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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.prg) - TRECHOS RELEVANTES PARA PASS SQL (4149 linhas total):

*-- Linhas 362 a 480:
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
372:             SET NULL ON
373:             CREATE CURSOR cursor_4c_TmpSaldg (Emps C(3), Grupos C(10), Estos C(10), CPros C(14), ;
374:                 CodCors C(4), CodTams C(4), Saldo N(12,3), Disps N(12,3), Priors N(2), Reservs N(12,3))
375:             SET NULL OFF
376:             INDEX ON CPros + CodCors + CodTams + STR(Priors, 2) + Grupos + Estos + Emps TAG CPros
377:             INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG GruEstPro
378:         ENDIF
379:         IF !USED("cursor_4c_TmpFabr")
380:             SET NULL ON
381:             CREATE CURSOR cursor_4c_TmpFabr (Priors N(2), Nops N(10), Fases C(10), Cpros C(14), ;
382:                 CodCors C(4), CodTams C(4), Qtds N(12,3), Disps N(12,3), Reservs N(12,3))
383:             SET NULL OFF
384:             INDEX ON Cpros + CodCors + CodTams + STR(Priors, 2) + STR(Nops, 10) TAG Cpros
385:         ENDIF
386:         IF !USED("cursor_4c_TmpSaldo")
387:             SET NULL ON
388:             CREATE CURSOR cursor_4c_TmpSaldo (CPros C(14), CodCors C(4), CodTams C(4), ;
389:                 Saldo N(12,3), Disps N(12,3), Fabrs N(12,3), DispFs N(12,3))
390:             SET NULL OFF
391:             INDEX ON CPros + CodCors + CodTams TAG CPros
392:         ENDIF
393:         *-- TmpSaldU (Init legado): marca "produto com selecao manual" por
394:         *-- item (KeySelm/KeySelmp), consultado/alterado pelos Valid das
395:         *-- colunas editaveis (Column7 aqui, Column10 na Page2)
396:         IF !USED("TmpSaldU")
397:             CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L, KeySelmp L)
398:             INDEX ON Cpros TAG Cpros
399:         ENDIF
400: 
401:         *-- Grade principal (TmpFinalg) -----------------------------------
402:         loc_oPag1.AddObject("grd_4c_Dados", "Grid")
403: 
404:         *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
405:         *-- antes de o bloco abaixo acessar .Column1..Column10.
406:         loc_oPag1.grd_4c_Dados.RecordSource = ""
407:         loc_oPag1.grd_4c_Dados.ColumnCount  = 10
408:         loc_oPag1.grd_4c_Dados.RecordSource = "TmpFinalg"
409: 
410:         WITH loc_oPag1.grd_4c_Dados
411:             .Top         = 173
412:             .Left        = 52
413:             .Width       = 586
414:             .Height      = 173
415:             .RecordMark   = .F.
416:             .DeleteMark   = .F.
417:             .ReadOnly     = .F.
418: 
419:             .Column1.ControlSource = "TmpFinalg.Cpros"
420:             .Column1.Header1.Caption = "Produto"
421:             .Column1.Width = 90
422:             .Column1.ReadOnly = .T.
423: 
424:             .Column2.ControlSource = "TmpFinalg.CodCors"
425:             .Column2.Header1.Caption = "Cor"
426:             .Column2.Width = 50
427:             .Column2.ReadOnly = .T.
428: 
429:             .Column3.ControlSource = "TmpFinalg.Flag"
430:             .Column3.Header1.Caption = ""
431:             .Column3.Width = 30
432: 
433:             .Column4.ControlSource = "TmpFinalg.Qtds"
434:             .Column4.Header1.Caption = "N" + CHR(250) + "mero"
435:             .Column4.Width = 60
436:             .Column4.ReadOnly = .T.
437: 
438:             .Column5.ControlSource = "TmpFinalg.Saldo"
439:             .Column5.Header1.Caption = "Qtde Pedido"
440:             .Column5.Width = 70
441:             .Column5.ReadOnly = .T.
442: 
443:             .Column6.ControlSource = "TmpFinalg.Produzir"
444:             .Column6.Header1.Caption = "Produzir"
445:             .Column6.Width = 70
446:             .Column6.ReadOnly = .T.
447: 
448:             .Column7.ControlSource = "TmpFinalg.Fabrs"
449:             .Column7.Header1.Caption = "Qtd Produ" + CHR(231) + CHR(227) + "o"
450:             .Column7.Width = 80
451:             .Column7.ReadOnly = .F.
452:             .Column7.DynamicBackColor = "RGB(255,255,204)"
453: 
454:             .Column8.ControlSource = "TmpFinalg.Produzir2"
455:             .Column8.Header1.Caption = "Produzir Estq"
456:             .Column8.Width = 80
457:             .Column8.ReadOnly = .T.
458:             .Column8.DynamicForeColor = "IIF(!EMPTY(TmpFinalg.UsuLibs), RGB(255,0,0), RGB(0,0,0))"
459: 
460:             .Column9.ControlSource = "TmpFinalg.CodTams"
461:             .Column9.Header1.Caption = "Tam"
462:             .Column9.Width = 40
463:             .Column9.ReadOnly = .T.
464: 
465:             .Column10.ControlSource = "TmpFinalg.Estoque"
466:             .Column10.Header1.Caption = "Qtd Estoque"
467:             .Column10.Width = 76
468:             .Column10.ReadOnly = .F.
469:         ENDWITH
470: 
471:         *-- GotFocus -> Column7.SetFocus SO nas colunas que o legado redireciona
472:         *-- (Column1/2/5/6/9 - dump: ver lista de PROCEDURE por coluna). NUNCA
473:         *-- no laco inteiro de 1 a 10: Column7 (Qtd Producao), Column8
474:         *-- (Produzir Estq, liberada por BtnAlteraqtdClick) e Column10 (Qtd
475:         *-- Estoque) sao JUSTAMENTE as digitaveis - redirecionar o foco delas
476:         *-- torna as tres inalcancaveis e o usuario nao consegue digitar nada.
477:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
478:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
479:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column5.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
480:         BINDEVENT(loc_oPag1.grd_4c_Dados.Column6.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")

*-- Linhas 533 a 567:
533:             .Width = 358
534:             .Height = 147
535:             .RecordMark = .F.
536:             .DeleteMark = .F.
537:             .ReadOnly = .T.
538: 
539:             *-- Headers transcritos de SIGPRGLX.PageDados.Page1.Container3.
540:             *-- GradeDisp (dump task618, linhas 1215-1340): "Atual" (Saldo) e
541:             *-- "Utilizado" (Saldo-Disps) - nao "Saldo"/"Reservado".
542:             .Column1.ControlSource = "cursor_4c_TmpSaldg.Grupos"
543:             .Column1.Header1.Caption = "Grupo"
544:             .Column2.ControlSource = "cursor_4c_TmpSaldg.Estos"
545:             .Column2.Header1.Caption = "Conta"
546:             .Column3.ControlSource = "cursor_4c_TmpSaldg.Saldo"
547:             .Column3.Header1.Caption = "Atual"
548:             .Column4.ControlSource = "cursor_4c_TmpSaldg.Saldo - cursor_4c_TmpSaldg.Disps"
549:             .Column4.Header1.Caption = "Utilizado"
550:             .Column5.ControlSource = "cursor_4c_TmpSaldg.Disps"
551:             .Column5.Header1.Caption = "Disponivel"
552:             .Column6.ControlSource = "cursor_4c_TmpSaldg.Priors"
553:             .Column6.Header1.Caption = "Prior"
554:             .Column6.ReadOnly = !THIS.this_lPermiteAjustarPrioridade()
555:         ENDWITH
556:         BINDEVENT(loc_oCnt.grd_4c_DispGrupo.Column6.Text1, "KeyPress", THIS, "GradeDispGrupoColumn6LostFocus")
557: 
558:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
559:         WITH loc_oCnt.lbl_4c_Label2
560:             .AutoSize = .F.
561:             .Top = 163
562:             .Left = 128
563:             .Width = 42
564:             .Height = 17
565:             .FontBold = .T.
566:             .BackStyle = 0
567:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 638 a 670:
638:             .Width = 303
639:             .Height = 99
640:             .RecordMark = .F.
641:             .DeleteMark = .F.
642:             .ReadOnly = .T.
643: 
644:             .Column1.ControlSource = "cursor_4c_TmpFabr.Fases"
645:             .Column1.Header1.Caption = "Fase"
646:             .Column2.ControlSource = "cursor_4c_TmpFabr.Qtds"
647:             .Column2.Header1.Caption = "Quantidade"
648:             .Column3.ControlSource = "cursor_4c_TmpFabr.Disps"
649:             .Column3.Header1.Caption = "Disponivel"
650:             .Column4.ControlSource = "cursor_4c_TmpFabr.Priors"
651:             .Column4.Header1.Caption = "Prior"
652:             .Column4.ReadOnly = !THIS.this_lPermiteAjustarPrioridade()
653:             .Column5.ControlSource = ""
654:             .Column5.Header1.Caption = ""
655:             .Column6.ControlSource = "cursor_4c_TmpFabr.Nops"
656:             .Column6.Header1.Caption = "Nop"
657:             .Column6.Visible = .F.
658:         ENDWITH
659:         BINDEVENT(loc_oCnt.grd_4c_DispFase.Column4.Text1, "KeyPress", THIS, "GradeDispFaseColumn4LostFocus")
660: 
661:         loc_oCnt.AddObject("lbl_4c_label22", "Label")
662:         WITH loc_oCnt.lbl_4c_label22
663:             .AutoSize = .F.
664:             .Top = 115
665:             .Left = 102
666:             .Width = 42
667:             .Height = 17
668:             .FontBold = .T.
669:             .BackStyle = 0
670:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 732 a 792:
732:             .Width = 108
733:             .Height = 19
734:             .ReadOnly = .T.
735:             .ControlSource = "TmpFinalg.Cpros"
736:         ENDWITH
737:         loc_oCnt.AddObject("lbl_4c_label13", "Label")
738:         WITH loc_oCnt.lbl_4c_label13
739:             .AutoSize = .F.
740:             .Top = 18
741:             .Left = 269
742:             .Width = 83
743:             .Height = 15
744:             .BackStyle = 0
745:             .ForeColor = RGB(90, 90, 90)
746:             .Caption = "Qtde Vendida :"
747:         ENDWITH
748:         loc_oCnt.AddObject("txt_4c_Tot_Venda", "TextBox")
749:         WITH loc_oCnt.txt_4c_Tot_Venda
750:             .Top = 17
751:             .Left = 349
752:             .Width = 80
753:             .Height = 19
754:             .InputMask = "999,999.99"
755:             .ReadOnly = .T.
756:             .ControlSource = "TmpFinalg.TotVenda"
757:         ENDWITH
758:         loc_oCnt.AddObject("lbl_4c_label23", "Label")
759:         WITH loc_oCnt.lbl_4c_label23
760:             .AutoSize = .F.
761:             .Top = 18
762:             .Left = 448
763:             .Width = 164
764:             .Height = 15
765:             .BackStyle = 0
766:             .ForeColor = RGB(90, 90, 90)
767:             .Caption = "Qtde M" + CHR(237) + "nima Para Produ" + CHR(231) + CHR(227) + "o :"
768:         ENDWITH
769:         loc_oCnt.AddObject("txt_4c_Minima", "TextBox")
770:         WITH loc_oCnt.txt_4c_Minima
771:             .Top = 17
772:             .Left = 623
773:             .Width = 80
774:             .Height = 19
775:             .InputMask = "999,999.99"
776:             .ReadOnly = .T.
777:             .ControlSource = "TmpFinalg.QtdMins"
778:         ENDWITH
779: 
780:         *-- Imagem do produto corrente (SigCdPro.FigJpgs) ------------------
781:         loc_oPag1.AddObject("img_4c_FigJpg", "Image")
782:         WITH loc_oPag1.img_4c_FigJpg
783:             .Top = 255
784:             .Left = 646
785:             .Width = 122
786:             .Height = 89
787:             .Stretch = 1
788:             .Visible = .F.
789:         ENDWITH
790:         BINDEVENT(loc_oPag1.img_4c_FigJpg, "DblClick", THIS, "ImgFigJpgPage1DblClick")
791: 
792:         *-- Totais gerais da pagina (soma de TmpFinalg) --------------------

*-- Linhas 977 a 1077:
977:         *-- cabeca de ConfigurarPaginaLista). Cursor de apoio so para modo
978:         *-- de teste de UI, com a MESMA estrutura exportada pelo pai.
979:         IF !USED("TmpFinal")
980:             CREATE CURSOR TmpFinal (Emps C(3), Dopes C(20), Numes N(6), CPros C(14), Qtds N(10,3), ;
981:                 Peso N(9,3), Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), Obs M NULL, ;
982:                 Obsps M NULL, Datas D NULL, Entregas D NULL, CodCors C(4), CodTams C(4), ;
983:                 Linhas C(10), Citens N(10), Reffs C(40), Notas C(6), Dpros C(40), GrupoDs C(10), ;
984:                 ContaDs C(10), KeySelM L, Fabrs N(10,3), KeyPdes L, Jobs C(10))
985:             INDEX ON Cpros + CodCors + CodTams TAG Cpros
986:         ENDIF
987: 
988:         *-- Grade de selecao de linha (GradeItens / TmpFinal). ControlSource
989:         *-- remapeado conforme SIGPRGLX.Init (dump 4279-4291) - NAO pela
990:         *-- ordem fisica de Column no SCX (ver nota do cabecalho do metodo).
991:         loc_oPag2.AddObject("grd_4c_Dados", "Grid")
992: 
993:         *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
994:         *-- antes de o bloco abaixo acessar .Column1..Column10.
995:         loc_oPag2.grd_4c_Dados.RecordSource = ""
996:         loc_oPag2.grd_4c_Dados.ColumnCount  = 10
997:         loc_oPag2.grd_4c_Dados.RecordSource = "TmpFinal"
998: 
999:         WITH loc_oPag2.grd_4c_Dados
1000:             .Top          = 181
1001:             .Left         = 53
1002:             .Width        = 703
1003:             .Height       = 189
1004:             .FontName     = "Tahoma"
1005:             .FontSize     = 8
1006:             .AllowHeaderSizing = .F.
1007:             .AllowRowSizing    = .F.
1008:             .RowHeight    = 17
1009:             .GridLineColor = RGB(238, 238, 238)
1010:             .RecordMark   = .F.
1011:             .DeleteMark   = .F.
1012:             .ReadOnly     = .F.
1013: 
1014:             .Column1.ControlSource = "TmpFinal.Cpros"
1015:             .Column1.Header1.Caption = "Produto"
1016:             .Column1.Width = 108
1017:             .Column1.ReadOnly = .T.
1018: 
1019:             .Column2.ControlSource = "TmpFinal.CodCors"
1020:             .Column2.Header1.Caption = "Cor"
1021:             .Column2.Width = 38
1022:             .Column2.ReadOnly = .T.
1023: 
1024:             .Column3.ControlSource = "TmpFinal.Dopes"
1025:             .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1026:             .Column3.Width = 150
1027:             .Column3.ReadOnly = .T.
1028: 
1029:             .Column4.ControlSource = "TmpFinal.Numes"
1030:             .Column4.Header1.Caption = "N" + CHR(250) + "mero"
1031:             .Column4.Width = 47
1032:             .Column4.ReadOnly = .T.
1033: 
1034:             .Column5.ControlSource = "TmpFinal.Saldo"
1035:             .Column5.Header1.Caption = "Quantidade"
1036:             .Column5.Width = 65
1037:             .Column5.ReadOnly = .T.
1038: 
1039:             .Column6.ControlSource = "TmpFinal.Produzir"
1040:             .Column6.Header1.Caption = "Produzir"
1041:             .Column6.Width = 65
1042:             .Column6.ReadOnly = .T.
1043: 
1044:             .Column7.ControlSource = "TmpFinal.Estoque"
1045:             .Column7.Header1.Caption = "Estoque"
1046:             .Column7.Width = 65
1047:             .Column7.ReadOnly = .F.
1048:             .Column7.BackColor = RGB(255, 255, 204)
1049:             .Column7.Text1.FontBold = .T.
1050:             .Column7.Text1.BackColor = RGB(255, 255, 204)
1051: 
1052:             .Column8.ControlSource = [IIF(!EMPTY(TmpFinal.Obsps), "*", "")]
1053:             .Column8.Header1.Caption = "Obs"
1054:             .Column8.Width = 21
1055:             .Column8.ReadOnly = .T.
1056: 
1057:             .Column9.ControlSource = "TmpFinal.CodTams"
1058:             .Column9.Header1.Caption = "Tam"
1059:             .Column9.Width = 38
1060:             .Column9.ReadOnly = .T.
1061: 
1062:             .Column10.ControlSource = "TmpFinal.Fabrs"
1063:             .Column10.Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
1064:             .Column10.Width = 65
1065:             .Column10.ReadOnly = .F.
1066:             .Column10.BackColor = RGB(255, 255, 204)
1067:             .Column10.Text1.FontBold = .T.
1068:             .Column10.Text1.BackColor = RGB(255, 255, 204)
1069:         ENDWITH
1070: 
1071:         *-- Cabecalhos: Tahoma 8, alinhado ao centro, azul - igual ao legado
1072:         *-- em todas as 10 colunas.
1073:         FOR loc_nCol = 1 TO 10
1074:             WITH EVALUATE("loc_oPag2.grd_4c_Dados.Column" + TRANSFORM(loc_nCol) + ".Header1")
1075:                 .FontName   = "Tahoma"
1076:                 .FontSize   = 8
1077:                 .Alignment  = 2

