# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOEDS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: _XNRG, CPROS, CUNIS, MATPRINCS, CGRUS, PGRU, CODS, IFORS, REFFS, COLECOES, MOEMRKAPS, TPCALCPS, ACRESCS, VALORS, TPFTIOS, ARREDCS, MATS, PCOMPOS, PRODUTOS, CUSTOS, TIPOS, RESUMOS, I, 1, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, QTDS, CIDCHAVES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, TPCALCCUS, ESTIMADO, MERCS, ORDEM, ALTCOEF, USUARIOS, CODDEPTO, CODGRUPO, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, NTIPOJOALS, CESTOS, CONJUNTS, CODMACRO, CNJLACTO, USARPAS, APAGAR, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, PRODWEBS, MARCAS, OBRCONJUTS, EAN13, VLDCONJUTS, CATS, ENCOMS, MKPOBRIGS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CODIGO, CATEGORIA, CONTAS, PCESCOLHA, ETIQCDPRO, LINHAS, LNMARCKUPA, LOCLIVRE, TPCALCP, QTEQUALPS, TAG, ORDEMS, DESCRS, USUARS, CODCADS, DEPTOS, UTILACTO, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (11475 linhas total):

*-- Linhas 364 a 382:
364:             .HighlightBackColor = RGB(255, 255, 255)
365:             .HighlightForeColor = RGB(15, 41, 104)
366:             .HighlightStyle     = 2
367:             .DeleteMark         = .F.
368:             .RecordMark         = .F.
369:             .RowHeight          = 18
370:             .ScrollBars         = 3
371:             .GridLines          = 3
372:             .AllowHeaderSizing  = .F.
373:             .AllowRowSizing     = .F.
374:             .Visible            = .T.
375:         ENDWITH
376:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
377: 
378:         THIS.TornarControlesVisiveis(loc_oPagina)
379:     ENDPROC
380: 
381:     *===========================================================================
382:     * ConfigurarPaginaDados - Configura Page2: BotoesAcao + pgf_4c_Dados (8 abas)

*-- Linhas 1347 a 1398:
1347: 
1348:     *===========================================================================
1349:     * CarregarLista - Carrega dados no grid da Page1
1350:     * CRITICO: Definir ControlSources APOS RecordSource (auto-bind)
1351:     *===========================================================================
1352:     PROCEDURE CarregarLista()
1353:         LOCAL loc_lResultado, loc_oGrid
1354:         loc_lResultado = .F.
1355: 
1356:         TRY
1357:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1358:                 SET NULL ON
1359:                 CREATE CURSOR cursor_4c_Dados (cpros C(14), dpros C(65), cgrus C(3), ;
1360:                     sgrus C(6), linhas C(10), tipos C(1), situas N(1,0), ifors C(10), ;
1361:                     pvens N(11,5), pcuss N(11,5), custofs N(11,3), cunis C(3), ;
1362:                     matprincs C(14), codcors C(4), codtams C(4), reffs C(40), ;
1363:                     colecoes C(10), idpro N(10,0))
1364:                 SET NULL OFF
1365:                 loc_lResultado = .T.
1366:             ELSE
1367:                 IF !THIS.this_oBusinessObject.Buscar("")
1368:                     loc_lResultado = .F.
1369:                 ELSE
1370:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1371: 
1372:                 *-- RecordSource e ColumnCount FORA do WITH (auto-bind VFP9)
1373:                 loc_oGrid.ColumnCount  = 7
1374:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1375: 
1376:                 *-- ControlSources APOS RecordSource (OBRIGATORIO - auto-bind sobrescreve)
1377:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
1378:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
1379:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
1380:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.sgrus"
1381:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.reffs"
1382:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.colecoes"
1383:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.situas"
1384: 
1385:                 *-- Widths (originais: 110, 408, 40, 70, 150, 100, 16)
1386:                 loc_oGrid.Column1.Width = 110
1387:                 loc_oGrid.Column2.Width = 408
1388:                 loc_oGrid.Column3.Width = 40
1389:                 loc_oGrid.Column4.Width = 70
1390:                 loc_oGrid.Column5.Width = 150
1391:                 loc_oGrid.Column6.Width = 100
1392:                 loc_oGrid.Column7.Width = 40
1393: 
1394:                 *-- Headers APOS RecordSource (RecordSource reseta captions)
1395:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1396:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1397:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
1398:                 loc_oGrid.Column4.Header1.Caption = "Subgrp."

*-- Linhas 1499 a 1517:
1499:         loc_cCodigo = ""
1500: 
1501:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1502:             SELECT cursor_4c_Dados
1503:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
1504:         ENDIF
1505: 
1506:         IF EMPTY(loc_cCodigo)
1507:             MsgAviso("Selecione um produto para visualizar.")
1508:         ELSE
1509:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1510:                 THIS.this_cModoAtual = "VISUALIZAR"
1511:                 THIS.BOParaForm()
1512:                 THIS.HabilitarCampos(.F.)
1513:                 THIS.AjustarBotoesPorModo()
1514:                 THIS.AlternarPagina(2)
1515:             ENDIF
1516:         ENDIF
1517:     ENDPROC

*-- Linhas 1525 a 1543:
1525:         loc_cCodigo = ""
1526: 
1527:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1528:             SELECT cursor_4c_Dados
1529:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
1530:         ENDIF
1531: 
1532:         IF EMPTY(loc_cCodigo)
1533:             MsgAviso("Selecione um produto para alterar.")
1534:         ELSE
1535:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1536:                 THIS.this_oBusinessObject.EditarRegistro()
1537:                 THIS.this_cModoAtual = "ALTERAR"
1538:                 THIS.BOParaForm()
1539:                 THIS.HabilitarCampos(.T.)
1540:                 THIS.AjustarBotoesPorModo()
1541:                 THIS.AlternarPagina(2)
1542:             ENDIF
1543:         ENDIF

*-- Linhas 1553 a 1571:
1553:         loc_cDescricao = ""
1554: 
1555:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1556:             SELECT cursor_4c_Dados
1557:             loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cpros)
1558:             loc_cDescricao = ALLTRIM(cursor_4c_Dados.dpros)
1559:         ENDIF
1560: 
1561:         IF EMPTY(loc_cCodigo)
1562:             MsgAviso("Selecione um produto para excluir.")
1563:         ELSE
1564:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1565:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto [" + ;
1566:                     loc_cCodigo + "] - " + loc_cDescricao + "?", ;
1567:                     "Confirmar Exclus" + CHR(227) + "o")
1568:                     IF THIS.this_oBusinessObject.Excluir()
1569:                         MsgInfo("Produto exclu" + CHR(237) + "do com sucesso!")
1570:                         THIS.CarregarLista()
1571:                     ENDIF

*-- Linhas 1583 a 1624:
1583:         loc_cCodigo = ""
1584: 
1585:         TRY
1586:             loc_nRet = SQLEXEC(gnConnHandle, ;
1587:                 "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros", ;
1588:                 "cursor_4c_BuscaProduto")
1589: 
1590:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaProduto")
1591:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1592:                 IF VARTYPE(loc_oBusca) = "O"
1593:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaProduto"
1594:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaProduto", "cpros", "dpros", ;
1595:                         "Buscar Produto")
1596:                     loc_oBusca.Mostrar()
1597:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado)
1598:                         loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1599:                     ENDIF
1600:                     loc_oBusca = .NULL.
1601:                 ENDIF
1602:             ENDIF
1603: 
1604:             IF USED("cursor_4c_BuscaProduto")
1605:                 USE IN cursor_4c_BuscaProduto
1606:             ENDIF
1607: 
1608:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
1609:                 SELECT cursor_4c_Dados
1610:                 LOCATE FOR ALLTRIM(cpros) == loc_cCodigo
1611:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1612:             ENDIF
1613: 
1614:         CATCH TO loException
1615:             IF USED("cursor_4c_BuscaProduto")
1616:                 USE IN cursor_4c_BuscaProduto
1617:             ENDIF
1618:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, ;
1619:                 "FormProduto.BtnBuscarClick")
1620:         ENDTRY
1621:     ENDPROC
1622: 
1623:     *===========================================================================
1624:     * BtnEncerrarClick - Fecha o formulario

*-- Linhas 1798 a 1816:
1798:                 *-- Flush obs do EditBox para o cursor da linha selecionada antes de salvar
1799:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase") AND ;
1800:                         PEMSTATUS(loc_oPgFP, "edt_4c_Obs", 5)
1801:                     SELECT cursor_4c_GradFase
1802:                     REPLACE cursor_4c_GradFase.obs WITH loc_oPgFP.edt_4c_Obs.Value
1803:                 ENDIF
1804:             ENDIF
1805: 
1806:             *-- Campos da aba Dados Fiscais (Page3 de pgf_4c_Dados)
1807:             LOCAL loc_oPgFisc, loc_nIpiIdx
1808:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
1809:             IF PEMSTATUS(loc_oPgFisc, "txt_4c_Clfiscal", 5)
1810:                 loc_oBO.this_cClfiscals  = ALLTRIM(loc_oPgFisc.txt_4c_Clfiscal.Value)
1811:                 loc_oBO.this_cOrigmercs  = ALLTRIM(loc_oPgFisc.txt_4c_Origmerc.Value)
1812:                 loc_oBO.this_cSittricms  = ALLTRIM(loc_oPgFisc.txt_4c_Sittricm.Value)
1813:                 loc_oBO.this_nIcms       = loc_oPgFisc.txt_4c_Icms.Value
1814:                 loc_oBO.this_cTptribs    = ALLTRIM(loc_oPgFisc.txt_4c_TpTrib.Value)
1815:                 loc_oBO.this_cIats       = ALLTRIM(loc_oPgFisc.txt_4c_Iat.Value)
1816:                 loc_oBO.this_nAliqipis   = loc_oPgFisc.txt_4c_AliqIPI.Value

*-- Linhas 2069 a 2158:
2069:             *-- Grupo (SigCdGrp: cgrus/dgrus)
2070:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
2071:             IF !EMPTY(loc_cCod)
2072:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2073:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
2074:                     "cursor_4c_LkpDesc")
2075:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2076:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_LkpDesc.dgrus)
2077:                 ENDIF
2078:                 IF USED("cursor_4c_LkpDesc")
2079:                     USE IN cursor_4c_LkpDesc
2080:                 ENDIF
2081:             ENDIF
2082: 
2083:             *-- Linha (SigCdLin: linhas/descs)
2084:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
2085:             IF !EMPTY(loc_cCod)
2086:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2087:                     "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
2088:                     "cursor_4c_LkpDesc")
2089:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2090:                     loc_oPg.txt_4c_DLinhas.Value = ALLTRIM(cursor_4c_LkpDesc.descs)
2091:                 ENDIF
2092:                 IF USED("cursor_4c_LkpDesc")
2093:                     USE IN cursor_4c_LkpDesc
2094:                 ENDIF
2095:             ENDIF
2096: 
2097:             *-- Colecao/Grupo de Venda (SigCdCol: colecoes/descs)
2098:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
2099:             IF !EMPTY(loc_cCod)
2100:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2101:                     "SELECT descs FROM SigCdCol WHERE colecoes = " + EscaparSQL(loc_cCod), ;
2102:                     "cursor_4c_LkpDesc")
2103:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2104:                     loc_oPg.txt_4c_DColecoes.Value = ALLTRIM(cursor_4c_LkpDesc.descs)
2105:                 ENDIF
2106:                 IF USED("cursor_4c_LkpDesc")
2107:                     USE IN cursor_4c_LkpDesc
2108:                 ENDIF
2109:             ENDIF
2110: 
2111:             *-- Fornecedor (SigCdFor: ifors/dfors)
2112:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
2113:             IF !EMPTY(loc_cCod)
2114:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2115:                     "SELECT dfors FROM SigCdFor WHERE ifors = " + EscaparSQL(loc_cCod), ;
2116:                     "cursor_4c_LkpDesc")
2117:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2118:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_LkpDesc.dfors)
2119:                 ENDIF
2120:                 IF USED("cursor_4c_LkpDesc")
2121:                     USE IN cursor_4c_LkpDesc
2122:                 ENDIF
2123:             ENDIF
2124: 
2125:             *-- Acabamento (SigCdAca: cods/descrs)
2126:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcbs.Value)
2127:             IF !EMPTY(loc_cCod)
2128:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2129:                     "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
2130:                     "cursor_4c_LkpDesc")
2131:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2132:                     loc_oPg.txt_4c_DAcbs.Value = ALLTRIM(cursor_4c_LkpDesc.descrs)
2133:                 ENDIF
2134:                 IF USED("cursor_4c_LkpDesc")
2135:                     USE IN cursor_4c_LkpDesc
2136:                 ENDIF
2137:             ENDIF
2138: 
2139:             *-- Unidade (SigCdUni: cunis/dunis)
2140:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)
2141:             IF !EMPTY(loc_cCod)
2142:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2143:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
2144:                     "cursor_4c_LkpDesc")
2145:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2146:                     loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_LkpDesc.dunis)
2147:                 ENDIF
2148:                 IF USED("cursor_4c_LkpDesc")
2149:                     USE IN cursor_4c_LkpDesc
2150:                 ENDIF
2151:             ENDIF
2152: 
2153:         CATCH TO loException
2154:             IF USED("cursor_4c_LkpDesc")
2155:                 USE IN cursor_4c_LkpDesc
2156:             ENDIF
2157:             MostrarErro("Erro ao carregar descri" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
2158:                 loException.Message, "FormProduto.CarregarDescricoes")

*-- Linhas 2174 a 2250:
2174:             *-- Classificacao Fiscal (SigCdClf: codigos/descricaos)
2175:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
2176:             IF !EMPTY(loc_cCod)
2177:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2178:                     "SELECT descricaos FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cCod), ;
2179:                     "cursor_4c_LkpFiscDesc")
2180:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
2181:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descricaos)
2182:                 ENDIF
2183:                 IF USED("cursor_4c_LkpFiscDesc")
2184:                     USE IN cursor_4c_LkpFiscDesc
2185:                 ENDIF
2186:             ENDIF
2187: 
2188:             *-- Origem Mercadoria (SIGCDORG: codigos/descricaos)
2189:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
2190:             IF !EMPTY(loc_cCod)
2191:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2192:                     "SELECT descricaos FROM SIGCDORG WHERE codigos = " + EscaparSQL(loc_cCod), ;
2193:                     "cursor_4c_LkpFiscDesc")
2194:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
2195:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descricaos)
2196:                 ENDIF
2197:                 IF USED("cursor_4c_LkpFiscDesc")
2198:                     USE IN cursor_4c_LkpFiscDesc
2199:                 ENDIF
2200:             ENDIF
2201: 
2202:             *-- Situacao Tributaria ICMS (SIGCDICM: codigos/descricaos)
2203:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
2204:             IF !EMPTY(loc_cCod)
2205:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2206:                     "SELECT descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
2207:                     "cursor_4c_LkpFiscDesc")
2208:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
2209:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descricaos)
2210:                 ENDIF
2211:                 IF USED("cursor_4c_LkpFiscDesc")
2212:                     USE IN cursor_4c_LkpFiscDesc
2213:                 ENDIF
2214:             ENDIF
2215: 
2216:             *-- Metal (SigCdMtl: codigos/descs WHERE tipos='M')
2217:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Metal.Value)
2218:             IF !EMPTY(loc_cCod)
2219:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2220:                     "SELECT descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
2221:                     " AND tipos = 'M'", ;
2222:                     "cursor_4c_LkpFiscDesc")
2223:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
2224:                     loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descs)
2225:                 ENDIF
2226:                 IF USED("cursor_4c_LkpFiscDesc")
2227:                     USE IN cursor_4c_LkpFiscDesc
2228:                 ENDIF
2229:             ENDIF
2230: 
2231:             *-- Teor (SigCdMtl: codigos/descs WHERE tipos<>'M')
2232:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Teor.Value)
2233:             IF !EMPTY(loc_cCod)
2234:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2235:                     "SELECT descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
2236:                     " AND tipos <> 'M'", ;
2237:                     "cursor_4c_LkpFiscDesc")
2238:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
2239:                     loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descs)
2240:                 ENDIF
2241:                 IF USED("cursor_4c_LkpFiscDesc")
2242:                     USE IN cursor_4c_LkpFiscDesc
2243:                 ENDIF
2244:             ENDIF
2245: 
2246:         CATCH TO loException
2247:             IF USED("cursor_4c_LkpFiscDesc")
2248:                 USE IN cursor_4c_LkpFiscDesc
2249:             ENDIF
2250:             MostrarErro("Erro ao carregar descri" + CHR(231) + CHR(245) + "es fiscais:" + CHR(13) + ;

*-- Linhas 2315 a 2334:
2315:             IF EMPTY(loc_cCod)
2316:                 loc_oPg.txt_4c_Dgrus.Value = ""
2317:             ELSE
2318:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2319:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
2320:                     "cursor_4c_LkpCgrus")
2321: 
2322:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpCgrus") AND !EOF("cursor_4c_LkpCgrus")
2323:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_LkpCgrus.dgrus)
2324:                     USE IN cursor_4c_LkpCgrus
2325:                 ELSE
2326:                     IF USED("cursor_4c_LkpCgrus")
2327:                         USE IN cursor_4c_LkpCgrus
2328:                     ENDIF
2329:                     loc_oPg.txt_4c_Cgrus.Value = ""
2330:                     loc_oPg.txt_4c_Dgrus.Value = ""
2331:                     THIS.AbrirBuscaGrupo()
2332:                 ENDIF
2333:             ENDIF
2334: 

*-- Linhas 2364 a 2383:
2364:             IF EMPTY(loc_cCod)
2365:                 loc_oPg.txt_4c_DLinhas.Value = ""
2366:             ELSE
2367:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2368:                     "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
2369:                     "cursor_4c_LkpLinha")
2370: 
2371:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpLinha") AND !EOF("cursor_4c_LkpLinha")
2372:                     loc_oPg.txt_4c_DLinhas.Value = ALLTRIM(cursor_4c_LkpLinha.descs)
2373:                     USE IN cursor_4c_LkpLinha
2374:                 ELSE
2375:                     IF USED("cursor_4c_LkpLinha")
2376:                         USE IN cursor_4c_LkpLinha
2377:                     ENDIF
2378:                     loc_oPg.txt_4c_Linhas.Value  = ""
2379:                     loc_oPg.txt_4c_DLinhas.Value = ""
2380:                     MsgAviso("Linha n" + CHR(227) + "o encontrada.")
2381:                 ENDIF
2382:             ENDIF
2383: 

*-- Linhas 2403 a 2422:
2403:             IF EMPTY(loc_cCod)
2404:                 loc_oPg.txt_4c_DColecoes.Value = ""
2405:             ELSE
2406:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2407:                     "SELECT descs FROM SigCdCol WHERE colecoes = " + EscaparSQL(loc_cCod), ;
2408:                     "cursor_4c_LkpColecao")
2409: 
2410:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpColecao") AND !EOF("cursor_4c_LkpColecao")
2411:                     loc_oPg.txt_4c_DColecoes.Value = ALLTRIM(cursor_4c_LkpColecao.descs)
2412:                     USE IN cursor_4c_LkpColecao
2413:                 ELSE
2414:                     IF USED("cursor_4c_LkpColecao")
2415:                         USE IN cursor_4c_LkpColecao
2416:                     ENDIF
2417:                     loc_oPg.txt_4c_Colecoes.Value  = ""
2418:                     loc_oPg.txt_4c_DColecoes.Value = ""
2419:                     MsgAviso("Grupo de venda n" + CHR(227) + "o encontrado.")
2420:                 ENDIF
2421:             ENDIF
2422: 

*-- Linhas 2442 a 2461:
2442:             IF EMPTY(loc_cCod)
2443:                 loc_oPg.txt_4c_Dfors.Value = ""
2444:             ELSE
2445:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2446:                     "SELECT dfors FROM SigCdFor WHERE ifors = " + EscaparSQL(loc_cCod), ;
2447:                     "cursor_4c_LkpForn")
2448: 
2449:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpForn") AND !EOF("cursor_4c_LkpForn")
2450:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_LkpForn.dfors)
2451:                     USE IN cursor_4c_LkpForn
2452:                 ELSE
2453:                     IF USED("cursor_4c_LkpForn")
2454:                         USE IN cursor_4c_LkpForn
2455:                     ENDIF
2456:                     loc_oPg.txt_4c_Ifors.Value = ""
2457:                     loc_oPg.txt_4c_Dfors.Value = ""
2458:                     THIS.AbrirBuscaFornecedor()
2459:                 ENDIF
2460:             ENDIF
2461: 

*-- Linhas 2479 a 2498:
2479:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodCors.Value)
2480: 
2481:             IF !EMPTY(loc_cCod)
2482:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2483:                     "SELECT cods FROM SigCdCor WHERE cods = " + EscaparSQL(loc_cCod), ;
2484:                     "cursor_4c_LkpCor")
2485: 
2486:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpCor") AND !EOF("cursor_4c_LkpCor")
2487:                     USE IN cursor_4c_LkpCor
2488:                 ELSE
2489:                     IF USED("cursor_4c_LkpCor")
2490:                         USE IN cursor_4c_LkpCor
2491:                     ENDIF
2492:                     loc_oPg.txt_4c_CodCors.Value = ""
2493:                     MsgAviso("Cor n" + CHR(227) + "o encontrada.")
2494:                 ENDIF
2495:             ENDIF
2496: 
2497:         CATCH TO loException
2498:             IF USED("cursor_4c_LkpCor")

*-- Linhas 2514 a 2533:
2514:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodTams.Value)
2515: 
2516:             IF !EMPTY(loc_cCod)
2517:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2518:                     "SELECT cods FROM SigCdTam WHERE cods = " + EscaparSQL(loc_cCod), ;
2519:                     "cursor_4c_LkpTam")
2520: 
2521:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpTam") AND !EOF("cursor_4c_LkpTam")
2522:                     USE IN cursor_4c_LkpTam
2523:                 ELSE
2524:                     IF USED("cursor_4c_LkpTam")
2525:                         USE IN cursor_4c_LkpTam
2526:                     ENDIF
2527:                     loc_oPg.txt_4c_CodTams.Value = ""
2528:                     MsgAviso("Tamanho n" + CHR(227) + "o encontrado.")
2529:                 ENDIF
2530:             ENDIF
2531: 
2532:         CATCH TO loException
2533:             IF USED("cursor_4c_LkpTam")

*-- Linhas 2551 a 2570:
2551:             IF EMPTY(loc_cCod)
2552:                 loc_oPg.txt_4c_DAcbs.Value = ""
2553:             ELSE
2554:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2555:                     "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
2556:                     "cursor_4c_LkpAcab")
2557: 
2558:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpAcab") AND !EOF("cursor_4c_LkpAcab")
2559:                     loc_oPg.txt_4c_DAcbs.Value = ALLTRIM(cursor_4c_LkpAcab.descrs)
2560:                     USE IN cursor_4c_LkpAcab
2561:                 ELSE
2562:                     IF USED("cursor_4c_LkpAcab")
2563:                         USE IN cursor_4c_LkpAcab
2564:                     ENDIF
2565:                     loc_oPg.txt_4c_CodAcbs.Value = ""
2566:                     loc_oPg.txt_4c_DAcbs.Value   = ""
2567:                     MsgAviso("Acabamento n" + CHR(227) + "o encontrado.")
2568:                 ENDIF
2569:             ENDIF
2570: 

*-- Linhas 2590 a 2609:
2590:             IF EMPTY(loc_cCod)
2591:                 loc_oPg.txt_4c_Dunis.Value = ""
2592:             ELSE
2593:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2594:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
2595:                     "cursor_4c_LkpUni")
2596: 
2597:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpUni") AND !EOF("cursor_4c_LkpUni")
2598:                     loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_LkpUni.dunis)
2599:                     USE IN cursor_4c_LkpUni
2600:                 ELSE
2601:                     IF USED("cursor_4c_LkpUni")
2602:                         USE IN cursor_4c_LkpUni
2603:                     ENDIF
2604:                     loc_oPg.txt_4c_Cunis.Value = ""
2605:                     loc_oPg.txt_4c_Dunis.Value = ""
2606:                     MsgAviso("Unidade n" + CHR(227) + "o encontrada.")
2607:                 ENDIF
2608:             ENDIF
2609: 

*-- Linhas 2626 a 2653:
2626:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2627:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
2628: 
2629:             loc_nRet = SQLEXEC(gnConnHandle, ;
2630:                 "SELECT cgrus, dgrus FROM SigCdGrp WHERE cgrus LIKE '" + ;
2631:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cgrus", ;
2632:                 "cursor_4c_GrpBusca")
2633: 
2634:             IF loc_nRet <= 0 OR !USED("cursor_4c_GrpBusca") OR EOF("cursor_4c_GrpBusca")
2635:                 IF USED("cursor_4c_GrpBusca")
2636:                     USE IN cursor_4c_GrpBusca
2637:                 ENDIF
2638:                 SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", ;
2639:                     "cursor_4c_GrpBusca")
2640:             ENDIF
2641: 
2642:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2643:             IF VARTYPE(loc_oBusca) = "O"
2644:                 loc_oBusca.this_cCursorDestino = "cursor_4c_GrpBusca"
2645:                 loc_oBusca.DefinirCursor("cursor_4c_GrpBusca", "cgrus", "dgrus", ;
2646:                     "Buscar Grupo de Produto")
2647:                 loc_oBusca.Mostrar()
2648: 
2649:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
2650:                     loc_oPg.txt_4c_Cgrus.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
2651:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
2652:                 ENDIF
2653:                 loc_oBusca = .NULL.

*-- Linhas 2676 a 2703:
2676:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2677:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
2678: 
2679:             loc_nRet = SQLEXEC(gnConnHandle, ;
2680:                 "SELECT ifors, dfors FROM SigCdFor WHERE ifors LIKE '" + ;
2681:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY dfors", ;
2682:                 "cursor_4c_FornBusca")
2683: 
2684:             IF loc_nRet <= 0 OR !USED("cursor_4c_FornBusca") OR EOF("cursor_4c_FornBusca")
2685:                 IF USED("cursor_4c_FornBusca")
2686:                     USE IN cursor_4c_FornBusca
2687:                 ENDIF
2688:                 SQLEXEC(gnConnHandle, "SELECT ifors, dfors FROM SigCdFor ORDER BY dfors", ;
2689:                     "cursor_4c_FornBusca")
2690:             ENDIF
2691: 
2692:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2693:             IF VARTYPE(loc_oBusca) = "O"
2694:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FornBusca"
2695:                 loc_oBusca.DefinirCursor("cursor_4c_FornBusca", "ifors", "dfors", ;
2696:                     "Buscar Fornecedor")
2697:                 loc_oBusca.Mostrar()
2698: 
2699:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
2700:                     loc_oPg.txt_4c_Ifors.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
2701:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
2702:                 ENDIF
2703:                 loc_oBusca = .NULL.

