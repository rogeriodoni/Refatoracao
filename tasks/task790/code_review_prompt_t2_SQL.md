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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoppro.prg) - TRECHOS RELEVANTES PARA PASS SQL (6488 linhas total):

*-- Linhas 151 a 169:
151:                 THIS.ConfigurarPageFrame()
152: 
153:                 *-- Cursores ANTES das paginas: os campos de Page1/Page3 e a
154:                 *-- grade de Page4 usam ControlSource, e ControlSource de alias
155:                 *-- que ainda nao existe derruba o Init (regra #41).
156:                 THIS.CriarCursorItens()
157:                 THIS.CriarCursorPrecos()
158: 
159:                 THIS.ConfigurarPaginaProduto()
160:                 THIS.ConfigurarPaginaDados()
161:                 THIS.ConfigurarPaginaFiscal()
162:                 THIS.ConfigurarPaginaPrecos()
163:                 THIS.ConfigurarBotoes()
164:                 THIS.ConfigurarBotoesTopo()
165:                 THIS.ConfigurarBotoesAcao()
166:                 THIS.ConfigurarGridDados()
167: 
168:                 *-- AfterRowColChange: handler DECLARA par_nColIndex porque o
169:                 *-- evento passa o argumento (regra #3). Uso de LINHA corrente

*-- Linhas 376 a 394:
376:     * data session do form PAI (Movimentacao) - este form eh DataSession=2
377:     * (privado) e ainda nao tem a ponte com o pai conectada (ver comentario
378:     * de this_cOpEscolha no cabecalho da classe). Por isso os campos usam
379:     * .Value direto (sem ControlSource) a partir de properties locais
380:     * this_cMascnum/this_cTabds/this_cTpfats/this_cMoeits, que uma fase
381:     * posterior de integracao com o form pai ira popular.
382:     *
383:     * FASE 6/8 (Parte 2 de 2): completa os containers desta pagina com
384:     * cnt_4c_Origem, cnt_4c_Destino, cnt_4c_EmpDes, cnt_4c_LPrecos.
385:     *
386:     * SEM LOOKUP nestes quatro: no legado, Get_grupo/Get_conta/Get_dconta de
387:     * cntOrigem/cntDestino tem ReadOnly=.T. no dump E o proprio When() do SCX
388:     * retorna .F. sempre (Return .F.) - sao espelhos read-only do cabecalho
389:     * TprMvCab (que vive no data session do form PAI), nunca campos
390:     * digitaveis. getEmpDs (cntEmpDes) tambem tem When() = Return(.F.). So
391:     * getLPrecos (cntLPrecos) eh editavel no legado, mas nao tem
392:     * CreateObject('fwbuscaext'/'fwBuscaSel') nem sigacess() no Valid - eh
393:     * texto livre (Format="K", MaxLength=30), sem tabela de referencia.
394:     *==========================================================================

*-- Linhas 816 a 844:
816:     *==========================================================================
817:     * CriarCursorItens - Cursor de trabalho (espelha crTpmMvItn do legado),
818:     * compartilhado pela grade grd_4c_Dados e pelo sigopproBO.CarregarDoCursor.
819:     * Mantido num unico CREATE CURSOR para que as paginas de Dados/Fiscal/
820:     * Precificacao (fases seguintes) liguem campos nele sem recriar a
821:     * estrutura (regra #41 - Column.ControlSource exige o cursor ja existir).
822:     *==========================================================================
823:     PROTECTED PROCEDURE CriarCursorItens()
824:         IF USED("cursor_4c_Itens")
825:             USE IN cursor_4c_Itens
826:         ENDIF
827: 
828:         SET NULL ON
829:         CREATE CURSOR cursor_4c_Itens ( ;
830:             cidchaves C(20), citens N(10,0), cpros C(14), dpros C(65), ;
831:             codbarras N(14,0), cunis C(3), cunips C(3), fators N(8,3), ;
832:             opers C(1), qtds N(9,3), pesos N(9,3), units N(15,6), ;
833:             moedas C(3), totas N(11,2), tpesos N(11,2), abrevis C(3), ;
834:             locals C(10), localos C(10), compris N(6,2), qtreservas N(9,3), ;
835:             ckpresente N(1,0), codcors C(4), codtams C(4), servicos N(1,0), ;
836:             aqtds N(9,3), datatrans T NULL, descvals N(7,2), dopes C(20), ;
837:             emps C(3), etiesps L, fatvals N(15,6), fvals L, iconfs L, ;
838:             moefats C(3), moevals N(15,6), notas C(6), nrcons C(10), ;
839:             ntrans N(6,0), numes N(6,0), numolds N(6,0), obs M NULL, ;
840:             qtbaixas N(9,3), qtbxprods N(9,3), qtprods N(9,3), ;
841:             unitembs N(11,4), univals N(15,6), vcoms N(8,2), aliqs N(4,2), ;
842:             sitribs C(2), tpipis C(1), valipis N(11,2), aliqicms N(5,2), ;
843:             valdescs N(9,2), empos C(3), moevs C(3), utilizas N(4,0), ;
844:             ncodigos N(10,0), nlotes N(10,0), dtalts T NULL, empdopnums C(29), ;

*-- Linhas 864 a 1129:
864: 
865:         INDEX ON citens TAG citens
866: 
867:         *-- SET DELETED eh escopado por DATA SESSION e este form eh
868:         *-- DataSession = 2: na sessao privada ele volta ao default OFF, e com
869:         *-- OFF a linha excluida do cursor CONTINUA aparecendo na grade (que
870:         *-- tem DeleteMark = .F., entao nem a marca de exclusao denuncia) e
871:         *-- ainda eh contada por COUNT/SCAN. A exclusao de linha e a
872:         *-- renumeracao dos itens dependem disso.
873:         SET DELETED ON
874:     ENDPROC
875: 
876:     *==========================================================================
877:     * ConfigurarGridDados - grd_4c_Dados (fwGrade do legado): grade principal
878:     * de itens da movimentacao, 22 colunas na mesma ordem/largura do dump.
879:     *==========================================================================
880:     PROTECTED PROCEDURE ConfigurarGridDados()
881:         THIS.AddObject("grd_4c_Dados", "Grid")
882:         WITH THIS.grd_4c_Dados
883:             .Top               = 122
884:             .Left              = 7
885:             .Width             = 1035
886:             .Height            = 233
887:             .ColumnCount       = 22
888:             .RecordSource      = "cursor_4c_Itens"
889:             .FontName          = "Courier New"
890:             .FontSize          = 9
891:             .HeaderHeight      = 16
892:             .RowHeight         = 16
893:             .AllowHeaderSizing = .F.
894:             .DeleteMark        = .F.
895:             .RecordMark        = .F.
896:             .ScrollBars        = 3
897:             .GridLineColor     = RGB(238, 238, 238)
898:             .ToolTipText       = "Grade de Produtos"
899:         ENDWITH
900: 
901:         *-- Column1: PRODUTO (estilo link - sublinhado/azul, igual ao legado)
902:         WITH THIS.grd_4c_Dados.Column1
903:             .ControlSource     = "cursor_4c_Itens.cpros"
904:             .Width             = 108
905:             .FontBold          = .T.
906:             .FontName          = "Courier New"
907:             .FontSize          = 9
908:             .FontUnderline     = .T.
909:             .ForeColor         = RGB(0, 0, 255)
910:             .Format            = "K!"
911:             .InputMask         = REPLICATE("!", 14)
912:             .Header1.FontBold  = .T.
913:             .Header1.FontName  = "Arial"
914:             .Header1.FontSize  = 8
915:             .Header1.Alignment = 2
916:             .Header1.Caption   = "Produto"
917:         ENDWITH
918: 
919:         *-- Column2: FATOR
920:         WITH THIS.grd_4c_Dados.Column2
921:             .ControlSource     = "cursor_4c_Itens.fators"
922:             .Width             = 50
923:             .InputMask         = "99999.999"
924:             .Header1.Alignment = 2
925:             .Header1.Caption   = "Fator"
926:         ENDWITH
927: 
928:         *-- Column3: OPERACAO (Format=M -> InputMask eh a LISTA, regra #24)
929:         WITH THIS.grd_4c_Dados.Column3
930:             .ControlSource     = "cursor_4c_Itens.opers"
931:             .Width             = 14
932:             .Format            = "M"
933:             .InputMask         = "E,S"
934:             .Header1.Caption   = "Op"
935:         ENDWITH
936: 
937:         *-- Column4: QTD
938:         WITH THIS.grd_4c_Dados.Column4
939:             .ControlSource     = "cursor_4c_Itens.qtds"
940:             .Width             = 64
941:             .InputMask         = "99999.999"
942:             .Header1.Alignment = 2
943:             .Header1.Caption   = "Qtd."
944:         ENDWITH
945: 
946:         *-- Column5: PESO
947:         WITH THIS.grd_4c_Dados.Column5
948:             .ControlSource     = "cursor_4c_Itens.pesos"
949:             .Width             = 60
950:             .InputMask         = "99999.999"
951:             .Header1.Alignment = 2
952:             .Header1.Caption   = "Peso"
953:         ENDWITH
954: 
955:         *-- Column6: VALOR
956:         WITH THIS.grd_4c_Dados.Column6
957:             .ControlSource     = "cursor_4c_Itens.units"
958:             .Width             = 90
959:             .InputMask         = "99999999.99"
960:             .Header1.Alignment = 2
961:             .Header1.Caption   = "Valor"
962:         ENDWITH
963: 
964:         *-- Column7: MOEDA
965:         WITH THIS.grd_4c_Dados.Column7
966:             .ControlSource     = "cursor_4c_Itens.moedas"
967:             .Width             = 24
968:             .Header1.Alignment = 2
969:             .Header1.Caption   = "Moe"
970:         ENDWITH
971: 
972:         *-- Column8: TOTAL
973:         WITH THIS.grd_4c_Dados.Column8
974:             .ControlSource     = "cursor_4c_Itens.totas"
975:             .Width             = 107
976:             .InputMask         = "9999999999.99"
977:             .Header1.Alignment = 2
978:             .Header1.Caption   = "Total"
979:         ENDWITH
980: 
981:         *-- Column9: pesotot
982:         WITH THIS.grd_4c_Dados.Column9
983:             .ControlSource     = "cursor_4c_Itens.tpesos"
984:             .Width             = 64
985:             .InputMask         = "9999999.99"
986:             .Header1.Alignment = 2
987:             .Header1.Caption   = "Total Peso"
988:         ENDWITH
989: 
990:         *-- Column10: item (numero sequencial, sem legenda no legado)
991:         WITH THIS.grd_4c_Dados.Column10
992:             .ControlSource     = "cursor_4c_Itens.citens"
993:             .Width             = 31
994:             .InputMask         = "9999"
995:             .Header1.Caption   = ""
996:         ENDWITH
997: 
998:         *-- Column11: UNIDADE
999:         WITH THIS.grd_4c_Dados.Column11
1000:             .ControlSource     = "cursor_4c_Itens.cunis"
1001:             .Width             = 30
1002:             .Header1.Alignment = 2
1003:             .Header1.Caption   = "Uni"
1004:         ENDWITH
1005: 
1006:         *-- Column12: UNIPESO (desabilitada, igual ao legado)
1007:         WITH THIS.grd_4c_Dados.Column12
1008:             .ControlSource     = "cursor_4c_Itens.cunips"
1009:             .Width             = 31
1010:             .Enabled           = .F.
1011:             .Header1.Alignment = 2
1012:             .Header1.Caption   = "Uni"
1013:         ENDWITH
1014: 
1015:         *-- Column13: PEDIDO
1016:         WITH THIS.grd_4c_Dados.Column13
1017:             .ControlSource     = "cursor_4c_Itens.abrevis"
1018:             .Width             = 40
1019:             .Header1.Alignment = 2
1020:             .Header1.Caption   = "Ped"
1021:         ENDWITH
1022: 
1023:         *-- Column14: DESCRS
1024:         WITH THIS.grd_4c_Dados.Column14
1025:             .ControlSource     = "cursor_4c_Itens.dpros"
1026:             .Width             = 290
1027:             .Header1.Alignment = 2
1028:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1029:         ENDWITH
1030: 
1031:         *-- Column15: cor
1032:         WITH THIS.grd_4c_Dados.Column15
1033:             .ControlSource     = "cursor_4c_Itens.codcors"
1034:             .Width             = 24
1035:             .Header1.Alignment = 2
1036:             .Header1.Caption   = "Cor"
1037:         ENDWITH
1038: 
1039:         *-- Column16: Local
1040:         WITH THIS.grd_4c_Dados.Column16
1041:             .ControlSource     = "cursor_4c_Itens.locals"
1042:             .Width             = 80
1043:             .Header1.Alignment = 2
1044:             .Header1.Caption   = "Local"
1045:         ENDWITH
1046: 
1047:         *-- Column17: Comprimento
1048:         WITH THIS.grd_4c_Dados.Column17
1049:             .ControlSource     = "cursor_4c_Itens.compris"
1050:             .Width             = 50
1051:             .InputMask         = "9999.99"
1052:             .Header1.Alignment = 2
1053:             .Header1.Caption   = "Compr."
1054:         ENDWITH
1055: 
1056:         *-- Column18: LocalO
1057:         WITH THIS.grd_4c_Dados.Column18
1058:             .ControlSource     = "cursor_4c_Itens.localos"
1059:             .Width             = 80
1060:             .Header1.Alignment = 2
1061:             .Header1.Caption   = "Local Ori"
1062:         ENDWITH
1063: 
1064:         *-- Column19: Tamanho
1065:         WITH THIS.grd_4c_Dados.Column19
1066:             .ControlSource     = "cursor_4c_Itens.codtams"
1067:             .Width             = 35
1068:             .Header1.Alignment = 2
1069:             .Header1.Caption   = "Tam."
1070:         ENDWITH
1071: 
1072:         *-- Column20: Reserva (ReadOnly, igual ao legado)
1073:         WITH THIS.grd_4c_Dados.Column20
1074:             .ControlSource     = "cursor_4c_Itens.qtreservas"
1075:             .Width             = 64
1076:             .ReadOnly          = .T.
1077:             .InputMask         = "999999.999"
1078:             .Header1.Alignment = 2
1079:             .Header1.Caption   = "Reserva"
1080:         ENDWITH
1081: 
1082:         *-- Column21 (Presente) e Column22 (O.S.): CheckBox de coluna.
1083:         *-- Aqui so o BIND e a largura/header. O AddObject do CheckBox roda
1084:         *-- DEPOIS, em InstalarCheckBoxesGrade(), porque Column.AddObject de
1085:         *-- CheckBox ESTOURA enquanto a coluna estiver ligada (pelo auto-bind
1086:         *-- do RecordSource) a um campo de outro tipo: com ColumnCount = 22 o
1087:         *-- VFP liga Column22 ao 22o campo do cursor, que eh codcors C(4), e
1088:         *-- adicionar um controle numerico ali da
1089:         *-- "Error with CHK_4C_SERVICO - Value : Data type mismatch."
1090:         *-- A falha eh TOTAL e MUDA: cai no TRY do InicializarForm, que
1091:         *-- devolve .F., CREATEOBJECT devolve o logico .F. e a tela
1092:         *-- simplesmente nao abre - sem erro na tela e sem log.
1093:         WITH THIS.grd_4c_Dados.Column21
1094:             .ControlSource     = "cursor_4c_Itens.ckpresente"
1095:             .Width             = 50
1096:             .Header1.Alignment = 2
1097:             .Header1.Caption   = "Presente"
1098:         ENDWITH
1099: 
1100:         WITH THIS.grd_4c_Dados.Column22
1101:             .ControlSource     = "cursor_4c_Itens.servicos"
1102:             .Width             = 50
1103:             .Header1.Alignment = 2
1104:             .Header1.Caption   = "O.S."
1105:         ENDWITH
1106: 
1107:         *-- Todas as colunas ja estao bindadas: agora os CheckBox.
1108:         THIS.InstalarCheckBoxesGrade()
1109:     ENDPROC
1110: 
1111:     *==========================================================================
1112:     * InstalarCheckBoxesGrade - Instala os CheckBox das colunas Presente e
1113:     * O.S. na ordem que o VFP9 exige (medido): ColumnCount -> RecordSource ->
1114:     * ControlSource de TODAS as colunas -> Column.AddObject + Value ->
1115:     * Sparse + CurrentControl. Invertido, o AddObject estoura por causa do
1116:     * auto-bind do RecordSource (ver comentario em ConfigurarGridDados).
1117:     *
1118:     * IDEMPOTENTE e vive no funil: reatribuir RecordSource/ColumnCount ou
1119:     * fechar o alias destroi os objetos postos na Column, entao a instalacao
1120:     * tem de poder rodar de novo sem duplicar o AddObject.
1121:     *==========================================================================
1122:     PROTECTED PROCEDURE InstalarCheckBoxesGrade()
1123:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1124:             RETURN
1125:         ENDIF
1126: 
1127:         IF THIS.grd_4c_Dados.ColumnCount < 22
1128:             RETURN
1129:         ENDIF

*-- Linhas 1810 a 1832:
1810:     * chamado de fora (TesteAutomatico / form pai) e pelo funil de recarga.
1811:     *
1812:     * Equivale ao AddCursor('SigMvItn', ...) que o legado herda do form pai
1813:     * de Movimentacao (crTpmMvItn) seguido de "Select crTpmMvItn / Goto Top"
1814:     * no fim do Init.
1815:     *
1816:     * O BO le para um cursor TEMPORARIO e aqui o alias da grade eh recarregado
1817:     * com SELECT/ZAP/APPEND FROM DBF(): SQLEXEC direto sobre o alias ligado ao
1818:     * Grid o FECHA e RECRIA, zerando o ColumnCount - a grade viraria um
1819:     * retangulo branco sem cabecalho, sem erro e sem log.
1820:     *==========================================================================
1821:     PROCEDURE CarregarDados()
1822:         LOCAL loc_lSucesso, loc_cChave, loc_oErro
1823: 
1824:         loc_lSucesso = .F.
1825: 
1826:         IF !USED("cursor_4c_Itens")
1827:             THIS.CriarCursorItens()
1828:         ENDIF
1829: 
1830:         loc_cChave = THIS.ObterChaveMovimentacao()
1831: 
1832:         IF EMPTY(loc_cChave)

*-- Linhas 1842 a 1861:
1842:             IF THIS.this_oBusinessObject.CarregarItens(loc_cChave, "cursor_4c_ItensTmp")
1843:                 THIS.ZaparCursorItens()
1844:                 IF USED("cursor_4c_ItensTmp")
1845:                     SELECT cursor_4c_Itens
1846:                     APPEND FROM DBF("cursor_4c_ItensTmp")
1847:                 ENDIF
1848:                 loc_lSucesso = .T.
1849:             ENDIF
1850: 
1851:             IF USED("cursor_4c_ItensTmp")
1852:                 USE IN cursor_4c_ItensTmp
1853:             ENDIF
1854: 
1855:         CATCH TO loc_oErro
1856:             THIS.this_cMensagemErro = loc_oErro.Message
1857:             MsgErro("Erro ao carregar os itens da movimenta" + CHR(231) + CHR(227) + ;
1858:                     "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1859:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1860:                     "Proc: " + loc_oErro.Procedure, "Erro CarregarDados")
1861:         ENDTRY

*-- Linhas 1876 a 1971:
1876:     * PrepararLinhaInicial - Fecho do Init legado, que em INSERIR/ALTERAR
1877:     * entrega uma linha em branco pronta para digitacao:
1878:     *
1879:     *   Select crTpmMvItn / Set Order To
1880:     *   If Thisform.Op_Escolha = 'ALTERAR' Or crSigCdOpe.SubnObrigs = 3
1881:     *       Count To lnCount / Thisform.CItem = lnCount / Thisform.minserelinha()
1882:     *   Else
1883:     *       If Thisform.Op_Escolha = 'INSERIR'
1884:     *           Count To lnCount / Thisform.CItem = lnCount / minserelinha()
1885:     *       Endif
1886:     *   Endif
1887:     *
1888:     * Em CONSULTAR/EXCLUIR o legado NAO entrega linha nova (a grade abre so
1889:     * com o que foi gravado), e o mesmo vale aqui.
1890:     *==========================================================================
1891:     PROTECTED PROCEDURE PrepararLinhaInicial()
1892:         LOCAL loc_nRegistros
1893: 
1894:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
1895:             RETURN .F.
1896:         ENDIF
1897: 
1898:         IF !USED("cursor_4c_Itens")
1899:             RETURN .F.
1900:         ENDIF
1901: 
1902:         SELECT cursor_4c_Itens
1903:         COUNT TO loc_nRegistros
1904:         THIS.this_nCItem = loc_nRegistros
1905: 
1906:         RETURN THIS.InserirLinhaGrade()
1907:     ENDPROC
1908: 
1909:     *==========================================================================
1910:     * RepintarGradeItens - FUNIL UNICO de repintura da grade. Popular o cursor
1911:     * NAO faz a grade exibir as linhas (regra #21): o legado sempre fecha com
1912:     * "Go Top In crTpmMvItn" + "fwGrade.Refresh". Tem de rodar em TODO caminho
1913:     * que mexe no cursor (carga, exclusao de linha, troca de modo) e DEPOIS de
1914:     * trocar o ActivePage - Refresh em pagina oculta nao pinta.
1915:     *==========================================================================
1916:     PROCEDURE RepintarGradeItens()
1917:         IF !USED("cursor_4c_Itens")
1918:             RETURN
1919:         ENDIF
1920: 
1921:         SELECT cursor_4c_Itens
1922:         GO TOP
1923: 
1924:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1925:             *-- Reinstala os CheckBox de coluna antes de repintar: se algo
1926:             *-- tiver reatribuido RecordSource/ColumnCount ou fechado o
1927:             *-- alias, os objetos postos nas Columns foram destruidos. A
1928:             *-- instalacao eh idempotente.
1929:             THIS.InstalarCheckBoxesGrade()
1930:             THIS.grd_4c_Dados.Refresh()
1931:         ENDIF
1932:     ENDPROC
1933: 
1934:     *==========================================================================
1935:     * ZaparCursorItens - ZAP guardado por SAFETY. SET SAFETY eh escopado por
1936:     * DATA SESSION: este form eh DataSession = 2, e na sessao privada SAFETY
1937:     * vale ON mesmo com o SET SAFETY OFF do main.prg. Com SAFETY ON o ZAP
1938:     * abre o dialogo modal "Zap ... Are you sure?" e CONGELA a tela,
1939:     * esperando um clique que ninguem ve (nao eh erro: em teste headless
1940:     * aparece como timeout sem resultado).
1941:     *
1942:     * ZAP eh a escolha CERTA aqui (o legado faz "Zap In <cursor>"): preserva
1943:     * a estrutura e o binding do Grid. Fechar e recriar o alias derrubaria
1944:     * RecordSource/ControlSource e a grade ficaria vazia com o cursor cheio.
1945:     *==========================================================================
1946:     PROTECTED PROCEDURE ZaparCursorItens()
1947:         LOCAL loc_cSafety
1948: 
1949:         IF !USED("cursor_4c_Itens")
1950:             RETURN
1951:         ENDIF
1952: 
1953:         loc_cSafety = SET("SAFETY")
1954:         SET SAFETY OFF
1955: 
1956:         SELECT cursor_4c_Itens
1957:         ZAP
1958: 
1959:         IF loc_cSafety = "ON"
1960:             SET SAFETY ON
1961:         ENDIF
1962:     ENDPROC
1963: 
1964:     *==========================================================================
1965:     * AplicarModoNaGrade - Espelha o par fwGrade/fwGradeR do legado. No legado sao
1966:     * duas grades mutuamente exclusivas sobre o MESMO cursor, e o proprio
1967:     * legado alinha a segunda na posicao da primeira (".Left = fwGrade.Left /
1968:     * .Top = fwGrade.Top / .Height = fwGrade.Height"), isto eh: visualmente
1969:     * eh UMA grade que alterna entre editavel e somente-leitura.
1970:     *
1971:     * Legado: fwGrade  (editavel)      -> INSERIR, ou ALTERAR com AltEtiqs # 1

*-- Linhas 2024 a 2085:
2024:     * INSERIR ou ALTERAR) e a cada vez que o usuario termina uma linha.
2025:     *
2026:     * Legado:
2027:     *   Select crTpmMvItn / Set Order to CPros / Count to wRegistros
2028:     *   Seek Space(14)                       && procura linha com produto vazio
2029:     *   If Not Eof()                         && achou: nao insere, so desce
2030:     *       If Not ThisForm.lAutPreco / keyboard "{DNARROW}" / EndIf
2031:     *   Else
2032:     *       If wRegistros < crSigCdOpe.qtdites
2033:     *           ThisForm.CItem = ThisForm.CItem + 1
2034:     *           Insert Into crTpmMvItn( Emps, Dopes, Numes, Citens ) Values (...)
2035:     *       EndIf
2036:     *   EndIf
2037:     *   ThisForm.OldCodBarras = 0 / AntCPro = Space(14) / AntValu = Space(3)
2038:     *
2039:     * O cursor migrado nao tem a tag CPros do legado, entao a procura da linha
2040:     * em branco eh LOCATE FOR EMPTY(cpros) - mesmo efeito do Seek Space(14).
2041:     * O "keyboard {DNARROW}" do legado era a forma de levar o foco da grade
2042:     * para a linha nova; aqui o equivalente eh posicionar o cursor nela e
2043:     * repintar, porque a navegacao nao depende da fila de teclado.
2044:     *
2045:     * PUBLIC: o form pai e o harness de teste chamam de fora.
2046:     *==========================================================================
2047:     PROCEDURE InserirLinhaGrade()
2048:         LOCAL loc_nRegistros, loc_lTemLimite, loc_lInseriu
2049: 
2050:         IF !USED("cursor_4c_Itens")
2051:             RETURN .F.
2052:         ENDIF
2053: 
2054:         loc_lInseriu = .F.
2055: 
2056:         SELECT cursor_4c_Itens
2057:         COUNT TO loc_nRegistros
2058: 
2059:         LOCATE FOR EMPTY(cpros)
2060: 
2061:         IF !FOUND()
2062:             *-- Nenhuma linha em branco na grade: entrega uma nova, respeitando
2063:             *-- o teto de itens da operacao quando ele existe (legado:
2064:             *-- "If wRegistros < crSigCdOpe.qtdites").
2065:             loc_lTemLimite = (THIS.this_nQtdItes > 0)
2066: 
2067:             IF !loc_lTemLimite OR loc_nRegistros < THIS.this_nQtdItes
2068:                 THIS.this_nCItem = THIS.this_nCItem + 1
2069: 
2070:                 INSERT INTO cursor_4c_Itens (emps, dopes, numes, citens, empdopnums) ;
2071:                     VALUES (PADR(THIS.this_cEmps, 3), PADR(THIS.this_cDopes, 20), ;
2072:                             THIS.this_nNumes, THIS.this_nCItem, ;
2073:                             THIS.ObterChaveMovimentacao())
2074: 
2075:                 loc_lInseriu = .T.
2076:             ENDIF
2077:         ENDIF
2078: 
2079:         *-- Em qualquer um dos dois caminhos a linha corrente passa a ser a de
2080:         *-- digitacao (a que estava em branco, ou a recem-inserida).
2081:         THIS.RepintarGradeItens()
2082:         THIS.AjustarBotoesPorModo()
2083: 
2084:         RETURN loc_lInseriu
2085:     ENDPROC

*-- Linhas 2105 a 2218:
2105:             RETURN .F.
2106:         ENDIF
2107: 
2108:         SELECT cursor_4c_Itens
2109:         loc_nCitens = cursor_4c_Itens.citens
2110: 
2111:         REPLACE cpros      WITH "", ;
2112:                 dpros      WITH "", ;
2113:                 obs        WITH "", ;
2114:                 codbarras  WITH 0, ;
2115:                 utilizas   WITH 0, ;
2116:                 numeronota WITH "", ;
2117:                 notas      WITH ""
2118: 
2119:         REPLACE qtds    WITH 0, ;
2120:                 pesos   WITH 0, ;
2121:                 compris WITH 0, ;
2122:                 fators  WITH 0, ;
2123:                 tpesos  WITH 0, ;
2124:                 units   WITH 0, ;
2125:                 moedas  WITH "", ;
2126:                 totas   WITH 0
2127: 
2128:         *-- Sub-itens da linha (composicao): no legado moram em crTpmMvIts e
2129:         *-- aqui convivem no mesmo cursor, apontando o pai por citem2.
2130:         DELETE FOR citem2 = loc_nCitens AND citens <> loc_nCitens
2131: 
2132:         *-- Volta a posicionar na linha esvaziada (o DELETE FOR varre o cursor).
2133:         *-- LOCATE em vez de SEEK: nao depende de qual tag esta ativa, e a
2134:         *-- renumeracao de itens troca a ordem corrente durante o SCAN.
2135:         LOCATE FOR citens = loc_nCitens
2136:         IF !FOUND()
2137:             GO TOP
2138:         ENDIF
2139: 
2140:         THIS.RepintarGradeItens()
2141:         THIS.AjustarBotoesPorModo()
2142: 
2143:         RETURN .T.
2144:     ENDPROC
2145: 
2146:     *==========================================================================
2147:     * ExcluirLinhaGrade - Equivale a PROCEDURE deletaritem do legado, que eh o
2148:     * "Excluir" desta tela: exclusao de LINHA da grade de itens (o registro em
2149:     * SigMvItn so eh gravado/removido pelo form pai de Movimentacao, na
2150:     * confirmacao da operacao).
2151:     *
2152:     * Legado (deletaritem):
2153:     *   If !IsEmpty(crTpmMvItn.cpros)
2154:     *       _CItem = CItens / Delete / apaga os sub-itens de cItem2 = _CItem
2155:     *       Delete For cItem2 = _CItem
2156:     *   Else
2157:     *       Select Count(1) From crTpmMvItn Where IsEmpty(cpros) ... xApaga
2158:     *       If xApaga.Total > 1 / Delete / Else / Thisform.ApaIte() / EndIf
2159:     *   EndIf
2160:     *   Select crTpmMvItn / Go Top
2161:     *
2162:     * Isto eh: linha COM produto sai da grade junto com a composicao dela;
2163:     * linha SEM produto so sai se houver outra em branco - se for a unica, ela
2164:     * eh apenas esvaziada, para a grade nunca ficar sem linha de digitacao.
2165:     *
2166:     * PUBLIC: o form pai e o harness de teste chamam de fora.
2167:     *==========================================================================
2168:     PROCEDURE ExcluirLinhaGrade()
2169:         LOCAL loc_nCitens, loc_nEmBranco, loc_nRecno
2170: 
2171:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
2172:             RETURN .F.
2173:         ENDIF
2174: 
2175:         SELECT cursor_4c_Itens
2176: 
2177:         IF EMPTY(cursor_4c_Itens.cpros)
2178:             *-- COUNT varre o cursor e deixa o ponteiro em EOF: sem repor o
2179:             *-- RECNO, o DELETE abaixo cairia no registro fantasma do fim e
2180:             *-- nao apagaria linha nenhuma (sem erro e sem aviso).
2181:             loc_nRecno = RECNO()
2182:             COUNT FOR EMPTY(cpros) TO loc_nEmBranco
2183:             IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
2184:                 GO loc_nRecno
2185:             ENDIF
2186: 
2187:             IF loc_nEmBranco > 1
2188:                 DELETE
2189:             ELSE
2190:                 *-- Unica linha em branco: esvazia em vez de remover
2191:                 THIS.LimparLinhaGrade()
2192:                 RETURN .T.
2193:             ENDIF
2194:         ELSE
2195:             loc_nCitens = cursor_4c_Itens.citens
2196: 
2197:             DELETE
2198: 
2199:             *-- Composicao da linha excluida (legado: Delete For cItem2 = _CItem)
2200:             DELETE FOR citem2 = loc_nCitens AND citens <> loc_nCitens
2201:         ENDIF
2202: 
2203:         SELECT cursor_4c_Itens
2204:         GO TOP
2205: 
2206:         RETURN .T.
2207:     ENDPROC
2208: 
2209:     *==========================================================================
2210:     * RenumerarItensGrade - Equivale ao bloco de renumeracao do btnPApaga.Click
2211:     * do legado, que roda SEMPRE depois de excluir uma linha: as linhas que
2212:     * sobraram recebem citens 1..N em sequencia, e as referencias de
2213:     * composicao (cItem2) acompanham, senao o pai de uma composicao passa a
2214:     * apontar para item que nao existe mais.
2215:     *
2216:     * Legado: Set Order To CItens / Go Top / Cont = 0 / Scan / Cont = Cont + 1
2217:     *         ... Replace cItem2 With Cont For cItem2 = _cIt ... Replace CItens
2218:     *         With Cont / EndScan / Thisform.CItem = Cont

*-- Linhas 2226 a 2244:
2226: 
2227:         loc_nCont = 0
2228: 
2229:         SELECT cursor_4c_Itens
2230:         SET ORDER TO
2231:         GO TOP
2232: 
2233:         SCAN
2234:             loc_nCont      = loc_nCont + 1
2235:             loc_nCitensAnt = cursor_4c_Itens.citens
2236:             loc_nRecno     = RECNO()
2237: 
2238:             *-- Primeiro as referencias da composicao, depois o proprio item:
2239:             *-- invertido, o Replace de cItem2 nao encontraria mais o valor
2240:             *-- antigo para casar.
2241:             REPLACE citem2 WITH loc_nCont FOR citem2 = loc_nCitensAnt
2242: 
2243:             GO loc_nRecno
2244:             REPLACE citens WITH loc_nCont

*-- Linhas 2252 a 2291:
2252:     ENDPROC
2253: 
2254:     *==========================================================================
2255:     * GarantirLinhaDeDigitacao - Equivale ao "If Eof() / Insert Into
2256:     * crTpmMvItn(...) Values (..., 1)" que o legado faz no btnPApaga.Click
2257:     * depois de excluir: se a grade ficou sem nenhuma linha, entrega uma nova
2258:     * para o usuario continuar digitando.
2259:     *==========================================================================
2260:     PROCEDURE GarantirLinhaDeDigitacao()
2261:         LOCAL loc_nRegistros
2262: 
2263:         IF !USED("cursor_4c_Itens")
2264:             RETURN .F.
2265:         ENDIF
2266: 
2267:         SELECT cursor_4c_Itens
2268:         COUNT TO loc_nRegistros
2269: 
2270:         IF loc_nRegistros > 0
2271:             RETURN .F.
2272:         ENDIF
2273: 
2274:         THIS.this_nCItem = 1
2275: 
2276:         INSERT INTO cursor_4c_Itens (emps, dopes, numes, citens, empdopnums) ;
2277:             VALUES (PADR(THIS.this_cEmps, 3), PADR(THIS.this_cDopes, 20), ;
2278:                     THIS.this_nNumes, 1, THIS.ObterChaveMovimentacao())
2279: 
2280:         RETURN .T.
2281:     ENDPROC
2282: 
2283:     *==========================================================================
2284:     * TotalizarLinha - Equivale a PROCEDURE total_item do legado:
2285:     *
2286:     *   parameters pMantVal
2287:     *   =ThisForm.ParentForm.Calc_ValIte(,,pMantVal)
2288:     *   ThisForm.fwGrade.Refresh
2289:     *
2290:     * A aritmetica do total do item (unitario x quantidade, fator, moeda,
2291:     * descontos e impostos) eh regra de negocio que mora no Calc_ValIte do

*-- Linhas 2336 a 2400:
2336:     * mesmo comportamento vale aqui. A checagem de consistencia entre item e
2337:     * composicao eh INCONDICIONAL no legado e eh a que roda aqui:
2338:     *
2339:     *   Select a.* From crTpmMvIts a, crTpmMvItn b Where a.citens = b.citens
2340:     *       And a.CPros <> b.CPros Into Cursor ChecItem
2341:     *   If Reccount() > 0 / lcMsg = 'Problema de inconsistencia com o Item '
2342:     *       + Str(ChecItem.citens,4) + ' Produto:' + ChecItem.CPros
2343:     *
2344:     * Devolve .T. quando os itens estao consistentes.
2345:     *==========================================================================
2346:     PROCEDURE ValidarItensAntesDeSair()
2347:         LOCAL loc_lOk, loc_cMsg, loc_cTitulo, loc_nRecno
2348: 
2349:         loc_lOk     = .T.
2350:         loc_cMsg    = ""
2351:         loc_cTitulo = "Inconsistencia dos Itens"
2352: 
2353:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2354:             RETURN .T.
2355:         ENDIF
2356: 
2357:         IF !USED("cursor_4c_Itens")
2358:             RETURN .T.
2359:         ENDIF
2360: 
2361:         SELECT cursor_4c_Itens
2362:         loc_nRecno = RECNO()
2363: 
2364:         *-- Composicao (citem2 aponta o item pai) cujo produto divergiu do
2365:         *-- produto do pai: no legado sao duas tabelas (crTpmMvIts x
2366:         *-- crTpmMvItn) ligadas por citens; aqui convivem no mesmo cursor.
2367:         SELECT a.citens, a.cpros ;
2368:             FROM cursor_4c_Itens a, cursor_4c_Itens b ;
2369:             WHERE a.citem2 <> 0 ;
2370:               AND a.citem2 = b.citens ;
2371:               AND a.cpros <> b.cpros ;
2372:             INTO CURSOR cursor_4c_ChecaItem
2373: 
2374:         IF USED("cursor_4c_ChecaItem")
2375:             SELECT cursor_4c_ChecaItem
2376:             GO TOP
2377:             IF !EOF()
2378:                 loc_cMsg = "Problema de inconsistencia com o Item " + ;
2379:                            STR(cursor_4c_ChecaItem.citens, 4) + ;
2380:                            " Produto:" + ALLTRIM(cursor_4c_ChecaItem.cpros)
2381:             ENDIF
2382:             USE IN cursor_4c_ChecaItem
2383:         ENDIF
2384: 
2385:         SELECT cursor_4c_Itens
2386:         IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
2387:             GO loc_nRecno
2388:         ENDIF
2389: 
2390:         IF !EMPTY(loc_cMsg)
2391:             loc_lOk = .F.
2392:             MsgAviso(loc_cMsg, loc_cTitulo)
2393: 
2394:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Visible
2395:                 THIS.grd_4c_Dados.SetFocus()
2396:             ENDIF
2397:         ENDIF
2398: 
2399:         RETURN loc_lOk
2400:     ENDPROC

*-- Linhas 2612 a 2630:
2612:         THIS.GarantirLinhaDeDigitacao()
2613:         THIS.RenumerarItensGrade()
2614: 
2615:         SELECT cursor_4c_Itens
2616:         GO TOP
2617: 
2618:         THIS.RepintarGradeItens()
2619:         THIS.AjustarBotoesPorModo()
2620: 
2621:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Visible
2622:             THIS.grd_4c_Dados.SetFocus()
2623:         ENDIF
2624:     ENDPROC
2625: 
2626:     *-- "Carregar Composicao": Do Form SigSubCp (composicao do produto)
2627:     PROCEDURE BtnComposClick()
2628:         LOCAL loc_oForm, loc_oErro
2629:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") OR !THIS.TemProdutoSelecionado()
2630:             RETURN

*-- Linhas 2675 a 2694:
2675: 
2676:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro") AND USED("cursor_4c_Itens") ;
2677:                AND !EOF("cursor_4c_Itens")
2678:                 SELECT cursor_4c_BuscaPro
2679:                 SELECT cursor_4c_Itens
2680:                 REPLACE cpros WITH ALLTRIM(cursor_4c_BuscaPro.Cpros), ;
2681:                         dpros WITH ALLTRIM(cursor_4c_BuscaPro.Dpros)
2682:                 THIS.grd_4c_Dados.Refresh()
2683:             ENDIF
2684: 
2685:             loc_oBusca.Release()
2686:         ENDIF
2687: 
2688:         IF USED("cursor_4c_BuscaPro")
2689:             USE IN cursor_4c_BuscaPro
2690:         ENDIF
2691:     ENDPROC
2692: 
2693:     *-- "Informar Pedido": Do Form SigOpPed With ThisForm, DataSessionId
2694:     PROCEDURE BtnPedidoClick()

*-- Linhas 2842 a 2860:
2842:     * tamanho, com browse), get_prod / get_qtd (conferencia por codigo de
2843:     * barras) e getBusca (procura na grade).
2844:     *
2845:     * Os campos que SAO coluna de SigMvItn usam ControlSource sobre
2846:     * cursor_4c_Itens - exatamente o que o legado faz sobre crTpmMvItn - e por
2847:     * isso acompanham a linha corrente da grade sozinhos. Os de EXIBICAO
2848:     * (preco atual, grupo de venda, referencia, saldo, resta, peso medio) nao
2849:     * sao coluna do item: no legado o AfterRowColChange da grade os preenche a
2850:     * cada troca de linha, e aqui AtualizarPainelProduto() faz o mesmo.
2851:     *
2852:     * cnt_4c_Obs nasce Visible = .F. (painel flutuante da observacao, aberto
2853:     * pelo Click de obj_4c_GetObs) e por isso entra na lista de excecao de
2854:     * TornarControlesVisiveis / ReaplicarVisibilidadeInicial.
2855:     *==========================================================================
2856:     PROTECTED PROCEDURE ConfigurarPaginaProduto()
2857:         LOCAL loc_oPag
2858:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2859: 
2860:         *-- cnt_4c_Obs (cntObs no legado) - painel flutuante da observacao ---

*-- Linhas 2879 a 2897:
2879:             .FontName      = "Tahoma"
2880:             .FontSize      = 8
2881:             .SpecialEffect = 1
2882:             .ControlSource = "cursor_4c_Itens.obs"
2883:             .ToolTipText   = "Observa" + CHR(231) + CHR(227) + "o do Produto"
2884:             .Visible       = .T.
2885:         ENDWITH
2886: 
2887:         *-- shp_4c_Shape4 - moldura da area da imagem do produto -------------
2888:         loc_oPag.AddObject("shp_4c_Shape4", "Shape")
2889:         WITH loc_oPag.shp_4c_Shape4
2890:             .Top           = 2
2891:             .Left          = 2
2892:             .Width         = 192
2893:             .Height        = 167
2894:             .BackStyle     = 0
2895:             .BorderWidth   = 2
2896:             .SpecialEffect = 0
2897:             .Visible       = .T.

*-- Linhas 2939 a 2957:
2939:             .MaxLength         = 65
2940:             .Margin            = 2
2941:             .SpecialEffect     = 1
2942:             .ControlSource     = "cursor_4c_Itens.dpros"
2943:             .BackColor         = RGB(255, 255, 255)
2944:             .DisabledBackColor = RGB(255, 255, 255)
2945:             .DisabledForeColor = RGB(192, 192, 192)
2946:             .BorderColor       = RGB(90, 90, 90)
2947:             .ToolTipText       = "Descri" + CHR(231) + CHR(227) + "o do Produto"
2948:             .Visible           = .T.
2949:         ENDWITH
2950: 
2951:         *-- Preco atual (exibicao - vem de SigCdPro, nao eh coluna do item) --
2952:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
2953:         WITH loc_oPag.lbl_4c_Label1
2954:             .Top       = 72
2955:             .Left      = 202
2956:             .Width     = 60
2957:             .Height    = 15

*-- Linhas 3048 a 3066:
3048:             .FontSize      = 8
3049:             .Margin        = 2
3050:             .SpecialEffect = 1
3051:             .ControlSource = "cursor_4c_Itens.obs"
3052:             .NullDisplay   = " "
3053:             .BorderColor   = RGB(90, 90, 90)
3054:             .ToolTipText   = "Observa" + CHR(231) + CHR(227) + "o do Produto"
3055:             .Visible       = .T.
3056:         ENDWITH
3057: 
3058:         *-- Codigo de barras do item (somente leitura) -----------------------
3059:         loc_oPag.AddObject("lbl_4c_Label5", "Label")
3060:         WITH loc_oPag.lbl_4c_Label5
3061:             .Top       = 36
3062:             .Left      = 202
3063:             .Width     = 35
3064:             .Height    = 15
3065:             .Caption   = "Barra"
3066:             .FontName  = "Tahoma"

*-- Linhas 3084 a 3102:
3084:             .Margin            = 2
3085:             .ReadOnly          = .T.
3086:             .SpecialEffect     = 1
3087:             .ControlSource     = "cursor_4c_Itens.codbarras"
3088:             .DisabledBackColor = RGB(255, 255, 255)
3089:             .BorderColor       = RGB(90, 90, 90)
3090:             .ToolTipText       = "C" + CHR(243) + "digo de Barras do Produto"
3091:             .Visible           = .T.
3092:         ENDWITH
3093: 
3094:         *-- Documento (notas) ------------------------------------------------
3095:         loc_oPag.AddObject("lbl_4c_Label7", "Label")
3096:         WITH loc_oPag.lbl_4c_Label7
3097:             .Top       = 36
3098:             .Left      = 311
3099:             .Width     = 56
3100:             .Height    = 15
3101:             .Caption   = "Documento"
3102:             .FontName  = "Tahoma"

*-- Linhas 3121 a 3139:
3121:             .MaxLength         = 6
3122:             .Margin            = 2
3123:             .SpecialEffect     = 1
3124:             .ControlSource     = "cursor_4c_Itens.notas"
3125:             .DisabledBackColor = RGB(255, 255, 255)
3126:             .BorderColor       = RGB(90, 90, 90)
3127:             .ToolTipText       = "Documento do Produto"
3128:             .Visible           = .T.
3129:         ENDWITH
3130: 
3131:         *-- Numero do lote ---------------------------------------------------
3132:         loc_oPag.AddObject("lbl_4c_Label8", "Label")
3133:         WITH loc_oPag.lbl_4c_Label8
3134:             .Top       = 36
3135:             .Left      = 380
3136:             .Width     = 63
3137:             .Height    = 15
3138:             .Caption   = "N" + CHR(250) + "mero Lote"
3139:             .FontName  = "Tahoma"

*-- Linhas 3158 a 3195:
3158:             .MaxLength         = 10
3159:             .Margin            = 2
3160:             .SpecialEffect     = 1
3161:             .ControlSource     = "cursor_4c_Itens.nlotes"
3162:             .DisabledBackColor = RGB(255, 255, 255)
3163:             .BorderColor       = RGB(90, 90, 90)
3164:             .ToolTipText       = "N" + CHR(250) + "mero do Lote"
3165:             .Visible           = .T.
3166:         ENDWITH
3167: 
3168:         *-- Moeda do preco atual ---------------------------------------------
3169:         loc_oPag.AddObject("txt_4c_MoeVs", "TextBox")
3170:         WITH loc_oPag.txt_4c_MoeVs
3171:             .Top               = 84
3172:             .Left              = 303
3173:             .Width             = 31
3174:             .Height            = 21
3175:             .FontName          = "Tahoma"
3176:             .FontSize          = 8
3177:             .MaxLength         = 3
3178:             .Margin            = 2
3179:             .SpecialEffect     = 1
3180:             .ControlSource     = "cursor_4c_Itens.moevs"
3181:             .ForeColor         = RGB(90, 90, 90)
3182:             .BackColor         = RGB(255, 255, 255)
3183:             .DisabledBackColor = RGB(255, 255, 255)
3184:             .DisabledForeColor = RGB(192, 192, 192)
3185:             .BorderColor       = RGB(90, 90, 90)
3186:             .ToolTipText       = "Moeda do Pre" + CHR(231) + "o Atual"
3187:             .Visible           = .T.
3188:         ENDWITH
3189: 
3190:         *-- Grupo de venda (exibicao) ----------------------------------------
3191:         loc_oPag.AddObject("lbl_4c_Label11", "Label")
3192:         WITH loc_oPag.lbl_4c_Label11
3193:             .Top       = 2
3194:             .Left      = 491
3195:             .Width     = 80

*-- Linhas 3254 a 3272:
3254:             .InputMask         = "999,999.99"
3255:             .Margin            = 2
3256:             .SpecialEffect     = 1
3257:             .ControlSource     = "cursor_4c_Itens.valdescs"
3258:             .DisabledBackColor = RGB(255, 255, 255)
3259:             .BorderColor       = RGB(90, 90, 90)
3260:             .ToolTipText       = "Valor do Desconto"
3261:             .Visible           = .T.
3262:         ENDWITH
3263: 
3264:         *-- Desconto em percentual -------------------------------------------
3265:         loc_oPag.AddObject("lbl_4c_LblPDescs", "Label")
3266:         WITH loc_oPag.lbl_4c_LblPDescs
3267:             .Top       = 72
3268:             .Left      = 581
3269:             .Width     = 61
3270:             .Height    = 15
3271:             .Caption   = "% Desconto"
3272:             .FontName  = "Tahoma"

*-- Linhas 3291 a 3309:
3291:             .InputMask         = "999.99"
3292:             .Margin            = 2
3293:             .SpecialEffect     = 1
3294:             .ControlSource     = "cursor_4c_Itens.pdescs"
3295:             .DisabledBackColor = RGB(255, 255, 255)
3296:             .BorderColor       = RGB(90, 90, 90)
3297:             .ToolTipText       = "Percentual do Desconto"
3298:             .Visible           = .T.
3299:         ENDWITH
3300: 
3301:         *-- Observacoes do pedido (exibicao) ---------------------------------
3302:         loc_oPag.AddObject("obj_4c_GetObsPes", "EditBox")
3303:         WITH loc_oPag.obj_4c_GetObsPes
3304:             .Top           = 107
3305:             .Left          = 202
3306:             .Width         = 200
3307:             .Height        = 21
3308:             .FontName      = "Courier New"
3309:             .FontSize      = 8

*-- Linhas 3362 a 3380:
3362:             .MaxLength     = 4
3363:             .Margin        = 2
3364:             .SpecialEffect = 1
3365:             .ControlSource = "cursor_4c_Itens.codcors"
3366:             .BorderColor   = RGB(90, 90, 90)
3367:             .ToolTipText   = "Cor do Produto"
3368:             .Visible       = .F.
3369:         ENDWITH
3370: 
3371:         loc_oPag.AddObject("lbl_4c_LblCodTams", "Label")
3372:         WITH loc_oPag.lbl_4c_LblCodTams
3373:             .Top       = 2
3374:             .Left      = 790
3375:             .Width     = 22
3376:             .Height    = 15
3377:             .Caption   = "Tam"
3378:             .FontName  = "Tahoma"
3379:             .FontSize  = 8
3380:             .AutoSize  = .F.

*-- Linhas 3396 a 3414:
3396:             .MaxLength     = 4
3397:             .Margin        = 2
3398:             .SpecialEffect = 1
3399:             .ControlSource = "cursor_4c_Itens.codtams"
3400:             .BorderColor   = RGB(90, 90, 90)
3401:             .ToolTipText   = "Tamanho do Produto"
3402:             .Visible       = .F.
3403:         ENDWITH
3404: 
3405:         *-- cnt_4c_Reffs - referencia do fornecedor (exibicao) ---------------
3406:         loc_oPag.AddObject("cnt_4c_Reffs", "Container")
3407:         WITH loc_oPag.cnt_4c_Reffs
3408:             .Top         = 66
3409:             .Left        = 332
3410:             .Width       = 154
3411:             .Height      = 41
3412:             .BackStyle   = 0
3413:             .BorderWidth = 0
3414:             .BorderColor = RGB(36, 84, 155)

*-- Linhas 3516 a 3534:
3516:             .Margin        = 2
3517:             .ReadOnly      = .T.
3518:             .SpecialEffect = 1
3519:             .ControlSource = "cursor_4c_Itens.qtbaixas"
3520:             .BorderColor   = RGB(90, 90, 90)
3521:             .ToolTipText   = "Quantidade Baixada"
3522:             .Visible       = .T.
3523:         ENDWITH
3524: 
3525:         loc_oPag.AddObject("lbl_4c_Label9", "Label")
3526:         WITH loc_oPag.lbl_4c_Label9
3527:             .Top       = 112
3528:             .Left      = 729
3529:             .Width     = 35
3530:             .Height    = 15
3531:             .Caption   = "Resta"
3532:             .FontName  = "Tahoma"
3533:             .FontSize  = 8
3534:             .AutoSize  = .F.

*-- Linhas 3772 a 3790:
3772:         *-- nao o item pai da composicao: no legado o preenchimento eh
3773:         *-- "getConjunts.Value = crTmpPro.Conjunts". Por isso fica em .Value
3774:         *-- (campo de EXIBICAO, alimentado por AtualizarPainelProduto) e NAO
3775:         *-- com ControlSource em citem2, que eh outra coisa.
3776:         loc_oPag.AddObject("txt_4c_Conjunts", "TextBox")
3777:         WITH loc_oPag.txt_4c_Conjunts
3778:             .Top               = 140
3779:             .Left              = 202
3780:             .Width             = 55
3781:             .Height            = 21
3782:             .FontName          = "Courier New"
3783:             .FontSize          = 8
3784:             .Alignment         = 3
3785:             .Value             = ""
3786:             .MaxLength         = 6
3787:             .Margin            = 2
3788:             .ReadOnly          = .T.
3789:             .SpecialEffect     = 1
3790:             .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 3859 a 3877:
3859:     * impostos (btnAltImps.Click faz "pgfPagina.pgFiscs.Enabled = .t."), e eh
3860:     * isso que HabilitarCampos reproduz.
3861:     *
3862:     * Os campos sao coluna de SigMvItn e por isso usam ControlSource sobre
3863:     * cursor_4c_Itens, acompanhando a linha corrente da grade. Os dois que NAO
3864:     * sao coluna do item (classificacao fiscal e a descricao dela, que vem de
3865:     * SigCdPro/SigCdClf) ficam em .Value e sao preenchidos por
3866:     * AtualizarPainelProduto(), como o AfterRowColChange do legado faz.
3867:     *==========================================================================
3868:     PROTECTED PROCEDURE ConfigurarPaginaFiscal()
3869:         LOCAL loc_oPag, loc_oCnt
3870:         loc_oPag = THIS.pgf_4c_Paginas.Page3
3871: 
3872:         loc_oPag.AddObject("cnt_4c_Item", "Container")
3873:         WITH loc_oPag.cnt_4c_Item
3874:             .Top           = -6
3875:             .Left          = 2
3876:             .Width         = 973
3877:             .Height        = 151

*-- Linhas 3914 a 3949:
3914:             .MaxLength     = 14
3915:             .ReadOnly      = .T.
3916:             .SpecialEffect = 1
3917:             .ControlSource = "cursor_4c_Itens.cpros"
3918:             .BackColor     = RGB(251, 254, 226)
3919:             .BorderColor   = RGB(90, 90, 90)
3920:             .Visible       = .T.
3921:         ENDWITH
3922: 
3923:         loc_oCnt.AddObject("txt_4c_FDPros", "TextBox")
3924:         WITH loc_oCnt.txt_4c_FDPros
3925:             .Top               = 21
3926:             .Left              = 119
3927:             .Width             = 303
3928:             .Height            = 21
3929:             .FontName          = "Courier New"
3930:             .FontSize          = 8
3931:             .MaxLength         = 65
3932:             .ReadOnly          = .T.
3933:             .SpecialEffect     = 1
3934:             .ControlSource     = "cursor_4c_Itens.dpros"
3935:             .BackColor         = RGB(251, 254, 226)
3936:             .DisabledBackColor = RGB(255, 255, 255)
3937:             .DisabledForeColor = RGB(192, 192, 192)
3938:             .BorderColor       = RGB(90, 90, 90)
3939:             .Visible           = .T.
3940:         ENDWITH
3941: 
3942:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFClFis", 7, 424, 100, ;
3943:                                   "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
3944: 
3945:         loc_oCnt.AddObject("txt_4c_FClFis", "TextBox")
3946:         WITH loc_oCnt.txt_4c_FClFis
3947:             .Top           = 21
3948:             .Left          = 424
3949:             .Width         = 89

*-- Linhas 3989 a 4007:
3989:             .FontName      = "Tahoma"
3990:             .FontSize      = 8
3991:             .SpecialEffect = 1
3992:             .ControlSource = "cursor_4c_Itens.ob2s"
3993:             .NullDisplay   = " "
3994:             .BorderColor   = RGB(90, 90, 90)
3995:             .ToolTipText   = "Observa" + CHR(231) + CHR(227) + "o 2"
3996:             .Visible       = .T.
3997:         ENDWITH
3998: 
3999:         *-- Linha 2: total, IPI, ICMS, ICMS-ST, situacao tributaria ----------
4000:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFTotal", 48, 10, 35, "Total")
4001:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FTotal", 61, 10, 112, ;
4002:                                     "999,999,999.99", "cursor_4c_Itens.totas")
4003: 
4004:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFPipis", 48, 124, 35, "%IPI")
4005:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FPipis", 61, 124, 48, ;
4006:                                     "99.99", "cursor_4c_Itens.aliqs")
4007: 

*-- Linhas 4039 a 4057:
4039:             .SpecialEffect = 1
4040:             *-- getSitTrI do legado le crTpmMvItn.SitTrIcms (NAO sitribs, que
4041:             *-- eh outra coluna da mesma tabela)
4042:             .ControlSource = "cursor_4c_Itens.sittricms"
4043:             .BackColor     = RGB(251, 254, 226)
4044:             .BorderColor   = RGB(90, 90, 90)
4045:             .Visible       = .T.
4046:         ENDWITH
4047: 
4048:         *-- Linha 3: bases de IPI / ICMS / ICMS-ST e CFOP --------------------
4049:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_VBipis", 84, 174, 97, ;
4050:                                     "9999,999.99", "cursor_4c_Itens.bcipis")
4051:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FBIcms", 84, 323, 98, ;
4052:                                     "9999,999.99", "cursor_4c_Itens.baseicms")
4053:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_FBIcsS", 84, 424, 96, ;
4054:                                     "9999,999.99", "cursor_4c_Itens.bcicmss")
4055: 
4056:         loc_oCnt.AddObject("txt_4c_Cfop", "TextBox")
4057:         WITH loc_oCnt.txt_4c_Cfop

*-- Linhas 4067 a 4085:
4067:             .MaxLength     = 10
4068:             .ReadOnly      = .T.
4069:             .SpecialEffect = 1
4070:             .ControlSource = "cursor_4c_Itens.cfops"
4071:             .BackColor     = RGB(251, 254, 226)
4072:             .BorderColor   = RGB(90, 90, 90)
4073:             .Visible       = .T.
4074:         ENDWITH
4075: 
4076:         *-- Linha 4: base de calculo, PIS, COFINS, ISS, IRRF, INSS, CSSL, II -
4077:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label5", 111, 13, 67, ;
4078:                                   "Base C" + CHR(225) + "lculos")
4079:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_VBc", 124, 10, 108, ;
4080:                                     "999,999,999.99", "cursor_4c_Itens.valbases")
4081: 
4082:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label6", 111, 124, 18, "PIS")
4083:         THIS.AdicionarTextBoxFiscal(loc_oCnt, "txt_4c_Vpis", 124, 121, 95, ;
4084:                                     "999,999.99", "cursor_4c_Itens.vpis")
4085: 

