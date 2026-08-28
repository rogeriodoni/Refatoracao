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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (11505 linhas total):

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
4558:             loc_oGradeGrupo.Column2.Header1.Caption = "Total "
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

*-- Linhas 6969 a 6996:
6969:                 loc_cValAtual = ALLTRIM(loc_oPg.&par_cCampoDestino..Value)
6970:             ENDIF
6971: 
6972:             loc_nRet = SQLEXEC(gnConnHandle, ;
6973:                 "SELECT cmoeds, dmoeds FROM SigCdMoe WHERE cmoeds LIKE " + ;
6974:                 EscaparSQL(ALLTRIM(loc_cValAtual) + "%") + " ORDER BY cmoeds", ;
6975:                 "cursor_4c_MoedaBusca")
6976: 
6977:             IF loc_nRet <= 0 OR !USED("cursor_4c_MoedaBusca") OR EOF("cursor_4c_MoedaBusca")
6978:                 IF USED("cursor_4c_MoedaBusca")
6979:                     USE IN cursor_4c_MoedaBusca
6980:                 ENDIF
6981:                 SQLEXEC(gnConnHandle, "SELECT cmoeds, dmoeds FROM SigCdMoe ORDER BY cmoeds", ;
6982:                     "cursor_4c_MoedaBusca")
6983:             ENDIF
6984: 
6985:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6986:             IF VARTYPE(loc_oBusca) = "O"
6987:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MoedaBusca"
6988:                 loc_oBusca.DefinirCursor("cursor_4c_MoedaBusca", "cmoeds", "dmoeds", "Buscar Moeda")
6989:                 loc_oBusca.Mostrar()
6990:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
6991:                     loc_oPg.&par_cCampoDestino..Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
6992:                 ENDIF
6993:                 loc_oBusca = .NULL.
6994:             ENDIF
6995: 
6996:             IF USED("cursor_4c_MoedaBusca")

*-- Linhas 7018 a 7045:
7018:                 loc_cValAtual = ALLTRIM(loc_oPg.&par_cCampoDestino..Value)
7019:             ENDIF
7020: 
7021:             loc_nRet = SQLEXEC(gnConnHandle, ;
7022:                 "SELECT cods, descs FROM SigPrFti WHERE cods LIKE '" + ;
7023:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", ;
7024:                 "cursor_4c_FeitioBusca")
7025: 
7026:             IF loc_nRet <= 0 OR !USED("cursor_4c_FeitioBusca") OR EOF("cursor_4c_FeitioBusca")
7027:                 IF USED("cursor_4c_FeitioBusca")
7028:                     USE IN cursor_4c_FeitioBusca
7029:                 ENDIF
7030:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigPrFti ORDER BY cods", ;
7031:                     "cursor_4c_FeitioBusca")
7032:             ENDIF
7033: 
7034:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
7035:             IF VARTYPE(loc_oBusca) = "O"
7036:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FeitioBusca"
7037:                 loc_oBusca.DefinirCursor("cursor_4c_FeitioBusca", "cods", "descs", "Buscar Feitio/MKP")
7038:                 loc_oBusca.Mostrar()
7039:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
7040:                     loc_oPg.&par_cCampoDestino..Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
7041:                 ENDIF
7042:                 loc_oBusca = .NULL.
7043:             ENDIF
7044: 
7045:             IF USED("cursor_4c_FeitioBusca")

*-- Linhas 7067 a 7094:
7067:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Status.Value)
7068:             ENDIF
7069: 
7070:             loc_nRet = SQLEXEC(gnConnHandle, ;
7071:                 "SELECT cods, descs FROM SigCdPst WHERE cods LIKE '" + ;
7072:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", ;
7073:                 "cursor_4c_StatusBusca")
7074: 
7075:             IF loc_nRet <= 0 OR !USED("cursor_4c_StatusBusca") OR EOF("cursor_4c_StatusBusca")
7076:                 IF USED("cursor_4c_StatusBusca")
7077:                     USE IN cursor_4c_StatusBusca
7078:                 ENDIF
7079:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdPst ORDER BY cods", ;
7080:                     "cursor_4c_StatusBusca")
7081:             ENDIF
7082: 
7083:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
7084:             IF VARTYPE(loc_oBusca) = "O"
7085:                 loc_oBusca.this_cCursorDestino = "cursor_4c_StatusBusca"
7086:                 loc_oBusca.DefinirCursor("cursor_4c_StatusBusca", "cods", "descs", "Buscar Status")
7087:                 loc_oBusca.Mostrar()
7088:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, "txt_4c_Status", 5)
7089:                     loc_oPg.txt_4c_Status.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
7090:                 ENDIF
7091:                 loc_oBusca = .NULL.
7092:             ENDIF
7093: 
7094:             IF USED("cursor_4c_StatusBusca")

*-- Linhas 7118 a 7143:
7118:             *-- Cursors placeholder (ANTES de RecordSource - REGRA CRITICA VFP9)
7119:             IF !USED("cursor_4c_GradFase")
7120:                 SET NULL ON
7121:                 CREATE CURSOR cursor_4c_GradFase ( ;
7122:                     cidchaves C(20), ordems N(2,0), grupos C(10), ;
7123:                     minutos   N(9,1), uniprdts C(10), matprdts C(15), obs M)
7124:                 SET NULL OFF
7125:             ENDIF
7126:             IF !USED("cursor_4c_GrdMatrizes")
7127:                 SET NULL ON
7128:                 CREATE CURSOR cursor_4c_GrdMatrizes ( ;
7129:                     cidchaves C(20), cmats C(14), qtds N(3,0), dpros C(65))
7130:                 SET NULL OFF
7131:             ENDIF
7132: 
7133:             *-- shp_4c_Fig: Shape moldura da figura do produto
7134:             *-- Original shpFig: top=129, left=231, width=244, height=148
7135:             loc_oPg.AddObject("shp_4c_Fig", "Shape")
7136:             WITH loc_oPg.shp_4c_Fig
7137:                 .Top           = 129
7138:                 .Left          = 231
7139:                 .Width         = 244
7140:                 .Height        = 148
7141:                 .BackStyle     = 0
7142:                 .BorderWidth   = 2
7143:                 .SpecialEffect = 0

*-- Linhas 7224 a 7296:
7224:                 .FontName          = "Tahoma"
7225:                 .FontSize          = 8
7226:                 .RecordMark        = .F.
7227:                 .DeleteMark        = .F.
7228:                 .HeaderHeight      = 20
7229:                 .RowHeight         = 18
7230:                 .ScrollBars        = 2
7231:                 .GridLines         = 3
7232:                 .GridLineColor     = RGB(238, 238, 238)
7233:                 .HighlightBackColor = RGB(255, 255, 255)
7234:                 .HighlightForeColor = RGB(15, 41, 104)
7235:                 .HighlightStyle    = 2
7236:                 .AllowHeaderSizing = .F.
7237:                 .AllowRowSizing    = .F.
7238:                 .Visible           = .T.
7239:             ENDWITH
7240:             loc_oPg.grd_4c_GradFase.ColumnCount  = 5
7241:             loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
7242:             loc_oGrid = loc_oPg.grd_4c_GradFase
7243: 
7244:             *-- Column1: Ordem (ordems N2,0) - width=45
7245:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GradFase.ordems"
7246:             loc_oGrid.Column1.Width           = 45
7247:             loc_oGrid.Column1.ReadOnly        = .F.
7248:             loc_oGrid.Column1.Movable         = .F.
7249:             loc_oGrid.Column1.Resizable       = .F.
7250:             loc_oGrid.Column1.Header1.Caption = "Ordem"
7251:             BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "GrdFaseCol1OrdValid")
7252: 
7253:             *-- Column2: Fase/Grupo (grupos C10) - lookup SigCdGcr, width=80
7254:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GradFase.grupos"
7255:             loc_oGrid.Column2.Width           = 80
7256:             loc_oGrid.Column2.ReadOnly        = .F.
7257:             loc_oGrid.Column2.Movable         = .F.
7258:             loc_oGrid.Column2.Resizable       = .F.
7259:             loc_oGrid.Column2.Header1.Caption = "Fase"
7260:             BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "GrdFaseCol2FaseValid")
7261: 
7262:             *-- Column3: Utilizacao (minutos N9,1) - width=70
7263:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GradFase.minutos"
7264:             loc_oGrid.Column3.Width           = 70
7265:             loc_oGrid.Column3.ReadOnly        = .F.
7266:             loc_oGrid.Column3.Movable         = .F.
7267:             loc_oGrid.Column3.Resizable       = .F.
7268:             loc_oGrid.Column3.InputMask       = "99,999.9"
7269:             loc_oGrid.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
7270: 
7271:             *-- Column4: Uni. Produtiva (uniprdts C10) - lookup SigCdUpd, width=84
7272:             loc_oGrid.Column4.ControlSource   = "cursor_4c_GradFase.uniprdts"
7273:             loc_oGrid.Column4.Width           = 84
7274:             loc_oGrid.Column4.ReadOnly        = .F.
7275:             loc_oGrid.Column4.Movable         = .F.
7276:             loc_oGrid.Column4.Resizable       = .F.
7277:             loc_oGrid.Column4.Header1.Caption = "Uni. Produtiva"
7278:             BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdFaseCol4UniPrdtValid")
7279: 
7280:             *-- Column5: Material (matprdts C15) - lookup SigOpOpt, width=115
7281:             loc_oGrid.Column5.ControlSource   = "cursor_4c_GradFase.matprdts"
7282:             loc_oGrid.Column5.Width           = 115
7283:             loc_oGrid.Column5.ReadOnly        = .F.
7284:             loc_oGrid.Column5.Movable         = .F.
7285:             loc_oGrid.Column5.Resizable       = .F.
7286:             loc_oGrid.Column5.Header1.Caption = "Material"
7287:             BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GrdFaseCol5MatPrdtValid")
7288: 
7289:             BINDEVENT(loc_oGrid, "BeforeRowColChange", THIS, "GrdFaseBeforeRowColChange")
7290:             BINDEVENT(loc_oGrid, "AfterRowColChange",  THIS, "GrdFaseAfterRowColChange")
7291: 
7292:             *-- cmd_4c_InserirFase: Inserir fase na GradFase
7293:             *-- Original inserir: top=129, left=950, width=40, height=40
7294:             loc_oPg.AddObject("cmd_4c_InserirFase", "CommandButton")
7295:             WITH loc_oPg.cmd_4c_InserirFase
7296:                 .Top             = 129

*-- Linhas 7366 a 7384:
7366:             ENDWITH
7367: 
7368:             *-- txt_4c_QminFabs: Quantidade minima de fabricacao (getQmin)
7369:             *-- Original getQmin: top=129, left=137, width=80, height=23, ControlSource=crSigCdPro.qtminFabs
7370:             loc_oPg.AddObject("txt_4c_QminFabs", "TextBox")
7371:             WITH loc_oPg.txt_4c_QminFabs
7372:                 .Top           = 129
7373:                 .Left          = 137
7374:                 .Width         = 80
7375:                 .Height        = 23
7376:                 .FontName      = "Tahoma"
7377:                 .FontSize      = 8
7378:                 .InputMask     = "999,999.99"
7379:                 .MaxLength     = 10
7380:                 .SpecialEffect = 1
7381:                 .Value         = 0
7382:                 .Visible       = .T.
7383:             ENDWITH
7384: 

*-- Linhas 7399 a 7417:
7399:             ENDWITH
7400: 
7401:             *-- txt_4c_CodGarras: Codigo de garra (getCodGarras)
7402:             *-- Original getCodGarras: top=154, left=137, width=80, height=23, ControlSource=crSigCdPro.CodGarras
7403:             loc_oPg.AddObject("txt_4c_CodGarras", "TextBox")
7404:             WITH loc_oPg.txt_4c_CodGarras
7405:                 .Top           = 154
7406:                 .Left          = 137
7407:                 .Width         = 80
7408:                 .Height        = 23
7409:                 .FontName      = "Tahoma"
7410:                 .FontSize      = 8
7411:                 .MaxLength     = 10
7412:                 .SpecialEffect = 1
7413:                 .Value         = ""
7414:                 .Visible       = .T.
7415:             ENDWITH
7416: 
7417:             *-- lbl_4c_Say4: "Conquilha :"

*-- Linhas 7429 a 7447:
7429:             ENDWITH
7430: 
7431:             *-- txt_4c_Conquilhas: Conquilha (getConquilha)
7432:             *-- Original getConquilha: top=179, left=137, width=80, height=23, ControlSource=crSigCdPro.Conquilhas
7433:             loc_oPg.AddObject("txt_4c_Conquilhas", "TextBox")
7434:             WITH loc_oPg.txt_4c_Conquilhas
7435:                 .Top           = 179
7436:                 .Left          = 137
7437:                 .Width         = 80
7438:                 .Height        = 23
7439:                 .FontName      = "Tahoma"
7440:                 .FontSize      = 8
7441:                 .MaxLength     = 10
7442:                 .SpecialEffect = 1
7443:                 .Alignment     = 3
7444:                 .Value         = ""
7445:                 .Visible       = .T.
7446:             ENDWITH
7447:             BINDEVENT(loc_oPg.txt_4c_Conquilhas, "KeyPress", THIS, "ValidarConquilhaFaseP")

*-- Linhas 7463 a 7481:
7463:             ENDWITH
7464: 
7465:             *-- txt_4c_PesoBris: Peso Brilhante (getPesoBris)
7466:             *-- Original getPesoBris: top=204, left=137, width=80, height=23, ControlSource=crSigCdPro.PesoBris
7467:             loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
7468:             WITH loc_oPg.txt_4c_PesoBris
7469:                 .Top           = 204
7470:                 .Left          = 137
7471:                 .Width         = 80
7472:                 .Height        = 23
7473:                 .FontName      = "Tahoma"
7474:                 .FontSize      = 8
7475:                 .InputMask     = "99,999.999"
7476:                 .MaxLength     = 10
7477:                 .SpecialEffect = 1
7478:                 .Value         = 0
7479:                 .Visible       = .T.
7480:             ENDWITH
7481: 

*-- Linhas 7496 a 7514:
7496:             ENDWITH
7497: 
7498:             *-- txt_4c_PesoMetal: Peso Metal (getPesoMetal)
7499:             *-- Original getPesoMetal: top=229, left=137, width=80, height=23, ControlSource=crSigCdPro.PesoMetal
7500:             loc_oPg.AddObject("txt_4c_PesoMetal", "TextBox")
7501:             WITH loc_oPg.txt_4c_PesoMetal
7502:                 .Top           = 229
7503:                 .Left          = 137
7504:                 .Width         = 80
7505:                 .Height        = 23
7506:                 .FontName      = "Tahoma"
7507:                 .FontSize      = 8
7508:                 .InputMask     = "99,999.999"
7509:                 .MaxLength     = 10
7510:                 .SpecialEffect = 1
7511:                 .Value         = 0
7512:                 .Visible       = .T.
7513:             ENDWITH
7514: 

