# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [SQL-ASPAS] Linha 194: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.CPros = '" + loc_cMats + "' AND " + ;
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CAMPO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OPZERS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg) - TRECHOS RELEVANTES PARA PASS SQL (2910 linhas total):

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

*-- Linhas 180 a 210:
180:                 .Width     = THIS.Width
181:                 .Height    = 40
182:                 .FontBold  = .T.
183:                 .FontName  = "Tahoma"
184:                 .FontSize  = 18
185:                 .BackStyle = 0
186:                 .ForeColor = RGB(0, 0, 0)
187:                 .Caption   = " "
188:             ENDWITH
189: 
190:             .AddObject("lbl_4c_Titulo", "Label")
191:             WITH .lbl_4c_Titulo
192:                 .AutoSize  = .F.
193:                 .Top       = 17
194:                 .Left      = 10
195:                 .Width     = THIS.Width
196:                 .Height    = 46
197:                 .FontBold  = .T.
198:                 .FontName  = "Tahoma"
199:                 .FontSize  = 18
200:                 .BackStyle = 0
201:                 .ForeColor = RGB(255, 255, 255)
202:                 .Caption   = " "
203:             ENDWITH
204:         ENDWITH
205:     ENDPROC
206: 
207:     *==========================================================================
208:     PROTECTED PROCEDURE ConfigurarLayout
209:     *==========================================================================
210:         LOCAL loc_cImgProcessar, loc_cImgCancelar, loc_cImgRelatorio

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
1460:         WITH THIS.cnt_4c_Container3.grd_4c_Dados
1461:             .RecordSource = "TmpSaldG"
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
1536:             WITH THIS.grd_4c_Dados
1537:                 .RecordSource = "TmpFinal"
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
1568:             WITH THIS.cnt_4c_Container3.grd_4c_Dados
1569:                 .RecordSource = "TmpSaldG"
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
1592:             IF INLIST(loc_oCtrl.Name, ;
1593:                       "cnt_4c_Container1", ;
1594:                       "cnt_4c_Container2", ;
1595:                       "cnt_4c_Container4", ;
1596:                       "cnt_4c_Container5", ;
1597:                       "img_4c_ImgFigJpg")

*-- Linhas 1652 a 1688:
1652:                     USE IN TmpDisp
1653:                 ENDIF
1654: 
1655:                 SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
1656:                   FROM TmpSaldo ;
1657:                  WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND Disps > 0 ;
1658:                  ORDER BY Cpros, CodCors, CodTams ;
1659:                   INTO CURSOR TmpDisp READWRITE
1660: 
1661:                 THIS.grd_4c_Dados.Enabled = .F.
1662: 
1663:                 IF _Tally = 0
1664:                     MsgAviso("N" + CHR(227) + "o Existe Estoque Dispon" + CHR(237) + "vel Em Nenhum Tamanho!!!", "")
1665:                     THIS.BtnCancelaDisp2Click()
1666:                 ELSE
1667:                     WITH THIS.cnt_4c_Container2.grd_4c_Dados
1668:                         .RecordSource = "TmpDisp"
1669:                         .Column1.ControlSource = "TmpDisp.Cpros"
1670:                         .Column2.ControlSource = "TmpDisp.CodCors"
1671:                         .Column3.ControlSource = "TmpDisp.CodTams"
1672:                         .Column4.ControlSource = "TmpDisp.Disps"
1673:                         .Column5.ControlSource = "TmpDisp.Utilizar"
1674:                     ENDWITH
1675: 
1676:                     WITH THIS.cnt_4c_Container2
1677:                         .txt_4c_Qt_pedida.Value = TmpFinal.Saldo
1678:                         .txt_4c_Qt_Selec.Value  = 0
1679:                         .Visible     = .T.
1680:                     ENDWITH
1681: 
1682:                     THIS.cmd_4c_Processar.Enabled  = .F.
1683:                     THIS.cmd_4c_Cancelar.Enabled   = .F.
1684:                     THIS.cmd_4c_TotLinha.Enabled   = .F.
1685:                     THIS.cmd_4c_Pedras.Enabled     = .F.
1686:                     THIS.cmd_4c_Disponivel.Enabled = .F.
1687:                     THIS.cnt_4c_Container3.Enabled = .F.
1688:                     THIS.cnt_4c_Container2.Visible = .T.