*-- Linhas 1255 a 1273:
1255:             .Width          = 396
1256:             .Height         = 69
1257:             .ReadOnly       = .T.
1258:             .ControlSource  = "TmpFinal.Obsps"
1259:         ENDWITH
1260: 
1261:         *-- Cancelar/Voltar da Page2 (volta para a grade principal - Page1 -
1262:         *-- apos validar que Estoque/Producao selecionados fecham com o que
1263:         *-- foi reservado nas sub-paginas; validacao real na fase de eventos).
1264:         loc_oPag2.AddObject("cmd_4c_Cancelar", "CommandButton")
1265:         WITH loc_oPag2.cmd_4c_Cancelar
1266:             .Top         = 12
1267:             .Left        = 704
1268:             .Width       = 75
1269:             .Height      = 75
1270:             .FontBold    = .T.
1271:             .FontItalic  = .T.
1272:             .FontName    = "Comic Sans MS"
1273:             .FontSize    = 8

*-- Linhas 1297 a 1332:
1297:     * pgf_4c_1.Top = -27 veio cru do SCX).
1298:     *
1299:     * cursor_4c_Linhas eh o cursor de apoio desta grade (TmpLinha no legado) -
1300:     * a estrutura aqui tem de bater EXATAMENTE com a do SELECT que a popula
1301:     * depois (regra do cursor de apoio / APPEND FROM casa por NOME).
1302:     *--------------------------------------------------------------------------
1303:     PROTECTED PROCEDURE ConfigurarPaginaTotaisLinha()
1304:         LOCAL loc_oPag3, loc_nCol
1305: 
1306:         loc_oPag3 = THIS.pgf_4c_1.Page3
1307: 
1308:         WITH loc_oPag3
1309:             .Caption   = "Totais por Linha"
1310:             .FontBold  = .T.
1311:             .ForeColor = RGB(0, 128, 192)
1312:             .Enabled   = .F.
1313:         ENDWITH
1314: 
1315:         SET NULL ON
1316:         IF !USED("cursor_4c_Linhas")
1317:             CREATE CURSOR cursor_4c_Linhas ;
1318:                 (Linhas C(10) NULL, Ordem N(1) NULL, Saldo N(12,3) NULL, ;
1319:                  Estoque N(12,3) NULL, Produzir N(12,3) NULL, Fabrs N(12,3) NULL)
1320:         ENDIF
1321:         SET NULL OFF
1322: 
1323:         *-- Titulo da sub-tela (Label2 + Shape4 no legado) ------------------
1324:         loc_oPag3.AddObject("lbl_4c_Label2", "Label")
1325:         WITH loc_oPag3.lbl_4c_Label2
1326:             .AutoSize   = .F.
1327:             .Top        = 147
1328:             .Left       = 173
1329:             .Width      = 157
1330:             .Height     = 25
1331:             .FontName   = "Tahoma"
1332:             .FontSize   = 14

*-- Linhas 1367 a 1429:
1367:             .RowHeight    = 16
1368:             .ScrollBars   = 2
1369:             .GridLineColor = RGB(238, 238, 238)
1370:             .DeleteMark   = .F.
1371:             .RecordMark   = .T.
1372:             *-- Grid.ReadOnly propaga para as colunas: tem de vir ANTES delas.
1373:             .ReadOnly     = .T.
1374: 
1375:             .Column1.ControlSource = "cursor_4c_Linhas.Linhas"
1376:             .Column1.Header1.Caption = "Linha"
1377:             .Column1.Width     = 84
1378:             .Column1.Movable   = .F.
1379:             .Column1.Resizable = .F.
1380:             .Column1.Sparse    = .F.
1381:             .Column1.ReadOnly  = .T.
1382:             .Column1.ForeColor = RGB(36, 84, 155)
1383: 
1384:             .Column2.ControlSource = "cursor_4c_Linhas.Saldo"
1385:             .Column2.Header1.Caption = "Quantidade"
1386:             .Column2.Width     = 80
1387:             .Column2.Movable   = .F.
1388:             .Column2.Resizable = .F.
1389:             .Column2.Sparse    = .F.
1390:             .Column2.ReadOnly  = .T.
1391:             .Column2.Text1.InputMask = "999,999.99"
1392:             .Column2.Text1.MaxLength = 10
1393: 
1394:             .Column3.ControlSource = "cursor_4c_Linhas.Estoque"
1395:             .Column3.Header1.Caption = "Estoque"
1396:             .Column3.Width     = 80
1397:             .Column3.Movable   = .F.
1398:             .Column3.Resizable = .F.
1399:             .Column3.Sparse    = .F.
1400:             .Column3.ReadOnly  = .T.
1401:             .Column3.Text1.InputMask = "999,999.99"
1402:             .Column3.Text1.MaxLength = 10
1403: 
1404:             .Column4.ControlSource = "cursor_4c_Linhas.Fabrs"
1405:             .Column4.Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
1406:             .Column4.Width     = 80
1407:             .Column4.Movable   = .F.
1408:             .Column4.Resizable = .F.
1409:             .Column4.Sparse    = .F.
1410:             .Column4.ReadOnly  = .T.
1411:             .Column4.Text1.InputMask = "999,999.99"
1412:             .Column4.Text1.MaxLength = 10
1413: 
1414:             .Column5.ControlSource = "cursor_4c_Linhas.Produzir"
1415:             .Column5.Header1.Caption = "Produzir"
1416:             .Column5.Width     = 80
1417:             .Column5.Movable   = .F.
1418:             .Column5.Resizable = .F.
1419:             .Column5.Sparse    = .F.
1420:             .Column5.ReadOnly  = .T.
1421:             .Column5.Text1.InputMask = "999,999.99"
1422:             .Column5.Text1.MaxLength = 10
1423:         ENDWITH
1424: 
1425:         FOR loc_nCol = 1 TO 5
1426:             WITH EVALUATE("loc_oPag3.grd_4c_Linhas.Column" + TRANSFORM(loc_nCol) + ".Header1")
1427:                 .FontName  = "Tahoma"
1428:                 .FontSize  = 8
1429:                 .Alignment = 2

