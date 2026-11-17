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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoporc.prg) - TRECHOS RELEVANTES PARA PASS SQL (5195 linhas total):

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

*-- Linhas 338 a 356:
338: 
339: 				*-- FUNIL de carga (cria/vincula cursores, posiciona e repinta).
340: 				*-- Nao condicionado a loc_lModoValidacaoOuTeste: os cursores sao
341: 				*-- locais (CREATE CURSOR), nao dependem de conexao SQL, e sem a
342: 				*-- chamada as grades abririam com cabecalho "Column<N>" e largura
343: 				*-- default tambem na validacao de UI. Ele ja aplica o layout do
344: 				*-- modo (AtualizarModoCriacao -> HabilitarCampos +
345: 				*-- AjustarBotoesPorModo) e traz os percentuais do cabecalho
346: 				*-- (BOParaForm).
347: 				THIS.CarregarDados()
348: 
349: 				loc_lSucesso = .T.
350: 			ENDIF
351: 		CATCH TO loc_oErro
352: 			MsgErro(loc_oErro.Message + CHR(13) + ;
353: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
354: 				"Procedure: " + loc_oErro.Procedure, ;
355: 				"Erro em Formsigoporc.InicializarForm")
356: 		ENDTRY

*-- Linhas 421 a 482:
421: 	* CriarCursorItens - Cursor local da grade de itens (grd_4c_Itens),
422: 	* equivalente ao crSigMvOrc que o legado compartilha com o form pai via
423: 	* troca de DataSession. Aqui o cursor e proprio deste form (regra
424: 	* OPERACIONAL #2/#3: ControlSource das colunas tem de bater com os
425: 	* campos deste CREATE CURSOR, com a MESMA ordem em qualquer outro lugar
426: 	* que vier a recriar o cursor).
427: 	*
428: 	* Campos cidchaves/cblocos/citens/citem2/citem3/citagrs/cpros/vlbaixas
429: 	* sao usados pelos botoes de linha (Incluir/Excluir) para renumerar o
430: 	* bloco - nao aparecem em coluna do grid, mas existem no cursor (igual
431: 	* ao legado, que os mantem no cursor mesmo sem Column visivel).
432: 	*
433: 	* dcunis/dcunips/dacabs sao campos de PROJECAO (join com SigCdUni/
434: 	* SigCdAca no legado - Column4/Column6/Column30 mostram a DESCRICAO,
435: 	* nao o codigo) - ficam vazios ate a fase do BO que monta a consulta
436: 	* com os joins (CarregarItens - ver cabecalho do BO).
437: 	*
438: 	* cunis/cunips/codacabs sao os CODIGOS que os lookups de celula
439: 	* (SigCdUni em Column4/Column6, SigCdAca em Column30) e o lookup de
440: 	* produto (Column1) gravam - char(3) nas tres colunas de SigMvOrc
441: 	* (docs\schema.sql conferido com Get-Content -Raw, regra #14). Nao tem
442: 	* Column no grid (o grid mostra a descricao), mas EXISTEM no cursor:
443: 	* sem eles o REPLACE dos handlers Validar* estouraria em runtime
444: 	* ("Variable CUNIS is not found") na primeira vez que o usuario
445: 	* escolhesse uma unidade.
446: 	*
447: 	* perc1s..perc6s NAO existem na tabela SigMvOrc (docs\schema.sql
448: 	* conferido) - sao campos de TRABALHO, so do cursor/grid, usados pelo
449: 	* legado para aplicar o percentual digitado nos campos do topo
450: 	* (Fase 5) antes de consolidar o resultado em tota1s..tota10s (que
451: 	* SIM sao persistidos). perc1s nao tem coluna propria no grid (so e
452: 	* usado internamente por TotalizarItn/getPtax2), por isso faltava
453: 	* aqui.
454: 	*==========================================================================
455: 	*
456: 	* Fase 7/8 - ACRESCIMO: emps/dopes/numes/empdopnums/pkchaves/moedas/
457: 	* moefats/moevs/opers nao estavam no cursor (faltavam desde a Fase 3) -
458: 	* sem eles, BO.CarregarDoCursor() (chamado no Salvar) nao tinha de onde
459: 	* ler essas colunas NOT NULL de SigMvOrc, e o INSERT/UPDATE do item
460: 	* gravaria moeda/operacao/chave sempre em branco. emps/dopes/numes
461: 	* tambem sao usados por BO.CarregarItens() como filtro de carga.
462: 	*==========================================================================
463: 	*
464: 	* Fase 8/8 - ACRESCIMO: tpesos/univals/utilizas. As TRES sao colunas
465: 	* REAIS de SigMvOrc (docs\schema.sql conferido com Get-Content -Raw,
466: 	* regra #14), estao no SELECT de BO.CarregarItens e nos INSERT/UPDATE
467: 	* de BO.Inserir/Atualizar - mas FALTAVAM no CREATE CURSOR. Como
468: 	* BO.CarregarDoCursor() le as tres (TratarNulo(tpesos,...)), a leitura
469: 	* estourava "Variable TPESOS is not found" em RUNTIME, dentro do
470: 	* TRY/CATCH do BO: compilava limpo e, na PRIMEIRA linha do SCAN de
471: 	* BtnSalvarClick, o metodo devolvia .F. com as properties do item
472: 	* ainda no valor da linha anterior - ou seja, NENHUM item era gravado
473: 	* corretamente. Mesma familia da regra #22 (campo lido em
474: 	* CarregarDoCursor que nao existe no cursor).
475: 	*
476: 	* vlbaixas fica no cursor mas NUNCA e preenchida pela carga: no legado
477: 	* ela e coluna PROJETADA pela query do form PAI (igual a DcUnis/
478: 	* DcUnips/DAcabs), e SigMvOrc nao tem coluna de baixa. Com 0 fixo, os
479: 	* guards "Empty(VlBaixas)" transcritos do legado ficam sempre
480: 	* verdadeiros (item nunca bloqueado por baixa) - comportamento seguro
481: 	* e explicito, nao silencioso: inventar uma origem para essa coluna
482: 	* seria inventar regra de negocio (regra #17).

*-- Linhas 490 a 570:
490: 		ENDIF
491: 
492: 		SET NULL ON
493: 		CREATE CURSOR (loc_cCursor) ;
494: 			(cidchaves C(20), cblocos C(30), citens N(10,0), citem2 N(10,0), ;
495: 			 citem3 N(10,0), citagrs N(10,0), cpros C(14), dpros C(65), ;
496: 			 dpro2s M, qtds N(8,4), cunis C(3), dcunis C(20), pesos N(8,4), ;
497: 			 cunips C(3), dcunips C(20), codacabs C(3), ;
498: 			 fators N(8,4), units N(13,2), totas N(13,2), tota1s N(13,2), ;
499: 			 tota2s N(13,2), tota3s N(13,2), tota4s N(13,2), tota5s N(13,2), ;
500: 			 tota6s N(13,2), obs M, tota7s N(13,2), tota8s N(13,2), ;
501: 			 tota9s N(13,2), tota10s N(13,2), notas C(9), perc1s N(8,4), ;
502: 			 perc2s N(8,4), perc3s N(8,4), perc4s N(8,4), perc5s N(8,4), ;
503: 			 perc6s N(8,4), servicos L, debitos L, taxas L, dacabs C(40), ;
504: 			 vlbaixas N(13,2), emps C(3), dopes C(20), numes N(6,0), ;
505: 			 empdopnums C(29), pkchaves C(20), moedas C(3), moefats C(3), ;
506: 			 moevs C(3), opers C(1), tpesos N(8,4), univals N(13,2), ;
507: 			 utilizas N(2,0))
508: 		SET NULL OFF
509: 
510: 		INDEX ON citens TAG citens
511: 	ENDPROC
512: 
513: 	*==========================================================================
514: 	* ConfigurarGridItens - grd_4c_Itens, equivalente ao SIGOPORC.grdItem
515: 	* (30 colunas). ControlSource/Width/ColumnOrder/Header1.Caption
516: 	* TRANSCRITOS do dump (PROPRIEDADES DE: SIGOPORC.grdItem e do Init -
517: 	* "With ThisForm.grdItem"). Column1 mostra Dpros (nao "Item" - o
518: 	* Header1.Caption do dump e literalmente esse, apesar do nome sugerir
519: 	* outra coisa) e Column2 mostra Dpro2s - conferido nas DUAS fontes do
520: 	* dump (PROPRIEDADES + Init) porque batiam.
521: 	*
522: 	* FICA PARA FASE POSTERIOR (depende de crSigCdOpe/SigCdEmp, carregados
523: 	* pelo BO em fase propria - ver cabecalho de sigoporcBO.prg):
524: 	*   - ReadOnly fixo (.T.) de Column13/Column14, mascaras de Column3/
525: 	*     Column5/Column7..20 (InputMask calculado de SigOpCdd.CasQtds/
526: 	*     SigCdOpe.NCPesos/Casas) e a troca de Header1.Caption/Width/
527: 	*     Visible conforme LocalEmp.DivNotas (P&G) ou crSigCdOpe.DigItens
528: 	*     IN (6,7) (modo Criacao);
529: 	*   - DynamicBackColor/DynamicForeColor (realce de bloco/sub-bloco);
530: 	*   - Column4/Column6 (DcUnis/DcUnips) e Column30 (DAcabs) so recebem
531: 	*     valor quando o BO passar a montar cursor_4c_Itens com os joins
532: 	*     de unidade/acabamento.
533: 	*==========================================================================
534: 	PROTECTED PROCEDURE ConfigurarGridItens()
535: 		LOCAL loc_lSoLeitura
536: 		loc_lSoLeitura = (THIS.this_cOpEscolha = "CONSULTAR")
537: 
538: 		THIS.AddObject("grd_4c_Itens", "Grid")
539: 
540: 		*-- ColumnCount FORA do WITH: as colunas ainda nao existem no momento
541: 		*-- da compilacao do WITH abaixo (regra CLAUDE.md sobre WITH + Grid -
542: 		*-- "Unknown member COLUMN1"). RecordSource/ControlSource/Width/
543: 		*-- Header1.Caption NAO ficam aqui: vao em VincularGradeItens().
544: 		THIS.grd_4c_Itens.ColumnCount  = 30
545: 
546: 		WITH THIS.grd_4c_Itens
547: 			.Top          = 218
548: 			.Left         = 5
549: 			.Width        = 989
550: 			.Height       = 258
551: 			.FontSize     = 8
552: 			.HeaderHeight = 16
553: 			.RowHeight    = 16
554: 			.ScrollBars   = 3
555: 			.DeleteMark   = .F.
556: 			.RecordMark   = .F.
557: 			.TabIndex     = 13
558: 
559: 			*-- Column1 (Item/Dpros - descritivo do produto). Celula com
560: 			*-- LOOKUP (legado grdItem.Column1.Text1.Valid -> SigCdPro), por
561: 			*-- isso recebe TextBox proprio via AddObject + CurrentControl +
562: 			*-- Sparse = .F. (regra #18: sem CurrentControl a coluna continua
563: 			*-- desenhando o Text1 nativo e o lookup nunca e alcancado; sem
564: 			*-- Sparse = .F. o controle so aparece na linha ativa).
565: 			*-- MaxLength vem da LARGURA da coluna no schema (SigMvOrc.dpros
566: 			*-- char(65)), nunca do Width em pixels (regra #19).
567: 			.Column1.ColumnOrder     = 1
568: 			.Column1.FontSize        = 8
569: 			.Column1.Header1.Alignment = 2
570: 			.Column1.Header1.FontSize  = 8

*-- Linhas 1040 a 1102:
1040: 		loc_cValor = ALLTRIM(par_oTxt.Value)
1041: 
1042: 		IF EMPTY(loc_cValor)
1043: 			SELECT (loc_cItens)
1044: 			REPLACE (par_cCampoCod) WITH ""
1045: 			RETURN
1046: 		ENDIF
1047: 
1048: 		IF USED("cursor_4c_TmpUnidade")
1049: 			USE IN cursor_4c_TmpUnidade
1050: 		ENDIF
1051: 		loc_cSQL = "SELECT Dunis, Cunis FROM SigCdUni WHERE Dunis LIKE " + ;
1052: 			EscaparSQL("%" + loc_cValor + "%") + " ORDER BY Cunis"
1053: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpUnidade")
1054: 
1055: 		IF loc_nResultado < 0
1056: 			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1057: 				"Falha na Conex" + CHR(227) + "o (SigCdUni)")
1058: 			RETURN
1059: 		ENDIF
1060: 
1061: 		loc_cDescEscolhida = ""
1062: 		loc_cCodEscolhido  = ""
1063: 
1064: 		IF USED("cursor_4c_TmpUnidade") AND RECCOUNT("cursor_4c_TmpUnidade") > 0
1065: 			SELECT cursor_4c_TmpUnidade
1066: 			GO TOP
1067: 			LOCATE FOR Dunis = PADR(loc_cValor, 20)
1068: 
1069: 			IF FOUND()
1070: 				loc_cDescEscolhida = ALLTRIM(cursor_4c_TmpUnidade.Dunis)
1071: 				loc_cCodEscolhido  = ALLTRIM(cursor_4c_TmpUnidade.Cunis)
1072: 			ELSE
1073: 				*-- Busca exata falhou: abre o picker sobre o cursor JA
1074: 				*-- populado (equivale ao fwBuscaInt do legado). Regra #50:
1075: 				*-- NAO avisar nem apagar o que o usuario digitou aqui - o
1076: 				*-- picker e o proprio feedback.
1077: 				THIS.AbrirBuscaUnidade()
1078: 				loc_cCodEscolhido  = THIS.this_cLookupCodigo
1079: 				loc_cDescEscolhida = THIS.this_cLookupDescricao
1080: 			ENDIF
1081: 		ENDIF
1082: 
1083: 		IF USED("cursor_4c_TmpUnidade")
1084: 			USE IN cursor_4c_TmpUnidade
1085: 		ENDIF
1086: 
1087: 		SELECT (loc_cItens)
1088: 		IF EMPTY(loc_cCodEscolhido)
1089: 			par_oTxt.Value = ""
1090: 			REPLACE (par_cCampoDesc) WITH "", (par_cCampoCod) WITH ""
1091: 		ELSE
1092: 			par_oTxt.Value = loc_cDescEscolhida
1093: 			REPLACE (par_cCampoDesc) WITH loc_cDescEscolhida, (par_cCampoCod) WITH loc_cCodEscolhido
1094: 		ENDIF
1095: 	ENDPROC
1096: 
1097: 	*==========================================================================
1098: 	* ValidarAcabamentoKeyPress - legado SIGOPORC.grdItem.Column30.Text1.
1099: 	* Valid. O usuario digita a descricao do acabamento (dacabs); o metodo
1100: 	* busca em SigCdAca por LIKE e abre o picker local quando ha mais de
1101: 	* um resultado. Universo VAZIO (zero linhas) NAO e erro de migracao
1102: 	* (regra #50): manter o aviso do legado, mas NUNCA apagar o texto que

*-- Linhas 1125 a 1152:
1125: 		loc_cValor = ALLTRIM(loc_oTxt.Value)
1126: 
1127: 		IF EMPTY(loc_cValor)
1128: 			SELECT (loc_cItens)
1129: 			REPLACE codacabs WITH ""
1130: 			RETURN
1131: 		ENDIF
1132: 
1133: 		IF USED("cursor_4c_TmpAcabamento")
1134: 			USE IN cursor_4c_TmpAcabamento
1135: 		ENDIF
1136: 		loc_cSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Descrs LIKE " + EscaparSQL("%" + loc_cValor + "%")
1137: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpAcabamento")
1138: 
1139: 		IF loc_nResultado < 0
1140: 			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1141: 				"Falha na Conex" + CHR(227) + "o (SigCdAca)")
1142: 			RETURN
1143: 		ENDIF
1144: 
1145: 		loc_cDescEscolhida = ""
1146: 		loc_cCodEscolhido  = ""
1147: 
1148: 		IF USED("cursor_4c_TmpAcabamento") AND RECCOUNT("cursor_4c_TmpAcabamento") > 0
1149: 			THIS.AbrirBuscaAcabamento()
1150: 			loc_cCodEscolhido  = THIS.this_cLookupCodigo
1151: 			loc_cDescEscolhida = THIS.this_cLookupDescricao
1152: 		ELSE

*-- Linhas 1160 a 1195:
1160: 			USE IN cursor_4c_TmpAcabamento
1161: 		ENDIF
1162: 
1163: 		SELECT (loc_cItens)
1164: 		IF !EMPTY(loc_cCodEscolhido)
1165: 			loc_oTxt.Value = loc_cDescEscolhida
1166: 			REPLACE dacabs WITH loc_cDescEscolhida, codacabs WITH loc_cCodEscolhido
1167: 		ELSE
1168: 			REPLACE codacabs WITH ""
1169: 		ENDIF
1170: 	ENDPROC
1171: 
1172: 	*==========================================================================
1173: 	* ValidarProdutoItemKeyPress - legado SIGOPORC.grdItem.Column1.Text1.
1174: 	* Valid (o trecho de LOOKUP; a precificacao automatica que vem depois
1175: 	* dele no dump depende de crSigCdOpe/crSigOpCdd, carregados em fase
1176: 	* propria do BO - ver cabecalho da classe).
1177: 	*
1178: 	* O usuario digita parte da DESCRICAO do produto (Dpros); o metodo
1179: 	* consulta SigCdPro com a restricao de SigCdRpo (Dopps = Dopes do
1180: 	* cabecalho) - quando a restricao existe, o legado faz INNER JOIN; sem
1181: 	* restricao, consulta SigCdPro direto. Resolve por busca exata e, se
1182: 	* nao casar, abre o picker.
1183: 	*
1184: 	* Guardas TRANSCRITAS do legado (regra #21b - a condicao que cerca a
1185: 	* validacao FAZ PARTE dela):
1186: 	*   - valor nao mudou desde a entrada na celula (this_cAntDpros,
1187: 	*     comparado com PADR(...,40) igual ao legado) -> sai sem consultar
1188: 	*   - linha de SUBTOTAL (citens = citem2) ou de marcador de nivel
1189: 	*     (citens = citem3) -> o legado NAO faz lookup: nessas linhas a
1190: 	*     descricao digitada e so o rotulo do bloco, propagado para o
1191: 	*     dpro2s das linhas de SUBTOTAL do mesmo agrupamento
1192: 	*
1193: 	* O valor digitado esta em .Value (o cursor so recebe DEPOIS, via
1194: 	* REPLACE - regra #46), e a descricao escolhida volta para .Value alem
1195: 	* do REPLACE, senao o texto digitado sobrescreveria o cursor.

*-- Linhas 1213 a 1350:
1213: 
1214: 		loc_cValor = ALLTRIM(TratarNulo(loc_oTxt.Value, ""))
1215: 
1216: 		SELECT (loc_cItens)
1217: 		loc_nItens = citens
1218: 		loc_nItem2 = citem2
1219: 		loc_nItem3 = citem3
1220: 
1221: 		*-- Linha de SUBTOTAL / marcador de nivel: sem lookup. O legado
1222: 		*-- propaga o rotulo digitado para o dpro2s das linhas de SUBTOTAL
1223: 		*-- do mesmo agrupamento e volta ao item corrente por SEEK no TAG
1224: 		*-- citens.
1225: 		IF loc_nItens = loc_nItem2 OR loc_nItens = loc_nItem3
1226: 			IF loc_nItens = loc_nItem2 AND loc_nItens = loc_nItem3
1227: 				REPLACE dpro2s WITH loc_cValor ;
1228: 					FOR citem3 = loc_nItens AND citem2 = citens AND cblocos = "SUBTOTAL" ;
1229: 					IN (loc_cItens)
1230: 			ELSE
1231: 				REPLACE dpro2s WITH loc_cValor ;
1232: 					FOR citem2 = loc_nItem2 AND cblocos = "SUBTOTAL" ;
1233: 					IN (loc_cItens)
1234: 			ENDIF
1235: 			SELECT (loc_cItens)
1236: 			=SEEK(loc_nItens, loc_cItens, "citens")
1237: 			THIS.this_cAntDpros = loc_cValor
1238: 			THIS.grd_4c_Itens.Refresh()
1239: 			RETURN
1240: 		ENDIF
1241: 
1242: 		*-- Valor nao mudou desde que o usuario entrou na celula
1243: 		IF PADR(loc_cValor, 40) = PADR(ALLTRIM(TratarNulo(THIS.this_cAntDpros, "")), 40)
1244: 			RETURN
1245: 		ENDIF
1246: 
1247: 		IF EMPTY(loc_cValor)
1248: 			SELECT (loc_cItens)
1249: 			REPLACE cpros WITH "", cunis WITH "", cunips WITH ""
1250: 			THIS.this_cAntDpros = ""
1251: 			RETURN
1252: 		ENDIF
1253: 
1254: 		*-- Ha restricao de grupo/grande grupo para esta movimentacao?
1255: 		IF USED("cursor_4c_RestricaoProduto")
1256: 			USE IN cursor_4c_RestricaoProduto
1257: 		ENDIF
1258: 		loc_cSQL = "SELECT Cgrus, Opers, Mercs, Contas, CodCors FROM SigCdRpo WHERE Dopps = " + ;
1259: 			EscaparSQL(THIS.this_cDopes)
1260: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RestricaoProduto")
1261: 
1262: 		IF loc_nResultado < 0
1263: 			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1264: 				"Falha na Conex" + CHR(227) + "o (SigCdRpo)")
1265: 			RETURN
1266: 		ENDIF
1267: 
1268: 		loc_lRestrito = (USED("cursor_4c_RestricaoProduto") AND ;
1269: 			RECCOUNT("cursor_4c_RestricaoProduto") > 0)
1270: 
1271: 		IF USED("cursor_4c_RestricaoProduto")
1272: 			USE IN cursor_4c_RestricaoProduto
1273: 		ENDIF
1274: 
1275: 		IF USED("cursor_4c_BuscaProduto")
1276: 			USE IN cursor_4c_BuscaProduto
1277: 		ENDIF
1278: 
1279: 		loc_cSQL = "SELECT a.Cpros, a.Dpros, a.Dpro2s, a.Cunis, a.cUniPs," + ;
1280: 			" a.Situas, a.DtSituas, a.Cgrus, a.Mercs" + ;
1281: 			" FROM SigCdPro a"
1282: 		IF loc_lRestrito
1283: 			loc_cSQL = loc_cSQL + ;
1284: 				" INNER JOIN SigCdRpo b ON (a.Cgrus = b.Cgrus OR a.Mercs = b.Mercs)" + ;
1285: 				" AND b.Dopps = " + EscaparSQL(THIS.this_cDopes)
1286: 		ENDIF
1287: 		loc_cSQL = loc_cSQL + ;
1288: 			" WHERE a.DPros LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
1289: 			" ORDER BY a.Cpros, a.Cgrus"
1290: 
1291: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProduto")
1292: 
1293: 		IF loc_nResultado < 0
1294: 			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1295: 				"Falha na Conex" + CHR(227) + "o (SigCdPro)")
1296: 			RETURN
1297: 		ENDIF
1298: 
1299: 		loc_cCodEscolhido  = ""
1300: 		loc_cDescEscolhida = ""
1301: 		loc_cDescritivo    = ""
1302: 		loc_cCunis         = ""
1303: 		loc_cCunips        = ""
1304: 
1305: 		IF USED("cursor_4c_BuscaProduto") AND RECCOUNT("cursor_4c_BuscaProduto") > 0
1306: 			SELECT cursor_4c_BuscaProduto
1307: 			GO TOP
1308: 			LOCATE FOR ALLTRIM(UPPER(Dpros)) == UPPER(loc_cValor)
1309: 
1310: 			IF !FOUND()
1311: 				*-- Busca exata falhou: picker sobre o cursor JA populado
1312: 				*-- (equivale ao fwBuscaInt do legado). Regra #50: sem aviso
1313: 				*-- e sem apagar o que o usuario digitou.
1314: 				THIS.AbrirBuscaProdutoItem()
1315: 				IF !EMPTY(THIS.this_cLookupCodigo) AND USED("cursor_4c_BuscaProduto")
1316: 					SELECT cursor_4c_BuscaProduto
1317: 					GO TOP
1318: 					LOCATE FOR ALLTRIM(Cpros) == ALLTRIM(THIS.this_cLookupCodigo)
1319: 				ENDIF
1320: 			ENDIF
1321: 
1322: 			IF FOUND()
1323: 				loc_cCodEscolhido  = ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.Cpros, ""))
1324: 				loc_cDescEscolhida = ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.Dpros, ""))
1325: 				loc_cDescritivo    = ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.Dpro2s, ""))
1326: 				loc_cCunis         = ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.Cunis, ""))
1327: 				loc_cCunips        = ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.cUniPs, ""))
1328: 			ENDIF
1329: 		ENDIF
1330: 
1331: 		IF USED("cursor_4c_BuscaProduto")
1332: 			USE IN cursor_4c_BuscaProduto
1333: 		ENDIF
1334: 
1335: 		SELECT (loc_cItens)
1336: 		IF !EMPTY(loc_cCodEscolhido)
1337: 			loc_oTxt.Value = loc_cDescEscolhida
1338: 			REPLACE cpros  WITH loc_cCodEscolhido, ;
1339: 				dpros  WITH loc_cDescEscolhida, ;
1340: 				dpro2s WITH IIF(EMPTY(ALLTRIM(TratarNulo(dpro2s, ""))), loc_cDescritivo, dpro2s), ;
1341: 				cunis  WITH loc_cCunis, ;
1342: 				cunips WITH loc_cCunips
1343: 			THIS.this_cAntDpros = loc_cDescEscolhida
1344: 		ENDIF
1345: 
1346: 		THIS.grd_4c_Itens.Refresh()
1347: 	ENDPROC
1348: 
1349: 	*==========================================================================
1350: 	* AbrirBuscaProdutoItem - picker do lookup de produto da celula

