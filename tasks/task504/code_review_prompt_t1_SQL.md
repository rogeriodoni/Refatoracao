# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DFORS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: _XNRG, CPROS, CUNIS, MATPRINCS, CGRUS, PGRU, CODS, IFORS, REFFS, COLECOES, MOEMRKAPS, TPCALCPS, ACRESCS, VALORS, TPFTIOS, ARREDCS, MATS, PCOMPOS, PRODUTOS, CUSTOS, TIPOS, RESUMOS, I, 1, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, QTDS, CIDCHAVES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, TPCALCCUS, ESTIMADO, MERCS, ORDEM, ALTCOEF, USUARIOS, CODDEPTO, CODGRUPO, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, NTIPOJOALS, CESTOS, CONJUNTS, CODMACRO, CNJLACTO, USARPAS, APAGAR, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, PRODWEBS, MARCAS, OBRCONJUTS, EAN13, VLDCONJUTS, CATS, ENCOMS, MKPOBRIGS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CODIGO, CATEGORIA, CONTAS, PCESCOLHA, ETIQCDPRO, LINHAS, LNMARCKUPA, LOCLIVRE, TPCALCP, QTEQUALPS, TAG, ORDEMS, DESCRS, USUARS, CODCADS, DEPTOS, UTILACTO, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (2446 linhas total):

*-- Linhas 362 a 380:
362:             .HighlightBackColor = RGB(255, 255, 255)
363:             .HighlightForeColor = RGB(15, 41, 104)
364:             .HighlightStyle     = 2
365:             .DeleteMark         = .F.
366:             .RecordMark         = .F.
367:             .RowHeight          = 18
368:             .ScrollBars         = 3
369:             .GridLines          = 3
370:             .AllowHeaderSizing  = .F.
371:             .AllowRowSizing     = .F.
372:             .Visible            = .T.
373:         ENDWITH
374:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
375: 
376:         THIS.TornarControlesVisiveis(loc_oPagina)
377:     ENDPROC
378: 
379:     *===========================================================================
380:     * ConfigurarPaginaDados - Configura Page2: BotoesAcao + pgf_4c_Dados (8 abas)

*-- Linhas 1350 a 1395:
1350: 
1351:     *===========================================================================
1352:     * CarregarLista - Carrega dados no grid da Page1
1353:     * CRITICO: Definir ControlSources APOS RecordSource (auto-bind)
1354:     *===========================================================================
1355:     PROCEDURE CarregarLista()
1356:         LOCAL loc_lResultado, loc_oGrid
1357:         loc_lResultado = .F.
1358: 
1359:         TRY
1360:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1361:                 loc_lResultado = .T.
1362:             ENDIF
1363: 
1364:             IF !THIS.this_oBusinessObject.Buscar("")
1365:                 loc_lResultado = .F.
1366:             ELSE
1367:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1368: 
1369:                 *-- RecordSource e ColumnCount FORA do WITH (auto-bind VFP9)
1370:                 loc_oGrid.ColumnCount  = 7
1371:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1372: 
1373:                 *-- ControlSources APOS RecordSource (OBRIGATORIO - auto-bind sobrescreve)
1374:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
1375:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
1376:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
1377:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.sgrus"
1378:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.reffs"
1379:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.colecoes"
1380:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.situas"
1381: 
1382:                 *-- Widths (originais: 110, 408, 40, 70, 150, 100, 16)
1383:                 loc_oGrid.Column1.Width = 110
1384:                 loc_oGrid.Column2.Width = 408
1385:                 loc_oGrid.Column3.Width = 40
1386:                 loc_oGrid.Column4.Width = 70
1387:                 loc_oGrid.Column5.Width = 150
1388:                 loc_oGrid.Column6.Width = 100
1389:                 loc_oGrid.Column7.Width = 40
1390: 
1391:                 *-- Headers APOS RecordSource (RecordSource reseta captions)
1392:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1393:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1394:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
1395:                 loc_oGrid.Column4.Header1.Caption = "Sub-grupo"

*-- Linhas 1495 a 1513:
1495:         loc_cCodigo = ""
1496: 
1497:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1498:             SELECT cursor_4c_Dados
1499:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
1500:         ENDIF
1501: 
1502:         IF EMPTY(loc_cCodigo)
1503:             MsgAviso("Selecione um produto para visualizar.")
1504:         ELSE
1505:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1506:                 THIS.this_cModoAtual = "VISUALIZAR"
1507:                 THIS.BOParaForm()
1508:                 THIS.HabilitarCampos(.F.)
1509:                 THIS.AjustarBotoesPorModo()
1510:                 THIS.AlternarPagina(2)
1511:             ENDIF
1512:         ENDIF
1513:     ENDPROC