*-- Linhas 2764 a 2782:
2764:             *-- Cursor placeholder para grd_4c_Cmv (RecordSource = TotGrupo2)
2765:             IF !USED("cursor_4c_TotGrupo2")
2766:                 SET NULL ON
2767:                 CREATE CURSOR cursor_4c_TotGrupo2 ( ;
2768:                     Grupo    C(3), ValGrupo N(12,3), Moeda C(3), Estimado N(1,0))
2769:                 SET NULL OFF
2770:             ENDIF
2771: 
2772:             *====================================================================
2773:             *  SECAO: Configuracao / Tipo produto (topo)
2774:             *====================================================================
2775: 
2776:             *-- lbl_4c_Label29: "Configuracao :" (Say29, top=128, left=129)
2777:             loc_oPg.AddObject("lbl_4c_Label29", "Label")
2778:             WITH loc_oPg.lbl_4c_Label29
2779:                 .Caption   = "Configura" + CHR(231) + CHR(227) + "o :"
2780:                 .Top       = 128
2781:                 .Left      = 129
2782:                 .Width     = 73

*-- Linhas 2790 a 2808:
2790:             ENDWITH
2791: 
2792:             *-- obj_4c_Fwoption1: OptionGroup "Importado / Nacional" (Fwoption1, top=123, left=204)
2793:             *-- ControlSource: TpCodPro (nao existe no schema atual - UI-only)
2794:             loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
2795:             WITH loc_oPg.obj_4c_Fwoption1
2796:                 .ButtonCount  = 2
2797:                 .Top          = 123
2798:                 .Left         = 204
2799:                 .Width        = 151
2800:                 .Height       = 24
2801:                 .BackStyle    = 0
2802:                 .BorderStyle  = 0
2803:                 .Value        = 1
2804:                 .AutoSize     = .F.
2805:                 .Visible      = .T.
2806: 
2807:                 .Buttons(1).Caption   = "Importado"
2808:                 .Buttons(1).FontName  = "Tahoma"

*-- Linhas 3518 a 3563:
3518:                 .FontSize   = 8
3519:                 .RecordMark = .T.
3520:                 .RowHeight  = 17
3521:                 .DeleteMark = .F.
3522:                 .ReadOnly   = .T.
3523:                 .Visible    = .T.
3524:             ENDWITH
3525:             loc_oPg.grd_4c_Cmv.ColumnCount  = 3
3526:             loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_TotGrupo2"
3527:             loc_oGrid = loc_oPg.grd_4c_Cmv
3528: 
3529:             loc_oGrid.Column1.ControlSource   = "cursor_4c_TotGrupo2.Grupo"
3530:             loc_oGrid.Column1.Width           = 59
3531:             loc_oGrid.Column1.Movable         = .F.
3532:             loc_oGrid.Column1.Resizable       = .F.
3533:             loc_oGrid.Column1.ReadOnly        = .T.
3534:             loc_oGrid.Column1.FontName        = "Courier New"
3535:             loc_oGrid.Column1.FontSize        = 8
3536:             loc_oGrid.Column1.Header1.Caption = "Per" + CHR(237) + "odo"
3537: 
3538:             loc_oGrid.Column2.ControlSource   = "cursor_4c_TotGrupo2.ValGrupo"
3539:             loc_oGrid.Column2.Width           = 100
3540:             loc_oGrid.Column2.Movable         = .F.
3541:             loc_oGrid.Column2.Resizable       = .F.
3542:             loc_oGrid.Column2.ReadOnly        = .T.
3543:             loc_oGrid.Column2.InputMask       = "999,999,999.999"
3544:             loc_oGrid.Column2.FontName        = "Courier New"
3545:             loc_oGrid.Column2.FontSize        = 8
3546:             loc_oGrid.Column2.Header1.Caption = "Valor Custo GR"
3547: 
3548:             loc_oGrid.Column3.ControlSource   = "cursor_4c_TotGrupo2.Moeda"
3549:             loc_oGrid.Column3.Width           = 31
3550:             loc_oGrid.Column3.ReadOnly        = .T.
3551:             loc_oGrid.Column3.Header1.Caption = "Moe"
3552: 
3553:             *====================================================================
3554:             *  SECAO: Descricao ECF / Metal / Teor
3555:             *====================================================================
3556: 
3557:             *-- lbl_4c_Label12: "Descricao ECF :" (Say12, top=497, left=125)
3558:             loc_oPg.AddObject("lbl_4c_Label12", "Label")
3559:             WITH loc_oPg.lbl_4c_Label12
3560:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o ECF :"
3561:                 .Top       = 497
3562:                 .Left      = 125
3563:                 .Width     = 77

*-- Linhas 3779 a 3806:
3779:             *-- Reutiliza cursor_4c_GrdCompo e TotGrupo criados por pgComposicao se existirem
3780:             IF !USED("cursor_4c_GrdCompo")
3781:                 SET NULL ON
3782:                 CREATE CURSOR cursor_4c_GrdCompo ( ;
3783:                     cpros    C(14), dpros    C(65),  cunis  C(5),  ;
3784:                     valor    N(14,3), qtdes  N(10,3), total N(14,3), ;
3785:                     moeda    C(3),  obs      C(80),  estoc  C(1),   ;
3786:                     consumo  N(10,0), qtdes2 N(10,3), cunis2 C(5),  ;
3787:                     ords     N(5,0), matprinc C(14))
3788:                 SET NULL OFF
3789:             ENDIF
3790:             IF !USED("TotGrupo")
3791:                 CREATE CURSOR TotGrupo (Grupo C(10), ValGrupo N(14,3), Moeda C(3))
3792:             ENDIF
3793: 
3794:             *-- lbl_4c_Label1: "Tipo :" (Say1, top=159, left=107)
3795:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
3796:             WITH loc_oPg.lbl_4c_Label1
3797:                 .Caption   = "Tipo :"
3798:                 .Top       = 159
3799:                 .Left      = 107
3800:                 .Width     = 29
3801:                 .Height    = 15
3802:                 .FontName  = "Tahoma"
3803:                 .FontSize  = 8
3804:                 .ForeColor = RGB(90, 90, 90)
3805:                 .BackStyle = 0
3806:                 .AutoSize  = .T.

