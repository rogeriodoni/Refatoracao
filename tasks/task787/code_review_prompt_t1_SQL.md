# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (9)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'USUARIOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, PESOMS, FAIXAPESO, CPROS, CGRUS, EMPGRUESTS, MATS, PROCESSOS, COPIAS, EMPMRCFS, ORIDOPNUMS, COPERS, CIDCHAVES, NUMLOTES, NCHEQUES, NUMS, CIDCONNS, LCCT3, LNGCO, CODBARRAS, CITENS, NDOPES, CODCORS, CODTAMS, CBARS, NOPS, DOPES, OPERS, ORIGEMS, QTEQUALPS, 0, LNCNT, NUMPS, LLNAO, I, LLACHOU, LNVAL, DPROS, FKCHAVES, MERCS, CUNIS, PRODUTOS, REFFS, COMPOS, EMPS, EMPDS, DOPEDS, CONTAOS, CONTADS, LLFILTRA, UNITS, NUMES, MOEVALS, ESTDESTS, LNAGR, GLOBALIZAS, EMPDNPS, NOPERS, LLF, TIPOS, DATAS, DRIVES, SQTDS, DTALTS, DOPCS, SGRUS, UNICOMPOS, GRUPOS, ORDEMS, ICLIS, PESOS, CUNIPS, CESTOQS, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NOTAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, PESOMS, FAIXAPESO, CPROS, CGRUS, EMPGRUESTS, MATS, PROCESSOS, COPIAS, EMPMRCFS, ORIDOPNUMS, COPERS, CIDCHAVES, NUMLOTES, NCHEQUES, NUMS, CIDCONNS, LCCT3, LNGCO, CODBARRAS, CITENS, NDOPES, CODCORS, CODTAMS, CBARS, NOPS, DOPES, OPERS, ORIGEMS, QTEQUALPS, 0, LNCNT, NUMPS, LLNAO, I, LLACHOU, LNVAL, DPROS, FKCHAVES, MERCS, CUNIS, PRODUTOS, REFFS, COMPOS, EMPS, EMPDS, DOPEDS, CONTAOS, CONTADS, LLFILTRA, UNITS, NUMES, MOEVALS, ESTDESTS, LNAGR, GLOBALIZAS, EMPDNPS, NOPERS, LLF, TIPOS, DATAS, DRIVES, SQTDS, DTALTS, DOPCS, SGRUS, UNICOMPOS, GRUPOS, ORDEMS, ICLIS, PESOS, CUNIPS, CESTOQS, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHKSUBN' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, PESOMS, FAIXAPESO, CPROS, CGRUS, EMPGRUESTS, MATS, PROCESSOS, COPIAS, EMPMRCFS, ORIDOPNUMS, COPERS, CIDCHAVES, NUMLOTES, NCHEQUES, NUMS, CIDCONNS, LCCT3, LNGCO, CODBARRAS, CITENS, NDOPES, CODCORS, CODTAMS, CBARS, NOPS, DOPES, OPERS, ORIGEMS, QTEQUALPS, 0, LNCNT, NUMPS, LLNAO, I, LLACHOU, LNVAL, DPROS, FKCHAVES, MERCS, CUNIS, PRODUTOS, REFFS, COMPOS, EMPS, EMPDS, DOPEDS, CONTAOS, CONTADS, LLFILTRA, UNITS, NUMES, MOEVALS, ESTDESTS, LNAGR, GLOBALIZAS, EMPDNPS, NOPERS, LLF, TIPOS, DATAS, DRIVES, SQTDS, DTALTS, DOPCS, SGRUS, UNICOMPOS, GRUPOS, ORDEMS, ICLIS, PESOS, CUNIPS, CESTOQS, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, PESOMS, FAIXAPESO, CPROS, CGRUS, EMPGRUESTS, MATS, PROCESSOS, COPIAS, EMPMRCFS, ORIDOPNUMS, COPERS, CIDCHAVES, NUMLOTES, NCHEQUES, NUMS, CIDCONNS, LCCT3, LNGCO, CODBARRAS, CITENS, NDOPES, CODCORS, CODTAMS, CBARS, NOPS, DOPES, OPERS, ORIGEMS, QTEQUALPS, 0, LNCNT, NUMPS, LLNAO, I, LLACHOU, LNVAL, DPROS, FKCHAVES, MERCS, CUNIS, PRODUTOS, REFFS, COMPOS, EMPS, EMPDS, DOPEDS, CONTAOS, CONTADS, LLFILTRA, UNITS, NUMES, MOEVALS, ESTDESTS, LNAGR, GLOBALIZAS, EMPDNPS, NOPERS, LLF, TIPOS, DATAS, DRIVES, SQTDS, DTALTS, DOPCS, SGRUS, UNICOMPOS, GRUPOS, ORDEMS, ICLIS, PESOS, CUNIPS, CESTOQS, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CLASS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, PESOMS, FAIXAPESO, CPROS, CGRUS, EMPGRUESTS, MATS, PROCESSOS, COPIAS, EMPMRCFS, ORIDOPNUMS, COPERS, CIDCHAVES, NUMLOTES, NCHEQUES, NUMS, CIDCONNS, LCCT3, LNGCO, CODBARRAS, CITENS, NDOPES, CODCORS, CODTAMS, CBARS, NOPS, DOPES, OPERS, ORIGEMS, QTEQUALPS, 0, LNCNT, NUMPS, LLNAO, I, LLACHOU, LNVAL, DPROS, FKCHAVES, MERCS, CUNIS, PRODUTOS, REFFS, COMPOS, EMPS, EMPDS, DOPEDS, CONTAOS, CONTADS, LLFILTRA, UNITS, NUMES, MOEVALS, ESTDESTS, LNAGR, GLOBALIZAS, EMPDNPS, NOPERS, LLF, TIPOS, DATAS, DRIVES, SQTDS, DTALTS, DOPCS, SGRUS, UNICOMPOS, GRUPOS, ORDEMS, ICLIS, PESOS, CUNIPS, CESTOQS, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, PESOMS, FAIXAPESO, CPROS, CGRUS, EMPGRUESTS, MATS, PROCESSOS, COPIAS, EMPMRCFS, ORIDOPNUMS, COPERS, CIDCHAVES, NUMLOTES, NCHEQUES, NUMS, CIDCONNS, LCCT3, LNGCO, CODBARRAS, CITENS, NDOPES, CODCORS, CODTAMS, CBARS, NOPS, DOPES, OPERS, ORIGEMS, QTEQUALPS, 0, LNCNT, NUMPS, LLNAO, I, LLACHOU, LNVAL, DPROS, FKCHAVES, MERCS, CUNIS, PRODUTOS, REFFS, COMPOS, EMPS, EMPDS, DOPEDS, CONTAOS, CONTADS, LLFILTRA, UNITS, NUMES, MOEVALS, ESTDESTS, LNAGR, GLOBALIZAS, EMPDNPS, NOPERS, LLF, TIPOS, DATAS, DRIVES, SQTDS, DTALTS, DOPCS, SGRUS, UNICOMPOS, GRUPOS, ORDEMS, ICLIS, PESOS, CUNIPS, CESTOQS, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COPIADO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, PESOMS, FAIXAPESO, CPROS, CGRUS, EMPGRUESTS, MATS, PROCESSOS, COPIAS, EMPMRCFS, ORIDOPNUMS, COPERS, CIDCHAVES, NUMLOTES, NCHEQUES, NUMS, CIDCONNS, LCCT3, LNGCO, CODBARRAS, CITENS, NDOPES, CODCORS, CODTAMS, CBARS, NOPS, DOPES, OPERS, ORIGEMS, QTEQUALPS, 0, LNCNT, NUMPS, LLNAO, I, LLACHOU, LNVAL, DPROS, FKCHAVES, MERCS, CUNIS, PRODUTOS, REFFS, COMPOS, EMPS, EMPDS, DOPEDS, CONTAOS, CONTADS, LLFILTRA, UNITS, NUMES, MOEVALS, ESTDESTS, LNAGR, GLOBALIZAS, EMPDNPS, NOPERS, LLF, TIPOS, DATAS, DRIVES, SQTDS, DTALTS, DOPCS, SGRUS, UNICOMPOS, GRUPOS, ORDEMS, ICLIS, PESOS, CUNIPS, CESTOQS, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'FPAGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, PESOMS, FAIXAPESO, CPROS, CGRUS, EMPGRUESTS, MATS, PROCESSOS, COPIAS, EMPMRCFS, ORIDOPNUMS, COPERS, CIDCHAVES, NUMLOTES, NCHEQUES, NUMS, CIDCONNS, LCCT3, LNGCO, CODBARRAS, CITENS, NDOPES, CODCORS, CODTAMS, CBARS, NOPS, DOPES, OPERS, ORIGEMS, QTEQUALPS, 0, LNCNT, NUMPS, LLNAO, I, LLACHOU, LNVAL, DPROS, FKCHAVES, MERCS, CUNIS, PRODUTOS, REFFS, COMPOS, EMPS, EMPDS, DOPEDS, CONTAOS, CONTADS, LLFILTRA, UNITS, NUMES, MOEVALS, ESTDESTS, LNAGR, GLOBALIZAS, EMPDNPS, NOPERS, LLF, TIPOS, DATAS, DRIVES, SQTDS, DTALTS, DOPCS, SGRUS, UNICOMPOS, GRUPOS, ORDEMS, ICLIS, PESOS, CUNIPS, CESTOQS, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, PESOMS, FAIXAPESO, CPROS, CGRUS, EMPGRUESTS, MATS, PROCESSOS, COPIAS, EMPMRCFS, ORIDOPNUMS, COPERS, CIDCHAVES, NUMLOTES, NCHEQUES, NUMS, CIDCONNS, LCCT3, LNGCO, CODBARRAS, CITENS, NDOPES, CODCORS, CODTAMS, CBARS, NOPS, DOPES, OPERS, ORIGEMS, QTEQUALPS, 0, LNCNT, NUMPS, LLNAO, I, LLACHOU, LNVAL, DPROS, FKCHAVES, MERCS, CUNIS, PRODUTOS, REFFS, COMPOS, EMPS, EMPDS, DOPEDS, CONTAOS, CONTADS, LLFILTRA, UNITS, NUMES, MOEVALS, ESTDESTS, LNAGR, GLOBALIZAS, EMPDNPS, NOPERS, LLF, TIPOS, DATAS, DRIVES, SQTDS, DTALTS, DOPCS, SGRUS, UNICOMPOS, GRUPOS, ORDEMS, ICLIS, PESOS, CUNIPS, CESTOQS, CODIGOS

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
  DeleteMark = .F.
	Select SigMvCab
		Update SigMvCab ;
	Select SigMvItn
		Update SigMvItn ;
	Select SigMvPar
		Update SigMvPar ;
	lcQuery = [Select Count(1) as Brancos ] + ;
				[From SigMvCab ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpBrancos') < 1)
		lcQuery = [Update SigMvCab ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - TmpBrancos 1)')
	lcQuery = [Select Count(1) as Brancos ] + ;
				[From SigMvItn ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpBrancos') < 1)
		lcQuery = [Update SigMvItn ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - TmpBrancos 2)')
	lcQuery = [Select Count(1) as Brancos ] + ;
				[From SigMvPar ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpBrancos') < 1)
		lcQuery = [Update SigMvPar ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - TmpBrancos 3)')
	Select Top 1 PesoMs ;
	  From &lcCur. ;
		Update &lcCur. ;
	Delete From &lcCur. Where FaixaPeso <> lcFxa
	Update &lcCur. Set FaixaPeso = lcFxa
Select TmpPro1
	lcQuery = [Select CPros, Mats, Compos, Qtds ] + ;
			    [From SigPrCpo ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpCompo') < 1)
	Select TmpCompo
				If Not Seek(lcMat, 'csMatOrigem', 'Mats')
					Insert Into csMatOrigem (Mats, Qtds) Values (lcMat, TmpDesCompo.Qtds)
		Insert Into csMatOrigem (Mats, Qtds) Values ('OURO', TmpPro1.PesoMs)
	lcQuery = [Select '] + lcEmp + lcGru + lcCon + [' as EmpGruEsts, CPros, CGrus ] + ;
				[From SigCdPro ] + ;
	If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, 'csCompoIgual') < 1)
	lcQuery = [Select EmpGruEsts, CPros, cIdChaves ] + ;
				[From SigMvEst ] + ;
	If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, 'csEstIgual') < 1)
	Select a.CPros ;
	  From csCompoIgual a, csEstIgual b ;
		Select CPros ;
		  From csCompoIgual ;
	Select csComEstoque
		Select TmpDesCompo
		Select csMatOrigem
		Select csComEstoque
			Select csMatOrigem
				lcQuery = [Select CPros, Mats, Compos, Qtds, cIdChaves ] + ;
							[From SigPrCpo ] + ;
				If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, 'TmpDesCompo') < 1)
				Select CPros, Iif(Empty(Compos), Mats, Compos) as Mats, Sum(Qtds) as Qtds ;
				  From TmpDesCompo ;
				Select CPros, Mats, Qtds ;
				  From csCompoPro1 ;
			Select [ ] as AGrupar,Sum(MelhorA) as MelhorA, Sum(MelhorB) as MelhorB ;
			  From csMatOrigem ;
				Select csMatOrigem
	Select csMatOrigem
lcQuery = [Select Distinct Emps, Dopes, Codigos, Situas, cIdChaves ] + ;
  			[From SigPcOoI ] + ;