*-- Linhas 1521 a 1539:
1521:         loc_cCodigo = ""
1522: 
1523:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1524:             SELECT cursor_4c_Dados
1525:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
1526:         ENDIF
1527: 
1528:         IF EMPTY(loc_cCodigo)
1529:             MsgAviso("Selecione um produto para alterar.")
1530:         ELSE
1531:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1532:                 THIS.this_oBusinessObject.EditarRegistro()
1533:                 THIS.this_cModoAtual = "ALTERAR"
1534:                 THIS.BOParaForm()
1535:                 THIS.HabilitarCampos(.T.)
1536:                 THIS.AjustarBotoesPorModo()
1537:                 THIS.AlternarPagina(2)
1538:             ENDIF
1539:         ENDIF

*-- Linhas 1549 a 1567:
1549:         loc_cDescricao = ""
1550: 
1551:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1552:             SELECT cursor_4c_Dados
1553:             loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cpros)
1554:             loc_cDescricao = ALLTRIM(cursor_4c_Dados.dpros)
1555:         ENDIF
1556: 
1557:         IF EMPTY(loc_cCodigo)
1558:             MsgAviso("Selecione um produto para excluir.")
1559:         ELSE
1560:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1561:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto [" + ;
1562:                     loc_cCodigo + "] - " + loc_cDescricao + "?", ;
1563:                     "Confirmar Exclus" + CHR(227) + "o")
1564:                     IF THIS.this_oBusinessObject.Excluir()
1565:                         MsgInfo("Produto exclu" + CHR(237) + "do com sucesso!")
1566:                         THIS.CarregarLista()
1567:                     ENDIF

*-- Linhas 1579 a 1619:
1579:         loc_cCodigo = ""
1580: 
1581:         TRY
1582:             loc_nRet = SQLEXEC(gnConnHandle, ;
1583:                 "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros", ;
1584:                 "cursor_4c_BuscaProduto")
1585: 
1586:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaProduto")
1587:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1588:                 IF VARTYPE(loc_oBusca) = "O"
1589:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaProduto", "cpros", "dpros", ;
1590:                         "Buscar Produto")
1591:                     loc_oBusca.Mostrar()
1592:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado)
1593:                         loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1594:                     ENDIF
1595:                     loc_oBusca = .NULL.
1596:                 ENDIF
1597:             ENDIF
1598: 
1599:             IF USED("cursor_4c_BuscaProduto")
1600:                 USE IN cursor_4c_BuscaProduto
1601:             ENDIF
1602: 
1603:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
1604:                 SELECT cursor_4c_Dados
1605:                 LOCATE FOR ALLTRIM(cpros) == loc_cCodigo
1606:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1607:             ENDIF
1608: 
1609:         CATCH TO loException
1610:             IF USED("cursor_4c_BuscaProduto")
1611:                 USE IN cursor_4c_BuscaProduto
1612:             ENDIF
1613:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, ;
1614:                 "FormProduto.BtnBuscarClick")
1615:         ENDTRY
1616:     ENDPROC
1617: 
1618:     *===========================================================================
1619:     * BtnEncerrarClick - Fecha o formulario

