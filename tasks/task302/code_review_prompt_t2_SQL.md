# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPREDE, CPROS, NCNT, LLRECNO, CODS, CGRUS, LCEMPDS, LCOPERS, CBARS, EMPDOPNUMS, EMPS, NOMELISTA, LCXEMPDS, I, INATIVAS, ANO, SGRUPOS, SCONTAS, GRUPOS, CONTAS, LIMCRES, VALOS, 0, MES, GRUPOSCC, CONTASCC, GRUPOSEMT, CONTASEMT, CONTAMATS, GRCLIS, ICLIS, UMOVS, TIPOS, ESTOS, CHKLIMESTS, _SALDO, LCUPDATE, CIDCHAVES, CHKESC, CONTAOS, DOPES, CMOES, LPRECOS, ICL

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
  ControlSource = "TmpList"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
Select TmpPlanilha
		Select TmpPlanilha	
	loBarraLista.Update(.T.,'Referencia: ' +TmpPlanilha.Referencia)
	Select crSigCdPro
		Select TmpPlanilha	
		Insert Into CrSigPrPre (Cpros, cIdChaves, PVens, PVensAnt, Moevs, MoevsAnt, Datas) Values ;
	Select 	CrSigImpPr
		lcQuery = [Select * From SigPrTam Where Cpros = ']+lcCpros+[' ]	
		If ThisForm.poDatamgr.SqlExecute(lcQuery,[crSigPrTam]) <1
			=Messagebox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigPrTam)])
		Select crSigPrTam
	lcUpdate = [Update SigCdPro Set pVens = ]+Alltrim(Str(lnPVens,12,5)) + ;
	If ThisForm.poDatamgr.SqlExecute(lcUpdate) <1
		=Messagebox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - CrSigImpPr)])
	lcDelete = [Delete from SigPrPrt Where CPros = ']+lcCpros+[' ] 
	If ThisForm.poDatamgr.SqlExecute(lcDelete) <1
		=Messagebox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Delete - 1)])
	If Not Thisform.poDataMgr.Update('CrSigImpPr')
		=Messagebox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - CrSigImpPr)])
	If Not Thisform.poDataMgr.Update('CrSigPrPre')
		=Messagebox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - CrSigPrPre)])
	If Not Thisform.poDataMgr.Update('CrSigPrTam')
		=Messagebox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - CrSigPrTam)])
	Select TmpPlanilha
Select ComboTipo
	Delete File lcFile+'TmpPlanilha.dbf'
	Select TmpPlanilha 
	Append From Alltrim(Thisform.Cntplanilha.getPlanilha.Value) Type Xl5
Select TmpPlanilha 	
	Delete In TmpPlanilha 
