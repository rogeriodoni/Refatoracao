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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpIpE.prg) - TRECHOS RELEVANTES PARA PASS SQL (5618 linhas total):

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

*-- Linhas 390 a 408:
390:     * O sufixo "Ipe" nao eh enfeite: este form tem DataSession = 1, ou seja o
391:     * alias vive na sessao de dados CORRENTE, compartilhada com o form
392:     * chamador e com o resto da aplicacao. "cursor_4c_Etiquetas" (sem o
393:     * sufixo) JA EXISTE no projeto - PrlBO.prg:273 faz SQLEXEC nesse alias -
394:     * e colidir ali derrubaria as duas telas sem erro atribuivel a nenhuma
395:     * delas. "cursor_4c_IpeEtiquetas" foi conferido: zero ocorrencias em
396:     * projeto\app\.
397:     *--------------------------------------------------------------------------
398:     this_cCursorEtiquetas = "cursor_4c_IpeEtiquetas"
399: 
400:     *==========================================================================
401:     * Init - recebe os dois parametros do legado (lfFormAnterior, llGravaPro)
402:     *
403:     * Legado (SIGOPIPE.Init), transcrito nas linhas que esta fase cobre:
404:     *
405:     *   Lparameters lfFormAnterior, llGravaPro
406:     *   Thisform.ParentForm = lfFormAnterior
407:     *   If Type('lfFormAnterior') = 'O'
408:     *       lfFormAnterior.Enabled = .F.