*-- Linhas 3834 a 3934:
3834:                 .RecordMark = .F.
3835:                 .RowHeight  = 16
3836:                 .ScrollBars = 2
3837:                 .DeleteMark = .F.
3838:                 .Visible    = .T.
3839:             ENDWITH
3840:             loc_oPg.grd_4c_GrdCusto.ColumnCount  = 12
3841:             loc_oPg.grd_4c_GrdCusto.RecordSource = "cursor_4c_GrdCompo"
3842:             loc_oGrid = loc_oPg.grd_4c_GrdCusto
3843: 
3844:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdCompo.cpros"
3845:             loc_oGrid.Column1.Width           = 90
3846:             loc_oGrid.Column1.ColumnOrder     = 1
3847:             loc_oGrid.Column1.Movable         = .F.
3848:             loc_oGrid.Column1.Resizable       = .F.
3849:             loc_oGrid.Column1.Header1.Caption = "Item"
3850: 
3851:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdCompo.dpros"
3852:             loc_oGrid.Column2.Width           = 175
3853:             loc_oGrid.Column2.ColumnOrder     = 2
3854:             loc_oGrid.Column2.Movable         = .F.
3855:             loc_oGrid.Column2.Resizable       = .F.
3856:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3857: 
3858:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdCompo.cunis"
3859:             loc_oGrid.Column3.Width           = 30
3860:             loc_oGrid.Column3.ColumnOrder     = 3
3861:             loc_oGrid.Column3.Movable         = .F.
3862:             loc_oGrid.Column3.Resizable       = .F.
3863:             loc_oGrid.Column3.Header1.Caption = "Un"
3864: 
3865:             loc_oGrid.Column4.ControlSource   = "cursor_4c_GrdCompo.valor"
3866:             loc_oGrid.Column4.Width           = 75
3867:             loc_oGrid.Column4.ColumnOrder     = 4
3868:             loc_oGrid.Column4.Movable         = .F.
3869:             loc_oGrid.Column4.Resizable       = .F.
3870:             loc_oGrid.Column4.InputMask       = "9999999.999"
3871:             loc_oGrid.Column4.Header1.Caption = "Valor"
3872: 
3873:             loc_oGrid.Column5.ControlSource   = "cursor_4c_GrdCompo.qtdes"
3874:             loc_oGrid.Column5.Width           = 55
3875:             loc_oGrid.Column5.ColumnOrder     = 5
3876:             loc_oGrid.Column5.Movable         = .F.
3877:             loc_oGrid.Column5.Resizable       = .F.
3878:             loc_oGrid.Column5.InputMask       = "9999.999"
3879:             loc_oGrid.Column5.Header1.Caption = "Qtd"
3880: 
3881:             loc_oGrid.Column6.ControlSource   = "cursor_4c_GrdCompo.total"
3882:             loc_oGrid.Column6.Width           = 75
3883:             loc_oGrid.Column6.ColumnOrder     = 6
3884:             loc_oGrid.Column6.Movable         = .F.
3885:             loc_oGrid.Column6.Resizable       = .F.
3886:             loc_oGrid.Column6.InputMask       = "9999999.999"
3887:             loc_oGrid.Column6.Header1.Caption = "Total"
3888: 
3889:             loc_oGrid.Column7.ControlSource   = "cursor_4c_GrdCompo.moeda"
3890:             loc_oGrid.Column7.Width           = 30
3891:             loc_oGrid.Column7.ColumnOrder     = 7
3892:             loc_oGrid.Column7.Header1.Caption = "Moe"
3893: 
3894:             loc_oGrid.Column8.ControlSource   = "cursor_4c_GrdCompo.obs"
3895:             loc_oGrid.Column8.Width           = 100
3896:             loc_oGrid.Column8.ColumnOrder     = 8
3897:             loc_oGrid.Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
3898: 
3899:             loc_oGrid.Column9.ControlSource   = "cursor_4c_GrdCompo.estoc"
3900:             loc_oGrid.Column9.Width           = 25
3901:             loc_oGrid.Column9.ColumnOrder     = 9
3902:             loc_oGrid.Column9.Format          = "M"
3903:             loc_oGrid.Column9.InputMask       = "N,S"
3904:             loc_oGrid.Column9.Header1.Caption = "Etiq"
3905: 
3906:             loc_oGrid.Column10.ControlSource   = "cursor_4c_GrdCompo.consumo"
3907:             loc_oGrid.Column10.Width           = 55
3908:             loc_oGrid.Column10.ColumnOrder     = 10
3909:             loc_oGrid.Column10.InputMask       = "99999"
3910:             loc_oGrid.Column10.Header1.Caption = "Consumo"
3911: 
3912:             loc_oGrid.Column11.ControlSource   = "cursor_4c_GrdCompo.qtdes2"
3913:             loc_oGrid.Column11.Width           = 55
3914:             loc_oGrid.Column11.ColumnOrder     = 11
3915:             loc_oGrid.Column11.Movable         = .F.
3916:             loc_oGrid.Column11.Resizable       = .F.
3917:             loc_oGrid.Column11.Header1.Caption = "Qtd"
3918: 
3919:             loc_oGrid.Column12.ControlSource   = "cursor_4c_GrdCompo.cunis2"
3920:             loc_oGrid.Column12.Width           = 30
3921:             loc_oGrid.Column12.ColumnOrder     = 12
3922:             loc_oGrid.Column12.Movable         = .F.
3923:             loc_oGrid.Column12.Resizable       = .F.
3924:             loc_oGrid.Column12.ReadOnly        = .T.
3925:             loc_oGrid.Column12.Header1.Caption = "Un"
3926: 
3927:             BINDEVENT(loc_oPg.grd_4c_GrdCusto, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")
3928: 
3929:             *-- cmg_4c_CmdgCusto: 2 botoes de controle (cmdgCompo, top=240, left=851)
3930:             loc_oPg.AddObject("cmg_4c_CmdgCusto", "CommandGroup")
3931:             WITH loc_oPg.cmg_4c_CmdgCusto
3932:                 .Top         = 240
3933:                 .Left        = 851
3934:                 .Width       = 50

*-- Linhas 4065 a 4109:
4065:                 .Height       = 141
4066:                 .FontName     = "Verdana"
4067:                 .FontSize     = 8
4068:                 .DeleteMark   = .F.
4069:                 .HeaderHeight = 14
4070:                 .ReadOnly     = .T.
4071:                 .RecordMark   = .F.
4072:                 .RowHeight    = 16
4073:                 .Visible      = .T.
4074:             ENDWITH
4075:             loc_oPg.grd_4c_GradeGrupo2.ColumnCount  = 3
4076:             loc_oPg.grd_4c_GradeGrupo2.RecordSource = "TotGrupo"
4077:             loc_oGrid2 = loc_oPg.grd_4c_GradeGrupo2
4078: 
4079:             loc_oGrid2.Column1.ControlSource   = "TotGrupo.Grupo"
4080:             loc_oGrid2.Column1.Width           = 35
4081:             loc_oGrid2.Column1.Movable         = .F.
4082:             loc_oGrid2.Column1.Resizable       = .F.
4083:             loc_oGrid2.Column1.ReadOnly        = .T.
4084:             loc_oGrid2.Column1.Header1.Caption = "Grp"
4085: 
4086:             loc_oGrid2.Column2.ControlSource   = "TotGrupo.ValGrupo"
4087:             loc_oGrid2.Column2.Width           = 120
4088:             loc_oGrid2.Column2.Movable         = .F.
4089:             loc_oGrid2.Column2.Resizable       = .F.
4090:             loc_oGrid2.Column2.ReadOnly        = .T.
4091:             loc_oGrid2.Column2.InputMask       = "999,999,999.999"
4092:             loc_oGrid2.Column2.Header1.Caption = "Total"
4093: 
4094:             loc_oGrid2.Column3.ControlSource   = "TotGrupo.Moeda"
4095:             loc_oGrid2.Column3.Width           = 37
4096:             loc_oGrid2.Column3.Movable         = .F.
4097:             loc_oGrid2.Column3.Resizable       = .F.
4098:             loc_oGrid2.Column3.ReadOnly        = .T.
4099:             loc_oGrid2.Column3.Header1.Caption = "Moe"
4100: 
4101:         CATCH TO loc_oErro
4102:             MostrarErro("Erro ao configurar p" + CHR(225) + "gina Custos:" + ;
4103:                 CHR(13) + loc_oErro.Message, "FormProduto.ConfigurarPgpgCusto")
4104:         ENDTRY
4105:     ENDPROC
4106: 
4107:     *===========================================================================
4108:     * ConfigurarPgpgComposicao - Configura Page6 "Composicao" do pgf_4c_Dados
4109:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao

*-- Linhas 4116 a 4268:
4116:             *-- Cursors placeholder para os grids (ANTES de RecordSource)
4117:             IF !USED("cursor_4c_GrdCompo")
4118:                 SET NULL ON
4119:                 CREATE CURSOR cursor_4c_GrdCompo ( ;
4120:                     cpros    C(14), dpros   C(65), cunis   C(5),  ;
4121:                     valor    N(14,3), qtdes N(10,3), total  N(14,3), ;
4122:                     moeda    C(3),  obs    C(80),  estoc   C(1),  ;
4123:                     consumo  N(10,0), qtdes2 N(10,3), cunis2 C(5),  ;
4124:                     ords     N(5,0), matprinc C(14))
4125:                 SET NULL OFF
4126:             ENDIF
4127:             IF !USED("cursor_4c_GrdSubCp")
4128:                 SET NULL ON
4129:                 CREATE CURSOR cursor_4c_GrdSubCp ( ;
4130:                     cpros    C(14), dpros   C(65), cunis   C(5),  ;
4131:                     valor    N(14,3), qtdes N(10,3), total  N(14,3), ;
4132:                     moeda    C(3),  obs    C(80),  estoc   C(1),  ;
4133:                     consumo  N(10,0), qtdes2 N(10,3), cunis2 C(5),  ;
4134:                     ords     N(5,0), matprinc C(14), tamanho C(10))
4135:                 SET NULL OFF
4136:             ENDIF
4137:             IF !USED("cursor_4c_GrdRelogios")
4138:                 SET NULL ON
4139:                 CREATE CURSOR cursor_4c_GrdRelogios ( ;
4140:                     grp C(5), descricao C(60), produto C(14), descprod C(60))
4141:                 SET NULL OFF
4142:             ENDIF
4143:             IF !USED("TotGrupo")
4144:                 CREATE CURSOR TotGrupo (Grupo C(10), ValGrupo N(14,3), Moeda C(3))
4145:             ENDIF
4146: 
4147:             *-- grdCompo: grade principal de composicao (14 colunas)
4148:             loc_oPg.AddObject("grd_4c_GrdCompo", "Grid")
4149:             WITH loc_oPg.grd_4c_GrdCompo
4150:                 .Top        = 117
4151:                 .Left       = 6
4152:                 .Width      = 943
4153:                 .Height     = 147
4154:                 .FontName   = "Tahoma"
4155:                 .FontSize   = 8
4156:                 .RecordMark = .F.
4157:                 .RowHeight  = 16
4158:                 .ScrollBars = 2
4159:                 .TabStop    = .F.
4160:                 .Visible    = .T.
4161:             ENDWITH
4162:             loc_oPg.grd_4c_GrdCompo.ColumnCount  = 14
4163:             loc_oPg.grd_4c_GrdCompo.RecordSource = "cursor_4c_GrdCompo"
4164:             loc_oGrid = loc_oPg.grd_4c_GrdCompo
4165: 
4166:             loc_oGrid.Column1.ControlSource  = "cursor_4c_GrdCompo.cpros"
4167:             loc_oGrid.Column1.Width          = 108
4168:             loc_oGrid.Column1.ColumnOrder    = 1
4169:             loc_oGrid.Column1.Movable        = .F.
4170:             loc_oGrid.Column1.Resizable      = .F.
4171:             loc_oGrid.Column1.Header1.Caption = "Material"
4172: 
4173:             loc_oGrid.Column2.ControlSource  = "cursor_4c_GrdCompo.dpros"
4174:             loc_oGrid.Column2.Width          = 187
4175:             loc_oGrid.Column2.ColumnOrder    = 2
4176:             loc_oGrid.Column2.Movable        = .F.
4177:             loc_oGrid.Column2.Resizable      = .F.
4178:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4179: 
4180:             loc_oGrid.Column3.ControlSource  = "cursor_4c_GrdCompo.cunis"
4181:             loc_oGrid.Column3.Width          = 24
4182:             loc_oGrid.Column3.ColumnOrder    = 4
4183:             loc_oGrid.Column3.Movable        = .F.
4184:             loc_oGrid.Column3.Resizable      = .F.
4185:             loc_oGrid.Column3.Header1.Caption = "Un"
4186: 
4187:             loc_oGrid.Column4.ControlSource  = "cursor_4c_GrdCompo.valor"
4188:             loc_oGrid.Column4.Width          = 73
4189:             loc_oGrid.Column4.ColumnOrder    = 7
4190:             loc_oGrid.Column4.Movable        = .F.
4191:             loc_oGrid.Column4.Resizable      = .F.
4192:             loc_oGrid.Column4.InputMask      = "9999999.999"
4193:             loc_oGrid.Column4.Header1.Caption = "Valor"
4194: 
4195:             loc_oGrid.Column5.ControlSource  = "cursor_4c_GrdCompo.qtdes"
4196:             loc_oGrid.Column5.Width          = 59
4197:             loc_oGrid.Column5.ColumnOrder    = 3
4198:             loc_oGrid.Column5.Movable        = .F.
4199:             loc_oGrid.Column5.Resizable      = .F.
4200:             loc_oGrid.Column5.InputMask      = "9999.999"
4201:             loc_oGrid.Column5.Header1.Caption = "Qtde."
4202: 
4203:             loc_oGrid.Column6.ControlSource  = "cursor_4c_GrdCompo.total"
4204:             loc_oGrid.Column6.Width          = 58
4205:             loc_oGrid.Column6.ColumnOrder    = 9
4206:             loc_oGrid.Column6.InputMask      = "9999999.999"
4207:             loc_oGrid.Column6.Header1.Caption = "Total"
4208: 
4209:             loc_oGrid.Column7.ControlSource  = "cursor_4c_GrdCompo.moeda"
4210:             loc_oGrid.Column7.Width          = 31
4211:             loc_oGrid.Column7.ColumnOrder    = 8
4212:             loc_oGrid.Column7.Header1.Caption = "Moe"
4213: 
4214:             loc_oGrid.Column8.ControlSource  = "cursor_4c_GrdCompo.obs"
4215:             loc_oGrid.Column8.Width          = 80
4216:             loc_oGrid.Column8.ColumnOrder    = 10
4217:             loc_oGrid.Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
4218: 
4219:             loc_oGrid.Column9.ControlSource  = "cursor_4c_GrdCompo.estoc"
4220:             loc_oGrid.Column9.Width          = 14
4221:             loc_oGrid.Column9.ColumnOrder    = 12
4222:             loc_oGrid.Column9.Format         = "M"
4223:             loc_oGrid.Column9.InputMask      = "N,S"
4224:             loc_oGrid.Column9.Header1.Caption = "E"
4225: 
4226:             loc_oGrid.Column10.ControlSource  = "cursor_4c_GrdCompo.consumo"
4227:             loc_oGrid.Column10.Width          = 58
4228:             loc_oGrid.Column10.ColumnOrder    = 13
4229:             loc_oGrid.Column10.InputMask      = "99999"
4230:             loc_oGrid.Column10.Header1.Caption = "Consumo"
4231: 
4232:             loc_oGrid.Column11.ControlSource  = "cursor_4c_GrdCompo.qtdes2"
4233:             loc_oGrid.Column11.Width          = 59
4234:             loc_oGrid.Column11.ColumnOrder    = 5
4235:             loc_oGrid.Column11.Movable        = .F.
4236:             loc_oGrid.Column11.Resizable      = .F.
4237:             loc_oGrid.Column11.Header1.Caption = "Qtde."
4238: 
4239:             loc_oGrid.Column12.ControlSource  = "cursor_4c_GrdCompo.cunis2"
4240:             loc_oGrid.Column12.Width          = 24
4241:             loc_oGrid.Column12.ColumnOrder    = 6
4242:             loc_oGrid.Column12.Movable        = .F.
4243:             loc_oGrid.Column12.ReadOnly       = .T.
4244:             loc_oGrid.Column12.Header1.Caption = "Un"
4245: 
4246:             loc_oGrid.Column13.ControlSource  = "cursor_4c_GrdCompo.ords"
4247:             loc_oGrid.Column13.Width          = 24
4248:             loc_oGrid.Column13.ColumnOrder    = 14
4249:             loc_oGrid.Column13.Format         = "K"
4250:             loc_oGrid.Column13.InputMask      = "99"
4251:             loc_oGrid.Column13.Header1.Caption = "Ord"
4252: 
4253:             loc_oGrid.Column14.ControlSource  = "cursor_4c_GrdCompo.matprinc"
4254:             loc_oGrid.Column14.Width          = 108
4255:             loc_oGrid.Column14.ColumnOrder    = 11
4256:             loc_oGrid.Column14.Header1.Caption = "Material"
4257: 
4258:             *-- cmg_4c_CmdgCompo: 5 botoes de controle da composicao
4259:             loc_oPg.AddObject("cmg_4c_CmdgCompo", "CommandGroup")
4260:             WITH loc_oPg.cmg_4c_CmdgCompo
4261:                 .Top         = 114
4262:                 .Left        = 947
4263:                 .Width       = 50
4264:                 .Height      = 210
4265:                 .BackStyle   = 0
4266:                 .BorderStyle = 0
4267:                 .Value       = 1
4268:                 .BackColor   = RGB(162, 214, 242)

*-- Linhas 4340 a 4451:
4340:             loc_oPg.grd_4c_GrdSubCp.RecordSource = "cursor_4c_GrdSubCp"
4341:             loc_oGrid2 = loc_oPg.grd_4c_GrdSubCp
4342: 
4343:             loc_oGrid2.Column1.ControlSource  = "cursor_4c_GrdSubCp.cpros"
4344:             loc_oGrid2.Column1.Width          = 108
4345:             loc_oGrid2.Column1.ColumnOrder    = 1
4346:             loc_oGrid2.Column1.Movable        = .F.
4347:             loc_oGrid2.Column1.Resizable      = .F.
4348:             loc_oGrid2.Column1.Header1.Caption = "Material"
4349: 
4350:             loc_oGrid2.Column2.ControlSource  = "cursor_4c_GrdSubCp.dpros"
4351:             loc_oGrid2.Column2.Width          = 149
4352:             loc_oGrid2.Column2.ColumnOrder    = 2
4353:             loc_oGrid2.Column2.Movable        = .F.
4354:             loc_oGrid2.Column2.Resizable      = .F.
4355:             loc_oGrid2.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4356: 
4357:             loc_oGrid2.Column3.ControlSource  = "cursor_4c_GrdSubCp.cunis"
4358:             loc_oGrid2.Column3.Width          = 24
4359:             loc_oGrid2.Column3.ColumnOrder    = 4
4360:             loc_oGrid2.Column3.Movable        = .F.
4361:             loc_oGrid2.Column3.Resizable      = .F.
4362:             loc_oGrid2.Column3.Header1.Caption = "Un"
4363: 
4364:             loc_oGrid2.Column4.ControlSource  = "cursor_4c_GrdSubCp.valor"
4365:             loc_oGrid2.Column4.Width          = 73
4366:             loc_oGrid2.Column4.ColumnOrder    = 7
4367:             loc_oGrid2.Column4.Movable        = .F.
4368:             loc_oGrid2.Column4.Resizable      = .F.
4369:             loc_oGrid2.Column4.InputMask      = "9999999.999"
4370:             loc_oGrid2.Column4.Header1.Caption = "Valor"
4371: 
4372:             loc_oGrid2.Column5.ControlSource  = "cursor_4c_GrdSubCp.qtdes"
4373:             loc_oGrid2.Column5.Width          = 59
4374:             loc_oGrid2.Column5.ColumnOrder    = 3
4375:             loc_oGrid2.Column5.Movable        = .F.
4376:             loc_oGrid2.Column5.Resizable      = .F.
4377:             loc_oGrid2.Column5.InputMask      = "9999.999"
4378:             loc_oGrid2.Column5.Header1.Caption = "Qtde."
4379: 
4380:             loc_oGrid2.Column6.ControlSource  = "cursor_4c_GrdSubCp.total"
4381:             loc_oGrid2.Column6.Width          = 58
4382:             loc_oGrid2.Column6.ColumnOrder    = 9
4383:             loc_oGrid2.Column6.InputMask      = "9999999.999"
4384:             loc_oGrid2.Column6.Header1.Caption = "Total"
4385: 
4386:             loc_oGrid2.Column7.ControlSource  = "cursor_4c_GrdSubCp.moeda"
4387:             loc_oGrid2.Column7.Width          = 31
4388:             loc_oGrid2.Column7.ColumnOrder    = 8
4389:             loc_oGrid2.Column7.Header1.Caption = "Moe"
4390: 
4391:             loc_oGrid2.Column8.ControlSource  = "cursor_4c_GrdSubCp.obs"
4392:             loc_oGrid2.Column8.Width          = 80
4393:             loc_oGrid2.Column8.ColumnOrder    = 10
4394:             loc_oGrid2.Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
4395: 
4396:             loc_oGrid2.Column9.ControlSource  = "cursor_4c_GrdSubCp.estoc"
4397:             loc_oGrid2.Column9.Width          = 14
4398:             loc_oGrid2.Column9.ColumnOrder    = 12
4399:             loc_oGrid2.Column9.Format         = "M"
4400:             loc_oGrid2.Column9.InputMask      = "N,S"
4401:             loc_oGrid2.Column9.Header1.Caption = "E"
4402: 
4403:             loc_oGrid2.Column10.ControlSource  = "cursor_4c_GrdSubCp.consumo"
4404:             loc_oGrid2.Column10.Width          = 58
4405:             loc_oGrid2.Column10.ColumnOrder    = 13
4406:             loc_oGrid2.Column10.InputMask      = "99999"
4407:             loc_oGrid2.Column10.Header1.Caption = "Consumo"
4408: 
4409:             loc_oGrid2.Column11.ControlSource  = "cursor_4c_GrdSubCp.qtdes2"
4410:             loc_oGrid2.Column11.Width          = 59
4411:             loc_oGrid2.Column11.ColumnOrder    = 5
4412:             loc_oGrid2.Column11.Movable        = .F.
4413:             loc_oGrid2.Column11.Resizable      = .F.
4414:             loc_oGrid2.Column11.Header1.Caption = "Qtde."
4415: 
4416:             loc_oGrid2.Column12.ControlSource  = "cursor_4c_GrdSubCp.cunis2"
4417:             loc_oGrid2.Column12.Width          = 24
4418:             loc_oGrid2.Column12.ColumnOrder    = 6
4419:             loc_oGrid2.Column12.Movable        = .F.
4420:             loc_oGrid2.Column12.ReadOnly       = .T.
4421:             loc_oGrid2.Column12.Header1.Caption = "Un"
4422: 
4423:             loc_oGrid2.Column13.ControlSource  = "cursor_4c_GrdSubCp.ords"
4424:             loc_oGrid2.Column13.Width          = 24
4425:             loc_oGrid2.Column13.ColumnOrder    = 14
4426:             loc_oGrid2.Column13.Format         = "K"
4427:             loc_oGrid2.Column13.InputMask      = "99"
4428:             loc_oGrid2.Column13.Header1.Caption = "Ord"
4429: 
4430:             loc_oGrid2.Column14.ControlSource  = "cursor_4c_GrdSubCp.matprinc"
4431:             loc_oGrid2.Column14.Width          = 108
4432:             loc_oGrid2.Column14.ColumnOrder    = 11
4433:             loc_oGrid2.Column14.Header1.Caption = "Material"
4434:             loc_oGrid2.Column14.Header1.BackColor = RGB(240, 240, 240)
4435: 
4436:             loc_oGrid2.Column15.ControlSource  = "cursor_4c_GrdSubCp.tamanho"
4437:             loc_oGrid2.Column15.Width          = 38
4438:             loc_oGrid2.Column15.Header1.Caption = "Tam"
4439:             loc_oGrid2.Column15.Header1.ToolTipText = "Tamanho"
4440: 
4441:             *-- cmg_4c_CmdgSubCp: 2 botoes de subcomposicao
4442:             loc_oPg.AddObject("cmg_4c_CmdgSubCp", "CommandGroup")
4443:             WITH loc_oPg.cmg_4c_CmdgSubCp
4444:                 .Top         = 314
4445:                 .Left        = 947
4446:                 .Width       = 50
4447:                 .Height      = 90
4448:                 .BackStyle   = 0
4449:                 .BorderStyle = 0
4450:                 .Value       = 1
4451:                 .BackColor   = RGB(162, 214, 242)

*-- Linhas 4495 a 4575:
4495:             loc_oPg.grd_4c_GrdRelogios.RecordSource = "cursor_4c_GrdRelogios"
4496:             loc_oGrid3 = loc_oPg.grd_4c_GrdRelogios
4497: 
4498:             loc_oGrid3.Column1.ControlSource  = "cursor_4c_GrdRelogios.grp"
4499:             loc_oGrid3.Column1.Width          = 31
4500:             loc_oGrid3.Column1.ColumnOrder    = 1
4501:             loc_oGrid3.Column1.Movable        = .F.
4502:             loc_oGrid3.Column1.Resizable      = .F.
4503:             loc_oGrid3.Column1.Header1.Caption = "Grp"
4504: 
4505:             loc_oGrid3.Column2.ControlSource  = "cursor_4c_GrdRelogios.descricao"
4506:             loc_oGrid3.Column2.Width          = 150
4507:             loc_oGrid3.Column2.Movable        = .F.
4508:             loc_oGrid3.Column2.Resizable      = .F.
4509:             loc_oGrid3.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4510: 
4511:             loc_oGrid3.Column3.ControlSource  = "cursor_4c_GrdRelogios.produto"
4512:             loc_oGrid3.Column3.Width          = 115
4513:             loc_oGrid3.Column3.ColumnOrder    = 3
4514:             loc_oGrid3.Column3.Movable        = .F.
4515:             loc_oGrid3.Column3.Resizable      = .F.
4516:             loc_oGrid3.Column3.Header1.Caption = "Produto"
4517: 
4518:             loc_oGrid3.Column4.ControlSource  = "cursor_4c_GrdRelogios.descprod"
4519:             loc_oGrid3.Column4.Width          = 290
4520:             loc_oGrid3.Column4.ColumnOrder    = 4
4521:             loc_oGrid3.Column4.Movable        = .F.
4522:             loc_oGrid3.Column4.Resizable      = .F.
4523:             loc_oGrid3.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4524: 
4525:             *-- GradeGRUPO: grade de totais por grupo
4526:             loc_oPg.AddObject("grd_4c_GradeGrupo", "Grid")
4527:             WITH loc_oPg.grd_4c_GradeGrupo
4528:                 .Top          = 41
4529:                 .Left         = 619
4530:                 .Width        = 215
4531:                 .Height       = 68
4532:                 .FontName     = "Verdana"
4533:                 .FontSize     = 8
4534:                 .DeleteMark   = .F.
4535:                 .HeaderHeight = 14
4536:                 .ReadOnly     = .T.
4537:                 .RecordMark   = .F.
4538:                 .RowHeight    = 16
4539:                 .Visible      = .T.
4540:             ENDWITH
4541:             loc_oPg.grd_4c_GradeGrupo.ColumnCount  = 3
4542:             loc_oPg.grd_4c_GradeGrupo.RecordSource = "TotGrupo"
4543:             loc_oGradeGrupo = loc_oPg.grd_4c_GradeGrupo
4544: 
4545:             loc_oGradeGrupo.Column1.ControlSource  = "TotGrupo.Grupo"
4546:             loc_oGradeGrupo.Column1.Width          = 35
4547:             loc_oGradeGrupo.Column1.Movable        = .F.
4548:             loc_oGradeGrupo.Column1.Resizable      = .F.
4549:             loc_oGradeGrupo.Column1.ReadOnly       = .T.
4550:             loc_oGradeGrupo.Column1.Header1.Caption = "Grupo"
4551: 
4552:             loc_oGradeGrupo.Column2.ControlSource  = "TotGrupo.ValGrupo"
4553:             loc_oGradeGrupo.Column2.Width          = 120
4554:             loc_oGradeGrupo.Column2.Movable        = .F.
4555:             loc_oGradeGrupo.Column2.Resizable      = .F.
4556:             loc_oGradeGrupo.Column2.ReadOnly       = .T.
4557:             loc_oGradeGrupo.Column2.InputMask      = "999,999,999.999"
4558:             loc_oGradeGrupo.Column2.Header1.Caption = "Total"
4559: 
4560:             loc_oGradeGrupo.Column3.ControlSource  = "TotGrupo.Moeda"
4561:             loc_oGradeGrupo.Column3.Width          = 37
4562:             loc_oGradeGrupo.Column3.Movable        = .F.
4563:             loc_oGradeGrupo.Column3.Resizable      = .F.
4564:             loc_oGradeGrupo.Column3.ReadOnly       = .T.
4565:             loc_oGradeGrupo.Column3.Header1.Caption = "Moeda"
4566: 
4567:             *-- BINDEVENT para grids
4568:             BINDEVENT(loc_oPg.grd_4c_GrdCompo, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
4569:             BINDEVENT(loc_oPg.grd_4c_GrdSubCp, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")
4570: 
4571:             *-- Say4: "Obs. da OF :"
4572:             loc_oPg.AddObject("lbl_4c_Label4", "Label")
4573:             WITH loc_oPg.lbl_4c_Label4
4574:                 .Caption   = "Obs. da OF :"
4575:                 .FontName  = "Tahoma"

*-- Linhas 5784 a 5916:
5784:             *-- Cursors placeholder (ANTES de RecordSource - REGRA CRITICA VFP9)
5785:             IF !USED("cursor_4c_GrdConsP")
5786:                 SET NULL ON
5787:                 CREATE CURSOR cursor_4c_GrdConsP ( ;
5788:                     mats      C(14), qtds     N(8,3),  unicompos C(3), ;
5789:                     grupos    C(10), dscgrp   C(20),   ordems    N(2,0), ;
5790:                     qtscons   N(8,3), cats    C(6),    dcats     C(15))
5791:                 SET NULL OFF
5792:             ENDIF
5793:             IF !USED("cursor_4c_GrDTEMP")
5794:                 SET NULL ON
5795:                 CREATE CURSOR cursor_4c_GrDTEMP (grupos C(10), tempopct N(8,3))
5796:                 SET NULL OFF
5797:             ENDIF
5798: 
5799:             *-- grd_4c_GrdConsP: grade principal de consumo por processo (9 colunas)
5800:             *-- Original GrdCons: top=149, left=6, width=987, height=347, columnCount=9
5801:             loc_oPg.AddObject("grd_4c_GrdConsP", "Grid")
5802:             WITH loc_oPg.grd_4c_GrdConsP
5803:                 .Top        = 149
5804:                 .Left       = 6
5805:                 .Width      = 987
5806:                 .Height     = 347
5807:                 .FontName   = "Tahoma"
5808:                 .FontSize   = 8
5809:                 .RecordMark = .F.
5810:                 .DeleteMark = .F.
5811:                 .RowHeight  = 18
5812:                 .ScrollBars = 3
5813:                 .GridLines  = 3
5814:                 .GridLineColor      = RGB(238, 238, 238)
5815:                 .HighlightBackColor = RGB(255, 255, 255)
5816:                 .HighlightForeColor = RGB(15, 41, 104)
5817:                 .HighlightStyle     = 2
5818:                 .AllowHeaderSizing  = .F.
5819:                 .AllowRowSizing     = .F.
5820:                 .Visible    = .T.
5821:             ENDWITH
5822:             loc_oPg.grd_4c_GrdConsP.ColumnCount  = 9
5823:             loc_oPg.grd_4c_GrdConsP.RecordSource = "cursor_4c_GrdConsP"
5824:             loc_oGrid = loc_oPg.grd_4c_GrdConsP
5825: 
5826:             *-- Column1: Componente (mats C14) - somente leitura (When=.F. original)
5827:             loc_oGrid.Column1.ControlSource    = "cursor_4c_GrdConsP.mats"
5828:             loc_oGrid.Column1.Width            = 130
5829:             loc_oGrid.Column1.ReadOnly         = .T.
5830:             loc_oGrid.Column1.Movable          = .F.
5831:             loc_oGrid.Column1.Resizable        = .F.
5832:             loc_oGrid.Column1.Header1.Caption  = "Componente"
5833: 
5834:             *-- Column2: Qtde. (qtds N8.3) - somente leitura (When=.F. original)
5835:             loc_oGrid.Column2.ControlSource    = "cursor_4c_GrdConsP.qtds"
5836:             loc_oGrid.Column2.Width            = 65
5837:             loc_oGrid.Column2.ReadOnly         = .T.
5838:             loc_oGrid.Column2.Movable          = .F.
5839:             loc_oGrid.Column2.Resizable        = .F.
5840:             loc_oGrid.Column2.InputMask        = "9999.999"
5841:             loc_oGrid.Column2.Header1.Caption  = "Qtde."
5842: 
5843:             *-- Column3: Uni (unicompos C3) - somente leitura (When=.F. original)
5844:             loc_oGrid.Column3.ControlSource    = "cursor_4c_GrdConsP.unicompos"
5845:             loc_oGrid.Column3.Width            = 38
5846:             loc_oGrid.Column3.ReadOnly         = .T.
5847:             loc_oGrid.Column3.Movable          = .F.
5848:             loc_oGrid.Column3.Resizable        = .F.
5849:             loc_oGrid.Column3.Header1.Caption  = "Uni"
5850: 
5851:             *-- Column4: Fase (grupos C10) - editavel, lookup SigCdGcr
5852:             *-- Original When: Return(Inlist(ThisForm.pcEscolha,'INSERIR','ALTERAR'))
5853:             loc_oGrid.Column4.ControlSource    = "cursor_4c_GrdConsP.grupos"
5854:             loc_oGrid.Column4.Width            = 80
5855:             loc_oGrid.Column4.ReadOnly         = .F.
5856:             loc_oGrid.Column4.Movable          = .F.
5857:             loc_oGrid.Column4.Resizable        = .F.
5858:             loc_oGrid.Column4.Header1.Caption  = "Fase"
5859:             BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdConsPCol4FaseValid")
5860: 
5861:             *-- Column5: Descricao fase (dscgrp C20) - editavel, lookup SigCdGcr por descrs
5862:             *-- Original When: Return(Inlist(...) And Empty(Column4.Text1.Value))
5863:             loc_oGrid.Column5.ControlSource    = "cursor_4c_GrdConsP.dscgrp"
5864:             loc_oGrid.Column5.Width            = 180
5865:             loc_oGrid.Column5.ReadOnly         = .F.
5866:             loc_oGrid.Column5.Movable          = .F.
5867:             loc_oGrid.Column5.Resizable        = .F.
5868:             loc_oGrid.Column5.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
5869:             BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GrdConsPCol5DescFaseValid")
5870: 
5871:             *-- Column6: Ord. (ordems N2) - somente leitura (When=.F. original)
5872:             loc_oGrid.Column6.ControlSource    = "cursor_4c_GrdConsP.ordems"
5873:             loc_oGrid.Column6.Width            = 40
5874:             loc_oGrid.Column6.ReadOnly         = .T.
5875:             loc_oGrid.Column6.Movable          = .F.
5876:             loc_oGrid.Column6.Resizable        = .F.
5877:             loc_oGrid.Column6.InputMask        = "99"
5878:             loc_oGrid.Column6.Header1.Caption  = "Ord."
5879: 
5880:             *-- Column7: Consumo (qtscons N8.3) - editavel
5881:             *-- Original When: Return Inlist(ThisForm.pcEscolha,'INSERIR','ALTERAR')
5882:             loc_oGrid.Column7.ControlSource    = "cursor_4c_GrdConsP.qtscons"
5883:             loc_oGrid.Column7.Width            = 75
5884:             loc_oGrid.Column7.ReadOnly         = .F.
5885:             loc_oGrid.Column7.Movable          = .F.
5886:             loc_oGrid.Column7.Resizable        = .F.
5887:             loc_oGrid.Column7.InputMask        = "9999.999"
5888:             loc_oGrid.Column7.Header1.Caption  = "Consumo"
5889: 
5890:             *-- Column8: Cat. (cats C6) - editavel, lookup SigCdCat por Cods
5891:             *-- Original When: Return(InList(ThisForm.pcEscolha,"INSERIR","ALTERAR"))
5892:             loc_oGrid.Column8.ControlSource    = "cursor_4c_GrdConsP.cats"
5893:             loc_oGrid.Column8.Width            = 55
5894:             loc_oGrid.Column8.ReadOnly         = .F.
5895:             loc_oGrid.Column8.Movable          = .F.
5896:             loc_oGrid.Column8.Resizable        = .F.
5897:             loc_oGrid.Column8.Header1.Caption  = "Cat."
5898:             BINDEVENT(loc_oGrid.Column8.Text1, "Valid", THIS, "GrdConsPCol8CatValid")
5899: 
5900:             *-- Column9: Descricao Cat. (dcats C15) - somente leitura
5901:             loc_oGrid.Column9.ControlSource    = "cursor_4c_GrdConsP.dcats"
5902:             loc_oGrid.Column9.Width            = 185
5903:             loc_oGrid.Column9.ReadOnly         = .T.
5904:             loc_oGrid.Column9.Movable          = .F.
5905:             loc_oGrid.Column9.Resizable        = .F.
5906:             loc_oGrid.Column9.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
5907: 
5908:             BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdConsPAfterRowColChange")
5909: 
5910:             *-- lbl_4c_Label7: "Qtde Componentes :" (Say7: top=505, left=23, w=105)
5911:             loc_oPg.AddObject("lbl_4c_Label7", "Label")
5912:             WITH loc_oPg.lbl_4c_Label7
5913:                 .Caption   = "Qtde Componentes : "
5914:                 .Top       = 505
5915:                 .Left      = 23
5916:                 .Width     = 105

*-- Linhas 5986 a 6023:
5986:                 .FontName   = "Tahoma"
5987:                 .FontSize   = 8
5988:                 .RecordMark = .F.
5989:                 .DeleteMark = .F.
5990:                 .RowHeight  = 18
5991:                 .ScrollBars = 2
5992:                 .GridLines  = 3
5993:                 .AllowHeaderSizing = .F.
5994:                 .AllowRowSizing    = .F.
5995:                 .Visible    = .T.
5996:             ENDWITH
5997:             loc_oPg.grd_4c_GrDTEMP.ColumnCount  = 2
5998:             loc_oPg.grd_4c_GrDTEMP.RecordSource = "cursor_4c_GrDTEMP"
5999:             loc_oGrid2 = loc_oPg.grd_4c_GrDTEMP
6000: 
6001:             *-- Column1: Agrupamento (grupos C10) - somente leitura (When=.F. original)
6002:             loc_oGrid2.Column1.ControlSource    = "cursor_4c_GrDTEMP.grupos"
6003:             loc_oGrid2.Column1.Width            = 100
6004:             loc_oGrid2.Column1.ReadOnly         = .T.
6005:             loc_oGrid2.Column1.Header1.Caption  = "Agrupamento"
6006: 
6007:             *-- Column2: Tempo % (tempopct N8.3) - somente leitura (When=.F. original)
6008:             loc_oGrid2.Column2.ControlSource    = "cursor_4c_GrDTEMP.tempopct"
6009:             loc_oGrid2.Column2.Width            = 72
6010:             loc_oGrid2.Column2.ReadOnly         = .T.
6011:             loc_oGrid2.Column2.InputMask        = "9999.99"
6012:             loc_oGrid2.Column2.Header1.Caption  = "Tempo %"
6013: 
6014:         CATCH TO loc_oErro
6015:             MostrarErro("Erro ao configurar p" + CHR(225) + "gina Consumo por Processo:" + ;
6016:                 CHR(13) + loc_oErro.Message, "FormProduto.ConfigurarPgPgDadosConsP")
6017:         ENDTRY
6018:     ENDPROC
6019: 
6020:     *===========================================================================
6021:     * Handlers de BINDEVENT para pgDadosConsP (Page5)
6022:     * Todos PUBLIC - requerido pelo BINDEVENT
6023:     *===========================================================================

*-- Linhas 6054 a 6076:
6054:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6055:                 loc_cGrupos = ALLTRIM(cursor_4c_GrdConsP.grupos)
6056:                 IF !EMPTY(loc_cGrupos)
6057:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6058:                         "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupos), ;
6059:                         "cursor_4c_GcrFase")
6060:                     IF loc_nRet > 0 AND USED("cursor_4c_GcrFase") AND !EOF("cursor_4c_GcrFase")
6061:                         SELECT cursor_4c_GrdConsP
6062:                         REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(cursor_4c_GcrFase.descrs)
6063:                         IF USED("cursor_4c_GcrFase")
6064:                             USE IN cursor_4c_GcrFase
6065:                         ENDIF
6066:                     ELSE
6067:                         IF USED("cursor_4c_GcrFase")
6068:                             USE IN cursor_4c_GcrFase
6069:                         ENDIF
6070:                         THIS.AbrirBuscaFaseConsP()
6071:                     ENDIF
6072:                 ENDIF
6073:             ENDIF
6074:         CATCH TO loException
6075:             IF USED("cursor_4c_GcrFase")
6076:                 USE IN cursor_4c_GcrFase

*-- Linhas 6093 a 6115:
6093:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6094:                 loc_cDescrs = ALLTRIM(cursor_4c_GrdConsP.dscgrp)
6095:                 IF !EMPTY(loc_cDescrs)
6096:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6097:                         "SELECT codigos, descrs FROM SigCdGcr WHERE descrs = " + EscaparSQL(loc_cDescrs), ;
6098:                         "cursor_4c_GcrDescFase")
6099:                     IF loc_nRet > 0 AND USED("cursor_4c_GcrDescFase") AND !EOF("cursor_4c_GcrDescFase")
6100:                         SELECT cursor_4c_GrdConsP
6101:                         REPLACE cursor_4c_GrdConsP.grupos WITH ALLTRIM(cursor_4c_GcrDescFase.codigos)
6102:                         IF USED("cursor_4c_GcrDescFase")
6103:                             USE IN cursor_4c_GcrDescFase
6104:                         ENDIF
6105:                     ELSE
6106:                         IF USED("cursor_4c_GcrDescFase")
6107:                             USE IN cursor_4c_GcrDescFase
6108:                         ENDIF
6109:                         THIS.AbrirBuscaDescFaseConsP()
6110:                     ENDIF
6111:                 ENDIF
6112:             ENDIF
6113:         CATCH TO loException
6114:             IF USED("cursor_4c_GcrDescFase")
6115:                 USE IN cursor_4c_GcrDescFase

*-- Linhas 6132 a 6157:
6132:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6133:                 loc_cCats = ALLTRIM(cursor_4c_GrdConsP.cats)
6134:                 IF EMPTY(loc_cCats)
6135:                     SELECT cursor_4c_GrdConsP
6136:                     REPLACE cursor_4c_GrdConsP.dcats WITH ""
6137:                 ELSE
6138:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6139:                         "SELECT cods, descs FROM SigCdCat WHERE cods = " + EscaparSQL(loc_cCats), ;
6140:                         "cursor_4c_CatBusca")
6141:                     IF loc_nRet > 0 AND USED("cursor_4c_CatBusca") AND !EOF("cursor_4c_CatBusca")
6142:                         SELECT cursor_4c_GrdConsP
6143:                         REPLACE cursor_4c_GrdConsP.dcats WITH ALLTRIM(cursor_4c_CatBusca.descs)
6144:                         IF USED("cursor_4c_CatBusca")
6145:                             USE IN cursor_4c_CatBusca
6146:                         ENDIF
6147:                     ELSE
6148:                         IF USED("cursor_4c_CatBusca")
6149:                             USE IN cursor_4c_CatBusca
6150:                         ENDIF
6151:                         THIS.AbrirBuscaCatConsP()
6152:                     ENDIF
6153:                 ENDIF
6154:             ENDIF
6155:         CATCH TO loException
6156:             IF USED("cursor_4c_CatBusca")
6157:                 USE IN cursor_4c_CatBusca