Select crSigCdPac
Select crSigCdOpe
Select TmpPlanilha
Scan for !Deleted() 
Select distinct * From TmpPlanilha Into Cursor csTransf ReadWrite
Select csTransf
Scan for !Deleted() 
 	loBarraLista.Update(.T.,'Empresa: ' +csTransf.EmpDs)
 		Select csTransf
		Select csTransf
		Select csTransf
		Select csTransf
		Select csTransf
	Select crSigCdEmp
		Select csTransf	
	Select crSigCdEmp2
		Select csTransf	
	Select crSigCdCli
		Select csTransf	
	Select crSigCdPro
		Select csPrNAOCad
		Select csTransf	
			Select csTransf
			Select csTransf
			Select csTransf
			Select csTransf
		lcQuery = [Select * From SigCdTam Where Cods = ']+lcTam+[' ]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crTmpTam') < 1)
		Select crTmpTam
		lcQuery = [Select * From SigCdCor Where Cods = ']+lcCor+[' ]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crTmpCor') < 1)
		Select crTmpCor
	lcQuery = [Select TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, mtPrimas, LocalPdr ] + ;
		[From SigCdGrp ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crTmpGru') < 1)
		Select csPrSemCT
			Insert Into CrSigMvCab (Datars,DataS,Dopes,Emps,EmpDs,Numes,MascNum,GrupoOs,ContaOs,GrupoDs,ContaDs,CIdChaves,DtAlts,EmpDopNums, usuals, Usuars, PRAZOENTS, grupoccs, contaccs) ;
		Insert Into CrSigMvItn (CPros,Dopes,Emps,Numes,Opers,Qtds,CItens,Units,Totas,Moedas,DPros,AQtds,CUnis,CIdChaves,DtAlts,EmpDopNums,Pesos,codbarras) ;
			Insert Into CrSigMvIts (Emps,Dopes,Numes,CPros,CodTams,CodCors,Qtds,AQtds,codbarras,Pesos,CIdChaves,EmpDopNums,chksubn,CItens) ;
			Insert Into CrSigMvHst (CPros,Datars,DataS,DtAudits,Dopes,EmpOs,Emps,Opers,Numes,Qtds,Units,Totas,Grupos,;
			lcUpdate = [Update SigOpEtq Set Contas = Space(10), Grupos = Space(10) Where Cbars = ]+Str(lnCbars,14)
			If Thisform.poDataMgr.SqlExecute(lcUpdate) < 1
				Messagebox('Favor reinicializar o processo !!!',16,'Falha na Conexão (lcUpdate - Transferencia)')
	Select csTransf
lnOldSel = Select()
Select csPrNAOCad
	Select csPrNAOCad
Select csPrSemCT
	Select csPrSemCT
Select CrSigMvItn
Select EmpDopNums, Sum(Totas) as Total From CrSigMvItn Group by EmpDopNums Order by EmpDopNums Into Cursor csTmpTot ReadWrite
Select csTmpTot
	Update CrSigMvCab Set Valos = csTmpTot.Total Where EmpDopNums = csTmpTot.EmpDopNums
	Select csTmpTot	
	Select CrSigMvCab
Select(lnOldSel)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvCab'), 1, -1)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvItn'), 1, -1)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvIts'), 1, -1)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvHst'), 1, -1)
Select crSigCdPac
Select crSigCdOpe
Select TmpPlanilha
Scan For !Deleted()
Select Distinct *, Alltrim(Right(EmpresaO,3)) As Emps, Alltrim(Right(EmpresaD,3)) As EmpDs From TmpPlanilha Into Cursor csTransf Readwrite
Select csTransf
	loBarraLista.Update(.T.,'Empresa: ' +csTransf.Emps)
		Select csTransf
		Select csTransf
		Select csTransf
	Select crSigCdEmp
		Select csTransf
	Select crSigCdEmp2
		Select csTransf
	Select crSigCdPro
		Select csPrNAOCad
		Select csTransf
			Select csTransf
			Select csTransf
			Select csTransf
			Select csTransf
		lcQuery = [Select * From SigCdTam Where Cods = ']+lcTam+[' ]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crTmpTam') < 1)
		Select crTmpTam
		lcQuery = [Select * From SigCdCor Where Cods = ']+lcCor+[' ]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crTmpCor') < 1)
		Select crTmpCor
	lcQuery = [Select TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, mtPrimas, LocalPdr ] + ;
		[From SigCdGrp ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crTmpGru') < 1)
		Select csPrSemCT
			Insert Into CrSigMvCab (Datars,DataS,Dopes,Emps,EmpDs,Numes,MascNum,GrupoOs,ContaOs,GrupoDs,ContaDs,CIdChaves,DtAlts,EmpDopNums, usuals, Usuars, PRAZOENTS) ;
		Insert Into CrSigMvItn (Cpros,Dopes,Emps,Numes,opers,Qtds,CItens,Units,Totas,Moedas,Dpros,AQtds,CUnis,CIdChaves,DtAlts,EmpDopNums,Pesos,codbarras) ;
			Insert Into CrSigMvIts (Emps,Dopes,Numes,Cpros,CodTams,CodCors,Qtds,AQtds,codbarras,Pesos,CIdChaves,EmpDopNums,chksubn,CItens) ;
			Insert Into CrSigMvHst (Cpros,Datars,DataS,DtAudits,Dopes,EmpOs,Emps,opers,Numes,Qtds,Units,Totas,Grupos,;
			lcUpdate = [Update SigOpEtq Set Contas = Space(10), Grupos = Space(10) Where Cbars = ]+Str(lnCBars,14)
			If Thisform.poDataMgr.SqlExecute(lcUpdate) < 1
				Messagebox('Favor reinicializar o processo !!!',16,'Falha na Conexão (lcUpdate - Transferencia)')
	Select csTransf
lnOldSel = Select()
Select csPrNAOCad
	Select csPrNAOCad
Select csPrSemCT
	Select csPrSemCT
Select(lnOldSel)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvCab'), 1, -1)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvItn'), 1, -1)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvIts'), 1, -1)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvHst'), 1, -1)
Select Distinct NomeLista, Emps From TmpPlanilha Into Cursor crNomeLista
Select crNomeLista && Se tiver mais de 1 lista por planilha
 	loBarraLista.Update(.T.,'Lista: ' +crNomeLista.NomeLista)
		lcQuery = [Select lPrecos ] + ;
				    [From SigCdLpc ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)
			Select crNomeLista
			Select crNomeLista
 	Select crNomeLista
	Select crSigCdLpc
		Select * from TmpPlanilha Where NomeLista = crNomeLista.NomeLista Into Cursor crTmpPlanilha
		Select crTmpPlanilha
			loBarraProLi.Update(.T.,'Produto: ' + crSigCdPro.cPros + ' - ' + crSigCdPro.dPros)	
			Select 	crSigCdLpi
		If Not ThisForm.poDataMgr.Update('crSigCdLpc')
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigCdLpc)])
		If Not ThisForm.poDataMgr.Update('crSigCdLpi')
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigCdLpi)])
Select crSigCdPac
Select crSigCdOpe
Select TmpPlanilha
Scan For !Deleted()
Select Distinct * From TmpPlanilha Into Cursor csTransf Readwrite
Select csTransf
Scan For !Deleted()
	loBarraLista.Update(.T.,'Empresa: ' +csTransf.Empds)
		Select csTransf
		Select csTransf
		Select csTransf
		Select csTransf
		lcQuery = [Select * From SigCdTam Where Cods = ']+lcTam+[' ]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crTmpTam') < 1)
		Select crTmpTam
		lcQuery = [Select * From SigCdCor Where Cods = ']+lcCor+[' ]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crTmpCor') < 1)
		Select crTmpCor
	Select crSigCdEmp
		Select csTransf
	Select crSigCdEmp2
		Select csTransf
	Select crSigCdCli
		Select csTransf
	Select crSigCdPro
		Select csPrNAOCad
		Select csTransf
			Select csTransf
			Select csTransf
			Select csTransf
			Select csTransf
	lcQuery = [Select TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, mtPrimas, LocalPdr ] + ;
		[From SigCdGrp ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crTmpGru') < 1)
		Select csPrSemCT
			Insert Into CrSigMvCab (Datars,DataS,Dopes,Emps,Empds,Numes,MascNum,GrupoOs,ContaOs,GrupoDs,ContaDs,CIdChaves,DtAlts,EmpDopNums, usuals, Usuars, PRAZOENTS, grupoccs, contaccs) ;
		Insert Into CrSigMvItn (Cpros,Dopes,Emps,Numes,opers,Qtds,CItens,Units,Totas,Moedas,Dpros,AQtds,CUnis,CIdChaves,DtAlts,EmpDopNums,Pesos,codbarras) ;
			Insert Into CrSigMvIts (Emps,Dopes,Numes,Cpros,CodTams,CodCors,Qtds,AQtds,codbarras,Pesos,CIdChaves,EmpDopNums,chksubn,CItens) ;
			Insert Into CrSigMvHst (Cpros,Datars,DataS,DtAudits,Dopes,EmpOs,Emps,opers,Numes,Qtds,Units,Totas,Grupos,;
			lcUpdate = [Update SigOpEtq Set Contas = Space(10), Grupos = Space(10) Where Cbars = ]+Str(lnCBars,14)
			If Thisform.poDataMgr.SqlExecute(lcUpdate) < 1
				Messagebox('Favor reinicializar o processo !!!',16,'Falha na Conexão (lcUpdate - Transferencia)')
	Select csTransf
lnOldSel = Select()
Select csPrNAOCad
	Select csPrNAOCad
Select csPrSemCT
	Select csPrSemCT
Select CrSigMvItn
Select EmpDopNums, Sum(Totas) As Total From CrSigMvItn Group By EmpDopNums Order By EmpDopNums Into Cursor csTmpTot Readwrite
Select csTmpTot
	Update CrSigMvCab Set Valos = csTmpTot.Total Where EmpDopNums = csTmpTot.EmpDopNums
	Select csTmpTot
	Select CrSigMvCab
Select(lnOldSel)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvCab'), 1, -1)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvItn'), 1, -1)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvIts'), 1, -1)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvHst'), 1, -1)
		Insert Into ComboTipo (Titulo,Rotina,ColunaLi) values (aComboTipo[i,1],aComboTipo[i,2],aComboTipo[i,3])
