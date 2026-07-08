# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VERESTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, FABRS, CODCORS, DISPS, NUMERODAOP, NUMPS, KEYPDES, PRODUZIR, FABRPROPRS, _LNVEZES, EMPDOPNUMS, CIDCHAVES, CITEM2, CONTADS, EMPS, NUMES, CODTAMS, XBAIXA, NOPS, QTDS, IF, X, CMATS, PRAZOENTS, ENTPES, AUTOS, MATS, NTRANS, TMPH, EMPDNPS, ESTOQUE, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, FABRS, CODCORS, DISPS, NUMERODAOP, NUMPS, KEYPDES, PRODUZIR, FABRPROPRS, _LNVEZES, EMPDOPNUMS, CIDCHAVES, CITEM2, CONTADS, EMPS, NUMES, CODTAMS, XBAIXA, NOPS, QTDS, IF, X, CMATS, PRAZOENTS, ENTPES, AUTOS, MATS, NTRANS, TMPH, EMPDNPS, ESTOQUE, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LINHA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, FABRS, CODCORS, DISPS, NUMERODAOP, NUMPS, KEYPDES, PRODUZIR, FABRPROPRS, _LNVEZES, EMPDOPNUMS, CIDCHAVES, CITEM2, CONTADS, EMPS, NUMES, CODTAMS, XBAIXA, NOPS, QTDS, IF, X, CMATS, PRAZOENTS, ENTPES, AUTOS, MATS, NTRANS, TMPH, EMPDNPS, ESTOQUE, CITENS, QTPRODS, DTALTS

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.prg) - TRECHOS RELEVANTES PARA PASS SQL (3562 linhas total):

*-- Linhas 524 a 600:
524:                     .Header1.Caption = "Produto"
525:                     .Width = 70
526:                     .ReadOnly = .T.
527:                     .ControlSource = "TmpFinalg.Cpros"
528:                 ENDWITH
529:                 WITH .Column2
530:                     .Header1.Caption = "Cor"
531:                     .Width = 35
532:                     .ReadOnly = .T.
533:                     .ControlSource = "TmpFinalg.CodCors"
534:                 ENDWITH
535:                 WITH .Column3
536:                     .Header1.Caption = ""
537:                     .Width = 18
538:                     .ReadOnly = .T.
539:                     .ControlSource = "TmpFinalg.Linhas"
540:                 ENDWITH
541:                 WITH .Column4
542:                     .Header1.Caption = "N"+CHR(250)+"mero"
543:                     .Width = 55
544:                     .ReadOnly = .T.
545:                     .ControlSource = "TmpFinalg.Nopes"
546:                 ENDWITH
547:                 WITH .Column5
548:                     .Header1.Caption = "Qtde Pedido"
549:                     .Width = 65
550:                     .ReadOnly = .T.
551:                     .ControlSource = "TmpFinalg.Saldo"
552:                     .Text1.Format = "@Z 9999999.999"
553:                 ENDWITH
554:                 WITH .Column6
555:                     .Header1.Caption = "Produzir"
556:                     .Width = 65
557:                     .ReadOnly = .T.
558:                     .ControlSource = "TmpFinalg.Fabrs"
559:                     .Text1.Format = "@Z 9999999.999"
560:                 ENDWITH
561:                 WITH .Column7
562:                     .Header1.Caption = "Qtd Produ"+CHR(231)+CHR(227)+"o"
563:                     .Width = 65
564:                     .ReadOnly = .F.
565:                     .ControlSource = "TmpFinalg.Produzir"
566:                     .Text1.Format = "@Z 9999999.999"
567:                 ENDWITH
568:                 WITH .Column8
569:                     .Header1.Caption = "Produzir Estq"
570:                     .Width = 65
571:                     .ReadOnly = .T.
572:                     .ControlSource = "TmpFinalg.Produzir2"
573:                     .Text1.Format = "@Z 9999999.999"
574:                 ENDWITH
575:                 WITH .Column9
576:                     .Header1.Caption = "Tam"
577:                     .Width = 30
578:                     .ReadOnly = .T.
579:                     .ControlSource = "TmpFinalg.CodTams"
580:                 ENDWITH
581:                 WITH .Column10
582:                     .Header1.Caption = "Qtd Estoque"
583:                     .Width = 65
584:                     .ReadOnly = .F.
585:                     .ControlSource = "TmpFinalg.Estoque"
586:                     .Text1.Format = "@Z 9999999.999"
587:                 ENDWITH
588: 
589:                 .RecordSource = "TmpFinalg"
590:             ENDWITH
591: 
592:             *-- Totais da grade principal (abaixo do grid)
593:             loc_oPag1.AddObject("lbl_4c_TotaisGrd", "Label")
594:             WITH loc_oPag1.lbl_4c_TotaisGrd
595:                 .AutoSize = .F.
596:                 .Caption = "Totais :"
597:                 .Top = 348
598:                 .Left = 224
599:                 .Width = 42
600:                 .Height = 17

*-- Linhas 703 a 744:
703: 
704:                     WITH .Column1
705:                         .Header1.Caption = "Grupo"
706:                         .ControlSource = "TmpSaldG.Grupos"
707:                         .RecordMark   = .F.
708:                         .DeleteMark   = .F.
709:                     ENDWITH
710:                     WITH .Column2
711:                         .Header1.Caption = "Conta"
712:                         .ControlSource = "TmpSaldG.Estos"
713:                     ENDWITH
714:                     WITH .Column3
715:                         .Header1.Caption = "Atual"
716:                         .ControlSource = "TmpSaldG.Saldo"
717:                         .Text1.Format = "@Z 9999999.999"
718:                     ENDWITH
719:                     WITH .Column4
720:                         .Header1.Caption = "Utilizado"
721:                     ENDWITH
722:                     WITH .Column5
723:                         .Header1.Caption = "Dispon"+CHR(237)+"vel"
724:                         .ControlSource = "TmpSaldG.Disps"
725:                         .Text1.Format = "@Z 9999999.999"
726:                     ENDWITH
727:                     WITH .Column6
728:                         .Header1.Caption = "Prior"
729:                         .ControlSource = "TmpSaldG.Priors"
730:                     ENDWITH
731: 
732:                     .RecordSource = "TmpSaldG"
733:                 ENDWITH
734: 
735:                 .AddObject("lbl_4c_TotDisp", "Label")
736:                 WITH .lbl_4c_TotDisp
737:                     .AutoSize = .F.
738:                     .Caption = "Totais :"
739:                     .Top = 163
740:                     .Left = 128
741:                     .Width = 42
742:                     .Height = 17
743:                     .BackStyle = 0
744:                     .FontName = "Tahoma"