If (ThisForm.poDataMgf.SqlExecute(lcQuery, 'csCpOI') < 1)
	Select Distinct Drives, cIdConns ;
	  From crTodosDestinos ;
		Select Distinct Drives, cIdConns ;
		  From crTodosDestinos ;
		Select csDestinos2
			oProg.Update(.t.)
			lcQryRelX  = [Select * From SigFiRX]
			lcQryRelXT = [Select * From SigFiRXT]
			lcQryMri   = [Select * From SigFiMpi]
			lcQryMrcf  = [Select * From SigFiMpc]
			lcQryLgrfd = [Select * From SigFiGfd]
				lcQuery = [Select * ] + ;
						    [From SigFiRx ] + ;
				If (ThisForm.poDataMgf.SqlExecute(lcQuery, 'csSigFiRX') < 1)
					Select csSigFiRx
						Select csSigFiRx
					 	Insert Into DesRelx From MemVar
							lcQuery = [Delete From SigFiRx Where Copias = ?pNot]
							If (ThisForm.poDataMgf.SqlExecute(lcQuery, '') < 1)
								=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigFiRX)')
							lcQuery = [Update SigFiRX Set Copias = ?pTru Where Copias = ?pNot]
							If (ThisForm.poDataMgf.SqlExecute(lcQuery, '') < 1)
								=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigFiRX)')
				lcQuery = [Select * ] + ;
						    [From SigFiRXT ] + ;
				If (ThisForm.poDataMgf.SqlExecute(lcQuery, 'csSigFiRxT') < 1)
					Select csSigFiRxT
						Select csSigFiRxT
					 	Insert Into DesRelxT From MemVar
							lcQuery = [Delete From SigFiRXT Where Copias = ?pNot]
							If (ThisForm.poDataMgf.SqlExecute(lcQuery, '') < 1)
								=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigFiRXT)')
							lcQuery = [Update SigFiRXT Set Copias = ?pTru Where Copias = ?pNot]
							If (ThisForm.poDataMgf.SqlExecute(lcQuery, '') < 1)
								=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigFiRXT)')
				lcQuery = [Select * ] + ;
						    [From SigFiMpc ] + ;
				If (ThisForm.poDataMgf.SqlExecute(lcQuery, 'csMrcf') < 1)
				Select csMrcf
					lcQuery = [Select * ] + ;
							    [From SigFiMpc ] + ;
					If (ThisForm.poDataFiscal.SqlExecute(lcQuery, 'csTemDest') < 1)
						Delete In csMrcf
					Select csMrcf
						Select csMrcf
					 	Insert Into DesMrcf From MemVar
							lcQuery = [Delete From SigFiMpc Where Copias = ?pNot]
							If (ThisForm.poDataMgf.SqlExecute(lcQuery, '') < 1)
								=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigFiMpc)')
							lcQuery = [Update SigFiMpc Set Copias = ?pTru Where Copias = ?pNot]
							If (ThisForm.poDataMgf.SqlExecute(lcQuery, '') < 1)
								=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigFiMpc)')
				lcQuery = [Select * ] + ;
						    [From SigFiMpi ] + ;
				If (ThisForm.poDataMgf.SqlExecute(lcQuery, 'csMri') < 1)
				Select csMri
					lcQuery = [Select * ] + ;
							    [From SigFiMpi ] + ;
					If (ThisForm.poDataFiscal.SqlExecute(lcQuery, 'csTemDest') < 1)
						Delete In csMri
					Select csMri
						Select csMri
					 	Insert Into DesMri From MemVar
							lcQuery = [Delete From SigFiMpi Where Copias = ?pNot]
							If (ThisForm.poDataMgf.SqlExecute(lcQuery, '') < 1)
								=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigFiMpi)')
							lcQuery = [Update SigFiMpi Set Copias = ?pTru Where Copias = ?pNot]
							If (ThisForm.poDataMgf.SqlExecute(lcQuery, '') < 1)
								=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigFiMpi)')
				lcQuery = [Select * ] + ;
						    [From SigFiGfd ] + ;
				If (ThisForm.poDataMgf.SqlExecute(lcQuery, 'csSigFiGfd') < 1)
					Select csSigFiGfd
						Select csSigFiGfd
					 	Insert Into DesLgrfd From MemVar
							lcQuery = [Delete From SigFiGfd Where Copias = ?pNot]
							If (ThisForm.poDataMgf.SqlExecute(lcQuery, '') < 1)
								=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigFiGfd)')
							lcQuery = [Update SigFiGfd Set Copias = ?pTru Where Copias = ?pNot]
							If (ThisForm.poDataMgf.SqlExecute(lcQuery, '') < 1)
								=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigFiGfd)')
					If Not ThisForm.poDataFiscal.Update('DesRelX')
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesRelX)')
					If Not ThisForm.poDataFiscal.Update('DesRelXT')
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesRelXT)')
					If Not ThisForm.poDataFiscal.Update('DesMri')
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesMri)')
					If Not ThisForm.poDataFiscal.Update('DesMrcf')
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesMrcf)')
					If Not ThisForm.poDataFiscal.Update('DesLgrfd')
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesLgrfd)')
lcQuery = [Select Datas,Cpros,Grupos,Estos,CodCors,CodTams,Emps From SigMvHst Where OriDopNums = ']+_Operacao+[' ]
If (pCnx.SqlExecute(lcQuery, 'CrHis') < 1)
Select CrHis
lcDelete = [Delete From SigMvHst Where OriDopNums = ']+_Operacao+[' ]
If (pCnx.SqlExecute(lcDelete,' ') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvHst)')
lcDelete = [Delete From SigMvCab Where EmpDopNums = ']+_Operacao+[']
If (pCnx.SqlExecute(lcDelete,' ') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvCab)')
lcDelete    = [Delete From SigMvItn Where EmpDopNums = ']+_Operacao+[']
If (pCnx.SqlExecute(lcDelete,' ') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvItn 3)')
lcDelete = [Delete From SigMvIts Where EmpDopNums = ']+_Operacao+[']
If (pCnx.SqlExecute(lcDelete,' ') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvIts)')
lcDelete = [Delete From SigOpEtq Where EmpDopNums = ']+_Operacao+[']
If (pCnx.SqlExecute(lcDelete,' ') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigOpEtq)')
lcDelete = [Delete From SigMvCpv Where EmpDopNums = ']+_Operacao+[']
If (pCnx.SqlExecute(lcDelete,' ') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvCpv)')
lcQuery = [Select * From SigMvCcr Where EmpDopNums = ']+_Operacao+[']
If (pCnx.SqlExecute(lcQuery, 'crMccr') < 1)
Select CrMccr
lcQuery = [Select * From SigMvCcr Where EmpDopNums = ']+_Operacao+[']
If (pCnx.SqlExecute(lcQuery, 'crMccr') < 1)
Select CrMccr
lcDelete = [Delete From SigMvCcr Where EmpDopNums = ']+_Operacao+[']
lnErro = pCnx.SqlExecute(lcDelete,'')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvCcr)')
lcQuery = [Select * From SigMvPar Where EmpDopNums = ']+_Operacao+[']
If (pCnx.SqlExecute(lcQuery, 'CrPar') < 1)
Select crPar
			Select CrPrBx
			=Seek(lcCheque)
				lcUpdate = [UpDate SigCdPbx Set Deposits = ?llDep Where CidChaves = ']+CrPrBx.CidChaves+[']
				lnErro = pCnx.SqlExecute(lcUpDate,'')
					MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigCdPbx 2)')
lcDelete = [Delete From SigMvPar Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvPar)')
lcDelete = [Delete From SigTtCcd Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigTtCcd)')
lcDelete = [Delete From SigCdCmm Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCmm)')
lcQuery = [Select NumLotes From SigChLcq Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcQuery,'CrCheh') < 1
Select CrCheH
		lcDelete = [Delete From SigCheH Where NumLotes = ]+Str(_Lote)
		If pCnx.SqlExecute(lcDelete,'') < 1
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCheH)')
lcDelete = [Delete From SigChLcq Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigChLcq)')
lcQuery = [Select * From SigCqChm Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcQuery,'CrChm') < 1
Select crChm
	lcDelete = [Delete From SigCqChm Where CidChaves = ']+CrChm.cidChaves+[']
	If pCnx.SqlExecute(lcDelete,'') < 1
		MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCqChm)')
	lcWher = [Select * From SigCqChm Where nCheques=']+CrChm.nCheques+[' ]
	lnErro = pCnx.SqlExecute(lcWher,'CrChm2')	
	Select * From CrChm2 where Bancos+Agencias+ncontas+Ncheques=lcCheque And EmpDopNums # _Operacao ;
	lcWher = [Select * From SigChe Where Nums=']+lcNums+[' ]
	lnErro = pCnx.SqlExecute(lcWher,'CrChe')	
	Select crChe
	Seek (lcCheque)
		insert into crSigExChq (agencias,bancos,vencs,ncheques,ncontas,nums,;
		lcDelete = [Delete From SigChe Where Nums = ']+CrChe.Nums+[']
		If pCnx.SqlExecute(lcDelete,'') < 1
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigChe)')
		lcUpDate = [Update SigChe Set Umovs = ']+lcUmovs+[', Numeros=']+lcNumCheques+[', ]+;
		lnErro   = pCnx.SqlExecute(lcUpDate,'')
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigChe)')
		lcQuery = [Select * From SigMvPar Where EmpDopNums = ']+_Operacao+[']
		If pCnx.SqlExecute(lcQuery,'CrPar') < 1
		Select CrPar
				lcUpdate = [Update SigMvPar Set VPags = 0, Pagos = ?lcPago, DtAlts = ?ldDat ] + ;
				If pCnx.SqlExecute(lcUpdate,'') < 1
					MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvPar)')