*-- Linhas 7529 a 7547:
7529:             ENDWITH
7530: 
7531:             *-- txt_4c_PesoPdrs: Peso de Pedras (getPesoPdrs)
7532:             *-- Original getPesoPdrs: top=254, left=137, width=80, height=23, ControlSource=crSigCdPro.PesoPdrs
7533:             loc_oPg.AddObject("txt_4c_PesoPdrs", "TextBox")
7534:             WITH loc_oPg.txt_4c_PesoPdrs
7535:                 .Top           = 254
7536:                 .Left          = 137
7537:                 .Width         = 80
7538:                 .Height        = 23
7539:                 .FontName      = "Tahoma"
7540:                 .FontSize      = 8
7541:                 .InputMask     = "99,999.999"
7542:                 .MaxLength     = 10
7543:                 .SpecialEffect = 1
7544:                 .Value         = 0
7545:                 .Visible       = .T.
7546:             ENDWITH
7547: 

*-- Linhas 7560 a 7595:
7560:             ENDWITH
7561: 
7562:             *-- txt_4c_CodCorsFP: Cor Padrao (getCor) - espelha Page1 CodCors
7563:             *-- Original getCor: top=279, left=137, width=38, ControlSource=crSigCdPro.CodCors
7564:             loc_oPg.AddObject("txt_4c_CodCorsFP", "TextBox")
7565:             WITH loc_oPg.txt_4c_CodCorsFP
7566:                 .Top           = 279
7567:                 .Left          = 137
7568:                 .Width         = 38
7569:                 .Height        = 23
7570:                 .FontName      = "Tahoma"
7571:                 .FontSize      = 8
7572:                 .MaxLength     = 4
7573:                 .SpecialEffect = 1
7574:                 .Value         = ""
7575:                 .Visible       = .T.
7576:             ENDWITH
7577:             BINDEVENT(loc_oPg.txt_4c_CodCorsFP, "KeyPress", THIS, "ValidarCorFaseP")
7578: 
7579:             *-- chk_4c_CravCera: Cravacao em Cera (opc_CravCera)
7580:             *-- Original opc_CravCera: top=283, left=180, ControlSource=crSigCdPro.CravCers
7581:             loc_oPg.AddObject("chk_4c_CravCera", "CheckBox")
7582:             WITH loc_oPg.chk_4c_CravCera
7583:                 .Caption       = "Crava" + CHR(231) + CHR(227) + "o em Cera"
7584:                 .Top           = 283
7585:                 .Left          = 180
7586:                 .FontName      = "Tahoma"
7587:                 .FontSize      = 8
7588:                 .BackStyle     = 0
7589:                 .AutoSize      = .T.
7590:                 .Alignment     = 0
7591:                 .Value         = 0
7592:                 .SpecialEffect = 1
7593:                 .ForeColor     = RGB(90, 90, 90)
7594:                 .Visible       = .T.
7595:             ENDWITH

*-- Linhas 7609 a 7644:
7609:             ENDWITH
7610: 
7611:             *-- txt_4c_CodTamsFP: Tamanho Padrao (getTam) - espelha Page1 CodTams
7612:             *-- Original getTam: top=304, left=137, width=38, ControlSource=crSigCdPro.CodTams
7613:             loc_oPg.AddObject("txt_4c_CodTamsFP", "TextBox")
7614:             WITH loc_oPg.txt_4c_CodTamsFP
7615:                 .Top           = 304
7616:                 .Left          = 137
7617:                 .Width         = 38
7618:                 .Height        = 23
7619:                 .FontName      = "Tahoma"
7620:                 .FontSize      = 8
7621:                 .MaxLength     = 4
7622:                 .SpecialEffect = 1
7623:                 .Value         = ""
7624:                 .Visible       = .T.
7625:             ENDWITH
7626:             BINDEVENT(loc_oPg.txt_4c_CodTamsFP, "KeyPress", THIS, "ValidarTamFaseP")
7627: 
7628:             *-- chk_4c_Varias: Peso Variavel (fwoption1)
7629:             *-- Original fwoption1: top=308, left=180, ControlSource=crSigCdPro.Varias
7630:             loc_oPg.AddObject("chk_4c_Varias", "CheckBox")
7631:             WITH loc_oPg.chk_4c_Varias
7632:                 .Caption       = "Peso Vari" + CHR(225) + "vel"
7633:                 .Top           = 308
7634:                 .Left          = 180
7635:                 .FontName      = "Tahoma"
7636:                 .FontSize      = 8
7637:                 .BackStyle     = 0
7638:                 .AutoSize      = .T.
7639:                 .Alignment     = 0
7640:                 .Value         = 0
7641:                 .SpecialEffect = 1
7642:                 .ForeColor     = RGB(90, 90, 90)
7643:                 .Visible       = .T.
7644:             ENDWITH

*-- Linhas 7661 a 7679:
7661:             ENDWITH
7662: 
7663:             *-- txt_4c_CodAcbsFP: Codigo de Acabamento (get_codacb)
7664:             *-- Original get_codacb: top=329, left=137, width=38, ControlSource=crSigCdPro.codAcbs
7665:             loc_oPg.AddObject("txt_4c_CodAcbsFP", "TextBox")
7666:             WITH loc_oPg.txt_4c_CodAcbsFP
7667:                 .Top           = 329
7668:                 .Left          = 137
7669:                 .Width         = 38
7670:                 .Height        = 23
7671:                 .FontName      = "Tahoma"
7672:                 .FontSize      = 8
7673:                 .MaxLength     = 3
7674:                 .SpecialEffect = 1
7675:                 .Value         = ""
7676:                 .Visible       = .T.
7677:             ENDWITH
7678:             BINDEVENT(loc_oPg.txt_4c_CodAcbsFP, "KeyPress", THIS, "ValidarAcabamentoFaseP")
7679: 

*-- Linhas 7710 a 7728:
7710:             ENDWITH
7711: 
7712:             *-- txt_4c_TEnts: Tempo de Entrega em Dias (getTEnts)
7713:             *-- Original getTEnts: top=355, left=137, width=31, height=23, ControlSource=crSigCdPro.tents
7714:             loc_oPg.AddObject("txt_4c_TEnts", "TextBox")
7715:             WITH loc_oPg.txt_4c_TEnts
7716:                 .Top           = 355
7717:                 .Left          = 137
7718:                 .Width         = 31
7719:                 .Height        = 23
7720:                 .FontName      = "Tahoma"
7721:                 .FontSize      = 8
7722:                 .InputMask     = "999"
7723:                 .MaxLength     = 10
7724:                 .SpecialEffect = 1
7725:                 .Value         = 0
7726:                 .Visible       = .T.
7727:             ENDWITH
7728: 

*-- Linhas 7759 a 7777:
7759:             ENDWITH
7760: 
7761:             *-- txt_4c_DiasGar: Dias de Garantia (getDiasGar)
7762:             *-- Original getDiasGar: top=380, left=137, width=31, height=23, ControlSource=crSigCdPro.DiasGar
7763:             loc_oPg.AddObject("txt_4c_DiasGar", "TextBox")
7764:             WITH loc_oPg.txt_4c_DiasGar
7765:                 .Top           = 380
7766:                 .Left          = 137
7767:                 .Width         = 31
7768:                 .Height        = 23
7769:                 .FontName      = "Tahoma"
7770:                 .FontSize      = 8
7771:                 .InputMask     = "999"
7772:                 .MaxLength     = 3
7773:                 .SpecialEffect = 1
7774:                 .Value         = 0
7775:                 .Visible       = .T.
7776:             ENDWITH
7777: 

*-- Linhas 7808 a 7826:
7808:             ENDWITH
7809: 
7810:             *-- txt_4c_Volumes: Numero de Volumes (fwget3)
7811:             *-- Original fwget3: top=405, left=137, width=31, height=23, ControlSource=crSigCdPro.volumes
7812:             loc_oPg.AddObject("txt_4c_Volumes", "TextBox")
7813:             WITH loc_oPg.txt_4c_Volumes
7814:                 .Top           = 405
7815:                 .Left          = 137
7816:                 .Width         = 31
7817:                 .Height        = 23
7818:                 .FontName      = "Tahoma"
7819:                 .FontSize      = 8
7820:                 .MaxLength     = 3
7821:                 .SpecialEffect = 1
7822:                 .Value         = 0
7823:                 .Visible       = .T.
7824:             ENDWITH
7825: 
7826:             *-- lbl_4c_Say21: "Lote Minimo :"

*-- Linhas 7840 a 7858:
7840:             ENDWITH
7841: 
7842:             *-- txt_4c_LtMinsV: Lote Minimo de Venda (getLtMinsV)
7843:             *-- Original getLtMinsV: top=430, left=137, width=80, height=23, ControlSource=crSigCdPro.ltminsv
7844:             loc_oPg.AddObject("txt_4c_LtMinsV", "TextBox")
7845:             WITH loc_oPg.txt_4c_LtMinsV
7846:                 .Top           = 430
7847:                 .Left          = 137
7848:                 .Width         = 80
7849:                 .Height        = 23
7850:                 .FontName      = "Tahoma"
7851:                 .FontSize      = 8
7852:                 .InputMask     = "999,999.99"
7853:                 .MaxLength     = 10
7854:                 .SpecialEffect = 1
7855:                 .Value         = 0
7856:                 .Visible       = .T.
7857:             ENDWITH
7858: 

*-- Linhas 7873 a 7933:
7873:             ENDWITH
7874: 
7875:             *-- txt_4c_DtUcp: Data da ultima compra (get_Dtucp) - somente leitura
7876:             *-- Original get_Dtucp: top=455, left=137, width=79, height=23, ControlSource=crSigCdPro.UltComps
7877:             loc_oPg.AddObject("txt_4c_DtUcp", "TextBox")
7878:             WITH loc_oPg.txt_4c_DtUcp
7879:                 .Top               = 455
7880:                 .Left              = 137
7881:                 .Width             = 79
7882:                 .Height            = 23
7883:                 .FontName          = "Tahoma"
7884:                 .FontSize          = 8
7885:                 .MaxLength         = 10
7886:                 .SpecialEffect     = 1
7887:                 .ReadOnly          = .T.
7888:                 .Value             = ""
7889:                 .BackColor         = RGB(240, 240, 240)
7890:                 .ForeColor         = RGB(0, 0, 0)
7891:                 .DisabledBackColor = RGB(224, 235, 235)
7892:                 .DisabledForeColor = RGB(36, 84, 155)
7893:                 .Visible           = .T.
7894:             ENDWITH
7895: 
7896:             *-- txt_4c_VUcp: Valor da ultima compra (Get_vucp) - somente leitura
7897:             *-- Original Get_vucp: top=455, left=217, width=97, height=23, ControlSource=crSigCdPro.vUltComps
7898:             loc_oPg.AddObject("txt_4c_VUcp", "TextBox")
7899:             WITH loc_oPg.txt_4c_VUcp
7900:                 .Top               = 455
7901:                 .Left              = 217
7902:                 .Width             = 97
7903:                 .Height            = 23
7904:                 .FontName          = "Tahoma"
7905:                 .FontSize          = 8
7906:                 .InputMask         = "99,999.99999"
7907:                 .SpecialEffect     = 1
7908:                 .ReadOnly          = .T.
7909:                 .Value             = 0
7910:                 .BackColor         = RGB(240, 240, 240)
7911:                 .ForeColor         = RGB(0, 0, 0)
7912:                 .DisabledBackColor = RGB(224, 235, 235)
7913:                 .DisabledForeColor = RGB(36, 84, 155)
7914:                 .Visible           = .T.
7915:             ENDWITH
7916: 
7917:             *-- txt_4c_MUcp: Moeda da ultima compra (Get_mucp) - somente leitura
7918:             *-- Original Get_mucp: top=455, left=315, width=31, height=23, ControlSource=crSigCdPro.MUltComps
7919:             loc_oPg.AddObject("txt_4c_MUcp", "TextBox")
7920:             WITH loc_oPg.txt_4c_MUcp
7921:                 .Top               = 455
7922:                 .Left              = 315
7923:                 .Width             = 31
7924:                 .Height            = 23
7925:                 .FontName          = "Tahoma"
7926:                 .FontSize          = 8
7927:                 .MaxLength         = 3
7928:                 .SpecialEffect     = 1
7929:                 .ReadOnly          = .T.
7930:                 .Value             = ""
7931:                 .BackColor         = RGB(240, 240, 240)
7932:                 .ForeColor         = RGB(0, 0, 0)
7933:                 .DisabledBackColor = RGB(224, 235, 235)

*-- Linhas 7952 a 7970:
7952:             ENDWITH
7953: 
7954:             *-- opt_4c_Prodvars: Variacao p/ e-commerce Sim/Nao (Fwoption2)
7955:             *-- Original Fwoption2: top=482, left=132, width=93, height=15, ControlSource=crSigCdPro.prodvars
7956:             loc_oPg.AddObject("opt_4c_Prodvars", "OptionGroup")
7957:             WITH loc_oPg.opt_4c_Prodvars
7958:                 .ButtonCount = 2
7959:                 .Value       = 1
7960:                 .Top         = 482
7961:                 .Left        = 132
7962:                 .Width       = 93
7963:                 .Height      = 15
7964:                 .BackStyle   = 0
7965:                 .BorderStyle = 0
7966:                 .Visible     = .T.
7967:                 .Option1.Caption   = "Sim"
7968:                 .Option1.FontName  = "Tahoma"
7969:                 .Option1.FontSize  = 8
7970:                 .Option1.BackStyle = 0

*-- Linhas 8008 a 8042:
8008:             ENDWITH
8009: 
8010:             *-- txt_4c_Desc: Descricao da fase selecionada (Get_Desc) - somente leitura
8011:             *-- Original Get_Desc: top=505, left=595, width=395, height=23, ControlSource=crSigCdGcr.descrs
8012:             loc_oPg.AddObject("txt_4c_Desc", "TextBox")
8013:             WITH loc_oPg.txt_4c_Desc
8014:                 .Top           = 505
8015:                 .Left          = 595
8016:                 .Width         = 395
8017:                 .Height        = 23
8018:                 .FontName      = "Tahoma"
8019:                 .FontSize      = 8
8020:                 .SpecialEffect = 1
8021:                 .ReadOnly      = .T.
8022:                 .Value         = ""
8023:                 .Visible       = .T.
8024:             ENDWITH
8025: 
8026:             *-- edt_4c_Obs: Observacoes da fase (Get_Obs - fwmemo)
8027:             *-- Original Get_Obs: top=531, left=527, width=463, height=92, ControlSource=crSigCdPrf.Obs
8028:             loc_oPg.AddObject("edt_4c_Obs", "EditBox")
8029:             WITH loc_oPg.edt_4c_Obs
8030:                 .Top           = 531
8031:                 .Left          = 527
8032:                 .Width         = 463
8033:                 .Height        = 92
8034:                 .FontName      = "Tahoma"
8035:                 .FontSize      = 8
8036:                 .SpecialEffect = 1
8037:                 .Value         = ""
8038:                 .Visible       = .T.
8039:             ENDWITH
8040: 
8041:             *--------------------------------------------------------------
8042:             *-- Area de Matrizes (grdMatrizes + shpBorracha + ImgBorracha)