*-- Linhas 1526 a 1589:
1526: 	* Column.Width e Column.Header1.Caption (regra #41 / Problema 48), entao
1527: 	* os dois tem de ser reaplicados DEPOIS de cada bind - e o bind acontece
1528: 	* mais de uma vez (toda vez que o cursor de itens e recriado pelo funil
1529: 	* CarregarDados). Ordem canonica: RecordSource -> ControlSource ->
1530: 	* Width -> Header1.Caption.
1531: 	*
1532: 	* O bind e CONDICIONADO a USED(cursor): instanciado sem cursor (harness de
1533: 	* teste), atribuir RecordSource estouraria "Alias is not found". Width e
1534: 	* Header1.Caption sao aplicados SEMPRE, com ou sem alias aberto - senao a
1535: 	* grade apareceria com cabecalho "Column1" e largura default.
1536: 	*==========================================================================
1537: 	PROTECTED PROCEDURE VincularGradeItens()
1538: 		LOCAL loc_cCursor
1539: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
1540: 
1541: 		WITH THIS.grd_4c_Itens
1542: 			IF USED(loc_cCursor)
1543: 				.RecordSource = loc_cCursor
1544: 
1545: 				.Column1.ControlSource = loc_cCursor + ".dpros"
1546: 				.Column2.ControlSource = loc_cCursor + ".dpro2s"
1547: 				.Column3.ControlSource = loc_cCursor + ".qtds"
1548: 				.Column4.ControlSource = loc_cCursor + ".dcunis"
1549: 				.Column5.ControlSource = loc_cCursor + ".pesos"
1550: 				.Column6.ControlSource = loc_cCursor + ".dcunips"
1551: 				.Column7.ControlSource = loc_cCursor + ".fators"
1552: 				.Column8.ControlSource = loc_cCursor + ".units"
1553: 				.Column9.ControlSource = loc_cCursor + ".totas"
1554: 				.Column10.ControlSource = loc_cCursor + ".tota1s"
1555: 				.Column11.ControlSource = loc_cCursor + ".tota2s"
1556: 				.Column12.ControlSource = loc_cCursor + ".tota3s"
1557: 				.Column13.ControlSource = loc_cCursor + ".tota4s"
1558: 				.Column14.ControlSource = loc_cCursor + ".tota5s"
1559: 				.Column15.ControlSource = loc_cCursor + ".tota6s"
1560: 				.Column16.ControlSource = loc_cCursor + ".obs"
1561: 				.Column17.ControlSource = loc_cCursor + ".tota7s"
1562: 				.Column18.ControlSource = loc_cCursor + ".tota8s"
1563: 				.Column19.ControlSource = loc_cCursor + ".tota9s"
1564: 				.Column20.ControlSource = loc_cCursor + ".tota10s"
1565: 				.Column21.ControlSource = loc_cCursor + ".notas"
1566: 				.Column22.ControlSource = loc_cCursor + ".perc4s"
1567: 				.Column23.ControlSource = loc_cCursor + ".perc5s"
1568: 				.Column24.ControlSource = loc_cCursor + ".perc6s"
1569: 				.Column25.ControlSource = loc_cCursor + ".perc2s"
1570: 				.Column26.ControlSource = loc_cCursor + ".perc3s"
1571: 				.Column27.ControlSource = loc_cCursor + ".servicos"
1572: 				.Column28.ControlSource = loc_cCursor + ".debitos"
1573: 				.Column29.ControlSource = loc_cCursor + ".taxas"
1574: 				.Column30.ControlSource = loc_cCursor + ".dacabs"
1575: 			ENDIF
1576: 
1577: 			*-- Width/Header1.Caption SEMPRE depois do bind (RecordSource reseta
1578: 			*-- os dois para 90 / "Column<N>"). Transcritos do dump do legado.
1579: 			.Column1.Width           = 290
1580: 			.Column1.Header1.Caption = "Item"
1581: 			.Column2.Width           = 290
1582: 			.Column2.Header1.Caption = "Descritivo"
1583: 			.Column3.Width           = 122
1584: 			.Column3.Header1.Caption = "Quantidade"
1585: 			.Column4.Width           = 150
1586: 			.Column4.Header1.Caption = "Unidade"
1587: 			.Column5.Width           = 45
1588: 			.Column5.Header1.Caption = "Per" + CHR(237) + "odo"
1589: 			.Column6.Width           = 150

*-- Linhas 1734 a 1787:
1734: 	*
1735: 	* dfors NAO e coluna de SigMvOrp - e PROJECAO: o legado liga
1736: 	* grdParcela.Column6 a crSigMvOrp.Dfors, que e a razao social do
1737: 	* fornecedor (SigCdCli.RClis) trazida pelo join em Ifors. Fica vazia
1738: 	* ate a fase do BO que monta a consulta com o join.
1739: 	*
1740: 	* A ORDEM DOS CAMPOS deste CREATE CURSOR e a unica do form (regra
1741: 	* OPERACIONAL #2): qualquer outro ponto que venha a recriar o cursor
1742: 	* tem de chamar ESTE metodo, nunca repetir o CREATE CURSOR.
1743: 	*==========================================================================
1744: 	PROTECTED PROCEDURE CriarCursorParcelas()
1745: 		LOCAL loc_cCursor
1746: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorParcelas
1747: 
1748: 		IF USED(loc_cCursor)
1749: 			USE IN (loc_cCursor)
1750: 		ENDIF
1751: 
1752: 		SET NULL ON
1753: 		CREATE CURSOR (loc_cCursor) ;
1754: 			(cidchaves C(20), citens N(10,0), datas D, dopes C(29), ;
1755: 			 empdopnums C(29), emps C(3), numes N(6,0), percs N(5,2), ;
1756: 			 valos N(13,2), vlbaixas N(12,2), borderos N(10,0), ;
1757: 			 ifors C(10), valcreds N(13,2), dfors C(50))
1758: 		SET NULL OFF
1759: 
1760: 		*-- Legado (fim do Init): Select crSigMvOrp / Set Order to / Set Order
1761: 		*-- to CItens - a grade de parcelas e sempre vista pela ordem do item,
1762: 		*-- porque e por essa chave que PosicionarParcelasDoItem filtra.
1763: 		INDEX ON citens TAG citens
1764: 	ENDPROC
1765: 
1766: 	*==========================================================================
1767: 	* ConfigurarGradeParcelas - grd_4c_Parcelas, equivalente ao
1768: 	* SIGOPORC.grdParcela (7 colunas). Geometria/fonte/cor/ColumnOrder
1769: 	* TRANSCRITOS do dump ("PROPRIEDADES DE: SIGOPORC.grdParcela").
1770: 	*
1771: 	* Igual a grade de itens, aqui fica SO o que nao depende de dado;
1772: 	* RecordSource/ControlSource/Width/Header1.Caption vao em
1773: 	* VincularGradeParcelas().
1774: 	*
1775: 	* ReadOnly por coluna transcrito do Init legado ("With ThisForm.grdParcela"):
1776: 	* Column4 (Fornecedor), Column6 (Descricao) e Column7 (Credito) sao
1777: 	* ReadOnly = .T. SEMPRE - sao projecao/valor calculado, nao entrada; as
1778: 	* demais seguem o modo (CONSULTAR = somente leitura). O ReadOnly da
1779: 	* COLUNA vem DEPOIS do ReadOnly do GRID, senao o do grid sobrescreve
1780: 	* (regra #46).
1781: 	*==========================================================================
1782: 	PROTECTED PROCEDURE ConfigurarGradeParcelas()
1783: 		LOCAL loc_lSoLeitura
1784: 		loc_lSoLeitura = (THIS.this_cOpEscolha = "CONSULTAR")
1785: 
1786: 		THIS.AddObject("grd_4c_Parcelas", "Grid")
1787: 

*-- Linhas 1800 a 1818:
1800: 			.RowHeight    = 16
1801: 			.Panel        = 1
1802: 			.ScrollBars   = 3
1803: 			.DeleteMark   = .F.
1804: 			.RecordMark   = .F.
1805: 			.TabIndex     = 25
1806: 			.ReadOnly     = loc_lSoLeitura
1807: 
1808: 			*-- Column1 (% - percs)
1809: 			.Column1.ColumnOrder       = 3
1810: 			.Column1.FontName          = "Tahoma"
1811: 			.Column1.FontSize          = 8
1812: 			.Column1.ForeColor         = RGB(90, 90, 90)
1813: 			.Column1.Header1.Alignment = 2
1814: 			.Column1.Header1.FontSize  = 8
1815: 			.Column1.ReadOnly          = loc_lSoLeitura
1816: 
1817: 			*-- Column2 (Data - datas)
1818: 			.Column2.ColumnOrder       = 4

*-- Linhas 1878 a 1912:
1878: 	* Width/Header1.Caption, entao os dois vem DEPOIS do bind e sao
1879: 	* aplicados SEMPRE, com ou sem alias aberto. Bind condicionado a
1880: 	* USED(cursor) para nao estourar "Alias is not found" no harness.
1881: 	* ControlSource transcrito do Init legado ("With ThisForm.grdParcela").
1882: 	*==========================================================================
1883: 	PROTECTED PROCEDURE VincularGradeParcelas()
1884: 		LOCAL loc_cCursor
1885: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorParcelas
1886: 
1887: 		WITH THIS.grd_4c_Parcelas
1888: 			IF USED(loc_cCursor)
1889: 				.RecordSource = loc_cCursor
1890: 
1891: 				.Column1.ControlSource = loc_cCursor + ".percs"
1892: 				.Column2.ControlSource = loc_cCursor + ".datas"
1893: 				.Column3.ControlSource = loc_cCursor + ".valos"
1894: 				.Column4.ControlSource = loc_cCursor + ".ifors"
1895: 				.Column5.ControlSource = loc_cCursor + ".vlbaixas"
1896: 				.Column6.ControlSource = loc_cCursor + ".dfors"
1897: 				.Column7.ControlSource = loc_cCursor + ".valcreds"
1898: 			ENDIF
1899: 
1900: 			*-- Width/Header1.Caption SEMPRE depois do bind. Transcritos do
1901: 			*-- dump (PROPRIEDADES DE: SIGOPORC.grdParcela + o Header1 de cada
1902: 			*-- Column no layout do legado).
1903: 			.Column1.Width           = 70
1904: 			.Column1.Header1.Caption = "%"
1905: 			.Column2.Width           = 70
1906: 			.Column2.Header1.Caption = "Data"
1907: 			.Column3.Width           = 122
1908: 			.Column3.Header1.Caption = "Previsto"
1909: 			.Column4.Width           = 80
1910: 			.Column4.Header1.Caption = "Fornecedor"
1911: 			.Column5.Width           = 122
1912: 			.Column5.Header1.Caption = "Realizado"

*-- Linhas 2000 a 2030:
2000: 
2001: 		THIS.LockScreen = .T.
2002: 
2003: 		SELECT (loc_cItens)
2004: 		loc_lPodeIncluir = (citens <> citem2) AND !EMPTY(cpros) AND ;
2005: 			!INLIST(ALLTRIM(cblocos), "SUBTOTAL", "BRANCO", "SUBTOTAIS", ;
2006: 				"TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
2007: 		loc_nItem = citens
2008: 
2009: 		IF loc_lPodeIncluir
2010: 			INSERT INTO (loc_cParcelas) ;
2011: 				(emps, dopes, numes, citens, datas, valos, vlbaixas) ;
2012: 				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
2013: 					loc_nItem, CTOD(""), 0, 0)
2014: 
2015: 			SELECT (loc_cParcelas)
2016: 			GO BOTTOM
2017: 		ENDIF
2018: 
2019: 		THIS.grd_4c_Parcelas.Refresh()
2020: 		THIS.LockScreen = .F.
2021: 
2022: 		*-- Legado: thisform.grdParcela.column4.SetFocus()
2023: 		THIS.grd_4c_Parcelas.Column4.SetFocus()
2024: 	ENDPROC
2025: 
2026: 	*==========================================================================
2027: 	* BtnExcluirParcelaClick - legado SIGOPORC.btnExcluirp.Click. Exclui a
2028: 	* parcela corrente, recusando a exclusao quando ela JA FOI BAIXADA
2029: 	* (VlBaixas preenchido) - a regra e a mensagem sao do legado.
2030: 	*

*-- Linhas 2044 a 2100:
2044: 			RETURN
2045: 		ENDIF
2046: 
2047: 		SELECT (loc_cParcelas)
2048: 
2049: 		IF !EMPTY(vlbaixas)
2050: 			*-- Legado: "A parcela ja joi autorizada!" - o "joi" e erro de
2051: 			*-- digitacao do original, visivel ao usuario; aqui sai "foi",
2052: 			*-- sem mudar o sentido da mensagem.
2053: 			MsgAviso("A parcela j" + CHR(225) + " foi autorizada!", ;
2054: 				"Imposs" + CHR(237) + "vel excluir")
2055: 		ELSE
2056: 			THIS.LockScreen = .T.
2057: 
2058: 			IF !EOF(loc_cParcelas)
2059: 				DELETE
2060: 				GO TOP
2061: 			ENDIF
2062: 
2063: 			THIS.grd_4c_Parcelas.Refresh()
2064: 			THIS.LockScreen = .F.
2065: 
2066: 			*-- Legado: thisform.grdParcela.column1.SetFocus()
2067: 			THIS.grd_4c_Parcelas.Column1.SetFocus()
2068: 		ENDIF
2069: 	ENDPROC
2070: 
2071: 	*==========================================================================
2072: 	* ConfigurarCamposPercentuais - Shape4 (moldura decorativa) + os 6
2073: 	* campos de percentual do cabecalho (say5/getPmargem .. Say6/
2074: 	* getPservico do legado). TRANSCRITOS do dump (bloco "PROPRIEDADES
2075: 	* DE: SIGOPORC.<nome>"), pareados por proximidade de Top (label.Top =
2076: 	* textbox.Top + 3, conferido um a um):
2077: 	*
2078: 	*   Say5 "Margem :...%"            (96)  <-> getPmargem      (93)  - SEM ControlSource; When sempre .F. (resultado calculado por TotalizarItn, nunca digitado)
2079: 	*   say4 "Contingente :...%"       (116) <-> getPtax2        (113) - ControlSource = TprMvCab.ptax2s (Perc1s)
2080: 	*   say1 "Ta\<xa Adm. :...%"       (136) <-> getPtaxa        (133) - ControlSource = TprMvCab.descs  (Perc2s)
2081: 	*   Say3 "BV :...%"                (156) <-> getPTax1        (153) - ControlSource = TprMvCab.ptax1s (Perc3s)
2082: 	*   say2 "Im\<posto :...%"         (176) <-> getPimposto     (173) - ControlSource = TprMvCab.acres  (Perc4s, item nao-servico)
2083: 	*   Say6 "Imposto sem ISS :...%"   (196) <-> getPservico     (193) - ControlSource = TprMvCab.ptax3s (Perc4s, item servico)
2084: 	*
2085: 	* Nenhum dos 5 TextBoxes editaveis usa ControlSource aqui: TprMvCab e
2086: 	* cursor do FORM PAI no legado (nao existe neste dialogo), e os 5
2087: 	* valores correspondentes (this_nPTax2s/this_nDescs/this_nPTax1s/
2088: 	* this_nAcres/this_nPTax3s) sao escalares do BO, repassados uma unica
2089: 	* vez na abertura (nao mudam por item) - a sincronizacao e manual
2090: 	* (.Value lido/escrito direto), igual ao padrao ja usado para
2091: 	* this_cEmps/this_cDopes/etc.
2092: 	*
2093: 	* SIMPLIFICACAO DOCUMENTADA: o legado guarda This.PEAntValue (property
2094: 	* da classe fwget) e so executa a cascata de Replace quando
2095: 	* "this.Value <> this.peantvalue" (evita reprocessar se o usuario so
2096: 	* passou pelo campo sem alterar). Como a cascata e IDEMPOTENTE (mesmo
2097: 	* valor de entrada sempre produz o mesmo resultado), replicar esse
2098: 	* guard exigiria 5 handlers de GotFocus extras so para guardar o
2099: 	* valor anterior em .Tag - trocado aqui por executar a cascata sempre
2100: 	* que o valor NAO esta vazio, no Enter/Tab (regra "BINDEVENT Valid nao

*-- Linhas 2354 a 2372:
2354: 
2355: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2356: 		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
2357: 			SELECT (loc_cItens)
2358: 			loc_nItens = citens
2359: 			SCAN
2360: 				REPLACE perc1s WITH loc_nValor, ;
2361: 					tota1s WITH (totas * loc_nValor) / 100, ;
2362: 					tota2s WITH ((totas + tota1s) * perc2s) / 100, ;
2363: 					tota3s WITH ((totas + tota1s + tota2s) * perc3s) / 100, ;
2364: 					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2365: 					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2366: 			ENDSCAN
2367: 			= SEEK(loc_nItens, loc_cItens, "citens")
2368: 		ENDIF
2369: 
2370: 		THIS.TotalizarItn()
2371: 	ENDPROC
2372: 

*-- Linhas 2393 a 2411:
2393: 
2394: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2395: 		IF USED(loc_cItens)
2396: 			SELECT (loc_cItens)
2397: 			loc_nItens = citens
2398: 
2399: 			IF THIS.this_oBusinessObject.this_nDivNotas = 2
2400: 				SCAN
2401: 					REPLACE perc2s WITH loc_nValor, ;
2402: 						tota2s WITH ((totas + tota1s) * loc_nValor) / 100, ;
2403: 						tota3s WITH ((totas + tota1s + tota2s) * perc3s) / 100, ;
2404: 						tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2405: 						tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2406: 				ENDSCAN
2407: 			ELSE
2408: 				GO TOP
2409: 				LOCATE FOR ALLTRIM(cblocos) == "TAXA"
2410: 				IF FOUND()
2411: 					REPLACE perc1s WITH loc_nValor, perc2s WITH loc_nValor, perc3s WITH loc_nValor

*-- Linhas 2440 a 2458:
2440: 
2441: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2442: 		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
2443: 			SELECT (loc_cItens)
2444: 			loc_nItens = citens
2445: 			SCAN
2446: 				REPLACE perc3s WITH loc_nValor, ;
2447: 					tota3s WITH ((totas + tota1s + tota2s) * loc_nValor) / 100, ;
2448: 					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2449: 					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2450: 			ENDSCAN
2451: 			= SEEK(loc_nItens, loc_cItens, "citens")
2452: 		ENDIF
2453: 
2454: 		THIS.TotalizarItn()
2455: 	ENDPROC
2456: 
2457: 	*==========================================================================
2458: 	* TxtImpostoKeyPress - legado SIGOPORC.getPimposto.Valid. Perc4s

*-- Linhas 2476 a 2494:
2476: 
2477: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2478: 		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
2479: 			SELECT (loc_cItens)
2480: 			loc_nItens = citens
2481: 			SCAN
2482: 				REPLACE perc4s WITH loc_nValor, ;
2483: 					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2484: 					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2485: 			ENDSCAN
2486: 			= SEEK(loc_nItens, loc_cItens, "citens")
2487: 		ENDIF
2488: 
2489: 		THIS.TotalizarItn()
2490: 	ENDPROC
2491: 
2492: 	*==========================================================================
2493: 	* TxtImpostoServicoKeyPress - legado SIGOPORC.getPservico.Valid.
2494: 	* Perc4s (imposto, variante "sem ISS") - aplicado SO nos itens

*-- Linhas 2512 a 2530:
2512: 
2513: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2514: 		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
2515: 			SELECT (loc_cItens)
2516: 			loc_nItens = citens
2517: 			SCAN FOR servicos
2518: 				REPLACE perc4s WITH loc_nValor, ;
2519: 					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2520: 					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2521: 			ENDSCAN
2522: 			= SEEK(loc_nItens, loc_cItens, "citens")
2523: 		ENDIF
2524: 
2525: 		THIS.TotalizarItn()
2526: 	ENDPROC
2527: 
2528: 	*==========================================================================
2529: 	* TotalizarItn - legado SIGOPORC.TotalizarItn. Motor de calculo
2530: 	* chamado por calc_valite (fase posterior) e pelos 5 campos de

*-- Linhas 2558 a 2576:
2558: 
2559: 		THIS.LockScreen = .T.
2560: 
2561: 		SELECT (loc_cItens)
2562: 		loc_nItens = citens
2563: 		loc_nItem2 = citem2
2564: 		loc_nItem3 = citem3
2565: 		loc_nItAgr = citagrs
2566: 
2567: 		IF THIS.this_oBusinessObject.this_nDivNotas = 2
2568: 			*-- P&G
2569: 			REPLACE tota1s WITH IIF(perc1s = 0, tota1s, (totas * perc1s) / 100), ;
2570: 				tota2s WITH IIF(perc2s = 0, tota2s, ((totas + tota1s) * perc2s) / 100), ;
2571: 				tota3s WITH IIF(perc3s = 0, tota3s, ((totas + tota1s + tota2s) * perc3s) / 100)
2572: 			REPLACE tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s))
2573: 			REPLACE tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2574: 		ELSE
2575: 			*-- SRCOM: total dos valores de NF SRCOM e fornecedor
2576: 			IF EMPTY(perc2s) AND EMPTY(perc3s)

*-- Linhas 2588 a 2694:
2588: 			IF INT(VAL(SUBSTR(THIS.this_oBusinessObject.this_cConfigGers, 192, 1))) = 1
2589: 				*-- Decupagem
2590: 				GO TOP
2591: 				SELECT SUM(totas) AS totas, SUM(tota1s) AS tota1s, SUM(tota2s) AS tota2s, SUM(tota3s) AS tota3s, ;
2592: 						SUM(tota7s) AS tota7s, SUM(tota8s) AS tota8s, SUM(tota9s) AS tota9s, SUM(tota10s) AS tota10s ;
2593: 					FROM (loc_cItens) WHERE citagrs = IIF(!EMPTY(loc_nItAgr), loc_nItAgr, loc_nItens) ;
2594: 					INTO CURSOR cursor_4c_TmpTotBlo
2595: 
2596: 				IF !EOF("cursor_4c_TmpTotBlo") AND !EMPTY(cursor_4c_TmpTotBlo.totas)
2597: 					SELECT (loc_cItens)
2598: 					= SEEK(IIF(!EMPTY(loc_nItAgr), loc_nItAgr, loc_nItens), loc_cItens, "citens")
2599: 
2600: 					REPLACE tota9s WITH IIF(!EMPTY(tota1s), tota1s - tota8s, tota2s) - tota7s, ;
2601: 						tota10s WITH IIF(!EMPTY(tota1s), 0, tota3s - tota8s)
2602: 
2603: 					REPLACE tota9s WITH tota9s - cursor_4c_TmpTotBlo.tota7s, ;
2604: 						tota10s WITH tota10s - cursor_4c_TmpTotBlo.tota8s
2605: 				ENDIF
2606: 			ENDIF
2607: 		ENDIF
2608: 
2609: 		SELECT (loc_cItens)
2610: 		GO TOP
2611: 
2612: 		SELECT SUM(totas) AS totas, SUM(tota1s) AS tota1s, SUM(tota2s) AS tota2s, SUM(tota3s) AS tota3s, ;
2613: 				SUM(tota4s) AS tota4s, SUM(tota5s) AS tota5s, SUM(tota6s) AS tota6s, SUM(tota7s) AS tota7s, ;
2614: 				SUM(tota8s) AS tota8s, SUM(tota9s) AS tota9s, SUM(tota10s) AS tota10s ;
2615: 			FROM (loc_cItens) ;
2616: 			WHERE citem2 = loc_nItem2 AND !INLIST(ALLTRIM(cblocos), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
2617: 			GROUP BY citem2 INTO CURSOR cursor_4c_TmpTotBlo
2618: 
2619: 		SELECT (loc_cItens)
2620: 		GO TOP
2621: 		LOCATE FOR citem2 = loc_nItem2 AND ALLTRIM(cblocos) == "SUBTOTAL"
2622: 		IF FOUND()
2623: 			REPLACE totas WITH cursor_4c_TmpTotBlo.totas, tota1s WITH cursor_4c_TmpTotBlo.tota1s, ;
2624: 				tota2s WITH cursor_4c_TmpTotBlo.tota2s, tota3s WITH cursor_4c_TmpTotBlo.tota3s, ;
2625: 				tota4s WITH cursor_4c_TmpTotBlo.tota4s, tota5s WITH cursor_4c_TmpTotBlo.tota5s, ;
2626: 				tota6s WITH cursor_4c_TmpTotBlo.tota6s, tota7s WITH cursor_4c_TmpTotBlo.tota7s, ;
2627: 				tota8s WITH cursor_4c_TmpTotBlo.tota8s, tota9s WITH cursor_4c_TmpTotBlo.tota9s, ;
2628: 				tota10s WITH cursor_4c_TmpTotBlo.tota10s
2629: 		ENDIF
2630: 
2631: 		SELECT (loc_cItens)
2632: 		GO TOP
2633: 
2634: 		SELECT SUM(totas) AS totas, SUM(tota1s) AS tota1s, SUM(tota2s) AS tota2s, SUM(tota3s) AS tota3s, ;
2635: 				SUM(tota4s) AS tota4s, SUM(tota5s) AS tota5s, SUM(tota6s) AS tota6s, SUM(tota7s) AS tota7s, ;
2636: 				SUM(tota8s) AS tota8s, SUM(tota9s) AS tota9s, SUM(tota10s) AS tota10s ;
2637: 			FROM (loc_cItens) ;
2638: 			WHERE citem3 = loc_nItem3 AND !INLIST(ALLTRIM(cblocos), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
2639: 			GROUP BY citem3 INTO CURSOR cursor_4c_TmpTotBlo
2640: 
2641: 		SELECT (loc_cItens)
2642: 		GO TOP
2643: 		LOCATE FOR citem3 = loc_nItem3 AND ALLTRIM(cblocos) == "SUBTOTAL" AND citens = citem2
2644: 		IF FOUND()
2645: 			REPLACE totas WITH cursor_4c_TmpTotBlo.totas, tota1s WITH cursor_4c_TmpTotBlo.tota1s, ;
2646: 				tota2s WITH cursor_4c_TmpTotBlo.tota2s, tota3s WITH cursor_4c_TmpTotBlo.tota3s, ;
2647: 				tota4s WITH cursor_4c_TmpTotBlo.tota4s, tota5s WITH cursor_4c_TmpTotBlo.tota5s, ;
2648: 				tota6s WITH cursor_4c_TmpTotBlo.tota6s, tota7s WITH cursor_4c_TmpTotBlo.tota7s, ;
2649: 				tota8s WITH cursor_4c_TmpTotBlo.tota8s, tota9s WITH cursor_4c_TmpTotBlo.tota9s, ;
2650: 				tota10s WITH cursor_4c_TmpTotBlo.tota10s
2651: 		ENDIF
2652: 
2653: 		SELECT (loc_cItens)
2654: 		GO TOP
2655: 
2656: 		SELECT SUM(totas) AS totas, SUM(tota1s) AS tota1s, SUM(tota2s) AS tota2s, SUM(tota3s) AS tota3s, ;
2657: 				SUM(IIF(taxas, tota1s, 0)) AS tota1ts, SUM(IIF(taxas, tota2s, 0)) AS tota2ts, SUM(IIF(taxas, tota3s, 0)) AS tota3ts, ;
2658: 				SUM(tota4s) AS tota4s, SUM(tota5s) AS tota5s, SUM(tota6s) AS tota6s, SUM(tota7s) AS tota7s, ;
2659: 				SUM(tota8s) AS tota8s, SUM(tota9s) AS tota9s, SUM(tota10s) AS tota10s ;
2660: 			FROM (loc_cItens) ;
2661: 			WHERE !INLIST(ALLTRIM(cblocos), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
2662: 			INTO CURSOR cursor_4c_TmpTotBlo
2663: 
2664: 		IF THIS.this_oBusinessObject.this_nDivNotas = 2
2665: 			SELECT (loc_cItens)
2666: 			GO TOP
2667: 			LOCATE FOR ALLTRIM(cblocos) == "TOTALGERAL"
2668: 			IF FOUND() AND !EMPTY(cursor_4c_TmpTotBlo.totas)
2669: 				REPLACE totas WITH cursor_4c_TmpTotBlo.totas, tota1s WITH cursor_4c_TmpTotBlo.tota1s, ;
2670: 					tota2s WITH cursor_4c_TmpTotBlo.tota2s, tota3s WITH cursor_4c_TmpTotBlo.tota3s, ;
2671: 					tota4s WITH cursor_4c_TmpTotBlo.tota4s, tota5s WITH cursor_4c_TmpTotBlo.tota5s, ;
2672: 					tota6s WITH cursor_4c_TmpTotBlo.tota6s, tota7s WITH cursor_4c_TmpTotBlo.tota7s, ;
2673: 					tota8s WITH cursor_4c_TmpTotBlo.tota8s, tota9s WITH cursor_4c_TmpTotBlo.tota9s, ;
2674: 					tota10s WITH cursor_4c_TmpTotBlo.tota10s
2675: 
2676: 				THIS.txt_4c_Margem.Value = ((tota1s + tota2s) / tota5s) * 100
2677: 			ENDIF
2678: 		ELSE
2679: 			SELECT (loc_cItens)
2680: 			GO TOP
2681: 			LOCATE FOR ALLTRIM(cblocos) == "SUBTOTAIS"
2682: 			IF FOUND()
2683: 				REPLACE totas WITH cursor_4c_TmpTotBlo.totas, tota1s WITH cursor_4c_TmpTotBlo.tota1s, ;
2684: 					tota2s WITH cursor_4c_TmpTotBlo.tota2s, tota3s WITH cursor_4c_TmpTotBlo.tota3s, ;
2685: 					tota4s WITH cursor_4c_TmpTotBlo.tota4s, tota5s WITH cursor_4c_TmpTotBlo.tota5s, ;
2686: 					tota6s WITH cursor_4c_TmpTotBlo.tota6s, tota7s WITH cursor_4c_TmpTotBlo.tota7s, ;
2687: 					tota8s WITH cursor_4c_TmpTotBlo.tota8s, tota9s WITH cursor_4c_TmpTotBlo.tota9s, ;
2688: 					tota10s WITH cursor_4c_TmpTotBlo.tota10s
2689: 
2690: 				loc_nSubtot = tota1s
2691: 
2692: 				*-- Avanca para a linha de TAXA (fee da produtora), imediatamente
2693: 				*-- apos o SUBTOTAIS - mesma premissa posicional do legado
2694: 				SKIP

*-- Linhas 2726 a 2757:
2726: 			ENDIF
2727: 		ENDIF
2728: 
2729: 		SELECT (loc_cItens)
2730: 		= SEEK(loc_nItens, loc_cItens, "citens")
2731: 
2732: 		IF USED(loc_cParcelas)
2733: 			SELECT (loc_cParcelas)
2734: 			SCAN
2735: 				IF !EMPTY(percs)
2736: 					*-- (Real SRCOM custos internos) * percentual + (real fornecedor) * percentual
2737: 					REPLACE valos WITH ((EVALUATE(loc_cItens + ".tota7s") * percs) / 100) + ((EVALUATE(loc_cItens + ".tota8s") * percs) / 100)
2738: 				ENDIF
2739: 			ENDSCAN
2740: 		ENDIF
2741: 
2742: 		SELECT (loc_cItens)
2743: 		THIS.LockScreen = .F.
2744: 		THIS.grd_4c_Itens.Refresh()
2745: 	ENDPROC
2746: 
2747: 	*==========================================================================
2748: 	* ConfigurarCampoNovoGrupo - Say_NewGrp/get_NewGrp do legado: grupo a
2749: 	* usar quando o produto novo cadastrado pelo btnCadPro (Fase 6) ainda
2750: 	* nao existe em SigCdPro. Geometria/MaxLength/ToolTipText TRANSCRITOS
2751: 	* do dump.
2752: 	*==========================================================================
2753: 	PROTECTED PROCEDURE ConfigurarCampoNovoGrupo()
2754: 		LOCAL loc_lPodeEditar
2755: 		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2756: 
2757: 		THIS.AddObject("lbl_4c_NovoGrupo", "Label")

*-- Linhas 2823 a 2854:
2823: 					USE IN cursor_4c_BuscaGrupo
2824: 				ENDIF
2825: 
2826: 				loc_cSQL = "SELECT a.Cgrus, a.DGrus FROM SigCdGrp a" + ;
2827: 					" INNER JOIN SigCdRpo b ON (a.Cgrus = b.Cgrus OR a.Mercs = b.Mercs)" + ;
2828: 					" WHERE b.Dopps = " + EscaparSQL(THIS.this_cDopes)
2829: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
2830: 
2831: 				IF loc_nResultado <= 0 OR RECCOUNT("cursor_4c_BuscaGrupo") = 0
2832: 					IF USED("cursor_4c_BuscaGrupo")
2833: 						USE IN cursor_4c_BuscaGrupo
2834: 					ENDIF
2835: 					loc_nResultado = SQLEXEC(gnConnHandle, "SELECT a.Cgrus, a.DGrus FROM SigCdGrp a", "cursor_4c_BuscaGrupo")
2836: 				ENDIF
2837: 
2838: 				IF loc_nResultado > 0 AND USED("cursor_4c_BuscaGrupo")
2839: 					SELECT cursor_4c_BuscaGrupo
2840: 					GO TOP
2841: 					LOCATE FOR ALLTRIM(Cgrus) == loc_cValorDigitado
2842: 
2843: 					IF FOUND()
2844: 						THIS.txt_4c_NovoGrupo.Value = ALLTRIM(Cgrus)
2845: 					ELSE
2846: 						*-- Codigo digitado nao existe no universo restrito:
2847: 						*-- abre o picker (equivale ao fwBuscaInt do legado).
2848: 						*-- Regra #50: cancelando (ESC) o digitado PERMANECE,
2849: 						*-- nao se apaga o campo nem se exibe aviso.
2850: 						THIS.AbrirBuscaNovoGrupo()
2851: 						IF !EMPTY(THIS.this_cLookupCodigo)
2852: 							THIS.txt_4c_NovoGrupo.Value = THIS.this_cLookupCodigo
2853: 						ENDIF
2854: 					ENDIF

*-- Linhas 2959 a 2998:
2959: 
2960: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2961: 		IF USED(loc_cItens)
2962: 			SELECT (loc_cItens)
2963: 			GO TOP
2964: 			LOCATE FOR LIKE("*" + loc_cValor + "*", dpros)
2965: 			THIS.grd_4c_Itens.Refresh()
2966: 		ENDIF
2967: 	ENDPROC
2968: 
2969: 	PROCEDURE ProcuraDpro2sKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2970: 		LOCAL loc_cItens, loc_cValor
2971: 
2972: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2973: 			RETURN
2974: 		ENDIF
2975: 
2976: 		loc_cValor = ALLTRIM(THIS.edt_4c_ProcuraDpro2s.Value)
2977: 		IF EMPTY(loc_cValor)
2978: 			RETURN
2979: 		ENDIF
2980: 
2981: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2982: 		IF USED(loc_cItens)
2983: 			SELECT (loc_cItens)
2984: 			GO TOP
2985: 			LOCATE FOR LIKE("*" + loc_cValor + "*", dpro2s)
2986: 			THIS.grd_4c_Itens.Refresh()
2987: 		ENDIF
2988: 	ENDPROC
2989: 
2990: 	*==========================================================================
2991: 	* ProcuraDprosLostFocus / ProcuraDpro2sLostFocus - legado: "If !Empty
2992: 	* (this.Value) / thisform.btnprocura.SetFocus()". So move o foco (nao
2993: 	* dispara busca nenhuma) - a busca ja rodou no Enter/Tab acima.
2994: 	*==========================================================================
2995: 	PROCEDURE ProcuraDprosLostFocus()
2996: 		IF !EMPTY(THIS.txt_4c_ProcuraDpros.Value)
2997: 			THIS.cmd_4c_Procurar.SetFocus()
2998: 		ENDIF

*-- Linhas 3044 a 3062:
3044: 
3045: 				loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
3046: 				IF USED(loc_cItens)
3047: 					SELECT (loc_cItens)
3048: 					loc_nItem = citens
3049: 					IF !EOF()
3050: 						SKIP
3051: 					ENDIF
3052: 					IF loc_lPorDpros
3053: 						LOCATE FOR LIKE("*" + loc_cProcura + "*", dpros) AND citens <> loc_nItem
3054: 					ELSE
3055: 						LOCATE FOR LIKE("*" + loc_cProcura + "*", dpro2s) AND citens <> loc_nItem
3056: 					ENDIF
3057: 					THIS.grd_4c_Itens.Refresh()
3058: 				ENDIF
3059: 			ENDIF
3060: 		ENDIF
3061: 	ENDPROC
3062: 

*-- Linhas 3113 a 3140:
3113: 				IF USED("cursor_4c_TmpFotoZom")
3114: 					USE IN cursor_4c_TmpFotoZom
3115: 				ENDIF
3116: 				loc_cSQL = "SELECT a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros)
3117: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFotoZom")
3118: 
3119: 				IF loc_nResultado < 1 OR !USED("cursor_4c_TmpFotoZom") OR RECCOUNT("cursor_4c_TmpFotoZom") = 0
3120: 					loc_lProsseguir = .F.
3121: 				ENDIF
3122: 			ENDIF
3123: 
3124: 			IF loc_lProsseguir
3125: 				SELECT cursor_4c_TmpFotoZom
3126: 				GO TOP
3127: 				loc_cFigJpgs = TratarNulo(cursor_4c_TmpFotoZom.FigJpgs, "")
3128: 				USE IN cursor_4c_TmpFotoZom
3129: 
3130: 				IF !EMPTY(loc_cFigJpgs)
3131: 					loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
3132: 					loc_cFoto = STRCONV( ;
3133: 						STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
3134: 							"data:image/png;base64,", ""), ;
3135: 							"data:image/jpeg;base64,", ""), ;
3136: 							"data:image/jpg;base64,", ""), 14)
3137: 					STRTOFILE(loc_cFoto, loc_cArqTemp)
3138: 
3139: 					IF FILE(loc_cArqTemp)
3140: 						loc_cCaption = "Produto : " + loc_cCpros + " - " + loc_cDpros

*-- Linhas 3169 a 3195:
3169: 
3170: 	*==========================================================================
3171: 	* ConfigurarDescritivoRodape - getDescritivo do legado: memo de rodape,
3172: 	* largura TOTAL, abaixo das duas grades. Por padrao (ControlSource =
3173: 	* TprMvCab.Obses, dado de cabecalho que esta fora do escopo deste BO)
3174: 	* o Init legado deixa INVISIVEL fora do modo Criacao - unico estado
3175: 	* alcancavel nesta fase, porque this_nDigItens so e preenchido em
3176: 	* fase posterior (SigCdOpe - ver cabecalho do BO). AtualizarModoCriacao
3177: 	* fica pronto para quando DigItens chegar: troca o ControlSource para
3178: 	* o Dpro2s do item corrente e mostra o campo (regra transcrita do
3179: 	* Init: "If Inlist(DigItens,6,7) ... thisform.getDescritivo.
3180: 	* ControlSource = [crSigMvOrc.Dpro2s] Else ... .Visible = .f.").
3181: 	*==========================================================================
3182: 	PROTECTED PROCEDURE ConfigurarDescritivoRodape()
3183: 		THIS.AddObject("edt_4c_DescritivoRodape", "EditBox")
3184: 		WITH THIS.edt_4c_DescritivoRodape
3185: 			.Top           = 481
3186: 			.Left          = 5
3187: 			.Width         = 989
3188: 			.Height        = 115
3189: 			.FontSize      = 8
3190: 			.SpecialEffect = 1
3191: 			.ForeColor     = RGB(0, 0, 0)
3192: 			.DisabledBackColor = RGB(255, 255, 255)
3193: 			.BorderColor   = RGB(100, 100, 100)
3194: 			.Value         = ""
3195: 			.Enabled       = .F.

*-- Linhas 3288 a 3310:
3288: 
3289: 		IF loc_lModoCriacao
3290: 			*-- Criacao: o descritivo do rodape entra ligado ao item corrente
3291: 			*-- (legado: getDescritivo.ControlSource = [crSigMvOrc.Dpro2s]) e
3292: 			*-- a linha de busca sai inteira.
3293: 			THIS.edt_4c_DescritivoRodape.Visible = .T.
3294: 			IF USED(loc_cItens)
3295: 				THIS.edt_4c_DescritivoRodape.ControlSource = loc_cItens + ".dpro2s"
3296: 			ENDIF
3297: 
3298: 			THIS.txt_4c_ProcuraDpros.Visible  = .F.
3299: 			THIS.edt_4c_ProcuraDpro2s.Visible = .F.
3300: 			THIS.cmd_4c_Procurar.Visible      = .F.
3301: 		ELSE
3302: 			THIS.edt_4c_DescritivoRodape.Visible = .F.
3303: 
3304: 			THIS.txt_4c_ProcuraDpros.Visible  = .T.
3305: 			THIS.edt_4c_ProcuraDpro2s.Visible = .T.
3306: 			THIS.cmd_4c_Procurar.Visible      = .T.
3307: 
3308: 			*-- Geometria do ramo P&G (ver DESVIO DOCUMENTADO no cabecalho):
3309: 			*-- sem a grade de parcelas, a grade de itens cresce ate a linha
3310: 			*-- de busca, que desce para o rodape.

*-- Linhas 3331 a 3369:
3331: 	*==========================================================================
3332: 	* PosicionarParcelasDoItem - Reproduz o fecho do Init legado:
3333: 	*
3334: 	*   Select crSigMvOrp / Set Order to / Set Order to CItens
3335: 	*   Set Key to crSigMvOrc.CItens / Go Top
3336: 	*
3337: 	* O SET KEY e o que faz a grade de parcelas mostrar SO as parcelas do
3338: 	* item corrente (mestre-detalhe por Citens) - sem ele a grade exibiria
3339: 	* as parcelas de TODOS os itens. Trocar ordem/chave de um alias NAO
3340: 	* repinta a grade ligada a ele, por isso o Refresh fica no funil
3341: 	* CarregarDados e no handler de troca de linha (regra #21).
3342: 	*==========================================================================
3343: 	PROTECTED PROCEDURE PosicionarParcelasDoItem()
3344: 		LOCAL loc_cItens, loc_cParcelas, loc_nItem
3345: 		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
3346: 		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
3347: 
3348: 		IF USED(loc_cParcelas)
3349: 			loc_nItem = 0
3350: 			IF USED(loc_cItens) AND !EOF(loc_cItens)
3351: 				loc_nItem = EVALUATE(loc_cItens + ".citens")
3352: 			ENDIF
3353: 
3354: 			SELECT (loc_cParcelas)
3355: 			SET ORDER TO
3356: 			SET ORDER TO TAG citens
3357: 			SET KEY TO loc_nItem
3358: 			GO TOP
3359: 		ENDIF
3360: 	ENDPROC
3361: 
3362: 	*==========================================================================
3363: 	* CarregarDados - FUNIL de carga da tela. PUBLIC de proposito: alem de
3364: 	* ser chamado pelo InicializarForm, o harness de teste
3365: 	* (TesteAutomatico.prg) o invoca de FORA da classe - com PROTECTED a
3366: 	* chamada estoura "Property CARREGARDADOS is not found", porque
3367: 	* PEMSTATUS(...,5) devolve .T. tambem para metodo protegido (regra #3).
3368: 	*
3369: 	* Ordem (a mesma do Init legado): garantir os cursores -> aplicar o

*-- Linhas 3399 a 3429:
3399: 			ENDIF
3400: 
3401: 			*-- Layout (quem aparece) ANTES da carga: AtualizarModoCriacao
3402: 			*-- liga o ControlSource de edt_4c_DescritivoRodape ao cursor e
3403: 			*-- fecha chamando HabilitarCampos/AjustarBotoesPorModo.
3404: 			THIS.AtualizarModoCriacao()
3405: 
3406: 			*-- Legado: AddCursor('SigMvOrc',...)/AddCursor('SigMvOrp',...) no
3407: 			*-- Init. Vincular as grades, ler do banco, posicionar os aliases
3408: 			*-- e repintar ficam todos em CarregarLista (funil de recarga),
3409: 			*-- para a primeira carga e as recargas seguintes seguirem
3410: 			*-- exatamente o mesmo caminho.
3411: 			loc_lSucesso = THIS.CarregarLista()
3412: 
3413: 			*-- Valores do cabecalho (percentuais) para a tela - no legado
3414: 			*-- vinham sozinhos pelo ControlSource = TprMvCab.<coluna>
3415: 			THIS.BOParaForm()
3416: 		CATCH TO loc_oErro
3417: 			MsgErro(loc_oErro.Message + CHR(13) + ;
3418: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3419: 				"Procedure: " + loc_oErro.Procedure, ;
3420: 				"Erro em Formsigoporc.CarregarDados")
3421: 		ENDTRY
3422: 
3423: 		RETURN loc_lSucesso
3424: 	ENDPROC
3425: 
3426: 	*==========================================================================
3427: 	* GradeItensAfterRowColChange - Troca de linha na grade de itens: refaz
3428: 	* o filtro da grade de parcelas (mestre-detalhe), espelha a descricao
3429: 	* do item nos campos de busca, reseta o modo de busca e atualiza a

*-- Linhas 3562 a 3584:
3562: 			IF USED("cursor_4c_TmpFotoItem")
3563: 				USE IN cursor_4c_TmpFotoItem
3564: 			ENDIF
3565: 			loc_cSQL = "SELECT a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros)
3566: 			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFotoItem")
3567: 
3568: 			IF loc_nResultado >= 1 AND USED("cursor_4c_TmpFotoItem") AND RECCOUNT("cursor_4c_TmpFotoItem") > 0
3569: 				SELECT cursor_4c_TmpFotoItem
3570: 				GO TOP
3571: 				loc_cFigJpgs = TratarNulo(cursor_4c_TmpFotoItem.FigJpgs, "")
3572: 				USE IN cursor_4c_TmpFotoItem
3573: 
3574: 				IF !EMPTY(loc_cFigJpgs)
3575: 					loc_cArqTemp = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + "SigOpPro.jpg"
3576: 					loc_cFoto = STRCONV( ;
3577: 						STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
3578: 							"data:image/png;base64,", ""), ;
3579: 							"data:image/jpeg;base64,", ""), ;
3580: 							"data:image/jpg;base64,", ""), 14)
3581: 
3582: 					IF STRTOFILE(loc_cFoto, loc_cArqTemp) > 0
3583: 						THIS.img_4c_Produto.Picture = loc_cArqTemp
3584: 						THIS.img_4c_Produto.Visible = .T.

*-- Linhas 3669 a 3715:
3669: 	*     default do cabecalho quando LocalEmp.DivNotas = 2 (P&G).
3670: 	* A persistencia em SQL (BO.Inserir) acontece so no fechamento/
3671: 	* confirmacao do dialogo (fase propria) - igual ao legado, que so
3672: 	* grava a grade inteira ao sair ("Zap In crTpmMvItn ... Insert into
3673: 	* crTpmMvItn from Memvar").
3674: 	*==========================================================================
3675: 	PROCEDURE BtnIncluirLinhaClick()
3676: 		LOCAL loc_cCursor, loc_nItem, loc_nItem2, loc_nItem3, loc_nItAgr, loc_cBloco
3677: 
3678: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3679: 			RETURN
3680: 		ENDIF
3681: 
3682: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
3683: 		IF !USED(loc_cCursor)
3684: 			RETURN
3685: 		ENDIF
3686: 
3687: 		SELECT (loc_cCursor)
3688: 		IF EOF() OR INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
3689: 			RETURN
3690: 		ENDIF
3691: 
3692: 		THIS.LockScreen = .T.
3693: 
3694: 		loc_nItem  = citens
3695: 		loc_nItem2 = citem2
3696: 		loc_nItem3 = citem3
3697: 		loc_nItAgr = citagrs
3698: 		loc_cBloco = cblocos
3699: 
3700: 		*-- Legado: "Select crSigMvOrc / Set Order To" ANTES do Scan - sem
3701: 		*-- remover a ordem controladora, atualizar a propria chave (Citens)
3702: 		*-- durante o Scan faria o VFP reprocessar/pular registros.
3703: 		SET ORDER TO
3704: 		SCAN FOR citens > loc_nItem
3705: 			REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 + 1), ;
3706: 				citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 + 1), ;
3707: 				citens WITH citens + 1, ;
3708: 				citagrs WITH IIF(EMPTY(citagrs) OR citagrs = loc_nItAgr, citagrs, citagrs + 1)
3709: 		ENDSCAN
3710: 
3711: 		APPEND BLANK
3712: 		REPLACE citens WITH loc_nItem + 1, citem2 WITH loc_nItem2, citem3 WITH loc_nItem3, ;
3713: 			cblocos WITH loc_cBloco, taxas WITH .T.
3714: 
3715: 		SET ORDER TO TAG citens