Select CrSigCdGcr2
lcQuery = [Select a.cidchaves, a.codigo, a.grupos, a.contas, a.chkvalida, b.sgrupos, b.scontas, b.Ano, b.moeda ] +_Campo+ ;
	[From SigCdMtI a ] + ;
	[join SigCdMtz b on a.codigo = b.codigo ] + ;
If (Thisform.poDataMgr.SqlExecute(lcQuery, [crSigCdMtI]) < 1)
Select crSigCdMtI
lcQuery = [Select Ano, replicate('0',2-len(ltrim(rtrim(Mes))))+ltrim(rtrim(Mes)) as Mes, ] + ; 
        [from( ] + ;   
        [select a.limcres, a.dopes, ] + ;  
        [c.datas, case when a.cmoes = space(3) then (Select moedaps from sigcdpam) else a.cmoes end as cmoes, ] + ;  
        [from sigcdope a  ] + ;  
        [join sigopcdd b on a.dopes = b.dopes ] + ;    
        [join sigmvcab c on a.dopes = c.dopes ] + ;    
If (Thisform.poDataMgr.SqlExecute(lcQuery, [crSldMov]) < 1)
Select crSldMov
	Select crSldMov
	lcQuery = [Select a.cidchaves, a.codigo, a.grupos, a.contas, a.chkvalida, b.sgrupos, b.scontas, b.Ano, b.moeda ] + _Campo + ;
		[From SigCdMtI a ] + ;
		[join SigCdMtz b on a.codigo = b.codigo ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [crSigCdMtI]) < 1)
	lcQuery = [Select IClis ] + ;
		[From SigCdCli ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalContas]) < 1)
	Select crSigCdMtI
	Select crPar
	Select LocalContas
		lcQuery = [Select sum(a.valors) as Valors, a.fpags ]+;
			[From SigChe a, SigCdOpt b Where a.GrClis = ']+_Grupo+[' ]+;
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'Cheques') < 1)
		Select Cheques
		Select crSigClLcr
	Select LocalContas
			lcQuery = [Select a.Cpros, Sum(a.Sqtds) as Qtds From SigMvEst a, SigCdGcr b ]+;
			If (Thisform.poDataMgr.SqlExecute(lcQuery, 'CrEst') < 1)
			lcQuery = [Select Cpros, Sum(Qtds*-1) as Qtds From SigMvItn Where EmpDopNums = ']+lcChave+[' Group By Cpros ]
			If (Thisform.poDataMgr.SqlExecute(lcQuery, 'CrEsti') < 1)
			Select Cpros, Sum(qtds) As qtds From crEst Group By Cpros ;
				Select Cpros, Sum(qtds) As qtds From crTpmMvItn Group By Cpros;
				Select Cpros, Sum(qtds) As qtds From crEsti Group By Cpros;
			lcQuery = [Select a.Cpros, Sum(a.Sqtds) as Qtds From SigMvEst a, SigCdGcr b ]+;
			If (Thisform.poDataMgr.SqlExecute(lcQuery, 'TmpEst') < 1)
		Select TmpEst