*-- Linhas 1487 a 1505:
1487: 
1488:         SET NULL ON
1489:         IF !USED("cursor_4c_DispEstoque")
1490:             CREATE CURSOR cursor_4c_DispEstoque ;
1491:                 (Priors N(2) NULL, Grupos C(10) NULL, Estos C(10) NULL, ;
1492:                  Cpros C(14) NULL, CodCors C(10) NULL, CodTams C(10) NULL, ;
1493:                  Disps N(12,3) NULL, Utilizar N(12,3) NULL)
1494:         ENDIF
1495:         SET NULL OFF
1496: 
1497:         *-- Titulo da sub-tela (Label1 + Shape4) ----------------------------
1498:         loc_oPag4.AddObject("lbl_4c_Label1", "Label")
1499:         WITH loc_oPag4.lbl_4c_Label1
1500:             .AutoSize   = .F.
1501:             .Top        = 138
1502:             .Left       = 197
1503:             .Width      = 184
1504:             .Height     = 25
1505:             .FontName   = "Tahoma"

*-- Linhas 1533 a 1609:
1533:             .Margin        = 0
1534:             .ReadOnly      = .T.
1535:             .ForeColor     = RGB(0, 0, 255)
1536:             .ControlSource = "TmpFinalg.Cpros"
1537:         ENDWITH
1538: 
1539:         *-- Grade de disponivel por grupo/conta (GradeDisp / TmpSaldG) ------
1540:         loc_oPag4.AddObject("grd_4c_DispEstoque", "Grid")
1541: 
1542:         *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
1543:         *-- antes de o bloco abaixo acessar .Column1..Column5.
1544:         loc_oPag4.grd_4c_DispEstoque.RecordSource = ""
1545:         loc_oPag4.grd_4c_DispEstoque.ColumnCount  = 5
1546:         loc_oPag4.grd_4c_DispEstoque.RecordSource = "cursor_4c_DispEstoque"
1547: 
1548:         WITH loc_oPag4.grd_4c_DispEstoque
1549:             .Top          = 169
1550:             .Left         = 191
1551:             .Width        = 370
1552:             .Height       = 244
1553:             .FontSize     = 8
1554:             .AllowHeaderSizing = .F.
1555:             .AllowRowSizing    = .F.
1556:             .RowHeight    = 16
1557:             .ScrollBars   = 2
1558:             .GridLineColor = RGB(238, 238, 238)
1559:             .DeleteMark   = .F.
1560:             .RecordMark   = .T.
1561:             .Panel        = 1
1562:             *-- Grid.ReadOnly ANTES das colunas: ele propaga e sobrescreveria
1563:             *-- o ReadOnly = .F. da coluna Utilizar.
1564:             .ReadOnly     = .F.
1565: 
1566:             .Column1.ControlSource = "cursor_4c_DispEstoque.Grupos"
1567:             .Column1.Header1.Caption = "Grupo"
1568:             .Column1.Width     = 80
1569:             .Column1.Movable   = .F.
1570:             .Column1.Resizable = .F.
1571:             .Column1.ReadOnly  = .T.
1572: 
1573:             .Column2.ControlSource = "cursor_4c_DispEstoque.Estos"
1574:             .Column2.Header1.Caption = "Conta"
1575:             .Column2.Width     = 80
1576:             .Column2.Movable   = .F.
1577:             .Column2.Resizable = .F.
1578:             .Column2.ReadOnly  = .T.
1579: 
1580:             .Column3.ControlSource = "cursor_4c_DispEstoque.Priors"
1581:             .Column3.Header1.Caption = "Prior"
1582:             .Column3.Width     = 24
1583:             .Column3.Movable   = .F.
1584:             .Column3.Resizable = .F.
1585:             .Column3.ReadOnly  = .T.
1586: 
1587:             .Column4.ControlSource = "cursor_4c_DispEstoque.Disps"
1588:             .Column4.Header1.Caption = "Disponivel"
1589:             .Column4.Width     = 75
1590:             .Column4.Movable   = .F.
1591:             .Column4.Resizable = .F.
1592:             .Column4.ReadOnly  = .T.
1593: 
1594:             .Column5.ControlSource = "cursor_4c_DispEstoque.Utilizar"
1595:             .Column5.Header1.Caption = "Utilizar"
1596:             .Column5.Width     = 75
1597:             .Column5.Movable   = .F.
1598:             .Column5.Resizable = .F.
1599:             .Column5.ReadOnly  = .F.
1600:             .Column5.Text1.FontBold = .T.
1601:         ENDWITH
1602:         BINDEVENT(loc_oPag4.grd_4c_DispEstoque.Column5.Text1, "Valid", THIS, "GradeDispEstoqueColumn5Valid")
1603:         BINDEVENT(loc_oPag4.grd_4c_DispEstoque.Column5.Text1, "KeyPress", THIS, "GradeDispColumn5LostFocus")
1604: 
1605:         FOR loc_nCol = 1 TO 5
1606:             WITH EVALUATE("loc_oPag4.grd_4c_DispEstoque.Column" + TRANSFORM(loc_nCol) + ".Header1")
1607:                 .FontName  = "Verdana"
1608:                 .FontSize  = 8
1609:                 .Alignment = 2

*-- Linhas 1711 a 1729:
1711: 
1712:         SET NULL ON
1713:         IF !USED("cursor_4c_DispTamanho")
1714:             CREATE CURSOR cursor_4c_DispTamanho ;
1715:                 (Cpros C(14) NULL, CodCors C(10) NULL, CodTams C(10) NULL, ;
1716:                  Disps N(12,3) NULL, Utilizar N(12,3) NULL)
1717:         ENDIF
1718:         SET NULL OFF
1719: 
1720:         loc_oPag5.AddObject("lbl_4c_Label1", "Label")
1721:         WITH loc_oPag5.lbl_4c_Label1
1722:             .AutoSize   = .F.
1723:             .Top        = 150
1724:             .Left       = 246
1725:             .Width      = 205
1726:             .Height     = 25
1727:             .FontName   = "Tahoma"
1728:             .FontSize   = 14
1729:             .FontBold   = .T.

*-- Linhas 1752 a 1828:
1752:             .Margin        = 0
1753:             .ReadOnly      = .T.
1754:             .ForeColor     = RGB(0, 0, 255)
1755:             .ControlSource = "TmpFinalg.Cpros"
1756:         ENDWITH
1757: 
1758:         loc_oPag5.AddObject("grd_4c_DispTamanho", "Grid")
1759: 
1760:         *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
1761:         *-- antes de o bloco abaixo acessar .Column1..Column5.
1762:         loc_oPag5.grd_4c_DispTamanho.RecordSource = ""
1763:         loc_oPag5.grd_4c_DispTamanho.ColumnCount  = 5
1764:         loc_oPag5.grd_4c_DispTamanho.RecordSource = "cursor_4c_DispTamanho"
1765: 
1766:         WITH loc_oPag5.grd_4c_DispTamanho
1767:             .Top          = 181
1768:             .Left         = 239
1769:             .Width        = 327
1770:             .Height       = 228
1771:             .FontName     = "Tahoma"
1772:             .FontSize     = 8
1773:             .AllowHeaderSizing = .F.
1774:             .AllowRowSizing    = .F.
1775:             .RowHeight    = 16
1776:             .ScrollBars   = 2
1777:             .GridLineColor = RGB(238, 238, 238)
1778:             .DeleteMark   = .F.
1779:             .RecordMark   = .T.
1780:             .Panel        = 1
1781:             .ReadOnly     = .F.
1782: 
1783:             .Column1.ControlSource = "cursor_4c_DispTamanho.Cpros"
1784:             .Column1.Header1.Caption = "Produto"
1785:             .Column1.Width     = 80
1786:             .Column1.Movable   = .F.
1787:             .Column1.Resizable = .F.
1788:             .Column1.ReadOnly  = .T.
1789: 
1790:             .Column2.ControlSource = "cursor_4c_DispTamanho.CodCors"
1791:             .Column2.Header1.Caption = "Cor"
1792:             .Column2.Width     = 38
1793:             .Column2.Movable   = .F.
1794:             .Column2.Resizable = .F.
1795:             .Column2.ReadOnly  = .T.
1796:             .Column2.Text1.FontBold = .T.
1797: 
1798:             .Column3.ControlSource = "cursor_4c_DispTamanho.CodTams"
1799:             .Column3.Header1.Caption = "Tam"
1800:             .Column3.Width     = 24
1801:             .Column3.Movable   = .F.
1802:             .Column3.Resizable = .F.
1803:             .Column3.ReadOnly  = .T.
1804:             .Column3.Text1.FontBold = .T.
1805: 
1806:             .Column4.ControlSource = "cursor_4c_DispTamanho.Disps"
1807:             .Column4.Header1.Caption = "Disponivel"
1808:             .Column4.Width     = 75
1809:             .Column4.Movable   = .F.
1810:             .Column4.Resizable = .F.
1811:             .Column4.ReadOnly  = .T.
1812: 
1813:             .Column5.ControlSource = "cursor_4c_DispTamanho.Utilizar"
1814:             .Column5.Header1.Caption = "Utilizar"
1815:             .Column5.Width     = 75
1816:             .Column5.Movable   = .F.
1817:             .Column5.Resizable = .F.
1818:             .Column5.ReadOnly  = .F.
1819:             .Column5.Text1.FontBold = .T.
1820:         ENDWITH
1821:         BINDEVENT(loc_oPag5.grd_4c_DispTamanho.Column5.Text1, "Valid", THIS, "GradeDispTamanhoColumn5Valid")
1822:         BINDEVENT(loc_oPag5.grd_4c_DispTamanho.Column5.Text1, "KeyPress", THIS, "GradeDispColumn5LostFocus")
1823: 
1824:         FOR loc_nCol = 1 TO 5
1825:             WITH EVALUATE("loc_oPag5.grd_4c_DispTamanho.Column" + TRANSFORM(loc_nCol) + ".Header1")
1826:                 .FontName  = "Verdana"
1827:                 .FontSize  = 8
1828:                 .Alignment = 2

