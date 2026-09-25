# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (11)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, EMPDOPNUMS, CPROS, IF, ICLIS, I, EMPGRUESTS, CODCORS, CODTAMS, SQTDS, NIVELS, CNIVELS, CRSUBNIVE, CEMPS, EMPS, 0, NUMES, UNITS, XNF, USUARIOS, CCARGS, JOBS, DATAS, SITUAS, DTCOTAS, COTACAOS, COTREQGER, FRETES, QTDADQS, DTVALIDS, CHKAPROVS, GRADES, CITENS, ICL, SERIES, CHKSUBN, DOPES, CUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, EMPDOPNUMS, CPROS, IF, ICLIS, I, EMPGRUESTS, CODCORS, CODTAMS, SQTDS, NIVELS, CNIVELS, CRSUBNIVE, CEMPS, EMPS, 0, NUMES, UNITS, XNF, USUARIOS, CCARGS, JOBS, DATAS, SITUAS, DTCOTAS, COTACAOS, COTREQGER, FRETES, QTDADQS, DTVALIDS, CHKAPROVS, GRADES, CITENS, ICL, SERIES, CHKSUBN, DOPES, CUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, EMPDOPNUMS, CPROS, IF, ICLIS, I, EMPGRUESTS, CODCORS, CODTAMS, SQTDS, NIVELS, CNIVELS, CRSUBNIVE, CEMPS, EMPS, 0, NUMES, UNITS, XNF, USUARIOS, CCARGS, JOBS, DATAS, SITUAS, DTCOTAS, COTACAOS, COTREQGER, FRETES, QTDADQS, DTVALIDS, CHKAPROVS, GRADES, CITENS, ICL, SERIES, CHKSUBN, DOPES, CUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MARCA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, EMPDOPNUMS, CPROS, IF, ICLIS, I, EMPGRUESTS, CODCORS, CODTAMS, SQTDS, NIVELS, CNIVELS, CRSUBNIVE, CEMPS, EMPS, 0, NUMES, UNITS, XNF, USUARIOS, CCARGS, JOBS, DATAS, SITUAS, DTCOTAS, COTACAOS, COTREQGER, FRETES, QTDADQS, DTVALIDS, CHKAPROVS, GRADES, CITENS, ICL, SERIES, CHKSUBN, DOPES, CUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VALADQS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, EMPDOPNUMS, CPROS, IF, ICLIS, I, EMPGRUESTS, CODCORS, CODTAMS, SQTDS, NIVELS, CNIVELS, CRSUBNIVE, CEMPS, EMPS, 0, NUMES, UNITS, XNF, USUARIOS, CCARGS, JOBS, DATAS, SITUAS, DTCOTAS, COTACAOS, COTREQGER, FRETES, QTDADQS, DTVALIDS, CHKAPROVS, GRADES, CITENS, ICL, SERIES, CHKSUBN, DOPES, CUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CURSOR_4C_SUBNIVE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, EMPDOPNUMS, CPROS, IF, ICLIS, I, EMPGRUESTS, CODCORS, CODTAMS, SQTDS, NIVELS, CNIVELS, CRSUBNIVE, CEMPS, EMPS, 0, NUMES, UNITS, XNF, USUARIOS, CCARGS, JOBS, DATAS, SITUAS, DTCOTAS, COTACAOS, COTREQGER, FRETES, QTDADQS, DTVALIDS, CHKAPROVS, GRADES, CITENS, ICL, SERIES, CHKSUBN, DOPES, CUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHKLIMOPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, EMPDOPNUMS, CPROS, IF, ICLIS, I, EMPGRUESTS, CODCORS, CODTAMS, SQTDS, NIVELS, CNIVELS, CRSUBNIVE, CEMPS, EMPS, 0, NUMES, UNITS, XNF, USUARIOS, CCARGS, JOBS, DATAS, SITUAS, DTCOTAS, COTACAOS, COTREQGER, FRETES, QTDADQS, DTVALIDS, CHKAPROVS, GRADES, CITENS, ICL, SERIES, CHKSUBN, DOPES, CUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'FPAGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, EMPDOPNUMS, CPROS, IF, ICLIS, I, EMPGRUESTS, CODCORS, CODTAMS, SQTDS, NIVELS, CNIVELS, CRSUBNIVE, CEMPS, EMPS, 0, NUMES, UNITS, XNF, USUARIOS, CCARGS, JOBS, DATAS, SITUAS, DTCOTAS, COTACAOS, COTREQGER, FRETES, QTDADQS, DTVALIDS, CHKAPROVS, GRADES, CITENS, ICL, SERIES, CHKSUBN, DOPES, CUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, EMPDOPNUMS, CPROS, IF, ICLIS, I, EMPGRUESTS, CODCORS, CODTAMS, SQTDS, NIVELS, CNIVELS, CRSUBNIVE, CEMPS, EMPS, 0, NUMES, UNITS, XNF, USUARIOS, CCARGS, JOBS, DATAS, SITUAS, DTCOTAS, COTACAOS, COTREQGER, FRETES, QTDADQS, DTVALIDS, CHKAPROVS, GRADES, CITENS, ICL, SERIES, CHKSUBN, DOPES, CUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, EMPDOPNUMS, CPROS, IF, ICLIS, I, EMPGRUESTS, CODCORS, CODTAMS, SQTDS, NIVELS, CNIVELS, CRSUBNIVE, CEMPS, EMPS, 0, NUMES, UNITS, XNF, USUARIOS, CCARGS, JOBS, DATAS, SITUAS, DTCOTAS, COTACAOS, COTREQGER, FRETES, QTDADQS, DTVALIDS, CHKAPROVS, GRADES, CITENS, ICL, SERIES, CHKSUBN, DOPES, CUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, EMPDOPNUMS, CPROS, IF, ICLIS, I, EMPGRUESTS, CODCORS, CODTAMS, SQTDS, NIVELS, CNIVELS, CRSUBNIVE, CEMPS, EMPS, 0, NUMES, UNITS, XNF, USUARIOS, CCARGS, JOBS, DATAS, SITUAS, DTCOTAS, COTACAOS, COTREQGER, FRETES, QTDADQS, DTVALIDS, CHKAPROVS, GRADES, CITENS, ICL, SERIES, CHKSUBN, DOPES, CUN

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
  Column1.ControlSource = "crCotaPends.Codigos"
  Column2.ControlSource = "crCotaPends.DtSolics"
  Column3.ControlSource = "crCotaPends.Solicitas"
  Column4.ControlSource = "crCotaPends.Deptos"
  Column5.ControlSource = "crCotaPends.Prioris"
  Column6.ControlSource = "crCotaPends.DtCotas"
  DeleteMark = .F.
  Column1.ControlSource = "crOperacoes.Marcas"
  Column2.ControlSource = "crOperacoes.Datas"
  Column3.ControlSource = "crOperacoes.Emps"
  Column4.ControlSource = "crOperacoes.Dopes"
  Column5.ControlSource = "crOperacoes.Numes"
  Column6.ControlSource = "crOperacoes.Itens"
  ControlSource = "crSigCtTDc.ContaEs"
  ControlSource = "crSigCtTDc.Justificas"
  ControlSource = "crSigCtTDc.Aprovador"
  ControlSource = "crSigCtTDc.DtAprovs"
  ControlSource = "crSigCtTDc.ObsAprovs"
  ControlSource = "crSigCtTDc.ChkAprovs"
  ControlSource = "crSigCtTDc.AprSols"
  ControlSource = "crSigCtTDc.DtAprSols"
  ControlSource = "crSigCtTDc.ObsAprSols"
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
  Column20.ControlSource = ""
  Column21.ControlSource = ""
  Column22.ControlSource = ""
  Column23.ControlSource = ""
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column8.ControlSource = ""
  Column9.ControlSource = ""
  ControlSource = "crSigCtTCt.Obs"
  ControlSource = "crSigCtTCt.Justificas"
  ControlSource = "crSigCtTDc.Prioris"
  ControlSource = "crSigCtTCt.DPros"
  ControlSource = "crSigCtTDc.Solicitas"
  ControlSource = "crSigCtTDc.Deptos"
  ControlSource = "crSigCtTDc.DtSolics"
  ControlSource = "crSigCtTDc.DtCotas"
  ControlSource = "crSigCtTDc.DtValids"
  ControlSource = "crSigCtTDc.DtPagtos"
  ControlSource = "crSigCtTDc.Comprador"
  ControlSource = "crSigCtTDc.Codigos"
  ControlSource = "crSigCtTDc.Aprovador"
  ControlSource = "crSigCtTDc.Copias"
  Column1.ControlSource = "crCabOperas.Numes"
  Column2.ControlSource = "crCabOperas.IFors"
  Column3.ControlSource = "crCabOperas.Fornecs"
  Column4.ControlSource = "crCabOperas.FPags"
  Column5.ControlSource = "crCabOperas.DtEnts"
  Column6.ControlSource = "crCabOperas.Qtds"
  Column7.ControlSource = "crCabOperas.Valors"
  Column8.ControlSource = "Left(crCabOperas.Fretes, 1)"
  Column9.ControlSource = "crCabOperas.VlFretes"
  Column1.ControlSource = "crItnOperas.CItens"
  Column2.ControlSource = "crItnOperas.CPros"
  Column3.ControlSource = "crItnOperas.DPros"
  Column4.ControlSource = "crItnOperas.CUnis"
  Column5.ControlSource = "crItnOperas.Qtds"
  Column6.ControlSource = "crItnOperas.Units"
  Column7.ControlSource = "crItnOperas.Valors"
  Column8.ControlSource = "crItnOperas.CodCors"
  Column9.ControlSource = "crItnOperas.CodTams"
  ControlSource = ""
  ControlSource = ""
Select crCotaPends
oTop.Update(.t.)
oTop.Update(.t.)
lcQuery = [Select * ] + ;
		    [From SigCtTDc ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotDc]) < 1)
Select LocalCotDc
	Insert Into crSigCtTDc From Memvar
oTop.Update(.t.)
lcQuery = [Select * ] + ;
		    [From SigCtTFn ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotFn]) < 1)
Select LocalCotFn
	Insert Into crSigCtTFn From Memvar
oTop.Update(.t.)
lcQuery = [Select * ] + ;
		    [From SigCtTCt ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotCt]) < 1)
Select LocalCotCt
	Insert Into crSigCtTCt From Memvar
Select crSigCtTDc
	Select crSigCtTFn
	Select crSigCtTDc
	Select crSigCtTCt
	lcQuery = [Select Jobs From SigMvCab Where EmpDopNums = '] + crSigCtTCt.EmpDopNums + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalMvCab]) < 1)
Select [Soma] as Soma, Sum(Valors) as Valors ;
  From crCabOperas ;
Select crSoma
lcQuery = [Select a.Codigos, a.CItens, a.CPros, a.EmpDopNums, a.QtdAdqs, a.ValAdqs, a.Justificas, a.Obs, ] + ;
			[From SigCtTCt a, SigCtTDc b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crAnterior]) < 1)
Select crAnterior
Update crAnterior Set DtAprovs = Nvl(DtAprovs, Ctot([]))
		lcQuery = [Select * ] + ;
				    [From SigCtTFn ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotFn]) < 1)
		Select LocalCotFn
			Select crSigCtTFn
				Select crSigCtTFn
						Select LocalCotFn
						Select crSigCtTFn
			Insert Into crJustAnts (Linha) Values (lcJus)
oTop.Update(.t.)
lcQuery = [Select * ] + ;
		    [From SigCtTPc a ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotPc]) < 1)
Select LocalCotPc
	lcQuery = [Select * ] + ;
			    [From SigCtTPe a ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotPe]) < 1)
	Select LocalCotPe
		Insert Into crCabOperas (Numes, IFors, Fornecs, FPags, DtEnts, Qtds, Valors, Fretes, VlFretes) ;
	lcQuery = [Select * ] + ;
			    [From SigCtTPi a ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotPi]) < 1)
	Select LocalCotPi
		Insert Into crItnOperas (CItens, Numes, CPros, DPros, CodCors, CodTams, CUnis, Obs, Qtds, Units, Valors) ;
Select crCabOperas
	Select crCabOperas
Select crCotaPends
oTop.Update(.t.)
oTop.Update(.t.)
lcQuery = [Select * ] + ;
		    [From SigCtTDc ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotDc]) < 1)
Select LocalCotDc
	Insert Into crSigCtTDc From Memvar
oTop.Update(.t.)
lcQuery = [Select * ] + ;
		    [From SigCtTFn ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotFn]) < 1)
Select LocalCotFn
	Insert Into crSigCtTFn From Memvar
oTop.Update(.t.)
lcQuery = [Select * ] + ;
		    [From SigCtTCt ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotCt]) < 1)
Select LocalCotCt
	Insert Into crSigCtTCt From Memvar
Select crSigCtTFn
Select crSigCtTDc
Select crSigCtTCt
lcQuery = [Select a.Situas, a.Codigos, a.DtSolics, a.Solicitas, a.Deptos, a.Prioris, a.DtCotas, ] + ;
		    [From SigCtTDc a ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotDc]) < 1)
Select LocalCotDc
Insert Into crCotaPends (Situas, Codigos, DtSolics, Solicitas, Deptos, Prioris, DtCotas, DtAprovs, ;
Select crSigCtTCt
Select CPros ;
  From crSigCtTCt ;
Select CPros ;
  From crSigCtTCt ;
	lcQuery = [Select EmpDopNums ] + ;
				[From SigCtTCt ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotCt]) < 1)
	Select LocalCotCt
		lcQuery = [Update SigMvCab ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (ExcluirProduto - Update - SigMvCab)])
Select crSigCtTCt
Delete In crSigCtTCt
	Select EmpDopNums, Jobs ;
	  From crOperacoes ;
	Select crCotarProds
oTop.Update(.t.)
oTop.Update(.t.)
	Select crCotarProds
		lcQuery = [Select a.Emps, a.Dopes, a.Numes, (b.Qtds - b.QtBaixas) as Qtds, s.CodCors, s.CodTams, ] + ;
				   	[From SigMvCab a ] + ;
				   	[Left Join SigMvItn b On a.EmpDopNums = b.EmpDopNums ] + ;
				   	[Left Join SigCdOpe o On a.Dopes = o.Dopes ] + ;
				   	[Left Join SigCdPro c On b.CPros = c.CPros ] + ;
				   	[Left Join SigCdGrp g On c.CGrus = g.CGrus ] + ;
				   	[Left Join SigMvIts s On b.EmpDopNums + Str(b.CItens, 10) = s.EmpDopNums + Str(s.CItens, 10) ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalDados]) < 1)
		Update LocalDados ;
		Select LocalDados
			lcQuery = [Select a.EmpDopNums, a.CItens, a.Qtds ] + ;
					    [From SigCtTCt a ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotCt]) < 1)
			Select LocalCotCt
					lcQuery = [Select * ] + ;
								[From SigMvEst ] + ;
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalEstoque]) < 1)
						=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GeraCotacao - Update - SigMvCab)])
						Select LocalEstoque
				Insert Into crSigCtTCt (Codigos, CItens, EmpDopNums, CPros, DPros, CodCors, CodTams, Obs, Qtds, CUnis, QtdAdqs, cIdChaves) ;
				lcQuery = [Update SigMvCab ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
					=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GeraCotacao - Update - SigMvCab)])
	Insert Into crSigCtTCt (Codigos, CItens, EmpDopNums, CPros, DPros, Obs, Qtds, CUnis, QtdAdqs, cIdChaves) ;
		Insert Into crSigCtTFn (Codigos, Grades, Fretes, cIdChaves) Values (lnCod, lcLet, [Emitente], fUniqueIds())
	Insert Into crSigCtTDc (Codigos, Solicitas, Deptos, DtSolics, DtCotas, DtValids, DtPagtos, Comprador, Prioris, cIdChaves) ;
	Select crSigCtTCt
Select Distinct Linha ;
  From crJustAnts ;
Select crMontaJus
Select crSigCtTCt
	Select crSigCtTFn
	Select crSigCtTDc
	Select crSigCtTCt
oTop.Update(.t.)
oTop.Update(.t.)
Select crSigCtTCt
		lcQuery = [Select a.IClis, a.Fornecs, a.FPags, a.DtEnts, a.Fretes, a.VlFretes ] + ;
				    [From SigCtTFn a ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotFn]) < 1)
		Select LocalCotFn
				lcQuery = [Select a.IClis, a.RClis ] + ;
						    [From SigCdCli a ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCli]) < 1)
				Select LocalCotFn
			Insert Into crPedidos (IFors, Fornecs, FPags, DtEnts, Cpros, DPros, CUnis, Obs, Qtds, Valors, Fretes, VlFretes, CodCors, CodTams) ;
Select crPedidos
Select crPedidos
	If Not Seek(crPedidos.IFors, [crCabOperas], [IFors])
		Insert Into crCabOperas (Numes, IFors, Fornecs, FPags, DtEnts, Fretes, VlFretes, Jobs) ;
	Insert Into crItnOperas (Numes, CPros, DPros, CodCors, CodTams, CUnis, Obs, Qtds, Units, Valors) ;
Select crItnOperas
lcQuery = [Select a.Dopes, a.GruOrigs, a.GruDests, a.ConDests, a.Opers, a.CMoes, a.NFiscals, ] + ;
			[From SigCdOpe a Inner Join SigOpCdd b On a.Dopes = b.Dopes ] + ;
		  [Select b.CDopes as Dopes, c.GruOrigs, c.GruDests, c.ConDests, c.Opers, c.CMoes, c.NFiscals, ] + ;
			[From SigOpCsn b Inner Join SigCdOpe c On b.CDopes = c.Dopes ] + ;
				[Inner Join SigOpCdd d On b.CDopes = d.Dopes ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalSubs]) < 1)
Select Distinct Dopes, GruOrigs, GruDests, ConDests, Opers, CMoes, NFiscals, ;
  From LocalSubs ;
	lcQuery = [Select a.Dopes, a.GruOrigs, a.GruDests, a.ConDests, a.Opers, a.CMoes, a.NFiscals, ] + ;
				[From SigCdOpe a Inner Join SigOpCdd b On a.Dopes = b.Dopes ]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSubniveis]) < 1)
Select crSubniveis
Select crCotGer
Select crSubniveis
		If !Seek(crSubniveis.dopes,[crCotGer],[Dopes])
			Delete
Select crSubniveis
Select crCabOperas
	Select crCabOperas
oTop.Update(.t.)
Select crSigCtTDc
oTop.Update(.t.)
	Select crSigCtTCt
		lcQuery = [Select Distinct EmpDopNums From SigCtTCt Where Codigos = ] + Alltrim(Str(lnCod, 6))
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crApagar]) < 1)
	lcQuery = [Delete From SigCtTDc Where Codigos = ] + Alltrim(Str(lnCod, 6))
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
	lcQuery = [Delete From SigCtTFn Where Codigos = ] + Alltrim(Str(lnCod, 6))
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
	lcQuery = [Delete From SigCtTCt Where Codigos = ] + Alltrim(Str(lnCod, 6))
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
oTop.Update(.t.)
	Select crApagar
		lcQuery = [Select EmpDopNums ] + ;
					[From SigCtTCt ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotCt]) < 1)
		Select LocalCotCt
			lcQuery = [Update SigMvCab ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
				=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (ExcluirProduto - Update - SigMvCab)])
		If Not ThisForm.poDataMgr.Update([crSigCtTDc])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GravaDados - Update - crSigCtTDc)])
		If Not ThisForm.poDataMgr.Update([crSigCtTFn])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GravaDados - Update - crSigCtTFn)])
		Delete From crSigCtTCt Where Empty(CPros)
		If Not ThisForm.poDataMgr.Update([crSigCtTCt])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GravaDados - Update - crSigCtTCt)])
oTop.Update(.t.)
=Seek(Padr(lcDop, 20), [crSubniveis], [Dopes])
lcQuery = [Select Estas ] + ;
  			[From SigCdEmp ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdEmp]) < 1)
Select crSigCdEmp
	lcQuery = [Select Emps, EspPads, MarPads, Piss, FatBrutos, PesoVols ] + ;
	  			[From SigCnFnf ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCnFnf]) < 1)
	Select crSigCnFnf
		lcQuery = [Select Emps, EspPads, MarPads, Piss, FatBrutos, PesoVols ] + ;
		  			[From SigCnFnf ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCnFnf]) < 1)
		Select crSigCnFnf
	Select crCabOperas
Insert Into crSigCtTPc (Codigos, Datars, Datas, Emps, Dopes, CMoes, GrupoDs, ContaDs, ;
Select crItnOperas
Select crCabOperas
	oTop.Update(.t.)
	Insert Into crSigMvCab (Emps, Dopes, Numes, EmpDopNums, MascNum, Opers, Datas, Datars, DtAlts, ;
	Insert Into crSigCtTPs (Codigos, EmpDopNums, cIdChaves) ;
	Insert Into crSigCtTPe (Codigos, Numes, IFors, Fornecs, FPags, DtEnts, Qtds, Valors, Fretes, VlFretes, cIdChaves) ;
	Select * From crSigMvItn Where 0 = 1 Into Cursor crTpmMvItn ReadWrite
	Select * From crSigMvIts Where 0 = 1 Into Cursor crTpmMvIts ReadWrite
	Select crItnOperas
		Insert Into crTpmMvItn (Emps, Dopes, Numes, EmpDopNums, DtAlts, cIdChaves, CItens, CPros, DPros, Obs, ;
		Insert Into crSigCtTPi (Codigos, CItens, Numes, CPros, DPros, CodCors, CodTams, CUnis, Obs, Qtds, Units, Valors, cIdChaves) ;
			Select crItnOperas
				Insert Into crTpmMvIts (CItens, Emps, Dopes, Numes, Cpros, Qtds, CodCors, CodTams, EmpDopNums, cIdChaves) ;
				Select crItnOperas
			Select crItnOperas
		Select crSigCdSer
		Select crSigCdSer
		Select * From crSigMvNfi Where 0 = 1 Into Cursor xNfis ReadWrite
		Select crSigMvItn
		Append From Dbf([crTpmMvItn])
		Select crSigMvIts
		Append From Dbf([crTpmMvIts])
		Select crSigMvNfi
		Append From Dbf([xNfis])
		Select crSigMvNfi
		Select crSigMvItn
		Append From Dbf([crTpmMvItn])
		Select crSigMvIts
		Append From Dbf([crTpmMvIts])
	Select LocalFPag
			Insert Into crSigMvPar (Emps, Dopes, Numes, EmpDopNums, Datas, cIdChaves, CotFPgs, FPags, MoeFPgs, NOpers, ;
Select crSigMvCab
oTop.Update(.t.)
lcQuery = [Update SigCtTDc ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
	=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GravaPedidos - Update - SigCtTDc)])
	If Not ThisForm.poDataMgr.Update([crSigMvCab])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GravaPedidos - Update - SigMvCab)])
	If Not ThisForm.poDataMgr.Update([crSigMvItn])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GravaPedidos - Update - SigMvItn)])
	If Not ThisForm.poDataMgr.Update([crSigMvIts])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GravaPedidos - Update - SigMvIts)])
	If Not ThisForm.poDataMgr.Update([crSigMvPar])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GravaPedidos - Update - SigMvPar)])
	If Not ThisForm.poDataMgr.Update([crSigMvNfi])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GravaPedidos - Update - SigMvNfi)])
	If Not ThisForm.poDataMgr.Update([crSigCtTPc])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GravaPedidos - Update - SigCtTPc)])
	If Not ThisForm.poDataMgr.Update([crSigCtTPe])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GravaPedidos - Update - SigCtTPe)])
	If Not ThisForm.poDataMgr.Update([crSigCtTPi])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GravaPedidos - Update - SigCtTPi)])
	If Not ThisForm.poDataMgr.Update([crSigCtTPs])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GravaPedidos - Update - SigCtTPs)])
	If Not ThisForm.poDataMgr.Update([cqSigMvCcr])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GravaPedidos - Update - SigMvCcr)])
	If Not ThisForm.poDataMgr.Update([crSigMvCpv])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (GravaPedidos - Update - SigMvCpv)])
Insert Into crCabecalho (Codigos, Comprador, NmComprador, Deptos, DtCotas, DtPagtos, DtSolics, DtValids, Solicitas, ;
Select Grades, IClis, Fornecs, Contatos, Tel1s, FPags, DtEnts, Fretes, VlFretes ;
  From crSigCtTFn ;
Select LocalIFors
Select * ;
  From crSigCtTCt ;
Select LocalCPros
	Select LocalUni
	Insert Into crDetalhe (CPros, DPros, CodCors, CodTams, Obs, Qtds, QtdAdqs, CUnis, DUnis, ValAdqs, ;
Select crDetalhe
lcSql = [Select CCargs From SigCdUsu Where Usuarios = ']+Usuar+[']
If ThisForm.poDataMgr.Sqlexecute(lcSql,'CrSigCdUsu') < 1
lcSql = [Select VlLibOpes From SigCdCrg Where CCargs = ']+CrSigCdUsu.cCargs+[']
If ThisForm.poDataMgr.Sqlexecute(lcSql,'CrTmpCarg') < 1
	.Column1.ControlSource  = [crSigCtTFn.Grades]
	.Column2.ControlSource  = [crSigCtTFn.IClis]
	.Column3.ControlSource  = [crSigCtTFn.Fornecs]
	.Column5.ControlSource  = [crSigCtTFn.Contatos]
	.Column6.ControlSource  = [crSigCtTFn.Tel1s]
	.Column7.ControlSource  = [crSigCtTFn.FPags]
	.Column8.ControlSource  = [crSigCtTFn.DtEnts]
	.Column9.ControlSource  = [crSigCtTFn.Fretes]
	.Column10.ControlSource = [crSigCtTFn.VlFretes]
	.Column1.ControlSource  = [crSigCtTCt.CPros]
	.Column2.ControlSource  = [crSigCtTCt.Qtds]
	.Column3.ControlSource  = [crSigCtTCt.QtdAdqs]
	.Column4.ControlSource  = [crSigCtTCt.CUnis]
	.Column5.ControlSource  = [crSigCtTCt.ValAdqs]
	.Column6.ControlSource  = [crSigCtTCt.Marca01]
	.Column7.ControlSource  = [crSigCtTCt.Unit01]
	.Column8.ControlSource  = [crSigCtTCt.Tota01]
	.Column9.ControlSource  = [crSigCtTCt.Marca02]
	.Column10.ControlSource = [crSigCtTCt.Unit02]
	.Column11.ControlSource = [crSigCtTCt.Tota02]
	.Column12.ControlSource = [crSigCtTCt.Marca03]
	.Column13.ControlSource = [crSigCtTCt.Unit03]
	.Column14.ControlSource = [crSigCtTCt.Tota03]
	.Column15.ControlSource = [crSigCtTCt.Marca04]
	.Column16.ControlSource = [crSigCtTCt.Unit04]
	.Column17.ControlSource = [crSigCtTCt.Tota04]
	.Column18.ControlSource = [crSigCtTCt.Marca05]
	.Column19.ControlSource = [crSigCtTCt.Unit05]
	.Column20.ControlSource = [crSigCtTCt.Tota05]
	.Column21.ControlSource = [crSigCtTCt.Marca06]
	.Column22.ControlSource = [crSigCtTCt.Unit06]
	.Column23.ControlSource = [crSigCtTCt.Tota06]
	.Column24.ControlSource = [crSigCtTCt.CodTams]
	.Column25.ControlSource = [crSigCtTCt.CodCors]
oTop.Update(.t.)
oTop.Update(.t.)
lcQuery = [Select a.Datas, a.Emps, a.Dopes, a.Numes, b.CItens, (b.Qtds - b.QtBaixas) as Qtds, ] + ;
		    [From SigMvCab a, SigMvItn b, SigCdPro c, SigCdOpe d ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalDados]) < 1)