*-- Linhas 8116 a 8170:
8116:                 .FontName          = "Tahoma"
8117:                 .FontSize          = 8
8118:                 .RecordMark        = .F.
8119:                 .DeleteMark        = .F.
8120:                 .HeaderHeight      = 20
8121:                 .RowHeight         = 18
8122:                 .ScrollBars        = 2
8123:                 .GridLines         = 3
8124:                 .GridLineColor     = RGB(238, 238, 238)
8125:                 .HighlightBackColor = RGB(255, 255, 255)
8126:                 .HighlightForeColor = RGB(15, 41, 104)
8127:                 .HighlightStyle    = 2
8128:                 .AllowHeaderSizing = .F.
8129:                 .AllowRowSizing    = .F.
8130:                 .Visible           = .T.
8131:             ENDWITH
8132:             loc_oPg.grd_4c_GrdMatrizes.ColumnCount  = 3
8133:             loc_oPg.grd_4c_GrdMatrizes.RecordSource = "cursor_4c_GrdMatrizes"
8134:             loc_oGrid2 = loc_oPg.grd_4c_GrdMatrizes
8135: 
8136:             *-- Column1: Matriz (cmats C14) - lookup, width=108
8137:             loc_oGrid2.Column1.ControlSource   = "cursor_4c_GrdMatrizes.cmats"
8138:             loc_oGrid2.Column1.Width           = 108
8139:             loc_oGrid2.Column1.ReadOnly        = .F.
8140:             loc_oGrid2.Column1.Movable         = .F.
8141:             loc_oGrid2.Column1.Resizable       = .F.
8142:             loc_oGrid2.Column1.Header1.Caption = "Matriz"
8143:             BINDEVENT(loc_oGrid2.Column1.Text1, "Valid", THIS, "GrdMatrizesCol1Valid")
8144: 
8145:             *-- Column2: Qtde (qtds N3,0) - width=34
8146:             loc_oGrid2.Column2.ControlSource   = "cursor_4c_GrdMatrizes.qtds"
8147:             loc_oGrid2.Column2.Width           = 34
8148:             loc_oGrid2.Column2.ReadOnly        = .F.
8149:             loc_oGrid2.Column2.Movable         = .F.
8150:             loc_oGrid2.Column2.Resizable       = .F.
8151:             loc_oGrid2.Column2.InputMask       = "9999"
8152:             loc_oGrid2.Column2.Header1.Caption = "Qtde"
8153: 
8154:             *-- Column3: Local (dpros C65) - somente leitura (descricao do produto matriz), width=80
8155:             loc_oGrid2.Column3.ControlSource   = "cursor_4c_GrdMatrizes.dpros"
8156:             loc_oGrid2.Column3.Width           = 80
8157:             loc_oGrid2.Column3.ReadOnly        = .T.
8158:             loc_oGrid2.Column3.Movable         = .F.
8159:             loc_oGrid2.Column3.Resizable       = .F.
8160:             loc_oGrid2.Column3.Header1.Caption = "Local"
8161: 
8162:             BINDEVENT(loc_oGrid2, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
8163: 
8164:         CATCH TO loc_oErro
8165:             MostrarErro("Erro ao configurar p" + CHR(225) + "gina Processos de Produ" + ;
8166:                 CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, ;
8167:                 "FormProduto.ConfigurarPgPgDadosFaseP")
8168:         ENDTRY
8169:     ENDPROC
8170: 

*-- Linhas 8185 a 8269:
8185:             IF USED("cursor_4c_GradFase")
8186:                 USE IN cursor_4c_GradFase
8187:             ENDIF
8188:             loc_nRet = SQLEXEC(gnConnHandle, ;
8189:                 "SELECT cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs" + ;
8190:                 " FROM SigCdPrf WHERE produtos = " + EscaparSQL(loc_cCpros) + ;
8191:                 " ORDER BY ordems", "cursor_4c_GradFase")
8192:             IF loc_nRet <= 0
8193:                 CREATE CURSOR cursor_4c_GradFase ( ;
8194:                     cidchaves C(20), ordems N(2,0), grupos C(10), ;
8195:                     minutos   N(9,1), uniprdts C(10), matprdts C(15), obs M)
8196:             ENDIF
8197:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8198:                 loc_oPg.grd_4c_GradFase.ColumnCount = 5
8199:                 loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8200:                 loc_oPg.grd_4c_GradFase.Column1.ControlSource = "cursor_4c_GradFase.ordems"
8201:                 loc_oPg.grd_4c_GradFase.Column2.ControlSource = "cursor_4c_GradFase.grupos"
8202:                 loc_oPg.grd_4c_GradFase.Column3.ControlSource = "cursor_4c_GradFase.minutos"
8203:                 loc_oPg.grd_4c_GradFase.Column4.ControlSource = "cursor_4c_GradFase.uniprdts"
8204:                 loc_oPg.grd_4c_GradFase.Column5.ControlSource = "cursor_4c_GradFase.matprdts"
8205:                 loc_oPg.grd_4c_GradFase.Column1.Header1.Caption = "Ordem"
8206:                 loc_oPg.grd_4c_GradFase.Column2.Header1.Caption = "Fase"
8207:                 loc_oPg.grd_4c_GradFase.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
8208:                 loc_oPg.grd_4c_GradFase.Column4.Header1.Caption = "Uni. Produtiva"
8209:                 loc_oPg.grd_4c_GradFase.Column5.Header1.Caption = "Material"
8210:                 loc_oPg.grd_4c_GradFase.Refresh()
8211:             ENDIF
8212: 
8213:             *-- Carregar grdMatrizes de SigPrMtz + SigCdPro (descricao do produto matriz)
8214:             IF USED("cursor_4c_GrdMatrizes")
8215:                 USE IN cursor_4c_GrdMatrizes
8216:             ENDIF
8217:             loc_nRet = SQLEXEC(gnConnHandle, ;
8218:                 "SELECT m.cidchaves, m.cmats, m.qtds, ISNULL(p.dpros,'') AS dpros" + ;
8219:                 " FROM SigPrMtz m LEFT JOIN SigCdPro p ON p.cpros = m.cmats" + ;
8220:                 " WHERE m.cpros = " + EscaparSQL(loc_cCpros) + ;
8221:                 " ORDER BY m.cmats", "cursor_4c_GrdMatrizes")
8222:             IF loc_nRet <= 0
8223:                 CREATE CURSOR cursor_4c_GrdMatrizes ( ;
8224:                     cidchaves C(20), cmats C(14), qtds N(3,0), dpros C(65))
8225:             ENDIF
8226:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
8227:                 loc_oPg.grd_4c_GrdMatrizes.ColumnCount = 3
8228:                 loc_oPg.grd_4c_GrdMatrizes.RecordSource = "cursor_4c_GrdMatrizes"
8229:                 loc_oPg.grd_4c_GrdMatrizes.Column1.ControlSource = "cursor_4c_GrdMatrizes.cmats"
8230:                 loc_oPg.grd_4c_GrdMatrizes.Column2.ControlSource = "cursor_4c_GrdMatrizes.qtds"
8231:                 loc_oPg.grd_4c_GrdMatrizes.Column3.ControlSource = "cursor_4c_GrdMatrizes.dpros"
8232:                 loc_oPg.grd_4c_GrdMatrizes.Column1.Header1.Caption = "Matriz"
8233:                 loc_oPg.grd_4c_GrdMatrizes.Column2.Header1.Caption = "Qtde"
8234:                 loc_oPg.grd_4c_GrdMatrizes.Column3.Header1.Caption = "Local"
8235:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
8236:             ENDIF
8237: 
8238:         CATCH TO loException
8239:             MostrarErro("Erro ao carregar FaseP:" + CHR(13) + loException.Message + ;
8240:                 CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
8241:                 "FormProduto.CarregarFaseP")
8242:         ENDTRY
8243:     ENDPROC
8244: 
8245:     *===========================================================================
8246:     * GrdFaseBeforeRowColChange - Persiste obs do EditBox no cursor antes de mudar linha
8247:     * PUBLIC: BINDEVENT requer metodo publico
8248:     *===========================================================================
8249:     PROCEDURE GrdFaseBeforeRowColChange(par_nColIndex)
8250:         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
8251:             LOCAL loc_oPgBC
8252:             loc_oPgBC = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8253:             IF PEMSTATUS(loc_oPgBC, "edt_4c_Obs", 5)
8254:                 SELECT cursor_4c_GradFase
8255:                 REPLACE cursor_4c_GradFase.obs WITH loc_oPgBC.edt_4c_Obs.Value
8256:             ENDIF
8257:         ENDIF
8258:     ENDPROC
8259: 
8260:     *===========================================================================
8261:     * GrdFaseAfterRowColChange - Exibe imagem da fase e atualiza descricao
8262:     * PUBLIC: BINDEVENT requer metodo publico
8263:     *===========================================================================
8264:     PROCEDURE GrdFaseAfterRowColChange(par_nColIndex)
8265:         LOCAL loc_oPg, loc_lcArquivo, loc_nRet, loException
8266:         TRY
8267:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8268:             IF !PEMSTATUS(loc_oPg, "img_4c_ImgFig", 5) OR !USED("cursor_4c_GradFase")
8269:                 RETURN

*-- Linhas 8277 a 8325:
8277: 
8278:             IF !EOF("cursor_4c_GradFase") AND !BOF("cursor_4c_GradFase")
8279:                 LOCAL loc_cGrupos, loc_cCidchaves
8280:                 SELECT cursor_4c_GradFase
8281:                 loc_cGrupos    = ALLTRIM(cursor_4c_GradFase.grupos)
8282:                 loc_cCidchaves = ALLTRIM(cursor_4c_GradFase.cidchaves)
8283: 
8284:                 *-- Carregar descricao do grupo/fase (SigCdGcr)
8285:                 IF !EMPTY(loc_cGrupos)
8286:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8287:                         "SELECT descrs FROM SigCdGcr WHERE codigos = '" + ;
8288:                         EscaparSQL(loc_cGrupos) + "", "cursor_4c_FaseGcrDesc")
8289:                     IF loc_nRet > 0 AND USED("cursor_4c_FaseGcrDesc") AND !EOF("cursor_4c_FaseGcrDesc")
8290:                         SELECT cursor_4c_FaseGcrDesc
8291:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_FaseGcrDesc.descrs)
8292:                     ENDIF
8293:                     IF USED("cursor_4c_FaseGcrDesc")
8294:                         USE IN cursor_4c_FaseGcrDesc
8295:                     ENDIF
8296:                 ENDIF
8297: 
8298:                 *-- Obs vem do cursor (ja carregado em CarregarFaseP / gravado por BeforeRowColChange)
8299:                 SELECT cursor_4c_GradFase
8300:                 IF !ISNULL(cursor_4c_GradFase.obs)
8301:                     loc_oPg.edt_4c_Obs.Value = cursor_4c_GradFase.obs
8302:                 ENDIF
8303: 
8304:                 *-- Figura carregada do banco (campo figprocs - binario nao armazenado no cursor)
8305:                 IF !EMPTY(loc_cCidchaves)
8306:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8307:                         "SELECT figprocs FROM SigCdPrf WHERE cidchaves = '" + ;
8308:                         EscaparSQL(loc_cCidchaves) + "", "cursor_4c_FasePrfFig")
8309:                     IF loc_nRet > 0 AND USED("cursor_4c_FasePrfFig") AND !EOF("cursor_4c_FasePrfFig")
8310:                         SELECT cursor_4c_FasePrfFig
8311:                         IF !ISNULL(cursor_4c_FasePrfFig.figprocs) AND ;
8312:                                 !EMPTY(cursor_4c_FasePrfFig.figprocs)
8313:                             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
8314:                             IF STRTOFILE(cursor_4c_FasePrfFig.figprocs, loc_lcArquivo) > 0
8315:                                 loc_oPg.img_4c_ImgFig.Visible = .T.
8316:                                 loc_oPg.img_4c_ImgFig.Picture = loc_lcArquivo
8317:                             ENDIF
8318:                         ENDIF
8319:                     ENDIF
8320:                     IF USED("cursor_4c_FasePrfFig")
8321:                         USE IN cursor_4c_FasePrfFig
8322:                     ENDIF
8323:                 ENDIF
8324:             ENDIF
8325: 