lcDelete = [Delete From SigCdCar Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCar)')
lcDelete = [Delete From SigCdCtt Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCtt)')
lcDelete = [Delete From SigCdCrd Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCrd)')
lcDelete = [Delete From SigOpDev Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigOpDev 2)')
lcDelete = [Delete From SigMvPec Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvPec)')
lcDelete = [Delete From SigMvMov Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvMov)')
lcDelete = [Delete From SigMvEtv Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvEtv)')
lcDelete = [Delete From SigMvNfi Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvNfi)')
lcDelete = [Delete From SigExMvc Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigExMvc)')
lcDelete = [Delete From SigExMvI Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigExMvI)')
lcDelete = [Delete From SigExMvP Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigExMvP)')
lcDelete = [Delete From SigCdPbx Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdPbx)')
lcDelete = [Delete From SigCqChi Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCqChi)')
lcDelete = [Delete From SigCdCar Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCar)')
lcDelete = [Delete From SigCdCtt Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCtt)')
lcDelete = [Delete From SigCdCrd Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCrd)')
lcDelete = [Delete From SigCdPgc Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdPgc)')
lcDelete = [Delete From SigPrTtl Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigPrTtl)')
lcDelete = [Delete From SigCdPit Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdPit)')
lcDelete = [Delete From SigCdPgr Where EmpDopNums = ']+_Operacao+[']
If pCnx.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdPit)')
Select (lcArqMccr)
lcSql = [Select * From SigCdPac]
pCnx.Sqlexecute(lcSql, [LocalCdPac])
Insert Into (lcArqMccr) (VOpers, NOpers, NLancs, VLancs, Opers, Grupos, Contas, Moedas, Cotacaos, Valors, Emps, Datas, ;
Select csCpOri
	Select * ;
	  From csOperacoes ;
		Select Distinct Processos, Emps, Dopes, Codigos, Drives, cIdConns, EmpDs, DopeDs, TpProdutos, Dias, ;
		  From crTodosDestinos ;
		Select csDestinos
			Select csConexoes && Cursor Com as Conexões Criadas
			Select DesMvCcr
			Select csSelecionados
				lcQuery = [Select a.DopCs, a.ConOrigs, a.ConDests, a.Grupos, a.Contas, a.NDopes, a.COpers, ] + ;
							[From SigCdOpe a, SigOpOpe b ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalTitulo]) < 1)
				lcSql = [Select * From SigCdPac]
				loConexao(ThisForm.lnConexao, 1).Sqlexecute(lcSql, [LocalCdPac])
				Insert Into DesMvCcr (NOpers, VOpers, Docus, Emps, Datas, UsuAlts, DatAlts, Vencs, Hists, Opers, ;
				Select DesMvCcr
				Select DesMvCcr
				lcQuery = [Insert Into SigPcOoL (Tipos, Emps, Dopes, Numes, Empds, Dopeds, Numeds, Datas, Usuars, ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
					If Not loConexao(ThisForm.lnConexao, 1).Update([DesMvCcr])
						=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - DesMvCcr)])
			oSuper.Update(.t.)
	lcQuery = [Select a.CodProds, a.IdeCpros, b.DigAuts ] + ;
			    [From SigCdGrp a, SigCdGpr b ] + ;
	If (pCnx.SqlExecute(lcQuery, 'fGerCodPro_Gru') < 1)
		If Not llTem And Not Seek(lcCpf, 'DesCli', 'Cpfs') And Not Seek(crTmp.IClis, 'DesCli', 'IClis')
			Select crTmp
		 	Insert Into DesCli From MemVar
		If Not llTem And Not Seek(lcCli, 'DesCli', 'Iclis')
			Select crTmp
		 	Insert Into DesCli From MemVar
		Select &pCur.
				Select crTmpO
				Select &pCur.
				Insert Into &pCur. From Memvar
			lcSqlEstPe = [Select a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, ] + ;
			             [From SigMvCab b ] + ;
			             [Left Join SigMvPec a on a.EmpDopNums = b.EmpDopNums ] + ;
			             [Inner Join SigMvItn c on b.EmpDopNums = c.EmpDopNums ] + ;
			             [Left Join SigMvIts d on b.EmpDopNums = d.EmpDopNums And c.Citens = d.Citens ] + ;
					     [Select a.Codigos, a.Emps, a.Dopes, a.Numes, a.Emps As EmpSubns, ] + ;
			             [From SigMvCab b ] + ;
			             [Left Join SigOpDev a on a.EmpDopNums = b.EmpDopNums ] + ;
			             [Inner Join SigMvItn c on b.EmpDopNums = c.EmpDopNums ] + ;
			             [Left Join SigMvIts d on b.EmpDopNums = d.EmpDopNums And c.Citens = d.Citens ] + ;																             
			If (ThisForm.poDataMgr.SqlExecute(lcSqlEstPe, 'crMvPec') < 1)
			Select crMvPec
				If crMvPec.codbarras <> 0 And !Seek(Str(crMvPec.codbarras,14),'crProducao','Cbars') &&crMvPec.Nops <> 0
				lcSqlOpe = [Select Dopes From SigCdOpe Where nDopes = ] + lnDopes
				If Thisform.PoDataMgr.SqlExecute(lcSqlOpe,'crTmpOPe') < 1
				Select crMvPec
			lcQuery = [Select a.EmpOs, a.DopeOs, a.NumeOs, a.Nops, b.codcors, b.codtams, a.Qtds, sum(b.qtds) as TotQtds ] +;
					[from SigOpEtq a Inner Join SigOpPic b On a.Nops = b.Nops And a.CodCors = b.CodCors And a.CodTams = b.CodTams ] +;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crOpEtq') < 1)
				Select crProducao
				=Seek(Str(crOpEtq.Nops,10) + Str(lcCodBarra,14),'crProducao','Nops')
					lcQuery = [Select Emps, Dopes, Numes, Sum(Qtds) as Qtds From SigOpPic ] +;
					loConexao(ThisForm.lnConexao,1).SqlExecute(lcQuery,[TmpDesOp])
					Insert into crProducao(EmpOs, DopeOs, NumeOs, Nops, codcors, codtams, Cbars, QtdOps) Value ;
					Select crProducao
				lcQuery = [Select c.* From SigCdOpe a Inner Join SigOpCdc b On a.Dopes = b.Dopes ] +;
							[Inner Join SigCdOpe c On b.DopeNfs = c.Dopes Where a.Dopes = '] + DesOpe.Dopes + [']
				If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, 'DesOpCdc') < 1)
					Insert Into DesEest (Emps, Empds, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, Contaos, ;
				Insert Into DesEestI(CItens, Emps, Dopes, Numes, CPros, Qtds, Pesos, Cunis, DPros, ;
					Select csDesEstI2
						Insert Into DesEstI2( CItens, CPros, Emps, Dopes, Numes, qtds, QtdEmbs, Pesos, CodCors, CodTams, CodEmbs, EmpDopNums, CidChaves, DtAlts ) ;
					Insert Into DesHis (CodBarras, CodCors, CodTams, CPros, Datars, ;
					Insert Into DesHis (CodBarras, CodCors, CodTams, CPros, Datars, ;
					Select csCompoPro
						Select csCompoPro
						Select CEstoqs From DesGru Where CGrus = csCompoPro.CGrus Into Cursor TmpGru1
						Select csCompoPro						
							lcQuery = [Select Casas, Mercs, CGrus, DPros, CUnis, CUniPs, Varias From SigCdPro Where CPros = '] + lcMtp + [']
							If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, 'csCasas') < 1)
								Select Casas, Mercs, Cgrus, Dpros, CUnis, CUniPs, Varias From DesPro Where CPros = lcMtp Into Cursor csCasas
						Insert Into DesEestI(CItens, Emps, Dopes, Numes, CPros, Qtds, Pesos, Cunis, CuniPs, DPros, ;
							Insert Into DesHis (CodBarras, CodCors, CodTams, CPros, Datars, ;
							Insert Into DesHis (CodBarras, CodCors, CodTams, CPros, Datars, ;
						Select csCompoPro							
		lcQuery = [Select a.*, Case When b.CodBarras is null or b.CodBarras = 0 Then a.CodBarras Else b.CodBarras End as codBarra2s, b.CodCors, b.CodTams ] +;
					[From SigMvItn a Left Join SigMvIts b On a.EmpDopNums = b. EmpDopNums And a.Citens = b.Citens ] +;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvItn') < 1)
		Select crSigMvItn
		Select crSigMvItn
				lcSqlEstPe = [Select a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, ] + ;
				             [From SigMvCab b ] + ;
				             [Left Join SigMvPec a on a.EmpDopNums = b.EmpDopNums ] + ;
				             [Inner Join SigMvItn c on b.EmpDopNums = c.EmpDopNums ] + ;
				             [Left Join SigMvIts d on b.EmpDopNums = d.EmpDopNums And c.Citens = d.Citens ] + ;
						     [Select a.Codigos, a.Emps, a.Dopes, a.Numes, a.Emps As EmpSubns, ] + ;
				             [From SigMvCab b ] + ;
				             [Left Join SigOpDev a on a.EmpDopNums = b.EmpDopNums ] + ;
				             [Inner Join SigMvItn c on b.EmpDopNums = c.EmpDopNums ] + ;
				             [Left Join SigMvIts d on b.EmpDopNums = d.EmpDopNums And c.Citens = d.Citens ] + ;																             
				If (ThisForm.poDataMgr.SqlExecute(lcSqlEstPe, 'crMvPec') < 1)
				Select crMvPec
					If crMvPec.codbarras <> 0 And !Seek(Str(crMvPec.codbarras,14),'crProducao','Cbars') &&crMvPec.Nops <> 0
					lcSqlOpe = [Select Dopes From SigCdOpe Where nDopes = ] + lnDopes
					If Thisform.PoDataMgr.SqlExecute(lcSqlOpe,'crTmpOPe') < 1
					Select crMvPec
				lcQuery = [Select a.EmpOs, a.DopeOs, a.NumeOs, a.Nops, b.codcors, b.codtams, a.Qtds, sum(b.qtds) as TotQtds ] +;
						[from SigOpEtq a Inner Join SigOpPic b On a.Nops = b.Nops And a.CodCors = b.CodCors And a.CodTams = b.CodTams ] +;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crOpEtq') < 1)
					Select crProducao
					=Seek(Str(crOpEtq.Nops,10) + Str(lcCodBarra,14),'crProducao','Nops')
						lcQuery = [Select EmpDNps, Emps, Dopes, Numes, Sum(Qtds) as Qtds From SigOpPic ] +;
						loConexao(ThisForm.lnConexao,1).SqlExecute(lcQuery,[TmpDesOp])
						Insert into crProducao(EmpOs, DopeOs, NumeOs, Nops, codcors, codtams, Cbars, QtdOps) Value ;
						Select crProducao
		Select EmpOs, DopeOs, NumeOs, Nops, Max(QtdOps) as QtdOps, Sum(QtdFinal) as Qtds From crProducao ;
		Select Nops, EmpOs as Emps From crProducao Where 0 = 1 into cursor TmpOpFinal ReadWrite
		Select TmpOps
				Select DopeOs, NumeOs, Codcors, Codtams, EmpOs, Nops, Nops as NewOps, Sum(QtdFinal) as Qtds, Sum(QtdFinal) as NewQtds From crProducao ;
						Select TmpOpFinal
				Select TmpOpFinal
			Select TmpOpFinal
				Select * From TmpOpFinal Into Array laNOps
			Select TmpOpFinal
				lcQuery = [Update b set b.ChkSubn = ?llTrue, b.Lccs = ?llTrue From SigOpPic a Inner Join SigCdNec b On a.EmpDopNops = b.EmpDNps Where a.Nops = ?TmpOpFinal.Nops]
				If loConexao(ThisForm.lnConexao,1).SqlExecute(lcQuery) < 1
	=Seek(TmpPriPro.CGrus, 'crSigCdGrp', 'CGrus')
Select TmpPriPro
			=Seek(TmpPriPro.CGrus + TmpPriPro.SGrus, 'crSigCdPsg', 'CGruCods')
			=Seek(TmpPriPro.CGrus + TmpPriPro.SGrus, 'crSigCdPsg', 'CGruCods')
		Select crSigCdPro
			Select TmpPro
				Select DesPro
		Select TmpPriPro
			Select crSigCdPro
				If Not Seek(m.CPros, 'DesPro', 'CPros')
					Select DesPro && Este Tipo Sempre Atualiza o Produto
			If Not Seek(ThisForm.cPros, 'DesCompo', 'CProMatUni')
			Select crSigCdPro
				Select DesPro
			lcQuery = [Delete From SigPrPrt ] + ;
			If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, '') < 1)
			Select DesEti
				Select crSigOpEtq
					Select DesEti
					Select crSigCdPro
			Select DesEti
				Select TmpPriPro
				Select crSigCdPro
					Select TmpPro
						Select crSigCdPro
						Select DesPro
		Select TmpPro
			Select TmpPro
				Select DesPro
					Select crSigCdPro
						Select DesPro
						If Not Seek(m.CPros, 'DesPro', 'CPros')
		Select crSigCdPro
				Select csGrupos
					lcQuery = [Select a.CGrus, a.CPros, a.DescFis, a.DPros, c.Datas, a.PesoMs, ] + ;
								[From SigCdPro a, SigMvHst c, SigMvEst d ] + ;
					If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, 'csProRef1') < 1)
					Select csProRef1
								Delete
								Select CGrus, CPros, DescFis, DPros, Sqtds, PVens ;
								  From csProRef1 ;
								Select CGrus, CPros, DescFis, DPros, Sqtds, PVens ;
								  From csProRef1 ;
						Select csProRef2
								Delete
						Select Distinct CPros, Padr(DescFis, 255) as DescFis, DPros, Sqtds ;
						  From csProRef2 ;
						Select csProRef
							lcQuery = [Select Top 1 EmpGruEsts, CPros, cIdChaves, Opers, SQtds ] + ;
										[From SigMvHst ] + ;
							If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, 'TmpHis1') < 1)
							Select TmpHis1
									Delete In csProRef
								Delete In csProRef
							Select csProRef
						Select csProRef
							=Seek(csProRef.Cpros, 'csBaixas', 'Cpros')
								Insert Into csBaixas (Cpros) Values (csProRef.Cpros)
						Select csProRef
				lcQuery = [Select Top 1 CPros ] + ;
							[From SigCdPro ] + ;
				If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, 'csTmpPro') < 1)
					lcQuery = [Select Top 1 CPros ] + ;
								[From SigCdPro ] + ;
					If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, 'csTmpPro') < 1)
			Select crSigCdPro
				Select DesPro
				If Not Seek(m.CPros, 'DesPro', 'CPros')
				Insert Into DesPro2 From Memvar
				If Not loConexao(ThisForm.lnConexao, 2).Update('DesPro2')
		Select TmpPro
			Select DesPro
				Select * From DesPro Where CPros = Padr(lcPro, 14) Into Cursor TmpPro
			lcQuery = [Select * ] + ;
					    [From SigCdPro ] + ;
			If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, 'TmpPro') < 1)
			Select TmpPro
				Select * ;
				  From DesPro ;
				Select TmpPro
			Select crSigCdPro
				Select DesPro
				If Not Seek(m.CPros, 'DesPro', 'CPros')
				Select TmpPro
					Select DesPro
						Select * From DesPro Where CPros = Padr(lcPro, 14) Into Cursor TmpPro
				lcQuery = [Select * ] + ;
							[From SigCdPro ] + ;
				If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, 'TmpPro') < 1)
				Select TmpPro
					Select DesPro
						Select * From DesPro Where DPros = Padr(lcPro, 40) Into Cursor TmpPro
				lcQuery = [Select * ] + ;
							[From SigCdPro ] + ;
				If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, 'TmpPro') < 1)
				Select TmpPro
					Select DesPro
						Select * From DesPro Where DPros = Padr(lcPro, 40) And PesoMs = pPes Into Cursor TmpPro
			Select crSigCdPro
				Select DesPro
				If Not Seek(m.CPros, 'DesPro', 'CPros')
	lcQuery = [Select c.nGenerics, b.PesoMs, a.*, b.Mercs ] + ;
			    [From SigPrCpo a ] + ;
			   [Inner Join SigCdPro b On ] + ;
			   [Inner Join SigCdGrp c On ] + ;
	ThisForm.poDataMgr.SQLExecute(lcQuery,[crTmp1])	
	Select crTmp1
		Select CPros, Mats, Max(Cats) as Cats, Max(CGrus) as CGrus, Max(DscGrp) as DscGrp, ;
		  From crTmp1 ;
		Select CPros, Iif(Empty(Compos), Mats, Compos) as Mats, UniCompos, PesoMs, Sum(Qtds) as Qtds, Max(DCompos) as DCompos, ;
		  From crTmp1 a ;
	Select csCompoPro
				Select crTmpCpx1
					If Not Seek(m.CPros, 'DesPro', 'CPros')
						Insert Into DesPro From MemVar
					Select * From DesPro Where Mats = csCompoPro.Mats Into Cursor crTmp2
				Delete In csCompoPro
		lcQuery = [Delete From SigPrCpo Where CPros = '] + Padr(Alltrim(ThisForm.CPros), 14) + [']
		If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (LancaProduto - Delete - SigPrCpo)')
	lcQuery = [Select Mercs, Cgrus, CUnis ] + ;
				[From SigPcOoG ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPcOoG') < 1)
	Select csCompoPro
		If Not Seek(lcProProd + Mats + UniCompos, 'DesCompo', 'CProMatUni')
			lcQuery = [Select cIdChaves ] + ;
						[From SigPrCpo ] + ;
			If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, 'csBusca1') < 1)
				Select csCompoPro
				lcQuery = [Select Casas, Mercs, CGrus, DPros, CUnis, CUniPs, Varias ] + ;
							[From SigCdPro ] + ;
				If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, 'csCasas') < 1)
					Select Casas, Mercs, Cgrus, Dpros, CUnis, CUniPs, Varias From DesPro Where CPros = lcMtp Into Cursor csCasas
					Select crSigPcOoG
				Select DesCompo
				Select crSigPcOoG