*-- Linhas 6172 a 6207:
6172:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6173:                 *-- Atualizar dcats (Column9) se cats (Column8) foi preenchido
6174:                 IF !EMPTY(ALLTRIM(cursor_4c_GrdConsP.cats)) AND EMPTY(ALLTRIM(cursor_4c_GrdConsP.dcats))
6175:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6176:                         "SELECT descs FROM SigCdCat WHERE cods = " + EscaparSQL(ALLTRIM(cursor_4c_GrdConsP.cats)), ;
6177:                         "cursor_4c_GCatDesc")
6178:                     IF loc_nRet > 0 AND USED("cursor_4c_GCatDesc") AND !EOF("cursor_4c_GCatDesc")
6179:                         SELECT cursor_4c_GrdConsP
6180:                         REPLACE cursor_4c_GrdConsP.dcats WITH ALLTRIM(cursor_4c_GCatDesc.descs)
6181:                     ENDIF
6182:                     IF USED("cursor_4c_GCatDesc")
6183:                         USE IN cursor_4c_GCatDesc
6184:                     ENDIF
6185:                 ENDIF
6186:                 *-- Atualizar dscgrp (Column5) se grupos (Column4) foi preenchido e dscgrp vazio
6187:                 IF !EMPTY(ALLTRIM(cursor_4c_GrdConsP.grupos)) AND EMPTY(ALLTRIM(cursor_4c_GrdConsP.dscgrp))
6188:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6189:                         "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(ALLTRIM(cursor_4c_GrdConsP.grupos)), ;
6190:                         "cursor_4c_GFaseDesc")
6191:                     IF loc_nRet > 0 AND USED("cursor_4c_GFaseDesc") AND !EOF("cursor_4c_GFaseDesc")
6192:                         SELECT cursor_4c_GrdConsP
6193:                         REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(cursor_4c_GFaseDesc.descrs)
6194:                     ENDIF
6195:                     IF USED("cursor_4c_GFaseDesc")
6196:                         USE IN cursor_4c_GFaseDesc
6197:                     ENDIF
6198:                 ENDIF
6199:             ENDIF
6200:         CATCH TO loException
6201:             IF USED("cursor_4c_GCatDesc")
6202:                 USE IN cursor_4c_GCatDesc
6203:             ENDIF
6204:             IF USED("cursor_4c_GFaseDesc")
6205:                 USE IN cursor_4c_GFaseDesc
6206:             ENDIF
6207:             MostrarErro("Erro ao atualizar descri" + CHR(231) + CHR(245) + "es do grid ConsP:" + ;

*-- Linhas 6219 a 6257:
6219:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6220:                 loc_cValAtual = ALLTRIM(cursor_4c_GrdConsP.grupos)
6221: 
6222:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6223:                     "SELECT codigos, descrs FROM SigCdGcr WHERE codigos LIKE " + ;
6224:                     EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
6225:                     "cursor_4c_FaseBusca")
6226: 
6227:                 IF loc_nRet <= 0 OR !USED("cursor_4c_FaseBusca") OR EOF("cursor_4c_FaseBusca")
6228:                     IF USED("cursor_4c_FaseBusca")
6229:                         USE IN cursor_4c_FaseBusca
6230:                     ENDIF
6231:                     SQLEXEC(gnConnHandle, "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos", ;
6232:                         "cursor_4c_FaseBusca")
6233:                 ENDIF
6234: 
6235:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6236:                 IF VARTYPE(loc_oBusca) = "O"
6237:                     loc_oBusca.this_cCursorDestino = "cursor_4c_FaseBusca"
6238:                     loc_oBusca.DefinirCursor("cursor_4c_FaseBusca", "codigos", "descrs", ;
6239:                         "Buscar Fase/Processo")
6240:                     loc_oBusca.Mostrar()
6241:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6242:                         SELECT cursor_4c_GrdConsP
6243:                         REPLACE cursor_4c_GrdConsP.grupos WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
6244:                         REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
6245:                     ENDIF
6246:                     loc_oBusca = .NULL.
6247:                 ENDIF
6248: 
6249:                 IF USED("cursor_4c_FaseBusca")
6250:                     USE IN cursor_4c_FaseBusca
6251:                 ENDIF
6252:             ENDIF
6253:         CATCH TO loException
6254:             IF USED("cursor_4c_FaseBusca")
6255:                 USE IN cursor_4c_FaseBusca
6256:             ENDIF
6257:             MostrarErro("Erro ao buscar Fase:" + CHR(13) + loException.Message, ;

*-- Linhas 6269 a 6307:
6269:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6270:                 loc_cValAtual = ALLTRIM(cursor_4c_GrdConsP.dscgrp)
6271: 
6272:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6273:                     "SELECT descrs, codigos FROM SigCdGcr WHERE descrs LIKE " + ;
6274:                     EscaparSQL(loc_cValAtual + "%") + " ORDER BY descrs", ;
6275:                     "cursor_4c_DescFaseBusca")
6276: 
6277:                 IF loc_nRet <= 0 OR !USED("cursor_4c_DescFaseBusca") OR EOF("cursor_4c_DescFaseBusca")
6278:                     IF USED("cursor_4c_DescFaseBusca")
6279:                         USE IN cursor_4c_DescFaseBusca
6280:                     ENDIF
6281:                     SQLEXEC(gnConnHandle, "SELECT descrs, codigos FROM SigCdGcr ORDER BY descrs", ;
6282:                         "cursor_4c_DescFaseBusca")
6283:                 ENDIF
6284: 
6285:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6286:                 IF VARTYPE(loc_oBusca) = "O"
6287:                     loc_oBusca.this_cCursorDestino = "cursor_4c_DescFaseBusca"
6288:                     loc_oBusca.DefinirCursor("cursor_4c_DescFaseBusca", "descrs", "codigos", ;
6289:                         "Buscar Fase por Descri" + CHR(231) + CHR(227) + "o")
6290:                     loc_oBusca.Mostrar()
6291:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6292:                         SELECT cursor_4c_GrdConsP
6293:                         REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
6294:                         REPLACE cursor_4c_GrdConsP.grupos WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
6295:                     ENDIF
6296:                     loc_oBusca = .NULL.
6297:                 ENDIF
6298: 
6299:                 IF USED("cursor_4c_DescFaseBusca")
6300:                     USE IN cursor_4c_DescFaseBusca
6301:                 ENDIF
6302:             ENDIF
6303:         CATCH TO loException
6304:             IF USED("cursor_4c_DescFaseBusca")
6305:                 USE IN cursor_4c_DescFaseBusca
6306:             ENDIF
6307:             MostrarErro("Erro ao buscar Fase por descri" + CHR(231) + CHR(227) + "o:" + ;

*-- Linhas 6319 a 6356:
6319:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6320:                 loc_cValAtual = ALLTRIM(cursor_4c_GrdConsP.cats)
6321: 
6322:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6323:                     "SELECT cods, descs FROM SigCdCat WHERE cods LIKE " + ;
6324:                     EscaparSQL(loc_cValAtual + "%") + " ORDER BY cods", ;
6325:                     "cursor_4c_CatBusca")
6326: 
6327:                 IF loc_nRet <= 0 OR !USED("cursor_4c_CatBusca") OR EOF("cursor_4c_CatBusca")
6328:                     IF USED("cursor_4c_CatBusca")
6329:                         USE IN cursor_4c_CatBusca
6330:                     ENDIF
6331:                     SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdCat ORDER BY cods", ;
6332:                         "cursor_4c_CatBusca")
6333:                 ENDIF
6334: 
6335:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6336:                 IF VARTYPE(loc_oBusca) = "O"
6337:                     loc_oBusca.this_cCursorDestino = "cursor_4c_CatBusca"
6338:                     loc_oBusca.DefinirCursor("cursor_4c_CatBusca", "cods", "descs", "Buscar Categoria")
6339:                     loc_oBusca.Mostrar()
6340:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6341:                         SELECT cursor_4c_GrdConsP
6342:                         REPLACE cursor_4c_GrdConsP.cats  WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
6343:                         REPLACE cursor_4c_GrdConsP.dcats WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
6344:                     ENDIF
6345:                     loc_oBusca = .NULL.
6346:                 ENDIF
6347: 
6348:                 IF USED("cursor_4c_CatBusca")
6349:                     USE IN cursor_4c_CatBusca
6350:                 ENDIF
6351:             ENDIF
6352:         CATCH TO loException
6353:             IF USED("cursor_4c_CatBusca")
6354:                 USE IN cursor_4c_CatBusca
6355:             ENDIF
6356:             MostrarErro("Erro ao buscar Categoria:" + CHR(13) + loException.Message, ;

*-- Linhas 6371 a 6408:
6371:                 RETURN
6372:             ENDIF
6373:             IF !EMPTY(cursor_4c_GrdCompo.cpros)
6374:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6375:                     "SELECT dpros FROM SigCdPro WHERE cpros = '" + ;
6376:                     EscaparSQL(ALLTRIM(cursor_4c_GrdCompo.cpros)) + "", ;
6377:                     "cursor_4c_DescCusto")
6378:                 IF loc_nRet > 0 AND USED("cursor_4c_DescCusto") AND !EOF("cursor_4c_DescCusto")
6379:                     IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
6380:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_DescCusto.dpros)
6381:                     ENDIF
6382:                     USE IN cursor_4c_DescCusto
6383:                 ENDIF
6384:             ELSE
6385:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
6386:                     loc_oPg.txt_4c_Desc.Value = ""
6387:                 ENDIF
6388:             ENDIF
6389:             IF !EMPTY(cursor_4c_GrdCompo.cpros)
6390:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6391:                     "SELECT b.dgrus FROM SigCdPro a " + ;
6392:                     "INNER JOIN SigCdGrp b ON a.cgrus = b.cgrus " + ;
6393:                     "WHERE a.cpros = " + EscaparSQL(ALLTRIM(cursor_4c_GrdCompo.cpros)) + "", ;
6394:                     "cursor_4c_GruCusto")
6395:                 IF loc_nRet > 0 AND USED("cursor_4c_GruCusto") AND !EOF("cursor_4c_GruCusto")
6396:                     IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
6397:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_GruCusto.dgrus)
6398:                     ENDIF
6399:                     USE IN cursor_4c_GruCusto
6400:                 ENDIF
6401:             ELSE
6402:                 IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
6403:                     loc_oPg.txt_4c_DGruCompos.Value = ""
6404:                 ENDIF
6405:             ENDIF
6406:         CATCH TO loException
6407:             IF USED("cursor_4c_DescCusto")
6408:                 USE IN cursor_4c_DescCusto

*-- Linhas 6433 a 6486:
6433:             IF !USED("cursor_4c_GrdCompo")
6434:                 RETURN
6435:             ENDIF
6436:             SELECT cursor_4c_GrdCompo
6437:             APPEND BLANK
6438:         CATCH TO loException
6439:             MostrarErro("Erro ao inserir item de custo:" + CHR(13) + loException.Message, ;
6440:                 "FormProduto.CmdCustoInserirClick")
6441:         ENDTRY
6442:     ENDPROC
6443: 
6444:     PROCEDURE CmdCustoExcluirClick()
6445:         LOCAL loc_lConfirma, loException
6446:         TRY
6447:             IF !USED("cursor_4c_GrdCompo") OR EOF("cursor_4c_GrdCompo")
6448:                 RETURN
6449:             ENDIF
6450:             loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste item de custo?")
6451:             IF loc_lConfirma
6452:                 SELECT cursor_4c_GrdCompo
6453:                 DELETE
6454:                 IF !EOF()
6455:                     SKIP
6456:                     SKIP -1
6457:                 ENDIF
6458:             ENDIF
6459:         CATCH TO loException
6460:             MostrarErro("Erro ao excluir item de custo:" + CHR(13) + loException.Message, ;
6461:                 "FormProduto.CmdCustoExcluirClick")
6462:         ENDTRY
6463:     ENDPROC
6464: 
6465:     PROCEDURE CboTiposCustoInteractiveChange()
6466:         LOCAL loc_oPg, loc_cTipo, loException
6467:         TRY
6468:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
6469:             IF PEMSTATUS(loc_oPg, "cbo_4c_CmbTipos", 5) AND USED("cursor_4c_GrdCompo")
6470:                 loc_cTipo = ALLTRIM(NVL(loc_oPg.cbo_4c_CmbTipos.Value, ""))
6471:                 SELECT cursor_4c_GrdCompo
6472:                 IF EMPTY(loc_cTipo)
6473:                     SET FILTER TO
6474:                 ELSE
6475:                     SET FILTER TO ALLTRIM(cursor_4c_GrdCompo.cunis) = loc_cTipo
6476:                 ENDIF
6477:                 GO TOP
6478:                 IF PEMSTATUS(loc_oPg, "grd_4c_GrdCusto", 5)
6479:                     loc_oPg.grd_4c_GrdCusto.Refresh()
6480:                 ENDIF
6481:             ENDIF
6482:         CATCH TO loException
6483:             MostrarErro("Erro ao filtrar tipos de custo:" + CHR(13) + loException.Message, ;
6484:                 "FormProduto.CboTiposCustoInteractiveChange")
6485:         ENDTRY
6486:     ENDPROC

*-- Linhas 6495 a 6532:
6495:         TRY
6496:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6497:             IF USED("cursor_4c_GrdCompo") AND !EOF("cursor_4c_GrdCompo") AND !BOF("cursor_4c_GrdCompo")
6498:                 SELECT cursor_4c_GrdCompo
6499:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
6500:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_GrdCompo.dpros)
6501:                 ENDIF
6502:                 IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
6503:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_GrdCompo.matprinc)
6504:                 ENDIF
6505:             ENDIF
6506:         CATCH TO loException
6507:             MostrarErro("Erro ao navegar composicao:" + CHR(13) + loException.Message, ;
6508:                 "FormProduto.GrdCompoAfterRowColChange")
6509:         ENDTRY
6510:     ENDPROC
6511: 
6512:     PROCEDURE GrdSubCpAfterRowColChange(par_nColIndex)
6513:         LOCAL loc_oPg, loException
6514:         TRY
6515:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6516:             IF USED("cursor_4c_GrdSubCp") AND !EOF("cursor_4c_GrdSubCp") AND !BOF("cursor_4c_GrdSubCp")
6517:                 SELECT cursor_4c_GrdSubCp
6518:                 IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
6519:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_GrdSubCp.dpros)
6520:                 ENDIF
6521:                 IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
6522:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_GrdSubCp.matprinc)
6523:                 ENDIF
6524:             ENDIF
6525:         CATCH TO loException
6526:             MostrarErro("Erro ao navegar subcomposicao:" + CHR(13) + loException.Message, ;
6527:                 "FormProduto.GrdSubCpAfterRowColChange")
6528:         ENDTRY
6529:     ENDPROC
6530: 
6531:     PROCEDURE CmgCompoClick()
6532:         LOCAL loc_oPg, loc_nBotao

*-- Linhas 6719 a 6737:
6719:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6720:                 IF USED("cursor_4c_GrdCompo") AND !EOF("cursor_4c_GrdCompo") AND ;
6721:                         PEMSTATUS(loc_oPg, "txt_4c_ObsOFs", 5)
6722:                     SELECT cursor_4c_GrdCompo
6723:                     REPLACE cursor_4c_GrdCompo.obs WITH ;
6724:                         ALLTRIM(loc_oPg.txt_4c_ObsOFs.Value)
6725:                 ENDIF
6726:             CATCH TO loException
6727:                 MostrarErro("Erro ao salvar obs OFs:" + CHR(13) + loException.Message, ;
6728:                     "FormProduto.TxtObsOFsKeyPress")
6729:             ENDTRY
6730:         ENDIF
6731:     ENDPROC
6732: 
6733:     *-- Validacoes/lookups de moeda (SigCdMoe: cmoeds, dmoeds)
6734: 
6735:     PROCEDURE ValidarMoec(par_nKeyCode, par_nShiftAltCtrl)
6736:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6737:             RETURN

*-- Linhas 6969 a 6988:
6969:                 loc_cValAtual = ALLTRIM(loc_oPg.&par_cCampoDestino..Value)
6970:             ENDIF
6971: 
6972:             loc_nRet = SQLEXEC(gnConnHandle, ;
6973:                 "SELECT cmoeds, dmoeds FROM SigCdMoe ORDER BY cmoeds", ;
6974:                 "cursor_4c_MoedaBusca")
6975: 
6976:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6977:             IF VARTYPE(loc_oBusca) = "O"
6978:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MoedaBusca"
6979:                 loc_oBusca.DefinirCursor("cursor_4c_MoedaBusca", "cmoeds", "dmoeds", "Buscar Moeda")
6980:                 loc_oBusca.Mostrar()
6981:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
6982:                     loc_oPg.&par_cCampoDestino..Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
6983:                 ENDIF
6984:                 loc_oBusca = .NULL.
6985:             ENDIF
6986: 
6987:             IF USED("cursor_4c_MoedaBusca")
6988:                 USE IN cursor_4c_MoedaBusca

*-- Linhas 7009 a 7036:
7009:                 loc_cValAtual = ALLTRIM(loc_oPg.&par_cCampoDestino..Value)
7010:             ENDIF
7011: 
7012:             loc_nRet = SQLEXEC(gnConnHandle, ;
7013:                 "SELECT cods, descs FROM SigPrFti WHERE cods LIKE '" + ;
7014:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", ;
7015:                 "cursor_4c_FeitioBusca")
7016: 
7017:             IF loc_nRet <= 0 OR !USED("cursor_4c_FeitioBusca") OR EOF("cursor_4c_FeitioBusca")
7018:                 IF USED("cursor_4c_FeitioBusca")
7019:                     USE IN cursor_4c_FeitioBusca
7020:                 ENDIF
7021:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigPrFti ORDER BY cods", ;
7022:                     "cursor_4c_FeitioBusca")
7023:             ENDIF
7024: 
7025:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
7026:             IF VARTYPE(loc_oBusca) = "O"
7027:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FeitioBusca"
7028:                 loc_oBusca.DefinirCursor("cursor_4c_FeitioBusca", "cods", "descs", "Buscar Feitio/MKP")
7029:                 loc_oBusca.Mostrar()
7030:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
7031:                     loc_oPg.&par_cCampoDestino..Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
7032:                 ENDIF
7033:                 loc_oBusca = .NULL.
7034:             ENDIF
7035: 
7036:             IF USED("cursor_4c_FeitioBusca")

*-- Linhas 7058 a 7085:
7058:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Status.Value)
7059:             ENDIF
7060: 
7061:             loc_nRet = SQLEXEC(gnConnHandle, ;
7062:                 "SELECT cods, descs FROM SigCdPst WHERE cods LIKE '" + ;
7063:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", ;
7064:                 "cursor_4c_StatusBusca")
7065: 
7066:             IF loc_nRet <= 0 OR !USED("cursor_4c_StatusBusca") OR EOF("cursor_4c_StatusBusca")
7067:                 IF USED("cursor_4c_StatusBusca")
7068:                     USE IN cursor_4c_StatusBusca
7069:                 ENDIF
7070:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdPst ORDER BY cods", ;
7071:                     "cursor_4c_StatusBusca")
7072:             ENDIF
7073: 
7074:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
7075:             IF VARTYPE(loc_oBusca) = "O"
7076:                 loc_oBusca.this_cCursorDestino = "cursor_4c_StatusBusca"
7077:                 loc_oBusca.DefinirCursor("cursor_4c_StatusBusca", "cods", "descs", "Buscar Status")
7078:                 loc_oBusca.Mostrar()
7079:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, "txt_4c_Status", 5)
7080:                     loc_oPg.txt_4c_Status.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
7081:                 ENDIF
7082:                 loc_oBusca = .NULL.
7083:             ENDIF
7084: 
7085:             IF USED("cursor_4c_StatusBusca")

*-- Linhas 7109 a 7134:
7109:             *-- Cursors placeholder (ANTES de RecordSource - REGRA CRITICA VFP9)
7110:             IF !USED("cursor_4c_GradFase")
7111:                 SET NULL ON
7112:                 CREATE CURSOR cursor_4c_GradFase ( ;
7113:                     cidchaves C(20), ordems N(2,0), grupos C(10), ;
7114:                     minutos   N(9,1), uniprdts C(10), matprdts C(15), obs M)
7115:                 SET NULL OFF
7116:             ENDIF
7117:             IF !USED("cursor_4c_GrdMatrizes")
7118:                 SET NULL ON
7119:                 CREATE CURSOR cursor_4c_GrdMatrizes ( ;
7120:                     cidchaves C(20), cmats C(14), qtds N(3,0), dpros C(65))
7121:                 SET NULL OFF
7122:             ENDIF
7123: 
7124:             *-- shp_4c_Fig: Shape moldura da figura do produto
7125:             *-- Original shpFig: top=129, left=231, width=244, height=148
7126:             loc_oPg.AddObject("shp_4c_Fig", "Shape")
7127:             WITH loc_oPg.shp_4c_Fig
7128:                 .Top           = 129
7129:                 .Left          = 231
7130:                 .Width         = 244
7131:                 .Height        = 148
7132:                 .BackStyle     = 0
7133:                 .BorderWidth   = 2
7134:                 .SpecialEffect = 0

*-- Linhas 7215 a 7287:
7215:                 .FontName          = "Tahoma"
7216:                 .FontSize          = 8
7217:                 .RecordMark        = .F.
7218:                 .DeleteMark        = .F.
7219:                 .HeaderHeight      = 20
7220:                 .RowHeight         = 18
7221:                 .ScrollBars        = 2
7222:                 .GridLines         = 3
7223:                 .GridLineColor     = RGB(238, 238, 238)
7224:                 .HighlightBackColor = RGB(255, 255, 255)
7225:                 .HighlightForeColor = RGB(15, 41, 104)
7226:                 .HighlightStyle    = 2
7227:                 .AllowHeaderSizing = .F.
7228:                 .AllowRowSizing    = .F.
7229:                 .Visible           = .T.
7230:             ENDWITH
7231:             loc_oPg.grd_4c_GradFase.ColumnCount  = 5
7232:             loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
7233:             loc_oGrid = loc_oPg.grd_4c_GradFase
7234: 
7235:             *-- Column1: Ordem (ordems N2,0) - width=45
7236:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GradFase.ordems"
7237:             loc_oGrid.Column1.Width           = 45
7238:             loc_oGrid.Column1.ReadOnly        = .F.
7239:             loc_oGrid.Column1.Movable         = .F.
7240:             loc_oGrid.Column1.Resizable       = .F.
7241:             loc_oGrid.Column1.Header1.Caption = "Ordem"
7242:             BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "GrdFaseCol1OrdValid")
7243: 
7244:             *-- Column2: Fase/Grupo (grupos C10) - lookup SigCdGcr, width=80
7245:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GradFase.grupos"
7246:             loc_oGrid.Column2.Width           = 80
7247:             loc_oGrid.Column2.ReadOnly        = .F.
7248:             loc_oGrid.Column2.Movable         = .F.
7249:             loc_oGrid.Column2.Resizable       = .F.
7250:             loc_oGrid.Column2.Header1.Caption = "Fase"
7251:             BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "GrdFaseCol2FaseValid")
7252: 
7253:             *-- Column3: Utilizacao (minutos N9,1) - width=70
7254:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GradFase.minutos"
7255:             loc_oGrid.Column3.Width           = 70
7256:             loc_oGrid.Column3.ReadOnly        = .F.
7257:             loc_oGrid.Column3.Movable         = .F.
7258:             loc_oGrid.Column3.Resizable       = .F.
7259:             loc_oGrid.Column3.InputMask       = "99,999.9"
7260:             loc_oGrid.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
7261: 
7262:             *-- Column4: Uni. Produtiva (uniprdts C10) - lookup SigCdUpd, width=84
7263:             loc_oGrid.Column4.ControlSource   = "cursor_4c_GradFase.uniprdts"
7264:             loc_oGrid.Column4.Width           = 84
7265:             loc_oGrid.Column4.ReadOnly        = .F.
7266:             loc_oGrid.Column4.Movable         = .F.
7267:             loc_oGrid.Column4.Resizable       = .F.
7268:             loc_oGrid.Column4.Header1.Caption = "Uni. Produtiva"
7269:             BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdFaseCol4UniPrdtValid")
7270: 
7271:             *-- Column5: Material (matprdts C15) - lookup SigOpOpt, width=115
7272:             loc_oGrid.Column5.ControlSource   = "cursor_4c_GradFase.matprdts"
7273:             loc_oGrid.Column5.Width           = 115
7274:             loc_oGrid.Column5.ReadOnly        = .F.
7275:             loc_oGrid.Column5.Movable         = .F.
7276:             loc_oGrid.Column5.Resizable       = .F.
7277:             loc_oGrid.Column5.Header1.Caption = "Material"
7278:             BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GrdFaseCol5MatPrdtValid")
7279: 
7280:             BINDEVENT(loc_oGrid, "BeforeRowColChange", THIS, "GrdFaseBeforeRowColChange")
7281:             BINDEVENT(loc_oGrid, "AfterRowColChange",  THIS, "GrdFaseAfterRowColChange")
7282: 
7283:             *-- cmd_4c_InserirFase: Inserir fase na GradFase
7284:             *-- Original inserir: top=129, left=950, width=40, height=40
7285:             loc_oPg.AddObject("cmd_4c_InserirFase", "CommandButton")
7286:             WITH loc_oPg.cmd_4c_InserirFase
7287:                 .Top             = 129

*-- Linhas 7357 a 7375:
7357:             ENDWITH
7358: 
7359:             *-- txt_4c_QminFabs: Quantidade minima de fabricacao (getQmin)
7360:             *-- Original getQmin: top=129, left=137, width=80, height=23, ControlSource=crSigCdPro.qtminFabs
7361:             loc_oPg.AddObject("txt_4c_QminFabs", "TextBox")
7362:             WITH loc_oPg.txt_4c_QminFabs
7363:                 .Top           = 129
7364:                 .Left          = 137
7365:                 .Width         = 80
7366:                 .Height        = 23
7367:                 .FontName      = "Tahoma"
7368:                 .FontSize      = 8
7369:                 .InputMask     = "999,999.99"
7370:                 .MaxLength     = 10
7371:                 .SpecialEffect = 1
7372:                 .Value         = 0
7373:                 .Visible       = .T.
7374:             ENDWITH
7375: 

*-- Linhas 7390 a 7408:
7390:             ENDWITH
7391: 
7392:             *-- txt_4c_CodGarras: Codigo de garra (getCodGarras)
7393:             *-- Original getCodGarras: top=154, left=137, width=80, height=23, ControlSource=crSigCdPro.CodGarras
7394:             loc_oPg.AddObject("txt_4c_CodGarras", "TextBox")
7395:             WITH loc_oPg.txt_4c_CodGarras
7396:                 .Top           = 154
7397:                 .Left          = 137
7398:                 .Width         = 80
7399:                 .Height        = 23
7400:                 .FontName      = "Tahoma"
7401:                 .FontSize      = 8
7402:                 .MaxLength     = 10
7403:                 .SpecialEffect = 1
7404:                 .Value         = ""
7405:                 .Visible       = .T.
7406:             ENDWITH
7407: 
7408:             *-- lbl_4c_Say4: "Conquilha :"

*-- Linhas 7420 a 7438:
7420:             ENDWITH
7421: 
7422:             *-- txt_4c_Conquilhas: Conquilha (getConquilha)
7423:             *-- Original getConquilha: top=179, left=137, width=80, height=23, ControlSource=crSigCdPro.Conquilhas
7424:             loc_oPg.AddObject("txt_4c_Conquilhas", "TextBox")
7425:             WITH loc_oPg.txt_4c_Conquilhas
7426:                 .Top           = 179
7427:                 .Left          = 137
7428:                 .Width         = 80
7429:                 .Height        = 23
7430:                 .FontName      = "Tahoma"
7431:                 .FontSize      = 8
7432:                 .MaxLength     = 10
7433:                 .SpecialEffect = 1
7434:                 .Alignment     = 3
7435:                 .Value         = ""
7436:                 .Visible       = .T.
7437:             ENDWITH
7438:             BINDEVENT(loc_oPg.txt_4c_Conquilhas, "KeyPress", THIS, "ValidarConquilhaFaseP")

*-- Linhas 7454 a 7472:
7454:             ENDWITH
7455: 
7456:             *-- txt_4c_PesoBris: Peso Brilhante (getPesoBris)
7457:             *-- Original getPesoBris: top=204, left=137, width=80, height=23, ControlSource=crSigCdPro.PesoBris
7458:             loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
7459:             WITH loc_oPg.txt_4c_PesoBris
7460:                 .Top           = 204
7461:                 .Left          = 137
7462:                 .Width         = 80
7463:                 .Height        = 23
7464:                 .FontName      = "Tahoma"
7465:                 .FontSize      = 8
7466:                 .InputMask     = "99,999.999"
7467:                 .MaxLength     = 10
7468:                 .SpecialEffect = 1
7469:                 .Value         = 0
7470:                 .Visible       = .T.
7471:             ENDWITH
7472: 

