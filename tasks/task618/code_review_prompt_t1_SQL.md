# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, FABRS, CODCORS, DISPS, NUMERODAOP, NUMPS, KEYPDES, PRODUZIR, FABRPROPRS, _LNVEZES, EMPDOPNUMS, CIDCHAVES, CITEM2, CONTADS, EMPS, NUMES, CODTAMS, XBAIXA, NOPS, QTDS, IF, X, CMATS, PRAZOENTS, ENTPES, AUTOS, MATS, NTRANS, TMPH, EMPDNPS, ESTOQUE, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VALOR' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, FABRS, CODCORS, DISPS, NUMERODAOP, NUMPS, KEYPDES, PRODUZIR, FABRPROPRS, _LNVEZES, EMPDOPNUMS, CIDCHAVES, CITEM2, CONTADS, EMPS, NUMES, CODTAMS, XBAIXA, NOPS, QTDS, IF, X, CMATS, PRAZOENTS, ENTPES, AUTOS, MATS, NTRANS, TMPH, EMPDNPS, ESTOQUE, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, FABRS, CODCORS, DISPS, NUMERODAOP, NUMPS, KEYPDES, PRODUZIR, FABRPROPRS, _LNVEZES, EMPDOPNUMS, CIDCHAVES, CITEM2, CONTADS, EMPS, NUMES, CODTAMS, XBAIXA, NOPS, QTDS, IF, X, CMATS, PRAZOENTS, ENTPES, AUTOS, MATS, NTRANS, TMPH, EMPDNPS, ESTOQUE, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, FABRS, CODCORS, DISPS, NUMERODAOP, NUMPS, KEYPDES, PRODUZIR, FABRPROPRS, _LNVEZES, EMPDOPNUMS, CIDCHAVES, CITEM2, CONTADS, EMPS, NUMES, CODTAMS, XBAIXA, NOPS, QTDS, IF, X, CMATS, PRAZOENTS, ENTPES, AUTOS, MATS, NTRANS, TMPH, EMPDNPS, ESTOQUE, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VALUE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, FABRS, CODCORS, DISPS, NUMERODAOP, NUMPS, KEYPDES, PRODUZIR, FABRPROPRS, _LNVEZES, EMPDOPNUMS, CIDCHAVES, CITEM2, CONTADS, EMPS, NUMES, CODTAMS, XBAIXA, NOPS, QTDS, IF, X, CMATS, PRAZOENTS, ENTPES, AUTOS, MATS, NTRANS, TMPH, EMPDNPS, ESTOQUE, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PRODUZIR2' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, FABRS, CODCORS, DISPS, NUMERODAOP, NUMPS, KEYPDES, PRODUZIR, FABRPROPRS, _LNVEZES, EMPDOPNUMS, CIDCHAVES, CITEM2, CONTADS, EMPS, NUMES, CODTAMS, XBAIXA, NOPS, QTDS, IF, X, CMATS, PRAZOENTS, ENTPES, AUTOS, MATS, NTRANS, TMPH, EMPDNPS, ESTOQUE, CITENS, QTPRODS, DTALTS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = "TmpFinalg.Cpros"
  ControlSource = "TmpFinalG.TotVenda"
  ControlSource = "TmpFinalG.QtdMins"
  DeleteMark = .F.
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  DeleteMark = .F.
  ControlSource = "TmpFinal.Obsps"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  DeleteMark = .F.
  ControlSource = "TmpFinalg.Cpros"
  DeleteMark = .F.
  ControlSource = "TmpFinalg.Cpros"
  ControlSource = "TmpFinalg.Cpros"
  DeleteMark = .F.
	Select &cCompo.
		Select crSigCdCom
			lcQuery = [Select a.cUnis, a.cUnips, b.BPesos ] + ;
					  [From SigCdPro a, SigCdGrp b ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSomaGru') < 1)
				lcSql = [Select Fators From SigCdUni Where Cunis = ']+Iif(CrSomaGru.bPesos=1,CrSomaGru.Cunis,CrSomagru.CUnips)+[']
				=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalUni')
				Select &cCompo.
	Select &cCompo.
Select Dopes,Estoqs,Origems,Destinos,EstOrigs,EstDests From CrSigCdOpe ;
Select Distinct Dopes From CrSigMvHst Into Cursor SelOperacao
Select SelOperacao
	lcSql = [Select Dopes,Estoqs,Origems,Destinos,EstOrigs,EstDests From SigCdOpe ]+;
	ThisForm.Podatamgr.Sqlexecute(lcSql,'xTmpOpe')
	Select LocalOpe
	Append From Dbf('xTmpOpe')
Select LocalOpe
Select SelOperacao
	lcSql = [Select Dopps as Dopes,1 as Estoqs,Origems,Destinos,EstOrigs,EstDests From SigCdOpd ]+;
	ThisForm.Podatamgr.Sqlexecute(lcSql,'xTmpOpe')
	Select LocalOpe
	Append From Dbf('xTmpOpe')
Select crSigMvHst
Select SelPedra
	.Column3.ControlSource = 'TmpFinalg.Flag'
	.Column1.ControlSource = 'TmpFinalg.Cpros'
	.Column2.ControlSource = 'TmpFinalg.CodCors'
	.Column9.ControlSource = 'TmpFinalg.CodTams'
	.Column5.ControlSource = 'TmpFinalg.Saldo'
	.Column7.ControlSource = 'TmpFinalg.Fabrs'
	.Column10.ControlSource = 'TmpFinalg.Estoque'
	.Column6.ControlSource = 'TmpFinalg.Produzir'
	.Column8.ControlSource = 'TmpFinalg.Produzir2'
	.Column1.ControlSource = 'TmpFinal.Cpros'
	.Column2.ControlSource = 'TmpFinal.CodCors'
	.Column3.ControlSource = 'TmpFinal.Dopes'
	.Column4.ControlSource = 'TmpFinal.Numes'
	.Column5.ControlSource = 'TmpFinal.Saldo'
	.Column6.ControlSource = 'TmpFinal.Produzir'
	.Column7.ControlSource = 'TmpFinal.Estoque'
	.Column8.ControlSource = 'Iif( !Empty( TmpFinal.Obsps ), "*", "" )'
	.Column9.ControlSource = 'TmpFinal.CodTams'
	.Column10.ControlSource = 'TmpFinal.Fabrs'
Select TmpSaldG
	.Column1.ControlSource = 'TmpSaldG.Grupos'
	.Column2.ControlSource = 'TmpSaldG.Estos'
	.Column3.ControlSource = 'TmpSaldG.Saldo'
	.Column4.ControlSource = 'TmpSaldG.Saldo - TmpSaldg.Disps'
	.Column5.ControlSource = 'TmpSaldg.Disps'
	.Column6.ControlSource = 'TmpSaldg.Priors'
Select TmpFabr
	.Column6.ControlSource = 'TmpFabr.Nops'
	.Column1.ControlSource = 'TmpFabr.Fases'
	.Column2.ControlSource = 'TmpFabr.Qtds'
	.Column3.ControlSource = 'TmpFabr.Disps'
	.Column4.ControlSource = 'TmpFabr.Priors'
Select TmpFinalg
Select TmpFinal
lcSql = [Select a.cpros,a.dpros,a.FigJpgs From SigCdPro a Where a.cpros = ']+lcCodPro+[' ]
ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalPro')
		Delete File (lcArquivo)
Select Cpros, CodCors, CodTams, Disps, 000000000.000 AS  Utilizar;
From TmpSaldo Where Cpros = lcCpro And CodCors = lcCor And Disps > 0;
Select 0
		.Column1.ControlSource = 'Tmpdisp.Cpros'
		.Column2.ControlSource = 'Tmpdisp.CodCors'
		.Column3.ControlSource = 'Tmpdisp.CodTams'
		.Column4.ControlSource = 'Tmpdisp.Disps'
		.Column5.ControlSource = 'Tmpdisp.Utilizar'
Select CrSigCdPam
Select crSigOpPic
Select crSigPdMvf
Select crSigCdNec
Select crSigMvCab
Select crSigMvHst
Select crSigBxEst
Select crSigMvItn
Select crSigMvIts
Select CrSigOpPii
Select CrSigInAtz
Select CrSigCdNei
Select * From CrSigCdNei Where 0=1 Into Cursor GrSigCdNei ReadWrite
	lcSql = [Select Numps From SigOpPic Where Numps = ]+Str(_Nump)
	If (ThisForm.poDataMgr.SqlExecute(lcSql, 'TmpOpi') < 1)
Select * From CrSigMvIts Where 0=1 Into Cursor crTplMvIts ReadWrite
Select * From CrSigMvItn Where 0=1 Into Cursor crTpmMvItn ReadWrite
Select TmpFinalG
lcSql = [Select * From SigCdOpe Where Dopes = ']+_DopEst+[']
ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSigCdOpe')
Insert Into CrSigMvCab ( Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, Contaos, ;
	Select TmpFinal
	Delete For KeyPdes = .t.
	Select TmpFinalG
		Insert Into TmpFinal (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, Estoque, Produzir, Obsps, ;
	Select TmpFinal
						Insert Into crSigPdMvf (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, Grupods, Contads, ;
						Insert Into crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, TotPesos, Grupoos, ;
						Insert Into GrSigCdNei (Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, ;
						lcQuery = [Select Sum(qtds) as total from SigPrMtz where Cpros = ?TmpFinal.CPros]
						If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPrMtz') < 1)
						Select crSigPrMtz
					lcQuery = [Select * ] + ;
							    [From SigMvItn ] + ;
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEestI') < 1)
					Select TempEestI
					Insert Into crSigOpPic (Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, Qtds, Cpros, ;
					Select TempEestI
							lcQuery = [Select * ] + ;
									    [From SigMvIts ] + ;
							If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEsti2') < 1)
							Select TempEsti2
								lcQuery = [Update SigMvItn ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - 1)')
								Select TempEsti2
										lcQuery = [Update SigMvItn ] + ;
										If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
											=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - 2)')
										lcQuery = [Update SigMvIts ] + ;
										If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
											=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - 3)')
					lcQuery = [Update SigMvCab ] + ;
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - 4)')
					lcquery = [Select a.*, b.cgrus from SigSubMv a inner join SigCdPro b on a.mats=b.cpros ] + ;
					If ThisForm.poDataMgr.sqlexecute(lcquery,[LocalCompo]) < 1
						Select LocalCompo
						Select crSigOpPic
					Select crSigPdMvf
					Select GrSigCdNei
					Select crSigCdNec
				Select crSigMvCab
					Select Max(Citens) as Citens from crTpmMvItn Where Emps = _Empr And Dopes = _DopePed And Numes = _Nume Into Cursor TmpUltItn
					Insert Into crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, Contaos, ;
				Insert Into crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, Citens, Pesos, cUniPs, Obs ) ;
					Insert Into crTplMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, Pesos, CodCors, CodTams, QtdEmbs) ;
				lcQuery = [Update SigMvCab ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
					=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - 4.1)')
		Select TmpFinal
Select * From CrSigOpPic where 0=1 Into Cursor TmpOpi ReadWrite
Select TmpSaldg
Select TmpFinal
		Select TmpSaldG
		=Seek(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams)
				Insert Into TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, Grupos, Estos, Estoque, EmpDs ) Values ;
					Insert Into TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, Grupos, Estos, Estoque, EmpDs ) Values ;
