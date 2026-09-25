# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [GRID-SQL] Campo 'cpros' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'dpros' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'reffs' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'usuaalts' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL

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
  ControlSource = "crSigCdPro.locals"
  ControlSource = "crSigCdPro.cunips"
  ControlSource = "crSigCdPro.situas"
  ControlSource = "crSigCdPro.obsetqs"
  ControlSource = "crSigCdPro.cClass"
  ControlSource = "crSigCdPro.UsuIncs"
  ControlSource = "crSigCdPro.IdeCPros"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigCdPro.CodFinP"
  ControlSource = "crSigCdPro.dsccompras"
  ControlSource = "crSigCdPro.obscompras"
  ControlSource = "crSigCdPro.DPro3s"
  ControlSource = "crSigCdPro.pesoms"
  ControlSource = "crSigCdPro.pesobs"
  ControlSource = "crSigCdPro.tamps"
  ControlSource = "crSigCdPro.tamls"
  ControlSource = "crSigCdPro.tamhs"
  ControlSource = "crSigCdPro.consigs"
  ControlSource = "crSigCdPro.fabrproprs"
  ControlSource = "crSigCdPro.CodTams"
  ControlSource = "crSigCdPro.CodCors"
  ControlSource = "crSigCdPro.codAcbs"
  ControlSource = "crSigCdPro.encoms"
  ControlSource = "crSigCdPro.DtSituas"
  ControlSource = "crSigCdPro.prodwebs"
  ControlSource = "crSigCdPro.Conjunts"
  ControlSource = "crSigCdPro.obsMkt"
  ControlSource = "crSigCdPro.AtivoSite"
  ControlSource = "crSigCdPro.ForaLinha"
  ControlSource = "crSigCdPro.ProdNovo"
  ControlSource = "crSigCdPro.SemConsulta"
  ControlSource = "crSigCdPro.Categoria"
  ControlSource = "crSigCdPro.mostruario"
  ControlSource = "crSigCdPro.ProdOff"
  ControlSource = "crSigCdPro.CodCtgSite"
  ControlSource = "crSigCdPro.CodDptSite"
  ControlSource = "crSigCdPro.SegMasc"
  ControlSource = "crSigCdPro.SegFem"
  ControlSource = "crSigCdPro.SegUni"
  ControlSource = "crSigCdPro.SegInf"
  ControlSource = "crSigCdPro.SegKids"
  ControlSource = "crSigCdPro.dpro4s"
  ControlSource = "crSigCdPro.espessus"
  ControlSource = "crSigCdPro.ObrTamSer"
  ControlSource = "crSigCdPro.CodMacro"
  ControlSource = "crSigCdPro.qmins"
  ControlSource = "crSigCdPro.DtLacto"
  ControlSource = "crSigCdPro.Lancamento"
  ControlSource = "crSigCdPro.FimDtLacto"
  ControlSource = "crSigCdPro.CnjLacto"
  ControlSource = "crSigCdPro.OrigemLac"
  ControlSource = "crSigCdPro.DispEnc"
  ControlSource = "crSigCdPro.BrcEsp"
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  ControlSource = "crSigCdPro.MarkupA"
  ControlSource = "crSigCdPro.montadescs"
  ControlSource = "crSigCdPro.digimaxs"
  ControlSource = "crSigCdPro.ordcompos"
  ControlSource = "crSigCdPro.compos"
  ControlSource = "crSigCdPro.casas"
  ControlSource = "crSigCdPro.pcuss"
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
  ControlSource = "crSigCdPro.PrecoDe"
  ControlSource = "crSigCdPro.CustoCP"
  ControlSource = "crSigCdPro.varPesoMs"
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
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
  ControlSource = "crSigCdPro.CodImpPro"
  ControlSource = "crSigCdPro.DCodImpPro"
  ControlSource = "crSigCdPro.codnacpro"
  ControlSource = "crSigCdPro.coddcr"
  ControlSource = "crSigCdPro.TpCodPro"
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
  ControlSource = "crSigCdPro.volumes"
  ControlSource = "crSigCdPro.tents"
  ControlSource = "crSigCdPro.DiasGar"
  ControlSource = "crSigCdPro.ltminsv"
  ControlSource = "crSigCdPro.UltComps"
  ControlSource = "crSigCdPro.vUltComps"
  ControlSource = "crSigCdPro.MUltComps"
  ControlSource = "crSigCdPro.prodvars"
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
  ControlSource = "crSigPrTar.ObsTars"
  DeleteMark = .F.
  ControlSource = "crSigCdPro.ObsInsp"
  DeleteMark = .F.
  ControlSource = "crSigCdPro.DesLacto"
  ControlSource = "crSigCdPro.CriaLacto"
  ControlSource = "crSigCdPro.DtAprAmo"
  DeleteMark = .F.
  Column2.ControlSource = ""
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
	lcQuery = [Select Distinct Matprincs From SigCdPro Where MatPrincs <> Space(14) and MatPrincs = ']+lcMat+[' ]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crMatPrinc') < 1)
	Select crMatPrinc
Select &cCompo.
Select crSigPrCpo
		lcQuery = [Select a.PesoMs, b.CfgGerGprs ] + ;
				    [From SigCdPro a, SigCdGrp b ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalProCp]) < 1)
		Select crSigPrCpo
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
lcQuery = [Select * ] + ;
		    [From SigPrFnc ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalFPro]) < 1)
			Select LocalFPro
			Select LocalFPro
			Select LocalFPro
			Select LocalFPro
		Select crSigPrCpo
Select crSigCdPro
lcQuery = [Select b.chkInstalas ] + ;
			[From SigCdPro a, SigCdGrp b ] + ;
If ThisForm.poDataMgr.SqlExecute(lcQuery,'LocalInstal') < 1
	SELECT crSigPrCpo
		lcSql = [Select a.*, b.rClis From SigPrFnc a Inner Join SigCdCli b on b.iClis = a.IFors Where cPros = ']+crSigPrCpo.mats+[']
		lcSql = [Select * ] + ;
				    [From SigPrFnc ] + ;
		thisform.Podatamgr.Sqlexecute(lcSql,'CrSigPrFnctmp')
		SELECT CrSigPrFnctmp
			SELECT crSigPrCpo
			SELECT CrSigPrFnctmp
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
	lcQuery = [Select Cods, ChkLibs ] + ;
				[From SigCdPst ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca]) < 1)
Select crSigCdPst
	lcQuery = [Select Campos ] + ;
				[From SigSyCpo ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCampo]) < 1)
			lcQuery = [Select Campos ] + ;
						[From SigSyCpo ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCampo]) < 1)
lcQuery = [Select nTipoJoals ] + ;
			[From SigCdGrp ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalRel]) < 1)
Select LocalRel
lcQuery = [Select * ] + ;
		    [From SigOpEtq ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEti') < 1)
	Update crSigCdPro Set ImpEtiqs = crTmp.ImpEtiqs Where CPros = ThisForm.Produto
	lcQuery = [Select Top 1 CPros, Datars ] + ;
				[From SigMvHst ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalHis') < 1)
	Select * From crSigPrCpo Into Cursor csTemCompo
		Select CrSigPrCpo
			Select LocalLinI
				lcSql = [Select CustoFs as pCompos, MoeCusfs as Moeds From SigCdPro Where Cpros = ']+LocalLini.Mats+[']
				ThisForm.PodataMgr.SqlExecute(lcSql,'TmpProL')
				Select TmpProl
				Insert Into crSigPrCpo From Memvar
Select &cCompo.
Select Distinct CGrus, Linguas, TpMontas ;
  From crSigCdPrd ;
Select LocalMontas
			Select crSigCdDic
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
	.Column1.ControlSource  = 'crSigPrCpo.Cgrus'
	.Column2.ControlSource  = 'crSigPrCpo.DscGrp'
	.Column3.ControlSource  = 'crSigPrCpo.Mats'
	.Column4.ControlSource  = 'crSigPrCpo.DCompos'
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
ThisForm.poDatamgr.SqlExecute([Select EstMins From SigCdPac],'csSigCdPac')
	Select crSigCdMin
	lcSql = [Select * From SigcdCpo Where grupos = ']+crSigCdPro.cgrus+[']
	ThisForm.Podatamgr.Sqlexecute(lcSql,'crSigCdCpo')
	SELECT crSigcdCpo
		lcQ = [SELECT * from crsigcdcpo where 1=1 ]+lcCheTp + lcCheVal + [ into cursor crCpo]
		SELECT crCpo
	SELECT crSigcdPro
	Select crSigCdGrp
	Select crSigCdGpr
Select crSigPrCpo
Select Mats, ObsCompos ;
  From crSigPrCpo ;
Select crMontaCPros
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
lcQuery = [Select resultado from SigPrSic where cIdChaves = ']+lcChave+[']
If( ThisForm.poDataMgr.SQLExecute(lcQuery,[crSigPrSic]) < 1 )
	lcQuery = [Insert into SigPrSic(cTipos,Mercs,Indicador,ValorCmp,Resultado,cIdChaves) Values ('] + ;
	ThisForm.poDataMgr.SQLExecute(lcQuery)
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
Select crSigCdPrf
Select crSigPrCpo
Update crSigPrCpo Set Etiqs = [N] Where Not Etiqs = [S]
Select crSigSubCp
Update crSigSubCp Set Etiqs = [N] Where Not Etiqs = [S]
Select crSigPrCpo
Select crListaPro
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
Select Cgrus as Grupo, Mats as CPros, dCompos as Dgrus, Moeds as Moeda, Pesos, Qtds, PCompos, 00000000.000 as ValGrupo, chkInstalas, OrdTs ;
  From crSigPrCpo ;
Update LocalTGrupo Set ValGrupo = Iif(chkInstalas=2, Pesos, Qtds) * PCompos
	lcSql = [Select * From SigPrFti Where Cods = ']+MarkCus+[']
	ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtio')
	Select TmpFtio
		lcSql = [Select a.*, IsNull(b.Dgrus,'') as Dgrus ] + ;
			[From SigPrFto a Left Join SigCdGrp b on a.Cgrus = b.Cgrus ] + ;
		ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtioC')
			Select LocalTGrupo
				Select TmpFtioC
					Select CsGrade
			Select CsGrade
		lcSql = [Select a.*, b.Dpros From SigPrFto a, SigCdPro b Where a.Cods = ']+MarkCus+[' And ]+;
		ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtioC')
		Select TmpFtioC
			Select CsGrade
	lcSql = [Select * From SigPrFti Where Cods = ']+MarkVen+[']
	ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtio')
	Select TmpFtio
		lcSql = [Select a.*, b.Dgrus, 0 as altcoef From SigPrFto a, SigCdGrp b Where a.Cods = ']+MarkVen+[' And ]+;
		ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtioC')
		SELECT crPrFtp
				SELECT TmpftioC
			Select LocalTGrupo
				Select TmpFtioC
					Select CsGrade
			Select CsGrade
		lcSql = [Select a.*, b.Dpros From SigPrFto a, SigCdPro b Where a.Cods = ']+MarkVen+[' And ]+;
		ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtioC')
		Select TmpFtioC
			Select CsGrade
		SELECT csGrade
lnOldSel = Select()
lcQuery = [Select Mercs from SigCdGrp where CGrus = ']+pcGrupo+[' ]
If (Thisform.poDataMgr.SqlExecute(lcQuery,'csTmpGGr') < 1)
Select csTmpGGr
lcQuery = [Select Deptos ] + ;
	[From SigCdUsu ] + ;
If (Thisform.poDataMgr.SqlExecute(lcQuery,'TmpUsuario') < 1)
Select TmpUsuario
	lcSql = [select Distinct codgrupo from sigdptgg Where coddepto = ']+TmpUsuario.Deptos+[' ]
	If (Thisform.poDataMgr.SqlExecute(lcSql,'csVlAceGru') < 1)
	Select csVlAceGru
		lcSql = [select a.*, b.descs ] + ;
			[from sigdptgg a ] + ;
			[join sigcdgpr b on a.codgrupo = b.codigos ] + ;
		If (Thisform.poDataMgr.SqlExecute(lcSql,'TmpAceGru') < 1)
		Select TmpAceGru
lnOldSel = Select()
lnOldSel = Select()
Select crSigPrCpo
	Select crSigPrCpo
Select(lnOldSel)
lcQuery = [Select Descs From SigCdCor Where Cods = '] + crSigCdPro.CodCors + [']
If (Thisform.poDataMgr.SqlExecute(lcQuery, [crAux]) < 1)
lcQuery = [Select cgrus, dgrus,mercs from SigCdGrp Where mercs = 'PED']
If (Thisform.poDataMgr.SqlExecute(lcQuery, [crPed]) < 1)
Select cgrus, Sum(qtds) As qtds From crsigprcpo Where cgrus Not In('P06','P37','P38') Group By cgrus Into Cursor crAux
Select crAux
	Select crPed
	Select crAux
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
	If Not ThisForm.poDataMgr.Update('crSigPrPre')
	If Not ThisForm.poDataMgr.Update('crSigSerPr')
Delete From crProcurar Where CPros = pPro
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
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigSerPr Where CPros = ?pPro], '') < 1)
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
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigSerPr Where CPros = ?pPro], '') < 1)
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
	If Not ThisForm.poDataMgr.Update('crSigPrPre')
	If Not ThisForm.poDataMgr.Update('crSigSerPr')
	Select crListaPro
	If Seek(lcChv, 'crProcurar', 'CPros')
		Select crProcurar
	Select crListaPro
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
lcQrySerPr = [select a.*, b.descs from sigserpr a join sigprser b on a.cods = b.cods where a.cpros = ?pPro]
		Select LocalGru
