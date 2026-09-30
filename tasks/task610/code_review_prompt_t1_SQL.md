# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, GERBALS, EMPS, LNCT, CONTADS, NUMBALDS, CONTAOS, NUMBALS, GRUPOOS, NOPS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, LCSQL, CODIGOS, RECFALS, VISIVEL, EMPGRUESTS, OPERAS, NOME, UNIFBALS, DATAS, NAGMTS, GRUPOS, CONTAS, EMPDNPS, SERVICOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OPERS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, GERBALS, EMPS, LNCT, CONTADS, NUMBALDS, CONTAOS, NUMBALS, GRUPOOS, NOPS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, LCSQL, CODIGOS, RECFALS, VISIVEL, EMPGRUESTS, OPERAS, NOME, UNIFBALS, DATAS, NAGMTS, GRUPOS, CONTAS, EMPDNPS, SERVICOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ESTORIGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, GERBALS, EMPS, LNCT, CONTADS, NUMBALDS, CONTAOS, NUMBALS, GRUPOOS, NOPS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, LCSQL, CODIGOS, RECFALS, VISIVEL, EMPGRUESTS, OPERAS, NOME, UNIFBALS, DATAS, NAGMTS, GRUPOS, CONTAS, EMPDNPS, SERVICOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ESTDESTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, GERBALS, EMPS, LNCT, CONTADS, NUMBALDS, CONTAOS, NUMBALS, GRUPOOS, NOPS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, LCSQL, CODIGOS, RECFALS, VISIVEL, EMPGRUESTS, OPERAS, NOME, UNIFBALS, DATAS, NAGMTS, GRUPOS, CONTAS, EMPDNPS, SERVICOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, GERBALS, EMPS, LNCT, CONTADS, NUMBALDS, CONTAOS, NUMBALS, GRUPOOS, NOPS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, LCSQL, CODIGOS, RECFALS, VISIVEL, EMPGRUESTS, OPERAS, NOME, UNIFBALS, DATAS, NAGMTS, GRUPOS, CONTAS, EMPDNPS, SERVICOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, GERBALS, EMPS, LNCT, CONTADS, NUMBALDS, CONTAOS, NUMBALS, GRUPOOS, NOPS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, LCSQL, CODIGOS, RECFALS, VISIVEL, EMPGRUESTS, OPERAS, NOME, UNIFBALS, DATAS, NAGMTS, GRUPOS, CONTAS, EMPDNPS, SERVICOS, EMPDOPNUMS

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
  DeleteMark = .F.
  DeleteMark = .F.
  DeleteMark = .F.
  DeleteMark = .F.
lcSql = [Select Rclis, GerBals, PagFals, RecFals From SigCdCli where Iclis = ']+CrSigMvEst.Estos+[']
If Thisform.Podatamgr.Sqlexecute(lcSql,'CrSigCdCli') < 1
=Seek(CrSigMvEst.Grupos,'CrSigCdGcr','Codigos')
lcQuery = [Select Datas, codigos ] + ;
		    [From SigCdFcx ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalFecha') < 1)
	Select TmpResumo
	Select LocalFecha
	=Seek(Dtos(ldDataB))
	lcQuery = [Select Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, Obss, cIdChaves, EmpDnPs ] + ;
				[From SigCdNec ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNens') < 1)
	lcQuery = [Select b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops, b.Peso2s, b.CodCors, b.CodTams ] + ;
				[From SigCdNec a, SigCdNei b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNensI') < 1)
	Select LocalNensI
	Select LocalNens
		loBarrap.UpDate(.t.)
		=Seek(LocalNens.Dopps, 'CrSigCdOpd', 'Dopps')
		Select LocalNensI
					lcSql = [Select Cpros From SigOpPic where Nops = ]+Str(LocalNensi.Nops)
					=Thisform.Podatamgr.Sqlexecute(lcsql,'TmpOpi')
					=Seek(TmpOpi.Cpros,'TmpPro','Cpros')
					lcSql = [Select Cpros From SigOpPic where Nops = ]+Str(LocalNensi.Nops)
					=Thisform.Podatamgr.Sqlexecute(lcsql,'TmpOpi')
						=Seek(TmpOpi.Cpros,'TmpPro','Cpros')
			=Seek(LocalNensI.CMats, 'TmpPro', 'CPros')
			=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
			=Seek(LocalGru.Mercs,'LocalGgrp','Codigos')
				If Not Seek(LocalNens.GrupoOs + LocalNens.ContaOs + LocalNensI.CMats + lcCodCor + lcCodTam, 'TmpResumo')
					Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
				Select TmpResumo
				If Not Seek(LocalNens.GrupoDs + LocalNens.ContaDs + LocalNensI.CMats+ lcCodCor + lcCodTam, 'TmpResumo')
					Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams ) ;
				Select TmpResumo
			=Seek(TmpResumo.CMats, 'TmpPro', 'CPros')
			=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
			=Seek(LocalGru.Mercs,'LocalGgrp','Codigos')
				=Seek(_Material, 'TmpPro', 'CPros')
				=Seek(TmpPro.Cgrus,'LocalGru','CGrus')
				=Seek(LocalGru.Mercs,'LocalGgrp','Codigos')
					If Not Seek(LocalNens.GrupoOs + LocalNens.ContaOs + _Material, 'TmpResumo')
						Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, visivel ) ;
					Select TmpResumo
					If Not Seek(LocalNens.GrupoDs + LocalNens.ContaDs + _Material , 'TmpResumo')
						Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Visivel ) ;
					Select TmpResumo
	lcQuery = [Select Datas, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Dopes, Numes, Obses, CidChaves, EmpDs ] + ;
				[From SigMvCab ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEest') < 1)
	lcQuery = [Select b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds, b.Pesos, b.cItens ] + ;
				[From SigMvCab a, SigMvItn b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEestI') < 1)
	Select LocalEestI
	lcQuery = [Select b.EmpDopNums, b.CPros, b.Qtds, b.Pesos, b.CodCors, b.CodTams, b.Citens ] + ;
				[From SigMvCab a, SigMvIts b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEsti2') < 1)
	Select LocalEsti2
	Select LocalEest
		loBarrap.Update(.t.)
		=Seek(LocalEest.Dopes, 'crSigCdOpe', 'Dopes')
		Select LocalEestI
			=Seek(LocalEesti.Cpros, 'TmpPro', 'CPros')
			=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
			=Seek(LocalGru.Mercs,'LocalGgrp','Codigos')
			=Seek(TmpPro.CUnis,'CrSigCdUni','Cunis')
			Select LocalEsti2
			If Seek(LocalEesti.EmpDopNums + LocalEesti.Cpros + Str(LocalEesti.Citens,4))
						If Not Seek(_Grupo + _Conta + LocalEsti2.CPros + lcCodCor + lcCodTam, 'TmpResumo')
							Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams  ) ;
						Select TmpResumo
						If Not Seek(_Grupo + _Conta + LocalEsti2.CPros + lcCodCor + lcCodTam, 'TmpResumo')
							Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, visivel, CodCors, CodTams ) ;
						Select TmpResumo
					If Not Seek(_Grupo + _Conta + LocalEestI.CPros, 'TmpResumo')
						Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel  ) ;
					Select TmpResumo
					If Not Seek(_Grupo + _Conta + LocalEestI.CPros, 'TmpResumo')
						Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, visivel ) ;
					Select TmpResumo
	Select TmpResumo
		Select TmpResumo
		If Not Seek(_Grupo + _Conta + lcMat)
		Select [ ] as Agrupar,Sum(PesoEnts) as pEnts, Sum(PesoSais) as pSais ;
		  From TmpResumo ;
		Select TmpResumo
		=Seek(_Grupo + _Conta)
	lcSql = [Select * From SigOpCfe Where Codigos = ]+Str(LocalFecha.Codigos,6)+[ And Emps= ']+_Empr+[' Order by Codigos, cpros ]
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSaldoI') < 1
	Select CrSaldoI
	Select TmpResumo
	=Seek(_Grupo + _Conta)
		=Seek(TmpResumo.CMats, 'TmpPro', 'CPros')
		Select CrSaldoI
		=Seek(TmpResumo.Cmats)
		Select TmpResumo
	Select CrSaldoI
		=Seek(CrSaldoI.Cpros, 'TmpPro', 'CPros')
		=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
		Select TmpResumo
			Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
			Select TmpResumo
	Select TmpResumo
	=Seek(_Grupo + _Conta + lcCodMat)
			If Not Seek(_Grupo, 'Saldos')
				Insert Into Saldos (Grupos, Contas, Emps) Values (_Grupo, _Conta, _Empr)
			If Not Seek(_Grupo , 'SaldoAnt')
				Insert Into SaldoAnt (Grupos, Contas, Emps) Values (_Grupo, _Conta, _Empr)
		Select crSigCdOpe
		Select crSigCdOpd
		Select crSigCdGcr
		Select crSigCdUni
		Select LocalGru
		Select LocalGgrp
	Select TmpImp