*-- Linhas 7487 a 7505:
7487:             ENDWITH
7488: 
7489:             *-- txt_4c_PesoMetal: Peso Metal (getPesoMetal)
7490:             *-- Original getPesoMetal: top=229, left=137, width=80, height=23, ControlSource=crSigCdPro.PesoMetal
7491:             loc_oPg.AddObject("txt_4c_PesoMetal", "TextBox")
7492:             WITH loc_oPg.txt_4c_PesoMetal
7493:                 .Top           = 229
7494:                 .Left          = 137
7495:                 .Width         = 80
7496:                 .Height        = 23
7497:                 .FontName      = "Tahoma"
7498:                 .FontSize      = 8
7499:                 .InputMask     = "99,999.999"
7500:                 .MaxLength     = 10
7501:                 .SpecialEffect = 1
7502:                 .Value         = 0
7503:                 .Visible       = .T.
7504:             ENDWITH
7505: 

*-- Linhas 7520 a 7538:
7520:             ENDWITH
7521: 
7522:             *-- txt_4c_PesoPdrs: Peso de Pedras (getPesoPdrs)
7523:             *-- Original getPesoPdrs: top=254, left=137, width=80, height=23, ControlSource=crSigCdPro.PesoPdrs
7524:             loc_oPg.AddObject("txt_4c_PesoPdrs", "TextBox")
7525:             WITH loc_oPg.txt_4c_PesoPdrs
7526:                 .Top           = 254
7527:                 .Left          = 137
7528:                 .Width         = 80
7529:                 .Height        = 23
7530:                 .FontName      = "Tahoma"
7531:                 .FontSize      = 8
7532:                 .InputMask     = "99,999.999"
7533:                 .MaxLength     = 10
7534:                 .SpecialEffect = 1
7535:                 .Value         = 0
7536:                 .Visible       = .T.
7537:             ENDWITH
7538: 

*-- Linhas 7551 a 7586:
7551:             ENDWITH
7552: 
7553:             *-- txt_4c_CodCorsFP: Cor Padrao (getCor) - espelha Page1 CodCors
7554:             *-- Original getCor: top=279, left=137, width=38, ControlSource=crSigCdPro.CodCors
7555:             loc_oPg.AddObject("txt_4c_CodCorsFP", "TextBox")
7556:             WITH loc_oPg.txt_4c_CodCorsFP
7557:                 .Top           = 279
7558:                 .Left          = 137
7559:                 .Width         = 38
7560:                 .Height        = 23
7561:                 .FontName      = "Tahoma"
7562:                 .FontSize      = 8
7563:                 .MaxLength     = 4
7564:                 .SpecialEffect = 1
7565:                 .Value         = ""
7566:                 .Visible       = .T.
7567:             ENDWITH
7568:             BINDEVENT(loc_oPg.txt_4c_CodCorsFP, "KeyPress", THIS, "ValidarCorFaseP")
7569: 
7570:             *-- chk_4c_CravCera: Cravacao em Cera (opc_CravCera)
7571:             *-- Original opc_CravCera: top=283, left=180, ControlSource=crSigCdPro.CravCers
7572:             loc_oPg.AddObject("chk_4c_CravCera", "CheckBox")
7573:             WITH loc_oPg.chk_4c_CravCera
7574:                 .Caption       = "Crava" + CHR(231) + CHR(227) + "o em Cera"
7575:                 .Top           = 283
7576:                 .Left          = 180
7577:                 .FontName      = "Tahoma"
7578:                 .FontSize      = 8
7579:                 .BackStyle     = 0
7580:                 .AutoSize      = .T.
7581:                 .Alignment     = 0
7582:                 .Value         = 0
7583:                 .SpecialEffect = 1
7584:                 .ForeColor     = RGB(90, 90, 90)
7585:                 .Visible       = .T.
7586:             ENDWITH

*-- Linhas 7600 a 7635:
7600:             ENDWITH
7601: 
7602:             *-- txt_4c_CodTamsFP: Tamanho Padrao (getTam) - espelha Page1 CodTams
7603:             *-- Original getTam: top=304, left=137, width=38, ControlSource=crSigCdPro.CodTams
7604:             loc_oPg.AddObject("txt_4c_CodTamsFP", "TextBox")
7605:             WITH loc_oPg.txt_4c_CodTamsFP
7606:                 .Top           = 304
7607:                 .Left          = 137
7608:                 .Width         = 38
7609:                 .Height        = 23
7610:                 .FontName      = "Tahoma"
7611:                 .FontSize      = 8
7612:                 .MaxLength     = 4
7613:                 .SpecialEffect = 1
7614:                 .Value         = ""
7615:                 .Visible       = .T.
7616:             ENDWITH
7617:             BINDEVENT(loc_oPg.txt_4c_CodTamsFP, "KeyPress", THIS, "ValidarTamFaseP")
7618: 
7619:             *-- chk_4c_Varias: Peso Variavel (fwoption1)
7620:             *-- Original fwoption1: top=308, left=180, ControlSource=crSigCdPro.Varias
7621:             loc_oPg.AddObject("chk_4c_Varias", "CheckBox")
7622:             WITH loc_oPg.chk_4c_Varias
7623:                 .Caption       = "Peso Vari" + CHR(225) + "vel"
7624:                 .Top           = 308
7625:                 .Left          = 180
7626:                 .FontName      = "Tahoma"
7627:                 .FontSize      = 8
7628:                 .BackStyle     = 0
7629:                 .AutoSize      = .T.
7630:                 .Alignment     = 0
7631:                 .Value         = 0
7632:                 .SpecialEffect = 1
7633:                 .ForeColor     = RGB(90, 90, 90)
7634:                 .Visible       = .T.
7635:             ENDWITH

*-- Linhas 7652 a 7670:
7652:             ENDWITH
7653: 
7654:             *-- txt_4c_CodAcbsFP: Codigo de Acabamento (get_codacb)
7655:             *-- Original get_codacb: top=329, left=137, width=38, ControlSource=crSigCdPro.codAcbs
7656:             loc_oPg.AddObject("txt_4c_CodAcbsFP", "TextBox")
7657:             WITH loc_oPg.txt_4c_CodAcbsFP
7658:                 .Top           = 329
7659:                 .Left          = 137
7660:                 .Width         = 38
7661:                 .Height        = 23
7662:                 .FontName      = "Tahoma"
7663:                 .FontSize      = 8
7664:                 .MaxLength     = 3
7665:                 .SpecialEffect = 1
7666:                 .Value         = ""
7667:                 .Visible       = .T.
7668:             ENDWITH
7669:             BINDEVENT(loc_oPg.txt_4c_CodAcbsFP, "KeyPress", THIS, "ValidarAcabamentoFaseP")
7670: 

*-- Linhas 7701 a 7719:
7701:             ENDWITH
7702: 
7703:             *-- txt_4c_TEnts: Tempo de Entrega em Dias (getTEnts)
7704:             *-- Original getTEnts: top=355, left=137, width=31, height=23, ControlSource=crSigCdPro.tents
7705:             loc_oPg.AddObject("txt_4c_TEnts", "TextBox")
7706:             WITH loc_oPg.txt_4c_TEnts
7707:                 .Top           = 355
7708:                 .Left          = 137
7709:                 .Width         = 31
7710:                 .Height        = 23
7711:                 .FontName      = "Tahoma"
7712:                 .FontSize      = 8
7713:                 .InputMask     = "999"
7714:                 .MaxLength     = 10
7715:                 .SpecialEffect = 1
7716:                 .Value         = 0
7717:                 .Visible       = .T.
7718:             ENDWITH
7719: 

*-- Linhas 7750 a 7768:
7750:             ENDWITH
7751: 
7752:             *-- txt_4c_DiasGar: Dias de Garantia (getDiasGar)
7753:             *-- Original getDiasGar: top=380, left=137, width=31, height=23, ControlSource=crSigCdPro.DiasGar
7754:             loc_oPg.AddObject("txt_4c_DiasGar", "TextBox")
7755:             WITH loc_oPg.txt_4c_DiasGar
7756:                 .Top           = 380
7757:                 .Left          = 137
7758:                 .Width         = 31
7759:                 .Height        = 23
7760:                 .FontName      = "Tahoma"
7761:                 .FontSize      = 8
7762:                 .InputMask     = "999"
7763:                 .MaxLength     = 3
7764:                 .SpecialEffect = 1
7765:                 .Value         = 0
7766:                 .Visible       = .T.
7767:             ENDWITH
7768: 

*-- Linhas 7799 a 7817:
7799:             ENDWITH
7800: 
7801:             *-- txt_4c_Volumes: Numero de Volumes (fwget3)
7802:             *-- Original fwget3: top=405, left=137, width=31, height=23, ControlSource=crSigCdPro.volumes
7803:             loc_oPg.AddObject("txt_4c_Volumes", "TextBox")
7804:             WITH loc_oPg.txt_4c_Volumes
7805:                 .Top           = 405
7806:                 .Left          = 137
7807:                 .Width         = 31
7808:                 .Height        = 23
7809:                 .FontName      = "Tahoma"
7810:                 .FontSize      = 8
7811:                 .MaxLength     = 3
7812:                 .SpecialEffect = 1
7813:                 .Value         = 0
7814:                 .Visible       = .T.
7815:             ENDWITH
7816: 
7817:             *-- lbl_4c_Say21: "Lote Minimo :"

*-- Linhas 7831 a 7849:
7831:             ENDWITH
7832: 
7833:             *-- txt_4c_LtMinsV: Lote Minimo de Venda (getLtMinsV)
7834:             *-- Original getLtMinsV: top=430, left=137, width=80, height=23, ControlSource=crSigCdPro.ltminsv
7835:             loc_oPg.AddObject("txt_4c_LtMinsV", "TextBox")
7836:             WITH loc_oPg.txt_4c_LtMinsV
7837:                 .Top           = 430
7838:                 .Left          = 137
7839:                 .Width         = 80
7840:                 .Height        = 23
7841:                 .FontName      = "Tahoma"
7842:                 .FontSize      = 8
7843:                 .InputMask     = "999,999.99"
7844:                 .MaxLength     = 10
7845:                 .SpecialEffect = 1
7846:                 .Value         = 0
7847:                 .Visible       = .T.
7848:             ENDWITH
7849: 

*-- Linhas 7864 a 7924:
7864:             ENDWITH
7865: 
7866:             *-- txt_4c_DtUcp: Data da ultima compra (get_Dtucp) - somente leitura
7867:             *-- Original get_Dtucp: top=455, left=137, width=79, height=23, ControlSource=crSigCdPro.UltComps
7868:             loc_oPg.AddObject("txt_4c_DtUcp", "TextBox")
7869:             WITH loc_oPg.txt_4c_DtUcp
7870:                 .Top               = 455
7871:                 .Left              = 137
7872:                 .Width             = 79
7873:                 .Height            = 23
7874:                 .FontName          = "Tahoma"
7875:                 .FontSize          = 8
7876:                 .MaxLength         = 10
7877:                 .SpecialEffect     = 1
7878:                 .ReadOnly          = .T.
7879:                 .Value             = ""
7880:                 .BackColor         = RGB(240, 240, 240)
7881:                 .ForeColor         = RGB(0, 0, 0)
7882:                 .DisabledBackColor = RGB(224, 235, 235)
7883:                 .DisabledForeColor = RGB(36, 84, 155)
7884:                 .Visible           = .T.
7885:             ENDWITH
7886: 
7887:             *-- txt_4c_VUcp: Valor da ultima compra (Get_vucp) - somente leitura
7888:             *-- Original Get_vucp: top=455, left=217, width=97, height=23, ControlSource=crSigCdPro.vUltComps
7889:             loc_oPg.AddObject("txt_4c_VUcp", "TextBox")
7890:             WITH loc_oPg.txt_4c_VUcp
7891:                 .Top               = 455
7892:                 .Left              = 217
7893:                 .Width             = 97
7894:                 .Height            = 23
7895:                 .FontName          = "Tahoma"
7896:                 .FontSize          = 8
7897:                 .InputMask         = "99,999.99999"
7898:                 .SpecialEffect     = 1
7899:                 .ReadOnly          = .T.
7900:                 .Value             = 0
7901:                 .BackColor         = RGB(240, 240, 240)
7902:                 .ForeColor         = RGB(0, 0, 0)
7903:                 .DisabledBackColor = RGB(224, 235, 235)
7904:                 .DisabledForeColor = RGB(36, 84, 155)
7905:                 .Visible           = .T.
7906:             ENDWITH
7907: 
7908:             *-- txt_4c_MUcp: Moeda da ultima compra (Get_mucp) - somente leitura
7909:             *-- Original Get_mucp: top=455, left=315, width=31, height=23, ControlSource=crSigCdPro.MUltComps
7910:             loc_oPg.AddObject("txt_4c_MUcp", "TextBox")
7911:             WITH loc_oPg.txt_4c_MUcp
7912:                 .Top               = 455
7913:                 .Left              = 315
7914:                 .Width             = 31
7915:                 .Height            = 23
7916:                 .FontName          = "Tahoma"
7917:                 .FontSize          = 8
7918:                 .MaxLength         = 3
7919:                 .SpecialEffect     = 1
7920:                 .ReadOnly          = .T.
7921:                 .Value             = ""
7922:                 .BackColor         = RGB(240, 240, 240)
7923:                 .ForeColor         = RGB(0, 0, 0)
7924:                 .DisabledBackColor = RGB(224, 235, 235)

*-- Linhas 7943 a 7961:
7943:             ENDWITH
7944: 
7945:             *-- opt_4c_Prodvars: Variacao p/ e-commerce Sim/Nao (Fwoption2)
7946:             *-- Original Fwoption2: top=482, left=132, width=93, height=15, ControlSource=crSigCdPro.prodvars
7947:             loc_oPg.AddObject("opt_4c_Prodvars", "OptionGroup")
7948:             WITH loc_oPg.opt_4c_Prodvars
7949:                 .ButtonCount = 2
7950:                 .Value       = 1
7951:                 .Top         = 482
7952:                 .Left        = 132
7953:                 .Width       = 93
7954:                 .Height      = 15
7955:                 .BackStyle   = 0
7956:                 .BorderStyle = 0
7957:                 .Visible     = .T.
7958:                 .Option1.Caption   = "Sim"
7959:                 .Option1.FontName  = "Tahoma"
7960:                 .Option1.FontSize  = 8
7961:                 .Option1.BackStyle = 0

*-- Linhas 7999 a 8033:
7999:             ENDWITH
8000: 
8001:             *-- txt_4c_Desc: Descricao da fase selecionada (Get_Desc) - somente leitura
8002:             *-- Original Get_Desc: top=505, left=595, width=395, height=23, ControlSource=crSigCdGcr.descrs
8003:             loc_oPg.AddObject("txt_4c_Desc", "TextBox")
8004:             WITH loc_oPg.txt_4c_Desc
8005:                 .Top           = 505
8006:                 .Left          = 595
8007:                 .Width         = 395
8008:                 .Height        = 23
8009:                 .FontName      = "Tahoma"
8010:                 .FontSize      = 8
8011:                 .SpecialEffect = 1
8012:                 .ReadOnly      = .T.
8013:                 .Value         = ""
8014:                 .Visible       = .T.
8015:             ENDWITH
8016: 
8017:             *-- edt_4c_Obs: Observacoes da fase (Get_Obs - fwmemo)
8018:             *-- Original Get_Obs: top=531, left=527, width=463, height=92, ControlSource=crSigCdPrf.Obs
8019:             loc_oPg.AddObject("edt_4c_Obs", "EditBox")
8020:             WITH loc_oPg.edt_4c_Obs
8021:                 .Top           = 531
8022:                 .Left          = 527
8023:                 .Width         = 463
8024:                 .Height        = 92
8025:                 .FontName      = "Tahoma"
8026:                 .FontSize      = 8
8027:                 .SpecialEffect = 1
8028:                 .Value         = ""
8029:                 .Visible       = .T.
8030:             ENDWITH
8031: 
8032:             *--------------------------------------------------------------
8033:             *-- Area de Matrizes (grdMatrizes + shpBorracha + ImgBorracha)

*-- Linhas 8107 a 8161:
8107:                 .FontName          = "Tahoma"
8108:                 .FontSize          = 8
8109:                 .RecordMark        = .F.
8110:                 .DeleteMark        = .F.
8111:                 .HeaderHeight      = 20
8112:                 .RowHeight         = 18
8113:                 .ScrollBars        = 2
8114:                 .GridLines         = 3
8115:                 .GridLineColor     = RGB(238, 238, 238)
8116:                 .HighlightBackColor = RGB(255, 255, 255)
8117:                 .HighlightForeColor = RGB(15, 41, 104)
8118:                 .HighlightStyle    = 2
8119:                 .AllowHeaderSizing = .F.
8120:                 .AllowRowSizing    = .F.
8121:                 .Visible           = .T.
8122:             ENDWITH
8123:             loc_oPg.grd_4c_GrdMatrizes.ColumnCount  = 3
8124:             loc_oPg.grd_4c_GrdMatrizes.RecordSource = "cursor_4c_GrdMatrizes"
8125:             loc_oGrid2 = loc_oPg.grd_4c_GrdMatrizes
8126: 
8127:             *-- Column1: Matriz (cmats C14) - lookup, width=108
8128:             loc_oGrid2.Column1.ControlSource   = "cursor_4c_GrdMatrizes.cmats"
8129:             loc_oGrid2.Column1.Width           = 108
8130:             loc_oGrid2.Column1.ReadOnly        = .F.
8131:             loc_oGrid2.Column1.Movable         = .F.
8132:             loc_oGrid2.Column1.Resizable       = .F.
8133:             loc_oGrid2.Column1.Header1.Caption = "Matriz"
8134:             BINDEVENT(loc_oGrid2.Column1.Text1, "Valid", THIS, "GrdMatrizesCol1Valid")
8135: 
8136:             *-- Column2: Qtde (qtds N3,0) - width=34
8137:             loc_oGrid2.Column2.ControlSource   = "cursor_4c_GrdMatrizes.qtds"
8138:             loc_oGrid2.Column2.Width           = 34
8139:             loc_oGrid2.Column2.ReadOnly        = .F.
8140:             loc_oGrid2.Column2.Movable         = .F.
8141:             loc_oGrid2.Column2.Resizable       = .F.
8142:             loc_oGrid2.Column2.InputMask       = "9999"
8143:             loc_oGrid2.Column2.Header1.Caption = "Qtde"
8144: 
8145:             *-- Column3: Local (dpros C65) - somente leitura (descricao do produto matriz), width=80
8146:             loc_oGrid2.Column3.ControlSource   = "cursor_4c_GrdMatrizes.dpros"
8147:             loc_oGrid2.Column3.Width           = 80
8148:             loc_oGrid2.Column3.ReadOnly        = .T.
8149:             loc_oGrid2.Column3.Movable         = .F.
8150:             loc_oGrid2.Column3.Resizable       = .F.
8151:             loc_oGrid2.Column3.Header1.Caption = "Local"
8152: 
8153:             BINDEVENT(loc_oGrid2, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
8154: 
8155:         CATCH TO loc_oErro
8156:             MostrarErro("Erro ao configurar p" + CHR(225) + "gina Processos de Produ" + ;
8157:                 CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, ;
8158:                 "FormProduto.ConfigurarPgPgDadosFaseP")
8159:         ENDTRY
8160:     ENDPROC
8161: 

*-- Linhas 8176 a 8260:
8176:             IF USED("cursor_4c_GradFase")
8177:                 USE IN cursor_4c_GradFase
8178:             ENDIF
8179:             loc_nRet = SQLEXEC(gnConnHandle, ;
8180:                 "SELECT cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs" + ;
8181:                 " FROM SigCdPrf WHERE produtos = " + EscaparSQL(loc_cCpros) + ;
8182:                 " ORDER BY ordems", "cursor_4c_GradFase")
8183:             IF loc_nRet <= 0
8184:                 CREATE CURSOR cursor_4c_GradFase ( ;
8185:                     cidchaves C(20), ordems N(2,0), grupos C(10), ;
8186:                     minutos   N(9,1), uniprdts C(10), matprdts C(15), obs M)
8187:             ENDIF
8188:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8189:                 loc_oPg.grd_4c_GradFase.ColumnCount = 5
8190:                 loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8191:                 loc_oPg.grd_4c_GradFase.Column1.ControlSource = "cursor_4c_GradFase.ordems"
8192:                 loc_oPg.grd_4c_GradFase.Column2.ControlSource = "cursor_4c_GradFase.grupos"
8193:                 loc_oPg.grd_4c_GradFase.Column3.ControlSource = "cursor_4c_GradFase.minutos"
8194:                 loc_oPg.grd_4c_GradFase.Column4.ControlSource = "cursor_4c_GradFase.uniprdts"
8195:                 loc_oPg.grd_4c_GradFase.Column5.ControlSource = "cursor_4c_GradFase.matprdts"
8196:                 loc_oPg.grd_4c_GradFase.Column1.Header1.Caption = "Ordem"
8197:                 loc_oPg.grd_4c_GradFase.Column2.Header1.Caption = "Fase"
8198:                 loc_oPg.grd_4c_GradFase.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
8199:                 loc_oPg.grd_4c_GradFase.Column4.Header1.Caption = "Uni. Produtiva"
8200:                 loc_oPg.grd_4c_GradFase.Column5.Header1.Caption = "Material"
8201:                 loc_oPg.grd_4c_GradFase.Refresh()
8202:             ENDIF
8203: 
8204:             *-- Carregar grdMatrizes de SigPrMtz + SigCdPro (descricao do produto matriz)
8205:             IF USED("cursor_4c_GrdMatrizes")
8206:                 USE IN cursor_4c_GrdMatrizes
8207:             ENDIF
8208:             loc_nRet = SQLEXEC(gnConnHandle, ;
8209:                 "SELECT m.cidchaves, m.cmats, m.qtds, ISNULL(p.dpros,'') AS dpros" + ;
8210:                 " FROM SigPrMtz m LEFT JOIN SigCdPro p ON p.cpros = m.cmats" + ;
8211:                 " WHERE m.cpros = " + EscaparSQL(loc_cCpros) + ;
8212:                 " ORDER BY m.cmats", "cursor_4c_GrdMatrizes")
8213:             IF loc_nRet <= 0
8214:                 CREATE CURSOR cursor_4c_GrdMatrizes ( ;
8215:                     cidchaves C(20), cmats C(14), qtds N(3,0), dpros C(65))
8216:             ENDIF
8217:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
8218:                 loc_oPg.grd_4c_GrdMatrizes.ColumnCount = 3
8219:                 loc_oPg.grd_4c_GrdMatrizes.RecordSource = "cursor_4c_GrdMatrizes"
8220:                 loc_oPg.grd_4c_GrdMatrizes.Column1.ControlSource = "cursor_4c_GrdMatrizes.cmats"
8221:                 loc_oPg.grd_4c_GrdMatrizes.Column2.ControlSource = "cursor_4c_GrdMatrizes.qtds"
8222:                 loc_oPg.grd_4c_GrdMatrizes.Column3.ControlSource = "cursor_4c_GrdMatrizes.dpros"
8223:                 loc_oPg.grd_4c_GrdMatrizes.Column1.Header1.Caption = "Matriz"
8224:                 loc_oPg.grd_4c_GrdMatrizes.Column2.Header1.Caption = "Qtde"
8225:                 loc_oPg.grd_4c_GrdMatrizes.Column3.Header1.Caption = "Local"
8226:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
8227:             ENDIF
8228: 
8229:         CATCH TO loException
8230:             MostrarErro("Erro ao carregar FaseP:" + CHR(13) + loException.Message + ;
8231:                 CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
8232:                 "FormProduto.CarregarFaseP")
8233:         ENDTRY
8234:     ENDPROC
8235: 
8236:     *===========================================================================
8237:     * GrdFaseBeforeRowColChange - Persiste obs do EditBox no cursor antes de mudar linha
8238:     * PUBLIC: BINDEVENT requer metodo publico
8239:     *===========================================================================
8240:     PROCEDURE GrdFaseBeforeRowColChange(par_nColIndex)
8241:         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
8242:             LOCAL loc_oPgBC
8243:             loc_oPgBC = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8244:             IF PEMSTATUS(loc_oPgBC, "edt_4c_Obs", 5)
8245:                 SELECT cursor_4c_GradFase
8246:                 REPLACE cursor_4c_GradFase.obs WITH loc_oPgBC.edt_4c_Obs.Value
8247:             ENDIF
8248:         ENDIF
8249:     ENDPROC
8250: 
8251:     *===========================================================================
8252:     * GrdFaseAfterRowColChange - Exibe imagem da fase e atualiza descricao
8253:     * PUBLIC: BINDEVENT requer metodo publico
8254:     *===========================================================================
8255:     PROCEDURE GrdFaseAfterRowColChange(par_nColIndex)
8256:         LOCAL loc_oPg, loc_lcArquivo, loc_nRet, loException
8257:         TRY
8258:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8259:             IF !PEMSTATUS(loc_oPg, "img_4c_ImgFig", 5) OR !USED("cursor_4c_GradFase")
8260:                 RETURN

*-- Linhas 8268 a 8316:
8268: 
8269:             IF !EOF("cursor_4c_GradFase") AND !BOF("cursor_4c_GradFase")
8270:                 LOCAL loc_cGrupos, loc_cCidchaves
8271:                 SELECT cursor_4c_GradFase
8272:                 loc_cGrupos    = ALLTRIM(cursor_4c_GradFase.grupos)
8273:                 loc_cCidchaves = ALLTRIM(cursor_4c_GradFase.cidchaves)
8274: 
8275:                 *-- Carregar descricao do grupo/fase (SigCdGcr)
8276:                 IF !EMPTY(loc_cGrupos)
8277:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8278:                         "SELECT descrs FROM SigCdGcr WHERE codigos = '" + ;
8279:                         EscaparSQL(loc_cGrupos) + "", "cursor_4c_FaseGcrDesc")
8280:                     IF loc_nRet > 0 AND USED("cursor_4c_FaseGcrDesc") AND !EOF("cursor_4c_FaseGcrDesc")
8281:                         SELECT cursor_4c_FaseGcrDesc
8282:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_FaseGcrDesc.descrs)
8283:                     ENDIF
8284:                     IF USED("cursor_4c_FaseGcrDesc")
8285:                         USE IN cursor_4c_FaseGcrDesc
8286:                     ENDIF
8287:                 ENDIF
8288: 
8289:                 *-- Obs vem do cursor (ja carregado em CarregarFaseP / gravado por BeforeRowColChange)
8290:                 SELECT cursor_4c_GradFase
8291:                 IF !ISNULL(cursor_4c_GradFase.obs)
8292:                     loc_oPg.edt_4c_Obs.Value = cursor_4c_GradFase.obs
8293:                 ENDIF
8294: 
8295:                 *-- Figura carregada do banco (campo figprocs - binario nao armazenado no cursor)
8296:                 IF !EMPTY(loc_cCidchaves)
8297:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8298:                         "SELECT figprocs FROM SigCdPrf WHERE cidchaves = '" + ;
8299:                         EscaparSQL(loc_cCidchaves) + "", "cursor_4c_FasePrfFig")
8300:                     IF loc_nRet > 0 AND USED("cursor_4c_FasePrfFig") AND !EOF("cursor_4c_FasePrfFig")
8301:                         SELECT cursor_4c_FasePrfFig
8302:                         IF !ISNULL(cursor_4c_FasePrfFig.figprocs) AND ;
8303:                                 !EMPTY(cursor_4c_FasePrfFig.figprocs)
8304:                             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
8305:                             IF STRTOFILE(cursor_4c_FasePrfFig.figprocs, loc_lcArquivo) > 0
8306:                                 loc_oPg.img_4c_ImgFig.Visible = .T.
8307:                                 loc_oPg.img_4c_ImgFig.Picture = loc_lcArquivo
8308:                             ENDIF
8309:                         ENDIF
8310:                     ENDIF
8311:                     IF USED("cursor_4c_FasePrfFig")
8312:                         USE IN cursor_4c_FasePrfFig
8313:                     ENDIF
8314:                 ENDIF
8315:             ENDIF
8316: 