*-- Linhas 8335 a 8411:
8335:     *===========================================================================
8336:     PROCEDURE GrdFaseCol1OrdValid()
8337:         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
8338:             SELECT cursor_4c_GradFase
8339:             IF cursor_4c_GradFase.ordems <= 0
8340:                 MsgAviso("Ordem deve ser maior que zero.", "Fase")
8341:                 RETURN .F.
8342:             ENDIF
8343:         ENDIF
8344:         RETURN .T.
8345:     ENDPROC
8346: 
8347:     *===========================================================================
8348:     * GrdFaseCol2FaseValid - Lookup de fase/grupo (SigCdGcr) na GradFase
8349:     * PUBLIC: BINDEVENT requer metodo publico
8350:     *===========================================================================
8351:     PROCEDURE GrdFaseCol2FaseValid()
8352:         LOCAL loc_cValAtual, loc_nRet, loc_oBusca, loException
8353:         TRY
8354:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8355:                 loc_lResultado = .T.
8356:             ENDIF
8357:             SELECT cursor_4c_GradFase
8358:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.grupos)
8359:             IF EMPTY(loc_cValAtual)
8360:                 loc_lResultado = .T.
8361:             ENDIF
8362: 
8363:             loc_nRet = SQLEXEC(gnConnHandle, ;
8364:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = '" + ;
8365:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_FaseGcrBusca")
8366:             IF loc_nRet > 0 AND USED("cursor_4c_FaseGcrBusca") AND !EOF("cursor_4c_FaseGcrBusca")
8367:                 IF USED("cursor_4c_FaseGcrBusca")
8368:                     USE IN cursor_4c_FaseGcrBusca
8369:                 ENDIF
8370:                 loc_lResultado = .T.
8371:             ENDIF
8372:             IF USED("cursor_4c_FaseGcrBusca")
8373:                 USE IN cursor_4c_FaseGcrBusca
8374:             ENDIF
8375: 
8376:             *-- Codigo nao encontrado: abrir busca
8377:             loc_nRet = SQLEXEC(gnConnHandle, ;
8378:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos LIKE '" + ;
8379:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY codigos", "cursor_4c_FaseGcrBusca")
8380:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseGcrBusca") OR EOF("cursor_4c_FaseGcrBusca")
8381:                 IF USED("cursor_4c_FaseGcrBusca")
8382:                     USE IN cursor_4c_FaseGcrBusca
8383:                 ENDIF
8384:                 SQLEXEC(gnConnHandle, ;
8385:                     "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos", ;
8386:                     "cursor_4c_FaseGcrBusca")
8387:             ENDIF
8388: 
8389:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8390:             IF VARTYPE(loc_oBusca) = "O"
8391:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FaseGcrBusca"
8392:                 loc_oBusca.DefinirCursor("cursor_4c_FaseGcrBusca", "codigos", "descrs", ;
8393:                     "Selecionar Fase/Grupo")
8394:                 loc_oBusca.Mostrar()
8395:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8396:                     SELECT cursor_4c_GradFase
8397:                     REPLACE cursor_4c_GradFase.grupos WITH loc_oBusca.cCodigoSelecionado
8398:                 ENDIF
8399:                 loc_oBusca = .NULL.
8400:             ENDIF
8401: 
8402:             IF USED("cursor_4c_FaseGcrBusca")
8403:                 USE IN cursor_4c_FaseGcrBusca
8404:             ENDIF
8405: 
8406:         CATCH TO loException
8407:             IF USED("cursor_4c_FaseGcrBusca")
8408:                 USE IN cursor_4c_FaseGcrBusca
8409:             ENDIF
8410:             MostrarErro("Erro ao validar fase:" + CHR(13) + loException.Message, ;
8411:                 "FormProduto.GrdFaseCol2FaseValid")

*-- Linhas 8423 a 8482:
8423:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8424:                 loc_lResultado = .T.
8425:             ENDIF
8426:             SELECT cursor_4c_GradFase
8427:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.uniprdts)
8428:             loc_cGrupos   = ALLTRIM(cursor_4c_GradFase.grupos)
8429:             IF EMPTY(loc_cValAtual)
8430:                 loc_lResultado = .T.
8431:             ENDIF
8432: 
8433:             loc_nRet = SQLEXEC(gnConnHandle, ;
8434:                 "SELECT uniprdts FROM SigCdUpd WHERE codigos = " + ;
8435:                 EscaparSQL(loc_cGrupos) + " AND uniprdts = " + ;
8436:                 EscaparSQL(loc_cValAtual), "cursor_4c_FaseUpdBusca")
8437:             IF loc_nRet > 0 AND USED("cursor_4c_FaseUpdBusca") AND !EOF("cursor_4c_FaseUpdBusca")
8438:                 IF USED("cursor_4c_FaseUpdBusca")
8439:                     USE IN cursor_4c_FaseUpdBusca
8440:                 ENDIF
8441:                 loc_lResultado = .T.
8442:             ENDIF
8443:             IF USED("cursor_4c_FaseUpdBusca")
8444:                 USE IN cursor_4c_FaseUpdBusca
8445:             ENDIF
8446: 
8447:             *-- Abrir busca das unidades produtivas para este grupo
8448:             loc_nRet = SQLEXEC(gnConnHandle, ;
8449:                 "SELECT uniprdts FROM SigCdUpd WHERE codigos = " + ;
8450:                 EscaparSQL(loc_cGrupos) + " ORDER BY uniprdts", "cursor_4c_FaseUpdBusca")
8451:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseUpdBusca") OR EOF("cursor_4c_FaseUpdBusca")
8452:                 IF USED("cursor_4c_FaseUpdBusca")
8453:                     USE IN cursor_4c_FaseUpdBusca
8454:                 ENDIF
8455:                 SQLEXEC(gnConnHandle, ;
8456:                     "SELECT DISTINCT uniprdts FROM SigCdUpd ORDER BY uniprdts", ;
8457:                     "cursor_4c_FaseUpdBusca")
8458:             ENDIF
8459: 
8460:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8461:             IF VARTYPE(loc_oBusca) = "O"
8462:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FaseUpdBusca"
8463:                 loc_oBusca.DefinirCursor("cursor_4c_FaseUpdBusca", "uniprdts", "uniprdts", ;
8464:                     "Selecionar Uni. Produtiva")
8465:                 loc_oBusca.Mostrar()
8466:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8467:                     SELECT cursor_4c_GradFase
8468:                     REPLACE cursor_4c_GradFase.uniprdts WITH loc_oBusca.cCodigoSelecionado
8469:                 ENDIF
8470:                 loc_oBusca = .NULL.
8471:             ENDIF
8472: 
8473:             IF USED("cursor_4c_FaseUpdBusca")
8474:                 USE IN cursor_4c_FaseUpdBusca
8475:             ENDIF
8476: 
8477:         CATCH TO loException
8478:             IF USED("cursor_4c_FaseUpdBusca")
8479:                 USE IN cursor_4c_FaseUpdBusca
8480:             ENDIF
8481:             MostrarErro("Erro ao validar uni. produtiva:" + CHR(13) + loException.Message, ;
8482:                 "FormProduto.GrdFaseCol4UniPrdtValid")

*-- Linhas 8494 a 8553:
8494:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8495:                 loc_lResultado = .T.
8496:             ENDIF
8497:             SELECT cursor_4c_GradFase
8498:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.matprdts)
8499:             loc_cGrupos   = ALLTRIM(cursor_4c_GradFase.grupos)
8500:             IF EMPTY(loc_cValAtual)
8501:                 loc_lResultado = .T.
8502:             ENDIF
8503: 
8504:             loc_nRet = SQLEXEC(gnConnHandle, ;
8505:                 "SELECT cods, descs FROM SigOpOpt WHERE cods = '" + ;
8506:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_FaseOptBusca")
8507:             IF loc_nRet > 0 AND USED("cursor_4c_FaseOptBusca") AND !EOF("cursor_4c_FaseOptBusca")
8508:                 IF USED("cursor_4c_FaseOptBusca")
8509:                     USE IN cursor_4c_FaseOptBusca
8510:                 ENDIF
8511:                 loc_lResultado = .T.
8512:             ENDIF
8513:             IF USED("cursor_4c_FaseOptBusca")
8514:                 USE IN cursor_4c_FaseOptBusca
8515:             ENDIF
8516: 
8517:             *-- Abrir busca filtrando pelo grupo da fase
8518:             loc_nRet = SQLEXEC(gnConnHandle, ;
8519:                 "SELECT cods, descs FROM SigOpOpt WHERE grupos = '" + ;
8520:                 EscaparSQL(loc_cGrupos) + " AND cods LIKE '" + ;
8521:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_FaseOptBusca")
8522:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseOptBusca") OR EOF("cursor_4c_FaseOptBusca")
8523:                 IF USED("cursor_4c_FaseOptBusca")
8524:                     USE IN cursor_4c_FaseOptBusca
8525:                 ENDIF
8526:                 SQLEXEC(gnConnHandle, ;
8527:                     "SELECT cods, descs FROM SigOpOpt ORDER BY cods", ;
8528:                     "cursor_4c_FaseOptBusca")
8529:             ENDIF
8530: 
8531:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8532:             IF VARTYPE(loc_oBusca) = "O"
8533:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FaseOptBusca"
8534:                 loc_oBusca.DefinirCursor("cursor_4c_FaseOptBusca", "cods", "descs", ;
8535:                     "Selecionar Material")
8536:                 loc_oBusca.Mostrar()
8537:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8538:                     SELECT cursor_4c_GradFase
8539:                     REPLACE cursor_4c_GradFase.matprdts WITH loc_oBusca.cCodigoSelecionado
8540:                 ENDIF
8541:                 loc_oBusca = .NULL.
8542:             ENDIF
8543: 
8544:             IF USED("cursor_4c_FaseOptBusca")
8545:                 USE IN cursor_4c_FaseOptBusca
8546:             ENDIF
8547: 
8548:         CATCH TO loException
8549:             IF USED("cursor_4c_FaseOptBusca")
8550:                 USE IN cursor_4c_FaseOptBusca
8551:             ENDIF
8552:             MostrarErro("Erro ao validar material:" + CHR(13) + loException.Message, ;
8553:                 "FormProduto.GrdFaseCol5MatPrdtValid")

*-- Linhas 8570 a 8597:
8570:                 RETURN
8571:             ENDIF
8572: 
8573:             SELECT cursor_4c_GradFase
8574:             IF EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase") OR ;
8575:                     RECCOUNT("cursor_4c_GradFase") = 0
8576:                 loc_nProxOrdem = 1
8577:             ELSE
8578:                 GO BOTTOM IN cursor_4c_GradFase
8579:                 loc_nProxOrdem = cursor_4c_GradFase.ordems + 1
8580:             ENDIF
8581: 
8582:             INSERT INTO cursor_4c_GradFase (cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs) ;
8583:                 VALUES (SYS(2015), loc_nProxOrdem, "", 0, "", "", "")
8584: 
8585:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8586:                 loc_oPg.grd_4c_GradFase.Refresh()
8587:                 GO BOTTOM IN cursor_4c_GradFase
8588:                 loc_oPg.grd_4c_GradFase.Column2.SetFocus()
8589:             ENDIF
8590: 
8591:         CATCH TO loException
8592:             MostrarErro("Erro ao inserir fase:" + CHR(13) + loException.Message, ;
8593:                 "FormProduto.BtnInserirFaseClick")
8594:         ENDTRY
8595:     ENDPROC
8596: 
8597:     *===========================================================================

*-- Linhas 8608 a 8630:
8608:                 RETURN
8609:             ENDIF
8610: 
8611:             SELECT cursor_4c_GradFase
8612:             IF !MsgConfirma("Excluir esta fase de produ" + CHR(231) + CHR(227) + "o?")
8613:                 RETURN
8614:             ENDIF
8615:             DELETE IN cursor_4c_GradFase
8616:             IF !EOF("cursor_4c_GradFase")
8617:                 SKIP IN cursor_4c_GradFase
8618:             ENDIF
8619:             IF EOF("cursor_4c_GradFase") AND RECCOUNT("cursor_4c_GradFase") > 0
8620:                 GO BOTTOM IN cursor_4c_GradFase
8621:             ENDIF
8622: 
8623:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8624:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8625:                 loc_oPg.grd_4c_GradFase.Refresh()
8626:             ENDIF
8627: 
8628:         CATCH TO loException
8629:             MostrarErro("Erro ao excluir fase:" + CHR(13) + loException.Message, ;
8630:                 "FormProduto.BtnExcluirFaseClick")

*-- Linhas 8646 a 8672:
8646:                 RETURN
8647:             ENDIF
8648: 
8649:             SELECT cursor_4c_GradFase
8650:             IF EOF("cursor_4c_GradFase") OR RECCOUNT("cursor_4c_GradFase") = 0
8651:                 loc_nOrdemAtual = 0
8652:             ELSE
8653:                 loc_nOrdemAtual = cursor_4c_GradFase.ordems
8654:             ENDIF
8655:             loc_nProxOrdem = loc_nOrdemAtual + 1
8656: 
8657:             INSERT INTO cursor_4c_GradFase (cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs) ;
8658:                 VALUES (SYS(2015), loc_nProxOrdem, "", 0, "", "", "")
8659: 
8660:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8661:                 loc_oPg.grd_4c_GradFase.Refresh()
8662:                 GO BOTTOM IN cursor_4c_GradFase
8663:                 loc_oPg.grd_4c_GradFase.Column2.SetFocus()
8664:             ENDIF
8665: 
8666:         CATCH TO loException
8667:             MostrarErro("Erro ao inserir fase alternativa:" + CHR(13) + loException.Message, ;
8668:                 "FormProduto.BtnAlternativaFaseClick")
8669:         ENDTRY
8670:     ENDPROC
8671: 
8672:     *===========================================================================

*-- Linhas 8779 a 8818:
8779:                 loc_lResultado = .T.
8780:             ENDIF
8781: 
8782:             loc_nRet = SQLEXEC(gnConnHandle, ;
8783:                 "SELECT conquilhas FROM sigcdcnq WHERE conquilhas = " + ;
8784:                 EscaparSQL(loc_cValAtual), "cursor_4c_CnqBusca")
8785:             IF loc_nRet > 0 AND USED("cursor_4c_CnqBusca") AND !EOF("cursor_4c_CnqBusca")
8786:                 IF USED("cursor_4c_CnqBusca")
8787:                     USE IN cursor_4c_CnqBusca
8788:                 ENDIF
8789:                 loc_lResultado = .T.
8790:             ENDIF
8791:             IF USED("cursor_4c_CnqBusca")
8792:                 USE IN cursor_4c_CnqBusca
8793:             ENDIF
8794: 
8795:             loc_nRet = SQLEXEC(gnConnHandle, ;
8796:                 "SELECT DISTINCT conquilhas FROM sigcdcnq WHERE conquilhas LIKE " + ;
8797:                 EscaparSQL(ALLTRIM(loc_cValAtual) + "%") + " ORDER BY conquilhas", "cursor_4c_CnqBusca")
8798:             IF loc_nRet <= 0 OR !USED("cursor_4c_CnqBusca") OR EOF("cursor_4c_CnqBusca")
8799:                 IF USED("cursor_4c_CnqBusca")
8800:                     USE IN cursor_4c_CnqBusca
8801:                 ENDIF
8802:                 SQLEXEC(gnConnHandle, ;
8803:                     "SELECT DISTINCT conquilhas FROM sigcdcnq ORDER BY conquilhas", ;
8804:                     "cursor_4c_CnqBusca")
8805:             ENDIF
8806: 
8807:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8808:             IF VARTYPE(loc_oBusca) = "O"
8809:                 loc_oBusca.this_cCursorDestino = "cursor_4c_CnqBusca"
8810:                 loc_oBusca.DefinirCursor("cursor_4c_CnqBusca", "conquilhas", "conquilhas", ;
8811:                     "Selecionar Conquilha")
8812:                 loc_oBusca.Mostrar()
8813:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8814:                     loc_oPg.txt_4c_Conquilhas.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8815:                 ENDIF
8816:                 loc_oBusca = .NULL.
8817:             ENDIF
8818: 

*-- Linhas 8846 a 8890:
8846:                 loc_lResultado = .T.
8847:             ENDIF
8848: 
8849:             loc_nRet = SQLEXEC(gnConnHandle, ;
8850:                 "SELECT cods, descs FROM SigCdCor WHERE cods = '" + ;
8851:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_CorFPBusca")
8852:             IF loc_nRet > 0 AND USED("cursor_4c_CorFPBusca") AND !EOF("cursor_4c_CorFPBusca")
8853:                 IF USED("cursor_4c_CorFPBusca")
8854:                     USE IN cursor_4c_CorFPBusca
8855:                 ENDIF
8856:                 *-- Sincronizar com Page1
8857:                 LOCAL loc_oPg1
8858:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8859:                 IF PEMSTATUS(loc_oPg1, "txt_4c_CodCors", 5)
8860:                     loc_oPg1.txt_4c_CodCors.Value = loc_cValAtual
8861:                 ENDIF
8862:                 loc_lResultado = .T.
8863:             ENDIF
8864:             IF USED("cursor_4c_CorFPBusca")
8865:                 USE IN cursor_4c_CorFPBusca
8866:             ENDIF
8867: 
8868:             loc_nRet = SQLEXEC(gnConnHandle, ;
8869:                 "SELECT cods, descs FROM SigCdCor WHERE cods LIKE '" + ;
8870:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_CorFPBusca")
8871:             IF loc_nRet <= 0 OR !USED("cursor_4c_CorFPBusca") OR EOF("cursor_4c_CorFPBusca")
8872:                 IF USED("cursor_4c_CorFPBusca")
8873:                     USE IN cursor_4c_CorFPBusca
8874:                 ENDIF
8875:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdCor ORDER BY cods", ;
8876:                     "cursor_4c_CorFPBusca")
8877:             ENDIF
8878: 
8879:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8880:             IF VARTYPE(loc_oBusca) = "O"
8881:                 loc_oBusca.this_cCursorDestino = "cursor_4c_CorFPBusca"
8882:                 loc_oBusca.DefinirCursor("cursor_4c_CorFPBusca", "cods", "descs", ;
8883:                     "Selecionar Cor Padr" + CHR(227) + "o")
8884:                 loc_oBusca.Mostrar()
8885:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8886:                     loc_oPg.txt_4c_CodCorsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8887:                     LOCAL loc_oPg1b
8888:                     loc_oPg1b = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8889:                     IF PEMSTATUS(loc_oPg1b, "txt_4c_CodCors", 5)
8890:                         loc_oPg1b.txt_4c_CodCors.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)

*-- Linhas 8923 a 8966:
8923:                 loc_lResultado = .T.
8924:             ENDIF
8925: 
8926:             loc_nRet = SQLEXEC(gnConnHandle, ;
8927:                 "SELECT cods, descs FROM SigCdTam WHERE cods = '" + ;
8928:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_TamFPBusca")
8929:             IF loc_nRet > 0 AND USED("cursor_4c_TamFPBusca") AND !EOF("cursor_4c_TamFPBusca")
8930:                 IF USED("cursor_4c_TamFPBusca")
8931:                     USE IN cursor_4c_TamFPBusca
8932:                 ENDIF
8933:                 LOCAL loc_oPg1c
8934:                 loc_oPg1c = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8935:                 IF PEMSTATUS(loc_oPg1c, "txt_4c_CodTams", 5)
8936:                     loc_oPg1c.txt_4c_CodTams.Value = loc_cValAtual
8937:                 ENDIF
8938:                 loc_lResultado = .T.
8939:             ENDIF
8940:             IF USED("cursor_4c_TamFPBusca")
8941:                 USE IN cursor_4c_TamFPBusca
8942:             ENDIF
8943: 
8944:             loc_nRet = SQLEXEC(gnConnHandle, ;
8945:                 "SELECT cods, descs FROM SigCdTam WHERE cods LIKE '" + ;
8946:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_TamFPBusca")
8947:             IF loc_nRet <= 0 OR !USED("cursor_4c_TamFPBusca") OR EOF("cursor_4c_TamFPBusca")
8948:                 IF USED("cursor_4c_TamFPBusca")
8949:                     USE IN cursor_4c_TamFPBusca
8950:                 ENDIF
8951:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdTam ORDER BY cods", ;
8952:                     "cursor_4c_TamFPBusca")
8953:             ENDIF
8954: 
8955:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8956:             IF VARTYPE(loc_oBusca) = "O"
8957:                 loc_oBusca.this_cCursorDestino = "cursor_4c_TamFPBusca"
8958:                 loc_oBusca.DefinirCursor("cursor_4c_TamFPBusca", "cods", "descs", ;
8959:                     "Selecionar Tamanho Padr" + CHR(227) + "o")
8960:                 loc_oBusca.Mostrar()
8961:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8962:                     loc_oPg.txt_4c_CodTamsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8963:                     LOCAL loc_oPg1d
8964:                     loc_oPg1d = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8965:                     IF PEMSTATUS(loc_oPg1d, "txt_4c_CodTams", 5)
8966:                         loc_oPg1d.txt_4c_CodTams.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)

*-- Linhas 9000 a 9045:
9000:                 loc_lResultado = .T.
9001:             ENDIF
9002: 
9003:             loc_nRet = SQLEXEC(gnConnHandle, ;
9004:                 "SELECT cods, descrs FROM SigCdAca WHERE cods = '" + ;
9005:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_AcaFPBusca")
9006:             IF loc_nRet > 0 AND USED("cursor_4c_AcaFPBusca") AND !EOF("cursor_4c_AcaFPBusca")
9007:                 SELECT cursor_4c_AcaFPBusca
9008:                 loc_oPg.txt_4c_DacbFP.Value = ALLTRIM(cursor_4c_AcaFPBusca.descrs)
9009:                 IF USED("cursor_4c_AcaFPBusca")
9010:                     USE IN cursor_4c_AcaFPBusca
9011:                 ENDIF
9012:                 LOCAL loc_oPg1e
9013:                 loc_oPg1e = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9014:                 IF PEMSTATUS(loc_oPg1e, "txt_4c_CodAcbs", 5)
9015:                     loc_oPg1e.txt_4c_CodAcbs.Value = loc_cValAtual
9016:                 ENDIF
9017:                 loc_lResultado = .T.
9018:             ENDIF
9019:             IF USED("cursor_4c_AcaFPBusca")
9020:                 USE IN cursor_4c_AcaFPBusca
9021:             ENDIF
9022: 
9023:             loc_nRet = SQLEXEC(gnConnHandle, ;
9024:                 "SELECT cods, descrs FROM SigCdAca WHERE cods LIKE '" + ;
9025:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_AcaFPBusca")
9026:             IF loc_nRet <= 0 OR !USED("cursor_4c_AcaFPBusca") OR EOF("cursor_4c_AcaFPBusca")
9027:                 IF USED("cursor_4c_AcaFPBusca")
9028:                     USE IN cursor_4c_AcaFPBusca
9029:                 ENDIF
9030:                 SQLEXEC(gnConnHandle, "SELECT cods, descrs FROM SigCdAca ORDER BY cods", ;
9031:                     "cursor_4c_AcaFPBusca")
9032:             ENDIF
9033: 
9034:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
9035:             IF VARTYPE(loc_oBusca) = "O"
9036:                 loc_oBusca.this_cCursorDestino = "cursor_4c_AcaFPBusca"
9037:                 loc_oBusca.DefinirCursor("cursor_4c_AcaFPBusca", "cods", "descrs", ;
9038:                     "Selecionar Acabamento")
9039:                 loc_oBusca.Mostrar()
9040:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
9041:                     loc_oPg.txt_4c_CodAcbsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
9042:                     loc_oPg.txt_4c_DacbFP.Value    = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
9043:                     LOCAL loc_oPg1f
9044:                     loc_oPg1f = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9045:                     IF PEMSTATUS(loc_oPg1f, "txt_4c_CodAcbs", 5)

*-- Linhas 9073 a 9133:
9073:             IF !USED("cursor_4c_GrdMatrizes") OR EOF("cursor_4c_GrdMatrizes")
9074:                 loc_lResultado = .T.
9075:             ENDIF
9076:             SELECT cursor_4c_GrdMatrizes
9077:             loc_cValAtual = ALLTRIM(cursor_4c_GrdMatrizes.cmats)
9078:             IF EMPTY(loc_cValAtual)
9079:                 loc_lResultado = .T.
9080:             ENDIF
9081: 
9082:             loc_nRet = SQLEXEC(gnConnHandle, ;
9083:                 "SELECT cpros, dpros FROM SigCdPro WHERE cpros = '" + ;
9084:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_MtzPrBusca")
9085:             IF loc_nRet > 0 AND USED("cursor_4c_MtzPrBusca") AND !EOF("cursor_4c_MtzPrBusca")
9086:                 SELECT cursor_4c_MtzPrBusca
9087:                 SELECT cursor_4c_GrdMatrizes
9088:                 REPLACE cursor_4c_GrdMatrizes.dpros WITH ALLTRIM(cursor_4c_MtzPrBusca.dpros)
9089:                 IF USED("cursor_4c_MtzPrBusca")
9090:                     USE IN cursor_4c_MtzPrBusca
9091:                 ENDIF
9092:                 loc_lResultado = .T.
9093:             ENDIF
9094:             IF USED("cursor_4c_MtzPrBusca")
9095:                 USE IN cursor_4c_MtzPrBusca
9096:             ENDIF
9097: 
9098:             *-- Codigo nao encontrado: abrir busca
9099:             loc_nRet = SQLEXEC(gnConnHandle, ;
9100:                 "SELECT cpros, dpros FROM SigCdPro WHERE cpros LIKE '" + ;
9101:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cpros", "cursor_4c_MtzPrBusca")
9102:             IF loc_nRet <= 0 OR !USED("cursor_4c_MtzPrBusca") OR EOF("cursor_4c_MtzPrBusca")
9103:                 IF USED("cursor_4c_MtzPrBusca")
9104:                     USE IN cursor_4c_MtzPrBusca
9105:                 ENDIF
9106:                 SQLEXEC(gnConnHandle, ;
9107:                     "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros", ;
9108:                     "cursor_4c_MtzPrBusca")
9109:             ENDIF
9110: 
9111:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
9112:             IF VARTYPE(loc_oBusca) = "O"
9113:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MtzPrBusca"
9114:                 loc_oBusca.DefinirCursor("cursor_4c_MtzPrBusca", "cpros", "dpros", ;
9115:                     "Selecionar Produto Matriz")
9116:                 loc_oBusca.Mostrar()
9117:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdMatrizes")
9118:                     SELECT cursor_4c_GrdMatrizes
9119:                     REPLACE cursor_4c_GrdMatrizes.cmats WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
9120:                     REPLACE cursor_4c_GrdMatrizes.dpros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
9121:                 ENDIF
9122:                 loc_oBusca = .NULL.
9123:             ENDIF
9124: 
9125:             IF USED("cursor_4c_MtzPrBusca")
9126:                 USE IN cursor_4c_MtzPrBusca
9127:             ENDIF
9128: 
9129:         CATCH TO loException
9130:             IF USED("cursor_4c_MtzPrBusca")
9131:                 USE IN cursor_4c_MtzPrBusca
9132:             ENDIF
9133:             MostrarErro("Erro ao validar matriz:" + CHR(13) + loException.Message, ;

*-- Linhas 9153 a 9179:
9153:             loc_oPg.img_4c_ImgBorracha.Visible = .F.
9154: 
9155:             IF !EOF("cursor_4c_GrdMatrizes") AND !BOF("cursor_4c_GrdMatrizes")
9156:                 SELECT cursor_4c_GrdMatrizes
9157:                 LOCAL loc_cCmats
9158:                 loc_cCmats = ALLTRIM(cursor_4c_GrdMatrizes.cmats)
9159:                 IF !EMPTY(loc_cCmats)
9160:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9161:                         "SELECT figprocs FROM SigCdPro WHERE cpros = '" + ;
9162:                         EscaparSQL(loc_cCmats) + "", "cursor_4c_MtzImgPro")
9163:                     IF loc_nRet > 0 AND USED("cursor_4c_MtzImgPro") AND !EOF("cursor_4c_MtzImgPro")
9164:                         SELECT cursor_4c_MtzImgPro
9165:                         IF !ISNULL(cursor_4c_MtzImgPro.figprocs) AND ;
9166:                                 !EMPTY(cursor_4c_MtzImgPro.figprocs)
9167:                             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9168:                             IF STRTOFILE(cursor_4c_MtzImgPro.figprocs, loc_lcArquivo) > 0
9169:                                 loc_oPg.img_4c_ImgBorracha.Visible = .T.
9170:                                 loc_oPg.img_4c_ImgBorracha.Picture = loc_lcArquivo
9171:                             ENDIF
9172:                         ENDIF
9173:                     ENDIF
9174:                     IF USED("cursor_4c_MtzImgPro")
9175:                         USE IN cursor_4c_MtzImgPro
9176:                     ENDIF
9177:                 ENDIF
9178:             ENDIF
9179: 

*-- Linhas 9197 a 9215:
9197:                 RETURN
9198:             ENDIF
9199: 
9200:             INSERT INTO cursor_4c_GrdMatrizes (cidchaves, cmats, qtds, dpros) ;
9201:                 VALUES (SYS(2015), "", 0, "")
9202: 
9203:             GO BOTTOM IN cursor_4c_GrdMatrizes
9204: 
9205:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9206:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
9207:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
9208:                 loc_oPg.grd_4c_GrdMatrizes.Column1.SetFocus()
9209:             ENDIF
9210: 
9211:         CATCH TO loException
9212:             MostrarErro("Erro ao inserir matriz:" + CHR(13) + loException.Message, ;
9213:                 "FormProduto.BtnInserirMtzClick")
9214:         ENDTRY
9215:     ENDPROC

*-- Linhas 9228 a 9250:
9228:                 RETURN
9229:             ENDIF
9230: 
9231:             SELECT cursor_4c_GrdMatrizes
9232:             IF !MsgConfirma("Excluir este registro de matriz?")
9233:                 RETURN
9234:             ENDIF
9235:             DELETE IN cursor_4c_GrdMatrizes
9236:             IF !EOF("cursor_4c_GrdMatrizes")
9237:                 SKIP IN cursor_4c_GrdMatrizes
9238:             ENDIF
9239:             IF EOF("cursor_4c_GrdMatrizes") AND RECCOUNT("cursor_4c_GrdMatrizes") > 0
9240:                 GO BOTTOM IN cursor_4c_GrdMatrizes
9241:             ENDIF
9242: 
9243:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9244:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
9245:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
9246:             ENDIF
9247: 
9248:         CATCH TO loException
9249:             MostrarErro("Erro ao excluir matriz:" + CHR(13) + loException.Message, ;
9250:                 "FormProduto.BtnExcluirMtzClick")

*-- Linhas 9274 a 9293:
9274:                 ENDIF
9275:                 RETURN
9276:             ENDIF
9277:             loc_nRet = SQLEXEC(gnConnHandle, ;
9278:                 "SELECT codigos, descricaos FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cCod), ;
9279:                 "cursor_4c_ClfBusca")
9280:             IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca") AND !EOF("cursor_4c_ClfBusca")
9281:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9282:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.descricaos)
9283:                 ENDIF
9284:                 IF USED("cursor_4c_ClfBusca")
9285:                     USE IN cursor_4c_ClfBusca
9286:                 ENDIF
9287:             ELSE
9288:                 IF USED("cursor_4c_ClfBusca")
9289:                     USE IN cursor_4c_ClfBusca
9290:                 ENDIF
9291:                 THIS.AbrirBuscaClfiscal()
9292:             ENDIF
9293:         CATCH TO loException

*-- Linhas 9332 a 9352:
9332:                 THIS.AbrirBuscaClfiscal()
9333:                 RETURN
9334:             ENDIF
9335:             loc_nRet = SQLEXEC(gnConnHandle, ;
9336:                 "SELECT codigos, descricaos FROM SigCdClf WHERE descricaos LIKE " + ;
9337:                 EscaparSQL(loc_cDesc + "%"), ;
9338:                 "cursor_4c_ClfBusca")
9339:             IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca") AND !EOF("cursor_4c_ClfBusca")
9340:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9341:                     loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.codigos)
9342:                 ENDIF
9343:                 loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.descricaos)
9344:                 IF USED("cursor_4c_ClfBusca")
9345:                     USE IN cursor_4c_ClfBusca
9346:                 ENDIF
9347:             ELSE
9348:                 IF USED("cursor_4c_ClfBusca")
9349:                     USE IN cursor_4c_ClfBusca
9350:                 ENDIF
9351:                 THIS.AbrirBuscaClfiscal()
9352:             ENDIF

*-- Linhas 9383 a 9402:
9383:                 ENDIF
9384:                 RETURN
9385:             ENDIF
9386:             loc_nRet = SQLEXEC(gnConnHandle, ;
9387:                 "SELECT codigos, descricaos FROM SIGCDORG WHERE codigos = " + EscaparSQL(loc_cCod), ;
9388:                 "cursor_4c_OrgBusca")
9389:             IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca") AND !EOF("cursor_4c_OrgBusca")
9390:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9391:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgBusca.descricaos)
9392:                 ENDIF
9393:                 IF USED("cursor_4c_OrgBusca")
9394:                     USE IN cursor_4c_OrgBusca
9395:                 ENDIF
9396:             ELSE
9397:                 IF USED("cursor_4c_OrgBusca")
9398:                     USE IN cursor_4c_OrgBusca
9399:                 ENDIF
9400:                 THIS.AbrirBuscaOrigmerc()
9401:             ENDIF
9402:         CATCH TO loException

*-- Linhas 9441 a 9461:
9441:                 THIS.AbrirBuscaOrigmerc()
9442:                 RETURN
9443:             ENDIF
9444:             loc_nRet = SQLEXEC(gnConnHandle, ;
9445:                 "SELECT codigos, descricaos FROM SIGCDORG WHERE descricaos LIKE " + ;
9446:                 EscaparSQL(loc_cDesc + "%"), ;
9447:                 "cursor_4c_OrgBusca")
9448:             IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca") AND !EOF("cursor_4c_OrgBusca")
9449:                 IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9450:                     loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(cursor_4c_OrgBusca.codigos)
9451:                 ENDIF
9452:                 loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgBusca.descricaos)
9453:                 IF USED("cursor_4c_OrgBusca")
9454:                     USE IN cursor_4c_OrgBusca
9455:                 ENDIF
9456:             ELSE
9457:                 IF USED("cursor_4c_OrgBusca")
9458:                     USE IN cursor_4c_OrgBusca
9459:                 ENDIF
9460:                 THIS.AbrirBuscaOrigmerc()
9461:             ENDIF

*-- Linhas 9492 a 9511:
9492:                 ENDIF
9493:                 RETURN
9494:             ENDIF
9495:             loc_nRet = SQLEXEC(gnConnHandle, ;
9496:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
9497:                 "cursor_4c_IcmBusca")
9498:             IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca") AND !EOF("cursor_4c_IcmBusca")
9499:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9500:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmBusca.descricaos)
9501:                 ENDIF
9502:                 IF USED("cursor_4c_IcmBusca")
9503:                     USE IN cursor_4c_IcmBusca
9504:                 ENDIF
9505:             ELSE
9506:                 IF USED("cursor_4c_IcmBusca")
9507:                     USE IN cursor_4c_IcmBusca
9508:                 ENDIF
9509:                 THIS.AbrirBuscaSittricm()
9510:             ENDIF
9511:         CATCH TO loException