*-- Linhas 1703 a 1736:
1703:                 USE IN TmpLinha
1704:             ENDIF
1705: 
1706:             SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
1707:               FROM TmpFinal ;
1708:              GROUP BY 1 ;
1709:              UNION ALL ;
1710:             SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
1711:               FROM TmpFinal ;
1712:              GROUP BY 1 ;
1713:               INTO CURSOR TmpLinha ;
1714:              ORDER BY 2, 1
1715: 
1716:             WITH THIS.cnt_4c_Container1.grd_4c_Dados
1717:                 .RecordSource = "TmpLinha"
1718:                 .Column1.ControlSource = "TmpLinha.Linhas"
1719:                 .Column2.ControlSource = "TmpLinha.Saldo"
1720:                 .Column3.ControlSource = "TmpLinha.Estoque"
1721:                 .Column4.ControlSource = "TmpLinha.Produzir"
1722:                 .SetAll("DynamicFontBold",  "TmpLinha.Linhas = [TOTAIS]", "Column")
1723:                 .SetAll("DynamicForeColor", "IIF(TmpLinha.Linhas = [TOTAIS], RGB(0,0,255), RGB(0,0,0))", "Column")
1724:             ENDWITH
1725: 
1726:             THIS.cmd_4c_Processar.Enabled  = .F.
1727:             THIS.cmd_4c_Cancelar.Enabled   = .F.
1728:             THIS.cmd_4c_TotLinha.Enabled   = .F.
1729:             THIS.cmd_4c_Pedras.Enabled     = .F.
1730:             THIS.cmd_4c_Disponivel.Enabled = .F.
1731:             THIS.grd_4c_Dados.Enabled      = .F.
1732:             THIS.cnt_4c_Container3.Enabled = .F.
1733:             THIS.cnt_4c_Container1.Visible = .T.
1734:             THIS.cnt_4c_Container1.ZOrder
1735:             THIS.cnt_4c_Container1.grd_4c_Dados.Refresh
1736:             THIS.cnt_4c_Container1.grd_4c_Dados.Column1.SetFocus