lcQuery = [Select * ] + ;
		    [From SigCdPrf ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csFasesProd') < 1)
Select csFasesProd
	If Not Seek(m.Produtos + m.Grupos + Str(m.Ordems, 2), 'DesProF', 'ProGruOrds')
		lcQuery = [Select cIdChaves ] + ;
				    [From SigCdPrf ] + ;
		If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, 'TmpDesProF') < 1)
		Select TmpDesProF
			Select cIdChaves ;
			  From DesProF ;
			Select TmpxDesProF
				Select DesProF
	lcQuery = [Select a.Reffs ] + ;
				[From SigPrFnc a ] + ;
			   [Inner Join SigCdCli b On b.IClis = a.IFors ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPrFnc') < 1)
	=Seek(TmpPriPro.CGrus, 'crSigCdGrp', 'CGrus')
lcQuery = [Select Mercs, Cgrus, CUnis ] + ;
			[From SigPcOoG ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPcOoG') < 1)
Select TmpPriPro
lcQuery = [Select * ] + ;
			[From SigCdPro ] + ;
If (loConexao(ThisForm.lnConexao, 1).SQLExecute(lcQuery, [TmpPro]) < 1)
Select TmpPro
	Select DesPro
		lcSQLCmd = [Select a.CPros ] + ;
					 [From SigSubMv a ] + ;
		If (ThisForm.poDataMgr.SQLExecute(lcSQLCmd, [LocalBusca]) < 1)
			Select LocalBusca
		lcSQLCmd = [Select a.Mats, b.OrdCompos, b.MontaDescs, b.DigiMaxs, b.Casas, d.DGrus, b.Compos, a.Qtds, a.CUnis, ] + ;
					 [From SigSubMv a, SigCdPro b, SigCdPro c, SigCdGrp d ] + ;
		lcSQLCmd = [Select a.Mats, b.OrdCompos, b.MontaDescs, b.DigiMaxs, b.Casas, d.DGrus, b.Compos, a.Qtds, a.UniCompos as CUnis, ] + ;
				 	 [From SigPrCpo a, SigCdPro b, SigCdGrp g, SigCdPro c, SigCdGrp d ] + ;
	If (ThisForm.poDataMgr.SQLExecute(lcSQLCmd, [LocalCompos1]) < 1)
		Select OrdCompos, MontaDescs, DigiMaxs, Casas, DGrus, Compos, CGrus, Mercs, MercCompos, GrupCompos, ;
		  From LocalCompos1 ;
		Select LocalCompos
			Select crTmp2
				Select LocalCompos1
				lcSQLCmd = [Select a.* ] + ;
						 	 [From SigCdPro a ] + ;
				If (ThisForm.poDataMgr.SQLExecute(lcSQLCmd, [crTmp1]) < 1)
				Select crTmp1
					Select crSigPcOoG
				If Not Seek(m.CPros, [DesPro], [CPros])
					Insert Into DesPro From MemVar
					Select crSigPcOoG
			Select crTmpGru
			If Not Seek(Padr(ThisForm.Cpros, 14) + Padr(lcMat, 14) + Padr(LocalCompos.CUnis, 3), [DesCompo], [CProMatUni])
				Insert Into DesCompo (CGrus, CPros, Mats, DCompos, DataTrans, Qtds, UniCompos, Pesos, ;
		Select crTmp
		 	Insert Into DesTabD From MemVar
			Select crTmp
			 	Insert Into DesTabDe From MemVar
Select Dopes ;
  From csOperacoes ;
lcQuery = [Select Distinct Emps, Dopes, Codigos, DopeDs ] + ;
			[From SigPcOoI ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csCpOri') < 1)
Select csCpOri
	Select csCpOri
		Select Emps, Dopes, Numes, Datas, Valos, Notas, Usuars, ContaOs, ContaDs, EmpDs, Deletado ;
		  From csOperacoes ;
			Select Emps, Dopes, EmpDs, DopeDs, Count(*) as Qtd from crTodosDestinos where Processos = lcPro And ;
				Select Emps, Dopes, EmpDs, DopeDs, TpProdutos, GdeGrupos from crTodosDestinos where Emps+Dopes+EmpDs+DopeDs in ;
						(Select Emps+Dopes+EmpDs+DopeDs from crAgrupa) into cursor crTpProds readwrite
				Select crTpProds
				Select a.Emps, a.Dopes, a.EmpDs, a.DopeDs, Max(b.Processos) as Processos, Max(b.Codigos) as Codigos, Max(b.Drives) as Drives, Max(b.cIdConns) as cIdConns,; 
				  From crAgrupa a, crTodosDestinos b ;
		Select Distinct Emps, Dopes, EmpDs, DopeDs, Processos, Codigos, Drives, cIdConns, TpProdutos, Dias, ;
				  From crTodosDestinos ;
				 Where Processos = lcPro And &lcWhere. And Emps+Dopes+EmpDs+DopeDs not in (Select Emps+Dopes+EmpDs+DopeDs from crAgrupa) ;
				Select Distinct Processos, Emps, Dopes, Codigos, Drives, cIdConns, EmpDs, DopeDs, TpProdutos, Dias, ;
				  From crTodosDestinos ;
			Select csDestinos
				Select csConexoes && Cursor Com as Conexões Criadas
						Select DesEti
						Select DesMccr
						Select DesPMccr
							Select DesPdMvf
					Select DesCli
					Select DesPro
					Select DesCompo
					Select DesProF
					Select csSelecionados
								lcQuery = [Delete From SigPcOoL Where EmpDopNums = '] + lcEDNs + [']
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigPcOoL)')
							lcQuery = [Insert Into SigPcOoL (Tipos, Emps, Dopes, Numes, Empds, ] + ;
							If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
							Insert Into csImpressao (Processos, Drives, Datas, Emps, Emps1, Dopes, ;
							Select csSelecionados
							lcQuery = [Select a.CPros, a.CUnis, a.Opers, a.Qtds, a.Pesos, a.Units, p.CGrus, a.cIdChaves ] + ;
										[From SigMvItn a, SigMvCab d, SigCdPro p ] + ;
							If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csTemProduto') < 1)
								Select csTemProduto
										If Seek(csDestinos.Emps+csDestinos.Dopes+csDestinos.EmpDs+csDestinos.DopeDs,[crTpProds],[skGroup1])
										=Seek(csTemProduto.CGrus, 'crSigCdGrp', 'CGrus')
										Delete In csTemProduto
								=Seek(csTemProduto.CGrus, 'crSigCdGrp', 'CGrus')
								If Seek(csDestinos.Emps+csDestinos.Dopes+csDestinos.EmpDs+csDestinos.DopeDs+crSigCdGrp.Mercs,[crTpProds],[skGroup1])
							Select csTemProduto
										Select crSigMvCab
											If Seek(lcChave+csDestinos.DopeDs,[crTransferidos],[skGroup2])
											If Seek(lcChave+csDestinos.EmpDs+csDestinos.DopeDs,[crTransferidos],[skGroup1])
											Insert into crTransferidos(EmpDopNums,EmpDs,DopeDs,NumDs) Values(lcChave,csDestinos.EmpDs,csDestinos.DopeDs,lnNumes)
												Select DesEest
													lcQuery = [Delete From SigPcOoL Where EmpDopNums = '] + lcEDNs + [']
													If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
														=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigPcOoL)')
												lcQuery = [Insert Into SigPcOoL (Tipos, Emps, Dopes, Numes, Empds, ] + ;
												If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
												Insert Into csImpressao (Processos, Drives, Datas, Emps, Emps1, Dopes, ;
										lcQuery = [Select * ] + ;
												    [From SigMvNfi ] + ;
										If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvNfi') < 1)
										Select crSigMvNfi
											Select DesNFis
											Select *, CItens as AntCItens ;
											  From DesEstI2 ;
											Select csDesEstI2
										Select *, Emps as AntEmps, Numes as AntNumes, Notas as AntNotas, ;
										  From DesEestI ;
										Select csDesEestI
										lcQuery = [Select * ] + ;
												    [From SigMvItn ] + ;
										If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvItn') < 1)
											Select CPros, Sum(1) as Linhas, Sum(Units) as Units ;
											  From crSigMvItn ;
											Select crSigMvItn
													Delete In crSigMvItn
											Delete From DesEest Where Emps = lcEmpDs And Dopes = csDestinos.DopeDs And Numes = lnNumes
											Delete From DesNFis Where Emps = lcEmpDs And Dopes = csDestinos.DopeDs And Numes = lnNumes
											lcQuery = [Select EmpDopNums, Sum(1) as Total ] + ;
														[From SigMvItn ] + ;
											If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csQtdeEsstI') < 1)
											Select crSigMvItn
													If Seek(csDestinos.Emps+csDestinos.Dopes+csDestinos.EmpDs+csDestinos.DopeDs,[crTpProds],[skGroup1])
													=Seek(crSigCdPro.CGrus, 'crSigCdGrp', 'CGrus')
													oInfer.Update(.t.)
														lcQuery = [Select * ] + ;
																    [From SigMvIts ] + ;
														If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvIts') < 1)
														=Seek(crSigCdPro.CGrus, 'crSigCdGrp', 'CGrus')
															If Seek(csDestinos.Emps+csDestinos.Dopes+csDestinos.EmpDs+csDestinos.DopeDs+crSigCdGrp.Mercs,[crTpProds],[skGroup1])
														=Seek(crSigCdPro.CGrus, 'crSigCdGrp', 'CGrus')
															Select crSigOpEtq
																Select DesEti
																Select DesEti
														lcQuery = [Select * ] + ;
																    [From SigMvIts ] + ;
														If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvIts') < 1)
															Select crSigMvIts
														Select crSigMvIts
															Select csDesEstI2
														Select crSigMvItn
															lcQuery = [Select Cpros, OrdCompos, Mats, Compos, Qtds, Pesos ] + ;
																	    [From SigPrCpo ] + ;
															If (loConexao(ThisForm.lnConexao, 1).SqlExecute(lcQuery, 'TmpCompo') < 1)
															Select TmpCompo
																	Select TmpPro1
														Select csDesEestI
														If llAgrupado And Seek(Padr(ThisForm.CPros, 14), 'csDesEestI', 'CPros')
																	Select crValAgrupas
																Select csDesEestI
																Select crValAgrupas
															Select csDesEestI
															lcQuery = [Select Mercs, Cgrus, CUnis ] + ;
																		[From SigPcOoG ] + ;
															If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPcOoG') < 1)
																Select csDesEstI2
											Select DesPro
												Select csDesEestI
													Select PesoMs, CUnis ;
													  From DesPro ;
													Select DesEestI
													loConexao(ThisForm.lnConexao, 1).Update('DesTabDe')
														Select csDesEstI2
																Select DesEstI2
													Insert Into csImpressao (Processos, Drives, Datas, Emps, Emps1, Dopes, Numes, ;
														Select CGrus From DesPro Where CPros = DesEestI.CPros Into Cursor TmpPro1
														Select CEstoqs From DesGru Where CGrus = TmpPro1.CGrus Into Cursor TmpGru1
																Insert Into DesHis (CodBarras, CodCors, CodTams, CPros, Datars, ;
																Insert Into DesHis (CodBarras, CodCors, CodTams, CPros, Datars, ;
														lcQuery = [Select * From SigOpPic Where EmpDopNums = '] + lcChave + [' And CItens = ] + Str(CsDesEestI.CItens, 4) + [ Order By cIdChaves]
														If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crOpPic') < 1)
															Select crOpPic
																Select crOpPic
																Select DesOpPic
															Select DesPdMvf
															=Seek(lcEmpDs + m.Dopps + Str(m.Numps,10),'DesPdMvf','EmpDNps')
																lcQuery = [Select top 1 * From SigPdMvf Where Nops = ?lnNop Order By cIdChaves]
																If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crPdMvf') < 1)
																Select crPdMvf
																Select DesPdMvf
																lcQuery = [Select * From SigCdNec Where EmpDNps = ?crPdMvf.EmpDNps Order By cIdChaves]															
																If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crCdNec') < 1)
																Select crCdNec
																Select DesCdNec
																lcQuery = [Select * From SigCdNei Where EmpDNps = ?crPdMvf.EmpDNps Order By cIdChaves]															
																If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crCdNei') < 1)
																Select crCdNei
																	Select DesCdNei
													Select CsDesEestI													
												Select DesNfis
												Select DesEestI
												Update DesEestI ;
												Select DesNfis
									lcQuery = [Select *, 0000000 as nOperOrig ] + ;
											    [From SigMvPar ] + ;
									If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csPar') < 1)
									Select csPar
										Select csPar
										If Seek(m.Nopers,'LocalCopNp','Nopers')
											Insert Into LocalCopNp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
											Insert Into CrSigPcOnp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
										Select DesPar
										Select DesPar
								lcQuery = [Select * ] + ;
										    [From SigMvMov ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csEstMo') < 1)
									Select csEstMo
										Select csEstMo
										Select DesEstMo
										Select DesEstMo
								lcQuery = [Select * ] + ;
										    [From SigCdCmm ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csComis') < 1)
									Select csComis
										Select csComis
										Select DesComis
										Select DesComis
									lcQuery = [Select * ] + ;
												[From SigMvCcr ] + ;
									If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csMccr') < 1)
										Select csMccr
											Select DesMccr
												Select cspar
													If Seek(CsMccr.Nopers,'LocalCopNp','Nopers')
														Insert Into LocalCopNp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
														Insert Into CrSigPcOnp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
													Insert into csPar (nOpers, nOperOrig ) Values (CsMccr.Nopers, lnNoper)
												If Seek(CsMccr.Nopers,'LocalCopNp','Nopers')
													Insert Into LocalCopNp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
													Insert Into CrSigPcOnp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
												Insert Into csPar (Nopers, nOperOrig ) Values (csMccr.Nopers, lnNoper)
											Select DesMccr
											Select DesMccr
											Select DesMccr
									lcQuery = [Select * ] + ;
												[From SigMvCpv ] + ;
									If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csPMccr') < 1)
										Select csPMccr
											Select DesPMccr
												Select cspar
													If Seek(CsPMccr.Nopers,'LocalCopNp','Nopers')
														Insert Into LocalCopNp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
														Insert Into CrSigPcOnp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
													Insert into csPar (nOpers, nOperOrig ) Values (CspMccr.Nopers, lnNoper)
												If Seek(CspMccr.Nopers,'LocalCopNp','Nopers')
													Insert Into LocalCopNp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
													Insert Into CrSigPcOnp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
												Insert Into csPar (Nopers, nOperOrig ) Values (cspMccr.Nopers, lnNoper)
											Select DesPMccr
									lcQuery = [Select * ] + ;
												[From SigChLcq ] + ;
									If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpLChm') < 1)
										Select TmpLChm
											Select DesLChm
										lcQuery = [Select * ] + ;
													[From SigCqChm ] + ;
										If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpChm') < 1)
											Select TmpChm
												Select DesChm
												lcQuery = [Select * ] + ;
															[From SigChe ] + ;
												If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpChe') < 1)
													Select TmpChe
														Select DesChe
									lcQuery = [Select * ] + ;
												[From SigCqChi ] + ;
									If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpChI') < 1)
										Select TmpChi
											Select DesChI
								lcQuery = [Select * ] + ;
										    [From SigCdCar ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csCar') < 1)
									Select csCar
										Select csCar
										Select DesCar
										Select DesCar
								lcQuery = [Select * ] + ;
										    [From SigCdCtt ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csCart') < 1)
									Select csCart
										Select csCart
										Select DesCart
										Select DesCart
								lcQuery = [Select * ] + ;
										    [From SigCdCrd ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csCard') < 1)
									Select csCard
										Select csCard
										Select DesCard
										Select DesCar
								lcQuery = [Select * ] + ;
										    [From SigCdPgc ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csPgcli') < 1)
									Select csPgCli
										Select csPgCli
										Select DesPgcli
										Select DesPgCli
								lcQuery = [Select * ] + ;
										    [From SigPrTtl ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csPrTot') < 1)
									Select csPrTot
										Select csPrTot
										Select DesPrTot
										Select DesPrTot
								lcQuery = [Select * ] + ;
										    [From SigCdPit ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csPrit') < 1)
										Select csPrit
											lcQuery = [Select * ] + ;
													    [From SigMvCcr ] + ;
											If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csMccr') < 1)
											Select CsMccr
												If Seek(CsMccr.Nopers,'LocalCopNp','Nopers')
													If Seek(Str(lnNoper,7)+CsMccr.Opers,'DesMccr','Nopers') Or Seek(Str(lnNoper,7)+CsMccr.Opers,'DesPMccr','Nopers')
													lcSql = [Select cidchaves,grupos,Contas,Datas,Moedas,sgrupos,scontas,smoedas From SigMvCcr Where Nopers = ]+Str(lnNoper)
													If (loConexao(ThisForm.lnConexao, 1).sqlexecute(lcSql,'LocalMccr') ) < 1
													Select LocalMccr
														lcSql = [delete From SigMvCcr Where cidchaves = ']+LocalMccr.Cidchaves+[']
														If (loConexao(ThisForm.lnConexao, 1).sqlexecute(lcSql,' ') ) < 1
															=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (delete From SigMvCcr)')
												Select CsMccr
												Select DesMccr
													Select cspar
														If Seek(CsMccr.Nopers,'LocalCopNp','Nopers')
															Insert Into LocalCopNp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
															Insert Into CrSigPcOnp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
														Insert into csPar (nOpers, nOperOrig ) Values (CsMccr.Nopers, lnNoper)
													If Seek(CsMccr.Nopers,'LocalCopNp','Nopers')
														Insert Into LocalCopNp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
														Insert Into CrSigPcOnp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
													Insert Into csPar (Nopers, nOperOrig ) Values (csMccr.Nopers, lnNoper)
												Select DesMccr
												Select DesMccr
											lcQuery = [Select * ] + ;
														[From SigMvCpv ] + ;
											If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csPMccr') < 1)
											Select csPMccr
												If Seek(CspMccr.Nopers,'LocalCopNp','Nopers')
													If Seek(Str(lnNoper,7)+CsMccr.Opers,'DesMccr','Nopers') Or Seek(str(lnNoper,7)+CsMccr.Opers,'DesPMccr','Nopers')
													lcSql = [Delete From SigMvCpv Where Nopers = ]+Str(lnNoper)
													If (loConexao(ThisForm.lnConexao, 1).sqlexecute(lcSql,' ') ) < 1
														=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvCpv)')
												Select DesPMccr
													Select cspar
														If Seek(CsPMccr.Nopers,'LocalCopNp','Nopers')
															Insert Into LocalCopNp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
															Insert Into CrSigPcOnp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
														Insert into csPar (nOpers, nOperOrig ) Values (CspMccr.Nopers, lnNoper)
													If Seek(CspMccr.Nopers,'LocalCopNp','Nopers')
														Insert Into LocalCopNp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
														Insert Into CrSigPcOnp (NoperOrigs, nOperNews, Cidchaves, EmpDopNums ) Values ;
													Insert Into csPar (Nopers, nOperOrig ) Values (cspMccr.Nopers, lnNoper)
												Select DesPMccr
									Select csPrit
										Select csPrit
										Select DesPrit
										If Seek(m.Nopers,'LocalCopNp','Nopers')
										Select DesPrit
								lcQuery = [Select * ] + ;
										    [From SigCdPbx ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csPrBx') < 1)
									Select csPrBx
										Select csPrBx
										Select DesPrBx
										If Seek(m.Nopers,'LocalCopNp','Nopers')
										Select DesPrBx
								lcQuery = [Select * ] + ;
										    [From SigCdPgr ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csPgRec') < 1)
									Select csPgRec
										Select csPgRec
										Select DesPgRec
										Select DesPgRec
								lcQuery = [Select * ] + ;
										    [From SigExMvc ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csDelet') < 1)
									Select csDelet
										Select DesDelet
										Select DesDelet
											lcQuery = [Select * ] + ;
													    [From SigExMvI ] + ;
											If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csDelI') < 1)
											Select csDelI
												Select csDelI
												Select DesDelI
													=Seek(crSigCdPro.CGrus, 'crSigCdGrp', 'CGrus')
													If Seek(csDestinos.Emps+csDestinos.Dopes+csDestinos.EmpDs+csDestinos.DopeDs+crSigCdGrp.Mercs,[crTpProds],[skGroup1])
													Select DesDelI
												Insert Into csImpressao (Processos, Drives, Datas, Emps, Emps1, Dopes, ;
											lcQuery = [Select * ] + ;
													    [From SigExMvP ] + ;
											If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csDelP') < 1)
											Select csDelP
												Select csDelP
												Select DesDelP
												Select DesDelP
											lcQuery = [Select * ] + ;
													    [From SigMvNfi ] + ;
											If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvNfi') < 1)
											Select crSigMvNfi
											Select DesNFis
										lcQuery = [Delete From SigPcOoL Where EmpDopNums = '] + lcEDNs + [']
										If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
											=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigPcOoL)')
									lcQuery = [Insert Into SigPcOoL (Tipos, Emps, Dopes, Numes, Empds, ] + ;
									If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
									Insert Into csImpressao (Processos, Drives, Datas, Emps, Emps1, Dopes, ;
							If Not Seek(lcChave, 'csApagarOri', 'Chave')
								Insert Into csApagarOri (Chave) Values (lcChave)
							Select Min(Datas) as Datas From DesEest Into Cursor TmpGdm
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesEest')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesEest)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesEestI')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesEestI)')
									If Not loConexao(ThisForm.lnConexao, 1).Update('DesEstI2')
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesEstI2)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesNFis')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesNFis)')
									Update DesMccr  Set EspecieNFs = DesNFis.EspecieNfs
									Update DesPMccr Set EspecieNFs = DesNFis.EspecieNfs
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesHis')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesHis)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesPar')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesPar)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesEstMo')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesEstMo)')
								If not loConexao(ThisForm.lnConexao,1).Update('DesComis')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesComis)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesCompo')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesCompo)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesMoe')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesMoe)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesUni')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesUni)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesLin')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesLin)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesCli')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesCli)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesCol')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesCol)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesGru')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesGru)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesTabD')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesTabD)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesTabDe')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesTabDe)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesLPre')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesLPre)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesGccr')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesGccr)')
									If Not loConexao(ThisForm.lnConexao, 1).Update('DesEti')
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesEti)')
									If Not loConexao(ThisForm.lnConexao, 1).Update('DesDelet')
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesDelet)')
									If Not loConexao(ThisForm.lnConexao, 1).Update('DesDelI')
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesDelI)')
									If Not loConexao(ThisForm.lnConexao, 1).Update('DesDelP')
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesDelP)')
									If Not loConexao(ThisForm.lnConexao, 1).Update('DesMccr')
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesMccr)')
									If Not loConexao(ThisForm.lnConexao, 1).Update('DesPMccr')
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesPMccr)')
									If Not loConexao(ThisForm.lnConexao, 1).Update('DesChe')
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesChe)')
									If Not loConexao(ThisForm.lnConexao, 1).Update('DesChm')
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesChm)')
									If Not loConexao(ThisForm.lnConexao, 1).Update('DesLChm')
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesLChm)')
									If Not loConexao(ThisForm.lnConexao, 1).Update('DesChi')
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesChi)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesPro')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesProF')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesProF)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesPrBx')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesPrBx)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesCar')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesCar)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesCart')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesCart)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesCard')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesCard)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesPgCli')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesPgCli)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesPrTot')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesPrTot)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesPrit')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesPrit)')
								If Not loConexao(ThisForm.lnConexao, 1).Update('DesPgRec')
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesPgRec)')
									If Not loConexao(ThisForm.lnConexao, 1).Update('DesOpPic')
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesOpPic)')
									If Not loConexao(ThisForm.lnConexao, 1).Update('DesCdNec')
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesCdNec)')
									If Not loConexao(ThisForm.lnConexao, 1).Update('DesCdNei')
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesCdNei)')
									If Not loConexao(ThisForm.lnConexao, 1).Update('DesPdMvf')
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesPdMvf)')
						lcQuery = [Select * ] + ;
								    [From SigOpLog ] + ;
						If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csSigOpLog') < 1)
							Select csSigOpLog
								Select csSigOpLog
							 	Insert Into DesLog From MemVar
									lcQuery = [Delete From SigOpLog Where Copias = ?pNot]
									If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigOpLog)')
									lcQuery = [Update SigOpLog Set Copias = ?pTru Where Copias = ?pNot]
									If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
										=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigOpLog)')
							If Not loConexao(ThisForm.lnConexao, 1).Update('DesLog')
								=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesLog)')
				oSuper.Update(.t.)
		If Not ThisForm.PodataMgr.Update('CrSigPcOnp')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigPcOnp)')
			Select csApagarOri
					lcQuery = [Select Grupos, Contas, Datas, Moedas, cIdChaves, SGrupos, SContas, SMoedas ] + ;
							    [From SigMvCcr ] + ;
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csMccr') < 1)
						Select csMccr
						lcQuery = [Delete From SigMvCcr Where EmpDopNums = '] + lcChave + [']
						If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
							=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigMvCcr)')
						lcQuery = [Delete From SigMvCpv Where EmpDopNums = '] + lcChave + [']
						If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
							=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigMvCpv)')
					lcQuery = [Delete From SigOpEtq Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigOpEtq)')
					lcQuery = [Delete From SigMvNfi Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigMvNfi)')
					lcQuery = [Delete From SigMvIts Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigMvIts)')
					lcQuery = [Delete From SigExMvc Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigExMvc)')
					lcQuery = [Delete From SigMvCab Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigMvCab)')
					lcQuery = [Delete From SigMvItn Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigMvItn)')
					lcQuery = [Delete From SigMvPar Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigMvPar)')
					lcQuery = [Delete From SigMvMov Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigMvMov)')
					lcQuery = [Delete From SigCdCmm Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigCdCmm)')
					lcQuery = [Delete From SigCdPbx Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigCdPbx)')
					lcQuery = [Delete From SigCdCar Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigCdCar)')
					lcQuery = [Delete From SigCdCtt Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigCdCtt)')
					lcQuery = [Delete From SigCdCrd Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigCdCrd)')
					lcQuery = [Delete From SigCdPgc Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigCdPgc)')
					lcQuery = [Delete From SigPrTtl Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigPrTtl)')
					lcQuery = [Delete From SigCdPit Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigCdPit)')
					lcQuery = [Delete From SigCdPgr Where EmpDopNums = '] + lcChave + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigCdPgr)')
				Select csImpressao
