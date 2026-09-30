# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VALOR' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ESTOQUE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PRODUZIR' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CUSTOS, CPROS, CUNIS, 0, DOPES, DOPPS, _NREGISTRO, ORIGEMS, TIPOS, CODCORS, CODTAMS, XBAIXA, EMPDOPNUMS, CIDCHAVES, DISPS, NUMERODAOP, NUMPS, FABRPROPRS, _LNVEZES, CITEM2, CONTADS, EMPS, NUMES, QTDS, IF, X, CHKSUBN, DOPEBS, QTDES, CMATS, LNTOTREQ, PRAZOENTS, ENTPES, AUTOS, NOPS, MATS, NTRANS, TMPH, EMPDNPS, AQTDS, CITENS, QTPRODS, DTALTS

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg) - TRECHOS RELEVANTES PARA PASS SQL (4730 linhas total):

*-- Linhas 237 a 255:
237:     *                     btnRelatorio) e o grid principal grd_4c_Itens
238:     *                     (GradeItens, 9 colunas, RecordSource='TmpFinal')
239:     *   Fase 5 (esta)  - 3 dos 5 containers flutuantes (estrutura visual
240:     *                     apenas - RecordSource/ControlSource dos grids fica
241:     *                     para a Fase 7-8, igual ao legado, que so liga isso
242:     *                     dentro do Click de cada botao): cnt_4c_Container1
243:     *                     (Pecas a Produzir por Linha - botao TotLinha),
244:     *                     cnt_4c_Container2 (Estoque Disponivel por
245:     *                     Produto/Cor/Tam - botao Disponivel) e
246:     *                     cnt_4c_Container5 (Estoque Disponivel por
247:     *                     Grupo/Conta - botao SelEstoque)
248:     *   Fase 6 (esta)  - cnt_4c_Container4 (Requisicao de Componentes
249:     *                     Adicionais - botao Pedras; grid ligado a SelPedra
250:     *                     em runtime pelo Pedras.Click, mesmo padrao dos
251:     *                     containers da Fase 5), cnt_4c_Container3
252:     *                     (Estoque Disponivel por Conta, rodape SEMPRE
253:     *                     visivel - nao entra no filtro de
254:     *                     TornarControlesVisiveis), os campos totais da
255:     *                     grade principal (txt_4c_TotQtd/TotEst/TotPrz),

*-- Linhas 593 a 617:
593:     * de teste de UI (gb_4c_ValidandoUI) nao existe. Quando ele chega
594:     * DEPOIS, quem liga a grade eh CarregarLista() (chamado no fim do
595:     * InicializarForm), que refaz o bind por LigarGradeItens() repondo
596:     * ControlSource/Width/Header na ordem canonica.
597:     *
598:     * IMPORTANTE - Correspondencia ControlSource x Header (conferida com o
599:     * dump linha a linha, incluindo cruzamento com os handlers de
600:     * GotFocus/Valid do legado, que confirmam qual coluna eh a UNICA
601:     * editavel): a ordem de DECLARACAO das colunas (Column1..Column9, a
602:     * mesma usada no ".ColumnN.ControlSource=" do Init legado) NAO anda em
603:     * paralelo com a ordem em que os Header1/Text1 aparecem no dump do SCX
604:     * - os Header1/Text1 sao indexados pelo .Name HISTORICO de cada coluna
605:     * (ex.: a coluna fisica 2, ligada a CodCors, tem .Name="Column5" e por
606:     * isso seu Header1.Caption fica na secao "Column5" do dump = "Quantidade").
607:     * Coluna 3 (fisica), ligada a Dopes, tem .Name="Column6", Header
608:     * "Produzir" e eh a UNICA com ReadOnly=.F. (BackColor 221,252,255) - os
609:     * handlers GotFocus de TODAS as outras colunas (comportamento.json)
610:     * fazem SetFocus justamente para "GradeItens.Column6.Text1", confirmando
611:     * que esta (fisica 3/Dopes/"Produzir") eh a coluna editavel do grid.
612:     *--------------------------------------------------------------------------
613:     PROTECTED PROCEDURE ConfigurarGradeItens()
614:         LOCAL loc_oErro
615: 
616:         TRY
617:             THIS.AddObject("grd_4c_Itens", "Grid")

*-- Linhas 624 a 739:
624:                 .FontSize          = 8
625:                 .AllowHeaderSizing = .F.
626:                 .AllowRowSizing    = .F.
627:                 .DeleteMark        = .F.
628:                 .RecordMark        = .F.
629:                 .RowHeight         = 17
630:                 .ScrollBars        = 2
631:                 .GridLineColor     = RGB(238, 238, 238)
632:                 .Visible           = .T.
633: 
634:                 .ColumnCount = 9
635: 
636:                 IF USED("TmpFinal")
637:                     .RecordSource = "TmpFinal"
638:                 ENDIF
639: 
640:                 *-- Coluna 1 - Produto (Cpros)
641:                 .Column1.ControlSource = "TmpFinal.Cpros"
642:                 .Column1.Width         = 115
643:                 .Column1.Movable       = .F.
644:                 .Column1.Resizable     = .F.
645:                 .Column1.ReadOnly      = .T.
646:                 .Column1.Header1.FontName  = "Verdana"
647:                 .Column1.Header1.FontSize  = 8
648:                 .Column1.Header1.Alignment = 2
649:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
650:                 .Column1.Header1.Caption   = "Produto"
651:                 .Column1.Text1.FontSize    = 8
652:                 .Column1.Text1.BorderStyle = 0
653:                 .Column1.Text1.Margin      = 0
654:                 .Column1.Text1.ReadOnly    = .T.
655:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)
656:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
657: 
658:                 *-- Coluna 2 - Cor (CodCors)
659:                 .Column2.ControlSource = "TmpFinal.CodCors"
660:                 .Column2.FontBold      = .T.
661:                 .Column2.ColumnOrder   = 6
662:                 .Column2.Width         = 80
663:                 .Column2.Movable       = .F.
664:                 .Column2.Resizable     = .F.
665:                 .Column2.ReadOnly      = .T.
666:                 .Column2.Header1.FontName  = "Verdana"
667:                 .Column2.Header1.FontSize  = 8
668:                 .Column2.Header1.Alignment = 2
669:                 .Column2.Header1.ForeColor = RGB(36, 84, 155)
670:                 .Column2.Header1.Caption   = "Cor"
671:                 .Column2.Text1.FontSize    = 8
672:                 .Column2.Text1.BorderStyle = 0
673:                 .Column2.Text1.Margin      = 0
674:                 .Column2.Text1.ReadOnly    = .T.
675:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)
676:                 .Column2.Text1.BackColor   = RGB(255, 255, 255)
677: 
678:                 *-- Coluna 3 - Movimentacao (Dopes) - SEMPRE ReadOnly (o dump
679:                 *-- legado declara Column3.Text1.ReadOnly=.T., BackColor
680:                 *-- 255,255,255, sem FontBold - a UNICA editavel do grid eh a
681:                 *-- Column6/Produzir, corrigido abaixo)
682:                 .Column3.ControlSource = "TmpFinal.Dopes"
683:                 .Column3.ColumnOrder   = 8
684:                 .Column3.Width         = 80
685:                 .Column3.Movable       = .F.
686:                 .Column3.Resizable     = .F.
687:                 .Column3.ReadOnly      = .T.
688:                 .Column3.Header1.FontName  = "Verdana"
689:                 .Column3.Header1.FontSize  = 8
690:                 .Column3.Header1.Alignment = 2
691:                 .Column3.Header1.ForeColor = RGB(36, 84, 155)
692:                 .Column3.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
693:                 .Column3.Text1.FontSize    = 8
694:                 .Column3.Text1.BorderStyle = 0
695:                 .Column3.Text1.Margin      = 0
696:                 .Column3.Text1.ReadOnly    = .T.
697:                 .Column3.Text1.ForeColor   = RGB(0, 0, 0)
698:                 .Column3.Text1.BackColor   = RGB(255, 255, 255)
699: 
700:                 *-- Coluna 4 - Codigo (Numes)
701:                 .Column4.ControlSource = "TmpFinal.Numes"
702:                 .Column4.FontBold      = .T.
703:                 .Column4.Alignment     = 2
704:                 .Column4.ColumnOrder   = 9
705:                 .Column4.Width         = 38
706:                 .Column4.Movable       = .F.
707:                 .Column4.Resizable     = .F.
708:                 .Column4.ReadOnly      = .T.
709:                 .Column4.Header1.FontName  = "Verdana"
710:                 .Column4.Header1.FontSize  = 8
711:                 .Column4.Header1.Alignment = 2
712:                 .Column4.Header1.ForeColor = RGB(36, 84, 155)
713:                 .Column4.Header1.Caption   = "C" + CHR(243) + "digo"
714:                 .Column4.Text1.FontBold    = .T.
715:                 .Column4.Text1.FontSize    = 8
716:                 .Column4.Text1.Alignment   = 2
717:                 .Column4.Text1.BorderStyle = 0
718:                 .Column4.Text1.Margin      = 0
719:                 .Column4.Text1.ReadOnly    = .T.
720:                 .Column4.Text1.ForeColor   = RGB(0, 0, 0)
721:                 .Column4.Text1.BackColor   = RGB(255, 255, 255)
722: 
723:                 *-- Coluna 5 - Quantidade (Saldo)
724:                 .Column5.ControlSource = "TmpFinal.Saldo"
725:                 .Column5.FontBold      = .T.
726:                 .Column5.ColumnOrder   = 7
727:                 .Column5.Width         = 80
728:                 .Column5.Movable       = .F.
729:                 .Column5.Resizable     = .F.
730:                 .Column5.ReadOnly      = .T.
731:                 .Column5.BackColor     = RGB(255, 253, 179)
732:                 .Column5.Header1.FontName  = "Verdana"
733:                 .Column5.Header1.FontSize  = 8
734:                 .Column5.Header1.Alignment = 2
735:                 .Column5.Header1.ForeColor = RGB(36, 84, 155)
736:                 .Column5.Header1.Caption   = "Quantidade"
737:                 .Column5.Text1.FontBold    = .T.
738:                 .Column5.Text1.FontSize    = 8
739:                 .Column5.Text1.BorderStyle = 0

