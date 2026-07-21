# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CAMPO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OPZERS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ESTOQUE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS

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
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  DeleteMark = .F.
  ControlSource = "TmpFinal.Obsps"
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
SELECT SelPedra
			.Column1.ControlSource = 'TmpFinal.Cpros'
			.Column2.ControlSource = 'TmpFinal.CodCors'
			.Column3.ControlSource = 'TmpFinal.Dopes'
			.Column4.ControlSource = 'TmpFinal.Numes'
			.Column5.ControlSource = 'TmpFinal.Saldo'
			.Column6.ControlSource = 'TmpFinal.Produzir'
			.Column7.ControlSource = 'TmpFinal.Estoque'
			.Column8.ControlSource = 'Iif(IsEmpty(TmpFinal.Obsps), "", "*")'
			.Column9.ControlSource = 'TmpFinal.CodTams'
		Select TmpSaldG
			.Column1.ControlSource = 'TmpSaldG.Grupos'
			.Column2.ControlSource = 'TmpSaldG.Estos'
			.Column3.ControlSource = 'TmpSaldG.Saldo'
			.Column4.ControlSource = 'TmpSaldG.Saldo - TmpSaldg.Disps'
			.Column5.ControlSource = 'TmpSaldg.Disps'
			.Column6.ControlSource = 'TmpSaldg.Emps'
		lcQuery = [Select a.Tipos, a.Custos, b.CGrus ] + ;
				    [From SigCdTpc a, SigCdCom b ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdCom]) < 1)
		Select crSigCdCom
		Select TmpFinal
Select TmpFinal
Select TmpDisp
	Select TmpDisp
		=Seek( TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, 'TmpSaldo' )
		Select TmpFinal
		Select TmpSaldo
		If Not Seek(TmpFinal.Cpros,'TmpSaldU','Cpros')
			Insert into TmpSaldU (Cpros ) Values (TmpFinal.Cpros)
		Select TmpSaldG
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + Str(TmpDisp.Priors,2) + TmpDisp.Grupos + TmpDisp.Estos)
	=Seek( TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, 'TmpSaldo' )
Select TmpFinal
Select TmpDisp
	Select TmpFinal
	Create Cursor Temporario From Array TFinal
	Select TmpDisp
		=Seek(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, 'TmpSaldo')
		Select TmpFinal
		Select Temporario
		Append From Array Memvar
		Select TmpSaldG
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
		lcQuery = [Select * ] + ;
				    [From SigMvIts ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEsti2') < 1)
		Select TempEsti2
				lcQuery = [Update SigMvIts ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
					=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - 9)')
				Select crSigMvIts
				Append From Array Memvar
					Delete
	Select TmpFinal
		Delete
	Select TmpFinal
	Append From Dbf('Temporario')
	=Seek(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, 'TmpSaldo')
	SELECT SelPedra
=Seek( TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, 'TmpSaldo' )
Select TmpSaldG
Select TmpFinal
Select TmpFinal
If Not Seek(TmpFinal.Cpros,'TmpSaldU','Cpros')
	Insert into TmpSaldU (Cpros ) Values (TmpFinal.Cpros)
	Case Not Seek(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, 'TmpSaldo') And ;
			Select TmpSaldo
			Select TmpSaldG
			=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
			=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
Select TmpFinal
Select Cpros, CodCors, CodTams, Disps, 000000000.000 as Utilizar ;
  From TmpSaldo ;
			.Column1.ControlSource = 'Tmpdisp.Cpros'
			.Column2.ControlSource = 'Tmpdisp.CodCors'
			.Column3.ControlSource = 'Tmpdisp.CodTams'
			.Column4.ControlSource = 'Tmpdisp.Disps'
			.Column5.ControlSource = 'Tmpdisp.Utilizar'
Select Linhas, 0 as Ordem, Sum(Saldo) as Saldo, Sum(Estoque) as Estoque, Sum(Produzir) as Produzir ;
  From TmpFinal ;
Select Padr('TOTAIS',10) as Linhas, 1 as Ordem, Sum(Saldo) as Saldo, Sum(Estoque) as Estoque, Sum(Produzir) as Produzir ;
  from TmpFinal ;
	.Column1.ControlSource = 'TmpLinha.Linhas'
	.Column2.ControlSource = 'TmpLinha.Saldo'
	.Column3.ControlSource = 'TmpLinha.Estoque'
	.Column4.ControlSource = 'TmpLinha.Produzir'
	.Column1.ControlSource = 'SelPedra.Cpros'
	.Column2.ControlSource = 'SelPedra.Dpros'
	.Column3.ControlSource = 'SelPedra.Cunis'
	.Column4.ControlSource = 'SelPedra.Qtds'
	.Column5.ControlSource = 'SelPedra.Cpro2s'
Select Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, 000000000.000 AS  Utilizar;
From TmpSaldG Where Cpros = lcCpro And CodCors = lcCor And CodTams = lcTam And Disps > 0;
Select 0
			.Column1.ControlSource = 'Tmpdisp.Grupos'
			.Column2.ControlSource = 'Tmpdisp.Estos'
			.Column3.ControlSource = 'Tmpdisp.Priors'
			.Column4.ControlSource = 'Tmpdisp.Disps'
			.Column5.ControlSource = 'Tmpdisp.Utilizar'
Select crSigOpPic
Select crSigPdMvf
Select crSigCdNec
Select crSigMvCab
Select crSigMvHst
Select crSigBxEst
Select crSigMvItn
Select crSigMvIts
Select CrSigCdNei
Select * From CrSigCdNei Where 0=1 Into Cursor GrSigCdNei ReadWrite
Select crSigCdPam
	lcSql = [Select Numps From SigOpPic Where Numps = ]+Str(_Nump)
	If (ThisForm.poDataMgr.SqlExecute(lcSql, 'TmpOpi') < 1)
Select crTplMvIts
Select crTpmMvItn
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
Select TmpSaldg
Select TmpFinal
		Select TmpSaldG
		=Seek(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams)
				Insert Into TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, Grupos, Estos, Estoque, EmpDs ) Values ;
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
	llFalse = .f. && Tiago - 07/07/2015 - Incluído na select para buscar apenas as movimentações que não foram baixadas, pois é desnecessário checar o que foi baixado e estava muito lento
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
		If Seek(pEstoque.Cpros + pEstoque.Grupos + pEstoque.Estos ,'TmpPedra','MatGruCon') && Tiago - 17/02/2012 - Vianna - Ao checar se tinha estoque, não estava olhando o grupo e conta configurado no grupo de produtos, com isso não gerava requisição corretamente
	Select TmpEmpH
			Insert Into crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, ;
		Insert Into crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, Citens, cPro2s, Pesos, cUnips ) ;
	Select TmpPedra
			lcQuery = [select Isnull(SUM(qtds),0) - Isnull(SUM(qtbaixas),0) as Qtds from SigMvItn where empdopnums in( ] + ;
						[select empdopnums from SigMvCab where empdopnums in( ] + ;
						[SELECT distinct EmpDopNums FROM SigBxEst ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'pQtdsReq') < 1)
	Select TmpPedra
			Select TmpMatPrz
			Select crSigMvCab
				Select Max(Citens) as Citens from crTpmMvItn Where Emps = _Empr And Dopes = _Dope And Numes = _Nume Into Cursor TmpUltItn
				Insert Into crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, Contaos, ;
			Insert Into crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, Citens, Pesos, cUniPs ) ;
