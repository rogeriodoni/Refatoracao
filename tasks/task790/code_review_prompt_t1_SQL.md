# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NDOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DISTRIBUI, QTDS, CFGTITTPESO, CITENS, W, CPROS, LPRECOS, IFORS, PVENS, CMOES, CITEM2, CBARS, CODBARRAS, ORDTS, SEMIACABS, DOPES, MERCS, CGRUS, 0, PRODUTOS, EMPDOPNUMS, CDOPES, DIGITADO, ENCOMS, CODIGOS, OP_ESCOLHA, OPERS, MATS, CARGO, CATEGORIA, LCTIPOCARG, LNDIAGAR, ABREVIS, ABREVS, CODTAMS, SUBNOBRIGS, CNIVELS, OPEINATVS, TOTA, EMPDNCRDS, PADRAOS, PRESENTEIT, SERVICOIT, LCDYNFC, NITEMBXS, MOEDS, EDCOTAS, CHKOPNCSH, CADPRODS, SERVICOS, DTSITUAS, SITUAS, DESCOS, NPARCS, IF, OBSITEMS, NGRADERECNO, NOTAS, TIPOOPS, OPVLUNIS, NUMES, FPAGS, EDITDOCS, CTRLLOTES, PRECOPS, UTILIZAS, EPRECOS, UNITS, CORES, TAMS, CBARS_OLD, CIDCHAVES, CUNIS, EAN13, ICONFS, LCARQ, TIPOESTOS, CODS, I, DIGITENS, CHKVLDXML, CHAVENOTA, REFFS, DESCOB2S, ULTIMAGEM, ICLIS, VISNOMEFOR, EDITDECLS, VARCPPQS, QTDESMEMB, ALERTITEM, ALTETIQS, CEMPS, ATIVAS, ESTORIGS, ESTOQS, ESTDESTS, CONTAOS, CPROEQS, CODBARS, DOPPS, LINHAS, MTPRIMAS, TPPESOS, SEMETIQS, BARINDIVS, DPROS, CONJUNTS, MOSTRUARIO, ETIQS, PESOMETAL, EMPS, TT, LLPRODUCAO, CONTAS, CONTAORIG, EXCLUS, EMBS, QTD, EMPGRUESTS, SQTDS, BXPARCIALS, CONSIGS, STATUS, VLRFIXOS, VALITEMS, BARREFS, CITEM, CONSERS, EFATORS, ORIDOPNUMS, GEROPES, VALUE, VALQTDSUP, HABSUBITS, FATDIVS, TAG, ZERQTDS, LNPESOM, XPESO, RECQTD, DESMEMBS, EDUNIS, CODCORS, CONFES, TPLOCALS, ORIGEMS, DESTINOS, ATUAPESOS, EPESOS, ITSITUAS, LOCALOS, GRUPOS, ESTOS, LOCALS, OPERACAO, VALVARPESO, LNVARIAPROD, CHKABREVS, CHKVARCARG, VALCORTAM, CKCODPAIES, QTRESERVAS, PESOVTS, VALITENS, PARRECALS, LNVALPAR, CUN, LCCUN, VALINIS, VALSERVS

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
  ControlSource = "TprMvCab.mascnum"
  ControlSource = "TprMvCab.tabds"
  ControlSource = "TprMvCab.tpfats"
  ControlSource = "TprMvCab.MoeIts"
  ControlSource = "TprMvCab.grupoos"
  ControlSource = "TprMvCab.contaos"
  ControlSource = ""
  ControlSource = "TprMvCab.grupods"
  ControlSource = "TprMvCab.contads"
  ControlSource = ""
  ControlSource = "TprMvCab.empds"
  ControlSource = "TprMvCab.LPrecos"
  ControlSource = "crTpmMvItn.OBS"
  ControlSource = "crTpmMvItn.DPros"
  ControlSource = "crTpmMvItn.OBS"
  ControlSource = "crTpmMvItn.Notas"
  ControlSource = "crTpmMvItn.nLotes"
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crTpmMvItn.qtbaixas"
  ControlSource = "crTpmMvItn.nadis"
  ControlSource = "crTpmMvItn.niadis"
  ControlSource = "crTpmMvItn.codfabs"
  ControlSource = "crTpmMvItn.Ob2s"
  DeleteMark = .F.
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  ControlSource = "lpitem.tabds"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column9.ControlSource = ""
  Column10.ControlSource = ""
  Column11.ControlSource = ""
  Column12.ControlSource = ""
  Column13.ControlSource = ""
  Column14.ControlSource = ""
  Column15.ControlSource = ""
  Column16.ControlSource = ""
  Column17.ControlSource = ""
  Column18.ControlSource = ""
  Column19.ControlSource = ""
  ControlSource = "crTpmMvItn.citens"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column9.ControlSource = ""
  Column10.ControlSource = ""
  Column11.ControlSource = ""
  Column12.ControlSource = ""
  Column13.ControlSource = ""
  Column14.ControlSource = ""
  Column15.ControlSource = ""
  Column16.ControlSource = ""
  Column17.ControlSource = ""
  Column18.ControlSource = ""
  Column19.ControlSource = ""
  ControlSource = "crTpmMvItn.citens"
  ControlSource = ""
Select crTpmMvItn
Select crTpmMvIts
Delete For crTpmMvIts.CItens = crTpmMvItn.CItens
Select crTpmMvItn
		=Seek( crTpmMvItn.AbrevIs, 'CsPedidos', 'Abrevs' )
		=Seek(CsPedidos.cNivels,'TprMvCab3','Dopes')
Select crTpmMvIts
Select * From crTpmMvIts Where cItens = lnItem Into Cursor TmpEsti2 ReadWrite
	lcSql = [Select Cpros, cproeqs From SigCdPro where Cpros = ']+pProduto+[']
	If ThisForm.ParentForm.podatamgr.sqlexecute(lcsql,'CrtmpPro') > 0
			lcQuery = [Select Cpros, Cgrus, Reffs, Situas, DtSituas, Cunis, Dpros, Pesoms, FVendas, FCustos, Moepvs, ifors, ] + ;
					  [From SigCdPro ] + ;
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpPro') < 1)
				lcSql = [Select Codigos From SigCdLpc where lPrecos = ']+TprMvCab.lPrecos+[']
				lnErro = ThisForm.ParentForm.podatamgr.SqlExecute(lcSql,'CrtmplPre')
				lcwhere = [Select * From SigCdLpi Where Cpros = ']+CrTmpPro.Cpros+[' And LPrecos = ']+TprMvCab.lPrecos+[']
				lnErro = ThisForm.ParentForm.podatamgr.SqlExecute(lcWhere,'crSigCdLpi')
				Select crSigCdLpi
								lcQuery = [Select Moevs,Pvens From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[' And Ifors = ']+_Ct+[']
								=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
							lcQuery = [Select MoeQs, QtdEqs ] + ;
									    [From SigCdMoe ] + ;
							If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpMoe') < 1)
						lcQuery = [select customedioreais as csmedio, (select moedaps from sigcdpam) as csmoedas ] + ;
								[from customedio3 where cpros = ']+CrTmpPro.Cpros+[' ]
						If ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpProMd') < 1
					Select crTpmMvItn
			Select crTpmMvItn
			Select crTpmMvItn
		Select TmpEsti2
		Update TmpEsti2 Set Cpros = lcCodProduto, cItens = crTpmMvItn.cItens
		Select crTpmMvIts
		Append From Dbf('TmpEsti2')
	Select crTpmMvItn
Select crTpmMvIts
	Select crTpmMvItn
		Select crTpmMvItn
		Delete For Empty(Cpros)
			Insert Into crTpmMvItn From Memvar
		Select crTpmMvItn
Select crTpmMvItn
Select cItens From crTpmMvItn Where cItem2 = _cItem2 Into Cursor xDelIte2
Select xDelIte2
	Select crTpmMvIts
	Seek ( xDelIte2.Citens )
		Delete 
		Seek ( xDelIte2.Citens )
Select crTpmMvItn
Delete For cItem2 = m.cItens
	Select crTpmMvIts
	Select CrSigSubMv
		Select crSigMvIte
	Select crTpmMvItn
		lcSql = [Select c.Mats, c.Qtds, c.Pesos, a.Qtds as QtdEti from (Select top 1 b.OriDopNums, b.EmpDopNums, a.Cbars, a.Qtds from SigOpEtq a ] +;
				[inner join SigMvHst b on a.cbars = b.codbarras ] +;
				[inner join SigMvItn d On d.EmpDopNums = a.EmpDopNums And d.codbarras = a.cbars ] +;
				[inner join SigSubMv c on c.EmpDopNums = d.empdopnums and c.citem2 = d.citens ]
		If ThisForm.ParentForm.podatamgr.Sqlexecute(lcsql,'CrTmpCompo') < 1
			lcSql = [select c.Mats, c.Qtds, c.Pesos, a.Qtds as QtdEti from SigOpEtq a inner join SigOpPic b on a.nops = b.nops and a.cbars = b.codbarras ] +;
					[inner join SigSubMv c on b.empdopnums = c.empdopnums and b.citens = c.citem2 ] +;
			If ThisForm.ParentForm.podatamgr.Sqlexecute(lcsql,'CrTmpCompo') < 1
		lcSql = [Select a.Mats, a.Qtds, a.Pesos, a.ObsOfs, a.pcompos From SigPrCpo a Inner Join SigCdGrp b On a.Cgrus = b.Cgrus ] + ;
				[Select a.Mats, a.Qtds, a.Pesos, a.ObsOfs, a.pcompos From SigPrCpo a Where a.Cpros in ] + ;
				[(Select a.Mats From SigPrCpo a Inner Join SigCdGrp b On a.Cgrus = b.Cgrus Where a.Cpros = ']+_Produto+[' And b.Semiacabs = 1]+ _Ordem +[) Order by a.Mats]		
		ThisForm.ParentForm.podatamgr.Sqlexecute(lcsql,'CrTmpCompo')
		lcSql = [Select Cgrus From SigOpGpo Where dopes = ']+TprMvCab.dopes+[']
		=ThisForm.ParentForm.podataMgr.SqlExecute(lcSql,'TmpgpOpe')
		Select tmpgpOpe
		Select CrTmpCompo
			lcQuerPro = [Select a.Cpros, a.Cgrus, a.Reffs, a.Situas, a.DtSituas, a.Cunis, a.Dpros, a.Pesoms, a.fvendas, a.fcustos, a.moepvs, ]+;
						[From SigCdPro a Inner Join SigCdGrp b on b.cGrus = a.cGrus ] +;
						[left join SigCdPsg c on a.sgrus = c.codigos ] + ;
			=ThisForm.ParentForm.PodataMgr.Sqlexecute(lcQuerPro,'CrTmpPro')
			lcSql = [Select a.*, b.Dgrus From SigOpGpo a, SigCdGrp b Where a.Dopes = ']+TprMvCab.Dopes+[' And a.Cgrus = b.Cgrus ]
			ThisForm.ParentForm.PodataMgr.Sqlexecute(lcSql,'crFilGrupos')
				Select crFilGrupos
			If llTemGru And Not Seek(CrTmpPro.Cgrus,'TmpGpOpe','Cgrus')
			Select crTpmMvItn
			Select crTpmMvItn
				lcSql = [Select Codigos from SigCdLpc Where lPrecos = ']+TprMvCab.lPrecos+[']
				lnErro = ThisForm.ParentForm.podatamgr.SqlExecute(lcSql,'CrTmplPre')
				lcwhere = [Select * From SigCdLpi Where Cpros = ']+CrTmpPro.Cpros+[' And LPrecos = ']+TprMvCab.lPrecos+[']
				lnErro = ThisForm.ParentForm.podatamgr.SqlExecute(lcWhere,'crSigCdLpi')
				Select crSigCdLpi
								lcQuery = [Select Moevs, Pvens From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[' And Ifors = ']+_Ct+[']
								=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
							lcQuery = [Select MoeQs, QtdEqs ] + ;
									    [From SigCdMoe ] + ;
							If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpMoe') < 1)
						lcQuery = [select customedioreais as csmedio, (select moedaps from sigcdpam) as csmoedas ] + ;
								[from customedio3 where cpros = ']+CrTmpPro.Cpros+[' ]
						If ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpProMd') < 1
					Select crTpmMvItn
			Select crTpmMvItn
			If( crTmpPro.nTipoJoals == 3 ) And Seek(_cItem2,[crTpmMvIts],[CItens]) and (not IsEmpty(crTpmMvIts.CodCors) or not IsEmpty(crTpmMvIts.CodTams))
				Select crTpmMvIts
			Select crTpmMvItn
		Select LocalBusLin
				Select crTpmMvItn
				Select crTpmMvItn
		Select crGrade
			Select crTpmMvItn
			Select crTpmMvItn
		Select * from crTpmMvItn where 0=1 into cursor TmpDesmem readwrite
		Select * from crTpmMvItn where cItem2 <> 0 into cursor TmpCompo
		Select crTpmMvItn
				Insert into TmpDesmem from memvar
				Select TmpCompo
				=Seek(crTpmMvItn.cItens)
					Select TmpDesmem
					Select TmpDesmem 
					Select crTpmMvIts
				Select crTpmMvIts
				Select CrSigSubMv
					Select crSigMvIte
		Select TmpDesmem
		Select crTpmMvIts
		Select crSigSubMv
			Select crSigMvIte
		Select crTpmMvItn
		Delete All
		Append From Dbf('TmpDesmem')
	Select crTpmMvItn && Tiago - 09/01/2010 - Incluído pq o cursor selecionado não era o crTpmMvItn
	Select crTpmMvItn
	Select crTpmMvItn
	If (ThisForm.ParentForm.PodataMgr.SQLExecute([Delete From SigCdPro Where CPros = ']+pPro+['], '') < 1)
	If (ThisForm.ParentForm.PodataMgr.SQLExecute([Delete From SigPrMdl Where CPros = ']+pPro+['] , '') < 1)
	If (ThisForm.ParentForm.PodataMgr.SQLExecute([Delete From SigCdPrf Where Produtos = ']+pPro+['] , '') < 1)
	If (ThisForm.ParentForm.PodataMgr.SQLExecute([Delete From SigPrCpo Where CPros = ']+pPro+['] , '') < 1)
	If (ThisForm.ParentForm.PodataMgr.SQLExecute([Delete From SigPrPmi Where CPros = ']+pPro+['] , '') < 1)
	If (ThisForm.ParentForm.PodataMgr.SQLExecute([Delete From SigPrCrr Where CPros = ']+pPro+['] , '') < 1)
	If (ThisForm.ParentForm.PodataMgr.SQLExecute([Delete From SigCdPft Where CPros = ']+pPro+['] , '') < 1)
	If (ThisForm.ParentForm.PodataMgr.SQLExecute([Delete From SigPrPrr Where CPros = ']+pPro+['] , '') < 1)
	If (ThisForm.ParentForm.PodataMgr.SQLExecute([Delete From SigPrVlm Where CPros = ']+pPro+['] , '') < 1)
	SELECT * from crsigexmvi where cpros = crTpmMvItn.cpros and empdopnums = lcEdn into cursor curaux
		Insert Into crsigexmvi (empdopnums, CPros, DPros, Qtds, Units, totas, cIdChaves) ;
SELECT crTpmMvItn	&& recupera base selecionada
Select crTpmMvItn
		Insert Into crTpmMvItn( Emps, Dopes, Numes, Citens ) ;
	Select crTpmMvItn
lcSql = [Select a.Mercs, b.Abrevs ] + ;
		  [From SigCdMop a, SigCdOpe b, SigOpCdc c ] + ;
If (ThisForm.ParentForm.PoDataMgr.SqlExecute(lcSql, [LocalMop]) < 1)
Select LocalMop
			Select LocalBus
lcSql = [Select ItSituas,CadProds,TabdObrigs,PrecoPs From SigCdOpe Where Dopes = ']+_pDopMult+[']
ThisForm.ParentForm.PodataMgr.Sqlexecute(lcSql,'LocalOpe')
lcSql = [Select ChkQtMinV From SigOpCdd Where Dopes = ']+_pDopMult+[']
ThisForm.ParentForm.PoDataMgr.SQLExecute(lcSql,'LocalOpe2')
lcSql = [Select Cpros,Situas,DtSituas,CProEqs,MoeVs,MoeCs,Moedas,mUltComps,CGrus,Linhas,Colecoes,Cunis,Cftios,Sgrus,CodFinP, LtMinsv, Encoms, Mostruario ]+;
		[From SigCdPro Where Cpros = ']+crTpmMvItn.Cpros+[']
ThisForm.ParentForm.PodataMgr.Sqlexecute(lcSql,'LocalPro')
Select crTpmMvItn
=Seek(_pDopMult,'TprMvCab3','Dopes')
	Select crTpmMvItn						    
	Select crTpmMvItn						    
	Select crTpmMvItn						    
	lcWhere = [Select * From SigOpTdt Where Codigos = ']+TprMvCab3.Tabds+[']
	lnErro = ThisForm.ParentForm.PodataMgr.SqlExecute(lcWhere,'crSigOpTdt')
	Select crSigOpTdt
	Select crSigOpTdt
	If Seek( TprMvCab3.Tabds + '4' + LocalPro.CPros ) Or ;
			Seek( TprMvCab3.Tabds + '9' + LocalPro.CodFinP ) Or ;
			Seek( TprMvCab3.Tabds + '1' + LocalPro.CGrus ) Or ;
			Seek( TprMvCab3.Tabds + '2' + LocalPro.Linhas ) Or ;
			Seek( TprMvCab3.Tabds + '3' + LocalPro.Colecoes ) Or ;
			Seek( TprMvCab3.TabDs + '5' + lcMoedas ) Or ;
			Seek( TprMvCab3.TabDs + '6' + LocalPro.Cunis ) Or ;
			Seek( TprMvCab3.TabDs + '7' + LocalPro.Cftios ) Or ;
			Seek( TprMvCab3.TabDs + '8' + LocalPro.Sgrus )
	=Seek(crTpmMvItn.AbrevAs,'CsPedidos','Abrevs')
	=Seek(xAntOpe,'TprMvCab3','Dopes')
Select crTpmMvItn
=Seek(_pDopMult,'TprMvCab3','Dopes')
			Delete
			Select CItens From crTpmMvItn Where cItem2 = _CItem Into Cursor xDelIte2
			Select xDelIte2
				Select crTpmMvIts
				Seek ( xDelIte2.CItens )
					Delete
					Seek ( xDelIte2.CItens )
			Select crTpmMvItn
			Delete For cItem2 = _CItem
			Select TmpOperacao
				Select xBaixa
				If Seek( _Cpro )
			Select crTpmMvIts
			Seek ( _CItem )
				Delete
				Seek ( _CItem )
			Select crSigMvItd
				Delete All For empdopnums = TprMvCab.empdopnums
			Select crTpmMvItn3
			Delete For crTpmMvItn3.CItens = _CItem
			Select crSigSubMv
			Delete For cItem2 = _CItem
				Select crSigMvIte
				Delete For CItens = _CItem
				lcSql = [Select Cpros From SigMvItn Where Cpros = ']+_Cpro+[' And EmpDopNums <> ']+TprMvCab.empdopnums+[']
				Thisform.ParentForm.PodataMgr.SqlExecute(lcSql,'LocEesti')
				lcSql = [Select Cpros From SigMvHst  Where Cpros = ']+_Cpro+[' And EmpDopNums <> ']+TprMvCab.empdopnums+[']
				Thisform.ParentForm.PodataMgr.SqlExecute(lcSql,'LocHis')
				lcSql = [Select Mats From SigPrCpo Where Mats = ']+_Cpro+[']
				Thisform.ParentForm.PodataMgr.SqlExecute(lcSql,'LocCompo')
		Select [ ] As Agrupar,Count(1) As Total From crTpmMvItn Where IsEmpty(cpros) Into Cursor xApaga Group By 1
			Select crTpmMvItn
			Delete
	Select crTpmMvItn
lcQuery = [Select Cunis, Cgrus, CodCors, CodTams, Mercs, Categoria ] + ;
	[From SigCdPro ] + ;
If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpProCt') < 1)
	lcQuery = [select a.*, b.descs ] + ;
		[from sigcarct a ] + ;
		[join sigcdctg b on a.categoria = b.cods ] + ;
	If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, [crTmpCarg]) < 1)
lnOldSel = Select()
Select crTpmMvItn
Select Opers, Sum(Totas) as Total From crTpmMvItn Group by Opers Into cursor csSumOpers Readwrite 
Select csSumOpers
	Select crTmpUsu
		Select crTmpCrg
Select(lnOldSel)
	lcQuery = [select Top 1 IsNull(DATEDIFF(d,datas,getdate()),0) as dias from sigmvhst where opers = 'S' and codbarras = ] + str(nBarra,14) + [ order by cidchaves desc ] 
	If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery,[csTMovimento]))<1
Select TmpOperacao
	lnOldSel = Select()
		Select *, Space(40) as Dpros from xBaixa2 ;
		Select cpros, Space(3) as CodCors, Space(3) as CodCors, qtds, qtbaixas, qtprods, Space(40) as Dpros ;
			From xBaixa Where cpros not in(Select cpros from xBaixa2 ) ;
		Select *, Space(40) As Dpros, Space(3) As CodTams, Space(3) As CodCors From xBaixa Where Cpros = _pcProd Into Cursor TmpItepen Readwrite
	Select TmpItepen
	Select Distinct a.Cpros, a.AbrevIs, Nvl(b.CodTams,[]) As CodTams, Sum(a.qtds) As qtds ;
		From crTpmMvItn a ;
		Left Join crTpmMvIts b On b.citens=a.citens And b.Cpros=a.Cpros ;
	Select ChecAbrev
		lcQuery = [select a.VldQtdAbrv from sigopcdi a join sigcdope b on a.dopes = b.dopes where b.abrevs = ']+ChecAbrev.AbrevIs+[' ]
		=Thisform.ParentForm.PoDataMgr.SqlExecute(lcQuery,[csVldAbr])
			Select a.* From TmpItepen a, ChecAbrev b ;
			Select csValQtAbr
			If Not Seek(Alltrim(ChecAbrev.Cpros) + Alltrim(ChecAbrev.CodTams),[TmpItepen],[ProTam])
		Select ChecAbrev
	Select(lnOldSel)
Select *, 000000000.00 As Parcelas, Space(10) As Tabds, Space(30) As lPrecos From crSigMvItn ;
Select lpItem
	.Column1.ControlSource = "LpItem.Lprecos"
	.Column2.ControlSource = "LpItem.Tabds"
	.Column3.ControlSource = "LpItem.Units"
	.Column4.ControlSource = "LpItem.Moedas"
	lcQuery = [Select * From SigCdLpi ]
	If Thisform.ParentForm.PodataMgr.SqlExecute(lcQuery,'TablPrei') > 0
		Select TablPrei
	lcQuery = [Select * From SigCdLpc ]
	If Thisform.ParentForm.PodataMgr.SqlExecute(lcQuery,'TablPre') > 0
		Select TablPre
lcQuery = [Select Top 1 * from SigCdFtc where cGrus = ']+TprMvCab.Dopes+[']
If Thisform.ParentForm.PodataMgr.SqlExecute(lcQuery,'crTmpFtc') < 0
Select crTmpFtc
lcQuery = [Select * From SigOpTde ]
If Thisform.ParentForm.PodataMgr.SqlExecute(lcQuery,'CrTabTabDe') > 0
	Select CrTabTabDe
lcQuery = [Select * From SigOpTdz ]
If Thisform.ParentForm.PodataMgr.SqlExecute(lcQuery,'CrTabTabd') > 0
	Select CrTabTabd
lcQuery = [Select * From SigOpTdt ]
If Thisform.ParentForm.PodataMgr.SqlExecute(lcQuery,'CrTabTabDi') > 0
	Select CrTabTabDi
Select crTpmMvItn
Select crTpmMvItn
	lcSql = [Select a.cDopes, a.cnivels, a.nCors, a.padraos, a.Mercs, a.opers, b.abrevs, b.CadProds from SigCdMop a, SigCdOpe b, SigOpCdc c ]+;
	If Thisform.ParentForm.PodataMgr.SqlExecute(lcSql,'CsPedidos') < 1
	Select CsPedidos
	Select Abrevs, Mercs, Sum(1) From CsPedidos Group By 1, 2 Having Sum(1) > 1 Into Cursor Totais
	Select Totais
	lcSql = [Select empdopnums From SigMvCab Where EmpDnCrds = ']+lcEmpDopNum2+[']
	If (Thisform.ParentForm.PodataMgr.SqlExecute(lcSql, 'CsTransf') < 1)
	Select Substr(empdopnums,4,20) As Dopes, Val(Right(empdopnums,6)) As Numes From CsTransf ;
	Select PedidosA
	Select * From TprMvCab Where 0=1 Into Cursor TprMvCab3 Readwrite
	Select TprMvCab3
	lcSql = [Select b.dopes, b.GruOrigs, b.ConOrigs, b.GruDests, b.ConDests, b.TabDescs, b.Tabdps ]+;
		[From SigCdMop a, SigCdOpe b, SigOpCdc c ]+;
	If Thisform.ParentForm.PodataMgr.SqlExecute(lcSql,'CsOpe') < 1
	Select CsOpe
		=Seek(CsOpe.Dopes,'PedidosA','Dopes')
		Insert Into TprMvCab3 (DataS, Emps, Dopes, GrupoOs, ContaOs, GrupoDs, ContaDs, lPrecos) Values ;
		Select CsPedidos
			Update crTpmMvItn Set AbrevIs = CsPedidos.Abrevs, ChkAbrevs = .T. Where AbrevIs = ' '
		Select CsPedidos
					Select crTpmMvItn
							Select LocalBus
Select crTpmMvItn
		.Produto.ControlSource    = 'crTpmMvItn.cpros'
		.Fator.ControlSource      = 'crTpmMvItn.fators'
		.Operacao.ControlSource   = 'crTpmMvItn.opers'
		.Qtd.ControlSource        = 'crTpmMvItn.qtds'
		.Peso.ControlSource       = 'crTpmMvItn.pesos'
		.Comprimento.ControlSource   = 'crTpmMvItn.Compris'
		.Valor.ControlSource      = 'crTpmMvItn.units'
		.Moeda.ControlSource      = 'crTpmMvItn.moedas'
		.Total.ControlSource      = 'crTpmMvItn.totas'
		.PesoTot.ControlSource    = 'crTpmMvItn.tpesos'
		.Item.ControlSource       = 'crTpmMvItn.CItens'
		.Unidade.ControlSource    = 'crTpmMvItn.cUnis'
		.UniPeso.ControlSource    = 'crTpmMvItn.cUnips'
		.Pedido.ControlSource     = 'crTpmMvItn.AbrevIs'
		.Descrs.ControlSource     = 'crTpmMvItn.DPros'
		.cor.ControlSource		  = 'crTpmMvItn.Codcors'
		.Local.ControlSource	  = 'crTpmMvItn.Locals'
		.LocalO.ControlSource	  = 'crTpmMvItn.LocalOs'
		.Tamanho.ControlSource	  = 'crTpmMvItn.CodTams'
		.Reserva.ControlSource	  = 'crTpmMvItn.QtReservas'	
		.Presente.ControlSource = 'crTpmMvItn.ckpresente'
		.Servico.ControlSource = 'crTpmMvItn.ckServico'
			Select CsPedidos
			.Peso.ControlSource       = 'crTpmMvItn.AliqIcms'
			.UniPeso.ControlSource    = 'crTpmMvItn.Icms'
			.ControlSource = 'crTpmMvItn.cpros'
			.ControlSource = 'crTpmMvItn.fators'
			.ControlSource = 'crTpmMvItn.opers'
			.ControlSource = 'crTpmMvItn.qtds'
			.ControlSource = 'crTpmMvItn.pesos'
			.ControlSource = 'crTpmMvItn.Compris'
			.ControlSource = 'crTpmMvItn.units'
			.ControlSource = 'crTpmMvItn.moedas'
			.ControlSource = 'crTpmMvItn.totas'
			.ControlSource = 'crTpmMvItn.tpesos'
			.ControlSource = 'crTpmMvItn.CItens'
			.ControlSource = 'crTpmMvItn.cUnis'
			.ControlSource = 'crTpmMvItn.cUniPs'
		.Pedido.ControlSource = 'crTpmMvItn.AbrevIs'
		.Descrs.ControlSource     = 'crTpmMvItn.DPros'
		.cor.ControlSource		  = 'crTpmMvItn.Codcors'
		.Tamanho.ControlSource	  = 'crTpmMvItn.CodTams'
		.Local.ControlSource	  = 'crTpmMvItn.Locals'
		.LocalO.ControlSource	  = 'crTpmMvItn.LocalOs'
		.Reserva.ControlSource	  = 'crTpmMvItn.QtReservas'	
		.Presente.ControlSource = 'crTpmMvItn.ckPresente'
		.Servico.ControlSource = 'crTpmMvItn.ckServico'
			Select CsPedidos
		.Peso.ControlSource       = 'crTpmMvItn.AliqIcms'
		.UniPeso.ControlSource    = 'crTpmMvItn.Icms'
Select TprMvCab
		Select crTpmMvItn
		Select TmpTotal
		Select crTpmMvItn
		lcQuery = [Select a.Cpros, a.Dpros, a.IdeCPros From SigCdPro a, SigCdGrp b ]+;
		If Thisform.ParentForm.PodataMgr.SqlExecute(lcQuery,'CsSigCdPro') < 1
		lcQuery = [Select a.Cpros, '                                        ' as Dpros, a.IdeCPros From SigCdPro a Where 0=1 ]
		If Thisform.ParentForm.PodataMgr.SqlExecute(lcQuery,'CsSigCdPro') < 1
	Select csSigCdPro
Select crTpmMvItn
	If Not Seek( This.Value, 'csSigOpTdz', 'Codigos' )
	If Seek(This.peantValue,'csSigOpTdz','Codigos') And csSigOpTdz.nParcs > 0
		Select xpar
		Update TprMvCab3 Set Tabds = This.Value
	Select crTpmMvItn
	Select crSigMvNfi
	Select TprMvCab
		Update TprMvCab3 Set TpFats = This.Value
	Select crTpmMvItn
	Select crSigMvNfi
	Select TprMvCab
		Update TprMvCab3 Set MoeIts = This.Value
	Select crTpmMvItn
	Select crSigMvNfi
	Select TprMvCab
llNotasObrig  = Seek(crTpmMvItn.Cpros,'csOpeAut','CPros')
	lcQuery = [Select Emps, Dopes, Numes From SigMvItn Where Notas = ']+lcNotas+[']
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTprMvCabi') < 1)
	Select CrTprMvCabi
		Select CrTprMvCabi
		If Seek(TprMvCab.Dopes) And CrTprMvCabi.Emps + CrTprMvCabi.Dopes + Str(CrTprMvCabi.Numes,6) # TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes,6)
			Select Count(1) As nTotal, Notas From crTpmMvItn ;
			Select CrTprMvCabi
			If Seek(CsOpeAut.Dopes) And ;
				Select Count(1) As nTotal, Cpros, Notas From crTpmMvItn ;
		lcSql = [Select a.Valos, a.Datas, a.EmpDopNums From SigMvCab a, SigCdOpe b, SigCdTom c Where a.Dopes = b.Dopes ]+;
		If ThisForm.ParentForm.Podatamgr.Sqlexecute(lcsql,'LocalEest') < 1
		Select LocalEest
				lcSql = [Select * From SigMvPar Where EmpdopNums = ']+LocalEest.EmpdopNums+[' and fPags = 'P']
				If ThisForm.ParentForm.Podatamgr.Sqlexecute(lcsql,'LocalPar') < 1
				Select LocalPar
				 	Insert Into xPar From Memvar
			Select crTpmMvItn
If ! (InList( ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR' ) And ( (Seek(crTpmMvItn.Cpros,'csOpeAut','CPros') And crSigCdOpe.EditDocs < 3 ) ;
	lcSql = [Select EmpDopNums from SigMvCab Where Numes = ]+Str(Nume,6)+[ And Dopes = ']+Dope+[']
	If ThisForm.ParentForm.PodataMgr.Sqlexecute(lcSql,'CsTprMvCab') < 1 Or Reccount('CsTprMvCab') = 0
		Select crTpmMvItn
        ( crTpmMvItn.Opers = 'E' Or Seek( crTpmMvItn.Cpros, 'csOpeAut', 'CPros' ) ) ) Or ;
		Select crTpmMvItn
        ( crTpmMvItn.Opers = 'E' Or Seek( crTpmMvItn.Cpros, 'csOpeAut', 'CPros' ) ) ) Or ;
		Select RecNo() As nRecNo From crTpmMvItn Where CodBarras = Int(Val(lnCBars)) Into Cursor csProcura
		Select RecNo() As nRecNo From crTpmMvItn Where Cpros = lcCpros Into Cursor csProcura
	Select csProcura
		Select crTpmMvItn
			Select crTpmMvItn
				lcQuery = [Select * ] + ;
					[From SigCdPro ] + ;
				If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpPro') < 1)
				lStrQuery = [Select a.CPros,a.CBars,a.CodTams,a.Contas ] + ;
					[From SigOpEtq a ] + ;
					[left join sigopeta b on a.cpros = b.cpros and a.cbars = b.cbars_new ] + ;
				If Thisform.ParentForm.poDataMgr.SqlExecute(lStrQuery,'CrEtiqs') < 1
				Select CrEtiqs
							Select crTpmMvItn
							Select Top 1 * From crTpmMvItn Where codbarras = 0 ;
							Select csAssocia
							Select crTpmMvItn
							Update crTpmMvItn set codbarras = Val(_Prod) Where cidchaves = csAssocia.cidchaves
							Select crTpmMvIts
							Update crTpmMvIts set codbarras = Val(_Prod) Where cItens = csAssocia.cItens
				Select crTpmMvItn
					lcQuery = [Select * ] + ;
						[From SigCdPro ] + ;
					If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpPro') < 1)
					Select crTpmMvIts
						lcQuery = [Select * ] + ;
							[From SigCdPro ] + ;
						If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpPro') < 1)
						lcQuery = [Select * ] + ;
							[From SigCdPro ] + ;
						If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpPro') < 1)
					Select crTpmMvIts
			Select crTpmMvItn
			lcQuery = [Select * ] + ;
				[From SigCdPro ] + ;
			If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpPro') < 1)
				lcQuery = [Select * ] + ;
					[From SigCdUni ] + ;
				If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrSigCdUni') < 1)
				lcQuery = [Select * ] + ;
					[From SigCdPro ] + ;
				If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpPro') < 1)
			lcSql = [Select Cpros From SigCdPro Where Ean13 = ]+Str(Val(cpro),13)
			If Thisform.ParentForm.poDataMgr.SqlExecute(lcSql,'CrTmpPro') < 1
			Select CrTmpPro
				lcSql = [Select Cpros From SigCdPro Where Cbars = ]+Str(Val(cpro),14)
				If Thisform.ParentForm.poDataMgr.SqlExecute(lcSql,'CrTmpPro') < 1
				Select CrTmpPro
		lcQuery = [Select * ] + ;
			[From SigCdPro ] + ;
		If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpPro') < 1)
			lcQuery = [Select * ] + ;
				[From SigCdUni ] + ;
			If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrSigCdUni') < 1)
Select crTpmMvItn
		Select crTpmMvIts
				Select crTpmMvIts
				Select crTpmMvItn
				Update crTpmMvItn set iconfs = .T. where crTpmMvItn.Cpros = crTpmMvIts.Cpros and crTpmMvItn.cItens = crTpmMvIts.cItens And crTpmMvItn.EmpDopNums = crTpmMvIts.EmpDopNums
	Select crTpmMvItn
lcSql = [Select a.cpros,a.dpros,a.FigJpgs From SigCdPro a Where a.cpros = ']+lcCodPro+[' ]
ThisForm.ParentForm.Podatamgr.Sqlexecute(lcsql,'LocalPro')
			Delete File (lcArquivo)
lnOldSel = Select()
Select(lnOldSel)
SELECT crTpmMvItn
		Select crTpmMvItn
		Update crTpmMvItn Set AltImpost = .f.
		Select crTpmMvItn
		Select crTpmMvItn
Select crTpmMvItn
SELECT xBaixa
lnOldSel = Select()
Delete From crTpmMvItn
Delete From crTpmMvIts
	If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalLanca') < 1)
	Select LocalLanca
		Insert Into crTpmMvItn (Opers, Emps, Dopes, Numes, EmpDopNums, CItens, CPros, DPros, ;
			Insert Into crTpmMvIts ( CItens, CPros, Emps, Dopes, Numes, Qtds, QtdEmbs, Pesos, Codcors, CodTams, CodEmbs, CodBarras ) ;
			Select ([BKPMVITN.DBF])
		Select BKPMVITN
			Insert Into crTpmMvItn From Memvar
			Select ([BKPMVITS.DBF])
		Select BKPMVITS
			Insert Into crTpmMvIts From Memvar
		Select LocalLanca
		Select * From xlResults Into Cursor LocalLanca Readwrite
			Select LocalLanca
			Select Distinct Left(Alltrim(Empds),3) As Empds From LocalLanca Where Not IsEmpty(Empds) Into Cursor EmpsDest Readwrite
			Select EmpsDest
					Select TprMvCab
		Select LocalLanca
				lcQuery = [Select Dpros, Cunis, Cunips, Moevs, Cpros, cGrus, sGrus, PesoMs, CustoFs From SigCdPro ] + ;
				If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'ProdImport') < 1)
					lcQuery = [Select * From SigCdUni Where CUnis = '] + ProdImport.CUnis + [' Order By Etiqs]
					If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpUni') < 1)
					lcQuery = [Select TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, mtPrimas, LocalPdr ] + ;
						[From SigCdGrp ] + ;
					If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpGru') < 1)
						Select LocalLanca
						lcQuery = [Select * From SigCdTam Where Cods = ']+lcTam+[' ]
						If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpTam') < 1)
						Select crTmpTam
						lcQuery = [Select * From SigCdCor Where Cods = ']+lcCor+[' ]
						If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpCor') < 1)
						Select crTmpCor
						lcQuery = [select Localizas, cbars from SigOpEtq Where Cbars = ]+Alltrim(Str(lnCodBarra,14))
						If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'csBarra') < 1)
						Select csPrSemCT
							Insert Into crTpmMvItn (Opers, Emps, Dopes, Numes, EmpDopNums, CItens, CPros, DPros, CUnis, Fatvals, ;
						Insert Into crTpmMvItn (Opers, Emps, Dopes, Numes, EmpDopNums, CItens, CPros, DPros, CUnis, Fatvals, ;
										Insert Into crTpmMvIts ( CItens, CPros, Emps, Dopes, Numes, Qtds, QtdEmbs, Pesos, Codcors, CodTams, CodEmbs, locals, CodBarras ) ;
								Insert Into crTpmMvIts ( CItens, CPros, Emps, Dopes, Numes, Qtds, QtdEmbs, Pesos, Codcors, CodTams, CodEmbs, locals, CodBarras ) ;
					Select csPrNAOCad
			Select LocalLanca
Select csPrNAOCad
	Select csPrNAOCad
Select csPrSemCT
	Select csPrSemCT
Select(lnOldSel)
lnOldSel = Select()
Delete From crTpmMvItn
Delete From crTpmMvIts
Select crItensFor
Select crItensIna
	lcNota   	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/ide/nNF").Text
	lcSerie  	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/ide/serie").Text
	lcEmis 	 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/ide/dhEmi").Text
	lcUf	 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/ide/cUF").Text
	lcNatOp  	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/ide/natOp").Text
	lcCodMun 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/ide/cMunFG").Text
	lcEmissor 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/xNome").Text
	lcCnpj		= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/CNPJ").Text
	lcIe 	 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/IE").Text
	lcCrt		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/CRT").Length > 0,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/CRT").Text, '')
	lcEndes	 	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/xLgr").Length > 0	,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/xLgr").Text, '')
	lcNumero	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/nro").Length > 0	,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/nro").Text, '')
	lcBairro	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/xBairro").Length > 0,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/xBairro").Text, '')
	lcCmun		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/cMun").Length > 0	,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/cMun").Text, '')
	lcMunic		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/xMun").Length > 0	,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/xMun").Text, '')
	lcEstas		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/UF").Length > 0		,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/UF").Text, '')
	lcCEP		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/CEP").Length > 0	,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/CEP").Text, '')
	lcPais		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/xPais").Length > 0	,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/xPais").Text, '')
	lcFone		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/fone").Length > 0	,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/fone").Text, '')
	lcDest		= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/xNome").Text
	lcCNPJDest	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/CNPJ").Text
	lcIEDest	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/IE").Text
	lcEndDest	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/enderDest/xLgr").Text
	lcNumDest	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/enderDest/nro").Text
	lcBaiDest	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/enderDest/xBairro").Text
	lcCMunDest 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/enderDest/cMun").Text
	lcMunicDest = OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/enderDest/xMun").Text
	lcUfDest	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/enderDest/UF").Text
	lcCEPDest	= Iif(OXML.SelectNodes("/nfeProc/NFe/infNFe/dest/enderDest/CEP").Length > 0,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/enderDest/CEP").Text, '')
	lcPaisDest	= Iif(OXML.SelectNodes("/nfeProc/NFe/infNFe/dest/enderDest/xPais").Length > 0,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/enderDest/xPais").Text, '')
	lcBaseCalc 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vBC").Text
	lcICMS 		= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vICMS").Text
	lcBaseST 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vBCST").Text
	lcICMSST 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vST").Text
	lcValorUnit = OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vProd").Text
	lcFrete 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vFrete").Text
	lcSeguro 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vSeg").Text
	lcDescontos = OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vDesc").Text
	lcIImport 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vII").Text
	lcIPI 		= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vIPI").Text
	lcPIS 		= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vPIS").Text
	lcCOFINS 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vCOFINS").Text
	lcOUTROS 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vOutro").Text
	lcVTOTAL 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vNF").Text
	lcChave		= OXML.SELECTSINGLENODE("/nfeProc/protNFe/infProt/chNFe").Text
	Select crItens
	lnOldSel = Select()
			lcQuery = [select EmpDopNums From SigMvCab Where ChaveNota = ']+lcChave+[' And Dopes = ']+crTpmMvItn.Dopes+[' And EmpDopNums <> ']+crTpmMvItn.EmpDopNums+[']
			If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpChv') < 1)
				Select(lnOldSel)
	Select(lnOldSel)
	qt_itens = OXML.SelectNodes("//nfeProc/NFe/infNFe/det").Length && conta quantidade de itens na nota
		oXmlTemp = OXML.SelectNodes("//nfeProc/NFe/infNFe/det").Item(i)
		Replace codigo		With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/cProd").Item(i).Text
		Replace Descr		With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/xProd").Item(i).Text
		Replace quant		With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/qCom").Item(i).Text
		Replace valor_uni	With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vUnCom").Item(i).Text
		Replace valor_tot	With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vProd").Item(i).Text
		Replace unid		With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/uCom").Item(i).Text
		Replace cfop		With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/CFOP").Item(i).Text
		Replace ncm			With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/NCM").Item(i).Text
		If oXmlTemp.SelectNodes("prod/vDesc").Length > 0
			Replace desconto	With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vDesc").Item(lnContaDesconto).Text
			Replace valor_desc	With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vDesc").Item(lnContaDesconto).Text
				lnvBC 		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS00/vBC").Length >   0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS00/vBC").Item(i).text, '')
				lnpICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS00/pICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS00/pICMS").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS00/vICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS00/vICMS").Item(i).text, '')
				lnvBC 		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS10/vBC").Length >   0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS10/vBC").Item(i).text, '')
				lnpICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS10/pICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS10/pICMS").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS10/vICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS10/vICMS").Item(i).text, '')
				lnvBC 		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS20/vBC").Length >   0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS20/vBC").Item(i).text, '')
				lnpICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS20/pICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS20/pICMS").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS20/vICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS20/vICMS").Item(i).text, '')
				lnvBC 		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS30/vBCST").Length >   0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS30/vBCST").Item(i).text, '')
				lnpICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS30/pICMSST").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS30/pICMSST").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS30/vICMSST").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS30/vICMSST").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS40/vICMSDeson").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS40/vICMSDeson").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS41/vICMSDeson").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS41/vICMSDeson").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS50/vICMSDeson").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS50/vICMSDeson").Item(i).text, '')
				lnvBC 		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS51/vBC").Length >   0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS51/vBC").Item(i).text, '')
				lnpICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS51/pICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS51/pICMS").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS51/vICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS51/vICMS").Item(i).text, '')
				lnvBC 		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS60/vBCSTRet").Length >   0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS60/vBCSTRet").Item(i).text, '')
				lnpICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS60/pST").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS60/pST").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS60/vICMSSTRet").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS60/vICMSSTRet").Item(i).text, '')
				lnvBC 		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS70/vBC").Length >   0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS70/vBC").Item(i).text, '')
				lnpICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS70/pICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS70/pICMS").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS70/vICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS70/vICMS").Item(i).text, '')
				lnvBC 		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS90/vBC").Length >   0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS90/vBC").Item(i).text, '')
				lnpICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS90/pICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS90/pICMS").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS90/vICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMS90/vICMS").Item(i).text, '')
				lnvBC 		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSPart/vBC").Length >   0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSPart/vBC").Item(i).text, '')
				lnpICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSPart/pICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSPart/pICMS").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSPart/vICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSPart/vICMS").Item(i).text, '')
				lnvBC 		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSST/vBCSTRet").Length >   0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSST/vBCSTRet").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSST/vICMSSTRet").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSST/vICMSSTRet").Item(i).text, '')
				lnpICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN101/pCredSN").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN101/pCredSN").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN101/vCredICMSSN").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN101/vCredICMSSN").Item(i).text, '')
				lnvBC 		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN102/vBC").Length >   0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN102/vBC").Item(i).text, '')
				lnpICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN102/pICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN102/pICMS").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN102/vICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN102/vICMS").Item(i).text, '')
				lnvBC 		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN201/vBCST").Length >   0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN201/vBCST").Item(i).text, '')
				lnpICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN201/pICMSST").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN201/pICMSST").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN201/vICMSST").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN201/vICMSST").Item(i).text, '')
				lnvBC 		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN202/vBCST").Length >   0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN202/vBCST").Item(i).text, '')
				lnpICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN202/pICMSST").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN202/pICMSST").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN202/vICMSST").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN202/vICMSST").Item(i).text, '')
				lnvBC 		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN500/vBCSTRet").Length >   0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN500/vBCSTRet").Item(i).text, '')
				lnpICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN500/pST").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN500/pST").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN500/vICMSSTRet").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN500/vICMSSTRet").Item(i).text, '')
				lnvBC 		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN900/vBC").Length >   0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN900/vBC").Item(i).text, '')
				lnpICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN900/pICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN900/pICMS").Item(i).text, '')
				lnvICMS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN900/vICMS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN900/vICMS").Item(i).text, '')
				lnvICMSSt	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN900/vICMSST").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/ICMS/ICMSSN900/vICMSST").Item(i).text, '')
				lnvBCPIs	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/PIS/PISAliq/vBC").Length >   0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/PIS/PISAliq/vBC").Item(i).text, '')
				lnpPIS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/PIS/PISAliq/pPIS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/PIS/PISAliq/pPIS").Item(i).text, '')
				lnvPIS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/PIS/PISAliq/vPIS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/PIS/PISAliq/vPIS").Item(i).text, '')
				lnpPIS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/PIS/PISQtde/vAliqProd").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/PIS/PISQtde/vAliqProd").Item(i).text, '')
				lnvPIS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/PIS/PISQtde/vPIS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/PIS/PISQtde/vPIS").Item(i).text, '')
				lnvBCPIs	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/PIS/PISOutr/vBC").Length >  0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/PIS/PISOutr/vBC").Item(i).text, '')
				lnpPIS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/PIS/PISOutr/pPIS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/PIS/PISOutr/pPIS").Item(i).text, '')
				lnvPIS		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/PIS/PISOutr/vPIS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/PIS/PISOutr/vPIS").Item(i).text, '')
				lnvBCCofins	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/COFINS/COFINSAliq/vBC").Length >     0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/COFINS/COFINSAliq/vBC").Item(i).text, '')
				lnpCofins	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/COFINS/COFINSAliq/pCOFINS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/COFINS/COFINSAliq/pCOFINS").Item(i).text, '')
				lnvCofins	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/COFINS/COFINSAliq/vCOFINS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/COFINS/COFINSAliq/vCOFINS").Item(i).text, '')
				lnpCofins	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/COFINS/COFINSQtde/vAliqProd").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/COFINS/COFINSQtde/vAliqProd").Item(i).text, '')
				lnvCofins	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/COFINS/COFINSQtde/vCOFINS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/COFINS/COFINSQtde/vCOFINS").Item(i).text, '')
				lnvBCCofins	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/COFINS/COFINSOutr/vBC").Length >  0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/COFINS/COFINSOutr/vBC").Item(i).text, '')
				lnpCofins	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/COFINS/COFINSOutr/pCOFINS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/COFINS/COFINSOutr/pCOFINS").Item(i).text, '')
				lnvCofins	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/COFINS/COFINSOutr/vCOFINS").Length > 0,OXML.SelectNodes("//nfeProc/NFe/infNFe/det/imposto/COFINS/COFINSOutr/vCOFINS").Item(i).text, '')
	Select(lnOldSel)