lcQuery = [Select g.Cgrus, g.Dgrus, p.Cpros, p.Dpros ] + ;
			[From SigCdGrp g ] + ;
			[Left Join SigCdPro p On p.Cgrus = g.Cgrus ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crRelogios]) < 1)
Select crRelogios
Delete From crRelogios Where IsEmpty(Cpros)
Delete From crRelogios Where IsEmpty(Dpros)
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
lStrQuery = [Select Distinct a.CPros, a.DPros, a.Locals, a.CGrus, a.MontaDescs, b.MtPrimas, Space(20) as Tipos, 1 as Custos, b.CfgGerGprs, a.Situas, a.CustoFs, a.moecusfs ] + ;
			  [From SigCdPro a, SigCdGrp b ] + ;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrMtPrimaC') < 1
Select * From CrMtPrimaC Where MtPrimas = 4 Into Cursor crMatrizes ReadWrite
Select crMatrizes
Select * From CrMtPrimaC Where MtPrimas In (1, 2) And Iif(Int(Val(Substr(CfgGerGprs, 38, 1))) = 1,Situas = 1,.t.) Into Cursor crMtPrima ReadWrite
Select CrMtPrima
lcQuery = [Select Distinct a.Conjunts From SigCdPro a Inner Join SigCdGrp b On a.CGrus = b.CGrus Where b.MtPrimas = 3 And a.Conjunts <> '' Order By a.Conjunts]
If ThisForm.poDataMgr.SqlExecute(lcQuery,'CrConjunto') < 1
Select crConjunto
lcQuery = [Select Distinct a.CodMacro From SigCdPro a Inner Join SigCdGrp b On a.CGrus = b.CGrus Where a.CodMacro <> '' Order By a.CodMacro]
If ThisForm.poDataMgr.SqlExecute(lcQuery,'CrCodMacro') < 1
Select crCodMacro
lcQuery = [Select Distinct a.CnjLacto From SigCdPro a Inner Join SigCdGrp b On a.CGrus = b.CGrus Where a.CnjLacto <> '' Order By a.CnjLacto]
If ThisForm.poDataMgr.SqlExecute(lcQuery,'CrCnjLacto') < 1
Select crCnjLacto
lStrQuery = [Select Tipos From SigCdCom]			  
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'LocalCdCom') < 1
	Select * From CrMtPrima Into Cursor CrMtPrimaT ReadWrite
	lStrQuery = [Select Distinct a.CPros, a.DPros, a.CGrus, a.MontaDescs, b.MtPrimas, c.Tipos, d.Custos, a.CustoFs, a.moecusfs ] + ;
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
	Select Distinct CGrus, Dgrus From crRelogios Into Cursor TmpRelos
	Select TmpRelos
		Select crSigPrCpo
			Insert Into crSigPrCpo (CGrus, DscGrp, CPros, Qtds, cIdChaves) ; 
lcQuery = [Select 0 as Marcas, * from SigPrSer ]
Thisform.poDatamgr.SqlExecute(lcQuery,[crSigPrSer])
	.column1.ControlSource = [crSigPrSer.Descs]
	.column2.ControlSource = [crSigPrSer.Cods]
	.column3.ControlSource = [crSigPrSer.Marcas]
Select crSigPrSer
Select crSigSerPr
	If Seek(crSigSerPr.Cods,[crSigPrSer],[Cods])
Select crSigSerPr
Select CrSigPrSer
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
		Select CrSigPrSer
		lcQuery = [Select CPros, Cunis, CuniPs ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro') < 1)
		lcQuery = [Select CPros, DPros ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro') < 1)
			lcQuery = [Select cgrus, codcors, colecoes, categoria from sigcdpro where conjunts = ']+crSigCdPro.Conjunts+[' and cpros <> ']+crSigCdPro.Cpros+[']
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpCnj') < 1)
			Select crTmpCnj
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
		Insert Into CrSigPrPre (Cpros, cIdChaves, PVens, PVensAnt, Moevs, MoevsAnt, Datas) Values ;
	Select crSigPrSer
		Select crSigSerPr
		Select crSigPrSer
	lcQuery = [Delete From SigPrPrt Where CPros = '] + CrSigCdPro.Cpros + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		lcQuery = [update sigprdvt set ckatudesc = null where codigo = 'NIM] + CrSigCdPro.Conjunts + [']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
				lcQuery = [Select Arquivos From SigPrArq Where Cpros = ']+crSigCdPro.Cpros+[']
				If ThisForm.poDataGrv.SqlExecute(lcQuery,'LocalArq') < 1
				lcQuery = [Select Cpros From SigCdPro Where Categoria = '] + crSigCdPro.Categoria + [' And Cpros <> ']+crSigCdPro.Cpros+[']
				If ThisForm.poDataGrv.SqlExecute(lcQuery,'LocalCat') < 1
				Select LocalCat
					lcQuery = [Update SigCdPro Set ObsInsp = ']+Nvl(crSigCdPro.ObsInsp,'')+[' Where Cpros = ']+LocalCat.Cpros+[']
					If ThisForm.poDataGrv.SqlExecute(lcQuery) < 1
					lcQuery = [Delete SigPrArq Where Cpros = ']+LocalCat.Cpros+[']
					If ThisForm.poDataGrv.SqlExecute(lcQuery) < 1
					Select LocalArq
						lcQuery = [Insert Into SigPrArq(Arquivos,Cpros,PkChaves) Values(']+LocalArq.Arquivos+[',']+LocalCat.Cpros+[',']+fUniqueIds()+[')]
						If ThisForm.poDataGrv.SqlExecute(lcQuery) < 1
						Select LocalArq
					Select LocalCat	
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
		Select crSigPrTam
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
		lStrQuery = [Select Distinct a.CPros, a.DPros, a.CGrus, a.MontaDescs, b.MtPrimas, b.CfgGerGprs, a.Situas, a.CustoFs, a.moecusfs ] + ;
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
lStrQuery = [Select CGrus, Mercs, CodProds, IdeCPros, CfgGerGprs From SigCdGrp Where CGrus = '] + this.Parent.getNewCGrus.Value + [']
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpGruPro') < 1
Select TmpGruPro
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
SELECT *, pkchaves as cidChaves from crSigPrFtp where cpros = pPro1 into cursor crPrFtp READWRITE
lStrQuery = [Select CGrus,CodProds,IdeCPros,Mercs From SigCdGrp Where CGrus = ']+lcCGrus+[' ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpGruPro') < 1
Select TmpGruPro
Select crListaPro
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
			Delete File (lcFigura)
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
	lcSql = [Select cEstos From SigCdUni Where cunis = ']+CrSigCdPro.cUnis+[']
	ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
	Select * ;
	  From crSigCdCls ;
	Select LocalClas
	Select LocalClas
		lcQuery = [Select a.CPros ] + ;
					[From SigCdMin a ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca]) < 1)
		lcQuery = [Select a.CPros ] + ;
					[From SigCdMax a ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca]) < 1)
	Select crConjunto
	If !Seek(lcConjunto,[crConjunto],[Conjunts])
Select crSigCdPro
		Select crSigCdPro
			Delete File (lcFigura)
	Select crSigPrCar
	lcQuery = [Select Descs From SigCdCor Where Cods = '] + crSigCdPro.CodCors + [']
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [crAux]) < 1)
		Select cgrus, Sum(qtds) As qtds, Sum(pesos*100) As pesos From crSigPrCpo Where cgrus In ('P06','P37','P38') group by cgrus Into Cursor crAux
		Select crAux
			Select crAux
		Select Sum(qtds) As qtds, Sum(pesos*100) As pesos From crsigprcpo Where cgrus In ('P06','P37','P38') Into Cursor crAux
	lcQuery = [Select cgrus, dgrus,mercs from SigCdGrp Where mercs = 'PED']
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [crPed]) < 1)
	Select cgrus, Sum(qtds) As qtds From crsigprcpo Where cgrus Not In('P06','P37','P38') Group By cgrus Into Cursor crAux
	Select crAux
		Select crPed
		Select crAux
	lcQuery = [Select Descs From SigCdCor Where Cods = '] + crSigCdPro.CodCors + [']
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [crAux]) < 1)
		Select cgrus, Sum(qtds) As qtds, Sum(pesos*100) As pesos From crsigprcpo Where cgrus In('P06','P37','P38') group by cgrus Into Cursor crAux
		Select crAux
			Select crAux
		Select Sum(qtds) As qtds, Sum(pesos*100) As pesos From crsigprcpo Where cgrus In('P06','P37','P38') Into Cursor crAux
	lcQuery = [Select cgrus, dgrus,mercs from SigCdGrp Where mercs = 'PED']
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [crPed]) < 1)
	Select cgrus, Sum(qtds) As qtds From crsigprcpo Where cgrus Not In('P06','P37','P38') Group By cgrus Into Cursor crAux
	Select crAux
		Select crPed
		Select crAux
		Select dcompos From crsigprcpo Where cgrus = 'RGN' Into Cursor crAux
		Select dcompos From crsigprcpo Where cgrus = 'RMP' Into Cursor crAux
		Select dcompos From crsigprcpo Where cgrus = 'RCP' Into Cursor crAux
		lcQuery = [Select Cgrus, Dgrus from SigCdGrp Where Cgrus = ']+crSigCdPro.cgrus+[']
		If (Thisform.poDataMgr.SqlExecute(lcQuery, [crGrp]) < 1)
		Select dcompos From crsigprcpo Where cgrus = 'RGN' Into Cursor crAux
		Select dcompos From crsigprcpo Where cgrus = 'RFC' Into Cursor crAux
		Select dcompos From crsigprcpo Where cgrus = 'RCC' Into Cursor crAux
		Select dcompos From crsigprcpo Where cgrus = 'RCP' Into Cursor crAux
		Select dcompos From crsigprcpo Where cgrus = 'RCM' Into Cursor crAux
		Select dcompos From crsigprcpo Where cgrus = 'RTM' Into Cursor crAux
lcQuery = [Select cgrus, dgrus,mercs from SigCdGrp Where mercs = 'PED' ]
If (Thisform.poDataMgr.SqlExecute(lcQuery, [crPed]) < 1)
Select cgrus, Sum(pesos) As pesos From crsigprcpo Where cgrus Not In('P06','P37','P38') Group By cgrus Into Cursor crAux
Select crAux
	Select crPed
	Select crAux
Select crSigCdPro
Select crSigCdPro
	Select crCodMacro
	If !Seek(lcCodMacro,[crCodMacro],[CodMacro])
	.Column1.ControlSource  = 'crSigCdMin.Emps'
	.Column2.ControlSource  = 'crSigCdMin.QMins'
	Select crCnjLacto
	If !Seek(lcConjunto,[crCnjLacto],[CnjLacto])
