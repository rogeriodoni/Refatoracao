# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (12)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, ETQSEPS, CPROS, LNTPETI, EMPOS, NTIPOS, TPESPES, CEMPS, CODIGOS, X, 0, I, IMPETIQS, EMPDOPNUMS, CBARS, DATAS, COLECOES, CGRUS, SGRUS, GRUPOS, CONTAS, LOCALIZAS, PROMOS, LINHAS, LOCALS, PQTD, CITENS, LNI, NSITUAS, NTPIMPRES, USUACESS, CIMPS, USUARIOS, LNIMPRES, CBARS_OLD, ATIVAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'IMPRES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, ETQSEPS, CPROS, LNTPETI, EMPOS, NTIPOS, TPESPES, CEMPS, CODIGOS, X, 0, I, IMPETIQS, EMPDOPNUMS, CBARS, DATAS, COLECOES, CGRUS, SGRUS, GRUPOS, CONTAS, LOCALIZAS, PROMOS, LINHAS, LOCALS, PQTD, CITENS, LNI, NSITUAS, NTPIMPRES, USUACESS, CIMPS, USUARIOS, LNIMPRES, CBARS_OLD, ATIVAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RECORDSOURCE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, ETQSEPS, CPROS, LNTPETI, EMPOS, NTIPOS, TPESPES, CEMPS, CODIGOS, X, 0, I, IMPETIQS, EMPDOPNUMS, CBARS, DATAS, COLECOES, CGRUS, SGRUS, GRUPOS, CONTAS, LOCALIZAS, PROMOS, LINHAS, LOCALS, PQTD, CITENS, LNI, NSITUAS, NTPIMPRES, USUACESS, CIMPS, USUARIOS, LNIMPRES, CBARS_OLD, ATIVAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TAG' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, ETQSEPS, CPROS, LNTPETI, EMPOS, NTIPOS, TPESPES, CEMPS, CODIGOS, X, 0, I, IMPETIQS, EMPDOPNUMS, CBARS, DATAS, COLECOES, CGRUS, SGRUS, GRUPOS, CONTAS, LOCALIZAS, PROMOS, LINHAS, LOCALS, PQTD, CITENS, LNI, NSITUAS, NTPIMPRES, USUACESS, CIMPS, USUARIOS, LNIMPRES, CBARS_OLD, ATIVAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, ETQSEPS, CPROS, LNTPETI, EMPOS, NTIPOS, TPESPES, CEMPS, CODIGOS, X, 0, I, IMPETIQS, EMPDOPNUMS, CBARS, DATAS, COLECOES, CGRUS, SGRUS, GRUPOS, CONTAS, LOCALIZAS, PROMOS, LINHAS, LOCALS, PQTD, CITENS, LNI, NSITUAS, NTPIMPRES, USUACESS, CIMPS, USUARIOS, LNIMPRES, CBARS_OLD, ATIVAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'JUSTIFS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, ETQSEPS, CPROS, LNTPETI, EMPOS, NTIPOS, TPESPES, CEMPS, CODIGOS, X, 0, I, IMPETIQS, EMPDOPNUMS, CBARS, DATAS, COLECOES, CGRUS, SGRUS, GRUPOS, CONTAS, LOCALIZAS, PROMOS, LINHAS, LOCALS, PQTD, CITENS, LNI, NSITUAS, NTPIMPRES, USUACESS, CIMPS, USUARIOS, LNIMPRES, CBARS_OLD, ATIVAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, ETQSEPS, CPROS, LNTPETI, EMPOS, NTIPOS, TPESPES, CEMPS, CODIGOS, X, 0, I, IMPETIQS, EMPDOPNUMS, CBARS, DATAS, COLECOES, CGRUS, SGRUS, GRUPOS, CONTAS, LOCALIZAS, PROMOS, LINHAS, LOCALS, PQTD, CITENS, LNI, NSITUAS, NTPIMPRES, USUACESS, CIMPS, USUARIOS, LNIMPRES, CBARS_OLD, ATIVAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, ETQSEPS, CPROS, LNTPETI, EMPOS, NTIPOS, TPESPES, CEMPS, CODIGOS, X, 0, I, IMPETIQS, EMPDOPNUMS, CBARS, DATAS, COLECOES, CGRUS, SGRUS, GRUPOS, CONTAS, LOCALIZAS, PROMOS, LINHAS, LOCALS, PQTD, CITENS, LNI, NSITUAS, NTPIMPRES, USUACESS, CIMPS, USUARIOS, LNIMPRES, CBARS_OLD, ATIVAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OCOETIQS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, ETQSEPS, CPROS, LNTPETI, EMPOS, NTIPOS, TPESPES, CEMPS, CODIGOS, X, 0, I, IMPETIQS, EMPDOPNUMS, CBARS, DATAS, COLECOES, CGRUS, SGRUS, GRUPOS, CONTAS, LOCALIZAS, PROMOS, LINHAS, LOCALS, PQTD, CITENS, LNI, NSITUAS, NTPIMPRES, USUACESS, CIMPS, USUARIOS, LNIMPRES, CBARS_OLD, ATIVAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CUNIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, ETQSEPS, CPROS, LNTPETI, EMPOS, NTIPOS, TPESPES, CEMPS, CODIGOS, X, 0, I, IMPETIQS, EMPDOPNUMS, CBARS, DATAS, COLECOES, CGRUS, SGRUS, GRUPOS, CONTAS, LOCALIZAS, PROMOS, LINHAS, LOCALS, PQTD, CITENS, LNI, NSITUAS, NTPIMPRES, USUACESS, CIMPS, USUARIOS, LNIMPRES, CBARS_OLD, ATIVAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DISTRIBS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, ETQSEPS, CPROS, LNTPETI, EMPOS, NTIPOS, TPESPES, CEMPS, CODIGOS, X, 0, I, IMPETIQS, EMPDOPNUMS, CBARS, DATAS, COLECOES, CGRUS, SGRUS, GRUPOS, CONTAS, LOCALIZAS, PROMOS, LINHAS, LOCALS, PQTD, CITENS, LNI, NSITUAS, NTPIMPRES, USUACESS, CIMPS, USUARIOS, LNIMPRES, CBARS_OLD, ATIVAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MERCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, ETQSEPS, CPROS, LNTPETI, EMPOS, NTIPOS, TPESPES, CEMPS, CODIGOS, X, 0, I, IMPETIQS, EMPDOPNUMS, CBARS, DATAS, COLECOES, CGRUS, SGRUS, GRUPOS, CONTAS, LOCALIZAS, PROMOS, LINHAS, LOCALS, PQTD, CITENS, LNI, NSITUAS, NTPIMPRES, USUACESS, CIMPS, USUARIOS, LNIMPRES, CBARS_OLD, ATIVAS

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
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  ControlSource = "dbetiqueta.datas"
  ControlSource = "dbetiqueta.cpros"
  ControlSource = "dbetiqueta.cpros"
  ControlSource = "dbetiqueta.pesos"
  ControlSource = "dbetiqueta.qtds"
  ControlSource = ""
If ThisForm.ParentForm.poDataMgr.SqlExecute([Select * From SigEtOco Where Cods = ']+lcOcEti+[' ],'TmpOcEti') < 1
Select TmpOcEti
	SELECT dbImpressao
	Select DbEtiqueta
		oProg.Update(.T.)
				Insert Into DbImpressao From Memvar
				Insert Into DbImpressao (cpros, Qtds, QtdeEtiq, Pedido, Obs, Pvens, Moedas, Empos, cpros1, Pvens, PrecoDe, Parcelas) ;
		Select DbEtiqueta
			oProg.Update(.T.)
					Insert Into DbImpressao From Memvar
						Insert Into DbImpressao (Cpros, Qtds, Cbars, Obs, cpros1) ;
							Insert Into DbImpressao (Cpros, Qtds, QtdeEtiq, Pedido, Obs, Pvens, Moedas, Empos, cpros1, CodTams, PrecoDe, Parcelas) ;
							Insert Into DbImpressao (Cpros, Qtds, QtdeEtiq, Pedido, Obs, Pvens, Moedas, Empos, cpros1, CodTams, PrecoDe, Parcelas) ;
		Select DbImpressao
						Select DbImpressao
							lcQuery = [Select PVIdeals, Moedas, PVens, Moevs, PrecoDe ] + ;
									    [From SigCdPro ] + ;
							If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
							Select LocalPro
					lcQuery = [Update SigCdPro Set ImpEtiqs = ?pTru Where CPros = '] + lcBrr + [']
					If (ThisForm.poDataGrv.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigCdPro)')
						Update crSigCdPro Set ImpEtiqs = .T. Where CPros = lcBrr
				Select DbImpressao
					Insert Into crSigEtOcr (Cbars, Datas, Horas, Usuars, Qtds, Cods, Justifs, cIdChaves) ;
				If Not ThisForm.poDataGrv.Update('crSigEtOcr')
					=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigEtOcr 1)')
		Select dbEtiqueta
				oProg.Update(.T.)
					Insert Into DbImpressao From Memvar
						Insert Into DbImpressao (Cpros, Qtds, QtdeEtiq, Obs) ;
						Insert Into DbImpressao (Cpros, Qtds, QtdeEtiq, Pedido, Obs) ;
			Select DbImpressao
						lcQuery = [Update SigCdPro Set ImpEtiqs = ?pTru Where CPros = '] + lcBrr + [']
						If (ThisForm.poDataGrv.SqlExecute(lcQuery, '') < 1)
							=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigCdPro)')
							Update crSigCdPro Set ImpEtiqs = .T. Where CPros = lcBrr
					Select DbImpressao
						Insert Into crSigEtOcr (Cbars, Datas, Horas, Usuars, Qtds, Cods, Justifs, cIdChaves) ;
					If Not ThisForm.poDataGrv.Update('crSigEtOcr')
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigEtOcr 2)')
	Select crSigMvCab
	Select CrSigMvItn
	Select CrSigMvIts
	Select Empos,Grupos,Contas,Cpros,Cbars,CodCors,CodTams,Qtds,Pesos From DbEtiqueta ;
	Select CsSelecao
			Insert Into CrSigMvCab (Datars,Datas,Dopes,Emps,Numes,MascNum,GrupoOs,ContaOs,CIdChaves,DtAlts,EmpDopNums,Usuars) ;
		lcSql = [Select Moevs,Pvens,Dpros,cUnis From SigCdPro Where Cpros = ']+CsSelecao.Cpros+[']
		ThisForm.Podatagrv.Sqlexecute(lcSql,'LocalPro')
		Insert Into CrSigMvItn (CPros,Dopes,Emps,Numes,Opers,Qtds,Pesos,CItens,Units,Totas,Moedas,DPros,CUnis,;
			Insert Into crSigMvIts (qtds, cpros, Dopes, emps, numes, codcors, ;
	If Not ThisForm.poDataGrv.Update('CrSigMvCab')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - CrSigMvCab)')
	If Not ThisForm.poDataGrv.Update('CrSigMvItn')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - CrSigMvItn)')
	If Not ThisForm.poDataGrv.Update('CrSigMvIts')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - CrSigMvIts)')
SELECT LocalTpEti
	ThisForm.ParentForm.poDataMgr.Sqlexecute('select cemps, razas from SigCdEmp', 'crSigCdEmp')
	ThisForm.ParentForm.poDataMgr.Sqlexecute('select observas, codigos from SigCdObs', 'crSigCdObs')
	Select DbEtiqueta
		oProg.Update(.T.)
			SELECT crSigCdEmp
			SELECT crSigCdObs
			lcSql = [Select dpros, PVIdeals, Moedas, PVens, Moevs From SigCdPro Where Cpros = ']+DbEtiqueta.Cpros+[']
			ThisForm.Podatagrv.Sqlexecute(lcSql,'LocalPro')
				Select LocalPro
			Insert Into DbImpressao (Cpros, Cbars, dpros, pvens, razas, reffs, codtams, codcors) ;
	SELECT DbImpressao
					lcQuery = [Update SigCdPro Set ImpEtiqs = ?pTru Where CPros = '] + lcBrr + [']
					If (ThisForm.poDataGrv.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigCdPro)')
						Update crSigCdPro Set ImpEtiqs = .T. Where CPros = lcBrr
lnOldSel = Select()
	Select Max(cpros) as Cpros, Max(Qtds) as Qtds, Max(QtdeEtiq) as QtdeEtiq, Max(Pedido) as Pedido, ;
	From DbImpressao ;
	Select DbImpressao
	Select csConjunto
		Select DbImpressao
	Select DbImpressao
		Select LocalEti
		Select *, .F. As Flag, 000000000.00 As PrecoDe, 000000000.00 As pvens, 00 As Parcelas, Space(3) As Moedas, Space(40) As Reffs, ;
			From LocalEti Where 0=1 ;
			.Column2.ControlSource = 'DbEtiqueta.Flag'
			.Column1.ControlSource  = 'DbEtiqueta.Datas'
			.Column3.ControlSource  = 'DbEtiqueta.CPros'
			.Column4.ControlSource  = 'DbEtiqueta.CBars'
			.Column5.ControlSource  = 'DbEtiqueta.PrecoDe'
			.Column6.ControlSource  = 'DbEtiqueta.pVens'
			.Column7.ControlSource  = 'DbEtiqueta.Qtds'
			.Column8.ControlSource  = 'DbEtiqueta.ObsEtiqs'
			.Column9.ControlSource  = 'DbEtiqueta.Reffs'
			.Column10.ControlSource = 'DbEtiqueta.Parcelas'
			.Column11.ControlSource = 'DbEtiqueta.PrecoDeCJ'
			.Column12.ControlSource = 'DbEtiqueta.pVensCJ'
			Select LocalEti
			Insert Into DbEtiqueta From Memvar
				Select dbImpressao
					Select LocalEti
					Insert Into DbEtiqueta From Memvar
				Select csRelatorio
					Select LocalEti
					Insert Into DbEtiqueta From Memvar
			Select LocalEti
			Select * From LocalEti Where 0=1 Into Cursor TmpEti Readwrite
			lStrQuery = [Select c.EmpOs, c.Grupos, c.Contas, a.CPros, c.CBars, c.pesos, c.qtds, c.datas, a.pvens, a.precode, a.cGrus, a.Categoria ] + ;
				[From SigCdPro a, SigOpEtq c ] + ;
			If (Thisform.ParentForm.poDataMgr.SqlExecute(lStrQuery, 'TmpTmp1') < 1)
			Select TmpTmp1
				lStrQuery = [Select Top 1 UsuaAlts ] + ;
					[From SigCdPrc ] + ;
				If (Thisform.ParentForm.poDataMgr.SqlExecute(lStrQuery, 'TmpUltimo') < 1)
					Select TmpTmp1
					Insert Into DbEtiqueta From Memvar
			Select DbEtiqueta
			Select LocalEti
			Select * From LocalEti Where 0=1 Into Cursor TmpEti Readwrite
			lcQuery = [Select b.*, a.pvens, a.precode, a.cGrus, a.Categoria ] + ;
				[From SigOpEtq b ] + ;
				[Join SigCdpro a on a.cpros = b.cpros ] + ;
			If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'TmpTmp2') < 1)
			Select TmpTmp2
				Insert Into DbEtiqueta From Memvar
			Select DbEtiqueta
				Select LocalEti
				Select * From LocalEti Where 0=1 Into Cursor TmpEti Readwrite
					lcQuery = [Select b.*, a.pvens, a.precode, a.cGrus, a.Categoria ] + ;
						[From SigOpEtq b ] + ;
						[Join SigCdpro a on a.cpros = b.cpros ] + ;
					lcQuery = [Select a.*, b.pvens, b.precode, b.cGrus, b.Categoria ] + ;
						[From SigOpEtq a, SigCdPro b ] +;
						Iif(Empty(pcPromos),'',[Inner Join SigPrPmi p On b.cpros = p.cpros ])+;
				If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'TmpEti') < 1)
				Select TmpEti
					Select TmpEti
					Insert Into DbEtiqueta From Memvar
					lcQuery = [Select Emps, Dopes, Numes, EmpDopNums ] + ;
						[From SigMvCab ] + ;
					If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'TprMvCab') < 1)
					Select TprMvCab
						Insert Into DbEtiqueta (Cpros, Qtds, CBars, ObsEtiqs, Dopes, EmpDopNums ) ;
					lcQuery = [Select b.CodBarras as BarraB, a.CodBarras as BarraA, a.Units, a.Moedas, a.EmpdopNums, p.Reffs, a.Opers, p.PrecoDe,p.cGrus,p.Categoria ] + ;
						[From SigMvItn a ] + ;
						[Left Join SigMvIts b ] + ;
						[Left Join SigCdPro p On a.Cpros = p.cpros ] + ;
					If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'TprMvCabI') < 1)
					Select Nvl(BarraB, BarraA) As CodBarras, Units, Moedas, EmpDopNums, Reffs, Opers, PrecoDe, cgrus, Categoria ;
						From TprMvCabI ;
					Select csItens
							Select LocalEti
								Insert Into DbEtiqueta From Memvar
			Select DbEtiqueta
				Insert Into crImpre	(impres) Values(Upper(laPrinters(lnI, 1)))
		Select LocalTpEti
		Select LocalTpEti
		lcQuery = [Select * From SigCdmp Where nTpImpres in (2,4)]
		If (Thisform.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalCimp') < 1)
		lcSql = [Select b.* From SigSyImp a, SigCdmp b Where a.UsuAcess = ']+Usuar+[' And a.cimps = b.impres ]+;
			[Select c.* From SigCdAcG a, SigSyImp b, SigCdmp c Where a.Usuarios=']+Usuar+[' ]+;
		If Thisform.ParentForm.poDataMgr.SqlExecute(lcSql,'CrTmpCimp') <= 0
		Select CrTmpCimp
			Select * From CrTmpCimp Into Cursor LocalcImp Readwrite
		Select LocalcImp
		Select Padr(Alltrim(a.impres),15)+' '+Alltrim(b.impres) As IDupla, b.impres, a.impres As impresS From LocalcImp a, crImpre b Where Alltrim(Upper(a.impres)) Like '%'+Alltrim(Upper(b.impres))+'%' ;
		Select * From crImp Order By 1 Into Cursor crImpreV
		Select crImpreV
		Select DbEtiqueta
			Select DbEtiqueta
	lStrQuery = [Select a.CPros,a.CBars ] + ;
			[From SigOpEtq a ] + ;
			[left join sigopeta b on a.cpros = b.cpros and a.cbars = b.cbars_new ] + ;
	If ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery,'CrEtiqs') < 1
	Select CrEtiqs
	lcQuery = [Select a.*, b.pvens, case when b.precode = 0 then b.pvens else b.precode end as precode ] + ;
		[From SigOpEtq a, SigCdPro b ] +;
	ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalEti')
	Select CBars ;
	  From DbEtiqueta ;
	Select LocalEti
	Select DbEtiqueta
	lcQuery = [Select Cemps, Razas ] + ;
			    [From SigCdEmp ] + ;
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalEmp') < 1)
	Select LocalEmp
		If Not Seek(lcEmD, 'csEmpresas', 'CEmps')
			Insert Into csEmpresas (ImpEmps, CEmps, Razas) Values (.T., lcEmD, LocalEmp.Razas)
	Select CEmps From csEmpresas Where ImpEmps Into Cursor csEmps 
	Select csEmps
		oProg.Update(.T.)
		Select CBars ;
		  From DbEtiqueta ;
		Select TmpEtiquetas
	Select dbEtiqueta
		lcQuery = [Update SigCdPro ] + ;
		If (ThisForm.poDataGrv.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigCdPro)')
Insert Into DbImpressao (Cpros, Qtds, Cbars, Obs) ;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpIpE.prg) - TRECHOS RELEVANTES PARA PASS SQL (5593 linhas total):