*-- Linhas 9550 a 9570:
9550:                 THIS.AbrirBuscaSittricm()
9551:                 RETURN
9552:             ENDIF
9553:             loc_nRet = SQLEXEC(gnConnHandle, ;
9554:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE descricaos LIKE " + ;
9555:                 EscaparSQL(loc_cDesc + "%"), ;
9556:                 "cursor_4c_IcmBusca")
9557:             IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca") AND !EOF("cursor_4c_IcmBusca")
9558:                 IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9559:                     loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_IcmBusca.codigos)
9560:                 ENDIF
9561:                 loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmBusca.descricaos)
9562:                 IF USED("cursor_4c_IcmBusca")
9563:                     USE IN cursor_4c_IcmBusca
9564:                 ENDIF
9565:             ELSE
9566:                 IF USED("cursor_4c_IcmBusca")
9567:                     USE IN cursor_4c_IcmBusca
9568:                 ENDIF
9569:                 THIS.AbrirBuscaSittricm()
9570:             ENDIF

*-- Linhas 9598 a 9617:
9598:             IF EMPTY(loc_cCod)
9599:                 RETURN
9600:             ENDIF
9601:             loc_nRet = SQLEXEC(gnConnHandle, ;
9602:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
9603:                 "cursor_4c_IcmServBusca")
9604:             IF loc_nRet > 0 AND USED("cursor_4c_IcmServBusca") AND !EOF("cursor_4c_IcmServBusca")
9605:                 IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9606:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(cursor_4c_IcmServBusca.codigos)
9607:                 ENDIF
9608:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9609:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmServBusca.descricaos)
9610:                 ENDIF
9611:                 IF USED("cursor_4c_IcmServBusca")
9612:                     USE IN cursor_4c_IcmServBusca
9613:                 ENDIF
9614:             ELSE
9615:                 IF USED("cursor_4c_IcmServBusca")
9616:                     USE IN cursor_4c_IcmServBusca
9617:                 ENDIF