oTop.Update(.t.)
Select LocalDados
	lcQuery = [Select a.EmpDopNums, a.CItens, a.Qtds ] + ;
			    [From SigCtTCt a ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotCt]) < 1)
	Select LocalCotCt	
		Delete In LocalDados
Select LocalDados
	If Not Seek(Dtos(ldDat) + lcEdn, [crOperacoes], [Ordem])
		Insert Into crOperacoes (Emps, Dopes, Numes, Datas, EmpDopNums, Nops, ChkSubn, LCancelas, ChkBxParcs, ;
Select crOperacoes
oTop.Update(.t.)
lcQuery = [Select a.Situas, a.Codigos, a.DtSolics, a.Solicitas, a.Deptos, a.Prioris, a.DtCotas, ] + ;
		    [From SigCtTDc a ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotDc]) < 1)
Select LocalCotDc
	Insert Into crCotaPends (Situas, Codigos, DtSolics, Solicitas, Deptos, Prioris, DtCotas, DtAprovs, ;
Select crOperacoes
	Select crCotaPends
	Select crOperacoes
		lcQuery = [Select a.Dopes, a.Ordes, Str(a.Ndopes, 16, 0) as NDopes ] + ;
					[From SigCdOpe a ] + ;
					[join SigOpCdd b on a.dopes = b.dopes ] + ;
		If (.poDataMgr.SqlExecute(lcQuery, [crCotReq]) < 1)
		Select crCotReq
				Delete
		lcQuery = [Select a.Dopes, a.Ordes, Str(a.Ndopes, 16, 0) as NDopes ] + ;
					[From SigCdOpe a ] + ;
					[join SigOpCdd b on a.dopes = b.dopes ] + ;
		If (.poDataMgr.SqlExecute(lcQuery, [crCotGer]) < 1)
		Select crCotGer
				Delete
		lcQuery = [Select Gesind, MascNums, MoedaPs From SigCdPam]
		If (.poDataMgr.SqlExecute(lcQuery, [crSigCdPam]) < 1)
		Select crSigCdPam
Insert Into crFretes (Fretes) Values ([Emitente])
Insert Into crFretes (Fretes) Values ([Destinatario])
Select crCotReq
		If Not Seek(Padr(This.Value, 20), [crCotReq], [Dopes])
Update crOperacoes Set Marcas = (This.Value = 1)
Update crOperacoes Set Marcas = (This.Value = 1)
	Select EmpDopNums From crOperacoes Where Marcas And Jobs <> lcJob into cursor TmpMarca
	lcQuery = [Select CUnis ] + ;
			    [From SigCdPro ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
	Select crSigCtTCt
	Update crSigCtTCt Set Marca01 = .t. Where Not Empty(Tota01)
	Update crSigCtTCt Set ValAdqs = Tota01 Where Marca01
	Update crSigCtTCt ;
	Update crSigCtTCt Set Marca02 = .t. Where Not Empty(Tota02)
	Update crSigCtTCt Set ValAdqs = Tota02 Where Marca02
	Update crSigCtTCt ;
	Update crSigCtTCt Set Marca03 = .t. Where Not Empty(Tota03)
	Update crSigCtTCt Set ValAdqs = Tota03 Where Marca03
	Update crSigCtTCt ;
	Update crSigCtTCt Set Marca04 = .t. Where Not Empty(Tota04)
	Update crSigCtTCt Set ValAdqs = Tota04 Where Marca04
	Update crSigCtTCt ;
	Update crSigCtTCt Set Marca05 = .t. Where Not Empty(Tota05)
	Update crSigCtTCt Set ValAdqs = Tota05 Where Marca05
	Update crSigCtTCt ;
	Update crSigCtTCt Set Marca06 = .t. Where Not Empty(Tota06)
	Update crSigCtTCt Set ValAdqs = Tota06 Where Marca06
	Update crSigCtTCt ;
	Select crFretes
Select crSigCtTCt
		Delete In crSigCtTCt
Insert Into crSigCtTCt (Codigos, CItens, CPros, DPros, Obs, Qtds, CUnis, QtdAdqs, cIdChaves) ;
Delete In crSigCtTCt
Select crSigCtTCt
		Delete In crSigCtTCt
Insert Into crSigCtTCt (Codigos, CItens, CPros, DPros, Obs, Qtds, CUnis, QtdAdqs, cIdChaves) ;
Select crItnOperas
	If Not Seek(Padr(This.Value, 20), [crSubniveis], [Dopes])

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvcot.prg) - TRECHOS RELEVANTES PARA PASS SQL (9067 linhas total):

*-- Linhas 501 a 521:
501:         IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
502:             loc_oPag.txt_4c_CEmps.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)
503: 
504:             loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
505:                        EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
506:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpPadrao")
507: 
508:             IF loc_nResultado > 0 AND USED("cursor_4c_EmpPadrao") AND !EOF("cursor_4c_EmpPadrao")
509:                 loc_oPag.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_EmpPadrao.Razas)
510:             ENDIF
511: 
512:             IF USED("cursor_4c_EmpPadrao")
513:                 USE IN cursor_4c_EmpPadrao
514:             ENDIF
515: 
516:             loc_oPag.txt_4c_DtPerI.SetFocus()
517:         ENDIF
518:     ENDPROC
519: 
520:     *--------------------------------------------------------------------------
521:     * TeclaCEmps/TeclaDEmps/TeclaDopes/TeclaJob/TeclaDjob - Handlers de

*-- Linhas 584 a 603:
584:             RETURN
585:         ENDIF
586: 
587:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
588:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
589: 
590:         IF loc_nResultado > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
591:             loc_oPag.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
592:         ELSE
593:             loc_oPag.txt_4c_DEmps.Value = ""
594:             THIS.AbrirBuscaEmpresa()
595:         ENDIF
596: 
597:         IF USED("cursor_4c_EmpVal")
598:             USE IN cursor_4c_EmpVal
599:         ENDIF
600:     ENDPROC
601: 
602:     PROCEDURE AbrirBuscaEmpresa()
603:         LOCAL loc_oPag, loc_cValor, loc_oBusca

*-- Linhas 643 a 662:
643:             RETURN
644:         ENDIF
645: 
646:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas = " + EscaparSQL(loc_cValor)
647:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDVal")
648: 
649:         IF loc_nResultado > 0 AND USED("cursor_4c_EmpDVal") AND !EOF("cursor_4c_EmpDVal")
650:             loc_oPag.txt_4c_CEmps.Value = ALLTRIM(cursor_4c_EmpDVal.Cemps)
651:         ELSE
652:             THIS.AbrirBuscaDesEmpresa()
653:         ENDIF
654: 
655:         IF USED("cursor_4c_EmpDVal")
656:             USE IN cursor_4c_EmpDVal
657:         ENDIF
658:     ENDPROC
659: 
660:     PROCEDURE AbrirBuscaDesEmpresa()
661:         LOCAL loc_oPag, loc_cValor, loc_oBusca
662: 

*-- Linhas 706 a 725:
706:             RETURN
707:         ENDIF
708: 
709:         loc_cSQL = "SELECT TOP 1 Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cValor)
710:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeVal")
711: 
712:         IF loc_nResultado > 0 AND USED("cursor_4c_OpeVal") AND !EOF("cursor_4c_OpeVal")
713:             loc_oPag.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_OpeVal.Dopes)
714:         ELSE
715:             THIS.AbrirBuscaOperacao()
716:         ENDIF
717: 
718:         IF USED("cursor_4c_OpeVal")
719:             USE IN cursor_4c_OpeVal
720:         ENDIF
721:     ENDPROC
722: 
723:     PROCEDURE AbrirBuscaOperacao()
724:         LOCAL loc_oPag, loc_cValor, loc_oBusca
725: 

*-- Linhas 754 a 787:
754:     * Job/Conta (SigCdCli.IClis/RClis) - equivalente a fAcessoContas(Usuar,
755:     * Grupo, 'C'/'D', this.Value, getjob, getdjob, ...) do legado, sem grupo
756:     * (fAcessoContas nao usada como lookup UX - ver memoria
757:     * "facessocontas_lookup_ux": substituicao canonica por SELECT direto +
758:     * FormBuscaAuxiliar).
759:     *--------------------------------------------------------------------------
760:     PROCEDURE ValidarJobCodigo()
761:         LOCAL loc_oPag, loc_cValor, loc_cSQL, loc_nResultado
762: 
763:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
764:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_Job.Value)
765: 
766:         IF EMPTY(loc_cValor)
767:             loc_oPag.txt_4c_Djob.Value = ""
768:             RETURN
769:         ENDIF
770: 
771:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cValor)
772:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_JobVal")
773: 
774:         IF loc_nResultado > 0 AND USED("cursor_4c_JobVal") AND !EOF("cursor_4c_JobVal")
775:             loc_oPag.txt_4c_Djob.Value = ALLTRIM(cursor_4c_JobVal.RClis)
776:         ELSE
777:             loc_oPag.txt_4c_Djob.Value = ""
778:             THIS.AbrirBuscaJobCodigo()
779:         ENDIF
780: 
781:         IF USED("cursor_4c_JobVal")
782:             USE IN cursor_4c_JobVal
783:         ENDIF
784:     ENDPROC
785: 
786:     PROCEDURE AbrirBuscaJobCodigo()
787:         LOCAL loc_oPag, loc_cValor, loc_oBusca

*-- Linhas 827 a 846:
827:             RETURN
828:         ENDIF
829: 
830:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RClis = " + EscaparSQL(loc_cValor)
831:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_JobDVal")
832: 
833:         IF loc_nResultado > 0 AND USED("cursor_4c_JobDVal") AND !EOF("cursor_4c_JobDVal")
834:             loc_oPag.txt_4c_Job.Value = ALLTRIM(cursor_4c_JobDVal.IClis)
835:         ELSE
836:             THIS.AbrirBuscaJobDescricao()
837:         ENDIF
838: 
839:         IF USED("cursor_4c_JobDVal")
840:             USE IN cursor_4c_JobDVal
841:         ENDIF
842:     ENDPROC
843: 
844:     PROCEDURE AbrirBuscaJobDescricao()
845:         LOCAL loc_oPag, loc_cValor, loc_oBusca
846: 

*-- Linhas 1011 a 1033:
1011:                 USE IN cursor_4c_Parametros
1012:             ENDIF
1013: 
1014:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1015:                 "SELECT gesind, moedaps FROM SigCdPam", "cursor_4c_Parametros")
1016: 
1017:             IF loc_nResultado > 0 AND USED("cursor_4c_Parametros")
1018:                 SELECT cursor_4c_Parametros
1019:                 GO TOP IN cursor_4c_Parametros
1020:                 IF !EOF("cursor_4c_Parametros")
1021:                     THIS.this_nGesind  = NVL(cursor_4c_Parametros.gesind, 0)
1022:                     THIS.this_cMoedaPs = ALLTRIM(NVL(cursor_4c_Parametros.moedaps, ""))
1023:                 ENDIF
1024:             ENDIF
1025: 
1026:             IF USED("cursor_4c_Parametros")
1027:                 USE IN cursor_4c_Parametros
1028:             ENDIF
1029:         CATCH TO loc_oErro
1030:             MsgErro("Erro ao ler os par" + CHR(226) + "metros do sistema (SigCdPam):" + ;
1031:                 CHR(13) + loc_oErro.Message, "Erro")
1032:         ENDTRY
1033:     ENDPROC

*-- Linhas 1039 a 1080:
1039:     *   crOperacoes  -> cursor_4c_Movimentacao    (grade de Movimentacoes)
1040:     *   crCotaPends  -> grade de Cotacoes Realizadas (grd_4c_CotaPends, cursor local)
1041:     *
1042:     * CREATE CURSOR nasce READWRITE, o que eh pre-requisito para a coluna de
1043:     * marcacao (CheckBox) do grid de Movimentacoes aceitar o REPLACE feito
1044:     * pelos handlers de clique/tecla. Tipos e tamanhos transcritos do legado
1045:     * sem "correcoes" (Nops n(6) e Itens n(6) sao os do Load original).
1046:     *--------------------------------------------------------------------------
1047:     PROTECTED PROCEDURE CriarCursoresLista()
1048:         IF USED("cursor_4c_Movimentacao")
1049:             USE IN cursor_4c_Movimentacao
1050:         ENDIF
1051: 
1052:         CREATE CURSOR cursor_4c_Movimentacao ( ;
1053:             Marcas     L(1),  Emps       C(3),  Dopes      C(20), Numes      N(6), ;
1054:             Datas      D(8),  Itens      N(6),  EmpDopNums C(29), Nops       N(6), ;
1055:             ChkSubn    L(1),  LCancelas  L(1),  ChkBxParcs L(1),  ChkPagos   L(1), ;
1056:             ProcBals   L(1),  ProcDBal   L(1),  Destinos   N(1),  EstDests   N(1), ;
1057:             EstOrigs   N(1),  Origems    N(1),  Produc     N(1),  Jobs       C(10))
1058: 
1059:         INDEX ON DTOS(Datas) + EmpDopNums TAG Ordem
1060: 
1061:         IF USED("cursor_4c_CotasPendentes")
1062:             USE IN cursor_4c_CotasPendentes
1063:         ENDIF
1064: 
1065:         CREATE CURSOR cursor_4c_CotasPendentes ( ;
1066:             Situas     N(1),  Codigos    N(6),  DtSolics   D(8),  Solicitas  C(10), ;
1067:             Deptos     C(10), Prioris    C(10), DtCotas    D(8),  DtAprovs   D(8), ;
1068:             Aprovador  C(10), ContaEs    C(10), LocalEnts  N(10), Justificas M(4), ;
1069:             Copias     N(6))
1070: 
1071:         INDEX ON Codigos TAG Ordem
1072:     ENDPROC
1073: 
1074:     *--------------------------------------------------------------------------
1075:     * ConfigurarPaginaLista - Monta a Page2 (pgDados do legado), que eh a
1076:     * pagina de LISTA deste form OPERACIONAL: as duas grades (Movimentacoes
1077:     * em aberto e Cotacoes Realizadas) e os CommandGroups de acao sobre elas.
1078:     *
1079:     * Top/Left EXATOS do SCX. O PageFrame deste form tem Top = -1 e abas
1080:     * VISIVEIS - NAO existe aqui a compensacao +29 do padrao CRUD.

