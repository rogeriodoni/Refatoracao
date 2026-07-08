# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (11)
- [GRID-SQL] Campo 'emps' usado em ControlSource de cursor_4c_MaxProduto mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'qmaxs' usado em ControlSource de cursor_4c_MaxProduto mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'codtams' usado em ControlSource de cursor_4c_MaxProduto mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'codcores' usado em ControlSource de cursor_4c_MaxProduto mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'deptos' usado em ControlSource de cursor_4c_MaxProduto mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'marcas' usado em ControlSource de cursor_4c_Copia mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'qmaxs' usado em ControlSource de cursor_4c_Copia mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'codtams' usado em ControlSource de cursor_4c_Copia mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'codcores' usado em ControlSource de cursor_4c_Copia mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'deptos' usado em ControlSource de cursor_4c_Copia mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, CORES, TAMS, EMPS, ICLIS, EXISTES, PCESCOLHA, GESIND

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
Select CrSigCdMax
	.Column1.ControlSource = 'CrSigCdMax.emps'
	.Column2.ControlSource = 'CrSigCdMax.Qmaxs'
	.Column3.ControlSource = 'CrSigCdMax.codtams'
	.Column4.ControlSource = 'CrSigCdMax.codcores'
	.Column5.ControlSource = 'CrSigCdMax.Deptos'
