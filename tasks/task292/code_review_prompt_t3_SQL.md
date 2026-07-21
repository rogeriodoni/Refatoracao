# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CAMPO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2848 linhas total):

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

*-- Linhas 391 a 409:
391:             .ColumnCount      = 9
392:             .AllowHeaderSizing = .F.
393:             .AllowRowSizing    = .F.
394:             .DeleteMark        = .F.
395:             .RecordMark        = .F.
396:             .ScrollBars        = 3
397:             .RowHeight         = 16
398:             .GridLineColor     = RGB(238, 238, 238)
399:             .FontName          = "Tahoma"
400:             .FontSize          = 8
401:             *-- Col1: Produto
402:             WITH .Column1
403:                 .Width          = 80
404:                 .ReadOnly       = .T.
405:                 .Movable        = .F.
406:                 .Resizable      = .F.
407:                 .Header1.Caption = "Produto"
408:                 .Header1.FontName = "Verdana"
409:                 .Header1.FontSize = 8

*-- Linhas 637 a 655:
637:                 .ColumnCount      = 6
638:                 .AllowHeaderSizing = .F.
639:                 .AllowRowSizing    = .F.
640:                 .DeleteMark        = .F.
641:                 .RecordMark        = .F.
642:                 .ScrollBars        = 2
643:                 .RowHeight         = 16
644:                 .GridLineColor     = RGB(238, 238, 238)
645:                 .FontSize          = 8
646:                 WITH .Column1
647:                     .Width = 70
648:                     .ReadOnly = .T.
649:                     .Header1.Caption = "Grupo"
650:                     .Header1.FontName = "Verdana"
651:                     .Header1.FontSize = 8
652:                     .Header1.ForeColor = RGB(36, 84, 155)
653:                 ENDWITH
654:                 WITH .Column2
655:                     .Width = 70

*-- Linhas 831 a 849:
831:                 .ColumnCount = 4
832:                 .AllowHeaderSizing = .F.
833:                 .AllowRowSizing = .F.
834:                 .DeleteMark = .F.
835:                 .RecordMark = .F.
836:                 .ScrollBars = 2
837:                 .RowHeight = 16
838:                 .FontSize = 8
839:                 WITH .Column1
840:                     .Width = 80
841:                     .ReadOnly = .T.
842:                     .Header1.Caption = "Linha"
843:                     .Header1.FontName = "Verdana"
844:                     .Header1.FontSize = 8
845:                     .Header1.ForeColor = RGB(36, 84, 155)
846:                 ENDWITH
847:                 WITH .Column2
848:                     .Width = 80
849:                     .ReadOnly = .T.

*-- Linhas 924 a 942:
924:                 .ColumnCount = 5
925:                 .AllowHeaderSizing = .F.
926:                 .AllowRowSizing = .F.
927:                 .DeleteMark = .F.
928:                 .RecordMark = .F.
929:                 .ScrollBars = 2
930:                 .RowHeight = 16
931:                 .FontSize = 8
932:                 WITH .Column1
933:                     .Width = 80
934:                     .ReadOnly = .T.
935:                     .Header1.Caption = "Produto"
936:                     .Header1.FontName = "Verdana"
937:                     .Header1.FontSize = 8
938:                     .Header1.ForeColor = RGB(36, 84, 155)
939:                 ENDWITH
940:                 WITH .Column2
941:                     .Width = 38
942:                     .ReadOnly = .T.

*-- Linhas 1086 a 1104:
1086:                 .ColumnCount = 5
1087:                 .AllowHeaderSizing = .F.
1088:                 .AllowRowSizing = .F.
1089:                 .DeleteMark = .F.
1090:                 .RecordMark = .F.
1091:                 .ScrollBars = 3
1092:                 .RowHeight = 16
1093:                 .FontSize = 8
1094:                 WITH .Column1
1095:                     .Width = 80
1096:                     .ReadOnly = .F.
1097:                     .Header1.Caption = "Produto"
1098:                     .Header1.FontName = "Verdana"
1099:                     .Header1.FontSize = 8
1100:                     .Header1.ForeColor = RGB(36, 84, 155)
1101:                 ENDWITH
1102:                 WITH .Column2
1103:                     .Width = 200
1104:                     .ReadOnly = .T.

*-- Linhas 1191 a 1209:
1191:                 .ColumnCount = 5
1192:                 .AllowHeaderSizing = .F.
1193:                 .AllowRowSizing = .F.
1194:                 .DeleteMark = .F.
1195:                 .RecordMark = .F.
1196:                 .ScrollBars = 2
1197:                 .RowHeight = 16
1198:                 .FontSize = 8
1199:                 WITH .Column1
1200:                     .Width = 80
1201:                     .ReadOnly = .T.
1202:                     .Header1.Caption = "Grupo"
1203:                     .Header1.FontName = "Verdana"
1204:                     .Header1.FontSize = 8
1205:                     .Header1.ForeColor = RGB(36, 84, 155)
1206:                 ENDWITH
1207:                 WITH .Column2
1208:                     .Width = 80
1209:                     .ReadOnly = .T.