*-- Linhas 3744 a 3812:
3744: 			RETURN
3745: 		ENDIF
3746: 
3747: 		SELECT (loc_cCursor)
3748: 		IF EOF() OR INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
3749: 			RETURN
3750: 		ENDIF
3751: 
3752: 		THIS.LockScreen = .T.
3753: 
3754: 		IF citens = citem2
3755: 			*-- Cabecalho de BLOCO ou SUB-BLOCO
3756: 			loc_nItem  = citens
3757: 			loc_nItem2 = citem2
3758: 			loc_nItem3 = citem3
3759: 
3760: 			IF loc_nItem = loc_nItem2 AND loc_nItem = loc_nItem3
3761: 				*-- BLOCO: so apaga se nao houver NENHUM item real dentro dele
3762: 				SELECT COUNT(1) AS nitem FROM (loc_cCursor) ;
3763: 					WHERE citem3 = loc_nItem3 ;
3764: 					AND !INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
3765: 					AND !EMPTY(cpros) ;
3766: 					GROUP BY citem3 INTO CURSOR cursor_4c_TmpBloco
3767: 
3768: 				IF !USED("cursor_4c_TmpBloco") OR cursor_4c_TmpBloco.nitem = 0
3769: 					SELECT COUNT(1) AS nitem FROM (loc_cCursor) WHERE citem3 = loc_nItem3 INTO CURSOR cursor_4c_TmpBloco
3770: 					loc_nTotalItens = cursor_4c_TmpBloco.nitem
3771: 
3772: 					SELECT (loc_cCursor)
3773: 					DELETE FOR citem3 = loc_nItem3 ;
3774: 						AND !INLIST(ALLTRIM(NVL(cblocos, "")), "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
3775: 
3776: 					SET ORDER TO
3777: 					SCAN FOR citens > loc_nItem
3778: 						REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 - loc_nTotalItens), ;
3779: 							citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 - loc_nTotalItens), ;
3780: 							citens WITH citens - loc_nTotalItens, ;
3781: 							citagrs WITH citagrs - loc_nTotalItens
3782: 					ENDSCAN
3783: 				ENDIF
3784: 			ELSE
3785: 				*-- SUB-BLOCO: so apaga se nao houver NENHUM item real dentro dele
3786: 				SELECT COUNT(1) AS nitem FROM (loc_cCursor) ;
3787: 					WHERE citem2 = loc_nItem2 ;
3788: 					AND !INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
3789: 					AND !EMPTY(cpros) ;
3790: 					GROUP BY citem2 INTO CURSOR cursor_4c_TmpBloco
3791: 
3792: 				IF !USED("cursor_4c_TmpBloco") OR cursor_4c_TmpBloco.nitem = 0
3793: 					SELECT COUNT(1) AS nitem FROM (loc_cCursor) WHERE citem2 = loc_nItem2 INTO CURSOR cursor_4c_TmpBloco
3794: 					loc_nTotalItens = cursor_4c_TmpBloco.nitem
3795: 
3796: 					SELECT (loc_cCursor)
3797: 					DELETE FOR citem2 = loc_nItem2 ;
3798: 						AND !INLIST(ALLTRIM(NVL(cblocos, "")), "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
3799: 
3800: 					SET ORDER TO
3801: 					SCAN FOR citens > loc_nItem
3802: 						REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 - loc_nTotalItens), ;
3803: 							citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 - loc_nTotalItens), ;
3804: 							citens WITH citens - loc_nTotalItens, ;
3805: 							citagrs WITH citagrs - loc_nTotalItens
3806: 					ENDSCAN
3807: 				ENDIF
3808: 			ENDIF
3809: 
3810: 			IF USED("cursor_4c_TmpBloco")
3811: 				USE IN cursor_4c_TmpBloco
3812: 			ENDIF