*-- Linhas 745 a 826:
745:                 *-- Coluna 6 - Produzir - UNICA editavel do grid (dump legado:
746:                 *-- Column6.Text1.ReadOnly=.F., FontBold=.T., BackColor
747:                 *-- 221,252,255 - trocado com a Column3 por engano na Fase 4)
748:                 .Column6.ControlSource = "TmpFinal.Produzir"
749:                 .Column6.FontBold      = .T.
750:                 .Column6.FontSize      = 8
751:                 .Column6.ColumnOrder   = 4
752:                 .Column6.Width         = 150
753:                 .Column6.Movable       = .F.
754:                 .Column6.Resizable     = .F.
755:                 .Column6.ReadOnly      = .F.
756:                 .Column6.BackColor     = RGB(221, 252, 255)
757:                 .Column6.Header1.FontName  = "Verdana"
758:                 .Column6.Header1.FontSize  = 8
759:                 .Column6.Header1.Alignment = 2
760:                 .Column6.Header1.ForeColor = RGB(36, 84, 155)
761:                 .Column6.Header1.Caption   = "Produzir"
762:                 .Column6.Text1.FontBold    = .T.
763:                 .Column6.Text1.FontSize    = 8
764:                 .Column6.Text1.BorderStyle = 0
765:                 .Column6.Text1.Margin      = 0
766:                 .Column6.Text1.ReadOnly    = .F.
767:                 .Column6.Text1.ForeColor   = RGB(0, 0, 0)
768:                 .Column6.Text1.BackColor   = RGB(221, 252, 255)
769: 
770:                 *-- Coluna 7 - Estoque
771:                 .Column7.ControlSource = "TmpFinal.Estoque"
772:                 .Column7.FontSize      = 8
773:                 .Column7.ColumnOrder   = 5
774:                 .Column7.Width         = 50
775:                 .Column7.Movable       = .F.
776:                 .Column7.Resizable     = .F.
777:                 .Column7.ReadOnly      = .T.
778:                 .Column7.Header1.FontName  = "Verdana"
779:                 .Column7.Header1.FontSize  = 8
780:                 .Column7.Header1.Alignment = 2
781:                 .Column7.Header1.ForeColor = RGB(36, 84, 155)
782:                 .Column7.Header1.Caption   = "Estoque"
783:                 .Column7.Text1.FontSize    = 8
784:                 .Column7.Text1.BorderStyle = 0
785:                 .Column7.Text1.Margin      = 0
786:                 .Column7.Text1.ReadOnly    = .T.
787:                 .Column7.Text1.ForeColor   = RGB(0, 0, 0)
788:                 .Column7.Text1.BackColor   = RGB(255, 255, 255)
789: 
790:                 *-- Coluna 8 - Obs (marcador "*" quando ha observacao)
791:                 .Column8.ControlSource = [IIF(ISNULL(TmpFinal.Obsps) OR EMPTY(TmpFinal.Obsps), "", "*")]
792:                 .Column8.FontSize      = 8
793:                 .Column8.ColumnOrder   = 2
794:                 .Column8.Width         = 38
795:                 .Column8.Movable       = .F.
796:                 .Column8.Resizable     = .F.
797:                 .Column8.ReadOnly      = .T.
798:                 .Column8.Header1.FontName  = "Verdana"
799:                 .Column8.Header1.FontSize  = 8
800:                 .Column8.Header1.Alignment = 2
801:                 .Column8.Header1.ForeColor = RGB(36, 84, 155)
802:                 .Column8.Header1.Caption   = "Obs"
803:                 .Column8.Text1.FontSize    = 8
804:                 .Column8.Text1.BorderStyle = 0
805:                 .Column8.Text1.Margin      = 0
806:                 .Column8.Text1.ReadOnly    = .T.
807:                 .Column8.Text1.ForeColor   = RGB(0, 0, 0)
808:                 .Column8.Text1.BackColor   = RGB(255, 255, 255)
809: 
810:                 *-- Coluna 9 - Tam (CodTams)
811:                 .Column9.ControlSource = "TmpFinal.CodTams"
812:                 .Column9.FontSize      = 8
813:                 .Column9.ColumnOrder   = 3
814:                 .Column9.Width         = 38
815:                 .Column9.Movable       = .F.
816:                 .Column9.Resizable     = .F.
817:                 .Column9.ReadOnly      = .T.
818:                 .Column9.Header1.FontName  = "Verdana"
819:                 .Column9.Header1.FontSize  = 8
820:                 .Column9.Header1.Alignment = 2
821:                 .Column9.Header1.ForeColor = RGB(36, 84, 155)
822:                 .Column9.Header1.Caption   = "Tam"
823:                 .Column9.Text1.FontSize    = 8
824:                 .Column9.Text1.BorderStyle = 0
825:                 .Column9.Text1.Margin      = 0
826:                 .Column9.Text1.ReadOnly    = .T.

*-- Linhas 838 a 858:
838:     * ConfigurarContainer1 - "Pecas a produzir por linha" (Container1 no
839:     * legado), alternado pelo botao cmd_4c_TotLinha (Fase 7-8). Grid
840:     * grd_4c_Linhas 100% somente-leitura (o proprio Grid tem .ReadOnly=.T.
841:     * no dump, alem de cada Column) - Column1..4.ControlSource ficam vazios
842:     * de proposito (assim declarado no SCX): TotLinha.Click monta o cursor
843:     * TmpLinha e liga RecordSource/ControlSource em runtime (Fase 7-8),
844:     * igual ao legado.
845:     *--------------------------------------------------------------------------
846:     PROTECTED PROCEDURE ConfigurarContainer1()
847:         LOCAL loc_oCnt, loc_oErro
848: 
849:         TRY
850:             THIS.AddObject("cnt_4c_Container1", "Container")
851:             loc_oCnt = THIS.cnt_4c_Container1
852:             WITH loc_oCnt
853:                 .Top           = 125
854:                 .Left          = 12
855:                 .Width         = 708
856:                 .Height        = 465
857:                 .SpecialEffect = 0
858:                 .BackColor     = RGB(255, 255, 255)

*-- Linhas 906 a 998:
906:                 .FontSize          = 8
907:                 .AllowHeaderSizing = .F.
908:                 .AllowRowSizing    = .F.
909:                 .DeleteMark        = .F.
910:                 .RecordMark        = .T.
911:                 .RowHeight         = 16
912:                 .ScrollBars        = 2
913:                 .GridLineColor     = RGB(238, 238, 238)
914:                 .ReadOnly          = .T.
915:                 .Visible           = .T.
916: 
917:                 .ColumnCount = 4
918: 
919:                 *-- Coluna 1 - Linha (futuro TmpLinha.Linhas)
920:                 .Column1.ControlSource     = ""
921:                 .Column1.Width             = 84
922:                 .Column1.Movable           = .F.
923:                 .Column1.Resizable         = .F.
924:                 .Column1.ReadOnly          = .T.
925:                 .Column1.Sparse            = .F.
926:                 .Column1.Header1.FontName  = "Verdana"
927:                 .Column1.Header1.FontSize  = 8
928:                 .Column1.Header1.Alignment = 2
929:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
930:                 .Column1.Header1.Caption   = "Linha"
931:                 .Column1.Text1.FontName    = "Arial"
932:                 .Column1.Text1.FontSize    = 8
933:                 .Column1.Text1.BorderStyle = 0
934:                 .Column1.Text1.Margin      = 0
935:                 .Column1.Text1.ReadOnly    = .T.
936:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)
937:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
938: 
939:                 *-- Coluna 2 - Quantidade (futuro TmpLinha.Saldo)
940:                 .Column2.ControlSource     = ""
941:                 .Column2.Width             = 80
942:                 .Column2.Movable           = .F.
943:                 .Column2.Resizable         = .F.
944:                 .Column2.ReadOnly          = .T.
945:                 .Column2.Sparse            = .F.
946:                 .Column2.Header1.FontName  = "Verdana"
947:                 .Column2.Header1.FontSize  = 8
948:                 .Column2.Header1.Alignment = 2
949:                 .Column2.Header1.ForeColor = RGB(36, 84, 155)
950:                 .Column2.Header1.Caption   = "Quantidade"
951:                 .Column2.Text1.FontSize    = 8
952:                 .Column2.Text1.BorderStyle = 0
953:                 .Column2.Text1.InputMask   = "999,999.99"
954:                 .Column2.Text1.Margin      = 0
955:                 .Column2.Text1.MaxLength   = 10
956:                 .Column2.Text1.ReadOnly    = .T.
957:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)
958:                 .Column2.Text1.BackColor   = RGB(255, 255, 255)
959: 
960:                 *-- Coluna 3 - Estoque (futuro TmpLinha.Estoque)
961:                 .Column3.ControlSource     = ""
962:                 .Column3.Width             = 80
963:                 .Column3.Movable           = .F.
964:                 .Column3.Resizable         = .F.
965:                 .Column3.ReadOnly          = .T.
966:                 .Column3.Sparse            = .F.
967:                 .Column3.Header1.FontName  = "Verdana"
968:                 .Column3.Header1.FontSize  = 8
969:                 .Column3.Header1.Alignment = 2
970:                 .Column3.Header1.ForeColor = RGB(36, 84, 155)
971:                 .Column3.Header1.Caption   = "Estoque"
972:                 .Column3.Text1.FontName    = "Arial"
973:                 .Column3.Text1.FontSize    = 8
974:                 .Column3.Text1.BorderStyle = 0
975:                 .Column3.Text1.InputMask   = "999,999.99"
976:                 .Column3.Text1.Margin      = 0
977:                 .Column3.Text1.MaxLength   = 10
978:                 .Column3.Text1.ReadOnly    = .T.
979:                 .Column3.Text1.ForeColor   = RGB(0, 0, 0)
980:                 .Column3.Text1.BackColor   = RGB(255, 255, 255)
981: 
982:                 *-- Coluna 4 - Produzir (futuro TmpLinha.Produzir)
983:                 .Column4.ControlSource     = ""
984:                 .Column4.Width             = 80
985:                 .Column4.Movable           = .F.
986:                 .Column4.Resizable         = .F.
987:                 .Column4.ReadOnly          = .T.
988:                 .Column4.Sparse            = .F.
989:                 .Column4.Header1.FontName  = "Verdana"
990:                 .Column4.Header1.FontSize  = 8
991:                 .Column4.Header1.Alignment = 2
992:                 .Column4.Header1.ForeColor = RGB(36, 84, 155)
993:                 .Column4.Header1.Caption   = "Produzir"
994:                 .Column4.Text1.FontName    = "Arial"
995:                 .Column4.Text1.FontSize    = 8
996:                 .Column4.Text1.BorderStyle = 0
997:                 .Column4.Text1.InputMask   = "999,999.99"
998:                 .Column4.Text1.Margin      = 0

*-- Linhas 1011 a 1029:
1011:     *--------------------------------------------------------------------------
1012:     * ConfigurarContainer2 - "Estoque Disponivel" por PRODUTO/COR/TAM,
1013:     * alternado pelo botao cmd_4c_Disponivel (Fase 7-8). RecordSource/
1014:     * ControlSource ficam de fora aqui (o SCX nao declara ControlSource
1015:     * estatico para estas colunas - o Click do legado monta TmpDisp e liga
1016:     * tudo em runtime, mesmo padrao do Container5).
1017:     *--------------------------------------------------------------------------
1018:     PROTECTED PROCEDURE ConfigurarContainer2()
1019:         LOCAL loc_oCnt, loc_oErro
1020: 
1021:         TRY
1022:             THIS.AddObject("cnt_4c_Container2", "Container")
1023:             loc_oCnt = THIS.cnt_4c_Container2
1024:             WITH loc_oCnt
1025:                 .Top           = 125
1026:                 .Left          = 12
1027:                 .Width         = 708
1028:                 .Height        = 465
1029:                 .SpecialEffect = 0

*-- Linhas 1073 a 1091:
1073:                 .FontSize          = 8
1074:                 .AllowHeaderSizing = .F.
1075:                 .AllowRowSizing    = .F.
1076:                 .DeleteMark        = .F.
1077:                 .RecordMark        = .T.
1078:                 .Panel             = 1
1079:                 .RowHeight         = 16
1080:                 .ScrollBars        = 2
1081:                 .GridLineColor     = RGB(238, 238, 238)
1082:                 .Visible           = .T.
1083: 
1084:                 .ColumnCount = 5
1085: 
1086:                 *-- Coluna 1 - Produto (futuro TmpDisp.Cpros)
1087:                 .Column1.Width             = 108
1088:                 .Column1.Movable           = .F.
1089:                 .Column1.Resizable         = .F.
1090:                 .Column1.ReadOnly          = .T.
1091:                 .Column1.Header1.FontName  = "Verdana"

*-- Linhas 1310 a 1328:
1310:                 .FontSize          = 8
1311:                 .AllowHeaderSizing = .F.
1312:                 .AllowRowSizing    = .F.
1313:                 .DeleteMark        = .F.
1314:                 .RecordMark        = .T.
1315:                 .RowHeight         = 16
1316:                 .ScrollBars        = 2
1317:                 .GridLineColor     = RGB(238, 238, 238)
1318:                 .Visible           = .T.
1319: 
1320:                 .ColumnCount = 5
1321: 
1322:                 *-- Coluna 1 - Grupo (futuro TmpDisp.Grupos) - ColumnOrder 2
1323:                 .Column1.ColumnOrder       = 2
1324:                 .Column1.Width             = 80
1325:                 .Column1.Movable           = .F.
1326:                 .Column1.Resizable         = .F.
1327:                 .Column1.ReadOnly          = .T.
1328:                 .Column1.Header1.FontName  = "Verdana"

*-- Linhas 1534 a 1552:
1534:     * ConfigurarContainer4 - "Requisicao de componentes adicionais"
1535:     * (Container4 no legado), alternado pelo botao cmd_4c_Pedras (Fase 7-8).
1536:     * Grid grd_4c_Pedras liga em runtime ao cursor SelPedra montado pelo
1537:     * Click (mesmo padrao de RecordSource/ControlSource vazio ja usado nos
1538:     * Containers 1/2/5) - Pedras.Click faz .RecordSource='SelPedra' e liga
1539:     * Column1..5 a Cpros/Dpros/Cunis/Qtds/Cpro2s.
1540:     *
1541:     * ReadOnly por coluna transcrito do When de cada Text1 no legado:
1542:     * Coluna1 (Produto) eh a UNICA de entrada livre - o Valid dela dispara
1543:     * o lookup fwBuscaExt em SigCdPro (Fase 7-8) e preenche Descricao/Uni
1544:     * (Colunas 2/3, sempre ReadOnly, "Return .f." no When). Colunas 4
1545:     * (Qtde) e 5 (Produto substituto, com o proprio lookup fwBuscaExt) so
1546:     * habilitam quando a Coluna1 estiver preenchida (When = "Return (Not
1547:     * Empty(...Column1.Text1.Value))"); a Coluna5 tambem tem um LostFocus
1548:     * que insere linha em branco no SelPedra (Fase 7-8).
1549:     *--------------------------------------------------------------------------
1550:     PROTECTED PROCEDURE ConfigurarContainer4()
1551:         LOCAL loc_oCnt, loc_oErro
1552: 