*-- Linhas 42 a 60:
42: *   CriarCursorEtiquetas                 o cursor que alimenta a grade
43: *                                         (DbEtiqueta no legado) + os 6
44: *                                         INDEX ON do Init legado
45: *   MontaGradeEtiquetas                  RecordSource + os 12 ControlSource
46: *                                         + o que o bind RESETA (larguras,
47: *                                         cabecalhos, CurrentControl,
48: *                                         Sparse, ReadOnly, ColumnOrder) +
49: *                                         GO TOP / Refresh
50: *   FormatarColunasGrade                 o bloco reaplicavel do acima
51: *   ConfigurarBotoes                     cntBotoes (4 botoes) e cmdTestaPos
52: *   AjustarBotoesPorTipoChamador         o "btnDepois.Enabled = .F. se
53: *                                         ParentForm.Tipo <> 'CADASTRO'" do
54: *                                         Init legado
55: *
56: * POR QUE A FASE 4 NAO TEM "ConfigurarPaginaLista"/"AlternarPagina"
57: * -------------------------------------------------------------------
58: * O prompt generico da fase pede Grid + 6 botoes CRUD em Page1 + troca de
59: * pagina. Aqui vale o ramo FLAT do gate (OPERACIONAL + grd_4c_* + botao +
60: * metodo de carga), e isso eh MEDIDO no dump, nao afirmado:

