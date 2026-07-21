# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, FABRS, CODCORS, DISPS, NUMERODAOP, NUMPS, KEYPDES, PRODUZIR, FABRPROPRS, _LNVEZES, EMPDOPNUMS, CIDCHAVES, CITEM2, CONTADS, EMPS, NUMES, CODTAMS, XBAIXA, NOPS, QTDS, IF, X, CMATS, PRAZOENTS, ENTPES, AUTOS, MATS, NTRANS, TMPH, EMPDNPS, ESTOQUE, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'UTILIZAR' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, FABRS, CODCORS, DISPS, NUMERODAOP, NUMPS, KEYPDES, PRODUZIR, FABRPROPRS, _LNVEZES, EMPDOPNUMS, CIDCHAVES, CITEM2, CONTADS, EMPS, NUMES, CODTAMS, XBAIXA, NOPS, QTDS, IF, X, CMATS, PRAZOENTS, ENTPES, AUTOS, MATS, NTRANS, TMPH, EMPDNPS, ESTOQUE, CITENS, QTPRODS, DTALTS

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.prg) - TRECHOS RELEVANTES PARA PASS SQL (3954 linhas total):

*-- Linhas 124 a 142:
124:             IF USED("TmpSaldU")
125:                 USE IN TmpSaldU
126:             ENDIF
127:             CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L, KeySelmp L)
128:             INDEX ON Cpros TAG Cpros
129: 
130:             *-- Carrega totais iniciais do BO
131:             THIS.AtualizarTotaisPage1()
132: 
133:         CATCH TO loc_oErro
134:             MsgErro("Erro ao inicializar form: " + loc_oErro.Message, "Erro")
135:         ENDTRY
136:     ENDPROC
137: 
138:     *--------------------------------------------------------------------------
139:     * ConfigurarPageFrame - Cria PageFrame com 6 paginas
140:     *--------------------------------------------------------------------------
141:     PROTECTED PROCEDURE ConfigurarPageFrame()
142: 

*-- Linhas 351 a 431:
351:                 .ColumnCount  = 10
352:                 .RecordSource = IIF(USED("TmpFinal"), "TmpFinal", "")
353:                 .RecordMark   = .F.
354:                 .DeleteMark   = .F.
355:                 .Visible      = .F.
356: 
357:                 WITH .Column1
358:                     .Header1.Caption = "Produto"
359:                     .ControlSource   = "TmpFinal.Cpros"
360:                     .Width           = 90
361:                     .ReadOnly        = .T.
362:                 ENDWITH
363:                 WITH .Column2
364:                     .Header1.Caption = "Cor"
365:                     .ControlSource   = "TmpFinal.CodCors"
366:                     .Width           = 35
367:                     .ReadOnly        = .T.
368:                 ENDWITH
369:                 WITH .Column3
370:                     .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
371:                     .ControlSource   = "TmpFinal.Dopes"
372:                     .Width           = 60
373:                     .ReadOnly        = .T.
374:                 ENDWITH
375:                 WITH .Column4
376:                     .Header1.Caption = "N" + CHR(250) + "mero"
377:                     .ControlSource   = "TmpFinal.Nops"
378:                     .Width           = 50
379:                     .ReadOnly        = .T.
380:                 ENDWITH
381:                 WITH .Column5
382:                     .Header1.Caption = "Quantidade"
383:                     .ControlSource   = "TmpFinal.Saldo"
384:                     .Width           = 62
385:                     .ReadOnly        = .T.
386:                     .Text1.Alignment = 1
387:                 ENDWITH
388:                 WITH .Column6
389:                     .Header1.Caption = "Produzir"
390:                     .ControlSource   = "TmpFinal.Produzir"
391:                     .Width           = 57
392:                     .ReadOnly        = .T.
393:                     .Text1.Alignment = 1
394:                 ENDWITH
395:                 WITH .Column7
396:                     .Header1.Caption = "Estoque"
397:                     .ControlSource   = "TmpFinal.Estoque"
398:                     .Width           = 62
399:                     .ReadOnly        = .F.
400:                     .Text1.Alignment = 1
401:                 ENDWITH
402:                 WITH .Column8
403:                     .Header1.Caption = "Obs"
404:                     .ControlSource   = "TmpFinal.CodObs"
405:                     .Width           = 60
406:                     .ReadOnly        = .T.
407:                 ENDWITH
408:                 WITH .Column9
409:                     .Header1.Caption = "Tam"
410:                     .ControlSource   = "TmpFinal.CodTams"
411:                     .Width           = 33
412:                     .ReadOnly        = .T.
413:                 ENDWITH
414:                 WITH .Column10
415:                     .Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
416:                     .ControlSource   = "TmpFinal.Fabrs"
417:                     .Width           = 62
418:                     .ReadOnly        = .F.
419:                     .Text1.Alignment = 1
420:                 ENDWITH
421:             ENDWITH
422:             THIS.FormatarGrid(loc_oPage.grd_4c_GradeItens2)
423: 
424:             loc_oPage.AddObject("lbl_4c_LblTotais", "Label")
425:             WITH loc_oPage.lbl_4c_LblTotais
426:                 .Top       = 372
427:                 .Left      = 403
428:                 .Width     = 42
429:                 .Height    = 17
430:                 .Caption   = "Totais :"
431:                 .BackStyle = 0

*-- Linhas 492 a 510:
492:                 .Left          = 221
493:                 .Width         = 396
494:                 .Height        = 69
495:                 .ControlSource = IIF(USED("TmpFinal"), "TmpFinal.CodObs", "")
496:                 .ReadOnly      = .T.
497:                 .Visible       = .F.
498:             ENDWITH
499: 
500:             loc_oPage.AddObject("lbl_4c_Txt_ObsItens", "Label")
501:             WITH loc_oPage.lbl_4c_Txt_ObsItens
502:                 .Top       = 400
503:                 .Left      = 221
504:                 .Width     = 119
505:                 .Height    = 17
506:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item : "
507:                 .BackStyle = 0
508:                 .Visible   = .F.
509:             ENDWITH
510: 

*-- Linhas 619 a 666:
619:                 .ColumnCount  = 5
620:                 .RecordSource = IIF(USED("TmpLinha"), "TmpLinha", "")
621:                 .RecordMark   = .F.
622:                 .DeleteMark   = .F.
623:                 .ReadOnly     = .T.
624:                 .Visible      = .F.
625: 
626:                 WITH .Column1
627:                     .Header1.Caption = "Linha"
628:                     .ControlSource   = "TmpLinha.Linhas"
629:                     .Width           = 80
630:                 ENDWITH
631:                 WITH .Column2
632:                     .Header1.Caption = "Quantidade"
633:                     .ControlSource   = "TmpLinha.Saldo"
634:                     .Width           = 74
635:                     .Text1.Alignment = 1
636:                 ENDWITH
637:                 WITH .Column3
638:                     .Header1.Caption = "Estoque"
639:                     .ControlSource   = "TmpLinha.Estoque"
640:                     .Width           = 74
641:                     .Text1.Alignment = 1
642:                 ENDWITH
643:                 WITH .Column4
644:                     .Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
645:                     .ControlSource   = "TmpLinha.Fabrs"
646:                     .Width           = 74
647:                     .Text1.Alignment = 1
648:                 ENDWITH
649:                 WITH .Column5
650:                     .Header1.Caption = "Produzir"
651:                     .ControlSource   = "TmpLinha.Produzir"
652:                     .Width           = 74
653:                     .Text1.Alignment = 1
654:                 ENDWITH
655:             ENDWITH
656:             THIS.FormatarGrid(loc_oPage.grd_4c_GradeLinhas)
657: 
658:             loc_oPage.AddObject("cmd_4c_Voltar", "CommandButton")
659:             WITH loc_oPage.cmd_4c_Voltar
660:                 .Top         = 12
661:                 .Left        = 704
662:                 .Width       = 75
663:                 .Height      = 75
664:                 .Caption     = "Voltar"
665:                 .FontName    = "Tahoma"
666:                 .FontSize    = 8