*-- Linhas 1605 a 1716:
1605:                 .FontSize          = 8
1606:                 .AllowHeaderSizing = .F.
1607:                 .AllowRowSizing    = .F.
1608:                 .DeleteMark        = .F.
1609:                 .RecordMark        = .T.
1610:                 .RowHeight         = 16
1611:                 .ScrollBars        = 2
1612:                 .GridLineColor     = RGB(238, 238, 238)
1613:                 .Visible           = .T.
1614: 
1615:                 .ColumnCount = 5
1616: 
1617:                 *-- Coluna 1 - Produto (futuro SelPedra.Cpros) - entrada
1618:                 *-- livre com lookup em SigCdPro (ValidarPedraProduto /
1619:                 *-- AbrirLookupPedraProduto, ligados por BINDEVENT abaixo)
1620:                 .Column1.ControlSource     = ""
1621:                 .Column1.Width             = 110
1622:                 .Column1.Movable           = .F.
1623:                 .Column1.Resizable         = .F.
1624:                 .Column1.ReadOnly          = .F.
1625:                 .Column1.Header1.FontName  = "Verdana"
1626:                 .Column1.Header1.FontSize  = 8
1627:                 .Column1.Header1.Alignment = 2
1628:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
1629:                 .Column1.Header1.Caption   = "Produto"
1630:                 .Column1.Text1.FontSize    = 8
1631:                 .Column1.Text1.BorderStyle = 0
1632:                 .Column1.Text1.Margin      = 0
1633:                 .Column1.Text1.ReadOnly    = .F.
1634:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)
1635:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
1636: 
1637:                 *-- Coluna 2 - Descricao (futuro SelPedra.Dpros) - sempre
1638:                 *-- ReadOnly, preenchida pelo lookup da Coluna1
1639:                 .Column2.ControlSource     = ""
1640:                 .Column2.Width             = 215
1641:                 .Column2.Movable           = .F.
1642:                 .Column2.Resizable         = .F.
1643:                 .Column2.ReadOnly          = .T.
1644:                 .Column2.Header1.FontName  = "Verdana"
1645:                 .Column2.Header1.FontSize  = 8
1646:                 .Column2.Header1.Alignment = 2
1647:                 .Column2.Header1.ForeColor = RGB(36, 84, 155)
1648:                 .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1649:                 .Column2.Text1.FontSize    = 8
1650:                 .Column2.Text1.BorderStyle = 0
1651:                 .Column2.Text1.Margin      = 0
1652:                 .Column2.Text1.ReadOnly    = .T.
1653:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)
1654:                 .Column2.Text1.BackColor   = RGB(255, 255, 255)
1655: 
1656:                 *-- Coluna 3 - Uni (futuro SelPedra.Cunis) - sempre ReadOnly,
1657:                 *-- preenchida pelo lookup da Coluna1
1658:                 .Column3.ControlSource     = ""
1659:                 .Column3.Width             = 50
1660:                 .Column3.Movable           = .F.
1661:                 .Column3.Resizable         = .F.
1662:                 .Column3.ReadOnly          = .T.
1663:                 .Column3.Header1.FontName  = "Verdana"
1664:                 .Column3.Header1.FontSize  = 8
1665:                 .Column3.Header1.Alignment = 2
1666:                 .Column3.Header1.ForeColor = RGB(36, 84, 155)
1667:                 .Column3.Header1.Caption   = "Uni"
1668:                 .Column3.Text1.FontSize    = 8
1669:                 .Column3.Text1.BorderStyle = 0
1670:                 .Column3.Text1.Margin      = 0
1671:                 .Column3.Text1.ReadOnly    = .T.
1672:                 .Column3.Text1.ForeColor   = RGB(0, 0, 0)
1673:                 .Column3.Text1.BackColor   = RGB(255, 255, 255)
1674: 
1675:                 *-- Coluna 4 - Qtde (futuro SelPedra.Qtds) - habilita so
1676:                 *-- quando a Coluna1 estiver preenchida (gate do When
1677:                 *-- legado, reproduzido em PedrasAfterRowColChange)
1678:                 .Column4.ControlSource     = ""
1679:                 .Column4.Width             = 100
1680:                 .Column4.Movable           = .F.
1681:                 .Column4.Resizable         = .F.
1682:                 .Column4.ReadOnly          = .F.
1683:                 .Column4.Header1.FontName  = "Verdana"
1684:                 .Column4.Header1.FontSize  = 8
1685:                 .Column4.Header1.Alignment = 2
1686:                 .Column4.Header1.ForeColor = RGB(36, 84, 155)
1687:                 .Column4.Header1.Caption   = "Qtde"
1688:                 .Column4.Text1.FontSize    = 8
1689:                 .Column4.Text1.BorderStyle = 0
1690:                 .Column4.Text1.InputMask   = "999,999.99"
1691:                 .Column4.Text1.Margin      = 0
1692:                 .Column4.Text1.ReadOnly    = .F.
1693:                 .Column4.Text1.ForeColor   = RGB(0, 0, 0)
1694:                 .Column4.Text1.BackColor   = RGB(255, 255, 255)
1695: 
1696:                 *-- Coluna 5 - Produto substituto (futuro SelPedra.Cpro2s) -
1697:                 *-- lookup proprio em SigCdPro (ValidarPedraSubstituto /
1698:                 *-- AbrirLookupPedraSubstituto), habilita so com a Coluna1
1699:                 *-- preenchida; LostFocus do legado insere linha em branco
1700:                 *-- no SelPedra (PedraSubstitutoLostFocus)
1701:                 .Column5.ControlSource     = ""
1702:                 .Column5.Width             = 125
1703:                 .Column5.Movable           = .F.
1704:                 .Column5.Resizable         = .F.
1705:                 .Column5.ReadOnly          = .F.
1706:                 .Column5.Header1.FontName  = "Verdana"
1707:                 .Column5.Header1.FontSize  = 8
1708:                 .Column5.Header1.Alignment = 2
1709:                 .Column5.Header1.ForeColor = RGB(36, 84, 155)
1710:                 .Column5.Header1.Caption   = "Produto"
1711:                 .Column5.Text1.FontSize    = 8
1712:                 .Column5.Text1.BorderStyle = 0
1713:                 .Column5.Text1.Margin      = 0
1714:                 .Column5.Text1.ReadOnly    = .F.
1715:                 .Column5.Text1.ForeColor   = RGB(0, 0, 0)
1716:                 .Column5.Text1.BackColor   = RGB(255, 255, 255)

*-- Linhas 1760 a 1778:
1760:     * e mostrando outro produto/cor/tam escolhido pelo usuario).
1761:     *
1762:     * GradeDisp e os campos txt_4c_GetDGrupo/GetDConta/TotQtd/TotEst/TotPrz
1763:     * ficam sem ControlSource/Value dinamico aqui - GradeItens.
1764:     * AfterRowColChange (Fase 7-8) religa TmpSaldG com "Set Key To" filtrado
1765:     * pelo Cpros+CodCors+CodTams do item corrente e atualiza estes campos,
1766:     * igual ao legado.
1767:     *--------------------------------------------------------------------------
1768:     PROTECTED PROCEDURE ConfigurarContainer3()
1769:         LOCAL loc_oCnt, loc_oErro
1770: 
1771:         TRY
1772:             THIS.AddObject("cnt_4c_Container3", "Container")
1773:             loc_oCnt = THIS.cnt_4c_Container3
1774:             WITH loc_oCnt
1775:                 .Top           = 373
1776:                 .Left          = 12
1777:                 .Width         = 708
1778:                 .Height        = 205

*-- Linhas 1805 a 1924:
1805:                 .FontSize          = 8
1806:                 .AllowHeaderSizing = .F.
1807:                 .AllowRowSizing    = .F.
1808:                 .DeleteMark        = .F.
1809:                 .RecordMark        = .F.
1810:                 .RowHeight         = 16
1811:                 .ScrollBars        = 2
1812:                 .GridLineColor     = RGB(238, 238, 238)
1813:                 .ReadOnly          = .T.
1814:                 .Visible           = .T.
1815: 
1816:                 .ColumnCount = 6
1817: 
1818:                 *-- Coluna 1 - Grupo (futuro TmpSaldG.Grupos)
1819:                 .Column1.ControlSource     = ""
1820:                 .Column1.Width             = 75
1821:                 .Column1.Movable           = .F.
1822:                 .Column1.Resizable         = .F.
1823:                 .Column1.ReadOnly          = .T.
1824:                 .Column1.Header1.FontName  = "Verdana"
1825:                 .Column1.Header1.FontSize  = 8
1826:                 .Column1.Header1.Alignment = 2
1827:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
1828:                 .Column1.Header1.Caption   = "Grupo"
1829:                 .Column1.Text1.FontSize    = 8
1830:                 .Column1.Text1.BorderStyle = 0
1831:                 .Column1.Text1.Margin      = 0
1832:                 .Column1.Text1.ReadOnly    = .T.
1833:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)
1834:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
1835: 
1836:                 *-- Coluna 2 - Conta (futuro TmpSaldG.Estos)
1837:                 .Column2.ControlSource     = ""
1838:                 .Column2.Width             = 75
1839:                 .Column2.Movable           = .F.
1840:                 .Column2.Resizable         = .F.
1841:                 .Column2.ReadOnly          = .T.
1842:                 .Column2.Header1.FontName  = "Verdana"
1843:                 .Column2.Header1.FontSize  = 8
1844:                 .Column2.Header1.Alignment = 2
1845:                 .Column2.Header1.ForeColor = RGB(36, 84, 155)
1846:                 .Column2.Header1.Caption   = "Conta"
1847:                 .Column2.Text1.FontSize    = 8
1848:                 .Column2.Text1.BorderStyle = 0
1849:                 .Column2.Text1.Margin      = 0
1850:                 .Column2.Text1.ReadOnly    = .T.
1851:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)
1852:                 .Column2.Text1.BackColor   = RGB(255, 255, 255)
1853: 
1854:                 *-- Coluna 3 - Atual
1855:                 .Column3.ControlSource     = ""
1856:                 .Column3.Width             = 70
1857:                 .Column3.Movable           = .F.
1858:                 .Column3.Resizable         = .F.
1859:                 .Column3.ReadOnly          = .T.
1860:                 .Column3.Header1.FontName  = "Verdana"
1861:                 .Column3.Header1.FontSize  = 8
1862:                 .Column3.Header1.Alignment = 2
1863:                 .Column3.Header1.ForeColor = RGB(36, 84, 155)
1864:                 .Column3.Header1.Caption   = "Atual"
1865:                 .Column3.Text1.FontSize    = 8
1866:                 .Column3.Text1.BorderStyle = 0
1867:                 .Column3.Text1.Margin      = 0
1868:                 .Column3.Text1.ReadOnly    = .T.
1869:                 .Column3.Text1.ForeColor   = RGB(0, 0, 0)
1870:                 .Column3.Text1.BackColor   = RGB(255, 255, 255)
1871: 
1872:                 *-- Coluna 4 - Utilizado (futuro TmpSaldG.Utilizar)
1873:                 .Column4.ControlSource     = ""
1874:                 .Column4.Width             = 70
1875:                 .Column4.Movable           = .F.
1876:                 .Column4.Resizable         = .F.
1877:                 .Column4.ReadOnly          = .T.
1878:                 .Column4.Header1.FontName  = "Verdana"
1879:                 .Column4.Header1.FontSize  = 8
1880:                 .Column4.Header1.Alignment = 2
1881:                 .Column4.Header1.ForeColor = RGB(36, 84, 155)
1882:                 .Column4.Header1.Caption   = "Utilizado"
1883:                 .Column4.Text1.FontSize    = 8
1884:                 .Column4.Text1.BorderStyle = 0
1885:                 .Column4.Text1.Margin      = 0
1886:                 .Column4.Text1.ReadOnly    = .T.
1887:                 .Column4.Text1.ForeColor   = RGB(0, 0, 0)
1888:                 .Column4.Text1.BackColor   = RGB(255, 255, 255)
1889: 
1890:                 *-- Coluna 5 - Disponivel (futuro TmpSaldG.Disps)
1891:                 .Column5.ControlSource     = ""
1892:                 .Column5.Width             = 80
1893:                 .Column5.Movable           = .F.
1894:                 .Column5.Resizable         = .F.
1895:                 .Column5.ReadOnly          = .T.
1896:                 .Column5.Header1.FontName  = "Verdana"
1897:                 .Column5.Header1.FontSize  = 8
1898:                 .Column5.Header1.Alignment = 2
1899:                 .Column5.Header1.ForeColor = RGB(36, 84, 155)
1900:                 .Column5.Header1.Caption   = "Dispon" + CHR(237) + "vel"
1901:                 .Column5.Text1.FontSize    = 8
1902:                 .Column5.Text1.BorderStyle = 0
1903:                 .Column5.Text1.Margin      = 0
1904:                 .Column5.Text1.ReadOnly    = .T.
1905:                 .Column5.Text1.ForeColor   = RGB(0, 0, 0)
1906:                 .Column5.Text1.BackColor   = RGB(255, 255, 255)
1907: 
1908:                 *-- Coluna 6 - Emp (futuro TmpSaldG.Estos - empresa/filial)
1909:                 .Column6.ControlSource     = ""
1910:                 .Column6.Width             = 64
1911:                 .Column6.Movable           = .F.
1912:                 .Column6.Resizable         = .F.
1913:                 .Column6.ReadOnly          = .T.
1914:                 .Column6.Header1.FontName  = "Verdana"
1915:                 .Column6.Header1.FontSize  = 8
1916:                 .Column6.Header1.Alignment = 2
1917:                 .Column6.Header1.ForeColor = RGB(36, 84, 155)
1918:                 .Column6.Header1.Caption   = "Emp"
1919:                 .Column6.Text1.FontSize    = 8
1920:                 .Column6.Text1.BorderStyle = 0
1921:                 .Column6.Text1.Margin      = 0
1922:                 .Column6.Text1.ReadOnly    = .T.
1923:                 .Column6.Text1.ForeColor   = RGB(0, 0, 0)
1924:                 .Column6.Text1.BackColor   = RGB(255, 255, 255)