*-- Linhas 1893 a 1982:
1893:             *-- Grupo (SigCdGrp: cgrus/dgrus)
1894:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
1895:             IF !EMPTY(loc_cCod)
1896:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1897:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
1898:                     "cursor_4c_LkpDesc")
1899:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
1900:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_LkpDesc.dgrus)
1901:                 ENDIF
1902:                 IF USED("cursor_4c_LkpDesc")
1903:                     USE IN cursor_4c_LkpDesc
1904:                 ENDIF
1905:             ENDIF
1906: 
1907:             *-- Linha (SigCdLin: linhas/descs)
1908:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
1909:             IF !EMPTY(loc_cCod)
1910:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1911:                     "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
1912:                     "cursor_4c_LkpDesc")
1913:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
1914:                     loc_oPg.txt_4c_DLinhas.Value = ALLTRIM(cursor_4c_LkpDesc.descs)
1915:                 ENDIF
1916:                 IF USED("cursor_4c_LkpDesc")
1917:                     USE IN cursor_4c_LkpDesc
1918:                 ENDIF
1919:             ENDIF
1920: 
1921:             *-- Colecao/Grupo de Venda (SigCdCol: colecoes/descs)
1922:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
1923:             IF !EMPTY(loc_cCod)
1924:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1925:                     "SELECT descs FROM SigCdCol WHERE colecoes = " + EscaparSQL(loc_cCod), ;
1926:                     "cursor_4c_LkpDesc")
1927:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
1928:                     loc_oPg.txt_4c_DColecoes.Value = ALLTRIM(cursor_4c_LkpDesc.descs)
1929:                 ENDIF
1930:                 IF USED("cursor_4c_LkpDesc")
1931:                     USE IN cursor_4c_LkpDesc
1932:                 ENDIF
1933:             ENDIF
1934: 
1935:             *-- Fornecedor (SigCdFor: ifors/dfors)
1936:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
1937:             IF !EMPTY(loc_cCod)
1938:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1939:                     "SELECT dfors FROM SigCdFor WHERE ifors = " + EscaparSQL(loc_cCod), ;
1940:                     "cursor_4c_LkpDesc")
1941:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
1942:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_LkpDesc.dfors)
1943:                 ENDIF
1944:                 IF USED("cursor_4c_LkpDesc")
1945:                     USE IN cursor_4c_LkpDesc
1946:                 ENDIF
1947:             ENDIF
1948: 
1949:             *-- Acabamento (SigCdAca: cods/descrs)
1950:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcbs.Value)
1951:             IF !EMPTY(loc_cCod)
1952:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1953:                     "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
1954:                     "cursor_4c_LkpDesc")
1955:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
1956:                     loc_oPg.txt_4c_DAcbs.Value = ALLTRIM(cursor_4c_LkpDesc.descrs)
1957:                 ENDIF
1958:                 IF USED("cursor_4c_LkpDesc")
1959:                     USE IN cursor_4c_LkpDesc
1960:                 ENDIF
1961:             ENDIF
1962: 
1963:             *-- Unidade (SigCdUni: cunis/dunis)
1964:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)
1965:             IF !EMPTY(loc_cCod)
1966:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1967:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
1968:                     "cursor_4c_LkpDesc")
1969:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
1970:                     loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_LkpDesc.dunis)
1971:                 ENDIF
1972:                 IF USED("cursor_4c_LkpDesc")
1973:                     USE IN cursor_4c_LkpDesc
1974:                 ENDIF
1975:             ENDIF
1976: 
1977:         CATCH TO loException
1978:             IF USED("cursor_4c_LkpDesc")
1979:                 USE IN cursor_4c_LkpDesc
1980:             ENDIF
1981:             MostrarErro("Erro ao carregar descri" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1982:                 loException.Message, "FormProduto.CarregarDescricoes")

*-- Linhas 2043 a 2062:
2043:             IF EMPTY(loc_cCod)
2044:                 loc_oPg.txt_4c_Dgrus.Value = ""
2045:             ELSE
2046:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2047:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
2048:                     "cursor_4c_LkpCgrus")
2049: 
2050:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpCgrus") AND !EOF("cursor_4c_LkpCgrus")
2051:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_LkpCgrus.dgrus)
2052:                     USE IN cursor_4c_LkpCgrus
2053:                 ELSE
2054:                     IF USED("cursor_4c_LkpCgrus")
2055:                         USE IN cursor_4c_LkpCgrus
2056:                     ENDIF
2057:                     loc_oPg.txt_4c_Cgrus.Value = ""
2058:                     loc_oPg.txt_4c_Dgrus.Value = ""
2059:                     THIS.AbrirBuscaGrupo()
2060:                 ENDIF
2061:             ENDIF
2062: 

*-- Linhas 2092 a 2111:
2092:             IF EMPTY(loc_cCod)
2093:                 loc_oPg.txt_4c_DLinhas.Value = ""
2094:             ELSE
2095:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2096:                     "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
2097:                     "cursor_4c_LkpLinha")
2098: 
2099:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpLinha") AND !EOF("cursor_4c_LkpLinha")
2100:                     loc_oPg.txt_4c_DLinhas.Value = ALLTRIM(cursor_4c_LkpLinha.descs)
2101:                     USE IN cursor_4c_LkpLinha
2102:                 ELSE
2103:                     IF USED("cursor_4c_LkpLinha")
2104:                         USE IN cursor_4c_LkpLinha
2105:                     ENDIF
2106:                     loc_oPg.txt_4c_Linhas.Value  = ""
2107:                     loc_oPg.txt_4c_DLinhas.Value = ""
2108:                     MsgAviso("Linha n" + CHR(227) + "o encontrada.")
2109:                 ENDIF
2110:             ENDIF
2111: 

