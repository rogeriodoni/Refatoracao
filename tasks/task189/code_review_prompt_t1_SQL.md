# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ESTOQUE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GEREMPHS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'BXDESTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2978 linhas total):

*-- Linhas 334 a 352:
334:             .FontSize          = 8
335:             .AllowHeaderSizing = .F.
336:             .AllowRowSizing    = .F.
337:             .DeleteMark        = .F.
338:             .RecordMark        = .F.
339:             .Panel             = 1
340:             .RowHeight         = 17
341:             .ScrollBars        = 2
342:             .GridLineColor     = RGB(238,238,238)
343:             WITH .Column1
344:                 .Width              = 115
345:                 .Movable            = .F.
346:                 .Resizable          = .F.
347:                 .ReadOnly           = .T.
348:                 .Header1.Caption    = "Produto"
349:                 .Header1.FontName   = "Verdana"
350:                 .Header1.FontSize   = 8
351:                 .Header1.Alignment  = 2
352:                 .Header1.ForeColor  = RGB(36,84,155)

*-- Linhas 543 a 561:
543:                 .FontSize          = 8
544:                 .AllowHeaderSizing = .F.
545:                 .AllowRowSizing    = .F.
546:                 .DeleteMark        = .F.
547:                 .RecordMark        = .F.
548:                 .Panel             = 1
549:                 .RowHeight         = 16
550:                 .ScrollBars        = 2
551:                 .GridLineColor     = RGB(238,238,238)
552:                 WITH .Column1
553:                     .ColumnOrder        = 2
554:                     .Width              = 74
555:                     .Movable            = .F.
556:                     .Resizable          = .F.
557:                     .ReadOnly           = .T.
558:                     .Header1.Caption    = "Grupo"
559:                     .Header1.FontName   = "Verdana"
560:                     .Header1.FontSize   = 8
561:                     .Header1.Alignment  = 2

*-- Linhas 805 a 823:
805:                 .FontSize          = 8
806:                 .AllowHeaderSizing = .F.
807:                 .AllowRowSizing    = .F.
808:                 .DeleteMark        = .F.
809:                 .RecordMark        = .F.
810:                 .Panel             = 1
811:                 .RowHeight         = 16
812:                 .ScrollBars        = 2
813:                 .GridLineColor     = RGB(238,238,238)
814:                 WITH .Column1
815:                     .Width              = 108
816:                     .Movable            = .F.
817:                     .Resizable          = .F.
818:                     .ReadOnly           = .T.
819:                     .Header1.Caption    = "Produto"
820:                     .Header1.FontName   = "Verdana"
821:                     .Header1.FontSize   = 8
822:                     .Header1.Alignment  = 2
823:                     .Header1.ForeColor  = RGB(36,84,155)

*-- Linhas 1018 a 1036:
1018:                 .FontSize          = 8
1019:                 .AllowHeaderSizing = .F.
1020:                 .AllowRowSizing    = .F.
1021:                 .DeleteMark        = .F.
1022:                 .RecordMark        = .F.
1023:                 .RowHeight         = 16
1024:                 .ScrollBars        = 2
1025:                 .GridLineColor     = RGB(238,238,238)
1026:                 WITH .Column1
1027:                     .ColumnOrder        = 2
1028:                     .Width              = 80
1029:                     .Movable            = .F.
1030:                     .Resizable          = .F.
1031:                     .ReadOnly           = .T.
1032:                     .Header1.Caption    = "Grupo"
1033:                     .Header1.FontName   = "Verdana"
1034:                     .Header1.FontSize   = 8
1035:                     .Header1.Alignment  = 2
1036:                     .Header1.ForeColor  = RGB(36,84,155)

*-- Linhas 1283 a 1301:
1283:                 .FontSize          = 8
1284:                 .AllowHeaderSizing = .F.
1285:                 .AllowRowSizing    = .F.
1286:                 .DeleteMark        = .F.
1287:                 .RecordMark        = .F.
1288:                 .ReadOnly          = .T.
1289:                 .RowHeight         = 16
1290:                 .ScrollBars        = 2
1291:                 .GridLineColor     = RGB(238,238,238)
1292:                 WITH .Column1
1293:                     .Width              = 84
1294:                     .Movable            = .F.
1295:                     .Resizable          = .F.
1296:                     .ReadOnly           = .T.
1297:                     .Sparse             = .F.
1298:                     .Header1.Caption    = "Linha"
1299:                     .Header1.FontName   = "Verdana"
1300:                     .Header1.FontSize   = 8
1301:                     .Header1.Alignment  = 2