lnOldSel = Select()
Select(lnOldSel)
		Select &lcArq.
		Select crSigCdPro
			If Not Seek(Padr(This.Value, 14), lcArq, [CPros])			
				If Not Seek(Padr(This.Value, 14), lcArq, [CPros])
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
			If Not Seek(Padr(This.Value, 40), lcArq, [DPros])
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
	lcQuery = [Select b.pCustVens ] + ;
			    [From SigCdPro a, SigCdGrp b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
	Select crSigPrCpo	
	Select crSigPrCpo
	lcQuery = [Select b.pCustVens,b.Fators,qtequalps, a.PesoMs, a.cGrus ] + ;
			    [From SigCdPro a, SigCdUni b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
	Select crSigPrCpo
	Select crSigPrCpo	
	Select crSigPrCpo
	lcSql = [Select cEstos From SigCdUni Where cunis = ']+CrSigPrCpo.cUniPs+[']
	ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
	lcQuery = [Select b.pCustVens,b.Fators, a.PesoMs, a.cGrus ] + ;
			    [From SigCdPro a, SigCdUni b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
	Select crSigPrCpo
	Select crMatrizes
	If Not Seek(Padr(This.Value, 14), [crMatrizes], [CPros])
	Select crSigPrCpo
		Insert Into crSigPrCpo (Cpros, DtMovs, cIdChaves, TpCalcCus, OrdTs) Values (crSigCdPro.Cpros, DateTime(), fUniqueIds(), 1, 1)
	Select crSigPrCpo
		Delete
Select crSigPrCpo
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
	Select * From crRelogios Where CGrus = lcGrp Into Cursor TmpRel1s Readwrite
	Select TmpRel1s
	If Not Seek(This.Value,'TmpRel1s','CPros')
	Select * From crRelogios Where CGrus = lcGrp Into Cursor TmpRel1s Readwrite
	Select TmpRel1s
	If Not Seek(This.Value,'TmpRel1s','DPros')
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
		Insert Into crSigPrCpo (Cpros, DtMovs, cIdChaves, Tipos, OrdTs) Values (crSigCdPro.Cpros, DateTime(), fUniqueIds(), lcTip, 1)
	Select crSigPrCpo
		Delete
Select crSigPrTar
Select crSigPrTar
Insert Into crSigPrTar (CPros, pkChaves, DtInis, Usuars) ;
	Insert Into crSigPrArq (CPros, pkChaves, Arquivos) Values (crSigCdPro.CPros, fUniqueIds(), Upper(lcArq))
	Delete In crSigPrArq
	Select crTarefas
lcFiltro = [ Not cAtivos='N' and deptos in(select codigos from sigcddpt where UtiLacto = 1) ]
lcFiltro = [ Not cAtivos='N' and deptos in(select codigos from sigcddpt where UtiLacto = 1) ]

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (8398 linhas total):

*-- Linhas 536 a 554:
536:             .HighlightBackColor = RGB(255, 255, 255)
537:             .HighlightForeColor = RGB(15, 41, 104)
538:             .HighlightStyle     = 2
539:             .DeleteMark         = .F.
540:             .RecordMark         = .F.
541:             .RowHeight          = 16
542:             .ScrollBars         = 2
543:             .GridLines          = 3
544:             .ReadOnly           = .T.
545:             .AllowHeaderSizing  = .F.
546:             .AllowRowSizing     = .F.
547:             .Visible            = .T.
548:         ENDWITH
549: 
550:         *-- Coluna 7 (checkbox "I" = Inativo): AddObject + CurrentControl
551:         *-- obrigatorios para o controle aparecer (regra #18 do CLAUDE.md).
552:         loc_oPagina.grd_4c_Dados.Column7.AddObject("chk_4c_Inativo", "CheckBox")
553:         WITH loc_oPagina.grd_4c_Dados.Column7
554:             .CurrentControl = "chk_4c_Inativo"

*-- Linhas 605 a 650:
605:                 IF !THIS.this_oBusinessObject.BuscarLista(loc_cGrupo, loc_dDtIni, loc_dDtFim, loc_nSituacao)
606:                     loc_lResultado = .F.
607:                 ELSE
608:                     *-- Bind, larguras e headers ficam em VincularGradeLista
609:                     *-- (o mesmo bloco eh usado pela busca por exemplo, que
610:                     *-- popula cursor_4c_Dados por outro caminho).
611:                     THIS.VincularGradeLista()
612: 
613:                     loc_lResultado = .T.
614:                 ENDIF
615:             ENDIF
616: 
617:         CATCH TO loException
618:             MostrarErro("Erro ao carregar lista de produtos:" + CHR(13) + ;
619:                 loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
620:                 "FormProduto.CarregarLista")
621:             loc_lResultado = .F.
622:         ENDTRY
623: 
624:         RETURN loc_lResultado
625:     ENDPROC
626: 
627:     *===========================================================================
628:     * AtualizarContadorProdutos - Atualiza o rotulo "Produtos Selecionados"
629:     *===========================================================================
630:     PROTECTED PROCEDURE AtualizarContadorProdutos()
631:         LOCAL loc_nTotal
632:         loc_nTotal = 0
633: 
634:         IF USED("cursor_4c_Dados")
635:             loc_nTotal = RECCOUNT("cursor_4c_Dados")
636:         ENDIF
637: 
638:         THIS.pgf_4c_Paginas.Page1.lbl_4c_Produtos.Caption = ;
639:             "Produtos Selecionados : " + TRANSFORM(loc_nTotal)
640:     ENDPROC
641: 
642:     *===========================================================================
643:     * GridDadosAfterRowColChange - Handler de BINDEVENT (regra #38 - precisa
644:     * declarar o parametro do evento, senao "No PARAMETER statement is found")
645:     *===========================================================================
646:     PROCEDURE GridDadosAfterRowColChange(par_nColIndex)
647:         THIS.AtualizarContadorProdutos()
648:     ENDPROC
649: 
650:     *===========================================================================

*-- Linhas 690 a 708:
690:                 ENDIF
691: 
692:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpFiltro")
693:                     SELECT cursor_4c_BuscaGrpFiltro
694:                     loc_oFiltros.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_BuscaGrpFiltro.cgrus)
695:                     loc_oFiltros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_BuscaGrpFiltro.dgrus)
696:                     THIS.this_cUltimoGrupoValidado = PADR(ALLTRIM(cursor_4c_BuscaGrpFiltro.cgrus), 3)
697:                 ELSE
698:                     loc_oFiltros.txt_4c_Cgru.Value = ""
699:                     loc_oFiltros.txt_4c_Dgru.Value = ""
700:                     THIS.this_cUltimoGrupoValidado = ""
701:                 ENDIF
702: 
703:                 loc_oBusca.Release()
704:             ENDIF
705: 
706:             IF USED("cursor_4c_BuscaGrpFiltro")
707:                 USE IN cursor_4c_BuscaGrpFiltro
708:             ENDIF

*-- Linhas 741 a 759:
741:                 ENDIF
742: 
743:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpFiltro")
744:                     SELECT cursor_4c_BuscaGrpFiltro
745:                     loc_oFiltros.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_BuscaGrpFiltro.cgrus)
746:                     loc_oFiltros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_BuscaGrpFiltro.dgrus)
747:                     THIS.this_cUltimoGrupoValidado = PADR(ALLTRIM(cursor_4c_BuscaGrpFiltro.cgrus), 3)
748:                 ELSE
749:                     loc_oFiltros.txt_4c_Dgru.Value = ""
750:                 ENDIF
751: 
752:                 loc_oBusca.Release()
753:             ENDIF
754: 
755:             IF USED("cursor_4c_BuscaGrpFiltro")
756:                 USE IN cursor_4c_BuscaGrpFiltro
757:             ENDIF
758: 
759:         CATCH TO loException

*-- Linhas 825 a 874:
825:     *===========================================================================
826:     PROCEDURE BtnVisualizarClick()
827:         LOCAL loc_cCodigo
828:         loc_cCodigo = ""
829: 
830:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
831:             SELECT cursor_4c_Dados
832:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
833:         ENDIF
834: 
835:         IF EMPTY(loc_cCodigo)
836:             MsgAviso("Selecione um produto para visualizar.")
837:         ELSE
838:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
839:                 THIS.this_cModoAtual = "VISUALIZAR"
840:                 THIS.BOParaForm()
841:                 THIS.HabilitarCampos(.F.)
842:                 THIS.AjustarBotoesPorModo()
843:                 THIS.AlternarPagina(2)
844:                 THIS.IrParaDivisao(1)
845:             ENDIF
846:         ENDIF
847:     ENDPROC
848: 
849:     *===========================================================================
850:     * BtnAlterarClick - Abre o produto selecionado na grade em modo alteracao
851:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
852:     *===========================================================================
853:     PROCEDURE BtnAlterarClick()
854:         LOCAL loc_cCodigo
855:         loc_cCodigo = ""
856: 
857:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
858:             SELECT cursor_4c_Dados
859:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
860:         ENDIF
861: 
862:         IF EMPTY(loc_cCodigo)
863:             MsgAviso("Selecione um produto para alterar.")
864:         ELSE
865:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
866:                 THIS.this_oBusinessObject.EditarRegistro()
867:                 THIS.this_cModoAtual = "ALTERAR"
868:                 THIS.BOParaForm()
869:                 THIS.HabilitarCampos(.T.)
870:                 THIS.AjustarBotoesPorModo()
871:                 THIS.AlternarPagina(2)
872:                 THIS.IrParaDivisao(1)
873:             ENDIF
874:         ENDIF

*-- Linhas 880 a 902:
880:     *===========================================================================
881:     PROCEDURE BtnExcluirClick()
882:         LOCAL loc_cCodigo
883:         loc_cCodigo = ""
884: 
885:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
886:             SELECT cursor_4c_Dados
887:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
888:         ENDIF
889: 
890:         IF EMPTY(loc_cCodigo)
891:             MsgAviso("Selecione um produto para excluir.")
892:         ELSE
893:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
894:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto [" + ;
895:                         loc_cCodigo + "]?", "Confirmar Exclus" + CHR(227) + "o")
896:                     IF THIS.this_oBusinessObject.Excluir()
897:                         MsgInfo("Produto exclu" + CHR(237) + "do com sucesso!")
898:                         THIS.CarregarLista()
899:                     ENDIF
900:                 ENDIF
901:             ENDIF
902:         ENDIF

*-- Linhas 2385 a 2404:
2385:     *
2386:     * FASE 9 - so a camada VISUAL (controles + lookups de codigo isolado).
2387:     * As grades de dados (grd_4c_Compo/SubCp/GradeGrupo/Relogios) ficam SEM
2388:     * RecordSource/ControlSource nesta fase (regra #41 do CLAUDE.md: ligar
2389:     * Column.ControlSource antes do cursor existir derruba o Init) e os
2390:     * botoes cmdgCompo/cmdgSubCp/cmdCalcVals ficam SEM Click - a logica de
2391:     * negocio (FiltrarCompo, CalcPreco, AtuaPreco, CalcFornec, TotalGrupo)
2392:     * e as 4 grades legadas de composicao entram em fase propria.
2393:     *
2394:     * DESVIO DE NOME (mapeamento.json): o gerador colidiu "grd_4c_Dados" nas
2395:     * QUATRO grades desta mesma pagina (grdCompo/GradeGRUPO/grdsubcp/
2396:     * grdRelogios sao todas filhas diretas de pgComposicao) - AddObject
2397:     * duplicado no mesmo container. Renomeado para grd_4c_Compo/GradeGrupo/
2398:     * SubCp/Relogios; mapeamento.json atualizado para registrar a correcao.
2399:     *===========================================================================
2400:     PROTECTED PROCEDURE ConfigurarPgpgComposicao()
2401:         LOCAL par_oPagina
2402:         par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
2403: 
2404:         *-- Grade principal de componentes (grdCompo legado, 14 colunas)

*-- Linhas 2417 a 2435:
2417:             .HighlightBackColor = RGB(255, 255, 255)
2418:             .HighlightForeColor = RGB(15, 41, 104)
2419:             .HighlightStyle     = 2
2420:             .DeleteMark         = .F.
2421:             .RecordMark         = .F.
2422:             .RowHeight          = 16
2423:             .ScrollBars         = 2
2424:             .GridLines          = 3
2425:             .ReadOnly           = .F.
2426:             .Visible            = .T.
2427: 
2428:             .Column1.Width  = 85
2429:             .Column1.Header1.Caption = "Material"
2430:             .Column2.Width  = 224
2431:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2432:             .Column3.Width  = 30
2433:             .Column3.Header1.Caption = "Un"
2434:             .Column4.Width  = 65
2435:             .Column4.Header1.Caption = "Valor"