Select crTpmMvItn
	Insert Into crSigMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, Citens, ;
Select crTplMvIts
	Insert Into crSigMvIts(cItens, Emps, Dopes, Numes, CPros, Qtds, CodCors, CodTams, CidChaves, EmpDopNums, QtdEmbs) ;
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
Select Min(Datas) as Datas From CrSigMvCab Into Cursor TmpGdm
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
	Select CrSigMvHst
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
Select Cpros, Space(50) as DPros, CodCors, CodTams, Dopes, Numes, ;
  From TmpFinal ;
	Select Distinct Cpros From crImpressao Into Cursor LocalProds
	Select LocalProds
		lcQuery = [Select CPros, DPros ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)
		Select LocalBus
			Update crImpressao Set DPros = LocalBus.DPros Where CPros = LocalBus.CPros
	Select crImpressao

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2856 linhas total):

*-- Linhas 85 a 147:
85:                     .this_nEmphPdr    = THIS.this_nEmphPdr
86:                     .this_dData       = THIS.this_dData
87:                     IF USED("CrSigCdPac")
88:                         SELECT CrSigCdPac
89:                         .this_cSigKey = TratarNulo(CrSigCdPac.sigKeys, "C")
90:                     ENDIF
91:                 ENDWITH
92: 
93:                 IF THIS.this_lReserva
94:                     THIS.Caption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
95:                 ELSE
96:                     THIS.Caption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
97:                 ENDIF
98: 
99:                 THIS.ConfigurarPageFrame()
100:                 THIS.ConfigurarCabecalho()
101:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
102:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
103: 
104:                 THIS.this_oBusinessObject.InicializarConexaoTemp()
105:                 THIS.this_oBusinessObject.CarregarParametros()
106:                 THIS.this_oBusinessObject.CarregarComposicao()
107:                 THIS.this_oBusinessObject.InicializarTmpSaldU()
108: 
109:                 IF USED("SelPedra")
110:                     SELECT SelPedra
111:                     IF RECCOUNT() = 0
112:                         APPEND BLANK
113:                     ENDIF
114:                 ENDIF
115: 
116:                 THIS.ConfigurarLayout()
117:                 THIS.CarregarDados()
118:                 THIS.TornarControlesVisiveis()
119: 
120:                 *-- Estado inicial do botao Pedras
121:                 THIS.cmd_4c_Pedras.Enabled = .F.
122:                 IF USED("crSigCdPam")
123:                     SELECT crSigCdPam
124:                     IF !EMPTY(crSigCdPam.DopEmphs) AND !EMPTY(crSigCdPam.DopReqcs) AND ;
125:                        !EMPTY(crSigCdPam.DopPedcs) AND !EMPTY(crSigCdPam.DopComps) AND ;
126:                        !THIS.this_lReserva
127:                         THIS.cmd_4c_Pedras.Enabled = .T.
128:                     ENDIF
129:                 ENDIF
130: 
131:                 IF USED("TmpFinal")
132:                     SELECT TmpFinal
133:                     SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
134:                     GO TOP
135:                     THIS.txt_4c_Tot_Qtd.Value = loc_nSal
136:                     THIS.txt_4c_Tot_Est.Value = loc_nEst
137:                     THIS.txt_4c_Tot_Prz.Value = loc_nPrz
138:                 ENDIF
139: 
140:                 THIS.Refresh
141:                 loc_lSucesso = .T.
142:             ENDIF
143:         CATCH TO loc_oErro
144:             MsgErro("Erro ao inicializar FormSigPrGlp: " + loc_oErro.Message + ;
145:                     " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
146:                     " Proc=" + loc_oErro.Procedure, "Erro")
147:         ENDTRY

*-- Linhas 390 a 408:
390:             .ColumnCount      = 9
391:             .AllowHeaderSizing = .F.
392:             .AllowRowSizing    = .F.
393:             .DeleteMark        = .F.
394:             .RecordMark        = .F.
395:             .ScrollBars        = 3
396:             .RowHeight         = 16
397:             .GridLineColor     = RGB(238, 238, 238)
398:             .FontName          = "Tahoma"
399:             .FontSize          = 8
400:             *-- Col1: Produto
401:             WITH .Column1
402:                 .Width          = 80
403:                 .ReadOnly       = .T.
404:                 .Movable        = .F.
405:                 .Resizable      = .F.
406:                 .Header1.Caption = "Produto"
407:                 .Header1.FontName = "Verdana"
408:                 .Header1.FontSize = 8