*-- Linhas 822 a 856:
822: 
823:                     WITH .Column1
824:                         .Header1.Caption = "Fase"
825:                         .ControlSource = "TmpSaldG.Grupos"
826:                         .RecordMark   = .F.
827:                         .DeleteMark   = .F.
828:                     ENDWITH
829:                     WITH .Column2
830:                         .Header1.Caption = "Disponivel"
831:                         .ControlSource = "TmpSaldG.Disps"
832:                         .Text1.Format = "@Z 9999999.999"
833:                     ENDWITH
834:                     WITH .Column3
835:                         .Header1.Caption = "Utilizado"
836:                         .ControlSource = "TmpSaldG.Saldo"
837:                         .Text1.Format = "@Z 9999999.999"
838:                     ENDWITH
839:                     WITH .Column4
840:                         .Header1.Caption = "Prior"
841:                         .ControlSource = "TmpSaldG.Priors"
842:                     ENDWITH
843:                     WITH .Column5
844:                         .Header1.Caption = "Nop"
845:                     ENDWITH
846: 
847:                     .RecordSource = "TmpSaldU"
848:                 ENDWITH
849: 
850:                 .AddObject("lbl_4c_TotProd", "Label")
851:                 WITH .lbl_4c_TotProd
852:                     .AutoSize = .F.
853:                     .Caption = "Totais :"
854:                     .Top = 115
855:                     .Left = 102
856:                     .Width = 42

*-- Linhas 1067 a 1144:
1067:                     .Header1.Caption = "Produto"
1068:                     .Width = 70
1069:                     .ReadOnly = .T.
1070:                     .ControlSource = "TmpFinal.Cpros"
1071:                     .RecordMark   = .F.
1072:                     .DeleteMark   = .F.
1073:                 ENDWITH
1074:                 WITH .Column2
1075:                     .Header1.Caption = "Cor"
1076:                     .Width = 35
1077:                     .ReadOnly = .T.
1078:                     .ControlSource = "TmpFinal.CodCors"
1079:                 ENDWITH
1080:                 WITH .Column3
1081:                     .Header1.Caption = "Opera"+CHR(231)+CHR(227)+"o"
1082:                     .Width = 60
1083:                     .ReadOnly = .T.
1084:                     .ControlSource = "TmpFinal.Dopes"
1085:                 ENDWITH
1086:                 WITH .Column4
1087:                     .Header1.Caption = "N"+CHR(250)+"mero"
1088:                     .Width = 55
1089:                     .ReadOnly = .T.
1090:                     .ControlSource = "TmpFinal.Nops"
1091:                 ENDWITH
1092:                 WITH .Column5
1093:                     .Header1.Caption = "Quantidade"
1094:                     .Width = 65
1095:                     .ReadOnly = .T.
1096:                     .ControlSource = "TmpFinal.Saldo"
1097:                     .Text1.Format = "@Z 9999999.999"
1098:                 ENDWITH
1099:                 WITH .Column6
1100:                     .Header1.Caption = "Produzir"
1101:                     .Width = 65
1102:                     .ReadOnly = .T.
1103:                     .ControlSource = "TmpFinal.Produzir"
1104:                     .Text1.Format = "@Z 9999999.999"
1105:                 ENDWITH
1106:                 WITH .Column7
1107:                     .Header1.Caption = "Estoque"
1108:                     .Width = 65
1109:                     .ReadOnly = .F.
1110:                     .ControlSource = "TmpFinal.Estoque"
1111:                     .Text1.Format = "@Z 9999999.999"
1112:                 ENDWITH
1113:                 WITH .Column8
1114:                     .Header1.Caption = "Obs"
1115:                     .Width = 55
1116:                     .ReadOnly = .T.
1117:                     .ControlSource = "TmpFinal.UsuLibs"
1118:                 ENDWITH
1119:                 WITH .Column9
1120:                     .Header1.Caption = "Tam"
1121:                     .Width = 30
1122:                     .ReadOnly = .T.
1123:                     .ControlSource = "TmpFinal.CodTams"
1124:                 ENDWITH
1125:                 WITH .Column10
1126:                     .Header1.Caption = "Produ"+CHR(231)+CHR(227)+"o"
1127:                     .Width = 65
1128:                     .ReadOnly = .F.
1129:                     .ControlSource = "TmpFinal.Fabrs"
1130:                     .Text1.Format = "@Z 9999999.999"
1131:                 ENDWITH
1132: 
1133:                 .RecordSource = "TmpFinal"
1134:             ENDWITH
1135: 
1136:             loc_oPag2.AddObject("lbl_4c_TotP2Lbl", "Label")
1137:             WITH loc_oPag2.lbl_4c_TotP2Lbl
1138:                 .AutoSize = .F.
1139:                 .Caption = "Totais :"
1140:                 .Top = 372
1141:                 .Left = 403
1142:                 .Width = 42
1143:                 .Height = 17
1144:                 .BackStyle = 0

*-- Linhas 1293 a 1332:
1293: 
1294:                 WITH .Column1
1295:                     .Header1.Caption = "Linha"
1296:                     .ControlSource = "TmpLinha.Linhas"
1297:                     .RecordMark   = .F.
1298:                     .DeleteMark   = .F.
1299:                 ENDWITH
1300:                 WITH .Column2
1301:                     .Header1.Caption = "Quantidade"
1302:                     .ControlSource = "TmpLinha.Saldo"
1303:                     .Text1.Format = "@Z 9999999.999"
1304:                 ENDWITH
1305:                 WITH .Column3
1306:                     .Header1.Caption = "Estoque"
1307:                     .ControlSource = "TmpLinha.Estoque"
1308:                     .Text1.Format = "@Z 9999999.999"
1309:                 ENDWITH
1310:                 WITH .Column4
1311:                     .Header1.Caption = "Produ"+CHR(231)+CHR(227)+"o"
1312:                     .ControlSource = "TmpLinha.Fabrs"
1313:                     .Text1.Format = "@Z 9999999.999"
1314:                 ENDWITH
1315:                 WITH .Column5
1316:                     .Header1.Caption = "Produzir"
1317:                     .ControlSource = "TmpLinha.Produzir"
1318:                     .Text1.Format = "@Z 9999999.999"
1319:                 ENDWITH
1320:             ENDWITH
1321: 
1322:             loc_oPag3.AddObject("btn_4c_VoltarP3", "CommandButton")
1323:             WITH loc_oPag3.btn_4c_VoltarP3
1324:                 .Top = 12
1325:                 .Left = 704
1326:                 .Width = 75
1327:                 .Height = 75
1328:                 .Caption = "Voltar"
1329:                 .Themes = .F.
1330:                 .FontName = "Tahoma"
1331:                 .FontSize = 8
1332:             ENDWITH