*-- Linhas 726 a 775:
726:                 .ColumnCount  = 5
727:                 .RecordSource = IIF(USED("TmpDisp"), "TmpDisp", "")
728:                 .RecordMark   = .F.
729:                 .DeleteMark   = .F.
730:                 .Visible      = .F.
731: 
732:                 WITH .Column1
733:                     .Header1.Caption = "Grupo"
734:                     .ControlSource   = "TmpDisp.Grupos"
735:                     .Width           = 60
736:                     .ReadOnly        = .T.
737:                 ENDWITH
738:                 WITH .Column2
739:                     .Header1.Caption = "Conta"
740:                     .ControlSource   = "TmpDisp.Estos"
741:                     .Width           = 60
742:                     .ReadOnly        = .T.
743:                 ENDWITH
744:                 WITH .Column3
745:                     .Header1.Caption = "Prior"
746:                     .ControlSource   = "TmpDisp.Priors"
747:                     .Width           = 55
748:                     .ReadOnly        = .T.
749:                     .Text1.Alignment = 1
750:                 ENDWITH
751:                 WITH .Column4
752:                     .Header1.Caption = "Dispon" + CHR(237) + "vel"
753:                     .ControlSource   = "TmpDisp.Disps"
754:                     .Width           = 65
755:                     .ReadOnly        = .T.
756:                     .Text1.Alignment = 1
757:                 ENDWITH
758:                 WITH .Column5
759:                     .Header1.Caption = "Utilizar"
760:                     .ControlSource   = "TmpDisp.Utilizar"
761:                     .Width           = 65
762:                     .ReadOnly        = .F.
763:                     .Text1.Alignment = 1
764:                 ENDWITH
765:             ENDWITH
766:             THIS.FormatarGrid(loc_oPage.grd_4c_GradeDisp)
767: 
768:             loc_oPage.AddObject("lbl_4c_Label2", "Label")
769:             WITH loc_oPage.lbl_4c_Label2
770:                 .Top       = 418
771:                 .Left      = 220
772:                 .Width     = 82
773:                 .Height    = 16
774:                 .Caption   = "Qtde Pedida : "
775:                 .BackStyle = 0

*-- Linhas 889 a 937:
889:                 .ColumnCount  = 5
890:                 .RecordSource = IIF(USED("TmpDisp"), "TmpDisp", "")
891:                 .RecordMark   = .F.
892:                 .DeleteMark   = .F.
893:                 .Visible      = .F.
894: 
895:                 WITH .Column1
896:                     .Header1.Caption = "Produto"
897:                     .ControlSource   = "TmpDisp.Cpros"
898:                     .Width           = 55
899:                     .ReadOnly        = .T.
900:                 ENDWITH
901:                 WITH .Column2
902:                     .Header1.Caption = "Cor"
903:                     .ControlSource   = "TmpDisp.CodCors"
904:                     .Width           = 40
905:                     .ReadOnly        = .T.
906:                 ENDWITH
907:                 WITH .Column3
908:                     .Header1.Caption = "Tam"
909:                     .ControlSource   = "TmpDisp.CodTams"
910:                     .Width           = 40
911:                     .ReadOnly        = .T.
912:                 ENDWITH
913:                 WITH .Column4
914:                     .Header1.Caption = "Dispon" + CHR(237) + "vel"
915:                     .ControlSource   = "TmpDisp.Disps"
916:                     .Width           = 65
917:                     .ReadOnly        = .T.
918:                     .Text1.Alignment = 1
919:                 ENDWITH
920:                 WITH .Column5
921:                     .Header1.Caption = "Utilizar"
922:                     .ControlSource   = "TmpDisp.Utilizar"
923:                     .Width           = 65
924:                     .ReadOnly        = .F.
925:                     .Text1.Alignment = 1
926:                 ENDWITH
927:             ENDWITH
928:             THIS.FormatarGrid(loc_oPage.grd_4c_GradeDisp)
929: 
930:             loc_oPage.AddObject("lbl_4c_Label2", "Label")
931:             WITH loc_oPage.lbl_4c_Label2
932:                 .Top       = 415
933:                 .Left      = 289
934:                 .Width     = 82
935:                 .Height    = 16
936:                 .Caption   = "Qtde Pedida : "
937:                 .BackStyle = 0

*-- Linhas 1050 a 1098:
1050:                 .ColumnCount  = 5
1051:                 .RecordSource = IIF(USED("SelPedra"), "SelPedra", "")
1052:                 .RecordMark   = .F.
1053:                 .DeleteMark   = .F.
1054:                 .Visible      = .F.
1055: 
1056:                 WITH .Column1
1057:                     .Header1.Caption = "Produto"
1058:                     .ControlSource   = "SelPedra.Cpros"
1059:                     .Width           = 90
1060:                     .ReadOnly        = .F.
1061:                 ENDWITH
1062:                 WITH .Column2
1063:                     .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1064:                     .ControlSource   = "SelPedra.Dpros"
1065:                     .Width           = 150
1066:                     .ReadOnly        = .T.
1067:                 ENDWITH
1068:                 WITH .Column3
1069:                     .Header1.Caption = "Uni"
1070:                     .ControlSource   = "SelPedra.Cunis"
1071:                     .Width           = 40
1072:                     .ReadOnly        = .T.
1073:                 ENDWITH
1074:                 WITH .Column4
1075:                     .Header1.Caption = "Qtde"
1076:                     .ControlSource   = "SelPedra.Qtdes"
1077:                     .Width           = 75
1078:                     .ReadOnly        = .F.
1079:                     .Text1.Alignment = 1
1080:                 ENDWITH
1081:                 WITH .Column5
1082:                     .Header1.Caption = "Produto"
1083:                     .ControlSource   = "SelPedra.Cpro2s"
1084:                     .Width           = 90
1085:                     .ReadOnly        = .F.
1086:                 ENDWITH
1087:             ENDWITH
1088:             THIS.FormatarGrid(loc_oPage.grd_4c_GradePedra)
1089: 
1090:             loc_oPage.AddObject("cmd_4c_Voltar", "CommandButton")
1091:             WITH loc_oPage.cmd_4c_Voltar
1092:                 .Top         = 12
1093:                 .Left        = 704
1094:                 .Width       = 75
1095:                 .Height      = 75
1096:                 .Caption     = "Voltar"
1097:                 .FontName    = "Tahoma"
1098:                 .FontSize    = 8

*-- Linhas 1242 a 1260:
1242:             .FontName   = "Verdana"
1243:             .FontSize   = 8
1244:             .RecordMark = .F.
1245:             .DeleteMark = .F.
1246:             .FontName = "Verdana"
1247:             .FontSize = 8
1248:         ENDWITH
1249:     ENDPROC
1250: 
1251:     *--------------------------------------------------------------------------
1252:     * ConfigurarPaginaLista - Adiciona grade de itens e controles na Page1
1253:     *--------------------------------------------------------------------------
1254:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1255: 
1256:         LOCAL loc_oPage, loc_oGrid
1257: 
1258:         TRY
1259:             loc_oPage = THIS.pgf_4c_1.Page1
1260: 