llUpdate = .T.
			llUpdate = .F.
			llUpdate = .T.
	lcUpdate = [Update SigCdMti set ]+_CmpUp+[ = ]+Alltrim(Str((_Valor + _SaldoMov),13,2))+[ Where cIdChaves = ']+crSigCdMtI.cIdChaves+[']
	If (Thisform.poDataMgr.SqlExecute(lcUpdate) < 1)
If (Thisform.poDataMgr.SQLExecute([Select Cemps From SigCdEmp Where ChkEsc = 1], [crChkEsc]) < 1)
Select TmpPlanilha
Select Distinct Contaos, Dopes, PrazoEnts From TmpPlanilha ;
Select csMovPlan
	Select crSigCdOpe
		Select csMovPlan
	Select * From TmpPlanilha Where Contaos = lcContaOs And Dopes = lcDopes Into Cursor csPedFab Readwrite
	Select csPedFab
			Select csPedFab
			Select csPedFab
			Select csPedFab
			Select csPedFab
			lcQuery = [Select * From SigCdTam Where Cods = ']+lcTam+[' ]
			If (Thisform.poDataMgr.SQLExecute(lcQuery, 'crTmpTam') < 1)
			Select crTmpTam
			lcQuery = [Select * From SigCdCor Where Cods = ']+lcCor+[' ]
			If (Thisform.poDataMgr.SQLExecute(lcQuery, 'crTmpCor') < 1)
			Select crTmpCor
		Select crSigCdCli
			Select csPedFab
		Select crSigCdPro
			Select csPrNAOCad
			Select csPedFab
				Select csPedFab
				Select csPedFab
		lcQuery = [Select TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, mtPrimas, LocalPdr ] + ;
			[From SigCdGrp ] + ;
		If (Thisform.poDataMgr.SQLExecute(lcQuery, 'crTmpGru') < 1)
			Select csPrSemCT
				Insert Into CrSigMvCab (Datars,DataS,Dopes,Emps,EmpDs,Numes,MascNum,GrupoOs,Contaos,GrupoDs,ContaDs,CIdChaves,DtAlts,EmpDopNums, usuals, Usuars, PrazoEnts, grupoccs, contaccs) ;
			Insert Into CrSigMvItn (Cpros,Dopes,Emps,Numes,opers,Qtds,CItens,Units,Totas,Moedas,Dpros,AQtds,CUnis,CIdChaves,DtAlts,EmpDopNums,Pesos,codbarras) ;
				Insert Into CrSigMvIts (Emps,Dopes,Numes,Cpros,CodTams,CodCors,Qtds,AQtds,codbarras,Pesos,CIdChaves,EmpDopNums,chksubn,CItens) ;
				Insert Into CrSigMvHst (Cpros,Datars,DataS,DtAudits,Dopes,EmpOs,Emps,opers,Numes,Qtds,Units,Totas,Grupos,;
		Select csPedFab
	Select csMovPlan
lnOldSel = Select()
Select csPrNAOCad
	Select csPrNAOCad
Select csPrSemCT
	Select csPrSemCT
Select CrSigMvItn
Select EmpDopNums, Sum(Totas) As Total From CrSigMvItn Group By EmpDopNums Order By EmpDopNums Into Cursor csTmpTot Readwrite
Select csTmpTot
	Update CrSigMvCab Set Valos = csTmpTot.Total Where EmpDopNums = csTmpTot.EmpDopNums
	Select csTmpTot
	Select CrSigMvCab
Select(lnOldSel)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvCab'), 1, -1)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvItn'), 1, -1)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvIts'), 1, -1)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvHst'), 1, -1)
Select crSigCdPac
Select crSigCdOpe
Select TmpPlanilha
Scan for !Deleted() 
Select distinct * From TmpPlanilha Into Cursor csTransf ReadWrite
Select csTransf
Scan for !Deleted() 
 	loBarraLista.Update(.T.,'Empresa: ' +csTransf.EmpDs)
 		Select csTransf
		Select csTransf
		Select csTransf
		Select csTransf
		Select csTransf
	Select crSigCdEmp
		Select csTransf	
	Select crSigCdEmp2
		Select csTransf	
	Select crSigCdCli
		Select csTransf	
	Select crSigCdPro
		Select csPrNAOCad
		Select csTransf	
			Select csTransf
			Select csTransf
			Select csTransf
			Select csTransf
		lcQuery = [Select * From SigCdTam Where Cods = ']+lcTam+[' ]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crTmpTam') < 1)
		Select crTmpTam
		lcQuery = [Select * From SigCdCor Where Cods = ']+lcCor+[' ]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crTmpCor') < 1)
		Select crTmpCor
	lcQuery = [Select TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, mtPrimas, LocalPdr ] + ;
		[From SigCdGrp ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crTmpGru') < 1)
		Select csPrSemCT
			Insert Into CrSigMvCab (Datars,DataS,Dopes,Emps,EmpDs,Numes,MascNum,GrupoOs,ContaOs,GrupoDs,ContaDs,CIdChaves,DtAlts,EmpDopNums, usuals, Usuars, PRAZOENTS, grupoccs, contaccs) ;
		Insert Into CrSigMvItn (CPros,Dopes,Emps,Numes,Opers,Qtds,CItens,Units,Totas,Moedas,DPros,AQtds,CUnis,CIdChaves,DtAlts,EmpDopNums,Pesos,codbarras) ;
			Insert Into CrSigMvIts (Emps,Dopes,Numes,CPros,CodTams,CodCors,Qtds,AQtds,codbarras,Pesos,CIdChaves,EmpDopNums,chksubn,CItens) ;
			Insert Into CrSigMvHst (CPros,Datars,DataS,DtAudits,Dopes,EmpOs,Emps,Opers,Numes,Qtds,Units,Totas,Grupos,;
			lcUpdate = [Update SigOpEtq Set Contas = Space(10), Grupos = Space(10) Where Cbars = ]+Str(lnCbars,14)
			If Thisform.poDataMgr.SqlExecute(lcUpdate) < 1
				Messagebox('Favor reinicializar o processo !!!',16,'Falha na Conexão (lcUpdate - Transferencia)')
	Select csTransf
lnOldSel = Select()
Select csPrNAOCad
	Select csPrNAOCad
Select csPrSemCT
	Select csPrSemCT
Select CrSigMvItn
Select EmpDopNums, Sum(Totas) as Total From CrSigMvItn Group by EmpDopNums Order by EmpDopNums Into Cursor csTmpTot ReadWrite
Select csTmpTot
	Update CrSigMvCab Set Valos = csTmpTot.Total Where EmpDopNums = csTmpTot.EmpDopNums
	Select csTmpTot	
	Select CrSigMvCab
Select(lnOldSel)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvCab'), 1, -1)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvItn'), 1, -1)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvIts'), 1, -1)
	lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigMvHst'), 1, -1)
	lcSql = [Select Cotas From SigCdMoe where Cmoes = ']+_xMoeda+[']
	If ThisForm.poDataMgr.Sqlexecute(lcsql,'LocalMoe') < 1
		If !Seek( _xMoeda, "TmpCot" )
			Insert Into TmpCot ( Cmoes, Valos ) Values ( _xMoeda, _xCotacao )
		Select TmpTotal
		If !Seek(_xMoeda)
			Insert Into TmpTotal (Moeds) Values (_xMoeda)
	Select (lcAlias)