*-- Linhas 1998 a 2054:
1998: 
1999:         *-- Obs/Justificas do produto seguem a linha corrente do grdCotacoes -
2000:         *-- o AfterRowColChange do legado so faz .Refresh (o binding jah
2001:         *-- reflete a linha); aqui, como nao ha ControlSource direto (os
2002:         *-- valores sao ESPELHADOS manualmente da linha corrente, regra dos
2003:         *-- campos de rodape de grid), o handler deste form copia os 3 campos.
2004:         BINDEVENT(loc_oPag.txt_4c_DPros,           "LostFocus", THIS, "SalvarRodapeProdutoAtual")
2005:         BINDEVENT(loc_oPag.obj_4c_GetObs,          "LostFocus", THIS, "SalvarRodapeProdutoAtual")
2006:         BINDEVENT(loc_oPag.obj_4c_GetJustificas,   "LostFocus", THIS, "SalvarRodapeProdutoAtual")
2007:     ENDPROC
2008: 
2009:     *--------------------------------------------------------------------------
2010:     * CriarCursoresCotacao - Cursores locais das grades de Page3 (Cotacoes):
2011:     *
2012:     *   cursor_4c_Produtos      -> crSigCtTCt  (grdCotacoes, itens da cotacao)
2013:     *   cursor_4c_Fornecedores  -> crSigCtTFn  (grdFornecs, fornecedores A..F)
2014:     *
2015:     * Estrutura espelha docs/schema.sql (SigCtTCt/SigCtTFn), NUNCA o dump do
2016:     * legado (regra #22). CREATE CURSOR nasce READWRITE - pre-requisito para os
2017:     * REPLACE feitos pelos handlers de Valid/toggle das grades.
2018:     *--------------------------------------------------------------------------
2019:     PROTECTED PROCEDURE CriarCursoresCotacao()
2020:         IF USED("cursor_4c_Produtos")
2021:             USE IN cursor_4c_Produtos
2022:         ENDIF
2023: 
2024:         CREATE CURSOR cursor_4c_Produtos ( ;
2025:             cIdChaves  C(20), Codigos N(6),    CItens     N(6),    CPros   C(14), ;
2026:             DPros      C(65), CUnis   C(3),    CodCors    C(4),    CodTams C(4), ;
2027:             EmpDopNums C(29), Obs     M(4),    Justificas M(4), ;
2028:             Qtds       N(15,2), QtdAdqs  N(15,2), ValAdqs N(15,6), ;
2029:             Marca01 L(1), Marca02 L(1), Marca03 L(1), Marca04 L(1), Marca05 L(1), Marca06 L(1), ;
2030:             Unit01 N(15,6), Unit02 N(15,6), Unit03 N(15,6), Unit04 N(15,6), Unit05 N(15,6), Unit06 N(15,6), ;
2031:             Tota01 N(15,6), Tota02 N(15,6), Tota03 N(15,6), Tota04 N(15,6), Tota05 N(15,6), Tota06 N(15,6))
2032: 
2033:         INDEX ON CItens TAG Ordem
2034: 
2035:         IF USED("cursor_4c_Fornecedores")
2036:             USE IN cursor_4c_Fornecedores
2037:         ENDIF
2038: 
2039:         CREATE CURSOR cursor_4c_Fornecedores ( ;
2040:             cIdChaves C(20), Codigos N(6), Grades C(1), IClis C(10), Fornecs C(40), ;
2041:             Contatos  C(20), Tel1s   C(20), FPags  C(12), DtEnts D(8), ;
2042:             Fretes    C(12), VlFretes N(11,2))
2043: 
2044:         INDEX ON Grades TAG Ordem
2045:     ENDPROC
2046: 
2047:     *--------------------------------------------------------------------------
2048:     * ConfigurarComplCots - Item B da Fase 6: PageFrame interno pgf_4c_ComplCots
2049:     * (3 sub-abas: Adicionais/Aprovacao Final/Aprovacao Solicitante), criado em
2050:     * Page3 - Top/Left/Width/Height EXATOS do SCX (pgfComplCots). Tabs = .T.:
2051:     * sao 3 sub-telas alternadas manualmente pelo usuario (Complementos /
2052:     * Aprovacao Final / Aprovacao Solicitante), nao um wizard escondido.
2053:     *
2054:     * Page1=pgAdicionais, Page2=pgAprovacao, Page3=pgSolicitas - mesma ordem de

*-- Linhas 2441 a 2474:
2441:             .HeaderHeight  = 16
2442:             .RowHeight     = 15
2443:             .ScrollBars    = 3
2444:             .DeleteMark    = .F.
2445:             .RecordMark    = .F.
2446:             .ReadOnly      = .F.
2447:             .GridLineColor = RGB(128, 128, 128)
2448:             .Visible       = .T.
2449: 
2450:             .RecordSource          = "cursor_4c_Fornecedores"
2451:             .Column1.ControlSource = "cursor_4c_Fornecedores.Grades"
2452:             .Column2.ControlSource = "cursor_4c_Fornecedores.IClis"
2453:             .Column3.ControlSource = "cursor_4c_Fornecedores.Fornecs"
2454:             .Column4.ControlSource = "cursor_4c_Fornecedores.Contatos"
2455:             .Column5.ControlSource = "cursor_4c_Fornecedores.Tel1s"
2456:             .Column6.ControlSource = "cursor_4c_Fornecedores.FPags"
2457:             .Column7.ControlSource = "cursor_4c_Fornecedores.DtEnts"
2458:             .Column8.ControlSource = "cursor_4c_Fornecedores.Fretes"
2459:             .Column9.ControlSource = "cursor_4c_Fornecedores.VlFretes"
2460:         ENDWITH
2461: 
2462:         WITH loc_oGrid.Column1
2463:             .FontBold          = .T.
2464:             .Alignment         = 2
2465:             .Movable           = .F.
2466:             .Resizable         = .F.
2467:             .ReadOnly          = .T.
2468:             .Sparse            = .F.
2469:             .DynamicForeColor  = loc_cCor
2470:             .Header1.Caption   = ""
2471:             .Header1.FontSize  = 8
2472:         ENDWITH
2473: 
2474:         WITH loc_oGrid.Column2

*-- Linhas 2620 a 2669:
2620:             .HeaderHeight  = 16
2621:             .RowHeight     = 15
2622:             .ScrollBars    = 3
2623:             .DeleteMark    = .F.
2624:             .RecordMark    = .F.
2625:             .ReadOnly      = .F.
2626:             .GridLineColor = RGB(128, 128, 128)
2627:             .Visible       = .T.
2628: 
2629:             .RecordSource           = "cursor_4c_Produtos"
2630:             .Column1.ControlSource  = "cursor_4c_Produtos.CPros"
2631:             .Column2.ControlSource  = "cursor_4c_Produtos.Qtds"
2632:             .Column3.ControlSource  = "cursor_4c_Produtos.QtdAdqs"
2633:             .Column4.ControlSource  = "cursor_4c_Produtos.CUnis"
2634:             .Column5.ControlSource  = "cursor_4c_Produtos.ValAdqs"
2635:             .Column6.ControlSource  = "cursor_4c_Produtos.Marca01"
2636:             .Column7.ControlSource  = "cursor_4c_Produtos.Unit01"
2637:             .Column8.ControlSource  = "cursor_4c_Produtos.Tota01"
2638:             .Column9.ControlSource  = "cursor_4c_Produtos.Marca02"
2639:             .Column10.ControlSource = "cursor_4c_Produtos.Unit02"
2640:             .Column11.ControlSource = "cursor_4c_Produtos.Tota02"
2641:             .Column12.ControlSource = "cursor_4c_Produtos.Marca03"
2642:             .Column13.ControlSource = "cursor_4c_Produtos.Unit03"
2643:             .Column14.ControlSource = "cursor_4c_Produtos.Tota03"
2644:             .Column15.ControlSource = "cursor_4c_Produtos.Marca04"
2645:             .Column16.ControlSource = "cursor_4c_Produtos.Unit04"
2646:             .Column17.ControlSource = "cursor_4c_Produtos.Tota04"
2647:             .Column18.ControlSource = "cursor_4c_Produtos.Marca05"
2648:             .Column19.ControlSource = "cursor_4c_Produtos.Unit05"
2649:             .Column20.ControlSource = "cursor_4c_Produtos.Tota05"
2650:             .Column21.ControlSource = "cursor_4c_Produtos.Marca06"
2651:             .Column22.ControlSource = "cursor_4c_Produtos.Unit06"
2652:             .Column23.ControlSource = "cursor_4c_Produtos.Tota06"
2653:             .Column24.ControlSource = "cursor_4c_Produtos.CodTams"
2654:             .Column25.ControlSource = "cursor_4c_Produtos.CodCors"
2655:         ENDWITH
2656: 
2657:         *-- Column1 (Produto) - link azul sublinhado, igual ao legado
2658:         WITH loc_oGrid.Column1
2659:             .FontBold          = .T.
2660:             .FontUnderline     = .T.
2661:             .ReadOnly          = .F.
2662:             .Sparse            = .F.
2663:             .Format            = "K"
2664:             .Text1.MaxLength         = 14
2665:             .Header1.Caption   = "Produto"
2666:             .Header1.Alignment = 2
2667:             .Header1.FontBold  = .T.
2668:             .Header1.FontSize  = 8
2669:             .Text1.FontBold    = .T.

*-- Linhas 3304 a 3356:
3304:     *--------------------------------------------------------------------------
3305:     * SalvarRodapeProdutoAtual - Copia getDPros/getObs/getJustificas (rodape
3306:     * de Page3) para a linha CORRENTE de cursor_4c_Produtos. Sao campos que o
3307:     * legado liga por ControlSource direto a crSigCtTCt; aqui, como o valor
3308:     * fica em controles de nivel de Page (fora da grade), a copia manual eh
3309:     * feita ao perder o foco - equivalente ao LostFocus nativo do binding.
3310:     *--------------------------------------------------------------------------
3311:     PROCEDURE SalvarRodapeProdutoAtual()
3312:         LOCAL loc_oPag
3313: 
3314:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
3315:             RETURN
3316:         ENDIF
3317: 
3318:         loc_oPag = THIS.pgf_4c_Paginas.Page3
3319: 
3320:         SELECT cursor_4c_Produtos
3321:         REPLACE DPros      WITH ALLTRIM(loc_oPag.txt_4c_DPros.Value), ;
3322:                 Obs        WITH loc_oPag.obj_4c_GetObs.Value, ;
3323:                 Justificas WITH loc_oPag.obj_4c_GetJustificas.Value ;
3324:             IN cursor_4c_Produtos
3325:     ENDPROC
3326: 
3327:     *--------------------------------------------------------------------------
3328:     * GridCotacoesAfterRowColChange - Espelha a linha corrente do grd_4c_Produtos
3329:     * nos campos de rodape (equivalente ao Refresh dos 3 controles no legado,
3330:     * que estao ligados por ControlSource direto).
3331:     *--------------------------------------------------------------------------
3332:     PROCEDURE GridCotacoesAfterRowColChange(par_nColIndex)
3333:         LOCAL loc_oPag
3334: 
3335:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
3336:             RETURN
3337:         ENDIF
3338: 
3339:         loc_oPag = THIS.pgf_4c_Paginas.Page3
3340: 
3341:         SELECT cursor_4c_Produtos
3342:         loc_oPag.txt_4c_DPros.Value         = ALLTRIM(NVL(DPros, ""))
3343:         loc_oPag.obj_4c_GetObs.Value        = NVL(Obs, "")
3344:         loc_oPag.obj_4c_GetJustificas.Value = NVL(Justificas, "")
3345:     ENDPROC
3346: 
3347:     *--------------------------------------------------------------------------
3348:     * GridCotacoesKeyPressComum / GridFornecsKeyPressComum - Navegacao comum
3349:     * Tab/Shift+Tab das colunas de texto das duas grades de Page3, transcrita
3350:     * do KeyPress identico presente em TODAS as colunas do dump legado.
3351:     *--------------------------------------------------------------------------
3352:     PROCEDURE GridCotacoesKeyPressComum(par_nKeyCode, par_nShiftAltCtrl)
3353:         DO CASE
3354:             CASE par_nKeyCode = 9   && TAB
3355:                 THIS.pgf_4c_Paginas.Page3.txt_4c_DPros.SetFocus()
3356:             CASE par_nKeyCode = 15  && SHIFT+TAB

*-- Linhas 3560 a 3616:
3560:         loc_cCampo  = "Marca" + par_cNum
3561:         loc_lMarcado = EVALUATE("cursor_4c_Produtos." + loc_cCampo)
3562: 
3563:         SELECT cursor_4c_Produtos
3564:         IF loc_lMarcado
3565:             REPLACE (loc_cCampo) WITH .F., ValAdqs WITH 0 IN cursor_4c_Produtos
3566:         ELSE
3567:             REPLACE Marca01 WITH .F., Marca02 WITH .F., Marca03 WITH .F., ;
3568:                     Marca04 WITH .F., Marca05 WITH .F., Marca06 WITH .F. IN cursor_4c_Produtos
3569:             REPLACE (loc_cCampo) WITH .T., ;
3570:                     ValAdqs WITH EVALUATE("cursor_4c_Produtos.Tota" + par_cNum) IN cursor_4c_Produtos
3571:         ENDIF
3572: 
3573:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
3574:     ENDPROC
3575: 
3576:     *--------------------------------------------------------------------------
3577:     * SelecionarTodosFornecedor - Header1.DblClick do legado: marca <par_cNum>
3578:     * em TODAS as linhas com Total preenchido e ValAdqs = Total, desmarcando os
3579:     * outros 5 fornecedores em todas as linhas (Update sem Where -> todas).
3580:     *--------------------------------------------------------------------------
3581:     PROCEDURE SelecionarTodosFornecedor(par_cNum)
3582:         LOCAL loc_cCampo, loc_cCampoTota, loc_nRegAtual, loc_nI, loc_cOutro
3583: 
3584:         IF !USED("cursor_4c_Produtos") ;
3585:            OR !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
3586:             RETURN
3587:         ENDIF
3588: 
3589:         loc_cCampo     = "Marca" + par_cNum
3590:         loc_cCampoTota = "Tota"  + par_cNum
3591:         loc_nRegAtual  = RECNO("cursor_4c_Produtos")
3592: 
3593:         *-- Transcrito literal do Header1.DblClick legado (3 passos
3594:         *-- distintos - inclusive a assimetria: so as OUTRAS 5 letras sao
3595:         *-- limpas incondicionalmente, a marcada so muda onde o Total dela
3596:         *-- esta preenchido). REPLACE...FOR (nao UPDATE-SQL) porque so REPLACE
3597:         *-- aceita nome de campo DINAMICO via parenteses em VFP9:
3598:         *-- Update Set Marca<N>=.t. Where Not Empty(Tota<N>)
3599:         *-- Update Set ValAdqs=Tota<N> Where Marca<N>
3600:         *-- Update Set Marca<outras 5>=.f. (todas as linhas)
3601:         SELECT cursor_4c_Produtos
3602:         REPLACE (loc_cCampo) WITH .T. FOR !EMPTY(EVALUATE(loc_cCampoTota)) IN cursor_4c_Produtos
3603:         REPLACE ValAdqs WITH EVALUATE(loc_cCampoTota) FOR EVALUATE(loc_cCampo) IN cursor_4c_Produtos
3604: 
3605:         FOR loc_nI = 1 TO 6
3606:             loc_cOutro = "Marca" + PADL(loc_nI, 2, "0")
3607:             IF loc_cOutro != loc_cCampo
3608:                 REPLACE (loc_cOutro) WITH .F. ALL IN cursor_4c_Produtos
3609:             ENDIF
3610:         ENDFOR
3611: 
3612:         GO TOP IN cursor_4c_Produtos
3613:         IF BETWEEN(loc_nRegAtual, 1, RECCOUNT("cursor_4c_Produtos"))
3614:             GO loc_nRegAtual IN cursor_4c_Produtos
3615:         ENDIF
3616: 

*-- Linhas 3630 a 3648:
3630:             RETURN
3631:         ENDIF
3632: 
3633:         SELECT cursor_4c_Produtos
3634:         loc_nUnit = EVALUATE("Unit" + par_cNum)
3635: 
3636:         IF loc_nUnit < 0
3637:             REPLACE ("Unit" + par_cNum) WITH 0 IN cursor_4c_Produtos
3638:             loc_nUnit = 0
3639:         ENDIF
3640: 
3641:         loc_nQtd      = QtdAdqs
3642:         loc_nTotalNovo = loc_nUnit * loc_nQtd
3643: 
3644:         IF EVALUATE("Tota" + par_cNum) != loc_nTotalNovo
3645:             REPLACE ("Tota" + par_cNum) WITH loc_nTotalNovo IN cursor_4c_Produtos
3646:         ENDIF
3647: 
3648:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()

*-- Linhas 3655 a 3673:
3655:             RETURN
3656:         ENDIF
3657: 
3658:         SELECT cursor_4c_Produtos
3659:         loc_nTotal = EVALUATE("Tota" + par_cNum)
3660: 
3661:         IF loc_nTotal < 0
3662:             REPLACE ("Tota" + par_cNum) WITH 0 IN cursor_4c_Produtos
3663:             loc_nTotal = 0
3664:         ENDIF
3665: 
3666:         loc_nQtd     = IIF(QtdAdqs = 0, 1, QtdAdqs)
3667:         loc_nUnitNovo = loc_nTotal / loc_nQtd
3668: 
3669:         IF EVALUATE("Unit" + par_cNum) != loc_nUnitNovo
3670:             REPLACE ("Unit" + par_cNum) WITH loc_nUnitNovo IN cursor_4c_Produtos
3671:         ENDIF
3672: 
3673:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()

*-- Linhas 3685 a 3703:
3685:             RETURN
3686:         ENDIF
3687: 
3688:         SELECT cursor_4c_Produtos
3689:         loc_nQtd = QtdAdqs
3690: 
3691:         IF loc_nQtd < 0
3692:             REPLACE QtdAdqs WITH 0 IN cursor_4c_Produtos
3693:             loc_nQtd = 0
3694:         ENDIF
3695: 
3696:         FOR loc_nI = 1 TO 6
3697:             loc_cNum = PADL(loc_nI, 2, "0")
3698:             IF EVALUATE("Unit" + loc_cNum) > 0
3699:                 REPLACE ("Tota" + loc_cNum) WITH EVALUATE("Unit" + loc_cNum) * loc_nQtd IN cursor_4c_Produtos
3700:             ENDIF
3701:         ENDFOR
3702: 
3703:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()

*-- Linhas 3728 a 3746:
3728: 
3729:         loc_nRegAtual = RECNO("cursor_4c_Produtos")
3730: 
3731:         SELECT cursor_4c_Produtos
3732:         SCAN
3733:             FOR loc_nI = 1 TO 6
3734:                 loc_cNum = PADL(loc_nI, 2, "0")
3735:                 IF !EMPTY(EVALUATE("Tota" + loc_cNum)) AND ;
3736:                    (EMPTY(ValAdqs) OR ValAdqs > EVALUATE("Tota" + loc_cNum))
3737:                     REPLACE Marca01 WITH .F., Marca02 WITH .F., Marca03 WITH .F., ;
3738:                             Marca04 WITH .F., Marca05 WITH .F., Marca06 WITH .F. IN cursor_4c_Produtos
3739:                     REPLACE ValAdqs WITH EVALUATE("Tota" + loc_cNum), ;
3740:                             ("Marca" + loc_cNum) WITH .T. IN cursor_4c_Produtos
3741:                 ENDIF
3742:             ENDFOR
3743:         ENDSCAN
3744: 
3745:         IF BETWEEN(loc_nRegAtual, 1, RECCOUNT("cursor_4c_Produtos"))
3746:             GO loc_nRegAtual IN cursor_4c_Produtos

*-- Linhas 3764 a 3782:
3764:     PROCEDURE GridCotacoesProdutoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3765:         IF USED("cursor_4c_Produtos") AND !EOF("cursor_4c_Produtos")
3766:             IF !EMPTY(cursor_4c_Produtos.EmpDopNums)
3767:                 SELECT cursor_4c_Produtos
3768:                 REPLACE CPros WITH THIS.this_cTagProduto IN cursor_4c_Produtos
3769:                 THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
3770:             ENDIF
3771:         ENDIF
3772:     ENDPROC
3773: 
3774:     PROCEDURE GridCotacoesProdutoDblClick()
3775:         *-- Legado: Do Form SigOpCgp.Scx (tela de consulta de movimentacoes por
3776:         *-- produto) - form de CONSULTA externo, nao portado nesta fase.
3777:         MsgAviso("Consulta de movimenta" + CHR(231) + CHR(245) + "es por produto (SigOpCgp) " + ;
3778:             "n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", ;
3779:             "Aviso")
3780:     ENDPROC
3781: 
3782:     *--------------------------------------------------------------------------

*-- Linhas 3822 a 3840:
3822:             ENDIF
3823: 
3824:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
3825:                 SELECT cursor_4c_Produtos
3826:                 REPLACE CPros     WITH ALLTRIM(cursor_4c_BuscaProduto.CPros), ;
3827:                         DPros     WITH ALLTRIM(cursor_4c_BuscaProduto.DPros), ;
3828:                         CUnis     WITH ALLTRIM(cursor_4c_BuscaProduto.CUnis), ;
3829:                         cIdChaves WITH LEFT(fUniqueIds(), 20) IN cursor_4c_Produtos
3830:                 loc_oGrid.Refresh()
3831:                 THIS.GridCotacoesAfterRowColChange(1)
3832:             ENDIF
3833: 
3834:             loc_oBusca.Release()
3835:         ENDIF
3836: 
3837:         IF USED("cursor_4c_BuscaProduto")
3838:             USE IN cursor_4c_BuscaProduto
3839:         ENDIF
3840: 

*-- Linhas 3875 a 3913:
3875:                 ENDIF
3876: 
3877:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUnidade")
3878:                     SELECT cursor_4c_Produtos
3879:                     REPLACE CUnis WITH ALLTRIM(cursor_4c_BuscaUnidade.CUnis) IN cursor_4c_Produtos
3880:                 ELSE
3881:                     SELECT cursor_4c_Produtos
3882:                     REPLACE CUnis WITH "" IN cursor_4c_Produtos
3883:                 ENDIF
3884: 
3885:                 loc_oBusca.Release()
3886:             ENDIF
3887: 
3888:             IF USED("cursor_4c_BuscaUnidade")
3889:                 USE IN cursor_4c_BuscaUnidade
3890:             ENDIF
3891: 
3892:             loc_oGrid.Refresh()
3893: 
3894:             *-- Confere contra a unidade cadastrada no produto (aviso, nao bloqueio)
3895:             IF !EMPTY(cursor_4c_Produtos.CPros)
3896:                 loc_cSQL = "SELECT CUnis FROM SigCdPro WHERE CPros = " + ;
3897:                     EscaparSQL(cursor_4c_Produtos.CPros)
3898:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniPro")
3899: 
3900:                 IF loc_nResultado > 0 AND USED("cursor_4c_UniPro") AND !EOF("cursor_4c_UniPro")
3901:                     IF !EMPTY(cursor_4c_UniPro.CUnis) AND ;
3902:                        ALLTRIM(cursor_4c_UniPro.CUnis) != ALLTRIM(cursor_4c_Produtos.CUnis)
3903:                         MsgAviso("A Unidade de Medida Deste Produto no Cadastro " + CHR(233) + ' "' + ;
3904:                             ALLTRIM(cursor_4c_UniPro.CUnis) + '"!!!', "Aten" + CHR(231) + CHR(227) + "o!!!")
3905:                     ENDIF
3906:                 ENDIF
3907: 
3908:                 IF USED("cursor_4c_UniPro")
3909:                     USE IN cursor_4c_UniPro
3910:                 ENDIF
3911:             ENDIF
3912: 
3913:             THIS.this_lAbrindoLookupGrid = .F.

*-- Linhas 3944 a 3962:
3944:         ENDIF
3945: 
3946:         IF EMPTY(loc_cValor)
3947:             SELECT cursor_4c_Fornecedores
3948:             REPLACE IClis WITH "", Fornecs WITH "", Contatos WITH "", Tel1s WITH "", Fretes WITH "" ;
3949:                 IN cursor_4c_Fornecedores
3950:             loc_oGrid.Refresh()
3951:             RETURN
3952:         ENDIF
3953: 
3954:         *-- Guarda de reentrancia (ver ValidarProdutoGrid).
3955:         IF THIS.this_lAbrindoLookupGrid
3956:             RETURN
3957:         ENDIF
3958:         THIS.this_lAbrindoLookupGrid = .T.
3959: 
3960:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"
3961:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3962:             "SigCdCli", "cursor_4c_BuscaFornec", par_cCampo, loc_cValor, loc_cTitulo, .F., .T., "")

*-- Linhas 3971 a 3996:
3971:             ENDIF
3972: 
3973:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFornec")
3974:                 SELECT cursor_4c_Fornecedores
3975:                 REPLACE IClis    WITH ALLTRIM(cursor_4c_BuscaFornec.IClis), ;
3976:                         Fornecs  WITH ALLTRIM(cursor_4c_BuscaFornec.RClis), ;
3977:                         Contatos WITH ALLTRIM(NVL(cursor_4c_BuscaFornec.Contato, "")), ;
3978:                         Tel1s    WITH ALLTRIM(NVL(cursor_4c_BuscaFornec.Tel1s, "")), ;
3979:                         Fretes   WITH "Emitente" IN cursor_4c_Fornecedores
3980:             ELSE
3981:                 SELECT cursor_4c_Fornecedores
3982:                 REPLACE IClis WITH "", Fornecs WITH "", Contatos WITH "", Tel1s WITH "", Fretes WITH "" ;
3983:                     IN cursor_4c_Fornecedores
3984:             ENDIF
3985: 
3986:             loc_oBusca.Release()
3987:         ENDIF
3988: 
3989:         IF USED("cursor_4c_BuscaFornec")
3990:             USE IN cursor_4c_BuscaFornec
3991:         ENDIF
3992: 
3993:         loc_oGrid.Refresh()
3994:         THIS.this_lAbrindoLookupGrid = .F.
3995:     ENDPROC
3996: 

*-- Linhas 4028 a 4049:
4028:             ENDIF
4029: 
4030:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFPag")
4031:                 SELECT cursor_4c_Fornecedores
4032:                 REPLACE FPags WITH ALLTRIM(cursor_4c_BuscaFPag.FPags) IN cursor_4c_Fornecedores
4033:             ELSE
4034:                 SELECT cursor_4c_Fornecedores
4035:                 REPLACE FPags WITH "" IN cursor_4c_Fornecedores
4036:             ENDIF
4037: 
4038:             loc_oBusca.Release()
4039:         ENDIF
4040: 
4041:         IF USED("cursor_4c_BuscaFPag")
4042:             USE IN cursor_4c_BuscaFPag
4043:         ENDIF
4044: 
4045:         THIS.pgf_4c_Paginas.Page3.grd_4c_Fornecedores.Refresh()
4046:         THIS.this_lAbrindoLookupGrid = .F.
4047:     ENDPROC
4048: 
4049:     *--------------------------------------------------------------------------

*-- Linhas 4071 a 4089:
4071: 
4072:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4073:             "SigCdUsu", "cursor_4c_BuscaSolic", "Usuarios", loc_cValor, ;
4074:             "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "CAtivos = " + EscaparSQL("S"))
4075: 
4076:         IF VARTYPE(loc_oBusca) = "O"
4077:             IF loc_oBusca.this_lAchouRegistro
4078:                 loc_oPag.txt_4c_Solicitas.Value = ALLTRIM(cursor_4c_BuscaSolic.Usuarios)
4079:             ELSE
4080:                 loc_oBusca.mAddColuna("Usuarios", "", "Solicitante")
4081:                 loc_oBusca.mAddColuna("NComps",   "", "Nome")
4082:                 loc_oBusca.mAddColuna("Deptos",   "", "Departamento")
4083:                 loc_oBusca.Show()
4084:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSolic")
4085:                     loc_oPag.txt_4c_Solicitas.Value = ALLTRIM(cursor_4c_BuscaSolic.Usuarios)
4086:                 ENDIF
4087:             ENDIF
4088:             loc_oBusca.Release()
4089:         ENDIF

*-- Linhas 4174 a 4192:
4174: 
4175:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4176:             "SigCdUsu", "cursor_4c_BuscaCompr", "Usuarios", loc_cValor, ;
4177:             "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "CAtivos = " + EscaparSQL("S"))
4178: 
4179:         IF VARTYPE(loc_oBusca) = "O"
4180:             IF loc_oBusca.this_lAchouRegistro
4181:                 loc_oPag.txt_4c_Comprador.Value = ALLTRIM(cursor_4c_BuscaCompr.Usuarios)
4182:             ELSE
4183:                 loc_oBusca.mAddColuna("Usuarios", "", "Solicitante")
4184:                 loc_oBusca.mAddColuna("NComps",   "", "Nome")
4185:                 loc_oBusca.Show()
4186:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCompr")
4187:                     loc_oPag.txt_4c_Comprador.Value = ALLTRIM(cursor_4c_BuscaCompr.Usuarios)
4188:                 ENDIF
4189:             ENDIF
4190:             loc_oBusca.Release()
4191:         ENDIF
4192: 

*-- Linhas 4250 a 4269:
4250:             RETURN
4251:         ENDIF
4252: 
4253:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE " + par_cCampo + " = " + EscaparSQL(loc_cValor)
4254:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaEsVal")
4255: 
4256:         IF loc_nResultado > 0 AND USED("cursor_4c_ContaEsVal") AND !EOF("cursor_4c_ContaEsVal")
4257:             loc_oAdic.txt_4c_ContaEs.Value  = ALLTRIM(cursor_4c_ContaEsVal.IClis)
4258:             loc_oAdic.txt_4c_DContaEs.Value = ALLTRIM(cursor_4c_ContaEsVal.RClis)
4259:         ELSE
4260:             loc_oAdic.txt_4c_ContaEs.Value  = ""
4261:             loc_oAdic.txt_4c_DContaEs.Value = ""
4262:             THIS.AbrirBuscaContaEsGeral(par_cCampo)
4263:         ENDIF
4264: 
4265:         IF USED("cursor_4c_ContaEsVal")
4266:             USE IN cursor_4c_ContaEsVal
4267:         ENDIF
4268: 
4269:         IF VARTYPE(THIS.this_oBusinessObject) = "O"

*-- Linhas 4334 a 4353:
4334:             RETURN
4335:         ENDIF
4336: 
4337:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cContaEs)
4338:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EntregaCli")
4339: 
4340:         IF loc_nResultado < 0 OR !USED("cursor_4c_EntregaCli") OR EOF("cursor_4c_EntregaCli")
4341:             MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
4342:                 "Falha na Conex" + CHR(227) + "o (cmdEntrega)")
4343:         ELSE
4344:             MsgAviso("A tela de Local de Entrega (SigCdEnd) n" + CHR(227) + "o foi portada para o " + ;
4345:                 "sistema novo." + CHR(13) + "Cadastre/ajuste os endere" + CHR(231) + "os de entrega do " + ;
4346:                 "cliente " + ALLTRIM(cursor_4c_EntregaCli.RClis) + " pelo cadastro de Clientes.", "Aviso")
4347:         ENDIF
4348: 
4349:         IF USED("cursor_4c_EntregaCli")
4350:             USE IN cursor_4c_EntregaCli
4351:         ENDIF
4352:     ENDPROC
4353: 

*-- Linhas 4380 a 4398:
4380: 
4381:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4382:             "SigCdUsu", "cursor_4c_BuscaAprov", "Usuarios", loc_cValor, ;
4383:             "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "CAtivos = " + EscaparSQL("S"))
4384: 
4385:         IF VARTYPE(loc_oBusca) = "O"
4386:             IF loc_oBusca.this_lAchouRegistro
4387:                 loc_oApr.txt_4c_Aprovador.Value = ALLTRIM(cursor_4c_BuscaAprov.Usuarios)
4388:             ELSE
4389:                 loc_oBusca.mAddColuna("Usuarios", "", "Aprovador")
4390:                 loc_oBusca.mAddColuna("NComps",   "", "Nome")
4391:                 loc_oBusca.Show()
4392:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAprov")
4393:                     loc_oApr.txt_4c_Aprovador.Value = ALLTRIM(cursor_4c_BuscaAprov.Usuarios)
4394:                 ENDIF
4395:             ENDIF
4396:             loc_oBusca.Release()
4397:         ENDIF
4398: 

*-- Linhas 4526 a 4570:
4526: 
4527:             *-- So desmarca o SigMvCab se NENHUMA outra linha (desta ou de
4528:             *-- OUTRAS cotacoes ja gravadas) ainda usar a mesma operacao
4529:             SELECT COUNT(*) AS Total FROM cursor_4c_Produtos ;
4530:                 WHERE EmpDopNums = loc_cEdn AND cIdChaves != loc_cIdAtual ;
4531:                 INTO CURSOR cursor_4c_ChecagemLocal
4532: 
4533:             IF cursor_4c_ChecagemLocal.Total = 0
4534:                 loc_cSQL = "SELECT EmpDopNums FROM SigCtTCt WHERE EmpDopNums = " + ;
4535:                     EscaparSQL(loc_cEdn) + " AND Codigos != " + FormatarNumeroSQL(loc_nCod, 0)
4536: 
4537:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChecagemSQL")
4538: 
4539:                 IF loc_nResultado >= 0 AND USED("cursor_4c_ChecagemSQL") AND EOF("cursor_4c_ChecagemSQL")
4540:                     SQLEXEC(gnConnHandle, "UPDATE SigMvCab SET Utilizados = 0 WHERE EmpDopNums = " + ;
4541:                         EscaparSQL(loc_cEdn))
4542:                 ENDIF
4543: 
4544:                 IF USED("cursor_4c_ChecagemSQL")
4545:                     USE IN cursor_4c_ChecagemSQL
4546:                 ENDIF
4547:             ENDIF
4548: 
4549:             IF USED("cursor_4c_ChecagemLocal")
4550:                 USE IN cursor_4c_ChecagemLocal
4551:             ENDIF
4552:         ENDIF
4553: 
4554:         SELECT cursor_4c_Produtos
4555:         DELETE IN cursor_4c_Produtos
4556: 
4557:         loc_nItn = 1
4558:         SCAN
4559:             REPLACE CItens WITH loc_nItn IN cursor_4c_Produtos
4560:             loc_nItn = loc_nItn + 1
4561:         ENDSCAN
4562: 
4563:         GO TOP IN cursor_4c_Produtos
4564:         IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Produtos")
4565:             GO loc_nRec IN cursor_4c_Produtos
4566:         ENDIF
4567: 
4568:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
4569:         THIS.GridCotacoesAfterRowColChange(1)
4570: 

*-- Linhas 4589 a 4617:
4589:         ENDIF
4590: 
4591:         loc_nItn = 1
4592:         SELECT cursor_4c_Produtos
4593:         SCAN
4594:             REPLACE CItens WITH loc_nItn IN cursor_4c_Produtos
4595:             IF EMPTY(cursor_4c_Produtos.CPros)
4596:                 DELETE IN cursor_4c_Produtos
4597:             ELSE
4598:                 loc_nItn = loc_nItn + 1
4599:             ENDIF
4600:         ENDSCAN
4601: 
4602:         INSERT INTO cursor_4c_Produtos (cIdChaves, Codigos, CItens, CPros, DPros, Obs, Qtds, CUnis, QtdAdqs) ;
4603:             VALUES (LEFT(fUniqueIds(), 20), loc_nCod, loc_nItn, "", "", "", 0, "", 0)
4604: 
4605:         GO BOTTOM IN cursor_4c_Produtos
4606:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
4607:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Column1.SetFocus()
4608:         THIS.GridCotacoesAfterRowColChange(1)
4609:     ENDPROC
4610: 
4611:     *--------------------------------------------------------------------------
4612:     * BtnSairCotacoesClick - cmdBotoes.btnSair.Click de Page3: confirma
4613:     * abandono em modo de edicao, desfaz a edicao em curso do BO e volta para
4614:     * a pagina de Dados (Page2).
4615:     *--------------------------------------------------------------------------
4616:     PROCEDURE BtnSairCotacoesClick()
4617:         LOCAL loc_lConfirma

*-- Linhas 4657 a 4693:
4657:     *--------------------------------------------------------------------------
4658:     * GravaDados - Equivalente ao PROCEDURE gravadados legado: apaga o que
4659:     * existia para este Codigos e regrava o cabecalho (SigCtTDc, via BO) e os
4660:     * itens/fornecedores (SigCtTCt/SigCtTFn, INSERT direto - esta arquitetura
4661:     * nao usa cursores bufferizados/TABLEUPDATE como o legado, entao o padrao
4662:     * "apagar tudo e regravar" e feito com DELETE + INSERT explicitos).
4663:     *
4664:     * Modo EXCLUIR: so apaga (cabecalho + filhos) e libera o SigMvCab.
4665:     *--------------------------------------------------------------------------
4666:     PROCEDURE GravaDados()
4667:         LOCAL loc_lOk, loc_nCod, loc_cSQL, loc_nI, loc_cNum, loc_nRec
4668: 
4669:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
4670:             RETURN .F.
4671:         ENDIF
4672: 
4673:         loc_lOk = .T.
4674: 
4675:         *-- ValAdqs = Total do fornecedor marcado (ou 0 se nenhum) - transcrito
4676:         IF USED("cursor_4c_Produtos")
4677:             loc_nRec = RECNO("cursor_4c_Produtos")
4678:             SELECT cursor_4c_Produtos
4679:             SCAN
4680:                 loc_cNum = ""
4681:                 FOR loc_nI = 1 TO 6
4682:                     IF EVALUATE("Marca" + PADL(loc_nI, 2, "0"))
4683:                         loc_cNum = PADL(loc_nI, 2, "0")
4684:                     ENDIF
4685:                 ENDFOR
4686:                 IF EMPTY(loc_cNum)
4687:                     REPLACE ValAdqs WITH 0 IN cursor_4c_Produtos
4688:                 ELSE
4689:                     REPLACE ValAdqs WITH EVALUATE("Tota" + loc_cNum) IN cursor_4c_Produtos
4690:                 ENDIF
4691:             ENDSCAN
4692:             IF BETWEEN(loc_nRec, 1, RECCOUNT("cursor_4c_Produtos"))
4693:                 GO loc_nRec IN cursor_4c_Produtos

