# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-SQL] Campo 'nops' usado em ControlSource de cursor_4c_Operacoes mas NAO aparece no SELECT SQL
- [SQL-ASPAS] Linha 81: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: " WHERE a.empdnps BETWEEN '" + loc_cOpI + "' AND '" + loc_cOpF + "'"

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
  ControlSource = "tmpnens.datas"
  ControlSource = "tmpnens.numps"
  ControlSource = "tmpnens.grupoos"
  ControlSource = "tmpnens.contaos"
  ControlSource = "tmpnens.grupods"
  ControlSource = "tmpnens.contads"
  Column1.ControlSource = ""
  ControlSource = "tmpnens.grvends"
  ControlSource = "tmpnens.vends"
Select xNensi
Select TmpOperacao
	Select LocalMFas
			lcSql = [Select CidChaves From SigCdNec Where EmpDnPs = '] + TmpNens.Emps + _CheckBaixa + Str(_Nops, 10) + [']
			If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocalNens2') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Marca - Update - SigCdNec)')
			Select LocalNens2
				lcQuery = [Update SigCdNec Set ChkSubn = ?pTru Where CidChaves = '] +LocalNens2.CidChaves + [']
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
					=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Marca - Update - SigCdNec)')
		Select LocalCompo
			Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, CGrus,;
			If Not Seek(_Operacao + LocalCompo.Mats, 'xNensi', 'NEnvCMat')
				Insert Into xNensi (Nops, Nenvs, CMats, CDescs, CUnis, CGrus, Visivel, Rateio, FlagIncs, Cats) ;
Select * From CrSigCdNec Where 0=1 Into Cursor TmpNens ReadWrite
Select *, 000000.000 as PsFaseAnt, 0 as Rateio, .f. as Visivel, 000000.000 as QtFaseAnt ;
From CrSigCdNei Where 0=1 Into Cursor xNensi ReadWrite
Select * From CrSigPdMvf Where 0=1 Into Cursor xMFas ReadWrite
Select * From CrSigPdMvf Where 0=1 Into cursor xMFas2 ReadWrite
	.Column1.ControlSource  = 'TmpOperacao.Codigos'
