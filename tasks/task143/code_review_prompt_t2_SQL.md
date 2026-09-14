# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SERVICOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: AMARRACAO, CMATS, NOPS, CPROS, QTEQUALPS, CESTOS, CTRLLOTES, LCMASK, NENVS, FATORS, SERVAUTO, CHKQTDPS, TRFPESA, DOPPS, CGRUS, VALUE, ICLIS, EMPS, MERCS, SEMIACABS, GRUPOS, CODACBS, CODS, RATEIO, CHKPESOS, PO, CUNIPS, XDIFP, XDIFP2, MENFALHAS, DIFPESAGS, BPESOS, LNSINAL, CUNIS, NDOPES, EMPDOPNUMS, CORES, TAMS, _CMATS, _NOPS, CRETRABS, CONTADS, CONTAOS, GRODNS, TPOPS, EMPDNPS, SEPPEDRAS, _DISPMFAS, _DISPENVE, TOTA, OS, QTDS, PESOS, CHKSUBN, CONTAS, GRUPOOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PCCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: AMARRACAO, CMATS, NOPS, CPROS, QTEQUALPS, CESTOS, CTRLLOTES, LCMASK, NENVS, FATORS, SERVAUTO, CHKQTDPS, TRFPESA, DOPPS, CGRUS, VALUE, ICLIS, EMPS, MERCS, SEMIACABS, GRUPOS, CODACBS, CODS, RATEIO, CHKPESOS, PO, CUNIPS, XDIFP, XDIFP2, MENFALHAS, DIFPESAGS, BPESOS, LNSINAL, CUNIS, NDOPES, EMPDOPNUMS, CORES, TAMS, _CMATS, _NOPS, CRETRABS, CONTADS, CONTAOS, GRODNS, TPOPS, EMPDNPS, SEPPEDRAS, _DISPMFAS, _DISPENVE, TOTA, OS, QTDS, PESOS, CHKSUBN, CONTAS, GRUPOOS

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
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  DeleteMark = .F.
  ControlSource = "xNensi.cMats"
  ControlSource = "xNensi.cdescs"
  ControlSource = "xNensi.fators"
  ControlSource = "xNensi.moedas"
  ControlSource = "xNensi.qtds"
  ControlSource = "xNensi.Coefs"
  ControlSource = "tmpnens.numps"
  ControlSource = "tmpnens.emps"
  ControlSource = "tmpnens.dopps"
  ControlSource = "xnensi.cdescs"
  ControlSource = "xnensi.obss"
  ControlSource = ""
  ControlSource = "xNensi.CodCors"
  ControlSource = "xNensi.CodTams"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
Select xNensi
	Delete All For FlagIncs And Amarracao = lnAmarraAnt And Cmats <> lcMat
Select xMFas
lcQuery = [Select a.Mats, a.DCompos, a.Qtds, a.UniCompos, a.Pesos, a.CuniPs, b.Cgrus, b.Varias, c.TpMovs, a.Pesos as Peso2s From SigPrCpo a ] +;
			[Inner Join SigCdPro b On a.Mats = b.Cpros ] +;
			[Inner Join SigCdGrp c On a.Cgrus = c.Cgrus ] +;
If ThisForm.poDataMgr.SqlExecute(lcQuery,[crTmpPrCpo]) < 1
Select crTmpPrCpo
Select crTmpPrCpo
		Insert Into xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, Qtds, Pesos, ;
		Insert Into xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, Qtds, Pesos, ;
	Select xNensi
	Delete All For FlagIncs And Amarracao = _xAmarra
Select xNensi
Insert Into xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, Qtds, Pesos, ;
Insert Into xNensi From Memvar
Select xNensi
Select xNensi
		Select xNensi
		If Not Seek(Str(_Nops, 10) + _cMats)
			Insert Into xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, Qtds, Pesos, TpOps) ;
		Select xNensi
	Select xNensi
			Select xNensi
=Seek(pForm._Dopp, 'crSigCdOpd', 'Dopps')
lcSql = [Select Count(1) as Qt From SigCdUni WherE cEstos = '3' ]
If (ThisForm.poDataMgr.SqlExecute(lcSql, 'CstmpUni') < 1)
lcQuery = [Select Dopes, nDopes From SigCdOpe Where Ctrllotes = 1 ]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CsTmpOpe') < 1)
Select CsTmpOpe
Select xNensi
	.Column1.ControlSource   = 'xnensi.nops'  				&& Ordem de Produção
	.Column2.ControlSource   = 'xnensi.cmats'  				&& Componente
	.Column4.ControlSource   = 'xnensi.cunis'				&& Unidade
	.Column5.ControlSource   = 'xnensi.tpops'				&& Tipo de Material
	.Column6.ControlSource   = 'xnensi.qtds'				&& Peso na Fase Anterior
	.Column7.ControlSource   = 'xnensi.pesos'				&& Peso Atual (Balança)
	.Column8.ControlSource   = 'xnensi.cats'				&& Categoria
	.Column9.ControlSource   = 'xnensi.Peso2s'				&& Peso da Unidade
	.Column10.ControlSource  = 'xnensi.cUniPs'				&& Unidade do Peso
	.Column3.ControlSource   = 'xnensi.Nenvs' 				&& Envelope
	.Column11.ControlSource  = 'xnensi.nlotes'				&& Numero do Lote (amagold)
	.Column12.ControlSource  = 'xNensi.CodCors'				&& Codigo da Cor
	.Column13.ControlSource  = 'xNensi.CodTams'				&& Codigo do Tamanho
Select Nenvs,Nops From xMfas where Nenvs > 0 Into Cursor Envelope ReadWrite
Select Envelope
	Select xNensi
	=Seek(TmpNens.GrupoOs,'TmpGccr','BalCodigo')