*-- Linhas 1416 a 1434:
1416:         *-- Botao Pedras/SelEstoque respeitam regra de negocio
1417:         loc_lPodeAcao = .F.
1418:         IF USED("crSigCdPam")
1419:             SELECT crSigCdPam
1420:             loc_lPodeAcao = !EMPTY(crSigCdPam.DopEmphs) AND !EMPTY(crSigCdPam.DopReqcs) AND ;
1421:                             !EMPTY(crSigCdPam.DopPedcs) AND !EMPTY(crSigCdPam.DopComps) AND ;
1422:                             !THIS.this_lReserva
1423:         ENDIF
1424:         THIS.cmd_4c_Pedras.Enabled     = loc_lPodeAcao
1425:         THIS.cmd_4c_SelEstoque.Enabled = loc_lPodeAcao
1426: 
1427:         *-- Focar grid principal na coluna editavel Produzir
1428:         IF THIS.grd_4c_Dados.Enabled
1429:             THIS.grd_4c_Dados.Refresh
1430:             THIS.grd_4c_Dados.Column6.SetFocus
1431:         ENDIF
1432:     ENDPROC
1433: 
1434:     *==========================================================================

*-- Linhas 1453 a 1484:
1453:         ENDIF
1454: 
1455:         *-- Reposicionar TmpSaldG conforme item corrente do grid principal
1456:         SELECT TmpSaldG
1457:         SET ORDER TO Cpros
1458:         SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1459:         GO TOP
1460: 
1461:         *-- Vincular Container3 grid ao cursor de saldo detalhado
1462:         THIS.cnt_4c_Container3.grd_4c_Dados.RecordSource = "TmpSaldG"
1463:         WITH THIS.cnt_4c_Container3.grd_4c_Dados
1464:             .Column1.ControlSource = "TmpSaldG.Grupos"
1465:             .Column2.ControlSource = "TmpSaldG.Estos"
1466:             .Column3.ControlSource = "TmpSaldG.Saldo"
1467:             .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
1468:             .Column5.ControlSource = "TmpSaldG.Disps"
1469:             .Column6.ControlSource = "TmpSaldG.Emps"
1470:             .SetAll("ReadOnly", .T.)
1471:             .Refresh
1472:         ENDWITH
1473: 
1474:         *-- Descricoes grupo/conta (buscadas via CursorQuery no AfterRowColChange)
1475:         IF USED("TmpGrupo")
1476:             THIS.cnt_4c_Container3.txt_4c__dgrupo.Value = TratarNulo(TmpGrupo.Descrs, "C")
1477:         ENDIF
1478:         IF USED("TmpConta")
1479:             THIS.cnt_4c_Container3.txt_4c__dconta.Value = TratarNulo(TmpConta.RClis, "C")
1480:         ENDIF
1481: 
1482:         *-- Totais do item corrente (Saldo/Estoque/Produzir do TmpSaldo)
1483:         IF USED("TmpSaldo") AND SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
1484:             loc_nSaldo    = NVL(TmpSaldo.Saldo, 0)

*-- Linhas 1490 a 1508:
1490:         THIS.cnt_4c_Container3.txt_4c_Tot_Prz.Value = loc_nProduzir
1491: 
1492:         *-- Rebind da EditBox de observacao ao item corrente
1493:         THIS.obj_4c_ObsItens.ControlSource = "TmpFinal.Obsps"
1494:         THIS.obj_4c_ObsItens.Refresh
1495: 
1496:         *-- Rotulo dinamico da observacao
1497:         THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ;
1498:                                             ALLTRIM(TratarNulo(TmpFinal.Cpros, "C"))
1499:     ENDPROC
1500: 
1501:     *==========================================================================
1502:     * AlternarPagina - Alterna entre a visao principal e os overlays
1503:     *
1504:     * Parametros: par_nPagina
1505:     *   0 -> visao principal (grid + Container3) - via ConfigurarPaginaLista()
1506:     *   1 -> Container1 (Totais por Linha) - equivalente a BtnTotLinhaClick
1507:     *   2 -> Container2 (Disponibilidade)  - equivalente a BtnDisponiveiClick
1508:     *   3 -> Container3 permanece ativo (saldo por grupo/conta) - restaura lista