*-- Linhas 2192 a 2217:
2192:                 ENDIF
2193: 
2194:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2195:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2196:                         "SELECT cpros, dpros, cunis FROM SigCdPro " + ;
2197:                         "WHERE cpros = " + EscaparSQL(loc_cValor), ;
2198:                         "cursor_4c_BuscaPedra")
2199: 
2200:                     IF loc_nResultado > 0 AND USED("cursor_4c_BuscaPedra") ;
2201:                        AND RECCOUNT("cursor_4c_BuscaPedra") = 1
2202:                         SELECT cursor_4c_BuscaPedra
2203:                         GO TOP
2204:                         THIS.AplicarPedraProduto(ALLTRIM(cursor_4c_BuscaPedra.cpros), ;
2205:                                                  ALLTRIM(cursor_4c_BuscaPedra.dpros), ;
2206:                                                  ALLTRIM(cursor_4c_BuscaPedra.cunis))
2207:                         loc_lAchou = .T.
2208:                     ENDIF
2209:                 ENDIF
2210: 
2211:                 IF USED("cursor_4c_BuscaPedra")
2212:                     USE IN cursor_4c_BuscaPedra
2213:                 ENDIF
2214: 
2215:                 *-- Sem casamento exato o legado abria a lista - NUNCA
2216:                 *-- MsgAviso("nao encontrado") + limpar o campo antes do
2217:                 *-- picker (anti-padrao ja registrado no CLAUDE.md).

*-- Linhas 2267 a 2285:
2267: 
2268:                 *-- Atribuicao SO sob a guarda de selecao
2269:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPedra")
2270:                     SELECT cursor_4c_BuscaPedra
2271:                     THIS.AplicarPedraProduto(ALLTRIM(cursor_4c_BuscaPedra.cpros), ;
2272:                                              ALLTRIM(cursor_4c_BuscaPedra.dpros), ;
2273:                                              ALLTRIM(cursor_4c_BuscaPedra.cunis))
2274:                 ENDIF
2275: 
2276:                 loc_oBusca.Release()
2277:             ENDIF
2278: 
2279:             IF USED("cursor_4c_BuscaPedra")
2280:                 USE IN cursor_4c_BuscaPedra
2281:             ENDIF
2282:         CATCH TO loc_oErro
2283:             MsgErro(loc_oErro.Message + CHR(13) + ;
2284:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2285:                 "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupPedraProduto")

*-- Linhas 2353 a 2378:
2353:                 ENDIF
2354: 
2355:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2356:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2357:                         "SELECT cpros, dpros FROM SigCdPro " + ;
2358:                         "WHERE cpros = " + EscaparSQL(loc_cValor), ;
2359:                         "cursor_4c_BuscaPedra2")
2360: 
2361:                     IF loc_nResultado > 0 AND USED("cursor_4c_BuscaPedra2") ;
2362:                        AND RECCOUNT("cursor_4c_BuscaPedra2") = 1
2363:                         SELECT cursor_4c_BuscaPedra2
2364:                         GO TOP
2365:                         THIS.AplicarPedraSubstituto(ALLTRIM(cursor_4c_BuscaPedra2.cpros))
2366:                         loc_lAchou = .T.
2367:                     ENDIF
2368:                 ENDIF
2369: 
2370:                 IF USED("cursor_4c_BuscaPedra2")
2371:                     USE IN cursor_4c_BuscaPedra2
2372:                 ENDIF
2373: 
2374:                 IF !loc_lAchou
2375:                     THIS.AbrirLookupPedraSubstituto()
2376:                 ENDIF
2377:             ENDIF
2378:         CATCH TO loc_oErro

*-- Linhas 2417 a 2435:
2417:                 ENDIF
2418: 
2419:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPedra2")
2420:                     SELECT cursor_4c_BuscaPedra2
2421:                     THIS.AplicarPedraSubstituto(ALLTRIM(cursor_4c_BuscaPedra2.cpros))
2422:                 ENDIF
2423: 
2424:                 loc_oBusca.Release()
2425:             ENDIF
2426: 
2427:             IF USED("cursor_4c_BuscaPedra2")
2428:                 USE IN cursor_4c_BuscaPedra2
2429:             ENDIF
2430:         CATCH TO loc_oErro
2431:             MsgErro(loc_oErro.Message + CHR(13) + ;
2432:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2433:                 "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupPedraSubstituto")
2434:         ENDTRY
2435: 

*-- Linhas 2451 a 2498:
2451:     *--------------------------------------------------------------------------
2452:     * PedraSubstitutoLostFocus - LostFocus da Column5.Text1 do GradePedra.
2453:     * Transcricao do legado:
2454:     *   SELECT SelPedra / xPosicao = RECNO() / Locate For Empty(Cpros)
2455:     *   If Eof() / Append Blank / EndIf
2456:     *   Locate for Recno() = xPosicao / KEYBOARD '{DNARROW}'
2457:     * Ou seja: garante que exista sempre UMA linha em branco no fim do
2458:     * cursor (para o usuario continuar digitando), volta para a linha em que
2459:     * estava e desce uma linha. PUBLIC (BINDEVENT).
2460:     *--------------------------------------------------------------------------
2461:     PROCEDURE PedraSubstitutoLostFocus()
2462:         LOCAL loc_nPosicao, loc_cAliasAnterior, loc_oErro
2463: 
2464:         TRY
2465:             IF USED("SelPedra")
2466:                 loc_cAliasAnterior = ALIAS()
2467: 
2468:                 SELECT SelPedra
2469:                 loc_nPosicao = RECNO("SelPedra")
2470: 
2471:                 LOCATE FOR EMPTY(SelPedra.Cpros)
2472:                 IF EOF("SelPedra")
2473:                     APPEND BLANK IN SelPedra
2474:                 ENDIF
2475: 
2476:                 *-- "Locate for Recno() = xPosicao" do legado: volta para o
2477:                 *-- registro em que o usuario estava
2478:                 IF loc_nPosicao > 0 AND loc_nPosicao <= RECCOUNT("SelPedra")
2479:                     GO loc_nPosicao IN SelPedra
2480:                 ENDIF
2481: 
2482:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
2483:                     SELECT (loc_cAliasAnterior)
2484:                 ENDIF
2485: 
2486:                 KEYBOARD "{DNARROW}"
2487:             ENDIF
2488:         CATCH TO loc_oErro
2489:             MsgErro(loc_oErro.Message + CHR(13) + ;
2490:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2491:                 "Procedure: " + loc_oErro.Procedure, "Erro em PedraSubstitutoLostFocus")
2492:         ENDTRY
2493:     ENDPROC
2494: 
2495:     *--------------------------------------------------------------------------
2496:     * PedrasAfterRowColChange - Reavalia, a cada troca de linha/coluna do
2497:     * grd_4c_Pedras, o gate que o legado escrevia no When das Column4/Column5:
2498:     *   "RETURN (Not EMPTY(ThisForm.Container4.GradePedra.Column1.Text1.Value))"

*-- Linhas 2537 a 2627:
2537:     * legado faz DEPOIS de montar a tela e da qual os eventos desta fase
2538:     * dependem (transcrito de SIGPRGLP.Init, dump linhas 2891-2959):
2539:     *
2540:     *   SELECT SelPedra / IF RECCOUNT() = 0 / APPEND BLANK    -> a grade de
2541:     *       Requisicoes (cmd_4c_Pedras) abre com UMA linha em branco pronta
2542:     *       para digitacao; sem isso o Click liga o grid a um cursor vazio.
2543:     *   Create Cursor TmpSaldU (Cpros c(14), KeySelm L)       -> marca os
2544:     *       produtos cujo estoque foi escolhido MANUALMENTE (consumido por
2545:     *       BtnConfirmarDispGrupoClick).
2546:     *   crSigCdCom (SigCdTpc + SigCdCom)                      -> tipos de
2547:     *       componente que entram no custo (consumido pelo AtualizaPeso).
2548:     *   Bind do grid do Container3 + Set Order/Set Key de TmpSaldG.
2549:     *   SetAll('ReadOnly', .t.) da grade principal quando SigCdPam.TransfRes
2550:     *       esta vazio (sem operacao de transferencia nao se edita Produzir).
2551:     *   Totais Tot_Qtd/Tot_Est/Tot_Prz somados de TmpFinal.
2552:     *
2553:     * Todos os cursores de trabalho chegam prontos do form pai, na
2554:     * DataSession privada compartilhada - por isso cada bloco eh guardado
2555:     * por USED(): em modo de teste de UI nenhum deles existe e o metodo
2556:     * simplesmente nao faz nada, sem erro.
2557:     *--------------------------------------------------------------------------
2558:     PROTECTED PROCEDURE PrepararCursoresDeTrabalho()
2559:         LOCAL loc_oErro, loc_nResultado, loc_cSQL
2560: 
2561:         TRY
2562:             *-- Linha em branco no SelPedra (Init legado)
2563:             IF USED("SelPedra")
2564:                 SELECT SelPedra
2565:                 IF RECCOUNT("SelPedra") = 0
2566:                     APPEND BLANK
2567:                 ENDIF
2568:             ENDIF
2569: 
2570:             *-- TmpSaldU - produtos com selecao MANUAL de estoque
2571:             IF !USED("TmpSaldU")
2572:                 CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L)
2573:                 INDEX ON Cpros TAG Cpros
2574:             ENDIF
2575: 
2576:             *-- crSigCdCom: "Select a.Tipos, a.Custos, b.CGrus From SigCdTpc a,
2577:             *-- SigCdCom b Where a.Tipos = b.Tipos" + "Index On Tipos + CGrus
2578:             *-- Tag Tipos" do Init legado. Vai para cursor temporario e dai
2579:             *-- para cursor READWRITE porque cursor de SQLEXEC nasce
2580:             *-- somente-leitura e nao aceita INDEX ON.
2581:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND !USED("crSigCdCom")
2582:                 loc_cSQL = "SELECT a.Tipos, a.Custos, b.CGrus" + ;
2583:                            "  FROM SigCdTpc a, SigCdCom b" + ;
2584:                            " WHERE a.Tipos = b.Tipos"
2585: 
2586:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ComTmp")
2587: 
2588:                 IF loc_nResultado >= 0 AND USED("cursor_4c_ComTmp")
2589:                     SELECT * FROM cursor_4c_ComTmp INTO CURSOR crSigCdCom READWRITE
2590:                     USE IN cursor_4c_ComTmp
2591:                     SELECT crSigCdCom
2592:                     INDEX ON Tipos + CGrus TAG Tipos
2593:                 ELSE
2594:                     MsgErro("Falha ao carregar os tipos de componente (crSigCdCom)." + ;
2595:                         CHR(13) + CapturarErroSQL(), "Erro")
2596:                 ENDIF
2597:             ENDIF
2598: 
2599:             *-- TmpSaldG na ordem/faixa do item corrente + bind do Container3
2600:             IF USED("TmpSaldG")
2601:                 SELECT TmpSaldG
2602:                 SET ORDER TO Cpros
2603:                 THIS.AplicarFaixaSaldoContas()
2604:                 THIS.LigarGradeContas()
2605:             ENDIF
2606: 
2607:             *-- "Select TmpFinal / Sum Saldo, Estoque, Produzir / Go Top" +
2608:             *-- os tres Tot_*.Value do Init legado. O GO TOP vem ANTES: o
2609:             *-- legado deixa o ponteiro no primeiro item, e BOParaForm
2610:             *-- preserva o RECNO corrente ao somar.
2611:             IF USED("TmpFinal")
2612:                 SELECT TmpFinal
2613:                 GO TOP
2614:             ENDIF
2615:             THIS.BOParaForm()
2616: 
2617:             *-- Estado inicial dos botoes de acao + o "If
2618:             *-- Empty(crSigCdPam.TransfRes) / .SetAll('ReadOnly', .t.)" do
2619:             *-- Init legado (a grade inteira vira somente-leitura sem a
2620:             *-- operacao de transferencia de reserva configurada)
2621:             THIS.AjustarBotoesPorModo()
2622:         CATCH TO loc_oErro
2623:             MsgErro(loc_oErro.Message + CHR(13) + ;
2624:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2625:                 "Procedure: " + loc_oErro.Procedure, "Erro em PrepararCursoresDeTrabalho")
2626:         ENDTRY
2627:     ENDPROC