*-- Linhas 4699 a 4843:
4699: 
4700:             *-- Libera as operacoes (SigMvCab) que so eram usadas por esta cotacao
4701:             IF USED("cursor_4c_Produtos")
4702:                 SELECT DISTINCT EmpDopNums FROM cursor_4c_Produtos ;
4703:                     WHERE !EMPTY(EmpDopNums) INTO CURSOR cursor_4c_ApagarEdn
4704: 
4705:                 SELECT cursor_4c_ApagarEdn
4706:                 SCAN
4707:                     loc_cSQL = "SELECT EmpDopNums FROM SigCtTCt WHERE EmpDopNums = " + ;
4708:                         EscaparSQL(cursor_4c_ApagarEdn.EmpDopNums) + " AND Codigos != " + ;
4709:                         FormatarNumeroSQL(loc_nCod, 0)
4710: 
4711:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ApagarChk") >= 0
4712:                         IF USED("cursor_4c_ApagarChk") AND EOF("cursor_4c_ApagarChk")
4713:                             SQLEXEC(gnConnHandle, "UPDATE SigMvCab SET Utilizados = 0 WHERE EmpDopNums = " + ;
4714:                                 EscaparSQL(cursor_4c_ApagarEdn.EmpDopNums))
4715:                         ENDIF
4716:                     ENDIF
4717:                     IF USED("cursor_4c_ApagarChk")
4718:                         USE IN cursor_4c_ApagarChk
4719:                     ENDIF
4720:                 ENDSCAN
4721: 
4722:                 IF USED("cursor_4c_ApagarEdn")
4723:                     USE IN cursor_4c_ApagarEdn
4724:                 ENDIF
4725:             ENDIF
4726: 
4727:             IF SQLEXEC(gnConnHandle, "DELETE FROM SigCtTFn WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)) < 0
4728:                 MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - Apagando SigCtTFn)" + CHR(13) + ;
4729:                     CapturarErroSQL(), "Erro SQL")
4730:                 loc_lOk = .F.
4731:             ENDIF
4732:             IF loc_lOk AND SQLEXEC(gnConnHandle, "DELETE FROM SigCtTCt WHERE Codigos = " + ;
4733:                 FormatarNumeroSQL(loc_nCod, 0)) < 0
4734:                 MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - Apagando SigCtTCt)" + CHR(13) + ;
4735:                     CapturarErroSQL(), "Erro SQL")
4736:                 loc_lOk = .F.
4737:             ENDIF
4738:             IF loc_lOk AND !THIS.this_oBusinessObject.Excluir()
4739:                 loc_lOk = .F.
4740:             ENDIF
4741: 
4742:             RETURN loc_lOk
4743:         ENDIF
4744: 
4745:         *-- INSERIR/ALTERAR: recolhe primeiro o que esta nos controles do
4746:         *-- cabecalho (no legado o ControlSource ja mantinha crSigCtTDc em dia;
4747:         *-- aqui, campo digitado e gravado sem sair do foco nunca chegou ao BO)
4748:         THIS.FormParaBO()
4749: 
4750:         *-- e so entao grava o cabecalho via BO (Inserir gera cidchaves +
4751:         *-- codigos automaticamente no primeiro Salvar)
4752:         IF !THIS.this_oBusinessObject.Salvar()
4753:             RETURN .F.
4754:         ENDIF
4755: 
4756:         loc_nCod = THIS.this_oBusinessObject.this_nCodigos
4757: 
4758:         *-- Regrava filhos: apaga o que ja existia e reinsere o cursor inteiro
4759:         IF SQLEXEC(gnConnHandle, "DELETE FROM SigCtTFn WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)) < 0
4760:             MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - SigCtTFn)" + CHR(13) + CapturarErroSQL(), "Erro SQL")
4761:             RETURN .F.
4762:         ENDIF
4763:         IF SQLEXEC(gnConnHandle, "DELETE FROM SigCtTCt WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)) < 0
4764:             MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - SigCtTCt)" + CHR(13) + CapturarErroSQL(), "Erro SQL")
4765:             RETURN .F.
4766:         ENDIF
4767: 
4768:         IF USED("cursor_4c_Fornecedores")
4769:             SELECT cursor_4c_Fornecedores
4770:             SCAN
4771:                 loc_cSQL = "INSERT INTO SigCtTFn (cidchaves, codigos, grades, iclis, fornecs, contatos, " + ;
4772:                     "tel1s, fpags, dtents, fretes, vlfretes) VALUES (" + ;
4773:                     EscaparSQL(IIF(EMPTY(cIdChaves), LEFT(fUniqueIds(), 20), cIdChaves)) + ", " + ;
4774:                     FormatarNumeroSQL(loc_nCod, 0) + ", " + ;
4775:                     EscaparSQL(Grades) + ", " + ;
4776:                     EscaparSQL(LEFT(ALLTRIM(IClis), 10)) + ", " + ;
4777:                     EscaparSQL(LEFT(ALLTRIM(Fornecs), 40)) + ", " + ;
4778:                     EscaparSQL(LEFT(ALLTRIM(Contatos), 20)) + ", " + ;
4779:                     EscaparSQL(LEFT(ALLTRIM(Tel1s), 20)) + ", " + ;
4780:                     EscaparSQL(LEFT(ALLTRIM(FPags), 12)) + ", " + ;
4781:                     FormatarDataSQL(DtEnts) + ", " + ;
4782:                     EscaparSQL(LEFT(IIF(EMPTY(Fretes), "Emitente", ALLTRIM(Fretes)), 12)) + ", " + ;
4783:                     FormatarNumeroSQL(VlFretes, 2) + ")"
4784: 
4785:                 IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
4786:                     MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - INSERT SigCtTFn)" + CHR(13) + ;
4787:                         CapturarErroSQL(), "Erro SQL")
4788:                     RETURN .F.
4789:                 ENDIF
4790:             ENDSCAN
4791:         ENDIF
4792: 
4793:         IF USED("cursor_4c_Produtos")
4794:             SELECT cursor_4c_Produtos
4795:             SCAN FOR !EMPTY(CPros)
4796:                 loc_cSQL = "INSERT INTO SigCtTCt (cidchaves, codigos, citens, cpros, dpros, cunis, " + ;
4797:                     "codcors, codtams, empdopnums, obs, justificas, qtds, qtdadqs, valadqs, " + ;
4798:                     "marca01, marca02, marca03, marca04, marca05, marca06, " + ;
4799:                     "unit01, unit02, unit03, unit04, unit05, unit06, " + ;
4800:                     "tota01, tota02, tota03, tota04, tota05, tota06) VALUES (" + ;
4801:                     EscaparSQL(IIF(EMPTY(cIdChaves), LEFT(fUniqueIds(), 20), cIdChaves)) + ", " + ;
4802:                     FormatarNumeroSQL(loc_nCod, 0) + ", " + ;
4803:                     FormatarNumeroSQL(CItens, 0) + ", " + ;
4804:                     EscaparSQL(LEFT(ALLTRIM(CPros), 14)) + ", " + ;
4805:                     EscaparSQL(LEFT(ALLTRIM(DPros), 65)) + ", " + ;
4806:                     EscaparSQL(LEFT(ALLTRIM(CUnis), 3)) + ", " + ;
4807:                     EscaparSQL(LEFT(ALLTRIM(NVL(CodCors, "")), 4)) + ", " + ;
4808:                     EscaparSQL(LEFT(ALLTRIM(NVL(CodTams, "")), 4)) + ", " + ;
4809:                     EscaparSQL(LEFT(NVL(EmpDopNums, ""), 29)) + ", " + ;
4810:                     EscaparSQL(Obs) + ", " + EscaparSQL(Justificas) + ", " + ;
4811:                     FormatarNumeroSQL(Qtds, 2) + ", " + FormatarNumeroSQL(QtdAdqs, 2) + ", " + ;
4812:                     FormatarNumeroSQL(ValAdqs, 6) + ", " + ;
4813:                     IIF(Marca01, "1", "0") + ", " + IIF(Marca02, "1", "0") + ", " + IIF(Marca03, "1", "0") + ", " + ;
4814:                     IIF(Marca04, "1", "0") + ", " + IIF(Marca05, "1", "0") + ", " + IIF(Marca06, "1", "0") + ", " + ;
4815:                     FormatarNumeroSQL(Unit01, 6) + ", " + FormatarNumeroSQL(Unit02, 6) + ", " + ;
4816:                     FormatarNumeroSQL(Unit03, 6) + ", " + FormatarNumeroSQL(Unit04, 6) + ", " + ;
4817:                     FormatarNumeroSQL(Unit05, 6) + ", " + FormatarNumeroSQL(Unit06, 6) + ", " + ;
4818:                     FormatarNumeroSQL(Tota01, 6) + ", " + FormatarNumeroSQL(Tota02, 6) + ", " + ;
4819:                     FormatarNumeroSQL(Tota03, 6) + ", " + FormatarNumeroSQL(Tota04, 6) + ", " + ;
4820:                     FormatarNumeroSQL(Tota05, 6) + ", " + FormatarNumeroSQL(Tota06, 6) + ")"
4821: 
4822:                 IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
4823:                     MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - INSERT SigCtTCt)" + CHR(13) + ;
4824:                         CapturarErroSQL(), "Erro SQL")
4825:                     RETURN .F.
4826:                 ENDIF
4827: 
4828:                 SELECT cursor_4c_Produtos
4829:             ENDSCAN
4830:         ENDIF
4831: 
4832:         RETURN .T.
4833:     ENDPROC
4834: 
4835:     *--------------------------------------------------------------------------
4836:     * AprovarCotacao - Equivalente ao PROCEDURE aprovarcotacao legado.
4837:     * Transcrito literal: cada guarda de validacao, ao falhar, zera ChkAprovs,
4838:     * regrava (GravaDados) e devolve o foco ao campo correspondente.
4839:     *--------------------------------------------------------------------------
4840:     PROCEDURE AprovarCotacao()
4841:         LOCAL loc_oApr, loc_oBO, loc_cSQL, loc_nResultado, loc_nVlLib, loc_nTotalCotacao
4842: 
4843:         loc_oApr = THIS.pgf_4c_Paginas.Page3.pgf_4c_ComplCots.Page2

*-- Linhas 4928 a 4966:
4928:         ENDIF
4929: 
4930:         *-- Procurando o cargo do aprovador e o valor maximo de liberacao
4931:         loc_cSQL = "SELECT CCargs FROM SigCdUsu WHERE Usuarios = " + EscaparSQL(loc_oBO.this_cAprovador)
4932:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CargoAprov")
4933: 
4934:         IF loc_nResultado < 0 OR !USED("cursor_4c_CargoAprov") OR EOF("cursor_4c_CargoAprov") OR ;
4935:            EMPTY(cursor_4c_CargoAprov.CCargs)
4936:             MsgAviso("O Aprovador N" + CHR(227) + "o Possui o Cargo Informado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
4937:             loc_oBO.this_nChkAprovs = 0
4938:             IF !THIS.GravaDados()
4939:                 RETURN .F.
4940:             ENDIF
4941:             loc_oApr.chk_4c_ChkAprovador.Value = 0
4942:             loc_oApr.txt_4c_Aprovador.SetFocus()
4943:             IF USED("cursor_4c_CargoAprov")
4944:                 USE IN cursor_4c_CargoAprov
4945:             ENDIF
4946:             RETURN .F.
4947:         ENDIF
4948: 
4949:         loc_cSQL = "SELECT VlLibCots FROM SigCdCrg WHERE CCargs = " + EscaparSQL(cursor_4c_CargoAprov.CCargs)
4950:         USE IN cursor_4c_CargoAprov
4951:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LimiteAprov")
4952: 
4953:         IF loc_nResultado < 0 OR !USED("cursor_4c_LimiteAprov") OR EOF("cursor_4c_LimiteAprov") OR ;
4954:            EMPTY(cursor_4c_LimiteAprov.VlLibCots)
4955:             MsgAviso("O Cargo do Aprovador N" + CHR(227) + "o Possui Um Valor de Libera" + CHR(231) + CHR(227) + ;
4956:                 "o de Cota" + CHR(231) + CHR(227) + "o Informado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
4957:             loc_oBO.this_nChkAprovs = 0
4958:             IF !THIS.GravaDados()
4959:                 RETURN .F.
4960:             ENDIF
4961:             loc_oApr.chk_4c_ChkAprovador.Value = 0
4962:             loc_oApr.txt_4c_Aprovador.SetFocus()
4963:             IF USED("cursor_4c_LimiteAprov")
4964:                 USE IN cursor_4c_LimiteAprov
4965:             ENDIF
4966:             RETURN .F.

*-- Linhas 4981 a 4999:
4981: 
4982:         loc_nTotalCotacao = 0
4983:         IF USED("cursor_4c_CabOperas")
4984:             SELECT SUM(Valors) AS Total FROM cursor_4c_CabOperas INTO CURSOR cursor_4c_SomaCab
4985:             IF USED("cursor_4c_SomaCab") AND !EOF("cursor_4c_SomaCab")
4986:                 loc_nTotalCotacao = NVL(cursor_4c_SomaCab.Total, 0)
4987:             ENDIF
4988:             IF USED("cursor_4c_SomaCab")
4989:                 USE IN cursor_4c_SomaCab
4990:             ENDIF
4991:         ENDIF
4992: 
4993:         IF loc_nTotalCotacao <= 0 OR loc_nTotalCotacao > loc_nVlLib
4994:             MsgAviso("O Cargo do Aprovador N" + CHR(227) + "o Permite a Aprova" + CHR(231) + CHR(227) + ;
4995:                 "o Do Valor Desta Cota" + CHR(231) + CHR(227) + "o!!!" + CHR(13) + CHR(13) + ;
4996:                 "Valor da Cota" + CHR(231) + CHR(227) + "o : " + ALLTRIM(STR(loc_nTotalCotacao, 12, 2)) + ;
4997:                 "  -  Limite Para Aprova" + CHR(231) + CHR(227) + "o : " + ALLTRIM(STR(loc_nVlLib, 12, 2)), ;
4998:                 "Aten" + CHR(231) + CHR(227) + "o!!!")
4999:             loc_oBO.this_nChkAprovs = 0

*-- Linhas 5015 a 5066:
5015:     * CriarCursoresPedidos - Cursores locais da pagina de Pedidos (Page4):
5016:     *
5017:     *   cursor_4c_Pedidos    -> crPedidos    (staging por produto/fornecedor)
5018:     *   cursor_4c_CabOperas  -> crCabOperas  (grdCabOperas, 1 linha por Numes)
5019:     *   cursor_4c_ItnOperas  -> crItnOperas  (grdItnOperas, itens de cada Numes)
5020:     *   cursor_4c_Subniveis  -> crSubniveis  (operacoes de subnivel do Dopes)
5021:     *--------------------------------------------------------------------------
5022:     PROTECTED PROCEDURE CriarCursoresPedidos()
5023:         IF USED("cursor_4c_Pedidos")
5024:             USE IN cursor_4c_Pedidos
5025:         ENDIF
5026:         CREATE CURSOR cursor_4c_Pedidos ( ;
5027:             IFors C(10), Fornecs C(40), FPags C(12), DtEnts D(8), CPros C(14), DPros C(65), ;
5028:             CUnis C(3), Obs M(4), Qtds N(15,2), Valors N(15,2), Fretes C(12), VlFretes N(11,2), ;
5029:             CodCors C(4), CodTams C(4))
5030: 
5031:         IF USED("cursor_4c_CabOperas")
5032:             USE IN cursor_4c_CabOperas
5033:         ENDIF
5034:         CREATE CURSOR cursor_4c_CabOperas ( ;
5035:             Numes N(6), IFors C(10), Fornecs C(40), FPags C(12), DtEnts D(8), ;
5036:             Qtds N(15,2), Valors N(15,2), Fretes C(12), VlFretes N(11,2), Jobs C(10))
5037:         INDEX ON IFors TAG IFors
5038:         INDEX ON Numes TAG Ordem
5039: 
5040:         IF USED("cursor_4c_ItnOperas")
5041:             USE IN cursor_4c_ItnOperas
5042:         ENDIF
5043:         CREATE CURSOR cursor_4c_ItnOperas ( ;
5044:             Numes N(6), CItens N(6), CPros C(14), DPros C(65), CodCors C(4), CodTams C(4), ;
5045:             CUnis C(3), Obs M(4), Qtds N(15,2), Units N(15,6), Valors N(15,2))
5046:         INDEX ON STR(Numes, 6) + STR(CItens, 6) TAG Ordem
5047: 
5048:         IF USED("cursor_4c_Subniveis")
5049:             USE IN cursor_4c_Subniveis
5050:         ENDIF
5051:         CREATE CURSOR cursor_4c_Subniveis ( ;
5052:             Dopes C(20), GruOrigs C(10), GruDests C(10), ConDests C(10), Opers N(1), ;
5053:             CMoes C(3), NFiscals N(1), Series C(3), Especies C(2), TipoNfs N(1), ;
5054:             MarcaSubns C(1), Cfos C(10), Casas N(1), GrVends C(10), ChkLimOps N(1))
5055:         INDEX ON Dopes TAG Dopes
5056:     ENDPROC
5057: 
5058:     *--------------------------------------------------------------------------
5059:     * GeraPedidos - Equivalente ao PROCEDURE gerapedidos legado: valida os
5060:     * dados de cada fornecedor marcado na grade de Produtos, monta os cursores
5061:     * de cabecalho/itens da pagina de Pedidos e navega para Page4 (a menos que
5062:     * par_lChk seja .T., usado por AprovarCotacao so para CALCULAR o total).
5063:     *
5064:     * NAO inclui a gravacao fisica (SigMvCab/SigMvItn/financeiro) - essa parte
5065:     * (GravaPedidos do legado) esta em THIS.GravaPedidos(), acionada pelo
5066:     * botao "Processar Pedidos" (BtnProcessarPedidosClick).

*-- Linhas 5091 a 5109:
5091:         ZAP IN cursor_4c_ItnOperas
5092: 
5093:         IF USED("cursor_4c_Produtos")
5094:             SELECT cursor_4c_Produtos
5095:             SCAN
5096:                 loc_cLetra = ""
5097:                 DO CASE
5098:                     CASE cursor_4c_Produtos.Marca01
5099:                         loc_cLetra = "A"
5100:                     CASE cursor_4c_Produtos.Marca02
5101:                         loc_cLetra = "B"
5102:                     CASE cursor_4c_Produtos.Marca03
5103:                         loc_cLetra = "C"
5104:                     CASE cursor_4c_Produtos.Marca04
5105:                         loc_cLetra = "D"
5106:                     CASE cursor_4c_Produtos.Marca05
5107:                         loc_cLetra = "E"
5108:                     CASE cursor_4c_Produtos.Marca06
5109:                         loc_cLetra = "F"

*-- Linhas 5178 a 5351:
5178:                         RETURN .F.
5179:                     ENDIF
5180: 
5181:                     loc_cSQL = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
5182:                         EscaparSQL(cursor_4c_Fornecedores.IClis)
5183:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ForneCliChk")
5184: 
5185:                     IF loc_nResultado < 0 OR !USED("cursor_4c_ForneCliChk") OR EOF("cursor_4c_ForneCliChk")
5186:                         MsgAviso("O Produto " + ALLTRIM(cursor_4c_Produtos.CPros) + "-" + ;
5187:                             ALLTRIM(cursor_4c_Produtos.DPros) + CHR(13) + "Foi Solicitado ao Fornecedor " + ;
5188:                             loc_cLetra + " Que Est" + CHR(225) + " Sem o C" + CHR(243) + "digo Informado!!!" + ;
5189:                             CHR(13) + "Para Gerar Pedidos " + CHR(233) + " Necess" + CHR(225) + "rio Realizar " + ;
5190:                             "o Cadastro Deste Fornecedor!!!", "Fornecedor N" + CHR(227) + "o Informado")
5191:                         IF USED("cursor_4c_ForneCliChk")
5192:                             USE IN cursor_4c_ForneCliChk
5193:                         ENDIF
5194:                         RETURN .F.
5195:                     ENDIF
5196:                     IF USED("cursor_4c_ForneCliChk")
5197:                         USE IN cursor_4c_ForneCliChk
5198:                     ENDIF
5199: 
5200:                     INSERT INTO cursor_4c_Pedidos (IFors, Fornecs, FPags, DtEnts, CPros, DPros, CUnis, Obs, ;
5201:                             Qtds, Valors, Fretes, VlFretes, CodCors, CodTams) ;
5202:                         VALUES (ALLTRIM(cursor_4c_Fornecedores.IClis), ALLTRIM(cursor_4c_Fornecedores.Fornecs), ;
5203:                             ALLTRIM(cursor_4c_Fornecedores.FPags), NVL(cursor_4c_Fornecedores.DtEnts, {}), ;
5204:                             ALLTRIM(cursor_4c_Produtos.CPros), ALLTRIM(cursor_4c_Produtos.DPros), ;
5205:                             ALLTRIM(cursor_4c_Produtos.CUnis), NVL(cursor_4c_Produtos.Obs, ""), ;
5206:                             cursor_4c_Produtos.QtdAdqs, cursor_4c_Produtos.ValAdqs, ;
5207:                             ALLTRIM(cursor_4c_Fornecedores.Fretes), cursor_4c_Fornecedores.VlFretes, ;
5208:                             NVL(cursor_4c_Produtos.CodCors, ""), NVL(cursor_4c_Produtos.CodTams, ""))
5209:                 ENDIF
5210:             ENDSCAN
5211:         ENDIF
5212: 
5213:         IF !USED("cursor_4c_Pedidos") OR EOF("cursor_4c_Pedidos")
5214:             MsgAviso("Nenhum Produto Foi Selecionado Para Gerar Cota" + CHR(231) + CHR(245) + "es!!!", ;
5215:                 "Aten" + CHR(231) + CHR(227) + "o!!!")
5216:             RETURN .F.
5217:         ENDIF
5218: 
5219:         *-- Agrupa por fornecedor (crCabOperas: 1 linha por IFors)
5220:         loc_nNum = 0
5221:         SELECT cursor_4c_Pedidos
5222:         SCAN
5223:             IF !SEEK(cursor_4c_Pedidos.IFors, "cursor_4c_CabOperas", "IFors")
5224:                 loc_nNum = loc_nNum + 1
5225:                 INSERT INTO cursor_4c_CabOperas (Numes, IFors, Fornecs, FPags, DtEnts, Fretes, VlFretes, Jobs) ;
5226:                     VALUES (loc_nNum, cursor_4c_Pedidos.IFors, cursor_4c_Pedidos.Fornecs, cursor_4c_Pedidos.FPags, ;
5227:                         cursor_4c_Pedidos.DtEnts, cursor_4c_Pedidos.Fretes, cursor_4c_Pedidos.VlFretes, ;
5228:                         THIS.this_cJobs)
5229:             ENDIF
5230: 
5231:             loc_nNumAtual = cursor_4c_CabOperas.Numes
5232:             SELECT cursor_4c_CabOperas
5233:             REPLACE Qtds WITH Qtds + cursor_4c_Pedidos.Qtds, ;
5234:                     Valors WITH Valors + cursor_4c_Pedidos.Valors IN cursor_4c_CabOperas
5235: 
5236:             INSERT INTO cursor_4c_ItnOperas (Numes, CPros, DPros, CodCors, CodTams, CUnis, Obs, Qtds, Units, Valors) ;
5237:                 VALUES (loc_nNumAtual, cursor_4c_Pedidos.CPros, cursor_4c_Pedidos.DPros, cursor_4c_Pedidos.CodCors, ;
5238:                     cursor_4c_Pedidos.CodTams, cursor_4c_Pedidos.CUnis, cursor_4c_Pedidos.Obs, ;
5239:                     cursor_4c_Pedidos.Qtds, IIF(cursor_4c_Pedidos.Qtds = 0, 0, cursor_4c_Pedidos.Valors / cursor_4c_Pedidos.Qtds), ;
5240:                     cursor_4c_Pedidos.Valors)
5241: 
5242:             SELECT cursor_4c_Pedidos
5243:         ENDSCAN
5244: 
5245:         *-- Renumera CItens dentro de cada Numes
5246:         loc_nNumAtual = -1
5247:         loc_nItn = 0
5248:         SELECT cursor_4c_ItnOperas
5249:         SCAN
5250:             IF loc_nNumAtual != cursor_4c_ItnOperas.Numes
5251:                 loc_nItn     = 0
5252:                 loc_nNumAtual = cursor_4c_ItnOperas.Numes
5253:             ENDIF
5254:             loc_nItn = loc_nItn + 1
5255:             REPLACE CItens WITH loc_nItn IN cursor_4c_ItnOperas
5256:         ENDSCAN
5257: 
5258:         *-- Operacoes de subnivel do Dopes filtrado em Page1
5259:         loc_cSQL = ;
5260:             "SELECT a.Dopes, a.GruOrigs, a.GruDests, a.ConDests, a.Opers, a.CMoes, a.NFiscals, " + ;
5261:             "a.Series, a.Especies, a.TipoNfs, a.MarcaSubns, a.Cfos, a.Casas, a.GrVends, b.ChkLimOps " + ;
5262:             "FROM SigCdOpe a INNER JOIN SigOpCdd b ON a.Dopes = b.Dopes " + ;
5263:             "WHERE a.Nivels = " + EscaparSQL(PADR(THIS.this_cDopes, 20)) + " " + ;
5264:             "UNION ALL " + ;
5265:             "SELECT b.CDopes AS Dopes, c.GruOrigs, c.GruDests, c.ConDests, c.Opers, c.CMoes, c.NFiscals, " + ;
5266:             "c.Series, c.Especies, c.TipoNfs, c.MarcaSubns, c.Cfos, c.Casas, c.GrVends, d.ChkLimOps " + ;
5267:             "FROM SigOpCsn b INNER JOIN SigCdOpe c ON b.CDopes = c.Dopes " + ;
5268:             "INNER JOIN SigOpCdd d ON b.CDopes = d.Dopes " + ;
5269:             "WHERE b.CNivels = " + EscaparSQL(PADR(THIS.this_cDopes, 20))
5270: 
5271:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubTemp")
5272: 
5273:         IF loc_nResultado < 0
5274:             MsgErro("Falha na Conex" + CHR(227) + "o (GeraPedidos - Subn" + CHR(237) + "veis)" + CHR(13) + ;
5275:                 CapturarErroSQL(), "Erro SQL")
5276:             RETURN .F.
5277:         ENDIF
5278: 
5279:         IF !USED("cursor_4c_Subniveis")
5280:             THIS.CriarCursoresPedidos()
5281:         ENDIF
5282:         ZAP IN cursor_4c_Subniveis
5283: 
5284:         IF USED("cursor_4c_SubTemp")
5285:             SELECT DISTINCT * FROM cursor_4c_SubTemp INTO CURSOR cursor_4c_SubDistinct
5286:             SELECT cursor_4c_SubDistinct
5287:             SCAN
5288:                 INSERT INTO cursor_4c_Subniveis (Dopes, GruOrigs, GruDests, ConDests, Opers, CMoes, ;
5289:                         NFiscals, Series, Especies, TipoNfs, MarcaSubns, Cfos, Casas, GrVends, ChkLimOps) ;
5290:                     VALUES (cursor_4c_SubDistinct.Dopes, cursor_4c_SubDistinct.GruOrigs, cursor_4c_SubDistinct.GruDests, ;
5291:                         cursor_4c_SubDistinct.ConDests, cursor_4c_SubDistinct.Opers, cursor_4c_SubDistinct.CMoes, ;
5292:                         cursor_4c_SubDistinct.NFiscals, cursor_4c_SubDistinct.Series, cursor_4c_SubDistinct.Especies, ;
5293:                         cursor_4c_SubDistinct.TipoNfs, cursor_4c_SubDistinct.MarcaSubns, cursor_4c_SubDistinct.Cfos, ;
5294:                         cursor_4c_SubDistinct.Casas, cursor_4c_SubDistinct.GrVends, cursor_4c_SubDistinct.ChkLimOps)
5295:             ENDSCAN
5296:             IF USED("cursor_4c_SubDistinct")
5297:                 USE IN cursor_4c_SubDistinct
5298:             ENDIF
5299:             USE IN cursor_4c_SubTemp
5300:         ENDIF
5301: 
5302:         GO TOP IN cursor_4c_Subniveis
5303: 
5304:         *-- Preenche o cabecalho da operacao de pedido (cnt_4c_Operacao)
5305:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "cnt_4c_Operacao", 5)
5306:             WITH THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
5307:                 .txt_4c_Emps.Value  = THIS.this_cEmps
5308:                 .txt_4c_Job.Value   = THIS.this_cJobs
5309:                 .txt_4c_Datas.Value = DATE()
5310: 
5311:                 IF !EOF("cursor_4c_Subniveis")
5312:                     .txt_4c_Dopes.Value  = ALLTRIM(cursor_4c_Subniveis.Dopes)
5313:                     .txt_4c_CMoes.Value  = ALLTRIM(cursor_4c_Subniveis.CMoes)
5314:                     .txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_Subniveis.GruDests)
5315:                     .txt_4c_ContaDs.Value = ALLTRIM(cursor_4c_Subniveis.ConDests)
5316:                 ENDIF
5317: 
5318:                 .txt_4c_ContaEs.Value = ALLTRIM(loc_oBO.this_cContaEs)
5319:                 .obj_4c_GetObs.Value = "Cota" + CHR(231) + CHR(227) + "o " + ;
5320:                     ALLTRIM(STR(loc_oBO.this_nCodigos, 6)) + ;
5321:                     IIF(EMPTY(ALLTRIM(loc_oBO.this_cJustificas)), "", " - ") + ALLTRIM(loc_oBO.this_cJustificas)
5322: 
5323:                 IF !EMPTY(.txt_4c_ContaDs.Value)
5324:                     loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(.txt_4c_ContaDs.Value)
5325:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DContaDsTmp") > 0 AND ;
5326:                        USED("cursor_4c_DContaDsTmp") AND !EOF("cursor_4c_DContaDsTmp")
5327:                         .txt_4c_DContaDs.Value = ALLTRIM(cursor_4c_DContaDsTmp.RClis)
5328:                     ENDIF
5329:                     IF USED("cursor_4c_DContaDsTmp")
5330:                         USE IN cursor_4c_DContaDsTmp
5331:                     ENDIF
5332:                 ENDIF
5333: 
5334:                 IF !EMPTY(.txt_4c_ContaEs.Value)
5335:                     loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(.txt_4c_ContaEs.Value)
5336:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DContaEsTmp") > 0 AND ;
5337:                        USED("cursor_4c_DContaEsTmp") AND !EOF("cursor_4c_DContaEsTmp")
5338:                         .txt_4c_DContaEs.Value = ALLTRIM(cursor_4c_DContaEsTmp.RClis)
5339:                     ENDIF
5340:                     IF USED("cursor_4c_DContaEsTmp")
5341:                         USE IN cursor_4c_DContaEsTmp
5342:                     ENDIF
5343:                 ENDIF
5344:             ENDWITH
5345:         ENDIF
5346: 
5347:         IF !USED("cursor_4c_CabOperas") OR EOF("cursor_4c_CabOperas")
5348:             MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Processar!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5349:             THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Column1.SetFocus()
5350:             RETURN .F.
5351:         ENDIF

