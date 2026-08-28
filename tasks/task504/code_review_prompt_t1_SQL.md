# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOEDS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: _XNRG, CPROS, CUNIS, MATPRINCS, CGRUS, PGRU, CODS, IFORS, REFFS, COLECOES, MOEMRKAPS, TPCALCPS, ACRESCS, VALORS, TPFTIOS, ARREDCS, MATS, PCOMPOS, PRODUTOS, CUSTOS, TIPOS, RESUMOS, I, 1, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, QTDS, CIDCHAVES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, TPCALCCUS, ESTIMADO, MERCS, ORDEM, ALTCOEF, USUARIOS, CODDEPTO, CODGRUPO, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, NTIPOJOALS, CESTOS, CONJUNTS, CODMACRO, CNJLACTO, USARPAS, APAGAR, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, PRODWEBS, MARCAS, OBRCONJUTS, EAN13, VLDCONJUTS, CATS, ENCOMS, MKPOBRIGS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CODIGO, CATEGORIA, CONTAS, PCESCOLHA, ETIQCDPRO, LINHAS, LNMARCKUPA, LOCLIVRE, TPCALCP, QTEQUALPS, TAG, ORDEMS, DESCRS, USUARS, CODCADS, DEPTOS, UTILACTO, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'UNIPRDTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: _XNRG, CPROS, CUNIS, MATPRINCS, CGRUS, PGRU, CODS, IFORS, REFFS, COLECOES, MOEMRKAPS, TPCALCPS, ACRESCS, VALORS, TPFTIOS, ARREDCS, MATS, PCOMPOS, PRODUTOS, CUSTOS, TIPOS, RESUMOS, I, 1, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, QTDS, CIDCHAVES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, TPCALCCUS, ESTIMADO, MERCS, ORDEM, ALTCOEF, USUARIOS, CODDEPTO, CODGRUPO, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, NTIPOJOALS, CESTOS, CONJUNTS, CODMACRO, CNJLACTO, USARPAS, APAGAR, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, PRODWEBS, MARCAS, OBRCONJUTS, EAN13, VLDCONJUTS, CATS, ENCOMS, MKPOBRIGS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CODIGO, CATEGORIA, CONTAS, PCESCOLHA, ETIQCDPRO, LINHAS, LNMARCKUPA, LOCLIVRE, TPCALCP, QTEQUALPS, TAG, ORDEMS, DESCRS, USUARS, CODCADS, DEPTOS, UTILACTO, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONQUILHAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: _XNRG, CPROS, CUNIS, MATPRINCS, CGRUS, PGRU, CODS, IFORS, REFFS, COLECOES, MOEMRKAPS, TPCALCPS, ACRESCS, VALORS, TPFTIOS, ARREDCS, MATS, PCOMPOS, PRODUTOS, CUSTOS, TIPOS, RESUMOS, I, 1, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, QTDS, CIDCHAVES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, TPCALCCUS, ESTIMADO, MERCS, ORDEM, ALTCOEF, USUARIOS, CODDEPTO, CODGRUPO, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, NTIPOJOALS, CESTOS, CONJUNTS, CODMACRO, CNJLACTO, USARPAS, APAGAR, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, PRODWEBS, MARCAS, OBRCONJUTS, EAN13, VLDCONJUTS, CATS, ENCOMS, MKPOBRIGS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CODIGO, CATEGORIA, CONTAS, PCESCOLHA, ETIQCDPRO, LINHAS, LNMARCKUPA, LOCLIVRE, TPCALCP, QTEQUALPS, TAG, ORDEMS, DESCRS, USUARS, CODCADS, DEPTOS, UTILACTO, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRICAOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: _XNRG, CPROS, CUNIS, MATPRINCS, CGRUS, PGRU, CODS, IFORS, REFFS, COLECOES, MOEMRKAPS, TPCALCPS, ACRESCS, VALORS, TPFTIOS, ARREDCS, MATS, PCOMPOS, PRODUTOS, CUSTOS, TIPOS, RESUMOS, I, 1, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, QTDS, CIDCHAVES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, TPCALCCUS, ESTIMADO, MERCS, ORDEM, ALTCOEF, USUARIOS, CODDEPTO, CODGRUPO, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, NTIPOJOALS, CESTOS, CONJUNTS, CODMACRO, CNJLACTO, USARPAS, APAGAR, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, PRODWEBS, MARCAS, OBRCONJUTS, EAN13, VLDCONJUTS, CATS, ENCOMS, MKPOBRIGS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CODIGO, CATEGORIA, CONTAS, PCESCOLHA, ETIQCDPRO, LINHAS, LNMARCKUPA, LOCLIVRE, TPCALCP, QTEQUALPS, TAG, ORDEMS, DESCRS, USUARS, CODCADS, DEPTOS, UTILACTO, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CATIVOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: _XNRG, CPROS, CUNIS, MATPRINCS, CGRUS, PGRU, CODS, IFORS, REFFS, COLECOES, MOEMRKAPS, TPCALCPS, ACRESCS, VALORS, TPFTIOS, ARREDCS, MATS, PCOMPOS, PRODUTOS, CUSTOS, TIPOS, RESUMOS, I, 1, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, QTDS, CIDCHAVES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, TPCALCCUS, ESTIMADO, MERCS, ORDEM, ALTCOEF, USUARIOS, CODDEPTO, CODGRUPO, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, NTIPOJOALS, CESTOS, CONJUNTS, CODMACRO, CNJLACTO, USARPAS, APAGAR, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, PRODWEBS, MARCAS, OBRCONJUTS, EAN13, VLDCONJUTS, CATS, ENCOMS, MKPOBRIGS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CODIGO, CATEGORIA, CONTAS, PCESCOLHA, ETIQCDPRO, LINHAS, LNMARCKUPA, LOCLIVRE, TPCALCP, QTEQUALPS, TAG, ORDEMS, DESCRS, USUARS, CODCADS, DEPTOS, UTILACTO, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (11438 linhas total):

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

*-- Linhas 1346 a 1395:
1346: 
1347:     *===========================================================================
1348:     * CarregarLista - Carrega dados no grid da Page1
1349:     * CRITICO: Definir ControlSources APOS RecordSource (auto-bind)
1350:     *===========================================================================
1351:     PROCEDURE CarregarLista()
1352:         LOCAL loc_lResultado, loc_oGrid
1353:         loc_lResultado = .F.
1354: 
1355:         TRY
1356:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1357:                 CREATE CURSOR cursor_4c_Dados (cpros C(14), dpros C(65), cgrus C(3), ;
1358:                     sgrus C(6), linhas C(10), tipos C(1), situas N(1,0), ifors C(10), ;
1359:                     pvens N(11,5), pcuss N(11,5), custofs N(11,3), cunis C(3), ;
1360:                     matprincs C(14), codcors C(4), codtams C(4), reffs C(40), ;
1361:                     colecoes C(10), idpro N(10,0))
1362:                 loc_lResultado = .T.
1363:             ELSE
1364:                 IF !THIS.this_oBusinessObject.Buscar("")
1365:                     loc_lResultado = .F.
1366:                 ELSE
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
1395:                 loc_oGrid.Column4.Header1.Caption = "Subgrp."

*-- Linhas 1496 a 1514:
1496:         loc_cCodigo = ""
1497: 
1498:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1499:             SELECT cursor_4c_Dados
1500:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
1501:         ENDIF
1502: 
1503:         IF EMPTY(loc_cCodigo)
1504:             MsgAviso("Selecione um produto para visualizar.")
1505:         ELSE
1506:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1507:                 THIS.this_cModoAtual = "VISUALIZAR"
1508:                 THIS.BOParaForm()
1509:                 THIS.HabilitarCampos(.F.)
1510:                 THIS.AjustarBotoesPorModo()
1511:                 THIS.AlternarPagina(2)
1512:             ENDIF
1513:         ENDIF
1514:     ENDPROC

*-- Linhas 1522 a 1540:
1522:         loc_cCodigo = ""
1523: 
1524:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1525:             SELECT cursor_4c_Dados
1526:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
1527:         ENDIF
1528: 
1529:         IF EMPTY(loc_cCodigo)
1530:             MsgAviso("Selecione um produto para alterar.")
1531:         ELSE
1532:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1533:                 THIS.this_oBusinessObject.EditarRegistro()
1534:                 THIS.this_cModoAtual = "ALTERAR"
1535:                 THIS.BOParaForm()
1536:                 THIS.HabilitarCampos(.T.)
1537:                 THIS.AjustarBotoesPorModo()
1538:                 THIS.AlternarPagina(2)
1539:             ENDIF
1540:         ENDIF

*-- Linhas 1550 a 1568:
1550:         loc_cDescricao = ""
1551: 
1552:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1553:             SELECT cursor_4c_Dados
1554:             loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cpros)
1555:             loc_cDescricao = ALLTRIM(cursor_4c_Dados.dpros)
1556:         ENDIF
1557: 
1558:         IF EMPTY(loc_cCodigo)
1559:             MsgAviso("Selecione um produto para excluir.")
1560:         ELSE
1561:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1562:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto [" + ;
1563:                     loc_cCodigo + "] - " + loc_cDescricao + "?", ;
1564:                     "Confirmar Exclus" + CHR(227) + "o")
1565:                     IF THIS.this_oBusinessObject.Excluir()
1566:                         MsgInfo("Produto exclu" + CHR(237) + "do com sucesso!")
1567:                         THIS.CarregarLista()
1568:                     ENDIF

*-- Linhas 1580 a 1621:
1580:         loc_cCodigo = ""
1581: 
1582:         TRY
1583:             loc_nRet = SQLEXEC(gnConnHandle, ;
1584:                 "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros", ;
1585:                 "cursor_4c_BuscaProduto")
1586: 
1587:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaProduto")
1588:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1589:                 IF VARTYPE(loc_oBusca) = "O"
1590:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaProduto"
1591:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaProduto", "cpros", "dpros", ;
1592:                         "Buscar Produto")
1593:                     loc_oBusca.Mostrar()
1594:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado)
1595:                         loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1596:                     ENDIF
1597:                     loc_oBusca = .NULL.
1598:                 ENDIF
1599:             ENDIF
1600: 
1601:             IF USED("cursor_4c_BuscaProduto")
1602:                 USE IN cursor_4c_BuscaProduto
1603:             ENDIF
1604: 
1605:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
1606:                 SELECT cursor_4c_Dados
1607:                 LOCATE FOR ALLTRIM(cpros) == loc_cCodigo
1608:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1609:             ENDIF
1610: 
1611:         CATCH TO loException
1612:             IF USED("cursor_4c_BuscaProduto")
1613:                 USE IN cursor_4c_BuscaProduto
1614:             ENDIF
1615:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, ;
1616:                 "FormProduto.BtnBuscarClick")
1617:         ENDTRY
1618:     ENDPROC
1619: 
1620:     *===========================================================================
1621:     * BtnEncerrarClick - Fecha o formulario

*-- Linhas 1795 a 1813:
1795:                 *-- Flush obs do EditBox para o cursor da linha selecionada antes de salvar
1796:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase") AND ;
1797:                         PEMSTATUS(loc_oPgFP, "edt_4c_Obs", 5)
1798:                     SELECT cursor_4c_GradFase
1799:                     REPLACE cursor_4c_GradFase.obs WITH loc_oPgFP.edt_4c_Obs.Value
1800:                 ENDIF
1801:             ENDIF
1802: 
1803:             *-- Campos da aba Dados Fiscais (Page3 de pgf_4c_Dados)
1804:             LOCAL loc_oPgFisc, loc_nIpiIdx
1805:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
1806:             IF PEMSTATUS(loc_oPgFisc, "txt_4c_Clfiscal", 5)
1807:                 loc_oBO.this_cClfiscals  = ALLTRIM(loc_oPgFisc.txt_4c_Clfiscal.Value)
1808:                 loc_oBO.this_cOrigmercs  = ALLTRIM(loc_oPgFisc.txt_4c_Origmerc.Value)
1809:                 loc_oBO.this_cSittricms  = ALLTRIM(loc_oPgFisc.txt_4c_Sittricm.Value)
1810:                 loc_oBO.this_nIcms       = loc_oPgFisc.txt_4c_Icms.Value
1811:                 loc_oBO.this_cTptribs    = ALLTRIM(loc_oPgFisc.txt_4c_TpTrib.Value)
1812:                 loc_oBO.this_cIats       = ALLTRIM(loc_oPgFisc.txt_4c_Iat.Value)
1813:                 loc_oBO.this_nAliqipis   = loc_oPgFisc.txt_4c_AliqIPI.Value

*-- Linhas 2066 a 2155:
2066:             *-- Grupo (SigCdGrp: cgrus/dgrus)
2067:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
2068:             IF !EMPTY(loc_cCod)
2069:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2070:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
2071:                     "cursor_4c_LkpDesc")
2072:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2073:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_LkpDesc.dgrus)
2074:                 ENDIF
2075:                 IF USED("cursor_4c_LkpDesc")
2076:                     USE IN cursor_4c_LkpDesc
2077:                 ENDIF
2078:             ENDIF
2079: 
2080:             *-- Linha (SigCdLin: linhas/descs)
2081:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
2082:             IF !EMPTY(loc_cCod)
2083:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2084:                     "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
2085:                     "cursor_4c_LkpDesc")
2086:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2087:                     loc_oPg.txt_4c_DLinhas.Value = ALLTRIM(cursor_4c_LkpDesc.descs)
2088:                 ENDIF
2089:                 IF USED("cursor_4c_LkpDesc")
2090:                     USE IN cursor_4c_LkpDesc
2091:                 ENDIF
2092:             ENDIF
2093: 
2094:             *-- Colecao/Grupo de Venda (SigCdCol: colecoes/descs)
2095:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
2096:             IF !EMPTY(loc_cCod)
2097:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2098:                     "SELECT descs FROM SigCdCol WHERE colecoes = " + EscaparSQL(loc_cCod), ;
2099:                     "cursor_4c_LkpDesc")
2100:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2101:                     loc_oPg.txt_4c_DColecoes.Value = ALLTRIM(cursor_4c_LkpDesc.descs)
2102:                 ENDIF
2103:                 IF USED("cursor_4c_LkpDesc")
2104:                     USE IN cursor_4c_LkpDesc
2105:                 ENDIF
2106:             ENDIF
2107: 
2108:             *-- Fornecedor (SigCdFor: ifors/dfors)
2109:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
2110:             IF !EMPTY(loc_cCod)
2111:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2112:                     "SELECT dfors FROM SigCdFor WHERE ifors = " + EscaparSQL(loc_cCod), ;
2113:                     "cursor_4c_LkpDesc")
2114:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2115:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_LkpDesc.dfors)
2116:                 ENDIF
2117:                 IF USED("cursor_4c_LkpDesc")
2118:                     USE IN cursor_4c_LkpDesc
2119:                 ENDIF
2120:             ENDIF
2121: 
2122:             *-- Acabamento (SigCdAca: cods/descrs)
2123:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcbs.Value)
2124:             IF !EMPTY(loc_cCod)
2125:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2126:                     "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
2127:                     "cursor_4c_LkpDesc")
2128:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2129:                     loc_oPg.txt_4c_DAcbs.Value = ALLTRIM(cursor_4c_LkpDesc.descrs)
2130:                 ENDIF
2131:                 IF USED("cursor_4c_LkpDesc")
2132:                     USE IN cursor_4c_LkpDesc
2133:                 ENDIF
2134:             ENDIF
2135: 
2136:             *-- Unidade (SigCdUni: cunis/dunis)
2137:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)
2138:             IF !EMPTY(loc_cCod)
2139:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2140:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
2141:                     "cursor_4c_LkpDesc")
2142:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2143:                     loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_LkpDesc.dunis)
2144:                 ENDIF
2145:                 IF USED("cursor_4c_LkpDesc")
2146:                     USE IN cursor_4c_LkpDesc
2147:                 ENDIF
2148:             ENDIF
2149: 
2150:         CATCH TO loException
2151:             IF USED("cursor_4c_LkpDesc")
2152:                 USE IN cursor_4c_LkpDesc
2153:             ENDIF
2154:             MostrarErro("Erro ao carregar descri" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
2155:                 loException.Message, "FormProduto.CarregarDescricoes")

*-- Linhas 2171 a 2247:
2171:             *-- Classificacao Fiscal (SigCdClf: codigos/descricaos)
2172:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
2173:             IF !EMPTY(loc_cCod)
2174:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2175:                     "SELECT descricaos FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cCod), ;
2176:                     "cursor_4c_LkpFiscDesc")
2177:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
2178:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descricaos)
2179:                 ENDIF
2180:                 IF USED("cursor_4c_LkpFiscDesc")
2181:                     USE IN cursor_4c_LkpFiscDesc
2182:                 ENDIF
2183:             ENDIF
2184: 
2185:             *-- Origem Mercadoria (SIGCDORG: codigos/descricaos)
2186:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
2187:             IF !EMPTY(loc_cCod)
2188:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2189:                     "SELECT descricaos FROM SIGCDORG WHERE codigos = " + EscaparSQL(loc_cCod), ;
2190:                     "cursor_4c_LkpFiscDesc")
2191:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
2192:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descricaos)
2193:                 ENDIF
2194:                 IF USED("cursor_4c_LkpFiscDesc")
2195:                     USE IN cursor_4c_LkpFiscDesc
2196:                 ENDIF
2197:             ENDIF
2198: 
2199:             *-- Situacao Tributaria ICMS (SIGCDICM: codigos/descricaos)
2200:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
2201:             IF !EMPTY(loc_cCod)
2202:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2203:                     "SELECT descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
2204:                     "cursor_4c_LkpFiscDesc")
2205:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
2206:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descricaos)
2207:                 ENDIF
2208:                 IF USED("cursor_4c_LkpFiscDesc")
2209:                     USE IN cursor_4c_LkpFiscDesc
2210:                 ENDIF
2211:             ENDIF
2212: 
2213:             *-- Metal (SigCdMtl: codigos/descs WHERE tipos='M')
2214:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Metal.Value)
2215:             IF !EMPTY(loc_cCod)
2216:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2217:                     "SELECT descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
2218:                     " AND tipos = 'M'", ;
2219:                     "cursor_4c_LkpFiscDesc")
2220:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
2221:                     loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descs)
2222:                 ENDIF
2223:                 IF USED("cursor_4c_LkpFiscDesc")
2224:                     USE IN cursor_4c_LkpFiscDesc
2225:                 ENDIF
2226:             ENDIF
2227: 
2228:             *-- Teor (SigCdMtl: codigos/descs WHERE tipos<>'M')
2229:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Teor.Value)
2230:             IF !EMPTY(loc_cCod)
2231:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2232:                     "SELECT descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
2233:                     " AND tipos <> 'M'", ;
2234:                     "cursor_4c_LkpFiscDesc")
2235:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
2236:                     loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descs)
2237:                 ENDIF
2238:                 IF USED("cursor_4c_LkpFiscDesc")
2239:                     USE IN cursor_4c_LkpFiscDesc
2240:                 ENDIF
2241:             ENDIF
2242: 
2243:         CATCH TO loException
2244:             IF USED("cursor_4c_LkpFiscDesc")
2245:                 USE IN cursor_4c_LkpFiscDesc
2246:             ENDIF
2247:             MostrarErro("Erro ao carregar descri" + CHR(231) + CHR(245) + "es fiscais:" + CHR(13) + ;

*-- Linhas 2312 a 2331:
2312:             IF EMPTY(loc_cCod)
2313:                 loc_oPg.txt_4c_Dgrus.Value = ""
2314:             ELSE
2315:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2316:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
2317:                     "cursor_4c_LkpCgrus")
2318: 
2319:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpCgrus") AND !EOF("cursor_4c_LkpCgrus")
2320:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_LkpCgrus.dgrus)
2321:                     USE IN cursor_4c_LkpCgrus
2322:                 ELSE
2323:                     IF USED("cursor_4c_LkpCgrus")
2324:                         USE IN cursor_4c_LkpCgrus
2325:                     ENDIF
2326:                     loc_oPg.txt_4c_Cgrus.Value = ""
2327:                     loc_oPg.txt_4c_Dgrus.Value = ""
2328:                     THIS.AbrirBuscaGrupo()
2329:                 ENDIF
2330:             ENDIF
2331: 

*-- Linhas 2361 a 2380:
2361:             IF EMPTY(loc_cCod)
2362:                 loc_oPg.txt_4c_DLinhas.Value = ""
2363:             ELSE
2364:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2365:                     "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
2366:                     "cursor_4c_LkpLinha")
2367: 
2368:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpLinha") AND !EOF("cursor_4c_LkpLinha")
2369:                     loc_oPg.txt_4c_DLinhas.Value = ALLTRIM(cursor_4c_LkpLinha.descs)
2370:                     USE IN cursor_4c_LkpLinha
2371:                 ELSE
2372:                     IF USED("cursor_4c_LkpLinha")
2373:                         USE IN cursor_4c_LkpLinha
2374:                     ENDIF
2375:                     loc_oPg.txt_4c_Linhas.Value  = ""
2376:                     loc_oPg.txt_4c_DLinhas.Value = ""
2377:                     MsgAviso("Linha n" + CHR(227) + "o encontrada.")
2378:                 ENDIF
2379:             ENDIF
2380: 

*-- Linhas 2400 a 2419:
2400:             IF EMPTY(loc_cCod)
2401:                 loc_oPg.txt_4c_DColecoes.Value = ""
2402:             ELSE
2403:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2404:                     "SELECT descs FROM SigCdCol WHERE colecoes = " + EscaparSQL(loc_cCod), ;
2405:                     "cursor_4c_LkpColecao")
2406: 
2407:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpColecao") AND !EOF("cursor_4c_LkpColecao")
2408:                     loc_oPg.txt_4c_DColecoes.Value = ALLTRIM(cursor_4c_LkpColecao.descs)
2409:                     USE IN cursor_4c_LkpColecao
2410:                 ELSE
2411:                     IF USED("cursor_4c_LkpColecao")
2412:                         USE IN cursor_4c_LkpColecao
2413:                     ENDIF
2414:                     loc_oPg.txt_4c_Colecoes.Value  = ""
2415:                     loc_oPg.txt_4c_DColecoes.Value = ""
2416:                     MsgAviso("Grupo de venda n" + CHR(227) + "o encontrado.")
2417:                 ENDIF
2418:             ENDIF
2419: 

*-- Linhas 2439 a 2458:
2439:             IF EMPTY(loc_cCod)
2440:                 loc_oPg.txt_4c_Dfors.Value = ""
2441:             ELSE
2442:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2443:                     "SELECT dfors FROM SigCdFor WHERE ifors = " + EscaparSQL(loc_cCod), ;
2444:                     "cursor_4c_LkpForn")
2445: 
2446:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpForn") AND !EOF("cursor_4c_LkpForn")
2447:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_LkpForn.dfors)
2448:                     USE IN cursor_4c_LkpForn
2449:                 ELSE
2450:                     IF USED("cursor_4c_LkpForn")
2451:                         USE IN cursor_4c_LkpForn
2452:                     ENDIF
2453:                     loc_oPg.txt_4c_Ifors.Value = ""
2454:                     loc_oPg.txt_4c_Dfors.Value = ""
2455:                     THIS.AbrirBuscaFornecedor()
2456:                 ENDIF
2457:             ENDIF
2458: 

*-- Linhas 2476 a 2495:
2476:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodCors.Value)
2477: 
2478:             IF !EMPTY(loc_cCod)
2479:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2480:                     "SELECT cods FROM SigCdCor WHERE cods = " + EscaparSQL(loc_cCod), ;
2481:                     "cursor_4c_LkpCor")
2482: 
2483:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpCor") AND !EOF("cursor_4c_LkpCor")
2484:                     USE IN cursor_4c_LkpCor
2485:                 ELSE
2486:                     IF USED("cursor_4c_LkpCor")
2487:                         USE IN cursor_4c_LkpCor
2488:                     ENDIF
2489:                     loc_oPg.txt_4c_CodCors.Value = ""
2490:                     MsgAviso("Cor n" + CHR(227) + "o encontrada.")
2491:                 ENDIF
2492:             ENDIF
2493: 
2494:         CATCH TO loException
2495:             IF USED("cursor_4c_LkpCor")

*-- Linhas 2511 a 2530:
2511:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodTams.Value)
2512: 
2513:             IF !EMPTY(loc_cCod)
2514:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2515:                     "SELECT cods FROM SigCdTam WHERE cods = " + EscaparSQL(loc_cCod), ;
2516:                     "cursor_4c_LkpTam")
2517: 
2518:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpTam") AND !EOF("cursor_4c_LkpTam")
2519:                     USE IN cursor_4c_LkpTam
2520:                 ELSE
2521:                     IF USED("cursor_4c_LkpTam")
2522:                         USE IN cursor_4c_LkpTam
2523:                     ENDIF
2524:                     loc_oPg.txt_4c_CodTams.Value = ""
2525:                     MsgAviso("Tamanho n" + CHR(227) + "o encontrado.")
2526:                 ENDIF
2527:             ENDIF
2528: 
2529:         CATCH TO loException
2530:             IF USED("cursor_4c_LkpTam")

*-- Linhas 2548 a 2567:
2548:             IF EMPTY(loc_cCod)
2549:                 loc_oPg.txt_4c_DAcbs.Value = ""
2550:             ELSE
2551:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2552:                     "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
2553:                     "cursor_4c_LkpAcab")
2554: 
2555:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpAcab") AND !EOF("cursor_4c_LkpAcab")
2556:                     loc_oPg.txt_4c_DAcbs.Value = ALLTRIM(cursor_4c_LkpAcab.descrs)
2557:                     USE IN cursor_4c_LkpAcab
2558:                 ELSE
2559:                     IF USED("cursor_4c_LkpAcab")
2560:                         USE IN cursor_4c_LkpAcab
2561:                     ENDIF
2562:                     loc_oPg.txt_4c_CodAcbs.Value = ""
2563:                     loc_oPg.txt_4c_DAcbs.Value   = ""
2564:                     MsgAviso("Acabamento n" + CHR(227) + "o encontrado.")
2565:                 ENDIF
2566:             ENDIF
2567: 

*-- Linhas 2587 a 2606:
2587:             IF EMPTY(loc_cCod)
2588:                 loc_oPg.txt_4c_Dunis.Value = ""
2589:             ELSE
2590:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2591:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
2592:                     "cursor_4c_LkpUni")
2593: 
2594:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpUni") AND !EOF("cursor_4c_LkpUni")
2595:                     loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_LkpUni.dunis)
2596:                     USE IN cursor_4c_LkpUni
2597:                 ELSE
2598:                     IF USED("cursor_4c_LkpUni")
2599:                         USE IN cursor_4c_LkpUni
2600:                     ENDIF
2601:                     loc_oPg.txt_4c_Cunis.Value = ""
2602:                     loc_oPg.txt_4c_Dunis.Value = ""
2603:                     MsgAviso("Unidade n" + CHR(227) + "o encontrada.")
2604:                 ENDIF
2605:             ENDIF
2606: 