lcQryListaPreco  = 'Select * from SigCdLpc  Where lPrecos = ?plCodLista And Emps = ?plEmps'
lcQryListaPrecoi = 'Select * from SigCdLpi Where lPrecos = ?plPrecos '
lcQryPro		 = 'Select cGrus, cPros, dPros, MoeVs, pCuss, Ean13, Reffs From SigCdPro Where cPros = ?pPro'
		= .poDataMgr.SqlExecute([Select * From SigCdPam],[crSigCdPam])
		= .poDataMgr.SqlExecute([Select * From SigCdPac],[crSigCdPac])
	m.lcMcrSql1 = [select a.cmoes,a.cotas,a.moeqs,a.qtdeqs from SigCdMoe a order by 1]
		Select ('crSigCdMoe') 
	m.lcMcrSql1 = [select a.cmoes,a.datas,a.horas,a.valos from SigCdCot a order by 1 asc,2 desc,3 desc]
		Select ('crSigCdCot') 

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprila.prg) - TRECHOS RELEVANTES PARA PASS SQL (978 linhas total):

*-- Linhas 6 a 24:
6: *
7: * Pilares:
8: *   UX   -> layout identico ao legado (800x350, container planilha + botoes)
9: *   BD   -> SigPrTam, SigMvCab, SigMvItn, SigCdLpc, SigCdLpi via SQLEXEC
10: *   CODE -> arquitetura em camadas (FormBase / sigprilaBO)
11: *==============================================================================
12: 
13: DEFINE CLASS Formsigprila AS FormBase
14: 
15:     *-- Dimensoes e aparencia (identico ao legado)
16:     Height       = 350
17:     Width        = 800
18:     AutoCenter   = .T.
19:     BorderStyle  = 2
20:     TitleBar     = 0
21:     ShowWindow = 1
22:     WindowType = 1
23:     ControlBox   = .F.
24:     MaxButton    = .F.