*-- Linhas 1537 a 1599:
1537:         IF USED("TmpFinal")
1538:             THIS.grd_4c_Dados.RecordSource = "TmpFinal"
1539:             WITH THIS.grd_4c_Dados
1540:                 .Column1.ControlSource = "TmpFinal.Cpros"
1541:                 .Column2.ControlSource = "TmpFinal.CodCors"
1542:                 .Column3.ControlSource = "TmpFinal.Dopes"
1543:                 .Column4.ControlSource = "TmpFinal.Numes"
1544:                 .Column5.ControlSource = "TmpFinal.Saldo"
1545:                 .Column6.ControlSource = "TmpFinal.Produzir"
1546:                 .Column7.ControlSource = "TmpFinal.Estoque"
1547:                 .Column8.ControlSource = "IIF(EMPTY(TmpFinal.Obsps), ' ', '*')"
1548:                 .Column9.ControlSource = "TmpFinal.CodTams"
1549:             ENDWITH
1550: 
1551:             *-- Se nao ha operacao de transferencia, grid fica somente leitura
1552:             IF USED("crSigCdPam")
1553:                 SELECT crSigCdPam
1554:                 IF EMPTY(crSigCdPam.TransfRes)
1555:                     THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
1556:                 ENDIF
1557:             ENDIF
1558:         ENDIF
1559: 
1560:         *-- Container3: Grid saldo por grupo/conta (TmpSaldG)
1561:         IF USED("TmpSaldG") AND USED("TmpFinal")
1562:             SELECT TmpSaldG
1563:             SET ORDER TO Cpros
1564:             GO TOP
1565:             IF !EOF("TmpFinal")
1566:                 SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1567:             ENDIF
1568:             GO TOP
1569: 
1570:             THIS.cnt_4c_Container3.grd_4c_Dados.RecordSource = "TmpSaldG"
1571:             WITH THIS.cnt_4c_Container3.grd_4c_Dados
1572:                 .Column1.ControlSource = "TmpSaldG.Grupos"
1573:                 .Column2.ControlSource = "TmpSaldG.Estos"
1574:                 .Column3.ControlSource = "TmpSaldG.Saldo"
1575:                 .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
1576:                 .Column5.ControlSource = "TmpSaldG.Disps"
1577:                 .Column6.ControlSource = "TmpSaldG.Emps"
1578:                 .SetAll("ReadOnly", .T.)
1579:             ENDWITH
1580:         ENDIF
1581: 
1582:         *-- ObsItens: vincula ao campo de observacao do item corrente
1583:         IF USED("TmpFinal")
1584:             THIS.obj_4c_ObsItens.ControlSource = "TmpFinal.Obsps"
1585:         ENDIF
1586:     ENDPROC
1587: 
1588:     *==========================================================================
1589:     PROTECTED PROCEDURE TornarControlesVisiveis
1590:     *==========================================================================
1591:         LOCAL loc_nI, loc_oCtrl
1592:         FOR loc_nI = 1 TO THIS.ControlCount
1593:             loc_oCtrl = THIS.Controls(loc_nI)
1594:             *-- Overlays ocultos (Visible=.F.): processar sub-controles mas manter container oculto
1595:             IF INLIST(UPPER(loc_oCtrl.Name), ;
1596:                       "CNT_4C_CONTAINER1", ;
1597:                       "CNT_4C_CONTAINER2", ;
1598:                       "CNT_4C_CONTAINER4", ;
1599:                       "CNT_4C_CONTAINER5", ;

*-- Linhas 1653 a 1689:
1653:                     USE IN TmpDisp
1654:                 ENDIF
1655: 
1656:                 SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
1657:                   FROM TmpSaldo ;
1658:                  WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND Disps > 0 ;
1659:                  ORDER BY Cpros, CodCors, CodTams ;
1660:                   INTO CURSOR TmpDisp READWRITE
1661: 
1662:                 THIS.grd_4c_Dados.Enabled = .F.
1663: 
1664:                 IF _Tally = 0
1665:                     MsgAviso("N" + CHR(227) + "o Existe Estoque Dispon" + CHR(237) + "vel Em Nenhum Tamanho!!!", "")
1666:                     THIS.BtnCancelaDisp2Click()
1667:                 ELSE
1668:                     THIS.cnt_4c_Container2.grd_4c_Dados.RecordSource = "TmpDisp"
1669:                     WITH THIS.cnt_4c_Container2.grd_4c_Dados
1670:                         .Column1.ControlSource = "TmpDisp.Cpros"
1671:                         .Column2.ControlSource = "TmpDisp.CodCors"
1672:                         .Column3.ControlSource = "TmpDisp.CodTams"
1673:                         .Column4.ControlSource = "TmpDisp.Disps"
1674:                         .Column5.ControlSource = "TmpDisp.Utilizar"
1675:                     ENDWITH
1676: 
1677:                     WITH THIS.cnt_4c_Container2
1678:                         .txt_4c_Qt_pedida.Value = TmpFinal.Saldo
1679:                         .txt_4c_Qt_Selec.Value  = 0
1680:                         .Visible     = .T.
1681:                     ENDWITH
1682: 
1683:                     THIS.cmd_4c_Processar.Enabled  = .F.
1684:                     THIS.cmd_4c_Cancelar.Enabled   = .F.
1685:                     THIS.cmd_4c_TotLinha.Enabled   = .F.
1686:                     THIS.cmd_4c_Pedras.Enabled     = .F.
1687:                     THIS.cmd_4c_Disponivel.Enabled = .F.
1688:                     THIS.cnt_4c_Container3.Enabled = .F.
1689:                     THIS.cnt_4c_Container2.Visible = .T.

*-- Linhas 1704 a 1737:
1704:                 USE IN TmpLinha
1705:             ENDIF
1706: 
1707:             SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
1708:               FROM TmpFinal ;
1709:              GROUP BY 1 ;
1710:              UNION ALL ;
1711:             SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
1712:               FROM TmpFinal ;
1713:              GROUP BY 1 ;
1714:               INTO CURSOR TmpLinha ;
1715:              ORDER BY 2, 1
1716: 
1717:             THIS.cnt_4c_Container1.grd_4c_Dados.RecordSource = "TmpLinha"
1718:             WITH THIS.cnt_4c_Container1.grd_4c_Dados
1719:                 .Column1.ControlSource = "TmpLinha.Linhas"
1720:                 .Column2.ControlSource = "TmpLinha.Saldo"
1721:                 .Column3.ControlSource = "TmpLinha.Estoque"
1722:                 .Column4.ControlSource = "TmpLinha.Produzir"
1723:                 .SetAll("DynamicFontBold",  "TmpLinha.Linhas = [TOTAIS]", "Column")
1724:                 .SetAll("DynamicForeColor", "IIF(TmpLinha.Linhas = [TOTAIS], RGB(0,0,255), RGB(0,0,0))", "Column")
1725:             ENDWITH
1726: 
1727:             THIS.cmd_4c_Processar.Enabled  = .F.
1728:             THIS.cmd_4c_Cancelar.Enabled   = .F.
1729:             THIS.cmd_4c_TotLinha.Enabled   = .F.
1730:             THIS.cmd_4c_Pedras.Enabled     = .F.
1731:             THIS.cmd_4c_Disponivel.Enabled = .F.
1732:             THIS.grd_4c_Dados.Enabled      = .F.
1733:             THIS.cnt_4c_Container3.Enabled = .F.
1734:             THIS.cnt_4c_Container1.Visible = .T.
1735:             THIS.cnt_4c_Container1.ZOrder
1736:             THIS.cnt_4c_Container1.grd_4c_Dados.Refresh
1737:             THIS.cnt_4c_Container1.grd_4c_Dados.Column1.SetFocus

*-- Linhas 1748 a 1770:
1748: 
1749:             THIS.cnt_4c_Container4.grd_4c_Dados.RecordSource = "SelPedra"
1750:             WITH THIS.cnt_4c_Container4.grd_4c_Dados
1751:                 .Column1.ControlSource = "SelPedra.Cpros"
1752:                 .Column2.ControlSource = "SelPedra.Dpros"
1753:                 .Column3.ControlSource = "SelPedra.Cunis"
1754:                 .Column4.ControlSource = "SelPedra.Qtds"
1755:                 .Column5.ControlSource = "SelPedra.Cpro2s"
1756:             ENDWITH
1757: 
1758:             THIS.cmd_4c_Processar.Enabled  = .F.
1759:             THIS.cmd_4c_Cancelar.Enabled   = .F.
1760:             THIS.cmd_4c_TotLinha.Enabled   = .F.
1761:             THIS.cmd_4c_Pedras.Enabled     = .F.
1762:             THIS.cmd_4c_Disponivel.Enabled = .F.
1763:             THIS.grd_4c_Dados.Enabled      = .F.
1764:             THIS.cnt_4c_Container3.Enabled = .F.
1765:             THIS.cnt_4c_Container4.Visible = .T.
1766:             THIS.cnt_4c_Container4.ZOrder
1767:             THIS.cnt_4c_Container4.grd_4c_Dados.Refresh
1768:             THIS.cnt_4c_Container4.grd_4c_Dados.Column1.SetFocus
1769:         CATCH TO loc_oErro
1770:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 1785 a 1824:
1785:                     USE IN TmpDisp
1786:                 ENDIF
1787: 
1788:                 SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
1789:                        000000000.000 AS Utilizar ;
1790:                   FROM TmpSaldG ;
1791:                  WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND CodTams = m.loc_cTam AND Disps > 0 ;
1792:                   INTO CURSOR Resultado ORDER BY 1, 2, 3, 4
1793:                 SELECT 0
1794:                 USE DBF("Resultado") ALIAS TmpDisp AGAIN
1795:                 USE IN Resultado
1796: 
1797:                 THIS.grd_4c_Dados.Enabled = .F.
1798: 
1799:                 IF _Tally = 0
1800:                     MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "")
1801:                     THIS.BtnCancelaDisp5Click()
1802:                 ELSE
1803:                     THIS.cnt_4c_Container5.grd_4c_Dados.RecordSource = "TmpDisp"
1804:                     WITH THIS.cnt_4c_Container5.grd_4c_Dados
1805:                         .Column1.ControlSource = "TmpDisp.Grupos"
1806:                         .Column2.ControlSource = "TmpDisp.Estos"
1807:                         .Column3.ControlSource = "TmpDisp.Priors"
1808:                         .Column4.ControlSource = "TmpDisp.Disps"
1809:                         .Column5.ControlSource = "TmpDisp.Utilizar"
1810:                     ENDWITH
1811: 
1812:                     WITH THIS.cnt_4c_Container5
1813:                         .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel (" + ;
1814:                                                  ALLTRIM(loc_cCpro) + " " + ALLTRIM(loc_cCor) + ;
1815:                                                  "/" + ALLTRIM(loc_cTam) + ")"
1816:                         .txt_4c_Qt_pedida.Value = TmpFinal.Saldo - TmpFinal.Estoque
1817:                         .txt_4c_Qt_Selec.Value  = 0
1818:                         .Visible     = .T.
1819:                     ENDWITH
1820: 
1821:                     THIS.cmd_4c_Processar.Enabled  = .F.
1822:                     THIS.cmd_4c_Cancelar.Enabled   = .F.
1823:                     THIS.cmd_4c_TotLinha.Enabled   = .F.
1824:                     THIS.cmd_4c_Disponivel.Enabled = .F.

*-- Linhas 1925 a 1971:
1925: 
1926:         TRY
1927:             IF USED("TmpDisp") AND USED("TmpFinal")
1928:                 SELECT TmpDisp
1929:                 SUM Utilizar TO loc_nQtdUtil
1930: 
1931:                 IF loc_nQtdUtil > 0
1932:                     SELECT TmpDisp
1933:                     SCAN
1934:                         IF Utilizar = 0
1935:                             LOOP
1936:                         ENDIF
1937:                         loc_nQtUtil = Utilizar
1938:                         =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, "TmpSaldo")
1939:                         SELECT TmpFinal
1940:                         REPLACE Produzir WITH TmpFinal.Produzir - m.loc_nQtUtil
1941:                         REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir
1942: 
1943:                         SELECT TmpSaldo
1944:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - m.loc_nQtUtil
1945: 
1946:                         IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
1947:                             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
1948:                         ENDIF
1949:                         REPLACE KeySelm WITH .T. IN TmpSaldU
1950: 
1951:                         SELECT TmpSaldG
1952:                         SET ORDER TO Cpros
1953:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
1954:                         REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_nQtUtil
1955: 
1956:                         SELECT TmpDisp
1957:                     ENDSCAN
1958:                     =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
1959:                 ENDIF
1960:                 loc_lSucesso = .T.
1961:             ENDIF
1962:         CATCH TO loc_oErro
1963:             MsgErro(loc_oErro.Message, "Erro")
1964:         ENDTRY
1965: 
1966:         WITH THIS
1967:             .cmd_4c_Processar.Enabled  = .T.
1968:             .cmd_4c_Cancelar.Enabled   = .T.
1969:             .cmd_4c_TotLinha.Enabled   = .T.
1970:             .cmd_4c_SelEstoque.Enabled = .T.
1971:             .cmd_4c_Pedras.Enabled     = .T.