*-- Linhas 9647 a 9666:
9647:             IF EMPTY(loc_cCod)
9648:                 RETURN
9649:             ENDIF
9650:             loc_nRet = SQLEXEC(gnConnHandle, ;
9651:                 "SELECT tipos, descs FROM SigPrTri WHERE tipos = " + EscaparSQL(loc_cCod), ;
9652:                 "cursor_4c_TpTribBusca")
9653:             IF loc_nRet > 0 AND USED("cursor_4c_TpTribBusca") AND !EOF("cursor_4c_TpTribBusca")
9654:                 IF USED("cursor_4c_TpTribBusca")
9655:                     USE IN cursor_4c_TpTribBusca
9656:                 ENDIF
9657:             ELSE
9658:                 IF USED("cursor_4c_TpTribBusca")
9659:                     USE IN cursor_4c_TpTribBusca
9660:                 ENDIF
9661:                 THIS.AbrirBuscaTpTrib()
9662:             ENDIF
9663:         CATCH TO loException
9664:             IF USED("cursor_4c_TpTribBusca")
9665:                 USE IN cursor_4c_TpTribBusca
9666:             ENDIF

*-- Linhas 9727 a 9746:
9727:             IF EMPTY(loc_cClf) OR loc_nAliq = 0
9728:                 RETURN
9729:             ENDIF
9730:             loc_nRet = SQLEXEC(gnConnHandle, ;
9731:                 "SELECT aipis FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cClf), ;
9732:                 "cursor_4c_ClfAliq")
9733:             IF loc_nRet > 0 AND USED("cursor_4c_ClfAliq") AND !EOF("cursor_4c_ClfAliq")
9734:                 loc_nAliqRef = cursor_4c_ClfAliq.aipis
9735:                 IF loc_nAliqRef > 0 AND ABS(loc_nAliq - loc_nAliqRef) > 0.001
9736:                     MsgAviso("Al" + CHR(237) + "quota IPI informada (" + ;
9737:                         TRANSFORM(loc_nAliq) + "%) difere da padr" + CHR(227) + ;
9738:                         "o da classifica" + CHR(231) + CHR(227) + "o fiscal (" + ;
9739:                         TRANSFORM(loc_nAliqRef) + "%).")
9740:                 ENDIF
9741:             ENDIF
9742:             IF USED("cursor_4c_ClfAliq")
9743:                 USE IN cursor_4c_ClfAliq
9744:             ENDIF
9745:         CATCH TO loException
9746:             IF USED("cursor_4c_ClfAliq")

*-- Linhas 9773 a 9792:
9773:             IF EMPTY(loc_cClf)
9774:                 loc_lResultado = .F.
9775:             ENDIF
9776:             loc_nRet = SQLEXEC(gnConnHandle, ;
9777:                 "SELECT ipiprods FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cClf), ;
9778:                 "cursor_4c_ClfIpiProd")
9779:             IF loc_nRet > 0 AND USED("cursor_4c_ClfIpiProd") AND !EOF("cursor_4c_ClfIpiProd")
9780:                 loc_lPermite = (ALLTRIM(cursor_4c_ClfIpiProd.ipiprods) = "S")
9781:             ENDIF
9782:             IF USED("cursor_4c_ClfIpiProd")
9783:                 USE IN cursor_4c_ClfIpiProd
9784:             ENDIF
9785:         CATCH TO loException
9786:             IF USED("cursor_4c_ClfIpiProd")
9787:                 USE IN cursor_4c_ClfIpiProd
9788:             ENDIF
9789:         ENDTRY
9790:         RETURN loc_lPermite
9791:     ENDPROC
9792: 

*-- Linhas 9840 a 9859:
9840:                 ENDIF
9841:                 RETURN
9842:             ENDIF
9843:             loc_nRet = SQLEXEC(gnConnHandle, ;
9844:                 "SELECT codigos, descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
9845:                 " AND tipos = 'M'", ;
9846:                 "cursor_4c_MetalBusca")
9847:             IF loc_nRet > 0 AND USED("cursor_4c_MetalBusca") AND !EOF("cursor_4c_MetalBusca")
9848:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
9849:                     loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(cursor_4c_MetalBusca.descs)
9850:                 ENDIF
9851:                 IF USED("cursor_4c_MetalBusca")
9852:                     USE IN cursor_4c_MetalBusca
9853:                 ENDIF
9854:             ELSE
9855:                 IF USED("cursor_4c_MetalBusca")
9856:                     USE IN cursor_4c_MetalBusca
9857:                 ENDIF
9858:                 THIS.AbrirBuscaMetal()
9859:             ENDIF

*-- Linhas 9890 a 9909:
9890:                 ENDIF
9891:                 RETURN
9892:             ENDIF
9893:             loc_nRet = SQLEXEC(gnConnHandle, ;
9894:                 "SELECT codigos, descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
9895:                 " AND tipos <> 'M'", ;
9896:                 "cursor_4c_TeorBusca")
9897:             IF loc_nRet > 0 AND USED("cursor_4c_TeorBusca") AND !EOF("cursor_4c_TeorBusca")
9898:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
9899:                     loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(cursor_4c_TeorBusca.descs)
9900:                 ENDIF
9901:                 IF USED("cursor_4c_TeorBusca")
9902:                     USE IN cursor_4c_TeorBusca
9903:                 ENDIF
9904:             ELSE
9905:                 IF USED("cursor_4c_TeorBusca")
9906:                     USE IN cursor_4c_TeorBusca
9907:                 ENDIF
9908:                 THIS.AbrirBuscaTeor()
9909:             ENDIF

*-- Linhas 9937 a 9956:
9937:             IF EMPTY(loc_cCod)
9938:                 RETURN
9939:             ENDIF
9940:             loc_nRet = SQLEXEC(gnConnHandle, ;
9941:                 "SELECT cmoeds, dmoeds FROM SigCdMoe WHERE cmoeds = " + EscaparSQL(loc_cCod), ;
9942:                 "cursor_4c_MoeFiscalBusca")
9943:             IF loc_nRet > 0 AND USED("cursor_4c_MoeFiscalBusca") AND !EOF("cursor_4c_MoeFiscalBusca")
9944:                 IF USED("cursor_4c_MoeFiscalBusca")
9945:                     USE IN cursor_4c_MoeFiscalBusca
9946:                 ENDIF
9947:             ELSE
9948:                 IF USED("cursor_4c_MoeFiscalBusca")
9949:                     USE IN cursor_4c_MoeFiscalBusca
9950:                 ENDIF
9951:                 THIS.AbrirBuscaMvalorFiscal()
9952:             ENDIF
9953:         CATCH TO loException
9954:             IF USED("cursor_4c_MoeFiscalBusca")
9955:                 USE IN cursor_4c_MoeFiscalBusca
9956:             ENDIF

*-- Linhas 10123 a 10150:
10123:             IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10124:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
10125:             ENDIF
10126:             loc_nRet = SQLEXEC(gnConnHandle, ;
10127:                 "SELECT codigos, descricaos FROM SigCdClf WHERE codigos LIKE " + ;
10128:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10129:                 "cursor_4c_ClfBusca")
10130:             IF loc_nRet <= 0 OR !USED("cursor_4c_ClfBusca") OR EOF("cursor_4c_ClfBusca")
10131:                 IF USED("cursor_4c_ClfBusca")
10132:                     USE IN cursor_4c_ClfBusca
10133:                 ENDIF
10134:                 SQLEXEC(gnConnHandle, ;
10135:                     "SELECT codigos, descricaos FROM SigCdClf ORDER BY codigos", ;
10136:                     "cursor_4c_ClfBusca")
10137:             ENDIF
10138:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10139:             IF VARTYPE(loc_oBusca) = "O"
10140:                 loc_oBusca.this_cCursorDestino = "cursor_4c_ClfBusca"
10141:                 loc_oBusca.DefinirCursor("cursor_4c_ClfBusca", "codigos", "descricaos", ;
10142:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
10143:                 loc_oBusca.Mostrar()
10144:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10145:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10146:                         loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10147:                     ENDIF
10148:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
10149:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10150:                     ENDIF

*-- Linhas 10172 a 10199:
10172:             IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
10173:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
10174:             ENDIF
10175:             loc_nRet = SQLEXEC(gnConnHandle, ;
10176:                 "SELECT codigos, descricaos FROM SIGCDORG WHERE codigos LIKE " + ;
10177:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10178:                 "cursor_4c_OrgBusca")
10179:             IF loc_nRet <= 0 OR !USED("cursor_4c_OrgBusca") OR EOF("cursor_4c_OrgBusca")
10180:                 IF USED("cursor_4c_OrgBusca")
10181:                     USE IN cursor_4c_OrgBusca
10182:                 ENDIF
10183:                 SQLEXEC(gnConnHandle, ;
10184:                     "SELECT codigos, descricaos FROM SIGCDORG ORDER BY codigos", ;
10185:                     "cursor_4c_OrgBusca")
10186:             ENDIF
10187:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10188:             IF VARTYPE(loc_oBusca) = "O"
10189:                 loc_oBusca.this_cCursorDestino = "cursor_4c_OrgBusca"
10190:                 loc_oBusca.DefinirCursor("cursor_4c_OrgBusca", "codigos", "descricaos", ;
10191:                     "Buscar Origem Mercadoria")
10192:                 loc_oBusca.Mostrar()
10193:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10194:                     IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
10195:                         loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10196:                     ENDIF
10197:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
10198:                         loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10199:                     ENDIF

*-- Linhas 10221 a 10248:
10221:             IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10222:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
10223:             ENDIF
10224:             loc_nRet = SQLEXEC(gnConnHandle, ;
10225:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos LIKE " + ;
10226:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10227:                 "cursor_4c_IcmBusca")
10228:             IF loc_nRet <= 0 OR !USED("cursor_4c_IcmBusca") OR EOF("cursor_4c_IcmBusca")
10229:                 IF USED("cursor_4c_IcmBusca")
10230:                     USE IN cursor_4c_IcmBusca
10231:                 ENDIF
10232:                 SQLEXEC(gnConnHandle, ;
10233:                     "SELECT codigos, descricaos FROM SIGCDICM ORDER BY codigos", ;
10234:                     "cursor_4c_IcmBusca")
10235:             ENDIF
10236:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10237:             IF VARTYPE(loc_oBusca) = "O"
10238:                 loc_oBusca.this_cCursorDestino = "cursor_4c_IcmBusca"
10239:                 loc_oBusca.DefinirCursor("cursor_4c_IcmBusca", "codigos", "descricaos", ;
10240:                     "Buscar Sit. Tributaria ICMS")
10241:                 loc_oBusca.Mostrar()
10242:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10243:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10244:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10245:                     ENDIF
10246:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
10247:                         loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10248:                     ENDIF

*-- Linhas 10270 a 10297:
10270:             IF PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
10271:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Codigo.Value)
10272:             ENDIF
10273:             loc_nRet = SQLEXEC(gnConnHandle, ;
10274:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos LIKE " + ;
10275:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10276:                 "cursor_4c_CodServBusca")
10277:             IF loc_nRet <= 0 OR !USED("cursor_4c_CodServBusca") OR EOF("cursor_4c_CodServBusca")
10278:                 IF USED("cursor_4c_CodServBusca")
10279:                     USE IN cursor_4c_CodServBusca
10280:                 ENDIF
10281:                 SQLEXEC(gnConnHandle, ;
10282:                     "SELECT codigos, descricaos FROM SIGCDICM ORDER BY codigos", ;
10283:                     "cursor_4c_CodServBusca")
10284:             ENDIF
10285:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10286:             IF VARTYPE(loc_oBusca) = "O"
10287:                 loc_oBusca.this_cCursorDestino = "cursor_4c_CodServBusca"
10288:                 loc_oBusca.DefinirCursor("cursor_4c_CodServBusca", "codigos", "descricaos", ;
10289:                     "Buscar C" + CHR(243) + "d. Servi" + CHR(231) + "o Fiscal")
10290:                 loc_oBusca.Mostrar()
10291:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10292:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
10293:                         loc_oPg.txt_4c_Codigo.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10294:                     ENDIF
10295:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10296:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10297:                     ENDIF