*-- Linhas 3474 a 3492:
3474:             .HighlightBackColor = RGB(255, 255, 255)
3475:             .HighlightForeColor = RGB(15, 41, 104)
3476:             .HighlightStyle     = 2
3477:             .DeleteMark         = .F.
3478:             .RecordMark         = .F.
3479:             .RowHeight          = 16
3480:             .ScrollBars         = 0
3481:             .GridLines          = 3
3482:             .ReadOnly           = .T.
3483:             .Visible            = .T.
3484: 
3485:             .Column1.Width = 60
3486:             .Column1.Header1.Caption = "Grupo"
3487:             .Column2.Width = 95
3488:             .Column2.Header1.Caption = "Total"
3489:             .Column3.Width = 60
3490:             .Column3.Header1.Caption = "Moeda"
3491:         ENDWITH
3492: 

*-- Linhas 3506 a 3524:
3506:             .HighlightBackColor = RGB(255, 255, 255)
3507:             .HighlightForeColor = RGB(15, 41, 104)
3508:             .HighlightStyle     = 2
3509:             .DeleteMark         = .F.
3510:             .RecordMark         = .F.
3511:             .RowHeight          = 16
3512:             .ScrollBars         = 2
3513:             .GridLines          = 3
3514:             .ReadOnly           = .F.
3515:             .Visible            = .T.
3516: 
3517:             .Column1.Width  = 78
3518:             .Column1.Header1.Caption = "Material"
3519:             .Column2.Width  = 248
3520:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3521:             .Column3.Width  = 28
3522:             .Column3.Header1.Caption = "Un"
3523:             .Column4.Width  = 60
3524:             .Column4.Header1.Caption = "Valor"

*-- Linhas 3656 a 3674:
3656:             .HighlightBackColor = RGB(255, 255, 255)
3657:             .HighlightForeColor = RGB(15, 41, 104)
3658:             .HighlightStyle     = 2
3659:             .DeleteMark         = .F.
3660:             .RecordMark         = .F.
3661:             .RowHeight          = 16
3662:             .ScrollBars         = 2
3663:             .GridLines          = 3
3664:             .ReadOnly           = .T.
3665:             .Visible            = .F.
3666: 
3667:             .Column1.Width = 60
3668:             .Column1.Header1.Caption = "Grp"
3669:             .Column2.Width = 350
3670:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3671:             .Column3.Width = 150
3672:             .Column3.Header1.Caption = "Produto"
3673:             .Column4.Width = 383
3674:             .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