*-- Linhas 1376 a 1417:
1376:                 WITH .Column1
1377:                     .Header1.Caption = "Grupo"
1378:                     .ReadOnly = .T.
1379:                     .ControlSource = "TmpDisp.Grupos"
1380:                     .RecordMark   = .F.
1381:                     .DeleteMark   = .F.
1382:                 ENDWITH
1383:                 WITH .Column2
1384:                     .Header1.Caption = "Conta"
1385:                     .ReadOnly = .T.
1386:                     .ControlSource = "TmpDisp.Estos"
1387:                 ENDWITH
1388:                 WITH .Column3
1389:                     .Header1.Caption = "Prior"
1390:                     .ReadOnly = .T.
1391:                     .ControlSource = "TmpDisp.Priors"
1392:                 ENDWITH
1393:                 WITH .Column4
1394:                     .Header1.Caption = "Disponivel"
1395:                     .ReadOnly = .T.
1396:                     .ControlSource = "TmpDisp.Disps"
1397:                     .Text1.Format = "@Z 9999999.999"
1398:                 ENDWITH
1399:                 WITH .Column5
1400:                     .Header1.Caption = "Utilizar"
1401:                     .ReadOnly = .F.
1402:                     .ControlSource = "TmpDisp.Utilizar"
1403:                     .Text1.Format = "@Z 9999999.999"
1404:                 ENDWITH
1405:             ENDWITH
1406: 
1407:             loc_oPag4.AddObject("lbl_4c_P4QtPed", "Label")
1408:             WITH loc_oPag4.lbl_4c_P4QtPed
1409:                 .AutoSize = .F.
1410:                 .Caption = "Qtde Pedida :"
1411:                 .Top = 418
1412:                 .Left = 220
1413:                 .Width = 82
1414:                 .Height = 16
1415:                 .BackStyle = 0
1416:                 .FontName = "Tahoma"
1417:                 .FontSize = 8

*-- Linhas 1514 a 1555:
1514:                 WITH .Column1
1515:                     .Header1.Caption = "Produto"
1516:                     .ReadOnly = .T.
1517:                     .ControlSource = "TmpDisp.Cpros"
1518:                     .RecordMark   = .F.
1519:                     .DeleteMark   = .F.
1520:                 ENDWITH
1521:                 WITH .Column2
1522:                     .Header1.Caption = "Cor"
1523:                     .ReadOnly = .T.
1524:                     .ControlSource = "TmpDisp.CodCors"
1525:                 ENDWITH
1526:                 WITH .Column3
1527:                     .Header1.Caption = "Tam"
1528:                     .ReadOnly = .T.
1529:                     .ControlSource = "TmpDisp.CodTams"
1530:                 ENDWITH
1531:                 WITH .Column4
1532:                     .Header1.Caption = "Disponivel"
1533:                     .ReadOnly = .T.
1534:                     .ControlSource = "TmpDisp.Disps"
1535:                     .Text1.Format = "@Z 9999999.999"
1536:                 ENDWITH
1537:                 WITH .Column5
1538:                     .Header1.Caption = "Utilizar"
1539:                     .ReadOnly = .F.
1540:                     .ControlSource = "TmpDisp.Utilizar"
1541:                     .Text1.Format = "@Z 9999999.999"
1542:                 ENDWITH
1543:             ENDWITH
1544: 
1545:             loc_oPag5.AddObject("lbl_4c_P5QtPed", "Label")
1546:             WITH loc_oPag5.lbl_4c_P5QtPed
1547:                 .AutoSize = .F.
1548:                 .Caption = "Qtde Pedida :"
1549:                 .Top = 415
1550:                 .Left = 289
1551:                 .Width = 82
1552:                 .Height = 16
1553:                 .BackStyle = 0
1554:                 .FontName = "Tahoma"
1555:                 .FontSize = 8

*-- Linhas 1655 a 1696:
1655:                 WITH .Column1
1656:                     .Header1.Caption = "Produto"
1657:                     .ReadOnly = .F.
1658:                     .ControlSource = "SelPedra.Cpros"
1659:                     .RecordMark   = .F.
1660:                     .DeleteMark   = .F.
1661:                 ENDWITH
1662:                 WITH .Column2
1663:                     .Header1.Caption = "Descri"+CHR(231)+CHR(227)+"o"
1664:                     .ReadOnly = .T.
1665:                     .ControlSource = "SelPedra.Dpros"
1666:                 ENDWITH
1667:                 WITH .Column3
1668:                     .Header1.Caption = "Uni"
1669:                     .ReadOnly = .T.
1670:                     .ControlSource = "SelPedra.Cunis"
1671:                 ENDWITH
1672:                 WITH .Column4
1673:                     .Header1.Caption = "Qtde"
1674:                     .ReadOnly = .F.
1675:                     .ControlSource = "SelPedra.Qtds"
1676:                     .Text1.Format = "@Z 9999999.999"
1677:                 ENDWITH
1678:                 WITH .Column5
1679:                     .Header1.Caption = "Produto"
1680:                     .ReadOnly = .F.
1681:                     .ControlSource = "SelPedra.Cpro2s"
1682:                 ENDWITH
1683:             ENDWITH
1684: 
1685:             loc_oPag6.AddObject("btn_4c_VoltarP6", "CommandButton")
1686:             WITH loc_oPag6.btn_4c_VoltarP6
1687:                 .Top = 12
1688:                 .Left = 704
1689:                 .Width = 75
1690:                 .Height = 75
1691:                 .Caption = "Voltar"
1692:                 .Themes = .F.
1693:                 .FontName = "Tahoma"
1694:                 .FontSize = 8
1695:             ENDWITH
1696:             BINDEVENT(loc_oPag6.btn_4c_VoltarP6, "Click", THIS, "BtnVoltarPage6Click")

*-- Linhas 2023 a 2041:
2023: 
2024:         *-- Filtrar TmpSaldG para linha atual
2025:         IF USED("TmpSaldG")
2026:             SELECT TmpSaldG
2027:             SET ORDER TO Cpros
2028:             SET KEY TO TmpFinalg.Cpros + TmpFinalg.CodCors + TmpFinalg.CodTams
2029:             GO TOP
2030:         ENDIF
2031: 
2032:         *-- Atualizar Container3 (Estoque Disponivel)
2033:         WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_GradeDisp
2034:             IF USED("TmpSaldo") AND NOT EOF("TmpSaldo")
2035:                 .txt_4c_DispQtd.Value = TmpSaldo.Saldo
2036:                 .txt_4c_DispEst.Value = TmpSaldo.Saldo - TmpSaldo.Disps
2037:                 .txt_4c_DispPrz.Value = TmpSaldo.Disps
2038:             ELSE
2039:                 .txt_4c_DispQtd.Value = 0
2040:                 .txt_4c_DispEst.Value = 0
2041:                 .txt_4c_DispPrz.Value = 0