*-- Linhas 2000 a 2047:
2000: 
2001:         TRY
2002:             IF USED("TmpDisp") AND USED("TmpFinal")
2003:                 SELECT TmpDisp
2004:                 SUM Utilizar TO loc_nQtdUtil
2005: 
2006:                 IF loc_nQtdUtil > 0
2007:                     SELECT TmpDisp
2008:                     SCAN
2009:                         IF Utilizar = 0
2010:                             LOOP
2011:                         ENDIF
2012:                         loc_nQtUtil = Utilizar
2013:                         =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2014: 
2015:                         SELECT TmpFinal
2016:                         REPLACE Produzir WITH TmpFinal.Produzir - m.loc_nQtUtil
2017:                         REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir
2018: 
2019:                         SELECT TmpSaldo
2020:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - m.loc_nQtUtil
2021: 
2022:                         IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
2023:                             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
2024:                         ENDIF
2025:                         REPLACE KeySelm WITH .T. IN TmpSaldU
2026: 
2027:                         SELECT TmpSaldG
2028:                         SET ORDER TO Cpros
2029:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + STR(TmpDisp.Priors, 2) + TmpDisp.Grupos + TmpDisp.Estos)
2030:                         REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_nQtUtil
2031: 
2032:                         SELECT TmpDisp
2033:                     ENDSCAN
2034:                     =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2035:                 ENDIF
2036:             ENDIF
2037:         CATCH TO loc_oErro
2038:             MsgErro(loc_oErro.Message, "Erro")
2039:         ENDTRY
2040: 
2041:         WITH THIS
2042:             .cmd_4c_Processar.Enabled  = .T.
2043:             .cmd_4c_Cancelar.Enabled   = .T.
2044:             .cmd_4c_TotLinha.Enabled   = .T.
2045:             .cmd_4c_Disponivel.Enabled = .T.
2046:             .cmd_4c_SelEstoque.Enabled = .T.
2047:             .cmd_4c_Pedras.Enabled     = .T.