*-- Linhas 3685 a 3703:
3685:     * FASE 10 - so a camada VISUAL. pgCusto eh uma visao ALTERNATIVA da mesma
3686:     * grade de composicao (crSigPrCpo) ja tratada em ConfigurarPgpgComposicao,
3687:     * agrupada por Tipo (cmbTipos). Por isso:
3688:     *   - grd_4c_Compo fica SEM RecordSource/ControlSource (regra #41 do
3689:     *     CLAUDE.md: ligar antes do cursor existir derruba o Init);
3690:     *   - obj_4c_CmdgCompo (Inserir/Excluir) fica SEM Click - mesma logica de
3691:     *     negocio (FiltrarCompo) ja fora de escopo na pagina irma;
3692:     *   - cmbTipos.Valid dispara FiltrarCompo(2) no legado - fora de escopo;
3693:     *   - grdCompo.Procedure (AfterRowColChange) atualiza getDGruCompos via
3694:     *     SQL na linha selecionada - depende de cursor populado, fora de
3695:     *     escopo por ser reacao a dado, nao layout.
3696:     *
3697:     * Coluna 9 ("Etiq"): mesma cursor/tabela (crSigPrCpo) e mesma posicao
3698:     * relativa da coluna "E" (chk_4c_Etiqueta) ja criada em
3699:     * ConfigurarPgpgComposicao - reproduzida aqui como checkbox pela regra
3700:     * #18 (AddObject + CurrentControl + Sparse = .F.).
3701:     *
3702:     * grd_4c_Compo/grd_4c_GradeGrupo2 (DESVIO DE NOME, mapeamento.json): o
3703:     * gerador colidiu "grd_4c_Dados" nas DUAS grades desta pagina (ambas

*-- Linhas 3724 a 3742:
3724:             .HighlightBackColor = RGB(255, 255, 255)
3725:             .HighlightForeColor = RGB(15, 41, 104)
3726:             .HighlightStyle     = 2
3727:             .DeleteMark         = .F.
3728:             .RecordMark         = .F.
3729:             .RowHeight          = 16
3730:             .ScrollBars         = 2
3731:             .GridLines          = 3
3732:             .ReadOnly           = .F.
3733:             .Visible            = .T.
3734: 
3735:             .Column1.Width  = 45
3736:             .Column1.Header1.Caption = "Item"
3737:             .Column2.Width  = 215
3738:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3739:             .Column3.Width  = 32
3740:             .Column3.Header1.Caption = "Un"
3741:             .Column4.Width  = 68
3742:             .Column4.Header1.Caption = "Valor"

*-- Linhas 3921 a 3939:
3921:             .HighlightBackColor = RGB(255, 255, 255)
3922:             .HighlightForeColor = RGB(15, 41, 104)
3923:             .HighlightStyle     = 2
3924:             .DeleteMark         = .F.
3925:             .RecordMark         = .F.
3926:             .RowHeight          = 16
3927:             .ScrollBars         = 0
3928:             .GridLines          = 3
3929:             .ReadOnly           = .T.
3930:             .Visible            = .T.
3931: 
3932:             .Column1.Width = 55
3933:             .Column1.Header1.Caption = "Grp"
3934:             .Column2.Width = 100
3935:             .Column2.Header1.Caption = "Total"
3936:             .Column3.Width = 38
3937:             .Column3.Header1.Caption = "Moe"
3938:         ENDWITH
3939: 

*-- Linhas 3946 a 3970:
3946:     * FASE 12 - camada VISUAL completa (70 objetos do layout.json/dump).
3947:     * GradFase (5 colunas) e grdMatrizes (3 colunas) espelham os cursores
3948:     * crSigCdPrf/crSigPrMtz do legado - NAO existem nesta fase (regra #41 do
3949:     * CLAUDE.md: ligar Column.ControlSource antes do cursor existir derruba o
3950:     * Init), por isso ficam SEM RecordSource/ControlSource, e os botoes
3951:     * inserir/excluir/Alternativa/CmdFicha/btnInsereMtx/btnExcluiMtz (que
3952:     * operam sobre essas grades) ficam SEM Click - mesmo padrao de deferimento
3953:     * usado em ConfigurarPgpgComposicao/ConfigurarPgpgCusto/ConfigurarPgPgDadosConsP.
3954:     * Get_Desc/Get_Obs (ControlSource crSigCdGcr.descrs / crSigCdPrf.Obs) pela
3955:     * mesma razao ficam sem ControlSource.
3956:     *
3957:     * Os QUATRO campos de codigo isolado (Acabamento/Cor/Tamanho/Conquilha)
3958:     * SAO lookups simples contra tabela mestre (sem dependencia de cursor de
3959:     * grade) e por isso recebem BINDEVENT + ExecutarLookupGenerico, igual aos
3960:     * demais campos de codigo isolado da aba "Dados Principais".
3961:     *===========================================================================
3962:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP()
3963:         LOCAL par_oPagina
3964:         par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
3965: 
3966:         *-- Imagem do processo/fase (shpFig / ImgFigJpg - espelha crSigCdPrf.FigProcs)
3967:         par_oPagina.AddObject("shp_4c_ShpFig", "Shape")
3968:         WITH par_oPagina.shp_4c_ShpFig
3969:             .Top     = 129
3970:             .Left    = 231

*-- Linhas 4235 a 4253:
4235:         ENDWITH
4236:         BINDEVENT(par_oPagina.txt_4c_Cor, "KeyPress", THIS, "ValidarCorPadraoDados")
4237: 
4238:         *-- Peso Variavel (fwoption1 legado - checkbox, ControlSource Varias)
4239:         par_oPagina.AddObject("chk_4c_Fwoption1", "CheckBox")
4240:         WITH par_oPagina.chk_4c_Fwoption1
4241:             .Caption   = "Peso Vari" + CHR(225) + "vel"
4242:             .Top       = 308
4243:             .Left      = 180
4244:             .Width     = 90
4245:             .Height    = 15
4246:             .Value     = 0
4247:             .Alignment = 0
4248:             .BackStyle = 0
4249:             .ForeColor = RGB(90, 90, 90)
4250:             .FontName  = "Tahoma"
4251:             .FontSize  = 8
4252:             .Visible   = .T.
4253:         ENDWITH

*-- Linhas 4320 a 4338:
4320:         ENDWITH
4321:         BINDEVENT(par_oPagina.txt_4c_DescAcb, "KeyPress", THIS, "ValidarAcabamentoDadosPorDescricao")
4322: 
4323:         *-- Cravacao em Cera (opc_CravCera legado - checkbox, ControlSource CravCers)
4324:         par_oPagina.AddObject("chk_4c_OpcCravCera", "CheckBox")
4325:         WITH par_oPagina.chk_4c_OpcCravCera
4326:             .Caption   = "Crava" + CHR(231) + CHR(227) + "o em Cera"
4327:             .Top       = 283
4328:             .Left      = 180
4329:             .Width     = 100
4330:             .Height    = 15
4331:             .Value     = 0
4332:             .Alignment = 0
4333:             .BackStyle = 0
4334:             .ForeColor = RGB(90, 90, 90)
4335:             .FontName  = "Tahoma"
4336:             .FontSize  = 8
4337:             .Visible   = .T.
4338:         ENDWITH

*-- Linhas 4530 a 4548:
4530:             .Visible   = .T.
4531:         ENDWITH
4532: 
4533:         *-- Variacao (Say36/Fwoption2 - OptionGroup Sim/Nao, ControlSource prodvars)
4534:         par_oPagina.AddObject("lbl_4c_Label36", "Label")
4535:         WITH par_oPagina.lbl_4c_Label36
4536:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o :"
4537:             .Top       = 481
4538:             .Left      = 84
4539:             .Width     = 50
4540:             .Height    = 15
4541:             .BackStyle = 0
4542:             .ForeColor = RGB(90, 90, 90)
4543:             .FontName  = "Tahoma"
4544:             .FontSize  = 8
4545:             .Visible   = .T.
4546:         ENDWITH
4547: 
4548:         par_oPagina.AddObject("obj_4c_Fwoption2", "OptionGroup")

*-- Linhas 4579 a 4597:
4579:         ENDWITH
4580: 
4581:         *-- Descricao do grupo/fase selecionada (Get_Desc - espelha
4582:         *-- crSigCdGcr.descrs; sem ControlSource nesta fase - regra #41)
4583:         par_oPagina.AddObject("lbl_4c_Label1", "Label")
4584:         WITH par_oPagina.lbl_4c_Label1
4585:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
4586:             .Top       = 508
4587:             .Left      = 527
4588:             .Width     = 67
4589:             .Height    = 17
4590:             .BackStyle = 0
4591:             .ForeColor = RGB(90, 90, 90)
4592:             .FontName  = "Tahoma"
4593:             .FontSize  = 8
4594:             .Visible   = .T.
4595:         ENDWITH
4596: 
4597:         par_oPagina.AddObject("txt_4c_Desc", "TextBox")

*-- Linhas 4606 a 4640:
4606:         ENDWITH
4607: 
4608:         *-- Grade de Fases do Processo (GradFase legado, 5 colunas) - espelha
4609:         *-- crSigCdPrf; SEM RecordSource/ControlSource nesta fase (regra #41)
4610:         par_oPagina.AddObject("grd_4c_Dados", "Grid")
4611:         par_oPagina.grd_4c_Dados.ColumnCount = 5
4612:         WITH par_oPagina.grd_4c_Dados
4613:             .Top                = 129
4614:             .Left               = 527
4615:             .Width              = 420
4616:             .Height             = 168
4617:             .FontName           = "Verdana"
4618:             .FontSize           = 8
4619:             .ForeColor          = RGB(90, 90, 90)
4620:             .BackColor          = RGB(255, 255, 255)
4621:             .GridLineColor      = RGB(238, 238, 238)
4622:             .HighlightBackColor = RGB(255, 255, 255)
4623:             .HighlightForeColor = RGB(15, 41, 104)
4624:             .HighlightStyle     = 2
4625:             .DeleteMark         = .F.
4626:             .RecordMark         = .F.
4627:             .RowHeight          = 17
4628:             .ScrollBars         = 2
4629:             .GridLines          = 3
4630:             .ReadOnly           = .F.
4631:             .Visible            = .T.
4632: 
4633:             .Column1.Width           = 45
4634:             .Column1.Header1.Caption = "Ordem"
4635:             .Column2.Width           = 80
4636:             .Column2.Header1.Caption = "Fase"
4637:             .Column3.Width           = 70
4638:             .Column3.Movable         = .F.
4639:             .Column3.Resizable       = .F.
4640:             .Column3.InputMask       = "99,999.9"

*-- Linhas 4695 a 4743:
4695:         ENDWITH
4696: 
4697:         *-- Observacao da Fase (Get_Obs - espelha crSigCdPrf.Obs; sem
4698:         *-- ControlSource nesta fase - regra #41)
4699:         par_oPagina.AddObject("obj_4c_GetObs", "EditBox")
4700:         WITH par_oPagina.obj_4c_GetObs
4701:             .Top     = 531
4702:             .Left    = 527
4703:             .Width   = 463
4704:             .Height  = 92
4705:             .FontName = "Tahoma"
4706:             .FontSize = 8
4707:             .Visible = .T.
4708:         ENDWITH
4709: 
4710:         *-- Grade de Matrizes (grdMatrizes legado, 3 colunas) - espelha
4711:         *-- crSigPrMtz; SEM RecordSource/ControlSource nesta fase (regra #41).
4712:         *-- ColumnOrder replicado do dump: pos1=Matriz, pos2=Qtde, pos3=Local.
4713:         par_oPagina.AddObject("grd_4c_Matrizes", "Grid")
4714:         par_oPagina.grd_4c_Matrizes.ColumnCount = 3
4715:         WITH par_oPagina.grd_4c_Matrizes
4716:             .Top                = 305
4717:             .Left               = 527
4718:             .Width              = 245
4719:             .Height             = 192
4720:             .FontName           = "Verdana"
4721:             .FontSize           = 8
4722:             .ForeColor          = RGB(90, 90, 90)
4723:             .BackColor          = RGB(255, 255, 255)
4724:             .GridLineColor      = RGB(238, 238, 238)
4725:             .HighlightBackColor = RGB(255, 255, 255)
4726:             .HighlightForeColor = RGB(15, 41, 104)
4727:             .HighlightStyle     = 2
4728:             .DeleteMark         = .F.
4729:             .RecordMark         = .F.
4730:             .RowHeight          = 17
4731:             .ScrollBars         = 2
4732:             .GridLines          = 3
4733:             .ReadOnly           = .F.
4734:             .Visible            = .T.
4735: 
4736:             .Column1.Width           = 108
4737:             .Column1.Header1.Caption = "Matriz"
4738:             .Column2.Width           = 80
4739:             .Column2.ColumnOrder     = 3
4740:             .Column2.Movable         = .F.
4741:             .Column2.Resizable       = .F.
4742:             .Column2.Header1.Caption = "Local"
4743:             .Column3.Width           = 34

*-- Linhas 4889 a 4907:
4889:             .HighlightStyle     = 2
4890:             .AllowHeaderSizing  = .F.
4891:             .AllowRowSizing     = .T.
4892:             .DeleteMark         = .F.
4893:             .RecordMark         = .F.
4894:             .RowHeight          = 17
4895:             .ScrollBars         = 2
4896:             .GridLines          = 3
4897:             .ReadOnly           = .F.
4898:             .Visible            = .T.
4899: 
4900:             .Column1.ColumnOrder     = 1
4901:             .Column1.Width           = 108
4902:             .Column1.ReadOnly        = .T.
4903:             .Column1.Header1.Caption = "Componente"
4904: 
4905:             .Column9.ColumnOrder     = 2
4906:             .Column9.Width           = 223
4907:             .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

*-- Linhas 4971 a 4989:
4971:             .HighlightBackColor = RGB(255, 255, 255)
4972:             .HighlightForeColor = RGB(15, 41, 104)
4973:             .HighlightStyle     = 2
4974:             .DeleteMark         = .F.
4975:             .RecordMark         = .T.
4976:             .RowHeight          = 17
4977:             .ScrollBars         = 0
4978:             .GridLines          = 3
4979:             .ReadOnly           = .T.
4980:             .Visible            = .T.
4981: 
4982:             .Column1.Width = 80
4983:             .Column1.Header1.Caption = "Agrupamento"
4984:             .Column2.Width = 60
4985:             .Column2.Header1.Caption = "Tempo %"
4986:         ENDWITH
4987: 
4988:         THIS.TornarControlesVisiveis(par_oPagina)
4989:     ENDPROC

*-- Linhas 5584 a 5602:
5584:             .HighlightBackColor = RGB(255, 255, 255)
5585:             .HighlightForeColor = RGB(15, 41, 104)
5586:             .HighlightStyle     = 2
5587:             .DeleteMark         = .F.
5588:             .RecordMark         = .F.
5589:             .RowHeight          = 16
5590:             .ScrollBars         = 3
5591:             .GridLines          = 3
5592:             .ReadOnly           = .T.
5593:             .Visible            = .T.
5594: 
5595:             .Column1.Width = 70
5596:             .Column1.Header1.Caption = "Per" + CHR(237) + "odo"
5597:             .Column2.Width = 90
5598:             .Column2.Header1.Caption = "Valor Custo GR"
5599:             .Column3.Width = 40
5600:             .Column3.Header1.Caption = "Moe"
5601:         ENDWITH
5602: 

*-- Linhas 5840 a 5876:
5840:     * Criado por - lookup SigCdUsu / Data Apr. Amostra).
5841:     *
5842:     * grd_4c_Dados (grdDesigner) e grd_4c_Arquivos (grdArquivos) ficam SEM
5843:     * RecordSource/ControlSource nesta fase (regra #41 do CLAUDE.md:
5844:     * crSigPrTar/crSigPrArq ainda nao existem - nenhum BO deste projeto os
5845:     * popula). Pelo mesmo motivo os botoes que operam sobre essas grades
5846:     * (Iniciar/Encerrar Tarefa, Inserir/Abrir/Excluir Arquivo) e o
5847:     * AfterRowColChange/DblClick que atualizam a preview de imagem ficam SEM
5848:     * Click/evento - mesmo padrao de deferimento de ConfigurarPgPgDadosFaseP/
5849:     * ConfigurarPgPgDadosConsP (GradFase/grdMatrizes/inserir/excluir/...).
5850:     * Nomes internos das grades distintos de proposito (nao ambos
5851:     * "grd_4c_Dados") para nao colidir - o mapeamento.json mapeia as DUAS
5852:     * grades desta pagina para "grd_4c_Dados" (mesma colisao ja documentada
5853:     * em ConfigurarPgPgDadosConsP/grd_4c_Tempos).
5854:     *
5855:     * getObsTarefas (ControlSource legado crSigPrTar.ObsTars) e getObsInsp
5856:     * (ControlSource legado crSigCdPro.ObsInsp) ficam so estruturais - esta
5857:     * arquitetura nao usa TextBox.ControlSource (FormParaBO/BOParaForm fazem
5858:     * o bind manual) e getObsTarefas depende do cursor de tarefas acima.
5859:     *
5860:     * GetDesLacto/GetCriaLacto SAO lookups reais contra SigCdUsu, filtrados
5861:     * por "Not cAtivos='N' and deptos in (select codigos from sigcddpt where
5862:     * UtiLacto = 1)" (transcrito do Valid legado), e recebem BINDEVENT +
5863:     * ExecutarLookupGenerico, igual aos demais campos de codigo isolado do
5864:     * form.
5865:     *===========================================================================
5866:     PROTECTED PROCEDURE ConfigurarPgpgDesigner()
5867:         LOCAL par_oPagina
5868:         par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page7
5869: 
5870:         *-- Moldura decorativa ao redor do bloco Inspiracao/Observacao (Shape1)
5871:         par_oPagina.AddObject("shp_4c_Shape1", "Shape")
5872:         WITH par_oPagina.shp_4c_Shape1
5873:             .Top           = 400
5874:             .Left          = 584
5875:             .Width         = 407
5876:             .Height        = 202

*-- Linhas 5882 a 5918:
5882:         ENDWITH
5883: 
5884:         *-- Grade de tarefas do designer (grdDesigner legado, 4 colunas) -
5885:         *-- espelha crSigPrTar; SEM RecordSource/ControlSource nesta fase
5886:         *-- (regra #41)
5887:         par_oPagina.AddObject("grd_4c_Dados", "Grid")
5888:         par_oPagina.grd_4c_Dados.ColumnCount = 4
5889:         WITH par_oPagina.grd_4c_Dados
5890:             .Top                = 145
5891:             .Left               = 10
5892:             .Width              = 495
5893:             .Height             = 180
5894:             .FontName           = "Tahoma"
5895:             .FontSize           = 8
5896:             .ForeColor          = RGB(90, 90, 90)
5897:             .BackColor          = RGB(255, 255, 255)
5898:             .GridLineColor      = RGB(238, 238, 238)
5899:             .HighlightBackColor = RGB(255, 255, 255)
5900:             .HighlightForeColor = RGB(15, 41, 104)
5901:             .HighlightStyle     = 2
5902:             .AllowHeaderSizing  = .F.
5903:             .DeleteMark         = .F.
5904:             .RecordMark         = .F.
5905:             .RowHeight          = 16
5906:             .ScrollBars         = 2
5907:             .GridLines          = 3
5908:             .ReadOnly           = .T.
5909:             .Visible            = .T.
5910: 
5911:             .Column1.Width           = 140
5912:             .Column1.Movable         = .F.
5913:             .Column1.Resizable       = .F.
5914:             .Column1.ReadOnly        = .T.
5915:             .Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
5916: 
5917:             .Column2.Width           = 140
5918:             .Column2.Movable         = .F.

*-- Linhas 5996 a 6032:
5996:         ENDWITH
5997: 
5998:         *-- Grade de arquivos anexados (grdArquivos legado, 1 coluna) -
5999:         *-- espelha crSigPrArq; SEM RecordSource/ControlSource nesta fase
6000:         *-- (regra #41)
6001:         par_oPagina.AddObject("grd_4c_Arquivos", "Grid")
6002:         par_oPagina.grd_4c_Arquivos.ColumnCount = 1
6003:         WITH par_oPagina.grd_4c_Arquivos
6004:             .Top                = 334
6005:             .Left               = 10
6006:             .Width              = 495
6007:             .Height             = 164
6008:             .FontName           = "Tahoma"
6009:             .FontSize           = 8
6010:             .ForeColor          = RGB(90, 90, 90)
6011:             .BackColor          = RGB(255, 255, 255)
6012:             .GridLineColor      = RGB(238, 238, 238)
6013:             .HighlightBackColor = RGB(255, 255, 255)
6014:             .HighlightForeColor = RGB(15, 41, 104)
6015:             .HighlightStyle     = 2
6016:             .AllowHeaderSizing  = .F.
6017:             .DeleteMark         = .F.
6018:             .RecordMark         = .F.
6019:             .RowHeight          = 16
6020:             .ScrollBars         = 2
6021:             .GridLines          = 3
6022:             .ReadOnly           = .T.
6023:             .Visible            = .T.
6024: 
6025:             .Column1.Width           = 464
6026:             .Column1.Movable         = .F.
6027:             .Column1.Resizable       = .F.
6028:             .Column1.ReadOnly        = .T.
6029:             .Column1.Header1.Caption = "Arquivos Para Designer"
6030:         ENDWITH
6031: 
6032:         *-- Botoes Inserir / Abrir / Excluir Arquivo (btnInsArqs/btnOpnArqs/

*-- Linhas 6242 a 6283:
6242:     * ConfigurarPgpgServico - Sub-pagina "Servicos" (pgServico legado - Page8):
6243:     * grade de servicos vinculados ao produto (crSigPrSer legado), com colunas
6244:     * Servicos/Codigo e checkbox de marcacao na Coluna3 - FASE 15. SEM
6245:     * RecordSource/ControlSource nesta fase (regra #41 CLAUDE.md - cursor
6246:     * ainda nao populado, mesmo estagio dos demais grids desta pagina).
6247:     *===========================================================================
6248:     PROTECTED PROCEDURE ConfigurarPgpgServico()
6249:         LOCAL par_oPagina
6250:         par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8
6251: 
6252:         *-- Grade de servicos (grdServico legado, 3 colunas)
6253:         par_oPagina.AddObject("grd_4c_Dados", "Grid")
6254:         par_oPagina.grd_4c_Dados.ColumnCount = 3
6255:         WITH par_oPagina.grd_4c_Dados
6256:             .Top                = 171
6257:             .Left               = 339
6258:             .Width              = 320
6259:             .Height             = 387
6260:             .FontName           = "Verdana"
6261:             .FontSize           = 8
6262:             .ForeColor          = RGB(90, 90, 90)
6263:             .BackColor          = RGB(255, 255, 255)
6264:             .GridLineColor      = RGB(238, 238, 238)
6265:             .HighlightBackColor = RGB(255, 255, 255)
6266:             .HighlightForeColor = RGB(15, 41, 104)
6267:             .HighlightStyle     = 2
6268:             .DeleteMark         = .F.
6269:             .RecordMark         = .F.
6270:             .RowHeight          = 16
6271:             .ScrollBars         = 2
6272:             .GridLines          = 3
6273:             .ReadOnly           = .F.
6274:             .Visible            = .T.
6275: 
6276:             .Column1.Width           = 180
6277:             .Column1.Header1.Caption = "Servi" + CHR(231) + "os"
6278: 
6279:             .Column2.Width           = 90
6280:             .Column2.Header1.Caption = "C" + CHR(243) + "digo"
6281: 
6282:             .Column3.Width           = 50
6283:             .Column3.Header1.Caption = ""

*-- Linhas 6338 a 6356:
6338:                 ENDIF
6339: 
6340:                 IF loc_oBusca.this_lSelecionou AND USED(par_cCursor)
6341:                     SELECT (par_cCursor)
6342:                     par_oTxtCod.Value = ALLTRIM(EVALUATE(par_cCursor + "." + par_cCampoCod))
6343:                     IF VARTYPE(par_oTxtDesc) = "O" AND !EMPTY(par_cCampoDesc)
6344:                         par_oTxtDesc.Value = ALLTRIM(EVALUATE(par_cCursor + "." + par_cCampoDesc))
6345:                     ENDIF
6346:                 ELSE
6347:                     par_oTxtCod.Value = ""
6348:                     IF VARTYPE(par_oTxtDesc) = "O"
6349:                         par_oTxtDesc.Value = ""
6350:                     ENDIF
6351:                 ENDIF
6352: 
6353:                 loc_oBusca.Release()
6354:             ENDIF
6355: 
6356:             IF USED(par_cCursor)

*-- Linhas 6413 a 6444:
6413:         LOCAL loc_oPg, loc_cValor, loc_cFiltro
6414:         loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6415:         loc_cValor  = PADR(ALLTRIM(loc_oPg.txt_4c_CSGru.Value), 6)
6416:         loc_cFiltro = "CGrus = " + EscaparSQL(PADR(ALLTRIM(loc_oPg.txt_4c_Cgru.Value), 3))
6417:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CSGru, loc_oPg.txt_4c_DsGru, ;
6418:             "SigCdPsg", "Codigos", "Descricaos", "Subgrupo", ;
6419:             "cursor_4c_BuscaSubGrpDados", "Codigos", loc_cValor, loc_cFiltro)
6420:     ENDPROC
6421: 
6422:     PROCEDURE ValidarSubgrupoDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
6423:         LOCAL loc_oPg, loc_cValor, loc_cFiltro
6424:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6425:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsGru.Value)
6426:         IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_CSGru.Value))
6427:             RETURN
6428:         ENDIF
6429:         loc_cFiltro = "CGrus = " + EscaparSQL(PADR(ALLTRIM(loc_oPg.txt_4c_Cgru.Value), 3))
6430:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CSGru, loc_oPg.txt_4c_DsGru, ;
6431:             "SigCdPsg", "Codigos", "Descricaos", "Subgrupo", ;
6432:             "cursor_4c_BuscaSubGrpDados", "Descricaos", loc_cValor, loc_cFiltro)
6433:     ENDPROC
6434: 
6435:     PROCEDURE ValidarLinhaDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
6436:         LOCAL loc_oPg, loc_cValor
6437:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6438:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Lin.Value), 10)
6439:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Lin, loc_oPg.txt_4c_DLin, ;
6440:             "SigCdLin", "Linhas", "Descs", "Linha", "cursor_4c_BuscaLinDados", ;
6441:             "Linhas", loc_cValor, "")
6442:     ENDPROC
6443: 
6444:     PROCEDURE ValidarLinhaDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 6478 a 6497:
6478:         LOCAL loc_oPg, loc_cValor, loc_cFiltro
6479:         loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6480:         loc_cValor  = PADR(ALLTRIM(loc_oPg.txt_4c_Class.Value), 3)
6481:         loc_cFiltro = "CGrus IN (" + EscaparSQL(PADR(ALLTRIM(loc_oPg.txt_4c_Cgru.Value), 3)) + ;
6482:             ", " + EscaparSQL(SPACE(3)) + ")"
6483:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Class, .NULL., "SigCdCls", ;
6484:             "Cods", "", "Classifica" + CHR(231) + CHR(227) + "o", ;
6485:             "cursor_4c_BuscaClsDados", "Cods", loc_cValor, loc_cFiltro)
6486:     ENDPROC
6487: 
6488:     PROCEDURE ValidarFornecedorDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
6489:         LOCAL loc_oPg, loc_cValor
6490:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
6491:         loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Ifor.Value), 10)
6492:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Ifor, loc_oPg.txt_4c_Dfor, ;
6493:             "SigCdCli", "Iclis", "Rclis", "Fornecedor", ;
6494:             "cursor_4c_BuscaForDados", "Iclis", loc_cValor, "")
6495:     ENDPROC
6496: 
6497:     PROCEDURE ValidarFornecedorDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 6912 a 6932:
6912:                 USE IN cursor_4c_AliqClfDadosFiscais
6913:             ENDIF
6914: 
6915:             loc_cSQL = "SELECT aipis FROM SigCdClf WHERE Codigos = " + ;
6916:                 EscaparSQL(PADR(loc_cClfiscal, 10))
6917:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AliqClfDadosFiscais")
6918: 
6919:             IF loc_nResultado >= 0 AND USED("cursor_4c_AliqClfDadosFiscais") ;
6920:                     AND RECCOUNT("cursor_4c_AliqClfDadosFiscais") > 0
6921:                 IF loc_nValor = cursor_4c_AliqClfDadosFiscais.aipis
6922:                     MsgAviso("Al" + CHR(237) + "quota de IPI informada no " + ;
6923:                         "produto id" + CHR(234) + "ntica " + CHR(224) + ;
6924:                         " classifica" + CHR(231) + CHR(227) + "o fiscal, " + ;
6925:                         "deixe zero e ser" + CHR(225) + " utilizada a " + ;
6926:                         "classifica" + CHR(231) + CHR(227) + "o fiscal!", ;
6927:                         "Aten" + CHR(231) + CHR(227) + "o")
6928:                 ENDIF
6929:             ENDIF
6930: 
6931:             IF USED("cursor_4c_AliqClfDadosFiscais")
6932:                 USE IN cursor_4c_AliqClfDadosFiscais