*-- Linhas 2623 a 2650:
2623:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2624:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
2625: 
2626:             loc_nRet = SQLEXEC(gnConnHandle, ;
2627:                 "SELECT cgrus, dgrus FROM SigCdGrp WHERE cgrus LIKE '" + ;
2628:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cgrus", ;
2629:                 "cursor_4c_GrpBusca")
2630: 
2631:             IF loc_nRet <= 0 OR !USED("cursor_4c_GrpBusca") OR EOF("cursor_4c_GrpBusca")
2632:                 IF USED("cursor_4c_GrpBusca")
2633:                     USE IN cursor_4c_GrpBusca
2634:                 ENDIF
2635:                 SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", ;
2636:                     "cursor_4c_GrpBusca")
2637:             ENDIF
2638: 
2639:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2640:             IF VARTYPE(loc_oBusca) = "O"
2641:                 loc_oBusca.this_cCursorDestino = "cursor_4c_GrpBusca"
2642:                 loc_oBusca.DefinirCursor("cursor_4c_GrpBusca", "cgrus", "dgrus", ;
2643:                     "Buscar Grupo de Produto")
2644:                 loc_oBusca.Mostrar()
2645: 
2646:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
2647:                     loc_oPg.txt_4c_Cgrus.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
2648:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
2649:                 ENDIF
2650:                 loc_oBusca = .NULL.

*-- Linhas 2673 a 2700:
2673:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2674:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
2675: 
2676:             loc_nRet = SQLEXEC(gnConnHandle, ;
2677:                 "SELECT ifors, dfors FROM SigCdFor WHERE ifors LIKE '" + ;
2678:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY dfors", ;
2679:                 "cursor_4c_FornBusca")
2680: 
2681:             IF loc_nRet <= 0 OR !USED("cursor_4c_FornBusca") OR EOF("cursor_4c_FornBusca")
2682:                 IF USED("cursor_4c_FornBusca")
2683:                     USE IN cursor_4c_FornBusca
2684:                 ENDIF
2685:                 SQLEXEC(gnConnHandle, "SELECT ifors, dfors FROM SigCdFor ORDER BY dfors", ;
2686:                     "cursor_4c_FornBusca")
2687:             ENDIF
2688: 
2689:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2690:             IF VARTYPE(loc_oBusca) = "O"
2691:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FornBusca"
2692:                 loc_oBusca.DefinirCursor("cursor_4c_FornBusca", "ifors", "dfors", ;
2693:                     "Buscar Fornecedor")
2694:                 loc_oBusca.Mostrar()
2695: 
2696:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
2697:                     loc_oPg.txt_4c_Ifors.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
2698:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
2699:                 ENDIF
2700:                 loc_oBusca = .NULL.

*-- Linhas 2743 a 2761:
2743: 
2744:             *-- Cursor placeholder para grd_4c_Cmv (RecordSource = TotGrupo2)
2745:             IF !USED("cursor_4c_TotGrupo2")
2746:                 CREATE CURSOR cursor_4c_TotGrupo2 ( ;
2747:                     Grupo    C(3), ValGrupo N(12,3), Moeda C(3), Estimado N(1,0))
2748:             ENDIF
2749: 
2750:             *====================================================================
2751:             *  SECAO: Configuracao / Tipo produto (topo)
2752:             *====================================================================
2753: 
2754:             *-- lbl_4c_Label29: "Configuracao :" (Say29, top=128, left=129)
2755:             loc_oPg.AddObject("lbl_4c_Label29", "Label")
2756:             WITH loc_oPg.lbl_4c_Label29
2757:                 .Caption   = "Configura" + CHR(231) + CHR(227) + "o :"
2758:                 .Top       = 128
2759:                 .Left      = 129
2760:                 .Width     = 73
2761:                 .Height    = 15

*-- Linhas 2768 a 2786:
2768:             ENDWITH
2769: 
2770:             *-- obj_4c_Fwoption1: OptionGroup "Importado / Nacional" (Fwoption1, top=123, left=204)
2771:             *-- ControlSource: TpCodPro (nao existe no schema atual - UI-only)
2772:             loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
2773:             WITH loc_oPg.obj_4c_Fwoption1
2774:                 .ButtonCount  = 2
2775:                 .Top          = 123
2776:                 .Left         = 204
2777:                 .Width        = 151
2778:                 .Height       = 24
2779:                 .BackStyle    = 0
2780:                 .BorderStyle  = 0
2781:                 .Value        = 1
2782:                 .AutoSize     = .F.
2783:                 .Visible      = .T.
2784: 
2785:                 .Buttons(1).Caption   = "Importado"
2786:                 .Buttons(1).FontName  = "Tahoma"

*-- Linhas 3496 a 3541:
3496:                 .FontSize   = 8
3497:                 .RecordMark = .T.
3498:                 .RowHeight  = 17
3499:                 .DeleteMark = .F.
3500:                 .ReadOnly   = .T.
3501:                 .Visible    = .T.
3502:             ENDWITH
3503:             loc_oPg.grd_4c_Cmv.ColumnCount  = 3
3504:             loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_TotGrupo2"
3505:             loc_oGrid = loc_oPg.grd_4c_Cmv
3506: 
3507:             loc_oGrid.Column1.ControlSource   = "cursor_4c_TotGrupo2.Grupo"
3508:             loc_oGrid.Column1.Width           = 59
3509:             loc_oGrid.Column1.Movable         = .F.
3510:             loc_oGrid.Column1.Resizable       = .F.
3511:             loc_oGrid.Column1.ReadOnly        = .T.
3512:             loc_oGrid.Column1.FontName        = "Courier New"
3513:             loc_oGrid.Column1.FontSize        = 8
3514:             loc_oGrid.Column1.Header1.Caption = "Per" + CHR(237) + "odo"
3515: 
3516:             loc_oGrid.Column2.ControlSource   = "cursor_4c_TotGrupo2.ValGrupo"
3517:             loc_oGrid.Column2.Width           = 100
3518:             loc_oGrid.Column2.Movable         = .F.
3519:             loc_oGrid.Column2.Resizable       = .F.
3520:             loc_oGrid.Column2.ReadOnly        = .T.
3521:             loc_oGrid.Column2.InputMask       = "999,999,999.999"
3522:             loc_oGrid.Column2.FontName        = "Courier New"
3523:             loc_oGrid.Column2.FontSize        = 8
3524:             loc_oGrid.Column2.Header1.Caption = "Valor Custo GR"
3525: 
3526:             loc_oGrid.Column3.ControlSource   = "cursor_4c_TotGrupo2.Moeda"
3527:             loc_oGrid.Column3.Width           = 31
3528:             loc_oGrid.Column3.ReadOnly        = .T.
3529:             loc_oGrid.Column3.Header1.Caption = "Moe"
3530: 
3531:             *====================================================================
3532:             *  SECAO: Descricao ECF / Metal / Teor
3533:             *====================================================================
3534: 
3535:             *-- lbl_4c_Label12: "Descricao ECF :" (Say12, top=497, left=125)
3536:             loc_oPg.AddObject("lbl_4c_Label12", "Label")
3537:             WITH loc_oPg.lbl_4c_Label12
3538:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o ECF :"
3539:                 .Top       = 497
3540:                 .Left      = 125
3541:                 .Width     = 77

*-- Linhas 3756 a 3782:
3756:             *-- Cursors placeholder para os grids (ANTES de RecordSource)
3757:             *-- Reutiliza cursor_4c_GrdCompo e TotGrupo criados por pgComposicao se existirem
3758:             IF !USED("cursor_4c_GrdCompo")
3759:                 CREATE CURSOR cursor_4c_GrdCompo ( ;
3760:                     cpros    C(14), dpros    C(65),  cunis  C(5),  ;
3761:                     valor    N(14,3), qtdes  N(10,3), total N(14,3), ;
3762:                     moeda    C(3),  obs      C(80),  estoc  C(1),   ;
3763:                     consumo  N(10,0), qtdes2 N(10,3), cunis2 C(5),  ;
3764:                     ords     N(5,0), matprinc C(14))
3765:             ENDIF
3766:             IF !USED("TotGrupo")
3767:                 CREATE CURSOR TotGrupo (Grupo C(10), ValGrupo N(14,3), Moeda C(3))
3768:             ENDIF
3769: 
3770:             *-- lbl_4c_Label1: "Tipo :" (Say1, top=159, left=107)
3771:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
3772:             WITH loc_oPg.lbl_4c_Label1
3773:                 .Caption   = "Tipo :"
3774:                 .Top       = 159
3775:                 .Left      = 107
3776:                 .Width     = 29
3777:                 .Height    = 15
3778:                 .FontName  = "Tahoma"
3779:                 .FontSize  = 8
3780:                 .ForeColor = RGB(90, 90, 90)
3781:                 .BackStyle = 0
3782:                 .AutoSize  = .T.

