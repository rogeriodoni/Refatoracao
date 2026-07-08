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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2980 linhas total):

*-- Linhas 336 a 354:
336:             .FontSize          = 8
337:             .AllowHeaderSizing = .F.
338:             .AllowRowSizing    = .F.
339:             .DeleteMark        = .F.
340:             .RecordMark        = .F.
341:             .Panel             = 1
342:             .RowHeight         = 17
343:             .ScrollBars        = 2
344:             .GridLineColor     = RGB(238,238,238)
345:             WITH .Column1
346:                 .Width              = 115
347:                 .Movable            = .F.
348:                 .Resizable          = .F.
349:                 .ReadOnly           = .T.
350:                 .Header1.Caption    = "Produto"
351:                 .Header1.FontName   = "Verdana"
352:                 .Header1.FontSize   = 8
353:                 .Header1.Alignment  = 2
354:                 .Header1.ForeColor  = RGB(36,84,155)

*-- Linhas 545 a 563:
545:                 .FontSize          = 8
546:                 .AllowHeaderSizing = .F.
547:                 .AllowRowSizing    = .F.
548:                 .DeleteMark        = .F.
549:                 .RecordMark        = .F.
550:                 .Panel             = 1
551:                 .RowHeight         = 16
552:                 .ScrollBars        = 2
553:                 .GridLineColor     = RGB(238,238,238)
554:                 WITH .Column1
555:                     .ColumnOrder        = 2
556:                     .Width              = 74
557:                     .Movable            = .F.
558:                     .Resizable          = .F.
559:                     .ReadOnly           = .T.
560:                     .Header1.Caption    = "Grupo"
561:                     .Header1.FontName   = "Verdana"
562:                     .Header1.FontSize   = 8
563:                     .Header1.Alignment  = 2

*-- Linhas 807 a 825:
807:                 .FontSize          = 8
808:                 .AllowHeaderSizing = .F.
809:                 .AllowRowSizing    = .F.
810:                 .DeleteMark        = .F.
811:                 .RecordMark        = .F.
812:                 .Panel             = 1
813:                 .RowHeight         = 16
814:                 .ScrollBars        = 2
815:                 .GridLineColor     = RGB(238,238,238)
816:                 WITH .Column1
817:                     .Width              = 108
818:                     .Movable            = .F.
819:                     .Resizable          = .F.
820:                     .ReadOnly           = .T.
821:                     .Header1.Caption    = "Produto"
822:                     .Header1.FontName   = "Verdana"
823:                     .Header1.FontSize   = 8
824:                     .Header1.Alignment  = 2
825:                     .Header1.ForeColor  = RGB(36,84,155)

*-- Linhas 1020 a 1038:
1020:                 .FontSize          = 8
1021:                 .AllowHeaderSizing = .F.
1022:                 .AllowRowSizing    = .F.
1023:                 .DeleteMark        = .F.
1024:                 .RecordMark        = .F.
1025:                 .RowHeight         = 16
1026:                 .ScrollBars        = 2
1027:                 .GridLineColor     = RGB(238,238,238)
1028:                 WITH .Column1
1029:                     .ColumnOrder        = 2
1030:                     .Width              = 80
1031:                     .Movable            = .F.
1032:                     .Resizable          = .F.
1033:                     .ReadOnly           = .T.
1034:                     .Header1.Caption    = "Grupo"
1035:                     .Header1.FontName   = "Verdana"
1036:                     .Header1.FontSize   = 8
1037:                     .Header1.Alignment  = 2
1038:                     .Header1.ForeColor  = RGB(36,84,155)

*-- Linhas 1285 a 1303:
1285:                 .FontSize          = 8
1286:                 .AllowHeaderSizing = .F.
1287:                 .AllowRowSizing    = .F.
1288:                 .DeleteMark        = .F.
1289:                 .RecordMark        = .F.
1290:                 .ReadOnly          = .T.
1291:                 .RowHeight         = 16
1292:                 .ScrollBars        = 2
1293:                 .GridLineColor     = RGB(238,238,238)
1294:                 WITH .Column1
1295:                     .Width              = 84
1296:                     .Movable            = .F.
1297:                     .Resizable          = .F.
1298:                     .ReadOnly           = .T.
1299:                     .Sparse             = .F.
1300:                     .Header1.Caption    = "Linha"
1301:                     .Header1.FontName   = "Verdana"
1302:                     .Header1.FontSize   = 8
1303:                     .Header1.Alignment  = 2