*-- Linhas 4125 a 4189:
4125:             .InputMask         = "999"
4126:             .MaxLength         = 3
4127:             .SpecialEffect     = 1
4128:             .ControlSource     = "cursor_4c_Itens.nadis"
4129:             .DisabledBackColor = RGB(255, 255, 255)
4130:             .BorderColor       = RGB(90, 90, 90)
4131:             .ToolTipText       = "Dado de Importa" + CHR(231) + CHR(227) + ;
4132:                                  "o - Numero da Adi" + CHR(231) + CHR(227) + "o"
4133:             .Visible           = .T.
4134:         ENDWITH
4135: 
4136:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label2", 69, 875, 59, ;
4137:                                   "Item Adi" + CHR(231) + CHR(227) + "o")
4138: 
4139:         loc_oCnt.AddObject("txt_4c_NIAdis", "TextBox")
4140:         WITH loc_oCnt.txt_4c_NIAdis
4141:             .Top               = 84
4142:             .Left              = 876
4143:             .Width             = 31
4144:             .Height            = 21
4145:             .FontName          = "Tahoma"
4146:             .FontSize          = 8
4147:             .Alignment         = 3
4148:             .InputMask         = "999"
4149:             .MaxLength         = 3
4150:             .SpecialEffect     = 1
4151:             .ControlSource     = "cursor_4c_Itens.niadis"
4152:             .DisabledBackColor = RGB(255, 255, 255)
4153:             .BorderColor       = RGB(90, 90, 90)
4154:             .ToolTipText       = "Dado de Importa" + CHR(231) + CHR(227) + ;
4155:                                  "o - Numero do item da Adi" + CHR(231) + CHR(227) + "o"
4156:             .Visible           = .T.
4157:         ENDWITH
4158: 
4159:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_Label3", 108, 806, 121, ;
4160:                                   "C Fabricante Estrangeiro")
4161: 
4162:         loc_oCnt.AddObject("txt_4c_Codfabs", "TextBox")
4163:         WITH loc_oCnt.txt_4c_Codfabs
4164:             .Top               = 123
4165:             .Left              = 806
4166:             .Width             = 155
4167:             .Height            = 21
4168:             .FontName          = "Tahoma"
4169:             .FontSize          = 8
4170:             .Alignment         = 0
4171:             .Format            = "!"
4172:             .MaxLength         = 6
4173:             .SpecialEffect     = 1
4174:             .ControlSource     = "cursor_4c_Itens.codfabs"
4175:             .DisabledBackColor = RGB(255, 255, 255)
4176:             .BorderColor       = RGB(90, 90, 90)
4177:             .ToolTipText       = "Dado de Importa" + CHR(231) + CHR(227) + ;
4178:                                  "o - C" + CHR(243) + "digo do Fabricante Estrangeiro"
4179:             .Visible           = .T.
4180:         ENDWITH
4181:     ENDPROC
4182: 
4183:     *==========================================================================
4184:     * AdicionarLabelFiscal - Fabrica dos rotulos de cnt_4c_Item. Todos os Say
4185:     * daquele container tem no dump a MESMA assinatura (Tahoma 8, FontBold
4186:     * = .F., BackStyle = 0, ForeColor = 90,90,90) e variam so em Top/Left/
4187:     * Width/Caption, entao repetir 20 blocos WITH identicos aqui so aumentaria
4188:     * a chance de um deles sair com propriedade faltando.
4189:     *