Select TmpEstoque
	Select TmpEstoque
		lcQuery = [Update SigMvCab ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - 5)')
			Insert Into crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, Contaos, ;
			lcQuery = [Update SigMvCab ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - 6)')
	Insert Into crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, cItens) ;
		Insert Into crTplMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, CodCors, CodTams, QtdEmbs) ;
		Insert Into crSigMvHst (Usuars, Datas, Datars, Emps, Dopes, Numes, Empos, Cpros, Qtds, Opers, Grupos, ;
		Insert Into crSigMvHst (Usuars, Datas, Datars, Emps, Dopes, Numes, Empos, Cpros, Qtds, Opers, Grupos, ;
	lcQuery = [Select * ] + ;
			    [From SigMvIts ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEsti2') < 1)
	lcQuery = [Select * ] + ;
			    [From SigMvItn ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEestI') < 1)
	Select TempEestI
		lcQuery = [Update SigMvItn ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - 7)')
			Insert Into crSigBxEst (Emps, Dopes, Numes, CItens, Cpros, Datas, Empbs, Dopebs, ;
	Select TempEsti2
		lcQuery = [Update SigMvIts ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - 8)')
		Insert Into crSigBxEst (Emps, Dopes, Numes, CItens, Cpros, Datas, Empbs, Dopebs, Numebs, ;
Select TmpFabr
Select TmpFinal
		Select TmpFabr
		=Seek(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams)
				Insert Into TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, Nops, Estoque ) Values ;
					Insert Into TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, Nops, Estoque ) Values ;
Select CrSigMvCab
Select TmpFinalG
		Insert Into CrSigInAtz (Emps,dopes,Numes,EmpDopNums,Cpros,Qtds,Qtdes,qtdps,qtdfs,;
	Insert Into crTpmMvItn ( Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, cItens, Pesos, Units, Moedas, Totas ) ;
		Insert Into crTplMvIts ( cItens, Emps, Dopes, Numes, CPros, Qtds, CodCors, CodTams, QtdEmbs  ) ;
Select TmpEstoque
	lcSql = [Select * From SigOpPic Where Nops = ]+Str(TmpEstoque.Nops)
	ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalOpi')
	Select LocalOpi
			lcSql = [Update SigOpPic Set Qtds = ]+Str(LocalOpi.Qtds,12,3)+[ Where CidChaves = ']+LocalOpi.CidChaves+[']
			Thisform.Podatamgr.Sqlexecute(lcSql,'')
			Insert Into CrSigOpPii (Emps,dopes,Numes,EmpDopNums,Empos,DopeOs,NumeOs,EmpDs,DopeDs,Numeds,Qtds,Nops,Cidchaves) Values ;
			Select TmpOpi
			Append From array memvar
				Insert Into CrSigOpPii (Emps,dopes,Numes,EmpDopNums,Empos,DopeOs,NumeOs,EmpDs,DopeDs,Numeds,Qtds,Nops,Cidchaves) Values ;
				Select LocalOpi
				Select TmpOpi
				Append From array Memvar
	lcQuery = [Select * ] + ;
			    [From SigMvIts ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEsti2') < 1)
	lcQuery = [Select * ] + ;
			    [From SigMvItn ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEestI') < 1)
	Select TempEestI
		lcQuery = [Update SigMvItn ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - 7)')
	Select TempEsti2
		lcQuery = [Update SigMvIts ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - 8)')
	Select CrSigMvCab
		Select CrSigMvCab
		Delete
Select CrSigOpPic
Append From Dbf('TmpOpi')
	SELECT SelPedra
			Select TmpPedra
			If Not Seek(SelPedra.Cpros)
				Insert Into TmpPedra (Grupos, Contas, cGrus, cMats, QtdMins) ;
			Select TmpMatPrz 
			If Not Seek(Dtoc(Date()) + SelPedra.Cpros)
				Insert Into TmpMatPrz(cMats, PrazoEnts) ;
			Select TmpEmpH
			If Not Seek(SelPedra.Cpros + SelPedra.Cpro2s)
				Insert Into TmpEmpH (Grupos, Contas, cGrus, cMats, QtdMins, Cpro2s ) ;
	Select TmpFinal
		lcsql = [Select GerEmphs From SigOpCdc where Dopes = ']+TmpFinal.Dopes+[']
		ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpDcOpe')
			Select * from &lcBusca. into cursor crSigPrCpo READWRITE
		Select crSigPrCpo
				Select TmpPedra
				If Not Seek(crSigPrCpo.Mats)
					Insert Into TmpPedra (Grupos, Contas, cGrus, cMats, QtdMins) ;
				Select TmpMatPrz 
				If Not Seek(Dtoc(ldDtEnt) + crSigPrCpo.Mats)
					Insert Into TmpMatPrz(cMats, PrazoEnts) ;
				Select TmpEmpH
				If Not Seek(CrSigPrCpo.Mats + CrSigPrCpo.Cpros)
					Insert Into TmpEmpH (Grupos, Contas, cGrus, cMats, QtdMins, Cpro2s ) ;
		lcQuery = [Select * ] + ;
				    [From SigMvCab ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEest') < 1)
		Select TempEest
			Select TempEestI
					Select TmpPedra
					If Seek(TempEestI.Cpros)
	lcQuery = [Select b.* ] + ;
				[From SigMvEst b ] + ;
					 [Select GruEstps + ConEstPs as Contas ] + ;
					   [From SigCdGrp ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'pEstoque') < 1)
	Select pEstoque
		Select TmpPedra
		If Seek(pEstoque.Cpros)
	Select TmpEmpH
			Insert Into crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, ;
		Insert Into crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, Citens, cPro2s) ;
	Select TmpPedra
	Select TmpPedra
			Select TmpMatPrz
			Select crSigMvCab
				Select crTpmMvItn
				Select Max(Citens) as Citens from crTpmMvItn Where Emps = _Empr And Dopes = _Dope And Numes = _Nume Into Cursor TmpUltItn
				Insert Into crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, Contaos, ;
			Insert Into crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, Citens) ;
Select crTpmMvItn
	Insert Into crSigMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, Citens, ;
Select crTplMvIts
	Insert Into CrSigMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, CodCors, CodTams, QtdEmbs  ) ;
	Select CrSigCdNec
	Select GrSigCdNei
		Select Cmats, Cdescs, cUnis, TpOps, Nops, Nenvs, sum(Pesos) as Pesos, sum(Qtds) as Qtds, sum(Peso2s) as Peso2s ;
		From GrSigCdNei Into Cursor TmpNensi group by 1,2,3,4,5,6
		Select TmpNensi
			Insert Into crSigCdNei (Emps, Dopps, Numps, Cmats, Cdescs, cUnis, Pesos, Qtds, TpOps, EmpDNps, ;
				Insert Into crSigMvHst ( Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, Grupos, Estos, Cpros, Opers, Qtds, ;
				Insert Into crSigMvHst ( Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, Grupos, Estos, Cpros, Opers, Qtds, ;
			Insert Into crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, ;
		Select * From GrSigCdNei Into Cursor TmpNensi Order by EmpDnPs,Nops
		Select TmpNensi
			=Seek(TmpNensI.EmpDnPs,'CrSigCdNec','EmpDnPs')
			If Not Seek(_DopEntAu + _GrupoC + _ContaC + _GrupoD + _ContaD,'CrSigCdNec','DopEntAu')				
				Insert Into crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, ;
			Select TmpNensi
			Insert Into crSigCdNei (Emps, Dopps, Numps, Cmats, Cdescs, cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves, nenvs, Peso2s, Nops ) ;
				Insert Into crSigMvHst ( Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, Grupos, Estos, Cpros, Opers, Qtds, ;
				Insert Into crSigMvHst ( Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, Grupos, Estos, Cpros, Opers, Qtds, ;
Select crSigMvHst
	Select TmpCabec
		lcSql = [Update SigMvCab Set Rnops = ]+Str(_Rnop)+[ Where EmpDopNums = ']+TmpCabec.Emps + TmpCabec.Dopes + Str( TmpCabec.Numes, 6 )+[']
		ThisForm.Podatamgr.Sqlexecute(lcSql,'')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigOpPic')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigOpPic)')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigPdMvf')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPdMvf)')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigCdNec')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdNec)')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigCdNei')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdNei)')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigMvCab')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvCab)')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigMvHst')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvHst)')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigBxEst')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigBxEst)')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigMvItn')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvItn)')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigMvIts')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvIts)')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigOpPii')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigOpPii)')
If Not llErro And Not ThisForm.poDataMgr.Update('crSigInAtz')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigInAtz)')
	lcSql = [Select dopps From SigCdOpd where Autos = 1 ]
	Thisform.PodataMgr.sqlExecute(lcSql,'CrSigCdOpd')
	Select CrSigCdOpd
	lcSql = [Select Dopps From SigCdOpd Where Autos = 2 ]
	ThisForm.PodataMgr.SqlExecute(lcSql,'CrTmpOpp')
	Select CrTmpOpp
	Select crSigPdMvf
	Select crSigCdNec
	Select CrSigCdNei
	Select crSigMvHst
	Select CrSigCdNei
	Create Cursor xNensi From Array _axNensi
	lcSql = [Select * From SigCdLnf ]
	=ThisForm.Podatamgr.SqlExecute(lcSql,'TmpLinf')
	Select TmpLinF
	lcSql = [Select a.Cpros, a.Nops, b.Linhas, b.cUnis, a.EmpdopNops, a.CodTams, sum(a.Qtds) as Qtds, Sum(a.Pesos) as Pesos From SigOpPic a, SigCdPro b ]+;
	Thisform.PodataMgr.SqlExecute(lcSql,'TmpOpi')
	Select TmpOpi
		lcSql = [Select a.Mats, a.Qtds, b.cunis, b.Pesoms, b.Cgrus, b.dpros, c.Fators, b.Varias, d.Mercs ]+;
				[From SigSubMv a, SigCdPro b, SigCdUni c, SigCdGrp d ]+;
		=ThisForm.Podatamgr.SqlExecute(lcSql,'TmpCompo')
			lcSql = [Select a.Mats, b.cunis, b.Pesoms, b.Cgrus, b.dpros, c.Fators, b.Varias, d.Mercs, ] +;
					[From SigPrCpo a inner Join SigCdPro b On a.mats = b.Cpros ] +;
					[Inner Join SigCdUni c On b.Cunis = c.Cunis ] +;
					[Inner Join SigCdGrp d On b.Cgrus = d.Cgrus ] +;
					[Left Join SigSubCp e On a.mats = e.Mats And e.CodTams = ']+TmpOpi.CodTams+[' ] +;
			=ThisForm.Podatamgr.SqlExecute(lcSql,'TmpCompo')
		Select xNensi
		Select TmpLinF
		If Not Seek(TmpOpi.Linhas)
			Select CrSigCdNec
			If Not Seek(_GrpO + _CtaO + _GrpD + _CtaD + Dtos(_DtGe) + Str(TmpLinf.Ordems,10))
			Insert Into CrSigPdMvf (Grupoos, Contaos, Grupods, Contads, NOps, NEnvs, Codpds, Unids, Pesos, Qtds, Ordems, nTrans, Usuars ) ;
				Select TmpCompo
						Insert Into xNensi (Nops, NEnvs, CMats, CDescs, CUnis, CGrus, Qtds, Pesos) ;
			Select xNensi
				Insert Into CrSigCdNei From Memvar
			Select TmpLinF
		Select CrSigCdNec
		If Not Seek(_GrpO + _CtaO + _GrpD + _CtaD + Dtos(_DtGe) + Str(99,10))
		Insert Into CrSigPdMvf (Grupoos, Contaos, Grupods, Contads, NOps, NEnvs, Codpds, Unids, Pesos, Qtds, Ordems, nTrans, Usuars ) ;
		Select xNensi
			Insert Into CrSigCdNei From Memvar
	Select CrSigCdNec
		Select crSigPdMvf
		=Seek(nTran)
		lcSql = [Select * From SigCdOpd Where Dopps = ']+CrSigCdNec.Dopps+[']
		=Thisform.PodataMgr.SqlExecute(lcSql,'CrSigCdOpd')
		Select CrSigCdNei
		=Seek(nTran)
			lcSql = [Select Cgrus From SigCdPro Where Cpros = ']+CrSigCdNei.Cmats+[']
			ThisForm.PodataMgr.SqlExecute(lcSql,'LocalPro')
			lcSql = [Select cEstoqs From SigCdGrp Where Cgrus = ']+LocalPro.Cgrus+[']
			ThisForm.PodataMgr.SqlExecute(lcSql,'LocalGru')
				Insert Into crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, CPros, Empos, Qtds, Grupos, ;
				Insert Into crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, CPros, Empos, Qtds, Grupos, ;
			Select Distinct b.Nops, b.Cpros, b.Qtds ;
			  From CrSigCdNei a, TmpOpi b ;
			Select TmpHis
				Insert Into crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, CPros, Empos, Qtds, ;
	Select TmpOpi
		lcSql = [Select CidChaves From SigCdNec Where EmpDnPs = ']+TmpOpi.EmpDopNops+[']
		If Thisform.Podatamgr.Sqlexecute(lcsql,'LocalNens') < 1
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdNec)')
			Select LocalNens
				lcUpdate = [Update SigCdNec Set ChkSubn = ?llTrue Where cidChaves = ']+LocalNens.CidChaves+[']
				If Thisform.PodataMgr.SqlExecute(lcUpdate,'') < 1
					=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdNec 1)')
	If Not llErro And Not ThisForm.poDataMgr.Update('crSigPdMvf')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPdMvf)')
	If Not llErro And Not ThisForm.poDataMgr.Update('crSigCdNec')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdNec)')
	If Not llErro And Not ThisForm.poDataMgr.Update('crSigMvHst')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvHst)')
	If Not llErro And Not ThisForm.poDataMgr.Update('crSigCdNei')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdNei)')
Select Linhas, 0 as Ordem, sum(saldo) as saldo, sum(estoque) as estoque, sum(produzir) as produzir, sum(Fabrs) as Fabrs ;
From TmpFinalg Group by 1;
Select Padr('TOTAIS',10) as Linhas, 1 as ordem, sum(saldo) as saldo, sum(estoque) as estoque, sum(produzir) as produzir, sum(Fabrs) as Fabrs ;
from TmpFinalG Group by 1;
	.Column1.ControlSource = 'TmpLinha.Linhas'
	.Column2.ControlSource = 'TmpLinha.Saldo'
	.Column3.ControlSource = 'TmpLinha.Estoque'
	.Column4.ControlSource = 'TmpLinha.Fabrs'
	.Column5.ControlSource = 'TmpLinha.Produzir'
Select Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, 000000000.000 AS  Utilizar;
From TmpSaldG Where Cpros = lcCpro And CodCors = lcCor And CodTams = lcTam And Disps > 0;
Select 0
		.Column1.ControlSource = 'Tmpdisp.Grupos'
		.Column2.ControlSource = 'Tmpdisp.Estos'
		.Column3.ControlSource = 'Tmpdisp.Priors'
		.Column4.ControlSource = 'Tmpdisp.Disps'
		.Column5.ControlSource = 'Tmpdisp.Utilizar'
=Seek( TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, 'TmpSaldo' )
Select TmpSaldG
Select TmpFabr
lcSql = [Select Cpros, FigJpgs From SigCdPro Where Cpros = ']+TmpFinalg.cpros+[']
ThisForm.PodataMgr.Sqlexecute(lcSql,'TmpPro')
Select TmpFinalg
If Not Seek(TmpFinalg.Cpros,'TmpSaldU','Cpros')
	Insert into TmpSaldU (Cpros ) Values (TmpFinalg.Cpros)
	Case !Seek( TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, 'TmpSaldo' ) And TmpFinalg.Produzir # TmpFinalg.Saldo
		Select TmpFinalG
		Select TmpSaldo
		Select TmpFabr
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
		Select TmpFinal
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
Select TmpFinalg
If Not Seek(TmpFinalg.Cpros,'TmpSaldU','Cpros')
	Insert into TmpSaldU (Cpros ) Values (TmpFinalg.Cpros)
	Case !Seek( TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, 'TmpSaldo' ) And TmpFinalg.Produzir # TmpFinalg.Saldo
		Select TmpFinalG
		Select TmpSaldo
		Select TmpSaldG
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
		Select TmpFinal
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
Select TmpFinalg
	.Column1.ControlSource = 'SelPedra.Cpros'
	.Column2.ControlSource = 'SelPedra.Dpros'
	.Column3.ControlSource = 'SelPedra.Cunis'
	.Column4.ControlSource = 'SelPedra.Qtds'
	.Column5.ControlSource = 'SelPedra.Cpro2s'
lcSql = [Select cpros, figjpgs From SigCdPro Where Cpros = ']+TmpFinal.Cpros+[']
Thisform.Podatamgr.Sqlexecute(lcSql,'Tmppro')
Select TmpFinal
Select TmpFinal
Select TmpFinal
Select TmpFinal
Select TmpDisp
	Select TmpDisp
		=Seek( TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, 'TmpSaldo' )
		Select TmpFinalg
		Select TmpSaldo
		If Not Seek(TmpFinal.Cpros,'TmpSaldU','Cpros')
			Insert into TmpSaldU (Cpros ) Values (TmpFinal.Cpros)
		Select TmpSaldG
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + Str(TmpDisp.Priors,2) + TmpDisp.Grupos + TmpDisp.Estos)
	=Seek( TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, 'TmpSaldo' )
	Select TmpFinal
	=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
	=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
Select TmpFinalg
Select TmpFinal
Select TmpDisp
	Select TmpFinal
	Create Cursor Temporario From array tfinal
	Select TmpDisp
		=Seek( TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, 'TmpSaldo' )
		Select TmpFinal
		Select Temporario
		Append From array memvar
		Select TmpFinal
		Select TmpFinalG
		Select TmpSaldo
		Select TmpSaldG
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
		Select SigMvIts
		Seek( TmpFinal.Emps + TmpFinal.Dopes + Str(TmpFinal.Numes,6) + TmpFinal.Cpros )
				Append From Array Memvar
	Select TmpFinal
	Append From Dbf('Temporario')
	Select TmpFinalG
	=Seek( TmpFinalG.CPros + TmpFinalG.CodCors + TmpFinalG.CodTams, 'TmpSaldo' )
Select TmpFinalg
	SELECT SelPedra

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.prg) - TRECHOS RELEVANTES PARA PASS SQL (4114 linhas total):