*-- Linhas 2059 a 2079:
2059:         THIS.pgf_4c_Paginas.Page1.cnt_4c_GradeProd.grd_4c_GradeProd.Refresh
2060: 
2061:         *-- Carregar imagem do produto
2062:         loc_lcSql = [SELECT cpros, figjpgs FROM SigCdPro WHERE Cpros = ] + ;
2063:                     EscaparSQL(TmpFinalg.Cpros)
2064:         IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_ProdFig") >= 1
2065:             WITH THIS.pgf_4c_Paginas.Page1.img_4c_FigJpg
2066:                 IF NOT EMPTY(cursor_4c_ProdFig.FigJpgs) AND NOT ISNULL(cursor_4c_ProdFig.FigJpgs)
2067:                     loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
2068:                     loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ProdFig.FigJpgs, ;
2069:                         "data:image/png;base64,", ""), ;
2070:                         "data:image/jpeg;base64,", ""), ;
2071:                         "data:image/jpg;base64,", ""), 14)
2072:                     =STRTOFILE(loc_lcFoto, loc_lcArquivo)
2073:                     .Picture = loc_lcArquivo
2074:                     .Visible = .T.
2075:                 ELSE
2076:                     .Picture = ""
2077:                     .Visible = .F.
2078:                 ENDIF
2079:             ENDWITH

*-- Linhas 2090 a 2108:
2090: 
2091:         *-- Filtrar TmpFinal para o produto/cor/tam corrente (SET KEY dinamico)
2092:         IF USED("TmpFinal") AND USED("TmpFinalg") AND NOT EOF("TmpFinalg")
2093:             SELECT TmpFinal
2094:             SET ORDER TO Cpros
2095:             SET KEY TO TmpFinalg.Cpros + TmpFinalg.CodCors + TmpFinalg.CodTams
2096:             GO TOP
2097:         ENDIF
2098: 
2099:         *-- Inicializar totais da secao "Qtd Selecionada" em Page2
2100:         IF USED("TmpFinalg") AND NOT EOF("TmpFinalg")
2101:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2102:             loc_oPag2.txt_4c_TotSEst.Value = TmpFinalg.Estoque
2103:             loc_oPag2.txt_4c_TotSPrc.Value = TmpFinalg.Fabrs
2104:             THIS.AtualizarTotaisPage2()
2105:         ENDIF
2106: 
2107:         THIS.pgf_4c_Paginas.Page2.Enabled = .T.
2108:         THIS.pgf_4c_Paginas.ActivePage = 2

*-- Linhas 2128 a 2146:
2128: 
2129:         *-- Garantir registro em TmpSaldU para este produto
2130:         IF USED("TmpSaldU") AND NOT SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
2131:             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2132:         ENDIF
2133: 
2134:         *-- Checar se produto usa selecao manual de OP
2135:         IF USED("TmpSaldU") AND loc_nNewVal <> THIS.this_nOldValue AND TmpSaldU.KeySelmp
2136:             IF NOT MsgConfirma("Produto com Sele"+CHR(231)+CHR(227)+"o Manual de OP. "+CHR(13)+ ;
2137:                     "O sistema ir"+CHR(225)+" acionar o modo autom"+CHR(225)+"tico. Deseja Continuar?")
2138:                 THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column7.Text1.Value = THIS.this_nOldValue
2139:                 RETURN .F.
2140:             ENDIF
2141:         ENDIF
2142: 
2143:         loc_nMaxProd = IIF(USED("TmpFinalg") AND NOT EOF("TmpFinalg"), ;
2144:                            TmpFinalg.Saldo - TmpFinalg.Estoque, 0)
2145:         loc_nQtdMin  = IIF(USED("TmpFinalg") AND NOT EOF("TmpFinalg"), TmpFinalg.QtdMins, 0)
2146: 

*-- Linhas 2170 a 2188:
2170:                 IF USED("TmpSaldo") AND NOT EOF("TmpSaldo") AND USED("TmpSaldG")
2171:                     LOCAL loc_nDisps
2172:                     loc_nDisps = TmpSaldo.Disps
2173:                     SELECT TmpSaldG
2174:                     SCAN
2175:                         REPLACE Disps WITH loc_nDisps IN TmpSaldG
2176:                     ENDSCAN
2177:                 ENDIF
2178:         ENDCASE
2179: 
2180:         RETURN loc_lResultado
2181:     ENDPROC
2182: 
2183:     *--------------------------------------------------------------------------
2184:     * GradeItensCol7LostFocus - Atualiza totais apos edicao de Producao
2185:     *--------------------------------------------------------------------------
2186:     PROCEDURE GradeItensCol7LostFocus
2187:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2188:         THIS.AtualizarTotaisGrade()

*-- Linhas 2207 a 2247:
2207: 
2208:         *-- Mostrar botao Disponivel apenas para reserva de produtos tipo 3 ou 4
2209:         IF THIS.this_lReserva AND USED("TmpFinalg") AND NOT EOF("TmpFinalg") AND TmpFinalg.Estoque = 0
2210:             loc_lcSql = [SELECT g.TipoEstos FROM SigCdPro p ] + ;
2211:                         [INNER JOIN SigCdGrp g ON g.CGrus = p.CGrus ] + ;
2212:                         [WHERE p.CPros = ] + EscaparSQL(TmpFinalg.Cpros)
2213:             IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_TipoEsto") >= 1
2214:                 IF INLIST(cursor_4c_TipoEsto.TipoEstos, 3, 4)
2215:                     THIS.pgf_4c_Paginas.Page1.btn_4c_Disponivel.Visible = .T.
2216:                 ENDIF
2217:                 USE IN cursor_4c_TipoEsto
2218:             ENDIF
2219:         ENDIF
2220:     ENDPROC
2221: 
2222:     *--------------------------------------------------------------------------
2223:     * GradeItensCol10Valid - Valida e aplica nova quantidade de Estoque
2224:     *--------------------------------------------------------------------------
2225:     PROCEDURE GradeItensCol10Valid
2226:         LOCAL loc_lResultado, loc_nNewVal, loc_nMaxEst, loc_nDelta, loc_nNovoProd, loc_nQtdMin
2227:         loc_lResultado = .T.
2228:         loc_nNewVal    = THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value
2229: 
2230:         *-- Garantir registro em TmpSaldU para este produto
2231:         IF USED("TmpSaldU") AND NOT SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
2232:             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2233:         ENDIF
2234: 
2235:         *-- Checar se produto usa selecao manual de estoque
2236:         IF USED("TmpSaldU") AND loc_nNewVal <> THIS.this_nOldValue AND TmpSaldU.KeySelm
2237:             IF NOT MsgConfirma("Produto com Sele"+CHR(231)+CHR(227)+"o Manual de estoque. "+CHR(13)+ ;
2238:                     "O sistema ir"+CHR(225)+" acionar o modo autom"+CHR(225)+"tico. Deseja Continuar?")
2239:                 THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value = THIS.this_nOldValue
2240:                 RETURN .F.
2241:             ENDIF
2242:         ENDIF
2243: 
2244:         loc_nMaxEst = IIF(USED("TmpSaldo") AND NOT EOF("TmpSaldo"), TmpSaldo.Disps, 0)
2245:         loc_nQtdMin = IIF(USED("TmpFinalg") AND NOT EOF("TmpFinalg"), TmpFinalg.QtdMins, 0)
2246: 
2247:         DO CASE