*-- Linhas 1427 a 1445:
1427:                 .Width             = 605
1428:                 .ColumnCount       = 5
1429:                 .FontSize          = 8
1430:                 .DeleteMark        = .F.
1431:                 .RecordMark        = .F.
1432:                 .RowHeight         = 16
1433:                 .ScrollBars        = 2
1434:                 .GridLineColor     = RGB(238,238,238)
1435:                 WITH .Column1
1436:                     .Width              = 108
1437:                     .Movable            = .F.
1438:                     .Resizable          = .F.
1439:                     .Header1.Caption    = "Produto"
1440:                     .Header1.FontName   = "Verdana"
1441:                     .Header1.FontSize   = 8
1442:                     .Header1.Alignment  = 2
1443:                     .Header1.ForeColor  = RGB(36,84,155)
1444:                     .Text1.FontSize     = 8
1445:                     .Text1.BorderStyle  = 0

*-- Linhas 1679 a 1787:
1679:     ENDPROC
1680: 
1681:     *==========================================================================
1682:     * InicializarDados - ControlSources, queries iniciais, totais
1683:     *==========================================================================
1684:     PROTECTED PROCEDURE InicializarDados()
1685:         LOCAL loc_lSucesso, loc_oErro, loc_nSal, loc_nEst, loc_nPrz, loc_lcQuery
1686:         loc_lSucesso = .F.
1687:         TRY
1688:             *-- ControlSources GradeItens (mapeamento exato do legado)
1689:             WITH THIS.grd_4c_Itens
1690:                 .RecordSource            = "TmpFinal"
1691:                 .Column1.ControlSource   = "TmpFinal.Cpros"
1692:                 .Column2.ControlSource   = "TmpFinal.CodCors"
1693:                 .Column3.ControlSource   = "TmpFinal.Dopes"
1694:                 .Column4.ControlSource   = "TmpFinal.Numes"
1695:                 .Column5.ControlSource   = "TmpFinal.Saldo"
1696:                 .Column6.ControlSource   = "TmpFinal.Produzir"
1697:                 .Column7.ControlSource   = "TmpFinal.Estoque"
1698:                 .Column8.ControlSource   = "IIF(EMPTY(TmpFinal.Obsps),' ','*')"
1699:                 .Column9.ControlSource   = "TmpFinal.CodTams"
1700:             ENDWITH
1701: 
1702:             *-- Se TransfRes vazio, grid somente leitura
1703:             IF USED("crSigCdPam") .AND. NOT EOF("crSigCdPam")
1704:                 IF EMPTY(ALLTRIM(crSigCdPam.TransfRes))
1705:                     THIS.grd_4c_Itens.SetAll("ReadOnly", .T.)
1706:                 ENDIF
1707:             ENDIF
1708: 
1709:             *-- TmpSaldG para Container3
1710:             IF USED("TmpSaldG")
1711:                 SELECT TmpSaldG
1712:                 SET ORDER TO Cpros
1713:                 IF USED("TmpFinal") .AND. NOT EOF("TmpFinal")
1714:                     SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1715:                 ENDIF
1716:                 GO TOP
1717:             ENDIF
1718: 
1719:             WITH THIS.cnt_4c_Info.grd_4c_DispInfo
1720:                 .RecordSource            = "TmpSaldG"
1721:                 .Column1.ControlSource   = "TmpSaldG.Grupos"
1722:                 .Column2.ControlSource   = "TmpSaldG.Estos"
1723:                 .Column3.ControlSource   = "TmpSaldG.Saldo"
1724:                 .Column4.ControlSource   = "TmpSaldG.Saldo - TmpSaldG.Disps"
1725:                 .Column5.ControlSource   = "TmpSaldG.Disps"
1726:                 .Column6.ControlSource   = "TmpSaldG.Emps"
1727:                 .SetAll("ReadOnly", .T.)
1728:             ENDWITH
1729: 
1730:             *-- Cursor de rastreamento de selecao manual
1731:             IF NOT USED("TmpSaldU")
1732:                 CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L)
1733:                 INDEX ON Cpros TAG Cpros
1734:             ENDIF
1735: 
1736:             *-- ControlSource do EditBox de observacoes
1737:             THIS.edt_4c_Obs.ControlSource = "TmpFinal.Obsps"
1738: 
1739:             *-- Calcular totais iniciais
1740:             loc_nSal = 0
1741:             loc_nEst = 0
1742:             loc_nPrz = 0
1743:             IF USED("TmpFinal")
1744:                 SELECT TmpFinal
1745:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
1746:                 GO TOP
1747:             ENDIF
1748:             THIS.txt_4c_TotQtd.Value = loc_nSal
1749:             THIS.txt_4c_TotEst.Value = loc_nEst
1750:             THIS.txt_4c_TotPrz.Value = loc_nPrz
1751: 
1752:             *-- Carregar SigCdTpc + SigCdCom -> crSigCdCom
1753:             IF NOT USED("crSigCdCom")
1754:                 loc_lcQuery = "SELECT a.Tipos, a.Custos, b.CGrus " + ;
1755:                               "FROM SigCdTpc a, SigCdCom b " + ;
1756:                               "WHERE a.Tipos = b.Tipos"
1757:                 IF SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdCom") > 0
1758:                     SELECT crSigCdCom
1759:                     INDEX ON Tipos + CGrus TAG Tipos
1760:                 ELSE
1761:                     MsgErro("Falha ao carregar SigCdCom.", "Erro")
1762:                 ENDIF
1763:             ENDIF
1764: 
1765:             *-- SigKey do pacote (usado em GravaHistorico)
1766:             IF USED("CrSigCdPac") .AND. NOT EOF("CrSigCdPac")
1767:                 THIS.this_oBusinessObject.this_cSigKey = CrSigCdPac.sigKeys
1768:             ENDIF
1769: 
1770:             *-- SelPedra: garantir pelo menos um registro
1771:             IF USED("SelPedra") .AND. RECCOUNT("SelPedra") = 0
1772:                 SELECT SelPedra
1773:                 APPEND BLANK
1774:             ENDIF
1775: 
1776:             loc_lSucesso = .T.
1777:         CATCH TO loc_oErro
1778:             MsgErro("Erro ao inicializar dados: " + loc_oErro.Message + ;
1779:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
1780:         ENDTRY
1781:         RETURN loc_lSucesso
1782:     ENDPROC
1783: 
1784:     *==========================================================================
1785:     * AjustarBotaoPedras - habilitar apenas se parametros completos
1786:     *==========================================================================
1787:     PROTECTED PROCEDURE AjustarBotaoPedras()

*-- Linhas 1852 a 1870:
1852:             =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
1853: 
1854:             IF USED("TmpSaldG")
1855:                 SELECT TmpSaldG
1856:                 SET ORDER TO Cpros
1857:                 SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1858:                 GO TOP
1859:             ENDIF
1860: 
1861:             WITH THIS.cnt_4c_Info
1862:                 .txt_4c_TotQtdInfo.Value = TmpSaldo.Saldo
1863:                 .txt_4c_TotEstInfo.Value = TmpSaldo.Saldo - TmpSaldo.Disps
1864:                 .txt_4c_TotPrzInfo.Value = TmpSaldo.Disps
1865:                 .lbl_4c_TituloInfo.Caption = TmpFinal.Cpros + ;
1866:                     IIF(NOT EMPTY(TmpFinal.CodCors), " Cor:" + TmpFinal.CodCors, "") + ;
1867:                     IIF(NOT EMPTY(TmpFinal.CodTams), " Tam:" + TmpFinal.CodTams, "")
1868: 
1869:                 IF THIS.this_oBusinessObject.AtualizarInfoItem(par_nColIndex)
1870:                     .txt_4c_DGrupoInfo.Value = THIS.this_oBusinessObject.this_cDscGrupo

*-- Linhas 1879 a 1934:
1879:             CLEAR RESOURCES
1880:             THIS.img_4c_Figura.Picture = ""
1881:             THIS.img_4c_Figura.Visible = .F.
1882:             IF SQLEXEC(gnConnHandle, "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(TmpFinal.CPros)), "crSigProFig") > 0
1883:                 IF NOT EOF("crSigProFig")
1884:                     IF NOT EMPTY(crSigProFig.FigJpgs) .AND. NOT ISNULL(crSigProFig.FigJpgs)
1885:                         loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(crSigProFig.FigJpgs, ;
1886:                             "data:image/png;base64,", ""), ;
1887:                             "data:image/jpeg;base64,", ""), ;
1888:                             "data:image/jpg;base64,", ""), 14)
1889:                         IF STRTOFILE(loc_lcFoto, loc_lcArquivo) > 0
1890:                             THIS.img_4c_Figura.Picture = loc_lcArquivo
1891:                             THIS.img_4c_Figura.Visible = .T.
1892:                         ENDIF
1893:                     ENDIF
1894:                 ENDIF
1895:                 USE IN crSigProFig
1896:             ENDIF
1897: 
1898:             SELECT TmpFinal
1899:         CATCH TO loc_oErro
1900:             MsgErro(loc_oErro.Message, "Erro")
1901:         ENDTRY
1902:     ENDPROC
1903: 
1904:     PROCEDURE GradeItensRedirFoco()
1905:         THIS.grd_4c_Itens.Column6.Text1.SetFocus
1906:     ENDPROC
1907: 
1908:     PROCEDURE GradeDispProdRedirFoco()
1909:         THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.SetFocus
1910:     ENDPROC
1911: 
1912:     PROCEDURE GradeItensColumn6When()
1913:         LOCAL loc_oErro
1914:         THIS.this_oBusinessObject.this_nOldValue = THIS.grd_4c_Itens.Column6.Text1.Value
1915:         IF THIS.this_lReserva .AND. (TmpFinal.Estoque = 0)
1916:             TRY
1917:                 IF SQLEXEC(gnConnHandle, "SELECT CGrus FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(TmpFinal.CPros)), "crTmpPro") > 0
1918:                     IF NOT EOF("crTmpPro")
1919:                         IF SQLEXEC(gnConnHandle, "SELECT TipoEstos FROM SigCdGrp WHERE CGrus = " + EscaparSQL(ALLTRIM(crTmpPro.CGrus)), "crTmpGru") > 0
1920:                             IF NOT EOF("crTmpGru")
1921:                                 IF INLIST(crTmpGru.TipoEstos, 3, 4)
1922:                                     THIS.cmd_4c_Disponiveis.Enabled = .T.
1923:                                 ENDIF
1924:                             ENDIF
1925:                             USE IN crTmpGru
1926:                         ENDIF
1927:                     ENDIF
1928:                     USE IN crTmpPro
1929:                 ENDIF
1930:             CATCH TO loc_oErro
1931:                 MsgErro(loc_oErro.Message, "Erro")
1932:             ENDTRY
1933:         ENDIF
1934:         RETURN .T.

*-- Linhas 1940 a 1958:
1940:         loc_nNovoValor = THIS.grd_4c_Itens.Column6.Text1.Value
1941:         TRY
1942:             IF NOT SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
1943:                 INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
1944:             ENDIF
1945:             IF loc_nNovoValor <> THIS.this_oBusinessObject.this_nOldValue .AND. TmpSaldU.KeySelm
1946:                 IF NOT MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque. " + CHR(13) + ;
1947:                     "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?")
1948:                     THIS.grd_4c_Itens.Column6.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
1949:                     loc_lResultado = .F.
1950:                 ENDIF
1951:             ENDIF
1952:             IF loc_lResultado
1953:                 DO CASE
1954:                     CASE loc_nNovoValor = THIS.this_oBusinessObject.this_nOldValue
1955:                         *-- nenhuma mudanca
1956:                     CASE loc_nNovoValor < 0
1957:                         MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", "")
1958:                         THIS.grd_4c_Itens.Column6.Text1.Value = THIS.this_oBusinessObject.this_nOldValue