*-- Linhas 1429 a 1447:
1429:                 .Width             = 605
1430:                 .ColumnCount       = 5
1431:                 .FontSize          = 8
1432:                 .DeleteMark        = .F.
1433:                 .RecordMark        = .F.
1434:                 .RowHeight         = 16
1435:                 .ScrollBars        = 2
1436:                 .GridLineColor     = RGB(238,238,238)
1437:                 WITH .Column1
1438:                     .Width              = 108
1439:                     .Movable            = .F.
1440:                     .Resizable          = .F.
1441:                     .Header1.Caption    = "Produto"
1442:                     .Header1.FontName   = "Verdana"
1443:                     .Header1.FontSize   = 8
1444:                     .Header1.Alignment  = 2
1445:                     .Header1.ForeColor  = RGB(36,84,155)
1446:                     .Text1.FontSize     = 8
1447:                     .Text1.BorderStyle  = 0

*-- Linhas 1681 a 1789:
1681:     ENDPROC
1682: 
1683:     *==========================================================================
1684:     * InicializarDados - ControlSources, queries iniciais, totais
1685:     *==========================================================================
1686:     PROTECTED PROCEDURE InicializarDados()
1687:         LOCAL loc_lSucesso, loc_oErro, loc_nSal, loc_nEst, loc_nPrz, loc_lcQuery
1688:         loc_lSucesso = .F.
1689:         TRY
1690:             *-- ControlSources GradeItens (mapeamento exato do legado)
1691:             THIS.grd_4c_Itens.RecordSource = "TmpFinal"
1692:             WITH THIS.grd_4c_Itens
1693:                 .Column1.ControlSource   = "TmpFinal.Cpros"
1694:                 .Column2.ControlSource   = "TmpFinal.CodCors"
1695:                 .Column3.ControlSource   = "TmpFinal.Dopes"
1696:                 .Column4.ControlSource   = "TmpFinal.Numes"
1697:                 .Column5.ControlSource   = "TmpFinal.Saldo"
1698:                 .Column6.ControlSource   = "TmpFinal.Produzir"
1699:                 .Column7.ControlSource   = "TmpFinal.Estoque"
1700:                 .Column8.ControlSource   = "IIF(EMPTY(TmpFinal.Obsps),' ','*')"
1701:                 .Column9.ControlSource   = "TmpFinal.CodTams"
1702:             ENDWITH
1703: 
1704:             *-- Se TransfRes vazio, grid somente leitura
1705:             IF USED("crSigCdPam") .AND. NOT EOF("crSigCdPam")
1706:                 IF EMPTY(ALLTRIM(crSigCdPam.TransfRes))
1707:                     THIS.grd_4c_Itens.SetAll("ReadOnly", .T.)
1708:                 ENDIF
1709:             ENDIF
1710: 
1711:             *-- TmpSaldG para Container3
1712:             IF USED("TmpSaldG")
1713:                 SELECT TmpSaldG
1714:                 SET ORDER TO Cpros
1715:                 IF USED("TmpFinal") .AND. NOT EOF("TmpFinal")
1716:                     SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1717:                 ENDIF
1718:                 GO TOP
1719:             ENDIF
1720: 
1721:             THIS.cnt_4c_Info.grd_4c_DispInfo.RecordSource = "TmpSaldG"
1722:             WITH THIS.cnt_4c_Info.grd_4c_DispInfo
1723:                 .Column1.ControlSource   = "TmpSaldG.Grupos"
1724:                 .Column2.ControlSource   = "TmpSaldG.Estos"
1725:                 .Column3.ControlSource   = "TmpSaldG.Saldo"
1726:                 .Column4.ControlSource   = "TmpSaldG.Saldo - TmpSaldG.Disps"
1727:                 .Column5.ControlSource   = "TmpSaldG.Disps"
1728:                 .Column6.ControlSource   = "TmpSaldG.Emps"
1729:                 .SetAll("ReadOnly", .T.)
1730:             ENDWITH
1731: 
1732:             *-- Cursor de rastreamento de selecao manual
1733:             IF NOT USED("TmpSaldU")
1734:                 CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L)
1735:                 INDEX ON Cpros TAG Cpros
1736:             ENDIF
1737: 
1738:             *-- ControlSource do EditBox de observacoes
1739:             THIS.edt_4c_Obs.ControlSource = "TmpFinal.Obsps"
1740: 
1741:             *-- Calcular totais iniciais
1742:             loc_nSal = 0
1743:             loc_nEst = 0
1744:             loc_nPrz = 0
1745:             IF USED("TmpFinal")
1746:                 SELECT TmpFinal
1747:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
1748:                 GO TOP
1749:             ENDIF
1750:             THIS.txt_4c_TotQtd.Value = loc_nSal
1751:             THIS.txt_4c_TotEst.Value = loc_nEst
1752:             THIS.txt_4c_TotPrz.Value = loc_nPrz
1753: 
1754:             *-- Carregar SigCdTpc + SigCdCom -> crSigCdCom
1755:             IF NOT USED("crSigCdCom")
1756:                 loc_lcQuery = "SELECT a.Tipos, a.Custos, b.CGrus " + ;
1757:                               "FROM SigCdTpc a, SigCdCom b " + ;
1758:                               "WHERE a.Tipos = b.Tipos"
1759:                 IF SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdCom") > 0
1760:                     SELECT crSigCdCom
1761:                     INDEX ON Tipos + CGrus TAG Tipos
1762:                 ELSE
1763:                     MsgErro("Falha ao carregar SigCdCom.", "Erro")
1764:                 ENDIF
1765:             ENDIF
1766: 
1767:             *-- SigKey do pacote (usado em GravaHistorico)
1768:             IF USED("CrSigCdPac") .AND. NOT EOF("CrSigCdPac")
1769:                 THIS.this_oBusinessObject.this_cSigKey = CrSigCdPac.sigKeys
1770:             ENDIF
1771: 
1772:             *-- SelPedra: garantir pelo menos um registro
1773:             IF USED("SelPedra") .AND. RECCOUNT("SelPedra") = 0
1774:                 SELECT SelPedra
1775:                 APPEND BLANK
1776:             ENDIF
1777: 
1778:             loc_lSucesso = .T.
1779:         CATCH TO loc_oErro
1780:             MsgErro("Erro ao inicializar dados: " + loc_oErro.Message + ;
1781:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
1782:         ENDTRY
1783:         RETURN loc_lSucesso
1784:     ENDPROC
1785: 
1786:     *==========================================================================
1787:     * AjustarBotaoPedras - habilitar apenas se parametros completos
1788:     *==========================================================================
1789:     PROTECTED PROCEDURE AjustarBotaoPedras()

*-- Linhas 1854 a 1872:
1854:             =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
1855: 
1856:             IF USED("TmpSaldG")
1857:                 SELECT TmpSaldG
1858:                 SET ORDER TO Cpros
1859:                 SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1860:                 GO TOP
1861:             ENDIF
1862: 
1863:             WITH THIS.cnt_4c_Info
1864:                 .txt_4c_TotQtdInfo.Value = TmpSaldo.Saldo
1865:                 .txt_4c_TotEstInfo.Value = TmpSaldo.Saldo - TmpSaldo.Disps
1866:                 .txt_4c_TotPrzInfo.Value = TmpSaldo.Disps
1867:                 .lbl_4c_TituloInfo.Caption = TmpFinal.Cpros + ;
1868:                     IIF(NOT EMPTY(TmpFinal.CodCors), " Cor:" + TmpFinal.CodCors, "") + ;
1869:                     IIF(NOT EMPTY(TmpFinal.CodTams), " Tam:" + TmpFinal.CodTams, "")
1870: 
1871:                 IF THIS.this_oBusinessObject.AtualizarInfoItem(par_nColIndex)
1872:                     .txt_4c_DGrupoInfo.Value = THIS.this_oBusinessObject.this_cDscGrupo

*-- Linhas 1881 a 1936:
1881:             CLEAR RESOURCES
1882:             THIS.img_4c_Figura.Picture = ""
1883:             THIS.img_4c_Figura.Visible = .F.
1884:             IF SQLEXEC(gnConnHandle, "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(TmpFinal.CPros)), "crSigProFig") > 0
1885:                 IF NOT EOF("crSigProFig")
1886:                     IF NOT EMPTY(crSigProFig.FigJpgs) .AND. NOT ISNULL(crSigProFig.FigJpgs)
1887:                         loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(crSigProFig.FigJpgs, ;
1888:                             "data:image/png;base64,", ""), ;
1889:                             "data:image/jpeg;base64,", ""), ;
1890:                             "data:image/jpg;base64,", ""), 14)
1891:                         IF STRTOFILE(loc_lcFoto, loc_lcArquivo) > 0
1892:                             THIS.img_4c_Figura.Picture = loc_lcArquivo
1893:                             THIS.img_4c_Figura.Visible = .T.
1894:                         ENDIF
1895:                     ENDIF
1896:                 ENDIF
1897:                 USE IN crSigProFig
1898:             ENDIF
1899: 
1900:             SELECT TmpFinal
1901:         CATCH TO loc_oErro
1902:             MsgErro(loc_oErro.Message, "Erro")
1903:         ENDTRY
1904:     ENDPROC
1905: 
1906:     PROCEDURE GradeItensRedirFoco()
1907:         THIS.grd_4c_Itens.Column6.Text1.SetFocus
1908:     ENDPROC
1909: 
1910:     PROCEDURE GradeDispProdRedirFoco()
1911:         THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.SetFocus
1912:     ENDPROC
1913: 
1914:     PROCEDURE GradeItensColumn6When()
1915:         LOCAL loc_oErro
1916:         THIS.this_oBusinessObject.this_nOldValue = THIS.grd_4c_Itens.Column6.Text1.Value
1917:         IF THIS.this_lReserva .AND. (TmpFinal.Estoque = 0)
1918:             TRY
1919:                 IF SQLEXEC(gnConnHandle, "SELECT CGrus FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(TmpFinal.CPros)), "crTmpPro") > 0
1920:                     IF NOT EOF("crTmpPro")
1921:                         IF SQLEXEC(gnConnHandle, "SELECT TipoEstos FROM SigCdGrp WHERE CGrus = " + EscaparSQL(ALLTRIM(crTmpPro.CGrus)), "crTmpGru") > 0
1922:                             IF NOT EOF("crTmpGru")
1923:                                 IF INLIST(crTmpGru.TipoEstos, 3, 4)
1924:                                     THIS.cmd_4c_Disponiveis.Enabled = .T.
1925:                                 ENDIF
1926:                             ENDIF
1927:                             USE IN crTmpGru
1928:                         ENDIF
1929:                     ENDIF
1930:                     USE IN crTmpPro
1931:                 ENDIF
1932:             CATCH TO loc_oErro
1933:                 MsgErro(loc_oErro.Message, "Erro")
1934:             ENDTRY
1935:         ENDIF
1936:         RETURN .T.

*-- Linhas 1942 a 1960:
1942:         loc_nNovoValor = THIS.grd_4c_Itens.Column6.Text1.Value
1943:         TRY
1944:             IF NOT SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
1945:                 INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
1946:             ENDIF
1947:             IF loc_nNovoValor <> THIS.this_oBusinessObject.this_nOldValue .AND. TmpSaldU.KeySelm
1948:                 IF NOT MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque. " + CHR(13) + ;
1949:                     "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?")
1950:                     THIS.grd_4c_Itens.Column6.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
1951:                     loc_lResultado = .F.
1952:                 ENDIF
1953:             ENDIF
1954:             IF loc_lResultado
1955:                 DO CASE
1956:                     CASE loc_nNovoValor = THIS.this_oBusinessObject.this_nOldValue
1957:                         *-- nenhuma mudanca
1958:                     CASE loc_nNovoValor < 0
1959:                         MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", "")
1960:                         THIS.grd_4c_Itens.Column6.Text1.Value = THIS.this_oBusinessObject.this_nOldValue