*-- Linhas 659 a 736:
659:     * Geometria e aparencia TRANSCRITAS do dump (SIGOPIPE.grd_historico):
660:     * Top 147 / Left 6 / Width 984 / Height 241 / ColumnCount 12 /
661:     * Arial 8 / HeaderHeight 17 / RowHeight 17 / ScrollBars 3 / Panel 1 /
662:     * DeleteMark .F. As que o dump NAO declara vem da classe fwgrade
663:     * (docs\FRAMEWORK_class_codigo_fonte.txt): AllowHeaderSizing .F.,
664:     * AllowRowSizing .F., GridLineColor 238,238,238,
665:     * HighlightBackColor 90,90,90.
666:     *
667:     * RecordMark = .F. eh o UNICO acrescimo: nem o dump nem a fwgrade o
668:     * declaram, e o default do VFP9 eh .T. - a regra do projeto para grade
669:     * criada por AddObject em form OPERACIONAL manda .F. nos dois marcadores,
670:     * senao aparece a barra de marcacao na lateral esquerda que o legado nao
671:     * tem (a fwgrade ja traz DeleteMark .F., so faltava o par).
672:     *
673:     * NUMERACAO DAS COLUNAS - A ARMADILHA DESTE FORM
674:     * -----------------------------------------------
675:     * O legado RENOMEIA quatro Column, e o dump mostra isso em dois lugares
676:     * que nao concordam: o bloco de propriedades da grade usa o prefixo da
677:     * POSICAO no SCX (ordem de criacao) e termina cada grupo com o
678:     * ".Name" REAL, enquanto os blocos "PROPRIEDADES DE: ...ColumnN.Header1/
679:     * .Text1" e o "With Thisform.grd_Historico" do Init usam o NOME.
680:     *
681:     *   posicao no SCX .....  6        7        8        9
682:     *   .Name declarado ....  Column7  Column8  Column9  Column6
683:     *
684:     * Renomear Column eh PROIBIDO (quebra toda referencia .ColumnN), e com
685:     * ColumnCount = 12 o VFP9 cria Column1..Column12 na ordem de criacao.
686:     * Logo, neste arquivo a Column<N> eh a POSICAO N do SCX, e o que vale
687:     * para ela sao: as propriedades do bloco da grade com prefixo <N>, mais o
688:     * Header1/Text1/ControlSource do bloco cujo NOME esta na tabela acima.
689:     * Ler os dois pela posicao (ou os dois pelo nome) embaralharia
690:     * cabecalho, largura, mascara e coluna de dados de quatro colunas - e a
691:     * tela abriria sem erro nenhum, so com os dados nas colunas erradas.
692:     *
693:     * A conferencia que fecha o mapeamento eh semantica: o par
694:     * cabecalho x ControlSource bate em todas as 12 (Data/Datas,
695:     * Produto/CPros, "Codigo / Barra"/CBars, Quantidade/Qtds,
696:     * Observacao/ObsEtiqs, "Ref. Fornecedor"/Reffs, Preco/pVens,
697:     * Parcelas/Parcelas, "Preco De Conjunto"/PrecoDeCJ,
698:     * "Preco Conjunto"/pVensCJ). Os ControlSource gravados NO SCX estao
699:     * OBSOLETOS (ele poe "dbetiqueta.pesos" na coluna "Preco De", e tres
700:     * colunas sem ControlSource nenhum): quem manda eh o
701:     * "With Thisform.grd_Historico" do Init legado (linhas 2654-2672), que
702:     * reatribui os 12 - por isso eh dele que a transcricao sai.
703:     *
704:     * Movable/Resizable = .F. em TODAS as 12: o dump declara o par so em
705:     * algumas (e chega a declarar Movable = .T. na posicao 10), mas o Init
706:     * legado fecha com "For I=1 To .ColumnCount / .Column&lcCol..Movable =
707:     * .F. / .Column&lcCol..Resizable = .F. / Next", que sobrepoe o SCX em
708:     * todas. O estado final eh .F. nas 12.
709:     *
710:     * SetAll para a base uniforme (Arial 8 nas Column, nos Header e nos
711:     * Text1; BorderStyle 0 / Margin 0 / preto sobre branco nos Text1;
712:     * Alignment 2 nos Header) porque esses valores sao IDENTICOS nos 12
713:     * blocos do dump - 12 blocos WITH repetindo as mesmas 6 linhas esconderia
714:     * justamente as diferencas, que ficam explicitas logo abaixo.
715:     *
716:     * Text1 e Header1 sao membros NATIVOS da Column: nao se cria e nao se
717:     * renomeia. O CheckBox da coluna de marcacao, nao - esse EXIGE AddObject
718:     * (regra CLAUDE.md #18), e sem o CurrentControl (em FormatarColunasGrade)
719:     * ele existe e NAO desenha.
720:     *
721:     * ControlSource, RecordSource, larguras e cabecalhos NAO entram aqui:
722:     * ligar coluna a cursor que ainda nao existe derruba o Init (regra
723:     * CLAUDE.md #41), e o bind reseta largura/cabecalho. Tudo isso mora em
724:     * MontaGradeEtiquetas.
725:     *==========================================================================
726:     PROTECTED PROCEDURE ConfigurarGrade()
727:         LOCAL loc_oGrid
728: 
729:         THIS.AddObject("grd_4c_Dados", "Grid")
730:         loc_oGrid = THIS.grd_4c_Dados
731: 
732:         *-- Legado: Thisform.grd_Historico.RecordSource = '' antes do cursor
733:         loc_oGrid.RecordSource = ""
734:         loc_oGrid.ColumnCount  = 12
735: 
736:         WITH loc_oGrid

*-- Linhas 744 a 762:
744:             .RowHeight          = 17
745:             .ScrollBars         = 3
746:             .Panel              = 1
747:             .DeleteMark         = .F.
748:             .RecordMark         = .F.
749:             .AllowHeaderSizing  = .F.
750:             .AllowRowSizing     = .F.
751:             .GridLineColor      = RGB(238, 238, 238)
752:             .HighlightBackColor = RGB(90, 90, 90)
753:             .Enabled            = .T.
754:             .Visible            = .T.
755:         ENDWITH
756: 
757:         *-- Base uniforme dos 12 blocos do dump
758:         WITH loc_oGrid
759:             .FontName = "Arial"
760:             .FontSize = 8
761:             .SetAll("Movable",   .F.,     "Column")
762:             .SetAll("Resizable", .F.,     "Column")

*-- Linhas 868 a 953:
868:     * Legado (Init, linhas 2641-2652):
869:     *
870:     *   Thisform.ParentForm.poDataMgr.CursorQuery('SigOpEtq','LocalEti','CBars',99999999999999)
871:     *   Select *, .F. As Flag, 000000000.00 As PrecoDe, 000000000.00 As pvens,
872:     *       00 As Parcelas, Space(3) As Moedas, Space(40) As Reffs,
873:     *       Space(30) As Pedido, Space(10) As Obs, .F. As Mantem,
874:     *       000000000.000 As QtdeEtiq, 000000000.00 As PrecoDeCJ,
875:     *       000000000.00 As pvensCJ, Space(6) as Categoria, Space(3) as CGrus
876:     *       From LocalEti Where 0=1 Into Cursor DbEtiqueta Readwrite
877:     *   <6 x Index On ... Tag ...>
878:     *
879:     * O "Where 0=1" eh o ponto: o legado usa LocalEti apenas como MOLDE de
880:     * estrutura e cria o cursor VAZIO. As linhas chegam depois, nos ramos por
881:     * ParentForm.Tipo (Fase 7). Aqui o CREATE CURSOR substitui o par
882:     * CursorQuery + Select-Where-0=1 sem nenhuma ida ao banco, o que tambem
883:     * torna a tela instanciavel sem conexao.
884:     *
885:     * As 47 primeiras colunas sao SigOpEtq na ordem do schema (= a ordem que
886:     * o "Select *" produz), conferidas em docs\schema.sql com
887:     * Get-Content -Raw (o arquivo eh UTF-16: grep/findstr devolvem ZERO
888:     * silenciosamente e fariam coluna existente parecer inexistente - regra
889:     * CLAUDE.md #14). As 14 ultimas sao os literais do Select acima, com a
890:     * largura LIDA do literal: "000000000.00" = 9 inteiros + 2 decimais =
891:     * N(12,2), "000000000.000" = N(13,3), "00" = N(2,0).
892:     *
893:     * NULL por coluna, nao por atacado: as 6 colunas que o schema declara
894:     * NULL (datas, datatrans, dtmovs, dtbals, dtincs, tbdwbi) vao NULL e
895:     * TODAS as outras vao NOT NULL - os 14 literais inclusive, porque .F.,
896:     * zero e Space() nao sao nulos. Isso importa em "Flag": nula, ela
897:     * chegaria ao CheckBox da grade como .NULL. e a celula de marcacao
898:     * mostraria vazio em vez de desmarcado. Com NULL/NOT NULL explicitos nas
899:     * 61 colunas o SET NULL ambiente deixa de influir; ele continua sendo
900:     * ligado/restaurado porque o cursor recebe INSERT/APPEND de cursores
901:     * vindos do SQL Server nas fases seguintes.
902:     *
903:     * UM UNICO ponto de criacao, de proposito: a regra de que todo
904:     * CREATE CURSOR do mesmo alias tenha a MESMA ordem de campos eh
905:     * satisfeita por construcao se existir um so. Todo caminho que precise do
906:     * cursor chama este metodo.
907:     *
908:     * Os 6 INDEX ON sao os do legado, com os MESMOS nomes de tag (o form le
909:     * por "Set Order To EmpGruCon" e afins) e sem ALLTRIM nas partes - chave
910:     * concatenada de char fixo eh POSICIONAL e o padding faz parte dela
911:     * (regra CLAUDE.md #42).
912:     *
913:     * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
914:     *==========================================================================
915:     PROTECTED PROCEDURE CriarCursorEtiquetas()
916:         LOCAL loc_lSucesso, loc_oErro, loc_cCursor, loc_cNullAnterior
917: 
918:         loc_lSucesso = .F.
919:         loc_cCursor  = THIS.this_cCursorEtiquetas
920: 
921:         *-- Lido ANTES do TRY de proposito: o CATCH precisa dele para repor o
922:         *-- SET. Lido dentro, uma falha no CREATE CURSOR deixaria SET NULL ON
923:         *-- vazando do form para o resto da aplicacao, e o proximo
924:         *-- CREATE CURSOR de QUALQUER tela nasceria com colunas nulaveis que
925:         *-- ela nao pediu - defeito sem erro e longe da causa.
926:         loc_cNullAnterior = SET("NULL")
927: 
928:         TRY
929:             IF USED(loc_cCursor)
930:                 IF CURSORGETPROP("Buffering", loc_cCursor) > 1
931:                     TABLEREVERT(.T., loc_cCursor)
932:                 ENDIF
933:                 USE IN (loc_cCursor)
934:             ENDIF
935: 
936:             SET NULL ON
937: 
938:             CREATE CURSOR (loc_cCursor) ( ;
939:                 cbars      N(14, 0) NOT NULL, ;
940:                 contas     C(10)    NOT NULL, ;
941:                 cpros      C(14)    NOT NULL, ;
942:                 datas      T        NULL,     ;
943:                 dopeos     C(20)    NOT NULL, ;
944:                 dopes      C(20)    NOT NULL, ;
945:                 empos      C(3)     NOT NULL, ;
946:                 emps       C(3)     NOT NULL, ;
947:                 grupos     C(10)    NOT NULL, ;
948:                 nops       N(10, 0) NOT NULL, ;
949:                 numeos     N(6, 0)  NOT NULL, ;
950:                 numes      N(6, 0)  NOT NULL, ;
951:                 pesos      N(9, 3)  NOT NULL, ;
952:                 qtds       N(9, 3)  NOT NULL, ;
953:                 transps    L        NOT NULL, ;

*-- Linhas 1002 a 1020:
1002:                 SET NULL OFF
1003:             ENDIF
1004: 
1005:             SELECT (loc_cCursor)
1006:             INDEX ON EmpDopNums + Cpros                            TAG EmpDopNums
1007:             INDEX ON EmpOs + Grupos + Contas + Cpros + CodTams     TAG EmpGruCon
1008:             INDEX ON Cpros + CodTams                               TAG Cpros
1009:             INDEX ON Reffs                                         TAG RefFor
1010:             INDEX ON CBars                                         TAG CBars
1011:             INDEX ON Categoria + CGrus                             TAG CatGru
1012: 
1013:             loc_lSucesso = .T.
1014:         CATCH TO loc_oErro
1015:             loc_lSucesso = .F.
1016: 
1017:             *-- repoe o SET tambem no caminho de falha
1018:             IF loc_cNullAnterior = "OFF"
1019:                 SET NULL OFF
1020:             ENDIF

*-- Linhas 1034 a 1065:
1034:     * destroi
1035:     *
1036:     * Reproduz o "With Thisform.grd_Historico" do Init legado (2654-2672) e o
1037:     * "Select DbEtiqueta / Goto Top / Refresh" da linha 3268.
1038:     *
1039:     * Os ControlSource vem do NOME da Column no legado, traduzido para a
1040:     * POSICAO deste arquivo (ver a tabela em ConfigurarGrade):
1041:     *
1042:     *   legado .Column1  -> Column1   Datas        legado .Column7  -> Column6   Qtds
1043:     *   legado .Column2  -> Column2   Flag         legado .Column8  -> Column7   ObsEtiqs
1044:     *   legado .Column3  -> Column3   CPros        legado .Column9  -> Column8   Reffs
1045:     *   legado .Column4  -> Column4   CBars        legado .Column6  -> Column9   pVens
1046:     *   legado .Column5  -> Column5   PrecoDe      legado .Column10 -> Column10  Parcelas
1047:     *                                              legado .Column11 -> Column11  PrecoDeCJ
1048:     *                                              legado .Column12 -> Column12  pVensCJ
1049:     *
1050:     * O cursor eh criado antes de qualquer ControlSource: ligar coluna a
1051:     * cursor inexistente estoura "Alias ... is not found" DENTRO do TRY do
1052:     * InicializarForm, que devolve .F., e ai CREATEOBJECT devolve .F., o
1053:     * "IF VARTYPE(loForm) = 'O'" do chamador nao entra e o usuario aciona a
1054:     * tela e NADA acontece, sem erro visivel (regra CLAUDE.md #41).
1055:     *
1056:     * GO TOP + Refresh no fim porque popular/religar cursor NAO repinta a
1057:     * grade sozinho - o legado fecha exatamente assim, e sem isso a grade
1058:     * fica visualmente vazia com o cursor correto, o que manda o diagnostico
1059:     * para SQL/permissao (regra CLAUDE.md #21).
1060:     *
1061:     * PUBLIC de proposito: eh o funil de (re)carga da grade, chamado pelos
1062:     * ramos por Tipo da Fase 7 e alvo potencial de BINDEVENT - PROTECTED
1063:     * falharia calado no bind e estouraria "Property ... is not found" na
1064:     * chamada de fora (regras CLAUDE.md #3/#51).
1065:     *

*-- Linhas 1083 a 1137:
1083:                 loc_oGrid.RecordSource = ""
1084:                 loc_oGrid.RecordSource = loc_cCursor
1085: 
1086:                 loc_oGrid.Column1.ControlSource  = loc_cCursor + ".Datas"
1087:                 loc_oGrid.Column2.ControlSource  = loc_cCursor + ".Flag"
1088:                 loc_oGrid.Column3.ControlSource  = loc_cCursor + ".CPros"
1089:                 loc_oGrid.Column4.ControlSource  = loc_cCursor + ".CBars"
1090:                 loc_oGrid.Column5.ControlSource  = loc_cCursor + ".PrecoDe"
1091:                 loc_oGrid.Column6.ControlSource  = loc_cCursor + ".Qtds"
1092:                 loc_oGrid.Column7.ControlSource  = loc_cCursor + ".ObsEtiqs"
1093:                 loc_oGrid.Column8.ControlSource  = loc_cCursor + ".Reffs"
1094:                 loc_oGrid.Column9.ControlSource  = loc_cCursor + ".pVens"
1095:                 loc_oGrid.Column10.ControlSource = loc_cCursor + ".Parcelas"
1096:                 loc_oGrid.Column11.ControlSource = loc_cCursor + ".PrecoDeCJ"
1097:                 loc_oGrid.Column12.ControlSource = loc_cCursor + ".pVensCJ"
1098: 
1099:                 THIS.FormatarColunasGrade()
1100: 
1101:                 *-- Legado: Select DbEtiqueta / Goto Top / Refresh
1102:                 SELECT (loc_cCursor)
1103:                 GO TOP
1104:                 loc_oGrid.Refresh()
1105: 
1106:                 loc_lSucesso = .T.
1107:             ENDIF
1108:         CATCH TO loc_oErro
1109:             loc_lSucesso = .F.
1110:             THIS.this_cMensagemErro = loc_oErro.Message
1111:             MsgErro(loc_oErro.Message + CHR(13) + ;
1112:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1113:                 "Procedure: " + loc_oErro.Procedure, ;
1114:                 "Erro em MontaGradeEtiquetas")
1115:         ENDTRY
1116: 
1117:         RETURN loc_lSucesso
1118:     ENDPROC
1119: 
1120:     *==========================================================================
1121:     * FormatarColunasGrade - tudo o que a atribuicao de RecordSource/
1122:     * ControlSource RESETA, reaplicado por inteiro
1123:     *
1124:     * Atribuir RecordSource devolve Column.Width ao default 90 e
1125:     * Header1.Caption a "ColumnN", e zera Column.CurrentControl /
1126:     * Column.Sparse / Column.ReadOnly (regras CLAUDE.md #41/#46). Por isso
1127:     * este bloco vive num metodo proprio e roda DEPOIS de cada bind - todo
1128:     * caminho que mexer em RecordSource tem de chamar este metodo no fim.
1129:     *
1130:     * Larguras e cabecalhos TRANSCRITOS do dump, cada um pela chave certa (a
1131:     * largura pela POSICAO, o cabecalho pelo NOME - ver ConfigurarGrade).
1132:     *
1133:     * CurrentControl eh o que faz o CheckBox APARECER: sem ele a Column2
1134:     * continua desenhando o Text1 dela e o usuario ve ".T."/".F." como texto,
1135:     * sem nada para clicar. E Sparse = .F. (que o dump declara) eh o que o
1136:     * faz aparecer em TODAS as linhas, nao so na linha ativa - numa tela cuja
1137:     * funcao eh escolher quais etiquetas imprimir, isso eh a diferenca entre

*-- Linhas 1214 a 1241:
1214:         loc_oGrid.Column12.Header1.Caption  = "Pre" + CHR(231) + "o Conjunto"
1215: 
1216:         *-- Sem CurrentControl o CheckBox existe e NAO desenha (regra #18).
1217:         *-- Column.ControlSource (atribuido acima, linha do Column2) so se
1218:         *-- aplica ao controle que FOR CurrentControl NO MOMENTO da
1219:         *-- atribuicao - na abertura, esse controle ainda era o Text1
1220:         *-- nativo (CurrentControl so muda aqui). Sem reatribuir
1221:         *-- ControlSource DEPOIS de trocar para chk_4c_Check1, o CheckBox
1222:         *-- nunca se liga a Flag e fica sempre desmarcado, mesmo com o
1223:         *-- REPLACE que os handlers de toggle da Fase 7 fazem no cursor.
1224:         IF PEMSTATUS(loc_oGrid.Column2, "chk_4c_Check1", 5)
1225:             loc_oGrid.Column2.CurrentControl = "chk_4c_Check1"
1226:             loc_oGrid.Column2.chk_4c_Check1.ControlSource = THIS.this_cCursorEtiquetas + ".Flag"
1227:         ENDIF
1228: 
1229:         *-- Dump: Column2.Sparse = .F. - CheckBox em TODAS as linhas
1230:         loc_oGrid.Column2.Sparse = .F.
1231: 
1232:         *-- Grid.ReadOnly ANTES do das colunas, porque PROPAGA (regra #46)
1233:         loc_oGrid.ReadOnly          = .F.
1234:         loc_oGrid.Column1.ReadOnly  = .T.
1235:         loc_oGrid.Column2.ReadOnly  = .F.
1236:         loc_oGrid.Column3.ReadOnly  = .T.
1237:         loc_oGrid.Column4.ReadOnly  = .T.
1238:         loc_oGrid.Column5.ReadOnly  = .T.
1239:         loc_oGrid.Column6.ReadOnly  = .F.
1240:         loc_oGrid.Column7.ReadOnly  = .T.
1241:         loc_oGrid.Column8.ReadOnly  = .T.

*-- Linhas 1518 a 1536:
1518:     * GetTexto (classe fwmemo no layout.json, migrado para EditBox puro) eh
1519:     * o campo de texto livre que entra na etiqueta. AddLineFeeds = .F. vem
1520:     * do dump (o legado NAO quebra linha automaticamente ao digitar).
1521:     * Nenhum ControlSource: o legado liga o conteudo no momento de montar a
1522:     * etiqueta (Fase 7/8), nao por bind direto a cursor.
1523:     *
1524:     * getQtParcs eh a quantidade de parcelas - so faz sentido quando
1525:     * opt_Preco seleciona "Parcelamento" (Buttons(6)), condicao que mora no
1526:     * When do campo (Fase 6: "Return(ThisForm.opt_Preco.Value = 6)"), nao
1527:     * aqui. Format = "K" + InputMask = "99" TRANSCRITOS do dump (regra
1528:     * CLAUDE.md #49): "K" seleciona o conteudo ao focar, o InputMask
1529:     * restringe a 2 digitos numericos. Alignment = 3 (direita) e Value = 0
1530:     * (NUMERICO - o destino eh a coluna Parcelas N(2,0) do cursor da grade)
1531:     * tambem vem do dump, assim como ForeColor = RGB(90,90,90) e os dois
1532:     * DisabledXxxColor.
1533:     *
1534:     * TabIndex de FORM (Label7/GetTexto/Label8/getQtParcs declaram 6/7/6/4
1535:     * no dump, com o 4 duplicado com getOcoEtiqs - controle que so existe a
1536:     * partir da Fase 6) fica para a Fase 6, mesma regra ja registrada no

*-- Linhas 2395 a 2413:
2395:     * para a Fase 7 (precisa de LocalParam e de ParentForm.pcEscolha - ver
2396:     * cabecalho do arquivo).
2397:     *
2398:     * getOcoEtiqs/getDOcoEtiqs nao tem ControlSource no dump (o valor eh
2399:     * atribuido por codigo no Click de Imprimir/Armazenar - Fase 7/8), por
2400:     * isso .Value = "" em vez de bind a cursor. O mesmo vale para
2401:     * GetJustifs.
2402:     *
2403:     * ShpOcoEtiqs/ShpJustifs seguem o mesmo estilo dos Shape1/2/3
2404:     * (BackStyle 0, BorderWidth 2, BorderColor 90,90,90) - unica diferenca
2405:     * eh a geometria, TRANSCRITA do dump.
2406:     *==========================================================================
2407:     PROTECTED PROCEDURE ConfigurarOcorrenciaEJustificativa()
2408:         THIS.this_lGravaOcorrencia = .F.
2409: 
2410:         THIS.AddObject("shp_4c_ShpOcoEtiqs", "Shape")
2411:         WITH THIS.shp_4c_ShpOcoEtiqs
2412:             .Top           = 464
2413:             .Left          = 593

*-- Linhas 2743 a 2761:
2743:     * O guard de Buffering antes do TABLEREVERT nao eh defensividade solta:
2744:     * TABLEREVERT sem buffering nao eh no-op, dispara erro 1586 ("Function
2745:     * requires row or table buffering mode"), e cursor criado por
2746:     * CREATE CURSOR nasce com Buffering = 1 - ou seja, o caminho normal eh
2747:     * justamente o que estouraria. USE IN fecha o alias mesmo com buffer
2748:     * sujo (regra CLAUDE.md #52).
2749:     *
2750:     * DODEFAULT() eh a ULTIMA linha, obrigatoriamente: FormBase.Destroy faz
2751:     * o SET SYSMENU TO DEFAULT + RELEASE POPUP + CriarMenuPrincipal() que
2752:     * repoe os pads do menu principal - sem ele o menu do sistema aparece
2753:     * encolhido.
2754:     *==========================================================================
2755:     PROCEDURE Destroy()
2756:         IF USED(THIS.this_cCursorEtiquetas)
2757:             IF CURSORGETPROP("Buffering", THIS.this_cCursorEtiquetas) > 1
2758:                 TABLEREVERT(.T., THIS.this_cCursorEtiquetas)
2759:             ENDIF
2760:             USE IN (THIS.this_cCursorEtiquetas)
2761:         ENDIF

*-- Linhas 2926 a 2982:
2926:                 IF USED("csEmpresas")
2927:                     USE IN csEmpresas
2928:                 ENDIF
2929:                 CREATE CURSOR csEmpresas (ImpEmps L(1), CEmps C(3), Razas C(40))
2930:                 INDEX ON CEmps TAG CEmps
2931: 
2932:                 IF USED("LocalEmp")
2933:                     USE IN LocalEmp
2934:                 ENDIF
2935:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2936:                     "SELECT Cemps, Razas FROM SigCdEmp WHERE Ativas = 1 ORDER BY Cemps", "LocalEmp")
2937: 
2938:                 IF loc_nResultado < 1
2939:                     MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalEmp)")
2940:                 ELSE
2941:                     SELECT LocalEmp
2942:                     SCAN
2943:                         IF !SEEK(LocalEmp.Cemps, "csEmpresas", "CEmps")
2944:                             INSERT INTO csEmpresas (ImpEmps, CEmps, Razas) ;
2945:                                 VALUES (.T., LocalEmp.Cemps, LocalEmp.Razas)
2946:                         ENDIF
2947:                     ENDSCAN
2948: 
2949:                     IF USED("csEmps")
2950:                         USE IN csEmps
2951:                     ENDIF
2952:                     SELECT CEmps FROM csEmpresas WHERE ImpEmps INTO CURSOR csEmps
2953:                     SELECT csEmps
2954: 
2955:                     loc_oProgresso = CREATEOBJECT("fwprogressbar", "Imprimindo Boletos...", RECCOUNT())
2956:                     loc_oProgresso.Show()
2957: 
2958:                     SCAN
2959:                         loc_cEmpAtual = csEmps.Cemps
2960:                         loc_oProgresso.SubTitulo.Caption = "Boleto da Empresa : " + loc_cEmpAtual
2961:                         loc_oProgresso.Update(.T.)
2962: 
2963:                         IF USED(THIS.this_cCursorEtiquetas)
2964:                             IF USED("TmpEtiquetas")
2965:                                 USE IN TmpEtiquetas
2966:                             ENDIF
2967:                             SELECT CBars FROM (THIS.this_cCursorEtiquetas) ;
2968:                                 WHERE Empos = loc_cEmpAtual ORDER BY CBars INTO CURSOR TmpEtiquetas
2969: 
2970:                             IF USED("TmpEtiquetas") AND RECCOUNT("TmpEtiquetas") > 0
2971:                                 loc_cNomeImp = THIS.ObterNomeImpressoraAtual()
2972: 
2973:                                 TRY
2974:                                     DO SigBlBol.Prg WITH 10, , loc_cEmpAtual, "", "", 0, 64, 1, loc_cNomeImp
2975:                                 CATCH TO loc_oErro
2976:                                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel emitir o boleto da " + ;
2977:                                         "empresa " + loc_cEmpAtual + ":" + CHR(13) + loc_oErro.Message, "Erro")
2978:                                 ENDTRY
2979:                             ENDIF
2980:                         ENDIF
2981:                     ENDSCAN
2982: 

*-- Linhas 3003 a 3027:
3003:             loc_cCursor = THIS.this_cCursorEtiquetas
3004: 
3005:             IF THIS.this_lImpArquivadas AND USED(loc_cCursor)
3006:                 SELECT (loc_cCursor)
3007:                 SCAN
3008:                     loc_cSQL = "UPDATE SigCdPro SET ImpEtiqs = 0 WHERE CPros = " + ;
3009:                         EscaparSQL(ALLTRIM(EVALUATE(loc_cCursor + ".CPros")))
3010: 
3011:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
3012:                         MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - SigCdPro)")
3013:                     ENDIF
3014:                 ENDSCAN
3015:             ENDIF
3016:         CATCH TO loc_oErro
3017:             MsgErro(loc_oErro.Message, "Erro em BtnSairClick")
3018:         ENDTRY
3019: 
3020:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
3021:             IF PEMSTATUS(THIS.this_oFormAnterior, "Enabled", 5)
3022:                 THIS.this_oFormAnterior.Enabled = .T.
3023:             ENDIF
3024:         ENDIF
3025: 
3026:         THIS.Release()
3027:     ENDPROC

*-- Linhas 3060 a 3082:
3060:             loc_cNomeImp = THIS.ObterNomeImpressoraAtual()
3061:             loc_cCursor  = THIS.this_cCursorEtiquetas
3062: 
3063:             SELECT dbImpressao
3064:             ZAP
3065: 
3066:             IF USED(loc_cCursor) AND !EOF(loc_cCursor)
3067:                 INSERT INTO dbImpressao (Cpros, Qtds, Cbars, Obs) ;
3068:                     VALUES (EVALUATE(loc_cCursor + ".CPros"), 1, 99999999999999, "")
3069:             ENDIF
3070: 
3071:             TRY
3072:                 SigOpEtq(gnConnHandle, .F., .F., 99, 2, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, , , , ;
3073:                     loc_cNomeImp, .F., .F., loc_nAjVelos, .F., .F., .F., .F., .F., loc_lResete)
3074:             CATCH TO loc_oErro
3075:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel testar a posi" + CHR(231) + CHR(227) + ;
3076:                     "o:" + CHR(13) + loc_oErro.Message, "Erro")
3077:             ENDTRY
3078:         CATCH TO loc_oErro
3079:             MsgErro(loc_oErro.Message + CHR(13) + ;
3080:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em BtnPosicaoClick")
3081:         ENDTRY
3082:     ENDPROC

*-- Linhas 3090 a 3114:
3090:     * Used(...)" so cria na PRIMEIRA chamada da sessao, entao qualquer uma
3091:     * das duas "ganha" dependendo da ordem de cliques, inconsistencia do
3092:     * PROPRIO legado. Aqui ha UM UNICO ponto de criacao (regra CLAUDE.md -
3093:     * mesma ordem de campos em todo CREATE CURSOR do mesmo alias), com a
3094:     * UNIAO das duas larguras (a maior de cada campo) para nao truncar
3095:     * nenhum dos dois usos.
3096:     *==========================================================================
3097:     PROTECTED PROCEDURE GarantirCursorImpressao()
3098:         IF !USED("dbImpressao")
3099:             CREATE CURSOR dbImpressao ( ;
3100:                 CPros      C(14), ;
3101:                 Qtds       N(10, 3), ;
3102:                 QtdeEtiq   N(10, 3), ;
3103:                 Pedido     C(30), ;
3104:                 Obs        C(10), ;
3105:                 Cbars      N(16, 0), ;
3106:                 Pvens      N(12, 2), ;
3107:                 PrecoDe    N(12, 2), ;
3108:                 Parcelas   N(2, 0), ;
3109:                 Moedas     C(3), ;
3110:                 EmpDopNums C(29), ;
3111:                 Reffs      C(40), ;
3112:                 Empos      C(3), ;
3113:                 Cpros1     C(14), ;
3114:                 CodTams    C(4))

*-- Linhas 3175 a 3193:
3175:                 loc_cCursor = THIS.this_cCursorEtiquetas
3176: 
3177:                 IF USED(loc_cCursor) AND !EOF(loc_cCursor)
3178:                     SELECT (loc_cCursor)
3179:                     REPLACE Flag WITH !Flag
3180:                     THIS.grd_4c_Dados.Refresh()
3181:                 ENDIF
3182:             CATCH TO loc_oErro
3183:                 MsgErro(loc_oErro.Message, "Erro em GradeCheckMarcarKeyPress")
3184:             ENDTRY
3185: 
3186:             NODEFAULT
3187:         ENDIF
3188:     ENDPROC
3189: 
3190:     *==========================================================================
3191:     * GradeRedirecionarParaColunaBarras - GotFocus de Column1/3/5/7/8.Text1
3192:     * (dump: cada uma identica, "If ParentForm.Tipo='DIGITACAO' / Column4.
3193:     * SetFocus"). Em modo DIGITACAO a unica coluna editavel eh a de codigo

*-- Linhas 3231 a 3320:
3231:                     IF USED("CrEtiqs")
3232:                         USE IN CrEtiqs
3233:                     ENDIF
3234:                     loc_cSQL = "SELECT a.CPros, a.CBars FROM SigOpEtq a " + ;
3235:                         "LEFT JOIN sigopeta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
3236:                         "WHERE (a.CBars = " + loc_cBars + " OR b.cbars_old = " + loc_cBars + ")"
3237:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "CrEtiqs")
3238: 
3239:                     IF loc_nResultado < 1
3240:                         MsgErro("Favor reinicializar o processo !!!", "Falha na Conex" + CHR(227) + "o (CrEtiqs)")
3241:                         loc_lResultado  = .F.
3242:                         loc_lProsseguir = .F.
3243:                     ENDIF
3244: 
3245:                     IF loc_lProsseguir
3246:                         SELECT CrEtiqs
3247:                         GO TOP
3248: 
3249:                         IF EOF("CrEtiqs")
3250:                             MsgAviso("A Etiqueta Digitada N" + CHR(227) + "o Foi Encontrada!!!", "")
3251:                             loc_lResultado  = .F.
3252:                             loc_lProsseguir = .F.
3253:                         ENDIF
3254:                     ENDIF
3255: 
3256:                     IF loc_lProsseguir
3257:                         par_oTxt.Value = CrEtiqs.CBars
3258:                         loc_nEti       = par_oTxt.Value
3259: 
3260:                         IF USED("LocalEti")
3261:                             USE IN LocalEti
3262:                         ENDIF
3263:                         loc_cSQL = "SELECT a.*, b.pvens, CASE WHEN b.precode = 0 THEN b.pvens ELSE b.precode END " + ;
3264:                             "AS precode FROM SigOpEtq a, SigCdPro b WHERE a.CPros = b.CPros AND a.Cbars = " + ;
3265:                             ALLTRIM(STR(loc_nEti, 14))
3266:                         SQLEXEC(gnConnHandle, loc_cSQL, "LocalEti")
3267: 
3268:                         IF !USED("LocalEti") OR EOF("LocalEti")
3269:                             MsgAviso("A Etiqueta Digitada N" + CHR(227) + "o Foi Encontrada!!!", "")
3270:                             loc_lResultado  = .F.
3271:                             loc_lProsseguir = .F.
3272:                         ENDIF
3273:                     ENDIF
3274: 
3275:                     IF loc_lProsseguir
3276:                         IF EMPTY(LocalEti.Grupos) AND EMPTY(LocalEti.Contas)
3277:                             MsgAviso("A Etiqueta Digitada J" + CHR(225) + " Foi Vendida!!!", "")
3278:                             loc_lResultado  = .F.
3279:                             loc_lProsseguir = .F.
3280:                         ENDIF
3281:                     ENDIF
3282: 
3283:                     IF loc_lProsseguir
3284:                         loc_nRecOriginal = RECNO(loc_cCursor)
3285: 
3286:                         IF USED("crTmp")
3287:                             USE IN crTmp
3288:                         ENDIF
3289:                         SELECT CBars FROM (loc_cCursor) ;
3290:                             WHERE CBars = loc_nEti AND !EMPTY(CPros) AND RECNO() != loc_nRecOriginal ;
3291:                             INTO CURSOR crTmp
3292: 
3293:                         IF RECCOUNT("crTmp") > 0
3294:                             MsgAviso("Etiqueta J" + CHR(225) + " Digitada Na Sele" + CHR(231) + CHR(227) + "o Atual!!!", "")
3295:                             par_oTxt.Value  = 0
3296:                             loc_lResultado  = .F.
3297:                             loc_lProsseguir = .F.
3298:                         ENDIF
3299:                     ENDIF
3300: 
3301:                     IF loc_lProsseguir
3302:                         SELECT LocalEti
3303:                         SCATTER MEMVAR
3304: 
3305:                         SELECT (loc_cCursor)
3306:                         GATHER MEMVAR
3307:                         REPLACE Flag WITH .T.
3308: 
3309:                         APPEND BLANK
3310:                         GO BOTTOM
3311: 
3312:                         THIS.grd_4c_Dados.Refresh()
3313:                     ENDIF
3314:                 CATCH TO loc_oErro
3315:                     MsgErro(loc_oErro.Message + CHR(13) + ;
3316:                         "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ValidarCodigoBarrasGrade")
3317:                     loc_lResultado = .F.
3318:                 ENDTRY
3319:             ENDIF
3320:         ENDIF

*-- Linhas 3495 a 3521:
3495:                 ENDIF
3496: 
3497:                 IF !EMPTY(loc_cCodigo)
3498:                     loc_cSQL = "SELECT TOP 1 Cods, Descrs FROM SigEtOco WHERE Cods = " + EscaparSQL(loc_cCodigo)
3499:                 ELSE
3500:                     loc_cSQL = "SELECT TOP 1 Cods, Descrs FROM SigEtOco WHERE Descrs = " + EscaparSQL(loc_cDescricao)
3501:                 ENDIF
3502: 
3503:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OcoEtiq")
3504: 
3505:                 IF loc_nResultado >= 1 AND USED("cursor_4c_OcoEtiq") AND RECCOUNT("cursor_4c_OcoEtiq") > 0
3506:                     SELECT cursor_4c_OcoEtiq
3507:                     GO TOP
3508:                     THIS.txt_4c_OcoEtiqs.Value  = ALLTRIM(Cods)
3509:                     THIS.txt_4c_DOcoEtiqs.Value = ALLTRIM(Descrs)
3510:                     loc_lAchou = .T.
3511:                 ENDIF
3512: 
3513:                 IF USED("cursor_4c_OcoEtiq")
3514:                     USE IN cursor_4c_OcoEtiq
3515:                 ENDIF
3516: 
3517:                 *-- Nao achou exato: abre o picker (regra CLAUDE.md #50 -
3518:                 *-- sem aviso, o picker JA eh o feedback; o codigo digitado
3519:                 *-- vira prefixo).
3520:                 IF !loc_lAchou
3521:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigEtOco", ;

*-- Linhas 3530 a 3548:
3530:                         ENDIF
3531: 
3532:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_OcoEtiqBusca")
3533:                             SELECT cursor_4c_OcoEtiqBusca
3534:                             THIS.txt_4c_OcoEtiqs.Value  = ALLTRIM(Cods)
3535:                             THIS.txt_4c_DOcoEtiqs.Value = ALLTRIM(Descrs)
3536:                         ELSE
3537:                             THIS.txt_4c_OcoEtiqs.Value  = ""
3538:                             THIS.txt_4c_DOcoEtiqs.Value = ""
3539:                         ENDIF
3540: 
3541:                         loc_oBusca.Release()
3542:                     ENDIF
3543: 
3544:                     IF USED("cursor_4c_OcoEtiqBusca")
3545:                         USE IN cursor_4c_OcoEtiqBusca
3546:                     ENDIF
3547:                 ENDIF
3548:             ENDIF

*-- Linhas 3578 a 3615:
3578:                     USE IN csConjunto
3579:                 ENDIF
3580: 
3581:                 SELECT MAX(cpros) AS Cpros, MAX(Qtds) AS Qtds, MAX(QtdeEtiq) AS QtdeEtiq, ;
3582:                        MAX(Pedido) AS Pedido, "" AS Obs, SUM(Pvens) AS Pvens, MAX(Moedas) AS Moedas, ;
3583:                        "" AS Empos, MAX(cpros1) AS cpros1, SUM(PrecoDe) AS PrecoDe, MAX(Parcelas) AS Parcelas ;
3584:                     FROM dbImpressao ;
3585:                     INTO CURSOR csConjunto READWRITE
3586: 
3587:                 SELECT dbImpressao
3588:                 ZAP
3589: 
3590:                 SELECT csConjunto
3591:                 GO TOP
3592:                 SCAN
3593:                     SCATTER MEMVAR
3594:                     SELECT dbImpressao
3595:                     APPEND BLANK
3596:                     GATHER MEMVAR
3597:                     SELECT csConjunto
3598:                 ENDSCAN
3599: 
3600:                 SELECT dbImpressao
3601:                 GO TOP
3602: 
3603:                 IF USED("csConjunto")
3604:                     USE IN csConjunto
3605:                 ENDIF
3606:             CATCH TO loc_oErro
3607:                 MsgErro(loc_oErro.Message, "Erro em MontaConjunto")
3608:             ENDTRY
3609:         ENDIF
3610:     ENDPROC
3611: 
3612:     *==========================================================================
3613:     * TagModelo1 - tagmod1 do legado (dump 2459-2541): etiquetas cujo tipo
3614:     * (SigCdTpe.tpespes = 2, "TAG MODELO 1") usam um layout proprio
3615:     * (SigReTg1.frx), montado a partir de dpros/razas/preco em vez da

*-- Linhas 3699 a 3784:
3699:         loc_cCursor    = THIS.this_cCursorEtiquetas
3700: 
3701:         IF USED("LocalTpEti")
3702:             SELECT LocalTpEti
3703:             LOCATE FOR LocalTpEti.nTipos = par_nTpEti
3704: 
3705:             IF !EOF() AND LocalTpEti.tpespes = 2
3706:                 loc_lEhModelo1 = .T.
3707: 
3708:                 TRY
3709:                     IF USED("dbImpressao")
3710:                         USE IN dbImpressao
3711:                     ENDIF
3712:                     CREATE CURSOR dbImpressao (CPros C(14), dpros C(40), Cbars N(14, 0), ;
3713:                         Pvens N(12, 2), razas C(30), Reffs C(40), codtams C(4), CodCors C(4))
3714:                     INDEX ON cpros TAG cpros
3715: 
3716:                     SQLEXEC(gnConnHandle, "SELECT cemps, razas FROM SigCdEmp", "crSigCdEmp")
3717:                     SQLEXEC(gnConnHandle, "SELECT observas, codigos FROM SigCdObs", "crSigCdObs")
3718: 
3719:                     IF USED(loc_cCursor)
3720:                         SELECT (loc_cCursor)
3721:                         SCAN
3722:                             IF EVALUATE(loc_cCursor + ".Flag")
3723:                                 IF USED("crSigCdEmp")
3724:                                     SELECT crSigCdEmp
3725:                                     LOCATE FOR cemps = EVALUATE(loc_cCursor + ".empos")
3726:                                 ENDIF
3727: 
3728:                                 IF USED("crSigCdObs")
3729:                                     SELECT crSigCdObs
3730:                                     LOCATE FOR codigos = LocalTpEti.codobs
3731:                                 ENDIF
3732: 
3733:                                 SQLEXEC(gnConnHandle, "SELECT dpros, PVIdeals, Moedas, PVens, Moevs FROM SigCdPro " + ;
3734:                                     "WHERE Cpros = " + EscaparSQL(EVALUATE(loc_cCursor + ".Cpros")), "LocalPro")
3735: 
3736:                                 SELECT (loc_cCursor)
3737: 
3738:                                 INSERT INTO dbImpressao (Cpros, Cbars, dpros, pvens, razas, reffs, codtams, codcors) ;
3739:                                     VALUES (EVALUATE(loc_cCursor + ".Cpros"), ;
3740:                                             EVALUATE(loc_cCursor + ".cbars"), ;
3741:                                             IIF(USED("LocalPro"), NVL(LocalPro.dpros, ""), ""), ;
3742:                                             IIF(par_lImpPreco, EVALUATE(loc_cCursor + ".Pvens"), 0), ;
3743:                                             IIF(USED("crSigCdEmp"), NVL(crSigCdEmp.razas, ""), ""), ;
3744:                                             EVALUATE(loc_cCursor + ".reffs"), ;
3745:                                             EVALUATE(loc_cCursor + ".codtams"), ;
3746:                                             EVALUATE(loc_cCursor + ".codcors"))
3747:                             ENDIF
3748:                         ENDSCAN
3749:                     ENDIF
3750: 
3751:                     SELECT dbImpressao
3752:                     GO TOP
3753: 
3754:                     IF !EOF()
3755:                         SET ORDER TO TAG cpros
3756: 
3757:                         IF par_cTipo = "I"
3758:                             IF FILE(FULLPATH(gc_4c_CaminhoReports + "SigReTg1.frx"))
3759:                                 THIS.ExecutarReportForm("SigReTg1", "PRINTER")
3760:                             ELSE
3761:                                 MsgErro("Relat" + CHR(243) + "rio de etiqueta (SigReTg1) n" + CHR(227) + ;
3762:                                     "o encontrado.", "Erro")
3763:                             ENDIF
3764:                         ELSE
3765:                             SELECT dbImpressao
3766:                             SCAN
3767:                                 loc_nBrr = INT(VAL(dbImpressao.Cpros))
3768:                                 SQLEXEC(gnConnHandle, "UPDATE SigCdPro SET ImpEtiqs = 1 WHERE CPros IN " + ;
3769:                                     "(SELECT CPros FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBrr) + ")")
3770:                             ENDSCAN
3771:                         ENDIF
3772:                     ENDIF
3773:                 CATCH TO loc_oErro
3774:                     MsgErro(loc_oErro.Message + CHR(13) + ;
3775:                         "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em TagModelo1")
3776:                 ENDTRY
3777:             ENDIF
3778:         ENDIF
3779: 
3780:         RETURN loc_lEhModelo1
3781:     ENDPROC
3782: 
3783:     *==========================================================================
3784:     * RegistrarOcorrenciaEtiquetas - bloco "If Thisform.GravaOcorrencia"

*-- Linhas 3790 a 3822:
3790: 
3791:         IF THIS.this_lGravaOcorrencia AND USED("dbImpressao")
3792:             TRY
3793:                 SELECT dbImpressao
3794:                 SCAN
3795:                     loc_cSQL = "INSERT INTO SigEtOcr (Cbars, Datas, Horas, Usuars, Qtds, Cods, Justifs, cidchaves) " + ;
3796:                         "VALUES (" + ;
3797:                         FormatarNumeroSQL(INT(VAL(dbImpressao.Cpros)), 0) + ", " + ;
3798:                         FormatarDataSQL(DATE()) + ", " + ;
3799:                         EscaparSQL(TIME()) + ", " + ;
3800:                         EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
3801:                         FormatarNumeroSQL(dbImpressao.QtdeEtiq, 0) + ", " + ;
3802:                         EscaparSQL(ALLTRIM(THIS.txt_4c_OcoEtiqs.Value)) + ", " + ;
3803:                         EscaparSQL(THIS.obj_4c_GetJustifs.Value) + ", " + ;
3804:                         EscaparSQL(LEFT(fUniqueIds(), 20)) + ")"
3805: 
3806:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
3807:                         MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - SigEtOcr)")
3808:                     ENDIF
3809:                 ENDSCAN
3810:             CATCH TO loc_oErro
3811:                 MsgErro(loc_oErro.Message, "Erro em RegistrarOcorrenciaEtiquetas")
3812:             ENDTRY
3813:         ENDIF
3814:     ENDPROC
3815: 
3816:     *==========================================================================
3817:     * ImpressaoValidarOcorrenciaObrigatoria - "Consiste os Parametros" do
3818:     * Impressao() legado (dump 1949-1970): a Ocorrencia eh obrigatoria
3819:     * quando this_lGravaOcorrencia, e a Justificativa eh obrigatoria quando
3820:     * a ocorrencia escolhida exige (SigEtOco.Justifs = 1).
3821:     *==========================================================================
3822:     PROCEDURE ImpressaoValidarOcorrenciaObrigatoria()

*-- Linhas 3835 a 3860:
3835:                     IF USED("TmpOcEti")
3836:                         USE IN TmpOcEti
3837:                     ENDIF
3838:                     loc_cSQL = "SELECT * FROM SigEtOco WHERE Cods = " + EscaparSQL(ALLTRIM(THIS.txt_4c_OcoEtiqs.Value))
3839:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TmpOcEti")
3840: 
3841:                     IF loc_nResultado < 1
3842:                         MsgErro("Favor reinicializar o processo !!!", "Falha na Conex" + CHR(227) + "o (TmpOcEti)")
3843:                         loc_lResultado = .F.
3844:                     ELSE
3845:                         SELECT TmpOcEti
3846:                         GO TOP
3847:                         IF !EOF() AND TmpOcEti.Justifs = 1 AND EMPTY(THIS.obj_4c_GetJustifs.Value)
3848:                             MsgAviso("Ocorr" + CHR(234) + "ncia com Justificativa Obrigat" + CHR(243) + "ria !!!", ;
3849:                                 "Campo Obrigat" + CHR(243) + "rio")
3850:                             THIS.obj_4c_GetJustifs.SetFocus()
3851:                             loc_lResultado = .F.
3852:                         ENDIF
3853:                     ENDIF
3854:                 CATCH TO loc_oErro
3855:                     MsgErro(loc_oErro.Message, "Erro em ImpressaoValidarOcorrenciaObrigatoria")
3856:                     loc_lResultado = .F.
3857:                 ENDTRY
3858:             ENDIF
3859:         ENDIF
3860: 

*-- Linhas 3875 a 3893:
3875:             loc_lTratado = .T.
3876: 
3877:             THIS.GarantirCursorImpressao()
3878:             SELECT dbImpressao
3879:             ZAP
3880:             APPEND BLANK
3881:             REPLACE Cpros WITH "1", Qtds WITH 1
3882: 
3883:             loc_cTexto = THIS.obj_4c_GetTexto.Value
3884: 
3885:             IF par_cTipo = "I"
3886:                 TRY
3887:                     SigOpEtq(gnConnHandle, .F., .F., par_nTpEti, THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value, ;
3888:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value, ;
3889:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value, ;
3890:                         THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value, "", "", "", ;
3891:                         THIS.ObterNomeImpressoraAtual(), .F., .F., THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value, ;
3892:                         .F., .F., .F., .F., .F., .F., loc_cTexto)
3893:                 CATCH TO loc_oErro

*-- Linhas 3919 a 3956:
3919:                 loc_cTexto = ALLTRIM(STR(IIF(!EMPTY(THIS.txt_4c_QtParcs.Value), THIS.txt_4c_QtParcs.Value, 1)))
3920: 
3921:                 THIS.GarantirCursorImpressao()
3922:                 SELECT dbImpressao
3923:                 ZAP
3924: 
3925:                 IF USED(loc_cCursor)
3926:                     SELECT (loc_cCursor)
3927:                     loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Etiquetas...", RECCOUNT())
3928:                     loc_oProgresso.Show()
3929: 
3930:                     SCAN
3931:                         loc_oProgresso.Update(.T.)
3932: 
3933:                         IF EVALUATE(loc_cCursor + ".Flag")
3934:                             IF EVALUATE(loc_cCursor + ".Mantem")
3935:                                 SCATTER MEMVAR MEMO
3936:                                 SELECT dbImpressao
3937:                                 APPEND BLANK
3938:                                 GATHER MEMVAR MEMO
3939:                                 SELECT (loc_cCursor)
3940:                             ELSE
3941:                                 INSERT INTO dbImpressao (cpros, Qtds, QtdeEtiq, Pedido, Obs, Pvens, Moedas, Empos, cpros1, PrecoDe, Parcelas) ;
3942:                                     VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, EVALUATE(loc_cCursor + ".Qtds"), ;
3943:                                             NVL(EVALUATE(loc_cCursor + ".CodAmss"), ""), NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), ""), ;
3944:                                             EVALUATE(loc_cCursor + ".Pvens"), EVALUATE(loc_cCursor + ".Moedas"), ;
3945:                                             EVALUATE(loc_cCursor + ".Empos"), EVALUATE(loc_cCursor + ".Cpros"), ;
3946:                                             EVALUATE(loc_cCursor + ".PrecoDe"), EVALUATE(loc_cCursor + ".Parcelas"))
3947:                             ENDIF
3948:                         ENDIF
3949:                     ENDSCAN
3950: 
3951:                     loc_oProgresso.Complete()
3952:                 ENDIF
3953: 
3954:                 THIS.MontaConjunto()
3955: 
3956:                 IF par_cTipo = "I"

*-- Linhas 3985 a 4125:
3985: 
3986:         TRY
3987:             THIS.GarantirCursorImpressao()
3988:             SELECT dbImpressao
3989:             ZAP
3990:             IF USED("crSigEtOcr")
3991:                 SELECT crSigEtOcr
3992:                 ZAP
3993:             ENDIF
3994: 
3995:             IF USED(loc_cCursor)
3996:                 SELECT (loc_cCursor)
3997:                 loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Etiquetas...", RECCOUNT())
3998:                 loc_oProgresso.Show()
3999: 
4000:                 SCAN
4001:                     loc_oProgresso.Update(.T.)
4002: 
4003:                     IF EVALUATE(loc_cCursor + ".Flag")
4004:                         IF EVALUATE(loc_cCursor + ".Mantem")
4005:                             SCATTER MEMVAR MEMO
4006:                             m.Obs = IIF(par_nTpEti = 134, m.CodCors, m.Obs)
4007:                             SELECT dbImpressao
4008:                             APPEND BLANK
4009:                             GATHER MEMVAR MEMO
4010:                             SELECT (loc_cCursor)
4011:                         ELSE
4012:                             IF par_nTpEti = 12
4013:                                 SQLEXEC(gnConnHandle, "SELECT * FROM SigCdOpe WHERE Dopes = " + ;
4014:                                     EscaparSQL(EVALUATE(loc_cCursor + ".Dopes")), "LocalOpe")
4015: 
4016:                                 IF USED("LocalOpe") AND !EOF("LocalOpe")
4017:                                     INSERT INTO dbImpressao (Cpros, Qtds, Cbars, Obs, cpros1) ;
4018:                                         VALUES (EVALUATE(loc_cCursor + ".Cpros"), 1, ;
4019:                                             VAL(STR(LocalOpe.Ndopes, 4) + TRANSFORM(EVALUATE(loc_cCursor + ".Cbars"), "@L 9999999999")), ;
4020:                                             NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), ""), EVALUATE(loc_cCursor + ".Cpros"))
4021:                                 ENDIF
4022:                             ELSE
4023:                                 loc_nQtd = EVALUATE(loc_cCursor + ".Qtds")
4024: 
4025:                                 IF EMPTY(EVALUATE(loc_cCursor + ".Nops"))
4026:                                     INSERT INTO dbImpressao (Cpros, Qtds, QtdeEtiq, Pedido, Obs, Pvens, Moedas, Empos, cpros1, CodTams, PrecoDe, Parcelas) ;
4027:                                         VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, loc_nQtd, ;
4028:                                             NVL(EVALUATE(loc_cCursor + ".CodAmss"), ""), ;
4029:                                             IIF(par_nTpEti = 134, EVALUATE(loc_cCursor + ".CodCors"), NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), "")), ;
4030:                                             EVALUATE(loc_cCursor + ".Pvens"), EVALUATE(loc_cCursor + ".Moedas"), ;
4031:                                             EVALUATE(loc_cCursor + ".Empos"), EVALUATE(loc_cCursor + ".Cpros"), ;
4032:                                             EVALUATE(loc_cCursor + ".CodTams"), EVALUATE(loc_cCursor + ".PrecoDe"), ;
4033:                                             IIF(par_nOptPreco = 6 AND EMPTY(EVALUATE(loc_cCursor + ".Parcelas")), 1, EVALUATE(loc_cCursor + ".Parcelas")))
4034: 
4035:                                     IF INLIST(par_nTpEti, 39)
4036:                                         loc_cEdn = EVALUATE(loc_cCursor + ".Empos") + EVALUATE(loc_cCursor + ".Dopeos") + ;
4037:                                             STR(EVALUATE(loc_cCursor + ".Numeos"), 6)
4038:                                         SQLEXEC(gnConnHandle, "SELECT ContaOs, ContaDs, Vends FROM SigMvCab WHERE EmpDopNums = " + ;
4039:                                             EscaparSQL(loc_cEdn), "LocalEest")
4040:                                         IF USED("LocalEest") AND !EOF("LocalEest")
4041:                                             loc_cConta = IIF(EMPTY(LocalEest.ContaDs), LocalEest.ContaOs, LocalEest.ContaDs) + "/" + ;
4042:                                                 ALLTRIM(STR(EVALUATE(loc_cCursor + ".Numeos"), 6))
4043:                                             REPLACE Pedido WITH loc_cConta IN dbImpressao
4044:                                         ENDIF
4045:                                     ENDIF
4046: 
4047:                                     IF INLIST(par_nTpEti, 23, 26, 24, 93, 135)
4048:                                         REPLACE empdopnums WITH EVALUATE(loc_cCursor + ".empdopnums") IN dbImpressao
4049:                                     ENDIF
4050:                                 ELSE
4051:                                     SQLEXEC(gnConnHandle, "SELECT Abrevs, Globalizas FROM SigCdOpe WHERE Dopes = " + ;
4052:                                         EscaparSQL(EVALUATE(loc_cCursor + ".DopeOs")), "LocalOpe")
4053: 
4054:                                     IF USED("LocalOpe") AND !EOF("LocalOpe")
4055:                                         INSERT INTO dbImpressao (Cpros, Qtds, QtdeEtiq, Pedido, Obs, Pvens, Moedas, Empos, cpros1, CodTams, PrecoDe, Parcelas) ;
4056:                                             VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, loc_nQtd, ;
4057:                                                 ALLTRIM(LocalOpe.Abrevs) + " : " + ALLTRIM(STR(EVALUATE(loc_cCursor + ".NumeOs"))), ;
4058:                                                 IIF(par_nTpEti = 134, EVALUATE(loc_cCursor + ".CodCors"), NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), "")), ;
4059:                                                 EVALUATE(loc_cCursor + ".Pvens"), EVALUATE(loc_cCursor + ".Moedas"), ;
4060:                                                 EVALUATE(loc_cCursor + ".Empos"), EVALUATE(loc_cCursor + ".Cpros"), ;
4061:                                                 EVALUATE(loc_cCursor + ".CodTams"), EVALUATE(loc_cCursor + ".PrecoDe"), ;
4062:                                                 IIF(par_nOptPreco = 6 AND EMPTY(EVALUATE(loc_cCursor + ".Parcelas")), 1, EVALUATE(loc_cCursor + ".Parcelas")))
4063: 
4064:                                         IF INLIST(par_nTpEti, 23, 26, 24, 93, 135)
4065:                                             REPLACE empdopnums WITH EVALUATE(loc_cCursor + ".empdopnums") IN dbImpressao
4066:                                         ENDIF
4067: 
4068:                                         IF INLIST(par_nTpEti, 39, 109, 113)
4069:                                             loc_cEdn = EVALUATE(loc_cCursor + ".Empos") + EVALUATE(loc_cCursor + ".Dopeos") + ;
4070:                                                 STR(EVALUATE(loc_cCursor + ".Numeos"), 6)
4071:                                             SQLEXEC(gnConnHandle, "SELECT ContaOs, ContaDs, Vends FROM SigMvCab WHERE EmpDopNums = " + ;
4072:                                                 EscaparSQL(loc_cEdn), "LocalEest")
4073: 
4074:                                             IF USED("LocalEest") AND !EOF("LocalEest")
4075:                                                 loc_cConta = IIF(LocalOpe.Globalizas = 1, LocalEest.ContaOs, LocalEest.ContaDs) + ;
4076:                                                     IIF(INLIST(par_nTpEti, 39), "/" + ALLTRIM(STR(EVALUATE(loc_cCursor + ".Numeos"), 6)), "")
4077: 
4078:                                                 IF INLIST(par_nTpEti, 109, 113)
4079:                                                     SQLEXEC(gnConnHandle, "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
4080:                                                         EscaparSQL(loc_cConta), "LocalCli")
4081:                                                     IF USED("LocalCli") AND !EOF("LocalCli")
4082:                                                         loc_cConta = LocalCli.Rclis
4083:                                                     ENDIF
4084:                                                 ENDIF
4085: 
4086:                                                 REPLACE Pedido WITH loc_cConta IN dbImpressao
4087:                                             ENDIF
4088:                                         ENDIF
4089:                                     ENDIF
4090:                                 ENDIF
4091:                             ENDIF
4092:                         ENDIF
4093:                     ENDIF
4094:                 ENDSCAN
4095: 
4096:                 loc_oProgresso.Complete()
4097:             ENDIF
4098: 
4099:             SELECT dbImpressao
4100:             GO TOP
4101: 
4102:             IF !EOF()
4103:                 IF par_cTipo = "I"
4104:                     loc_lPreco = .T.
4105:                     IF !INLIST(THIS.ObterTipoChamador(), "CADASTRO", "UNITARIO", "OPERACAO")
4106:                         IF INLIST(par_nOptPreco, 3, 4)
4107:                             SELECT dbImpressao
4108:                             SCAN
4109:                                 SQLEXEC(gnConnHandle, "SELECT PVIdeals, Moedas, PVens, Moevs, PrecoDe FROM SigCdPro WHERE CPros = " + ;
4110:                                     EscaparSQL(dbImpressao.CPros1), "LocalPro")
4111: 
4112:                                 IF USED("LocalPro")
4113:                                     GO TOP IN LocalPro
4114:                                     IF !EOF("LocalPro")
4115:                                         REPLACE PVens   WITH IIF(par_nOptPreco = 3, LocalPro.PVIdeals, LocalPro.PVens), ;
4116:                                                 Moedas  WITH IIF(par_nOptPreco = 3, LocalPro.Moedas,   LocalPro.MoeVs), ;
4117:                                                 PrecoDe WITH LocalPro.PrecoDe IN dbImpressao
4118:                                     ENDIF
4119:                                 ENDIF
4120:                             ENDSCAN
4121:                         ENDIF
4122:                     ENDIF
4123: 
4124:                     THIS.MontaConjunto()
4125: 