*-- Linhas 1971 a 1991:
1971:                             REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps + TmpFinal.Estoque - (TmpFinal.Saldo - TmpFinal.Produzir) IN TmpSaldo
1972:                             REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - loc_nNovoValor IN TmpFinal
1973:                             REPLACE KeySelm WITH .F. IN TmpSaldU
1974:                             SELECT TmpSaldo
1975:                             loc_xBaixa = TmpSaldo.Saldo - TmpSaldo.Disps
1976:                             SELECT TmpSaldG
1977:                             SET ORDER TO Cpros
1978:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
1979:                             REPLACE Disps WITH Saldo WHILE Cpros = TmpSaldo.Cpros .AND. ;
1980:                                 CodCors = TmpSaldo.CodCors .AND. CodTams = TmpSaldo.CodTams
1981:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
1982:                             SCAN WHILE Cpros = TmpSaldo.Cpros .AND. CodCors = TmpSaldo.CodCors .AND. ;
1983:                                 CodTams = TmpSaldo.CodTams .AND. loc_xBaixa > 0
1984:                                 IF TmpSaldG.Disps >= loc_xBaixa
1985:                                     REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_xBaixa
1986:                                     loc_xBaixa = 0
1987:                                 ELSE
1988:                                     loc_xBaixa = loc_xBaixa - TmpSaldG.Disps
1989:                                     REPLACE TmpSaldG.Disps WITH 0
1990:                                 ENDIF
1991:                             ENDSCAN