*-- Linhas 2295 a 2313:
2295:             RETURN
2296:         ENDIF
2297: 
2298:         SELECT TmpFinalg
2299:         loc_nRecno = RECNO()
2300:         SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 ;
2301:             TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
2302:         GO loc_nRecno
2303: 
2304:         WITH THIS.pgf_4c_Paginas.Page1
2305:             .txt_4c_TotQtd.Value  = loc_nSal
2306:             .txt_4c_TotEst.Value  = loc_nEst
2307:             .txt_4c_TotPrdc.Value = loc_nPrc
2308:             .txt_4c_TotPrz.Value  = loc_nPrz
2309:             .txt_4c_TotPrze.Value = loc_nPrze
2310:             .txt_4c_TotQtd.Refresh
2311:             .txt_4c_TotEst.Refresh
2312:             .txt_4c_TotPrdc.Refresh
2313:             .txt_4c_TotPrz.Refresh

*-- Linhas 2325 a 2346:
2325:             RETURN
2326:         ENDIF
2327: 
2328:         loc_lcSql = [SELECT a.cpros, a.dpros, a.figjpgs FROM SigCdPro a WHERE a.cpros = ] + ;
2329:                     EscaparSQL(TmpFinalg.Cpros)
2330: 
2331:         IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_LocalPro") >= 1
2332:             WITH THIS.pgf_4c_Paginas.Page1.img_4c_FigJpg
2333:                 IF NOT EMPTY(cursor_4c_LocalPro.FigJpgs) AND NOT ISNULL(cursor_4c_LocalPro.FigJpgs)
2334:                     loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
2335:                     loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_LocalPro.FigJpgs, ;
2336:                         "data:image/png;base64,", ""), ;
2337:                         "data:image/jpeg;base64,", ""), ;
2338:                         "data:image/jpg;base64,", ""), 14)
2339:                     =STRTOFILE(loc_lcFoto, loc_lcArquivo)
2340:                     .Picture = loc_lcArquivo
2341:                     .Visible = .T.
2342:                 ELSE
2343:                     MsgAviso("Nenhuma imagem cadastrada para este produto.")
2344:                 ENDIF
2345:             ENDWITH
2346:             USE IN cursor_4c_LocalPro

*-- Linhas 2384 a 2408:
2384:             USE IN TmpLinha
2385:         ENDIF
2386: 
2387:         SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, ;
2388:                SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs ;
2389:         FROM TmpFinalg GROUP BY 1 ;
2390:         UNION ALL ;
2391:         SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, ;
2392:                SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs ;
2393:         FROM TmpFinalg GROUP BY 1 ;
2394:         INTO CURSOR TmpLinha ORDER BY 2, 1
2395: 
2396:         WITH THIS.pgf_4c_Paginas.Page3.grd_4c_GradeLinhas
2397:             .RecordSource = "TmpLinha"
2398:             .Refresh
2399:         ENDWITH
2400: 
2401:         THIS.AlternarPagina(3)
2402:     ENDPROC
2403: 
2404:     *--------------------------------------------------------------------------
2405:     * BtnCancelarClick - Encerra o form e reativa o form pai
2406:     *--------------------------------------------------------------------------
2407:     PROCEDURE BtnCancelarClick
2408:         IF VARTYPE(THIS.this_oParentForm) = "O"

*-- Linhas 2431 a 2454:
2431:             USE IN TmpDisp
2432:         ENDIF
2433: 
2434:         SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
2435:         FROM TmpSaldo ;
2436:         WHERE Cpros = loc_lcCpro AND CodCors = loc_lcCor AND Disps > 0 ;
2437:         INTO CURSOR Resultado ORDER BY 1, 2, 3
2438: 
2439:         SELECT 0
2440:         USE DBF("Resultado") ALIAS TmpDisp AGAIN
2441:         USE IN Resultado
2442: 
2443:         IF RECCOUNT("TmpDisp") = 0
2444:             MsgAviso("Nenhum tamanho dispon"+CHR(237)+"vel para esta refer"+CHR(234)+"ncia.")
2445:             IF USED("TmpDisp")
2446:                 USE IN TmpDisp
2447:             ENDIF
2448:             RETURN
2449:         ENDIF
2450: 
2451:         WITH THIS.pgf_4c_Paginas.Page5
2452:             .txt_4c_P5CodProd.Value  = ALLTRIM(loc_lcCpro) + ;
2453:                 IIF(NOT EMPTY(loc_lcCor), "/"+ALLTRIM(loc_lcCor), "")
2454:             .txt_4c_P5QtPedida.Value = TmpFinalg.Saldo

*-- Linhas 2475 a 2498:
2475:             USE IN TmpDisp
2476:         ENDIF
2477: 
2478:         SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
2479:         FROM TmpSaldG ;
2480:         WHERE Cpros = loc_lcCpro AND CodCors = loc_lcCor AND CodTams = loc_lcTam AND Disps > 0 ;
2481:         INTO CURSOR Resultado ORDER BY 1, 2, 3, 4
2482: 
2483:         SELECT 0
2484:         USE DBF("Resultado") ALIAS TmpDisp AGAIN
2485:         USE IN Resultado
2486: 
2487:         IF RECCOUNT("TmpDisp") = 0
2488:             MsgAviso("Nenhum estoque dispon"+CHR(237)+"vel para esta refer"+CHR(234)+"ncia.")
2489:             IF USED("TmpDisp")
2490:                 USE IN TmpDisp
2491:             ENDIF
2492:             RETURN
2493:         ENDIF
2494: 
2495:         WITH THIS.pgf_4c_Paginas.Page4
2496:             .txt_4c_P4CodProd.Value  = ALLTRIM(loc_lcCpro) + ;
2497:                 IIF(NOT EMPTY(loc_lcCor), "/"+ALLTRIM(loc_lcCor), "") + ;
2498:                 IIF(NOT EMPTY(loc_lcTam), "/"+ALLTRIM(loc_lcTam), "")

*-- Linhas 2515 a 2537:
2515:             ENDIF
2516:             .RecordSource          = "SelPedra"
2517:             .ColumnCount           = 5
2518:             .Column1.ControlSource = "SelPedra.Cpros"
2519:             .Column2.ControlSource = "SelPedra.Dpros"
2520:             .Column3.ControlSource = "SelPedra.Cunis"
2521:             .Column4.ControlSource = "SelPedra.Qtds"
2522:             .Column5.ControlSource = "SelPedra.Cpro2s"
2523:             .Refresh
2524:         ENDWITH
2525: 
2526:         THIS.pgf_4c_Paginas.Page6.txt_4c_P6CodProd.Value = ALLTRIM(TmpFinalg.Cpros)
2527:         THIS.AlternarPagina(6)
2528:     ENDPROC
2529: 
2530:     *--------------------------------------------------------------------------
2531:     * BtnAlteraqtdClick - Autoriza alteracao de Produzir2 via SigOpSen
2532:     *--------------------------------------------------------------------------
2533:     PROCEDURE BtnAlteraqtdClick
2534:         LOCAL loc_lcString, loc_lcRetorno
2535: 
2536:         IF TmpFinalg.Produzir2 = 0
2537:             MsgAviso("Referencia Sem Quantidade a Produzir para Estoque!!!")