*-- Linhas 1973 a 1993:
1973:                             REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps + TmpFinal.Estoque - (TmpFinal.Saldo - TmpFinal.Produzir) IN TmpSaldo
1974:                             REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - loc_nNovoValor IN TmpFinal
1975:                             REPLACE KeySelm WITH .F. IN TmpSaldU
1976:                             SELECT TmpSaldo
1977:                             loc_xBaixa = TmpSaldo.Saldo - TmpSaldo.Disps
1978:                             SELECT TmpSaldG
1979:                             SET ORDER TO Cpros
1980:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
1981:                             REPLACE Disps WITH Saldo WHILE Cpros = TmpSaldo.Cpros .AND. ;
1982:                                 CodCors = TmpSaldo.CodCors .AND. CodTams = TmpSaldo.CodTams
1983:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
1984:                             SCAN WHILE Cpros = TmpSaldo.Cpros .AND. CodCors = TmpSaldo.CodCors .AND. ;
1985:                                 CodTams = TmpSaldo.CodTams .AND. loc_xBaixa > 0
1986:                                 IF TmpSaldG.Disps >= loc_xBaixa
1987:                                     REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_xBaixa
1988:                                     loc_xBaixa = 0
1989:                                 ELSE
1990:                                     loc_xBaixa = loc_xBaixa - TmpSaldG.Disps
1991:                                     REPLACE TmpSaldG.Disps WITH 0
1992:                                 ENDIF
1993:                             ENDSCAN