*-- Linhas 8326 a 8402:
8326:     *===========================================================================
8327:     PROCEDURE GrdFaseCol1OrdValid()
8328:         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
8329:             SELECT cursor_4c_GradFase
8330:             IF cursor_4c_GradFase.ordems <= 0
8331:                 MsgAviso("Ordem deve ser maior que zero.", "Fase")
8332:                 RETURN .F.
8333:             ENDIF
8334:         ENDIF
8335:         RETURN .T.
8336:     ENDPROC
8337: 
8338:     *===========================================================================
8339:     * GrdFaseCol2FaseValid - Lookup de fase/grupo (SigCdGcr) na GradFase
8340:     * PUBLIC: BINDEVENT requer metodo publico
8341:     *===========================================================================
8342:     PROCEDURE GrdFaseCol2FaseValid()
8343:         LOCAL loc_cValAtual, loc_nRet, loc_oBusca, loException
8344:         TRY
8345:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8346:                 loc_lResultado = .T.
8347:             ENDIF
8348:             SELECT cursor_4c_GradFase
8349:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.grupos)
8350:             IF EMPTY(loc_cValAtual)
8351:                 loc_lResultado = .T.
8352:             ENDIF
8353: 
8354:             loc_nRet = SQLEXEC(gnConnHandle, ;
8355:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = '" + ;
8356:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_FaseGcrBusca")
8357:             IF loc_nRet > 0 AND USED("cursor_4c_FaseGcrBusca") AND !EOF("cursor_4c_FaseGcrBusca")
8358:                 IF USED("cursor_4c_FaseGcrBusca")
8359:                     USE IN cursor_4c_FaseGcrBusca
8360:                 ENDIF
8361:                 loc_lResultado = .T.
8362:             ENDIF
8363:             IF USED("cursor_4c_FaseGcrBusca")
8364:                 USE IN cursor_4c_FaseGcrBusca
8365:             ENDIF
8366: 
8367:             *-- Codigo nao encontrado: abrir busca
8368:             loc_nRet = SQLEXEC(gnConnHandle, ;
8369:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos LIKE '" + ;
8370:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY codigos", "cursor_4c_FaseGcrBusca")
8371:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseGcrBusca") OR EOF("cursor_4c_FaseGcrBusca")
8372:                 IF USED("cursor_4c_FaseGcrBusca")
8373:                     USE IN cursor_4c_FaseGcrBusca
8374:                 ENDIF
8375:                 SQLEXEC(gnConnHandle, ;
8376:                     "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos", ;
8377:                     "cursor_4c_FaseGcrBusca")
8378:             ENDIF
8379: 
8380:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8381:             IF VARTYPE(loc_oBusca) = "O"
8382:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FaseGcrBusca"
8383:                 loc_oBusca.DefinirCursor("cursor_4c_FaseGcrBusca", "codigos", "descrs", ;
8384:                     "Selecionar Fase/Grupo")
8385:                 loc_oBusca.Mostrar()
8386:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8387:                     SELECT cursor_4c_GradFase
8388:                     REPLACE cursor_4c_GradFase.grupos WITH loc_oBusca.cCodigoSelecionado
8389:                 ENDIF
8390:                 loc_oBusca = .NULL.
8391:             ENDIF
8392: 
8393:             IF USED("cursor_4c_FaseGcrBusca")
8394:                 USE IN cursor_4c_FaseGcrBusca
8395:             ENDIF
8396: 
8397:         CATCH TO loException
8398:             IF USED("cursor_4c_FaseGcrBusca")
8399:                 USE IN cursor_4c_FaseGcrBusca
8400:             ENDIF
8401:             MostrarErro("Erro ao validar fase:" + CHR(13) + loException.Message, ;
8402:                 "FormProduto.GrdFaseCol2FaseValid")

*-- Linhas 8414 a 8473:
8414:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8415:                 loc_lResultado = .T.
8416:             ENDIF
8417:             SELECT cursor_4c_GradFase
8418:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.uniprdts)
8419:             loc_cGrupos   = ALLTRIM(cursor_4c_GradFase.grupos)
8420:             IF EMPTY(loc_cValAtual)
8421:                 loc_lResultado = .T.
8422:             ENDIF
8423: 
8424:             loc_nRet = SQLEXEC(gnConnHandle, ;
8425:                 "SELECT uniprdts FROM SigCdUpd WHERE codigos = " + ;
8426:                 EscaparSQL(loc_cGrupos), "cursor_4c_FaseUpdBusca")
8427:             IF loc_nRet > 0 AND USED("cursor_4c_FaseUpdBusca")
8428:                 LOCATE FOR ALLTRIM(cursor_4c_FaseUpdBusca.uniprdts) == ALLTRIM(loc_cValAtual)
8429:                 IF !EOF("cursor_4c_FaseUpdBusca")
8430:                     loc_lResultado = .T.
8431:                 ENDIF
8432:                 USE IN cursor_4c_FaseUpdBusca
8433:             ENDIF
8434:             IF USED("cursor_4c_FaseUpdBusca")
8435:                 USE IN cursor_4c_FaseUpdBusca
8436:             ENDIF
8437: 
8438:             *-- Abrir busca das unidades produtivas para este grupo
8439:             loc_nRet = SQLEXEC(gnConnHandle, ;
8440:                 "SELECT uniprdts FROM SigCdUpd WHERE codigos = " + ;
8441:                 EscaparSQL(loc_cGrupos) + " ORDER BY uniprdts", "cursor_4c_FaseUpdBusca")
8442:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseUpdBusca") OR EOF("cursor_4c_FaseUpdBusca")
8443:                 IF USED("cursor_4c_FaseUpdBusca")
8444:                     USE IN cursor_4c_FaseUpdBusca
8445:                 ENDIF
8446:                 SQLEXEC(gnConnHandle, ;
8447:                     "SELECT DISTINCT uniprdts FROM SigCdUpd ORDER BY uniprdts", ;
8448:                     "cursor_4c_FaseUpdBusca")
8449:             ENDIF
8450: 
8451:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8452:             IF VARTYPE(loc_oBusca) = "O"
8453:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FaseUpdBusca"
8454:                 loc_oBusca.DefinirCursor("cursor_4c_FaseUpdBusca", "uniprdts", "uniprdts", ;
8455:                     "Selecionar Uni. Produtiva")
8456:                 loc_oBusca.Mostrar()
8457:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8458:                     SELECT cursor_4c_GradFase
8459:                     REPLACE cursor_4c_GradFase.uniprdts WITH loc_oBusca.cCodigoSelecionado
8460:                 ENDIF
8461:                 loc_oBusca = .NULL.
8462:             ENDIF
8463: 
8464:             IF USED("cursor_4c_FaseUpdBusca")
8465:                 USE IN cursor_4c_FaseUpdBusca
8466:             ENDIF
8467: 
8468:         CATCH TO loException
8469:             IF USED("cursor_4c_FaseUpdBusca")
8470:                 USE IN cursor_4c_FaseUpdBusca
8471:             ENDIF
8472:             MostrarErro("Erro ao validar uni. produtiva:" + CHR(13) + loException.Message, ;
8473:                 "FormProduto.GrdFaseCol4UniPrdtValid")

*-- Linhas 8485 a 8544:
8485:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8486:                 loc_lResultado = .T.
8487:             ENDIF
8488:             SELECT cursor_4c_GradFase
8489:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.matprdts)
8490:             loc_cGrupos   = ALLTRIM(cursor_4c_GradFase.grupos)
8491:             IF EMPTY(loc_cValAtual)
8492:                 loc_lResultado = .T.
8493:             ENDIF
8494: 
8495:             loc_nRet = SQLEXEC(gnConnHandle, ;
8496:                 "SELECT cods, descs FROM SigOpOpt WHERE cods = '" + ;
8497:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_FaseOptBusca")
8498:             IF loc_nRet > 0 AND USED("cursor_4c_FaseOptBusca") AND !EOF("cursor_4c_FaseOptBusca")
8499:                 IF USED("cursor_4c_FaseOptBusca")
8500:                     USE IN cursor_4c_FaseOptBusca
8501:                 ENDIF
8502:                 loc_lResultado = .T.
8503:             ENDIF
8504:             IF USED("cursor_4c_FaseOptBusca")
8505:                 USE IN cursor_4c_FaseOptBusca
8506:             ENDIF
8507: 
8508:             *-- Abrir busca filtrando pelo grupo da fase
8509:             loc_nRet = SQLEXEC(gnConnHandle, ;
8510:                 "SELECT cods, descs FROM SigOpOpt WHERE grupos = '" + ;
8511:                 EscaparSQL(loc_cGrupos) + " AND cods LIKE '" + ;
8512:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_FaseOptBusca")
8513:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseOptBusca") OR EOF("cursor_4c_FaseOptBusca")
8514:                 IF USED("cursor_4c_FaseOptBusca")
8515:                     USE IN cursor_4c_FaseOptBusca
8516:                 ENDIF
8517:                 SQLEXEC(gnConnHandle, ;
8518:                     "SELECT cods, descs FROM SigOpOpt ORDER BY cods", ;
8519:                     "cursor_4c_FaseOptBusca")
8520:             ENDIF
8521: 
8522:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8523:             IF VARTYPE(loc_oBusca) = "O"
8524:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FaseOptBusca"
8525:                 loc_oBusca.DefinirCursor("cursor_4c_FaseOptBusca", "cods", "descs", ;
8526:                     "Selecionar Material")
8527:                 loc_oBusca.Mostrar()
8528:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8529:                     SELECT cursor_4c_GradFase
8530:                     REPLACE cursor_4c_GradFase.matprdts WITH loc_oBusca.cCodigoSelecionado
8531:                 ENDIF
8532:                 loc_oBusca = .NULL.
8533:             ENDIF
8534: 
8535:             IF USED("cursor_4c_FaseOptBusca")
8536:                 USE IN cursor_4c_FaseOptBusca
8537:             ENDIF
8538: 
8539:         CATCH TO loException
8540:             IF USED("cursor_4c_FaseOptBusca")
8541:                 USE IN cursor_4c_FaseOptBusca
8542:             ENDIF
8543:             MostrarErro("Erro ao validar material:" + CHR(13) + loException.Message, ;
8544:                 "FormProduto.GrdFaseCol5MatPrdtValid")

*-- Linhas 8561 a 8588:
8561:                 RETURN
8562:             ENDIF
8563: 
8564:             SELECT cursor_4c_GradFase
8565:             IF EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase") OR ;
8566:                     RECCOUNT("cursor_4c_GradFase") = 0
8567:                 loc_nProxOrdem = 1
8568:             ELSE
8569:                 GO BOTTOM IN cursor_4c_GradFase
8570:                 loc_nProxOrdem = cursor_4c_GradFase.ordems + 1
8571:             ENDIF
8572: 
8573:             INSERT INTO cursor_4c_GradFase (cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs) ;
8574:                 VALUES (SYS(2015), loc_nProxOrdem, "", 0, "", "", "")
8575: 
8576:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8577:                 loc_oPg.grd_4c_GradFase.Refresh()
8578:                 GO BOTTOM IN cursor_4c_GradFase
8579:                 loc_oPg.grd_4c_GradFase.Column2.SetFocus()
8580:             ENDIF
8581: 
8582:         CATCH TO loException
8583:             MostrarErro("Erro ao inserir fase:" + CHR(13) + loException.Message, ;
8584:                 "FormProduto.BtnInserirFaseClick")
8585:         ENDTRY
8586:     ENDPROC
8587: 
8588:     *===========================================================================

*-- Linhas 8599 a 8621:
8599:                 RETURN
8600:             ENDIF
8601: 
8602:             SELECT cursor_4c_GradFase
8603:             IF !MsgConfirma("Excluir esta fase de produ" + CHR(231) + CHR(227) + "o?")
8604:                 RETURN
8605:             ENDIF
8606:             DELETE IN cursor_4c_GradFase
8607:             IF !EOF("cursor_4c_GradFase")
8608:                 SKIP IN cursor_4c_GradFase
8609:             ENDIF
8610:             IF EOF("cursor_4c_GradFase") AND RECCOUNT("cursor_4c_GradFase") > 0
8611:                 GO BOTTOM IN cursor_4c_GradFase
8612:             ENDIF
8613: 
8614:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8615:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8616:                 loc_oPg.grd_4c_GradFase.Refresh()
8617:             ENDIF
8618: 
8619:         CATCH TO loException
8620:             MostrarErro("Erro ao excluir fase:" + CHR(13) + loException.Message, ;
8621:                 "FormProduto.BtnExcluirFaseClick")

*-- Linhas 8637 a 8663:
8637:                 RETURN
8638:             ENDIF
8639: 
8640:             SELECT cursor_4c_GradFase
8641:             IF EOF("cursor_4c_GradFase") OR RECCOUNT("cursor_4c_GradFase") = 0
8642:                 loc_nOrdemAtual = 0
8643:             ELSE
8644:                 loc_nOrdemAtual = cursor_4c_GradFase.ordems
8645:             ENDIF
8646:             loc_nProxOrdem = loc_nOrdemAtual + 1
8647: 
8648:             INSERT INTO cursor_4c_GradFase (cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs) ;
8649:                 VALUES (SYS(2015), loc_nProxOrdem, "", 0, "", "", "")
8650: 
8651:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8652:                 loc_oPg.grd_4c_GradFase.Refresh()
8653:                 GO BOTTOM IN cursor_4c_GradFase
8654:                 loc_oPg.grd_4c_GradFase.Column2.SetFocus()
8655:             ENDIF
8656: 
8657:         CATCH TO loException
8658:             MostrarErro("Erro ao inserir fase alternativa:" + CHR(13) + loException.Message, ;
8659:                 "FormProduto.BtnAlternativaFaseClick")
8660:         ENDTRY
8661:     ENDPROC
8662: 
8663:     *===========================================================================

*-- Linhas 8770 a 8803:
8770:                 loc_lResultado = .T.
8771:             ENDIF
8772: 
8773:             loc_nRet = SQLEXEC(gnConnHandle, ;
8774:                 "SELECT DISTINCT conquilhas FROM sigcdcnq ORDER BY conquilhas", ;
8775:                 "cursor_4c_CnqBusca")
8776:             IF loc_nRet > 0 AND USED("cursor_4c_CnqBusca")
8777:                 LOCATE FOR ALLTRIM(cursor_4c_CnqBusca.conquilhas) == ALLTRIM(loc_cValAtual)
8778:                 IF !EOF("cursor_4c_CnqBusca")
8779:                     loc_lResultado = .T.
8780:                 ENDIF
8781:                 USE IN cursor_4c_CnqBusca
8782:             ENDIF
8783:             IF USED("cursor_4c_CnqBusca")
8784:                 USE IN cursor_4c_CnqBusca
8785:             ENDIF
8786: 
8787:             loc_nRet = SQLEXEC(gnConnHandle, ;
8788:                 "SELECT DISTINCT conquilhas FROM sigcdcnq ORDER BY conquilhas", ;
8789:                 "cursor_4c_CnqBusca")
8790: 
8791:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8792:             IF VARTYPE(loc_oBusca) = "O"
8793:                 loc_oBusca.this_cCursorDestino = "cursor_4c_CnqBusca"
8794:                 loc_oBusca.DefinirCursor("cursor_4c_CnqBusca", "conquilhas", "conquilhas", ;
8795:                     "Selecionar Conquilha")
8796:                 loc_oBusca.Mostrar()
8797:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8798:                     loc_oPg.txt_4c_Conquilhas.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8799:                 ENDIF
8800:                 loc_oBusca = .NULL.
8801:             ENDIF
8802: 
8803:             IF USED("cursor_4c_CnqBusca")

*-- Linhas 8830 a 8874:
8830:                 loc_lResultado = .T.
8831:             ENDIF
8832: 
8833:             loc_nRet = SQLEXEC(gnConnHandle, ;
8834:                 "SELECT cods, descs FROM SigCdCor WHERE cods = '" + ;
8835:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_CorFPBusca")
8836:             IF loc_nRet > 0 AND USED("cursor_4c_CorFPBusca") AND !EOF("cursor_4c_CorFPBusca")
8837:                 IF USED("cursor_4c_CorFPBusca")
8838:                     USE IN cursor_4c_CorFPBusca
8839:                 ENDIF
8840:                 *-- Sincronizar com Page1
8841:                 LOCAL loc_oPg1
8842:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8843:                 IF PEMSTATUS(loc_oPg1, "txt_4c_CodCors", 5)
8844:                     loc_oPg1.txt_4c_CodCors.Value = loc_cValAtual
8845:                 ENDIF
8846:                 loc_lResultado = .T.
8847:             ENDIF
8848:             IF USED("cursor_4c_CorFPBusca")
8849:                 USE IN cursor_4c_CorFPBusca
8850:             ENDIF
8851: 
8852:             loc_nRet = SQLEXEC(gnConnHandle, ;
8853:                 "SELECT cods, descs FROM SigCdCor WHERE cods LIKE '" + ;
8854:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_CorFPBusca")
8855:             IF loc_nRet <= 0 OR !USED("cursor_4c_CorFPBusca") OR EOF("cursor_4c_CorFPBusca")
8856:                 IF USED("cursor_4c_CorFPBusca")
8857:                     USE IN cursor_4c_CorFPBusca
8858:                 ENDIF
8859:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdCor ORDER BY cods", ;
8860:                     "cursor_4c_CorFPBusca")
8861:             ENDIF
8862: 
8863:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8864:             IF VARTYPE(loc_oBusca) = "O"
8865:                 loc_oBusca.this_cCursorDestino = "cursor_4c_CorFPBusca"
8866:                 loc_oBusca.DefinirCursor("cursor_4c_CorFPBusca", "cods", "descs", ;
8867:                     "Selecionar Cor Padr" + CHR(227) + "o")
8868:                 loc_oBusca.Mostrar()
8869:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8870:                     loc_oPg.txt_4c_CodCorsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8871:                     LOCAL loc_oPg1b
8872:                     loc_oPg1b = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8873:                     IF PEMSTATUS(loc_oPg1b, "txt_4c_CodCors", 5)
8874:                         loc_oPg1b.txt_4c_CodCors.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)

*-- Linhas 8907 a 8950:
8907:                 loc_lResultado = .T.
8908:             ENDIF
8909: 
8910:             loc_nRet = SQLEXEC(gnConnHandle, ;
8911:                 "SELECT cods, descs FROM SigCdTam WHERE cods = '" + ;
8912:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_TamFPBusca")
8913:             IF loc_nRet > 0 AND USED("cursor_4c_TamFPBusca") AND !EOF("cursor_4c_TamFPBusca")
8914:                 IF USED("cursor_4c_TamFPBusca")
8915:                     USE IN cursor_4c_TamFPBusca
8916:                 ENDIF
8917:                 LOCAL loc_oPg1c
8918:                 loc_oPg1c = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8919:                 IF PEMSTATUS(loc_oPg1c, "txt_4c_CodTams", 5)
8920:                     loc_oPg1c.txt_4c_CodTams.Value = loc_cValAtual
8921:                 ENDIF
8922:                 loc_lResultado = .T.
8923:             ENDIF
8924:             IF USED("cursor_4c_TamFPBusca")
8925:                 USE IN cursor_4c_TamFPBusca
8926:             ENDIF
8927: 
8928:             loc_nRet = SQLEXEC(gnConnHandle, ;
8929:                 "SELECT cods, descs FROM SigCdTam WHERE cods LIKE '" + ;
8930:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_TamFPBusca")
8931:             IF loc_nRet <= 0 OR !USED("cursor_4c_TamFPBusca") OR EOF("cursor_4c_TamFPBusca")
8932:                 IF USED("cursor_4c_TamFPBusca")
8933:                     USE IN cursor_4c_TamFPBusca
8934:                 ENDIF
8935:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdTam ORDER BY cods", ;
8936:                     "cursor_4c_TamFPBusca")
8937:             ENDIF
8938: 
8939:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8940:             IF VARTYPE(loc_oBusca) = "O"
8941:                 loc_oBusca.this_cCursorDestino = "cursor_4c_TamFPBusca"
8942:                 loc_oBusca.DefinirCursor("cursor_4c_TamFPBusca", "cods", "descs", ;
8943:                     "Selecionar Tamanho Padr" + CHR(227) + "o")
8944:                 loc_oBusca.Mostrar()
8945:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8946:                     loc_oPg.txt_4c_CodTamsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8947:                     LOCAL loc_oPg1d
8948:                     loc_oPg1d = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8949:                     IF PEMSTATUS(loc_oPg1d, "txt_4c_CodTams", 5)
8950:                         loc_oPg1d.txt_4c_CodTams.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)

*-- Linhas 8984 a 9029:
8984:                 loc_lResultado = .T.
8985:             ENDIF
8986: 
8987:             loc_nRet = SQLEXEC(gnConnHandle, ;
8988:                 "SELECT cods, descrs FROM SigCdAca WHERE cods = '" + ;
8989:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_AcaFPBusca")
8990:             IF loc_nRet > 0 AND USED("cursor_4c_AcaFPBusca") AND !EOF("cursor_4c_AcaFPBusca")
8991:                 SELECT cursor_4c_AcaFPBusca
8992:                 loc_oPg.txt_4c_DacbFP.Value = ALLTRIM(cursor_4c_AcaFPBusca.descrs)
8993:                 IF USED("cursor_4c_AcaFPBusca")
8994:                     USE IN cursor_4c_AcaFPBusca
8995:                 ENDIF
8996:                 LOCAL loc_oPg1e
8997:                 loc_oPg1e = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8998:                 IF PEMSTATUS(loc_oPg1e, "txt_4c_CodAcbs", 5)
8999:                     loc_oPg1e.txt_4c_CodAcbs.Value = loc_cValAtual
9000:                 ENDIF
9001:                 loc_lResultado = .T.
9002:             ENDIF
9003:             IF USED("cursor_4c_AcaFPBusca")
9004:                 USE IN cursor_4c_AcaFPBusca
9005:             ENDIF
9006: 
9007:             loc_nRet = SQLEXEC(gnConnHandle, ;
9008:                 "SELECT cods, descrs FROM SigCdAca WHERE cods LIKE '" + ;
9009:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_AcaFPBusca")
9010:             IF loc_nRet <= 0 OR !USED("cursor_4c_AcaFPBusca") OR EOF("cursor_4c_AcaFPBusca")
9011:                 IF USED("cursor_4c_AcaFPBusca")
9012:                     USE IN cursor_4c_AcaFPBusca
9013:                 ENDIF
9014:                 SQLEXEC(gnConnHandle, "SELECT cods, descrs FROM SigCdAca ORDER BY cods", ;
9015:                     "cursor_4c_AcaFPBusca")
9016:             ENDIF
9017: 
9018:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
9019:             IF VARTYPE(loc_oBusca) = "O"
9020:                 loc_oBusca.this_cCursorDestino = "cursor_4c_AcaFPBusca"
9021:                 loc_oBusca.DefinirCursor("cursor_4c_AcaFPBusca", "cods", "descrs", ;
9022:                     "Selecionar Acabamento")
9023:                 loc_oBusca.Mostrar()
9024:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
9025:                     loc_oPg.txt_4c_CodAcbsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
9026:                     loc_oPg.txt_4c_DacbFP.Value    = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
9027:                     LOCAL loc_oPg1f
9028:                     loc_oPg1f = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9029:                     IF PEMSTATUS(loc_oPg1f, "txt_4c_CodAcbs", 5)

*-- Linhas 9057 a 9117:
9057:             IF !USED("cursor_4c_GrdMatrizes") OR EOF("cursor_4c_GrdMatrizes")
9058:                 loc_lResultado = .T.
9059:             ENDIF
9060:             SELECT cursor_4c_GrdMatrizes
9061:             loc_cValAtual = ALLTRIM(cursor_4c_GrdMatrizes.cmats)
9062:             IF EMPTY(loc_cValAtual)
9063:                 loc_lResultado = .T.
9064:             ENDIF
9065: 
9066:             loc_nRet = SQLEXEC(gnConnHandle, ;
9067:                 "SELECT cpros, dpros FROM SigCdPro WHERE cpros = '" + ;
9068:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_MtzPrBusca")
9069:             IF loc_nRet > 0 AND USED("cursor_4c_MtzPrBusca") AND !EOF("cursor_4c_MtzPrBusca")
9070:                 SELECT cursor_4c_MtzPrBusca
9071:                 SELECT cursor_4c_GrdMatrizes
9072:                 REPLACE cursor_4c_GrdMatrizes.dpros WITH ALLTRIM(cursor_4c_MtzPrBusca.dpros)
9073:                 IF USED("cursor_4c_MtzPrBusca")
9074:                     USE IN cursor_4c_MtzPrBusca
9075:                 ENDIF
9076:                 loc_lResultado = .T.
9077:             ENDIF
9078:             IF USED("cursor_4c_MtzPrBusca")
9079:                 USE IN cursor_4c_MtzPrBusca
9080:             ENDIF
9081: 
9082:             *-- Codigo nao encontrado: abrir busca
9083:             loc_nRet = SQLEXEC(gnConnHandle, ;
9084:                 "SELECT cpros, dpros FROM SigCdPro WHERE cpros LIKE '" + ;
9085:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cpros", "cursor_4c_MtzPrBusca")
9086:             IF loc_nRet <= 0 OR !USED("cursor_4c_MtzPrBusca") OR EOF("cursor_4c_MtzPrBusca")
9087:                 IF USED("cursor_4c_MtzPrBusca")
9088:                     USE IN cursor_4c_MtzPrBusca
9089:                 ENDIF
9090:                 SQLEXEC(gnConnHandle, ;
9091:                     "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros", ;
9092:                     "cursor_4c_MtzPrBusca")
9093:             ENDIF
9094: 
9095:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
9096:             IF VARTYPE(loc_oBusca) = "O"
9097:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MtzPrBusca"
9098:                 loc_oBusca.DefinirCursor("cursor_4c_MtzPrBusca", "cpros", "dpros", ;
9099:                     "Selecionar Produto Matriz")
9100:                 loc_oBusca.Mostrar()
9101:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdMatrizes")
9102:                     SELECT cursor_4c_GrdMatrizes
9103:                     REPLACE cursor_4c_GrdMatrizes.cmats WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
9104:                     REPLACE cursor_4c_GrdMatrizes.dpros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
9105:                 ENDIF
9106:                 loc_oBusca = .NULL.
9107:             ENDIF
9108: 
9109:             IF USED("cursor_4c_MtzPrBusca")
9110:                 USE IN cursor_4c_MtzPrBusca
9111:             ENDIF
9112: 
9113:         CATCH TO loException
9114:             IF USED("cursor_4c_MtzPrBusca")
9115:                 USE IN cursor_4c_MtzPrBusca
9116:             ENDIF
9117:             MostrarErro("Erro ao validar matriz:" + CHR(13) + loException.Message, ;

*-- Linhas 9137 a 9163:
9137:             loc_oPg.img_4c_ImgBorracha.Visible = .F.
9138: 
9139:             IF !EOF("cursor_4c_GrdMatrizes") AND !BOF("cursor_4c_GrdMatrizes")
9140:                 SELECT cursor_4c_GrdMatrizes
9141:                 LOCAL loc_cCmats
9142:                 loc_cCmats = ALLTRIM(cursor_4c_GrdMatrizes.cmats)
9143:                 IF !EMPTY(loc_cCmats)
9144:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9145:                         "SELECT figprocs FROM SigCdPro WHERE cpros = '" + ;
9146:                         EscaparSQL(loc_cCmats) + "", "cursor_4c_MtzImgPro")
9147:                     IF loc_nRet > 0 AND USED("cursor_4c_MtzImgPro") AND !EOF("cursor_4c_MtzImgPro")
9148:                         SELECT cursor_4c_MtzImgPro
9149:                         IF !ISNULL(cursor_4c_MtzImgPro.figprocs) AND ;
9150:                                 !EMPTY(cursor_4c_MtzImgPro.figprocs)
9151:                             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9152:                             IF STRTOFILE(cursor_4c_MtzImgPro.figprocs, loc_lcArquivo) > 0
9153:                                 loc_oPg.img_4c_ImgBorracha.Visible = .T.
9154:                                 loc_oPg.img_4c_ImgBorracha.Picture = loc_lcArquivo
9155:                             ENDIF
9156:                         ENDIF
9157:                     ENDIF
9158:                     IF USED("cursor_4c_MtzImgPro")
9159:                         USE IN cursor_4c_MtzImgPro
9160:                     ENDIF
9161:                 ENDIF
9162:             ENDIF
9163: 

*-- Linhas 9181 a 9199:
9181:                 RETURN
9182:             ENDIF
9183: 
9184:             INSERT INTO cursor_4c_GrdMatrizes (cidchaves, cmats, qtds, dpros) ;
9185:                 VALUES (SYS(2015), "", 0, "")
9186: 
9187:             GO BOTTOM IN cursor_4c_GrdMatrizes
9188: 
9189:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9190:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
9191:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
9192:                 loc_oPg.grd_4c_GrdMatrizes.Column1.SetFocus()
9193:             ENDIF
9194: 
9195:         CATCH TO loException
9196:             MostrarErro("Erro ao inserir matriz:" + CHR(13) + loException.Message, ;
9197:                 "FormProduto.BtnInserirMtzClick")
9198:         ENDTRY
9199:     ENDPROC

*-- Linhas 9212 a 9234:
9212:                 RETURN
9213:             ENDIF
9214: 
9215:             SELECT cursor_4c_GrdMatrizes
9216:             IF !MsgConfirma("Excluir este registro de matriz?")
9217:                 RETURN
9218:             ENDIF
9219:             DELETE IN cursor_4c_GrdMatrizes
9220:             IF !EOF("cursor_4c_GrdMatrizes")
9221:                 SKIP IN cursor_4c_GrdMatrizes
9222:             ENDIF
9223:             IF EOF("cursor_4c_GrdMatrizes") AND RECCOUNT("cursor_4c_GrdMatrizes") > 0
9224:                 GO BOTTOM IN cursor_4c_GrdMatrizes
9225:             ENDIF
9226: 
9227:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9228:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
9229:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
9230:             ENDIF
9231: 
9232:         CATCH TO loException
9233:             MostrarErro("Erro ao excluir matriz:" + CHR(13) + loException.Message, ;
9234:                 "FormProduto.BtnExcluirMtzClick")

*-- Linhas 9258 a 9277:
9258:                 ENDIF
9259:                 RETURN
9260:             ENDIF
9261:             loc_nRet = SQLEXEC(gnConnHandle, ;
9262:                 "SELECT codigos, descricaos FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cCod), ;
9263:                 "cursor_4c_ClfBusca")
9264:             IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca") AND !EOF("cursor_4c_ClfBusca")
9265:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9266:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.descricaos)
9267:                 ENDIF
9268:                 IF USED("cursor_4c_ClfBusca")
9269:                     USE IN cursor_4c_ClfBusca
9270:                 ENDIF
9271:             ELSE
9272:                 IF USED("cursor_4c_ClfBusca")
9273:                     USE IN cursor_4c_ClfBusca
9274:                 ENDIF
9275:                 THIS.AbrirBuscaClfiscal()
9276:             ENDIF
9277:         CATCH TO loException

*-- Linhas 9316 a 9335:
9316:                 THIS.AbrirBuscaClfiscal()
9317:                 RETURN
9318:             ENDIF
9319:             loc_nRet = SQLEXEC(gnConnHandle, ;
9320:                 "SELECT codigos, descricaos FROM SigCdClf ORDER BY descricaos", ;
9321:                 "cursor_4c_ClfBusca")
9322:             IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca")
9323:                 LOCATE FOR LIKE(UPPER(ALLTRIM(loc_cDesc)) + "*", UPPER(ALLTRIM(cursor_4c_ClfBusca.descricaos)))
9324:             ENDIF
9325:             IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca") AND !EOF("cursor_4c_ClfBusca")
9326:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9327:                     loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.codigos)
9328:                 ENDIF
9329:                 loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.descricaos)
9330:                 IF USED("cursor_4c_ClfBusca")
9331:                     USE IN cursor_4c_ClfBusca
9332:                 ENDIF
9333:             ELSE
9334:                 IF USED("cursor_4c_ClfBusca")
9335:                     USE IN cursor_4c_ClfBusca

*-- Linhas 9369 a 9388:
9369:                 ENDIF
9370:                 RETURN
9371:             ENDIF
9372:             loc_nRet = SQLEXEC(gnConnHandle, ;
9373:                 "SELECT codigos, descricaos FROM SIGCDORG WHERE codigos = " + EscaparSQL(loc_cCod), ;
9374:                 "cursor_4c_OrgBusca")
9375:             IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca") AND !EOF("cursor_4c_OrgBusca")
9376:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9377:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgBusca.descricaos)
9378:                 ENDIF
9379:                 IF USED("cursor_4c_OrgBusca")
9380:                     USE IN cursor_4c_OrgBusca
9381:                 ENDIF
9382:             ELSE
9383:                 IF USED("cursor_4c_OrgBusca")
9384:                     USE IN cursor_4c_OrgBusca
9385:                 ENDIF
9386:                 THIS.AbrirBuscaOrigmerc()
9387:             ENDIF
9388:         CATCH TO loException

*-- Linhas 9427 a 9446:
9427:                 THIS.AbrirBuscaOrigmerc()
9428:                 RETURN
9429:             ENDIF
9430:             loc_nRet = SQLEXEC(gnConnHandle, ;
9431:                 "SELECT codigos, descricaos FROM SIGCDORG ORDER BY descricaos", ;
9432:                 "cursor_4c_OrgBusca")
9433:             IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca")
9434:                 LOCATE FOR LIKE(UPPER(ALLTRIM(loc_cDesc)) + "*", UPPER(ALLTRIM(cursor_4c_OrgBusca.descricaos)))
9435:             ENDIF
9436:             IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca") AND !EOF("cursor_4c_OrgBusca")
9437:                 IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9438:                     loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(cursor_4c_OrgBusca.codigos)
9439:                 ENDIF
9440:                 loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgBusca.descricaos)
9441:                 IF USED("cursor_4c_OrgBusca")
9442:                     USE IN cursor_4c_OrgBusca
9443:                 ENDIF
9444:             ELSE
9445:                 IF USED("cursor_4c_OrgBusca")
9446:                     USE IN cursor_4c_OrgBusca

*-- Linhas 9480 a 9499:
9480:                 ENDIF
9481:                 RETURN
9482:             ENDIF
9483:             loc_nRet = SQLEXEC(gnConnHandle, ;
9484:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
9485:                 "cursor_4c_IcmBusca")
9486:             IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca") AND !EOF("cursor_4c_IcmBusca")
9487:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9488:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmBusca.descricaos)
9489:                 ENDIF
9490:                 IF USED("cursor_4c_IcmBusca")
9491:                     USE IN cursor_4c_IcmBusca
9492:                 ENDIF
9493:             ELSE
9494:                 IF USED("cursor_4c_IcmBusca")
9495:                     USE IN cursor_4c_IcmBusca
9496:                 ENDIF
9497:                 THIS.AbrirBuscaSittricm()
9498:             ENDIF
9499:         CATCH TO loException