*-- Linhas 2072 a 2154:
2072: 
2073:             =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2074: 
2075:             SELECT TmpSaldG
2076:             SET ORDER TO Cpros
2077:             SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
2078:             GO TOP
2079: 
2080:             WITH THIS.cnt_4c_Container3
2081:                 IF USED("TmpSaldo") AND !EOF("TmpSaldo")
2082:                     .txt_4c_Tot_Qtd.Value = TmpSaldo.Saldo
2083:                     .txt_4c_Tot_Est.Value = TmpSaldo.Saldo - TmpSaldo.Disps
2084:                     .txt_4c_Tot_Prz.Value = TmpSaldo.Disps
2085:                 ENDIF
2086: 
2087:                 .lbl_4c_Label1.Caption = ALLTRIM(TmpFinal.Cpros) + ;
2088:                     IIF(!EMPTY(TmpFinal.CodCors), " Cor:" + TmpFinal.CodCors, "") + ;
2089:                     IIF(!EMPTY(TmpFinal.CodTams), " Tam:" + TmpFinal.CodTams, "")
2090: 
2091:                 .grd_4c_Dados.Refresh
2092:                 .Visible     = .T.
2093:             ENDWITH
2094: 
2095:             *-- Foto do produto
2096:             loc_cSQL = "SELECT TOP 1 FigJpgs FROM SigCdPro WHERE CPros = '" + ;
2097:                        ALLTRIM(TmpFinal.CPros) + "'"
2098:             IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpProFig") > 0
2099:                 CLEAR RESOURCES
2100:                 THIS.img_4c_ImgFigJpg.Picture = ""
2101:                 THIS.img_4c_ImgFigJpg.Visible = .F.
2102: 
2103:                 IF !EMPTY(xTmpProFig.FigJpgs) AND !ISNULL(xTmpProFig.FigJpgs)
2104:                     loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(xTmpProFig.FigJpgs, ;
2105:                                      "data:image/png;base64,", ""), ;
2106:                                      "data:image/jpeg;base64,", ""), ;
2107:                                      "data:image/jpg;base64,", ""), 14)
2108:                     loc_lcArquivo = SYS(2023) + "\TempGlb.jpg"
2109:                     IF STRTOFILE(loc_lcFoto, loc_lcArquivo) > 0
2110:                         THIS.img_4c_ImgFigJpg.Picture = loc_lcArquivo
2111:                         THIS.img_4c_ImgFigJpg.Visible = .T.
2112:                     ENDIF
2113:                 ENDIF
2114:                 IF USED("xTmpProFig")
2115:                     USE IN xTmpProFig
2116:                 ENDIF
2117:             ENDIF
2118: 
2119:             SELECT TmpFinal
2120:         CATCH TO loc_oErro
2121:             MsgErro(loc_oErro.Message, "Erro")
2122:         ENDTRY
2123:     ENDPROC
2124: 
2125:     PROCEDURE GrdCol6TextWhen
2126:         LOCAL loc_lPermite
2127:         loc_lPermite = .T.
2128: 
2129:         TRY
2130:             IF USED("TmpFinal")
2131:                 THIS.this_nOldValue = THIS.grd_4c_Dados.Column6.Text1.Value
2132: 
2133:                 IF THIS.this_lReserva AND TmpFinal.Estoque = 0
2134:                     loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdPro WHERE CPros = '" + ;
2135:                                ALLTRIM(TmpFinal.CPros) + "'"
2136:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempPro") > 0
2137:                         loc_cSQL = "SELECT TOP 1 TipoEstos FROM SigCdGrp WHERE CGrus = '" + ;
2138:                                    ALLTRIM(xTempPro.CGrus) + "'"
2139:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempGru") > 0
2140:                             IF INLIST(xTempGru.TipoEstos, 3, 4)
2141:                                 THIS.cmd_4c_Disponivel.Enabled = .T.
2142:                             ENDIF
2143:                             IF USED("xTempGru")
2144:                                 USE IN xTempGru
2145:                             ENDIF
2146:                         ENDIF
2147:                         IF USED("xTempPro")
2148:                             USE IN xTempPro
2149:                         ENDIF
2150:                     ENDIF
2151:                 ENDIF
2152:             ENDIF
2153:         CATCH TO loc_oErro
2154:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 2170 a 2188:
2170:             ENDIF
2171: 
2172:             IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
2173:                 INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
2174:             ENDIF
2175: 
2176:             IF loc_nNewValue <> loc_nOld AND TmpSaldU.KeySelm
2177:                 IF MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque. " + ;
2178:                                CHR(13) + "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", "")
2179:                     *-- Continue
2180:                 ELSE
2181:                     THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
2182:                     loc_lValido = .F.
2183:                 ENDIF
2184:             ENDIF
2185: 
2186:             IF loc_lValido
2187:                 DO CASE
2188:                     CASE loc_nNewValue = loc_nOld