lcQuery = [Select Top 1 Sqtds ] + ;
		    [From SigMvHst ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvHst') < 1)
Select crSigMvHst
lcQuery = [Select Grupos, Contas, TpOps From SigCdDpr Where Operas = 'P' And Nome = '] + lcConfig + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpPesag') < 1)
Select TmpPesag
lcQuery = [Select Grupos, Contas, TpOps From SigCdDpr Where Operas = 'H' And Nome = '] + lcConfig + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpSaldo') < 1)
Select TmpSaldo
lcQuery = [Select Grupos, Contas, TpOps From SigCdDpr Where Operas = 'E' And Nome = '] + lcConfig + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEntra') < 1)
Select TmpEntra
lcQuery = [Select Grupos, Contas, TpOps From SigCdDpr Where Operas = 'S' And Nome = '] + lcConfig + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpSaida') < 1)
Select TmpSaida
lcQuery = [Select CPros, DPros, CUnis, CGrus, Varias, Custofs, MoeCusfs, MatPrincs, cUniPs ] + ;
		    [From SigCdPro]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpPro') < 1)
Select TmpPro
lcQuery = [Select a.Datas, a.Emps, a.Dopps, a.Numps, a.GrupoOs, a.ContaOs, ] + ;
		    [From SigCdNec a, SigCdNei b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crProducao') < 1)
lcQuery = [Select CPros, Nops ] + ;
		    [From SigOpPic]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'Tmpopi') < 1)
Select TmpOpi
Select Distinct EmpDnps, Servicos, CMats, Pesos, ChaveB, TpOps, Qtds, Nops ;
  From crProducao ;
Select crSigCdNei
Select Distinct Datas, Emps, Dopps, Numps, GrupoOs, ContaOs, GrupoDs, ContaDs, cIdChaves ;
From crProducao ;
Select crSigCdNec
	loBarra.UpDate(.t.)
	=Seek(crSigCdNec.Dopps, 'crSigCdOpd', 'Dopps')
		If (Seek(crSigCdNec.GrupoOs + crSigCdNec.ContaOs, 'TmpEntra') Or Seek(crSigCdNec.GrupoOs + Space(10), 'TmpEntra')) And (crSigCdOpd.EstOrigs = 1)
		If (Seek(crSigCdNec.GrupoOs + crSigCdNec.ContaOs, 'TmpSaida') Or Seek(crSigCdNec.GrupoOs + Space(10), 'TmpSaida')) And (crSigCdOpd.EstOrigs = 2)
		If (Seek(crSigCdNec.GrupoDs + crSigCdNec.ContaDs, 'TmpEntra') Or Seek(crSigCdNec.GrupoDs + Space(10), 'TmpEntra')) And (crSigCdOpd.EstDests = 1)
		If (Seek(crSigCdNec.GrupoDs + crSigCdNec.ContaDs, 'TmpSaida') Or Seek(crSigCdNec.GrupoDs + Space(10), 'TmpSaida')) And (crSigCdOpd.EstDests = 2)
	Select crSigCdNei
	=SEEK(lcEdn)
		=Seek(crSigCdNec.GrupoOs, 'crSigCdGcr', 'Codigos')
				=Seek(CrSigCdNei.Nops,'TmpOpi','Nops')
				=Seek(TmpOpi.Cpros,'TmpPro','Cpros')
				=Seek(CrSigCdNei.Nops,'TmpOpi','Nops')
					=Seek(TmpOpi.Cpros,'TmpPro','Cpros')
			If Seek(lcChave1, lcTemp) Or Seek(lcChave2, lcTemp)
				If Not Seek(lcEmp + &lcTemp..TpOps, lcAlias)
					Insert Into &lcAlias. (TpOps) Values (&lcTemp..TpOps)
		=Seek(crSigCdNec.GrupoDs, 'crSigCdGcr', 'Codigos')
				=Seek(CrSigCdNei.Nops,'TmpOpi','Nops')
				=Seek(TmpOpi.Cpros,'TmpPro','Cpros')
				=Seek(CrSigCdNei.Nops,'TmpOpi','Nops')
					=Seek(TmpOpi.Cpros,'TmpPro','Cpros')
			If Seek(lcChave1, lcTemp) Or Seek(lcChave2, lcTemp)
				If Not Seek(lcEmp + &lcTemp..TpOps, lcAlias)
					Insert Into &lcAlias. (TpOps) Values (&lcTemp..TpOps)
