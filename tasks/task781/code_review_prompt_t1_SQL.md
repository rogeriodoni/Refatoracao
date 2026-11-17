# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, IFORS, PVENS, CASAS, LPRECOS, CITAGRS, CITEM2, CBLOCOS, CITEM3, CITENS, LNCNT, VLBAIXAS, TOTREAL, TOTPREV, LNITEM, MERCS, DOPPS, ORIGEMS, DESTINOS, CMOES, FVENDAS, FCUSTOS, CADPRODS, CONFES, DPROS, DUNIS, DIVNOTAS, DESCRS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, IFORS, PVENS, CASAS, LPRECOS, CITAGRS, CITEM2, CBLOCOS, CITEM3, CITENS, LNCNT, VLBAIXAS, TOTREAL, TOTPREV, LNITEM, MERCS, DOPPS, ORIGEMS, DESTINOS, CMOES, FVENDAS, FCUSTOS, CADPRODS, CONFES, DPROS, DUNIS, DIVNOTAS, DESCRS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, IFORS, PVENS, CASAS, LPRECOS, CITAGRS, CITEM2, CBLOCOS, CITEM3, CITENS, LNCNT, VLBAIXAS, TOTREAL, TOTPREV, LNITEM, MERCS, DOPPS, ORIGEMS, DESTINOS, CMOES, FVENDAS, FCUSTOS, CADPRODS, CONFES, DPROS, DUNIS, DIVNOTAS, DESCRS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, IFORS, PVENS, CASAS, LPRECOS, CITAGRS, CITEM2, CBLOCOS, CITEM3, CITENS, LNCNT, VLBAIXAS, TOTREAL, TOTPREV, LNITEM, MERCS, DOPPS, ORIGEMS, DESTINOS, CMOES, FVENDAS, FCUSTOS, CADPRODS, CONFES, DPROS, DUNIS, DIVNOTAS, DESCRS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, IFORS, PVENS, CASAS, LPRECOS, CITAGRS, CITEM2, CBLOCOS, CITEM3, CITENS, LNCNT, VLBAIXAS, TOTREAL, TOTPREV, LNITEM, MERCS, DOPPS, ORIGEMS, DESTINOS, CMOES, FVENDAS, FCUSTOS, CADPRODS, CONFES, DPROS, DUNIS, DIVNOTAS, DESCRS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NITEM' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, IFORS, PVENS, CASAS, LPRECOS, CITAGRS, CITEM2, CBLOCOS, CITEM3, CITENS, LNCNT, VLBAIXAS, TOTREAL, TOTPREV, LNITEM, MERCS, DOPPS, ORIGEMS, DESTINOS, CMOES, FVENDAS, FCUSTOS, CADPRODS, CONFES, DPROS, DUNIS, DIVNOTAS, DESCRS

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
  ControlSource = "TprMvCab.obses"
  ControlSource = "TprMvCab.ptax1s"
  ControlSource = "TprMvCab.descs"
  ControlSource = "TprMvCab.acres"
  ControlSource = "TprMvCab.ptax3s"
  ControlSource = "TprMvCab.ptax2s"
Select ( lcpArqItem )
lcQuery = [Select a.Cpros, a.Moevs, a.Moecs, a.Moedas, a.ClFiscals, a.Cgrus, a.Linhas, a.Colecoes, a.CUnis, ] + ;
		    [From SigCdPro a, SigCdGrp b ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [crTmpPro]) < 1)
Select CrTmpPro
lcWhere = [Select Arreds, TipoEstos, Tams, Cores, Embs, chkInstalas From SigCdGrp Where Cgrus = ']+CrTmpPro.Cgrus+[']
lnErro = ThisForm.ParentForm.poDataMgr.SqlExecute(lcWhere,'crSigCdGrp')
	lcQuery = [Select Moevs,Pvens From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[' And Ifors = ']+_Ct+[']
	=ThisForm.ParentForm.poDataMgr.Sqlexecute(lcQuery,'CrTmpFpro')
	Select &lcpArqItem.
			lcwhere = [Select * From SigCdLpi Where Cpros = ']+&lcpArqItem..Cpros+[' And LPrecos = ']+&lcpArqCab..lPrecos+[']
			lnErro = ThisForm.ParentForm.poDataMgr.SqlExecute(lcWhere,'crSigCdLpi')
			Select crSigCdLpi
					lcQuery = [Select Moevs,Pvens From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[' And Ifors = ']+_Ct+[']
					=ThisForm.ParentForm.poDataMgr.Sqlexecute(lcQuery,'CrTmpFpro')
	Select &lcpArqItem.				
	Select crSigMvOrc
			Select crSigMvOrc
			Select Sum(Totas) as Totas, Sum(Tota1s) as Tota1s, Sum(Tota2s) as Tota2s, Sum(Tota3s) as Tota3s, Sum(tota7s) as Tota7s, Sum(tota8s) as Tota8s, ;
				From crSigMvOrc Where cItAgrs = Iif(!Empty(lnItAgr),lnItAgr,lnItens) Into Cursor TmpTotBlo	
				=Seek(Iif(!Empty(lnItAgr),lnItAgr,lnItens),[crSigMvOrc],[Citens])
	Select crSigMvOrc
	Select Sum(Totas) as Totas, Sum(tota1s) as Tota1s, Sum(tota2s) as Tota2s, Sum(tota3s) as Tota3s, ;
		from crSigMvOrc ;
	Select crSigMvOrc
	Select crSigMvOrc	
	Select Sum(Totas) as Totas, Sum(tota1s) as Tota1s, Sum(tota2s) as Tota2s, Sum(tota3s) as Tota3s, ;
		from crSigMvOrc ;
	Select crSigMvOrc
	Select crSigMvOrc
	Select Sum(Totas) as Totas, Sum(tota1s) as Tota1s, Sum(tota2s) as Tota2s, Sum(tota3s) as Tota3s, ;
		from crSigMvOrc ;
		Select crSigMvOrc
		Select crSigMvOrc
	Select crSigMvOrc
	=Seek(lnItens,[crSigMvOrc],[Citens])
	Select crSigMvOrp
	Select crSigMvOrc
		thisform.getDescritivo.ControlSource = [crSigMvOrc.Dpro2s]
		Select crSigMvOrc
		.Column1.Controlsource    = 'crSigMvOrc.Dpros'
		.Column2.Controlsource    = 'crSigMvOrc.Dpro2s'
		.Column3.Controlsource    = 'crSigMvOrc.qtds'
		.Column4.Controlsource    = 'crSigMvOrc.DcUnis'
		.Column5.Controlsource       = 'crSigMvOrc.pesos'
		.Column6.Controlsource    = 'crSigMvOrc.DcUnips'
		.Column7.Controlsource      = 'crSigMvOrc.fators'
		.Column8.Controlsource      = 'crSigMvOrc.units'
		.Column9.Controlsource      = 'crSigMvOrc.totas'
		.Column10.Controlsource     = 'crSigMvOrc.tota1s'
		.Column11.Controlsource     = 'crSigMvOrc.tota2s'
		.Column12.Controlsource     = 'crSigMvOrc.tota3s'
		.Column13.Controlsource     = 'crSigMvOrc.tota4s'
		.Column14.Controlsource     = 'crSigMvOrc.tota5s'
		.Column15.Controlsource     = 'crSigMvOrc.tota6s'
		.Column16.Controlsource     = 'crSigMvOrc.Obs'
		.Column17.Controlsource     = 'crSigMvOrc.tota7s'
		.Column18.Controlsource     = 'crSigMvOrc.tota8s'
		.Column19.Controlsource     = 'crSigMvOrc.tota9s'
		.Column20.Controlsource     = 'crSigMvOrc.tota10s'
		.Column21.Controlsource     = 'crSigMvOrc.Notas'
		.Column22.Controlsource     = 'crSigMvOrc.Perc4s'
		.Column23.Controlsource     = 'crSigMvOrc.Perc5s'
		.Column24.Controlsource     = 'crSigMvOrc.Perc6s'
		.Column25.Controlsource     = 'crSigMvOrc.Perc2s'
		.Column26.Controlsource     = 'crSigMvOrc.Perc3s'
		.Column27.Controlsource     = 'crSigMvOrc.Servicos'
		.Column28.Controlsource   = 'crSigMvOrc.Debitos'
		.Column29.Controlsource   = 'crSigMvOrc.Taxas'
		.Column30.Controlsource   = 'crSigMvOrc.DAcabs'
	Select crSigMvOrc
	Select Count(1) as tt from crSigMvOrc into cursor TmpMvOrc
				Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Dpros) Value ;
				Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Dpros, Dpro2s) Value ;
			Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Dpros) Value ;
			Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Dpros) Value ;
			Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Dpros) Value ;
			Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Dpros) Value ;
			Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Dpros) Value ;
			Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Dpros) Value ;
	Select crSigMvOrc
	.Column1.Controlsource    = 'crSigMvOrp.Percs'
	.Column2.Controlsource    = 'crSigMvOrp.Datas'
	.Column3.Controlsource    = 'crSigMvOrp.Valos'
	.Column4.Controlsource    = 'crSigMvOrp.Ifors'
	.Column5.Controlsource    = 'crSigMvOrp.Vlbaixas'
	.Column6.Controlsource    = 'crSigMvOrp.Dfors'
	.Column7.Controlsource    = 'crSigMvOrp.Valcreds'
Select crSigMvOrp
	Select crSigMvOrc
		Select crSigMvOrc
		Select crSigMvOrc
		Select crSigMvOrp
				=Seek(crSigMvOrp.Citens,[crSigMvOrc],[citens])			
			Select a.Citens, a.Dpros, (a.Tota7s + a.Tota8s) as TotReal, Sum(b.Valos) as TotPrev ;
				From crSigMvOrc a Left Join crSigMvOrp b On a.Citens = b.Citens ;
				Select TmpTotPrev
				=Seek(TmpTotPrev.Citens,[crSigMvOrc],[citens])						
	Select crSigMvOrc
	Delete For Empty(Dpros) And Citens <> Citem2 And cBlocos <> [BRANCO]
			Insert into crTpmMvItn from Memvar
	Select crSigMvOrp
	Delete For Empty(Ifors) And Empty(Percs) And Empty(Datas)
	Select crTpmMvItn
Select crSigMvOrc
		Select Max(citens) as Citens From crSigMvOrc Where cItAgrs = Iif(!Empty(lnItAgr),lnItAgr,lnItem) Into Cursor TmpSub	
			=Seek(TmpSub.Citens,[crSigMvOrc],[Citens])
	Select crSigMvOrc
		Select crSigMvOrp
	Select crSigMvOrp
	Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, Citem3, cBlocos, Taxas, Visivels) Value ;
	Select crSigMvOrc
	=Seek(lnItem + 1)	
	Select crSigMvOrp
Select crSigMvOrc
Select crSigMvOrc
			Select Count(1) as NItem from crSigMvOrc ;
				Select Count(1) as NItem from crSigMvOrc where cItem3 = lnItem3 into cursor TmpTotBlo
				Delete for cItem3 = lnItem3 And !Inlist(cBlocos,[BRANCO],[SUBTOTAIS],[TAXA],[TOTAL],[IMPOSTO],[TOTALGERAL]) in crSigMvOrc
				Select crSigMvOrc
					Select crSigMvOrp
				Select crSigMvOrp
			Select Count(1) as NItem from crSigMvOrc ;
				Select Count(1) as NItem from crSigMvOrc where cItem2 = lnItem2 into cursor TmpTotBlo				
				Delete for cItem2 = lnItem2 And !Inlist(cBlocos,[BRANCO],[SUBTOTAIS],[TAXA],[TOTAL],[IMPOSTO],[TOTALGERAL]) in crSigMvOrc
				Select crSigMvOrc
					Select crSigMvOrp
				Select crSigMvOrp
		Select crSigMvOrc
		=Seek(lnItem)
		Select crSigMvOrp
		Select crSigMvOrc			
		Delete For cItens = lnItem 
		Select crSigMvOrp
		Delete For cItens = lnItem 
		Select crSigMvOrc
			Select crSigMvOrp
		Select crSigMvOrp
		Select crSigMvOrc
		=Seek(lnItem)
		Select crSigMvOrp
	Select crSigMvOrc
Select crSigMvOrp
Select crSigMvOrp
	Insert into crSigMvOrp(Emps, Dopes, Numes, Citens, Datas, Valos, Vlbaixas) Value ;
	Select crSigMvOrp
	Select crSigMvOrp
		Delete
Select crSigMvOrc
	Select Max(citens) as Citens From crSigMvOrc Where Citem3 = lnItem3 Into Cursor TmpSub	
		=Seek(TmpSub.Citens,[crSigMvOrc],[Citens])
	Select crSigMvOrc	
		Select crSigMvOrp
	Select crSigMvOrp
	Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Visivels) Value ;
	Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Dpros, Dpro2s, Visivels) Value ;
				Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Dpros, Visivels) Value ;
				Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Dpros, Dpro2s, Visivels) Value ;
		Select crSigMvOrc
			Select Max(citens) as Citens From crSigMvOrc Into Cursor TmpSub	
			Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Dpros, Visivels) Value ;
			Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Dpros, Visivels) Value ;
	Select crSigMvOrc
	=Seek(lnItem + 1)
	Select crSigMvOrp
Select crSigMvOrc
Select crSigMvOrc
	Select Max(citens) as Citens From crSigMvOrc Where Citem3 = lnItem3 And cItem2 = lnItem2 And cBlocos = [SUBTOTAL] Into Cursor TmpSub	
		=Seek(TmpSub.Citens,[crSigMvOrc],[Citens])	
	Select crSigMvOrc	
		Select crSigMvOrp
	Select crSigMvOrp
	Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Visivels) Value ;
		Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Dpros, Visivels) Value ;
		Select crSigMvOrc
			Select Max(citens) as Citens From crSigMvOrc Into Cursor TmpSub	
			Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Dpros, Visivels) Value ;
			Insert into crSigMvOrc(Emps, Dopes, Numes, Citens, cItem2, cItem3, cBlocos, Dpros, Visivels) Value ;
	Select crSigMvOrc
	=Seek(lnItem + 1)
	Select crSigMvOrp
Select crSigMvOrc
		Select crSigMvOrc
		=Seek(lnItem,[crSigMvOrc],[citens])
		Select crSigMvOrc
		=Seek(lnItem,[crSigMvOrc],[citens])
		Select crSigMvOrc
		=Seek(lnItem,[crSigMvOrc],[citens])		
	lcQuery = [Select a.Cgrus, a.DGrus From SigCdGrp a Inner Join SigCdRpo b On a.Cgrus = b.Cgrus Or a.Mercs = b.Mercs Where b.Dopps = ']+TprMvCab.Dopes+[']
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'TmpCdGpr') < 1)
	Select TmpCdGpr
		lcQuery = [Select a.Cgrus, a.DGrus From SigCdGrp a]
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'TmpCdGpr') < 1)
			lcSql = [Select Cgrus From SigCdPro Where cpros = ']+crSigMvOrc.Cpros+[']
			ThisForm.ParentForm.PodataMgr.SqlExecute(lcSql,'LocalGru')
		lcSql = [Select a.Cpros, a.Cgrus, a.Cunis, a.CuniPs, a.Dpros, a.Dpro2s, a.Pesoms, a.fvendas, a.fcustos, a.moepvs, ]+;
				[From SigCdPro a Inner Join SigCdGrp b on b.cGrus = a.cGrus Where a.Cpros = ']+lcCodProduto+[']
		ThisForm.ParentForm.Podatamgr.Sqlexecute(lcSql,'LocalPro')
							lcQuery = [Select Moevs, Pvens From SigPrFnc Where Cpros = ']+LocalPro.Cpros+[' And Ifors = ']+_Ct+[']
							=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
						lcQuery = [Select MoeQs, QtdEqs ] + ;
								    [From SigCdMoe ] + ;
						If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpMoe') < 1)
			Select crSigmvOrc
	Select crSigMvOrc
		Select crSigMvOrc
		=Seek(lnItem,[crSigMvOrc],[citens])
		Select crSigMvOrc
		=Seek(lnItem,[crSigMvOrc],[citens])
		Select crSigMvOrc
		=Seek(lnItem,[crSigMvOrc],[citens])
lcSql = [Select a.FigJpgs From SigCdPro a Where a.cpros = ']+lcCodPro+[' ]
ThisForm.ParentForm.Podatamgr.Sqlexecute(lcsql,'LocalPro')
		Delete File (lcArquivo)
	Select crSigMvOrc
		Select crSigMvOrc
lcQuery = [Select FigJpgs From SigCdPro Where Cpros = '] + crSigMvOrc.CPros + [']
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [crTmpPro]) < 1)
Select crSigMvOrp
		Select crSigMvOrc
		=Seek(lnItens,[crSigMvOrc],[Citens])		
	lcQuery = [Select Cgrus, Opers, Mercs, Contas, CodCors From SigCdRpo Where Dopps = ']+TprMvCab.Dopes+[']
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalRopt') < 1)
	Select LocalRopt
	lcQuery = [Select a.Cpros, a.Cgrus, a.Reffs, a.Situas, a.DtSituas, a.Cunis, a.Dpros, a.FVendas, a.FCustos, a.Moepvs, ] + ;
			    [From SigCdPro a ] + ;
			    Iif(llRest,[Inner Join SigCdRpo b On a.Cgrus = b.Cgrus Or a.Mercs = b.Mercs And b.Dopps = ']+TprMvCab.Dopes+['],[]) + ;
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpPro') < 1)
			Select crSigMvOrc						    
			Select crSigMvOrc
							lcQuery = [Select Moevs, Pvens From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[' And Ifors = ']+_Ct+[']
							=ThisForm.ParentForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
						lcQuery = [Select MoeQs, QtdEqs ] + ;
								    [From SigCdMoe ] + ;
						If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpMoe') < 1)
			Select crSigMvOrc
Select crSigMvOrc
	lcQuery = [Select Dunis, Cunis From SigCdUni Where Dunis like '%] + lcDUni + [%' Order By Cunis]
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpUni') < 1)
	Select crTmpUni
Select crSigMvOrc
	lcQuery = [Select Dunis, Cunis From SigCdUni Where Dunis like '%] + lcDUni + [%' Order By Cunis]
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crTmpUni') < 1)
	Select crTmpUni
Select crSigMvOrc
	Select crSigMvOrc
	lcQuery = [Select Cods, Descrs From SigCdAca Where Descrs like '%] + Alltrim(this.Value) + [%']
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'TmpCdAca') < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoporc.prg) - TRECHOS RELEVANTES PARA PASS SQL (5176 linhas total):