*-- Linhas 2203 a 2223:
2203:                             REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - loc_nNewValue IN TmpFinal
2204:                             REPLACE KeySelm WITH .F. IN TmpSaldU
2205: 
2206:                             SELECT TmpSaldo
2207:                             loc_xBaixa = Saldo - Disps
2208:                             SELECT TmpSaldG
2209:                             SET ORDER TO Cpros
2210:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
2211:                             REPLACE Disps WITH Saldo WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams
2212:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
2213:                             SCAN WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams AND m.loc_xBaixa > 0
2214:                                 IF TmpSaldG.Disps >= m.loc_xBaixa
2215:                                     REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_xBaixa
2216:                                     m.loc_xBaixa = 0
2217:                                 ELSE
2218:                                     m.loc_xBaixa = m.loc_xBaixa - TmpSaldG.Disps
2219:                                     REPLACE TmpSaldG.Disps WITH 0
2220:                                 ENDIF
2221:                             ENDSCAN
2222:                         ELSE
2223:                             MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")

*-- Linhas 2238 a 2256:
2238: 
2239:         TRY
2240:             IF USED("TmpFinal")
2241:                 SELECT TmpFinal
2242:                 loc_nRecno = RECNO()
2243:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2244:                 GO loc_nRecno
2245:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2246:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2247:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2248:                 THIS.txt_4c_Tot_Qtd.Refresh
2249:                 THIS.txt_4c_Tot_Est.Refresh
2250:                 THIS.txt_4c_Tot_Prz.Refresh
2251:                 THIS.Refresh
2252:             ENDIF
2253:         CATCH TO loc_oErro
2254:             MsgErro(loc_oErro.Message, "Erro")
2255:         ENDTRY
2256:     ENDPROC