*-- Linhas 6957 a 6987:
6957:         LOCAL loc_oPg, loc_cValor, loc_cFiltro
6958:         loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page7
6959:         loc_cValor  = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
6960:         loc_cFiltro = "cAtivos <> " + EscaparSQL("N") + " AND deptos IN " + ;
6961:             "(SELECT codigos FROM sigcddpt WHERE UtiLacto = 1)"
6962:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_DesLacto, .NULL., "SigCdUsu", ;
6963:             "Usuarios", "NComps", "Usu" + CHR(225) + "rio", ;
6964:             "cursor_4c_BuscaDesLactoDesigner", "Usuarios", loc_cValor, loc_cFiltro)
6965:     ENDPROC
6966: 
6967:     PROCEDURE ValidarCriadoPorLacto(par_nKeyCode, par_nShiftAltCtrl)
6968:         LOCAL loc_oPg, loc_cValor, loc_cFiltro
6969:         loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page7
6970:         loc_cValor  = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
6971:         loc_cFiltro = "cAtivos <> " + EscaparSQL("N") + " AND deptos IN " + ;
6972:             "(SELECT codigos FROM sigcddpt WHERE UtiLacto = 1)"
6973:         THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CriaLacto, .NULL., "SigCdUsu", ;
6974:             "Usuarios", "NComps", "Usu" + CHR(225) + "rio", ;
6975:             "cursor_4c_BuscaCriaLactoDesigner", "Usuarios", loc_cValor, loc_cFiltro)
6976:     ENDPROC
6977: 
6978:     *===========================================================================
6979:     * ConfigurarNavegacaoDivisoes - OptionGroup de 8 botoes graficos que faz o
6980:     * papel da barra de abas (Optiongroup1 legado: Top=3, Left=8, 610 x 85)
6981:     *
6982:     * Cada botao mantem o Left, o Picture e a tecla de atalho do SCX. A ordem
6983:     * dos botoes na tela (Left) NAO e a ordem do Value: o Value e o indice da
6984:     * Option, e e ele que o legado usa no DO CASE do InteractiveChange.
6985:     *===========================================================================
6986:     PROTECTED PROCEDURE ConfigurarNavegacaoDivisoes(par_oPagina)
6987:         par_oPagina.AddObject("opt_4c_Navegacao", "OptionGroup")

*-- Linhas 7295 a 7317:
7295:     *===========================================================================
7296:     * FormParaBO - Transfere os campos da aba Dados Principais para o BO
7297:     *
7298:     * O mapa campo -> coluna eh a transcricao dos ControlSource do SCX legado
7299:     * (crSigCdPro.<coluna>), coluna por coluna. Campos de DESCRICAO de lookup
7300:     * (Dgru, DsGru, DLin, DCol, Dfor, DesFinP, Duni, _dunip) NAO tem
7301:     * ControlSource no legado: sao so apoio visual e por isso nao entram aqui.
7302:     * Estoques/QtdEsts tambem ficam de fora - o SCX zera o ControlSource deles
7303:     * (sao calculados, nao existem em SigCdPro).
7304:     *===========================================================================
7305:     PROTECTED PROCEDURE FormParaBO()
7306:         LOCAL loc_lResultado, loc_oPg, loc_oBO, loException
7307:         loc_lResultado = .F.
7308: 
7309:         TRY
7310:             loc_oPg = THIS.ObterPaginaDados()
7311:             loc_oBO = THIS.this_oBusinessObject
7312: 
7313:             *-- Identificacao ------------------------------------------------
7314:             loc_oBO.this_cCpros    = ALLTRIM(loc_oPg.txt_4c_Cpro.Value)          && cpros
7315:             loc_oBO.this_cDpros    = ALLTRIM(loc_oPg.txt_4c_Dpro.Value)          && dpros
7316:             loc_oBO.this_cDpro2s   = ALLTRIM(loc_oPg.txt_4c_DPro2s.Value)        && dpro2s
7317:             loc_oBO.this_cCproeqs  = ALLTRIM(loc_oPg.txt_4c_CProEq.Value)        && cproeqs

*-- Linhas 7357 a 7375:
7357:             *-- Auditoria: data/usuario de inclusao e de alteracao.
7358:             *-- Os carimbos sao aplicados pelo BO (AplicarCarimboInclusao /
7359:             *-- AplicarCarimboAlteracao); aqui so devolvemos o que ja estava
7360:             *-- gravado, para o UPDATE nao zerar a inclusao original.
7361:             loc_oBO.this_dDtincs   = ConverterParaData(loc_oPg.txt_4c_DtIncs.Value)   && dtincs
7362:             loc_oBO.this_cUsuincs  = ALLTRIM(loc_oPg.txt_4c_Usuario.Value)            && UsuIncs
7363:             loc_oBO.this_dDtalts   = ConverterParaData(loc_oPg.txt_4c_DataAlts.Value) && dtalts
7364:             loc_oBO.this_cUsuaalts = ALLTRIM(loc_oPg.txt_4c_UsuaAlts.Value)           && usuaalts
7365: 
7366:             loc_oBO.MarcarComoAlterado()
7367:             loc_lResultado = .T.
7368: 
7369:         CATCH TO loException
7370:             MostrarErro("Erro ao transferir os dados do formul" + CHR(225) + "rio:" + ;
7371:                 CHR(13) + loException.Message + CHR(13) + ;
7372:                 "Linha: " + TRANSFORM(loException.LineNo), "FormProduto.FormParaBO")
7373:             loc_lResultado = .F.
7374:         ENDTRY
7375: 