=Seek(TmpNens.GrupoOs,'TmpGccr','BalCodigo')
Select Max(Amarracao) as Amarracao From xNensi Into Cursor TmpAmarra
	lcQuery = [Select Distinct Cgrus From SigCdRpo Where Dopps = ']+CrSigCdOpd.Dopps+[' And not Cgrus = ' ' Order By Cgrus]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalRopt') < 1)
	Select LocalRopt
		Select crSigCdSvc
			Case Seek(lcCat + TmpNens.Grupoos + TmpNens.Contaos )
			Case Seek(lcCat + TmpNens.Grupoos + Space(10))
			Case Seek(lcCat + Space(20))
		lcQuery = [Select a.comis from SigCdCrg a inner join SigCdCli b on a.CCargs = b.CCargs where Iclis = '] + _Conta + [']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalCar') < 1)
		Select LocalCar
		Select xNensi
	Select xNensi
		lcQuery = [Select cIdChaves ] + ;
				    [From SigCdMsg ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMens') < 1)
		Select LocalMens
	If not Seek(This.Value,'Envelope',Iif(CrSigCdOpd.SepPedras=3,'Nops','Nenvs'))
If Not Empty(This.Value) And CrSigCdOpd.ChkQtdPs = 4 And Not Seek(Str(This.Value,10) + xNensi.Cmats,'xNensiP','Nenvs')
				Select xNensi
			Select xNensi
	Select xNensi
		Select xMfas
		lcsql = [Select CodAcbs From SigCdPro Where Cpros = ']+_Cpro+[']
		=ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpPro')
	lcQuery = [Select Distinct TpOps From SigCdRpo Where Dopps = ']+CrSigCdOpd.Dopps+[' ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmprOpt') < 1)
		lcQuery = [Select Distinct TpOps From SigCdRpo Where Dopps = ']+CrSigCdOpd.Dopps+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmprOpt') < 1)
	lcQuery = [Select Cods, Descs, pFalhas, Grupos ] + ;
			  [From SigOpOpt ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpOpt') < 1)
		lcQuery = [Select Cods, Descs, pFalhas, Grupos ] + ;
					[From SigOpOpt ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpOpt') < 1)
	Select TmpRopt
		Select a.* from TmpOpt a, TmpRopt b Where a.Cods = b.TpOps Into Cursor csSelecao ReadWrite
		Select * From TmpOpt Into Cursor CsSelecao ReadWrite
	Select CsSelecao
	If Not Seek(This.Value) Or (TmpNens.Grupoos <> CsSelecao.Grupos And Not Empty(CsSelecao.Grupos))
	Select xnensi
Select xNensi
			Select xNensi
			Select Sum(Qtds) as Qtds, Sum(Peso2s) as Peso2s, Sum(Pesos) as Pesos from xNensi where Amarracao = lcAmarra And Rateio = 3 And !Servicos ;
			Select xNensi
		lcSql = [Select Premios From SigCdGrp Where cGrus = ']+xNensi.cGrus+[']
		ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpGrp')
			Select CMats, Sum(Qtds) as Qtds, Sum(Pesos) as Pesos from xNensiP where NEnvs = _nOperacao And cMats = lcMat ;
			Select Cmats, Cunis, Cunips, Sum(Qtds) as Qtds, Sum(Peso2s) as Pesos from xNensi where Nops = _nOperacao And cMats = lcMat And Rateio = 2 And !Servicos ;
			Select a.cMats, a.Qtds as QtdCompo, a.Pesos as PesoCompo, Nvl(b.Qtds,0) as QtdAgre, Nvl(b.Pesos,0) as PesoAgre, Nvl(b.Cunis,'') as Cunis, Nvl(b.Cunips,'') as Cunips ;
				from TmpTotComp a Inner Join TmpTotAgre b on a.cMats = b.cMats Into Cursor TmpDifAgre
			Select TmpDifAgre
			Select TmpDifAgre
			Select TmpTotAgre
			Select xNensi
		Select xNensi
			Select xNensi
				Select xNensi
		Select xNensi
		Select Sum(Qtds) as Qtds, Sum(Peso2s) as Peso2s, Sum(Pesos) as Pesos from xNensi where Amarracao = lcAmarra And Rateio = 3 And !Servicos ;
		Select xNensi
		Select xNensi
			Select xNensi
			Select xNensi
				Select xNensi
		lcSql = [Select Premios From SigCdGrp Where cGrus = ']+xNensi.cGrus+[']
		ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpGrp')
		Select CMats, Sum(Qtds) as Qtds, Sum(Pesos) as Pesos from xNensiP where NEnvs = _nOperacao And cMats = lcMat ;
		Select Cmats, Cunis, Cunips, Sum(Qtds) as Qtds, Sum(Peso2s) as Pesos from xNensi where Nops = _nOperacao And cMats = lcMat And Rateio = 2 And !Servicos ;
		Select a.cMats, a.Qtds as QtdCompo, a.Pesos as PesoCompo, Nvl(b.Qtds,0) as QtdAgre, Nvl(b.Pesos,0) as PesoAgre, Nvl(b.Cunis,'') as Cunis, Nvl(b.Cunips,'') as Cunips ;
			from TmpTotComp a Inner Join TmpTotAgre b on a.cMats = b.cMats Into Cursor TmpDifAgre
		Select TmpDifAgre
		Select TmpDifAgre
		Select TmpTotAgre
				Select xNensi
				Select xNensi
		Select xNensi
		If Not Seek(Str(_Nops, 10) + _cMats)
			Insert Into xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, Qtds, Pesos, TpOps) ;
		Select xNensi
	Select xNensi
			Select xNensi
	Select xNensi
	Select crSigCdSvc
		Case Seek(This.Value + TmpNens.Grupoos + TmpNens.Contaos )
		Case Seek(This.Value + TmpNens.Grupoos + Space(10))
		Case Seek(This.Value + Space(20))
		Select crSigCdSvc
			Case Seek(This.Value + TmpNens.Grupoos + TmpNens.Contaos)
			Case Seek(This.Value + TmpNens.Grupoos + Space(10))
			Case Seek(This.Value + Space(20))
		lcQuery = [Select a.comis from SigCdCrg a inner join SigCdCli b on a.CCargs = b.CCargs where Iclis = '] + _Conta + [']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalCar') < 1)
		Select LocalCar
		Select xNensi
			Select xNensi
Select xNensi
	lcSql = [Select cEstos From SigCdUni Where cunis = ']+xnensi.cunis+[']
	ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
		Select xNensi
		Select Sum(Qtds) as Qtds, Sum(Peso2s) as Peso2s, Sum(Pesos) as Pesos from xNensi where Amarracao = lcAmarra And Rateio = 3 And !Servicos ;
		Select xNensi
		lcSql = [Select Premios From SigCdGrp Where cGrus = ']+xNensi.cGrus+[']
		ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpGrp')
			Select CMats, Sum(Qtds) as Qtds, Sum(Pesos) as Pesos from xNensiP where NEnvs = _nOperacao And cMats = lcMat ;
			Select Cmats, Cunis, Cunips, Sum(Qtds) as Qtds, Sum(Peso2s) as Pesos from xNensi where Nops = _nOperacao And cMats = lcMat And Rateio = 2 And !Servicos ;
			Select a.cMats, a.Qtds as QtdCompo, a.Pesos as PesoCompo, Nvl(b.Qtds,0) as QtdAgre, Nvl(b.Pesos,0) as PesoAgre, Nvl(b.Cunis,'') as Cunis, Nvl(b.Cunips,'') as Cunips ;
				from TmpTotComp a Inner Join TmpTotAgre b on a.cMats = b.cMats Into Cursor TmpDifAgre
			Select TmpDifAgre
			Select TmpDifAgre
			Select TmpTotAgre
			Select xNensi
	lcQuery = [Select dopes From SigCdOpe Where Ndopes = ]+Str(lnDope)
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpnDop') < 1)
	lcQuery = [Select EmpDopNums From SigMvCab Where EmpdopNums = ']+lcDopNum+[']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpLote') < 1 ) Or Reccount('TmpLote') = 0
Select xNensi
If Not Seek(Str(0, 10) + Space(13))
	Insert Into xNensi (Emps, Dopps, Numps, Visivel, Rateio, FlagIncs, TpOps, NChkSep) ;
		Insert Into xNensi (Emps, Dopps, Numps, Visivel, Rateio, FlagIncs, TpOps, NChkSep) ;
Select xNensi
Select xNensi
	Delete All For _Cmats = xNensi.CMats and !servicos
			Delete All For FlagIncs And _Cmats = xNensi.CMats And xNensi.Amarracao = _xAmr &&and !servicos
			Delete All For FlagIncs And _Cmats = xNensi.CMats And (_Nenvs = xNensi.Nenvs And _NOps = xNensi.Nops ) &&and !servicos
			Delete All For FlagIncs And Iif(!Empty(_xAmr),xNensi.Amarracao = _xAmr,_Cmats = xNensi.CMats) &&and !servicos
		lcSql = [Select * From SigPrCrt Where Emps = ']+_Empr+[' Or Emps = ' ']
		If Thisform.Podatamgr.Sqlexecute(lcSql,'LocalCrt') < 1
		Select LocalCrt
		Select xMfas
				lcSql = [Select a.cRetrabs, b.Seqs From SigPdMvf a, SigPrCrt b Where a.Nops = ]+Str(xmfas.Nops)+[ ]+;
				ThisForm.Podatamgr.SqlExecute(lcSql,'LocalCrt1')
				Select LocalCrt1
				If Seek(lnSeq+1,'LocalCrt')
Select xMfas
	Select xNensi
		lcSql = [Select DupTpOps From SigOpOpt Where cods = ']+xNensi.TpOps+[']
		ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalOpt')
			lcSql = [Select a.Nenvs, a.TpOps From SigCdNei a, SigCdNec b Where a.Nenvs = ]+Str(xNensI.Nenvs)+[ ]+;
			ThisForm.Podatamgr.Sqlexecute(lcSql,'DupNensI')
		lcSql = [Select b.Cores,b.Tams From SigCdPro a, SigCdGrp b ]+;
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrTmpGru')
	Select xMfas
		Select xNensi
							Select Nenvs, Sum(Qtds) as Qtds From xNensi Where Nenvs > 0 And Visivel ;
										Select xNensiNC
										Select Totais
											Select xNensiNC
										Select xNensiNC
										Select xNensi
												Select xNensiNC
Select xNensi
Select xNensiR
Select xMfas
Select xNensi
Select xNensi
	Select LocalPro
	Select xTmpx
	If Not Seek(xNensi.CMats)
		Insert Into xTmpx (CMats) Values (xNensi.CMats)
=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
Select xTmpx
	Insert Into xNensi (Emps, Dopps, Numps, CMats, CDescs, CUnis, ;
Select xNensi 
lcQuery = [Select nLotes From SigPdNlt ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNlt') < 1)
Select LocalNlt
	Select TmpResumo
		Insert into TmpLote from Memvar
		Select TmpLote 
Select TmpLote
	thisform.container2.grdLotes.column1.ControlSource = [TmpLote.nLotes]
	thisform.container2.grdLotes.column2.ControlSource = [TmpLote.cMats]
	thisform.container2.grdLotes.column3.ControlSource = [TmpLote.SaldoF]

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigpdmp2.prg) - TRECHOS RELEVANTES PARA PASS SQL (2993 linhas total):

*-- Linhas 11 a 64:
11: 
12: *==============================================================================
13: * DataMgrProxy - Proxy de compatibilidade com sub-forms legados
14: * Sub-forms do legado chamam ThisForm.poDataMgr.SqlExecute() e CursorQuery().
15: * Este proxy encapsula gnConnHandle para manter essa interface sem quebrar
16: * chamadas herdadas espalhadas pelos eventos do form.
17: *==============================================================================
18: DEFINE CLASS DataMgrProxy AS Custom
19: 
20:     pnIdConn = 0
21: 
22:     PROCEDURE Init(par_nConn)
23:         THIS.pnIdConn = par_nConn
24:     ENDPROC
25: 
26:     PROCEDURE SqlExecute(par_cSQL, par_cAlias)
27:         LOCAL loc_nRet, loc_oErro
28:         loc_nRet = -1
29:         TRY
30:             loc_nRet = SQLEXEC(THIS.pnIdConn, par_cSQL, par_cAlias)
31:         CATCH TO loc_oErro
32:             MsgErro(loc_oErro.Message, "Erro SqlExecute")
33:         ENDTRY
34:         RETURN loc_nRet
35:     ENDPROC
36: 
37:     PROCEDURE CursorQuery(par_cTabela, par_cAlias, par_cCampoChave, par_xValor, par_cCampos)
38:         LOCAL loc_cSQL, loc_cCampos, loc_cWhere, loc_nRet, loc_oErro
39:         loc_nRet    = -1
40:         loc_cCampos = IIF(EMPTY(par_cCampos), "*", par_cCampos)
41:         IF VARTYPE(par_xValor) = "N"
42:             loc_cWhere = par_cCampoChave + " = " + TRANSFORM(par_xValor)
43:         ELSE
44:             loc_cWhere = par_cCampoChave + " = '" + ALLTRIM(TRANSFORM(par_xValor)) + "'"
45:         ENDIF
46:         loc_cSQL = "SELECT " + loc_cCampos + " FROM " + par_cTabela + ;
47:                    " WHERE " + loc_cWhere
48:         TRY
49:             loc_nRet = SQLEXEC(THIS.pnIdConn, loc_cSQL, par_cAlias)
50:             IF loc_nRet >= 1 AND USED(par_cAlias) AND RECCOUNT(par_cAlias) > 0
51:                 GO TOP IN (par_cAlias)
52:             ENDIF
53:         CATCH TO loc_oErro
54:             MsgErro(loc_oErro.Message, "Erro CursorQuery")
55:         ENDTRY
56:         RETURN loc_nRet
57:     ENDPROC
58: 
59: ENDDEFINE
60: 
61: *==============================================================================
62: * Formsigpdmp2 - Form operacional de componentes de producao
63: *==============================================================================
64: DEFINE CLASS Formsigpdmp2 AS FormBase

*-- Linhas 409 a 578:
409:                 .RecordSource     = "xNensi"
410:                 .RecordSourceType = 1
411:                 .ColumnCount      = 13
412:                 .DeleteMark       = .F.
413:                 .ReadOnly         = .F.
414:                 .FontName         = "Tahoma"
415:                 .FontSize         = 8
416:                 .GridLines        = 1
417:                 .ScrollBars       = 3
418:                 .Visible          = .T.
419:             ENDWITH
420:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
421: 
422:             *-- Coluna 1: Seq (somente leitura)
423:             loc_oCol = loc_oGrd.Columns(1)
424:             WITH loc_oCol
425:                 .Width           = 35
426:                 .ReadOnly        = .T.
427:                 .Header1.Caption = "OF / Envelope"
428:             ENDWITH
429:             loc_oCol.Controls(1).ControlSource = "xNensi.Seq"
430: 
431:             *-- Coluna 2: SigCdPro - produto (lookup)
432:             loc_oCol = loc_oGrd.Columns(2)
433:             WITH loc_oCol
434:                 .Width           = 70
435:                 .ReadOnly        = .F.
436:                 .Header1.Caption = "Componente"
437:             ENDWITH
438:             loc_oCtrl = loc_oCol.Controls(1)
439:             loc_oCtrl.ControlSource = "xNensi.SigCdPro"
440:             BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col2GotFocus")
441:             BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col2ValidarComponente")
442:             BINDEVENT(loc_oCtrl, "KeyPress", THIS, "Col2KeyPress")
443: 
444:             *-- Coluna 3: Descr (somente leitura - derivada do produto)
445:             loc_oCol = loc_oGrd.Columns(3)
446:             WITH loc_oCol
447:                 .Width           = 200
448:                 .ReadOnly        = .T.
449:                 .Header1.Caption = "Envelope"
450:             ENDWITH
451:             loc_oCol.Controls(1).ControlSource = "xNensi.Descr"
452: 
453:             *-- Coluna 4: CUnida - unidade principal (somente leitura)
454:             loc_oCol = loc_oGrd.Columns(4)
455:             WITH loc_oCol
456:                 .Width           = 45
457:                 .ReadOnly        = .T.
458:                 .Header1.Caption = "Uni"
459:             ENDWITH
460:             loc_oCol.Controls(1).ControlSource = "xNensi.CUnida"
461: 
462:             *-- Coluna 5: SigCdRpo - roteiro/processo (lookup com logica CodAcb/Peso)
463:             loc_oCol = loc_oGrd.Columns(5)
464:             WITH loc_oCol
465:                 .Width           = 60
466:                 .ReadOnly        = .F.
467:                 .Header1.Caption = "Peso Fabr."
468:             ENDWITH
469:             loc_oCtrl = loc_oCol.Controls(1)
470:             loc_oCtrl.ControlSource = "xNensi.SigCdRpo"
471:             BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col5GotFocus")
472:             BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col5ValidarRoteiro")
473: 
474:             *-- Coluna 6: CUniPs - unidade de pecas (somente leitura)
475:             loc_oCol = loc_oGrd.Columns(6)
476:             WITH loc_oCol
477:                 .Width           = 45
478:                 .ReadOnly        = .T.
479:                 .Header1.Caption = "Lote"
480:             ENDWITH
481:             loc_oCol.Controls(1).ControlSource = "xNensi.CUniPs"
482: 
483:             *-- Coluna 7: Qtde - quantidade principal
484:             loc_oCol = loc_oGrd.Columns(7)
485:             WITH loc_oCol
486:                 .Width           = 65
487:                 .ReadOnly        = .F.
488:                 .Header1.Caption = "Quantidade"
489:             ENDWITH
490:             loc_oCtrl = loc_oCol.Controls(1)
491:             loc_oCtrl.ControlSource = "xNensi.Qtde"
492:             loc_oCtrl.Format = "9999.999"
493:             BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col7GotFocus")
494:             BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col7ValidarQuantidade")
495: 
496:             *-- Coluna 8: SigCdSvc - servico (lookup em crSigCdSvc do pai)
497:             loc_oCol = loc_oGrd.Columns(8)
498:             WITH loc_oCol
499:                 .Width           = 60
500:                 .ReadOnly        = .F.
501:                 .Header1.Caption = "Cat."
502:             ENDWITH
503:             loc_oCtrl = loc_oCol.Controls(1)
504:             loc_oCtrl.ControlSource = "xNensi.SigCdSvc"
505:             BINDEVENT(loc_oCtrl, "When",  THIS, "Col8WhenServico")
506:             BINDEVENT(loc_oCtrl, "Valid", THIS, "Col8ValidarServico")
507: 
508:             *-- Coluna 9: Qtps - quantidade em pecas
509:             loc_oCol = loc_oGrd.Columns(9)
510:             WITH loc_oCol
511:                 .Width           = 65
512:                 .ReadOnly        = .F.
513:                 .Header1.Caption = "Saldo"
514:             ENDWITH
515:             loc_oCtrl = loc_oCol.Controls(1)
516:             loc_oCtrl.ControlSource = "xNensi.Qtps"
517:             loc_oCtrl.Format = "9999.999"
518:             BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col9GotFocus")
519:             BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col9ValidarQtps")
520: 
521:             *-- Coluna 10: SigCdTma - tipo de material (lookup)
522:             loc_oCol = loc_oGrd.Columns(10)
523:             WITH loc_oCol
524:                 .Width           = 60
525:                 .ReadOnly        = .F.
526:                 .Header1.Caption = "Tipo de Material"
527:             ENDWITH
528:             loc_oCtrl = loc_oCol.Controls(1)
529:             loc_oCtrl.ControlSource = "xNensi.SigCdTma"
530:             BINDEVENT(loc_oCtrl, "GotFocus", THIS, "Col10GotFocus")
531:             BINDEVENT(loc_oCtrl, "Valid",    THIS, "Col10ValidarTipoMaterial")
532: 
533:             *-- Coluna 11: RepRetrab - sempre oculta (gerenciada via BO legado)
534:             loc_oCol = loc_oGrd.Columns(11)
535:             WITH loc_oCol
536:                 .Width           = 1
537:                 .ReadOnly        = .T.
538:                 .Visible         = .F.
539:                 .Header1.Caption = ""
540:             ENDWITH
541:             loc_oCol.Controls(1).ControlSource = "xNensi.RepRetrab"
542: 
543:             *-- Coluna 12: Cors - cor (dinamica: Width=1 ate grupo ter Cores=.T.)
544:             loc_oCol = loc_oGrd.Columns(12)
545:             WITH loc_oCol
546:                 .Width           = 1
547:                 .ReadOnly        = .F.
548:                 .Header1.Caption = "Cor"
549:             ENDWITH
550:             loc_oCtrl = loc_oCol.Controls(1)
551:             loc_oCtrl.ControlSource = "xNensi.Cors"
552:             BINDEVENT(loc_oCtrl, "When",  THIS, "Col12WhenCor")
553:             BINDEVENT(loc_oCtrl, "Valid", THIS, "Col12ValidarCor")
554: 
555:             *-- Coluna 13: Tams - tamanho (dinamica: Width=1 ate grupo ter Tams=.T.)
556:             loc_oCol = loc_oGrd.Columns(13)
557:             WITH loc_oCol
558:                 .Width           = 1
559:                 .ReadOnly        = .F.
560:                 .Header1.Caption = "Tam"
561:             ENDWITH
562:             loc_oCtrl = loc_oCol.Controls(1)
563:             loc_oCtrl.ControlSource = "xNensi.Tams"
564:             BINDEVENT(loc_oCtrl, "When",  THIS, "Col13WhenTamanho")
565:             BINDEVENT(loc_oCtrl, "Valid", THIS, "Col13ValidarTamanho")
566: 
567:         CATCH TO loc_oErro
568:             MsgErro(loc_oErro.Message, "Erro ao configurar grade principal")
569:         ENDTRY
570:     ENDPROC
571: 
572:     *==========================================================================
573:     * GrdDadosAfterRowColChange - Atualiza Get_Descr/Get_Obs e Cnt_Servico
574:     * BINDEVENT: AfterRowColChange do grd_4c_Dados
575:     * Replica: Grade.Procedure do SIGPDMP2 - mostra/oculta Cnt_Servico,
576:     * recalcula total (Fators*Qtds) e determina AlteraServico.
577:     *==========================================================================
578:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)

*-- Linhas 851 a 869:
851:                 loc_cCod = ALLTRIM(NVL(xNensi.SigCdSvc, ""))
852:                 IF !EMPTY(loc_cCod)
853:                     IF USED("crSigCdSvc")
854:                         SELECT crSigCdSvc
855:                         LOCATE FOR ALLTRIM(crSigCdSvc.SigCdSvc) = loc_cCod
856:                         IF !FOUND("crSigCdSvc")
857:                             REPLACE xNensi.SigCdSvc WITH ""
858:                             MsgAviso("Servi" + CHR(231) + "o n" + CHR(227) + "o encontrado.", ;
859:                                 "Aten" + CHR(231) + CHR(227) + "o")
860:                             loc_lRet = .F.
861:                         ENDIF
862:                     ENDIF
863:                 ENDIF
864:             ENDIF
865:         CATCH TO loc_oErro
866:             MsgErro(loc_oErro.Message, "Erro ValidarServico")
867:             loc_lRet = .T.
868:         ENDTRY
869: 

*-- Linhas 1212 a 1232:
1212: 
1213:                             *-- Verifica flag DupTpOps no cadastro de opcoes
1214:                             IF !EMPTY(loc_cTpOps)
1215:                                 IF THIS.poDataMgr.SqlExecute( ;
1216:                                         "SELECT DupTpOps FROM SigOpOpt WHERE Cods = " + ;
1217:                                         EscaparSQL(loc_cTpOps), "cursor_4c_DupOpt") >= 1 ;
1218:                                         AND USED("cursor_4c_DupOpt") ;
1219:                                         AND RECCOUNT("cursor_4c_DupOpt") > 0
1220:                                     loc_nDupOpt = NVL(cursor_4c_DupOpt.DupTpOps, 0)
1221:                                     USE IN cursor_4c_DupOpt
1222:                                     IF loc_nDupOpt = 1
1223:                                         loc_lDupTpO = .T.
1224:                                     ENDIF
1225:                                 ELSE
1226:                                     IF USED("cursor_4c_DupOpt")
1227:                                         USE IN cursor_4c_DupOpt
1228:                                     ENDIF
1229:                                 ENDIF
1230:                             ENDIF
1231:                         ENDIF
1232: 

*-- Linhas 1290 a 1308:
1290: 
1291:     *==========================================================================
1292:     * BtnInserirClick - Insere nova linha em xNensi com valores iniciais de TmpNens
1293:     * Replica: Inserir.Click do SIGPDMP2 (INSERT INTO com campos de TmpNens/crSigCdOpd)
1294:     * Nao insere se ja existe linha vazia (Nops=0 + Cmats em branco), exceto
1295:     * quando CompAgru=1 e PsFaseAnt <> 0 (agregacao de componentes permitida).
1296:     *==========================================================================
1297:     PROCEDURE BtnInserirClick()
1298:         LOCAL loc_lPode, loc_cEmps, loc_cDopps, loc_nNumps, loc_cTpPadrao, loc_oErro
1299: 
1300:         loc_lPode = .T.
1301:         IF !THIS.LibInserir
1302:             MsgAviso("Inser" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida.", ;
1303:                 "Aten" + CHR(231) + CHR(227) + "o")
1304:             loc_lPode = .F.
1305:         ENDIF
1306: 
1307:         IF loc_lPode AND !INLIST(THIS.pcEscolha, "INSERIR", "ALTERAR")
1308:             loc_lPode = .F.

*-- Linhas 1328 a 1355:
1328:                     ENDIF
1329: 
1330:                     *-- Verifica se ja existe linha vazia (Nops=0 + Cmats em branco)
1331:                     SELECT xNensi
1332:                     SET ORDER TO NopMatCat
1333:                     IF !SEEK(STR(0, 10) + SPACE(13))
1334:                         *-- Sem linha vazia: inserir nova com valores iniciais
1335:                         INSERT INTO xNensi (Emps, Dopps, Numps, Visivel, Rateio, FlagIncs, TpOps, NChkSep) ;
1336:                             VALUES (loc_cEmps, loc_cDopps, loc_nNumps, .T., 5, .T., loc_cTpPadrao, .T.)
1337:                     ELSE
1338:                         *-- Linha vazia existe: inserir somente se CompAgru=1 e PsFaseAnt<>0
1339:                         IF THIS.CompAgru = 1 AND NVL(xNensi.PsFaseAnt, 0) <> 0
1340:                             INSERT INTO xNensi (Emps, Dopps, Numps, Visivel, Rateio, FlagIncs, TpOps, NChkSep) ;
1341:                                 VALUES (loc_cEmps, loc_cDopps, loc_nNumps, .T., 5, .T., loc_cTpPadrao, .T.)
1342:                         ENDIF
1343:                     ENDIF
1344:                     SET ORDER TO
1345:                     GO BOTTOM IN xNensi
1346:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1347:                         THIS.grd_4c_Dados.Refresh()
1348:                     ENDIF
1349:                 ELSE
1350:                     MsgErro("Cursor xNensi n" + CHR(227) + "o dispon" + ;
1351:                         CHR(237) + "vel.", "Erro Inserir")
1352:                 ENDIF
1353:             CATCH TO loc_oErro
1354:                 MsgErro(loc_oErro.Message, "Erro ao inserir componente")
1355:             ENDTRY

*-- Linhas 1421 a 1488:
1421:                         loc_nChkQtdPs  = NVL(crSigCdOpd.ChkQtdPs, 0)
1422:                     ENDIF
1423: 
1424:                     SELECT xNensi
1425:                     SET ORDER TO
1426: 
1427:                     IF loc_nSepPedras = 4
1428:                         *-- SepPedras=4: remove todos com mesmo material (exceto servicos)
1429:                         DELETE ALL FOR ;
1430:                             !EMPTY(Cmats) AND ;
1431:                             ALLTRIM(Cmats) = loc_cMats AND ;
1432:                             !(VARTYPE(Servicos) = "L" AND Servicos)
1433:                     ELSE
1434:                         IF loc_nChkQtdPs = 4
1435:                         *-- ChkQtdPs=4: remove agrupados por FlagIncs + Cmats + Amarracao
1436:                         IF loc_lFlagIncs
1437:                             DELETE ALL FOR ;
1438:                                 VARTYPE(FlagIncs) = "L" AND FlagIncs AND ;
1439:                                 ALLTRIM(Cmats) = loc_cMats AND ;
1440:                                 NVL(Amarracao, 0) = loc_nAmr
1441:                         ENDIF
1442:                     ELSE
1443:                         *-- Padrao: agrupado por FlagIncs + Cmats + (Nenvs/Nops ou Amarracao)
1444:                         IF loc_nAmr = 0
1445:                             DELETE ALL FOR ;
1446:                                 VARTYPE(FlagIncs) = "L" AND FlagIncs AND ;
1447:                                 ALLTRIM(Cmats) = loc_cMats AND ;
1448:                                 NVL(Nenvs, 0) = loc_nNenvs AND ;
1449:                                 NVL(Nops, 0) = loc_nNops
1450:                         ELSE
1451:                             DELETE ALL FOR ;
1452:                                 VARTYPE(FlagIncs) = "L" AND FlagIncs AND ;
1453:                                 ALLTRIM(Cmats) = loc_cMats AND ;
1454:                                 NVL(Amarracao, 0) = loc_nAmr
1455:                         ENDIF
1456:                         ENDIF
1457:                     ENDIF
1458: 
1459:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1460:                         THIS.grd_4c_Dados.Refresh()
1461:                     ENDIF
1462:                 ENDIF
1463:             ENDIF
1464:         CATCH TO loc_oErro
1465:             MsgErro(loc_oErro.Message, "Erro ao excluir componente")
1466:         ENDTRY
1467:     ENDPROC
1468: 
1469:     *==========================================================================
1470:     * BtnIncluirClick - Alias canonico do novo sistema para BtnInserirClick
1471:     * O SCX legado nomeia o botao "Inserir"; a nova arquitetura padroniza
1472:     * "Incluir" para operacao equivalente. Delega para BtnInserirClick que
1473:     * mantem a logica original (INSERT INTO xNensi + verificacao de linha
1474:     * vazia + suporte a CompAgru/PsFaseAnt).
1475:     *==========================================================================
1476:     PROCEDURE BtnIncluirClick()
1477:         THIS.BtnInserirClick()
1478:     ENDPROC
1479: 
1480:     *==========================================================================
1481:     * BtnVisualizarClick - Alterna o form para modo somente-leitura
1482:     * SIGPDMP2 nao tem botao Visualizar no legado; quando pcEscolha !=
1483:     * INSERIR/ALTERAR a interface ja se comporta como visualizacao (When
1484:     * dos botoes retorna .F.). Este metodo formaliza a entrada em modo
1485:     * VISUALIZAR: trava o grid e os campos de descricao/observacao,
1486:     * desabilita botoes de manipulacao e mantem dados visiveis. Replica
1487:     * a logica implicita do legado quando pcEscolha = 'VISUALIZAR'.
1488:     *==========================================================================

*-- Linhas 1499 a 1517:
1499:             *-- Trava grid principal (impede edicao de qualquer coluna)
1500:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1501:                 THIS.grd_4c_Dados.ReadOnly = .T.
1502:                 THIS.grd_4c_Dados.DeleteMark = .F.
1503:             ENDIF
1504: 
1505:             *-- Trava campos de descricao e observacao
1506:             IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
1507:                 THIS.txt_4c_Descr.ReadOnly = .T.
1508:             ENDIF
1509:             IF PEMSTATUS(THIS, "txt_4c_Obs", 5)
1510:                 THIS.txt_4c_Obs.ReadOnly = .T.
1511:             ENDIF
1512:             IF PEMSTATUS(THIS, "txt_4c_Cor", 5)
1513:                 THIS.txt_4c_Cor.ReadOnly = .T.
1514:             ENDIF
1515:             IF PEMSTATUS(THIS, "txt_4c_Tam", 5)
1516:                 THIS.txt_4c_Tam.ReadOnly = .T.
1517:             ENDIF

*-- Linhas 1549 a 1567:
1549: 
1550:             *-- Reposiciona no topo da lista e refresca exibicao
1551:             IF USED("xNensi") AND RECCOUNT("xNensi") > 0
1552:                 SELECT xNensi
1553:                 GO TOP
1554:             ENDIF
1555:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1556:                 THIS.grd_4c_Dados.Refresh()
1557:             ENDIF
1558:             THIS.Refresh()
1559:         CATCH TO loc_oErro
1560:             MsgErro(loc_oErro.Message, "Erro ao alternar para modo visualizar")
1561:         ENDTRY
1562:     ENDPROC
1563: 
1564:     *==========================================================================
1565:     * ConfigurarCheckboxes - 8 checkboxes de controle (Top=81)
1566:     * Todos: Width=75, Height=75, Style=1(PictureButton), FontName="Comic Sans MS"
1567:     *   chk_4c_Retrabalho (Left=171): abre SigPdM12 (informar retrabalho)

*-- Linhas 1918 a 1959:
1918:                 .RecordSource     = "TmpNens"
1919:                 .RecordSourceType = 1
1920:                 .ColumnCount      = 3
1921:                 .DeleteMark       = .F.
1922:                 .ReadOnly         = .F.
1923:                 .FontName         = "Tahoma"
1924:                 .FontSize         = 8
1925:                 .Visible          = .T.
1926:             ENDWITH
1927: 
1928:             *-- Coluna 1: Lote
1929:             loc_oCol = loc_oGrd.Columns(1)
1930:             loc_oCol.Width           = 160
1931:             loc_oCol.Header1.Caption = "Lote"
1932:             loc_oCol.Controls(1).ControlSource = "TmpNens.Lote"
1933: 
1934:             *-- Coluna 2: Qtde do lote
1935:             loc_oCol = loc_oGrd.Columns(2)
1936:             loc_oCol.Width           = 120
1937:             loc_oCol.Header1.Caption = "Quantidade"
1938:             loc_oCol.Controls(1).ControlSource = "TmpNens.Qtde"
1939: 
1940:             *-- Coluna 3: Prazo/Vencimento
1941:             loc_oCol = loc_oGrd.Columns(3)
1942:             loc_oCol.Width           = 120
1943:             loc_oCol.Header1.Caption = "Saldo"
1944:             loc_oCol.Controls(1).ControlSource = "TmpNens.Prazo"
1945: 
1946:             *-- Botao OK: fecha o painel de lotes
1947:             loc_oCnt.AddObject("cmd_4c_OkLotes", "CommandButton")
1948:             loc_oBtn = loc_oCnt.cmd_4c_OkLotes
1949:             WITH loc_oBtn
1950:                 .Top      = 232
1951:                 .Left     = 170
1952:                 .Width    = 80
1953:                 .Height   = 24
1954:                 .Caption  = "OK"
1955:                 .FontName = "Tahoma"
1956:                 .FontSize = 8
1957:                 .Visible  = .T.
1958:             ENDWITH
1959:             BINDEVENT(loc_oCnt.cmd_4c_OkLotes, "Click", THIS, "BtnOkLotesClick")

*-- Linhas 2182 a 2215:
2182:                 .FontName      = "Tahoma"
2183:                 .FontSize      = 8
2184:                 .BorderStyle   = 1
2185:                 .ControlSource = "xNensi.Cors"
2186:                 .Value         = ""
2187:                 .Visible       = .T.
2188:             ENDWITH
2189: 
2190:             THIS.AddObject("txt_4c_GetTam", "TextBox")
2191:             WITH THIS.txt_4c_GetTam
2192:                 .Top           = 506
2193:                 .Left          = 143
2194:                 .Width         = 32
2195:                 .Height        = 23
2196:                 .ReadOnly      = .T.
2197:                 .FontName      = "Tahoma"
2198:                 .FontSize      = 8
2199:                 .BorderStyle   = 1
2200:                 .ControlSource = "xNensi.Tams"
2201:                 .Value         = ""
2202:                 .Visible       = .T.
2203:             ENDWITH
2204: 
2205:             *------------------------------------------------------------------
2206:             * Area de Descricao - Get_descr/Say2 com posicoes corretas do original
2207:             * Say2 (label): Top=533, Left=51, Caption="Descri??o :"
2208:             * lbl_4c_GetDescr: Top=529, Left=108, Width=490 (exibe xNensi.Descr)
2209:             * Nota: movido de ConfigurarGradePrincipal onde estava em Top=128 (errado)
2210:             *------------------------------------------------------------------
2211:             THIS.AddObject("lbl_4c_Say2", "Label")
2212:             WITH THIS.lbl_4c_Say2
2213:                 .Top       = 533
2214:                 .Left      = 51
2215:                 .Width     = 55

*-- Linhas 2365 a 2400:
2365:                 .Left          = 77
2366:                 .Width         = 113
2367:                 .Height        = 23
2368:                 .ControlSource = "xNensi.cMats"
2369:                 .ReadOnly      = .T.
2370:                 .MaxLength     = 14
2371:                 .FontName      = "Tahoma"
2372:                 .FontSize      = 8
2373:                 .BorderStyle   = 1
2374:                 .BorderColor   = RGB(100, 100, 100)
2375:                 .Visible       = .T.
2376:             ENDWITH
2377: 
2378:             *-- txt_4c_GetDpro: descricao do servico (ReadOnly)
2379:             loc_oCnt.AddObject("txt_4c_GetDpro", "TextBox")
2380:             WITH loc_oCnt.txt_4c_GetDpro
2381:                 .Top           = 25
2382:                 .Left          = 77
2383:                 .Width         = 290
2384:                 .Height        = 23
2385:                 .ControlSource = "xNensi.cdescs"
2386:                 .ReadOnly      = .T.
2387:                 .SpecialEffect = 1
2388:                 .FontName      = "Tahoma"
2389:                 .FontSize      = 8
2390:                 .BorderColor   = RGB(100, 100, 100)
2391:                 .Visible       = .T.
2392:             ENDWITH
2393: 
2394:             *-- Label4: "Valor :" - rotulo de txt_4c_GetValor
2395:             loc_oCnt.AddObject("lbl_4c_Label4", "Label")
2396:             WITH loc_oCnt.lbl_4c_Label4
2397:                 .Top       = 52
2398:                 .Left      = 42
2399:                 .Width     = 33
2400:                 .Height    = 15

*-- Linhas 2414 a 2449:
2414:                 .Left          = 77
2415:                 .Width         = 80
2416:                 .Height        = 23
2417:                 .ControlSource = "xNensi.fators"
2418:                 .InputMask     = "999,999.99"
2419:                 .MaxLength     = 12
2420:                 .SpecialEffect = 1
2421:                 .FontName      = "Tahoma"
2422:                 .FontSize      = 8
2423:                 .BorderColor   = RGB(100, 100, 100)
2424:                 .Visible       = .T.
2425:             ENDWITH
2426: 
2427:             *-- txt_4c_GetMoeda: codigo da moeda (editavel se AlteraServico, lookup SigCdMoe)
2428:             loc_oCnt.AddObject("txt_4c_GetMoeda", "TextBox")
2429:             WITH loc_oCnt.txt_4c_GetMoeda
2430:                 .Top           = 48
2431:                 .Left          = 157
2432:                 .Width         = 31
2433:                 .Height        = 23
2434:                 .ControlSource = "xNensi.moedas"
2435:                 .MaxLength     = 3
2436:                 .SpecialEffect = 1
2437:                 .FontName      = "Tahoma"
2438:                 .FontSize      = 8
2439:                 .BorderColor   = RGB(100, 100, 100)
2440:                 .Visible       = .T.
2441:             ENDWITH
2442: 
2443:             *-- Label1: "Quantidade :" - rotulo de txt_4c_GetQtde
2444:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
2445:             WITH loc_oCnt.lbl_4c_Label1
2446:                 .Top       = 52
2447:                 .Left      = 220
2448:                 .Width     = 65
2449:                 .Height    = 15

*-- Linhas 2463 a 2481:
2463:                 .Left          = 287
2464:                 .Width         = 80
2465:                 .Height        = 23
2466:                 .ControlSource = "xNensi.qtds"
2467:                 .InputMask     = "999,999.999"
2468:                 .MaxLength     = 12
2469:                 .ReadOnly      = .T.
2470:                 .SpecialEffect = 1
2471:                 .FontName      = "Tahoma"
2472:                 .FontSize      = 8
2473:                 .BorderColor   = RGB(100, 100, 100)
2474:                 .Visible       = .T.
2475:             ENDWITH
2476: 
2477:             *-- Label5: "Total :" (negrito) - rotulo de txt_4c_GetTotal
2478:             loc_oCnt.AddObject("lbl_4c_Label5", "Label")
2479:             WITH loc_oCnt.lbl_4c_Label5
2480:                 .Top       = 75
2481:                 .Left      = 248

*-- Linhas 2531 a 2549:
2531:                 .Left          = 77
2532:                 .Width         = 80
2533:                 .Height        = 23
2534:                 .ControlSource = "xNensi.Coefs"
2535:                 .InputMask     = "999,999.99"
2536:                 .MaxLength     = 12
2537:                 .SpecialEffect = 1
2538:                 .FontName      = "Tahoma"
2539:                 .FontSize      = 8
2540:                 .BorderColor   = RGB(100, 100, 100)
2541:                 .Visible       = .T.
2542:             ENDWITH
2543: 
2544:             *-- BINDEVENTs: When - editabilidade controlada por AlteraServico
2545:             BINDEVENT(loc_oCnt.txt_4c_GetValor,  "When", THIS, "CntServicoEditavelWhen")
2546:             BINDEVENT(loc_oCnt.txt_4c_GetMoeda,  "When", THIS, "CntServicoEditavelWhen")
2547:             BINDEVENT(loc_oCnt.txt_4c_GetRetrab, "When", THIS, "CntServicoEditavelWhen")
2548: 
2549:             *-- BINDEVENTs: LostFocus - recalculo de get_total

*-- Linhas 2942 a 2960:
2942:     *==========================================================================
2943:     * BtnCancelarClick - Reverte alteracoes no cursor xNensi e fecha o form
2944:     * Cancela todas as edicoes em andamento: TABLEREVERT .T. desfaz todos os
2945:     * registros alterados/adicionados desde o ultimo TABLEUPDATE.
2946:     * O form pai (SigPdMfa) continua com xNensi no estado anterior a abertura.
2947:     *==========================================================================
2948:     PROCEDURE BtnCancelarClick()
2949:         LOCAL loc_oErro
2950: 
2951:         TRY
2952:             IF USED("xNensi")
2953:                 *-- Desfaz edicoes no buffer da tabela
2954:                 TABLEREVERT(.T., "xNensi")
2955:             ENDIF
2956:             THIS.Release()
2957:         CATCH TO loc_oErro
2958:             MsgErro(loc_oErro.Message, "Erro ao cancelar componentes")
2959:         ENDTRY
2960:     ENDPROC

*-- Linhas 2969 a 2987:
2969: 
2970:         TRY
2971:             IF USED("xNensi")
2972:                 SELECT xNensi
2973:                 SET ORDER TO
2974:                 GO TOP
2975:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2976:                     THIS.grd_4c_Dados.Refresh()
2977:                 ENDIF
2978:                 *-- Atualiza campos de exibicao da linha corrente
2979:                 IF !EOF("xNensi")
2980:                     IF PEMSTATUS(THIS, "lbl_4c_GetDescr", 5)
2981:                         THIS.lbl_4c_GetDescr.Caption = ALLTRIM(NVL(xNensi.Descr, ""))
2982:                     ENDIF
2983:                     IF PEMSTATUS(THIS, "txt_4c_GetObs", 5)
2984:                         THIS.txt_4c_GetObs.Value = ALLTRIM(NVL(xNensi.Obs, ""))
2985:                     ENDIF
2986:                 ENDIF
2987:             ENDIF