lcQuery = [select grupos, iclis, rclis, cpfs from sigcdcli where replace(replace(replace(cpfs,'-',''),'/',''),'.','') = ']+Alltrim(lcCnpj)+[' ]
If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpcli') < 1)
Select crItens
		lcQuery = [Select Dpros, Cunis, Cunips, Moevs, Cpros, CGrus, Custofs, CustoCp, moecusfs, Situas, iFors From SigCdPro Where Reffs = '] + lcProd + [']
		If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'ProdImport') < 1)
		Select ProdImport
			lcQuery = [Select b.Dpros, b.Cunis, b.Cunips, b.Moevs, b.Cpros, b.CGrus, b.Custofs, b.CustoCp, b.moecusfs, b.Situas, b.iFors from SigPrFnc a join sigcdpro b on a.cpros = b.cpros Where a.Reffs = '] + lcProd + [']
			If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'ProdImport') < 1)
		Select ProdImport
			lcQuery = [Select Dpros, Cunis, Cunips, Moevs, Cpros, CGrus, Custofs, CustoCp, moecusfs, Situas, iFors From SigCdPro Where Cpros = '] + lcProd + [']
			If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'ProdImport') < 1)
					If Not Seek(ProdImport.Cpros,[crItensIna],[Codigo])
						Insert into crItensFor( Codigo, Descr ) Values (ProdImport.Cpros,ProdImport.Dpros)
				If Not Seek(ProdImport.Cpros,[crItensIna],[Codigo])
					Insert into crItensIna( Codigo, Descr ) Values (ProdImport.Cpros,ProdImport.Dpros)
			lcQuery = [Select * From SigCdUni Where CUnis = '] + lcCunis + [' Order By Etiqs]
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpUni') < 1)
			lcQuery = [Select TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, mtPrimas, LocalPdr, VarCustoTs ] + ;
					    [From SigCdGrp ] + ;
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpGru') < 1)
				lcQuery = [Select * From SigCdTam Where Cods = ']+lcTam+[' ]
				If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpTam') < 1)
				Select crTmpTam
				lcQuery = [Select * From SigCdCor Where Cods = ']+lcCor+[' ]
				If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpCor') < 1)
				Select crTmpCor
					Insert Into crTpmMvItn (Opers, Emps, Dopes, Numes, EmpDopNums, CItens, Cpros, DPros, Cunis, Fatvals, ;
				Insert Into crTpmMvItn (Opers, Emps, Dopes, Numes, EmpDopNums, CItens, Cpros, DPros, Cunis, Fatvals, ;
			Select csPrNAOCad
	Select crItens
Select csPrNAOCad
	Select csPrNAOCad
Select crTpmMvIts
Delete From crTpmMvIts Where Empty(Cpros)
	SELECT cpros, SUM(qtds) as qtds from crEesti where !EMPTY(cpros) group by cpros into cursor crItSn order by cpros
		SELECT crItSn 
		SELECT cpros, SUM(qtds) as qtds from crTpmMvItn group by cpros into cursor crItXml order by cpros
		SELECT 'Produto Inativo: '+a.cpros as Diferencas from crItXml a, crItensIna b where a.cpros = b.codigo ;
		SELECT 'Produto de Outro Fornecedor: '+a.cpros as Diferencas from crItXml a, crItensFor b where a.cpros = b.codigo ;
		SELECT 'Produto inexistente no subnivel: '+cpros as Diferencas from crItXml where cpros not in (select cpros from crItSn) ;
		SELECT 'Produto Com quantidade diferente: '+a.cpros as Diferencas from crItXml a, crItSn b where a.cpros = b.cpros And a.qtds <> b.qtds ;
		SELECT 'Produto inexistente no Xml: '+cpros as Diferencas from crItSn where cpros not in (select cpros from crItXml) into cursor crItnDif
Select TprMvCab
lcQuery = [select cemps from sigcdemp where replace(replace(replace(cgcs,'-',''),'/',''),'.','') = ']+Alltrim(lcCNPJDest)+[' ]
If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpEmp') < 1)
Select crTpmMvItn
Delete From crTpmMvItn Where Empty(Cpros)
Select crTpmMvItn
	Select crSigMvNfi
	Select TprMvCab
Select(lnOldSel)
If Not ThisForm.parentform.poDataMgr.Update([crSigOpFnl])
	=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigOpFnl)])
Select crTpmMvIts
	Select crGrade
Select crSigSubMv
lcQuery = [Select a.Cpros, a.CGrus, a.Reffs, a.Situas, a.DtSituas, a.CUnis, a.Dpros, a.PesoMs, a.FVendas, a.FCustos, a.MoePvs, ] + ;
		    [From SigCdPro a Left Join SigCdCol b On a.Colecoes = b.Colecoes ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [crTmpPro]) < 1)
lcQuery = [Select TipoEstos, Mercs, cores, tams, embs, cgrus, dgrus, Pesos, Entregas, Arreds From SigCdGrp Where Cgrus = ']+CrTmpPro.Cgrus+[']
=ThisForm.ParentForm.PodataMgr.SqlExecute(lcQuery,'CrTmpGru')
lcQuery = [Select Reffs From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[' And Ifors = ']+_Ct+[']
=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
lcQuery = [Select e.Sqtds ] + ;
			[From SigCdPro p ] + ;
			[Left Join SigMvEst e On e.CPros = p.CPros And ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca1]) < 1)
lcQuery = [Select RClis From SigCdCli Where Iclis = ']+CrTmpPro.Ifors+[' ]
=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFor')
Select crTpmMvItn
	Select LpItem
Select crTpmMvIts
Select crTpmMvItn
		lcQuery = [Select Descricaos ] + ;
				    [From SigCdClf ] + ;
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalClf]) < 1)
		Select LocalClf
	lcQuery = [Select Mats ] + ;
			    [From SigPrCpo ] + ;
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalCompo]) < 1)
Select crTpmMvItn
Select crTpmMvItn
		lcSql = [Select Cpros, cproeqs From SigCdPro where Cpros = ']+crTpmMvItn.Cpros+[']
		If ThisForm.ParentForm.podatamgr.sqlexecute(lcsql,'CrtmpPro') > 0
		lcQuery = [Select Cunis, Cgrus, CodCors, CodTams, Mercs ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpPro') < 1)
		lcQuery = [Select * ] + ;
				    [From SigCdUni ] + ;
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpUni') < 1)
		lcQuery = [Select TipoEstos, Mercs, cores, tams, embs, cgrus, dgrus, Pesos, Entregas ] + ;
				    [From SigCdGrp ] + ;
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpGru') < 1)
					Select crTpmMvItn
					lcQuery = [Select Mats, Qtds, Pesos From SigPrCpo Where Cpros = '] + crTpmMvItn.CPros + [' ]+_Ordem+[Order By Mats]
					If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [crTmpCompo]) < 1)
					Select crTmpCompo
						Select crTpmMvItn
					Select crTpmMvItn
					lnOldSel = Select()
					Select(lnOldSel)
							  	Seek(crTpmMvItn.CPros, 'csOpeAut','CPros') ) ) Or ;
	Select crTpmMvItn