*-- Linhas 7396 a 7415:
7396:             loc_oPg.txt_4c_Dpro.Value    = ALLTRIM(loc_oBO.this_cDpros)
7397:             loc_oPg.txt_4c_DPro2s.Value  = ALLTRIM(loc_oBO.this_cDpro2s)
7398:             loc_oPg.txt_4c_CProEq.Value  = ALLTRIM(loc_oBO.this_cCproeqs)
7399:             loc_oPg.txt_4c_Cbar.Value    = THIS.FormatarNumeroTexto(loc_oBO.this_nCbars, 0)
7400:             loc_oPg.txt_4c_EAN13.Value   = THIS.FormatarNumeroTexto(loc_oBO.this_nEan13, 0)
7401: 
7402:             *-- Classificacao ------------------------------------------------
7403:             loc_oPg.txt_4c_Cgru.Value     = ALLTRIM(loc_oBO.this_cCgrus)
7404:             loc_oPg.txt_4c_CSGru.Value    = ALLTRIM(loc_oBO.this_cSgrus)
7405:             loc_oPg.txt_4c_Lin.Value      = ALLTRIM(loc_oBO.this_cLinhas)
7406:             loc_oPg.txt_4c_Col.Value      = ALLTRIM(loc_oBO.this_cColecoes)
7407:             loc_oPg.txt_4c_Merc.Value     = ALLTRIM(loc_oBO.this_cMercs)
7408:             loc_oPg.txt_4c_Class.Value    = ALLTRIM(loc_oBO.this_cCclass)
7409:             loc_oPg.txt_4c_IdeCPros.Value = ALLTRIM(loc_oBO.this_cIdecpros)
7410:             loc_oPg.txt_4c_Conjunto.Value = ALLTRIM(loc_oBO.this_cConjunts)
7411: 
7412:             *-- Fornecedor / referencia / modelo ------------------------------
7413:             loc_oPg.txt_4c_Ifor.Value    = ALLTRIM(loc_oBO.this_cIfors)
7414:             loc_oPg.txt_4c_Refs.Value    = ALLTRIM(loc_oBO.this_cReffs)
7415:             loc_oPg.txt_4c_CodFinP.Value = ALLTRIM(loc_oBO.this_cCodfinp)

*-- Linhas 7428 a 7502:
7428:             loc_oPg.txt_4c_Obs3.Value = ALLTRIM(loc_oBO.this_cObsetqs)
7429: 
7430:             *-- Custo / venda e suas moedas -----------------------------------
7431:             loc_oPg.txt_4c_Ctotal.Value   = THIS.FormatarNumeroTexto(loc_oBO.this_nCustofs, 3)
7432:             loc_oPg.txt_4c_Mctotal.Value  = ALLTRIM(loc_oBO.this_cMoecusfs)
7433:             loc_oPg.txt_4c_Pvenda.Value   = THIS.FormatarNumeroTexto(loc_oBO.this_nPvens, 5)
7434:             loc_oPg.txt_4c_Mpvenda.Value  = ALLTRIM(loc_oBO.this_cMoevs)
7435:             loc_oPg.txt_4c_Fvenda.Value   = THIS.FormatarNumeroTexto(loc_oBO.this_nFvendas, 3)
7436:             loc_oPg.txt_4c_Mfvenda.Value  = ALLTRIM(loc_oBO.this_cMoepvs)
7437: 
7438:             *-- Auditoria -----------------------------------------------------
7439:             loc_oPg.txt_4c_DtIncs.Value   = THIS.FormatarDataTexto(loc_oBO.this_dDtincs)
7440:             loc_oPg.txt_4c_Usuario.Value  = ALLTRIM(loc_oBO.this_cUsuincs)
7441:             loc_oPg.txt_4c_DataAlts.Value = THIS.FormatarDataTexto(loc_oBO.this_dDtalts)
7442:             loc_oPg.txt_4c_UsuaAlts.Value = ALLTRIM(loc_oBO.this_cUsuaalts)
7443: 
7444:             *-- Descricoes dos lookups (nao existem em SigCdPro)
7445:             THIS.PreencherDescricoesLookup()
7446: 
7447:             loc_lResultado = .T.
7448: 
7449:         CATCH TO loException
7450:             MostrarErro("Erro ao exibir os dados do produto:" + CHR(13) + ;
7451:                 loException.Message + CHR(13) + ;
7452:                 "Linha: " + TRANSFORM(loException.LineNo), "FormProduto.BOParaForm")
7453:             loc_lResultado = .F.
7454:         ENDTRY
7455: 
7456:         RETURN loc_lResultado
7457:     ENDPROC
7458: 
7459:     *===========================================================================
7460:     * FormatarNumeroTexto - Converte numerico para o texto exibido no TextBox
7461:     * Os TextBox numericos desta aba sao de tipo Caractere (o legado usa
7462:     * ControlSource direto na coluna; aqui o valor entra como texto), entao a
7463:     * conversao passa por aqui em vez de atribuir o numero cru.
7464:     *===========================================================================
7465:     PROTECTED PROCEDURE FormatarNumeroTexto(par_nValor, par_nDecimais)
7466:         LOCAL loc_nValor, loc_nDec, loc_cTexto
7467:         loc_nValor = IIF(VARTYPE(par_nValor) = "N", par_nValor, 0)
7468:         loc_nDec   = IIF(VARTYPE(par_nDecimais) = "N", par_nDecimais, 0)
7469:         loc_cTexto = ""
7470: 
7471:         IF loc_nValor != 0
7472:             IF loc_nDec > 0
7473:                 loc_cTexto = ALLTRIM(STR(loc_nValor, 20, loc_nDec))
7474:             ELSE
7475:                 loc_cTexto = ALLTRIM(STR(loc_nValor, 20, 0))
7476:             ENDIF
7477:         ENDIF
7478: 
7479:         RETURN loc_cTexto
7480:     ENDPROC
7481: 
7482:     *===========================================================================
7483:     * FormatarDataTexto - Converte DATE/DATETIME para o texto do TextBox
7484:     * Regra #16: NUNCA TTOD() direto - o valor chega como DATE (campo em
7485:     * branco) ou DATETIME (vindo do SQL Server) conforme o caminho.
7486:     *===========================================================================
7487:     PROTECTED PROCEDURE FormatarDataTexto(par_uData)
7488:         LOCAL loc_dData, loc_cTexto
7489:         loc_cTexto = ""
7490:         loc_dData  = ConverterParaData(par_uData)
7491: 
7492:         IF VARTYPE(loc_dData) = "D" AND !EMPTY(loc_dData)
7493:             loc_cTexto = DTOC(loc_dData)
7494:         ENDIF
7495: 
7496:         RETURN loc_cTexto
7497:     ENDPROC
7498: 
7499:     *===========================================================================
7500:     * PreencherDescricoesLookup - Recarrega os campos de descricao dos lookups
7501:     * (Grupo, Subgrupo, Linha, Colecao, Fornecedor, Modelo, Unidades). Eles nao
7502:     * existem em SigCdPro, por isso sao consultados nas tabelas de apoio.

*-- Linhas 7513 a 7531:
7513: 
7514:             loc_oPg.txt_4c_DsGru.Value = THIS.ObterDescricaoTabela("SigCdPsg", ;
7515:                 "Descricaos", "Codigos", ALLTRIM(loc_oPg.txt_4c_CSGru.Value), ;
7516:                 IIF(EMPTY(loc_cGrupo), "", "CGrus = " + EscaparSQL(PADR(loc_cGrupo, 3))))
7517: 
7518:             loc_oPg.txt_4c_DLin.Value = THIS.ObterDescricaoTabela("SigCdLin", ;
7519:                 "Descs", "Linhas", ALLTRIM(loc_oPg.txt_4c_Lin.Value), "")
7520: 
7521:             loc_oPg.txt_4c_DCol.Value = THIS.ObterDescricaoTabela("SigCdCol", ;
7522:                 "Descs", "Colecoes", ALLTRIM(loc_oPg.txt_4c_Col.Value), "")
7523: 
7524:             loc_oPg.txt_4c_Dfor.Value = THIS.ObterDescricaoTabela("SigCdCli", ;
7525:                 "Rclis", "Iclis", ALLTRIM(loc_oPg.txt_4c_Ifor.Value), "")
7526: 
7527:             loc_oPg.txt_4c_DesFinP.Value = THIS.ObterDescricaoTabela("SigCdFip", ;
7528:                 "Descs", "Cods", ALLTRIM(loc_oPg.txt_4c_CodFinP.Value), "")
7529: 
7530:             loc_oPg.txt_4c_Duni.Value = THIS.ObterDescricaoTabela("SigCdUni", ;
7531:                 "DUnis", "CUnis", ALLTRIM(loc_oPg.txt_4c_Cuni.Value), "")