*-- Linhas 1942 a 1971:
1942: 
1943:         SET NULL ON
1944:         IF !USED("cursor_4c_Requisicao")
1945:             CREATE CURSOR cursor_4c_Requisicao ;
1946:                 (Cpros C(14) NULL, Dpros C(65) NULL, Cunis C(3) NULL, ;
1947:                  Qtds N(12,3) NULL, Cpro2s C(14) NULL)
1948:         ENDIF
1949:         SET NULL OFF
1950: 
1951:         *-- Linha em branco inicial (Init legado: If Reccount('SelPedra') = 0
1952:         *-- / Append Blank) - sem ela a grade abre sem nenhuma celula onde
1953:         *-- digitar o primeiro material.
1954:         IF USED("cursor_4c_Requisicao")
1955:             IF RECCOUNT("cursor_4c_Requisicao") = 0
1956:                 SELECT cursor_4c_Requisicao
1957:                 APPEND BLANK
1958:                 REPLACE Cpros WITH "", Dpros WITH "", Cunis WITH "", ;
1959:                         Qtds  WITH 0,  Cpro2s WITH "" IN cursor_4c_Requisicao
1960:                 GO TOP IN cursor_4c_Requisicao
1961:             ENDIF
1962:         ENDIF
1963: 
1964:         *-- Titulo da sub-tela (Label1 + Shape4) ----------------------------
1965:         loc_oPag6.AddObject("lbl_4c_Label1", "Label")
1966:         WITH loc_oPag6.lbl_4c_Label1
1967:             .AutoSize   = .F.
1968:             .Top        = 168
1969:             .Left       = 132
1970:             .Width      = 294
1971:             .Height     = 25

*-- Linhas 1998 a 2093:
1998:             .Margin        = 0
1999:             .ReadOnly      = .T.
2000:             .ForeColor     = RGB(0, 0, 255)
2001:             .ControlSource = "TmpFinalg.Cpros"
2002:         ENDWITH
2003: 
2004:         *-- Grade de requisicao manual (GradePedra / SelPedra) --------------
2005:         loc_oPag6.AddObject("grd_4c_Pedra", "Grid")
2006: 
2007:         *-- RecordSource/ColumnCount FORA do WITH: as colunas tem de existir
2008:         *-- antes de o bloco abaixo acessar .Column1..Column5.
2009:         loc_oPag6.grd_4c_Pedra.RecordSource = ""
2010:         loc_oPag6.grd_4c_Pedra.ColumnCount  = 5
2011:         loc_oPag6.grd_4c_Pedra.RecordSource = "cursor_4c_Requisicao"
2012: 
2013:         WITH loc_oPag6.grd_4c_Pedra
2014:             .Top          = 197
2015:             .Left         = 119
2016:             .Width        = 500
2017:             .Height       = 261
2018:             .FontSize     = 8
2019:             .RowHeight    = 16
2020:             .ScrollBars   = 2
2021:             .GridLineColor = RGB(238, 238, 238)
2022:             .DeleteMark   = .F.
2023:             .RecordMark   = .T.
2024:             *-- Grid.ReadOnly ANTES das colunas: propaga e sobrescreveria o
2025:             *-- ReadOnly = .F. das colunas digitaveis (1, 4 e 5).
2026:             .ReadOnly     = .F.
2027: 
2028:             .Column1.ControlSource = "cursor_4c_Requisicao.Cpros"
2029:             .Column1.Header1.Caption = "Produto"
2030:             .Column1.Width     = 80
2031:             .Column1.Movable   = .F.
2032:             .Column1.Resizable = .F.
2033:             .Column1.ReadOnly  = .F.
2034:             .Column1.Text1.BorderStyle = 0
2035:             .Column1.Text1.Margin      = 0
2036:             .Column1.Text1.MaxLength   = 14
2037:             .Column1.Text1.ForeColor   = RGB(0, 0, 0)
2038:             .Column1.Text1.BackColor   = RGB(255, 255, 255)
2039:             .Column1.Text1.ToolTipText = "F4 ou duplo clique: buscar produto"
2040: 
2041:             .Column2.ControlSource = "cursor_4c_Requisicao.Dpros"
2042:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2043:             .Column2.Width     = 200
2044:             .Column2.Movable   = .F.
2045:             .Column2.Resizable = .F.
2046:             .Column2.ReadOnly  = .T.
2047:             .Column2.Text1.FontBold    = .T.
2048:             .Column2.Text1.BorderStyle = 0
2049:             .Column2.Text1.Margin      = 0
2050:             .Column2.Text1.ReadOnly    = .T.
2051:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
2052:             .Column2.Text1.BackColor   = RGB(255, 255, 255)
2053: 
2054:             .Column3.ControlSource = "cursor_4c_Requisicao.Cunis"
2055:             .Column3.Header1.Caption = "Uni"
2056:             .Column3.Width     = 30
2057:             .Column3.Movable   = .F.
2058:             .Column3.Resizable = .F.
2059:             .Column3.ReadOnly  = .T.
2060:             .Column3.Text1.FontBold    = .T.
2061:             .Column3.Text1.BorderStyle = 0
2062:             .Column3.Text1.Margin      = 0
2063:             .Column3.Text1.ReadOnly    = .T.
2064:             .Column3.Text1.ForeColor   = RGB(0, 0, 0)
2065:             .Column3.Text1.BackColor   = RGB(255, 255, 255)
2066: 
2067:             .Column4.ControlSource = "cursor_4c_Requisicao.Qtds"
2068:             .Column4.Header1.Caption = "Qtde"
2069:             .Column4.Width     = 75
2070:             .Column4.Movable   = .F.
2071:             .Column4.Resizable = .F.
2072:             .Column4.ReadOnly  = .F.
2073:             .Column4.Text1.BorderStyle = 0
2074:             .Column4.Text1.Margin      = 0
2075:             .Column4.Text1.ForeColor   = RGB(0, 0, 0)
2076:             .Column4.Text1.BackColor   = RGB(255, 255, 255)
2077: 
2078:             .Column5.ControlSource = "cursor_4c_Requisicao.Cpro2s"
2079:             .Column5.Header1.Caption = "Produto"
2080:             .Column5.Width     = 80
2081:             .Column5.Movable   = .F.
2082:             .Column5.Resizable = .F.
2083:             .Column5.ReadOnly  = .F.
2084:             .Column5.Text1.BorderStyle = 0
2085:             .Column5.Text1.Margin      = 0
2086:             .Column5.Text1.MaxLength   = 14
2087:             .Column5.Text1.ForeColor   = RGB(0, 0, 0)
2088:             .Column5.Text1.BackColor   = RGB(255, 255, 255)
2089:             .Column5.Text1.ToolTipText = "F4 ou duplo clique: buscar produto substituto"
2090:         ENDWITH
2091: 
2092:         FOR loc_nCol = 1 TO 5
2093:             WITH EVALUATE("loc_oPag6.grd_4c_Pedra.Column" + TRANSFORM(loc_nCol) + ".Header1")

*-- Linhas 2177 a 2195:
2177:     *
2178:     * O Replace de Dpros/Cunis eh o que preenche as colunas Descricao e Uni,
2179:     * que sao ReadOnly e nao tem outra origem - sem ele a linha fica so com
2180:     * o codigo. Cunis vem junto do mesmo SELECT (por isso o lookup consulta
2181:     * CPros/DPros/Cunis, mesmo exibindo so as duas primeiras no picker,
2182:     * exatamente como o legado, cujo fwBuscaExt traz a linha inteira).
2183:     *--------------------------------------------------------------------------
2184:     PROCEDURE AbrirLookupProdutoRequisicao()
2185:         LOCAL loc_oBusca, loc_cValor, loc_oErro
2186:         LOCAL loc_oGrade, loc_oCampo
2187: 
2188:         IF THIS.this_lLookupEmCurso
2189:             RETURN
2190:         ENDIF
2191:         THIS.this_lLookupEmCurso = .T.
2192: 
2193:         TRY
2194:             loc_oGrade = THIS.pgf_4c_1.Page6.grd_4c_Pedra
2195:             loc_oCampo = loc_oGrade.Column1.Text1

*-- Linhas 2362 a 2402:
2362:     * GarantirLinhaLivreRequisicao - transcricao do LostFocus de
2363:     * SIGPRGLX.PageDados.Page6.GradePedra.Column5.Text1:
2364:     *
2365:     *   SELECT SelPedra
2366:     *   xPosicao = RECNO()
2367:     *   Locate For Empty(Cpros)
2368:     *   If Eof()
2369:     *       Append Blank
2370:     *   EndIf
2371:     *   Locate for Recno() = xPosicao
2372:     *
2373:     * Mantem sempre ao menos uma linha em branco disponivel na grade e
2374:     * devolve o ponteiro para onde o usuario estava. O KEYBOARD '{DNARROW}'
2375:     * do legado (que empurra o cursor para a linha de baixo) nao eh
2376:     * reproduzido aqui: la ele vinha do LostFocus real da celula; neste
2377:     * ponto o foco ja voltou do picker e o salto adicional tiraria o
2378:     * usuario da linha que ele acabou de preencher.
2379:     *--------------------------------------------------------------------------
2380:     PROTECTED PROCEDURE GarantirLinhaLivreRequisicao()
2381:         LOCAL loc_nPosicao
2382: 
2383:         IF !USED("cursor_4c_Requisicao")
2384:             RETURN
2385:         ENDIF
2386: 
2387:         SELECT cursor_4c_Requisicao
2388:         loc_nPosicao = RECNO()
2389: 
2390:         LOCATE FOR EMPTY(cursor_4c_Requisicao.Cpros)
2391:         IF EOF("cursor_4c_Requisicao")
2392:             APPEND BLANK
2393:             REPLACE Cpros WITH "", Dpros WITH "", Cunis WITH "", ;
2394:                     Qtds  WITH 0,  Cpro2s WITH "" IN cursor_4c_Requisicao
2395:         ENDIF
2396: 
2397:         IF loc_nPosicao > 0 AND loc_nPosicao <= RECCOUNT("cursor_4c_Requisicao")
2398:             GOTO loc_nPosicao IN cursor_4c_Requisicao
2399:         ENDIF
2400:     ENDPROC
2401: 
2402:     *--------------------------------------------------------------------------

*-- Linhas 2475 a 2493:
2475:         ENDIF
2476: 
2477:         IF !SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
2478:             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2479:         ENDIF
2480:         IF loc_nValorNovo != THIS.this_nOldValue AND TmpSaldU.KeySelmp
2481:             IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de OP." + CHR(13) + ;
2482:                     "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", ;
2483:                     "Confirmar")
2484:                 loc_oCampo.Value = THIS.this_nOldValue
2485:                 RETURN
2486:             ENDIF
2487:         ENDIF
2488: 
2489:         loc_lOk = .T.
2490:         DO CASE
2491:             CASE loc_nValorNovo = THIS.this_nOldValue
2492:                 * nada a fazer
2493:             CASE loc_nValorNovo < 0