lcQuery = [Select Distinct Emps, Dopes, Codigos, Situas, Delets, cIdChaves, Globalizas ] + ;
  			[From SigPcOoI ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csCpOI') < 1)
Select csCpOI
	oProg.Update(.t.)
	lcQuery = [Select a.Emps, a.Dopes, a.Numes, ] + Iif(lnChk = 3, [a.DtBaixas], [a.Datas]) + [ as Datas, ] + ;
				[From SigMvCab a, SigCdEmp b ] + ;
			   		 [In (Select b.EmpDopNums ] + ;
		 	  		  	   [From SigPcOoL b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csDados2') < 1)
	Select csDados2
		If Not Seek(csDados2.Emps + csDados2.Dopes + Str(csDados2.Numes, 6), [csDados], [EmpDopNums])
			Insert Into csDados (Emps, Dopes, Numes, Datas, Valos, Notas, Usuars, ContaOs, ContaDs, EmpDs) ;
		lcQuery = [Select a.Emps, a.Dopes, a.Numes, a.Datas, a.Valos, a.Notas, a.Usuars, a.ContaOs, a.ContaDs, a.EmpDs ] + ;
					[From SigExMvc a, SigCdEmp b ] + ;
				   		 [In (Select b.EmpDopNums ] + ;
			 	  		  	   [From SigPcOoL b ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csDados2') < 1)
		Select csDados2
			If Not Seek(csDados2.Emps + csDados2.Dopes + Str(csDados2.Numes, 6), [csDados], [EmpDopNums])
				Insert Into csDados (Emps, Dopes, Numes, Datas, Valos, Notas, Usuars, ContaOs, ContaDs, EmpDs, Deletado) ;
Select crSigCdAcE
	Select csDados
		If Not Seek(csDados.Emps, 'crSigCdAcE', 'Emps')	
			Delete In csDados
		Select csDestinos
			oProg.Update(.t.)
				lcQuery = [Select * ] + ;
						    [From SigOpLog ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csSigOpLogs') < 1)
					Select csSigOpLogs
						Select csSigOpLogs
					 	Insert Into DesLog From MemVar
							lcQuery = [Delete From SigOpLog Where Copias = ?pNot]
							If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
								=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigOpLog)')
							lcQuery = [Update SigOpLog Set Copias = ?pTru Where Copias = ?pNot]
							If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
								=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigOpLog)')
					If Not ThisForm.poDataLogs.Update('DesLog')
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - DesLog)')
Select csDados
	oProg.Update(.t.)
	Insert Into csOperacoes (SelImp, Emps, Dopes, Numes, Datas, Valos, Notas, Usuars, ContaOs, ContaDs, EmpDs, Deletado) ;
Select csOperacoes
Select csOperacoes
	Select LocalCopNp
	Select crSigCdPsg
	Select crSigCdGrp
	lcQuery = [Select Distinct Processos, Emps, Dopes, Codigos, cIdChaves ] + ;
				[From SigPcOoI ] + ;
	If (.poDataMgr.SqlExecute(lcQuery, 'csOrigens') < 1)
	Select csOrigens
			Delete In csOrigens
	Select Distinct Processos ;
	  From csOrigens ;
	Select csProcessos
	lcQuery = [Select b.Processos, b.Emps, b.Dopes, b.Codigos, b.EmpDs, b.DopeDs, b.TpProdutos, b.Dias, ] + ;
				[From SigPcOoI b, SigCdLoc c ] + ;
	If (.poDataMgr.SqlExecute(lcQuery, 'crTodosDestinos') < 1)
SELECT * from crTodosDestinos into cursor csdestinos 
	.DeleteMark   	   = .f.
	.Column1.ControlSource = 'csOperacoes.SelImp'
	.Column2.ControlSource  = 'csOperacoes.Numes'
	.Column3.ControlSource  = 'csOperacoes.Datas'
	.Column4.ControlSource  = 'csOperacoes.Valos'
	.Column5.ControlSource  = 'csOperacoes.Notas'
	.Column6.ControlSource  = 'csOperacoes.Usuars'
	.Column7.ControlSource  = 'csOperacoes.ContaOs'
	.Column8.ControlSource  = 'csOperacoes.ContaDs'
	.Column9.ControlSource  = 'csOperacoes.Emps'
	.Column10.ControlSource = 'csOperacoes.EmpDs'
	.Column11.ControlSource = 'csOperacoes.Dopes'
		Select csOperacoes
		Select csOperacoes
	Select csOperacoes
Select csOperacoes
	Select SelImp, Count(1) as Selecionados ;
	  From csOperacoes ;
		Select Distinct Drives, cIdConns ;
		  From crTodosDestinos ;
		Select csConexoes && Criando As Conexões
			Select csConexoes && Fechando as Conexões
		Select csConexoes && Fechando as Conexões

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoppop.prg) - TRECHOS RELEVANTES PARA PASS SQL (2486 linhas total):

*-- Linhas 57 a 78:
57: * cmg_4c_CmdBtnGrade (equivalente a cmdBtnGrade - Selecionar Tudo/
58: * Desmarcar/Documentos) + o funil CarregarLista() ligado a
59: * this_oBusinessObject.this_cCursorOperacoes (cursor_4c_Operacoes).
60: * Mapeamento das 10 colunas de dado (dump nao declara ControlSource
61: * explicito - GrdOperacoes e um Grid nativo sem metodo de bind no
62: * trecho de codigo disponivel; inferido pelos ToolTipText de cada
63: * Column.Text1 do dump, casando contra o CREATE CURSOR do legado -
64: * csOperacoes - citado em comportamento.json): Codigo->Numes,
65: * Data->Datas, Valor->Valos, Documento->Notas, Usuario->Usuars,
66: * Origem->ContaOs, Destino->ContaDs, Orig.->Emps, Dest.->EmpDs,
67: * Movimentacao->Dopes (mais largo - 242px - compativel com Dopes
68: * char(20)). O cursor so e POPULADO pelo Selecionar() do legado
69: * (cntOperacoes.cmdSelecionar.Valid), nao no Init - nesta fase o
70: * cursor_4c_Operacoes nasce vazio (casca) e CarregarLista() so
71: * faz o bind/repintura (regra #21 - popular cursor NAO repinta a
72: * grade); Selecionar() entra na Fase 7/8 e reusa este mesmo metodo
73: * para repintar depois de popular.
74: *
75: * FASE 5/8 - CAMPOS PRINCIPAIS (PARTE 1) - esta fase: cnt_4c_Operacoes
76: * (equivalente a cntOperacoes do dump) com lbl_4c_TituloOperacoes
77: * (titulo em negrito "Operacoes" - Label1 do dump), obj_4c_OptProcessados
78: * (OptionGroup "Nao Processadas"/"Ja Processadas" - 2 botoes, INDICE,

*-- Linhas 122 a 140:
122: * VerificarAcessoEmpresa (modo CHECK, 2 args, sem UI), que nao se
123: * aplica aqui porque o legado preenche os DOIS textboxes a partir do
124: * picker. BINDEVENT em "KeyPress" com par_nKeyCode testado (F4=115
125: * abre o picker direto; Enter=13/Tab=9 fazem o SELECT exato e so
126: * abrem o picker em caso de miss) - regra CLAUDE.md #47, handler
127: * TESTA a tecla, entao KeyPress eh legitimo (nao precisa LostFocus
128: * nem guarda de reentrancia, que so vale para handler ligado a
129: * LostFocus). Pares: ValidarEmpOs/AbrirBuscaEmpOs (Cemps) +
130: * ValidarDEmpOs/AbrirBuscaDEmpOs (Razas, so ativo quando EmpOs esta
131: * vazio - When do dump) para Origem; ValidarEmpDs/AbrirBuscaEmpDs +
132: * ValidarDEmpDs/AbrirBuscaDEmpDs para Destino, mesmo padrao.
133: *
134: * FASE 7/8 (esta fase) - EVENTOS: BINDEVENT dos Click de cmg_4c_
135: * CmdBtnForm (btnLimpar/btnCopiar/btnSair - equivalentes a
136: * LimpaSelecao()/Processamento()/Release do legado, dump:
137: * sigoppop_form_codigo_fonte.txt:10809-10897) e de cmg_4c_CmdBtnGrade
138: * (btnMarcaTudo/btnDesmarcar/btnDocumentos, dump:10488-10513), Click
139: * de cmd_4c_CmdSelecionar (equivalente ao Valid legado "ThisForm.
140: * Selecionar()", dump:10713-10715 - migrado para "Click", que e o

*-- Linhas 541 a 594:
541: 
542:     *====================================================================
543:     * ConfigurarGrid - cria o cursor (casca) da grade de operacoes
544:     * candidatas (equivalente ao "Create Cursor csOperacoes" do Init
545:     * legado - regra OPERACIONAL #4: SET NULL ON antes do CREATE
546:     * CURSOR, pois os valores reais virao de SQLEXEC no Selecionar() da
547:     * Fase 7/8) e o container+Grid que a exibem (cnt_4c_Grade/
548:     * grd_4c_Dados, nomes conforme mapeamento.json).
549:     *
550:     * ORDEM OBRIGATORIA (regra "grid_autobind_area_corrente_quebra_
551:     * addobject_checkbox"): um Grid SEM RecordSource ainda atribuida
552:     * auto-binda sozinho ao alias CORRENTE no instante em que
553:     * ColumnCount e definido - e se a coluna que vai receber o
554:     * Column.AddObject("Check1","CheckBox") cair, por acaso, numa
555:     * coluna CHARACTER dessa auto-bind, o AddObject estoura "Data type
556:     * mismatch" DENTRO de si mesmo (CheckBox.Value nasce NUMERICO).
557:     * Por isso RecordSource + ControlSource de TODAS as colunas e
558:     * aplicado ANTES do AddObject do Check1 - nunca depois. ColumnCount
559:     * e fixado AQUI, UMA UNICA VEZ (regra "SOREDUZIRColumn" -
560:     * reatribuir ColumnCount recria as colunas e destroi o Check1).
561:     * CarregarLista() so REBINDA (RecordSource/ControlSource/Width/
562:     * Header1.Caption, que o RecordSource RESETA a cada chamada - regra
563:     * "Problema 48"), sem tocar no AddObject.
564:     *
565:     * Colunas 1 a 11 (Width/ToolTipText/FontName/FontSize transcritos
566:     * do dump): Column1 = Check1 (marcacao, regra #18 - AddObject +
567:     * CurrentControl + Sparse); Columns 2-11 = Text1 de exibicao
568:     * (Codigo/Data/Valor/Documento/Usuario/Origem/Destino/Orig./Dest./
569:     * Movimentacao).
570:     *====================================================================
571:     PROTECTED PROCEDURE ConfigurarGrid()
572:         LOCAL loc_cCursor, loc_oGrid, loc_nCol, loc_oColuna, loc_oErro
573: 
574:         loc_cCursor = THIS.this_cCursorOperacoes
575: 
576:         TRY
577:             IF !USED(loc_cCursor)
578:                 SET NULL ON
579:                 CREATE CURSOR (loc_cCursor) ;
580:                     (SelImp L NULL, Emps C(3) NULL, Dopes C(20) NULL, ;
581:                      Numes N(6, 0) NULL, Datas D NULL, Valos N(12, 2) NULL, ;
582:                      Notas C(10) NULL, Usuars C(10) NULL, ContaOs C(10) NULL, ;
583:                      ContaDs C(10) NULL, EmpDs C(3) NULL, Deletado L NULL)
584:                 SET NULL OFF
585: 
586:                 *-- Os CINCO indices do Load legado (dump:10459-10463). Um TAG
587:                 *-- por criterio de ordenacao do Processo de Copia
588:                 *-- (SigPcOoP.Ordems): 1-Operacao / 2-Data / 3-Nota /
589:                 *-- 4-Origem / 5-Destino. Sem eles o "SET ORDER TO TAG <x>"
590:                 *-- que AplicarOrdemGrade() faz depois de Selecionar nao tem
591:                 *-- em que se apoiar.
592:                 INDEX ON Emps + Dopes + STR(Numes, 6)                   TAG Operacao
593:                 INDEX ON DTOS(Datas) + Emps + Dopes + STR(Numes, 6)     TAG Data
594:                 INDEX ON Notas + Emps + Dopes + STR(Numes, 6)           TAG Nota

*-- Linhas 621 a 663:
621:                 .FontSize          = 8
622:                 .AllowHeaderSizing = .F.
623:                 .AllowRowSizing    = .F.
624:                 .DeleteMark        = .F.
625:                 .RecordMark        = .F.
626:                 .HeaderHeight      = 16
627:                 .RowHeight         = 16
628:                 .ScrollBars        = 2
629:                 .GridLineColor     = RGB(238, 238, 238)
630:                 .ColumnCount       = 11
631: 
632:                 *-- RecordSource + ControlSource de TODAS as colunas
633:                 *-- ANTES do AddObject do Check1 (ver comentario do
634:                 *-- metodo acima - evita o auto-bind em coluna
635:                 *-- CHARACTER estourar o AddObject do CheckBox).
636:                 .RecordSource = loc_cCursor
637: 
638:                 .Column1.ControlSource  = loc_cCursor + ".SelImp"
639:                 .Column2.ControlSource  = loc_cCursor + ".Numes"
640:                 .Column3.ControlSource  = loc_cCursor + ".Datas"
641:                 .Column4.ControlSource  = loc_cCursor + ".Valos"
642:                 .Column5.ControlSource  = loc_cCursor + ".Notas"
643:                 .Column6.ControlSource  = loc_cCursor + ".Usuars"
644:                 .Column7.ControlSource  = loc_cCursor + ".ContaOs"
645:                 .Column8.ControlSource  = loc_cCursor + ".ContaDs"
646:                 .Column9.ControlSource  = loc_cCursor + ".Emps"
647:                 .Column10.ControlSource = loc_cCursor + ".EmpDs"
648:                 .Column11.ControlSource = loc_cCursor + ".Dopes"
649: 
650:                 *-- Column1 - marcacao (Check1). CurrentControl/Sparse
651:                 *-- obrigatorios (regra #18) para o CheckBox aparecer e
652:                 *-- ser editavel em TODAS as linhas.
653:                 .Column1.FontName = "Tahoma"
654:                 .Column1.FontSize = 8
655:                 .Column1.Header1.Alignment = 2
656:                 .Column1.Header1.Caption   = ""
657:                 .Column1.AddObject("Check1", "CheckBox")
658:                 WITH .Column1.Check1
659:                     .Top         = 9
660:                     .Left        = 2
661:                     .Height      = 17
662:                     .Width       = 22
663:                     .FontName    = "Tahoma"

*-- Linhas 920 a 938:
920:             *-- o cursor existe antes de amarrar o RowSourceType=2 do
921:             *-- combo - senao o AddObject do ComboBox estoura.
922:             IF !USED(THIS.this_cCursorProcessos)
923:                 CREATE CURSOR (THIS.this_cCursorProcessos) (processos C(20))
924:             ENDIF
925: 
926:             THIS.AddObject("cnt_4c_Operacoes", "Container")
927:             loc_oCnt = THIS.cnt_4c_Operacoes
928:             WITH loc_oCnt
929:                 .Top         = 88
930:                 .Left        = 6
931:                 .Width       = 732
932:                 .Height      = 46
933:                 .BackStyle   = 0
934:                 .BorderWidth = 0
935:                 .SpecialEffect = 0
936:                 .Visible     = .T.
937:             ENDWITH
938: 

*-- Linhas 1194 a 1212:
1194:     * fAcessoEmpresa no modo LOOKUP de 5 argumentos (comportamento.json);
1195:     * aqui, como BINDEVENT em "Valid" de TextBox nao e confiavel (regra
1196:     * CLAUDE.md #3), o equivalente fica no "KeyPress", testando a tecla
1197:     * (F4=115 abre o picker direto; Enter=13/Tab=9 fazem o SELECT exato
1198:     * contra SigCdEmp e so abrem o picker em caso de miss - regra
1199:     * CLAUDE.md #47, sem necessidade de guarda de reentrancia porque o
1200:     * handler testa par_nKeyCode). Os pickers (AbrirBuscaEmpOs/
1201:     * AbrirBuscaDEmpOs/AbrirBuscaEmpDs/AbrirBuscaDEmpDs) e os validadores
1202:     * (ValidarEmpOs/ValidarDEmpOs/ValidarEmpDs/ValidarDEmpDs) estao
1203:     * definidos mais abaixo, no mesmo padrao de Formsigatcrp.prg:2285-
1204:     * 2445 (ValidarEmp/AbrirBuscaEmp/ValidarDemp/AbrirBuscaDemp).
1205:     *====================================================================
1206:     PROTECTED PROCEDURE ConfigurarFiltro()
1207:         LOCAL loc_oCnt, loc_oErro
1208: 
1209:         TRY
1210:             THIS.AddObject("cnt_4c_Filtro", "Container")
1211:             loc_oCnt = THIS.cnt_4c_Filtro
1212:             WITH loc_oCnt

*-- Linhas 1364 a 1386:
1364:         ENDIF
1365: 
1366:         TRY
1367:             loc_nResult = SQLEXEC(gnConnHandle, ;
1368:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
1369:                 "cursor_4c_EmpOsVal")
1370:             IF loc_nResult > 0 AND USED("cursor_4c_EmpOsVal") AND !EOF("cursor_4c_EmpOsVal")
1371:                 SELECT cursor_4c_EmpOsVal
1372:                 THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_EmpOsVal.Cemps)
1373:                 THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpOsVal.Razas)
1374:             ELSE
1375:                 THIS.AbrirBuscaEmpOs()
1376:             ENDIF
1377:             IF USED("cursor_4c_EmpOsVal")
1378:                 USE IN cursor_4c_EmpOsVal
1379:             ENDIF
1380:         CATCH TO loc_oErro
1381:             MsgErro(loc_oErro.Message, "Erro")
1382:         ENDTRY
1383:         THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
1384:         THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
1385:     ENDPROC
1386: 

*-- Linhas 1400 a 1453:
1400:         loc_lProsseguir = .T.
1401:         TRY
1402:             IF EMPTY(loc_cValor)
1403:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
1404:             ELSE
1405:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
1406:                            "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
1407:                            " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
1408:                            " ORDER BY Cemps"
1409:             ENDIF
1410:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpOs")
1411: 
1412:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpOs") OR RECCOUNT("cursor_4c_BuscaEmpOs") = 0) ;
1413:                     AND !EMPTY(loc_cValor)
1414:                 IF USED("cursor_4c_BuscaEmpOs")
1415:                     USE IN cursor_4c_BuscaEmpOs
1416:                 ENDIF
1417:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1418:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
1419:                     "cursor_4c_BuscaEmpOs")
1420:             ENDIF
1421: 
1422:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpOs") OR RECCOUNT("cursor_4c_BuscaEmpOs") = 0
1423:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
1424:                 loc_lProsseguir = .F.
1425:             ENDIF
1426: 
1427:             IF loc_lProsseguir
1428:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1429:                 IF VARTYPE(loc_oBusca) = "O"
1430:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpOs"
1431:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1432:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1433:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1434:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1435:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1436:                     loc_oBusca.Show()
1437:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpOs")
1438:                         SELECT cursor_4c_BuscaEmpOs
1439:                         THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmpOs.Cemps)
1440:                         THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmpOs.Razas)
1441:                     ENDIF
1442:                     loc_oBusca.Release()
1443:                 ENDIF
1444:             ENDIF
1445:         CATCH TO loc_oErro
1446:             MsgErro(loc_oErro.Message, "Erro")
1447:         ENDTRY
1448: 
1449:         IF USED("cursor_4c_BuscaEmpOs")
1450:             USE IN cursor_4c_BuscaEmpOs
1451:         ENDIF
1452:         THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
1453:         THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh

*-- Linhas 1484 a 1506:
1484:         ENDIF
1485: 
1486:         TRY
1487:             loc_nResult = SQLEXEC(gnConnHandle, ;
1488:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Razas = " + EscaparSQL(loc_cVal), ;
1489:                 "cursor_4c_EmpOsVal")
1490:             IF loc_nResult > 0 AND USED("cursor_4c_EmpOsVal") AND !EOF("cursor_4c_EmpOsVal")
1491:                 SELECT cursor_4c_EmpOsVal
1492:                 THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_EmpOsVal.Cemps)
1493:                 THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpOsVal.Razas)
1494:             ELSE
1495:                 THIS.AbrirBuscaDEmpOs()
1496:             ENDIF
1497:             IF USED("cursor_4c_EmpOsVal")
1498:                 USE IN cursor_4c_EmpOsVal
1499:             ENDIF
1500:         CATCH TO loc_oErro
1501:             MsgErro(loc_oErro.Message, "Erro")
1502:         ENDTRY
1503:         THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
1504:         THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh
1505:     ENDPROC
1506: 