*-- Linhas 362 a 471:
362:         loc_oPag1 = THIS.pgf_4c_1.Page1
363: 
364:         IF !USED("TmpFinalg")
365:             CREATE CURSOR TmpFinalg (Flag C(1), CPros C(14), CodCors C(4), CodTams C(4), ;
366:                 Linhas C(10), Qtds N(10,3), Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), ;
367:                 Fabrs N(10,3), Produzir2 N(10,3), TotVenda N(10,3), QtdMins N(10,3), ;
368:                 KeySelM L, KeySelMP L, UsuLibs C(10))
369:             INDEX ON Cpros + CodCors + CodTams TAG Cpros
370:         ENDIF
371:         IF !USED("cursor_4c_TmpSaldg")
372:             CREATE CURSOR cursor_4c_TmpSaldg (Emps C(3), Grupos C(10), Estos C(10), CPros C(14), ;
373:                 CodCors C(4), CodTams C(4), Saldo N(12,3), Disps N(12,3), Priors N(2), Reservs N(12,3))
374:             INDEX ON CPros + CodCors + CodTams + STR(Priors, 2) + Grupos + Estos + Emps TAG CPros
375:             INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG GruEstPro
376:         ENDIF
377:         IF !USED("cursor_4c_TmpFabr")
378:             CREATE CURSOR cursor_4c_TmpFabr (Priors N(2), Nops N(10), Fases C(10), Cpros C(14), ;
379:                 CodCors C(4), CodTams C(4), Qtds N(12,3), Disps N(12,3), Reservs N(12,3))
380:             INDEX ON Cpros + CodCors + CodTams + STR(Priors, 2) + STR(Nops, 10) TAG Cpros
381:         ENDIF
382:         IF !USED("cursor_4c_TmpSaldo")
383:             CREATE CURSOR cursor_4c_TmpSaldo (CPros C(14), CodCors C(4), CodTams C(4), ;
384:                 Saldo N(12,3), Disps N(12,3), Fabrs N(12,3), DispFs N(12,3))
385:             INDEX ON CPros + CodCors + CodTams TAG CPros
386:         ENDIF
387:         *-- TmpSaldU (Init legado): marca "produto com selecao manual" por
388:         *-- item (KeySelm/KeySelmp), consultado/alterado pelos Valid das
389:         *-- colunas editaveis (Column7 aqui, Column10 na Page2)
390:         IF !USED("TmpSaldU")
391:             CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L, KeySelmp L)
392:             INDEX ON Cpros TAG Cpros
393:         ENDIF
394: 
395:         *-- Grade principal (TmpFinalg) -----------------------------------
396:         loc_oPag1.AddObject("grd_4c_Dados", "Grid")
397: 
398:         WITH loc_oPag1.grd_4c_Dados
399:             .Top         = 173
400:             .Left        = 52
401:             .Width       = 586
402:             .Height      = 173
403:             .RecordSource = ""
404:             .ColumnCount  = 10
405:             .RecordSource = "TmpFinalg"
406:             .RecordMark   = .F.
407:             .DeleteMark   = .F.
408:             .ReadOnly     = .F.
409: 
410:             .Column1.ControlSource = "TmpFinalg.Cpros"
411:             .Column1.Header1.Caption = "Produto"
412:             .Column1.Width = 90
413:             .Column1.ReadOnly = .T.
414: 
415:             .Column2.ControlSource = "TmpFinalg.CodCors"
416:             .Column2.Header1.Caption = "Cor"
417:             .Column2.Width = 50
418:             .Column2.ReadOnly = .T.
419: 
420:             .Column3.ControlSource = "TmpFinalg.Flag"
421:             .Column3.Header1.Caption = ""
422:             .Column3.Width = 30
423: 
424:             .Column4.ControlSource = "TmpFinalg.Qtds"
425:             .Column4.Header1.Caption = "N" + CHR(250) + "mero"
426:             .Column4.Width = 60
427:             .Column4.ReadOnly = .T.
428: 
429:             .Column5.ControlSource = "TmpFinalg.Saldo"
430:             .Column5.Header1.Caption = "Qtde Pedido"
431:             .Column5.Width = 70
432:             .Column5.ReadOnly = .T.
433: 
434:             .Column6.ControlSource = "TmpFinalg.Produzir"
435:             .Column6.Header1.Caption = "Produzir"
436:             .Column6.Width = 70
437:             .Column6.ReadOnly = .T.
438: 
439:             .Column7.ControlSource = "TmpFinalg.Fabrs"
440:             .Column7.Header1.Caption = "Qtd Produ" + CHR(231) + CHR(227) + "o"
441:             .Column7.Width = 80
442:             .Column7.ReadOnly = .F.
443:             .Column7.DynamicBackColor = "RGB(255,255,204)"
444: 
445:             .Column8.ControlSource = "TmpFinalg.Produzir2"
446:             .Column8.Header1.Caption = "Produzir Estq"
447:             .Column8.Width = 80
448:             .Column8.ReadOnly = .T.
449:             .Column8.DynamicForeColor = "IIF(!EMPTY(TmpFinalg.UsuLibs), RGB(255,0,0), RGB(0,0,0))"
450: 
451:             .Column9.ControlSource = "TmpFinalg.CodTams"
452:             .Column9.Header1.Caption = "Tam"
453:             .Column9.Width = 40
454:             .Column9.ReadOnly = .T.
455: 
456:             .Column10.ControlSource = "TmpFinalg.Estoque"
457:             .Column10.Header1.Caption = "Qtd Estoque"
458:             .Column10.Width = 76
459:             .Column10.ReadOnly = .F.
460:         ENDWITH
461: 
462:         *-- GotFocus -> Column7.SetFocus SO nas colunas que o legado redireciona
463:         *-- (Column1/2/5/6/9 - dump: ver lista de PROCEDURE por coluna). NUNCA
464:         *-- no laco inteiro de 1 a 10: Column7 (Qtd Producao), Column8
465:         *-- (Produzir Estq, liberada por BtnAlteraqtdClick) e Column10 (Qtd
466:         *-- Estoque) sao JUSTAMENTE as digitaveis - redirecionar o foco delas
467:         *-- torna as tres inalcancaveis e o usuario nao consegue digitar nada.
468:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
469:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
470:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column5.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
471:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column6.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")

*-- Linhas 520 a 551:
520:             .ColumnCount = 6
521:             .RecordSource = "cursor_4c_TmpSaldg"
522:             .RecordMark = .F.
523:             .DeleteMark = .F.
524:             .ReadOnly = .T.
525: 
526:             .Column1.ControlSource = "cursor_4c_TmpSaldg.Grupos"
527:             .Column1.Header1.Caption = "Grupo"
528:             .Column2.ControlSource = "cursor_4c_TmpSaldg.Estos"
529:             .Column2.Header1.Caption = "Conta"
530:             .Column3.ControlSource = "cursor_4c_TmpSaldg.Saldo"
531:             .Column3.Header1.Caption = "Saldo"
532:             .Column4.ControlSource = "cursor_4c_TmpSaldg.Saldo - cursor_4c_TmpSaldg.Disps"
533:             .Column4.Header1.Caption = "Reservado"
534:             .Column5.ControlSource = "cursor_4c_TmpSaldg.Disps"
535:             .Column5.Header1.Caption = "Disponivel"
536:             .Column6.ControlSource = "cursor_4c_TmpSaldg.Priors"
537:             .Column6.Header1.Caption = "Prior"
538:             .Column6.ReadOnly = !THIS.this_lPermiteAjustarPrioridade()
539:         ENDWITH
540:         BINDEVENT(loc_oCnt.grd_4c_DispGrupo.Column6.Text1, "KeyPress", THIS, "GradeDispGrupoColumn6LostFocus")
541: 
542:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
543:         WITH loc_oCnt.lbl_4c_Label2
544:             .AutoSize = .F.
545:             .Top = 163
546:             .Left = 128
547:             .Width = 42
548:             .Height = 17
549:             .FontBold = .T.
550:             .BackStyle = 0
551:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 618 a 650:
618:             .ColumnCount = 6
619:             .RecordSource = "cursor_4c_TmpFabr"
620:             .RecordMark = .F.
621:             .DeleteMark = .F.
622:             .ReadOnly = .T.
623: 
624:             .Column1.ControlSource = "cursor_4c_TmpFabr.Fases"
625:             .Column1.Header1.Caption = "Fase"
626:             .Column2.ControlSource = "cursor_4c_TmpFabr.Qtds"
627:             .Column2.Header1.Caption = "Quantidade"
628:             .Column3.ControlSource = "cursor_4c_TmpFabr.Disps"
629:             .Column3.Header1.Caption = "Disponivel"
630:             .Column4.ControlSource = "cursor_4c_TmpFabr.Priors"
631:             .Column4.Header1.Caption = "Prior"
632:             .Column4.ReadOnly = !THIS.this_lPermiteAjustarPrioridade()
633:             .Column5.ControlSource = ""
634:             .Column5.Header1.Caption = ""
635:             .Column6.ControlSource = "cursor_4c_TmpFabr.Nops"
636:             .Column6.Header1.Caption = "Nop"
637:             .Column6.Visible = .F.
638:         ENDWITH
639:         BINDEVENT(loc_oCnt.grd_4c_DispFase.Column4.Text1, "KeyPress", THIS, "GradeDispFaseColumn4LostFocus")
640: 
641:         loc_oCnt.AddObject("lbl_4c_label22", "Label")
642:         WITH loc_oCnt.lbl_4c_label22
643:             .AutoSize = .F.
644:             .Top = 115
645:             .Left = 102
646:             .Width = 42
647:             .Height = 17
648:             .FontBold = .T.
649:             .BackStyle = 0
650:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 712 a 772:
712:             .Width = 108
713:             .Height = 19
714:             .ReadOnly = .T.
715:             .ControlSource = "TmpFinalg.Cpros"
716:         ENDWITH
717:         loc_oCnt.AddObject("lbl_4c_label13", "Label")
718:         WITH loc_oCnt.lbl_4c_label13
719:             .AutoSize = .F.
720:             .Top = 18
721:             .Left = 269
722:             .Width = 83
723:             .Height = 15
724:             .BackStyle = 0
725:             .ForeColor = RGB(90, 90, 90)
726:             .Caption = "Qtde Vendida :"
727:         ENDWITH
728:         loc_oCnt.AddObject("txt_4c_Tot_Venda", "TextBox")
729:         WITH loc_oCnt.txt_4c_Tot_Venda
730:             .Top = 17
731:             .Left = 349
732:             .Width = 80
733:             .Height = 19
734:             .InputMask = "999,999.99"
735:             .ReadOnly = .T.
736:             .ControlSource = "TmpFinalg.TotVenda"
737:         ENDWITH
738:         loc_oCnt.AddObject("lbl_4c_label23", "Label")
739:         WITH loc_oCnt.lbl_4c_label23
740:             .AutoSize = .F.
741:             .Top = 18
742:             .Left = 448
743:             .Width = 164
744:             .Height = 15
745:             .BackStyle = 0
746:             .ForeColor = RGB(90, 90, 90)
747:             .Caption = "Qtde M" + CHR(237) + "nima Para Produ" + CHR(231) + CHR(227) + "o :"
748:         ENDWITH
749:         loc_oCnt.AddObject("txt_4c_Minima", "TextBox")
750:         WITH loc_oCnt.txt_4c_Minima
751:             .Top = 17
752:             .Left = 623
753:             .Width = 80
754:             .Height = 19
755:             .InputMask = "999,999.99"
756:             .ReadOnly = .T.
757:             .ControlSource = "TmpFinalg.QtdMins"
758:         ENDWITH
759: 
760:         *-- Imagem do produto corrente (SigCdPro.FigJpgs) ------------------
761:         loc_oPag1.AddObject("img_4c_FigJpg", "Image")
762:         WITH loc_oPag1.img_4c_FigJpg
763:             .Top = 255
764:             .Left = 646
765:             .Width = 122
766:             .Height = 89
767:             .Stretch = 1
768:             .Visible = .F.
769:         ENDWITH
770:         BINDEVENT(loc_oPag1.img_4c_FigJpg, "DblClick", THIS, "ImgFigJpgPage1DblClick")
771: 
772:         *-- Totais gerais da pagina (soma de TmpFinalg) --------------------

*-- Linhas 957 a 1054:
957:         *-- cabeca de ConfigurarPaginaLista). Cursor de apoio so para modo
958:         *-- de teste de UI, com a MESMA estrutura exportada pelo pai.
959:         IF !USED("TmpFinal")
960:             CREATE CURSOR TmpFinal (Emps C(3), Dopes C(20), Numes N(6), CPros C(14), Qtds N(10,3), ;
961:                 Peso N(9,3), Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), Obs M NULL, ;
962:                 Obsps M NULL, Datas D NULL, Entregas D NULL, CodCors C(4), CodTams C(4), ;
963:                 Linhas C(10), Citens N(10), Reffs C(40), Notas C(6), Dpros C(40), GrupoDs C(10), ;
964:                 ContaDs C(10), KeySelM L, Fabrs N(10,3), KeyPdes L, Jobs C(10))
965:             INDEX ON Cpros + CodCors + CodTams TAG Cpros
966:         ENDIF
967: 
968:         *-- Grade de selecao de linha (GradeItens / TmpFinal). ControlSource
969:         *-- remapeado conforme SIGPRGLX.Init (dump 4279-4291) - NAO pela
970:         *-- ordem fisica de Column no SCX (ver nota do cabecalho do metodo).
971:         loc_oPag2.AddObject("grd_4c_Dados", "Grid")
972: 
973:         WITH loc_oPag2.grd_4c_Dados
974:             .Top          = 181
975:             .Left         = 53
976:             .Width        = 703
977:             .Height       = 189
978:             .FontName     = "Tahoma"
979:             .FontSize     = 8
980:             .RecordSource = ""
981:             .ColumnCount  = 10
982:             .RecordSource = "TmpFinal"
983:             .AllowHeaderSizing = .F.
984:             .AllowRowSizing    = .F.
985:             .RowHeight    = 17
986:             .GridLineColor = RGB(238, 238, 238)
987:             .RecordMark   = .F.
988:             .DeleteMark   = .F.
989:             .ReadOnly     = .F.
990: 
991:             .Column1.ControlSource = "TmpFinal.Cpros"
992:             .Column1.Header1.Caption = "Produto"
993:             .Column1.Width = 108
994:             .Column1.ReadOnly = .T.
995: 
996:             .Column2.ControlSource = "TmpFinal.CodCors"
997:             .Column2.Header1.Caption = "Cor"
998:             .Column2.Width = 38
999:             .Column2.ReadOnly = .T.
1000: 
1001:             .Column3.ControlSource = "TmpFinal.Dopes"
1002:             .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1003:             .Column3.Width = 150
1004:             .Column3.ReadOnly = .T.
1005: 
1006:             .Column4.ControlSource = "TmpFinal.Numes"
1007:             .Column4.Header1.Caption = "N" + CHR(250) + "mero"
1008:             .Column4.Width = 47
1009:             .Column4.ReadOnly = .T.
1010: 
1011:             .Column5.ControlSource = "TmpFinal.Saldo"
1012:             .Column5.Header1.Caption = "Quantidade"
1013:             .Column5.Width = 65
1014:             .Column5.ReadOnly = .T.
1015: 
1016:             .Column6.ControlSource = "TmpFinal.Produzir"
1017:             .Column6.Header1.Caption = "Produzir"
1018:             .Column6.Width = 65
1019:             .Column6.ReadOnly = .T.
1020: 
1021:             .Column7.ControlSource = "TmpFinal.Estoque"
1022:             .Column7.Header1.Caption = "Estoque"
1023:             .Column7.Width = 65
1024:             .Column7.ReadOnly = .F.
1025:             .Column7.BackColor = RGB(255, 255, 204)
1026:             .Column7.Text1.FontBold = .T.
1027:             .Column7.Text1.BackColor = RGB(255, 255, 204)
1028: 
1029:             .Column8.ControlSource = [IIF(!EMPTY(TmpFinal.Obsps), "*", "")]
1030:             .Column8.Header1.Caption = "Obs"
1031:             .Column8.Width = 21
1032:             .Column8.ReadOnly = .T.
1033: 
1034:             .Column9.ControlSource = "TmpFinal.CodTams"
1035:             .Column9.Header1.Caption = "Tam"
1036:             .Column9.Width = 38
1037:             .Column9.ReadOnly = .T.
1038: 
1039:             .Column10.ControlSource = "TmpFinal.Fabrs"
1040:             .Column10.Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
1041:             .Column10.Width = 65
1042:             .Column10.ReadOnly = .F.
1043:             .Column10.BackColor = RGB(255, 255, 204)
1044:             .Column10.Text1.FontBold = .T.
1045:             .Column10.Text1.BackColor = RGB(255, 255, 204)
1046:         ENDWITH
1047: 
1048:         *-- Cabecalhos: Tahoma 8, alinhado ao centro, azul - igual ao legado
1049:         *-- em todas as 10 colunas.
1050:         FOR loc_nCol = 1 TO 10
1051:             WITH EVALUATE("loc_oPag2.grd_4c_Dados.Column" + TRANSFORM(loc_nCol) + ".Header1")
1052:                 .FontName   = "Tahoma"
1053:                 .FontSize   = 8
1054:                 .Alignment  = 2