*-- Linhas 37 a 55:
37: *                                    btnExcluirp do legado)
38: *
39: * Cada grade tem o par Configurar<X> (so o que NAO depende de dado) +
40: * Vincular<X> (RecordSource/ControlSource sob USED, e depois deles
41: * Width/Header1.Caption) - separados porque atribuir RecordSource RESETA
42: * Width e Header1.Caption (regra #41/Problema 48) e o bind acontece mais
43: * de uma vez. CarregarDados() e o FUNIL (PUBLIC) que garante os cursores,
44: * vincula, posiciona os aliases e repinta - transcrevendo o fecho do Init
45: * legado (Set Order/Set Key/Go Top + thisform.Refresh + Grade.Refresh).
46: *
47: * FASE 5/8 - CAMPOS PRINCIPAIS (PARTE 1): os campos de percentual/calculo
48: * do topo (Say5/getPmargem, say4/getPtax2, say1/getPtaxa, Say3/getPTax1,
49: * say2/getPimposto, Say6/getPservico - migrados para
50: * lbl_4c_Margem/txt_4c_Margem, lbl_4c_Contingente/txt_4c_Contingente,
51: * lbl_4c_TaxaAdm/txt_4c_TaxaAdm, lbl_4c_BV/txt_4c_BV, lbl_4c_Imposto/
52: * txt_4c_Imposto, lbl_4c_ImpostoServico/txt_4c_ImpostoServico) + Shape4
53: * (shp_4c_Painel) + get_NewGrp/Say_NewGrp (txt_4c_NovoGrupo/
54: * lbl_4c_NovoGrupo, com o lookup de Grupo transcrito) + getDescritivo
55: * (edt_4c_DescritivoRodape) + TotalizarItn() (motor de calculo chamado

*-- Linhas 71 a 89:
71: *                              (SigCdGrp restrito por SigCdRpo.Dopps, com
72: *                              fallback para a lista inteira - transcrito)
73: *   grdItem.Column1.Text1   -> ValidarProdutoItemKeyPress +
74: *                              AbrirBuscaProdutoItem (SigCdPro, INNER JOIN
75: *                              SigCdRpo quando ha restricao)
76: *   grdItem.Column4/Column6 -> ValidarUnidadeVenda/PedidoKeyPress ->
77: *                              ValidarUnidadeGenerica + AbrirBuscaUnidade
78: *                              (SigCdUni)
79: *   grdItem.Column30.Text1  -> ValidarAcabamentoKeyPress +
80: *                              AbrirBuscaAcabamento (SigCdAca)
81: *
82: * grdParcela.Column4/Column6.Text1 TEM Valid com fAcessoContas no dump,
83: * mas o Init legado fixa ".Column4.ReadOnly = .t." e
84: * ".Column6.ReadOnly = .t." (sem depender do modo) - coluna ReadOnly nao
85: * dispara Valid, entao esse lookup JA e inalcancavel no legado. As duas
86: * colunas ficam ReadOnly aqui tambem (fiel ao Init) e NENHUM lookup de
87: * conta e criado: inventar um editaria campo que o legado nunca deixou
88: * editar (PILAR 1).
89: *

*-- Linhas 120 a 138:
120: *                            linha corrente (SEEK por Citens) e repinta
121: *   - FormParaBO()/BOParaForm()  sincronizacao manual dos 5 percentuais do
122: *                            topo, que no legado era automatica pelo
123: *                            ControlSource = TprMvCab.<coluna> (ptax2s/
124: *                            descs/ptax1s/acres/ptax3s). Sem BOParaForm os
125: *                            campos abriam sempre em 0,00 e o primeiro
126: *                            Enter num deles zerava o percentual de TODOS
127: *                            os itens
128: *   - HabilitarCampos()      os "When" dos CAMPOS num lugar so
129: *   - AjustarBotoesPorModo() os "When" dos BOTOES num lugar so
130: *   - LimparCampos()         reset do estado auxiliar da tela (busca/
131: *                            grupo novo/foto/valores anteriores)
132: *   - BtnCancelarClick()     funil de abandono (o legado nao tem botao de
133: *                            abandono; e o ramo CONSULTAR do OK, que fecha
134: *                            sem gravar) - BtnSalvarClick delega a ele
135: *   - AtualizarModoCriacao() COMPLETADO: ate a Fase 7 cobria 2 dos ~20
136: *                            controles que o bloco de layout do Init
137: *                            legado toca (faltavam os 6 pares de
138: *                            percentual, a grade de parcelas e seus

*-- Linhas 331 a 349:
331: 
332: 				*-- FUNIL de carga (cria/vincula cursores, posiciona e repinta).
333: 				*-- Nao condicionado a loc_lModoValidacaoOuTeste: os cursores sao
334: 				*-- locais (CREATE CURSOR), nao dependem de conexao SQL, e sem a
335: 				*-- chamada as grades abririam com cabecalho "Column<N>" e largura
336: 				*-- default tambem na validacao de UI. Ele ja aplica o layout do
337: 				*-- modo (AtualizarModoCriacao -> HabilitarCampos +
338: 				*-- AjustarBotoesPorModo) e traz os percentuais do cabecalho
339: 				*-- (BOParaForm).
340: 				THIS.CarregarDados()
341: 
342: 				loc_lSucesso = .T.
343: 			ENDIF
344: 		CATCH TO loc_oErro
345: 			MsgErro(loc_oErro.Message + CHR(13) + ;
346: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
347: 				"Procedure: " + loc_oErro.Procedure, ;
348: 				"Erro em Formsigoporc.InicializarForm")
349: 		ENDTRY

*-- Linhas 414 a 475:
414: 	* CriarCursorItens - Cursor local da grade de itens (grd_4c_Itens),
415: 	* equivalente ao crSigMvOrc que o legado compartilha com o form pai via
416: 	* troca de DataSession. Aqui o cursor e proprio deste form (regra
417: 	* OPERACIONAL #2/#3: ControlSource das colunas tem de bater com os
418: 	* campos deste CREATE CURSOR, com a MESMA ordem em qualquer outro lugar
419: 	* que vier a recriar o cursor).
420: 	*
421: 	* Campos cidchaves/cblocos/citens/citem2/citem3/citagrs/cpros/vlbaixas
422: 	* sao usados pelos botoes de linha (Incluir/Excluir) para renumerar o
423: 	* bloco - nao aparecem em coluna do grid, mas existem no cursor (igual
424: 	* ao legado, que os mantem no cursor mesmo sem Column visivel).
425: 	*
426: 	* dcunis/dcunips/dacabs sao campos de PROJECAO (join com SigCdUni/
427: 	* SigCdAca no legado - Column4/Column6/Column30 mostram a DESCRICAO,
428: 	* nao o codigo) - ficam vazios ate a fase do BO que monta a consulta
429: 	* com os joins (CarregarItens - ver cabecalho do BO).
430: 	*
431: 	* cunis/cunips/codacabs sao os CODIGOS que os lookups de celula
432: 	* (SigCdUni em Column4/Column6, SigCdAca em Column30) e o lookup de
433: 	* produto (Column1) gravam - char(3) nas tres colunas de SigMvOrc
434: 	* (docs\schema.sql conferido com Get-Content -Raw, regra #14). Nao tem
435: 	* Column no grid (o grid mostra a descricao), mas EXISTEM no cursor:
436: 	* sem eles o REPLACE dos handlers Validar* estouraria em runtime
437: 	* ("Variable CUNIS is not found") na primeira vez que o usuario
438: 	* escolhesse uma unidade.
439: 	*
440: 	* perc1s..perc6s NAO existem na tabela SigMvOrc (docs\schema.sql
441: 	* conferido) - sao campos de TRABALHO, so do cursor/grid, usados pelo
442: 	* legado para aplicar o percentual digitado nos campos do topo
443: 	* (Fase 5) antes de consolidar o resultado em tota1s..tota10s (que
444: 	* SIM sao persistidos). perc1s nao tem coluna propria no grid (so e
445: 	* usado internamente por TotalizarItn/getPtax2), por isso faltava
446: 	* aqui.
447: 	*==========================================================================
448: 	*
449: 	* Fase 7/8 - ACRESCIMO: emps/dopes/numes/empdopnums/pkchaves/moedas/
450: 	* moefats/moevs/opers nao estavam no cursor (faltavam desde a Fase 3) -
451: 	* sem eles, BO.CarregarDoCursor() (chamado no Salvar) nao tinha de onde
452: 	* ler essas colunas NOT NULL de SigMvOrc, e o INSERT/UPDATE do item
453: 	* gravaria moeda/operacao/chave sempre em branco. emps/dopes/numes
454: 	* tambem sao usados por BO.CarregarItens() como filtro de carga.
455: 	*==========================================================================
456: 	*
457: 	* Fase 8/8 - ACRESCIMO: tpesos/univals/utilizas. As TRES sao colunas
458: 	* REAIS de SigMvOrc (docs\schema.sql conferido com Get-Content -Raw,
459: 	* regra #14), estao no SELECT de BO.CarregarItens e nos INSERT/UPDATE
460: 	* de BO.Inserir/Atualizar - mas FALTAVAM no CREATE CURSOR. Como
461: 	* BO.CarregarDoCursor() le as tres (TratarNulo(tpesos,...)), a leitura
462: 	* estourava "Variable TPESOS is not found" em RUNTIME, dentro do
463: 	* TRY/CATCH do BO: compilava limpo e, na PRIMEIRA linha do SCAN de
464: 	* BtnSalvarClick, o metodo devolvia .F. com as properties do item
465: 	* ainda no valor da linha anterior - ou seja, NENHUM item era gravado
466: 	* corretamente. Mesma familia da regra #22 (campo lido em
467: 	* CarregarDoCursor que nao existe no cursor).
468: 	*
469: 	* vlbaixas fica no cursor mas NUNCA e preenchida pela carga: no legado
470: 	* ela e coluna PROJETADA pela query do form PAI (igual a DcUnis/
471: 	* DcUnips/DAcabs), e SigMvOrc nao tem coluna de baixa. Com 0 fixo, os
472: 	* guards "Empty(VlBaixas)" transcritos do legado ficam sempre
473: 	* verdadeiros (item nunca bloqueado por baixa) - comportamento seguro
474: 	* e explicito, nao silencioso: inventar uma origem para essa coluna
475: 	* seria inventar regra de negocio (regra #17).

*-- Linhas 483 a 563:
483: 		ENDIF
484: 
485: 		SET NULL ON
486: 		CREATE CURSOR (loc_cCursor) ;
487: 			(cidchaves C(20), cblocos C(30), citens N(10,0), citem2 N(10,0), ;
488: 			 citem3 N(10,0), citagrs N(10,0), cpros C(14), dpros C(65), ;
489: 			 dpro2s M, qtds N(8,4), cunis C(3), dcunis C(20), pesos N(8,4), ;
490: 			 cunips C(3), dcunips C(20), codacabs C(3), ;
491: 			 fators N(8,4), units N(13,2), totas N(13,2), tota1s N(13,2), ;
492: 			 tota2s N(13,2), tota3s N(13,2), tota4s N(13,2), tota5s N(13,2), ;
493: 			 tota6s N(13,2), obs M, tota7s N(13,2), tota8s N(13,2), ;
494: 			 tota9s N(13,2), tota10s N(13,2), notas C(9), perc1s N(8,4), ;
495: 			 perc2s N(8,4), perc3s N(8,4), perc4s N(8,4), perc5s N(8,4), ;
496: 			 perc6s N(8,4), servicos L, debitos L, taxas L, dacabs C(40), ;
497: 			 vlbaixas N(13,2), emps C(3), dopes C(20), numes N(6,0), ;
498: 			 empdopnums C(29), pkchaves C(20), moedas C(3), moefats C(3), ;
499: 			 moevs C(3), opers C(1), tpesos N(8,4), univals N(13,2), ;
500: 			 utilizas N(2,0))
501: 		SET NULL OFF
502: 
503: 		INDEX ON citens TAG citens
504: 	ENDPROC
505: 
506: 	*==========================================================================
507: 	* ConfigurarGridItens - grd_4c_Itens, equivalente ao SIGOPORC.grdItem
508: 	* (30 colunas). ControlSource/Width/ColumnOrder/Header1.Caption
509: 	* TRANSCRITOS do dump (PROPRIEDADES DE: SIGOPORC.grdItem e do Init -
510: 	* "With ThisForm.grdItem"). Column1 mostra Dpros (nao "Item" - o
511: 	* Header1.Caption do dump e literalmente esse, apesar do nome sugerir
512: 	* outra coisa) e Column2 mostra Dpro2s - conferido nas DUAS fontes do
513: 	* dump (PROPRIEDADES + Init) porque batiam.
514: 	*
515: 	* FICA PARA FASE POSTERIOR (depende de crSigCdOpe/SigCdEmp, carregados
516: 	* pelo BO em fase propria - ver cabecalho de sigoporcBO.prg):
517: 	*   - ReadOnly fixo (.T.) de Column13/Column14, mascaras de Column3/
518: 	*     Column5/Column7..20 (InputMask calculado de SigOpCdd.CasQtds/
519: 	*     SigCdOpe.NCPesos/Casas) e a troca de Header1.Caption/Width/
520: 	*     Visible conforme LocalEmp.DivNotas (P&G) ou crSigCdOpe.DigItens
521: 	*     IN (6,7) (modo Criacao);
522: 	*   - DynamicBackColor/DynamicForeColor (realce de bloco/sub-bloco);
523: 	*   - Column4/Column6 (DcUnis/DcUnips) e Column30 (DAcabs) so recebem
524: 	*     valor quando o BO passar a montar cursor_4c_Itens com os joins
525: 	*     de unidade/acabamento.
526: 	*==========================================================================
527: 	PROTECTED PROCEDURE ConfigurarGridItens()
528: 		LOCAL loc_lSoLeitura
529: 		loc_lSoLeitura = (THIS.this_cOpEscolha = "CONSULTAR")
530: 
531: 		THIS.AddObject("grd_4c_Itens", "Grid")
532: 
533: 		*-- ColumnCount FORA do WITH: as colunas ainda nao existem no momento
534: 		*-- da compilacao do WITH abaixo (regra CLAUDE.md sobre WITH + Grid -
535: 		*-- "Unknown member COLUMN1"). RecordSource/ControlSource/Width/
536: 		*-- Header1.Caption NAO ficam aqui: vao em VincularGradeItens().
537: 		THIS.grd_4c_Itens.ColumnCount  = 30
538: 
539: 		WITH THIS.grd_4c_Itens
540: 			.Top          = 218
541: 			.Left         = 5
542: 			.Width        = 989
543: 			.Height       = 258
544: 			.FontSize     = 8
545: 			.HeaderHeight = 16
546: 			.RowHeight    = 16
547: 			.ScrollBars   = 3
548: 			.DeleteMark   = .F.
549: 			.RecordMark   = .F.
550: 			.TabIndex     = 13
551: 
552: 			*-- Column1 (Item/Dpros - descritivo do produto). Celula com
553: 			*-- LOOKUP (legado grdItem.Column1.Text1.Valid -> SigCdPro), por
554: 			*-- isso recebe TextBox proprio via AddObject + CurrentControl +
555: 			*-- Sparse = .F. (regra #18: sem CurrentControl a coluna continua
556: 			*-- desenhando o Text1 nativo e o lookup nunca e alcancado; sem
557: 			*-- Sparse = .F. o controle so aparece na linha ativa).
558: 			*-- MaxLength vem da LARGURA da coluna no schema (SigMvOrc.dpros
559: 			*-- char(65)), nunca do Width em pixels (regra #19).
560: 			.Column1.ColumnOrder     = 1
561: 			.Column1.FontSize        = 8
562: 			.Column1.Header1.Alignment = 2
563: 			.Column1.Header1.FontSize  = 8

*-- Linhas 1033 a 1095:
1033: 		loc_cValor = ALLTRIM(par_oTxt.Value)
1034: 
1035: 		IF EMPTY(loc_cValor)
1036: 			SELECT (loc_cItens)
1037: 			REPLACE (par_cCampoCod) WITH ""
1038: 			RETURN
1039: 		ENDIF
1040: 
1041: 		IF USED("cursor_4c_TmpUnidade")
1042: 			USE IN cursor_4c_TmpUnidade
1043: 		ENDIF
1044: 		loc_cSQL = "SELECT Dunis, Cunis FROM SigCdUni WHERE Dunis LIKE " + ;
1045: 			EscaparSQL("%" + loc_cValor + "%") + " ORDER BY Cunis"
1046: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpUnidade")
1047: 
1048: 		IF loc_nResultado < 0
1049: 			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1050: 				"Falha na Conex" + CHR(227) + "o (SigCdUni)")
1051: 			RETURN
1052: 		ENDIF
1053: 
1054: 		loc_cDescEscolhida = ""
1055: 		loc_cCodEscolhido  = ""
1056: 
1057: 		IF USED("cursor_4c_TmpUnidade") AND RECCOUNT("cursor_4c_TmpUnidade") > 0
1058: 			SELECT cursor_4c_TmpUnidade
1059: 			GO TOP
1060: 			LOCATE FOR Dunis = PADR(loc_cValor, 20)
1061: 
1062: 			IF FOUND()
1063: 				loc_cDescEscolhida = ALLTRIM(cursor_4c_TmpUnidade.Dunis)
1064: 				loc_cCodEscolhido  = ALLTRIM(cursor_4c_TmpUnidade.Cunis)
1065: 			ELSE
1066: 				*-- Busca exata falhou: abre o picker sobre o cursor JA
1067: 				*-- populado (equivale ao fwBuscaInt do legado). Regra #50:
1068: 				*-- NAO avisar nem apagar o que o usuario digitou aqui - o
1069: 				*-- picker e o proprio feedback.
1070: 				THIS.AbrirBuscaUnidade()
1071: 				loc_cCodEscolhido  = THIS.this_cLookupCodigo
1072: 				loc_cDescEscolhida = THIS.this_cLookupDescricao
1073: 			ENDIF
1074: 		ENDIF
1075: 
1076: 		IF USED("cursor_4c_TmpUnidade")
1077: 			USE IN cursor_4c_TmpUnidade
1078: 		ENDIF
1079: 
1080: 		SELECT (loc_cItens)
1081: 		IF EMPTY(loc_cCodEscolhido)
1082: 			par_oTxt.Value = ""
1083: 			REPLACE (par_cCampoDesc) WITH "", (par_cCampoCod) WITH ""
1084: 		ELSE
1085: 			par_oTxt.Value = loc_cDescEscolhida
1086: 			REPLACE (par_cCampoDesc) WITH loc_cDescEscolhida, (par_cCampoCod) WITH loc_cCodEscolhido
1087: 		ENDIF
1088: 	ENDPROC
1089: 
1090: 	*==========================================================================
1091: 	* ValidarAcabamentoKeyPress - legado SIGOPORC.grdItem.Column30.Text1.
1092: 	* Valid. O usuario digita a descricao do acabamento (dacabs); o metodo
1093: 	* busca em SigCdAca por LIKE e abre o picker local quando ha mais de
1094: 	* um resultado. Universo VAZIO (zero linhas) NAO e erro de migracao
1095: 	* (regra #50): manter o aviso do legado, mas NUNCA apagar o texto que

*-- Linhas 1118 a 1145:
1118: 		loc_cValor = ALLTRIM(loc_oTxt.Value)
1119: 
1120: 		IF EMPTY(loc_cValor)
1121: 			SELECT (loc_cItens)
1122: 			REPLACE codacabs WITH ""
1123: 			RETURN
1124: 		ENDIF
1125: 
1126: 		IF USED("cursor_4c_TmpAcabamento")
1127: 			USE IN cursor_4c_TmpAcabamento
1128: 		ENDIF
1129: 		loc_cSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Descrs LIKE " + EscaparSQL("%" + loc_cValor + "%")
1130: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpAcabamento")
1131: 
1132: 		IF loc_nResultado < 0
1133: 			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1134: 				"Falha na Conex" + CHR(227) + "o (SigCdAca)")
1135: 			RETURN
1136: 		ENDIF
1137: 
1138: 		loc_cDescEscolhida = ""
1139: 		loc_cCodEscolhido  = ""
1140: 
1141: 		IF USED("cursor_4c_TmpAcabamento") AND RECCOUNT("cursor_4c_TmpAcabamento") > 0
1142: 			THIS.AbrirBuscaAcabamento()
1143: 			loc_cCodEscolhido  = THIS.this_cLookupCodigo
1144: 			loc_cDescEscolhida = THIS.this_cLookupDescricao
1145: 		ELSE

*-- Linhas 1153 a 1188:
1153: 			USE IN cursor_4c_TmpAcabamento
1154: 		ENDIF
1155: 
1156: 		SELECT (loc_cItens)
1157: 		IF !EMPTY(loc_cCodEscolhido)
1158: 			loc_oTxt.Value = loc_cDescEscolhida
1159: 			REPLACE dacabs WITH loc_cDescEscolhida, codacabs WITH loc_cCodEscolhido
1160: 		ELSE
1161: 			REPLACE codacabs WITH ""
1162: 		ENDIF
1163: 	ENDPROC
1164: 
1165: 	*==========================================================================
1166: 	* ValidarProdutoItemKeyPress - legado SIGOPORC.grdItem.Column1.Text1.
1167: 	* Valid (o trecho de LOOKUP; a precificacao automatica que vem depois
1168: 	* dele no dump depende de crSigCdOpe/crSigOpCdd, carregados em fase
1169: 	* propria do BO - ver cabecalho da classe).
1170: 	*
1171: 	* O usuario digita parte da DESCRICAO do produto (Dpros); o metodo
1172: 	* consulta SigCdPro com a restricao de SigCdRpo (Dopps = Dopes do
1173: 	* cabecalho) - quando a restricao existe, o legado faz INNER JOIN; sem
1174: 	* restricao, consulta SigCdPro direto. Resolve por busca exata e, se
1175: 	* nao casar, abre o picker.
1176: 	*
1177: 	* Guardas TRANSCRITAS do legado (regra #21b - a condicao que cerca a
1178: 	* validacao FAZ PARTE dela):
1179: 	*   - valor nao mudou desde a entrada na celula (this_cAntDpros,
1180: 	*     comparado com PADR(...,40) igual ao legado) -> sai sem consultar
1181: 	*   - linha de SUBTOTAL (citens = citem2) ou de marcador de nivel
1182: 	*     (citens = citem3) -> o legado NAO faz lookup: nessas linhas a
1183: 	*     descricao digitada e so o rotulo do bloco, propagado para o
1184: 	*     dpro2s das linhas de SUBTOTAL do mesmo agrupamento
1185: 	*
1186: 	* O valor digitado esta em .Value (o cursor so recebe DEPOIS, via
1187: 	* REPLACE - regra #46), e a descricao escolhida volta para .Value alem
1188: 	* do REPLACE, senao o texto digitado sobrescreveria o cursor.

*-- Linhas 1206 a 1343:
1206: 
1207: 		loc_cValor = ALLTRIM(TratarNulo(loc_oTxt.Value, ""))
1208: 
1209: 		SELECT (loc_cItens)
1210: 		loc_nItens = citens
1211: 		loc_nItem2 = citem2
1212: 		loc_nItem3 = citem3
1213: 
1214: 		*-- Linha de SUBTOTAL / marcador de nivel: sem lookup. O legado
1215: 		*-- propaga o rotulo digitado para o dpro2s das linhas de SUBTOTAL
1216: 		*-- do mesmo agrupamento e volta ao item corrente por SEEK no TAG
1217: 		*-- citens.
1218: 		IF loc_nItens = loc_nItem2 OR loc_nItens = loc_nItem3
1219: 			IF loc_nItens = loc_nItem2 AND loc_nItens = loc_nItem3
1220: 				REPLACE dpro2s WITH loc_cValor ;
1221: 					FOR citem3 = loc_nItens AND citem2 = citens AND cblocos = "SUBTOTAL" ;
1222: 					IN (loc_cItens)
1223: 			ELSE
1224: 				REPLACE dpro2s WITH loc_cValor ;
1225: 					FOR citem2 = loc_nItem2 AND cblocos = "SUBTOTAL" ;
1226: 					IN (loc_cItens)
1227: 			ENDIF
1228: 			SELECT (loc_cItens)
1229: 			=SEEK(loc_nItens, loc_cItens, "citens")
1230: 			THIS.this_cAntDpros = loc_cValor
1231: 			THIS.grd_4c_Itens.Refresh()
1232: 			RETURN
1233: 		ENDIF
1234: 
1235: 		*-- Valor nao mudou desde que o usuario entrou na celula
1236: 		IF PADR(loc_cValor, 40) = PADR(ALLTRIM(TratarNulo(THIS.this_cAntDpros, "")), 40)
1237: 			RETURN
1238: 		ENDIF
1239: 
1240: 		IF EMPTY(loc_cValor)
1241: 			SELECT (loc_cItens)
1242: 			REPLACE cpros WITH "", cunis WITH "", cunips WITH ""
1243: 			THIS.this_cAntDpros = ""
1244: 			RETURN
1245: 		ENDIF
1246: 
1247: 		*-- Ha restricao de grupo/grande grupo para esta movimentacao?
1248: 		IF USED("cursor_4c_RestricaoProduto")
1249: 			USE IN cursor_4c_RestricaoProduto
1250: 		ENDIF
1251: 		loc_cSQL = "SELECT Cgrus, Opers, Mercs, Contas, CodCors FROM SigCdRpo WHERE Dopps = " + ;
1252: 			EscaparSQL(THIS.this_cDopes)
1253: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RestricaoProduto")
1254: 
1255: 		IF loc_nResultado < 0
1256: 			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1257: 				"Falha na Conex" + CHR(227) + "o (SigCdRpo)")
1258: 			RETURN
1259: 		ENDIF
1260: 
1261: 		loc_lRestrito = (USED("cursor_4c_RestricaoProduto") AND ;
1262: 			RECCOUNT("cursor_4c_RestricaoProduto") > 0)
1263: 
1264: 		IF USED("cursor_4c_RestricaoProduto")
1265: 			USE IN cursor_4c_RestricaoProduto
1266: 		ENDIF
1267: 
1268: 		IF USED("cursor_4c_BuscaProduto")
1269: 			USE IN cursor_4c_BuscaProduto
1270: 		ENDIF
1271: 
1272: 		loc_cSQL = "SELECT a.Cpros, a.Dpros, a.Dpro2s, a.Cunis, a.cUniPs," + ;
1273: 			" a.Situas, a.DtSituas, a.Cgrus, a.Mercs" + ;
1274: 			" FROM SigCdPro a"
1275: 		IF loc_lRestrito
1276: 			loc_cSQL = loc_cSQL + ;
1277: 				" INNER JOIN SigCdRpo b ON (a.Cgrus = b.Cgrus OR a.Mercs = b.Mercs)" + ;
1278: 				" AND b.Dopps = " + EscaparSQL(THIS.this_cDopes)
1279: 		ENDIF
1280: 		loc_cSQL = loc_cSQL + ;
1281: 			" WHERE a.DPros LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
1282: 			" ORDER BY a.Cpros, a.Cgrus"
1283: 
1284: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProduto")
1285: 
1286: 		IF loc_nResultado < 0
1287: 			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1288: 				"Falha na Conex" + CHR(227) + "o (SigCdPro)")
1289: 			RETURN
1290: 		ENDIF
1291: 
1292: 		loc_cCodEscolhido  = ""
1293: 		loc_cDescEscolhida = ""
1294: 		loc_cDescritivo    = ""
1295: 		loc_cCunis         = ""
1296: 		loc_cCunips        = ""
1297: 
1298: 		IF USED("cursor_4c_BuscaProduto") AND RECCOUNT("cursor_4c_BuscaProduto") > 0
1299: 			SELECT cursor_4c_BuscaProduto
1300: 			GO TOP
1301: 			LOCATE FOR ALLTRIM(UPPER(Dpros)) == UPPER(loc_cValor)
1302: 
1303: 			IF !FOUND()
1304: 				*-- Busca exata falhou: picker sobre o cursor JA populado
1305: 				*-- (equivale ao fwBuscaInt do legado). Regra #50: sem aviso
1306: 				*-- e sem apagar o que o usuario digitou.
1307: 				THIS.AbrirBuscaProdutoItem()
1308: 				IF !EMPTY(THIS.this_cLookupCodigo) AND USED("cursor_4c_BuscaProduto")
1309: 					SELECT cursor_4c_BuscaProduto
1310: 					GO TOP
1311: 					LOCATE FOR ALLTRIM(Cpros) == ALLTRIM(THIS.this_cLookupCodigo)
1312: 				ENDIF
1313: 			ENDIF
1314: 
1315: 			IF FOUND()
1316: 				loc_cCodEscolhido  = ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.Cpros, ""))
1317: 				loc_cDescEscolhida = ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.Dpros, ""))
1318: 				loc_cDescritivo    = ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.Dpro2s, ""))
1319: 				loc_cCunis         = ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.Cunis, ""))
1320: 				loc_cCunips        = ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.cUniPs, ""))
1321: 			ENDIF
1322: 		ENDIF
1323: 
1324: 		IF USED("cursor_4c_BuscaProduto")
1325: 			USE IN cursor_4c_BuscaProduto
1326: 		ENDIF
1327: 
1328: 		SELECT (loc_cItens)
1329: 		IF !EMPTY(loc_cCodEscolhido)
1330: 			loc_oTxt.Value = loc_cDescEscolhida
1331: 			REPLACE cpros  WITH loc_cCodEscolhido, ;
1332: 				dpros  WITH loc_cDescEscolhida, ;
1333: 				dpro2s WITH IIF(EMPTY(ALLTRIM(TratarNulo(dpro2s, ""))), loc_cDescritivo, dpro2s), ;
1334: 				cunis  WITH loc_cCunis, ;
1335: 				cunips WITH loc_cCunips
1336: 			THIS.this_cAntDpros = loc_cDescEscolhida
1337: 		ENDIF
1338: 
1339: 		THIS.grd_4c_Itens.Refresh()
1340: 	ENDPROC
1341: 
1342: 	*==========================================================================
1343: 	* AbrirBuscaProdutoItem - picker do lookup de produto da celula