*-- Linhas 2509 a 2574:
2509:                     REPLACE DispFs WITH Fabrs - loc_nValorNovo IN cursor_4c_TmpSaldo
2510:                     REPLACE Produzir WITH Saldo - Estoque - loc_nValorNovo IN TmpFinalg
2511: 
2512:                     SELECT TmpFinalg
2513:                     REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
2514:                             QtdMins - Produzir, 0), ;
2515:                             UsuLibs WITH " " IN TmpFinalg
2516: 
2517:                     REPLACE KeySelmp WITH .F. IN TmpSaldU
2518: 
2519:                     SELECT cursor_4c_TmpSaldo
2520:                     loc_nXBaixa = Fabrs - DispFs
2521:                     SELECT cursor_4c_TmpFabr
2522:                     SET ORDER TO Cpros
2523:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2524:                     REPLACE Disps WITH 0 WHILE cursor_4c_TmpFabr.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2525:                             cursor_4c_TmpFabr.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2526:                             cursor_4c_TmpFabr.CodTams = cursor_4c_TmpSaldo.CodTams
2527:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2528:                     SCAN WHILE cursor_4c_TmpFabr.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2529:                             cursor_4c_TmpFabr.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2530:                             cursor_4c_TmpFabr.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
2531:                         IF (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps) >= loc_nXBaixa
2532:                             REPLACE cursor_4c_TmpFabr.Disps WITH cursor_4c_TmpFabr.Disps + loc_nXBaixa
2533:                             loc_nXBaixa = 0
2534:                         ELSE
2535:                             loc_nXBaixa = loc_nXBaixa - (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps)
2536:                             REPLACE cursor_4c_TmpFabr.Disps WITH cursor_4c_TmpFabr.Qtds
2537:                         ENDIF
2538:                         SELECT cursor_4c_TmpFabr
2539:                     ENDSCAN
2540: 
2541:                     loc_nXBaixa = loc_nValorNovo
2542:                     SELECT TmpFinal
2543:                     SET ORDER TO
2544:                     SET ORDER TO Cpros
2545:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2546:                     REPLACE Fabrs WITH 0 WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2547:                             TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams
2548:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2549:                     SCAN WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors ;
2550:                             AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa >= 0
2551:                         IF (TmpFinal.Saldo - TmpFinal.Estoque) >= loc_nXBaixa
2552:                             REPLACE TmpFinal.Fabrs WITH TmpFinal.Fabrs + loc_nXBaixa
2553:                             loc_nXBaixa = 0
2554:                         ELSE
2555:                             loc_nXBaixa = loc_nXBaixa - (TmpFinal.Saldo - TmpFinal.Estoque)
2556:                             REPLACE TmpFinal.Fabrs WITH (TmpFinal.Saldo - TmpFinal.Estoque)
2557:                         ENDIF
2558:                         REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
2559:                         SELECT TmpFinal
2560:                     ENDSCAN
2561:                 ELSE
2562:                     MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto Em " + ;
2563:                         "Produ" + CHR(231) + CHR(227) + "o para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
2564:                     loc_lOk = .F.
2565:                 ENDIF
2566:         ENDCASE
2567: 
2568:         IF !loc_lOk
2569:             loc_oCampo.Value = THIS.this_nOldValue
2570:         ENDIF
2571:     ENDPROC
2572: 
2573:     *--------------------------------------------------------------------------
2574:     * GradeItensPage1Column10Valid - transcricao de GradeItens.Column10.Text1.

*-- Linhas 2603 a 2621:
2603:         ENDIF
2604: 
2605:         IF !SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
2606:             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2607:         ENDIF
2608:         IF loc_nValorNovo != THIS.this_nOldValue AND TmpSaldU.KeySelm
2609:             IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque." + CHR(13) + ;
2610:                     "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", ;
2611:                     "Confirmar")
2612:                 loc_oCampo.Value = THIS.this_nOldValue
2613:                 RETURN
2614:             ENDIF
2615:         ENDIF
2616: 
2617:         loc_lOk = .T.
2618:         DO CASE
2619:             CASE loc_nValorNovo = THIS.this_nOldValue
2620:                 * nada a fazer
2621:             CASE loc_nValorNovo < 0

*-- Linhas 2637 a 2718:
2637:                     REPLACE Disps WITH Saldo - loc_nValorNovo IN cursor_4c_TmpSaldo
2638:                     REPLACE Produzir WITH Saldo - Fabrs - loc_nValorNovo IN TmpFinalg
2639: 
2640:                     SELECT TmpFinalg
2641:                     REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
2642:                             QtdMins - Produzir, 0), ;
2643:                             UsuLibs WITH " " IN TmpFinalg
2644: 
2645:                     REPLACE KeySelm WITH .F. IN TmpSaldU
2646: 
2647:                     SELECT cursor_4c_TmpSaldo
2648:                     loc_nXBaixa = Saldo - Disps
2649: 
2650:                     SELECT cursor_4c_TmpSaldg
2651:                     SET ORDER TO CPros
2652:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2653:                     REPLACE Disps WITH Saldo WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2654:                             cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2655:                             cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams
2656:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2657:                     SCAN WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2658:                             cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2659:                             cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
2660:                         IF cursor_4c_TmpSaldg.Disps >= loc_nXBaixa
2661:                             REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldg.Disps - loc_nXBaixa
2662:                             loc_nXBaixa = 0
2663:                         ELSE
2664:                             loc_nXBaixa = loc_nXBaixa - cursor_4c_TmpSaldg.Disps
2665:                             REPLACE cursor_4c_TmpSaldg.Disps WITH 0
2666:                         ENDIF
2667:                         SELECT cursor_4c_TmpSaldg
2668:                     ENDSCAN
2669: 
2670:                     loc_nXBaixa = loc_nValorNovo
2671:                     SELECT TmpFinal
2672:                     SET ORDER TO
2673:                     SET ORDER TO Cpros
2674:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2675:                     REPLACE Estoque WITH 0 WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2676:                             TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2677:                             TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams
2678:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
2679:                     SCAN WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
2680:                             TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
2681:                             TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
2682:                         IF (TmpFinal.Saldo - TmpFinal.Fabrs) >= loc_nXBaixa
2683:                             REPLACE TmpFinal.Estoque WITH TmpFinal.Estoque + loc_nXBaixa IN TmpFinal
2684:                             loc_nXBaixa = 0
2685:                         ELSE
2686:                             loc_nXBaixa = loc_nXBaixa - (TmpFinal.Saldo - TmpFinal.Fabrs)
2687:                             REPLACE TmpFinal.Estoque WITH (TmpFinal.Saldo - TmpFinal.Fabrs) IN TmpFinal
2688:                         ENDIF
2689:                         REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
2690:                         SELECT TmpFinal
2691:                     ENDSCAN
2692:                 ELSE
2693:                     MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto no " + ;
2694:                         "estoque para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
2695:                     loc_lOk = .F.
2696:                 ENDIF
2697:         ENDCASE
2698: 
2699:         IF !loc_lOk
2700:             loc_oCampo.Value = THIS.this_nOldValue
2701:         ENDIF
2702: 
2703:         SELECT TmpFinalg
2704:     ENDPROC
2705: 
2706:     *--------------------------------------------------------------------------
2707:     * AtualizarVisibilidadeDisponivel - "When" de GradeItens.Column10.Text1
2708:     * (Page1, dump 7029-7043): o botao "Disponiveis" so aparece quando o
2709:     * form esta em modo RESERVA, o item corrente ainda nao tem estoque
2710:     * reservado e o GRUPO do produto eh de tipo de estoque 3 ou 4.
2711:     *
2712:     *   ThisForm.PageDados.Page1.Disponivel.Visible = .f.
2713:     *   If ThisForm.Reserva And TmpFinalg.Estoque = 0
2714:     *       ... CursorQuery SigCdPro -> Cgrus -> SigCdGrp -> TipoEstos
2715:     *       If InList(CrSigCdGrp.TipoEstos,3,4) -> Visible = .t.
2716:     *
2717:     * Vive num metodo proprio, chamado de AfterRowColChange (troca de item)
2718:     * e de CarregarLista (primeira linha), porque BINDEVENT em "When" de

*-- Linhas 2771 a 2789:
2771:             RETURN
2772:         ENDIF
2773: 
2774:         SELECT TmpFinalg
2775:         loc_nRecno = RECNO()
2776:         SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
2777:         IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("TmpFinalg")
2778:             GOTO loc_nRecno
2779:         ENDIF
2780: 
2781:         WITH THIS.pgf_4c_1.Page1
2782:             .txt_4c_Tot_Qtd.Value  = loc_nSal
2783:             .txt_4c_Tot_Est.Value  = loc_nEst
2784:             .txt_4c_Tot_prdc.Value = loc_nPrc
2785:             .txt_4c_Tot_Prz.Value  = loc_nPrz
2786:             .txt_4c_Tot_prze.Value = loc_nPrze
2787:             .txt_4c_Tot_Qtd.Refresh()
2788:             .txt_4c_Tot_Est.Refresh()
2789:             .txt_4c_Tot_prdc.Refresh()

*-- Linhas 2833 a 2868:
2833:         *-- ao SET EXACT. Mesmo remedio ja adotado no irmao FormSigPrGlp.
2834:         loc_cFiltro = "Cpros + CodCors + CodTams == [" + loc_cChave + "]"
2835: 
2836:         SELECT cursor_4c_TmpSaldg
2837:         SET ORDER TO CPros
2838:         SET KEY TO
2839:         SET FILTER TO &loc_cFiltro
2840:         GO TOP
2841: 
2842:         WITH loc_oPag1.cnt_4c_Container3
2843:             .txt_4c_Tot_Qtd.Value = TratarNulo(cursor_4c_TmpSaldo.Saldo, 0)
2844:             .txt_4c_Tot_Est.Value = TratarNulo(cursor_4c_TmpSaldo.Saldo, 0) - TratarNulo(cursor_4c_TmpSaldo.Disps, 0)
2845:             .txt_4c_Tot_Prz.Value = TratarNulo(cursor_4c_TmpSaldo.Disps, 0)
2846:             .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel " + ALLTRIM(TmpFinalg.Cpros) + ;
2847:                 IIF(!EMPTY(TmpFinalg.CodCors), " Cor:" + ALLTRIM(TmpFinalg.CodCors), "") + ;
2848:                 IIF(!EMPTY(TmpFinalg.CodTams), " Tam:" + ALLTRIM(TmpFinalg.CodTams), "")
2849:             .grd_4c_DispGrupo.Refresh()
2850:             .Visible     = .T.
2851:         ENDWITH
2852: 
2853:         SELECT cursor_4c_TmpFabr
2854:         SET ORDER TO Cpros
2855:         SET KEY TO
2856:         SET FILTER TO &loc_cFiltro
2857:         GO TOP
2858: 
2859:         WITH loc_oPag1.cnt_4c_Container1
2860:             .txt_4c_Tot_Qtd.Value = TratarNulo(cursor_4c_TmpSaldo.Fabrs, 0)
2861:             .txt_4c_Tot_Est.Value = TratarNulo(cursor_4c_TmpSaldo.Fabrs, 0) - TratarNulo(cursor_4c_TmpSaldo.DispFs, 0)
2862:             .grd_4c_DispFase.Refresh()
2863:             .Visible     = .T.
2864:         ENDWITH
2865: 
2866:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2867:             loc_cArquivo = ADDBS(SYS(2023)) + "TempGlb_" + SYS(3) + ".jpg"
2868:             loc_oPag1.img_4c_FigJpg.Picture = ""