*-- Linhas 1298 a 1388:
1298:                 .ColumnCount  = 10
1299:                 .RecordSource = IIF(USED("TmpFinalg"), "TmpFinalg", "")
1300:                 .RecordMark   = .F.
1301:                 .DeleteMark   = .F.
1302:                 .Visible      = .F.
1303: 
1304:                 WITH .Column1
1305:                     .Header1.Caption = "Produto"
1306:                     .ControlSource   = "TmpFinalg.Cpros"
1307:                     .Width           = 90
1308:                     .ReadOnly        = .T.
1309:                 ENDWITH
1310: 
1311:                 WITH .Column2
1312:                     .Header1.Caption = "Cor"
1313:                     .ControlSource   = "TmpFinalg.CodCors"
1314:                     .Width           = 35
1315:                     .ReadOnly        = .T.
1316:                 ENDWITH
1317: 
1318:                 WITH .Column3
1319:                     .Header1.Caption = ""
1320:                     .ControlSource   = "TmpFinalg.Linhas"
1321:                     .Width           = 20
1322:                     .ReadOnly        = .T.
1323:                 ENDWITH
1324: 
1325:                 WITH .Column4
1326:                     .Header1.Caption = "N" + CHR(250) + "mero"
1327:                     .ControlSource   = "TmpFinalg.Nops"
1328:                     .Width           = 48
1329:                     .ReadOnly        = .T.
1330:                 ENDWITH
1331: 
1332:                 WITH .Column5
1333:                     .Header1.Caption = "Qtde Pedido"
1334:                     .ControlSource   = "TmpFinalg.Saldo"
1335:                     .Width           = 62
1336:                     .ReadOnly        = .T.
1337:                     .Text1.Alignment = 1
1338:                 ENDWITH
1339: 
1340:                 WITH .Column6
1341:                     .Header1.Caption = "Produzir"
1342:                     .ControlSource   = "TmpFinalg.Produzir"
1343:                     .Width           = 57
1344:                     .ReadOnly        = .T.
1345:                     .Text1.Alignment = 1
1346:                 ENDWITH
1347: 
1348:                 WITH .Column7
1349:                     .Header1.Caption = "Qtd Produ" + CHR(231) + CHR(227) + "o"
1350:                     .ControlSource   = "TmpFinalg.Fabrs"
1351:                     .Width           = 62
1352:                     .ReadOnly        = .F.
1353:                     .Text1.Alignment = 1
1354:                 ENDWITH
1355: 
1356:                 WITH .Column8
1357:                     .Header1.Caption = "Produzir Estq"
1358:                     .ControlSource   = "TmpFinalg.Produzir2"
1359:                     .Width           = 62
1360:                     .ReadOnly        = .F.
1361:                     .Text1.Alignment = 1
1362:                 ENDWITH
1363: 
1364:                 WITH .Column9
1365:                     .Header1.Caption = "Tam"
1366:                     .ControlSource   = "TmpFinalg.CodTams"
1367:                     .Width           = 33
1368:                     .ReadOnly        = .T.
1369:                 ENDWITH
1370: 
1371:                 WITH .Column10
1372:                     .Header1.Caption = "Qtd Estoque"
1373:                     .ControlSource   = "TmpFinalg.Estoque"
1374:                     .Width           = 62
1375:                     .ReadOnly        = .F.
1376:                     .Text1.Alignment = 1
1377:                 ENDWITH
1378:             ENDWITH
1379: 
1380:             THIS.FormatarGrid(loc_oPage.grd_4c_GradeItens)
1381: 
1382:             *-- Label e textboxes de totais da grade
1383:             loc_oPage.AddObject("lbl_4c_LblTotais", "Label")
1384:             WITH loc_oPage.lbl_4c_LblTotais
1385:                 .Top       = 348
1386:                 .Left      = 224
1387:                 .Width     = 42
1388:                 .Height    = 17

*-- Linhas 1593 a 1655:
1593:                 .ColumnCount  = 6
1594:                 .RecordSource = IIF(USED("TmpSaldG"), "TmpSaldG", "")
1595:                 .RecordMark   = .F.
1596:                 .DeleteMark   = .F.
1597:                 .ReadOnly     = .F.
1598:                 .Visible      = .F.
1599: 
1600:                 WITH .Column1
1601:                     .Header1.Caption = "Grupo"
1602:                     .ControlSource   = "TmpSaldG.Grupos"
1603:                     .Width           = 50
1604:                     .ReadOnly        = .T.
1605:                 ENDWITH
1606: 
1607:                 WITH .Column2
1608:                     .Header1.Caption = "Conta"
1609:                     .ControlSource   = "TmpSaldG.Estos"
1610:                     .Width           = 50
1611:                     .ReadOnly        = .T.
1612:                 ENDWITH
1613: 
1614:                 WITH .Column3
1615:                     .Header1.Caption = "Atual"
1616:                     .ControlSource   = "TmpSaldG.Saldo"
1617:                     .Width           = 60
1618:                     .ReadOnly        = .T.
1619:                     .Text1.Alignment = 1
1620:                 ENDWITH
1621: 
1622:                 WITH .Column4
1623:                     .Header1.Caption = "Utilizado"
1624:                     .ControlSource   = "TmpSaldG.Disps"
1625:                     .Width           = 60
1626:                     .ReadOnly        = .T.
1627:                     .Text1.Alignment = 1
1628:                 ENDWITH
1629: 
1630:                 WITH .Column5
1631:                     .Header1.Caption = "Dispon" + CHR(237) + "vel"
1632:                     .ControlSource   = "TmpSaldG.Disps"
1633:                     .Width           = 60
1634:                     .ReadOnly        = .T.
1635:                     .Text1.Alignment = 1
1636:                 ENDWITH
1637: 
1638:                 WITH .Column6
1639:                     .Header1.Caption = "Prior"
1640:                     .ControlSource   = "TmpSaldG.Priors"
1641:                     .Width           = 50
1642:                     .ReadOnly        = .T.
1643:                     .Text1.Alignment = 1
1644:                 ENDWITH
1645:             ENDWITH
1646: 
1647:             THIS.FormatarGrid(loc_oCnt.grd_4c_EstDisp)
1648: 
1649:             loc_oCnt.AddObject("lbl_4c_Label2", "Label")
1650:             WITH loc_oCnt.lbl_4c_Label2
1651:                 .Top       = 163
1652:                 .Left      = 128
1653:                 .Width     = 42
1654:                 .Height    = 17
1655:                 .Caption   = "Totais :"

*-- Linhas 1731 a 1782:
1731:                 .ColumnCount  = 5
1732:                 .RecordSource = IIF(USED("TmpFinal"), "TmpFinal", "")
1733:                 .RecordMark   = .F.
1734:                 .DeleteMark   = .F.
1735:                 .ReadOnly     = .T.
1736:                 .Visible      = .F.
1737: 
1738:                 WITH .Column1
1739:                     .Header1.Caption = "Fase"
1740:                     .ControlSource   = "TmpFinal.Dopes"
1741:                     .Width           = 55
1742:                 ENDWITH
1743: 
1744:                 WITH .Column2
1745:                     .Header1.Caption = "Disponivel"
1746:                     .ControlSource   = "TmpFinal.Saldo"
1747:                     .Width           = 62
1748:                     .Text1.Alignment = 1
1749:                 ENDWITH
1750: 
1751:                 WITH .Column3
1752:                     .Header1.Caption = "Utilizado"
1753:                     .ControlSource   = "TmpFinal.Estoque"
1754:                     .Width           = 62
1755:                     .Text1.Alignment = 1
1756:                 ENDWITH
1757: 
1758:                 WITH .Column4
1759:                     .Header1.Caption = "Nop"
1760:                     .ControlSource   = "TmpFinal.Produzir"
1761:                     .Width           = 62
1762:                     .Text1.Alignment = 1
1763:                 ENDWITH
1764: 
1765:                 WITH .Column5
1766:                     .Header1.Caption = "Prior"
1767:                     .ControlSource   = "TmpFinal.Fabrs"
1768:                     .Width           = 55
1769:                     .Text1.Alignment = 1
1770:                 ENDWITH
1771:             ENDWITH
1772: 
1773:             THIS.FormatarGrid(loc_oCnt.grd_4c_EstProd)
1774: 
1775:             loc_oCnt.AddObject("lbl_4c_Label2", "Label")
1776:             WITH loc_oCnt.lbl_4c_Label2
1777:                 .Top       = 115
1778:                 .Left      = 102
1779:                 .Width     = 42
1780:                 .Height    = 17
1781:                 .Caption   = "Totais :"
1782:                 .BackStyle = 0

*-- Linhas 2024 a 2051:
2024: 
2025:             *-- Filtra TmpSaldG pelo item atual
2026:             IF USED("TmpSaldG")
2027:                 SELECT TmpSaldG
2028:                 SET ORDER TO Cpros
2029:                 SET KEY TO ALLTRIM(TmpFinalg.Cpros) + ALLTRIM(TmpFinalg.CodCors) + ;
2030:                     ALLTRIM(TmpFinalg.CodTams)
2031:                 GO TOP
2032:             ENDIF
2033: 
2034:             *-- Filtra TmpFinal pelo item atual (Container1)
2035:             IF USED("TmpFinal")
2036:                 SELECT TmpFinal
2037:                 SET ORDER TO Cpros
2038:                 SET KEY TO ALLTRIM(TmpFinalg.Cpros) + ALLTRIM(TmpFinalg.CodCors) + ;
2039:                     ALLTRIM(TmpFinalg.CodTams)
2040:                 GO TOP
2041:             ENDIF
2042: 
2043:             *-- Totais de Container3 via TmpSaldo (registro unico por produto/cor/tam)
2044:             IF USED("TmpSaldo") AND SEEK(ALLTRIM(TmpFinalg.Cpros) + ;
2045:                ALLTRIM(TmpFinalg.CodCors) + ALLTRIM(TmpFinalg.CodTams), "TmpSaldo")
2046: 
2047:                 loc_oCnt3 = loc_oPage.cnt_4c_Container3
2048:                 IF PEMSTATUS(loc_oCnt3, "txt_4c_Tot_Qtd", 5)
2049:                     loc_oCnt3.txt_4c_Tot_Qtd.Value = TmpSaldo.Saldo
2050:                     loc_oCnt3.txt_4c_Tot_Est.Value = TmpSaldo.Saldo - TmpSaldo.Disps
2051:                     loc_oCnt3.txt_4c_Tot_Prz.Value = TmpSaldo.Disps