*-- Linhas 1519 a 1582:
1519: 	* Column.Width e Column.Header1.Caption (regra #41 / Problema 48), entao
1520: 	* os dois tem de ser reaplicados DEPOIS de cada bind - e o bind acontece
1521: 	* mais de uma vez (toda vez que o cursor de itens e recriado pelo funil
1522: 	* CarregarDados). Ordem canonica: RecordSource -> ControlSource ->
1523: 	* Width -> Header1.Caption.
1524: 	*
1525: 	* O bind e CONDICIONADO a USED(cursor): instanciado sem cursor (harness de
1526: 	* teste), atribuir RecordSource estouraria "Alias is not found". Width e
1527: 	* Header1.Caption sao aplicados SEMPRE, com ou sem alias aberto - senao a
1528: 	* grade apareceria com cabecalho "Column1" e largura default.
1529: 	*==========================================================================
1530: 	PROTECTED PROCEDURE VincularGradeItens()
1531: 		LOCAL loc_cCursor
1532: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
1533: 
1534: 		WITH THIS.grd_4c_Itens
1535: 			IF USED(loc_cCursor)
1536: 				.RecordSource = loc_cCursor
1537: 
1538: 				.Column1.ControlSource = loc_cCursor + ".dpros"
1539: 				.Column2.ControlSource = loc_cCursor + ".dpro2s"
1540: 				.Column3.ControlSource = loc_cCursor + ".qtds"
1541: 				.Column4.ControlSource = loc_cCursor + ".dcunis"
1542: 				.Column5.ControlSource = loc_cCursor + ".pesos"
1543: 				.Column6.ControlSource = loc_cCursor + ".dcunips"
1544: 				.Column7.ControlSource = loc_cCursor + ".fators"
1545: 				.Column8.ControlSource = loc_cCursor + ".units"
1546: 				.Column9.ControlSource = loc_cCursor + ".totas"
1547: 				.Column10.ControlSource = loc_cCursor + ".tota1s"
1548: 				.Column11.ControlSource = loc_cCursor + ".tota2s"
1549: 				.Column12.ControlSource = loc_cCursor + ".tota3s"
1550: 				.Column13.ControlSource = loc_cCursor + ".tota4s"
1551: 				.Column14.ControlSource = loc_cCursor + ".tota5s"
1552: 				.Column15.ControlSource = loc_cCursor + ".tota6s"
1553: 				.Column16.ControlSource = loc_cCursor + ".obs"
1554: 				.Column17.ControlSource = loc_cCursor + ".tota7s"
1555: 				.Column18.ControlSource = loc_cCursor + ".tota8s"
1556: 				.Column19.ControlSource = loc_cCursor + ".tota9s"
1557: 				.Column20.ControlSource = loc_cCursor + ".tota10s"
1558: 				.Column21.ControlSource = loc_cCursor + ".notas"
1559: 				.Column22.ControlSource = loc_cCursor + ".perc4s"
1560: 				.Column23.ControlSource = loc_cCursor + ".perc5s"
1561: 				.Column24.ControlSource = loc_cCursor + ".perc6s"
1562: 				.Column25.ControlSource = loc_cCursor + ".perc2s"
1563: 				.Column26.ControlSource = loc_cCursor + ".perc3s"
1564: 				.Column27.ControlSource = loc_cCursor + ".servicos"
1565: 				.Column28.ControlSource = loc_cCursor + ".debitos"
1566: 				.Column29.ControlSource = loc_cCursor + ".taxas"
1567: 				.Column30.ControlSource = loc_cCursor + ".dacabs"
1568: 			ENDIF
1569: 
1570: 			*-- Width/Header1.Caption SEMPRE depois do bind (RecordSource reseta
1571: 			*-- os dois para 90 / "Column<N>"). Transcritos do dump do legado.
1572: 			.Column1.Width           = 290
1573: 			.Column1.Header1.Caption = "Item"
1574: 			.Column2.Width           = 290
1575: 			.Column2.Header1.Caption = "Descritivo"
1576: 			.Column3.Width           = 122
1577: 			.Column3.Header1.Caption = "Quantidade"
1578: 			.Column4.Width           = 150
1579: 			.Column4.Header1.Caption = "Unidade"
1580: 			.Column5.Width           = 45
1581: 			.Column5.Header1.Caption = "Per" + CHR(237) + "odo"
1582: 			.Column6.Width           = 150

*-- Linhas 1727 a 1780:
1727: 	*
1728: 	* dfors NAO e coluna de SigMvOrp - e PROJECAO: o legado liga
1729: 	* grdParcela.Column6 a crSigMvOrp.Dfors, que e a razao social do
1730: 	* fornecedor (SigCdCli.RClis) trazida pelo join em Ifors. Fica vazia
1731: 	* ate a fase do BO que monta a consulta com o join.
1732: 	*
1733: 	* A ORDEM DOS CAMPOS deste CREATE CURSOR e a unica do form (regra
1734: 	* OPERACIONAL #2): qualquer outro ponto que venha a recriar o cursor
1735: 	* tem de chamar ESTE metodo, nunca repetir o CREATE CURSOR.
1736: 	*==========================================================================
1737: 	PROTECTED PROCEDURE CriarCursorParcelas()
1738: 		LOCAL loc_cCursor
1739: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorParcelas
1740: 
1741: 		IF USED(loc_cCursor)
1742: 			USE IN (loc_cCursor)
1743: 		ENDIF
1744: 
1745: 		SET NULL ON
1746: 		CREATE CURSOR (loc_cCursor) ;
1747: 			(cidchaves C(20), citens N(10,0), datas D, dopes C(29), ;
1748: 			 empdopnums C(29), emps C(3), numes N(6,0), percs N(5,2), ;
1749: 			 valos N(13,2), vlbaixas N(12,2), borderos N(10,0), ;
1750: 			 ifors C(10), valcreds N(13,2), dfors C(50))
1751: 		SET NULL OFF
1752: 
1753: 		*-- Legado (fim do Init): Select crSigMvOrp / Set Order to / Set Order
1754: 		*-- to CItens - a grade de parcelas e sempre vista pela ordem do item,
1755: 		*-- porque e por essa chave que PosicionarParcelasDoItem filtra.
1756: 		INDEX ON citens TAG citens
1757: 	ENDPROC
1758: 
1759: 	*==========================================================================
1760: 	* ConfigurarGradeParcelas - grd_4c_Parcelas, equivalente ao
1761: 	* SIGOPORC.grdParcela (7 colunas). Geometria/fonte/cor/ColumnOrder
1762: 	* TRANSCRITOS do dump ("PROPRIEDADES DE: SIGOPORC.grdParcela").
1763: 	*
1764: 	* Igual a grade de itens, aqui fica SO o que nao depende de dado;
1765: 	* RecordSource/ControlSource/Width/Header1.Caption vao em
1766: 	* VincularGradeParcelas().
1767: 	*
1768: 	* ReadOnly por coluna transcrito do Init legado ("With ThisForm.grdParcela"):
1769: 	* Column4 (Fornecedor), Column6 (Descricao) e Column7 (Credito) sao
1770: 	* ReadOnly = .T. SEMPRE - sao projecao/valor calculado, nao entrada; as
1771: 	* demais seguem o modo (CONSULTAR = somente leitura). O ReadOnly da
1772: 	* COLUNA vem DEPOIS do ReadOnly do GRID, senao o do grid sobrescreve
1773: 	* (regra #46).
1774: 	*==========================================================================
1775: 	PROTECTED PROCEDURE ConfigurarGradeParcelas()
1776: 		LOCAL loc_lSoLeitura
1777: 		loc_lSoLeitura = (THIS.this_cOpEscolha = "CONSULTAR")
1778: 
1779: 		THIS.AddObject("grd_4c_Parcelas", "Grid")
1780: 

*-- Linhas 1793 a 1811:
1793: 			.RowHeight    = 16
1794: 			.Panel        = 1
1795: 			.ScrollBars   = 3
1796: 			.DeleteMark   = .F.
1797: 			.RecordMark   = .F.
1798: 			.TabIndex     = 25
1799: 			.ReadOnly     = loc_lSoLeitura
1800: 
1801: 			*-- Column1 (% - percs)
1802: 			.Column1.ColumnOrder       = 3
1803: 			.Column1.FontName          = "Tahoma"
1804: 			.Column1.FontSize          = 8
1805: 			.Column1.ForeColor         = RGB(90, 90, 90)
1806: 			.Column1.Header1.Alignment = 2
1807: 			.Column1.Header1.FontSize  = 8
1808: 			.Column1.ReadOnly          = loc_lSoLeitura
1809: 
1810: 			*-- Column2 (Data - datas)
1811: 			.Column2.ColumnOrder       = 4

*-- Linhas 1871 a 1905:
1871: 	* Width/Header1.Caption, entao os dois vem DEPOIS do bind e sao
1872: 	* aplicados SEMPRE, com ou sem alias aberto. Bind condicionado a
1873: 	* USED(cursor) para nao estourar "Alias is not found" no harness.
1874: 	* ControlSource transcrito do Init legado ("With ThisForm.grdParcela").
1875: 	*==========================================================================
1876: 	PROTECTED PROCEDURE VincularGradeParcelas()
1877: 		LOCAL loc_cCursor
1878: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorParcelas
1879: 
1880: 		WITH THIS.grd_4c_Parcelas
1881: 			IF USED(loc_cCursor)
1882: 				.RecordSource = loc_cCursor
1883: 
1884: 				.Column1.ControlSource = loc_cCursor + ".percs"
1885: 				.Column2.ControlSource = loc_cCursor + ".datas"
1886: 				.Column3.ControlSource = loc_cCursor + ".valos"
1887: 				.Column4.ControlSource = loc_cCursor + ".ifors"
1888: 				.Column5.ControlSource = loc_cCursor + ".vlbaixas"
1889: 				.Column6.ControlSource = loc_cCursor + ".dfors"
1890: 				.Column7.ControlSource = loc_cCursor + ".valcreds"
1891: 			ENDIF
1892: 
1893: 			*-- Width/Header1.Caption SEMPRE depois do bind. Transcritos do
1894: 			*-- dump (PROPRIEDADES DE: SIGOPORC.grdParcela + o Header1 de cada
1895: 			*-- Column no layout do legado).
1896: 			.Column1.Width           = 70
1897: 			.Column1.Header1.Caption = "%"
1898: 			.Column2.Width           = 70
1899: 			.Column2.Header1.Caption = "Data"
1900: 			.Column3.Width           = 122
1901: 			.Column3.Header1.Caption = "Previsto"
1902: 			.Column4.Width           = 80
1903: 			.Column4.Header1.Caption = "Fornecedor"
1904: 			.Column5.Width           = 122
1905: 			.Column5.Header1.Caption = "Realizado"

*-- Linhas 1993 a 2023:
1993: 
1994: 		THIS.LockScreen = .T.
1995: 
1996: 		SELECT (loc_cItens)
1997: 		loc_lPodeIncluir = (citens <> citem2) AND !EMPTY(cpros) AND ;
1998: 			!INLIST(ALLTRIM(cblocos), "SUBTOTAL", "BRANCO", "SUBTOTAIS", ;
1999: 				"TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
2000: 		loc_nItem = citens
2001: 
2002: 		IF loc_lPodeIncluir
2003: 			INSERT INTO (loc_cParcelas) ;
2004: 				(emps, dopes, numes, citens, datas, valos, vlbaixas) ;
2005: 				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
2006: 					loc_nItem, CTOD(""), 0, 0)
2007: 
2008: 			SELECT (loc_cParcelas)
2009: 			GO BOTTOM
2010: 		ENDIF
2011: 
2012: 		THIS.grd_4c_Parcelas.Refresh()
2013: 		THIS.LockScreen = .F.
2014: 
2015: 		*-- Legado: thisform.grdParcela.column4.SetFocus()
2016: 		THIS.grd_4c_Parcelas.Column4.SetFocus()
2017: 	ENDPROC
2018: 
2019: 	*==========================================================================
2020: 	* BtnExcluirParcelaClick - legado SIGOPORC.btnExcluirp.Click. Exclui a
2021: 	* parcela corrente, recusando a exclusao quando ela JA FOI BAIXADA
2022: 	* (VlBaixas preenchido) - a regra e a mensagem sao do legado.
2023: 	*

*-- Linhas 2037 a 2093:
2037: 			RETURN
2038: 		ENDIF
2039: 
2040: 		SELECT (loc_cParcelas)
2041: 
2042: 		IF !EMPTY(vlbaixas)
2043: 			*-- Legado: "A parcela ja joi autorizada!" - o "joi" e erro de
2044: 			*-- digitacao do original, visivel ao usuario; aqui sai "foi",
2045: 			*-- sem mudar o sentido da mensagem.
2046: 			MsgAviso("A parcela j" + CHR(225) + " foi autorizada!", ;
2047: 				"Imposs" + CHR(237) + "vel excluir")
2048: 		ELSE
2049: 			THIS.LockScreen = .T.
2050: 
2051: 			IF !EOF(loc_cParcelas)
2052: 				DELETE
2053: 				GO TOP
2054: 			ENDIF
2055: 
2056: 			THIS.grd_4c_Parcelas.Refresh()
2057: 			THIS.LockScreen = .F.
2058: 
2059: 			*-- Legado: thisform.grdParcela.column1.SetFocus()
2060: 			THIS.grd_4c_Parcelas.Column1.SetFocus()
2061: 		ENDIF
2062: 	ENDPROC
2063: 
2064: 	*==========================================================================
2065: 	* ConfigurarCamposPercentuais - Shape4 (moldura decorativa) + os 6
2066: 	* campos de percentual do cabecalho (say5/getPmargem .. Say6/
2067: 	* getPservico do legado). TRANSCRITOS do dump (bloco "PROPRIEDADES
2068: 	* DE: SIGOPORC.<nome>"), pareados por proximidade de Top (label.Top =
2069: 	* textbox.Top + 3, conferido um a um):
2070: 	*
2071: 	*   Say5 "Margem :...%"            (96)  <-> getPmargem      (93)  - SEM ControlSource; When sempre .F. (resultado calculado por TotalizarItn, nunca digitado)
2072: 	*   say4 "Contingente :...%"       (116) <-> getPtax2        (113) - ControlSource = TprMvCab.ptax2s (Perc1s)
2073: 	*   say1 "Ta\<xa Adm. :...%"       (136) <-> getPtaxa        (133) - ControlSource = TprMvCab.descs  (Perc2s)
2074: 	*   Say3 "BV :...%"                (156) <-> getPTax1        (153) - ControlSource = TprMvCab.ptax1s (Perc3s)
2075: 	*   say2 "Im\<posto :...%"         (176) <-> getPimposto     (173) - ControlSource = TprMvCab.acres  (Perc4s, item nao-servico)
2076: 	*   Say6 "Imposto sem ISS :...%"   (196) <-> getPservico     (193) - ControlSource = TprMvCab.ptax3s (Perc4s, item servico)
2077: 	*
2078: 	* Nenhum dos 5 TextBoxes editaveis usa ControlSource aqui: TprMvCab e
2079: 	* cursor do FORM PAI no legado (nao existe neste dialogo), e os 5
2080: 	* valores correspondentes (this_nPTax2s/this_nDescs/this_nPTax1s/
2081: 	* this_nAcres/this_nPTax3s) sao escalares do BO, repassados uma unica
2082: 	* vez na abertura (nao mudam por item) - a sincronizacao e manual
2083: 	* (.Value lido/escrito direto), igual ao padrao ja usado para
2084: 	* this_cEmps/this_cDopes/etc.
2085: 	*
2086: 	* SIMPLIFICACAO DOCUMENTADA: o legado guarda This.PEAntValue (property
2087: 	* da classe fwget) e so executa a cascata de Replace quando
2088: 	* "this.Value <> this.peantvalue" (evita reprocessar se o usuario so
2089: 	* passou pelo campo sem alterar). Como a cascata e IDEMPOTENTE (mesmo
2090: 	* valor de entrada sempre produz o mesmo resultado), replicar esse
2091: 	* guard exigiria 5 handlers de GotFocus extras so para guardar o
2092: 	* valor anterior em .Tag - trocado aqui por executar a cascata sempre
2093: 	* que o valor NAO esta vazio, no Enter/Tab (regra "BINDEVENT Valid nao

*-- Linhas 2347 a 2365:
2347: 
2348: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2349: 		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
2350: 			SELECT (loc_cItens)
2351: 			loc_nItens = citens
2352: 			SCAN
2353: 				REPLACE perc1s WITH loc_nValor, ;
2354: 					tota1s WITH (totas * loc_nValor) / 100, ;
2355: 					tota2s WITH ((totas + tota1s) * perc2s) / 100, ;
2356: 					tota3s WITH ((totas + tota1s + tota2s) * perc3s) / 100, ;
2357: 					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2358: 					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2359: 			ENDSCAN
2360: 			= SEEK(loc_nItens, loc_cItens, "citens")
2361: 		ENDIF
2362: 
2363: 		THIS.TotalizarItn()
2364: 	ENDPROC
2365: 

*-- Linhas 2386 a 2404:
2386: 
2387: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2388: 		IF USED(loc_cItens)
2389: 			SELECT (loc_cItens)
2390: 			loc_nItens = citens
2391: 
2392: 			IF THIS.this_oBusinessObject.this_nDivNotas = 2
2393: 				SCAN
2394: 					REPLACE perc2s WITH loc_nValor, ;
2395: 						tota2s WITH ((totas + tota1s) * loc_nValor) / 100, ;
2396: 						tota3s WITH ((totas + tota1s + tota2s) * perc3s) / 100, ;
2397: 						tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2398: 						tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2399: 				ENDSCAN
2400: 			ELSE
2401: 				GO TOP
2402: 				LOCATE FOR ALLTRIM(cblocos) == "TAXA"
2403: 				IF FOUND()
2404: 					REPLACE perc1s WITH loc_nValor, perc2s WITH loc_nValor, perc3s WITH loc_nValor

*-- Linhas 2433 a 2451:
2433: 
2434: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2435: 		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
2436: 			SELECT (loc_cItens)
2437: 			loc_nItens = citens
2438: 			SCAN
2439: 				REPLACE perc3s WITH loc_nValor, ;
2440: 					tota3s WITH ((totas + tota1s + tota2s) * loc_nValor) / 100, ;
2441: 					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2442: 					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2443: 			ENDSCAN
2444: 			= SEEK(loc_nItens, loc_cItens, "citens")
2445: 		ENDIF
2446: 
2447: 		THIS.TotalizarItn()
2448: 	ENDPROC
2449: 
2450: 	*==========================================================================
2451: 	* TxtImpostoKeyPress - legado SIGOPORC.getPimposto.Valid. Perc4s

*-- Linhas 2469 a 2487:
2469: 
2470: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2471: 		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
2472: 			SELECT (loc_cItens)
2473: 			loc_nItens = citens
2474: 			SCAN
2475: 				REPLACE perc4s WITH loc_nValor, ;
2476: 					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2477: 					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2478: 			ENDSCAN
2479: 			= SEEK(loc_nItens, loc_cItens, "citens")
2480: 		ENDIF
2481: 
2482: 		THIS.TotalizarItn()
2483: 	ENDPROC
2484: 
2485: 	*==========================================================================
2486: 	* TxtImpostoServicoKeyPress - legado SIGOPORC.getPservico.Valid.
2487: 	* Perc4s (imposto, variante "sem ISS") - aplicado SO nos itens

*-- Linhas 2505 a 2523:
2505: 
2506: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2507: 		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
2508: 			SELECT (loc_cItens)
2509: 			loc_nItens = citens
2510: 			SCAN FOR servicos
2511: 				REPLACE perc4s WITH loc_nValor, ;
2512: 					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2513: 					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2514: 			ENDSCAN
2515: 			= SEEK(loc_nItens, loc_cItens, "citens")
2516: 		ENDIF
2517: 
2518: 		THIS.TotalizarItn()
2519: 	ENDPROC
2520: 
2521: 	*==========================================================================
2522: 	* TotalizarItn - legado SIGOPORC.TotalizarItn. Motor de calculo
2523: 	* chamado por calc_valite (fase posterior) e pelos 5 campos de

*-- Linhas 2551 a 2569:
2551: 
2552: 		THIS.LockScreen = .T.
2553: 
2554: 		SELECT (loc_cItens)
2555: 		loc_nItens = citens
2556: 		loc_nItem2 = citem2
2557: 		loc_nItem3 = citem3
2558: 		loc_nItAgr = citagrs
2559: 
2560: 		IF THIS.this_oBusinessObject.this_nDivNotas = 2
2561: 			*-- P&G
2562: 			REPLACE tota1s WITH IIF(perc1s = 0, tota1s, (totas * perc1s) / 100), ;
2563: 				tota2s WITH IIF(perc2s = 0, tota2s, ((totas + tota1s) * perc2s) / 100), ;
2564: 				tota3s WITH IIF(perc3s = 0, tota3s, ((totas + tota1s + tota2s) * perc3s) / 100)
2565: 			REPLACE tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s))
2566: 			REPLACE tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2567: 		ELSE
2568: 			*-- SRCOM: total dos valores de NF SRCOM e fornecedor
2569: 			IF EMPTY(perc2s) AND EMPTY(perc3s)

*-- Linhas 2581 a 2687:
2581: 			IF INT(VAL(SUBSTR(THIS.this_oBusinessObject.this_cConfigGers, 192, 1))) = 1
2582: 				*-- Decupagem
2583: 				GO TOP
2584: 				SELECT SUM(totas) AS totas, SUM(tota1s) AS tota1s, SUM(tota2s) AS tota2s, SUM(tota3s) AS tota3s, ;
2585: 						SUM(tota7s) AS tota7s, SUM(tota8s) AS tota8s, SUM(tota9s) AS tota9s, SUM(tota10s) AS tota10s ;
2586: 					FROM (loc_cItens) WHERE citagrs = IIF(!EMPTY(loc_nItAgr), loc_nItAgr, loc_nItens) ;
2587: 					INTO CURSOR cursor_4c_TmpTotBlo
2588: 
2589: 				IF !EOF("cursor_4c_TmpTotBlo") AND !EMPTY(cursor_4c_TmpTotBlo.totas)
2590: 					SELECT (loc_cItens)
2591: 					= SEEK(IIF(!EMPTY(loc_nItAgr), loc_nItAgr, loc_nItens), loc_cItens, "citens")
2592: 
2593: 					REPLACE tota9s WITH IIF(!EMPTY(tota1s), tota1s - tota8s, tota2s) - tota7s, ;
2594: 						tota10s WITH IIF(!EMPTY(tota1s), 0, tota3s - tota8s)
2595: 
2596: 					REPLACE tota9s WITH tota9s - cursor_4c_TmpTotBlo.tota7s, ;
2597: 						tota10s WITH tota10s - cursor_4c_TmpTotBlo.tota8s
2598: 				ENDIF
2599: 			ENDIF
2600: 		ENDIF
2601: 
2602: 		SELECT (loc_cItens)
2603: 		GO TOP
2604: 
2605: 		SELECT SUM(totas) AS totas, SUM(tota1s) AS tota1s, SUM(tota2s) AS tota2s, SUM(tota3s) AS tota3s, ;
2606: 				SUM(tota4s) AS tota4s, SUM(tota5s) AS tota5s, SUM(tota6s) AS tota6s, SUM(tota7s) AS tota7s, ;
2607: 				SUM(tota8s) AS tota8s, SUM(tota9s) AS tota9s, SUM(tota10s) AS tota10s ;
2608: 			FROM (loc_cItens) ;
2609: 			WHERE citem2 = loc_nItem2 AND !INLIST(ALLTRIM(cblocos), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
2610: 			GROUP BY citem2 INTO CURSOR cursor_4c_TmpTotBlo
2611: 
2612: 		SELECT (loc_cItens)
2613: 		GO TOP
2614: 		LOCATE FOR citem2 = loc_nItem2 AND ALLTRIM(cblocos) == "SUBTOTAL"
2615: 		IF FOUND()
2616: 			REPLACE totas WITH cursor_4c_TmpTotBlo.totas, tota1s WITH cursor_4c_TmpTotBlo.tota1s, ;
2617: 				tota2s WITH cursor_4c_TmpTotBlo.tota2s, tota3s WITH cursor_4c_TmpTotBlo.tota3s, ;
2618: 				tota4s WITH cursor_4c_TmpTotBlo.tota4s, tota5s WITH cursor_4c_TmpTotBlo.tota5s, ;
2619: 				tota6s WITH cursor_4c_TmpTotBlo.tota6s, tota7s WITH cursor_4c_TmpTotBlo.tota7s, ;
2620: 				tota8s WITH cursor_4c_TmpTotBlo.tota8s, tota9s WITH cursor_4c_TmpTotBlo.tota9s, ;
2621: 				tota10s WITH cursor_4c_TmpTotBlo.tota10s
2622: 		ENDIF
2623: 
2624: 		SELECT (loc_cItens)
2625: 		GO TOP
2626: 
2627: 		SELECT SUM(totas) AS totas, SUM(tota1s) AS tota1s, SUM(tota2s) AS tota2s, SUM(tota3s) AS tota3s, ;
2628: 				SUM(tota4s) AS tota4s, SUM(tota5s) AS tota5s, SUM(tota6s) AS tota6s, SUM(tota7s) AS tota7s, ;
2629: 				SUM(tota8s) AS tota8s, SUM(tota9s) AS tota9s, SUM(tota10s) AS tota10s ;
2630: 			FROM (loc_cItens) ;
2631: 			WHERE citem3 = loc_nItem3 AND !INLIST(ALLTRIM(cblocos), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
2632: 			GROUP BY citem3 INTO CURSOR cursor_4c_TmpTotBlo
2633: 
2634: 		SELECT (loc_cItens)
2635: 		GO TOP
2636: 		LOCATE FOR citem3 = loc_nItem3 AND ALLTRIM(cblocos) == "SUBTOTAL" AND citens = citem2
2637: 		IF FOUND()
2638: 			REPLACE totas WITH cursor_4c_TmpTotBlo.totas, tota1s WITH cursor_4c_TmpTotBlo.tota1s, ;
2639: 				tota2s WITH cursor_4c_TmpTotBlo.tota2s, tota3s WITH cursor_4c_TmpTotBlo.tota3s, ;
2640: 				tota4s WITH cursor_4c_TmpTotBlo.tota4s, tota5s WITH cursor_4c_TmpTotBlo.tota5s, ;
2641: 				tota6s WITH cursor_4c_TmpTotBlo.tota6s, tota7s WITH cursor_4c_TmpTotBlo.tota7s, ;
2642: 				tota8s WITH cursor_4c_TmpTotBlo.tota8s, tota9s WITH cursor_4c_TmpTotBlo.tota9s, ;
2643: 				tota10s WITH cursor_4c_TmpTotBlo.tota10s
2644: 		ENDIF
2645: 
2646: 		SELECT (loc_cItens)
2647: 		GO TOP
2648: 
2649: 		SELECT SUM(totas) AS totas, SUM(tota1s) AS tota1s, SUM(tota2s) AS tota2s, SUM(tota3s) AS tota3s, ;
2650: 				SUM(IIF(taxas, tota1s, 0)) AS tota1ts, SUM(IIF(taxas, tota2s, 0)) AS tota2ts, SUM(IIF(taxas, tota3s, 0)) AS tota3ts, ;
2651: 				SUM(tota4s) AS tota4s, SUM(tota5s) AS tota5s, SUM(tota6s) AS tota6s, SUM(tota7s) AS tota7s, ;
2652: 				SUM(tota8s) AS tota8s, SUM(tota9s) AS tota9s, SUM(tota10s) AS tota10s ;
2653: 			FROM (loc_cItens) ;
2654: 			WHERE !INLIST(ALLTRIM(cblocos), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
2655: 			INTO CURSOR cursor_4c_TmpTotBlo
2656: 
2657: 		IF THIS.this_oBusinessObject.this_nDivNotas = 2
2658: 			SELECT (loc_cItens)
2659: 			GO TOP
2660: 			LOCATE FOR ALLTRIM(cblocos) == "TOTALGERAL"
2661: 			IF FOUND() AND !EMPTY(cursor_4c_TmpTotBlo.totas)
2662: 				REPLACE totas WITH cursor_4c_TmpTotBlo.totas, tota1s WITH cursor_4c_TmpTotBlo.tota1s, ;
2663: 					tota2s WITH cursor_4c_TmpTotBlo.tota2s, tota3s WITH cursor_4c_TmpTotBlo.tota3s, ;
2664: 					tota4s WITH cursor_4c_TmpTotBlo.tota4s, tota5s WITH cursor_4c_TmpTotBlo.tota5s, ;
2665: 					tota6s WITH cursor_4c_TmpTotBlo.tota6s, tota7s WITH cursor_4c_TmpTotBlo.tota7s, ;
2666: 					tota8s WITH cursor_4c_TmpTotBlo.tota8s, tota9s WITH cursor_4c_TmpTotBlo.tota9s, ;
2667: 					tota10s WITH cursor_4c_TmpTotBlo.tota10s
2668: 
2669: 				THIS.txt_4c_Margem.Value = ((tota1s + tota2s) / tota5s) * 100
2670: 			ENDIF
2671: 		ELSE
2672: 			SELECT (loc_cItens)
2673: 			GO TOP
2674: 			LOCATE FOR ALLTRIM(cblocos) == "SUBTOTAIS"
2675: 			IF FOUND()
2676: 				REPLACE totas WITH cursor_4c_TmpTotBlo.totas, tota1s WITH cursor_4c_TmpTotBlo.tota1s, ;
2677: 					tota2s WITH cursor_4c_TmpTotBlo.tota2s, tota3s WITH cursor_4c_TmpTotBlo.tota3s, ;
2678: 					tota4s WITH cursor_4c_TmpTotBlo.tota4s, tota5s WITH cursor_4c_TmpTotBlo.tota5s, ;
2679: 					tota6s WITH cursor_4c_TmpTotBlo.tota6s, tota7s WITH cursor_4c_TmpTotBlo.tota7s, ;
2680: 					tota8s WITH cursor_4c_TmpTotBlo.tota8s, tota9s WITH cursor_4c_TmpTotBlo.tota9s, ;
2681: 					tota10s WITH cursor_4c_TmpTotBlo.tota10s
2682: 
2683: 				loc_nSubtot = tota1s
2684: 
2685: 				*-- Avanca para a linha de TAXA (fee da produtora), imediatamente
2686: 				*-- apos o SUBTOTAIS - mesma premissa posicional do legado
2687: 				SKIP

*-- Linhas 2719 a 2750:
2719: 			ENDIF
2720: 		ENDIF
2721: 
2722: 		SELECT (loc_cItens)
2723: 		= SEEK(loc_nItens, loc_cItens, "citens")
2724: 
2725: 		IF USED(loc_cParcelas)
2726: 			SELECT (loc_cParcelas)
2727: 			SCAN
2728: 				IF !EMPTY(percs)
2729: 					*-- (Real SRCOM custos internos) * percentual + (real fornecedor) * percentual
2730: 					REPLACE valos WITH ((EVALUATE(loc_cItens + ".tota7s") * percs) / 100) + ((EVALUATE(loc_cItens + ".tota8s") * percs) / 100)
2731: 				ENDIF
2732: 			ENDSCAN
2733: 		ENDIF
2734: 
2735: 		SELECT (loc_cItens)
2736: 		THIS.LockScreen = .F.
2737: 		THIS.grd_4c_Itens.Refresh()
2738: 	ENDPROC
2739: 
2740: 	*==========================================================================
2741: 	* ConfigurarCampoNovoGrupo - Say_NewGrp/get_NewGrp do legado: grupo a
2742: 	* usar quando o produto novo cadastrado pelo btnCadPro (Fase 6) ainda
2743: 	* nao existe em SigCdPro. Geometria/MaxLength/ToolTipText TRANSCRITOS
2744: 	* do dump.
2745: 	*==========================================================================
2746: 	PROTECTED PROCEDURE ConfigurarCampoNovoGrupo()
2747: 		LOCAL loc_lPodeEditar
2748: 		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2749: 
2750: 		THIS.AddObject("lbl_4c_NovoGrupo", "Label")

*-- Linhas 2809 a 2840:
2809: 					USE IN cursor_4c_BuscaGrupo
2810: 				ENDIF
2811: 
2812: 				loc_cSQL = "SELECT a.Cgrus, a.DGrus FROM SigCdGrp a" + ;
2813: 					" INNER JOIN SigCdRpo b ON (a.Cgrus = b.Cgrus OR a.Mercs = b.Mercs)" + ;
2814: 					" WHERE b.Dopps = " + EscaparSQL(THIS.this_cDopes)
2815: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
2816: 
2817: 				IF loc_nResultado <= 0 OR RECCOUNT("cursor_4c_BuscaGrupo") = 0
2818: 					IF USED("cursor_4c_BuscaGrupo")
2819: 						USE IN cursor_4c_BuscaGrupo
2820: 					ENDIF
2821: 					loc_nResultado = SQLEXEC(gnConnHandle, "SELECT a.Cgrus, a.DGrus FROM SigCdGrp a", "cursor_4c_BuscaGrupo")
2822: 				ENDIF
2823: 
2824: 				IF loc_nResultado > 0 AND USED("cursor_4c_BuscaGrupo")
2825: 					SELECT cursor_4c_BuscaGrupo
2826: 					GO TOP
2827: 					LOCATE FOR ALLTRIM(Cgrus) == loc_cValorDigitado
2828: 
2829: 					IF FOUND()
2830: 						THIS.txt_4c_NovoGrupo.Value = ALLTRIM(Cgrus)
2831: 					ELSE
2832: 						*-- Codigo digitado nao existe no universo restrito:
2833: 						*-- abre o picker (equivale ao fwBuscaInt do legado).
2834: 						*-- Regra #50: cancelando (ESC) o digitado PERMANECE,
2835: 						*-- nao se apaga o campo nem se exibe aviso.
2836: 						THIS.AbrirBuscaNovoGrupo()
2837: 						IF !EMPTY(THIS.this_cLookupCodigo)
2838: 							THIS.txt_4c_NovoGrupo.Value = THIS.this_cLookupCodigo
2839: 						ENDIF
2840: 					ENDIF

*-- Linhas 2940 a 2979:
2940: 
2941: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2942: 		IF USED(loc_cItens)
2943: 			SELECT (loc_cItens)
2944: 			GO TOP
2945: 			LOCATE FOR LIKE("*" + loc_cValor + "*", dpros)
2946: 			THIS.grd_4c_Itens.Refresh()
2947: 		ENDIF
2948: 	ENDPROC
2949: 
2950: 	PROCEDURE ProcuraDpro2sKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2951: 		LOCAL loc_cItens, loc_cValor
2952: 
2953: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2954: 			RETURN
2955: 		ENDIF
2956: 
2957: 		loc_cValor = ALLTRIM(THIS.edt_4c_ProcuraDpro2s.Value)
2958: 		IF EMPTY(loc_cValor)
2959: 			RETURN
2960: 		ENDIF
2961: 
2962: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2963: 		IF USED(loc_cItens)
2964: 			SELECT (loc_cItens)
2965: 			GO TOP
2966: 			LOCATE FOR LIKE("*" + loc_cValor + "*", dpro2s)
2967: 			THIS.grd_4c_Itens.Refresh()
2968: 		ENDIF
2969: 	ENDPROC
2970: 
2971: 	*==========================================================================
2972: 	* ProcuraDprosLostFocus / ProcuraDpro2sLostFocus - legado: "If !Empty
2973: 	* (this.Value) / thisform.btnprocura.SetFocus()". So move o foco (nao
2974: 	* dispara busca nenhuma) - a busca ja rodou no Enter/Tab acima.
2975: 	*==========================================================================
2976: 	PROCEDURE ProcuraDprosLostFocus()
2977: 		IF !EMPTY(THIS.txt_4c_ProcuraDpros.Value)
2978: 			THIS.cmd_4c_Procurar.SetFocus()
2979: 		ENDIF

*-- Linhas 3025 a 3043:
3025: 
3026: 				loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
3027: 				IF USED(loc_cItens)
3028: 					SELECT (loc_cItens)
3029: 					loc_nItem = citens
3030: 					IF !EOF()
3031: 						SKIP
3032: 					ENDIF
3033: 					IF loc_lPorDpros
3034: 						LOCATE FOR LIKE("*" + loc_cProcura + "*", dpros) AND citens <> loc_nItem
3035: 					ELSE
3036: 						LOCATE FOR LIKE("*" + loc_cProcura + "*", dpro2s) AND citens <> loc_nItem
3037: 					ENDIF
3038: 					THIS.grd_4c_Itens.Refresh()
3039: 				ENDIF
3040: 			ENDIF
3041: 		ENDIF
3042: 	ENDPROC
3043: 

*-- Linhas 3094 a 3121:
3094: 				IF USED("cursor_4c_TmpFotoZom")
3095: 					USE IN cursor_4c_TmpFotoZom
3096: 				ENDIF
3097: 				loc_cSQL = "SELECT a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros)
3098: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFotoZom")
3099: 
3100: 				IF loc_nResultado < 1 OR !USED("cursor_4c_TmpFotoZom") OR RECCOUNT("cursor_4c_TmpFotoZom") = 0
3101: 					loc_lProsseguir = .F.
3102: 				ENDIF
3103: 			ENDIF
3104: 
3105: 			IF loc_lProsseguir
3106: 				SELECT cursor_4c_TmpFotoZom
3107: 				GO TOP
3108: 				loc_cFigJpgs = TratarNulo(cursor_4c_TmpFotoZom.FigJpgs, "")
3109: 				USE IN cursor_4c_TmpFotoZom
3110: 
3111: 				IF !EMPTY(loc_cFigJpgs)
3112: 					loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
3113: 					loc_cFoto = STRCONV( ;
3114: 						STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
3115: 							"data:image/png;base64,", ""), ;
3116: 							"data:image/jpeg;base64,", ""), ;
3117: 							"data:image/jpg;base64,", ""), 14)
3118: 					STRTOFILE(loc_cFoto, loc_cArqTemp)
3119: 
3120: 					IF FILE(loc_cArqTemp)
3121: 						loc_cCaption = "Produto : " + loc_cCpros + " - " + loc_cDpros

*-- Linhas 3150 a 3176:
3150: 
3151: 	*==========================================================================
3152: 	* ConfigurarDescritivoRodape - getDescritivo do legado: memo de rodape,
3153: 	* largura TOTAL, abaixo das duas grades. Por padrao (ControlSource =
3154: 	* TprMvCab.Obses, dado de cabecalho que esta fora do escopo deste BO)
3155: 	* o Init legado deixa INVISIVEL fora do modo Criacao - unico estado
3156: 	* alcancavel nesta fase, porque this_nDigItens so e preenchido em
3157: 	* fase posterior (SigCdOpe - ver cabecalho do BO). AtualizarModoCriacao
3158: 	* fica pronto para quando DigItens chegar: troca o ControlSource para
3159: 	* o Dpro2s do item corrente e mostra o campo (regra transcrita do
3160: 	* Init: "If Inlist(DigItens,6,7) ... thisform.getDescritivo.
3161: 	* ControlSource = [crSigMvOrc.Dpro2s] Else ... .Visible = .f.").
3162: 	*==========================================================================
3163: 	PROTECTED PROCEDURE ConfigurarDescritivoRodape()
3164: 		THIS.AddObject("edt_4c_DescritivoRodape", "EditBox")
3165: 		WITH THIS.edt_4c_DescritivoRodape
3166: 			.Top           = 481
3167: 			.Left          = 5
3168: 			.Width         = 989
3169: 			.Height        = 115
3170: 			.FontSize      = 8
3171: 			.SpecialEffect = 1
3172: 			.ForeColor     = RGB(0, 0, 0)
3173: 			.DisabledBackColor = RGB(255, 255, 255)
3174: 			.BorderColor   = RGB(100, 100, 100)
3175: 			.Value         = ""
3176: 			.Enabled       = .F.

*-- Linhas 3269 a 3291:
3269: 
3270: 		IF loc_lModoCriacao
3271: 			*-- Criacao: o descritivo do rodape entra ligado ao item corrente
3272: 			*-- (legado: getDescritivo.ControlSource = [crSigMvOrc.Dpro2s]) e
3273: 			*-- a linha de busca sai inteira.
3274: 			THIS.edt_4c_DescritivoRodape.Visible = .T.
3275: 			IF USED(loc_cItens)
3276: 				THIS.edt_4c_DescritivoRodape.ControlSource = loc_cItens + ".dpro2s"
3277: 			ENDIF
3278: 
3279: 			THIS.txt_4c_ProcuraDpros.Visible  = .F.
3280: 			THIS.edt_4c_ProcuraDpro2s.Visible = .F.
3281: 			THIS.cmd_4c_Procurar.Visible      = .F.
3282: 		ELSE
3283: 			THIS.edt_4c_DescritivoRodape.Visible = .F.
3284: 
3285: 			THIS.txt_4c_ProcuraDpros.Visible  = .T.
3286: 			THIS.edt_4c_ProcuraDpro2s.Visible = .T.
3287: 			THIS.cmd_4c_Procurar.Visible      = .T.
3288: 
3289: 			*-- Geometria do ramo P&G (ver DESVIO DOCUMENTADO no cabecalho):
3290: 			*-- sem a grade de parcelas, a grade de itens cresce ate a linha
3291: 			*-- de busca, que desce para o rodape.

*-- Linhas 3312 a 3350:
3312: 	*==========================================================================
3313: 	* PosicionarParcelasDoItem - Reproduz o fecho do Init legado:
3314: 	*
3315: 	*   Select crSigMvOrp / Set Order to / Set Order to CItens
3316: 	*   Set Key to crSigMvOrc.CItens / Go Top
3317: 	*
3318: 	* O SET KEY e o que faz a grade de parcelas mostrar SO as parcelas do
3319: 	* item corrente (mestre-detalhe por Citens) - sem ele a grade exibiria
3320: 	* as parcelas de TODOS os itens. Trocar ordem/chave de um alias NAO
3321: 	* repinta a grade ligada a ele, por isso o Refresh fica no funil
3322: 	* CarregarDados e no handler de troca de linha (regra #21).
3323: 	*==========================================================================
3324: 	PROTECTED PROCEDURE PosicionarParcelasDoItem()
3325: 		LOCAL loc_cItens, loc_cParcelas, loc_nItem
3326: 		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
3327: 		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
3328: 
3329: 		IF USED(loc_cParcelas)
3330: 			loc_nItem = 0
3331: 			IF USED(loc_cItens) AND !EOF(loc_cItens)
3332: 				loc_nItem = EVALUATE(loc_cItens + ".citens")
3333: 			ENDIF
3334: 
3335: 			SELECT (loc_cParcelas)
3336: 			SET ORDER TO
3337: 			SET ORDER TO TAG citens
3338: 			SET KEY TO loc_nItem
3339: 			GO TOP
3340: 		ENDIF
3341: 	ENDPROC
3342: 
3343: 	*==========================================================================
3344: 	* CarregarDados - FUNIL de carga da tela. PUBLIC de proposito: alem de
3345: 	* ser chamado pelo InicializarForm, o harness de teste
3346: 	* (TesteAutomatico.prg) o invoca de FORA da classe - com PROTECTED a
3347: 	* chamada estoura "Property CARREGARDADOS is not found", porque
3348: 	* PEMSTATUS(...,5) devolve .T. tambem para metodo protegido (regra #3).
3349: 	*
3350: 	* Ordem (a mesma do Init legado): garantir os cursores -> aplicar o

*-- Linhas 3380 a 3410:
3380: 			ENDIF
3381: 
3382: 			*-- Layout (quem aparece) ANTES da carga: AtualizarModoCriacao
3383: 			*-- liga o ControlSource de edt_4c_DescritivoRodape ao cursor e
3384: 			*-- fecha chamando HabilitarCampos/AjustarBotoesPorModo.
3385: 			THIS.AtualizarModoCriacao()
3386: 
3387: 			*-- Legado: AddCursor('SigMvOrc',...)/AddCursor('SigMvOrp',...) no
3388: 			*-- Init. Vincular as grades, ler do banco, posicionar os aliases
3389: 			*-- e repintar ficam todos em CarregarLista (funil de recarga),
3390: 			*-- para a primeira carga e as recargas seguintes seguirem
3391: 			*-- exatamente o mesmo caminho.
3392: 			loc_lSucesso = THIS.CarregarLista()
3393: 
3394: 			*-- Valores do cabecalho (percentuais) para a tela - no legado
3395: 			*-- vinham sozinhos pelo ControlSource = TprMvCab.<coluna>
3396: 			THIS.BOParaForm()
3397: 		CATCH TO loc_oErro
3398: 			MsgErro(loc_oErro.Message + CHR(13) + ;
3399: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3400: 				"Procedure: " + loc_oErro.Procedure, ;
3401: 				"Erro em Formsigoporc.CarregarDados")
3402: 		ENDTRY
3403: 
3404: 		RETURN loc_lSucesso
3405: 	ENDPROC
3406: 
3407: 	*==========================================================================
3408: 	* GradeItensAfterRowColChange - Troca de linha na grade de itens: refaz
3409: 	* o filtro da grade de parcelas (mestre-detalhe), espelha a descricao
3410: 	* do item nos campos de busca, reseta o modo de busca e atualiza a

*-- Linhas 3543 a 3565:
3543: 			IF USED("cursor_4c_TmpFotoItem")
3544: 				USE IN cursor_4c_TmpFotoItem
3545: 			ENDIF
3546: 			loc_cSQL = "SELECT a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros)
3547: 			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFotoItem")
3548: 
3549: 			IF loc_nResultado >= 1 AND USED("cursor_4c_TmpFotoItem") AND RECCOUNT("cursor_4c_TmpFotoItem") > 0
3550: 				SELECT cursor_4c_TmpFotoItem
3551: 				GO TOP
3552: 				loc_cFigJpgs = TratarNulo(cursor_4c_TmpFotoItem.FigJpgs, "")
3553: 				USE IN cursor_4c_TmpFotoItem
3554: 
3555: 				IF !EMPTY(loc_cFigJpgs)
3556: 					loc_cArqTemp = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + "SigOpPro.jpg"
3557: 					loc_cFoto = STRCONV( ;
3558: 						STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
3559: 							"data:image/png;base64,", ""), ;
3560: 							"data:image/jpeg;base64,", ""), ;
3561: 							"data:image/jpg;base64,", ""), 14)
3562: 
3563: 					IF STRTOFILE(loc_cFoto, loc_cArqTemp) > 0
3564: 						THIS.img_4c_Produto.Picture = loc_cArqTemp
3565: 						THIS.img_4c_Produto.Visible = .T.

*-- Linhas 3650 a 3696:
3650: 	*     default do cabecalho quando LocalEmp.DivNotas = 2 (P&G).
3651: 	* A persistencia em SQL (BO.Inserir) acontece so no fechamento/
3652: 	* confirmacao do dialogo (fase propria) - igual ao legado, que so
3653: 	* grava a grade inteira ao sair ("Zap In crTpmMvItn ... Insert into
3654: 	* crTpmMvItn from Memvar").
3655: 	*==========================================================================
3656: 	PROCEDURE BtnIncluirLinhaClick()
3657: 		LOCAL loc_cCursor, loc_nItem, loc_nItem2, loc_nItem3, loc_nItAgr, loc_cBloco
3658: 
3659: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3660: 			RETURN
3661: 		ENDIF
3662: 
3663: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
3664: 		IF !USED(loc_cCursor)
3665: 			RETURN
3666: 		ENDIF
3667: 
3668: 		SELECT (loc_cCursor)
3669: 		IF EOF() OR INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
3670: 			RETURN
3671: 		ENDIF
3672: 
3673: 		THIS.LockScreen = .T.
3674: 
3675: 		loc_nItem  = citens
3676: 		loc_nItem2 = citem2
3677: 		loc_nItem3 = citem3
3678: 		loc_nItAgr = citagrs
3679: 		loc_cBloco = cblocos
3680: 
3681: 		*-- Legado: "Select crSigMvOrc / Set Order To" ANTES do Scan - sem
3682: 		*-- remover a ordem controladora, atualizar a propria chave (Citens)
3683: 		*-- durante o Scan faria o VFP reprocessar/pular registros.
3684: 		SET ORDER TO
3685: 		SCAN FOR citens > loc_nItem
3686: 			REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 + 1), ;
3687: 				citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 + 1), ;
3688: 				citens WITH citens + 1, ;
3689: 				citagrs WITH IIF(EMPTY(citagrs) OR citagrs = loc_nItAgr, citagrs, citagrs + 1)
3690: 		ENDSCAN
3691: 
3692: 		APPEND BLANK
3693: 		REPLACE citens WITH loc_nItem + 1, citem2 WITH loc_nItem2, citem3 WITH loc_nItem3, ;
3694: 			cblocos WITH loc_cBloco, taxas WITH .T.
3695: 
3696: 		SET ORDER TO TAG citens