*-- Linhas 7554 a 7595:
7554:         ENDIF
7555: 
7556:         *-- Sem conexao (validacao de UI / teste headless) nao ha o que
7557:         *-- consultar. Sai antes do SQLEXEC: senao cada um dos 8 lookups de
7558:         *-- PreencherDescricoesLookup abriria o seu proprio dialogo de erro.
7559:         *-- O CATCH abaixo continua reportando falha REAL de SQL (regra #9).
7560:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
7561:             RETURN ""
7562:         ENDIF
7563: 
7564:         TRY
7565:             IF USED("cursor_4c_DescAux")
7566:                 USE IN cursor_4c_DescAux
7567:             ENDIF
7568: 
7569:             loc_cSQL = "SELECT " + par_cCampoDesc + " FROM " + par_cTabela + ;
7570:                 " WHERE " + par_cCampoChave + " = " + EscaparSQL(ALLTRIM(par_cValor))
7571: 
7572:             IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
7573:                 loc_cSQL = loc_cSQL + " AND " + par_cFiltro
7574:             ENDIF
7575: 
7576:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescAux")
7577: 
7578:             IF loc_nResultado >= 0 AND USED("cursor_4c_DescAux")
7579:                 IF RECCOUNT("cursor_4c_DescAux") > 0
7580:                     SELECT cursor_4c_DescAux
7581:                     GO TOP
7582:                     loc_cDescricao = ALLTRIM(NVL(EVALUATE("cursor_4c_DescAux." + par_cCampoDesc), ""))
7583:                 ENDIF
7584:             ENDIF
7585: 
7586:             IF USED("cursor_4c_DescAux")
7587:                 USE IN cursor_4c_DescAux
7588:             ENDIF
7589: 
7590:         CATCH TO loException
7591:             MostrarErro("Erro ao consultar " + par_cTabela + ":" + CHR(13) + ;
7592:                 loException.Message, "FormProduto.ObterDescricaoTabela")
7593:             loc_cDescricao = ""
7594:         ENDTRY
7595: 

*-- Linhas 7958 a 8015:
7958: 
7959:             *-- lcBus: so usado nos casos DPros / DPro2s
7960:             loc_cBus = IIF(EMPTY(ALLTRIM(loc_cGru)), "", ;
7961:                 "cgrus = " + EscaparSQL(loc_cGru) + " AND ")
7962: 
7963:             loc_cFiltro    = ""
7964:             loc_cMsgParcial = ""
7965:             loc_lTemFiltro = .T.
7966:             loc_lLike      = .F.
7967: 
7968:             DO CASE
7969:                 CASE !EMPTY(ALLTRIM(loc_cPro))
7970:                     loc_cFiltro = "cpros = " + EscaparSQL(ALLTRIM(loc_cPro))
7971: 
7972:                 CASE !EMPTY(ALLTRIM(loc_cDes))
7973:                     loc_cFiltro     = loc_cBus + "dpros = " + EscaparSQL(ALLTRIM(loc_cDes))
7974:                     loc_lLike       = .T.
7975:                     loc_cMsgParcial = "N" + CHR(227) + "o Foi Encontrada Uma Descri" + ;
7976:                         CHR(231) + CHR(227) + "o Igual a Digitada!!!" + CHR(13) + ;
7977:                         "Deseja Procurar Parte da Descri" + CHR(231) + CHR(227) + "o?"
7978: 
7979:                 CASE !EMPTY(ALLTRIM(loc_cD2s))
7980:                     loc_cFiltro     = loc_cBus + "dpro2s = " + EscaparSQL(ALLTRIM(loc_cD2s))
7981:                     loc_lLike       = .T.
7982:                     loc_cMsgParcial = "N" + CHR(227) + "o Foi Encontrado Um Descritivo Igual " + ;
7983:                         "ao Digitado!!!" + CHR(13) + ;
7984:                         "Deseja Procurar Parte da Descri" + CHR(231) + CHR(227) + "o?"
7985: 
7986:                 CASE !EMPTY(ALLTRIM(loc_cFor))
7987:                     loc_cFiltro = "ifors = " + EscaparSQL(ALLTRIM(loc_cFor))
7988: 
7989:                 CASE !EMPTY(ALLTRIM(loc_cRff))
7990:                     loc_cFiltro     = "reffs = " + EscaparSQL(ALLTRIM(loc_cRff))
7991:                     loc_lLike       = .T.
7992:                     loc_cMsgParcial = "N" + CHR(227) + "o Foi Encontrada Uma Refer" + CHR(234) + ;
7993:                         "ncia Igual a Digitada!!!" + CHR(13) + ;
7994:                         "Deseja Procurar Parte da Refer" + CHR(234) + "ncia?"
7995: 
7996:                 CASE !EMPTY(loc_cCnj)
7997:                     loc_cFiltro = "conjunts = " + EscaparSQL(loc_cCnj)
7998: 
7999:                 CASE !EMPTY(loc_cBar)
8000:                     loc_cFiltro = "cbars = " + FormatarNumeroSQL(VAL(loc_cBar), 0)
8001: 
8002:                 OTHERWISE
8003:                     loc_lTemFiltro = .F.
8004:             ENDCASE
8005: 
8006:             IF !loc_lTemFiltro
8007:                 MsgAviso("Informe ao menos um campo de procura: Produto, " + ;
8008:                     "Descri" + CHR(231) + CHR(227) + "o, Descritivo," + CHR(13) + ;
8009:                     "Ref. Fornecedor, Fornecedor, Barra ou Cod. Pai.", "Procurar")
8010:             ELSE
8011:                 THIS.AplicarResultadoBusca(loc_cTabela, loc_cFiltro, loc_lLike, ;
8012:                     loc_cMsgParcial, loc_cBus, loc_cDes, loc_cD2s, loc_cRff)
8013:             ENDIF
8014: 
8015:         CATCH TO loException

*-- Linhas 8024 a 8099:
8024:     * AplicarResultadoBusca - Executa a consulta da busca por exemplo, aplica o
8025:     * fallback "parte da descricao" do legado e devolve o resultado para a
8026:     * grade da Lista.
8027:     *
8028:     * O legado insere os achados em crProcurar e habilita a navegacao; aqui o
8029:     * equivalente natural eh recarregar cursor_4c_Dados (a propria grade da
8030:     * pagina Lista) e voltar para ela - o usuario ve exatamente os produtos
8031:     * que a procura encontrou.
8032:     *===========================================================================
8033:     PROTECTED PROCEDURE AplicarResultadoBusca(par_cTabela, par_cFiltro, ;
8034:             par_lLike, par_cMsgParcial, par_cBus, par_cDes, par_cD2s, par_cRff)
8035:         LOCAL loc_cSQL, loc_nResultado, loc_nAchados, loc_cFiltro, loException
8036: 
8037:         loc_cFiltro  = par_cFiltro
8038:         loc_nAchados = 0
8039: 
8040:         TRY
8041:             IF USED("cursor_4c_Dados")
8042:                 USE IN cursor_4c_Dados
8043:             ENDIF
8044: 
8045:             loc_cSQL = "SELECT " + THIS.ObterColunasBusca() + " FROM " + par_cTabela + ;
8046:                 " WHERE " + loc_cFiltro + " ORDER BY cpros"
8047: 
8048:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
8049: 
8050:             IF loc_nResultado < 0
8051:                 MsgErro("Erro ao procurar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
8052:             ELSE
8053:                 loc_nAchados = RECCOUNT("cursor_4c_Dados")
8054: 
8055:                 *-- Fallback do legado: sem resultado exato, pergunta se quer
8056:                 *-- procurar PARTE do texto (Rtrim(<campo>) Like '%valor%')
8057:                 IF loc_nAchados < 1 AND par_lLike
8058:                     IF MsgConfirma(par_cMsgParcial, "Procura")
8059:                         loc_cFiltro = THIS.MontarFiltroParcial(par_cFiltro, par_cBus, ;
8060:                             par_cDes, par_cD2s, par_cRff)
8061: 
8062:                         IF USED("cursor_4c_Dados")
8063:                             USE IN cursor_4c_Dados
8064:                         ENDIF
8065: 
8066:                         loc_cSQL = "SELECT " + THIS.ObterColunasBusca() + ;
8067:                             " FROM " + par_cTabela + " WHERE " + loc_cFiltro + ;
8068:                             " ORDER BY cpros"
8069: 
8070:                         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
8071: 
8072:                         IF loc_nResultado < 0
8073:                             MsgErro("Erro ao procurar produtos:" + CHR(13) + ;
8074:                                 CapturarErroSQL(), "Erro SQL")
8075:                         ELSE
8076:                             loc_nAchados = RECCOUNT("cursor_4c_Dados")
8077:                         ENDIF
8078:                     ENDIF
8079:                 ENDIF
8080: 
8081:                 IF loc_nAchados < 1
8082:                     MsgAviso("Nenhum produto encontrado com os dados informados.", "Procurar")
8083:                 ELSE
8084:                     GO TOP IN cursor_4c_Dados
8085: 
8086:                     *-- Volta para a Lista mostrando o resultado. A grade eh
8087:                     *-- religada aqui porque AlternarPagina(1) recarregaria o
8088:                     *-- cursor pelos filtros da Lista e descartaria a procura.
8089:                     THIS.this_cModoAtual = "LISTA"
8090:                     THIS.LimparCampos()
8091:                     THIS.pgf_4c_Paginas.ActivePage = 1
8092:                     THIS.VincularGradeLista()
8093:                     THIS.AjustarBotoesPorModo()
8094:                 ENDIF
8095:             ENDIF
8096: 
8097:         CATCH TO loException
8098:             MostrarErro("Erro ao aplicar o resultado da procura:" + CHR(13) + ;
8099:                 loException.Message + CHR(13) + ;

*-- Linhas 8118 a 8185:
8118:         DO CASE
8119:             CASE "dpros = " $ LOWER(par_cFiltroOriginal)
8120:                 loc_cFiltro = par_cBus + "RTRIM(dpros) LIKE " + ;
8121:                     EscaparSQL("%" + ALLTRIM(par_cDes) + "%")
8122: 
8123:             CASE "dpro2s = " $ LOWER(par_cFiltroOriginal)
8124:                 loc_cFiltro = par_cBus + "RTRIM(dpro2s) LIKE " + ;
8125:                     EscaparSQL("%" + ALLTRIM(par_cD2s) + "%")
8126: 
8127:             CASE "reffs = " $ LOWER(par_cFiltroOriginal)
8128:                 loc_cFiltro = "RTRIM(reffs) LIKE " + ;
8129:                     EscaparSQL("%" + ALLTRIM(par_cRff) + "%")
8130:         ENDCASE
8131: 
8132:         RETURN loc_cFiltro
8133:     ENDPROC
8134: 
8135:     *===========================================================================
8136:     * ObterColunasBusca - Colunas do SELECT da procura
8137:     * TEM de coincidir com as colunas que a grade da Lista usa em
8138:     * VincularGradeLista (regra Grid-SQL: ControlSource sem coluna no SELECT
8139:     * estoura "Variable not found").
8140:     *===========================================================================
8141:     PROTECTED PROCEDURE ObterColunasBusca()
8142:         RETURN "cpros, dpros, dpro2s, cgrus, sgrus, reffs, colecoes," + ;
8143:             " impetiqs, situas, encoms, cbars, cproeqs, compos, codcors," + ;
8144:             " usuaalts, dtalts"
8145:     ENDPROC
8146: 
8147:     *===========================================================================
8148:     * VincularGradeLista - Religa a grade da Lista ao cursor_4c_Dados
8149:     *
8150:     * Extraido de CarregarLista para poder ser reutilizado pela procura, que
8151:     * popula o MESMO cursor por outro caminho. Regra #41 / Problema 48:
8152:     * RecordSource PRIMEIRO, depois ControlSource, Width e Header.
8153:     *===========================================================================
8154:     PROTECTED PROCEDURE VincularGradeLista()
8155:         LOCAL loc_oGrid, loException
8156: 
8157:         TRY
8158:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
8159: 
8160:             loc_oGrid.RecordSource = ""
8161:             loc_oGrid.ColumnCount = 6
8162:             loc_oGrid.RecordSource = "cursor_4c_Dados"
8163: 
8164:             loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
8165:             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
8166:             loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
8167:             loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.sgrus"
8168:             loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.reffs"
8169:             loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.usuaalts"
8170:             loc_oGrid.Column7.chk_4c_Inativo.ControlSource = "cursor_4c_Dados.situas = 2"
8171: 
8172:             loc_oGrid.Column1.Width = 90
8173:             loc_oGrid.Column2.Width = 380
8174:             loc_oGrid.Column3.Width = 50
8175:             loc_oGrid.Column4.Width = 70
8176:             loc_oGrid.Column5.Width = 140
8177:             loc_oGrid.Column6.Width = 100
8178:             loc_oGrid.Column7.Width = 30
8179: 
8180:             loc_oGrid.Column1.Header1.Caption = "Produto"
8181:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
8182:             loc_oGrid.Column3.Header1.Caption = "Grupo"
8183:             loc_oGrid.Column4.Header1.Caption = "Subgrp."
8184:             loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
8185:             loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"

*-- Linhas 8236 a 8257:
8236:                 USE IN cursor_4c_MaxConj
8237:             ENDIF
8238: 
8239:             loc_cSQL = "SELECT MAX(CAST(conjunts AS INT)) AS ultimo FROM SigCdPro" + ;
8240:                 " WHERE conjunts <> '' AND ISNUMERIC(conjunts) = 1"
8241: 
8242:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxConj")
8243: 
8244:             IF loc_nResultado < 0
8245:                 MsgErro("Erro ao gerar o Cod. Pai:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
8246:             ELSE
8247:                 loc_nProximo = NVL(cursor_4c_MaxConj.ultimo, 0) + 1
8248:                 loc_oPg.txt_4c_Conjunto.Value = PADL(ALLTRIM(STR(loc_nProximo, 10, 0)), 6, "0")
8249:             ENDIF
8250: 
8251:             IF USED("cursor_4c_MaxConj")
8252:                 USE IN cursor_4c_MaxConj
8253:             ENDIF
8254: 
8255:         CATCH TO loException
8256:             MostrarErro("Erro ao gerar o Cod. Pai:" + CHR(13) + ;
8257:                 loException.Message, "FormProduto.BtnGerarConjuntoClick")

*-- Linhas 8288 a 8306:
8288:                 *-- Regra #37: atribui SO sob a guarda de this_lSelecionou,
8289:                 *-- senao o campo seria ZERADO quando o usuario desiste.
8290:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConj")
8291:                     SELECT cursor_4c_BuscaConj
8292:                     loc_oPg.txt_4c_Conjunto.Value = ;
8293:                         PADL(ALLTRIM(NVL(cursor_4c_BuscaConj.conjunts, "")), 6, "0")
8294:                 ENDIF
8295: 
8296:                 loc_oBusca.Release()
8297:             ENDIF
8298: 
8299:             IF USED("cursor_4c_BuscaConj")
8300:                 USE IN cursor_4c_BuscaConj
8301:             ENDIF
8302: 
8303:         CATCH TO loException
8304:             MostrarErro("Erro ao localizar o Cod. Pai:" + CHR(13) + ;
8305:                 loException.Message, "FormProduto.BtnLocalizarConjuntoClick")
8306:         ENDTRY

*-- Linhas 8374 a 8395:
8374:     PROCEDURE Destroy()
8375:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
8376:             THIS.this_oBusinessObject = .NULL.
8377:         ENDIF
8378: 
8379:         IF USED("cursor_4c_Dados")
8380:             USE IN cursor_4c_Dados
8381:         ENDIF
8382: 
8383:         IF USED("cursor_4c_DescAux")
8384:             USE IN cursor_4c_DescAux
8385:         ENDIF
8386: 
8387:         IF USED("cursor_4c_BuscaConj")
8388:             USE IN cursor_4c_BuscaConj
8389:         ENDIF
8390: 
8391:         IF USED("cursor_4c_MaxConj")
8392:             USE IN cursor_4c_MaxConj
8393:         ENDIF
8394: 
8395:         DODEFAULT()