*-- Linhas 2100 a 2123:
2100: 
2101:         TRY
2102:             loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
2103:             loc_cSql     = "SELECT a.cpros, a.FigJpgs FROM SigCdPro a " + ;
2104:                 "WHERE a.cpros = " + EscaparSQL(par_cCpros)
2105: 
2106:             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FotoPro") > 0 AND ;
2107:                USED("cursor_4c_FotoPro") AND RECCOUNT("cursor_4c_FotoPro") > 0
2108:                 SELECT cursor_4c_FotoPro
2109:                 IF !EMPTY(cursor_4c_FotoPro.FigJpgs) AND !ISNULL(cursor_4c_FotoPro.FigJpgs)
2110:                     loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FotoPro.FigJpgs, ;
2111:                         "data:image/png;base64,",  ""), ;
2112:                         "data:image/jpeg;base64,", ""), ;
2113:                         "data:image/jpg;base64,",  ""), 14)
2114:                     =STRTOFILE(loc_cFoto, loc_cArquivo)
2115:                     loc_oImg = THIS.pgf_4c_1.Page1.img_4c_ImgFigJpg
2116:                     IF FILE(loc_cArquivo) AND PEMSTATUS(loc_oImg, "Picture", 5)
2117:                         loc_oImg.Picture = loc_cArquivo
2118:                         loc_oImg.Visible = .T.
2119:                     ENDIF
2120:                 ELSE
2121:                     THIS.pgf_4c_1.Page1.img_4c_ImgFigJpg.Visible = .F.
2122:                 ENDIF
2123:                 USE IN cursor_4c_FotoPro

*-- Linhas 2155 a 2173:
2155:                 loc_nRecno     = IIF(!BOF("TmpFinalg") AND !EOF("TmpFinalg"), ;
2156:                     RECNO("TmpFinalg"), 0)
2157: 
2158:                 SELECT TmpFinalg
2159:                 SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 ;
2160:                     TO loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs, loc_nProduzir2
2161: 
2162:                 IF loc_nRecno > 0 AND RECCOUNT("TmpFinalg") >= loc_nRecno
2163:                     GO loc_nRecno IN TmpFinalg
2164:                 ENDIF
2165: 
2166:                 WITH loc_oPage
2167:                     .txt_4c_Tot_Qtd.Value  = loc_nSaldo
2168:                     .txt_4c_Tot_Est.Value  = loc_nEstoque
2169:                     .txt_4c_Tot_Prz.Value  = loc_nProduzir
2170:                     .txt_4c_Tot_prdc.Value = loc_nFabrs
2171:                     .txt_4c_Tot_prze.Value = loc_nProduzir2
2172:                     .txt_4c_Tot_Qtd.Refresh
2173:                     .txt_4c_Tot_Est.Refresh

*-- Linhas 2215 a 2233:
2215: 
2216:             IF USED("TmpFinalg") AND !EOF("TmpFinalg") AND USED("TmpSaldU")
2217:                 IF !SEEK(ALLTRIM(TmpFinalg.Cpros), "TmpSaldU", "Cpros")
2218:                     INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2219:                 ENDIF
2220: 
2221:                 IF loc_nNewVal <> loc_nOld AND TmpSaldU.KeySelmp
2222:                     IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + ;
2223:                         "o Manual de OP." + CHR(13) + ;
2224:                         "O sistema ir" + CHR(225) + " acionar o modo autom" + ;
2225:                         CHR(225) + "tico. Deseja Continuar?")
2226:                         loc_oGrid.Column7.Text1.Value = loc_nOld
2227:                         loc_lResultado = 0
2228:                     ENDIF
2229:                 ENDIF
2230:             ENDIF
2231: 
2232:             IF loc_lResultado = 1 AND USED("TmpFinalg") AND !EOF("TmpFinalg")
2233:                 DO CASE

*-- Linhas 2242 a 2260:
2242:                     loc_oGrid.Column7.Text1.Value = loc_nOld
2243:                     loc_lResultado = 0
2244:                 OTHERWISE
2245:                     SELECT TmpFinalg
2246:                     REPLACE Fabrs WITH loc_nNewVal
2247:                 ENDCASE
2248:             ENDIF
2249:         CATCH TO loc_oErro
2250:             MsgErro("Erro na valida" + CHR(231) + CHR(227) + "o da coluna 7: " + ;
2251:                 loc_oErro.Message, "Erro")
2252:             loc_lResultado = 0
2253:         ENDTRY
2254:         RETURN loc_lResultado
2255:     ENDPROC
2256: 
2257:     *--------------------------------------------------------------------------
2258:     * ColC7LostFocus - Handler LostFocus da coluna 7 - atualiza totais
2259:     *--------------------------------------------------------------------------
2260:     PROCEDURE ColC7LostFocus

*-- Linhas 2304 a 2327:
2304:             IF USED("TmpFinalg") AND !EOF("TmpFinalg") AND ;
2305:                !ISNULL(THIS.this_oBusinessObject) AND ISOBJECT(THIS.this_oBusinessObject)
2306:                 IF THIS.this_oBusinessObject.this_lReserva AND TmpFinalg.Estoque = 0
2307:                     loc_cSql = "SELECT a.CGrus, b.TipoEstos " + ;
2308:                         "FROM SigCdPro a INNER JOIN SigCdGrp b ON a.CGrus = b.CGrus " + ;
2309:                         "WHERE a.CPros = " + EscaparSQL(ALLTRIM(TmpFinalg.Cpros))
2310:                     IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpTipo") > 0 AND ;
2311:                        USED("cursor_4c_GrpTipo") AND RECCOUNT("cursor_4c_GrpTipo") > 0
2312:                         SELECT cursor_4c_GrpTipo
2313:                         loc_lMostraDisp = INLIST(cursor_4c_GrpTipo.TipoEstos, 3, 4)
2314:                         USE IN cursor_4c_GrpTipo
2315:                         IF loc_lMostraDisp AND ;
2316:                            PEMSTATUS(THIS.pgf_4c_1.Page1, "cmd_4c_Disponivel", 5)
2317:                             THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .T.
2318:                         ENDIF
2319:                     ENDIF
2320:                 ENDIF
2321:             ENDIF
2322:         CATCH TO loc_oErro
2323:             MsgErro("Erro em ColC10When: " + loc_oErro.Message, "Erro")
2324:         ENDTRY
2325:         RETURN loc_lResultado
2326:     ENDPROC
2327: 

*-- Linhas 2341 a 2382:
2341: 
2342:             IF USED("TmpFinalg") AND !EOF("TmpFinalg") AND USED("TmpSaldU")
2343:                 IF !SEEK(ALLTRIM(TmpFinalg.Cpros), "TmpSaldU", "Cpros")
2344:                     INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2345:                 ENDIF
2346: 
2347:                 IF loc_nNewVal <> loc_nOld AND TmpSaldU.KeySelm
2348:                     IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + ;
2349:                         "o Manual de estoque." + CHR(13) + ;
2350:                         "O sistema ir" + CHR(225) + " acionar o modo autom" + ;
2351:                         CHR(225) + "tico. Deseja Continuar?")
2352:                         loc_oGrid.Column10.Text1.Value = loc_nOld
2353:                         loc_lResultado = 0
2354:                     ENDIF
2355:                 ENDIF
2356:             ENDIF
2357: 
2358:             IF loc_lResultado = 1 AND USED("TmpFinalg") AND !EOF("TmpFinalg")
2359:                 DO CASE
2360:                 CASE loc_nNewVal = loc_nOld
2361:                     *-- Sem mudanca
2362:                 CASE loc_nNewVal < 0
2363:                     MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo!!!")
2364:                     loc_oGrid.Column10.Text1.Value = loc_nOld
2365:                     loc_lResultado = 0
2366:                 OTHERWISE
2367:                     SELECT TmpFinalg
2368:                     REPLACE Estoque WITH loc_nNewVal
2369:                 ENDCASE
2370:             ENDIF
2371:         CATCH TO loc_oErro
2372:             MsgErro("Erro na valida" + CHR(231) + CHR(227) + "o da coluna 10: " + ;
2373:                 loc_oErro.Message, "Erro")
2374:             loc_lResultado = 0
2375:         ENDTRY
2376:         RETURN loc_lResultado
2377:     ENDPROC
2378: 
2379:     *--------------------------------------------------------------------------
2380:     * ColC10LostFocus - Handler LostFocus da coluna 10 - atualiza totais
2381:     *--------------------------------------------------------------------------
2382:     PROCEDURE ColC10LostFocus