*-- Linhas 3825 a 3843:
3825: 				RETURN
3826: 			ENDIF
3827: 
3828: 			DELETE FOR citens = loc_nItem
3829: 
3830: 			SET ORDER TO
3831: 			SCAN FOR citens > loc_nItem
3832: 				REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 - 1), ;
3833: 					citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 - 1), ;
3834: 					citens WITH citens - 1, ;
3835: 					citagrs WITH IIF(EMPTY(citagrs) OR citagrs = loc_nItem, 0, citagrs - 1)
3836: 			ENDSCAN
3837: 
3838: 			SET ORDER TO TAG citens
3839: 			= SEEK(loc_nItem)
3840: 		ENDIF
3841: 
3842: 		THIS.grd_4c_Itens.Refresh()
3843: 		THIS.LockScreen = .F.

*-- Linhas 4068 a 4124:
4068: 		ENDIF
4069: 
4070: 		*-- TELA -> BO antes de qualquer validacao/gravacao: no legado os 5
4071: 		*-- percentuais do topo chegavam ao cabecalho sozinhos (ControlSource
4072: 		*-- = TprMvCab.<coluna>); aqui a transferencia e manual e passa por
4073: 		*-- FormParaBO (ver cabecalho dele).
4074: 		IF !THIS.FormParaBO()
4075: 			RETURN
4076: 		ENDIF
4077: 
4078: 		loc_lContinuar = .T.
4079: 
4080: 		TRY
4081: 			*-- Legado: as validacoes abaixo SO correm fora do modo P&G
4082: 			*-- (LocalEmp.DivNotas <> 2)
4083: 			IF THIS.this_oBusinessObject.this_nDivNotas <> 2
4084: 				SELECT (loc_cItens)
4085: 				SET ORDER TO TAG citens
4086: 				GO TOP
4087: 				LOCATE FOR perc2s + perc3s > 100
4088: 				IF FOUND()
4089: 					MsgAviso("Existe item com percentual de NF maior que 100%.", "Aviso")
4090: 					THIS.grd_4c_Itens.Column25.SetFocus()
4091: 					loc_lContinuar = .F.
4092: 				ENDIF
4093: 
4094: 				IF loc_lContinuar
4095: 					SELECT (loc_cItens)
4096: 					GO TOP
4097: 					LOCATE FOR perc4s + perc5s + perc6s > 100
4098: 					IF FOUND()
4099: 						MsgAviso("Existe item com percentual de incentivos maior que 100%.", "Aviso")
4100: 						THIS.grd_4c_Itens.Column22.SetFocus()
4101: 						loc_lContinuar = .F.
4102: 					ENDIF
4103: 				ENDIF
4104: 
4105: 				IF loc_lContinuar
4106: 					*-- Previsao de pagamento incompleta - varre TODAS as
4107: 					*-- parcelas (nao so as do item corrente): desliga o SET
4108: 					*-- KEY temporariamente e restaura no final.
4109: 					SELECT (loc_cParcelas)
4110: 					SET ORDER TO TAG citens
4111: 					SET KEY TO
4112: 					GO TOP
4113: 					SCAN
4114: 						IF !(EMPTY(ifors) AND EMPTY(percs) AND EMPTY(datas)) AND ;
4115: 								(EMPTY(ifors) OR EMPTY(percs) OR EMPTY(datas))
4116: 							loc_nItem  = citens
4117: 							loc_cDpros = ""
4118: 							IF SEEK(loc_nItem, loc_cItens, "citens")
4119: 								loc_cDpros = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".dpros"), ""))
4120: 							ENDIF
4121: 							MsgAviso("Existe previs" + CHR(227) + "o de pagamento no item '" + ;
4122: 								loc_cDpros + "' incompleta.", "Aviso")
4123: 							loc_lContinuar = .F.
4124: 							EXIT