*-- Linhas 10322 a 10349:
10322:             IF PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
10323:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_TpTrib.Value)
10324:             ENDIF
10325:             loc_nRet = SQLEXEC(gnConnHandle, ;
10326:                 "SELECT tipos, descs FROM SigPrTri WHERE tipos LIKE " + ;
10327:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY tipos", ;
10328:                 "cursor_4c_TpTribBusca")
10329:             IF loc_nRet <= 0 OR !USED("cursor_4c_TpTribBusca") OR EOF("cursor_4c_TpTribBusca")
10330:                 IF USED("cursor_4c_TpTribBusca")
10331:                     USE IN cursor_4c_TpTribBusca
10332:                 ENDIF
10333:                 SQLEXEC(gnConnHandle, ;
10334:                     "SELECT tipos, descs FROM SigPrTri ORDER BY tipos", ;
10335:                     "cursor_4c_TpTribBusca")
10336:             ENDIF
10337:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10338:             IF VARTYPE(loc_oBusca) = "O"
10339:                 loc_oBusca.this_cCursorDestino = "cursor_4c_TpTribBusca"
10340:                 loc_oBusca.DefinirCursor("cursor_4c_TpTribBusca", "tipos", "descs", ;
10341:                     "Buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o")
10342:                 loc_oBusca.Mostrar()
10343:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10344:                     IF PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
10345:                         loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10346:                     ENDIF
10347:                 ENDIF
10348:                 loc_oBusca = .NULL.
10349:             ENDIF

*-- Linhas 10368 a 10396:
10368:             IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
10369:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Metal.Value)
10370:             ENDIF
10371:             loc_nRet = SQLEXEC(gnConnHandle, ;
10372:                 "SELECT codigos, descs FROM SigCdMtl " + ;
10373:                 "WHERE tipos = 'M' AND codigos LIKE " + ;
10374:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10375:                 "cursor_4c_MetalBusca")
10376:             IF loc_nRet <= 0 OR !USED("cursor_4c_MetalBusca") OR EOF("cursor_4c_MetalBusca")
10377:                 IF USED("cursor_4c_MetalBusca")
10378:                     USE IN cursor_4c_MetalBusca
10379:                 ENDIF
10380:                 SQLEXEC(gnConnHandle, ;
10381:                     "SELECT codigos, descs FROM SigCdMtl WHERE tipos = 'M' ORDER BY codigos", ;
10382:                     "cursor_4c_MetalBusca")
10383:             ENDIF
10384:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10385:             IF VARTYPE(loc_oBusca) = "O"
10386:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MetalBusca"
10387:                 loc_oBusca.DefinirCursor("cursor_4c_MetalBusca", "codigos", "descs", "Buscar Metal")
10388:                 loc_oBusca.Mostrar()
10389:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10390:                     IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
10391:                         loc_oPg.txt_4c_Metal.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10392:                     ENDIF
10393:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
10394:                         loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10395:                     ENDIF
10396:                 ENDIF

*-- Linhas 10417 a 10445:
10417:             IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
10418:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Teor.Value)
10419:             ENDIF
10420:             loc_nRet = SQLEXEC(gnConnHandle, ;
10421:                 "SELECT codigos, descs FROM SigCdMtl " + ;
10422:                 "WHERE tipos <> 'M' AND codigos LIKE " + ;
10423:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10424:                 "cursor_4c_TeorBusca")
10425:             IF loc_nRet <= 0 OR !USED("cursor_4c_TeorBusca") OR EOF("cursor_4c_TeorBusca")
10426:                 IF USED("cursor_4c_TeorBusca")
10427:                     USE IN cursor_4c_TeorBusca
10428:                 ENDIF
10429:                 SQLEXEC(gnConnHandle, ;
10430:                     "SELECT codigos, descs FROM SigCdMtl WHERE tipos <> 'M' ORDER BY codigos", ;
10431:                     "cursor_4c_TeorBusca")
10432:             ENDIF
10433:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10434:             IF VARTYPE(loc_oBusca) = "O"
10435:                 loc_oBusca.this_cCursorDestino = "cursor_4c_TeorBusca"
10436:                 loc_oBusca.DefinirCursor("cursor_4c_TeorBusca", "codigos", "descs", "Buscar Teor")
10437:                 loc_oBusca.Mostrar()
10438:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10439:                     IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
10440:                         loc_oPg.txt_4c_Teor.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10441:                     ENDIF
10442:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
10443:                         loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10444:                     ENDIF
10445:                 ENDIF

*-- Linhas 10466 a 10493:
10466:             IF PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
10467:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Mvalor.Value)
10468:             ENDIF
10469:             loc_nRet = SQLEXEC(gnConnHandle, ;
10470:                 "SELECT cmoeds, dmoeds FROM SigCdMoe WHERE cmoeds LIKE " + ;
10471:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY cmoeds", ;
10472:                 "cursor_4c_MoeFiscalBusca")
10473:             IF loc_nRet <= 0 OR !USED("cursor_4c_MoeFiscalBusca") OR EOF("cursor_4c_MoeFiscalBusca")
10474:                 IF USED("cursor_4c_MoeFiscalBusca")
10475:                     USE IN cursor_4c_MoeFiscalBusca
10476:                 ENDIF
10477:                 SQLEXEC(gnConnHandle, ;
10478:                     "SELECT cmoeds, dmoeds FROM SigCdMoe ORDER BY cmoeds", ;
10479:                     "cursor_4c_MoeFiscalBusca")
10480:             ENDIF
10481:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10482:             IF VARTYPE(loc_oBusca) = "O"
10483:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MoeFiscalBusca"
10484:                 loc_oBusca.DefinirCursor("cursor_4c_MoeFiscalBusca", "cmoeds", "dmoeds", ;
10485:                     "Buscar Moeda")
10486:                 loc_oBusca.Mostrar()
10487:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10488:                     IF PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
10489:                         loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10490:                     ENDIF
10491:                 ENDIF
10492:                 loc_oBusca = .NULL.
10493:             ENDIF

*-- Linhas 10515 a 10547:
10515:             *-- Cursors placeholder (preenchidos pelo BO ao carregar produto)
10516:             IF !USED("cursor_4c_GrdDesigner")
10517:                 SET NULL ON
10518:                 CREATE CURSOR cursor_4c_GrdDesigner ( ;
10519:                     dtini D, dtfim D, usuarios C(10), codcads C(10))
10520:                 SET NULL OFF
10521:             ENDIF
10522:             IF !USED("cursor_4c_GrdArquivos")
10523:                 SET NULL ON
10524:                 CREATE CURSOR cursor_4c_GrdArquivos (arqnome C(200))
10525:                 SET NULL OFF
10526:             ENDIF
10527:             IF !USED("crTarefas")
10528:                 CREATE CURSOR crTarefas (CodCads C(10), DesCads C(40))
10529:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
10530:                     SQLEXEC(gnConnHandle, ;
10531:                         "SELECT LEFT(codcads, 10) AS CodCads, descads AS DesCads " + ;
10532:                         "FROM SigCdCad ORDER BY codcads", ;
10533:                         "crTarefas")
10534:                 ENDIF
10535:             ENDIF
10536: 
10537:             *-- grdDesigner: grade historico de designer (4 colunas)
10538:             *-- Original: top=145, left=10, width=495, height=180
10539:             loc_oPg.AddObject("grd_4c_GrdDesigner", "Grid")
10540:             WITH loc_oPg.grd_4c_GrdDesigner
10541:                 .Top        = 145
10542:                 .Left       = 10
10543:                 .Width      = 495
10544:                 .Height     = 180
10545:                 .FontName   = "Tahoma"
10546:                 .FontSize   = 8
10547:                 .RecordMark = .F.

*-- Linhas 10554 a 10593:
10554:             loc_oPg.grd_4c_GrdDesigner.RecordSource = "cursor_4c_GrdDesigner"
10555:             loc_oGrid = loc_oPg.grd_4c_GrdDesigner
10556: 
10557:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdDesigner.dtini"
10558:             loc_oGrid.Column1.Width           = 100
10559:             loc_oGrid.Column1.ColumnOrder     = 1
10560:             loc_oGrid.Column1.Movable         = .F.
10561:             loc_oGrid.Column1.Resizable       = .F.
10562:             loc_oGrid.Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
10563: 
10564:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdDesigner.dtfim"
10565:             loc_oGrid.Column2.Width           = 100
10566:             loc_oGrid.Column2.ColumnOrder     = 2
10567:             loc_oGrid.Column2.Movable         = .F.
10568:             loc_oGrid.Column2.Resizable       = .F.
10569:             loc_oGrid.Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
10570: 
10571:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdDesigner.usuarios"
10572:             loc_oGrid.Column3.Width           = 100
10573:             loc_oGrid.Column3.ColumnOrder     = 3
10574:             loc_oGrid.Column3.Movable         = .F.
10575:             loc_oGrid.Column3.Resizable       = .F.
10576:             loc_oGrid.Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
10577: 
10578:             loc_oGrid.Column4.ControlSource   = "cursor_4c_GrdDesigner.codcads"
10579:             loc_oGrid.Column4.Width           = 193
10580:             loc_oGrid.Column4.ColumnOrder     = 4
10581:             loc_oGrid.Column4.Movable         = .F.
10582:             loc_oGrid.Column4.Resizable       = .F.
10583:             loc_oGrid.Column4.Header1.Caption = "Tarefa"
10584:             BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdDesignerCol4TarefaValid")
10585: 
10586:             *-- Say31: label "Observacao da Tarefa"
10587:             *-- Original: top=129, left=583, width=126, height=15
10588:             loc_oPg.AddObject("lbl_4c_Label31", "Label")
10589:             WITH loc_oPg.lbl_4c_Label31
10590:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
10591:                 .Top       = 129
10592:                 .Left      = 583
10593:                 .Width     = 126

*-- Linhas 10703 a 10721:
10703:             ENDWITH
10704:             loc_oPg.grd_4c_GrdArquivos.ColumnCount  = 1
10705:             loc_oPg.grd_4c_GrdArquivos.RecordSource = "cursor_4c_GrdArquivos"
10706:             loc_oPg.grd_4c_GrdArquivos.Column1.ControlSource   = "cursor_4c_GrdArquivos.arqnome"
10707:             loc_oPg.grd_4c_GrdArquivos.Column1.Width           = 493
10708:             loc_oPg.grd_4c_GrdArquivos.Column1.ColumnOrder     = 1
10709:             loc_oPg.grd_4c_GrdArquivos.Column1.Movable         = .F.
10710:             loc_oPg.grd_4c_GrdArquivos.Column1.Resizable       = .F.
10711:             loc_oPg.grd_4c_GrdArquivos.Column1.Header1.Caption = "Arquivos Para Designer"
10712: 
10713:             *-- btnInsArqs: botao Inserir Arquivo
10714:             *-- Original: top=335, left=509, width=42, height=42
10715:             loc_oPg.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
10716:             WITH loc_oPg.cmd_4c_BtnInsArqs
10717:                 .Caption       = "+"
10718:                 .Top           = 335
10719:                 .Left          = 509
10720:                 .Width         = 42
10721:                 .Height        = 42

*-- Linhas 10943 a 11004:
10943:                 loc_cCodCads = ALLTRIM(cursor_4c_GrdDesigner.codcads)
10944:                 IF !EMPTY(loc_cCodCads)
10945:                     IF USED("crTarefas")
10946:                         SELECT crTarefas
10947:                         GO TOP
10948:                         LOCATE FOR ALLTRIM(CodCads) = loc_cCodCads
10949:                         IF EOF("crTarefas")
10950:                             THIS.AbrirBuscaTarefaDesigner()
10951:                         ENDIF
10952:                         IF USED("cursor_4c_GrdDesigner")
10953:                             SELECT cursor_4c_GrdDesigner
10954:                         ENDIF
10955:                     ELSE
10956:                         THIS.AbrirBuscaTarefaDesigner()
10957:                     ENDIF
10958:                 ENDIF
10959:             ENDIF
10960:         CATCH TO loException
10961:             MostrarErro("Erro ao validar Tarefa:" + CHR(13) + loException.Message, ;
10962:                 "FormProduto.GrdDesignerCol4TarefaValid")
10963:         ENDTRY
10964:         RETURN loc_lSucesso
10965:     ENDPROC
10966: 
10967:     PROCEDURE AbrirBuscaTarefaDesigner()
10968:         LOCAL loc_oBusca, loc_nRet, loException
10969:         TRY
10970:             IF !USED("crTarefas")
10971:                 CREATE CURSOR crTarefas (CodCads C(10), DesCads C(40))
10972:                 loc_nRet = SQLEXEC(gnConnHandle, ;
10973:                     "SELECT LEFT(codcads, 10) AS CodCads, descads AS DesCads " + ;
10974:                     "FROM SigCdCad ORDER BY codcads", ;
10975:                     "crTarefas")
10976:                 IF loc_nRet <= 0 OR EOF("crTarefas")
10977:                     MsgAviso("Sem tarefas cadastradas para selecionar.")
10978:                     RETURN
10979:                 ENDIF
10980:             ENDIF
10981:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10982:             IF VARTYPE(loc_oBusca) = "O"
10983:                 loc_oBusca.this_cCursorDestino = "crTarefas"
10984:                 loc_oBusca.DefinirCursor("crTarefas", "CodCads", "DesCads", ;
10985:                     "Selecionar Tarefa")
10986:                 loc_oBusca.Mostrar()
10987:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND ;
10988:                     USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
10989:                     SELECT cursor_4c_GrdDesigner
10990:                     REPLACE cursor_4c_GrdDesigner.codcads WITH ;
10991:                         ALLTRIM(loc_oBusca.cCodigoSelecionado)
10992:                 ENDIF
10993:                 loc_oBusca = .NULL.
10994:             ENDIF
10995:         CATCH TO loException
10996:             MostrarErro("Erro ao buscar Tarefa:" + CHR(13) + loException.Message, ;
10997:                 "FormProduto.AbrirBuscaTarefaDesigner")
10998:         ENDTRY
10999:     ENDPROC
11000: 
11001:     *-- GetDesLacto (txt_4c_DesLacto): Valid - valida usuario desenvolvedor em SigCdUsu
11002:     PROCEDURE ValidarDesLacto(par_nKeyCode, par_nShiftAltCtrl)
11003:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11004:             RETURN

*-- Linhas 11011 a 11031:
11011:                 loc_cCod = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
11012:             ENDIF
11013:             IF !EMPTY(loc_cCod)
11014:                 loc_nRet = SQLEXEC(gnConnHandle, ;
11015:                     "SELECT usuarios FROM SigCdUsu " + ;
11016:                     "WHERE usuarios = " + EscaparSQL(loc_cCod) + " AND cativos <> 'N'", ;
11017:                     "cursor_4c_DesLactoBusca")
11018:                 IF loc_nRet > 0 AND USED("cursor_4c_DesLactoBusca") AND !EOF("cursor_4c_DesLactoBusca")
11019:                     IF USED("cursor_4c_DesLactoBusca")
11020:                         USE IN cursor_4c_DesLactoBusca
11021:                     ENDIF
11022:                 ELSE
11023:                     IF USED("cursor_4c_DesLactoBusca")
11024:                         USE IN cursor_4c_DesLactoBusca
11025:                     ENDIF
11026:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
11027:                         loc_oPg.txt_4c_DesLacto.Value = ""
11028:                     ENDIF
11029:                     THIS.AbrirBuscaDesLacto()
11030:                 ENDIF
11031:             ENDIF