*-- Linhas 1520 a 1573:
1520:         loc_lProsseguir = .T.
1521:         TRY
1522:             IF EMPTY(loc_cValor)
1523:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas"
1524:             ELSE
1525:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
1526:                            "WHERE RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
1527:                            " OR Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
1528:                            " ORDER BY Razas"
1529:             ENDIF
1530:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpOs")
1531: 
1532:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpOs") OR RECCOUNT("cursor_4c_BuscaEmpOs") = 0) ;
1533:                     AND !EMPTY(loc_cValor)
1534:                 IF USED("cursor_4c_BuscaEmpOs")
1535:                     USE IN cursor_4c_BuscaEmpOs
1536:                 ENDIF
1537:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1538:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas", ;
1539:                     "cursor_4c_BuscaEmpOs")
1540:             ENDIF
1541: 
1542:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpOs") OR RECCOUNT("cursor_4c_BuscaEmpOs") = 0
1543:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
1544:                 loc_lProsseguir = .F.
1545:             ENDIF
1546: 
1547:             IF loc_lProsseguir
1548:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1549:                 IF VARTYPE(loc_oBusca) = "O"
1550:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpOs"
1551:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1552:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1553:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1554:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1555:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1556:                     loc_oBusca.Show()
1557:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpOs")
1558:                         SELECT cursor_4c_BuscaEmpOs
1559:                         THIS.cnt_4c_Filtro.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmpOs.Cemps)
1560:                         THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmpOs.Razas)
1561:                     ENDIF
1562:                     loc_oBusca.Release()
1563:                 ENDIF
1564:             ENDIF
1565:         CATCH TO loc_oErro
1566:             MsgErro(loc_oErro.Message, "Erro")
1567:         ENDTRY
1568: 
1569:         IF USED("cursor_4c_BuscaEmpOs")
1570:             USE IN cursor_4c_BuscaEmpOs
1571:         ENDIF
1572:         THIS.cnt_4c_Filtro.txt_4c_EmpOs.Refresh
1573:         THIS.cnt_4c_Filtro.txt_4c_DEmpOs.Refresh