Insert Into CrSigCdMax (cpros,cidchaves) Values (ThisForm.Pagina.Dados.Get_Produto.Value,fUniqueIds())
Select CrSigCdMax
Select CrSigCdMax
	lStrQuery = [Select b.cores,b.tams,b.tipoestos From SigCdPro a, SigCdGrp b ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpProGru') < 1
	Select TmpProGru
lcQProds  = [Select a.cpros,b.dpros,b.ifors,b.reffs,b.cgrus,b.sgrus,b.situas,c.rclis,g.dgrus ]+;
			[From SigCdMax a ]+;
			[Inner Join SigCdPro b On b.cpros = a.cpros ]+;
			[Left Join SigCdCli c On b.ifors = c.iclis ]+;
			[Left Join SigCdGrp g On b.cgrus = g.cgrus ]+;
LcQprCom  = [Select a.*,b.dpros,b.ifors,b.reffs,b.cgrus,b.situas,c.rclis,g.dgrus ]+;
			[From SigCdMax a, SigCdPro b ]+;
			[Left Join SigCdCli c On b.ifors = c.iclis ]+;
			[Left Join SigCdGrp g On b.cgrus = g.cgrus ]+;
lcQCopia  = [Select 1 As marcas,0 As existes,a.cpros,a.emps,a.Qmaxs,a.codtams,a.codcores,a.cidchaves ]+;
			[From SigCdMax a ]+;
 				[(Select b.cpros + b.codtams + b.codcores As cprotamcores From SigCdMax b ]+;
			[Select 0 As marcas,1 As existes,a.cpros,a.emps,a.Qmaxs,a.codtams,a.codcores,a.cidchaves ]+;
			[From SigCdMax a ]+;
 				[(Select b.cpros + b.codtams + b.codcores As cprotamcores From SigCdMax b ]+;
			[Select 0 As marcas,2 As existes,a.cpros,a.emps,a.Qmaxs,a.codtams,a.codcores,a.cidchaves ]+;
			[From SigCdMax a ]+;
 				[(Select b.cpros + b.codtams + b.codcores As cprotamcores From SigCdMax b ]+;
If ThisForm.poDataMgr.SqlExecute([Select gesind From SigCdPam ],'CrSigCdPam') < 1
ThisForm.poDataMgr.Update('CrSigCdMax')
Select CrSigCdMax
Delete From CrSigCdMax
Delete From CrSigCdMax
ThisForm.poDataMgr.Update('CrSigCdMax')
ThisForm.poDataMgr.Update('CrSigCdMax')
Select CrProdutos
Select Distinct cpros,dpros,cgrus,dgrus,ifors,rclis,reffs,Qmaxs,situas ;
  From CrSigCdMax ;
	Insert Into CsCabec (cpros,dpros,cgrus,dgrus,ifors,rclis,reffs,Qmaxs,situas) ;
Select CrSigCdMax
	lStrQuery = [Select rclis From SigCdCli Where iclis = ']+ThisForm.pcIFors+[']
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpIFors') < 1
	lStrQuery = [Select Dgrus From SigCdGrp Where CGrus = ']+ThisForm.pcCGrus+[']
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpCGrus') < 1
	Select CrSigCdMax
	Insert Into CrSigCdMax (cpros,cidchaves) Values (ThisForm.pcCPros,fUniqueIds())
	Select CrSigCdMax
	Insert Into CsCabec (cpros,dpros,ifors,rclis,cgrus,dgrus,reffs,situas) ;
		Select CrSigCdMax
	Select CrSigCdMax
			Delete
	Select CrSigCdMax
		Insert Into CrSigCdMax (cpros,cidchaves) Values (Thisform.pagina.dados.get_Produto.Value,fUniqueIds())
		Select CrSigCdMax
Select CsCopia
		Insert Into CrSigCdMax (cpros,emps,Qmaxs,codtams,codcores,cidchaves,Deptos) ;
ThisForm.poDataMgr.Update('CrSigCdMax')
	Select CsCopia
	Select CsCopia
		.Column1.ControlSource = 'CsCopia.marcas'
		.Column2.ControlSource = 'CsCopia.cpros'
		.Column3.ControlSource = 'CsCopia.Qmaxs'
		.Column4.ControlSource = 'CsCopia.codtams'
		.Column5.ControlSource = 'CsCopia.codcores'
		.Column6.ControlSource = 'CsCopia.Deptos'
Select CsCopia
Update CsCopia Set Marcas = 1 Where existes = 0
Select CsCopia
Update CsCopia Set Marcas = 0 Where existes = 0
		lStrQuery = [Select a.cpros,a.dpros,a.cgrus,a.ifors,a.reffs,a.situas,c.rclis,g.dgrus ]+;
					[From SigCdPro a ]+;
					[Left Join SigCdGrp g On g.cgrus = a.cgrus ]+;
					[Left Join SigCdCli c On c.iclis = a.ifors ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
		Select TmpPro
			Select CrSigCdMax
		Insert Into CrSigCdMax (cpros,cidchaves) Values (TmpPro.cpros,fUniqueIds())
		Select CrSigCdMax
		Insert Into CsCabec (cpros,dpros,ifors,rclis,cgrus,dgrus,reffs,situas) ;
Select CrSigCdMax
Delete From CrSigCdMax Where emps = lcEmps
Select CrSigCdMax
	Insert Into CrSigCdMax (cpros,cidchaves) Values (This.Parent.Get_Produto.Value,fUniqueIds())
Select CrSigCdMax
	Select CrSigCdMax
		lStrQuery = [Select a.cpros,a.dpros,a.cgrus,a.ifors,a.reffs,a.situas,c.rclis,g.dgrus ]+;
					[From SigCdPro a ]+;
					[Left Join SigCdGrp g On g.cgrus = a.cgrus ]+;
					[Left Join SigCdCli c On c.iclis = a.ifors ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
		Select TmpPro
			Select CrSigCdMax
		Insert Into CrSigCdMax (cpros,cidchaves) Values (TmpPro.cpros,fUniqueIds())
		Select CrSigCdMax
		Insert Into CsCabec (cpros,dpros,ifors,rclis,cgrus,dgrus,reffs,situas) ;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprcom.prg) - TRECHOS RELEVANTES PARA PASS SQL (2486 linhas total):

*-- Linhas 436 a 454:
436:             .RecordSource  = ""
437:             .Visible       = .T.
438:             .RecordMark   = .F.
439:             .DeleteMark   = .F.
440:         ENDWITH
441:         BINDEVENT(loc_oPag.grd_4c_Lista, "AfterRowColChange", THIS, "GridListaAfterRowColChange")
442: 
443:         *----------------------------------------------------------------------
444:         * Container flutuante de copia de produto entre empresas
445:         * Original cntCopia: Top=161, Left=256, Width=486, Height=373, visible=.F.
446:         * Com compensacao: Top = 161 + 29 = 190
447:         * BackStyle=1 (opaco) obrigatorio: BackStyle=0 sobre grid = ghost trails no scroll
448:         *----------------------------------------------------------------------
449:         loc_oPag.AddObject("cnt_4c_Copia", "Container")
450:         WITH loc_oPag.cnt_4c_Copia
451:             .Top           = 190
452:             .Left          = 256
453:             .Width         = 486
454:             .Height        = 373

*-- Linhas 750 a 768:
750:             .RecordSource  = ""
751:             .Visible       = .T.
752:             .RecordMark   = .F.
753:             .DeleteMark   = .F.
754:         ENDWITH
755: 
756:         *-- CheckBox na Column1 (Check1 original): marca registro para copia
757:         loc_oCopia.grd_4c_Dados.Column1.AddObject("chk_4c_Check1", "CheckBox")
758:         WITH loc_oCopia.grd_4c_Dados.Column1
759:             .CurrentControl = "chk_4c_Check1"
760:             .Sparse         = .F.
761:             .Width          = 30
762:             .ReadOnly       = .F.
763:         ENDWITH
764:         WITH loc_oCopia.grd_4c_Dados.Column1.chk_4c_Check1
765:             .Caption = ""
766:             .Width   = 25
767:             .Height  = 17
768:         ENDWITH

*-- Linhas 1102 a 1138:
1102:         * Top=181+29=210, Left=309, Width=387, Height=472, ColumnCount=5
1103:         * ReadOnly=.F.: usuario edita empresa/qtde/tamanho/cor/departamento
1104:         * Problema 36: ColumnCount FORA de WITH (colunas criadas imediatamente)
1105:         * RecordSource, ControlSource e Headers configurados em VincularGridPage2()
1106:         * Column3 (codtams): habilitado se this_lTemTam=.T.
1107:         * Column4 (codcores): habilitado se this_lTemCor=.T.
1108:         * F4 em Column3/4/5: abre lookup via GradeKeyPressPage2
1109:         *----------------------------------------------------------------------
1110:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
1111:         loc_oPag.grd_4c_Dados.ColumnCount = 5
1112:         WITH loc_oPag.grd_4c_Dados
1113:             .Top           = 210
1114:             .Left          = 309
1115:             .Width         = 387
1116:             .Height        = 472
1117:             .ReadOnly      = .F.
1118:             .FontName      = "Tahoma"
1119:             .FontSize      = 8
1120:             .GridLineColor = RGB(238, 238, 238)
1121:             .ForeColor     = RGB(90, 90, 90)
1122:             .RowHeight     = 16
1123:             .DeleteMark    = .F.
1124:             .RecordMark    = .F.
1125:             .ScrollBars    = 2
1126:             .RecordSource  = ""
1127:             .Visible       = .T.
1128:         ENDWITH
1129:         BINDEVENT(loc_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChangePage2")
1130:         BINDEVENT(loc_oPag.grd_4c_Dados, "KeyPress", THIS, "GradeKeyPressPage2")
1131: 
1132:         *-- Tornar controles visiveis
1133:         THIS.TornarControlesVisiveis(loc_oPag)
1134:     ENDPROC
1135: 
1136:     *==========================================================================
1137:     * CarregarLista - Carrega dados e vincula ao grid da Page1
1138:     *==========================================================================

*-- Linhas 1211 a 1256:
1211: 
1212:     *==========================================================================
1213:     * VincularGridLista - Vincula cursor_4c_Dados ao grd_4c_Lista
1214:     * Problemas 34/36/48/32: reset RS -> ColumnCount fora WITH -> RS -> ControlSource -> Header
1215:     *==========================================================================
1216:     PROCEDURE VincularGridLista()
1217:         LOCAL loc_oGrd
1218: 
1219:         TRY
1220:             IF USED("cursor_4c_Dados")
1221:                 loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1222: 
1223:                 *-- Problema 34: reset RecordSource antes de reconectar
1224:                 loc_oGrd.RecordSource = ""
1225: 
1226:                 *-- Problema 36: ColumnCount FORA de WITH
1227:                 loc_oGrd.ColumnCount = 7
1228: 
1229:                 *-- Reconectar RecordSource
1230:                 loc_oGrd.ColumnCount = 7
1231:                 loc_oGrd.RecordSource = "cursor_4c_Dados"
1232: 
1233:                 *-- Problema 48: ControlSource APOS RecordSource
1234:                 WITH loc_oGrd
1235:                     .Column1.ControlSource = "cursor_4c_Dados.cpros"
1236:                     .Column2.ControlSource = "cursor_4c_Dados.dpros"
1237:                     .Column3.ControlSource = "cursor_4c_Dados.rclis"
1238:                     .Column4.ControlSource = "cursor_4c_Dados.ifors"
1239:                     .Column5.ControlSource = "cursor_4c_Dados.reffs"
1240:                     .Column6.ControlSource = "cursor_4c_Dados.cgrus"
1241:                     .Column7.ControlSource = "cursor_4c_Dados.dgrus"
1242:                 ENDWITH
1243: 
1244:                 *-- Problema 32: Header captions APOS RecordSource
1245:                 loc_oGrd.Column1.Header1.Caption = ""
1246:                 loc_oGrd.Column2.Header1.Caption = "Produto"
1247:                 loc_oGrd.Column3.Header1.Caption = "Qtde. M" + CHR(225) + "x."
1248:                 loc_oGrd.Column4.Header1.Caption = "Tam"
1249:                 loc_oGrd.Column5.Header1.Caption = "Cor"
1250:                 loc_oGrd.Column6.Header1.Caption = "Departamento"
1251:                 loc_oGrd.Column7.Header1.Caption = "Emp"
1252: 
1253:                 *-- Larguras das colunas (total = 950, cabe em Width=971)
1254:                 WITH loc_oGrd
1255:                     .Column1.Width = 100
1256:                     .Column2.Width = 280

*-- Linhas 1321 a 1339:
1321: 
1322:         TRY
1323:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
1324:                 SELECT cursor_4c_Dados
1325:                 loc_cCpros   = ALLTRIM(cpros)
1326:                 loc_lSucesso = THIS.this_oBusinessObject.BuscarCabecalhoProduto(loc_cCpros)
1327: 
1328:                 IF loc_lSucesso
1329:                     loc_lSucesso = THIS.this_oBusinessObject.BuscarPorProduto(loc_cCpros)
1330:                 ENDIF
1331: 
1332:                 IF loc_lSucesso
1333:                     THIS.this_lTemCor    = THIS.this_oBusinessObject.this_lTemCor
1334:                     THIS.this_lTemTam    = THIS.this_oBusinessObject.this_lTemTam
1335:                     THIS.this_nTipoEstos = THIS.this_oBusinessObject.this_nTipoEstos
1336:                     THIS.this_cPcEscolha = "CONSULTAR"
1337:                     THIS.pgf_4c_Paginas.Page2.txt_4c__produto.Value    = ALLTRIM(loc_cCpros)
1338:                     THIS.PreencherCabecalhoProduto()
1339:                     THIS.VincularGridPage2()

*-- Linhas 1358 a 1376:
1358: 
1359:         TRY
1360:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
1361:                 SELECT cursor_4c_Dados
1362:                 loc_cCpros   = ALLTRIM(cpros)
1363:                 loc_lSucesso = THIS.this_oBusinessObject.BuscarCabecalhoProduto(loc_cCpros)
1364: 
1365:                 IF loc_lSucesso
1366:                     loc_lSucesso = THIS.this_oBusinessObject.BuscarPorProduto(loc_cCpros)
1367:                 ENDIF
1368: 
1369:                 IF loc_lSucesso
1370:                     THIS.this_lTemCor    = THIS.this_oBusinessObject.this_lTemCor
1371:                     THIS.this_lTemTam    = THIS.this_oBusinessObject.this_lTemTam
1372:                     THIS.this_nTipoEstos = THIS.this_oBusinessObject.this_nTipoEstos
1373:                     THIS.this_cPcEscolha = "ALTERAR"
1374:                     THIS.pgf_4c_Paginas.Page2.txt_4c__produto.Value    = ALLTRIM(loc_cCpros)
1375:                     THIS.PreencherCabecalhoProduto()
1376:                     THIS.VincularGridPage2()

*-- Linhas 1396 a 1414:
1396: 
1397:         TRY
1398:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
1399:                 SELECT cursor_4c_Dados
1400:                 loc_cCpros    = ALLTRIM(cpros)
1401:                 loc_lConfirma = MsgConfirma("Excluir todos os registros do produto " + loc_cCpros + "?", ;
1402:                     "Confirmar Exclus" + CHR(227) + "o")
1403:             ELSE
1404:                 MsgAviso("Selecione um produto para excluir.", "Aviso")
1405:             ENDIF
1406:         CATCH TO loException
1407:             MsgErro("Erro em BtnExcluirClick: " + loException.Message, "Erro")
1408:         ENDTRY
1409: 
1410:         IF loc_lConfirma
1411:             THIS.this_oBusinessObject.this_cCidchaves = ""
1412:             THIS.this_oBusinessObject.this_cCpros     = loc_cCpros
1413:             loc_lSucesso = THIS.this_oBusinessObject.Excluir()
1414: 

*-- Linhas 1439 a 1458:
1439: 
1440:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_Busca")
1441:                     GO TOP IN cursor_4c_Busca
1442:                     SELECT cursor_4c_Busca
1443:                     loc_cFiltro = "a.cpros = " + EscaparSQL(ALLTRIM(cpros))
1444:                 ENDIF
1445: 
1446:                 IF USED("cursor_4c_Busca")
1447:                     USE IN cursor_4c_Busca
1448:                 ENDIF
1449: 
1450:                 loc_oForm.Release()
1451:             ENDIF
1452:         CATCH TO loException
1453:             MsgErro("Erro em BtnBuscarClick: " + loException.Message, "Erro")
1454:         ENDTRY
1455: 
1456:         *-- Recarregar lista com filtro (vazio = todos os produtos)
1457:         THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1458:         THIS.VincularGridLista()

*-- Linhas 1505 a 1526:
1505:                 .grd_4c_Dados.RecordSource = ""
1506:                 .cmd_4c_Marcar.Visible    = .F.
1507:                 .cmd_4c_Desmarcar.Visible = .F.
1508:             ENDWITH
1509: 
1510:             IF USED("cursor_4c_Copia")
1511:                 USE IN cursor_4c_Copia
1512:             ENDIF
1513:         CATCH TO loException
1514:             MsgErro("Erro em CmdSairCopiaClick: " + loException.Message, "Erro")
1515:         ENDTRY
1516:     ENDPROC
1517: 
1518:     *==========================================================================
1519:     * EmpOrigLostFocus - Habilita/desabilita campo Empresa Destino
1520:     *==========================================================================
1521:     PROCEDURE EmpOrigLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1522:         LOCAL loc_oCopia
1523: 
1524:         TRY
1525:             loc_oCopia = THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia
1526: 

*-- Linhas 1564 a 1639:
1564: 
1565:         TRY
1566:             loc_oCopia = THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia
1567:             loc_cProd  = ALLTRIM(loc_oCopia.txt_4c_Produto.Value)
1568: 
1569:             IF !EMPTY(loc_cProd) AND USED("cursor_4c_Copia")
1570:                 SELECT cursor_4c_Copia
1571:                 SET NEAR ON
1572:                 SEEK loc_cProd
1573:                 SET NEAR OFF
1574:                 loc_oCopia.grd_4c_Dados.Refresh
1575:             ENDIF
1576:         CATCH TO loException
1577:             MsgErro("Erro em ProdutoCopiaLostFocus: " + loException.Message, "Erro")
1578:         ENDTRY
1579:     ENDPROC
1580: 
1581:     *==========================================================================
1582:     * CmdProcessaClick - Carrega cursor_4c_Copia e vincula ao grd_4c_Dados
1583:     * Problemas 34/36/48/32 aplicados ao grd_4c_Dados
1584:     *==========================================================================
1585:     PROCEDURE CmdProcessaClick()
1586:         LOCAL loc_oCopia, loc_cEmpO, loc_cEmpD, loc_cProd, loc_oGrd, loc_lSucesso
1587:         loc_lSucesso = .F.
1588: 
1589:         TRY
1590:             loc_oCopia = THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia
1591:             loc_cEmpO  = ALLTRIM(loc_oCopia.txt_4c_EmpOs.Value)
1592:             loc_cEmpD  = ALLTRIM(loc_oCopia.txt_4c_EmpDs.Value)
1593:             loc_cProd  = ALLTRIM(loc_oCopia.txt_4c_Produto.Value)
1594: 
1595:             IF EMPTY(loc_cEmpO)
1596:                 MsgAviso("Digite uma Empresa de Origem para realizar a C" + CHR(243) + "pia!", "Aviso")
1597:                 loc_oCopia.txt_4c_EmpOs.SetFocus
1598:             ELSE
1599:                 IF EMPTY(loc_cEmpD)
1600:                     MsgAviso("Digite uma Empresa de Destino para realizar a C" + CHR(243) + "pia!", "Aviso")
1601:                     loc_oCopia.txt_4c_EmpDs.SetFocus
1602:                 ELSE
1603:                     loc_lSucesso = THIS.this_oBusinessObject.CarregarCursorCopia(loc_cProd, loc_cEmpO, loc_cEmpD)
1604: 
1605:                     IF loc_lSucesso AND USED("cursor_4c_Copia")
1606:                         loc_oGrd = loc_oCopia.grd_4c_Dados
1607: 
1608:                         *-- Problema 34: reset antes de reconectar
1609:                         loc_oGrd.RecordSource = ""
1610: 
1611:                         *-- Problema 36: ColumnCount FORA de WITH
1612:                         loc_oGrd.ColumnCount = 6
1613: 
1614:                         *-- Reconectar RecordSource
1615:                         loc_oGrd.ColumnCount = 6
1616:                         loc_oGrd.RecordSource = "cursor_4c_Copia"
1617: 
1618:                         *-- Problema 48: ControlSource APOS RecordSource
1619:                         loc_oGrd.Column1.ControlSource = "cursor_4c_Copia.marcas"
1620:                         loc_oGrd.Column2.ControlSource = "cursor_4c_Copia.cpros"
1621:                         loc_oGrd.Column3.ControlSource = "cursor_4c_Copia.qmaxs"
1622:                         loc_oGrd.Column4.ControlSource = "cursor_4c_Copia.codtams"
1623:                         loc_oGrd.Column5.ControlSource = "cursor_4c_Copia.codcores"
1624:                         loc_oGrd.Column6.ControlSource = "cursor_4c_Copia.deptos"
1625: 
1626:                         *-- Problema 32: Header captions APOS RecordSource
1627:                         loc_oGrd.Column1.Header1.Caption = ""
1628:                         loc_oGrd.Column2.Header1.Caption = "Produto"
1629:                         loc_oGrd.Column3.Header1.Caption = "Qtde. M" + CHR(225) + "x."
1630:                         loc_oGrd.Column4.Header1.Caption = "Tam"
1631:                         loc_oGrd.Column5.Header1.Caption = "Cor"
1632:                         loc_oGrd.Column6.Header1.Caption = "Departamento"
1633: 
1634:                         WITH loc_oGrd
1635:                             .Column1.Width = 30
1636:                             .Column2.Width = 100
1637:                             .Column3.Width = 70
1638:                             .Column4.Width = 50
1639:                             .Column5.Width = 50

*-- Linhas 1682 a 1714:
1682:             THIS.CmdSairCopiaClick()
1683:         ENDIF
1684:     ENDPROC
1685: 
1686:     *==========================================================================
1687:     * CmdMarcarClick - Marca todos os registros eleg?veis no cursor_4c_Copia
1688:     *==========================================================================
1689:     PROCEDURE CmdMarcarClick()
1690:         TRY
1691:             THIS.this_oBusinessObject.MarcarTodosParaCopia(.T.)
1692:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia.grd_4c_Dados.Refresh
1693:         CATCH TO loException
1694:             MsgErro("Erro em CmdMarcarClick: " + loException.Message, "Erro")
1695:         ENDTRY
1696:     ENDPROC
1697: 
1698:     *==========================================================================
1699:     * CmdDesmarcarClick - Desmarca todos os registros no cursor_4c_Copia
1700:     *==========================================================================
1701:     PROCEDURE CmdDesmarcarClick()
1702:         TRY
1703:             THIS.this_oBusinessObject.MarcarTodosParaCopia(.F.)
1704:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia.grd_4c_Dados.Refresh
1705:         CATCH TO loException
1706:             MsgErro("Erro em CmdDesmarcarClick: " + loException.Message, "Erro")
1707:         ENDTRY
1708:     ENDPROC
1709: 
1710:     *==========================================================================
1711:     * GridListaAfterRowColChange - Handler AfterRowColChange do grd_4c_Lista
1712:     * BINDEVENT exige parametro declarado no handler
1713:     *==========================================================================
1714:     PROCEDURE GridListaAfterRowColChange(par_nColIndex)

*-- Linhas 1816 a 1834:
1816: 
1817:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
1818:                             GO TOP IN cursor_4c_Busca
1819:                             SELECT cursor_4c_Busca
1820:                             loc_oPag2.txt_4c__produto.Value = ALLTRIM(cpros)
1821:                             loc_oPag2.txt_4c_Dpro.Value     = ALLTRIM(dpros)
1822:                             THIS.this_oBusinessObject.BuscarCabecalhoProduto(ALLTRIM(cpros))
1823:                             THIS.PreencherCabecalhoProduto()
1824:                             THIS.AcertarGridPorProduto(ALLTRIM(cpros))
1825:                         ELSE
1826:                             loc_oPag2.txt_4c__produto.Value = ""
1827:                         ENDIF
1828: 
1829:                         IF USED("cursor_4c_Busca")
1830:                             USE IN cursor_4c_Busca
1831:                         ENDIF
1832: 
1833:                         loc_oBusca.Release()
1834:                     ENDIF

*-- Linhas 1872 a 1890:
1872: 
1873:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
1874:                             GO TOP IN cursor_4c_Busca
1875:                             SELECT cursor_4c_Busca
1876:                             loc_oPag2.txt_4c_Dpro.Value    = ALLTRIM(dpros)
1877:                             loc_oPag2.txt_4c__produto.Value = ALLTRIM(cpros)
1878:                             THIS.this_oBusinessObject.BuscarCabecalhoProduto(ALLTRIM(cpros))
1879:                             THIS.PreencherCabecalhoProduto()
1880:                             THIS.AcertarGridPorProduto(ALLTRIM(cpros))
1881:                         ELSE
1882:                             loc_oPag2.txt_4c_Dpro.Value = ""
1883:                         ENDIF
1884: 
1885:                         IF USED("cursor_4c_Busca")
1886:                             USE IN cursor_4c_Busca
1887:                         ENDIF
1888: 
1889:                         loc_oBusca.Release()
1890:                     ENDIF

*-- Linhas 1935 a 1999:
1935:                     THIS.this_lTemTam    = THIS.this_oBusinessObject.this_lTemTam
1936:                     THIS.this_nTipoEstos = THIS.this_oBusinessObject.this_nTipoEstos
1937: 
1938:                     *-- Em modo INSERIR sem dados, garantir pelo menos uma linha em branco
1939:                     IF THIS.this_cPcEscolha = "INSERIR" AND ;
1940:                        (!USED("cursor_4c_MaxProduto") OR RECCOUNT("cursor_4c_MaxProduto") = 0)
1941:                         THIS.this_oBusinessObject.InserirLinhaCursorLocal(par_cCpros)
1942:                     ENDIF
1943: 
1944:                     THIS.VincularGridPage2()
1945:                 ENDIF
1946:             ENDIF
1947:         CATCH TO loException
1948:             MsgErro("Erro em AcertarGridPorProduto: " + loException.Message, "Erro")
1949:         ENDTRY
1950:     ENDPROC
1951: 
1952:     *==========================================================================
1953:     * VincularGridPage2 - Vincula cursor_4c_MaxProduto ao grd_4c_Dados (Page2)
1954:     * Problemas 34/36/48/32: reset RS -> ColumnCount fora WITH -> RS -> ControlSource -> Header
1955:     * Column3 (codtams): ReadOnly se produto nao tem tamanho
1956:     * Column4 (codcores): ReadOnly se produto nao tem cor
1957:     * CONSULTAR: todas as colunas ReadOnly
1958:     *==========================================================================
1959:     PROCEDURE VincularGridPage2()
1960:         LOCAL loc_oGrd, loc_lTemTam, loc_lTemCor, loc_lConsultar
1961: 
1962:         TRY
1963:             IF USED("cursor_4c_MaxProduto")
1964:                 loc_oGrd       = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
1965:                 loc_lTemTam    = THIS.this_lTemTam
1966:                 loc_lTemCor    = THIS.this_lTemCor
1967:                 loc_lConsultar = (THIS.this_cPcEscolha = "CONSULTAR")
1968: 
1969:                 *-- Problema 34: reset RecordSource antes de reconectar
1970:                 loc_oGrd.RecordSource = ""
1971: 
1972:                 *-- Problema 36: ColumnCount FORA de WITH
1973:                 loc_oGrd.ColumnCount = 5
1974: 
1975:                 *-- Reconectar RecordSource
1976:                 loc_oGrd.ColumnCount = 5
1977:                 loc_oGrd.RecordSource = "cursor_4c_MaxProduto"
1978: 
1979:                 *-- Problema 48: ControlSource APOS RecordSource
1980:                 loc_oGrd.Column1.ControlSource = "cursor_4c_MaxProduto.emps"
1981:                 loc_oGrd.Column2.ControlSource = "cursor_4c_MaxProduto.qmaxs"
1982:                 loc_oGrd.Column3.ControlSource = "cursor_4c_MaxProduto.codtams"
1983:                 loc_oGrd.Column4.ControlSource = "cursor_4c_MaxProduto.codcores"
1984:                 loc_oGrd.Column5.ControlSource = "cursor_4c_MaxProduto.deptos"
1985: 
1986:                 *-- Problema 32: Header captions APOS RecordSource
1987:                 loc_oGrd.Column1.Header1.Caption = "Emp"
1988:                 loc_oGrd.Column2.Header1.Caption = "Qtde. M" + CHR(225) + "x."
1989:                 loc_oGrd.Column3.Header1.Caption = "Tam"
1990:                 loc_oGrd.Column4.Header1.Caption = "Cor"
1991:                 loc_oGrd.Column5.Header1.Caption = "Departamento"
1992: 
1993:                 WITH loc_oGrd
1994:                     .Column1.Width = 40
1995:                     .Column2.Width = 80
1996:                     .Column3.Width = 70
1997:                     .Column4.Width = 70
1998:                     .Column5.Width = 100
1999:                 ENDWITH

*-- Linhas 2032 a 2296:
2032: 
2033:         TRY
2034:             IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
2035:                 *-- Nao processar fora do modo de edicao
2036:             ELSE
2037:                 IF USED("cursor_4c_MaxProduto") AND RECCOUNT("cursor_4c_MaxProduto") > 0 AND !EOF("cursor_4c_MaxProduto")
2038:                 SELECT cursor_4c_MaxProduto
2039:                 loc_cCpros    = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__produto.Value)
2040:                 loc_cEmps     = ALLTRIM(emps)
2041:                 loc_lConfirma = MsgConfirma("Excluir linha da empresa '" + loc_cEmps + "'?", ;
2042:                     "Confirmar Exclus" + CHR(227) + "o")
2043:             ELSE
2044:                 MsgAviso("Nenhuma linha selecionada para exclus" + CHR(227) + "o.", "Aviso")
2045:                 ENDIF
2046:             ENDIF
2047:         CATCH TO loException
2048:             MsgErro("Erro em BtnExcluirLinhaClick: " + loException.Message, "Erro")
2049:         ENDTRY
2050: 
2051:         IF loc_lConfirma AND !EMPTY(loc_cCpros) AND !EMPTY(loc_cEmps)
2052:             loc_lSucesso = THIS.this_oBusinessObject.ExcluirLinhaEmpresa(loc_cCpros, loc_cEmps)
2053: 
2054:             IF loc_lSucesso
2055:                 THIS.this_oBusinessObject.BuscarPorProduto(loc_cCpros)
2056: 
2057:                 IF !USED("cursor_4c_MaxProduto") OR RECCOUNT("cursor_4c_MaxProduto") = 0
2058:                     THIS.this_oBusinessObject.InserirLinhaCursorLocal(loc_cCpros)
2059:                 ENDIF
2060: 
2061:                 THIS.VincularGridPage2()
2062:             ENDIF
2063:         ENDIF
2064:     ENDPROC
2065: 
2066:     *==========================================================================
2067:     * GradeAfterRowColChangePage2 - Handler AfterRowColChange do grd_4c_Dados
2068:     * Atualiza ReadOnly de Column3/4 conforme flags lTemTam/lTemCor
2069:     *==========================================================================
2070:     PROCEDURE GradeAfterRowColChangePage2(par_nColIndex)
2071:         LOCAL loc_oGrd
2072: 
2073:         TRY
2074:             IF THIS.this_cPcEscolha != "CONSULTAR" AND USED("cursor_4c_MaxProduto")
2075:                 loc_oGrd = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
2076:                 loc_oGrd.Column3.ReadOnly = !THIS.this_lTemTam
2077:                 loc_oGrd.Column4.ReadOnly = !THIS.this_lTemCor
2078:                 loc_oGrd.Refresh
2079:             ENDIF
2080:         CATCH TO loException
2081:             MsgErro("Erro em GradeAfterRowColChangePage2: " + loException.Message, "Erro")
2082:         ENDTRY
2083:     ENDPROC
2084: 
2085:     *==========================================================================
2086:     * GradeKeyPressPage2 - Handler KeyPress do grd_4c_Dados (Page2)
2087:     * F4(28): abre lookup de Tamanho(col3)/Cor(col4)/Departamento(col5)
2088:     * Tab(9) em col5 na ultima linha: insere nova linha via MNovaLinha
2089:     *==========================================================================
2090:     PROCEDURE GradeKeyPressPage2(par_nKeyCode, par_nShiftAltCtrl)
2091:         LOCAL loc_oGrd, loc_nCol, loc_lUltimaLinha
2092: 
2093:         TRY
2094:             IF THIS.this_cPcEscolha != "CONSULTAR" AND USED("cursor_4c_MaxProduto")
2095:                 loc_oGrd = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
2096:                 loc_nCol = loc_oGrd.ActiveColumn
2097: 
2098:                 DO CASE
2099:                 CASE par_nKeyCode = 28 AND loc_nCol = 3 AND THIS.this_lTemTam
2100:                     THIS.AbrirLookupTamanhoGrid()
2101:                     NODEFAULT
2102: 
2103:                 CASE par_nKeyCode = 28 AND loc_nCol = 4 AND THIS.this_lTemCor
2104:                     THIS.AbrirLookupCorGrid()
2105:                     NODEFAULT
2106: 
2107:                 CASE par_nKeyCode = 28 AND loc_nCol = 5
2108:                     THIS.AbrirLookupDepartamentoGrid()
2109:                     NODEFAULT
2110: 
2111:                 CASE par_nKeyCode = 9 AND loc_nCol = 5
2112:                     SELECT cursor_4c_MaxProduto
2113:                     loc_lUltimaLinha = (RECNO() = RECCOUNT())
2114:                     IF loc_lUltimaLinha
2115:                         THIS.MNovaLinha()
2116:                         NODEFAULT
2117:                     ENDIF
2118:                 ENDCASE
2119:             ENDIF
2120:         CATCH TO loException
2121:             MsgErro("Erro em GradeKeyPressPage2: " + loException.Message, "Erro")
2122:         ENDTRY
2123:     ENDPROC
2124: 
2125:     *==========================================================================
2126:     * AbrirLookupTamanhoGrid - Abre FormBuscaAuxiliar para SigCdTam (coluna 3)
2127:     * Colunas: cods (codigo), descs (descricao)
2128:     *==========================================================================
2129:     PROCEDURE AbrirLookupTamanhoGrid()
2130:         LOCAL loc_oForm, loc_cValAtual
2131: 
2132:         TRY
2133:             IF USED("cursor_4c_MaxProduto")
2134:                 SELECT cursor_4c_MaxProduto
2135:                 loc_cValAtual = ALLTRIM(codtams)
2136: 
2137:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2138:                     "SigCdTam", "cursor_4c_BuscaTam", "cods", loc_cValAtual, ;
2139:                     "Tamanhos")
2140: 
2141:                 IF VARTYPE(loc_oForm) = "O"
2142:                     IF !loc_oForm.this_lAchouRegistro
2143:                         loc_oForm.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
2144:                         loc_oForm.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2145:                         loc_oForm.Show()
2146:                     ENDIF
2147: 
2148:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaTam")
2149:                         GO TOP IN cursor_4c_BuscaTam
2150:                         SELECT cursor_4c_BuscaTam
2151:                         loc_cValAtual = ALLTRIM(cods)
2152: 
2153:                         SELECT cursor_4c_MaxProduto
2154:                         REPLACE codtams WITH loc_cValAtual
2155:                     ENDIF
2156: 
2157:                     IF USED("cursor_4c_BuscaTam")
2158:                         USE IN cursor_4c_BuscaTam
2159:                     ENDIF
2160: 
2161:                     loc_oForm.Release()
2162:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh
2163:                 ENDIF
2164:             ENDIF
2165:         CATCH TO loException
2166:             MsgErro("Erro em AbrirLookupTamanhoGrid: " + loException.Message, "Erro")
2167:         ENDTRY
2168:     ENDPROC
2169: 
2170:     *==========================================================================
2171:     * AbrirLookupCorGrid - Abre FormBuscaAuxiliar para SigCdCor (coluna 4)
2172:     * Colunas: cods (codigo), descs (descricao)
2173:     *==========================================================================
2174:     PROCEDURE AbrirLookupCorGrid()
2175:         LOCAL loc_oForm, loc_cValAtual
2176: 
2177:         TRY
2178:             IF USED("cursor_4c_MaxProduto")
2179:                 SELECT cursor_4c_MaxProduto
2180:                 loc_cValAtual = ALLTRIM(codcores)
2181: 
2182:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2183:                     "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cValAtual, ;
2184:                     "Cores")
2185: 
2186:                 IF VARTYPE(loc_oForm) = "O"
2187:                     IF !loc_oForm.this_lAchouRegistro
2188:                         loc_oForm.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
2189:                         loc_oForm.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2190:                         loc_oForm.Show()
2191:                     ENDIF
2192: 
2193:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCor")
2194:                         GO TOP IN cursor_4c_BuscaCor
2195:                         SELECT cursor_4c_BuscaCor
2196:                         loc_cValAtual = ALLTRIM(cods)
2197: 
2198:                         SELECT cursor_4c_MaxProduto
2199:                         REPLACE codcores WITH loc_cValAtual
2200:                     ENDIF
2201: 
2202:                     IF USED("cursor_4c_BuscaCor")
2203:                         USE IN cursor_4c_BuscaCor
2204:                     ENDIF
2205: 
2206:                     loc_oForm.Release()
2207:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh
2208:                 ENDIF
2209:             ENDIF
2210:         CATCH TO loException
2211:             MsgErro("Erro em AbrirLookupCorGrid: " + loException.Message, "Erro")
2212:         ENDTRY
2213:     ENDPROC
2214: 
2215:     *==========================================================================
2216:     * AbrirLookupDepartamentoGrid - Abre FormBuscaAuxiliar para SigCdDpt (coluna 5)
2217:     * Colunas: codigos (codigo), Descricaos (descricao)
2218:     *==========================================================================
2219:     PROCEDURE AbrirLookupDepartamentoGrid()
2220:         LOCAL loc_oForm, loc_cValAtual
2221: 
2222:         TRY
2223:             IF USED("cursor_4c_MaxProduto")
2224:                 SELECT cursor_4c_MaxProduto
2225:                 loc_cValAtual = ALLTRIM(deptos)
2226: 
2227:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2228:                     "SigCdDpt", "cursor_4c_BuscaDpt", "codigos", loc_cValAtual, ;
2229:                     "Departamentos")
2230: 
2231:                 IF VARTYPE(loc_oForm) = "O"
2232:                     IF !loc_oForm.this_lAchouRegistro
2233:                         loc_oForm.mAddColuna("codigos",    "", "C" + CHR(243) + "d.")
2234:                         loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2235:                         loc_oForm.Show()
2236:                     ENDIF
2237: 
2238:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaDpt")
2239:                         GO TOP IN cursor_4c_BuscaDpt
2240:                         SELECT cursor_4c_BuscaDpt
2241:                         loc_cValAtual = ALLTRIM(codigos)
2242: 
2243:                         SELECT cursor_4c_MaxProduto
2244:                         REPLACE deptos WITH PADR(loc_cValAtual, 10)
2245:                     ENDIF
2246: 
2247:                     IF USED("cursor_4c_BuscaDpt")
2248:                         USE IN cursor_4c_BuscaDpt
2249:                     ENDIF
2250: 
2251:                     loc_oForm.Release()
2252:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh
2253:                 ENDIF
2254:             ENDIF
2255:         CATCH TO loException
2256:             MsgErro("Erro em AbrirLookupDepartamentoGrid: " + loException.Message, "Erro")
2257:         ENDTRY
2258:     ENDPROC
2259: 
2260:     *==========================================================================
2261:     * MNovaLinha - Insere nova linha em branco no cursor_4c_MaxProduto
2262:     * Chamado pelo Tab na ultima coluna da ultima linha do grid
2263:     *==========================================================================
2264:     PROCEDURE MNovaLinha()
2265:         LOCAL loc_cCpros, loc_oGrd
2266: 
2267:         TRY
2268:             loc_cCpros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__produto.Value)
2269: 
2270:             IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
2271:                 *-- Nao inserir linha em modo leitura
2272:             ELSE
2273:                 IF EMPTY(loc_cCpros)
2274:                 MsgAviso("Selecione um produto antes de adicionar linha.", "Aviso")
2275:             ELSE
2276:                 THIS.this_oBusinessObject.InserirLinhaCursorLocal(loc_cCpros)
2277: 
2278:                 IF USED("cursor_4c_MaxProduto")
2279:                     GO BOTTOM IN cursor_4c_MaxProduto
2280:                     loc_oGrd = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
2281:                     loc_oGrd.ActivateCell(RECNO("cursor_4c_MaxProduto"), 1)
2282:                     loc_oGrd.Refresh
2283:                 ENDIF
2284:                 ENDIF
2285:             ENDIF
2286:         CATCH TO loException
2287:             MsgErro("Erro em MNovaLinha: " + loException.Message, "Erro")
2288:         ENDTRY
2289:     ENDPROC
2290: 
2291:     *==========================================================================
2292:     * LimparPage2 - Limpa campos da Page2 (chamado em modo INSERIR)
2293:     *==========================================================================
2294:     PROCEDURE LimparPage2()
2295:         LOCAL loc_oPag2
2296: 

*-- Linhas 2305 a 2335:
2305:             loc_oPag2.txt_4c_Dfor.Value         = ""
2306:             loc_oPag2.txt_4c_Refs.Value         = ""
2307:             loc_oPag2.obj_4c_Opc_situacao.Value = 1
2308:             loc_oPag2.grd_4c_Dados.RecordSource = ""
2309: 
2310:             IF USED("cursor_4c_MaxProduto")
2311:                 USE IN cursor_4c_MaxProduto
2312:             ENDIF
2313:         CATCH TO loException
2314:             MsgErro("Erro em LimparPage2: " + loException.Message, "Erro")
2315:         ENDTRY
2316:     ENDPROC
2317: 
2318:     *==========================================================================
2319:     * FormParaBO - Transfere campos do form para o Business Object
2320:     * Neste form especial, a edicao acontece no grid (cursor_4c_MaxProduto).
2321:     * FormParaBO captura o produto selecionado e as flags de modo.
2322:     *==========================================================================
2323:     PROCEDURE FormParaBO()
2324:         LOCAL loc_oPag2
2325:         loc_oPag2 = .NULL.
2326: 
2327:         TRY
2328:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2329: 
2330:             WITH THIS.this_oBusinessObject
2331:                 .this_cCpros     = ALLTRIM(loc_oPag2.txt_4c__produto.Value)
2332:                 .this_cDpros     = ALLTRIM(loc_oPag2.txt_4c_Dpro.Value)
2333:                 .this_cCgrus     = ALLTRIM(loc_oPag2.txt_4c_Cgru.Value)
2334:                 .this_cDgrus     = ALLTRIM(loc_oPag2.txt_4c_Dgru.Value)
2335:                 .this_cIfors     = ALLTRIM(loc_oPag2.txt_4c_Ifor.Value)

*-- Linhas 2468 a 2486:
2468: 
2469:         *-- Fechar cursores de dados abertos
2470:         IF USED("cursor_4c_Dados")
2471:             USE IN cursor_4c_Dados
2472:         ENDIF
2473:         IF USED("cursor_4c_MaxProduto")
2474:             USE IN cursor_4c_MaxProduto
2475:         ENDIF
2476:         IF USED("cursor_4c_Copia")
2477:             USE IN cursor_4c_Copia
2478:         ENDIF
2479:         IF USED("cursor_4c_Cabecalho")
2480:             USE IN cursor_4c_Cabecalho
2481:         ENDIF
2482: 
2483:         DODEFAULT()
2484:     ENDPROC
2485: 
2486: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprcomBO.prg):
*==============================================================================
* sigprcomBO.prg - Business Object: Estoque M?ximo
* Tabela: SigCdMax
* PK: cidchaves (CHAR 20 - UUID)
* Autor: Migra??o VFP9 - task165
*==============================================================================