*-- Linhas 1232 a 1250:
1232:             .Width          = 396
1233:             .Height         = 69
1234:             .ReadOnly       = .T.
1235:             .ControlSource  = "TmpFinal.Obsps"
1236:         ENDWITH
1237: 
1238:         *-- Cancelar/Voltar da Page2 (volta para a grade principal - Page1 -
1239:         *-- apos validar que Estoque/Producao selecionados fecham com o que
1240:         *-- foi reservado nas sub-paginas; validacao real na fase de eventos).
1241:         loc_oPag2.AddObject("cmd_4c_Cancelar", "CommandButton")
1242:         WITH loc_oPag2.cmd_4c_Cancelar
1243:             .Top         = 12
1244:             .Left        = 704
1245:             .Width       = 75
1246:             .Height      = 75
1247:             .FontBold    = .T.
1248:             .FontItalic  = .T.
1249:             .FontName    = "Comic Sans MS"
1250:             .FontSize    = 8

*-- Linhas 1274 a 1309:
1274:     * pgf_4c_1.Top = -27 veio cru do SCX).
1275:     *
1276:     * cursor_4c_Linhas eh o cursor de apoio desta grade (TmpLinha no legado) -
1277:     * a estrutura aqui tem de bater EXATAMENTE com a do SELECT que a popula
1278:     * depois (regra do cursor de apoio / APPEND FROM casa por NOME).
1279:     *--------------------------------------------------------------------------
1280:     PROTECTED PROCEDURE ConfigurarPaginaTotaisLinha()
1281:         LOCAL loc_oPag3, loc_nCol
1282: 
1283:         loc_oPag3 = THIS.pgf_4c_1.Page3
1284: 
1285:         WITH loc_oPag3
1286:             .Caption   = "Totais por Linha"
1287:             .FontBold  = .T.
1288:             .ForeColor = RGB(0, 128, 192)
1289:             .Enabled   = .F.
1290:         ENDWITH
1291: 
1292:         SET NULL ON
1293:         IF !USED("cursor_4c_Linhas")
1294:             CREATE CURSOR cursor_4c_Linhas ;
1295:                 (Linhas C(10) NULL, Ordem N(1) NULL, Saldo N(12,3) NULL, ;
1296:                  Estoque N(12,3) NULL, Produzir N(12,3) NULL, Fabrs N(12,3) NULL)
1297:         ENDIF
1298:         SET NULL OFF
1299: 
1300:         *-- Titulo da sub-tela (Label2 + Shape4 no legado) ------------------
1301:         loc_oPag3.AddObject("lbl_4c_Label2", "Label")
1302:         WITH loc_oPag3.lbl_4c_Label2
1303:             .AutoSize   = .F.
1304:             .Top        = 147
1305:             .Left       = 173
1306:             .Width      = 157
1307:             .Height     = 25
1308:             .FontName   = "Tahoma"
1309:             .FontSize   = 14

*-- Linhas 1338 a 1403:
1338:             .RowHeight    = 16
1339:             .ScrollBars   = 2
1340:             .GridLineColor = RGB(238, 238, 238)
1341:             .DeleteMark   = .F.
1342:             .RecordMark   = .T.
1343:             .RecordSource = ""
1344:             .ColumnCount  = 5
1345:             .RecordSource = "cursor_4c_Linhas"
1346:             *-- Grid.ReadOnly propaga para as colunas: tem de vir ANTES delas.
1347:             .ReadOnly     = .T.
1348: 
1349:             .Column1.ControlSource = "cursor_4c_Linhas.Linhas"
1350:             .Column1.Header1.Caption = "Linha"
1351:             .Column1.Width     = 84
1352:             .Column1.Movable   = .F.
1353:             .Column1.Resizable = .F.
1354:             .Column1.Sparse    = .F.
1355:             .Column1.ReadOnly  = .T.
1356:             .Column1.ForeColor = RGB(36, 84, 155)
1357: 
1358:             .Column2.ControlSource = "cursor_4c_Linhas.Saldo"
1359:             .Column2.Header1.Caption = "Quantidade"
1360:             .Column2.Width     = 80
1361:             .Column2.Movable   = .F.
1362:             .Column2.Resizable = .F.
1363:             .Column2.Sparse    = .F.
1364:             .Column2.ReadOnly  = .T.
1365:             .Column2.Text1.InputMask = "999,999.99"
1366:             .Column2.Text1.MaxLength = 10
1367: 
1368:             .Column3.ControlSource = "cursor_4c_Linhas.Estoque"
1369:             .Column3.Header1.Caption = "Estoque"
1370:             .Column3.Width     = 80
1371:             .Column3.Movable   = .F.
1372:             .Column3.Resizable = .F.
1373:             .Column3.Sparse    = .F.
1374:             .Column3.ReadOnly  = .T.
1375:             .Column3.Text1.InputMask = "999,999.99"
1376:             .Column3.Text1.MaxLength = 10
1377: 
1378:             .Column4.ControlSource = "cursor_4c_Linhas.Fabrs"
1379:             .Column4.Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
1380:             .Column4.Width     = 80
1381:             .Column4.Movable   = .F.
1382:             .Column4.Resizable = .F.
1383:             .Column4.Sparse    = .F.
1384:             .Column4.ReadOnly  = .T.
1385:             .Column4.Text1.InputMask = "999,999.99"
1386:             .Column4.Text1.MaxLength = 10
1387: 
1388:             .Column5.ControlSource = "cursor_4c_Linhas.Produzir"
1389:             .Column5.Header1.Caption = "Produzir"
1390:             .Column5.Width     = 80
1391:             .Column5.Movable   = .F.
1392:             .Column5.Resizable = .F.
1393:             .Column5.Sparse    = .F.
1394:             .Column5.ReadOnly  = .T.
1395:             .Column5.Text1.InputMask = "999,999.99"
1396:             .Column5.Text1.MaxLength = 10
1397:         ENDWITH
1398: 
1399:         FOR loc_nCol = 1 TO 5
1400:             WITH EVALUATE("loc_oPag3.grd_4c_Linhas.Column" + TRANSFORM(loc_nCol) + ".Header1")
1401:                 .FontName  = "Tahoma"
1402:                 .FontSize  = 8
1403:                 .Alignment = 2

*-- Linhas 1461 a 1479:
1461: 
1462:         SET NULL ON
1463:         IF !USED("cursor_4c_DispEstoque")
1464:             CREATE CURSOR cursor_4c_DispEstoque ;
1465:                 (Priors N(2) NULL, Grupos C(10) NULL, Estos C(10) NULL, ;
1466:                  Cpros C(14) NULL, CodCors C(10) NULL, CodTams C(10) NULL, ;
1467:                  Disps N(12,3) NULL, Utilizar N(12,3) NULL)
1468:         ENDIF
1469:         SET NULL OFF
1470: 
1471:         *-- Titulo da sub-tela (Label1 + Shape4) ----------------------------
1472:         loc_oPag4.AddObject("lbl_4c_Label1", "Label")
1473:         WITH loc_oPag4.lbl_4c_Label1
1474:             .AutoSize   = .F.
1475:             .Top        = 138
1476:             .Left       = 197
1477:             .Width      = 184
1478:             .Height     = 25
1479:             .FontName   = "Tahoma"

*-- Linhas 1507 a 1580:
1507:             .Margin        = 0
1508:             .ReadOnly      = .T.
1509:             .ForeColor     = RGB(0, 0, 255)
1510:             .ControlSource = "TmpFinalg.Cpros"
1511:         ENDWITH
1512: 
1513:         *-- Grade de disponivel por grupo/conta (GradeDisp / TmpSaldG) ------
1514:         loc_oPag4.AddObject("grd_4c_DispEstoque", "Grid")
1515: 
1516:         WITH loc_oPag4.grd_4c_DispEstoque
1517:             .Top          = 169
1518:             .Left         = 191
1519:             .Width        = 370
1520:             .Height       = 244
1521:             .FontSize     = 8
1522:             .AllowHeaderSizing = .F.
1523:             .AllowRowSizing    = .F.
1524:             .RowHeight    = 16
1525:             .ScrollBars   = 2
1526:             .GridLineColor = RGB(238, 238, 238)
1527:             .DeleteMark   = .F.
1528:             .RecordMark   = .T.
1529:             .Panel        = 1
1530:             .RecordSource = ""
1531:             .ColumnCount  = 5
1532:             .RecordSource = "cursor_4c_DispEstoque"
1533:             *-- Grid.ReadOnly ANTES das colunas: ele propaga e sobrescreveria
1534:             *-- o ReadOnly = .F. da coluna Utilizar.
1535:             .ReadOnly     = .F.
1536: 
1537:             .Column1.ControlSource = "cursor_4c_DispEstoque.Grupos"
1538:             .Column1.Header1.Caption = "Grupo"
1539:             .Column1.Width     = 80
1540:             .Column1.Movable   = .F.
1541:             .Column1.Resizable = .F.
1542:             .Column1.ReadOnly  = .T.
1543: 
1544:             .Column2.ControlSource = "cursor_4c_DispEstoque.Estos"
1545:             .Column2.Header1.Caption = "Conta"
1546:             .Column2.Width     = 80
1547:             .Column2.Movable   = .F.
1548:             .Column2.Resizable = .F.
1549:             .Column2.ReadOnly  = .T.
1550: 
1551:             .Column3.ControlSource = "cursor_4c_DispEstoque.Priors"
1552:             .Column3.Header1.Caption = "Prior"
1553:             .Column3.Width     = 24
1554:             .Column3.Movable   = .F.
1555:             .Column3.Resizable = .F.
1556:             .Column3.ReadOnly  = .T.
1557: 
1558:             .Column4.ControlSource = "cursor_4c_DispEstoque.Disps"
1559:             .Column4.Header1.Caption = "Disponivel"
1560:             .Column4.Width     = 75
1561:             .Column4.Movable   = .F.
1562:             .Column4.Resizable = .F.
1563:             .Column4.ReadOnly  = .T.
1564: 
1565:             .Column5.ControlSource = "cursor_4c_DispEstoque.Utilizar"
1566:             .Column5.Header1.Caption = "Utilizar"
1567:             .Column5.Width     = 75
1568:             .Column5.Movable   = .F.
1569:             .Column5.Resizable = .F.
1570:             .Column5.ReadOnly  = .F.
1571:             .Column5.Text1.FontBold = .T.
1572:         ENDWITH
1573:         BINDEVENT(loc_oPag4.grd_4c_DispEstoque.Column5.Text1, "Valid", THIS, "GradeDispEstoqueColumn5Valid")
1574:         BINDEVENT(loc_oPag4.grd_4c_DispEstoque.Column5.Text1, "KeyPress", THIS, "GradeDispColumn5LostFocus")
1575: 
1576:         FOR loc_nCol = 1 TO 5
1577:             WITH EVALUATE("loc_oPag4.grd_4c_DispEstoque.Column" + TRANSFORM(loc_nCol) + ".Header1")
1578:                 .FontName  = "Verdana"
1579:                 .FontSize  = 8
1580:                 .Alignment = 2

*-- Linhas 1682 a 1700:
1682: 
1683:         SET NULL ON
1684:         IF !USED("cursor_4c_DispTamanho")
1685:             CREATE CURSOR cursor_4c_DispTamanho ;
1686:                 (Cpros C(14) NULL, CodCors C(10) NULL, CodTams C(10) NULL, ;
1687:                  Disps N(12,3) NULL, Utilizar N(12,3) NULL)
1688:         ENDIF
1689:         SET NULL OFF
1690: 
1691:         loc_oPag5.AddObject("lbl_4c_Label1", "Label")
1692:         WITH loc_oPag5.lbl_4c_Label1
1693:             .AutoSize   = .F.
1694:             .Top        = 150
1695:             .Left       = 246
1696:             .Width      = 205
1697:             .Height     = 25
1698:             .FontName   = "Tahoma"
1699:             .FontSize   = 14
1700:             .FontBold   = .T.