lcQuery = [Select a.Datas, a.Emps, a.EmpDs, a.Dopes, a.Numes, a.GrupoOs, a.ContaOs, a.GrupoDs, ] + ;
		    [From SigMvCab a, SigMvItn b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crEstoque') < 1)
Select Distinct EmpDopNums, CPros, Opers, Qtds, ChaveB ;
  From crEstoque ;
Select crSigMvItn
Select Distinct Datas, Emps, EmpDs, Dopes, Numes, GrupoOs, ContaOs, GrupoDs, ContaDs, cIdChaves ;
  From crEstoque ;
Select crSigMvCab
	loBarra.Update(.t.)
	=Seek(crSigMvCab.Dopes, 'crSigCdOpe', 'Dopes')
		If Seek(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, 'TmpEntra')
		If (Seek(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, 'TmpEntra') Or ; 
			Seek(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, 'TmpSaida') Or ; 
			Seek(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, 'TmpEntra') Or ;
			Seek(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, 'TmpSaida')) Or ;
			(Seek(crSigMvCab.GrupoOs + Space(10), 'TmpEntra') Or ; 
			Seek(crSigMvCab.GrupoOs + Space(10), 'TmpSaida') Or ; 
			Seek(crSigMvCab.GrupoDs + Space(10), 'TmpEntra') Or ;
			Seek(crSigMvCab.GrupoDs + Space(10), 'TmpSaida'))			
	Select crSigMvItn
			If (crSigMvItn.Opers = 'S') And (Seek(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, 'TmpSaida') Or Seek(crSigMvCab.GrupoOs + Space(10), 'TmpSaida'))
				If (crSigMvItn.Opers = 'E') And (Seek(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, 'TmpEntra') Or Seek(crSigMvCab.GrupoDs + Space(10), 'TmpEntra'))
					If (crSigMvItn.Opers = 'S') And (Seek(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, 'TmpSaida') Or Seek(crSigMvCab.GrupoOs + Space(10), 'TmpSaida'))
						If (crSigMvItn.Opers = 'E') And (Seek(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, 'TmpEntra') Or Seek(crSigMvCab.GrupoOs + Space(10), 'TmpEntra'))
						If (crSigMvItn.Opers = 'S') And (Seek(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, 'TmpSaida') Or Seek(crSigMvCab.GrupoDs + Space(10), 'TmpSaida'))
							If (crSigMvItn.Opers = 'E') And (Seek(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, 'TmpEntra') Or Seek(crSigMvCab.GrupoOs + Space(10), 'TmpEntra'))
					If (Seek(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, 'TmpSaida') Or Seek(crSigMvCab.GrupoOs + Space(10), 'TmpSaida')) And (crSigCdOpe.EstOrigs = 2)
						If (Seek(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, 'TmpEntra') Or Seek(crSigMvCab.GrupoOs + Space(10), 'TmpEntra')) And (crSigCdOpe.EstOrigs = 1)
					If (Seek(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, 'TmpSaida') Or Seek(crSigMvCab.GrupoDs + Space(10), 'TmpSaida')) And (crSigCdOpe.EstDests = 2)
						If (Seek(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, 'TmpEntra') Or Seek(crSigMvCab.GrupoDs + Space(10), 'TmpEntra')) And (crSigCdOpe.EstDests = 1)
		=Seek(_Grupoo, 'crSigCdGcr', 'Codigos')
		=Seek(crSigMvItn.Cpros,'TmpPro','Cpros')
			=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')		
			If Seek(lcChave1, lcTemp) Or Seek(lcChave2, lcTemp)
				If Not Seek(lcEmp + lcTpOp, lcAlias)
					Select (lcAlias)
		=Seek(_Grupod, 'crSigCdGcr', 'Codigos')
		=Seek(crSigMvItn.Cpros,'TmpPro','Cpros')				
			=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
			If Seek(lcChave1, lcTemp) Or Seek(lcChave2, lcTemp)
				If Not Seek(lcEmp + lcTpOp, lcAlias)
					Select (lcAlias)
Select TmpPesag
	loBarra.UpDate(.t.)
	lcQuery = [Select Datas, Codigos ] + ;
			    [From SigCdPsc ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPsc') < 1)
	Select crSigCdPsc
	lcQuery = [Select CPros, Qtds ] + ;
			    [From SigCdPsi ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPsi') < 1)
	Select crSigCdPsi
Select TmpSaldo
	loBarra.UpDate(.t.)
	lcQuery = [Select Emps, Grupos, Estos, CPros ] + ;
			    [From SigMvEst Where ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvEst') < 1)
	Select crSigMvEst
		=Seek(CrSigMvEst.Grupos, 'crSigCdGcr', 'Codigos')
Select [ ] as Agrupar, Sum(qtde) as Qtde From Saldos Into cursor CsSelecao group by 1
Select [ ] as Agrupar, Sum(qtde) as Qtde From SaldoAnt Into cursor CsSelecao group by 1
Select TmpSaldo
	loBarra.UpDate(.t.)
	lcQuery = [Select b.cIdChaves, b.FReals, b.Entradas, b.Saldos, b.Saidas, b.Pesagems ] + ;
			    [From SigCdFcx a, SigOpCfe b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdFcx') < 1)
	Select crSigCdFcx
		If Not Seek(TmpSaldo.Grupos, 'Falhas')
			Insert Into Falhas (Grupos, Contas, Emps) Values (TmpSaldo.Grupos, TmpSaldo.Contas, _Empr)
Select Entradas
Select Saidas
Select SaldoAnt
		.Column1.Controlsource   = 'SaldoAnt.Grupos'
		.Column2.Controlsource   = 'SaldoAnt.Qtde'
		.Column3.Controlsource   = 'SaldoAnt.Emps'
Select Entradas
		.Column1.Controlsource   = 'Entradas.TpOps'
		.Column2.Controlsource   = 'Entradas.Qtde'
		.Column3.Controlsource   = 'Entradas.emps'
Select Saidas
		.Column1.Controlsource   = 'Saidas.TpOps'
		.Column2.Controlsource   = 'Saidas.Qtde'
		.Column3.Controlsource   = 'Saidas.emps'
Select Saldos
		.Column1.Controlsource   = 'Saldos.Grupos'
		.Column2.Controlsource   = 'Saldos.Qtde'
		.Column3.Controlsource   = 'Saldos.Emps'
Select Falhas
		.Column1.Controlsource   = 'Falhas.Grupos'
		.Column2.Controlsource   = 'Falhas.Qtde'
		.Column3.Controlsource   = 'Falhas.Emps'
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Saldo Inicial : ', lnSaldoIni)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Saldo Ant c/Funcionário : ', lnSaldoaFun)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Entradas : ', lnTotalEntra)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Total de Entradas : ', lnSaldoIni + lnTotalEntra + lnSaldoaFun)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Saídas : ', lnTotalSaida)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Saldo : ', lnSaldoIni + lnTotalEntra - lnTotalSaida + lnSaldoaFun)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Saldo com Funcionários : ', lnSaldoFunc)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Pesagem : ', lnPesagem)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor) Values (lnLinha, .f., 'Total : ', lnPesagem + lnSaldoFunc)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor, Traco) Values (lnLinha, .f., 'Falha dos Funcionários : ', lnFalhaFunc, .t.)
Insert Into TmpImprime (Linha, Cabec, Titulo, Valor, Traco) Values (lnLinha, .f., 'Diferenca : ', lnSaldoIni + lnTotalEntra - lnTotalSaida + lnSaldoaFun - lnPesagem - lnSaldoFunc - lnFalhaFunc, .t.)
Select Entradas 
	Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2) Values (lnLinha2, .t., 'Resumo de Entradas')
	Select Entradas
		Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2, Emps) ;
	Select TmpImprime2
Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) Values (lnLinha2, .f., ' ', lnTotalEntra)
Select Saidas
	Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2) Values (lnLinha2, .t., 'Resumo de Saidas')
	Select Saidas
		Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2, Emps) ;
	Select TmpImprime2
Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) Values (lnLinha2, .f., ' ', lnTotalSaida)
Select Saldos
	Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2) Values (lnLinha2, .t., ' ')
	Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2) Values (lnLinha2, .t., 'Saldos das Fases')
	Select Saldos
		Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) Values (lnLinha2, .f., Saldos.Grupos, Saldos.Qtde)
	Select TmpImprime2