*-- Linhas 2563 a 2581:
2563:         LOCAL loc_nSumEst, loc_nSumPrc
2564: 
2565:         IF USED("TmpFinal") AND USED("TmpFinalg") AND NOT EOF("TmpFinalg")
2566:             SELECT TmpFinal
2567:             SUM TmpFinal.Estoque, TmpFinal.Fabrs TO loc_nSumEst, loc_nSumPrc
2568: 
2569:             IF loc_nSumEst <> TmpFinalg.Estoque
2570:                 MsgAviso("A quantidade de Estoque n"+CHR(227)+"o confere com a Quantidade Selecionada!!!")
2571:                 RETURN
2572:             ENDIF
2573:             IF loc_nSumPrc <> TmpFinalg.Fabrs
2574:                 MsgAviso("A quantidade de Produ"+CHR(231)+CHR(227)+"o n"+CHR(227)+"o confere com a Quantidade Selecionada!!!")
2575:                 RETURN
2576:             ENDIF
2577:         ENDIF
2578: 
2579:         THIS.AlternarPagina(1)
2580:     ENDPROC
2581: 

*-- Linhas 2599 a 2660:
2599:         TRY
2600:             IF USED("TmpDisp")
2601: 
2602:                 SELECT TmpDisp
2603:                 SUM Utilizar TO loc_nQtdUti
2604: 
2605:                 IF loc_nQtdUti > 0
2606: 
2607:                     SELECT TmpDisp
2608:                     SCAN
2609:                         IF TmpDisp.Utilizar = 0
2610:                             LOOP
2611:                         ENDIF
2612:                         loc_nQtUtil = TmpDisp.Utilizar
2613: 
2614:                         =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, 'TmpSaldo')
2615: 
2616:                         SELECT TmpFinalg
2617:                         REPLACE Produzir  WITH Produzir - loc_nQtUtil, ;
2618:                                 Estoque   WITH Estoque + loc_nQtUtil, ;
2619:                                 UsuLibs   WITH ' ' IN TmpFinalg
2620:                         REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
2621:                                                   QtdMins - Produzir, 0) IN TmpFinalg
2622: 
2623:                         SELECT TmpSaldo
2624:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nQtUtil IN TmpSaldo
2625: 
2626:                         *-- Registrar selecao manual de estoque em TmpSaldU
2627:                         IF NOT SEEK(TmpFinalg.Cpros, 'TmpSaldU', 'Cpros')
2628:                             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2629:                         ENDIF
2630:                         REPLACE keySelm WITH .T. IN TmpSaldU
2631: 
2632:                         *-- Atualizar disponivel no grupo/conta especifico em TmpSaldG
2633:                         SELECT TmpSaldG
2634:                         SET ORDER TO Cpros
2635:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + ;
2636:                               STR(TmpDisp.Priors, 2) + TmpDisp.Grupos + TmpDisp.Estos)
2637:                         REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nQtUtil
2638: 
2639:                     ENDSCAN
2640: 
2641:                     *-- Redistribuir Estoque acumulado pelas operacoes em TmpFinal
2642:                     =SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, 'TmpSaldo')
2643:                     loc_nXBaixa = TmpFinalg.Estoque
2644: 
2645:                     SELECT TmpFinal
2646:                     SET ORDER TO
2647:                     SET ORDER TO Cpros
2648:                     =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
2649:                     REPLACE Estoque WITH 0 ;
2650:                         WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND ;
2651:                               CodTams = TmpSaldo.CodTams
2652:                     =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
2653:                     SCAN WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND ;
2654:                                CodTams = TmpSaldo.CodTams AND loc_nXBaixa > 0
2655:                         IF TmpFinal.Saldo - TmpFinal.Fabrs >= loc_nXBaixa
2656:                             REPLACE TmpFinal.Estoque WITH TmpFinal.Estoque + loc_nXBaixa IN TmpFinal
2657:                             loc_nXBaixa = 0
2658:                         ELSE
2659:                             loc_nXBaixa = loc_nXBaixa - ( TmpFinal.Saldo - TmpFinal.Fabrs )
2660:                             REPLACE TmpFinal.Estoque WITH ( TmpFinal.Saldo - TmpFinal.Fabrs ) IN TmpFinal