*-- Linhas 1723 a 1796:
1723:             .Margin        = 0
1724:             .ReadOnly      = .T.
1725:             .ForeColor     = RGB(0, 0, 255)
1726:             .ControlSource = "TmpFinalg.Cpros"
1727:         ENDWITH
1728: 
1729:         loc_oPag5.AddObject("grd_4c_DispTamanho", "Grid")
1730: 
1731:         WITH loc_oPag5.grd_4c_DispTamanho
1732:             .Top          = 181
1733:             .Left         = 239
1734:             .Width        = 327
1735:             .Height       = 228
1736:             .FontName     = "Tahoma"
1737:             .FontSize     = 8
1738:             .AllowHeaderSizing = .F.
1739:             .AllowRowSizing    = .F.
1740:             .RowHeight    = 16
1741:             .ScrollBars   = 2
1742:             .GridLineColor = RGB(238, 238, 238)
1743:             .DeleteMark   = .F.
1744:             .RecordMark   = .T.
1745:             .Panel        = 1
1746:             .RecordSource = ""
1747:             .ColumnCount  = 5
1748:             .RecordSource = "cursor_4c_DispTamanho"
1749:             .ReadOnly     = .F.
1750: 
1751:             .Column1.ControlSource = "cursor_4c_DispTamanho.Cpros"
1752:             .Column1.Header1.Caption = "Produto"
1753:             .Column1.Width     = 80
1754:             .Column1.Movable   = .F.
1755:             .Column1.Resizable = .F.
1756:             .Column1.ReadOnly  = .T.
1757: 
1758:             .Column2.ControlSource = "cursor_4c_DispTamanho.CodCors"
1759:             .Column2.Header1.Caption = "Cor"
1760:             .Column2.Width     = 38
1761:             .Column2.Movable   = .F.
1762:             .Column2.Resizable = .F.
1763:             .Column2.ReadOnly  = .T.
1764:             .Column2.Text1.FontBold = .T.
1765: 
1766:             .Column3.ControlSource = "cursor_4c_DispTamanho.CodTams"
1767:             .Column3.Header1.Caption = "Tam"
1768:             .Column3.Width     = 24
1769:             .Column3.Movable   = .F.
1770:             .Column3.Resizable = .F.
1771:             .Column3.ReadOnly  = .T.
1772:             .Column3.Text1.FontBold = .T.
1773: 
1774:             .Column4.ControlSource = "cursor_4c_DispTamanho.Disps"
1775:             .Column4.Header1.Caption = "Disponivel"
1776:             .Column4.Width     = 75
1777:             .Column4.Movable   = .F.
1778:             .Column4.Resizable = .F.
1779:             .Column4.ReadOnly  = .T.
1780: 
1781:             .Column5.ControlSource = "cursor_4c_DispTamanho.Utilizar"
1782:             .Column5.Header1.Caption = "Utilizar"
1783:             .Column5.Width     = 75
1784:             .Column5.Movable   = .F.
1785:             .Column5.Resizable = .F.
1786:             .Column5.ReadOnly  = .F.
1787:             .Column5.Text1.FontBold = .T.
1788:         ENDWITH
1789:         BINDEVENT(loc_oPag5.grd_4c_DispTamanho.Column5.Text1, "Valid", THIS, "GradeDispTamanhoColumn5Valid")
1790:         BINDEVENT(loc_oPag5.grd_4c_DispTamanho.Column5.Text1, "KeyPress", THIS, "GradeDispColumn5LostFocus")
1791: 
1792:         FOR loc_nCol = 1 TO 5
1793:             WITH EVALUATE("loc_oPag5.grd_4c_DispTamanho.Column" + TRANSFORM(loc_nCol) + ".Header1")
1794:                 .FontName  = "Verdana"
1795:                 .FontSize  = 8
1796:                 .Alignment = 2

*-- Linhas 1910 a 1939:
1910: 
1911:         SET NULL ON
1912:         IF !USED("cursor_4c_Requisicao")
1913:             CREATE CURSOR cursor_4c_Requisicao ;
1914:                 (Cpros C(14) NULL, Dpros C(65) NULL, Cunis C(3) NULL, ;
1915:                  Qtds N(12,3) NULL, Cpro2s C(14) NULL)
1916:         ENDIF
1917:         SET NULL OFF
1918: 
1919:         *-- Linha em branco inicial (Init legado: If Reccount('SelPedra') = 0
1920:         *-- / Append Blank) - sem ela a grade abre sem nenhuma celula onde
1921:         *-- digitar o primeiro material.
1922:         IF USED("cursor_4c_Requisicao")
1923:             IF RECCOUNT("cursor_4c_Requisicao") = 0
1924:                 SELECT cursor_4c_Requisicao
1925:                 APPEND BLANK
1926:                 REPLACE Cpros WITH "", Dpros WITH "", Cunis WITH "", ;
1927:                         Qtds  WITH 0,  Cpro2s WITH "" IN cursor_4c_Requisicao
1928:                 GO TOP IN cursor_4c_Requisicao
1929:             ENDIF
1930:         ENDIF
1931: 
1932:         *-- Titulo da sub-tela (Label1 + Shape4) ----------------------------
1933:         loc_oPag6.AddObject("lbl_4c_Label1", "Label")
1934:         WITH loc_oPag6.lbl_4c_Label1
1935:             .AutoSize   = .F.
1936:             .Top        = 168
1937:             .Left       = 132
1938:             .Width      = 294
1939:             .Height     = 25

*-- Linhas 1966 a 2058:
1966:             .Margin        = 0
1967:             .ReadOnly      = .T.
1968:             .ForeColor     = RGB(0, 0, 255)
1969:             .ControlSource = "TmpFinalg.Cpros"
1970:         ENDWITH
1971: 
1972:         *-- Grade de requisicao manual (GradePedra / SelPedra) --------------
1973:         loc_oPag6.AddObject("grd_4c_Pedra", "Grid")
1974: 
1975:         WITH loc_oPag6.grd_4c_Pedra
1976:             .Top          = 197
1977:             .Left         = 119
1978:             .Width        = 500
1979:             .Height       = 261
1980:             .FontSize     = 8
1981:             .RowHeight    = 16
1982:             .ScrollBars   = 2
1983:             .GridLineColor = RGB(238, 238, 238)
1984:             .DeleteMark   = .F.
1985:             .RecordMark   = .T.
1986:             .RecordSource = ""
1987:             .ColumnCount  = 5
1988:             .RecordSource = "cursor_4c_Requisicao"
1989:             *-- Grid.ReadOnly ANTES das colunas: propaga e sobrescreveria o
1990:             *-- ReadOnly = .F. das colunas digitaveis (1, 4 e 5).
1991:             .ReadOnly     = .F.
1992: 
1993:             .Column1.ControlSource = "cursor_4c_Requisicao.Cpros"
1994:             .Column1.Header1.Caption = "Produto"
1995:             .Column1.Width     = 80
1996:             .Column1.Movable   = .F.
1997:             .Column1.Resizable = .F.
1998:             .Column1.ReadOnly  = .F.
1999:             .Column1.Text1.BorderStyle = 0
2000:             .Column1.Text1.Margin      = 0
2001:             .Column1.Text1.MaxLength   = 14
2002:             .Column1.Text1.ForeColor   = RGB(0, 0, 0)
2003:             .Column1.Text1.BackColor   = RGB(255, 255, 255)
2004:             .Column1.Text1.ToolTipText = "F4 ou duplo clique: buscar produto"
2005: 
2006:             .Column2.ControlSource = "cursor_4c_Requisicao.Dpros"
2007:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2008:             .Column2.Width     = 200
2009:             .Column2.Movable   = .F.
2010:             .Column2.Resizable = .F.
2011:             .Column2.ReadOnly  = .T.
2012:             .Column2.Text1.FontBold    = .T.
2013:             .Column2.Text1.BorderStyle = 0
2014:             .Column2.Text1.Margin      = 0
2015:             .Column2.Text1.ReadOnly    = .T.
2016:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
2017:             .Column2.Text1.BackColor   = RGB(255, 255, 255)
2018: 
2019:             .Column3.ControlSource = "cursor_4c_Requisicao.Cunis"
2020:             .Column3.Header1.Caption = "Uni"
2021:             .Column3.Width     = 30
2022:             .Column3.Movable   = .F.
2023:             .Column3.Resizable = .F.
2024:             .Column3.ReadOnly  = .T.
2025:             .Column3.Text1.FontBold    = .T.
2026:             .Column3.Text1.BorderStyle = 0
2027:             .Column3.Text1.Margin      = 0
2028:             .Column3.Text1.ReadOnly    = .T.
2029:             .Column3.Text1.ForeColor   = RGB(0, 0, 0)
2030:             .Column3.Text1.BackColor   = RGB(255, 255, 255)
2031: 
2032:             .Column4.ControlSource = "cursor_4c_Requisicao.Qtds"
2033:             .Column4.Header1.Caption = "Qtde"
2034:             .Column4.Width     = 75
2035:             .Column4.Movable   = .F.
2036:             .Column4.Resizable = .F.
2037:             .Column4.ReadOnly  = .F.
2038:             .Column4.Text1.BorderStyle = 0
2039:             .Column4.Text1.Margin      = 0
2040:             .Column4.Text1.ForeColor   = RGB(0, 0, 0)
2041:             .Column4.Text1.BackColor   = RGB(255, 255, 255)
2042: 
2043:             .Column5.ControlSource = "cursor_4c_Requisicao.Cpro2s"
2044:             .Column5.Header1.Caption = "Produto"
2045:             .Column5.Width     = 80
2046:             .Column5.Movable   = .F.
2047:             .Column5.Resizable = .F.
2048:             .Column5.ReadOnly  = .F.
2049:             .Column5.Text1.BorderStyle = 0
2050:             .Column5.Text1.Margin      = 0
2051:             .Column5.Text1.MaxLength   = 14
2052:             .Column5.Text1.ForeColor   = RGB(0, 0, 0)
2053:             .Column5.Text1.BackColor   = RGB(255, 255, 255)
2054:             .Column5.Text1.ToolTipText = "F4 ou duplo clique: buscar produto substituto"
2055:         ENDWITH
2056: 
2057:         FOR loc_nCol = 1 TO 5
2058:             WITH EVALUATE("loc_oPag6.grd_4c_Pedra.Column" + TRANSFORM(loc_nCol) + ".Header1")

*-- Linhas 2142 a 2160:
2142:     *
2143:     * O Replace de Dpros/Cunis eh o que preenche as colunas Descricao e Uni,
2144:     * que sao ReadOnly e nao tem outra origem - sem ele a linha fica so com
2145:     * o codigo. Cunis vem junto do mesmo SELECT (por isso o lookup consulta
2146:     * CPros/DPros/Cunis, mesmo exibindo so as duas primeiras no picker,
2147:     * exatamente como o legado, cujo fwBuscaExt traz a linha inteira).
2148:     *--------------------------------------------------------------------------
2149:     PROCEDURE AbrirLookupProdutoRequisicao()
2150:         LOCAL loc_oBusca, loc_cValor, loc_oErro
2151:         LOCAL loc_oGrade, loc_oCampo
2152: 
2153:         IF THIS.this_lLookupEmCurso
2154:             RETURN
2155:         ENDIF
2156:         THIS.this_lLookupEmCurso = .T.
2157: 
2158:         TRY
2159:             loc_oGrade = THIS.pgf_4c_1.Page6.grd_4c_Pedra
2160:             loc_oCampo = loc_oGrade.Column1.Text1

*-- Linhas 2327 a 2367:
2327:     * GarantirLinhaLivreRequisicao - transcricao do LostFocus de
2328:     * SIGPRGLX.PageDados.Page6.GradePedra.Column5.Text1:
2329:     *
2330:     *   SELECT SelPedra
2331:     *   xPosicao = RECNO()
2332:     *   Locate For Empty(Cpros)
2333:     *   If Eof()
2334:     *       Append Blank
2335:     *   EndIf
2336:     *   Locate for Recno() = xPosicao
2337:     *
2338:     * Mantem sempre ao menos uma linha em branco disponivel na grade e
2339:     * devolve o ponteiro para onde o usuario estava. O KEYBOARD '{DNARROW}'
2340:     * do legado (que empurra o cursor para a linha de baixo) nao eh
2341:     * reproduzido aqui: la ele vinha do LostFocus real da celula; neste
2342:     * ponto o foco ja voltou do picker e o salto adicional tiraria o
2343:     * usuario da linha que ele acabou de preencher.
2344:     *--------------------------------------------------------------------------
2345:     PROTECTED PROCEDURE GarantirLinhaLivreRequisicao()
2346:         LOCAL loc_nPosicao
2347: 
2348:         IF !USED("cursor_4c_Requisicao")
2349:             RETURN
2350:         ENDIF
2351: 
2352:         SELECT cursor_4c_Requisicao
2353:         loc_nPosicao = RECNO()
2354: 
2355:         LOCATE FOR EMPTY(cursor_4c_Requisicao.Cpros)
2356:         IF EOF("cursor_4c_Requisicao")
2357:             APPEND BLANK
2358:             REPLACE Cpros WITH "", Dpros WITH "", Cunis WITH "", ;
2359:                     Qtds  WITH 0,  Cpro2s WITH "" IN cursor_4c_Requisicao
2360:         ENDIF
2361: 
2362:         IF loc_nPosicao > 0 AND loc_nPosicao <= RECCOUNT("cursor_4c_Requisicao")
2363:             GOTO loc_nPosicao IN cursor_4c_Requisicao
2364:         ENDIF
2365:     ENDPROC
2366: 
2367:     *--------------------------------------------------------------------------

*-- Linhas 2440 a 2458:
2440:         ENDIF
2441: 
2442:         IF !SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
2443:             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2444:         ENDIF
2445:         IF loc_nValorNovo != THIS.this_nOldValue AND TmpSaldU.KeySelmp
2446:             IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de OP." + CHR(13) + ;
2447:                     "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", ;
2448:                     "Confirmar")
2449:                 loc_oCampo.Value = THIS.this_nOldValue
2450:                 RETURN
2451:             ENDIF
2452:         ENDIF
2453: 
2454:         loc_lOk = .T.
2455:         DO CASE
2456:             CASE loc_nValorNovo = THIS.this_nOldValue
2457:                 * nada a fazer
2458:             CASE loc_nValorNovo < 0