*-- Linhas 2349 a 2369:
2349:         TRY
2350:             loc_cVal = ALLTRIM(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
2351:             IF !EMPTY(loc_cVal)
2352:                 loc_cSQL = "SELECT TOP 1 CPros, DPros, Cunis FROM SigCdPro WHERE CPros = '" + ;
2353:                            EscaparSQL(loc_cVal)
2354:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crListaRemota") > 0 AND RECCOUNT("crListaRemota") > 0
2355:                     THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value = crListaRemota.CPros
2356:                     REPLACE SelPedra.Dpros WITH crListaRemota.DPros, ;
2357:                             SelPedra.Cunis WITH crListaRemota.Cunis IN SelPedra
2358:                 ELSE
2359:                     *-- Abrir picker (FormBuscaAuxiliar)
2360:                     DO FormBuscaAuxiliar WITH gnConnHandle, "SigCdPro", "crListaRemota", "CPros", ;
2361:                                              loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", 1000, ;
2362:                                              "CPros", "DPros"
2363:                     IF USED("crListaRemota") AND RECCOUNT("crListaRemota") > 0
2364:                         THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value = crListaRemota.CPros
2365:                         REPLACE SelPedra.Dpros WITH crListaRemota.DPros, ;
2366:                                 SelPedra.Cunis WITH crListaRemota.Cunis IN SelPedra
2367:                     ENDIF
2368:                 ENDIF
2369:                 IF USED("crListaRemota")

*-- Linhas 2417 a 2437:
2417:         TRY
2418:             loc_cVal = ALLTRIM(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value)
2419:             IF !EMPTY(loc_cVal)
2420:                 loc_cSQL = "SELECT TOP 1 CPros, DPros FROM SigCdPro WHERE CPros = " + ;
2421:                            EscaparSQL(loc_cVal)
2422:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crListaPro2") > 0 AND RECCOUNT("crListaPro2") > 0
2423:                     THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = crListaPro2.CPros
2424:                     REPLACE SelPedra.Cpro2s WITH crListaPro2.CPros IN SelPedra
2425:                 ELSE
2426:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2427:                                              "crListaPro2", "CPros", loc_cVal, ;
2428:                                              "Produto Substituto")
2429:                     IF VARTYPE(loc_oBusca) = "O"
2430:                         loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2431:                         loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2432:                         loc_oBusca.Show()
2433:                         IF loc_oBusca.this_lSelecionou AND USED("crListaPro2") AND RECCOUNT("crListaPro2") > 0
2434:                             THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = crListaPro2.CPros
2435:                             REPLACE SelPedra.Cpro2s WITH crListaPro2.CPros IN SelPedra
2436:                         ELSE
2437:                             THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = ""