*-- Linhas 4135 a 4164:
4135:                 ELSE
4136:                     loc_nBrr = INT(VAL(dbImpressao.Cpros))
4137: 
4138:                     SQLEXEC(gnConnHandle, "SELECT CPros FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBrr), "csBarra")
4139: 
4140:                     IF USED("csBarra") AND !EOF("csBarra")
4141:                         loc_cBrr = csBarra.CPros
4142:                         loc_cSQL = "UPDATE SigCdPro SET ImpEtiqs = 1 WHERE CPros = " + EscaparSQL(loc_cBrr)
4143: 
4144:                         IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
4145:                             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - SigCdPro)")
4146:                         ENDIF
4147: 
4148:                         IF USED("crSigCdPro")
4149:                             UPDATE crSigCdPro SET ImpEtiqs = .T. WHERE CPros = loc_cBrr
4150:                         ENDIF
4151:                     ENDIF
4152:                 ENDIF
4153: 
4154:                 THIS.RegistrarOcorrenciaEtiquetas()
4155:             ELSE
4156:                 MsgAviso("Nenhuma Etiqueta Selecionada!!!", "")
4157:             ENDIF
4158:         CATCH TO loc_oErro
4159:             MsgErro(loc_oErro.Message + CHR(13) + ;
4160:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4161:                 "Procedure: " + loc_oErro.Procedure, "Erro em ImprimirSemAgrupamento")
4162:         ENDTRY
4163:     ENDPROC
4164: 