Select crTpmMvItn
lcQuery = [Select * ] + ;
		    [From SigCdOpe ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdOpe') < 1)
lcSql = [Select * From SigOpCdd Where Dopes = ']+TprMvCab.Dopes+[']
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcSql, 'crSigOpCdd') < 1)
lcSql = [Select * From SigOpCdI Where Dopes = ']+TprMvCab.Dopes+[']
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcSql, 'crSigOpCdI') < 1)
					Select crTpmMvIts
						Select xBaixa2
						If Seek( crTpmMvIts.Cpros + crTpmMvIts.CodCors + crTpmMvIts.CodTams, 'xBaixa2', 'CPros' )
					Select crTpmMvIts
					Delete For crTpmMvIts.CItens = crTpmMvItn.CItens
				Select crTpmMvItn3
				Delete For crTpmMvItn3.CItens = crTpmMvItn.CItens
				Select CrSigSubMv
				Delete For cItem2 = crTpmMvItn.CItens
					Select crSigMvIte
					Delete For Citens = crTpmMvItn.Citens
				Select TmpOperacao
					Select xBaixa
					If Seek( Padr(ThisForm.AntCPro,14) )
			Select crTpmMvItn
			Select crTpmMvItn
		Select crTpmMvItn
		If Seek( Val( This.Value ) ) And Recno() = _Recnx
			lcQuery = [Select c.AltEtiqs ] + ;
					    [From SigOpEtq a ] + ;
					    [left join SigOpEta d on a.cpros = d.cpros and a.cbars = d.cbars_new ] + ;
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalGgrp') < 1)
			Select crTpmMvItn
		lcQuery = [Select a.Cpros, a.Cbars From SigOpEtq a ] + ;
				[Left join SigOpEta d on a.cpros = d.cpros and a.cbars = d.cbars_new ] + ;
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crEtiqueta') < 1)
		lcQuery = [Select a.Empos, a.Grupos, a.Contas, a.Cbars, a.Cpros, a.Qtds, a.Pesos, a.CodCors, a.CodTams, a.Peso2s, b.cproEqs, a.CustoFs, a.Localizas ] + ;
				    [From SigOpEtq a ] + ;
				    [Left join SigOpEta d on a.cpros = d.cpros and a.cbars = d.cbars_new ] + ;
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpEti') < 1)
			Select crTpmMvItn
			If Seek( Val( This.Value ) ) And Recno() = _Recnx
				lcQuery = [Select c.AltEtiqs ] + ;
						    [From SigOpEtq a ] + ;
						    [left join SigOpEta d on a.cpros = d.cpros and a.cbars = d.cbars_new ] + ;
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalGgrp') < 1)
				Select crTpmMvItn
					lcQuery = [Select Cemps, Ativas ] + ;
							    [From SigCdEmp ] + ;
					If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'csTmpEmp') < 1)
						lcQuery = [Select Cemps, Ativas ] + ;
								    [From SigCdEmp ] + ;
						If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'csTmpEmp') < 1)
				lcQuery = [Select EmpDopNums, OriDopNums, CidChaves From SigMvHst Where CodBarras = ]+Str(CrTmpEti.cbars,14)+[ Order By CidChaves Desc ]
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crhis') < 1)
				Select crHis
					lcQuery = [Select Grupoos, Contaos ] + ;
							    [From SigMvCab ] + ;
					If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crEest') < 1)
				lcQuery = [Select EmpdopNums,CodBarras From SigMvItn Where CodBarras = ]+Str(CrTmpEti.Cbars)+[ And Dopes=']+crSigCdOpe.Dopes+[']
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery,'CrBarra') < 1)
				Select CrBarra
				lcUpDate = [UpDate SigOpEtq Set Usuars = ']+Usuar+[' Where Cbars = ]+Str(CrTmpEti.Cbars)
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcupdate,'') < 1)
			lcQuery = [Select a.Cpros, a.Cgrus, a.Reffs, a.Situas, a.DtSituas, a.Cunis, a.Dpros, a.Pesoms, a.FVendas, a.FCustos, a.Moepvs, a.iFors, ] + ;
					    [From SigCdPro a ] + ;
	    			  Iif(llRes, [Inner Join SigCdRpo b On (a.Cgrus = b.Cgrus Or a.Mercs = b.Mercs) And b.Dopps = '] + TprMvCab.Dopes + [' ],[]) + ;					   
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpPro') < 1)
				Select crTpmMvItn						    
				Select crTpmMvItn						    
				Select crTpmMvItn						    
				Select crTpmMvItn						    
				Select crTpmMvItn						    
					Select crTpmMvItn						    
			lcQuery = [Select Etiqs ] + ;
					    [From SigCdUni ] + ;
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpUni') < 1)
			lcQuery = [Select TpPesos,VlrFixos From SigCdLin ] + ;
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpLin') < 1)
			lcQuery = [Select TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, MtPrimas ] + ;
					    [From SigCdGrp ] + ;
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpGru') < 1)
				lcQuery = [Select a.Cpros, a.Cgrus, a.Reffs, a.Situas, a.DtSituas, a.Cunis, a.Dpros, a.Pesoms, a.FVendas, a.FCustos, a.Moepvs, ] + ;
						    [From SigCdPro a ] + ;
			    			  Iif(llRes, [Inner Join SigCdRpo b On (a.Cgrus = b.Cgrus Or a.Mercs = b.Mercs) And b.Dopps = '] + TprMvCab.Dopes + [' ],[]) + ;						   
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpPro') < 1)
				lcQuery = [Select Etiqs From SigCdUni Where CUnis = '] + crTmpPro.CUnis + [' Order By Etiqs]
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpUni') < 1)
				lcQuery = [Select TpPesos,VlrFixos From SigCdLin Where Linhas = '] + crTmpPro.Linhas + [' ]
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpLin') < 1)
				lcQuery = [Select TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas ] + ;
						    [From SigCdGrp ] + ;
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpGru') < 1)
				lcWhere = [Select * From SigOpTdt Where Codigos = ']+TprMvCab.Tabds+[']
				lnErro = ThisForm.ParentForm.PodataMgr.SqlExecute(lcWhere,'crSigOpTdt')
				Select crSigOpTdt
				Select crSigOpTdt
				If Seek( TprMvCab.Tabds + '4' + CrtmpPro.CPros ) Or ;
						Seek( TprMvCab.Tabds + '9' + CrTmpPro.CodFinP ) Or ;
						Seek( TprMvCab.Tabds + '1' + CrTmpPro.CGrus ) Or ;
						Seek( TprMvCab.Tabds + '2' + CrTmpPro.Linhas ) Or ;
						Seek( TprMvCab.Tabds + '3' + CrTmpPro.Colecoes ) Or ;
						Seek( TprMvCab.TabDs + '5' + lcMoedas ) Or ;
						Seek( TprMvCab.TabDs + '6' + CrTmpPro.Cunis ) Or ;
						Seek( TprMvCab.TabDs + '7' + CrTmpPro.Cftios ) Or ;
						Seek( TprMvCab.TabDs + '8' + CrTmpPro.Sgrus )
			lcQuery = [Select Ifors From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[']
			=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
			Select CrTmpFPro
			If ( crSigOpCdd.ChkIfors = 1 And CrTmpPro.Ifors <> TprMvCab.ContaOs And Not Seek(TprMvCab.ContaOs,'CrTmpFPro','Ifors') ) Or ;
				( crSigOpCdd.ChkIfors = 2 And CrTmpPro.Ifors <> TprMvCab.ContaDs And Not Seek(TprMvCab.Contads,'CrTmpFPro','Ifors') )
				Select crTpmMvIts
				Delete For crTpmMvIts.CItens = crTpmMvItn.CItens
				Insert Into crTpmMvIts ( CItens, Emps, Dopes, Numes, Cpros, Qtds, CodCors, ;
				Select crTpmMvIts
			lcQuery = [Select Cpros, Cgrus, Reffs, Situas, DtSituas, Cunis, Dpros, Pesoms, FVendas, FCustos, Moepvs, iFors, ] + ;
					    [From SigCdPro ] + ;
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpPro') < 1)
				lcQuery = [Select Cpros, Cgrus, Reffs, Situas, DtSituas, Cunis, Dpros, Pesoms, FVendas, FCustos, Moepvs, iFors, ] + ;
						    [From SigCdPro ] + ;
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpPro') < 1)
				lcQuery = [Select Etiqs ] + ;
						    [From SigCdUni ] + ;
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpUni') < 1)
							Select crTpmMvItn						    
							Select crTpmMvItn						    
							Select crTpmMvItn						    
							Select crTpmMvItn						    
							Select crTpmMvItn						    
							lcWhere = [Select * From SigOpTdt Where Codigos = ']+TprMvCab.Tabds+[']
							lnErro = ThisForm.ParentForm.PodataMgr.SqlExecute(lcWhere,'crSigOpTdt')
							Select crSigOpTdt
							Select crSigOpTdt
							If Seek( TprMvCab.Tabds + '4' + CrtmpPro.CPros ) Or ;
									Seek( TprMvCab.Tabds + '9' + CrTmpPro.CodFinP ) Or ;
									Seek( TprMvCab.Tabds + '1' + CrTmpPro.CGrus ) Or ;
									Seek( TprMvCab.Tabds + '2' + CrTmpPro.Linhas ) Or ;
									Seek( TprMvCab.Tabds + '3' + CrTmpPro.Colecoes ) Or ;
									Seek( TprMvCab.TabDs + '5' + lcMoedas ) Or ;
									Seek( TprMvCab.TabDs + '6' + CrTmpPro.Cunis ) Or ;
									Seek( TprMvCab.TabDs + '7' + CrTmpPro.Cftios ) Or ;
									Seek( TprMvCab.TabDs + '8' + CrTmpPro.Sgrus )
						lcQuery = [Select Ifors From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[']
						=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
						Select CrTmpFPro
						If ( crSigOpCdd.ChkIfors = 1 And CrTmpPro.Ifors <> TprMvCab.ContaOs And Not Seek(TprMvCab.ContaOs,'CrTmpFPro','Ifors') ) Or ;
							( crSigOpCdd.ChkIfors = 2 And CrTmpPro.Ifors <> TprMvCab.ContaDs And Not Seek(TprMvCab.Contads,'CrTmpFPro','Ifors') )
			lcSql = [Select Cpros,Dpros,Cunis,Situas, DtSituas,fVendas,fCustos,Pesoms,Moepcs,Moepvs,pvens,pvideals,Pcuss,cftios,sgrus,]+;
					[From SigCdPro Where Cbars = ]+Str(Val(This.Value),14)
			If ThisForm.ParentForm.Podatamgr.Sqlexecute(lcsql,'CrTmpPro') < 1
				lcSql = [Select Cpros, Ean13, cproeqs From SigCdPro Where Ean13 = ]+Str(Val(Cpro),13)
				If ThisForm.ParentForm.PodataMgr.SqlExecute(lcSql,'CrTmpPro') < 1
			Select CrTmpPro
				lcSql = [Select Cpros, cproeqs, FigJpgs From SigCdPro Where Cpros = ']+cpro+[']
				If ThisForm.ParentForm.PodataMgr.SqlExecute(lcSql,'CrTmpPro') < 1
				Select CrTmpPro
					lcsql = [select cpros, cproeqs, FigJpgs from SigCdPro where reffs = ']+lcreff+[']
					ThisForm.ParentForm.podatamgr.sqlexecute(lcsql,'crTmpPro')
			lcSql = [Select Cpros, cproeqs, FigJpgs From SigCdPro Where Cpros = ']+cPro+[']
			ThisForm.ParentForm.podatamgr.sqlexecute(lcsql,'crTmpPro')
				lcsql = [select cpros, cproeqs, FigJpgs from SigCdPro where reffs = ']+lcreff+[']
				ThisForm.ParentForm.podatamgr.sqlexecute(lcsql,'crTmpPro')
		lcQuery = [Select a.Cpros, a.Cgrus, a.Reffs, a.Situas, a.DtSituas, a.Cunis, a.Dpros, a.Pesoms, a.FVendas, a.FCustos, a.Moepvs, a.ifors, ] + ;
				    [From SigCdPro a ] + ;
    			  Iif(llRes, [Inner Join SigCdRpo b On (a.Cgrus = b.Cgrus Or a.Mercs = b.Mercs) And b.Dopps = '] + TprMvCab.Dopes + [' ],[]) + ;					    
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpPro') < 1)
						lcQuery = [Select a.reffs ] + ;
								    [From SigCdPro a ] + ;
						If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca]) < 1)
					lcQuery = [Select a.Cpros, a.DPros, a.Reffs, a.Reffs+a.CPros as RefPro, a.dpro2s ] + ;
								[From SigCdPro a ] + ;
				    			  Iif(llRes, [Inner Join SigCdRpo b On (a.Cgrus = b.Cgrus Or a.Mercs = b.Mercs) And b.Dopps = '] + TprMvCab.Dopes + [' ],[]) + ;								
					If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca]) < 1)
					Select LocalBusca
					lcQuery = [Select a.Cpros, a.DPros + '(' + a.Cpros + ')' as DPros, a.ObsPes, a.ObsPeds, a.PVens, a.Moevs, a.PCuss, a.Moecs, a.custofs ] + ;
								[From SigCdPro a ] + ;
				    			  Iif(llRes, [Inner Join SigCdRpo b On (a.Cgrus = b.Cgrus Or a.Mercs = b.Mercs) And b.Dopps = '] + TprMvCab.Dopes + [' ],[]) + ;								
					If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca]) < 1)
					Select LocalBusca
					lcQuery = [Select a.Cpros, a.DPros + '(' + a.Cpros + ')' as DPros, a.ObsPes, a.ObsPeds, e.Sqtds ] + ;
								[From SigCdPro a ] + ;
				    			 Iif(llRes, [Inner Join SigCdRpo b On (a.Cgrus = b.Cgrus Or a.Mercs = b.Mercs) And b.Dopps = '] + TprMvCab.Dopes + [' ],[]) + ;								
								[Left Join SigMvEst e On e.CPros = a.CPros And ] + ;
					If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca]) < 1)
					Select LocalBusca
					lcQuery = [Select a.Cpros, a.DPros + '(' + a.Cpros + ')' as DPros, a.ObsPes, a.ObsPeds, ] + ;
								[From SigCdPro a ] + ;
					    		Iif(llRes, [Inner Join SigCdRpo b On (a.Cgrus = b.Cgrus Or a.Mercs = b.Mercs) And b.Dopps = '] + TprMvCab.Dopes + [' ],[]) + ;								
								[Left Join SigMvEst e On e.CPros = a.CPros And ] + ;
					If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca1]) < 1)
					Select CPros, DPros, Padr(ObsPes, 17) as ObsPes, Padr(ObsPeds, 17) as ObsPeds, Sqtds, ;
					  From LocalBusca1 ;
					Select LocalBusca
						lcQuery = [Select a.DPros, a.Cpros, a.Linhas, e.Sqtds, a.PVens, a.MoeVs, a.Reffs, a.CUnis, a.CGrus ] + ;
									[From SigCdPro a ] + ;
						    		Iif(llRes, [Inner Join SigCdRpo b On (a.Cgrus = b.Cgrus Or a.Mercs = b.Mercs) And b.Dopps = '] + TprMvCab.Dopes + [' ],[]) + ;									
									[Left Join SigMvEst e On e.CPros = a.CPros And ] + ;
						If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca1]) < 1)
						Select .f. as Selecao, CPros, DPros, Linhas, Sqtds, PVens, MoeVs, Reffs, CUnis, CGrus ;
						  From LocalBusca1 ;
						Select LocalBusLin
						Select LocalBusLin
						Select crTpmMvItn
			lcQuery = [Select a.Cpros, a.Cgrus, a.Reffs, a.Situas, a.DtSituas, a.Cunis, a.Dpros, a.Pesoms, a.FVendas, a.FCustos, a.Moepvs, a.ifors, ] +;
					    [From SigCdPro a ] + ;
			    		 Iif(llRes, [Inner Join SigCdRpo b On (a.Cgrus = b.Cgrus Or a.Mercs = b.Mercs) And b.Dopps = '] + TprMvCab.Dopes + [' ],[]) + ;					    
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpPro') < 1)
				lcQuery = [Select Cpros, Cgrus, Reffs, Situas, DtSituas, Cunis, Dpros, Pesoms, FVendas, FCustos, Moepvs, ifors, ] + ;
						    [From SigCdPro ] + ;
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpPro') < 1)
			lcQuery = [Select Etiqs From SigCdUni Where CUnis = '] + crTmpPro.CUnis + [' Order By Etiqs]
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpUni') < 1)
		lcQuery = [Select TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, mtPrimas, LocalPdr ] + ;
				    [From SigCdGrp ] + ;
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpGru') < 1)
		lcQuery = [Select Etiqs ] + ;
				    [From SigCdUni ] + ;
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpUni') < 1)
				lcQuery = [Select a.Cpros, a.Cgrus, a.Reffs, a.Situas, a.DtSituas, a.Cunis, a.Dpros, a.Pesoms, a.FVendas, a.FCustos, a.Moepvs, a.ifors, ] + ;
						    [From SigCdPro a ] + ;
				    		 Iif(llRes, [Inner Join SigCdRpo b On (a.Cgrus = b.Cgrus Or a.Mercs = b.Mercs) And b.Dopps = '] + TprMvCab.Dopes + [' ],[]) + ;						    
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpPro') < 1)
					Select crTpmMvItn						    
					Select crTpmMvItn						    
					Select crTpmMvItn						    
					Select crTpmMvItn						    
			lcWhere = [Select * From SigOpTdt Where Codigos = ']+TprMvCab.Tabds+[']
			lnErro = ThisForm.ParentForm.PodataMgr.SqlExecute(lcWhere,'crSigOpTdt')
			Select crSigOpTdt
			Select crSigOpTdt
			If Seek( TprMvCab.Tabds + '4' + CrtmpPro.CPros ) Or ;
					Seek( TprMvCab.Tabds + '9' + CrTmpPro.CodFinP ) Or ;
					Seek( TprMvCab.Tabds + '1' + CrTmpPro.CGrus ) Or ;
					Seek( TprMvCab.Tabds + '2' + CrTmpPro.Linhas ) Or ;
					Seek( TprMvCab.Tabds + '3' + CrTmpPro.Colecoes ) Or ;
					Seek( TprMvCab.TabDs + '5' + lcMoedas ) Or ;
					Seek( TprMvCab.TabDs + '6' + CrTmpPro.Cunis ) Or ;
					Seek( TprMvCab.TabDs + '7' + CrTmpPro.Cftios ) Or ;
					Seek( TprMvCab.TabDs + '8' + CrTmpPro.Sgrus )
		lcQuery = [Select Ifors From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[']
		=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
		Select CrTmpFPro
		If ( crSigOpCdd.ChkIfors = 1 And CrTmpPro.Ifors <> TprMvCab.ContaOs And Not Seek(TprMvCab.ContaOs,'CrTmpFPro','Ifors') ) Or ;
			( crSigOpCdd.ChkIfors = 2 And CrTmpPro.Ifors <> TprMvCab.ContaDs And Not Seek(TprMvCab.Contads,'CrTmpFPro','Ifors') )
			    Not Seek(crBuscaPro.CGrus, 'crSigCdGrpFilter', 'CGrus'))
		lcSql = [Select Cpros, sum(QMins) as TT From SigCdMin Where Emps = ']+TprMvCab.EmpDs+[' And ]+;
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcSql, 'LocalPrEmp') < 1)
	lcQuery = [Select Cgrus, Opers, Mercs, Contas, CodCors, ContaOrig From SigCdRpo Where Dopps = ']+TprMvCab.Dopes+[']
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalRopt') < 1)
		Select LocalRopt
			SELECT Cgrus, Mercs FROM LocalRopt Where Contas = ' ' INTO CURSOR Selecao
			Select Selecao
				SELECT Cgrus, Mercs FROM LocalRopt Where Contas = TprMvCab.ContaDs INTO CURSOR Selecao2
				Select Selecao2
				SELECT Cgrus, Mercs FROM LocalRopt Where ContaOrig = TprMvCab.ContaOs INTO CURSOR Selecao3
				Select Selecao3
			lcQuery = [Select distinct dopps From SigCdRpo Where Exclus = 1 And (Cgrus = ']+CrTmpGru.Cgrus+[' Or ]+;
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalRoptG') < 1)
			Select LocalRoptG
			Select Cpros,Count(1) as Qt From crTpmMvItn Where Cpros = cpro and cItens <> _cit Into cursor Total Group by Cpros
			Select Total
					Select crTpmMvItn 
		select crTpmMvItn
				Select crTpmMvIts
				If Seek(crTpmMvItn.Citens)
					Delete While crTpmMvIts.CItens = crTpmMvItn.CItens
			Select CrSigSubMv
			Delete for citem2 = crTpmMvItn.CItens
				Select crSigMvIte
				Delete For Citens = crTpmMvItn.Citens
		Select crTpmMvItn
			lcSql = [Select Codigos From SigCdLpc where lPrecos = ']+TprMvCab.lPrecos+[']
			lnErro = ThisForm.ParentForm.podatamgr.SqlExecute(lcSql,'CrtmplPre')
			lcwhere = [Select * From SigCdLpi Where Cpros = ']+CrTmpPro.Cpros+[' And LPrecos = ']+TprMvCab.lPrecos+[']
			lnErro = ThisForm.ParentForm.podatamgr.SqlExecute(lcWhere,'crSigCdLpi')
			Select crSigCdLpi
							lcQuery = [Select Moevs, Pvens From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[' And Ifors = ']+_Ct+[']
							=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
						lcQuery = [Select MoeQs, QtdEqs ] + ;
								    [From SigCdMoe ] + ;
						If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpMoe') < 1)
							Select xBaixaEtq
							If Seek( crTpmMvItn.CodBarras )
					lcQuery = [select customedioreais as csmedio, (select moedaps from sigcdpam) as csmoedas ] + ;
							[from customedio3 where cpros = ']+CrTmpPro.Cpros+[' ]
					If ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpProMd') < 1
				Select crTpmMvItn
		Select crTpmMvItn
			lcQuery = [Select * From SigMvEst Where EmpGruEsts = ']+TprMvCab.Emps+TprMvCab.GrupoOs+TprMvCab.contaOs+[' ]+;
			ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'csTprMvCab')
			Select crTpmMvIts
			If Seek(crTpmMvItn.Citens)
				Delete While crTpmMvIts.CItens = crTpmMvItn.CItens
			Select CsTprMvCab
				Select CsTprMvCab
					Insert Into crTpmMvIts ( CItens, Emps, Dopes, Numes, Cpros, Qtds, CodCors, ;
			Select TmpOperacao
					Select xBaixaEtq
					If !Seek( crTpmMvItn.CodBarras ) Or crTpmMvItn.Qtds > xBaixaEtq.Qtds - xBaixaEtq.QtBaixas
					Select xBaixa
					If !Seek( crTpmMvItn.CPros ) Or crTpmMvItn.Qtds > xBaixa.Qtds - Iif(crSigCdOpe.BxParcials=3,xBaixa.QtProds,xBaixa.QtBaixas) + crTpmMvItn.aQtds
	Select crTpmMvItn
		SELECT Cgrus, Mercs, Opers FROM LocalRopt WHERE opers <> ' ' INTO CURSOR OpEntSai
		SELECT OpEntSai
		If Seek(crTpmMvItn.Cpros,'xBaixa','Cpros')
		Select crTpmMvItn
		Delete
			Insert Into crTpmMvItn(Emps,Dopes,Numes,CItens ) ;
			Select crTpmMvItn
		Select crTpmMvItn
			Select crTpmMvIts
			Select CrSigSubMv
				Select crSigMvIte
			Select crTpmMvItn
	Select crTmpPro
				Delete File (lcArquivo)
	Select crTpmMvItn
					Select crTpmMvIts
					Select crTpmMvItn
Select crTpmMvItn
Select crTpmMvItn
	llCProsAut = Seek(crTpmMvItn.Cpros,'csOpeAut','CPros')
lcQuery = [Select Desmembs ] + ;
		    [From SigCdUni ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpUni') < 1)
		   ( crTpmMvItn.Opers='S' And Seek(crTpmMvItn.Cpros,'csOpeAut','CPros') ) ) Or ;
			If (crTpmMvItn.Opers = 'S') And Empty(crTpmMvItn.Notas) And ( Seek(crTpmMvItn.Cpros,'csOpeAut','CPros') Or crSigCdOpe.Consers = 1)
		lcQuery = [Select b.CfgGerGprs ] + ;
				    [From SigCdPro a, SigCdGrp b ] + ;
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro') < 1)
	lcQuery = [Select b.CfgGerGprs ] + ;
			    [From SigCdPro a, SigCdGrp b ] + ;
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro') < 1)
	lcQuery = [Select Cunis, Cgrus, CodCors, CodTams,mercs,CodFinP, LtMinsv, mercs ] + ;
			    [From SigCdPro ] + ;
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpPro') < 1)
	lcQuery = [Select * ] + ;
			    [From SigCdUni ] + ;
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpUni') < 1)
	lcQuery = [Select TipoEstos, Mercs, cores, tams, embs, cgrus, dgrus, Pesos, Entregas ] + ;
			    [From SigCdGrp ] + ;
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpGru') < 1)
				lnOldSel = Select()
				Select(lnOldSel)
	Select crTpmMvItn
lcQuery = [Select Cpros, Cgrus, Reffs, Situas, DtSituas, Cunis, Dpros, Pesoms, FVendas, FCustos, Moepvs, mUltComps, vUltComps, ] + ;
		    [From SigCdPro ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpPro') < 1)
lcQuery = [Select Etiqs ] + ;
		    [From SigCdUni ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpUni') < 1)
lcQuery = [Select TpPesos From SigCdLin ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpLin') < 1)
lcQuery = [Select TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos ] + ;
		    [From SigCdGrp ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpGru') < 1)
lcQuery = [Select Cgrus, Mercs, Opers, Contas, CodCors, ContaOrig From SigCdRpo Where Dopps = ']+TprMvCab.Dopes+[' ]+;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalRopt') < 1)
SELECT LocalRopt
	Select * From LocalRopt Where Contas = ' ' Into Cursor Selecao
		SELECT Cgrus, Mercs, Opers FROM LocalRopt Where Contas = TprMvCab.ContaDs INTO CURSOR Selecao2
		Select Selecao2
		SELECT Cgrus, Mercs, Opers FROM LocalRopt Where ContaOrig = TprMvCab.ContaOs INTO CURSOR Selecao3
		Select Selecao3
Select crTpmMvItn
			lcQuery = [Select Empos, Grupos, Contas, Cbars, Cpros, Qtds, Pesos, CodCors, CodTams, Peso2s ] + ;
					    [From SigOpEtq ] + ;
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpEti') < 1)
						lcQuery = [Select Cemps, Ativas ] + ;
								    [From SigCdEmp ] + ;
						If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CsTmpEmp') < 1)
						lcQuery = [Select Cemps, Ativas ] + ;
								    [From SigCdEmp ] + ;
						If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'csTmpEmp') < 1)
				lcQuery = [Select EmpDopNums, OriDopNums, Empos, CidChaves From SigMvHst Where CodBarras = ]+Str(CrTmpEti.Cbars,14)+[ Order By CidChaves Desc ]
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crhis') < 1)
				Select crHis
					lcQuery = [Select Grupoos, Contaos ] + ;
							    [From SigMvCab ] + ;
					If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrEest') < 1)
				lcUpDate = [UpDate SigOpEtq Set Usuars = ']+Usuar+[' Where Cbars = ]+Str(CrTmpEti.Cbars)
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcupdate,'') < 1)
					Select crTpmMvItn
				lcQuery = [Select Empos, Grupos, Contas, Cbars, Cpros, Qtds, Pesos, CodCors, CodTams, Peso2s ] + ;
						    [From SigOpEtq ] + ;
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpEti') < 1)
					lcQuery = [Select EmpdopNums, CidChaves From SigMvHst Where CodBarras = ]+Str(CrTmpEti.Cbars,14)+[ Order By CidChaves Desc ]
					If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crhis') < 1)
					Select crHis
						lcQuery = [Select Grupoos, Contaos ] + ;
								    [From SigMvCab ] + ;
						If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrEest') < 1)
					lcUpDate = [UpDate SigOpEtq Set Usuars = ']+Usuar+[' Where Cbars = ]+Str(CrTmpEti.Cbars)
					If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcupdate,'') < 1)
						Select crTpmMvItn
				Select crTpmMvItn
Select crTpmMvItn
			  crTpmMvItn.Opers = 'S' And Seek( crTpmMvItn.Cpros, 'csOpeAut', 'CPros' ) ) ) Or ;
	If Empty(crTpmMvItn.Notas) And ( Seek(crTpmMvItn.Cpros,'csOpeAut','CPros') Or crSigCdOpe.Consers = 1)
Select crTpmMvItn
lcQuery = [Select Cpros, LtMinSv, Cgrus, Mercs From SigCdPro ] + ;
If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpPro2') < 1)
lcQuery = [Select * ] + ;
	[From SigCdOpe ] + ;
If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdOpe') < 1)
lcQuery = [Select Desmembs, BlqQtdFrac, CUnis ] + ;
	[From SigCdUni ] + ;
If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpUni') < 1)
lcQuery = [Select TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos ] + ;
	[From SigCdGrp ] + ;
If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpGru') < 1)
Select TmpOperacao
		Select xBaixa
		If !Seek( crTpmMvItn.CPros ) Or This.Value > xBaixa.Qtds - xBaixa.qtbaixas + Thisform.AntQtdBx
			lcSql = [Select Qtds, Pesos, aQtds, aPesos From SigOpEtq Where Cbars = ]+Str(crTpmMvItn.CodBarras)
			If (Thisform.ParentForm.poDataMgr.SqlExecute(lcSql, 'crTmpET') < 1)
			Select [] As Agrupar,Sum(Qtds)+This.Value As Qtds From crTpmMvItn Where CodBarras = lnBr And ;
			Select crTpmMvItn
				lcSql = [Select a.*, b.Dgrus From SigOpGpo a, SigCdGrp b Where a.Dopes = ']+TprMvCab.Dopes+[' And a.Cgrus = b.Cgrus ]
				Thisform.ParentForm.poDataMgr.SqlExecute(lcSql,'crFilGrupos')
					Select crFilGrupos
			Select crTpmMvIts
			Select crTpmMvItn && Tiago - 27/06/2012 - BenneFatto - Quando vai checar o estoque, a rotina olha a tabela que está em uso, e se for crTpmMvItn não checa o estoque por cor e tamanho, por isso seleciono a crTpmMvItn antes, e se tiver cor, seleciona a crTpmMvIts
				Select crTpmMvIts
			Select crTpmMvItn
		lcQuery = [Select a.Cpros, a.PesoMs, b.Fatdivs, a.Mercs From SigCdPro a, SigCdUni b ] + ;
		If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpPro') < 1)
		Select crTpmMvIts
		Select Top 1 * from crTpmMvIts Where CItens = crTpmMvItn.CItens Order by cItens Into Cursor cTmpBkpIts Readwrite
		Select crTpmMvIts
		Select CItens, Sum(Qtds) As Qtds From crTpmMvIts group by cItens Where CItens = crTpmMvItn.CItens Into Cursor cTmpQtdIts Readwrite
			Select crTpmMvIts
			If Seek(crTpmMvItn.Citens)
				Delete While crTpmMvIts.CItens = crTpmMvItn.CItens
				Select cTmpBkpIts
				Insert Into crTpmMvIts From Memvar 
			Seek(crTpmMvItn.CPros, 'csOpeAut','CPros') ) ) Or ;
			If Not Empty(crTpmMvItn.CPros) And (Seek(crTpmMvItn.CPros,'csOpeAut','CPros') Or crSigCdOpe.Consers=1 ) And Empty(crTpmMvItn.Notas)
	Select crTpmMvItn
		Select crTpmMvItn
		Select * From crSigSubMv Where Citem2 = _Item2 Into Cursor crTmpCompo
			lcQuery = [Select a.Mats, a.Qtds, a.Pesos, a.ObsOfs From SigPrCpo a ] + ;
				[Inner Join SigCdGrp b On a.Cgrus = b.Cgrus Where a.Cpros = '] + crTpmMvItn.CPros + [' And b.Semiacabs <> 1 ] + _Ordem + ;
				[Select a.Mats, a.Qtds, a.Pesos, a.ObsOfs From SigPrCpo a Where a.Cpros in ] + ;
				[(Select a.Mats From SigPrCpo a Inner Join SigCdGrp b On a.Cgrus = b.Cgrus Where a.Cpros = '] + crTpmMvItn.CPros + [' And b.Semiacabs = 1]+_Ordem+[) Order by a.Mats]
			If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, [crTmpCompo]) < 1)
		Select crTmpCompo
			Select crTpmMvItn
				Select crTpmMvIts
				Select crTpmMvItn
		Select crTpmMvItn