*-- Linhas 2538 a 2556:
2538: 
2539:         TRY
2540:             IF USED("TmpFinal")
2541:                 SELECT TmpFinal
2542:                 loc_nRecno = RECNO()
2543:                 loc_nSal = 0
2544:                 loc_nEst = 0
2545:                 loc_nPrz = 0
2546:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2547:                 IF loc_nRecno <= RECCOUNT("TmpFinal") AND loc_nRecno > 0
2548:                     GO loc_nRecno IN TmpFinal
2549:                 ENDIF
2550: 
2551:                 IF VARTYPE(THIS.txt_4c_Tot_Qtd) = "O"
2552:                     THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2553:                     THIS.txt_4c_Tot_Qtd.Refresh()
2554:                 ENDIF
2555:                 IF VARTYPE(THIS.txt_4c_Tot_Est) = "O"
2556:                     THIS.txt_4c_Tot_Est.Value = loc_nEst

*-- Linhas 2604 a 2622:
2604:                 loc_nSal = 0
2605:                 loc_nEst = 0
2606:                 loc_nPrz = 0
2607:                 SELECT TmpFinal
2608:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2609:                 GO TOP
2610:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2611:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2612:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2613:             ENDIF
2614:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
2615:                 THIS.grd_4c_Dados.Refresh()
2616:             ENDIF
2617:         CATCH TO loc_oErro
2618:             MsgErro(loc_oErro.Message, "Erro")
2619:         ENDTRY
2620:     ENDPROC
2621: 
2622:     *==========================================================================

*-- Linhas 2707 a 2725:
2707:             THIS.CarregarDados()
2708: 
2709:             IF USED("TmpFinal")
2710:                 SELECT TmpFinal
2711:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2712:                 GO TOP
2713:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2714:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2715:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2716:             ENDIF
2717: 
2718:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
2719:                 THIS.grd_4c_Dados.Refresh()
2720:             ENDIF
2721:             IF VARTYPE(THIS.cnt_4c_Container3) = "O"
2722:                 THIS.cnt_4c_Container3.Refresh()
2723:             ENDIF
2724:             THIS.Refresh()
2725:         CATCH TO loc_oErro

*-- Linhas 2743 a 2761:
2743:                 IF loc_lHab
2744:                     *-- Permitir edicao apenas se nao ha operacao TransfRes bloqueando
2745:                     IF USED("crSigCdPam")
2746:                         SELECT crSigCdPam
2747:                         IF EMPTY(crSigCdPam.TransfRes)
2748:                             THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
2749:                         ELSE
2750:                             THIS.grd_4c_Dados.Column6.ReadOnly = .F.
2751:                         ENDIF
2752:                     ELSE
2753:                         THIS.grd_4c_Dados.Column6.ReadOnly = .F.
2754:                     ENDIF
2755:                 ELSE
2756:                     THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
2757:                 ENDIF
2758:             ENDIF
2759: 
2760:             *-- Botoes de acao
2761:             THIS.AjustarBotoesPorModo()

*-- Linhas 2824 a 2842:
2824: 
2825:             *-- Verificar se operacao de pedras/selecao de estoque esta disponivel
2826:             IF loc_lTemDados AND USED("crSigCdPam")
2827:                 SELECT crSigCdPam
2828:                 loc_lPodeAcao = !EMPTY(crSigCdPam.DopEmphs) AND ;
2829:                                 !EMPTY(crSigCdPam.DopReqcs) AND ;
2830:                                 !EMPTY(crSigCdPam.DopPedcs) AND ;
2831:                                 !EMPTY(crSigCdPam.DopComps) AND ;
2832:                                 !THIS.this_lReserva
2833:             ENDIF
2834: 
2835:             *-- Aplicar estado aos botoes
2836:             THIS.cmd_4c_Processar.Enabled    = loc_lTemDados
2837:             THIS.cmd_4c_Cancelar.Enabled     = .T.
2838:             THIS.cmd_4c_TotLinha.Enabled     = loc_lTemDados
2839:             THIS.cmd_4c_Disponivel.Enabled   = loc_lTemDados
2840:             THIS.cmd_4c_BtnRelatorio.Enabled = loc_lTemDados
2841:             THIS.cmd_4c_Pedras.Enabled       = loc_lPodeAcao
2842:             THIS.cmd_4c_SelEstoque.Enabled   = loc_lPodeAcao