*-- Linhas 1747 a 1769:
1747: 
1748:             WITH THIS.cnt_4c_Container4.grd_4c_Dados
1749:                 .RecordSource = "SelPedra"
1750:                 .Column1.ControlSource = "SelPedra.Cpros"
1751:                 .Column2.ControlSource = "SelPedra.Dpros"
1752:                 .Column3.ControlSource = "SelPedra.Cunis"
1753:                 .Column4.ControlSource = "SelPedra.Qtds"
1754:                 .Column5.ControlSource = "SelPedra.Cpro2s"
1755:             ENDWITH
1756: 
1757:             THIS.cmd_4c_Processar.Enabled  = .F.
1758:             THIS.cmd_4c_Cancelar.Enabled   = .F.
1759:             THIS.cmd_4c_TotLinha.Enabled   = .F.
1760:             THIS.cmd_4c_Pedras.Enabled     = .F.
1761:             THIS.cmd_4c_Disponivel.Enabled = .F.
1762:             THIS.grd_4c_Dados.Enabled      = .F.
1763:             THIS.cnt_4c_Container3.Enabled = .F.
1764:             THIS.cnt_4c_Container4.Visible = .T.
1765:             THIS.cnt_4c_Container4.ZOrder
1766:             THIS.cnt_4c_Container4.grd_4c_Dados.Refresh
1767:             THIS.cnt_4c_Container4.grd_4c_Dados.Column1.SetFocus
1768:         CATCH TO loc_oErro
1769:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 1784 a 1823:
1784:                     USE IN TmpDisp
1785:                 ENDIF
1786: 
1787:                 SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
1788:                        000000000.000 AS Utilizar ;
1789:                   FROM TmpSaldG ;
1790:                  WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND CodTams = m.loc_cTam AND Disps > 0 ;
1791:                   INTO CURSOR Resultado ORDER BY 1, 2, 3, 4
1792:                 SELECT 0
1793:                 USE DBF("Resultado") ALIAS TmpDisp AGAIN
1794:                 USE IN Resultado
1795: 
1796:                 THIS.grd_4c_Dados.Enabled = .F.
1797: 
1798:                 IF _Tally = 0
1799:                     MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "")
1800:                     THIS.BtnCancelaDisp5Click()
1801:                 ELSE
1802:                     WITH THIS.cnt_4c_Container5.grd_4c_Dados
1803:                         .RecordSource = "TmpDisp"
1804:                         .Column1.ControlSource = "TmpDisp.Grupos"
1805:                         .Column2.ControlSource = "TmpDisp.Estos"
1806:                         .Column3.ControlSource = "TmpDisp.Priors"
1807:                         .Column4.ControlSource = "TmpDisp.Disps"
1808:                         .Column5.ControlSource = "TmpDisp.Utilizar"
1809:                     ENDWITH
1810: 
1811:                     WITH THIS.cnt_4c_Container5
1812:                         .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel (" + ;
1813:                                                  ALLTRIM(loc_cCpro) + " " + ALLTRIM(loc_cCor) + ;
1814:                                                  "/" + ALLTRIM(loc_cTam) + ")"
1815:                         .txt_4c_Qt_pedida.Value = TmpFinal.Saldo - TmpFinal.Estoque
1816:                         .txt_4c_Qt_Selec.Value  = 0
1817:                         .Visible     = .T.
1818:                     ENDWITH
1819: 
1820:                     THIS.cmd_4c_Processar.Enabled  = .F.
1821:                     THIS.cmd_4c_Cancelar.Enabled   = .F.
1822:                     THIS.cmd_4c_TotLinha.Enabled   = .F.
1823:                     THIS.cmd_4c_Disponivel.Enabled = .F.

*-- Linhas 1924 a 1970:
1924: 
1925:         TRY
1926:             IF USED("TmpDisp") AND USED("TmpFinal")
1927:                 SELECT TmpDisp
1928:                 SUM Utilizar TO loc_nQtdUtil
1929: 
1930:                 IF loc_nQtdUtil > 0
1931:                     SELECT TmpDisp
1932:                     SCAN
1933:                         IF Utilizar = 0
1934:                             LOOP
1935:                         ENDIF
1936:                         loc_nQtUtil = Utilizar
1937:                         =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, "TmpSaldo")
1938:                         SELECT TmpFinal
1939:                         REPLACE Produzir WITH TmpFinal.Produzir - m.loc_nQtUtil
1940:                         REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir
1941: 
1942:                         SELECT TmpSaldo
1943:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - m.loc_nQtUtil
1944: 
1945:                         IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
1946:                             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
1947:                         ENDIF
1948:                         REPLACE KeySelm WITH .T. IN TmpSaldU
1949: 
1950:                         SELECT TmpSaldG
1951:                         SET ORDER TO Cpros
1952:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
1953:                         REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_nQtUtil
1954: 
1955:                         SELECT TmpDisp
1956:                     ENDSCAN
1957:                     =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
1958:                 ENDIF
1959:                 loc_lSucesso = .T.
1960:             ENDIF
1961:         CATCH TO loc_oErro
1962:             MsgErro(loc_oErro.Message, "Erro")
1963:         ENDTRY
1964: 
1965:         WITH THIS
1966:             .cmd_4c_Processar.Enabled  = .T.
1967:             .cmd_4c_Cancelar.Enabled   = .T.
1968:             .cmd_4c_TotLinha.Enabled   = .T.
1969:             .cmd_4c_SelEstoque.Enabled = .T.
1970:             .cmd_4c_Pedras.Enabled     = .T.