*-- Linhas 9538 a 9557:
9538:                 THIS.AbrirBuscaSittricm()
9539:                 RETURN
9540:             ENDIF
9541:             loc_nRet = SQLEXEC(gnConnHandle, ;
9542:                 "SELECT codigos, descricaos FROM SIGCDICM ORDER BY descricaos", ;
9543:                 "cursor_4c_IcmBusca")
9544:             IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca")
9545:                 LOCATE FOR LIKE(UPPER(ALLTRIM(loc_cDesc)) + "*", UPPER(ALLTRIM(cursor_4c_IcmBusca.descricaos)))
9546:             ENDIF
9547:             IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca") AND !EOF("cursor_4c_IcmBusca")
9548:                 IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9549:                     loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_IcmBusca.codigos)
9550:                 ENDIF
9551:                 loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmBusca.descricaos)
9552:                 IF USED("cursor_4c_IcmBusca")
9553:                     USE IN cursor_4c_IcmBusca
9554:                 ENDIF
9555:             ELSE
9556:                 IF USED("cursor_4c_IcmBusca")
9557:                     USE IN cursor_4c_IcmBusca

*-- Linhas 9588 a 9607:
9588:             IF EMPTY(loc_cCod)
9589:                 RETURN
9590:             ENDIF
9591:             loc_nRet = SQLEXEC(gnConnHandle, ;
9592:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
9593:                 "cursor_4c_IcmServBusca")
9594:             IF loc_nRet > 0 AND USED("cursor_4c_IcmServBusca") AND !EOF("cursor_4c_IcmServBusca")
9595:                 IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9596:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(cursor_4c_IcmServBusca.codigos)
9597:                 ENDIF
9598:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9599:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmServBusca.descricaos)
9600:                 ENDIF
9601:                 IF USED("cursor_4c_IcmServBusca")
9602:                     USE IN cursor_4c_IcmServBusca
9603:                 ENDIF
9604:             ELSE
9605:                 IF USED("cursor_4c_IcmServBusca")
9606:                     USE IN cursor_4c_IcmServBusca
9607:                 ENDIF

*-- Linhas 9637 a 9656:
9637:             IF EMPTY(loc_cCod)
9638:                 RETURN
9639:             ENDIF
9640:             loc_nRet = SQLEXEC(gnConnHandle, ;
9641:                 "SELECT tipos, descs FROM SigPrTri WHERE tipos = " + EscaparSQL(loc_cCod), ;
9642:                 "cursor_4c_TpTribBusca")
9643:             IF loc_nRet > 0 AND USED("cursor_4c_TpTribBusca") AND !EOF("cursor_4c_TpTribBusca")
9644:                 IF USED("cursor_4c_TpTribBusca")
9645:                     USE IN cursor_4c_TpTribBusca
9646:                 ENDIF
9647:             ELSE
9648:                 IF USED("cursor_4c_TpTribBusca")
9649:                     USE IN cursor_4c_TpTribBusca
9650:                 ENDIF
9651:                 THIS.AbrirBuscaTpTrib()
9652:             ENDIF
9653:         CATCH TO loException
9654:             IF USED("cursor_4c_TpTribBusca")
9655:                 USE IN cursor_4c_TpTribBusca
9656:             ENDIF

*-- Linhas 9717 a 9736:
9717:             IF EMPTY(loc_cClf) OR loc_nAliq = 0
9718:                 RETURN
9719:             ENDIF
9720:             loc_nRet = SQLEXEC(gnConnHandle, ;
9721:                 "SELECT aipis FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cClf), ;
9722:                 "cursor_4c_ClfAliq")
9723:             IF loc_nRet > 0 AND USED("cursor_4c_ClfAliq") AND !EOF("cursor_4c_ClfAliq")
9724:                 loc_nAliqRef = cursor_4c_ClfAliq.aipis
9725:                 IF loc_nAliqRef > 0 AND ABS(loc_nAliq - loc_nAliqRef) > 0.001
9726:                     MsgAviso("Al" + CHR(237) + "quota IPI informada (" + ;
9727:                         TRANSFORM(loc_nAliq) + "%) difere da padr" + CHR(227) + ;
9728:                         "o da classifica" + CHR(231) + CHR(227) + "o fiscal (" + ;
9729:                         TRANSFORM(loc_nAliqRef) + "%).")
9730:                 ENDIF
9731:             ENDIF
9732:             IF USED("cursor_4c_ClfAliq")
9733:                 USE IN cursor_4c_ClfAliq
9734:             ENDIF
9735:         CATCH TO loException
9736:             IF USED("cursor_4c_ClfAliq")

*-- Linhas 9763 a 9782:
9763:             IF EMPTY(loc_cClf)
9764:                 loc_lResultado = .F.
9765:             ENDIF
9766:             loc_nRet = SQLEXEC(gnConnHandle, ;
9767:                 "SELECT ipiprods FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cClf), ;
9768:                 "cursor_4c_ClfIpiProd")
9769:             IF loc_nRet > 0 AND USED("cursor_4c_ClfIpiProd") AND !EOF("cursor_4c_ClfIpiProd")
9770:                 loc_lPermite = (ALLTRIM(cursor_4c_ClfIpiProd.ipiprods) = "S")
9771:             ENDIF
9772:             IF USED("cursor_4c_ClfIpiProd")
9773:                 USE IN cursor_4c_ClfIpiProd
9774:             ENDIF
9775:         CATCH TO loException
9776:             IF USED("cursor_4c_ClfIpiProd")
9777:                 USE IN cursor_4c_ClfIpiProd
9778:             ENDIF
9779:         ENDTRY
9780:         RETURN loc_lPermite
9781:     ENDPROC
9782: 

*-- Linhas 9830 a 9849:
9830:                 ENDIF
9831:                 RETURN
9832:             ENDIF
9833:             loc_nRet = SQLEXEC(gnConnHandle, ;
9834:                 "SELECT codigos, descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
9835:                 " AND tipos = 'M'", ;
9836:                 "cursor_4c_MetalBusca")
9837:             IF loc_nRet > 0 AND USED("cursor_4c_MetalBusca") AND !EOF("cursor_4c_MetalBusca")
9838:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
9839:                     loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(cursor_4c_MetalBusca.descs)
9840:                 ENDIF
9841:                 IF USED("cursor_4c_MetalBusca")
9842:                     USE IN cursor_4c_MetalBusca
9843:                 ENDIF
9844:             ELSE
9845:                 IF USED("cursor_4c_MetalBusca")
9846:                     USE IN cursor_4c_MetalBusca
9847:                 ENDIF
9848:                 THIS.AbrirBuscaMetal()
9849:             ENDIF

*-- Linhas 9880 a 9899:
9880:                 ENDIF
9881:                 RETURN
9882:             ENDIF
9883:             loc_nRet = SQLEXEC(gnConnHandle, ;
9884:                 "SELECT codigos, descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
9885:                 " AND tipos <> 'M'", ;
9886:                 "cursor_4c_TeorBusca")
9887:             IF loc_nRet > 0 AND USED("cursor_4c_TeorBusca") AND !EOF("cursor_4c_TeorBusca")
9888:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
9889:                     loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(cursor_4c_TeorBusca.descs)
9890:                 ENDIF
9891:                 IF USED("cursor_4c_TeorBusca")
9892:                     USE IN cursor_4c_TeorBusca
9893:                 ENDIF
9894:             ELSE
9895:                 IF USED("cursor_4c_TeorBusca")
9896:                     USE IN cursor_4c_TeorBusca
9897:                 ENDIF
9898:                 THIS.AbrirBuscaTeor()
9899:             ENDIF

*-- Linhas 9927 a 9946:
9927:             IF EMPTY(loc_cCod)
9928:                 RETURN
9929:             ENDIF
9930:             loc_nRet = SQLEXEC(gnConnHandle, ;
9931:                 "SELECT cmoeds, dmoeds FROM SigCdMoe WHERE cmoeds = " + EscaparSQL(loc_cCod), ;
9932:                 "cursor_4c_MoeFiscalBusca")
9933:             IF loc_nRet > 0 AND USED("cursor_4c_MoeFiscalBusca") AND !EOF("cursor_4c_MoeFiscalBusca")
9934:                 IF USED("cursor_4c_MoeFiscalBusca")
9935:                     USE IN cursor_4c_MoeFiscalBusca
9936:                 ENDIF
9937:             ELSE
9938:                 IF USED("cursor_4c_MoeFiscalBusca")
9939:                     USE IN cursor_4c_MoeFiscalBusca
9940:                 ENDIF
9941:                 THIS.AbrirBuscaMvalorFiscal()
9942:             ENDIF
9943:         CATCH TO loException
9944:             IF USED("cursor_4c_MoeFiscalBusca")
9945:                 USE IN cursor_4c_MoeFiscalBusca
9946:             ENDIF

*-- Linhas 10113 a 10140:
10113:             IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10114:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
10115:             ENDIF
10116:             loc_nRet = SQLEXEC(gnConnHandle, ;
10117:                 "SELECT codigos, descricaos FROM SigCdClf WHERE codigos LIKE " + ;
10118:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10119:                 "cursor_4c_ClfBusca")
10120:             IF loc_nRet <= 0 OR !USED("cursor_4c_ClfBusca") OR EOF("cursor_4c_ClfBusca")
10121:                 IF USED("cursor_4c_ClfBusca")
10122:                     USE IN cursor_4c_ClfBusca
10123:                 ENDIF
10124:                 SQLEXEC(gnConnHandle, ;
10125:                     "SELECT codigos, descricaos FROM SigCdClf ORDER BY codigos", ;
10126:                     "cursor_4c_ClfBusca")
10127:             ENDIF
10128:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10129:             IF VARTYPE(loc_oBusca) = "O"
10130:                 loc_oBusca.this_cCursorDestino = "cursor_4c_ClfBusca"
10131:                 loc_oBusca.DefinirCursor("cursor_4c_ClfBusca", "codigos", "descricaos", ;
10132:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
10133:                 loc_oBusca.Mostrar()
10134:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10135:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10136:                         loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10137:                     ENDIF
10138:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
10139:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10140:                     ENDIF

*-- Linhas 10162 a 10189:
10162:             IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
10163:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
10164:             ENDIF
10165:             loc_nRet = SQLEXEC(gnConnHandle, ;
10166:                 "SELECT codigos, descricaos FROM SIGCDORG WHERE codigos LIKE " + ;
10167:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10168:                 "cursor_4c_OrgBusca")
10169:             IF loc_nRet <= 0 OR !USED("cursor_4c_OrgBusca") OR EOF("cursor_4c_OrgBusca")
10170:                 IF USED("cursor_4c_OrgBusca")
10171:                     USE IN cursor_4c_OrgBusca
10172:                 ENDIF
10173:                 SQLEXEC(gnConnHandle, ;
10174:                     "SELECT codigos, descricaos FROM SIGCDORG ORDER BY codigos", ;
10175:                     "cursor_4c_OrgBusca")
10176:             ENDIF
10177:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10178:             IF VARTYPE(loc_oBusca) = "O"
10179:                 loc_oBusca.this_cCursorDestino = "cursor_4c_OrgBusca"
10180:                 loc_oBusca.DefinirCursor("cursor_4c_OrgBusca", "codigos", "descricaos", ;
10181:                     "Buscar Origem Mercadoria")
10182:                 loc_oBusca.Mostrar()
10183:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10184:                     IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
10185:                         loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10186:                     ENDIF
10187:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
10188:                         loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10189:                     ENDIF

*-- Linhas 10211 a 10238:
10211:             IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10212:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
10213:             ENDIF
10214:             loc_nRet = SQLEXEC(gnConnHandle, ;
10215:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos LIKE " + ;
10216:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10217:                 "cursor_4c_IcmBusca")
10218:             IF loc_nRet <= 0 OR !USED("cursor_4c_IcmBusca") OR EOF("cursor_4c_IcmBusca")
10219:                 IF USED("cursor_4c_IcmBusca")
10220:                     USE IN cursor_4c_IcmBusca
10221:                 ENDIF
10222:                 SQLEXEC(gnConnHandle, ;
10223:                     "SELECT codigos, descricaos FROM SIGCDICM ORDER BY codigos", ;
10224:                     "cursor_4c_IcmBusca")
10225:             ENDIF
10226:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10227:             IF VARTYPE(loc_oBusca) = "O"
10228:                 loc_oBusca.this_cCursorDestino = "cursor_4c_IcmBusca"
10229:                 loc_oBusca.DefinirCursor("cursor_4c_IcmBusca", "codigos", "descricaos", ;
10230:                     "Buscar Sit. Tributaria ICMS")
10231:                 loc_oBusca.Mostrar()
10232:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10233:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10234:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10235:                     ENDIF
10236:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
10237:                         loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10238:                     ENDIF

*-- Linhas 10260 a 10287:
10260:             IF PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
10261:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Codigo.Value)
10262:             ENDIF
10263:             loc_nRet = SQLEXEC(gnConnHandle, ;
10264:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos LIKE " + ;
10265:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10266:                 "cursor_4c_CodServBusca")
10267:             IF loc_nRet <= 0 OR !USED("cursor_4c_CodServBusca") OR EOF("cursor_4c_CodServBusca")
10268:                 IF USED("cursor_4c_CodServBusca")
10269:                     USE IN cursor_4c_CodServBusca
10270:                 ENDIF
10271:                 SQLEXEC(gnConnHandle, ;
10272:                     "SELECT codigos, descricaos FROM SIGCDICM ORDER BY codigos", ;
10273:                     "cursor_4c_CodServBusca")
10274:             ENDIF
10275:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10276:             IF VARTYPE(loc_oBusca) = "O"
10277:                 loc_oBusca.this_cCursorDestino = "cursor_4c_CodServBusca"
10278:                 loc_oBusca.DefinirCursor("cursor_4c_CodServBusca", "codigos", "descricaos", ;
10279:                     "Buscar C" + CHR(243) + "d. Servi" + CHR(231) + "o Fiscal")
10280:                 loc_oBusca.Mostrar()
10281:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10282:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
10283:                         loc_oPg.txt_4c_Codigo.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10284:                     ENDIF
10285:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10286:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10287:                     ENDIF

*-- Linhas 10312 a 10339:
10312:             IF PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
10313:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_TpTrib.Value)
10314:             ENDIF
10315:             loc_nRet = SQLEXEC(gnConnHandle, ;
10316:                 "SELECT tipos, descs FROM SigPrTri WHERE tipos LIKE " + ;
10317:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY tipos", ;
10318:                 "cursor_4c_TpTribBusca")
10319:             IF loc_nRet <= 0 OR !USED("cursor_4c_TpTribBusca") OR EOF("cursor_4c_TpTribBusca")
10320:                 IF USED("cursor_4c_TpTribBusca")
10321:                     USE IN cursor_4c_TpTribBusca
10322:                 ENDIF
10323:                 SQLEXEC(gnConnHandle, ;
10324:                     "SELECT tipos, descs FROM SigPrTri ORDER BY tipos", ;
10325:                     "cursor_4c_TpTribBusca")
10326:             ENDIF
10327:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10328:             IF VARTYPE(loc_oBusca) = "O"
10329:                 loc_oBusca.this_cCursorDestino = "cursor_4c_TpTribBusca"
10330:                 loc_oBusca.DefinirCursor("cursor_4c_TpTribBusca", "tipos", "descs", ;
10331:                     "Buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o")
10332:                 loc_oBusca.Mostrar()
10333:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10334:                     IF PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
10335:                         loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10336:                     ENDIF
10337:                 ENDIF
10338:                 loc_oBusca = .NULL.
10339:             ENDIF

*-- Linhas 10358 a 10386:
10358:             IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
10359:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Metal.Value)
10360:             ENDIF
10361:             loc_nRet = SQLEXEC(gnConnHandle, ;
10362:                 "SELECT codigos, descs FROM SigCdMtl " + ;
10363:                 "WHERE tipos = 'M' AND codigos LIKE " + ;
10364:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10365:                 "cursor_4c_MetalBusca")
10366:             IF loc_nRet <= 0 OR !USED("cursor_4c_MetalBusca") OR EOF("cursor_4c_MetalBusca")
10367:                 IF USED("cursor_4c_MetalBusca")
10368:                     USE IN cursor_4c_MetalBusca
10369:                 ENDIF
10370:                 SQLEXEC(gnConnHandle, ;
10371:                     "SELECT codigos, descs FROM SigCdMtl WHERE tipos = 'M' ORDER BY codigos", ;
10372:                     "cursor_4c_MetalBusca")
10373:             ENDIF
10374:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10375:             IF VARTYPE(loc_oBusca) = "O"
10376:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MetalBusca"
10377:                 loc_oBusca.DefinirCursor("cursor_4c_MetalBusca", "codigos", "descs", "Buscar Metal")
10378:                 loc_oBusca.Mostrar()
10379:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10380:                     IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
10381:                         loc_oPg.txt_4c_Metal.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10382:                     ENDIF
10383:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
10384:                         loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10385:                     ENDIF
10386:                 ENDIF