*-- Linhas 2876 a 2894:
2876:         *-- "Disponiveis" eh decidido POR ITEM (When de Column10 no legado)
2877:         THIS.AtualizarVisibilidadeDisponivel()
2878: 
2879:         SELECT TmpFinalg
2880:     ENDPROC
2881: 
2882:     *--------------------------------------------------------------------------
2883:     * GradeDispGrupoColumn6LostFocus / GradeDispFaseColumn4LostFocus -
2884:     * "Skip / Skip -1 / Grid.Refresh" do legado (dump 4439-4444, 6625-6630,
2885:     * 6647-6654): forca a grade a repintar apos editar a coluna Prior.
2886:     *--------------------------------------------------------------------------
2887:     PROCEDURE GradeDispGrupoColumn6LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2888:         THIS.pgf_4c_1.Page1.cnt_4c_Container3.grd_4c_DispGrupo.Refresh()
2889:     ENDPROC
2890: 
2891:     PROCEDURE GradeDispFaseColumn4LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2892:         THIS.pgf_4c_1.Page1.cnt_4c_Container1.grd_4c_DispFase.Refresh()
2893:     ENDPROC
2894: 

*-- Linhas 2934 a 2952:
2934:     * GradeItensPage2Column7Valid / Column10Valid - transcricao de
2935:     * GradeItens.Column7/Column10.Text1.Valid da Page2 (dump 7357-7379,
2936:     * 7477-7499): validacao PURA de faixa (sem redistribuicao - o
2937:     * ControlSource do Grid ja grava o valor em TmpFinal.Estoque/Fabrs).
2938:     *--------------------------------------------------------------------------
2939:     PROCEDURE GradeItensPage2Column7Valid()
2940:         LOCAL loc_oCampo, loc_nPSaldo
2941: 
2942:         loc_oCampo = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column7.Text1
2943:         loc_nPSaldo = THIS.pgf_4c_1.Page2.txt_4c_Tot_sEst.Value
2944: 
2945:         IF !USED("TmpFinal") OR EOF("TmpFinal") OR loc_oCampo.Value = THIS.this_nOldValue
2946:             RETURN
2947:         ENDIF
2948: 
2949:         DO CASE
2950:             CASE loc_oCampo.Value < 0
2951:                 MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
2952:                 loc_oCampo.Value = THIS.this_nOldValue

*-- Linhas 2999 a 3017:
2999:             RETURN
3000:         ENDIF
3001: 
3002:         SELECT TmpFinal
3003:         loc_nRecno = RECNO()
3004:         SUM Saldo, Estoque, Produzir, Fabrs TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
3005:         IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("TmpFinal")
3006:             GOTO loc_nRecno
3007:         ENDIF
3008: 
3009:         WITH THIS.pgf_4c_1.Page2
3010:             .txt_4c_Tot_Qtd.Value = loc_nSal
3011:             .txt_4c_Tot_Est.Value = loc_nEst
3012:             .txt_4c_Tot_prc.Value = loc_nPrc
3013:             .txt_4c_Tot_Prz.Value = loc_nPrz
3014:             .txt_4c_Tot_Qtd.Refresh()
3015:             .txt_4c_Tot_Est.Refresh()
3016:             .txt_4c_Tot_prc.Refresh()
3017:             .txt_4c_Tot_Prz.Refresh()

*-- Linhas 3048 a 3066:
3048:             ENDIF
3049:         ENDIF
3050: 
3051:         SELECT TmpFinal
3052:     ENDPROC
3053: 
3054:     *--------------------------------------------------------------------------
3055:     * GradeDispEstoqueColumn5Valid / GradeDispTamanhoColumn5Valid -
3056:     * transcricao de Page4/Page5.GradeDisp.Column5.Text1.Valid (dump
3057:     * 7754-7785, 8030-8057): valida a quantidade "Utilizar" contra o
3058:     * disponivel da linha e contra o saldo total ainda nao atendido
3059:     * (Qt_pedida), e atualiza Qt_Selec com a soma de Utilizar da grade.
3060:     *--------------------------------------------------------------------------
3061:     PROCEDURE GradeDispEstoqueColumn5Valid()
3062:         LOCAL loc_oCampo, loc_nPSaldo, loc_nQtdUti, loc_nRecno
3063: 
3064:         loc_oCampo = THIS.pgf_4c_1.Page4.grd_4c_DispEstoque.Column5.Text1
3065: 
3066:         IF !USED("TmpFinalg") OR EOF("TmpFinalg") OR !USED("cursor_4c_DispEstoque")

*-- Linhas 3083 a 3101:
3083:         ENDIF
3084: 
3085:         loc_nRecno = RECNO("cursor_4c_DispEstoque")
3086:         SELECT cursor_4c_DispEstoque
3087:         SUM Utilizar TO loc_nQtdUti
3088:         IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("cursor_4c_DispEstoque")
3089:             GOTO loc_nRecno
3090:         ENDIF
3091: 
3092:         IF loc_nQtdUti > loc_nPSaldo
3093:             MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Solicitada...", "Aten" + CHR(231) + CHR(227) + "o")
3094:             loc_oCampo.Value = 0
3095:             loc_oCampo.Refresh()
3096:             RETURN
3097:         ENDIF
3098: 
3099:         THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Value = loc_nQtdUti
3100:         THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Refresh()
3101:     ENDPROC

*-- Linhas 3119 a 3137:
3119:         ENDIF
3120: 
3121:         loc_nRecno = RECNO("cursor_4c_DispTamanho")
3122:         SELECT cursor_4c_DispTamanho
3123:         SUM Utilizar TO loc_nQtdUti
3124:         IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("cursor_4c_DispTamanho")
3125:             GOTO loc_nRecno
3126:         ENDIF
3127: 
3128:         IF loc_nQtdUti > loc_nPSaldo
3129:             MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Pedida...", "Aten" + CHR(231) + CHR(227) + "o")
3130:             loc_oCampo.Value = 0
3131:             loc_oCampo.Refresh()
3132:             RETURN
3133:         ENDIF
3134: 
3135:         THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Value = loc_nQtdUti
3136:         THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Refresh()
3137:     ENDPROC

*-- Linhas 3219 a 3237:
3219:         loc_nEstoque = TmpFinalg.Estoque
3220:         loc_nFabrica = TmpFinalg.Fabrs
3221: 
3222:         SELECT TmpFinal
3223:         SUM Saldo, Estoque, Produzir, Fabrs TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
3224:         GO TOP
3225: 
3226:         IF loc_nEst != loc_nEstoque
3227:             MsgAviso("A quantidade de Estoque n" + CHR(227) + "o confere com a Quantidade Selecionada!!!", "Aten" + CHR(231) + CHR(227) + "o")
3228:             RETURN
3229:         ENDIF
3230:         IF loc_nPrc != loc_nFabrica
3231:             MsgAviso("A quantidade de Produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o confere com a Quantidade Selecionada!!!", "Aten" + CHR(231) + CHR(227) + "o")
3232:             RETURN
3233:         ENDIF
3234: 
3235:         THIS.pgf_4c_1.Page1.Enabled = .T.
3236:         THIS.AlternarPagina(1)
3237:         THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()