*-- Linhas 2011 a 2029:
2011:         ENDIF
2012:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_oErro
2013:         TRY
2014:             SELECT TmpFinal
2015:             loc_nRecno = RECNO()
2016:             SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2017:             GO loc_nRecno
2018:             THIS.txt_4c_TotQtd.Value = loc_nSal
2019:             THIS.txt_4c_TotEst.Value = loc_nEst
2020:             THIS.txt_4c_TotPrz.Value = loc_nPrz
2021:             THIS.txt_4c_TotQtd.Refresh
2022:             THIS.txt_4c_TotEst.Refresh
2023:             THIS.txt_4c_TotPrz.Refresh
2024:             THIS.Refresh
2025:         CATCH TO loc_oErro
2026:             MsgErro(loc_oErro.Message, "Erro")
2027:         ENDTRY
2028:     ENDPROC
2029: 

*-- Linhas 2142 a 2164:
2142:                     .Column3.Header1.Caption = "Tam"
2143:                     .Column4.Header1.Caption = "Disponivel"
2144:                     .Column5.Header1.Caption = "Utilizar"
2145:                     .Column1.ControlSource   = "TmpDisp.Cpros"
2146:                     .Column2.ControlSource   = "TmpDisp.CodCors"
2147:                     .Column3.ControlSource   = "TmpDisp.CodTams"
2148:                     .Column4.ControlSource   = "TmpDisp.Disps"
2149:                     .Column5.ControlSource   = "TmpDisp.Utilizar"
2150:                 ENDWITH
2151:                 THIS.cnt_4c_Disponivel.txt_4c_PedidaDisp.Value = TmpFinal.Saldo
2152:                 THIS.grd_4c_Itens.Enabled        = .F.
2153:                 THIS.cmd_4c_Processar.Enabled    = .F.
2154:                 THIS.cmd_4c_Cancelar.Enabled     = .F.
2155:                 THIS.cmd_4c_LinhasTot.Enabled    = .F.
2156:                 THIS.cmd_4c_Disponiveis.Enabled  = .F.
2157:                 THIS.cnt_4c_Info.Enabled         = .F.
2158:                 THIS.cnt_4c_Disponivel.Visible   = .T.
2159:                 THIS.cnt_4c_Disponivel.ZOrder(0)
2160:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Refresh
2161:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.SetFocus
2162:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Refresh
2163:             ENDIF
2164:         CATCH TO loc_oErro