*-- Linhas 10407 a 10435:
10407:             IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
10408:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Teor.Value)
10409:             ENDIF
10410:             loc_nRet = SQLEXEC(gnConnHandle, ;
10411:                 "SELECT codigos, descs FROM SigCdMtl " + ;
10412:                 "WHERE tipos <> 'M' AND codigos LIKE " + ;
10413:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10414:                 "cursor_4c_TeorBusca")
10415:             IF loc_nRet <= 0 OR !USED("cursor_4c_TeorBusca") OR EOF("cursor_4c_TeorBusca")
10416:                 IF USED("cursor_4c_TeorBusca")
10417:                     USE IN cursor_4c_TeorBusca
10418:                 ENDIF
10419:                 SQLEXEC(gnConnHandle, ;
10420:                     "SELECT codigos, descs FROM SigCdMtl WHERE tipos <> 'M' ORDER BY codigos", ;
10421:                     "cursor_4c_TeorBusca")
10422:             ENDIF
10423:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10424:             IF VARTYPE(loc_oBusca) = "O"
10425:                 loc_oBusca.this_cCursorDestino = "cursor_4c_TeorBusca"
10426:                 loc_oBusca.DefinirCursor("cursor_4c_TeorBusca", "codigos", "descs", "Buscar Teor")
10427:                 loc_oBusca.Mostrar()
10428:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10429:                     IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
10430:                         loc_oPg.txt_4c_Teor.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10431:                     ENDIF
10432:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
10433:                         loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10434:                     ENDIF
10435:                 ENDIF

*-- Linhas 10456 a 10483:
10456:             IF PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
10457:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Mvalor.Value)
10458:             ENDIF
10459:             loc_nRet = SQLEXEC(gnConnHandle, ;
10460:                 "SELECT cmoeds, dmoeds FROM SigCdMoe WHERE cmoeds LIKE " + ;
10461:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY cmoeds", ;
10462:                 "cursor_4c_MoeFiscalBusca")
10463:             IF loc_nRet <= 0 OR !USED("cursor_4c_MoeFiscalBusca") OR EOF("cursor_4c_MoeFiscalBusca")
10464:                 IF USED("cursor_4c_MoeFiscalBusca")
10465:                     USE IN cursor_4c_MoeFiscalBusca
10466:                 ENDIF
10467:                 SQLEXEC(gnConnHandle, ;
10468:                     "SELECT cmoeds, dmoeds FROM SigCdMoe ORDER BY cmoeds", ;
10469:                     "cursor_4c_MoeFiscalBusca")
10470:             ENDIF
10471:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10472:             IF VARTYPE(loc_oBusca) = "O"
10473:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MoeFiscalBusca"
10474:                 loc_oBusca.DefinirCursor("cursor_4c_MoeFiscalBusca", "cmoeds", "dmoeds", ;
10475:                     "Buscar Moeda")
10476:                 loc_oBusca.Mostrar()
10477:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10478:                     IF PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
10479:                         loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10480:                     ENDIF
10481:                 ENDIF
10482:                 loc_oBusca = .NULL.
10483:             ENDIF

*-- Linhas 10505 a 10537:
10505:             *-- Cursors placeholder (preenchidos pelo BO ao carregar produto)
10506:             IF !USED("cursor_4c_GrdDesigner")
10507:                 SET NULL ON
10508:                 CREATE CURSOR cursor_4c_GrdDesigner ( ;
10509:                     dtini D, dtfim D, usuarios C(10), codcads C(10))
10510:                 SET NULL OFF
10511:             ENDIF
10512:             IF !USED("cursor_4c_GrdArquivos")
10513:                 SET NULL ON
10514:                 CREATE CURSOR cursor_4c_GrdArquivos (arqnome C(200))
10515:                 SET NULL OFF
10516:             ENDIF
10517:             IF !USED("crTarefas")
10518:                 CREATE CURSOR crTarefas (CodCads C(10), DesCads C(40))
10519:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
10520:                     SQLEXEC(gnConnHandle, ;
10521:                         "SELECT LEFT(codcads, 10) AS CodCads, descads AS DesCads " + ;
10522:                         "FROM SigCdCad ORDER BY codcads", ;
10523:                         "crTarefas")
10524:                 ENDIF
10525:             ENDIF
10526: 
10527:             *-- grdDesigner: grade historico de designer (4 colunas)
10528:             *-- Original: top=145, left=10, width=495, height=180
10529:             loc_oPg.AddObject("grd_4c_GrdDesigner", "Grid")
10530:             WITH loc_oPg.grd_4c_GrdDesigner
10531:                 .Top        = 145
10532:                 .Left       = 10
10533:                 .Width      = 495
10534:                 .Height     = 180
10535:                 .FontName   = "Tahoma"
10536:                 .FontSize   = 8
10537:                 .RecordMark = .F.

*-- Linhas 10544 a 10583:
10544:             loc_oPg.grd_4c_GrdDesigner.RecordSource = "cursor_4c_GrdDesigner"
10545:             loc_oGrid = loc_oPg.grd_4c_GrdDesigner
10546: 
10547:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdDesigner.dtini"
10548:             loc_oGrid.Column1.Width           = 100
10549:             loc_oGrid.Column1.ColumnOrder     = 1
10550:             loc_oGrid.Column1.Movable         = .F.
10551:             loc_oGrid.Column1.Resizable       = .F.
10552:             loc_oGrid.Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
10553: 
10554:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdDesigner.dtfim"
10555:             loc_oGrid.Column2.Width           = 100
10556:             loc_oGrid.Column2.ColumnOrder     = 2
10557:             loc_oGrid.Column2.Movable         = .F.
10558:             loc_oGrid.Column2.Resizable       = .F.
10559:             loc_oGrid.Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
10560: 
10561:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdDesigner.usuarios"
10562:             loc_oGrid.Column3.Width           = 100
10563:             loc_oGrid.Column3.ColumnOrder     = 3
10564:             loc_oGrid.Column3.Movable         = .F.
10565:             loc_oGrid.Column3.Resizable       = .F.
10566:             loc_oGrid.Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
10567: 
10568:             loc_oGrid.Column4.ControlSource   = "cursor_4c_GrdDesigner.codcads"
10569:             loc_oGrid.Column4.Width           = 193
10570:             loc_oGrid.Column4.ColumnOrder     = 4
10571:             loc_oGrid.Column4.Movable         = .F.
10572:             loc_oGrid.Column4.Resizable       = .F.
10573:             loc_oGrid.Column4.Header1.Caption = "Tarefa"
10574:             BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdDesignerCol4TarefaValid")
10575: 
10576:             *-- Say31: label "Observacao da Tarefa"
10577:             *-- Original: top=129, left=583, width=126, height=15
10578:             loc_oPg.AddObject("lbl_4c_Label31", "Label")
10579:             WITH loc_oPg.lbl_4c_Label31
10580:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
10581:                 .Top       = 129
10582:                 .Left      = 583
10583:                 .Width     = 126

*-- Linhas 10693 a 10711:
10693:             ENDWITH
10694:             loc_oPg.grd_4c_GrdArquivos.ColumnCount  = 1
10695:             loc_oPg.grd_4c_GrdArquivos.RecordSource = "cursor_4c_GrdArquivos"
10696:             loc_oPg.grd_4c_GrdArquivos.Column1.ControlSource   = "cursor_4c_GrdArquivos.arqnome"
10697:             loc_oPg.grd_4c_GrdArquivos.Column1.Width           = 493
10698:             loc_oPg.grd_4c_GrdArquivos.Column1.ColumnOrder     = 1
10699:             loc_oPg.grd_4c_GrdArquivos.Column1.Movable         = .F.
10700:             loc_oPg.grd_4c_GrdArquivos.Column1.Resizable       = .F.
10701:             loc_oPg.grd_4c_GrdArquivos.Column1.Header1.Caption = "Arquivos Para Designer"
10702: 
10703:             *-- btnInsArqs: botao Inserir Arquivo
10704:             *-- Original: top=335, left=509, width=42, height=42
10705:             loc_oPg.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
10706:             WITH loc_oPg.cmd_4c_BtnInsArqs
10707:                 .Caption       = "+"
10708:                 .Top           = 335
10709:                 .Left          = 509
10710:                 .Width         = 42
10711:                 .Height        = 42

*-- Linhas 10933 a 10994:
10933:                 loc_cCodCads = ALLTRIM(cursor_4c_GrdDesigner.codcads)
10934:                 IF !EMPTY(loc_cCodCads)
10935:                     IF USED("crTarefas")
10936:                         SELECT crTarefas
10937:                         GO TOP
10938:                         LOCATE FOR ALLTRIM(CodCads) = loc_cCodCads
10939:                         IF EOF("crTarefas")
10940:                             THIS.AbrirBuscaTarefaDesigner()
10941:                         ENDIF
10942:                         IF USED("cursor_4c_GrdDesigner")
10943:                             SELECT cursor_4c_GrdDesigner
10944:                         ENDIF
10945:                     ELSE
10946:                         THIS.AbrirBuscaTarefaDesigner()
10947:                     ENDIF
10948:                 ENDIF
10949:             ENDIF
10950:         CATCH TO loException
10951:             MostrarErro("Erro ao validar Tarefa:" + CHR(13) + loException.Message, ;
10952:                 "FormProduto.GrdDesignerCol4TarefaValid")
10953:         ENDTRY
10954:         RETURN loc_lSucesso
10955:     ENDPROC
10956: 
10957:     PROCEDURE AbrirBuscaTarefaDesigner()
10958:         LOCAL loc_oBusca, loc_nRet, loException
10959:         TRY
10960:             IF !USED("crTarefas")
10961:                 CREATE CURSOR crTarefas (CodCads C(10), DesCads C(40))
10962:                 loc_nRet = SQLEXEC(gnConnHandle, ;
10963:                     "SELECT LEFT(codcads, 10) AS CodCads, descads AS DesCads " + ;
10964:                     "FROM SigCdCad ORDER BY codcads", ;
10965:                     "crTarefas")
10966:                 IF loc_nRet <= 0 OR EOF("crTarefas")
10967:                     MsgAviso("Sem tarefas cadastradas para selecionar.")
10968:                     RETURN
10969:                 ENDIF
10970:             ENDIF
10971:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10972:             IF VARTYPE(loc_oBusca) = "O"
10973:                 loc_oBusca.this_cCursorDestino = "crTarefas"
10974:                 loc_oBusca.DefinirCursor("crTarefas", "CodCads", "DesCads", ;
10975:                     "Selecionar Tarefa")
10976:                 loc_oBusca.Mostrar()
10977:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND ;
10978:                     USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
10979:                     SELECT cursor_4c_GrdDesigner
10980:                     REPLACE cursor_4c_GrdDesigner.codcads WITH ;
10981:                         ALLTRIM(loc_oBusca.cCodigoSelecionado)
10982:                 ENDIF
10983:                 loc_oBusca = .NULL.
10984:             ENDIF
10985:         CATCH TO loException
10986:             MostrarErro("Erro ao buscar Tarefa:" + CHR(13) + loException.Message, ;
10987:                 "FormProduto.AbrirBuscaTarefaDesigner")
10988:         ENDTRY
10989:     ENDPROC
10990: 
10991:     *-- GetDesLacto (txt_4c_DesLacto): Valid - valida usuario desenvolvedor em SigCdUsu
10992:     PROCEDURE ValidarDesLacto(par_nKeyCode, par_nShiftAltCtrl)
10993:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
10994:             RETURN

*-- Linhas 11001 a 11021:
11001:                 loc_cCod = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
11002:             ENDIF
11003:             IF !EMPTY(loc_cCod)
11004:                 loc_nRet = SQLEXEC(gnConnHandle, ;
11005:                     "SELECT usuarios FROM SigCdUsu " + ;
11006:                     "WHERE usuarios = " + EscaparSQL(loc_cCod), ;
11007:                     "cursor_4c_DesLactoBusca")
11008:                 IF loc_nRet > 0 AND USED("cursor_4c_DesLactoBusca") AND !EOF("cursor_4c_DesLactoBusca")
11009:                     IF USED("cursor_4c_DesLactoBusca")
11010:                         USE IN cursor_4c_DesLactoBusca
11011:                     ENDIF
11012:                 ELSE
11013:                     IF USED("cursor_4c_DesLactoBusca")
11014:                         USE IN cursor_4c_DesLactoBusca
11015:                     ENDIF
11016:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
11017:                         loc_oPg.txt_4c_DesLacto.Value = ""
11018:                     ENDIF
11019:                     THIS.AbrirBuscaDesLacto()
11020:                 ENDIF
11021:             ENDIF

*-- Linhas 11036 a 11055:
11036:             IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
11037:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
11038:             ENDIF
11039:             loc_nRet = SQLEXEC(gnConnHandle, ;
11040:                 "SELECT usuarios, ncomps FROM SigCdUsu ORDER BY usuarios", ;
11041:                 "cursor_4c_DesLactoBusca")
11042:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
11043:             IF VARTYPE(loc_oBusca) = "O"
11044:                 loc_oBusca.this_cCursorDestino = "cursor_4c_DesLactoBusca"
11045:                 loc_oBusca.DefinirCursor("cursor_4c_DesLactoBusca", "usuarios", "ncomps", ;
11046:                     "Selecionar Desenvolvedor")
11047:                 loc_oBusca.Mostrar()
11048:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
11049:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
11050:                         loc_oPg.txt_4c_DesLacto.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
11051:                     ENDIF
11052:                 ENDIF
11053:                 loc_oBusca = .NULL.
11054:             ENDIF
11055:             IF USED("cursor_4c_DesLactoBusca")

*-- Linhas 11077 a 11097:
11077:                 loc_cCod = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
11078:             ENDIF
11079:             IF !EMPTY(loc_cCod)
11080:                 loc_nRet = SQLEXEC(gnConnHandle, ;
11081:                     "SELECT usuarios FROM SigCdUsu " + ;
11082:                     "WHERE usuarios = " + EscaparSQL(loc_cCod), ;
11083:                     "cursor_4c_CriaLactoBusca")
11084:                 IF loc_nRet > 0 AND USED("cursor_4c_CriaLactoBusca") AND !EOF("cursor_4c_CriaLactoBusca")
11085:                     IF USED("cursor_4c_CriaLactoBusca")
11086:                         USE IN cursor_4c_CriaLactoBusca
11087:                     ENDIF
11088:                 ELSE
11089:                     IF USED("cursor_4c_CriaLactoBusca")
11090:                         USE IN cursor_4c_CriaLactoBusca
11091:                     ENDIF
11092:                     IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11093:                         loc_oPg.txt_4c_CriaLacto.Value = ""
11094:                     ENDIF
11095:                     THIS.AbrirBuscaCriaLacto()
11096:                 ENDIF
11097:             ENDIF

*-- Linhas 11112 a 11131:
11112:             IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11113:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
11114:             ENDIF
11115:             loc_nRet = SQLEXEC(gnConnHandle, ;
11116:                 "SELECT usuarios, ncomps FROM SigCdUsu ORDER BY usuarios", ;
11117:                 "cursor_4c_CriaLactoBusca")
11118:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
11119:             IF VARTYPE(loc_oBusca) = "O"
11120:                 loc_oBusca.this_cCursorDestino = "cursor_4c_CriaLactoBusca"
11121:                 loc_oBusca.DefinirCursor("cursor_4c_CriaLactoBusca", "usuarios", "ncomps", ;
11122:                     "Selecionar Criador")
11123:                 loc_oBusca.Mostrar()
11124:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
11125:                     IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11126:                         loc_oPg.txt_4c_CriaLacto.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
11127:                     ENDIF
11128:                 ENDIF
11129:                 loc_oBusca = .NULL.
11130:             ENDIF
11131:             IF USED("cursor_4c_CriaLactoBusca")

*-- Linhas 11148 a 11166:
11148:                 MsgAviso("Habilite Incluir ou Alterar para registrar tarefa.")
11149:             ELSE
11150:                 IF USED("cursor_4c_GrdDesigner")
11151:                     SELECT cursor_4c_GrdDesigner
11152:                     APPEND BLANK
11153:                     REPLACE cursor_4c_GrdDesigner.dtini    WITH DATE()
11154:                     REPLACE cursor_4c_GrdDesigner.usuarios WITH ALLTRIM(gc_4c_UsuarioLogado)
11155:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11156:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdDesigner", 5)
11157:                         loc_oPg.grd_4c_GrdDesigner.Refresh()
11158:                     ENDIF
11159:                 ENDIF
11160:             ENDIF
11161:         CATCH TO loException
11162:             MostrarErro("Erro ao registrar inicio de tarefa:" + CHR(13) + loException.Message, ;
11163:                 "FormProduto.BtnIniTarefaClick")
11164:         ENDTRY
11165:     ENDPROC
11166: 

*-- Linhas 11172 a 11190:
11172:                 MsgAviso("Habilite Incluir ou Alterar para registrar conclus" + CHR(227) + "o.")
11173:             ELSE
11174:                 IF USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
11175:                     SELECT cursor_4c_GrdDesigner
11176:                     REPLACE cursor_4c_GrdDesigner.dtfim WITH DATE()
11177:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11178:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdDesigner", 5)
11179:                         loc_oPg.grd_4c_GrdDesigner.Refresh()
11180:                     ENDIF
11181:                 ELSE
11182:                     MsgAviso("Selecione um registro de tarefa para registrar conclus" + CHR(227) + "o.")
11183:                 ENDIF
11184:             ENDIF
11185:         CATCH TO loException
11186:             MostrarErro("Erro ao registrar fim de tarefa:" + CHR(13) + loException.Message, ;
11187:                 "FormProduto.BtnFimTarefaClick")
11188:         ENDTRY
11189:     ENDPROC
11190: 

*-- Linhas 11197 a 11215:
11197:             ELSE
11198:                 loc_cArquivo = GETFILE("*", "Selecionar Arquivo")
11199:                 IF !EMPTY(loc_cArquivo) AND USED("cursor_4c_GrdArquivos")
11200:                     SELECT cursor_4c_GrdArquivos
11201:                     APPEND BLANK
11202:                     REPLACE cursor_4c_GrdArquivos.arqnome WITH ALLTRIM(loc_cArquivo)
11203:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11204:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdArquivos", 5)
11205:                         loc_oPg.grd_4c_GrdArquivos.Refresh()
11206:                     ENDIF
11207:                 ENDIF
11208:             ENDIF
11209:         CATCH TO loException
11210:             MostrarErro("Erro ao inserir arquivo:" + CHR(13) + loException.Message, ;
11211:                 "FormProduto.BtnInsArqsClick")
11212:         ENDTRY
11213:     ENDPROC
11214: 
11215:     *-- btnExcArqs: exclui arquivo selecionado da lista grdArquivos

*-- Linhas 11222 a 11241:
11222:                 IF USED("cursor_4c_GrdArquivos") AND !EOF("cursor_4c_GrdArquivos")
11223:                     loc_lConfirm = MsgConfirma("Confirma exclus" + CHR(227) + "o do arquivo selecionado?")
11224:                     IF loc_lConfirm
11225:                         SELECT cursor_4c_GrdArquivos
11226:                         DELETE
11227:                         PACK
11228:                         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11229:                         IF PEMSTATUS(loc_oPg, "grd_4c_GrdArquivos", 5)
11230:                             loc_oPg.grd_4c_GrdArquivos.Refresh()
11231:                         ENDIF
11232:                     ENDIF
11233:                 ELSE
11234:                     MsgAviso("Selecione um arquivo para excluir.")
11235:                 ENDIF
11236:             ENDIF
11237:         CATCH TO loException
11238:             MostrarErro("Erro ao excluir arquivo:" + CHR(13) + loException.Message, ;
11239:                 "FormProduto.BtnExcArqsClick")
11240:         ENDTRY
11241:     ENDPROC

*-- Linhas 11290 a 11363:
11290:             *-- Cursor placeholder ANTES de RecordSource (REGRA CRITICA VFP9)
11291:             IF !USED("cursor_4c_GrdServico")
11292:                 SET NULL ON
11293:                 CREATE CURSOR cursor_4c_GrdServico (Marcas N(1,0), Cods C(3), Descs C(30), qtdias N(3,0))
11294:                 SET NULL OFF
11295:             ENDIF
11296: 
11297:             *-- grd_4c_Dados: grade de servicos associados
11298:             *-- Original grdServico: top=171, left=339, width=320, height=387
11299:             loc_oPg.AddObject("grd_4c_Dados", "Grid")
11300:             WITH loc_oPg.grd_4c_Dados
11301:                 .Top        = 171
11302:                 .Left       = 339
11303:                 .Width      = 320
11304:                 .Height     = 387
11305:                 .FontName   = "Tahoma"
11306:                 .FontSize   = 8
11307:                 .DeleteMark = .F.
11308:                 .RecordMark = .F.
11309:                 .RowHeight  = 16
11310:                 .ScrollBars = 2
11311:                 .Visible    = .T.
11312:             ENDWITH
11313:             loc_oPg.grd_4c_Dados.ColumnCount  = 3
11314:             loc_oPg.grd_4c_Dados.RecordSource = "cursor_4c_GrdServico"
11315:             loc_oGrid = loc_oPg.grd_4c_Dados
11316: 
11317:             *-- Column1: Descs/Descricao Servico (ColumnOrder=2 - exibida como 2a coluna)
11318:             *-- When: editavel em INCLUIR/ALTERAR E Marcas=1 na linha atual
11319:             *-- Valid: fAcessoEmpresa (validacao empresa por descricao de servico)
11320:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdServico.Descs"
11321:             loc_oGrid.Column1.Width           = 228
11322:             loc_oGrid.Column1.ColumnOrder     = 2
11323:             loc_oGrid.Column1.Movable         = .F.
11324:             loc_oGrid.Column1.Resizable       = .F.
11325:             loc_oGrid.Column1.Header1.Caption = "Servi" + CHR(231) + "os"
11326:             loc_oGrid.Column1.Text1.Alignment  = 3
11327:             loc_oGrid.Column1.Text1.BorderStyle = 0
11328:             loc_oGrid.Column1.Text1.Margin     = 0
11329:             BINDEVENT(loc_oGrid.Column1.Text1, "When",  THIS, "GrdServicoCol1When")
11330:             BINDEVENT(loc_oGrid.Column1.Text1, "Valid",  THIS, "GrdServicoCol1Valid")
11331: 
11332:             *-- Column2: Cods/Codigo Servico (ColumnOrder=3, somente leitura)
11333:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdServico.Cods"
11334:             loc_oGrid.Column2.Width           = 50
11335:             loc_oGrid.Column2.ColumnOrder     = 3
11336:             loc_oGrid.Column2.Movable         = .F.
11337:             loc_oGrid.Column2.Resizable       = .F.
11338:             loc_oGrid.Column2.ReadOnly        = .T.
11339:             loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
11340:             loc_oGrid.Column2.Text1.BorderStyle = 0
11341:             loc_oGrid.Column2.Text1.Margin     = 0
11342:             loc_oGrid.Column2.Text1.ReadOnly   = .T.
11343: 
11344:             *-- Column3: Marcas/CheckBox (ColumnOrder=1 - primeira coluna visualmente)
11345:             *-- Sparse=.F. obrigatorio para CheckBox funcionar em coluna de grid
11346:             *-- When: editavel em INCLUIR/ALTERAR
11347:             *-- KeyPress: Space(32) ou Enter(13) togla Marcas (0->1, 1->0)
11348:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdServico.Marcas"
11349:             loc_oGrid.Column3.Width           = 17
11350:             loc_oGrid.Column3.ColumnOrder     = 1
11351:             loc_oGrid.Column3.Movable         = .F.
11352:             loc_oGrid.Column3.Resizable       = .F.
11353:             loc_oGrid.Column3.Sparse          = .F.
11354:             loc_oGrid.Column3.Header1.Caption = ""
11355:             loc_oGrid.Column3.AddObject("Check1", "CheckBox")
11356:             WITH loc_oGrid.Column3.Check1
11357:                 .Caption   = ""
11358:                 .Alignment = 0
11359:                 .ReadOnly  = .F.
11360:                 .Visible   = .T.
11361:                 .Top       = 9
11362:                 .Left      = 2
11363:                 .Height    = 17

*-- Linhas 11387 a 11427:
11387: 
11388:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page8
11389: 
11390:             *-- Carregar todos os servicos com Marcas=0/1 via LEFT JOIN em SigSerPr
11391:             IF USED("cursor_4c_GrdServico")
11392:                 USE IN cursor_4c_GrdServico
11393:             ENDIF
11394:             loc_nRet = SQLEXEC(gnConnHandle, ;
11395:                 "SELECT CASE WHEN s.cods IS NOT NULL THEN 1 ELSE 0 END AS Marcas," + ;
11396:                 " p.cods, p.descs, p.qtdias" + ;
11397:                 " FROM SigPrSer p" + ;
11398:                 " LEFT JOIN SigSerPr s ON s.cods = p.cods AND s.cpros = " + EscaparSQL(loc_cCpros) + ;
11399:                 " ORDER BY p.descs", ;
11400:                 "cursor_4c_GrdServico")
11401:             IF loc_nRet <= 0
11402:                 CREATE CURSOR cursor_4c_GrdServico (Marcas N(1,0), Cods C(3), Descs C(30), qtdias N(3,0))
11403:             ENDIF
11404: 
11405:             *-- Reassociar RecordSource e ControlSources apos recarregar cursor
11406:             IF PEMSTATUS(loc_oPg, "grd_4c_Dados", 5)
11407:                 loc_oGrid = loc_oPg.grd_4c_Dados
11408:                 loc_oGrid.ColumnCount = 3
11409:                 loc_oGrid.RecordSource          = "cursor_4c_GrdServico"
11410:                 loc_oGrid.Column1.ControlSource = "cursor_4c_GrdServico.Descs"
11411:                 loc_oGrid.Column2.ControlSource = "cursor_4c_GrdServico.Cods"
11412:                 loc_oGrid.Column3.ControlSource = "cursor_4c_GrdServico.Marcas"
11413:                 loc_oGrid.Refresh()
11414:             ENDIF
11415: 
11416:         CATCH TO loException
11417:             MostrarErro("Erro ao carregar Servi" + CHR(231) + "os:" + CHR(13) + ;
11418:                 loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
11419:                 "FormProduto.CarregarServicos")
11420:         ENDTRY
11421:     ENDPROC
11422: 
11423:     *===========================================================================
11424:     * Handlers de BINDEVENT para pgServico (Page8)
11425:     * Todos PUBLIC - requerido pelo BINDEVENT
11426:     *===========================================================================
11427: 