*-- Linhas 1599 a 1621:
1599:         ENDIF
1600: 
1601:         TRY
1602:             loc_nResult = SQLEXEC(gnConnHandle, ;
1603:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
1604:                 "cursor_4c_EmpDsVal")
1605:             IF loc_nResult > 0 AND USED("cursor_4c_EmpDsVal") AND !EOF("cursor_4c_EmpDsVal")
1606:                 SELECT cursor_4c_EmpDsVal
1607:                 THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value  = ALLTRIM(cursor_4c_EmpDsVal.Cemps)
1608:                 THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ALLTRIM(cursor_4c_EmpDsVal.Razas)
1609:             ELSE
1610:                 THIS.AbrirBuscaEmpDs()
1611:             ENDIF
1612:             IF USED("cursor_4c_EmpDsVal")
1613:                 USE IN cursor_4c_EmpDsVal
1614:             ENDIF
1615:         CATCH TO loc_oErro
1616:             MsgErro(loc_oErro.Message, "Erro")
1617:         ENDTRY
1618:         THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
1619:         THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
1620:     ENDPROC
1621: 

*-- Linhas 1635 a 1688:
1635:         loc_lProsseguir = .T.
1636:         TRY
1637:             IF EMPTY(loc_cValor)
1638:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
1639:             ELSE
1640:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
1641:                            "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
1642:                            " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
1643:                            " ORDER BY Cemps"
1644:             ENDIF
1645:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpDs")
1646: 
1647:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpDs") OR RECCOUNT("cursor_4c_BuscaEmpDs") = 0) ;
1648:                     AND !EMPTY(loc_cValor)
1649:                 IF USED("cursor_4c_BuscaEmpDs")
1650:                     USE IN cursor_4c_BuscaEmpDs
1651:                 ENDIF
1652:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1653:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
1654:                     "cursor_4c_BuscaEmpDs")
1655:             ENDIF
1656: 
1657:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpDs") OR RECCOUNT("cursor_4c_BuscaEmpDs") = 0
1658:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
1659:                 loc_lProsseguir = .F.
1660:             ENDIF
1661: 
1662:             IF loc_lProsseguir
1663:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1664:                 IF VARTYPE(loc_oBusca) = "O"
1665:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpDs"
1666:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1667:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1668:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1669:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1670:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1671:                     loc_oBusca.Show()
1672:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpDs")
1673:                         SELECT cursor_4c_BuscaEmpDs
1674:                         THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value  = ALLTRIM(cursor_4c_BuscaEmpDs.Cemps)
1675:                         THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ALLTRIM(cursor_4c_BuscaEmpDs.Razas)
1676:                     ENDIF
1677:                     loc_oBusca.Release()
1678:                 ENDIF
1679:             ENDIF
1680:         CATCH TO loc_oErro
1681:             MsgErro(loc_oErro.Message, "Erro")
1682:         ENDTRY
1683: 
1684:         IF USED("cursor_4c_BuscaEmpDs")
1685:             USE IN cursor_4c_BuscaEmpDs
1686:         ENDIF
1687:         THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
1688:         THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh

*-- Linhas 1719 a 1741:
1719:         ENDIF
1720: 
1721:         TRY
1722:             loc_nResult = SQLEXEC(gnConnHandle, ;
1723:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Razas = " + EscaparSQL(loc_cVal), ;
1724:                 "cursor_4c_EmpDsVal")
1725:             IF loc_nResult > 0 AND USED("cursor_4c_EmpDsVal") AND !EOF("cursor_4c_EmpDsVal")
1726:                 SELECT cursor_4c_EmpDsVal
1727:                 THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value  = ALLTRIM(cursor_4c_EmpDsVal.Cemps)
1728:                 THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ALLTRIM(cursor_4c_EmpDsVal.Razas)
1729:             ELSE
1730:                 THIS.AbrirBuscaDEmpDs()
1731:             ENDIF
1732:             IF USED("cursor_4c_EmpDsVal")
1733:                 USE IN cursor_4c_EmpDsVal
1734:             ENDIF
1735:         CATCH TO loc_oErro
1736:             MsgErro(loc_oErro.Message, "Erro")
1737:         ENDTRY
1738:         THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
1739:         THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh
1740:     ENDPROC
1741: 

*-- Linhas 1755 a 1808:
1755:         loc_lProsseguir = .T.
1756:         TRY
1757:             IF EMPTY(loc_cValor)
1758:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas"
1759:             ELSE
1760:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
1761:                            "WHERE RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
1762:                            " OR Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
1763:                            " ORDER BY Razas"
1764:             ENDIF
1765:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpDs")
1766: 
1767:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpDs") OR RECCOUNT("cursor_4c_BuscaEmpDs") = 0) ;
1768:                     AND !EMPTY(loc_cValor)
1769:                 IF USED("cursor_4c_BuscaEmpDs")
1770:                     USE IN cursor_4c_BuscaEmpDs
1771:                 ENDIF
1772:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1773:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas", ;
1774:                     "cursor_4c_BuscaEmpDs")
1775:             ENDIF
1776: 
1777:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpDs") OR RECCOUNT("cursor_4c_BuscaEmpDs") = 0
1778:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
1779:                 loc_lProsseguir = .F.
1780:             ENDIF
1781: 
1782:             IF loc_lProsseguir
1783:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1784:                 IF VARTYPE(loc_oBusca) = "O"
1785:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpDs"
1786:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1787:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1788:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1789:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1790:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1791:                     loc_oBusca.Show()
1792:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpDs")
1793:                         SELECT cursor_4c_BuscaEmpDs
1794:                         THIS.cnt_4c_Filtro.txt_4c_EmpDs.Value  = ALLTRIM(cursor_4c_BuscaEmpDs.Cemps)
1795:                         THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Value = ALLTRIM(cursor_4c_BuscaEmpDs.Razas)
1796:                     ENDIF
1797:                     loc_oBusca.Release()
1798:                 ENDIF
1799:             ENDIF
1800:         CATCH TO loc_oErro
1801:             MsgErro(loc_oErro.Message, "Erro")
1802:         ENDTRY
1803: 
1804:         IF USED("cursor_4c_BuscaEmpDs")
1805:             USE IN cursor_4c_BuscaEmpDs
1806:         ENDIF
1807:         THIS.cnt_4c_Filtro.txt_4c_EmpDs.Refresh
1808:         THIS.cnt_4c_Filtro.txt_4c_DEmpDs.Refresh