*-- Linhas 2659 a 2677:
2659: 
2660:         TRY
2661:             IF USED("TmpSaldG")
2662:                 SELECT TmpSaldG
2663: 
2664:                 IF USED("TmpFinal") AND !EOF("TmpFinal")
2665:                     loc_cChave = TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
2666:                     *-- "]" quebraria o delimitador do literal montado abaixo;
2667:                     *-- nenhum codigo de produto/cor/tamanho o usa
2668:                     loc_cChave = STRTRAN(loc_cChave, "]", " ")
2669: 
2670:                     loc_cFiltro = "Cpros + CodCors + CodTams == [" + loc_cChave + "]"
2671:                     SET FILTER TO &loc_cFiltro
2672:                 ELSE
2673:                     SET FILTER TO
2674:                 ENDIF
2675: 
2676:                 GO TOP
2677:             ENDIF

*-- Linhas 2700 a 2723:
2700:         TRY
2701:             WITH THIS.cnt_4c_Container3.grd_4c_DispConta
2702:                 .RecordSource          = "TmpSaldG"
2703:                 .Column1.ControlSource = "TmpSaldG.Grupos"
2704:                 .Column2.ControlSource = "TmpSaldG.Estos"
2705:                 .Column3.ControlSource = "TmpSaldG.Saldo"
2706:                 .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
2707:                 .Column5.ControlSource = "TmpSaldG.Disps"
2708:                 .Column6.ControlSource = "TmpSaldG.Emps"
2709: 
2710:                 .SetAll("ReadOnly", .T.)
2711: 
2712:                 IF fChecaAcesso("SIGPRGLO", "PRIORIDADE")
2713:                     .Column6.ReadOnly              = .F.
2714:                     THIS.cmd_4c_SelEstoque.Enabled = .T.
2715:                 ENDIF
2716: 
2717:                 .Refresh()
2718:             ENDWITH
2719:         CATCH TO loc_oErro
2720:             MsgErro(loc_oErro.Message + CHR(13) + ;
2721:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2722:                 "Procedure: " + loc_oErro.Procedure, "Erro em LigarGradeContas")
2723:         ENDTRY

*-- Linhas 2811 a 2877:
2811:     * porque eh isso que o legado faz - e os valores dele divergem de
2812:     * proposito do SCX (Column1 = 80 e nao 108; Column3 = 24 e nao 38).
2813:     *
2814:     * "m." nos nomes das variaveis LOCAIS dentro do SELECT VFP local eh
2815:     * obrigatorio: sem ele o VFP resolve o identificador como COLUNA.
2816:     *
2817:     * _TALLY eh capturado na linha seguinte ao SELECT - no legado ele eh
2818:     * lido varias linhas adiante, o que so funciona por nao haver comando
2819:     * de dados no meio.
2820:     *--------------------------------------------------------------------------
2821:     PROCEDURE BtnDisponivelClick()
2822:         LOCAL loc_cCpro, loc_cCor, loc_nTally, loc_oErro
2823: 
2824:         TRY
2825:             IF !USED("TmpFinal") OR EOF("TmpFinal") OR !USED("TmpSaldo")
2826:                 MsgAviso("Nenhum item selecionado na grade.", ;
2827:                     "Aten" + CHR(231) + CHR(227) + "o")
2828:             ELSE
2829:                 loc_cCpro = TmpFinal.Cpros
2830:                 loc_cCor  = TmpFinal.CodCors
2831: 
2832:                 IF USED("TmpDisp")
2833:                     THIS.cnt_4c_Container2.grd_4c_DispProduto.RecordSource = ""
2834:                     USE IN TmpDisp
2835:                 ENDIF
2836: 
2837:                 SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
2838:                   FROM TmpSaldo ;
2839:                  WHERE Cpros   = m.loc_cCpro ;
2840:                    AND CodCors = m.loc_cCor ;
2841:                    AND Disps   > 0 ;
2842:                  ORDER BY Cpros, CodCors, CodTams ;
2843:                   INTO CURSOR TmpDisp READWRITE
2844: 
2845:                 loc_nTally = _TALLY
2846: 
2847:                 THIS.grd_4c_Itens.Enabled = .F.
2848: 
2849:                 IF loc_nTally = 0
2850:                     MsgAviso("N" + CHR(227) + "o Existe Estoque Dispon" + CHR(237) + ;
2851:                         "vel Em Nenhum Tamanho!!!", "Aten" + CHR(231) + CHR(227) + "o")
2852:                     THIS.BtnConfirmarDispProdutoClick()
2853:                 ELSE
2854:                     WITH THIS.cnt_4c_Container2.grd_4c_DispProduto
2855:                         .RecordSource = "TmpDisp"
2856:                         .ColumnCount  = 5
2857: 
2858:                         .Column1.ControlSource = "TmpDisp.Cpros"
2859:                         .Column2.ControlSource = "TmpDisp.CodCors"
2860:                         .Column3.ControlSource = "TmpDisp.CodTams"
2861:                         .Column4.ControlSource = "TmpDisp.Disps"
2862:                         .Column5.ControlSource = "TmpDisp.Utilizar"
2863: 
2864:                         .Column1.Width = 80
2865:                         .Column2.Width = 38
2866:                         .Column3.Width = 24
2867:                         .Column4.Width = 75
2868:                         .Column5.Width = 75
2869: 
2870:                         .Column1.Header1.Caption = "Produto"
2871:                         .Column2.Header1.Caption = "Cor"
2872:                         .Column3.Header1.Caption = "Tam"
2873:                         .Column4.Header1.Caption = "Disponivel"
2874:                         .Column5.Header1.Caption = "Utilizar"
2875:                     ENDWITH
2876: 
2877:                     THIS.cmd_4c_Processar.Enabled  = .F.