*-- Linhas 2174 a 2195:
2174:             THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.ColumnCount = 4
2175:             THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.RecordSource = "TmpLinha"
2176:             WITH THIS.cnt_4c_Linhas.grd_4c_LinhasAgg
2177:                 .Column1.ControlSource = "TmpLinha.Linhas"
2178:                 .Column2.ControlSource = "TmpLinha.Saldo"
2179:                 .Column3.ControlSource = "TmpLinha.Estoque"
2180:                 .Column4.ControlSource = "TmpLinha.Produzir"
2181:                 .SetAll("DynamicFontBold",  "TmpLinha.Linhas=[TOTAIS]",                              "Column")
2182:                 .SetAll("DynamicForeColor", "IIF(TmpLinha.Linhas=[TOTAIS],RGB(0,0,255),RGB(0,0,0))", "Column")
2183:             ENDWITH
2184:             THIS.cmd_4c_Processar.Enabled   = .F.
2185:             THIS.cmd_4c_Cancelar.Enabled    = .F.
2186:             THIS.cmd_4c_LinhasTot.Enabled   = .F.
2187:             THIS.cmd_4c_Requisicoes.Enabled = .F.
2188:             THIS.cmd_4c_Disponiveis.Enabled = .F.
2189:             THIS.grd_4c_Itens.Enabled       = .F.
2190:             THIS.cnt_4c_Info.Enabled        = .F.
2191:             THIS.cnt_4c_Linhas.Visible      = .T.
2192:             THIS.cnt_4c_Linhas.ZOrder(0)
2193:             THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.Refresh
2194:             THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.Column1.SetFocus
2195:         CATCH TO loc_oErro

*-- Linhas 2204 a 2226:
2204:             THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.ColumnCount = 5
2205:             THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.RecordSource = "SelPedra"
2206:             WITH THIS.cnt_4c_Requisicoes.grd_4c_PedraReq
2207:                 .Column1.ControlSource = "SelPedra.Cpros"
2208:                 .Column2.ControlSource = "SelPedra.Dpros"
2209:                 .Column3.ControlSource = "SelPedra.Cunis"
2210:                 .Column4.ControlSource = "SelPedra.Qtds"
2211:                 .Column5.ControlSource = "SelPedra.Cpro2s"
2212:             ENDWITH
2213:             THIS.cmd_4c_Processar.Enabled    = .F.
2214:             THIS.cmd_4c_Cancelar.Enabled     = .F.
2215:             THIS.cmd_4c_LinhasTot.Enabled    = .F.
2216:             THIS.cmd_4c_Requisicoes.Enabled  = .F.
2217:             THIS.cmd_4c_Disponiveis.Enabled  = .F.
2218:             THIS.grd_4c_Itens.Enabled        = .F.
2219:             THIS.cnt_4c_Info.Enabled         = .F.
2220:             THIS.cnt_4c_Requisicoes.Visible  = .T.
2221:             THIS.cnt_4c_Requisicoes.ZOrder(0)
2222:             THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Refresh
2223:             THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.SetFocus
2224:         CATCH TO loc_oErro
2225:             MsgErro(loc_oErro.Message, "Erro")
2226:         ENDTRY