*-- Linhas 3810 a 3910:
3810:                 .RecordMark = .F.
3811:                 .RowHeight  = 16
3812:                 .ScrollBars = 2
3813:                 .DeleteMark = .F.
3814:                 .Visible    = .T.
3815:             ENDWITH
3816:             loc_oPg.grd_4c_GrdCusto.ColumnCount  = 12
3817:             loc_oPg.grd_4c_GrdCusto.RecordSource = "cursor_4c_GrdCompo"
3818:             loc_oGrid = loc_oPg.grd_4c_GrdCusto
3819: 
3820:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdCompo.cpros"
3821:             loc_oGrid.Column1.Width           = 90
3822:             loc_oGrid.Column1.ColumnOrder     = 1
3823:             loc_oGrid.Column1.Movable         = .F.
3824:             loc_oGrid.Column1.Resizable       = .F.
3825:             loc_oGrid.Column1.Header1.Caption = "Item"
3826: 
3827:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdCompo.dpros"
3828:             loc_oGrid.Column2.Width           = 175
3829:             loc_oGrid.Column2.ColumnOrder     = 2
3830:             loc_oGrid.Column2.Movable         = .F.
3831:             loc_oGrid.Column2.Resizable       = .F.
3832:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3833: 
3834:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdCompo.cunis"
3835:             loc_oGrid.Column3.Width           = 30
3836:             loc_oGrid.Column3.ColumnOrder     = 3
3837:             loc_oGrid.Column3.Movable         = .F.
3838:             loc_oGrid.Column3.Resizable       = .F.
3839:             loc_oGrid.Column3.Header1.Caption = "Un"
3840: 
3841:             loc_oGrid.Column4.ControlSource   = "cursor_4c_GrdCompo.valor"
3842:             loc_oGrid.Column4.Width           = 75
3843:             loc_oGrid.Column4.ColumnOrder     = 4
3844:             loc_oGrid.Column4.Movable         = .F.
3845:             loc_oGrid.Column4.Resizable       = .F.
3846:             loc_oGrid.Column4.InputMask       = "9999999.999"
3847:             loc_oGrid.Column4.Header1.Caption = "Valor"
3848: 
3849:             loc_oGrid.Column5.ControlSource   = "cursor_4c_GrdCompo.qtdes"
3850:             loc_oGrid.Column5.Width           = 55
3851:             loc_oGrid.Column5.ColumnOrder     = 5
3852:             loc_oGrid.Column5.Movable         = .F.
3853:             loc_oGrid.Column5.Resizable       = .F.
3854:             loc_oGrid.Column5.InputMask       = "9999.999"
3855:             loc_oGrid.Column5.Header1.Caption = "Qtd"
3856: 
3857:             loc_oGrid.Column6.ControlSource   = "cursor_4c_GrdCompo.total"
3858:             loc_oGrid.Column6.Width           = 75
3859:             loc_oGrid.Column6.ColumnOrder     = 6
3860:             loc_oGrid.Column6.Movable         = .F.
3861:             loc_oGrid.Column6.Resizable       = .F.
3862:             loc_oGrid.Column6.InputMask       = "9999999.999"
3863:             loc_oGrid.Column6.Header1.Caption = "Total"
3864: 
3865:             loc_oGrid.Column7.ControlSource   = "cursor_4c_GrdCompo.moeda"
3866:             loc_oGrid.Column7.Width           = 30
3867:             loc_oGrid.Column7.ColumnOrder     = 7
3868:             loc_oGrid.Column7.Header1.Caption = "Moe"
3869: 
3870:             loc_oGrid.Column8.ControlSource   = "cursor_4c_GrdCompo.obs"
3871:             loc_oGrid.Column8.Width           = 100
3872:             loc_oGrid.Column8.ColumnOrder     = 8
3873:             loc_oGrid.Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
3874: 
3875:             loc_oGrid.Column9.ControlSource   = "cursor_4c_GrdCompo.estoc"
3876:             loc_oGrid.Column9.Width           = 25
3877:             loc_oGrid.Column9.ColumnOrder     = 9
3878:             loc_oGrid.Column9.Format          = "M"
3879:             loc_oGrid.Column9.InputMask       = "N,S"
3880:             loc_oGrid.Column9.Header1.Caption = "Etiq"
3881: 
3882:             loc_oGrid.Column10.ControlSource   = "cursor_4c_GrdCompo.consumo"
3883:             loc_oGrid.Column10.Width           = 55
3884:             loc_oGrid.Column10.ColumnOrder     = 10
3885:             loc_oGrid.Column10.InputMask       = "99999"
3886:             loc_oGrid.Column10.Header1.Caption = "Consumo"
3887: 
3888:             loc_oGrid.Column11.ControlSource   = "cursor_4c_GrdCompo.qtdes2"
3889:             loc_oGrid.Column11.Width           = 55
3890:             loc_oGrid.Column11.ColumnOrder     = 11
3891:             loc_oGrid.Column11.Movable         = .F.
3892:             loc_oGrid.Column11.Resizable       = .F.
3893:             loc_oGrid.Column11.Header1.Caption = "Qtd"
3894: 
3895:             loc_oGrid.Column12.ControlSource   = "cursor_4c_GrdCompo.cunis2"
3896:             loc_oGrid.Column12.Width           = 30
3897:             loc_oGrid.Column12.ColumnOrder     = 12
3898:             loc_oGrid.Column12.Movable         = .F.
3899:             loc_oGrid.Column12.Resizable       = .F.
3900:             loc_oGrid.Column12.ReadOnly        = .T.
3901:             loc_oGrid.Column12.Header1.Caption = "Un"
3902: 
3903:             BINDEVENT(loc_oPg.grd_4c_GrdCusto, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")
3904: 
3905:             *-- cmg_4c_CmdgCusto: 2 botoes de controle (cmdgCompo, top=240, left=851)
3906:             loc_oPg.AddObject("cmg_4c_CmdgCusto", "CommandGroup")
3907:             WITH loc_oPg.cmg_4c_CmdgCusto
3908:                 .Top         = 240
3909:                 .Left        = 851
3910:                 .Width       = 50

*-- Linhas 4041 a 4085:
4041:                 .Height       = 141
4042:                 .FontName     = "Verdana"
4043:                 .FontSize     = 8
4044:                 .DeleteMark   = .F.
4045:                 .HeaderHeight = 14
4046:                 .ReadOnly     = .T.
4047:                 .RecordMark   = .F.
4048:                 .RowHeight    = 16
4049:                 .Visible      = .T.
4050:             ENDWITH
4051:             loc_oPg.grd_4c_GradeGrupo2.ColumnCount  = 3
4052:             loc_oPg.grd_4c_GradeGrupo2.RecordSource = "TotGrupo"
4053:             loc_oGrid2 = loc_oPg.grd_4c_GradeGrupo2
4054: 
4055:             loc_oGrid2.Column1.ControlSource   = "TotGrupo.Grupo"
4056:             loc_oGrid2.Column1.Width           = 35
4057:             loc_oGrid2.Column1.Movable         = .F.
4058:             loc_oGrid2.Column1.Resizable       = .F.
4059:             loc_oGrid2.Column1.ReadOnly        = .T.
4060:             loc_oGrid2.Column1.Header1.Caption = "Grp"
4061: 
4062:             loc_oGrid2.Column2.ControlSource   = "TotGrupo.ValGrupo"
4063:             loc_oGrid2.Column2.Width           = 120
4064:             loc_oGrid2.Column2.Movable         = .F.
4065:             loc_oGrid2.Column2.Resizable       = .F.
4066:             loc_oGrid2.Column2.ReadOnly        = .T.
4067:             loc_oGrid2.Column2.InputMask       = "999,999,999.999"
4068:             loc_oGrid2.Column2.Header1.Caption = "Total "
4069: 
4070:             loc_oGrid2.Column3.ControlSource   = "TotGrupo.Moeda"
4071:             loc_oGrid2.Column3.Width           = 37
4072:             loc_oGrid2.Column3.Movable         = .F.
4073:             loc_oGrid2.Column3.Resizable       = .F.
4074:             loc_oGrid2.Column3.ReadOnly        = .T.
4075:             loc_oGrid2.Column3.Header1.Caption = "Moe"
4076: 
4077:         CATCH TO loc_oErro
4078:             MostrarErro("Erro ao configurar p" + CHR(225) + "gina Custos:" + ;
4079:                 CHR(13) + loc_oErro.Message, "FormProduto.ConfigurarPgpgCusto")
4080:         ENDTRY
4081:     ENDPROC
4082: 
4083:     *===========================================================================
4084:     * ConfigurarPgpgComposicao - Configura Page6 "Composicao" do pgf_4c_Dados
4085:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao

*-- Linhas 4091 a 4238:
4091: 
4092:             *-- Cursors placeholder para os grids (ANTES de RecordSource)
4093:             IF !USED("cursor_4c_GrdCompo")
4094:                 CREATE CURSOR cursor_4c_GrdCompo ( ;
4095:                     cpros    C(14), dpros   C(65), cunis   C(5),  ;
4096:                     valor    N(14,3), qtdes N(10,3), total  N(14,3), ;
4097:                     moeda    C(3),  obs    C(80),  estoc   C(1),  ;
4098:                     consumo  N(10,0), qtdes2 N(10,3), cunis2 C(5),  ;
4099:                     ords     N(5,0), matprinc C(14))
4100:             ENDIF
4101:             IF !USED("cursor_4c_GrdSubCp")
4102:                 CREATE CURSOR cursor_4c_GrdSubCp ( ;
4103:                     cpros    C(14), dpros   C(65), cunis   C(5),  ;
4104:                     valor    N(14,3), qtdes N(10,3), total  N(14,3), ;
4105:                     moeda    C(3),  obs    C(80),  estoc   C(1),  ;
4106:                     consumo  N(10,0), qtdes2 N(10,3), cunis2 C(5),  ;
4107:                     ords     N(5,0), matprinc C(14), tamanho C(10))
4108:             ENDIF
4109:             IF !USED("cursor_4c_GrdRelogios")
4110:                 CREATE CURSOR cursor_4c_GrdRelogios ( ;
4111:                     grp C(5), descricao C(60), produto C(14), descprod C(60))
4112:             ENDIF
4113:             IF !USED("TotGrupo")
4114:                 CREATE CURSOR TotGrupo (Grupo C(10), ValGrupo N(14,3), Moeda C(3))
4115:             ENDIF
4116: 
4117:             *-- grdCompo: grade principal de composicao (14 colunas)
4118:             loc_oPg.AddObject("grd_4c_GrdCompo", "Grid")
4119:             WITH loc_oPg.grd_4c_GrdCompo
4120:                 .Top        = 117
4121:                 .Left       = 6
4122:                 .Width      = 943
4123:                 .Height     = 147
4124:                 .FontName   = "Tahoma"
4125:                 .FontSize   = 8
4126:                 .RecordMark = .F.
4127:                 .RowHeight  = 16
4128:                 .ScrollBars = 2
4129:                 .TabStop    = .F.
4130:                 .Visible    = .T.
4131:             ENDWITH
4132:             loc_oPg.grd_4c_GrdCompo.ColumnCount  = 14
4133:             loc_oPg.grd_4c_GrdCompo.RecordSource = "cursor_4c_GrdCompo"
4134:             loc_oGrid = loc_oPg.grd_4c_GrdCompo
4135: 
4136:             loc_oGrid.Column1.ControlSource  = "cursor_4c_GrdCompo.cpros"
4137:             loc_oGrid.Column1.Width          = 108
4138:             loc_oGrid.Column1.ColumnOrder    = 1
4139:             loc_oGrid.Column1.Movable        = .F.
4140:             loc_oGrid.Column1.Resizable      = .F.
4141:             loc_oGrid.Column1.Header1.Caption = "Material"
4142: 
4143:             loc_oGrid.Column2.ControlSource  = "cursor_4c_GrdCompo.dpros"
4144:             loc_oGrid.Column2.Width          = 187
4145:             loc_oGrid.Column2.ColumnOrder    = 2
4146:             loc_oGrid.Column2.Movable        = .F.
4147:             loc_oGrid.Column2.Resizable      = .F.
4148:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4149: 
4150:             loc_oGrid.Column3.ControlSource  = "cursor_4c_GrdCompo.cunis"
4151:             loc_oGrid.Column3.Width          = 24
4152:             loc_oGrid.Column3.ColumnOrder    = 4
4153:             loc_oGrid.Column3.Movable        = .F.
4154:             loc_oGrid.Column3.Resizable      = .F.
4155:             loc_oGrid.Column3.Header1.Caption = "Un"
4156: 
4157:             loc_oGrid.Column4.ControlSource  = "cursor_4c_GrdCompo.valor"
4158:             loc_oGrid.Column4.Width          = 73
4159:             loc_oGrid.Column4.ColumnOrder    = 7
4160:             loc_oGrid.Column4.Movable        = .F.
4161:             loc_oGrid.Column4.Resizable      = .F.
4162:             loc_oGrid.Column4.InputMask      = "9999999.999"
4163:             loc_oGrid.Column4.Header1.Caption = "Valor"
4164: 
4165:             loc_oGrid.Column5.ControlSource  = "cursor_4c_GrdCompo.qtdes"
4166:             loc_oGrid.Column5.Width          = 59
4167:             loc_oGrid.Column5.ColumnOrder    = 3
4168:             loc_oGrid.Column5.Movable        = .F.
4169:             loc_oGrid.Column5.Resizable      = .F.
4170:             loc_oGrid.Column5.InputMask      = "9999.999"
4171:             loc_oGrid.Column5.Header1.Caption = "Qtde."
4172: 
4173:             loc_oGrid.Column6.ControlSource  = "cursor_4c_GrdCompo.total"
4174:             loc_oGrid.Column6.Width          = 58
4175:             loc_oGrid.Column6.ColumnOrder    = 9
4176:             loc_oGrid.Column6.InputMask      = "9999999.999"
4177:             loc_oGrid.Column6.Header1.Caption = "Total"
4178: 
4179:             loc_oGrid.Column7.ControlSource  = "cursor_4c_GrdCompo.moeda"
4180:             loc_oGrid.Column7.Width          = 31
4181:             loc_oGrid.Column7.ColumnOrder    = 8
4182:             loc_oGrid.Column7.Header1.Caption = "Moe"
4183: 
4184:             loc_oGrid.Column8.ControlSource  = "cursor_4c_GrdCompo.obs"
4185:             loc_oGrid.Column8.Width          = 80
4186:             loc_oGrid.Column8.ColumnOrder    = 10
4187:             loc_oGrid.Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
4188: 
4189:             loc_oGrid.Column9.ControlSource  = "cursor_4c_GrdCompo.estoc"
4190:             loc_oGrid.Column9.Width          = 14
4191:             loc_oGrid.Column9.ColumnOrder    = 12
4192:             loc_oGrid.Column9.Format         = "M"
4193:             loc_oGrid.Column9.InputMask      = "N,S"
4194:             loc_oGrid.Column9.Header1.Caption = "E"
4195: 
4196:             loc_oGrid.Column10.ControlSource  = "cursor_4c_GrdCompo.consumo"
4197:             loc_oGrid.Column10.Width          = 58
4198:             loc_oGrid.Column10.ColumnOrder    = 13
4199:             loc_oGrid.Column10.InputMask      = "99999"
4200:             loc_oGrid.Column10.Header1.Caption = "Consumo"
4201: 
4202:             loc_oGrid.Column11.ControlSource  = "cursor_4c_GrdCompo.qtdes2"
4203:             loc_oGrid.Column11.Width          = 59
4204:             loc_oGrid.Column11.ColumnOrder    = 5
4205:             loc_oGrid.Column11.Movable        = .F.
4206:             loc_oGrid.Column11.Resizable      = .F.
4207:             loc_oGrid.Column11.Header1.Caption = "Qtde."
4208: 
4209:             loc_oGrid.Column12.ControlSource  = "cursor_4c_GrdCompo.cunis2"
4210:             loc_oGrid.Column12.Width          = 24
4211:             loc_oGrid.Column12.ColumnOrder    = 6
4212:             loc_oGrid.Column12.Movable        = .F.
4213:             loc_oGrid.Column12.ReadOnly       = .T.
4214:             loc_oGrid.Column12.Header1.Caption = "Un"
4215: 
4216:             loc_oGrid.Column13.ControlSource  = "cursor_4c_GrdCompo.ords"
4217:             loc_oGrid.Column13.Width          = 24
4218:             loc_oGrid.Column13.ColumnOrder    = 14
4219:             loc_oGrid.Column13.Format         = "K"
4220:             loc_oGrid.Column13.InputMask      = "99"
4221:             loc_oGrid.Column13.Header1.Caption = "Ord"
4222: 
4223:             loc_oGrid.Column14.ControlSource  = "cursor_4c_GrdCompo.matprinc"
4224:             loc_oGrid.Column14.Width          = 108
4225:             loc_oGrid.Column14.ColumnOrder    = 11
4226:             loc_oGrid.Column14.Header1.Caption = "Material"
4227: 
4228:             *-- cmg_4c_CmdgCompo: 5 botoes de controle da composicao
4229:             loc_oPg.AddObject("cmg_4c_CmdgCompo", "CommandGroup")
4230:             WITH loc_oPg.cmg_4c_CmdgCompo
4231:                 .Top         = 114
4232:                 .Left        = 947
4233:                 .Width       = 50
4234:                 .Height      = 210
4235:                 .BackStyle   = 0
4236:                 .BorderStyle = 0
4237:                 .Value       = 1
4238:                 .BackColor   = RGB(162, 214, 242)

*-- Linhas 4310 a 4421:
4310:             loc_oPg.grd_4c_GrdSubCp.RecordSource = "cursor_4c_GrdSubCp"
4311:             loc_oGrid2 = loc_oPg.grd_4c_GrdSubCp
4312: 
4313:             loc_oGrid2.Column1.ControlSource  = "cursor_4c_GrdSubCp.cpros"
4314:             loc_oGrid2.Column1.Width          = 108
4315:             loc_oGrid2.Column1.ColumnOrder    = 1
4316:             loc_oGrid2.Column1.Movable        = .F.
4317:             loc_oGrid2.Column1.Resizable      = .F.
4318:             loc_oGrid2.Column1.Header1.Caption = "Material"
4319: 
4320:             loc_oGrid2.Column2.ControlSource  = "cursor_4c_GrdSubCp.dpros"
4321:             loc_oGrid2.Column2.Width          = 149
4322:             loc_oGrid2.Column2.ColumnOrder    = 2
4323:             loc_oGrid2.Column2.Movable        = .F.
4324:             loc_oGrid2.Column2.Resizable      = .F.
4325:             loc_oGrid2.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4326: 
4327:             loc_oGrid2.Column3.ControlSource  = "cursor_4c_GrdSubCp.cunis"
4328:             loc_oGrid2.Column3.Width          = 24
4329:             loc_oGrid2.Column3.ColumnOrder    = 4
4330:             loc_oGrid2.Column3.Movable        = .F.
4331:             loc_oGrid2.Column3.Resizable      = .F.
4332:             loc_oGrid2.Column3.Header1.Caption = "Un"
4333: 
4334:             loc_oGrid2.Column4.ControlSource  = "cursor_4c_GrdSubCp.valor"
4335:             loc_oGrid2.Column4.Width          = 73
4336:             loc_oGrid2.Column4.ColumnOrder    = 7
4337:             loc_oGrid2.Column4.Movable        = .F.
4338:             loc_oGrid2.Column4.Resizable      = .F.
4339:             loc_oGrid2.Column4.InputMask      = "9999999.999"
4340:             loc_oGrid2.Column4.Header1.Caption = "Valor"
4341: 
4342:             loc_oGrid2.Column5.ControlSource  = "cursor_4c_GrdSubCp.qtdes"
4343:             loc_oGrid2.Column5.Width          = 59
4344:             loc_oGrid2.Column5.ColumnOrder    = 3
4345:             loc_oGrid2.Column5.Movable        = .F.
4346:             loc_oGrid2.Column5.Resizable      = .F.
4347:             loc_oGrid2.Column5.InputMask      = "9999.999"
4348:             loc_oGrid2.Column5.Header1.Caption = "Qtde."
4349: 
4350:             loc_oGrid2.Column6.ControlSource  = "cursor_4c_GrdSubCp.total"
4351:             loc_oGrid2.Column6.Width          = 58
4352:             loc_oGrid2.Column6.ColumnOrder    = 9
4353:             loc_oGrid2.Column6.InputMask      = "9999999.999"
4354:             loc_oGrid2.Column6.Header1.Caption = "Total"
4355: 
4356:             loc_oGrid2.Column7.ControlSource  = "cursor_4c_GrdSubCp.moeda"
4357:             loc_oGrid2.Column7.Width          = 31
4358:             loc_oGrid2.Column7.ColumnOrder    = 8
4359:             loc_oGrid2.Column7.Header1.Caption = "Moe"
4360: 
4361:             loc_oGrid2.Column8.ControlSource  = "cursor_4c_GrdSubCp.obs"
4362:             loc_oGrid2.Column8.Width          = 80
4363:             loc_oGrid2.Column8.ColumnOrder    = 10
4364:             loc_oGrid2.Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
4365: 
4366:             loc_oGrid2.Column9.ControlSource  = "cursor_4c_GrdSubCp.estoc"
4367:             loc_oGrid2.Column9.Width          = 14
4368:             loc_oGrid2.Column9.ColumnOrder    = 12
4369:             loc_oGrid2.Column9.Format         = "M"
4370:             loc_oGrid2.Column9.InputMask      = "N,S"
4371:             loc_oGrid2.Column9.Header1.Caption = "E"
4372: 
4373:             loc_oGrid2.Column10.ControlSource  = "cursor_4c_GrdSubCp.consumo"
4374:             loc_oGrid2.Column10.Width          = 58
4375:             loc_oGrid2.Column10.ColumnOrder    = 13
4376:             loc_oGrid2.Column10.InputMask      = "99999"
4377:             loc_oGrid2.Column10.Header1.Caption = "Consumo"
4378: 
4379:             loc_oGrid2.Column11.ControlSource  = "cursor_4c_GrdSubCp.qtdes2"
4380:             loc_oGrid2.Column11.Width          = 59
4381:             loc_oGrid2.Column11.ColumnOrder    = 5
4382:             loc_oGrid2.Column11.Movable        = .F.
4383:             loc_oGrid2.Column11.Resizable      = .F.
4384:             loc_oGrid2.Column11.Header1.Caption = "Qtde."
4385: 
4386:             loc_oGrid2.Column12.ControlSource  = "cursor_4c_GrdSubCp.cunis2"
4387:             loc_oGrid2.Column12.Width          = 24
4388:             loc_oGrid2.Column12.ColumnOrder    = 6
4389:             loc_oGrid2.Column12.Movable        = .F.
4390:             loc_oGrid2.Column12.ReadOnly       = .T.
4391:             loc_oGrid2.Column12.Header1.Caption = "Un"
4392: 
4393:             loc_oGrid2.Column13.ControlSource  = "cursor_4c_GrdSubCp.ords"
4394:             loc_oGrid2.Column13.Width          = 24
4395:             loc_oGrid2.Column13.ColumnOrder    = 14
4396:             loc_oGrid2.Column13.Format         = "K"
4397:             loc_oGrid2.Column13.InputMask      = "99"
4398:             loc_oGrid2.Column13.Header1.Caption = "Ord"
4399: 
4400:             loc_oGrid2.Column14.ControlSource  = "cursor_4c_GrdSubCp.matprinc"
4401:             loc_oGrid2.Column14.Width          = 108
4402:             loc_oGrid2.Column14.ColumnOrder    = 11
4403:             loc_oGrid2.Column14.Header1.Caption = "Material"
4404:             loc_oGrid2.Column14.Header1.BackColor = RGB(240, 240, 240)
4405: 
4406:             loc_oGrid2.Column15.ControlSource  = "cursor_4c_GrdSubCp.tamanho"
4407:             loc_oGrid2.Column15.Width          = 38
4408:             loc_oGrid2.Column15.Header1.Caption = "Tam"
4409:             loc_oGrid2.Column15.Header1.ToolTipText = "Tamanho"
4410: 
4411:             *-- cmg_4c_CmdgSubCp: 2 botoes de subcomposicao
4412:             loc_oPg.AddObject("cmg_4c_CmdgSubCp", "CommandGroup")
4413:             WITH loc_oPg.cmg_4c_CmdgSubCp
4414:                 .Top         = 314
4415:                 .Left        = 947
4416:                 .Width       = 50
4417:                 .Height      = 90
4418:                 .BackStyle   = 0
4419:                 .BorderStyle = 0
4420:                 .Value       = 1
4421:                 .BackColor   = RGB(162, 214, 242)

*-- Linhas 4465 a 4545:
4465:             loc_oPg.grd_4c_GrdRelogios.RecordSource = "cursor_4c_GrdRelogios"
4466:             loc_oGrid3 = loc_oPg.grd_4c_GrdRelogios
4467: 
4468:             loc_oGrid3.Column1.ControlSource  = "cursor_4c_GrdRelogios.grp"
4469:             loc_oGrid3.Column1.Width          = 31
4470:             loc_oGrid3.Column1.ColumnOrder    = 1
4471:             loc_oGrid3.Column1.Movable        = .F.
4472:             loc_oGrid3.Column1.Resizable      = .F.
4473:             loc_oGrid3.Column1.Header1.Caption = "Grp"
4474: 
4475:             loc_oGrid3.Column2.ControlSource  = "cursor_4c_GrdRelogios.descricao"
4476:             loc_oGrid3.Column2.Width          = 150
4477:             loc_oGrid3.Column2.Movable        = .F.
4478:             loc_oGrid3.Column2.Resizable      = .F.
4479:             loc_oGrid3.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4480: 
4481:             loc_oGrid3.Column3.ControlSource  = "cursor_4c_GrdRelogios.produto"
4482:             loc_oGrid3.Column3.Width          = 115
4483:             loc_oGrid3.Column3.ColumnOrder    = 3
4484:             loc_oGrid3.Column3.Movable        = .F.
4485:             loc_oGrid3.Column3.Resizable      = .F.
4486:             loc_oGrid3.Column3.Header1.Caption = "Produto"
4487: 
4488:             loc_oGrid3.Column4.ControlSource  = "cursor_4c_GrdRelogios.descprod"
4489:             loc_oGrid3.Column4.Width          = 290
4490:             loc_oGrid3.Column4.ColumnOrder    = 4
4491:             loc_oGrid3.Column4.Movable        = .F.
4492:             loc_oGrid3.Column4.Resizable      = .F.
4493:             loc_oGrid3.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4494: 
4495:             *-- GradeGRUPO: grade de totais por grupo
4496:             loc_oPg.AddObject("grd_4c_GradeGrupo", "Grid")
4497:             WITH loc_oPg.grd_4c_GradeGrupo
4498:                 .Top          = 41
4499:                 .Left         = 619
4500:                 .Width        = 215
4501:                 .Height       = 68
4502:                 .FontName     = "Verdana"
4503:                 .FontSize     = 8
4504:                 .DeleteMark   = .F.
4505:                 .HeaderHeight = 14
4506:                 .ReadOnly     = .T.
4507:                 .RecordMark   = .F.
4508:                 .RowHeight    = 16
4509:                 .Visible      = .T.
4510:             ENDWITH
4511:             loc_oPg.grd_4c_GradeGrupo.ColumnCount  = 3
4512:             loc_oPg.grd_4c_GradeGrupo.RecordSource = "TotGrupo"
4513:             loc_oGradeGrupo = loc_oPg.grd_4c_GradeGrupo
4514: 
4515:             loc_oGradeGrupo.Column1.ControlSource  = "TotGrupo.Grupo"
4516:             loc_oGradeGrupo.Column1.Width          = 35
4517:             loc_oGradeGrupo.Column1.Movable        = .F.
4518:             loc_oGradeGrupo.Column1.Resizable      = .F.
4519:             loc_oGradeGrupo.Column1.ReadOnly       = .T.
4520:             loc_oGradeGrupo.Column1.Header1.Caption = "Grupo"
4521: 
4522:             loc_oGradeGrupo.Column2.ControlSource  = "TotGrupo.ValGrupo"
4523:             loc_oGradeGrupo.Column2.Width          = 120
4524:             loc_oGradeGrupo.Column2.Movable        = .F.
4525:             loc_oGradeGrupo.Column2.Resizable      = .F.
4526:             loc_oGradeGrupo.Column2.ReadOnly       = .T.
4527:             loc_oGradeGrupo.Column2.InputMask      = "999,999,999.999"
4528:             loc_oGradeGrupo.Column2.Header1.Caption = "Total "
4529: 
4530:             loc_oGradeGrupo.Column3.ControlSource  = "TotGrupo.Moeda"
4531:             loc_oGradeGrupo.Column3.Width          = 37
4532:             loc_oGradeGrupo.Column3.Movable        = .F.
4533:             loc_oGradeGrupo.Column3.Resizable      = .F.
4534:             loc_oGradeGrupo.Column3.ReadOnly       = .T.
4535:             loc_oGradeGrupo.Column3.Header1.Caption = "Moeda"
4536: 
4537:             *-- BINDEVENT para grids
4538:             BINDEVENT(loc_oPg.grd_4c_GrdCompo, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
4539:             BINDEVENT(loc_oPg.grd_4c_GrdSubCp, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")
4540: 
4541:             *-- Say4: "Obs. da OF :"
4542:             loc_oPg.AddObject("lbl_4c_Label4", "Label")
4543:             WITH loc_oPg.lbl_4c_Label4
4544:                 .Caption   = "Obs. da OF :"
4545:                 .FontName  = "Tahoma"

*-- Linhas 5753 a 5882:
5753: 
5754:             *-- Cursors placeholder (ANTES de RecordSource - REGRA CRITICA VFP9)
5755:             IF !USED("cursor_4c_GrdConsP")
5756:                 CREATE CURSOR cursor_4c_GrdConsP ( ;
5757:                     mats      C(14), qtds     N(8,3),  unicompos C(3), ;
5758:                     grupos    C(10), dscgrp   C(20),   ordems    N(2,0), ;
5759:                     qtscons   N(8,3), cats    C(6),    dcats     C(15))
5760:             ENDIF
5761:             IF !USED("cursor_4c_GrDTEMP")
5762:                 CREATE CURSOR cursor_4c_GrDTEMP (grupos C(10), tempopct N(8,3))
5763:             ENDIF
5764: 
5765:             *-- grd_4c_GrdConsP: grade principal de consumo por processo (9 colunas)
5766:             *-- Original GrdCons: top=149, left=6, width=987, height=347, columnCount=9
5767:             loc_oPg.AddObject("grd_4c_GrdConsP", "Grid")
5768:             WITH loc_oPg.grd_4c_GrdConsP
5769:                 .Top        = 149
5770:                 .Left       = 6
5771:                 .Width      = 987
5772:                 .Height     = 347
5773:                 .FontName   = "Tahoma"
5774:                 .FontSize   = 8
5775:                 .RecordMark = .F.
5776:                 .DeleteMark = .F.
5777:                 .RowHeight  = 18
5778:                 .ScrollBars = 3
5779:                 .GridLines  = 3
5780:                 .GridLineColor      = RGB(238, 238, 238)
5781:                 .HighlightBackColor = RGB(255, 255, 255)
5782:                 .HighlightForeColor = RGB(15, 41, 104)
5783:                 .HighlightStyle     = 2
5784:                 .AllowHeaderSizing  = .F.
5785:                 .AllowRowSizing     = .F.
5786:                 .Visible    = .T.
5787:             ENDWITH
5788:             loc_oPg.grd_4c_GrdConsP.ColumnCount  = 9
5789:             loc_oPg.grd_4c_GrdConsP.RecordSource = "cursor_4c_GrdConsP"
5790:             loc_oGrid = loc_oPg.grd_4c_GrdConsP
5791: 
5792:             *-- Column1: Componente (mats C14) - somente leitura (When=.F. original)
5793:             loc_oGrid.Column1.ControlSource    = "cursor_4c_GrdConsP.mats"
5794:             loc_oGrid.Column1.Width            = 130
5795:             loc_oGrid.Column1.ReadOnly         = .T.
5796:             loc_oGrid.Column1.Movable          = .F.
5797:             loc_oGrid.Column1.Resizable        = .F.
5798:             loc_oGrid.Column1.Header1.Caption  = "Componente"
5799: 
5800:             *-- Column2: Qtde. (qtds N8.3) - somente leitura (When=.F. original)
5801:             loc_oGrid.Column2.ControlSource    = "cursor_4c_GrdConsP.qtds"
5802:             loc_oGrid.Column2.Width            = 65
5803:             loc_oGrid.Column2.ReadOnly         = .T.
5804:             loc_oGrid.Column2.Movable          = .F.
5805:             loc_oGrid.Column2.Resizable        = .F.
5806:             loc_oGrid.Column2.InputMask        = "9999.999"
5807:             loc_oGrid.Column2.Header1.Caption  = "Qtde."
5808: 
5809:             *-- Column3: Uni (unicompos C3) - somente leitura (When=.F. original)
5810:             loc_oGrid.Column3.ControlSource    = "cursor_4c_GrdConsP.unicompos"
5811:             loc_oGrid.Column3.Width            = 38
5812:             loc_oGrid.Column3.ReadOnly         = .T.
5813:             loc_oGrid.Column3.Movable          = .F.
5814:             loc_oGrid.Column3.Resizable        = .F.
5815:             loc_oGrid.Column3.Header1.Caption  = "Uni"
5816: 
5817:             *-- Column4: Fase (grupos C10) - editavel, lookup SigCdGcr
5818:             *-- Original When: Return(Inlist(ThisForm.pcEscolha,'INSERIR','ALTERAR'))
5819:             loc_oGrid.Column4.ControlSource    = "cursor_4c_GrdConsP.grupos"
5820:             loc_oGrid.Column4.Width            = 80
5821:             loc_oGrid.Column4.ReadOnly         = .F.
5822:             loc_oGrid.Column4.Movable          = .F.
5823:             loc_oGrid.Column4.Resizable        = .F.
5824:             loc_oGrid.Column4.Header1.Caption  = "Fase"
5825:             BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdConsPCol4FaseValid")
5826: 
5827:             *-- Column5: Descricao fase (dscgrp C20) - editavel, lookup SigCdGcr por descrs
5828:             *-- Original When: Return(Inlist(...) And Empty(Column4.Text1.Value))
5829:             loc_oGrid.Column5.ControlSource    = "cursor_4c_GrdConsP.dscgrp"
5830:             loc_oGrid.Column5.Width            = 180
5831:             loc_oGrid.Column5.ReadOnly         = .F.
5832:             loc_oGrid.Column5.Movable          = .F.
5833:             loc_oGrid.Column5.Resizable        = .F.
5834:             loc_oGrid.Column5.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
5835:             BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GrdConsPCol5DescFaseValid")
5836: 
5837:             *-- Column6: Ord. (ordems N2) - somente leitura (When=.F. original)
5838:             loc_oGrid.Column6.ControlSource    = "cursor_4c_GrdConsP.ordems"
5839:             loc_oGrid.Column6.Width            = 40
5840:             loc_oGrid.Column6.ReadOnly         = .T.
5841:             loc_oGrid.Column6.Movable          = .F.
5842:             loc_oGrid.Column6.Resizable        = .F.
5843:             loc_oGrid.Column6.InputMask        = "99"
5844:             loc_oGrid.Column6.Header1.Caption  = "Ord."
5845: 
5846:             *-- Column7: Consumo (qtscons N8.3) - editavel
5847:             *-- Original When: Return Inlist(ThisForm.pcEscolha,'INSERIR','ALTERAR')
5848:             loc_oGrid.Column7.ControlSource    = "cursor_4c_GrdConsP.qtscons"
5849:             loc_oGrid.Column7.Width            = 75
5850:             loc_oGrid.Column7.ReadOnly         = .F.
5851:             loc_oGrid.Column7.Movable          = .F.
5852:             loc_oGrid.Column7.Resizable        = .F.
5853:             loc_oGrid.Column7.InputMask        = "9999.999"
5854:             loc_oGrid.Column7.Header1.Caption  = "Consumo"
5855: 
5856:             *-- Column8: Cat. (cats C6) - editavel, lookup SigCdCat por Cods
5857:             *-- Original When: Return(InList(ThisForm.pcEscolha,"INSERIR","ALTERAR"))
5858:             loc_oGrid.Column8.ControlSource    = "cursor_4c_GrdConsP.cats"
5859:             loc_oGrid.Column8.Width            = 55
5860:             loc_oGrid.Column8.ReadOnly         = .F.
5861:             loc_oGrid.Column8.Movable          = .F.
5862:             loc_oGrid.Column8.Resizable        = .F.
5863:             loc_oGrid.Column8.Header1.Caption  = "Cat."
5864:             BINDEVENT(loc_oGrid.Column8.Text1, "Valid", THIS, "GrdConsPCol8CatValid")
5865: 
5866:             *-- Column9: Descricao Cat. (dcats C15) - somente leitura
5867:             loc_oGrid.Column9.ControlSource    = "cursor_4c_GrdConsP.dcats"
5868:             loc_oGrid.Column9.Width            = 185
5869:             loc_oGrid.Column9.ReadOnly         = .T.
5870:             loc_oGrid.Column9.Movable          = .F.
5871:             loc_oGrid.Column9.Resizable        = .F.
5872:             loc_oGrid.Column9.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
5873: 
5874:             BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdConsPAfterRowColChange")
5875: 
5876:             *-- lbl_4c_Label7: "Qtde Componentes :" (Say7: top=505, left=23, w=105)
5877:             loc_oPg.AddObject("lbl_4c_Label7", "Label")
5878:             WITH loc_oPg.lbl_4c_Label7
5879:                 .Caption   = "Qtde Componentes : "
5880:                 .Top       = 505
5881:                 .Left      = 23
5882:                 .Width     = 105

*-- Linhas 5952 a 5989:
5952:                 .FontName   = "Tahoma"
5953:                 .FontSize   = 8
5954:                 .RecordMark = .F.
5955:                 .DeleteMark = .F.
5956:                 .RowHeight  = 18
5957:                 .ScrollBars = 2
5958:                 .GridLines  = 3
5959:                 .AllowHeaderSizing = .F.
5960:                 .AllowRowSizing    = .F.
5961:                 .Visible    = .T.
5962:             ENDWITH
5963:             loc_oPg.grd_4c_GrDTEMP.ColumnCount  = 2
5964:             loc_oPg.grd_4c_GrDTEMP.RecordSource = "cursor_4c_GrDTEMP"
5965:             loc_oGrid2 = loc_oPg.grd_4c_GrDTEMP
5966: 
5967:             *-- Column1: Agrupamento (grupos C10) - somente leitura (When=.F. original)
5968:             loc_oGrid2.Column1.ControlSource    = "cursor_4c_GrDTEMP.grupos"
5969:             loc_oGrid2.Column1.Width            = 100
5970:             loc_oGrid2.Column1.ReadOnly         = .T.
5971:             loc_oGrid2.Column1.Header1.Caption  = "Agrupamento"
5972: 
5973:             *-- Column2: Tempo % (tempopct N8.3) - somente leitura (When=.F. original)
5974:             loc_oGrid2.Column2.ControlSource    = "cursor_4c_GrDTEMP.tempopct"
5975:             loc_oGrid2.Column2.Width            = 72
5976:             loc_oGrid2.Column2.ReadOnly         = .T.
5977:             loc_oGrid2.Column2.InputMask        = "9999.99"
5978:             loc_oGrid2.Column2.Header1.Caption  = "Tempo %"
5979: 
5980:         CATCH TO loc_oErro
5981:             MostrarErro("Erro ao configurar p" + CHR(225) + "gina Consumo por Processo:" + ;
5982:                 CHR(13) + loc_oErro.Message, "FormProduto.ConfigurarPgPgDadosConsP")
5983:         ENDTRY
5984:     ENDPROC
5985: 
5986:     *===========================================================================
5987:     * Handlers de BINDEVENT para pgDadosConsP (Page5)
5988:     * Todos PUBLIC - requerido pelo BINDEVENT
5989:     *===========================================================================

*-- Linhas 6020 a 6042:
6020:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6021:                 loc_cGrupos = ALLTRIM(cursor_4c_GrdConsP.grupos)
6022:                 IF !EMPTY(loc_cGrupos)
6023:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6024:                         "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupos), ;
6025:                         "cursor_4c_GcrFase")
6026:                     IF loc_nRet > 0 AND USED("cursor_4c_GcrFase") AND !EOF("cursor_4c_GcrFase")
6027:                         SELECT cursor_4c_GrdConsP
6028:                         REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(cursor_4c_GcrFase.descrs)
6029:                         IF USED("cursor_4c_GcrFase")
6030:                             USE IN cursor_4c_GcrFase
6031:                         ENDIF
6032:                     ELSE
6033:                         IF USED("cursor_4c_GcrFase")
6034:                             USE IN cursor_4c_GcrFase
6035:                         ENDIF
6036:                         THIS.AbrirBuscaFaseConsP()
6037:                     ENDIF
6038:                 ENDIF
6039:             ENDIF
6040:         CATCH TO loException
6041:             IF USED("cursor_4c_GcrFase")
6042:                 USE IN cursor_4c_GcrFase

*-- Linhas 6059 a 6081:
6059:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6060:                 loc_cDescrs = ALLTRIM(cursor_4c_GrdConsP.dscgrp)
6061:                 IF !EMPTY(loc_cDescrs)
6062:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6063:                         "SELECT codigos, descrs FROM SigCdGcr WHERE descrs = " + EscaparSQL(loc_cDescrs), ;
6064:                         "cursor_4c_GcrDescFase")
6065:                     IF loc_nRet > 0 AND USED("cursor_4c_GcrDescFase") AND !EOF("cursor_4c_GcrDescFase")
6066:                         SELECT cursor_4c_GrdConsP
6067:                         REPLACE cursor_4c_GrdConsP.grupos WITH ALLTRIM(cursor_4c_GcrDescFase.codigos)
6068:                         IF USED("cursor_4c_GcrDescFase")
6069:                             USE IN cursor_4c_GcrDescFase
6070:                         ENDIF
6071:                     ELSE
6072:                         IF USED("cursor_4c_GcrDescFase")
6073:                             USE IN cursor_4c_GcrDescFase
6074:                         ENDIF
6075:                         THIS.AbrirBuscaDescFaseConsP()
6076:                     ENDIF
6077:                 ENDIF
6078:             ENDIF
6079:         CATCH TO loException
6080:             IF USED("cursor_4c_GcrDescFase")
6081:                 USE IN cursor_4c_GcrDescFase

*-- Linhas 6098 a 6123:
6098:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6099:                 loc_cCats = ALLTRIM(cursor_4c_GrdConsP.cats)
6100:                 IF EMPTY(loc_cCats)
6101:                     SELECT cursor_4c_GrdConsP
6102:                     REPLACE cursor_4c_GrdConsP.dcats WITH ""
6103:                 ELSE
6104:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6105:                         "SELECT cods, descs FROM SigCdCat WHERE cods = " + EscaparSQL(loc_cCats), ;
6106:                         "cursor_4c_CatBusca")
6107:                     IF loc_nRet > 0 AND USED("cursor_4c_CatBusca") AND !EOF("cursor_4c_CatBusca")
6108:                         SELECT cursor_4c_GrdConsP
6109:                         REPLACE cursor_4c_GrdConsP.dcats WITH ALLTRIM(cursor_4c_CatBusca.descs)
6110:                         IF USED("cursor_4c_CatBusca")
6111:                             USE IN cursor_4c_CatBusca
6112:                         ENDIF
6113:                     ELSE
6114:                         IF USED("cursor_4c_CatBusca")
6115:                             USE IN cursor_4c_CatBusca
6116:                         ENDIF
6117:                         THIS.AbrirBuscaCatConsP()
6118:                     ENDIF
6119:                 ENDIF
6120:             ENDIF
6121:         CATCH TO loException
6122:             IF USED("cursor_4c_CatBusca")
6123:                 USE IN cursor_4c_CatBusca