*-- Linhas 2924 a 2973:
2924:                     USE IN TmpDisp
2925:                 ENDIF
2926: 
2927:                 SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
2928:                        000000000.000 AS Utilizar ;
2929:                   FROM TmpSaldG ;
2930:                  WHERE Cpros   = m.loc_cCpro ;
2931:                    AND CodCors = m.loc_cCor ;
2932:                    AND CodTams = m.loc_cTam ;
2933:                    AND Disps   > 0 ;
2934:                   INTO CURSOR Resultado ;
2935:                  ORDER BY 1, 2, 3, 4
2936: 
2937:                 loc_nTally = _TALLY
2938: 
2939:                 SELECT 0
2940:                 USE DBF("Resultado") ALIAS TmpDisp AGAIN
2941:                 USE IN Resultado
2942: 
2943:                 THIS.grd_4c_Itens.Enabled = .F.
2944: 
2945:                 IF loc_nTally = 0
2946:                     MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + ;
2947:                         "vel !!!", "Aten" + CHR(231) + CHR(227) + "o")
2948:                     THIS.BtnConfirmarDispGrupoClick()
2949:                 ELSE
2950:                     WITH THIS.cnt_4c_Container5.grd_4c_DispGrupo
2951:                         .RecordSource = "TmpDisp"
2952:                         .ColumnCount  = 5
2953: 
2954:                         .Column1.ControlSource = "TmpDisp.Grupos"
2955:                         .Column2.ControlSource = "TmpDisp.Estos"
2956:                         .Column3.ControlSource = "TmpDisp.Priors"
2957:                         .Column4.ControlSource = "TmpDisp.Disps"
2958:                         .Column5.ControlSource = "TmpDisp.Utilizar"
2959: 
2960:                         .Column1.Width = 80
2961:                         .Column2.Width = 80
2962:                         .Column3.Width = 24
2963:                         .Column4.Width = 75
2964:                         .Column5.Width = 75
2965: 
2966:                         .Column1.Header1.Caption = "Grupo"
2967:                         .Column2.Header1.Caption = "Conta"
2968:                         .Column3.Header1.Caption = "Prior"
2969:                         .Column4.Header1.Caption = "Disponivel"
2970:                         .Column5.Header1.Caption = "Utilizar"
2971:                     ENDWITH
2972: 
2973:                     *-- Bloco do legado com o "Estoques" INCLUSO (eh o unico

*-- Linhas 3016 a 3053:
3016:                     THIS.cnt_4c_Container1.grd_4c_Linhas.RecordSource = ""
3017:                 ENDIF
3018: 
3019:                 SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, ;
3020:                        SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
3021:                   FROM TmpFinal ;
3022:                  GROUP BY 1 ;
3023:                  UNION ALL ;
3024:                 SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, ;
3025:                        SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
3026:                   FROM TmpFinal ;
3027:                  GROUP BY 1 ;
3028:                   INTO CURSOR TmpLinha ;
3029:                  ORDER BY 2, 1
3030: 
3031:                 WITH THIS.cnt_4c_Container1.grd_4c_Linhas
3032:                     .RecordSource = "TmpLinha"
3033:                     .ColumnCount  = 4
3034: 
3035:                     .Column1.ControlSource = "TmpLinha.Linhas"
3036:                     .Column2.ControlSource = "TmpLinha.Saldo"
3037:                     .Column3.ControlSource = "TmpLinha.Estoque"
3038:                     .Column4.ControlSource = "TmpLinha.Produzir"
3039: 
3040:                     .SetAll("DynamicFontBold",  "TmpLinha.Linhas = [TOTAIS]", "Column")
3041:                     .SetAll("DynamicForeColor", ;
3042:                         "IIF(TmpLinha.Linhas = [TOTAIS], RGB(0,0,255), RGB(0,0,0))", "Column")
3043:                 ENDWITH
3044: 
3045:                 *-- "Estoques" FORA do bloco (o legado nao o toca aqui)
3046:                 THIS.HabilitarCampos(.F., .F.)
3047:                 THIS.cnt_4c_Container1.Visible = .T.
3048: 
3049:                 THIS.cnt_4c_Container1.ZOrder(0)
3050:                 THIS.cnt_4c_Container1.grd_4c_Linhas.Refresh()
3051:                 THIS.cnt_4c_Container1.grd_4c_Linhas.Column1.SetFocus()
3052:             ENDIF
3053:         CATCH TO loc_oErro

*-- Linhas 3082 a 3104:
3082:                     .RecordSource = "SelPedra"
3083:                     .ColumnCount  = 5
3084: 
3085:                     .Column1.ControlSource = "SelPedra.Cpros"
3086:                     .Column2.ControlSource = "SelPedra.Dpros"
3087:                     .Column3.ControlSource = "SelPedra.Cunis"
3088:                     .Column4.ControlSource = "SelPedra.Qtds"
3089:                     .Column5.ControlSource = "SelPedra.Cpro2s"
3090:                 ENDWITH
3091: 
3092:                 *-- "Estoques" FORA do bloco (o legado nao o toca aqui)
3093:                 THIS.HabilitarCampos(.F., .F.)
3094:                 THIS.cnt_4c_Container4.Visible = .T.
3095: 
3096:                 THIS.cnt_4c_Container4.ZOrder(0)
3097:                 THIS.cnt_4c_Container4.grd_4c_Pedras.Refresh()
3098:                 THIS.cnt_4c_Container4.grd_4c_Pedras.Column1.SetFocus()
3099: 
3100:                 *-- Reaplica o gate do When legado (Qtde e Produto substituto
3101:                 *-- so liberam com o Produto preenchido) na linha em que o
3102:                 *-- grid acabou de pousar
3103:                 THIS.AjustarColunasPedra()
3104:             ENDIF

*-- Linhas 3119 a 3158:
3119:     * (que trata NULL como vazio), sem depender da resolucao do wrapper
3120:     * pelo PATH. Mesma forma ja usada no Column8 da grade principal.
3121:     *
3122:     * A descricao eh buscada produto a produto, como no legado ("Select
3123:     * Distinct Cpros ... Scan ... SqlExecute"): a consulta unica por IN
3124:     * seria mais rapida, mas mudaria a forma do acesso ao banco sem que o
3125:     * legado peca isso.
3126:     *--------------------------------------------------------------------------
3127:     PROCEDURE BtnRelatorioClick()
3128:         LOCAL loc_cSQL, loc_nResultado, loc_lProsseguir, loc_oErro
3129: 
3130:         TRY
3131:             loc_lProsseguir = .T.
3132: 
3133:             IF !USED("TmpFinal")
3134:                 MsgAviso("N" + CHR(227) + "o Existem Dados Para Impress" + CHR(227) + ;
3135:                     "o do Relat" + CHR(243) + "rio!!!", "Aten" + CHR(231) + CHR(227) + "o")
3136:                 loc_lProsseguir = .F.
3137:             ENDIF
3138: 
3139:             IF loc_lProsseguir
3140:                 SELECT Cpros, SPACE(50) AS DPros, CodCors, CodTams, Dopes, Numes, ;
3141:                        Saldo, Estoque, Produzir, ;
3142:                        IIF(ISNULL(TmpFinal.Obsps) OR EMPTY(TmpFinal.Obsps), " ", "*") AS ObsPs ;
3143:                   FROM TmpFinal ;
3144:                  ORDER BY Cpros, CodCors, CodTams, Dopes, Numes ;
3145:                   INTO CURSOR crImpressao READWRITE
3146: 
3147:                 GO TOP IN crImpressao
3148: 
3149:                 IF EOF("crImpressao")
3150:                     MsgAviso("N" + CHR(227) + "o Existem Dados Para Impress" + CHR(227) + ;
3151:                         "o do Relat" + CHR(243) + "rio!!!", ;
3152:                         "Aten" + CHR(231) + CHR(227) + "o")
3153:                     loc_lProsseguir = .F.
3154:                 ENDIF
3155:             ENDIF
3156: 
3157:             *-- Sem conexao o relatorio sairia com a coluna Descricao em
3158:             *-- branco, sem nenhum aviso - o legado nem chega a testar isso

*-- Linhas 3164 a 3219:
3164:             ENDIF
3165: 
3166:             IF loc_lProsseguir
3167:                 SELECT DISTINCT Cpros FROM crImpressao INTO CURSOR LocalProds
3168: 
3169:                 SELECT LocalProds
3170:                 SCAN
3171:                     loc_cSQL = "SELECT CPros, DPros" + ;
3172:                                "  FROM SigCdPro" + ;
3173:                                " WHERE CPros = " + EscaparSQL(LocalProds.CPros)
3174: 
3175:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "LocalBus")
3176: 
3177:                     IF loc_nResultado < 0
3178:                         MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
3179:                             CapturarErroSQL(), ;
3180:                             "Falha na Conex" + CHR(227) + "o (LocalBus)")
3181:                         loc_lProsseguir = .F.
3182:                         EXIT
3183:                     ENDIF
3184: 
3185:                     SELECT LocalBus
3186:                     GO TOP IN LocalBus
3187:                     IF !EOF("LocalBus")
3188:                         UPDATE crImpressao SET DPros = LocalBus.DPros ;
3189:                          WHERE CPros = LocalBus.CPros
3190:                     ENDIF
3191: 
3192:                     SELECT LocalProds
3193:                 ENDSCAN
3194: 
3195:                 IF USED("LocalBus")
3196:                     USE IN LocalBus
3197:                 ENDIF
3198:                 IF USED("LocalProds")
3199:                     USE IN LocalProds
3200:                 ENDIF
3201:             ENDIF
3202: 
3203:             IF loc_lProsseguir
3204:                 SELECT crImpressao
3205:                 GO TOP IN crImpressao
3206:                 THIS.ExecutarReportForm("SigReGlp", "PREVIEW", "crImpressao")
3207:             ENDIF
3208:         CATCH TO loc_oErro
3209:             MsgErro(loc_oErro.Message + CHR(13) + ;
3210:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3211:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnRelatorioClick")
3212:         ENDTRY
3213:     ENDPROC
3214: 
3215:     *--------------------------------------------------------------------------
3216:     * BtnCancelarClick - botao "Sair" (SIGPRGLP.Cancelar.Click).
3217:     * Descarta a transacao em aberto e fecha a tela SEM efetivar nada.
3218:     *
3219:     * "ThisForm.poDataMgr.RollBack()" do legado vira SQLROLLBACK no handle

*-- Linhas 3261 a 3342:
3261:     * Substituicoes de sintaxe (mesma semantica, forma valida em VFP9):
3262:     *   "=Afiel(Tfinal)"  -> AFIELDS() com LOCAL ARRAY (a funcao EXIGE
3263:     *       array declarado; LOCAL simples estoura em runtime)
3264:     *   "Scatter To Memvar / Append From Array Memvar" -> SCATTER MEMVAR
3265:     *       MEMO + APPEND BLANK + GATHER MEMVAR MEMO (copia do registro
3266:     *       inteiro; o MEMO preserva a observacao do item na linha
3267:     *       desmembrada, que continua sendo o MESMO item)
3268:     *   "?pQtd / ?pAqt / ?pIds" -> EscaparSQL/FormatarNumeroSQL conforme o
3269:     *       TIPO de cada coluna em SigMvIts (qtds/aqtds numeric(9,3),
3270:     *       codtams char(4), cidchaves char(20))
3271:     *
3272:     * EmpDopNums eh chave POSICIONAL char(29) = Emps char(3) + Dopes
3273:     * char(20) + Str(Numes, 6): o padding FAZ PARTE da chave, por isso
3274:     * PADR explicito e NUNCA ALLTRIM nas partes (regra #42).
3275:     *--------------------------------------------------------------------------
3276:     PROCEDURE BtnConfirmarDispProdutoClick()
3277:         LOCAL loc_nRegFinal, loc_nQtdUti, loc_nQtUtil, loc_nBaixa
3278:         LOCAL loc_cEdn, loc_cSQL, loc_nResultado, loc_lProsseguir
3279:         LOCAL loc_nQtd, loc_nAQtd, loc_cIds, loc_cExactOrig, loc_oErro
3280:         LOCAL ARRAY loc_aTFinal[1]
3281: 
3282:         TRY
3283:             loc_lProsseguir = .T.
3284: 
3285:             IF USED("TmpFinal") AND USED("TmpDisp")
3286:                 SELECT TmpFinal
3287:                 loc_nRegFinal = RECNO()
3288: 
3289:                 SELECT TmpDisp
3290:                 loc_nQtdUti = 0
3291:                 SUM Utilizar TO loc_nQtdUti
3292: 
3293:                 *-- Sem conexao nao da para acertar o item da O.P. em
3294:                 *-- SigMvIts, e o legado so descobre isso NO MEIO do laco -
3295:                 *-- quando TmpFinal/TmpSaldo/TmpSaldG ja foram alterados e o
3296:                 *-- "Return 0" deixa a divisao pela metade. Conferir ANTES de
3297:                 *-- mexer em qualquer cursor evita esse estado parcial.
3298:                 IF loc_nQtdUti > 0 AND !(TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
3299:                     MsgErro("Sem conex" + CHR(227) + "o com o banco de dados - n" + CHR(227) + ;
3300:                         "o " + CHR(233) + " poss" + CHR(237) + "vel confirmar a sele" + ;
3301:                         CHR(231) + CHR(227) + "o de estoque.", ;
3302:                         "Falha na Conex" + CHR(227) + "o")
3303:                     loc_lProsseguir = .F.
3304:                 ENDIF
3305: 
3306:                 IF loc_lProsseguir AND loc_nQtdUti > 0
3307:                     SELECT TmpFinal
3308:                     =AFIELDS(loc_aTFinal)
3309:                     CREATE CURSOR Temporario FROM ARRAY loc_aTFinal
3310: 
3311:                     SELECT TmpDisp
3312:                     SCAN
3313:                         IF TmpDisp.Utilizar = 0
3314:                             LOOP
3315:                         ENDIF
3316: 
3317:                         loc_nQtUtil = TmpDisp.Utilizar
3318: 
3319:                         =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, "TmpSaldo")
3320: 
3321:                         *-- Desmembra a linha corrente de TmpFinal: o tamanho
3322:                         *-- escolhido vira uma linha nova ja coberta por
3323:                         *-- estoque, e o restante fica na linha original
3324:                         SELECT TmpFinal
3325:                         SCATTER MEMVAR MEMO
3326: 
3327:                         SELECT Temporario
3328:                         APPEND BLANK
3329:                         GATHER MEMVAR MEMO
3330:                         REPLACE Saldo    WITH loc_nQtUtil, ;
3331:                                 CodTams  WITH TmpDisp.CodTams, ;
3332:                                 Estoque  WITH loc_nQtUtil, ;
3333:                                 Produzir WITH 0 IN Temporario
3334: 
3335:                         REPLACE Saldo    WITH TmpFinal.Saldo    - loc_nQtUtil IN TmpFinal
3336:                         REPLACE Produzir WITH TmpFinal.Produzir - loc_nQtUtil IN TmpFinal
3337:                         REPLACE Disps    WITH TmpSaldo.Disps    - loc_nQtUtil IN TmpSaldo
3338: 
3339:                         *-- Redistribui a baixa entre as contas de TmpSaldG,
3340:                         *-- da primeira com saldo em diante.
3341:                         *--
3342:                         *-- Os dois SEEK abaixo usam chave PARCIAL (22 dos 44

*-- Linhas 3351 a 3369:
3351:                         loc_cExactOrig = SET("EXACT")
3352:                         SET EXACT OFF
3353: 
3354:                         SELECT TmpSaldG
3355:                         SET ORDER TO Cpros
3356:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
3357:                         REPLACE Disps WITH Saldo ;
3358:                           WHILE Cpros   = TmpSaldo.Cpros ;
3359:                             AND CodCors = TmpSaldo.CodCors ;
3360:                             AND CodTams = TmpSaldo.CodTams
3361: 
3362:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
3363:                         SCAN WHILE Cpros   = TmpSaldo.Cpros ;
3364:                                AND CodCors = TmpSaldo.CodCors ;
3365:                                AND CodTams = TmpSaldo.CodTams ;
3366:                                AND loc_nBaixa > 0
3367:                             IF TmpSaldG.Disps >= loc_nBaixa
3368:                                 REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nBaixa
3369:                                 loc_nBaixa = 0

*-- Linhas 3379 a 3475:
3379:                         loc_cEdn = PADR(TmpFinal.Emps, 3) + PADR(TmpFinal.Dopes, 20) + ;
3380:                                    STR(TmpFinal.Numes, 6)
3381: 
3382:                         loc_cSQL = "SELECT *" + ;
3383:                                    "  FROM SigMvIts" + ;
3384:                                    " WHERE empdopnums = " + EscaparSQL(loc_cEdn) + ;
3385:                                    "   AND cpros = " + EscaparSQL(TmpFinal.Cpros)
3386: 
3387:                         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TempEsti2")
3388: 
3389:                         IF loc_nResultado < 0
3390:                             MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
3391:                                 CapturarErroSQL(), ;
3392:                                 "Falha na Conex" + CHR(227) + "o (TempEsti2 - 3)")
3393:                             loc_lProsseguir = .F.
3394:                             EXIT
3395:                         ENDIF
3396: 
3397:                         SELECT TempEsti2
3398:                         SCAN
3399:                             IF TempEsti2.Citens <> TmpFinal.Citens
3400:                                 LOOP
3401:                             ENDIF
3402: 
3403:                             IF TempEsti2.CodCors = TmpFinal.CodCors ;
3404:                                     AND TempEsti2.CodTams = SPACE(4)
3405: 
3406:                                 SCATTER MEMVAR
3407: 
3408:                                 loc_nQtd  = loc_nQtUtil
3409:                                 loc_nAQtd = TempEsti2.Qtds
3410:                                 loc_cIds  = TempEsti2.cIdChaves
3411: 
3412:                                 loc_cSQL = "UPDATE SigMvIts" + ;
3413:                                            "   SET codtams = " + EscaparSQL(LEFT(TmpDisp.CodTams, 4)) + ;
3414:                                            "     , qtds    = " + FormatarNumeroSQL(loc_nQtd,  3) + ;
3415:                                            "     , aqtds   = " + FormatarNumeroSQL(loc_nAQtd, 3) + ;
3416:                                            " WHERE cidchaves = " + EscaparSQL(loc_cIds)
3417: 
3418:                                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
3419: 
3420:                                 IF loc_nResultado < 0
3421:                                     MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
3422:                                         CapturarErroSQL(), ;
3423:                                         "Falha na Conex" + CHR(227) + "o (Update - 9)")
3424:                                     loc_lProsseguir = .F.
3425:                                     EXIT
3426:                                 ENDIF
3427: 
3428:                                 *-- Sobra do item original entra no cursor de
3429:                                 *-- itens que o Processar grava depois
3430:                                 IF USED("crSigMvIts")
3431:                                     SELECT crSigMvIts
3432:                                     APPEND BLANK
3433:                                     GATHER MEMVAR
3434:                                     REPLACE Qtds      WITH Qtds - loc_nQtUtil
3435:                                     REPLACE AQtds     WITH Qtds
3436:                                     REPLACE cIdChaves WITH fUniqueIds()
3437:                                     IF crSigMvIts.Qtds = 0
3438:                                         DELETE
3439:                                     ENDIF
3440:                                 ENDIF
3441: 
3442:                                 SELECT TempEsti2
3443:                                 EXIT
3444:                             ENDIF
3445:                         ENDSCAN
3446: 
3447:                         IF !loc_lProsseguir
3448:                             EXIT
3449:                         ENDIF
3450: 
3451:                         SELECT TmpDisp
3452:                     ENDSCAN
3453: 
3454:                     IF loc_lProsseguir
3455:                         SELECT TmpFinal
3456:                         IF TmpFinal.Saldo = 0
3457:                             DELETE
3458:                         ENDIF
3459:                         SELECT TmpFinal
3460:                         APPEND FROM DBF("Temporario")
3461:                         GO loc_nRegFinal
3462: 
3463:                         =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
3464:                     ENDIF
3465: 
3466:                     IF USED("Temporario")
3467:                         USE IN Temporario
3468:                     ENDIF
3469:                     IF USED("TempEsti2")
3470:                         USE IN TempEsti2
3471:                     ENDIF
3472:                 ENDIF
3473:             ENDIF
3474: 
3475:             THIS.RestaurarGradePrincipal(THIS.cnt_4c_Container2, .F.)

*-- Linhas 3498 a 3554:
3498: 
3499:         TRY
3500:             IF USED("TmpFinal") AND USED("TmpDisp")
3501:                 SELECT TmpFinal
3502:                 loc_nRegFinal = RECNO()
3503: 
3504:                 SELECT TmpDisp
3505:                 loc_nQtdUti = 0
3506:                 SUM Utilizar TO loc_nQtdUti
3507: 
3508:                 IF loc_nQtdUti > 0
3509:                     SELECT TmpDisp
3510:                     SCAN
3511:                         IF TmpDisp.Utilizar = 0
3512:                             LOOP
3513:                         ENDIF
3514: 
3515:                         loc_nQtUtil = TmpDisp.Utilizar
3516: 
3517:                         =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, "TmpSaldo")
3518: 
3519:                         SELECT TmpFinal
3520:                         REPLACE Produzir WITH Produzir - loc_nQtUtil IN TmpFinal
3521:                         REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir IN TmpFinal
3522: 
3523:                         SELECT TmpSaldo
3524:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nQtUtil
3525: 
3526:                         IF USED("TmpSaldU")
3527:                             IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
3528:                                 INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
3529:                             ENDIF
3530:                             REPLACE KeySelm WITH .T. IN TmpSaldU
3531:                         ENDIF
3532: 
3533:                         SELECT TmpSaldG
3534:                         SET ORDER TO Cpros
3535:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + ;
3536:                               STR(TmpDisp.Priors, 2) + TmpDisp.Grupos + TmpDisp.Estos)
3537:                         REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nQtUtil
3538: 
3539:                         SELECT TmpDisp
3540:                     ENDSCAN
3541: 
3542:                     =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
3543:                 ENDIF
3544:             ENDIF
3545: 
3546:             THIS.RestaurarGradePrincipal(THIS.cnt_4c_Container5, .T.)
3547:         CATCH TO loc_oErro
3548:             MsgErro(loc_oErro.Message + CHR(13) + ;
3549:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3550:                 "Procedure: " + loc_oErro.Procedure, ;
3551:                 "Erro em BtnConfirmarDispGrupoClick")
3552:         ENDTRY
3553:     ENDPROC
3554: 