*-- Linhas 1999 a 2046:
1999: 
2000:         TRY
2001:             IF USED("TmpDisp") AND USED("TmpFinal")
2002:                 SELECT TmpDisp
2003:                 SUM Utilizar TO loc_nQtdUtil
2004: 
2005:                 IF loc_nQtdUtil > 0
2006:                     SELECT TmpDisp
2007:                     SCAN
2008:                         IF Utilizar = 0
2009:                             LOOP
2010:                         ENDIF
2011:                         loc_nQtUtil = Utilizar
2012:                         =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2013: 
2014:                         SELECT TmpFinal
2015:                         REPLACE Produzir WITH TmpFinal.Produzir - m.loc_nQtUtil
2016:                         REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir
2017: 
2018:                         SELECT TmpSaldo
2019:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - m.loc_nQtUtil
2020: 
2021:                         IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
2022:                             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
2023:                         ENDIF
2024:                         REPLACE KeySelm WITH .T. IN TmpSaldU
2025: 
2026:                         SELECT TmpSaldG
2027:                         SET ORDER TO Cpros
2028:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + STR(TmpDisp.Priors, 2) + TmpDisp.Grupos + TmpDisp.Estos)
2029:                         REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_nQtUtil
2030: 
2031:                         SELECT TmpDisp
2032:                     ENDSCAN
2033:                     =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2034:                 ENDIF
2035:             ENDIF
2036:         CATCH TO loc_oErro
2037:             MsgErro(loc_oErro.Message, "Erro")
2038:         ENDTRY
2039: 
2040:         WITH THIS
2041:             .cmd_4c_Processar.Enabled  = .T.
2042:             .cmd_4c_Cancelar.Enabled   = .T.
2043:             .cmd_4c_TotLinha.Enabled   = .T.
2044:             .cmd_4c_Disponivel.Enabled = .T.
2045:             .cmd_4c_SelEstoque.Enabled = .T.
2046:             .cmd_4c_Pedras.Enabled     = .T.