*-- Linhas 6138 a 6173:
6138:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6139:                 *-- Atualizar dcats (Column9) se cats (Column8) foi preenchido
6140:                 IF !EMPTY(ALLTRIM(cursor_4c_GrdConsP.cats)) AND EMPTY(ALLTRIM(cursor_4c_GrdConsP.dcats))
6141:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6142:                         "SELECT descs FROM SigCdCat WHERE cods = " + EscaparSQL(ALLTRIM(cursor_4c_GrdConsP.cats)), ;
6143:                         "cursor_4c_GCatDesc")
6144:                     IF loc_nRet > 0 AND USED("cursor_4c_GCatDesc") AND !EOF("cursor_4c_GCatDesc")
6145:                         SELECT cursor_4c_GrdConsP
6146:                         REPLACE cursor_4c_GrdConsP.dcats WITH ALLTRIM(cursor_4c_GCatDesc.descs)
6147:                     ENDIF
6148:                     IF USED("cursor_4c_GCatDesc")
6149:                         USE IN cursor_4c_GCatDesc
6150:                     ENDIF
6151:                 ENDIF
6152:                 *-- Atualizar dscgrp (Column5) se grupos (Column4) foi preenchido e dscgrp vazio
6153:                 IF !EMPTY(ALLTRIM(cursor_4c_GrdConsP.grupos)) AND EMPTY(ALLTRIM(cursor_4c_GrdConsP.dscgrp))
6154:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6155:                         "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(ALLTRIM(cursor_4c_GrdConsP.grupos)), ;
6156:                         "cursor_4c_GFaseDesc")
6157:                     IF loc_nRet > 0 AND USED("cursor_4c_GFaseDesc") AND !EOF("cursor_4c_GFaseDesc")
6158:                         SELECT cursor_4c_GrdConsP
6159:                         REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(cursor_4c_GFaseDesc.descrs)
6160:                     ENDIF
6161:                     IF USED("cursor_4c_GFaseDesc")
6162:                         USE IN cursor_4c_GFaseDesc
6163:                     ENDIF
6164:                 ENDIF
6165:             ENDIF
6166:         CATCH TO loException
6167:             IF USED("cursor_4c_GCatDesc")
6168:                 USE IN cursor_4c_GCatDesc
6169:             ENDIF
6170:             IF USED("cursor_4c_GFaseDesc")
6171:                 USE IN cursor_4c_GFaseDesc
6172:             ENDIF
6173:             MostrarErro("Erro ao atualizar descri" + CHR(231) + CHR(245) + "es do grid ConsP:" + ;

*-- Linhas 6185 a 6222:
6185:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6186:                 loc_cValAtual = ALLTRIM(cursor_4c_GrdConsP.grupos)
6187: 
6188:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6189:                     "SELECT codigos, descrs FROM SigCdGcr WHERE codigos LIKE " + ;
6190:                     EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
6191:                     "cursor_4c_FaseBusca")
6192: 
6193:                 IF loc_nRet <= 0 OR !USED("cursor_4c_FaseBusca") OR EOF("cursor_4c_FaseBusca")
6194:                     IF USED("cursor_4c_FaseBusca")
6195:                         USE IN cursor_4c_FaseBusca
6196:                     ENDIF
6197:                     SQLEXEC(gnConnHandle, "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos", ;
6198:                         "cursor_4c_FaseBusca")
6199:                 ENDIF
6200: 
6201:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6202:                 IF VARTYPE(loc_oBusca) = "O"
6203:                     loc_oBusca.DefinirCursor("cursor_4c_FaseBusca", "codigos", "descrs", ;
6204:                         "Buscar Fase/Processo")
6205:                     loc_oBusca.Mostrar()
6206:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6207:                         SELECT cursor_4c_GrdConsP
6208:                         REPLACE cursor_4c_GrdConsP.grupos WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
6209:                         REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
6210:                     ENDIF
6211:                     loc_oBusca = .NULL.
6212:                 ENDIF
6213: 
6214:                 IF USED("cursor_4c_FaseBusca")
6215:                     USE IN cursor_4c_FaseBusca
6216:                 ENDIF
6217:             ENDIF
6218:         CATCH TO loException
6219:             IF USED("cursor_4c_FaseBusca")
6220:                 USE IN cursor_4c_FaseBusca
6221:             ENDIF
6222:             MostrarErro("Erro ao buscar Fase:" + CHR(13) + loException.Message, ;

*-- Linhas 6234 a 6271:
6234:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6235:                 loc_cValAtual = ALLTRIM(cursor_4c_GrdConsP.dscgrp)
6236: 
6237:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6238:                     "SELECT descrs, codigos FROM SigCdGcr WHERE descrs LIKE " + ;
6239:                     EscaparSQL(loc_cValAtual + "%") + " ORDER BY descrs", ;
6240:                     "cursor_4c_DescFaseBusca")
6241: 
6242:                 IF loc_nRet <= 0 OR !USED("cursor_4c_DescFaseBusca") OR EOF("cursor_4c_DescFaseBusca")
6243:                     IF USED("cursor_4c_DescFaseBusca")
6244:                         USE IN cursor_4c_DescFaseBusca
6245:                     ENDIF
6246:                     SQLEXEC(gnConnHandle, "SELECT descrs, codigos FROM SigCdGcr ORDER BY descrs", ;
6247:                         "cursor_4c_DescFaseBusca")
6248:                 ENDIF
6249: 
6250:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6251:                 IF VARTYPE(loc_oBusca) = "O"
6252:                     loc_oBusca.DefinirCursor("cursor_4c_DescFaseBusca", "descrs", "codigos", ;
6253:                         "Buscar Fase por Descri" + CHR(231) + CHR(227) + "o")
6254:                     loc_oBusca.Mostrar()
6255:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6256:                         SELECT cursor_4c_GrdConsP
6257:                         REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
6258:                         REPLACE cursor_4c_GrdConsP.grupos WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
6259:                     ENDIF
6260:                     loc_oBusca = .NULL.
6261:                 ENDIF
6262: 
6263:                 IF USED("cursor_4c_DescFaseBusca")
6264:                     USE IN cursor_4c_DescFaseBusca
6265:                 ENDIF
6266:             ENDIF
6267:         CATCH TO loException
6268:             IF USED("cursor_4c_DescFaseBusca")
6269:                 USE IN cursor_4c_DescFaseBusca
6270:             ENDIF
6271:             MostrarErro("Erro ao buscar Fase por descri" + CHR(231) + CHR(227) + "o:" + ;

*-- Linhas 6283 a 6319:
6283:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6284:                 loc_cValAtual = ALLTRIM(cursor_4c_GrdConsP.cats)
6285: 
6286:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6287:                     "SELECT cods, descs FROM SigCdCat WHERE cods LIKE " + ;
6288:                     EscaparSQL(loc_cValAtual + "%") + " ORDER BY cods", ;
6289:                     "cursor_4c_CatBusca")
6290: 
6291:                 IF loc_nRet <= 0 OR !USED("cursor_4c_CatBusca") OR EOF("cursor_4c_CatBusca")
6292:                     IF USED("cursor_4c_CatBusca")
6293:                         USE IN cursor_4c_CatBusca
6294:                     ENDIF
6295:                     SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdCat ORDER BY cods", ;
6296:                         "cursor_4c_CatBusca")
6297:                 ENDIF
6298: 
6299:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6300:                 IF VARTYPE(loc_oBusca) = "O"
6301:                     loc_oBusca.DefinirCursor("cursor_4c_CatBusca", "cods", "descs", "Buscar Categoria")
6302:                     loc_oBusca.Mostrar()
6303:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6304:                         SELECT cursor_4c_GrdConsP
6305:                         REPLACE cursor_4c_GrdConsP.cats  WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
6306:                         REPLACE cursor_4c_GrdConsP.dcats WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
6307:                     ENDIF
6308:                     loc_oBusca = .NULL.
6309:                 ENDIF
6310: 
6311:                 IF USED("cursor_4c_CatBusca")
6312:                     USE IN cursor_4c_CatBusca
6313:                 ENDIF
6314:             ENDIF
6315:         CATCH TO loException
6316:             IF USED("cursor_4c_CatBusca")
6317:                 USE IN cursor_4c_CatBusca
6318:             ENDIF
6319:             MostrarErro("Erro ao buscar Categoria:" + CHR(13) + loException.Message, ;

*-- Linhas 6334 a 6371:
6334:                 RETURN
6335:             ENDIF
6336:             IF !EMPTY(cursor_4c_GrdCompo.cpros)
6337:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6338:                     "SELECT dpros FROM SigCdPro WHERE cpros = '" + ;
6339:                     EscaparSQL(ALLTRIM(cursor_4c_GrdCompo.cpros)) + "", ;
6340:                     "cursor_4c_DescCusto")
6341:                 IF loc_nRet > 0 AND USED("cursor_4c_DescCusto") AND !EOF("cursor_4c_DescCusto")
6342:                     IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
6343:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_DescCusto.dpros)
6344:                     ENDIF
6345:                     USE IN cursor_4c_DescCusto
6346:                 ENDIF
6347:             ELSE
6348:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
6349:                     loc_oPg.txt_4c_Desc.Value = ""
6350:                 ENDIF
6351:             ENDIF
6352:             IF !EMPTY(cursor_4c_GrdCompo.cpros)
6353:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6354:                     "SELECT b.dgrus FROM SigCdPro a " + ;
6355:                     "INNER JOIN SigCdGrp b ON a.cgrus = b.cgrus " + ;
6356:                     "WHERE a.cpros = " + EscaparSQL(ALLTRIM(cursor_4c_GrdCompo.cpros)) + "", ;
6357:                     "cursor_4c_GruCusto")
6358:                 IF loc_nRet > 0 AND USED("cursor_4c_GruCusto") AND !EOF("cursor_4c_GruCusto")
6359:                     IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
6360:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_GruCusto.dgrus)
6361:                     ENDIF
6362:                     USE IN cursor_4c_GruCusto
6363:                 ENDIF
6364:             ELSE
6365:                 IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
6366:                     loc_oPg.txt_4c_DGruCompos.Value = ""
6367:                 ENDIF
6368:             ENDIF
6369:         CATCH TO loException
6370:             IF USED("cursor_4c_DescCusto")
6371:                 USE IN cursor_4c_DescCusto

*-- Linhas 6396 a 6449:
6396:             IF !USED("cursor_4c_GrdCompo")
6397:                 RETURN
6398:             ENDIF
6399:             SELECT cursor_4c_GrdCompo
6400:             APPEND BLANK
6401:         CATCH TO loException
6402:             MostrarErro("Erro ao inserir item de custo:" + CHR(13) + loException.Message, ;
6403:                 "FormProduto.CmdCustoInserirClick")
6404:         ENDTRY
6405:     ENDPROC
6406: 
6407:     PROCEDURE CmdCustoExcluirClick()
6408:         LOCAL loc_lConfirma, loException
6409:         TRY
6410:             IF !USED("cursor_4c_GrdCompo") OR EOF("cursor_4c_GrdCompo")
6411:                 RETURN
6412:             ENDIF
6413:             loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste item de custo?")
6414:             IF loc_lConfirma
6415:                 SELECT cursor_4c_GrdCompo
6416:                 DELETE
6417:                 IF !EOF()
6418:                     SKIP
6419:                     SKIP -1
6420:                 ENDIF
6421:             ENDIF
6422:         CATCH TO loException
6423:             MostrarErro("Erro ao excluir item de custo:" + CHR(13) + loException.Message, ;
6424:                 "FormProduto.CmdCustoExcluirClick")
6425:         ENDTRY
6426:     ENDPROC
6427: 
6428:     PROCEDURE CboTiposCustoInteractiveChange()
6429:         LOCAL loc_oPg, loc_cTipo, loException
6430:         TRY
6431:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
6432:             IF PEMSTATUS(loc_oPg, "cbo_4c_CmbTipos", 5) AND USED("cursor_4c_GrdCompo")
6433:                 loc_cTipo = ALLTRIM(NVL(loc_oPg.cbo_4c_CmbTipos.Value, ""))
6434:                 SELECT cursor_4c_GrdCompo
6435:                 IF EMPTY(loc_cTipo)
6436:                     SET FILTER TO
6437:                 ELSE
6438:                     SET FILTER TO ALLTRIM(cursor_4c_GrdCompo.cunis) = loc_cTipo
6439:                 ENDIF
6440:                 GO TOP
6441:                 IF PEMSTATUS(loc_oPg, "grd_4c_GrdCusto", 5)
6442:                     loc_oPg.grd_4c_GrdCusto.Refresh()
6443:                 ENDIF
6444:             ENDIF
6445:         CATCH TO loException
6446:             MostrarErro("Erro ao filtrar tipos de custo:" + CHR(13) + loException.Message, ;
6447:                 "FormProduto.CboTiposCustoInteractiveChange")
6448:         ENDTRY
6449:     ENDPROC

*-- Linhas 6458 a 6495:
6458:         TRY
6459:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6460:             IF USED("cursor_4c_GrdCompo") AND !EOF("cursor_4c_GrdCompo") AND !BOF("cursor_4c_GrdCompo")
6461:                 SELECT cursor_4c_GrdCompo
6462:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
6463:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_GrdCompo.dpros)
6464:                 ENDIF
6465:                 IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
6466:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_GrdCompo.matprinc)
6467:                 ENDIF
6468:             ENDIF
6469:         CATCH TO loException
6470:             MostrarErro("Erro ao navegar composicao:" + CHR(13) + loException.Message, ;
6471:                 "FormProduto.GrdCompoAfterRowColChange")
6472:         ENDTRY
6473:     ENDPROC
6474: 
6475:     PROCEDURE GrdSubCpAfterRowColChange(par_nColIndex)
6476:         LOCAL loc_oPg, loException
6477:         TRY
6478:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6479:             IF USED("cursor_4c_GrdSubCp") AND !EOF("cursor_4c_GrdSubCp") AND !BOF("cursor_4c_GrdSubCp")
6480:                 SELECT cursor_4c_GrdSubCp
6481:                 IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
6482:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_GrdSubCp.dpros)
6483:                 ENDIF
6484:                 IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
6485:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_GrdSubCp.matprinc)
6486:                 ENDIF
6487:             ENDIF
6488:         CATCH TO loException
6489:             MostrarErro("Erro ao navegar subcomposicao:" + CHR(13) + loException.Message, ;
6490:                 "FormProduto.GrdSubCpAfterRowColChange")
6491:         ENDTRY
6492:     ENDPROC
6493: 
6494:     PROCEDURE CmgCompoClick()
6495:         LOCAL loc_oPg, loc_nBotao

*-- Linhas 6682 a 6700:
6682:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6683:                 IF USED("cursor_4c_GrdCompo") AND !EOF("cursor_4c_GrdCompo") AND ;
6684:                         PEMSTATUS(loc_oPg, "txt_4c_ObsOFs", 5)
6685:                     SELECT cursor_4c_GrdCompo
6686:                     REPLACE cursor_4c_GrdCompo.obs WITH ;
6687:                         ALLTRIM(loc_oPg.txt_4c_ObsOFs.Value)
6688:                 ENDIF
6689:             CATCH TO loException
6690:                 MostrarErro("Erro ao salvar obs OFs:" + CHR(13) + loException.Message, ;
6691:                     "FormProduto.TxtObsOFsKeyPress")
6692:             ENDTRY
6693:         ENDIF
6694:     ENDPROC
6695: 
6696:     *-- Validacoes/lookups de moeda (SigCdMoe: cmoeds, dmoeds)
6697: 
6698:     PROCEDURE ValidarMoec(par_nKeyCode, par_nShiftAltCtrl)
6699:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6700:             RETURN

*-- Linhas 6932 a 6959:
6932:                 loc_cValAtual = ALLTRIM(loc_oPg.&par_cCampoDestino..Value)
6933:             ENDIF
6934: 
6935:             loc_nRet = SQLEXEC(gnConnHandle, ;
6936:                 "SELECT cmoeds, dmoeds FROM SigCdMoe WHERE cmoeds LIKE '" + ;
6937:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cmoeds", ;
6938:                 "cursor_4c_MoedaBusca")
6939: 
6940:             IF loc_nRet <= 0 OR !USED("cursor_4c_MoedaBusca") OR EOF("cursor_4c_MoedaBusca")
6941:                 IF USED("cursor_4c_MoedaBusca")
6942:                     USE IN cursor_4c_MoedaBusca
6943:                 ENDIF
6944:                 SQLEXEC(gnConnHandle, "SELECT cmoeds, dmoeds FROM SigCdMoe ORDER BY cmoeds", ;
6945:                     "cursor_4c_MoedaBusca")
6946:             ENDIF
6947: 
6948:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6949:             IF VARTYPE(loc_oBusca) = "O"
6950:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MoedaBusca"
6951:                 loc_oBusca.DefinirCursor("cursor_4c_MoedaBusca", "cmoeds", "dmoeds", "Buscar Moeda")
6952:                 loc_oBusca.Mostrar()
6953:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
6954:                     loc_oPg.&par_cCampoDestino..Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
6955:                 ENDIF
6956:                 loc_oBusca = .NULL.
6957:             ENDIF
6958: 
6959:             IF USED("cursor_4c_MoedaBusca")

*-- Linhas 6981 a 7008:
6981:                 loc_cValAtual = ALLTRIM(loc_oPg.&par_cCampoDestino..Value)
6982:             ENDIF
6983: 
6984:             loc_nRet = SQLEXEC(gnConnHandle, ;
6985:                 "SELECT cods, descs FROM SigPrFti WHERE cods LIKE '" + ;
6986:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", ;
6987:                 "cursor_4c_FeitioBusca")
6988: 
6989:             IF loc_nRet <= 0 OR !USED("cursor_4c_FeitioBusca") OR EOF("cursor_4c_FeitioBusca")
6990:                 IF USED("cursor_4c_FeitioBusca")
6991:                     USE IN cursor_4c_FeitioBusca
6992:                 ENDIF
6993:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigPrFti ORDER BY cods", ;
6994:                     "cursor_4c_FeitioBusca")
6995:             ENDIF
6996: 
6997:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6998:             IF VARTYPE(loc_oBusca) = "O"
6999:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FeitioBusca"
7000:                 loc_oBusca.DefinirCursor("cursor_4c_FeitioBusca", "cods", "descs", "Buscar Feitio/MKP")
7001:                 loc_oBusca.Mostrar()
7002:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
7003:                     loc_oPg.&par_cCampoDestino..Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
7004:                 ENDIF
7005:                 loc_oBusca = .NULL.
7006:             ENDIF
7007: 
7008:             IF USED("cursor_4c_FeitioBusca")

*-- Linhas 7030 a 7057:
7030:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Status.Value)
7031:             ENDIF
7032: 
7033:             loc_nRet = SQLEXEC(gnConnHandle, ;
7034:                 "SELECT cods, descs FROM SigCdPst WHERE cods LIKE '" + ;
7035:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", ;
7036:                 "cursor_4c_StatusBusca")
7037: 
7038:             IF loc_nRet <= 0 OR !USED("cursor_4c_StatusBusca") OR EOF("cursor_4c_StatusBusca")
7039:                 IF USED("cursor_4c_StatusBusca")
7040:                     USE IN cursor_4c_StatusBusca
7041:                 ENDIF
7042:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdPst ORDER BY cods", ;
7043:                     "cursor_4c_StatusBusca")
7044:             ENDIF
7045: 
7046:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
7047:             IF VARTYPE(loc_oBusca) = "O"
7048:                 loc_oBusca.this_cCursorDestino = "cursor_4c_StatusBusca"
7049:                 loc_oBusca.DefinirCursor("cursor_4c_StatusBusca", "cods", "descs", "Buscar Status")
7050:                 loc_oBusca.Mostrar()
7051:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, "txt_4c_Status", 5)
7052:                     loc_oPg.txt_4c_Status.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
7053:                 ENDIF
7054:                 loc_oBusca = .NULL.
7055:             ENDIF
7056: 
7057:             IF USED("cursor_4c_StatusBusca")

*-- Linhas 7080 a 7103:
7080: 
7081:             *-- Cursors placeholder (ANTES de RecordSource - REGRA CRITICA VFP9)
7082:             IF !USED("cursor_4c_GradFase")
7083:                 CREATE CURSOR cursor_4c_GradFase ( ;
7084:                     cidchaves C(20), ordems N(2,0), grupos C(10), ;
7085:                     minutos   N(9,1), uniprdts C(10), matprdts C(15), obs M)
7086:             ENDIF
7087:             IF !USED("cursor_4c_GrdMatrizes")
7088:                 CREATE CURSOR cursor_4c_GrdMatrizes ( ;
7089:                     cidchaves C(20), cmats C(14), qtds N(3,0), dpros C(65))
7090:             ENDIF
7091: 
7092:             *-- shp_4c_Fig: Shape moldura da figura do produto
7093:             *-- Original shpFig: top=129, left=231, width=244, height=148
7094:             loc_oPg.AddObject("shp_4c_Fig", "Shape")
7095:             WITH loc_oPg.shp_4c_Fig
7096:                 .Top           = 129
7097:                 .Left          = 231
7098:                 .Width         = 244
7099:                 .Height        = 148
7100:                 .BackStyle     = 0
7101:                 .BorderWidth   = 2
7102:                 .SpecialEffect = 0
7103:                 .Visible       = .T.

*-- Linhas 7183 a 7255:
7183:                 .FontName          = "Tahoma"
7184:                 .FontSize          = 8
7185:                 .RecordMark        = .F.
7186:                 .DeleteMark        = .F.
7187:                 .HeaderHeight      = 20
7188:                 .RowHeight         = 18
7189:                 .ScrollBars        = 2
7190:                 .GridLines         = 3
7191:                 .GridLineColor     = RGB(238, 238, 238)
7192:                 .HighlightBackColor = RGB(255, 255, 255)
7193:                 .HighlightForeColor = RGB(15, 41, 104)
7194:                 .HighlightStyle    = 2
7195:                 .AllowHeaderSizing = .F.
7196:                 .AllowRowSizing    = .F.
7197:                 .Visible           = .T.
7198:             ENDWITH
7199:             loc_oPg.grd_4c_GradFase.ColumnCount  = 5
7200:             loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
7201:             loc_oGrid = loc_oPg.grd_4c_GradFase
7202: 
7203:             *-- Column1: Ordem (ordems N2,0) - width=45
7204:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GradFase.ordems"
7205:             loc_oGrid.Column1.Width           = 45
7206:             loc_oGrid.Column1.ReadOnly        = .F.
7207:             loc_oGrid.Column1.Movable         = .F.
7208:             loc_oGrid.Column1.Resizable       = .F.
7209:             loc_oGrid.Column1.Header1.Caption = "Ordem"
7210:             BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "GrdFaseCol1OrdValid")
7211: 
7212:             *-- Column2: Fase/Grupo (grupos C10) - lookup SigCdGcr, width=80
7213:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GradFase.grupos"
7214:             loc_oGrid.Column2.Width           = 80
7215:             loc_oGrid.Column2.ReadOnly        = .F.
7216:             loc_oGrid.Column2.Movable         = .F.
7217:             loc_oGrid.Column2.Resizable       = .F.
7218:             loc_oGrid.Column2.Header1.Caption = "Fase"
7219:             BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "GrdFaseCol2FaseValid")
7220: 
7221:             *-- Column3: Utilizacao (minutos N9,1) - width=70
7222:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GradFase.minutos"
7223:             loc_oGrid.Column3.Width           = 70
7224:             loc_oGrid.Column3.ReadOnly        = .F.
7225:             loc_oGrid.Column3.Movable         = .F.
7226:             loc_oGrid.Column3.Resizable       = .F.
7227:             loc_oGrid.Column3.InputMask       = "99,999.9"
7228:             loc_oGrid.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
7229: 
7230:             *-- Column4: Uni. Produtiva (uniprdts C10) - lookup SigCdUpd, width=84
7231:             loc_oGrid.Column4.ControlSource   = "cursor_4c_GradFase.uniprdts"
7232:             loc_oGrid.Column4.Width           = 84
7233:             loc_oGrid.Column4.ReadOnly        = .F.
7234:             loc_oGrid.Column4.Movable         = .F.
7235:             loc_oGrid.Column4.Resizable       = .F.
7236:             loc_oGrid.Column4.Header1.Caption = "Uni. Produtiva"
7237:             BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdFaseCol4UniPrdtValid")
7238: 
7239:             *-- Column5: Material (matprdts C15) - lookup SigOpOpt, width=115
7240:             loc_oGrid.Column5.ControlSource   = "cursor_4c_GradFase.matprdts"
7241:             loc_oGrid.Column5.Width           = 115
7242:             loc_oGrid.Column5.ReadOnly        = .F.
7243:             loc_oGrid.Column5.Movable         = .F.
7244:             loc_oGrid.Column5.Resizable       = .F.
7245:             loc_oGrid.Column5.Header1.Caption = "Material"
7246:             BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GrdFaseCol5MatPrdtValid")
7247: 
7248:             BINDEVENT(loc_oGrid, "BeforeRowColChange", THIS, "GrdFaseBeforeRowColChange")
7249:             BINDEVENT(loc_oGrid, "AfterRowColChange",  THIS, "GrdFaseAfterRowColChange")
7250: 
7251:             *-- cmd_4c_InserirFase: Inserir fase na GradFase
7252:             *-- Original inserir: top=129, left=950, width=40, height=40
7253:             loc_oPg.AddObject("cmd_4c_InserirFase", "CommandButton")
7254:             WITH loc_oPg.cmd_4c_InserirFase
7255:                 .Top             = 129

*-- Linhas 7325 a 7343:
7325:             ENDWITH
7326: 
7327:             *-- txt_4c_QminFabs: Quantidade minima de fabricacao (getQmin)
7328:             *-- Original getQmin: top=129, left=137, width=80, height=23, ControlSource=crSigCdPro.qtminFabs
7329:             loc_oPg.AddObject("txt_4c_QminFabs", "TextBox")
7330:             WITH loc_oPg.txt_4c_QminFabs
7331:                 .Top           = 129
7332:                 .Left          = 137
7333:                 .Width         = 80
7334:                 .Height        = 23
7335:                 .FontName      = "Tahoma"
7336:                 .FontSize      = 8
7337:                 .InputMask     = "999,999.99"
7338:                 .MaxLength     = 10
7339:                 .SpecialEffect = 1
7340:                 .Value         = 0
7341:                 .Visible       = .T.
7342:             ENDWITH
7343: 

*-- Linhas 7358 a 7376:
7358:             ENDWITH
7359: 
7360:             *-- txt_4c_CodGarras: Codigo de garra (getCodGarras)
7361:             *-- Original getCodGarras: top=154, left=137, width=80, height=23, ControlSource=crSigCdPro.CodGarras
7362:             loc_oPg.AddObject("txt_4c_CodGarras", "TextBox")
7363:             WITH loc_oPg.txt_4c_CodGarras
7364:                 .Top           = 154
7365:                 .Left          = 137
7366:                 .Width         = 80
7367:                 .Height        = 23
7368:                 .FontName      = "Tahoma"
7369:                 .FontSize      = 8
7370:                 .MaxLength     = 10
7371:                 .SpecialEffect = 1
7372:                 .Value         = ""
7373:                 .Visible       = .T.
7374:             ENDWITH
7375: 
7376:             *-- lbl_4c_Say4: "Conquilha :"

*-- Linhas 7388 a 7406:
7388:             ENDWITH
7389: 
7390:             *-- txt_4c_Conquilhas: Conquilha (getConquilha)
7391:             *-- Original getConquilha: top=179, left=137, width=80, height=23, ControlSource=crSigCdPro.Conquilhas
7392:             loc_oPg.AddObject("txt_4c_Conquilhas", "TextBox")
7393:             WITH loc_oPg.txt_4c_Conquilhas
7394:                 .Top           = 179
7395:                 .Left          = 137
7396:                 .Width         = 80
7397:                 .Height        = 23
7398:                 .FontName      = "Tahoma"
7399:                 .FontSize      = 8
7400:                 .MaxLength     = 10
7401:                 .SpecialEffect = 1
7402:                 .Alignment     = 3
7403:                 .Value         = ""
7404:                 .Visible       = .T.
7405:             ENDWITH
7406:             BINDEVENT(loc_oPg.txt_4c_Conquilhas, "KeyPress", THIS, "ValidarConquilhaFaseP")