*-- Linhas 208 a 226:
208:             WITH .txt_4c_Planilha
209:                 .FontName            = "Tahoma"
210:                 .FontSize            = 8
211:                 .ControlSource       = ""
212:                 .Enabled             = .F.
213:                 .Height              = 23
214:                 .Left                = 85
215:                 .MaxLength           = 0
216:                 .ReadOnly            = .T.
217:                 .Top                 = 37
218:                 .Width               = 336
219:                 .ForeColor           = RGB(0, 0, 0)
220:                 .DisabledBackColor   = RGB(255, 255, 255)
221:             ENDWITH
222: 
223:             *-- Botao abrir arquivo XLS
224:             .AddObject("cmd_4c_Cmdgetp", "CommandButton")
225:             WITH .cmd_4c_Cmdgetp
226:                 .Top         = 36

*-- Linhas 500 a 518:
500:     * ConfigurarPaginaDados - Monta a area de acoes sobre os dados de entrada
501:     * (equivalente logico da Page2 Dados do pipeline CRUD). Em Formsigprila
502:     * corresponde aos botoes que operam sobre o painel configurado por
503:     * ConfigurarPaginaLista: Processar (executa a importacao SQLEXEC/INSERT)
504:     * e Encerrar (fecha o formulario). Separado por semantica list-vs-action.
505:     *==========================================================================
506:     PROTECTED PROCEDURE ConfigurarPaginaDados
507:         THIS.ConfigurarBotoes()
508:     ENDPROC
509: 
510:     *==========================================================================
511:     * AlternarPagina - Reinicia o fluxo de importacao para uma nova operacao.
512:     * Forms OPERACIONAIS nao possuem PageFrame; "alternar para pagina 1"
513:     * equivale a limpar todos os campos de entrada, fechar cursores de
514:     * processamento anterior e reposicionar o foco no combo de tipos.
515:     * Chamado apos concluir uma importacao (Processar) para preparar o form
516:     * para importar outra planilha sem precisar recriar controles.
517:     *==========================================================================
518:     PROCEDURE AlternarPagina(par_nPagina)