*-- Linhas 2071 a 2172:
2071: 
2072:             =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2073: 
2074:             SELECT TmpSaldG
2075:             SET ORDER TO Cpros
2076:             SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
2077:             GO TOP
2078: 
2079:             WITH THIS.cnt_4c_Container3
2080:                 IF USED("TmpSaldo") AND !EOF("TmpSaldo")
2081:                     .txt_4c_Tot_Qtd.Value = TmpSaldo.Saldo
2082:                     .txt_4c_Tot_Est.Value = TmpSaldo.Saldo - TmpSaldo.Disps
2083:                     .txt_4c_Tot_Prz.Value = TmpSaldo.Disps
2084:                 ENDIF
2085: 
2086:                 .lbl_4c_Label1.Caption = ALLTRIM(TmpFinal.Cpros) + ;
2087:                     IIF(!EMPTY(TmpFinal.CodCors), " Cor:" + TmpFinal.CodCors, "") + ;
2088:                     IIF(!EMPTY(TmpFinal.CodTams), " Tam:" + TmpFinal.CodTams, "")
2089: 
2090:                 IF USED("TmpSaldG") AND !EOF("TmpSaldG")
2091:                     loc_cSQL = "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = '" + ;
2092:                                ALLTRIM(TmpSaldG.Estos) + "'"
2093:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpConta") > 0
2094:                         .txt_4c__dconta.Value = TratarNulo(xTmpConta.RClis, "C")
2095:                         IF USED("xTmpConta")
2096:                             USE IN xTmpConta
2097:                         ENDIF
2098:                     ENDIF
2099: 
2100:                     loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE Codigos = '" + ;
2101:                                ALLTRIM(TmpSaldG.Grupos) + "'"
2102:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpGrupo") > 0
2103:                         .txt_4c__dgrupo.Value = TratarNulo(xTmpGrupo.Descrs, "C")
2104:                         IF USED("xTmpGrupo")
2105:                             USE IN xTmpGrupo
2106:                         ENDIF
2107:                     ENDIF
2108:                 ENDIF
2109: 
2110:                 .grd_4c_Dados.Refresh
2111:             ENDWITH
2112: 
2113:             *-- Foto do produto
2114:             loc_cSQL = "SELECT TOP 1 FigJpgs FROM SigCdPro WHERE CPros = '" + ;
2115:                        ALLTRIM(TmpFinal.CPros) + "'"
2116:             IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpProFig") > 0
2117:                 CLEAR RESOURCES
2118:                 THIS.img_4c_ImgFigJpg.Picture = ""
2119:                 THIS.img_4c_ImgFigJpg.Visible = .F.
2120: 
2121:                 IF !EMPTY(xTmpProFig.FigJpgs) AND !ISNULL(xTmpProFig.FigJpgs)
2122:                     loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(xTmpProFig.FigJpgs, ;
2123:                                      "data:image/png;base64,", ""), ;
2124:                                      "data:image/jpeg;base64,", ""), ;
2125:                                      "data:image/jpg;base64,", ""), 14)
2126:                     loc_lcArquivo = SYS(2023) + "\TempGlb.jpg"
2127:                     IF STRTOFILE(loc_lcFoto, loc_lcArquivo) > 0
2128:                         THIS.img_4c_ImgFigJpg.Picture = loc_lcArquivo
2129:                         THIS.img_4c_ImgFigJpg.Visible = .T.
2130:                     ENDIF
2131:                 ENDIF
2132:                 IF USED("xTmpProFig")
2133:                     USE IN xTmpProFig
2134:                 ENDIF
2135:             ENDIF
2136: 
2137:             SELECT TmpFinal
2138:         CATCH TO loc_oErro
2139:             MsgErro(loc_oErro.Message, "Erro")
2140:         ENDTRY
2141:     ENDPROC
2142: 
2143:     PROCEDURE GrdCol6TextWhen
2144:         LOCAL loc_lPermite
2145:         loc_lPermite = .T.
2146: 
2147:         TRY
2148:             IF USED("TmpFinal")
2149:                 THIS.this_nOldValue = THIS.grd_4c_Dados.Column6.Text1.Value
2150: 
2151:                 IF THIS.this_lReserva AND TmpFinal.Estoque = 0
2152:                     loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdPro WHERE CPros = '" + ;
2153:                                ALLTRIM(TmpFinal.CPros) + "'"
2154:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempPro") > 0
2155:                         loc_cSQL = "SELECT TOP 1 TipoEstos FROM SigCdGrp WHERE CGrus = '" + ;
2156:                                    ALLTRIM(xTempPro.CGrus) + "'"
2157:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempGru") > 0
2158:                             IF INLIST(xTempGru.TipoEstos, 3, 4)
2159:                                 THIS.cmd_4c_Disponivel.Enabled = .T.
2160:                             ENDIF
2161:                             IF USED("xTempGru")
2162:                                 USE IN xTempGru
2163:                             ENDIF
2164:                         ENDIF
2165:                         IF USED("xTempPro")
2166:                             USE IN xTempPro
2167:                         ENDIF
2168:                     ENDIF
2169:                 ENDIF
2170:             ENDIF
2171:         CATCH TO loc_oErro
2172:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 2188 a 2206:
2188:             ENDIF
2189: 
2190:             IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
2191:                 INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
2192:             ENDIF
2193: 
2194:             IF loc_nNewValue <> loc_nOld AND TmpSaldU.KeySelm
2195:                 IF MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque. " + ;
2196:                                CHR(13) + "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", "")
2197:                     *-- Continue
2198:                 ELSE
2199:                     THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
2200:                     loc_lValido = .F.
2201:                 ENDIF
2202:             ENDIF
2203: 
2204:             IF loc_lValido
2205:                 DO CASE
2206:                     CASE loc_nNewValue = loc_nOld