lcQuery = [Select Cgrus, Cunis, mercs, LtMinsv ] + ;
		    [From SigCdPro ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpPro') < 1)
lcQuery = [Select TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos ] + ;
		    [From SigCdGrp ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpGru') < 1)
Select crTpmMvItn
		lcSql = [Select Qtds, Pesos, aQtds, aPesos From SigOpEtq Where Cbars = ]+Str(crTpmMvItn.CodBarras)
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcsql, 'crTmpET') < 1)
		Select [] as Agrupar,Sum(Pesos)+This.Value as Pesos From crTpmMvItn where CodBarras = lnBr And ;
	llCProsAut = Seek(crTpmMvItn.Cpros,'csOpeAut','CPros')
			lcQuery = [Select a.Cpros, a.PesoMs, b.FatDivs, a.mercs From SigCdPro a, SigCdUni b ] + ;
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpPro') < 1)
					INSERT into crTabVar (pesoi, pesof,var) values (lnPesoi, lnPesof,lnVar)
			SELECT * from crTabVar where lnPesom between pesoi and pesof into cursor crTabVar
			lcQuery = [Select a.Cpros, a.PesoMs, b.FatDivs, a.mercs From SigCdPro a, SigCdUni b ] + ;
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpPro') < 1)
			lcQuery = [Select a.Cpros, a.PesoMs, a.Mercs From SigCdPro a Where a.CPros = '] + crTpmMvItn.CPros + [']
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpPro') < 1)
 				Select crTpmMvIts
	lcQuery = [Select * ] + ;
			    [From SigCdUni ] + ;
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpUni') < 1)
lcQuery = [Select * ] + ;
		    [From SigCdUni ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpUni') < 1)
	lcQuery = [Select b.CfgGerGprs ] + ;
			    [From SigCdPro a, SigCdGrp b ] + ;
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro') < 1)
Select crTpmMvItn
	Select crTpmMvItn
Select crTpmMvItn
	Select crTpmMvItn
lcQuery = [Select * From SigCdUni Where CUnis = '] + crTpmMvItn.CUnis + [' Order By CUnis]
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'CrTmpUni') < 1)
			If Not Empty(crTpmMvItn.CPros) And (Seek(crTpmMvItn.Cpros,'csOpeAut','CPros') Or crSigCdOpe.Consers=1 ) And Empty(crTpmMvItn.Notas)
        ( crTpmMvItn.Opers = 'E' Or Seek( crTpmMvItn.Cpros, 'csOpeAut', 'CPros' ) ) ) Or ;
	lcQuery = [Select b.CfgGerGprs ] + ;
			    [From SigCdPro a, SigCdGrp b ] + ;
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro') < 1)
	Select crTpmMvItn
	Update crTpmMvItn Set AbrevIs = This.Value Where citem2=lnCItens
		Update crTpmMvItn Set opers = CsPedidos.opers Where citem2=lnCItens
	Select CsPedidos
	If Not Seek( This.Value, 'CsPedidos', 'Abrevs' )
	Select crTpmMvItn
	lcQuery = [Select Cgrus, Opers, Mercs, Contas, CodCors, ContaOrig From SigCdRpo Where Dopps = ']+TprMvCab.Dopes+[']
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalRopt') < 1)
	SELECT LocalRopt
		SELECT Cgrus, Mercs, CodCors FROM LocalRopt Where Contas = ' ' And ContaOrig = ' ' INTO CURSOR Selecao
		Select Selecao
			SELECT Cgrus, Mercs, CodCors FROM LocalRopt Where Contas = TprMvCab.ContaDs INTO CURSOR Selecao2
			Select Selecao2
			SELECT Cgrus, Mercs, CodCors FROM LocalRopt Where ContaOrig = TprMvCab.ContaOs INTO CURSOR Selecao3
			Select Selecao3
		lcQuery = [Select distinct dopps From SigCdRpo Where Exclus = 1 And (Cgrus = ']+CrTmpGru.Cgrus+[' Or ]+;
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalRoptG') < 1)
		Select LocalRoptG
	Select crTpmMvIts
		Delete
	Insert Into crTpmMvIts ( CItens, CPros, Emps, Dopes, Numes, qtds, QtdEmbs, Pesos, CodCors, CodTams, CodEmbs ) ;
lcQuery = [Select cgrus, cpros, mercs ] + ;
		    [From SigCdPro ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpPro') < 1)
lcQuery = [Select TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, MtPrimas ] + ;
		    [From SigCdGrp ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpGru') < 1)
Select crTpmMvItn
Select crTpmMvItn
Select crTpmMvItn
	Select crTpmMvIts
		Delete
	Insert Into crTpmMvIts ( CItens, CPros, Emps, Dopes, Numes, qtds, QtdEmbs, Pesos, CodCors, CodTams, CodEmbs ) ;
lcQuery = [Select cgrus, cpros, mercs ] + ;
		    [From SigCdPro ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpPro') < 1)
lcQuery = [Select TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, MtPrimas ] + ;
		    [From SigCdGrp ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpGru') < 1)
lcQuery = [Select a.Cpros, a.CGrus, a.Reffs, a.Situas, a.DtSituas, a.CUnis, a.Dpros, a.PesoMs, a.FVendas, a.FCustos, a.MoePvs, ] + ;
		    [From SigCdPro a Left Join SigCdCol b On a.Colecoes = b.Colecoes ] + ;
ThisForm.ParentForm.PodataMgr.SqlExecute(lcQuery, [crTmpPro])
lcQuery = [Select TipoEstos, Mercs, cores, tams, embs, cgrus, dgrus, Pesos, Entregas, Arreds From SigCdGrp Where Cgrus = ']+CrTmpPro.Cgrus+[']
=ThisForm.ParentForm.PodataMgr.SqlExecute(lcQuery,'CrTmpGru')
lcQuery = [Select Reffs From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[' And Ifors = ']+_Ct+[']
=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
lcQuery = [Select e.Sqtds ] + ;
			[From SigCdPro p ] + ;
			[Left Join SigMvEst e On e.CPros = p.CPros And ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca1]) < 1)
lcQuery = [Select RClis From SigCdCli Where Iclis = ']+CrTmpPro.Ifors+[' ]
=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFor')
Select crTpmMvItn
	Select LpItem
Select crTpmMvIts
		lcQuery = [Select Descricaos ] + ;
				    [From SigCdClf ] + ;
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalClf]) < 1)
		Select LocalClf
Select crTpmMvItn
			lnOldSel = Select()
			Select(lnOldSel)
		Select crTpmMvItn
	=Seek( crTpmMvItn.AbrevIs, 'CsPedidos', 'Abrevs' )
			lcSql = [Select Cgrus From SigCdPro Where cpros = ']+crTpmMvItn.Cpros+[']
			ThisForm.ParentForm.PodataMgr.SqlExecute(lcSql,'LocalGru')
		lcSql = [Select a.Cpros, a.Cgrus, a.Reffs, a.Situas, a.DtSituas, a.Cunis, a.Dpros, a.Pesoms, a.fvendas, a.fcustos, a.moepvs, ]+;
				[From SigCdPro a Inner Join SigCdGrp b on b.cGrus = a.cGrus Where a.Cpros = ']+lcCodProduto+[']
		ThisForm.ParentForm.Podatamgr.Sqlexecute(lcSql,'LocalPro')
			lcSql = [Select Codigos From SigCdLpc where lPrecos = ']+TprMvCab.lPrecos+[']
			lnErro = ThisForm.ParentForm.podatamgr.SqlExecute(lcSql,'CrtmplPre')
			lcwhere = [Select * From SigCdLpi Where Cpros = ']+LocalPro.Cpros+[' And LPrecos = ']+TprMvCab.lPrecos+[']
			lnErro = ThisForm.ParentForm.podatamgr.SqlExecute(lcWhere,'crSigCdLpi')
			Select crSigCdLpi
							lcQuery = [Select Moevs, Pvens From SigPrFnc Where Cpros = ']+LocalPro.Cpros+[' And Ifors = ']+_Ct+[']
							=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
						lcQuery = [Select MoeQs, QtdEqs ] + ;
								    [From SigCdMoe ] + ;
						If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpMoe') < 1)
					lcQuery = [select customedioreais as csmedio, (select moedaps from sigcdpam) as csmoedas ] + ;
							[from customedio3 where cpros = ']+LocalPro.Cpros+[' ]
					If ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpProMd') < 1
				Select crTpmMvItn
			Select crTpmMvItn
Select crTpmMvItn
		Select crTpmMvItn
		Select * From crTpmMvItn Where Empty(AbrevIs) And citem2 = 0 And Not Empty(Cpros) Into Cursor csRegZero ReadWrite 
			Select csRegZero
				If Seek(csRegZero.cItens,[crTpmMvItn],[Item])
					Select crTpmMvItn
				Select csRegZero
	Select crTpmMvItn
		Insert Into crTpmMvItn( Emps, Dopes, Numes, CItens) ;
		Select crTpmMvIts
		Select crSigSubMv
			Select crSigMvIte
		Select crTpmMvItn
	Select crTpmMvItn
		Select crTpmMvIts
			Select crTpmMvItn
Select crTpmMvItn
	Select TmpOperacao
	Select crTpmMvItn
	Select crTpmMvItn
				llNotasObrig = Seek(crTpmMvItn.CPros,'csOpeAut','CPros')
					lcQuery = [Select Cgrus, Opers, Mercs, Contas, CodCors, ContaOrig From SigCdRpo Where Dopps = ']+TprMvCab.Dopes+[']
					If (Thisform.ParentForm.PoDataMgr.SqlExecute(lcQuery, 'LocalRopt') < 1)
					Select LocalRopt
						Select Cgrus, Mercs, Codcors From LocalRopt Where Contas = ' ' And ContaOrig = ' ' Into Cursor Selecao
						Select Selecao
							Select Cgrus, Mercs, Codcors From LocalRopt Where Contas = TprMvCab.ContaDs Into Cursor Selecao2
							Select Selecao2
							Select Cgrus, Mercs, Codcors From LocalRopt Where ContaOrig = TprMvCab.ContaOs Into Cursor Selecao3
							Select Selecao3
						lcQuery = [Select distinct dopps From SigCdRpo Where Exclus = 1 And (Cgrus = ']+crTmpGru.Cgrus+[' Or ]+;
						If (Thisform.ParentForm.PoDataMgr.SqlExecute(lcQuery, 'LocalRoptG') < 1)
						Select LocalRoptG
						Select Count(1) As nTotal, Notas From crTpmMvItn ;
							Select Count(1) As nTotal, CPros, Notas From crTpmMvItn ;
				Select crItn
				lcQuery = [Select * from sigmvesl Where emps = ']+TprMvCab.Emps+[' and grupos = ']+TprMvCab.grupoos+;
				If (Thisform.ParentForm.PoDataMgr.SqlExecute(lcQuery, 'LocalestL') < 1)
			Select crTpmMvItn
					Select crTpmMvItn
			Select crTpmMvItn
		lnOldSel = Select()
			Select *, Space(40) as Dpros from xBaixa2 ;
		Select cpros, Space(3) as CodCors, Space(3) as CodCors, qtds, qtbaixas, qtprods, Space(40) as Dpros ;
			From xBaixa Where cpros not in(Select cpros from xBaixa2 ) ;
			Select *, Space(40) as Dpros, Space(3) as CodTams, Space(3) as CodCors from xBaixa Into Cursor TmpItepen ReadWrite
		Select TmpItepen
		Select Distinct a.CPros, a.AbrevIs, Nvl(b.CodTams,[]) as CodTams, Sum(a.qtds) as Qtds ;
			From crTpmMvItn a ;
			Left Join crTpmMvIts b On b.citens=a.citens And b.cpros=a.cpros ;
		Select ChecAbrev 
			lcQuery = [select a.VldQtdAbrv from sigopcdi a join sigcdope b on a.dopes = b.dopes where b.abrevs = ']+ChecAbrev.AbrevIs+[' ]
			=Thisform.ParentForm.PoDataMgr.SqlExecute(lcQuery,[csVldAbr])
				Select a.* From TmpItepen a, ChecAbrev b ;
				Select csValQtAbr				
				If Not Seek(Alltrim(ChecAbrev.Cpros) + Alltrim(ChecAbrev.CodTams),[TmpItepen],[ProTam])
			Select ChecAbrev 
		Select(lnOldSel)		
	Select crTpmMvItn
			Select crSigOpFnl
			Select * from crSigOpFnl where Operacao = 'ITN' into cursor csTemFnl Readwrite
		Select Distinct a.CPros, a.citens, a.Pesos, b.Pesos as PesoIts, b.codtams ;
		From crTpmMvItn a ;
		Left Join crTpmMvIts b On b.citens=a.citens And b.cpros=a.cpros ;
		Select csChecIt2s
			lnOldSel = Select()
				lcQuery = [Select PesoMs From SigPrTam Where Cpros = ']+csChecIt2s.CPros+[' and CodTams = ']+lcTams+[' ]
				Thisform.ParentForm.PoDataMgr.SqlExecute(lcQuery,[csPrTam])
				Select csPrTam
			Select(lnOldSel)
			Select csChecIt2s
		Select crTpmMvItn
		Select crTpmMvItn
				=Seek( crTpmMvItn.AbrevIs, 'CsPedidos', 'Abrevs' )
		Select citens,CPros From crTpmMvItn	Where qtds <> 0 And Empty(AbrevIs) And Not Empty(CPros) ;
		Select ChecAbrev
		Select crTpmMvItn
				Select LocalBus
					lcSql = [Select a.Mercs, b.Abrevs ] + ;
						[From SigCdMop a, SigCdOpe b, SigOpCdc c ] + ;
					If (Thisform.ParentForm.PoDataMgr.SqlExecute(lcSql, [LocalMop]) < 1)
		Select crTpmMvItn3
		Select CPros From crTpmMvItn3 Where Not Empty(CPros) Into Cursor csQtdSer Readwrite
		Select csQtdSer
	Select crTpmMvItn3
	Delete From crTpmMvItn3 Where Empty(CPros)
	Select crTpmMvItn
		Select crTpmMvItn
			lcQuery = [Select a.cores, a.tams, a.obriggrd from SigCdGrp a, sigcdpro b  Where b.CPros = '] + lcProduto + [' and a.cgrus=b.cgrus]
			If (Thisform.ParentForm.PoDataMgr.SqlExecute(lcQuery, [crGrpA]) < 1)
			Select * From crTpmMvItn Where Empty(Codcors) And Not Empty(Cpros) and Cpros = lcProduto Into Cursor crAux
			Select * From crTpmMvItn Where Empty(codtams) And Not Empty(Cpros) and Cpros = lcProduto Into Cursor crAux
	Select crTpmMvIts
		Select csValCdP
		Select Cpros, Opers, Sum(qtds) as Qtds from crTpmMvItn ;
		Select csCkItens
			lcQuery = [Select Cpros, Conjunts from sigcdpro Where CPros = '] + csCkItens.CPros + [' ]
			If (Thisform.ParentForm.PoDataMgr.SqlExecute(lcQuery, [crTmpProS]) < 1)
			Select csValCdP
			Select csCkItens
		Select csValCdP
		Select Conjunts, Opers, Sum(Qtds) as QtE From csValCdP Where Opers = 'E' group by Conjunts, Opers Into Cursor csCkE Readwrite 
		Select csValCdP
		Select Conjunts, Opers, Sum(Qtds) as QtS From csValCdP Where Opers = 'S' group by Conjunts, Opers Into Cursor csCkS Readwrite 
		Select csCkE
		Select csCkS 
		Select csCkE
			If Not Seek(csCkE.Conjunts,[csCkS],[Conjunts])
			If Seek(csCkE.Conjunts,[csCkS],[Conjunts])
			Select csCkE
		Select csCkS
			If Not Seek(csCkS.Conjunts,[csCkE],[Conjunts])
			If Seek(csCkS.Conjunts,[csCkE],[Conjunts])
			Select csCkS
	Select a.* From crTpmMvIts a, crTpmMvItn b Where a.citens = b.citens And a.CPros <> b.CPros;
	Select ChecItem
	Select a.CPros,a.citens,a.qtds,Sum(b.qtds*b.qtdembs) As qtdb From crTpmMvIts b, crTpmMvItn a Where;
	Select ChecItem2
		Select a.CPros,a.citens,a.qtds,a.qtreservas ;
			From crTpmMvItn a ;
		Select ChecItem3
		Select crTpmMvItn
		Select citens From crTpmMvItn Where !Empty(CPros) And Empty(locals) Into Cursor ChecLocal
		Select ChecLocal
			Select crTpmMvItn
		Select TmpTotal
				Delete
		Select crTpmMvItn
			Select TmpTotal
				If Not IsEmpty(crTpmMvItn.MoeFats) And !Seek( crTpmMvItn.MoeFats )
					Insert Into TmpTotal ( moeds ) Values ( crTpmMvItn.MoeFats )
				If Not IsEmpty(crTpmMvItn.Moedas) And !Seek( crTpmMvItn.Moedas )
					Insert Into TmpTotal ( moeds ) Values ( crTpmMvItn.Moedas )
		Select TmpTotal
		Select TmpTotal
		Select TmpTotal
			Select TprMvCab
			Select xPar
			Select crSigMvItp
			Select crTpmMvItn
				Select crTpmMvItn3
				Seek ( crTpmMvItn.citens )
					Insert Into crSigMvItp (CPros, DPros, Cunis, Dopes, Emps, Numes, ;
				lcUpdate = [Update SigMvCab Set valos = ]+Str(TprMvCab.valos,12,2)+[,]+;
				If Thisform.ParentForm.PoDataMgr.SqlExecute(lcUpdate,'') < 1
			lcDelete = [Delete From SigMvItp Where EmpDopNums = ']+TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes,6)+[']
			If Thisform.ParentForm.PoDataMgr.SqlExecute(lcDelete,'') < 1
			If Not llOk Or !Thisform.ParentForm.PoDataMgr.Update('crSigMvItp') Or Thisform.ParentForm.PoDataMgr.Commit() < 1

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoppro.prg) - TRECHOS RELEVANTES PARA PASS SQL (6402 linhas total):

*-- Linhas 144 a 162:
144:                 THIS.ConfigurarPageFrame()
145: 
146:                 *-- Cursores ANTES das paginas: os campos de Page1/Page3 e a
147:                 *-- grade de Page4 usam ControlSource, e ControlSource de alias
148:                 *-- que ainda nao existe derruba o Init (regra #41).
149:                 THIS.CriarCursorItens()
150:                 THIS.CriarCursorPrecos()
151: 
152:                 THIS.ConfigurarPaginaProduto()
153:                 THIS.ConfigurarPaginaDados()
154:                 THIS.ConfigurarPaginaFiscal()
155:                 THIS.ConfigurarPaginaPrecos()
156:                 THIS.ConfigurarBotoes()
157:                 THIS.ConfigurarBotoesTopo()
158:                 THIS.ConfigurarBotoesAcao()
159:                 THIS.ConfigurarGridDados()
160: 
161:                 *-- AfterRowColChange: handler DECLARA par_nColIndex porque o
162:                 *-- evento passa o argumento (regra #3). Uso de LINHA corrente

*-- Linhas 369 a 387:
369:     * data session do form PAI (Movimentacao) - este form eh DataSession=2
370:     * (privado) e ainda nao tem a ponte com o pai conectada (ver comentario
371:     * de this_cOpEscolha no cabecalho da classe). Por isso os campos usam
372:     * .Value direto (sem ControlSource) a partir de properties locais
373:     * this_cMascnum/this_cTabds/this_cTpfats/this_cMoeits, que uma fase
374:     * posterior de integracao com o form pai ira popular.
375:     *
376:     * FASE 6/8 (Parte 2 de 2): completa os containers desta pagina com
377:     * cnt_4c_Origem, cnt_4c_Destino, cnt_4c_EmpDes, cnt_4c_LPrecos.
378:     *
379:     * SEM LOOKUP nestes quatro: no legado, Get_grupo/Get_conta/Get_dconta de
380:     * cntOrigem/cntDestino tem ReadOnly=.T. no dump E o proprio When() do SCX
381:     * retorna .F. sempre (Return .F.) - sao espelhos read-only do cabecalho
382:     * TprMvCab (que vive no data session do form PAI), nunca campos
383:     * digitaveis. getEmpDs (cntEmpDes) tambem tem When() = Return(.F.). So
384:     * getLPrecos (cntLPrecos) eh editavel no legado, mas nao tem
385:     * CreateObject('fwbuscaext'/'fwBuscaSel') nem sigacess() no Valid - eh
386:     * texto livre (Format="K", MaxLength=30), sem tabela de referencia.
387:     *==========================================================================

*-- Linhas 807 a 835:
807:     *==========================================================================
808:     * CriarCursorItens - Cursor de trabalho (espelha crTpmMvItn do legado),
809:     * compartilhado pela grade grd_4c_Dados e pelo sigopproBO.CarregarDoCursor.
810:     * Mantido num unico CREATE CURSOR para que as paginas de Dados/Fiscal/
811:     * Precificacao (fases seguintes) liguem campos nele sem recriar a
812:     * estrutura (regra #41 - Column.ControlSource exige o cursor ja existir).
813:     *==========================================================================
814:     PROTECTED PROCEDURE CriarCursorItens()
815:         IF USED("cursor_4c_Itens")
816:             USE IN cursor_4c_Itens
817:         ENDIF
818: 
819:         SET NULL ON
820:         CREATE CURSOR cursor_4c_Itens ( ;
821:             cidchaves C(20), citens N(10,0), cpros C(14), dpros C(65), ;
822:             codbarras N(14,0), cunis C(3), cunips C(3), fators N(8,3), ;
823:             opers C(1), qtds N(9,3), pesos N(9,3), units N(15,6), ;
824:             moedas C(3), totas N(11,2), tpesos N(11,2), abrevis C(3), ;
825:             locals C(10), localos C(10), compris N(6,2), qtreservas N(9,3), ;
826:             ckpresente N(1,0), codcors C(4), codtams C(4), servicos N(1,0), ;
827:             aqtds N(9,3), datatrans T NULL, descvals N(7,2), dopes C(20), ;
828:             emps C(3), etiesps L, fatvals N(15,6), fvals L, iconfs L, ;
829:             moefats C(3), moevals N(15,6), notas C(6), nrcons C(10), ;
830:             ntrans N(6,0), numes N(6,0), numolds N(6,0), obs M NULL, ;
831:             qtbaixas N(9,3), qtbxprods N(9,3), qtprods N(9,3), ;
832:             unitembs N(11,4), univals N(15,6), vcoms N(8,2), aliqs N(4,2), ;
833:             sitribs C(2), tpipis C(1), valipis N(11,2), aliqicms N(5,2), ;
834:             valdescs N(9,2), empos C(3), moevs C(3), utilizas N(4,0), ;
835:             ncodigos N(10,0), nlotes N(10,0), dtalts T NULL, empdopnums C(29), ;

*-- Linhas 855 a 1120:
855: 
856:         INDEX ON citens TAG citens
857: 
858:         *-- SET DELETED eh escopado por DATA SESSION e este form eh
859:         *-- DataSession = 2: na sessao privada ele volta ao default OFF, e com
860:         *-- OFF a linha excluida do cursor CONTINUA aparecendo na grade (que
861:         *-- tem DeleteMark = .F., entao nem a marca de exclusao denuncia) e
862:         *-- ainda eh contada por COUNT/SCAN. A exclusao de linha e a
863:         *-- renumeracao dos itens dependem disso.
864:         SET DELETED ON
865:     ENDPROC
866: 
867:     *==========================================================================
868:     * ConfigurarGridDados - grd_4c_Dados (fwGrade do legado): grade principal
869:     * de itens da movimentacao, 22 colunas na mesma ordem/largura do dump.
870:     *==========================================================================
871:     PROTECTED PROCEDURE ConfigurarGridDados()
872:         THIS.AddObject("grd_4c_Dados", "Grid")
873:         WITH THIS.grd_4c_Dados
874:             .Top               = 122
875:             .Left              = 7
876:             .Width             = 1035
877:             .Height            = 233
878:             .ColumnCount       = 22
879:             .RecordSource      = "cursor_4c_Itens"
880:             .FontName          = "Courier New"
881:             .FontSize          = 9
882:             .HeaderHeight      = 16
883:             .RowHeight         = 16
884:             .AllowHeaderSizing = .F.
885:             .DeleteMark        = .F.
886:             .RecordMark        = .F.
887:             .ScrollBars        = 3
888:             .GridLineColor     = RGB(238, 238, 238)
889:             .ToolTipText       = "Grade de Produtos"
890:         ENDWITH
891: 
892:         *-- Column1: PRODUTO (estilo link - sublinhado/azul, igual ao legado)
893:         WITH THIS.grd_4c_Dados.Column1
894:             .ControlSource     = "cursor_4c_Itens.cpros"
895:             .Width             = 108
896:             .FontBold          = .T.
897:             .FontName          = "Courier New"
898:             .FontSize          = 9
899:             .FontUnderline     = .T.
900:             .ForeColor         = RGB(0, 0, 255)
901:             .Format            = "K!"
902:             .InputMask         = REPLICATE("!", 14)
903:             .Header1.FontBold  = .T.
904:             .Header1.FontName  = "Arial"
905:             .Header1.FontSize  = 8
906:             .Header1.Alignment = 2
907:             .Header1.Caption   = "Produto"
908:         ENDWITH
909: 
910:         *-- Column2: FATOR
911:         WITH THIS.grd_4c_Dados.Column2
912:             .ControlSource     = "cursor_4c_Itens.fators"
913:             .Width             = 50
914:             .InputMask         = "99999.999"
915:             .Header1.Alignment = 2
916:             .Header1.Caption   = "Fator"
917:         ENDWITH
918: 
919:         *-- Column3: OPERACAO (Format=M -> InputMask eh a LISTA, regra #24)
920:         WITH THIS.grd_4c_Dados.Column3
921:             .ControlSource     = "cursor_4c_Itens.opers"
922:             .Width             = 14
923:             .Format            = "M"
924:             .InputMask         = "E,S"
925:             .Header1.Caption   = "Op"
926:         ENDWITH
927: 
928:         *-- Column4: QTD
929:         WITH THIS.grd_4c_Dados.Column4
930:             .ControlSource     = "cursor_4c_Itens.qtds"
931:             .Width             = 64
932:             .InputMask         = "99999.999"
933:             .Header1.Alignment = 2
934:             .Header1.Caption   = "Qtd."
935:         ENDWITH
936: 
937:         *-- Column5: PESO
938:         WITH THIS.grd_4c_Dados.Column5
939:             .ControlSource     = "cursor_4c_Itens.pesos"
940:             .Width             = 60
941:             .InputMask         = "99999.999"
942:             .Header1.Alignment = 2
943:             .Header1.Caption   = "Peso"
944:         ENDWITH
945: 
946:         *-- Column6: VALOR
947:         WITH THIS.grd_4c_Dados.Column6
948:             .ControlSource     = "cursor_4c_Itens.units"
949:             .Width             = 90
950:             .InputMask         = "99999999.99"
951:             .Header1.Alignment = 2
952:             .Header1.Caption   = "Valor"
953:         ENDWITH
954: 
955:         *-- Column7: MOEDA
956:         WITH THIS.grd_4c_Dados.Column7
957:             .ControlSource     = "cursor_4c_Itens.moedas"
958:             .Width             = 24
959:             .Header1.Alignment = 2
960:             .Header1.Caption   = "Moe"
961:         ENDWITH
962: 
963:         *-- Column8: TOTAL
964:         WITH THIS.grd_4c_Dados.Column8
965:             .ControlSource     = "cursor_4c_Itens.totas"
966:             .Width             = 107
967:             .InputMask         = "9999999999.99"
968:             .Header1.Alignment = 2
969:             .Header1.Caption   = "Total"
970:         ENDWITH
971: 
972:         *-- Column9: pesotot
973:         WITH THIS.grd_4c_Dados.Column9
974:             .ControlSource     = "cursor_4c_Itens.tpesos"
975:             .Width             = 64
976:             .InputMask         = "9999999.99"
977:             .Header1.Alignment = 2
978:             .Header1.Caption   = "Total Peso"
979:         ENDWITH
980: 
981:         *-- Column10: item (numero sequencial, sem legenda no legado)
982:         WITH THIS.grd_4c_Dados.Column10
983:             .ControlSource     = "cursor_4c_Itens.citens"
984:             .Width             = 31
985:             .InputMask         = "9999"
986:             .Header1.Caption   = ""
987:         ENDWITH
988: 
989:         *-- Column11: UNIDADE
990:         WITH THIS.grd_4c_Dados.Column11
991:             .ControlSource     = "cursor_4c_Itens.cunis"
992:             .Width             = 30
993:             .Header1.Alignment = 2
994:             .Header1.Caption   = "Uni"
995:         ENDWITH
996: 
997:         *-- Column12: UNIPESO (desabilitada, igual ao legado)
998:         WITH THIS.grd_4c_Dados.Column12
999:             .ControlSource     = "cursor_4c_Itens.cunips"
1000:             .Width             = 31
1001:             .Enabled           = .F.
1002:             .Header1.Alignment = 2
1003:             .Header1.Caption   = "Uni"
1004:         ENDWITH
1005: 
1006:         *-- Column13: PEDIDO
1007:         WITH THIS.grd_4c_Dados.Column13
1008:             .ControlSource     = "cursor_4c_Itens.abrevis"
1009:             .Width             = 40
1010:             .Header1.Alignment = 2
1011:             .Header1.Caption   = "Ped"
1012:         ENDWITH
1013: 
1014:         *-- Column14: DESCRS
1015:         WITH THIS.grd_4c_Dados.Column14
1016:             .ControlSource     = "cursor_4c_Itens.dpros"
1017:             .Width             = 290
1018:             .Header1.Alignment = 2
1019:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1020:         ENDWITH
1021: 
1022:         *-- Column15: cor
1023:         WITH THIS.grd_4c_Dados.Column15
1024:             .ControlSource     = "cursor_4c_Itens.codcors"
1025:             .Width             = 24
1026:             .Header1.Alignment = 2
1027:             .Header1.Caption   = "Cor"
1028:         ENDWITH
1029: 
1030:         *-- Column16: Local
1031:         WITH THIS.grd_4c_Dados.Column16
1032:             .ControlSource     = "cursor_4c_Itens.locals"
1033:             .Width             = 80
1034:             .Header1.Alignment = 2
1035:             .Header1.Caption   = "Local"
1036:         ENDWITH
1037: 
1038:         *-- Column17: Comprimento
1039:         WITH THIS.grd_4c_Dados.Column17
1040:             .ControlSource     = "cursor_4c_Itens.compris"
1041:             .Width             = 50
1042:             .InputMask         = "9999.99"
1043:             .Header1.Alignment = 2
1044:             .Header1.Caption   = "Compr."
1045:         ENDWITH
1046: 
1047:         *-- Column18: LocalO
1048:         WITH THIS.grd_4c_Dados.Column18
1049:             .ControlSource     = "cursor_4c_Itens.localos"
1050:             .Width             = 80
1051:             .Header1.Alignment = 2
1052:             .Header1.Caption   = "Local Ori"
1053:         ENDWITH
1054: 
1055:         *-- Column19: Tamanho
1056:         WITH THIS.grd_4c_Dados.Column19
1057:             .ControlSource     = "cursor_4c_Itens.codtams"
1058:             .Width             = 35
1059:             .Header1.Alignment = 2
1060:             .Header1.Caption   = "Tam."
1061:         ENDWITH
1062: 
1063:         *-- Column20: Reserva (ReadOnly, igual ao legado)
1064:         WITH THIS.grd_4c_Dados.Column20
1065:             .ControlSource     = "cursor_4c_Itens.qtreservas"
1066:             .Width             = 64
1067:             .ReadOnly          = .T.
1068:             .InputMask         = "999999.999"
1069:             .Header1.Alignment = 2
1070:             .Header1.Caption   = "Reserva"
1071:         ENDWITH
1072: 
1073:         *-- Column21 (Presente) e Column22 (O.S.): CheckBox de coluna.
1074:         *-- Aqui so o BIND e a largura/header. O AddObject do CheckBox roda
1075:         *-- DEPOIS, em InstalarCheckBoxesGrade(), porque Column.AddObject de
1076:         *-- CheckBox ESTOURA enquanto a coluna estiver ligada (pelo auto-bind
1077:         *-- do RecordSource) a um campo de outro tipo: com ColumnCount = 22 o
1078:         *-- VFP liga Column22 ao 22o campo do cursor, que eh codcors C(4), e
1079:         *-- adicionar um controle numerico ali da
1080:         *-- "Error with CHK_4C_SERVICO - Value : Data type mismatch."
1081:         *-- A falha eh TOTAL e MUDA: cai no TRY do InicializarForm, que
1082:         *-- devolve .F., CREATEOBJECT devolve o logico .F. e a tela
1083:         *-- simplesmente nao abre - sem erro na tela e sem log.
1084:         WITH THIS.grd_4c_Dados.Column21
1085:             .ControlSource     = "cursor_4c_Itens.ckpresente"
1086:             .Width             = 50
1087:             .Header1.Alignment = 2
1088:             .Header1.Caption   = "Presente"
1089:         ENDWITH
1090: 
1091:         WITH THIS.grd_4c_Dados.Column22
1092:             .ControlSource     = "cursor_4c_Itens.servicos"
1093:             .Width             = 50
1094:             .Header1.Alignment = 2
1095:             .Header1.Caption   = "O.S."
1096:         ENDWITH
1097: 
1098:         *-- Todas as colunas ja estao bindadas: agora os CheckBox.
1099:         THIS.InstalarCheckBoxesGrade()
1100:     ENDPROC
1101: 
1102:     *==========================================================================
1103:     * InstalarCheckBoxesGrade - Instala os CheckBox das colunas Presente e
1104:     * O.S. na ordem que o VFP9 exige (medido): ColumnCount -> RecordSource ->
1105:     * ControlSource de TODAS as colunas -> Column.AddObject + Value ->
1106:     * Sparse + CurrentControl. Invertido, o AddObject estoura por causa do
1107:     * auto-bind do RecordSource (ver comentario em ConfigurarGridDados).
1108:     *
1109:     * IDEMPOTENTE e vive no funil: reatribuir RecordSource/ColumnCount ou
1110:     * fechar o alias destroi os objetos postos na Column, entao a instalacao
1111:     * tem de poder rodar de novo sem duplicar o AddObject.
1112:     *==========================================================================
1113:     PROTECTED PROCEDURE InstalarCheckBoxesGrade()
1114:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1115:             RETURN
1116:         ENDIF
1117: 
1118:         IF THIS.grd_4c_Dados.ColumnCount < 22
1119:             RETURN
1120:         ENDIF

*-- Linhas 1801 a 1823:
1801:     * chamado de fora (TesteAutomatico / form pai) e pelo funil de recarga.
1802:     *
1803:     * Equivale ao AddCursor('SigMvItn', ...) que o legado herda do form pai
1804:     * de Movimentacao (crTpmMvItn) seguido de "Select crTpmMvItn / Goto Top"
1805:     * no fim do Init.
1806:     *
1807:     * O BO le para um cursor TEMPORARIO e aqui o alias da grade eh recarregado
1808:     * com SELECT/ZAP/APPEND FROM DBF(): SQLEXEC direto sobre o alias ligado ao
1809:     * Grid o FECHA e RECRIA, zerando o ColumnCount - a grade viraria um
1810:     * retangulo branco sem cabecalho, sem erro e sem log.
1811:     *==========================================================================
1812:     PROCEDURE CarregarDados()
1813:         LOCAL loc_lSucesso, loc_cChave, loc_oErro
1814: 
1815:         loc_lSucesso = .F.
1816: 
1817:         IF !USED("cursor_4c_Itens")
1818:             THIS.CriarCursorItens()
1819:         ENDIF
1820: 
1821:         loc_cChave = THIS.ObterChaveMovimentacao()
1822: 
1823:         IF EMPTY(loc_cChave)

*-- Linhas 1833 a 1852:
1833:             IF THIS.this_oBusinessObject.CarregarItens(loc_cChave, "cursor_4c_ItensTmp")
1834:                 THIS.ZaparCursorItens()
1835:                 IF USED("cursor_4c_ItensTmp")
1836:                     SELECT cursor_4c_Itens
1837:                     APPEND FROM DBF("cursor_4c_ItensTmp")
1838:                 ENDIF
1839:                 loc_lSucesso = .T.
1840:             ENDIF
1841: 
1842:             IF USED("cursor_4c_ItensTmp")
1843:                 USE IN cursor_4c_ItensTmp
1844:             ENDIF
1845: 
1846:         CATCH TO loc_oErro
1847:             THIS.this_cMensagemErro = loc_oErro.Message
1848:             MsgErro("Erro ao carregar os itens da movimenta" + CHR(231) + CHR(227) + ;
1849:                     "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1850:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1851:                     "Proc: " + loc_oErro.Procedure, "Erro CarregarDados")
1852:         ENDTRY

*-- Linhas 1867 a 1962:
1867:     * PrepararLinhaInicial - Fecho do Init legado, que em INSERIR/ALTERAR
1868:     * entrega uma linha em branco pronta para digitacao:
1869:     *
1870:     *   Select crTpmMvItn / Set Order To
1871:     *   If Thisform.Op_Escolha = 'ALTERAR' Or crSigCdOpe.SubnObrigs = 3
1872:     *       Count To lnCount / Thisform.CItem = lnCount / Thisform.minserelinha()
1873:     *   Else
1874:     *       If Thisform.Op_Escolha = 'INSERIR'
1875:     *           Count To lnCount / Thisform.CItem = lnCount / minserelinha()
1876:     *       Endif
1877:     *   Endif
1878:     *
1879:     * Em CONSULTAR/EXCLUIR o legado NAO entrega linha nova (a grade abre so
1880:     * com o que foi gravado), e o mesmo vale aqui.
1881:     *==========================================================================
1882:     PROTECTED PROCEDURE PrepararLinhaInicial()
1883:         LOCAL loc_nRegistros
1884: 
1885:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
1886:             RETURN .F.
1887:         ENDIF
1888: 
1889:         IF !USED("cursor_4c_Itens")
1890:             RETURN .F.
1891:         ENDIF
1892: 
1893:         SELECT cursor_4c_Itens
1894:         COUNT TO loc_nRegistros
1895:         THIS.this_nCItem = loc_nRegistros
1896: 
1897:         RETURN THIS.InserirLinhaGrade()
1898:     ENDPROC
1899: 
1900:     *==========================================================================
1901:     * RepintarGradeItens - FUNIL UNICO de repintura da grade. Popular o cursor
1902:     * NAO faz a grade exibir as linhas (regra #21): o legado sempre fecha com
1903:     * "Go Top In crTpmMvItn" + "fwGrade.Refresh". Tem de rodar em TODO caminho
1904:     * que mexe no cursor (carga, exclusao de linha, troca de modo) e DEPOIS de
1905:     * trocar o ActivePage - Refresh em pagina oculta nao pinta.
1906:     *==========================================================================
1907:     PROCEDURE RepintarGradeItens()
1908:         IF !USED("cursor_4c_Itens")
1909:             RETURN
1910:         ENDIF
1911: 
1912:         SELECT cursor_4c_Itens
1913:         GO TOP
1914: 
1915:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1916:             *-- Reinstala os CheckBox de coluna antes de repintar: se algo
1917:             *-- tiver reatribuido RecordSource/ColumnCount ou fechado o
1918:             *-- alias, os objetos postos nas Columns foram destruidos. A
1919:             *-- instalacao eh idempotente.
1920:             THIS.InstalarCheckBoxesGrade()
1921:             THIS.grd_4c_Dados.Refresh()
1922:         ENDIF
1923:     ENDPROC
1924: 
1925:     *==========================================================================
1926:     * ZaparCursorItens - ZAP guardado por SAFETY. SET SAFETY eh escopado por
1927:     * DATA SESSION: este form eh DataSession = 2, e na sessao privada SAFETY
1928:     * vale ON mesmo com o SET SAFETY OFF do main.prg. Com SAFETY ON o ZAP
1929:     * abre o dialogo modal "Zap ... Are you sure?" e CONGELA a tela,
1930:     * esperando um clique que ninguem ve (nao eh erro: em teste headless
1931:     * aparece como timeout sem resultado).
1932:     *
1933:     * ZAP eh a escolha CERTA aqui (o legado faz "Zap In <cursor>"): preserva
1934:     * a estrutura e o binding do Grid. Fechar e recriar o alias derrubaria
1935:     * RecordSource/ControlSource e a grade ficaria vazia com o cursor cheio.
1936:     *==========================================================================
1937:     PROTECTED PROCEDURE ZaparCursorItens()
1938:         LOCAL loc_cSafety
1939: 
1940:         IF !USED("cursor_4c_Itens")
1941:             RETURN
1942:         ENDIF
1943: 
1944:         loc_cSafety = SET("SAFETY")
1945:         SET SAFETY OFF
1946: 
1947:         SELECT cursor_4c_Itens
1948:         ZAP
1949: 
1950:         IF loc_cSafety = "ON"
1951:             SET SAFETY ON
1952:         ENDIF
1953:     ENDPROC
1954: 
1955:     *==========================================================================
1956:     * AplicarModoNaGrade - Espelha o par fwGrade/fwGradeR do legado. No legado sao
1957:     * duas grades mutuamente exclusivas sobre o MESMO cursor, e o proprio
1958:     * legado alinha a segunda na posicao da primeira (".Left = fwGrade.Left /
1959:     * .Top = fwGrade.Top / .Height = fwGrade.Height"), isto eh: visualmente
1960:     * eh UMA grade que alterna entre editavel e somente-leitura.
1961:     *
1962:     * Legado: fwGrade  (editavel)      -> INSERIR, ou ALTERAR com AltEtiqs # 1

*-- Linhas 2015 a 2076:
2015:     * INSERIR ou ALTERAR) e a cada vez que o usuario termina uma linha.
2016:     *
2017:     * Legado:
2018:     *   Select crTpmMvItn / Set Order to CPros / Count to wRegistros
2019:     *   Seek Space(14)                       && procura linha com produto vazio
2020:     *   If Not Eof()                         && achou: nao insere, so desce
2021:     *       If Not ThisForm.lAutPreco / keyboard "{DNARROW}" / EndIf
2022:     *   Else
2023:     *       If wRegistros < crSigCdOpe.qtdites
2024:     *           ThisForm.CItem = ThisForm.CItem + 1
2025:     *           Insert Into crTpmMvItn( Emps, Dopes, Numes, Citens ) Values (...)
2026:     *       EndIf
2027:     *   EndIf
2028:     *   ThisForm.OldCodBarras = 0 / AntCPro = Space(14) / AntValu = Space(3)
2029:     *
2030:     * O cursor migrado nao tem a tag CPros do legado, entao a procura da linha
2031:     * em branco eh LOCATE FOR EMPTY(cpros) - mesmo efeito do Seek Space(14).
2032:     * O "keyboard {DNARROW}" do legado era a forma de levar o foco da grade
2033:     * para a linha nova; aqui o equivalente eh posicionar o cursor nela e
2034:     * repintar, porque a navegacao nao depende da fila de teclado.
2035:     *
2036:     * PUBLIC: o form pai e o harness de teste chamam de fora.
2037:     *==========================================================================
2038:     PROCEDURE InserirLinhaGrade()
2039:         LOCAL loc_nRegistros, loc_lTemLimite, loc_lInseriu
2040: 
2041:         IF !USED("cursor_4c_Itens")
2042:             RETURN .F.
2043:         ENDIF
2044: 
2045:         loc_lInseriu = .F.
2046: 
2047:         SELECT cursor_4c_Itens
2048:         COUNT TO loc_nRegistros
2049: 
2050:         LOCATE FOR EMPTY(cpros)
2051: 
2052:         IF !FOUND()
2053:             *-- Nenhuma linha em branco na grade: entrega uma nova, respeitando
2054:             *-- o teto de itens da operacao quando ele existe (legado:
2055:             *-- "If wRegistros < crSigCdOpe.qtdites").
2056:             loc_lTemLimite = (THIS.this_nQtdItes > 0)
2057: 
2058:             IF !loc_lTemLimite OR loc_nRegistros < THIS.this_nQtdItes
2059:                 THIS.this_nCItem = THIS.this_nCItem + 1
2060: 
2061:                 INSERT INTO cursor_4c_Itens (emps, dopes, numes, citens, empdopnums) ;
2062:                     VALUES (PADR(THIS.this_cEmps, 3), PADR(THIS.this_cDopes, 20), ;
2063:                             THIS.this_nNumes, THIS.this_nCItem, ;
2064:                             THIS.ObterChaveMovimentacao())
2065: 
2066:                 loc_lInseriu = .T.
2067:             ENDIF
2068:         ENDIF
2069: 
2070:         *-- Em qualquer um dos dois caminhos a linha corrente passa a ser a de
2071:         *-- digitacao (a que estava em branco, ou a recem-inserida).
2072:         THIS.RepintarGradeItens()
2073:         THIS.AjustarBotoesPorModo()
2074: 
2075:         RETURN loc_lInseriu
2076:     ENDPROC

*-- Linhas 2096 a 2209:
2096:             RETURN .F.
2097:         ENDIF
2098: 
2099:         SELECT cursor_4c_Itens
2100:         loc_nCitens = cursor_4c_Itens.citens
2101: 
2102:         REPLACE cpros      WITH "", ;
2103:                 dpros      WITH "", ;
2104:                 obs        WITH "", ;
2105:                 codbarras  WITH 0, ;
2106:                 utilizas   WITH 0, ;
2107:                 numeronota WITH "", ;
2108:                 notas      WITH ""
2109: 
2110:         REPLACE qtds    WITH 0, ;
2111:                 pesos   WITH 0, ;
2112:                 compris WITH 0, ;
2113:                 fators  WITH 0, ;
2114:                 tpesos  WITH 0, ;
2115:                 units   WITH 0, ;
2116:                 moedas  WITH "", ;
2117:                 totas   WITH 0
2118: 
2119:         *-- Sub-itens da linha (composicao): no legado moram em crTpmMvIts e
2120:         *-- aqui convivem no mesmo cursor, apontando o pai por citem2.
2121:         DELETE FOR citem2 = loc_nCitens AND citens <> loc_nCitens
2122: 
2123:         *-- Volta a posicionar na linha esvaziada (o DELETE FOR varre o cursor).
2124:         *-- LOCATE em vez de SEEK: nao depende de qual tag esta ativa, e a
2125:         *-- renumeracao de itens troca a ordem corrente durante o SCAN.
2126:         LOCATE FOR citens = loc_nCitens
2127:         IF !FOUND()
2128:             GO TOP
2129:         ENDIF
2130: 
2131:         THIS.RepintarGradeItens()
2132:         THIS.AjustarBotoesPorModo()
2133: 
2134:         RETURN .T.
2135:     ENDPROC
2136: 
2137:     *==========================================================================
2138:     * ExcluirLinhaGrade - Equivale a PROCEDURE deletaritem do legado, que eh o
2139:     * "Excluir" desta tela: exclusao de LINHA da grade de itens (o registro em
2140:     * SigMvItn so eh gravado/removido pelo form pai de Movimentacao, na
2141:     * confirmacao da operacao).
2142:     *
2143:     * Legado (deletaritem):
2144:     *   If !IsEmpty(crTpmMvItn.cpros)
2145:     *       _CItem = CItens / Delete / apaga os sub-itens de cItem2 = _CItem
2146:     *       Delete For cItem2 = _CItem
2147:     *   Else
2148:     *       Select Count(1) From crTpmMvItn Where IsEmpty(cpros) ... xApaga
2149:     *       If xApaga.Total > 1 / Delete / Else / Thisform.ApaIte() / EndIf
2150:     *   EndIf
2151:     *   Select crTpmMvItn / Go Top
2152:     *
2153:     * Isto eh: linha COM produto sai da grade junto com a composicao dela;
2154:     * linha SEM produto so sai se houver outra em branco - se for a unica, ela
2155:     * eh apenas esvaziada, para a grade nunca ficar sem linha de digitacao.
2156:     *
2157:     * PUBLIC: o form pai e o harness de teste chamam de fora.
2158:     *==========================================================================
2159:     PROCEDURE ExcluirLinhaGrade()
2160:         LOCAL loc_nCitens, loc_nEmBranco, loc_nRecno
2161: 
2162:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
2163:             RETURN .F.
2164:         ENDIF
2165: 
2166:         SELECT cursor_4c_Itens
2167: 
2168:         IF EMPTY(cursor_4c_Itens.cpros)
2169:             *-- COUNT varre o cursor e deixa o ponteiro em EOF: sem repor o
2170:             *-- RECNO, o DELETE abaixo cairia no registro fantasma do fim e
2171:             *-- nao apagaria linha nenhuma (sem erro e sem aviso).
2172:             loc_nRecno = RECNO()
2173:             COUNT FOR EMPTY(cpros) TO loc_nEmBranco
2174:             IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
2175:                 GO loc_nRecno
2176:             ENDIF
2177: 
2178:             IF loc_nEmBranco > 1
2179:                 DELETE
2180:             ELSE
2181:                 *-- Unica linha em branco: esvazia em vez de remover
2182:                 THIS.LimparLinhaGrade()
2183:                 RETURN .T.
2184:             ENDIF
2185:         ELSE
2186:             loc_nCitens = cursor_4c_Itens.citens
2187: 
2188:             DELETE
2189: 
2190:             *-- Composicao da linha excluida (legado: Delete For cItem2 = _CItem)
2191:             DELETE FOR citem2 = loc_nCitens AND citens <> loc_nCitens
2192:         ENDIF
2193: 
2194:         SELECT cursor_4c_Itens
2195:         GO TOP
2196: 
2197:         RETURN .T.
2198:     ENDPROC
2199: 
2200:     *==========================================================================
2201:     * RenumerarItensGrade - Equivale ao bloco de renumeracao do btnPApaga.Click
2202:     * do legado, que roda SEMPRE depois de excluir uma linha: as linhas que
2203:     * sobraram recebem citens 1..N em sequencia, e as referencias de
2204:     * composicao (cItem2) acompanham, senao o pai de uma composicao passa a
2205:     * apontar para item que nao existe mais.
2206:     *
2207:     * Legado: Set Order To CItens / Go Top / Cont = 0 / Scan / Cont = Cont + 1
2208:     *         ... Replace cItem2 With Cont For cItem2 = _cIt ... Replace CItens
2209:     *         With Cont / EndScan / Thisform.CItem = Cont

*-- Linhas 2217 a 2235:
2217: 
2218:         loc_nCont = 0
2219: 
2220:         SELECT cursor_4c_Itens
2221:         SET ORDER TO
2222:         GO TOP
2223: 
2224:         SCAN
2225:             loc_nCont      = loc_nCont + 1
2226:             loc_nCitensAnt = cursor_4c_Itens.citens
2227:             loc_nRecno     = RECNO()
2228: 
2229:             *-- Primeiro as referencias da composicao, depois o proprio item:
2230:             *-- invertido, o Replace de cItem2 nao encontraria mais o valor
2231:             *-- antigo para casar.
2232:             REPLACE citem2 WITH loc_nCont FOR citem2 = loc_nCitensAnt
2233: 
2234:             GO loc_nRecno
2235:             REPLACE citens WITH loc_nCont

*-- Linhas 2243 a 2282:
2243:     ENDPROC
2244: 
2245:     *==========================================================================
2246:     * GarantirLinhaDeDigitacao - Equivale ao "If Eof() / Insert Into
2247:     * crTpmMvItn(...) Values (..., 1)" que o legado faz no btnPApaga.Click
2248:     * depois de excluir: se a grade ficou sem nenhuma linha, entrega uma nova
2249:     * para o usuario continuar digitando.
2250:     *==========================================================================
2251:     PROCEDURE GarantirLinhaDeDigitacao()
2252:         LOCAL loc_nRegistros
2253: 
2254:         IF !USED("cursor_4c_Itens")
2255:             RETURN .F.
2256:         ENDIF
2257: 
2258:         SELECT cursor_4c_Itens
2259:         COUNT TO loc_nRegistros
2260: 
2261:         IF loc_nRegistros > 0
2262:             RETURN .F.
2263:         ENDIF
2264: 
2265:         THIS.this_nCItem = 1
2266: 
2267:         INSERT INTO cursor_4c_Itens (emps, dopes, numes, citens, empdopnums) ;
2268:             VALUES (PADR(THIS.this_cEmps, 3), PADR(THIS.this_cDopes, 20), ;
2269:                     THIS.this_nNumes, 1, THIS.ObterChaveMovimentacao())
2270: 
2271:         RETURN .T.
2272:     ENDPROC
2273: 
2274:     *==========================================================================
2275:     * TotalizarLinha - Equivale a PROCEDURE total_item do legado:
2276:     *
2277:     *   parameters pMantVal
2278:     *   =ThisForm.ParentForm.Calc_ValIte(,,pMantVal)
2279:     *   ThisForm.fwGrade.Refresh
2280:     *
2281:     * A aritmetica do total do item (unitario x quantidade, fator, moeda,
2282:     * descontos e impostos) eh regra de negocio que mora no Calc_ValIte do

*-- Linhas 2327 a 2391:
2327:     * mesmo comportamento vale aqui. A checagem de consistencia entre item e
2328:     * composicao eh INCONDICIONAL no legado e eh a que roda aqui:
2329:     *
2330:     *   Select a.* From crTpmMvIts a, crTpmMvItn b Where a.citens = b.citens
2331:     *       And a.CPros <> b.CPros Into Cursor ChecItem
2332:     *   If Reccount() > 0 / lcMsg = 'Problema de inconsistencia com o Item '
2333:     *       + Str(ChecItem.citens,4) + ' Produto:' + ChecItem.CPros
2334:     *
2335:     * Devolve .T. quando os itens estao consistentes.
2336:     *==========================================================================
2337:     PROCEDURE ValidarItensAntesDeSair()
2338:         LOCAL loc_lOk, loc_cMsg, loc_cTitulo, loc_nRecno
2339: 
2340:         loc_lOk     = .T.
2341:         loc_cMsg    = ""
2342:         loc_cTitulo = "Inconsistencia dos Itens"
2343: 
2344:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2345:             RETURN .T.
2346:         ENDIF
2347: 
2348:         IF !USED("cursor_4c_Itens")
2349:             RETURN .T.
2350:         ENDIF
2351: 
2352:         SELECT cursor_4c_Itens
2353:         loc_nRecno = RECNO()
2354: 
2355:         *-- Composicao (citem2 aponta o item pai) cujo produto divergiu do
2356:         *-- produto do pai: no legado sao duas tabelas (crTpmMvIts x
2357:         *-- crTpmMvItn) ligadas por citens; aqui convivem no mesmo cursor.
2358:         SELECT a.citens, a.cpros ;
2359:             FROM cursor_4c_Itens a, cursor_4c_Itens b ;
2360:             WHERE a.citem2 <> 0 ;
2361:               AND a.citem2 = b.citens ;
2362:               AND a.cpros <> b.cpros ;
2363:             INTO CURSOR cursor_4c_ChecaItem
2364: 
2365:         IF USED("cursor_4c_ChecaItem")
2366:             SELECT cursor_4c_ChecaItem
2367:             GO TOP
2368:             IF !EOF()
2369:                 loc_cMsg = "Problema de inconsistencia com o Item " + ;
2370:                            STR(cursor_4c_ChecaItem.citens, 4) + ;
2371:                            " Produto:" + ALLTRIM(cursor_4c_ChecaItem.cpros)
2372:             ENDIF
2373:             USE IN cursor_4c_ChecaItem
2374:         ENDIF
2375: 
2376:         SELECT cursor_4c_Itens
2377:         IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
2378:             GO loc_nRecno
2379:         ENDIF
2380: 
2381:         IF !EMPTY(loc_cMsg)
2382:             loc_lOk = .F.
2383:             MsgAviso(loc_cMsg, loc_cTitulo)
2384: 
2385:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Visible
2386:                 THIS.grd_4c_Dados.SetFocus()
2387:             ENDIF
2388:         ENDIF
2389: 
2390:         RETURN loc_lOk
2391:     ENDPROC

*-- Linhas 2603 a 2621:
2603:         THIS.GarantirLinhaDeDigitacao()
2604:         THIS.RenumerarItensGrade()
2605: 
2606:         SELECT cursor_4c_Itens
2607:         GO TOP
2608: 
2609:         THIS.RepintarGradeItens()
2610:         THIS.AjustarBotoesPorModo()
2611: 
2612:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Visible
2613:             THIS.grd_4c_Dados.SetFocus()
2614:         ENDIF
2615:     ENDPROC
2616: 
2617:     *-- "Carregar Composicao": Do Form SigSubCp (composicao do produto)
2618:     PROCEDURE BtnComposClick()
2619:         LOCAL loc_oForm, loc_oErro
2620:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") OR !THIS.TemProdutoSelecionado()
2621:             RETURN

*-- Linhas 2666 a 2685:
2666: 
2667:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro") AND USED("cursor_4c_Itens") ;
2668:                AND !EOF("cursor_4c_Itens")
2669:                 SELECT cursor_4c_BuscaPro
2670:                 SELECT cursor_4c_Itens
2671:                 REPLACE cpros WITH ALLTRIM(cursor_4c_BuscaPro.Cpros), ;
2672:                         dpros WITH ALLTRIM(cursor_4c_BuscaPro.Dpros)
2673:                 THIS.grd_4c_Dados.Refresh()
2674:             ENDIF
2675: 
2676:             loc_oBusca.Release()
2677:         ENDIF
2678: 
2679:         IF USED("cursor_4c_BuscaPro")
2680:             USE IN cursor_4c_BuscaPro
2681:         ENDIF
2682:     ENDPROC
2683: 
2684:     *-- "Informar Pedido": Do Form SigOpPed With ThisForm, DataSessionId
2685:     PROCEDURE BtnPedidoClick()

*-- Linhas 2833 a 2851:
2833:     * tamanho, com browse), get_prod / get_qtd (conferencia por codigo de
2834:     * barras) e getBusca (procura na grade).
2835:     *
2836:     * Os campos que SAO coluna de SigMvItn usam ControlSource sobre
2837:     * cursor_4c_Itens - exatamente o que o legado faz sobre crTpmMvItn - e por
2838:     * isso acompanham a linha corrente da grade sozinhos. Os de EXIBICAO
2839:     * (preco atual, grupo de venda, referencia, saldo, resta, peso medio) nao
2840:     * sao coluna do item: no legado o AfterRowColChange da grade os preenche a
2841:     * cada troca de linha, e aqui AtualizarPainelProduto() faz o mesmo.
2842:     *
2843:     * cnt_4c_Obs nasce Visible = .F. (painel flutuante da observacao, aberto
2844:     * pelo Click de obj_4c_GetObs) e por isso entra na lista de excecao de
2845:     * TornarControlesVisiveis / ReaplicarVisibilidadeInicial.
2846:     *==========================================================================
2847:     PROTECTED PROCEDURE ConfigurarPaginaProduto()
2848:         LOCAL loc_oPag
2849:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2850: 
2851:         *-- cnt_4c_Obs (cntObs no legado) - painel flutuante da observacao ---

*-- Linhas 2870 a 2888:
2870:             .FontName      = "Tahoma"
2871:             .FontSize      = 8
2872:             .SpecialEffect = 1
2873:             .ControlSource = "cursor_4c_Itens.obs"
2874:             .ToolTipText   = "Observa" + CHR(231) + CHR(227) + "o do Produto"
2875:             .Visible       = .T.
2876:         ENDWITH
2877: 
2878:         *-- shp_4c_Shape4 - moldura da area da imagem do produto -------------
2879:         loc_oPag.AddObject("shp_4c_Shape4", "Shape")
2880:         WITH loc_oPag.shp_4c_Shape4
2881:             .Top           = 2
2882:             .Left          = 2
2883:             .Width         = 192
2884:             .Height        = 167
2885:             .BackStyle     = 0
2886:             .BorderWidth   = 2
2887:             .SpecialEffect = 0
2888:             .Visible       = .T.

*-- Linhas 2930 a 2948:
2930:             .MaxLength         = 65
2931:             .Margin            = 2
2932:             .SpecialEffect     = 1
2933:             .ControlSource     = "cursor_4c_Itens.dpros"
2934:             .BackColor         = RGB(255, 255, 255)
2935:             .DisabledBackColor = RGB(255, 255, 255)
2936:             .DisabledForeColor = RGB(192, 192, 192)
2937:             .BorderColor       = RGB(90, 90, 90)
2938:             .ToolTipText       = "Descri" + CHR(231) + CHR(227) + "o do Produto"
2939:             .Visible           = .T.
2940:         ENDWITH
2941: 
2942:         *-- Preco atual (exibicao - vem de SigCdPro, nao eh coluna do item) --
2943:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
2944:         WITH loc_oPag.lbl_4c_Label1
2945:             .Top       = 72
2946:             .Left      = 202
2947:             .Width     = 60
2948:             .Height    = 15

*-- Linhas 3039 a 3057:
3039:             .FontSize      = 8
3040:             .Margin        = 2
3041:             .SpecialEffect = 1
3042:             .ControlSource = "cursor_4c_Itens.obs"
3043:             .NullDisplay   = " "
3044:             .BorderColor   = RGB(90, 90, 90)
3045:             .ToolTipText   = "Observa" + CHR(231) + CHR(227) + "o do Produto"
3046:             .Visible       = .T.
3047:         ENDWITH
3048: 
3049:         *-- Codigo de barras do item (somente leitura) -----------------------
3050:         loc_oPag.AddObject("lbl_4c_Label5", "Label")
3051:         WITH loc_oPag.lbl_4c_Label5
3052:             .Top       = 36
3053:             .Left      = 202
3054:             .Width     = 35
3055:             .Height    = 15
3056:             .Caption   = "Barra"
3057:             .FontName  = "Tahoma"

*-- Linhas 3075 a 3093:
3075:             .Margin            = 2
3076:             .ReadOnly          = .T.
3077:             .SpecialEffect     = 1
3078:             .ControlSource     = "cursor_4c_Itens.codbarras"
3079:             .DisabledBackColor = RGB(255, 255, 255)
3080:             .BorderColor       = RGB(90, 90, 90)
3081:             .ToolTipText       = "C" + CHR(243) + "digo de Barras do Produto"
3082:             .Visible           = .T.
3083:         ENDWITH
3084: 
3085:         *-- Documento (notas) ------------------------------------------------
3086:         loc_oPag.AddObject("lbl_4c_Label7", "Label")
3087:         WITH loc_oPag.lbl_4c_Label7
3088:             .Top       = 36
3089:             .Left      = 311
3090:             .Width     = 56
3091:             .Height    = 15
3092:             .Caption   = "Documento"
3093:             .FontName  = "Tahoma"

*-- Linhas 3112 a 3130:
3112:             .MaxLength         = 6
3113:             .Margin            = 2
3114:             .SpecialEffect     = 1
3115:             .ControlSource     = "cursor_4c_Itens.notas"
3116:             .DisabledBackColor = RGB(255, 255, 255)
3117:             .BorderColor       = RGB(90, 90, 90)
3118:             .ToolTipText       = "Documento do Produto"
3119:             .Visible           = .T.
3120:         ENDWITH
3121: 
3122:         *-- Numero do lote ---------------------------------------------------
3123:         loc_oPag.AddObject("lbl_4c_Label8", "Label")
3124:         WITH loc_oPag.lbl_4c_Label8
3125:             .Top       = 36
3126:             .Left      = 380
3127:             .Width     = 63
3128:             .Height    = 15
3129:             .Caption   = "N" + CHR(250) + "mero Lote"
3130:             .FontName  = "Tahoma"

*-- Linhas 3149 a 3186:
3149:             .MaxLength         = 10
3150:             .Margin            = 2
3151:             .SpecialEffect     = 1
3152:             .ControlSource     = "cursor_4c_Itens.nlotes"
3153:             .DisabledBackColor = RGB(255, 255, 255)
3154:             .BorderColor       = RGB(90, 90, 90)
3155:             .ToolTipText       = "N" + CHR(250) + "mero do Lote"
3156:             .Visible           = .T.
3157:         ENDWITH
3158: 
3159:         *-- Moeda do preco atual ---------------------------------------------
3160:         loc_oPag.AddObject("txt_4c_MoeVs", "TextBox")
3161:         WITH loc_oPag.txt_4c_MoeVs
3162:             .Top               = 84
3163:             .Left              = 303
3164:             .Width             = 31
3165:             .Height            = 21
3166:             .FontName          = "Tahoma"
3167:             .FontSize          = 8
3168:             .MaxLength         = 3
3169:             .Margin            = 2
3170:             .SpecialEffect     = 1
3171:             .ControlSource     = "cursor_4c_Itens.moevs"
3172:             .ForeColor         = RGB(90, 90, 90)
3173:             .BackColor         = RGB(255, 255, 255)
3174:             .DisabledBackColor = RGB(255, 255, 255)
3175:             .DisabledForeColor = RGB(192, 192, 192)
3176:             .BorderColor       = RGB(90, 90, 90)
3177:             .ToolTipText       = "Moeda do Pre" + CHR(231) + "o Atual"
3178:             .Visible           = .T.
3179:         ENDWITH
3180: 
3181:         *-- Grupo de venda (exibicao) ----------------------------------------
3182:         loc_oPag.AddObject("lbl_4c_Label11", "Label")
3183:         WITH loc_oPag.lbl_4c_Label11
3184:             .Top       = 2
3185:             .Left      = 491
3186:             .Width     = 80

*-- Linhas 3245 a 3263:
3245:             .InputMask         = "999,999.99"
3246:             .Margin            = 2
3247:             .SpecialEffect     = 1
3248:             .ControlSource     = "cursor_4c_Itens.valdescs"
3249:             .DisabledBackColor = RGB(255, 255, 255)
3250:             .BorderColor       = RGB(90, 90, 90)
3251:             .ToolTipText       = "Valor do Desconto"
3252:             .Visible           = .T.
3253:         ENDWITH
3254: 
3255:         *-- Desconto em percentual -------------------------------------------
3256:         loc_oPag.AddObject("lbl_4c_LblPDescs", "Label")
3257:         WITH loc_oPag.lbl_4c_LblPDescs
3258:             .Top       = 72
3259:             .Left      = 581
3260:             .Width     = 61
3261:             .Height    = 15
3262:             .Caption   = "% Desconto"
3263:             .FontName  = "Tahoma"

*-- Linhas 3282 a 3300:
3282:             .InputMask         = "999.99"
3283:             .Margin            = 2
3284:             .SpecialEffect     = 1
3285:             .ControlSource     = "cursor_4c_Itens.pdescs"
3286:             .DisabledBackColor = RGB(255, 255, 255)
3287:             .BorderColor       = RGB(90, 90, 90)
3288:             .ToolTipText       = "Percentual do Desconto"
3289:             .Visible           = .T.
3290:         ENDWITH
3291: 
3292:         *-- Observacoes do pedido (exibicao) ---------------------------------
3293:         loc_oPag.AddObject("obj_4c_GetObsPes", "EditBox")
3294:         WITH loc_oPag.obj_4c_GetObsPes
3295:             .Top           = 107
3296:             .Left          = 202
3297:             .Width         = 200
3298:             .Height        = 21
3299:             .FontName      = "Courier New"
3300:             .FontSize      = 8

*-- Linhas 3353 a 3371:
3353:             .MaxLength     = 4
3354:             .Margin        = 2
3355:             .SpecialEffect = 1
3356:             .ControlSource = "cursor_4c_Itens.codcors"
3357:             .BorderColor   = RGB(90, 90, 90)
3358:             .ToolTipText   = "Cor do Produto"
3359:             .Visible       = .F.
3360:         ENDWITH
3361: 
3362:         loc_oPag.AddObject("lbl_4c_LblCodTams", "Label")
3363:         WITH loc_oPag.lbl_4c_LblCodTams
3364:             .Top       = 2
3365:             .Left      = 790
3366:             .Width     = 22
3367:             .Height    = 15
3368:             .Caption   = "Tam"
3369:             .FontName  = "Tahoma"
3370:             .FontSize  = 8
3371:             .AutoSize  = .F.

*-- Linhas 3387 a 3405:
3387:             .MaxLength     = 4
3388:             .Margin        = 2
3389:             .SpecialEffect = 1
3390:             .ControlSource = "cursor_4c_Itens.codtams"
3391:             .BorderColor   = RGB(90, 90, 90)
3392:             .ToolTipText   = "Tamanho do Produto"
3393:             .Visible       = .F.
3394:         ENDWITH
3395: 
3396:         *-- cnt_4c_Reffs - referencia do fornecedor (exibicao) ---------------
3397:         loc_oPag.AddObject("cnt_4c_Reffs", "Container")
3398:         WITH loc_oPag.cnt_4c_Reffs
3399:             .Top         = 66
3400:             .Left        = 332
3401:             .Width       = 154
3402:             .Height      = 41
3403:             .BackStyle   = 0
3404:             .BorderWidth = 0
3405:             .BorderColor = RGB(36, 84, 155)

*-- Linhas 3507 a 3525:
3507:             .Margin        = 2
3508:             .ReadOnly      = .T.
3509:             .SpecialEffect = 1
3510:             .ControlSource = "cursor_4c_Itens.qtbaixas"
3511:             .BorderColor   = RGB(90, 90, 90)
3512:             .ToolTipText   = "Quantidade Baixada"
3513:             .Visible       = .T.
3514:         ENDWITH
3515: 
3516:         loc_oPag.AddObject("lbl_4c_Label9", "Label")
3517:         WITH loc_oPag.lbl_4c_Label9
3518:             .Top       = 112
3519:             .Left      = 729
3520:             .Width     = 35
3521:             .Height    = 15
3522:             .Caption   = "Resta"
3523:             .FontName  = "Tahoma"
3524:             .FontSize  = 8
3525:             .AutoSize  = .F.

*-- Linhas 3763 a 3781:
3763:         *-- nao o item pai da composicao: no legado o preenchimento eh
3764:         *-- "getConjunts.Value = crTmpPro.Conjunts". Por isso fica em .Value
3765:         *-- (campo de EXIBICAO, alimentado por AtualizarPainelProduto) e NAO
3766:         *-- com ControlSource em citem2, que eh outra coisa.
3767:         loc_oPag.AddObject("txt_4c_Conjunts", "TextBox")
3768:         WITH loc_oPag.txt_4c_Conjunts
3769:             .Top               = 140
3770:             .Left              = 202
3771:             .Width             = 55
3772:             .Height            = 21
3773:             .FontName          = "Courier New"
3774:             .FontSize          = 8
3775:             .Alignment         = 3
3776:             .Value             = ""
3777:             .MaxLength         = 6
3778:             .Margin            = 2
3779:             .ReadOnly          = .T.
3780:             .SpecialEffect     = 1
3781:             .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 3850 a 3868:
3850:     * impostos (btnAltImps.Click faz "pgfPagina.pgFiscs.Enabled = .t."), e eh
3851:     * isso que HabilitarCampos reproduz.
3852:     *
3853:     * Os campos sao coluna de SigMvItn e por isso usam ControlSource sobre
3854:     * cursor_4c_Itens, acompanhando a linha corrente da grade. Os dois que NAO
3855:     * sao coluna do item (classificacao fiscal e a descricao dela, que vem de
3856:     * SigCdPro/SigCdClf) ficam em .Value e sao preenchidos por
3857:     * AtualizarPainelProduto(), como o AfterRowColChange do legado faz.
3858:     *==========================================================================
3859:     PROTECTED PROCEDURE ConfigurarPaginaFiscal()
3860:         LOCAL loc_oPag, loc_oCnt
3861:         loc_oPag = THIS.pgf_4c_Paginas.Page3
3862: 
3863:         loc_oPag.AddObject("cnt_4c_Item", "Container")
3864:         WITH loc_oPag.cnt_4c_Item
3865:             .Top           = -6
3866:             .Left          = 2
3867:             .Width         = 973
3868:             .Height        = 151

*-- Linhas 3905 a 3940:
3905:             .MaxLength     = 14
3906:             .ReadOnly      = .T.
3907:             .SpecialEffect = 1
3908:             .ControlSource = "cursor_4c_Itens.cpros"
3909:             .BackColor     = RGB(251, 254, 226)
3910:             .BorderColor   = RGB(90, 90, 90)
3911:             .Visible       = .T.
3912:         ENDWITH
3913: 
3914:         loc_oCnt.AddObject("txt_4c_FDPros", "TextBox")
3915:         WITH loc_oCnt.txt_4c_FDPros
3916:             .Top               = 21
3917:             .Left              = 119
3918:             .Width             = 303
3919:             .Height            = 21
3920:             .FontName          = "Courier New"
3921:             .FontSize          = 8
3922:             .MaxLength         = 65
3923:             .ReadOnly          = .T.
3924:             .SpecialEffect     = 1
3925:             .ControlSource     = "cursor_4c_Itens.dpros"
3926:             .BackColor         = RGB(251, 254, 226)
3927:             .DisabledBackColor = RGB(255, 255, 255)
3928:             .DisabledForeColor = RGB(192, 192, 192)
3929:             .BorderColor       = RGB(90, 90, 90)
3930:             .Visible           = .T.
3931:         ENDWITH
3932: 
3933:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFClFis", 7, 424, 100, ;
3934:                                   "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
3935: 
3936:         loc_oCnt.AddObject("txt_4c_FClFis", "TextBox")
3937:         WITH loc_oCnt.txt_4c_FClFis
3938:             .Top           = 21
3939:             .Left          = 424
3940:             .Width         = 89

*-- Linhas 3980 a 3998:
3980:             .FontName      = "Tahoma"
3981:             .FontSize      = 8
3982:             .SpecialEffect = 1
3983:             .ControlSource = "cursor_4c_Itens.ob2s"
3984:             .NullDisplay   = " "
3985:             .BorderColor   = RGB(90, 90, 90)
3986:             .ToolTipText   = "Observa" + CHR(231) + CHR(227) + "o 2"
3987:             .Visible       = .T.
3988:         ENDWITH
3989: 
3990:         *-- Linha 2: total, IPI, ICMS, ICMS-ST, situacao tributaria ----------
3991:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFTotal", 48, 10, 35, "Total")
3992:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FTotal", 61, 10, 112, ;
3993:                                     "999,999,999.99", "cursor_4c_Itens.totas")
3994: 
3995:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFPipis", 48, 124, 35, "%IPI")
3996:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FPipis", 61, 124, 48, ;
3997:                                     "99.99", "cursor_4c_Itens.aliqs")
3998: 

*-- Linhas 4030 a 4048:
4030:             .SpecialEffect = 1
4031:             *-- getSitTrI do legado le crTpmMvItn.SitTrIcms (NAO sitribs, que
4032:             *-- eh outra coluna da mesma tabela)
4033:             .ControlSource = "cursor_4c_Itens.sittricms"
4034:             .BackColor     = RGB(251, 254, 226)
4035:             .BorderColor   = RGB(90, 90, 90)
4036:             .Visible       = .T.
4037:         ENDWITH
4038: 
4039:         *-- Linha 3: bases de IPI / ICMS / ICMS-ST e CFOP --------------------
4040:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_VBipis", 84, 174, 97, ;
4041:                                     "9999,999.99", "cursor_4c_Itens.bcipis")
4042:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FBIcms", 84, 323, 98, ;
4043:                                     "9999,999.99", "cursor_4c_Itens.baseicms")
4044:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FBIcsS", 84, 424, 96, ;
4045:                                     "9999,999.99", "cursor_4c_Itens.bcicmss")
4046: 
4047:         loc_oCnt.AddObject("txt_4c_Cfop", "TextBox")
4048:         WITH loc_oCnt.txt_4c_Cfop

*-- Linhas 4058 a 4076:
4058:             .MaxLength     = 10
4059:             .ReadOnly      = .T.
4060:             .SpecialEffect = 1
4061:             .ControlSource = "cursor_4c_Itens.cfops"
4062:             .BackColor     = RGB(251, 254, 226)
4063:             .BorderColor   = RGB(90, 90, 90)
4064:             .Visible       = .T.
4065:         ENDWITH
4066: 
4067:         *-- Linha 4: base de calculo, PIS, COFINS, ISS, IRRF, INSS, CSSL, II -
4068:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label5", 111, 13, 67, ;
4069:                                   "Base C" + CHR(225) + "lculos")
4070:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_VBc", 124, 10, 108, ;
4071:                                     "999,999,999.99", "cursor_4c_Itens.valbases")
4072: 
4073:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label6", 111, 124, 18, "PIS")
4074:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_Vpis", 124, 121, 95, ;
4075:                                     "999,999.99", "cursor_4c_Itens.vpis")
4076: 

*-- Linhas 4116 a 4180:
4116:             .InputMask         = "999"
4117:             .MaxLength         = 3
4118:             .SpecialEffect     = 1
4119:             .ControlSource     = "cursor_4c_Itens.nadis"
4120:             .DisabledBackColor = RGB(255, 255, 255)
4121:             .BorderColor       = RGB(90, 90, 90)
4122:             .ToolTipText       = "Dado de Importa" + CHR(231) + CHR(227) + ;
4123:                                  "o - Numero da Adi" + CHR(231) + CHR(227) + "o"
4124:             .Visible           = .T.
4125:         ENDWITH
4126: 
4127:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label2", 69, 875, 59, ;
4128:                                   "Item Adi" + CHR(231) + CHR(227) + "o")
4129: 
4130:         loc_oCnt.AddObject("txt_4c_NIAdis", "TextBox")
4131:         WITH loc_oCnt.txt_4c_NIAdis
4132:             .Top               = 84
4133:             .Left              = 876
4134:             .Width             = 31
4135:             .Height            = 21
4136:             .FontName          = "Tahoma"
4137:             .FontSize          = 8
4138:             .Alignment         = 3
4139:             .InputMask         = "999"
4140:             .MaxLength         = 3
4141:             .SpecialEffect     = 1
4142:             .ControlSource     = "cursor_4c_Itens.niadis"
4143:             .DisabledBackColor = RGB(255, 255, 255)
4144:             .BorderColor       = RGB(90, 90, 90)
4145:             .ToolTipText       = "Dado de Importa" + CHR(231) + CHR(227) + ;
4146:                                  "o - Numero do item da Adi" + CHR(231) + CHR(227) + "o"
4147:             .Visible           = .T.
4148:         ENDWITH
4149: 
4150:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label3", 108, 806, 121, ;
4151:                                   "C Fabricante Estrangeiro")
4152: 
4153:         loc_oCnt.AddObject("txt_4c_Codfabs", "TextBox")
4154:         WITH loc_oCnt.txt_4c_Codfabs
4155:             .Top               = 123
4156:             .Left              = 806
4157:             .Width             = 155
4158:             .Height            = 21
4159:             .FontName          = "Tahoma"
4160:             .FontSize          = 8
4161:             .Alignment         = 0
4162:             .Format            = "!"
4163:             .MaxLength         = 6
4164:             .SpecialEffect     = 1
4165:             .ControlSource     = "cursor_4c_Itens.codfabs"
4166:             .DisabledBackColor = RGB(255, 255, 255)
4167:             .BorderColor       = RGB(90, 90, 90)
4168:             .ToolTipText       = "Dado de Importa" + CHR(231) + CHR(227) + ;
4169:                                  "o - C" + CHR(243) + "digo do Fabricante Estrangeiro"
4170:             .Visible           = .T.
4171:         ENDWITH
4172:     ENDPROC
4173: 
4174:     *==========================================================================
4175:     * AdicionarLabelFiscal - Fabrica dos rotulos de cnt_4c_Item. Todos os Say
4176:     * daquele container tem no dump a MESMA assinatura (Tahoma 8, FontBold
4177:     * = .F., BackStyle = 0, ForeColor = 90,90,90) e variam so em Top/Left/
4178:     * Width/Caption, entao repetir 20 blocos WITH identicos aqui so aumentaria
4179:     * a chance de um deles sair com propriedade faltando.
4180:     *