*-- Linhas 710 a 728:
710: 
711:         loc_cRotina = ""
712:         IF USED("ComboTipo") AND !EOF("ComboTipo")
713:             SELECT ComboTipo
714:             loc_cRotina = ALLTRIM(ComboTipo.Rotina)
715:         ENDIF
716: 
717:         loc_lResultado = THIS.this_oBusinessObject.Processamento( ;
718:             loc_nTipo, loc_nPreco, loc_cRotina, loc_cArquivo, ;
719:             loc_lCabecalho, THIS.cnt_4c_Planilha.obj_4c_List1)
720: 
721:         IF loc_lResultado
722:             THIS.AlternarPagina(1)
723:         ENDIF
724:     ENDPROC
725: 
726:     *==========================================================================
727:     * BtnAlterarClick - Reaproveita o fluxo de importacao (BtnIncluirClick).
728:     * Importacao e sempre substituicao/idempotente -- nao ha distincao entre

*-- Linhas 763 a 781:
763: 
764:         loc_cRotina = ""
765:         IF USED("ComboTipo") AND !EOF("ComboTipo")
766:             SELECT ComboTipo
767:             loc_cRotina = ALLTRIM(ComboTipo.Rotina)
768:         ENDIF
769: 
770:         IF !THIS.this_oBusinessObject.ValidarColunas(loc_cRotina)
771:             MsgAviso("Rotina '" + loc_cRotina + "' n" + CHR(227) + "o reconhecida para o tipo selecionado.")
772:             RETURN
773:         ENDIF
774: 
775:         MsgInfo("Configura" + CHR(231) + CHR(227) + "o v" + CHR(225) + "lida." + CHR(13) + ;
776:             "Tipo: " + loc_cTipoSel + CHR(13) + ;
777:             "Arquivo: " + loc_cArquivo)
778:     ENDPROC
779: 
780:     *==========================================================================
781:     * BtnExcluirClick - Descarta as selecoes atuais e reinicia o fluxo.