*-- Linhas 7422 a 7440:
7422:             ENDWITH
7423: 
7424:             *-- txt_4c_PesoBris: Peso Brilhante (getPesoBris)
7425:             *-- Original getPesoBris: top=204, left=137, width=80, height=23, ControlSource=crSigCdPro.PesoBris
7426:             loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
7427:             WITH loc_oPg.txt_4c_PesoBris
7428:                 .Top           = 204
7429:                 .Left          = 137
7430:                 .Width         = 80
7431:                 .Height        = 23
7432:                 .FontName      = "Tahoma"
7433:                 .FontSize      = 8
7434:                 .InputMask     = "99,999.999"
7435:                 .MaxLength     = 10
7436:                 .SpecialEffect = 1
7437:                 .Value         = 0
7438:                 .Visible       = .T.
7439:             ENDWITH
7440: 

*-- Linhas 7455 a 7473:
7455:             ENDWITH
7456: 
7457:             *-- txt_4c_PesoMetal: Peso Metal (getPesoMetal)
7458:             *-- Original getPesoMetal: top=229, left=137, width=80, height=23, ControlSource=crSigCdPro.PesoMetal
7459:             loc_oPg.AddObject("txt_4c_PesoMetal", "TextBox")
7460:             WITH loc_oPg.txt_4c_PesoMetal
7461:                 .Top           = 229
7462:                 .Left          = 137
7463:                 .Width         = 80
7464:                 .Height        = 23
7465:                 .FontName      = "Tahoma"
7466:                 .FontSize      = 8
7467:                 .InputMask     = "99,999.999"
7468:                 .MaxLength     = 10
7469:                 .SpecialEffect = 1
7470:                 .Value         = 0
7471:                 .Visible       = .T.
7472:             ENDWITH
7473: 

*-- Linhas 7488 a 7506:
7488:             ENDWITH
7489: 
7490:             *-- txt_4c_PesoPdrs: Peso de Pedras (getPesoPdrs)
7491:             *-- Original getPesoPdrs: top=254, left=137, width=80, height=23, ControlSource=crSigCdPro.PesoPdrs
7492:             loc_oPg.AddObject("txt_4c_PesoPdrs", "TextBox")
7493:             WITH loc_oPg.txt_4c_PesoPdrs
7494:                 .Top           = 254
7495:                 .Left          = 137
7496:                 .Width         = 80
7497:                 .Height        = 23
7498:                 .FontName      = "Tahoma"
7499:                 .FontSize      = 8
7500:                 .InputMask     = "99,999.999"
7501:                 .MaxLength     = 10
7502:                 .SpecialEffect = 1
7503:                 .Value         = 0
7504:                 .Visible       = .T.
7505:             ENDWITH
7506: 

*-- Linhas 7519 a 7554:
7519:             ENDWITH
7520: 
7521:             *-- txt_4c_CodCorsFP: Cor Padrao (getCor) - espelha Page1 CodCors
7522:             *-- Original getCor: top=279, left=137, width=38, ControlSource=crSigCdPro.CodCors
7523:             loc_oPg.AddObject("txt_4c_CodCorsFP", "TextBox")
7524:             WITH loc_oPg.txt_4c_CodCorsFP
7525:                 .Top           = 279
7526:                 .Left          = 137
7527:                 .Width         = 38
7528:                 .Height        = 23
7529:                 .FontName      = "Tahoma"
7530:                 .FontSize      = 8
7531:                 .MaxLength     = 4
7532:                 .SpecialEffect = 1
7533:                 .Value         = ""
7534:                 .Visible       = .T.
7535:             ENDWITH
7536:             BINDEVENT(loc_oPg.txt_4c_CodCorsFP, "KeyPress", THIS, "ValidarCorFaseP")
7537: 
7538:             *-- chk_4c_CravCera: Cravacao em Cera (opc_CravCera)
7539:             *-- Original opc_CravCera: top=283, left=180, ControlSource=crSigCdPro.CravCers
7540:             loc_oPg.AddObject("chk_4c_CravCera", "CheckBox")
7541:             WITH loc_oPg.chk_4c_CravCera
7542:                 .Caption       = "Crava" + CHR(231) + CHR(227) + "o em Cera"
7543:                 .Top           = 283
7544:                 .Left          = 180
7545:                 .FontName      = "Tahoma"
7546:                 .FontSize      = 8
7547:                 .BackStyle     = 0
7548:                 .AutoSize      = .T.
7549:                 .Alignment     = 0
7550:                 .Value         = 0
7551:                 .SpecialEffect = 1
7552:                 .ForeColor     = RGB(90, 90, 90)
7553:                 .Visible       = .T.
7554:             ENDWITH

*-- Linhas 7568 a 7603:
7568:             ENDWITH
7569: 
7570:             *-- txt_4c_CodTamsFP: Tamanho Padrao (getTam) - espelha Page1 CodTams
7571:             *-- Original getTam: top=304, left=137, width=38, ControlSource=crSigCdPro.CodTams
7572:             loc_oPg.AddObject("txt_4c_CodTamsFP", "TextBox")
7573:             WITH loc_oPg.txt_4c_CodTamsFP
7574:                 .Top           = 304
7575:                 .Left          = 137
7576:                 .Width         = 38
7577:                 .Height        = 23
7578:                 .FontName      = "Tahoma"
7579:                 .FontSize      = 8
7580:                 .MaxLength     = 4
7581:                 .SpecialEffect = 1
7582:                 .Value         = ""
7583:                 .Visible       = .T.
7584:             ENDWITH
7585:             BINDEVENT(loc_oPg.txt_4c_CodTamsFP, "KeyPress", THIS, "ValidarTamFaseP")
7586: 
7587:             *-- chk_4c_Varias: Peso Variavel (fwoption1)
7588:             *-- Original fwoption1: top=308, left=180, ControlSource=crSigCdPro.Varias
7589:             loc_oPg.AddObject("chk_4c_Varias", "CheckBox")
7590:             WITH loc_oPg.chk_4c_Varias
7591:                 .Caption       = "Peso Vari" + CHR(225) + "vel"
7592:                 .Top           = 308
7593:                 .Left          = 180
7594:                 .FontName      = "Tahoma"
7595:                 .FontSize      = 8
7596:                 .BackStyle     = 0
7597:                 .AutoSize      = .T.
7598:                 .Alignment     = 0
7599:                 .Value         = 0
7600:                 .SpecialEffect = 1
7601:                 .ForeColor     = RGB(90, 90, 90)
7602:                 .Visible       = .T.
7603:             ENDWITH

*-- Linhas 7620 a 7638:
7620:             ENDWITH
7621: 
7622:             *-- txt_4c_CodAcbsFP: Codigo de Acabamento (get_codacb)
7623:             *-- Original get_codacb: top=329, left=137, width=38, ControlSource=crSigCdPro.codAcbs
7624:             loc_oPg.AddObject("txt_4c_CodAcbsFP", "TextBox")
7625:             WITH loc_oPg.txt_4c_CodAcbsFP
7626:                 .Top           = 329
7627:                 .Left          = 137
7628:                 .Width         = 38
7629:                 .Height        = 23
7630:                 .FontName      = "Tahoma"
7631:                 .FontSize      = 8
7632:                 .MaxLength     = 3
7633:                 .SpecialEffect = 1
7634:                 .Value         = ""
7635:                 .Visible       = .T.
7636:             ENDWITH
7637:             BINDEVENT(loc_oPg.txt_4c_CodAcbsFP, "KeyPress", THIS, "ValidarAcabamentoFaseP")
7638: 

*-- Linhas 7669 a 7687:
7669:             ENDWITH
7670: 
7671:             *-- txt_4c_TEnts: Tempo de Entrega em Dias (getTEnts)
7672:             *-- Original getTEnts: top=355, left=137, width=31, height=23, ControlSource=crSigCdPro.tents
7673:             loc_oPg.AddObject("txt_4c_TEnts", "TextBox")
7674:             WITH loc_oPg.txt_4c_TEnts
7675:                 .Top           = 355
7676:                 .Left          = 137
7677:                 .Width         = 31
7678:                 .Height        = 23
7679:                 .FontName      = "Tahoma"
7680:                 .FontSize      = 8
7681:                 .InputMask     = "999"
7682:                 .MaxLength     = 10
7683:                 .SpecialEffect = 1
7684:                 .Value         = 0
7685:                 .Visible       = .T.
7686:             ENDWITH
7687: 

*-- Linhas 7718 a 7736:
7718:             ENDWITH
7719: 
7720:             *-- txt_4c_DiasGar: Dias de Garantia (getDiasGar)
7721:             *-- Original getDiasGar: top=380, left=137, width=31, height=23, ControlSource=crSigCdPro.DiasGar
7722:             loc_oPg.AddObject("txt_4c_DiasGar", "TextBox")
7723:             WITH loc_oPg.txt_4c_DiasGar
7724:                 .Top           = 380
7725:                 .Left          = 137
7726:                 .Width         = 31
7727:                 .Height        = 23
7728:                 .FontName      = "Tahoma"
7729:                 .FontSize      = 8
7730:                 .InputMask     = "999"
7731:                 .MaxLength     = 3
7732:                 .SpecialEffect = 1
7733:                 .Value         = 0
7734:                 .Visible       = .T.
7735:             ENDWITH
7736: 

*-- Linhas 7767 a 7785:
7767:             ENDWITH
7768: 
7769:             *-- txt_4c_Volumes: Numero de Volumes (fwget3)
7770:             *-- Original fwget3: top=405, left=137, width=31, height=23, ControlSource=crSigCdPro.volumes
7771:             loc_oPg.AddObject("txt_4c_Volumes", "TextBox")
7772:             WITH loc_oPg.txt_4c_Volumes
7773:                 .Top           = 405
7774:                 .Left          = 137
7775:                 .Width         = 31
7776:                 .Height        = 23
7777:                 .FontName      = "Tahoma"
7778:                 .FontSize      = 8
7779:                 .MaxLength     = 3
7780:                 .SpecialEffect = 1
7781:                 .Value         = 0
7782:                 .Visible       = .T.
7783:             ENDWITH
7784: 
7785:             *-- lbl_4c_Say21: "Lote Minimo :"

*-- Linhas 7799 a 7817:
7799:             ENDWITH
7800: 
7801:             *-- txt_4c_LtMinsV: Lote Minimo de Venda (getLtMinsV)
7802:             *-- Original getLtMinsV: top=430, left=137, width=80, height=23, ControlSource=crSigCdPro.ltminsv
7803:             loc_oPg.AddObject("txt_4c_LtMinsV", "TextBox")
7804:             WITH loc_oPg.txt_4c_LtMinsV
7805:                 .Top           = 430
7806:                 .Left          = 137
7807:                 .Width         = 80
7808:                 .Height        = 23
7809:                 .FontName      = "Tahoma"
7810:                 .FontSize      = 8
7811:                 .InputMask     = "999,999.99"
7812:                 .MaxLength     = 10
7813:                 .SpecialEffect = 1
7814:                 .Value         = 0
7815:                 .Visible       = .T.
7816:             ENDWITH
7817: 

*-- Linhas 7832 a 7892:
7832:             ENDWITH
7833: 
7834:             *-- txt_4c_DtUcp: Data da ultima compra (get_Dtucp) - somente leitura
7835:             *-- Original get_Dtucp: top=455, left=137, width=79, height=23, ControlSource=crSigCdPro.UltComps
7836:             loc_oPg.AddObject("txt_4c_DtUcp", "TextBox")
7837:             WITH loc_oPg.txt_4c_DtUcp
7838:                 .Top               = 455
7839:                 .Left              = 137
7840:                 .Width             = 79
7841:                 .Height            = 23
7842:                 .FontName          = "Tahoma"
7843:                 .FontSize          = 8
7844:                 .MaxLength         = 10
7845:                 .SpecialEffect     = 1
7846:                 .ReadOnly          = .T.
7847:                 .Value             = ""
7848:                 .BackColor         = RGB(240, 240, 240)
7849:                 .ForeColor         = RGB(0, 0, 0)
7850:                 .DisabledBackColor = RGB(224, 235, 235)
7851:                 .DisabledForeColor = RGB(36, 84, 155)
7852:                 .Visible           = .T.
7853:             ENDWITH
7854: 
7855:             *-- txt_4c_VUcp: Valor da ultima compra (Get_vucp) - somente leitura
7856:             *-- Original Get_vucp: top=455, left=217, width=97, height=23, ControlSource=crSigCdPro.vUltComps
7857:             loc_oPg.AddObject("txt_4c_VUcp", "TextBox")
7858:             WITH loc_oPg.txt_4c_VUcp
7859:                 .Top               = 455
7860:                 .Left              = 217
7861:                 .Width             = 97
7862:                 .Height            = 23
7863:                 .FontName          = "Tahoma"
7864:                 .FontSize          = 8
7865:                 .InputMask         = "99,999.99999"
7866:                 .SpecialEffect     = 1
7867:                 .ReadOnly          = .T.
7868:                 .Value             = 0
7869:                 .BackColor         = RGB(240, 240, 240)
7870:                 .ForeColor         = RGB(0, 0, 0)
7871:                 .DisabledBackColor = RGB(224, 235, 235)
7872:                 .DisabledForeColor = RGB(36, 84, 155)
7873:                 .Visible           = .T.
7874:             ENDWITH
7875: 
7876:             *-- txt_4c_MUcp: Moeda da ultima compra (Get_mucp) - somente leitura
7877:             *-- Original Get_mucp: top=455, left=315, width=31, height=23, ControlSource=crSigCdPro.MUltComps
7878:             loc_oPg.AddObject("txt_4c_MUcp", "TextBox")
7879:             WITH loc_oPg.txt_4c_MUcp
7880:                 .Top               = 455
7881:                 .Left              = 315
7882:                 .Width             = 31
7883:                 .Height            = 23
7884:                 .FontName          = "Tahoma"
7885:                 .FontSize          = 8
7886:                 .MaxLength         = 3
7887:                 .SpecialEffect     = 1
7888:                 .ReadOnly          = .T.
7889:                 .Value             = ""
7890:                 .BackColor         = RGB(240, 240, 240)
7891:                 .ForeColor         = RGB(0, 0, 0)
7892:                 .DisabledBackColor = RGB(224, 235, 235)

*-- Linhas 7911 a 7929:
7911:             ENDWITH
7912: 
7913:             *-- opt_4c_Prodvars: Variacao p/ e-commerce Sim/Nao (Fwoption2)
7914:             *-- Original Fwoption2: top=482, left=132, width=93, height=15, ControlSource=crSigCdPro.prodvars
7915:             loc_oPg.AddObject("opt_4c_Prodvars", "OptionGroup")
7916:             WITH loc_oPg.opt_4c_Prodvars
7917:                 .ButtonCount = 2
7918:                 .Value       = 1
7919:                 .Top         = 482
7920:                 .Left        = 132
7921:                 .Width       = 93
7922:                 .Height      = 15
7923:                 .BackStyle   = 0
7924:                 .BorderStyle = 0
7925:                 .Visible     = .T.
7926:                 .Option1.Caption   = "Sim"
7927:                 .Option1.FontName  = "Tahoma"
7928:                 .Option1.FontSize  = 8
7929:                 .Option1.BackStyle = 0

*-- Linhas 7966 a 8000:
7966:             ENDWITH
7967: 
7968:             *-- txt_4c_Desc: Descricao da fase selecionada (Get_Desc) - somente leitura
7969:             *-- Original Get_Desc: top=505, left=595, width=395, height=23, ControlSource=crSigCdGcr.descrs
7970:             loc_oPg.AddObject("txt_4c_Desc", "TextBox")
7971:             WITH loc_oPg.txt_4c_Desc
7972:                 .Top           = 505
7973:                 .Left          = 595
7974:                 .Width         = 395
7975:                 .Height        = 23
7976:                 .FontName      = "Tahoma"
7977:                 .FontSize      = 8
7978:                 .SpecialEffect = 1
7979:                 .ReadOnly      = .T.
7980:                 .Value         = ""
7981:                 .Visible       = .T.
7982:             ENDWITH
7983: 
7984:             *-- edt_4c_Obs: Observacoes da fase (Get_Obs - fwmemo)
7985:             *-- Original Get_Obs: top=531, left=527, width=463, height=92, ControlSource=crSigCdPrf.Obs
7986:             loc_oPg.AddObject("edt_4c_Obs", "EditBox")
7987:             WITH loc_oPg.edt_4c_Obs
7988:                 .Top           = 531
7989:                 .Left          = 527
7990:                 .Width         = 463
7991:                 .Height        = 92
7992:                 .FontName      = "Tahoma"
7993:                 .FontSize      = 8
7994:                 .SpecialEffect = 1
7995:                 .Value         = ""
7996:                 .Visible       = .T.
7997:             ENDWITH
7998: 
7999:             *--------------------------------------------------------------
8000:             *-- Area de Matrizes (grdMatrizes + shpBorracha + ImgBorracha)

*-- Linhas 8074 a 8128:
8074:                 .FontName          = "Tahoma"
8075:                 .FontSize          = 8
8076:                 .RecordMark        = .F.
8077:                 .DeleteMark        = .F.
8078:                 .HeaderHeight      = 20
8079:                 .RowHeight         = 18
8080:                 .ScrollBars        = 2
8081:                 .GridLines         = 3
8082:                 .GridLineColor     = RGB(238, 238, 238)
8083:                 .HighlightBackColor = RGB(255, 255, 255)
8084:                 .HighlightForeColor = RGB(15, 41, 104)
8085:                 .HighlightStyle    = 2
8086:                 .AllowHeaderSizing = .F.
8087:                 .AllowRowSizing    = .F.
8088:                 .Visible           = .T.
8089:             ENDWITH
8090:             loc_oPg.grd_4c_GrdMatrizes.ColumnCount  = 3
8091:             loc_oPg.grd_4c_GrdMatrizes.RecordSource = "cursor_4c_GrdMatrizes"
8092:             loc_oGrid2 = loc_oPg.grd_4c_GrdMatrizes
8093: 
8094:             *-- Column1: Matriz (cmats C14) - lookup, width=108
8095:             loc_oGrid2.Column1.ControlSource   = "cursor_4c_GrdMatrizes.cmats"
8096:             loc_oGrid2.Column1.Width           = 108
8097:             loc_oGrid2.Column1.ReadOnly        = .F.
8098:             loc_oGrid2.Column1.Movable         = .F.
8099:             loc_oGrid2.Column1.Resizable       = .F.
8100:             loc_oGrid2.Column1.Header1.Caption = "Matriz"
8101:             BINDEVENT(loc_oGrid2.Column1.Text1, "Valid", THIS, "GrdMatrizesCol1Valid")
8102: 
8103:             *-- Column2: Qtde (qtds N3,0) - width=34
8104:             loc_oGrid2.Column2.ControlSource   = "cursor_4c_GrdMatrizes.qtds"
8105:             loc_oGrid2.Column2.Width           = 34
8106:             loc_oGrid2.Column2.ReadOnly        = .F.
8107:             loc_oGrid2.Column2.Movable         = .F.
8108:             loc_oGrid2.Column2.Resizable       = .F.
8109:             loc_oGrid2.Column2.InputMask       = "9999"
8110:             loc_oGrid2.Column2.Header1.Caption = "Qtde"
8111: 
8112:             *-- Column3: Local (dpros C65) - somente leitura (descricao do produto matriz), width=80
8113:             loc_oGrid2.Column3.ControlSource   = "cursor_4c_GrdMatrizes.dpros"
8114:             loc_oGrid2.Column3.Width           = 80
8115:             loc_oGrid2.Column3.ReadOnly        = .T.
8116:             loc_oGrid2.Column3.Movable         = .F.
8117:             loc_oGrid2.Column3.Resizable       = .F.
8118:             loc_oGrid2.Column3.Header1.Caption = "Local"
8119: 
8120:             BINDEVENT(loc_oGrid2, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
8121: 
8122:         CATCH TO loc_oErro
8123:             MostrarErro("Erro ao configurar p" + CHR(225) + "gina Processos de Produ" + ;
8124:                 CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, ;
8125:                 "FormProduto.ConfigurarPgPgDadosFaseP")
8126:         ENDTRY
8127:     ENDPROC
8128: 

*-- Linhas 8143 a 8227:
8143:             IF USED("cursor_4c_GradFase")
8144:                 USE IN cursor_4c_GradFase
8145:             ENDIF
8146:             loc_nRet = SQLEXEC(gnConnHandle, ;
8147:                 "SELECT cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs" + ;
8148:                 " FROM SigCdPrf WHERE produtos = " + EscaparSQL(loc_cCpros) + ;
8149:                 "' ORDER BY ordems", "cursor_4c_GradFase")
8150:             IF loc_nRet <= 0
8151:                 CREATE CURSOR cursor_4c_GradFase ( ;
8152:                     cidchaves C(20), ordems N(2,0), grupos C(10), ;
8153:                     minutos   N(9,1), uniprdts C(10), matprdts C(15), obs M)
8154:             ENDIF
8155:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8156:                 loc_oPg.grd_4c_GradFase.ColumnCount = 5
8157:                 loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8158:                 loc_oPg.grd_4c_GradFase.Column1.ControlSource = "cursor_4c_GradFase.ordems"
8159:                 loc_oPg.grd_4c_GradFase.Column2.ControlSource = "cursor_4c_GradFase.grupos"
8160:                 loc_oPg.grd_4c_GradFase.Column3.ControlSource = "cursor_4c_GradFase.minutos"
8161:                 loc_oPg.grd_4c_GradFase.Column4.ControlSource = "cursor_4c_GradFase.uniprdts"
8162:                 loc_oPg.grd_4c_GradFase.Column5.ControlSource = "cursor_4c_GradFase.matprdts"
8163:                 loc_oPg.grd_4c_GradFase.Column1.Header1.Caption = "Ordem"
8164:                 loc_oPg.grd_4c_GradFase.Column2.Header1.Caption = "Fase"
8165:                 loc_oPg.grd_4c_GradFase.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
8166:                 loc_oPg.grd_4c_GradFase.Column4.Header1.Caption = "Uni. Produtiva"
8167:                 loc_oPg.grd_4c_GradFase.Column5.Header1.Caption = "Material"
8168:                 loc_oPg.grd_4c_GradFase.Refresh()
8169:             ENDIF
8170: 
8171:             *-- Carregar grdMatrizes de SigPrMtz + SigCdPro (descricao do produto matriz)
8172:             IF USED("cursor_4c_GrdMatrizes")
8173:                 USE IN cursor_4c_GrdMatrizes
8174:             ENDIF
8175:             loc_nRet = SQLEXEC(gnConnHandle, ;
8176:                 "SELECT m.cidchaves, m.cmats, m.qtds, ISNULL(p.dpros,'') AS dpros" + ;
8177:                 " FROM SigPrMtz m LEFT JOIN SigCdPro p ON p.cpros = m.cmats" + ;
8178:                 " WHERE m.cpros = " + EscaparSQL(loc_cCpros) + ;
8179:                 " ORDER BY m.cmats", "cursor_4c_GrdMatrizes")
8180:             IF loc_nRet <= 0
8181:                 CREATE CURSOR cursor_4c_GrdMatrizes ( ;
8182:                     cidchaves C(20), cmats C(14), qtds N(3,0), dpros C(65))
8183:             ENDIF
8184:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
8185:                 loc_oPg.grd_4c_GrdMatrizes.ColumnCount = 3
8186:                 loc_oPg.grd_4c_GrdMatrizes.RecordSource = "cursor_4c_GrdMatrizes"
8187:                 loc_oPg.grd_4c_GrdMatrizes.Column1.ControlSource = "cursor_4c_GrdMatrizes.cmats"
8188:                 loc_oPg.grd_4c_GrdMatrizes.Column2.ControlSource = "cursor_4c_GrdMatrizes.qtds"
8189:                 loc_oPg.grd_4c_GrdMatrizes.Column3.ControlSource = "cursor_4c_GrdMatrizes.dpros"
8190:                 loc_oPg.grd_4c_GrdMatrizes.Column1.Header1.Caption = "Matriz"
8191:                 loc_oPg.grd_4c_GrdMatrizes.Column2.Header1.Caption = "Qtde"
8192:                 loc_oPg.grd_4c_GrdMatrizes.Column3.Header1.Caption = "Local"
8193:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
8194:             ENDIF
8195: 
8196:         CATCH TO loException
8197:             MostrarErro("Erro ao carregar FaseP:" + CHR(13) + loException.Message + ;
8198:                 CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
8199:                 "FormProduto.CarregarFaseP")
8200:         ENDTRY
8201:     ENDPROC
8202: 
8203:     *===========================================================================
8204:     * GrdFaseBeforeRowColChange - Persiste obs do EditBox no cursor antes de mudar linha
8205:     * PUBLIC: BINDEVENT requer metodo publico
8206:     *===========================================================================
8207:     PROCEDURE GrdFaseBeforeRowColChange(par_nColIndex)
8208:         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
8209:             LOCAL loc_oPgBC
8210:             loc_oPgBC = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8211:             IF PEMSTATUS(loc_oPgBC, "edt_4c_Obs", 5)
8212:                 SELECT cursor_4c_GradFase
8213:                 REPLACE cursor_4c_GradFase.obs WITH loc_oPgBC.edt_4c_Obs.Value
8214:             ENDIF
8215:         ENDIF
8216:     ENDPROC
8217: 
8218:     *===========================================================================
8219:     * GrdFaseAfterRowColChange - Exibe imagem da fase e atualiza descricao
8220:     * PUBLIC: BINDEVENT requer metodo publico
8221:     *===========================================================================
8222:     PROCEDURE GrdFaseAfterRowColChange(par_nColIndex)
8223:         LOCAL loc_oPg, loc_lcArquivo, loc_nRet, loException
8224:         TRY
8225:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8226:             IF !PEMSTATUS(loc_oPg, "img_4c_ImgFig", 5) OR !USED("cursor_4c_GradFase")
8227:                 RETURN

*-- Linhas 8235 a 8283:
8235: 
8236:             IF !EOF("cursor_4c_GradFase") AND !BOF("cursor_4c_GradFase")
8237:                 LOCAL loc_cGrupos, loc_cCidchaves
8238:                 SELECT cursor_4c_GradFase
8239:                 loc_cGrupos    = ALLTRIM(cursor_4c_GradFase.grupos)
8240:                 loc_cCidchaves = ALLTRIM(cursor_4c_GradFase.cidchaves)
8241: 
8242:                 *-- Carregar descricao do grupo/fase (SigCdGcr)
8243:                 IF !EMPTY(loc_cGrupos)
8244:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8245:                         "SELECT descrs FROM SigCdGcr WHERE codigos = '" + ;
8246:                         EscaparSQL(loc_cGrupos) + "", "cursor_4c_FaseGcrDesc")
8247:                     IF loc_nRet > 0 AND USED("cursor_4c_FaseGcrDesc") AND !EOF("cursor_4c_FaseGcrDesc")
8248:                         SELECT cursor_4c_FaseGcrDesc
8249:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_FaseGcrDesc.descrs)
8250:                     ENDIF
8251:                     IF USED("cursor_4c_FaseGcrDesc")
8252:                         USE IN cursor_4c_FaseGcrDesc
8253:                     ENDIF
8254:                 ENDIF
8255: 
8256:                 *-- Obs vem do cursor (ja carregado em CarregarFaseP / gravado por BeforeRowColChange)
8257:                 SELECT cursor_4c_GradFase
8258:                 IF !ISNULL(cursor_4c_GradFase.obs)
8259:                     loc_oPg.edt_4c_Obs.Value = cursor_4c_GradFase.obs
8260:                 ENDIF
8261: 
8262:                 *-- Figura carregada do banco (campo figprocs - binario nao armazenado no cursor)
8263:                 IF !EMPTY(loc_cCidchaves)
8264:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8265:                         "SELECT figprocs FROM SigCdPrf WHERE cidchaves = '" + ;
8266:                         EscaparSQL(loc_cCidchaves) + "", "cursor_4c_FasePrfFig")
8267:                     IF loc_nRet > 0 AND USED("cursor_4c_FasePrfFig") AND !EOF("cursor_4c_FasePrfFig")
8268:                         SELECT cursor_4c_FasePrfFig
8269:                         IF !ISNULL(cursor_4c_FasePrfFig.figprocs) AND ;
8270:                                 !EMPTY(cursor_4c_FasePrfFig.figprocs)
8271:                             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
8272:                             IF STRTOFILE(cursor_4c_FasePrfFig.figprocs, loc_lcArquivo) > 0
8273:                                 loc_oPg.img_4c_ImgFig.Visible = .T.
8274:                                 loc_oPg.img_4c_ImgFig.Picture = loc_lcArquivo
8275:                             ENDIF
8276:                         ENDIF
8277:                     ENDIF
8278:                     IF USED("cursor_4c_FasePrfFig")
8279:                         USE IN cursor_4c_FasePrfFig
8280:                     ENDIF
8281:                 ENDIF
8282:             ENDIF
8283: 