*-- Linhas 3267 a 3302:
3267:             USE IN TmpLinha
3268:         ENDIF
3269: 
3270:         SELECT Linhas, 0 AS Ordem, SUM(saldo) AS saldo, SUM(estoque) AS estoque, ;
3271:                 SUM(produzir) AS produzir, SUM(Fabrs) AS Fabrs ;
3272:             FROM TmpFinalg GROUP BY 1 ;
3273:             UNION ALL ;
3274:             SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS ordem, SUM(saldo) AS saldo, SUM(estoque) AS estoque, ;
3275:                 SUM(produzir) AS produzir, SUM(Fabrs) AS Fabrs ;
3276:             FROM TmpFinalg GROUP BY 1 ;
3277:             INTO CURSOR TmpLinha ORDER BY 2, 1
3278: 
3279:         loc_oGrid = THIS.pgf_4c_1.Page3.grd_4c_Linhas
3280:         loc_oGrid.RecordSource = ""
3281:         loc_oGrid.ColumnCount  = 5
3282:         loc_oGrid.RecordSource = "TmpLinha"
3283:         loc_oGrid.Column1.ControlSource = "TmpLinha.Linhas"
3284:         loc_oGrid.Column2.ControlSource = "TmpLinha.Saldo"
3285:         loc_oGrid.Column3.ControlSource = "TmpLinha.Estoque"
3286:         loc_oGrid.Column4.ControlSource = "TmpLinha.Fabrs"
3287:         loc_oGrid.Column5.ControlSource = "TmpLinha.Produzir"
3288: 
3289:         *-- ColumnCount reatribuido RESETA Header1.Caption/Width/ReadOnly/
3290:         *-- Movable/Resizable/Sparse de TODAS as colunas (medido no VFP9 -
3291:         *-- regra do Problema 48/Pattern #180) - reconfigurar na mesma
3292:         *-- ordem de ConfigurarPaginaTotaisLinha.
3293:         loc_oGrid.Column1.Header1.Caption = "Linha"
3294:         loc_oGrid.Column1.Width     = 84
3295:         loc_oGrid.Column1.Movable   = .F.
3296:         loc_oGrid.Column1.Resizable = .F.
3297:         loc_oGrid.Column1.Sparse    = .F.
3298:         loc_oGrid.Column1.ReadOnly  = .T.
3299:         loc_oGrid.Column1.ForeColor = RGB(36, 84, 155)
3300: 
3301:         loc_oGrid.Column2.Header1.Caption = "Quantidade"
3302:         loc_oGrid.Column2.Width     = 80

*-- Linhas 3377 a 3414:
3377:             USE IN cursor_4c_DispEstoque
3378:         ENDIF
3379: 
3380:         SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, 0 AS Utilizar ;
3381:             FROM cursor_4c_TmpSaldg ;
3382:             WHERE Cpros = loc_cCpro AND CodCors = loc_cCor AND CodTams = loc_cTam AND Disps > 0 ;
3383:             ORDER BY 1, 2, 3, 4 ;
3384:             INTO CURSOR cursor_4c_DispEstoque READWRITE
3385: 
3386:         IF RECCOUNT("cursor_4c_DispEstoque") = 0
3387:             MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "Aten" + CHR(231) + CHR(227) + "o")
3388:             THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3389:             RETURN
3390:         ENDIF
3391: 
3392:         loc_oGrid = THIS.pgf_4c_1.Page4.grd_4c_DispEstoque
3393:         loc_oGrid.ColumnCount = 5
3394:         loc_oGrid.RecordSource = "cursor_4c_DispEstoque"
3395:         loc_oGrid.Column1.ControlSource = "cursor_4c_DispEstoque.Grupos"
3396:         loc_oGrid.Column2.ControlSource = "cursor_4c_DispEstoque.Estos"
3397:         loc_oGrid.Column3.ControlSource = "cursor_4c_DispEstoque.Priors"
3398:         loc_oGrid.Column4.ControlSource = "cursor_4c_DispEstoque.Disps"
3399:         loc_oGrid.Column5.ControlSource = "cursor_4c_DispEstoque.Utilizar"
3400: 
3401:         *-- RecordSource reatribuido RESETA Header1.Caption/Width/ReadOnly de
3402:         *-- TODAS as colunas (medido no VFP9 - regra do Problema 48/Pattern
3403:         *-- #180) - reconfigurar na mesma ordem de ConfigurarPaginaEstoque.
3404:         loc_oGrid.Column1.Header1.Caption = "Grupo"
3405:         loc_oGrid.Column1.Width     = 80
3406:         loc_oGrid.Column1.ReadOnly  = .T.
3407:         loc_oGrid.Column2.Header1.Caption = "Conta"
3408:         loc_oGrid.Column2.Width     = 80
3409:         loc_oGrid.Column2.ReadOnly  = .T.
3410:         loc_oGrid.Column3.Header1.Caption = "Prior"
3411:         loc_oGrid.Column3.Width     = 24
3412:         loc_oGrid.Column3.ReadOnly  = .T.
3413:         loc_oGrid.Column4.Header1.Caption = "Disponivel"
3414:         loc_oGrid.Column4.Width     = 75

*-- Linhas 3460 a 3497:
3460:             USE IN cursor_4c_DispTamanho
3461:         ENDIF
3462: 
3463:         SELECT Cpros, CodCors, CodTams, Disps, 0 AS Utilizar ;
3464:             FROM cursor_4c_TmpSaldo ;
3465:             WHERE Cpros = loc_cCpro AND CodCors = loc_cCor AND Disps > 0 ;
3466:             ORDER BY 1, 2, 3 ;
3467:             INTO CURSOR cursor_4c_DispTamanho READWRITE
3468: 
3469:         IF RECCOUNT("cursor_4c_DispTamanho") = 0
3470:             MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel em Nenhum Tamanho!!!", "Aten" + CHR(231) + CHR(227) + "o")
3471:             THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3472:             RETURN
3473:         ENDIF
3474: 
3475:         loc_oGrid = THIS.pgf_4c_1.Page5.grd_4c_DispTamanho
3476:         loc_oGrid.ColumnCount = 5
3477:         loc_oGrid.RecordSource = "cursor_4c_DispTamanho"
3478:         loc_oGrid.Column1.ControlSource = "cursor_4c_DispTamanho.Cpros"
3479:         loc_oGrid.Column2.ControlSource = "cursor_4c_DispTamanho.CodCors"
3480:         loc_oGrid.Column3.ControlSource = "cursor_4c_DispTamanho.CodTams"
3481:         loc_oGrid.Column4.ControlSource = "cursor_4c_DispTamanho.Disps"
3482:         loc_oGrid.Column5.ControlSource = "cursor_4c_DispTamanho.Utilizar"
3483: 
3484:         *-- RecordSource reatribuido RESETA Header1.Caption/Width/ReadOnly de
3485:         *-- TODAS as colunas (medido no VFP9 - regra do Problema 48/Pattern
3486:         *-- #180) - reconfigurar na mesma ordem de ConfigurarPaginaTamanhos.
3487:         loc_oGrid.Column1.Header1.Caption = "Produto"
3488:         loc_oGrid.Column1.Width     = 80
3489:         loc_oGrid.Column1.ReadOnly  = .T.
3490:         loc_oGrid.Column2.Header1.Caption = "Cor"
3491:         loc_oGrid.Column2.Width     = 38
3492:         loc_oGrid.Column2.ReadOnly  = .T.
3493:         loc_oGrid.Column2.Text1.FontBold = .T.
3494:         loc_oGrid.Column3.Header1.Caption = "Tam"
3495:         loc_oGrid.Column3.Width     = 24
3496:         loc_oGrid.Column3.ReadOnly  = .T.
3497:         loc_oGrid.Column3.Text1.FontBold = .T.

*-- Linhas 3528 a 3601:
3528:         LOCAL loc_nQtdUti, loc_nLnQtUtil, loc_nXBaixa
3529: 
3530:         IF USED("cursor_4c_DispEstoque") AND RECCOUNT("cursor_4c_DispEstoque") > 0
3531:             SELECT cursor_4c_DispEstoque
3532:             SUM Utilizar TO loc_nQtdUti
3533: 
3534:             IF loc_nQtdUti > 0
3535:                 SELECT cursor_4c_DispEstoque
3536:                 SCAN
3537:                     IF cursor_4c_DispEstoque.Utilizar = 0
3538:                         LOOP
3539:                     ENDIF
3540:                     loc_nLnQtUtil = cursor_4c_DispEstoque.Utilizar
3541: 
3542:                     = SEEK(cursor_4c_DispEstoque.CPros + cursor_4c_DispEstoque.CodCors + cursor_4c_DispEstoque.CodTams, ;
3543:                         "cursor_4c_TmpSaldo", "CPros")
3544: 
3545:                     SELECT TmpFinalg
3546:                     REPLACE Produzir WITH Produzir - loc_nLnQtUtil, ;
3547:                             Estoque  WITH Estoque + loc_nLnQtUtil, ;
3548:                             UsuLibs  WITH " " IN TmpFinalg
3549: 
3550:                     SELECT cursor_4c_TmpSaldo
3551:                     REPLACE Disps WITH Disps - loc_nLnQtUtil IN cursor_4c_TmpSaldo
3552: 
3553:                     IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
3554:                         INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
3555:                     ENDIF
3556:                     REPLACE keySelm WITH .T. IN TmpSaldU
3557: 
3558:                     SELECT cursor_4c_TmpSaldg
3559:                     SET ORDER TO CPros
3560:                     = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams + ;
3561:                         STR(cursor_4c_DispEstoque.Priors, 2) + cursor_4c_DispEstoque.Grupos + cursor_4c_DispEstoque.Estos)
3562:                     REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldg.Disps - loc_nLnQtUtil
3563:                     SELECT cursor_4c_DispEstoque
3564:                 ENDSCAN
3565: 
3566:                 = SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, "cursor_4c_TmpSaldo", "CPros")
3567: 
3568:                 loc_nXBaixa = TmpFinalg.Estoque
3569:                 SELECT TmpFinal
3570:                 SET ORDER TO
3571:                 SET ORDER TO Cpros
3572:                 = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
3573:                 REPLACE Estoque WITH 0 WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
3574:                         TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams
3575:                 = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
3576:                 SCAN WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors ;
3577:                         AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
3578:                     IF (TmpFinal.Saldo - TmpFinal.Fabrs) >= loc_nXBaixa
3579:                         REPLACE TmpFinal.Estoque WITH TmpFinal.Estoque + loc_nXBaixa
3580:                         loc_nXBaixa = 0
3581:                     ELSE
3582:                         loc_nXBaixa = loc_nXBaixa - (TmpFinal.Saldo - TmpFinal.Fabrs)
3583:                         REPLACE TmpFinal.Estoque WITH (TmpFinal.Saldo - TmpFinal.Fabrs)
3584:                     ENDIF
3585:                     REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
3586:                     SELECT TmpFinal
3587:                 ENDSCAN
3588:             ENDIF
3589:         ENDIF
3590: 
3591:         THIS.AtualizarTotaisPage1()
3592: 
3593:         THIS.pgf_4c_1.Page1.Enabled = .T.
3594:         THIS.pgf_4c_1.Page2.Enabled = .T.
3595:         THIS.pgf_4c_1.Page3.Enabled = .F.
3596:         THIS.pgf_4c_1.Page4.Enabled = .F.
3597:         THIS.pgf_4c_1.Page5.Enabled = .F.
3598:         THIS.AlternarPagina(1)
3599:         THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3600:     ENDPROC
3601: 

*-- Linhas 3608 a 3741:
3608:     * nova linha com o tamanho escolhido).
3609:     *--------------------------------------------------------------------------
3610:     PROCEDURE BtnCancelaDispPage5Click()
3611:         LOCAL loc_nQtdUti, loc_nRegFinal, loc_nLnQtUtil, loc_cEdn, loc_cQuery
3612: 
3613:         IF !USED("TmpFinal") OR !USED("cursor_4c_DispTamanho")
3614:             THIS.AlternarPagina(1)
3615:             RETURN
3616:         ENDIF
3617: 
3618:         SELECT TmpFinal
3619:         SET ORDER TO
3620:         loc_nRegFinal = RECNO()
3621: 
3622:         SELECT cursor_4c_DispTamanho
3623:         SUM Utilizar TO loc_nQtdUti
3624: 
3625:         IF loc_nQtdUti > 0
3626:             IF USED("Temporario")
3627:                 USE IN Temporario
3628:             ENDIF
3629:             SELECT * FROM TmpFinal WHERE .F. INTO CURSOR Temporario READWRITE
3630: 
3631:             SELECT cursor_4c_DispTamanho
3632:             SCAN
3633:                 IF cursor_4c_DispTamanho.Utilizar = 0
3634:                     LOOP
3635:                 ENDIF
3636:                 loc_nLnQtUtil = cursor_4c_DispTamanho.Utilizar
3637: 
3638:                 = SEEK(cursor_4c_DispTamanho.CPros + cursor_4c_DispTamanho.CodCors + cursor_4c_DispTamanho.CodTams, ;
3639:                     "cursor_4c_TmpSaldo", "CPros")
3640: 
3641:                 SELECT TmpFinal
3642:                 SCATTER MEMVAR
3643:                 SELECT Temporario
3644:                 APPEND BLANK
3645:                 GATHER MEMVAR
3646:                 REPLACE Temporario.Saldo WITH loc_nLnQtUtil, ;
3647:                         Temporario.codTams WITH cursor_4c_DispTamanho.CodTams, ;
3648:                         Temporario.Estoque WITH loc_nLnQtUtil, ;
3649:                         Temporario.Produzir WITH 0
3650: 
3651:                 SELECT TmpFinal
3652:                 REPLACE TmpFinal.Saldo WITH TmpFinal.Saldo - loc_nLnQtUtil, ;
3653:                         TmpFinal.Produzir WITH TmpFinal.Produzir - loc_nLnQtUtil
3654: 
3655:                 REPLACE Saldo WITH Saldo - loc_nLnQtUtil, Produzir WITH Produzir - loc_nLnQtUtil IN TmpFinalg
3656: 
3657:                 SELECT TmpFinalg
3658:                 REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
3659:                     QtdMins - Produzir, 0) IN TmpFinalg
3660: 
3661:                 SELECT cursor_4c_TmpSaldo
3662:                 REPLACE cursor_4c_TmpSaldo.Disps WITH cursor_4c_TmpSaldo.Disps - loc_nLnQtUtil
3663: 
3664:                 SELECT cursor_4c_TmpSaldg
3665:                 SET ORDER TO CPros
3666:                 = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
3667:                 REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldo.Saldo ;
3668:                     WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
3669:                           cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
3670:                           cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams
3671: 
3672:                 *-- Divide a linha SEM tamanho de SigMvIts (tabela real) em
3673:                 *-- duas: a original com a quantidade restante e uma nova
3674:                 *-- com o tamanho escolhido e loc_nLnQtUtil (dump 7896-7916)
3675:                 loc_cEdn = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)
3676:                 loc_cQuery = "SELECT * FROM SigMvIts WHERE EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
3677:                     " AND Citens = " + FormatarNumeroSQL(TmpFinal.Citens, 0) + ;
3678:                     " AND CodCors = " + EscaparSQL(ALLTRIM(TmpFinal.CodCors)) + ;
3679:                     " AND CodTams = " + EscaparSQL(SPACE(4))
3680:                 IF USED("cursor_4c_MvItsOrig")
3681:                     USE IN cursor_4c_MvItsOrig
3682:                 ENDIF
3683:                 IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_MvItsOrig") >= 0 AND ;
3684:                         USED("cursor_4c_MvItsOrig") AND !EOF("cursor_4c_MvItsOrig")
3685: 
3686:                     IF (cursor_4c_MvItsOrig.Qtds - loc_nLnQtUtil) = 0
3687:                         SQLEXEC(gnConnHandle, "DELETE FROM SigMvIts WHERE cIdChaves = " + ;
3688:                             EscaparSQL(cursor_4c_MvItsOrig.cIdChaves))
3689:                     ELSE
3690:                         SQLEXEC(gnConnHandle, "UPDATE SigMvIts SET Qtds = " + ;
3691:                             FormatarNumeroSQL(cursor_4c_MvItsOrig.Qtds - loc_nLnQtUtil, 3) + ;
3692:                             ", Aqtds = " + FormatarNumeroSQL(cursor_4c_MvItsOrig.Qtds - loc_nLnQtUtil, 3) + ;
3693:                             " WHERE cIdChaves = " + EscaparSQL(cursor_4c_MvItsOrig.cIdChaves))
3694:                     ENDIF
3695: 
3696:                     SQLEXEC(gnConnHandle, ;
3697:                         "INSERT INTO SigMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, Aqtds, CodCors, CodTams, QtdEmbs, cIdChaves) " + ;
3698:                         "VALUES (" + FormatarNumeroSQL(cursor_4c_MvItsOrig.Citens, 0) + ", " + ;
3699:                         EscaparSQL(cursor_4c_MvItsOrig.Emps) + ", " + EscaparSQL(cursor_4c_MvItsOrig.Dopes) + ", " + ;
3700:                         FormatarNumeroSQL(cursor_4c_MvItsOrig.Numes, 0) + ", " + ;
3701:                         EscaparSQL(cursor_4c_MvItsOrig.Cpros) + ", " + FormatarNumeroSQL(loc_nLnQtUtil, 3) + ", " + ;
3702:                         FormatarNumeroSQL(loc_nLnQtUtil, 3) + ", " + EscaparSQL(cursor_4c_MvItsOrig.CodCors) + ", " + ;
3703:                         EscaparSQL(cursor_4c_DispTamanho.CodTams) + ", 1, " + EscaparSQL(fUniqueIds()) + ")")
3704:                 ENDIF
3705:                 IF USED("cursor_4c_MvItsOrig")
3706:                     USE IN cursor_4c_MvItsOrig
3707:                 ENDIF
3708: 
3709:                 SELECT cursor_4c_DispTamanho
3710:             ENDSCAN
3711: 
3712:             IF USED("Temporario") AND RECCOUNT("Temporario") > 0
3713:                 SELECT TmpFinal
3714:                 APPEND FROM DBF("Temporario")
3715:             ENDIF
3716:             IF loc_nRegFinal > 0 AND loc_nRegFinal <= RECCOUNT("TmpFinal")
3717:                 GOTO loc_nRegFinal IN TmpFinal
3718:             ENDIF
3719:             IF TmpFinal.Saldo = 0
3720:                 SELECT TmpFinal
3721:                 DELETE
3722:             ENDIF
3723: 
3724:             SELECT TmpFinalg
3725:             IF TmpFinalg.Saldo = 0
3726:                 DELETE
3727:             ENDIF
3728: 
3729:             = SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, "cursor_4c_TmpSaldo", "CPros")
3730:         ENDIF
3731: 
3732:         THIS.AtualizarTotaisPage1()
3733: 
3734:         THIS.pgf_4c_1.Page1.Enabled = .T.
3735:         THIS.pgf_4c_1.Page2.Enabled = .T.
3736:         THIS.pgf_4c_1.Page3.Enabled = .F.
3737:         THIS.pgf_4c_1.Page4.Enabled = .F.
3738:         THIS.pgf_4c_1.Page5.Enabled = .F.
3739:         THIS.AlternarPagina(1)
3740:         THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
3741:     ENDPROC