*-- Linhas 2248 a 2270:
2248:                     .Column3.Header1.Caption = "Prioridade"
2249:                     .Column4.Header1.Caption = "Disponivel"
2250:                     .Column5.Header1.Caption = "Utilizar"
2251:                     .Column1.ControlSource   = "TmpDisp.Grupos"
2252:                     .Column2.ControlSource   = "TmpDisp.Estos"
2253:                     .Column3.ControlSource   = "TmpDisp.Priors"
2254:                     .Column4.ControlSource   = "TmpDisp.Disps"
2255:                     .Column5.ControlSource   = "TmpDisp.Utilizar"
2256:                 ENDWITH
2257:                 THIS.cnt_4c_Estoques.lbl_4c_TituloEstq.Caption = ;
2258:                     "Estoque Dispon" + CHR(237) + "vel (" + TmpFinal.Cpros + " " + TmpFinal.CodCors + "/" + TmpFinal.CodTams + ")"
2259:                 THIS.cnt_4c_Estoques.txt_4c_PedidaEstq.Value = TmpFinal.Saldo - TmpFinal.Estoque
2260:                 THIS.cnt_4c_Estoques.txt_4c_SelecEstq.Value  = 0
2261:                 THIS.cmd_4c_Processar.Enabled    = .F.
2262:                 THIS.cmd_4c_Cancelar.Enabled     = .F.
2263:                 THIS.cmd_4c_LinhasTot.Enabled    = .F.
2264:                 THIS.cmd_4c_Disponiveis.Enabled  = .F.
2265:                 THIS.cmd_4c_Estoques.Enabled     = .F.
2266:                 THIS.cmd_4c_Requisicoes.Enabled  = .F.
2267:                 THIS.cnt_4c_Info.Enabled         = .F.
2268:                 THIS.cnt_4c_Estoques.Visible     = .T.
2269:                 THIS.cnt_4c_Estoques.ZOrder(0)
2270:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Refresh

*-- Linhas 2312 a 2330:
2312:                 THIS.grd_4c_Itens.Refresh
2313:                 THIS.cnt_4c_Info.grd_4c_DispInfo.Refresh
2314:                 IF USED("TmpFinal")
2315:                     SELECT TmpFinal
2316:                     SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2317:                     THIS.txt_4c_TotQtd.Value = loc_nSal
2318:                     THIS.txt_4c_TotEst.Value = loc_nEst
2319:                     THIS.txt_4c_TotPrz.Value = loc_nPrz
2320:                 ENDIF
2321:             ENDIF
2322:         CATCH TO loc_oErro
2323:             MsgErro(loc_oErro.Message, "Erro")
2324:         ENDTRY
2325:     ENDPROC
2326: 
2327:     *-- Cancelar.Click: fechar form sem processar
2328:     PROCEDURE CmdCancelarClick()
2329:         LOCAL loc_oErro
2330:         TRY

*-- Linhas 2343 a 2361:
2343:         TRY
2344:             THIS.this_oBusinessObject.ConfirmarDisponivelSimples()
2345:             IF USED("TmpFinal")
2346:                 SELECT TmpFinal
2347:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2348:                 THIS.txt_4c_TotQtd.Value = loc_nSal
2349:                 THIS.txt_4c_TotEst.Value = loc_nEst
2350:                 THIS.txt_4c_TotPrz.Value = loc_nPrz
2351:             ENDIF
2352:         CATCH TO loc_oErro
2353:             MsgErro(loc_oErro.Message, "Erro")
2354:         ENDTRY
2355:         THIS.cmd_4c_Processar.Enabled    = .T.
2356:         THIS.cmd_4c_Cancelar.Enabled     = .T.
2357:         THIS.cmd_4c_LinhasTot.Enabled    = .T.
2358:         THIS.cmd_4c_Estoques.Enabled     = .T.
2359:         THIS.cmd_4c_Disponiveis.Enabled  = .T.
2360:         THIS.cnt_4c_Info.Enabled         = .T.
2361:         THIS.cnt_4c_Estoques.Visible     = .F.