*-- Linhas 3725 a 3793:
3725: 			RETURN
3726: 		ENDIF
3727: 
3728: 		SELECT (loc_cCursor)
3729: 		IF EOF() OR INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
3730: 			RETURN
3731: 		ENDIF
3732: 
3733: 		THIS.LockScreen = .T.
3734: 
3735: 		IF citens = citem2
3736: 			*-- Cabecalho de BLOCO ou SUB-BLOCO
3737: 			loc_nItem  = citens
3738: 			loc_nItem2 = citem2
3739: 			loc_nItem3 = citem3
3740: 
3741: 			IF loc_nItem = loc_nItem2 AND loc_nItem = loc_nItem3
3742: 				*-- BLOCO: so apaga se nao houver NENHUM item real dentro dele
3743: 				SELECT COUNT(1) AS nitem FROM (loc_cCursor) ;
3744: 					WHERE citem3 = loc_nItem3 ;
3745: 					AND !INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
3746: 					AND !EMPTY(cpros) ;
3747: 					GROUP BY citem3 INTO CURSOR cursor_4c_TmpBloco
3748: 
3749: 				IF !USED("cursor_4c_TmpBloco") OR cursor_4c_TmpBloco.nitem = 0
3750: 					SELECT COUNT(1) AS nitem FROM (loc_cCursor) WHERE citem3 = loc_nItem3 INTO CURSOR cursor_4c_TmpBloco
3751: 					loc_nTotalItens = cursor_4c_TmpBloco.nitem
3752: 
3753: 					SELECT (loc_cCursor)
3754: 					DELETE FOR citem3 = loc_nItem3 ;
3755: 						AND !INLIST(ALLTRIM(NVL(cblocos, "")), "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
3756: 
3757: 					SET ORDER TO
3758: 					SCAN FOR citens > loc_nItem
3759: 						REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 - loc_nTotalItens), ;
3760: 							citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 - loc_nTotalItens), ;
3761: 							citens WITH citens - loc_nTotalItens, ;
3762: 							citagrs WITH citagrs - loc_nTotalItens
3763: 					ENDSCAN
3764: 				ENDIF
3765: 			ELSE
3766: 				*-- SUB-BLOCO: so apaga se nao houver NENHUM item real dentro dele
3767: 				SELECT COUNT(1) AS nitem FROM (loc_cCursor) ;
3768: 					WHERE citem2 = loc_nItem2 ;
3769: 					AND !INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
3770: 					AND !EMPTY(cpros) ;
3771: 					GROUP BY citem2 INTO CURSOR cursor_4c_TmpBloco
3772: 
3773: 				IF !USED("cursor_4c_TmpBloco") OR cursor_4c_TmpBloco.nitem = 0
3774: 					SELECT COUNT(1) AS nitem FROM (loc_cCursor) WHERE citem2 = loc_nItem2 INTO CURSOR cursor_4c_TmpBloco
3775: 					loc_nTotalItens = cursor_4c_TmpBloco.nitem
3776: 
3777: 					SELECT (loc_cCursor)
3778: 					DELETE FOR citem2 = loc_nItem2 ;
3779: 						AND !INLIST(ALLTRIM(NVL(cblocos, "")), "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
3780: 
3781: 					SET ORDER TO
3782: 					SCAN FOR citens > loc_nItem
3783: 						REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 - loc_nTotalItens), ;
3784: 							citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 - loc_nTotalItens), ;
3785: 							citens WITH citens - loc_nTotalItens, ;
3786: 							citagrs WITH citagrs - loc_nTotalItens
3787: 					ENDSCAN
3788: 				ENDIF
3789: 			ENDIF
3790: 
3791: 			IF USED("cursor_4c_TmpBloco")
3792: 				USE IN cursor_4c_TmpBloco
3793: 			ENDIF