*-- Linhas 2131 a 2150:
2131:             IF EMPTY(loc_cCod)
2132:                 loc_oPg.txt_4c_DColecoes.Value = ""
2133:             ELSE
2134:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2135:                     "SELECT descs FROM SigCdCol WHERE colecoes = " + EscaparSQL(loc_cCod), ;
2136:                     "cursor_4c_LkpColecao")
2137: 
2138:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpColecao") AND !EOF("cursor_4c_LkpColecao")
2139:                     loc_oPg.txt_4c_DColecoes.Value = ALLTRIM(cursor_4c_LkpColecao.descs)
2140:                     USE IN cursor_4c_LkpColecao
2141:                 ELSE
2142:                     IF USED("cursor_4c_LkpColecao")
2143:                         USE IN cursor_4c_LkpColecao
2144:                     ENDIF
2145:                     loc_oPg.txt_4c_Colecoes.Value  = ""
2146:                     loc_oPg.txt_4c_DColecoes.Value = ""
2147:                     MsgAviso("Grupo de venda n" + CHR(227) + "o encontrado.")
2148:                 ENDIF
2149:             ENDIF
2150: 

*-- Linhas 2170 a 2189:
2170:             IF EMPTY(loc_cCod)
2171:                 loc_oPg.txt_4c_Dfors.Value = ""
2172:             ELSE
2173:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2174:                     "SELECT dfors FROM SigCdFor WHERE ifors = " + EscaparSQL(loc_cCod), ;
2175:                     "cursor_4c_LkpForn")
2176: 
2177:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpForn") AND !EOF("cursor_4c_LkpForn")
2178:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_LkpForn.dfors)
2179:                     USE IN cursor_4c_LkpForn
2180:                 ELSE
2181:                     IF USED("cursor_4c_LkpForn")
2182:                         USE IN cursor_4c_LkpForn
2183:                     ENDIF
2184:                     loc_oPg.txt_4c_Ifors.Value = ""
2185:                     loc_oPg.txt_4c_Dfors.Value = ""
2186:                     THIS.AbrirBuscaFornecedor()
2187:                 ENDIF
2188:             ENDIF
2189: 

*-- Linhas 2207 a 2226:
2207:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodCors.Value)
2208: 
2209:             IF !EMPTY(loc_cCod)
2210:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2211:                     "SELECT cods FROM SigCdCor WHERE cods = " + EscaparSQL(loc_cCod), ;
2212:                     "cursor_4c_LkpCor")
2213: 
2214:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpCor") AND !EOF("cursor_4c_LkpCor")
2215:                     USE IN cursor_4c_LkpCor
2216:                 ELSE
2217:                     IF USED("cursor_4c_LkpCor")
2218:                         USE IN cursor_4c_LkpCor
2219:                     ENDIF
2220:                     loc_oPg.txt_4c_CodCors.Value = ""
2221:                     MsgAviso("Cor n" + CHR(227) + "o encontrada.")
2222:                 ENDIF
2223:             ENDIF
2224: 
2225:         CATCH TO loException
2226:             IF USED("cursor_4c_LkpCor")

*-- Linhas 2242 a 2261:
2242:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodTams.Value)
2243: 
2244:             IF !EMPTY(loc_cCod)
2245:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2246:                     "SELECT cods FROM SigCdTam WHERE cods = " + EscaparSQL(loc_cCod), ;
2247:                     "cursor_4c_LkpTam")
2248: 
2249:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpTam") AND !EOF("cursor_4c_LkpTam")
2250:                     USE IN cursor_4c_LkpTam
2251:                 ELSE
2252:                     IF USED("cursor_4c_LkpTam")
2253:                         USE IN cursor_4c_LkpTam
2254:                     ENDIF
2255:                     loc_oPg.txt_4c_CodTams.Value = ""
2256:                     MsgAviso("Tamanho n" + CHR(227) + "o encontrado.")
2257:                 ENDIF
2258:             ENDIF
2259: 
2260:         CATCH TO loException
2261:             IF USED("cursor_4c_LkpTam")