*-- Linhas 2009 a 2027:
2009:         ENDIF
2010:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_oErro
2011:         TRY
2012:             SELECT TmpFinal
2013:             loc_nRecno = RECNO()
2014:             SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2015:             GO loc_nRecno
2016:             THIS.txt_4c_TotQtd.Value = loc_nSal
2017:             THIS.txt_4c_TotEst.Value = loc_nEst
2018:             THIS.txt_4c_TotPrz.Value = loc_nPrz
2019:             THIS.txt_4c_TotQtd.Refresh
2020:             THIS.txt_4c_TotEst.Refresh
2021:             THIS.txt_4c_TotPrz.Refresh
2022:             THIS.Refresh
2023:         CATCH TO loc_oErro
2024:             MsgErro(loc_oErro.Message, "Erro")
2025:         ENDTRY
2026:     ENDPROC
2027: 

*-- Linhas 2140 a 2162:
2140:                     .Column3.Header1.Caption = "Tam"
2141:                     .Column4.Header1.Caption = "Disponivel"
2142:                     .Column5.Header1.Caption = "Utilizar"
2143:                     .Column1.ControlSource   = "TmpDisp.Cpros"
2144:                     .Column2.ControlSource   = "TmpDisp.CodCors"
2145:                     .Column3.ControlSource   = "TmpDisp.CodTams"
2146:                     .Column4.ControlSource   = "TmpDisp.Disps"
2147:                     .Column5.ControlSource   = "TmpDisp.Utilizar"
2148:                 ENDWITH
2149:                 THIS.cnt_4c_Disponivel.txt_4c_PedidaDisp.Value = TmpFinal.Saldo
2150:                 THIS.grd_4c_Itens.Enabled        = .F.
2151:                 THIS.cmd_4c_Processar.Enabled    = .F.
2152:                 THIS.cmd_4c_Cancelar.Enabled     = .F.
2153:                 THIS.cmd_4c_LinhasTot.Enabled    = .F.
2154:                 THIS.cmd_4c_Disponiveis.Enabled  = .F.
2155:                 THIS.cnt_4c_Info.Enabled         = .F.
2156:                 THIS.cnt_4c_Disponivel.Visible   = .T.
2157:                 THIS.cnt_4c_Disponivel.ZOrder(0)
2158:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Refresh
2159:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.SetFocus
2160:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Refresh
2161:             ENDIF
2162:         CATCH TO loc_oErro