*-- Linhas 4237 a 4352:
4237:             .InputMask     = par_cMascara
4238:             .ReadOnly      = .T.
4239:             .SpecialEffect = 1
4240:             .ControlSource = par_cFonte
4241:             .BackColor     = RGB(251, 254, 226)
4242:             .BorderColor   = RGB(90, 90, 90)
4243:             .Visible       = .T.
4244:         ENDWITH
4245:     ENDPROC
4246: 
4247:     *==========================================================================
4248:     * CriarCursorPrecos - Cursor da grade de Precificacao (Page4). No legado a
4249:     * grdPrecos esta ligada a "lpitem", cursor da lista de precificacao que
4250:     * vive no data session do form PAI de Movimentacao; aqui ele eh local e eh
4251:     * populado por CarregarPrecos() a partir de SigOpLpi/SigOpLpr.
4252:     *
4253:     * Criado ANTES de ConfigurarPaginaPrecos porque Column.ControlSource de
4254:     * alias inexistente derruba o Init (regra #41).
4255:     *==========================================================================
4256:     PROTECTED PROCEDURE CriarCursorPrecos()
4257:         IF USED("cursor_4c_Precos")
4258:             USE IN cursor_4c_Precos
4259:         ENDIF
4260: 
4261:         SET NULL ON
4262:         CREATE CURSOR cursor_4c_Precos ( ;
4263:             lprecos C(30), tabds C(20), units N(11,2), moedas C(3))
4264:         SET NULL OFF
4265:     ENDPROC
4266: 
4267:     *==========================================================================
4268:     * ConfigurarPaginaPrecos - Page4 (pgPrecos no legado) "Precificacao".
4269:     *
4270:     * Grade grdPrecos: lista as precificacoes disponiveis para o produto do
4271:     * item corrente. Nasce Visible = .F. e ReadOnly = .T. no SCX legado (o
4272:     * proprio legado so a mostra quando a operacao trabalha com lista de
4273:     * precos), e por isso entra na lista de excecao de
4274:     * TornarControlesVisiveis / ReaplicarVisibilidadeInicial.
4275:     *
4276:     * Ordem de configuracao obrigatoria (regra #41 / Problema 48):
4277:     * ColumnCount -> RecordSource -> ControlSource -> Width -> Header.Caption.
4278:     *==========================================================================
4279:     PROTECTED PROCEDURE ConfigurarPaginaPrecos()
4280:         LOCAL loc_oPag, loc_oGrd
4281:         loc_oPag = THIS.pgf_4c_Paginas.Page4
4282: 
4283:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
4284:         loc_oGrd = loc_oPag.grd_4c_Dados
4285: 
4286:         WITH loc_oGrd
4287:             .Top                = 9
4288:             .Left               = 7
4289:             .Width              = 416
4290:             .Height             = 131
4291:             .ColumnCount        = 4
4292:             .DeleteMark         = .F.
4293:             .RecordMark         = .F.
4294:             .ScrollBars         = 2
4295:             .ReadOnly           = .T.
4296:             .AllowHeaderSizing  = .F.
4297:             .GridLineColor      = RGB(238, 238, 238)
4298:             .RecordSource       = "cursor_4c_Precos"
4299:             .Visible            = .F.
4300:         ENDWITH
4301: 
4302:         WITH loc_oGrd.Column1
4303:             .ControlSource   = "cursor_4c_Precos.lprecos"
4304:             .Width           = 210
4305:             .Movable         = .F.
4306:             .Resizable       = .F.
4307:             .ReadOnly        = .T.
4308:             .FontName        = "Courier New"
4309:             .Header1.Caption = "Lista de Precifica" + CHR(231) + CHR(227) + "o"
4310:             .Visible         = .T.
4311:         ENDWITH
4312: 
4313:         WITH loc_oGrd.Column2
4314:             .ControlSource   = "cursor_4c_Precos.tabds"
4315:             .Width           = 80
4316:             .Movable         = .F.
4317:             .Resizable       = .F.
4318:             .ReadOnly        = .T.
4319:             .FontName        = "Courier New"
4320:             .Header1.Caption = "Tab.Varia" + CHR(231) + CHR(227) + "o"
4321:             .Visible         = .T.
4322:         ENDWITH
4323: 
4324:         WITH loc_oGrd.Column3
4325:             .ControlSource   = "cursor_4c_Precos.units"
4326:             .Width           = 70
4327:             .Movable         = .F.
4328:             .Resizable       = .F.
4329:             .ReadOnly        = .T.
4330:             .FontName        = "Courier New"
4331:             .InputMask       = "9999,999.99"
4332:             .Header1.Caption = "Unit" + CHR(225) + "rio"
4333:             .Visible         = .T.
4334:         ENDWITH
4335: 
4336:         WITH loc_oGrd.Column4
4337:             .ControlSource   = "cursor_4c_Precos.moedas"
4338:             .Width           = 30
4339:             .Movable         = .F.
4340:             .Resizable       = .F.
4341:             .ReadOnly        = .T.
4342:             .FontName        = "Courier New"
4343:             .Header1.Caption = "Moe"
4344:             .Visible         = .T.
4345:         ENDWITH
4346: 
4347:         WITH loc_oGrd
4348:             .FontName = "Courier New"
4349:             .FontSize = 8
4350:             .HeaderHeight = 16
4351:             .RowHeight    = 16
4352:         ENDWITH

*-- Linhas 4362 a 4381:
4362:     * inventa consulta: o pai informa o alias que ele montou e este metodo
4363:     * copia as linhas para cursor_4c_Precos, repinta e mostra a grade.
4364:     *
4365:     * Desvio registrado: no SCX legado so Column2 declara ControlSource
4366:     * ("lpitem.tabds") - as outras tres ficaram com ControlSource vazio, o que
4367:     * as deixa em branco na tela. Os headers ("Lista de Precificacao",
4368:     * "Unitario", "Moe"), a MaxLength = 30 da Column1 e a InputMask numerica da
4369:     * Column3 provam a intencao, e por isso as quatro colunas foram ligadas.
4370:     *
4371:     * PUBLIC: eh o form pai quem chama.
4372:     *==========================================================================
4373:     PROCEDURE CarregarPrecos(par_cCursorOrigem)
4374:         LOCAL loc_lSucesso, loc_oErro
4375: 
4376:         loc_lSucesso = .F.
4377: 
4378:         IF VARTYPE(par_cCursorOrigem) <> "C" OR EMPTY(par_cCursorOrigem)
4379:             RETURN .F.
4380:         ENDIF
4381: 

*-- Linhas 4390 a 4414:
4390:         TRY
4391:             *-- ZAP (nao fechar/recriar): fechar o alias derrubaria o
4392:             *-- RecordSource da grade e ela viraria um retangulo branco.
4393:             SELECT cursor_4c_Precos
4394:             THIS.ZaparCursor("cursor_4c_Precos")
4395: 
4396:             *-- APPEND FROM DBF casa os campos por NOME: o alias do pai tem de
4397:             *-- trazer lprecos/tabds/units/moedas.
4398:             SELECT cursor_4c_Precos
4399:             APPEND FROM DBF(ALLTRIM(par_cCursorOrigem))
4400: 
4401:             GO TOP IN cursor_4c_Precos
4402: 
4403:             WITH THIS.pgf_4c_Paginas.Page4.grd_4c_Dados
4404:                 .Visible = (RECCOUNT("cursor_4c_Precos") > 0)
4405:                 .Refresh()
4406:             ENDWITH
4407: 
4408:             loc_lSucesso = .T.
4409: 
4410:         CATCH TO loc_oErro
4411:             THIS.this_cMensagemErro = loc_oErro.Message
4412:             MsgErro("Erro ao carregar a lista de precifica" + CHR(231) + CHR(227) + ;
4413:                     "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
4414:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 4435 a 4453:
4435:         loc_cSafety = SET("SAFETY")
4436:         SET SAFETY OFF
4437: 
4438:         SELECT (ALLTRIM(par_cAlias))
4439:         ZAP
4440: 
4441:         IF loc_cSafety = "ON"
4442:             SET SAFETY ON
4443:         ENDIF
4444: 
4445:         RETURN .T.
4446:     ENDPROC
4447: 
4448:     *==========================================================================
4449:     * GradeAfterRowColChange - Handler de AfterRowColChange de grd_4c_Dados.
4450:     *
4451:     * Declara par_nColIndex porque o evento passa esse argumento e handler sem
4452:     * o parametro estoura a cada troca de celula (regra #3). O uso aqui eh o
4453:     * MESMO do legado: carregar o detalhe da LINHA corrente, sem filtrar por

*-- Linhas 4466 a 4502:
4466:     * a partir do produto da linha corrente da grade.
4467:     *
4468:     * Transcreve o bloco de preenchimento do fwGrade.AfterRowColChange do
4469:     * legado: consulta SigCdPro (com LEFT JOIN em SigCdCol para a descricao da
4470:     * colecao), SigPrFnc (referencia do fornecedor por conta), SigMvEst (saldo
4471:     * do produto no grupo de estoque), SigCdCli (nome do fornecedor) e
4472:     * SigCdClf (descricao da classificacao fiscal), e devolve:
4473:     *
4474:     *   getPVens/getMoeVs       <- crTmpPro.PVens / .MoeVs
4475:     *   cntReffs.getReffs       <- SigPrFnc.Reffs, com fallback SigCdPro.Reffs
4476:     *   getGVendas              <- Colecoes + " - " + Descs da colecao
4477:     *   getObsPes/getObsPeds    <- crTmpPro.ObsPes / .ObsPeds
4478:     *   getPesoms               <- crTmpPro.Pesoms
4479:     *   gerDIfors               <- SigCdCli.RClis do fornecedor do produto
4480:     *   getsaldo                <- SigMvEst.Sqtds
4481:     *   getqtresta              <- qtds - qtbaixas (qtds quando nada baixado)
4482:     *   lblVDescs/lblPDescs     <- trocam para "Acrescimo" quando ValDescs < 0
4483:     *   getFClFis/getFDlFis     <- classificacao fiscal e a descricao dela
4484:     *
4485:     * Os campos que SAO coluna de SigMvItn nao aparecem aqui: eles tem
4486:     * ControlSource sobre cursor_4c_Itens e acompanham a linha sozinhos - no
4487:     * legado eram atribuidos um a um porque la nao havia ControlSource.
4488:     *
4489:     * PUBLIC: o form pai e o harness chamam de fora.
4490:     *==========================================================================
4491:     PROCEDURE AtualizarPainelProduto()
4492:         LOCAL loc_oPag, loc_oFis, loc_cPro, loc_cSQL, loc_cReff, loc_cDsCol
4493:         LOCAL loc_cNomeFor, loc_cClFis, loc_cDsClFis, loc_nSaldo, loc_nResta
4494:         LOCAL loc_lProsseguir, loc_oErro
4495: 
4496:         loc_oPag = THIS.pgf_4c_Paginas.Page1
4497:         loc_oFis = THIS.pgf_4c_Paginas.Page3.cnt_4c_Item
4498: 
4499:         loc_cPro = ""
4500:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
4501:             loc_cPro = ALLTRIM(cursor_4c_Itens.cpros)
4502:         ENDIF

*-- Linhas 4524 a 4657:
4524: 
4525:         TRY
4526:             *-- Produto + descricao da colecao -----------------------------
4527:             loc_cSQL = "SELECT a.Cpros, a.CGrus, a.Reffs, a.Situas," + ;
4528:                        " a.DtSituas, a.CUnis, a.Dpros, a.PesoMs, a.MoeVs," + ;
4529:                        " a.PVens, a.Moedas, a.Colecoes, a.ClFiscals," + ;
4530:                        " a.ObsPes, a.ObsPeds, a.Conjunts, a.ifors," + ;
4531:                        " b.Descs AS ColDescs" + ;
4532:                        " FROM SigCdPro a" + ;
4533:                        " LEFT JOIN SigCdCol b ON a.Colecoes = b.Colecoes" + ;
4534:                        " WHERE a.Cpros = " + EscaparSQL(loc_cPro)
4535: 
4536:             IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ProTmp")
4537:                 IF USED("cursor_4c_ProTmp")
4538:                     SELECT cursor_4c_ProTmp
4539:                     GO TOP
4540:                     IF !EOF()
4541:                         loc_cReff    = TratarNulo(cursor_4c_ProTmp.Reffs, "")
4542:                         loc_cDsCol   = TratarNulo(cursor_4c_ProTmp.ColDescs, "")
4543:                         loc_cClFis   = TratarNulo(cursor_4c_ProTmp.ClFiscals, "")
4544:                     ELSE
4545:                         loc_lProsseguir = .F.
4546:                     ENDIF
4547:                 ENDIF
4548:             ELSE
4549:                 loc_lProsseguir = .F.
4550:             ENDIF
4551: 
4552:             IF loc_lProsseguir
4553:                 *-- Referencia do fornecedor da conta (SigPrFnc sobrepoe a de
4554:                 *-- SigCdPro, como no legado)
4555:                 loc_cSQL = "SELECT Reffs FROM SigPrFnc" + ;
4556:                            " WHERE Cpros = " + EscaparSQL(loc_cPro) + ;
4557:                            " AND Ifors = " + EscaparSQL(THIS.ObterContaFornecedor())
4558: 
4559:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_FProTmp")
4560:                     IF USED("cursor_4c_FProTmp")
4561:                         SELECT cursor_4c_FProTmp
4562:                         GO TOP
4563:                         IF !EOF()
4564:                             loc_cReff = TratarNulo(cursor_4c_FProTmp.Reffs, loc_cReff)
4565:                         ENDIF
4566:                     ENDIF
4567:                 ENDIF
4568: 
4569:                 *-- Saldo do produto no grupo de estoque
4570:                 loc_cSQL = "SELECT e.Sqtds FROM SigCdPro p" + ;
4571:                            " LEFT JOIN SigMvEst e ON e.CPros = p.CPros" + ;
4572:                            " AND e.EmpGruEsts = " + EscaparSQL(THIS.ObterGrupoEstoque()) + ;
4573:                            " WHERE p.CPros = " + EscaparSQL(loc_cPro)
4574: 
4575:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_SaldoTmp")
4576:                     IF USED("cursor_4c_SaldoTmp")
4577:                         SELECT cursor_4c_SaldoTmp
4578:                         GO TOP
4579:                         IF !EOF()
4580:                             loc_nSaldo = TratarNulo(cursor_4c_SaldoTmp.Sqtds, 0)
4581:                         ENDIF
4582:                     ENDIF
4583:                 ENDIF
4584: 
4585:                 *-- Nome do fornecedor do produto
4586:                 SELECT cursor_4c_ProTmp
4587:                 loc_cSQL = "SELECT RClis FROM SigCdCli" + ;
4588:                            " WHERE Iclis = " + ;
4589:                            EscaparSQL(ALLTRIM(TratarNulo(cursor_4c_ProTmp.ifors, "")))
4590: 
4591:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ForTmp")
4592:                     IF USED("cursor_4c_ForTmp")
4593:                         SELECT cursor_4c_ForTmp
4594:                         GO TOP
4595:                         IF !EOF()
4596:                             loc_cNomeFor = TratarNulo(cursor_4c_ForTmp.RClis, "")
4597:                         ENDIF
4598:                     ENDIF
4599:                 ENDIF
4600: 
4601:                 *-- Descricao da classificacao fiscal
4602:                 IF !EMPTY(loc_cClFis)
4603:                     loc_cSQL = "SELECT Descricaos FROM SigCdClf" + ;
4604:                                " WHERE Codigos = " + EscaparSQL(ALLTRIM(loc_cClFis))
4605: 
4606:                     IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ClfTmp")
4607:                         IF USED("cursor_4c_ClfTmp")
4608:                             SELECT cursor_4c_ClfTmp
4609:                             GO TOP
4610:                             IF !EOF()
4611:                                 loc_cDsClFis = TratarNulo(cursor_4c_ClfTmp.Descricaos, "")
4612:                             ENDIF
4613:                         ENDIF
4614:                     ENDIF
4615:                 ENDIF
4616: 
4617:                 *-- Entrega na tela ---------------------------------------
4618:                 SELECT cursor_4c_Itens
4619:                 loc_nResta = IIF(cursor_4c_Itens.qtbaixas = 0, ;
4620:                                  TratarNulo(cursor_4c_Itens.qtds, 0), ;
4621:                                  TratarNulo(cursor_4c_Itens.qtds, 0) - ;
4622:                                  TratarNulo(cursor_4c_Itens.qtbaixas, 0))
4623: 
4624:                 SELECT cursor_4c_ProTmp
4625:                 WITH loc_oPag
4626:                     .txt_4c_PVens.Value   = TratarNulo(cursor_4c_ProTmp.PVens, 0)
4627:                     .txt_4c_Peso.Value    = TratarNulo(cursor_4c_ProTmp.PesoMs, 0)
4628:                     .txt_4c_GVendas.Value = ALLTRIM(TratarNulo(cursor_4c_ProTmp.Colecoes, "")) + ;
4629:                                             IIF(EMPTY(loc_cDsCol), "", ;
4630:                                                 " - " + ALLTRIM(loc_cDsCol))
4631:                     .obj_4c_GetObsPes.Value  = ALLTRIM(TratarNulo(cursor_4c_ProTmp.ObsPes, ""))
4632:                     .obj_4c_GetObsPeds.Value = ALLTRIM(TratarNulo(cursor_4c_ProTmp.ObsPeds, ""))
4633:                     .txt_4c_Conjunts.Value   = ALLTRIM(TratarNulo(cursor_4c_ProTmp.Conjunts, ""))
4634:                     .txt_4c_GerDIfors.Value  = ALLTRIM(loc_cNomeFor)
4635:                     .txt_4c_Saldo.Value      = loc_nSaldo
4636:                     .txt_4c_Qtresta.Value    = loc_nResta
4637:                     .cnt_4c_Reffs.txt_4c_Reffs.Value = ALLTRIM(loc_cReff)
4638:                 ENDWITH
4639: 
4640:                 *-- Rotulo do desconto vira "Acrescimo" quando o valor eh
4641:                 *-- negativo (legado: If crTpmMvItn.ValDescs < 0)
4642:                 SELECT cursor_4c_Itens
4643:                 IF TratarNulo(cursor_4c_Itens.valdescs, 0) < 0
4644:                     loc_oPag.lbl_4c_LblVDescs.Caption = "Valor Acr" + CHR(233) + "scimo"
4645:                     loc_oPag.lbl_4c_LblPDescs.Caption = "%Acr" + CHR(233) + "scimo"
4646:                 ELSE
4647:                     loc_oPag.lbl_4c_LblVDescs.Caption = "Valor Desconto"
4648:                     loc_oPag.lbl_4c_LblPDescs.Caption = "% Desconto"
4649:                 ENDIF
4650: 
4651:                 *-- Painel fiscal: os dois campos que nao sao coluna do item
4652:                 WITH loc_oFis
4653:                     .txt_4c_FClFis.Value = ALLTRIM(loc_cClFis)
4654:                     .txt_4c_FDlFis.Value = ALLTRIM(loc_cDsClFis)
4655:                 ENDWITH
4656:             ELSE
4657:                 THIS.LimparPainelProduto()

*-- Linhas 4673 a 4709:
4673:     ENDPROC
4674: 
4675:     *==========================================================================
4676:     * ExecutarConsultaPainel - SQLEXEC das consultas de EXIBICAO do painel.
4677:     * Nenhuma delas alimenta grade, entao o alias pode ser fechado e recriado
4678:     * sem risco - o guard testa o BUFFERING antes do TABLEREVERT (regra #52).
4679:     * Falha de consulta nao interrompe o preenchimento: o legado segue com o
4680:     * campo em branco nos mesmos casos.
4681:     *==========================================================================
4682:     PROTECTED FUNCTION ExecutarConsultaPainel(par_cSQL, par_cCursor)
4683:         LOCAL loc_nResultado, loc_lOk
4684: 
4685:         loc_lOk = .F.
4686: 
4687:         IF USED(par_cCursor)
4688:             IF CURSORGETPROP("Buffering", par_cCursor) > 1
4689:                 TABLEREVERT(.T., par_cCursor)
4690:             ENDIF
4691:             USE IN (par_cCursor)
4692:         ENDIF
4693: 
4694:         loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)
4695: 
4696:         IF loc_nResultado >= 0
4697:             loc_lOk = .T.
4698:         ELSE
4699:             THIS.this_cMensagemErro = CapturarErroSQL()
4700:         ENDIF
4701: 
4702:         RETURN loc_lOk
4703:     ENDFUNC
4704: 
4705:     *==========================================================================
4706:     * FecharCursoresPainel - Fecha os cursores auxiliares do painel e devolve a
4707:     * area de trabalho corrente para cursor_4c_Itens, que eh o alias da grade.
4708:     *==========================================================================
4709:     PROTECTED PROCEDURE FecharCursoresPainel()

*-- Linhas 4724 a 4750:
4724:         ENDIF
4725: 
4726:         IF USED("cursor_4c_Itens")
4727:             SELECT cursor_4c_Itens
4728:         ENDIF
4729:     ENDPROC
4730: 
4731:     *==========================================================================
4732:     * LimparPainelProduto - Ramo ELSE do fwGrade.AfterRowColChange do legado:
4733:     * linha sem produto deixa o painel em branco.
4734:     *
4735:     * So zera os campos de EXIBICAO (sem ControlSource). Os que estao ligados a
4736:     * cursor_4c_Itens NAO entram aqui: escrever .Value neles gravaria no
4737:     * cursor, apagando o item - eles ja mostram branco porque a linha esta
4738:     * vazia.
4739:     *==========================================================================
4740:     PROCEDURE LimparPainelProduto()
4741:         LOCAL loc_oPag
4742: 
4743:         loc_oPag = THIS.pgf_4c_Paginas.Page1
4744: 
4745:         WITH loc_oPag
4746:             .txt_4c_PVens.Value      = 0
4747:             .txt_4c_Peso.Value       = 0
4748:             .txt_4c_Saldo.Value      = 0
4749:             .txt_4c_Qtresta.Value    = 0
4750:             .txt_4c_GVendas.Value    = ""

*-- Linhas 4798 a 4842:
4798:     *
4799:     * Chave POSICIONAL: o padding faz parte dela (emps char(3) + grupo char(10)
4800:     * + conta char(10) = 23 = a largura de EmpGruEsts). ALLTRIM nas partes
4801:     * encurtaria a chave e o SELECT devolveria ZERO linha em silencio
4802:     * (regra #42) - por isso PADR explicito em cada parte.
4803:     *==========================================================================
4804:     PROTECTED FUNCTION ObterGrupoEstoque()
4805:         RETURN PADR(THIS.this_cEmps, 3) + ;
4806:                PADR(THIS.this_cGrupoos, 10) + ;
4807:                PADR(THIS.this_cContaos, 10)
4808:     ENDFUNC
4809: 
4810:     *==========================================================================
4811:     * BtnBuscarClick - Procura na grade (getBusca do legado, bloco "Procurar"
4812:     * de Page1). NAO eh picker: ele POSICIONA a grade na linha cujo codigo de
4813:     * barras (obj_4c_Opt_Busca = 1) ou cujo produto (= 2) casa com o digitado.
4814:     *
4815:     * Legado (getBusca.Valid + getBusca.LostFocus):
4816:     *   lnOptBusca = This.parent.Opt_Busca.Value
4817:     *   ThisForm.lProcuraCB = .T.
4818:     *   If Not Empty(This.Value)
4819:     *       If lnOptBusca = 1
4820:     *           Select RecNo() As nRecNo From crTpmMvItn
4821:     *               Where CodBarras = Int(Val(lnCBars)) Into Cursor csProcura
4822:     *       Else
4823:     *           Select RecNo() As nRecNo From crTpmMvItn
4824:     *               Where Cpros = lcCpros Into Cursor csProcura
4825:     *       Endif
4826:     *       Select csProcura / Goto Top
4827:     *       If Not Eof() / Select crTpmMvItn / Goto csProcura.nRecNo / Endif
4828:     *   Endif
4829:     *   (LostFocus) This.Value = [] / se lProcuraCB, foco na coluna Produto
4830:     *
4831:     * Ligado ao LostFocus do campo porque no legado a procura mora no Valid,
4832:     * isto eh: dispara ao SAIR do campo (regra #47).
4833:     *
4834:     * PUBLIC: alvo de BINDEVENT e do harness de teste.
4835:     *==========================================================================
4836:     PROCEDURE BtnBuscarClick()
4837:         LOCAL loc_oPag, loc_cDigitado, loc_nOpcao, loc_nBarra, loc_nRecno
4838:         LOCAL loc_oErro
4839: 
4840:         loc_oPag     = THIS.pgf_4c_Paginas.Page1
4841:         loc_cDigitado = ALLTRIM(loc_oPag.txt_4c_Busca.Value)
4842:         loc_nOpcao    = loc_oPag.obj_4c_Opt_Busca.Value

*-- Linhas 4850 a 4914:
4850:         loc_nRecno           = 0
4851: 
4852:         TRY
4853:             SELECT cursor_4c_Itens
4854: 
4855:             IF loc_nOpcao = 1
4856:                 loc_nBarra = INT(VAL(loc_cDigitado))
4857:                 LOCATE FOR cursor_4c_Itens.codbarras = loc_nBarra
4858:             ELSE
4859:                 LOCATE FOR ALLTRIM(cursor_4c_Itens.cpros) == loc_cDigitado
4860:             ENDIF
4861: 
4862:             IF FOUND()
4863:                 loc_nRecno = RECNO("cursor_4c_Itens")
4864:             ENDIF
4865: 
4866:         CATCH TO loc_oErro
4867:             MsgErro("Erro ao procurar na grade:" + CHR(13) + loc_oErro.Message + ;
4868:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4869:                     "Proc: " + loc_oErro.Procedure, "Erro BtnBuscarClick")
4870:         ENDTRY
4871: 
4872:         *-- LostFocus do legado: limpa o campo de procura sempre
4873:         loc_oPag.txt_4c_Busca.Value = ""
4874: 
4875:         IF loc_nRecno > 0
4876:             SELECT cursor_4c_Itens
4877:             GO loc_nRecno
4878:             THIS.AtualizarPainelProduto()
4879:             THIS.RepintarGradeItens()
4880:             SELECT cursor_4c_Itens
4881:             GO loc_nRecno
4882:             THIS.grd_4c_Dados.Refresh()
4883:         ELSE
4884:             MsgAviso("Item n" + CHR(227) + "o encontrado na grade.", "Procurar")
4885:         ENDIF
4886: 
4887:         THIS.this_lProcuraCB = .F.
4888: 
4889:         RETURN (loc_nRecno > 0)
4890:     ENDPROC
4891: 
4892:     *==========================================================================
4893:     * TxtProdLostFocus - Conferencia por codigo (get_prod do legado).
4894:     *
4895:     * O legado resolve o valor digitado nesta ordem (get_prod.Valid):
4896:     *   1. codigo de barras que JA esta numa linha da grade (Seek em
4897:     *      crTpmMvItn por codbarras) - marca ThisForm.Barra e usa o produto
4898:     *      daquela linha;
4899:     *   2. etiqueta individual em SigOpEtq (com LEFT JOIN em SigOpEta para
4900:     *      aceitar a barra antiga de uma etiqueta reemitida);
4901:     *   3. SigCdPro.Cbars (codigo de barras do cadastro);
4902:     *   4. SigCdPro.Ean13;
4903:     *   5. o proprio valor como CPros.
4904:     * Em qualquer caminho, achando o produto ele confere a unidade: se
4905:     * SigCdUni.etiqs = 'S' recusa com "Codigo Errado - Etiqueta Especial !!".
4906:     * Nao achando, avisa "Produto Nao Cadastrado!!!".
4907:     *
4908:     * fVerificarBarras() (SIGFUNCS.PRG) NAO foi portada. No legado ela apenas
4909:     * ESCOLHE entre o ramo de barras e o ramo de EAN13 - e os dois ramos
4910:     * terminam na mesma consulta a SigCdPro - entao tentar as duas resolucoes
4911:     * em sequencia produz o mesmo resultado sem o wrapper (mesma decisao
4912:     * documentada em FormSigPrEtq, regra #27 "no-op documentado").
4913:     *
4914:     * PUBLIC: alvo de BINDEVENT e do harness de teste.

*-- Linhas 4969 a 4987:
4969: 
4970:         *-- 1. Barra que ja esta numa linha da grade -----------------------
4971:         IF loc_nBarra <> 0 AND USED("cursor_4c_Itens")
4972:             SELECT cursor_4c_Itens
4973:             loc_nRecno = RECNO()
4974:             LOCATE FOR cursor_4c_Itens.codbarras = loc_nBarra
4975:             IF FOUND()
4976:                 THIS.this_nBarra = loc_nBarra
4977:                 loc_cProduto     = ALLTRIM(cursor_4c_Itens.cpros)
4978:             ELSE
4979:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
4980:                     GO loc_nRecno
4981:                 ENDIF
4982:             ENDIF
4983:         ENDIF
4984: 
4985:         IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
4986:             IF EMPTY(loc_cProduto)
4987:                 MsgAviso("Conex" + CHR(227) + "o com o banco n" + CHR(227) + ;

*-- Linhas 4993 a 5080:
4993:         TRY
4994:             *-- 2. Etiqueta individual (SigOpEtq + SigOpEta) ---------------
4995:             IF EMPTY(loc_cProduto) AND loc_nBarra <> 0
4996:                 loc_cSQL = "SELECT a.CPros, a.CBars, a.CodTams, a.Contas" + ;
4997:                            " FROM SigOpEtq a" + ;
4998:                            " LEFT JOIN SigOpEta b ON a.cpros = b.cpros" + ;
4999:                            " AND a.cbars = b.cbars_new" + ;
5000:                            " WHERE (a.CBars = " + FormatarNumeroSQL(loc_nBarra, 0) + ;
5001:                            " OR b.cbars_old = " + FormatarNumeroSQL(loc_nBarra, 0) + ")"
5002: 
5003:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_EtqTmp")
5004:                     IF USED("cursor_4c_EtqTmp")
5005:                         SELECT cursor_4c_EtqTmp
5006:                         GO TOP
5007:                         IF !EOF()
5008:                             THIS.this_nBarra = loc_nBarra
5009:                             loc_cProduto     = ALLTRIM(TratarNulo(cursor_4c_EtqTmp.CPros, ""))
5010:                         ENDIF
5011:                         USE IN cursor_4c_EtqTmp
5012:                     ENDIF
5013:                 ENDIF
5014:             ENDIF
5015: 
5016:             *-- 3. Codigo de barras do cadastro (SigCdPro.Cbars) -----------
5017:             IF EMPTY(loc_cProduto) AND loc_nBarra <> 0
5018:                 loc_cSQL = "SELECT Cpros FROM SigCdPro" + ;
5019:                            " WHERE Cbars = " + FormatarNumeroSQL(loc_nBarra, 0)
5020: 
5021:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_BarTmp")
5022:                     IF USED("cursor_4c_BarTmp")
5023:                         SELECT cursor_4c_BarTmp
5024:                         GO TOP
5025:                         IF !EOF()
5026:                             THIS.this_nBarra = loc_nBarra
5027:                             loc_cProduto     = ALLTRIM(TratarNulo(cursor_4c_BarTmp.Cpros, ""))
5028:                         ENDIF
5029:                         USE IN cursor_4c_BarTmp
5030:                     ENDIF
5031:                 ENDIF
5032:             ENDIF
5033: 
5034:             *-- 4. EAN13 do cadastro (SigCdPro.Ean13) ----------------------
5035:             IF EMPTY(loc_cProduto) AND loc_nBarra <> 0
5036:                 loc_cSQL = "SELECT Cpros FROM SigCdPro" + ;
5037:                            " WHERE Ean13 = " + FormatarNumeroSQL(loc_nBarra, 0)
5038: 
5039:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_EanTmp")
5040:                     IF USED("cursor_4c_EanTmp")
5041:                         SELECT cursor_4c_EanTmp
5042:                         GO TOP
5043:                         IF !EOF()
5044:                             THIS.this_nBarra = loc_nBarra
5045:                             loc_cProduto     = ALLTRIM(TratarNulo(cursor_4c_EanTmp.Cpros, ""))
5046:                         ENDIF
5047:                         USE IN cursor_4c_EanTmp
5048:                     ENDIF
5049:                 ENDIF
5050:             ENDIF
5051: 
5052:             *-- 5. O proprio valor como CPros ------------------------------
5053:             IF EMPTY(loc_cProduto)
5054:                 loc_cProduto = par_cDigitado
5055:             ENDIF
5056: 
5057:             *-- Confere o cadastro do produto e a unidade ------------------
5058:             loc_cSQL = "SELECT a.Cpros, a.Cunis, b.etiqs" + ;
5059:                        " FROM SigCdPro a" + ;
5060:                        " LEFT JOIN SigCdUni b ON a.Cunis = b.Cunis" + ;
5061:                        " WHERE a.Cpros = " + EscaparSQL(loc_cProduto)
5062: 
5063:             IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ProdTmp")
5064:                 IF USED("cursor_4c_ProdTmp")
5065:                     SELECT cursor_4c_ProdTmp
5066:                     GO TOP
5067:                     IF EOF()
5068:                         MsgAviso("Produto N" + CHR(227) + "o Cadastrado!!! " + ;
5069:                                  CHR(13) + loc_cProduto, ;
5070:                                  "Aten" + CHR(231) + CHR(227) + "o!!!")
5071:                         loc_cProduto = ""
5072:                     ELSE
5073:                         loc_cUnidade = UPPER(ALLTRIM(TratarNulo(cursor_4c_ProdTmp.etiqs, "")))
5074:                         *-- Legado: CrSigCdUni.etiqs = 'S' recusa a digitacao
5075:                         *-- manual porque o produto exige etiqueta especial.
5076:                         IF loc_cUnidade == "S"
5077:                             MsgAviso("C" + CHR(243) + "digo Errado - Etiqueta Especial !!", ;
5078:                                      "Aten" + CHR(231) + CHR(227) + "o!!!")
5079:                             loc_cProduto = ""
5080:                         ELSE

*-- Linhas 5096 a 5114:
5096:         ENDTRY
5097: 
5098:         IF USED("cursor_4c_Itens")
5099:             SELECT cursor_4c_Itens
5100:         ENDIF
5101: 
5102:         RETURN loc_cProduto
5103:     ENDFUNC
5104: 
5105:     *==========================================================================
5106:     * CarregarImagemProduto - Foto do produto em img_4c_ImgProds. Legado
5107:     * (get_prod.Valid e fwGrade.AfterRowColChange):
5108:     *
5109:     *   If CrSigCdOpe.Imagems = 1
5110:     *       imgProds.Visible = .F. / imgProds.Picture = ''
5111:     *       If Not Empty(CrTmpPro.FigJpgs) And Not Isnull(CrTmpPro.FigJpgs)
5112:     *           lcFoto = Strconv(Strtran(... data:image/...;base64, ...),14)
5113:     *           If (StrToFile(lcFoto, lcArquivo3) > 0)
5114:     *               imgProds.Picture = (lcArquivo3) / imgProds.Visible = .T.

*-- Linhas 5138 a 5161:
5138:         ENDIF
5139: 
5140:         TRY
5141:             loc_cSQL = "SELECT FigJpgs FROM SigCdPro" + ;
5142:                        " WHERE Cpros = " + EscaparSQL(ALLTRIM(par_cProduto))
5143: 
5144:             IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_FigTmp")
5145:                 IF USED("cursor_4c_FigTmp")
5146:                     SELECT cursor_4c_FigTmp
5147:                     GO TOP
5148:                     IF !EOF()
5149:                         loc_cFig = TratarNulo(cursor_4c_FigTmp.FigJpgs, "")
5150: 
5151:                         IF !EMPTY(loc_cFig)
5152:                             loc_cFig = STRTRAN(loc_cFig, "data:image/png;base64,",  "")
5153:                             loc_cFig = STRTRAN(loc_cFig, "data:image/jpeg;base64,", "")
5154:                             loc_cFig = STRTRAN(loc_cFig, "data:image/jpg;base64,",  "")
5155: 
5156:                             loc_cFoto    = STRCONV(loc_cFig, 14)
5157:                             loc_cArquivo = ADDBS(SYS(2023)) + "SigOpPro_" + ;
5158:                                            SYS(2015) + ".jpg"
5159: 
5160:                             IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0
5161:                                 loc_oImg.Picture = loc_cArquivo

*-- Linhas 5175 a 5205:
5175:         ENDTRY
5176: 
5177:         IF USED("cursor_4c_Itens")
5178:             SELECT cursor_4c_Itens
5179:         ENDIF
5180: 
5181:         RETURN loc_oImg.Visible
5182:     ENDPROC
5183: 
5184:     *==========================================================================
5185:     * TxtQtdLostFocus - Confirma a linha conferida (get_qtd.LostFocus do
5186:     * legado). O par Produto+Qtde desta pagina NAO inclui item novo: ele
5187:     * CONFERE um item que ja esta na grade. Legado:
5188:     *
5189:     *   _Prod = Padr(get_prod.Value,14)
5190:     *   Select crTpmMvItn / Set Order To cpros
5191:     *   If Not IsEmpty(This.Value)
5192:     *       If Empty(Barra) / Seek _Prod / ok = .T. / Endif
5193:     *       If Not Eof()
5194:     *           Do While Empty(Barra) And cpros = _Prod And ok And Not Eof()
5195:     *               If qtds = This.Value And iconfs = .F. / ok = .F. / Exit
5196:     *               Skip
5197:     *           Enddo
5198:     *           If ok / Messagebox('Quantidade Errada !!') / limpa campos
5199:     *           Else  / Replace iconfs With .T. / Refresh / limpa / foco grade
5200:     *       Else / Messagebox('Item nao encontrado !!') / limpa campos
5201:     *       Endif
5202:     *       ... Skip -1 / fwgrade.Refresh / get_prod.SetFocus / Barra = 0
5203:     *   Endif
5204:     *
5205:     * PUBLIC: alvo de BINDEVENT e do harness de teste.

*-- Linhas 5231 a 5249:
5231:         loc_nRecnoAchado = 0
5232: 
5233:         TRY
5234:             SELECT cursor_4c_Itens
5235:             SET ORDER TO
5236:             GO TOP
5237: 
5238:             *-- Procura a linha ainda nao conferida cuja quantidade bate.
5239:             *-- Com barra lida (this_nBarra) o legado nao exige casar o
5240:             *-- produto: a barra ja identificou a linha.
5241:             SCAN
5242:                 IF THIS.this_nBarra <> 0
5243:                     IF cursor_4c_Itens.codbarras <> THIS.this_nBarra
5244:                         LOOP
5245:                     ENDIF
5246:                 ELSE
5247:                     IF PADR(cursor_4c_Itens.cpros, 14) <> loc_cProduto
5248:                         LOOP
5249:                     ENDIF

*-- Linhas 5275 a 5293:
5275:             CASE loc_lConfere
5276:                 THIS.RepintarGradeItens()
5277:                 IF loc_nRecnoAchado > 0
5278:                     SELECT cursor_4c_Itens
5279:                     GO loc_nRecnoAchado
5280:                 ENDIF
5281:                 THIS.AtualizarPainelProduto()
5282:             CASE loc_lAchouLinha
5283:                 MsgAviso("Quantidade Errada !!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5284:             OTHERWISE
5285:                 MsgAviso("Item n" + CHR(227) + "o encontrado !!", ;
5286:                          "Aten" + CHR(231) + CHR(227) + "o!!!")
5287:         ENDCASE
5288: 
5289:         *-- Em TODOS os caminhos o legado limpa os dois campos e devolve o
5290:         *-- foco ao codigo, pronto para a leitura seguinte.
5291:         THIS.this_nBarra            = 0
5292:         THIS.this_lEmLookup         = .F.
5293: 

*-- Linhas 5339 a 5380:
5339:             ENDIF
5340: 
5341:             IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
5342:                 SELECT (loc_cCursor)
5343:                 par_oControleCodigo.Value = ALLTRIM(EVALUATE(loc_cCursor + "." + par_cCampoCodigo))
5344: 
5345:                 IF VARTYPE(par_oControleDescricao) = "O"
5346:                     par_oControleDescricao.Value = ALLTRIM(EVALUATE(loc_cCursor + "." + par_cCampoDescricao))
5347:                 ENDIF
5348:             ENDIF
5349: 
5350:             loc_oBusca.Release()
5351:         ENDIF
5352: 
5353:         IF USED(loc_cCursor)
5354:             USE IN (loc_cCursor)
5355:         ENDIF
5356: 
5357:         RETURN .T.
5358:     ENDPROC
5359: 
5360:     *==========================================================================
5361:     * ValidarCodCorLostFocus - Cor do item (getCodCors.Valid do legado, que
5362:     * abre fwbuscaext sobre SigCdCor por 'Cods'). Aqui o browse eh o
5363:     * FormBuscaAuxiliar via AbrirLookupCanonico (padrao canonico do projeto).
5364:     *
5365:     * O valor escolhido volta para o proprio TextBox, que tem ControlSource em
5366:     * cursor_4c_Itens.codcors - entao ele grava na linha corrente, igual ao
5367:     * "This.Value = crListaRemota.Cods" do legado.
5368:     *
5369:     * PUBLIC: alvo de BINDEVENT.
5370:     *==========================================================================
5371:     PROCEDURE ValidarCodCorLostFocus()
5372:         LOCAL loc_oPag, loc_cValor
5373: 
5374:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
5375:         loc_cValor = ALLTRIM(TRANSFORM(loc_oPag.txt_4c_CodCors.Value))
5376: 
5377:         *-- Legado: "If !Empty(lcCodCors)" - vazio nao abre browse nenhum
5378:         IF EMPTY(loc_cValor)
5379:             RETURN .F.
5380:         ENDIF

*-- Linhas 5468 a 5486:
5468:     *    fica so com EditDocs = 5 - mesmo comportamento aqui.
5469:     *
5470:     * 2. PREENCHIDO e crSigCdOpe.ValiNotas = 1: o documento tem de ser UNICO.
5471:     *    a) "Select Emps, Dopes, Numes From SigMvItn Where Notas = '<valor>'" -
5472:     *       achando o MESMO Dopes em OUTRA movimentacao (emps+dopes+numes
5473:     *       diferente da corrente), recusa com "Documento ... Ja Existe !!";
5474:     *    b) nao achando, conta no cursor local quantas linhas usam o mesmo
5475:     *       documento - mais de uma recusa com "Documento ... Ja Lancado Nessa
5476:     *       Operacao !!".
5477:     *
5478:     * 3. crSigOpCdc.OpVlUnis = 1 com produto 'C': o valor unitario do item vem
5479:     *    do documento informado ("Replace Units With LocalEest.valos,
5480:     *    Utilizas With 51"). A acumulacao das parcelas do legado grava no
5481:     *    cursor xPar, que pertence ao form PAI: so roda quando o pai o
5482:     *    entregou (USED("xPar")).
5483:     *
5484:     * O legado tambem normaliza o valor com Transf(Val(This.Value),"@L 999999")
5485:     * - documento eh char(6) com zeros a esquerda.
5486:     *

*-- Linhas 5530 a 5574:
5530: 
5531:         TRY
5532:             *-- 2a. Mesmo documento em OUTRA movimentacao da mesma operacao
5533:             loc_cSQL = "SELECT Emps, Dopes, Numes, empdopnums FROM SigMvItn" + ;
5534:                        " WHERE Notas = " + EscaparSQL(loc_cNotas) + ;
5535:                        " AND Dopes = " + EscaparSQL(PADR(THIS.this_cDopes, 20))
5536: 
5537:             IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_NotaTmp")
5538:                 IF USED("cursor_4c_NotaTmp")
5539:                     SELECT cursor_4c_NotaTmp
5540:                     SCAN
5541:                         IF ALLTRIM(TratarNulo(cursor_4c_NotaTmp.empdopnums, "")) <> ;
5542:                            ALLTRIM(loc_cChave)
5543:                             MsgAviso("Documento " + ALLTRIM(THIS.this_cDopes) + " " + ;
5544:                                      loc_cNotas + " J" + CHR(225) + " Existe !!", ;
5545:                                      "Opera" + CHR(231) + CHR(227) + "o: " + ;
5546:                                      ALLTRIM(TratarNulo(cursor_4c_NotaTmp.Emps, "")) + "-" + ;
5547:                                      ALLTRIM(TratarNulo(cursor_4c_NotaTmp.Dopes, "")) + "-" + ;
5548:                                      ALLTRIM(STR(TratarNulo(cursor_4c_NotaTmp.Numes, 0))))
5549:                             loc_lOk = .F.
5550:                             EXIT
5551:                         ENDIF
5552:                     ENDSCAN
5553:                     USE IN cursor_4c_NotaTmp
5554:                 ENDIF
5555:             ENDIF
5556: 
5557:             *-- 2b. Mesmo documento repetido DENTRO desta operacao
5558:             IF loc_lOk
5559:                 SELECT cursor_4c_Itens
5560:                 loc_nRecno = RECNO()
5561:                 COUNT FOR ALLTRIM(cursor_4c_Itens.notas) == loc_cNotas TO loc_nIguais
5562:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
5563:                     GO loc_nRecno
5564:                 ENDIF
5565: 
5566:                 IF loc_nIguais > 1
5567:                     MsgAviso("Documento " + ALLTRIM(THIS.this_cDopes) + " " + loc_cNotas + ;
5568:                              " J" + CHR(225) + " Lan" + CHR(231) + "ado Nessa Opera" + ;
5569:                              CHR(231) + CHR(227) + "o !!", ;
5570:                              "Opera" + CHR(231) + CHR(227) + "o: " + ALLTRIM(THIS.this_cDopes))
5571:                     loc_lOk = .F.
5572:                 ENDIF
5573:             ENDIF
5574: 

*-- Linhas 5587 a 5719:
5587:         ENDTRY
5588: 
5589:         IF USED("cursor_4c_Itens")
5590:             SELECT cursor_4c_Itens
5591:         ENDIF
5592: 
5593:         RETURN loc_lOk
5594:     ENDPROC
5595: 
5596:     *==========================================================================
5597:     * AplicarValorDoDocumento - Ramo "crSigOpCdc.OpVlUnis = 1" do
5598:     * getDocs.Valid: o valor unitario do item 'C' vem do documento informado.
5599:     *
5600:     * Legado:
5601:     *   lcSql = [Select a.Valos, a.Datas, a.EmpDopNums From SigMvCab a,
5602:     *            SigCdOpe b, SigCdTom c Where a.Dopes = b.Dopes And
5603:     *            b.TipoOps = c.Codigos And c.OpVlUnis = 1 And a.Numes = <n>
5604:     *            Order by A.Datas]
5605:     *   Select LocalEest / Go Bott
5606:     *   If Reccount() > 0
5607:     *       Replace Units With LocalEest.valos, Utilizas With 51 in crTpmMvItn
5608:     *       If crSigCdOpe.parcs = 1 ... soma SigMvPar em xPar ... Replace Units
5609:     *   ThisForm.Calc_ValIte()
5610:     *
5611:     * Utilizas = 51 eh a marca do legado para "preco travado pelo documento":
5612:     * os guards de When de getVDescs/getPDescs e da coluna Valor testam
5613:     * justamente esse valor.
5614:     *
5615:     * A acumulacao das parcelas grava no cursor xPar, que eh do form PAI; ela
5616:     * so roda quando o pai entregou esse cursor.
5617:     *==========================================================================
5618:     PROTECTED PROCEDURE AplicarValorDoDocumento(par_nNumero)
5619:         LOCAL loc_cSQL, loc_nValor, loc_cEdn, loc_nTotPar, loc_lAplicou
5620: 
5621:         loc_lAplicou = .F.
5622: 
5623:         IF VARTYPE(par_nNumero) <> "N" OR par_nNumero = 0
5624:             RETURN .F.
5625:         ENDIF
5626: 
5627:         loc_cSQL = "SELECT a.Valos, a.Datas, a.EmpDopNums" + ;
5628:                    " FROM SigMvCab a, SigCdOpe b, SigCdTom c" + ;
5629:                    " WHERE a.Dopes = b.Dopes" + ;
5630:                    " AND b.TipoOps = c.Codigos" + ;
5631:                    " AND c.OpVlUnis = 1" + ;
5632:                    " AND a.Numes = " + FormatarNumeroSQL(par_nNumero, 0) + ;
5633:                    " ORDER BY a.Datas"
5634: 
5635:         IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_DocValTmp")
5636:             IF USED("cursor_4c_DocValTmp")
5637:                 SELECT cursor_4c_DocValTmp
5638:                 GO BOTTOM
5639:                 IF RECCOUNT("cursor_4c_DocValTmp") > 0
5640:                     loc_nValor = TratarNulo(cursor_4c_DocValTmp.Valos, 0)
5641:                     loc_cEdn   = ALLTRIM(TratarNulo(cursor_4c_DocValTmp.EmpDopNums, ""))
5642: 
5643:                     SELECT cursor_4c_Itens
5644:                     REPLACE units    WITH loc_nValor, ;
5645:                             utilizas WITH 51 IN cursor_4c_Itens
5646: 
5647:                     *-- Parcelas: o cursor de destino (xPar) pertence ao form
5648:                     *-- PAI; sem ele entregue, o legado tambem nao soma nada.
5649:                     IF THIS.this_nParcs = 1 AND USED("xPar") AND !EMPTY(loc_cEdn)
5650:                         loc_cSQL = "SELECT Valos FROM SigMvPar" + ;
5651:                                    " WHERE EmpdopNums = " + EscaparSQL(loc_cEdn) + ;
5652:                                    " AND fPags = " + EscaparSQL("P")
5653: 
5654:                         IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ParTmp")
5655:                             loc_nTotPar = 0
5656:                             IF USED("cursor_4c_ParTmp")
5657:                                 SELECT cursor_4c_ParTmp
5658:                                 SCAN
5659:                                     SELECT xPar
5660:                                     APPEND BLANK
5661:                                     REPLACE Valos WITH TratarNulo(cursor_4c_ParTmp.Valos, 0) IN xPar
5662:                                     loc_nTotPar = loc_nTotPar + TratarNulo(cursor_4c_ParTmp.Valos, 0)
5663:                                     SELECT cursor_4c_ParTmp
5664:                                 ENDSCAN
5665:                                 USE IN cursor_4c_ParTmp
5666:                             ENDIF
5667: 
5668:                             SELECT cursor_4c_Itens
5669:                             REPLACE units WITH loc_nTotPar IN cursor_4c_Itens
5670:                         ENDIF
5671:                     ENDIF
5672: 
5673:                     loc_lAplicou = .T.
5674:                 ENDIF
5675:                 IF USED("cursor_4c_DocValTmp")
5676:                     USE IN cursor_4c_DocValTmp
5677:                 ENDIF
5678:             ENDIF
5679:         ENDIF
5680: 
5681:         IF loc_lAplicou
5682:             THIS.TotalizarLinha(.F.)
5683:         ENDIF
5684: 
5685:         IF USED("cursor_4c_Itens")
5686:             SELECT cursor_4c_Itens
5687:         ENDIF
5688: 
5689:         RETURN loc_lAplicou
5690:     ENDPROC
5691: 
5692:     *==========================================================================
5693:     * ValidarLotesLostFocus - Numero do lote (getLotes.Valid do legado).
5694:     *
5695:     * O numero digitado eh COMPOSTO: os 4 primeiros digitos sao o nDopes da
5696:     * operacao que gerou o lote e os 6 ultimos o numero da movimentacao.
5697:     * Legado:
5698:     *
5699:     *   ndope = Val( Left( Str( This.Value, 10 ), 4) )
5700:     *   Cursorquery('SigCdOpe','crSigCdOpe','nDopes',ndope) / Dope = Dopes
5701:     *   If crSigCdOpe.Ctrllotes # 1
5702:     *       Messagebox('Operacao '+Dope+' nao Configurada para gerar No. Lote !!')
5703:     *   Nume = Val( Right( Str( This.Value, 10), 6 ) )
5704:     *   Select EmpDopNums from SigMvCab Where Numes = <Nume> And Dopes = '<Dope>'
5705:     *   If ... Reccount = 0 / Messagebox('Lote N '+...+' nao Existe !!')
5706:     *
5707:     * O "set decimals to 0" do legado existe para o STR nao trazer casas
5708:     * decimais; aqui o INT() sobre o valor digitado faz o mesmo sem mexer num
5709:     * SET global.
5710:     *
5711:     * PUBLIC: alvo de BINDEVENT.
5712:     *==========================================================================
5713:     PROCEDURE ValidarLotesLostFocus()
5714:         LOCAL loc_oPag, loc_nLote, loc_cLote, loc_nDope, loc_nNume
5715:         LOCAL loc_cDope, loc_nCtrl, loc_cSQL, loc_lOk, loc_oErro
5716: 
5717:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5718:         loc_lOk  = .T.
5719: 

*-- Linhas 5739 a 5782:
5739:         loc_nCtrl = 0
5740: 
5741:         TRY
5742:             loc_cSQL = "SELECT Dopes, Ctrllotes FROM SigCdOpe" + ;
5743:                        " WHERE nDopes = " + FormatarNumeroSQL(loc_nDope, 0)
5744: 
5745:             IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_OpeLoteTmp")
5746:                 IF USED("cursor_4c_OpeLoteTmp")
5747:                     SELECT cursor_4c_OpeLoteTmp
5748:                     GO TOP
5749:                     IF !EOF()
5750:                         loc_cDope = ALLTRIM(TratarNulo(cursor_4c_OpeLoteTmp.Dopes, ""))
5751:                         loc_nCtrl = TratarNulo(cursor_4c_OpeLoteTmp.Ctrllotes, 0)
5752:                     ENDIF
5753:                     USE IN cursor_4c_OpeLoteTmp
5754:                 ENDIF
5755:             ENDIF
5756: 
5757:             IF loc_nCtrl <> 1
5758:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o " + loc_cDope + ;
5759:                          " n" + CHR(227) + "o Configurada para gerar No. Lote !!", ;
5760:                          "Aten" + CHR(231) + CHR(227) + "o!!!")
5761:                 loc_lOk = .F.
5762:             ENDIF
5763: 
5764:             IF loc_lOk
5765:                 loc_cSQL = "SELECT EmpDopNums FROM SigMvCab" + ;
5766:                            " WHERE Numes = " + FormatarNumeroSQL(loc_nNume, 0) + ;
5767:                            " AND Dopes = " + EscaparSQL(PADR(loc_cDope, 20))
5768: 
5769:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_LoteTmp")
5770:                     IF !USED("cursor_4c_LoteTmp") OR RECCOUNT("cursor_4c_LoteTmp") = 0
5771:                         MsgAviso("Lote N" + CHR(186) + " " + ALLTRIM(loc_cLote) + ;
5772:                                  " n" + CHR(227) + "o Existe !!", ;
5773:                                  "Aten" + CHR(231) + CHR(227) + "o!!!")
5774:                         loc_lOk = .F.
5775:                     ENDIF
5776:                     IF USED("cursor_4c_LoteTmp")
5777:                         USE IN cursor_4c_LoteTmp
5778:                     ENDIF
5779:                 ELSE
5780:                     MsgAviso("Lote N" + CHR(186) + " " + ALLTRIM(loc_cLote) + ;
5781:                              " n" + CHR(227) + "o Existe !!", ;
5782:                              "Aten" + CHR(231) + CHR(227) + "o!!!")

*-- Linhas 5793 a 5811:
5793:         ENDTRY
5794: 
5795:         IF USED("cursor_4c_Itens")
5796:             SELECT cursor_4c_Itens
5797:         ENDIF
5798: 
5799:         RETURN loc_lOk
5800:     ENDPROC
5801: 
5802:     PROCEDURE ValidarVDescsLostFocus()
5803:         LOCAL loc_oPag, loc_nValor, loc_nOrig, loc_oErro
5804: 
5805:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5806: 
5807:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
5808:             RETURN .F.
5809:         ENDIF
5810: 
5811:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")

*-- Linhas 5819 a 5837:
5819:         ENDIF
5820: 
5821:         TRY
5822:             SELECT cursor_4c_Itens
5823:             loc_nOrig = TratarNulo(cursor_4c_Itens.unitorigs, 0)
5824: 
5825:             IF loc_nOrig = 0
5826:                 loc_nOrig = TratarNulo(cursor_4c_Itens.units, 0)
5827:                 REPLACE unitorigs WITH loc_nOrig IN cursor_4c_Itens
5828:             ENDIF
5829: 
5830:             IF loc_nValor > 0
5831:                 REPLACE units WITH loc_nOrig - loc_nValor IN cursor_4c_Itens
5832:             ELSE
5833:                 REPLACE units WITH loc_nOrig + loc_nValor IN cursor_4c_Itens
5834:             ENDIF
5835: 
5836:         CATCH TO loc_oErro
5837:             MsgErro("Erro ao aplicar o desconto:" + CHR(13) + loc_oErro.Message + ;

*-- Linhas 5877 a 5895:
5877:         ENDIF
5878: 
5879:         TRY
5880:             SELECT cursor_4c_Itens
5881:             loc_nOrig = TratarNulo(cursor_4c_Itens.unitorigs, 0)
5882: 
5883:             IF loc_nOrig = 0
5884:                 loc_nOrig = TratarNulo(cursor_4c_Itens.units, 0)
5885:                 REPLACE unitorigs WITH loc_nOrig IN cursor_4c_Itens
5886:             ENDIF
5887: 
5888:             IF loc_nPerc > 0
5889:                 REPLACE units WITH loc_nOrig - ((ABS(loc_nPerc) * loc_nOrig) / 100) ;
5890:                         IN cursor_4c_Itens
5891:             ELSE
5892:                 REPLACE units WITH loc_nOrig + ((ABS(loc_nPerc) * loc_nOrig) / 100) ;
5893:                         IN cursor_4c_Itens
5894:             ENDIF
5895: 

*-- Linhas 6141 a 6159:
6141:     * campos de conferencia e de procura (que nao sao coluna do item) e manda
6142:     * o painel de exibicao para o branco.
6143:     *
6144:     * NAO toca nos campos com ControlSource: escrever .Value neles gravaria no
6145:     * cursor e APAGARIA o item da linha corrente. Quem limpa a LINHA eh
6146:     * LimparLinhaGrade().
6147:     *==========================================================================
6148:     PROTECTED PROCEDURE LimparCampos()
6149:         LOCAL loc_oPag
6150: 
6151:         loc_oPag = THIS.pgf_4c_Paginas.Page1
6152: 
6153:         WITH loc_oPag
6154:             .txt_4c__prod.Value  = ""
6155:             .txt_4c__qtd.Value   = 0
6156:             .txt_4c_Busca.Value  = ""
6157:             .obj_4c_Opt_Busca.Value = 1
6158:             .cnt_4c_Obs.Visible  = .F.
6159:         ENDWITH

*-- Linhas 6195 a 6215:
6195:     * sigopproBO, cobrindo TODAS as colunas de SigMvItn que o cursor carrega.
6196:     *
6197:     * O painel de Page1/Page3 eh uma VISTA da linha: os campos digitaveis tem
6198:     * ControlSource sobre cursor_4c_Itens, logo o que o usuario digitou ja esta
6199:     * no cursor quando este metodo roda - ler do cursor eh ler da tela, e eh
6200:     * tambem o que o legado faz (ele grava o cursor inteiro com TABLEUPDATE).
6201:     *
6202:     * Os campos de EXIBICAO (preco atual, saldo, resta, referencia, grupo de
6203:     * venda, peso medio, classificacao fiscal) NAO entram: nao sao coluna de
6204:     * SigMvItn - vem de SigCdPro/SigMvEst/SigCdClf e seriam gravados em
6205:     * coluna que nao existe.
6206:     *
6207:     * Devolve .T. quando havia linha para transferir.
6208:     *==========================================================================
6209:     PROTECTED FUNCTION FormParaBO()
6210:         LOCAL loc_lOk, loc_oBO, loc_oErro
6211: 
6212:         loc_lOk = .F.
6213: 
6214:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
6215:             RETURN .F.

*-- Linhas 6226 a 6244:
6226:             *-- uma a uma, com TratarNulo e com o teste de VARTYPE nos campos
6227:             *-- bit. Reescrever a lista aqui criaria duas versoes do mesmo
6228:             *-- mapeamento, que divergem na primeira coluna nova.
6229:             SELECT cursor_4c_Itens
6230:             loc_lOk = loc_oBO.CarregarDoCursor("cursor_4c_Itens")
6231: 
6232:             IF loc_lOk
6233:                 *-- Identificacao da movimentacao: no legado vem de TprMvCab
6234:                 *-- (cursor do form pai) e nao da linha do item.
6235:                 loc_oBO.this_cEmpdopnums = THIS.ObterChaveMovimentacao()
6236: 
6237:                 IF EMPTY(loc_oBO.this_cEmps)
6238:                     loc_oBO.this_cEmps = PADR(THIS.this_cEmps, 3)
6239:                 ENDIF
6240:                 IF EMPTY(loc_oBO.this_cDopes)
6241:                     loc_oBO.this_cDopes = PADR(THIS.this_cDopes, 20)
6242:                 ENDIF
6243:                 IF loc_oBO.this_nNumes = 0
6244:                     loc_oBO.this_nNumes = THIS.this_nNumes

*-- Linhas 6265 a 6283:
6265:     *==========================================================================
6266:     * BOParaForm - Caminho inverso de FormParaBO: leva as properties do
6267:     * sigopproBO para a linha da grade e, por consequencia, para o painel de
6268:     * Page1/Page3 (que esta ligado ao cursor por ControlSource).
6269:     *
6270:     * Posiciona PRIMEIRO na linha do item que esta no BO (citens): sem isso a
6271:     * gravacao cairia na linha errada e sobrescreveria outro item - o cursor
6272:     * nao acompanha o BO sozinho.
6273:     *
6274:     * Fecha atualizando o painel de exibicao e repintando a grade: popular o
6275:     * cursor NAO repinta a grade (regra #21).
6276:     *==========================================================================
6277:     PROTECTED PROCEDURE BOParaForm()
6278:         LOCAL loc_oBO, loc_lOk, loc_oErro
6279: 
6280:         loc_lOk = .F.
6281: 
6282:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
6283:             RETURN .F.

*-- Linhas 6290 a 6308:
6290:         loc_oBO = THIS.this_oBusinessObject
6291: 
6292:         TRY
6293:             SELECT cursor_4c_Itens
6294: 
6295:             *-- Casa a linha pelo numero do item; sem numero, usa a corrente.
6296:             IF loc_oBO.this_nCitens <> 0
6297:                 LOCATE FOR cursor_4c_Itens.citens = loc_oBO.this_nCitens
6298:                 IF !FOUND()
6299:                     GO TOP
6300:                 ENDIF
6301:             ENDIF
6302: 
6303:             IF !EOF("cursor_4c_Itens")
6304:                 REPLACE cidchaves  WITH loc_oBO.this_cCidchaves, ;
6305:                         citens     WITH loc_oBO.this_nCitens, ;
6306:                         citem2     WITH loc_oBO.this_nCitem2, ;
6307:                         cpros      WITH loc_oBO.this_cCpros, ;
6308:                         cpro2s     WITH loc_oBO.this_cCpro2s, ;

*-- Linhas 6454 a 6472:
6454: 
6455:         IF loc_lOk
6456:             *-- Popular o cursor NAO repinta a grade nem os campos ligados a
6457:             *-- ele por ControlSource (regra #21): o Refresh das paginas eh o
6458:             *-- que faz o painel mostrar o que acabou de ser gravado na linha.
6459:             THIS.RepintarGradeItens()
6460:             THIS.pgf_4c_Paginas.Page1.Refresh()
6461:             THIS.pgf_4c_Paginas.Page3.Refresh()
6462:             THIS.AtualizarPainelProduto()
6463:         ENDIF
6464: 
6465:         RETURN loc_lOk
6466:     ENDPROC
6467: 
6468:     *==========================================================================
6469:     * BtnCancelarClick - Caminho de ESC/Cancelar da tela.
6470:     *
6471:     * No SCX legado o botao de saida eh OK.btnSair, Caption "Retornar", com
6472:     * Command1.Cancel = .T. - isto eh: Encerrar e Cancelar sao o MESMO botao,


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