*-- Linhas 2279 a 2298:
2279:             IF EMPTY(loc_cCod)
2280:                 loc_oPg.txt_4c_DAcbs.Value = ""
2281:             ELSE
2282:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2283:                     "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
2284:                     "cursor_4c_LkpAcab")
2285: 
2286:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpAcab") AND !EOF("cursor_4c_LkpAcab")
2287:                     loc_oPg.txt_4c_DAcbs.Value = ALLTRIM(cursor_4c_LkpAcab.descrs)
2288:                     USE IN cursor_4c_LkpAcab
2289:                 ELSE
2290:                     IF USED("cursor_4c_LkpAcab")
2291:                         USE IN cursor_4c_LkpAcab
2292:                     ENDIF
2293:                     loc_oPg.txt_4c_CodAcbs.Value = ""
2294:                     loc_oPg.txt_4c_DAcbs.Value   = ""
2295:                     MsgAviso("Acabamento n" + CHR(227) + "o encontrado.")
2296:                 ENDIF
2297:             ENDIF
2298: 

*-- Linhas 2318 a 2337:
2318:             IF EMPTY(loc_cCod)
2319:                 loc_oPg.txt_4c_Dunis.Value = ""
2320:             ELSE
2321:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2322:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
2323:                     "cursor_4c_LkpUni")
2324: 
2325:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpUni") AND !EOF("cursor_4c_LkpUni")
2326:                     loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_LkpUni.dunis)
2327:                     USE IN cursor_4c_LkpUni
2328:                 ELSE
2329:                     IF USED("cursor_4c_LkpUni")
2330:                         USE IN cursor_4c_LkpUni
2331:                     ENDIF
2332:                     loc_oPg.txt_4c_Cunis.Value = ""
2333:                     loc_oPg.txt_4c_Dunis.Value = ""
2334:                     MsgAviso("Unidade n" + CHR(227) + "o encontrada.")
2335:                 ENDIF
2336:             ENDIF
2337: 

*-- Linhas 2354 a 2381:
2354:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2355:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
2356: 
2357:             loc_nRet = SQLEXEC(gnConnHandle, ;
2358:                 "SELECT cgrus, dgrus FROM SigCdGrp WHERE cgrus LIKE '" + ;
2359:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cgrus", ;
2360:                 "cursor_4c_GrpBusca")
2361: 
2362:             IF loc_nRet <= 0 OR !USED("cursor_4c_GrpBusca") OR EOF("cursor_4c_GrpBusca")
2363:                 IF USED("cursor_4c_GrpBusca")
2364:                     USE IN cursor_4c_GrpBusca
2365:                 ENDIF
2366:                 SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", ;
2367:                     "cursor_4c_GrpBusca")
2368:             ENDIF
2369: 
2370:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2371:             IF VARTYPE(loc_oBusca) = "O"
2372:                 loc_oBusca.DefinirCursor("cursor_4c_GrpBusca", "cgrus", "dgrus", ;
2373:                     "Buscar Grupo de Produto")
2374:                 loc_oBusca.Mostrar()
2375: 
2376:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
2377:                     loc_oPg.txt_4c_Cgrus.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
2378:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
2379:                 ENDIF
2380:                 loc_oBusca = .NULL.
2381:             ENDIF

*-- Linhas 2403 a 2431:
2403:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2404:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
2405: 
2406:             loc_nRet = SQLEXEC(gnConnHandle, ;
2407:                 "SELECT ifors, dfors FROM SigCdFor WHERE ifors LIKE '" + ;
2408:                 EscaparSQL(loc_cValAtual) + "%' OR dfors LIKE '" + ;
2409:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY dfors", ;
2410:                 "cursor_4c_FornBusca")
2411: 
2412:             IF loc_nRet <= 0 OR !USED("cursor_4c_FornBusca") OR EOF("cursor_4c_FornBusca")
2413:                 IF USED("cursor_4c_FornBusca")
2414:                     USE IN cursor_4c_FornBusca
2415:                 ENDIF
2416:                 SQLEXEC(gnConnHandle, "SELECT ifors, dfors FROM SigCdFor ORDER BY dfors", ;
2417:                     "cursor_4c_FornBusca")
2418:             ENDIF
2419: 
2420:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2421:             IF VARTYPE(loc_oBusca) = "O"
2422:                 loc_oBusca.DefinirCursor("cursor_4c_FornBusca", "ifors", "dfors", ;
2423:                     "Buscar Fornecedor")
2424:                 loc_oBusca.Mostrar()
2425: 
2426:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
2427:                     loc_oPg.txt_4c_Ifors.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
2428:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
2429:                 ENDIF
2430:                 loc_oBusca = .NULL.
2431:             ENDIF