*-- Linhas 2172 a 2193:
2172:             WITH THIS.cnt_4c_Linhas.grd_4c_LinhasAgg
2173:                 .ColumnCount           = 4
2174:                 .RecordSource          = "TmpLinha"
2175:                 .Column1.ControlSource = "TmpLinha.Linhas"
2176:                 .Column2.ControlSource = "TmpLinha.Saldo"
2177:                 .Column3.ControlSource = "TmpLinha.Estoque"
2178:                 .Column4.ControlSource = "TmpLinha.Produzir"
2179:                 .SetAll("DynamicFontBold",  "TmpLinha.Linhas=[TOTAIS]",                              "Column")
2180:                 .SetAll("DynamicForeColor", "IIF(TmpLinha.Linhas=[TOTAIS],RGB(0,0,255),RGB(0,0,0))", "Column")
2181:             ENDWITH
2182:             THIS.cmd_4c_Processar.Enabled   = .F.
2183:             THIS.cmd_4c_Cancelar.Enabled    = .F.
2184:             THIS.cmd_4c_LinhasTot.Enabled   = .F.
2185:             THIS.cmd_4c_Requisicoes.Enabled = .F.
2186:             THIS.cmd_4c_Disponiveis.Enabled = .F.
2187:             THIS.grd_4c_Itens.Enabled       = .F.
2188:             THIS.cnt_4c_Info.Enabled        = .F.
2189:             THIS.cnt_4c_Linhas.Visible      = .T.
2190:             THIS.cnt_4c_Linhas.ZOrder(0)
2191:             THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.Refresh
2192:             THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.Column1.SetFocus
2193:         CATCH TO loc_oErro

*-- Linhas 2202 a 2224:
2202:             WITH THIS.cnt_4c_Requisicoes.grd_4c_PedraReq
2203:                 .ColumnCount           = 5
2204:                 .RecordSource          = "SelPedra"
2205:                 .Column1.ControlSource = "SelPedra.Cpros"
2206:                 .Column2.ControlSource = "SelPedra.Dpros"
2207:                 .Column3.ControlSource = "SelPedra.Cunis"
2208:                 .Column4.ControlSource = "SelPedra.Qtds"
2209:                 .Column5.ControlSource = "SelPedra.Cpro2s"
2210:             ENDWITH
2211:             THIS.cmd_4c_Processar.Enabled    = .F.
2212:             THIS.cmd_4c_Cancelar.Enabled     = .F.
2213:             THIS.cmd_4c_LinhasTot.Enabled    = .F.
2214:             THIS.cmd_4c_Requisicoes.Enabled  = .F.
2215:             THIS.cmd_4c_Disponiveis.Enabled  = .F.
2216:             THIS.grd_4c_Itens.Enabled        = .F.
2217:             THIS.cnt_4c_Info.Enabled         = .F.
2218:             THIS.cnt_4c_Requisicoes.Visible  = .T.
2219:             THIS.cnt_4c_Requisicoes.ZOrder(0)
2220:             THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Refresh
2221:             THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.SetFocus
2222:         CATCH TO loc_oErro
2223:             MsgErro(loc_oErro.Message, "Erro")
2224:         ENDTRY