*-- Linhas 8293 a 8368:
8293:     *===========================================================================
8294:     PROCEDURE GrdFaseCol1OrdValid()
8295:         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
8296:             SELECT cursor_4c_GradFase
8297:             IF cursor_4c_GradFase.ordems <= 0
8298:                 MsgAviso("Ordem deve ser maior que zero.", "Fase")
8299:                 RETURN .F.
8300:             ENDIF
8301:         ENDIF
8302:         RETURN .T.
8303:     ENDPROC
8304: 
8305:     *===========================================================================
8306:     * GrdFaseCol2FaseValid - Lookup de fase/grupo (SigCdGcr) na GradFase
8307:     * PUBLIC: BINDEVENT requer metodo publico
8308:     *===========================================================================
8309:     PROCEDURE GrdFaseCol2FaseValid()
8310:         LOCAL loc_cValAtual, loc_nRet, loc_oBusca, loException
8311:         TRY
8312:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8313:                 loc_lResultado = .T.
8314:             ENDIF
8315:             SELECT cursor_4c_GradFase
8316:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.grupos)
8317:             IF EMPTY(loc_cValAtual)
8318:                 loc_lResultado = .T.
8319:             ENDIF
8320: 
8321:             loc_nRet = SQLEXEC(gnConnHandle, ;
8322:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = '" + ;
8323:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_FaseGcrBusca")
8324:             IF loc_nRet > 0 AND USED("cursor_4c_FaseGcrBusca") AND !EOF("cursor_4c_FaseGcrBusca")
8325:                 IF USED("cursor_4c_FaseGcrBusca")
8326:                     USE IN cursor_4c_FaseGcrBusca
8327:                 ENDIF
8328:                 loc_lResultado = .T.
8329:             ENDIF
8330:             IF USED("cursor_4c_FaseGcrBusca")
8331:                 USE IN cursor_4c_FaseGcrBusca
8332:             ENDIF
8333: 
8334:             *-- Codigo nao encontrado: abrir busca
8335:             loc_nRet = SQLEXEC(gnConnHandle, ;
8336:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos LIKE '" + ;
8337:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY codigos", "cursor_4c_FaseGcrBusca")
8338:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseGcrBusca") OR EOF("cursor_4c_FaseGcrBusca")
8339:                 IF USED("cursor_4c_FaseGcrBusca")
8340:                     USE IN cursor_4c_FaseGcrBusca
8341:                 ENDIF
8342:                 SQLEXEC(gnConnHandle, ;
8343:                     "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos", ;
8344:                     "cursor_4c_FaseGcrBusca")
8345:             ENDIF
8346: 
8347:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8348:             IF VARTYPE(loc_oBusca) = "O"
8349:                 loc_oBusca.DefinirCursor("cursor_4c_FaseGcrBusca", "codigos", "descrs", ;
8350:                     "Selecionar Fase/Grupo")
8351:                 loc_oBusca.Mostrar()
8352:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8353:                     SELECT cursor_4c_GradFase
8354:                     REPLACE cursor_4c_GradFase.grupos WITH loc_oBusca.cCodigoSelecionado
8355:                 ENDIF
8356:                 loc_oBusca = .NULL.
8357:             ENDIF
8358: 
8359:             IF USED("cursor_4c_FaseGcrBusca")
8360:                 USE IN cursor_4c_FaseGcrBusca
8361:             ENDIF
8362: 
8363:         CATCH TO loException
8364:             IF USED("cursor_4c_FaseGcrBusca")
8365:                 USE IN cursor_4c_FaseGcrBusca
8366:             ENDIF
8367:             MostrarErro("Erro ao validar fase:" + CHR(13) + loException.Message, ;
8368:                 "FormProduto.GrdFaseCol2FaseValid")

*-- Linhas 8380 a 8438:
8380:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8381:                 loc_lResultado = .T.
8382:             ENDIF
8383:             SELECT cursor_4c_GradFase
8384:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.uniprdts)
8385:             loc_cGrupos   = ALLTRIM(cursor_4c_GradFase.grupos)
8386:             IF EMPTY(loc_cValAtual)
8387:                 loc_lResultado = .T.
8388:             ENDIF
8389: 
8390:             loc_nRet = SQLEXEC(gnConnHandle, ;
8391:                 "SELECT uniprdts FROM SigCdUpd WHERE codigos = '" + ;
8392:                 EscaparSQL(loc_cGrupos) + " AND uniprdts = '" + ;
8393:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_FaseUpdBusca")
8394:             IF loc_nRet > 0 AND USED("cursor_4c_FaseUpdBusca") AND !EOF("cursor_4c_FaseUpdBusca")
8395:                 IF USED("cursor_4c_FaseUpdBusca")
8396:                     USE IN cursor_4c_FaseUpdBusca
8397:                 ENDIF
8398:                 loc_lResultado = .T.
8399:             ENDIF
8400:             IF USED("cursor_4c_FaseUpdBusca")
8401:                 USE IN cursor_4c_FaseUpdBusca
8402:             ENDIF
8403: 
8404:             *-- Abrir busca das unidades produtivas para este grupo
8405:             loc_nRet = SQLEXEC(gnConnHandle, ;
8406:                 "SELECT uniprdts FROM SigCdUpd WHERE codigos = '" + ;
8407:                 EscaparSQL(loc_cGrupos) + " ORDER BY uniprdts", "cursor_4c_FaseUpdBusca")
8408:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseUpdBusca") OR EOF("cursor_4c_FaseUpdBusca")
8409:                 IF USED("cursor_4c_FaseUpdBusca")
8410:                     USE IN cursor_4c_FaseUpdBusca
8411:                 ENDIF
8412:                 SQLEXEC(gnConnHandle, ;
8413:                     "SELECT DISTINCT uniprdts FROM SigCdUpd ORDER BY uniprdts", ;
8414:                     "cursor_4c_FaseUpdBusca")
8415:             ENDIF
8416: 
8417:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8418:             IF VARTYPE(loc_oBusca) = "O"
8419:                 loc_oBusca.DefinirCursor("cursor_4c_FaseUpdBusca", "uniprdts", "uniprdts", ;
8420:                     "Selecionar Uni. Produtiva")
8421:                 loc_oBusca.Mostrar()
8422:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8423:                     SELECT cursor_4c_GradFase
8424:                     REPLACE cursor_4c_GradFase.uniprdts WITH loc_oBusca.cCodigoSelecionado
8425:                 ENDIF
8426:                 loc_oBusca = .NULL.
8427:             ENDIF
8428: 
8429:             IF USED("cursor_4c_FaseUpdBusca")
8430:                 USE IN cursor_4c_FaseUpdBusca
8431:             ENDIF
8432: 
8433:         CATCH TO loException
8434:             IF USED("cursor_4c_FaseUpdBusca")
8435:                 USE IN cursor_4c_FaseUpdBusca
8436:             ENDIF
8437:             MostrarErro("Erro ao validar uni. produtiva:" + CHR(13) + loException.Message, ;
8438:                 "FormProduto.GrdFaseCol4UniPrdtValid")

*-- Linhas 8450 a 8508:
8450:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8451:                 loc_lResultado = .T.
8452:             ENDIF
8453:             SELECT cursor_4c_GradFase
8454:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.matprdts)
8455:             loc_cGrupos   = ALLTRIM(cursor_4c_GradFase.grupos)
8456:             IF EMPTY(loc_cValAtual)
8457:                 loc_lResultado = .T.
8458:             ENDIF
8459: 
8460:             loc_nRet = SQLEXEC(gnConnHandle, ;
8461:                 "SELECT cods, descs FROM SigOpOpt WHERE cods = '" + ;
8462:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_FaseOptBusca")
8463:             IF loc_nRet > 0 AND USED("cursor_4c_FaseOptBusca") AND !EOF("cursor_4c_FaseOptBusca")
8464:                 IF USED("cursor_4c_FaseOptBusca")
8465:                     USE IN cursor_4c_FaseOptBusca
8466:                 ENDIF
8467:                 loc_lResultado = .T.
8468:             ENDIF
8469:             IF USED("cursor_4c_FaseOptBusca")
8470:                 USE IN cursor_4c_FaseOptBusca
8471:             ENDIF
8472: 
8473:             *-- Abrir busca filtrando pelo grupo da fase
8474:             loc_nRet = SQLEXEC(gnConnHandle, ;
8475:                 "SELECT cods, descs FROM SigOpOpt WHERE grupos = '" + ;
8476:                 EscaparSQL(loc_cGrupos) + " AND cods LIKE '" + ;
8477:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_FaseOptBusca")
8478:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseOptBusca") OR EOF("cursor_4c_FaseOptBusca")
8479:                 IF USED("cursor_4c_FaseOptBusca")
8480:                     USE IN cursor_4c_FaseOptBusca
8481:                 ENDIF
8482:                 SQLEXEC(gnConnHandle, ;
8483:                     "SELECT cods, descs FROM SigOpOpt ORDER BY cods", ;
8484:                     "cursor_4c_FaseOptBusca")
8485:             ENDIF
8486: 
8487:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8488:             IF VARTYPE(loc_oBusca) = "O"
8489:                 loc_oBusca.DefinirCursor("cursor_4c_FaseOptBusca", "cods", "descs", ;
8490:                     "Selecionar Material")
8491:                 loc_oBusca.Mostrar()
8492:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8493:                     SELECT cursor_4c_GradFase
8494:                     REPLACE cursor_4c_GradFase.matprdts WITH loc_oBusca.cCodigoSelecionado
8495:                 ENDIF
8496:                 loc_oBusca = .NULL.
8497:             ENDIF
8498: 
8499:             IF USED("cursor_4c_FaseOptBusca")
8500:                 USE IN cursor_4c_FaseOptBusca
8501:             ENDIF
8502: 
8503:         CATCH TO loException
8504:             IF USED("cursor_4c_FaseOptBusca")
8505:                 USE IN cursor_4c_FaseOptBusca
8506:             ENDIF
8507:             MostrarErro("Erro ao validar material:" + CHR(13) + loException.Message, ;
8508:                 "FormProduto.GrdFaseCol5MatPrdtValid")

*-- Linhas 8525 a 8552:
8525:                 RETURN
8526:             ENDIF
8527: 
8528:             SELECT cursor_4c_GradFase
8529:             IF EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase") OR ;
8530:                     RECCOUNT("cursor_4c_GradFase") = 0
8531:                 loc_nProxOrdem = 1
8532:             ELSE
8533:                 GO BOTTOM IN cursor_4c_GradFase
8534:                 loc_nProxOrdem = cursor_4c_GradFase.ordems + 1
8535:             ENDIF
8536: 
8537:             INSERT INTO cursor_4c_GradFase (cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs) ;
8538:                 VALUES (SYS(2015), loc_nProxOrdem, "", 0, "", "", "")
8539: 
8540:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8541:                 loc_oPg.grd_4c_GradFase.Refresh()
8542:                 GO BOTTOM IN cursor_4c_GradFase
8543:                 loc_oPg.grd_4c_GradFase.Column2.SetFocus()
8544:             ENDIF
8545: 
8546:         CATCH TO loException
8547:             MostrarErro("Erro ao inserir fase:" + CHR(13) + loException.Message, ;
8548:                 "FormProduto.BtnInserirFaseClick")
8549:         ENDTRY
8550:     ENDPROC
8551: 
8552:     *===========================================================================

*-- Linhas 8563 a 8585:
8563:                 RETURN
8564:             ENDIF
8565: 
8566:             SELECT cursor_4c_GradFase
8567:             IF !MsgConfirma("Excluir esta fase de produ" + CHR(231) + CHR(227) + "o?")
8568:                 RETURN
8569:             ENDIF
8570:             DELETE IN cursor_4c_GradFase
8571:             IF !EOF("cursor_4c_GradFase")
8572:                 SKIP IN cursor_4c_GradFase
8573:             ENDIF
8574:             IF EOF("cursor_4c_GradFase") AND RECCOUNT("cursor_4c_GradFase") > 0
8575:                 GO BOTTOM IN cursor_4c_GradFase
8576:             ENDIF
8577: 
8578:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8579:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8580:                 loc_oPg.grd_4c_GradFase.Refresh()
8581:             ENDIF
8582: 
8583:         CATCH TO loException
8584:             MostrarErro("Erro ao excluir fase:" + CHR(13) + loException.Message, ;
8585:                 "FormProduto.BtnExcluirFaseClick")

*-- Linhas 8601 a 8627:
8601:                 RETURN
8602:             ENDIF
8603: 
8604:             SELECT cursor_4c_GradFase
8605:             IF EOF("cursor_4c_GradFase") OR RECCOUNT("cursor_4c_GradFase") = 0
8606:                 loc_nOrdemAtual = 0
8607:             ELSE
8608:                 loc_nOrdemAtual = cursor_4c_GradFase.ordems
8609:             ENDIF
8610:             loc_nProxOrdem = loc_nOrdemAtual + 1
8611: 
8612:             INSERT INTO cursor_4c_GradFase (cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs) ;
8613:                 VALUES (SYS(2015), loc_nProxOrdem, "", 0, "", "", "")
8614: 
8615:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8616:                 loc_oPg.grd_4c_GradFase.Refresh()
8617:                 GO BOTTOM IN cursor_4c_GradFase
8618:                 loc_oPg.grd_4c_GradFase.Column2.SetFocus()
8619:             ENDIF
8620: 
8621:         CATCH TO loException
8622:             MostrarErro("Erro ao inserir fase alternativa:" + CHR(13) + loException.Message, ;
8623:                 "FormProduto.BtnAlternativaFaseClick")
8624:         ENDTRY
8625:     ENDPROC
8626: 
8627:     *===========================================================================

*-- Linhas 8734 a 8773:
8734:                 loc_lResultado = .T.
8735:             ENDIF
8736: 
8737:             loc_nRet = SQLEXEC(gnConnHandle, ;
8738:                 "SELECT conquilhas FROM sigcdcnq WHERE conquilhas = '" + ;
8739:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_CnqBusca")
8740:             IF loc_nRet > 0 AND USED("cursor_4c_CnqBusca") AND !EOF("cursor_4c_CnqBusca")
8741:                 IF USED("cursor_4c_CnqBusca")
8742:                     USE IN cursor_4c_CnqBusca
8743:                 ENDIF
8744:                 loc_lResultado = .T.
8745:             ENDIF
8746:             IF USED("cursor_4c_CnqBusca")
8747:                 USE IN cursor_4c_CnqBusca
8748:             ENDIF
8749: 
8750:             loc_nRet = SQLEXEC(gnConnHandle, ;
8751:                 "SELECT DISTINCT conquilhas FROM sigcdcnq WHERE conquilhas LIKE '" + ;
8752:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY conquilhas", "cursor_4c_CnqBusca")
8753:             IF loc_nRet <= 0 OR !USED("cursor_4c_CnqBusca") OR EOF("cursor_4c_CnqBusca")
8754:                 IF USED("cursor_4c_CnqBusca")
8755:                     USE IN cursor_4c_CnqBusca
8756:                 ENDIF
8757:                 SQLEXEC(gnConnHandle, ;
8758:                     "SELECT DISTINCT conquilhas FROM sigcdcnq ORDER BY conquilhas", ;
8759:                     "cursor_4c_CnqBusca")
8760:             ENDIF
8761: 
8762:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8763:             IF VARTYPE(loc_oBusca) = "O"
8764:                 loc_oBusca.DefinirCursor("cursor_4c_CnqBusca", "conquilhas", "conquilhas", ;
8765:                     "Selecionar Conquilha")
8766:                 loc_oBusca.Mostrar()
8767:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8768:                     loc_oPg.txt_4c_Conquilhas.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8769:                 ENDIF
8770:                 loc_oBusca = .NULL.
8771:             ENDIF
8772: 
8773:             IF USED("cursor_4c_CnqBusca")

*-- Linhas 8800 a 8844:
8800:                 loc_lResultado = .T.
8801:             ENDIF
8802: 
8803:             loc_nRet = SQLEXEC(gnConnHandle, ;
8804:                 "SELECT cods, descs FROM SigCdCor WHERE cods = '" + ;
8805:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_CorFPBusca")
8806:             IF loc_nRet > 0 AND USED("cursor_4c_CorFPBusca") AND !EOF("cursor_4c_CorFPBusca")
8807:                 IF USED("cursor_4c_CorFPBusca")
8808:                     USE IN cursor_4c_CorFPBusca
8809:                 ENDIF
8810:                 *-- Sincronizar com Page1
8811:                 LOCAL loc_oPg1
8812:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8813:                 IF PEMSTATUS(loc_oPg1, "txt_4c_CodCors", 5)
8814:                     loc_oPg1.txt_4c_CodCors.Value = loc_cValAtual
8815:                 ENDIF
8816:                 loc_lResultado = .T.
8817:             ENDIF
8818:             IF USED("cursor_4c_CorFPBusca")
8819:                 USE IN cursor_4c_CorFPBusca
8820:             ENDIF
8821: 
8822:             loc_nRet = SQLEXEC(gnConnHandle, ;
8823:                 "SELECT cods, descs FROM SigCdCor WHERE cods LIKE '" + ;
8824:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_CorFPBusca")
8825:             IF loc_nRet <= 0 OR !USED("cursor_4c_CorFPBusca") OR EOF("cursor_4c_CorFPBusca")
8826:                 IF USED("cursor_4c_CorFPBusca")
8827:                     USE IN cursor_4c_CorFPBusca
8828:                 ENDIF
8829:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdCor ORDER BY cods", ;
8830:                     "cursor_4c_CorFPBusca")
8831:             ENDIF
8832: 
8833:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8834:             IF VARTYPE(loc_oBusca) = "O"
8835:                 loc_oBusca.DefinirCursor("cursor_4c_CorFPBusca", "cods", "descs", ;
8836:                     "Selecionar Cor Padr" + CHR(227) + "o")
8837:                 loc_oBusca.Mostrar()
8838:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8839:                     loc_oPg.txt_4c_CodCorsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8840:                     LOCAL loc_oPg1b
8841:                     loc_oPg1b = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8842:                     IF PEMSTATUS(loc_oPg1b, "txt_4c_CodCors", 5)
8843:                         loc_oPg1b.txt_4c_CodCors.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8844:                     ENDIF

*-- Linhas 8876 a 8919:
8876:                 loc_lResultado = .T.
8877:             ENDIF
8878: 
8879:             loc_nRet = SQLEXEC(gnConnHandle, ;
8880:                 "SELECT cods, descs FROM SigCdTam WHERE cods = '" + ;
8881:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_TamFPBusca")
8882:             IF loc_nRet > 0 AND USED("cursor_4c_TamFPBusca") AND !EOF("cursor_4c_TamFPBusca")
8883:                 IF USED("cursor_4c_TamFPBusca")
8884:                     USE IN cursor_4c_TamFPBusca
8885:                 ENDIF
8886:                 LOCAL loc_oPg1c
8887:                 loc_oPg1c = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8888:                 IF PEMSTATUS(loc_oPg1c, "txt_4c_CodTams", 5)
8889:                     loc_oPg1c.txt_4c_CodTams.Value = loc_cValAtual
8890:                 ENDIF
8891:                 loc_lResultado = .T.
8892:             ENDIF
8893:             IF USED("cursor_4c_TamFPBusca")
8894:                 USE IN cursor_4c_TamFPBusca
8895:             ENDIF
8896: 
8897:             loc_nRet = SQLEXEC(gnConnHandle, ;
8898:                 "SELECT cods, descs FROM SigCdTam WHERE cods LIKE '" + ;
8899:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_TamFPBusca")
8900:             IF loc_nRet <= 0 OR !USED("cursor_4c_TamFPBusca") OR EOF("cursor_4c_TamFPBusca")
8901:                 IF USED("cursor_4c_TamFPBusca")
8902:                     USE IN cursor_4c_TamFPBusca
8903:                 ENDIF
8904:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdTam ORDER BY cods", ;
8905:                     "cursor_4c_TamFPBusca")
8906:             ENDIF
8907: 
8908:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8909:             IF VARTYPE(loc_oBusca) = "O"
8910:                 loc_oBusca.DefinirCursor("cursor_4c_TamFPBusca", "cods", "descs", ;
8911:                     "Selecionar Tamanho Padr" + CHR(227) + "o")
8912:                 loc_oBusca.Mostrar()
8913:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8914:                     loc_oPg.txt_4c_CodTamsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8915:                     LOCAL loc_oPg1d
8916:                     loc_oPg1d = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8917:                     IF PEMSTATUS(loc_oPg1d, "txt_4c_CodTams", 5)
8918:                         loc_oPg1d.txt_4c_CodTams.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8919:                     ENDIF

*-- Linhas 8952 a 8997:
8952:                 loc_lResultado = .T.
8953:             ENDIF
8954: 
8955:             loc_nRet = SQLEXEC(gnConnHandle, ;
8956:                 "SELECT cods, descrs FROM SigCdAca WHERE cods = '" + ;
8957:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_AcaFPBusca")
8958:             IF loc_nRet > 0 AND USED("cursor_4c_AcaFPBusca") AND !EOF("cursor_4c_AcaFPBusca")
8959:                 SELECT cursor_4c_AcaFPBusca
8960:                 loc_oPg.txt_4c_DacbFP.Value = ALLTRIM(cursor_4c_AcaFPBusca.descrs)
8961:                 IF USED("cursor_4c_AcaFPBusca")
8962:                     USE IN cursor_4c_AcaFPBusca
8963:                 ENDIF
8964:                 LOCAL loc_oPg1e
8965:                 loc_oPg1e = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8966:                 IF PEMSTATUS(loc_oPg1e, "txt_4c_CodAcbs", 5)
8967:                     loc_oPg1e.txt_4c_CodAcbs.Value = loc_cValAtual
8968:                 ENDIF
8969:                 loc_lResultado = .T.
8970:             ENDIF
8971:             IF USED("cursor_4c_AcaFPBusca")
8972:                 USE IN cursor_4c_AcaFPBusca
8973:             ENDIF
8974: 
8975:             loc_nRet = SQLEXEC(gnConnHandle, ;
8976:                 "SELECT cods, descrs FROM SigCdAca WHERE cods LIKE '" + ;
8977:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_AcaFPBusca")
8978:             IF loc_nRet <= 0 OR !USED("cursor_4c_AcaFPBusca") OR EOF("cursor_4c_AcaFPBusca")
8979:                 IF USED("cursor_4c_AcaFPBusca")
8980:                     USE IN cursor_4c_AcaFPBusca
8981:                 ENDIF
8982:                 SQLEXEC(gnConnHandle, "SELECT cods, descrs FROM SigCdAca ORDER BY cods", ;
8983:                     "cursor_4c_AcaFPBusca")
8984:             ENDIF
8985: 
8986:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8987:             IF VARTYPE(loc_oBusca) = "O"
8988:                 loc_oBusca.DefinirCursor("cursor_4c_AcaFPBusca", "cods", "descrs", ;
8989:                     "Selecionar Acabamento")
8990:                 loc_oBusca.Mostrar()
8991:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8992:                     loc_oPg.txt_4c_CodAcbsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8993:                     loc_oPg.txt_4c_DacbFP.Value    = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
8994:                     LOCAL loc_oPg1f
8995:                     loc_oPg1f = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8996:                     IF PEMSTATUS(loc_oPg1f, "txt_4c_CodAcbs", 5)
8997:                         loc_oPg1f.txt_4c_CodAcbs.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)

*-- Linhas 9024 a 9083:
9024:             IF !USED("cursor_4c_GrdMatrizes") OR EOF("cursor_4c_GrdMatrizes")
9025:                 loc_lResultado = .T.
9026:             ENDIF
9027:             SELECT cursor_4c_GrdMatrizes
9028:             loc_cValAtual = ALLTRIM(cursor_4c_GrdMatrizes.cmats)
9029:             IF EMPTY(loc_cValAtual)
9030:                 loc_lResultado = .T.
9031:             ENDIF
9032: 
9033:             loc_nRet = SQLEXEC(gnConnHandle, ;
9034:                 "SELECT cpros, dpros FROM SigCdPro WHERE cpros = '" + ;
9035:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_MtzPrBusca")
9036:             IF loc_nRet > 0 AND USED("cursor_4c_MtzPrBusca") AND !EOF("cursor_4c_MtzPrBusca")
9037:                 SELECT cursor_4c_MtzPrBusca
9038:                 SELECT cursor_4c_GrdMatrizes
9039:                 REPLACE cursor_4c_GrdMatrizes.dpros WITH ALLTRIM(cursor_4c_MtzPrBusca.dpros)
9040:                 IF USED("cursor_4c_MtzPrBusca")
9041:                     USE IN cursor_4c_MtzPrBusca
9042:                 ENDIF
9043:                 loc_lResultado = .T.
9044:             ENDIF
9045:             IF USED("cursor_4c_MtzPrBusca")
9046:                 USE IN cursor_4c_MtzPrBusca
9047:             ENDIF
9048: 
9049:             *-- Codigo nao encontrado: abrir busca
9050:             loc_nRet = SQLEXEC(gnConnHandle, ;
9051:                 "SELECT cpros, dpros FROM SigCdPro WHERE cpros LIKE '" + ;
9052:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cpros", "cursor_4c_MtzPrBusca")
9053:             IF loc_nRet <= 0 OR !USED("cursor_4c_MtzPrBusca") OR EOF("cursor_4c_MtzPrBusca")
9054:                 IF USED("cursor_4c_MtzPrBusca")
9055:                     USE IN cursor_4c_MtzPrBusca
9056:                 ENDIF
9057:                 SQLEXEC(gnConnHandle, ;
9058:                     "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros", ;
9059:                     "cursor_4c_MtzPrBusca")
9060:             ENDIF
9061: 
9062:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
9063:             IF VARTYPE(loc_oBusca) = "O"
9064:                 loc_oBusca.DefinirCursor("cursor_4c_MtzPrBusca", "cpros", "dpros", ;
9065:                     "Selecionar Produto Matriz")
9066:                 loc_oBusca.Mostrar()
9067:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdMatrizes")
9068:                     SELECT cursor_4c_GrdMatrizes
9069:                     REPLACE cursor_4c_GrdMatrizes.cmats WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
9070:                     REPLACE cursor_4c_GrdMatrizes.dpros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
9071:                 ENDIF
9072:                 loc_oBusca = .NULL.
9073:             ENDIF
9074: 
9075:             IF USED("cursor_4c_MtzPrBusca")
9076:                 USE IN cursor_4c_MtzPrBusca
9077:             ENDIF
9078: 
9079:         CATCH TO loException
9080:             IF USED("cursor_4c_MtzPrBusca")
9081:                 USE IN cursor_4c_MtzPrBusca
9082:             ENDIF
9083:             MostrarErro("Erro ao validar matriz:" + CHR(13) + loException.Message, ;

*-- Linhas 9103 a 9129:
9103:             loc_oPg.img_4c_ImgBorracha.Visible = .F.
9104: 
9105:             IF !EOF("cursor_4c_GrdMatrizes") AND !BOF("cursor_4c_GrdMatrizes")
9106:                 SELECT cursor_4c_GrdMatrizes
9107:                 LOCAL loc_cCmats
9108:                 loc_cCmats = ALLTRIM(cursor_4c_GrdMatrizes.cmats)
9109:                 IF !EMPTY(loc_cCmats)
9110:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9111:                         "SELECT figprocs FROM SigCdPro WHERE cpros = '" + ;
9112:                         EscaparSQL(loc_cCmats) + "", "cursor_4c_MtzImgPro")
9113:                     IF loc_nRet > 0 AND USED("cursor_4c_MtzImgPro") AND !EOF("cursor_4c_MtzImgPro")
9114:                         SELECT cursor_4c_MtzImgPro
9115:                         IF !ISNULL(cursor_4c_MtzImgPro.figprocs) AND ;
9116:                                 !EMPTY(cursor_4c_MtzImgPro.figprocs)
9117:                             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9118:                             IF STRTOFILE(cursor_4c_MtzImgPro.figprocs, loc_lcArquivo) > 0
9119:                                 loc_oPg.img_4c_ImgBorracha.Visible = .T.
9120:                                 loc_oPg.img_4c_ImgBorracha.Picture = loc_lcArquivo
9121:                             ENDIF
9122:                         ENDIF
9123:                     ENDIF
9124:                     IF USED("cursor_4c_MtzImgPro")
9125:                         USE IN cursor_4c_MtzImgPro
9126:                     ENDIF
9127:                 ENDIF
9128:             ENDIF
9129: 

*-- Linhas 9147 a 9165:
9147:                 RETURN
9148:             ENDIF
9149: 
9150:             INSERT INTO cursor_4c_GrdMatrizes (cidchaves, cmats, qtds, dpros) ;
9151:                 VALUES (SYS(2015), "", 0, "")
9152: 
9153:             GO BOTTOM IN cursor_4c_GrdMatrizes
9154: 
9155:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9156:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
9157:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
9158:                 loc_oPg.grd_4c_GrdMatrizes.Column1.SetFocus()
9159:             ENDIF
9160: 
9161:         CATCH TO loException
9162:             MostrarErro("Erro ao inserir matriz:" + CHR(13) + loException.Message, ;
9163:                 "FormProduto.BtnInserirMtzClick")
9164:         ENDTRY
9165:     ENDPROC

*-- Linhas 9178 a 9200:
9178:                 RETURN
9179:             ENDIF
9180: 
9181:             SELECT cursor_4c_GrdMatrizes
9182:             IF !MsgConfirma("Excluir este registro de matriz?")
9183:                 RETURN
9184:             ENDIF
9185:             DELETE IN cursor_4c_GrdMatrizes
9186:             IF !EOF("cursor_4c_GrdMatrizes")
9187:                 SKIP IN cursor_4c_GrdMatrizes
9188:             ENDIF
9189:             IF EOF("cursor_4c_GrdMatrizes") AND RECCOUNT("cursor_4c_GrdMatrizes") > 0
9190:                 GO BOTTOM IN cursor_4c_GrdMatrizes
9191:             ENDIF
9192: 
9193:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9194:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
9195:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
9196:             ENDIF
9197: 
9198:         CATCH TO loException
9199:             MostrarErro("Erro ao excluir matriz:" + CHR(13) + loException.Message, ;
9200:                 "FormProduto.BtnExcluirMtzClick")

*-- Linhas 9224 a 9243:
9224:                 ENDIF
9225:                 RETURN
9226:             ENDIF
9227:             loc_nRet = SQLEXEC(gnConnHandle, ;
9228:                 "SELECT codigos, descricaos FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cCod), ;
9229:                 "cursor_4c_ClfBusca")
9230:             IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca") AND !EOF("cursor_4c_ClfBusca")
9231:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9232:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.descricaos)
9233:                 ENDIF
9234:                 IF USED("cursor_4c_ClfBusca")
9235:                     USE IN cursor_4c_ClfBusca
9236:                 ENDIF
9237:             ELSE
9238:                 IF USED("cursor_4c_ClfBusca")
9239:                     USE IN cursor_4c_ClfBusca
9240:                 ENDIF
9241:                 THIS.AbrirBuscaClfiscal()
9242:             ENDIF
9243:         CATCH TO loException

*-- Linhas 9282 a 9302:
9282:                 THIS.AbrirBuscaClfiscal()
9283:                 RETURN
9284:             ENDIF
9285:             loc_nRet = SQLEXEC(gnConnHandle, ;
9286:                 "SELECT codigos, descricaos FROM SigCdClf WHERE descricaos LIKE " + ;
9287:                 EscaparSQL(loc_cDesc + "%"), ;
9288:                 "cursor_4c_ClfBusca")
9289:             IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca") AND !EOF("cursor_4c_ClfBusca")
9290:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9291:                     loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.codigos)
9292:                 ENDIF
9293:                 loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.descricaos)
9294:                 IF USED("cursor_4c_ClfBusca")
9295:                     USE IN cursor_4c_ClfBusca
9296:                 ENDIF
9297:             ELSE
9298:                 IF USED("cursor_4c_ClfBusca")
9299:                     USE IN cursor_4c_ClfBusca
9300:                 ENDIF
9301:                 THIS.AbrirBuscaClfiscal()
9302:             ENDIF

*-- Linhas 9333 a 9352:
9333:                 ENDIF
9334:                 RETURN
9335:             ENDIF
9336:             loc_nRet = SQLEXEC(gnConnHandle, ;
9337:                 "SELECT codigos, descricaos FROM SIGCDORG WHERE codigos = " + EscaparSQL(loc_cCod), ;
9338:                 "cursor_4c_OrgBusca")
9339:             IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca") AND !EOF("cursor_4c_OrgBusca")
9340:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9341:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgBusca.descricaos)
9342:                 ENDIF
9343:                 IF USED("cursor_4c_OrgBusca")
9344:                     USE IN cursor_4c_OrgBusca
9345:                 ENDIF
9346:             ELSE
9347:                 IF USED("cursor_4c_OrgBusca")
9348:                     USE IN cursor_4c_OrgBusca
9349:                 ENDIF
9350:                 THIS.AbrirBuscaOrigmerc()
9351:             ENDIF
9352:         CATCH TO loException

*-- Linhas 9391 a 9411:
9391:                 THIS.AbrirBuscaOrigmerc()
9392:                 RETURN
9393:             ENDIF
9394:             loc_nRet = SQLEXEC(gnConnHandle, ;
9395:                 "SELECT codigos, descricaos FROM SIGCDORG WHERE descricaos LIKE " + ;
9396:                 EscaparSQL(loc_cDesc + "%"), ;
9397:                 "cursor_4c_OrgBusca")
9398:             IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca") AND !EOF("cursor_4c_OrgBusca")
9399:                 IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9400:                     loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(cursor_4c_OrgBusca.codigos)
9401:                 ENDIF
9402:                 loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgBusca.descricaos)
9403:                 IF USED("cursor_4c_OrgBusca")
9404:                     USE IN cursor_4c_OrgBusca
9405:                 ENDIF
9406:             ELSE
9407:                 IF USED("cursor_4c_OrgBusca")
9408:                     USE IN cursor_4c_OrgBusca
9409:                 ENDIF
9410:                 THIS.AbrirBuscaOrigmerc()
9411:             ENDIF

*-- Linhas 9442 a 9461:
9442:                 ENDIF
9443:                 RETURN
9444:             ENDIF
9445:             loc_nRet = SQLEXEC(gnConnHandle, ;
9446:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
9447:                 "cursor_4c_IcmBusca")
9448:             IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca") AND !EOF("cursor_4c_IcmBusca")
9449:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9450:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmBusca.descricaos)
9451:                 ENDIF
9452:                 IF USED("cursor_4c_IcmBusca")
9453:                     USE IN cursor_4c_IcmBusca
9454:                 ENDIF
9455:             ELSE
9456:                 IF USED("cursor_4c_IcmBusca")
9457:                     USE IN cursor_4c_IcmBusca
9458:                 ENDIF
9459:                 THIS.AbrirBuscaSittricm()
9460:             ENDIF
9461:         CATCH TO loException

*-- Linhas 9500 a 9520:
9500:                 THIS.AbrirBuscaSittricm()
9501:                 RETURN
9502:             ENDIF
9503:             loc_nRet = SQLEXEC(gnConnHandle, ;
9504:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE descricaos LIKE " + ;
9505:                 EscaparSQL(loc_cDesc + "%"), ;
9506:                 "cursor_4c_IcmBusca")
9507:             IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca") AND !EOF("cursor_4c_IcmBusca")
9508:                 IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9509:                     loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_IcmBusca.codigos)
9510:                 ENDIF
9511:                 loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmBusca.descricaos)
9512:                 IF USED("cursor_4c_IcmBusca")
9513:                     USE IN cursor_4c_IcmBusca
9514:                 ENDIF
9515:             ELSE
9516:                 IF USED("cursor_4c_IcmBusca")
9517:                     USE IN cursor_4c_IcmBusca
9518:                 ENDIF
9519:                 THIS.AbrirBuscaSittricm()
9520:             ENDIF

*-- Linhas 9548 a 9567:
9548:             IF EMPTY(loc_cCod)
9549:                 RETURN
9550:             ENDIF
9551:             loc_nRet = SQLEXEC(gnConnHandle, ;
9552:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
9553:                 "cursor_4c_IcmServBusca")
9554:             IF loc_nRet > 0 AND USED("cursor_4c_IcmServBusca") AND !EOF("cursor_4c_IcmServBusca")
9555:                 IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9556:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(cursor_4c_IcmServBusca.codigos)
9557:                 ENDIF
9558:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9559:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmServBusca.descricaos)
9560:                 ENDIF
9561:                 IF USED("cursor_4c_IcmServBusca")
9562:                     USE IN cursor_4c_IcmServBusca
9563:                 ENDIF
9564:             ELSE
9565:                 IF USED("cursor_4c_IcmServBusca")
9566:                     USE IN cursor_4c_IcmServBusca
9567:                 ENDIF

*-- Linhas 9597 a 9616:
9597:             IF EMPTY(loc_cCod)
9598:                 RETURN
9599:             ENDIF
9600:             loc_nRet = SQLEXEC(gnConnHandle, ;
9601:                 "SELECT tipos, descs FROM SigPrTri WHERE tipos = " + EscaparSQL(loc_cCod), ;
9602:                 "cursor_4c_TpTribBusca")
9603:             IF loc_nRet > 0 AND USED("cursor_4c_TpTribBusca") AND !EOF("cursor_4c_TpTribBusca")
9604:                 IF USED("cursor_4c_TpTribBusca")
9605:                     USE IN cursor_4c_TpTribBusca
9606:                 ENDIF
9607:             ELSE
9608:                 IF USED("cursor_4c_TpTribBusca")
9609:                     USE IN cursor_4c_TpTribBusca
9610:                 ENDIF
9611:                 THIS.AbrirBuscaTpTrib()
9612:             ENDIF
9613:         CATCH TO loException
9614:             IF USED("cursor_4c_TpTribBusca")
9615:                 USE IN cursor_4c_TpTribBusca
9616:             ENDIF

*-- Linhas 9677 a 9696:
9677:             IF EMPTY(loc_cClf) OR loc_nAliq = 0
9678:                 RETURN
9679:             ENDIF
9680:             loc_nRet = SQLEXEC(gnConnHandle, ;
9681:                 "SELECT aipis FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cClf), ;
9682:                 "cursor_4c_ClfAliq")
9683:             IF loc_nRet > 0 AND USED("cursor_4c_ClfAliq") AND !EOF("cursor_4c_ClfAliq")
9684:                 loc_nAliqRef = cursor_4c_ClfAliq.aipis
9685:                 IF loc_nAliqRef > 0 AND ABS(loc_nAliq - loc_nAliqRef) > 0.001
9686:                     MsgAviso("Al" + CHR(237) + "quota IPI informada (" + ;
9687:                         TRANSFORM(loc_nAliq) + "%) difere da padr" + CHR(227) + ;
9688:                         "o da classifica" + CHR(231) + CHR(227) + "o fiscal (" + ;
9689:                         TRANSFORM(loc_nAliqRef) + "%).")
9690:                 ENDIF
9691:             ENDIF
9692:             IF USED("cursor_4c_ClfAliq")
9693:                 USE IN cursor_4c_ClfAliq
9694:             ENDIF
9695:         CATCH TO loException
9696:             IF USED("cursor_4c_ClfAliq")

*-- Linhas 9723 a 9742:
9723:             IF EMPTY(loc_cClf)
9724:                 loc_lResultado = .F.
9725:             ENDIF
9726:             loc_nRet = SQLEXEC(gnConnHandle, ;
9727:                 "SELECT ipiprods FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cClf), ;
9728:                 "cursor_4c_ClfIpiProd")
9729:             IF loc_nRet > 0 AND USED("cursor_4c_ClfIpiProd") AND !EOF("cursor_4c_ClfIpiProd")
9730:                 loc_lPermite = (ALLTRIM(cursor_4c_ClfIpiProd.ipiprods) = "S")
9731:             ENDIF
9732:             IF USED("cursor_4c_ClfIpiProd")
9733:                 USE IN cursor_4c_ClfIpiProd
9734:             ENDIF
9735:         CATCH TO loException
9736:             IF USED("cursor_4c_ClfIpiProd")
9737:                 USE IN cursor_4c_ClfIpiProd
9738:             ENDIF
9739:         ENDTRY
9740:         RETURN loc_lPermite
9741:     ENDPROC
9742: 

*-- Linhas 9790 a 9809:
9790:                 ENDIF
9791:                 RETURN
9792:             ENDIF
9793:             loc_nRet = SQLEXEC(gnConnHandle, ;
9794:                 "SELECT codigos, descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
9795:                 " AND tipos = 'M'", ;
9796:                 "cursor_4c_MetalBusca")
9797:             IF loc_nRet > 0 AND USED("cursor_4c_MetalBusca") AND !EOF("cursor_4c_MetalBusca")
9798:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
9799:                     loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(cursor_4c_MetalBusca.descs)
9800:                 ENDIF
9801:                 IF USED("cursor_4c_MetalBusca")
9802:                     USE IN cursor_4c_MetalBusca
9803:                 ENDIF
9804:             ELSE
9805:                 IF USED("cursor_4c_MetalBusca")
9806:                     USE IN cursor_4c_MetalBusca
9807:                 ENDIF
9808:                 THIS.AbrirBuscaMetal()
9809:             ENDIF

*-- Linhas 9840 a 9859:
9840:                 ENDIF
9841:                 RETURN
9842:             ENDIF
9843:             loc_nRet = SQLEXEC(gnConnHandle, ;
9844:                 "SELECT codigos, descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
9845:                 " AND tipos <> 'M'", ;
9846:                 "cursor_4c_TeorBusca")
9847:             IF loc_nRet > 0 AND USED("cursor_4c_TeorBusca") AND !EOF("cursor_4c_TeorBusca")
9848:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
9849:                     loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(cursor_4c_TeorBusca.descs)
9850:                 ENDIF
9851:                 IF USED("cursor_4c_TeorBusca")
9852:                     USE IN cursor_4c_TeorBusca
9853:                 ENDIF
9854:             ELSE
9855:                 IF USED("cursor_4c_TeorBusca")
9856:                     USE IN cursor_4c_TeorBusca
9857:                 ENDIF
9858:                 THIS.AbrirBuscaTeor()
9859:             ENDIF

*-- Linhas 9887 a 9906:
9887:             IF EMPTY(loc_cCod)
9888:                 RETURN
9889:             ENDIF
9890:             loc_nRet = SQLEXEC(gnConnHandle, ;
9891:                 "SELECT cmoeds, dmoeds FROM SigCdMoe WHERE cmoeds = " + EscaparSQL(loc_cCod), ;
9892:                 "cursor_4c_MoeFiscalBusca")
9893:             IF loc_nRet > 0 AND USED("cursor_4c_MoeFiscalBusca") AND !EOF("cursor_4c_MoeFiscalBusca")
9894:                 IF USED("cursor_4c_MoeFiscalBusca")
9895:                     USE IN cursor_4c_MoeFiscalBusca
9896:                 ENDIF
9897:             ELSE
9898:                 IF USED("cursor_4c_MoeFiscalBusca")
9899:                     USE IN cursor_4c_MoeFiscalBusca
9900:                 ENDIF
9901:                 THIS.AbrirBuscaMvalorFiscal()
9902:             ENDIF
9903:         CATCH TO loException
9904:             IF USED("cursor_4c_MoeFiscalBusca")
9905:                 USE IN cursor_4c_MoeFiscalBusca
9906:             ENDIF

*-- Linhas 10073 a 10100:
10073:             IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10074:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
10075:             ENDIF
10076:             loc_nRet = SQLEXEC(gnConnHandle, ;
10077:                 "SELECT codigos, descricaos FROM SigCdClf WHERE codigos LIKE " + ;
10078:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10079:                 "cursor_4c_ClfBusca")
10080:             IF loc_nRet <= 0 OR !USED("cursor_4c_ClfBusca") OR EOF("cursor_4c_ClfBusca")
10081:                 IF USED("cursor_4c_ClfBusca")
10082:                     USE IN cursor_4c_ClfBusca
10083:                 ENDIF
10084:                 SQLEXEC(gnConnHandle, ;
10085:                     "SELECT codigos, descricaos FROM SigCdClf ORDER BY codigos", ;
10086:                     "cursor_4c_ClfBusca")
10087:             ENDIF
10088:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10089:             IF VARTYPE(loc_oBusca) = "O"
10090:                 loc_oBusca.DefinirCursor("cursor_4c_ClfBusca", "codigos", "descricaos", ;
10091:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
10092:                 loc_oBusca.Mostrar()
10093:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10094:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10095:                         loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10096:                     ENDIF
10097:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
10098:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10099:                     ENDIF
10100:                 ENDIF

*-- Linhas 10121 a 10148:
10121:             IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
10122:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
10123:             ENDIF
10124:             loc_nRet = SQLEXEC(gnConnHandle, ;
10125:                 "SELECT codigos, descricaos FROM SIGCDORG WHERE codigos LIKE " + ;
10126:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10127:                 "cursor_4c_OrgBusca")
10128:             IF loc_nRet <= 0 OR !USED("cursor_4c_OrgBusca") OR EOF("cursor_4c_OrgBusca")
10129:                 IF USED("cursor_4c_OrgBusca")
10130:                     USE IN cursor_4c_OrgBusca
10131:                 ENDIF
10132:                 SQLEXEC(gnConnHandle, ;
10133:                     "SELECT codigos, descricaos FROM SIGCDORG ORDER BY codigos", ;
10134:                     "cursor_4c_OrgBusca")
10135:             ENDIF
10136:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10137:             IF VARTYPE(loc_oBusca) = "O"
10138:                 loc_oBusca.DefinirCursor("cursor_4c_OrgBusca", "codigos", "descricaos", ;
10139:                     "Buscar Origem Mercadoria")
10140:                 loc_oBusca.Mostrar()
10141:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10142:                     IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
10143:                         loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10144:                     ENDIF
10145:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
10146:                         loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10147:                     ENDIF
10148:                 ENDIF

*-- Linhas 10169 a 10196:
10169:             IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10170:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
10171:             ENDIF
10172:             loc_nRet = SQLEXEC(gnConnHandle, ;
10173:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos LIKE " + ;
10174:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10175:                 "cursor_4c_IcmBusca")
10176:             IF loc_nRet <= 0 OR !USED("cursor_4c_IcmBusca") OR EOF("cursor_4c_IcmBusca")
10177:                 IF USED("cursor_4c_IcmBusca")
10178:                     USE IN cursor_4c_IcmBusca
10179:                 ENDIF
10180:                 SQLEXEC(gnConnHandle, ;
10181:                     "SELECT codigos, descricaos FROM SIGCDICM ORDER BY codigos", ;
10182:                     "cursor_4c_IcmBusca")
10183:             ENDIF
10184:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10185:             IF VARTYPE(loc_oBusca) = "O"
10186:                 loc_oBusca.DefinirCursor("cursor_4c_IcmBusca", "codigos", "descricaos", ;
10187:                     "Buscar Sit. Tributaria ICMS")
10188:                 loc_oBusca.Mostrar()
10189:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10190:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10191:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10192:                     ENDIF
10193:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
10194:                         loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10195:                     ENDIF
10196:                 ENDIF

*-- Linhas 10217 a 10244:
10217:             IF PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
10218:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Codigo.Value)
10219:             ENDIF
10220:             loc_nRet = SQLEXEC(gnConnHandle, ;
10221:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos LIKE " + ;
10222:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10223:                 "cursor_4c_CodServBusca")
10224:             IF loc_nRet <= 0 OR !USED("cursor_4c_CodServBusca") OR EOF("cursor_4c_CodServBusca")
10225:                 IF USED("cursor_4c_CodServBusca")
10226:                     USE IN cursor_4c_CodServBusca
10227:                 ENDIF
10228:                 SQLEXEC(gnConnHandle, ;
10229:                     "SELECT codigos, descricaos FROM SIGCDICM ORDER BY codigos", ;
10230:                     "cursor_4c_CodServBusca")
10231:             ENDIF
10232:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10233:             IF VARTYPE(loc_oBusca) = "O"
10234:                 loc_oBusca.DefinirCursor("cursor_4c_CodServBusca", "codigos", "descricaos", ;
10235:                     "Buscar C" + CHR(243) + "d. Servi" + CHR(231) + "o Fiscal")
10236:                 loc_oBusca.Mostrar()
10237:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10238:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
10239:                         loc_oPg.txt_4c_Codigo.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10240:                     ENDIF
10241:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10242:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10243:                     ENDIF
10244:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)