*-- Linhas 2410 a 2428:
2410: 
2411:         TRY
2412:             IF USED("TmpSaldG") AND RECCOUNT("TmpSaldG") > 0
2413:                 SELECT TmpSaldG
2414:                 SKIP
2415:                 SKIP -1
2416:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1.cnt_4c_Container3, "grd_4c_EstDisp", 5)
2417:                     THIS.pgf_4c_1.Page1.cnt_4c_Container3.grd_4c_EstDisp.Refresh
2418:                 ENDIF
2419:             ENDIF
2420:         CATCH TO loc_oErro
2421:             MsgErro("Erro em EstDispC6LostFocus: " + loc_oErro.Message, "Erro")
2422:         ENDTRY
2423:     ENDPROC
2424: 
2425:     *--------------------------------------------------------------------------
2426:     * ColC3Click - Handler Click na coluna 3 - navega para Page2 (detalhes)
2427:     *--------------------------------------------------------------------------
2428:     PROCEDURE ColC3Click

*-- Linhas 2468 a 2488:
2468:                 ENDIF
2469: 
2470:                 IF USED("CrSigCdPac")
2471:                     SELECT Cpros, Dpros, Cunis, Qtdes, CodPros, ;
2472:                         SPACE(14) AS Cpro2s ;
2473:                         FROM CrSigCdPac ;
2474:                         WHERE CodPros = m.loc_cCpro ;
2475:                         INTO CURSOR SelPedra ORDER BY Cpros READWRITE
2476: 
2477:                     IF RECCOUNT("SelPedra") > 0
2478:                         IF PEMSTATUS(THIS.pgf_4c_1.Page6, "grd_4c_GradePedra", 5)
2479:                             THIS.pgf_4c_1.Page6.grd_4c_GradePedra.RecordSource = "SelPedra"
2480:                         ENDIF
2481:                         IF PEMSTATUS(THIS.pgf_4c_1.Page6, "txt_4c_Cpros", 5)
2482:                             THIS.pgf_4c_1.Page6.txt_4c_Cpros.Value = loc_cCpro
2483:                         ENDIF
2484:                         THIS.AlternarPagina(6)
2485:                         loc_lResultado = .T.
2486:                     ELSE
2487:                         MsgAviso("Nenhuma requisi" + CHR(231) + CHR(227) + ;
2488:                             "o de material para este produto.")

*-- Linhas 2519 a 2539:
2519:                     USE IN TmpDisp
2520:                 ENDIF
2521: 
2522:                 SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
2523:                     0.000 AS Utilizar ;
2524:                     FROM TmpSaldG ;
2525:                     WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND ;
2526:                     CodTams = m.loc_cTam AND Disps > 0 ;
2527:                     INTO CURSOR TmpDisp ORDER BY Priors, Grupos, Estos, Cpros READWRITE
2528: 
2529:                 IF RECCOUNT("TmpDisp") > 0
2530:                     IF PEMSTATUS(THIS.pgf_4c_1.Page4, "txt_4c_Cpros", 5)
2531:                         THIS.pgf_4c_1.Page4.txt_4c_Cpros.Value = loc_cCpro + ;
2532:                             IIF(!EMPTY(loc_cCor), " Cor:" + loc_cCor, "") + ;
2533:                             IIF(!EMPTY(loc_cTam), " Tam:" + loc_cTam, "")
2534:                     ENDIF
2535:                     IF PEMSTATUS(THIS.pgf_4c_1.Page4, "txt_4c_Qt_pedida", 5)
2536:                         THIS.pgf_4c_1.Page4.txt_4c_Qt_pedida.Value = TmpFinalg.Saldo
2537:                     ENDIF
2538:                     IF PEMSTATUS(THIS.pgf_4c_1.Page4, "txt_4c_Qt_Selec", 5)
2539:                         THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Value = 0

*-- Linhas 2581 a 2600:
2581:                     USE IN TmpDisp
2582:                 ENDIF
2583: 
2584:                 SELECT Cpros, CodCors, CodTams, Disps, 0.000 AS Utilizar ;
2585:                     FROM TmpSaldo ;
2586:                     WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND Disps > 0 ;
2587:                     INTO CURSOR TmpDisp ORDER BY CodTams READWRITE
2588: 
2589:                 IF RECCOUNT("TmpDisp") > 0
2590:                     IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Cpros", 5)
2591:                         THIS.pgf_4c_1.Page5.txt_4c_Cpros.Value = loc_cCpro + ;
2592:                             IIF(!EMPTY(loc_cCor), " Cor:" + loc_cCor, "")
2593:                     ENDIF
2594:                     IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Qt_pedida", 5)
2595:                         THIS.pgf_4c_1.Page5.txt_4c_Qt_pedida.Value = TmpFinalg.Saldo
2596:                     ENDIF
2597:                     IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Qt_Selec", 5)
2598:                         THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Value = 0
2599:                     ENDIF
2600:                     THIS.AlternarPagina(5)

*-- Linhas 2630 a 2655:
2630:                     ENDIF
2631:                 ENDIF
2632: 
2633:                 SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, ;
2634:                     SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs ;
2635:                     FROM TmpFinalg GROUP BY 1 ;
2636:                     UNION ALL ;
2637:                     SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, ;
2638:                     SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, ;
2639:                     SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs ;
2640:                     FROM TmpFinalg GROUP BY 1 ;
2641:                     INTO CURSOR TmpLinha ORDER BY 2, 1
2642: 
2643:                 THIS.AlternarPagina(3)
2644:                 loc_lResultado = .T.
2645:             ENDIF
2646:         CATCH TO loc_oErro
2647:             MsgErro("Erro ao calcular totais por linha: " + loc_oErro.Message, "Erro")
2648:         ENDTRY
2649:     ENDPROC
2650: 
2651:     *--------------------------------------------------------------------------
2652:     * BtnProcessarClick - Processa globalizacao via BO
2653:     *--------------------------------------------------------------------------
2654:     PROCEDURE BtnProcessarClick
2655: 

*-- Linhas 2748 a 2766:
2748: 
2749:                 IF USED("TmpFinal")
2750:                     loc_nOldRecno = IIF(RECCOUNT("TmpFinal") > 0, RECNO("TmpFinal"), 0)
2751:                     SELECT TmpFinal
2752:                     SET KEY TO (m.loc_cCpros)
2753:                     THIS.AtualizarTotaisPage2()
2754:                     IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpFinal")
2755:                         GO loc_nOldRecno IN TmpFinal
2756:                     ENDIF
2757:                 ENDIF
2758: 
2759:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_Tot_sEst", 5)
2760:                     THIS.pgf_4c_1.Page2.txt_4c_Tot_sEst.Value = THIS.this_nTotSEst
2761:                 ENDIF
2762:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_Tot_sPrc", 5)
2763:                     THIS.pgf_4c_1.Page2.txt_4c_Tot_sPrc.Value = THIS.this_nTotSPrc
2764:                 ENDIF
2765: 
2766:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "edt_4c_ObsItens", 5) AND USED("TmpFinal") AND !EOF("TmpFinal")

*-- Linhas 2781 a 2799:
2781:         TRY
2782:             IF USED("TmpFinal") AND RECCOUNT("TmpFinal") > 0
2783:                 loc_nOldRecno = RECNO("TmpFinal")
2784:                 SELECT TmpFinal
2785:                 loc_nSaldo    = 0
2786:                 loc_nEstoque  = 0
2787:                 loc_nProduzir = 0
2788:                 loc_nFabrs    = 0
2789:                 SUM Saldo, Estoque, Produzir, Fabrs ;
2790:                     TO loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs
2791:                 IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpFinal")
2792:                     GO loc_nOldRecno
2793:                 ENDIF
2794: 
2795:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_TotQtdP2", 5)
2796:                     THIS.pgf_4c_1.Page2.txt_4c_TotQtdP2.Value = loc_nSaldo
2797:                 ENDIF
2798:                 IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_TotEstP2", 5)
2799:                     THIS.pgf_4c_1.Page2.txt_4c_TotEstP2.Value = loc_nEstoque