*-- Linhas 4177 a 4337:
4177: 
4178:         TRY
4179:             IF USED(loc_cCursor)
4180:                 SELECT (loc_cCursor)
4181: 
4182:                 IF THIS.this_nOrdemImp != 3
4183:                     SET ORDER TO TAG EmpGruCon
4184:                 ENDIF
4185: 
4186:                 GO TOP
4187: 
4188:                 loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Dados do Cursor...", RECCOUNT())
4189:                 loc_oProgresso.Show()
4190: 
4191:                 DO WHILE !EOF(loc_cCursor)
4192:                     loc_cEmp = EVALUATE(loc_cCursor + ".Empos")
4193:                     loc_cGrp = EVALUATE(loc_cCursor + ".Grupos")
4194:                     loc_cCta = EVALUATE(loc_cCursor + ".Contas")
4195:                     loc_cRps = IIF(THIS.this_lGravaPro, "Reposicao", " ")
4196: 
4197:                     THIS.GarantirCursorImpressao()
4198:                     SELECT dbImpressao
4199:                     ZAP
4200:                     IF USED("crSigEtOcr")
4201:                         SELECT crSigEtOcr
4202:                         ZAP
4203:                     ENDIF
4204: 
4205:                     SELECT (loc_cCursor)
4206: 
4207:                     DO WHILE !EOF(loc_cCursor)
4208:                         IF THIS.this_nOrdemImp != 3
4209:                             IF EVALUATE(loc_cCursor + ".Empos") + EVALUATE(loc_cCursor + ".Grupos") + ;
4210:                                     EVALUATE(loc_cCursor + ".Contas") != loc_cEmp + loc_cGrp + loc_cCta
4211:                                 EXIT
4212:                             ENDIF
4213:                         ENDIF
4214: 
4215:                         loc_oProgresso.Update(.T.)
4216: 
4217:                         IF EVALUATE(loc_cCursor + ".Flag")
4218:                             IF EVALUATE(loc_cCursor + ".Mantem")
4219:                                 SCATTER MEMVAR MEMO
4220:                                 SELECT dbImpressao
4221:                                 APPEND BLANK
4222:                                 GATHER MEMVAR MEMO
4223:                                 SELECT (loc_cCursor)
4224:                             ELSE
4225:                                 loc_nQtd = EVALUATE(loc_cCursor + ".Qtds")
4226: 
4227:                                 IF EMPTY(EVALUATE(loc_cCursor + ".Nops"))
4228:                                     INSERT INTO dbImpressao (Cpros, Qtds, QtdeEtiq, Obs) ;
4229:                                         VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, loc_nQtd, ;
4230:                                             NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), ""))
4231:                                 ELSE
4232:                                     SQLEXEC(gnConnHandle, "SELECT Abrevs, Globalizas FROM SigCdOpe WHERE Dopes = " + ;
4233:                                         EscaparSQL(EVALUATE(loc_cCursor + ".DopeOs")), "LocalOpe")
4234: 
4235:                                     IF USED("LocalOpe") AND !EOF("LocalOpe")
4236:                                         INSERT INTO dbImpressao (Cpros, Qtds, QtdeEtiq, Pedido, Obs) ;
4237:                                             VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, loc_nQtd, ;
4238:                                                 ALLTRIM(LocalOpe.Abrevs) + " : " + ALLTRIM(STR(EVALUATE(loc_cCursor + ".Numeos"))), ;
4239:                                                 NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), ""))
4240: 
4241:                                         IF INLIST(par_nTpEti, 39, 109, 113)
4242:                                             loc_cEdn = EVALUATE(loc_cCursor + ".Empos") + EVALUATE(loc_cCursor + ".Dopeos") + ;
4243:                                                 STR(EVALUATE(loc_cCursor + ".Numeos"), 6)
4244:                                             SQLEXEC(gnConnHandle, "SELECT ContaOs, ContaDs, Vends FROM SigMvCab WHERE EmpDopNums = " + ;
4245:                                                 EscaparSQL(loc_cEdn), "LocalEest")
4246: 
4247:                                             IF USED("LocalEest") AND !EOF("LocalEest")
4248:                                                 loc_cConta = IIF(LocalOpe.Globalizas = 1, LocalEest.ContaOs, LocalEest.ContaDs) + ;
4249:                                                     IIF(INLIST(par_nTpEti, 39), "/" + ALLTRIM(STR(EVALUATE(loc_cCursor + ".Numeos"), 6)), "")
4250: 
4251:                                                 IF INLIST(par_nTpEti, 109, 113)
4252:                                                     SQLEXEC(gnConnHandle, "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
4253:                                                         EscaparSQL(loc_cConta), "LocalCli")
4254:                                                     IF USED("LocalCli") AND !EOF("LocalCli")
4255:                                                         loc_cConta = LocalCli.Rclis
4256:                                                     ENDIF
4257:                                                 ENDIF
4258: 
4259:                                                 REPLACE Pedido WITH loc_cConta IN dbImpressao
4260:                                             ENDIF
4261:                                         ENDIF
4262:                                     ENDIF
4263:                                 ENDIF
4264:                             ENDIF
4265:                         ENDIF
4266: 
4267:                         SELECT (loc_cCursor)
4268:                         SKIP
4269:                     ENDDO
4270: 
4271:                     *-- Legado: "Skip -1" reposiciona no ULTIMO registro do
4272:                     *-- grupo que acabou de ser processado, para o SKIP
4273:                     *-- implicito do loop externo avancar para o grupo
4274:                     *-- seguinte (mesma semantica do Scan/Scan While/Skip -1
4275:                     *-- aninhados do dump).
4276:                     IF !BOF(loc_cCursor)
4277:                         SKIP -1 IN (loc_cCursor)
4278:                     ENDIF
4279: 
4280:                     SELECT dbImpressao
4281:                     GO TOP
4282: 
4283:                     THIS.MontaConjunto()
4284: 
4285:                     IF !EOF("dbImpressao")
4286:                         IF par_cTipo = "I"
4287:                             SigOpEtq(gnConnHandle, par_lImpPreco, .F., par_nTpEti, ;
4288:                                 THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value, ;
4289:                                 THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value, ;
4290:                                 THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value, ;
4291:                                 THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value, loc_cEmp, loc_cGrp, loc_cCta, ;
4292:                                 THIS.ObterNomeImpressoraAtual(), .F., loc_cRps, ;
4293:                                 THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value, par_lImpPesoTotal, ;
4294:                                 .F., .F., .F., .F., (THIS.cnt_4c__Impressora.chk_4c_Chk_Resete.Value = 1))
4295: 
4296:                             IF THIS.ObterTipoChamador() == "ARQUIVADAS"
4297:                                 THIS.this_lImpArquivadas = .T.
4298:                             ENDIF
4299:                         ELSE
4300:                             loc_nBrr = INT(VAL(dbImpressao.Cpros))
4301: 
4302:                             SQLEXEC(gnConnHandle, "SELECT CPros FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBrr), "csBarra")
4303: 
4304:                             IF USED("csBarra") AND !EOF("csBarra")
4305:                                 loc_cBrr = csBarra.CPros
4306:                                 loc_cSQL = "UPDATE SigCdPro SET ImpEtiqs = 1 WHERE CPros = " + EscaparSQL(loc_cBrr)
4307: 
4308:                                 IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
4309:                                     MsgErro("Favor Reinicializar o Processo!!!", ;
4310:                                         "Falha na Conex" + CHR(227) + "o (Update - SigCdPro)")
4311:                                 ENDIF
4312: 
4313:                                 IF USED("crSigCdPro")
4314:                                     UPDATE crSigCdPro SET ImpEtiqs = .T. WHERE CPros = loc_cBrr
4315:                                 ENDIF
4316:                             ENDIF
4317:                         ENDIF
4318: 
4319:                         THIS.RegistrarOcorrenciaEtiquetas()
4320:                     ENDIF
4321: 
4322:                     SELECT (loc_cCursor)
4323:                 ENDDO
4324: 
4325:                 loc_oProgresso.Complete()
4326:             ENDIF
4327:         CATCH TO loc_oErro
4328:             MsgErro(loc_oErro.Message + CHR(13) + ;
4329:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4330:                 "Procedure: " + loc_oErro.Procedure, "Erro em ImprimirAgrupadoPorContaOs")
4331:         ENDTRY
4332:     ENDPROC
4333: 
4334:     *==========================================================================
4335:     * GerarOperacaoEtiquetas - bloco final de Impressao() (dump 2381-2450):
4336:     * quando a impressao eh imediata e o chamador configurou uma operacao
4337:     * de destino (LocalParac.DopEtiqs), gera o movimento correspondente em

*-- Linhas 4345 a 4402:
4345:     *
4346:     * SigMvCab e SigMvItn tem mais de 100 colunas NOT NULL cada (conferido
4347:     * em docs\schema.sql); o legado grava via cursor BUFFERIZADO inteiro
4348:     * (AddCursor + TableUpdate), que preenche as colunas nao citadas com o
4349:     * branco do registro em branco do cursor. Um INSERT parcial aqui
4350:     * quebraria o NOT NULL em runtime (regra CLAUDE.md #22 - mesma classe
4351:     * dos Erro151/Erro159) - por isso SigMvCab/SigMvItn NAO sao gravados
4352:     * por este metodo ainda; SigMvIts (o item com o codigo de barras) TEM
4353:     * BO proprio e completo (SigOpIpEBO, Fases 1-2, INSERT com as 30
4354:     * colunas da tabela) e esse SIM eh gravado aqui.
4355:     *==========================================================================
4356:     PROCEDURE GerarOperacaoEtiquetas(par_nTpEti)
4357:         LOCAL loc_lConfirmou, loc_cDopes, loc_cChave, loc_nItem, loc_nNumes, loc_cEmps, ;
4358:               loc_oBO, loc_oErro
4359: 
4360:         IF USED("LocalParac") AND !EMPTY(NVL(LocalParac.DopEtiqs, "")) AND par_nTpEti != 12
4361:             loc_cDopes = ALLTRIM(LocalParac.DopEtiqs)
4362: 
4363:             loc_lConfirmou = MsgConfirma("Confirma Gera" + CHR(231) + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + ;
4364:                 "o " + loc_cDopes + "!!!", "")
4365: 
4366:             IF loc_lConfirmou
4367:                 TRY
4368:                     IF USED("CsSelecao")
4369:                         USE IN CsSelecao
4370:                     ENDIF
4371:                     SELECT Empos, Grupos, Contas, Cpros, Cbars, CodCors, CodTams, Qtds, Pesos ;
4372:                         FROM (THIS.this_cCursorEtiquetas) WHERE Empos != "  " ;
4373:                         INTO CURSOR CsSelecao ORDER BY 1, 2, 3
4374: 
4375:                     loc_cChave = SPACE(23)
4376:                     loc_nItem  = 1
4377: 
4378:                     MsgErro("A gera" + CHR(231) + CHR(227) + "o autom" + CHR(225) + "tica da opera" + CHR(231) + ;
4379:                         CHR(227) + "o " + loc_cDopes + " tamb" + CHR(233) + "m grava em SigMvCab e SigMvItn, que " + ;
4380:                         "ainda n" + CHR(227) + "o t" + CHR(234) + "m cobertura completa de colunas NOT NULL nesta " + ;
4381:                         "migra" + CHR(231) + CHR(227) + "o. O item em SigMvIts ser" + CHR(225) + " gravado; " + ;
4382:                         "registre o cabe" + CHR(231) + "alho/itens do movimento manualmente.", ;
4383:                         "Grava" + CHR(231) + CHR(227) + "o parcial")
4384: 
4385:                     loc_oBO = THIS.this_oBusinessObject
4386: 
4387:                     SELECT CsSelecao
4388:                     SCAN
4389:                         loc_cEmps = CsSelecao.Empos
4390: 
4391:                         IF Empos + Grupos + Contas != loc_cChave
4392:                             loc_nNumes = fGerUniqueKey(ALLTRIM(loc_cDopes) + loc_cEmps)
4393:                             loc_nItem  = 1
4394:                             loc_cChave = CsSelecao.Empos + CsSelecao.Grupos + CsSelecao.Contas
4395:                         ENDIF
4396: 
4397:                         IF VARTYPE(loc_oBO) = "O" AND (!EMPTY(CsSelecao.CodCors) OR !EMPTY(CsSelecao.CodTams))
4398:                             loc_oBO.this_cEmps      = loc_cEmps
4399:                             loc_oBO.this_cDopes     = loc_cDopes
4400:                             loc_oBO.this_nNumes     = loc_nNumes
4401:                             loc_oBO.this_cCpros     = CsSelecao.Cpros
4402:                             loc_oBO.this_cCodtams   = CsSelecao.CodTams

*-- Linhas 4505 a 4523:
4505:     *
4506:     * poDataGrv/fSqlConector (dump 2621-2630, AddCursor de SigEtOcr/
4507:     * SigMvCab/SigMvItn/SigMvIts) NAO entra: eh um wrapper de acesso a
4508:     * dados que o resto do projeto substitui por SQLEXEC direto, e os
4509:     * quatro cursores que ele abriria (crSigEtOcr/crSigMvCab/crSigMvItn/
4510:     * crSigMvIts) ja sao lidos com guarda USED() pelas Fases 5-7 (ex.
4511:     * GarantirCursorImpressao) assumindo que podem nao existir -
4512:     * implementa-lo seria trazer uma camada de acesso a dados inteira
4513:     * para uma fase que so precisa de quatro cursores especificos
4514:     * (LocalParam/LocalParaC/LocalTpEti/crImpreV, ja fixados como
4515:     * contrato pelas Fases 5-7).
4516:     *==========================================================================
4517:     PROTECTED PROCEDURE CarregarContextoInicial()
4518:         LOCAL loc_oErro
4519: 
4520:         TRY
4521:             *-- Legado: "Thisform.grd_Historico.Column2.Header1.Tag = []"
4522:             THIS.grd_4c_Dados.Column2.Header1.Tag = ""
4523: 

*-- Linhas 4559 a 4612:
4559: 
4560:     *==========================================================================
4561:     * CarregarParametrosSistema - LocalParam/LocalParaC (SigCdPam/SigCdPaC),
4562:     * tabelas de UMA linha so - mesma leitura "SELECT sem WHERE" que o
4563:     * irmao sigopetsBO documenta para CrSigCdPam/CrSigCdPac.
4564:     *
4565:     * Legado (Init:2632-2634):
4566:     *   lcCpo = 'OcoEtiqs, Ouros, nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis,
4567:     *            AjVerts, AjHorzs, LibObss, TpInstalas'
4568:     *   CursorQuery('SigCdPam', 'LocalParam', .F., .F., lcCpo)
4569:     *   CursorQuery('SigCdPaC', 'LocalParaC', .F., .F., 'AjDens, AjVelos,
4570:     *            EtqSeps, DopEtiqs, QtdMarPar, VlrMinPar')
4571:     *
4572:     * SQLEXEC com SELECT explicito (nunca SELECT *) - colunas conferidas
4573:     * em docs\schema.sql (UTF-16, Get-Content -Raw).
4574:     *==========================================================================
4575:     PROTECTED FUNCTION CarregarParametrosSistema()
4576:         LOCAL loc_lSucesso, loc_nResultado, loc_oErro
4577: 
4578:         loc_lSucesso = .F.
4579: 
4580:         TRY
4581:             IF USED("LocalParam")
4582:                 USE IN LocalParam
4583:             ENDIF
4584: 
4585:             loc_nResultado = SQLEXEC(gnConnHandle, ;
4586:                 "SELECT OcoEtiqs, Ouros, nMaxTpEtis, TpEtiPads, nMaxImpEti, " + ;
4587:                 "ImpEtis, AjVerts, AjHorzs, LibObss, TpInstalas FROM SigCdPam", ;
4588:                 "LocalParam")
4589: 
4590:             IF loc_nResultado >= 1 AND USED("LocalParam")
4591:                 IF USED("LocalParaC")
4592:                     USE IN LocalParaC
4593:                 ENDIF
4594: 
4595:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
4596:                     "SELECT AjDens, AjVelos, EtqSeps, DopEtiqs, QtdMarPar, " + ;
4597:                     "VlrMinPar FROM SigCdPaC", "LocalParaC")
4598: 
4599:                 loc_lSucesso = (loc_nResultado >= 1) AND USED("LocalParaC")
4600:             ENDIF
4601: 
4602:             IF !loc_lSucesso
4603:                 THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
4604:             ENDIF
4605:         CATCH TO loc_oErro
4606:             loc_lSucesso = .F.
4607:             THIS.this_cMensagemErro = loc_oErro.Message
4608:             MsgErro(loc_oErro.Message + CHR(13) + ;
4609:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarParametrosSistema")
4610:         ENDTRY
4611: 
4612:         RETURN loc_lSucesso

*-- Linhas 4688 a 4721:
4688:                 USE IN LocalTpEti
4689:             ENDIF
4690: 
4691:             loc_nResultado = SQLEXEC(gnConnHandle, ;
4692:                 "SELECT * FROM SigCdTpe WHERE nSituas = 1 ORDER BY cOrdems, cEtiquetas", ;
4693:                 "LocalTpEti")
4694: 
4695:             loc_nTotalTipos = IIF(loc_nResultado >= 1 AND USED("LocalTpEti"), ;
4696:                 RECCOUNT("LocalTpEti"), 0)
4697:             THIS.this_nTotalTiposEtiqueta = loc_nTotalTipos
4698: 
4699:             IF loc_nTotalTipos != 0 AND USED("LocalParam")
4700:                 loc_nMaxBotoes = MIN(loc_nTotalTipos, MAX(LocalParam.nMaxTpEtis, 5))
4701:                 loc_oGrupo.ButtonCount = loc_nMaxBotoes
4702: 
4703:                 loc_nIndicePadrao = 1
4704:                 loc_nTop          = 10
4705: 
4706:                 SELECT LocalTpEti
4707:                 GO TOP
4708:                 loc_nI = 1
4709:                 SCAN WHILE loc_nI <= loc_nMaxBotoes
4710:                     IF LocalTpEti.nTipos = LocalParam.TpEtiPads
4711:                         loc_nIndicePadrao = loc_nI
4712:                     ENDIF
4713: 
4714:                     loc_oBotao = loc_oGrupo.Buttons(loc_nI)
4715:                     loc_oBotao.AutoSize  = .F.
4716:                     loc_oBotao.Width     = loc_oGrupo.Width - 10
4717:                     loc_oBotao.Caption   = "\<" + CHR(96 + loc_nI) + ". " + ALLTRIM(LocalTpEti.cEtiquetas)
4718:                     loc_oBotao.FontSize  = 8
4719:                     loc_oBotao.ForeColor = RGB(36, 84, 155)
4720:                     loc_oBotao.Tag       = ALLTRIM(STR(LocalTpEti.nTipos))
4721:                     loc_oBotao.Top       = loc_nTop

*-- Linhas 4807 a 4832:
4807:                 USE IN LocalEti
4808:             ENDIF
4809: 
4810:             loc_nResultado = SQLEXEC(gnConnHandle, ;
4811:                 "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBarra), "LocalEti")
4812: 
4813:             IF loc_nResultado >= 1 AND USED("LocalEti") AND !EOF("LocalEti") AND USED(loc_cCursor)
4814:                 SELECT LocalEti
4815:                 SCATTER MEMVAR
4816:                 m.Flag = .T.
4817:                 INSERT INTO (loc_cCursor) FROM MEMVAR
4818:             ENDIF
4819:         CATCH TO loc_oErro
4820:             THIS.this_cMensagemErro = loc_oErro.Message
4821:             MsgErro(loc_oErro.Message + CHR(13) + ;
4822:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasUnitario")
4823:         ENDTRY
4824:     ENDPROC
4825: 
4826:     *==========================================================================
4827:     * CarregarLinhasOperacao - Tipo='OPERACAO' (dump 2730-2775): as
4828:     * etiquetas vem do cursor dbImpressao que o form PAI (SigMvCab) ja
4829:     * deixou aberto (contrato entre forms - nao se recria aqui, so se le
4830:     * com guarda USED()).
4831:     *
4832:     * Column6(name)/migrado Column9 (pVens/Preco) vira editavel aqui -

*-- Linhas 4845 a 4891:
4845: 
4846:         TRY
4847:             IF USED("dbImpressao")
4848:                 SELECT dbImpressao
4849:                 SCAN
4850:                     loc_nBarra = INT(VAL(dbImpressao.Cpros))
4851: 
4852:                     IF USED("LocalEti")
4853:                         USE IN LocalEti
4854:                     ENDIF
4855:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
4856:                         "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBarra), "LocalEti")
4857: 
4858:                     IF loc_nResultado >= 1 AND USED("LocalEti")
4859:                         SELECT LocalEti
4860:                         SCATTER MEMVAR
4861:                         m.Flag = .T.
4862:                         m.Qtds = dbImpressao.Qtds
4863: 
4864:                         IF USED("LocalPro")
4865:                             USE IN LocalPro
4866:                         ENDIF
4867:                         SQLEXEC(gnConnHandle, "SELECT CUniPs, cGrus, Categoria FROM SigCdPro " + ;
4868:                             "WHERE CPros = " + EscaparSQL(LocalEti.Cpros), "LocalPro")
4869: 
4870:                         loc_lDistribui = .F.
4871:                         IF USED("LocalPro") AND !EOF("LocalPro")
4872:                             IF USED("LocalUni")
4873:                                 USE IN LocalUni
4874:                             ENDIF
4875:                             SQLEXEC(gnConnHandle, "SELECT Distribs FROM SigCdUni WHERE CUnis = " + ;
4876:                                 EscaparSQL(LocalPro.CUniPs), "LocalUni")
4877: 
4878:                             IF USED("LocalUni") AND !EOF("LocalUni") AND LocalUni.Distribs = 1
4879:                                 loc_lDistribui = .T.
4880:                             ENDIF
4881:                         ENDIF
4882: 
4883:                         IF loc_lDistribui
4884:                             m.Pesos     = dbImpressao.Pesos
4885:                             m.pvens     = dbImpressao.pvens
4886:                             m.PrecoDe   = LocalPro.PrecoDe
4887:                             m.Moedas    = dbImpressao.Moedas
4888:                             m.Reffs     = dbImpressao.Reffs
4889:                             m.Pedido    = dbImpressao.Pedido
4890:                             m.Obs       = dbImpressao.Obs
4891:                             m.Contas    = dbImpressao.Contas

*-- Linhas 4904 a 5090:
4904:                         ENDIF
4905: 
4906:                         IF USED(loc_cCursor)
4907:                             INSERT INTO (loc_cCursor) FROM MEMVAR
4908:                         ENDIF
4909:                     ENDIF
4910: 
4911:                     SELECT dbImpressao
4912:                 ENDSCAN
4913:             ENDIF
4914:         CATCH TO loc_oErro
4915:             THIS.this_cMensagemErro = loc_oErro.Message
4916:             MsgErro(loc_oErro.Message + CHR(13) + ;
4917:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasOperacao")
4918:         ENDTRY
4919:     ENDPROC
4920: 
4921:     *==========================================================================
4922:     * CarregarLinhasDiversas - Tipo='DIVERSAS' (dump 2777-2793): varias
4923:     * etiquetas passadas no cursor csRelatorio (contrato do form pai).
4924:     *==========================================================================
4925:     PROTECTED PROCEDURE CarregarLinhasDiversas()
4926:         LOCAL loc_cCursor, loc_nBarra, loc_nResultado, loc_oErro
4927: 
4928:         loc_cCursor = THIS.this_cCursorEtiquetas
4929: 
4930:         TRY
4931:             IF USED("csRelatorio")
4932:                 SELECT csRelatorio
4933:                 SCAN
4934:                     loc_nBarra = csRelatorio.CBars
4935: 
4936:                     IF USED("LocalEti")
4937:                         USE IN LocalEti
4938:                     ENDIF
4939:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
4940:                         "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBarra), "LocalEti")
4941: 
4942:                     IF loc_nResultado >= 1 AND USED("LocalEti") AND !EOF("LocalEti") AND USED(loc_cCursor)
4943:                         SELECT LocalEti
4944:                         SCATTER MEMVAR
4945:                         m.Flag = .T.
4946:                         INSERT INTO (loc_cCursor) FROM MEMVAR
4947:                     ENDIF
4948: 
4949:                     SELECT csRelatorio
4950:                 ENDSCAN
4951:             ENDIF
4952:         CATCH TO loc_oErro
4953:             THIS.this_cMensagemErro = loc_oErro.Message
4954:             MsgErro(loc_oErro.Message + CHR(13) + ;
4955:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasDiversas")
4956:         ENDTRY
4957:     ENDPROC
4958: 
4959:     *==========================================================================
4960:     * CarregarLinhasArquivadas - Tipo='ARQUIVADAS' (dump 2795-2846):
4961:     * chamado do SigPrRet (reimpressao individual) - todas as etiquetas
4962:     * dos produtos marcados com ImpEtiqs=1, uma por EmpOs+Grupos+Contas+
4963:     * CPros+CBars+pesos+qtds+datas, mantendo so as que o ULTIMO usuario a
4964:     * alterar o preco (SigCdPrc) foi o usuario logado (ou nenhum
4965:     * historico ainda).
4966:     *==========================================================================
4967:     PROTECTED PROCEDURE CarregarLinhasArquivadas()
4968:         LOCAL loc_cCursor, loc_cQuery, loc_nResultado, loc_oErro
4969: 
4970:         loc_cCursor = THIS.this_cCursorEtiquetas
4971: 
4972:         THIS.grd_4c_Dados.Column4.ReadOnly = .T.
4973: 
4974:         TRY
4975:             loc_cQuery = "SELECT c.EmpOs, c.Grupos, c.Contas, a.CPros, c.CBars, " + ;
4976:                 "c.pesos, c.qtds, c.datas, a.pvens, a.precode, a.cGrus, a.Categoria " + ;
4977:                 "FROM SigCdPro a, SigOpEtq c " + ;
4978:                 "WHERE a.ImpEtiqs = 1 AND a.CPros = c.CPros " + ;
4979:                 "AND NOT c.Grupos = '" + SPACE(10) + "' " + ;
4980:                 "AND NOT c.Contas = '" + SPACE(10) + "' " + ;
4981:                 "GROUP BY c.EmpOs, c.Grupos, c.Contas, a.CPros, c.CBars, c.pesos, c.qtds, c.datas"
4982: 
4983:             IF USED("TmpTmp1")
4984:                 USE IN TmpTmp1
4985:             ENDIF
4986:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "TmpTmp1")
4987: 
4988:             IF loc_nResultado < 1
4989:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpTmp1)")
4990:             ELSE
4991:                 SELECT TmpTmp1
4992:                 SCAN
4993:                     loc_cQuery = "SELECT TOP 1 UsuaAlts FROM SigCdPrc WHERE CPros = " + ;
4994:                         EscaparSQL(TmpTmp1.Cpros) + " ORDER BY DataAlts DESC, HoraAlts DESC"
4995: 
4996:                     IF USED("TmpUltimo")
4997:                         USE IN TmpUltimo
4998:                     ENDIF
4999:                     SQLEXEC(gnConnHandle, loc_cQuery, "TmpUltimo")
5000: 
5001:                     IF USED("TmpUltimo")
5002:                         GO TOP IN TmpUltimo
5003: 
5004:                         IF (EOF("TmpUltimo") OR gc_4c_UsuarioLogado == TmpUltimo.UsuaAlts) AND USED(loc_cCursor)
5005:                             SELECT TmpTmp1
5006:                             SCATTER MEMVAR
5007:                             m.Flag = .T.
5008:                             INSERT INTO (loc_cCursor) FROM MEMVAR
5009:                         ENDIF
5010:                     ENDIF
5011: 
5012:                     SELECT TmpTmp1
5013:                 ENDSCAN
5014:             ENDIF
5015: 
5016:             IF USED(loc_cCursor)
5017:                 SELECT (loc_cCursor)
5018:                 SET ORDER TO EmpGruCon
5019:             ENDIF
5020:         CATCH TO loc_oErro
5021:             THIS.this_cMensagemErro = loc_oErro.Message
5022:             MsgErro(loc_oErro.Message + CHR(13) + ;
5023:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasArquivadas")
5024:         ENDTRY
5025:     ENDPROC
5026: 
5027:     *==========================================================================
5028:     * CarregarLinhasCadastro - Tipo='CADASTRO' (dump 2848-2884): chamado
5029:     * do Cadastro de Produtos (SigCdPro) - todas as etiquetas de UM
5030:     * produto. ParentForm.Produto aqui eh STRING (CPros), diferente do
5031:     * ramo UNITARIO (mesmo nome de property, tipo NUMERICO la).
5032:     *==========================================================================
5033:     PROTECTED PROCEDURE CarregarLinhasCadastro()
5034:         LOCAL loc_cCursor, loc_cProduto, loc_cQuery, loc_nResultado, loc_oErro
5035: 
5036:         loc_cCursor  = THIS.this_cCursorEtiquetas
5037:         loc_cProduto = ""
5038: 
5039:         THIS.grd_4c_Dados.Column4.ReadOnly = .T.
5040: 
5041:         IF VARTYPE(THIS.this_oFormAnterior) = "O"
5042:             IF PEMSTATUS(THIS.this_oFormAnterior, "Produto", 5)
5043:                 IF VARTYPE(THIS.this_oFormAnterior.Produto) = "C"
5044:                     loc_cProduto = THIS.this_oFormAnterior.Produto
5045:                 ENDIF
5046:             ENDIF
5047:         ENDIF
5048: 
5049:         TRY
5050:             loc_cQuery = "SELECT b.*, a.pvens, a.precode, a.cGrus, a.Categoria " + ;
5051:                 "FROM SigOpEtq b JOIN SigCdpro a ON a.cpros = b.cpros " + ;
5052:                 "WHERE b.Cpros = " + EscaparSQL(loc_cProduto) + " " + ;
5053:                 "AND NOT b.Grupos = '" + SPACE(10) + "' " + ;
5054:                 "AND NOT b.Contas = '" + SPACE(10) + "'"
5055: 
5056:             IF USED("TmpTmp2")
5057:                 USE IN TmpTmp2
5058:             ENDIF
5059:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "TmpTmp2")
5060: 
5061:             IF loc_nResultado < 1
5062:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpTmp2)")
5063:             ELSE
5064:                 IF USED(loc_cCursor)
5065:                     SELECT TmpTmp2
5066:                     SCAN
5067:                         SCATTER MEMVAR
5068:                         m.Flag = .T.
5069:                         INSERT INTO (loc_cCursor) FROM MEMVAR
5070:                     ENDSCAN
5071:                 ENDIF
5072:             ENDIF
5073: 
5074:             IF USED(loc_cCursor)
5075:                 SELECT (loc_cCursor)
5076:                 SET ORDER TO EmpGruCon
5077:             ENDIF
5078:         CATCH TO loc_oErro
5079:             THIS.this_cMensagemErro = loc_oErro.Message
5080:             MsgErro(loc_oErro.Message + CHR(13) + ;
5081:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasCadastro")
5082:         ENDTRY
5083:     ENDPROC
5084: 
5085:     *==========================================================================
5086:     * CarregarLinhasConsulta - Tipo='CONSULTA' (dump 2886-3080): chamado
5087:     * do SigPrRet (reimpressao de etiquetas). O mais complexo dos seis -
5088:     * depende de uma bateria de memvars PRIVATE/PUBLIC que o CHAMADOR
5089:     * seta antes do DO FORM (mesmo padrao de guarda TYPE()!='U' que o
5090:     * proprio Init legado ja usa para pcGdeGrupo/pcCol).

*-- Linhas 5114 a 5132:
5114:               loc_cIndustria, loc_nNumero, loc_nNumerof, loc_cCdProduto, ;
5115:               loc_cGrEstoque, loc_cEstoque, loc_cLocaliza, loc_cGrupo, ;
5116:               loc_cSgrus, loc_cColecoes, loc_cPromos, loc_nQtdEti, ;
5117:               loc_nOptMarca, loc_cLinha, loc_cDepto, loc_cQuery, ;
5118:               loc_nResultado, loc_nBrI, loc_nBrF, loc_cDtI, loc_cDtF, ;
5119:               loc_cOpIn, loc_cOpFim, loc_nQtd, loc_oErro
5120: 
5121:         loc_cCursor = THIS.this_cCursorEtiquetas
5122: 
5123:         THIS.grd_4c_Dados.Column4.ReadOnly = .T.
5124: 
5125:         *-- Memvars PRIVATE/PUBLIC do chamador (SigPrRet) - guarda TYPE()
5126:         *-- igual ao Init legado para pcGdeGrupo/pcCol (2598-2604).
5127:         loc_cGdeGrupo  = IIF(TYPE("pcGdeGrupo")  != "U", pcGdeGrupo,  SPACE(3))
5128:         loc_cCol       = IIF(TYPE("pcCol")       != "U", pcCol,       SPACE(3))
5129:         loc_cOperacao  = IIF(TYPE("pcOperacao")  != "U", pcOperacao,  "")
5130:         loc_nEtiqIni   = IIF(TYPE("pnEtiqIni")   != "U", pnEtiqIni,   0)
5131:         loc_nEtiqFim   = IIF(TYPE("pnEtiqFim")   != "U", pnEtiqFim,   0)
5132:         loc_dDtInicial = IIF(TYPE("pdDtInicial") != "U", pdDtInicial, {})

*-- Linhas 5152 a 5238:
5152:             IF EMPTY(loc_cOperacao)
5153:                 loc_nBrI = loc_nEtiqIni
5154:                 loc_nBrF = IIF(EMPTY(loc_nEtiqFim), 99999999999999, loc_nEtiqFim)
5155:                 loc_cDtI = IIF(EMPTY(loc_dDtInicial), "", FormatarDataSQL(loc_dDtInicial))
5156:                 loc_cDtF = IIF(EMPTY(loc_dDtFinal), "", FormatarDataSQL(DTOT(loc_dDtFinal) + 86399))
5157: 
5158:                 loc_cOpIn  = IIF(EMPTY(loc_cEmpresa), go_4c_Sistema.cCodEmpresa, loc_cEmpresa) + ;
5159:                              loc_cIndustria + STR(loc_nNumero, 6)
5160:                 loc_cOpFim = IIF(EMPTY(loc_cEmpresa), go_4c_Sistema.cCodEmpresa, loc_cEmpresa) + ;
5161:                              loc_cIndustria + STR(loc_nNumerof, 6)
5162: 
5163:                 IF EMPTY(loc_cCol) AND EMPTY(loc_cGrupo) AND EMPTY(loc_cColecoes) AND EMPTY(loc_cPromos)
5164:                     loc_cQuery = "SELECT b.*, a.pvens, a.precode, a.cGrus, a.Categoria " + ;
5165:                         "FROM SigOpEtq b JOIN SigCdpro a ON a.cpros = b.cpros WHERE " + ;
5166:                         IIF(EMPTY(loc_nBrI), "", "b.CBars BETWEEN " + TRANSFORM(loc_nBrI) + " AND " + TRANSFORM(loc_nBrF) + " AND ") + ;
5167:                         IIF(EMPTY(loc_dDtInicial), "", "b.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + " AND ") + ;
5168:                         IIF(EMPTY(loc_cEmpresa), "", "b.Empos = " + EscaparSQL(loc_cEmpresa) + " AND ") + ;
5169:                         IIF(EMPTY(loc_cCdProduto), "", "b.Cpros = " + EscaparSQL(loc_cCdProduto) + " AND ") + ;
5170:                         IIF(EMPTY(loc_cGrEstoque), "", "b.Grupos = " + EscaparSQL(loc_cGrEstoque) + " AND ") + ;
5171:                         IIF(EMPTY(loc_cEstoque), "", "b.Contas = " + EscaparSQL(loc_cEstoque) + " AND ") + ;
5172:                         IIF(EMPTY(loc_cLocaliza), "", "b.Localizas = " + EscaparSQL(loc_cLocaliza) + " AND ") + ;
5173:                         "NOT b.Grupos = '" + SPACE(10) + "' AND NOT b.Contas = '" + SPACE(10) + "' " + ;
5174:                         IIF(EMPTY(loc_cIndustria), "", "AND b.empdopnums BETWEEN " + EscaparSQL(loc_cOpIn) + " AND " + EscaparSQL(loc_cOpFim))
5175:                 ELSE
5176:                     loc_cQuery = "SELECT a.*, b.pvens, b.precode, b.cGrus, b.Categoria " + ;
5177:                         "FROM SigOpEtq a, SigCdPro b " + ;
5178:                         IIF(EMPTY(loc_cPromos), "", "INNER JOIN SigPrPmi p ON b.cpros = p.cpros ") + ;
5179:                         "WHERE a.CPros = b.CPros " + ;
5180:                         IIF(EMPTY(loc_nBrI), "", "AND a.CBars BETWEEN " + TRANSFORM(loc_nBrI) + " AND " + TRANSFORM(loc_nBrF) + " ") + ;
5181:                         IIF(EMPTY(loc_dDtInicial), "", "AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + " ") + ;
5182:                         IIF(EMPTY(loc_cCol), "", "AND b.Colecoes = " + EscaparSQL(loc_cCol) + " ") + ;
5183:                         IIF(EMPTY(loc_cGrupo), "", "AND b.Cgrus = " + EscaparSQL(loc_cGrupo) + " ") + ;
5184:                         IIF(EMPTY(loc_cSgrus), "", "AND b.Sgrus = " + EscaparSQL(loc_cSgrus) + " ") + ;
5185:                         IIF(EMPTY(loc_cColecoes), "", "AND b.Colecoes = " + EscaparSQL(loc_cColecoes) + " ") + ;
5186:                         IIF(EMPTY(loc_cEmpresa), "", "AND a.Empos = " + EscaparSQL(loc_cEmpresa) + " ") + ;
5187:                         IIF(EMPTY(loc_cCdProduto), "", "AND a.CPros = " + EscaparSQL(loc_cCdProduto) + " ") + ;
5188:                         IIF(EMPTY(loc_cGrEstoque), "", "AND a.Grupos = " + EscaparSQL(loc_cGrEstoque) + " ") + ;
5189:                         IIF(EMPTY(loc_cEstoque), "", "AND a.Contas = " + EscaparSQL(loc_cEstoque) + " ") + ;
5190:                         IIF(EMPTY(loc_cLocaliza), "", "AND a.Localizas = " + EscaparSQL(loc_cLocaliza) + " ") + ;
5191:                         IIF(EMPTY(loc_cPromos), "", "AND p.Promos = " + EscaparSQL(loc_cPromos) + " ") + ;
5192:                         "AND NOT a.Grupos = '" + SPACE(10) + "' AND NOT a.Contas = '" + SPACE(10) + "' " + ;
5193:                         IIF(EMPTY(loc_cIndustria), "", "AND a.empdopnums BETWEEN " + EscaparSQL(loc_cOpIn) + " AND " + EscaparSQL(loc_cOpFim))
5194:                 ENDIF
5195: 
5196:                 IF USED("TmpEti")
5197:                     USE IN TmpEti
5198:                 ENDIF
5199:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "TmpEti")
5200: 
5201:                 IF loc_nResultado < 1
5202:                     MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpEti - 1)")
5203:                 ELSE
5204:                     loc_nQtd = 0
5205: 
5206:                     SELECT TmpEti
5207:                     SCAN
5208:                         IF USED("LocalPro")
5209:                             USE IN LocalPro
5210:                         ENDIF
5211:                         SQLEXEC(gnConnHandle, "SELECT CGrus, Linhas, Locals, Colecoes, Reffs, Categoria " + ;
5212:                             "FROM SigCdPro WHERE CPros = " + EscaparSQL(TmpEti.Cpros), "LocalPro")
5213: 
5214:                         IF !USED("LocalPro") OR EOF("LocalPro")
5215:                             LOOP
5216:                         ENDIF
5217: 
5218:                         IF !EMPTY(loc_cGdeGrupo)
5219:                             IF USED("LocalGru")
5220:                                 USE IN LocalGru
5221:                             ENDIF
5222:                             SQLEXEC(gnConnHandle, "SELECT CGrus, Mercs FROM SigCdGrp WHERE CGrus = " + ;
5223:                                 EscaparSQL(LocalPro.CGrus), "LocalGru")
5224: 
5225:                             IF !USED("LocalGru") OR EOF("LocalGru") OR LocalGru.Mercs != loc_cGdeGrupo
5226:                                 LOOP
5227:                             ENDIF
5228:                         ENDIF
5229: 
5230:                         IF !EMPTY(loc_cGrupo) AND LocalPro.CGrus != loc_cGrupo
5231:                             LOOP
5232:                         ENDIF
5233: 
5234:                         IF !EMPTY(loc_cColecoes) AND LocalPro.Colecoes != loc_cColecoes
5235:                             LOOP
5236:                         ENDIF
5237: 
5238:                         IF !EMPTY(loc_cCol) AND LocalPro.Colecoes != loc_cCol

*-- Linhas 5253 a 5381:
5253: 
5254:                         loc_nQtd = loc_nQtd + 1
5255: 
5256:                         SELECT TmpEti
5257:                         SCATTER MEMVAR
5258:                         m.EmpDopNums = SPACE(29)
5259:                         m.Reffs      = LocalPro.Reffs
5260:                         m.cGrus      = LocalPro.cGrus
5261:                         m.Categoria  = LocalPro.Categoria
5262: 
5263:                         IF USED(loc_cCursor)
5264:                             INSERT INTO (loc_cCursor) FROM MEMVAR
5265:                             IF loc_nOptMarca = 1
5266:                                 REPLACE Flag WITH .T. IN (loc_cCursor)
5267:                             ENDIF
5268:                         ENDIF
5269: 
5270:                         SELECT TmpEti
5271:                     ENDSCAN
5272:                 ENDIF
5273:             ELSE
5274:                 loc_cOpIn  = IIF(EMPTY(loc_cEmpresa), go_4c_Sistema.cCodEmpresa, loc_cEmpresa) + ;
5275:                              loc_cOperacao + STR(loc_nNumero, 6)
5276:                 loc_cOpFim = IIF(EMPTY(loc_cEmpresa), go_4c_Sistema.cCodEmpresa, loc_cEmpresa) + ;
5277:                              loc_cOperacao + STR(loc_nNumerof, 6)
5278: 
5279:                 IF USED("LocalOpe")
5280:                     USE IN LocalOpe
5281:                 ENDIF
5282:                 SQLEXEC(gnConnHandle, "SELECT CtrlLotes, Abrevs, Globalizas FROM SigCdOpe WHERE Dopes = " + ;
5283:                     EscaparSQL(loc_cOperacao), "LocalOpe")
5284: 
5285:                 IF USED("LocalOpe") AND !EOF("LocalOpe") AND INLIST(LocalOpe.CtrlLotes, 1, 2) AND .F.
5286:                     *-- CODIGO MORTO no legado (AND .F. sempre anula) -
5287:                     *-- transcrito literal, nunca executa.
5288:                     IF USED("TprMvCab")
5289:                         USE IN TprMvCab
5290:                     ENDIF
5291:                     SQLEXEC(gnConnHandle, "SELECT Emps, Dopes, Numes, EmpDopNums FROM SigMvCab " + ;
5292:                         "WHERE EmpDopNums BETWEEN " + EscaparSQL(loc_cOpIn) + " AND " + EscaparSQL(loc_cOpFim), ;
5293:                         "TprMvCab")
5294: 
5295:                     IF USED("TprMvCab")
5296:                         SELECT TprMvCab
5297:                         SCAN
5298:                             IF USED(loc_cCursor)
5299:                                 INSERT INTO (loc_cCursor) (Cpros, Qtds, CBars, ObsEtiqs, Dopes, EmpDopNums) ;
5300:                                     VALUES (LocalParam.Ouros, 1, TprMvCab.Numes, ;
5301:                                         LocalOpe.Abrevs + "-" + TRANSFORM(TprMvCab.Numes, "@L 999999"), ;
5302:                                         TprMvCab.Dopes, TprMvCab.EmpDopNums)
5303: 
5304:                                 IF loc_nOptMarca = 1
5305:                                     REPLACE Flag WITH .T. IN (loc_cCursor)
5306:                                 ENDIF
5307:                             ENDIF
5308:                         ENDSCAN
5309:                     ENDIF
5310:                 ELSE
5311:                     IF USED("TprMvCabI")
5312:                         USE IN TprMvCabI
5313:                     ENDIF
5314:                     SQLEXEC(gnConnHandle, "SELECT b.CodBarras AS BarraB, a.CodBarras AS BarraA, " + ;
5315:                         "a.Units, a.Moedas, a.EmpdopNums, p.Reffs, a.Opers, p.PrecoDe, p.cGrus, p.Categoria " + ;
5316:                         "FROM SigMvItn a " + ;
5317:                         "LEFT JOIN SigMvIts b ON b.EmpDopNums = a.EmpDopNums AND b.CItens = a.CItens " + ;
5318:                         "LEFT JOIN SigCdPro p ON a.Cpros = p.cpros " + ;
5319:                         "WHERE a.EmpDopNums BETWEEN " + EscaparSQL(loc_cOpIn) + " AND " + EscaparSQL(loc_cOpFim), ;
5320:                         "TprMvCabI")
5321: 
5322:                     IF USED("TprMvCabI")
5323:                         IF USED("csItens")
5324:                             USE IN csItens
5325:                         ENDIF
5326:                         SELECT NVL(BarraB, BarraA) AS CodBarras, Units, Moedas, EmpDopNums, Reffs, Opers, ;
5327:                                 PrecoDe, cgrus, Categoria ;
5328:                             FROM TprMvCabI ;
5329:                             INTO CURSOR csItens
5330: 
5331:                         SELECT csItens
5332:                         SCAN
5333:                             IF !EMPTY(csItens.CodBarras) AND !ISNULL(csItens.CodBarras)
5334:                                 IF USED("LocalEti")
5335:                                     USE IN LocalEti
5336:                                 ENDIF
5337:                                 SQLEXEC(gnConnHandle, "SELECT * FROM SigOpEtq WHERE CBars = " + ;
5338:                                     TRANSFORM(csItens.CodBarras), "LocalEti")
5339: 
5340:                                 IF USED("LocalEti") AND !EOF("LocalEti")
5341:                                     SELECT LocalEti
5342:                                     SCATTER MEMVAR
5343:                                     m.pvens      = csItens.Units
5344:                                     m.Moedas     = csItens.Moedas
5345:                                     m.EmpDopNums = csItens.EmpDopNums
5346:                                     m.Reffs      = csItens.Reffs
5347:                                     m.cGrus      = csItens.cGrus
5348:                                     m.Categoria  = csItens.Categoria
5349: 
5350:                                     IF USED(loc_cCursor)
5351:                                         INSERT INTO (loc_cCursor) FROM MEMVAR
5352:                                         IF loc_nOptMarca = 1
5353:                                             REPLACE Flag WITH (csItens.Opers == "E") IN (loc_cCursor)
5354:                                         ENDIF
5355:                                     ENDIF
5356:                                 ENDIF
5357:                             ENDIF
5358: 
5359:                             SELECT csItens
5360:                         ENDSCAN
5361:                     ENDIF
5362:                 ENDIF
5363:             ENDIF
5364: 
5365:             IF USED(loc_cCursor)
5366:                 SELECT (loc_cCursor)
5367:                 DO CASE
5368:                 CASE THIS.this_nOrdemImp = 1
5369:                     SET ORDER TO Cpros
5370:                 CASE THIS.this_nOrdemImp = 2
5371:                     SET ORDER TO CBars
5372:                 CASE THIS.this_nOrdemImp = 3
5373:                     SET ORDER TO EmpDopNums
5374:                 CASE THIS.this_nOrdemImp = 4
5375:                     SET ORDER TO RefFor
5376:                 CASE THIS.this_nOrdemImp = 5
5377:                     SET ORDER TO CatGru
5378:                 ENDCASE
5379:             ENDIF
5380:         CATCH TO loc_oErro
5381:             THIS.this_cMensagemErro = loc_oErro.Message

*-- Linhas 5414 a 5488:
5414:             IF USED("crImpre")
5415:                 USE IN crImpre
5416:             ENDIF
5417:             CREATE CURSOR crImpre (impres C(50))
5418: 
5419:             IF loc_nPrinters <= 0
5420:                 THIS.this_cMensagemErro = "N" + CHR(227) + "o Foi Encontrada Nenhuma Impressora!!!"
5421:                 MsgAviso(THIS.this_cMensagemErro, "")
5422:             ELSE
5423:                 FOR loc_nI = 1 TO loc_nPrinters
5424:                     INSERT INTO crImpre (impres) VALUES (UPPER(loc_aPrinters[loc_nI, 1]))
5425:                 ENDFOR
5426: 
5427:                 loc_cSQL = "SELECT b.impres, b.ntpimpres FROM SigSyImp a, SigCdmp b " + ;
5428:                            "WHERE a.usuacess = " + EscaparSQL(gc_4c_UsuarioLogado) + " AND a.cimps = b.impres " + ;
5429:                            "UNION ALL " + ;
5430:                            "SELECT c.impres, c.ntpimpres FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
5431:                            "WHERE a.usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + " " + ;
5432:                            "AND a.grupos = b.gracess AND b.cimps = c.impres"
5433: 
5434:                 IF USED("cursor_4c_ImpressorasTemp")
5435:                     USE IN cursor_4c_ImpressorasTemp
5436:                 ENDIF
5437:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpressorasTemp")
5438: 
5439:                 IF USED("crSigCdmp")
5440:                     USE IN crSigCdmp
5441:                 ENDIF
5442: 
5443:                 IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ImpressorasTemp") > 0
5444:                     SELECT impres, ntpimpres FROM cursor_4c_ImpressorasTemp ;
5445:                         INTO CURSOR crSigCdmp READWRITE
5446:                 ELSE
5447:                     CREATE CURSOR crSigCdmp (impres C(50), ntpimpres N(4, 0))
5448:                 ENDIF
5449: 
5450:                 IF USED("cursor_4c_ImpressorasTemp")
5451:                     USE IN cursor_4c_ImpressorasTemp
5452:                 ENDIF
5453: 
5454:                 IF USED("crImp")
5455:                     USE IN crImp
5456:                 ENDIF
5457: 
5458:                 SELECT PADR(ALLTRIM(a.impres), 15) + " " + ALLTRIM(b.impres) AS IDupla, ;
5459:                        b.impres, a.impres AS impresS ;
5460:                     FROM crSigCdmp a, crImpre b ;
5461:                     WHERE ALLTRIM(UPPER(a.impres)) LIKE "%" + ALLTRIM(UPPER(b.impres)) + "%" OR ;
5462:                           ALLTRIM(UPPER(b.impres)) LIKE "%" + ALLTRIM(UPPER(a.impres)) + "%" ;
5463:                     GROUP BY b.impres, a.impres ;
5464:                     INTO CURSOR crImp READWRITE
5465: 
5466:                 IF RECCOUNT("crImp") > 1
5467:                     APPEND BLANK
5468:                 ENDIF
5469: 
5470:                 IF USED("crImpreV")
5471:                     USE IN crImpreV
5472:                 ENDIF
5473:                 SELECT * FROM crImp ORDER BY 1 INTO CURSOR crImpreV READWRITE
5474: 
5475:                 THIS.this_nTotalImpressoras = RECCOUNT("crImpreV")
5476: 
5477:                 IF USED("crImpreV")
5478:                     GO TOP IN crImpreV
5479:                     THIS.cbo_4c_Get_Printer.Value         = RECNO("crImpreV")
5480:                     THIS.cbo_4c_Get_Printer.RowSourceType = 2
5481:                     THIS.cbo_4c_Get_Printer.RowSource     = "crImpreV"
5482:                     THIS.cbo_4c_Get_Printer.Refresh()
5483:                 ENDIF
5484: 
5485:                 loc_lSucesso = .T.
5486:             ENDIF
5487:         CATCH TO loc_oErro
5488:             THIS.this_cMensagemErro = loc_oErro.Message

*-- Linhas 5557 a 5575:
5557: 
5558:         IF THIS.ObterTipoChamador() == "DIGITACAO"
5559:             IF USED(loc_cCursor)
5560:                 SELECT (loc_cCursor)
5561:                 SET ORDER TO
5562:                 APPEND BLANK
5563:             ENDIF
5564: 
5565:             THIS.grd_4c_Dados.Column4.ReadOnly = .F.
5566:             THIS.grd_4c_Dados.Column4.SetFocus()
5567:         ELSE
5568:             THIS.grd_4c_Dados.SetFocus()
5569:         ENDIF
5570:     ENDPROC
5571: 
5572: ENDDEFINE
5573: 
5574: *==============================================================================
5575: * TextBoxCodBarrasIpE_4c - subclasse de TextBox para a Column4 (codigo de


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