*-- Linhas 3620 a 3658:
3620:     * GradeItensAfterRowColChange - Transcricao de SIGPRGLP.GradeItens.
3621:     * AfterRowColChange. A cada troca de linha/coluna da grade principal:
3622:     * atualiza a observacao do item (memo TmpFinal.Obsps, ligado direto por
3623:     * ControlSource em PrepararCursoresDeTrabalho), refaz a faixa/bind do
3624:     * Container3 (Estoque Disponivel por Conta) para o item corrente e
3625:     * recarrega a foto do produto (SigCdPro.FigJpgs, base64).
3626:     *
3627:     * "ThisForm.poDataMgr.CursorQuery" do legado (helper do Fortyus que nao
3628:     * foi portado) vira SQLEXEC direto em cursor descartavel.
3629:     *--------------------------------------------------------------------------
3630:     PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
3631:         LOCAL loc_cArquivo, loc_cFoto, loc_oErro
3632: 
3633:         TRY
3634:             IF USED("TmpFinal") AND !EOF("TmpFinal")
3635:                 THIS.obj_4c_ObsItens.Refresh()
3636:                 THIS.lbl_4c_TxtObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ;
3637:                     ALLTRIM(TmpFinal.Cpros)
3638: 
3639:                 IF USED("TmpSaldo")
3640:                     =SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
3641:                 ENDIF
3642: 
3643:                 *-- "Select TmpSaldG / Set Order To Cpros / Set Key To ... /
3644:                 *-- Go Top" do legado - a faixa via SET KEY parcial nao
3645:                 *-- funciona sob o SET EXACT ON deste projeto (ver comentario
3646:                 *-- de AplicarFaixaSaldoContas); reusa o mesmo metodo que ja
3647:                 *-- resolve isso com SET FILTER congelado
3648:                 THIS.AplicarFaixaSaldoContas()
3649: 
3650:                 WITH THIS.cnt_4c_Container3
3651:                     IF USED("TmpSaldo") AND !EOF("TmpSaldo")
3652:                         .txt_4c_TotQtd.Value = TmpSaldo.Saldo
3653:                         .txt_4c_TotEst.Value = TmpSaldo.Saldo - TmpSaldo.Disps
3654:                         .txt_4c_TotPrz.Value = TmpSaldo.Disps
3655:                     ENDIF
3656: 
3657:                     .lbl_4c_Label1.Caption = ALLTRIM(TmpFinal.Cpros) + ;
3658:                         IIF(!EMPTY(TmpFinal.CodCors), "Cor:" + ALLTRIM(TmpFinal.CodCors), "") + ;

*-- Linhas 3670 a 3693:
3670:                         ENDIF
3671: 
3672:                         IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3673:                             SQLEXEC(gnConnHandle, ;
3674:                                 "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
3675:                                 EscaparSQL(ALLTRIM(TmpSaldG.Estos)), "TmpConta")
3676:                             SQLEXEC(gnConnHandle, ;
3677:                                 "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
3678:                                 EscaparSQL(ALLTRIM(TmpSaldG.Grupos)), "TmpGrupo")
3679:                         ENDIF
3680: 
3681:                         IF USED("TmpGrupo") AND !EOF("TmpGrupo")
3682:                             .txt_4c_GetDGrupo.Value = ALLTRIM(TratarNulo(TmpGrupo.Descrs, ""))
3683:                         ENDIF
3684:                         IF USED("TmpConta") AND !EOF("TmpConta")
3685:                             .txt_4c_GetDConta.Value = ALLTRIM(TratarNulo(TmpConta.Rclis, ""))
3686:                         ENDIF
3687: 
3688:                         IF USED("TmpConta")
3689:                             USE IN TmpConta
3690:                         ENDIF
3691:                         IF USED("TmpGrupo")
3692:                             USE IN TmpGrupo
3693:                         ENDIF

*-- Linhas 3701 a 3721:
3701:                     USE IN crSigCdPro_4c_Foto
3702:                 ENDIF
3703:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3704:                     SQLEXEC(gnConnHandle, ;
3705:                         "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + ;
3706:                         EscaparSQL(ALLTRIM(TmpFinal.Cpros)), "crSigCdPro_4c_Foto")
3707:                 ENDIF
3708: 
3709:                 loc_cArquivo = ADDBS(SYS(2023)) + "TempGlb.jpg"
3710: 
3711:                 CLEAR RESOURCES
3712:                 THIS.img_4c_ImgFigJpg.Picture = ""
3713:                 THIS.img_4c_ImgFigJpg.Visible = .F.
3714: 
3715:                 IF USED("crSigCdPro_4c_Foto") AND !EOF("crSigCdPro_4c_Foto") AND ;
3716:                         !ISNULL(crSigCdPro_4c_Foto.FigJpgs) AND !EMPTY(crSigCdPro_4c_Foto.FigJpgs)
3717:                     loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(crSigCdPro_4c_Foto.FigJpgs, ;
3718:                         "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
3719:                         "data:image/jpg;base64,", ""), 14)
3720: 
3721:                     IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0

*-- Linhas 3728 a 3746:
3728:                     USE IN crSigCdPro_4c_Foto
3729:                 ENDIF
3730: 
3731:                 SELECT TmpFinal
3732:             ENDIF
3733:         CATCH TO loc_oErro
3734:             MsgErro(loc_oErro.Message + CHR(13) + ;
3735:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3736:                 "Procedure: " + loc_oErro.Procedure, "Erro em GradeItensAfterRowColChange")
3737:         ENDTRY
3738:     ENDPROC
3739: 
3740:     *--------------------------------------------------------------------------
3741:     * ItemFocoColunaProduzir - GotFocus das demais colunas da grade principal
3742:     * (Column1/3/4/5/7/8 - legado: "ThisForm.GradeItens.Column6.Text1.
3743:     * SetFocus"). Column2 e Column9 nao tem esse redirecionamento no dump.
3744:     *--------------------------------------------------------------------------
3745:     PROCEDURE ItemFocoColunaProduzir()
3746:         THIS.grd_4c_Itens.Column6.SetFocus()

*-- Linhas 3768 a 3793:
3768:                     ENDIF
3769: 
3770:                     IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3771:                         SQLEXEC(gnConnHandle, ;
3772:                             "SELECT CGrus FROM SigCdPro WHERE Cpros = " + ;
3773:                             EscaparSQL(ALLTRIM(TmpFinal.Cpros)), "TempPro")
3774: 
3775:                         IF USED("TempPro") AND !EOF("TempPro")
3776:                             SQLEXEC(gnConnHandle, ;
3777:                                 "SELECT TipoEstos FROM SigCdGrp WHERE CGrus = " + ;
3778:                                 EscaparSQL(ALLTRIM(TempPro.CGrus)), "TempGru")
3779: 
3780:                             IF USED("TempGru") AND !EOF("TempGru") AND ;
3781:                                     INLIST(TempGru.TipoEstos, 3, 4)
3782:                                 THIS.cmd_4c_Disponivel.Enabled = .T.
3783:                             ENDIF
3784:                         ENDIF
3785:                     ENDIF
3786: 
3787:                     IF USED("TempGru")
3788:                         USE IN TempGru
3789:                     ENDIF
3790:                     IF USED("TempPro")
3791:                         USE IN TempPro
3792:                     ENDIF
3793:                 ENDIF

*-- Linhas 3833 a 3856:
3833:             loc_oTxt = THIS.grd_4c_Itens.Column6.Text1
3834: 
3835:             IF !USED("TmpSaldU")
3836:                 CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L)
3837:                 INDEX ON Cpros TAG Cpros
3838:             ENDIF
3839: 
3840:             IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
3841:                 INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
3842:             ENDIF
3843: 
3844:             IF loc_oTxt.Value <> THIS.this_nProduzirValorAnterior AND TmpSaldU.KeySelm
3845:                 loc_lConfirma = MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque." + ;
3846:                     CHR(13) + "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. " + ;
3847:                     "Deseja Continuar?", "Aten" + CHR(231) + CHR(227) + "o")
3848:                 IF !loc_lConfirma
3849:                     loc_oTxt.Value = THIS.this_nProduzirValorAnterior
3850:                     loc_oTxt.Refresh()
3851:                     RETURN
3852:                 ENDIF
3853:             ENDIF
3854: 
3855:             DO CASE
3856:                 CASE loc_oTxt.Value = THIS.this_nProduzirValorAnterior