*-- Linhas 4131 a 4184:
4131: 					IF USED("cursor_4c_TmpTotPrev")
4132: 						USE IN cursor_4c_TmpTotPrev
4133: 					ENDIF
4134: 					SELECT a.citens, a.dpros, (a.tota7s + a.tota8s) AS totreal, ;
4135: 							SUM(NVL(b.valos, 0)) AS totprev ;
4136: 						FROM (loc_cItens) a LEFT JOIN (loc_cParcelas) b ON a.citens = b.citens ;
4137: 						WHERE !EMPTY(a.cpros) ;
4138: 						GROUP BY a.citens, a.dpros, 3 ;
4139: 						HAVING totreal > 0 AND (ISNULL(totprev) OR totprev <> totreal) ;
4140: 						INTO CURSOR cursor_4c_TmpTotPrev
4141: 
4142: 					IF USED("cursor_4c_TmpTotPrev") AND RECCOUNT("cursor_4c_TmpTotPrev") > 0
4143: 						MsgAviso("Existe previs" + CHR(227) + "o de pagamento no item '" + ;
4144: 							ALLTRIM(cursor_4c_TmpTotPrev.dpros) + "' " + CHR(13) + ;
4145: 							"n" + CHR(227) + "o informada ou com valor diferente do Real Custos Internos + Real Fornecedor", ;
4146: 							"Aviso")
4147: 						THIS.grd_4c_Itens.Column1.SetFocus()
4148: 						loc_lContinuar = .F.
4149: 					ENDIF
4150: 
4151: 					IF USED("cursor_4c_TmpTotPrev")
4152: 						USE IN cursor_4c_TmpTotPrev
4153: 					ENDIF
4154: 				ENDIF
4155: 			ENDIF
4156: 
4157: 			IF loc_lContinuar
4158: 				*-- Legado: "Delete For Empty(Dpros) And Citens<>Citem2 And cBlocos<>[BRANCO]"
4159: 				SELECT (loc_cItens)
4160: 				DELETE FOR EMPTY(dpros) AND citens <> citem2 AND ALLTRIM(cblocos) <> "BRANCO"
4161: 
4162: 				*-- Legado: "Delete For Empty(Ifors) And Empty(Percs) And Empty(Datas)"
4163: 				SELECT (loc_cParcelas)
4164: 				SET KEY TO
4165: 				DELETE FOR EMPTY(ifors) AND EMPTY(percs) AND EMPTY(datas)
4166: 
4167: 				*-- Persiste TODOS os itens remanescentes (ver nota da
4168: 				*-- diferenca arquitetural no cabecalho do metodo)
4169: 				SELECT (loc_cItens)
4170: 				SET ORDER TO TAG citens
4171: 				GO TOP
4172: 				SCAN
4173: 					THIS.this_oBusinessObject.CarregarDoCursor(loc_cItens)
4174: 					THIS.this_oBusinessObject.this_cEmps  = THIS.this_cEmps
4175: 					THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
4176: 					THIS.this_oBusinessObject.this_nNumes = THIS.this_nNumes
4177: 
4178: 					IF EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCidchaves, "")))
4179: 						loc_lItemOk = THIS.this_oBusinessObject.Inserir()
4180: 					ELSE
4181: 						loc_lItemOk = THIS.this_oBusinessObject.Atualizar()
4182: 					ENDIF
4183: 
4184: 					IF !loc_lItemOk