*-- Linhas 10268 a 10295:
10268:             IF PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
10269:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_TpTrib.Value)
10270:             ENDIF
10271:             loc_nRet = SQLEXEC(gnConnHandle, ;
10272:                 "SELECT tipos, descs FROM SigPrTri WHERE tipos LIKE " + ;
10273:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY tipos", ;
10274:                 "cursor_4c_TpTribBusca")
10275:             IF loc_nRet <= 0 OR !USED("cursor_4c_TpTribBusca") OR EOF("cursor_4c_TpTribBusca")
10276:                 IF USED("cursor_4c_TpTribBusca")
10277:                     USE IN cursor_4c_TpTribBusca
10278:                 ENDIF
10279:                 SQLEXEC(gnConnHandle, ;
10280:                     "SELECT tipos, descs FROM SigPrTri ORDER BY tipos", ;
10281:                     "cursor_4c_TpTribBusca")
10282:             ENDIF
10283:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10284:             IF VARTYPE(loc_oBusca) = "O"
10285:                 loc_oBusca.DefinirCursor("cursor_4c_TpTribBusca", "tipos", "descs", ;
10286:                     "Buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o")
10287:                 loc_oBusca.Mostrar()
10288:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10289:                     IF PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
10290:                         loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10291:                     ENDIF
10292:                 ENDIF
10293:                 loc_oBusca = .NULL.
10294:             ENDIF
10295:             IF USED("cursor_4c_TpTribBusca")

*-- Linhas 10313 a 10341:
10313:             IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
10314:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Metal.Value)
10315:             ENDIF
10316:             loc_nRet = SQLEXEC(gnConnHandle, ;
10317:                 "SELECT codigos, descs FROM SigCdMtl " + ;
10318:                 "WHERE tipos = 'M' AND codigos LIKE " + ;
10319:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10320:                 "cursor_4c_MetalBusca")
10321:             IF loc_nRet <= 0 OR !USED("cursor_4c_MetalBusca") OR EOF("cursor_4c_MetalBusca")
10322:                 IF USED("cursor_4c_MetalBusca")
10323:                     USE IN cursor_4c_MetalBusca
10324:                 ENDIF
10325:                 SQLEXEC(gnConnHandle, ;
10326:                     "SELECT codigos, descs FROM SigCdMtl WHERE tipos = 'M' ORDER BY codigos", ;
10327:                     "cursor_4c_MetalBusca")
10328:             ENDIF
10329:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10330:             IF VARTYPE(loc_oBusca) = "O"
10331:                 loc_oBusca.DefinirCursor("cursor_4c_MetalBusca", "codigos", "descs", "Buscar Metal")
10332:                 loc_oBusca.Mostrar()
10333:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10334:                     IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
10335:                         loc_oPg.txt_4c_Metal.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10336:                     ENDIF
10337:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
10338:                         loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10339:                     ENDIF
10340:                 ENDIF
10341:                 loc_oBusca = .NULL.