*-- Linhas 11046 a 11074:
11046:             IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
11047:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
11048:             ENDIF
11049:             loc_nRet = SQLEXEC(gnConnHandle, ;
11050:                 "SELECT usuarios, ncomps FROM SigCdUsu " + ;
11051:                 "WHERE cativos <> 'N' AND usuarios LIKE " + EscaparSQL(loc_cValAtual + "%") + ;
11052:                 " ORDER BY usuarios", ;
11053:                 "cursor_4c_DesLactoBusca")
11054:             IF loc_nRet <= 0 OR !USED("cursor_4c_DesLactoBusca") OR EOF("cursor_4c_DesLactoBusca")
11055:                 IF USED("cursor_4c_DesLactoBusca")
11056:                     USE IN cursor_4c_DesLactoBusca
11057:                 ENDIF
11058:                 SQLEXEC(gnConnHandle, ;
11059:                     "SELECT usuarios, ncomps FROM SigCdUsu WHERE cativos <> 'N' ORDER BY usuarios", ;
11060:                     "cursor_4c_DesLactoBusca")
11061:             ENDIF
11062:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
11063:             IF VARTYPE(loc_oBusca) = "O"
11064:                 loc_oBusca.this_cCursorDestino = "cursor_4c_DesLactoBusca"
11065:                 loc_oBusca.DefinirCursor("cursor_4c_DesLactoBusca", "usuarios", "ncomps", ;
11066:                     "Selecionar Desenvolvedor")
11067:                 loc_oBusca.Mostrar()
11068:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
11069:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
11070:                         loc_oPg.txt_4c_DesLacto.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
11071:                     ENDIF
11072:                 ENDIF
11073:                 loc_oBusca = .NULL.
11074:             ENDIF

*-- Linhas 11097 a 11117:
11097:                 loc_cCod = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
11098:             ENDIF
11099:             IF !EMPTY(loc_cCod)
11100:                 loc_nRet = SQLEXEC(gnConnHandle, ;
11101:                     "SELECT usuarios FROM SigCdUsu " + ;
11102:                     "WHERE usuarios = " + EscaparSQL(loc_cCod) + " AND cativos <> 'N'", ;
11103:                     "cursor_4c_CriaLactoBusca")
11104:                 IF loc_nRet > 0 AND USED("cursor_4c_CriaLactoBusca") AND !EOF("cursor_4c_CriaLactoBusca")
11105:                     IF USED("cursor_4c_CriaLactoBusca")
11106:                         USE IN cursor_4c_CriaLactoBusca
11107:                     ENDIF
11108:                 ELSE
11109:                     IF USED("cursor_4c_CriaLactoBusca")
11110:                         USE IN cursor_4c_CriaLactoBusca
11111:                     ENDIF
11112:                     IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11113:                         loc_oPg.txt_4c_CriaLacto.Value = ""
11114:                     ENDIF
11115:                     THIS.AbrirBuscaCriaLacto()
11116:                 ENDIF
11117:             ENDIF

*-- Linhas 11132 a 11160:
11132:             IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11133:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
11134:             ENDIF
11135:             loc_nRet = SQLEXEC(gnConnHandle, ;
11136:                 "SELECT usuarios, ncomps FROM SigCdUsu " + ;
11137:                 "WHERE cativos <> 'N' AND usuarios LIKE " + EscaparSQL(loc_cValAtual + "%") + ;
11138:                 " ORDER BY usuarios", ;
11139:                 "cursor_4c_CriaLactoBusca")
11140:             IF loc_nRet <= 0 OR !USED("cursor_4c_CriaLactoBusca") OR EOF("cursor_4c_CriaLactoBusca")
11141:                 IF USED("cursor_4c_CriaLactoBusca")
11142:                     USE IN cursor_4c_CriaLactoBusca
11143:                 ENDIF
11144:                 SQLEXEC(gnConnHandle, ;
11145:                     "SELECT usuarios, ncomps FROM SigCdUsu WHERE cativos <> 'N' ORDER BY usuarios", ;
11146:                     "cursor_4c_CriaLactoBusca")
11147:             ENDIF
11148:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
11149:             IF VARTYPE(loc_oBusca) = "O"
11150:                 loc_oBusca.this_cCursorDestino = "cursor_4c_CriaLactoBusca"
11151:                 loc_oBusca.DefinirCursor("cursor_4c_CriaLactoBusca", "usuarios", "ncomps", ;
11152:                     "Selecionar Criador")
11153:                 loc_oBusca.Mostrar()
11154:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
11155:                     IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11156:                         loc_oPg.txt_4c_CriaLacto.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
11157:                     ENDIF
11158:                 ENDIF
11159:                 loc_oBusca = .NULL.
11160:             ENDIF

*-- Linhas 11178 a 11196:
11178:                 MsgAviso("Habilite Incluir ou Alterar para registrar tarefa.")
11179:             ELSE
11180:                 IF USED("cursor_4c_GrdDesigner")
11181:                     SELECT cursor_4c_GrdDesigner
11182:                     APPEND BLANK
11183:                     REPLACE cursor_4c_GrdDesigner.dtini    WITH DATE()
11184:                     REPLACE cursor_4c_GrdDesigner.usuarios WITH ALLTRIM(gc_4c_UsuarioLogado)
11185:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11186:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdDesigner", 5)
11187:                         loc_oPg.grd_4c_GrdDesigner.Refresh()
11188:                     ENDIF
11189:                 ENDIF
11190:             ENDIF
11191:         CATCH TO loException
11192:             MostrarErro("Erro ao registrar inicio de tarefa:" + CHR(13) + loException.Message, ;
11193:                 "FormProduto.BtnIniTarefaClick")
11194:         ENDTRY
11195:     ENDPROC
11196: 

*-- Linhas 11202 a 11220:
11202:                 MsgAviso("Habilite Incluir ou Alterar para registrar conclus" + CHR(227) + "o.")
11203:             ELSE
11204:                 IF USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
11205:                     SELECT cursor_4c_GrdDesigner
11206:                     REPLACE cursor_4c_GrdDesigner.dtfim WITH DATE()
11207:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11208:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdDesigner", 5)
11209:                         loc_oPg.grd_4c_GrdDesigner.Refresh()
11210:                     ENDIF
11211:                 ELSE
11212:                     MsgAviso("Selecione um registro de tarefa para registrar conclus" + CHR(227) + "o.")
11213:                 ENDIF
11214:             ENDIF
11215:         CATCH TO loException
11216:             MostrarErro("Erro ao registrar fim de tarefa:" + CHR(13) + loException.Message, ;
11217:                 "FormProduto.BtnFimTarefaClick")
11218:         ENDTRY
11219:     ENDPROC
11220: 

*-- Linhas 11227 a 11245:
11227:             ELSE
11228:                 loc_cArquivo = GETFILE("*", "Selecionar Arquivo")
11229:                 IF !EMPTY(loc_cArquivo) AND USED("cursor_4c_GrdArquivos")
11230:                     SELECT cursor_4c_GrdArquivos
11231:                     APPEND BLANK
11232:                     REPLACE cursor_4c_GrdArquivos.arqnome WITH ALLTRIM(loc_cArquivo)
11233:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11234:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdArquivos", 5)
11235:                         loc_oPg.grd_4c_GrdArquivos.Refresh()
11236:                     ENDIF
11237:                 ENDIF
11238:             ENDIF
11239:         CATCH TO loException
11240:             MostrarErro("Erro ao inserir arquivo:" + CHR(13) + loException.Message, ;
11241:                 "FormProduto.BtnInsArqsClick")
11242:         ENDTRY
11243:     ENDPROC
11244: 
11245:     *-- btnExcArqs: exclui arquivo selecionado da lista grdArquivos

*-- Linhas 11252 a 11271:
11252:                 IF USED("cursor_4c_GrdArquivos") AND !EOF("cursor_4c_GrdArquivos")
11253:                     loc_lConfirm = MsgConfirma("Confirma exclus" + CHR(227) + "o do arquivo selecionado?")
11254:                     IF loc_lConfirm
11255:                         SELECT cursor_4c_GrdArquivos
11256:                         DELETE
11257:                         PACK
11258:                         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11259:                         IF PEMSTATUS(loc_oPg, "grd_4c_GrdArquivos", 5)
11260:                             loc_oPg.grd_4c_GrdArquivos.Refresh()
11261:                         ENDIF
11262:                     ENDIF
11263:                 ELSE
11264:                     MsgAviso("Selecione um arquivo para excluir.")
11265:                 ENDIF
11266:             ENDIF
11267:         CATCH TO loException
11268:             MostrarErro("Erro ao excluir arquivo:" + CHR(13) + loException.Message, ;
11269:                 "FormProduto.BtnExcArqsClick")
11270:         ENDTRY
11271:     ENDPROC

*-- Linhas 11320 a 11393:
11320:             *-- Cursor placeholder ANTES de RecordSource (REGRA CRITICA VFP9)
11321:             IF !USED("cursor_4c_GrdServico")
11322:                 SET NULL ON
11323:                 CREATE CURSOR cursor_4c_GrdServico (Marcas N(1,0), Cods C(3), Descs C(30), qtdias N(3,0))
11324:                 SET NULL OFF
11325:             ENDIF
11326: 
11327:             *-- grd_4c_Dados: grade de servicos associados
11328:             *-- Original grdServico: top=171, left=339, width=320, height=387
11329:             loc_oPg.AddObject("grd_4c_Dados", "Grid")
11330:             WITH loc_oPg.grd_4c_Dados
11331:                 .Top        = 171
11332:                 .Left       = 339
11333:                 .Width      = 320
11334:                 .Height     = 387
11335:                 .FontName   = "Tahoma"
11336:                 .FontSize   = 8
11337:                 .DeleteMark = .F.
11338:                 .RecordMark = .F.
11339:                 .RowHeight  = 16
11340:                 .ScrollBars = 2
11341:                 .Visible    = .T.
11342:             ENDWITH
11343:             loc_oPg.grd_4c_Dados.ColumnCount  = 3
11344:             loc_oPg.grd_4c_Dados.RecordSource = "cursor_4c_GrdServico"
11345:             loc_oGrid = loc_oPg.grd_4c_Dados
11346: 
11347:             *-- Column1: Descs/Descricao Servico (ColumnOrder=2 - exibida como 2a coluna)
11348:             *-- When: editavel em INCLUIR/ALTERAR E Marcas=1 na linha atual
11349:             *-- Valid: fAcessoEmpresa (validacao empresa por descricao de servico)
11350:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdServico.Descs"
11351:             loc_oGrid.Column1.Width           = 228
11352:             loc_oGrid.Column1.ColumnOrder     = 2
11353:             loc_oGrid.Column1.Movable         = .F.
11354:             loc_oGrid.Column1.Resizable       = .F.
11355:             loc_oGrid.Column1.Header1.Caption = "Servi" + CHR(231) + "os"
11356:             loc_oGrid.Column1.Text1.Alignment  = 3
11357:             loc_oGrid.Column1.Text1.BorderStyle = 0
11358:             loc_oGrid.Column1.Text1.Margin     = 0
11359:             BINDEVENT(loc_oGrid.Column1.Text1, "When",  THIS, "GrdServicoCol1When")
11360:             BINDEVENT(loc_oGrid.Column1.Text1, "Valid",  THIS, "GrdServicoCol1Valid")
11361: 
11362:             *-- Column2: Cods/Codigo Servico (ColumnOrder=3, somente leitura)
11363:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdServico.Cods"
11364:             loc_oGrid.Column2.Width           = 50
11365:             loc_oGrid.Column2.ColumnOrder     = 3
11366:             loc_oGrid.Column2.Movable         = .F.
11367:             loc_oGrid.Column2.Resizable       = .F.
11368:             loc_oGrid.Column2.ReadOnly        = .T.
11369:             loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
11370:             loc_oGrid.Column2.Text1.BorderStyle = 0
11371:             loc_oGrid.Column2.Text1.Margin     = 0
11372:             loc_oGrid.Column2.Text1.ReadOnly   = .T.
11373: 
11374:             *-- Column3: Marcas/CheckBox (ColumnOrder=1 - primeira coluna visualmente)
11375:             *-- Sparse=.F. obrigatorio para CheckBox funcionar em coluna de grid
11376:             *-- When: editavel em INCLUIR/ALTERAR
11377:             *-- KeyPress: Space(32) ou Enter(13) togla Marcas (0->1, 1->0)
11378:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdServico.Marcas"
11379:             loc_oGrid.Column3.Width           = 17
11380:             loc_oGrid.Column3.ColumnOrder     = 1
11381:             loc_oGrid.Column3.Movable         = .F.
11382:             loc_oGrid.Column3.Resizable       = .F.
11383:             loc_oGrid.Column3.Sparse          = .F.
11384:             loc_oGrid.Column3.Header1.Caption = ""
11385:             loc_oGrid.Column3.AddObject("Check1", "CheckBox")
11386:             WITH loc_oGrid.Column3.Check1
11387:                 .Caption   = ""
11388:                 .Alignment = 0
11389:                 .ReadOnly  = .F.
11390:                 .Visible   = .T.
11391:                 .Top       = 9
11392:                 .Left      = 2
11393:                 .Height    = 17

*-- Linhas 11417 a 11457:
11417: 
11418:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page8
11419: 
11420:             *-- Carregar todos os servicos com Marcas=0/1 via LEFT JOIN em SigSerPr
11421:             IF USED("cursor_4c_GrdServico")
11422:                 USE IN cursor_4c_GrdServico
11423:             ENDIF
11424:             loc_nRet = SQLEXEC(gnConnHandle, ;
11425:                 "SELECT CASE WHEN s.cods IS NOT NULL THEN 1 ELSE 0 END AS Marcas," + ;
11426:                 " p.cods, p.descs, p.qtdias" + ;
11427:                 " FROM SigPrSer p" + ;
11428:                 " LEFT JOIN SigSerPr s ON s.cods = p.cods AND s.cpros = " + EscaparSQL(loc_cCpros) + ;
11429:                 " ORDER BY p.descs", ;
11430:                 "cursor_4c_GrdServico")
11431:             IF loc_nRet <= 0
11432:                 CREATE CURSOR cursor_4c_GrdServico (Marcas N(1,0), Cods C(3), Descs C(30), qtdias N(3,0))
11433:             ENDIF
11434: 
11435:             *-- Reassociar RecordSource e ControlSources apos recarregar cursor
11436:             IF PEMSTATUS(loc_oPg, "grd_4c_Dados", 5)
11437:                 loc_oGrid = loc_oPg.grd_4c_Dados
11438:                 loc_oGrid.ColumnCount = 3
11439:                 loc_oGrid.RecordSource          = "cursor_4c_GrdServico"
11440:                 loc_oGrid.Column1.ControlSource = "cursor_4c_GrdServico.Descs"
11441:                 loc_oGrid.Column2.ControlSource = "cursor_4c_GrdServico.Cods"
11442:                 loc_oGrid.Column3.ControlSource = "cursor_4c_GrdServico.Marcas"
11443:                 loc_oGrid.Refresh()
11444:             ENDIF
11445: 
11446:         CATCH TO loException
11447:             MostrarErro("Erro ao carregar Servi" + CHR(231) + "os:" + CHR(13) + ;
11448:                 loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
11449:                 "FormProduto.CarregarServicos")
11450:         ENDTRY
11451:     ENDPROC
11452: 
11453:     *===========================================================================
11454:     * Handlers de BINDEVENT para pgServico (Page8)
11455:     * Todos PUBLIC - requerido pelo BINDEVENT
11456:     *===========================================================================
11457: 