*-- Linhas 2474 a 2539:
2474:                     REPLACE DispFs WITH Fabrs - loc_nValorNovo IN cursor_4c_TmpSaldo
2475:                     REPLACE Produzir WITH Saldo - Estoque - loc_nValorNovo IN TmpFinalg
2476: 
2477:                     SELECT TmpFinalg
2478:                     REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
2479:                             QtdMins - Produzir, 0), ;
2480:                             UsuLibs WITH " " IN TmpFinalg
2481: 
2482:                     REPLACE KeySelmp WITH .F. IN TmpSaldU
2483: 
2484:                     SELECT cursor_4c_TmpSaldo
2485:                     loc_nXBaixa = Fabrs - DispFs
2486:                     SELECT cursor_4c_TmpFabr
2487:                     SET ORDER TO Cpros
2488:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2489:                     REPLACE Disps WITH 0 WHILE cursor_4c_TmpFabr.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2490:                             cursor_4c_TmpFabr.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2491:                             cursor_4c_TmpFabr.CodTams = cursor_4c_TmpSaldo.CodTams
2492:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2493:                     SCAN WHILE cursor_4c_TmpFabr.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2494:                             cursor_4c_TmpFabr.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2495:                             cursor_4c_TmpFabr.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
2496:                         IF (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps) >= loc_nXBaixa
2497:                             REPLACE cursor_4c_TmpFabr.Disps WITH cursor_4c_TmpFabr.Disps + loc_nXBaixa
2498:                             loc_nXBaixa = 0
2499:                         ELSE
2500:                             loc_nXBaixa = loc_nXBaixa - (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps)
2501:                             REPLACE cursor_4c_TmpFabr.Disps WITH cursor_4c_TmpFabr.Qtds
2502:                         ENDIF
2503:                         SELECT cursor_4c_TmpFabr
2504:                     ENDSCAN
2505: 
2506:                     loc_nXBaixa = loc_nValorNovo
2507:                     SELECT TmpFinal
2508:                     SET ORDER TO
2509:                     SET ORDER TO Cpros
2510:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2511:                     REPLACE Fabrs WITH 0 WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2512:                             TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams
2513:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2514:                     SCAN WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors ;
2515:                             AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa >= 0
2516:                         IF (TmpFinal.Saldo - TmpFinal.Estoque) >= loc_nXBaixa
2517:                             REPLACE TmpFinal.Fabrs WITH TmpFinal.Fabrs + loc_nXBaixa
2518:                             loc_nXBaixa = 0
2519:                         ELSE
2520:                             loc_nXBaixa = loc_nXBaixa - (TmpFinal.Saldo - TmpFinal.Estoque)
2521:                             REPLACE TmpFinal.Fabrs WITH (TmpFinal.Saldo - TmpFinal.Estoque)
2522:                         ENDIF
2523:                         REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
2524:                         SELECT TmpFinal
2525:                     ENDSCAN
2526:                 ELSE
2527:                     MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto Em " + ;
2528:                         "Produ" + CHR(231) + CHR(227) + "o para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
2529:                     loc_lOk = .F.
2530:                 ENDIF
2531:         ENDCASE
2532: 
2533:         IF !loc_lOk
2534:             loc_oCampo.Value = THIS.this_nOldValue
2535:         ENDIF
2536:     ENDPROC
2537: 
2538:     *--------------------------------------------------------------------------
2539:     * GradeItensPage1Column10Valid - transcricao de GradeItens.Column10.Text1.

*-- Linhas 2568 a 2586:
2568:         ENDIF
2569: 
2570:         IF !SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
2571:             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2572:         ENDIF
2573:         IF loc_nValorNovo != THIS.this_nOldValue AND TmpSaldU.KeySelm
2574:             IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque." + CHR(13) + ;
2575:                     "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", ;
2576:                     "Confirmar")
2577:                 loc_oCampo.Value = THIS.this_nOldValue
2578:                 RETURN
2579:             ENDIF
2580:         ENDIF
2581: 
2582:         loc_lOk = .T.
2583:         DO CASE
2584:             CASE loc_nValorNovo = THIS.this_nOldValue
2585:                 * nada a fazer
2586:             CASE loc_nValorNovo < 0

*-- Linhas 2602 a 2683:
2602:                     REPLACE Disps WITH Saldo - loc_nValorNovo IN cursor_4c_TmpSaldo
2603:                     REPLACE Produzir WITH Saldo - Fabrs - loc_nValorNovo IN TmpFinalg
2604: 
2605:                     SELECT TmpFinalg
2606:                     REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
2607:                             QtdMins - Produzir, 0), ;
2608:                             UsuLibs WITH " " IN TmpFinalg
2609: 
2610:                     REPLACE KeySelm WITH .F. IN TmpSaldU
2611: 
2612:                     SELECT cursor_4c_TmpSaldo
2613:                     loc_nXBaixa = Saldo - Disps
2614: 
2615:                     SELECT cursor_4c_TmpSaldg
2616:                     SET ORDER TO CPros
2617:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2618:                     REPLACE Disps WITH Saldo WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2619:                             cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2620:                             cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams
2621:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2622:                     SCAN WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2623:                             cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2624:                             cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
2625:                         IF cursor_4c_TmpSaldg.Disps >= loc_nXBaixa
2626:                             REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldg.Disps - loc_nXBaixa
2627:                             loc_nXBaixa = 0
2628:                         ELSE
2629:                             loc_nXBaixa = loc_nXBaixa - cursor_4c_TmpSaldg.Disps
2630:                             REPLACE cursor_4c_TmpSaldg.Disps WITH 0
2631:                         ENDIF
2632:                         SELECT cursor_4c_TmpSaldg
2633:                     ENDSCAN
2634: 
2635:                     loc_nXBaixa = loc_nValorNovo
2636:                     SELECT TmpFinal
2637:                     SET ORDER TO
2638:                     SET ORDER TO Cpros
2639:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2640:                     REPLACE Estoque WITH 0 WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2641:                             TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2642:                             TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams
2643:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2644:                     SCAN WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2645:                             TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2646:                             TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
2647:                         IF (TmpFinal.Saldo - TmpFinal.Fabrs) >= loc_nXBaixa
2648:                             REPLACE TmpFinal.Estoque WITH TmpFinal.Estoque + loc_nXBaixa IN TmpFinal
2649:                             loc_nXBaixa = 0
2650:                         ELSE
2651:                             loc_nXBaixa = loc_nXBaixa - (TmpFinal.Saldo - TmpFinal.Fabrs)
2652:                             REPLACE TmpFinal.Estoque WITH (TmpFinal.Saldo - TmpFinal.Fabrs) IN TmpFinal
2653:                         ENDIF
2654:                         REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
2655:                         SELECT TmpFinal
2656:                     ENDSCAN
2657:                 ELSE
2658:                     MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto no " + ;
2659:                         "estoque para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
2660:                     loc_lOk = .F.
2661:                 ENDIF
2662:         ENDCASE
2663: 
2664:         IF !loc_lOk
2665:             loc_oCampo.Value = THIS.this_nOldValue
2666:         ENDIF
2667: 
2668:         SELECT TmpFinalg
2669:     ENDPROC
2670: 
2671:     *--------------------------------------------------------------------------
2672:     * AtualizarVisibilidadeDisponivel - "When" de GradeItens.Column10.Text1
2673:     * (Page1, dump 7029-7043): o botao "Disponiveis" so aparece quando o
2674:     * form esta em modo RESERVA, o item corrente ainda nao tem estoque
2675:     * reservado e o GRUPO do produto eh de tipo de estoque 3 ou 4.
2676:     *
2677:     *   ThisForm.PageDados.Page1.Disponivel.Visible = .f.
2678:     *   If ThisForm.Reserva And TmpFinalg.Estoque = 0
2679:     *       ... CursorQuery SigCdPro -> Cgrus -> SigCdGrp -> TipoEstos
2680:     *       If InList(CrSigCdGrp.TipoEstos,3,4) -> Visible = .t.
2681:     *
2682:     * Vive num metodo proprio, chamado de AfterRowColChange (troca de item)
2683:     * e de CarregarLista (primeira linha), porque BINDEVENT em "When" de

*-- Linhas 2736 a 2754:
2736:             RETURN
2737:         ENDIF
2738: 
2739:         SELECT TmpFinalg
2740:         loc_nRecno = RECNO()
2741:         SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
2742:         IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("TmpFinalg")
2743:             GOTO loc_nRecno
2744:         ENDIF
2745: 
2746:         WITH THIS.pgf_4c_1.Page1
2747:             .txt_4c_Tot_Qtd.Value  = loc_nSal
2748:             .txt_4c_Tot_Est.Value  = loc_nEst
2749:             .txt_4c_Tot_prdc.Value = loc_nPrc
2750:             .txt_4c_Tot_Prz.Value  = loc_nPrz
2751:             .txt_4c_Tot_prze.Value = loc_nPrze
2752:             .txt_4c_Tot_Qtd.Refresh()
2753:             .txt_4c_Tot_Est.Refresh()
2754:             .txt_4c_Tot_prdc.Refresh()

*-- Linhas 2798 a 2833:
2798:         *-- ao SET EXACT. Mesmo remedio ja adotado no irmao FormSigPrGlp.
2799:         loc_cFiltro = "Cpros + CodCors + CodTams == [" + loc_cChave + "]"
2800: 
2801:         SELECT cursor_4c_TmpSaldg
2802:         SET ORDER TO CPros
2803:         SET KEY TO
2804:         SET FILTER TO &loc_cFiltro
2805:         GO TOP
2806: 
2807:         WITH loc_oPag1.cnt_4c_Container3
2808:             .txt_4c_Tot_Qtd.Value = TratarNulo(cursor_4c_TmpSaldo.Saldo, 0)
2809:             .txt_4c_Tot_Est.Value = TratarNulo(cursor_4c_TmpSaldo.Saldo, 0) - TratarNulo(cursor_4c_TmpSaldo.Disps, 0)
2810:             .txt_4c_Tot_Prz.Value = TratarNulo(cursor_4c_TmpSaldo.Disps, 0)
2811:             .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel " + ALLTRIM(TmpFinalg.Cpros) + ;
2812:                 IIF(!EMPTY(TmpFinalg.CodCors), " Cor:" + ALLTRIM(TmpFinalg.CodCors), "") + ;
2813:                 IIF(!EMPTY(TmpFinalg.CodTams), " Tam:" + ALLTRIM(TmpFinalg.CodTams), "")
2814:             .grd_4c_DispGrupo.Refresh()
2815:             .Visible     = .T.
2816:         ENDWITH
2817: 
2818:         SELECT cursor_4c_TmpFabr
2819:         SET ORDER TO Cpros
2820:         SET KEY TO
2821:         SET FILTER TO &loc_cFiltro
2822:         GO TOP
2823: 
2824:         WITH loc_oPag1.cnt_4c_Container1
2825:             .txt_4c_Tot_Qtd.Value = TratarNulo(cursor_4c_TmpSaldo.Fabrs, 0)
2826:             .txt_4c_Tot_Est.Value = TratarNulo(cursor_4c_TmpSaldo.Fabrs, 0) - TratarNulo(cursor_4c_TmpSaldo.DispFs, 0)
2827:             .grd_4c_DispFase.Refresh()
2828:             .Visible     = .T.
2829:         ENDWITH
2830: 
2831:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2832:             loc_cArquivo = ADDBS(SYS(2023)) + "TempGlb_" + SYS(3) + ".jpg"
2833:             loc_oPag1.img_4c_FigJpg.Picture = ""

*-- Linhas 2841 a 2859:
2841:         *-- "Disponiveis" eh decidido POR ITEM (When de Column10 no legado)
2842:         THIS.AtualizarVisibilidadeDisponivel()
2843: 
2844:         SELECT TmpFinalg
2845:     ENDPROC
2846: 
2847:     *--------------------------------------------------------------------------
2848:     * GradeDispGrupoColumn6LostFocus / GradeDispFaseColumn4LostFocus -
2849:     * "Skip / Skip -1 / Grid.Refresh" do legado (dump 4439-4444, 6625-6630,
2850:     * 6647-6654): forca a grade a repintar apos editar a coluna Prior.
2851:     *--------------------------------------------------------------------------
2852:     PROCEDURE GradeDispGrupoColumn6LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2853:         THIS.pgf_4c_1.Page1.cnt_4c_Container3.grd_4c_DispGrupo.Refresh()
2854:     ENDPROC
2855: 
2856:     PROCEDURE GradeDispFaseColumn4LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2857:         THIS.pgf_4c_1.Page1.cnt_4c_Container1.grd_4c_DispFase.Refresh()
2858:     ENDPROC
2859: 

*-- Linhas 2899 a 2917:
2899:     * GradeItensPage2Column7Valid / Column10Valid - transcricao de
2900:     * GradeItens.Column7/Column10.Text1.Valid da Page2 (dump 7357-7379,
2901:     * 7477-7499): validacao PURA de faixa (sem redistribuicao - o
2902:     * ControlSource do Grid ja grava o valor em TmpFinal.Estoque/Fabrs).
2903:     *--------------------------------------------------------------------------
2904:     PROCEDURE GradeItensPage2Column7Valid()
2905:         LOCAL loc_oCampo, loc_nPSaldo
2906: 
2907:         loc_oCampo = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column7.Text1
2908:         loc_nPSaldo = THIS.pgf_4c_1.Page2.txt_4c_Tot_sEst.Value
2909: 
2910:         IF !USED("TmpFinal") OR EOF("TmpFinal") OR loc_oCampo.Value = THIS.this_nOldValue
2911:             RETURN
2912:         ENDIF
2913: 
2914:         DO CASE
2915:             CASE loc_oCampo.Value < 0
2916:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
2917:                 loc_oCampo.Value = THIS.this_nOldValue

*-- Linhas 2964 a 2982:
2964:             RETURN
2965:         ENDIF
2966: 
2967:         SELECT TmpFinal
2968:         loc_nRecno = RECNO()
2969:         SUM Saldo, Estoque, Produzir, Fabrs TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
2970:         IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("TmpFinal")
2971:             GOTO loc_nRecno
2972:         ENDIF
2973: 
2974:         WITH THIS.pgf_4c_1.Page2
2975:             .txt_4c_Tot_Qtd.Value = loc_nSal
2976:             .txt_4c_Tot_Est.Value = loc_nEst
2977:             .txt_4c_Tot_prc.Value = loc_nPrc
2978:             .txt_4c_Tot_Prz.Value = loc_nPrz
2979:             .txt_4c_Tot_Qtd.Refresh()
2980:             .txt_4c_Tot_Est.Refresh()
2981:             .txt_4c_Tot_prc.Refresh()
2982:             .txt_4c_Tot_Prz.Refresh()

*-- Linhas 3013 a 3031:
3013:             ENDIF
3014:         ENDIF
3015: 
3016:         SELECT TmpFinal
3017:     ENDPROC
3018: 
3019:     *--------------------------------------------------------------------------
3020:     * GradeDispEstoqueColumn5Valid / GradeDispTamanhoColumn5Valid -
3021:     * transcricao de Page4/Page5.GradeDisp.Column5.Text1.Valid (dump
3022:     * 7754-7785, 8030-8057): valida a quantidade "Utilizar" contra o
3023:     * disponivel da linha e contra o saldo total ainda nao atendido
3024:     * (Qt_pedida), e atualiza Qt_Selec com a soma de Utilizar da grade.
3025:     *--------------------------------------------------------------------------
3026:     PROCEDURE GradeDispEstoqueColumn5Valid()
3027:         LOCAL loc_oCampo, loc_nPSaldo, loc_nQtdUti, loc_nRecno
3028: 
3029:         loc_oCampo = THIS.pgf_4c_1.Page4.grd_4c_DispEstoque.Column5.Text1
3030: 
3031:         IF !USED("TmpFinalg") OR EOF("TmpFinalg") OR !USED("cursor_4c_DispEstoque")