*-- Linhas 5396 a 5495:
5396:         ZAP IN cursor_4c_CabOperas
5397:         ZAP IN cursor_4c_ItnOperas
5398: 
5399:         loc_cSQL = "SELECT * FROM SigCtTPc WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)
5400:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaPc")
5401: 
5402:         IF loc_nResultado < 0
5403:             MsgErro("Falha na Conex" + CHR(227) + "o (ConsultaPedidos - SigCtTPc)" + CHR(13) + ;
5404:                 CapturarErroSQL(), "Erro SQL")
5405:             RETURN .F.
5406:         ENDIF
5407: 
5408:         IF USED("cursor_4c_ConsultaPc") AND !EOF("cursor_4c_ConsultaPc")
5409:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "cnt_4c_Operacao", 5)
5410:                 WITH THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
5411:                     .txt_4c_Datas.Value   = ConverterParaData(NVL(cursor_4c_ConsultaPc.Datas, {}))
5412:                     .txt_4c_Emps.Value    = ALLTRIM(NVL(cursor_4c_ConsultaPc.Emps, ""))
5413:                     .txt_4c_Dopes.Value   = ALLTRIM(NVL(cursor_4c_ConsultaPc.Dopes, ""))
5414:                     .txt_4c_CMoes.Value   = ALLTRIM(NVL(cursor_4c_ConsultaPc.CMoes, ""))
5415:                     .txt_4c_Grupo.Value   = ALLTRIM(NVL(cursor_4c_ConsultaPc.GrupoDs, ""))
5416:                     .txt_4c_ContaDs.Value = ALLTRIM(NVL(cursor_4c_ConsultaPc.ContaDs, ""))
5417:                     .txt_4c_CodObs.Value  = NVL(cursor_4c_ConsultaPc.CodObs, 0)
5418:                     .obj_4c_GetObs.Value  = NVL(cursor_4c_ConsultaPc.Obs, "")
5419:                     .txt_4c_ContaEs.Value = ALLTRIM(NVL(cursor_4c_ConsultaPc.ContaEs, ""))
5420: 
5421:                     IF !EMPTY(.txt_4c_ContaDs.Value)
5422:                         IF SQLEXEC(gnConnHandle, "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
5423:                             EscaparSQL(.txt_4c_ContaDs.Value), "cursor_4c_DsTmp") > 0 AND ;
5424:                            USED("cursor_4c_DsTmp") AND !EOF("cursor_4c_DsTmp")
5425:                             .txt_4c_DContaDs.Value = ALLTRIM(cursor_4c_DsTmp.RClis)
5426:                         ENDIF
5427:                         IF USED("cursor_4c_DsTmp")
5428:                             USE IN cursor_4c_DsTmp
5429:                         ENDIF
5430:                     ENDIF
5431: 
5432:                     IF !EMPTY(.txt_4c_ContaEs.Value)
5433:                         IF SQLEXEC(gnConnHandle, "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
5434:                             EscaparSQL(.txt_4c_ContaEs.Value), "cursor_4c_EsTmp") > 0 AND ;
5435:                            USED("cursor_4c_EsTmp") AND !EOF("cursor_4c_EsTmp")
5436:                             .txt_4c_DContaEs.Value = ALLTRIM(cursor_4c_EsTmp.RClis)
5437:                         ENDIF
5438:                         IF USED("cursor_4c_EsTmp")
5439:                             USE IN cursor_4c_EsTmp
5440:                         ENDIF
5441:                     ENDIF
5442:                 ENDWITH
5443:             ENDIF
5444: 
5445:             loc_cSQL = "SELECT * FROM SigCtTPe WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)
5446:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaPe")
5447: 
5448:             IF loc_nResultado < 0
5449:                 MsgErro("Falha na Conex" + CHR(227) + "o (ConsultaPedidos - SigCtTPe)" + CHR(13) + ;
5450:                     CapturarErroSQL(), "Erro SQL")
5451:                 RETURN .F.
5452:             ENDIF
5453: 
5454:             IF USED("cursor_4c_ConsultaPe")
5455:                 SELECT cursor_4c_ConsultaPe
5456:                 SCAN
5457:                     INSERT INTO cursor_4c_CabOperas (Numes, IFors, Fornecs, FPags, DtEnts, Qtds, Valors, Fretes, VlFretes) ;
5458:                         VALUES (cursor_4c_ConsultaPe.Numes, ALLTRIM(cursor_4c_ConsultaPe.IFors), ;
5459:                             ALLTRIM(cursor_4c_ConsultaPe.Fornecs), ALLTRIM(cursor_4c_ConsultaPe.FPags), ;
5460:                             ConverterParaData(NVL(cursor_4c_ConsultaPe.DtEnts, {})), cursor_4c_ConsultaPe.Qtds, ;
5461:                             cursor_4c_ConsultaPe.Valors, ALLTRIM(NVL(cursor_4c_ConsultaPe.Fretes, "")), ;
5462:                             NVL(cursor_4c_ConsultaPe.VlFretes, 0))
5463:                 ENDSCAN
5464:                 USE IN cursor_4c_ConsultaPe
5465:             ENDIF
5466: 
5467:             loc_cSQL = "SELECT * FROM SigCtTPi WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0) + ;
5468:                 " ORDER BY Numes, CItens"
5469:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaPi")
5470: 
5471:             IF loc_nResultado < 0
5472:                 MsgErro("Falha na Conex" + CHR(227) + "o (ConsultaPedidos - SigCtTPi)" + CHR(13) + ;
5473:                     CapturarErroSQL(), "Erro SQL")
5474:                 RETURN .F.
5475:             ENDIF
5476: 
5477:             IF USED("cursor_4c_ConsultaPi")
5478:                 SELECT cursor_4c_ConsultaPi
5479:                 SCAN
5480:                     INSERT INTO cursor_4c_ItnOperas (CItens, Numes, CPros, DPros, CodCors, CodTams, CUnis, Obs, Qtds, Units, Valors) ;
5481:                         VALUES (cursor_4c_ConsultaPi.CItens, cursor_4c_ConsultaPi.Numes, ALLTRIM(cursor_4c_ConsultaPi.CPros), ;
5482:                             ALLTRIM(cursor_4c_ConsultaPi.DPros), ALLTRIM(NVL(cursor_4c_ConsultaPi.CodCors, "")), ;
5483:                             ALLTRIM(NVL(cursor_4c_ConsultaPi.CodTams, "")), ALLTRIM(cursor_4c_ConsultaPi.CUnis), ;
5484:                             NVL(cursor_4c_ConsultaPi.Obs, ""), cursor_4c_ConsultaPi.Qtds, cursor_4c_ConsultaPi.Units, ;
5485:                             cursor_4c_ConsultaPi.Valors)
5486:                 ENDSCAN
5487:                 USE IN cursor_4c_ConsultaPi
5488:             ENDIF
5489:         ENDIF
5490: 
5491:         IF USED("cursor_4c_ConsultaPc")
5492:             USE IN cursor_4c_ConsultaPc
5493:         ENDIF
5494: 
5495:         IF !USED("cursor_4c_CabOperas") OR EOF("cursor_4c_CabOperas")

*-- Linhas 5529 a 5566:
5529:     * na data) feita duas linhas acima para a moeda padrao.
5530:     *--------------------------------------------------------------------------
5531:     PROTECTED FUNCTION LiberaPagto(par_nValTit, par_cMoeTit, par_dDatTit)
5532:         LOCAL loc_cSQL, loc_cCargo, loc_nVlLib, loc_nCotP, loc_nVlL, loc_lLib
5533: 
5534:         IF !USED("cursor_4c_Subniveis") OR cursor_4c_Subniveis.ChkLimOps != 1
5535:             RETURN .T.
5536:         ENDIF
5537: 
5538:         loc_cSQL = "SELECT CCargs FROM SigCdUsu WHERE Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado)
5539:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LibUsu") < 1 OR !USED("cursor_4c_LibUsu") OR EOF("cursor_4c_LibUsu")
5540:             MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + ;
5541:                 "o (CrSigCdUsu)", "Erro SQL")
5542:             IF USED("cursor_4c_LibUsu")
5543:                 USE IN cursor_4c_LibUsu
5544:             ENDIF
5545:             RETURN .F.
5546:         ENDIF
5547:         loc_cCargo = ALLTRIM(NVL(cursor_4c_LibUsu.CCargs, ""))
5548:         USE IN cursor_4c_LibUsu
5549: 
5550:         loc_cSQL = "SELECT VlLibOpes FROM SigCdCrg WHERE CCargs = " + EscaparSQL(loc_cCargo)
5551:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LibCrg") < 1 OR !USED("cursor_4c_LibCrg") OR EOF("cursor_4c_LibCrg")
5552:             MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + ;
5553:                 "o (CrTmpCarg)", "Erro SQL")
5554:             IF USED("cursor_4c_LibCrg")
5555:                 USE IN cursor_4c_LibCrg
5556:             ENDIF
5557:             RETURN .F.
5558:         ENDIF
5559:         loc_nVlLib = NVL(cursor_4c_LibCrg.VlLibOpes, 0)
5560:         USE IN cursor_4c_LibCrg
5561: 
5562:         loc_nCotP = fBuscarCotacao(THIS.this_cMoedaPs, par_dDatTit)
5563:         loc_nVlL  = par_nValTit * IIF(par_cMoeTit == THIS.this_cMoedaPs, 1, ;
5564:             fBuscarCotacao(par_cMoeTit, par_dDatTit) / loc_nCotP)
5565:         loc_lLib  = (loc_nVlLib >= loc_nVlL)
5566: 

*-- Linhas 5579 a 5598:
5579:     * conjunto de SigMvCab/Itn/Par por fornecedor marcado (cursor_4c_CabOperas).
5580:     *
5581:     * Adaptacoes de arquitetura (regra ja usada em GravaDados/AprovarCotacao
5582:     * deste form): SQLEXEC direto por registro em vez de cursor bufferizado +
5583:     * TableUpdate/Rollback. Como a conexao deste ambiente nasce com
5584:     * Transactions=2 (manual - medido, ver functions.prg:fGerUniqueKey), o
5585:     * "tudo ou nada" do Commit/Rollback legado equivale a SQLCOMMIT/SQLROLLBACK
5586:     * explicitos ao final (mesmo padrao de SIGMVCMVBO.GravarLancamentos).
5587:     *
5588:     * Duas funcoes GLOBAIS do legado ficam FORA do dump (regra #27 - nunca
5589:     * chutar valor de calculo/lancamento financeiro):
5590:     *   fCalcularImpostos  - calcula impostos da Nota Fiscal (NFiscals 1/2).
5591:     *                        Operacoes que emitem NF automaticamente por essa
5592:     *                        tela ficam BLOQUEADAS ate a funcao ser portada -
5593:     *                        aviso claro em vez de estourar em runtime.
5594:     *   fSigOpFin_Lancs    - lancamentos financeiros automaticos configurados
5595:     *                        em SigOpCdi. So dispara quando ha configuracao
5596:     *                        para a operacao (sem config, e no-op no legado
5597:     *                        tambem) - chamada literal, sem wrapper, para
5598:     *                        falhar alto so nesse caso especifico.

*-- Linhas 5631 a 5698:
5631:             loc_oCnt.txt_4c_Datas.SetFocus()
5632:             RETURN .F.
5633:         ENDIF
5634: 
5635:         loc_cDop = ALLTRIM(loc_oCnt.txt_4c_Dopes.Value)
5636:         IF !USED("cursor_4c_Subniveis") OR EMPTY(loc_cDop) OR ;
5637:             !SEEK(PADR(loc_cDop, 20), "cursor_4c_Subniveis", "Dopes")
5638:             MsgAviso("A Opera" + CHR(231) + CHR(227) + "o de Lan" + CHR(231) + "amento N" + CHR(227) + ;
5639:                 "o Foi Informada!!!", "Dados Inv" + CHR(225) + "lidos!!!")
5640:             loc_oCnt.txt_4c_Dopes.SetFocus()
5641:             RETURN .F.
5642:         ENDIF
5643: 
5644:         loc_cMoe = ALLTRIM(loc_oCnt.txt_4c_CMoes.Value)
5645:         IF EMPTY(loc_cMoe)
5646:             MsgAviso("A Moeda de Lan" + CHR(231) + "amento N" + CHR(227) + "o Foi Informada!!!", ;
5647:                 "Dados Inv" + CHR(225) + "lidos!!!")
5648:             loc_oCnt.txt_4c_CMoes.SetFocus()
5649:             RETURN .F.
5650:         ENDIF
5651: 
5652:         IF !USED("cursor_4c_CabOperas") OR EOF("cursor_4c_CabOperas")
5653:             MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Para Gravar!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5654:             RETURN .F.
5655:         ENDIF
5656: 
5657:         *-- cursor_4c_Subniveis ja esta posicionado pelo SEEK acima
5658:         loc_cGrO = ALLTRIM(cursor_4c_Subniveis.GruOrigs)
5659:         loc_cGrD = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
5660:         loc_cCtD = ALLTRIM(loc_oCnt.txt_4c_ContaDs.Value)
5661:         loc_cCtE = ALLTRIM(loc_oCnt.txt_4c_ContaEs.Value)
5662:         loc_nObs = loc_oCnt.txt_4c_CodObs.Value
5663:         loc_cObs = loc_oCnt.obj_4c_GetObs.Value
5664:         loc_nEnt = loc_oBO.this_nLocalEnts
5665:         loc_cOpe = IIF(cursor_4c_Subniveis.Opers = 1, "E", "S")
5666:         loc_nENF = cursor_4c_Subniveis.NFiscals
5667:         loc_cGrv = ALLTRIM(cursor_4c_Subniveis.GrVends)
5668: 
5669:         IF INLIST(loc_nENF, 1, 2)
5670:             MsgErro("Esta opera" + CHR(231) + CHR(227) + "o emite Nota Fiscal automaticamente ao " + ;
5671:                 "gerar o pedido (c" + CHR(225) + "lculo de impostos), funcionalidade ainda n" + ;
5672:                 CHR(227) + "o portada para o sistema novo." + CHR(13) + ;
5673:                 "Selecione uma opera" + CHR(231) + CHR(227) + "o de lan" + CHR(231) + "amento que N" + ;
5674:                 CHR(227) + "o emita NF, ou gere este pedido pelo sistema legado.", ;
5675:                 "Funcionalidade N" + CHR(227) + "o Dispon" + CHR(237) + "vel")
5676:             RETURN .F.
5677:         ENDIF
5678: 
5679:         *-- Limite de valor por cargo (Tiago - 22/09/2014 - CC2016)
5680:         IF cursor_4c_Subniveis.ChkLimOps = 1
5681:             loc_nCotP = fBuscarCotacao(THIS.this_cMoedaPs, loc_dDat)
5682:             loc_lOk   = .T.
5683:             SELECT cursor_4c_CabOperas
5684:             GO TOP
5685:             DO WHILE loc_lOk AND !EOF("cursor_4c_CabOperas")
5686:                 loc_nCotPen = IIF(EMPTY(loc_cMoe), 1, fBuscarCotacao(loc_cMoe, loc_dDat))
5687:                 loc_nTtPen  = cursor_4c_CabOperas.Valors * loc_nCotPen
5688:                 loc_nTtGer  = IIF(loc_nCotP = 0, 0, loc_nTtPen / loc_nCotP)
5689:                 IF !THIS.LiberaPagto(loc_nTtGer, THIS.this_cMoedaPs, loc_dDat)
5690:                     loc_lOk = .F.
5691:                 ENDIF
5692:                 IF loc_lOk
5693:                     SKIP IN cursor_4c_CabOperas
5694:                 ENDIF
5695:             ENDDO
5696:             IF !loc_lOk
5697:                 RETURN .F.
5698:             ENDIF

