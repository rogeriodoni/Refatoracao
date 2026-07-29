# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TPCODS, NUMS, LNDIAS, UMOVS, DEVOLVIDOS, CONTAT, GRUPOT, ICLIS, GRCLIS, NUMLOTES, CODIGOS, VOPERS, BANCOS, AGENCIAS, NCONTAS, NCHEQUES, 1, GRUPOS, PCDADO, _CONTAORIG, LCMOEL, _CONTADEST, OPERAS, DATAS, DTMOVS, TIPOS, EMPS, NUMOS, NOPERS, USUARIOS, CMOES, ORIGEMS, VALORS, LNRESPOSTA, VALTOTS, ALTCOTS, _RECNO, AUTOS, ORDENS, LCCONTAO, LNQTD, LCCONTAD, CPFS, RCLIS, BXPENDS, DTALTS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TABELAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TPCODS, NUMS, LNDIAS, UMOVS, DEVOLVIDOS, CONTAT, GRUPOT, ICLIS, GRCLIS, NUMLOTES, CODIGOS, VOPERS, BANCOS, AGENCIAS, NCONTAS, NCHEQUES, 1, GRUPOS, PCDADO, _CONTAORIG, LCMOEL, _CONTADEST, OPERAS, DATAS, DTMOVS, TIPOS, EMPS, NUMOS, NOPERS, USUARIOS, CMOES, ORIGEMS, VALORS, LNRESPOSTA, VALTOTS, ALTCOTS, _RECNO, AUTOS, ORDENS, LCCONTAO, LNQTD, LCCONTAD, CPFS, RCLIS, BXPENDS, DTALTS

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
  ControlSource = "crSigCqLcm.codigos"
  ControlSource = "crSigCqLcm.numlotes"
  ControlSource = "crSigCqLcm.moeds"
  ControlSource = "crSigCqLcm.valconvs"
  ControlSource = "crSigCqLcm.cotas"
  ControlSource = "crSigCqLcm.valtots"
  ControlSource = "crSigCqLcm.DtMovs"
  ControlSource = "crSigCqLcm.operas"
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  ControlSource = "TEMPCHQ.BANCOS"
  ControlSource = "TEMPCHQ.AGENCIAS"
  ControlSource = "TEMPCHQ.NCONTAS"
  ControlSource = "TEMPCHQ.NCHEQUES"
  ControlSource = "TEMPCHQ.VALORS"
  ControlSource = "tempchq.obss"
  ControlSource = "TEMPCHQ.cpft"
  ControlSource = "TEMPCHQ.nomet"
  ControlSource = "crSigCqLcm.Datas"
  ControlSource = "crSigCqLcm.GrupoDs"
  ControlSource = ""
  ControlSource = "crSigCqLcm.ContaDs"
  ControlSource = ""
  ControlSource = "crSigCqLcm.GrupoOs"
  ControlSource = "crSigCqLcm.ContaOs"
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigCqLcm.taxdias"
  ControlSource = "crSigCqLcm.taxiofs"
  ControlSource = "crSigCqLcm.taxcarts"
  ControlSource = ""
  ControlSource = "crSigCqLcm.grujuros"
  ControlSource = "crSigCqLcm.conjuros"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigCqLcm.valtjuros"
  ControlSource = ""
		Insert Into crSigCdCli (Iclis, Cpfs, Usuars, TpCads, Grupos, DataIncs, TpClis, NClis, DtAlts, rclis, razaos) ;
		m.Retorno = ThisForm.poDataMgr.UpDate('crSigCdCli')
select tempchq
select crSigCqLcm
Select crSigCdPam
select tempchq
		Select TempChq
	Select TempChq
		lcQuery = [Select nums,ValJuros ] + ;
		    [From SigCcChm] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csSigCcChm') < 1)
		Select csSigCcChm
		Select TempChq
Select TempChq
	LCQUERY = [SELECT a.valors, a.grupot, a.contat from sigcqlcm b, Sigccchm a where a.numlotes = b.numlotes ] +;
			  [AND b.codigos IN (SELECT OPERACAOS FROM SIGCDOPT WHERE DEVOLVIDOS = 'S')] +;	
	IF (THISFORM.PODATAMGR.SQLEXECUTE(LCQUERY, 'CRCHET') < 1)
	lcQuery = [select a.valors, a.grclis, a.iclis from sigcqlcm b, Sigccchm a where a.numlotes = b.numlotes ] +;
			  [and b.codigos in (select operacaos from SigCdOpt where devolvidos = 'S') ] +;	
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crCheC') < 1)
		SELECT SUM(valors) as valors from crCheT into cursor crChe
		SELECT SUM(valors) as valors from crCheC into cursor crChe
	SELECT tempchq
	Select crSigCcChm
lcQuery = [Select * ] + ;
		    [From SigCcChm]+;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crDeleteSigCcChm') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (crDeleteSigCcChm)')
Select crDeleteSigCcChm
	lcVOpers = crDeleteSigCcChm.emps + alltrim( str( crDeleteSigCcChm.numos, 9 ))
	lcQuery = [Select * ] + ;
		    [From SigMvCcr] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crMccr') < 1)
	Select crMccr
	lcDelMccr = [Delete From SigMvCcr Where Vopers = ']+lcVOpers+[']
	lnErro    = ThisForm.podatamgr.SqlExecute(lcDelMccr,'')
	_Nums =   crDeleteSigCcChm.Nums
	_chaves = crDeleteSigCcChm.CidChaves
	lcWher = [Select a.*, b.codigos From SigCcChm a, Sigcqlcm b ]+;
			 [ Where a.Bancos=']+crDeleteSigCcChm.bancos+[']+;
			 [ and a.agencias=']+crDeleteSigCcChm.agencias+[']+;
			 [ and  a.ncontas=']+crDeleteSigCcChm.ncontas+[']+;
			 [ and a.ncheques=']+crDeleteSigCcChm.ncheques+['] +;
	lnErro = ThisForm.PoDatamgr.SqlExecute(lcWher,'CrChm')
	SELECT crChm
		lcUpDate = [Update SigChe Set Umovs = ']+lcUmov+[' , Grupos=']+lcGrupos+[' , Contas=']+lcContas+[', ]+;
		lnErro   = ThisForm.Podatamgr.SqlExecute(lcUpDate,'')
		lcDelChe = [delete from SigChe where nums=']+crDeleteSigCcChm.nums+[']
		If (ThisForm.poDataMgr.SqlExecute(lcDelChe, '') < 1)
	lcDelLC = [delete from SigChLcq where numlotes=]+Alltrim(Str(codigo,8))
	If (ThisForm.poDataMgr.SqlExecute(lcDelLC, '') < 1)
	lcDelLI = [delete from SigCqChm where numlotes=]+Alltrim(Str(codigo,8))
	If (ThisForm.poDataMgr.SqlExecute(lcDelLI, '') < 1)
	Select crDeleteSigCcChm