*-- Linhas 635 a 653:
635:                 .ColumnCount      = 6
636:                 .AllowHeaderSizing = .F.
637:                 .AllowRowSizing    = .F.
638:                 .DeleteMark        = .F.
639:                 .RecordMark        = .F.
640:                 .ScrollBars        = 2
641:                 .RowHeight         = 16
642:                 .GridLineColor     = RGB(238, 238, 238)
643:                 .FontSize          = 8
644:                 WITH .Column1
645:                     .Width = 70
646:                     .ReadOnly = .T.
647:                     .Header1.Caption = "Grupo"
648:                     .Header1.FontName = "Verdana"
649:                     .Header1.FontSize = 8
650:                     .Header1.ForeColor = RGB(36, 84, 155)
651:                 ENDWITH
652:                 WITH .Column2
653:                     .Width = 70

*-- Linhas 829 a 847:
829:                 .ColumnCount = 4
830:                 .AllowHeaderSizing = .F.
831:                 .AllowRowSizing = .F.
832:                 .DeleteMark = .F.
833:                 .RecordMark = .F.
834:                 .ScrollBars = 2
835:                 .RowHeight = 16
836:                 .FontSize = 8
837:                 WITH .Column1
838:                     .Width = 80
839:                     .ReadOnly = .T.
840:                     .Header1.Caption = "Linha"
841:                     .Header1.FontName = "Verdana"
842:                     .Header1.FontSize = 8
843:                     .Header1.ForeColor = RGB(36, 84, 155)
844:                 ENDWITH
845:                 WITH .Column2
846:                     .Width = 80
847:                     .ReadOnly = .T.

*-- Linhas 922 a 940:
922:                 .ColumnCount = 5
923:                 .AllowHeaderSizing = .F.
924:                 .AllowRowSizing = .F.
925:                 .DeleteMark = .F.
926:                 .RecordMark = .F.
927:                 .ScrollBars = 2
928:                 .RowHeight = 16
929:                 .FontSize = 8
930:                 WITH .Column1
931:                     .Width = 80
932:                     .ReadOnly = .T.
933:                     .Header1.Caption = "Produto"
934:                     .Header1.FontName = "Verdana"
935:                     .Header1.FontSize = 8
936:                     .Header1.ForeColor = RGB(36, 84, 155)
937:                 ENDWITH
938:                 WITH .Column2
939:                     .Width = 38
940:                     .ReadOnly = .T.

*-- Linhas 1084 a 1102:
1084:                 .ColumnCount = 5
1085:                 .AllowHeaderSizing = .F.
1086:                 .AllowRowSizing = .F.
1087:                 .DeleteMark = .F.
1088:                 .RecordMark = .F.
1089:                 .ScrollBars = 3
1090:                 .RowHeight = 16
1091:                 .FontSize = 8
1092:                 WITH .Column1
1093:                     .Width = 80
1094:                     .ReadOnly = .F.
1095:                     .Header1.Caption = "Produto"
1096:                     .Header1.FontName = "Verdana"
1097:                     .Header1.FontSize = 8
1098:                     .Header1.ForeColor = RGB(36, 84, 155)
1099:                 ENDWITH
1100:                 WITH .Column2
1101:                     .Width = 200
1102:                     .ReadOnly = .T.

*-- Linhas 1189 a 1207:
1189:                 .ColumnCount = 5
1190:                 .AllowHeaderSizing = .F.
1191:                 .AllowRowSizing = .F.
1192:                 .DeleteMark = .F.
1193:                 .RecordMark = .F.
1194:                 .ScrollBars = 2
1195:                 .RowHeight = 16
1196:                 .FontSize = 8
1197:                 WITH .Column1
1198:                     .Width = 80
1199:                     .ReadOnly = .T.
1200:                     .Header1.Caption = "Grupo"
1201:                     .Header1.FontName = "Verdana"
1202:                     .Header1.FontSize = 8
1203:                     .Header1.ForeColor = RGB(36, 84, 155)
1204:                 ENDWITH
1205:                 WITH .Column2
1206:                     .Width = 80
1207:                     .ReadOnly = .T.

*-- Linhas 1414 a 1432:
1414:         *-- Botao Pedras/SelEstoque respeitam regra de negocio
1415:         loc_lPodeAcao = .F.
1416:         IF USED("crSigCdPam")
1417:             SELECT crSigCdPam
1418:             loc_lPodeAcao = !EMPTY(crSigCdPam.DopEmphs) AND !EMPTY(crSigCdPam.DopReqcs) AND ;
1419:                             !EMPTY(crSigCdPam.DopPedcs) AND !EMPTY(crSigCdPam.DopComps) AND ;
1420:                             !THIS.this_lReserva
1421:         ENDIF
1422:         THIS.cmd_4c_Pedras.Enabled     = loc_lPodeAcao
1423:         THIS.cmd_4c_SelEstoque.Enabled = loc_lPodeAcao
1424: 
1425:         *-- Focar grid principal na coluna editavel Produzir
1426:         IF THIS.grd_4c_Dados.Enabled
1427:             THIS.grd_4c_Dados.Refresh
1428:             THIS.grd_4c_Dados.Column6.SetFocus
1429:         ENDIF
1430:     ENDPROC
1431: 
1432:     *==========================================================================

*-- Linhas 1451 a 1482:
1451:         ENDIF
1452: 
1453:         *-- Reposicionar TmpSaldG conforme item corrente do grid principal
1454:         SELECT TmpSaldG
1455:         SET ORDER TO Cpros
1456:         SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1457:         GO TOP
1458: 
1459:         *-- Vincular Container3 grid ao cursor de saldo detalhado
1460:         THIS.cnt_4c_Container3.grd_4c_Dados.RecordSource = "TmpSaldG"
1461:         WITH THIS.cnt_4c_Container3.grd_4c_Dados
1462:             .Column1.ControlSource = "TmpSaldG.Grupos"
1463:             .Column2.ControlSource = "TmpSaldG.Estos"
1464:             .Column3.ControlSource = "TmpSaldG.Saldo"
1465:             .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
1466:             .Column5.ControlSource = "TmpSaldG.Disps"
1467:             .Column6.ControlSource = "TmpSaldG.Emps"
1468:             .SetAll("ReadOnly", .T.)
1469:             .Refresh
1470:         ENDWITH
1471: 
1472:         *-- Descricoes grupo/conta (buscadas via CursorQuery no AfterRowColChange)
1473:         IF USED("TmpGrupo")
1474:             THIS.cnt_4c_Container3.txt_4c__dgrupo.Value = TratarNulo(TmpGrupo.Descrs, "C")
1475:         ENDIF
1476:         IF USED("TmpConta")
1477:             THIS.cnt_4c_Container3.txt_4c__dconta.Value = TratarNulo(TmpConta.RClis, "C")
1478:         ENDIF
1479: 
1480:         *-- Totais do item corrente (Saldo/Estoque/Produzir do TmpSaldo)
1481:         IF USED("TmpSaldo") AND SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
1482:             loc_nSaldo    = NVL(TmpSaldo.Saldo, 0)