*-- Linhas 4197 a 4270:
4197: 				*-- de SigMvOrc; parcela nao tem propriedades proprias (regra
4198: 				*-- ja documentada no cabecalho de BtnIncluirParcelaClick: a
4199: 				*-- persistencia so acontece aqui, na confirmacao do dialogo)
4200: 				SELECT (loc_cParcelas)
4201: 				SET ORDER TO TAG citens
4202: 				GO TOP
4203: 				SCAN
4204: 					IF EMPTY(ALLTRIM(NVL(cidchaves, "")))
4205: 						loc_cChaveNova = LEFT(fUniqueIds(), 20)
4206: 
4207: 						loc_cSQL = "INSERT INTO SigMvOrp ("
4208: 						loc_cSQL = loc_cSQL + "cidchaves, citens, datas, dopes, empdopnums, emps,"
4209: 						loc_cSQL = loc_cSQL + " numes, percs, valos, vlbaixas, borderos, ifors, valcreds"
4210: 						loc_cSQL = loc_cSQL + ") VALUES ("
4211: 						loc_cSQL = loc_cSQL + EscaparSQL(loc_cChaveNova) + ","
4212: 						loc_cSQL = loc_cSQL + FormatarNumeroSQL(citens, 0) + ","
4213: 						loc_cSQL = loc_cSQL + FormatarDataSQL(datas) + ","
4214: 						loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 29)) + ","
4215: 						loc_cSQL = loc_cSQL + EscaparSQL(PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)) + ","
4216: 						loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEmps) + ","
4217: 						loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
4218: 						loc_cSQL = loc_cSQL + FormatarNumeroSQL(percs, 2) + ","
4219: 						loc_cSQL = loc_cSQL + FormatarNumeroSQL(valos, 2) + ","
4220: 						loc_cSQL = loc_cSQL + FormatarNumeroSQL(vlbaixas, 2) + ","
4221: 						loc_cSQL = loc_cSQL + FormatarNumeroSQL(NVL(borderos, 0), 0) + ","
4222: 						loc_cSQL = loc_cSQL + EscaparSQL(LEFT(ifors, 10)) + ","
4223: 						loc_cSQL = loc_cSQL + FormatarNumeroSQL(NVL(valcreds, 0), 2) + ")"
4224: 
4225: 						IF USED("cursor_4c_InsertParc")
4226: 							USE IN cursor_4c_InsertParc
4227: 						ENDIF
4228: 						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsertParc")
4229: 						IF USED("cursor_4c_InsertParc")
4230: 							USE IN cursor_4c_InsertParc
4231: 						ENDIF
4232: 
4233: 						IF loc_nResultado < 0
4234: 							MsgErro("Erro ao inserir previs" + CHR(227) + "o de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
4235: 							loc_lContinuar = .F.
4236: 							EXIT
4237: 						ENDIF
4238: 
4239: 						REPLACE cidchaves WITH loc_cChaveNova
4240: 					ELSE
4241: 						loc_cSQL = "UPDATE SigMvOrp SET"
4242: 						loc_cSQL = loc_cSQL + " citens = " + FormatarNumeroSQL(citens, 0) + ","
4243: 						loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(datas) + ","
4244: 						loc_cSQL = loc_cSQL + " percs = " + FormatarNumeroSQL(percs, 2) + ","
4245: 						loc_cSQL = loc_cSQL + " valos = " + FormatarNumeroSQL(valos, 2) + ","
4246: 						loc_cSQL = loc_cSQL + " vlbaixas = " + FormatarNumeroSQL(vlbaixas, 2) + ","
4247: 						loc_cSQL = loc_cSQL + " ifors = " + EscaparSQL(LEFT(ifors, 10))
4248: 						loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(cidchaves, 20))
4249: 
4250: 						IF USED("cursor_4c_UpdateParc")
4251: 							USE IN cursor_4c_UpdateParc
4252: 						ENDIF
4253: 						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdateParc")
4254: 						IF USED("cursor_4c_UpdateParc")
4255: 							USE IN cursor_4c_UpdateParc
4256: 						ENDIF
4257: 
4258: 						IF loc_nResultado < 0
4259: 							MsgErro("Erro ao atualizar previs" + CHR(227) + "o de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
4260: 							loc_lContinuar = .F.
4261: 							EXIT
4262: 						ENDIF
4263: 					ENDIF
4264: 				ENDSCAN
4265: 			ENDIF
4266: 		CATCH TO loc_oErro
4267: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4268: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4269: 				"Procedure: " + loc_oErro.Procedure, ;
4270: 				"Erro em Formsigoporc.BtnSalvarClick")