*-- Linhas 2423 a 2449:
2423:         TRY
2424:             loc_lcValor = ALLTRIM(TRANSFORM(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value))
2425:             IF NOT EMPTY(loc_lcValor)
2426:                 IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CPros, DPros, Cunis FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_lcValor), "crProLookup") > 0
2427:                     IF NOT EOF("crProLookup")
2428:                         THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value = crProLookup.Cpros
2429:                         REPLACE SelPedra.Dpros WITH crProLookup.DPros, ;
2430:                                 SelPedra.Cunis WITH crProLookup.Cunis IN SelPedra
2431:                         USE IN crProLookup
2432:                     ELSE
2433:                         USE IN crProLookup
2434:                         IF SQLEXEC(gnConnHandle, "SELECT CPros, DPros FROM SigCdPro WHERE CPros LIKE " + EscaparSQL(loc_lcValor + "%"), "cursor_4c_BuscaPro") > 0
2435:                             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
2436:                             IF VARTYPE(loc_oForm) = "O"
2437:                                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaPro"
2438:                                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2439:                                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2440:                                 loc_oForm.Show()
2441:                                 IF loc_oForm.this_lSelecionou
2442:                                     THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value = cursor_4c_BuscaPro.Cpros
2443:                                     REPLACE SelPedra.Dpros WITH cursor_4c_BuscaPro.DPros, ;
2444:                                             SelPedra.Cunis WITH cursor_4c_BuscaPro.Cunis IN SelPedra
2445:                                 ENDIF
2446:                             ENDIF
2447:                         ENDIF
2448:                         IF USED("cursor_4c_BuscaPro")
2449:                             USE IN cursor_4c_BuscaPro

*-- Linhas 2472 a 2496:
2472:         TRY
2473:             loc_lcValor = ALLTRIM(TRANSFORM(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value))
2474:             IF NOT EMPTY(loc_lcValor)
2475:                 IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_lcValor), "crProLookup2") > 0
2476:                     IF NOT EOF("crProLookup2")
2477:                         THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value = crProLookup2.Cpros
2478:                         USE IN crProLookup2
2479:                     ELSE
2480:                         USE IN crProLookup2
2481:                         IF SQLEXEC(gnConnHandle, "SELECT CPros, DPros FROM SigCdPro WHERE CPros LIKE " + EscaparSQL(loc_lcValor + "%"), "cursor_4c_BuscaPro2") > 0
2482:                             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
2483:                             IF VARTYPE(loc_oForm) = "O"
2484:                                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaPro2"
2485:                                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2486:                                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2487:                                 loc_oForm.Show()
2488:                                 IF loc_oForm.this_lSelecionou
2489:                                     THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value = cursor_4c_BuscaPro2.Cpros
2490:                                 ENDIF
2491:                             ENDIF
2492:                         ENDIF
2493:                         IF USED("cursor_4c_BuscaPro2")
2494:                             USE IN cursor_4c_BuscaPro2
2495:                         ENDIF
2496:                     ENDIF

*-- Linhas 2511 a 2529:
2511:         ENDIF
2512:         LOCAL loc_xPos, loc_oErro
2513:         TRY
2514:             SELECT SelPedra
2515:             loc_xPos = RECNO()
2516:             LOCATE FOR EMPTY(Cpros)
2517:             IF EOF()
2518:                 APPEND BLANK
2519:             ENDIF
2520:             LOCATE FOR RECNO() = loc_xPos
2521:             KEYBOARD "{DNARROW}"
2522:         CATCH TO loc_oErro
2523:             MsgErro(loc_oErro.Message, "Erro")
2524:         ENDTRY
2525:     ENDPROC
2526: 
2527:     *-- img_4c_Figura DblClick: zoom da imagem
2528:     PROCEDURE ImgFiguraDblClick()
2529:         IF NOT EMPTY(THIS.img_4c_Figura.Picture)