*-- Linhas 1488 a 1506:
1488:         THIS.cnt_4c_Container3.txt_4c_Tot_Prz.Value = loc_nProduzir
1489: 
1490:         *-- Rebind da EditBox de observacao ao item corrente
1491:         THIS.obj_4c_ObsItens.ControlSource = "TmpFinal.Obsps"
1492:         THIS.obj_4c_ObsItens.Refresh
1493: 
1494:         *-- Rotulo dinamico da observacao
1495:         THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ;
1496:                                             ALLTRIM(TratarNulo(TmpFinal.Cpros, "C"))
1497:     ENDPROC
1498: 
1499:     *==========================================================================
1500:     * AlternarPagina - Alterna entre a visao principal e os overlays
1501:     *
1502:     * Parametros: par_nPagina
1503:     *   0 -> visao principal (grid + Container3) - via ConfigurarPaginaLista()
1504:     *   1 -> Container1 (Totais por Linha) - equivalente a BtnTotLinhaClick
1505:     *   2 -> Container2 (Disponibilidade)  - equivalente a BtnDisponiveiClick
1506:     *   3 -> Container3 permanece ativo (saldo por grupo/conta) - restaura lista

*-- Linhas 1535 a 1597:
1535:         IF USED("TmpFinal")
1536:             THIS.grd_4c_Dados.RecordSource = "TmpFinal"
1537:             WITH THIS.grd_4c_Dados
1538:                 .Column1.ControlSource = "TmpFinal.Cpros"
1539:                 .Column2.ControlSource = "TmpFinal.CodCors"
1540:                 .Column3.ControlSource = "TmpFinal.Dopes"
1541:                 .Column4.ControlSource = "TmpFinal.Numes"
1542:                 .Column5.ControlSource = "TmpFinal.Saldo"
1543:                 .Column6.ControlSource = "TmpFinal.Produzir"
1544:                 .Column7.ControlSource = "TmpFinal.Estoque"
1545:                 .Column8.ControlSource = "IIF(EMPTY(TmpFinal.Obsps), ' ', '*')"
1546:                 .Column9.ControlSource = "TmpFinal.CodTams"
1547:             ENDWITH
1548: 
1549:             *-- Se nao ha operacao de transferencia, grid fica somente leitura
1550:             IF USED("crSigCdPam")
1551:                 SELECT crSigCdPam
1552:                 IF EMPTY(crSigCdPam.TransfRes)
1553:                     THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
1554:                 ENDIF
1555:             ENDIF
1556:         ENDIF
1557: 
1558:         *-- Container3: Grid saldo por grupo/conta (TmpSaldG)
1559:         IF USED("TmpSaldG") AND USED("TmpFinal")
1560:             SELECT TmpSaldG
1561:             SET ORDER TO Cpros
1562:             GO TOP
1563:             IF !EOF("TmpFinal")
1564:                 SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1565:             ENDIF
1566:             GO TOP
1567: 
1568:             THIS.cnt_4c_Container3.grd_4c_Dados.RecordSource = "TmpSaldG"
1569:             WITH THIS.cnt_4c_Container3.grd_4c_Dados
1570:                 .Column1.ControlSource = "TmpSaldG.Grupos"
1571:                 .Column2.ControlSource = "TmpSaldG.Estos"
1572:                 .Column3.ControlSource = "TmpSaldG.Saldo"
1573:                 .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
1574:                 .Column5.ControlSource = "TmpSaldG.Disps"
1575:                 .Column6.ControlSource = "TmpSaldG.Emps"
1576:                 .SetAll("ReadOnly", .T.)
1577:             ENDWITH
1578:         ENDIF
1579: 
1580:         *-- ObsItens: vincula ao campo de observacao do item corrente
1581:         IF USED("TmpFinal")
1582:             THIS.obj_4c_ObsItens.ControlSource = "TmpFinal.Obsps"
1583:         ENDIF
1584:     ENDPROC
1585: 
1586:     *==========================================================================
1587:     PROTECTED PROCEDURE TornarControlesVisiveis
1588:     *==========================================================================
1589:         LOCAL loc_nI, loc_oCtrl
1590:         FOR loc_nI = 1 TO THIS.ControlCount
1591:             loc_oCtrl = THIS.Controls(loc_nI)
1592:             *-- Overlays ocultos: manter Visible=.F., mas tornar sub-controles visiveis
1593:             IF INLIST(loc_oCtrl.Name, ;
1594:                       "cnt_4c_Container1", ;
1595:                       "cnt_4c_Container2", ;
1596:                       "cnt_4c_Container4", ;
1597:                       "cnt_4c_Container5", ;

*-- Linhas 1661 a 1697:
1661:                     USE IN TmpDisp
1662:                 ENDIF
1663: 
1664:                 SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
1665:                   FROM TmpSaldo ;
1666:                  WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND Disps > 0 ;
1667:                  ORDER BY Cpros, CodCors, CodTams ;
1668:                   INTO CURSOR TmpDisp READWRITE
1669: 
1670:                 THIS.grd_4c_Dados.Enabled = .F.
1671: 
1672:                 IF _Tally = 0
1673:                     MsgAviso("N" + CHR(227) + "o Existe Estoque Dispon" + CHR(237) + "vel Em Nenhum Tamanho!!!", "")
1674:                     THIS.BtnCancelaDisp2Click()
1675:                 ELSE
1676:                     THIS.cnt_4c_Container2.grd_4c_Dados.RecordSource = "TmpDisp"
1677:                     WITH THIS.cnt_4c_Container2.grd_4c_Dados
1678:                         .Column1.ControlSource = "TmpDisp.Cpros"
1679:                         .Column2.ControlSource = "TmpDisp.CodCors"
1680:                         .Column3.ControlSource = "TmpDisp.CodTams"
1681:                         .Column4.ControlSource = "TmpDisp.Disps"
1682:                         .Column5.ControlSource = "TmpDisp.Utilizar"
1683:                     ENDWITH
1684: 
1685:                     WITH THIS.cnt_4c_Container2
1686:                         .txt_4c_Qt_pedida.Value = TmpFinal.Saldo
1687:                         .txt_4c_Qt_Selec.Value  = 0
1688:                         .Visible     = .T.
1689:                     ENDWITH
1690: 
1691:                     THIS.cmd_4c_Processar.Enabled  = .F.
1692:                     THIS.cmd_4c_Cancelar.Enabled   = .F.
1693:                     THIS.cmd_4c_TotLinha.Enabled   = .F.
1694:                     THIS.cmd_4c_Pedras.Enabled     = .F.
1695:                     THIS.cmd_4c_Disponivel.Enabled = .F.
1696:                     THIS.cnt_4c_Container3.Enabled = .F.
1697:                     THIS.cnt_4c_Container2.Visible = .T.

*-- Linhas 1712 a 1745:
1712:                 USE IN TmpLinha
1713:             ENDIF
1714: 
1715:             SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
1716:               FROM TmpFinal ;
1717:              GROUP BY 1 ;
1718:              UNION ALL ;
1719:             SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
1720:               FROM TmpFinal ;
1721:              GROUP BY 1 ;
1722:               INTO CURSOR TmpLinha ;
1723:              ORDER BY 2, 1
1724: 
1725:             THIS.cnt_4c_Container1.grd_4c_Dados.RecordSource = "TmpLinha"
1726:             WITH THIS.cnt_4c_Container1.grd_4c_Dados
1727:                 .Column1.ControlSource = "TmpLinha.Linhas"
1728:                 .Column2.ControlSource = "TmpLinha.Saldo"
1729:                 .Column3.ControlSource = "TmpLinha.Estoque"
1730:                 .Column4.ControlSource = "TmpLinha.Produzir"
1731:                 .SetAll("DynamicFontBold",  "TmpLinha.Linhas = [TOTAIS]", "Column")
1732:                 .SetAll("DynamicForeColor", "IIF(TmpLinha.Linhas = [TOTAIS], RGB(0,0,255), RGB(0,0,0))", "Column")
1733:             ENDWITH
1734: 
1735:             THIS.cmd_4c_Processar.Enabled  = .F.
1736:             THIS.cmd_4c_Cancelar.Enabled   = .F.
1737:             THIS.cmd_4c_TotLinha.Enabled   = .F.
1738:             THIS.cmd_4c_Pedras.Enabled     = .F.
1739:             THIS.cmd_4c_Disponivel.Enabled = .F.
1740:             THIS.grd_4c_Dados.Enabled      = .F.
1741:             THIS.cnt_4c_Container3.Enabled = .F.
1742:             THIS.cnt_4c_Container1.Visible = .T.
1743:             THIS.cnt_4c_Container1.ZOrder
1744:             THIS.cnt_4c_Container1.grd_4c_Dados.Refresh
1745:             THIS.cnt_4c_Container1.grd_4c_Dados.Column1.SetFocus

*-- Linhas 1756 a 1778:
1756: 
1757:             THIS.cnt_4c_Container4.grd_4c_Dados.RecordSource = "SelPedra"
1758:             WITH THIS.cnt_4c_Container4.grd_4c_Dados
1759:                 .Column1.ControlSource = "SelPedra.Cpros"
1760:                 .Column2.ControlSource = "SelPedra.Dpros"
1761:                 .Column3.ControlSource = "SelPedra.Cunis"
1762:                 .Column4.ControlSource = "SelPedra.Qtds"
1763:                 .Column5.ControlSource = "SelPedra.Cpro2s"
1764:             ENDWITH
1765: 
1766:             THIS.cmd_4c_Processar.Enabled  = .F.
1767:             THIS.cmd_4c_Cancelar.Enabled   = .F.
1768:             THIS.cmd_4c_TotLinha.Enabled   = .F.
1769:             THIS.cmd_4c_Pedras.Enabled     = .F.
1770:             THIS.cmd_4c_Disponivel.Enabled = .F.
1771:             THIS.grd_4c_Dados.Enabled      = .F.
1772:             THIS.cnt_4c_Container3.Enabled = .F.
1773:             THIS.cnt_4c_Container4.Visible = .T.
1774:             THIS.cnt_4c_Container4.ZOrder
1775:             THIS.cnt_4c_Container4.grd_4c_Dados.Refresh
1776:             THIS.cnt_4c_Container4.grd_4c_Dados.Column1.SetFocus
1777:         CATCH TO loc_oErro
1778:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 1793 a 1832:
1793:                     USE IN TmpDisp
1794:                 ENDIF
1795: 
1796:                 SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
1797:                        000000000.000 AS Utilizar ;
1798:                   FROM TmpSaldG ;
1799:                  WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND CodTams = m.loc_cTam AND Disps > 0 ;
1800:                   INTO CURSOR Resultado ORDER BY 1, 2, 3, 4
1801:                 SELECT 0
1802:                 USE DBF("Resultado") ALIAS TmpDisp AGAIN
1803:                 USE IN Resultado
1804: 
1805:                 THIS.grd_4c_Dados.Enabled = .F.
1806: 
1807:                 IF _Tally = 0
1808:                     MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "")
1809:                     THIS.BtnCancelaDisp5Click()
1810:                 ELSE
1811:                     THIS.cnt_4c_Container5.grd_4c_Dados.RecordSource = "TmpDisp"
1812:                     WITH THIS.cnt_4c_Container5.grd_4c_Dados
1813:                         .Column1.ControlSource = "TmpDisp.Grupos"
1814:                         .Column2.ControlSource = "TmpDisp.Estos"
1815:                         .Column3.ControlSource = "TmpDisp.Priors"
1816:                         .Column4.ControlSource = "TmpDisp.Disps"
1817:                         .Column5.ControlSource = "TmpDisp.Utilizar"
1818:                     ENDWITH
1819: 
1820:                     WITH THIS.cnt_4c_Container5
1821:                         .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel (" + ;
1822:                                                  ALLTRIM(loc_cCpro) + " " + ALLTRIM(loc_cCor) + ;
1823:                                                  "/" + ALLTRIM(loc_cTam) + ")"
1824:                         .txt_4c_Qt_pedida.Value = TmpFinal.Saldo - TmpFinal.Estoque
1825:                         .txt_4c_Qt_Selec.Value  = 0
1826:                         .Visible     = .T.
1827:                     ENDWITH
1828: 
1829:                     THIS.cmd_4c_Processar.Enabled  = .F.
1830:                     THIS.cmd_4c_Cancelar.Enabled   = .F.
1831:                     THIS.cmd_4c_TotLinha.Enabled   = .F.
1832:                     THIS.cmd_4c_Disponivel.Enabled = .F.

*-- Linhas 1933 a 1979:
1933: 
1934:         TRY
1935:             IF USED("TmpDisp") AND USED("TmpFinal")
1936:                 SELECT TmpDisp
1937:                 SUM Utilizar TO loc_nQtdUtil
1938: 
1939:                 IF loc_nQtdUtil > 0
1940:                     SELECT TmpDisp
1941:                     SCAN
1942:                         IF Utilizar = 0
1943:                             LOOP
1944:                         ENDIF
1945:                         loc_nQtUtil = Utilizar
1946:                         =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, "TmpSaldo")
1947:                         SELECT TmpFinal
1948:                         REPLACE Produzir WITH TmpFinal.Produzir - m.loc_nQtUtil
1949:                         REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir
1950: 
1951:                         SELECT TmpSaldo
1952:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - m.loc_nQtUtil
1953: 
1954:                         IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
1955:                             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
1956:                         ENDIF
1957:                         REPLACE KeySelm WITH .T. IN TmpSaldU
1958: 
1959:                         SELECT TmpSaldG
1960:                         SET ORDER TO Cpros
1961:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
1962:                         REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_nQtUtil
1963: 
1964:                         SELECT TmpDisp
1965:                     ENDSCAN
1966:                     =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
1967:                 ENDIF
1968:                 loc_lSucesso = .T.
1969:             ENDIF
1970:         CATCH TO loc_oErro
1971:             MsgErro(loc_oErro.Message, "Erro")
1972:         ENDTRY
1973: 
1974:         WITH THIS
1975:             .cmd_4c_Processar.Enabled  = .T.
1976:             .cmd_4c_Cancelar.Enabled   = .T.
1977:             .cmd_4c_TotLinha.Enabled   = .T.
1978:             .cmd_4c_SelEstoque.Enabled = .T.
1979:             .cmd_4c_Pedras.Enabled     = .T.