*-- Linhas 139 a 157:
139: *   esse cursor so existe a partir da Fase 7 (populado por SQL dentro dos
140: *   ramos por ParentForm.Tipo, igual ao "crImpre" do comportamento.json).
141: *   Ligar RowSourceType = 2 a um alias ainda inexistente eh o mesmo risco
142: *   da regra CLAUDE.md #41 (Column.ControlSource contra cursor ausente) -
143: *   melhor errar para o lado conservador e deixar o bind explicito para
144: *   quando o alias existir, no mesmo padrao de MontaGradeEtiquetas.
145: *
146: *   this_lGravaOcorrencia (propriedade nova, PILAR 3 - o legado usa
147: *   "ThisForm.GravaOcorrencia" sem prefixo) e os sete controles de
148: *   Ocorrencia/Justificativa nascem no ESTADO INCONDICIONAL que o Init
149: *   legado atribui ANTES do "If (Type(...pcEscolha...)=[C]) And ... And
150: *   (LocalParam.OcoEtiqs = 1)" (linhas 2691-2710): tudo .F./oculto. O
151: *   RAMO que reacende os sete sob a condicao acima depende de LocalParam
152: *   (Fase 7) e de ParentForm.pcEscolha, e fica para la - mesma divisao que
153: *   o cabecalho da Fase 5 ja registrava para o cursor da grade (nasce
154: *   vazio, populado depois).
155: *
156: *   Label6 ("Windows") - UNICA excecao ao ForeColor RGB(90,90,90) desta
157: *   fase, e deliberada: o dump declara ForeColor = 231,254,253 (quase-

*-- Linhas 201 a 219:
201: *                                 <- ParentForm.Chk_Preco, this_nOrdemImp
202: *                                 <- memvar pnordem, e a sequencia abaixo
203: *   CarregarParametrosSistema     LocalParam/LocalParaC (SigCdPam/SigCdPaC,
204: *                                 SELECT sem WHERE - tabela de 1 linha)
205: *   AtualizarVisibilidadeOcorrencia  ramo que religa os 7 controles de
206: *                                 Ocorrencia/Justificativa (ParentForm.
207: *                                 pcEscolha + LocalParam.OcoEtiqs)
208: *   CarregarTiposEtiquetaDinamico SigCdTpe -> LocalTpEti, popula os
209: *                                 Buttons de obj_4c_Opt_Tipo (substitui o
210: *                                 unico botao transcrito na Fase 5)
211: *   CarregarLinhasPorTipoChamador dispatcher dos seis ramos por
212: *                                 ParentForm.Tipo (UNITARIO/OPERACAO/
213: *                                 DIVERSAS/ARQUIVADAS/CADASTRO/CONSULTA) -
214: *                                 cada ramo eh um metodo proprio; DIGITACAO
215: *                                 fica em ConfigurarModoDigitacao
216: *   CarregarImpressorasEtiqueta   APRINTERS() casado com SigSyImp/SigCdAcG/
217: *                                 SigCdmp -> crImpreV, bind de
218: *                                 cbo_4c_Get_Printer
219: *   AplicarDefaultsImpressora     Cnt_Impressora <- LocalParam/LocalParaC

*-- Linhas 227 a 245:
227: *   DECISOES DESTA FASE:
228: *   - poDataGrv/fSqlConector (dump 2621-2630, AddCursor de SigEtOcr/
229: *     SigMvCab/SigMvItn/SigMvIts) NAO foi implementado: eh uma camada de
230: *     acesso a dados que o projeto substitui por SQLEXEC direto, e os
231: *     quatro cursores ja sao lidos com guarda USED() pelas Fases 5-7
232: *     assumindo que podem nao existir. Implementa-lo traria uma camada
233: *     inteira para uma fase que so precisa de quatro cursores especificos.
234: *   - CarregarContextoInicial tem TRY/CATCH PROPRIO que nao propaga: SigCdTpe/
235: *     SigCdmp vazios sao caminho LEGITIMO (grade abre sem tipo/impressora
236: *     disponivel, igual ao legado), entao falha aqui nao pode travar a
237: *     abertura da tela (o legado so aborta com "Return 0" em falha de
238: *     CONEXAO, que nesta arquitetura ja seria detectada antes do form
239: *     existir).
240: *   - Ramo CONSULTA depende de uma bateria de memvars PRIVATE/PUBLIC que o
241: *     chamador legado (SigPrRet) seta antes do "Do Form" - SigPrRet nao
242: *     esta migrado ainda (conferido com grep no projeto), entao todos os
243: *     memvars usam o mesmo guard TYPE()!='U' que o proprio Init legado ja
244: *     usava para pcGdeGrupo/pcCol, com default inerte quando a memvar nao
245: *     existe (caminho hoje dominante, form testado isolado).

*-- Linhas 382 a 400:
382:     * O sufixo "Ipe" nao eh enfeite: este form tem DataSession = 1, ou seja o
383:     * alias vive na sessao de dados CORRENTE, compartilhada com o form
384:     * chamador e com o resto da aplicacao. "cursor_4c_Etiquetas" (sem o
385:     * sufixo) JA EXISTE no projeto - PrlBO.prg:273 faz SQLEXEC nesse alias -
386:     * e colidir ali derrubaria as duas telas sem erro atribuivel a nenhuma
387:     * delas. "cursor_4c_IpeEtiquetas" foi conferido: zero ocorrencias em
388:     * projeto\app\.
389:     *--------------------------------------------------------------------------
390:     this_cCursorEtiquetas = "cursor_4c_IpeEtiquetas"
391: 
392:     *==========================================================================
393:     * Init - recebe os dois parametros do legado (lfFormAnterior, llGravaPro)
394:     *
395:     * Legado (SIGOPIPE.Init), transcrito nas linhas que esta fase cobre:
396:     *
397:     *   Lparameters lfFormAnterior, llGravaPro
398:     *   Thisform.ParentForm = lfFormAnterior
399:     *   If Type('lfFormAnterior') = 'O'
400:     *       lfFormAnterior.Enabled = .F.

*-- Linhas 651 a 728:
651:     * Geometria e aparencia TRANSCRITAS do dump (SIGOPIPE.grd_historico):
652:     * Top 147 / Left 6 / Width 984 / Height 241 / ColumnCount 12 /
653:     * Arial 8 / HeaderHeight 17 / RowHeight 17 / ScrollBars 3 / Panel 1 /
654:     * DeleteMark .F. As que o dump NAO declara vem da classe fwgrade
655:     * (docs\FRAMEWORK_class_codigo_fonte.txt): AllowHeaderSizing .F.,
656:     * AllowRowSizing .F., GridLineColor 238,238,238,
657:     * HighlightBackColor 90,90,90.
658:     *
659:     * RecordMark = .F. eh o UNICO acrescimo: nem o dump nem a fwgrade o
660:     * declaram, e o default do VFP9 eh .T. - a regra do projeto para grade
661:     * criada por AddObject em form OPERACIONAL manda .F. nos dois marcadores,
662:     * senao aparece a barra de marcacao na lateral esquerda que o legado nao
663:     * tem (a fwgrade ja traz DeleteMark .F., so faltava o par).
664:     *
665:     * NUMERACAO DAS COLUNAS - A ARMADILHA DESTE FORM
666:     * -----------------------------------------------
667:     * O legado RENOMEIA quatro Column, e o dump mostra isso em dois lugares
668:     * que nao concordam: o bloco de propriedades da grade usa o prefixo da
669:     * POSICAO no SCX (ordem de criacao) e termina cada grupo com o
670:     * ".Name" REAL, enquanto os blocos "PROPRIEDADES DE: ...ColumnN.Header1/
671:     * .Text1" e o "With Thisform.grd_Historico" do Init usam o NOME.
672:     *
673:     *   posicao no SCX .....  6        7        8        9
674:     *   .Name declarado ....  Column7  Column8  Column9  Column6
675:     *
676:     * Renomear Column eh PROIBIDO (quebra toda referencia .ColumnN), e com
677:     * ColumnCount = 12 o VFP9 cria Column1..Column12 na ordem de criacao.
678:     * Logo, neste arquivo a Column<N> eh a POSICAO N do SCX, e o que vale
679:     * para ela sao: as propriedades do bloco da grade com prefixo <N>, mais o
680:     * Header1/Text1/ControlSource do bloco cujo NOME esta na tabela acima.
681:     * Ler os dois pela posicao (ou os dois pelo nome) embaralharia
682:     * cabecalho, largura, mascara e coluna de dados de quatro colunas - e a
683:     * tela abriria sem erro nenhum, so com os dados nas colunas erradas.
684:     *
685:     * A conferencia que fecha o mapeamento eh semantica: o par
686:     * cabecalho x ControlSource bate em todas as 12 (Data/Datas,
687:     * Produto/CPros, "Codigo / Barra"/CBars, Quantidade/Qtds,
688:     * Observacao/ObsEtiqs, "Ref. Fornecedor"/Reffs, Preco/pVens,
689:     * Parcelas/Parcelas, "Preco De Conjunto"/PrecoDeCJ,
690:     * "Preco Conjunto"/pVensCJ). Os ControlSource gravados NO SCX estao
691:     * OBSOLETOS (ele poe "dbetiqueta.pesos" na coluna "Preco De", e tres
692:     * colunas sem ControlSource nenhum): quem manda eh o
693:     * "With Thisform.grd_Historico" do Init legado (linhas 2654-2672), que
694:     * reatribui os 12 - por isso eh dele que a transcricao sai.
695:     *
696:     * Movable/Resizable = .F. em TODAS as 12: o dump declara o par so em
697:     * algumas (e chega a declarar Movable = .T. na posicao 10), mas o Init
698:     * legado fecha com "For I=1 To .ColumnCount / .Column&lcCol..Movable =
699:     * .F. / .Column&lcCol..Resizable = .F. / Next", que sobrepoe o SCX em
700:     * todas. O estado final eh .F. nas 12.
701:     *
702:     * SetAll para a base uniforme (Arial 8 nas Column, nos Header e nos
703:     * Text1; BorderStyle 0 / Margin 0 / preto sobre branco nos Text1;
704:     * Alignment 2 nos Header) porque esses valores sao IDENTICOS nos 12
705:     * blocos do dump - 12 blocos WITH repetindo as mesmas 6 linhas esconderia
706:     * justamente as diferencas, que ficam explicitas logo abaixo.
707:     *
708:     * Text1 e Header1 sao membros NATIVOS da Column: nao se cria e nao se
709:     * renomeia. O CheckBox da coluna de marcacao, nao - esse EXIGE AddObject
710:     * (regra CLAUDE.md #18), e sem o CurrentControl (em FormatarColunasGrade)
711:     * ele existe e NAO desenha.
712:     *
713:     * ControlSource, RecordSource, larguras e cabecalhos NAO entram aqui:
714:     * ligar coluna a cursor que ainda nao existe derruba o Init (regra
715:     * CLAUDE.md #41), e o bind reseta largura/cabecalho. Tudo isso mora em
716:     * MontaGradeEtiquetas.
717:     *==========================================================================
718:     PROTECTED PROCEDURE ConfigurarGrade()
719:         LOCAL loc_oGrid
720: 
721:         THIS.AddObject("grd_4c_Dados", "Grid")
722:         loc_oGrid = THIS.grd_4c_Dados
723: 
724:         *-- Legado: Thisform.grd_Historico.RecordSource = '' antes do cursor
725:         loc_oGrid.RecordSource = ""
726:         loc_oGrid.ColumnCount  = 12
727: 
728:         WITH loc_oGrid

*-- Linhas 736 a 754:
736:             .RowHeight          = 17
737:             .ScrollBars         = 3
738:             .Panel              = 1
739:             .DeleteMark         = .F.
740:             .RecordMark         = .F.
741:             .AllowHeaderSizing  = .F.
742:             .AllowRowSizing     = .F.
743:             .GridLineColor      = RGB(238, 238, 238)
744:             .HighlightBackColor = RGB(90, 90, 90)
745:             .Enabled            = .T.
746:             .Visible            = .T.
747:         ENDWITH
748: 
749:         *-- Base uniforme dos 12 blocos do dump
750:         WITH loc_oGrid
751:             .FontName = "Arial"
752:             .FontSize = 8
753:             .SetAll("Movable",   .F.,     "Column")
754:             .SetAll("Resizable", .F.,     "Column")

*-- Linhas 860 a 945:
860:     * Legado (Init, linhas 2641-2652):
861:     *
862:     *   Thisform.ParentForm.poDataMgr.CursorQuery('SigOpEtq','LocalEti','CBars',99999999999999)
863:     *   Select *, .F. As Flag, 000000000.00 As PrecoDe, 000000000.00 As pvens,
864:     *       00 As Parcelas, Space(3) As Moedas, Space(40) As Reffs,
865:     *       Space(30) As Pedido, Space(10) As Obs, .F. As Mantem,
866:     *       000000000.000 As QtdeEtiq, 000000000.00 As PrecoDeCJ,
867:     *       000000000.00 As pvensCJ, Space(6) as Categoria, Space(3) as CGrus
868:     *       From LocalEti Where 0=1 Into Cursor DbEtiqueta Readwrite
869:     *   <6 x Index On ... Tag ...>
870:     *
871:     * O "Where 0=1" eh o ponto: o legado usa LocalEti apenas como MOLDE de
872:     * estrutura e cria o cursor VAZIO. As linhas chegam depois, nos ramos por
873:     * ParentForm.Tipo (Fase 7). Aqui o CREATE CURSOR substitui o par
874:     * CursorQuery + Select-Where-0=1 sem nenhuma ida ao banco, o que tambem
875:     * torna a tela instanciavel sem conexao.
876:     *
877:     * As 47 primeiras colunas sao SigOpEtq na ordem do schema (= a ordem que
878:     * o "Select *" produz), conferidas em docs\schema.sql com
879:     * Get-Content -Raw (o arquivo eh UTF-16: grep/findstr devolvem ZERO
880:     * silenciosamente e fariam coluna existente parecer inexistente - regra
881:     * CLAUDE.md #14). As 14 ultimas sao os literais do Select acima, com a
882:     * largura LIDA do literal: "000000000.00" = 9 inteiros + 2 decimais =
883:     * N(12,2), "000000000.000" = N(13,3), "00" = N(2,0).
884:     *
885:     * NULL por coluna, nao por atacado: as 6 colunas que o schema declara
886:     * NULL (datas, datatrans, dtmovs, dtbals, dtincs, tbdwbi) vao NULL e
887:     * TODAS as outras vao NOT NULL - os 14 literais inclusive, porque .F.,
888:     * zero e Space() nao sao nulos. Isso importa em "Flag": nula, ela
889:     * chegaria ao CheckBox da grade como .NULL. e a celula de marcacao
890:     * mostraria vazio em vez de desmarcado. Com NULL/NOT NULL explicitos nas
891:     * 61 colunas o SET NULL ambiente deixa de influir; ele continua sendo
892:     * ligado/restaurado porque o cursor recebe INSERT/APPEND de cursores
893:     * vindos do SQL Server nas fases seguintes.
894:     *
895:     * UM UNICO ponto de criacao, de proposito: a regra de que todo
896:     * CREATE CURSOR do mesmo alias tenha a MESMA ordem de campos eh
897:     * satisfeita por construcao se existir um so. Todo caminho que precise do
898:     * cursor chama este metodo.
899:     *
900:     * Os 6 INDEX ON sao os do legado, com os MESMOS nomes de tag (o form le
901:     * por "Set Order To EmpGruCon" e afins) e sem ALLTRIM nas partes - chave
902:     * concatenada de char fixo eh POSICIONAL e o padding faz parte dela
903:     * (regra CLAUDE.md #42).
904:     *
905:     * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
906:     *==========================================================================
907:     PROTECTED PROCEDURE CriarCursorEtiquetas()
908:         LOCAL loc_lSucesso, loc_oErro, loc_cCursor, loc_cNullAnterior
909: 
910:         loc_lSucesso = .F.
911:         loc_cCursor  = THIS.this_cCursorEtiquetas
912: 
913:         *-- Lido ANTES do TRY de proposito: o CATCH precisa dele para repor o
914:         *-- SET. Lido dentro, uma falha no CREATE CURSOR deixaria SET NULL ON
915:         *-- vazando do form para o resto da aplicacao, e o proximo
916:         *-- CREATE CURSOR de QUALQUER tela nasceria com colunas nulaveis que
917:         *-- ela nao pediu - defeito sem erro e longe da causa.
918:         loc_cNullAnterior = SET("NULL")
919: 
920:         TRY
921:             IF USED(loc_cCursor)
922:                 IF CURSORGETPROP("Buffering", loc_cCursor) > 1
923:                     TABLEREVERT(.T., loc_cCursor)
924:                 ENDIF
925:                 USE IN (loc_cCursor)
926:             ENDIF
927: 
928:             SET NULL ON
929: 
930:             CREATE CURSOR (loc_cCursor) ( ;
931:                 cbars      N(14, 0) NOT NULL, ;
932:                 contas     C(10)    NOT NULL, ;
933:                 cpros      C(14)    NOT NULL, ;
934:                 datas      T        NULL,     ;
935:                 dopeos     C(20)    NOT NULL, ;
936:                 dopes      C(20)    NOT NULL, ;
937:                 empos      C(3)     NOT NULL, ;
938:                 emps       C(3)     NOT NULL, ;
939:                 grupos     C(10)    NOT NULL, ;
940:                 nops       N(10, 0) NOT NULL, ;
941:                 numeos     N(6, 0)  NOT NULL, ;
942:                 numes      N(6, 0)  NOT NULL, ;
943:                 pesos      N(9, 3)  NOT NULL, ;
944:                 qtds       N(9, 3)  NOT NULL, ;
945:                 transps    L        NOT NULL, ;

*-- Linhas 994 a 1012:
994:                 SET NULL OFF
995:             ENDIF
996: 
997:             SELECT (loc_cCursor)
998:             INDEX ON EmpDopNums + Cpros                            TAG EmpDopNums
999:             INDEX ON EmpOs + Grupos + Contas + Cpros + CodTams     TAG EmpGruCon
1000:             INDEX ON Cpros + CodTams                               TAG Cpros
1001:             INDEX ON Reffs                                         TAG RefFor
1002:             INDEX ON CBars                                         TAG CBars
1003:             INDEX ON Categoria + CGrus                             TAG CatGru
1004: 
1005:             loc_lSucesso = .T.
1006:         CATCH TO loc_oErro
1007:             loc_lSucesso = .F.
1008: 
1009:             *-- repoe o SET tambem no caminho de falha
1010:             IF loc_cNullAnterior = "OFF"
1011:                 SET NULL OFF
1012:             ENDIF

*-- Linhas 1026 a 1057:
1026:     * destroi
1027:     *
1028:     * Reproduz o "With Thisform.grd_Historico" do Init legado (2654-2672) e o
1029:     * "Select DbEtiqueta / Goto Top / Refresh" da linha 3268.
1030:     *
1031:     * Os ControlSource vem do NOME da Column no legado, traduzido para a
1032:     * POSICAO deste arquivo (ver a tabela em ConfigurarGrade):
1033:     *
1034:     *   legado .Column1  -> Column1   Datas        legado .Column7  -> Column6   Qtds
1035:     *   legado .Column2  -> Column2   Flag         legado .Column8  -> Column7   ObsEtiqs
1036:     *   legado .Column3  -> Column3   CPros        legado .Column9  -> Column8   Reffs
1037:     *   legado .Column4  -> Column4   CBars        legado .Column6  -> Column9   pVens
1038:     *   legado .Column5  -> Column5   PrecoDe      legado .Column10 -> Column10  Parcelas
1039:     *                                              legado .Column11 -> Column11  PrecoDeCJ
1040:     *                                              legado .Column12 -> Column12  pVensCJ
1041:     *
1042:     * O cursor eh criado antes de qualquer ControlSource: ligar coluna a
1043:     * cursor inexistente estoura "Alias ... is not found" DENTRO do TRY do
1044:     * InicializarForm, que devolve .F., e ai CREATEOBJECT devolve .F., o
1045:     * "IF VARTYPE(loForm) = 'O'" do chamador nao entra e o usuario aciona a
1046:     * tela e NADA acontece, sem erro visivel (regra CLAUDE.md #41).
1047:     *
1048:     * GO TOP + Refresh no fim porque popular/religar cursor NAO repinta a
1049:     * grade sozinho - o legado fecha exatamente assim, e sem isso a grade
1050:     * fica visualmente vazia com o cursor correto, o que manda o diagnostico
1051:     * para SQL/permissao (regra CLAUDE.md #21).
1052:     *
1053:     * PUBLIC de proposito: eh o funil de (re)carga da grade, chamado pelos
1054:     * ramos por Tipo da Fase 7 e alvo potencial de BINDEVENT - PROTECTED
1055:     * falharia calado no bind e estouraria "Property ... is not found" na
1056:     * chamada de fora (regras CLAUDE.md #3/#51).
1057:     *

*-- Linhas 1075 a 1129:
1075:                 loc_oGrid.RecordSource = ""
1076:                 loc_oGrid.RecordSource = loc_cCursor
1077: 
1078:                 loc_oGrid.Column1.ControlSource  = loc_cCursor + ".Datas"
1079:                 loc_oGrid.Column2.ControlSource  = loc_cCursor + ".Flag"
1080:                 loc_oGrid.Column3.ControlSource  = loc_cCursor + ".CPros"
1081:                 loc_oGrid.Column4.ControlSource  = loc_cCursor + ".CBars"
1082:                 loc_oGrid.Column5.ControlSource  = loc_cCursor + ".PrecoDe"
1083:                 loc_oGrid.Column6.ControlSource  = loc_cCursor + ".Qtds"
1084:                 loc_oGrid.Column7.ControlSource  = loc_cCursor + ".ObsEtiqs"
1085:                 loc_oGrid.Column8.ControlSource  = loc_cCursor + ".Reffs"
1086:                 loc_oGrid.Column9.ControlSource  = loc_cCursor + ".pVens"
1087:                 loc_oGrid.Column10.ControlSource = loc_cCursor + ".Parcelas"
1088:                 loc_oGrid.Column11.ControlSource = loc_cCursor + ".PrecoDeCJ"
1089:                 loc_oGrid.Column12.ControlSource = loc_cCursor + ".pVensCJ"
1090: 
1091:                 THIS.FormatarColunasGrade()
1092: 
1093:                 *-- Legado: Select DbEtiqueta / Goto Top / Refresh
1094:                 SELECT (loc_cCursor)
1095:                 GO TOP
1096:                 loc_oGrid.Refresh()
1097: 
1098:                 loc_lSucesso = .T.
1099:             ENDIF
1100:         CATCH TO loc_oErro
1101:             loc_lSucesso = .F.
1102:             THIS.this_cMensagemErro = loc_oErro.Message
1103:             MsgErro(loc_oErro.Message + CHR(13) + ;
1104:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1105:                 "Procedure: " + loc_oErro.Procedure, ;
1106:                 "Erro em MontaGradeEtiquetas")
1107:         ENDTRY
1108: 
1109:         RETURN loc_lSucesso
1110:     ENDPROC
1111: 
1112:     *==========================================================================
1113:     * FormatarColunasGrade - tudo o que a atribuicao de RecordSource/
1114:     * ControlSource RESETA, reaplicado por inteiro
1115:     *
1116:     * Atribuir RecordSource devolve Column.Width ao default 90 e
1117:     * Header1.Caption a "ColumnN", e zera Column.CurrentControl /
1118:     * Column.Sparse / Column.ReadOnly (regras CLAUDE.md #41/#46). Por isso
1119:     * este bloco vive num metodo proprio e roda DEPOIS de cada bind - todo
1120:     * caminho que mexer em RecordSource tem de chamar este metodo no fim.
1121:     *
1122:     * Larguras e cabecalhos TRANSCRITOS do dump, cada um pela chave certa (a
1123:     * largura pela POSICAO, o cabecalho pelo NOME - ver ConfigurarGrade).
1124:     *
1125:     * CurrentControl eh o que faz o CheckBox APARECER: sem ele a Column2
1126:     * continua desenhando o Text1 dela e o usuario ve ".T."/".F." como texto,
1127:     * sem nada para clicar. E Sparse = .F. (que o dump declara) eh o que o
1128:     * faz aparecer em TODAS as linhas, nao so na linha ativa - numa tela cuja
1129:     * funcao eh escolher quais etiquetas imprimir, isso eh a diferenca entre

*-- Linhas 1206 a 1233:
1206:         loc_oGrid.Column12.Header1.Caption  = "Pre" + CHR(231) + "o Conjunto"
1207: 
1208:         *-- Sem CurrentControl o CheckBox existe e NAO desenha (regra #18).
1209:         *-- Column.ControlSource (atribuido acima, linha do Column2) so se
1210:         *-- aplica ao controle que FOR CurrentControl NO MOMENTO da
1211:         *-- atribuicao - na abertura, esse controle ainda era o Text1
1212:         *-- nativo (CurrentControl so muda aqui). Sem reatribuir
1213:         *-- ControlSource DEPOIS de trocar para chk_4c_Check1, o CheckBox
1214:         *-- nunca se liga a Flag e fica sempre desmarcado, mesmo com o
1215:         *-- REPLACE que os handlers de toggle da Fase 7 fazem no cursor.
1216:         IF PEMSTATUS(loc_oGrid.Column2, "chk_4c_Check1", 5)
1217:             loc_oGrid.Column2.CurrentControl = "chk_4c_Check1"
1218:             loc_oGrid.Column2.chk_4c_Check1.ControlSource = THIS.this_cCursorEtiquetas + ".Flag"
1219:         ENDIF
1220: 
1221:         *-- Dump: Column2.Sparse = .F. - CheckBox em TODAS as linhas
1222:         loc_oGrid.Column2.Sparse = .F.
1223: 
1224:         *-- Grid.ReadOnly ANTES do das colunas, porque PROPAGA (regra #46)
1225:         loc_oGrid.ReadOnly          = .F.
1226:         loc_oGrid.Column1.ReadOnly  = .T.
1227:         loc_oGrid.Column2.ReadOnly  = .F.
1228:         loc_oGrid.Column3.ReadOnly  = .T.
1229:         loc_oGrid.Column4.ReadOnly  = .T.
1230:         loc_oGrid.Column5.ReadOnly  = .T.
1231:         loc_oGrid.Column6.ReadOnly  = .F.
1232:         loc_oGrid.Column7.ReadOnly  = .T.
1233:         loc_oGrid.Column8.ReadOnly  = .T.

*-- Linhas 1510 a 1528:
1510:     * GetTexto (classe fwmemo no layout.json, migrado para EditBox puro) eh
1511:     * o campo de texto livre que entra na etiqueta. AddLineFeeds = .F. vem
1512:     * do dump (o legado NAO quebra linha automaticamente ao digitar).
1513:     * Nenhum ControlSource: o legado liga o conteudo no momento de montar a
1514:     * etiqueta (Fase 7/8), nao por bind direto a cursor.
1515:     *
1516:     * getQtParcs eh a quantidade de parcelas - so faz sentido quando
1517:     * opt_Preco seleciona "Parcelamento" (Buttons(6)), condicao que mora no
1518:     * When do campo (Fase 6: "Return(ThisForm.opt_Preco.Value = 6)"), nao
1519:     * aqui. Format = "K" + InputMask = "99" TRANSCRITOS do dump (regra
1520:     * CLAUDE.md #49): "K" seleciona o conteudo ao focar, o InputMask
1521:     * restringe a 2 digitos numericos. Alignment = 3 (direita) e Value = 0
1522:     * (NUMERICO - o destino eh a coluna Parcelas N(2,0) do cursor da grade)
1523:     * tambem vem do dump, assim como ForeColor = RGB(90,90,90) e os dois
1524:     * DisabledXxxColor.
1525:     *
1526:     * TabIndex de FORM (Label7/GetTexto/Label8/getQtParcs declaram 6/7/6/4
1527:     * no dump, com o 4 duplicado com getOcoEtiqs - controle que so existe a
1528:     * partir da Fase 6) fica para a Fase 6, mesma regra ja registrada no

*-- Linhas 2387 a 2405:
2387:     * para a Fase 7 (precisa de LocalParam e de ParentForm.pcEscolha - ver
2388:     * cabecalho do arquivo).
2389:     *
2390:     * getOcoEtiqs/getDOcoEtiqs nao tem ControlSource no dump (o valor eh
2391:     * atribuido por codigo no Click de Imprimir/Armazenar - Fase 7/8), por
2392:     * isso .Value = "" em vez de bind a cursor. O mesmo vale para
2393:     * GetJustifs.
2394:     *
2395:     * ShpOcoEtiqs/ShpJustifs seguem o mesmo estilo dos Shape1/2/3
2396:     * (BackStyle 0, BorderWidth 2, BorderColor 90,90,90) - unica diferenca
2397:     * eh a geometria, TRANSCRITA do dump.
2398:     *==========================================================================
2399:     PROTECTED PROCEDURE ConfigurarOcorrenciaEJustificativa()
2400:         THIS.this_lGravaOcorrencia = .F.
2401: 
2402:         THIS.AddObject("shp_4c_ShpOcoEtiqs", "Shape")
2403:         WITH THIS.shp_4c_ShpOcoEtiqs
2404:             .Top           = 464
2405:             .Left          = 593

*-- Linhas 2735 a 2753:
2735:     * O guard de Buffering antes do TABLEREVERT nao eh defensividade solta:
2736:     * TABLEREVERT sem buffering nao eh no-op, dispara erro 1586 ("Function
2737:     * requires row or table buffering mode"), e cursor criado por
2738:     * CREATE CURSOR nasce com Buffering = 1 - ou seja, o caminho normal eh
2739:     * justamente o que estouraria. USE IN fecha o alias mesmo com buffer
2740:     * sujo (regra CLAUDE.md #52).
2741:     *
2742:     * DODEFAULT() eh a ULTIMA linha, obrigatoriamente: FormBase.Destroy faz
2743:     * o SET SYSMENU TO DEFAULT + RELEASE POPUP + CriarMenuPrincipal() que
2744:     * repoe os pads do menu principal - sem ele o menu do sistema aparece
2745:     * encolhido.
2746:     *==========================================================================
2747:     PROCEDURE Destroy()
2748:         IF USED(THIS.this_cCursorEtiquetas)
2749:             IF CURSORGETPROP("Buffering", THIS.this_cCursorEtiquetas) > 1
2750:                 TABLEREVERT(.T., THIS.this_cCursorEtiquetas)
2751:             ENDIF
2752:             USE IN (THIS.this_cCursorEtiquetas)
2753:         ENDIF

*-- Linhas 2918 a 2974:
2918:                 IF USED("csEmpresas")
2919:                     USE IN csEmpresas
2920:                 ENDIF
2921:                 CREATE CURSOR csEmpresas (ImpEmps L(1), CEmps C(3), Razas C(40))
2922:                 INDEX ON CEmps TAG CEmps
2923: 
2924:                 IF USED("LocalEmp")
2925:                     USE IN LocalEmp
2926:                 ENDIF
2927:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2928:                     "SELECT Cemps, Razas FROM SigCdEmp WHERE Ativas = 1 ORDER BY Cemps", "LocalEmp")
2929: 
2930:                 IF loc_nResultado < 1
2931:                     MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalEmp)")
2932:                 ELSE
2933:                     SELECT LocalEmp
2934:                     SCAN
2935:                         IF !SEEK(LocalEmp.Cemps, "csEmpresas", "CEmps")
2936:                             INSERT INTO csEmpresas (ImpEmps, CEmps, Razas) ;
2937:                                 VALUES (.T., LocalEmp.Cemps, LocalEmp.Razas)
2938:                         ENDIF
2939:                     ENDSCAN
2940: 
2941:                     IF USED("csEmps")
2942:                         USE IN csEmps
2943:                     ENDIF
2944:                     SELECT CEmps FROM csEmpresas WHERE ImpEmps INTO CURSOR csEmps
2945:                     SELECT csEmps
2946: 
2947:                     loc_oProgresso = CREATEOBJECT("fwprogressbar", "Imprimindo Boletos...", RECCOUNT())
2948:                     loc_oProgresso.Show()
2949: 
2950:                     SCAN
2951:                         loc_cEmpAtual = csEmps.Cemps
2952:                         loc_oProgresso.SubTitulo.Caption = "Boleto da Empresa : " + loc_cEmpAtual
2953:                         loc_oProgresso.Update(.T.)
2954: 
2955:                         IF USED(THIS.this_cCursorEtiquetas)
2956:                             IF USED("TmpEtiquetas")
2957:                                 USE IN TmpEtiquetas
2958:                             ENDIF
2959:                             SELECT CBars FROM (THIS.this_cCursorEtiquetas) ;
2960:                                 WHERE Empos = loc_cEmpAtual ORDER BY CBars INTO CURSOR TmpEtiquetas
2961: 
2962:                             IF USED("TmpEtiquetas") AND RECCOUNT("TmpEtiquetas") > 0
2963:                                 loc_cNomeImp = THIS.ObterNomeImpressoraAtual()
2964: 
2965:                                 TRY
2966:                                     DO SigBlBol.Prg WITH 10, , loc_cEmpAtual, "", "", 0, 64, 1, loc_cNomeImp
2967:                                 CATCH TO loc_oErro
2968:                                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel emitir o boleto da " + ;
2969:                                         "empresa " + loc_cEmpAtual + ":" + CHR(13) + loc_oErro.Message, "Erro")
2970:                                 ENDTRY
2971:                             ENDIF
2972:                         ENDIF
2973:                     ENDSCAN
2974: 

*-- Linhas 2995 a 3019:
2995:             loc_cCursor = THIS.this_cCursorEtiquetas
2996: 
2997:             IF THIS.this_lImpArquivadas AND USED(loc_cCursor)
2998:                 SELECT (loc_cCursor)
2999:                 SCAN
3000:                     loc_cSQL = "UPDATE SigCdPro SET ImpEtiqs = 0 WHERE CPros = " + ;
3001:                         EscaparSQL(ALLTRIM(EVALUATE(loc_cCursor + ".CPros")))
3002: 
3003:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
3004:                         MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - SigCdPro)")
3005:                     ENDIF
3006:                 ENDSCAN
3007:             ENDIF
3008:         CATCH TO loc_oErro
3009:             MsgErro(loc_oErro.Message, "Erro em BtnSairClick")
3010:         ENDTRY
3011: 
3012:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
3013:             IF PEMSTATUS(THIS.this_oFormAnterior, "Enabled", 5)
3014:                 THIS.this_oFormAnterior.Enabled = .T.
3015:             ENDIF
3016:         ENDIF
3017: 
3018:         THIS.Release()
3019:     ENDPROC

*-- Linhas 3052 a 3074:
3052:             loc_cNomeImp = THIS.ObterNomeImpressoraAtual()
3053:             loc_cCursor  = THIS.this_cCursorEtiquetas
3054: 
3055:             SELECT dbImpressao
3056:             ZAP
3057: 
3058:             IF USED(loc_cCursor) AND !EOF(loc_cCursor)
3059:                 INSERT INTO dbImpressao (Cpros, Qtds, Cbars, Obs) ;
3060:                     VALUES (EVALUATE(loc_cCursor + ".CPros"), 1, 99999999999999, "")
3061:             ENDIF
3062: 
3063:             TRY
3064:                 SigOpEtq(gnConnHandle, .F., .F., 99, 2, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, , , , ;
3065:                     loc_cNomeImp, .F., .F., loc_nAjVelos, .F., .F., .F., .F., .F., loc_lResete)
3066:             CATCH TO loc_oErro
3067:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel testar a posi" + CHR(231) + CHR(227) + ;
3068:                     "o:" + CHR(13) + loc_oErro.Message, "Erro")
3069:             ENDTRY
3070:         CATCH TO loc_oErro
3071:             MsgErro(loc_oErro.Message + CHR(13) + ;
3072:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em BtnPosicaoClick")
3073:         ENDTRY
3074:     ENDPROC

*-- Linhas 3082 a 3106:
3082:     * Used(...)" so cria na PRIMEIRA chamada da sessao, entao qualquer uma
3083:     * das duas "ganha" dependendo da ordem de cliques, inconsistencia do
3084:     * PROPRIO legado. Aqui ha UM UNICO ponto de criacao (regra CLAUDE.md -
3085:     * mesma ordem de campos em todo CREATE CURSOR do mesmo alias), com a
3086:     * UNIAO das duas larguras (a maior de cada campo) para nao truncar
3087:     * nenhum dos dois usos.
3088:     *==========================================================================
3089:     PROTECTED PROCEDURE GarantirCursorImpressao()
3090:         IF !USED("dbImpressao")
3091:             CREATE CURSOR dbImpressao ( ;
3092:                 CPros      C(14), ;
3093:                 Qtds       N(10, 3), ;
3094:                 QtdeEtiq   N(10, 3), ;
3095:                 Pedido     C(30), ;
3096:                 Obs        C(10), ;
3097:                 Cbars      N(16, 0), ;
3098:                 Pvens      N(12, 2), ;
3099:                 PrecoDe    N(12, 2), ;
3100:                 Parcelas   N(2, 0), ;
3101:                 Moedas     C(3), ;
3102:                 EmpDopNums C(29), ;
3103:                 Reffs      C(40), ;
3104:                 Empos      C(3), ;
3105:                 Cpros1     C(14), ;
3106:                 CodTams    C(4))

*-- Linhas 3167 a 3185:
3167:                 loc_cCursor = THIS.this_cCursorEtiquetas
3168: 
3169:                 IF USED(loc_cCursor) AND !EOF(loc_cCursor)
3170:                     SELECT (loc_cCursor)
3171:                     REPLACE Flag WITH !Flag
3172:                     THIS.grd_4c_Dados.Refresh()
3173:                 ENDIF
3174:             CATCH TO loc_oErro
3175:                 MsgErro(loc_oErro.Message, "Erro em GradeCheckMarcarKeyPress")
3176:             ENDTRY
3177: 
3178:             NODEFAULT
3179:         ENDIF
3180:     ENDPROC
3181: 
3182:     *==========================================================================
3183:     * GradeRedirecionarParaColunaBarras - GotFocus de Column1/3/5/7/8.Text1
3184:     * (dump: cada uma identica, "If ParentForm.Tipo='DIGITACAO' / Column4.
3185:     * SetFocus"). Em modo DIGITACAO a unica coluna editavel eh a de codigo

*-- Linhas 3223 a 3312:
3223:                     IF USED("CrEtiqs")
3224:                         USE IN CrEtiqs
3225:                     ENDIF
3226:                     loc_cSQL = "SELECT a.CPros, a.CBars FROM SigOpEtq a " + ;
3227:                         "LEFT JOIN sigopeta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
3228:                         "WHERE (a.CBars = " + loc_cBars + " OR b.cbars_old = " + loc_cBars + ")"
3229:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "CrEtiqs")
3230: 
3231:                     IF loc_nResultado < 1
3232:                         MsgErro("Favor reinicializar o processo !!!", "Falha na Conex" + CHR(227) + "o (CrEtiqs)")
3233:                         loc_lResultado  = .F.
3234:                         loc_lProsseguir = .F.
3235:                     ENDIF
3236: 
3237:                     IF loc_lProsseguir
3238:                         SELECT CrEtiqs
3239:                         GO TOP
3240: 
3241:                         IF EOF("CrEtiqs")
3242:                             MsgAviso("A Etiqueta Digitada N" + CHR(227) + "o Foi Encontrada!!!", "")
3243:                             loc_lResultado  = .F.
3244:                             loc_lProsseguir = .F.
3245:                         ENDIF
3246:                     ENDIF
3247: 
3248:                     IF loc_lProsseguir
3249:                         par_oTxt.Value = CrEtiqs.CBars
3250:                         loc_nEti       = par_oTxt.Value
3251: 
3252:                         IF USED("LocalEti")
3253:                             USE IN LocalEti
3254:                         ENDIF
3255:                         loc_cSQL = "SELECT a.*, b.pvens, CASE WHEN b.precode = 0 THEN b.pvens ELSE b.precode END " + ;
3256:                             "AS precode FROM SigOpEtq a, SigCdPro b WHERE a.CPros = b.CPros AND a.Cbars = " + ;
3257:                             ALLTRIM(STR(loc_nEti, 14))
3258:                         SQLEXEC(gnConnHandle, loc_cSQL, "LocalEti")
3259: 
3260:                         IF !USED("LocalEti") OR EOF("LocalEti")
3261:                             MsgAviso("A Etiqueta Digitada N" + CHR(227) + "o Foi Encontrada!!!", "")
3262:                             loc_lResultado  = .F.
3263:                             loc_lProsseguir = .F.
3264:                         ENDIF
3265:                     ENDIF
3266: 
3267:                     IF loc_lProsseguir
3268:                         IF EMPTY(LocalEti.Grupos) AND EMPTY(LocalEti.Contas)
3269:                             MsgAviso("A Etiqueta Digitada J" + CHR(225) + " Foi Vendida!!!", "")
3270:                             loc_lResultado  = .F.
3271:                             loc_lProsseguir = .F.
3272:                         ENDIF
3273:                     ENDIF
3274: 
3275:                     IF loc_lProsseguir
3276:                         loc_nRecOriginal = RECNO(loc_cCursor)
3277: 
3278:                         IF USED("crTmp")
3279:                             USE IN crTmp
3280:                         ENDIF
3281:                         SELECT CBars FROM (loc_cCursor) ;
3282:                             WHERE CBars = loc_nEti AND !EMPTY(CPros) AND RECNO() != loc_nRecOriginal ;
3283:                             INTO CURSOR crTmp
3284: 
3285:                         IF RECCOUNT("crTmp") > 0
3286:                             MsgAviso("Etiqueta J" + CHR(225) + " Digitada Na Sele" + CHR(231) + CHR(227) + "o Atual!!!", "")
3287:                             par_oTxt.Value  = 0
3288:                             loc_lResultado  = .F.
3289:                             loc_lProsseguir = .F.
3290:                         ENDIF
3291:                     ENDIF
3292: 
3293:                     IF loc_lProsseguir
3294:                         SELECT LocalEti
3295:                         SCATTER MEMVAR
3296: 
3297:                         SELECT (loc_cCursor)
3298:                         GATHER MEMVAR
3299:                         REPLACE Flag WITH .T.
3300: 
3301:                         APPEND BLANK
3302:                         GO BOTTOM
3303: 
3304:                         THIS.grd_4c_Dados.Refresh()
3305:                     ENDIF
3306:                 CATCH TO loc_oErro
3307:                     MsgErro(loc_oErro.Message + CHR(13) + ;
3308:                         "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ValidarCodigoBarrasGrade")
3309:                     loc_lResultado = .F.
3310:                 ENDTRY
3311:             ENDIF
3312:         ENDIF

*-- Linhas 3476 a 3502:
3476:                 ENDIF
3477: 
3478:                 IF !EMPTY(loc_cCodigo)
3479:                     loc_cSQL = "SELECT TOP 1 Cods, Descrs FROM SigEtOco WHERE Cods = " + EscaparSQL(loc_cCodigo)
3480:                 ELSE
3481:                     loc_cSQL = "SELECT TOP 1 Cods, Descrs FROM SigEtOco WHERE Descrs = " + EscaparSQL(loc_cDescricao)
3482:                 ENDIF
3483: 
3484:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OcoEtiq")
3485: 
3486:                 IF loc_nResultado >= 1 AND USED("cursor_4c_OcoEtiq") AND RECCOUNT("cursor_4c_OcoEtiq") > 0
3487:                     SELECT cursor_4c_OcoEtiq
3488:                     GO TOP
3489:                     THIS.txt_4c_OcoEtiqs.Value  = ALLTRIM(Cods)
3490:                     THIS.txt_4c_DOcoEtiqs.Value = ALLTRIM(Descrs)
3491:                     loc_lAchou = .T.
3492:                 ENDIF
3493: 
3494:                 IF USED("cursor_4c_OcoEtiq")
3495:                     USE IN cursor_4c_OcoEtiq
3496:                 ENDIF
3497: 
3498:                 *-- Nao achou exato: abre o picker (regra CLAUDE.md #50 -
3499:                 *-- sem aviso, o picker JA eh o feedback; o codigo digitado
3500:                 *-- vira prefixo).
3501:                 IF !loc_lAchou
3502:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigEtOco", ;

*-- Linhas 3511 a 3529:
3511:                         ENDIF
3512: 
3513:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_OcoEtiqBusca")
3514:                             SELECT cursor_4c_OcoEtiqBusca
3515:                             THIS.txt_4c_OcoEtiqs.Value  = ALLTRIM(Cods)
3516:                             THIS.txt_4c_DOcoEtiqs.Value = ALLTRIM(Descrs)
3517:                         ELSE
3518:                             THIS.txt_4c_OcoEtiqs.Value  = ""
3519:                             THIS.txt_4c_DOcoEtiqs.Value = ""
3520:                         ENDIF
3521: 
3522:                         loc_oBusca.Release()
3523:                     ENDIF
3524: 
3525:                     IF USED("cursor_4c_OcoEtiqBusca")
3526:                         USE IN cursor_4c_OcoEtiqBusca
3527:                     ENDIF
3528:                 ENDIF
3529:             ENDIF

*-- Linhas 3553 a 3590:
3553:                     USE IN csConjunto
3554:                 ENDIF
3555: 
3556:                 SELECT MAX(cpros) AS Cpros, MAX(Qtds) AS Qtds, MAX(QtdeEtiq) AS QtdeEtiq, ;
3557:                        MAX(Pedido) AS Pedido, "" AS Obs, SUM(Pvens) AS Pvens, MAX(Moedas) AS Moedas, ;
3558:                        "" AS Empos, MAX(cpros1) AS cpros1, SUM(PrecoDe) AS PrecoDe, MAX(Parcelas) AS Parcelas ;
3559:                     FROM dbImpressao ;
3560:                     INTO CURSOR csConjunto READWRITE
3561: 
3562:                 SELECT dbImpressao
3563:                 ZAP
3564: 
3565:                 SELECT csConjunto
3566:                 GO TOP
3567:                 SCAN
3568:                     SCATTER MEMVAR
3569:                     SELECT dbImpressao
3570:                     APPEND BLANK
3571:                     GATHER MEMVAR
3572:                     SELECT csConjunto
3573:                 ENDSCAN
3574: 
3575:                 SELECT dbImpressao
3576:                 GO TOP
3577: 
3578:                 IF USED("csConjunto")
3579:                     USE IN csConjunto
3580:                 ENDIF
3581:             CATCH TO loc_oErro
3582:                 MsgErro(loc_oErro.Message, "Erro em MontaConjunto")
3583:             ENDTRY
3584:         ENDIF
3585:     ENDPROC
3586: 
3587:     *==========================================================================
3588:     * TagModelo1 - tagmod1 do legado (dump 2459-2541): etiquetas cujo tipo
3589:     * (SigCdTpe.tpespes = 2, "TAG MODELO 1") usam um layout proprio
3590:     * (SigReTg1.frx), montado a partir de dpros/razas/preco em vez da

*-- Linhas 3674 a 3759:
3674:         loc_cCursor    = THIS.this_cCursorEtiquetas
3675: 
3676:         IF USED("LocalTpEti")
3677:             SELECT LocalTpEti
3678:             LOCATE FOR LocalTpEti.nTipos = par_nTpEti
3679: 
3680:             IF !EOF() AND LocalTpEti.tpespes = 2
3681:                 loc_lEhModelo1 = .T.
3682: 
3683:                 TRY
3684:                     IF USED("dbImpressao")
3685:                         USE IN dbImpressao
3686:                     ENDIF
3687:                     CREATE CURSOR dbImpressao (CPros C(14), dpros C(40), Cbars N(14, 0), ;
3688:                         Pvens N(12, 2), razas C(30), Reffs C(40), codtams C(4), CodCors C(4))
3689:                     INDEX ON cpros TAG cpros
3690: 
3691:                     SQLEXEC(gnConnHandle, "SELECT cemps, razas FROM SigCdEmp", "crSigCdEmp")
3692:                     SQLEXEC(gnConnHandle, "SELECT observas, codigos FROM SigCdObs", "crSigCdObs")
3693: 
3694:                     IF USED(loc_cCursor)
3695:                         SELECT (loc_cCursor)
3696:                         SCAN
3697:                             IF EVALUATE(loc_cCursor + ".Flag")
3698:                                 IF USED("crSigCdEmp")
3699:                                     SELECT crSigCdEmp
3700:                                     LOCATE FOR cemps = EVALUATE(loc_cCursor + ".empos")
3701:                                 ENDIF
3702: 
3703:                                 IF USED("crSigCdObs")
3704:                                     SELECT crSigCdObs
3705:                                     LOCATE FOR codigos = LocalTpEti.codobs
3706:                                 ENDIF
3707: 
3708:                                 SQLEXEC(gnConnHandle, "SELECT dpros, PVIdeals, Moedas, PVens, Moevs FROM SigCdPro " + ;
3709:                                     "WHERE Cpros = " + EscaparSQL(EVALUATE(loc_cCursor + ".Cpros")), "LocalPro")
3710: 
3711:                                 SELECT (loc_cCursor)
3712: 
3713:                                 INSERT INTO dbImpressao (Cpros, Cbars, dpros, pvens, razas, reffs, codtams, codcors) ;
3714:                                     VALUES (EVALUATE(loc_cCursor + ".Cpros"), ;
3715:                                             EVALUATE(loc_cCursor + ".cbars"), ;
3716:                                             IIF(USED("LocalPro"), NVL(LocalPro.dpros, ""), ""), ;
3717:                                             IIF(par_lImpPreco, EVALUATE(loc_cCursor + ".Pvens"), 0), ;
3718:                                             IIF(USED("crSigCdEmp"), NVL(crSigCdEmp.razas, ""), ""), ;
3719:                                             EVALUATE(loc_cCursor + ".reffs"), ;
3720:                                             EVALUATE(loc_cCursor + ".codtams"), ;
3721:                                             EVALUATE(loc_cCursor + ".codcors"))
3722:                             ENDIF
3723:                         ENDSCAN
3724:                     ENDIF
3725: 
3726:                     SELECT dbImpressao
3727:                     GO TOP
3728: 
3729:                     IF !EOF()
3730:                         SET ORDER TO TAG cpros
3731: 
3732:                         IF par_cTipo = "I"
3733:                             IF FILE(FULLPATH(gc_4c_CaminhoReports + "SigReTg1.frx"))
3734:                                 THIS.ExecutarReportForm("SigReTg1", "PRINTER")
3735:                             ELSE
3736:                                 MsgErro("Relat" + CHR(243) + "rio de etiqueta (SigReTg1) n" + CHR(227) + ;
3737:                                     "o encontrado.", "Erro")
3738:                             ENDIF
3739:                         ELSE
3740:                             SELECT dbImpressao
3741:                             SCAN
3742:                                 loc_nBrr = INT(VAL(dbImpressao.Cpros))
3743:                                 SQLEXEC(gnConnHandle, "UPDATE SigCdPro SET ImpEtiqs = 1 WHERE CPros IN " + ;
3744:                                     "(SELECT CPros FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBrr) + ")")
3745:                             ENDSCAN
3746:                         ENDIF
3747:                     ENDIF
3748:                 CATCH TO loc_oErro
3749:                     MsgErro(loc_oErro.Message + CHR(13) + ;
3750:                         "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em TagModelo1")
3751:                 ENDTRY
3752:             ENDIF
3753:         ENDIF
3754: 
3755:         RETURN loc_lEhModelo1
3756:     ENDPROC
3757: 
3758:     *==========================================================================
3759:     * RegistrarOcorrenciaEtiquetas - bloco "If Thisform.GravaOcorrencia"

*-- Linhas 3765 a 3797:
3765: 
3766:         IF THIS.this_lGravaOcorrencia AND USED("dbImpressao")
3767:             TRY
3768:                 SELECT dbImpressao
3769:                 SCAN
3770:                     loc_cSQL = "INSERT INTO SigEtOcr (Cbars, Datas, Horas, Usuars, Qtds, Cods, Justifs, cidchaves) " + ;
3771:                         "VALUES (" + ;
3772:                         FormatarNumeroSQL(INT(VAL(dbImpressao.Cpros)), 0) + ", " + ;
3773:                         FormatarDataSQL(DATE()) + ", " + ;
3774:                         EscaparSQL(TIME()) + ", " + ;
3775:                         EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
3776:                         FormatarNumeroSQL(dbImpressao.QtdeEtiq, 0) + ", " + ;
3777:                         EscaparSQL(ALLTRIM(THIS.txt_4c_OcoEtiqs.Value)) + ", " + ;
3778:                         EscaparSQL(THIS.obj_4c_GetJustifs.Value) + ", " + ;
3779:                         EscaparSQL(LEFT(fUniqueIds(), 20)) + ")"
3780: 
3781:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
3782:                         MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - SigEtOcr)")
3783:                     ENDIF
3784:                 ENDSCAN
3785:             CATCH TO loc_oErro
3786:                 MsgErro(loc_oErro.Message, "Erro em RegistrarOcorrenciaEtiquetas")
3787:             ENDTRY
3788:         ENDIF
3789:     ENDPROC
3790: 
3791:     *==========================================================================
3792:     * ImpressaoValidarOcorrenciaObrigatoria - "Consiste os Parametros" do
3793:     * Impressao() legado (dump 1949-1970): a Ocorrencia eh obrigatoria
3794:     * quando this_lGravaOcorrencia, e a Justificativa eh obrigatoria quando
3795:     * a ocorrencia escolhida exige (SigEtOco.Justifs = 1).
3796:     *==========================================================================
3797:     PROCEDURE ImpressaoValidarOcorrenciaObrigatoria()

*-- Linhas 3810 a 3835:
3810:                     IF USED("TmpOcEti")
3811:                         USE IN TmpOcEti
3812:                     ENDIF
3813:                     loc_cSQL = "SELECT * FROM SigEtOco WHERE Cods = " + EscaparSQL(ALLTRIM(THIS.txt_4c_OcoEtiqs.Value))
3814:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TmpOcEti")
3815: 
3816:                     IF loc_nResultado < 1
3817:                         MsgErro("Favor reinicializar o processo !!!", "Falha na Conex" + CHR(227) + "o (TmpOcEti)")
3818:                         loc_lResultado = .F.
3819:                     ELSE
3820:                         SELECT TmpOcEti
3821:                         GO TOP
3822:                         IF !EOF() AND TmpOcEti.Justifs = 1 AND EMPTY(THIS.obj_4c_GetJustifs.Value)
3823:                             MsgAviso("Ocorr" + CHR(234) + "ncia com Justificativa Obrigat" + CHR(243) + "ria !!!", ;
3824:                                 "Campo Obrigat" + CHR(243) + "rio")
3825:                             THIS.obj_4c_GetJustifs.SetFocus()
3826:                             loc_lResultado = .F.
3827:                         ENDIF
3828:                     ENDIF
3829:                 CATCH TO loc_oErro
3830:                     MsgErro(loc_oErro.Message, "Erro em ImpressaoValidarOcorrenciaObrigatoria")
3831:                     loc_lResultado = .F.
3832:                 ENDTRY
3833:             ENDIF
3834:         ENDIF
3835: 

*-- Linhas 3850 a 3868:
3850:             loc_lTratado = .T.
3851: 
3852:             THIS.GarantirCursorImpressao()
3853:             SELECT dbImpressao
3854:             ZAP
3855:             APPEND BLANK
3856:             REPLACE Cpros WITH "1", Qtds WITH 1
3857: 
3858:             loc_cTexto = THIS.obj_4c_GetTexto.Value
3859: 
3860:             IF par_cTipo = "I"
3861:                 TRY
3862:                     SigOpEtq(gnConnHandle, .F., .F., par_nTpEti, THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value, ;
3863:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value, ;
3864:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value, ;
3865:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value, "", "", "", ;
3866:                         THIS.ObterNomeImpressoraAtual(), .F., .F., THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value, ;
3867:                         .F., .F., .F., .F., .F., .F., loc_cTexto)
3868:                 CATCH TO loc_oErro

*-- Linhas 3894 a 3931:
3894:                 loc_cTexto = ALLTRIM(STR(IIF(!EMPTY(THIS.txt_4c_QtParcs.Value), THIS.txt_4c_QtParcs.Value, 1)))
3895: 
3896:                 THIS.GarantirCursorImpressao()
3897:                 SELECT dbImpressao
3898:                 ZAP
3899: 
3900:                 IF USED(loc_cCursor)
3901:                     SELECT (loc_cCursor)
3902:                     loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Etiquetas...", RECCOUNT())
3903:                     loc_oProgresso.Show()
3904: 
3905:                     SCAN
3906:                         loc_oProgresso.Update(.T.)
3907: 
3908:                         IF EVALUATE(loc_cCursor + ".Flag")
3909:                             IF EVALUATE(loc_cCursor + ".Mantem")
3910:                                 SCATTER MEMVAR MEMO
3911:                                 SELECT dbImpressao
3912:                                 APPEND BLANK
3913:                                 GATHER MEMVAR MEMO
3914:                                 SELECT (loc_cCursor)
3915:                             ELSE
3916:                                 INSERT INTO dbImpressao (cpros, Qtds, QtdeEtiq, Pedido, Obs, Pvens, Moedas, Empos, cpros1, PrecoDe, Parcelas) ;
3917:                                     VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, EVALUATE(loc_cCursor + ".Qtds"), ;
3918:                                             NVL(EVALUATE(loc_cCursor + ".CodAmss"), ""), NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), ""), ;
3919:                                             EVALUATE(loc_cCursor + ".Pvens"), EVALUATE(loc_cCursor + ".Moedas"), ;
3920:                                             EVALUATE(loc_cCursor + ".Empos"), EVALUATE(loc_cCursor + ".Cpros"), ;
3921:                                             EVALUATE(loc_cCursor + ".PrecoDe"), EVALUATE(loc_cCursor + ".Parcelas"))
3922:                             ENDIF
3923:                         ENDIF
3924:                     ENDSCAN
3925: 
3926:                     loc_oProgresso.Complete()
3927:                 ENDIF
3928: 
3929:                 THIS.MontaConjunto()
3930: 
3931:                 IF par_cTipo = "I"

*-- Linhas 3960 a 4100:
3960: 
3961:         TRY
3962:             THIS.GarantirCursorImpressao()
3963:             SELECT dbImpressao
3964:             ZAP
3965:             IF USED("crSigEtOcr")
3966:                 SELECT crSigEtOcr
3967:                 ZAP
3968:             ENDIF
3969: 
3970:             IF USED(loc_cCursor)
3971:                 SELECT (loc_cCursor)
3972:                 loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Etiquetas...", RECCOUNT())
3973:                 loc_oProgresso.Show()
3974: 
3975:                 SCAN
3976:                     loc_oProgresso.Update(.T.)
3977: 
3978:                     IF EVALUATE(loc_cCursor + ".Flag")
3979:                         IF EVALUATE(loc_cCursor + ".Mantem")
3980:                             SCATTER MEMVAR MEMO
3981:                             m.Obs = IIF(par_nTpEti = 134, m.CodCors, m.Obs)
3982:                             SELECT dbImpressao
3983:                             APPEND BLANK
3984:                             GATHER MEMVAR MEMO
3985:                             SELECT (loc_cCursor)
3986:                         ELSE
3987:                             IF par_nTpEti = 12
3988:                                 SQLEXEC(gnConnHandle, "SELECT * FROM SigCdOpe WHERE Dopes = " + ;
3989:                                     EscaparSQL(EVALUATE(loc_cCursor + ".Dopes")), "LocalOpe")
3990: 
3991:                                 IF USED("LocalOpe") AND !EOF("LocalOpe")
3992:                                     INSERT INTO dbImpressao (Cpros, Qtds, Cbars, Obs, cpros1) ;
3993:                                         VALUES (EVALUATE(loc_cCursor + ".Cpros"), 1, ;
3994:                                             VAL(STR(LocalOpe.Ndopes, 4) + TRANSFORM(EVALUATE(loc_cCursor + ".Cbars"), "@L 9999999999")), ;
3995:                                             NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), ""), EVALUATE(loc_cCursor + ".Cpros"))
3996:                                 ENDIF
3997:                             ELSE
3998:                                 loc_nQtd = EVALUATE(loc_cCursor + ".Qtds")
3999: 
4000:                                 IF EMPTY(EVALUATE(loc_cCursor + ".Nops"))
4001:                                     INSERT INTO dbImpressao (Cpros, Qtds, QtdeEtiq, Pedido, Obs, Pvens, Moedas, Empos, cpros1, CodTams, PrecoDe, Parcelas) ;
4002:                                         VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, loc_nQtd, ;
4003:                                             NVL(EVALUATE(loc_cCursor + ".CodAmss"), ""), ;
4004:                                             IIF(par_nTpEti = 134, EVALUATE(loc_cCursor + ".CodCors"), NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), "")), ;
4005:                                             EVALUATE(loc_cCursor + ".Pvens"), EVALUATE(loc_cCursor + ".Moedas"), ;
4006:                                             EVALUATE(loc_cCursor + ".Empos"), EVALUATE(loc_cCursor + ".Cpros"), ;
4007:                                             EVALUATE(loc_cCursor + ".CodTams"), EVALUATE(loc_cCursor + ".PrecoDe"), ;
4008:                                             IIF(par_nOptPreco = 6 AND EMPTY(EVALUATE(loc_cCursor + ".Parcelas")), 1, EVALUATE(loc_cCursor + ".Parcelas")))
4009: 
4010:                                     IF INLIST(par_nTpEti, 39)
4011:                                         loc_cEdn = EVALUATE(loc_cCursor + ".Empos") + EVALUATE(loc_cCursor + ".Dopeos") + ;
4012:                                             STR(EVALUATE(loc_cCursor + ".Numeos"), 6)
4013:                                         SQLEXEC(gnConnHandle, "SELECT ContaOs, ContaDs, Vends FROM SigMvCab WHERE EmpDopNums = " + ;
4014:                                             EscaparSQL(loc_cEdn), "LocalEest")
4015:                                         IF USED("LocalEest") AND !EOF("LocalEest")
4016:                                             loc_cConta = IIF(EMPTY(LocalEest.ContaDs), LocalEest.ContaOs, LocalEest.ContaDs) + "/" + ;
4017:                                                 ALLTRIM(STR(EVALUATE(loc_cCursor + ".Numeos"), 6))
4018:                                             REPLACE Pedido WITH loc_cConta IN dbImpressao
4019:                                         ENDIF
4020:                                     ENDIF
4021: 
4022:                                     IF INLIST(par_nTpEti, 23, 26, 24, 93, 135)
4023:                                         REPLACE empdopnums WITH EVALUATE(loc_cCursor + ".empdopnums") IN dbImpressao
4024:                                     ENDIF
4025:                                 ELSE
4026:                                     SQLEXEC(gnConnHandle, "SELECT Abrevs, Globalizas FROM SigCdOpe WHERE Dopes = " + ;
4027:                                         EscaparSQL(EVALUATE(loc_cCursor + ".DopeOs")), "LocalOpe")
4028: 
4029:                                     IF USED("LocalOpe") AND !EOF("LocalOpe")
4030:                                         INSERT INTO dbImpressao (Cpros, Qtds, QtdeEtiq, Pedido, Obs, Pvens, Moedas, Empos, cpros1, CodTams, PrecoDe, Parcelas) ;
4031:                                             VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, loc_nQtd, ;
4032:                                                 ALLTRIM(LocalOpe.Abrevs) + " : " + ALLTRIM(STR(EVALUATE(loc_cCursor + ".NumeOs"))), ;
4033:                                                 IIF(par_nTpEti = 134, EVALUATE(loc_cCursor + ".CodCors"), NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), "")), ;
4034:                                                 EVALUATE(loc_cCursor + ".Pvens"), EVALUATE(loc_cCursor + ".Moedas"), ;
4035:                                                 EVALUATE(loc_cCursor + ".Empos"), EVALUATE(loc_cCursor + ".Cpros"), ;
4036:                                                 EVALUATE(loc_cCursor + ".CodTams"), EVALUATE(loc_cCursor + ".PrecoDe"), ;
4037:                                                 IIF(par_nOptPreco = 6 AND EMPTY(EVALUATE(loc_cCursor + ".Parcelas")), 1, EVALUATE(loc_cCursor + ".Parcelas")))
4038: 
4039:                                         IF INLIST(par_nTpEti, 23, 26, 24, 93, 135)
4040:                                             REPLACE empdopnums WITH EVALUATE(loc_cCursor + ".empdopnums") IN dbImpressao
4041:                                         ENDIF
4042: 
4043:                                         IF INLIST(par_nTpEti, 39, 109, 113)
4044:                                             loc_cEdn = EVALUATE(loc_cCursor + ".Empos") + EVALUATE(loc_cCursor + ".Dopeos") + ;
4045:                                                 STR(EVALUATE(loc_cCursor + ".Numeos"), 6)
4046:                                             SQLEXEC(gnConnHandle, "SELECT ContaOs, ContaDs, Vends FROM SigMvCab WHERE EmpDopNums = " + ;
4047:                                                 EscaparSQL(loc_cEdn), "LocalEest")
4048: 
4049:                                             IF USED("LocalEest") AND !EOF("LocalEest")
4050:                                                 loc_cConta = IIF(LocalOpe.Globalizas = 1, LocalEest.ContaOs, LocalEest.ContaDs) + ;
4051:                                                     IIF(INLIST(par_nTpEti, 39), "/" + ALLTRIM(STR(EVALUATE(loc_cCursor + ".Numeos"), 6)), "")
4052: 
4053:                                                 IF INLIST(par_nTpEti, 109, 113)
4054:                                                     SQLEXEC(gnConnHandle, "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
4055:                                                         EscaparSQL(loc_cConta), "LocalCli")
4056:                                                     IF USED("LocalCli") AND !EOF("LocalCli")
4057:                                                         loc_cConta = LocalCli.Rclis
4058:                                                     ENDIF
4059:                                                 ENDIF
4060: 
4061:                                                 REPLACE Pedido WITH loc_cConta IN dbImpressao
4062:                                             ENDIF
4063:                                         ENDIF
4064:                                     ENDIF
4065:                                 ENDIF
4066:                             ENDIF
4067:                         ENDIF
4068:                     ENDIF
4069:                 ENDSCAN
4070: 
4071:                 loc_oProgresso.Complete()
4072:             ENDIF
4073: 
4074:             SELECT dbImpressao
4075:             GO TOP
4076: 
4077:             IF !EOF()
4078:                 IF par_cTipo = "I"
4079:                     loc_lPreco = .T.
4080:                     IF !INLIST(THIS.ObterTipoChamador(), "CADASTRO", "UNITARIO", "OPERACAO")
4081:                         IF INLIST(par_nOptPreco, 3, 4)
4082:                             SELECT dbImpressao
4083:                             SCAN
4084:                                 SQLEXEC(gnConnHandle, "SELECT PVIdeals, Moedas, PVens, Moevs, PrecoDe FROM SigCdPro WHERE CPros = " + ;
4085:                                     EscaparSQL(dbImpressao.CPros1), "LocalPro")
4086: 
4087:                                 IF USED("LocalPro")
4088:                                     GO TOP IN LocalPro
4089:                                     IF !EOF("LocalPro")
4090:                                         REPLACE PVens   WITH IIF(par_nOptPreco = 3, LocalPro.PVIdeals, LocalPro.PVens), ;
4091:                                                 Moedas  WITH IIF(par_nOptPreco = 3, LocalPro.Moedas,   LocalPro.MoeVs), ;
4092:                                                 PrecoDe WITH LocalPro.PrecoDe IN dbImpressao
4093:                                     ENDIF
4094:                                 ENDIF
4095:                             ENDSCAN
4096:                         ENDIF
4097:                     ENDIF
4098: 
4099:                     THIS.MontaConjunto()
4100: 