*-- Linhas 2246 a 2268:
2246:                     .Column3.Header1.Caption = "Prior"
2247:                     .Column4.Header1.Caption = "Disponivel"
2248:                     .Column5.Header1.Caption = "Utilizar"
2249:                     .Column1.ControlSource   = "TmpDisp.Grupos"
2250:                     .Column2.ControlSource   = "TmpDisp.Estos"
2251:                     .Column3.ControlSource   = "TmpDisp.Priors"
2252:                     .Column4.ControlSource   = "TmpDisp.Disps"
2253:                     .Column5.ControlSource   = "TmpDisp.Utilizar"
2254:                 ENDWITH
2255:                 THIS.cnt_4c_Estoques.lbl_4c_TituloEstq.Caption = ;
2256:                     "Estoque Dispon" + CHR(237) + "vel (" + TmpFinal.Cpros + " " + TmpFinal.CodCors + "/" + TmpFinal.CodTams + ")"
2257:                 THIS.cnt_4c_Estoques.txt_4c_PedidaEstq.Value = TmpFinal.Saldo - TmpFinal.Estoque
2258:                 THIS.cnt_4c_Estoques.txt_4c_SelecEstq.Value  = 0
2259:                 THIS.cmd_4c_Processar.Enabled    = .F.
2260:                 THIS.cmd_4c_Cancelar.Enabled     = .F.
2261:                 THIS.cmd_4c_LinhasTot.Enabled    = .F.
2262:                 THIS.cmd_4c_Disponiveis.Enabled  = .F.
2263:                 THIS.cmd_4c_Estoques.Enabled     = .F.
2264:                 THIS.cmd_4c_Requisicoes.Enabled  = .F.
2265:                 THIS.cnt_4c_Info.Enabled         = .F.
2266:                 THIS.cnt_4c_Estoques.Visible     = .T.
2267:                 THIS.cnt_4c_Estoques.ZOrder(0)
2268:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Refresh

*-- Linhas 2310 a 2328:
2310:                 THIS.grd_4c_Itens.Refresh
2311:                 THIS.cnt_4c_Info.grd_4c_DispInfo.Refresh
2312:                 IF USED("TmpFinal")
2313:                     SELECT TmpFinal
2314:                     SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2315:                     THIS.txt_4c_TotQtd.Value = loc_nSal
2316:                     THIS.txt_4c_TotEst.Value = loc_nEst
2317:                     THIS.txt_4c_TotPrz.Value = loc_nPrz
2318:                 ENDIF
2319:             ENDIF
2320:         CATCH TO loc_oErro
2321:             MsgErro(loc_oErro.Message, "Erro")
2322:         ENDTRY
2323:     ENDPROC
2324: 
2325:     *-- Cancelar.Click: fechar form sem processar
2326:     PROCEDURE CmdCancelarClick()
2327:         LOCAL loc_oErro
2328:         TRY

*-- Linhas 2341 a 2359:
2341:         TRY
2342:             THIS.this_oBusinessObject.ConfirmarDisponivelSimples()
2343:             IF USED("TmpFinal")
2344:                 SELECT TmpFinal
2345:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2346:                 THIS.txt_4c_TotQtd.Value = loc_nSal
2347:                 THIS.txt_4c_TotEst.Value = loc_nEst
2348:                 THIS.txt_4c_TotPrz.Value = loc_nPrz
2349:             ENDIF
2350:         CATCH TO loc_oErro
2351:             MsgErro(loc_oErro.Message, "Erro")
2352:         ENDTRY
2353:         THIS.cmd_4c_Processar.Enabled    = .T.
2354:         THIS.cmd_4c_Cancelar.Enabled     = .T.
2355:         THIS.cmd_4c_LinhasTot.Enabled    = .T.
2356:         THIS.cmd_4c_Estoques.Enabled     = .T.
2357:         THIS.cmd_4c_Disponiveis.Enabled  = .T.
2358:         THIS.cnt_4c_Info.Enabled         = .T.
2359:         THIS.cnt_4c_Estoques.Visible     = .F.