*-- Linhas 2834 a 2853:
2834:                 ENDIF
2835: 
2836:                 IF !EMPTY(loc_cCpros) AND gnConnHandle > 0
2837:                     loc_cSQL = "SELECT TOP 1 Fotos FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros)
2838:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FotoP2")
2839:                     IF loc_nRes > 0 AND USED("cursor_4c_FotoP2") AND !EOF("cursor_4c_FotoP2")
2840:                         IF !EMPTY(cursor_4c_FotoP2.Fotos) AND PEMSTATUS(THIS.pgf_4c_1.Page2, "img_4c_ImgFigJpg", 5)
2841:                             THIS.pgf_4c_1.Page2.img_4c_ImgFigJpg.PictureVal = STRCONV(cursor_4c_FotoP2.Fotos, 14)
2842:                         ENDIF
2843:                         USE IN cursor_4c_FotoP2
2844:                     ENDIF
2845:                 ENDIF
2846:             ENDIF
2847:         CATCH TO loc_oErro
2848:             MsgErro("Erro em P2GradeAfterRowColChange: " + loc_oErro.Message, "Erro")
2849:         ENDTRY
2850:     ENDPROC
2851: 
2852:     *--------------------------------------------------------------------------
2853:     * P2ColGotFocusToCol7 - Redireciona foco para coluna Estoque (Col7)

*-- Linhas 3019 a 3037:
3019:         TRY
3020:             IF USED("TmpFinal") AND USED("TmpFinalg") AND !EOF("TmpFinalg")
3021:                 loc_nOldRecno = IIF(RECCOUNT("TmpFinal") > 0, RECNO("TmpFinal"), 0)
3022:                 SELECT TmpFinal
3023:                 loc_nSumEst   = 0
3024:                 loc_nSumFabrs = 0
3025:                 SUM Estoque, Fabrs TO loc_nSumEst, loc_nSumFabrs
3026:                 IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpFinal")
3027:                     GO loc_nOldRecno IN TmpFinal
3028:                 ENDIF
3029: 
3030:                 IF loc_nSumEst != TmpFinalg.Estoque OR loc_nSumFabrs != TmpFinalg.Fabrs
3031:                     MsgAviso("Os totais de estoque/produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o conferem com o item selecionado.")
3032:                     RETURN
3033:                 ENDIF
3034:             ENDIF
3035: 
3036:             THIS.AlternarPagina(1)
3037:             THIS.AtualizarTotaisPage1()

*-- Linhas 3091 a 3109:
3091:                         loc_nPSaldo = TmpFinalg.Saldo - TmpFinalg.Estoque - TmpFinalg.Fabrs
3092: 
3093:                         loc_nOldRecno = IIF(RECCOUNT("TmpDisp") > 0, RECNO("TmpDisp"), 0)
3094:                         SELECT TmpDisp
3095:                         loc_nSumUtil = 0
3096:                         SUM Utilizar TO loc_nSumUtil
3097:                         IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpDisp")
3098:                             GO loc_nOldRecno
3099:                         ENDIF
3100: 
3101:                         loc_nSumUtil = loc_nSumUtil - TmpDisp.Utilizar + loc_nUtil
3102: 
3103:                         IF loc_nSumUtil > loc_nPSaldo
3104:                             MsgAviso("Total selecionado excede o saldo a produzir.")
3105:                             THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5.Text1.Value = 0
3106:                             loc_lResultado = .F.
3107:                         ELSE
3108:                             REPLACE TmpDisp.Utilizar WITH loc_nUtil
3109:                             IF PEMSTATUS(THIS.pgf_4c_1.Page4, "txt_4c_Qt_Selec", 5)

*-- Linhas 3150 a 3210:
3150:                     loc_cCpros = ALLTRIM(TmpFinalg.Cpros)
3151:                 ENDIF
3152: 
3153:                 SELECT TmpDisp
3154:                 SCAN FOR TmpDisp.Utilizar > 0
3155:                     loc_nUtil   = TmpDisp.Utilizar
3156:                     loc_cCpros  = ALLTRIM(TmpDisp.Grupos)
3157: 
3158:                     IF USED("TmpFinalg")
3159:                         SELECT TmpFinalg
3160:                         LOCATE FOR ALLTRIM(TmpFinalg.Cpros) = m.loc_cCpros
3161:                         IF FOUND()
3162:                             REPLACE TmpFinalg.Produzir   WITH TmpFinalg.Produzir - loc_nUtil
3163:                             REPLACE TmpFinalg.Estoque    WITH TmpFinalg.Estoque  + loc_nUtil
3164: 
3165:                             loc_nQtdMin = 0
3166:                             IF TYPE("TmpFinalg.QtdMins") != "U"
3167:                                 loc_nQtdMin = TmpFinalg.QtdMins
3168:                             ENDIF
3169:                             IF loc_nQtdMin > 0
3170:                                 REPLACE TmpFinalg.Produzir2 WITH IIF(TmpFinalg.Produzir >= loc_nQtdMin, ;
3171:                                     TmpFinalg.Produzir, 0)
3172:                             ELSE
3173:                                 REPLACE TmpFinalg.Produzir2 WITH TmpFinalg.Produzir
3174:                             ENDIF
3175:                         ENDIF
3176:                     ENDIF
3177: 
3178:                     IF USED("TmpSaldo")
3179:                         SELECT TmpSaldo
3180:                         LOCATE FOR ALLTRIM(TmpSaldo.Grupos) = m.loc_cCpros
3181:                         IF FOUND()
3182:                             REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nUtil
3183:                         ENDIF
3184:                     ENDIF
3185: 
3186:                     IF USED("TmpSaldG")
3187:                         SELECT TmpSaldG
3188:                         LOCATE FOR ALLTRIM(TmpSaldG.Grupos) = m.loc_cCpros
3189:                         IF FOUND()
3190:                             REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nUtil
3191:                         ENDIF
3192:                     ENDIF
3193: 
3194:                     IF USED("TmpSaldU")
3195:                         SELECT TmpSaldU
3196:                         LOCATE FOR ALLTRIM(TmpSaldU.Cpros) = m.loc_cCpros
3197:                         IF FOUND()
3198:                             REPLACE TmpSaldU.KeySelm WITH .T.
3199:                         ENDIF
3200:                     ENDIF
3201:                 ENDSCAN
3202: 
3203:                 USE IN TmpDisp
3204:             ENDIF
3205: 
3206:             THIS.AlternarPagina(1)
3207:             THIS.AtualizarTotaisPage1()
3208: 
3209:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3210:                 THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh()

*-- Linhas 3256 a 3274:
3256:                         ENDIF
3257: 
3258:                         loc_nOldRecno = IIF(RECCOUNT("TmpDisp") > 0, RECNO("TmpDisp"), 0)
3259:                         SELECT TmpDisp
3260:                         loc_nSumUtil = 0
3261:                         SUM Utilizar TO loc_nSumUtil
3262:                         IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpDisp")
3263:                             GO loc_nOldRecno
3264:                         ENDIF
3265: 
3266:                         loc_nSumUtil = loc_nSumUtil - TmpDisp.Utilizar + loc_nUtil
3267: 
3268:                         IF loc_nSumUtil > loc_nPSaldo
3269:                             MsgAviso("Total selecionado excede o pedido.")
3270:                             THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.Column5.Text1.Value = 0
3271:                             loc_lResultado = .F.
3272:                         ELSE
3273:                             REPLACE TmpDisp.Utilizar WITH loc_nUtil
3274:                             IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Qt_Selec", 5)

*-- Linhas 3294 a 3327:
3294: 
3295:         TRY
3296:             IF USED("TmpDisp")
3297:                 SELECT TmpDisp
3298:                 SCAN FOR TmpDisp.Utilizar > 0
3299:                     loc_nUtil  = TmpDisp.Utilizar
3300:                     loc_cGrupo = ALLTRIM(TmpDisp.Cpros)
3301: 
3302:                     IF USED("TmpFinalg")
3303:                         SELECT TmpFinalg
3304:                         LOCATE FOR ALLTRIM(TmpFinalg.Cpros) = m.loc_cGrupo
3305:                         IF FOUND()
3306:                             REPLACE TmpFinalg.Produzir WITH TmpFinalg.Produzir - loc_nUtil
3307:                             REPLACE TmpFinalg.Estoque  WITH TmpFinalg.Estoque  + loc_nUtil
3308:                         ENDIF
3309:                     ENDIF
3310: 
3311:                     IF USED("TmpSaldo")
3312:                         SELECT TmpSaldo
3313:                         LOCATE FOR ALLTRIM(TmpSaldo.Grupos) = m.loc_cGrupo
3314:                         IF FOUND()
3315:                             REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nUtil
3316:                         ENDIF
3317:                     ENDIF
3318:                 ENDSCAN
3319: 
3320:                 USE IN TmpDisp
3321:             ENDIF
3322: 
3323:             THIS.AlternarPagina(1)
3324:             THIS.AtualizarTotaisPage1()
3325: 
3326:             IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3327:                 THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh()