*-- Linhas 2008 a 2055:
2008: 
2009:         TRY
2010:             IF USED("TmpDisp") AND USED("TmpFinal")
2011:                 SELECT TmpDisp
2012:                 SUM Utilizar TO loc_nQtdUtil
2013: 
2014:                 IF loc_nQtdUtil > 0
2015:                     SELECT TmpDisp
2016:                     SCAN
2017:                         IF Utilizar = 0
2018:                             LOOP
2019:                         ENDIF
2020:                         loc_nQtUtil = Utilizar
2021:                         =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2022: 
2023:                         SELECT TmpFinal
2024:                         REPLACE Produzir WITH TmpFinal.Produzir - m.loc_nQtUtil
2025:                         REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir
2026: 
2027:                         SELECT TmpSaldo
2028:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - m.loc_nQtUtil
2029: 
2030:                         IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
2031:                             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
2032:                         ENDIF
2033:                         REPLACE KeySelm WITH .T. IN TmpSaldU
2034: 
2035:                         SELECT TmpSaldG
2036:                         SET ORDER TO Cpros
2037:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + STR(TmpDisp.Priors, 2) + TmpDisp.Grupos + TmpDisp.Estos)
2038:                         REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_nQtUtil
2039: 
2040:                         SELECT TmpDisp
2041:                     ENDSCAN
2042:                     =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2043:                 ENDIF
2044:             ENDIF
2045:         CATCH TO loc_oErro
2046:             MsgErro(loc_oErro.Message, "Erro")
2047:         ENDTRY
2048: 
2049:         WITH THIS
2050:             .cmd_4c_Processar.Enabled  = .T.
2051:             .cmd_4c_Cancelar.Enabled   = .T.
2052:             .cmd_4c_TotLinha.Enabled   = .T.
2053:             .cmd_4c_Disponivel.Enabled = .T.
2054:             .cmd_4c_SelEstoque.Enabled = .T.
2055:             .cmd_4c_Pedras.Enabled     = .T.