*-- Linhas 5704 a 5940:
5704: 
5705:         TRY
5706:             *-- SigCtTPc - cabecalho da cotacao-pedido (1 registro, fora do loop
5707:             *-- por fornecedor - Insert Into crSigCtTPc do legado)
5708:             loc_cSQL = "INSERT INTO SigCtTPc (cidchaves, codigos, datars, datas, emps, dopes, cmoes, " + ;
5709:                 "grupods, contads, contaes, codobs, obs) VALUES (" + ;
5710:                 EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
5711:                 FormatarNumeroSQL(loc_oBO.this_nCodigos, 0) + ", GETDATE(), " + ;
5712:                 FormatarDataSQL(loc_dDat) + ", " + ;
5713:                 EscaparSQL(loc_cEmp) + ", " + EscaparSQL(loc_cDop) + ", " + EscaparSQL(loc_cMoe) + ", " + ;
5714:                 EscaparSQL(loc_cGrD) + ", " + EscaparSQL(loc_cCtD) + ", " + EscaparSQL(loc_cCtE) + ", " + ;
5715:                 FormatarNumeroSQL(loc_nObs, 0) + ", " + EscaparSQL(loc_cObs) + ")"
5716: 
5717:             IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5718:                 loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPc)" + CHR(13) + CapturarErroSQL()
5719:                 loc_lOk = .F.
5720:             ENDIF
5721: 
5722:             SELECT cursor_4c_CabOperas
5723:             GO TOP
5724:             DO WHILE loc_lOk AND !EOF("cursor_4c_CabOperas")
5725:                 loc_nNumesGrupo = cursor_4c_CabOperas.Numes
5726: 
5727:                 loc_nNum = fGerUniqueKey(ALLTRIM(loc_cDop) + loc_cEmp)
5728:                 loc_nNop = fGerUniqueKey("SIGMVCCR")
5729:                 loc_cEmpDopNums = loc_cEmp + loc_cDop + STR(loc_nNum, 6)
5730:                 loc_cEmpGopNums = loc_cEmp + SPACE(20) + STR(loc_nNum, 6)
5731: 
5732:                 *-- SigMvCab - cabecalho da movimentacao (1 por fornecedor)
5733:                 loc_cSQL = "INSERT INTO SigMvCab (cidchaves, emps, dopes, numes, empdopnums, mascnum, " + ;
5734:                     "opers, datas, datars, dtalts, grupoos, contaos, grupods, contads, contaes, " + ;
5735:                     "localents, codobs, obses, valos, valinis, usuars, prazoents, empgopnums, " + ;
5736:                     "usupagos, grvends, resps, jobs) VALUES (" + ;
5737:                     EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
5738:                     EscaparSQL(loc_cEmp) + ", " + EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
5739:                     EscaparSQL(loc_cEmpDopNums) + ", " + EscaparSQL(ALLTRIM(fGerMascara(loc_nNum))) + ", " + ;
5740:                     EscaparSQL(loc_cOpe) + ", " + FormatarDataSQL(loc_dDat) + ", GETDATE(), GETDATE(), " + ;
5741:                     EscaparSQL(loc_cGrO) + ", " + EscaparSQL(cursor_4c_CabOperas.IFors) + ", " + ;
5742:                     EscaparSQL(loc_cGrD) + ", " + EscaparSQL(loc_cCtD) + ", " + EscaparSQL(loc_cCtE) + ", " + ;
5743:                     FormatarNumeroSQL(loc_nEnt, 0) + ", " + FormatarNumeroSQL(loc_nObs, 0) + ", " + ;
5744:                     EscaparSQL(loc_cObs) + ", " + FormatarNumeroSQL(cursor_4c_CabOperas.Valors, 2) + ", " + ;
5745:                     FormatarNumeroSQL(cursor_4c_CabOperas.Valors, 2) + ", " + EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
5746:                     FormatarDataSQL(cursor_4c_CabOperas.DtEnts) + ", " + EscaparSQL(loc_cEmpGopNums) + ", " + ;
5747:                     EscaparSQL(LEFT(loc_oBO.this_cAprovador, 10)) + ", " + EscaparSQL(loc_cGrv) + ", " + ;
5748:                     EscaparSQL(LEFT(loc_oBO.this_cComprador, 12)) + ", " + ;
5749:                     EscaparSQL(LEFT(NVL(cursor_4c_CabOperas.Jobs, ""), 10)) + ")"
5750: 
5751:                 IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5752:                     loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvCab)" + CHR(13) + CapturarErroSQL()
5753:                     loc_lOk = .F.
5754:                 ENDIF
5755: 
5756:                 *-- SigCtTPs - liga o Codigos da cotacao ao EmpDopNums gerado
5757:                 IF loc_lOk
5758:                     loc_cSQL = "INSERT INTO SigCtTPs (cidchaves, codigos, empdopnums) VALUES (" + ;
5759:                         EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + FormatarNumeroSQL(loc_oBO.this_nCodigos, 0) + ", " + ;
5760:                         EscaparSQL(loc_cEmpDopNums) + ")"
5761:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5762:                         loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPs)" + CHR(13) + CapturarErroSQL()
5763:                         loc_lOk = .F.
5764:                     ENDIF
5765:                 ENDIF
5766: 
5767:                 *-- SigCtTPe - fornecedor/condicao/entrega do pedido (1 por fornecedor)
5768:                 IF loc_lOk
5769:                     loc_cSQL = "INSERT INTO SigCtTPe (cidchaves, codigos, numes, ifors, fornecs, fpags, " + ;
5770:                         "dtents, qtds, valors, fretes, vlfretes) VALUES (" + ;
5771:                         EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + FormatarNumeroSQL(loc_oBO.this_nCodigos, 0) + ", " + ;
5772:                         FormatarNumeroSQL(loc_nNumesGrupo, 0) + ", " + ;
5773:                         EscaparSQL(LEFT(cursor_4c_CabOperas.IFors, 10)) + ", " + ;
5774:                         EscaparSQL(LEFT(cursor_4c_CabOperas.Fornecs, 50)) + ", " + ;
5775:                         EscaparSQL(LEFT(cursor_4c_CabOperas.FPags, 12)) + ", " + ;
5776:                         FormatarDataSQL(cursor_4c_CabOperas.DtEnts) + ", " + ;
5777:                         FormatarNumeroSQL(cursor_4c_CabOperas.Qtds, 2) + ", " + ;
5778:                         FormatarNumeroSQL(cursor_4c_CabOperas.Valors, 6) + ", " + ;
5779:                         EscaparSQL(LEFT(NVL(cursor_4c_CabOperas.Fretes, ""), 12)) + ", " + ;
5780:                         FormatarNumeroSQL(cursor_4c_CabOperas.VlFretes, 2) + ")"
5781:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5782:                         loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPe)" + CHR(13) + CapturarErroSQL()
5783:                         loc_lOk = .F.
5784:                     ENDIF
5785:                 ENDIF
5786: 
5787:                 *-- Itens do fornecedor corrente (cursor_4c_ItnOperas.Numes = loc_nNumesGrupo)
5788:                 IF loc_lOk
5789:                     SELECT cursor_4c_ItnOperas
5790:                     GO TOP
5791:                     LOCATE FOR cursor_4c_ItnOperas.Numes = loc_nNumesGrupo
5792:                     DO WHILE loc_lOk AND !EOF("cursor_4c_ItnOperas") AND cursor_4c_ItnOperas.Numes = loc_nNumesGrupo
5793:                         loc_cSQL = "INSERT INTO SigMvItn (cidchaves, emps, dopes, numes, empdopnums, dtalts, " + ;
5794:                             "citens, cpros, dpros, obs, opers, moedas, moefats, moevals, qtds, aqtds, units, " + ;
5795:                             "totas, cunis) VALUES (" + ;
5796:                             EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + EscaparSQL(loc_cEmp) + ", " + ;
5797:                             EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
5798:                             EscaparSQL(loc_cEmpDopNums) + ", GETDATE(), " + ;
5799:                             FormatarNumeroSQL(cursor_4c_ItnOperas.CItens, 0) + ", " + ;
5800:                             EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CPros), 14)) + ", " + ;
5801:                             EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.DPros), 65)) + ", " + ;
5802:                             EscaparSQL(NVL(cursor_4c_ItnOperas.Obs, "")) + ", " + ;
5803:                             EscaparSQL(loc_cOpe) + ", " + EscaparSQL(loc_cMoe) + ", " + EscaparSQL(loc_cMoe) + ", " + ;
5804:                             FormatarNumeroSQL(1, 0) + ", " + ;
5805:                             FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
5806:                             FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
5807:                             FormatarNumeroSQL(cursor_4c_ItnOperas.Units, 6) + ", " + ;
5808:                             FormatarNumeroSQL(cursor_4c_ItnOperas.Valors, 2) + ", " + ;
5809:                             EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CUnis), 3)) + ")"
5810: 
5811:                         IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5812:                             loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvItn)" + CHR(13) + CapturarErroSQL()
5813:                             loc_lOk = .F.
5814:                         ENDIF
5815: 
5816:                         IF loc_lOk
5817:                             loc_cSQL = "INSERT INTO SigCtTPi (cidchaves, codigos, citens, numes, cpros, " + ;
5818:                                 "dpros, codcors, codtams, cunis, obs, qtds, units, valors) VALUES (" + ;
5819:                                 EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + FormatarNumeroSQL(loc_oBO.this_nCodigos, 0) + ", " + ;
5820:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.CItens, 0) + ", " + ;
5821:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Numes, 0) + ", " + ;
5822:                                 EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CPros), 14)) + ", " + ;
5823:                                 EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.DPros), 50)) + ", " + ;
5824:                                 EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodCors, ""), 4)) + ", " + ;
5825:                                 EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodTams, ""), 4)) + ", " + ;
5826:                                 EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CUnis), 3)) + ", " + ;
5827:                                 EscaparSQL(NVL(cursor_4c_ItnOperas.Obs, "")) + ", " + ;
5828:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 2) + ", " + ;
5829:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Units, 6) + ", " + ;
5830:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Valors, 6) + ")"
5831:                             IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5832:                                 loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPi)" + CHR(13) + CapturarErroSQL()
5833:                                 loc_lOk = .F.
5834:                             ENDIF
5835:                         ENDIF
5836: 
5837:                         *-- SigMvIts - detalhe de cor/tamanho, so quando informado
5838:                         IF loc_lOk AND (!EMPTY(cursor_4c_ItnOperas.CodCors) OR !EMPTY(cursor_4c_ItnOperas.CodTams))
5839:                             loc_cSQL = "INSERT INTO SigMvIts (cidchaves, emps, dopes, numes, citens, cpros, " + ;
5840:                                 "codcors, codtams, qtds, aqtds, empdopnums, chksubn) VALUES (" + ;
5841:                                 EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + EscaparSQL(loc_cEmp) + ", " + ;
5842:                                 EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
5843:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.CItens, 0) + ", " + ;
5844:                                 EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CPros), 14)) + ", " + ;
5845:                                 EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodCors, ""), 4)) + ", " + ;
5846:                                 EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodTams, ""), 4)) + ", " + ;
5847:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
5848:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
5849:                                 EscaparSQL(loc_cEmpDopNums) + ", 0)"
5850:                             IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5851:                                 loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvIts)" + CHR(13) + CapturarErroSQL()
5852:                                 loc_lOk = .F.
5853:                             ENDIF
5854:                         ENDIF
5855: 
5856:                         IF loc_lOk
5857:                             SKIP IN cursor_4c_ItnOperas
5858:                         ENDIF
5859:                     ENDDO
5860:                 ENDIF
5861: 
5862:                 *-- SigMvPar - parcelas financeiras conforme a condicao de pagamento
5863:                 IF loc_lOk
5864:                     loc_cSQL = "SELECT FParcs, MoeFpgs, TVens, Dias FROM SigOpFp WHERE FPags = " + ;
5865:                         EscaparSQL(ALLTRIM(cursor_4c_CabOperas.FPags))
5866:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalFPag")
5867: 
5868:                     IF loc_nResultado >= 0 AND USED("cursor_4c_LocalFPag") AND !EOF("cursor_4c_LocalFPag")
5869:                         loc_nPar = IIF(NVL(cursor_4c_LocalFPag.FParcs, 0) < 1, 1, cursor_4c_LocalFPag.FParcs)
5870:                         loc_dDtV = loc_dDat
5871:                         loc_cMdf = IIF(EMPTY(NVL(cursor_4c_LocalFPag.MoeFpgs, "")), loc_cMoe, ;
5872:                             ALLTRIM(cursor_4c_LocalFPag.MoeFpgs))
5873: 
5874:                         FOR loc_nI = 1 TO loc_nPar
5875:                             loc_cSQL = "INSERT INTO SigMvPar (cidchaves, emps, dopes, numes, empdopnums, " + ;
5876:                                 "datas, cotfpgs, fpags, moefpgs, nopers, valos, vencs, parcs, pagos, dtalts) VALUES (" + ;
5877:                                 EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + EscaparSQL(loc_cEmp) + ", " + ;
5878:                                 EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
5879:                                 EscaparSQL(loc_cEmpDopNums) + ", " + FormatarDataSQL(loc_dDat) + ", " + ;
5880:                                 FormatarNumeroSQL(1, 4) + ", " + EscaparSQL(LEFT(cursor_4c_CabOperas.FPags, 12)) + ", " + ;
5881:                                 EscaparSQL(LEFT(loc_cMdf, 3)) + ", " + FormatarNumeroSQL(loc_nNop, 0) + ", " + ;
5882:                                 FormatarNumeroSQL(cursor_4c_CabOperas.Valors / loc_nPar, 2) + ", " + ;
5883:                                 FormatarDataSQL(loc_dDtV) + ", " + FormatarNumeroSQL(loc_nI, 0) + ", " + ;
5884:                                 EscaparSQL("1") + ", GETDATE())"
5885: 
5886:                             IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5887:                                 loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvPar)" + CHR(13) + CapturarErroSQL()
5888:                                 loc_lOk = .F.
5889:                             ENDIF
5890: 
5891:                             IF UPPER(ALLTRIM(NVL(cursor_4c_LocalFPag.TVens, ""))) == "F"
5892:                                 loc_dDtV = GOMONTH(loc_dDat, loc_nI)
5893:                             ELSE
5894:                                 loc_dDtV = loc_dDtV + NVL(cursor_4c_LocalFPag.Dias, 0)
5895:                             ENDIF
5896:                         ENDFOR
5897:                     ENDIF
5898: 
5899:                     IF USED("cursor_4c_LocalFPag")
5900:                         USE IN cursor_4c_LocalFPag
5901:                     ENDIF
5902:                 ENDIF
5903: 
5904:                 IF loc_lOk
5905:                     SELECT cursor_4c_CabOperas
5906:                     SKIP IN cursor_4c_CabOperas
5907:                 ENDIF
5908:             ENDDO
5909: 
5910:             *-- Marca a cotacao como Pedido Gerado
5911:             IF loc_lOk
5912:                 loc_cSQL = "UPDATE SigCtTDc SET Situas = 1 WHERE Codigos = " + FormatarNumeroSQL(loc_oBO.this_nCodigos, 0)
5913:                 IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5914:                     loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - Update SigCtTDc)" + CHR(13) + CapturarErroSQL()
5915:                     loc_lOk = .F.
5916:                 ENDIF
5917:             ENDIF
5918: 
5919:             *-- "Lanca movimentacoes financeiras conforme configurado" (Tiago,
5920:             *-- 23/09/2014). fSigOpFin_Lancs eh funcao GLOBAL fora do dump -
5921:             *-- so dispara quando ha config em SigOpCdi para esta operacao;
5922:             *-- sem config, e no-op no legado tambem.
5923:             IF loc_lOk
5924:                 loc_cSQL = "SELECT TOP 1 Dopes FROM SigOpCdi WHERE Dopes = " + EscaparSQL(PADR(loc_cDop, 20))
5925:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdi") > 0 AND USED("cursor_4c_OpCdi") AND !EOF("cursor_4c_OpCdi")
5926:                     fSigOpFin_Lancs(gnConnHandle, loc_cDop)
5927:                 ENDIF
5928:                 IF USED("cursor_4c_OpCdi")
5929:                     USE IN cursor_4c_OpCdi
5930:                 ENDIF
5931:             ENDIF
5932: 
5933:             IF loc_lOk
5934:                 loc_lOk = fRecalculaS(.T., gnConnHandle)
5935:                 IF !loc_lOk
5936:                     loc_cErro = "Favor Reinicializar o Processo!!!"
5937:                 ENDIF
5938:             ENDIF
5939:         CATCH TO loc_oErro
5940:             loc_cErro = loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 6003 a 6046:
6003: 
6004:         loc_cNomeComprador = ""
6005:         IF !EMPTY(loc_oBO.this_cComprador)
6006:             IF SQLEXEC(gnConnHandle, "SELECT NComps FROM SigCdUsu WHERE Usuarios = " + ;
6007:                 EscaparSQL(loc_oBO.this_cComprador), "cursor_4c_NomeCompr") > 0 AND ;
6008:                USED("cursor_4c_NomeCompr") AND !EOF("cursor_4c_NomeCompr")
6009:                 loc_cNomeComprador = ALLTRIM(cursor_4c_NomeCompr.NComps)
6010:             ENDIF
6011:             IF USED("cursor_4c_NomeCompr")
6012:                 USE IN cursor_4c_NomeCompr
6013:             ENDIF
6014:         ENDIF
6015: 
6016:         loc_cNomeAprSols = ""
6017:         IF !EMPTY(loc_oBO.this_cAprSols)
6018:             IF SQLEXEC(gnConnHandle, "SELECT NComps FROM SigCdUsu WHERE Usuarios = " + ;
6019:                 EscaparSQL(loc_oBO.this_cAprSols), "cursor_4c_NomeAprSol") > 0 AND ;
6020:                USED("cursor_4c_NomeAprSol") AND !EOF("cursor_4c_NomeAprSol")
6021:                 loc_cNomeAprSols = ALLTRIM(cursor_4c_NomeAprSol.NComps)
6022:             ENDIF
6023:             IF USED("cursor_4c_NomeAprSol")
6024:                 USE IN cursor_4c_NomeAprSol
6025:             ENDIF
6026:         ENDIF
6027: 
6028:         loc_cNomeAprovador = ""
6029:         IF !EMPTY(loc_oBO.this_cAprovador)
6030:             IF SQLEXEC(gnConnHandle, "SELECT NComps FROM SigCdUsu WHERE Usuarios = " + ;
6031:                 EscaparSQL(loc_oBO.this_cAprovador), "cursor_4c_NomeAprov") > 0 AND ;
6032:                USED("cursor_4c_NomeAprov") AND !EOF("cursor_4c_NomeAprov")
6033:                 loc_cNomeAprovador = ALLTRIM(cursor_4c_NomeAprov.NComps)
6034:             ENDIF
6035:             IF USED("cursor_4c_NomeAprov")
6036:                 USE IN cursor_4c_NomeAprov
6037:             ENDIF
6038:         ENDIF
6039: 
6040:         MsgAviso("Impress" + CHR(227) + "o da Cota" + CHR(231) + CHR(227) + "o " + ;
6041:             ALLTRIM(STR(loc_oBO.this_nCodigos, 6)) + " (" + loc_cTipo + ", Prioridade " + loc_cPrioridade + ")" + ;
6042:             CHR(13) + "Comprador: " + loc_cNomeComprador + CHR(13) + ;
6043:             "Aprovador Solicitante: " + loc_cNomeAprSols + CHR(13) + ;
6044:             "Aprovador Final: " + loc_cNomeAprovador + CHR(13) + CHR(13) + ;
6045:             "O relat" + CHR(243) + "rio impresso (FRX) desta cota" + CHR(231) + CHR(227) + "o ainda " + ;
6046:             CHR(227) + "o foi portado para o sistema novo.", "Impress" + CHR(227) + "o")

*-- Linhas 6713 a 6732:
6713:             RETURN
6714:         ENDIF
6715: 
6716:         loc_cSQL = "SELECT Codigos FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor)
6717:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoVal")
6718: 
6719:         IF loc_nResultado > 0 AND USED("cursor_4c_GrupoVal") AND !EOF("cursor_4c_GrupoVal")
6720:             loc_oCnt.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_GrupoVal.Codigos)
6721:         ELSE
6722:             THIS.AbrirBuscaGrupoDestino()
6723:         ENDIF
6724: 
6725:         IF USED("cursor_4c_GrupoVal")
6726:             USE IN cursor_4c_GrupoVal
6727:         ENDIF
6728: 
6729:         THIS.AjustarCamposPedidos()
6730:     ENDPROC
6731: 
6732:     PROCEDURE AbrirBuscaGrupoDestino()

*-- Linhas 6797 a 6820:
6797:             RETURN
6798:         ENDIF
6799: 
6800:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE " + par_cCampo + " = " + EscaparSQL(loc_cValor)
6801:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
6802:             loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
6803:         ENDIF
6804: 
6805:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDsVal")
6806: 
6807:         IF loc_nResultado > 0 AND USED("cursor_4c_ContaDsVal") AND !EOF("cursor_4c_ContaDsVal")
6808:             loc_oCnt.txt_4c_ContaDs.Value  = ALLTRIM(cursor_4c_ContaDsVal.IClis)
6809:             loc_oCnt.txt_4c_DContaDs.Value = ALLTRIM(cursor_4c_ContaDsVal.RClis)
6810:         ELSE
6811:             THIS.AbrirBuscaContaDestino(par_cCampo)
6812:         ENDIF
6813: 
6814:         IF USED("cursor_4c_ContaDsVal")
6815:             USE IN cursor_4c_ContaDsVal
6816:         ENDIF
6817: 
6818:         THIS.AjustarCamposPedidos()
6819:     ENDPROC
6820: 

*-- Linhas 6831 a 6849:
6831: 
6832:         loc_cFiltro = ""
6833:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
6834:             loc_cFiltro = "Grupos = " + EscaparSQL(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
6835:         ENDIF
6836: 
6837:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6838:             "SigCdCli", "cursor_4c_BuscaContaDs", par_cCampo, loc_cValor, ;
6839:             "Sele" + CHR(231) + CHR(227) + "o de Conta", .F., .T., loc_cFiltro)
6840: 
6841:         IF VARTYPE(loc_oBusca) = "O"
6842:             IF loc_oBusca.this_lAchouRegistro
6843:                 loc_oCnt.txt_4c_ContaDs.Value  = ALLTRIM(cursor_4c_BuscaContaDs.IClis)
6844:                 loc_oCnt.txt_4c_DContaDs.Value = ALLTRIM(cursor_4c_BuscaContaDs.RClis)
6845:             ELSE
6846:                 loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
6847:                 loc_oBusca.mAddColuna("RClis", "", "Nome")
6848:                 loc_oBusca.Show()
6849:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaDs")

*-- Linhas 6899 a 6918:
6899:             RETURN
6900:         ENDIF
6901: 
6902:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE " + par_cCampo + " = " + EscaparSQL(loc_cValor)
6903:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaEsPedVal")
6904: 
6905:         IF loc_nResultado > 0 AND USED("cursor_4c_ContaEsPedVal") AND !EOF("cursor_4c_ContaEsPedVal")
6906:             loc_oCnt.txt_4c_ContaEs.Value  = ALLTRIM(cursor_4c_ContaEsPedVal.IClis)
6907:             loc_oCnt.txt_4c_DContaEs.Value = ALLTRIM(cursor_4c_ContaEsPedVal.RClis)
6908:         ELSE
6909:             THIS.AbrirBuscaContaEntregaPedido(par_cCampo)
6910:         ENDIF
6911: 
6912:         IF USED("cursor_4c_ContaEsPedVal")
6913:             USE IN cursor_4c_ContaEsPedVal
6914:         ENDIF
6915: 
6916:         THIS.AjustarCamposPedidos()
6917:     ENDPROC
6918: 

*-- Linhas 6967 a 6986:
6967:             RETURN
6968:         ENDIF
6969: 
6970:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cContaEs)
6971:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EntregaPedCli")
6972: 
6973:         IF loc_nResultado < 0 OR !USED("cursor_4c_EntregaPedCli") OR EOF("cursor_4c_EntregaPedCli")
6974:             MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
6975:                 "Falha na Conex" + CHR(227) + "o (cmdEntrega)")
6976:         ELSE
6977:             MsgAviso("A tela de Local de Entrega (SigCdEnd) n" + CHR(227) + "o foi portada para o " + ;
6978:                 "sistema novo." + CHR(13) + "Cadastre/ajuste os endere" + CHR(231) + "os de entrega do " + ;
6979:                 "cliente " + ALLTRIM(cursor_4c_EntregaPedCli.RClis) + " pelo cadastro de Clientes.", "Aviso")
6980:         ENDIF
6981: 
6982:         IF USED("cursor_4c_EntregaPedCli")
6983:             USE IN cursor_4c_EntregaPedCli
6984:         ENDIF
6985:     ENDPROC
6986: 

*-- Linhas 7006 a 7025:
7006:             RETURN
7007:         ENDIF
7008: 
7009:         loc_cSQL = "SELECT Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
7010:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpPedVal")
7011: 
7012:         IF loc_nResultado > 0 AND USED("cursor_4c_EmpPedVal") AND !EOF("cursor_4c_EmpPedVal")
7013:             loc_oCnt.txt_4c_Emps.Value = ALLTRIM(cursor_4c_EmpPedVal.Cemps)
7014:         ELSE
7015:             THIS.AbrirBuscaEmpresaPedido()
7016:         ENDIF
7017: 
7018:         IF USED("cursor_4c_EmpPedVal")
7019:             USE IN cursor_4c_EmpPedVal
7020:         ENDIF
7021:     ENDPROC
7022: 
7023:     PROCEDURE AbrirBuscaEmpresaPedido()
7024:         LOCAL loc_oCnt, loc_cValor, loc_oBusca
7025: 

*-- Linhas 7049 a 7111:
7049:         ENDIF
7050:     ENDPROC
7051: 
7052:     *--------------------------------------------------------------------------
7053:     * Operacao de lancamento (getDopes -> operacoes de subnivel do Dopes
7054:     * filtrado em Page1, cursor_4c_Subniveis - equivalente ao fwBuscaInt do
7055:     * legado sobre crSubniveis, aqui implementado como FormBuscaAuxiliar sobre
7056:     * uma SUBCONSULTA SQL Server derivada (nao um cursor VFP local - o
7057:     * contrato de FormBuscaAuxiliar exige "SELECT * FROM <tabela>", e uma
7058:     * expressao "(SELECT ... ) AS X" e uma tabela derivada valida no SQL
7059:     * Server, preservando o padrao canonico do projeto).
7060:     *--------------------------------------------------------------------------
7061:     PROCEDURE TeclaOperacaoLancamento(par_nKeyCode, par_nShiftAltCtrl)
7062:         IF par_nKeyCode = 115
7063:             THIS.AbrirBuscaOperacaoLancamento()
7064:         ENDIF
7065:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
7066:             THIS.ValidarOperacaoLancamento()
7067:         ENDIF
7068:     ENDPROC
7069: 
7070:     PROTECTED PROCEDURE MontarConsultaSubniveis()
7071:         RETURN ;
7072:             "(SELECT a.Dopes, a.GruOrigs, a.GruDests, a.ConDests, a.Opers, a.CMoes, a.NFiscals, " + ;
7073:             "a.Series, a.Especies, a.TipoNfs, a.MarcaSubns, a.Cfos, a.Casas, a.GrVends, b.ChkLimOps " + ;
7074:             "FROM SigCdOpe a INNER JOIN SigOpCdd b ON a.Dopes = b.Dopes " + ;
7075:             "WHERE a.Nivels = " + EscaparSQL(PADR(THIS.this_cDopes, 20)) + " " + ;
7076:             "UNION ALL " + ;
7077:             "SELECT b.CDopes AS Dopes, c.GruOrigs, c.GruDests, c.ConDests, c.Opers, c.CMoes, c.NFiscals, " + ;
7078:             "c.Series, c.Especies, c.TipoNfs, c.MarcaSubns, c.Cfos, c.Casas, c.GrVends, d.ChkLimOps " + ;
7079:             "FROM SigOpCsn b INNER JOIN SigCdOpe c ON b.CDopes = c.Dopes " + ;
7080:             "INNER JOIN SigOpCdd d ON b.CDopes = d.Dopes " + ;
7081:             "WHERE b.CNivels = " + EscaparSQL(PADR(THIS.this_cDopes, 20)) + ") AS cursor_4c_SubDerivada"
7082:     ENDPROC
7083: 
7084:     PROCEDURE ValidarOperacaoLancamento()
7085:         LOCAL loc_oCnt, loc_cValor, loc_cSQL, loc_nResultado
7086: 
7087:         loc_oCnt   = THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
7088:         loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Dopes.Value)
7089: 
7090:         IF EMPTY(loc_cValor)
7091:             RETURN
7092:         ENDIF
7093: 
7094:         loc_cSQL = "SELECT * FROM " + THIS.MontarConsultaSubniveis() + " WHERE Dopes = " + ;
7095:             EscaparSQL(PADR(loc_cValor, 20))
7096:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeLancVal")
7097: 
7098:         IF loc_nResultado > 0 AND USED("cursor_4c_OpeLancVal") AND !EOF("cursor_4c_OpeLancVal")
7099:             loc_oCnt.txt_4c_Dopes.Value  = ALLTRIM(cursor_4c_OpeLancVal.Dopes)
7100:             loc_oCnt.txt_4c_CMoes.Value  = ALLTRIM(NVL(cursor_4c_OpeLancVal.CMoes, ""))
7101:             loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(NVL(cursor_4c_OpeLancVal.GruDests, ""))
7102:             loc_oCnt.txt_4c_ContaDs.Value = ""
7103:             THIS.ValidarContaDestino("IClis")
7104:         ELSE
7105:             THIS.AbrirBuscaOperacaoLancamento()
7106:         ENDIF
7107: 
7108:         IF USED("cursor_4c_OpeLancVal")
7109:             USE IN cursor_4c_OpeLancVal
7110:         ENDIF
7111:     ENDPROC

*-- Linhas 7168 a 7187:
7168:             RETURN
7169:         ENDIF
7170: 
7171:         loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor)
7172:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
7173: 
7174:         IF loc_nResultado > 0 AND USED("cursor_4c_MoeVal") AND !EOF("cursor_4c_MoeVal")
7175:             loc_oCnt.txt_4c_CMoes.Value = ALLTRIM(cursor_4c_MoeVal.CMoes)
7176:         ELSE
7177:             THIS.AbrirBuscaMoedaPedido()
7178:         ENDIF
7179: 
7180:         IF USED("cursor_4c_MoeVal")
7181:             USE IN cursor_4c_MoeVal
7182:         ENDIF
7183:     ENDPROC
7184: 
7185:     PROCEDURE AbrirBuscaMoedaPedido()
7186:         LOCAL loc_oCnt, loc_cValor, loc_oBusca
7187: 

*-- Linhas 7266 a 7284:
7266:         IF USED("cursor_4c_CabOperas") AND !EOF("cursor_4c_CabOperas") AND USED("cursor_4c_ItnOperas")
7267:             loc_nNumes = cursor_4c_CabOperas.Numes
7268: 
7269:             SELECT cursor_4c_ItnOperas
7270:             SET ORDER TO Ordem
7271:             SET FILTER TO Numes = loc_nNumes
7272:             GO TOP IN cursor_4c_ItnOperas
7273: 
7274:             loc_oPgf.Page2.grd_4c_ItnOperas.Refresh()
7275:             loc_oPgf.Page2.grd_4c_ItnOperas.Column1.SetFocus()
7276:         ENDIF
7277:     ENDPROC
7278: 
7279:     *--------------------------------------------------------------------------
7280:     * ConfigurarGridCabOperas - grdCabOperas (cabecalho das operacoes de
7281:     * pedido, 1 linha por fornecedor -> cursor_4c_CabOperas).
7282:     *--------------------------------------------------------------------------
7283:     PROTECTED PROCEDURE ConfigurarGridCabOperas(par_oPagina)
7284:         LOCAL loc_oGrid

*-- Linhas 7297 a 7330:
7297:             .HeaderHeight  = 16
7298:             .RowHeight     = 15
7299:             .ScrollBars    = 3
7300:             .DeleteMark    = .F.
7301:             .RecordMark    = .F.
7302:             .ReadOnly      = .T.
7303:             .GridLineColor = RGB(128, 128, 128)
7304:             .Visible       = .T.
7305: 
7306:             .RecordSource          = "cursor_4c_CabOperas"
7307:             .Column1.ControlSource = "cursor_4c_CabOperas.Numes"
7308:             .Column2.ControlSource = "cursor_4c_CabOperas.IFors"
7309:             .Column3.ControlSource = "cursor_4c_CabOperas.Fornecs"
7310:             .Column4.ControlSource = "cursor_4c_CabOperas.FPags"
7311:             .Column5.ControlSource = "cursor_4c_CabOperas.DtEnts"
7312:             .Column6.ControlSource = "cursor_4c_CabOperas.Qtds"
7313:             .Column7.ControlSource = "cursor_4c_CabOperas.Valors"
7314:             .Column8.ControlSource = "cursor_4c_CabOperas.Fretes"
7315:             .Column9.ControlSource = "cursor_4c_CabOperas.VlFretes"
7316:         ENDWITH
7317: 
7318:         WITH loc_oGrid.Column1
7319:             .Alignment         = 3
7320:             .Header1.Caption   = "Ord."
7321:             .Header1.Alignment = 2
7322:             .Header1.FontSize  = 8
7323:         ENDWITH
7324: 
7325:         WITH loc_oGrid.Column2
7326:             .Header1.Caption   = "C" + CHR(243) + "digo"
7327:             .Header1.Alignment = 2
7328:             .Header1.FontSize  = 8
7329:         ENDWITH
7330: 

*-- Linhas 7396 a 7414:
7396: 
7397:         IF USED("cursor_4c_CabOperas") AND !EOF("cursor_4c_CabOperas") AND USED("cursor_4c_ItnOperas")
7398:             loc_nNumes = cursor_4c_CabOperas.Numes
7399:             SELECT cursor_4c_ItnOperas
7400:             SET ORDER TO Ordem
7401:             SET FILTER TO Numes = loc_nNumes
7402:             GO TOP IN cursor_4c_ItnOperas
7403:         ENDIF
7404:     ENDPROC
7405: 
7406:     *--------------------------------------------------------------------------
7407:     * ConfigurarGridItnOperas - grdItnOperas (itens de UMA operacao de pedido,
7408:     * filtrados pelo Numes corrente de grdCabOperas -> cursor_4c_ItnOperas).
7409:     *--------------------------------------------------------------------------
7410:     PROTECTED PROCEDURE ConfigurarGridItnOperas(par_oPagina)
7411:         LOCAL loc_oGrid
7412: 
7413:         par_oPagina.AddObject("grd_4c_ItnOperas", "Grid")
7414:         loc_oGrid = par_oPagina.grd_4c_ItnOperas

*-- Linhas 7424 a 7457:
7424:             .HeaderHeight  = 16
7425:             .RowHeight     = 15
7426:             .ScrollBars    = 3
7427:             .DeleteMark    = .F.
7428:             .RecordMark    = .F.
7429:             .ReadOnly      = .T.
7430:             .GridLineColor = RGB(128, 128, 128)
7431:             .Visible       = .T.
7432: 
7433:             .RecordSource          = "cursor_4c_ItnOperas"
7434:             .Column1.ControlSource = "cursor_4c_ItnOperas.CItens"
7435:             .Column2.ControlSource = "cursor_4c_ItnOperas.CPros"
7436:             .Column3.ControlSource = "cursor_4c_ItnOperas.DPros"
7437:             .Column4.ControlSource = "cursor_4c_ItnOperas.CUnis"
7438:             .Column5.ControlSource = "cursor_4c_ItnOperas.Qtds"
7439:             .Column6.ControlSource = "cursor_4c_ItnOperas.Units"
7440:             .Column7.ControlSource = "cursor_4c_ItnOperas.Valors"
7441:             .Column8.ControlSource = "cursor_4c_ItnOperas.CodCors"
7442:             .Column9.ControlSource = "cursor_4c_ItnOperas.CodTams"
7443:         ENDWITH
7444: 
7445:         WITH loc_oGrid.Column1
7446:             .Alignment         = 3
7447:             .Header1.Caption   = "Ord."
7448:             .Header1.Alignment = 2
7449:             .Header1.FontSize  = 8
7450:         ENDWITH
7451: 
7452:         WITH loc_oGrid.Column2
7453:             .Header1.Caption   = "C" + CHR(243) + "digo"
7454:             .Header1.Alignment = 2
7455:             .Header1.FontSize  = 8
7456:         ENDWITH
7457: 

*-- Linhas 7598 a 7649:
7598:     * aparece (a coluna continua desenhando o Text1 dela) - e Column.ReadOnly
7599:     * tem de vir DEPOIS de Grid.ReadOnly, que propaga para as colunas.
7600:     *
7601:     * Column.Width por ULTIMO: mexer em RecordSource/ControlSource faz o VFP
7602:     * recalcular todas as larguras para o default.
7603:     *--------------------------------------------------------------------------
7604:     PROTECTED PROCEDURE ConfigurarGridOperacoes(par_oPagina)
7605:         LOCAL loc_oGrid
7606: 
7607:         par_oPagina.AddObject("grd_4c_Operacoes", "Grid")
7608:         loc_oGrid = par_oPagina.grd_4c_Operacoes
7609: 
7610:         WITH loc_oGrid
7611:             .ColumnCount       = 6
7612:             .Top               = 25
7613:             .Left              = 250
7614:             .Width             = 407
7615:             .Height            = 244
7616:             .FontName          = "Tahoma"
7617:             .FontSize          = 8
7618:             .RowHeight         = 16
7619:             .ScrollBars        = 2
7620:             .DeleteMark        = .F.
7621:             .RecordMark        = .F.
7622:             .AllowHeaderSizing = .F.
7623:             .AllowRowSizing    = .F.
7624:             .ReadOnly          = .F.
7625:             .GridLineColor     = RGB(128, 128, 128)
7626:             .Visible           = .T.
7627: 
7628:             .RecordSource          = "cursor_4c_Movimentacao"
7629:             .Column1.ControlSource = "cursor_4c_Movimentacao.Marcas"
7630:             .Column2.ControlSource = "cursor_4c_Movimentacao.Datas"
7631:             .Column3.ControlSource = "cursor_4c_Movimentacao.Emps"
7632:             .Column4.ControlSource = "cursor_4c_Movimentacao.Dopes"
7633:             .Column5.ControlSource = "cursor_4c_Movimentacao.Numes"
7634:             .Column6.ControlSource = "cursor_4c_Movimentacao.Itens"
7635:         ENDWITH
7636: 
7637:         IF !PEMSTATUS(loc_oGrid.Column1, "chk_4c_Marcas", 5)
7638:             loc_oGrid.Column1.AddObject("chk_4c_Marcas", "CheckBox")
7639:         ENDIF
7640: 
7641:         WITH loc_oGrid.Column1.chk_4c_Marcas
7642:             .Top       = 9
7643:             .Left      = 2
7644:             .Height    = 17
7645:             .Width     = 22
7646:             .FontName  = "Arial"
7647:             .FontSize  = 8
7648:             .Alignment = 0
7649:             .Caption   = ""

*-- Linhas 7761 a 7791:
7761:             .FontSize      = 8
7762:             .RowHeight     = 16
7763:             .ScrollBars    = 2
7764:             .DeleteMark    = .F.
7765:             .RecordMark    = .F.
7766:             .ReadOnly      = .T.
7767:             .GridLineColor = RGB(128, 128, 128)
7768:             .Visible       = .T.
7769: 
7770:             .RecordSource          = "cursor_4c_CotasPendentes"
7771:             .Column1.ControlSource = "cursor_4c_CotasPendentes.Codigos"
7772:             .Column2.ControlSource = "cursor_4c_CotasPendentes.DtSolics"
7773:             .Column3.ControlSource = "cursor_4c_CotasPendentes.Solicitas"
7774:             .Column4.ControlSource = "cursor_4c_CotasPendentes.Deptos"
7775:             .Column5.ControlSource = "cursor_4c_CotasPendentes.Prioris"
7776:             .Column6.ControlSource = "cursor_4c_CotasPendentes.DtCotas"
7777:         ENDWITH
7778: 
7779:         WITH loc_oGrid.Column1
7780:             .FontSize          = 8
7781:             .FontBold          = .T.
7782:             .Alignment         = 3
7783:             .Movable           = .F.
7784:             .Resizable         = .F.
7785:             .Sparse            = .F.
7786:             .Header1.Caption   = "C" + CHR(243) + "digo"
7787:             .Header1.Alignment = 2
7788:             .Header1.FontSize  = 8
7789:             .Text1.FontBold    = .T.
7790:             .Text1.FontSize    = 8
7791:             .Text1.Alignment   = 3

*-- Linhas 7914 a 8040:
7914: 
7915:                 IF VARTYPE(loc_oProgresso) = "O"
7916:                     loc_oProgresso.Show()
7917:                     loc_oProgresso.Update("Montando Telas", .T.)
7918:                 ENDIF
7919: 
7920:                 ZAP IN cursor_4c_Movimentacao
7921:                 ZAP IN cursor_4c_CotasPendentes
7922: 
7923:                 loc_cDtI = FormatarDataSQL(THIS.this_dDtPerI)
7924:                 loc_cDtF = FormatarDataSQL(DTOT(THIS.this_dDtPerF) + 86399)
7925: 
7926:                 *-- Filtro de operacao/empresa transcrito do legado: com a
7927:                 *-- empresa informada ele troca Dopes por uma faixa de
7928:                 *-- EmpDopNums (Emps + Dopes + Numes de 0 a 999999).
7929:                 IF EMPTY(THIS.this_cEmps)
7930:                     loc_cFiltro = "a.Dopes = " + EscaparSQL(PADR(THIS.this_cDopes, 20))
7931:                 ELSE
7932:                     loc_cEd1 = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(0, 6)
7933:                     loc_cEd2 = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(999999, 6)
7934:                     loc_cFiltro = "a.EmpDopNums BETWEEN " + EscaparSQL(loc_cEd1) + ;
7935:                                   " AND " + EscaparSQL(loc_cEd2)
7936:                 ENDIF
7937: 
7938:                 IF !EMPTY(THIS.this_cJobs)
7939:                     loc_cFiltro = loc_cFiltro + " AND a.Jobs = " + EscaparSQL(THIS.this_cJobs)
7940:                 ENDIF
7941: 
7942:                 IF VARTYPE(loc_oProgresso) = "O"
7943:                     loc_oProgresso.Update("Selecionando Opera" + CHR(231) + CHR(245) + ;
7944:                         "es Pendentes", .T.)
7945:                 ENDIF
7946: 
7947:                 loc_cSQL = "SELECT a.Datas, a.Emps, a.Dopes, a.Numes, b.CItens, " + ;
7948:                            "(b.Qtds - b.QtBaixas) AS Qtds, " + ;
7949:                            "a.ChkBxParcs, a.ChkPagos, a.ChkSubn, a.LCancelas, a.Nops, " + ;
7950:                            "a.ProcBals, a.ProcDBal, " + ;
7951:                            "d.Destinos, d.EstDests, d.EstOrigs, d.Origems, d.Produc, a.Jobs " + ;
7952:                            "FROM SigMvCab a, SigMvItn b, SigCdPro c, SigCdOpe d " + ;
7953:                            "WHERE a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + " AND " + ;
7954:                            "a.ChkSubn = 0 AND " + loc_cFiltro + " AND " + ;
7955:                            "a.EmpDopNums = b.EmpDopNums AND " + ;
7956:                            "(b.Qtds - b.QtBaixas) > 0 AND " + ;
7957:                            "b.CPros = c.CPros AND " + ;
7958:                            "a.Dopes = d.Dopes " + ;
7959:                            "ORDER BY a.Datas, a.Emps, a.Dopes, a.Numes, b.CItens"
7960: 
7961:                 IF USED("cursor_4c_MovTemp")
7962:                     USE IN cursor_4c_MovTemp
7963:                 ENDIF
7964: 
7965:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MovTemp")
7966: 
7967:                 IF loc_nResultado < 1
7968:                     MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
7969:                         "Falha na Conex" + CHR(227) + "o (Movimenta" + CHR(231) + ;
7970:                         CHR(245) + "es)")
7971:                     loc_lProsseguir = .F.
7972:                 ENDIF
7973:             ENDIF
7974: 
7975:             IF loc_lProsseguir
7976:                 IF VARTYPE(loc_oProgresso) = "O"
7977:                     loc_oProgresso.Update("Processando Dados Das Opera" + CHR(231) + ;
7978:                         CHR(245) + "es Pendentes", .T.)
7979:                 ENDIF
7980: 
7981:                 *-- Elimina as movimentacoes ja utilizadas em cotacoes
7982:                 *-- anteriores: o saldo cotado (SigCtTCt) desconta a quantidade
7983:                 *-- em aberto e o que zerar sai da lista.
7984:                 SELECT cursor_4c_MovTemp
7985:                 SCAN
7986:                     loc_nSaldo = NVL(cursor_4c_MovTemp.Qtds, 0)
7987:                     loc_cEdn   = cursor_4c_MovTemp.Emps + cursor_4c_MovTemp.Dopes + ;
7988:                                  STR(cursor_4c_MovTemp.Numes, 6)
7989: 
7990:                     loc_cSQL = "SELECT a.EmpDopNums, a.CItens, a.Qtds " + ;
7991:                                "FROM SigCtTCt a " + ;
7992:                                "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + " AND " + ;
7993:                                "a.CItens = " + ;
7994:                                FormatarNumeroSQL(cursor_4c_MovTemp.CItens, 0) + " " + ;
7995:                                "ORDER BY a.EmpDopNums, a.CItens, a.Qtds"
7996: 
7997:                     IF USED("cursor_4c_CotCtTemp")
7998:                         USE IN cursor_4c_CotCtTemp
7999:                     ENDIF
8000: 
8001:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotCtTemp") > 0
8002:                         SELECT cursor_4c_CotCtTemp
8003:                         GO TOP IN cursor_4c_CotCtTemp
8004:                         IF !EOF("cursor_4c_CotCtTemp")
8005:                             loc_nSaldo = NVL(cursor_4c_MovTemp.Qtds, 0) - ;
8006:                                          NVL(cursor_4c_CotCtTemp.Qtds, 0)
8007:                         ENDIF
8008:                         USE IN cursor_4c_CotCtTemp
8009:                     ENDIF
8010: 
8011:                     SELECT cursor_4c_MovTemp
8012:                     IF !(loc_nSaldo > 0)
8013:                         DELETE IN cursor_4c_MovTemp
8014:                     ENDIF
8015:                 ENDSCAN
8016: 
8017:                 *-- Agrupa por Empresa + Operacao + Numero, somando os itens
8018:                 SELECT cursor_4c_MovTemp
8019:                 SCAN
8020:                     loc_dData = ConverterParaData(NVL(cursor_4c_MovTemp.Datas, {}))
8021:                     loc_cEdn  = cursor_4c_MovTemp.Emps + cursor_4c_MovTemp.Dopes + ;
8022:                                 STR(cursor_4c_MovTemp.Numes, 6)
8023: 
8024:                     IF !SEEK(DTOS(loc_dData) + loc_cEdn, "cursor_4c_Movimentacao", "Ordem")
8025:                         INSERT INTO cursor_4c_Movimentacao ;
8026:                             (Emps, Dopes, Numes, Datas, EmpDopNums, Nops, ChkSubn, ;
8027:                              LCancelas, ChkBxParcs, ChkPagos, ProcBals, ProcDBal, ;
8028:                              Destinos, EstDests, EstOrigs, Origems, Produc, Jobs) ;
8029:                             VALUES ;
8030:                             (cursor_4c_MovTemp.Emps, cursor_4c_MovTemp.Dopes, ;
8031:                              cursor_4c_MovTemp.Numes, loc_dData, loc_cEdn, ;
8032:                              NVL(cursor_4c_MovTemp.Nops, 0), ;
8033:                              ConverterParaLogico(cursor_4c_MovTemp.ChkSubn), ;
8034:                              ConverterParaLogico(cursor_4c_MovTemp.LCancelas), ;
8035:                              ConverterParaLogico(cursor_4c_MovTemp.ChkBxParcs), ;
8036:                              ConverterParaLogico(cursor_4c_MovTemp.ChkPagos), ;
8037:                              ConverterParaLogico(cursor_4c_MovTemp.ProcBals), ;
8038:                              ConverterParaLogico(cursor_4c_MovTemp.ProcDBal), ;
8039:                              NVL(cursor_4c_MovTemp.Destinos, 0), ;
8040:                              NVL(cursor_4c_MovTemp.EstDests, 0), ;

*-- Linhas 8047 a 8163:
8047:                     REPLACE Itens WITH Itens + NVL(cursor_4c_MovTemp.Qtds, 0) ;
8048:                         IN cursor_4c_Movimentacao
8049: 
8050:                     SELECT cursor_4c_MovTemp
8051:                 ENDSCAN
8052: 
8053:                 IF USED("cursor_4c_MovTemp")
8054:                     USE IN cursor_4c_MovTemp
8055:                 ENDIF
8056: 
8057:                 SELECT cursor_4c_Movimentacao
8058:                 GO TOP IN cursor_4c_Movimentacao
8059: 
8060:                 THIS.AplicarCoresGridOperacoes()
8061: 
8062:                 IF VARTYPE(loc_oProgresso) = "O"
8063:                     loc_oProgresso.Update("Carregando as Cota" + CHR(231) + CHR(245) + ;
8064:                         "es Pendentes", .T.)
8065:                 ENDIF
8066: 
8067:                 *-- Cotacoes ja realizadas: as que estao em aberto (Situas = 0)
8068:                 *-- mais as que geraram pedido dentro do periodo filtrado
8069:                 loc_cSQL = "SELECT a.Situas, a.Codigos, a.DtSolics, a.Solicitas, " + ;
8070:                            "a.Deptos, a.Prioris, a.DtCotas, a.DtAprovs, a.Aprovador, " + ;
8071:                            "a.ContaEs, a.LocalEnts, a.Justificas, a.Copias " + ;
8072:                            "FROM SigCtTDc a " + ;
8073:                            "WHERE a.Situas = 0 OR " + ;
8074:                            "(NOT a.Situas = 0 AND a.DtCotas BETWEEN " + ;
8075:                            loc_cDtI + " AND " + loc_cDtF + ") " + ;
8076:                            "ORDER BY a.Codigos"
8077: 
8078:                 IF USED("cursor_4c_CotDcTemp")
8079:                     USE IN cursor_4c_CotDcTemp
8080:                 ENDIF
8081: 
8082:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotDcTemp")
8083: 
8084:                 IF loc_nResultado < 1
8085:                     MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
8086:                         "Falha na Conex" + CHR(227) + "o (Cota" + CHR(231) + CHR(245) + "es)")
8087:                     loc_lProsseguir = .F.
8088:                 ENDIF
8089:             ENDIF
8090: 
8091:             IF loc_lProsseguir
8092:                 SELECT cursor_4c_CotDcTemp
8093:                 SCAN
8094:                     IF NVL(cursor_4c_CotDcTemp.Situas, 0) <> 0
8095:                         loc_cPrioridade = "Ped.Gerado"
8096:                     ELSE
8097:                         DO CASE
8098:                             CASE NVL(cursor_4c_CotDcTemp.Prioris, 0) = 3
8099:                                 loc_cPrioridade = "Alta"
8100:                             CASE NVL(cursor_4c_CotDcTemp.Prioris, 0) = 2
8101:                                 loc_cPrioridade = "M" + CHR(233) + "dia"
8102:                             OTHERWISE
8103:                                 loc_cPrioridade = "Normal"
8104:                         ENDCASE
8105:                     ENDIF
8106: 
8107:                     INSERT INTO cursor_4c_CotasPendentes ;
8108:                         (Situas, Codigos, DtSolics, Solicitas, Deptos, Prioris, ;
8109:                          DtCotas, DtAprovs, Aprovador, ContaEs, LocalEnts, ;
8110:                          Justificas, Copias) ;
8111:                         VALUES ;
8112:                         (NVL(cursor_4c_CotDcTemp.Situas, 0), ;
8113:                          NVL(cursor_4c_CotDcTemp.Codigos, 0), ;
8114:                          ConverterParaData(NVL(cursor_4c_CotDcTemp.DtSolics, {})), ;
8115:                          NVL(cursor_4c_CotDcTemp.Solicitas, ""), ;
8116:                          NVL(cursor_4c_CotDcTemp.Deptos, ""), ;
8117:                          loc_cPrioridade, ;
8118:                          ConverterParaData(NVL(cursor_4c_CotDcTemp.DtCotas, {})), ;
8119:                          ConverterParaData(NVL(cursor_4c_CotDcTemp.DtAprovs, {})), ;
8120:                          NVL(cursor_4c_CotDcTemp.Aprovador, ""), ;
8121:                          NVL(cursor_4c_CotDcTemp.ContaEs, ""), ;
8122:                          NVL(cursor_4c_CotDcTemp.LocalEnts, 0), ;
8123:                          NVL(cursor_4c_CotDcTemp.Justificas, ""), ;
8124:                          NVL(cursor_4c_CotDcTemp.Copias, 0))
8125: 
8126:                     SELECT cursor_4c_CotDcTemp
8127:                 ENDSCAN
8128: 
8129:                 IF USED("cursor_4c_CotDcTemp")
8130:                     USE IN cursor_4c_CotDcTemp
8131:                 ENDIF
8132: 
8133:                 IF VARTYPE(loc_oProgresso) = "O"
8134:                     loc_oProgresso.Complete(.T.)
8135:                     loc_oProgresso = .NULL.
8136:                 ENDIF
8137: 
8138:                 IF RECCOUNT("cursor_4c_Movimentacao") < 1 AND ;
8139:                    RECCOUNT("cursor_4c_CotasPendentes") < 1
8140:                     MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Processar!!!", ;
8141:                         "Aten" + CHR(231) + CHR(227) + "o!!!")
8142:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DtPerI.SetFocus()
8143:                 ELSE
8144:                     *-- Popular o cursor NAO repinta a grade: GO TOP + Refresh
8145:                     SELECT cursor_4c_CotasPendentes
8146:                     GO TOP IN cursor_4c_CotasPendentes
8147: 
8148:                     SELECT cursor_4c_Movimentacao
8149:                     GO TOP IN cursor_4c_Movimentacao
8150: 
8151:                     loc_oPag.obj_4c_CmdProblemas.Visible = THIS.PossuiAcessoCotacaoLivre()
8152: 
8153:                     loc_oPag.grd_4c_Operacoes.Refresh()
8154:                     loc_oPag.grd_4c_CotaPends.Refresh()
8155: 
8156:                     THIS.AjustarBotoesPorModo()
8157: 
8158:                     loc_lSucesso = .T.
8159:                 ENDIF
8160:             ENDIF
8161:         CATCH TO loc_oErro
8162:             MsgErro(loc_oErro.Message + CHR(13) + ;
8163:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 8365 a 8418:
8365:         IF cursor_4c_Movimentacao.Marcas AND !EMPTY(cursor_4c_Movimentacao.Jobs)
8366:             loc_cJob = cursor_4c_Movimentacao.Jobs
8367: 
8368:             SELECT EmpDopNums ;
8369:               FROM cursor_4c_Movimentacao ;
8370:              WHERE Marcas AND Jobs <> m.loc_cJob ;
8371:               INTO CURSOR cursor_4c_MarcaJob
8372: 
8373:             IF !EOF("cursor_4c_MarcaJob")
8374:                 MsgAviso("N" + CHR(227) + "o " + CHR(233) + " permitido marcar " + ;
8375:                     "movimenta" + CHR(231) + CHR(227) + "o de jobs diferentes.", "Aviso")
8376:                 REPLACE Marcas WITH !Marcas IN cursor_4c_Movimentacao
8377:                 loc_oGrid.Refresh()
8378:             ENDIF
8379: 
8380:             IF USED("cursor_4c_MarcaJob")
8381:                 USE IN cursor_4c_MarcaJob
8382:             ENDIF
8383: 
8384:             SELECT cursor_4c_Movimentacao
8385:         ENDIF
8386:     ENDPROC
8387: 
8388:     *--------------------------------------------------------------------------
8389:     * BtnMarcarTodasClick / BtnDesmarcarTodasClick - Marcam ou desmarcam todas
8390:     * as movimentacoes (cmdMarcaDesmarca.Click do legado:
8391:     * Update crOperacoes Set Marcas = (This.Value = 1)).
8392:     *--------------------------------------------------------------------------
8393:     PROCEDURE BtnMarcarTodasClick()
8394:         IF USED("cursor_4c_Movimentacao")
8395:             UPDATE cursor_4c_Movimentacao SET Marcas = .T.
8396:             GO TOP IN cursor_4c_Movimentacao
8397:             THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Refresh()
8398:         ENDIF
8399:     ENDPROC
8400: 
8401:     PROCEDURE BtnDesmarcarTodasClick()
8402:         IF USED("cursor_4c_Movimentacao")
8403:             UPDATE cursor_4c_Movimentacao SET Marcas = .F.
8404:             GO TOP IN cursor_4c_Movimentacao
8405:             THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Refresh()
8406:         ENDIF
8407:     ENDPROC
8408: 
8409:     *--------------------------------------------------------------------------
8410:     * BtnRetornarFiltrosClick - cmdBotoes.btnSair.Click da pagina Dados:
8411:     * volta para a pagina de Filtros com o foco na data inicial.
8412:     *--------------------------------------------------------------------------
8413:     PROCEDURE BtnRetornarFiltrosClick()
8414:         THIS.this_cModoAtual = "FILTROS"
8415:         THIS.AlternarPagina(1)
8416:         THIS.pgf_4c_Paginas.Page1.txt_4c_DtPerI.SetFocus()
8417:     ENDPROC
8418: 

*-- Linhas 8494 a 8571:
8494:             ENDIF
8495: 
8496:             IF loc_lProsseguir
8497:                 SELECT EmpDopNums, Jobs ;
8498:                   FROM cursor_4c_Movimentacao ;
8499:                  WHERE Marcas ;
8500:                   INTO CURSOR cursor_4c_CotarProds
8501: 
8502:                 GO TOP IN cursor_4c_CotarProds
8503: 
8504:                 IF EOF("cursor_4c_CotarProds")
8505:                     MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Foi Selecionada " + ;
8506:                         "Para Gerar Cota" + CHR(231) + CHR(245) + "es!!!", ;
8507:                         "Aten" + CHR(231) + CHR(227) + "o!!!")
8508:                     loc_lProsseguir = .F.
8509:                 ELSE
8510:                     THIS.this_cJobs = ALLTRIM(cursor_4c_CotarProds.Jobs)
8511:                 ENDIF
8512: 
8513:                 SELECT cursor_4c_Movimentacao
8514:             ENDIF
8515:         ENDIF
8516: 
8517:         IF loc_lProsseguir
8518:             THIS.this_nCodigoSelecionado = 0
8519:             THIS.this_oBusinessObject.NovoRegistro()
8520:             THIS.PreencherPadroesNovaCotacao(par_lDaGrade)
8521:             THIS.PopularCamposCotacaoNoFormulario()
8522:             THIS.ZerarCursoresCotacao()
8523: 
8524:             THIS.this_cModoAtual = "COTACOES"
8525:             THIS.AlternarPagina(3)
8526:             THIS.AjustarCamposCotacao()
8527: 
8528:             loc_lSucesso = .T.
8529:         ENDIF
8530: 
8531:         RETURN loc_lSucesso
8532:     ENDPROC
8533: 
8534:     *--------------------------------------------------------------------------
8535:     * PreencherPadroesNovaCotacao - Equivalente ao INSERT INTO crSigCtTDc do
8536:     * PROCEDURE geracotacao legado: Solicitas/Comprador = usuario logado,
8537:     * DtSolics = data da movimentacao (ou hoje, se sem origem), DtCotas =
8538:     * hoje, DtValids = hoje + NDdVals (SigOpCdc.Dopes), Prioris = 1 (Normal).
8539:     *--------------------------------------------------------------------------
8540:     PROTECTED PROCEDURE PreencherPadroesNovaCotacao(par_lDaGrade)
8541:         LOCAL loc_oBO, loc_nDias, loc_dDtSolic
8542: 
8543:         loc_oBO = THIS.this_oBusinessObject
8544:         IF VARTYPE(loc_oBO) != "O"
8545:             RETURN
8546:         ENDIF
8547: 
8548:         loc_dDtSolic = DATE()
8549:         IF par_lDaGrade AND USED("cursor_4c_Movimentacao") AND !EOF("cursor_4c_Movimentacao")
8550:             loc_dDtSolic = ConverterParaData(cursor_4c_Movimentacao.Datas)
8551:         ENDIF
8552: 
8553:         loc_nDias = 0
8554:         IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) AND !EMPTY(THIS.this_cDopes)
8555:             IF SQLEXEC(gnConnHandle, "SELECT NDdVals FROM SigOpCdc WHERE Dopes = " + ;
8556:                 EscaparSQL(PADR(THIS.this_cDopes, 20)), "cursor_4c_NDdValsTmp") > 0 AND ;
8557:                USED("cursor_4c_NDdValsTmp") AND !EOF("cursor_4c_NDdValsTmp")
8558:                 loc_nDias = NVL(cursor_4c_NDdValsTmp.NDdVals, 0)
8559:             ENDIF
8560:             IF USED("cursor_4c_NDdValsTmp")
8561:                 USE IN cursor_4c_NDdValsTmp
8562:             ENDIF
8563:         ENDIF
8564: 
8565:         loc_oBO.this_cSolicitas  = gc_4c_UsuarioLogado
8566:         loc_oBO.this_cAprSols    = gc_4c_UsuarioLogado
8567:         loc_oBO.this_cComprador  = gc_4c_UsuarioLogado
8568:         loc_oBO.this_dDtSolics   = loc_dDtSolic
8569:         loc_oBO.this_dDtCotas    = DATE()
8570:         loc_oBO.this_dDtValids   = DATE() + loc_nDias
8571:         loc_oBO.this_nPrioris    = 1