*-- Linhas 3048 a 3066:
3048:         ENDIF
3049: 
3050:         loc_nRecno = RECNO("cursor_4c_DispEstoque")
3051:         SELECT cursor_4c_DispEstoque
3052:         SUM Utilizar TO loc_nQtdUti
3053:         IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("cursor_4c_DispEstoque")
3054:             GOTO loc_nRecno
3055:         ENDIF
3056: 
3057:         IF loc_nQtdUti > loc_nPSaldo
3058:             MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Solicitada...", "Aten" + CHR(231) + CHR(227) + "o")
3059:             loc_oCampo.Value = 0
3060:             loc_oCampo.Refresh()
3061:             RETURN
3062:         ENDIF
3063: 
3064:         THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Value = loc_nQtdUti
3065:         THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Refresh()
3066:     ENDPROC

*-- Linhas 3084 a 3102:
3084:         ENDIF
3085: 
3086:         loc_nRecno = RECNO("cursor_4c_DispTamanho")
3087:         SELECT cursor_4c_DispTamanho
3088:         SUM Utilizar TO loc_nQtdUti
3089:         IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("cursor_4c_DispTamanho")
3090:             GOTO loc_nRecno
3091:         ENDIF
3092: 
3093:         IF loc_nQtdUti > loc_nPSaldo
3094:             MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Pedida...", "Aten" + CHR(231) + CHR(227) + "o")
3095:             loc_oCampo.Value = 0
3096:             loc_oCampo.Refresh()
3097:             RETURN
3098:         ENDIF
3099: 
3100:         THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Value = loc_nQtdUti
3101:         THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Refresh()
3102:     ENDPROC

*-- Linhas 3184 a 3202:
3184:         loc_nEstoque = TmpFinalg.Estoque
3185:         loc_nFabrica = TmpFinalg.Fabrs
3186: 
3187:         SELECT TmpFinal
3188:         SUM Saldo, Estoque, Produzir, Fabrs TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
3189:         GO TOP
3190: 
3191:         IF loc_nEst != loc_nEstoque
3192:             MsgAviso("A quantidade de Estoque n" + CHR(227) + "o confere com a Quantidade Selecionada!!!", "Aten" + CHR(231) + CHR(227) + "o")
3193:             RETURN
3194:         ENDIF
3195:         IF loc_nPrc != loc_nFabrica
3196:             MsgAviso("A quantidade de Produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o confere com a Quantidade Selecionada!!!", "Aten" + CHR(231) + CHR(227) + "o")
3197:             RETURN
3198:         ENDIF
3199: 
3200:         THIS.pgf_4c_1.Page1.Enabled = .T.
3201:         THIS.AlternarPagina(1)
3202:         THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()

*-- Linhas 3232 a 3267:
3232:             USE IN TmpLinha
3233:         ENDIF
3234: 
3235:         SELECT Linhas, 0 AS Ordem, SUM(saldo) AS saldo, SUM(estoque) AS estoque, ;
3236:                 SUM(produzir) AS produzir, SUM(Fabrs) AS Fabrs ;
3237:             FROM TmpFinalg GROUP BY 1 ;
3238:             UNION ALL ;
3239:             SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS ordem, SUM(saldo) AS saldo, SUM(estoque) AS estoque, ;
3240:                 SUM(produzir) AS produzir, SUM(Fabrs) AS Fabrs ;
3241:             FROM TmpFinalg GROUP BY 1 ;
3242:             INTO CURSOR TmpLinha ORDER BY 2, 1
3243: 
3244:         loc_oGrid = THIS.pgf_4c_1.Page3.grd_4c_Linhas
3245:         loc_oGrid.RecordSource = ""
3246:         loc_oGrid.ColumnCount  = 5
3247:         loc_oGrid.RecordSource = "TmpLinha"
3248:         loc_oGrid.Column1.ControlSource = "TmpLinha.Linhas"
3249:         loc_oGrid.Column2.ControlSource = "TmpLinha.Saldo"
3250:         loc_oGrid.Column3.ControlSource = "TmpLinha.Estoque"
3251:         loc_oGrid.Column4.ControlSource = "TmpLinha.Fabrs"
3252:         loc_oGrid.Column5.ControlSource = "TmpLinha.Produzir"
3253: 
3254:         *-- ColumnCount reatribuido RESETA Header1.Caption/Width/ReadOnly/
3255:         *-- Movable/Resizable/Sparse de TODAS as colunas (medido no VFP9 -
3256:         *-- regra do Problema 48/Pattern #180) - reconfigurar na mesma
3257:         *-- ordem de ConfigurarPaginaTotaisLinha.
3258:         loc_oGrid.Column1.Header1.Caption = "Linha"
3259:         loc_oGrid.Column1.Width     = 84
3260:         loc_oGrid.Column1.Movable   = .F.
3261:         loc_oGrid.Column1.Resizable = .F.
3262:         loc_oGrid.Column1.Sparse    = .F.
3263:         loc_oGrid.Column1.ReadOnly  = .T.
3264:         loc_oGrid.Column1.ForeColor = RGB(36, 84, 155)
3265: 
3266:         loc_oGrid.Column2.Header1.Caption = "Quantidade"
3267:         loc_oGrid.Column2.Width     = 80

*-- Linhas 3342 a 3379:
3342:             USE IN cursor_4c_DispEstoque
3343:         ENDIF
3344: 
3345:         SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, 0 AS Utilizar ;
3346:             FROM cursor_4c_TmpSaldg ;
3347:             WHERE Cpros = loc_cCpro AND CodCors = loc_cCor AND CodTams = loc_cTam AND Disps > 0 ;
3348:             ORDER BY 1, 2, 3, 4 ;
3349:             INTO CURSOR cursor_4c_DispEstoque READWRITE
3350: 
3351:         IF RECCOUNT("cursor_4c_DispEstoque") = 0
3352:             MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "Aten" + CHR(231) + CHR(227) + "o")
3353:             THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3354:             RETURN
3355:         ENDIF
3356: 
3357:         loc_oGrid = THIS.pgf_4c_1.Page4.grd_4c_DispEstoque
3358:         loc_oGrid.ColumnCount = 5
3359:         loc_oGrid.RecordSource = "cursor_4c_DispEstoque"
3360:         loc_oGrid.Column1.ControlSource = "cursor_4c_DispEstoque.Grupos"
3361:         loc_oGrid.Column2.ControlSource = "cursor_4c_DispEstoque.Estos"
3362:         loc_oGrid.Column3.ControlSource = "cursor_4c_DispEstoque.Priors"
3363:         loc_oGrid.Column4.ControlSource = "cursor_4c_DispEstoque.Disps"
3364:         loc_oGrid.Column5.ControlSource = "cursor_4c_DispEstoque.Utilizar"
3365: 
3366:         *-- RecordSource reatribuido RESETA Header1.Caption/Width/ReadOnly de
3367:         *-- TODAS as colunas (medido no VFP9 - regra do Problema 48/Pattern
3368:         *-- #180) - reconfigurar na mesma ordem de ConfigurarPaginaEstoque.
3369:         loc_oGrid.Column1.Header1.Caption = "Grupo"
3370:         loc_oGrid.Column1.Width     = 80
3371:         loc_oGrid.Column1.ReadOnly  = .T.
3372:         loc_oGrid.Column2.Header1.Caption = "Conta"
3373:         loc_oGrid.Column2.Width     = 80
3374:         loc_oGrid.Column2.ReadOnly  = .T.
3375:         loc_oGrid.Column3.Header1.Caption = "Prior"
3376:         loc_oGrid.Column3.Width     = 24
3377:         loc_oGrid.Column3.ReadOnly  = .T.
3378:         loc_oGrid.Column4.Header1.Caption = "Disponivel"
3379:         loc_oGrid.Column4.Width     = 75

*-- Linhas 3425 a 3462:
3425:             USE IN cursor_4c_DispTamanho
3426:         ENDIF
3427: 
3428:         SELECT Cpros, CodCors, CodTams, Disps, 0 AS Utilizar ;
3429:             FROM cursor_4c_TmpSaldo ;
3430:             WHERE Cpros = loc_cCpro AND CodCors = loc_cCor AND Disps > 0 ;
3431:             ORDER BY 1, 2, 3 ;
3432:             INTO CURSOR cursor_4c_DispTamanho READWRITE
3433: 
3434:         IF RECCOUNT("cursor_4c_DispTamanho") = 0
3435:             MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel em Nenhum Tamanho!!!", "Aten" + CHR(231) + CHR(227) + "o")
3436:             THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3437:             RETURN
3438:         ENDIF
3439: 
3440:         loc_oGrid = THIS.pgf_4c_1.Page5.grd_4c_DispTamanho
3441:         loc_oGrid.ColumnCount = 5
3442:         loc_oGrid.RecordSource = "cursor_4c_DispTamanho"
3443:         loc_oGrid.Column1.ControlSource = "cursor_4c_DispTamanho.Cpros"
3444:         loc_oGrid.Column2.ControlSource = "cursor_4c_DispTamanho.CodCors"
3445:         loc_oGrid.Column3.ControlSource = "cursor_4c_DispTamanho.CodTams"
3446:         loc_oGrid.Column4.ControlSource = "cursor_4c_DispTamanho.Disps"
3447:         loc_oGrid.Column5.ControlSource = "cursor_4c_DispTamanho.Utilizar"
3448: 
3449:         *-- RecordSource reatribuido RESETA Header1.Caption/Width/ReadOnly de
3450:         *-- TODAS as colunas (medido no VFP9 - regra do Problema 48/Pattern
3451:         *-- #180) - reconfigurar na mesma ordem de ConfigurarPaginaTamanhos.
3452:         loc_oGrid.Column1.Header1.Caption = "Produto"
3453:         loc_oGrid.Column1.Width     = 80
3454:         loc_oGrid.Column1.ReadOnly  = .T.
3455:         loc_oGrid.Column2.Header1.Caption = "Cor"
3456:         loc_oGrid.Column2.Width     = 38
3457:         loc_oGrid.Column2.ReadOnly  = .T.
3458:         loc_oGrid.Column2.Text1.FontBold = .T.
3459:         loc_oGrid.Column3.Header1.Caption = "Tam"
3460:         loc_oGrid.Column3.Width     = 24
3461:         loc_oGrid.Column3.ReadOnly  = .T.
3462:         loc_oGrid.Column3.Text1.FontBold = .T.

*-- Linhas 3493 a 3566:
3493:         LOCAL loc_nQtdUti, loc_nLnQtUtil, loc_nXBaixa
3494: 
3495:         IF USED("cursor_4c_DispEstoque") AND RECCOUNT("cursor_4c_DispEstoque") > 0
3496:             SELECT cursor_4c_DispEstoque
3497:             SUM Utilizar TO loc_nQtdUti
3498: 
3499:             IF loc_nQtdUti > 0
3500:                 SELECT cursor_4c_DispEstoque
3501:                 SCAN
3502:                     IF cursor_4c_DispEstoque.Utilizar = 0
3503:                         LOOP
3504:                     ENDIF
3505:                     loc_nLnQtUtil = cursor_4c_DispEstoque.Utilizar
3506: 
3507:                     = SEEK(cursor_4c_DispEstoque.CPros + cursor_4c_DispEstoque.CodCors + cursor_4c_DispEstoque.CodTams, ;
3508:                         "cursor_4c_TmpSaldo", "CPros")
3509: 
3510:                     SELECT TmpFinalg
3511:                     REPLACE Produzir WITH Produzir - loc_nLnQtUtil, ;
3512:                             Estoque  WITH Estoque + loc_nLnQtUtil, ;
3513:                             UsuLibs  WITH " " IN TmpFinalg
3514: 
3515:                     SELECT cursor_4c_TmpSaldo
3516:                     REPLACE Disps WITH Disps - loc_nLnQtUtil IN cursor_4c_TmpSaldo
3517: 
3518:                     IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
3519:                         INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
3520:                     ENDIF
3521:                     REPLACE keySelm WITH .T. IN TmpSaldU
3522: 
3523:                     SELECT cursor_4c_TmpSaldg
3524:                     SET ORDER TO CPros
3525:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams + ;
3526:                         STR(cursor_4c_DispEstoque.Priors, 2) + cursor_4c_DispEstoque.Grupos + cursor_4c_DispEstoque.Estos)
3527:                     REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldg.Disps - loc_nLnQtUtil
3528:                     SELECT cursor_4c_DispEstoque
3529:                 ENDSCAN
3530: 
3531:                 = SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, "cursor_4c_TmpSaldo", "CPros")
3532: 
3533:                 loc_nXBaixa = TmpFinalg.Estoque
3534:                 SELECT TmpFinal
3535:                 SET ORDER TO
3536:                 SET ORDER TO Cpros
3537:                 = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
3538:                 REPLACE Estoque WITH 0 WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
3539:                         TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams
3540:                 = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
3541:                 SCAN WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors ;
3542:                         AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
3543:                     IF (TmpFinal.Saldo - TmpFinal.Fabrs) >= loc_nXBaixa
3544:                         REPLACE TmpFinal.Estoque WITH TmpFinal.Estoque + loc_nXBaixa
3545:                         loc_nXBaixa = 0
3546:                     ELSE
3547:                         loc_nXBaixa = loc_nXBaixa - (TmpFinal.Saldo - TmpFinal.Fabrs)
3548:                         REPLACE TmpFinal.Estoque WITH (TmpFinal.Saldo - TmpFinal.Fabrs)
3549:                     ENDIF
3550:                     REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
3551:                     SELECT TmpFinal
3552:                 ENDSCAN
3553:             ENDIF
3554:         ENDIF
3555: 
3556:         THIS.AtualizarTotaisPage1()
3557: 
3558:         THIS.pgf_4c_1.Page1.Enabled = .T.
3559:         THIS.pgf_4c_1.Page2.Enabled = .T.
3560:         THIS.pgf_4c_1.Page3.Enabled = .F.
3561:         THIS.pgf_4c_1.Page4.Enabled = .F.
3562:         THIS.pgf_4c_1.Page5.Enabled = .F.
3563:         THIS.AlternarPagina(1)
3564:         THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3565:     ENDPROC
3566: 