*-- Linhas 2221 a 2241:
2221:                             REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - loc_nNewValue IN TmpFinal
2222:                             REPLACE KeySelm WITH .F. IN TmpSaldU
2223: 
2224:                             SELECT TmpSaldo
2225:                             loc_xBaixa = Saldo - Disps
2226:                             SELECT TmpSaldG
2227:                             SET ORDER TO Cpros
2228:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
2229:                             REPLACE Disps WITH Saldo WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams
2230:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
2231:                             SCAN WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams AND m.loc_xBaixa > 0
2232:                                 IF TmpSaldG.Disps >= m.loc_xBaixa
2233:                                     REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_xBaixa
2234:                                     m.loc_xBaixa = 0
2235:                                 ELSE
2236:                                     m.loc_xBaixa = m.loc_xBaixa - TmpSaldG.Disps
2237:                                     REPLACE TmpSaldG.Disps WITH 0
2238:                                 ENDIF
2239:                             ENDSCAN
2240:                         ELSE
2241:                             MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")

*-- Linhas 2256 a 2274:
2256: 
2257:         TRY
2258:             IF USED("TmpFinal")
2259:                 SELECT TmpFinal
2260:                 loc_nRecno = RECNO()
2261:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2262:                 GO loc_nRecno
2263:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2264:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2265:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2266:                 THIS.txt_4c_Tot_Qtd.Refresh
2267:                 THIS.txt_4c_Tot_Est.Refresh
2268:                 THIS.txt_4c_Tot_Prz.Refresh
2269:                 THIS.Refresh
2270:             ENDIF
2271:         CATCH TO loc_oErro
2272:             MsgErro(loc_oErro.Message, "Erro")
2273:         ENDTRY
2274:     ENDPROC

*-- Linhas 2283 a 2312:
2283: 
2284:         TRY
2285:             IF USED("TmpDisp") AND !EOF("TmpDisp")
2286:                 loc_cSQL = "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = '" + ;
2287:                            ALLTRIM(TmpDisp.Estos) + "'"
2288:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpConta5") > 0
2289:                     THIS.cnt_4c_Container5.txt_4c__dconta.Value = TratarNulo(xTmpConta5.RClis, "C")
2290:                     IF USED("xTmpConta5")
2291:                         USE IN xTmpConta5
2292:                     ENDIF
2293:                 ENDIF
2294: 
2295:                 loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE Codigos = '" + ;
2296:                            ALLTRIM(TmpDisp.Grupos) + "'"
2297:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpGrupo5") > 0
2298:                     THIS.cnt_4c_Container5.txt_4c__dgrupo.Value = TratarNulo(xTmpGrupo5.Descrs, "C")
2299:                     IF USED("xTmpGrupo5")
2300:                         USE IN xTmpGrupo5
2301:                     ENDIF
2302:                 ENDIF
2303:             ENDIF
2304:         CATCH TO loc_oErro
2305:             MsgErro(loc_oErro.Message, "Erro")
2306:         ENDTRY
2307:     ENDPROC
2308: 
2309:     PROCEDURE Cnt5Col5TextValid
2310:         LOCAL loc_lValido, loc_nVal, loc_nQtdUtil, loc_nRecno
2311: 
2312:         loc_lValido = .T.