*-- Linhas 4323 a 4415:
4323: 			RETURN
4324: 		ENDIF
4325: 
4326: 		SELECT (loc_cItens)
4327: 		IF INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
4328: 			RETURN
4329: 		ENDIF
4330: 
4331: 		THIS.LockScreen = .T.
4332: 
4333: 		TRY
4334: 			SET ORDER TO TAG citens
4335: 
4336: 			loc_nItem  = IIF(EMPTY(citens), 0, citens)
4337: 			loc_nItem2 = IIF(EMPTY(citem2), 0, citem2)
4338: 			loc_nItem3 = IIF(EMPTY(citem3), 0, citem3)
4339: 			loc_cBloco = cblocos
4340: 
4341: 			SELECT MAX(citens) AS citens FROM (loc_cItens) WHERE citem3 = loc_nItem3 INTO CURSOR cursor_4c_TmpSub
4342: 			IF USED("cursor_4c_TmpSub") AND !EOF("cursor_4c_TmpSub") AND !EMPTY(cursor_4c_TmpSub.citens)
4343: 				IF SEEK(cursor_4c_TmpSub.citens, loc_cItens, "citens")
4344: 					loc_nItem  = EVALUATE(loc_cItens + ".citens")
4345: 					loc_nItem2 = EVALUATE(loc_cItens + ".citem2")
4346: 					loc_nItem3 = EVALUATE(loc_cItens + ".citem3")
4347: 					loc_cBloco = ""
4348: 				ENDIF
4349: 			ENDIF
4350: 			IF USED("cursor_4c_TmpSub")
4351: 				USE IN cursor_4c_TmpSub
4352: 			ENDIF
4353: 
4354: 			SELECT (loc_cItens)
4355: 			SET ORDER TO
4356: 			SCAN FOR citens > loc_nItem
4357: 				loc_nItAnt = citens
4358: 				REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 + 4), ;
4359: 					citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 + 4), ;
4360: 					citens WITH citens + 4
4361: 
4362: 				SELECT (loc_cParcelas)
4363: 				SET ORDER TO
4364: 				GO TOP
4365: 				REPLACE ALL citens WITH (loc_nItAnt + 4) * (-1) FOR citens = loc_nItAnt
4366: 				SELECT (loc_cItens)
4367: 			ENDSCAN
4368: 
4369: 			SELECT (loc_cParcelas)
4370: 			GO TOP
4371: 			REPLACE ALL citens WITH ABS(citens)
4372: 
4373: 			INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos) ;
4374: 				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, loc_nItem + 1, loc_nItem + 1, loc_nItem + 1, loc_cBloco)
4375: 
4376: 			INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros, dpro2s) ;
4377: 				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, loc_nItem + 4, loc_nItem + 4, loc_nItem + 1, "SUBTOTAL", "SUBTOTAL", loc_cBloco)
4378: 
4379: 			IF THIS.this_oBusinessObject.this_nDivNotas = 2
4380: 				SELECT (loc_cItens)
4381: 				GO TOP
4382: 				LOCATE FOR ALLTRIM(cblocos) == "TOTALGERAL"
4383: 				IF !FOUND()
4384: 					SELECT MAX(citens) AS citens FROM (loc_cItens) INTO CURSOR cursor_4c_TmpSub
4385: 					IF USED("cursor_4c_TmpSub") AND !EOF("cursor_4c_TmpSub")
4386: 						INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros) ;
4387: 							VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
4388: 								cursor_4c_TmpSub.citens + 1, cursor_4c_TmpSub.citens + 1, cursor_4c_TmpSub.citens, "BRANCO", "")
4389: 
4390: 						INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros) ;
4391: 							VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
4392: 								cursor_4c_TmpSub.citens + 2, cursor_4c_TmpSub.citens + 1, cursor_4c_TmpSub.citens, "TOTALGERAL", "TOTAL GERAL")
4393: 					ENDIF
4394: 					IF USED("cursor_4c_TmpSub")
4395: 						USE IN cursor_4c_TmpSub
4396: 					ENDIF
4397: 				ENDIF
4398: 			ENDIF
4399: 
4400: 			SELECT (loc_cItens)
4401: 			SET ORDER TO TAG citens
4402: 			= SEEK(loc_nItem + 1)
4403: 
4404: 			THIS.PosicionarParcelasDoItem()
4405: 		CATCH TO loc_oErro
4406: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4407: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4408: 				"Procedure: " + loc_oErro.Procedure, ;
4409: 				"Erro em Formsigoporc.BtnInserirBlocoClick")
4410: 		ENDTRY
4411: 
4412: 		THIS.grd_4c_Itens.Refresh()
4413: 		THIS.grd_4c_Parcelas.Refresh()
4414: 		THIS.LockScreen = .F.
4415: 		THIS.grd_4c_Itens.Column1.SetFocus()

*-- Linhas 4438 a 4532:
4438: 			RETURN
4439: 		ENDIF
4440: 
4441: 		SELECT (loc_cItens)
4442: 		IF INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
4443: 			RETURN
4444: 		ENDIF
4445: 
4446: 		THIS.LockScreen = .T.
4447: 
4448: 		TRY
4449: 			SET ORDER TO TAG citens
4450: 
4451: 			loc_nItem  = IIF(EMPTY(citens), 0, citens)
4452: 			loc_nItem2 = IIF(EMPTY(citem2), 0, citem2)
4453: 			loc_nItem3 = IIF(EMPTY(citem3), 0, citem3)
4454: 			loc_cBloco = cblocos
4455: 
4456: 			SELECT MAX(citens) AS citens FROM (loc_cItens) ;
4457: 				WHERE citem3 = loc_nItem3 AND citem2 = loc_nItem2 AND ALLTRIM(cblocos) == "SUBTOTAL" ;
4458: 				INTO CURSOR cursor_4c_TmpSub
4459: 			IF USED("cursor_4c_TmpSub") AND !EOF("cursor_4c_TmpSub") AND !EMPTY(cursor_4c_TmpSub.citens)
4460: 				IF SEEK(cursor_4c_TmpSub.citens, loc_cItens, "citens")
4461: 					loc_nItem  = EVALUATE(loc_cItens + ".citens")
4462: 					loc_nItem2 = EVALUATE(loc_cItens + ".citem2")
4463: 					loc_nItem3 = EVALUATE(loc_cItens + ".citem3")
4464: 					loc_cBloco = ""
4465: 				ENDIF
4466: 			ENDIF
4467: 			IF USED("cursor_4c_TmpSub")
4468: 				USE IN cursor_4c_TmpSub
4469: 			ENDIF
4470: 
4471: 			SELECT (loc_cItens)
4472: 			SET ORDER TO
4473: 			SCAN FOR citens > loc_nItem
4474: 				loc_nItAnt = citens
4475: 				REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 + 2), ;
4476: 					citem2 WITH citem2 + 2, ;
4477: 					citens WITH citens + 2
4478: 
4479: 				SELECT (loc_cParcelas)
4480: 				SET ORDER TO
4481: 				GO TOP
4482: 				REPLACE ALL citens WITH (loc_nItAnt + 2) * (-1) FOR citens = loc_nItAnt
4483: 				SELECT (loc_cItens)
4484: 			ENDSCAN
4485: 
4486: 			SELECT (loc_cParcelas)
4487: 			GO TOP
4488: 			REPLACE ALL citens WITH ABS(citens)
4489: 
4490: 			INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos) ;
4491: 				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, loc_nItem + 1, loc_nItem + 1, loc_nItem3, loc_cBloco)
4492: 
4493: 			INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros) ;
4494: 				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, loc_nItem + 2, loc_nItem + 1, loc_nItem3, "SUBTOTAL", "SUBTOTAL")
4495: 
4496: 			IF THIS.this_oBusinessObject.this_nDivNotas = 2
4497: 				SELECT (loc_cItens)
4498: 				GO TOP
4499: 				LOCATE FOR ALLTRIM(cblocos) == "TOTALGERAL"
4500: 				IF !FOUND()
4501: 					SELECT MAX(citens) AS citens FROM (loc_cItens) INTO CURSOR cursor_4c_TmpSub
4502: 					IF USED("cursor_4c_TmpSub") AND !EOF("cursor_4c_TmpSub")
4503: 						INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros) ;
4504: 							VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
4505: 								cursor_4c_TmpSub.citens + 1, cursor_4c_TmpSub.citens, cursor_4c_TmpSub.citens, "BRANCO", "")
4506: 
4507: 						INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros) ;
4508: 							VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
4509: 								cursor_4c_TmpSub.citens + 2, cursor_4c_TmpSub.citens, cursor_4c_TmpSub.citens, "TOTALGERAL", "TOTAL GERAL")
4510: 					ENDIF
4511: 					IF USED("cursor_4c_TmpSub")
4512: 						USE IN cursor_4c_TmpSub
4513: 					ENDIF
4514: 				ENDIF
4515: 			ENDIF
4516: 
4517: 			SELECT (loc_cItens)
4518: 			SET ORDER TO TAG citens
4519: 			= SEEK(loc_nItem + 1)
4520: 
4521: 			THIS.PosicionarParcelasDoItem()
4522: 		CATCH TO loc_oErro
4523: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4524: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4525: 				"Procedure: " + loc_oErro.Procedure, ;
4526: 				"Erro em Formsigoporc.BtnInserirSubBlocoClick")
4527: 		ENDTRY
4528: 
4529: 		THIS.grd_4c_Itens.Refresh()
4530: 		THIS.grd_4c_Parcelas.Refresh()
4531: 		THIS.LockScreen = .F.
4532: 		THIS.grd_4c_Itens.Column1.SetFocus()