*-- Linhas 3806 a 3824:
3806: 				RETURN
3807: 			ENDIF
3808: 
3809: 			DELETE FOR citens = loc_nItem
3810: 
3811: 			SET ORDER TO
3812: 			SCAN FOR citens > loc_nItem
3813: 				REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 - 1), ;
3814: 					citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 - 1), ;
3815: 					citens WITH citens - 1, ;
3816: 					citagrs WITH IIF(EMPTY(citagrs) OR citagrs = loc_nItem, 0, citagrs - 1)
3817: 			ENDSCAN
3818: 
3819: 			SET ORDER TO TAG citens
3820: 			= SEEK(loc_nItem)
3821: 		ENDIF
3822: 
3823: 		THIS.grd_4c_Itens.Refresh()
3824: 		THIS.LockScreen = .F.

*-- Linhas 4049 a 4105:
4049: 		ENDIF
4050: 
4051: 		*-- TELA -> BO antes de qualquer validacao/gravacao: no legado os 5
4052: 		*-- percentuais do topo chegavam ao cabecalho sozinhos (ControlSource
4053: 		*-- = TprMvCab.<coluna>); aqui a transferencia e manual e passa por
4054: 		*-- FormParaBO (ver cabecalho dele).
4055: 		IF !THIS.FormParaBO()
4056: 			RETURN
4057: 		ENDIF
4058: 
4059: 		loc_lContinuar = .T.
4060: 
4061: 		TRY
4062: 			*-- Legado: as validacoes abaixo SO correm fora do modo P&G
4063: 			*-- (LocalEmp.DivNotas <> 2)
4064: 			IF THIS.this_oBusinessObject.this_nDivNotas <> 2
4065: 				SELECT (loc_cItens)
4066: 				SET ORDER TO TAG citens
4067: 				GO TOP
4068: 				LOCATE FOR perc2s + perc3s > 100
4069: 				IF FOUND()
4070: 					MsgAviso("Existe item com percentual de NF maior que 100%.", "Aviso")
4071: 					THIS.grd_4c_Itens.Column25.SetFocus()
4072: 					loc_lContinuar = .F.
4073: 				ENDIF
4074: 
4075: 				IF loc_lContinuar
4076: 					SELECT (loc_cItens)
4077: 					GO TOP
4078: 					LOCATE FOR perc4s + perc5s + perc6s > 100
4079: 					IF FOUND()
4080: 						MsgAviso("Existe item com percentual de incentivos maior que 100%.", "Aviso")
4081: 						THIS.grd_4c_Itens.Column22.SetFocus()
4082: 						loc_lContinuar = .F.
4083: 					ENDIF
4084: 				ENDIF
4085: 
4086: 				IF loc_lContinuar
4087: 					*-- Previsao de pagamento incompleta - varre TODAS as
4088: 					*-- parcelas (nao so as do item corrente): desliga o SET
4089: 					*-- KEY temporariamente e restaura no final.
4090: 					SELECT (loc_cParcelas)
4091: 					SET ORDER TO TAG citens
4092: 					SET KEY TO
4093: 					GO TOP
4094: 					SCAN
4095: 						IF !(EMPTY(ifors) AND EMPTY(percs) AND EMPTY(datas)) AND ;
4096: 								(EMPTY(ifors) OR EMPTY(percs) OR EMPTY(datas))
4097: 							loc_nItem  = citens
4098: 							loc_cDpros = ""
4099: 							IF SEEK(loc_nItem, loc_cItens, "citens")
4100: 								loc_cDpros = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".dpros"), ""))
4101: 							ENDIF
4102: 							MsgAviso("Existe previs" + CHR(227) + "o de pagamento no item '" + ;
4103: 								loc_cDpros + "' incompleta.", "Aviso")
4104: 							loc_lContinuar = .F.
4105: 							EXIT

*-- Linhas 4112 a 4165:
4112: 					IF USED("cursor_4c_TmpTotPrev")
4113: 						USE IN cursor_4c_TmpTotPrev
4114: 					ENDIF
4115: 					SELECT a.citens, a.dpros, (a.tota7s + a.tota8s) AS totreal, ;
4116: 							SUM(NVL(b.valos, 0)) AS totprev ;
4117: 						FROM (loc_cItens) a LEFT JOIN (loc_cParcelas) b ON a.citens = b.citens ;
4118: 						WHERE !EMPTY(a.cpros) ;
4119: 						GROUP BY a.citens, a.dpros, 3 ;
4120: 						HAVING totreal > 0 AND (ISNULL(totprev) OR totprev <> totreal) ;
4121: 						INTO CURSOR cursor_4c_TmpTotPrev
4122: 
4123: 					IF USED("cursor_4c_TmpTotPrev") AND RECCOUNT("cursor_4c_TmpTotPrev") > 0
4124: 						MsgAviso("Existe previs" + CHR(227) + "o de pagamento no item '" + ;
4125: 							ALLTRIM(cursor_4c_TmpTotPrev.dpros) + "' " + CHR(13) + ;
4126: 							"n" + CHR(227) + "o informada ou com valor diferente do Real Custos Internos + Real Fornecedor", ;
4127: 							"Aviso")
4128: 						THIS.grd_4c_Itens.Column1.SetFocus()
4129: 						loc_lContinuar = .F.
4130: 					ENDIF
4131: 
4132: 					IF USED("cursor_4c_TmpTotPrev")
4133: 						USE IN cursor_4c_TmpTotPrev
4134: 					ENDIF
4135: 				ENDIF
4136: 			ENDIF
4137: 
4138: 			IF loc_lContinuar
4139: 				*-- Legado: "Delete For Empty(Dpros) And Citens<>Citem2 And cBlocos<>[BRANCO]"
4140: 				SELECT (loc_cItens)
4141: 				DELETE FOR EMPTY(dpros) AND citens <> citem2 AND ALLTRIM(cblocos) <> "BRANCO"
4142: 
4143: 				*-- Legado: "Delete For Empty(Ifors) And Empty(Percs) And Empty(Datas)"
4144: 				SELECT (loc_cParcelas)
4145: 				SET KEY TO
4146: 				DELETE FOR EMPTY(ifors) AND EMPTY(percs) AND EMPTY(datas)
4147: 
4148: 				*-- Persiste TODOS os itens remanescentes (ver nota da
4149: 				*-- diferenca arquitetural no cabecalho do metodo)
4150: 				SELECT (loc_cItens)
4151: 				SET ORDER TO TAG citens
4152: 				GO TOP
4153: 				SCAN
4154: 					THIS.this_oBusinessObject.CarregarDoCursor(loc_cItens)
4155: 					THIS.this_oBusinessObject.this_cEmps  = THIS.this_cEmps
4156: 					THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
4157: 					THIS.this_oBusinessObject.this_nNumes = THIS.this_nNumes
4158: 
4159: 					IF EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCidchaves, "")))
4160: 						loc_lItemOk = THIS.this_oBusinessObject.Inserir()
4161: 					ELSE
4162: 						loc_lItemOk = THIS.this_oBusinessObject.Atualizar()
4163: 					ENDIF
4164: 
4165: 					IF !loc_lItemOk