*-- Linhas 2692 a 2819:
2692:         TRY
2693:             IF USED("TmpDisp") AND USED("TmpFinal")
2694: 
2695:                 SELECT TmpFinal
2696:                 SET ORDER TO
2697:                 loc_nRegFinal = RECNO()
2698: 
2699:                 SELECT TmpDisp
2700:                 SUM Utilizar TO loc_nQtdUti
2701: 
2702:             IF loc_nQtdUti > 0
2703: 
2704:                 *-- Criar cursor Temporario com mesma estrutura de TmpFinal para staging
2705:                 SELECT TmpFinal
2706:                 =AFIELDS(loc_aFinal)
2707:                 CREATE CURSOR Temporario FROM ARRAY loc_aFinal
2708: 
2709:                 SELECT TmpDisp
2710:                 SCAN
2711:                     IF TmpDisp.Utilizar = 0
2712:                         LOOP
2713:                     ENDIF
2714:                     loc_nQtUtil = TmpDisp.Utilizar
2715: 
2716:                     =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, 'TmpSaldo')
2717: 
2718:                     *-- Copiar linha TmpFinal para Temporario, ajustando tamanho e quantidade
2719:                     SELECT TmpFinal
2720:                     SCATTER TO loc_aMemvar
2721:                     SELECT Temporario
2722:                     APPEND FROM ARRAY loc_aMemvar
2723:                     REPLACE Temporario.Saldo    WITH loc_nQtUtil, ;
2724:                             Temporario.CodTams  WITH TmpDisp.CodTams, ;
2725:                             Temporario.Estoque  WITH loc_nQtUtil, ;
2726:                             Temporario.Produzir WITH 0
2727: 
2728:                     *-- Reduzir TmpFinal e TmpFinalg pelo que foi alocado neste tamanho
2729:                     SELECT TmpFinal
2730:                     REPLACE TmpFinal.Saldo    WITH TmpFinal.Saldo    - loc_nQtUtil, ;
2731:                             TmpFinal.Produzir WITH TmpFinal.Produzir - loc_nQtUtil IN TmpFinal
2732: 
2733:                     REPLACE Saldo    WITH Saldo    - loc_nQtUtil, ;
2734:                             Produzir WITH Produzir - loc_nQtUtil IN TmpFinalg
2735: 
2736:                     SELECT TmpFinalg
2737:                     REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
2738:                                               QtdMins - Produzir, 0) IN TmpFinalg
2739: 
2740:                     *-- Atualizar TmpSaldo: reduzir Disps
2741:                     SELECT TmpSaldo
2742:                     REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nQtUtil
2743: 
2744:                     *-- Redistribuir Disps em TmpSaldG: reset ao Saldo, depois debitar xBaixa
2745:                     loc_nXBaixa = TmpSaldo.Saldo - TmpSaldo.Disps
2746:                     SELECT TmpSaldG
2747:                     SET ORDER TO Cpros
2748:                     =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
2749:                     REPLACE Disps WITH Saldo ;
2750:                         WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND ;
2751:                               CodTams = TmpSaldo.CodTams
2752:                     =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
2753:                     SCAN WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND ;
2754:                                CodTams = TmpSaldo.CodTams AND loc_nXBaixa > 0
2755:                         IF TmpSaldG.Disps >= loc_nXBaixa
2756:                             REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nXBaixa
2757:                             loc_nXBaixa = 0
2758:                         ELSE
2759:                             loc_nXBaixa = loc_nXBaixa - TmpSaldG.Disps
2760:                             REPLACE TmpSaldG.Disps WITH 0
2761:                         ENDIF
2762:                     ENDSCAN
2763: 
2764:                     *-- Quebrar SigMvIts: dividir linha sem tamanho pelo tamanho selecionado
2765:                     IF USED("SigMvIts")
2766:                         SELECT SigMvIts
2767:                         SET ORDER TO EmpDopnPro
2768:                         SEEK(TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6) + TmpFinal.Cpros)
2769:                         SCAN WHILE Emps + Dopes + STR(Numes, 6) + Cpros = ;
2770:                                    TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6) + TmpFinal.Cpros
2771:                             IF Citens <> TmpFinal.Citens
2772:                                 LOOP
2773:                             ENDIF
2774:                             IF CodCors = TmpFinal.CodCors AND CodTams = SPACE(4)
2775:                                 *-- Captura registro original; ajusta registro atual com novo tamanho
2776:                                 SCATTER TO loc_aMemvar
2777:                                 REPLACE CodTams WITH TmpDisp.CodTams
2778:                                 REPLACE Qtds    WITH loc_nQtUtil
2779:                                 REPLACE Aqtds   WITH Qtds
2780:                                 *-- Readiciona registro original com quantidade reduzida
2781:                                 APPEND FROM ARRAY loc_aMemvar
2782:                                 REPLACE Qtds  WITH Qtds - loc_nQtUtil
2783:                                 REPLACE Aqtds WITH Qtds
2784:                                 IF Qtds = 0
2785:                                     DELETE
2786:                                 ENDIF
2787:                                 EXIT
2788:                             ENDIF
2789:                         ENDSCAN
2790:                     ENDIF
2791: 
2792:                 ENDSCAN
2793: 
2794:                 *-- Incorporar registros de Temporario em TmpFinal e limpar zerados
2795:                 SELECT TmpFinal
2796:                 APPEND FROM DBF('Temporario')
2797:                 GO loc_nRegFinal
2798:                 IF TmpFinal.Saldo = 0
2799:                     DELETE
2800:                 ENDIF
2801: 
2802:                 SELECT TmpFinalg
2803:                 IF TmpFinalg.Saldo = 0
2804:                     DELETE
2805:                 ENDIF
2806: 
2807:                 =SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, 'TmpSaldo')
2808: 
2809:             ENDIF
2810: 
2811:                 THIS.AtualizarTotaisGrade()
2812: 
2813:             ENDIF
2814: 
2815:             THIS.AlternarPagina(1)
2816: 
2817:         CATCH TO loc_oErr
2818:             MsgErro("Erro em BtnVoltarPage5Click: " + loc_oErr.Message + ;
2819:                     " [Ln:" + TRANSFORM(loc_oErr.LineNo) + ;

*-- Linhas 2852 a 2870:
2852:                 loc_lResultado = .F.
2853:             ELSE
2854:                 loc_nRegDisp = RECNO("TmpDisp")
2855:                 SELECT TmpDisp
2856:                 SUM TmpDisp.Utilizar TO loc_nQtdUti
2857:                 GO loc_nRegDisp IN TmpDisp
2858:                 IF loc_nQtdUti > loc_nPedida
2859:                     MsgAviso("Qtde Selecionada n"+CHR(227)+"o pode ser maior que Qtde Solicitada...")
2860:                     THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Value = 0
2861:                     THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Refresh
2862:                     loc_lResultado = .F.
2863:                 ELSE
2864:                     WITH THIS.pgf_4c_Paginas.Page4
2865:                         .txt_4c_P4QtSelec.Value = loc_nQtdUti
2866:                         .txt_4c_P4QtSelec.Refresh
2867:                     ENDWITH
2868:                 ENDIF
2869:             ENDIF
2870:         ENDIF

*-- Linhas 2917 a 2935:
2917:             loc_lResultado = .F.
2918:         ELSE
2919:             loc_nRegDisp = RECNO("TmpDisp")
2920:             SELECT TmpDisp
2921:             SUM TmpDisp.Utilizar TO loc_nQtdUti
2922:             GO loc_nRegDisp IN TmpDisp
2923:             IF loc_nQtdUti > loc_nPedida
2924:                 MsgAviso("Qtde Selecionada n"+CHR(227)+"o pode ser maior que Qtde Pedida...")
2925:                 THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Value = 0
2926:                 THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Refresh
2927:                 loc_lResultado = .F.
2928:             ELSE
2929:                 WITH THIS.pgf_4c_Paginas.Page5
2930:                     .txt_4c_P5QtSelec.Value = loc_nQtdUti
2931:                     .txt_4c_P5QtSelec.Refresh
2932:                 ENDWITH
2933:             ENDIF
2934:         ENDIF
2935: 

*-- Linhas 2958 a 2978:
2958:         loc_oPag2.lbl_4c_ObsItem.Caption = "Observa"+CHR(231)+CHR(227)+"o do Item " + ALLTRIM(TmpFinal.Cpros)
2959:         loc_oPag2.edt_4c_ObsItens.Refresh
2960: 
2961:         loc_lcSql = [SELECT cpros, figjpgs FROM SigCdPro WHERE Cpros = ] + ;
2962:                     EscaparSQL(TmpFinal.Cpros)
2963:         IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_ProdFig2") >= 1
2964:             WITH loc_oPag2.img_4c_FigOpe
2965:                 IF NOT EMPTY(cursor_4c_ProdFig2.FigJpgs) AND NOT ISNULL(cursor_4c_ProdFig2.FigJpgs)
2966:                     loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
2967:                     loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ProdFig2.FigJpgs, ;
2968:                         "data:image/png;base64,", ""), ;
2969:                         "data:image/jpeg;base64,", ""), ;
2970:                         "data:image/jpg;base64,", ""), 14)
2971:                     =STRTOFILE(loc_lcFoto, loc_lcArquivo)
2972:                     .Picture = loc_lcArquivo
2973:                     .Visible = .T.
2974:                 ELSE
2975:                     .Picture = ""
2976:                     .Visible = .F.
2977:                 ENDIF
2978:             ENDWITH