*-- Linhas 2080 a 2162:
2080: 
2081:             =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2082: 
2083:             SELECT TmpSaldG
2084:             SET ORDER TO Cpros
2085:             SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
2086:             GO TOP
2087: 
2088:             WITH THIS.cnt_4c_Container3
2089:                 IF USED("TmpSaldo") AND !EOF("TmpSaldo")
2090:                     .txt_4c_Tot_Qtd.Value = TmpSaldo.Saldo
2091:                     .txt_4c_Tot_Est.Value = TmpSaldo.Saldo - TmpSaldo.Disps
2092:                     .txt_4c_Tot_Prz.Value = TmpSaldo.Disps
2093:                 ENDIF
2094: 
2095:                 .lbl_4c_Label1.Caption = ALLTRIM(TmpFinal.Cpros) + ;
2096:                     IIF(!EMPTY(TmpFinal.CodCors), " Cor:" + TmpFinal.CodCors, "") + ;
2097:                     IIF(!EMPTY(TmpFinal.CodTams), " Tam:" + TmpFinal.CodTams, "")
2098: 
2099:                 .grd_4c_Dados.Refresh
2100:                 .Visible     = .T.
2101:             ENDWITH
2102: 
2103:             *-- Foto do produto
2104:             loc_cSQL = "SELECT TOP 1 FigJpgs FROM SigCdPro WHERE CPros = '" + ;
2105:                        ALLTRIM(TmpFinal.CPros) + "'"
2106:             IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpProFig") > 0
2107:                 CLEAR RESOURCES
2108:                 THIS.img_4c_ImgFigJpg.Picture = ""
2109:                 THIS.img_4c_ImgFigJpg.Visible = .F.
2110: 
2111:                 IF !EMPTY(xTmpProFig.FigJpgs) AND !ISNULL(xTmpProFig.FigJpgs)
2112:                     loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(xTmpProFig.FigJpgs, ;
2113:                                      "data:image/png;base64,", ""), ;
2114:                                      "data:image/jpeg;base64,", ""), ;
2115:                                      "data:image/jpg;base64,", ""), 14)
2116:                     loc_lcArquivo = SYS(2023) + "\TempGlb.jpg"
2117:                     IF STRTOFILE(loc_lcFoto, loc_lcArquivo) > 0
2118:                         THIS.img_4c_ImgFigJpg.Picture = loc_lcArquivo
2119:                         THIS.img_4c_ImgFigJpg.Visible = .T.
2120:                     ENDIF
2121:                 ENDIF
2122:                 IF USED("xTmpProFig")
2123:                     USE IN xTmpProFig
2124:                 ENDIF
2125:             ENDIF
2126: 
2127:             SELECT TmpFinal
2128:         CATCH TO loc_oErro
2129:             MsgErro(loc_oErro.Message, "Erro")
2130:         ENDTRY
2131:     ENDPROC
2132: 
2133:     PROCEDURE GrdCol6TextWhen
2134:         LOCAL loc_lPermite
2135:         loc_lPermite = .T.
2136: 
2137:         TRY
2138:             IF USED("TmpFinal")
2139:                 THIS.this_nOldValue = THIS.grd_4c_Dados.Column6.Text1.Value
2140: 
2141:                 IF THIS.this_lReserva AND TmpFinal.Estoque = 0
2142:                     loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdPro WHERE CPros = '" + ;
2143:                                ALLTRIM(TmpFinal.CPros) + "'"
2144:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempPro") > 0
2145:                         loc_cSQL = "SELECT TOP 1 TipoEstos FROM SigCdGrp WHERE CGrus = '" + ;
2146:                                    ALLTRIM(xTempPro.CGrus) + "'"
2147:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempGru") > 0
2148:                             IF INLIST(xTempGru.TipoEstos, 3, 4)
2149:                                 THIS.cmd_4c_Disponivel.Enabled = .T.
2150:                             ENDIF
2151:                             IF USED("xTempGru")
2152:                                 USE IN xTempGru
2153:                             ENDIF
2154:                         ENDIF
2155:                         IF USED("xTempPro")
2156:                             USE IN xTempPro
2157:                         ENDIF
2158:                     ENDIF
2159:                 ENDIF
2160:             ENDIF
2161:         CATCH TO loc_oErro
2162:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 2178 a 2196:
2178:             ENDIF
2179: 
2180:             IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
2181:                 INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
2182:             ENDIF
2183: 
2184:             IF loc_nNewValue <> loc_nOld AND TmpSaldU.KeySelm
2185:                 IF MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque. " + ;
2186:                                CHR(13) + "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", "")
2187:                     *-- Continue
2188:                 ELSE
2189:                     THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
2190:                     loc_lValido = .F.
2191:                 ENDIF
2192:             ENDIF
2193: 
2194:             IF loc_lValido
2195:                 DO CASE
2196:                     CASE loc_nNewValue = loc_nOld