lcQuery = [Delete From SigCcChm ]+;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crExSigCcChm') < 1)
Select crSigMvCcr
Insert Into crSigMvCcr ( VOpers, NOpers, NLancs, VLancs, Opers, Grupos,;
select crSigMvCcr
lcQryLcChm = [Select * From SigCqLcm where 1=0 ]
lcQueryMccr= [Select * From SigMvCcr where 1=0 ]
lcQuerySigCcChm = [Select * From SigCcChm where 1=0 ]
lcQueryLC  = [Select * From SigChLcq where 1=0 ]
lcQueryLI  = [Select * From SigCqchm where 1=0 ]
lcQueryChe = [Select * From SigChe where 1=0 ]
lcQueryCli = [Select * From SigCdCli where 1=0 ]
lcQueryOper= [Select * From SigCdOpt Where Not Inativas = 1]
lcQueryCot = [Select * From SigCdCot ]
lcQueRyMoe = [Select * From SigCdMoe ] 
Select CrSigCdCot
Select CrSigCdMoe
lcQuery = [Select tplechqs,jurocarts,moedacheqs,grucarts,concarts,gruporecs,grupopags,contarecs,contapags, grupojuros, contajuros From SigCdPam]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPam') < 1)
Select crSigCdPam
Select crSigCdOpt
Select crSigCqLcm
Select crSigCdOpt
SELECT crSigCqLcm
lcQuery = [Select bancos,agencias,ncontas,ncheques,GruCarts,ConCarts,Umovs,valors,ValPags, ] + ;
	      [ From SigChe]+;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigChe') < 1)
SELECT tempChq
lcQuery = [Select iclis,cpfs,rclis, grupos From SigCdCli Where Grupos = ']+crSigChe.grupoT+[' and iclis = ']+crSigChe.contaT+[']
lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrTmpCli')
Select TempChq
Select crInsSigCcChm
Select CrSigMvCcr
Select CrSigChe
Select crSigChLcq
Select crSigCqChm
	select tempchq
Select crSigChLcq
select tempchq
	lcQuery = [Select * From SigChe ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpChe') < 1)
	SELECT crTmpChe
	SELECT crSigChe
	Select crSigCqChm
	select crInsSigCcChm
	select tempchq
	Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
	Select crSigMvCcr
	Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
	Select crSigMvCcr
		Select crSigMvCcr
		Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
		Select crSigMvCcr
		Select crSigMvCcr
		Insert Into crSigMvCcr ( NOpers, VOpers, Emps, Datas, usualts, datalts, Vencs, hists,;
		Select crSigMvCcr
llErro01 = ThisForm.Podatamgr.Update('crSigCqLcm')
llErro01 = ThisForm.Podatamgr.Update('CrSigMvCcr')
llErro01 = ThisForm.Podatamgr.Update('crInsSigCcChm')
llErro01 = ThisForm.Podatamgr.Update('crSigChe')
llErro01 = ThisForm.Podatamgr.Update('crSigChLcq')
llErro01 = ThisForm.Podatamgr.Update('crSigCqChm')
select crSigCqLcm
select tempchq
Select crSigCqLcm
	lcQryLcChm  = [Select * From SigCqLcm where dtMovs between ?llDatai And ?llDataf ]
	lcQueryMccr = [Select * From SigMvCcr where 1=0 ]
	lcQuerySigCcChm = [Select * From SigCcChm where 1=0 ]
	lcQueryLC	= [Select * From SigChLcq where 1=0 ]
	lcQueryLI	= [Select * From SigCqchm where 1=0 ]
	lcQueryChe	= [Select * From SigChe where 1=0 ]
	lcQueryCli	= [Select * From SigCdCli where 1=0 ]
	lcQueryOper  = [Select * From SigCdOpt Where Not Inativas = 1]
	lcQueryCot   = [Select * From SigCdCot ]
	lcQueRyMoe   = [Select * From SigCdMoe ] 
			Select CrSigCdCot
			Select CrSigCdMoe
			lcQuery = [Select tplechqs,jurocarts,moedacheqs,grucarts,concarts,gruporecs,grupopags,contarecs,contapags, grupojuros, contajuros From SigCdPam]
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPam') < 1)
			Select crSigCdPam
			Select * From crSigSyCom Where Tipos = 'Leitora Cheques' Into Cursor CrCfCom
				Select crCfCom
				lcWher = [Select * From SigCcChm Where Emps = ']+lcEmpo+[' And Numos = ]+Str(lcVope)
				ThisForm.podatamgr.SqlExecute(lcWher,'CrSigCcChm')
				Select CrSigCcChm
				lcWher = [Select * From SigCqLcm Where NumLotes = ]+Str(lnLote)
				ThisForm.poDatamgr.SqlExecute(lcWher,'crSigCqLcm')
				Select crSigCqLcm
	lcQuery = [select * from SIGCHE where nums = ']+pNums+[' and umovs = ']+ALLTRIM(pUlt)+[']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crCheque') < 1)
Select crSigCqLcm
	=Seek( NumLote, "crSigCqLcm", "NumLotes" )
Select crSigCdOpt
Select TempChq
lcQuery = [Select * From SigCcChm where NumLotes = ]+Str(lote)
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCcChm') < 1)
Select crSigCcChm
	select crSigCqLcm
	select crSigCcChm
	lcQuery = [Select nums,umovs From SigChe ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigChe') < 1)
		Select crSigCcChm
		lcWherMccr = [Select * From SigMvCcr Where VOpers = ?lcVoper ]
		lnErro1 = ThisForm.Podatamgr.SqlExecute(lcWherMccr,'CrSigMvCcr')
		Select CrSigMvCcr
			lcWherPrit = [Select * From SigCdPit Where Emps = ?lcEmp And Nopers = ?lnOpe]
			lnErrEx = ThisForm.Podatamgr.SqlExecute(lcWherPrit,'CrSigCdPit')
			SELECT crSigmvCCr
		Select crSigCcChm
	  Select crSigChe
lcQuery = [Select * ] + ;
		    [ From SigCdUsu]+;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdUsu') < 1)
	select crSigCcChm
		lcQuery = [Select * From SigChe ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigChe') < 1)
			insert into tempchq from memvar
	lcQuery = [Update SigCcChm Set valtots = valtots Where numlotes=]+Alltrim(Str(lote,8))
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCcChm') < 1)
	Select crSigCdOpt
	select tempchq
	select crSigCqLcm
		Select TempChq
		Insert Into TempChq (Emps)Values (_Empr)
	Select crSigCqLcm
Select TempChq
select crSigCqLcm
	lcQuery = [Select cmoes ] + ;
	    [From SigCdMoe] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'SigCdMoe') < 1)
	Select SigCdMoe
	select tempchq
	Select TempChq
			Delete
		Select TempChq
select tempchq
		delete
select crSigCqLcm
	Select crSigCqLcm
		  Delete
	select tempchq
	Select TempChq
Select crSigCqLcm
select crSigCqLcm
	lcSql = [Update SigCqLcm Set DataTrans = Null Where NumLotes = ]+Str(crSigCqLcm.NumLotes,6)
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'') < 1
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão - Update SigCqLcm ')
		lcSql = [Update SigCcChm Set DataTrans = Null Where NumLotes = ]+Str(crSigCqLcm.NumLotes,6)
		If ThisForm.Podatamgr.Sqlexecute(lcSql,'') < 1
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão - Update SigCcChm ')
Select crSigCdOpt
If !Seek( This.Value )
Select crSigCdMoe
If !Seek( This.Value )
		Select crSigCdCot
		select tempchq
		If seek( cheque )
				Select TempChq
			Select TempChq
select tempchq
	Select TempChq
	If Seek( lcCheque, 'TempChq', 'Cheque' ) And !IsEmpty( lcCheque ) and _Recno <> Recno('TempChq')
			Select TempChq
	Select TempChq
	lcQuery = [Select a.tipos, a.numos from sigcqchm a ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crCqlcm') < 1)
	SELECT crCqlcm
	lcQuery = [Select numos from sigcqchm where numlotes = ]+ALLTRIM(STR(crSigCqLcm.numlotes))+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crCqChm') < 1)
	lcQuery = [Select bancos,agencias,ncontas,ncheques,GruCarts,ConCarts,Umovs,valors,ValPags, ] + ;
		    [ From SigChe]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigChe') < 1)
	Select TempChq
	SELECT crSigChe
		Select TempChq
		lcQuery = [Select iclis,cpfs,rclis, grupos From SigCdCli Where Grupos = ']+crSigChe.grupoT+[' and iclis = ']+crSigChe.contaT+[']
		lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrTmpCli')
Select TempChq
select tempchq
		select tempchq
		If seek( Spac( 23 ), 'tempchq', 'cheque' )
select tempchq
SELECT tempchq
	lcQuery = [Select iclis,cpfs,rclis,grupos,nclis From SigCdCli Where Cpfs = ?Cgc1 And Grupos = ']+lcCadGrupo+[']
	lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrTmpCli')
	Select CrTmpCli
SELECT tempchq
SELECT tempchq
	lcQuery = [Select iclis,cpfs,rclis,grupos,nclis From SigCdCli Where Cpfs = ?Cgc1 And Grupos = ']+lcCadGrupo+[']
	lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrTmpCli')
	Select CrTmpCli
		lcQuery = [Select iclis,cpfs,rclis, grupos From SigCdCli Where Cpfs = ?Cgc1 And Grupos = ']+lcCadGrupo+[']
		lnErro = ThisForm.podatamgr.SqlExecute(lcQuery,'CrTmpCli')
		SELECT tempchq
SELECT tempchq
	select tempchq
lcQuery = [Select * From SigCcChm where NumLotes = ]+Str(crSigcqlcm.numlotes)
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crRel') < 1)
SELECT a.*, b.valjuros as valjur from tempchq a, crRel b where ;
SELECT crRel1
Select TempChq
Select TempChq
	Delete
Select TempChq
Select TempChq
	Select TempChq
	SELECT tempchq

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formche.prg) - TRECHOS RELEVANTES PARA PASS SQL (3327 linhas total):

*-- Linhas 442 a 460:
442:             .HighlightBackColor = RGB(255, 255, 255)
443:             .HighlightForeColor = RGB(15, 41, 104)
444:             .HighlightStyle     = 2
445:             .DeleteMark         = .F.
446:             .RecordMark         = .F.
447:             .RowHeight          = 16
448:             .ScrollBars         = 2
449:             .ReadOnly           = .T.
450:             .Visible            = .T.
451:             .Column1.Width      = 55
452:             .Column2.Width      = 82
453:             .Column3.Width      = 130
454:             .Column3.Alignment  = 2
455:             .Column4.Width      = 105
456:             .Column4.Alignment  = 1
457:             .Column5.Width      = 100
458:             .Column5.Alignment  = 1
459:             .Column6.Width      = 100
460:             .Column1.Header1.Caption = "Lote"

*-- Linhas 995 a 1032:
995:         ENDWITH
996: 
997:         *-- GradeCheque: grid de cheques (top=130+29=159), 9 colunas
998:         *-- ColumnCount FORA do WITH; ControlSource/RecordSource definidos em CarregarPaginaDados
999:         loc_oPg2.AddObject("grd_4c_GradeCheque", "Grid")
1000:         loc_oGrid             = loc_oPg2.grd_4c_GradeCheque
1001:         loc_oGrid.Top         = 159
1002:         loc_oGrid.Left        = 9
1003:         loc_oGrid.Width       = 985
1004:         loc_oGrid.Height      = 244
1005:         loc_oGrid.ColumnCount = 9
1006: 
1007:         WITH loc_oGrid
1008:             .FontName           = "Verdana"
1009:             .FontSize           = 8
1010:             .ForeColor          = RGB(90, 90, 90)
1011:             .BackColor          = RGB(255, 255, 255)
1012:             .GridLineColor      = RGB(238, 238, 238)
1013:             .GridLines          = 3
1014:             .HighlightBackColor = RGB(255, 255, 255)
1015:             .HighlightForeColor = RGB(15, 41, 104)
1016:             .HighlightStyle     = 2
1017:             .DeleteMark         = .F.
1018:             .RecordMark         = .F.
1019:             .RowHeight          = 16
1020:             .ScrollBars         = 3
1021:             .Visible            = .T.
1022:             .Column1.Width      = 40
1023:             .Column2.Width      = 50
1024:             .Column3.Width      = 100
1025:             .Column4.Width      = 70
1026:             .Column5.Width      = 80
1027:             .Column6.Width      = 80
1028:             .Column7.Width      = 150
1029:             .Column8.Width      = 100
1030:             .Column9.Width      = 150
1031:             .Column1.Header1.Caption = "Bco"
1032:             .Column2.Header1.Caption = "Agenc"

*-- Linhas 1554 a 1594:
1554:             loc_cFiltro = ""
1555: 
1556:             IF !EMPTY(THIS.this_dDataIni)
1557:                 loc_cDataIni = FormatarDataSQL(THIS.this_dDataIni)
1558:                 loc_cFiltro  = loc_cFiltro + " AND a.datas >= " + loc_cDataIni
1559:             ENDIF
1560: 
1561:             IF !EMPTY(THIS.this_dDataFim)
1562:                 loc_cDataFim = FormatarDataSQL(THIS.this_dDataFim)
1563:                 loc_cFiltro  = loc_cFiltro + " AND a.datas <= " + loc_cDataFim
1564:             ENDIF
1565: 
1566:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1567:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1568: 
1569:                 *-- RecordSource FORA do WITH (Problema 36)
1570:                 loc_oGrid.ColumnCount = 3
1571:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1572: 
1573:                 WITH loc_oGrid
1574:                     .Column1.ControlSource = "cursor_4c_Dados.numlotes"
1575:                     .Column2.ControlSource = "cursor_4c_Dados.datas"
1576:                     .Column3.ControlSource = "cursor_4c_Dados.operas"
1577:                     .Column4.ControlSource = "cursor_4c_Dados.valtots"
1578:                     .Column5.ControlSource = "cursor_4c_Dados.valtjuros"
1579:                     .Column6.ControlSource = "cursor_4c_Dados.datatrans"
1580:                     *-- Re-setar headers apos RecordSource (VFP9 reseta captions)
1581:                     .Column1.Header1.Caption = "Lote"
1582:                     .Column2.Header1.Caption = "Data"
1583:                     .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1584:                     .Column4.Header1.Caption = "Total"
1585:                     .Column5.Header1.Caption = "Juros"
1586:                     .Column6.Header1.Caption = "Dt. Transporte"
1587:                 ENDWITH
1588: 
1589:                 THIS.FormatarGridLista(loc_oGrid)
1590:                 loc_lResultado = .T.
1591:             ENDIF
1592: 
1593:         CATCH TO loc_oErro
1594:             MsgErro(loc_oErro.Message, "Formche.CarregarLista")

*-- Linhas 1794 a 1819:
1794:             ENDIF
1795: 
1796:             IF MsgConfirma("Limpar data de transporte do lote " + LTRIM(STR(loc_nLote)) + "?")
1797:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1798:                     "UPDATE SigCqLcm SET datatrans = NULL WHERE NumLotes = " + ;
1799:                     FormatarNumeroSQL(loc_nLote))
1800: 
1801:                 IF loc_nRet > 0
1802:                     SQLEXEC(gnConnHandle, ;
1803:                         "UPDATE SigCcChm SET datatrans = NULL WHERE numlotes = " + ;
1804:                         FormatarNumeroSQL(loc_nLote))
1805:                 ENDIF
1806: 
1807:                 THIS.CarregarLista()
1808:                 loc_lResultado = .T.
1809:             ENDIF
1810:         CATCH TO loc_oErro
1811:             MsgErro(loc_oErro.Message, "Formche.BtnLimpaDTClick")
1812:         ENDTRY
1813: 
1814:         RETURN loc_lResultado
1815:     ENDPROC
1816: 
1817:     *--------------------------------------------------------------------------
1818:     * DtInicialLostFocus - Valida data inicial e recarrega lista
1819:     *--------------------------------------------------------------------------

*-- Linhas 1949 a 1967:
1949:                 .txt_4c_TaxaIof.Value  = 0
1950:             ENDWITH
1951:             IF USED("TempChq")
1952:                 SELECT TempChq
1953:                 SET ORDER TO
1954:                 ZAP
1955:             ENDIF
1956:         CATCH TO loc_oErro
1957:             MsgErro(loc_oErro.Message, "Formche.LimparCampos")
1958:         ENDTRY
1959:     ENDPROC
1960: 
1961:     *--------------------------------------------------------------------------
1962:     * BOParaForm - Copia dados do BO para controles do form (expandido na Fase 5)
1963:     *--------------------------------------------------------------------------
1964:     PROCEDURE BOParaForm()
1965:         LOCAL loc_oPg2, loc_oBO, loc_nRet
1966:         TRY
1967:             IF VARTYPE(THIS.this_oBusinessObject) = "O"

*-- Linhas 1998 a 2114:
1998:                     IF USED("cursor_4c_GrupoTDesc")
1999:                         USE IN cursor_4c_GrupoTDesc
2000:                     ENDIF
2001:                     loc_nRet = SQLEXEC(gnConnHandle, ;
2002:                         "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
2003:                         EscaparSQL(ALLTRIM(loc_oBO.this_cGrupoT)), ;
2004:                         "cursor_4c_GrupoTDesc")
2005:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_GrupoTDesc") > 0
2006:                         SELECT cursor_4c_GrupoTDesc
2007:                         loc_oPg2.txt_4c_DGrupoT.Value = ALLTRIM(cursor_4c_GrupoTDesc.descrs)
2008:                     ENDIF
2009:                     IF USED("cursor_4c_GrupoTDesc")
2010:                         USE IN cursor_4c_GrupoTDesc
2011:                     ENDIF
2012:                 ENDIF
2013:                 *-- Descricoes Grupo/Conta Origem
2014:                 IF !EMPTY(ALLTRIM(loc_oBO.this_cGrupoOs))
2015:                     IF USED("cursor_4c_DescAux")
2016:                         USE IN cursor_4c_DescAux
2017:                     ENDIF
2018:                     loc_nRet = SQLEXEC(gnConnHandle, ;
2019:                         "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
2020:                         EscaparSQL(ALLTRIM(loc_oBO.this_cGrupoOs)), "cursor_4c_DescAux")
2021:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_DescAux") > 0
2022:                         SELECT cursor_4c_DescAux
2023:                         loc_oPg2.txt_4c_DGrupoOs.Value = ALLTRIM(cursor_4c_DescAux.descrs)
2024:                     ENDIF
2025:                     IF USED("cursor_4c_DescAux")
2026:                         USE IN cursor_4c_DescAux
2027:                     ENDIF
2028:                 ENDIF
2029:                 IF !EMPTY(ALLTRIM(loc_oBO.this_cContaOs))
2030:                     IF USED("cursor_4c_DescAux")
2031:                         USE IN cursor_4c_DescAux
2032:                     ENDIF
2033:                     loc_nRet = SQLEXEC(gnConnHandle, ;
2034:                         "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE iclis = " + ;
2035:                         EscaparSQL(ALLTRIM(loc_oBO.this_cContaOs)), "cursor_4c_DescAux")
2036:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_DescAux") > 0
2037:                         SELECT cursor_4c_DescAux
2038:                         loc_oPg2.txt_4c_DCONTAOs.Value = ALLTRIM(cursor_4c_DescAux.Rclis)
2039:                     ENDIF
2040:                     IF USED("cursor_4c_DescAux")
2041:                         USE IN cursor_4c_DescAux
2042:                     ENDIF
2043:                 ENDIF
2044:                 *-- Descricoes Grupo/Conta Destino
2045:                 IF !EMPTY(ALLTRIM(loc_oBO.this_cGrupoDs))
2046:                     IF USED("cursor_4c_DescAux")
2047:                         USE IN cursor_4c_DescAux
2048:                     ENDIF
2049:                     loc_nRet = SQLEXEC(gnConnHandle, ;
2050:                         "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
2051:                         EscaparSQL(ALLTRIM(loc_oBO.this_cGrupoDs)), "cursor_4c_DescAux")
2052:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_DescAux") > 0
2053:                         SELECT cursor_4c_DescAux
2054:                         loc_oPg2.txt_4c_DGrupoDs.Value = ALLTRIM(cursor_4c_DescAux.descrs)
2055:                     ENDIF
2056:                     IF USED("cursor_4c_DescAux")
2057:                         USE IN cursor_4c_DescAux
2058:                     ENDIF
2059:                 ENDIF
2060:                 IF !EMPTY(ALLTRIM(loc_oBO.this_cContaDs))
2061:                     IF USED("cursor_4c_DescAux")
2062:                         USE IN cursor_4c_DescAux
2063:                     ENDIF
2064:                     loc_nRet = SQLEXEC(gnConnHandle, ;
2065:                         "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE iclis = " + ;
2066:                         EscaparSQL(ALLTRIM(loc_oBO.this_cContaDs)), "cursor_4c_DescAux")
2067:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_DescAux") > 0
2068:                         SELECT cursor_4c_DescAux
2069:                         loc_oPg2.txt_4c_DCONTADs.Value = ALLTRIM(cursor_4c_DescAux.Rclis)
2070:                     ENDIF
2071:                     IF USED("cursor_4c_DescAux")
2072:                         USE IN cursor_4c_DescAux
2073:                     ENDIF
2074:                 ENDIF
2075:                 *-- Descricoes Grupo/Conta Juros
2076:                 IF !EMPTY(ALLTRIM(loc_oBO.this_cGruJuro))
2077:                     IF USED("cursor_4c_DescAux")
2078:                         USE IN cursor_4c_DescAux
2079:                     ENDIF
2080:                     loc_nRet = SQLEXEC(gnConnHandle, ;
2081:                         "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
2082:                         EscaparSQL(ALLTRIM(loc_oBO.this_cGruJuro)), "cursor_4c_DescAux")
2083:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_DescAux") > 0
2084:                         SELECT cursor_4c_DescAux
2085:                         loc_oPg2.txt_4c_DGruJuro.Value = ALLTRIM(cursor_4c_DescAux.descrs)
2086:                     ENDIF
2087:                     IF USED("cursor_4c_DescAux")
2088:                         USE IN cursor_4c_DescAux
2089:                     ENDIF
2090:                 ENDIF
2091:                 IF !EMPTY(ALLTRIM(loc_oBO.this_cConJuro))
2092:                     IF USED("cursor_4c_DescAux")
2093:                         USE IN cursor_4c_DescAux
2094:                     ENDIF
2095:                     loc_nRet = SQLEXEC(gnConnHandle, ;
2096:                         "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE iclis = " + ;
2097:                         EscaparSQL(ALLTRIM(loc_oBO.this_cConJuro)), "cursor_4c_DescAux")
2098:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_DescAux") > 0
2099:                         SELECT cursor_4c_DescAux
2100:                         loc_oPg2.txt_4c_DJuro.Value = ALLTRIM(cursor_4c_DescAux.Rclis)
2101:                     ENDIF
2102:                     IF USED("cursor_4c_DescAux")
2103:                         USE IN cursor_4c_DescAux
2104:                     ENDIF
2105:                 ENDIF
2106:             ENDIF
2107:         CATCH TO loc_oErro
2108:             MsgErro(loc_oErro.Message, "Formche.BOParaForm")
2109:         ENDTRY
2110:     ENDPROC
2111: 
2112:     *--------------------------------------------------------------------------
2113:     * FormParaBO - Copia dados dos controles para o BO (implementado na Fase 5)
2114:     *--------------------------------------------------------------------------

*-- Linhas 2139 a 2157:
2139:                 loc_nTotal = 0
2140:                 loc_nJuros = 0
2141:                 IF USED("TempChq")
2142:                     SELECT TempChq
2143:                     SCAN
2144:                         IF !EMPTY(ALLTRIM(TempChq.Bancos)) OR !EMPTY(ALLTRIM(TempChq.NCheques))
2145:                             loc_nTotal = loc_nTotal + TempChq.Valors
2146:                             loc_nJuros = loc_nJuros + TempChq.Valjuros
2147:                         ENDIF
2148:                     ENDSCAN
2149:                 ENDIF
2150:                 loc_oBO.this_nValor  = loc_nTotal
2151:                 loc_oBO.this_nTJuros = loc_nJuros
2152:                 loc_oBO.this_nTLiq   = loc_nTotal - loc_nJuros
2153:             ENDIF
2154:         CATCH TO loc_oErro
2155:             MsgErro(loc_oErro.Message, "Formche.FormParaBO")
2156:         ENDTRY
2157:     ENDPROC

*-- Linhas 2279 a 2359:
2279:     *--------------------------------------------------------------------------
2280:     * CarregarPaginaDados - Cria/atualiza TempChq e vincula grd_4c_GradeCheque
2281:     * INCLUIR: grade vazia (1 linha em branco p/ empresa)
2282:     * VISUALIZAR/ALTERAR: carrega SigCcChm JOIN SigChe JOIN SigCdCli
2283:     *--------------------------------------------------------------------------
2284:     PROCEDURE CarregarPaginaDados()
2285:         LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_oGrid, loc_oPg2
2286:         loc_lResultado = .F.
2287: 
2288:         TRY
2289:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2290: 
2291:             IF USED("TempChq")
2292:                 SELECT TempChq
2293:                 SET ORDER TO
2294:                 ZAP
2295:             ELSE
2296:                 CREATE CURSOR TempChq ( ;
2297:                     Bancos    C(3),   Agencias  C(4),  NContas   C(10), NCheques C(6),  ;
2298:                     Vencs     D(8),   Valors    N(12,2), cpft     C(20), Nomet    C(40), ;
2299:                     Obss      C(40),  emps      C(3),  Iclis     C(10), Grclis   C(10), ;
2300:                     contas    C(10),  grupos    C(10), valpags   N(12,2), grucarts C(10), ;
2301:                     concarts  C(10),  valjuros  N(12,2), nums    C(8),  Protocolos C(8), ;
2302:                     grupoT    C(10),  contaT    C(10), leituras  C(34), devolvido C(1),  ;
2303:                     moeds     C(3),   cotas     N(11,4) )
2304:             ENDIF
2305: 
2306:             IF THIS.this_nNumLoteAtual > 0
2307:                 *-- Carregar cheques via JOIN SigCcChm x SigChe x SigCdCli
2308:                 loc_cSQL = ;
2309:                     "SELECT c.bancos, c.agencias, c.ncontas, c.ncheques, c.obss, c.emps," + ;
2310:                     " ISNULL(h.vencs,  NULL)    AS vencs,"    + ;
2311:                     " ISNULL(h.valors,  0)      AS valors,"   + ;
2312:                     " ISNULL(h.valpags, 0)      AS valpags,"  + ;
2313:                     " ISNULL(h.iclis,   '')     AS iclis,"    + ;
2314:                     " ISNULL(h.grclis,  '')     AS grclis,"   + ;
2315:                     " ISNULL(h.contas,  '')     AS contas,"   + ;
2316:                     " ISNULL(h.grupos,  '')     AS grupos,"   + ;
2317:                     " ISNULL(h.nums,    '')     AS nums,"     + ;
2318:                     " ISNULL(h.grupot,  '')     AS grupot,"   + ;
2319:                     " ISNULL(h.contat,  '')     AS contat,"   + ;
2320:                     " ISNULL(h.moeds,   '')     AS moeds,"    + ;
2321:                     " ISNULL(h.cotas,    0)     AS cotas,"    + ;
2322:                     " ISNULL(h.grucarts, '')    AS grucarts," + ;
2323:                     " ISNULL(h.concarts, '')    AS concarts," + ;
2324:                     " ISNULL(h.protocolos, '')  AS protocolos," + ;
2325:                     " ISNULL(h.valjuros,  0)    AS valjuros," + ;
2326:                     " ISNULL(cli.cpfs,   '')    AS cpft,"     + ;
2327:                     " ISNULL(cli.rclis,  '')    AS nomet"     + ;
2328:                     " FROM SigCcChm c"                        + ;
2329:                     " LEFT JOIN SigChe h ON h.bancos = c.bancos AND h.agencias = c.agencias" + ;
2330:                     " AND h.ncontas = c.ncontas AND h.ncheques = c.ncheques"                 + ;
2331:                     " LEFT JOIN SigCdCli cli ON cli.iclis = h.iclis"                         + ;
2332:                     " WHERE c.numlotes = " + FormatarNumeroSQL(THIS.this_nNumLoteAtual)      + ;
2333:                     " ORDER BY c.bancos, c.agencias, c.ncontas, c.ncheques"
2334: 
2335:                 IF USED("cursor_4c_ChequesLoad")
2336:                     USE IN cursor_4c_ChequesLoad
2337:                 ENDIF
2338: 
2339:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChequesLoad")
2340: 
2341:                 IF loc_nRet > 0 AND USED("cursor_4c_ChequesLoad") AND RECCOUNT("cursor_4c_ChequesLoad") > 0
2342:                     SELECT cursor_4c_ChequesLoad
2343:                     SCAN
2344:                         INSERT INTO TempChq ;
2345:                             (Bancos, Agencias, NContas, NCheques, Vencs, Valors, ;
2346:                              cpft, Nomet, Obss, emps, Iclis, Grclis, contas, grupos, ;
2347:                              valpags, grucarts, concarts, nums, Protocolos, grupoT, ;
2348:                              contaT, moeds, cotas, valjuros) ;
2349:                             VALUES ;
2350:                             (cursor_4c_ChequesLoad.bancos, cursor_4c_ChequesLoad.agencias, ;
2351:                              cursor_4c_ChequesLoad.ncontas, cursor_4c_ChequesLoad.ncheques, ;
2352:                              cursor_4c_ChequesLoad.vencs, cursor_4c_ChequesLoad.valors, ;
2353:                              cursor_4c_ChequesLoad.cpft, cursor_4c_ChequesLoad.nomet, ;
2354:                              cursor_4c_ChequesLoad.obss, cursor_4c_ChequesLoad.emps, ;
2355:                              cursor_4c_ChequesLoad.iclis, cursor_4c_ChequesLoad.grclis, ;
2356:                              cursor_4c_ChequesLoad.contas, cursor_4c_ChequesLoad.grupos, ;
2357:                              cursor_4c_ChequesLoad.valpags, cursor_4c_ChequesLoad.grucarts, ;
2358:                              cursor_4c_ChequesLoad.concarts, cursor_4c_ChequesLoad.nums, ;
2359:                              cursor_4c_ChequesLoad.protocolos, cursor_4c_ChequesLoad.grupot, ;

*-- Linhas 2367 a 2432:
2367:                 ENDIF
2368:             ELSE
2369:                 *-- INCLUIR: linha em branco para empresa
2370:                 INSERT INTO TempChq (emps) VALUES (go_4c_Sistema.cCodEmpresa)
2371:             ENDIF
2372: 
2373:             *-- Vincular grid (RecordSource FORA do WITH - Problema 36)
2374:             loc_oGrid = loc_oPg2.grd_4c_GradeCheque
2375:             loc_oGrid.RecordSource = "TempChq"
2376: 
2377:             WITH loc_oGrid
2378:                 .Column1.ControlSource   = "TempChq.Bancos"
2379:                 .Column2.ControlSource   = "TempChq.Agencias"
2380:                 .Column3.ControlSource   = "TempChq.NContas"
2381:                 .Column4.ControlSource   = "TempChq.NCheques"
2382:                 .Column5.ControlSource   = "TempChq.Vencs"
2383:                 .Column6.ControlSource   = "TempChq.Valors"
2384:                 .Column7.ControlSource   = "TempChq.Obss"
2385:                 .Column8.ControlSource   = "TempChq.cpft"
2386:                 .Column9.ControlSource   = "TempChq.Nomet"
2387:                 .Column1.Header1.Caption = "Bco"
2388:                 .Column2.Header1.Caption = "Agenc"
2389:                 .Column3.Header1.Caption = "N" + CHR(250) + " Conta"
2390:                 .Column4.Header1.Caption = "N" + CHR(250) + " Cheque"
2391:                 .Column5.Header1.Caption = "Vencimento"
2392:                 .Column6.Header1.Caption = "Valor"
2393:                 .Column7.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
2394:                 .Column8.Header1.Caption = "CPF/CNPJ"
2395:                 .Column9.Header1.Caption = "Nome Terceiro"
2396:             ENDWITH
2397: 
2398:             SELECT TempChq
2399:             GO TOP
2400:             loc_oGrid.Refresh()
2401:             loc_lResultado = .T.
2402:         CATCH TO loc_oErro
2403:             MsgErro(loc_oErro.Message, "Formche.CarregarPaginaDados")
2404:         ENDTRY
2405: 
2406:         RETURN loc_lResultado
2407:     ENDPROC
2408: 
2409:     *--------------------------------------------------------------------------
2410:     * BtnExcChequeClick - Exclui cheque corrente de TempChq e atualiza grade
2411:     *--------------------------------------------------------------------------
2412:     PROCEDURE BtnExcChequeClick()
2413:         LOCAL loc_oGrid
2414:         TRY
2415:             IF USED("TempChq") AND !EOF("TempChq")
2416:                 SELECT TempChq
2417:                 DELETE
2418:                 SKIP
2419:                 IF EOF("TempChq")
2420:                     SKIP -1
2421:                     IF BOF("TempChq")
2422:                         APPEND BLANK
2423:                         REPLACE TempChq.emps WITH go_4c_Sistema.cCodEmpresa
2424:                         GO TOP
2425:                     ENDIF
2426:                 ENDIF
2427:             ENDIF
2428:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeCheque
2429:             loc_oGrid.Refresh()
2430:         CATCH TO loc_oErro
2431:             MsgErro(loc_oErro.Message, "Formche.BtnExcChequeClick")
2432:         ENDTRY

*-- Linhas 2522 a 2576:
2522:                 loc_lResultado = .F.
2523:             ENDIF
2524: 
2525:             loc_cSQL = "SELECT * FROM SigCcChm WHERE numlotes = " + ;
2526:                 FormatarNumeroSQL(THIS.this_nNumLoteAtual)
2527: 
2528:             IF USED("cursor_4c_Rel")
2529:                 USE IN cursor_4c_Rel
2530:             ENDIF
2531: 
2532:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Rel")
2533: 
2534:             IF loc_nRet < 0 OR !USED("cursor_4c_Rel") OR RECCOUNT("cursor_4c_Rel") = 0
2535:                 MsgAviso("Nenhum cheque encontrado para impress" + CHR(227) + "o.", "Imprimir")
2536:                 IF USED("cursor_4c_Rel")
2537:                     USE IN cursor_4c_Rel
2538:                 ENDIF
2539:                 loc_lResultado = .F.
2540:             ENDIF
2541: 
2542:             IF USED("cursor_4c_RelFinal")
2543:                 USE IN cursor_4c_RelFinal
2544:             ENDIF
2545: 
2546:             IF USED("TempChq") AND RECCOUNT("TempChq") > 0
2547:                 SELECT a.*, b.valjuros AS valjur ;
2548:                     FROM TempChq a, cursor_4c_Rel b ;
2549:                     WHERE a.bancos = b.bancos AND a.agencias = b.agencias ;
2550:                     AND a.ncontas = b.ncontas AND a.ncheques = b.ncheques ;
2551:                     INTO CURSOR cursor_4c_RelFinal
2552:             ELSE
2553:                 SELECT * FROM cursor_4c_Rel INTO CURSOR cursor_4c_RelFinal
2554:             ENDIF
2555: 
2556:             IF USED("cursor_4c_Rel")
2557:                 USE IN cursor_4c_Rel
2558:             ENDIF
2559: 
2560:             IF USED("cursor_4c_RelFinal") AND RECCOUNT("cursor_4c_RelFinal") > 0
2561:                 SELECT cursor_4c_RelFinal
2562:                 GO TOP
2563:                 loc_cPoint = SET("Point")
2564:                 loc_cSep   = SET("Separator")
2565:                 SET POINT TO "."
2566:                 SET SEPARATOR TO ","
2567:                 SET REPORTBEHAVIOR 80
2568:                 THIS.ExecutarReportForm("SigMvChe", "PREVIEW")
2569:                 SET POINT TO (loc_cPoint)
2570:                 SET SEPARATOR TO (loc_cSep)
2571:                 SET REPORTBEHAVIOR 90
2572:                 SET SYSMENU TO DEFAULT
2573:                 TRY
2574:                     CriarMenuPrincipal()
2575:                 CATCH TO loc_oErroMenu
2576:                 ENDTRY

*-- Linhas 2615 a 2633:
2615:             ENDIF
2616: 
2617:             IF USED("cursor_4c_OperLPick") AND RECCOUNT("cursor_4c_OperLPick") > 0
2618:                 SELECT cursor_4c_OperLPick
2619:                 GO TOP
2620:                 loc_oPg2.txt_4c_OperL.Value = ALLTRIM(cursor_4c_OperLPick.Operacaos)
2621:                 *-- opera: S=entrada(DB), E=saida, ' '=transferencia(TR)
2622:                 loc_oPg2.txt_4c_Opera.Value = IIF(ALLTRIM(cursor_4c_OperLPick.tipos) = "TR", " ", ;
2623:                     IIF(ALLTRIM(cursor_4c_OperLPick.tipos) = "DB", "S", "E"))
2624:                 *-- Moeda default da operacao
2625:                 IF !EMPTY(ALLTRIM(cursor_4c_OperLPick.moeds))
2626:                     loc_oPg2.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_OperLPick.moeds)
2627:                 ENDIF
2628:             ENDIF
2629: 
2630:             IF USED("cursor_4c_OperLPick")
2631:                 USE IN cursor_4c_OperLPick
2632:             ENDIF
2633:             loc_oLookup.Release()

*-- Linhas 2663 a 2694:
2663:             ENDIF
2664: 
2665:             IF USED("cursor_4c_MoedaPick") AND RECCOUNT("cursor_4c_MoedaPick") > 0
2666:                 SELECT cursor_4c_MoedaPick
2667:                 GO TOP
2668:                 loc_oPg2.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_MoedaPick.CMoes)
2669:                 *-- Carregar cotacao mais recente
2670:                 IF USED("cursor_4c_CotacaoPick")
2671:                     USE IN cursor_4c_CotacaoPick
2672:                 ENDIF
2673:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2674:                     "SELECT TOP 1 CMoes, Valos FROM SigCdCot WHERE CMoes = " + ;
2675:                     EscaparSQL(ALLTRIM(cursor_4c_MoedaPick.CMoes)) + ;
2676:                     " ORDER BY Datas DESC, Horas DESC", ;
2677:                     "cursor_4c_CotacaoPick")
2678:                 IF loc_nRet > 0 AND USED("cursor_4c_CotacaoPick") AND RECCOUNT("cursor_4c_CotacaoPick") > 0
2679:                     SELECT cursor_4c_CotacaoPick
2680:                     loc_oPg2.txt_4c_Cotacao.Value = cursor_4c_CotacaoPick.Valos
2681:                 ELSE
2682:                     loc_oPg2.txt_4c_Cotacao.Value = 1
2683:                 ENDIF
2684:                 IF USED("cursor_4c_CotacaoPick")
2685:                     USE IN cursor_4c_CotacaoPick
2686:                 ENDIF
2687:                 THIS.CotacaoLostFocus()
2688:             ENDIF
2689: 
2690:             IF USED("cursor_4c_MoedaPick")
2691:                 USE IN cursor_4c_MoedaPick
2692:             ENDIF
2693:             loc_oLookup.Release()
2694:         CATCH TO loc_oErro