Select LocalEest
		lcQuery = [Delete From SigMvCab ] + ;
		lcQuery = [Update SigMvCab ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Delete From SigMvItn ] + ;
		lcQuery = [Update SigMvItn ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	Select LocalHis
			lcQuery = [Delete From SigMvHst ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
Select LocalNens
	lcQuery = [Delete From SigCdNec ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Delete From SigCdNei ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Delete From SigOpPic ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	Select LocalHis
		lcQuery = [Delete From SigMvHst ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Delete From SigPdMvf ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
lcQuery = [Select * ] + ;
		    [From SigCdmp]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'SigCdmp') < 1)
Select SigCdmp
lcQryNens  = [Select * From SigCdNec  Where EmpDNps BetWeen ?pOpI And ?pOpF]
lcQryNensi = [Select * From SigCdNei Where cIdChaves = ?pIds]
lcQryMFas  = [Select * From SigPdMvf  Where cIdChaves = ?pIds]
lcQryHis   = [Select * From SigMvHst   Where cIdChaves = ?pIds]
lcQryEti   = [Select * From SigOpEtq   Where CBars = ?pBar]
		Select crSigCdGrp
		Select crSigCdUni
		Select TempGccr
	Select TmpOperacao
Select crSigCdNec
Select TmpNens
lcQuery = [Delete From SigCdNei ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
Select LocalHis
	lcQuery = [Delete From SigMvHst ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
Select LocalMccr
	lcQuery = [Delete From SigMvCcr ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
lcQuery = [Delete From SigOpEtq ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
Select LocalMFas
		lcQuery = [Update SigCdNec ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Excluir - Update SigCdNec)')
	Select LocalOpi
			lcQuery = [Update SigMvCab ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Excluir - Update - SigMvCab)')
	lcQuery = [Delete From SigPdMvf ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
lcQuery = [Delete From SigEtPos ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
Select LocalEest
	lcQuery = [Delete From SigMvItn ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Delete From SigMvIts ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcSql = [Select * From SigMvHst where OriDopNums = ']+LocalEest.EmpDopNums+[']
	If (ThisForm.poDataMgr.SqlExecute(lcSql,'LocalHis') < 1)
	Select LocalHis
	lcQuery = [Delete From SigMvHst Where OridopNums = '] + LocalEest.empDopNums + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
lcQuery = [Delete From SigMvCab ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
lcQuery = [Delete From SigCdNec ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
Select xNensi
Delete All For Empty(Nops) And Empty(CMats)
Select xMFas
Select xNensi
	Select TmpSoma
	If Not Seek(xNensi.CMats)
		Insert Into TmpSoma (CPros) Values (xNensi.CMats)
Select xNensi
	Insert Into crSigCdNei (Emps, Dopps, Numps, Nops, Nenvs, CMats, CDescs, CUnis, Tpops, Cats, Obss, AQtds, ;
	=Seek(LocalPro.CGrus, 'crSigCdGrp', 'CGrus')
	Select xMFas
	If Not Empty(xNensi.Nops) And Seek(xNensi.Nops) And (crSigCdGrp.CEstoqs = 1)
Select TmpSoma
	=Seek(LocalPro.CGrus, 'crSigCdGrp', 'CGrus')
		Insert Into crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, DtAudits, CPros, Empos, ;
		Insert Into crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, DtAudits, CPros, Empos, ;
Select xMFas
		lcQuery = [Select Grupos ] + ;
				    [From SigCdPrf ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPrf') < 1)
		Select crSigCdPrf
			lcQuery = [Select Ordems ] + ;
					    [From SigCdPrf ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPrf') < 1)
			Select crSigCdPrf
	Insert Into crSigPdMvf (Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, Grupoos, Contaos, Grupods, ;
		lcQuery = [Update SigCdNec ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdNec (2))')
Select xPesa
		Insert Into crSigOpEtq (Cbars, Cpros, Pesos, Qtds, Emps, Dopes, Numes, Datas, ;
			Insert Into crSigEtPos (Cbars, Cpros, Pesos, Qtds, Emps, Dopes, Numes, Datas, Empos, Grupos, Contas, ;
	Select LocalOpi
	Select xNensi 
		Insert Into crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, DtAudits, CPros, Empos, Qtds, ;
		Insert Into crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, DtAudits, CPros, Empos, Qtds, ;
	Select LocalEestI
			lcQuery = [Update SigMvItn ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Inserir - Update SigMvItn)')
	lcSql = [Select * From SigCdOpe Where dopes = ']+_Dope+[']
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigCdOpe')
	SELECT *, Space(10) as GrupoDs, Space(10) as ContaDs, Space(10) as GrupoOs, Space(10) as ContaOs ;
	From CrSigEtPos INTO CURSOR Localpeti order by CidChaves readwrite
	SELECT LocalpEti
		lcSql = [Select GrupoOs, ContaOs, GrupoDs, ContaDs From SigMvCab ]+;
		ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalEest')
	Select LocalpEti
			Insert Into crSigMvCab (Emps, Empds, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, Contaos, ;
		Insert Into crSigMvItn (CItens, Emps, Dopes, Numes, CPros, Qtds, Pesos, Cunis, DPros, ;
			Insert Into crSigMvIts ( CItens, CPros, Emps, Dopes, Numes, qtds, QtdEmbs, Pesos, CodCors, CodTams, CodEmbs, EmpDopNums, CidChaves, DtAlts ) ;
			insert into crSigMvHst (usuars, datars, emps, opers, Dopes, numes, datas, cpros, ;
			Insert Into crSigMvHst ( usuars, datars, opers, Dopes, numes, datas, cpros, qtds, ;
Select TmpNens
If Not ThisForm.poDataMgr.Update('crSigCdNei')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdNei)')
If Not ThisForm.poDataMgr.Update('crSigPdMvf')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPdMvf)')
If Not ThisForm.poDataMgr.Update('crSigMvHst')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvHst)')
If Not ThisForm.poDataMgr.Update('crSigOpEtq')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigOpEtq)')
If Not ThisForm.poDataMgr.Update('crSigEtPos')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigEtPos)')
If Not ThisForm.poDataMgr.Update('crSigMvCab')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvCab)')
If Not ThisForm.poDataMgr.Update('crSigMvItn')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvItn)')
		Select LocalNensi
			Select LocalMFas
		lcQuery = [Select CBars, Grupos, Contas ] + ;
				    [From SigOpEtq ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEti') < 1)
		Select LocalEti
		Select LocalMccr
Select crSigCdNec
		lcQuery = [Select Nops ] + ;
				    [From SigPdMvf ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMFas') < 1)
		Select LocalMFas
		Select TmpNens
		Insert Into TmpNens (Chksubn, Datars, Datas, Datatrans, Dopps, Emps, Numps, Usuars, TotPesos, Obss, Grupoos, ;
		Select LocalMFas
			Insert Into xMFas (Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, Grupoos, Contaos, Grupods, Contads, ;
			If Not Seek((_NumNivel * 10000000000) + xMFas.NEnvs, 'TmpOperacao', 'Codigos')
				Insert Into TmpOperacao (Codigos) Values ((_NumNivel * 10000000000) + xMFas.NEnvs)
			Select LocalOpi
				Insert Into xOpi (Nops, Oper, Qtds, CPros, Indiv, Amarra, Nenvs, Emps, Dopes, Numes) ;
		lcQuery = [Select * ] + ;
				    [From SigCdNei ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNensi') < 1)
		Select LocalNensi
					Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, QtFaseAnt, Qtds, PsFaseAnt, ;
					If Not Seek(Str(_Nenv, 10) + _BMat, 'xNensi', 'NEnvCMat')
						Insert Into xNensi (Nops, Nenvs, CMats, CDescs, CUnis, CGrus, Visivel, ;
					If Not Seek(LocalNensi.Cats, 'xNensi', 'Cats')
						Insert Into xNensi (Emps, Dopps, Numps, CMats, CDescs, CUnis, CGrus, Visivel, Rateio, ;
			Select LocalNensi
			Select LocalPEti
				Insert Into xPesa (Cbars, Cpros, Peso, Qtds, Emps, Dopes, Numes, Nops, Oper, Conta, Obs, Cors, Tams, MatPs) ;
			lcQuery = [Select Cpros, Pesos, Qtds, EmpOs, DopeOs, NumeOs, Nops, CodCors, CodTams ] + ;
					    [From SigOpEtq ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEti') < 1)
			Select LocalEti
				Insert Into xPesa (Cpros, Peso, Qtds, Emps, Dopes, Numes, Nops, Oper, Cors, Tams) ;
		Insert Into TmpNens (Emps, Dopps, Numps, Usuars, Datars, Datas) ;
	 	Select TmpOperacao
		Select TmpNens
	Select TmpNens
Select TmpNens
			Select xNensi
			Select xMfas
		Insert Into crSigCdNec (Datars, Datas, Emps, dopps, numps, Obss, Usuars, TotPesos,  Grupoos, Contaos, ;
	Select crSigCdNec
	Select crSigCdNec			
	Select crSigCdNec
Select TmpNens
If Not Empty(This.Value) And Not Seek(This.Value, 'TempGccr', 'BalCodigo')
	lcQuery = [Select IClis, RClis ] + ;
			    [From SigCdCli ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempCli') < 1)
	lcQuery = [Select IClis, RClis ] + ;
			    [From SigCdCli ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempCli') < 1)
If Not Empty(This.Value) And Not Seek(This.Value, 'TempGccr', 'BalCodigo')
	lcQuery = [Select IClis, RClis ] + ;
			    [From SigCdCli ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempCli') < 1)
	lcQuery = [Select IClis, RClis ] + ;
			    [From SigCdCli ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempCli') < 1)
	Select Codigos ;
	  From TmpOperacao ;
		Select xMFas
		Delete All For Nenvs = _nOperacao
		Select xOpi
		Delete All For Nenvs = _nOperacao
		Select xPesa
		Delete All For Nenvs = _nOperacao
		Select xNensi
		Delete All For Nenvs = _nOperacao
		Select TmpOperacao
			Insert Into TmpOperacao (Codigos) Values (0) 
		Select TmpNens
		Select TmpNens
	Select LocalMFas
			Select TmpNens
		Select LocalMFas
		Select xMFas
			Select xMFas
			Delete All For Nenvs = Val(Right(Str(_OldCodigo, 12), 10))
			Select xOpi
			Delete All For Nenvs = Val(Right(Str(_OldCodigo, 12), 10))
			Select xPesa
			Delete All For Nenvs = Val(Right(Str(_OldCodigo, 12), 10))
		Select xNensi
			Delete All For Emps + Dopps + Str(Numps, 10) = _Chave
		Delete All For Empty(CMats) And Empty(Nops) And Empty(Qtds)
		Select LocalMFas
			lcQuery = [Update SigCdNec ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdNec 1)')
			Select LocalOpi
				Insert Into xOpi (Nops, Oper, Qtds, CPros, Indiv, Amarra, Nenvs, Emps, Dopes, Numes) ;
				Insert Into xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, Nops) ;
			Insert Into xMFas (Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, Grupoos, Contaos, Grupods, ;
			Select LocalNensi
				Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, ;
				Select xNensi
				If Not Seek(_Operacao + Space(10))
					Insert Into xNensi (Nops, Nenvs, Visivel, Rateio, CUnis) ;
			Select LocalCompo
				=Seek(LocalPro.CUnis, 'crSigCdUni', 'CUnis')
				Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, CGrus, QtFaseAnt, ;
				If Not Seek(_Operacao + LocalCompo.Mats, 'xNensi', 'NEnvCMat')
					Insert Into xNensi (Nops, Nenvs, CMats, CDescs, CUnis, CGrus, Visivel, Rateio, FlagIncs, Cats) ;
			Select TmpNens
			Select TmpNens
		Select TmpOperacao
	Select TmpNens
Select xNensi
Select TmpNens
	Select xMfas
If Not Empty(This.Value) And Not Seek(This.Value, 'TempGccr', 'BalCodigo')
	lcQuery = [Select IClis, RClis ] + ;
			    [From SigCdCli ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempCli') < 1)
	lcQuery = [Select IClis, RClis ] + ;
			    [From SigCdCli ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempCli') < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formepd.prg) - TRECHOS RELEVANTES PARA PASS SQL (2266 linhas total):

*-- Linhas 67 a 97:
67: 
68:         CATCH TO loc_oErro
69:             MsgErro("Erro em InicializarForm: " + loc_oErro.Message + CHR(13) + ;
70:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
71:         ENDTRY
72: 
73:         RETURN loc_lSucesso
74:     ENDPROC
75: 
76:     *--------------------------------------------------------------------------
77:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
78:     *--------------------------------------------------------------------------
79:     PROTECTED PROCEDURE ConfigurarPageFrame()
80:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
81: 
82:         WITH THIS.pgf_4c_Paginas
83:             .PageCount  = 2
84:             .Left       = 0
85:             .Top        = -29
86:             .Width      = THIS.Width
87:             .Height     = THIS.Height + 29
88:             .Tabs       = .F.
89:             .Visible    = .T.
90:             .Page1.Caption   = "Lista"
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page2.Caption   = "Dados"
93:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:             .Page1.BackColor = RGB(236, 233, 216)
95:             .Page2.BackColor = RGB(236, 233, 216)
96:         ENDWITH
97:     ENDPROC

*-- Linhas 340 a 358:
340:             .HighlightBackColor = RGB(255, 255, 255)
341:             .HighlightForeColor = RGB(15, 41, 104)
342:             .HighlightStyle     = 2
343:             .DeleteMark         = .F.
344:             .RecordMark         = .F.
345:             .RowHeight          = 16
346:             .ScrollBars         = 2
347:             .GridLines          = 3
348:             .ReadOnly           = .T.
349:             .Visible            = .T.
350:         ENDWITH
351: 
352:         WITH loc_oGrid.Column1
353:             .Width           = 75
354:             .Alignment       = 2
355:             .Header1.Caption = "N" + CHR(250) + "mero"
356:         ENDWITH
357:         WITH loc_oGrid.Column2
358:             .Width           = 80

*-- Linhas 1010 a 1028:
1010:             .FontSize    = 8
1011:             .ForeColor   = RGB(90, 90, 90)
1012:             .BackColor   = RGB(255, 255, 255)
1013:             .DeleteMark  = .F.
1014:             .RecordMark  = .F.
1015:             .RowHeight   = 16
1016:             .ScrollBars  = 2
1017:             .GridLines   = 3
1018:             .ReadOnly    = .T.
1019:             .Visible     = .F.
1020:         ENDWITH
1021: 
1022:         WITH loc_oPagina.grd_4c_GradeOperacao.Column1
1023:             .Width           = 165
1024:             .Header1.Caption = "Ordem Produ" + CHR(231) + CHR(227) + "o"
1025:         ENDWITH
1026: 
1027:         *-- Botao de Ordens ao lado da grade (top=69+29=98)
1028:         loc_oPagina.AddObject("cmd_4c_BotOrdens", "CommandButton")

*-- Linhas 1067 a 1091:
1067: 
1068:                     loc_oGrid.ColumnCount = 7
1069:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1070:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.numps"
1071:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datas"
1072:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.grupoos"
1073:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.contaos"
1074:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.grupods"
1075:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.contads"
1076:                     loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.usuars"
1077: 
1078:                     *-- Reconfigurar headers ap?s RecordSource (VFP reseta ao mudar RecordSource)
1079:                     loc_oGrid.Column1.Header1.Caption = "N" + CHR(250) + "mero"
1080:                     loc_oGrid.Column2.Header1.Caption = "Data"
1081:                     loc_oGrid.Column3.Header1.Caption = "Gr.Origem"
1082:                     loc_oGrid.Column4.Header1.Caption = "Conta Origem"
1083:                     loc_oGrid.Column5.Header1.Caption = "Gr.Destino"
1084:                     loc_oGrid.Column6.Header1.Caption = "Conta Destino"
1085:                     loc_oGrid.Column7.Header1.Caption = "Usu" + CHR(225) + "rio"
1086: 
1087:                     THIS.FormatarGridLista(loc_oGrid)
1088:                     loc_lResultado = .T.
1089:                 ENDIF
1090:             ENDIF
1091:         CATCH TO loc_oErro

*-- Linhas 1190 a 1231:
1190:            EOF("cursor_4c_Dados")
1191:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
1192:         ELSE
1193:             SELECT cursor_4c_Dados
1194:             loc_cChave = ALLTRIM(cursor_4c_Dados.empdnps)
1195:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1196:                 THIS.this_cModoAtual = "VISUALIZAR"
1197:                 THIS.BOParaForm()
1198:                 THIS.HabilitarCampos(.F.)
1199:                 THIS.AjustarBotoesPorModo()
1200:                 THIS.AlternarPagina(2)
1201:             ENDIF
1202:         ENDIF
1203:     ENDPROC
1204: 
1205:     *--------------------------------------------------------------------------
1206:     * BtnAlterarClick - Carrega registro selecionado para edi??o
1207:     *--------------------------------------------------------------------------
1208:     PROCEDURE BtnAlterarClick()
1209:         LOCAL loc_cChave
1210:         loc_cChave = ""
1211: 
1212:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
1213:            EOF("cursor_4c_Dados")
1214:             MsgAviso("Nenhum registro selecionado.", "Alterar")
1215:         ELSE
1216:             SELECT cursor_4c_Dados
1217:             loc_cChave = ALLTRIM(cursor_4c_Dados.empdnps)
1218:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1219:                 THIS.this_oBusinessObject.EditarRegistro()
1220:                 THIS.this_cModoAtual = "ALTERAR"
1221:                 THIS.BOParaForm()
1222:                 THIS.HabilitarCampos(.T.)
1223:                 THIS.AjustarBotoesPorModo()
1224:                 THIS.AlternarPagina(2)
1225:             ENDIF
1226:         ENDIF
1227:     ENDPROC
1228: 
1229:     *--------------------------------------------------------------------------
1230:     * BtnExcluirClick - Exclui registro selecionado ap?s confirma??o
1231:     *--------------------------------------------------------------------------

*-- Linhas 1238 a 1256:
1238:            EOF("cursor_4c_Dados")
1239:             MsgAviso("Nenhum registro selecionado.", "Excluir")
1240:         ELSE
1241:             SELECT cursor_4c_Dados
1242:             loc_cChave  = ALLTRIM(cursor_4c_Dados.empdnps)
1243:             loc_nNumero = cursor_4c_Dados.numps
1244: 
1245:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1246:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro " + ;
1247:                                TRANSFORM(loc_nNumero) + "?", "Excluir")
1248:                     IF THIS.this_oBusinessObject.Excluir()
1249:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1250:                         THIS.CarregarLista()
1251:                     ENDIF
1252:                 ENDIF
1253:             ENDIF
1254:         ENDIF
1255:     ENDPROC
1256: 

*-- Linhas 1341 a 1359:
1341: 
1342:         TRY
1343:             IF USED("cursor_4c_OpConfig") AND !EOF("cursor_4c_OpConfig")
1344:                 SELECT cursor_4c_OpConfig
1345:                 loc_lTemBoleto = (cursor_4c_OpConfig.boletos = 1)
1346:             ENDIF
1347: 
1348:             IF loc_lTemBoleto
1349:                 THIS.ImprimirBoleto()
1350:                 loc_lResultado = .T.
1351:             ENDIF
1352:         CATCH TO loc_oErro
1353:             MsgErro("Erro em BtnBoletoClick: " + loc_oErro.Message, "Erro")
1354:             loc_lResultado = .F.
1355:         ENDTRY
1356: 
1357:         RETURN loc_lResultado
1358:     ENDPROC
1359: 

*-- Linhas 1366 a 1384:
1366: 
1367:         TRY
1368:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1369:                 SELECT cursor_4c_Dados
1370:                 DO SigPrBol WITH ALLTRIM(cursor_4c_Dados.emps), ;
1371:                                   ALLTRIM(cursor_4c_Dados.dopps), ;
1372:                                   cursor_4c_Dados.numps
1373:                 loc_lResultado = .T.
1374:             ENDIF
1375:         CATCH TO loc_oErro
1376:             MsgErro("Erro ao imprimir boleto: " + loc_oErro.Message, "Erro")
1377:             loc_lResultado = .F.
1378:         ENDTRY
1379: 
1380:         RETURN loc_lResultado
1381:     ENDPROC
1382: 
1383:     *--------------------------------------------------------------------------
1384:     * BtnDocumentoClick - Imprime documento se opera" + CHR(231) + CHR(227) + "o permite

*-- Linhas 1391 a 1415:
1391: 
1392:         TRY
1393:             IF USED("cursor_4c_OpConfig") AND !EOF("cursor_4c_OpConfig")
1394:                 SELECT cursor_4c_OpConfig
1395:                 loc_lTemDoc  = (cursor_4c_OpConfig.docus = 1)
1396:                 loc_nQtdDocs = cursor_4c_OpConfig.qtddocs
1397:             ENDIF
1398: 
1399:             IF loc_lTemDoc AND USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1400:                 SELECT cursor_4c_Dados
1401:                 DO SigPrIdc WITH ALLTRIM(cursor_4c_Dados.emps), ;
1402:                                   ALLTRIM(cursor_4c_Dados.dopps), ;
1403:                                   cursor_4c_Dados.numps, 0, ;
1404:                                   loc_nQtdDocs, ;
1405:                                   .F., .F., .F., .F., .F., .F., THIS
1406:                 loc_lResultado = .T.
1407:             ENDIF
1408:         CATCH TO loc_oErro
1409:             MsgErro("Erro em BtnDocumentoClick: " + loc_oErro.Message, "Erro")
1410:             loc_lResultado = .F.
1411:         ENDTRY
1412: 
1413:         RETURN loc_lResultado
1414:     ENDPROC
1415: 

*-- Linhas 1490 a 1510:
1490: 
1491:         IF !EMPTY(loc_cGrupo)
1492:             TRY
1493:                 loc_cSQL    = "SELECT TOP 1 Codigos FROM SigCdGcr WHERE Codigos = " + ;
1494:                               EscaparSQL(loc_cGrupo)
1495:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoOsVal")
1496: 
1497:                 IF loc_nResult < 0 OR !USED("cursor_4c_GrupoOsVal") OR ;
1498:                    RECCOUNT("cursor_4c_GrupoOsVal") = 0
1499:                     THIS.AbrirLookupGrupoOs()
1500:                 ENDIF
1501: 
1502:                 IF USED("cursor_4c_GrupoOsVal")
1503:                     USE IN cursor_4c_GrupoOsVal
1504:                 ENDIF
1505:             CATCH TO loc_oErro
1506:                 MsgErro("Erro ao validar Grupo: " + loc_oErro.Message, "Erro")
1507:             ENDTRY
1508:         ENDIF
1509:     ENDPROC
1510: 

*-- Linhas 1528 a 1546:
1528:                     loc_oBusca.Show()
1529:                 ENDIF
1530:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupoOs")
1531:                     SELECT cursor_4c_BuscaGrupoOs
1532:                     loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value = ALLTRIM(cursor_4c_BuscaGrupoOs.Codigos)
1533:                 ENDIF
1534:                 loc_oBusca.Release()
1535:             ENDIF
1536:         CATCH TO loc_oErro
1537:             MsgErro("Erro ao abrir busca de Grupos: " + loc_oErro.Message, "Erro")
1538:         ENDTRY
1539: 
1540:         IF USED("cursor_4c_BuscaGrupoOs")
1541:             USE IN cursor_4c_BuscaGrupoOs
1542:         ENDIF
1543:     ENDPROC
1544: 
1545:     *--------------------------------------------------------------------------
1546:     * TxtContaOsKeyPress - F4 abre lookup de Contas por C" + CHR(243) + "digo (Origem)

*-- Linhas 1561 a 1585:
1561: 
1562:         IF !EMPTY(loc_cConta)
1563:             TRY
1564:                 loc_cSQL    = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1565:                               EscaparSQL(loc_cConta)
1566:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaOsVal")
1567: 
1568:                 IF loc_nResult >= 0 AND USED("cursor_4c_ContaOsVal") AND ;
1569:                    RECCOUNT("cursor_4c_ContaOsVal") > 0
1570:                     SELECT cursor_4c_ContaOsVal
1571:                     loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ALLTRIM(cursor_4c_ContaOsVal.RClis)
1572:                 ELSE
1573:                     THIS.AbrirLookupContaOs()
1574:                 ENDIF
1575: 
1576:                 IF USED("cursor_4c_ContaOsVal")
1577:                     USE IN cursor_4c_ContaOsVal
1578:                 ENDIF
1579:             CATCH TO loc_oErro
1580:                 MsgErro("Erro ao validar Conta: " + loc_oErro.Message, "Erro")
1581:             ENDTRY
1582:         ENDIF
1583:     ENDPROC
1584: 
1585:     *--------------------------------------------------------------------------

*-- Linhas 1602 a 1620:
1602:                     loc_oBusca.Show()
1603:                 ENDIF
1604:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaOs")
1605:                     SELECT cursor_4c_BuscaContaOs
1606:                     loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value    = ALLTRIM(cursor_4c_BuscaContaOs.IClis)
1607:                     loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ALLTRIM(cursor_4c_BuscaContaOs.RClis)
1608:                 ENDIF
1609:                 loc_oBusca.Release()
1610:             ENDIF
1611:         CATCH TO loc_oErro
1612:             MsgErro("Erro ao abrir busca de Contas: " + loc_oErro.Message, "Erro")
1613:         ENDTRY
1614: 
1615:         IF USED("cursor_4c_BuscaContaOs")
1616:             USE IN cursor_4c_BuscaContaOs
1617:         ENDIF
1618:     ENDPROC
1619: 
1620:     *--------------------------------------------------------------------------

*-- Linhas 1646 a 1664:
1646:                     loc_oBusca.Show()
1647:                 ENDIF
1648:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaNomeContaOs")
1649:                     SELECT cursor_4c_BuscaNomeContaOs
1650:                     loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value     = ALLTRIM(cursor_4c_BuscaNomeContaOs.IClis)
1651:                     loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ALLTRIM(cursor_4c_BuscaNomeContaOs.RClis)
1652:                 ENDIF
1653:                 loc_oBusca.Release()
1654:             ENDIF
1655:         CATCH TO loc_oErro
1656:             MsgErro("Erro ao abrir busca por Nome: " + loc_oErro.Message, "Erro")
1657:         ENDTRY
1658: 
1659:         IF USED("cursor_4c_BuscaNomeContaOs")
1660:             USE IN cursor_4c_BuscaNomeContaOs
1661:         ENDIF
1662:     ENDPROC
1663: 
1664:     *==========================================================================

*-- Linhas 1684 a 1704:
1684: 
1685:         IF !EMPTY(loc_cGrupo)
1686:             TRY
1687:                 loc_cSQL    = "SELECT TOP 1 Codigos FROM SigCdGcr WHERE Codigos = " + ;
1688:                               EscaparSQL(loc_cGrupo)
1689:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoDsVal")
1690: 
1691:                 IF loc_nResult < 0 OR !USED("cursor_4c_GrupoDsVal") OR ;
1692:                    RECCOUNT("cursor_4c_GrupoDsVal") = 0
1693:                     THIS.AbrirLookupGrupoDs()
1694:                 ENDIF
1695: 
1696:                 IF USED("cursor_4c_GrupoDsVal")
1697:                     USE IN cursor_4c_GrupoDsVal
1698:                 ENDIF
1699:             CATCH TO loc_oErro
1700:                 MsgErro("Erro ao validar Grupo Destino: " + loc_oErro.Message, "Erro")
1701:             ENDTRY
1702:         ENDIF
1703:     ENDPROC
1704: 

*-- Linhas 1722 a 1740:
1722:                     loc_oBusca.Show()
1723:                 ENDIF
1724:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupoDs")
1725:                     SELECT cursor_4c_BuscaGrupoDs
1726:                     loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value = ALLTRIM(cursor_4c_BuscaGrupoDs.Codigos)
1727:                 ENDIF
1728:                 loc_oBusca.Release()
1729:             ENDIF
1730:         CATCH TO loc_oErro
1731:             MsgErro("Erro ao abrir busca de Grupos Destino: " + loc_oErro.Message, "Erro")
1732:         ENDTRY
1733: 
1734:         IF USED("cursor_4c_BuscaGrupoDs")
1735:             USE IN cursor_4c_BuscaGrupoDs
1736:         ENDIF
1737:     ENDPROC
1738: 
1739:     *--------------------------------------------------------------------------
1740:     * TxtContaDsKeyPress - F4 abre lookup de Contas por Codigo (Destino)

*-- Linhas 1755 a 1779:
1755: 
1756:         IF !EMPTY(loc_cConta)
1757:             TRY
1758:                 loc_cSQL    = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1759:                               EscaparSQL(loc_cConta)
1760:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDsVal")
1761: 
1762:                 IF loc_nResult >= 0 AND USED("cursor_4c_ContaDsVal") AND ;
1763:                    RECCOUNT("cursor_4c_ContaDsVal") > 0
1764:                     SELECT cursor_4c_ContaDsVal
1765:                     loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ALLTRIM(cursor_4c_ContaDsVal.RClis)
1766:                 ELSE
1767:                     THIS.AbrirLookupContaDs()
1768:                 ENDIF
1769: 
1770:                 IF USED("cursor_4c_ContaDsVal")
1771:                     USE IN cursor_4c_ContaDsVal
1772:                 ENDIF
1773:             CATCH TO loc_oErro
1774:                 MsgErro("Erro ao validar Conta Destino: " + loc_oErro.Message, "Erro")
1775:             ENDTRY
1776:         ENDIF
1777:     ENDPROC
1778: 
1779:     *--------------------------------------------------------------------------

*-- Linhas 1796 a 1814:
1796:                     loc_oBusca.Show()
1797:                 ENDIF
1798:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaDs")
1799:                     SELECT cursor_4c_BuscaContaDs
1800:                     loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value    = ALLTRIM(cursor_4c_BuscaContaDs.IClis)
1801:                     loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ALLTRIM(cursor_4c_BuscaContaDs.RClis)
1802:                 ENDIF
1803:                 loc_oBusca.Release()
1804:             ENDIF
1805:         CATCH TO loc_oErro
1806:             MsgErro("Erro ao abrir busca de Contas Destino: " + loc_oErro.Message, "Erro")
1807:         ENDTRY
1808: 
1809:         IF USED("cursor_4c_BuscaContaDs")
1810:             USE IN cursor_4c_BuscaContaDs
1811:         ENDIF
1812:     ENDPROC
1813: 
1814:     *--------------------------------------------------------------------------

*-- Linhas 1840 a 1858:
1840:                     loc_oBusca.Show()
1841:                 ENDIF
1842:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaNomeContaDs")
1843:                     SELECT cursor_4c_BuscaNomeContaDs
1844:                     loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value    = ALLTRIM(cursor_4c_BuscaNomeContaDs.IClis)
1845:                     loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ALLTRIM(cursor_4c_BuscaNomeContaDs.RClis)
1846:                 ENDIF
1847:                 loc_oBusca.Release()
1848:             ENDIF
1849:         CATCH TO loc_oErro
1850:             MsgErro("Erro ao abrir busca por Nome Destino: " + loc_oErro.Message, "Erro")
1851:         ENDTRY
1852: 
1853:         IF USED("cursor_4c_BuscaNomeContaDs")
1854:             USE IN cursor_4c_BuscaNomeContaDs
1855:         ENDIF
1856:     ENDPROC
1857: 
1858:     *==========================================================================

*-- Linhas 1878 a 1898:
1878: 
1879:         IF !EMPTY(loc_cGrupo)
1880:             TRY
1881:                 loc_cSQL    = "SELECT TOP 1 Codigos FROM SigCdGcr WHERE Codigos = " + ;
1882:                               EscaparSQL(loc_cGrupo)
1883:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrVendsVal")
1884: 
1885:                 IF loc_nResult < 0 OR !USED("cursor_4c_GrVendsVal") OR ;
1886:                    RECCOUNT("cursor_4c_GrVendsVal") = 0
1887:                     THIS.AbrirLookupGrVends()
1888:                 ENDIF
1889: 
1890:                 IF USED("cursor_4c_GrVendsVal")
1891:                     USE IN cursor_4c_GrVendsVal
1892:                 ENDIF
1893:             CATCH TO loc_oErro
1894:                 MsgErro("Erro ao validar Grupo Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
1895:             ENDTRY
1896:         ENDIF
1897:     ENDPROC
1898: 

*-- Linhas 1916 a 1934:
1916:                     loc_oBusca.Show()
1917:                 ENDIF
1918:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrVends")
1919:                     SELECT cursor_4c_BuscaGrVends
1920:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value = ALLTRIM(cursor_4c_BuscaGrVends.Codigos)
1921:                 ENDIF
1922:                 loc_oBusca.Release()
1923:             ENDIF
1924:         CATCH TO loc_oErro
1925:             MsgErro("Erro ao abrir busca de Grupos Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
1926:         ENDTRY
1927: 
1928:         IF USED("cursor_4c_BuscaGrVends")
1929:             USE IN cursor_4c_BuscaGrVends
1930:         ENDIF
1931:     ENDPROC
1932: 
1933:     *--------------------------------------------------------------------------
1934:     * TxtVendsKeyPress - F4 abre lookup de Contas por Codigo (Responsavel)

*-- Linhas 1949 a 1973:
1949: 
1950:         IF !EMPTY(loc_cConta)
1951:             TRY
1952:                 loc_cSQL    = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1953:                               EscaparSQL(loc_cConta)
1954:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VendsVal")
1955: 
1956:                 IF loc_nResult >= 0 AND USED("cursor_4c_VendsVal") AND ;
1957:                    RECCOUNT("cursor_4c_VendsVal") > 0
1958:                     SELECT cursor_4c_VendsVal
1959:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ALLTRIM(cursor_4c_VendsVal.RClis)
1960:                 ELSE
1961:                     THIS.AbrirLookupVends()
1962:                 ENDIF
1963: 
1964:                 IF USED("cursor_4c_VendsVal")
1965:                     USE IN cursor_4c_VendsVal
1966:                 ENDIF
1967:             CATCH TO loc_oErro
1968:                 MsgErro("Erro ao validar Conta Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
1969:             ENDTRY
1970:         ENDIF
1971:     ENDPROC
1972: 
1973:     *--------------------------------------------------------------------------

*-- Linhas 1990 a 2008:
1990:                     loc_oBusca.Show()
1991:                 ENDIF
1992:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVends")
1993:                     SELECT cursor_4c_BuscaVends
1994:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value    = ALLTRIM(cursor_4c_BuscaVends.IClis)
1995:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ALLTRIM(cursor_4c_BuscaVends.RClis)
1996:                 ENDIF
1997:                 loc_oBusca.Release()
1998:             ENDIF
1999:         CATCH TO loc_oErro
2000:             MsgErro("Erro ao abrir busca de Contas Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
2001:         ENDTRY
2002: 
2003:         IF USED("cursor_4c_BuscaVends")
2004:             USE IN cursor_4c_BuscaVends
2005:         ENDIF
2006:     ENDPROC
2007: 
2008:     *--------------------------------------------------------------------------

*-- Linhas 2034 a 2052:
2034:                     loc_oBusca.Show()
2035:                 ENDIF
2036:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaNomeVends")
2037:                     SELECT cursor_4c_BuscaNomeVends
2038:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value    = ALLTRIM(cursor_4c_BuscaNomeVends.IClis)
2039:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ALLTRIM(cursor_4c_BuscaNomeVends.RClis)
2040:                 ENDIF
2041:                 loc_oBusca.Release()
2042:             ENDIF
2043:         CATCH TO loc_oErro
2044:             MsgErro("Erro ao abrir busca por Nome Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
2045:         ENDTRY
2046: 
2047:         IF USED("cursor_4c_BuscaNomeVends")
2048:             USE IN cursor_4c_BuscaNomeVends
2049:         ENDIF
2050:     ENDPROC
2051: 
2052:     *--------------------------------------------------------------------------

*-- Linhas 2061 a 2095:
2061:         TRY
2062:             IF loc_oGrade.Visible
2063:                 loc_oGrade.Visible = .F.
2064:                 loc_lResultado     = .T.
2065:             ELSE
2066:                 IF USED("cursor_4c_Operacoes")
2067:                     USE IN cursor_4c_Operacoes
2068:                 ENDIF
2069: 
2070:                 IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cEmpDNps))
2071:                     loc_cSQL    = "SELECT a.nops FROM SigCdNei a" + ;
2072:                                   " WHERE a.empdnps = " + ;
2073:                                   EscaparSQL(THIS.this_oBusinessObject.this_cEmpDNps) + ;
2074:                                   " ORDER BY a.nops"
2075:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")
2076: 
2077:                     IF loc_nResult >= 0 AND USED("cursor_4c_Operacoes")
2078:                         loc_oGrade.ColumnCount = 1
2079:                         loc_oGrade.RecordSource          = "cursor_4c_Operacoes"
2080:                         loc_oGrade.Column1.ControlSource = "cursor_4c_Operacoes.nops"
2081:                         loc_oGrade.Column1.Header1.Caption = "Ordem Produ" + CHR(231) + CHR(227) + "o"
2082:                         loc_oGrade.Visible = .T.
2083:                         loc_lResultado     = .T.
2084:                     ENDIF
2085:                 ELSE
2086:                     loc_oGrade.Visible = .T.
2087:                     loc_lResultado     = .T.
2088:                 ENDIF
2089:             ENDIF
2090:         CATCH TO loc_oErro
2091:             MsgErro("Erro em BtnBotOrdensClick: " + loc_oErro.Message, "Erro")
2092:             loc_lResultado = .F.
2093:         ENDTRY
2094: 
2095:         RETURN loc_lResultado

*-- Linhas 2131 a 2198:
2131: 
2132:         IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cContaOs))
2133:             TRY
2134:                 loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli WHERE IClis = " + ;
2135:                            EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cContaOs))
2136:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NomeOsBo")
2137:                 IF loc_nResult >= 0 AND USED("cursor_4c_NomeOsBo") AND ;
2138:                    RECCOUNT("cursor_4c_NomeOsBo") > 0
2139:                     SELECT cursor_4c_NomeOsBo
2140:                     loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ALLTRIM(cursor_4c_NomeOsBo.RClis)
2141:                 ENDIF
2142:                 IF USED("cursor_4c_NomeOsBo")
2143:                     USE IN cursor_4c_NomeOsBo
2144:                 ENDIF
2145:             CATCH TO loc_oErro
2146:                 MsgErro("Erro ao carregar nome conta origem: " + loc_oErro.Message, "Erro")
2147:             ENDTRY
2148:         ENDIF
2149: 
2150:         loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoDs)
2151:         loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cContaDs)
2152:         loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ""
2153: 
2154:         IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cContaDs))
2155:             TRY
2156:                 loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli WHERE IClis = " + ;
2157:                            EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cContaDs))
2158:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NomeDsBo")
2159:                 IF loc_nResult >= 0 AND USED("cursor_4c_NomeDsBo") AND ;
2160:                    RECCOUNT("cursor_4c_NomeDsBo") > 0
2161:                     SELECT cursor_4c_NomeDsBo
2162:                     loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ALLTRIM(cursor_4c_NomeDsBo.RClis)
2163:                 ENDIF
2164:                 IF USED("cursor_4c_NomeDsBo")
2165:                     USE IN cursor_4c_NomeDsBo
2166:                 ENDIF
2167:             CATCH TO loc_oErro
2168:                 MsgErro("Erro ao carregar nome conta destino: " + loc_oErro.Message, "Erro")
2169:             ENDTRY
2170:         ENDIF
2171: 
2172:         loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cGrVends)
2173:         loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cVends)
2174:         loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ""
2175: 
2176:         IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cVends))
2177:             TRY
2178:                 loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli WHERE IClis = " + ;
2179:                            EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cVends))
2180:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NomeVendsBo")
2181:                 IF loc_nResult >= 0 AND USED("cursor_4c_NomeVendsBo") AND ;
2182:                    RECCOUNT("cursor_4c_NomeVendsBo") > 0
2183:                     SELECT cursor_4c_NomeVendsBo
2184:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ALLTRIM(cursor_4c_NomeVendsBo.RClis)
2185:                 ENDIF
2186:                 IF USED("cursor_4c_NomeVendsBo")
2187:                     USE IN cursor_4c_NomeVendsBo
2188:                 ENDIF
2189:             CATCH TO loc_oErro
2190:                 MsgErro("Erro ao carregar nome respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
2191:             ENDTRY
2192:         ENDIF
2193:     ENDPROC
2194: 
2195:     *--------------------------------------------------------------------------
2196:     * HabilitarCampos - Habilita/desabilita campos editaveis na Page2
2197:     *--------------------------------------------------------------------------
2198:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)


### BO (C:\4c\projeto\app\classes\epdBO.prg):
*******************************************************************************
* epdBO.prg - Business Object para Finalizacao Antecipada
* Tabela principal: SigCdNec
* Chave: EmpDNps (Emps C3 + Dopps C20 + Str(Numps,10))
*******************************************************************************

DEFINE CLASS epdBO AS BusinessBase

    *-- Chave primaria composta
    this_cEmpDNps    = ""    && C(33) Chave: Emps+Dopps+Str(Numps,10)
    this_cEmpDNpsC   = ""    && C(29) Chave curta: Emps+Dopps+Str(Numps,6)

    *-- Campos de SigCdNec (confirmados por ControlSource)
    this_cEmps       = ""    && C(3)  Empresa
    this_cDopps      = ""    && C(20) Tipo de Operacao (fixo: ENCERRAMENTO DIRETO)
    this_nNumps      = 0     && N(10) Numero do necessario (codigo)
    this_dDatas      = {}    && D     Data de finalizacao

    *-- Origem (ControlSource: tmpnens.grupoos, tmpnens.contaos)
    this_cGrupoOs    = ""    && C     Grupo de origem
    this_cContaOs    = ""    && C     Conta de origem (IClis)

    *-- Destino (ControlSource: tmpnens.grupods, tmpnens.contads)
    this_cGrupoDs    = ""    && C     Grupo de destino
    this_cContaDs    = ""    && C     Conta de destino (IClis)

    *-- Responsavel (ControlSource: tmpnens.grvends, tmpnens.vends)
    this_cGrVends    = ""    && C     Grupo do responsavel
    this_cVends      = ""    && C     Conta do responsavel (IClis)

    *-- Controles operacionais (propriedades do form original)
    this_cDopp       = ""    && C(20) Operacao fixa ENCERRAMENTO DIRETO
    this_lAutomatico = .F.   && L     Modo automatico (parametro)
    this_lEditaOrig  = .T.   && L     Permite editar origem (editaorigem)
    this_nNops       = 0     && N     Numero da ordem de producao

    *====================================================================
    PROCEDURE Init()
    *====================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdNec"
            THIS.this_cCampoChave = "EmpDNps"
            THIS.this_cDopp       = PADR("ENCERRAMENTO DIRETO", 20)
            loc_lResultado        = .T.
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
    *====================================================================
        RETURN THIS.this_cEmpDNps
    ENDPROC

    *====================================================================
    FUNCTION Buscar(par_cFiltro)
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        LOCAL loc_cEmpresa, loc_cOpI, loc_cOpF
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cEmpresa = go_4c_Sistema.cCodEmpresa
            loc_cOpI     = loc_cEmpresa + THIS.this_cDopp + STR(0,          10)
            loc_cOpF     = loc_cEmpresa + THIS.this_cDopp + STR(9999999999, 10)

            loc_cSQL = "SELECT a.empdnps, a.emps, a.dopps, a.numps," + ;
                       " a.datas, a.grupoos, a.contaos, a.grupods," + ;
                       " a.contads, a.grvends, a.vends, a.cidchaves," + ;
                       " a.chksubn, a.usuars, a.obss" + ;
                       " FROM SigCdNec a" + ;
                       " WHERE a.empdnps BETWEEN '" + loc_cOpI + "' AND '" + loc_cOpF + "'"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.numps"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    FUNCTION CarregarPorCodigo(par_cChave)
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.empdnps, a.emps, a.dopps, a.numps," + ;
                       " a.datas, a.grupoos, a.contaos, a.grupods," + ;
                       " a.contads, a.grvends, a.vends, a.cidchaves," + ;
                       " a.chksubn, a.usuars, a.obss" + ;
                       " FROM SigCdNec a" + ;
                       " WHERE a.empdnps = " + EscaparSQL(par_cChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado       = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
    *====================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps     = TratarNulo(emps,    "C")
                THIS.this_cDopps    = TratarNulo(dopps,   "C")
                THIS.this_nNumps    = TratarNulo(numps,   "N")
                THIS.this_dDatas    = TratarNulo(datas,   "D")
                THIS.this_cGrupoOs  = TratarNulo(grupoos, "C")
                THIS.this_cContaOs  = TratarNulo(contaos, "C")
                THIS.this_cGrupoDs  = TratarNulo(grupods, "C")
                THIS.this_cContaDs  = TratarNulo(contads, "C")
                THIS.this_cGrVends  = TratarNulo(grvends, "C")
                THIS.this_cVends    = TratarNulo(vends,   "C")
                THIS.this_cEmpDNps  = TratarNulo(empdnps, "C")
                THIS.this_cEmpDNpsC = THIS.this_cEmps + THIS.this_cDopps + ;
                                      STR(THIS.this_nNumps, 6)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION Inserir()
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cCidChave
        loc_lResultado = .F.

        TRY
            THIS.this_cEmps  = go_4c_Sistema.cCodEmpresa
            THIS.this_cDopps = THIS.this_cDopp

            THIS.this_cEmpDNps  = THIS.this_cEmps + THIS.this_cDopps + ;
                                   STR(THIS.this_nNumps, 10)
            THIS.this_cEmpDNpsC = THIS.this_cEmps + THIS.this_cDopps + ;
                                   STR(THIS.this_nNumps, 6)

            loc_cCidChave = SUBSTR(THIS.this_cEmpDNps, 14, 20)

            loc_cSQL = "INSERT INTO SigCdNec" + ;
                       " (emps, dopps, numps, datas," + ;
                       "  grupoos, contaos, grupods, contads," + ;
                       "  grvends, vends, empdnps, cidchaves, usuars," + ;
                       "  chksubn, totpesos, imprs, lccs, procbals, procdbal," + ;
                       "  docus, locals, ntrans, nops, naceites, entrabs," + ;
                       "  autos, libprods, codnconfs, numbalds, numbals, codobs," + ;
                       "  empds, nconforms, nlotes, jobs, pesolancs, usulins," + ;
                       "  chkbaixa, usuconfs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cEmps)    + "," + ;
                       EscaparSQL(THIS.this_cDopps)   + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumps) + "," + ;
                       FormatarDataSQL(THIS.this_dDatas)   + "," + ;
                       EscaparSQL(LEFT(THIS.this_cGrupoOs, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cContaOs, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cGrupoDs, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cContaDs, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cGrVends, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cVends,   10)) + "," + ;
                       EscaparSQL(THIS.this_cEmpDNps)  + "," + ;
                       EscaparSQL(loc_cCidChave)       + "," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + "," + ;
                       "0,0,0,0,0,0," + ;
                       "'          ','          ',0,0,0,0," + ;
                       "0,'          ','          ',0,0,0," + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ",0,0,'          ',0," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ",0,'          ')"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION Atualizar()
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNec SET" + ;
                       "  datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       "  grupoos = " + EscaparSQL(LEFT(THIS.this_cGrupoOs, 10)) + "," + ;
                       "  contaos = " + EscaparSQL(LEFT(THIS.this_cContaOs, 10)) + "," + ;
                       "  grupods = " + EscaparSQL(LEFT(THIS.this_cGrupoDs, 10)) + "," + ;
                       "  contads = " + EscaparSQL(LEFT(THIS.this_cContaDs, 10)) + "," + ;
                       "  grvends = " + EscaparSQL(LEFT(THIS.this_cGrVends, 10)) + "," + ;
                       "  vends   = " + EscaparSQL(LEFT(THIS.this_cVends,   10)) + "," + ;
                       "  usuars  = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ;
                       " WHERE empdnps = " + EscaparSQL(THIS.this_cEmpDNps)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            *-- Excluir itens de SigCdNei primeiro (integridade referencial)
            loc_cSQL    = "DELETE FROM SigCdNei WHERE empdnps = " + ;
                          EscaparSQL(THIS.this_cEmpDNps)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir itens (SigCdNei):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir registro principal de SigCdNec
                loc_cSQL    = "DELETE FROM SigCdNec WHERE empdnps = " + ;
                              EscaparSQL(THIS.this_cEmpDNps)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