*-- Linhas 4627 a 4661:
4627: 		ENDIF
4628: 
4629: 		IF !INLIST(THIS.this_oBusinessObject.this_nCadProds, 0, 2)
4630: 			SELECT (loc_cItens)
4631: 			IF EMPTY(cpros) AND EMPTY(THIS.txt_4c_NovoGrupo.Value)
4632: 				MsgAviso("Informe o grupo de produto para ser cadastrado!", "Aviso")
4633: 				IF THIS.txt_4c_NovoGrupo.Enabled
4634: 					THIS.txt_4c_NovoGrupo.SetFocus()
4635: 				ENDIF
4636: 				RETURN
4637: 			ENDIF
4638: 
4639: 			TRY
4640: 				loc_cGrupo = ""
4641: 				IF !EMPTY(cpros)
4642: 					IF USED("cursor_4c_TmpGruPro")
4643: 						USE IN cursor_4c_TmpGruPro
4644: 					ENDIF
4645: 					loc_cSQL = "SELECT Cgrus FROM SigCdPro WHERE cpros = " + EscaparSQL(cpros)
4646: 					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGruPro")
4647: 					IF loc_nResultado > 0 AND USED("cursor_4c_TmpGruPro") AND RECCOUNT("cursor_4c_TmpGruPro") > 0
4648: 						loc_cGrupo = ALLTRIM(TratarNulo(cursor_4c_TmpGruPro.Cgrus, ""))
4649: 					ENDIF
4650: 					IF USED("cursor_4c_TmpGruPro")
4651: 						USE IN cursor_4c_TmpGruPro
4652: 					ENDIF
4653: 				ELSE
4654: 					loc_cGrupo = ALLTRIM(THIS.txt_4c_NovoGrupo.Value)
4655: 				ENDIF
4656: 
4657: 				MsgInfo("Grupo de produto: " + loc_cGrupo + CHR(13) + ;
4658: 					"Fornecedor padr" + CHR(227) + "o: " + loc_cCodFornec + CHR(13) + CHR(13) + ;
4659: 					"Ap" + CHR(243) + "s cadastrar, digite o c" + CHR(243) + "digo do produto novo no item da grade.", ;
4660: 					"Cadastro de Produtos")
4661: 

*-- Linhas 4681 a 4699:
4681: 	* Equivale ao par AddCursor('SigMvOrc',...)/AddCursor('SigMvOrp',...)
4682: 	* do Init legado toda vez que ele e reexecutado: le de novo SigMvOrc/
4683: 	* SigMvOrp (BO.CarregarItens/CarregarParcelas, que usam cursor
4684: 	* temporario + ZAP + APPEND FROM DBF - nunca SQLEXEC direto no alias do
4685: 	* Grid), revincula as duas grades, reposiciona e repinta.
4686: 	*
4687: 	* PRESERVA A LINHA CORRENTE: guarda o Citens do item em que o usuario
4688: 	* estava e faz SEEK depois da recarga - sem isso toda recarga jogaria o
4689: 	* usuario de volta para o primeiro item. Cai em GO TOP quando a linha
4690: 	* nao existe mais (ex.: item recem-excluido) ou na primeira carga.
4691: 	*
4692: 	* O SET KEY do mestre-detalhe (PosicionarParcelasDoItem) e DESFEITO
4693: 	* antes da recarga e reposto depois: com filtro pendurado, a releitura
4694: 	* das parcelas enxergaria so a fatia do item corrente.
4695: 	*
4696: 	* Fecha com THIS.Refresh() + Refresh() das duas grades porque popular
4697: 	* cursor NAO repinta a grade ligada a ele, e trocar ordem/chave do
4698: 	* alias tampouco (regra #21).
4699: 	*==========================================================================

*-- Linhas 4715 a 4754:
4715: 			ENDIF
4716: 
4717: 			IF USED(loc_cParcelas)
4718: 				SELECT (loc_cParcelas)
4719: 				SET KEY TO
4720: 			ENDIF
4721: 
4722: 			*-- Pulado em validacao de UI / modo teste: sem conexao SQL real
4723: 			*-- (os cursores existem, so ficam vazios - mesma decisao do
4724: 			*-- CarregarDados desde a Fase 4).
4725: 			IF !loc_lModoValidacaoOuTeste
4726: 				THIS.this_oBusinessObject.CarregarItens()
4727: 				THIS.this_oBusinessObject.CarregarParcelas()
4728: 			ENDIF
4729: 
4730: 			*-- ZAP + APPEND FROM preserva estrutura/RecordSource/
4731: 			*-- CurrentControl, mas Width e Header1.Caption se perdem a cada
4732: 			*-- (re)atribuicao de RecordSource (regra #41) - os dois
4733: 			*-- Vincular* reaplicam tudo e sao idempotentes.
4734: 			THIS.VincularGradeItens()
4735: 			THIS.VincularGradeParcelas()
4736: 
4737: 			loc_lAchou = .F.
4738: 			IF USED(loc_cItens)
4739: 				SELECT (loc_cItens)
4740: 				SET ORDER TO TAG citens
4741: 				IF loc_nItemAtual > 0
4742: 					loc_lAchou = SEEK(loc_nItemAtual, loc_cItens, "citens")
4743: 				ENDIF
4744: 				IF !loc_lAchou
4745: 					GO TOP
4746: 				ENDIF
4747: 			ENDIF
4748: 
4749: 			THIS.PosicionarParcelasDoItem()
4750: 			THIS.AtualizarEstadoCadastroProduto()
4751: 
4752: 			THIS.Refresh()
4753: 			THIS.grd_4c_Itens.Refresh()
4754: 			THIS.grd_4c_Parcelas.Refresh()

*-- Linhas 4793 a 4832:
4793: 	* da grade) para as properties do Business Object, e carrega nele o
4794: 	* item da linha corrente da grade.
4795: 	*
4796: 	* No legado esses 5 campos tem ControlSource apontando para o cursor de
4797: 	* CABECALHO do form PAI (conferido um a um no dump):
4798: 	*   getPtax2    -> TprMvCab.ptax2s  -> this_nPTax2s  (Contingente/Perc1s)
4799: 	*   getPtaxa    -> TprMvCab.descs   -> this_nDescs   (Taxa Adm./Lucro, Perc2s)
4800: 	*   getPTax1    -> TprMvCab.ptax1s  -> this_nPTax1s  (BV/Perc3s)
4801: 	*   getPimposto -> TprMvCab.acres   -> this_nAcres   (Imposto, Perc4s nao-servico)
4802: 	*   getPservico -> TprMvCab.ptax3s  -> this_nPTax3s  (Imposto sem ISS, Perc4s servico)
4803: 	* Com ControlSource a sincronizacao era automatica; aqui TprMvCab nao
4804: 	* existe (o dialogo nao compartilha data session - ver cabecalho do
4805: 	* arquivo) e os cinco valores sao escalares do BO, entao a
4806: 	* sincronizacao e MANUAL e passa por este metodo.
4807: 	*
4808: 	* getPmargem (txt_4c_Margem) NAO entra: nao tem ControlSource no dump e
4809: 	* o When dele e ".f." - e resultado calculado por TotalizarItn, nunca
4810: 	* digitado nem gravado.
4811: 	*
4812: 	* PERSISTENCIA DO CABECALHO - DIVERGENCIA FIEL AO LEGADO: nem o
4813: 	* OK.btnSair.Click nem nenhum outro metodo do SIGOPORC grava TprMvCab
4814: 	* (conferido no dump: nao ha TableUpdate/Insert/Update sobre esse
4815: 	* cursor). Quem persiste SigMvCab e o form de cabecalho - este dialogo
4816: 	* so devolve os valores em memoria. Por isso FormParaBO escreve nas
4817: 	* properties do BO e NAO emite UPDATE em SigMvCab: fazer isso aqui
4818: 	* duplicaria a responsabilidade do pai e poderia sobrescrever o que ele
4819: 	* tem em edicao.
4820: 	*==========================================================================
4821: 	FUNCTION FormParaBO()
4822: 		LOCAL loc_lSucesso, loc_oErro, loc_cItens
4823: 		loc_lSucesso = .F.
4824: 
4825: 		IF VARTYPE(THIS.this_oBusinessObject) <> "O"
4826: 			RETURN .F.
4827: 		ENDIF
4828: 
4829: 		TRY
4830: 			THIS.this_oBusinessObject.this_nPTax2s = THIS.NumeroDoCampo(THIS.txt_4c_Contingente.Value)
4831: 			THIS.this_oBusinessObject.this_nDescs  = THIS.NumeroDoCampo(THIS.txt_4c_TaxaAdm.Value)
4832: 			THIS.this_oBusinessObject.this_nPTax1s = THIS.NumeroDoCampo(THIS.txt_4c_BV.Value)

*-- Linhas 4862 a 4880:
4862: 	* BOParaForm - BO -> TELA. Espelha nos 5 campos de percentual os valores
4863: 	* que o BO leu de SigMvCab em CarregarConfiguracao (acres/ptax1s/
4864: 	* ptax2s/ptax3s/descs), que no legado chegavam sozinhos pelo
4865: 	* ControlSource = TprMvCab.<coluna>.
4866: 	*
4867: 	* Fase 8/8 - SEM ESTE METODO os 5 campos abriam SEMPRE em 0,00, mesmo
4868: 	* com o cabecalho do orcamento tendo percentuais gravados: nada no
4869: 	* form lia essas properties do BO. Alem de exibir errado, isso
4870: 	* contaminava o calculo - os handlers Txt*KeyPress aplicam o valor do
4871: 	* CAMPO em perc1s..perc6s de cada item, entao o primeiro Enter num
4872: 	* campo zerado zeraria o percentual de todos os itens.
4873: 	*
4874: 	* Nao toca txt_4c_Margem (resultado calculado por TotalizarItn, ver
4875: 	* FormParaBO) nem a grade: os itens/parcelas vem por CarregarLista.
4876: 	*==========================================================================
4877: 	FUNCTION BOParaForm()
4878: 		LOCAL loc_lSucesso, loc_oErro
4879: 		loc_lSucesso = .F.
4880: 

*-- Linhas 5093 a 5129:
5093: 	* saida sem gravacao existir num lugar so.
5094: 	*
5095: 	* Fechar os dois cursores aqui e o que DESCARTA as edicoes em memoria:
5096: 	* eles sao LOCAIS do dialogo (CREATE CURSOR em CriarCursorItens/
5097: 	* CriarCursorParcelas), nao aliases emprestados do chamador, e a
5098: 	* persistencia acontece unicamente em BtnSalvarClick - reabrir o
5099: 	* dialogo depois disso le tudo de novo de SigMvOrc/SigMvOrp. O SET KEY
5100: 	* do mestre-detalhe sai antes, para nao deixar filtro pendurado.
5101: 	*
5102: 	* NAO pede confirmacao: o legado nao pergunta nada em nenhum caminho de
5103: 	* saida, e inventar um dialogo de confirmacao mudaria a UX (PILAR 1).
5104: 	*==========================================================================
5105: 	PROCEDURE BtnCancelarClick()
5106: 		LOCAL loc_oErro, loc_cItens, loc_cParcelas
5107: 
5108: 		TRY
5109: 			IF VARTYPE(THIS.this_oBusinessObject) = "O"
5110: 				loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
5111: 				loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
5112: 
5113: 				IF USED(loc_cParcelas)
5114: 					SELECT (loc_cParcelas)
5115: 					SET KEY TO
5116: 					USE IN (loc_cParcelas)
5117: 				ENDIF
5118: 
5119: 				IF USED(loc_cItens)
5120: 					USE IN (loc_cItens)
5121: 				ENDIF
5122: 			ENDIF
5123: 		CATCH TO loc_oErro
5124: 			MsgErro(loc_oErro.Message + CHR(13) + ;
5125: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5126: 				"Procedure: " + loc_oErro.Procedure, ;
5127: 				"Erro em Formsigoporc.BtnCancelarClick")
5128: 		ENDTRY
5129: 

*-- Linhas 5166 a 5191:
5166: 				ENDIF
5167: 			ENDIF
5168: 
5169: 			*-- Os dois cursores sao LOCAIS deste dialogo (CREATE CURSOR em
5170: 			*-- CriarCursorItens/CriarCursorParcelas), nao aliases emprestados
5171: 			*-- do chamador - por isso podem e devem ser fechados aqui. Antes
5172: 			*-- de fechar o de parcelas, desfaz o SET KEY aplicado por
5173: 			*-- PosicionarParcelasDoItem, para nao deixar filtro pendurado.
5174: 			IF VARTYPE(THIS.this_oBusinessObject) = "O"
5175: 				IF USED(THIS.this_oBusinessObject.this_cCursorParcelas)
5176: 					SELECT (THIS.this_oBusinessObject.this_cCursorParcelas)
5177: 					SET KEY TO
5178: 					USE IN (THIS.this_oBusinessObject.this_cCursorParcelas)
5179: 				ENDIF
5180: 
5181: 				IF USED(THIS.this_oBusinessObject.this_cCursorItens)
5182: 					USE IN (THIS.this_oBusinessObject.this_cCursorItens)
5183: 				ENDIF
5184: 			ENDIF
5185: 
5186: 			THIS.this_oFormPai = .NULL.
5187: 			THIS.this_oObjExt1 = .NULL.
5188: 		CATCH TO loc_oErro
5189: 			MsgErro(loc_oErro.Message, "Erro em Formsigoporc.Destroy")
5190: 		ENDTRY
5191: 


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