*-- Linhas 3344 a 3363:
3344:                 loc_cCpros = ALLTRIM(THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column1.Text1.Value)
3345: 
3346:                 IF !EMPTY(loc_cCpros)
3347:                     loc_cSQL = "SELECT TOP 1 Dpros, Cunis FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros)
3348:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProP6")
3349: 
3350:                     IF loc_nRes > 0 AND USED("cursor_4c_ProP6") AND !EOF("cursor_4c_ProP6")
3351:                         REPLACE SelPedra.Cpros WITH loc_cCpros
3352:                         REPLACE SelPedra.Dpros WITH ALLTRIM(cursor_4c_ProP6.Dpros)
3353:                         REPLACE SelPedra.Cunis WITH ALLTRIM(cursor_4c_ProP6.Cunis)
3354:                         USE IN cursor_4c_ProP6
3355:                     ELSE
3356:                         IF USED("cursor_4c_ProP6")
3357:                             USE IN cursor_4c_ProP6
3358:                         ENDIF
3359:                         THIS.AbrirLookupProdutoP6Col1(loc_cCpros)
3360:                         loc_lResultado = USED("SelPedra") AND !EOF("SelPedra") AND !EMPTY(ALLTRIM(SelPedra.Cpros))
3361:                     ENDIF
3362:                 ENDIF
3363:             ENDIF

*-- Linhas 3434 a 3453:
3434:                 loc_cCpro2 = ALLTRIM(THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column5.Text1.Value)
3435: 
3436:                 IF !EMPTY(loc_cCpro2)
3437:                     loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpro2)
3438:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pro2P6")
3439: 
3440:                     IF loc_nRes > 0 AND USED("cursor_4c_Pro2P6") AND !EOF("cursor_4c_Pro2P6")
3441:                         REPLACE SelPedra.Cpro2s WITH loc_cCpro2
3442:                         USE IN cursor_4c_Pro2P6
3443:                     ELSE
3444:                         IF USED("cursor_4c_Pro2P6")
3445:                             USE IN cursor_4c_Pro2P6
3446:                         ENDIF
3447:                         THIS.AbrirLookupProdutoP6Col5(loc_cCpro2)
3448:                         loc_lResultado = USED("SelPedra") AND !EOF("SelPedra") AND !EMPTY(ALLTRIM(SelPedra.Cpro2s))
3449:                     ENDIF
3450:                 ENDIF
3451:             ENDIF
3452:         CATCH TO loc_oErro
3453:             MsgErro("Erro em P6ColC5Valid: " + loc_oErro.Message, "Erro")

*-- Linhas 3508 a 3527:
3508:                 USE IN crLkpPro6C1
3509: 
3510:                 IF USED("SelPedra") AND !EOF("SelPedra") AND !EMPTY(loc_cCpros)
3511:                     loc_cSQL = "SELECT TOP 1 DPros, Cunis FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros)
3512:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "crLkpPro6C1Det")
3513: 
3514:                     IF loc_nRes > 0 AND USED("crLkpPro6C1Det") AND !EOF("crLkpPro6C1Det")
3515:                         REPLACE SelPedra.Cpros WITH loc_cCpros
3516:                         REPLACE SelPedra.Dpros WITH ALLTRIM(crLkpPro6C1Det.DPros)
3517:                         REPLACE SelPedra.Cunis WITH ALLTRIM(crLkpPro6C1Det.Cunis)
3518:                         USE IN crLkpPro6C1Det
3519:                     ELSE
3520:                         IF USED("crLkpPro6C1Det")
3521:                             USE IN crLkpPro6C1Det
3522:                         ENDIF
3523:                     ENDIF
3524: 
3525:                     IF PEMSTATUS(THIS.pgf_4c_1.Page6, "grd_4c_GradePedra", 5)
3526:                         THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Refresh()
3527:                     ENDIF

*-- Linhas 3722 a 3740:
3722:                 loc_cTam      = ALLTRIM(TmpFinalg.CodTams)
3723:                 loc_nSaldoTotal = TmpFinalg.Saldo
3724: 
3725:                 SELECT TmpFinalg
3726:                 REPLACE Estoque WITH 0, Fabrs WITH 0, Produzir WITH loc_nSaldoTotal, ;
3727:                     Produzir2 WITH 0, UsuLibs WITH " " IN TmpFinalg
3728: 
3729:                 IF USED("TmpSaldo")
3730:                     IF SEEK(loc_cCpro + loc_cCor + loc_cTam, "TmpSaldo")
3731:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Saldo IN TmpSaldo
3732:                     ENDIF
3733:                 ENDIF
3734: 
3735:                 THIS.AtualizarTotaisPage1()
3736:                 IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
3737:                     THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh
3738:                 ENDIF
3739:             ENDIF
3740:         CATCH TO loc_oErro

*-- Linhas 3785 a 3826:
3785:                 loc_nPrc   = 0
3786:                 loc_nPrze  = 0
3787: 
3788:                 SELECT TmpFinalg
3789:                 SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 ;
3790:                     TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
3791: 
3792:                 IF loc_nRecno > 0 AND RECCOUNT("TmpFinalg") >= loc_nRecno
3793:                     GO loc_nRecno IN TmpFinalg
3794:                 ENDIF
3795: 
3796:                 THIS.this_oBusinessObject.this_nTotQtd  = loc_nSal
3797:                 THIS.this_oBusinessObject.this_nTotEst  = loc_nEst
3798:                 THIS.this_oBusinessObject.this_nTotPrz  = loc_nPrz
3799:                 THIS.this_oBusinessObject.this_nTotPrdc = loc_nPrc
3800:                 THIS.this_oBusinessObject.this_nTotPrze = loc_nPrze
3801:             ENDIF
3802: 
3803:             IF USED("TmpFinal") AND RECCOUNT("TmpFinal") > 0
3804:                 loc_nRecno = IIF(!BOF("TmpFinal") AND !EOF("TmpFinal"), RECNO("TmpFinal"), 0)
3805: 
3806:                 loc_nSal2  = 0
3807:                 loc_nEst2  = 0
3808:                 loc_nPrz2  = 0
3809:                 loc_nPrc2  = 0
3810: 
3811:                 SELECT TmpFinal
3812:                 SUM Saldo, Estoque, Produzir, Fabrs ;
3813:                     TO loc_nSal2, loc_nEst2, loc_nPrz2, loc_nPrc2
3814: 
3815:                 IF loc_nRecno > 0 AND RECCOUNT("TmpFinal") >= loc_nRecno
3816:                     GO loc_nRecno IN TmpFinal
3817:                 ENDIF
3818: 
3819:                 THIS.this_oBusinessObject.this_nTotQtdP2 = loc_nSal2
3820:                 THIS.this_oBusinessObject.this_nTotEstP2 = loc_nEst2
3821:                 THIS.this_oBusinessObject.this_nTotPrzP2 = loc_nPrz2
3822:                 THIS.this_oBusinessObject.this_nTotPrcP2 = loc_nPrc2
3823:             ENDIF
3824:         CATCH TO loc_oErro
3825:             MsgErro("Erro em FormParaBO: " + loc_oErro.Message, "Erro")
3826:         ENDTRY


### BO (C:\4c\projeto\app\classes\SigPrGlxBO.prg):
*=============================================================================*
* SigPrGlxBO.prg - Business Object para Previa da Globalizacao
*=============================================================================*
* Herda de: BusinessBase
* Form associado: FormSigPrGlx.prg (forms\operacionais\)
* Descricao: Gerencia a previa da globalizacao de producao.
*            Opera sobre cursores temporarios passados pelo form pai
*            (TmpFinalg, TmpFinal, TmpSaldG, TmpFabr, TmpSaldU)
*            alem de cursores SQL criados em tempo de execucao.
*            Nao possui tabela SQL Server propria (opera em varias tabelas).
*=============================================================================*