*-- Linhas 2421 a 2447:
2421:         TRY
2422:             loc_lcValor = ALLTRIM(TRANSFORM(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value))
2423:             IF NOT EMPTY(loc_lcValor)
2424:                 IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CPros, DPros, Cunis FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_lcValor), "crProLookup") > 0
2425:                     IF NOT EOF("crProLookup")
2426:                         THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value = crProLookup.Cpros
2427:                         REPLACE SelPedra.Dpros WITH crProLookup.DPros, ;
2428:                                 SelPedra.Cunis WITH crProLookup.Cunis IN SelPedra
2429:                         USE IN crProLookup
2430:                     ELSE
2431:                         USE IN crProLookup
2432:                         IF SQLEXEC(gnConnHandle, "SELECT CPros, DPros FROM SigCdPro WHERE CPros LIKE " + EscaparSQL(loc_lcValor + "%"), "cursor_4c_BuscaPro") > 0
2433:                             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
2434:                             IF VARTYPE(loc_oForm) = "O"
2435:                                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaPro"
2436:                                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2437:                                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2438:                                 loc_oForm.Show()
2439:                                 IF loc_oForm.this_lSelecionou
2440:                                     THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value = cursor_4c_BuscaPro.Cpros
2441:                                     REPLACE SelPedra.Dpros WITH cursor_4c_BuscaPro.DPros, ;
2442:                                             SelPedra.Cunis WITH cursor_4c_BuscaPro.Cunis IN SelPedra
2443:                                 ENDIF
2444:                             ENDIF
2445:                         ENDIF
2446:                         IF USED("cursor_4c_BuscaPro")
2447:                             USE IN cursor_4c_BuscaPro

*-- Linhas 2470 a 2494:
2470:         TRY
2471:             loc_lcValor = ALLTRIM(TRANSFORM(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value))
2472:             IF NOT EMPTY(loc_lcValor)
2473:                 IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_lcValor), "crProLookup2") > 0
2474:                     IF NOT EOF("crProLookup2")
2475:                         THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value = crProLookup2.Cpros
2476:                         USE IN crProLookup2
2477:                     ELSE
2478:                         USE IN crProLookup2
2479:                         IF SQLEXEC(gnConnHandle, "SELECT CPros, DPros FROM SigCdPro WHERE CPros LIKE " + EscaparSQL(loc_lcValor + "%"), "cursor_4c_BuscaPro2") > 0
2480:                             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
2481:                             IF VARTYPE(loc_oForm) = "O"
2482:                                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaPro2"
2483:                                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2484:                                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2485:                                 loc_oForm.Show()
2486:                                 IF loc_oForm.this_lSelecionou
2487:                                     THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value = cursor_4c_BuscaPro2.Cpros
2488:                                 ENDIF
2489:                             ENDIF
2490:                         ENDIF
2491:                         IF USED("cursor_4c_BuscaPro2")
2492:                             USE IN cursor_4c_BuscaPro2
2493:                         ENDIF
2494:                     ENDIF

*-- Linhas 2509 a 2527:
2509:         ENDIF
2510:         LOCAL loc_xPos, loc_oErro
2511:         TRY
2512:             SELECT SelPedra
2513:             loc_xPos = RECNO()
2514:             LOCATE FOR EMPTY(Cpros)
2515:             IF EOF()
2516:                 APPEND BLANK
2517:             ENDIF
2518:             LOCATE FOR RECNO() = loc_xPos
2519:             KEYBOARD "{DNARROW}"
2520:         CATCH TO loc_oErro
2521:             MsgErro(loc_oErro.Message, "Erro")
2522:         ENDTRY
2523:     ENDPROC
2524: 
2525:     *-- img_4c_Figura DblClick: zoom da imagem
2526:     PROCEDURE ImgFiguraDblClick()
2527:         IF NOT EMPTY(THIS.img_4c_Figura.Picture)