Insert Into TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) Values (lnLinha2, .f., ' ', lnSaldoFunc)
Select Falhas 
	Insert Into TmpImprime (Linha, Cabec, Titulo) Values (lnLinha, .t., Padc('Falhas das Fases',70))
	Insert Into TmpImprime (Linha, Cabec, Titulo) Values (lnLinha, .t., 'Setor           Entrada      Saida      Falha Gr         %')
	Select Falhas
		Insert Into TmpImprime (Linha, Cabec, Titulo, Valor, Valor1, Entrada, Saida, Falha) ;
	Select Falhas
	Select TmpImprime
	Insert Into TmpImprime (Linha, Cabec, Titulo, Valor, Valor1, Entrada, Saida, Falha) ;
Select T1.*, T2.* ;
  From TmpImprime T1 ;
  Full Join TmpImprime2 T2 ;
Insert Into Cabecalho (pNomeEmpresa, pRelTitulo, pPeriodo) ;
	Select TmpImp

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrFem.prg) - TRECHOS RELEVANTES PARA PASS SQL (1892 linhas total):

*-- Linhas 458 a 480:
458:             IF EMPTY(loc_cValor)
459:                 THIS.txt_4c_Demonstrativo.Value = ""
460:             ELSE
461:                 loc_cSQL = "SELECT TOP 1 Nome FROM SigPrDmo WHERE Nome = " + ;
462:                            EscaparSQL(loc_cValor)
463:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FemDmoVal")
464:                 IF loc_nResultado > 0 AND !EOF("cursor_4c_FemDmoVal")
465:                     SELECT cursor_4c_FemDmoVal
466:                     THIS.txt_4c_Demonstrativo.Value = ALLTRIM(cursor_4c_FemDmoVal.Nome)
467:                 ELSE
468:                     THIS.AbrirBuscaDemonstrativo()
469:                 ENDIF
470:                 IF USED("cursor_4c_FemDmoVal")
471:                     USE IN cursor_4c_FemDmoVal
472:                 ENDIF
473:             ENDIF
474:         CATCH TO loc_oErro
475:             MsgErro(loc_oErro.Message + CHR(13) + ;
476:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
477:                     "Procedure: " + loc_oErro.Procedure, ;
478:                     "Erro em FormSigPrFem.ValidarDemonstrativo")
479:         ENDTRY
480: 

*-- Linhas 513 a 531:
513:                 ENDIF
514: 
515:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_FemDmoBusca")
516:                     SELECT cursor_4c_FemDmoBusca
517:                     THIS.txt_4c_Demonstrativo.Value = ALLTRIM(cursor_4c_FemDmoBusca.Nome)
518:                 ENDIF
519: 
520:                 loc_oBusca.Release()
521:             ENDIF
522:         CATCH TO loc_oErro
523:             MsgErro(loc_oErro.Message + CHR(13) + ;
524:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
525:                     "Procedure: " + loc_oErro.Procedure, ;
526:                     "Erro em FormSigPrFem.AbrirBuscaDemonstrativo")
527:         ENDTRY
528: 
529:         IF USED("cursor_4c_FemDmoBusca")
530:             USE IN cursor_4c_FemDmoBusca
531:         ENDIF