*-- Linhas 3573 a 3706:
3573:     * nova linha com o tamanho escolhido).
3574:     *--------------------------------------------------------------------------
3575:     PROCEDURE BtnCancelaDispPage5Click()
3576:         LOCAL loc_nQtdUti, loc_nRegFinal, loc_nLnQtUtil, loc_cEdn, loc_cQuery
3577: 
3578:         IF !USED("TmpFinal") OR !USED("cursor_4c_DispTamanho")
3579:             THIS.AlternarPagina(1)
3580:             RETURN
3581:         ENDIF
3582: 
3583:         SELECT TmpFinal
3584:         SET ORDER TO
3585:         loc_nRegFinal = RECNO()
3586: 
3587:         SELECT cursor_4c_DispTamanho
3588:         SUM Utilizar TO loc_nQtdUti
3589: 
3590:         IF loc_nQtdUti > 0
3591:             IF USED("Temporario")
3592:                 USE IN Temporario
3593:             ENDIF
3594:             SELECT * FROM TmpFinal WHERE .F. INTO CURSOR Temporario READWRITE
3595: 
3596:             SELECT cursor_4c_DispTamanho
3597:             SCAN
3598:                 IF cursor_4c_DispTamanho.Utilizar = 0
3599:                     LOOP
3600:                 ENDIF
3601:                 loc_nLnQtUtil = cursor_4c_DispTamanho.Utilizar
3602: 
3603:                 = SEEK(cursor_4c_DispTamanho.CPros + cursor_4c_DispTamanho.CodCors + cursor_4c_DispTamanho.CodTams, ;
3604:                     "cursor_4c_TmpSaldo", "CPros")
3605: 
3606:                 SELECT TmpFinal
3607:                 SCATTER MEMVAR
3608:                 SELECT Temporario
3609:                 APPEND BLANK
3610:                 GATHER MEMVAR
3611:                 REPLACE Temporario.Saldo WITH loc_nLnQtUtil, ;
3612:                         Temporario.codTams WITH cursor_4c_DispTamanho.CodTams, ;
3613:                         Temporario.Estoque WITH loc_nLnQtUtil, ;
3614:                         Temporario.Produzir WITH 0
3615: 
3616:                 SELECT TmpFinal
3617:                 REPLACE TmpFinal.Saldo WITH TmpFinal.Saldo - loc_nLnQtUtil, ;
3618:                         TmpFinal.Produzir WITH TmpFinal.Produzir - loc_nLnQtUtil
3619: 
3620:                 REPLACE Saldo WITH Saldo - loc_nLnQtUtil, Produzir WITH Produzir - loc_nLnQtUtil IN TmpFinalg
3621: 
3622:                 SELECT TmpFinalg
3623:                 REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
3624:                     QtdMins - Produzir, 0) IN TmpFinalg
3625: 
3626:                 SELECT cursor_4c_TmpSaldo
3627:                 REPLACE cursor_4c_TmpSaldo.Disps WITH cursor_4c_TmpSaldo.Disps - loc_nLnQtUtil
3628: 
3629:                 SELECT cursor_4c_TmpSaldg
3630:                 SET ORDER TO CPros
3631:                 = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
3632:                 REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldo.Saldo ;
3633:                     WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
3634:                           cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
3635:                           cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams
3636: 
3637:                 *-- Divide a linha SEM tamanho de SigMvIts (tabela real) em
3638:                 *-- duas: a original com a quantidade restante e uma nova
3639:                 *-- com o tamanho escolhido e loc_nLnQtUtil (dump 7896-7916)
3640:                 loc_cEdn = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)
3641:                 loc_cQuery = "SELECT * FROM SigMvIts WHERE EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
3642:                     " AND Citens = " + FormatarNumeroSQL(TmpFinal.Citens, 0) + ;
3643:                     " AND CodCors = " + EscaparSQL(ALLTRIM(TmpFinal.CodCors)) + ;
3644:                     " AND CodTams = " + EscaparSQL(SPACE(4))
3645:                 IF USED("cursor_4c_MvItsOrig")
3646:                     USE IN cursor_4c_MvItsOrig
3647:                 ENDIF
3648:                 IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_MvItsOrig") >= 0 AND ;
3649:                         USED("cursor_4c_MvItsOrig") AND !EOF("cursor_4c_MvItsOrig")
3650: 
3651:                     IF (cursor_4c_MvItsOrig.Qtds - loc_nLnQtUtil) = 0
3652:                         SQLEXEC(gnConnHandle, "DELETE FROM SigMvIts WHERE cIdChaves = " + ;
3653:                             EscaparSQL(cursor_4c_MvItsOrig.cIdChaves))
3654:                     ELSE
3655:                         SQLEXEC(gnConnHandle, "UPDATE SigMvIts SET Qtds = " + ;
3656:                             FormatarNumeroSQL(cursor_4c_MvItsOrig.Qtds - loc_nLnQtUtil, 3) + ;
3657:                             ", Aqtds = " + FormatarNumeroSQL(cursor_4c_MvItsOrig.Qtds - loc_nLnQtUtil, 3) + ;
3658:                             " WHERE cIdChaves = " + EscaparSQL(cursor_4c_MvItsOrig.cIdChaves))
3659:                     ENDIF
3660: 
3661:                     SQLEXEC(gnConnHandle, ;
3662:                         "INSERT INTO SigMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, Aqtds, CodCors, CodTams, QtdEmbs, cIdChaves) " + ;
3663:                         "VALUES (" + FormatarNumeroSQL(cursor_4c_MvItsOrig.Citens, 0) + ", " + ;
3664:                         EscaparSQL(cursor_4c_MvItsOrig.Emps) + ", " + EscaparSQL(cursor_4c_MvItsOrig.Dopes) + ", " + ;
3665:                         FormatarNumeroSQL(cursor_4c_MvItsOrig.Numes, 0) + ", " + ;
3666:                         EscaparSQL(cursor_4c_MvItsOrig.Cpros) + ", " + FormatarNumeroSQL(loc_nLnQtUtil, 3) + ", " + ;
3667:                         FormatarNumeroSQL(loc_nLnQtUtil, 3) + ", " + EscaparSQL(cursor_4c_MvItsOrig.CodCors) + ", " + ;
3668:                         EscaparSQL(cursor_4c_DispTamanho.CodTams) + ", 1, " + EscaparSQL(fUniqueIds()) + ")")
3669:                 ENDIF
3670:                 IF USED("cursor_4c_MvItsOrig")
3671:                     USE IN cursor_4c_MvItsOrig
3672:                 ENDIF
3673: 
3674:                 SELECT cursor_4c_DispTamanho
3675:             ENDSCAN
3676: 
3677:             IF USED("Temporario") AND RECCOUNT("Temporario") > 0
3678:                 SELECT TmpFinal
3679:                 APPEND FROM DBF("Temporario")
3680:             ENDIF
3681:             IF loc_nRegFinal > 0 AND loc_nRegFinal <= RECCOUNT("TmpFinal")
3682:                 GOTO loc_nRegFinal IN TmpFinal
3683:             ENDIF
3684:             IF TmpFinal.Saldo = 0
3685:                 SELECT TmpFinal
3686:                 DELETE
3687:             ENDIF
3688: 
3689:             SELECT TmpFinalg
3690:             IF TmpFinalg.Saldo = 0
3691:                 DELETE
3692:             ENDIF
3693: 
3694:             = SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, "cursor_4c_TmpSaldo", "CPros")
3695:         ENDIF
3696: 
3697:         THIS.AtualizarTotaisPage1()
3698: 
3699:         THIS.pgf_4c_1.Page1.Enabled = .T.
3700:         THIS.pgf_4c_1.Page2.Enabled = .T.
3701:         THIS.pgf_4c_1.Page3.Enabled = .F.
3702:         THIS.pgf_4c_1.Page4.Enabled = .F.
3703:         THIS.pgf_4c_1.Page5.Enabled = .F.
3704:         THIS.AlternarPagina(1)
3705:         THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3706:     ENDPROC

*-- Linhas 3731 a 3753:
3731:         loc_oGrid.RecordSource = ""
3732:         loc_oGrid.ColumnCount  = 5
3733:         loc_oGrid.RecordSource = "cursor_4c_Requisicao"
3734:         loc_oGrid.Column1.ControlSource = "cursor_4c_Requisicao.Cpros"
3735:         loc_oGrid.Column2.ControlSource = "cursor_4c_Requisicao.Dpros"
3736:         loc_oGrid.Column3.ControlSource = "cursor_4c_Requisicao.Cunis"
3737:         loc_oGrid.Column4.ControlSource = "cursor_4c_Requisicao.Qtds"
3738:         loc_oGrid.Column5.ControlSource = "cursor_4c_Requisicao.Cpro2s"
3739: 
3740:         THIS.pgf_4c_1.Page1.Enabled = .F.
3741:         THIS.pgf_4c_1.Page2.Enabled = .F.
3742:         THIS.pgf_4c_1.Page3.Enabled = .F.
3743:         THIS.pgf_4c_1.Page4.Enabled = .F.
3744:         THIS.pgf_4c_1.Page5.Enabled = .F.
3745:         THIS.pgf_4c_1.Page6.Enabled = .T.
3746:         THIS.AlternarPagina(6)
3747:         loc_oGrid.SetFocus()
3748:     ENDPROC
3749: 
3750:     *--------------------------------------------------------------------------
3751:     * BtnAlteraqtdClick - transcricao de Page1.Alteraqtd.Click (dump
3752:     * 7180-7204): autoriza UMA edicao da coluna "Produzir Estq" via dialogo
3753:     * de senha de risco (SigOpSen, "PRDZRISCO"). SigOpSen NAO foi migrado

*-- Linhas 3861 a 3893:
3861:     * CarregarLista - (re)liga a grade principal da Page1 ao cursor
3862:     * TmpFinalg e deixa a tela no estado em que o Init legado a entregava:
3863:     *
3864:     *   With ThisForm.PageDados.page1.GradeItens -> RecordSource/ControlSource
3865:     *   Select TmpSaldG / Set Order To Cpros / Set Key To TmpFinalg.Cpros+
3866:     *       CodCors+CodTams / Go Top          (filtro relacional por item)
3867:     *   Select TmpFabr  / idem
3868:     *   Select TmpFinalg / Sum ... / Tot_* .Value / .Refresh
3869:     *   ThisForm.pageDados.Page1.GradeItens.Setfocus
3870:     *
3871:     * Por que REBIND e nao so Refresh: TmpFinalg/TmpFinal/TmpSaldG/TmpFabr
3872:     * sao criados por FormSigPrGl2BO.ExecutarProcessamento na data session
3873:     * do form PAI (assumida no Init). Quando o pai reprocessa, o alias eh
3874:     * fisicamente RECRIADO e o Grid perde RecordSource/ControlSource,
3875:     * Header1.Caption, Width e ReadOnly (regra #43.1 do CLAUDE.md) - a
3876:     * grade viraria "Column1/Column2" generica e editavel. Por isso a
3877:     * reconfiguracao completa, na ordem ColumnCount -> RecordSource ->
3878:     * ControlSource -> Width -> Header1.Caption -> ReadOnly (regra #41).
3879:     *
3880:     * Fecha com GO TOP + Refresh (regra #21a: popular/religar cursor NAO
3881:     * repinta a grade sozinho).
3882:     *
3883:     * PUBLIC (nao PROTECTED): CarregarLista nao existe em FormBase e o
3884:     * harness de teste automatizado chama THIS.oForm.CarregarLista() direto
3885:     * de fora da classe (regra #3 do CLAUDE.md).
3886:     *--------------------------------------------------------------------------
3887:     PROCEDURE CarregarLista()
3888:         LOCAL loc_lSucesso, loc_oGrid, loc_oErro
3889:         loc_lSucesso = .F.
3890: 
3891:         TRY
3892:             IF !USED("TmpFinalg")
3893:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados de globaliza" + CHR(231) + CHR(227) + ;

*-- Linhas 3901 a 3930:
3901:                     .ColumnCount  = 10
3902:                     .RecordSource = "TmpFinalg"
3903: 
3904:                     .Column1.ControlSource  = "TmpFinalg.Cpros"
3905:                     .Column2.ControlSource  = "TmpFinalg.CodCors"
3906:                     .Column3.ControlSource  = "TmpFinalg.Flag"
3907:                     .Column4.ControlSource  = "TmpFinalg.Qtds"
3908:                     .Column5.ControlSource  = "TmpFinalg.Saldo"
3909:                     .Column6.ControlSource  = "TmpFinalg.Produzir"
3910:                     .Column7.ControlSource  = "TmpFinalg.Fabrs"
3911:                     .Column8.ControlSource  = "TmpFinalg.Produzir2"
3912:                     .Column9.ControlSource  = "TmpFinalg.CodTams"
3913:                     .Column10.ControlSource = "TmpFinalg.Estoque"
3914: 
3915:                     *-- Width DEPOIS do RecordSource/ControlSource: reatribuir
3916:                     *-- a fonte do Grid recalcula toda largura para o default.
3917:                     .Column1.Width  = 90
3918:                     .Column2.Width  = 50
3919:                     .Column3.Width  = 30
3920:                     .Column4.Width  = 60
3921:                     .Column5.Width  = 70
3922:                     .Column6.Width  = 70
3923:                     .Column7.Width  = 80
3924:                     .Column8.Width  = 80
3925:                     .Column9.Width  = 40
3926:                     .Column10.Width = 76
3927: 
3928:                     .Column1.Header1.Caption  = "Produto"
3929:                     .Column2.Header1.Caption  = "Cor"
3930:                     .Column3.Header1.Caption  = ""

*-- Linhas 3956 a 4002:
3956:                         "IIF(!EMPTY(TmpFinalg.UsuLibs), RGB(255,0,0), RGB(0,0,0))"
3957:                 ENDWITH
3958: 
3959:                 SELECT TmpFinalg
3960:                 GO TOP
3961: 
3962:                 *-- Ordem das grades de resumo (Set Order To Cpros do Init
3963:                 *-- legado). O FILTRO por item corrente NAO vem aqui: eh
3964:                 *-- GradeItensPage1AfterRowColChange quem o aplica, e ele eh
3965:                 *-- chamado no fim deste metodo para a primeira linha - uma
3966:                 *-- fonte unica, em vez de duas copias para divergirem.
3967:                 IF USED("cursor_4c_TmpSaldg")
3968:                     SELECT cursor_4c_TmpSaldg
3969:                     SET ORDER TO CPros
3970:                 ENDIF
3971:                 IF USED("cursor_4c_TmpFabr")
3972:                     SELECT cursor_4c_TmpFabr
3973:                     SET ORDER TO Cpros
3974:                 ENDIF
3975: 
3976:                 SELECT TmpFinalg
3977:                 GO TOP
3978:                 loc_oGrid.Refresh()
3979: 
3980:                 *-- Totais gerais e paineis/imagem do primeiro item
3981:                 THIS.AtualizarTotaisPage1()
3982:                 THIS.AtualizarVisibilidadeDisponivel()
3983:                 IF !EOF("TmpFinalg")
3984:                     THIS.GradeItensPage1AfterRowColChange(1)
3985:                 ENDIF
3986: 
3987:                 SELECT TmpFinalg
3988:                 loc_lSucesso = .T.
3989:             ENDIF
3990:         CATCH TO loc_oErro
3991:             MsgErro(loc_oErro.Message + CHR(13) + ;
3992:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3993:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
3994:             loc_lSucesso = .F.
3995:         ENDTRY
3996: 
3997:         RETURN loc_lSucesso
3998:     ENDPROC
3999: 
4000:     *--------------------------------------------------------------------------
4001:     * FormParaBO - repassa a Processar() os dois campos que o Init legado
4002:     * lia do form AVO (_Prev/_DtGera = ThisForm.ParentForm.ParentForm.