*-- Linhas 2683 a 2701:
2683:         TRY
2684:             THIS.AlternarPagina(1)
2685:             IF USED("cursor_4c_ItensFinal") AND RECCOUNT("cursor_4c_ItensFinal") > 0
2686:                 SELECT cursor_4c_ItensFinal
2687:                 GO TOP
2688:             ENDIF
2689:             IF PEMSTATUS(THIS, "grd_4c_Itens", 5) AND THIS.grd_4c_Itens.Visible
2690:                 THIS.grd_4c_Itens.Refresh
2691:                 IF THIS.grd_4c_Itens.ColumnCount >= 6
2692:                     THIS.grd_4c_Itens.Column6.Text1.SetFocus
2693:                 ENDIF
2694:             ENDIF
2695:         CATCH TO loc_oErro
2696:             MsgErro("Erro em BtnAlterarClick: " + loc_oErro.Message + ;
2697:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2698:         ENDTRY
2699:     ENDPROC
2700: 
2701:     *--------------------------------------------------------------------------

*-- Linhas 2708 a 2726:
2708:         TRY
2709:             THIS.AlternarPagina(6)
2710:             IF USED("cursor_4c_ItensFinal") AND RECCOUNT("cursor_4c_ItensFinal") > 0
2711:                 SELECT cursor_4c_ItensFinal
2712:                 THIS.GradeItensAfterRowColChange(1)
2713:             ENDIF
2714:         CATCH TO loc_oErro
2715:             MsgErro("Erro em BtnVisualizarClick: " + loc_oErro.Message + ;
2716:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2717:         ENDTRY
2718:     ENDPROC
2719: 
2720:     *--------------------------------------------------------------------------
2721:     * BtnExcluirClick - Cancela o processamento e encerra o formulario
2722:     * Faz rollback da transacao aberta pelo Init e libera o form pai.
2723:     * Equivalente a acao do botao Cancelar (Sair) da barra superior.
2724:     *--------------------------------------------------------------------------
2725:     PROCEDURE BtnExcluirClick()
2726:         LOCAL loc_oErro

*-- Linhas 2814 a 2832:
2814:             loc_nEst = 0
2815:             loc_nPrz = 0
2816:             IF USED("TmpFinal")
2817:                 SELECT TmpFinal
2818:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2819:                 GO TOP
2820:             ENDIF
2821:             IF PEMSTATUS(THIS, "txt_4c_TotQtd", 5)
2822:                 THIS.txt_4c_TotQtd.Value = loc_nSal
2823:                 THIS.txt_4c_TotEst.Value = loc_nEst
2824:                 THIS.txt_4c_TotPrz.Value = loc_nPrz
2825:             ENDIF
2826:             IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
2827:                 THIS.grd_4c_Itens.Refresh
2828:             ENDIF
2829:             IF PEMSTATUS(THIS, "cnt_4c_Info", 5)
2830:                 THIS.cnt_4c_Info.grd_4c_DispInfo.Refresh
2831:             ENDIF
2832:         CATCH TO loc_oErro

*-- Linhas 2883 a 2901:
2883:             THIS.lbl_4c_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item"
2884:         ENDIF
2885:         IF PEMSTATUS(THIS, "edt_4c_Obs", 5)
2886:             THIS.edt_4c_Obs.ControlSource = ""
2887:         ENDIF
2888:         IF PEMSTATUS(THIS, "img_4c_Figura", 5)
2889:             THIS.img_4c_Figura.Picture = ""
2890:             THIS.img_4c_Figura.Visible = .F.
2891:         ENDIF
2892:         IF PEMSTATUS(THIS, "cnt_4c_Info", 5)
2893:             THIS.cnt_4c_Info.txt_4c_TotQtdInfo.Value = 0
2894:             THIS.cnt_4c_Info.txt_4c_TotEstInfo.Value = 0
2895:             THIS.cnt_4c_Info.txt_4c_TotPrzInfo.Value = 0
2896:             THIS.cnt_4c_Info.txt_4c_DGrupoInfo.Value = ""
2897:             THIS.cnt_4c_Info.txt_4c_DContaInfo.Value = ""
2898:         ENDIF
2899:     ENDPROC
2900: 
2901:     *==========================================================================

*-- Linhas 2910 a 2928:
2910:         loc_nPrz = 0
2911:         TRY
2912:             IF USED("TmpFinal")
2913:                 SELECT TmpFinal
2914:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2915:                 GO TOP
2916:             ENDIF
2917:             IF PEMSTATUS(THIS, "txt_4c_TotQtd", 5)
2918:                 THIS.txt_4c_TotQtd.Value = loc_nSal
2919:                 THIS.txt_4c_TotEst.Value = loc_nEst
2920:                 THIS.txt_4c_TotPrz.Value = loc_nPrz
2921:             ENDIF
2922:             IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
2923:                 THIS.grd_4c_Itens.Refresh
2924:             ENDIF
2925:             IF USED("TmpSaldG") AND PEMSTATUS(THIS, "cnt_4c_Info", 5)
2926:                 THIS.cnt_4c_Info.grd_4c_DispInfo.Refresh
2927:             ENDIF
2928:         CATCH TO loc_oErro