*-- Linhas 579 a 600:
579:     *==========================================================================
580:     * Monta um dos 5 sub-containers de detalhe (par_cNome) dentro de
581:     * cnt_4c_Resultado: label lbl_4c_Titulo + grid grd_4c_Dados (3 colunas,
582:     * ReadOnly, sem RecordMark/DeleteMark - regra OPERACIONAL). O
583:     * RecordSource/ControlSource do grid NAO eh definido aqui: o cursor de
584:     * dados ainda nao existe (soh eh criado quando o botao Processar roda,
585:     * nas fases seguintes) - regra #41 (ControlSource antes do cursor
586:     * existir derruba o Init). Quem popular o grid mais adiante DEVE
587:     * reaplicar Column.Width/Header1.Caption depois de setar RecordSource
588:     * (RecordSource reseta ambos - Problema 48/regra #35c).
589:     *==========================================================================
590:         LOCAL loc_oDet
591: 
592:         THIS.cnt_4c_Resultado.AddObject(par_cNome, "Container")
593:         loc_oDet = EVALUATE("THIS.cnt_4c_Resultado." + par_cNome)
594:         WITH loc_oDet
595:             .Top       = par_nTop
596:             .Left      = par_nLeft
597:             .Width     = 294
598:             .Height    = 172
599:             .BackStyle = 0
600:             .Visible   = .F.

*-- Linhas 628 a 646:
628:             .FontSize          = 8
629:             .AllowHeaderSizing = .F.
630:             .AllowRowSizing    = .F.
631:             .DeleteMark        = .F.
632:             .RecordMark        = .F.
633:             .ReadOnly          = .T.
634:             .RowHeight         = 17
635:             .ScrollBars        = 2
636:             .GridLineColor     = RGB(238, 238, 238)
637:             .Visible           = .T.
638:         ENDWITH
639: 
640:         WITH loc_oDet.grd_4c_Dados.Column1
641:             .FontName          = "Tahoma"
642:             .FontSize          = 8
643:             .Width             = 110
644:             .Movable           = .F.
645:             .Resizable         = .F.
646:             .ReadOnly          = .T.

*-- Linhas 966 a 1033:
966:     *
967:     * Roda ANTES de compor o layout, como no legado (Load executa antes do
968:     * Init): assim os cursores ja existem quando CarregarDados() liga os
969:     * grids. Os AddObject dos grids NAO definem RecordSource/ControlSource
970:     * (regra #41 - ControlSource de cursor inexistente derruba o Init); todo
971:     * o bind vive em CarregarDados().
972:     *
973:     * DataSession = 2 (private): estes cursores pertencem a esta instancia do
974:     * form e morrem com ela.
975:     *==========================================================================
976:         LOCAL loc_oErro
977:         TRY
978:             *-- Entradas no periodo (legado: Entradas)
979:             IF USED("cursor_4c_Entradas")
980:                 USE IN cursor_4c_Entradas
981:             ENDIF
982:             CREATE CURSOR cursor_4c_Entradas (Emps C(3), TpOps C(15), Qtde N(12,3))
983:             INDEX ON Emps + TpOps TAG TpOps
984: 
985:             *-- Saidas no periodo (legado: Saidas)
986:             IF USED("cursor_4c_Saidas")
987:                 USE IN cursor_4c_Saidas
988:             ENDIF
989:             CREATE CURSOR cursor_4c_Saidas (Emps C(3), TpOps C(15), Qtde N(12,3))
990:             INDEX ON Emps + TpOps TAG TpOps
991: 
992:             *-- Saldo atual com funcionarios (legado: Saldos)
993:             IF USED("cursor_4c_Saldos")
994:                 USE IN cursor_4c_Saldos
995:             ENDIF
996:             CREATE CURSOR cursor_4c_Saldos (Grupos C(10), Contas C(10), Qtde N(12,3), Emps C(3))
997:             INDEX ON Grupos + Contas TAG GruConta
998: 
999:             *-- Saldo com funcionarios antes do periodo (legado: SaldoAnt)
1000:             IF USED("cursor_4c_SaldoAnt")
1001:                 USE IN cursor_4c_SaldoAnt
1002:             ENDIF
1003:             CREATE CURSOR cursor_4c_SaldoAnt (Grupos C(10), Contas C(10), Qtde N(12,3), Emps C(3))
1004:             INDEX ON Grupos + Contas TAG GruConta
1005: 
1006:             *-- Falhas dos funcionarios no periodo (legado: Falhas)
1007:             IF USED("cursor_4c_Falhas")
1008:                 USE IN cursor_4c_Falhas
1009:             ENDIF
1010:             CREATE CURSOR cursor_4c_Falhas (Grupos C(10), Contas C(10), Qtde N(12,3), ;
1011:                                             Entra N(12,3), Saida N(12,3), Emps C(3))
1012:             INDEX ON Grupos + Contas TAG GruConta
1013: 
1014:             *-- Cursor de trabalho do resumo por Grupo/Conta/Produto (legado: TmpResumo)
1015:             IF USED("cursor_4c_Resumo")
1016:                 USE IN cursor_4c_Resumo
1017:             ENDIF
1018:             CREATE CURSOR cursor_4c_Resumo (Flag L, Flag2 L, Grupo C(10), Conta C(10), ;
1019:                 CMats C(14), CUnis C(3), PesoEnts N(12,3), QtdeEnts N(12,3), ;
1020:                 PesoSais N(12,3), QtdeSais N(12,3), Saldoi N(12,3), Pesagem N(12,3), ;
1021:                 FReal N(12,3), FAdmin N(12,3), Saldof N(12,3), PesoPEnts N(12,3), ;
1022:                 PesoPSais N(12,3), PfTrabs N(9,2), Flag3 L, Varias N(1), ;
1023:                 PesoFabre N(12,3), PesoFabrs N(12,3), cUniPs C(3), CodCors C(4), ;
1024:                 CodTams C(4), Visivel L, Agregas N(1))
1025:             INDEX ON CMats + CodCors + CodTams TAG cpros
1026:             INDEX ON Grupo + Conta + CMats + CodCors + CodTams TAG GrConMat FOR Visivel
1027:         CATCH TO loc_oErro
1028:             MsgErro(loc_oErro.Message + CHR(13) + ;
1029:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1030:                     "Procedure: " + loc_oErro.Procedure, ;
1031:                     "Erro em FormSigPrFem.CriarCursoresResultado")
1032:         ENDTRY
1033:     ENDPROC

*-- Linhas 1100 a 1156:
1100:     *==========================================================================
1101:     * Aplica a UM dos 5 sub-containers de detalhe o bind que o legado faz em
1102:     * bloco: torna o container e a grade visiveis, posiciona o cursor no topo,
1103:     * define RecordSource + ControlSource das 3 colunas, os captions e - por
1104:     * ULTIMO - as larguras do dump. A 3a coluna eh sempre Emps/"Emp" nos
1105:     * cinco grids do legado.
1106:     *
1107:     * Por que a largura vem DEPOIS do RecordSource: atribuir RecordSource/
1108:     * ControlSource faz o VFP recalcular as larguras para o default 90 e
1109:     * resetar os Header1.Caption (Problema 48 / regra #35c) - definir antes
1110:     * seria descartado.
1111:     *
1112:     * Sem o GO TOP + Refresh a grade nao repinta as linhas inseridas depois
1113:     * de o cursor ter nascido vazio: o cursor fica cheio e a tela parece sem
1114:     * dados (o legado fecha cada bloco com Select <cursor> / Go Top / .Refresh
1115:     * pelo mesmo motivo).
1116:     *==========================================================================
1117:         LOCAL loc_oDet, loc_oGrid
1118: 
1119:         IF !USED(par_cCursor)
1120:             RETURN
1121:         ENDIF
1122: 
1123:         *-- Os 5 sub-containers de detalhe sao filhos de cnt_4c_Resultado, nao
1124:         *-- do Form (Left/Top no dump sao relativos ao container Resultado).
1125:         loc_oDet = EVALUATE("THIS.cnt_4c_Resultado." + par_cContainer)
1126:         loc_oDet.Visible = .T.
1127: 
1128:         loc_oGrid = loc_oDet.grd_4c_Dados
1129:         loc_oGrid.Visible = .T.
1130: 
1131:         SELECT (par_cCursor)
1132:         GO TOP
1133: 
1134:         WITH loc_oGrid
1135:             .ColumnCount             = 3
1136:             .RecordSource            = par_cCursor
1137:             .Column1.ControlSource   = par_cCursor + "." + par_cCampo1
1138:             .Column1.Header1.Caption = par_cCaption1
1139:             .Column2.ControlSource   = par_cCursor + "." + par_cCampo2
1140:             .Column2.Header1.Caption = par_cCaption2
1141:             .Column3.ControlSource   = par_cCursor + ".Emps"
1142:             .Column3.Header1.Caption = "Emp"
1143: 
1144:             *-- Larguras do dump, reaplicadas DEPOIS do RecordSource
1145:             .Column1.Width = 110
1146:             .Column2.Width = 80
1147:             .Column3.Width = 40
1148: 
1149:             .Refresh()
1150:         ENDWITH
1151:     ENDPROC
1152: 
1153:     *==========================================================================
1154:     PROTECTED PROCEDURE AtualizarResumo()
1155:     *==========================================================================
1156:     * Espelha nos 10 TextBox ReadOnly de cnt_4c_Resumo os totais calculados

*-- Linhas 1435 a 1453:
1435:     * BtnVisualizarClick - evento do botao Video (SIGPRFEM.Visualizar.Click)
1436:     *
1437:     * Legado:
1438:     *   If thisform.resultado.Visible / Select TmpImp / Go Top / If !Eof()
1439:     *       Report Form SIGPRFEM Preview NoConsole
1440:     *
1441:     * O "resultado.Visible" do legado eh o gate: sem ter processado, o botao
1442:     * nao faz nada. Aqui o gate eh o mesmo container (cnt_4c_Resultado) mais a
1443:     * flag this_lResultadoPronto, que so fica .T. quando os cursores de
1444:     * impressao foram montados - assim o clique antes de processar avisa em vez
1445:     * de abrir um preview vazio.
1446:     *==========================================================================
1447:     PROCEDURE BtnVisualizarClick()
1448:         LOCAL loc_oErro
1449: 
1450:         IF !THIS.ResultadoDisponivel()
1451:             RETURN
1452:         ENDIF
1453: 

*-- Linhas 1506 a 1543:
1506: 
1507:         IF THIS.cnt_4c_Resultado.Visible AND THIS.this_lResultadoPronto AND ;
1508:            USED("TmpImp")
1509:             SELECT TmpImp
1510:             GO TOP
1511:             loc_lPronto = !EOF("TmpImp")
1512:         ENDIF
1513: 
1514:         IF !loc_lPronto
1515:             MsgAviso("Processe a an" + CHR(225) + "lise antes de emitir o relat" + ;
1516:                      CHR(243) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
1517:         ENDIF
1518: 
1519:         RETURN loc_lPronto
1520:     ENDFUNC
1521: 
1522:     *==========================================================================
1523:     * MontarCursoresImpressao - bloco "Criando a Impressao" do fim de
1524:     * Processar.Click legado.
1525:     *
1526:     * Monta TmpImprime (coluna da esquerda: totais e falhas por fase),
1527:     * TmpImprime2 (coluna da direita: resumo de entradas/saidas/saldos), faz o
1528:     * FULL JOIN das duas em TmpImp e cria o cursor Cabecalho.
1529:     *
1530:     * Os nomes TmpImp/Cabecalho e os nomes de campo (Linha/Cabec/Titulo/Valor/
1531:     * Traco/Entrada/Saida/Falha/Linha2/Cabec2/Titulo2/Valor2/Traco2/Emps) NAO
1532:     * levam o prefixo cursor_4c_ nem sufixo _4c_: sao contrato do SigPrFem.frx,
1533:     * que veio do legado sem alteracao (PILAR 1/2). Renomear aqui quebraria
1534:     * todas as expressoes do FRX.
1535:     *
1536:     * As somas usadas nas linhas do relatorio vem das properties this_n* do BO
1537:     * (FONTE UNICA - regra #17): o total nao eh recalculado aqui.
1538:     *==========================================================================
1539:     PROTECTED FUNCTION MontarCursoresImpressao()
1540:         LOCAL loc_lSucesso, loc_oErro, loc_oBO
1541:         LOCAL loc_nLinha, loc_nLinha2, loc_nPerc
1542:         LOCAL loc_nQEnt, loc_nQSai, loc_nQFalha, loc_cOrdem
1543: 

*-- Linhas 1549 a 1741:
1549:             IF USED("TmpImprime2")
1550:                 USE IN TmpImprime2
1551:             ENDIF
1552:             CREATE CURSOR TmpImprime2 (Linha2 N(3), Cabec2 L, Titulo2 C(40), ;
1553:                                        Valor2 N(12,3), Traco2 L, Emps C(3))
1554: 
1555:             IF USED("TmpImprime")
1556:                 USE IN TmpImprime
1557:             ENDIF
1558:             CREATE CURSOR TmpImprime (Linha N(3), Cabec L, Titulo C(80), Valor N(12,3), ;
1559:                                       Valor1 N(11,3), Traco L, Entrada N(12,3), ;
1560:                                       Saida N(12,3), Falha L)
1561: 
1562:             *-- Coluna da esquerda: os 11 totalizadores, na ordem do legado
1563:             loc_nLinha = 1
1564:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1565:                  VALUES (loc_nLinha, .F., "Saldo Inicial : ", loc_oBO.this_nSaldoInicial)
1566:             loc_nLinha = loc_nLinha + 1
1567:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1568:                  VALUES (loc_nLinha, .F., "Saldo Ant c/Funcion" + CHR(225) + "rio : ", ;
1569:                          loc_oBO.this_nSaldoAnterior)
1570:             loc_nLinha = loc_nLinha + 1
1571:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1572:                  VALUES (loc_nLinha, .F., "Entradas : ", loc_oBO.this_nEntradas)
1573:             loc_nLinha = loc_nLinha + 1
1574:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1575:                  VALUES (loc_nLinha, .F., "Total de Entradas : ", loc_oBO.this_nTotalEntradas)
1576:             loc_nLinha = loc_nLinha + 1
1577:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1578:                  VALUES (loc_nLinha, .F., "Sa" + CHR(237) + "das : ", loc_oBO.this_nSaidas)
1579:             loc_nLinha = loc_nLinha + 1
1580:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1581:                  VALUES (loc_nLinha, .F., "Saldo : ", loc_oBO.this_nSaldo)
1582:             loc_nLinha = loc_nLinha + 1
1583:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1584:                  VALUES (loc_nLinha, .F., "Saldo com Funcion" + CHR(225) + "rios : ", ;
1585:                          loc_oBO.this_nSaldoFuncionarios)
1586:             loc_nLinha = loc_nLinha + 1
1587:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1588:                  VALUES (loc_nLinha, .F., "Pesagem : ", loc_oBO.this_nPesagem)
1589:             loc_nLinha = loc_nLinha + 1
1590:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
1591:                  VALUES (loc_nLinha, .F., "Total : ", loc_oBO.this_nSaldoTotal)
1592:             loc_nLinha = loc_nLinha + 1
1593:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Traco) ;
1594:                  VALUES (loc_nLinha, .F., "Falha dos Funcion" + CHR(225) + "rios : ", ;
1595:                          loc_oBO.this_nFalhaFuncionarios, .T.)
1596:             loc_nLinha = loc_nLinha + 1
1597:             INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Traco) ;
1598:                  VALUES (loc_nLinha, .F., "Diferenca : ", ;
1599:                          loc_oBO.this_nSaldo - loc_oBO.this_nPesagem - ;
1600:                          loc_oBO.this_nSaldoFuncionarios - loc_oBO.this_nFalhaFuncionarios, .T.)
1601: 
1602:             *-- Coluna da direita: resumo de entradas / saidas / saldos das fases
1603:             loc_nLinha2 = 0
1604: 
1605:             SELECT cursor_4c_Entradas
1606:             GO TOP
1607:             IF !EOF()
1608:                 loc_nLinha2 = loc_nLinha2 + 1
1609:                 INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
1610:                      VALUES (loc_nLinha2, .T., "Resumo de Entradas")
1611: 
1612:                 SELECT cursor_4c_Entradas
1613:                 SCAN
1614:                     loc_nLinha2 = loc_nLinha2 + 1
1615:                     INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2, Emps) ;
1616:                          VALUES (loc_nLinha2, .F., cursor_4c_Entradas.TpOps, ;
1617:                                  cursor_4c_Entradas.Qtde, cursor_4c_Entradas.Emps)
1618:                     SELECT cursor_4c_Entradas
1619:                 ENDSCAN
1620:                 REPLACE Traco2 WITH .T. IN TmpImprime2
1621:             ENDIF
1622: 
1623:             loc_nLinha2 = loc_nLinha2 + 1
1624:             INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
1625:                  VALUES (loc_nLinha2, .F., " ", loc_oBO.this_nEntradas)
1626: 
1627:             SELECT cursor_4c_Saidas
1628:             GO TOP
1629:             IF !EOF()
1630:                 loc_nLinha2 = loc_nLinha2 + 1
1631:                 INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
1632:                      VALUES (loc_nLinha2, .T., "Resumo de Saidas")
1633: 
1634:                 SELECT cursor_4c_Saidas
1635:                 SCAN
1636:                     loc_nLinha2 = loc_nLinha2 + 1
1637:                     INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2, Emps) ;
1638:                          VALUES (loc_nLinha2, .F., ;
1639:                                  IIF(EMPTY(cursor_4c_Saidas.TpOps), "PRODUZIDO", cursor_4c_Saidas.TpOps), ;
1640:                                  cursor_4c_Saidas.Qtde, cursor_4c_Saidas.Emps)
1641:                     SELECT cursor_4c_Saidas
1642:                 ENDSCAN
1643:                 REPLACE Traco2 WITH .T. IN TmpImprime2
1644:             ENDIF
1645: 
1646:             loc_nLinha2 = loc_nLinha2 + 1
1647:             INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
1648:                  VALUES (loc_nLinha2, .F., " ", loc_oBO.this_nSaidas)
1649: 
1650:             SELECT cursor_4c_Saldos
1651:             GO TOP
1652:             IF !EOF()
1653:                 loc_nLinha2 = loc_nLinha2 + 1
1654:                 INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
1655:                      VALUES (loc_nLinha2, .T., " ")
1656:                 loc_nLinha2 = loc_nLinha2 + 1
1657:                 INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
1658:                      VALUES (loc_nLinha2, .T., "Saldos das Fases")
1659: 
1660:                 SELECT cursor_4c_Saldos
1661:                 SCAN
1662:                     loc_nLinha2 = loc_nLinha2 + 1
1663:                     INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
1664:                          VALUES (loc_nLinha2, .F., cursor_4c_Saldos.Grupos, cursor_4c_Saldos.Qtde)
1665:                     SELECT cursor_4c_Saldos
1666:                 ENDSCAN
1667:                 REPLACE Traco2 WITH .T. IN TmpImprime2
1668:             ENDIF
1669: 
1670:             loc_nLinha2 = loc_nLinha2 + 1
1671:             INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
1672:                  VALUES (loc_nLinha2, .F., " ", loc_oBO.this_nSaldoFuncionarios)
1673: 
1674:             *-- Falhas por fase - a coluna "%" eh Falha/Saida*100 (regra do legado:
1675:             *-- percentual sobre a SAIDA, nao sobre a entrada).
1676:             *-- O guard de Saida = 0 eh o UNICO desvio: o legado divide direto e
1677:             *-- estoura "Divisao por zero" numa fase sem saida no periodo,
1678:             *-- derrubando a montagem do relatorio inteiro.
1679:             SELECT cursor_4c_Falhas
1680:             GO TOP
1681:             IF !EOF()
1682:                 loc_nLinha = loc_nLinha + 1
1683:                 INSERT INTO TmpImprime (Linha, Cabec, Titulo) ;
1684:                      VALUES (loc_nLinha, .T., PADC("Falhas das Fases", 70))
1685:                 loc_nLinha = loc_nLinha + 1
1686:                 INSERT INTO TmpImprime (Linha, Cabec, Titulo) ;
1687:                      VALUES (loc_nLinha, .T., ;
1688:                              "Setor           Entrada      Saida      Falha Gr         %")
1689: 
1690:                 SELECT cursor_4c_Falhas
1691:                 SCAN
1692:                     loc_nLinha = loc_nLinha + 1
1693:                     loc_nPerc  = IIF(cursor_4c_Falhas.Saida = 0, 0, ;
1694:                                      cursor_4c_Falhas.Qtde / cursor_4c_Falhas.Saida * 100)
1695:                     INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Valor1, ;
1696:                                             Entrada, Saida, Falha) ;
1697:                          VALUES (loc_nLinha, .F., cursor_4c_Falhas.Grupos, ;
1698:                                  cursor_4c_Falhas.Qtde, loc_nPerc, cursor_4c_Falhas.Entra, ;
1699:                                  cursor_4c_Falhas.Saida, .T.)
1700:                     SELECT cursor_4c_Falhas
1701:                 ENDSCAN
1702: 
1703:                 SELECT cursor_4c_Falhas
1704:                 SUM Entra, Saida, Qtde TO loc_nQEnt, loc_nQSai, loc_nQFalha
1705:                 loc_nPerc = IIF(loc_nQSai = 0, 0, loc_nQFalha / loc_nQSai * 100)
1706: 
1707:                 REPLACE Traco WITH .T. IN TmpImprime
1708:                 loc_nLinha = loc_nLinha + 1
1709:                 INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Valor1, ;
1710:                                         Entrada, Saida, Falha) ;
1711:                      VALUES (loc_nLinha, .F., " ", loc_nQFalha, loc_nPerc, ;
1712:                              loc_nQEnt, loc_nQSai, .T.)
1713:             ENDIF
1714: 
1715:             *-- FULL JOIN das duas colunas, ordenado pela mais longa
1716:             loc_cOrdem = "T1.Linha"
1717:             IF loc_nLinha2 > loc_nLinha
1718:                 loc_cOrdem = "T2.Linha2"
1719:             ENDIF
1720: 
1721:             IF USED("TmpImp")
1722:                 USE IN TmpImp
1723:             ENDIF
1724:             SELECT T1.*, T2.* ;
1725:               FROM TmpImprime T1 ;
1726:               FULL JOIN TmpImprime2 T2 ;
1727:                 ON T1.Linha = T2.Linha2 ;
1728:               INTO CURSOR TmpImp ;
1729:              ORDER BY &loc_cOrdem.
1730: 
1731:             *-- Cabecalho do FRX (razao social da empresa + titulo + periodo)
1732:             IF !THIS.MontarCabecalhoImpressao()
1733:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel montar o cabe" + ;
1734:                          CHR(231) + "alho do relat" + CHR(243) + "rio.", ;
1735:                          "Aten" + CHR(231) + CHR(227) + "o")
1736:             ENDIF
1737: 
1738:             loc_lSucesso = USED("TmpImp")
1739:         CATCH TO loc_oErro
1740:             MsgErro(loc_oErro.Message + CHR(13) + ;
1741:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 1751 a 1801:
1751:     *
1752:     * Legado:
1753:     *   CursorQuery('SigCdEmp', 'crSigCdEmp', 'Cemps', _Empr, 'Razas')
1754:     *   Create Cursor Cabecalho(pNomeEmpresa c(60), pRelTitulo c(60), pPeriodo c(60))
1755:     *   Insert ... Values (crSigCdEmp.Razas, 'Analise de Producao',
1756:     *                      'Periodo : ' + Dtoc(ldDatai) + ' ate ' + Dtoc(ldDataf))
1757:     *
1758:     * SigCdEmp usa Cemps/Razas (nao Cemps/Razas) - conferido em docs/schema.sql.
1759:     *==========================================================================
1760:     PROTECTED FUNCTION MontarCabecalhoImpressao()
1761:         LOCAL loc_cRazao, loc_nRet, loc_cSQL, loc_oBO
1762: 
1763:         loc_oBO   = THIS.this_oBusinessObject
1764:         loc_cRazao = ""
1765: 
1766:         IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1767:             IF USED("cursor_4c_CdEmp")
1768:                 USE IN cursor_4c_CdEmp
1769:             ENDIF
1770:             loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
1771:                        EscaparSQL(go_4c_Sistema.cCodEmpresa)
1772:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CdEmp")
1773:             IF loc_nRet >= 1 AND USED("cursor_4c_CdEmp") AND !EOF("cursor_4c_CdEmp")
1774:                 loc_cRazao = ALLTRIM(TratarNulo(cursor_4c_CdEmp.Razas, ""))
1775:             ENDIF
1776:         ENDIF
1777: 
1778:         IF EMPTY(loc_cRazao)
1779:             loc_cRazao = ALLTRIM(go_4c_Sistema.cEmpresa)
1780:         ENDIF
1781: 
1782:         IF USED("Cabecalho")
1783:             USE IN Cabecalho
1784:         ENDIF
1785:         CREATE CURSOR Cabecalho (pNomeEmpresa C(60), pRelTitulo C(60), pPeriodo C(60))
1786:         INSERT INTO Cabecalho (pNomeEmpresa, pRelTitulo, pPeriodo) ;
1787:              VALUES (loc_cRazao, ;
1788:                      "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o", ;
1789:                      "Per" + CHR(237) + "odo : " + DTOC(loc_oBO.this_dDataInicial) + ;
1790:                      " at" + CHR(233) + " " + DTOC(loc_oBO.this_dDataFinal))
1791: 
1792:         RETURN USED("Cabecalho")
1793:     ENDFUNC
1794: 
1795:     *==========================================================================
1796:     * ExecutarReportForm - helper canonico de REPORT FORM
1797:     *
1798:     * Combina o que o REPORT FORM cru do legado nao tem e sem o que o relatorio
1799:     * sai errado ou nao sai:
1800:     *   1. guard de EXISTENCIA do FRX (o legado usa "Report Form SIGPRFEM"
1801:     *      BARE, e o VFP9 procuraria o arquivo no diretorio corrente);

*-- Linhas 1823 a 1841:
1823:                          "Aten" + CHR(231) + CHR(227) + "o")
1824:                 RETURN .F.
1825:             ENDIF
1826:             SELECT (par_cCursorDados)
1827:             GO TOP
1828:         ENDIF
1829: 
1830:         loc_cPointOrig    = SET("POINT")
1831:         loc_cSepOrig      = SET("SEPARATOR")
1832:         loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
1833:         SET POINT TO "."
1834:         SET SEPARATOR TO ","
1835:         SET REPORTBEHAVIOR 80
1836: 
1837:         DO CASE
1838:             CASE par_cModo == "PREVIEW"
1839:                 REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
1840:             CASE par_cModo == "PRINTER_PROMPT"
1841:                 REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE

