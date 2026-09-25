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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvcot.prg) - TRECHOS RELEVANTES PARA PASS SQL (9095 linhas total):

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

*-- Linhas 1039 a 1083:
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
1052:         SET NULL ON
1053:         CREATE CURSOR cursor_4c_Movimentacao ( ;
1054:             Marcas     L(1),  Emps       C(3),  Dopes      C(20), Numes      N(6), ;
1055:             Datas      D(8),  Itens      N(6),  EmpDopNums C(29), Nops       N(6), ;
1056:             ChkSubn    L(1),  LCancelas  L(1),  ChkBxParcs L(1),  ChkPagos   L(1), ;
1057:             ProcBals   L(1),  ProcDBal   L(1),  Destinos   N(1),  EstDests   N(1), ;
1058:             EstOrigs   N(1),  Origems    N(1),  Produc     N(1),  Jobs       C(10))
1059:         SET NULL OFF
1060: 
1061:         INDEX ON DTOS(Datas) + EmpDopNums TAG Ordem
1062: 
1063:         IF USED("cursor_4c_CotasPendentes")
1064:             USE IN cursor_4c_CotasPendentes
1065:         ENDIF
1066: 
1067:         SET NULL ON
1068:         CREATE CURSOR cursor_4c_CotasPendentes ( ;
1069:             Situas     N(1),  Codigos    N(6),  DtSolics   D(8),  Solicitas  C(10), ;
1070:             Deptos     C(10), Prioris    C(10), DtCotas    D(8),  DtAprovs   D(8), ;
1071:             Aprovador  C(10), ContaEs    C(10), LocalEnts  N(10), Justificas M(4), ;
1072:             Copias     N(6))
1073:         SET NULL OFF
1074: 
1075:         INDEX ON Codigos TAG Ordem
1076:     ENDPROC
1077: 
1078:     *--------------------------------------------------------------------------
1079:     * ConfigurarPaginaLista - Monta a Page2 (pgDados do legado), que eh a
1080:     * pagina de LISTA deste form OPERACIONAL: as duas grades (Movimentacoes
1081:     * em aberto e Cotacoes Realizadas) e os CommandGroups de acao sobre elas.
1082:     *
1083:     * Top/Left EXATOS do SCX. O PageFrame deste form tem Top = -1 e abas

*-- Linhas 2002 a 2061:
2002: 
2003:         *-- Obs/Justificas do produto seguem a linha corrente do grdCotacoes -
2004:         *-- o AfterRowColChange do legado so faz .Refresh (o binding jah
2005:         *-- reflete a linha); aqui, como nao ha ControlSource direto (os
2006:         *-- valores sao ESPELHADOS manualmente da linha corrente, regra dos
2007:         *-- campos de rodape de grid), o handler deste form copia os 3 campos.
2008:         BINDEVENT(loc_oPag.txt_4c_DPros,           "LostFocus", THIS, "SalvarRodapeProdutoAtual")
2009:         BINDEVENT(loc_oPag.obj_4c_GetObs,          "LostFocus", THIS, "SalvarRodapeProdutoAtual")
2010:         BINDEVENT(loc_oPag.obj_4c_GetJustificas,   "LostFocus", THIS, "SalvarRodapeProdutoAtual")
2011:     ENDPROC
2012: 
2013:     *--------------------------------------------------------------------------
2014:     * CriarCursoresCotacao - Cursores locais das grades de Page3 (Cotacoes):
2015:     *
2016:     *   cursor_4c_Produtos      -> crSigCtTCt  (grdCotacoes, itens da cotacao)
2017:     *   cursor_4c_Fornecedores  -> crSigCtTFn  (grdFornecs, fornecedores A..F)
2018:     *
2019:     * Estrutura espelha docs/schema.sql (SigCtTCt/SigCtTFn), NUNCA o dump do
2020:     * legado (regra #22). CREATE CURSOR nasce READWRITE - pre-requisito para os
2021:     * REPLACE feitos pelos handlers de Valid/toggle das grades.
2022:     *--------------------------------------------------------------------------
2023:     PROTECTED PROCEDURE CriarCursoresCotacao()
2024:         IF USED("cursor_4c_Produtos")
2025:             USE IN cursor_4c_Produtos
2026:         ENDIF
2027: 
2028:         SET NULL ON
2029:         CREATE CURSOR cursor_4c_Produtos ( ;
2030:             cIdChaves  C(20), Codigos N(6),    CItens     N(6),    CPros   C(14), ;
2031:             DPros      C(65), CUnis   C(3),    CodCors    C(4),    CodTams C(4), ;
2032:             EmpDopNums C(29), Obs     M(4),    Justificas M(4), ;
2033:             Qtds       N(15,2), QtdAdqs  N(15,2), ValAdqs N(15,6), ;
2034:             Marca01 L(1), Marca02 L(1), Marca03 L(1), Marca04 L(1), Marca05 L(1), Marca06 L(1), ;
2035:             Unit01 N(15,6), Unit02 N(15,6), Unit03 N(15,6), Unit04 N(15,6), Unit05 N(15,6), Unit06 N(15,6), ;
2036:             Tota01 N(15,6), Tota02 N(15,6), Tota03 N(15,6), Tota04 N(15,6), Tota05 N(15,6), Tota06 N(15,6))
2037:         SET NULL OFF
2038: 
2039:         INDEX ON CItens TAG Ordem
2040: 
2041:         IF USED("cursor_4c_Fornecedores")
2042:             USE IN cursor_4c_Fornecedores
2043:         ENDIF
2044: 
2045:         SET NULL ON
2046:         CREATE CURSOR cursor_4c_Fornecedores ( ;
2047:             cIdChaves C(20), Codigos N(6), Grades C(1), IClis C(10), Fornecs C(40), ;
2048:             Contatos  C(20), Tel1s   C(20), FPags  C(12), DtEnts D(8), ;
2049:             Fretes    C(12), VlFretes N(11,2))
2050:         SET NULL OFF
2051: 
2052:         INDEX ON Grades TAG Ordem
2053:     ENDPROC
2054: 
2055:     *--------------------------------------------------------------------------
2056:     * ConfigurarComplCots - Item B da Fase 6: PageFrame interno pgf_4c_ComplCots
2057:     * (3 sub-abas: Adicionais/Aprovacao Final/Aprovacao Solicitante), criado em
2058:     * Page3 - Top/Left/Width/Height EXATOS do SCX (pgfComplCots). Tabs = .T.:
2059:     * sao 3 sub-telas alternadas manualmente pelo usuario (Complementos /
2060:     * Aprovacao Final / Aprovacao Solicitante), nao um wizard escondido.
2061:     *

*-- Linhas 2450 a 2485:
2450:             .HeaderHeight  = 16
2451:             .RowHeight     = 15
2452:             .ScrollBars    = 3
2453:             .DeleteMark    = .F.
2454:             .RecordMark    = .F.
2455:             .ReadOnly      = .F.
2456:             .GridLineColor = RGB(128, 128, 128)
2457:             .Visible       = .T.
2458:         ENDWITH
2459: 
2460:         loc_oGrid.ColumnCount = 9
2461:         loc_oGrid.RecordSource          = "cursor_4c_Fornecedores"
2462:         loc_oGrid.Column1.ControlSource = "cursor_4c_Fornecedores.Grades"
2463:         loc_oGrid.Column2.ControlSource = "cursor_4c_Fornecedores.IClis"
2464:         loc_oGrid.Column3.ControlSource = "cursor_4c_Fornecedores.Fornecs"
2465:         loc_oGrid.Column4.ControlSource = "cursor_4c_Fornecedores.Contatos"
2466:         loc_oGrid.Column5.ControlSource = "cursor_4c_Fornecedores.Tel1s"
2467:         loc_oGrid.Column6.ControlSource = "cursor_4c_Fornecedores.FPags"
2468:         loc_oGrid.Column7.ControlSource = "cursor_4c_Fornecedores.DtEnts"
2469:         loc_oGrid.Column8.ControlSource = "cursor_4c_Fornecedores.Fretes"
2470:         loc_oGrid.Column9.ControlSource = "cursor_4c_Fornecedores.VlFretes"
2471: 
2472:         WITH loc_oGrid.Column1
2473:             .FontBold          = .T.
2474:             .Alignment         = 2
2475:             .Movable           = .F.
2476:             .Resizable         = .F.
2477:             .ReadOnly          = .T.
2478:             .Sparse            = .F.
2479:             .DynamicForeColor  = loc_cCor
2480:             .Header1.Caption   = ""
2481:             .Header1.FontSize  = 8
2482:         ENDWITH
2483: 
2484:         WITH loc_oGrid.Column2
2485:             .FontBold          = .T.

*-- Linhas 2631 a 2682:
2631:             .HeaderHeight  = 16
2632:             .RowHeight     = 15
2633:             .ScrollBars    = 3
2634:             .DeleteMark    = .F.
2635:             .RecordMark    = .F.
2636:             .ReadOnly      = .F.
2637:             .GridLineColor = RGB(128, 128, 128)
2638:             .Visible       = .T.
2639:         ENDWITH
2640: 
2641:         loc_oGrid.ColumnCount = 15
2642:         loc_oGrid.RecordSource           = "cursor_4c_Produtos"
2643:         loc_oGrid.Column1.ControlSource  = "cursor_4c_Produtos.CPros"
2644:         loc_oGrid.Column2.ControlSource  = "cursor_4c_Produtos.Qtds"
2645:         loc_oGrid.Column3.ControlSource  = "cursor_4c_Produtos.QtdAdqs"
2646:         loc_oGrid.Column4.ControlSource  = "cursor_4c_Produtos.CUnis"
2647:         loc_oGrid.Column5.ControlSource  = "cursor_4c_Produtos.ValAdqs"
2648:         loc_oGrid.Column6.ControlSource  = "cursor_4c_Produtos.Marca01"
2649:         loc_oGrid.Column7.ControlSource  = "cursor_4c_Produtos.Unit01"
2650:         loc_oGrid.Column8.ControlSource  = "cursor_4c_Produtos.Tota01"
2651:         loc_oGrid.Column9.ControlSource  = "cursor_4c_Produtos.Marca02"
2652:         loc_oGrid.Column10.ControlSource = "cursor_4c_Produtos.Unit02"
2653:         loc_oGrid.Column11.ControlSource = "cursor_4c_Produtos.Tota02"
2654:         loc_oGrid.Column12.ControlSource = "cursor_4c_Produtos.Marca03"
2655:         loc_oGrid.Column13.ControlSource = "cursor_4c_Produtos.Unit03"
2656:         loc_oGrid.Column14.ControlSource = "cursor_4c_Produtos.Tota03"
2657:         loc_oGrid.Column15.ControlSource = "cursor_4c_Produtos.Marca04"
2658:         loc_oGrid.Column16.ControlSource = "cursor_4c_Produtos.Unit04"
2659:         loc_oGrid.Column17.ControlSource = "cursor_4c_Produtos.Tota04"
2660:         loc_oGrid.Column18.ControlSource = "cursor_4c_Produtos.Marca05"
2661:         loc_oGrid.Column19.ControlSource = "cursor_4c_Produtos.Unit05"
2662:         loc_oGrid.Column20.ControlSource = "cursor_4c_Produtos.Tota05"
2663:         loc_oGrid.Column21.ControlSource = "cursor_4c_Produtos.Marca06"
2664:         loc_oGrid.Column22.ControlSource = "cursor_4c_Produtos.Unit06"
2665:         loc_oGrid.Column23.ControlSource = "cursor_4c_Produtos.Tota06"
2666:         loc_oGrid.Column24.ControlSource = "cursor_4c_Produtos.CodTams"
2667:         loc_oGrid.Column25.ControlSource = "cursor_4c_Produtos.CodCors"
2668: 
2669:         *-- Column1 (Produto) - link azul sublinhado, igual ao legado
2670:         WITH loc_oGrid.Column1
2671:             .FontBold          = .T.
2672:             .FontUnderline     = .T.
2673:             .ReadOnly          = .F.
2674:             .Sparse            = .F.
2675:             .Format            = "K"
2676:             .Text1.MaxLength         = 14
2677:             .Header1.Caption   = "Produto"
2678:             .Header1.Alignment = 2
2679:             .Header1.FontBold  = .T.
2680:             .Header1.FontSize  = 8
2681:             .Text1.FontBold    = .T.
2682:             .Text1.FontUnderline = .T.

*-- Linhas 3316 a 3368:
3316:     *--------------------------------------------------------------------------
3317:     * SalvarRodapeProdutoAtual - Copia getDPros/getObs/getJustificas (rodape
3318:     * de Page3) para a linha CORRENTE de cursor_4c_Produtos. Sao campos que o
3319:     * legado liga por ControlSource direto a crSigCtTCt; aqui, como o valor
3320:     * fica em controles de nivel de Page (fora da grade), a copia manual eh
3321:     * feita ao perder o foco - equivalente ao LostFocus nativo do binding.
3322:     *--------------------------------------------------------------------------
3323:     PROCEDURE SalvarRodapeProdutoAtual()
3324:         LOCAL loc_oPag
3325: 
3326:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
3327:             RETURN
3328:         ENDIF
3329: 
3330:         loc_oPag = THIS.pgf_4c_Paginas.Page3
3331: 
3332:         SELECT cursor_4c_Produtos
3333:         REPLACE DPros      WITH ALLTRIM(loc_oPag.txt_4c_DPros.Value), ;
3334:                 Obs        WITH loc_oPag.obj_4c_GetObs.Value, ;
3335:                 Justificas WITH loc_oPag.obj_4c_GetJustificas.Value ;
3336:             IN cursor_4c_Produtos
3337:     ENDPROC
3338: 
3339:     *--------------------------------------------------------------------------
3340:     * GridCotacoesAfterRowColChange - Espelha a linha corrente do grd_4c_Produtos
3341:     * nos campos de rodape (equivalente ao Refresh dos 3 controles no legado,
3342:     * que estao ligados por ControlSource direto).
3343:     *--------------------------------------------------------------------------
3344:     PROCEDURE GridCotacoesAfterRowColChange(par_nColIndex)
3345:         LOCAL loc_oPag
3346: 
3347:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
3348:             RETURN
3349:         ENDIF
3350: 
3351:         loc_oPag = THIS.pgf_4c_Paginas.Page3
3352: 
3353:         SELECT cursor_4c_Produtos
3354:         loc_oPag.txt_4c_DPros.Value         = ALLTRIM(NVL(DPros, ""))
3355:         loc_oPag.obj_4c_GetObs.Value        = NVL(Obs, "")
3356:         loc_oPag.obj_4c_GetJustificas.Value = NVL(Justificas, "")
3357:     ENDPROC
3358: 
3359:     *--------------------------------------------------------------------------
3360:     * GridCotacoesKeyPressComum / GridFornecsKeyPressComum - Navegacao comum
3361:     * Tab/Shift+Tab das colunas de texto das duas grades de Page3, transcrita
3362:     * do KeyPress identico presente em TODAS as colunas do dump legado.
3363:     *--------------------------------------------------------------------------
3364:     PROCEDURE GridCotacoesKeyPressComum(par_nKeyCode, par_nShiftAltCtrl)
3365:         DO CASE
3366:             CASE par_nKeyCode = 9   && TAB
3367:                 THIS.pgf_4c_Paginas.Page3.txt_4c_DPros.SetFocus()
3368:             CASE par_nKeyCode = 15  && SHIFT+TAB

*-- Linhas 3572 a 3628:
3572:         loc_cCampo  = "Marca" + par_cNum
3573:         loc_lMarcado = EVALUATE("cursor_4c_Produtos." + loc_cCampo)
3574: 
3575:         SELECT cursor_4c_Produtos
3576:         IF loc_lMarcado
3577:             REPLACE (loc_cCampo) WITH .F., ValAdqs WITH 0 IN cursor_4c_Produtos
3578:         ELSE
3579:             REPLACE Marca01 WITH .F., Marca02 WITH .F., Marca03 WITH .F., ;
3580:                     Marca04 WITH .F., Marca05 WITH .F., Marca06 WITH .F. IN cursor_4c_Produtos
3581:             REPLACE (loc_cCampo) WITH .T., ;
3582:                     ValAdqs WITH EVALUATE("cursor_4c_Produtos.Tota" + par_cNum) IN cursor_4c_Produtos
3583:         ENDIF
3584: 
3585:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
3586:     ENDPROC
3587: 
3588:     *--------------------------------------------------------------------------
3589:     * SelecionarTodosFornecedor - Header1.DblClick do legado: marca <par_cNum>
3590:     * em TODAS as linhas com Total preenchido e ValAdqs = Total, desmarcando os
3591:     * outros 5 fornecedores em todas as linhas (Update sem Where -> todas).
3592:     *--------------------------------------------------------------------------
3593:     PROCEDURE SelecionarTodosFornecedor(par_cNum)
3594:         LOCAL loc_cCampo, loc_cCampoTota, loc_nRegAtual, loc_nI, loc_cOutro
3595: 
3596:         IF !USED("cursor_4c_Produtos") ;
3597:            OR !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
3598:             RETURN
3599:         ENDIF
3600: 
3601:         loc_cCampo     = "Marca" + par_cNum
3602:         loc_cCampoTota = "Tota"  + par_cNum
3603:         loc_nRegAtual  = RECNO("cursor_4c_Produtos")
3604: 
3605:         *-- Transcrito literal do Header1.DblClick legado (3 passos
3606:         *-- distintos - inclusive a assimetria: so as OUTRAS 5 letras sao
3607:         *-- limpas incondicionalmente, a marcada so muda onde o Total dela
3608:         *-- esta preenchido). REPLACE...FOR (nao UPDATE-SQL) porque so REPLACE
3609:         *-- aceita nome de campo DINAMICO via parenteses em VFP9:
3610:         *-- Update Set Marca<N>=.t. Where Not Empty(Tota<N>)
3611:         *-- Update Set ValAdqs=Tota<N> Where Marca<N>
3612:         *-- Update Set Marca<outras 5>=.f. (todas as linhas)
3613:         SELECT cursor_4c_Produtos
3614:         REPLACE (loc_cCampo) WITH .T. FOR !EMPTY(EVALUATE(loc_cCampoTota)) IN cursor_4c_Produtos
3615:         REPLACE ValAdqs WITH EVALUATE(loc_cCampoTota) FOR EVALUATE(loc_cCampo) IN cursor_4c_Produtos
3616: 
3617:         FOR loc_nI = 1 TO 6
3618:             loc_cOutro = "Marca" + PADL(loc_nI, 2, "0")
3619:             IF loc_cOutro != loc_cCampo
3620:                 REPLACE (loc_cOutro) WITH .F. ALL IN cursor_4c_Produtos
3621:             ENDIF
3622:         ENDFOR
3623: 
3624:         GO TOP IN cursor_4c_Produtos
3625:         IF BETWEEN(loc_nRegAtual, 1, RECCOUNT("cursor_4c_Produtos"))
3626:             GO loc_nRegAtual IN cursor_4c_Produtos
3627:         ENDIF
3628: 

*-- Linhas 3642 a 3660:
3642:             RETURN
3643:         ENDIF
3644: 
3645:         SELECT cursor_4c_Produtos
3646:         loc_nUnit = EVALUATE("Unit" + par_cNum)
3647: 
3648:         IF loc_nUnit < 0
3649:             REPLACE ("Unit" + par_cNum) WITH 0 IN cursor_4c_Produtos
3650:             loc_nUnit = 0
3651:         ENDIF
3652: 
3653:         loc_nQtd      = QtdAdqs
3654:         loc_nTotalNovo = loc_nUnit * loc_nQtd
3655: 
3656:         IF EVALUATE("Tota" + par_cNum) != loc_nTotalNovo
3657:             REPLACE ("Tota" + par_cNum) WITH loc_nTotalNovo IN cursor_4c_Produtos
3658:         ENDIF
3659: 
3660:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()

*-- Linhas 3667 a 3685:
3667:             RETURN
3668:         ENDIF
3669: 
3670:         SELECT cursor_4c_Produtos
3671:         loc_nTotal = EVALUATE("Tota" + par_cNum)
3672: 
3673:         IF loc_nTotal < 0
3674:             REPLACE ("Tota" + par_cNum) WITH 0 IN cursor_4c_Produtos
3675:             loc_nTotal = 0
3676:         ENDIF
3677: 
3678:         loc_nQtd     = IIF(QtdAdqs = 0, 1, QtdAdqs)
3679:         loc_nUnitNovo = loc_nTotal / loc_nQtd
3680: 
3681:         IF EVALUATE("Unit" + par_cNum) != loc_nUnitNovo
3682:             REPLACE ("Unit" + par_cNum) WITH loc_nUnitNovo IN cursor_4c_Produtos
3683:         ENDIF
3684: 
3685:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()

*-- Linhas 3697 a 3715:
3697:             RETURN
3698:         ENDIF
3699: 
3700:         SELECT cursor_4c_Produtos
3701:         loc_nQtd = QtdAdqs
3702: 
3703:         IF loc_nQtd < 0
3704:             REPLACE QtdAdqs WITH 0 IN cursor_4c_Produtos
3705:             loc_nQtd = 0
3706:         ENDIF
3707: 
3708:         FOR loc_nI = 1 TO 6
3709:             loc_cNum = PADL(loc_nI, 2, "0")
3710:             IF EVALUATE("Unit" + loc_cNum) > 0
3711:                 REPLACE ("Tota" + loc_cNum) WITH EVALUATE("Unit" + loc_cNum) * loc_nQtd IN cursor_4c_Produtos
3712:             ENDIF
3713:         ENDFOR
3714: 
3715:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()

*-- Linhas 3740 a 3758:
3740: 
3741:         loc_nRegAtual = RECNO("cursor_4c_Produtos")
3742: 
3743:         SELECT cursor_4c_Produtos
3744:         SCAN
3745:             FOR loc_nI = 1 TO 6
3746:                 loc_cNum = PADL(loc_nI, 2, "0")
3747:                 IF !EMPTY(EVALUATE("Tota" + loc_cNum)) AND ;
3748:                    (EMPTY(ValAdqs) OR ValAdqs > EVALUATE("Tota" + loc_cNum))
3749:                     REPLACE Marca01 WITH .F., Marca02 WITH .F., Marca03 WITH .F., ;
3750:                             Marca04 WITH .F., Marca05 WITH .F., Marca06 WITH .F. IN cursor_4c_Produtos
3751:                     REPLACE ValAdqs WITH EVALUATE("Tota" + loc_cNum), ;
3752:                             ("Marca" + loc_cNum) WITH .T. IN cursor_4c_Produtos
3753:                 ENDIF
3754:             ENDFOR
3755:         ENDSCAN
3756: 
3757:         IF BETWEEN(loc_nRegAtual, 1, RECCOUNT("cursor_4c_Produtos"))
3758:             GO loc_nRegAtual IN cursor_4c_Produtos

*-- Linhas 3776 a 3794:
3776:     PROCEDURE GridCotacoesProdutoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3777:         IF USED("cursor_4c_Produtos") AND !EOF("cursor_4c_Produtos")
3778:             IF !EMPTY(cursor_4c_Produtos.EmpDopNums)
3779:                 SELECT cursor_4c_Produtos
3780:                 REPLACE CPros WITH THIS.this_cTagProduto IN cursor_4c_Produtos
3781:                 THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
3782:             ENDIF
3783:         ENDIF
3784:     ENDPROC
3785: 
3786:     PROCEDURE GridCotacoesProdutoDblClick()
3787:         *-- Legado: Do Form SigOpCgp.Scx (tela de consulta de movimentacoes por
3788:         *-- produto) - form de CONSULTA externo, nao portado nesta fase.
3789:         MsgAviso("Consulta de movimenta" + CHR(231) + CHR(245) + "es por produto (SigOpCgp) " + ;
3790:             "n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", ;
3791:             "Aviso")
3792:     ENDPROC
3793: 
3794:     *--------------------------------------------------------------------------

*-- Linhas 3834 a 3852:
3834:             ENDIF
3835: 
3836:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
3837:                 SELECT cursor_4c_Produtos
3838:                 REPLACE CPros     WITH ALLTRIM(cursor_4c_BuscaProduto.CPros), ;
3839:                         DPros     WITH ALLTRIM(cursor_4c_BuscaProduto.DPros), ;
3840:                         CUnis     WITH ALLTRIM(cursor_4c_BuscaProduto.CUnis), ;
3841:                         cIdChaves WITH LEFT(fUniqueIds(), 20) IN cursor_4c_Produtos
3842:                 loc_oGrid.Refresh()
3843:                 THIS.GridCotacoesAfterRowColChange(1)
3844:             ENDIF
3845: 
3846:             loc_oBusca.Release()
3847:         ENDIF
3848: 
3849:         IF USED("cursor_4c_BuscaProduto")
3850:             USE IN cursor_4c_BuscaProduto
3851:         ENDIF
3852: 

*-- Linhas 3887 a 3925:
3887:                 ENDIF
3888: 
3889:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUnidade")
3890:                     SELECT cursor_4c_Produtos
3891:                     REPLACE CUnis WITH ALLTRIM(cursor_4c_BuscaUnidade.CUnis) IN cursor_4c_Produtos
3892:                 ELSE
3893:                     SELECT cursor_4c_Produtos
3894:                     REPLACE CUnis WITH "" IN cursor_4c_Produtos
3895:                 ENDIF
3896: 
3897:                 loc_oBusca.Release()
3898:             ENDIF
3899: 
3900:             IF USED("cursor_4c_BuscaUnidade")
3901:                 USE IN cursor_4c_BuscaUnidade
3902:             ENDIF
3903: 
3904:             loc_oGrid.Refresh()
3905: 
3906:             *-- Confere contra a unidade cadastrada no produto (aviso, nao bloqueio)
3907:             IF !EMPTY(cursor_4c_Produtos.CPros)
3908:                 loc_cSQL = "SELECT CUnis FROM SigCdPro WHERE CPros = " + ;
3909:                     EscaparSQL(cursor_4c_Produtos.CPros)
3910:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniPro")
3911: 
3912:                 IF loc_nResultado > 0 AND USED("cursor_4c_UniPro") AND !EOF("cursor_4c_UniPro")
3913:                     IF !EMPTY(cursor_4c_UniPro.CUnis) AND ;
3914:                        ALLTRIM(cursor_4c_UniPro.CUnis) != ALLTRIM(cursor_4c_Produtos.CUnis)
3915:                         MsgAviso("A Unidade de Medida Deste Produto no Cadastro " + CHR(233) + ' "' + ;
3916:                             ALLTRIM(cursor_4c_UniPro.CUnis) + '"!!!', "Aten" + CHR(231) + CHR(227) + "o!!!")
3917:                     ENDIF
3918:                 ENDIF
3919: 
3920:                 IF USED("cursor_4c_UniPro")
3921:                     USE IN cursor_4c_UniPro
3922:                 ENDIF
3923:             ENDIF
3924: 
3925:             THIS.this_lAbrindoLookupGrid = .F.

*-- Linhas 3956 a 3974:
3956:         ENDIF
3957: 
3958:         IF EMPTY(loc_cValor)
3959:             SELECT cursor_4c_Fornecedores
3960:             REPLACE IClis WITH "", Fornecs WITH "", Contatos WITH "", Tel1s WITH "", Fretes WITH "" ;
3961:                 IN cursor_4c_Fornecedores
3962:             loc_oGrid.Refresh()
3963:             RETURN
3964:         ENDIF
3965: 
3966:         *-- Guarda de reentrancia (ver ValidarProdutoGrid).
3967:         IF THIS.this_lAbrindoLookupGrid
3968:             RETURN
3969:         ENDIF
3970:         THIS.this_lAbrindoLookupGrid = .T.
3971: 
3972:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"
3973:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3974:             "SigCdCli", "cursor_4c_BuscaFornec", par_cCampo, loc_cValor, loc_cTitulo, .F., .T., "")

*-- Linhas 3983 a 4008:
3983:             ENDIF
3984: 
3985:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFornec")
3986:                 SELECT cursor_4c_Fornecedores
3987:                 REPLACE IClis    WITH ALLTRIM(cursor_4c_BuscaFornec.IClis), ;
3988:                         Fornecs  WITH ALLTRIM(cursor_4c_BuscaFornec.RClis), ;
3989:                         Contatos WITH ALLTRIM(NVL(cursor_4c_BuscaFornec.Contato, "")), ;
3990:                         Tel1s    WITH ALLTRIM(NVL(cursor_4c_BuscaFornec.Tel1s, "")), ;
3991:                         Fretes   WITH "Emitente" IN cursor_4c_Fornecedores
3992:             ELSE
3993:                 SELECT cursor_4c_Fornecedores
3994:                 REPLACE IClis WITH "", Fornecs WITH "", Contatos WITH "", Tel1s WITH "", Fretes WITH "" ;
3995:                     IN cursor_4c_Fornecedores
3996:             ENDIF
3997: 
3998:             loc_oBusca.Release()
3999:         ENDIF
4000: 
4001:         IF USED("cursor_4c_BuscaFornec")
4002:             USE IN cursor_4c_BuscaFornec
4003:         ENDIF
4004: 
4005:         loc_oGrid.Refresh()
4006:         THIS.this_lAbrindoLookupGrid = .F.
4007:     ENDPROC
4008: 

*-- Linhas 4040 a 4061:
4040:             ENDIF
4041: 
4042:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFPag")
4043:                 SELECT cursor_4c_Fornecedores
4044:                 REPLACE FPags WITH ALLTRIM(cursor_4c_BuscaFPag.FPags) IN cursor_4c_Fornecedores
4045:             ELSE
4046:                 SELECT cursor_4c_Fornecedores
4047:                 REPLACE FPags WITH "" IN cursor_4c_Fornecedores
4048:             ENDIF
4049: 
4050:             loc_oBusca.Release()
4051:         ENDIF
4052: 
4053:         IF USED("cursor_4c_BuscaFPag")
4054:             USE IN cursor_4c_BuscaFPag
4055:         ENDIF
4056: 
4057:         THIS.pgf_4c_Paginas.Page3.grd_4c_Fornecedores.Refresh()
4058:         THIS.this_lAbrindoLookupGrid = .F.
4059:     ENDPROC
4060: 
4061:     *--------------------------------------------------------------------------

*-- Linhas 4083 a 4101:
4083: 
4084:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4085:             "SigCdUsu", "cursor_4c_BuscaSolic", "Usuarios", loc_cValor, ;
4086:             "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "CAtivos = " + EscaparSQL("S"))
4087: 
4088:         IF VARTYPE(loc_oBusca) = "O"
4089:             IF loc_oBusca.this_lAchouRegistro
4090:                 loc_oPag.txt_4c_Solicitas.Value = ALLTRIM(cursor_4c_BuscaSolic.Usuarios)
4091:             ELSE
4092:                 loc_oBusca.mAddColuna("Usuarios", "", "Solicitante")
4093:                 loc_oBusca.mAddColuna("NComps",   "", "Nome")
4094:                 loc_oBusca.mAddColuna("Deptos",   "", "Departamento")
4095:                 loc_oBusca.Show()
4096:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSolic")
4097:                     loc_oPag.txt_4c_Solicitas.Value = ALLTRIM(cursor_4c_BuscaSolic.Usuarios)
4098:                 ENDIF
4099:             ENDIF
4100:             loc_oBusca.Release()
4101:         ENDIF

*-- Linhas 4186 a 4204:
4186: 
4187:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4188:             "SigCdUsu", "cursor_4c_BuscaCompr", "Usuarios", loc_cValor, ;
4189:             "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "CAtivos = " + EscaparSQL("S"))
4190: 
4191:         IF VARTYPE(loc_oBusca) = "O"
4192:             IF loc_oBusca.this_lAchouRegistro
4193:                 loc_oPag.txt_4c_Comprador.Value = ALLTRIM(cursor_4c_BuscaCompr.Usuarios)
4194:             ELSE
4195:                 loc_oBusca.mAddColuna("Usuarios", "", "Solicitante")
4196:                 loc_oBusca.mAddColuna("NComps",   "", "Nome")
4197:                 loc_oBusca.Show()
4198:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCompr")
4199:                     loc_oPag.txt_4c_Comprador.Value = ALLTRIM(cursor_4c_BuscaCompr.Usuarios)
4200:                 ENDIF
4201:             ENDIF
4202:             loc_oBusca.Release()
4203:         ENDIF
4204: 

*-- Linhas 4262 a 4281:
4262:             RETURN
4263:         ENDIF
4264: 
4265:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE " + par_cCampo + " = " + EscaparSQL(loc_cValor)
4266:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaEsVal")
4267: 
4268:         IF loc_nResultado > 0 AND USED("cursor_4c_ContaEsVal") AND !EOF("cursor_4c_ContaEsVal")
4269:             loc_oAdic.txt_4c_ContaEs.Value  = ALLTRIM(cursor_4c_ContaEsVal.IClis)
4270:             loc_oAdic.txt_4c_DContaEs.Value = ALLTRIM(cursor_4c_ContaEsVal.RClis)
4271:         ELSE
4272:             loc_oAdic.txt_4c_ContaEs.Value  = ""
4273:             loc_oAdic.txt_4c_DContaEs.Value = ""
4274:             THIS.AbrirBuscaContaEsGeral(par_cCampo)
4275:         ENDIF
4276: 
4277:         IF USED("cursor_4c_ContaEsVal")
4278:             USE IN cursor_4c_ContaEsVal
4279:         ENDIF
4280: 
4281:         IF VARTYPE(THIS.this_oBusinessObject) = "O"

*-- Linhas 4346 a 4365:
4346:             RETURN
4347:         ENDIF
4348: 
4349:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cContaEs)
4350:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EntregaCli")
4351: 
4352:         IF loc_nResultado < 0 OR !USED("cursor_4c_EntregaCli") OR EOF("cursor_4c_EntregaCli")
4353:             MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
4354:                 "Falha na Conex" + CHR(227) + "o (cmdEntrega)")
4355:         ELSE
4356:             MsgAviso("A tela de Local de Entrega (SigCdEnd) n" + CHR(227) + "o foi portada para o " + ;
4357:                 "sistema novo." + CHR(13) + "Cadastre/ajuste os endere" + CHR(231) + "os de entrega do " + ;
4358:                 "cliente " + ALLTRIM(cursor_4c_EntregaCli.RClis) + " pelo cadastro de Clientes.", "Aviso")
4359:         ENDIF
4360: 
4361:         IF USED("cursor_4c_EntregaCli")
4362:             USE IN cursor_4c_EntregaCli
4363:         ENDIF
4364:     ENDPROC
4365: 

*-- Linhas 4392 a 4410:
4392: 
4393:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4394:             "SigCdUsu", "cursor_4c_BuscaAprov", "Usuarios", loc_cValor, ;
4395:             "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "CAtivos = " + EscaparSQL("S"))
4396: 
4397:         IF VARTYPE(loc_oBusca) = "O"
4398:             IF loc_oBusca.this_lAchouRegistro
4399:                 loc_oApr.txt_4c_Aprovador.Value = ALLTRIM(cursor_4c_BuscaAprov.Usuarios)
4400:             ELSE
4401:                 loc_oBusca.mAddColuna("Usuarios", "", "Aprovador")
4402:                 loc_oBusca.mAddColuna("NComps",   "", "Nome")
4403:                 loc_oBusca.Show()
4404:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAprov")
4405:                     loc_oApr.txt_4c_Aprovador.Value = ALLTRIM(cursor_4c_BuscaAprov.Usuarios)
4406:                 ENDIF
4407:             ENDIF
4408:             loc_oBusca.Release()
4409:         ENDIF
4410: 

*-- Linhas 4538 a 4582:
4538: 
4539:             *-- So desmarca o SigMvCab se NENHUMA outra linha (desta ou de
4540:             *-- OUTRAS cotacoes ja gravadas) ainda usar a mesma operacao
4541:             SELECT COUNT(*) AS Total FROM cursor_4c_Produtos ;
4542:                 WHERE EmpDopNums = loc_cEdn AND cIdChaves != loc_cIdAtual ;
4543:                 INTO CURSOR cursor_4c_ChecagemLocal
4544: 
4545:             IF cursor_4c_ChecagemLocal.Total = 0
4546:                 loc_cSQL = "SELECT EmpDopNums FROM SigCtTCt WHERE EmpDopNums = " + ;
4547:                     EscaparSQL(loc_cEdn) + " AND Codigos != " + FormatarNumeroSQL(loc_nCod, 0)
4548: 
4549:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChecagemSQL")
4550: 
4551:                 IF loc_nResultado >= 0 AND USED("cursor_4c_ChecagemSQL") AND EOF("cursor_4c_ChecagemSQL")
4552:                     SQLEXEC(gnConnHandle, "UPDATE SigMvCab SET Utilizados = 0 WHERE EmpDopNums = " + ;
4553:                         EscaparSQL(loc_cEdn))
4554:                 ENDIF
4555: 
4556:                 IF USED("cursor_4c_ChecagemSQL")
4557:                     USE IN cursor_4c_ChecagemSQL
4558:                 ENDIF
4559:             ENDIF
4560: 
4561:             IF USED("cursor_4c_ChecagemLocal")
4562:                 USE IN cursor_4c_ChecagemLocal
4563:             ENDIF
4564:         ENDIF
4565: 
4566:         SELECT cursor_4c_Produtos
4567:         DELETE IN cursor_4c_Produtos
4568: 
4569:         loc_nItn = 1
4570:         SCAN
4571:             REPLACE CItens WITH loc_nItn IN cursor_4c_Produtos
4572:             loc_nItn = loc_nItn + 1
4573:         ENDSCAN
4574: 
4575:         GO TOP IN cursor_4c_Produtos
4576:         IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Produtos")
4577:             GO loc_nRec IN cursor_4c_Produtos
4578:         ENDIF
4579: 
4580:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
4581:         THIS.GridCotacoesAfterRowColChange(1)
4582: 

*-- Linhas 4601 a 4629:
4601:         ENDIF
4602: 
4603:         loc_nItn = 1
4604:         SELECT cursor_4c_Produtos
4605:         SCAN
4606:             REPLACE CItens WITH loc_nItn IN cursor_4c_Produtos
4607:             IF EMPTY(cursor_4c_Produtos.CPros)
4608:                 DELETE IN cursor_4c_Produtos
4609:             ELSE
4610:                 loc_nItn = loc_nItn + 1
4611:             ENDIF
4612:         ENDSCAN
4613: 
4614:         INSERT INTO cursor_4c_Produtos (cIdChaves, Codigos, CItens, CPros, DPros, Obs, Qtds, CUnis, QtdAdqs) ;
4615:             VALUES (LEFT(fUniqueIds(), 20), loc_nCod, loc_nItn, "", "", "", 0, "", 0)
4616: 
4617:         GO BOTTOM IN cursor_4c_Produtos
4618:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
4619:         THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Column1.SetFocus()
4620:         THIS.GridCotacoesAfterRowColChange(1)
4621:     ENDPROC
4622: 
4623:     *--------------------------------------------------------------------------
4624:     * BtnSairCotacoesClick - cmdBotoes.btnSair.Click de Page3: confirma
4625:     * abandono em modo de edicao, desfaz a edicao em curso do BO e volta para
4626:     * a pagina de Dados (Page2).
4627:     *--------------------------------------------------------------------------
4628:     PROCEDURE BtnSairCotacoesClick()
4629:         LOCAL loc_lConfirma

*-- Linhas 4669 a 4705:
4669:     *--------------------------------------------------------------------------
4670:     * GravaDados - Equivalente ao PROCEDURE gravadados legado: apaga o que
4671:     * existia para este Codigos e regrava o cabecalho (SigCtTDc, via BO) e os
4672:     * itens/fornecedores (SigCtTCt/SigCtTFn, INSERT direto - esta arquitetura
4673:     * nao usa cursores bufferizados/TABLEUPDATE como o legado, entao o padrao
4674:     * "apagar tudo e regravar" e feito com DELETE + INSERT explicitos).
4675:     *
4676:     * Modo EXCLUIR: so apaga (cabecalho + filhos) e libera o SigMvCab.
4677:     *--------------------------------------------------------------------------
4678:     PROCEDURE GravaDados()
4679:         LOCAL loc_lOk, loc_nCod, loc_cSQL, loc_nI, loc_cNum, loc_nRec
4680: 
4681:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
4682:             RETURN .F.
4683:         ENDIF
4684: 
4685:         loc_lOk = .T.
4686: 
4687:         *-- ValAdqs = Total do fornecedor marcado (ou 0 se nenhum) - transcrito
4688:         IF USED("cursor_4c_Produtos")
4689:             loc_nRec = RECNO("cursor_4c_Produtos")
4690:             SELECT cursor_4c_Produtos
4691:             SCAN
4692:                 loc_cNum = ""
4693:                 FOR loc_nI = 1 TO 6
4694:                     IF EVALUATE("Marca" + PADL(loc_nI, 2, "0"))
4695:                         loc_cNum = PADL(loc_nI, 2, "0")
4696:                     ENDIF
4697:                 ENDFOR
4698:                 IF EMPTY(loc_cNum)
4699:                     REPLACE ValAdqs WITH 0 IN cursor_4c_Produtos
4700:                 ELSE
4701:                     REPLACE ValAdqs WITH EVALUATE("Tota" + loc_cNum) IN cursor_4c_Produtos
4702:                 ENDIF
4703:             ENDSCAN
4704:             IF BETWEEN(loc_nRec, 1, RECCOUNT("cursor_4c_Produtos"))
4705:                 GO loc_nRec IN cursor_4c_Produtos

*-- Linhas 4711 a 4855:
4711: 
4712:             *-- Libera as operacoes (SigMvCab) que so eram usadas por esta cotacao
4713:             IF USED("cursor_4c_Produtos")
4714:                 SELECT DISTINCT EmpDopNums FROM cursor_4c_Produtos ;
4715:                     WHERE !EMPTY(EmpDopNums) INTO CURSOR cursor_4c_ApagarEdn
4716: 
4717:                 SELECT cursor_4c_ApagarEdn
4718:                 SCAN
4719:                     loc_cSQL = "SELECT EmpDopNums FROM SigCtTCt WHERE EmpDopNums = " + ;
4720:                         EscaparSQL(cursor_4c_ApagarEdn.EmpDopNums) + " AND Codigos != " + ;
4721:                         FormatarNumeroSQL(loc_nCod, 0)
4722: 
4723:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ApagarChk") >= 0
4724:                         IF USED("cursor_4c_ApagarChk") AND EOF("cursor_4c_ApagarChk")
4725:                             SQLEXEC(gnConnHandle, "UPDATE SigMvCab SET Utilizados = 0 WHERE EmpDopNums = " + ;
4726:                                 EscaparSQL(cursor_4c_ApagarEdn.EmpDopNums))
4727:                         ENDIF
4728:                     ENDIF
4729:                     IF USED("cursor_4c_ApagarChk")
4730:                         USE IN cursor_4c_ApagarChk
4731:                     ENDIF
4732:                 ENDSCAN
4733: 
4734:                 IF USED("cursor_4c_ApagarEdn")
4735:                     USE IN cursor_4c_ApagarEdn
4736:                 ENDIF
4737:             ENDIF
4738: 
4739:             IF SQLEXEC(gnConnHandle, "DELETE FROM SigCtTFn WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)) < 0
4740:                 MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - Apagando SigCtTFn)" + CHR(13) + ;
4741:                     CapturarErroSQL(), "Erro SQL")
4742:                 loc_lOk = .F.
4743:             ENDIF
4744:             IF loc_lOk AND SQLEXEC(gnConnHandle, "DELETE FROM SigCtTCt WHERE Codigos = " + ;
4745:                 FormatarNumeroSQL(loc_nCod, 0)) < 0
4746:                 MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - Apagando SigCtTCt)" + CHR(13) + ;
4747:                     CapturarErroSQL(), "Erro SQL")
4748:                 loc_lOk = .F.
4749:             ENDIF
4750:             IF loc_lOk AND !THIS.this_oBusinessObject.Excluir()
4751:                 loc_lOk = .F.
4752:             ENDIF
4753: 
4754:             RETURN loc_lOk
4755:         ENDIF
4756: 
4757:         *-- INSERIR/ALTERAR: recolhe primeiro o que esta nos controles do
4758:         *-- cabecalho (no legado o ControlSource ja mantinha crSigCtTDc em dia;
4759:         *-- aqui, campo digitado e gravado sem sair do foco nunca chegou ao BO)
4760:         THIS.FormParaBO()
4761: 
4762:         *-- e so entao grava o cabecalho via BO (Inserir gera cidchaves +
4763:         *-- codigos automaticamente no primeiro Salvar)
4764:         IF !THIS.this_oBusinessObject.Salvar()
4765:             RETURN .F.
4766:         ENDIF
4767: 
4768:         loc_nCod = THIS.this_oBusinessObject.this_nCodigos
4769: 
4770:         *-- Regrava filhos: apaga o que ja existia e reinsere o cursor inteiro
4771:         IF SQLEXEC(gnConnHandle, "DELETE FROM SigCtTFn WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)) < 0
4772:             MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - SigCtTFn)" + CHR(13) + CapturarErroSQL(), "Erro SQL")
4773:             RETURN .F.
4774:         ENDIF
4775:         IF SQLEXEC(gnConnHandle, "DELETE FROM SigCtTCt WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)) < 0
4776:             MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - SigCtTCt)" + CHR(13) + CapturarErroSQL(), "Erro SQL")
4777:             RETURN .F.
4778:         ENDIF
4779: 
4780:         IF USED("cursor_4c_Fornecedores")
4781:             SELECT cursor_4c_Fornecedores
4782:             SCAN
4783:                 loc_cSQL = "INSERT INTO SigCtTFn (cidchaves, codigos, grades, iclis, fornecs, contatos, " + ;
4784:                     "tel1s, fpags, dtents, fretes, vlfretes) VALUES (" + ;
4785:                     EscaparSQL(IIF(EMPTY(cIdChaves), LEFT(fUniqueIds(), 20), cIdChaves)) + ", " + ;
4786:                     FormatarNumeroSQL(loc_nCod, 0) + ", " + ;
4787:                     EscaparSQL(Grades) + ", " + ;
4788:                     EscaparSQL(LEFT(ALLTRIM(IClis), 10)) + ", " + ;
4789:                     EscaparSQL(LEFT(ALLTRIM(Fornecs), 40)) + ", " + ;
4790:                     EscaparSQL(LEFT(ALLTRIM(Contatos), 20)) + ", " + ;
4791:                     EscaparSQL(LEFT(ALLTRIM(Tel1s), 20)) + ", " + ;
4792:                     EscaparSQL(LEFT(ALLTRIM(FPags), 12)) + ", " + ;
4793:                     FormatarDataSQL(DtEnts) + ", " + ;
4794:                     EscaparSQL(LEFT(IIF(EMPTY(Fretes), "Emitente", ALLTRIM(Fretes)), 12)) + ", " + ;
4795:                     FormatarNumeroSQL(VlFretes, 2) + ")"
4796: 
4797:                 IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
4798:                     MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - INSERT SigCtTFn)" + CHR(13) + ;
4799:                         CapturarErroSQL(), "Erro SQL")
4800:                     RETURN .F.
4801:                 ENDIF
4802:             ENDSCAN
4803:         ENDIF
4804: 
4805:         IF USED("cursor_4c_Produtos")
4806:             SELECT cursor_4c_Produtos
4807:             SCAN FOR !EMPTY(CPros)
4808:                 loc_cSQL = "INSERT INTO SigCtTCt (cidchaves, codigos, citens, cpros, dpros, cunis, " + ;
4809:                     "codcors, codtams, empdopnums, obs, justificas, qtds, qtdadqs, valadqs, " + ;
4810:                     "marca01, marca02, marca03, marca04, marca05, marca06, " + ;
4811:                     "unit01, unit02, unit03, unit04, unit05, unit06, " + ;
4812:                     "tota01, tota02, tota03, tota04, tota05, tota06) VALUES (" + ;
4813:                     EscaparSQL(IIF(EMPTY(cIdChaves), LEFT(fUniqueIds(), 20), cIdChaves)) + ", " + ;
4814:                     FormatarNumeroSQL(loc_nCod, 0) + ", " + ;
4815:                     FormatarNumeroSQL(CItens, 0) + ", " + ;
4816:                     EscaparSQL(LEFT(ALLTRIM(CPros), 14)) + ", " + ;
4817:                     EscaparSQL(LEFT(ALLTRIM(DPros), 65)) + ", " + ;
4818:                     EscaparSQL(LEFT(ALLTRIM(CUnis), 3)) + ", " + ;
4819:                     EscaparSQL(LEFT(ALLTRIM(NVL(CodCors, "")), 4)) + ", " + ;
4820:                     EscaparSQL(LEFT(ALLTRIM(NVL(CodTams, "")), 4)) + ", " + ;
4821:                     EscaparSQL(LEFT(NVL(EmpDopNums, ""), 29)) + ", " + ;
4822:                     EscaparSQL(Obs) + ", " + EscaparSQL(Justificas) + ", " + ;
4823:                     FormatarNumeroSQL(Qtds, 2) + ", " + FormatarNumeroSQL(QtdAdqs, 2) + ", " + ;
4824:                     FormatarNumeroSQL(ValAdqs, 6) + ", " + ;
4825:                     IIF(Marca01, "1", "0") + ", " + IIF(Marca02, "1", "0") + ", " + IIF(Marca03, "1", "0") + ", " + ;
4826:                     IIF(Marca04, "1", "0") + ", " + IIF(Marca05, "1", "0") + ", " + IIF(Marca06, "1", "0") + ", " + ;
4827:                     FormatarNumeroSQL(Unit01, 6) + ", " + FormatarNumeroSQL(Unit02, 6) + ", " + ;
4828:                     FormatarNumeroSQL(Unit03, 6) + ", " + FormatarNumeroSQL(Unit04, 6) + ", " + ;
4829:                     FormatarNumeroSQL(Unit05, 6) + ", " + FormatarNumeroSQL(Unit06, 6) + ", " + ;
4830:                     FormatarNumeroSQL(Tota01, 6) + ", " + FormatarNumeroSQL(Tota02, 6) + ", " + ;
4831:                     FormatarNumeroSQL(Tota03, 6) + ", " + FormatarNumeroSQL(Tota04, 6) + ", " + ;
4832:                     FormatarNumeroSQL(Tota05, 6) + ", " + FormatarNumeroSQL(Tota06, 6) + ")"
4833: 
4834:                 IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
4835:                     MsgErro("Falha na Conex" + CHR(227) + "o (GravaDados - INSERT SigCtTCt)" + CHR(13) + ;
4836:                         CapturarErroSQL(), "Erro SQL")
4837:                     RETURN .F.
4838:                 ENDIF
4839: 
4840:                 SELECT cursor_4c_Produtos
4841:             ENDSCAN
4842:         ENDIF
4843: 
4844:         RETURN .T.
4845:     ENDPROC
4846: 
4847:     *--------------------------------------------------------------------------
4848:     * AprovarCotacao - Equivalente ao PROCEDURE aprovarcotacao legado.
4849:     * Transcrito literal: cada guarda de validacao, ao falhar, zera ChkAprovs,
4850:     * regrava (GravaDados) e devolve o foco ao campo correspondente.
4851:     *--------------------------------------------------------------------------
4852:     PROCEDURE AprovarCotacao()
4853:         LOCAL loc_oApr, loc_oBO, loc_cSQL, loc_nResultado, loc_nVlLib, loc_nTotalCotacao
4854: 
4855:         loc_oApr = THIS.pgf_4c_Paginas.Page3.pgf_4c_ComplCots.Page2

*-- Linhas 4940 a 4978:
4940:         ENDIF
4941: 
4942:         *-- Procurando o cargo do aprovador e o valor maximo de liberacao
4943:         loc_cSQL = "SELECT CCargs FROM SigCdUsu WHERE Usuarios = " + EscaparSQL(loc_oBO.this_cAprovador)
4944:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CargoAprov")
4945: 
4946:         IF loc_nResultado < 0 OR !USED("cursor_4c_CargoAprov") OR EOF("cursor_4c_CargoAprov") OR ;
4947:            EMPTY(cursor_4c_CargoAprov.CCargs)
4948:             MsgAviso("O Aprovador N" + CHR(227) + "o Possui o Cargo Informado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
4949:             loc_oBO.this_nChkAprovs = 0
4950:             IF !THIS.GravaDados()
4951:                 RETURN .F.
4952:             ENDIF
4953:             loc_oApr.chk_4c_ChkAprovador.Value = 0
4954:             loc_oApr.txt_4c_Aprovador.SetFocus()
4955:             IF USED("cursor_4c_CargoAprov")
4956:                 USE IN cursor_4c_CargoAprov
4957:             ENDIF
4958:             RETURN .F.
4959:         ENDIF
4960: 
4961:         loc_cSQL = "SELECT VlLibCots FROM SigCdCrg WHERE CCargs = " + EscaparSQL(cursor_4c_CargoAprov.CCargs)
4962:         USE IN cursor_4c_CargoAprov
4963:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LimiteAprov")
4964: 
4965:         IF loc_nResultado < 0 OR !USED("cursor_4c_LimiteAprov") OR EOF("cursor_4c_LimiteAprov") OR ;
4966:            EMPTY(cursor_4c_LimiteAprov.VlLibCots)
4967:             MsgAviso("O Cargo do Aprovador N" + CHR(227) + "o Possui Um Valor de Libera" + CHR(231) + CHR(227) + ;
4968:                 "o de Cota" + CHR(231) + CHR(227) + "o Informado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
4969:             loc_oBO.this_nChkAprovs = 0
4970:             IF !THIS.GravaDados()
4971:                 RETURN .F.
4972:             ENDIF
4973:             loc_oApr.chk_4c_ChkAprovador.Value = 0
4974:             loc_oApr.txt_4c_Aprovador.SetFocus()
4975:             IF USED("cursor_4c_LimiteAprov")
4976:                 USE IN cursor_4c_LimiteAprov
4977:             ENDIF
4978:             RETURN .F.

*-- Linhas 4993 a 5011:
4993: 
4994:         loc_nTotalCotacao = 0
4995:         IF USED("cursor_4c_CabOperas")
4996:             SELECT SUM(Valors) AS Total FROM cursor_4c_CabOperas INTO CURSOR cursor_4c_SomaCab
4997:             IF USED("cursor_4c_SomaCab") AND !EOF("cursor_4c_SomaCab")
4998:                 loc_nTotalCotacao = NVL(cursor_4c_SomaCab.Total, 0)
4999:             ENDIF
5000:             IF USED("cursor_4c_SomaCab")
5001:                 USE IN cursor_4c_SomaCab
5002:             ENDIF
5003:         ENDIF
5004: 
5005:         IF loc_nTotalCotacao <= 0 OR loc_nTotalCotacao > loc_nVlLib
5006:             MsgAviso("O Cargo do Aprovador N" + CHR(227) + "o Permite a Aprova" + CHR(231) + CHR(227) + ;
5007:                 "o Do Valor Desta Cota" + CHR(231) + CHR(227) + "o!!!" + CHR(13) + CHR(13) + ;
5008:                 "Valor da Cota" + CHR(231) + CHR(227) + "o : " + ALLTRIM(STR(loc_nTotalCotacao, 12, 2)) + ;
5009:                 "  -  Limite Para Aprova" + CHR(231) + CHR(227) + "o : " + ALLTRIM(STR(loc_nVlLib, 12, 2)), ;
5010:                 "Aten" + CHR(231) + CHR(227) + "o!!!")
5011:             loc_oBO.this_nChkAprovs = 0

*-- Linhas 5027 a 5085:
5027:     * CriarCursoresPedidos - Cursores locais da pagina de Pedidos (Page4):
5028:     *
5029:     *   cursor_4c_Pedidos    -> crPedidos    (staging por produto/fornecedor)
5030:     *   cursor_4c_CabOperas  -> crCabOperas  (grdCabOperas, 1 linha por Numes)
5031:     *   cursor_4c_ItnOperas  -> crItnOperas  (grdItnOperas, itens de cada Numes)
5032:     *   cursor_4c_Subniveis  -> crSubniveis  (operacoes de subnivel do Dopes)
5033:     *--------------------------------------------------------------------------
5034:     PROTECTED PROCEDURE CriarCursoresPedidos()
5035:         IF USED("cursor_4c_Pedidos")
5036:             USE IN cursor_4c_Pedidos
5037:         ENDIF
5038:         SET NULL ON
5039:         CREATE CURSOR cursor_4c_Pedidos ( ;
5040:             IFors C(10), Fornecs C(40), FPags C(12), DtEnts D(8), CPros C(14), DPros C(65), ;
5041:             CUnis C(3), Obs M(4), Qtds N(15,2), Valors N(15,2), Fretes C(12), VlFretes N(11,2), ;
5042:             CodCors C(4), CodTams C(4))
5043:         SET NULL OFF
5044: 
5045:         IF USED("cursor_4c_CabOperas")
5046:             USE IN cursor_4c_CabOperas
5047:         ENDIF
5048:         SET NULL ON
5049:         CREATE CURSOR cursor_4c_CabOperas ( ;
5050:             Numes N(6), IFors C(10), Fornecs C(40), FPags C(12), DtEnts D(8), ;
5051:             Qtds N(15,2), Valors N(15,2), Fretes C(12), VlFretes N(11,2), Jobs C(10))
5052:         SET NULL OFF
5053:         INDEX ON IFors TAG IFors
5054:         INDEX ON Numes TAG Ordem
5055: 
5056:         IF USED("cursor_4c_ItnOperas")
5057:             USE IN cursor_4c_ItnOperas
5058:         ENDIF
5059:         SET NULL ON
5060:         CREATE CURSOR cursor_4c_ItnOperas ( ;
5061:             Numes N(6), CItens N(6), CPros C(14), DPros C(65), CodCors C(4), CodTams C(4), ;
5062:             CUnis C(3), Obs M(4), Qtds N(15,2), Units N(15,6), Valors N(15,2))
5063:         SET NULL OFF
5064:         INDEX ON STR(Numes, 6) + STR(CItens, 6) TAG Ordem
5065: 
5066:         IF USED("cursor_4c_Subniveis")
5067:             USE IN cursor_4c_Subniveis
5068:         ENDIF
5069:         SET NULL ON
5070:         CREATE CURSOR cursor_4c_Subniveis ( ;
5071:             Dopes C(20), GruOrigs C(10), GruDests C(10), ConDests C(10), Opers N(1), ;
5072:             CMoes C(3), NFiscals N(1), Series C(3), Especies C(2), TipoNfs N(1), ;
5073:             MarcaSubns C(1), Cfos C(10), Casas N(1), GrVends C(10), ChkLimOps N(1))
5074:         SET NULL OFF
5075:         INDEX ON Dopes TAG Dopes
5076:     ENDPROC
5077: 
5078:     *--------------------------------------------------------------------------
5079:     * GeraPedidos - Equivalente ao PROCEDURE gerapedidos legado: valida os
5080:     * dados de cada fornecedor marcado na grade de Produtos, monta os cursores
5081:     * de cabecalho/itens da pagina de Pedidos e navega para Page4 (a menos que
5082:     * par_lChk seja .T., usado por AprovarCotacao so para CALCULAR o total).
5083:     *
5084:     * NAO inclui a gravacao fisica (SigMvCab/SigMvItn/financeiro) - essa parte
5085:     * (GravaPedidos do legado) esta em THIS.GravaPedidos(), acionada pelo

*-- Linhas 5111 a 5129:
5111:         ZAP IN cursor_4c_ItnOperas
5112: 
5113:         IF USED("cursor_4c_Produtos")
5114:             SELECT cursor_4c_Produtos
5115:             SCAN
5116:                 loc_cLetra = ""
5117:                 DO CASE
5118:                     CASE cursor_4c_Produtos.Marca01
5119:                         loc_cLetra = "A"
5120:                     CASE cursor_4c_Produtos.Marca02
5121:                         loc_cLetra = "B"
5122:                     CASE cursor_4c_Produtos.Marca03
5123:                         loc_cLetra = "C"
5124:                     CASE cursor_4c_Produtos.Marca04
5125:                         loc_cLetra = "D"
5126:                     CASE cursor_4c_Produtos.Marca05
5127:                         loc_cLetra = "E"
5128:                     CASE cursor_4c_Produtos.Marca06
5129:                         loc_cLetra = "F"

*-- Linhas 5198 a 5371:
5198:                         RETURN .F.
5199:                     ENDIF
5200: 
5201:                     loc_cSQL = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
5202:                         EscaparSQL(cursor_4c_Fornecedores.IClis)
5203:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ForneCliChk")
5204: 
5205:                     IF loc_nResultado < 0 OR !USED("cursor_4c_ForneCliChk") OR EOF("cursor_4c_ForneCliChk")
5206:                         MsgAviso("O Produto " + ALLTRIM(cursor_4c_Produtos.CPros) + "-" + ;
5207:                             ALLTRIM(cursor_4c_Produtos.DPros) + CHR(13) + "Foi Solicitado ao Fornecedor " + ;
5208:                             loc_cLetra + " Que Est" + CHR(225) + " Sem o C" + CHR(243) + "digo Informado!!!" + ;
5209:                             CHR(13) + "Para Gerar Pedidos " + CHR(233) + " Necess" + CHR(225) + "rio Realizar " + ;
5210:                             "o Cadastro Deste Fornecedor!!!", "Fornecedor N" + CHR(227) + "o Informado")
5211:                         IF USED("cursor_4c_ForneCliChk")
5212:                             USE IN cursor_4c_ForneCliChk
5213:                         ENDIF
5214:                         RETURN .F.
5215:                     ENDIF
5216:                     IF USED("cursor_4c_ForneCliChk")
5217:                         USE IN cursor_4c_ForneCliChk
5218:                     ENDIF
5219: 
5220:                     INSERT INTO cursor_4c_Pedidos (IFors, Fornecs, FPags, DtEnts, CPros, DPros, CUnis, Obs, ;
5221:                             Qtds, Valors, Fretes, VlFretes, CodCors, CodTams) ;
5222:                         VALUES (ALLTRIM(cursor_4c_Fornecedores.IClis), ALLTRIM(cursor_4c_Fornecedores.Fornecs), ;
5223:                             ALLTRIM(cursor_4c_Fornecedores.FPags), NVL(cursor_4c_Fornecedores.DtEnts, {}), ;
5224:                             ALLTRIM(cursor_4c_Produtos.CPros), ALLTRIM(cursor_4c_Produtos.DPros), ;
5225:                             ALLTRIM(cursor_4c_Produtos.CUnis), NVL(cursor_4c_Produtos.Obs, ""), ;
5226:                             cursor_4c_Produtos.QtdAdqs, cursor_4c_Produtos.ValAdqs, ;
5227:                             ALLTRIM(cursor_4c_Fornecedores.Fretes), cursor_4c_Fornecedores.VlFretes, ;
5228:                             NVL(cursor_4c_Produtos.CodCors, ""), NVL(cursor_4c_Produtos.CodTams, ""))
5229:                 ENDIF
5230:             ENDSCAN
5231:         ENDIF
5232: 
5233:         IF !USED("cursor_4c_Pedidos") OR EOF("cursor_4c_Pedidos")
5234:             MsgAviso("Nenhum Produto Foi Selecionado Para Gerar Cota" + CHR(231) + CHR(245) + "es!!!", ;
5235:                 "Aten" + CHR(231) + CHR(227) + "o!!!")
5236:             RETURN .F.
5237:         ENDIF
5238: 
5239:         *-- Agrupa por fornecedor (crCabOperas: 1 linha por IFors)
5240:         loc_nNum = 0
5241:         SELECT cursor_4c_Pedidos
5242:         SCAN
5243:             IF !SEEK(cursor_4c_Pedidos.IFors, "cursor_4c_CabOperas", "IFors")
5244:                 loc_nNum = loc_nNum + 1
5245:                 INSERT INTO cursor_4c_CabOperas (Numes, IFors, Fornecs, FPags, DtEnts, Fretes, VlFretes, Jobs) ;
5246:                     VALUES (loc_nNum, cursor_4c_Pedidos.IFors, cursor_4c_Pedidos.Fornecs, cursor_4c_Pedidos.FPags, ;
5247:                         cursor_4c_Pedidos.DtEnts, cursor_4c_Pedidos.Fretes, cursor_4c_Pedidos.VlFretes, ;
5248:                         THIS.this_cJobs)
5249:             ENDIF
5250: 
5251:             loc_nNumAtual = cursor_4c_CabOperas.Numes
5252:             SELECT cursor_4c_CabOperas
5253:             REPLACE Qtds WITH Qtds + cursor_4c_Pedidos.Qtds, ;
5254:                     Valors WITH Valors + cursor_4c_Pedidos.Valors IN cursor_4c_CabOperas
5255: 
5256:             INSERT INTO cursor_4c_ItnOperas (Numes, CPros, DPros, CodCors, CodTams, CUnis, Obs, Qtds, Units, Valors) ;
5257:                 VALUES (loc_nNumAtual, cursor_4c_Pedidos.CPros, cursor_4c_Pedidos.DPros, cursor_4c_Pedidos.CodCors, ;
5258:                     cursor_4c_Pedidos.CodTams, cursor_4c_Pedidos.CUnis, cursor_4c_Pedidos.Obs, ;
5259:                     cursor_4c_Pedidos.Qtds, IIF(cursor_4c_Pedidos.Qtds = 0, 0, cursor_4c_Pedidos.Valors / cursor_4c_Pedidos.Qtds), ;
5260:                     cursor_4c_Pedidos.Valors)
5261: 
5262:             SELECT cursor_4c_Pedidos
5263:         ENDSCAN
5264: 
5265:         *-- Renumera CItens dentro de cada Numes
5266:         loc_nNumAtual = -1
5267:         loc_nItn = 0
5268:         SELECT cursor_4c_ItnOperas
5269:         SCAN
5270:             IF loc_nNumAtual != cursor_4c_ItnOperas.Numes
5271:                 loc_nItn     = 0
5272:                 loc_nNumAtual = cursor_4c_ItnOperas.Numes
5273:             ENDIF
5274:             loc_nItn = loc_nItn + 1
5275:             REPLACE CItens WITH loc_nItn IN cursor_4c_ItnOperas
5276:         ENDSCAN
5277: 
5278:         *-- Operacoes de subnivel do Dopes filtrado em Page1
5279:         loc_cSQL = ;
5280:             "SELECT a.Dopes, a.GruOrigs, a.GruDests, a.ConDests, a.Opers, a.CMoes, a.NFiscals, " + ;
5281:             "a.Series, a.Especies, a.TipoNfs, a.MarcaSubns, a.Cfos, a.Casas, a.GrVends, b.ChkLimOps " + ;
5282:             "FROM SigCdOpe a INNER JOIN SigOpCdd b ON a.Dopes = b.Dopes " + ;
5283:             "WHERE a.Nivels = " + EscaparSQL(PADR(THIS.this_cDopes, 20)) + " " + ;
5284:             "UNION ALL " + ;
5285:             "SELECT b.CDopes AS Dopes, c.GruOrigs, c.GruDests, c.ConDests, c.Opers, c.CMoes, c.NFiscals, " + ;
5286:             "c.Series, c.Especies, c.TipoNfs, c.MarcaSubns, c.Cfos, c.Casas, c.GrVends, d.ChkLimOps " + ;
5287:             "FROM SigOpCsn b INNER JOIN SigCdOpe c ON b.CDopes = c.Dopes " + ;
5288:             "INNER JOIN SigOpCdd d ON b.CDopes = d.Dopes " + ;
5289:             "WHERE b.CNivels = " + EscaparSQL(PADR(THIS.this_cDopes, 20))
5290: 
5291:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubTemp")
5292: 
5293:         IF loc_nResultado < 0
5294:             MsgErro("Falha na Conex" + CHR(227) + "o (GeraPedidos - Subn" + CHR(237) + "veis)" + CHR(13) + ;
5295:                 CapturarErroSQL(), "Erro SQL")
5296:             RETURN .F.
5297:         ENDIF
5298: 
5299:         IF !USED("cursor_4c_Subniveis")
5300:             THIS.CriarCursoresPedidos()
5301:         ENDIF
5302:         ZAP IN cursor_4c_Subniveis
5303: 
5304:         IF USED("cursor_4c_SubTemp")
5305:             SELECT DISTINCT * FROM cursor_4c_SubTemp INTO CURSOR cursor_4c_SubDistinct
5306:             SELECT cursor_4c_SubDistinct
5307:             SCAN
5308:                 INSERT INTO cursor_4c_Subniveis (Dopes, GruOrigs, GruDests, ConDests, Opers, CMoes, ;
5309:                         NFiscals, Series, Especies, TipoNfs, MarcaSubns, Cfos, Casas, GrVends, ChkLimOps) ;
5310:                     VALUES (cursor_4c_SubDistinct.Dopes, cursor_4c_SubDistinct.GruOrigs, cursor_4c_SubDistinct.GruDests, ;
5311:                         cursor_4c_SubDistinct.ConDests, cursor_4c_SubDistinct.Opers, cursor_4c_SubDistinct.CMoes, ;
5312:                         cursor_4c_SubDistinct.NFiscals, cursor_4c_SubDistinct.Series, cursor_4c_SubDistinct.Especies, ;
5313:                         cursor_4c_SubDistinct.TipoNfs, cursor_4c_SubDistinct.MarcaSubns, cursor_4c_SubDistinct.Cfos, ;
5314:                         cursor_4c_SubDistinct.Casas, cursor_4c_SubDistinct.GrVends, cursor_4c_SubDistinct.ChkLimOps)
5315:             ENDSCAN
5316:             IF USED("cursor_4c_SubDistinct")
5317:                 USE IN cursor_4c_SubDistinct
5318:             ENDIF
5319:             USE IN cursor_4c_SubTemp
5320:         ENDIF
5321: 
5322:         GO TOP IN cursor_4c_Subniveis
5323: 
5324:         *-- Preenche o cabecalho da operacao de pedido (cnt_4c_Operacao)
5325:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "cnt_4c_Operacao", 5)
5326:             WITH THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
5327:                 .txt_4c_Emps.Value  = THIS.this_cEmps
5328:                 .txt_4c_Job.Value   = THIS.this_cJobs
5329:                 .txt_4c_Datas.Value = DATE()
5330: 
5331:                 IF !EOF("cursor_4c_Subniveis")
5332:                     .txt_4c_Dopes.Value  = ALLTRIM(cursor_4c_Subniveis.Dopes)
5333:                     .txt_4c_CMoes.Value  = ALLTRIM(cursor_4c_Subniveis.CMoes)
5334:                     .txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_Subniveis.GruDests)
5335:                     .txt_4c_ContaDs.Value = ALLTRIM(cursor_4c_Subniveis.ConDests)
5336:                 ENDIF
5337: 
5338:                 .txt_4c_ContaEs.Value = ALLTRIM(loc_oBO.this_cContaEs)
5339:                 .obj_4c_GetObs.Value = "Cota" + CHR(231) + CHR(227) + "o " + ;
5340:                     ALLTRIM(STR(loc_oBO.this_nCodigos, 6)) + ;
5341:                     IIF(EMPTY(ALLTRIM(loc_oBO.this_cJustificas)), "", " - ") + ALLTRIM(loc_oBO.this_cJustificas)
5342: 
5343:                 IF !EMPTY(.txt_4c_ContaDs.Value)
5344:                     loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(.txt_4c_ContaDs.Value)
5345:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DContaDsTmp") > 0 AND ;
5346:                        USED("cursor_4c_DContaDsTmp") AND !EOF("cursor_4c_DContaDsTmp")
5347:                         .txt_4c_DContaDs.Value = ALLTRIM(cursor_4c_DContaDsTmp.RClis)
5348:                     ENDIF
5349:                     IF USED("cursor_4c_DContaDsTmp")
5350:                         USE IN cursor_4c_DContaDsTmp
5351:                     ENDIF
5352:                 ENDIF
5353: 
5354:                 IF !EMPTY(.txt_4c_ContaEs.Value)
5355:                     loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(.txt_4c_ContaEs.Value)
5356:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DContaEsTmp") > 0 AND ;
5357:                        USED("cursor_4c_DContaEsTmp") AND !EOF("cursor_4c_DContaEsTmp")
5358:                         .txt_4c_DContaEs.Value = ALLTRIM(cursor_4c_DContaEsTmp.RClis)
5359:                     ENDIF
5360:                     IF USED("cursor_4c_DContaEsTmp")
5361:                         USE IN cursor_4c_DContaEsTmp
5362:                     ENDIF
5363:                 ENDIF
5364:             ENDWITH
5365:         ENDIF
5366: 
5367:         IF !USED("cursor_4c_CabOperas") OR EOF("cursor_4c_CabOperas")
5368:             MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Processar!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5369:             THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Column1.SetFocus()
5370:             RETURN .F.
5371:         ENDIF

*-- Linhas 5416 a 5515:
5416:         ZAP IN cursor_4c_CabOperas
5417:         ZAP IN cursor_4c_ItnOperas
5418: 
5419:         loc_cSQL = "SELECT * FROM SigCtTPc WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)
5420:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaPc")
5421: 
5422:         IF loc_nResultado < 0
5423:             MsgErro("Falha na Conex" + CHR(227) + "o (ConsultaPedidos - SigCtTPc)" + CHR(13) + ;
5424:                 CapturarErroSQL(), "Erro SQL")
5425:             RETURN .F.
5426:         ENDIF
5427: 
5428:         IF USED("cursor_4c_ConsultaPc") AND !EOF("cursor_4c_ConsultaPc")
5429:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "cnt_4c_Operacao", 5)
5430:                 WITH THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
5431:                     .txt_4c_Datas.Value   = ConverterParaData(NVL(cursor_4c_ConsultaPc.Datas, {}))
5432:                     .txt_4c_Emps.Value    = ALLTRIM(NVL(cursor_4c_ConsultaPc.Emps, ""))
5433:                     .txt_4c_Dopes.Value   = ALLTRIM(NVL(cursor_4c_ConsultaPc.Dopes, ""))
5434:                     .txt_4c_CMoes.Value   = ALLTRIM(NVL(cursor_4c_ConsultaPc.CMoes, ""))
5435:                     .txt_4c_Grupo.Value   = ALLTRIM(NVL(cursor_4c_ConsultaPc.GrupoDs, ""))
5436:                     .txt_4c_ContaDs.Value = ALLTRIM(NVL(cursor_4c_ConsultaPc.ContaDs, ""))
5437:                     .txt_4c_CodObs.Value  = NVL(cursor_4c_ConsultaPc.CodObs, 0)
5438:                     .obj_4c_GetObs.Value  = NVL(cursor_4c_ConsultaPc.Obs, "")
5439:                     .txt_4c_ContaEs.Value = ALLTRIM(NVL(cursor_4c_ConsultaPc.ContaEs, ""))
5440: 
5441:                     IF !EMPTY(.txt_4c_ContaDs.Value)
5442:                         IF SQLEXEC(gnConnHandle, "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
5443:                             EscaparSQL(.txt_4c_ContaDs.Value), "cursor_4c_DsTmp") > 0 AND ;
5444:                            USED("cursor_4c_DsTmp") AND !EOF("cursor_4c_DsTmp")
5445:                             .txt_4c_DContaDs.Value = ALLTRIM(cursor_4c_DsTmp.RClis)
5446:                         ENDIF
5447:                         IF USED("cursor_4c_DsTmp")
5448:                             USE IN cursor_4c_DsTmp
5449:                         ENDIF
5450:                     ENDIF
5451: 
5452:                     IF !EMPTY(.txt_4c_ContaEs.Value)
5453:                         IF SQLEXEC(gnConnHandle, "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
5454:                             EscaparSQL(.txt_4c_ContaEs.Value), "cursor_4c_EsTmp") > 0 AND ;
5455:                            USED("cursor_4c_EsTmp") AND !EOF("cursor_4c_EsTmp")
5456:                             .txt_4c_DContaEs.Value = ALLTRIM(cursor_4c_EsTmp.RClis)
5457:                         ENDIF
5458:                         IF USED("cursor_4c_EsTmp")
5459:                             USE IN cursor_4c_EsTmp
5460:                         ENDIF
5461:                     ENDIF
5462:                 ENDWITH
5463:             ENDIF
5464: 
5465:             loc_cSQL = "SELECT * FROM SigCtTPe WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)
5466:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaPe")
5467: 
5468:             IF loc_nResultado < 0
5469:                 MsgErro("Falha na Conex" + CHR(227) + "o (ConsultaPedidos - SigCtTPe)" + CHR(13) + ;
5470:                     CapturarErroSQL(), "Erro SQL")
5471:                 RETURN .F.
5472:             ENDIF
5473: 
5474:             IF USED("cursor_4c_ConsultaPe")
5475:                 SELECT cursor_4c_ConsultaPe
5476:                 SCAN
5477:                     INSERT INTO cursor_4c_CabOperas (Numes, IFors, Fornecs, FPags, DtEnts, Qtds, Valors, Fretes, VlFretes) ;
5478:                         VALUES (cursor_4c_ConsultaPe.Numes, ALLTRIM(cursor_4c_ConsultaPe.IFors), ;
5479:                             ALLTRIM(cursor_4c_ConsultaPe.Fornecs), ALLTRIM(cursor_4c_ConsultaPe.FPags), ;
5480:                             ConverterParaData(NVL(cursor_4c_ConsultaPe.DtEnts, {})), cursor_4c_ConsultaPe.Qtds, ;
5481:                             cursor_4c_ConsultaPe.Valors, ALLTRIM(NVL(cursor_4c_ConsultaPe.Fretes, "")), ;
5482:                             NVL(cursor_4c_ConsultaPe.VlFretes, 0))
5483:                 ENDSCAN
5484:                 USE IN cursor_4c_ConsultaPe
5485:             ENDIF
5486: 
5487:             loc_cSQL = "SELECT * FROM SigCtTPi WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0) + ;
5488:                 " ORDER BY Numes, CItens"
5489:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaPi")
5490: 
5491:             IF loc_nResultado < 0
5492:                 MsgErro("Falha na Conex" + CHR(227) + "o (ConsultaPedidos - SigCtTPi)" + CHR(13) + ;
5493:                     CapturarErroSQL(), "Erro SQL")
5494:                 RETURN .F.
5495:             ENDIF
5496: 
5497:             IF USED("cursor_4c_ConsultaPi")
5498:                 SELECT cursor_4c_ConsultaPi
5499:                 SCAN
5500:                     INSERT INTO cursor_4c_ItnOperas (CItens, Numes, CPros, DPros, CodCors, CodTams, CUnis, Obs, Qtds, Units, Valors) ;
5501:                         VALUES (cursor_4c_ConsultaPi.CItens, cursor_4c_ConsultaPi.Numes, ALLTRIM(cursor_4c_ConsultaPi.CPros), ;
5502:                             ALLTRIM(cursor_4c_ConsultaPi.DPros), ALLTRIM(NVL(cursor_4c_ConsultaPi.CodCors, "")), ;
5503:                             ALLTRIM(NVL(cursor_4c_ConsultaPi.CodTams, "")), ALLTRIM(cursor_4c_ConsultaPi.CUnis), ;
5504:                             NVL(cursor_4c_ConsultaPi.Obs, ""), cursor_4c_ConsultaPi.Qtds, cursor_4c_ConsultaPi.Units, ;
5505:                             cursor_4c_ConsultaPi.Valors)
5506:                 ENDSCAN
5507:                 USE IN cursor_4c_ConsultaPi
5508:             ENDIF
5509:         ENDIF
5510: 
5511:         IF USED("cursor_4c_ConsultaPc")
5512:             USE IN cursor_4c_ConsultaPc
5513:         ENDIF
5514: 
5515:         IF !USED("cursor_4c_CabOperas") OR EOF("cursor_4c_CabOperas")

*-- Linhas 5549 a 5586:
5549:     * na data) feita duas linhas acima para a moeda padrao.
5550:     *--------------------------------------------------------------------------
5551:     PROTECTED FUNCTION LiberaPagto(par_nValTit, par_cMoeTit, par_dDatTit)
5552:         LOCAL loc_cSQL, loc_cCargo, loc_nVlLib, loc_nCotP, loc_nVlL, loc_lLib
5553: 
5554:         IF !USED("cursor_4c_Subniveis") OR cursor_4c_Subniveis.ChkLimOps != 1
5555:             RETURN .T.
5556:         ENDIF
5557: 
5558:         loc_cSQL = "SELECT CCargs FROM SigCdUsu WHERE Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado)
5559:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LibUsu") < 1 OR !USED("cursor_4c_LibUsu") OR EOF("cursor_4c_LibUsu")
5560:             MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + ;
5561:                 "o (CrSigCdUsu)", "Erro SQL")
5562:             IF USED("cursor_4c_LibUsu")
5563:                 USE IN cursor_4c_LibUsu
5564:             ENDIF
5565:             RETURN .F.
5566:         ENDIF
5567:         loc_cCargo = ALLTRIM(NVL(cursor_4c_LibUsu.CCargs, ""))
5568:         USE IN cursor_4c_LibUsu
5569: 
5570:         loc_cSQL = "SELECT VlLibOpes FROM SigCdCrg WHERE CCargs = " + EscaparSQL(loc_cCargo)
5571:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LibCrg") < 1 OR !USED("cursor_4c_LibCrg") OR EOF("cursor_4c_LibCrg")
5572:             MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + ;
5573:                 "o (CrTmpCarg)", "Erro SQL")
5574:             IF USED("cursor_4c_LibCrg")
5575:                 USE IN cursor_4c_LibCrg
5576:             ENDIF
5577:             RETURN .F.
5578:         ENDIF
5579:         loc_nVlLib = NVL(cursor_4c_LibCrg.VlLibOpes, 0)
5580:         USE IN cursor_4c_LibCrg
5581: 
5582:         loc_nCotP = fBuscarCotacao(THIS.this_cMoedaPs, par_dDatTit)
5583:         loc_nVlL  = par_nValTit * IIF(par_cMoeTit == THIS.this_cMoedaPs, 1, ;
5584:             fBuscarCotacao(par_cMoeTit, par_dDatTit) / loc_nCotP)
5585:         loc_lLib  = (loc_nVlLib >= loc_nVlL)
5586: 

*-- Linhas 5599 a 5618:
5599:     * conjunto de SigMvCab/Itn/Par por fornecedor marcado (cursor_4c_CabOperas).
5600:     *
5601:     * Adaptacoes de arquitetura (regra ja usada em GravaDados/AprovarCotacao
5602:     * deste form): SQLEXEC direto por registro em vez de cursor bufferizado +
5603:     * TableUpdate/Rollback. Como a conexao deste ambiente nasce com
5604:     * Transactions=2 (manual - medido, ver functions.prg:fGerUniqueKey), o
5605:     * "tudo ou nada" do Commit/Rollback legado equivale a SQLCOMMIT/SQLROLLBACK
5606:     * explicitos ao final (mesmo padrao de SIGMVCMVBO.GravarLancamentos).
5607:     *
5608:     * Duas funcoes GLOBAIS do legado ficam FORA do dump (regra #27 - nunca
5609:     * chutar valor de calculo/lancamento financeiro):
5610:     *   fCalcularImpostos  - calcula impostos da Nota Fiscal (NFiscals 1/2).
5611:     *                        Operacoes que emitem NF automaticamente por essa
5612:     *                        tela ficam BLOQUEADAS ate a funcao ser portada -
5613:     *                        aviso claro em vez de estourar em runtime.
5614:     *   fSigOpFin_Lancs    - lancamentos financeiros automaticos configurados
5615:     *                        em SigOpCdi. So dispara quando ha configuracao
5616:     *                        para a operacao (sem config, e no-op no legado
5617:     *                        tambem) - chamada literal, sem wrapper, para
5618:     *                        falhar alto so nesse caso especifico.

*-- Linhas 5651 a 5718:
5651:             loc_oCnt.txt_4c_Datas.SetFocus()
5652:             RETURN .F.
5653:         ENDIF
5654: 
5655:         loc_cDop = ALLTRIM(loc_oCnt.txt_4c_Dopes.Value)
5656:         IF !USED("cursor_4c_Subniveis") OR EMPTY(loc_cDop) OR ;
5657:             !SEEK(PADR(loc_cDop, 20), "cursor_4c_Subniveis", "Dopes")
5658:             MsgAviso("A Opera" + CHR(231) + CHR(227) + "o de Lan" + CHR(231) + "amento N" + CHR(227) + ;
5659:                 "o Foi Informada!!!", "Dados Inv" + CHR(225) + "lidos!!!")
5660:             loc_oCnt.txt_4c_Dopes.SetFocus()
5661:             RETURN .F.
5662:         ENDIF
5663: 
5664:         loc_cMoe = ALLTRIM(loc_oCnt.txt_4c_CMoes.Value)
5665:         IF EMPTY(loc_cMoe)
5666:             MsgAviso("A Moeda de Lan" + CHR(231) + "amento N" + CHR(227) + "o Foi Informada!!!", ;
5667:                 "Dados Inv" + CHR(225) + "lidos!!!")
5668:             loc_oCnt.txt_4c_CMoes.SetFocus()
5669:             RETURN .F.
5670:         ENDIF
5671: 
5672:         IF !USED("cursor_4c_CabOperas") OR EOF("cursor_4c_CabOperas")
5673:             MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Para Gravar!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5674:             RETURN .F.
5675:         ENDIF
5676: 
5677:         *-- cursor_4c_Subniveis ja esta posicionado pelo SEEK acima
5678:         loc_cGrO = ALLTRIM(cursor_4c_Subniveis.GruOrigs)
5679:         loc_cGrD = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
5680:         loc_cCtD = ALLTRIM(loc_oCnt.txt_4c_ContaDs.Value)
5681:         loc_cCtE = ALLTRIM(loc_oCnt.txt_4c_ContaEs.Value)
5682:         loc_nObs = loc_oCnt.txt_4c_CodObs.Value
5683:         loc_cObs = loc_oCnt.obj_4c_GetObs.Value
5684:         loc_nEnt = loc_oBO.this_nLocalEnts
5685:         loc_cOpe = IIF(cursor_4c_Subniveis.Opers = 1, "E", "S")
5686:         loc_nENF = cursor_4c_Subniveis.NFiscals
5687:         loc_cGrv = ALLTRIM(cursor_4c_Subniveis.GrVends)
5688: 
5689:         IF INLIST(loc_nENF, 1, 2)
5690:             MsgErro("Esta opera" + CHR(231) + CHR(227) + "o emite Nota Fiscal automaticamente ao " + ;
5691:                 "gerar o pedido (c" + CHR(225) + "lculo de impostos), funcionalidade ainda n" + ;
5692:                 CHR(227) + "o portada para o sistema novo." + CHR(13) + ;
5693:                 "Selecione uma opera" + CHR(231) + CHR(227) + "o de lan" + CHR(231) + "amento que N" + ;
5694:                 CHR(227) + "o emita NF, ou gere este pedido pelo sistema legado.", ;
5695:                 "Funcionalidade N" + CHR(227) + "o Dispon" + CHR(237) + "vel")
5696:             RETURN .F.
5697:         ENDIF
5698: 
5699:         *-- Limite de valor por cargo (Tiago - 22/09/2014 - CC2016)
5700:         IF cursor_4c_Subniveis.ChkLimOps = 1
5701:             loc_nCotP = fBuscarCotacao(THIS.this_cMoedaPs, loc_dDat)
5702:             loc_lOk   = .T.
5703:             SELECT cursor_4c_CabOperas
5704:             GO TOP
5705:             DO WHILE loc_lOk AND !EOF("cursor_4c_CabOperas")
5706:                 loc_nCotPen = IIF(EMPTY(loc_cMoe), 1, fBuscarCotacao(loc_cMoe, loc_dDat))
5707:                 loc_nTtPen  = cursor_4c_CabOperas.Valors * loc_nCotPen
5708:                 loc_nTtGer  = IIF(loc_nCotP = 0, 0, loc_nTtPen / loc_nCotP)
5709:                 IF !THIS.LiberaPagto(loc_nTtGer, THIS.this_cMoedaPs, loc_dDat)
5710:                     loc_lOk = .F.
5711:                 ENDIF
5712:                 IF loc_lOk
5713:                     SKIP IN cursor_4c_CabOperas
5714:                 ENDIF
5715:             ENDDO
5716:             IF !loc_lOk
5717:                 RETURN .F.
5718:             ENDIF

*-- Linhas 5724 a 5960:
5724: 
5725:         TRY
5726:             *-- SigCtTPc - cabecalho da cotacao-pedido (1 registro, fora do loop
5727:             *-- por fornecedor - Insert Into crSigCtTPc do legado)
5728:             loc_cSQL = "INSERT INTO SigCtTPc (cidchaves, codigos, datars, datas, emps, dopes, cmoes, " + ;
5729:                 "grupods, contads, contaes, codobs, obs) VALUES (" + ;
5730:                 EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
5731:                 FormatarNumeroSQL(loc_oBO.this_nCodigos, 0) + ", GETDATE(), " + ;
5732:                 FormatarDataSQL(loc_dDat) + ", " + ;
5733:                 EscaparSQL(loc_cEmp) + ", " + EscaparSQL(loc_cDop) + ", " + EscaparSQL(loc_cMoe) + ", " + ;
5734:                 EscaparSQL(loc_cGrD) + ", " + EscaparSQL(loc_cCtD) + ", " + EscaparSQL(loc_cCtE) + ", " + ;
5735:                 FormatarNumeroSQL(loc_nObs, 0) + ", " + EscaparSQL(loc_cObs) + ")"
5736: 
5737:             IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5738:                 loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPc)" + CHR(13) + CapturarErroSQL()
5739:                 loc_lOk = .F.
5740:             ENDIF
5741: 
5742:             SELECT cursor_4c_CabOperas
5743:             GO TOP
5744:             DO WHILE loc_lOk AND !EOF("cursor_4c_CabOperas")
5745:                 loc_nNumesGrupo = cursor_4c_CabOperas.Numes
5746: 
5747:                 loc_nNum = fGerUniqueKey(ALLTRIM(loc_cDop) + loc_cEmp)
5748:                 loc_nNop = fGerUniqueKey("SIGMVCCR")
5749:                 loc_cEmpDopNums = loc_cEmp + loc_cDop + STR(loc_nNum, 6)
5750:                 loc_cEmpGopNums = loc_cEmp + SPACE(20) + STR(loc_nNum, 6)
5751: 
5752:                 *-- SigMvCab - cabecalho da movimentacao (1 por fornecedor)
5753:                 loc_cSQL = "INSERT INTO SigMvCab (cidchaves, emps, dopes, numes, empdopnums, mascnum, " + ;
5754:                     "opers, datas, datars, dtalts, grupoos, contaos, grupods, contads, contaes, " + ;
5755:                     "localents, codobs, obses, valos, valinis, usuars, prazoents, empgopnums, " + ;
5756:                     "usupagos, grvends, resps, jobs) VALUES (" + ;
5757:                     EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
5758:                     EscaparSQL(loc_cEmp) + ", " + EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
5759:                     EscaparSQL(loc_cEmpDopNums) + ", " + EscaparSQL(ALLTRIM(fGerMascara(loc_nNum))) + ", " + ;
5760:                     EscaparSQL(loc_cOpe) + ", " + FormatarDataSQL(loc_dDat) + ", GETDATE(), GETDATE(), " + ;
5761:                     EscaparSQL(loc_cGrO) + ", " + EscaparSQL(cursor_4c_CabOperas.IFors) + ", " + ;
5762:                     EscaparSQL(loc_cGrD) + ", " + EscaparSQL(loc_cCtD) + ", " + EscaparSQL(loc_cCtE) + ", " + ;
5763:                     FormatarNumeroSQL(loc_nEnt, 0) + ", " + FormatarNumeroSQL(loc_nObs, 0) + ", " + ;
5764:                     EscaparSQL(loc_cObs) + ", " + FormatarNumeroSQL(cursor_4c_CabOperas.Valors, 2) + ", " + ;
5765:                     FormatarNumeroSQL(cursor_4c_CabOperas.Valors, 2) + ", " + EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
5766:                     FormatarDataSQL(cursor_4c_CabOperas.DtEnts) + ", " + EscaparSQL(loc_cEmpGopNums) + ", " + ;
5767:                     EscaparSQL(LEFT(loc_oBO.this_cAprovador, 10)) + ", " + EscaparSQL(loc_cGrv) + ", " + ;
5768:                     EscaparSQL(LEFT(loc_oBO.this_cComprador, 12)) + ", " + ;
5769:                     EscaparSQL(LEFT(NVL(cursor_4c_CabOperas.Jobs, ""), 10)) + ")"
5770: 
5771:                 IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5772:                     loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvCab)" + CHR(13) + CapturarErroSQL()
5773:                     loc_lOk = .F.
5774:                 ENDIF
5775: 
5776:                 *-- SigCtTPs - liga o Codigos da cotacao ao EmpDopNums gerado
5777:                 IF loc_lOk
5778:                     loc_cSQL = "INSERT INTO SigCtTPs (cidchaves, codigos, empdopnums) VALUES (" + ;
5779:                         EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + FormatarNumeroSQL(loc_oBO.this_nCodigos, 0) + ", " + ;
5780:                         EscaparSQL(loc_cEmpDopNums) + ")"
5781:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5782:                         loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPs)" + CHR(13) + CapturarErroSQL()
5783:                         loc_lOk = .F.
5784:                     ENDIF
5785:                 ENDIF
5786: 
5787:                 *-- SigCtTPe - fornecedor/condicao/entrega do pedido (1 por fornecedor)
5788:                 IF loc_lOk
5789:                     loc_cSQL = "INSERT INTO SigCtTPe (cidchaves, codigos, numes, ifors, fornecs, fpags, " + ;
5790:                         "dtents, qtds, valors, fretes, vlfretes) VALUES (" + ;
5791:                         EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + FormatarNumeroSQL(loc_oBO.this_nCodigos, 0) + ", " + ;
5792:                         FormatarNumeroSQL(loc_nNumesGrupo, 0) + ", " + ;
5793:                         EscaparSQL(LEFT(cursor_4c_CabOperas.IFors, 10)) + ", " + ;
5794:                         EscaparSQL(LEFT(cursor_4c_CabOperas.Fornecs, 50)) + ", " + ;
5795:                         EscaparSQL(LEFT(cursor_4c_CabOperas.FPags, 12)) + ", " + ;
5796:                         FormatarDataSQL(cursor_4c_CabOperas.DtEnts) + ", " + ;
5797:                         FormatarNumeroSQL(cursor_4c_CabOperas.Qtds, 2) + ", " + ;
5798:                         FormatarNumeroSQL(cursor_4c_CabOperas.Valors, 6) + ", " + ;
5799:                         EscaparSQL(LEFT(NVL(cursor_4c_CabOperas.Fretes, ""), 12)) + ", " + ;
5800:                         FormatarNumeroSQL(cursor_4c_CabOperas.VlFretes, 2) + ")"
5801:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5802:                         loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPe)" + CHR(13) + CapturarErroSQL()
5803:                         loc_lOk = .F.
5804:                     ENDIF
5805:                 ENDIF
5806: 
5807:                 *-- Itens do fornecedor corrente (cursor_4c_ItnOperas.Numes = loc_nNumesGrupo)
5808:                 IF loc_lOk
5809:                     SELECT cursor_4c_ItnOperas
5810:                     GO TOP
5811:                     LOCATE FOR cursor_4c_ItnOperas.Numes = loc_nNumesGrupo
5812:                     DO WHILE loc_lOk AND !EOF("cursor_4c_ItnOperas") AND cursor_4c_ItnOperas.Numes = loc_nNumesGrupo
5813:                         loc_cSQL = "INSERT INTO SigMvItn (cidchaves, emps, dopes, numes, empdopnums, dtalts, " + ;
5814:                             "citens, cpros, dpros, obs, opers, moedas, moefats, moevals, qtds, aqtds, units, " + ;
5815:                             "totas, cunis) VALUES (" + ;
5816:                             EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + EscaparSQL(loc_cEmp) + ", " + ;
5817:                             EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
5818:                             EscaparSQL(loc_cEmpDopNums) + ", GETDATE(), " + ;
5819:                             FormatarNumeroSQL(cursor_4c_ItnOperas.CItens, 0) + ", " + ;
5820:                             EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CPros), 14)) + ", " + ;
5821:                             EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.DPros), 65)) + ", " + ;
5822:                             EscaparSQL(NVL(cursor_4c_ItnOperas.Obs, "")) + ", " + ;
5823:                             EscaparSQL(loc_cOpe) + ", " + EscaparSQL(loc_cMoe) + ", " + EscaparSQL(loc_cMoe) + ", " + ;
5824:                             FormatarNumeroSQL(1, 0) + ", " + ;
5825:                             FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
5826:                             FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
5827:                             FormatarNumeroSQL(cursor_4c_ItnOperas.Units, 6) + ", " + ;
5828:                             FormatarNumeroSQL(cursor_4c_ItnOperas.Valors, 2) + ", " + ;
5829:                             EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CUnis), 3)) + ")"
5830: 
5831:                         IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5832:                             loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvItn)" + CHR(13) + CapturarErroSQL()
5833:                             loc_lOk = .F.
5834:                         ENDIF
5835: 
5836:                         IF loc_lOk
5837:                             loc_cSQL = "INSERT INTO SigCtTPi (cidchaves, codigos, citens, numes, cpros, " + ;
5838:                                 "dpros, codcors, codtams, cunis, obs, qtds, units, valors) VALUES (" + ;
5839:                                 EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + FormatarNumeroSQL(loc_oBO.this_nCodigos, 0) + ", " + ;
5840:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.CItens, 0) + ", " + ;
5841:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Numes, 0) + ", " + ;
5842:                                 EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CPros), 14)) + ", " + ;
5843:                                 EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.DPros), 50)) + ", " + ;
5844:                                 EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodCors, ""), 4)) + ", " + ;
5845:                                 EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodTams, ""), 4)) + ", " + ;
5846:                                 EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CUnis), 3)) + ", " + ;
5847:                                 EscaparSQL(NVL(cursor_4c_ItnOperas.Obs, "")) + ", " + ;
5848:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 2) + ", " + ;
5849:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Units, 6) + ", " + ;
5850:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Valors, 6) + ")"
5851:                             IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5852:                                 loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPi)" + CHR(13) + CapturarErroSQL()
5853:                                 loc_lOk = .F.
5854:                             ENDIF
5855:                         ENDIF
5856: 
5857:                         *-- SigMvIts - detalhe de cor/tamanho, so quando informado
5858:                         IF loc_lOk AND (!EMPTY(cursor_4c_ItnOperas.CodCors) OR !EMPTY(cursor_4c_ItnOperas.CodTams))
5859:                             loc_cSQL = "INSERT INTO SigMvIts (cidchaves, emps, dopes, numes, citens, cpros, " + ;
5860:                                 "codcors, codtams, qtds, aqtds, empdopnums, chksubn) VALUES (" + ;
5861:                                 EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + EscaparSQL(loc_cEmp) + ", " + ;
5862:                                 EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
5863:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.CItens, 0) + ", " + ;
5864:                                 EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CPros), 14)) + ", " + ;
5865:                                 EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodCors, ""), 4)) + ", " + ;
5866:                                 EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodTams, ""), 4)) + ", " + ;
5867:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
5868:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
5869:                                 EscaparSQL(loc_cEmpDopNums) + ", 0)"
5870:                             IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5871:                                 loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvIts)" + CHR(13) + CapturarErroSQL()
5872:                                 loc_lOk = .F.
5873:                             ENDIF
5874:                         ENDIF
5875: 
5876:                         IF loc_lOk
5877:                             SKIP IN cursor_4c_ItnOperas
5878:                         ENDIF
5879:                     ENDDO
5880:                 ENDIF
5881: 
5882:                 *-- SigMvPar - parcelas financeiras conforme a condicao de pagamento
5883:                 IF loc_lOk
5884:                     loc_cSQL = "SELECT FParcs, MoeFpgs, TVens, Dias FROM SigOpFp WHERE FPags = " + ;
5885:                         EscaparSQL(ALLTRIM(cursor_4c_CabOperas.FPags))
5886:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalFPag")
5887: 
5888:                     IF loc_nResultado >= 0 AND USED("cursor_4c_LocalFPag") AND !EOF("cursor_4c_LocalFPag")
5889:                         loc_nPar = IIF(NVL(cursor_4c_LocalFPag.FParcs, 0) < 1, 1, cursor_4c_LocalFPag.FParcs)
5890:                         loc_dDtV = loc_dDat
5891:                         loc_cMdf = IIF(EMPTY(NVL(cursor_4c_LocalFPag.MoeFpgs, "")), loc_cMoe, ;
5892:                             ALLTRIM(cursor_4c_LocalFPag.MoeFpgs))
5893: 
5894:                         FOR loc_nI = 1 TO loc_nPar
5895:                             loc_cSQL = "INSERT INTO SigMvPar (cidchaves, emps, dopes, numes, empdopnums, " + ;
5896:                                 "datas, cotfpgs, fpags, moefpgs, nopers, valos, vencs, parcs, pagos, dtalts) VALUES (" + ;
5897:                                 EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + EscaparSQL(loc_cEmp) + ", " + ;
5898:                                 EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
5899:                                 EscaparSQL(loc_cEmpDopNums) + ", " + FormatarDataSQL(loc_dDat) + ", " + ;
5900:                                 FormatarNumeroSQL(1, 4) + ", " + EscaparSQL(LEFT(cursor_4c_CabOperas.FPags, 12)) + ", " + ;
5901:                                 EscaparSQL(LEFT(loc_cMdf, 3)) + ", " + FormatarNumeroSQL(loc_nNop, 0) + ", " + ;
5902:                                 FormatarNumeroSQL(cursor_4c_CabOperas.Valors / loc_nPar, 2) + ", " + ;
5903:                                 FormatarDataSQL(loc_dDtV) + ", " + FormatarNumeroSQL(loc_nI, 0) + ", " + ;
5904:                                 EscaparSQL("1") + ", GETDATE())"
5905: 
5906:                             IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5907:                                 loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvPar)" + CHR(13) + CapturarErroSQL()
5908:                                 loc_lOk = .F.
5909:                             ENDIF
5910: 
5911:                             IF UPPER(ALLTRIM(NVL(cursor_4c_LocalFPag.TVens, ""))) == "F"
5912:                                 loc_dDtV = GOMONTH(loc_dDat, loc_nI)
5913:                             ELSE
5914:                                 loc_dDtV = loc_dDtV + NVL(cursor_4c_LocalFPag.Dias, 0)
5915:                             ENDIF
5916:                         ENDFOR
5917:                     ENDIF
5918: 
5919:                     IF USED("cursor_4c_LocalFPag")
5920:                         USE IN cursor_4c_LocalFPag
5921:                     ENDIF
5922:                 ENDIF
5923: 
5924:                 IF loc_lOk
5925:                     SELECT cursor_4c_CabOperas
5926:                     SKIP IN cursor_4c_CabOperas
5927:                 ENDIF
5928:             ENDDO
5929: 
5930:             *-- Marca a cotacao como Pedido Gerado
5931:             IF loc_lOk
5932:                 loc_cSQL = "UPDATE SigCtTDc SET Situas = 1 WHERE Codigos = " + FormatarNumeroSQL(loc_oBO.this_nCodigos, 0)
5933:                 IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5934:                     loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - Update SigCtTDc)" + CHR(13) + CapturarErroSQL()
5935:                     loc_lOk = .F.
5936:                 ENDIF
5937:             ENDIF
5938: 
5939:             *-- "Lanca movimentacoes financeiras conforme configurado" (Tiago,
5940:             *-- 23/09/2014). fSigOpFin_Lancs eh funcao GLOBAL fora do dump -
5941:             *-- so dispara quando ha config em SigOpCdi para esta operacao;
5942:             *-- sem config, e no-op no legado tambem.
5943:             IF loc_lOk
5944:                 loc_cSQL = "SELECT TOP 1 Dopes FROM SigOpCdi WHERE Dopes = " + EscaparSQL(PADR(loc_cDop, 20))
5945:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdi") > 0 AND USED("cursor_4c_OpCdi") AND !EOF("cursor_4c_OpCdi")
5946:                     fSigOpFin_Lancs(gnConnHandle, loc_cDop)
5947:                 ENDIF
5948:                 IF USED("cursor_4c_OpCdi")
5949:                     USE IN cursor_4c_OpCdi
5950:                 ENDIF
5951:             ENDIF
5952: 
5953:             IF loc_lOk
5954:                 loc_lOk = fRecalculaS(.T., gnConnHandle)
5955:                 IF !loc_lOk
5956:                     loc_cErro = "Favor Reinicializar o Processo!!!"
5957:                 ENDIF
5958:             ENDIF
5959:         CATCH TO loc_oErro
5960:             loc_cErro = loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 6023 a 6066:
6023: 
6024:         loc_cNomeComprador = ""
6025:         IF !EMPTY(loc_oBO.this_cComprador)
6026:             IF SQLEXEC(gnConnHandle, "SELECT NComps FROM SigCdUsu WHERE Usuarios = " + ;
6027:                 EscaparSQL(loc_oBO.this_cComprador), "cursor_4c_NomeCompr") > 0 AND ;
6028:                USED("cursor_4c_NomeCompr") AND !EOF("cursor_4c_NomeCompr")
6029:                 loc_cNomeComprador = ALLTRIM(cursor_4c_NomeCompr.NComps)
6030:             ENDIF
6031:             IF USED("cursor_4c_NomeCompr")
6032:                 USE IN cursor_4c_NomeCompr
6033:             ENDIF
6034:         ENDIF
6035: 
6036:         loc_cNomeAprSols = ""
6037:         IF !EMPTY(loc_oBO.this_cAprSols)
6038:             IF SQLEXEC(gnConnHandle, "SELECT NComps FROM SigCdUsu WHERE Usuarios = " + ;
6039:                 EscaparSQL(loc_oBO.this_cAprSols), "cursor_4c_NomeAprSol") > 0 AND ;
6040:                USED("cursor_4c_NomeAprSol") AND !EOF("cursor_4c_NomeAprSol")
6041:                 loc_cNomeAprSols = ALLTRIM(cursor_4c_NomeAprSol.NComps)
6042:             ENDIF
6043:             IF USED("cursor_4c_NomeAprSol")
6044:                 USE IN cursor_4c_NomeAprSol
6045:             ENDIF
6046:         ENDIF
6047: 
6048:         loc_cNomeAprovador = ""
6049:         IF !EMPTY(loc_oBO.this_cAprovador)
6050:             IF SQLEXEC(gnConnHandle, "SELECT NComps FROM SigCdUsu WHERE Usuarios = " + ;
6051:                 EscaparSQL(loc_oBO.this_cAprovador), "cursor_4c_NomeAprov") > 0 AND ;
6052:                USED("cursor_4c_NomeAprov") AND !EOF("cursor_4c_NomeAprov")
6053:                 loc_cNomeAprovador = ALLTRIM(cursor_4c_NomeAprov.NComps)
6054:             ENDIF
6055:             IF USED("cursor_4c_NomeAprov")
6056:                 USE IN cursor_4c_NomeAprov
6057:             ENDIF
6058:         ENDIF
6059: 
6060:         MsgAviso("Impress" + CHR(227) + "o da Cota" + CHR(231) + CHR(227) + "o " + ;
6061:             ALLTRIM(STR(loc_oBO.this_nCodigos, 6)) + " (" + loc_cTipo + ", Prioridade " + loc_cPrioridade + ")" + ;
6062:             CHR(13) + "Comprador: " + loc_cNomeComprador + CHR(13) + ;
6063:             "Aprovador Solicitante: " + loc_cNomeAprSols + CHR(13) + ;
6064:             "Aprovador Final: " + loc_cNomeAprovador + CHR(13) + CHR(13) + ;
6065:             "O relat" + CHR(243) + "rio impresso (FRX) desta cota" + CHR(231) + CHR(227) + "o ainda " + ;
6066:             CHR(227) + "o foi portado para o sistema novo.", "Impress" + CHR(227) + "o")

*-- Linhas 6733 a 6752:
6733:             RETURN
6734:         ENDIF
6735: 
6736:         loc_cSQL = "SELECT Codigos FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor)
6737:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoVal")
6738: 
6739:         IF loc_nResultado > 0 AND USED("cursor_4c_GrupoVal") AND !EOF("cursor_4c_GrupoVal")
6740:             loc_oCnt.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_GrupoVal.Codigos)
6741:         ELSE
6742:             THIS.AbrirBuscaGrupoDestino()
6743:         ENDIF
6744: 
6745:         IF USED("cursor_4c_GrupoVal")
6746:             USE IN cursor_4c_GrupoVal
6747:         ENDIF
6748: 
6749:         THIS.AjustarCamposPedidos()
6750:     ENDPROC
6751: 
6752:     PROCEDURE AbrirBuscaGrupoDestino()

*-- Linhas 6817 a 6840:
6817:             RETURN
6818:         ENDIF
6819: 
6820:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE " + par_cCampo + " = " + EscaparSQL(loc_cValor)
6821:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
6822:             loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
6823:         ENDIF
6824: 
6825:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDsVal")
6826: 
6827:         IF loc_nResultado > 0 AND USED("cursor_4c_ContaDsVal") AND !EOF("cursor_4c_ContaDsVal")
6828:             loc_oCnt.txt_4c_ContaDs.Value  = ALLTRIM(cursor_4c_ContaDsVal.IClis)
6829:             loc_oCnt.txt_4c_DContaDs.Value = ALLTRIM(cursor_4c_ContaDsVal.RClis)
6830:         ELSE
6831:             THIS.AbrirBuscaContaDestino(par_cCampo)
6832:         ENDIF
6833: 
6834:         IF USED("cursor_4c_ContaDsVal")
6835:             USE IN cursor_4c_ContaDsVal
6836:         ENDIF
6837: 
6838:         THIS.AjustarCamposPedidos()
6839:     ENDPROC
6840: 

*-- Linhas 6851 a 6869:
6851: 
6852:         loc_cFiltro = ""
6853:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
6854:             loc_cFiltro = "Grupos = " + EscaparSQL(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
6855:         ENDIF
6856: 
6857:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6858:             "SigCdCli", "cursor_4c_BuscaContaDs", par_cCampo, loc_cValor, ;
6859:             "Sele" + CHR(231) + CHR(227) + "o de Conta", .F., .T., loc_cFiltro)
6860: 
6861:         IF VARTYPE(loc_oBusca) = "O"
6862:             IF loc_oBusca.this_lAchouRegistro
6863:                 loc_oCnt.txt_4c_ContaDs.Value  = ALLTRIM(cursor_4c_BuscaContaDs.IClis)
6864:                 loc_oCnt.txt_4c_DContaDs.Value = ALLTRIM(cursor_4c_BuscaContaDs.RClis)
6865:             ELSE
6866:                 loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
6867:                 loc_oBusca.mAddColuna("RClis", "", "Nome")
6868:                 loc_oBusca.Show()
6869:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaDs")

*-- Linhas 6919 a 6938:
6919:             RETURN
6920:         ENDIF
6921: 
6922:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE " + par_cCampo + " = " + EscaparSQL(loc_cValor)
6923:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaEsPedVal")
6924: 
6925:         IF loc_nResultado > 0 AND USED("cursor_4c_ContaEsPedVal") AND !EOF("cursor_4c_ContaEsPedVal")
6926:             loc_oCnt.txt_4c_ContaEs.Value  = ALLTRIM(cursor_4c_ContaEsPedVal.IClis)
6927:             loc_oCnt.txt_4c_DContaEs.Value = ALLTRIM(cursor_4c_ContaEsPedVal.RClis)
6928:         ELSE
6929:             THIS.AbrirBuscaContaEntregaPedido(par_cCampo)
6930:         ENDIF
6931: 
6932:         IF USED("cursor_4c_ContaEsPedVal")
6933:             USE IN cursor_4c_ContaEsPedVal
6934:         ENDIF
6935: 
6936:         THIS.AjustarCamposPedidos()
6937:     ENDPROC
6938: 

*-- Linhas 6987 a 7006:
6987:             RETURN
6988:         ENDIF
6989: 
6990:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cContaEs)
6991:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EntregaPedCli")
6992: 
6993:         IF loc_nResultado < 0 OR !USED("cursor_4c_EntregaPedCli") OR EOF("cursor_4c_EntregaPedCli")
6994:             MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
6995:                 "Falha na Conex" + CHR(227) + "o (cmdEntrega)")
6996:         ELSE
6997:             MsgAviso("A tela de Local de Entrega (SigCdEnd) n" + CHR(227) + "o foi portada para o " + ;
6998:                 "sistema novo." + CHR(13) + "Cadastre/ajuste os endere" + CHR(231) + "os de entrega do " + ;
6999:                 "cliente " + ALLTRIM(cursor_4c_EntregaPedCli.RClis) + " pelo cadastro de Clientes.", "Aviso")
7000:         ENDIF
7001: 
7002:         IF USED("cursor_4c_EntregaPedCli")
7003:             USE IN cursor_4c_EntregaPedCli
7004:         ENDIF
7005:     ENDPROC
7006: 

*-- Linhas 7026 a 7045:
7026:             RETURN
7027:         ENDIF
7028: 
7029:         loc_cSQL = "SELECT Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
7030:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpPedVal")
7031: 
7032:         IF loc_nResultado > 0 AND USED("cursor_4c_EmpPedVal") AND !EOF("cursor_4c_EmpPedVal")
7033:             loc_oCnt.txt_4c_Emps.Value = ALLTRIM(cursor_4c_EmpPedVal.Cemps)
7034:         ELSE
7035:             THIS.AbrirBuscaEmpresaPedido()
7036:         ENDIF
7037: 
7038:         IF USED("cursor_4c_EmpPedVal")
7039:             USE IN cursor_4c_EmpPedVal
7040:         ENDIF
7041:     ENDPROC
7042: 
7043:     PROCEDURE AbrirBuscaEmpresaPedido()
7044:         LOCAL loc_oCnt, loc_cValor, loc_oBusca
7045: 

*-- Linhas 7069 a 7131:
7069:         ENDIF
7070:     ENDPROC
7071: 
7072:     *--------------------------------------------------------------------------
7073:     * Operacao de lancamento (getDopes -> operacoes de subnivel do Dopes
7074:     * filtrado em Page1, cursor_4c_Subniveis - equivalente ao fwBuscaInt do
7075:     * legado sobre crSubniveis, aqui implementado como FormBuscaAuxiliar sobre
7076:     * uma SUBCONSULTA SQL Server derivada (nao um cursor VFP local - o
7077:     * contrato de FormBuscaAuxiliar exige "SELECT * FROM <tabela>", e uma
7078:     * expressao "(SELECT ... ) AS X" e uma tabela derivada valida no SQL
7079:     * Server, preservando o padrao canonico do projeto).
7080:     *--------------------------------------------------------------------------
7081:     PROCEDURE TeclaOperacaoLancamento(par_nKeyCode, par_nShiftAltCtrl)
7082:         IF par_nKeyCode = 115
7083:             THIS.AbrirBuscaOperacaoLancamento()
7084:         ENDIF
7085:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
7086:             THIS.ValidarOperacaoLancamento()
7087:         ENDIF
7088:     ENDPROC
7089: 
7090:     PROTECTED PROCEDURE MontarConsultaSubniveis()
7091:         RETURN ;
7092:             "(SELECT a.Dopes, a.GruOrigs, a.GruDests, a.ConDests, a.Opers, a.CMoes, a.NFiscals, " + ;
7093:             "a.Series, a.Especies, a.TipoNfs, a.MarcaSubns, a.Cfos, a.Casas, a.GrVends, b.ChkLimOps " + ;
7094:             "FROM SigCdOpe a INNER JOIN SigOpCdd b ON a.Dopes = b.Dopes " + ;
7095:             "WHERE a.Nivels = " + EscaparSQL(PADR(THIS.this_cDopes, 20)) + " " + ;
7096:             "UNION ALL " + ;
7097:             "SELECT b.CDopes AS Dopes, c.GruOrigs, c.GruDests, c.ConDests, c.Opers, c.CMoes, c.NFiscals, " + ;
7098:             "c.Series, c.Especies, c.TipoNfs, c.MarcaSubns, c.Cfos, c.Casas, c.GrVends, d.ChkLimOps " + ;
7099:             "FROM SigOpCsn b INNER JOIN SigCdOpe c ON b.CDopes = c.Dopes " + ;
7100:             "INNER JOIN SigOpCdd d ON b.CDopes = d.Dopes " + ;
7101:             "WHERE b.CNivels = " + EscaparSQL(PADR(THIS.this_cDopes, 20)) + ") AS cursor_4c_SubDerivada"
7102:     ENDPROC
7103: 
7104:     PROCEDURE ValidarOperacaoLancamento()
7105:         LOCAL loc_oCnt, loc_cValor, loc_cSQL, loc_nResultado
7106: 
7107:         loc_oCnt   = THIS.pgf_4c_Paginas.Page4.cnt_4c_Operacao
7108:         loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Dopes.Value)
7109: 
7110:         IF EMPTY(loc_cValor)
7111:             RETURN
7112:         ENDIF
7113: 
7114:         loc_cSQL = "SELECT * FROM " + THIS.MontarConsultaSubniveis() + " WHERE Dopes = " + ;
7115:             EscaparSQL(PADR(loc_cValor, 20))
7116:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeLancVal")
7117: 
7118:         IF loc_nResultado > 0 AND USED("cursor_4c_OpeLancVal") AND !EOF("cursor_4c_OpeLancVal")
7119:             loc_oCnt.txt_4c_Dopes.Value  = ALLTRIM(cursor_4c_OpeLancVal.Dopes)
7120:             loc_oCnt.txt_4c_CMoes.Value  = ALLTRIM(NVL(cursor_4c_OpeLancVal.CMoes, ""))
7121:             loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(NVL(cursor_4c_OpeLancVal.GruDests, ""))
7122:             loc_oCnt.txt_4c_ContaDs.Value = ""
7123:             THIS.ValidarContaDestino("IClis")
7124:         ELSE
7125:             THIS.AbrirBuscaOperacaoLancamento()
7126:         ENDIF
7127: 
7128:         IF USED("cursor_4c_OpeLancVal")
7129:             USE IN cursor_4c_OpeLancVal
7130:         ENDIF
7131:     ENDPROC

*-- Linhas 7188 a 7207:
7188:             RETURN
7189:         ENDIF
7190: 
7191:         loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor)
7192:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
7193: 
7194:         IF loc_nResultado > 0 AND USED("cursor_4c_MoeVal") AND !EOF("cursor_4c_MoeVal")
7195:             loc_oCnt.txt_4c_CMoes.Value = ALLTRIM(cursor_4c_MoeVal.CMoes)
7196:         ELSE
7197:             THIS.AbrirBuscaMoedaPedido()
7198:         ENDIF
7199: 
7200:         IF USED("cursor_4c_MoeVal")
7201:             USE IN cursor_4c_MoeVal
7202:         ENDIF
7203:     ENDPROC
7204: 
7205:     PROCEDURE AbrirBuscaMoedaPedido()
7206:         LOCAL loc_oCnt, loc_cValor, loc_oBusca
7207: 

*-- Linhas 7286 a 7304:
7286:         IF USED("cursor_4c_CabOperas") AND !EOF("cursor_4c_CabOperas") AND USED("cursor_4c_ItnOperas")
7287:             loc_nNumes = cursor_4c_CabOperas.Numes
7288: 
7289:             SELECT cursor_4c_ItnOperas
7290:             SET ORDER TO Ordem
7291:             SET FILTER TO Numes = loc_nNumes
7292:             GO TOP IN cursor_4c_ItnOperas
7293: 
7294:             loc_oPgf.Page2.grd_4c_ItnOperas.Refresh()
7295:             loc_oPgf.Page2.grd_4c_ItnOperas.Column1.SetFocus()
7296:         ENDIF
7297:     ENDPROC
7298: 
7299:     *--------------------------------------------------------------------------
7300:     * ConfigurarGridCabOperas - grdCabOperas (cabecalho das operacoes de
7301:     * pedido, 1 linha por fornecedor -> cursor_4c_CabOperas).
7302:     *--------------------------------------------------------------------------
7303:     PROTECTED PROCEDURE ConfigurarGridCabOperas(par_oPagina)
7304:         LOCAL loc_oGrid

*-- Linhas 7318 a 7353:
7318:             .HeaderHeight  = 16
7319:             .RowHeight     = 15
7320:             .ScrollBars    = 3
7321:             .DeleteMark    = .F.
7322:             .RecordMark    = .F.
7323:             .ReadOnly      = .T.
7324:             .GridLineColor = RGB(128, 128, 128)
7325:             .Visible       = .T.
7326:         ENDWITH
7327: 
7328:         loc_oGrid.ColumnCount = 9
7329:         loc_oGrid.RecordSource          = "cursor_4c_CabOperas"
7330:         loc_oGrid.Column1.ControlSource = "cursor_4c_CabOperas.Numes"
7331:         loc_oGrid.Column2.ControlSource = "cursor_4c_CabOperas.IFors"
7332:         loc_oGrid.Column3.ControlSource = "cursor_4c_CabOperas.Fornecs"
7333:         loc_oGrid.Column4.ControlSource = "cursor_4c_CabOperas.FPags"
7334:         loc_oGrid.Column5.ControlSource = "cursor_4c_CabOperas.DtEnts"
7335:         loc_oGrid.Column6.ControlSource = "cursor_4c_CabOperas.Qtds"
7336:         loc_oGrid.Column7.ControlSource = "cursor_4c_CabOperas.Valors"
7337:         loc_oGrid.Column8.ControlSource = "cursor_4c_CabOperas.Fretes"
7338:         loc_oGrid.Column9.ControlSource = "cursor_4c_CabOperas.VlFretes"
7339: 
7340:         WITH loc_oGrid.Column1
7341:             .Alignment         = 3
7342:             .Header1.Caption   = "Ord."
7343:             .Header1.Alignment = 2
7344:             .Header1.FontSize  = 8
7345:         ENDWITH
7346: 
7347:         WITH loc_oGrid.Column2
7348:             .Header1.Caption   = "C" + CHR(243) + "digo"
7349:             .Header1.Alignment = 2
7350:             .Header1.FontSize  = 8
7351:         ENDWITH
7352: 
7353:         WITH loc_oGrid.Column3

*-- Linhas 7418 a 7436:
7418: 
7419:         IF USED("cursor_4c_CabOperas") AND !EOF("cursor_4c_CabOperas") AND USED("cursor_4c_ItnOperas")
7420:             loc_nNumes = cursor_4c_CabOperas.Numes
7421:             SELECT cursor_4c_ItnOperas
7422:             SET ORDER TO Ordem
7423:             SET FILTER TO Numes = loc_nNumes
7424:             GO TOP IN cursor_4c_ItnOperas
7425:         ENDIF
7426:     ENDPROC
7427: 
7428:     *--------------------------------------------------------------------------
7429:     * ConfigurarGridItnOperas - grdItnOperas (itens de UMA operacao de pedido,
7430:     * filtrados pelo Numes corrente de grdCabOperas -> cursor_4c_ItnOperas).
7431:     *--------------------------------------------------------------------------
7432:     PROTECTED PROCEDURE ConfigurarGridItnOperas(par_oPagina)
7433:         LOCAL loc_oGrid
7434: 
7435:         par_oPagina.AddObject("grd_4c_ItnOperas", "Grid")
7436:         loc_oGrid = par_oPagina.grd_4c_ItnOperas

*-- Linhas 7447 a 7482:
7447:             .HeaderHeight  = 16
7448:             .RowHeight     = 15
7449:             .ScrollBars    = 3
7450:             .DeleteMark    = .F.
7451:             .RecordMark    = .F.
7452:             .ReadOnly      = .T.
7453:             .GridLineColor = RGB(128, 128, 128)
7454:             .Visible       = .T.
7455:         ENDWITH
7456: 
7457:         loc_oGrid.ColumnCount = 9
7458:         loc_oGrid.RecordSource          = "cursor_4c_ItnOperas"
7459:         loc_oGrid.Column1.ControlSource = "cursor_4c_ItnOperas.CItens"
7460:         loc_oGrid.Column2.ControlSource = "cursor_4c_ItnOperas.CPros"
7461:         loc_oGrid.Column3.ControlSource = "cursor_4c_ItnOperas.DPros"
7462:         loc_oGrid.Column4.ControlSource = "cursor_4c_ItnOperas.CUnis"
7463:         loc_oGrid.Column5.ControlSource = "cursor_4c_ItnOperas.Qtds"
7464:         loc_oGrid.Column6.ControlSource = "cursor_4c_ItnOperas.Units"
7465:         loc_oGrid.Column7.ControlSource = "cursor_4c_ItnOperas.Valors"
7466:         loc_oGrid.Column8.ControlSource = "cursor_4c_ItnOperas.CodCors"
7467:         loc_oGrid.Column9.ControlSource = "cursor_4c_ItnOperas.CodTams"
7468: 
7469:         WITH loc_oGrid.Column1
7470:             .Alignment         = 3
7471:             .Header1.Caption   = "Ord."
7472:             .Header1.Alignment = 2
7473:             .Header1.FontSize  = 8
7474:         ENDWITH
7475: 
7476:         WITH loc_oGrid.Column2
7477:             .Header1.Caption   = "C" + CHR(243) + "digo"
7478:             .Header1.Alignment = 2
7479:             .Header1.FontSize  = 8
7480:         ENDWITH
7481: 
7482:         WITH loc_oGrid.Column3

*-- Linhas 7622 a 7676:
7622:     * aparece (a coluna continua desenhando o Text1 dela) - e Column.ReadOnly
7623:     * tem de vir DEPOIS de Grid.ReadOnly, que propaga para as colunas.
7624:     *
7625:     * Column.Width por ULTIMO: mexer em RecordSource/ControlSource faz o VFP
7626:     * recalcular todas as larguras para o default.
7627:     *--------------------------------------------------------------------------
7628:     PROTECTED PROCEDURE ConfigurarGridOperacoes(par_oPagina)
7629:         LOCAL loc_oGrid
7630: 
7631:         par_oPagina.AddObject("grd_4c_Operacoes", "Grid")
7632:         loc_oGrid = par_oPagina.grd_4c_Operacoes
7633: 
7634:         loc_oGrid.ColumnCount = 6
7635: 
7636:         WITH loc_oGrid
7637:             .Top               = 25
7638:             .Left              = 250
7639:             .Width             = 407
7640:             .Height            = 244
7641:             .FontName          = "Tahoma"
7642:             .FontSize          = 8
7643:             .RowHeight         = 16
7644:             .ScrollBars        = 2
7645:             .DeleteMark        = .F.
7646:             .RecordMark        = .F.
7647:             .AllowHeaderSizing = .F.
7648:             .AllowRowSizing    = .F.
7649:             .ReadOnly          = .F.
7650:             .GridLineColor     = RGB(128, 128, 128)
7651:             .Visible           = .T.
7652:         ENDWITH
7653: 
7654:         loc_oGrid.ColumnCount = 6
7655:         loc_oGrid.RecordSource          = "cursor_4c_Movimentacao"
7656:         loc_oGrid.Column1.ControlSource = "cursor_4c_Movimentacao.Marcas"
7657:         loc_oGrid.Column2.ControlSource = "cursor_4c_Movimentacao.Datas"
7658:         loc_oGrid.Column3.ControlSource = "cursor_4c_Movimentacao.Emps"
7659:         loc_oGrid.Column4.ControlSource = "cursor_4c_Movimentacao.Dopes"
7660:         loc_oGrid.Column5.ControlSource = "cursor_4c_Movimentacao.Numes"
7661:         loc_oGrid.Column6.ControlSource = "cursor_4c_Movimentacao.Itens"
7662: 
7663:         IF !PEMSTATUS(loc_oGrid.Column1, "chk_4c_Marcas", 5)
7664:             loc_oGrid.Column1.AddObject("chk_4c_Marcas", "CheckBox")
7665:         ENDIF
7666: 
7667:         WITH loc_oGrid.Column1.chk_4c_Marcas
7668:             .Top       = 9
7669:             .Left      = 2
7670:             .Height    = 17
7671:             .Width     = 22
7672:             .FontName  = "Arial"
7673:             .FontSize  = 8
7674:             .Alignment = 0
7675:             .Caption   = ""
7676:             .BackStyle = 0

*-- Linhas 7788 a 7820:
7788:             .FontSize      = 8
7789:             .RowHeight     = 16
7790:             .ScrollBars    = 2
7791:             .DeleteMark    = .F.
7792:             .RecordMark    = .F.
7793:             .ReadOnly      = .T.
7794:             .GridLineColor = RGB(128, 128, 128)
7795:             .Visible       = .T.
7796:         ENDWITH
7797: 
7798:         loc_oGrid.ColumnCount = 6
7799:         loc_oGrid.RecordSource          = "cursor_4c_CotasPendentes"
7800:         loc_oGrid.Column1.ControlSource = "cursor_4c_CotasPendentes.Codigos"
7801:         loc_oGrid.Column2.ControlSource = "cursor_4c_CotasPendentes.DtSolics"
7802:         loc_oGrid.Column3.ControlSource = "cursor_4c_CotasPendentes.Solicitas"
7803:         loc_oGrid.Column4.ControlSource = "cursor_4c_CotasPendentes.Deptos"
7804:         loc_oGrid.Column5.ControlSource = "cursor_4c_CotasPendentes.Prioris"
7805:         loc_oGrid.Column6.ControlSource = "cursor_4c_CotasPendentes.DtCotas"
7806: 
7807:         WITH loc_oGrid.Column1
7808:             .FontSize          = 8
7809:             .FontBold          = .T.
7810:             .Alignment         = 3
7811:             .Movable           = .F.
7812:             .Resizable         = .F.
7813:             .Sparse            = .F.
7814:             .Header1.Caption   = "C" + CHR(243) + "digo"
7815:             .Header1.Alignment = 2
7816:             .Header1.FontSize  = 8
7817:             .Text1.FontBold    = .T.
7818:             .Text1.FontSize    = 8
7819:             .Text1.Alignment   = 3
7820:             .Text1.BorderStyle = 0

*-- Linhas 7942 a 8068:
7942: 
7943:                 IF VARTYPE(loc_oProgresso) = "O"
7944:                     loc_oProgresso.Show()
7945:                     loc_oProgresso.Update("Montando Telas", .T.)
7946:                 ENDIF
7947: 
7948:                 ZAP IN cursor_4c_Movimentacao
7949:                 ZAP IN cursor_4c_CotasPendentes
7950: 
7951:                 loc_cDtI = FormatarDataSQL(THIS.this_dDtPerI)
7952:                 loc_cDtF = FormatarDataSQL(DTOT(THIS.this_dDtPerF) + 86399)
7953: 
7954:                 *-- Filtro de operacao/empresa transcrito do legado: com a
7955:                 *-- empresa informada ele troca Dopes por uma faixa de
7956:                 *-- EmpDopNums (Emps + Dopes + Numes de 0 a 999999).
7957:                 IF EMPTY(THIS.this_cEmps)
7958:                     loc_cFiltro = "a.Dopes = " + EscaparSQL(PADR(THIS.this_cDopes, 20))
7959:                 ELSE
7960:                     loc_cEd1 = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(0, 6)
7961:                     loc_cEd2 = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(999999, 6)
7962:                     loc_cFiltro = "a.EmpDopNums BETWEEN " + EscaparSQL(loc_cEd1) + ;
7963:                                   " AND " + EscaparSQL(loc_cEd2)
7964:                 ENDIF
7965: 
7966:                 IF !EMPTY(THIS.this_cJobs)
7967:                     loc_cFiltro = loc_cFiltro + " AND a.Jobs = " + EscaparSQL(THIS.this_cJobs)
7968:                 ENDIF
7969: 
7970:                 IF VARTYPE(loc_oProgresso) = "O"
7971:                     loc_oProgresso.Update("Selecionando Opera" + CHR(231) + CHR(245) + ;
7972:                         "es Pendentes", .T.)
7973:                 ENDIF
7974: 
7975:                 loc_cSQL = "SELECT a.Datas, a.Emps, a.Dopes, a.Numes, b.CItens, " + ;
7976:                            "(b.Qtds - b.QtBaixas) AS Qtds, " + ;
7977:                            "a.ChkBxParcs, a.ChkPagos, a.ChkSubn, a.LCancelas, a.Nops, " + ;
7978:                            "a.ProcBals, a.ProcDBal, " + ;
7979:                            "d.Destinos, d.EstDests, d.EstOrigs, d.Origems, d.Produc, a.Jobs " + ;
7980:                            "FROM SigMvCab a, SigMvItn b, SigCdPro c, SigCdOpe d " + ;
7981:                            "WHERE a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + " AND " + ;
7982:                            "a.ChkSubn = 0 AND " + loc_cFiltro + " AND " + ;
7983:                            "a.EmpDopNums = b.EmpDopNums AND " + ;
7984:                            "(b.Qtds - b.QtBaixas) > 0 AND " + ;
7985:                            "b.CPros = c.CPros AND " + ;
7986:                            "a.Dopes = d.Dopes " + ;
7987:                            "ORDER BY a.Datas, a.Emps, a.Dopes, a.Numes, b.CItens"
7988: 
7989:                 IF USED("cursor_4c_MovTemp")
7990:                     USE IN cursor_4c_MovTemp
7991:                 ENDIF
7992: 
7993:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MovTemp")
7994: 
7995:                 IF loc_nResultado < 1
7996:                     MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
7997:                         "Falha na Conex" + CHR(227) + "o (Movimenta" + CHR(231) + ;
7998:                         CHR(245) + "es)")
7999:                     loc_lProsseguir = .F.
8000:                 ENDIF
8001:             ENDIF
8002: 
8003:             IF loc_lProsseguir
8004:                 IF VARTYPE(loc_oProgresso) = "O"
8005:                     loc_oProgresso.Update("Processando Dados Das Opera" + CHR(231) + ;
8006:                         CHR(245) + "es Pendentes", .T.)
8007:                 ENDIF
8008: 
8009:                 *-- Elimina as movimentacoes ja utilizadas em cotacoes
8010:                 *-- anteriores: o saldo cotado (SigCtTCt) desconta a quantidade
8011:                 *-- em aberto e o que zerar sai da lista.
8012:                 SELECT cursor_4c_MovTemp
8013:                 SCAN
8014:                     loc_nSaldo = NVL(cursor_4c_MovTemp.Qtds, 0)
8015:                     loc_cEdn   = cursor_4c_MovTemp.Emps + cursor_4c_MovTemp.Dopes + ;
8016:                                  STR(cursor_4c_MovTemp.Numes, 6)
8017: 
8018:                     loc_cSQL = "SELECT a.EmpDopNums, a.CItens, a.Qtds " + ;
8019:                                "FROM SigCtTCt a " + ;
8020:                                "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + " AND " + ;
8021:                                "a.CItens = " + ;
8022:                                FormatarNumeroSQL(cursor_4c_MovTemp.CItens, 0) + " " + ;
8023:                                "ORDER BY a.EmpDopNums, a.CItens, a.Qtds"
8024: 
8025:                     IF USED("cursor_4c_CotCtTemp")
8026:                         USE IN cursor_4c_CotCtTemp
8027:                     ENDIF
8028: 
8029:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotCtTemp") > 0
8030:                         SELECT cursor_4c_CotCtTemp
8031:                         GO TOP IN cursor_4c_CotCtTemp
8032:                         IF !EOF("cursor_4c_CotCtTemp")
8033:                             loc_nSaldo = NVL(cursor_4c_MovTemp.Qtds, 0) - ;
8034:                                          NVL(cursor_4c_CotCtTemp.Qtds, 0)
8035:                         ENDIF
8036:                         USE IN cursor_4c_CotCtTemp
8037:                     ENDIF
8038: 
8039:                     SELECT cursor_4c_MovTemp
8040:                     IF !(loc_nSaldo > 0)
8041:                         DELETE IN cursor_4c_MovTemp
8042:                     ENDIF
8043:                 ENDSCAN
8044: 
8045:                 *-- Agrupa por Empresa + Operacao + Numero, somando os itens
8046:                 SELECT cursor_4c_MovTemp
8047:                 SCAN
8048:                     loc_dData = ConverterParaData(NVL(cursor_4c_MovTemp.Datas, {}))
8049:                     loc_cEdn  = cursor_4c_MovTemp.Emps + cursor_4c_MovTemp.Dopes + ;
8050:                                 STR(cursor_4c_MovTemp.Numes, 6)
8051: 
8052:                     IF !SEEK(DTOS(loc_dData) + loc_cEdn, "cursor_4c_Movimentacao", "Ordem")
8053:                         INSERT INTO cursor_4c_Movimentacao ;
8054:                             (Emps, Dopes, Numes, Datas, EmpDopNums, Nops, ChkSubn, ;
8055:                              LCancelas, ChkBxParcs, ChkPagos, ProcBals, ProcDBal, ;
8056:                              Destinos, EstDests, EstOrigs, Origems, Produc, Jobs) ;
8057:                             VALUES ;
8058:                             (cursor_4c_MovTemp.Emps, cursor_4c_MovTemp.Dopes, ;
8059:                              cursor_4c_MovTemp.Numes, loc_dData, loc_cEdn, ;
8060:                              NVL(cursor_4c_MovTemp.Nops, 0), ;
8061:                              ConverterParaLogico(cursor_4c_MovTemp.ChkSubn), ;
8062:                              ConverterParaLogico(cursor_4c_MovTemp.LCancelas), ;
8063:                              ConverterParaLogico(cursor_4c_MovTemp.ChkBxParcs), ;
8064:                              ConverterParaLogico(cursor_4c_MovTemp.ChkPagos), ;
8065:                              ConverterParaLogico(cursor_4c_MovTemp.ProcBals), ;
8066:                              ConverterParaLogico(cursor_4c_MovTemp.ProcDBal), ;
8067:                              NVL(cursor_4c_MovTemp.Destinos, 0), ;
8068:                              NVL(cursor_4c_MovTemp.EstDests, 0), ;

*-- Linhas 8075 a 8191:
8075:                     REPLACE Itens WITH Itens + NVL(cursor_4c_MovTemp.Qtds, 0) ;
8076:                         IN cursor_4c_Movimentacao
8077: 
8078:                     SELECT cursor_4c_MovTemp
8079:                 ENDSCAN
8080: 
8081:                 IF USED("cursor_4c_MovTemp")
8082:                     USE IN cursor_4c_MovTemp
8083:                 ENDIF
8084: 
8085:                 SELECT cursor_4c_Movimentacao
8086:                 GO TOP IN cursor_4c_Movimentacao
8087: 
8088:                 THIS.AplicarCoresGridOperacoes()
8089: 
8090:                 IF VARTYPE(loc_oProgresso) = "O"
8091:                     loc_oProgresso.Update("Carregando as Cota" + CHR(231) + CHR(245) + ;
8092:                         "es Pendentes", .T.)
8093:                 ENDIF
8094: 
8095:                 *-- Cotacoes ja realizadas: as que estao em aberto (Situas = 0)
8096:                 *-- mais as que geraram pedido dentro do periodo filtrado
8097:                 loc_cSQL = "SELECT a.Situas, a.Codigos, a.DtSolics, a.Solicitas, " + ;
8098:                            "a.Deptos, a.Prioris, a.DtCotas, a.DtAprovs, a.Aprovador, " + ;
8099:                            "a.ContaEs, a.LocalEnts, a.Justificas, a.Copias " + ;
8100:                            "FROM SigCtTDc a " + ;
8101:                            "WHERE a.Situas = 0 OR " + ;
8102:                            "(NOT a.Situas = 0 AND a.DtCotas BETWEEN " + ;
8103:                            loc_cDtI + " AND " + loc_cDtF + ") " + ;
8104:                            "ORDER BY a.Codigos"
8105: 
8106:                 IF USED("cursor_4c_CotDcTemp")
8107:                     USE IN cursor_4c_CotDcTemp
8108:                 ENDIF
8109: 
8110:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotDcTemp")
8111: 
8112:                 IF loc_nResultado < 1
8113:                     MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
8114:                         "Falha na Conex" + CHR(227) + "o (Cota" + CHR(231) + CHR(245) + "es)")
8115:                     loc_lProsseguir = .F.
8116:                 ENDIF
8117:             ENDIF
8118: 
8119:             IF loc_lProsseguir
8120:                 SELECT cursor_4c_CotDcTemp
8121:                 SCAN
8122:                     IF NVL(cursor_4c_CotDcTemp.Situas, 0) <> 0
8123:                         loc_cPrioridade = "Ped.Gerado"
8124:                     ELSE
8125:                         DO CASE
8126:                             CASE NVL(cursor_4c_CotDcTemp.Prioris, 0) = 3
8127:                                 loc_cPrioridade = "Alta"
8128:                             CASE NVL(cursor_4c_CotDcTemp.Prioris, 0) = 2
8129:                                 loc_cPrioridade = "M" + CHR(233) + "dia"
8130:                             OTHERWISE
8131:                                 loc_cPrioridade = "Normal"
8132:                         ENDCASE
8133:                     ENDIF
8134: 
8135:                     INSERT INTO cursor_4c_CotasPendentes ;
8136:                         (Situas, Codigos, DtSolics, Solicitas, Deptos, Prioris, ;
8137:                          DtCotas, DtAprovs, Aprovador, ContaEs, LocalEnts, ;
8138:                          Justificas, Copias) ;
8139:                         VALUES ;
8140:                         (NVL(cursor_4c_CotDcTemp.Situas, 0), ;
8141:                          NVL(cursor_4c_CotDcTemp.Codigos, 0), ;
8142:                          ConverterParaData(NVL(cursor_4c_CotDcTemp.DtSolics, {})), ;
8143:                          NVL(cursor_4c_CotDcTemp.Solicitas, ""), ;
8144:                          NVL(cursor_4c_CotDcTemp.Deptos, ""), ;
8145:                          loc_cPrioridade, ;
8146:                          ConverterParaData(NVL(cursor_4c_CotDcTemp.DtCotas, {})), ;
8147:                          ConverterParaData(NVL(cursor_4c_CotDcTemp.DtAprovs, {})), ;
8148:                          NVL(cursor_4c_CotDcTemp.Aprovador, ""), ;
8149:                          NVL(cursor_4c_CotDcTemp.ContaEs, ""), ;
8150:                          NVL(cursor_4c_CotDcTemp.LocalEnts, 0), ;
8151:                          NVL(cursor_4c_CotDcTemp.Justificas, ""), ;
8152:                          NVL(cursor_4c_CotDcTemp.Copias, 0))
8153: 
8154:                     SELECT cursor_4c_CotDcTemp
8155:                 ENDSCAN
8156: 
8157:                 IF USED("cursor_4c_CotDcTemp")
8158:                     USE IN cursor_4c_CotDcTemp
8159:                 ENDIF
8160: 
8161:                 IF VARTYPE(loc_oProgresso) = "O"
8162:                     loc_oProgresso.Complete(.T.)
8163:                     loc_oProgresso = .NULL.
8164:                 ENDIF
8165: 
8166:                 IF RECCOUNT("cursor_4c_Movimentacao") < 1 AND ;
8167:                    RECCOUNT("cursor_4c_CotasPendentes") < 1
8168:                     MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Processar!!!", ;
8169:                         "Aten" + CHR(231) + CHR(227) + "o!!!")
8170:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DtPerI.SetFocus()
8171:                 ELSE
8172:                     *-- Popular o cursor NAO repinta a grade: GO TOP + Refresh
8173:                     SELECT cursor_4c_CotasPendentes
8174:                     GO TOP IN cursor_4c_CotasPendentes
8175: 
8176:                     SELECT cursor_4c_Movimentacao
8177:                     GO TOP IN cursor_4c_Movimentacao
8178: 
8179:                     loc_oPag.obj_4c_CmdProblemas.Visible = THIS.PossuiAcessoCotacaoLivre()
8180: 
8181:                     loc_oPag.grd_4c_Operacoes.Refresh()
8182:                     loc_oPag.grd_4c_CotaPends.Refresh()
8183: 
8184:                     THIS.AjustarBotoesPorModo()
8185: 
8186:                     loc_lSucesso = .T.
8187:                 ENDIF
8188:             ENDIF
8189:         CATCH TO loc_oErro
8190:             MsgErro(loc_oErro.Message + CHR(13) + ;
8191:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 8393 a 8446:
8393:         IF cursor_4c_Movimentacao.Marcas AND !EMPTY(cursor_4c_Movimentacao.Jobs)
8394:             loc_cJob = cursor_4c_Movimentacao.Jobs
8395: 
8396:             SELECT EmpDopNums ;
8397:               FROM cursor_4c_Movimentacao ;
8398:              WHERE Marcas AND Jobs <> m.loc_cJob ;
8399:               INTO CURSOR cursor_4c_MarcaJob
8400: 
8401:             IF !EOF("cursor_4c_MarcaJob")
8402:                 MsgAviso("N" + CHR(227) + "o " + CHR(233) + " permitido marcar " + ;
8403:                     "movimenta" + CHR(231) + CHR(227) + "o de jobs diferentes.", "Aviso")
8404:                 REPLACE Marcas WITH !Marcas IN cursor_4c_Movimentacao
8405:                 loc_oGrid.Refresh()
8406:             ENDIF
8407: 
8408:             IF USED("cursor_4c_MarcaJob")
8409:                 USE IN cursor_4c_MarcaJob
8410:             ENDIF
8411: 
8412:             SELECT cursor_4c_Movimentacao
8413:         ENDIF
8414:     ENDPROC
8415: 
8416:     *--------------------------------------------------------------------------
8417:     * BtnMarcarTodasClick / BtnDesmarcarTodasClick - Marcam ou desmarcam todas
8418:     * as movimentacoes (cmdMarcaDesmarca.Click do legado:
8419:     * Update crOperacoes Set Marcas = (This.Value = 1)).
8420:     *--------------------------------------------------------------------------
8421:     PROCEDURE BtnMarcarTodasClick()
8422:         IF USED("cursor_4c_Movimentacao")
8423:             UPDATE cursor_4c_Movimentacao SET Marcas = .T.
8424:             GO TOP IN cursor_4c_Movimentacao
8425:             THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Refresh()
8426:         ENDIF
8427:     ENDPROC
8428: 
8429:     PROCEDURE BtnDesmarcarTodasClick()
8430:         IF USED("cursor_4c_Movimentacao")
8431:             UPDATE cursor_4c_Movimentacao SET Marcas = .F.
8432:             GO TOP IN cursor_4c_Movimentacao
8433:             THIS.pgf_4c_Paginas.Page2.grd_4c_Operacoes.Refresh()
8434:         ENDIF
8435:     ENDPROC
8436: 
8437:     *--------------------------------------------------------------------------
8438:     * BtnRetornarFiltrosClick - cmdBotoes.btnSair.Click da pagina Dados:
8439:     * volta para a pagina de Filtros com o foco na data inicial.
8440:     *--------------------------------------------------------------------------
8441:     PROCEDURE BtnRetornarFiltrosClick()
8442:         THIS.this_cModoAtual = "FILTROS"
8443:         THIS.AlternarPagina(1)
8444:         THIS.pgf_4c_Paginas.Page1.txt_4c_DtPerI.SetFocus()
8445:     ENDPROC
8446: 

*-- Linhas 8522 a 8599:
8522:             ENDIF
8523: 
8524:             IF loc_lProsseguir
8525:                 SELECT EmpDopNums, Jobs ;
8526:                   FROM cursor_4c_Movimentacao ;
8527:                  WHERE Marcas ;
8528:                   INTO CURSOR cursor_4c_CotarProds
8529: 
8530:                 GO TOP IN cursor_4c_CotarProds
8531: 
8532:                 IF EOF("cursor_4c_CotarProds")
8533:                     MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Foi Selecionada " + ;
8534:                         "Para Gerar Cota" + CHR(231) + CHR(245) + "es!!!", ;
8535:                         "Aten" + CHR(231) + CHR(227) + "o!!!")
8536:                     loc_lProsseguir = .F.
8537:                 ELSE
8538:                     THIS.this_cJobs = ALLTRIM(cursor_4c_CotarProds.Jobs)
8539:                 ENDIF
8540: 
8541:                 SELECT cursor_4c_Movimentacao
8542:             ENDIF
8543:         ENDIF
8544: 
8545:         IF loc_lProsseguir
8546:             THIS.this_nCodigoSelecionado = 0
8547:             THIS.this_oBusinessObject.NovoRegistro()
8548:             THIS.PreencherPadroesNovaCotacao(par_lDaGrade)
8549:             THIS.PopularCamposCotacaoNoFormulario()
8550:             THIS.ZerarCursoresCotacao()
8551: 
8552:             THIS.this_cModoAtual = "COTACOES"
8553:             THIS.AlternarPagina(3)
8554:             THIS.AjustarCamposCotacao()
8555: 
8556:             loc_lSucesso = .T.
8557:         ENDIF
8558: 
8559:         RETURN loc_lSucesso
8560:     ENDPROC
8561: 
8562:     *--------------------------------------------------------------------------
8563:     * PreencherPadroesNovaCotacao - Equivalente ao INSERT INTO crSigCtTDc do
8564:     * PROCEDURE geracotacao legado: Solicitas/Comprador = usuario logado,
8565:     * DtSolics = data da movimentacao (ou hoje, se sem origem), DtCotas =
8566:     * hoje, DtValids = hoje + NDdVals (SigOpCdc.Dopes), Prioris = 1 (Normal).
8567:     *--------------------------------------------------------------------------
8568:     PROTECTED PROCEDURE PreencherPadroesNovaCotacao(par_lDaGrade)
8569:         LOCAL loc_oBO, loc_nDias, loc_dDtSolic
8570: 
8571:         loc_oBO = THIS.this_oBusinessObject
8572:         IF VARTYPE(loc_oBO) != "O"
8573:             RETURN
8574:         ENDIF
8575: 
8576:         loc_dDtSolic = DATE()
8577:         IF par_lDaGrade AND USED("cursor_4c_Movimentacao") AND !EOF("cursor_4c_Movimentacao")
8578:             loc_dDtSolic = ConverterParaData(cursor_4c_Movimentacao.Datas)
8579:         ENDIF
8580: 
8581:         loc_nDias = 0
8582:         IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) AND !EMPTY(THIS.this_cDopes)
8583:             IF SQLEXEC(gnConnHandle, "SELECT NDdVals FROM SigOpCdc WHERE Dopes = " + ;
8584:                 EscaparSQL(PADR(THIS.this_cDopes, 20)), "cursor_4c_NDdValsTmp") > 0 AND ;
8585:                USED("cursor_4c_NDdValsTmp") AND !EOF("cursor_4c_NDdValsTmp")
8586:                 loc_nDias = NVL(cursor_4c_NDdValsTmp.NDdVals, 0)
8587:             ENDIF
8588:             IF USED("cursor_4c_NDdValsTmp")
8589:                 USE IN cursor_4c_NDdValsTmp
8590:             ENDIF
8591:         ENDIF
8592: 
8593:         loc_oBO.this_cSolicitas  = gc_4c_UsuarioLogado
8594:         loc_oBO.this_cAprSols    = gc_4c_UsuarioLogado
8595:         loc_oBO.this_cComprador  = gc_4c_UsuarioLogado
8596:         loc_oBO.this_dDtSolics   = loc_dDtSolic
8597:         loc_oBO.this_dDtCotas    = DATE()
8598:         loc_oBO.this_dDtValids   = DATE() + loc_nDias
8599:         loc_oBO.this_nPrioris    = 1

*-- Linhas 8617 a 8652:
8617:     *--------------------------------------------------------------------------
8618:     * ZerarCursoresCotacao - Cotacao NOVA: ZAP dos cursores das grades e uma
8619:     * linha de fornecedor por letra (A..F, Fretes = "Emitente" por padrao) +
8620:     * uma linha de produto em branco - transcrito do INSERT INTO crSigCtTFn/
8621:     * crSigCtTCt do PROCEDURE geracotacao legado (Reccount = 0 -> ramo Else).
8622:     *--------------------------------------------------------------------------
8623:     PROTECTED PROCEDURE ZerarCursoresCotacao()
8624:         LOCAL loc_nI
8625: 
8626:         IF !USED("cursor_4c_Produtos")
8627:             THIS.CriarCursoresCotacao()
8628:         ENDIF
8629: 
8630:         ZAP IN cursor_4c_Produtos
8631:         ZAP IN cursor_4c_Fornecedores
8632: 
8633:         INSERT INTO cursor_4c_Produtos (cIdChaves, Codigos, CItens, CPros, DPros, Obs, Qtds, CUnis, QtdAdqs) ;
8634:             VALUES (LEFT(fUniqueIds(), 20), 0, 1, "", "", "", 0, "", 0)
8635: 
8636:         FOR loc_nI = 1 TO 6
8637:             INSERT INTO cursor_4c_Fornecedores (cIdChaves, Codigos, Grades, Fretes) ;
8638:                 VALUES (LEFT(fUniqueIds(), 20), 0, CHR(64 + loc_nI), "Emitente")
8639:         ENDFOR
8640: 
8641:         GO TOP IN cursor_4c_Produtos
8642:         GO TOP IN cursor_4c_Fornecedores
8643: 
8644:         IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5) AND PEMSTATUS(THIS.pgf_4c_Paginas.Page3, "grd_4c_Produtos", 5)
8645:             THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()
8646:             THIS.pgf_4c_Paginas.Page3.grd_4c_Fornecedores.Refresh()
8647:             THIS.GridCotacoesAfterRowColChange(1)
8648:         ENDIF
8649:     ENDPROC
8650: 
8651:     *--------------------------------------------------------------------------
8652:     * AlteraCotacao - Leva para a pagina de Cotacoes a cotacao SELECIONADA na

*-- Linhas 8737 a 8785:
8737:     *--------------------------------------------------------------------------
8738:     * CarregarCotacaoSelecionada - Le o cabecalho da cotacao (SigCtTDc) e o
8739:     * entrega ao Business Object. Equivale ao primeiro bloco do PROCEDURE
8740:     * alteracotacao legado (SqlExecute + Scatter/Insert em crSigCtTDc), aqui
8741:     * com o cabecalho vivendo nas propriedades do BO.
8742:     *--------------------------------------------------------------------------
8743:     PROTECTED PROCEDURE CarregarCotacaoSelecionada(par_nCodigo)
8744:         LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
8745: 
8746:         loc_lSucesso = .F.
8747: 
8748:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
8749:             RETURN .T.
8750:         ENDIF
8751: 
8752:         IF !(TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
8753:             RETURN .F.
8754:         ENDIF
8755: 
8756:         TRY
8757:             loc_cSQL = "SELECT * FROM SigCtTDc WHERE Codigos = " + ;
8758:                        FormatarNumeroSQL(par_nCodigo, 0) + " ORDER BY Codigos"
8759: 
8760:             IF USED("cursor_4c_CotacaoAtual")
8761:                 USE IN cursor_4c_CotacaoAtual
8762:             ENDIF
8763: 
8764:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotacaoAtual")
8765: 
8766:             IF loc_nResultado < 1
8767:                 MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
8768:                     "Falha na Conex" + CHR(227) + "o (Cota" + CHR(231) + CHR(227) + "o)")
8769:             ELSE
8770:                 SELECT cursor_4c_CotacaoAtual
8771:                 GO TOP IN cursor_4c_CotacaoAtual
8772: 
8773:                 IF EOF("cursor_4c_CotacaoAtual")
8774:                     MsgAviso("Cota" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
8775:                         "o encontrada: " + ALLTRIM(TRANSFORM(par_nCodigo)), ;
8776:                         "Aten" + CHR(231) + CHR(227) + "o!!!")
8777:                 ELSE
8778:                     THIS.this_oBusinessObject.EditarRegistro()
8779:                     loc_lSucesso = ;
8780:                         THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_CotacaoAtual")
8781: 
8782:                     IF loc_lSucesso
8783:                         THIS.CarregarItensEFornecedoresCotacao(par_nCodigo)
8784:                         THIS.PopularCamposCotacaoNoFormulario()
8785:                         THIS.AjustarCamposCotacao()

*-- Linhas 8802 a 8841:
8802:     *--------------------------------------------------------------------------
8803:     * CarregarItensEFornecedoresCotacao - Le SigCtTCt/SigCtTFn da cotacao
8804:     * <par_nCodigo> para cursor_4c_Produtos/cursor_4c_Fornecedores (equivalente
8805:     * ao SELECT * ... Order By Codigos, CItens/Grades do PROCEDURE
8806:     * alteracotacao legado - aqui usado tanto por Alterar quanto Consultar/
8807:     * Excluir, ja que a estrutura de carga eh identica).
8808:     *--------------------------------------------------------------------------
8809:     PROTECTED PROCEDURE CarregarItensEFornecedoresCotacao(par_nCodigo)
8810:         LOCAL loc_cSQL, loc_nResultado
8811: 
8812:         IF !USED("cursor_4c_Produtos")
8813:             THIS.CriarCursoresCotacao()
8814:         ENDIF
8815: 
8816:         ZAP IN cursor_4c_Produtos
8817:         ZAP IN cursor_4c_Fornecedores
8818: 
8819:         loc_cSQL = "SELECT * FROM SigCtTCt WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
8820:             " ORDER BY Codigos, CItens"
8821:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosTemp")
8822: 
8823:         IF loc_nResultado > 0 AND USED("cursor_4c_ProdutosTemp")
8824:             SELECT cursor_4c_ProdutosTemp
8825:             SCAN
8826:                 INSERT INTO cursor_4c_Produtos (cIdChaves, Codigos, CItens, CPros, DPros, CUnis, CodCors, CodTams, ;
8827:                         EmpDopNums, Obs, Justificas, Qtds, QtdAdqs, ValAdqs, ;
8828:                         Marca01, Marca02, Marca03, Marca04, Marca05, Marca06, ;
8829:                         Unit01, Unit02, Unit03, Unit04, Unit05, Unit06, ;
8830:                         Tota01, Tota02, Tota03, Tota04, Tota05, Tota06) ;
8831:                     VALUES (cursor_4c_ProdutosTemp.cIdChaves, cursor_4c_ProdutosTemp.Codigos, ;
8832:                         cursor_4c_ProdutosTemp.CItens, ALLTRIM(cursor_4c_ProdutosTemp.CPros), ;
8833:                         ALLTRIM(cursor_4c_ProdutosTemp.DPros), ALLTRIM(cursor_4c_ProdutosTemp.CUnis), ;
8834:                         ALLTRIM(NVL(cursor_4c_ProdutosTemp.CodCors, "")), ALLTRIM(NVL(cursor_4c_ProdutosTemp.CodTams, "")), ;
8835:                         ALLTRIM(NVL(cursor_4c_ProdutosTemp.EmpDopNums, "")), NVL(cursor_4c_ProdutosTemp.Obs, ""), ;
8836:                         NVL(cursor_4c_ProdutosTemp.Justificas, ""), cursor_4c_ProdutosTemp.Qtds, ;
8837:                         cursor_4c_ProdutosTemp.QtdAdqs, cursor_4c_ProdutosTemp.ValAdqs, ;
8838:                         ConverterParaLogico(cursor_4c_ProdutosTemp.Marca01), ConverterParaLogico(cursor_4c_ProdutosTemp.Marca02), ;
8839:                         ConverterParaLogico(cursor_4c_ProdutosTemp.Marca03), ConverterParaLogico(cursor_4c_ProdutosTemp.Marca04), ;
8840:                         ConverterParaLogico(cursor_4c_ProdutosTemp.Marca05), ConverterParaLogico(cursor_4c_ProdutosTemp.Marca06), ;
8841:                         cursor_4c_ProdutosTemp.Unit01, cursor_4c_ProdutosTemp.Unit02, cursor_4c_ProdutosTemp.Unit03, ;

*-- Linhas 8849 a 8878:
8849:         *-- Sem linhas (nao deveria acontecer, mas o legado sempre garante ao
8850:         *-- menos 1 linha para a grade nao ficar sem cursor posicionavel)
8851:         IF RECCOUNT("cursor_4c_Produtos") < 1
8852:             INSERT INTO cursor_4c_Produtos (cIdChaves, Codigos, CItens, CPros, DPros, Obs, Qtds, CUnis, QtdAdqs) ;
8853:                 VALUES (LEFT(fUniqueIds(), 20), par_nCodigo, 1, "", "", "", 0, "", 0)
8854:         ENDIF
8855: 
8856:         loc_cSQL = "SELECT * FROM SigCtTFn WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
8857:             " ORDER BY Codigos, Grades"
8858:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FornecTemp")
8859: 
8860:         IF loc_nResultado > 0 AND USED("cursor_4c_FornecTemp")
8861:             SELECT cursor_4c_FornecTemp
8862:             SCAN
8863:                 INSERT INTO cursor_4c_Fornecedores (cIdChaves, Codigos, Grades, IClis, Fornecs, Contatos, ;
8864:                         Tel1s, FPags, DtEnts, Fretes, VlFretes) ;
8865:                     VALUES (cursor_4c_FornecTemp.cIdChaves, cursor_4c_FornecTemp.Codigos, cursor_4c_FornecTemp.Grades, ;
8866:                         ALLTRIM(cursor_4c_FornecTemp.IClis), ALLTRIM(cursor_4c_FornecTemp.Fornecs), ;
8867:                         ALLTRIM(cursor_4c_FornecTemp.Contatos), ALLTRIM(cursor_4c_FornecTemp.Tel1s), ;
8868:                         ALLTRIM(cursor_4c_FornecTemp.FPags), ConverterParaData(NVL(cursor_4c_FornecTemp.DtEnts, {})), ;
8869:                         ALLTRIM(NVL(cursor_4c_FornecTemp.Fretes, "Emitente")), NVL(cursor_4c_FornecTemp.VlFretes, 0))
8870:             ENDSCAN
8871:             USE IN cursor_4c_FornecTemp
8872:         ENDIF
8873: 
8874:         GO TOP IN cursor_4c_Produtos
8875:         GO TOP IN cursor_4c_Fornecedores
8876: 
8877:         IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5) AND PEMSTATUS(THIS.pgf_4c_Paginas.Page3, "grd_4c_Produtos", 5)
8878:             THIS.pgf_4c_Paginas.Page3.grd_4c_Produtos.Refresh()

*-- Linhas 8892 a 8912:
8892:     * fora da classe (chamada externa estoura "Property FORMPARABO is not
8893:     * found", mesmo com PEMSTATUS devolvendo .T. - CLAUDE.md regra #3).
8894:     *
8895:     * No legado cada um desses campos tem ControlSource apontando direto para
8896:     * crSigCtTDc, entao o que o usuario digitou ja esta no cursor quando o
8897:     * btnGravaDados dispara. Aqui nao ha ControlSource: os Validar<X> so
8898:     * escrevem no BO quando o campo perde o foco ou recebe Enter/Tab. Sem esta
8899:     * varredura, o que foi digitado e gravado direto no botao (sem sair do
8900:     * campo) - data de cotacao/validade/pagamento, prioridade, departamento -
8901:     * se perderia em silencio. Chamado por GravaDados antes do Salvar().
8902:     *
8903:     * NAO recolhe os campos abaixo, de proposito - o dono deles e outro:
8904:     *   this_cCidChaves / this_nCodigos - gerados pelo BO no primeiro Inserir
8905:     *                                     (os TextBox sao ReadOnly, exibicao)
8906:     *   this_nCopias                    - definido por CopiaCotacao (ReadOnly)
8907:     *   this_nSituas                    - definido por GravaPedidos
8908:     *   this_nLocalEnts                 - definido pelo dialogo SigCdEnd
8909:     *   this_nChkAprovs                 - flag da maquina de aprovacao. Quem
8910:     *                                     manda nele sao ChkAprovadorClick e
8911:     *                                     AprovarCotacao, que o ZERAM no BO e
8912:     *                                     so DEPOIS de GravaDados zeram o

*-- Linhas 8961 a 8979:
8961:     *--------------------------------------------------------------------------
8962:     * BOParaForm - Caminho inverso de FormParaBO: espelha as propriedades do
8963:     * cabecalho da cotacao (SigCtTDc, no BusinessObject) nos controles da
8964:     * pagina de Cotacoes. E o que o legado obtem de graca pelo ControlSource
8965:     * ligado a crSigCtTDc. Chamado sempre que uma cotacao NOVA ou EXISTENTE e
8966:     * carregada no BO (GeraCotacao / AlteraCotacao / CopiaCotacao, atraves de
8967:     * PopularCamposCotacaoNoFormulario) e depois do Salvar(), para o Codigo
8968:     * recem-gerado aparecer na tela.
8969:     *
8970:     * this_cDContaEs e a unica descricao de lookup com controle proprio; as
8971:     * demais (this_cDComprador/DDeptos/DSolicitas/DAprovador/DAprSols) nao tem
8972:     * TextBox na tela - o legado tambem so exibe o codigo nesses campos.
8973:     *
8974:     * Override do hook PROTECTED de FormBase (formbase.prg:280) - ver a nota
8975:     * de escopo em FormParaBO.
8976:     *--------------------------------------------------------------------------
8977:     PROTECTED PROCEDURE BOParaForm()
8978:         LOCAL loc_oBO, loc_oPag, loc_oAdic, loc_oApr, loc_oSol
8979: 


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