*-- Linhas 8589 a 8624:
8589:     *--------------------------------------------------------------------------
8590:     * ZerarCursoresCotacao - Cotacao NOVA: ZAP dos cursores das grades e uma
8591:     * linha de fornecedor por letra (A..F, Fretes = "Emitente" por padrao) +
8592:     * uma linha de produto em branco - transcrito do INSERT INTO crSigCtTFn/
8593:     * crSigCtTCt do PROCEDURE geracotacao legado (Reccount = 0 -> ramo Else).
8594:     *--------------------------------------------------------------------------
8595:     PROTECTED PROCEDURE ZerarCursoresCotacao()
8596:         LOCAL loc_nI
8597: 
8598:         IF !USED("cursor_4c_Produtos")
8599:             THIS.CriarCursoresCotacao()
8600:         ENDIF
8601: 
8602:         ZAP IN cursor_4c_Produtos
8603:         ZAP IN cursor_4c_Fornecedores
8604: 
8605:         INSERT INTO cursor_4c_Produtos (cIdChaves, Codigos, CItens, CPros, DPros, Obs, Qtds, CUnis, QtdAdqs) ;
8606:             VALUES (LEFT(fUniqueIds(), 20), 0, 1, "", "", "", 0, "", 0)
8607: 
8608:         FOR loc_nI = 1 TO 6
8609:             INSERT INTO cursor_4c_Fornecedores (cIdChaves, Codigos, Grades, Fretes) ;
8610:                 VALUES (LEFT(fUniqueIds(), 20), 0, CHR(64 + loc_nI), "Emitente")
8611:         ENDFOR
8612: 
8613:         GO TOP IN cursor_4c_Produtos
8614:         GO TOP IN cursor_4c_Fornecedores
8615: 
8616:         IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5) AND PEMSTATUS(THIS.pgf_4c_Paginas.Page3, "grd_4c_Produtos", 5)
8617:             THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
8618:             THIS.pgf_4c_Paginas.Page3.grd_4c_Fornecedores.Refresh()
8619:             THIS.GridCotacoesAfterRowColChange(1)
8620:         ENDIF
8621:     ENDPROC
8622: 
8623:     *--------------------------------------------------------------------------
8624:     * AlteraCotacao - Leva para a pagina de Cotacoes a cotacao SELECIONADA na

*-- Linhas 8709 a 8757:
8709:     *--------------------------------------------------------------------------
8710:     * CarregarCotacaoSelecionada - Le o cabecalho da cotacao (SigCtTDc) e o
8711:     * entrega ao Business Object. Equivale ao primeiro bloco do PROCEDURE
8712:     * alteracotacao legado (SqlExecute + Scatter/Insert em crSigCtTDc), aqui
8713:     * com o cabecalho vivendo nas propriedades do BO.
8714:     *--------------------------------------------------------------------------
8715:     PROTECTED PROCEDURE CarregarCotacaoSelecionada(par_nCodigo)
8716:         LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
8717: 
8718:         loc_lSucesso = .F.
8719: 
8720:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
8721:             RETURN .T.
8722:         ENDIF
8723: 
8724:         IF !(TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
8725:             RETURN .F.
8726:         ENDIF
8727: 
8728:         TRY
8729:             loc_cSQL = "SELECT * FROM SigCtTDc WHERE Codigos = " + ;
8730:                        FormatarNumeroSQL(par_nCodigo, 0) + " ORDER BY Codigos"
8731: 
8732:             IF USED("cursor_4c_CotacaoAtual")
8733:                 USE IN cursor_4c_CotacaoAtual
8734:             ENDIF
8735: 
8736:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotacaoAtual")
8737: 
8738:             IF loc_nResultado < 1
8739:                 MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
8740:                     "Falha na Conex" + CHR(227) + "o (Cota" + CHR(231) + CHR(227) + "o)")
8741:             ELSE
8742:                 SELECT cursor_4c_CotacaoAtual
8743:                 GO TOP IN cursor_4c_CotacaoAtual
8744: 
8745:                 IF EOF("cursor_4c_CotacaoAtual")
8746:                     MsgAviso("Cota" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
8747:                         "o encontrada: " + ALLTRIM(TRANSFORM(par_nCodigo)), ;
8748:                         "Aten" + CHR(231) + CHR(227) + "o!!!")
8749:                 ELSE
8750:                     THIS.this_oBusinessObject.EditarRegistro()
8751:                     loc_lSucesso = ;
8752:                         THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_CotacaoAtual")
8753: 
8754:                     IF loc_lSucesso
8755:                         THIS.CarregarItensEFornecedoresCotacao(par_nCodigo)
8756:                         THIS.PopularCamposCotacaoNoFormulario()
8757:                         THIS.AjustarCamposCotacao()

*-- Linhas 8774 a 8813:
8774:     *--------------------------------------------------------------------------
8775:     * CarregarItensEFornecedoresCotacao - Le SigCtTCt/SigCtTFn da cotacao
8776:     * <par_nCodigo> para cursor_4c_Produtos/cursor_4c_Fornecedores (equivalente
8777:     * ao SELECT * ... Order By Codigos, CItens/Grades do PROCEDURE
8778:     * alteracotacao legado - aqui usado tanto por Alterar quanto Consultar/
8779:     * Excluir, ja que a estrutura de carga eh identica).
8780:     *--------------------------------------------------------------------------
8781:     PROTECTED PROCEDURE CarregarItensEFornecedoresCotacao(par_nCodigo)
8782:         LOCAL loc_cSQL, loc_nResultado
8783: 
8784:         IF !USED("cursor_4c_Produtos")
8785:             THIS.CriarCursoresCotacao()
8786:         ENDIF
8787: 
8788:         ZAP IN cursor_4c_Produtos
8789:         ZAP IN cursor_4c_Fornecedores
8790: 
8791:         loc_cSQL = "SELECT * FROM SigCtTCt WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
8792:             " ORDER BY Codigos, CItens"
8793:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosTemp")
8794: 
8795:         IF loc_nResultado > 0 AND USED("cursor_4c_ProdutosTemp")
8796:             SELECT cursor_4c_ProdutosTemp
8797:             SCAN
8798:                 INSERT INTO cursor_4c_Produtos (cIdChaves, Codigos, CItens, CPros, DPros, CUnis, CodCors, CodTams, ;
8799:                         EmpDopNums, Obs, Justificas, Qtds, QtdAdqs, ValAdqs, ;
8800:                         Marca01, Marca02, Marca03, Marca04, Marca05, Marca06, ;
8801:                         Unit01, Unit02, Unit03, Unit04, Unit05, Unit06, ;
8802:                         Tota01, Tota02, Tota03, Tota04, Tota05, Tota06) ;
8803:                     VALUES (cursor_4c_ProdutosTemp.cIdChaves, cursor_4c_ProdutosTemp.Codigos, ;
8804:                         cursor_4c_ProdutosTemp.CItens, ALLTRIM(cursor_4c_ProdutosTemp.CPros), ;
8805:                         ALLTRIM(cursor_4c_ProdutosTemp.DPros), ALLTRIM(cursor_4c_ProdutosTemp.CUnis), ;
8806:                         ALLTRIM(NVL(cursor_4c_ProdutosTemp.CodCors, "")), ALLTRIM(NVL(cursor_4c_ProdutosTemp.CodTams, "")), ;
8807:                         ALLTRIM(NVL(cursor_4c_ProdutosTemp.EmpDopNums, "")), NVL(cursor_4c_ProdutosTemp.Obs, ""), ;
8808:                         NVL(cursor_4c_ProdutosTemp.Justificas, ""), cursor_4c_ProdutosTemp.Qtds, ;
8809:                         cursor_4c_ProdutosTemp.QtdAdqs, cursor_4c_ProdutosTemp.ValAdqs, ;
8810:                         ConverterParaLogico(cursor_4c_ProdutosTemp.Marca01), ConverterParaLogico(cursor_4c_ProdutosTemp.Marca02), ;
8811:                         ConverterParaLogico(cursor_4c_ProdutosTemp.Marca03), ConverterParaLogico(cursor_4c_ProdutosTemp.Marca04), ;
8812:                         ConverterParaLogico(cursor_4c_ProdutosTemp.Marca05), ConverterParaLogico(cursor_4c_ProdutosTemp.Marca06), ;
8813:                         cursor_4c_ProdutosTemp.Unit01, cursor_4c_ProdutosTemp.Unit02, cursor_4c_ProdutosTemp.Unit03, ;

*-- Linhas 8821 a 8850:
8821:         *-- Sem linhas (nao deveria acontecer, mas o legado sempre garante ao
8822:         *-- menos 1 linha para a grade nao ficar sem cursor posicionavel)
8823:         IF RECCOUNT("cursor_4c_Produtos") < 1
8824:             INSERT INTO cursor_4c_Produtos (cIdChaves, Codigos, CItens, CPros, DPros, Obs, Qtds, CUnis, QtdAdqs) ;
8825:                 VALUES (LEFT(fUniqueIds(), 20), par_nCodigo, 1, "", "", "", 0, "", 0)
8826:         ENDIF
8827: 
8828:         loc_cSQL = "SELECT * FROM SigCtTFn WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
8829:             " ORDER BY Codigos, Grades"
8830:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FornecTemp")
8831: 
8832:         IF loc_nResultado > 0 AND USED("cursor_4c_FornecTemp")
8833:             SELECT cursor_4c_FornecTemp
8834:             SCAN
8835:                 INSERT INTO cursor_4c_Fornecedores (cIdChaves, Codigos, Grades, IClis, Fornecs, Contatos, ;
8836:                         Tel1s, FPags, DtEnts, Fretes, VlFretes) ;
8837:                     VALUES (cursor_4c_FornecTemp.cIdChaves, cursor_4c_FornecTemp.Codigos, cursor_4c_FornecTemp.Grades, ;
8838:                         ALLTRIM(cursor_4c_FornecTemp.IClis), ALLTRIM(cursor_4c_FornecTemp.Fornecs), ;
8839:                         ALLTRIM(cursor_4c_FornecTemp.Contatos), ALLTRIM(cursor_4c_FornecTemp.Tel1s), ;
8840:                         ALLTRIM(cursor_4c_FornecTemp.FPags), ConverterParaData(NVL(cursor_4c_FornecTemp.DtEnts, {})), ;
8841:                         ALLTRIM(NVL(cursor_4c_FornecTemp.Fretes, "Emitente")), NVL(cursor_4c_FornecTemp.VlFretes, 0))
8842:             ENDSCAN
8843:             USE IN cursor_4c_FornecTemp
8844:         ENDIF
8845: 
8846:         GO TOP IN cursor_4c_Produtos
8847:         GO TOP IN cursor_4c_Fornecedores
8848: 
8849:         IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5) AND PEMSTATUS(THIS.pgf_4c_Paginas.Page3, "grd_4c_Produtos", 5)
8850:             THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()

*-- Linhas 8864 a 8884:
8864:     * fora da classe (chamada externa estoura "Property FORMPARABO is not
8865:     * found", mesmo com PEMSTATUS devolvendo .T. - CLAUDE.md regra #3).
8866:     *
8867:     * No legado cada um desses campos tem ControlSource apontando direto para
8868:     * crSigCtTDc, entao o que o usuario digitou ja esta no cursor quando o
8869:     * btnGravaDados dispara. Aqui nao ha ControlSource: os Validar<X> so
8870:     * escrevem no BO quando o campo perde o foco ou recebe Enter/Tab. Sem esta
8871:     * varredura, o que foi digitado e gravado direto no botao (sem sair do
8872:     * campo) - data de cotacao/validade/pagamento, prioridade, departamento -
8873:     * se perderia em silencio. Chamado por GravaDados antes do Salvar().
8874:     *
8875:     * NAO recolhe os campos abaixo, de proposito - o dono deles e outro:
8876:     *   this_cCidChaves / this_nCodigos - gerados pelo BO no primeiro Inserir
8877:     *                                     (os TextBox sao ReadOnly, exibicao)
8878:     *   this_nCopias                    - definido por CopiaCotacao (ReadOnly)
8879:     *   this_nSituas                    - definido por GravaPedidos
8880:     *   this_nLocalEnts                 - definido pelo dialogo SigCdEnd
8881:     *   this_nChkAprovs                 - flag da maquina de aprovacao. Quem
8882:     *                                     manda nele sao ChkAprovadorClick e
8883:     *                                     AprovarCotacao, que o ZERAM no BO e
8884:     *                                     so DEPOIS de GravaDados zeram o

*-- Linhas 8933 a 8951:
8933:     *--------------------------------------------------------------------------
8934:     * BOParaForm - Caminho inverso de FormParaBO: espelha as propriedades do
8935:     * cabecalho da cotacao (SigCtTDc, no BusinessObject) nos controles da
8936:     * pagina de Cotacoes. E o que o legado obtem de graca pelo ControlSource
8937:     * ligado a crSigCtTDc. Chamado sempre que uma cotacao NOVA ou EXISTENTE e
8938:     * carregada no BO (GeraCotacao / AlteraCotacao / CopiaCotacao, atraves de
8939:     * PopularCamposCotacaoNoFormulario) e depois do Salvar(), para o Codigo
8940:     * recem-gerado aparecer na tela.
8941:     *
8942:     * this_cDContaEs e a unica descricao de lookup com controle proprio; as
8943:     * demais (this_cDComprador/DDeptos/DSolicitas/DAprovador/DAprSols) nao tem
8944:     * TextBox na tela - o legado tambem so exibe o codigo nesses campos.
8945:     *
8946:     * Override do hook PROTECTED de FormBase (formbase.prg:280) - ver a nota
8947:     * de escopo em FormParaBO.
8948:     *--------------------------------------------------------------------------
8949:     PROTECTED PROCEDURE BOParaForm()
8950:         LOCAL loc_oBO, loc_oPag, loc_oAdic, loc_oApr, loc_oSol
8951: 


### BO (C:\4c\projeto\app\classes\sigmvcotBO.prg):
*============================================================================
* sigmvcotBO.prg - Business Object para Cotacao de Compras
*
* Tabela principal : SigCtTDc  (PK: cidchaves char(20), business key: codigos)
* Tabela fornecs    : SigCtTFn  (FK: cidchaves)
* Tabela itens/prods: SigCtTCt  (FK: cidchaves)
*
* Form legado (SIGMVCOT) e um form OPERACIONAL com 4 paginas:
*   Filtros -> Dados (movimentacoes) -> Cotacoes (fornecedores/produtos) -> Pedidos
* As grades (Movimentacoes, Cotacoes em Aberto, Fornecedores, Produtos,
* Pedidos/Itens de Pedido) sao manipuladas via cursores populados por
* SQLEXEC (ver aliases HIDDEN abaixo) - nao viram propriedades this_ do BO,
* que representa apenas o cabecalho da Cotacao (SigCtTDc) sendo editado.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS sigmvcotBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigCtTDc (campos do banco)
    *==========================================================================
    this_cCidChaves  = ""   && char(20) NOT NULL - Chave primaria Fortyus (fUniqueIds())
    this_nCodigos    = 0    && numeric(6,0) NOT NULL - Codigo da cotacao (chave de negocio)
    this_cComprador  = ""   && char(12) NOT NULL - Usuario comprador (SigCdUsu.Usuarios)
    this_cDeptos     = ""   && char(10) NOT NULL - Departamento solicitante (SigCdDpt.Codigos)
    this_dDtCotas    = {}   && datetime NULL - Data da cotacao
    this_dDtPagtos   = {}   && datetime NULL - Data de pagamento
    this_dDtSolics   = {}   && datetime NULL - Data da solicitacao
    this_dDtValids   = {}   && datetime NULL - Data de validade da cotacao
    this_cJustificas = ""   && text NULL - Justificativa geral da cotacao
    this_nPrioris    = 0    && numeric(1,0) NOT NULL - Prioridade (1=Normal,2=Media,3=Alta)
    this_nSituas     = 0    && numeric(1,0) NOT NULL - Situacao (0=Em cotacao, >0=Pedido gerado)
    this_cSolicitas  = ""   && char(10) NOT NULL - Usuario solicitante (SigCdUsu.Usuarios)
    this_cAprovador  = ""   && char(10) NOT NULL - Usuario aprovador (SigCdUsu.Usuarios)
    this_cAprSols    = ""   && char(10) NOT NULL - Usuario que aprova a solicitacao
    this_nChkAprovs  = 0    && numeric(1,0) NOT NULL - Flag aprovacao final (0/1)
    this_cContaEs    = ""   && char(10) NOT NULL - Conta de entrega (SigCdCli.IClis)
    this_dDtAprovs   = {}   && datetime NULL - Data da aprovacao final
    this_dDtAprSols  = {}   && datetime NULL - Data da aprovacao da solicitacao
    this_nLocalEnts  = 0    && numeric(10,0) NOT NULL - Local de entrega (SigCdEnd)
    this_cObsAprovs  = ""   && text NULL - Observacao da aprovacao final
    this_cObsAprSols = ""   && text NULL - Observacao da aprovacao da solicitacao
    this_nCopias     = 0    && numeric(6,0) NOT NULL - Codigo da cotacao original (copia)

    *==========================================================================
    * Propriedades de exibicao - nao armazenadas no banco (descricoes de lookup)
    *==========================================================================
    this_cDComprador = ""   && Nome do comprador (SigCdUsu.NComps, exibicao)
    this_cDDeptos    = ""   && Descricao do departamento (SigCdDpt.Descricaos, exibicao)
    this_cDSolicitas = ""   && Nome do solicitante (SigCdUsu.NComps, exibicao)
    this_cDAprovador = ""   && Nome do aprovador (SigCdUsu.NComps, exibicao)
    this_cDAprSols   = ""   && Nome do aprovador da solicitacao (SigCdUsu.NComps, exibicao)
    this_cDContaEs   = ""   && Nome da conta de entrega (SigCdCli.RClis, exibicao)

    *==========================================================================
    * Aliases de cursores das grades da tela (populados via SQLEXEC nas fases
    * seguintes) - HIDDEN para nao aparecer em FormParaBO/BOParaForm
    *==========================================================================
    HIDDEN this_cCursorFornecedores
    HIDDEN this_cCursorProdutos
    HIDDEN this_cCursorMovimentacao
    HIDDEN this_cCursorCotasPendentes
    HIDDEN this_cCursorPedidos
    HIDDEN this_cCursorItensPedido

    this_cCursorFornecedores  = "cursor_4c_Fornecedores"
    this_cCursorProdutos      = "cursor_4c_Produtos"
    this_cCursorMovimentacao  = "cursor_4c_Movimentacao"
    this_cCursorCotasPendentes = "cursor_4c_CotasPendentes"
    this_cCursorPedidos       = "cursor_4c_Pedidos"
    this_cCursorItensPedido   = "cursor_4c_ItensPedido"

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCtTDc"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria (cidchaves) para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do cabecalho da cotacao
    * (SigCtTDc) a partir de um cursor ja aberto.
    *
    * As colunas cD<Campo> (this_cDComprador, this_cDDeptos, this_cDSolicitas,
    * this_cDAprovador, this_cDAprSols, this_cDContaEs) sao descricoes de
    * lookup que so existem quando o SELECT de origem faz JOIN com
    * SigCdUsu/SigCdDpt/SigCdCli - por isso sao carregadas so quando presentes
    * no cursor (regra #34: nunca checar por nome via Controls, aqui via TYPE).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "")
            THIS.this_nCodigos    = TratarNulo(codigos,    0)
            THIS.this_cComprador  = TratarNulo(comprador,  "")
            THIS.this_cDeptos     = TratarNulo(deptos,     "")
            THIS.this_dDtCotas    = TratarNulo(dtcotas,    {})
            THIS.this_dDtPagtos   = TratarNulo(dtpagtos,   {})
            THIS.this_dDtSolics   = TratarNulo(dtsolics,   {})
            THIS.this_dDtValids   = TratarNulo(dtvalids,   {})
            THIS.this_cJustificas = TratarNulo(justificas, "")
            THIS.this_nPrioris    = TratarNulo(prioris,    0)
            THIS.this_nSituas     = TratarNulo(situas,     0)
            THIS.this_cSolicitas  = TratarNulo(solicitas,  "")
            THIS.this_cAprovador  = TratarNulo(aprovador,  "")
            THIS.this_cAprSols    = TratarNulo(aprsols,    "")
            THIS.this_nChkAprovs  = TratarNulo(chkaprovs,  0)
            THIS.this_cContaEs    = TratarNulo(contaes,    "")
            THIS.this_dDtAprovs   = TratarNulo(dtaprovs,   {})
            THIS.this_dDtAprSols  = TratarNulo(dtaprsols,  {})
            THIS.this_nLocalEnts  = TratarNulo(localents,  0)
            THIS.this_cObsAprovs  = TratarNulo(obsaprovs,  "")
            THIS.this_cObsAprSols = TratarNulo(obsaprsols, "")
            THIS.this_nCopias     = TratarNulo(copias,     0)

            * Descricoes de lookup - presentes so quando o SELECT de origem
            * faz JOIN trazendo essas colunas extras.
            IF TYPE(par_cAliasCursor + ".dcomprador") != "U"
                THIS.this_cDComprador = TratarNulo(dcomprador, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".ddeptos") != "U"
                THIS.this_cDDeptos = TratarNulo(ddeptos, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".dsolicitas") != "U"
                THIS.this_cDSolicitas = TratarNulo(dsolicitas, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".daprovador") != "U"
                THIS.this_cDAprovador = TratarNulo(daprovador, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".daprsols") != "U"
                THIS.this_cDAprSols = TratarNulo(daprsols, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".dcontaes") != "U"
                THIS.this_cDContaEs = TratarNulo(dcontaes, "")
            ENDIF

            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Inclui o cabecalho da cotacao (SigCtTDc) - PROTECTED
    *
    * cidchaves (PK Fortyus) sempre gerado por fUniqueIds() - NUNCA string
    * vazia, senao o 2o registro colide no indice unico (regra #22).
    * codigos (chave de negocio) gerado por fGerUniqueKey("SIGMVCOT"), igual
    * ao legado (Insert Into crSigCtTDc ... fGerUniqueKey([SIGMVCOT])).
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)

            IF THIS.this_nCodigos <= 0
                THIS.this_nCodigos = fGerUniqueKey("SIGMVCOT")
            ENDIF

            IF THIS.this_nCodigos <= 0
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel gerar o c" + CHR(243) + "digo da cota" + CHR(231) + CHR(227) + "o."
            ELSE
                loc_cSQL = "INSERT INTO SigCtTDc" + ;
                           " (cidchaves, codigos, comprador, deptos, dtcotas, dtpagtos," + ;
                           "  dtsolics, dtvalids, justificas, prioris, situas, solicitas," + ;
                           "  aprovador, aprsols, chkaprovs, contaes, dtaprovs, dtaprsols," + ;
                           "  localents, obsaprovs, obsaprsols, copias)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCodigos, 0) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cComprador, 12)) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cDeptos, 10)) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtCotas) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtPagtos) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtSolics) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtValids) + ", " + ;
                           EscaparSQL(THIS.this_cJustificas) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nPrioris, 0) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cSolicitas, 10)) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cAprovador, 10)) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cAprSols, 10)) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nChkAprovs, 0) + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cContaEs, 10)) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtAprovs) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtAprSols) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLocalEnts, 0) + ", " + ;
                           EscaparSQL(THIS.this_cObsAprovs) + ", " + ;
                           EscaparSQL(THIS.this_cObsAprSols) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCopias, 0) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao incluir cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigmvcotBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza o cabecalho da cotacao (SigCtTDc) - PROTECTED
    * cidchaves e codigos NUNCA sao alterados apos a inclusao.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCtTDc SET" + ;
                       " comprador   = " + EscaparSQL(LEFT(THIS.this_cComprador, 12)) + "," + ;
                       " deptos      = " + EscaparSQL(LEFT(THIS.this_cDeptos, 10)) + "," + ;
                       " dtcotas     = " + FormatarDataSQL(THIS.this_dDtCotas) + "," + ;
                       " dtpagtos    = " + FormatarDataSQL(THIS.this_dDtPagtos) + "," + ;
                       " dtsolics    = " + FormatarDataSQL(THIS.this_dDtSolics) + "," + ;
                       " dtvalids    = " + FormatarDataSQL(THIS.this_dDtValids) + "," + ;
                       " justificas  = " + EscaparSQL(THIS.this_cJustificas) + "," + ;
                       " prioris     = " + FormatarNumeroSQL(THIS.this_nPrioris, 0) + "," + ;
                       " situas      = " + FormatarNumeroSQL(THIS.this_nSituas, 0) + "," + ;
                       " solicitas   = " + EscaparSQL(LEFT(THIS.this_cSolicitas, 10)) + "," + ;
                       " aprovador   = " + EscaparSQL(LEFT(THIS.this_cAprovador, 10)) + "," + ;
                       " aprsols     = " + EscaparSQL(LEFT(THIS.this_cAprSols, 10)) + "," + ;
                       " chkaprovs   = " + FormatarNumeroSQL(THIS.this_nChkAprovs, 0) + "," + ;
                       " contaes     = " + EscaparSQL(LEFT(THIS.this_cContaEs, 10)) + "," + ;
                       " dtaprovs    = " + FormatarDataSQL(THIS.this_dDtAprovs) + "," + ;
                       " dtaprsols   = " + FormatarDataSQL(THIS.this_dDtAprSols) + "," + ;
                       " localents   = " + FormatarNumeroSQL(THIS.this_nLocalEnts, 0) + "," + ;
                       " obsaprovs   = " + EscaparSQL(THIS.this_cObsAprovs) + "," + ;
                       " obsaprsols  = " + EscaparSQL(THIS.this_cObsAprSols) + "," + ;
                       " copias      = " + FormatarNumeroSQL(THIS.this_nCopias, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigmvcotBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