*-- Linhas 3766 a 3788:
3766:         loc_oGrid.RecordSource = ""
3767:         loc_oGrid.ColumnCount  = 5
3768:         loc_oGrid.RecordSource = "cursor_4c_Requisicao"
3769:         loc_oGrid.Column1.ControlSource = "cursor_4c_Requisicao.Cpros"
3770:         loc_oGrid.Column2.ControlSource = "cursor_4c_Requisicao.Dpros"
3771:         loc_oGrid.Column3.ControlSource = "cursor_4c_Requisicao.Cunis"
3772:         loc_oGrid.Column4.ControlSource = "cursor_4c_Requisicao.Qtds"
3773:         loc_oGrid.Column5.ControlSource = "cursor_4c_Requisicao.Cpro2s"
3774: 
3775:         THIS.pgf_4c_1.Page1.Enabled = .F.
3776:         THIS.pgf_4c_1.Page2.Enabled = .F.
3777:         THIS.pgf_4c_1.Page3.Enabled = .F.
3778:         THIS.pgf_4c_1.Page4.Enabled = .F.
3779:         THIS.pgf_4c_1.Page5.Enabled = .F.
3780:         THIS.pgf_4c_1.Page6.Enabled = .T.
3781:         THIS.AlternarPagina(6)
3782:         loc_oGrid.SetFocus()
3783:     ENDPROC
3784: 
3785:     *--------------------------------------------------------------------------
3786:     * BtnAlteraqtdClick - transcricao de Page1.Alteraqtd.Click (dump
3787:     * 7180-7204): autoriza UMA edicao da coluna "Produzir Estq" via dialogo
3788:     * de senha de risco (SigOpSen, "PRDZRISCO"). SigOpSen NAO foi migrado

*-- Linhas 3896 a 3928:
3896:     * CarregarLista - (re)liga a grade principal da Page1 ao cursor
3897:     * TmpFinalg e deixa a tela no estado em que o Init legado a entregava:
3898:     *
3899:     *   With ThisForm.PageDados.page1.GradeItens -> RecordSource/ControlSource
3900:     *   Select TmpSaldG / Set Order To Cpros / Set Key To TmpFinalg.Cpros+
3901:     *       CodCors+CodTams / Go Top          (filtro relacional por item)
3902:     *   Select TmpFabr  / idem
3903:     *   Select TmpFinalg / Sum ... / Tot_* .Value / .Refresh
3904:     *   ThisForm.pageDados.Page1.GradeItens.Setfocus
3905:     *
3906:     * Por que REBIND e nao so Refresh: TmpFinalg/TmpFinal/TmpSaldG/TmpFabr
3907:     * sao criados por FormSigPrGl2BO.ExecutarProcessamento na data session
3908:     * do form PAI (assumida no Init). Quando o pai reprocessa, o alias eh
3909:     * fisicamente RECRIADO e o Grid perde RecordSource/ControlSource,
3910:     * Header1.Caption, Width e ReadOnly (regra #43.1 do CLAUDE.md) - a
3911:     * grade viraria "Column1/Column2" generica e editavel. Por isso a
3912:     * reconfiguracao completa, na ordem ColumnCount -> RecordSource ->
3913:     * ControlSource -> Width -> Header1.Caption -> ReadOnly (regra #41).
3914:     *
3915:     * Fecha com GO TOP + Refresh (regra #21a: popular/religar cursor NAO
3916:     * repinta a grade sozinho).
3917:     *
3918:     * PUBLIC (nao PROTECTED): CarregarLista nao existe em FormBase e o
3919:     * harness de teste automatizado chama THIS.oForm.CarregarLista() direto
3920:     * de fora da classe (regra #3 do CLAUDE.md).
3921:     *--------------------------------------------------------------------------
3922:     PROCEDURE CarregarLista()
3923:         LOCAL loc_lSucesso, loc_oGrid, loc_oErro
3924:         loc_lSucesso = .F.
3925: 
3926:         TRY
3927:             IF !USED("TmpFinalg")
3928:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados de globaliza" + CHR(231) + CHR(227) + ;

*-- Linhas 3936 a 3965:
3936:                     .ColumnCount  = 10
3937:                     .RecordSource = "TmpFinalg"
3938: 
3939:                     .Column1.ControlSource  = "TmpFinalg.Cpros"
3940:                     .Column2.ControlSource  = "TmpFinalg.CodCors"
3941:                     .Column3.ControlSource  = "TmpFinalg.Flag"
3942:                     .Column4.ControlSource  = "TmpFinalg.Qtds"
3943:                     .Column5.ControlSource  = "TmpFinalg.Saldo"
3944:                     .Column6.ControlSource  = "TmpFinalg.Produzir"
3945:                     .Column7.ControlSource  = "TmpFinalg.Fabrs"
3946:                     .Column8.ControlSource  = "TmpFinalg.Produzir2"
3947:                     .Column9.ControlSource  = "TmpFinalg.CodTams"
3948:                     .Column10.ControlSource = "TmpFinalg.Estoque"
3949: 
3950:                     *-- Width DEPOIS do RecordSource/ControlSource: reatribuir
3951:                     *-- a fonte do Grid recalcula toda largura para o default.
3952:                     .Column1.Width  = 90
3953:                     .Column2.Width  = 50
3954:                     .Column3.Width  = 30
3955:                     .Column4.Width  = 60
3956:                     .Column5.Width  = 70
3957:                     .Column6.Width  = 70
3958:                     .Column7.Width  = 80
3959:                     .Column8.Width  = 80
3960:                     .Column9.Width  = 40
3961:                     .Column10.Width = 76
3962: 
3963:                     .Column1.Header1.Caption  = "Produto"
3964:                     .Column2.Header1.Caption  = "Cor"
3965:                     .Column3.Header1.Caption  = ""

*-- Linhas 3991 a 4037:
3991:                         "IIF(!EMPTY(TmpFinalg.UsuLibs), RGB(255,0,0), RGB(0,0,0))"
3992:                 ENDWITH
3993: 
3994:                 SELECT TmpFinalg
3995:                 GO TOP
3996: 
3997:                 *-- Ordem das grades de resumo (Set Order To Cpros do Init
3998:                 *-- legado). O FILTRO por item corrente NAO vem aqui: eh
3999:                 *-- GradeItensPage1AfterRowColChange quem o aplica, e ele eh
4000:                 *-- chamado no fim deste metodo para a primeira linha - uma
4001:                 *-- fonte unica, em vez de duas copias para divergirem.
4002:                 IF USED("cursor_4c_TmpSaldg")
4003:                     SELECT cursor_4c_TmpSaldg
4004:                     SET ORDER TO CPros
4005:                 ENDIF
4006:                 IF USED("cursor_4c_TmpFabr")
4007:                     SELECT cursor_4c_TmpFabr
4008:                     SET ORDER TO Cpros
4009:                 ENDIF
4010: 
4011:                 SELECT TmpFinalg
4012:                 GO TOP
4013:                 loc_oGrid.Refresh()
4014: 
4015:                 *-- Totais gerais e paineis/imagem do primeiro item
4016:                 THIS.AtualizarTotaisPage1()
4017:                 THIS.AtualizarVisibilidadeDisponivel()
4018:                 IF !EOF("TmpFinalg")
4019:                     THIS.GradeItensPage1AfterRowColChange(1)
4020:                 ENDIF
4021: 
4022:                 SELECT TmpFinalg
4023:                 loc_lSucesso = .T.
4024:             ENDIF
4025:         CATCH TO loc_oErro
4026:             MsgErro(loc_oErro.Message + CHR(13) + ;
4027:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4028:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
4029:             loc_lSucesso = .F.
4030:         ENDTRY
4031: 
4032:         RETURN loc_lSucesso
4033:     ENDPROC
4034: 
4035:     *--------------------------------------------------------------------------
4036:     * FormParaBO - repassa a Processar() os dois campos que o Init legado
4037:     * lia do form AVO (_Prev/_DtGera = ThisForm.ParentForm.ParentForm.