*-- Linhas 2389 a 2409:
2389:         TRY
2390:             loc_cVal = ALLTRIM(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
2391:             IF !EMPTY(loc_cVal)
2392:                 loc_cSQL = "SELECT TOP 1 CPros, DPros, Cunis FROM SigCdPro WHERE CPros = '" + ;
2393:                            EscaparSQL(loc_cVal)
2394:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crListaRemota") > 0 AND RECCOUNT("crListaRemota") > 0
2395:                     THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value = crListaRemota.CPros
2396:                     REPLACE SelPedra.Dpros WITH crListaRemota.DPros, ;
2397:                             SelPedra.Cunis WITH crListaRemota.Cunis IN SelPedra
2398:                 ELSE
2399:                     *-- Abrir picker (FormBuscaAuxiliar)
2400:                     DO FormBuscaAuxiliar WITH gnConnHandle, "SigCdPro", "crListaRemota", "CPros", ;
2401:                                              loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", 1000, ;
2402:                                              "CPros", "DPros"
2403:                     IF USED("crListaRemota") AND RECCOUNT("crListaRemota") > 0
2404:                         THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value = crListaRemota.CPros
2405:                         REPLACE SelPedra.Dpros WITH crListaRemota.DPros, ;
2406:                                 SelPedra.Cunis WITH crListaRemota.Cunis IN SelPedra
2407:                     ENDIF
2408:                 ENDIF
2409:                 IF USED("crListaRemota")

*-- Linhas 2457 a 2477:
2457:         TRY
2458:             loc_cVal = ALLTRIM(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value)
2459:             IF !EMPTY(loc_cVal)
2460:                 loc_cSQL = "SELECT TOP 1 CPros, DPros FROM SigCdPro WHERE CPros = " + ;
2461:                            EscaparSQL(loc_cVal)
2462:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crListaPro2") > 0 AND RECCOUNT("crListaPro2") > 0
2463:                     THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = crListaPro2.CPros
2464:                     REPLACE SelPedra.Cpro2s WITH crListaPro2.CPros IN SelPedra
2465:                 ELSE
2466:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2467:                                              "crListaPro2", "CPros", loc_cVal, ;
2468:                                              "Produto Substituto")
2469:                     IF VARTYPE(loc_oBusca) = "O"
2470:                         loc_oBusca.mAddColuna("CPros", "C" + CHR(243) + "digo", 80)
2471:                         loc_oBusca.mAddColuna("DPros", "Descri" + CHR(231) + CHR(227) + "o", 300)
2472:                         loc_oBusca.Show()
2473:                         IF loc_oBusca.this_lSelecionou AND USED("crListaPro2") AND RECCOUNT("crListaPro2") > 0
2474:                             THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = crListaPro2.CPros
2475:                             REPLACE SelPedra.Cpro2s WITH crListaPro2.CPros IN SelPedra
2476:                         ELSE
2477:                             THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = ""

*-- Linhas 2504 a 2533:
2504: 
2505:         TRY
2506:             IF USED("TmpSaldG") AND !EOF("TmpSaldG")
2507:                 loc_cSQL = "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = '" + ;
2508:                            ALLTRIM(TmpSaldG.Estos) + "'"
2509:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpConta3") > 0
2510:                     THIS.cnt_4c_Container3.txt_4c__dconta.Value = TratarNulo(xTmpConta3.RClis, "C")
2511:                     IF USED("xTmpConta3")
2512:                         USE IN xTmpConta3
2513:                     ENDIF
2514:                 ENDIF
2515: 
2516:                 loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE Codigos = '" + ;
2517:                            ALLTRIM(TmpSaldG.Grupos) + "'"
2518:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpGrupo3") > 0
2519:                     THIS.cnt_4c_Container3.txt_4c__dgrupo.Value = TratarNulo(xTmpGrupo3.Descrs, "C")
2520:                     IF USED("xTmpGrupo3")
2521:                         USE IN xTmpGrupo3
2522:                     ENDIF
2523:                 ENDIF
2524:             ENDIF
2525:         CATCH TO loc_oErro
2526:             MsgErro(loc_oErro.Message, "Erro")
2527:         ENDTRY
2528:     ENDPROC
2529: 
2530:     *==========================================================================
2531:     * ExecutarReportForm - Helper canonico REPORT FORM com guard FILE()
2532:     * e isolamento SET POINT/SEPARATOR/REPORTBEHAVIOR 80
2533:     * par_cRelatorioBase : nome base do FRX (sem path, sem extensao)