*-- Linhas 1931 a 2019:
1931:     * e reusado pelo Selecionar() da Fase 7/8 (cursor ja populado).
1932:     *
1933:     * Ordem canonica (regra "Problema 48"/CLAUDE.md): RecordSource (que
1934:     * RESETA Width e Header1.Caption) -> ControlSource de cada coluna ->
1935:     * Width -> Header1.Caption -> GO TOP + Refresh (regra #21 - popular
1936:     * cursor nao repinta a grade por si so). ColumnCount NAO e
1937:     * reatribuido aqui (ja fixo em ConfigurarGrid - regra
1938:     * "SOREDUZIRColumn"); CurrentControl/Sparse do Column1 sao
1939:     * reforcados defensivamente apos o RecordSource.
1940:     *====================================================================
1941:     PROCEDURE CarregarLista()
1942:         LOCAL loc_oGrid, loc_cCursor, loc_oErro
1943: 
1944:         loc_cCursor = THIS.this_cCursorOperacoes
1945: 
1946:         IF !USED(loc_cCursor)
1947:             RETURN
1948:         ENDIF
1949: 
1950:         TRY
1951:             loc_oGrid = THIS.cnt_4c_Grade.grd_4c_Dados
1952: 
1953:             loc_oGrid.RecordSource = loc_cCursor
1954: 
1955:             loc_oGrid.Column1.ControlSource = loc_cCursor + ".SelImp"
1956:             loc_oGrid.Column1.AddObject("Check1", "CheckBox")
1957:             loc_oGrid.Column1.Check1.Caption = ""
1958:             loc_oGrid.Column1.CurrentControl = "Check1"
1959:             loc_oGrid.Column1.Sparse         = .F.
1960:             loc_oGrid.Column1.ReadOnly       = .F.
1961:             loc_oGrid.Column1.Width          = 15
1962: 
1963:             loc_oGrid.Column2.ControlSource = loc_cCursor + ".Numes"
1964:             loc_oGrid.Column2.Width         = 52
1965:             loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
1966: 
1967:             loc_oGrid.Column3.ControlSource = loc_cCursor + ".Datas"
1968:             loc_oGrid.Column3.Width         = 80
1969:             loc_oGrid.Column3.Header1.Caption = "Data"
1970: 
1971:             loc_oGrid.Column4.ControlSource = loc_cCursor + ".Valos"
1972:             loc_oGrid.Column4.Width         = 104
1973:             loc_oGrid.Column4.Header1.Caption = "Valor"
1974: 
1975:             loc_oGrid.Column5.ControlSource = loc_cCursor + ".Notas"
1976:             loc_oGrid.Column5.Width         = 75
1977:             loc_oGrid.Column5.Header1.Caption = "Documento"
1978: 
1979:             loc_oGrid.Column6.ControlSource = loc_cCursor + ".Usuars"
1980:             loc_oGrid.Column6.Width         = 85
1981:             loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
1982: 
1983:             loc_oGrid.Column7.ControlSource = loc_cCursor + ".ContaOs"
1984:             loc_oGrid.Column7.Width         = 85
1985:             loc_oGrid.Column7.Header1.Caption = "Origem"
1986: 
1987:             loc_oGrid.Column8.ControlSource = loc_cCursor + ".ContaDs"
1988:             loc_oGrid.Column8.Width         = 85
1989:             loc_oGrid.Column8.Header1.Caption = "Destino"
1990: 
1991:             loc_oGrid.Column9.ControlSource = loc_cCursor + ".Emps"
1992:             loc_oGrid.Column9.Width         = 37
1993:             loc_oGrid.Column9.Header1.Caption = "Orig."
1994: 
1995:             loc_oGrid.Column10.ControlSource = loc_cCursor + ".EmpDs"
1996:             loc_oGrid.Column10.Width         = 37
1997:             loc_oGrid.Column10.Header1.Caption = "Dest."
1998: 
1999:             loc_oGrid.Column11.ControlSource = loc_cCursor + ".Dopes"
2000:             loc_oGrid.Column11.Width         = 242
2001:             loc_oGrid.Column11.ReadOnly      = .F.
2002:             loc_oGrid.Column11.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2003: 
2004:             SELECT (loc_cCursor)
2005:             GO TOP
2006:             loc_oGrid.Refresh()
2007:         CATCH TO loc_oErro
2008:             MsgErro(loc_oErro.Message + CHR(13) + ;
2009:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2010:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
2011:         ENDTRY
2012:     ENDPROC
2013: 
2014:     *====================================================================
2015:     * ConfigurarEventosBotoes - BINDEVENT dos botoes de acao (cmg_4c_
2016:     * CmdBtnForm/cmg_4c_CmdBtnGrade/cmd_4c_CmdSelecionar), do checkbox
2017:     * grafico (chk_4c_Fwcheckbox1) e dos 4 handlers da coluna de
2018:     * marcacao da grade (Column1.Check1 - regra CLAUDE.md #46/#18).
2019:     * Chamado ao final de ConfigurarLayout(), depois que todos os

*-- Linhas 2211 a 2246:
2211:     * AplicarOrdemGrade - ordena a grade pelo criterio escolhido no
2212:     * Processo de Copia (SigPcOoP.Ordems, lido por Selecionar() em
2213:     * this_nOrdemGrade). Equivalente ao
2214:     * "Select csOperacoes / Set Order To Operacao / Do Case ... Set
2215:     * Order To Data|Nota|Origem|Destino / Go Top" do legado
2216:     * (dump:10251-10263). Os TAGs sao criados com o cursor, em
2217:     * ConfigurarGrid.
2218:     *====================================================================
2219:     PROCEDURE AplicarOrdemGrade()
2220:         LOCAL loc_cCursor, loc_nOrdem, loc_oErro
2221: 
2222:         loc_cCursor = THIS.this_cCursorOperacoes
2223: 
2224:         IF !USED(loc_cCursor)
2225:             RETURN
2226:         ENDIF
2227: 
2228:         TRY
2229:             loc_nOrdem = THIS.this_oBusinessObject.this_nOrdemGrade
2230: 
2231:             SELECT (loc_cCursor)
2232: 
2233:             DO CASE
2234:             CASE loc_nOrdem = 2
2235:                 SET ORDER TO TAG Data
2236:             CASE loc_nOrdem = 3
2237:                 SET ORDER TO TAG Nota
2238:             CASE loc_nOrdem = 4
2239:                 SET ORDER TO TAG Origem
2240:             CASE loc_nOrdem = 5
2241:                 SET ORDER TO TAG Destino
2242:             OTHERWISE
2243:                 SET ORDER TO TAG Operacao
2244:             ENDCASE
2245: 
2246:             GO TOP

*-- Linhas 2276 a 2294:
2276: 
2277:         TRY
2278:             IF USED(loc_cCursor)
2279:                 SELECT (loc_cCursor)
2280:                 ZAP
2281:             ENDIF
2282: 
2283:             WITH THIS.cnt_4c_Operacoes
2284:                 .txt_4c_DtIni.Enabled                     = .T.
2285:                 .txt_4c_DtFin.Enabled                     = .T.
2286:                 .cbo_4c_CmbOperacoes.Enabled               = .T.
2287:                 .cmd_4c_CmdSelecionar.Enabled               = .T.
2288:                 .obj_4c_OptProcessados.Buttons(1).Enabled = .T.
2289:                 .obj_4c_OptProcessados.Buttons(2).Enabled = .T.
2290:                 .chk_4c_ChkMensa.Enabled                    = .F.
2291:             ENDWITH
2292: 
2293:             WITH THIS.cnt_4c_Filtro
2294:                 .txt_4c_EmpOs.Enabled  = .T.

*-- Linhas 2320 a 2360:
2320:     *====================================================================
2321:     * CmdBtnFormClick - equivalente ao Click de cmdBtnForm (dump:10809-
2322:     * 10897): Value=1 Limpar -> THIS.LimpaSelecao(); Value=2 Copiar ->
2323:     * guarda de selecao (regra CLAUDE.md #50 - "Select SelImp, Count(1)
2324:     * ... Where SelImp ... If Selecionados < 1" do legado, aqui via
2325:     * COUNT TO ... FOR SelImp apos SELECT do alias - regra CLAUDE.md
2326:     * "COUNT TO var IN alias PROIBIDO") seguida de THIS.
2327:     * this_oBusinessObject.Processamento() (Fase 8/8 - ver nota no
2328:     * cabecalho do arquivo); Value=3 Encerrar -> THIS.Release()
2329:     * (equivalente a "ThisForm.Release" do btnSair, dump:10885-10897).
2330:     *====================================================================
2331:     PROCEDURE CmdBtnFormClick()
2332:         LOCAL loc_oGrupo, loc_cCursor, loc_nSelecionados, loc_oErro
2333: 
2334:         loc_oGrupo  = THIS.cnt_4c_Botoes.cmg_4c_CmdBtnForm
2335:         loc_cCursor = THIS.this_cCursorOperacoes
2336: 
2337:         TRY
2338:             DO CASE
2339:             CASE loc_oGrupo.Value = 1 AND loc_oGrupo.Buttons(1).Enabled
2340:                 THIS.LimpaSelecao()
2341: 
2342:             CASE loc_oGrupo.Value = 2 AND loc_oGrupo.Buttons(2).Enabled
2343:                 loc_nSelecionados = 0
2344:                 IF USED(loc_cCursor)
2345:                     SELECT (loc_cCursor)
2346:                     COUNT TO loc_nSelecionados FOR SelImp
2347:                 ENDIF
2348: 
2349:                 IF loc_nSelecionados < 1
2350:                     MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Encontrado!!!", "Aten" + CHR(231) + CHR(227) + "o")
2351:                     THIS.cnt_4c_Operacoes.cbo_4c_CmbOperacoes.SetFocus
2352:                 ELSE
2353:                     *-- Fecho do legado, comum ao Processamento e ao
2354:                     *-- Financeiro (dump:9933-9934 e 2761-2762): copia
2355:                     *-- concluida devolve a tela ao estado inicial e refaz a
2356:                     *-- selecao, para o usuario ver o que ainda falta copiar.
2357:                     IF THIS.this_oBusinessObject.Processamento()
2358:                         THIS.LimpaSelecao()
2359:                         THIS.CmdSelecionarClick()
2360:                     ENDIF

*-- Linhas 2392 a 2422:
2392:         TRY
2393:             DO CASE
2394:             CASE loc_oGrupo.Value = 1 AND loc_oGrupo.Buttons(1).Enabled
2395:                 SELECT (loc_cCursor)
2396:                 REPLACE ALL SelImp WITH .T.
2397:                 GO TOP
2398:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2399: 
2400:             CASE loc_oGrupo.Value = 2 AND loc_oGrupo.Buttons(2).Enabled
2401:                 SELECT (loc_cCursor)
2402:                 REPLACE ALL SelImp WITH .F.
2403:                 GO TOP
2404:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2405: 
2406:             CASE loc_oGrupo.Value = 3 AND loc_oGrupo.Buttons(3).Enabled
2407:                 SELECT (loc_cCursor)
2408:                 IF !EOF()
2409:                     IF Deletado
2410:                         MsgAviso("Essa Opera" + CHR(231) + CHR(227) + "o Foi Exclu" + CHR(237) + "da do Sistema!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
2411:                     ELSE
2412:                         loc_oForm = CREATEOBJECT("FormSigMvExp", Dopes, "C", Numes, Emps, .T.)
2413:                         IF VARTYPE(loc_oForm) = "O"
2414:                             loc_oForm.Show()
2415:                         ENDIF
2416:                     ENDIF
2417:                 ENDIF
2418:             ENDCASE
2419:         CATCH TO loc_oErro
2420:             MsgErro(loc_oErro.Message + CHR(13) + ;
2421:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2422:                 "Procedure: " + loc_oErro.Procedure, "Erro em CmdBtnGradeClick")

*-- Linhas 2441 a 2472:
2441:         IF INLIST(par_nKeyCode, 13, 32)
2442:             loc_cCursor = THIS.this_cCursorOperacoes
2443:             IF USED(loc_cCursor)
2444:                 SELECT (loc_cCursor)
2445:                 REPLACE SelImp WITH !SelImp
2446:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2447:             ENDIF
2448:             NODEFAULT
2449:         ENDIF
2450:     ENDPROC
2451: 
2452:     PROCEDURE Check1MouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2453:         LOCAL loc_cCursor
2454: 
2455:         loc_cCursor = THIS.this_cCursorOperacoes
2456:         IF USED(loc_cCursor)
2457:             SELECT (loc_cCursor)
2458:             REPLACE SelImp WITH !SelImp
2459:             THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2460:         ENDIF
2461:         NODEFAULT
2462:     ENDPROC
2463: 
2464:     PROCEDURE Check1MouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2465:         NODEFAULT
2466:     ENDPROC
2467: 
2468:     *====================================================================
2469:     * Destroy - fecha o cursor da grade de operacoes e o cursor da lista
2470:     * de Processos de Copia (RowSource do combo) e encadeia para
2471:     * FormBase.Destroy() (libera this_oBusinessObject e restaura o
2472:     * menu principal).