*------------------------------------------------------------------------------
* DEFINE CLASS sigprcomBO AS BusinessBase
*------------------------------------------------------------------------------
DEFINE CLASS sigprcomBO AS BusinessBase

    *-- Propriedades da tabela SigCdMax (schema.sql)
    this_cCidchaves = ""    && cidchaves CHAR(20) PK - UUID
    this_cCpros     = ""    && cpros     CHAR(14) - C?digo do produto
    this_cEmps      = ""    && emps      CHAR(3)  - C?digo da empresa
    this_nQmaxs     = 0     && qmaxs     NUMERIC(7,2) - Qtde. m?xima
    this_cCodtams   = ""    && codtams   CHAR(4)  - C?digo do tamanho
    this_cCodcores  = ""    && codcores  CHAR(4)  - C?digo da cor
    this_cDeptos    = ""    && deptos    CHAR(10) - C?digo do departamento
    this_cOrdems    = ""    && ordems    CHAR(1)  - Ordem

    *-- Propriedades de exibi??o (joins com SigCdPro, SigCdCli, SigCdGrp)
    this_cDpros     = ""    && SigCdPro.dpros   - Descri??o do produto
    this_cIfors     = ""    && SigCdPro.ifors   - C?digo do fornecedor
    this_cReffs     = ""    && SigCdPro.reffs   - Refer?ncia do fornecedor
    this_cCgrus     = ""    && SigCdPro.cgrus   - C?digo do grupo
    this_nSituas    = 1     && SigCdPro.situas  - Situa??o (1=Ativo, 2=Inativo)
    this_cRclis     = ""    && SigCdCli.rclis   - Nome do fornecedor
    this_cDgrus     = ""    && SigCdGrp.dgrus   - Descri??o do grupo

    *-- Flags de configura??o do produto (carregados de SigCdPro/SigCdGrp)
    this_lTemCor    = .F.   && Produto tem controle de cor
    this_lTemTam    = .F.   && Produto tem controle de tamanho
    this_nTipoEstos = 0     && Tipo de estoque (SigCdGrp.tipoestos)

    *--------------------------------------------------------------------------
    * Init - Inicializa??o do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMax"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave prim?ria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista produtos com estoque m?ximo (SELECT principal da Page1)
    * par_cFiltro: filtro adicional WHERE (opcional)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("par_cFiltro") != "C"
            par_cFiltro = ""
        ENDIF

        TRY
            loc_cSQL = "SELECT a.cpros, b.dpros, b.ifors, b.reffs," + ;
                       " b.cgrus, b.situas, c.rclis, g.dgrus" + ;
                       " FROM SigCdMax a" + ;
                       " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                       " LEFT JOIN SigCdCli c ON b.ifors = c.iclis" + ;
                       " LEFT JOIN SigCdGrp g ON b.cgrus = g.cgrus"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + ;
                       " GROUP BY a.cpros, b.dpros, b.ifors, b.reffs," + ;
                       " b.cgrus, b.situas, c.rclis, g.dgrus"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Dados") = 0
                    GOTO TOP IN cursor_4c_Dados
                ELSE
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar produtos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorProduto - Carrega linhas de SigCdMax para um produto espec?fico
    * Popula cursor_4c_MaxProduto com emps/qmaxs/codtams/codcores/deptos
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorProduto(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("par_cCpros") != "C" OR EMPTY(ALLTRIM(par_cCpros))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT cidchaves, emps, qmaxs, codtams, codcores, deptos, ordems" + ;
                       " FROM SigCdMax" + ;
                       " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros)) + ;
                       " ORDER BY emps, codtams, codcores"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxProduto")

            IF loc_nResultado >= 0
                IF !EMPTY(ALLTRIM(par_cCpros))
                    THIS.CarregarFlagsTemCorTam(par_cCpros)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar estoque m?ximo: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarPorProduto: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCabecalhoProduto - Carrega dados do cabe?alho para um produto
    * Popula cursor_4c_Cabecalho com campos do produto + fornecedor + grupo
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCabecalhoProduto(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("par_cCpros") != "C" OR EMPTY(ALLTRIM(par_cCpros))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT DISTINCT" + ;
                       " a.cpros, b.dpros, b.ifors, b.reffs," + ;
                       " b.cgrus, b.situas, c.rclis, g.dgrus, a.qmaxs" + ;
                       " FROM SigCdMax a" + ;
                       " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                       " LEFT JOIN SigCdCli c ON b.ifors = c.iclis" + ;
                       " LEFT JOIN SigCdGrp g ON b.cgrus = g.cgrus" + ;
                       " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cabecalho")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Cabecalho") > 0
                    GO TOP IN cursor_4c_Cabecalho
                    SELECT cursor_4c_Cabecalho
                    THIS.this_cCpros   = ALLTRIM(cpros)
                    THIS.this_cDpros   = ALLTRIM(dpros)
                    THIS.this_cIfors   = ALLTRIM(ifors)
                    THIS.this_cRclis   = ALLTRIM(rclis)
                    THIS.this_cReffs   = ALLTRIM(reffs)
                    THIS.this_cCgrus   = ALLTRIM(cgrus)
                    THIS.this_cDgrus   = ALLTRIM(dgrus)
                    THIS.this_nSituas  = NVL(situas, 1)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar cabe?alho: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarCabecalhoProduto: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega uma linha de SigCdMax pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("par_cCidchaves") != "C" OR EMPTY(ALLTRIM(par_cCidchaves))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT cidchaves, cpros, emps, qmaxs, codtams," + ;
                       " codcores, deptos, ordems" + ;
                       " FROM SigCdMax" + ;
                       " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidchaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de um cursor
    * REGRA: SEMPRE usar SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
            THIS.this_cCpros     = TratarNulo(cpros,     "C")
            THIS.this_cEmps      = TratarNulo(emps,      "C")
            THIS.this_nQmaxs     = TratarNulo(qmaxs,     "N")
            THIS.this_cCodtams   = TratarNulo(codtams,   "C")
            THIS.this_cCodcores  = TratarNulo(codcores,  "C")
            THIS.this_cDeptos    = TratarNulo(deptos,    "C")
            THIS.this_cOrdems    = TratarNulo(ordems,    "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFlagsTemCorTam - Verifica se produto tem cor/tamanho ativos
    * Popula this_lTemCor, this_lTemTam, this_nTipoEstos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarFlagsTemCorTam(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        IF TYPE("par_cCpros") != "C" OR EMPTY(ALLTRIM(par_cCpros))
            THIS.this_lTemCor    = .F.
            THIS.this_lTemTam    = .F.
            THIS.this_nTipoEstos = 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT b.cores, b.tams, b.tipoestos" + ;
                       " FROM SigCdPro a" + ;
                       " INNER JOIN SigCdGrp b ON b.cgrus = a.cgrus" + ;
                       " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProGru")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProGru") > 0
                GO TOP IN cursor_4c_ProGru
                SELECT cursor_4c_ProGru
                THIS.this_nTipoEstos = NVL(tipoestos, 0)
                THIS.this_lTemCor = INLIST(THIS.this_nTipoEstos, 2, 4) OR NVL(cores, 0) = 1
                THIS.this_lTemTam = INLIST(THIS.this_nTipoEstos, 3, 4) OR NVL(tams, 0) = 1
                loc_lSucesso = .T.
            ELSE
                THIS.this_lTemCor    = .F.
                THIS.this_lTemTam    = .F.
                THIS.this_nTipoEstos = 0
            ENDIF

            IF USED("cursor_4c_ProGru")
                USE IN cursor_4c_ProGru
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarFlagsTemCorTam: " + loException.Message, "Erro")
            THIS.this_lTemCor    = .F.
            THIS.this_lTemTam    = .F.
            THIS.this_nTipoEstos = 0
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinhaCursorLocal - Insere nova linha no cursor local de estoque
    * Usado para adicionar linha vazia no grid (nova empresa)
    *--------------------------------------------------------------------------
    PROCEDURE InserirLinhaCursorLocal(par_cCpros)
        LOCAL loc_lSucesso, loc_cCidchave
        loc_lSucesso = .F.

        IF !USED("cursor_4c_MaxProduto")
            RETURN .F.
        ENDIF

        TRY

            loc_cCidchave = GerarUUID()

            INSERT INTO cursor_4c_MaxProduto ;
                (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems) ;
                VALUES (loc_cCidchave, par_cCpros, "", 0, "", "", "", "")

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em InserirLinhaCursorLocal: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarUUID - Gera identificador ?nico (substitui fUniqueIds do legado)
    *--------------------------------------------------------------------------
    PROCEDURE GerarUUID()
        RETURN SUBSTR(SYS(3), 1, 20)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir (PROTECTED) - Insere uma linha de SigCdMax no banco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Gerar cidchaves se vazio
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cCidchaves = THIS.GerarUUID()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdMax" + ;
                       " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                       " VALUES (" + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCidchaves), 20)) + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCpros),     14)) + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cEmps),       3)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nQmaxs)                  + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCodtams),    4)) + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCodcores),   4)) + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cDeptos),    10)) + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cOrdems),     1)) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Inserir: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar (PROTECTED) - Atualiza uma linha de SigCdMax no banco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMax SET" + ;
                       " emps    = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cEmps),     3)) + "," + ;
                       " qmaxs   = " + FormatarNumeroSQL(THIS.this_nQmaxs)               + "," + ;
                       " codtams = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCodtams),  4)) + "," + ;
                       " codcores= " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCodcores), 4)) + "," + ;
                       " deptos  = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cDeptos),  10)) + "," + ;
                       " ordems  = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cOrdems),   1)) + ;
                       " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao (PROTECTED) - Remove todas as linhas de um produto
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cCidchaves)) AND EMPTY(ALLTRIM(THIS.this_cCpros))
            MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o!")
            RETURN .F.
        ENDIF

        TRY

            *-- Excluir pelo cidchaves (linha espec?fica)
            IF !EMPTY(ALLTRIM(THIS.this_cCidchaves))
                loc_cSQL = "DELETE FROM SigCdMax" + ;
                           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))
            ELSE
                *-- Excluir todas as linhas do produto
                loc_cSQL = "DELETE FROM SigCdMax" + ;
                           " WHERE cpros = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCpros), 14))
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGridEstoque - Persiste o cursor_4c_MaxProduto no banco (UPDATE/INSERT)
    * Chamado ao salvar o grid de estoque m?ximo por produto
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGridEstoque(par_cCpros)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        IF TYPE("par_cCpros") != "C" OR EMPTY(ALLTRIM(par_cCpros))
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_MaxProduto")
            RETURN .F.
        ENDIF

        TRY
            *-- Remover linhas vazias (sem empresa) antes de salvar
            loc_cSQL = "DELETE FROM SigCdMax" + ;
                       " WHERE cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14)) + ;
                       " AND emps = '   '"
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Iterar sobre o cursor e salvar cada linha
            SELECT cursor_4c_MaxProduto
            GO TOP

            DO WHILE !EOF("cursor_4c_MaxProduto")
                SELECT cursor_4c_MaxProduto

                IF !EMPTY(ALLTRIM(emps))
                    THIS.this_cCidchaves = ALLTRIM(cidchaves)
                    THIS.this_cCpros     = PADR(ALLTRIM(par_cCpros), 14)
                    THIS.this_cEmps      = ALLTRIM(emps)
                    THIS.this_nQmaxs     = NVL(qmaxs, 0)
                    THIS.this_cCodtams   = ALLTRIM(codtams)
                    THIS.this_cCodcores  = ALLTRIM(codcores)
                    THIS.this_cDeptos    = ALLTRIM(deptos)
                    THIS.this_cOrdems    = ALLTRIM(ordems)

                    *-- Verificar se j? existe no banco
                    LOCAL loc_nCheck
                    loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdMax" + ;
                               " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
                    loc_nCheck = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Check")

                    LOCAL loc_lExiste
                    loc_lExiste = .F.
                    IF loc_nCheck >= 0 AND RECCOUNT("cursor_4c_Check") > 0
                        SELECT cursor_4c_Check
                        loc_lExiste = (NVL(qtd, 0) > 0)
                    ENDIF

                    IF USED("cursor_4c_Check")
                        USE IN cursor_4c_Check
                    ENDIF

                    IF loc_lExiste
                        THIS.this_lNovoRegistro = .F.
                    ELSE
                        THIS.this_lNovoRegistro = .T.
                        IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                            THIS.this_cCidchaves = THIS.GerarUUID()
                        ENDIF
                    ENDIF

                    IF !THIS.Salvar()
                        loc_lSucesso = .F.
                        EXIT
                    ENDIF
                ENDIF

                SELECT cursor_4c_MaxProduto
                SKIP
            ENDDO

            loc_lSucesso = .T.
            THIS.RegistrarAuditoria("SAVE_GRID")
        CATCH TO loException
            MsgErro("Erro em SalvarGridEstoque: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirLinhaEmpresa - Remove linha de estoque m?ximo de uma empresa
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirLinhaEmpresa(par_cCpros, par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("par_cCpros") != "C" OR EMPTY(ALLTRIM(par_cCpros))
            RETURN .F.
        ENDIF

        TRY
            IF EMPTY(ALLTRIM(par_cEmps))
                *-- Excluir todas as linhas do produto sem empresa
                loc_cSQL = "DELETE FROM SigCdMax" + ;
                           " WHERE cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14)) + ;
                           " AND RTRIM(emps) = ''"
            ELSE
                *-- Excluir linhas da empresa espec?fica
                loc_cSQL = "DELETE FROM SigCdMax" + ;
                           " WHERE cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14)) + ;
                           " AND emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmps), 3))
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir empresa: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExcluirLinhaEmpresa: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarEstoqueProduto - Copia registros de estoque entre empresas
    * par_cCpros: produto a copiar (vazio = todos)
    * par_cEmpO: empresa de origem
    * par_cEmpD: empresa de destino
    * Retorna n?mero de registros copiados
    *--------------------------------------------------------------------------
    PROCEDURE CopiarEstoqueProduto(par_cCpros, par_cEmpO, par_cEmpD)
        LOCAL loc_cSQL, loc_nResultado, loc_nCopiados, loc_lSucesso
        loc_lSucesso  = .F.
        loc_nCopiados = 0

        IF EMPTY(ALLTRIM(par_cEmpO)) OR EMPTY(ALLTRIM(par_cEmpD))
            MsgErro("Empresa origem e destino s" + CHR(227) + "o obrigat" + CHR(243) + "rias!", "Aviso")
            RETURN .F.
        ENDIF

        IF ALLTRIM(par_cEmpO) = ALLTRIM(par_cEmpD)
            MsgErro("Empresa destino n" + CHR(227) + "o pode ser igual " + CHR(224) + " empresa origem!", "Aviso")
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Copia")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Copia
            GO TOP

            DO WHILE !EOF("cursor_4c_Copia")
                SELECT cursor_4c_Copia

                IF NVL(marcas, 0) = 1 AND NVL(existes, 0) = 0
                    LOCAL loc_cNovoId
                    loc_cNovoId = THIS.GerarUUID()

                    loc_cSQL = "INSERT INTO SigCdMax" + ;
                               " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cNovoId)                              + "," + ;
                               EscaparSQL(PADR(ALLTRIM(cpros),       14))           + "," + ;
                               EscaparSQL(PADR(ALLTRIM(par_cEmpD),    3))           + "," + ;
                               FormatarNumeroSQL(NVL(qmaxs, 0))                     + "," + ;
                               EscaparSQL(PADR(ALLTRIM(codtams),      4))           + "," + ;
                               EscaparSQL(PADR(ALLTRIM(codcores),     4))           + "," + ;
                               EscaparSQL(PADR(ALLTRIM(deptos),      10))           + "," + ;
                               EscaparSQL(" ")                                      + ;
                               ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        loc_nCopiados = loc_nCopiados + 1
                    ENDIF
                ENDIF

                SKIP
            ENDDO

            loc_lSucesso = .T.
            THIS.RegistrarAuditoria("COPY")
        CATCH TO loException
            MsgErro("Erro em CopiarEstoqueProduto: " + loException.Message, "Erro")
        ENDTRY

        *-- Retornar n?mero de copiados via propriedade
        THIS.this_nQmaxs = loc_nCopiados

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCursorCopia - Carrega cursor_4c_Copia para copiar entre empresas
    * Mostra quais produtos existem na origem e compara com o destino
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCursorCopia(par_cCpros, par_cEmpO, par_cEmpD)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cEmpO)) OR EMPTY(ALLTRIM(par_cEmpD))
            RETURN .F.
        ENDIF

        TRY
            *-- Union: nao existem no destino | existem em ambos | existem no destino mas nao na origem
            loc_cSQL = "SELECT 1 AS marcas, 0 AS existes," + ;
                       " a.cpros, a.emps, a.qmaxs, a.codtams, a.codcores, a.deptos, a.cidchaves" + ;
                       " FROM SigCdMax a" + ;
                       " WHERE a.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpO), 3))

            IF !EMPTY(ALLTRIM(par_cCpros))
                loc_cSQL = loc_cSQL + " AND a.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14))
            ENDIF

            loc_cSQL = loc_cSQL + ;
                       " AND (a.cpros + a.codtams + a.codcores) NOT IN (" + ;
                       " SELECT b.cpros + b.codtams + b.codcores FROM SigCdMax b" + ;
                       " WHERE b.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3)) + ")" + ;
                       " UNION ALL" + ;
                       " SELECT 0 AS marcas, 1 AS existes," + ;
                       " a.cpros, a.emps, a.qmaxs, a.codtams, a.codcores, a.deptos, a.cidchaves" + ;
                       " FROM SigCdMax a" + ;
                       " WHERE a.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpO), 3))

            IF !EMPTY(ALLTRIM(par_cCpros))
                loc_cSQL = loc_cSQL + " AND a.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14))
            ENDIF

            loc_cSQL = loc_cSQL + ;
                       " AND a.cpros + a.codtams + a.codcores IN (" + ;
                       " SELECT b.cpros + b.codtams + b.codcores FROM SigCdMax b" + ;
                       " WHERE b.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3)) + ")" + ;
                       " UNION ALL" + ;
                       " SELECT 0 AS marcas, 2 AS existes," + ;
                       " a.cpros, a.emps, a.qmaxs, a.codtams, a.codcores, a.deptos, a.cidchaves" + ;
                       " FROM SigCdMax a" + ;
                       " WHERE a.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3))

            IF !EMPTY(ALLTRIM(par_cCpros))
                loc_cSQL = loc_cSQL + " AND a.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14))
            ENDIF

            loc_cSQL = loc_cSQL + ;
                       " AND a.cpros + a.codtams + a.codcores NOT IN (" + ;
                       " SELECT b.cpros + b.codtams + b.codcores FROM SigCdMax b" + ;
                       " WHERE b.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpO), 3)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Copia")

            IF loc_nResultado >= 0
                GO TOP IN cursor_4c_Copia
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar c" + CHR(243) + "pia: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarCursorCopia: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodosParaCopia - Marca/desmarca todos registros do cursor_4c_Copia
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodosParaCopia(par_lMarcar)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED("cursor_4c_Copia")
            RETURN .F.
        ENDIF

        TRY
            LOCAL loc_nMarca
            loc_nMarca = IIF(par_lMarcar, 1, 0)

            UPDATE cursor_4c_Copia SET marcas = loc_nMarca WHERE existes = 0

            GO TOP IN cursor_4c_Copia
            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em MarcarTodosParaCopia: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