*-- Linhas 4178 a 4251:
4178: 				*-- de SigMvOrc; parcela nao tem propriedades proprias (regra
4179: 				*-- ja documentada no cabecalho de BtnIncluirParcelaClick: a
4180: 				*-- persistencia so acontece aqui, na confirmacao do dialogo)
4181: 				SELECT (loc_cParcelas)
4182: 				SET ORDER TO TAG citens
4183: 				GO TOP
4184: 				SCAN
4185: 					IF EMPTY(ALLTRIM(NVL(cidchaves, "")))
4186: 						loc_cChaveNova = LEFT(fUniqueIds(), 20)
4187: 
4188: 						loc_cSQL = "INSERT INTO SigMvOrp ("
4189: 						loc_cSQL = loc_cSQL + "cidchaves, citens, datas, dopes, empdopnums, emps,"
4190: 						loc_cSQL = loc_cSQL + " numes, percs, valos, vlbaixas, borderos, ifors, valcreds"
4191: 						loc_cSQL = loc_cSQL + ") VALUES ("
4192: 						loc_cSQL = loc_cSQL + EscaparSQL(loc_cChaveNova) + ","
4193: 						loc_cSQL = loc_cSQL + FormatarNumeroSQL(citens, 0) + ","
4194: 						loc_cSQL = loc_cSQL + FormatarDataSQL(datas) + ","
4195: 						loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 29)) + ","
4196: 						loc_cSQL = loc_cSQL + EscaparSQL(PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)) + ","
4197: 						loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEmps) + ","
4198: 						loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
4199: 						loc_cSQL = loc_cSQL + FormatarNumeroSQL(percs, 2) + ","
4200: 						loc_cSQL = loc_cSQL + FormatarNumeroSQL(valos, 2) + ","
4201: 						loc_cSQL = loc_cSQL + FormatarNumeroSQL(vlbaixas, 2) + ","
4202: 						loc_cSQL = loc_cSQL + FormatarNumeroSQL(NVL(borderos, 0), 0) + ","
4203: 						loc_cSQL = loc_cSQL + EscaparSQL(LEFT(ifors, 10)) + ","
4204: 						loc_cSQL = loc_cSQL + FormatarNumeroSQL(NVL(valcreds, 0), 2) + ")"
4205: 
4206: 						IF USED("cursor_4c_InsertParc")
4207: 							USE IN cursor_4c_InsertParc
4208: 						ENDIF
4209: 						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsertParc")
4210: 						IF USED("cursor_4c_InsertParc")
4211: 							USE IN cursor_4c_InsertParc
4212: 						ENDIF
4213: 
4214: 						IF loc_nResultado < 0
4215: 							MsgErro("Erro ao inserir previs" + CHR(227) + "o de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
4216: 							loc_lContinuar = .F.
4217: 							EXIT
4218: 						ENDIF
4219: 
4220: 						REPLACE cidchaves WITH loc_cChaveNova
4221: 					ELSE
4222: 						loc_cSQL = "UPDATE SigMvOrp SET"
4223: 						loc_cSQL = loc_cSQL + " citens = " + FormatarNumeroSQL(citens, 0) + ","
4224: 						loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(datas) + ","
4225: 						loc_cSQL = loc_cSQL + " percs = " + FormatarNumeroSQL(percs, 2) + ","
4226: 						loc_cSQL = loc_cSQL + " valos = " + FormatarNumeroSQL(valos, 2) + ","
4227: 						loc_cSQL = loc_cSQL + " vlbaixas = " + FormatarNumeroSQL(vlbaixas, 2) + ","
4228: 						loc_cSQL = loc_cSQL + " ifors = " + EscaparSQL(LEFT(ifors, 10))
4229: 						loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(cidchaves, 20))
4230: 
4231: 						IF USED("cursor_4c_UpdateParc")
4232: 							USE IN cursor_4c_UpdateParc
4233: 						ENDIF
4234: 						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdateParc")
4235: 						IF USED("cursor_4c_UpdateParc")
4236: 							USE IN cursor_4c_UpdateParc
4237: 						ENDIF
4238: 
4239: 						IF loc_nResultado < 0
4240: 							MsgErro("Erro ao atualizar previs" + CHR(227) + "o de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
4241: 							loc_lContinuar = .F.
4242: 							EXIT
4243: 						ENDIF
4244: 					ENDIF
4245: 				ENDSCAN
4246: 			ENDIF
4247: 		CATCH TO loc_oErro
4248: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4249: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4250: 				"Procedure: " + loc_oErro.Procedure, ;
4251: 				"Erro em Formsigoporc.BtnSalvarClick")

*-- Linhas 4304 a 4396:
4304: 			RETURN
4305: 		ENDIF
4306: 
4307: 		SELECT (loc_cItens)
4308: 		IF INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
4309: 			RETURN
4310: 		ENDIF
4311: 
4312: 		THIS.LockScreen = .T.
4313: 
4314: 		TRY
4315: 			SET ORDER TO TAG citens
4316: 
4317: 			loc_nItem  = IIF(EMPTY(citens), 0, citens)
4318: 			loc_nItem2 = IIF(EMPTY(citem2), 0, citem2)
4319: 			loc_nItem3 = IIF(EMPTY(citem3), 0, citem3)
4320: 			loc_cBloco = cblocos
4321: 
4322: 			SELECT MAX(citens) AS citens FROM (loc_cItens) WHERE citem3 = loc_nItem3 INTO CURSOR cursor_4c_TmpSub
4323: 			IF USED("cursor_4c_TmpSub") AND !EOF("cursor_4c_TmpSub") AND !EMPTY(cursor_4c_TmpSub.citens)
4324: 				IF SEEK(cursor_4c_TmpSub.citens, loc_cItens, "citens")
4325: 					loc_nItem  = EVALUATE(loc_cItens + ".citens")
4326: 					loc_nItem2 = EVALUATE(loc_cItens + ".citem2")
4327: 					loc_nItem3 = EVALUATE(loc_cItens + ".citem3")
4328: 					loc_cBloco = ""
4329: 				ENDIF
4330: 			ENDIF
4331: 			IF USED("cursor_4c_TmpSub")
4332: 				USE IN cursor_4c_TmpSub
4333: 			ENDIF
4334: 
4335: 			SELECT (loc_cItens)
4336: 			SET ORDER TO
4337: 			SCAN FOR citens > loc_nItem
4338: 				loc_nItAnt = citens
4339: 				REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 + 4), ;
4340: 					citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 + 4), ;
4341: 					citens WITH citens + 4
4342: 
4343: 				SELECT (loc_cParcelas)
4344: 				SET ORDER TO
4345: 				GO TOP
4346: 				REPLACE ALL citens WITH (loc_nItAnt + 4) * (-1) FOR citens = loc_nItAnt
4347: 				SELECT (loc_cItens)
4348: 			ENDSCAN
4349: 
4350: 			SELECT (loc_cParcelas)
4351: 			GO TOP
4352: 			REPLACE ALL citens WITH ABS(citens)
4353: 
4354: 			INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos) ;
4355: 				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, loc_nItem + 1, loc_nItem + 1, loc_nItem + 1, loc_cBloco)
4356: 
4357: 			INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros, dpro2s) ;
4358: 				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, loc_nItem + 4, loc_nItem + 4, loc_nItem + 1, "SUBTOTAL", "SUBTOTAL", loc_cBloco)
4359: 
4360: 			IF THIS.this_oBusinessObject.this_nDivNotas = 2
4361: 				SELECT (loc_cItens)
4362: 				GO TOP
4363: 				LOCATE FOR ALLTRIM(cblocos) == "TOTALGERAL"
4364: 				IF !FOUND()
4365: 					SELECT MAX(citens) AS citens FROM (loc_cItens) INTO CURSOR cursor_4c_TmpSub
4366: 					IF USED("cursor_4c_TmpSub") AND !EOF("cursor_4c_TmpSub")
4367: 						INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros) ;
4368: 							VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
4369: 								cursor_4c_TmpSub.citens + 1, cursor_4c_TmpSub.citens + 1, cursor_4c_TmpSub.citens, "BRANCO", "")
4370: 
4371: 						INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros) ;
4372: 							VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
4373: 								cursor_4c_TmpSub.citens + 2, cursor_4c_TmpSub.citens + 1, cursor_4c_TmpSub.citens, "TOTALGERAL", "TOTAL GERAL")
4374: 					ENDIF
4375: 					IF USED("cursor_4c_TmpSub")
4376: 						USE IN cursor_4c_TmpSub
4377: 					ENDIF
4378: 				ENDIF
4379: 			ENDIF
4380: 
4381: 			SELECT (loc_cItens)
4382: 			SET ORDER TO TAG citens
4383: 			= SEEK(loc_nItem + 1)
4384: 
4385: 			THIS.PosicionarParcelasDoItem()
4386: 		CATCH TO loc_oErro
4387: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4388: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4389: 				"Procedure: " + loc_oErro.Procedure, ;
4390: 				"Erro em Formsigoporc.BtnInserirBlocoClick")
4391: 		ENDTRY
4392: 
4393: 		THIS.grd_4c_Itens.Refresh()
4394: 		THIS.grd_4c_Parcelas.Refresh()
4395: 		THIS.LockScreen = .F.
4396: 		THIS.grd_4c_Itens.Column1.SetFocus()

*-- Linhas 4419 a 4513:
4419: 			RETURN
4420: 		ENDIF
4421: 
4422: 		SELECT (loc_cItens)
4423: 		IF INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
4424: 			RETURN
4425: 		ENDIF
4426: 
4427: 		THIS.LockScreen = .T.
4428: 
4429: 		TRY
4430: 			SET ORDER TO TAG citens
4431: 
4432: 			loc_nItem  = IIF(EMPTY(citens), 0, citens)
4433: 			loc_nItem2 = IIF(EMPTY(citem2), 0, citem2)
4434: 			loc_nItem3 = IIF(EMPTY(citem3), 0, citem3)
4435: 			loc_cBloco = cblocos
4436: 
4437: 			SELECT MAX(citens) AS citens FROM (loc_cItens) ;
4438: 				WHERE citem3 = loc_nItem3 AND citem2 = loc_nItem2 AND ALLTRIM(cblocos) == "SUBTOTAL" ;
4439: 				INTO CURSOR cursor_4c_TmpSub
4440: 			IF USED("cursor_4c_TmpSub") AND !EOF("cursor_4c_TmpSub") AND !EMPTY(cursor_4c_TmpSub.citens)
4441: 				IF SEEK(cursor_4c_TmpSub.citens, loc_cItens, "citens")
4442: 					loc_nItem  = EVALUATE(loc_cItens + ".citens")
4443: 					loc_nItem2 = EVALUATE(loc_cItens + ".citem2")
4444: 					loc_nItem3 = EVALUATE(loc_cItens + ".citem3")
4445: 					loc_cBloco = ""
4446: 				ENDIF
4447: 			ENDIF
4448: 			IF USED("cursor_4c_TmpSub")
4449: 				USE IN cursor_4c_TmpSub
4450: 			ENDIF
4451: 
4452: 			SELECT (loc_cItens)
4453: 			SET ORDER TO
4454: 			SCAN FOR citens > loc_nItem
4455: 				loc_nItAnt = citens
4456: 				REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 + 2), ;
4457: 					citem2 WITH citem2 + 2, ;
4458: 					citens WITH citens + 2
4459: 
4460: 				SELECT (loc_cParcelas)
4461: 				SET ORDER TO
4462: 				GO TOP
4463: 				REPLACE ALL citens WITH (loc_nItAnt + 2) * (-1) FOR citens = loc_nItAnt
4464: 				SELECT (loc_cItens)
4465: 			ENDSCAN
4466: 
4467: 			SELECT (loc_cParcelas)
4468: 			GO TOP
4469: 			REPLACE ALL citens WITH ABS(citens)
4470: 
4471: 			INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos) ;
4472: 				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, loc_nItem + 1, loc_nItem + 1, loc_nItem3, loc_cBloco)
4473: 
4474: 			INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros) ;
4475: 				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, loc_nItem + 2, loc_nItem + 1, loc_nItem3, "SUBTOTAL", "SUBTOTAL")
4476: 
4477: 			IF THIS.this_oBusinessObject.this_nDivNotas = 2
4478: 				SELECT (loc_cItens)
4479: 				GO TOP
4480: 				LOCATE FOR ALLTRIM(cblocos) == "TOTALGERAL"
4481: 				IF !FOUND()
4482: 					SELECT MAX(citens) AS citens FROM (loc_cItens) INTO CURSOR cursor_4c_TmpSub
4483: 					IF USED("cursor_4c_TmpSub") AND !EOF("cursor_4c_TmpSub")
4484: 						INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros) ;
4485: 							VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
4486: 								cursor_4c_TmpSub.citens + 1, cursor_4c_TmpSub.citens, cursor_4c_TmpSub.citens, "BRANCO", "")
4487: 
4488: 						INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros) ;
4489: 							VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
4490: 								cursor_4c_TmpSub.citens + 2, cursor_4c_TmpSub.citens, cursor_4c_TmpSub.citens, "TOTALGERAL", "TOTAL GERAL")
4491: 					ENDIF
4492: 					IF USED("cursor_4c_TmpSub")
4493: 						USE IN cursor_4c_TmpSub
4494: 					ENDIF
4495: 				ENDIF
4496: 			ENDIF
4497: 
4498: 			SELECT (loc_cItens)
4499: 			SET ORDER TO TAG citens
4500: 			= SEEK(loc_nItem + 1)
4501: 
4502: 			THIS.PosicionarParcelasDoItem()
4503: 		CATCH TO loc_oErro
4504: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4505: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4506: 				"Procedure: " + loc_oErro.Procedure, ;
4507: 				"Erro em Formsigoporc.BtnInserirSubBlocoClick")
4508: 		ENDTRY
4509: 
4510: 		THIS.grd_4c_Itens.Refresh()
4511: 		THIS.grd_4c_Parcelas.Refresh()
4512: 		THIS.LockScreen = .F.
4513: 		THIS.grd_4c_Itens.Column1.SetFocus()

*-- Linhas 4608 a 4642:
4608: 		ENDIF
4609: 
4610: 		IF !INLIST(THIS.this_oBusinessObject.this_nCadProds, 0, 2)
4611: 			SELECT (loc_cItens)
4612: 			IF EMPTY(cpros) AND EMPTY(THIS.txt_4c_NovoGrupo.Value)
4613: 				MsgAviso("Informe o grupo de produto para ser cadastrado!", "Aviso")
4614: 				IF THIS.txt_4c_NovoGrupo.Enabled
4615: 					THIS.txt_4c_NovoGrupo.SetFocus()
4616: 				ENDIF
4617: 				RETURN
4618: 			ENDIF
4619: 
4620: 			TRY
4621: 				loc_cGrupo = ""
4622: 				IF !EMPTY(cpros)
4623: 					IF USED("cursor_4c_TmpGruPro")
4624: 						USE IN cursor_4c_TmpGruPro
4625: 					ENDIF
4626: 					loc_cSQL = "SELECT Cgrus FROM SigCdPro WHERE cpros = " + EscaparSQL(cpros)
4627: 					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGruPro")
4628: 					IF loc_nResultado > 0 AND USED("cursor_4c_TmpGruPro") AND RECCOUNT("cursor_4c_TmpGruPro") > 0
4629: 						loc_cGrupo = ALLTRIM(TratarNulo(cursor_4c_TmpGruPro.Cgrus, ""))
4630: 					ENDIF
4631: 					IF USED("cursor_4c_TmpGruPro")
4632: 						USE IN cursor_4c_TmpGruPro
4633: 					ENDIF
4634: 				ELSE
4635: 					loc_cGrupo = ALLTRIM(THIS.txt_4c_NovoGrupo.Value)
4636: 				ENDIF
4637: 
4638: 				MsgInfo("Grupo de produto: " + loc_cGrupo + CHR(13) + ;
4639: 					"Fornecedor padr" + CHR(227) + "o: " + loc_cCodFornec + CHR(13) + CHR(13) + ;
4640: 					"Ap" + CHR(243) + "s cadastrar, digite o c" + CHR(243) + "digo do produto novo no item da grade.", ;
4641: 					"Cadastro de Produtos")
4642: 