*-- Linhas 2685 a 2703:
2685:         TRY
2686:             THIS.AlternarPagina(1)
2687:             IF USED("cursor_4c_ItensFinal") AND RECCOUNT("cursor_4c_ItensFinal") > 0
2688:                 SELECT cursor_4c_ItensFinal
2689:                 GO TOP
2690:             ENDIF
2691:             IF PEMSTATUS(THIS, "grd_4c_Itens", 5) AND THIS.grd_4c_Itens.Visible
2692:                 THIS.grd_4c_Itens.Refresh
2693:                 IF THIS.grd_4c_Itens.ColumnCount >= 6
2694:                     THIS.grd_4c_Itens.Column6.Text1.SetFocus
2695:                 ENDIF
2696:             ENDIF
2697:         CATCH TO loc_oErro
2698:             MsgErro("Erro em BtnAlterarClick: " + loc_oErro.Message + ;
2699:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2700:         ENDTRY
2701:     ENDPROC
2702: 
2703:     *--------------------------------------------------------------------------

*-- Linhas 2710 a 2728:
2710:         TRY
2711:             THIS.AlternarPagina(6)
2712:             IF USED("cursor_4c_ItensFinal") AND RECCOUNT("cursor_4c_ItensFinal") > 0
2713:                 SELECT cursor_4c_ItensFinal
2714:                 THIS.GradeItensAfterRowColChange(1)
2715:             ENDIF
2716:         CATCH TO loc_oErro
2717:             MsgErro("Erro em BtnVisualizarClick: " + loc_oErro.Message + ;
2718:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2719:         ENDTRY
2720:     ENDPROC
2721: 
2722:     *--------------------------------------------------------------------------
2723:     * BtnExcluirClick - Cancela o processamento e encerra o formulario
2724:     * Faz rollback da transacao aberta pelo Init e libera o form pai.
2725:     * Equivalente a acao do botao Cancelar (Sair) da barra superior.
2726:     *--------------------------------------------------------------------------
2727:     PROCEDURE BtnExcluirClick()
2728:         LOCAL loc_oErro

*-- Linhas 2816 a 2834:
2816:             loc_nEst = 0
2817:             loc_nPrz = 0
2818:             IF USED("TmpFinal")
2819:                 SELECT TmpFinal
2820:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2821:                 GO TOP
2822:             ENDIF
2823:             IF PEMSTATUS(THIS, "txt_4c_TotQtd", 5)
2824:                 THIS.txt_4c_TotQtd.Value = loc_nSal
2825:                 THIS.txt_4c_TotEst.Value = loc_nEst
2826:                 THIS.txt_4c_TotPrz.Value = loc_nPrz
2827:             ENDIF
2828:             IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
2829:                 THIS.grd_4c_Itens.Refresh
2830:             ENDIF
2831:             IF PEMSTATUS(THIS, "cnt_4c_Info", 5)
2832:                 THIS.cnt_4c_Info.grd_4c_DispInfo.Refresh
2833:             ENDIF
2834:         CATCH TO loc_oErro

*-- Linhas 2885 a 2903:
2885:             THIS.lbl_4c_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item"
2886:         ENDIF
2887:         IF PEMSTATUS(THIS, "edt_4c_Obs", 5)
2888:             THIS.edt_4c_Obs.ControlSource = ""
2889:         ENDIF
2890:         IF PEMSTATUS(THIS, "img_4c_Figura", 5)
2891:             THIS.img_4c_Figura.Picture = ""
2892:             THIS.img_4c_Figura.Visible = .F.
2893:         ENDIF
2894:         IF PEMSTATUS(THIS, "cnt_4c_Info", 5)
2895:             THIS.cnt_4c_Info.txt_4c_TotQtdInfo.Value = 0
2896:             THIS.cnt_4c_Info.txt_4c_TotEstInfo.Value = 0
2897:             THIS.cnt_4c_Info.txt_4c_TotPrzInfo.Value = 0
2898:             THIS.cnt_4c_Info.txt_4c_DGrupoInfo.Value = ""
2899:             THIS.cnt_4c_Info.txt_4c_DContaInfo.Value = ""
2900:         ENDIF
2901:     ENDPROC
2902: 
2903:     *==========================================================================

*-- Linhas 2912 a 2930:
2912:         loc_nPrz = 0
2913:         TRY
2914:             IF USED("TmpFinal")
2915:                 SELECT TmpFinal
2916:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2917:                 GO TOP
2918:             ENDIF
2919:             IF PEMSTATUS(THIS, "txt_4c_TotQtd", 5)
2920:                 THIS.txt_4c_TotQtd.Value = loc_nSal
2921:                 THIS.txt_4c_TotEst.Value = loc_nEst
2922:                 THIS.txt_4c_TotPrz.Value = loc_nPrz
2923:             ENDIF
2924:             IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
2925:                 THIS.grd_4c_Itens.Refresh
2926:             ENDIF
2927:             IF USED("TmpSaldG") AND PEMSTATUS(THIS, "cnt_4c_Info", 5)
2928:                 THIS.cnt_4c_Info.grd_4c_DispInfo.Refresh
2929:             ENDIF
2930:         CATCH TO loc_oErro