*-- Linhas 3052 a 3070:
3052:             RETURN
3053:         ENDIF
3054: 
3055:         SELECT TmpFinal
3056:         loc_nRecno = RECNO()
3057:         SUM Saldo, Estoque, Produzir, Fabrs TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
3058:         GO loc_nRecno
3059: 
3060:         WITH THIS.pgf_4c_Paginas.Page2
3061:             .txt_4c_P2TotQtd.Value = loc_nSal
3062:             .txt_4c_P2TotEst.Value = loc_nEst
3063:             .txt_4c_P2TotPrc.Value = loc_nPrc
3064:             .txt_4c_P2TotPrz.Value = loc_nPrz
3065:             .txt_4c_P2TotQtd.Refresh
3066:             .txt_4c_P2TotEst.Refresh
3067:             .txt_4c_P2TotPrc.Refresh
3068:             .txt_4c_P2TotPrz.Refresh
3069:         ENDWITH
3070:     ENDPROC

*-- Linhas 3132 a 3175:
3132:         ENDIF
3133: 
3134:         TRY
3135:             loc_lcSql = [SELECT a.CPros, a.DPros, a.Cunis FROM SigCdPro a WHERE a.CPros = ] + ;
3136:                         EscaparSQL(loc_cCodPro)
3137:             IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_BPPedra") >= 1 AND ;
3138:                NOT EOF("cursor_4c_BPPedra")
3139:                 REPLACE SelPedra.Cpros  WITH ALLTRIM(cursor_4c_BPPedra.CPros) IN SelPedra
3140:                 REPLACE SelPedra.Dpros  WITH ALLTRIM(cursor_4c_BPPedra.DPros) IN SelPedra
3141:                 REPLACE SelPedra.Cunis  WITH ALLTRIM(cursor_4c_BPPedra.Cunis) IN SelPedra
3142:                 USE IN cursor_4c_BPPedra
3143:             ELSE
3144:                 IF USED("cursor_4c_BPPedra")
3145:                     USE IN cursor_4c_BPPedra
3146:                 ENDIF
3147:                 *-- Produto nao encontrado: abrir picker
3148:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3149:                     "SigCdPro", "cursor_4c_BPPedra2", "CPros", loc_cCodPro, ;
3150:                     "Selecionar Produto", .T., .T., "")
3151:                 loc_oBusca.mAddColuna("CPros", "", "C"+CHR(243)+"digo")
3152:                 loc_oBusca.mAddColuna("DPros", "", "Descri"+CHR(231)+CHR(227)+"o")
3153:                 loc_oBusca.Show()
3154:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BPPedra2")
3155:                     REPLACE SelPedra.Cpros WITH ALLTRIM(cursor_4c_BPPedra2.CPros) IN SelPedra
3156:                     REPLACE SelPedra.Dpros WITH ALLTRIM(cursor_4c_BPPedra2.DPros) IN SelPedra
3157:                     *-- Buscar unidade complementar
3158:                     loc_lcSql2 = [SELECT Cunis FROM SigCdPro WHERE CPros = ] + ;
3159:                                  EscaparSQL(ALLTRIM(cursor_4c_BPPedra2.CPros))
3160:                     IF SQLEXEC(gnConnHandle, loc_lcSql2, "cursor_4c_BPUni") >= 1
3161:                         REPLACE SelPedra.Cunis WITH ALLTRIM(cursor_4c_BPUni.Cunis) IN SelPedra
3162:                         USE IN cursor_4c_BPUni
3163:                     ENDIF
3164:                 ELSE
3165:                     REPLACE SelPedra.Cpros WITH "" IN SelPedra
3166:                     REPLACE SelPedra.Dpros WITH "" IN SelPedra
3167:                     REPLACE SelPedra.Cunis WITH "" IN SelPedra
3168:                 ENDIF
3169:                 IF USED("cursor_4c_BPPedra2")
3170:                     USE IN cursor_4c_BPPedra2
3171:                 ENDIF
3172:                 loc_oBusca.Release()
3173:             ENDIF
3174: 
3175:             THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.Refresh

*-- Linhas 3221 a 3240:
3221:         ENDIF
3222: 
3223:         TRY
3224:             loc_lcSql = [SELECT CPros FROM SigCdPro WHERE CPros = ] + EscaparSQL(loc_cCodRef)
3225:             IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_BPro2") >= 1 AND ;
3226:                NOT EOF("cursor_4c_BPro2")
3227:                 REPLACE SelPedra.Cpro2s WITH ALLTRIM(cursor_4c_BPro2.CPros) IN SelPedra
3228:                 USE IN cursor_4c_BPro2
3229:             ELSE
3230:                 IF USED("cursor_4c_BPro2")
3231:                     USE IN cursor_4c_BPro2
3232:                 ENDIF
3233:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3234:                     "SigCdPro", "cursor_4c_BPro2b", "CPros", loc_cCodRef, ;
3235:                     "Produto Refer"+CHR(234)+"ncia", .T., .T., "")
3236:                 loc_oBusca.mAddColuna("CPros", "", "C"+CHR(243)+"digo")
3237:                 loc_oBusca.mAddColuna("DPros", "", "Descri"+CHR(231)+CHR(227)+"o")
3238:                 loc_oBusca.Show()
3239:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BPro2b")
3240:                     REPLACE SelPedra.Cpro2s WITH ALLTRIM(cursor_4c_BPro2b.CPros) IN SelPedra

*-- Linhas 3325 a 3351:
3325: 
3326:         loc_lcCodPro  = TmpFinalg.Cpros
3327:         loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
3328:         loc_lcSql     = "SELECT a.cpros, a.dpros, a.FigJpgs FROM SigCdPro a " + ;
3329:                         "WHERE a.cpros = " + EscaparSQL(loc_lcCodPro)
3330: 
3331:         TRY
3332:             IF USED("cursor_4c_LocalPro")
3333:                 USE IN cursor_4c_LocalPro
3334:             ENDIF
3335: 
3336:             IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_LocalPro") < 1
3337:                 MsgAviso("N"+CHR(227)+"o foi poss"+CHR(237)+"vel carregar a imagem do produto.")
3338:                 RETURN
3339:             ENDIF
3340: 
3341:             IF NOT EMPTY(NVL(cursor_4c_LocalPro.FigJpgs, "")) AND ;
3342:                NOT ISNULL(cursor_4c_LocalPro.FigJpgs)
3343: 
3344:                 loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
3345:                     cursor_4c_LocalPro.FigJpgs, ;
3346:                     "data:image/png;base64,",  ""), ;
3347:                     "data:image/jpeg;base64,", ""), ;
3348:                     "data:image/jpg;base64,",  ""), 14)
3349:                 =STRTOFILE(loc_lcFoto, loc_lcArquivo)
3350: 
3351:                 WITH THIS.pgf_4c_Paginas.Page1.img_4c_FigJpg