*-- Linhas 4662 a 4680:
4662: 	* Equivale ao par AddCursor('SigMvOrc',...)/AddCursor('SigMvOrp',...)
4663: 	* do Init legado toda vez que ele e reexecutado: le de novo SigMvOrc/
4664: 	* SigMvOrp (BO.CarregarItens/CarregarParcelas, que usam cursor
4665: 	* temporario + ZAP + APPEND FROM DBF - nunca SQLEXEC direto no alias do
4666: 	* Grid), revincula as duas grades, reposiciona e repinta.
4667: 	*
4668: 	* PRESERVA A LINHA CORRENTE: guarda o Citens do item em que o usuario
4669: 	* estava e faz SEEK depois da recarga - sem isso toda recarga jogaria o
4670: 	* usuario de volta para o primeiro item. Cai em GO TOP quando a linha
4671: 	* nao existe mais (ex.: item recem-excluido) ou na primeira carga.
4672: 	*
4673: 	* O SET KEY do mestre-detalhe (PosicionarParcelasDoItem) e DESFEITO
4674: 	* antes da recarga e reposto depois: com filtro pendurado, a releitura
4675: 	* das parcelas enxergaria so a fatia do item corrente.
4676: 	*
4677: 	* Fecha com THIS.Refresh() + Refresh() das duas grades porque popular
4678: 	* cursor NAO repinta a grade ligada a ele, e trocar ordem/chave do
4679: 	* alias tampouco (regra #21).
4680: 	*==========================================================================

*-- Linhas 4696 a 4735:
4696: 			ENDIF
4697: 
4698: 			IF USED(loc_cParcelas)
4699: 				SELECT (loc_cParcelas)
4700: 				SET KEY TO
4701: 			ENDIF
4702: 
4703: 			*-- Pulado em validacao de UI / modo teste: sem conexao SQL real
4704: 			*-- (os cursores existem, so ficam vazios - mesma decisao do
4705: 			*-- CarregarDados desde a Fase 4).
4706: 			IF !loc_lModoValidacaoOuTeste
4707: 				THIS.this_oBusinessObject.CarregarItens()
4708: 				THIS.this_oBusinessObject.CarregarParcelas()
4709: 			ENDIF
4710: 
4711: 			*-- ZAP + APPEND FROM preserva estrutura/RecordSource/
4712: 			*-- CurrentControl, mas Width e Header1.Caption se perdem a cada
4713: 			*-- (re)atribuicao de RecordSource (regra #41) - os dois
4714: 			*-- Vincular* reaplicam tudo e sao idempotentes.
4715: 			THIS.VincularGradeItens()
4716: 			THIS.VincularGradeParcelas()
4717: 
4718: 			loc_lAchou = .F.
4719: 			IF USED(loc_cItens)
4720: 				SELECT (loc_cItens)
4721: 				SET ORDER TO TAG citens
4722: 				IF loc_nItemAtual > 0
4723: 					loc_lAchou = SEEK(loc_nItemAtual, loc_cItens, "citens")
4724: 				ENDIF
4725: 				IF !loc_lAchou
4726: 					GO TOP
4727: 				ENDIF
4728: 			ENDIF
4729: 
4730: 			THIS.PosicionarParcelasDoItem()
4731: 			THIS.AtualizarEstadoCadastroProduto()
4732: 
4733: 			THIS.Refresh()
4734: 			THIS.grd_4c_Itens.Refresh()
4735: 			THIS.grd_4c_Parcelas.Refresh()

*-- Linhas 4774 a 4813:
4774: 	* da grade) para as properties do Business Object, e carrega nele o
4775: 	* item da linha corrente da grade.
4776: 	*
4777: 	* No legado esses 5 campos tem ControlSource apontando para o cursor de
4778: 	* CABECALHO do form PAI (conferido um a um no dump):
4779: 	*   getPtax2    -> TprMvCab.ptax2s  -> this_nPTax2s  (Contingente/Perc1s)
4780: 	*   getPtaxa    -> TprMvCab.descs   -> this_nDescs   (Taxa Adm./Lucro, Perc2s)
4781: 	*   getPTax1    -> TprMvCab.ptax1s  -> this_nPTax1s  (BV/Perc3s)
4782: 	*   getPimposto -> TprMvCab.acres   -> this_nAcres   (Imposto, Perc4s nao-servico)
4783: 	*   getPservico -> TprMvCab.ptax3s  -> this_nPTax3s  (Imposto sem ISS, Perc4s servico)
4784: 	* Com ControlSource a sincronizacao era automatica; aqui TprMvCab nao
4785: 	* existe (o dialogo nao compartilha data session - ver cabecalho do
4786: 	* arquivo) e os cinco valores sao escalares do BO, entao a
4787: 	* sincronizacao e MANUAL e passa por este metodo.
4788: 	*
4789: 	* getPmargem (txt_4c_Margem) NAO entra: nao tem ControlSource no dump e
4790: 	* o When dele e ".f." - e resultado calculado por TotalizarItn, nunca
4791: 	* digitado nem gravado.
4792: 	*
4793: 	* PERSISTENCIA DO CABECALHO - DIVERGENCIA FIEL AO LEGADO: nem o
4794: 	* OK.btnSair.Click nem nenhum outro metodo do SIGOPORC grava TprMvCab
4795: 	* (conferido no dump: nao ha TableUpdate/Insert/Update sobre esse
4796: 	* cursor). Quem persiste SigMvCab e o form de cabecalho - este dialogo
4797: 	* so devolve os valores em memoria. Por isso FormParaBO escreve nas
4798: 	* properties do BO e NAO emite UPDATE em SigMvCab: fazer isso aqui
4799: 	* duplicaria a responsabilidade do pai e poderia sobrescrever o que ele
4800: 	* tem em edicao.
4801: 	*==========================================================================
4802: 	FUNCTION FormParaBO()
4803: 		LOCAL loc_lSucesso, loc_oErro, loc_cItens
4804: 		loc_lSucesso = .F.
4805: 
4806: 		IF VARTYPE(THIS.this_oBusinessObject) <> "O"
4807: 			RETURN .F.
4808: 		ENDIF
4809: 
4810: 		TRY
4811: 			THIS.this_oBusinessObject.this_nPTax2s = THIS.NumeroDoCampo(THIS.txt_4c_Contingente.Value)
4812: 			THIS.this_oBusinessObject.this_nDescs  = THIS.NumeroDoCampo(THIS.txt_4c_TaxaAdm.Value)
4813: 			THIS.this_oBusinessObject.this_nPTax1s = THIS.NumeroDoCampo(THIS.txt_4c_BV.Value)

*-- Linhas 4843 a 4861:
4843: 	* BOParaForm - BO -> TELA. Espelha nos 5 campos de percentual os valores
4844: 	* que o BO leu de SigMvCab em CarregarConfiguracao (acres/ptax1s/
4845: 	* ptax2s/ptax3s/descs), que no legado chegavam sozinhos pelo
4846: 	* ControlSource = TprMvCab.<coluna>.
4847: 	*
4848: 	* Fase 8/8 - SEM ESTE METODO os 5 campos abriam SEMPRE em 0,00, mesmo
4849: 	* com o cabecalho do orcamento tendo percentuais gravados: nada no
4850: 	* form lia essas properties do BO. Alem de exibir errado, isso
4851: 	* contaminava o calculo - os handlers Txt*KeyPress aplicam o valor do
4852: 	* CAMPO em perc1s..perc6s de cada item, entao o primeiro Enter num
4853: 	* campo zerado zeraria o percentual de todos os itens.
4854: 	*
4855: 	* Nao toca txt_4c_Margem (resultado calculado por TotalizarItn, ver
4856: 	* FormParaBO) nem a grade: os itens/parcelas vem por CarregarLista.
4857: 	*==========================================================================
4858: 	FUNCTION BOParaForm()
4859: 		LOCAL loc_lSucesso, loc_oErro
4860: 		loc_lSucesso = .F.
4861: 

*-- Linhas 5074 a 5110:
5074: 	* saida sem gravacao existir num lugar so.
5075: 	*
5076: 	* Fechar os dois cursores aqui e o que DESCARTA as edicoes em memoria:
5077: 	* eles sao LOCAIS do dialogo (CREATE CURSOR em CriarCursorItens/
5078: 	* CriarCursorParcelas), nao aliases emprestados do chamador, e a
5079: 	* persistencia acontece unicamente em BtnSalvarClick - reabrir o
5080: 	* dialogo depois disso le tudo de novo de SigMvOrc/SigMvOrp. O SET KEY
5081: 	* do mestre-detalhe sai antes, para nao deixar filtro pendurado.
5082: 	*
5083: 	* NAO pede confirmacao: o legado nao pergunta nada em nenhum caminho de
5084: 	* saida, e inventar um dialogo de confirmacao mudaria a UX (PILAR 1).
5085: 	*==========================================================================
5086: 	PROCEDURE BtnCancelarClick()
5087: 		LOCAL loc_oErro, loc_cItens, loc_cParcelas
5088: 
5089: 		TRY
5090: 			IF VARTYPE(THIS.this_oBusinessObject) = "O"
5091: 				loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
5092: 				loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
5093: 
5094: 				IF USED(loc_cParcelas)
5095: 					SELECT (loc_cParcelas)
5096: 					SET KEY TO
5097: 					USE IN (loc_cParcelas)
5098: 				ENDIF
5099: 
5100: 				IF USED(loc_cItens)
5101: 					USE IN (loc_cItens)
5102: 				ENDIF
5103: 			ENDIF
5104: 		CATCH TO loc_oErro
5105: 			MsgErro(loc_oErro.Message + CHR(13) + ;
5106: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5107: 				"Procedure: " + loc_oErro.Procedure, ;
5108: 				"Erro em Formsigoporc.BtnCancelarClick")
5109: 		ENDTRY
5110: 

*-- Linhas 5147 a 5172:
5147: 				ENDIF
5148: 			ENDIF
5149: 
5150: 			*-- Os dois cursores sao LOCAIS deste dialogo (CREATE CURSOR em
5151: 			*-- CriarCursorItens/CriarCursorParcelas), nao aliases emprestados
5152: 			*-- do chamador - por isso podem e devem ser fechados aqui. Antes
5153: 			*-- de fechar o de parcelas, desfaz o SET KEY aplicado por
5154: 			*-- PosicionarParcelasDoItem, para nao deixar filtro pendurado.
5155: 			IF VARTYPE(THIS.this_oBusinessObject) = "O"
5156: 				IF USED(THIS.this_oBusinessObject.this_cCursorParcelas)
5157: 					SELECT (THIS.this_oBusinessObject.this_cCursorParcelas)
5158: 					SET KEY TO
5159: 					USE IN (THIS.this_oBusinessObject.this_cCursorParcelas)
5160: 				ENDIF
5161: 
5162: 				IF USED(THIS.this_oBusinessObject.this_cCursorItens)
5163: 					USE IN (THIS.this_oBusinessObject.this_cCursorItens)
5164: 				ENDIF
5165: 			ENDIF
5166: 
5167: 			THIS.this_oFormPai = .NULL.
5168: 			THIS.this_oObjExt1 = .NULL.
5169: 		CATCH TO loc_oErro
5170: 			MsgErro(loc_oErro.Message, "Erro em Formsigoporc.Destroy")
5171: 		ENDTRY
5172: 


### BO (C:\4c\projeto\app\classes\sigoporcBO.prg):
*====================================================================
* sigoporcBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGOPORC" (grade de Itens de
* um Orcamento). O legado abre este form como filho do form de
* cabecalho do movimento (Lparameters poForm, pnDatSes - Set
* Datasession To pnDatSes, isto e, o filho passa a compartilhar a MESMA
* data session do pai, com os cursores crSigMvOrc/crSigMvOrp/TprMvCab/
* crSigCdOpe/LocalEmp ja abertos por ele).
*
* Tabelas envolvidas: SigMvOrc (itens do orcamento), SigMvOrp
* (parcelas/previsoes de pagamento do item), SigMvCab (cabecalho do
* movimento - espelhado no cursor temporario TprMvCab do pai), SigCdOpe
* (configuracao da operacao), SigCdEmp (configuracao da empresa).
*
* Referencias legado -> BO:
*   TprMvCab.Emps/Dopes/Numes/MascNum -> this_cEmps/this_cDopes/
*                                        this_nNumes/this_cMascNum
*   crSigCdOpe.DigItens/CadProds/Opers/Origems/Destinos/OpePads ->
*                                        this_nDigItens/this_nCadProds/
*                                        this_nOpers/this_nOrigems/
*                                        this_nDestinos/this_cOpePads
*   LocalEmp.DivNotas (CursorQuery de SigCdEmp) -> this_nDivNotas
*   TprMvCab.ContaOs/ContaDs -> this_cContaOs/this_cContaDs
*   TprMvCab.Acres/PTax1s/PTax2s/PTax3s/Descs -> this_nAcres/this_nPTax1s/
*                                          this_nPTax2s/this_nPTax3s/this_nDescs
*   SigOpCdd.ConfigGers -> this_cConfigGers
*   Thisform.Caption -> this_cCaption
*   crSigMvOrc (grade de itens) -> this_cCursorItens ("cursor_4c_Itens")
*   crSigMvOrp (grade de parcelas) -> this_cCursorParcelas
*                                     ("cursor_4c_Parcelas")
*
* Thisform.ParentForm, Thisform.poObjExt1 (referencia ao form externo de
* pesquisa de produtos SigOpCgp) e o controle de DataSession permanecem
* no FORM (sao referencias/estado de UI, fora da responsabilidade do
* Business Object).
*
* Herda de: BusinessBase
*
* Fase 1/8 - propriedades e Init(). A leitura de SigCdOpe/SigCdEmp
* (DigItens/CadProds/Opers/Origems/Destinos/OpePads/DivNotas) e as
* colunas de TprMvCab (ContaOs/ContaDs/Acres/PTax1s/PTax2s/PTax3s) serao
* carregadas por metodo proprio em fase posterior - os valores abaixo
* ficam com o default ate la.
*
* Fase 2/8 - CarregarDoCursor()/Inserir()/Atualizar()/ObterChavePrimaria()
* para o ITEM de SigMvOrc (chave cidchaves), com RegistrarAuditoria()
* (herdado de BusinessBase) chamado em Inserir/Atualizar. cidchaves e
* pkchaves sao as duas chaves Fortyus (fUniqueIds(), regra #22) geradas
* no Inserir quando ainda vazias. Buscar() nao e sobrescrito aqui: a
* listagem de itens (SELECT com joins de produto/unidade) fica na fase do
* BO que monta o cursor da grade (CarregarItens), porque a consulta tem
* joins e nao cabe no Buscar() generico herdado de BusinessBase.
*
* Fase 7/8 - CarregarConfiguracao() (SigCdOpe/SigCdEmp/SigOpCdd/SigMvCab,
* equivalentes aos cursores que o FORM PAI legado ja tinha abertos -
* regra #35/cabecalho acima), CarregarItens()/CarregarParcelas() (leitura
* de SigMvOrc/SigMvOrp para as duas grades - o legado faz isso via
* AddCursor no Init; aqui e feito por SQLEXEC em cursor temporario +
* ZAP/APPEND no cursor ja ligado ao Grid, regra "SQLEXEC sobre alias de
* grid zera o ColumnCount").
*
* Modo Criacao do legado (SigCdOpe.DigItens IN (6,7), com sub-blocos
* lidos de SigOpCdI.JOB_MV_BLO em btnInsBlo/btnInsSub) NAO E PORTADO: a
* tabela SigOpCdI NAO EXISTE no schema canonico (conferido em
* docs\schema.sql, regra #14 - zero ocorrencias, nao e falso-negativo de
* encoding). This_nDigItens continua sendo lido e comparado (para nao
* quebrar os outros ramos que dependem dele, como DigItens=5->CONSULTAR),
* mas o ramo exclusivo de DigItens IN (6,7) que insere sub-itens de
* JOB_MV_BLO fica de fora em btnInsBlo/btnInsSub, com o motivo documentado
* la (nao e omissao silenciosa - rule "SEMPRE FUNCIONALIDADE COMPLETA",
* mas a fonte de dados do legado para essa sub-feature nao existe mais).
*====================================================================

DEFINE CLASS sigoporcBO AS BusinessBase

	*-- Parametros recebidos do form pai na abertura do dialogo (legado:
	*-- Lparameters poForm, pnDatSes). O form migrado repassa so os
	*-- valores escalares que identificam o cabecalho do movimento
	*-- (TprMvCab/SigMvCab); poForm (referencia de UI) e a troca de
	*-- DataSession ficam no Form.
	this_cEmps = ""                 && Empresa do movimento (TprMvCab.Emps / SigMvCab.emps)
	this_cDopes = ""                && Documento de Operacao (TprMvCab.Dopes / SigMvCab.dopes)
	this_nNumes = 0                 && Numero do movimento (TprMvCab.Numes / SigMvCab.numes)
	this_cMascNum = ""              && Mascara/numero formatado do documento (TprMvCab.MascNum) - usado no Caption "Itens"

	*-- Configuracao da operacao (SigCdOpe), referente ao Dopes acima.
	*-- Controla ramos de negocio usados pelos botoes/grades desta tela.
	*-- Populados em fase posterior (leitura via SQLEXEC); default abaixo.
	this_nDigItens = 0              && SigCdOpe.DigItens - 5 forca modo CONSULTAR independente do pai (Op_Escolha)
	this_nCadProds = 0              && SigCdOpe.CadProds - habilita o botao "Cadastro de Produtos" (btnCadPro)
	this_nOpers = 0                 && SigCdOpe.Opers - 1=Entrada/2=Saida, usado para resolver o fornecedor padrao
	this_nOrigems = 0               && SigCdOpe.Origems - .T. quando a conta de origem (TprMvCab.ContaOs) e obrigatoria
	this_nDestinos = 0              && SigCdOpe.Destinos - .T. quando a conta de destino (TprMvCab.ContaDs) e obrigatoria
	this_cOpePads = ""              && SigCdOpe.OpePads - padrao de operacao usado no cadastro de produtos
	this_nImagems = 0               && SigCdOpe.Imagems - habilita a pre-visualizacao da foto do produto no AfterRowColChange (grdItem.imgProds)
	this_nConfes = 0                && SigCdOpe.Confes - quando = 1, suprime a pre-visualizacao mesmo com Imagems = 1
	this_nPrecoAuts = 0             && SigCdOpe.PrecoAuts - autoriza a precificacao automatica em btnCadPro.Click
	this_nPrecoPs = 0               && SigCdOpe.PrecoPs - origem do preco automatico (1/10=venda ou ideal, 2=custo, 5=valors, 7=ultima compra, 8/9=custo medio, 11=custo total)
	this_nPrecops = 0               && SigCdOpe.Precops - moeda/fator de venda(1) ou custo(2) a copiar do cadastro de produto
	this_cCMoes = ""                && SigCdOpe.CMoes - moeda padrao da operacao (fallback quando nao ha precificacao automatica)

	*-- Configuracao da empresa (SigCdEmp), lida via Cemps = this_cEmps
	*-- (legado: CursorQuery([SigCdEmp],[LocalEmp],[Cemps],TprMvCab.Emps,[DivNotas])).
	*-- Populada em fase posterior; default abaixo.
	this_nDivNotas = 0              && SigCdEmp.DivNotas - 1=Preco&Gerencial(P&G) / 2=SRCOM - decide a formula de rateio dos percentuais do item

	*-- Contas de origem/destino do cabecalho (TprMvCab/SigMvCab), usadas
	*-- em btnCadPro.Click para resolver o fornecedor do produto novo.
	*-- Populadas em fase posterior; default abaixo.
	this_cContaOs = ""              && Conta de Origem (TprMvCab.ContaOs)
	this_cContaDs = ""              && Conta de Destino (TprMvCab.ContaDs)

	*-- Percentuais/indices do cabecalho (TprMvCab/SigMvCab), usados como
	*-- semente dos campos de percentual do item recem-incluido.
	*-- Populados em fase posterior; default abaixo.
	this_nAcres = 0                 && TprMvCab.Acres - imposto cheio (usado quando o item NAO e servico)
	this_nPTax1s = 0                && TprMvCab.PTax1s - percentual default de BV (Perc3s)
	this_nPTax2s = 0                && TprMvCab.PTax2s - percentual default de despesa operacional/contingente (Perc1s)
	this_nPTax3s = 0                && TprMvCab.PTax3s - percentual default de imposto de servico (Perc4s quando Servicos)
	this_nDescs = 0                 && TprMvCab.Descs - percentual default de lucro/"Taxa Adm." (Perc2s)

	*-- Mascara de configuracoes gerais da operacao (SigOpCdd.ConfigGers),
	*-- lida via Dopes = this_cDopes. Posicao 192 (1 char) = flag de
	*-- Decupagem (Int(Val(Substr(ConfigGers,192,1))) = 1), usada em
	*-- TotalizarItn(). Populada em fase posterior; default "" faz a
	*-- checagem de Decupagem avaliar sempre .F. (SUBSTR/VAL de string
	*-- vazia devolve 0), que e o comportamento seguro ate a config
	*-- chegar.
	this_cConfigGers = ""
	this_nChkIfors = 0              && SigOpCdd.ChkIfors - 1/2 habilita a resolucao de preco por SigPrFnc (tabela de fornecedor) antes do padrao de SigCdMoe

	*-- Titulo montado para a tela (legado: Thisform.Caption)
	this_cCaption = ""              && "<Emps> <Dopes> <MascNum> - Itens"

	*-- Nomes dos cursores que este BO popula/consome (constantes, para o
	*-- Form referenciar sem repetir literais - equivalentes aos aliases
	*-- globais do legado crSigMvOrc/crSigMvOrp)
	this_cCursorItens = "cursor_4c_Itens"        && Grade de itens do orcamento (SigMvOrc)
	this_cCursorParcelas = "cursor_4c_Parcelas"  && Grade de parcelas/previsoes do item selecionado (SigMvOrp)

	*-- Propriedades da entidade (mapeamento 1-para-1 para a tabela SigMvOrc -
	*-- um ITEM da grade de orcamento, chave cidchaves). this_cEmps/
	*-- this_cDopes/this_nNumes acima (recebidos no Init) JA cobrem as
	*-- colunas emps/dopes/numes - nao duplicar.
	this_cCblocos    = ""   && cblocos char(30) - marcador de linha (SUBTOTAL/BRANCO/SUBTOTAIS/TAXA/TOTAL/IMPOSTO/TOTALGERAL ou vazio = item normal)
	this_nCitem2     = 0    && citem2 numeric(10,0) - item do bloco (subtotal pai)
	this_nCitens     = 0    && citens numeric(10,0) - numero do item (PK logica dentro do orcamento)
	this_cCpros      = ""   && cpros char(14) - codigo do produto
	this_cCunips     = ""   && cunips char(3) - unidade de compra/pedido
	this_cCunis      = ""   && cunis char(3) - unidade de venda
	this_cDpro2s     = ""   && dpro2s text NULL - descricao complementar do produto
	this_cDpros      = ""   && dpros char(65) - descricao do produto/bloco
	this_cEmpdopnums = ""   && empdopnums char(29) - Emps(3)+Dopes(20)+Str(Numes,6), chave posicional que liga o item ao cabecalho
	this_nFators     = 0    && fators numeric(8,4) - fator de conversao de unidade
	this_nPesos      = 0    && pesos numeric(8,4) - peso unitario
	this_cPkchaves   = ""   && pkchaves char(20) - chave unica Fortyus (fUniqueIds(), independente de cidchaves)
	this_nQtds       = 0    && qtds numeric(8,4) - quantidade
	this_nTotas      = 0    && totas numeric(13,2) - total do item
	this_nUnits      = 0    && units numeric(13,2) - valor unitario
	this_cCidchaves  = ""   && cidchaves char(20) - PK (fUniqueIds())
	this_cMoedas     = ""   && moedas char(3) - moeda do total de custo
	this_cMoefats    = ""   && moefats char(3) - moeda de faturamento
	this_cMoevs      = ""   && moevs char(3) - moeda de venda
	this_cNotas      = ""   && notas char(9) - numero/mascara da nota associada
	this_cObs        = ""   && obs text NULL - observacao do item
	this_cOpers      = ""   && opers char(1) - tipo de operacao do item (distinto de this_nOpers, que e config de SigCdOpe)
	this_nTota1s     = 0    && tota1s numeric(13,2) - despesa operacional (Perc1s)
	this_nTota2s     = 0    && tota2s numeric(13,2) - lucro (Perc2s)
	this_nTota3s     = 0    && tota3s numeric(13,2) - BV (Perc3s)
	this_nTota4s     = 0    && tota4s numeric(13,2) - imposto/servico (Perc4s)
	this_nTota5s     = 0    && tota5s numeric(13,2) - incentivo 1 (Perc5s)
	this_nTota6s     = 0    && tota6s numeric(13,2) - incentivo 2 (Perc6s)
	this_nTota7s     = 0    && tota7s numeric(13,2) - custo interno SRCOM
	this_nTota8s     = 0    && tota8s numeric(13,2) - valor fornecedor
	this_nTota9s     = 0    && tota9s numeric(13,2) - saldo real custo interno SRCOM
	this_nTota10s    = 0    && tota10s numeric(13,2) - saldo real fornecedor
	this_nTpesos     = 0    && tpesos numeric(8,4) - peso total
	this_nUnivals    = 0    && univals numeric(13,2) - valor unitario de venda
	this_nUtilizas   = 0    && utilizas numeric(2,0) - controle de utilizacao (fluxo de preco autorizado)
	this_lServicos   = .F.  && servicos bit - item e servico (troca a regra de calculo do imposto)
	this_nCitagrs    = 0    && citagrs numeric(10,0) - item do agrupador (decupagem)
	this_nCitem3     = 0    && citem3 numeric(10,0) - item do sub-bloco (subtotal de 2o nivel)
	this_cCodacabs   = ""   && codacabs char(3) - codigo de acabamento (SigCdAca)
	this_lDebitos    = .F.  && debitos bit - item gerado a debito (bloqueia imposto cheio)
	this_lTaxas      = .F.  && taxas bit - item e taxa (fee)

	*====================================================================
	* Init - Inicializa Business Object
	* Parametros equivalentes ao Lparameters poForm, pnDatSes do Init do
	* form legado - o form migrado repassa so os valores escalares que
	* identificam o cabecalho do movimento (poForm/pnDatSes, que sao
	* referencia de UI e troca de DataSession, ficam no Form).
	*====================================================================
	PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_cMascNum)
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela = "SigMvOrc"
		THIS.this_cCampoChave = "cidchaves"

		IF VARTYPE(par_cEmps) = "C"
			THIS.this_cEmps = par_cEmps
		ENDIF

		IF VARTYPE(par_cDopes) = "C"
			THIS.this_cDopes = par_cDopes
		ENDIF

		IF VARTYPE(par_nNumes) = "N"
			THIS.this_nNumes = par_nNumes
		ENDIF

		IF VARTYPE(par_cMascNum) = "C"
			THIS.this_cMascNum = par_cMascNum
		ENDIF

		*-- Legado: Thisform.Caption = Alltrim(Emps)+' '+Alltrim(Dopes)+' '+Alltrim(MascNum)+' - Itens'
		THIS.this_cCaption = ALLTRIM(THIS.this_cEmps) + " " + ALLTRIM(THIS.this_cDopes) + ;
			" " + ALLTRIM(THIS.this_cMascNum) + " - Itens"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna a chave primaria (cidchaves) do item
	* corrente, para uso em RegistrarAuditoria()
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia TODAS as colunas de um item de SigMvOrc
	* (cursor_4c_Itens/crSigMvOrc) para as propriedades do BO. SEMPRE usar
	* SELECT (par_cAliasCursor) antes de acessar os campos (regra #8).
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)

				THIS.this_cCblocos = TratarNulo(cblocos, "C")
				THIS.this_nCitem2 = TratarNulo(citem2, "N")
				THIS.this_nCitens = TratarNulo(citens, "N")
				THIS.this_cCpros = TratarNulo(cpros, "C")
				THIS.this_cCunips = TratarNulo(cunips, "C")
				THIS.this_cCunis = TratarNulo(cunis, "C")
				THIS.this_cDopes = TratarNulo(dopes, "C")
				THIS.this_cDpro2s = TratarNulo(dpro2s, "C")
				THIS.this_cDpros = TratarNulo(dpros, "C")
				THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
				THIS.this_cEmps = TratarNulo(emps, "C")
				THIS.this_nFators = TratarNulo(fators, "N")
				THIS.this_nNumes = TratarNulo(numes, "N")
				THIS.this_nPesos = TratarNulo(pesos, "N")
				THIS.this_cPkchaves = TratarNulo(pkchaves, "C")
				THIS.this_nQtds = TratarNulo(qtds, "N")
				THIS.this_nTotas = TratarNulo(totas, "N")
				THIS.this_nUnits = TratarNulo(units, "N")
				THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
				THIS.this_cMoedas = TratarNulo(moedas, "C")
				THIS.this_cMoefats = TratarNulo(moefats, "C")
				THIS.this_cMoevs = TratarNulo(moevs, "C")
				THIS.this_cNotas = TratarNulo(notas, "C")
				THIS.this_cObs = TratarNulo(obs, "C")
				THIS.this_cOpers = TratarNulo(opers, "C")
				THIS.this_nTota1s = TratarNulo(tota1s, "N")
				THIS.this_nTota2s = TratarNulo(tota2s, "N")
				THIS.this_nTota3s = TratarNulo(tota3s, "N")
				THIS.this_nTota4s = TratarNulo(tota4s, "N")
				THIS.this_nTota5s = TratarNulo(tota5s, "N")
				THIS.this_nTota6s = TratarNulo(tota6s, "N")
				THIS.this_nTota7s = TratarNulo(tota7s, "N")
				THIS.this_nTota8s = TratarNulo(tota8s, "N")
				THIS.this_nTota9s = TratarNulo(tota9s, "N")
				THIS.this_nTota10s = TratarNulo(tota10s, "N")
				THIS.this_nTpesos = TratarNulo(tpesos, "N")
				THIS.this_nUnivals = TratarNulo(univals, "N")
				THIS.this_nUtilizas = TratarNulo(utilizas, "N")
				IF VARTYPE(servicos) = "L"
					THIS.this_lServicos = servicos
				ELSE
					THIS.this_lServicos = (NVL(servicos, 0) = 1)
				ENDIF
				THIS.this_nCitagrs = TratarNulo(citagrs, "N")
				THIS.this_nCitem3 = TratarNulo(citem3, "N")
				THIS.this_cCodacabs = TratarNulo(codacabs, "C")
				IF VARTYPE(debitos) = "L"
					THIS.this_lDebitos = debitos
				ELSE
					THIS.this_lDebitos = (NVL(debitos, 0) = 1)
				ENDIF
				IF VARTYPE(taxas) = "L"
					THIS.this_lTaxas = taxas
				ELSE
					THIS.this_lTaxas = (NVL(taxas, 0) = 1)
				ENDIF

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere novo item (linha) em SigMvOrc
	* PK (cidchaves) e pkchaves gerados via fUniqueIds() se ainda vazios
	* (regra #22 - PK Fortyus NUNCA pode ser string vazia)
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
				THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
			ENDIF

			IF EMPTY(ALLTRIM(NVL(THIS.this_cPkchaves, "")))
				THIS.this_cPkchaves = LEFT(fUniqueIds(), 20)
			ENDIF

			*-- Campo computado: Emps + Dopes + Numes (chave posicional que liga
			*-- o item ao cabecalho - regra #42, NUNCA ALLTRIM nas partes)
			THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			*-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
			*-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
			*-- com limite de 8192 caracteres ("Line is too long" em runtime).
			loc_cSQL = "INSERT INTO SigMvOrc ("
			loc_cSQL = loc_cSQL + "cblocos, citem2, citens, cpros, cunips, cunis, dopes, dpro2s,"
			loc_cSQL = loc_cSQL + "dpros, empdopnums, emps, fators, numes, pesos, pkchaves, qtds,"
			loc_cSQL = loc_cSQL + "totas, units, cidchaves, moedas, moefats, moevs, notas, obs,"
			loc_cSQL = loc_cSQL + "opers, tota10s, tota1s, tota2s, tota3s, tota4s, tota5s, tota6s,"
			loc_cSQL = loc_cSQL + "tota7s, tota8s, tota9s, tpesos, univals, utilizas, servicos, citagrs,"
			loc_cSQL = loc_cSQL + "citem3, codacabs, debitos, taxas"
			loc_cSQL = loc_cSQL + ") VALUES ("
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCblocos, 30)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitem2, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCunips, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCunis, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cDpro2s) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nFators, 4) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPesos, 4) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPkchaves, 20)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtds, 4) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTotas, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUnits, 2) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoefats, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoevs, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNotas, 9)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cObs) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota10s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota1s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota2s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota3s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota4s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota5s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota6s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota7s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota8s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota9s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpesos, 4) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUnivals, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUtilizas, 0) + ","
			loc_cSQL = loc_cSQL + IIF(THIS.this_lServicos, "1", "0") + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitagrs, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitem3, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodacabs, 3)) + ","
			loc_cSQL = loc_cSQL + IIF(THIS.this_lDebitos, "1", "0") + ","
			loc_cSQL = loc_cSQL + IIF(THIS.this_lTaxas, "1", "0") + ")"

			IF USED("cursor_4c_Insert")
				USE IN cursor_4c_Insert
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

			IF loc_nResult < 0
				MsgErro("Erro ao inserir item do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("INSERT")
				IF USED("cursor_4c_Insert")
					USE IN cursor_4c_Insert
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza item existente em SigMvOrc (por cidchaves)
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Campo computado: Emps + Dopes + Numes (chave posicional - regra #42)
			THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			*-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
			*-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
			*-- com limite de 8192 caracteres ("Line is too long" em runtime).
			loc_cSQL = "UPDATE SigMvOrc SET"
			loc_cSQL = loc_cSQL + " cblocos = " + EscaparSQL(LEFT(THIS.this_cCblocos, 30)) + ","
			loc_cSQL = loc_cSQL + " citem2 = " + FormatarNumeroSQL(THIS.this_nCitem2, 0) + ","
			loc_cSQL = loc_cSQL + " citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + " cpros = " + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + " cunips = " + EscaparSQL(LEFT(THIS.this_cCunips, 3)) + ","
			loc_cSQL = loc_cSQL + " cunis = " + EscaparSQL(LEFT(THIS.this_cCunis, 3)) + ","
			loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + " dpro2s = " + EscaparSQL(THIS.this_cDpro2s) + ","
			loc_cSQL = loc_cSQL + " dpros = " + EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ","
			loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
			loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + " fators = " + FormatarNumeroSQL(THIS.this_nFators, 4) + ","
			loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + " pesos = " + FormatarNumeroSQL(THIS.this_nPesos, 4) + ","
			loc_cSQL = loc_cSQL + " pkchaves = " + EscaparSQL(LEFT(THIS.this_cPkchaves, 20)) + ","
			loc_cSQL = loc_cSQL + " qtds = " + FormatarNumeroSQL(THIS.this_nQtds, 4) + ","
			loc_cSQL = loc_cSQL + " totas = " + FormatarNumeroSQL(THIS.this_nTotas, 2) + ","
			loc_cSQL = loc_cSQL + " units = " + FormatarNumeroSQL(THIS.this_nUnits, 2) + ","
			loc_cSQL = loc_cSQL + " moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
			loc_cSQL = loc_cSQL + " moefats = " + EscaparSQL(LEFT(THIS.this_cMoefats, 3)) + ","
			loc_cSQL = loc_cSQL + " moevs = " + EscaparSQL(LEFT(THIS.this_cMoevs, 3)) + ","
			loc_cSQL = loc_cSQL + " notas = " + EscaparSQL(LEFT(THIS.this_cNotas, 9)) + ","
			loc_cSQL = loc_cSQL + " obs = " + EscaparSQL(THIS.this_cObs) + ","
			loc_cSQL = loc_cSQL + " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
			loc_cSQL = loc_cSQL + " tota10s = " + FormatarNumeroSQL(THIS.this_nTota10s, 2) + ","
			loc_cSQL = loc_cSQL + " tota1s = " + FormatarNumeroSQL(THIS.this_nTota1s, 2) + ","
			loc_cSQL = loc_cSQL + " tota2s = " + FormatarNumeroSQL(THIS.this_nTota2s, 2) + ","
			loc_cSQL = loc_cSQL + " tota3s = " + FormatarNumeroSQL(THIS.this_nTota3s, 2) + ","
			loc_cSQL = loc_cSQL + " tota4s = " + FormatarNumeroSQL(THIS.this_nTota4s, 2) + ","
			loc_cSQL = loc_cSQL + " tota5s = " + FormatarNumeroSQL(THIS.this_nTota5s, 2) + ","
			loc_cSQL = loc_cSQL + " tota6s = " + FormatarNumeroSQL(THIS.this_nTota6s, 2) + ","
			loc_cSQL = loc_cSQL + " tota7s = " + FormatarNumeroSQL(THIS.this_nTota7s, 2) + ","
			loc_cSQL = loc_cSQL + " tota8s = " + FormatarNumeroSQL(THIS.this_nTota8s, 2) + ","
			loc_cSQL = loc_cSQL + " tota9s = " + FormatarNumeroSQL(THIS.this_nTota9s, 2) + ","
			loc_cSQL = loc_cSQL + " tpesos = " + FormatarNumeroSQL(THIS.this_nTpesos, 4) + ","
			loc_cSQL = loc_cSQL + " univals = " + FormatarNumeroSQL(THIS.this_nUnivals, 2) + ","
			loc_cSQL = loc_cSQL + " utilizas = " + FormatarNumeroSQL(THIS.this_nUtilizas, 0) + ","
			loc_cSQL = loc_cSQL + " servicos = " + IIF(THIS.this_lServicos, "1", "0") + ","
			loc_cSQL = loc_cSQL + " citagrs = " + FormatarNumeroSQL(THIS.this_nCitagrs, 0) + ","
			loc_cSQL = loc_cSQL + " citem3 = " + FormatarNumeroSQL(THIS.this_nCitem3, 0) + ","
			loc_cSQL = loc_cSQL + " codacabs = " + EscaparSQL(LEFT(THIS.this_cCodacabs, 3)) + ","
			loc_cSQL = loc_cSQL + " debitos = " + IIF(THIS.this_lDebitos, "1", "0") + ","
			loc_cSQL = loc_cSQL + " taxas = " + IIF(THIS.this_lTaxas, "1", "0")
			loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

			IF USED("cursor_4c_Update")
				USE IN cursor_4c_Update
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

			IF loc_nResult < 0
				MsgErro("Erro ao atualizar item do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("UPDATE")
				IF USED("cursor_4c_Update")
					USE IN cursor_4c_Update
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarConfiguracao - Le SigCdOpe (por Dopes), SigCdEmp (por Cemps -
	* regra SigCdEmp usa Cemps, NUNCA Cemps), SigOpCdd (por Dopes) e os
	* percentuais/contas do cabecalho em SigMvCab (por Emps+Dopes+Numes).
	* Equivalente ao bloco de cursores que o FORM PAI legado ja mantinha
	* abertos (crSigCdOpe/LocalEmp/crSigOpCdd/TprMvCab) - aqui cada valor e
	* lido direto do SQL Server, uma unica vez, na abertura do dialogo.
	*
	* Chamada em Formsigoporc.InicializarForm, logo apos CREATEOBJECT do
	* BO e ANTES de qualquer Configurar*() que dependa de this_cOpEscolha
	* (o Form recalcula this_cOpEscolha com this_nDigItens depois desta
	* chamada - regra do legado: DigItens=5 forca CONSULTAR).
	*====================================================================
	PROCEDURE CarregarConfiguracao()
		LOCAL loc_cSQL, loc_lSucesso
		loc_lSucesso = .T.

		TRY
			*-- SigCdOpe (configuracao da operacao, chave Dopes)
			IF USED("cursor_4c_CfgOpe")
				USE IN cursor_4c_CfgOpe
			ENDIF
			loc_cSQL = "SELECT DigItens, CadProds, Opers, Origems, Destinos, OpePads,"
			loc_cSQL = loc_cSQL + " Imagems, Confes, PrecoAuts, PrecoPs, Precops, CMoes"
			loc_cSQL = loc_cSQL + " FROM SigCdOpe WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgOpe") > 0 AND USED("cursor_4c_CfgOpe") AND RECCOUNT("cursor_4c_CfgOpe") > 0
				SELECT cursor_4c_CfgOpe
				THIS.this_nDigItens  = TratarNulo(DigItens, "N")
				THIS.this_nCadProds  = TratarNulo(CadProds, "N")
				THIS.this_nOpers     = TratarNulo(Opers, "N")
				THIS.this_nOrigems   = TratarNulo(Origems, "N")
				THIS.this_nDestinos  = TratarNulo(Destinos, "N")
				THIS.this_cOpePads   = TratarNulo(OpePads, "C")
				THIS.this_nImagems   = TratarNulo(Imagems, "N")
				THIS.this_nConfes    = TratarNulo(Confes, "N")
				THIS.this_nPrecoAuts = TratarNulo(PrecoAuts, "N")
				THIS.this_nPrecoPs   = TratarNulo(PrecoPs, "N")
				THIS.this_nPrecops   = TratarNulo(Precops, "N")
				THIS.this_cCMoes     = TratarNulo(CMoes, "C")
			ENDIF
			IF USED("cursor_4c_CfgOpe")
				USE IN cursor_4c_CfgOpe
			ENDIF

			*-- SigCdEmp (configuracao da empresa, chave Cemps)
			IF USED("cursor_4c_CfgEmp")
				USE IN cursor_4c_CfgEmp
			ENDIF
			loc_cSQL = "SELECT DivNotas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(THIS.this_cEmps)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgEmp") > 0 AND USED("cursor_4c_CfgEmp") AND RECCOUNT("cursor_4c_CfgEmp") > 0
				THIS.this_nDivNotas = TratarNulo(cursor_4c_CfgEmp.DivNotas, "N")
			ENDIF
			IF USED("cursor_4c_CfgEmp")
				USE IN cursor_4c_CfgEmp
			ENDIF

			*-- SigOpCdd (configuracao-detalhe da operacao, chave Dopes)
			IF USED("cursor_4c_CfgOpd")
				USE IN cursor_4c_CfgOpd
			ENDIF
			loc_cSQL = "SELECT ConfigGers, ChkIfors FROM SigOpCdd WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgOpd") > 0 AND USED("cursor_4c_CfgOpd") AND RECCOUNT("cursor_4c_CfgOpd") > 0
				THIS.this_cConfigGers = TratarNulo(cursor_4c_CfgOpd.ConfigGers, "C")
				THIS.this_nChkIfors   = TratarNulo(cursor_4c_CfgOpd.ChkIfors, "N")
			ENDIF
			IF USED("cursor_4c_CfgOpd")
				USE IN cursor_4c_CfgOpd
			ENDIF

			*-- SigMvCab (cabecalho do movimento, chave Emps+Dopes+Numes) -
			*-- percentuais default (semente do item novo) e contas de
			*-- origem/destino (usadas por btnCadPro.Click)
			IF USED("cursor_4c_CfgCab")
				USE IN cursor_4c_CfgCab
			ENDIF
			loc_cSQL = "SELECT Acres, PTax1s, PTax2s, PTax3s, Descs, ContaOs, ContaDs"
			loc_cSQL = loc_cSQL + " FROM SigMvCab WHERE Emps = " + EscaparSQL(THIS.this_cEmps)
			loc_cSQL = loc_cSQL + " AND Dopes = " + EscaparSQL(THIS.this_cDopes)
			loc_cSQL = loc_cSQL + " AND Numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgCab") > 0 AND USED("cursor_4c_CfgCab") AND RECCOUNT("cursor_4c_CfgCab") > 0
				SELECT cursor_4c_CfgCab
				THIS.this_nAcres   = TratarNulo(Acres, "N")
				THIS.this_nPTax1s  = TratarNulo(PTax1s, "N")
				THIS.this_nPTax2s  = TratarNulo(PTax2s, "N")
				THIS.this_nPTax3s  = TratarNulo(PTax3s, "N")
				THIS.this_nDescs   = TratarNulo(Descs, "N")
				THIS.this_cContaOs = TratarNulo(ContaOs, "C")
				THIS.this_cContaDs = TratarNulo(ContaDs, "C")
			ENDIF
			IF USED("cursor_4c_CfgCab")
				USE IN cursor_4c_CfgCab
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarConfiguracao")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarItens - Popula cursor_4c_Itens (grade de itens) a partir de
	* SigMvOrc, filtrado por Emps/Dopes/Numes e ordenado por Citens -
	* equivalente ao AddCursor('SigMvOrc','citens','CrSigMvOrc',...) do
	* Init legado. SQLEXEC vai para um cursor TEMPORARIO; cursor_4c_Itens
	* (ja ligado ao Grid, com colunas de lookup instaladas via AddObject)
	* e recarregado com ZAP + APPEND FROM DBF() - NUNCA SQLEXEC direto nele
	* (regra: SQLEXEC sobre alias de grid zera o ColumnCount).
	*====================================================================
	PROCEDURE CarregarItens()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_ItensTmp")
				USE IN cursor_4c_ItensTmp
			ENDIF

			loc_cSQL = "SELECT o.cblocos, o.citem2, o.citens, o.cpros, o.cunips, o.cunis, o.dopes,"
			loc_cSQL = loc_cSQL + " o.dpro2s, o.dpros, o.empdopnums, o.emps, o.fators, o.numes, o.pesos,"
			loc_cSQL = loc_cSQL + " o.pkchaves, o.qtds, o.totas, o.units, o.cidchaves, o.moedas, o.moefats,"
			loc_cSQL = loc_cSQL + " o.moevs, o.notas, o.obs, o.opers, o.tota10s, o.tota1s, o.tota2s, o.tota3s,"
			loc_cSQL = loc_cSQL + " o.tota4s, o.tota5s, o.tota6s, o.tota7s, o.tota8s, o.tota9s, o.tpesos,"
			loc_cSQL = loc_cSQL + " o.univals, o.utilizas, o.servicos, o.citagrs, o.citem3, o.codacabs,"
			loc_cSQL = loc_cSQL + " o.debitos, o.taxas,"
			*-- Descricoes de lookup exibidas nas Columns 4/6/30 da grade de itens
			*-- (legado: crSigMvOrc.DcUnis/DcUnips/DAcabs - colunas PROJETADAS pela
			*-- query do form PAI, nao colunas de SigMvOrc). Sem estes tres joins a
			*-- grade abriria com Unidade/Unidade(pedido)/Acabamento em BRANCO,
			*-- mesmo com cunis/cunips/codacabs gravados.
			loc_cSQL = loc_cSQL + " NVL(uv.dunis, '')  AS dcunis,"
			loc_cSQL = loc_cSQL + " NVL(up.dunis, '')  AS dcunips,"
			loc_cSQL = loc_cSQL + " NVL(ac.descrs, '') AS dacabs"
			loc_cSQL = loc_cSQL + " FROM SigMvOrc o"
			loc_cSQL = loc_cSQL + " LEFT JOIN SigCdUni uv ON RTRIM(uv.cunis) = RTRIM(o.cunis)"
			loc_cSQL = loc_cSQL + " LEFT JOIN SigCdUni up ON RTRIM(up.cunis) = RTRIM(o.cunips)"
			loc_cSQL = loc_cSQL + " LEFT JOIN SigCdAca ac ON RTRIM(ac.cods)  = RTRIM(o.codacabs)"
			loc_cSQL = loc_cSQL + " WHERE o.emps = " + EscaparSQL(THIS.this_cEmps)
			loc_cSQL = loc_cSQL + " AND o.dopes = " + EscaparSQL(THIS.this_cDopes)
			loc_cSQL = loc_cSQL + " AND o.numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)
			loc_cSQL = loc_cSQL + " ORDER BY o.citens"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTmp")

			IF loc_nResultado < 0
				MsgErro("Erro ao carregar itens do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED(THIS.this_cCursorItens)
					SELECT (THIS.this_cCursorItens)
					ZAP
					IF USED("cursor_4c_ItensTmp") AND RECCOUNT("cursor_4c_ItensTmp") > 0
						APPEND FROM DBF("cursor_4c_ItensTmp")
					ENDIF
				ENDIF
				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_ItensTmp")
				USE IN cursor_4c_ItensTmp
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarItens")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarParcelas - Popula cursor_4c_Parcelas (grade de parcelas) a
	* partir de SigMvOrp, filtrado por Emps/Dopes/Numes e ordenado por
	* Citens - equivalente ao AddCursor('SigMvOrp','citens','CrSigMvOrp',
	* ...) do Init legado. dfors (descricao do fornecedor, Column6 de
	* grd_4c_Parcelas, SEMPRE ReadOnly) e projetado via LEFT JOIN em
	* SigCdCli.Iclis/Rclis - mesma tabela de conta usada pelo lookup
	* fAcessoContas do legado (ver cabecalho de ConfigurarGradeParcelas).
	* Mesmo padrao grid-safe de CarregarItens (cursor temporario + ZAP +
	* APPEND FROM DBF no cursor ja ligado ao Grid).
	*====================================================================
	PROCEDURE CarregarParcelas()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_ParcelasTmp")
				USE IN cursor_4c_ParcelasTmp
			ENDIF

			loc_cSQL = "SELECT p.cidchaves, p.citens, p.datas, p.dopes, p.empdopnums,"
			loc_cSQL = loc_cSQL + " p.emps, p.numes, p.percs, p.valos, p.vlbaixas,"
			loc_cSQL = loc_cSQL + " p.borderos, p.ifors, p.valcreds,"
			loc_cSQL = loc_cSQL + " NVL(f.rclis, '') AS dfors"
			loc_cSQL = loc_cSQL + " FROM SigMvOrp p LEFT JOIN SigCdCli f ON f.iclis = p.ifors"
			loc_cSQL = loc_cSQL + " WHERE p.emps = " + EscaparSQL(THIS.this_cEmps)
			loc_cSQL = loc_cSQL + " AND p.dopes = " + EscaparSQL(THIS.this_cDopes)
			loc_cSQL = loc_cSQL + " AND p.numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)
			loc_cSQL = loc_cSQL + " ORDER BY p.citens"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ParcelasTmp")

			IF loc_nResultado < 0
				MsgErro("Erro ao carregar parcelas do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED(THIS.this_cCursorParcelas)
					SELECT (THIS.this_cCursorParcelas)
					ZAP
					IF USED("cursor_4c_ParcelasTmp") AND RECCOUNT("cursor_4c_ParcelasTmp") > 0
						APPEND FROM DBF("cursor_4c_ParcelasTmp")
					ENDIF
				ENDIF
				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_ParcelasTmp")
				USE IN cursor_4c_ParcelasTmp
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarParcelas")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