*-- Linhas 10361 a 10389:
10361:             IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
10362:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Teor.Value)
10363:             ENDIF
10364:             loc_nRet = SQLEXEC(gnConnHandle, ;
10365:                 "SELECT codigos, descs FROM SigCdMtl " + ;
10366:                 "WHERE tipos <> 'M' AND codigos LIKE " + ;
10367:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10368:                 "cursor_4c_TeorBusca")
10369:             IF loc_nRet <= 0 OR !USED("cursor_4c_TeorBusca") OR EOF("cursor_4c_TeorBusca")
10370:                 IF USED("cursor_4c_TeorBusca")
10371:                     USE IN cursor_4c_TeorBusca
10372:                 ENDIF
10373:                 SQLEXEC(gnConnHandle, ;
10374:                     "SELECT codigos, descs FROM SigCdMtl WHERE tipos <> 'M' ORDER BY codigos", ;
10375:                     "cursor_4c_TeorBusca")
10376:             ENDIF
10377:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10378:             IF VARTYPE(loc_oBusca) = "O"
10379:                 loc_oBusca.DefinirCursor("cursor_4c_TeorBusca", "codigos", "descs", "Buscar Teor")
10380:                 loc_oBusca.Mostrar()
10381:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10382:                     IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
10383:                         loc_oPg.txt_4c_Teor.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10384:                     ENDIF
10385:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
10386:                         loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10387:                     ENDIF
10388:                 ENDIF
10389:                 loc_oBusca = .NULL.

*-- Linhas 10409 a 10436:
10409:             IF PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
10410:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Mvalor.Value)
10411:             ENDIF
10412:             loc_nRet = SQLEXEC(gnConnHandle, ;
10413:                 "SELECT cmoeds, dmoeds FROM SigCdMoe WHERE cmoeds LIKE " + ;
10414:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY cmoeds", ;
10415:                 "cursor_4c_MoeFiscalBusca")
10416:             IF loc_nRet <= 0 OR !USED("cursor_4c_MoeFiscalBusca") OR EOF("cursor_4c_MoeFiscalBusca")
10417:                 IF USED("cursor_4c_MoeFiscalBusca")
10418:                     USE IN cursor_4c_MoeFiscalBusca
10419:                 ENDIF
10420:                 SQLEXEC(gnConnHandle, ;
10421:                     "SELECT cmoeds, dmoeds FROM SigCdMoe ORDER BY cmoeds", ;
10422:                     "cursor_4c_MoeFiscalBusca")
10423:             ENDIF
10424:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10425:             IF VARTYPE(loc_oBusca) = "O"
10426:                 loc_oBusca.DefinirCursor("cursor_4c_MoeFiscalBusca", "cmoeds", "dmoeds", ;
10427:                     "Buscar Moeda")
10428:                 loc_oBusca.Mostrar()
10429:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10430:                     IF PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
10431:                         loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10432:                     ENDIF
10433:                 ENDIF
10434:                 loc_oBusca = .NULL.
10435:             ENDIF
10436:             IF USED("cursor_4c_MoeFiscalBusca")

*-- Linhas 10456 a 10485:
10456: 
10457:             *-- Cursors placeholder (preenchidos pelo BO ao carregar produto)
10458:             IF !USED("cursor_4c_GrdDesigner")
10459:                 CREATE CURSOR cursor_4c_GrdDesigner ( ;
10460:                     dtini D, dtfim D, usuarios C(10), codcads C(10))
10461:             ENDIF
10462:             IF !USED("cursor_4c_GrdArquivos")
10463:                 CREATE CURSOR cursor_4c_GrdArquivos (arqnome C(200))
10464:             ENDIF
10465:             IF !USED("crTarefas")
10466:                 CREATE CURSOR crTarefas (CodCads C(10), DesCads C(40))
10467:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
10468:                     SQLEXEC(gnConnHandle, ;
10469:                         "SELECT LEFT(codcads, 10) AS CodCads, descads AS DesCads " + ;
10470:                         "FROM SigCdCad ORDER BY codcads", ;
10471:                         "crTarefas")
10472:                 ENDIF
10473:             ENDIF
10474: 
10475:             *-- grdDesigner: grade historico de designer (4 colunas)
10476:             *-- Original: top=145, left=10, width=495, height=180
10477:             loc_oPg.AddObject("grd_4c_GrdDesigner", "Grid")
10478:             WITH loc_oPg.grd_4c_GrdDesigner
10479:                 .Top        = 145
10480:                 .Left       = 10
10481:                 .Width      = 495
10482:                 .Height     = 180
10483:                 .FontName   = "Tahoma"
10484:                 .FontSize   = 8
10485:                 .RecordMark = .F.

*-- Linhas 10492 a 10531:
10492:             loc_oPg.grd_4c_GrdDesigner.RecordSource = "cursor_4c_GrdDesigner"
10493:             loc_oGrid = loc_oPg.grd_4c_GrdDesigner
10494: 
10495:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdDesigner.dtini"
10496:             loc_oGrid.Column1.Width           = 100
10497:             loc_oGrid.Column1.ColumnOrder     = 1
10498:             loc_oGrid.Column1.Movable         = .F.
10499:             loc_oGrid.Column1.Resizable       = .F.
10500:             loc_oGrid.Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
10501: 
10502:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdDesigner.dtfim"
10503:             loc_oGrid.Column2.Width           = 100
10504:             loc_oGrid.Column2.ColumnOrder     = 2
10505:             loc_oGrid.Column2.Movable         = .F.
10506:             loc_oGrid.Column2.Resizable       = .F.
10507:             loc_oGrid.Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
10508: 
10509:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdDesigner.usuarios"
10510:             loc_oGrid.Column3.Width           = 100
10511:             loc_oGrid.Column3.ColumnOrder     = 3
10512:             loc_oGrid.Column3.Movable         = .F.
10513:             loc_oGrid.Column3.Resizable       = .F.
10514:             loc_oGrid.Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
10515: 
10516:             loc_oGrid.Column4.ControlSource   = "cursor_4c_GrdDesigner.codcads"
10517:             loc_oGrid.Column4.Width           = 193
10518:             loc_oGrid.Column4.ColumnOrder     = 4
10519:             loc_oGrid.Column4.Movable         = .F.
10520:             loc_oGrid.Column4.Resizable       = .F.
10521:             loc_oGrid.Column4.Header1.Caption = "Tarefa"
10522:             BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdDesignerCol4TarefaValid")
10523: 
10524:             *-- Say31: label "Observacao da Tarefa"
10525:             *-- Original: top=129, left=583, width=126, height=15
10526:             loc_oPg.AddObject("lbl_4c_Label31", "Label")
10527:             WITH loc_oPg.lbl_4c_Label31
10528:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
10529:                 .Top       = 129
10530:                 .Left      = 583
10531:                 .Width     = 126

*-- Linhas 10641 a 10659:
10641:             ENDWITH
10642:             loc_oPg.grd_4c_GrdArquivos.ColumnCount  = 1
10643:             loc_oPg.grd_4c_GrdArquivos.RecordSource = "cursor_4c_GrdArquivos"
10644:             loc_oPg.grd_4c_GrdArquivos.Column1.ControlSource   = "cursor_4c_GrdArquivos.arqnome"
10645:             loc_oPg.grd_4c_GrdArquivos.Column1.Width           = 493
10646:             loc_oPg.grd_4c_GrdArquivos.Column1.ColumnOrder     = 1
10647:             loc_oPg.grd_4c_GrdArquivos.Column1.Movable         = .F.
10648:             loc_oPg.grd_4c_GrdArquivos.Column1.Resizable       = .F.
10649:             loc_oPg.grd_4c_GrdArquivos.Column1.Header1.Caption = "Arquivos Para Designer"
10650: 
10651:             *-- btnInsArqs: botao Inserir Arquivo
10652:             *-- Original: top=335, left=509, width=42, height=42
10653:             loc_oPg.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
10654:             WITH loc_oPg.cmd_4c_BtnInsArqs
10655:                 .Caption       = "+"
10656:                 .Top           = 335
10657:                 .Left          = 509
10658:                 .Width         = 42
10659:                 .Height        = 42

*-- Linhas 10881 a 10941:
10881:                 loc_cCodCads = ALLTRIM(cursor_4c_GrdDesigner.codcads)
10882:                 IF !EMPTY(loc_cCodCads)
10883:                     IF USED("crTarefas")
10884:                         SELECT crTarefas
10885:                         GO TOP
10886:                         LOCATE FOR ALLTRIM(CodCads) = loc_cCodCads
10887:                         IF EOF("crTarefas")
10888:                             THIS.AbrirBuscaTarefaDesigner()
10889:                         ENDIF
10890:                         IF USED("cursor_4c_GrdDesigner")
10891:                             SELECT cursor_4c_GrdDesigner
10892:                         ENDIF
10893:                     ELSE
10894:                         THIS.AbrirBuscaTarefaDesigner()
10895:                     ENDIF
10896:                 ENDIF
10897:             ENDIF
10898:         CATCH TO loException
10899:             MostrarErro("Erro ao validar Tarefa:" + CHR(13) + loException.Message, ;
10900:                 "FormProduto.GrdDesignerCol4TarefaValid")
10901:         ENDTRY
10902:         RETURN loc_lSucesso
10903:     ENDPROC
10904: 
10905:     PROCEDURE AbrirBuscaTarefaDesigner()
10906:         LOCAL loc_oBusca, loc_nRet, loException
10907:         TRY
10908:             IF !USED("crTarefas")
10909:                 CREATE CURSOR crTarefas (CodCads C(10), DesCads C(40))
10910:                 loc_nRet = SQLEXEC(gnConnHandle, ;
10911:                     "SELECT LEFT(codcads, 10) AS CodCads, descads AS DesCads " + ;
10912:                     "FROM SigCdCad ORDER BY codcads", ;
10913:                     "crTarefas")
10914:                 IF loc_nRet <= 0 OR EOF("crTarefas")
10915:                     MsgAviso("Sem tarefas cadastradas para selecionar.")
10916:                     RETURN
10917:                 ENDIF
10918:             ENDIF
10919:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10920:             IF VARTYPE(loc_oBusca) = "O"
10921:                 loc_oBusca.DefinirCursor("crTarefas", "CodCads", "DesCads", ;
10922:                     "Selecionar Tarefa")
10923:                 loc_oBusca.Mostrar()
10924:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND ;
10925:                     USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
10926:                     SELECT cursor_4c_GrdDesigner
10927:                     REPLACE cursor_4c_GrdDesigner.codcads WITH ;
10928:                         ALLTRIM(loc_oBusca.cCodigoSelecionado)
10929:                 ENDIF
10930:                 loc_oBusca = .NULL.
10931:             ENDIF
10932:         CATCH TO loException
10933:             MostrarErro("Erro ao buscar Tarefa:" + CHR(13) + loException.Message, ;
10934:                 "FormProduto.AbrirBuscaTarefaDesigner")
10935:         ENDTRY
10936:     ENDPROC
10937: 
10938:     *-- GetDesLacto (txt_4c_DesLacto): Valid - valida usuario desenvolvedor em SigCdUsu
10939:     PROCEDURE ValidarDesLacto(par_nKeyCode, par_nShiftAltCtrl)
10940:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
10941:             RETURN

*-- Linhas 10948 a 10968:
10948:                 loc_cCod = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
10949:             ENDIF
10950:             IF !EMPTY(loc_cCod)
10951:                 loc_nRet = SQLEXEC(gnConnHandle, ;
10952:                     "SELECT usuarios FROM SigCdUsu " + ;
10953:                     "WHERE usuarios = " + EscaparSQL(loc_cCod) + " AND cativos <> 'N'", ;
10954:                     "cursor_4c_DesLactoBusca")
10955:                 IF loc_nRet > 0 AND USED("cursor_4c_DesLactoBusca") AND !EOF("cursor_4c_DesLactoBusca")
10956:                     IF USED("cursor_4c_DesLactoBusca")
10957:                         USE IN cursor_4c_DesLactoBusca
10958:                     ENDIF
10959:                 ELSE
10960:                     IF USED("cursor_4c_DesLactoBusca")
10961:                         USE IN cursor_4c_DesLactoBusca
10962:                     ENDIF
10963:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
10964:                         loc_oPg.txt_4c_DesLacto.Value = ""
10965:                     ENDIF
10966:                     THIS.AbrirBuscaDesLacto()
10967:                 ENDIF
10968:             ENDIF

*-- Linhas 10983 a 11011:
10983:             IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
10984:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
10985:             ENDIF
10986:             loc_nRet = SQLEXEC(gnConnHandle, ;
10987:                 "SELECT usuarios, ncomps FROM SigCdUsu " + ;
10988:                 "WHERE cativos <> 'N' AND usuarios LIKE " + EscaparSQL(loc_cValAtual + "%") + ;
10989:                 " ORDER BY usuarios", ;
10990:                 "cursor_4c_DesLactoBusca")
10991:             IF loc_nRet <= 0 OR !USED("cursor_4c_DesLactoBusca") OR EOF("cursor_4c_DesLactoBusca")
10992:                 IF USED("cursor_4c_DesLactoBusca")
10993:                     USE IN cursor_4c_DesLactoBusca
10994:                 ENDIF
10995:                 SQLEXEC(gnConnHandle, ;
10996:                     "SELECT usuarios, ncomps FROM SigCdUsu WHERE cativos <> 'N' ORDER BY usuarios", ;
10997:                     "cursor_4c_DesLactoBusca")
10998:             ENDIF
10999:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
11000:             IF VARTYPE(loc_oBusca) = "O"
11001:                 loc_oBusca.DefinirCursor("cursor_4c_DesLactoBusca", "usuarios", "ncomps", ;
11002:                     "Selecionar Desenvolvedor")
11003:                 loc_oBusca.Mostrar()
11004:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
11005:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
11006:                         loc_oPg.txt_4c_DesLacto.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
11007:                     ENDIF
11008:                 ENDIF
11009:                 loc_oBusca = .NULL.
11010:             ENDIF
11011:             IF USED("cursor_4c_DesLactoBusca")

*-- Linhas 11033 a 11053:
11033:                 loc_cCod = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
11034:             ENDIF
11035:             IF !EMPTY(loc_cCod)
11036:                 loc_nRet = SQLEXEC(gnConnHandle, ;
11037:                     "SELECT usuarios FROM SigCdUsu " + ;
11038:                     "WHERE usuarios = " + EscaparSQL(loc_cCod) + " AND cativos <> 'N'", ;
11039:                     "cursor_4c_CriaLactoBusca")
11040:                 IF loc_nRet > 0 AND USED("cursor_4c_CriaLactoBusca") AND !EOF("cursor_4c_CriaLactoBusca")
11041:                     IF USED("cursor_4c_CriaLactoBusca")
11042:                         USE IN cursor_4c_CriaLactoBusca
11043:                     ENDIF
11044:                 ELSE
11045:                     IF USED("cursor_4c_CriaLactoBusca")
11046:                         USE IN cursor_4c_CriaLactoBusca
11047:                     ENDIF
11048:                     IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11049:                         loc_oPg.txt_4c_CriaLacto.Value = ""
11050:                     ENDIF
11051:                     THIS.AbrirBuscaCriaLacto()
11052:                 ENDIF
11053:             ENDIF

*-- Linhas 11068 a 11096:
11068:             IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11069:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
11070:             ENDIF
11071:             loc_nRet = SQLEXEC(gnConnHandle, ;
11072:                 "SELECT usuarios, ncomps FROM SigCdUsu " + ;
11073:                 "WHERE cativos <> 'N' AND usuarios LIKE " + EscaparSQL(loc_cValAtual + "%") + ;
11074:                 " ORDER BY usuarios", ;
11075:                 "cursor_4c_CriaLactoBusca")
11076:             IF loc_nRet <= 0 OR !USED("cursor_4c_CriaLactoBusca") OR EOF("cursor_4c_CriaLactoBusca")
11077:                 IF USED("cursor_4c_CriaLactoBusca")
11078:                     USE IN cursor_4c_CriaLactoBusca
11079:                 ENDIF
11080:                 SQLEXEC(gnConnHandle, ;
11081:                     "SELECT usuarios, ncomps FROM SigCdUsu WHERE cativos <> 'N' ORDER BY usuarios", ;
11082:                     "cursor_4c_CriaLactoBusca")
11083:             ENDIF
11084:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
11085:             IF VARTYPE(loc_oBusca) = "O"
11086:                 loc_oBusca.DefinirCursor("cursor_4c_CriaLactoBusca", "usuarios", "ncomps", ;
11087:                     "Selecionar Criador")
11088:                 loc_oBusca.Mostrar()
11089:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
11090:                     IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11091:                         loc_oPg.txt_4c_CriaLacto.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
11092:                     ENDIF
11093:                 ENDIF
11094:                 loc_oBusca = .NULL.
11095:             ENDIF
11096:             IF USED("cursor_4c_CriaLactoBusca")

*-- Linhas 11113 a 11131:
11113:                 MsgAviso("Habilite Incluir ou Alterar para registrar tarefa.")
11114:             ELSE
11115:                 IF USED("cursor_4c_GrdDesigner")
11116:                     SELECT cursor_4c_GrdDesigner
11117:                     APPEND BLANK
11118:                     REPLACE cursor_4c_GrdDesigner.dtini    WITH DATE()
11119:                     REPLACE cursor_4c_GrdDesigner.usuarios WITH ALLTRIM(gc_4c_UsuarioLogado)
11120:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11121:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdDesigner", 5)
11122:                         loc_oPg.grd_4c_GrdDesigner.Refresh()
11123:                     ENDIF
11124:                 ENDIF
11125:             ENDIF
11126:         CATCH TO loException
11127:             MostrarErro("Erro ao registrar inicio de tarefa:" + CHR(13) + loException.Message, ;
11128:                 "FormProduto.BtnIniTarefaClick")
11129:         ENDTRY
11130:     ENDPROC
11131: 

*-- Linhas 11137 a 11155:
11137:                 MsgAviso("Habilite Incluir ou Alterar para registrar conclus" + CHR(227) + "o.")
11138:             ELSE
11139:                 IF USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
11140:                     SELECT cursor_4c_GrdDesigner
11141:                     REPLACE cursor_4c_GrdDesigner.dtfim WITH DATE()
11142:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11143:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdDesigner", 5)
11144:                         loc_oPg.grd_4c_GrdDesigner.Refresh()
11145:                     ENDIF
11146:                 ELSE
11147:                     MsgAviso("Selecione um registro de tarefa para registrar conclus" + CHR(227) + "o.")
11148:                 ENDIF
11149:             ENDIF
11150:         CATCH TO loException
11151:             MostrarErro("Erro ao registrar fim de tarefa:" + CHR(13) + loException.Message, ;
11152:                 "FormProduto.BtnFimTarefaClick")
11153:         ENDTRY
11154:     ENDPROC
11155: 

*-- Linhas 11162 a 11180:
11162:             ELSE
11163:                 loc_cArquivo = GETFILE("*", "Selecionar Arquivo")
11164:                 IF !EMPTY(loc_cArquivo) AND USED("cursor_4c_GrdArquivos")
11165:                     SELECT cursor_4c_GrdArquivos
11166:                     APPEND BLANK
11167:                     REPLACE cursor_4c_GrdArquivos.arqnome WITH ALLTRIM(loc_cArquivo)
11168:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11169:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdArquivos", 5)
11170:                         loc_oPg.grd_4c_GrdArquivos.Refresh()
11171:                     ENDIF
11172:                 ENDIF
11173:             ENDIF
11174:         CATCH TO loException
11175:             MostrarErro("Erro ao inserir arquivo:" + CHR(13) + loException.Message, ;
11176:                 "FormProduto.BtnInsArqsClick")
11177:         ENDTRY
11178:     ENDPROC
11179: 
11180:     *-- btnExcArqs: exclui arquivo selecionado da lista grdArquivos

*-- Linhas 11187 a 11206:
11187:                 IF USED("cursor_4c_GrdArquivos") AND !EOF("cursor_4c_GrdArquivos")
11188:                     loc_lConfirm = MsgConfirma("Confirma exclus" + CHR(227) + "o do arquivo selecionado?")
11189:                     IF loc_lConfirm
11190:                         SELECT cursor_4c_GrdArquivos
11191:                         DELETE
11192:                         PACK
11193:                         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11194:                         IF PEMSTATUS(loc_oPg, "grd_4c_GrdArquivos", 5)
11195:                             loc_oPg.grd_4c_GrdArquivos.Refresh()
11196:                         ENDIF
11197:                     ENDIF
11198:                 ELSE
11199:                     MsgAviso("Selecione um arquivo para excluir.")
11200:                 ENDIF
11201:             ENDIF
11202:         CATCH TO loException
11203:             MostrarErro("Erro ao excluir arquivo:" + CHR(13) + loException.Message, ;
11204:                 "FormProduto.BtnExcArqsClick")
11205:         ENDTRY
11206:     ENDPROC

*-- Linhas 11254 a 11326:
11254: 
11255:             *-- Cursor placeholder ANTES de RecordSource (REGRA CRITICA VFP9)
11256:             IF !USED("cursor_4c_GrdServico")
11257:                 CREATE CURSOR cursor_4c_GrdServico (Marcas N(1,0), Cods C(3), Descs C(30), qtdias N(3,0))
11258:             ENDIF
11259: 
11260:             *-- grd_4c_Dados: grade de servicos associados
11261:             *-- Original grdServico: top=171, left=339, width=320, height=387
11262:             loc_oPg.AddObject("grd_4c_Dados", "Grid")
11263:             WITH loc_oPg.grd_4c_Dados
11264:                 .Top        = 171
11265:                 .Left       = 339
11266:                 .Width      = 320
11267:                 .Height     = 387
11268:                 .FontName   = "Tahoma"
11269:                 .FontSize   = 8
11270:                 .DeleteMark = .F.
11271:                 .RecordMark = .F.
11272:                 .RowHeight  = 16
11273:                 .ScrollBars = 2
11274:                 .Visible    = .T.
11275:             ENDWITH
11276:             loc_oPg.grd_4c_Dados.ColumnCount  = 3
11277:             loc_oPg.grd_4c_Dados.RecordSource = "cursor_4c_GrdServico"
11278:             loc_oGrid = loc_oPg.grd_4c_Dados
11279: 
11280:             *-- Column1: Descs/Descricao Servico (ColumnOrder=2 - exibida como 2a coluna)
11281:             *-- When: editavel em INCLUIR/ALTERAR E Marcas=1 na linha atual
11282:             *-- Valid: fAcessoEmpresa (validacao empresa por descricao de servico)
11283:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdServico.Descs"
11284:             loc_oGrid.Column1.Width           = 228
11285:             loc_oGrid.Column1.ColumnOrder     = 2
11286:             loc_oGrid.Column1.Movable         = .F.
11287:             loc_oGrid.Column1.Resizable       = .F.
11288:             loc_oGrid.Column1.Header1.Caption = "Servi" + CHR(231) + "os"
11289:             loc_oGrid.Column1.Text1.Alignment  = 3
11290:             loc_oGrid.Column1.Text1.BorderStyle = 0
11291:             loc_oGrid.Column1.Text1.Margin     = 0
11292:             BINDEVENT(loc_oGrid.Column1.Text1, "When",  THIS, "GrdServicoCol1When")
11293:             BINDEVENT(loc_oGrid.Column1.Text1, "Valid",  THIS, "GrdServicoCol1Valid")
11294: 
11295:             *-- Column2: Cods/Codigo Servico (ColumnOrder=3, somente leitura)
11296:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdServico.Cods"
11297:             loc_oGrid.Column2.Width           = 50
11298:             loc_oGrid.Column2.ColumnOrder     = 3
11299:             loc_oGrid.Column2.Movable         = .F.
11300:             loc_oGrid.Column2.Resizable       = .F.
11301:             loc_oGrid.Column2.ReadOnly        = .T.
11302:             loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
11303:             loc_oGrid.Column2.Text1.BorderStyle = 0
11304:             loc_oGrid.Column2.Text1.Margin     = 0
11305:             loc_oGrid.Column2.Text1.ReadOnly   = .T.
11306: 
11307:             *-- Column3: Marcas/CheckBox (ColumnOrder=1 - primeira coluna visualmente)
11308:             *-- Sparse=.F. obrigatorio para CheckBox funcionar em coluna de grid
11309:             *-- When: editavel em INCLUIR/ALTERAR
11310:             *-- KeyPress: Space(32) ou Enter(13) togla Marcas (0->1, 1->0)
11311:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdServico.Marcas"
11312:             loc_oGrid.Column3.Width           = 17
11313:             loc_oGrid.Column3.ColumnOrder     = 1
11314:             loc_oGrid.Column3.Movable         = .F.
11315:             loc_oGrid.Column3.Resizable       = .F.
11316:             loc_oGrid.Column3.Sparse          = .F.
11317:             loc_oGrid.Column3.Header1.Caption = ""
11318:             loc_oGrid.Column3.AddObject("Check1", "CheckBox")
11319:             WITH loc_oGrid.Column3.Check1
11320:                 .Caption   = ""
11321:                 .Alignment = 0
11322:                 .ReadOnly  = .F.
11323:                 .Visible   = .T.
11324:                 .Top       = 9
11325:                 .Left      = 2
11326:                 .Height    = 17

*-- Linhas 11350 a 11390:
11350: 
11351:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page8
11352: 
11353:             *-- Carregar todos os servicos com Marcas=0/1 via LEFT JOIN em SigSerPr
11354:             IF USED("cursor_4c_GrdServico")
11355:                 USE IN cursor_4c_GrdServico
11356:             ENDIF
11357:             loc_nRet = SQLEXEC(gnConnHandle, ;
11358:                 "SELECT CASE WHEN s.cods IS NOT NULL THEN 1 ELSE 0 END AS Marcas," + ;
11359:                 " p.cods, p.descs, p.qtdias" + ;
11360:                 " FROM SigPrSer p" + ;
11361:                 " LEFT JOIN SigSerPr s ON s.cods = p.cods AND s.cpros = " + EscaparSQL(loc_cCpros) + ;
11362:                 " ORDER BY p.descs", ;
11363:                 "cursor_4c_GrdServico")
11364:             IF loc_nRet <= 0
11365:                 CREATE CURSOR cursor_4c_GrdServico (Marcas N(1,0), Cods C(3), Descs C(30), qtdias N(3,0))
11366:             ENDIF
11367: 
11368:             *-- Reassociar RecordSource e ControlSources apos recarregar cursor
11369:             IF PEMSTATUS(loc_oPg, "grd_4c_Dados", 5)
11370:                 loc_oGrid = loc_oPg.grd_4c_Dados
11371:                 loc_oGrid.ColumnCount = 3
11372:                 loc_oGrid.RecordSource          = "cursor_4c_GrdServico"
11373:                 loc_oGrid.Column1.ControlSource = "cursor_4c_GrdServico.Descs"
11374:                 loc_oGrid.Column2.ControlSource = "cursor_4c_GrdServico.Cods"
11375:                 loc_oGrid.Column3.ControlSource = "cursor_4c_GrdServico.Marcas"
11376:                 loc_oGrid.Refresh()
11377:             ENDIF
11378: 
11379:         CATCH TO loException
11380:             MostrarErro("Erro ao carregar Servi" + CHR(231) + "os:" + CHR(13) + ;
11381:                 loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
11382:                 "FormProduto.CarregarServicos")
11383:         ENDTRY
11384:     ENDPROC
11385: 
11386:     *===========================================================================
11387:     * Handlers de BINDEVENT para pgServico (Page8)
11388:     * Todos PUBLIC - requerido pelo BINDEVENT
11389:     *===========================================================================
11390: 