*-- Linhas 2741 a 2759:
2741:             ENDIF
2742: 
2743:             IF USED("cursor_4c_GrupoTPick") AND RECCOUNT("cursor_4c_GrupoTPick") > 0
2744:                 SELECT cursor_4c_GrupoTPick
2745:                 GO TOP
2746:                 loc_oPg2.txt_4c_GrupoT.Value  = ALLTRIM(cursor_4c_GrupoTPick.codigos)
2747:                 loc_oPg2.txt_4c_DGrupoT.Value = ALLTRIM(cursor_4c_GrupoTPick.descrs)
2748:             ENDIF
2749: 
2750:             IF USED("cursor_4c_GrupoTPick")
2751:                 USE IN cursor_4c_GrupoTPick
2752:             ENDIF
2753:             loc_oLookup.Release()
2754:         CATCH TO loc_oErro
2755:             MsgErro(loc_oErro.Message, "Formche.ValidarGrupoT")
2756:         ENDTRY
2757:     ENDPROC
2758: 
2759:     *--------------------------------------------------------------------------

*-- Linhas 2767 a 2791:
2767:             USE IN cursor_4c_ParamJuro
2768:         ENDIF
2769: 
2770:         loc_nRet = SQLEXEC(gnConnHandle, ;
2771:             "SELECT TOP 1 JuroCarts FROM SigCdPam WHERE emps = " + ;
2772:             EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
2773:             "cursor_4c_ParamJuro")
2774: 
2775:         IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ParamJuro") > 0
2776:             SELECT cursor_4c_ParamJuro
2777:             GO TOP
2778:             loc_nJuroCarts = cursor_4c_ParamJuro.JuroCarts
2779:         ENDIF
2780: 
2781:         IF USED("cursor_4c_ParamJuro")
2782:             USE IN cursor_4c_ParamJuro
2783:         ENDIF
2784: 
2785:         RETURN loc_nJuroCarts
2786:     ENDFUNC
2787: 
2788:     *--------------------------------------------------------------------------
2789:     * ValidarGrupoOs - LostFocus: lookup grupo contabil de origem (SigCdGcr)
2790:     *--------------------------------------------------------------------------
2791:     PROCEDURE ValidarGrupoOs(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 2812 a 2830:
2812:             ENDIF
2813: 
2814:             IF USED("cursor_4c_GrupoOsPick") AND RECCOUNT("cursor_4c_GrupoOsPick") > 0
2815:                 SELECT cursor_4c_GrupoOsPick
2816:                 GO TOP
2817:                 loc_oPg2.txt_4c_GrupoOs.Value  = ALLTRIM(cursor_4c_GrupoOsPick.codigos)
2818:                 loc_oPg2.txt_4c_DGrupoOs.Value = ALLTRIM(cursor_4c_GrupoOsPick.descrs)
2819:                 loc_oPg2.txt_4c_ContaOs.Value  = ""
2820:                 loc_oPg2.txt_4c_DCONTAOs.Value = ""
2821:             ENDIF
2822: 
2823:             IF USED("cursor_4c_GrupoOsPick")
2824:                 USE IN cursor_4c_GrupoOsPick
2825:             ENDIF
2826:             loc_oLookup.Release()
2827:         CATCH TO loc_oErro
2828:             MsgErro(loc_oErro.Message, "Formche.ValidarGrupoOs")
2829:         ENDTRY
2830:     ENDPROC

*-- Linhas 2853 a 2877:
2853:             IF USED("cursor_4c_ContaOsVal")
2854:                 USE IN cursor_4c_ContaOsVal
2855:             ENDIF
2856:             loc_nRet = SQLEXEC(gnConnHandle, ;
2857:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE iclis = " + ;
2858:                 EscaparSQL(loc_cVal) + " AND grupos = " + EscaparSQL(loc_cGrupo), ;
2859:                 "cursor_4c_ContaOsVal")
2860: 
2861:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ContaOsVal") > 0
2862:                 SELECT cursor_4c_ContaOsVal
2863:                 GO TOP
2864:                 loc_oPg2.txt_4c_ContaOs.Value  = ALLTRIM(cursor_4c_ContaOsVal.Iclis)
2865:                 loc_oPg2.txt_4c_DCONTAOs.Value = ALLTRIM(cursor_4c_ContaOsVal.Rclis)
2866:             ELSE
2867:                 MsgAviso("Conta n" + CHR(227) + "o encontrada no Grupo de Origem.", ;
2868:                     "Conta Origem")
2869:                 loc_oPg2.txt_4c_ContaOs.Value  = ""
2870:                 loc_oPg2.txt_4c_DCONTAOs.Value = ""
2871:                 loc_oPg2.txt_4c_ContaOs.SetFocus()
2872:             ENDIF
2873: 
2874:             IF USED("cursor_4c_ContaOsVal")
2875:                 USE IN cursor_4c_ContaOsVal
2876:             ENDIF
2877:         CATCH TO loc_oErro

*-- Linhas 2906 a 2924:
2906:             ENDIF
2907: 
2908:             IF USED("cursor_4c_GrupoDsPick") AND RECCOUNT("cursor_4c_GrupoDsPick") > 0
2909:                 SELECT cursor_4c_GrupoDsPick
2910:                 GO TOP
2911:                 loc_oPg2.txt_4c_GrupoDs.Value  = ALLTRIM(cursor_4c_GrupoDsPick.codigos)
2912:                 loc_oPg2.txt_4c_DGrupoDs.Value = ALLTRIM(cursor_4c_GrupoDsPick.descrs)
2913:                 loc_oPg2.txt_4c_ContaDs.Value  = ""
2914:                 loc_oPg2.txt_4c_DCONTADs.Value = ""
2915:             ENDIF
2916: 
2917:             IF USED("cursor_4c_GrupoDsPick")
2918:                 USE IN cursor_4c_GrupoDsPick
2919:             ENDIF
2920:             loc_oLookup.Release()
2921:         CATCH TO loc_oErro
2922:             MsgErro(loc_oErro.Message, "Formche.ValidarGrupoDs")
2923:         ENDTRY
2924:     ENDPROC

*-- Linhas 2947 a 2971:
2947:             IF USED("cursor_4c_ContaDsVal")
2948:                 USE IN cursor_4c_ContaDsVal
2949:             ENDIF
2950:             loc_nRet = SQLEXEC(gnConnHandle, ;
2951:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE iclis = " + ;
2952:                 EscaparSQL(loc_cVal) + " AND grupos = " + EscaparSQL(loc_cGrupo), ;
2953:                 "cursor_4c_ContaDsVal")
2954: 
2955:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ContaDsVal") > 0
2956:                 SELECT cursor_4c_ContaDsVal
2957:                 GO TOP
2958:                 loc_oPg2.txt_4c_ContaDs.Value  = ALLTRIM(cursor_4c_ContaDsVal.Iclis)
2959:                 loc_oPg2.txt_4c_DCONTADs.Value = ALLTRIM(cursor_4c_ContaDsVal.Rclis)
2960:             ELSE
2961:                 MsgAviso("Conta n" + CHR(227) + "o encontrada no Grupo de Destino.", ;
2962:                     "Conta Destino")
2963:                 loc_oPg2.txt_4c_ContaDs.Value  = ""
2964:                 loc_oPg2.txt_4c_DCONTADs.Value = ""
2965:                 loc_oPg2.txt_4c_ContaDs.SetFocus()
2966:             ENDIF
2967: 
2968:             IF USED("cursor_4c_ContaDsVal")
2969:                 USE IN cursor_4c_ContaDsVal
2970:             ENDIF
2971:         CATCH TO loc_oErro

*-- Linhas 3000 a 3018:
3000:             ENDIF
3001: 
3002:             IF USED("cursor_4c_GruJuroPick") AND RECCOUNT("cursor_4c_GruJuroPick") > 0
3003:                 SELECT cursor_4c_GruJuroPick
3004:                 GO TOP
3005:                 loc_oPg2.txt_4c_GruJuro.Value  = ALLTRIM(cursor_4c_GruJuroPick.codigos)
3006:                 loc_oPg2.txt_4c_DGruJuro.Value = ALLTRIM(cursor_4c_GruJuroPick.descrs)
3007:                 loc_oPg2.txt_4c_ConJuro.Value  = ""
3008:                 loc_oPg2.txt_4c_DJuro.Value    = ""
3009:             ENDIF
3010: 
3011:             IF USED("cursor_4c_GruJuroPick")
3012:                 USE IN cursor_4c_GruJuroPick
3013:             ENDIF
3014:             loc_oLookup.Release()
3015:         CATCH TO loc_oErro
3016:             MsgErro(loc_oErro.Message, "Formche.ValidarGruJuro")
3017:         ENDTRY
3018:     ENDPROC

*-- Linhas 3041 a 3065:
3041:             IF USED("cursor_4c_ConJuroVal")
3042:                 USE IN cursor_4c_ConJuroVal
3043:             ENDIF
3044:             loc_nRet = SQLEXEC(gnConnHandle, ;
3045:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE iclis = " + ;
3046:                 EscaparSQL(loc_cVal) + " AND grupos = " + EscaparSQL(loc_cGrupo), ;
3047:                 "cursor_4c_ConJuroVal")
3048: 
3049:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ConJuroVal") > 0
3050:                 SELECT cursor_4c_ConJuroVal
3051:                 GO TOP
3052:                 loc_oPg2.txt_4c_ConJuro.Value = ALLTRIM(cursor_4c_ConJuroVal.Iclis)
3053:                 loc_oPg2.txt_4c_DJuro.Value   = ALLTRIM(cursor_4c_ConJuroVal.Rclis)
3054:             ELSE
3055:                 MsgAviso("Conta n" + CHR(227) + "o encontrada no Grupo de Juros.", ;
3056:                     "Conta Juros")
3057:                 loc_oPg2.txt_4c_ConJuro.Value = ""
3058:                 loc_oPg2.txt_4c_DJuro.Value   = ""
3059:                 loc_oPg2.txt_4c_ConJuro.SetFocus()
3060:             ENDIF
3061: 
3062:             IF USED("cursor_4c_ConJuroVal")
3063:                 USE IN cursor_4c_ConJuroVal
3064:             ENDIF
3065:         CATCH TO loc_oErro

*-- Linhas 3162 a 3191:
3162:                 USE IN cursor_4c_PgvConsulta
3163:             ENDIF
3164: 
3165:             loc_cSQL = "SELECT c.bancos, c.agencias, c.ncontas, c.ncheques," + ;
3166:                 " ISNULL(h.valors, 0) AS valors" + ;
3167:                 " FROM SigCcChm c" + ;
3168:                 " LEFT JOIN SigChe h ON h.bancos=c.bancos AND h.agencias=c.agencias" + ;
3169:                 " AND h.ncontas=c.ncontas AND h.ncheques=c.ncheques" + ;
3170:                 " WHERE c.numlotes = " + FormatarNumeroSQL(THIS.this_nNumLoteAtual) + ;
3171:                 " ORDER BY c.bancos, c.ncheques"
3172: 
3173:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PgvConsulta")
3174: 
3175:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_PgvConsulta") > 0
3176:                 SELECT cursor_4c_PgvConsulta
3177:                 loc_nTotal = RECCOUNT("cursor_4c_PgvConsulta")
3178:                 GO TOP
3179:                 loc_cMsg = "PGV - Lote " + LTRIM(STR(THIS.this_nNumLoteAtual)) + ;
3180:                     " (" + LTRIM(STR(loc_nTotal)) + " cheque(s))" + CHR(13) + CHR(13)
3181:                 SCAN
3182:                     loc_cMsg = loc_cMsg + ;
3183:                         ALLTRIM(cursor_4c_PgvConsulta.bancos) + "/" + ;
3184:                         ALLTRIM(cursor_4c_PgvConsulta.ncontas) + ;
3185:                         " Ch:" + ALLTRIM(cursor_4c_PgvConsulta.ncheques) + CHR(13)
3186:                 ENDSCAN
3187:                 MsgInfo(loc_cMsg, "Consulta PGV")
3188:             ELSE
3189:                 MsgAviso("Nenhum cheque registrado neste lote.", "Consulta PGV")
3190:             ENDIF
3191: 

*-- Linhas 3221 a 3239:
3221:             IF VARTYPE(loc_oLookup1) = "O"
3222:                 loc_oLookup1.Show()
3223:                 IF USED("cursor_4c_ContaOsBtn") AND RECCOUNT("cursor_4c_ContaOsBtn") > 0
3224:                     SELECT cursor_4c_ContaOsBtn
3225:                     GO TOP
3226:                     loc_oPg2.txt_4c_ContaOs.Value  = ALLTRIM(cursor_4c_ContaOsBtn.Iclis)
3227:                     loc_oPg2.txt_4c_DCONTAOs.Value = ALLTRIM(cursor_4c_ContaOsBtn.Rclis)
3228:                 ENDIF
3229:                 IF USED("cursor_4c_ContaOsBtn")
3230:                     USE IN cursor_4c_ContaOsBtn
3231:                 ENDIF
3232:                 loc_oLookup1.Release()
3233:             ENDIF
3234:         CATCH TO loc_oErro
3235:             MsgErro(loc_oErro.Message, "Formche.BtnCommand1Click")
3236:         ENDTRY
3237:     ENDPROC
3238: 
3239:     *--------------------------------------------------------------------------

*-- Linhas 3260 a 3278:
3260:             IF VARTYPE(loc_oLookup2) = "O"
3261:                 loc_oLookup2.Show()
3262:                 IF USED("cursor_4c_ContaDsBtn") AND RECCOUNT("cursor_4c_ContaDsBtn") > 0
3263:                     SELECT cursor_4c_ContaDsBtn
3264:                     GO TOP
3265:                     loc_oPg2.txt_4c_ContaDs.Value  = ALLTRIM(cursor_4c_ContaDsBtn.Iclis)
3266:                     loc_oPg2.txt_4c_DCONTADs.Value = ALLTRIM(cursor_4c_ContaDsBtn.Rclis)
3267:                 ENDIF
3268:                 IF USED("cursor_4c_ContaDsBtn")
3269:                     USE IN cursor_4c_ContaDsBtn
3270:                 ENDIF
3271:                 loc_oLookup2.Release()
3272:             ENDIF
3273:         CATCH TO loc_oErro
3274:             MsgErro(loc_oErro.Message, "Formche.BtnCommand2Click")
3275:         ENDTRY
3276:     ENDPROC
3277: 
3278:     *--------------------------------------------------------------------------

*-- Linhas 3292 a 3319:
3292:                 USE IN cursor_4c_Hist
3293:             ENDIF
3294: 
3295:             loc_cSQL = "SELECT TOP 20 operacaos, datatrans, usuarios" + ;
3296:                 " FROM LogAuditoria" + ;
3297:                 " WHERE tabelas = 'SigCqLcm' AND codigos = " + ;
3298:                 FormatarNumeroSQL(loc_nLote) + ;
3299:                 " ORDER BY datatrans DESC"
3300: 
3301:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Hist")
3302: 
3303:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_Hist") > 0
3304:                 SELECT cursor_4c_Hist
3305:                 GO TOP
3306:                 loc_cMsg = "Hist" + CHR(243) + "rico - Lote " + ;
3307:                     LTRIM(STR(loc_nLote)) + CHR(13) + CHR(13)
3308:                 SCAN
3309:                     loc_cMsg = loc_cMsg + ;
3310:                         ALLTRIM(cursor_4c_Hist.operacaos) + " - " + ;
3311:                         ALLTRIM(cursor_4c_Hist.usuarios) + CHR(13)
3312:                 ENDSCAN
3313:                 MsgInfo(loc_cMsg, "Hist" + CHR(243) + "rico")
3314:             ELSE
3315:                 MsgAviso("Nenhum hist" + CHR(243) + "rico encontrado para este lote.", ;
3316:                     "Hist" + CHR(243) + "rico")
3317:             ENDIF
3318: 
3319:             IF USED("cursor_4c_Hist")


### BO (C:\4c\projeto\app\classes\cheBO.prg):
DEFINE CLASS cheBO AS BusinessBase

    *-- SigCqLcm - cabecalho do lote
    this_nNumLote  = 0
    this_cOperL    = ""
    this_dData     = {}
    this_dDtMovs   = {}
    this_cOpera    = ""
    this_cLimCart  = ""

    *-- Moeda / conversao
    this_cMoeda    = ""
    this_nCotacao  = 0
    this_nValConv  = 0

    *-- Totais (Valtots, Valtjuros, calc TLiq)
    this_nValor    = 0
    this_nTJuros   = 0
    this_nTLiq     = 0

    *-- Taxas
    this_nTaxaDia  = 0
    this_nTaxaIof  = 0
    this_nTaxaMes  = 0

    *-- Grupo / Conta Destino
    this_cGrupoDs  = ""
    this_cDGrupoDs = ""
    this_cContaDs  = ""
    this_cDContaDs = ""

    *-- Grupo / Conta Origem
    this_cGrupoOs  = ""
    this_cDGrupoOs = ""
    this_cContaOs  = ""
    this_cDContaOs = ""

    *-- Grupo / Conta Terceiro
    this_cGrupoT   = ""
    this_cDGrupoT  = ""

    *-- Grupo / Conta Juros
    this_cGruJuro  = ""
    this_cDGruJuro = ""
    this_cConJuro  = ""
    this_cDJuro    = ""

    *-- Chave interna (GUID - cidchaves)
    this_cCidChave  = ""

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCqLcm"
        THIS.this_cCampoChave = "NumLotes"
        RETURN .T.
    ENDPROC

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_nNumLote
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de lotes da carteira de cheques
    * par_cFiltro: WHERE adicional (ex: "AND datas BETWEEN '...' AND '...'")
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.datas, a.dtmovs, a.codigos," + ;
                " a.operas, a.tipos, a.moeds, a.cotas, a.valtots," + ;
                " a.valtjuros, a.valconvs, a.grupoos, a.contaos," + ;
                " a.grupods, a.contads, a.grupocx, a.contacx," + ;
                " a.grujuros, a.conjuros, a.taxcarts, a.taxdias, a.taxiofs," + ;
                " a.emps, a.usuarios, a.datatrans, a.cidchaves" + ;
                " FROM SigCqLcm a" + ;
                " WHERE 1=1"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.numlotes"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lotes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega lote pelo numlotes
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_nNumLote)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.datas, a.dtmovs, a.codigos," + ;
                " a.operas, a.tipos, a.moeds, a.cotas, a.valtots," + ;
                " a.valtjuros, a.valconvs, a.grupoos, a.contaos," + ;
                " a.grupods, a.contads, a.grupocx, a.contacx," + ;
                " a.grujuros, a.conjuros, a.taxcarts, a.taxdias, a.taxiofs," + ;
                " a.emps, a.usuarios, a.datatrans, a.cidchaves" + ;
                " FROM SigCqLcm a" + ;
                " WHERE a.numlotes = " + FormatarNumeroSQL(par_nNumLote)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNumLote   = TratarNulo(numlotes,  "N")
            THIS.this_cCidChave  = TratarNulo(cidchaves, "C")
            THIS.this_dData      = TratarNulo(datas,     "D")
            THIS.this_dDtMovs    = TratarNulo(dtmovs,    "D")
            THIS.this_cOperL     = TratarNulo(codigos,   "C")
            THIS.this_cOpera     = TratarNulo(operas,    "C")
            THIS.this_cLimCart   = TratarNulo(tipos,     "C")
            THIS.this_cMoeda     = TratarNulo(moeds,     "C")
            THIS.this_nCotacao   = TratarNulo(cotas,     "N")
            THIS.this_nValConv   = TratarNulo(valconvs,  "N")
            THIS.this_nValor     = TratarNulo(valtots,   "N")
            THIS.this_nTJuros    = TratarNulo(valtjuros, "N")
            THIS.this_nTLiq      = THIS.this_nValor - THIS.this_nTJuros
            THIS.this_nTaxaDia   = TratarNulo(taxdias,   "N")
            THIS.this_nTaxaIof   = TratarNulo(taxiofs,   "N")
            THIS.this_nTaxaMes   = TratarNulo(taxcarts,  "N")
            THIS.this_cGrupoDs   = TratarNulo(grupods,   "C")
            THIS.this_cContaDs   = TratarNulo(contads,   "C")
            THIS.this_cGrupoOs   = TratarNulo(grupoos,   "C")
            THIS.this_cContaOs   = TratarNulo(contaos,   "C")
            THIS.this_cGrupoT    = TratarNulo(grupocx,   "C")
            THIS.this_cGruJuro   = TratarNulo(grujuros,  "C")
            THIS.this_cConJuro   = TratarNulo(conjuros,  "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterProximoLote - Retorna proximo numlotes disponivel
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterProximoLote()
        LOCAL loc_cSQL, loc_nResult, loc_nProximo
        loc_nProximo = 1

        loc_cSQL = "SELECT ISNULL(MAX(numlotes), 0) + 1 AS proximo FROM SigCqLcm" + ;
            " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxLote")

        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxLote") > 0
            SELECT cursor_4c_ProxLote
            loc_nProximo = cursor_4c_ProxLote.proximo
        ENDIF

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        RETURN loc_nProximo
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCqLcm
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nProximo, loc_cCidChave
        loc_lSucesso = .F.

        TRY
            loc_nProximo  = THIS.ObterProximoLote()
            loc_cCidChave = LEFT(go_4c_Sistema.cCodEmpresa + ;
                PADL(TRANSFORM(loc_nProximo), 17, "0"), 20)

            THIS.this_nNumLote  = loc_nProximo
            THIS.this_cCidChave = loc_cCidChave

            loc_cSQL = "INSERT INTO SigCqLcm (" + ;
                " numlotes, cidchaves, datas, dtmovs, codigos, operas, tipos," + ;
                " moeds, cotas, valtots, valtjuros, valconvs," + ;
                " grupoos, contaos, grupods, contads, grupocx, contacx," + ;
                " grujuros, conjuros, taxcarts, taxdias, taxiofs," + ;
                " emps, usuarios, dtsis, autos, locals, ntrans," + ;
                " nalineas, empdopnums, custodia)" + ;
                " VALUES (" + ;
                FormatarNumeroSQL(THIS.this_nNumLote) + "," + ;
                EscaparSQL(THIS.this_cCidChave) + "," + ;
                FormatarDataSQL(THIS.this_dData) + "," + ;
                FormatarDataSQL(THIS.this_dDtMovs) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cOperL)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cOpera)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cLimCart)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoeda)) + "," + ;
                FormatarNumeroSQL(THIS.this_nCotacao) + "," + ;
                FormatarNumeroSQL(THIS.this_nValor) + "," + ;
                FormatarNumeroSQL(THIS.this_nTJuros) + "," + ;
                FormatarNumeroSQL(THIS.this_nValConv) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupoOs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cContaOs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupoDs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cContaDs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupoT)) + "," + ;
                "''," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruJuro)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConJuro)) + "," + ;
                FormatarNumeroSQL(THIS.this_nTaxaMes) + "," + ;
                FormatarNumeroSQL(THIS.this_nTaxaDia) + "," + ;
                FormatarNumeroSQL(THIS.this_nTaxaIof) + "," + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + "," + ;
                EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + "," + ;
                "GETDATE()," + ;
                "0,'',0,0,'','')"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCqLcm
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCqLcm SET" + ;
                " datas = "     + FormatarDataSQL(THIS.this_dData) + "," + ;
                " dtmovs = "    + FormatarDataSQL(THIS.this_dDtMovs) + "," + ;
                " operas = "    + EscaparSQL(ALLTRIM(THIS.this_cOpera)) + "," + ;
                " tipos = "     + EscaparSQL(ALLTRIM(THIS.this_cLimCart)) + "," + ;
                " moeds = "     + EscaparSQL(ALLTRIM(THIS.this_cMoeda)) + "," + ;
                " cotas = "     + FormatarNumeroSQL(THIS.this_nCotacao) + "," + ;
                " valtots = "   + FormatarNumeroSQL(THIS.this_nValor) + "," + ;
                " valtjuros = " + FormatarNumeroSQL(THIS.this_nTJuros) + "," + ;
                " valconvs = "  + FormatarNumeroSQL(THIS.this_nValConv) + "," + ;
                " grupoos = "   + EscaparSQL(ALLTRIM(THIS.this_cGrupoOs)) + "," + ;
                " contaos = "   + EscaparSQL(ALLTRIM(THIS.this_cContaOs)) + "," + ;
                " grupods = "   + EscaparSQL(ALLTRIM(THIS.this_cGrupoDs)) + "," + ;
                " contads = "   + EscaparSQL(ALLTRIM(THIS.this_cContaDs)) + "," + ;
                " grupocx = "   + EscaparSQL(ALLTRIM(THIS.this_cGrupoT)) + "," + ;
                " grujuros = "  + EscaparSQL(ALLTRIM(THIS.this_cGruJuro)) + "," + ;
                " conjuros = "  + EscaparSQL(ALLTRIM(THIS.this_cConJuro)) + "," + ;
                " taxcarts = "  + FormatarNumeroSQL(THIS.this_nTaxaMes) + "," + ;
                " taxdias = "   + FormatarNumeroSQL(THIS.this_nTaxaDia) + "," + ;
                " taxiofs = "   + FormatarNumeroSQL(THIS.this_nTaxaIof) + "," + ;
                " usuarios = "  + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCcChm (cheques) e SigCqLcm (lote)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.RegistrarAuditoria("DELETE")

            loc_cSQL = "DELETE FROM SigCcChm WHERE numlotes = " + ;
                FormatarNumeroSQL(THIS.this_nNumLote)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigCqLcm WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChave)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