*-- Linhas 2211 a 2231:
2211:                             REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - loc_nNewValue IN TmpFinal
2212:                             REPLACE KeySelm WITH .F. IN TmpSaldU
2213: 
2214:                             SELECT TmpSaldo
2215:                             loc_xBaixa = Saldo - Disps
2216:                             SELECT TmpSaldG
2217:                             SET ORDER TO Cpros
2218:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
2219:                             REPLACE Disps WITH Saldo WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams
2220:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
2221:                             SCAN WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams AND m.loc_xBaixa > 0
2222:                                 IF TmpSaldG.Disps >= m.loc_xBaixa
2223:                                     REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_xBaixa
2224:                                     m.loc_xBaixa = 0
2225:                                 ELSE
2226:                                     m.loc_xBaixa = m.loc_xBaixa - TmpSaldG.Disps
2227:                                     REPLACE TmpSaldG.Disps WITH 0
2228:                                 ENDIF
2229:                             ENDSCAN
2230:                         ELSE
2231:                             MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")

*-- Linhas 2246 a 2264:
2246: 
2247:         TRY
2248:             IF USED("TmpFinal")
2249:                 SELECT TmpFinal
2250:                 loc_nRecno = RECNO()
2251:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2252:                 GO loc_nRecno
2253:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2254:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2255:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2256:                 THIS.txt_4c_Tot_Qtd.Refresh
2257:                 THIS.txt_4c_Tot_Est.Refresh
2258:                 THIS.txt_4c_Tot_Prz.Refresh
2259:                 THIS.Refresh
2260:             ENDIF
2261:         CATCH TO loc_oErro
2262:             MsgErro(loc_oErro.Message, "Erro")
2263:         ENDTRY
2264:     ENDPROC