*-- Linhas 4228 a 4343:
4228:             .InputMask     = par_cMascara
4229:             .ReadOnly      = .T.
4230:             .SpecialEffect = 1
4231:             .ControlSource = par_cFonte
4232:             .BackColor     = RGB(251, 254, 226)
4233:             .BorderColor   = RGB(90, 90, 90)
4234:             .Visible       = .T.
4235:         ENDWITH
4236:     ENDPROC
4237: 
4238:     *==========================================================================
4239:     * CriarCursorPrecos - Cursor da grade de Precificacao (Page4). No legado a
4240:     * grdPrecos esta ligada a "lpitem", cursor da lista de precificacao que
4241:     * vive no data session do form PAI de Movimentacao; aqui ele eh local e eh
4242:     * populado por CarregarPrecos() a partir de SigOpLpi/SigOpLpr.
4243:     *
4244:     * Criado ANTES de ConfigurarPaginaPrecos porque Column.ControlSource de
4245:     * alias inexistente derruba o Init (regra #41).
4246:     *==========================================================================
4247:     PROTECTED PROCEDURE CriarCursorPrecos()
4248:         IF USED("cursor_4c_Precos")
4249:             USE IN cursor_4c_Precos
4250:         ENDIF
4251: 
4252:         SET NULL ON
4253:         CREATE CURSOR cursor_4c_Precos ( ;
4254:             lprecos C(30), tabds C(20), units N(11,2), moedas C(3))
4255:         SET NULL OFF
4256:     ENDPROC
4257: 
4258:     *==========================================================================
4259:     * ConfigurarPaginaPrecos - Page4 (pgPrecos no legado) "Precificacao".
4260:     *
4261:     * Grade grdPrecos: lista as precificacoes disponiveis para o produto do
4262:     * item corrente. Nasce Visible = .F. e ReadOnly = .T. no SCX legado (o
4263:     * proprio legado so a mostra quando a operacao trabalha com lista de
4264:     * precos), e por isso entra na lista de excecao de
4265:     * TornarControlesVisiveis / ReaplicarVisibilidadeInicial.
4266:     *
4267:     * Ordem de configuracao obrigatoria (regra #41 / Problema 48):
4268:     * ColumnCount -> RecordSource -> ControlSource -> Width -> Header.Caption.
4269:     *==========================================================================
4270:     PROTECTED PROCEDURE ConfigurarPaginaPrecos()
4271:         LOCAL loc_oPag, loc_oGrd
4272:         loc_oPag = THIS.pgf_4c_Paginas.Page4
4273: 
4274:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
4275:         loc_oGrd = loc_oPag.grd_4c_Dados
4276: 
4277:         WITH loc_oGrd
4278:             .Top                = 9
4279:             .Left               = 7
4280:             .Width              = 416
4281:             .Height             = 131
4282:             .ColumnCount        = 4
4283:             .DeleteMark         = .F.
4284:             .RecordMark         = .F.
4285:             .ScrollBars         = 2
4286:             .ReadOnly           = .T.
4287:             .AllowHeaderSizing  = .F.
4288:             .GridLineColor      = RGB(238, 238, 238)
4289:             .RecordSource       = "cursor_4c_Precos"
4290:             .Visible            = .F.
4291:         ENDWITH
4292: 
4293:         WITH loc_oGrd.Column1
4294:             .ControlSource   = "cursor_4c_Precos.lprecos"
4295:             .Width           = 210
4296:             .Movable         = .F.
4297:             .Resizable       = .F.
4298:             .ReadOnly        = .T.
4299:             .FontName        = "Courier New"
4300:             .Header1.Caption = "Lista de Precifica" + CHR(231) + CHR(227) + "o"
4301:             .Visible         = .T.
4302:         ENDWITH
4303: 
4304:         WITH loc_oGrd.Column2
4305:             .ControlSource   = "cursor_4c_Precos.tabds"
4306:             .Width           = 80
4307:             .Movable         = .F.
4308:             .Resizable       = .F.
4309:             .ReadOnly        = .T.
4310:             .FontName        = "Courier New"
4311:             .Header1.Caption = "Tab.Varia" + CHR(231) + CHR(227) + "o"
4312:             .Visible         = .T.
4313:         ENDWITH
4314: 
4315:         WITH loc_oGrd.Column3
4316:             .ControlSource   = "cursor_4c_Precos.units"
4317:             .Width           = 70
4318:             .Movable         = .F.
4319:             .Resizable       = .F.
4320:             .ReadOnly        = .T.
4321:             .FontName        = "Courier New"
4322:             .InputMask       = "9999,999.99"
4323:             .Header1.Caption = "Unit" + CHR(225) + "rio"
4324:             .Visible         = .T.
4325:         ENDWITH
4326: 
4327:         WITH loc_oGrd.Column4
4328:             .ControlSource   = "cursor_4c_Precos.moedas"
4329:             .Width           = 30
4330:             .Movable         = .F.
4331:             .Resizable       = .F.
4332:             .ReadOnly        = .T.
4333:             .FontName        = "Courier New"
4334:             .Header1.Caption = "Moe"
4335:             .Visible         = .T.
4336:         ENDWITH
4337: 
4338:         WITH loc_oGrd
4339:             .FontName = "Courier New"
4340:             .FontSize = 8
4341:             .HeaderHeight = 16
4342:             .RowHeight    = 16
4343:         ENDWITH

*-- Linhas 4353 a 4372:
4353:     * inventa consulta: o pai informa o alias que ele montou e este metodo
4354:     * copia as linhas para cursor_4c_Precos, repinta e mostra a grade.
4355:     *
4356:     * Desvio registrado: no SCX legado so Column2 declara ControlSource
4357:     * ("lpitem.tabds") - as outras tres ficaram com ControlSource vazio, o que
4358:     * as deixa em branco na tela. Os headers ("Lista de Precificacao",
4359:     * "Unitario", "Moe"), a MaxLength = 30 da Column1 e a InputMask numerica da
4360:     * Column3 provam a intencao, e por isso as quatro colunas foram ligadas.
4361:     *
4362:     * PUBLIC: eh o form pai quem chama.
4363:     *==========================================================================
4364:     PROCEDURE CarregarPrecos(par_cCursorOrigem)
4365:         LOCAL loc_lSucesso, loc_oErro
4366: 
4367:         loc_lSucesso = .F.
4368: 
4369:         IF VARTYPE(par_cCursorOrigem) <> "C" OR EMPTY(par_cCursorOrigem)
4370:             RETURN .F.
4371:         ENDIF
4372: 

*-- Linhas 4381 a 4405:
4381:         TRY
4382:             *-- ZAP (nao fechar/recriar): fechar o alias derrubaria o
4383:             *-- RecordSource da grade e ela viraria um retangulo branco.
4384:             SELECT cursor_4c_Precos
4385:             THIS.ZaparCursor("cursor_4c_Precos")
4386: 
4387:             *-- APPEND FROM DBF casa os campos por NOME: o alias do pai tem de
4388:             *-- trazer lprecos/tabds/units/moedas.
4389:             SELECT cursor_4c_Precos
4390:             APPEND FROM DBF(ALLTRIM(par_cCursorOrigem))
4391: 
4392:             GO TOP IN cursor_4c_Precos
4393: 
4394:             WITH THIS.pgf_4c_Paginas.Page4.grd_4c_Dados
4395:                 .Visible = (RECCOUNT("cursor_4c_Precos") > 0)
4396:                 .Refresh()
4397:             ENDWITH
4398: 
4399:             loc_lSucesso = .T.
4400: 
4401:         CATCH TO loc_oErro
4402:             THIS.this_cMensagemErro = loc_oErro.Message
4403:             MsgErro("Erro ao carregar a lista de precifica" + CHR(231) + CHR(227) + ;
4404:                     "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
4405:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 4426 a 4444:
4426:         loc_cSafety = SET("SAFETY")
4427:         SET SAFETY OFF
4428: 
4429:         SELECT (ALLTRIM(par_cAlias))
4430:         ZAP
4431: 
4432:         IF loc_cSafety = "ON"
4433:             SET SAFETY ON
4434:         ENDIF
4435: 
4436:         RETURN .T.
4437:     ENDPROC
4438: 
4439:     *==========================================================================
4440:     * GradeAfterRowColChange - Handler de AfterRowColChange de grd_4c_Dados.
4441:     *
4442:     * Declara par_nColIndex porque o evento passa esse argumento e handler sem
4443:     * o parametro estoura a cada troca de celula (regra #3). O uso aqui eh o
4444:     * MESMO do legado: carregar o detalhe da LINHA corrente, sem filtrar por

*-- Linhas 4457 a 4493:
4457:     * a partir do produto da linha corrente da grade.
4458:     *
4459:     * Transcreve o bloco de preenchimento do fwGrade.AfterRowColChange do
4460:     * legado: consulta SigCdPro (com LEFT JOIN em SigCdCol para a descricao da
4461:     * colecao), SigPrFnc (referencia do fornecedor por conta), SigMvEst (saldo
4462:     * do produto no grupo de estoque), SigCdCli (nome do fornecedor) e
4463:     * SigCdClf (descricao da classificacao fiscal), e devolve:
4464:     *
4465:     *   getPVens/getMoeVs       <- crTmpPro.PVens / .MoeVs
4466:     *   cntReffs.getReffs       <- SigPrFnc.Reffs, com fallback SigCdPro.Reffs
4467:     *   getGVendas              <- Colecoes + " - " + Descs da colecao
4468:     *   getObsPes/getObsPeds    <- crTmpPro.ObsPes / .ObsPeds
4469:     *   getPesoms               <- crTmpPro.Pesoms
4470:     *   gerDIfors               <- SigCdCli.RClis do fornecedor do produto
4471:     *   getsaldo                <- SigMvEst.Sqtds
4472:     *   getqtresta              <- qtds - qtbaixas (qtds quando nada baixado)
4473:     *   lblVDescs/lblPDescs     <- trocam para "Acrescimo" quando ValDescs < 0
4474:     *   getFClFis/getFDlFis     <- classificacao fiscal e a descricao dela
4475:     *
4476:     * Os campos que SAO coluna de SigMvItn nao aparecem aqui: eles tem
4477:     * ControlSource sobre cursor_4c_Itens e acompanham a linha sozinhos - no
4478:     * legado eram atribuidos um a um porque la nao havia ControlSource.
4479:     *
4480:     * PUBLIC: o form pai e o harness chamam de fora.
4481:     *==========================================================================
4482:     PROCEDURE AtualizarPainelProduto()
4483:         LOCAL loc_oPag, loc_oFis, loc_cPro, loc_cSQL, loc_cReff, loc_cDsCol
4484:         LOCAL loc_cNomeFor, loc_cClFis, loc_cDsClFis, loc_nSaldo, loc_nResta
4485:         LOCAL loc_lProsseguir, loc_oErro
4486: 
4487:         loc_oPag = THIS.pgf_4c_Paginas.Page1
4488:         loc_oFis = THIS.pgf_4c_Paginas.Page3.cnt_4c_Item
4489: 
4490:         loc_cPro = ""
4491:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
4492:             loc_cPro = ALLTRIM(cursor_4c_Itens.cpros)
4493:         ENDIF

*-- Linhas 4515 a 4648:
4515: 
4516:         TRY
4517:             *-- Produto + descricao da colecao -----------------------------
4518:             loc_cSQL = "SELECT a.Cpros, a.CGrus, a.Reffs, a.Situas," + ;
4519:                        " a.DtSituas, a.CUnis, a.Dpros, a.PesoMs, a.MoeVs," + ;
4520:                        " a.PVens, a.Moedas, a.Colecoes, a.ClFiscals," + ;
4521:                        " a.ObsPes, a.ObsPeds, a.Conjunts, a.ifors," + ;
4522:                        " b.Descs AS ColDescs" + ;
4523:                        " FROM SigCdPro a" + ;
4524:                        " LEFT JOIN SigCdCol b ON a.Colecoes = b.Colecoes" + ;
4525:                        " WHERE a.Cpros = " + EscaparSQL(loc_cPro)
4526: 
4527:             IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ProTmp")
4528:                 IF USED("cursor_4c_ProTmp")
4529:                     SELECT cursor_4c_ProTmp
4530:                     GO TOP
4531:                     IF !EOF()
4532:                         loc_cReff    = TratarNulo(cursor_4c_ProTmp.Reffs, "")
4533:                         loc_cDsCol   = TratarNulo(cursor_4c_ProTmp.ColDescs, "")
4534:                         loc_cClFis   = TratarNulo(cursor_4c_ProTmp.ClFiscals, "")
4535:                     ELSE
4536:                         loc_lProsseguir = .F.
4537:                     ENDIF
4538:                 ENDIF
4539:             ELSE
4540:                 loc_lProsseguir = .F.
4541:             ENDIF
4542: 
4543:             IF loc_lProsseguir
4544:                 *-- Referencia do fornecedor da conta (SigPrFnc sobrepoe a de
4545:                 *-- SigCdPro, como no legado)
4546:                 loc_cSQL = "SELECT Reffs FROM SigPrFnc" + ;
4547:                            " WHERE Cpros = " + EscaparSQL(loc_cPro) + ;
4548:                            " AND Ifors = " + EscaparSQL(THIS.ObterContaFornecedor())
4549: 
4550:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_FProTmp")
4551:                     IF USED("cursor_4c_FProTmp")
4552:                         SELECT cursor_4c_FProTmp
4553:                         GO TOP
4554:                         IF !EOF()
4555:                             loc_cReff = TratarNulo(cursor_4c_FProTmp.Reffs, loc_cReff)
4556:                         ENDIF
4557:                     ENDIF
4558:                 ENDIF
4559: 
4560:                 *-- Saldo do produto no grupo de estoque
4561:                 loc_cSQL = "SELECT e.Sqtds FROM SigCdPro p" + ;
4562:                            " LEFT JOIN SigMvEst e ON e.CPros = p.CPros" + ;
4563:                            " AND e.EmpGruEsts = " + EscaparSQL(THIS.ObterGrupoEstoque()) + ;
4564:                            " WHERE p.CPros = " + EscaparSQL(loc_cPro)
4565: 
4566:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_SaldoTmp")
4567:                     IF USED("cursor_4c_SaldoTmp")
4568:                         SELECT cursor_4c_SaldoTmp
4569:                         GO TOP
4570:                         IF !EOF()
4571:                             loc_nSaldo = TratarNulo(cursor_4c_SaldoTmp.Sqtds, 0)
4572:                         ENDIF
4573:                     ENDIF
4574:                 ENDIF
4575: 
4576:                 *-- Nome do fornecedor do produto
4577:                 SELECT cursor_4c_ProTmp
4578:                 loc_cSQL = "SELECT RClis FROM SigCdCli" + ;
4579:                            " WHERE Iclis = " + ;
4580:                            EscaparSQL(ALLTRIM(TratarNulo(cursor_4c_ProTmp.ifors, "")))
4581: 
4582:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ForTmp")
4583:                     IF USED("cursor_4c_ForTmp")
4584:                         SELECT cursor_4c_ForTmp
4585:                         GO TOP
4586:                         IF !EOF()
4587:                             loc_cNomeFor = TratarNulo(cursor_4c_ForTmp.RClis, "")
4588:                         ENDIF
4589:                     ENDIF
4590:                 ENDIF
4591: 
4592:                 *-- Descricao da classificacao fiscal
4593:                 IF !EMPTY(loc_cClFis)
4594:                     loc_cSQL = "SELECT Descricaos FROM SigCdClf" + ;
4595:                                " WHERE Codigos = " + EscaparSQL(ALLTRIM(loc_cClFis))
4596: 
4597:                     IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ClfTmp")
4598:                         IF USED("cursor_4c_ClfTmp")
4599:                             SELECT cursor_4c_ClfTmp
4600:                             GO TOP
4601:                             IF !EOF()
4602:                                 loc_cDsClFis = TratarNulo(cursor_4c_ClfTmp.Descricaos, "")
4603:                             ENDIF
4604:                         ENDIF
4605:                     ENDIF
4606:                 ENDIF
4607: 
4608:                 *-- Entrega na tela ---------------------------------------
4609:                 SELECT cursor_4c_Itens
4610:                 loc_nResta = IIF(cursor_4c_Itens.qtbaixas = 0, ;
4611:                                  TratarNulo(cursor_4c_Itens.qtds, 0), ;
4612:                                  TratarNulo(cursor_4c_Itens.qtds, 0) - ;
4613:                                  TratarNulo(cursor_4c_Itens.qtbaixas, 0))
4614: 
4615:                 SELECT cursor_4c_ProTmp
4616:                 WITH loc_oPag
4617:                     .txt_4c_PVens.Value   = TratarNulo(cursor_4c_ProTmp.PVens, 0)
4618:                     .txt_4c_Peso.Value    = TratarNulo(cursor_4c_ProTmp.PesoMs, 0)
4619:                     .txt_4c_GVendas.Value = ALLTRIM(TratarNulo(cursor_4c_ProTmp.Colecoes, "")) + ;
4620:                                             IIF(EMPTY(loc_cDsCol), "", ;
4621:                                                 " - " + ALLTRIM(loc_cDsCol))
4622:                     .obj_4c_GetObsPes.Value  = ALLTRIM(TratarNulo(cursor_4c_ProTmp.ObsPes, ""))
4623:                     .obj_4c_GetObsPeds.Value = ALLTRIM(TratarNulo(cursor_4c_ProTmp.ObsPeds, ""))
4624:                     .txt_4c_Conjunts.Value   = ALLTRIM(TratarNulo(cursor_4c_ProTmp.Conjunts, ""))
4625:                     .txt_4c_GerDIfors.Value  = ALLTRIM(loc_cNomeFor)
4626:                     .txt_4c_Saldo.Value      = loc_nSaldo
4627:                     .txt_4c_Qtresta.Value    = loc_nResta
4628:                     .cnt_4c_Reffs.txt_4c_Reffs.Value = ALLTRIM(loc_cReff)
4629:                 ENDWITH
4630: 
4631:                 *-- Rotulo do desconto vira "Acrescimo" quando o valor eh
4632:                 *-- negativo (legado: If crTpmMvItn.ValDescs < 0)
4633:                 SELECT cursor_4c_Itens
4634:                 IF TratarNulo(cursor_4c_Itens.valdescs, 0) < 0
4635:                     loc_oPag.lbl_4c_LblVDescs.Caption = "Valor Acr" + CHR(233) + "scimo"
4636:                     loc_oPag.lbl_4c_LblPDescs.Caption = "%Acr" + CHR(233) + "scimo"
4637:                 ELSE
4638:                     loc_oPag.lbl_4c_LblVDescs.Caption = "Valor Desconto"
4639:                     loc_oPag.lbl_4c_LblPDescs.Caption = "% Desconto"
4640:                 ENDIF
4641: 
4642:                 *-- Painel fiscal: os dois campos que nao sao coluna do item
4643:                 WITH loc_oFis
4644:                     .txt_4c_FClFis.Value = ALLTRIM(loc_cClFis)
4645:                     .txt_4c_FDlFis.Value = ALLTRIM(loc_cDsClFis)
4646:                 ENDWITH
4647:             ELSE
4648:                 THIS.LimparPainelProduto()

*-- Linhas 4664 a 4700:
4664:     ENDPROC
4665: 
4666:     *==========================================================================
4667:     * ExecutarConsultaPainel - SQLEXEC das consultas de EXIBICAO do painel.
4668:     * Nenhuma delas alimenta grade, entao o alias pode ser fechado e recriado
4669:     * sem risco - o guard testa o BUFFERING antes do TABLEREVERT (regra #52).
4670:     * Falha de consulta nao interrompe o preenchimento: o legado segue com o
4671:     * campo em branco nos mesmos casos.
4672:     *==========================================================================
4673:     PROTECTED FUNCTION ExecutarConsultaPainel(par_cSQL, par_cCursor)
4674:         LOCAL loc_nResultado, loc_lOk
4675: 
4676:         loc_lOk = .F.
4677: 
4678:         IF USED(par_cCursor)
4679:             IF CURSORGETPROP("Buffering", par_cCursor) > 1
4680:                 TABLEREVERT(.T., par_cCursor)
4681:             ENDIF
4682:             USE IN (par_cCursor)
4683:         ENDIF
4684: 
4685:         loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)
4686: 
4687:         IF loc_nResultado >= 0
4688:             loc_lOk = .T.
4689:         ELSE
4690:             THIS.this_cMensagemErro = CapturarErroSQL()
4691:         ENDIF
4692: 
4693:         RETURN loc_lOk
4694:     ENDFUNC
4695: 
4696:     *==========================================================================
4697:     * FecharCursoresPainel - Fecha os cursores auxiliares do painel e devolve a
4698:     * area de trabalho corrente para cursor_4c_Itens, que eh o alias da grade.
4699:     *==========================================================================
4700:     PROTECTED PROCEDURE FecharCursoresPainel()

*-- Linhas 4715 a 4741:
4715:         ENDIF
4716: 
4717:         IF USED("cursor_4c_Itens")
4718:             SELECT cursor_4c_Itens
4719:         ENDIF
4720:     ENDPROC
4721: 
4722:     *==========================================================================
4723:     * LimparPainelProduto - Ramo ELSE do fwGrade.AfterRowColChange do legado:
4724:     * linha sem produto deixa o painel em branco.
4725:     *
4726:     * So zera os campos de EXIBICAO (sem ControlSource). Os que estao ligados a
4727:     * cursor_4c_Itens NAO entram aqui: escrever .Value neles gravaria no
4728:     * cursor, apagando o item - eles ja mostram branco porque a linha esta
4729:     * vazia.
4730:     *==========================================================================
4731:     PROCEDURE LimparPainelProduto()
4732:         LOCAL loc_oPag
4733: 
4734:         loc_oPag = THIS.pgf_4c_Paginas.Page1
4735: 
4736:         WITH loc_oPag
4737:             .txt_4c_PVens.Value      = 0
4738:             .txt_4c_Peso.Value       = 0
4739:             .txt_4c_Saldo.Value      = 0
4740:             .txt_4c_Qtresta.Value    = 0
4741:             .txt_4c_GVendas.Value    = ""

*-- Linhas 4789 a 4833:
4789:     *
4790:     * Chave POSICIONAL: o padding faz parte dela (emps char(3) + grupo char(10)
4791:     * + conta char(10) = 23 = a largura de EmpGruEsts). ALLTRIM nas partes
4792:     * encurtaria a chave e o SELECT devolveria ZERO linha em silencio
4793:     * (regra #42) - por isso PADR explicito em cada parte.
4794:     *==========================================================================
4795:     PROTECTED FUNCTION ObterGrupoEstoque()
4796:         RETURN PADR(THIS.this_cEmps, 3) + ;
4797:                PADR(THIS.this_cGrupoos, 10) + ;
4798:                PADR(THIS.this_cContaos, 10)
4799:     ENDFUNC
4800: 
4801:     *==========================================================================
4802:     * BtnBuscarClick - Procura na grade (getBusca do legado, bloco "Procurar"
4803:     * de Page1). NAO eh picker: ele POSICIONA a grade na linha cujo codigo de
4804:     * barras (obj_4c_Opt_Busca = 1) ou cujo produto (= 2) casa com o digitado.
4805:     *
4806:     * Legado (getBusca.Valid + getBusca.LostFocus):
4807:     *   lnOptBusca = This.parent.Opt_Busca.Value
4808:     *   ThisForm.lProcuraCB = .T.
4809:     *   If Not Empty(This.Value)
4810:     *       If lnOptBusca = 1
4811:     *           Select RecNo() As nRecNo From crTpmMvItn
4812:     *               Where CodBarras = Int(Val(lnCBars)) Into Cursor csProcura
4813:     *       Else
4814:     *           Select RecNo() As nRecNo From crTpmMvItn
4815:     *               Where Cpros = lcCpros Into Cursor csProcura
4816:     *       Endif
4817:     *       Select csProcura / Goto Top
4818:     *       If Not Eof() / Select crTpmMvItn / Goto csProcura.nRecNo / Endif
4819:     *   Endif
4820:     *   (LostFocus) This.Value = [] / se lProcuraCB, foco na coluna Produto
4821:     *
4822:     * Ligado ao LostFocus do campo porque no legado a procura mora no Valid,
4823:     * isto eh: dispara ao SAIR do campo (regra #47).
4824:     *
4825:     * PUBLIC: alvo de BINDEVENT e do harness de teste.
4826:     *==========================================================================
4827:     PROCEDURE BtnBuscarClick()
4828:         LOCAL loc_oPag, loc_cDigitado, loc_nOpcao, loc_nBarra, loc_nRecno
4829:         LOCAL loc_oErro
4830: 
4831:         loc_oPag     = THIS.pgf_4c_Paginas.Page1
4832:         loc_cDigitado = ALLTRIM(loc_oPag.txt_4c_Busca.Value)
4833:         loc_nOpcao    = loc_oPag.obj_4c_Opt_Busca.Value

*-- Linhas 4841 a 4905:
4841:         loc_nRecno           = 0
4842: 
4843:         TRY
4844:             SELECT cursor_4c_Itens
4845: 
4846:             IF loc_nOpcao = 1
4847:                 loc_nBarra = INT(VAL(loc_cDigitado))
4848:                 LOCATE FOR cursor_4c_Itens.codbarras = loc_nBarra
4849:             ELSE
4850:                 LOCATE FOR ALLTRIM(cursor_4c_Itens.cpros) == loc_cDigitado
4851:             ENDIF
4852: 
4853:             IF FOUND()
4854:                 loc_nRecno = RECNO("cursor_4c_Itens")
4855:             ENDIF
4856: 
4857:         CATCH TO loc_oErro
4858:             MsgErro("Erro ao procurar na grade:" + CHR(13) + loc_oErro.Message + ;
4859:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4860:                     "Proc: " + loc_oErro.Procedure, "Erro BtnBuscarClick")
4861:         ENDTRY
4862: 
4863:         *-- LostFocus do legado: limpa o campo de procura sempre
4864:         loc_oPag.txt_4c_Busca.Value = ""
4865: 
4866:         IF loc_nRecno > 0
4867:             SELECT cursor_4c_Itens
4868:             GO loc_nRecno
4869:             THIS.AtualizarPainelProduto()
4870:             THIS.RepintarGradeItens()
4871:             SELECT cursor_4c_Itens
4872:             GO loc_nRecno
4873:             THIS.grd_4c_Dados.Refresh()
4874:         ELSE
4875:             MsgAviso("Item n" + CHR(227) + "o encontrado na grade.", "Procurar")
4876:         ENDIF
4877: 
4878:         THIS.this_lProcuraCB = .F.
4879: 
4880:         RETURN (loc_nRecno > 0)
4881:     ENDPROC
4882: 
4883:     *==========================================================================
4884:     * TxtProdLostFocus - Conferencia por codigo (get_prod do legado).
4885:     *
4886:     * O legado resolve o valor digitado nesta ordem (get_prod.Valid):
4887:     *   1. codigo de barras que JA esta numa linha da grade (Seek em
4888:     *      crTpmMvItn por codbarras) - marca ThisForm.Barra e usa o produto
4889:     *      daquela linha;
4890:     *   2. etiqueta individual em SigOpEtq (com LEFT JOIN em SigOpEta para
4891:     *      aceitar a barra antiga de uma etiqueta reemitida);
4892:     *   3. SigCdPro.Cbars (codigo de barras do cadastro);
4893:     *   4. SigCdPro.Ean13;
4894:     *   5. o proprio valor como CPros.
4895:     * Em qualquer caminho, achando o produto ele confere a unidade: se
4896:     * SigCdUni.etiqs = 'S' recusa com "Codigo Errado - Etiqueta Especial !!".
4897:     * Nao achando, avisa "Produto Nao Cadastrado!!!".
4898:     *
4899:     * fVerificarBarras() (SIGFUNCS.PRG) NAO foi portada. No legado ela apenas
4900:     * ESCOLHE entre o ramo de barras e o ramo de EAN13 - e os dois ramos
4901:     * terminam na mesma consulta a SigCdPro - entao tentar as duas resolucoes
4902:     * em sequencia produz o mesmo resultado sem o wrapper (mesma decisao
4903:     * documentada em FormSigPrEtq, regra #27 "no-op documentado").
4904:     *
4905:     * PUBLIC: alvo de BINDEVENT e do harness de teste.

*-- Linhas 4960 a 4978:
4960: 
4961:         *-- 1. Barra que ja esta numa linha da grade -----------------------
4962:         IF loc_nBarra <> 0 AND USED("cursor_4c_Itens")
4963:             SELECT cursor_4c_Itens
4964:             loc_nRecno = RECNO()
4965:             LOCATE FOR cursor_4c_Itens.codbarras = loc_nBarra
4966:             IF FOUND()
4967:                 THIS.this_nBarra = loc_nBarra
4968:                 loc_cProduto     = ALLTRIM(cursor_4c_Itens.cpros)
4969:             ELSE
4970:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
4971:                     GO loc_nRecno
4972:                 ENDIF
4973:             ENDIF
4974:         ENDIF
4975: 
4976:         IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
4977:             IF EMPTY(loc_cProduto)
4978:                 MsgAviso("Conex" + CHR(227) + "o com o banco n" + CHR(227) + ;

*-- Linhas 4984 a 5071:
4984:         TRY
4985:             *-- 2. Etiqueta individual (SigOpEtq + SigOpEta) ---------------
4986:             IF EMPTY(loc_cProduto) AND loc_nBarra <> 0
4987:                 loc_cSQL = "SELECT a.CPros, a.CBars, a.CodTams, a.Contas" + ;
4988:                            " FROM SigOpEtq a" + ;
4989:                            " LEFT JOIN SigOpEta b ON a.cpros = b.cpros" + ;
4990:                            " AND a.cbars = b.cbars_new" + ;
4991:                            " WHERE (a.CBars = " + FormatarNumeroSQL(loc_nBarra, 0) + ;
4992:                            " OR b.cbars_old = " + FormatarNumeroSQL(loc_nBarra, 0) + ")"
4993: 
4994:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_EtqTmp")
4995:                     IF USED("cursor_4c_EtqTmp")
4996:                         SELECT cursor_4c_EtqTmp
4997:                         GO TOP
4998:                         IF !EOF()
4999:                             THIS.this_nBarra = loc_nBarra
5000:                             loc_cProduto     = ALLTRIM(TratarNulo(cursor_4c_EtqTmp.CPros, ""))
5001:                         ENDIF
5002:                         USE IN cursor_4c_EtqTmp
5003:                     ENDIF
5004:                 ENDIF
5005:             ENDIF
5006: 
5007:             *-- 3. Codigo de barras do cadastro (SigCdPro.Cbars) -----------
5008:             IF EMPTY(loc_cProduto) AND loc_nBarra <> 0
5009:                 loc_cSQL = "SELECT Cpros FROM SigCdPro" + ;
5010:                            " WHERE Cbars = " + FormatarNumeroSQL(loc_nBarra, 0)
5011: 
5012:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_BarTmp")
5013:                     IF USED("cursor_4c_BarTmp")
5014:                         SELECT cursor_4c_BarTmp
5015:                         GO TOP
5016:                         IF !EOF()
5017:                             THIS.this_nBarra = loc_nBarra
5018:                             loc_cProduto     = ALLTRIM(TratarNulo(cursor_4c_BarTmp.Cpros, ""))
5019:                         ENDIF
5020:                         USE IN cursor_4c_BarTmp
5021:                     ENDIF
5022:                 ENDIF
5023:             ENDIF
5024: 
5025:             *-- 4. EAN13 do cadastro (SigCdPro.Ean13) ----------------------
5026:             IF EMPTY(loc_cProduto) AND loc_nBarra <> 0
5027:                 loc_cSQL = "SELECT Cpros FROM SigCdPro" + ;
5028:                            " WHERE Ean13 = " + FormatarNumeroSQL(loc_nBarra, 0)
5029: 
5030:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_EanTmp")
5031:                     IF USED("cursor_4c_EanTmp")
5032:                         SELECT cursor_4c_EanTmp
5033:                         GO TOP
5034:                         IF !EOF()
5035:                             THIS.this_nBarra = loc_nBarra
5036:                             loc_cProduto     = ALLTRIM(TratarNulo(cursor_4c_EanTmp.Cpros, ""))
5037:                         ENDIF
5038:                         USE IN cursor_4c_EanTmp
5039:                     ENDIF
5040:                 ENDIF
5041:             ENDIF
5042: 
5043:             *-- 5. O proprio valor como CPros ------------------------------
5044:             IF EMPTY(loc_cProduto)
5045:                 loc_cProduto = par_cDigitado
5046:             ENDIF
5047: 
5048:             *-- Confere o cadastro do produto e a unidade ------------------
5049:             loc_cSQL = "SELECT a.Cpros, a.Cunis, b.etiqs" + ;
5050:                        " FROM SigCdPro a" + ;
5051:                        " LEFT JOIN SigCdUni b ON a.Cunis = b.Cunis" + ;
5052:                        " WHERE a.Cpros = " + EscaparSQL(loc_cProduto)
5053: 
5054:             IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ProdTmp")
5055:                 IF USED("cursor_4c_ProdTmp")
5056:                     SELECT cursor_4c_ProdTmp
5057:                     GO TOP
5058:                     IF EOF()
5059:                         MsgAviso("Produto N" + CHR(227) + "o Cadastrado!!! " + ;
5060:                                  CHR(13) + loc_cProduto, ;
5061:                                  "Aten" + CHR(231) + CHR(227) + "o!!!")
5062:                         loc_cProduto = ""
5063:                     ELSE
5064:                         loc_cUnidade = UPPER(ALLTRIM(TratarNulo(cursor_4c_ProdTmp.etiqs, "")))
5065:                         *-- Legado: CrSigCdUni.etiqs = 'S' recusa a digitacao
5066:                         *-- manual porque o produto exige etiqueta especial.
5067:                         IF loc_cUnidade == "S"
5068:                             MsgAviso("C" + CHR(243) + "digo Errado - Etiqueta Especial !!", ;
5069:                                      "Aten" + CHR(231) + CHR(227) + "o!!!")
5070:                             loc_cProduto = ""
5071:                         ELSE

*-- Linhas 5087 a 5105:
5087:         ENDTRY
5088: 
5089:         IF USED("cursor_4c_Itens")
5090:             SELECT cursor_4c_Itens
5091:         ENDIF
5092: 
5093:         RETURN loc_cProduto
5094:     ENDFUNC
5095: 
5096:     *==========================================================================
5097:     * CarregarImagemProduto - Foto do produto em img_4c_ImgProds. Legado
5098:     * (get_prod.Valid e fwGrade.AfterRowColChange):
5099:     *
5100:     *   If CrSigCdOpe.Imagems = 1
5101:     *       imgProds.Visible = .F. / imgProds.Picture = ''
5102:     *       If Not Empty(CrTmpPro.FigJpgs) And Not Isnull(CrTmpPro.FigJpgs)
5103:     *           lcFoto = Strconv(Strtran(... data:image/...;base64, ...),14)
5104:     *           If (StrToFile(lcFoto, lcArquivo3) > 0)
5105:     *               imgProds.Picture = (lcArquivo3) / imgProds.Visible = .T.

*-- Linhas 5129 a 5152:
5129:         ENDIF
5130: 
5131:         TRY
5132:             loc_cSQL = "SELECT FigJpgs FROM SigCdPro" + ;
5133:                        " WHERE Cpros = " + EscaparSQL(ALLTRIM(par_cProduto))
5134: 
5135:             IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_FigTmp")
5136:                 IF USED("cursor_4c_FigTmp")
5137:                     SELECT cursor_4c_FigTmp
5138:                     GO TOP
5139:                     IF !EOF()
5140:                         loc_cFig = TratarNulo(cursor_4c_FigTmp.FigJpgs, "")
5141: 
5142:                         IF !EMPTY(loc_cFig)
5143:                             loc_cFig = STRTRAN(loc_cFig, "data:image/png;base64,",  "")
5144:                             loc_cFig = STRTRAN(loc_cFig, "data:image/jpeg;base64,", "")
5145:                             loc_cFig = STRTRAN(loc_cFig, "data:image/jpg;base64,",  "")
5146: 
5147:                             loc_cFoto    = STRCONV(loc_cFig, 14)
5148:                             loc_cArquivo = ADDBS(SYS(2023)) + "SigOpPro_" + ;
5149:                                            SYS(2015) + ".jpg"
5150: 
5151:                             IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0
5152:                                 loc_oImg.Picture = loc_cArquivo

*-- Linhas 5166 a 5196:
5166:         ENDTRY
5167: 
5168:         IF USED("cursor_4c_Itens")
5169:             SELECT cursor_4c_Itens
5170:         ENDIF
5171: 
5172:         RETURN loc_oImg.Visible
5173:     ENDPROC
5174: 
5175:     *==========================================================================
5176:     * TxtQtdLostFocus - Confirma a linha conferida (get_qtd.LostFocus do
5177:     * legado). O par Produto+Qtde desta pagina NAO inclui item novo: ele
5178:     * CONFERE um item que ja esta na grade. Legado:
5179:     *
5180:     *   _Prod = Padr(get_prod.Value,14)
5181:     *   Select crTpmMvItn / Set Order To cpros
5182:     *   If Not IsEmpty(This.Value)
5183:     *       If Empty(Barra) / Seek _Prod / ok = .T. / Endif
5184:     *       If Not Eof()
5185:     *           Do While Empty(Barra) And cpros = _Prod And ok And Not Eof()
5186:     *               If qtds = This.Value And iconfs = .F. / ok = .F. / Exit
5187:     *               Skip
5188:     *           Enddo
5189:     *           If ok / Messagebox('Quantidade Errada !!') / limpa campos
5190:     *           Else  / Replace iconfs With .T. / Refresh / limpa / foco grade
5191:     *       Else / Messagebox('Item nao encontrado !!') / limpa campos
5192:     *       Endif
5193:     *       ... Skip -1 / fwgrade.Refresh / get_prod.SetFocus / Barra = 0
5194:     *   Endif
5195:     *
5196:     * PUBLIC: alvo de BINDEVENT e do harness de teste.

*-- Linhas 5222 a 5240:
5222:         loc_nRecnoAchado = 0
5223: 
5224:         TRY
5225:             SELECT cursor_4c_Itens
5226:             SET ORDER TO
5227:             GO TOP
5228: 
5229:             *-- Procura a linha ainda nao conferida cuja quantidade bate.
5230:             *-- Com barra lida (this_nBarra) o legado nao exige casar o
5231:             *-- produto: a barra ja identificou a linha.
5232:             SCAN
5233:                 IF THIS.this_nBarra <> 0
5234:                     IF cursor_4c_Itens.codbarras <> THIS.this_nBarra
5235:                         LOOP
5236:                     ENDIF
5237:                 ELSE
5238:                     IF PADR(cursor_4c_Itens.cpros, 14) <> loc_cProduto
5239:                         LOOP
5240:                     ENDIF

*-- Linhas 5266 a 5284:
5266:             CASE loc_lConfere
5267:                 THIS.RepintarGradeItens()
5268:                 IF loc_nRecnoAchado > 0
5269:                     SELECT cursor_4c_Itens
5270:                     GO loc_nRecnoAchado
5271:                 ENDIF
5272:                 THIS.AtualizarPainelProduto()
5273:             CASE loc_lAchouLinha
5274:                 MsgAviso("Quantidade Errada !!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5275:             OTHERWISE
5276:                 MsgAviso("Item n" + CHR(227) + "o encontrado !!", ;
5277:                          "Aten" + CHR(231) + CHR(227) + "o!!!")
5278:         ENDCASE
5279: 
5280:         *-- Em TODOS os caminhos o legado limpa os dois campos e devolve o
5281:         *-- foco ao codigo, pronto para a leitura seguinte.
5282:         THIS.this_nBarra            = 0
5283:         THIS.this_lEmLookup         = .F.
5284: 

*-- Linhas 5294 a 5312:
5294:     * abre fwbuscaext sobre SigCdCor por 'Cods'). Aqui o browse eh o
5295:     * FormBuscaAuxiliar via AbrirLookupCanonico (padrao canonico do projeto).
5296:     *
5297:     * O valor escolhido volta para o proprio TextBox, que tem ControlSource em
5298:     * cursor_4c_Itens.codcors - entao ele grava na linha corrente, igual ao
5299:     * "This.Value = crListaRemota.Cods" do legado.
5300:     *
5301:     * PUBLIC: alvo de BINDEVENT.
5302:     *==========================================================================
5303:     PROCEDURE ValidarCodCorLostFocus()
5304:         LOCAL loc_oPag, loc_cValor
5305: 
5306:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
5307:         loc_cValor = ALLTRIM(TRANSFORM(loc_oPag.txt_4c_CodCors.Value))
5308: 
5309:         *-- Legado: "If !Empty(lcCodCors)" - vazio nao abre browse nenhum
5310:         IF EMPTY(loc_cValor)
5311:             RETURN .F.
5312:         ENDIF

*-- Linhas 5382 a 5400:
5382:     *    fica so com EditDocs = 5 - mesmo comportamento aqui.
5383:     *
5384:     * 2. PREENCHIDO e crSigCdOpe.ValiNotas = 1: o documento tem de ser UNICO.
5385:     *    a) "Select Emps, Dopes, Numes From SigMvItn Where Notas = '<valor>'" -
5386:     *       achando o MESMO Dopes em OUTRA movimentacao (emps+dopes+numes
5387:     *       diferente da corrente), recusa com "Documento ... Ja Existe !!";
5388:     *    b) nao achando, conta no cursor local quantas linhas usam o mesmo
5389:     *       documento - mais de uma recusa com "Documento ... Ja Lancado Nessa
5390:     *       Operacao !!".
5391:     *
5392:     * 3. crSigOpCdc.OpVlUnis = 1 com produto 'C': o valor unitario do item vem
5393:     *    do documento informado ("Replace Units With LocalEest.valos,
5394:     *    Utilizas With 51"). A acumulacao das parcelas do legado grava no
5395:     *    cursor xPar, que pertence ao form PAI: so roda quando o pai o
5396:     *    entregou (USED("xPar")).
5397:     *
5398:     * O legado tambem normaliza o valor com Transf(Val(This.Value),"@L 999999")
5399:     * - documento eh char(6) com zeros a esquerda.
5400:     *

*-- Linhas 5444 a 5488:
5444: 
5445:         TRY
5446:             *-- 2a. Mesmo documento em OUTRA movimentacao da mesma operacao
5447:             loc_cSQL = "SELECT Emps, Dopes, Numes, empdopnums FROM SigMvItn" + ;
5448:                        " WHERE Notas = " + EscaparSQL(loc_cNotas) + ;
5449:                        " AND Dopes = " + EscaparSQL(PADR(THIS.this_cDopes, 20))
5450: 
5451:             IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_NotaTmp")
5452:                 IF USED("cursor_4c_NotaTmp")
5453:                     SELECT cursor_4c_NotaTmp
5454:                     SCAN
5455:                         IF ALLTRIM(TratarNulo(cursor_4c_NotaTmp.empdopnums, "")) <> ;
5456:                            ALLTRIM(loc_cChave)
5457:                             MsgAviso("Documento " + ALLTRIM(THIS.this_cDopes) + " " + ;
5458:                                      loc_cNotas + " J" + CHR(225) + " Existe !!", ;
5459:                                      "Opera" + CHR(231) + CHR(227) + "o: " + ;
5460:                                      ALLTRIM(TratarNulo(cursor_4c_NotaTmp.Emps, "")) + "-" + ;
5461:                                      ALLTRIM(TratarNulo(cursor_4c_NotaTmp.Dopes, "")) + "-" + ;
5462:                                      ALLTRIM(STR(TratarNulo(cursor_4c_NotaTmp.Numes, 0))))
5463:                             loc_lOk = .F.
5464:                             EXIT
5465:                         ENDIF
5466:                     ENDSCAN
5467:                     USE IN cursor_4c_NotaTmp
5468:                 ENDIF
5469:             ENDIF
5470: 
5471:             *-- 2b. Mesmo documento repetido DENTRO desta operacao
5472:             IF loc_lOk
5473:                 SELECT cursor_4c_Itens
5474:                 loc_nRecno = RECNO()
5475:                 COUNT FOR ALLTRIM(cursor_4c_Itens.notas) == loc_cNotas TO loc_nIguais
5476:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
5477:                     GO loc_nRecno
5478:                 ENDIF
5479: 
5480:                 IF loc_nIguais > 1
5481:                     MsgAviso("Documento " + ALLTRIM(THIS.this_cDopes) + " " + loc_cNotas + ;
5482:                              " J" + CHR(225) + " Lan" + CHR(231) + "ado Nessa Opera" + ;
5483:                              CHR(231) + CHR(227) + "o !!", ;
5484:                              "Opera" + CHR(231) + CHR(227) + "o: " + ALLTRIM(THIS.this_cDopes))
5485:                     loc_lOk = .F.
5486:                 ENDIF
5487:             ENDIF
5488: 

*-- Linhas 5501 a 5633:
5501:         ENDTRY
5502: 
5503:         IF USED("cursor_4c_Itens")
5504:             SELECT cursor_4c_Itens
5505:         ENDIF
5506: 
5507:         RETURN loc_lOk
5508:     ENDPROC
5509: 
5510:     *==========================================================================
5511:     * AplicarValorDoDocumento - Ramo "crSigOpCdc.OpVlUnis = 1" do
5512:     * getDocs.Valid: o valor unitario do item 'C' vem do documento informado.
5513:     *
5514:     * Legado:
5515:     *   lcSql = [Select a.Valos, a.Datas, a.EmpDopNums From SigMvCab a,
5516:     *            SigCdOpe b, SigCdTom c Where a.Dopes = b.Dopes And
5517:     *            b.TipoOps = c.Codigos And c.OpVlUnis = 1 And a.Numes = <n>
5518:     *            Order by A.Datas]
5519:     *   Select LocalEest / Go Bott
5520:     *   If Reccount() > 0
5521:     *       Replace Units With LocalEest.valos, Utilizas With 51 in crTpmMvItn
5522:     *       If crSigCdOpe.parcs = 1 ... soma SigMvPar em xPar ... Replace Units
5523:     *   ThisForm.Calc_ValIte()
5524:     *
5525:     * Utilizas = 51 eh a marca do legado para "preco travado pelo documento":
5526:     * os guards de When de getVDescs/getPDescs e da coluna Valor testam
5527:     * justamente esse valor.
5528:     *
5529:     * A acumulacao das parcelas grava no cursor xPar, que eh do form PAI; ela
5530:     * so roda quando o pai entregou esse cursor.
5531:     *==========================================================================
5532:     PROTECTED PROCEDURE AplicarValorDoDocumento(par_nNumero)
5533:         LOCAL loc_cSQL, loc_nValor, loc_cEdn, loc_nTotPar, loc_lAplicou
5534: 
5535:         loc_lAplicou = .F.
5536: 
5537:         IF VARTYPE(par_nNumero) <> "N" OR par_nNumero = 0
5538:             RETURN .F.
5539:         ENDIF
5540: 
5541:         loc_cSQL = "SELECT a.Valos, a.Datas, a.EmpDopNums" + ;
5542:                    " FROM SigMvCab a, SigCdOpe b, SigCdTom c" + ;
5543:                    " WHERE a.Dopes = b.Dopes" + ;
5544:                    " AND b.TipoOps = c.Codigos" + ;
5545:                    " AND c.OpVlUnis = 1" + ;
5546:                    " AND a.Numes = " + FormatarNumeroSQL(par_nNumero, 0) + ;
5547:                    " ORDER BY a.Datas"
5548: 
5549:         IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_DocValTmp")
5550:             IF USED("cursor_4c_DocValTmp")
5551:                 SELECT cursor_4c_DocValTmp
5552:                 GO BOTTOM
5553:                 IF RECCOUNT("cursor_4c_DocValTmp") > 0
5554:                     loc_nValor = TratarNulo(cursor_4c_DocValTmp.Valos, 0)
5555:                     loc_cEdn   = ALLTRIM(TratarNulo(cursor_4c_DocValTmp.EmpDopNums, ""))
5556: 
5557:                     SELECT cursor_4c_Itens
5558:                     REPLACE units    WITH loc_nValor, ;
5559:                             utilizas WITH 51 IN cursor_4c_Itens
5560: 
5561:                     *-- Parcelas: o cursor de destino (xPar) pertence ao form
5562:                     *-- PAI; sem ele entregue, o legado tambem nao soma nada.
5563:                     IF THIS.this_nParcs = 1 AND USED("xPar") AND !EMPTY(loc_cEdn)
5564:                         loc_cSQL = "SELECT Valos FROM SigMvPar" + ;
5565:                                    " WHERE EmpdopNums = " + EscaparSQL(loc_cEdn) + ;
5566:                                    " AND fPags = " + EscaparSQL("P")
5567: 
5568:                         IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ParTmp")
5569:                             loc_nTotPar = 0
5570:                             IF USED("cursor_4c_ParTmp")
5571:                                 SELECT cursor_4c_ParTmp
5572:                                 SCAN
5573:                                     SELECT xPar
5574:                                     APPEND BLANK
5575:                                     REPLACE Valos WITH TratarNulo(cursor_4c_ParTmp.Valos, 0) IN xPar
5576:                                     loc_nTotPar = loc_nTotPar + TratarNulo(cursor_4c_ParTmp.Valos, 0)
5577:                                     SELECT cursor_4c_ParTmp
5578:                                 ENDSCAN
5579:                                 USE IN cursor_4c_ParTmp
5580:                             ENDIF
5581: 
5582:                             SELECT cursor_4c_Itens
5583:                             REPLACE units WITH loc_nTotPar IN cursor_4c_Itens
5584:                         ENDIF
5585:                     ENDIF
5586: 
5587:                     loc_lAplicou = .T.
5588:                 ENDIF
5589:                 IF USED("cursor_4c_DocValTmp")
5590:                     USE IN cursor_4c_DocValTmp
5591:                 ENDIF
5592:             ENDIF
5593:         ENDIF
5594: 
5595:         IF loc_lAplicou
5596:             THIS.TotalizarLinha(.F.)
5597:         ENDIF
5598: 
5599:         IF USED("cursor_4c_Itens")
5600:             SELECT cursor_4c_Itens
5601:         ENDIF
5602: 
5603:         RETURN loc_lAplicou
5604:     ENDPROC
5605: 
5606:     *==========================================================================
5607:     * ValidarLotesLostFocus - Numero do lote (getLotes.Valid do legado).
5608:     *
5609:     * O numero digitado eh COMPOSTO: os 4 primeiros digitos sao o nDopes da
5610:     * operacao que gerou o lote e os 6 ultimos o numero da movimentacao.
5611:     * Legado:
5612:     *
5613:     *   ndope = Val( Left( Str( This.Value, 10 ), 4) )
5614:     *   Cursorquery('SigCdOpe','crSigCdOpe','nDopes',ndope) / Dope = Dopes
5615:     *   If crSigCdOpe.Ctrllotes # 1
5616:     *       Messagebox('Operacao '+Dope+' nao Configurada para gerar No. Lote !!')
5617:     *   Nume = Val( Right( Str( This.Value, 10), 6 ) )
5618:     *   Select EmpDopNums from SigMvCab Where Numes = <Nume> And Dopes = '<Dope>'
5619:     *   If ... Reccount = 0 / Messagebox('Lote N '+...+' nao Existe !!')
5620:     *
5621:     * O "set decimals to 0" do legado existe para o STR nao trazer casas
5622:     * decimais; aqui o INT() sobre o valor digitado faz o mesmo sem mexer num
5623:     * SET global.
5624:     *
5625:     * PUBLIC: alvo de BINDEVENT.
5626:     *==========================================================================
5627:     PROCEDURE ValidarLotesLostFocus()
5628:         LOCAL loc_oPag, loc_nLote, loc_cLote, loc_nDope, loc_nNume
5629:         LOCAL loc_cDope, loc_nCtrl, loc_cSQL, loc_lOk, loc_oErro
5630: 
5631:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5632:         loc_lOk  = .T.
5633: 

*-- Linhas 5653 a 5696:
5653:         loc_nCtrl = 0
5654: 
5655:         TRY
5656:             loc_cSQL = "SELECT Dopes, Ctrllotes FROM SigCdOpe" + ;
5657:                        " WHERE nDopes = " + FormatarNumeroSQL(loc_nDope, 0)
5658: 
5659:             IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_OpeLoteTmp")
5660:                 IF USED("cursor_4c_OpeLoteTmp")
5661:                     SELECT cursor_4c_OpeLoteTmp
5662:                     GO TOP
5663:                     IF !EOF()
5664:                         loc_cDope = ALLTRIM(TratarNulo(cursor_4c_OpeLoteTmp.Dopes, ""))
5665:                         loc_nCtrl = TratarNulo(cursor_4c_OpeLoteTmp.Ctrllotes, 0)
5666:                     ENDIF
5667:                     USE IN cursor_4c_OpeLoteTmp
5668:                 ENDIF
5669:             ENDIF
5670: 
5671:             IF loc_nCtrl <> 1
5672:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o " + loc_cDope + ;
5673:                          " n" + CHR(227) + "o Configurada para gerar No. Lote !!", ;
5674:                          "Aten" + CHR(231) + CHR(227) + "o!!!")
5675:                 loc_lOk = .F.
5676:             ENDIF
5677: 
5678:             IF loc_lOk
5679:                 loc_cSQL = "SELECT EmpDopNums FROM SigMvCab" + ;
5680:                            " WHERE Numes = " + FormatarNumeroSQL(loc_nNume, 0) + ;
5681:                            " AND Dopes = " + EscaparSQL(PADR(loc_cDope, 20))
5682: 
5683:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_LoteTmp")
5684:                     IF !USED("cursor_4c_LoteTmp") OR RECCOUNT("cursor_4c_LoteTmp") = 0
5685:                         MsgAviso("Lote N" + CHR(186) + " " + ALLTRIM(loc_cLote) + ;
5686:                                  " n" + CHR(227) + "o Existe !!", ;
5687:                                  "Aten" + CHR(231) + CHR(227) + "o!!!")
5688:                         loc_lOk = .F.
5689:                     ENDIF
5690:                     IF USED("cursor_4c_LoteTmp")
5691:                         USE IN cursor_4c_LoteTmp
5692:                     ENDIF
5693:                 ELSE
5694:                     MsgAviso("Lote N" + CHR(186) + " " + ALLTRIM(loc_cLote) + ;
5695:                              " n" + CHR(227) + "o Existe !!", ;
5696:                              "Aten" + CHR(231) + CHR(227) + "o!!!")

*-- Linhas 5707 a 5725:
5707:         ENDTRY
5708: 
5709:         IF USED("cursor_4c_Itens")
5710:             SELECT cursor_4c_Itens
5711:         ENDIF
5712: 
5713:         RETURN loc_lOk
5714:     ENDPROC
5715: 
5716:     PROCEDURE ValidarVDescsLostFocus()
5717:         LOCAL loc_oPag, loc_nValor, loc_nOrig, loc_oErro
5718: 
5719:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5720: 
5721:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
5722:             RETURN .F.
5723:         ENDIF
5724: 
5725:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")

*-- Linhas 5733 a 5751:
5733:         ENDIF
5734: 
5735:         TRY
5736:             SELECT cursor_4c_Itens
5737:             loc_nOrig = TratarNulo(cursor_4c_Itens.unitorigs, 0)
5738: 
5739:             IF loc_nOrig = 0
5740:                 loc_nOrig = TratarNulo(cursor_4c_Itens.units, 0)
5741:                 REPLACE unitorigs WITH loc_nOrig IN cursor_4c_Itens
5742:             ENDIF
5743: 
5744:             IF loc_nValor > 0
5745:                 REPLACE units WITH loc_nOrig - loc_nValor IN cursor_4c_Itens
5746:             ELSE
5747:                 REPLACE units WITH loc_nOrig + loc_nValor IN cursor_4c_Itens
5748:             ENDIF
5749: 
5750:         CATCH TO loc_oErro
5751:             MsgErro("Erro ao aplicar o desconto:" + CHR(13) + loc_oErro.Message + ;

*-- Linhas 5791 a 5809:
5791:         ENDIF
5792: 
5793:         TRY
5794:             SELECT cursor_4c_Itens
5795:             loc_nOrig = TratarNulo(cursor_4c_Itens.unitorigs, 0)
5796: 
5797:             IF loc_nOrig = 0
5798:                 loc_nOrig = TratarNulo(cursor_4c_Itens.units, 0)
5799:                 REPLACE unitorigs WITH loc_nOrig IN cursor_4c_Itens
5800:             ENDIF
5801: 
5802:             IF loc_nPerc > 0
5803:                 REPLACE units WITH loc_nOrig - ((ABS(loc_nPerc) * loc_nOrig) / 100) ;
5804:                         IN cursor_4c_Itens
5805:             ELSE
5806:                 REPLACE units WITH loc_nOrig + ((ABS(loc_nPerc) * loc_nOrig) / 100) ;
5807:                         IN cursor_4c_Itens
5808:             ENDIF
5809: 

*-- Linhas 6055 a 6073:
6055:     * campos de conferencia e de procura (que nao sao coluna do item) e manda
6056:     * o painel de exibicao para o branco.
6057:     *
6058:     * NAO toca nos campos com ControlSource: escrever .Value neles gravaria no
6059:     * cursor e APAGARIA o item da linha corrente. Quem limpa a LINHA eh
6060:     * LimparLinhaGrade().
6061:     *==========================================================================
6062:     PROTECTED PROCEDURE LimparCampos()
6063:         LOCAL loc_oPag
6064: 
6065:         loc_oPag = THIS.pgf_4c_Paginas.Page1
6066: 
6067:         WITH loc_oPag
6068:             .txt_4c__prod.Value  = ""
6069:             .txt_4c__qtd.Value   = 0
6070:             .txt_4c_Busca.Value  = ""
6071:             .obj_4c_Opt_Busca.Value = 1
6072:             .cnt_4c_Obs.Visible  = .F.
6073:         ENDWITH

*-- Linhas 6109 a 6129:
6109:     * sigopproBO, cobrindo TODAS as colunas de SigMvItn que o cursor carrega.
6110:     *
6111:     * O painel de Page1/Page3 eh uma VISTA da linha: os campos digitaveis tem
6112:     * ControlSource sobre cursor_4c_Itens, logo o que o usuario digitou ja esta
6113:     * no cursor quando este metodo roda - ler do cursor eh ler da tela, e eh
6114:     * tambem o que o legado faz (ele grava o cursor inteiro com TABLEUPDATE).
6115:     *
6116:     * Os campos de EXIBICAO (preco atual, saldo, resta, referencia, grupo de
6117:     * venda, peso medio, classificacao fiscal) NAO entram: nao sao coluna de
6118:     * SigMvItn - vem de SigCdPro/SigMvEst/SigCdClf e seriam gravados em
6119:     * coluna que nao existe.
6120:     *
6121:     * Devolve .T. quando havia linha para transferir.
6122:     *==========================================================================
6123:     PROTECTED FUNCTION FormParaBO()
6124:         LOCAL loc_lOk, loc_oBO, loc_oErro
6125: 
6126:         loc_lOk = .F.
6127: 
6128:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
6129:             RETURN .F.

*-- Linhas 6140 a 6158:
6140:             *-- uma a uma, com TratarNulo e com o teste de VARTYPE nos campos
6141:             *-- bit. Reescrever a lista aqui criaria duas versoes do mesmo
6142:             *-- mapeamento, que divergem na primeira coluna nova.
6143:             SELECT cursor_4c_Itens
6144:             loc_lOk = loc_oBO.CarregarDoCursor("cursor_4c_Itens")
6145: 
6146:             IF loc_lOk
6147:                 *-- Identificacao da movimentacao: no legado vem de TprMvCab
6148:                 *-- (cursor do form pai) e nao da linha do item.
6149:                 loc_oBO.this_cEmpdopnums = THIS.ObterChaveMovimentacao()
6150: 
6151:                 IF EMPTY(loc_oBO.this_cEmps)
6152:                     loc_oBO.this_cEmps = PADR(THIS.this_cEmps, 3)
6153:                 ENDIF
6154:                 IF EMPTY(loc_oBO.this_cDopes)
6155:                     loc_oBO.this_cDopes = PADR(THIS.this_cDopes, 20)
6156:                 ENDIF
6157:                 IF loc_oBO.this_nNumes = 0
6158:                     loc_oBO.this_nNumes = THIS.this_nNumes

*-- Linhas 6179 a 6197:
6179:     *==========================================================================
6180:     * BOParaForm - Caminho inverso de FormParaBO: leva as properties do
6181:     * sigopproBO para a linha da grade e, por consequencia, para o painel de
6182:     * Page1/Page3 (que esta ligado ao cursor por ControlSource).
6183:     *
6184:     * Posiciona PRIMEIRO na linha do item que esta no BO (citens): sem isso a
6185:     * gravacao cairia na linha errada e sobrescreveria outro item - o cursor
6186:     * nao acompanha o BO sozinho.
6187:     *
6188:     * Fecha atualizando o painel de exibicao e repintando a grade: popular o
6189:     * cursor NAO repinta a grade (regra #21).
6190:     *==========================================================================
6191:     PROTECTED PROCEDURE BOParaForm()
6192:         LOCAL loc_oBO, loc_lOk, loc_oErro
6193: 
6194:         loc_lOk = .F.
6195: 
6196:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
6197:             RETURN .F.

*-- Linhas 6204 a 6222:
6204:         loc_oBO = THIS.this_oBusinessObject
6205: 
6206:         TRY
6207:             SELECT cursor_4c_Itens
6208: 
6209:             *-- Casa a linha pelo numero do item; sem numero, usa a corrente.
6210:             IF loc_oBO.this_nCitens <> 0
6211:                 LOCATE FOR cursor_4c_Itens.citens = loc_oBO.this_nCitens
6212:                 IF !FOUND()
6213:                     GO TOP
6214:                 ENDIF
6215:             ENDIF
6216: 
6217:             IF !EOF("cursor_4c_Itens")
6218:                 REPLACE cidchaves  WITH loc_oBO.this_cCidchaves, ;
6219:                         citens     WITH loc_oBO.this_nCitens, ;
6220:                         citem2     WITH loc_oBO.this_nCitem2, ;
6221:                         cpros      WITH loc_oBO.this_cCpros, ;
6222:                         cpro2s     WITH loc_oBO.this_cCpro2s, ;

*-- Linhas 6368 a 6386:
6368: 
6369:         IF loc_lOk
6370:             *-- Popular o cursor NAO repinta a grade nem os campos ligados a
6371:             *-- ele por ControlSource (regra #21): o Refresh das paginas eh o
6372:             *-- que faz o painel mostrar o que acabou de ser gravado na linha.
6373:             THIS.RepintarGradeItens()
6374:             THIS.pgf_4c_Paginas.Page1.Refresh()
6375:             THIS.pgf_4c_Paginas.Page3.Refresh()
6376:             THIS.AtualizarPainelProduto()
6377:         ENDIF
6378: 
6379:         RETURN loc_lOk
6380:     ENDPROC
6381: 
6382:     *==========================================================================
6383:     * BtnCancelarClick - Caminho de ESC/Cancelar da tela.
6384:     *
6385:     * No SCX legado o botao de saida eh OK.btnSair, Caption "Retornar", com
6386:     * Command1.Cancel = .T. - isto eh: Encerrar e Cancelar sao o MESMO botao,


### BO (C:\4c\projeto\app\classes\sigopproBO.prg):
*====================================================================
* sigopproBO.prg
*
* Business Object para o painel de Produtos (FormSigOpPro)
* Form OPERACIONAL embutido na tela de Movimentacao (Entrada/Saida)
* Entidade principal: Item de Movimentacao - tabela SigMvItn
* Cursor de trabalho repassado pelo form pai: crTpmMvItn/TprMvCab
* Chave primaria: cidchaves char(20)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigopproBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigMvItn)
    this_nAqtds              = 0     && aqtds numeric(9,3)
    this_nCitens             = 0     && citens numeric(10,0)
    this_nCodbarras          = 0     && codbarras numeric(14,0)
    this_cCpros              = ""    && cpros char(14)
    this_cCunis              = ""    && cunis char(3)
    this_dDatatrans          = {}    && datatrans datetime NULL
    this_nDescvals           = 0     && descvals numeric(7,2)
    this_cDopes              = ""    && dopes char(20)
    this_cDpros              = ""    && dpros char(65)
    this_cEmps               = ""    && emps char(3)
    this_lEtiesps            = .F.   && etiesps bit
    this_nFators             = 0     && fators numeric(8,3)
    this_nFatvals            = 0     && fatvals numeric(15,6)
    this_lFvals              = .F.   && fvals bit
    this_lIconfs             = .F.   && iconfs bit
    this_cLocals             = ""    && locals char(10)
    this_cMoedas             = ""    && moedas char(3)
    this_cMoefats            = ""    && moefats char(3)
    this_nMoevals            = 0     && moevals numeric(15,6)
    this_cNotas              = ""    && notas char(6)
    this_cNrcons             = ""    && nrcons char(10)
    this_nNtrans             = 0     && ntrans numeric(6,0)
    this_nNumes              = 0     && numes numeric(6,0)
    this_nNumolds            = 0     && numolds numeric(6,0)
    this_cObs                = ""    && obs text NULL
    this_cOpers              = ""    && opers char(1)
    this_nPesos              = 0     && pesos numeric(9,3)
    this_nQtbaixas           = 0     && qtbaixas numeric(9,3)
    this_nQtbxprods          = 0     && qtbxprods numeric(9,3)
    this_nQtds               = 0     && qtds numeric(9,3)
    this_nQtprods            = 0     && qtprods numeric(9,3)
    this_nTotas              = 0     && totas numeric(11,2)
    this_nTpesos             = 0     && tpesos numeric(11,2)
    this_nUnitembs           = 0     && unitembs numeric(11,4)
    this_nUnits              = 0     && units numeric(15,6)
    this_nUnivals            = 0     && univals numeric(15,6)
    this_nVcoms              = 0     && vcoms numeric(8,2)
    this_nAliqs              = 0     && aliqs numeric(4,2)
    this_cSitribs            = ""    && sitribs char(2)
    this_cTpipis             = ""    && tpipis char(1)
    this_nValipis            = 0     && valipis numeric(11,2)
    this_nAliqicms           = 0     && aliqicms numeric(5,2)
    this_nValdescs           = 0     && valdescs numeric(9,2)
    this_cEmpos              = ""    && empos char(3)
    this_cMoevs              = ""    && moevs char(3)
    this_nUtilizas            = 0     && utilizas numeric(4,0)
    this_nNcodigos           = 0     && ncodigos numeric(10,0)
    this_nQtreservas         = 0     && qtreservas numeric(9,3)
    this_cCidchaves          = ""    && cidchaves char(20) - PK
    this_nNlotes             = 0     && nlotes numeric(10,0)
    this_dDtalts             = {}    && dtalts datetime NULL
    this_cEmpdopnums         = ""    && empdopnums char(29)
    this_nBaseicms           = 0     && baseicms numeric(11,2)
    this_lChksubn            = .F.   && chksubn bit
    this_nUnit2s             = 0     && unit2s numeric(15,6)
    this_cUsulibs            = ""    && usulibs char(10)
    this_nValrats            = 0     && valrats numeric(14,6)
    this_nCodlprecs          = 0     && codlprecs numeric(6,0)
    this_cCunips             = ""    && cunips char(3)
    this_cMotdscs            = ""    && motdscs char(10)
    this_cTipos              = ""    && tipos char(1)
    this_nUnitinfs           = 0     && unitinfs numeric(14,6)
    this_cCpro2s             = ""    && cpro2s char(50)
    this_cAbrevis            = ""    && abrevis char(3)
    this_nBcicmss            = 0     && bcicmss numeric(15,2)
    this_nBcipis             = 0     && bcipis numeric(15,2)
    this_nIcms               = 0     && icms numeric(15,2)
    this_nIcmss              = 0     && icmss numeric(15,2)
    this_nPdescs             = 0     && pdescs numeric(5,2)
    this_nNchvtbds           = 0     && nchvtbds numeric(6,0)
    this_nIdpro              = 0     && idpro numeric(10,0)
    this_nUnitorigs          = 0     && unitorigs numeric(14,6)
    this_cOrigmercs          = ""    && origmercs char(1)
    this_nBaseicm2s          = 0     && baseicm2s numeric(11,2)
    this_nBaseicm3s          = 0     && baseicm3s numeric(11,2)
    this_nBaseipi2s          = 0     && baseipi2s numeric(11,2)
    this_nBaseipi3s          = 0     && baseipi3s numeric(11,2)
    this_cCfops              = ""    && cfops char(10)
    this_nRatdacs            = 0     && ratdacs numeric(11,2)
    this_nRatfrts            = 0     && ratfrts numeric(11,2)
    this_nRaticmds           = 0     && raticmds numeric(11,2)
    this_nRaticms            = 0     && raticms numeric(11,2)
    this_nRatsegs            = 0     && ratsegs numeric(11,2)
    this_cSittricms          = ""    && sittricms char(3)
    this_nAliqiis            = 0     && aliqiis numeric(4,2)
    this_nCitem2             = 0     && citem2 numeric(10,0)
    this_nTaxaiis            = 0     && taxaiis numeric(11,2)
    this_nVcofins            = 0     && vcofins numeric(11,2)
    this_nVpis               = 0     && vpis numeric(11,2)
    this_nAliqorigs          = 0     && aliqorigs numeric(4,2)
    this_lLcancelas          = .F.   && lcancelas bit
    this_nCompris            = 0     && compris numeric(6,2)
    this_cCodfabs            = ""    && codfabs char(60)
    this_nNadis              = 0     && nadis numeric(3,0)
    this_nNiadis             = 0     && niadis numeric(3,0)
    this_nAliqcofs           = 0     && aliqcofs numeric(4,2)
    this_nAliqpis            = 0     && aliqpis numeric(4,2)
    this_nCssl               = 0     && cssl numeric(11,2)
    this_nInss               = 0     && inss numeric(11,2)
    this_nIrrf               = 0     && irrf numeric(11,2)
    this_nIss                = 0     && iss numeric(11,2)
    this_nValbases           = 0     && valbases numeric(11,2)
    this_cLocalos            = ""    && localos char(10)
    this_nPfcpst             = 0     && pfcpst numeric(5,2)
    this_nVfcpst             = 0     && vfcpst numeric(11,2)
    this_cOb2s               = ""    && ob2s char(100)
    this_cPedidoweb          = ""    && pedidoweb char(50)
    this_nQtresres           = 0     && qtresres numeric(9,3)
    this_nBarraref           = 0     && barraref numeric(14,0)
    this_cItemped            = ""    && itemped char(4)
    this_cNumeronota         = ""    && numeronota char(10)
    this_cDopesorig          = ""    && dopesorig char(20)
    this_cChaveexterna       = ""    && chaveexterna char(33)
    this_nCkpresente         = 0     && ckpresente numeric(1,0)
    this_cGravacao           = ""    && gravacao char(20)
    this_cIfors              = ""    && ifors char(10)
    this_cPropriedades       = ""    && propriedades nvarchar(40) NULL
    this_cUnidade1           = ""    && unidade1 nvarchar(15) NULL
    this_cResultado1         = ""    && resultado1 nvarchar(15) NULL
    this_cValorMinimo        = ""    && valorMinimo nvarchar(15) NULL
    this_cValorMaximo        = ""    && valorMaximo nvarchar(15) NULL
    this_cMetodoReferencia1  = ""    && metodoReferencia1 nvarchar(15) NULL

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvItn"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "sigopproBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia uma linha de SigMvItn (cursor populado
    * por SQLEXEC) para as properties da entidade. NAO e PROTECTED
    * (regra #51 - BusinessBase declara publico).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_nAqtds        = TratarNulo(aqtds, 0)
            THIS.this_nCitens       = TratarNulo(citens, 0)
            THIS.this_nCodbarras    = TratarNulo(codbarras, 0)
            THIS.this_cCpros        = TratarNulo(cpros, "")
            THIS.this_cCunis        = TratarNulo(cunis, "")
            THIS.this_dDatatrans    = TratarNulo(datatrans, {})
            THIS.this_nDescvals     = TratarNulo(descvals, 0)
            THIS.this_cDopes        = TratarNulo(dopes, "")
            THIS.this_cDpros        = TratarNulo(dpros, "")
            THIS.this_cEmps         = TratarNulo(emps, "")
            THIS.this_lEtiesps      = IIF(VARTYPE(etiesps) = "L", etiesps, (NVL(etiesps, 0) = 1))
            THIS.this_nFators       = TratarNulo(fators, 0)
            THIS.this_nFatvals      = TratarNulo(fatvals, 0)
            THIS.this_lFvals        = IIF(VARTYPE(fvals) = "L", fvals, (NVL(fvals, 0) = 1))
            THIS.this_lIconfs       = IIF(VARTYPE(iconfs) = "L", iconfs, (NVL(iconfs, 0) = 1))
            THIS.this_cLocals       = TratarNulo(locals, "")
            THIS.this_cMoedas       = TratarNulo(moedas, "")
            THIS.this_cMoefats      = TratarNulo(moefats, "")
            THIS.this_nMoevals      = TratarNulo(moevals, 0)
            THIS.this_cNotas        = TratarNulo(notas, "")
            THIS.this_cNrcons       = TratarNulo(nrcons, "")
            THIS.this_nNtrans       = TratarNulo(ntrans, 0)
            THIS.this_nNumes        = TratarNulo(numes, 0)
            THIS.this_nNumolds      = TratarNulo(numolds, 0)
            THIS.this_cObs          = TratarNulo(obs, "")
            THIS.this_cOpers        = TratarNulo(opers, "")
            THIS.this_nPesos        = TratarNulo(pesos, 0)
            THIS.this_nQtbaixas     = TratarNulo(qtbaixas, 0)
            THIS.this_nQtbxprods    = TratarNulo(qtbxprods, 0)
            THIS.this_nQtds         = TratarNulo(qtds, 0)
            THIS.this_nQtprods      = TratarNulo(qtprods, 0)
            THIS.this_nTotas        = TratarNulo(totas, 0)
            THIS.this_nTpesos       = TratarNulo(tpesos, 0)
            THIS.this_nUnitembs     = TratarNulo(unitembs, 0)
            THIS.this_nUnits        = TratarNulo(units, 0)
            THIS.this_nUnivals      = TratarNulo(univals, 0)
            THIS.this_nVcoms        = TratarNulo(vcoms, 0)
            THIS.this_nAliqs        = TratarNulo(aliqs, 0)
            THIS.this_cSitribs      = TratarNulo(sitribs, "")
            THIS.this_cTpipis       = TratarNulo(tpipis, "")
            THIS.this_nValipis      = TratarNulo(valipis, 0)
            THIS.this_nAliqicms     = TratarNulo(aliqicms, 0)
            THIS.this_nValdescs     = TratarNulo(valdescs, 0)
            THIS.this_cEmpos        = TratarNulo(empos, "")
            THIS.this_cMoevs        = TratarNulo(moevs, "")
            THIS.this_nUtilizas     = TratarNulo(utilizas, 0)
            THIS.this_nNcodigos     = TratarNulo(ncodigos, 0)
            THIS.this_nQtreservas   = TratarNulo(qtreservas, 0)
            THIS.this_cCidchaves    = TratarNulo(cidchaves, "")
            THIS.this_nNlotes       = TratarNulo(nlotes, 0)
            THIS.this_dDtalts       = TratarNulo(dtalts, {})
            THIS.this_cEmpdopnums   = TratarNulo(empdopnums, "")
            THIS.this_nBaseicms     = TratarNulo(baseicms, 0)
            THIS.this_lChksubn      = IIF(VARTYPE(chksubn) = "L", chksubn, (NVL(chksubn, 0) = 1))
            THIS.this_nUnit2s       = TratarNulo(unit2s, 0)
            THIS.this_cUsulibs      = TratarNulo(usulibs, "")
            THIS.this_nValrats      = TratarNulo(valrats, 0)
            THIS.this_nCodlprecs    = TratarNulo(codlprecs, 0)
            THIS.this_cCunips       = TratarNulo(cunips, "")
            THIS.this_cMotdscs      = TratarNulo(motdscs, "")
            THIS.this_cTipos        = TratarNulo(tipos, "")
            THIS.this_nUnitinfs     = TratarNulo(unitinfs, 0)
            THIS.this_cCpro2s       = TratarNulo(cpro2s, "")
            THIS.this_cAbrevis      = TratarNulo(abrevis, "")
            THIS.this_nBcicmss      = TratarNulo(bcicmss, 0)
            THIS.this_nBcipis       = TratarNulo(bcipis, 0)
            THIS.this_nIcms         = TratarNulo(icms, 0)
            THIS.this_nIcmss        = TratarNulo(icmss, 0)
            THIS.this_nPdescs       = TratarNulo(pdescs, 0)
            THIS.this_nNchvtbds     = TratarNulo(nchvtbds, 0)
            THIS.this_nIdpro        = TratarNulo(idpro, 0)
            THIS.this_nUnitorigs    = TratarNulo(unitorigs, 0)
            THIS.this_cOrigmercs    = TratarNulo(origmercs, "")
            THIS.this_nBaseicm2s    = TratarNulo(baseicm2s, 0)
            THIS.this_nBaseicm3s    = TratarNulo(baseicm3s, 0)
            THIS.this_nBaseipi2s    = TratarNulo(baseipi2s, 0)
            THIS.this_nBaseipi3s    = TratarNulo(baseipi3s, 0)
            THIS.this_cCfops        = TratarNulo(cfops, "")
            THIS.this_nRatdacs      = TratarNulo(ratdacs, 0)
            THIS.this_nRatfrts      = TratarNulo(ratfrts, 0)
            THIS.this_nRaticmds     = TratarNulo(raticmds, 0)
            THIS.this_nRaticms      = TratarNulo(raticms, 0)
            THIS.this_nRatsegs      = TratarNulo(ratsegs, 0)
            THIS.this_cSittricms    = TratarNulo(sittricms, "")
            THIS.this_nAliqiis      = TratarNulo(aliqiis, 0)
            THIS.this_nCitem2       = TratarNulo(citem2, 0)
            THIS.this_nTaxaiis      = TratarNulo(taxaiis, 0)
            THIS.this_nVcofins      = TratarNulo(vcofins, 0)
            THIS.this_nVpis         = TratarNulo(vpis, 0)
            THIS.this_nAliqorigs    = TratarNulo(aliqorigs, 0)
            THIS.this_lLcancelas    = IIF(VARTYPE(lcancelas) = "L", lcancelas, (NVL(lcancelas, 0) = 1))
            THIS.this_nCompris      = TratarNulo(compris, 0)
            THIS.this_cCodfabs      = TratarNulo(codfabs, "")
            THIS.this_nNadis        = TratarNulo(nadis, 0)
            THIS.this_nNiadis       = TratarNulo(niadis, 0)
            THIS.this_nAliqcofs     = TratarNulo(aliqcofs, 0)
            THIS.this_nAliqpis      = TratarNulo(aliqpis, 0)
            THIS.this_nCssl         = TratarNulo(cssl, 0)
            THIS.this_nInss         = TratarNulo(inss, 0)
            THIS.this_nIrrf         = TratarNulo(irrf, 0)
            THIS.this_nIss          = TratarNulo(iss, 0)
            THIS.this_nValbases     = TratarNulo(valbases, 0)
            THIS.this_cLocalos      = TratarNulo(localos, "")
            THIS.this_nPfcpst       = TratarNulo(pfcpst, 0)
            THIS.this_nVfcpst       = TratarNulo(vfcpst, 0)
            THIS.this_cOb2s         = TratarNulo(ob2s, "")
            THIS.this_cPedidoweb    = TratarNulo(pedidoweb, "")
            THIS.this_nQtresres     = TratarNulo(qtresres, 0)
            THIS.this_nBarraref     = TratarNulo(barraref, 0)
            THIS.this_cItemped      = TratarNulo(itemped, "")
            THIS.this_cNumeronota   = TratarNulo(numeronota, "")
            THIS.this_cDopesorig    = TratarNulo(dopesorig, "")
            THIS.this_cChaveexterna = TratarNulo(chaveexterna, "")
            THIS.this_nCkpresente   = TratarNulo(ckpresente, 0)
            THIS.this_cGravacao     = TratarNulo(gravacao, "")
            THIS.this_cIfors        = TratarNulo(ifors, "")
            THIS.this_cPropriedades       = TratarNulo(propriedades, "")
            THIS.this_cUnidade1           = TratarNulo(unidade1, "")
            THIS.this_cResultado1         = TratarNulo(resultado1, "")
            THIS.this_cValorMinimo        = TratarNulo(valorMinimo, "")
            THIS.this_cValorMaximo        = TratarNulo(valorMaximo, "")
            THIS.this_cMetodoReferencia1  = TratarNulo(metodoReferencia1, "")

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * MontarChaveEmpDopNums - Monta a chave POSICIONAL empdopnums
    * char(29), igual ao legado (SIGMVSBN: Emps + Dopes + Str(Numes,6)).
    * Regra #42: o padding FAZ PARTE da chave - PADR explicito nas
    * partes (Emps char(3) + Dopes char(20) + 6 = 29). ALLTRIM nas
    * partes encurta a chave, ela nunca casa e o SELECT devolve ZERO
    * linhas em silencio.
    *====================================================================
    FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes

        loc_cEmps  = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
        loc_cDopes = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
        loc_nNumes = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)

        RETURN PADR(loc_cEmps, 3) + PADR(loc_cDopes, 20) + STR(loc_nNumes, 6)
    ENDFUNC

    *====================================================================
    * CarregarItens - Le os itens de UMA movimentacao (empdopnums) para
    * um cursor TEMPORARIO. Equivale ao AddCursor('SigMvItn', ...) que o
    * legado herda do form pai de Movimentacao.
    *
    * NUNCA faz SQLEXEC sobre o alias ligado a grade: isso FECHA e RECRIA
    * o alias, zera o ColumnCount e a grade vira um retangulo branco
    * (sem erro e sem log). O chamador recarrega o alias da grade com
    * SELECT/ZAP/APPEND FROM DBF() a partir deste cursor temporario.
    *
    * par_cEmpDopNums - chave char(29) da movimentacao (ver
    *                   MontarChaveEmpDopNums)
    * par_cCursorTmp  - alias do cursor temporario de destino
    *====================================================================
    FUNCTION CarregarItens(par_cEmpDopNums, par_cCursorTmp)
        LOCAL loc_cSQL, loc_cCursor, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = IIF(VARTYPE(par_cCursorTmp) = "C" AND !EMPTY(par_cCursorTmp), ;
                           ALLTRIM(par_cCursorTmp), "cursor_4c_ItensTmp")

        IF VARTYPE(par_cEmpDopNums) <> "C" OR EMPTY(par_cEmpDopNums)
            THIS.this_cMensagemErro = "Chave da movimenta" + CHR(231) + CHR(227) + ;
                                      "o n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco n" + ;
                                      CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            *-- Alias do cursor temporario fechado antes do SQLEXEC; o guard
            *-- testa o BUFFERING, nunca so o USED (regra #52).
            IF USED(loc_cCursor)
                IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                    TABLEREVERT(.T., loc_cCursor)
                ENDIF
                USE IN (loc_cCursor)
            ENDIF

            *-- Lista de colunas EXPLICITA e identica a do CREATE CURSOR do
            *-- form: o APPEND FROM DBF() casa os campos por NOME.
            loc_cSQL = "SELECT aqtds, citens, codbarras, cpros, cunis," + ;
                       " datatrans, descvals, dopes, dpros, emps," + ;
                       " etiesps, fators, fatvals, fvals, iconfs," + ;
                       " locals, moedas, moefats, moevals, notas," + ;
                       " nrcons, ntrans, numes, numolds, obs," + ;
                       " opers, pesos, qtbaixas, qtbxprods, qtds," + ;
                       " qtprods, totas, tpesos, unitembs, units," + ;
                       " univals, vcoms, aliqs, sitribs, tpipis," + ;
                       " valipis, aliqicms, valdescs, empos, moevs," + ;
                       " utilizas, ncodigos, qtreservas, cidchaves, nlotes," + ;
                       " dtalts, empdopnums, baseicms, chksubn, unit2s," + ;
                       " usulibs, valrats, codlprecs, cunips, motdscs," + ;
                       " tipos, unitinfs, cpro2s, abrevis, bcicmss," + ;
                       " bcipis, icms, icmss, pdescs, nchvtbds," + ;
                       " idpro, unitorigs, origmercs, baseicm2s, baseicm3s," + ;
                       " baseipi2s, baseipi3s, cfops, ratdacs, ratfrts," + ;
                       " raticmds, raticms, ratsegs, sittricms, aliqiis," + ;
                       " citem2, taxaiis, vcofins, vpis, aliqorigs," + ;
                       " lcancelas, compris, codfabs, nadis, niadis," + ;
                       " aliqcofs, aliqpis, cssl, inss, irrf," + ;
                       " iss, valbases, localos, pfcpst, vfcpst," + ;
                       " ob2s, pedidoweb, qtresres, barraref, itemped," + ;
                       " numeronota, dopesorig, chaveexterna, ckpresente," + ;
                       " gravacao, ifors, propriedades, unidade1, resultado1," + ;
                       " valorMinimo, valorMaximo, metodoReferencia1" + ;
                       " FROM SigMvItn" + ;
                       " WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums) + ;
                       " ORDER BY citens"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao carregar os itens da movimenta" + CHR(231) + ;
                            CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, ;
                            "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro("Erro ao carregar os itens da movimenta" + CHR(231) + ;
                        CHR(227) + "o:" + CHR(13) + loc_oErro.Message, ;
                        "sigopproBO.CarregarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterChavePrimaria - cidchaves (PK Fortyus, regra #22). PROTECTED:
    * nunca chamado de fora (so por RegistrarAuditoria/ExecutarExclusao).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDPROC

    *====================================================================
    * Inserir - INSERT completo em SigMvItn. cidchaves (PK Fortyus) e
    * gerada aqui se ainda vazia (regra #22 - fUniqueIds(), NUNCA string
    * vazia, senao o 2o registro colide no indice unico).
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidchaves)
            THIS.this_cCidchaves = fUniqueIds()
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigMvItn (
                    aqtds, citens, codbarras, cpros, cunis, datatrans,
                    descvals, dopes, dpros, emps, etiesps, fators,
                    fatvals, fvals, iconfs, locals, moedas, moefats,
                    moevals, notas, nrcons, ntrans, numes, numolds,
                    obs, opers, pesos, qtbaixas, qtbxprods, qtds,
                    qtprods, totas, tpesos, unitembs, units, univals,
                    vcoms, aliqs, sitribs, tpipis, valipis, aliqicms,
                    valdescs, empos, moevs, utilizas, ncodigos, qtreservas,
                    cidchaves, nlotes, dtalts, empdopnums, baseicms, chksubn,
                    unit2s, usulibs, valrats, codlprecs, cunips, motdscs,
                    tipos, unitinfs, cpro2s, abrevis, bcicmss, bcipis,
                    icms, icmss, pdescs, nchvtbds, idpro, unitorigs,
                    origmercs, baseicm2s, baseicm3s, baseipi2s, baseipi3s, cfops,
                    ratdacs, ratfrts, raticmds, raticms, ratsegs, sittricms,
                    aliqiis, citem2, taxaiis, vcofins, vpis, aliqorigs,
                    lcancelas, compris, codfabs, nadis, niadis, aliqcofs,
                    aliqpis, cssl, inss, irrf, iss, valbases,
                    localos, pfcpst, vfcpst, ob2s, pedidoweb, qtresres,
                    barraref, itemped, numeronota, dopesorig, chaveexterna, ckpresente,
                    gravacao, ifors, propriedades, unidade1, resultado1, valorMinimo,
                    valorMaximo, metodoReferencia1
                )
                VALUES (
                    <<FormatarNumeroSQL(THIS.this_nAqtds, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nCitens, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodbarras, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCunis, 3))>>,
                    <<IIF(EMPTY(THIS.this_dDatatrans), "NULL", FormatarDataSQL(THIS.this_dDatatrans))>>,
                    <<FormatarNumeroSQL(THIS.this_nDescvals, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cDopes, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cDpros, 65))>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    <<IIF(THIS.this_lEtiesps, 1, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nFators, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nFatvals, 6)>>,
                    <<IIF(THIS.this_lFvals, 1, 0)>>,
                    <<IIF(THIS.this_lIconfs, 1, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cLocals, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMoedas, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMoefats, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nMoevals, 6)>>,
                    <<EscaparSQL(LEFT(THIS.this_cNotas, 6))>>,
                    <<EscaparSQL(LEFT(THIS.this_cNrcons, 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumolds, 0)>>,
                    <<IIF(EMPTY(THIS.this_cObs), "NULL", EscaparSQL(THIS.this_cObs))>>,
                    <<EscaparSQL(LEFT(THIS.this_cOpers, 1))>>,
                    <<FormatarNumeroSQL(THIS.this_nPesos, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtbaixas, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtbxprods, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtds, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtprods, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nTotas, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpesos, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnitembs, 4)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnits, 6)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnivals, 6)>>,
                    <<FormatarNumeroSQL(THIS.this_nVcoms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqs, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cSitribs, 2))>>,
                    <<EscaparSQL(LEFT(THIS.this_cTpipis, 1))>>,
                    <<FormatarNumeroSQL(THIS.this_nValipis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqicms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nValdescs, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmpos, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMoevs, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nUtilizas, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNcodigos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtreservas, 3)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>,
                    <<FormatarNumeroSQL(THIS.this_nNlotes, 0)>>,
                    <<IIF(EMPTY(THIS.this_dDtalts), "NULL", FormatarDataSQL(THIS.this_dDtalts))>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseicms, 2)>>,
                    <<IIF(THIS.this_lChksubn, 1, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnit2s, 6)>>,
                    <<EscaparSQL(LEFT(THIS.this_cUsulibs, 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nValrats, 6)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodlprecs, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCunips, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMotdscs, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cTipos, 1))>>,
                    <<FormatarNumeroSQL(THIS.this_nUnitinfs, 6)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCpro2s, 50))>>,
                    <<EscaparSQL(LEFT(THIS.this_cAbrevis, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nBcicmss, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nBcipis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcmss, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nPdescs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nNchvtbds, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIdpro, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnitorigs, 6)>>,
                    <<EscaparSQL(LEFT(THIS.this_cOrigmercs, 1))>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseicm2s, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseicm3s, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseipi2s, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseipi3s, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCfops, 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nRatdacs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nRatfrts, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nRaticmds, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nRaticms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nRatsegs, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cSittricms, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqiis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nCitem2, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTaxaiis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nVcofins, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nVpis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqorigs, 2)>>,
                    <<IIF(THIS.this_lLcancelas, 1, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCompris, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCodfabs, 60))>>,
                    <<FormatarNumeroSQL(THIS.this_nNadis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNiadis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqcofs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqpis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nCssl, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nInss, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nIrrf, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nIss, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nValbases, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cLocalos, 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nPfcpst, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nVfcpst, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cOb2s, 100))>>,
                    <<EscaparSQL(LEFT(THIS.this_cPedidoweb, 50))>>,
                    <<FormatarNumeroSQL(THIS.this_nQtresres, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nBarraref, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cItemped, 4))>>,
                    <<EscaparSQL(LEFT(THIS.this_cNumeronota, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cDopesorig, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))>>,
                    <<FormatarNumeroSQL(THIS.this_nCkpresente, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cGravacao, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cIfors, 10))>>,
                    <<IIF(EMPTY(THIS.this_cPropriedades), "NULL", EscaparSQL(LEFT(THIS.this_cPropriedades, 40)))>>,
                    <<IIF(EMPTY(THIS.this_cUnidade1), "NULL", EscaparSQL(LEFT(THIS.this_cUnidade1, 15)))>>,
                    <<IIF(EMPTY(THIS.this_cResultado1), "NULL", EscaparSQL(LEFT(THIS.this_cResultado1, 15)))>>,
                    <<IIF(EMPTY(THIS.this_cValorMinimo), "NULL", EscaparSQL(LEFT(THIS.this_cValorMinimo, 15)))>>,
                    <<IIF(EMPTY(THIS.this_cValorMaximo), "NULL", EscaparSQL(LEFT(THIS.this_cValorMaximo, 15)))>>,
                    <<IIF(EMPTY(THIS.this_cMetodoReferencia1), "NULL", EscaparSQL(LEFT(THIS.this_cMetodoReferencia1, 15)))>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao inserir item de movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro("Erro ao inserir item de movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "sigopproBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE completo em SigMvItn pela PK cidchaves.
    * cidchaves identifica o registro e NAO entra no SET.
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigMvItn SET
                    aqtds        = <<FormatarNumeroSQL(THIS.this_nAqtds, 3)>>,
                    citens       = <<FormatarNumeroSQL(THIS.this_nCitens, 0)>>,
                    codbarras    = <<FormatarNumeroSQL(THIS.this_nCodbarras, 0)>>,
                    cpros        = <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    cunis        = <<EscaparSQL(LEFT(THIS.this_cCunis, 3))>>,
                    datatrans    = <<IIF(EMPTY(THIS.this_dDatatrans), "NULL", FormatarDataSQL(THIS.this_dDatatrans))>>,
                    descvals     = <<FormatarNumeroSQL(THIS.this_nDescvals, 2)>>,
                    dopes        = <<EscaparSQL(LEFT(THIS.this_cDopes, 20))>>,
                    dpros        = <<EscaparSQL(LEFT(THIS.this_cDpros, 65))>>,
                    emps         = <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    etiesps      = <<IIF(THIS.this_lEtiesps, 1, 0)>>,
                    fators       = <<FormatarNumeroSQL(THIS.this_nFators, 3)>>,
                    fatvals      = <<FormatarNumeroSQL(THIS.this_nFatvals, 6)>>,
                    fvals        = <<IIF(THIS.this_lFvals, 1, 0)>>,
                    iconfs       = <<IIF(THIS.this_lIconfs, 1, 0)>>,
                    locals       = <<EscaparSQL(LEFT(THIS.this_cLocals, 10))>>,
                    moedas       = <<EscaparSQL(LEFT(THIS.this_cMoedas, 3))>>,
                    moefats      = <<EscaparSQL(LEFT(THIS.this_cMoefats, 3))>>,
                    moevals      = <<FormatarNumeroSQL(THIS.this_nMoevals, 6)>>,
                    notas        = <<EscaparSQL(LEFT(THIS.this_cNotas, 6))>>,
                    nrcons       = <<EscaparSQL(LEFT(THIS.this_cNrcons, 10))>>,
                    ntrans       = <<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
                    numes        = <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
                    numolds      = <<FormatarNumeroSQL(THIS.this_nNumolds, 0)>>,
                    obs          = <<IIF(EMPTY(THIS.this_cObs), "NULL", EscaparSQL(THIS.this_cObs))>>,
                    opers        = <<EscaparSQL(LEFT(THIS.this_cOpers, 1))>>,
                    pesos        = <<FormatarNumeroSQL(THIS.this_nPesos, 3)>>,
                    qtbaixas     = <<FormatarNumeroSQL(THIS.this_nQtbaixas, 3)>>,
                    qtbxprods    = <<FormatarNumeroSQL(THIS.this_nQtbxprods, 3)>>,
                    qtds         = <<FormatarNumeroSQL(THIS.this_nQtds, 3)>>,
                    qtprods      = <<FormatarNumeroSQL(THIS.this_nQtprods, 3)>>,
                    totas        = <<FormatarNumeroSQL(THIS.this_nTotas, 2)>>,
                    tpesos       = <<FormatarNumeroSQL(THIS.this_nTpesos, 2)>>,
                    unitembs     = <<FormatarNumeroSQL(THIS.this_nUnitembs, 4)>>,
                    units        = <<FormatarNumeroSQL(THIS.this_nUnits, 6)>>,
                    univals      = <<FormatarNumeroSQL(THIS.this_nUnivals, 6)>>,
                    vcoms        = <<FormatarNumeroSQL(THIS.this_nVcoms, 2)>>,
                    aliqs        = <<FormatarNumeroSQL(THIS.this_nAliqs, 2)>>,
                    sitribs      = <<EscaparSQL(LEFT(THIS.this_cSitribs, 2))>>,
                    tpipis       = <<EscaparSQL(LEFT(THIS.this_cTpipis, 1))>>,
                    valipis      = <<FormatarNumeroSQL(THIS.this_nValipis, 2)>>,
                    aliqicms     = <<FormatarNumeroSQL(THIS.this_nAliqicms, 2)>>,
                    valdescs     = <<FormatarNumeroSQL(THIS.this_nValdescs, 2)>>,
                    empos        = <<EscaparSQL(LEFT(THIS.this_cEmpos, 3))>>,
                    moevs        = <<EscaparSQL(LEFT(THIS.this_cMoevs, 3))>>,
                    utilizas     = <<FormatarNumeroSQL(THIS.this_nUtilizas, 0)>>,
                    ncodigos     = <<FormatarNumeroSQL(THIS.this_nNcodigos, 0)>>,
                    qtreservas   = <<FormatarNumeroSQL(THIS.this_nQtreservas, 3)>>,
                    nlotes       = <<FormatarNumeroSQL(THIS.this_nNlotes, 0)>>,
                    dtalts       = <<IIF(EMPTY(THIS.this_dDtalts), "NULL", FormatarDataSQL(THIS.this_dDtalts))>>,
                    empdopnums   = <<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
                    baseicms     = <<FormatarNumeroSQL(THIS.this_nBaseicms, 2)>>,
                    chksubn      = <<IIF(THIS.this_lChksubn, 1, 0)>>,
                    unit2s       = <<FormatarNumeroSQL(THIS.this_nUnit2s, 6)>>,
                    usulibs      = <<EscaparSQL(LEFT(THIS.this_cUsulibs, 10))>>,
                    valrats      = <<FormatarNumeroSQL(THIS.this_nValrats, 6)>>,
                    codlprecs    = <<FormatarNumeroSQL(THIS.this_nCodlprecs, 0)>>,
                    cunips       = <<EscaparSQL(LEFT(THIS.this_cCunips, 3))>>,
                    motdscs      = <<EscaparSQL(LEFT(THIS.this_cMotdscs, 10))>>,
                    tipos        = <<EscaparSQL(LEFT(THIS.this_cTipos, 1))>>,
                    unitinfs     = <<FormatarNumeroSQL(THIS.this_nUnitinfs, 6)>>,
                    cpro2s       = <<EscaparSQL(LEFT(THIS.this_cCpro2s, 50))>>,
                    abrevis      = <<EscaparSQL(LEFT(THIS.this_cAbrevis, 3))>>,
                    bcicmss      = <<FormatarNumeroSQL(THIS.this_nBcicmss, 2)>>,
                    bcipis       = <<FormatarNumeroSQL(THIS.this_nBcipis, 2)>>,
                    icms         = <<FormatarNumeroSQL(THIS.this_nIcms, 2)>>,
                    icmss        = <<FormatarNumeroSQL(THIS.this_nIcmss, 2)>>,
                    pdescs       = <<FormatarNumeroSQL(THIS.this_nPdescs, 2)>>,
                    nchvtbds     = <<FormatarNumeroSQL(THIS.this_nNchvtbds, 0)>>,
                    idpro        = <<FormatarNumeroSQL(THIS.this_nIdpro, 0)>>,
                    unitorigs    = <<FormatarNumeroSQL(THIS.this_nUnitorigs, 6)>>,
                    origmercs    = <<EscaparSQL(LEFT(THIS.this_cOrigmercs, 1))>>,
                    baseicm2s    = <<FormatarNumeroSQL(THIS.this_nBaseicm2s, 2)>>,
                    baseicm3s    = <<FormatarNumeroSQL(THIS.this_nBaseicm3s, 2)>>,
                    baseipi2s    = <<FormatarNumeroSQL(THIS.this_nBaseipi2s, 2)>>,
                    baseipi3s    = <<FormatarNumeroSQL(THIS.this_nBaseipi3s, 2)>>,
                    cfops        = <<EscaparSQL(LEFT(THIS.this_cCfops, 10))>>,
                    ratdacs      = <<FormatarNumeroSQL(THIS.this_nRatdacs, 2)>>,
                    ratfrts      = <<FormatarNumeroSQL(THIS.this_nRatfrts, 2)>>,
                    raticmds     = <<FormatarNumeroSQL(THIS.this_nRaticmds, 2)>>,
                    raticms      = <<FormatarNumeroSQL(THIS.this_nRaticms, 2)>>,
                    ratsegs      = <<FormatarNumeroSQL(THIS.this_nRatsegs, 2)>>,
                    sittricms    = <<EscaparSQL(LEFT(THIS.this_cSittricms, 3))>>,
                    aliqiis      = <<FormatarNumeroSQL(THIS.this_nAliqiis, 2)>>,
                    citem2       = <<FormatarNumeroSQL(THIS.this_nCitem2, 0)>>,
                    taxaiis      = <<FormatarNumeroSQL(THIS.this_nTaxaiis, 2)>>,
                    vcofins      = <<FormatarNumeroSQL(THIS.this_nVcofins, 2)>>,
                    vpis         = <<FormatarNumeroSQL(THIS.this_nVpis, 2)>>,
                    aliqorigs    = <<FormatarNumeroSQL(THIS.this_nAliqorigs, 2)>>,
                    lcancelas    = <<IIF(THIS.this_lLcancelas, 1, 0)>>,
                    compris      = <<FormatarNumeroSQL(THIS.this_nCompris, 2)>>,
                    codfabs      = <<EscaparSQL(LEFT(THIS.this_cCodfabs, 60))>>,
                    nadis        = <<FormatarNumeroSQL(THIS.this_nNadis, 0)>>,
                    niadis       = <<FormatarNumeroSQL(THIS.this_nNiadis, 0)>>,
                    aliqcofs     = <<FormatarNumeroSQL(THIS.this_nAliqcofs, 2)>>,
                    aliqpis      = <<FormatarNumeroSQL(THIS.this_nAliqpis, 2)>>,
                    cssl         = <<FormatarNumeroSQL(THIS.this_nCssl, 2)>>,
                    inss         = <<FormatarNumeroSQL(THIS.this_nInss, 2)>>,
                    irrf         = <<FormatarNumeroSQL(THIS.this_nIrrf, 2)>>,
                    iss          = <<FormatarNumeroSQL(THIS.this_nIss, 2)>>,
                    valbases     = <<FormatarNumeroSQL(THIS.this_nValbases, 2)>>,
                    localos      = <<EscaparSQL(LEFT(THIS.this_cLocalos, 10))>>,
                    pfcpst       = <<FormatarNumeroSQL(THIS.this_nPfcpst, 2)>>,
                    vfcpst       = <<FormatarNumeroSQL(THIS.this_nVfcpst, 2)>>,
                    ob2s         = <<EscaparSQL(LEFT(THIS.this_cOb2s, 100))>>,
                    pedidoweb    = <<EscaparSQL(LEFT(THIS.this_cPedidoweb, 50))>>,
                    qtresres     = <<FormatarNumeroSQL(THIS.this_nQtresres, 3)>>,
                    barraref     = <<FormatarNumeroSQL(THIS.this_nBarraref, 0)>>,
                    itemped      = <<EscaparSQL(LEFT(THIS.this_cItemped, 4))>>,
                    numeronota   = <<EscaparSQL(LEFT(THIS.this_cNumeronota, 10))>>,
                    dopesorig    = <<EscaparSQL(LEFT(THIS.this_cDopesorig, 20))>>,
                    chaveexterna = <<EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))>>,
                    ckpresente   = <<FormatarNumeroSQL(THIS.this_nCkpresente, 0)>>,
                    gravacao     = <<EscaparSQL(LEFT(THIS.this_cGravacao, 20))>>,
                    ifors        = <<EscaparSQL(LEFT(THIS.this_cIfors, 10))>>,
                    propriedades = <<IIF(EMPTY(THIS.this_cPropriedades), "NULL", EscaparSQL(LEFT(THIS.this_cPropriedades, 40)))>>,
                    unidade1     = <<IIF(EMPTY(THIS.this_cUnidade1), "NULL", EscaparSQL(LEFT(THIS.this_cUnidade1, 15)))>>,
                    resultado1   = <<IIF(EMPTY(THIS.this_cResultado1), "NULL", EscaparSQL(LEFT(THIS.this_cResultado1, 15)))>>,
                    valorMinimo  = <<IIF(EMPTY(THIS.this_cValorMinimo), "NULL", EscaparSQL(LEFT(THIS.this_cValorMinimo, 15)))>>,
                    valorMaximo  = <<IIF(EMPTY(THIS.this_cValorMaximo), "NULL", EscaparSQL(LEFT(THIS.this_cValorMaximo, 15)))>>,
                    metodoReferencia1 = <<IIF(EMPTY(THIS.this_cMetodoReferencia1), "NULL", EscaparSQL(LEFT(THIS.this_cMetodoReferencia1, 15)))>>
                WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao atualizar item de movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro("Erro ao atualizar item de movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "sigopproBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