*-- Linhas 4110 a 4139:
4110:                 ELSE
4111:                     loc_nBrr = INT(VAL(dbImpressao.Cpros))
4112: 
4113:                     SQLEXEC(gnConnHandle, "SELECT CPros FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBrr), "csBarra")
4114: 
4115:                     IF USED("csBarra") AND !EOF("csBarra")
4116:                         loc_cBrr = csBarra.CPros
4117:                         loc_cSQL = "UPDATE SigCdPro SET ImpEtiqs = 1 WHERE CPros = " + EscaparSQL(loc_cBrr)
4118: 
4119:                         IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
4120:                             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - SigCdPro)")
4121:                         ENDIF
4122: 
4123:                         IF USED("crSigCdPro")
4124:                             UPDATE crSigCdPro SET ImpEtiqs = .T. WHERE CPros = loc_cBrr
4125:                         ENDIF
4126:                     ENDIF
4127:                 ENDIF
4128: 
4129:                 THIS.RegistrarOcorrenciaEtiquetas()
4130:             ELSE
4131:                 MsgAviso("Nenhuma Etiqueta Selecionada!!!", "")
4132:             ENDIF
4133:         CATCH TO loc_oErro
4134:             MsgErro(loc_oErro.Message + CHR(13) + ;
4135:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4136:                 "Procedure: " + loc_oErro.Procedure, "Erro em ImprimirSemAgrupamento")
4137:         ENDTRY
4138:     ENDPROC
4139: 