DEFINE CLASS SigPrGlxBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Parametros recebidos do form pai via Init/ConfigurarParametros
    *--------------------------------------------------------------------------

    *-- Indica modo reserva automatica (nao produz OP, apenas reserva estoque)
    this_lReserva           = .F.

    *-- Indica modo de processamento automatico (sem confirmacao manual)
    this_lAutomatico        = .F.

    *-- Indica se o destino das OPs segue o destino do movimento origem
    this_lPorDestino        = .F.

    *-- Numero de emphasis (empresa) padrao para geracao de OP
    this_nEmphPdr           = 0

    *-- Numero da OP pre-definida (quando GlobAutos = 2 no parametro)
    this_nNumerodaop        = 0

    *-- Data de referencia para processamento (data da globalizacao)
    this_dData              = {}

    *-- Chave de assinatura unica para rastreio de registros gerados
    this_cSigKey            = ""

    *--------------------------------------------------------------------------
    * Controle de edicao inline nos grids de itens (Page1 e Page2)
    *--------------------------------------------------------------------------

    *-- Valor anterior antes de edicao em Column7/Column10 do GradeItens
    this_nOldValue          = 0

    *-- Valor anterior antes de edicao em Column5 do GradePedra (Page6)
    this_nAntValue          = 0

    *-- Flag de liberacao para edicao de coluna normalmente bloqueada (Column8)
    this_lLiberado          = .F.

    *--------------------------------------------------------------------------
    * Controle de exibicao e estado de botoes da UI
    *--------------------------------------------------------------------------

    *-- Controla visibilidade do botao Pedras (requisicao manual de material)
    this_lPedrasVisiveis    = .F.

    *-- Controla visibilidade do botao Disponivel
    this_lDisponivelVisivel = .F.

    *-- Controla visibilidade do botao SelEstoque (selecionar estoque por grupo)
    this_lSelEstoqueVisivel = .F.

    *--------------------------------------------------------------------------
    * Acumuladores de totais da pagina principal (Page1 - GradeItens)
    *--------------------------------------------------------------------------

    *-- Total de quantidade / saldo (coluna Saldo do TmpFinalg)
    this_nTotQtd            = 0

    *-- Total de estoque (coluna Estoque do TmpFinalg)
    this_nTotEst            = 0

    *-- Total a produzir / prazo (coluna Produzir do TmpFinalg)
    this_nTotPrz            = 0

    *-- Total de producao / fabrico (coluna Fabrs do TmpFinalg)
    this_nTotPrdc           = 0

    *-- Total de producao para estoque (coluna Produzir2 do TmpFinalg)
    this_nTotPrze           = 0

    *--------------------------------------------------------------------------
    * Acumuladores de totais da pagina de operacoes detalhadas (Page2)
    *--------------------------------------------------------------------------

    *-- Total de quantidade (Page2 - TmpFinal)
    this_nTotQtdP2          = 0

    *-- Total de estoque (Page2 - TmpFinal)
    this_nTotEstP2          = 0

    *-- Total a produzir (Page2 - TmpFinal)
    this_nTotPrzP2          = 0

    *-- Total de producao (Page2 - TmpFinal.Fabrs)
    this_nTotPrcP2          = 0

    *-- Quantidade selecionada de estoque para a referencia corrente (Tot_sEst)
    this_nTotSEst           = 0

    *-- Quantidade selecionada de producao para a referencia corrente (Tot_sPrc)
    this_nTotSPrc           = 0

    *--------------------------------------------------------------------------
    * Permissoes de acesso
    *--------------------------------------------------------------------------

    *-- Indica se usuario tem permissao para alterar prioridade (SIGPRGLO/PRIORIDADE)
    this_lPermitePrioridade = .F.

    *--------------------------------------------------------------------------
    * INIT - Inicializa BO sem tabela SQL propria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le totais acumulados do cursor de itens
    *--------------------------------------------------------------------------
    * Para forms OPERACIONAIS este BO nao mapeia registro-a-registro:
    * recebe o alias do cursor de itens (TmpFinalg para Page1, TmpFinal para
    * Page2) e calcula os totais para exibir nos textboxes Tot_Qtd/Est/Prz/etc.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_nRecno, loc_nSaldo, loc_nEstoque
        LOCAL loc_nProduzir, loc_nFabrs, loc_nProduzir2
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cAlias = IIF(EMPTY(par_cAliasCursor), "TmpFinalg", par_cAliasCursor)

            IF !USED(loc_cAlias)
                loc_lSucesso = .F.
            ELSE
                SELECT (loc_cAlias)
                loc_nRecno = IIF(RECCOUNT() > 0, RECNO(), 0)

                loc_nSaldo     = 0
                loc_nEstoque   = 0
                loc_nProduzir  = 0
                loc_nFabrs     = 0
                loc_nProduzir2 = 0

                IF RECCOUNT() > 0
                    SUM Saldo, Estoque, Produzir, Fabrs ;
                        TO loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs

                    IF TYPE(loc_cAlias + ".Produzir2") != "U"
                        SUM Produzir2 TO loc_nProduzir2
                    ENDIF

                    IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT()
                        GO loc_nRecno
                    ENDIF
                ENDIF

                IF UPPER(loc_cAlias) = "TMPFINAL"
                    THIS.this_nTotQtdP2  = loc_nSaldo
                    THIS.this_nTotEstP2  = loc_nEstoque
                    THIS.this_nTotPrzP2  = loc_nProduzir
                    THIS.this_nTotPrcP2  = loc_nFabrs
                ELSE
                    THIS.this_nTotQtd  = loc_nSaldo
                    THIS.this_nTotEst  = loc_nEstoque
                    THIS.this_nTotPrz  = loc_nProduzir
                    THIS.this_nTotPrdc = loc_nFabrs
                    THIS.this_nTotPrze = loc_nProduzir2
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar totais do cursor: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave de rastreio da execucao (SigKey unica)
    *--------------------------------------------------------------------------
    * Cada execucao da previa gera uma SigKey por fGerUniqueKey no legado.
    * Enquanto o form nao a define, retorna string vazia. Usada para vincular
    * registros gerados (SigOpPic/SigCdNei/SigMvCab) na fase Processar.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cSigKey)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Registra execucao da globalizacao em LogAuditoria
    *--------------------------------------------------------------------------
    * OPERACIONAL: nao existe INSERT em tabela unica. O metodo delega para
    * RegistrarAuditoria com operacao "GLOBALIZACAO" (ou "RESERVA_AUTO"),
    * marcando que a previa foi confirmada. As gravacoes reais dos registros
    * (SigMvCab/SigOpPic/SigCdNei) ocorrem na fase Processar do form.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cOperacao

        loc_lSucesso = .F.

        TRY
            loc_cOperacao = IIF(THIS.this_lReserva, ;
                "RESERVA_AUTO_GLOBALIZACAO", ;
                "PREVIA_GLOBALIZACAO")

            THIS.RegistrarAuditoria(loc_cOperacao)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao registrar globalizacao: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Registra reprocessamento em LogAuditoria
    *--------------------------------------------------------------------------
    * Chamado quando o usuario reexecuta o Processar apos ajustar quantidades
    * (edicoes em GradeItens Column7/Column10). Registra evento no log.
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.RegistrarAuditoria("REPROCESSAMENTO_GLOBALIZACAO")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao registrar reprocessamento: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Insere entrada na tabela LogAuditoria
    *--------------------------------------------------------------------------
    * Grava operacao no log para rastreabilidade. Usa GETDATE() literal
    * (nao GETDATE()) para DataHora conforme feedback #35.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_cModulo
        LOCAL loc_nResultado, loc_oErro

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                gc_4c_UsuarioLogado, "SISTEMA")
            loc_cModulo  = "SigPrGlx"

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Modulo, Operacao, ChavePrimaria, Usuario, DataHora, Detalhes) " + ;
                "VALUES (" + ;
                EscaparSQL(loc_cModulo) + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL("SigKey=" + loc_cChave + ;
                    "; Reserva=" + IIF(THIS.this_lReserva, "S", "N") + ;
                    "; Automatico=" + IIF(THIS.this_lAutomatico, "S", "N") + ;
                    "; PorDestino=" + IIF(THIS.this_lPorDestino, "S", "N") + ;
                    "; NumeroOP=" + TRANSFORM(THIS.this_nNumerodaop)) + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Falha ao gravar LogAuditoria para operacao " + ;
                    par_cOperacao, "Auditoria")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RegistrarAuditoria: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