*-- Linhas 2357 a 2377:
2357:         TRY
2358:             loc_cVal = ALLTRIM(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
2359:             IF !EMPTY(loc_cVal)
2360:                 loc_cSQL = "SELECT TOP 1 CPros, DPros, Cunis FROM SigCdPro WHERE CPros = '" + ;
2361:                            EscaparSQL(loc_cVal)
2362:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crListaRemota") > 0 AND RECCOUNT("crListaRemota") > 0
2363:                     THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value = crListaRemota.CPros
2364:                     REPLACE SelPedra.Dpros WITH crListaRemota.DPros, ;
2365:                             SelPedra.Cunis WITH crListaRemota.Cunis IN SelPedra
2366:                 ELSE
2367:                     *-- Abrir picker (FormBuscaAuxiliar)
2368:                     DO FormBuscaAuxiliar WITH gnConnHandle, "SigCdPro", "crListaRemota", "CPros", ;
2369:                                              loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", 1000, ;
2370:                                              "CPros", "DPros"
2371:                     IF USED("crListaRemota") AND RECCOUNT("crListaRemota") > 0
2372:                         THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value = crListaRemota.CPros
2373:                         REPLACE SelPedra.Dpros WITH crListaRemota.DPros, ;
2374:                                 SelPedra.Cunis WITH crListaRemota.Cunis IN SelPedra
2375:                     ENDIF
2376:                 ENDIF
2377:                 IF USED("crListaRemota")

*-- Linhas 2425 a 2445:
2425:         TRY
2426:             loc_cVal = ALLTRIM(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value)
2427:             IF !EMPTY(loc_cVal)
2428:                 loc_cSQL = "SELECT TOP 1 CPros, DPros FROM SigCdPro WHERE CPros = " + ;
2429:                            EscaparSQL(loc_cVal)
2430:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crListaPro2") > 0 AND RECCOUNT("crListaPro2") > 0
2431:                     THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = crListaPro2.CPros
2432:                     REPLACE SelPedra.Cpro2s WITH crListaPro2.CPros IN SelPedra
2433:                 ELSE
2434:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2435:                                              "crListaPro2", "CPros", loc_cVal, ;
2436:                                              "Produto Substituto")
2437:                     IF VARTYPE(loc_oBusca) = "O"
2438:                         loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2439:                         loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2440:                         loc_oBusca.Show()
2441:                         IF loc_oBusca.this_lSelecionou AND USED("crListaPro2") AND RECCOUNT("crListaPro2") > 0
2442:                             THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = crListaPro2.CPros
2443:                             REPLACE SelPedra.Cpro2s WITH crListaPro2.CPros IN SelPedra
2444:                         ELSE
2445:                             THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = ""

*-- Linhas 2546 a 2564:
2546: 
2547:         TRY
2548:             IF USED("TmpFinal")
2549:                 SELECT TmpFinal
2550:                 loc_nRecno = RECNO()
2551:                 loc_nSal = 0
2552:                 loc_nEst = 0
2553:                 loc_nPrz = 0
2554:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2555:                 IF loc_nRecno <= RECCOUNT("TmpFinal") AND loc_nRecno > 0
2556:                     GO loc_nRecno IN TmpFinal
2557:                 ENDIF
2558: 
2559:                 IF VARTYPE(THIS.txt_4c_Tot_Qtd) = "O"
2560:                     THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2561:                     THIS.txt_4c_Tot_Qtd.Refresh()
2562:                 ENDIF
2563:                 IF VARTYPE(THIS.txt_4c_Tot_Est) = "O"
2564:                     THIS.txt_4c_Tot_Est.Value = loc_nEst

*-- Linhas 2612 a 2630:
2612:                 loc_nSal = 0
2613:                 loc_nEst = 0
2614:                 loc_nPrz = 0
2615:                 SELECT TmpFinal
2616:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2617:                 GO TOP
2618:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2619:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2620:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2621:             ENDIF
2622:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
2623:                 THIS.grd_4c_Dados.Refresh()
2624:             ENDIF
2625:         CATCH TO loc_oErro
2626:             MsgErro(loc_oErro.Message, "Erro")
2627:         ENDTRY
2628:     ENDPROC
2629: 
2630:     *==========================================================================

*-- Linhas 2715 a 2733:
2715:             THIS.CarregarDados()
2716: 
2717:             IF USED("TmpFinal")
2718:                 SELECT TmpFinal
2719:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2720:                 GO TOP
2721:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2722:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2723:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2724:             ENDIF
2725: 
2726:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
2727:                 THIS.grd_4c_Dados.Refresh()
2728:             ENDIF
2729:             IF VARTYPE(THIS.cnt_4c_Container3) = "O"
2730:                 THIS.cnt_4c_Container3.Refresh()
2731:             ENDIF
2732:             THIS.Refresh()
2733:         CATCH TO loc_oErro

*-- Linhas 2751 a 2769:
2751:                 IF loc_lHab
2752:                     *-- Permitir edicao apenas se nao ha operacao TransfRes bloqueando
2753:                     IF USED("crSigCdPam")
2754:                         SELECT crSigCdPam
2755:                         IF EMPTY(crSigCdPam.TransfRes)
2756:                             THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
2757:                         ELSE
2758:                             THIS.grd_4c_Dados.Column6.ReadOnly = .F.
2759:                         ENDIF
2760:                     ELSE
2761:                         THIS.grd_4c_Dados.Column6.ReadOnly = .F.
2762:                     ENDIF
2763:                 ELSE
2764:                     THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
2765:                 ENDIF
2766:             ENDIF
2767: 
2768:             *-- Botoes de acao
2769:             THIS.AjustarBotoesPorModo()

*-- Linhas 2832 a 2850:
2832: 
2833:             *-- Verificar se operacao de pedras/selecao de estoque esta disponivel
2834:             IF loc_lTemDados AND USED("crSigCdPam")
2835:                 SELECT crSigCdPam
2836:                 loc_lPodeAcao = !EMPTY(crSigCdPam.DopEmphs) AND ;
2837:                                 !EMPTY(crSigCdPam.DopReqcs) AND ;
2838:                                 !EMPTY(crSigCdPam.DopPedcs) AND ;
2839:                                 !EMPTY(crSigCdPam.DopComps) AND ;
2840:                                 !THIS.this_lReserva
2841:             ENDIF
2842: 
2843:             *-- Aplicar estado aos botoes
2844:             THIS.cmd_4c_Processar.Enabled    = loc_lTemDados
2845:             THIS.cmd_4c_Cancelar.Enabled     = .T.
2846:             THIS.cmd_4c_TotLinha.Enabled     = loc_lTemDados
2847:             THIS.cmd_4c_Disponivel.Enabled   = loc_lTemDados
2848:             THIS.cmd_4c_BtnRelatorio.Enabled = loc_lTemDados
2849:             THIS.cmd_4c_Pedras.Enabled       = loc_lPodeAcao
2850:             THIS.cmd_4c_SelEstoque.Enabled   = loc_lPodeAcao