*-- Linhas 2600 a 2618:
2600: 
2601:         TRY
2602:             IF USED("TmpFinal")
2603:                 SELECT TmpFinal
2604:                 loc_nRecno = RECNO()
2605:                 loc_nSal = 0
2606:                 loc_nEst = 0
2607:                 loc_nPrz = 0
2608:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2609:                 IF loc_nRecno <= RECCOUNT("TmpFinal") AND loc_nRecno > 0
2610:                     GO loc_nRecno IN TmpFinal
2611:                 ENDIF
2612: 
2613:                 IF VARTYPE(THIS.txt_4c_Tot_Qtd) = "O"
2614:                     THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2615:                     THIS.txt_4c_Tot_Qtd.Refresh()
2616:                 ENDIF
2617:                 IF VARTYPE(THIS.txt_4c_Tot_Est) = "O"
2618:                     THIS.txt_4c_Tot_Est.Value = loc_nEst

*-- Linhas 2666 a 2684:
2666:                 loc_nSal = 0
2667:                 loc_nEst = 0
2668:                 loc_nPrz = 0
2669:                 SELECT TmpFinal
2670:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2671:                 GO TOP
2672:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2673:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2674:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2675:             ENDIF
2676:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
2677:                 THIS.grd_4c_Dados.Refresh()
2678:             ENDIF
2679:         CATCH TO loc_oErro
2680:             MsgErro(loc_oErro.Message, "Erro")
2681:         ENDTRY
2682:     ENDPROC
2683: 
2684:     *==========================================================================

*-- Linhas 2769 a 2787:
2769:             THIS.CarregarDados()
2770: 
2771:             IF USED("TmpFinal")
2772:                 SELECT TmpFinal
2773:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2774:                 GO TOP
2775:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2776:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2777:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2778:             ENDIF
2779: 
2780:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
2781:                 THIS.grd_4c_Dados.Refresh()
2782:             ENDIF
2783:             IF VARTYPE(THIS.cnt_4c_Container3) = "O"
2784:                 THIS.cnt_4c_Container3.Refresh()
2785:             ENDIF
2786:             THIS.Refresh()
2787:         CATCH TO loc_oErro

*-- Linhas 2805 a 2823:
2805:                 IF loc_lHab
2806:                     *-- Permitir edicao apenas se nao ha operacao TransfRes bloqueando
2807:                     IF USED("crSigCdPam")
2808:                         SELECT crSigCdPam
2809:                         IF EMPTY(crSigCdPam.TransfRes)
2810:                             THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
2811:                         ELSE
2812:                             THIS.grd_4c_Dados.Column6.ReadOnly = .F.
2813:                         ENDIF
2814:                     ELSE
2815:                         THIS.grd_4c_Dados.Column6.ReadOnly = .F.
2816:                     ENDIF
2817:                 ELSE
2818:                     THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
2819:                 ENDIF
2820:             ENDIF
2821: 
2822:             *-- Botoes de acao
2823:             THIS.AjustarBotoesPorModo()

*-- Linhas 2886 a 2904:
2886: 
2887:             *-- Verificar se operacao de pedras/selecao de estoque esta disponivel
2888:             IF loc_lTemDados AND USED("crSigCdPam")
2889:                 SELECT crSigCdPam
2890:                 loc_lPodeAcao = !EMPTY(crSigCdPam.DopEmphs) AND ;
2891:                                 !EMPTY(crSigCdPam.DopReqcs) AND ;
2892:                                 !EMPTY(crSigCdPam.DopPedcs) AND ;
2893:                                 !EMPTY(crSigCdPam.DopComps) AND ;
2894:                                 !THIS.this_lReserva
2895:             ENDIF
2896: 
2897:             *-- Aplicar estado aos botoes
2898:             THIS.cmd_4c_Processar.Enabled    = loc_lTemDados
2899:             THIS.cmd_4c_Cancelar.Enabled     = .T.
2900:             THIS.cmd_4c_TotLinha.Enabled     = loc_lTemDados
2901:             THIS.cmd_4c_Disponivel.Enabled   = loc_lTemDados
2902:             THIS.cmd_4c_BtnRelatorio.Enabled = loc_lTemDados
2903:             THIS.cmd_4c_Pedras.Enabled       = loc_lPodeAcao
2904:             THIS.cmd_4c_SelEstoque.Enabled   = loc_lPodeAcao