*-- Linhas 3884 a 3902:
3884:                         loc_cExactOrig = SET("EXACT")
3885:                         SET EXACT OFF
3886: 
3887:                         SELECT TmpSaldG
3888:                         SET ORDER TO Cpros
3889:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
3890:                         REPLACE Disps WITH Saldo ;
3891:                           WHILE Cpros   = TmpSaldo.Cpros ;
3892:                             AND CodCors = TmpSaldo.CodCors ;
3893:                             AND CodTams = TmpSaldo.CodTams
3894:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
3895:                         SCAN WHILE Cpros   = TmpSaldo.Cpros ;
3896:                                AND CodCors = TmpSaldo.CodCors ;
3897:                                AND CodTams = TmpSaldo.CodTams ;
3898:                                AND loc_nBaixa > 0
3899:                             IF TmpSaldG.Disps >= loc_nBaixa
3900:                                 REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nBaixa
3901:                                 loc_nBaixa = 0
3902:                             ELSE

*-- Linhas 3983 a 4001:
3983:                 loc_oTxt.Value = 0
3984:                 loc_oTxt.Refresh()
3985:             ELSE
3986:                 SELECT TmpDisp
3987:                 loc_nRegDisp = RECNO()
3988:                 loc_nQtdUti  = 0
3989:                 SUM Utilizar TO loc_nQtdUti
3990:                 IF loc_nRegDisp > 0 AND loc_nRegDisp <= RECCOUNT("TmpDisp")
3991:                     GO loc_nRegDisp IN TmpDisp
3992:                 ENDIF
3993: 
3994:                 IF loc_nQtdUti > TmpFinal.Saldo
3995:                     MsgAviso("A Qtde. Selecionada N" + CHR(227) + "o Pode Ser Maior Que a Qtde. " + ;
3996:                         "Pedida!!!", "Aten" + CHR(231) + CHR(227) + "o")
3997:                     loc_oTxt.Value = 0
3998:                     loc_oTxt.Refresh()
3999:                 ELSE
4000:                     THIS.cnt_4c_Container2.txt_4c_QtSelec.Value = loc_nQtdUti
4001:                     THIS.cnt_4c_Container2.txt_4c_QtSelec.Refresh()

*-- Linhas 4047 a 4065:
4047:                     loc_oTxt.Value = 0
4048:                     loc_oTxt.Refresh()
4049:                 ELSE
4050:                     SELECT TmpDisp
4051:                     loc_nRegDisp = RECNO()
4052:                     loc_nQtdUti  = 0
4053:                     SUM Utilizar TO loc_nQtdUti
4054:                     IF loc_nRegDisp > 0 AND loc_nRegDisp <= RECCOUNT("TmpDisp")
4055:                         GO loc_nRegDisp IN TmpDisp
4056:                     ENDIF
4057: 
4058:                     IF loc_nQtdUti > TmpFinal.Saldo - TmpFinal.Estoque
4059:                         MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde " + ;
4060:                             "Solicitada...", "Aten" + CHR(231) + CHR(227) + "o")
4061:                         loc_oTxt.Value = 0
4062:                         loc_oTxt.Refresh()
4063:                     ELSE
4064:                         THIS.cnt_4c_Container5.txt_4c_QtSelec.Value = loc_nQtdUti
4065:                         THIS.cnt_4c_Container5.txt_4c_QtSelec.Refresh()

*-- Linhas 4278 a 4315:
4278:     * reatribuir RecordSource faz o VFP recalcular Column.Width para o default
4279:     * 90 e zerar Header1.Caption (Problema 48), por isso o rebind passa por
4280:     * LigarGradeItens(), que repoe as tres coisas na ordem canonica
4281:     * (RecordSource -> ControlSource -> ColumnOrder -> Width -> Header).
4282:     *--------------------------------------------------------------------------
4283:     PROCEDURE CarregarLista()
4284:         LOCAL loc_lSucesso, loc_oErro
4285:         loc_lSucesso = .F.
4286: 
4287:         TRY
4288:             IF !USED("TmpFinal")
4289:                 *-- Os cursores de trabalho sao recebidos prontos do form pai
4290:                 *-- na DataSession compartilhada; sem eles nao ha o que exibir
4291:                 THIS.LimparCampos()
4292:                 MsgAviso("Os itens da pr" + CHR(233) + "via n" + CHR(227) + "o foram recebidos " + ;
4293:                     "da tela de Processamento de O.P.", ;
4294:                     "Aten" + CHR(231) + CHR(227) + "o")
4295:             ELSE
4296:                 IF UPPER(ALLTRIM(THIS.grd_4c_Itens.RecordSource)) != "TMPFINAL"
4297:                     THIS.LigarGradeItens()
4298:                 ENDIF
4299: 
4300:                 SELECT TmpFinal
4301:                 GO TOP IN TmpFinal
4302:                 THIS.grd_4c_Itens.Refresh()
4303: 
4304:                 *-- Totais do rodape + Caption + rotulo da observacao
4305:                 THIS.BOParaForm()
4306: 
4307:                 *-- Faixa do painel "Estoque Disponivel por Conta" (Container3)
4308:                 *-- no item que ficou corrente
4309:                 THIS.AplicarFaixaSaldoContas()
4310:                 THIS.cnt_4c_Container3.grd_4c_DispConta.Refresh()
4311: 
4312:                 IF RECCOUNT("TmpFinal") = 0
4313:                     THIS.LimparCampos()
4314:                 ENDIF
4315: 

*-- Linhas 4328 a 4370:
4328:     * LigarGradeItens - (Re)ligacao da grade principal a TmpFinal, transcrita
4329:     * de "With .GradeItens ... EndWith" do Init legado.
4330:     *
4331:     * ORDEM OBRIGATORIA: RecordSource -> ControlSource -> ColumnOrder ->
4332:     * Width -> Header1.Caption. RecordSource reseta Width e Caption, por isso
4333:     * os dois vem por ULTIMO (Problema 48 / CLAUDE.md regra #35c). Os valores
4334:     * sao os mesmos declarados em ConfigurarGradeItens (SCX legado).
4335:     *
4336:     * Column8 exibe uma EXPRESSAO (marcador "*" quando o item tem observacao),
4337:     * nao uma coluna - igual ao legado.
4338:     *--------------------------------------------------------------------------
4339:     PROTECTED PROCEDURE LigarGradeItens()
4340:         LOCAL loc_oErro
4341: 
4342:         TRY
4343:             WITH THIS.grd_4c_Itens
4344:                 .ColumnCount  = 9
4345:                 .RecordSource = "TmpFinal"
4346: 
4347:                 .Column1.ControlSource = "TmpFinal.Cpros"
4348:                 .Column2.ControlSource = "TmpFinal.CodCors"
4349:                 .Column3.ControlSource = "TmpFinal.Dopes"
4350:                 .Column4.ControlSource = "TmpFinal.Numes"
4351:                 .Column5.ControlSource = "TmpFinal.Saldo"
4352:                 .Column6.ControlSource = "TmpFinal.Produzir"
4353:                 .Column7.ControlSource = "TmpFinal.Estoque"
4354:                 .Column8.ControlSource = [IIF(ISNULL(TmpFinal.Obsps) OR EMPTY(TmpFinal.Obsps), "", "*")]
4355:                 .Column9.ControlSource = "TmpFinal.CodTams"
4356: 
4357:                 .Column2.ColumnOrder = 6
4358:                 .Column3.ColumnOrder = 8
4359:                 .Column4.ColumnOrder = 9
4360:                 .Column5.ColumnOrder = 7
4361:                 .Column6.ColumnOrder = 4
4362:                 .Column7.ColumnOrder = 5
4363:                 .Column8.ColumnOrder = 2
4364:                 .Column9.ColumnOrder = 3
4365: 
4366:                 .Column1.Width = 115
4367:                 .Column2.Width = 80
4368:                 .Column3.Width = 80
4369:                 .Column4.Width = 38
4370:                 .Column5.Width = 80

*-- Linhas 4396 a 4414:
4396:     *
4397:     * Os campos editaveis desta tela vivem em CURSOR, nao em TextBox: a
4398:     * coluna "Produzir" (TmpFinal.Produzir) e as colunas "Utilizar" dos dois
4399:     * paineis de estoque estao ligadas por ControlSource e o BO le os
4400:     * cursores diretamente - por isso o que sobe aqui sao os parametros de
4401:     * MODO, que o Init legado le do form AVO (FormSigPrGlo, a tela de
4402:     * Processamento de O.P.) e guarda em variaveis do proprio form:
4403:     *
4404:     *   _Prev    = Thisform.ParentForm.ParentForm.Container1.Get_Previsao.Value
4405:     *   _DtGera  = ... Get_Geracao.Value
4406:     *   _lcTpGOp = ... Get_TpGOp.Value
4407:     *   GerPorTp = Not Empty(_lcTpGOp)
4408:     *
4409:     * mais o SigKey (CrSigCdPac.sigKeys), relido aqui porque o form pai pode
4410:     * ter repopulado CrSigCdPac entre a abertura desta tela e o Processar.
4411:     *
4412:     * Retorna .F. (com mensagem) quando o avo nao esta acessivel - o
4413:     * chamador ABORTA a gravacao nesse caso, em vez de processar com data de
4414:     * previsao/geracao vazias.

*-- Linhas 4466 a 4484:
4466:     * legado recalcula em tres pontos diferentes com o MESMO codigo (Init,
4467:     * Column6.LostFocus e o retorno dos paineis de estoque):
4468:     *
4469:     *   Select TmpFinal / Sum Saldo, Estoque, Produzir To lnSal, lnEst, lnPrz
4470:     *   .Tot_Qtd.Value = lnSal / .Tot_Est.Value = lnEst / .Tot_Prz.Value = lnPrz
4471:     *
4472:     * SUM percorre o cursor inteiro e deixa o ponteiro em EOF - o RECNO() eh
4473:     * guardado antes e restaurado depois, senao a linha corrente da grade
4474:     * (e a faixa do Container3, que depende dela) se perde a cada total.
4475:     *
4476:     * Tambem repoe o Caption (Globalizacao x Reserva Automatica, do Init
4477:     * legado) e o rotulo da observacao do item corrente.
4478:     *--------------------------------------------------------------------------
4479:     PROTECTED PROCEDURE BOParaForm()
4480:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_cCaption, loc_oErro
4481: 
4482:         TRY
4483:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
4484:                 loc_cCaption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"

*-- Linhas 4491 a 4509:
4491:             ENDIF
4492: 
4493:             IF USED("TmpFinal")
4494:                 SELECT TmpFinal
4495:                 loc_nRecno = RECNO()
4496:                 loc_nSal   = 0
4497:                 loc_nEst   = 0
4498:                 loc_nPrz   = 0
4499: 
4500:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
4501: 
4502:                 IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("TmpFinal")
4503:                     GO loc_nRecno IN TmpFinal
4504:                 ENDIF
4505: 
4506:                 THIS.txt_4c_TotQtd.Value = loc_nSal
4507:                 THIS.txt_4c_TotEst.Value = loc_nEst
4508:                 THIS.txt_4c_TotPrz.Value = loc_nPrz
4509: 