*-- Linhas 4152 a 4312:
4152: 
4153:         TRY
4154:             IF USED(loc_cCursor)
4155:                 SELECT (loc_cCursor)
4156: 
4157:                 IF THIS.this_nOrdemImp != 3
4158:                     SET ORDER TO TAG EmpGruCon
4159:                 ENDIF
4160: 
4161:                 GO TOP
4162: 
4163:                 loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Dados do Cursor...", RECCOUNT())
4164:                 loc_oProgresso.Show()
4165: 
4166:                 DO WHILE !EOF(loc_cCursor)
4167:                     loc_cEmp = EVALUATE(loc_cCursor + ".Empos")
4168:                     loc_cGrp = EVALUATE(loc_cCursor + ".Grupos")
4169:                     loc_cCta = EVALUATE(loc_cCursor + ".Contas")
4170:                     loc_cRps = IIF(THIS.this_lGravaPro, "Reposicao", " ")
4171: 
4172:                     THIS.GarantirCursorImpressao()
4173:                     SELECT dbImpressao
4174:                     ZAP
4175:                     IF USED("crSigEtOcr")
4176:                         SELECT crSigEtOcr
4177:                         ZAP
4178:                     ENDIF
4179: 
4180:                     SELECT (loc_cCursor)
4181: 
4182:                     DO WHILE !EOF(loc_cCursor)
4183:                         IF THIS.this_nOrdemImp != 3
4184:                             IF EVALUATE(loc_cCursor + ".Empos") + EVALUATE(loc_cCursor + ".Grupos") + ;
4185:                                     EVALUATE(loc_cCursor + ".Contas") != loc_cEmp + loc_cGrp + loc_cCta
4186:                                 EXIT
4187:                             ENDIF
4188:                         ENDIF
4189: 
4190:                         loc_oProgresso.Update(.T.)
4191: 
4192:                         IF EVALUATE(loc_cCursor + ".Flag")
4193:                             IF EVALUATE(loc_cCursor + ".Mantem")
4194:                                 SCATTER MEMVAR MEMO
4195:                                 SELECT dbImpressao
4196:                                 APPEND BLANK
4197:                                 GATHER MEMVAR MEMO
4198:                                 SELECT (loc_cCursor)
4199:                             ELSE
4200:                                 loc_nQtd = EVALUATE(loc_cCursor + ".Qtds")
4201: 
4202:                                 IF EMPTY(EVALUATE(loc_cCursor + ".Nops"))
4203:                                     INSERT INTO dbImpressao (Cpros, Qtds, QtdeEtiq, Obs) ;
4204:                                         VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, loc_nQtd, ;
4205:                                             NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), ""))
4206:                                 ELSE
4207:                                     SQLEXEC(gnConnHandle, "SELECT Abrevs, Globalizas FROM SigCdOpe WHERE Dopes = " + ;
4208:                                         EscaparSQL(EVALUATE(loc_cCursor + ".DopeOs")), "LocalOpe")
4209: 
4210:                                     IF USED("LocalOpe") AND !EOF("LocalOpe")
4211:                                         INSERT INTO dbImpressao (Cpros, Qtds, QtdeEtiq, Pedido, Obs) ;
4212:                                             VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, loc_nQtd, ;
4213:                                                 ALLTRIM(LocalOpe.Abrevs) + " : " + ALLTRIM(STR(EVALUATE(loc_cCursor + ".Numeos"))), ;
4214:                                                 NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), ""))
4215: 
4216:                                         IF INLIST(par_nTpEti, 39, 109, 113)
4217:                                             loc_cEdn = EVALUATE(loc_cCursor + ".Empos") + EVALUATE(loc_cCursor + ".Dopeos") + ;
4218:                                                 STR(EVALUATE(loc_cCursor + ".Numeos"), 6)
4219:                                             SQLEXEC(gnConnHandle, "SELECT ContaOs, ContaDs, Vends FROM SigMvCab WHERE EmpDopNums = " + ;
4220:                                                 EscaparSQL(loc_cEdn), "LocalEest")
4221: 
4222:                                             IF USED("LocalEest") AND !EOF("LocalEest")
4223:                                                 loc_cConta = IIF(LocalOpe.Globalizas = 1, LocalEest.ContaOs, LocalEest.ContaDs) + ;
4224:                                                     IIF(INLIST(par_nTpEti, 39), "/" + ALLTRIM(STR(EVALUATE(loc_cCursor + ".Numeos"), 6)), "")
4225: 
4226:                                                 IF INLIST(par_nTpEti, 109, 113)
4227:                                                     SQLEXEC(gnConnHandle, "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
4228:                                                         EscaparSQL(loc_cConta), "LocalCli")
4229:                                                     IF USED("LocalCli") AND !EOF("LocalCli")
4230:                                                         loc_cConta = LocalCli.Rclis
4231:                                                     ENDIF
4232:                                                 ENDIF
4233: 
4234:                                                 REPLACE Pedido WITH loc_cConta IN dbImpressao
4235:                                             ENDIF
4236:                                         ENDIF
4237:                                     ENDIF
4238:                                 ENDIF
4239:                             ENDIF
4240:                         ENDIF
4241: 
4242:                         SELECT (loc_cCursor)
4243:                         SKIP
4244:                     ENDDO
4245: 
4246:                     *-- Legado: "Skip -1" reposiciona no ULTIMO registro do
4247:                     *-- grupo que acabou de ser processado, para o SKIP
4248:                     *-- implicito do loop externo avancar para o grupo
4249:                     *-- seguinte (mesma semantica do Scan/Scan While/Skip -1
4250:                     *-- aninhados do dump).
4251:                     IF !BOF(loc_cCursor)
4252:                         SKIP -1 IN (loc_cCursor)
4253:                     ENDIF
4254: 
4255:                     SELECT dbImpressao
4256:                     GO TOP
4257: 
4258:                     THIS.MontaConjunto()
4259: 
4260:                     IF !EOF("dbImpressao")
4261:                         IF par_cTipo = "I"
4262:                             SigOpEtq(gnConnHandle, par_lImpPreco, .F., par_nTpEti, ;
4263:                                 THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value, ;
4264:                                 THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value, ;
4265:                                 THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value, ;
4266:                                 THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value, loc_cEmp, loc_cGrp, loc_cCta, ;
4267:                                 THIS.ObterNomeImpressoraAtual(), .F., loc_cRps, ;
4268:                                 THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value, par_lImpPesoTotal, ;
4269:                                 .F., .F., .F., .F., (THIS.cnt_4c__Impressora.chk_4c_Chk_Resete.Value = 1))
4270: 
4271:                             IF THIS.ObterTipoChamador() == "ARQUIVADAS"
4272:                                 THIS.this_lImpArquivadas = .T.
4273:                             ENDIF
4274:                         ELSE
4275:                             loc_nBrr = INT(VAL(dbImpressao.Cpros))
4276: 
4277:                             SQLEXEC(gnConnHandle, "SELECT CPros FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBrr), "csBarra")
4278: 
4279:                             IF USED("csBarra") AND !EOF("csBarra")
4280:                                 loc_cBrr = csBarra.CPros
4281:                                 loc_cSQL = "UPDATE SigCdPro SET ImpEtiqs = 1 WHERE CPros = " + EscaparSQL(loc_cBrr)
4282: 
4283:                                 IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
4284:                                     MsgErro("Favor Reinicializar o Processo!!!", ;
4285:                                         "Falha na Conex" + CHR(227) + "o (Update - SigCdPro)")
4286:                                 ENDIF
4287: 
4288:                                 IF USED("crSigCdPro")
4289:                                     UPDATE crSigCdPro SET ImpEtiqs = .T. WHERE CPros = loc_cBrr
4290:                                 ENDIF
4291:                             ENDIF
4292:                         ENDIF
4293: 
4294:                         THIS.RegistrarOcorrenciaEtiquetas()
4295:                     ENDIF
4296: 
4297:                     SELECT (loc_cCursor)
4298:                 ENDDO
4299: 
4300:                 loc_oProgresso.Complete()
4301:             ENDIF
4302:         CATCH TO loc_oErro
4303:             MsgErro(loc_oErro.Message + CHR(13) + ;
4304:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4305:                 "Procedure: " + loc_oErro.Procedure, "Erro em ImprimirAgrupadoPorContaOs")
4306:         ENDTRY
4307:     ENDPROC
4308: 
4309:     *==========================================================================
4310:     * GerarOperacaoEtiquetas - bloco final de Impressao() (dump 2381-2450):
4311:     * quando a impressao eh imediata e o chamador configurou uma operacao
4312:     * de destino (LocalParac.DopEtiqs), gera o movimento correspondente em

*-- Linhas 4320 a 4377:
4320:     *
4321:     * SigMvCab e SigMvItn tem mais de 100 colunas NOT NULL cada (conferido
4322:     * em docs\schema.sql); o legado grava via cursor BUFFERIZADO inteiro
4323:     * (AddCursor + TableUpdate), que preenche as colunas nao citadas com o
4324:     * branco do registro em branco do cursor. Um INSERT parcial aqui
4325:     * quebraria o NOT NULL em runtime (regra CLAUDE.md #22 - mesma classe
4326:     * dos Erro151/Erro159) - por isso SigMvCab/SigMvItn NAO sao gravados
4327:     * por este metodo ainda; SigMvIts (o item com o codigo de barras) TEM
4328:     * BO proprio e completo (SigOpIpEBO, Fases 1-2, INSERT com as 30
4329:     * colunas da tabela) e esse SIM eh gravado aqui.
4330:     *==========================================================================
4331:     PROCEDURE GerarOperacaoEtiquetas(par_nTpEti)
4332:         LOCAL loc_lConfirmou, loc_cDopes, loc_cChave, loc_nItem, loc_nNumes, loc_cEmps, ;
4333:               loc_oBO, loc_oErro
4334: 
4335:         IF USED("LocalParac") AND !EMPTY(NVL(LocalParac.DopEtiqs, "")) AND par_nTpEti != 12
4336:             loc_cDopes = ALLTRIM(LocalParac.DopEtiqs)
4337: 
4338:             loc_lConfirmou = MsgConfirma("Confirma Gera" + CHR(231) + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + ;
4339:                 "o " + loc_cDopes + "!!!", "")
4340: 
4341:             IF loc_lConfirmou
4342:                 TRY
4343:                     IF USED("CsSelecao")
4344:                         USE IN CsSelecao
4345:                     ENDIF
4346:                     SELECT Empos, Grupos, Contas, Cpros, Cbars, CodCors, CodTams, Qtds, Pesos ;
4347:                         FROM (THIS.this_cCursorEtiquetas) WHERE Empos != "  " ;
4348:                         INTO CURSOR CsSelecao ORDER BY 1, 2, 3
4349: 
4350:                     loc_cChave = SPACE(23)
4351:                     loc_nItem  = 1
4352: 
4353:                     MsgErro("A gera" + CHR(231) + CHR(227) + "o autom" + CHR(225) + "tica da opera" + CHR(231) + ;
4354:                         CHR(227) + "o " + loc_cDopes + " tamb" + CHR(233) + "m grava em SigMvCab e SigMvItn, que " + ;
4355:                         "ainda n" + CHR(227) + "o t" + CHR(234) + "m cobertura completa de colunas NOT NULL nesta " + ;
4356:                         "migra" + CHR(231) + CHR(227) + "o. O item em SigMvIts ser" + CHR(225) + " gravado; " + ;
4357:                         "registre o cabe" + CHR(231) + "alho/itens do movimento manualmente.", ;
4358:                         "Grava" + CHR(231) + CHR(227) + "o parcial")
4359: 
4360:                     loc_oBO = THIS.this_oBusinessObject
4361: 
4362:                     SELECT CsSelecao
4363:                     SCAN
4364:                         loc_cEmps = CsSelecao.Empos
4365: 
4366:                         IF Empos + Grupos + Contas != loc_cChave
4367:                             loc_nNumes = fGerUniqueKey(ALLTRIM(loc_cDopes) + loc_cEmps)
4368:                             loc_nItem  = 1
4369:                             loc_cChave = CsSelecao.Empos + CsSelecao.Grupos + CsSelecao.Contas
4370:                         ENDIF
4371: 
4372:                         IF VARTYPE(loc_oBO) = "O" AND (!EMPTY(CsSelecao.CodCors) OR !EMPTY(CsSelecao.CodTams))
4373:                             loc_oBO.this_cEmps      = loc_cEmps
4374:                             loc_oBO.this_cDopes     = loc_cDopes
4375:                             loc_oBO.this_nNumes     = loc_nNumes
4376:                             loc_oBO.this_cCpros     = CsSelecao.Cpros
4377:                             loc_oBO.this_cCodtams   = CsSelecao.CodTams

*-- Linhas 4480 a 4498:
4480:     *
4481:     * poDataGrv/fSqlConector (dump 2621-2630, AddCursor de SigEtOcr/
4482:     * SigMvCab/SigMvItn/SigMvIts) NAO entra: eh um wrapper de acesso a
4483:     * dados que o resto do projeto substitui por SQLEXEC direto, e os
4484:     * quatro cursores que ele abriria (crSigEtOcr/crSigMvCab/crSigMvItn/
4485:     * crSigMvIts) ja sao lidos com guarda USED() pelas Fases 5-7 (ex.
4486:     * GarantirCursorImpressao) assumindo que podem nao existir -
4487:     * implementa-lo seria trazer uma camada de acesso a dados inteira
4488:     * para uma fase que so precisa de quatro cursores especificos
4489:     * (LocalParam/LocalParaC/LocalTpEti/crImpreV, ja fixados como
4490:     * contrato pelas Fases 5-7).
4491:     *==========================================================================
4492:     PROTECTED PROCEDURE CarregarContextoInicial()
4493:         LOCAL loc_oErro
4494: 
4495:         TRY
4496:             *-- Legado: "Thisform.grd_Historico.Column2.Header1.Tag = []"
4497:             THIS.grd_4c_Dados.Column2.Header1.Tag = ""
4498: 

*-- Linhas 4534 a 4587:
4534: 
4535:     *==========================================================================
4536:     * CarregarParametrosSistema - LocalParam/LocalParaC (SigCdPam/SigCdPaC),
4537:     * tabelas de UMA linha so - mesma leitura "SELECT sem WHERE" que o
4538:     * irmao sigopetsBO documenta para CrSigCdPam/CrSigCdPac.
4539:     *
4540:     * Legado (Init:2632-2634):
4541:     *   lcCpo = 'OcoEtiqs, Ouros, nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis,
4542:     *            AjVerts, AjHorzs, LibObss, TpInstalas'
4543:     *   CursorQuery('SigCdPam', 'LocalParam', .F., .F., lcCpo)
4544:     *   CursorQuery('SigCdPaC', 'LocalParaC', .F., .F., 'AjDens, AjVelos,
4545:     *            EtqSeps, DopEtiqs, QtdMarPar, VlrMinPar')
4546:     *
4547:     * SQLEXEC com SELECT explicito (nunca SELECT *) - colunas conferidas
4548:     * em docs\schema.sql (UTF-16, Get-Content -Raw).
4549:     *==========================================================================
4550:     PROTECTED FUNCTION CarregarParametrosSistema()
4551:         LOCAL loc_lSucesso, loc_nResultado, loc_oErro
4552: 
4553:         loc_lSucesso = .F.
4554: 
4555:         TRY
4556:             IF USED("LocalParam")
4557:                 USE IN LocalParam
4558:             ENDIF
4559: 
4560:             loc_nResultado = SQLEXEC(gnConnHandle, ;
4561:                 "SELECT OcoEtiqs, Ouros, nMaxTpEtis, TpEtiPads, nMaxImpEti, " + ;
4562:                 "ImpEtis, AjVerts, AjHorzs, LibObss, TpInstalas FROM SigCdPam", ;
4563:                 "LocalParam")
4564: 
4565:             IF loc_nResultado >= 1 AND USED("LocalParam")
4566:                 IF USED("LocalParaC")
4567:                     USE IN LocalParaC
4568:                 ENDIF
4569: 
4570:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
4571:                     "SELECT AjDens, AjVelos, EtqSeps, DopEtiqs, QtdMarPar, " + ;
4572:                     "VlrMinPar FROM SigCdPaC", "LocalParaC")
4573: 
4574:                 loc_lSucesso = (loc_nResultado >= 1) AND USED("LocalParaC")
4575:             ENDIF
4576: 
4577:             IF !loc_lSucesso
4578:                 THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
4579:             ENDIF
4580:         CATCH TO loc_oErro
4581:             loc_lSucesso = .F.
4582:             THIS.this_cMensagemErro = loc_oErro.Message
4583:             MsgErro(loc_oErro.Message + CHR(13) + ;
4584:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarParametrosSistema")
4585:         ENDTRY
4586: 
4587:         RETURN loc_lSucesso

*-- Linhas 4663 a 4696:
4663:                 USE IN LocalTpEti
4664:             ENDIF
4665: 
4666:             loc_nResultado = SQLEXEC(gnConnHandle, ;
4667:                 "SELECT * FROM SigCdTpe WHERE nSituas = 1 ORDER BY cOrdems, cEtiquetas", ;
4668:                 "LocalTpEti")
4669: 
4670:             loc_nTotalTipos = IIF(loc_nResultado >= 1 AND USED("LocalTpEti"), ;
4671:                 RECCOUNT("LocalTpEti"), 0)
4672:             THIS.this_nTotalTiposEtiqueta = loc_nTotalTipos
4673: 
4674:             IF loc_nTotalTipos != 0 AND USED("LocalParam")
4675:                 loc_nMaxBotoes = MIN(loc_nTotalTipos, MAX(LocalParam.nMaxTpEtis, 5))
4676:                 loc_oGrupo.ButtonCount = loc_nMaxBotoes
4677: 
4678:                 loc_nIndicePadrao = 1
4679:                 loc_nTop          = 10
4680: 
4681:                 SELECT LocalTpEti
4682:                 GO TOP
4683:                 loc_nI = 1
4684:                 SCAN WHILE loc_nI <= loc_nMaxBotoes
4685:                     IF LocalTpEti.nTipos = LocalParam.TpEtiPads
4686:                         loc_nIndicePadrao = loc_nI
4687:                     ENDIF
4688: 
4689:                     loc_oBotao = loc_oGrupo.Buttons(loc_nI)
4690:                     loc_oBotao.AutoSize  = .F.
4691:                     loc_oBotao.Width     = loc_oGrupo.Width - 10
4692:                     loc_oBotao.Caption   = "\<" + CHR(96 + loc_nI) + ". " + ALLTRIM(LocalTpEti.cEtiquetas)
4693:                     loc_oBotao.FontSize  = 8
4694:                     loc_oBotao.ForeColor = RGB(36, 84, 155)
4695:                     loc_oBotao.Tag       = ALLTRIM(STR(LocalTpEti.nTipos))
4696:                     loc_oBotao.Top       = loc_nTop

*-- Linhas 4782 a 4807:
4782:                 USE IN LocalEti
4783:             ENDIF
4784: 
4785:             loc_nResultado = SQLEXEC(gnConnHandle, ;
4786:                 "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBarra), "LocalEti")
4787: 
4788:             IF loc_nResultado >= 1 AND USED("LocalEti") AND !EOF("LocalEti") AND USED(loc_cCursor)
4789:                 SELECT LocalEti
4790:                 SCATTER MEMVAR
4791:                 m.Flag = .T.
4792:                 INSERT INTO (loc_cCursor) FROM MEMVAR
4793:             ENDIF
4794:         CATCH TO loc_oErro
4795:             THIS.this_cMensagemErro = loc_oErro.Message
4796:             MsgErro(loc_oErro.Message + CHR(13) + ;
4797:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasUnitario")
4798:         ENDTRY
4799:     ENDPROC
4800: 
4801:     *==========================================================================
4802:     * CarregarLinhasOperacao - Tipo='OPERACAO' (dump 2730-2775): as
4803:     * etiquetas vem do cursor dbImpressao que o form PAI (SigMvCab) ja
4804:     * deixou aberto (contrato entre forms - nao se recria aqui, so se le
4805:     * com guarda USED()).
4806:     *
4807:     * Column6(name)/migrado Column9 (pVens/Preco) vira editavel aqui -

*-- Linhas 4820 a 4866:
4820: 
4821:         TRY
4822:             IF USED("dbImpressao")
4823:                 SELECT dbImpressao
4824:                 SCAN
4825:                     loc_nBarra = INT(VAL(dbImpressao.Cpros))
4826: 
4827:                     IF USED("LocalEti")
4828:                         USE IN LocalEti
4829:                     ENDIF
4830:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
4831:                         "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBarra), "LocalEti")
4832: 
4833:                     IF loc_nResultado >= 1 AND USED("LocalEti")
4834:                         SELECT LocalEti
4835:                         SCATTER MEMVAR
4836:                         m.Flag = .T.
4837:                         m.Qtds = dbImpressao.Qtds
4838: 
4839:                         IF USED("LocalPro")
4840:                             USE IN LocalPro
4841:                         ENDIF
4842:                         SQLEXEC(gnConnHandle, "SELECT CUniPs, cGrus, Categoria FROM SigCdPro " + ;
4843:                             "WHERE CPros = " + EscaparSQL(LocalEti.Cpros), "LocalPro")
4844: 
4845:                         loc_lDistribui = .F.
4846:                         IF USED("LocalPro") AND !EOF("LocalPro")
4847:                             IF USED("LocalUni")
4848:                                 USE IN LocalUni
4849:                             ENDIF
4850:                             SQLEXEC(gnConnHandle, "SELECT Distribs FROM SigCdUni WHERE CUnis = " + ;
4851:                                 EscaparSQL(LocalPro.CUniPs), "LocalUni")
4852: 
4853:                             IF USED("LocalUni") AND !EOF("LocalUni") AND LocalUni.Distribs = 1
4854:                                 loc_lDistribui = .T.
4855:                             ENDIF
4856:                         ENDIF
4857: 
4858:                         IF loc_lDistribui
4859:                             m.Pesos     = dbImpressao.Pesos
4860:                             m.pvens     = dbImpressao.pvens
4861:                             m.PrecoDe   = LocalPro.PrecoDe
4862:                             m.Moedas    = dbImpressao.Moedas
4863:                             m.Reffs     = dbImpressao.Reffs
4864:                             m.Pedido    = dbImpressao.Pedido
4865:                             m.Obs       = dbImpressao.Obs
4866:                             m.Contas    = dbImpressao.Contas

*-- Linhas 4879 a 5065:
4879:                         ENDIF
4880: 
4881:                         IF USED(loc_cCursor)
4882:                             INSERT INTO (loc_cCursor) FROM MEMVAR
4883:                         ENDIF
4884:                     ENDIF
4885: 
4886:                     SELECT dbImpressao
4887:                 ENDSCAN
4888:             ENDIF
4889:         CATCH TO loc_oErro
4890:             THIS.this_cMensagemErro = loc_oErro.Message
4891:             MsgErro(loc_oErro.Message + CHR(13) + ;
4892:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasOperacao")
4893:         ENDTRY
4894:     ENDPROC
4895: 
4896:     *==========================================================================
4897:     * CarregarLinhasDiversas - Tipo='DIVERSAS' (dump 2777-2793): varias
4898:     * etiquetas passadas no cursor csRelatorio (contrato do form pai).
4899:     *==========================================================================
4900:     PROTECTED PROCEDURE CarregarLinhasDiversas()
4901:         LOCAL loc_cCursor, loc_nBarra, loc_nResultado, loc_oErro
4902: 
4903:         loc_cCursor = THIS.this_cCursorEtiquetas
4904: 
4905:         TRY
4906:             IF USED("csRelatorio")
4907:                 SELECT csRelatorio
4908:                 SCAN
4909:                     loc_nBarra = csRelatorio.CBars
4910: 
4911:                     IF USED("LocalEti")
4912:                         USE IN LocalEti
4913:                     ENDIF
4914:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
4915:                         "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBarra), "LocalEti")
4916: 
4917:                     IF loc_nResultado >= 1 AND USED("LocalEti") AND !EOF("LocalEti") AND USED(loc_cCursor)
4918:                         SELECT LocalEti
4919:                         SCATTER MEMVAR
4920:                         m.Flag = .T.
4921:                         INSERT INTO (loc_cCursor) FROM MEMVAR
4922:                     ENDIF
4923: 
4924:                     SELECT csRelatorio
4925:                 ENDSCAN
4926:             ENDIF
4927:         CATCH TO loc_oErro
4928:             THIS.this_cMensagemErro = loc_oErro.Message
4929:             MsgErro(loc_oErro.Message + CHR(13) + ;
4930:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasDiversas")
4931:         ENDTRY
4932:     ENDPROC
4933: 
4934:     *==========================================================================
4935:     * CarregarLinhasArquivadas - Tipo='ARQUIVADAS' (dump 2795-2846):
4936:     * chamado do SigPrRet (reimpressao individual) - todas as etiquetas
4937:     * dos produtos marcados com ImpEtiqs=1, uma por EmpOs+Grupos+Contas+
4938:     * CPros+CBars+pesos+qtds+datas, mantendo so as que o ULTIMO usuario a
4939:     * alterar o preco (SigCdPrc) foi o usuario logado (ou nenhum
4940:     * historico ainda).
4941:     *==========================================================================
4942:     PROTECTED PROCEDURE CarregarLinhasArquivadas()
4943:         LOCAL loc_cCursor, loc_cQuery, loc_nResultado, loc_oErro
4944: 
4945:         loc_cCursor = THIS.this_cCursorEtiquetas
4946: 
4947:         THIS.grd_4c_Dados.Column4.ReadOnly = .T.
4948: 
4949:         TRY
4950:             loc_cQuery = "SELECT c.EmpOs, c.Grupos, c.Contas, a.CPros, c.CBars, " + ;
4951:                 "c.pesos, c.qtds, c.datas, a.pvens, a.precode, a.cGrus, a.Categoria " + ;
4952:                 "FROM SigCdPro a, SigOpEtq c " + ;
4953:                 "WHERE a.ImpEtiqs = 1 AND a.CPros = c.CPros " + ;
4954:                 "AND NOT c.Grupos = '" + SPACE(10) + "' " + ;
4955:                 "AND NOT c.Contas = '" + SPACE(10) + "' " + ;
4956:                 "GROUP BY c.EmpOs, c.Grupos, c.Contas, a.CPros, c.CBars, c.pesos, c.qtds, c.datas"
4957: 
4958:             IF USED("TmpTmp1")
4959:                 USE IN TmpTmp1
4960:             ENDIF
4961:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "TmpTmp1")
4962: 
4963:             IF loc_nResultado < 1
4964:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpTmp1)")
4965:             ELSE
4966:                 SELECT TmpTmp1
4967:                 SCAN
4968:                     loc_cQuery = "SELECT TOP 1 UsuaAlts FROM SigCdPrc WHERE CPros = " + ;
4969:                         EscaparSQL(TmpTmp1.Cpros) + " ORDER BY DataAlts DESC, HoraAlts DESC"
4970: 
4971:                     IF USED("TmpUltimo")
4972:                         USE IN TmpUltimo
4973:                     ENDIF
4974:                     SQLEXEC(gnConnHandle, loc_cQuery, "TmpUltimo")
4975: 
4976:                     IF USED("TmpUltimo")
4977:                         GO TOP IN TmpUltimo
4978: 
4979:                         IF (EOF("TmpUltimo") OR gc_4c_UsuarioLogado == TmpUltimo.UsuaAlts) AND USED(loc_cCursor)
4980:                             SELECT TmpTmp1
4981:                             SCATTER MEMVAR
4982:                             m.Flag = .T.
4983:                             INSERT INTO (loc_cCursor) FROM MEMVAR
4984:                         ENDIF
4985:                     ENDIF
4986: 
4987:                     SELECT TmpTmp1
4988:                 ENDSCAN
4989:             ENDIF
4990: 
4991:             IF USED(loc_cCursor)
4992:                 SELECT (loc_cCursor)
4993:                 SET ORDER TO EmpGruCon
4994:             ENDIF
4995:         CATCH TO loc_oErro
4996:             THIS.this_cMensagemErro = loc_oErro.Message
4997:             MsgErro(loc_oErro.Message + CHR(13) + ;
4998:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasArquivadas")
4999:         ENDTRY
5000:     ENDPROC
5001: 
5002:     *==========================================================================
5003:     * CarregarLinhasCadastro - Tipo='CADASTRO' (dump 2848-2884): chamado
5004:     * do Cadastro de Produtos (SigCdPro) - todas as etiquetas de UM
5005:     * produto. ParentForm.Produto aqui eh STRING (CPros), diferente do
5006:     * ramo UNITARIO (mesmo nome de property, tipo NUMERICO la).
5007:     *==========================================================================
5008:     PROTECTED PROCEDURE CarregarLinhasCadastro()
5009:         LOCAL loc_cCursor, loc_cProduto, loc_cQuery, loc_nResultado, loc_oErro
5010: 
5011:         loc_cCursor  = THIS.this_cCursorEtiquetas
5012:         loc_cProduto = ""
5013: 
5014:         THIS.grd_4c_Dados.Column4.ReadOnly = .T.
5015: 
5016:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
5017:             IF PEMSTATUS(THIS.this_oFormAnterior, "Produto", 5)
5018:                 IF VARTYPE(THIS.this_oFormAnterior.Produto) = "C"
5019:                     loc_cProduto = THIS.this_oFormAnterior.Produto
5020:                 ENDIF
5021:             ENDIF
5022:         ENDIF
5023: 
5024:         TRY
5025:             loc_cQuery = "SELECT b.*, a.pvens, a.precode, a.cGrus, a.Categoria " + ;
5026:                 "FROM SigOpEtq b JOIN SigCdpro a ON a.cpros = b.cpros " + ;
5027:                 "WHERE b.Cpros = " + EscaparSQL(loc_cProduto) + " " + ;
5028:                 "AND NOT b.Grupos = '" + SPACE(10) + "' " + ;
5029:                 "AND NOT b.Contas = '" + SPACE(10) + "'"
5030: 
5031:             IF USED("TmpTmp2")
5032:                 USE IN TmpTmp2
5033:             ENDIF
5034:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "TmpTmp2")
5035: 
5036:             IF loc_nResultado < 1
5037:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpTmp2)")
5038:             ELSE
5039:                 IF USED(loc_cCursor)
5040:                     SELECT TmpTmp2
5041:                     SCAN
5042:                         SCATTER MEMVAR
5043:                         m.Flag = .T.
5044:                         INSERT INTO (loc_cCursor) FROM MEMVAR
5045:                     ENDSCAN
5046:                 ENDIF
5047:             ENDIF
5048: 
5049:             IF USED(loc_cCursor)
5050:                 SELECT (loc_cCursor)
5051:                 SET ORDER TO EmpGruCon
5052:             ENDIF
5053:         CATCH TO loc_oErro
5054:             THIS.this_cMensagemErro = loc_oErro.Message
5055:             MsgErro(loc_oErro.Message + CHR(13) + ;
5056:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasCadastro")
5057:         ENDTRY
5058:     ENDPROC
5059: 
5060:     *==========================================================================
5061:     * CarregarLinhasConsulta - Tipo='CONSULTA' (dump 2886-3080): chamado
5062:     * do SigPrRet (reimpressao de etiquetas). O mais complexo dos seis -
5063:     * depende de uma bateria de memvars PRIVATE/PUBLIC que o CHAMADOR
5064:     * seta antes do DO FORM (mesmo padrao de guarda TYPE()!='U' que o
5065:     * proprio Init legado ja usa para pcGdeGrupo/pcCol).

*-- Linhas 5089 a 5107:
5089:               loc_cIndustria, loc_nNumero, loc_nNumerof, loc_cCdProduto, ;
5090:               loc_cGrEstoque, loc_cEstoque, loc_cLocaliza, loc_cGrupo, ;
5091:               loc_cSgrus, loc_cColecoes, loc_cPromos, loc_nQtdEti, ;
5092:               loc_nOptMarca, loc_cLinha, loc_cDepto, loc_cQuery, ;
5093:               loc_nResultado, loc_nBrI, loc_nBrF, loc_cDtI, loc_cDtF, ;
5094:               loc_cOpIn, loc_cOpFim, loc_nQtd, loc_oErro
5095: 
5096:         loc_cCursor = THIS.this_cCursorEtiquetas
5097: 
5098:         THIS.grd_4c_Dados.Column4.ReadOnly = .T.
5099: 
5100:         *-- Memvars PRIVATE/PUBLIC do chamador (SigPrRet) - guarda TYPE()
5101:         *-- igual ao Init legado para pcGdeGrupo/pcCol (2598-2604).
5102:         loc_cGdeGrupo  = IIF(TYPE("pcGdeGrupo")  != "U", pcGdeGrupo,  SPACE(3))
5103:         loc_cCol       = IIF(TYPE("pcCol")       != "U", pcCol,       SPACE(3))
5104:         loc_cOperacao  = IIF(TYPE("pcOperacao")  != "U", pcOperacao,  "")
5105:         loc_nEtiqIni   = IIF(TYPE("pnEtiqIni")   != "U", pnEtiqIni,   0)
5106:         loc_nEtiqFim   = IIF(TYPE("pnEtiqFim")   != "U", pnEtiqFim,   0)
5107:         loc_dDtInicial = IIF(TYPE("pdDtInicial") != "U", pdDtInicial, {})

*-- Linhas 5127 a 5213:
5127:             IF EMPTY(loc_cOperacao)
5128:                 loc_nBrI = loc_nEtiqIni
5129:                 loc_nBrF = IIF(EMPTY(loc_nEtiqFim), 99999999999999, loc_nEtiqFim)
5130:                 loc_cDtI = IIF(EMPTY(loc_dDtInicial), "", FormatarDataSQL(loc_dDtInicial))
5131:                 loc_cDtF = IIF(EMPTY(loc_dDtFinal), "", FormatarDataSQL(DTOT(loc_dDtFinal) + 86399))
5132: 
5133:                 loc_cOpIn  = IIF(EMPTY(loc_cEmpresa), go_4c_Sistema.cCodEmpresa, loc_cEmpresa) + ;
5134:                              loc_cIndustria + STR(loc_nNumero, 6)
5135:                 loc_cOpFim = IIF(EMPTY(loc_cEmpresa), go_4c_Sistema.cCodEmpresa, loc_cEmpresa) + ;
5136:                              loc_cIndustria + STR(loc_nNumerof, 6)
5137: 
5138:                 IF EMPTY(loc_cCol) AND EMPTY(loc_cGrupo) AND EMPTY(loc_cColecoes) AND EMPTY(loc_cPromos)
5139:                     loc_cQuery = "SELECT b.*, a.pvens, a.precode, a.cGrus, a.Categoria " + ;
5140:                         "FROM SigOpEtq b JOIN SigCdpro a ON a.cpros = b.cpros WHERE " + ;
5141:                         IIF(EMPTY(loc_nBrI), "", "b.CBars BETWEEN " + TRANSFORM(loc_nBrI) + " AND " + TRANSFORM(loc_nBrF) + " AND ") + ;
5142:                         IIF(EMPTY(loc_dDtInicial), "", "b.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + " AND ") + ;
5143:                         IIF(EMPTY(loc_cEmpresa), "", "b.Empos = " + EscaparSQL(loc_cEmpresa) + " AND ") + ;
5144:                         IIF(EMPTY(loc_cCdProduto), "", "b.Cpros = " + EscaparSQL(loc_cCdProduto) + " AND ") + ;
5145:                         IIF(EMPTY(loc_cGrEstoque), "", "b.Grupos = " + EscaparSQL(loc_cGrEstoque) + " AND ") + ;
5146:                         IIF(EMPTY(loc_cEstoque), "", "b.Contas = " + EscaparSQL(loc_cEstoque) + " AND ") + ;
5147:                         IIF(EMPTY(loc_cLocaliza), "", "b.Localizas = " + EscaparSQL(loc_cLocaliza) + " AND ") + ;
5148:                         "NOT b.Grupos = '" + SPACE(10) + "' AND NOT b.Contas = '" + SPACE(10) + "' " + ;
5149:                         IIF(EMPTY(loc_cIndustria), "", "AND b.empdopnums BETWEEN " + EscaparSQL(loc_cOpIn) + " AND " + EscaparSQL(loc_cOpFim))
5150:                 ELSE
5151:                     loc_cQuery = "SELECT a.*, b.pvens, b.precode, b.cGrus, b.Categoria " + ;
5152:                         "FROM SigOpEtq a, SigCdPro b " + ;
5153:                         IIF(EMPTY(loc_cPromos), "", "INNER JOIN SigPrPmi p ON b.cpros = p.cpros ") + ;
5154:                         "WHERE a.CPros = b.CPros " + ;
5155:                         IIF(EMPTY(loc_nBrI), "", "AND a.CBars BETWEEN " + TRANSFORM(loc_nBrI) + " AND " + TRANSFORM(loc_nBrF) + " ") + ;
5156:                         IIF(EMPTY(loc_dDtInicial), "", "AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + " ") + ;
5157:                         IIF(EMPTY(loc_cCol), "", "AND b.Colecoes = " + EscaparSQL(loc_cCol) + " ") + ;
5158:                         IIF(EMPTY(loc_cGrupo), "", "AND b.Cgrus = " + EscaparSQL(loc_cGrupo) + " ") + ;
5159:                         IIF(EMPTY(loc_cSgrus), "", "AND b.Sgrus = " + EscaparSQL(loc_cSgrus) + " ") + ;
5160:                         IIF(EMPTY(loc_cColecoes), "", "AND b.Colecoes = " + EscaparSQL(loc_cColecoes) + " ") + ;
5161:                         IIF(EMPTY(loc_cEmpresa), "", "AND a.Empos = " + EscaparSQL(loc_cEmpresa) + " ") + ;
5162:                         IIF(EMPTY(loc_cCdProduto), "", "AND a.CPros = " + EscaparSQL(loc_cCdProduto) + " ") + ;
5163:                         IIF(EMPTY(loc_cGrEstoque), "", "AND a.Grupos = " + EscaparSQL(loc_cGrEstoque) + " ") + ;
5164:                         IIF(EMPTY(loc_cEstoque), "", "AND a.Contas = " + EscaparSQL(loc_cEstoque) + " ") + ;
5165:                         IIF(EMPTY(loc_cLocaliza), "", "AND a.Localizas = " + EscaparSQL(loc_cLocaliza) + " ") + ;
5166:                         IIF(EMPTY(loc_cPromos), "", "AND p.Promos = " + EscaparSQL(loc_cPromos) + " ") + ;
5167:                         "AND NOT a.Grupos = '" + SPACE(10) + "' AND NOT a.Contas = '" + SPACE(10) + "' " + ;
5168:                         IIF(EMPTY(loc_cIndustria), "", "AND a.empdopnums BETWEEN " + EscaparSQL(loc_cOpIn) + " AND " + EscaparSQL(loc_cOpFim))
5169:                 ENDIF
5170: 
5171:                 IF USED("TmpEti")
5172:                     USE IN TmpEti
5173:                 ENDIF
5174:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "TmpEti")
5175: 
5176:                 IF loc_nResultado < 1
5177:                     MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpEti - 1)")
5178:                 ELSE
5179:                     loc_nQtd = 0
5180: 
5181:                     SELECT TmpEti
5182:                     SCAN
5183:                         IF USED("LocalPro")
5184:                             USE IN LocalPro
5185:                         ENDIF
5186:                         SQLEXEC(gnConnHandle, "SELECT CGrus, Linhas, Locals, Colecoes, Reffs, Categoria " + ;
5187:                             "FROM SigCdPro WHERE CPros = " + EscaparSQL(TmpEti.Cpros), "LocalPro")
5188: 
5189:                         IF !USED("LocalPro") OR EOF("LocalPro")
5190:                             LOOP
5191:                         ENDIF
5192: 
5193:                         IF !EMPTY(loc_cGdeGrupo)
5194:                             IF USED("LocalGru")
5195:                                 USE IN LocalGru
5196:                             ENDIF
5197:                             SQLEXEC(gnConnHandle, "SELECT CGrus, Mercs FROM SigCdGrp WHERE CGrus = " + ;
5198:                                 EscaparSQL(LocalPro.CGrus), "LocalGru")
5199: 
5200:                             IF !USED("LocalGru") OR EOF("LocalGru") OR LocalGru.Mercs != loc_cGdeGrupo
5201:                                 LOOP
5202:                             ENDIF
5203:                         ENDIF
5204: 
5205:                         IF !EMPTY(loc_cGrupo) AND LocalPro.CGrus != loc_cGrupo
5206:                             LOOP
5207:                         ENDIF
5208: 
5209:                         IF !EMPTY(loc_cColecoes) AND LocalPro.Colecoes != loc_cColecoes
5210:                             LOOP
5211:                         ENDIF
5212: 
5213:                         IF !EMPTY(loc_cCol) AND LocalPro.Colecoes != loc_cCol

*-- Linhas 5228 a 5356:
5228: 
5229:                         loc_nQtd = loc_nQtd + 1
5230: 
5231:                         SELECT TmpEti
5232:                         SCATTER MEMVAR
5233:                         m.EmpDopNums = SPACE(29)
5234:                         m.Reffs      = LocalPro.Reffs
5235:                         m.cGrus      = LocalPro.cGrus
5236:                         m.Categoria  = LocalPro.Categoria
5237: 
5238:                         IF USED(loc_cCursor)
5239:                             INSERT INTO (loc_cCursor) FROM MEMVAR
5240:                             IF loc_nOptMarca = 1
5241:                                 REPLACE Flag WITH .T. IN (loc_cCursor)
5242:                             ENDIF
5243:                         ENDIF
5244: 
5245:                         SELECT TmpEti
5246:                     ENDSCAN
5247:                 ENDIF
5248:             ELSE
5249:                 loc_cOpIn  = IIF(EMPTY(loc_cEmpresa), go_4c_Sistema.cCodEmpresa, loc_cEmpresa) + ;
5250:                              loc_cOperacao + STR(loc_nNumero, 6)
5251:                 loc_cOpFim = IIF(EMPTY(loc_cEmpresa), go_4c_Sistema.cCodEmpresa, loc_cEmpresa) + ;
5252:                              loc_cOperacao + STR(loc_nNumerof, 6)
5253: 
5254:                 IF USED("LocalOpe")
5255:                     USE IN LocalOpe
5256:                 ENDIF
5257:                 SQLEXEC(gnConnHandle, "SELECT CtrlLotes, Abrevs, Globalizas FROM SigCdOpe WHERE Dopes = " + ;
5258:                     EscaparSQL(loc_cOperacao), "LocalOpe")
5259: 
5260:                 IF USED("LocalOpe") AND !EOF("LocalOpe") AND INLIST(LocalOpe.CtrlLotes, 1, 2) AND .F.
5261:                     *-- CODIGO MORTO no legado (AND .F. sempre anula) -
5262:                     *-- transcrito literal, nunca executa.
5263:                     IF USED("TprMvCab")
5264:                         USE IN TprMvCab
5265:                     ENDIF
5266:                     SQLEXEC(gnConnHandle, "SELECT Emps, Dopes, Numes, EmpDopNums FROM SigMvCab " + ;
5267:                         "WHERE EmpDopNums BETWEEN " + EscaparSQL(loc_cOpIn) + " AND " + EscaparSQL(loc_cOpFim), ;
5268:                         "TprMvCab")
5269: 
5270:                     IF USED("TprMvCab")
5271:                         SELECT TprMvCab
5272:                         SCAN
5273:                             IF USED(loc_cCursor)
5274:                                 INSERT INTO (loc_cCursor) (Cpros, Qtds, CBars, ObsEtiqs, Dopes, EmpDopNums) ;
5275:                                     VALUES (LocalParam.Ouros, 1, TprMvCab.Numes, ;
5276:                                         LocalOpe.Abrevs + "-" + TRANSFORM(TprMvCab.Numes, "@L 999999"), ;
5277:                                         TprMvCab.Dopes, TprMvCab.EmpDopNums)
5278: 
5279:                                 IF loc_nOptMarca = 1
5280:                                     REPLACE Flag WITH .T. IN (loc_cCursor)
5281:                                 ENDIF
5282:                             ENDIF
5283:                         ENDSCAN
5284:                     ENDIF
5285:                 ELSE
5286:                     IF USED("TprMvCabI")
5287:                         USE IN TprMvCabI
5288:                     ENDIF
5289:                     SQLEXEC(gnConnHandle, "SELECT b.CodBarras AS BarraB, a.CodBarras AS BarraA, " + ;
5290:                         "a.Units, a.Moedas, a.EmpdopNums, p.Reffs, a.Opers, p.PrecoDe, p.cGrus, p.Categoria " + ;
5291:                         "FROM SigMvItn a " + ;
5292:                         "LEFT JOIN SigMvIts b ON b.EmpDopNums = a.EmpDopNums AND b.CItens = a.CItens " + ;
5293:                         "LEFT JOIN SigCdPro p ON a.Cpros = p.cpros " + ;
5294:                         "WHERE a.EmpDopNums BETWEEN " + EscaparSQL(loc_cOpIn) + " AND " + EscaparSQL(loc_cOpFim), ;
5295:                         "TprMvCabI")
5296: 
5297:                     IF USED("TprMvCabI")
5298:                         IF USED("csItens")
5299:                             USE IN csItens
5300:                         ENDIF
5301:                         SELECT NVL(BarraB, BarraA) AS CodBarras, Units, Moedas, EmpDopNums, Reffs, Opers, ;
5302:                                 PrecoDe, cgrus, Categoria ;
5303:                             FROM TprMvCabI ;
5304:                             INTO CURSOR csItens
5305: 
5306:                         SELECT csItens
5307:                         SCAN
5308:                             IF !EMPTY(csItens.CodBarras) AND !ISNULL(csItens.CodBarras)
5309:                                 IF USED("LocalEti")
5310:                                     USE IN LocalEti
5311:                                 ENDIF
5312:                                 SQLEXEC(gnConnHandle, "SELECT * FROM SigOpEtq WHERE CBars = " + ;
5313:                                     TRANSFORM(csItens.CodBarras), "LocalEti")
5314: 
5315:                                 IF USED("LocalEti") AND !EOF("LocalEti")
5316:                                     SELECT LocalEti
5317:                                     SCATTER MEMVAR
5318:                                     m.pvens      = csItens.Units
5319:                                     m.Moedas     = csItens.Moedas
5320:                                     m.EmpDopNums = csItens.EmpDopNums
5321:                                     m.Reffs      = csItens.Reffs
5322:                                     m.cGrus      = csItens.cGrus
5323:                                     m.Categoria  = csItens.Categoria
5324: 
5325:                                     IF USED(loc_cCursor)
5326:                                         INSERT INTO (loc_cCursor) FROM MEMVAR
5327:                                         IF loc_nOptMarca = 1
5328:                                             REPLACE Flag WITH (csItens.Opers == "E") IN (loc_cCursor)
5329:                                         ENDIF
5330:                                     ENDIF
5331:                                 ENDIF
5332:                             ENDIF
5333: 
5334:                             SELECT csItens
5335:                         ENDSCAN
5336:                     ENDIF
5337:                 ENDIF
5338:             ENDIF
5339: 
5340:             IF USED(loc_cCursor)
5341:                 SELECT (loc_cCursor)
5342:                 DO CASE
5343:                 CASE THIS.this_nOrdemImp = 1
5344:                     SET ORDER TO Cpros
5345:                 CASE THIS.this_nOrdemImp = 2
5346:                     SET ORDER TO CBars
5347:                 CASE THIS.this_nOrdemImp = 3
5348:                     SET ORDER TO EmpDopNums
5349:                 CASE THIS.this_nOrdemImp = 4
5350:                     SET ORDER TO RefFor
5351:                 CASE THIS.this_nOrdemImp = 5
5352:                     SET ORDER TO CatGru
5353:                 ENDCASE
5354:             ENDIF
5355:         CATCH TO loc_oErro
5356:             THIS.this_cMensagemErro = loc_oErro.Message

*-- Linhas 5389 a 5463:
5389:             IF USED("crImpre")
5390:                 USE IN crImpre
5391:             ENDIF
5392:             CREATE CURSOR crImpre (impres C(50))
5393: 
5394:             IF loc_nPrinters <= 0
5395:                 THIS.this_cMensagemErro = "N" + CHR(227) + "o Foi Encontrada Nenhuma Impressora!!!"
5396:                 MsgAviso(THIS.this_cMensagemErro, "")
5397:             ELSE
5398:                 FOR loc_nI = 1 TO loc_nPrinters
5399:                     INSERT INTO crImpre (impres) VALUES (UPPER(loc_aPrinters[loc_nI, 1]))
5400:                 ENDFOR
5401: 
5402:                 loc_cSQL = "SELECT b.impres, b.ntpimpres FROM SigSyImp a, SigCdmp b " + ;
5403:                            "WHERE a.usuacess = " + EscaparSQL(gc_4c_UsuarioLogado) + " AND a.cimps = b.impres " + ;
5404:                            "UNION ALL " + ;
5405:                            "SELECT c.impres, c.ntpimpres FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
5406:                            "WHERE a.usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + " " + ;
5407:                            "AND a.grupos = b.gracess AND b.cimps = c.impres"
5408: 
5409:                 IF USED("cursor_4c_ImpressorasTemp")
5410:                     USE IN cursor_4c_ImpressorasTemp
5411:                 ENDIF
5412:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpressorasTemp")
5413: 
5414:                 IF USED("crSigCdmp")
5415:                     USE IN crSigCdmp
5416:                 ENDIF
5417: 
5418:                 IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ImpressorasTemp") > 0
5419:                     SELECT impres, ntpimpres FROM cursor_4c_ImpressorasTemp ;
5420:                         INTO CURSOR crSigCdmp READWRITE
5421:                 ELSE
5422:                     CREATE CURSOR crSigCdmp (impres C(50), ntpimpres N(4, 0))
5423:                 ENDIF
5424: 
5425:                 IF USED("cursor_4c_ImpressorasTemp")
5426:                     USE IN cursor_4c_ImpressorasTemp
5427:                 ENDIF
5428: 
5429:                 IF USED("crImp")
5430:                     USE IN crImp
5431:                 ENDIF
5432: 
5433:                 SELECT PADR(ALLTRIM(a.impres), 15) + " " + ALLTRIM(b.impres) AS IDupla, ;
5434:                        b.impres, a.impres AS impresS ;
5435:                     FROM crSigCdmp a, crImpre b ;
5436:                     WHERE ALLTRIM(UPPER(a.impres)) LIKE "%" + ALLTRIM(UPPER(b.impres)) + "%" OR ;
5437:                           ALLTRIM(UPPER(b.impres)) LIKE "%" + ALLTRIM(UPPER(a.impres)) + "%" ;
5438:                     GROUP BY b.impres, a.impres ;
5439:                     INTO CURSOR crImp READWRITE
5440: 
5441:                 IF RECCOUNT("crImp") > 1
5442:                     APPEND BLANK
5443:                 ENDIF
5444: 
5445:                 IF USED("crImpreV")
5446:                     USE IN crImpreV
5447:                 ENDIF
5448:                 SELECT * FROM crImp ORDER BY 1 INTO CURSOR crImpreV READWRITE
5449: 
5450:                 THIS.this_nTotalImpressoras = RECCOUNT("crImpreV")
5451: 
5452:                 IF USED("crImpreV")
5453:                     GO TOP IN crImpreV
5454:                     THIS.cbo_4c_Get_Printer.Value         = RECNO("crImpreV")
5455:                     THIS.cbo_4c_Get_Printer.RowSourceType = 2
5456:                     THIS.cbo_4c_Get_Printer.RowSource     = "crImpreV"
5457:                     THIS.cbo_4c_Get_Printer.Refresh()
5458:                 ENDIF
5459: 
5460:                 loc_lSucesso = .T.
5461:             ENDIF
5462:         CATCH TO loc_oErro
5463:             THIS.this_cMensagemErro = loc_oErro.Message

*-- Linhas 5532 a 5550:
5532: 
5533:         IF THIS.ObterTipoChamador() == "DIGITACAO"
5534:             IF USED(loc_cCursor)
5535:                 SELECT (loc_cCursor)
5536:                 SET ORDER TO
5537:                 APPEND BLANK
5538:             ENDIF
5539: 
5540:             THIS.grd_4c_Dados.Column4.ReadOnly = .F.
5541:             THIS.grd_4c_Dados.Column4.SetFocus()
5542:         ELSE
5543:             THIS.grd_4c_Dados.SetFocus()
5544:         ENDIF
5545:     ENDPROC
5546: 
5547: ENDDEFINE
5548: 
5549: *==============================================================================
5550: * TextBoxCodBarrasIpE_4c - subclasse de TextBox para a Column4 (codigo de


### BO (C:\4c\projeto\app\classes\SigOpIpEBO.prg):
*==============================================================================
* SigOpIpEBO.PRG
* Business Object para Impressao/Reimpressao de Etiquetas (SIGOPIPE)
*
* Tabela Principal: SigMvIts (itens de movimento com codigo de barras/cor/tamanho)
*                    char(3) emps, char(20) dopes, numeric(6,0) numes,
*                    char(14) cpros, char(4) codtams/codcors, numeric(14,0) codbarras
*                    PK: cidchaves char(20)
*
* Origem: form legado SIGOPIPE monta um cursor local de etiquetas selecionadas
* (DbEtiqueta, a partir de SigOpEtq) e, ao confirmar a opcao "Impressao Imediata"
* com geracao de operacao, grava um movimento em SigMvCab/SigMvItn/SigMvIts.
* Este BO cobre a persistencia em SigMvIts (o item de movimento com o codigo
* de barras/cor/tamanho da etiqueta impressa).
*==============================================================================

DEFINE CLASS SigOpIpEBO AS BusinessBase

    *-- Propriedades da entidade (SigMvIts)
    this_nCitens       = 0    && citens       numeric(4,0)  - Numero sequencial do item
    this_cEmps         = ""   && emps         char(3)       - Codigo da empresa
    this_cDopes        = ""   && dopes        char(20)      - Codigo da operacao
    this_nNumes        = 0    && numes        numeric(6,0)  - Numero do movimento
    this_cCpros        = ""   && cpros        char(14)      - Codigo do produto
    this_cCodembs      = ""   && codembs      char(3)       - Codigo da embalagem
    this_cCodtams      = ""   && codtams      char(4)       - Codigo do tamanho
    this_cCodcors      = ""   && codcors      char(4)       - Codigo da cor
    this_nQtds         = 0    && qtds         numeric(9,3)  - Quantidade
    this_nAqtds        = 0    && aqtds        numeric(9,3)  - Quantidade anterior
    this_nQtdembs      = 0    && qtdembs      numeric(5,1)  - Quantidade por embalagem
    this_nAqtdembs     = 0    && aqtdembs     numeric(5,1)  - Quantidade por embalagem anterior
    this_nQtbaixas     = 0    && qtbaixas     numeric(9,3)  - Quantidade baixada
    this_nPrembs       = 0    && prembs       numeric(9,3)  - Peso da embalagem
    this_cCodembents   = ""   && codembents   char(3)       - Codigo da embalagem de entrada
    this_nQtdents      = 0    && qtdents      numeric(9,3)  - Quantidade de entrada
    this_nCodbarras    = 0    && codbarras    numeric(14,0) - Codigo de barras da etiqueta
    this_nPesos        = 0    && pesos        numeric(9,3)  - Peso
    this_nQtbxprods    = 0    && qtbxprods    numeric(9,3)  - Quantidade baixada do produto
    this_nQtprods      = 0    && qtprods      numeric(9,3)  - Quantidade do produto
    this_dDatatrans    = {}   && datatrans    datetime NULL - Data da transferencia
    this_cLocals       = ""   && locals       char(10)      - Local
    this_nNtrans       = 0    && ntrans       numeric(6,0)  - Numero da transferencia
    this_nQtreservas   = 0    && qtreservas   numeric(9,3)  - Quantidade reservada
    this_cCidchaves    = ""   && cidchaves    char(20)      - Chave unica (PK)
    this_cEmpdopnums   = ""   && empdopnums   char(29)      - Chave composta emps+dopes+numes
    this_lChksubn      = .F.  && chksubn      bit           - Checksum/flag de substituicao
    this_nCompris      = 0    && compris      numeric(6,2)  - Comprimento
    this_dDtalts       = {}   && dtalts       datetime NULL - Data da ultima alteracao
    this_cChaveexterna = ""   && chaveexterna char(33)      - Chave externa de integracao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigMvIts"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigMvIts a partir do
    * registro corrente do cursor informado (cursor_4c_Dados ou outro
    * alias com a mesma estrutura, ex. retorno de CarregarPorCodigo)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF !EOF()
                    THIS.this_nCitens       = TratarNulo(citens,       0)
                    THIS.this_cEmps         = TratarNulo(emps,         "")
                    THIS.this_cDopes        = TratarNulo(dopes,        "")
                    THIS.this_nNumes        = TratarNulo(numes,        0)
                    THIS.this_cCpros        = TratarNulo(cpros,        "")
                    THIS.this_cCodembs      = TratarNulo(codembs,      "")
                    THIS.this_cCodtams      = TratarNulo(codtams,      "")
                    THIS.this_cCodcors      = TratarNulo(codcors,      "")
                    THIS.this_nQtds         = TratarNulo(qtds,         0)
                    THIS.this_nAqtds        = TratarNulo(aqtds,        0)
                    THIS.this_nQtdembs      = TratarNulo(qtdembs,      0)
                    THIS.this_nAqtdembs     = TratarNulo(aqtdembs,     0)
                    THIS.this_nQtbaixas     = TratarNulo(qtbaixas,     0)
                    THIS.this_nPrembs       = TratarNulo(prembs,       0)
                    THIS.this_cCodembents   = TratarNulo(codembents,   "")
                    THIS.this_nQtdents      = TratarNulo(qtdents,      0)
                    THIS.this_nCodbarras    = TratarNulo(codbarras,    0)
                    THIS.this_nPesos        = TratarNulo(pesos,        0)
                    THIS.this_nQtbxprods    = TratarNulo(qtbxprods,    0)
                    THIS.this_nQtprods      = TratarNulo(qtprods,      0)
                    THIS.this_dDatatrans    = ConverterParaData(TratarNulo(datatrans, {}))
                    THIS.this_cLocals       = TratarNulo(locals,       "")
                    THIS.this_nNtrans       = TratarNulo(ntrans,       0)
                    THIS.this_nQtreservas   = TratarNulo(qtreservas,   0)
                    THIS.this_cCidchaves    = TratarNulo(cidchaves,    "")
                    THIS.this_cEmpdopnums   = TratarNulo(empdopnums,   "")
                    THIS.this_lChksubn      = ConverterParaLogico(chksubn)
                    THIS.this_nCompris      = TratarNulo(compris,      0)
                    THIS.this_dDtalts       = ConverterParaData(TratarNulo(dtalts, {}))
                    THIS.this_cChaveexterna = TratarNulo(chaveexterna, "")

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * MontarChaveEmpDopNums - Chave POSICIONAL Emps+Dopes+Str(Numes,6)
    * (char(3) + char(20) + str(6) = char(29), igual a coluna EmpDopNums).
    * PADR explicito em cada parte - o padding FAZ PARTE da chave (NUNCA
    * ALLTRIM nas partes internas, so na chave inteira se preciso).
    *====================================================================
    FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(TratarNulo(par_cEmps, ""), 3) + ;
               PADR(TratarNulo(par_cDopes, ""), 20) + ;
               STR(TratarNulo(par_nNumes, 0), 6)
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria real da tabela (cidchaves)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *====================================================================
    * Inserir - INSERT INTO SigMvIts (PROTECTED, chamado por Salvar())
    * Gera cidchaves via fUniqueIds() quando ainda nao preenchida (chave
    * unica Fortyus, regra CLAUDE.md #22 - NUNCA deixar em branco, senao
    * o 2o registro colide no indice unico) e recalcula empdopnums a
    * partir de Emps+Dopes+Numes (regra CLAUDE.md #42).
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            THIS.this_cEmpdopnums = THIS.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)

            loc_cSQL = "INSERT INTO SigMvIts (citens, emps, dopes, numes, cpros, codembs, " + ;
                       "codtams, codcors, qtds, aqtds, qtdembs, aqtdembs, qtbaixas, prembs, " + ;
                       "codembents, qtdents, codbarras, pesos, qtbxprods, qtprods, datatrans, " + ;
                       "locals, ntrans, qtreservas, cidchaves, empdopnums, chksubn, compris, " + ;
                       "dtalts, chaveexterna) VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCitens, 0) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cEmps, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cDopes, 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCodembs, 3)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCodtams, 4)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCodcors, 4)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAqtds, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdembs, 1) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAqtdembs, 1) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtbaixas, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPrembs, 3) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCodembents, 3)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdents, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodbarras, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesos, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtbxprods, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtprods, 3) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNtrans, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtreservas, 3) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ", " + ;
                       FormatarNumeroSQL(IIF(THIS.this_lChksubn, 1, 0), 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCompris, 2) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtalts) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cChaveexterna, 33)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsIts")
            IF USED("cursor_4c_InsIts")
                USE IN cursor_4c_InsIts
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir item de movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE SigMvIts (PROTECTED, chamado por Salvar())
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                MsgErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada para altera" + CHR(231) + CHR(227) + "o", "Erro")
            ELSE
                THIS.this_cEmpdopnums = THIS.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)

                loc_cSQL = "UPDATE SigMvIts SET " + ;
                           "citens = "       + FormatarNumeroSQL(THIS.this_nCitens, 0) + ", " + ;
                           "emps = "         + EscaparSQL(PADR(THIS.this_cEmps, 3)) + ", " + ;
                           "dopes = "        + EscaparSQL(PADR(THIS.this_cDopes, 20)) + ", " + ;
                           "numes = "        + FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                           "cpros = "        + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ", " + ;
                           "codembs = "      + EscaparSQL(LEFT(THIS.this_cCodembs, 3)) + ", " + ;
                           "codtams = "      + EscaparSQL(LEFT(THIS.this_cCodtams, 4)) + ", " + ;
                           "codcors = "      + EscaparSQL(LEFT(THIS.this_cCodcors, 4)) + ", " + ;
                           "qtds = "         + FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                           "aqtds = "        + FormatarNumeroSQL(THIS.this_nAqtds, 3) + ", " + ;
                           "qtdembs = "      + FormatarNumeroSQL(THIS.this_nQtdembs, 1) + ", " + ;
                           "aqtdembs = "     + FormatarNumeroSQL(THIS.this_nAqtdembs, 1) + ", " + ;
                           "qtbaixas = "     + FormatarNumeroSQL(THIS.this_nQtbaixas, 3) + ", " + ;
                           "prembs = "       + FormatarNumeroSQL(THIS.this_nPrembs, 3) + ", " + ;
                           "codembents = "   + EscaparSQL(LEFT(THIS.this_cCodembents, 3)) + ", " + ;
                           "qtdents = "      + FormatarNumeroSQL(THIS.this_nQtdents, 3) + ", " + ;
                           "codbarras = "    + FormatarNumeroSQL(THIS.this_nCodbarras, 0) + ", " + ;
                           "pesos = "        + FormatarNumeroSQL(THIS.this_nPesos, 3) + ", " + ;
                           "qtbxprods = "    + FormatarNumeroSQL(THIS.this_nQtbxprods, 3) + ", " + ;
                           "qtprods = "      + FormatarNumeroSQL(THIS.this_nQtprods, 3) + ", " + ;
                           "datatrans = "    + FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                           "locals = "       + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ", " + ;
                           "ntrans = "       + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ", " + ;
                           "qtreservas = "   + FormatarNumeroSQL(THIS.this_nQtreservas, 3) + ", " + ;
                           "empdopnums = "   + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ", " + ;
                           "chksubn = "      + FormatarNumeroSQL(IIF(THIS.this_lChksubn, 1, 0), 0) + ", " + ;
                           "compris = "      + FormatarNumeroSQL(THIS.this_nCompris, 2) + ", " + ;
                           "dtalts = "       + FormatarDataSQL(THIS.this_dDtalts) + ", " + ;
                           "chaveexterna = " + EscaparSQL(LEFT(THIS.this_cChaveexterna, 33)) + ;
                           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AltIts")
                IF USED("cursor_4c_AltIts")
                    USE IN cursor_4c_AltIts
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao alterar item de movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Ajustes de impressora (Fase 7) - Opt_Impressora/Get_Printer.
    * InteractiveChange do legado chamam a funcao global fCarregarImps()
    * (SIGFUNCS.PRG), que NAO veio no acervo extraido para esta task (ver
    * comportamento.json, "funcoesExternas"). Mesma decisao arquitetural
    * do BO irmao sigopetsBO (Formsigopets, tambem um dialogo de
    * impressao de etiquetas): reproduzir o efeito observavel lendo
    * SigCdmp pelas colunas que ela de fato tem, em vez de inventar o
    * corpo da funcao ausente.
    *====================================================================
    this_nTipoImpressora   = 0   && impetis (1=Allegro, 2=Zebra ZPL, 3=Zebra EPL)
    this_nAjusteVertical   = 0   && ajverts
    this_nAjusteHorizontal = 0   && ajhorzs
    this_nAjusteDensidade  = 0   && ajdens  (piso 10)
    this_nAjusteVelocidade = 0   && ajvelos (piso 1)

    *====================================================================
    * CarregarAjustesImpressora - Recarrega tipo/ajustes de impressao
    * quando o usuario troca a impressora no combobox (Get_Printer).
    * Legado: Get_Printer.InteractiveChange ->
    *   fCarregarImps(ALLTRIM(crImpreV.impresS), loImp.Opcao_Imp,
    *                 loImp.Spn_AjVerts, loImp.Spn_AjHorzs,
    *                 loImp.Spn_AjDenss, loImp.Spn_AjVelos, poDataMgr)
    *
    * par_cNomeImpressora eh o nome CADASTRADO no sistema (SigCdmp.impres,
    * "crImpreV.impresS" no legado) - NAO o nome do Windows.
    *
    * Nome sem registro casando em SigCdmp eh caminho LEGITIMO (regra
    * CLAUDE.md #50 - universo vazio de lookup nao eh erro): devolve .T.
    * e this_n* ficam com o que ja estava.
    *====================================================================
    FUNCTION CarregarAjustesImpressora(par_cNomeImpressora)
        LOCAL loc_lSucesso, loc_nResultado, loc_nValor

        loc_lSucesso = .T.

        IF VARTYPE(par_cNomeImpressora) != "C" OR EMPTY(par_cNomeImpressora)
            RETURN .T.
        ENDIF

        TRY
            IF USED("cursor_4c_AjusteImpIpE")
                USE IN cursor_4c_AjusteImpIpE
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT impetis, ajdens, ajhorzs, ajvelos, ajverts FROM SigCdmp " + ;
                "WHERE impres = " + EscaparSQL(ALLTRIM(par_cNomeImpressora)), ;
                "cursor_4c_AjusteImpIpE")

            IF loc_nResultado >= 1 AND RECCOUNT("cursor_4c_AjusteImpIpE") > 0
                SELECT cursor_4c_AjusteImpIpE
                GO TOP

                *-- impetis = 0 "nao configurado" - NAO troca o tipo (mesma
                *-- regra do BO irmao sigopetsBO.CarregarDoCursor)
                loc_nValor = NVL(impetis, 0)
                IF loc_nValor <> 0
                    THIS.this_nTipoImpressora = loc_nValor
                ENDIF

                THIS.this_nAjusteVertical   = NVL(ajverts, 0)
                THIS.this_nAjusteHorizontal = NVL(ajhorzs, 0)

                loc_nValor = NVL(ajdens, 0)
                THIS.this_nAjusteDensidade  = IIF(loc_nValor < 10, 10, loc_nValor)

                loc_nValor = NVL(ajvelos, 0)
                THIS.this_nAjusteVelocidade = IIF(loc_nValor < 1, 1, loc_nValor)
            ENDIF

            IF USED("cursor_4c_AjusteImpIpE")
                USE IN cursor_4c_AjusteImpIpE
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

