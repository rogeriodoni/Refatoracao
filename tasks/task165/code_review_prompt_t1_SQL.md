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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprcom.prg) - TRECHOS RELEVANTES PARA PASS SQL (2484 linhas total):

*-- Linhas 434 a 452:
434:             .RecordSource  = ""
435:             .Visible       = .T.
436:             .RecordMark   = .F.
437:             .DeleteMark   = .F.
438:         ENDWITH
439:         BINDEVENT(loc_oPag.grd_4c_Lista, "AfterRowColChange", THIS, "GridListaAfterRowColChange")
440: 
441:         *----------------------------------------------------------------------
442:         * Container flutuante de copia de produto entre empresas
443:         * Original cntCopia: Top=161, Left=256, Width=486, Height=373, visible=.F.
444:         * Com compensacao: Top = 161 + 29 = 190
445:         * BackStyle=1 (opaco) obrigatorio: BackStyle=0 sobre grid = ghost trails no scroll
446:         *----------------------------------------------------------------------
447:         loc_oPag.AddObject("cnt_4c_Copia", "Container")
448:         WITH loc_oPag.cnt_4c_Copia
449:             .Top           = 190
450:             .Left          = 256
451:             .Width         = 486
452:             .Height        = 373

*-- Linhas 748 a 766:
748:             .RecordSource  = ""
749:             .Visible       = .T.
750:             .RecordMark   = .F.
751:             .DeleteMark   = .F.
752:         ENDWITH
753: 
754:         *-- CheckBox na Column1 (Check1 original): marca registro para copia
755:         loc_oCopia.grd_4c_Dados.Column1.AddObject("chk_4c_Check1", "CheckBox")
756:         WITH loc_oCopia.grd_4c_Dados.Column1
757:             .CurrentControl = "chk_4c_Check1"
758:             .Sparse         = .F.
759:             .Width          = 30
760:             .ReadOnly       = .F.
761:         ENDWITH
762:         WITH loc_oCopia.grd_4c_Dados.Column1.chk_4c_Check1
763:             .Caption = ""
764:             .Width   = 25
765:             .Height  = 17
766:         ENDWITH

*-- Linhas 1100 a 1136:
1100:         * Top=181+29=210, Left=309, Width=387, Height=472, ColumnCount=5
1101:         * ReadOnly=.F.: usuario edita empresa/qtde/tamanho/cor/departamento
1102:         * Problema 36: ColumnCount FORA de WITH (colunas criadas imediatamente)
1103:         * RecordSource, ControlSource e Headers configurados em VincularGridPage2()
1104:         * Column3 (codtams): habilitado se this_lTemTam=.T.
1105:         * Column4 (codcores): habilitado se this_lTemCor=.T.
1106:         * F4 em Column3/4/5: abre lookup via GradeKeyPressPage2
1107:         *----------------------------------------------------------------------
1108:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
1109:         loc_oPag.grd_4c_Dados.ColumnCount = 5
1110:         WITH loc_oPag.grd_4c_Dados
1111:             .Top           = 210
1112:             .Left          = 309
1113:             .Width         = 387
1114:             .Height        = 472
1115:             .ReadOnly      = .F.
1116:             .FontName      = "Tahoma"
1117:             .FontSize      = 8
1118:             .GridLineColor = RGB(238, 238, 238)
1119:             .ForeColor     = RGB(90, 90, 90)
1120:             .RowHeight     = 16
1121:             .DeleteMark    = .F.
1122:             .RecordMark    = .F.
1123:             .ScrollBars    = 2
1124:             .RecordSource  = ""
1125:             .Visible       = .T.
1126:         ENDWITH
1127:         BINDEVENT(loc_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChangePage2")
1128:         BINDEVENT(loc_oPag.grd_4c_Dados, "KeyPress", THIS, "GradeKeyPressPage2")
1129: 
1130:         *-- Tornar controles visiveis
1131:         THIS.TornarControlesVisiveis(loc_oPag)
1132:     ENDPROC
1133: 
1134:     *==========================================================================
1135:     * CarregarLista - Carrega dados e vincula ao grid da Page1
1136:     *==========================================================================

*-- Linhas 1209 a 1254:
1209: 
1210:     *==========================================================================
1211:     * VincularGridLista - Vincula cursor_4c_Dados ao grd_4c_Lista
1212:     * Problemas 34/36/48/32: reset RS -> ColumnCount fora WITH -> RS -> ControlSource -> Header
1213:     *==========================================================================
1214:     PROCEDURE VincularGridLista()
1215:         LOCAL loc_oGrd
1216: 
1217:         TRY
1218:             IF USED("cursor_4c_Dados")
1219:                 loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1220: 
1221:                 *-- Problema 34: reset RecordSource antes de reconectar
1222:                 loc_oGrd.RecordSource = ""
1223: 
1224:                 *-- Problema 36: ColumnCount FORA de WITH
1225:                 loc_oGrd.ColumnCount = 7
1226: 
1227:                 *-- Reconectar RecordSource
1228:                 loc_oGrd.ColumnCount = 3
1229:                 loc_oGrd.RecordSource = "cursor_4c_Dados"
1230: 
1231:                 *-- Problema 48: ControlSource APOS RecordSource
1232:                 WITH loc_oGrd
1233:                     .Column1.ControlSource = "cursor_4c_Dados.cpros"
1234:                     .Column2.ControlSource = "cursor_4c_Dados.dpros"
1235:                     .Column3.ControlSource = "cursor_4c_Dados.rclis"
1236:                     .Column4.ControlSource = "cursor_4c_Dados.ifors"
1237:                     .Column5.ControlSource = "cursor_4c_Dados.reffs"
1238:                     .Column6.ControlSource = "cursor_4c_Dados.cgrus"
1239:                     .Column7.ControlSource = "cursor_4c_Dados.dgrus"
1240:                 ENDWITH
1241: 
1242:                 *-- Problema 32: Header captions APOS RecordSource
1243:                 loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
1244:                 loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1245:                 loc_oGrd.Column3.Header1.Caption = "Raz" + CHR(227) + "o Social"
1246:                 loc_oGrd.Column4.Header1.Caption = "Fornecedor"
1247:                 loc_oGrd.Column5.Header1.Caption = "Refer" + CHR(234) + "ncia"
1248:                 loc_oGrd.Column6.Header1.Caption = "Grupo"
1249:                 loc_oGrd.Column7.Header1.Caption = "Desc. Grupo"
1250: 
1251:                 *-- Larguras das colunas (total = 950, cabe em Width=971)
1252:                 WITH loc_oGrd
1253:                     .Column1.Width = 100
1254:                     .Column2.Width = 280

*-- Linhas 1319 a 1337:
1319: 
1320:         TRY
1321:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
1322:                 SELECT cursor_4c_Dados
1323:                 loc_cCpros   = ALLTRIM(cpros)
1324:                 loc_lSucesso = THIS.this_oBusinessObject.BuscarCabecalhoProduto(loc_cCpros)
1325: 
1326:                 IF loc_lSucesso
1327:                     loc_lSucesso = THIS.this_oBusinessObject.BuscarPorProduto(loc_cCpros)
1328:                 ENDIF
1329: 
1330:                 IF loc_lSucesso
1331:                     THIS.this_lTemCor    = THIS.this_oBusinessObject.this_lTemCor
1332:                     THIS.this_lTemTam    = THIS.this_oBusinessObject.this_lTemTam
1333:                     THIS.this_nTipoEstos = THIS.this_oBusinessObject.this_nTipoEstos
1334:                     THIS.this_cPcEscolha = "CONSULTAR"
1335:                     THIS.pgf_4c_Paginas.Page2.txt_4c__produto.Value    = ALLTRIM(loc_cCpros)
1336:                     THIS.PreencherCabecalhoProduto()
1337:                     THIS.VincularGridPage2()

*-- Linhas 1356 a 1374:
1356: 
1357:         TRY
1358:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
1359:                 SELECT cursor_4c_Dados
1360:                 loc_cCpros   = ALLTRIM(cpros)
1361:                 loc_lSucesso = THIS.this_oBusinessObject.BuscarCabecalhoProduto(loc_cCpros)
1362: 
1363:                 IF loc_lSucesso
1364:                     loc_lSucesso = THIS.this_oBusinessObject.BuscarPorProduto(loc_cCpros)
1365:                 ENDIF
1366: 
1367:                 IF loc_lSucesso
1368:                     THIS.this_lTemCor    = THIS.this_oBusinessObject.this_lTemCor
1369:                     THIS.this_lTemTam    = THIS.this_oBusinessObject.this_lTemTam
1370:                     THIS.this_nTipoEstos = THIS.this_oBusinessObject.this_nTipoEstos
1371:                     THIS.this_cPcEscolha = "ALTERAR"
1372:                     THIS.pgf_4c_Paginas.Page2.txt_4c__produto.Value    = ALLTRIM(loc_cCpros)
1373:                     THIS.PreencherCabecalhoProduto()
1374:                     THIS.VincularGridPage2()

*-- Linhas 1394 a 1412:
1394: 
1395:         TRY
1396:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
1397:                 SELECT cursor_4c_Dados
1398:                 loc_cCpros    = ALLTRIM(cpros)
1399:                 loc_lConfirma = MsgConfirma("Excluir todos os registros do produto " + loc_cCpros + "?", ;
1400:                     "Confirmar Exclus" + CHR(227) + "o")
1401:             ELSE
1402:                 MsgAviso("Selecione um produto para excluir.", "Aviso")
1403:             ENDIF
1404:         CATCH TO loException
1405:             MsgErro("Erro em BtnExcluirClick: " + loException.Message, "Erro")
1406:         ENDTRY
1407: 
1408:         IF loc_lConfirma
1409:             THIS.this_oBusinessObject.this_cCidchaves = ""
1410:             THIS.this_oBusinessObject.this_cCpros     = loc_cCpros
1411:             loc_lSucesso = THIS.this_oBusinessObject.Excluir()
1412: 

*-- Linhas 1437 a 1456:
1437: 
1438:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_Busca")
1439:                     GO TOP IN cursor_4c_Busca
1440:                     SELECT cursor_4c_Busca
1441:                     loc_cFiltro = "a.cpros = " + EscaparSQL(ALLTRIM(cpros))
1442:                 ENDIF
1443: 
1444:                 IF USED("cursor_4c_Busca")
1445:                     USE IN cursor_4c_Busca
1446:                 ENDIF
1447: 
1448:                 loc_oForm.Release()
1449:             ENDIF
1450:         CATCH TO loException
1451:             MsgErro("Erro em BtnBuscarClick: " + loException.Message, "Erro")
1452:         ENDTRY
1453: 
1454:         *-- Recarregar lista com filtro (vazio = todos os produtos)
1455:         THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1456:         THIS.VincularGridLista()

*-- Linhas 1503 a 1524:
1503:                 .grd_4c_Dados.RecordSource = ""
1504:                 .cmd_4c_Marcar.Visible    = .F.
1505:                 .cmd_4c_Desmarcar.Visible = .F.
1506:             ENDWITH
1507: 
1508:             IF USED("cursor_4c_Copia")
1509:                 USE IN cursor_4c_Copia
1510:             ENDIF
1511:         CATCH TO loException
1512:             MsgErro("Erro em CmdSairCopiaClick: " + loException.Message, "Erro")
1513:         ENDTRY
1514:     ENDPROC
1515: 
1516:     *==========================================================================
1517:     * EmpOrigLostFocus - Habilita/desabilita campo Empresa Destino
1518:     *==========================================================================
1519:     PROCEDURE EmpOrigLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1520:         LOCAL loc_oCopia
1521: 
1522:         TRY
1523:             loc_oCopia = THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia
1524: 

*-- Linhas 1562 a 1637:
1562: 
1563:         TRY
1564:             loc_oCopia = THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia
1565:             loc_cProd  = ALLTRIM(loc_oCopia.txt_4c_Produto.Value)
1566: 
1567:             IF !EMPTY(loc_cProd) AND USED("cursor_4c_Copia")
1568:                 SELECT cursor_4c_Copia
1569:                 SET NEAR ON
1570:                 SEEK loc_cProd
1571:                 SET NEAR OFF
1572:                 loc_oCopia.grd_4c_Dados.Refresh
1573:             ENDIF
1574:         CATCH TO loException
1575:             MsgErro("Erro em ProdutoCopiaLostFocus: " + loException.Message, "Erro")
1576:         ENDTRY
1577:     ENDPROC
1578: 
1579:     *==========================================================================
1580:     * CmdProcessaClick - Carrega cursor_4c_Copia e vincula ao grd_4c_Dados
1581:     * Problemas 34/36/48/32 aplicados ao grd_4c_Dados
1582:     *==========================================================================
1583:     PROCEDURE CmdProcessaClick()
1584:         LOCAL loc_oCopia, loc_cEmpO, loc_cEmpD, loc_cProd, loc_oGrd, loc_lSucesso
1585:         loc_lSucesso = .F.
1586: 
1587:         TRY
1588:             loc_oCopia = THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia
1589:             loc_cEmpO  = ALLTRIM(loc_oCopia.txt_4c_EmpOs.Value)
1590:             loc_cEmpD  = ALLTRIM(loc_oCopia.txt_4c_EmpDs.Value)
1591:             loc_cProd  = ALLTRIM(loc_oCopia.txt_4c_Produto.Value)
1592: 
1593:             IF EMPTY(loc_cEmpO)
1594:                 MsgAviso("Digite uma Empresa de Origem para realizar a C" + CHR(243) + "pia!", "Aviso")
1595:                 loc_oCopia.txt_4c_EmpOs.SetFocus
1596:             ELSE
1597:                 IF EMPTY(loc_cEmpD)
1598:                     MsgAviso("Digite uma Empresa de Destino para realizar a C" + CHR(243) + "pia!", "Aviso")
1599:                     loc_oCopia.txt_4c_EmpDs.SetFocus
1600:                 ELSE
1601:                     loc_lSucesso = THIS.this_oBusinessObject.CarregarCursorCopia(loc_cProd, loc_cEmpO, loc_cEmpD)
1602: 
1603:                     IF loc_lSucesso AND USED("cursor_4c_Copia")
1604:                         loc_oGrd = loc_oCopia.grd_4c_Dados
1605: 
1606:                         *-- Problema 34: reset antes de reconectar
1607:                         loc_oGrd.RecordSource = ""
1608: 
1609:                         *-- Problema 36: ColumnCount FORA de WITH
1610:                         loc_oGrd.ColumnCount = 6
1611: 
1612:                         *-- Reconectar RecordSource
1613:                         loc_oGrd.ColumnCount = 6
1614:                         loc_oGrd.RecordSource = "cursor_4c_Copia"
1615: 
1616:                         *-- Problema 48: ControlSource APOS RecordSource
1617:                         loc_oGrd.Column1.ControlSource = "cursor_4c_Copia.marcas"
1618:                         loc_oGrd.Column2.ControlSource = "cursor_4c_Copia.cpros"
1619:                         loc_oGrd.Column3.ControlSource = "cursor_4c_Copia.qmaxs"
1620:                         loc_oGrd.Column4.ControlSource = "cursor_4c_Copia.codtams"
1621:                         loc_oGrd.Column5.ControlSource = "cursor_4c_Copia.codcores"
1622:                         loc_oGrd.Column6.ControlSource = "cursor_4c_Copia.deptos"
1623: 
1624:                         *-- Problema 32: Header captions APOS RecordSource
1625:                         loc_oGrd.Column1.Header1.Caption = ""
1626:                         loc_oGrd.Column2.Header1.Caption = "Produto"
1627:                         loc_oGrd.Column3.Header1.Caption = "Qtde. M" + CHR(225) + "x."
1628:                         loc_oGrd.Column4.Header1.Caption = "Tam"
1629:                         loc_oGrd.Column5.Header1.Caption = "Cor"
1630:                         loc_oGrd.Column6.Header1.Caption = "Departamento"
1631: 
1632:                         WITH loc_oGrd
1633:                             .Column1.Width = 30
1634:                             .Column2.Width = 100
1635:                             .Column3.Width = 70
1636:                             .Column4.Width = 50
1637:                             .Column5.Width = 50

*-- Linhas 1680 a 1712:
1680:             THIS.CmdSairCopiaClick()
1681:         ENDIF
1682:     ENDPROC
1683: 
1684:     *==========================================================================
1685:     * CmdMarcarClick - Marca todos os registros eleg?veis no cursor_4c_Copia
1686:     *==========================================================================
1687:     PROCEDURE CmdMarcarClick()
1688:         TRY
1689:             THIS.this_oBusinessObject.MarcarTodosParaCopia(.T.)
1690:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia.grd_4c_Dados.Refresh
1691:         CATCH TO loException
1692:             MsgErro("Erro em CmdMarcarClick: " + loException.Message, "Erro")
1693:         ENDTRY
1694:     ENDPROC
1695: 
1696:     *==========================================================================
1697:     * CmdDesmarcarClick - Desmarca todos os registros no cursor_4c_Copia
1698:     *==========================================================================
1699:     PROCEDURE CmdDesmarcarClick()
1700:         TRY
1701:             THIS.this_oBusinessObject.MarcarTodosParaCopia(.F.)
1702:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia.grd_4c_Dados.Refresh
1703:         CATCH TO loException
1704:             MsgErro("Erro em CmdDesmarcarClick: " + loException.Message, "Erro")
1705:         ENDTRY
1706:     ENDPROC
1707: 
1708:     *==========================================================================
1709:     * GridListaAfterRowColChange - Handler AfterRowColChange do grd_4c_Lista
1710:     * BINDEVENT exige parametro declarado no handler
1711:     *==========================================================================
1712:     PROCEDURE GridListaAfterRowColChange(par_nColIndex)

*-- Linhas 1814 a 1832:
1814: 
1815:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
1816:                             GO TOP IN cursor_4c_Busca
1817:                             SELECT cursor_4c_Busca
1818:                             loc_oPag2.txt_4c__produto.Value = ALLTRIM(cpros)
1819:                             loc_oPag2.txt_4c_Dpro.Value     = ALLTRIM(dpros)
1820:                             THIS.this_oBusinessObject.BuscarCabecalhoProduto(ALLTRIM(cpros))
1821:                             THIS.PreencherCabecalhoProduto()
1822:                             THIS.AcertarGridPorProduto(ALLTRIM(cpros))
1823:                         ELSE
1824:                             loc_oPag2.txt_4c__produto.Value = ""
1825:                         ENDIF
1826: 
1827:                         IF USED("cursor_4c_Busca")
1828:                             USE IN cursor_4c_Busca
1829:                         ENDIF
1830: 
1831:                         loc_oBusca.Release()
1832:                     ENDIF

*-- Linhas 1870 a 1888:
1870: 
1871:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
1872:                             GO TOP IN cursor_4c_Busca
1873:                             SELECT cursor_4c_Busca
1874:                             loc_oPag2.txt_4c_Dpro.Value    = ALLTRIM(dpros)
1875:                             loc_oPag2.txt_4c__produto.Value = ALLTRIM(cpros)
1876:                             THIS.this_oBusinessObject.BuscarCabecalhoProduto(ALLTRIM(cpros))
1877:                             THIS.PreencherCabecalhoProduto()
1878:                             THIS.AcertarGridPorProduto(ALLTRIM(cpros))
1879:                         ELSE
1880:                             loc_oPag2.txt_4c_Dpro.Value = ""
1881:                         ENDIF
1882: 
1883:                         IF USED("cursor_4c_Busca")
1884:                             USE IN cursor_4c_Busca
1885:                         ENDIF
1886: 
1887:                         loc_oBusca.Release()
1888:                     ENDIF

*-- Linhas 1933 a 1997:
1933:                     THIS.this_lTemTam    = THIS.this_oBusinessObject.this_lTemTam
1934:                     THIS.this_nTipoEstos = THIS.this_oBusinessObject.this_nTipoEstos
1935: 
1936:                     *-- Em modo INSERIR sem dados, garantir pelo menos uma linha em branco
1937:                     IF THIS.this_cPcEscolha = "INSERIR" AND ;
1938:                        (!USED("cursor_4c_MaxProduto") OR RECCOUNT("cursor_4c_MaxProduto") = 0)
1939:                         THIS.this_oBusinessObject.InserirLinhaCursorLocal(par_cCpros)
1940:                     ENDIF
1941: 
1942:                     THIS.VincularGridPage2()
1943:                 ENDIF
1944:             ENDIF
1945:         CATCH TO loException
1946:             MsgErro("Erro em AcertarGridPorProduto: " + loException.Message, "Erro")
1947:         ENDTRY
1948:     ENDPROC
1949: 
1950:     *==========================================================================
1951:     * VincularGridPage2 - Vincula cursor_4c_MaxProduto ao grd_4c_Dados (Page2)
1952:     * Problemas 34/36/48/32: reset RS -> ColumnCount fora WITH -> RS -> ControlSource -> Header
1953:     * Column3 (codtams): ReadOnly se produto nao tem tamanho
1954:     * Column4 (codcores): ReadOnly se produto nao tem cor
1955:     * CONSULTAR: todas as colunas ReadOnly
1956:     *==========================================================================
1957:     PROCEDURE VincularGridPage2()
1958:         LOCAL loc_oGrd, loc_lTemTam, loc_lTemCor, loc_lConsultar
1959: 
1960:         TRY
1961:             IF USED("cursor_4c_MaxProduto")
1962:                 loc_oGrd       = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
1963:                 loc_lTemTam    = THIS.this_lTemTam
1964:                 loc_lTemCor    = THIS.this_lTemCor
1965:                 loc_lConsultar = (THIS.this_cPcEscolha = "CONSULTAR")
1966: 
1967:                 *-- Problema 34: reset RecordSource antes de reconectar
1968:                 loc_oGrd.RecordSource = ""
1969: 
1970:                 *-- Problema 36: ColumnCount FORA de WITH
1971:                 loc_oGrd.ColumnCount = 5
1972: 
1973:                 *-- Reconectar RecordSource
1974:                 loc_oGrd.ColumnCount = 5
1975:                 loc_oGrd.RecordSource = "cursor_4c_MaxProduto"
1976: 
1977:                 *-- Problema 48: ControlSource APOS RecordSource
1978:                 loc_oGrd.Column1.ControlSource = "cursor_4c_MaxProduto.emps"
1979:                 loc_oGrd.Column2.ControlSource = "cursor_4c_MaxProduto.qmaxs"
1980:                 loc_oGrd.Column3.ControlSource = "cursor_4c_MaxProduto.codtams"
1981:                 loc_oGrd.Column4.ControlSource = "cursor_4c_MaxProduto.codcores"
1982:                 loc_oGrd.Column5.ControlSource = "cursor_4c_MaxProduto.deptos"
1983: 
1984:                 *-- Problema 32: Header captions APOS RecordSource
1985:                 loc_oGrd.Column1.Header1.Caption = "Empresa"
1986:                 loc_oGrd.Column2.Header1.Caption = "Qtde. M" + CHR(225) + "x."
1987:                 loc_oGrd.Column3.Header1.Caption = "Tam"
1988:                 loc_oGrd.Column4.Header1.Caption = "Cor"
1989:                 loc_oGrd.Column5.Header1.Caption = "Departamento"
1990: 
1991:                 WITH loc_oGrd
1992:                     .Column1.Width = 40
1993:                     .Column2.Width = 80
1994:                     .Column3.Width = 70
1995:                     .Column4.Width = 70
1996:                     .Column5.Width = 100
1997:                 ENDWITH

*-- Linhas 2030 a 2294:
2030: 
2031:         TRY
2032:             IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
2033:                 *-- Nao processar fora do modo de edicao
2034:             ELSE
2035:                 IF USED("cursor_4c_MaxProduto") AND RECCOUNT("cursor_4c_MaxProduto") > 0 AND !EOF("cursor_4c_MaxProduto")
2036:                 SELECT cursor_4c_MaxProduto
2037:                 loc_cCpros    = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__produto.Value)
2038:                 loc_cEmps     = ALLTRIM(emps)
2039:                 loc_lConfirma = MsgConfirma("Excluir linha da empresa '" + loc_cEmps + "'?", ;
2040:                     "Confirmar Exclus" + CHR(227) + "o")
2041:             ELSE
2042:                 MsgAviso("Nenhuma linha selecionada para exclus" + CHR(227) + "o.", "Aviso")
2043:                 ENDIF
2044:             ENDIF
2045:         CATCH TO loException
2046:             MsgErro("Erro em BtnExcluirLinhaClick: " + loException.Message, "Erro")
2047:         ENDTRY
2048: 
2049:         IF loc_lConfirma AND !EMPTY(loc_cCpros) AND !EMPTY(loc_cEmps)
2050:             loc_lSucesso = THIS.this_oBusinessObject.ExcluirLinhaEmpresa(loc_cCpros, loc_cEmps)
2051: 
2052:             IF loc_lSucesso
2053:                 THIS.this_oBusinessObject.BuscarPorProduto(loc_cCpros)
2054: 
2055:                 IF !USED("cursor_4c_MaxProduto") OR RECCOUNT("cursor_4c_MaxProduto") = 0
2056:                     THIS.this_oBusinessObject.InserirLinhaCursorLocal(loc_cCpros)
2057:                 ENDIF
2058: 
2059:                 THIS.VincularGridPage2()
2060:             ENDIF
2061:         ENDIF
2062:     ENDPROC
2063: 
2064:     *==========================================================================
2065:     * GradeAfterRowColChangePage2 - Handler AfterRowColChange do grd_4c_Dados
2066:     * Atualiza ReadOnly de Column3/4 conforme flags lTemTam/lTemCor
2067:     *==========================================================================
2068:     PROCEDURE GradeAfterRowColChangePage2(par_nColIndex)
2069:         LOCAL loc_oGrd
2070: 
2071:         TRY
2072:             IF THIS.this_cPcEscolha != "CONSULTAR" AND USED("cursor_4c_MaxProduto")
2073:                 loc_oGrd = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
2074:                 loc_oGrd.Column3.ReadOnly = !THIS.this_lTemTam
2075:                 loc_oGrd.Column4.ReadOnly = !THIS.this_lTemCor
2076:                 loc_oGrd.Refresh
2077:             ENDIF
2078:         CATCH TO loException
2079:             MsgErro("Erro em GradeAfterRowColChangePage2: " + loException.Message, "Erro")
2080:         ENDTRY
2081:     ENDPROC
2082: 
2083:     *==========================================================================
2084:     * GradeKeyPressPage2 - Handler KeyPress do grd_4c_Dados (Page2)
2085:     * F4(28): abre lookup de Tamanho(col3)/Cor(col4)/Departamento(col5)
2086:     * Tab(9) em col5 na ultima linha: insere nova linha via MNovaLinha
2087:     *==========================================================================
2088:     PROCEDURE GradeKeyPressPage2(par_nKeyCode, par_nShiftAltCtrl)
2089:         LOCAL loc_oGrd, loc_nCol, loc_lUltimaLinha
2090: 
2091:         TRY
2092:             IF THIS.this_cPcEscolha != "CONSULTAR" AND USED("cursor_4c_MaxProduto")
2093:                 loc_oGrd = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
2094:                 loc_nCol = loc_oGrd.ActiveColumn
2095: 
2096:                 DO CASE
2097:                 CASE par_nKeyCode = 28 AND loc_nCol = 3 AND THIS.this_lTemTam
2098:                     THIS.AbrirLookupTamanhoGrid()
2099:                     NODEFAULT
2100: 
2101:                 CASE par_nKeyCode = 28 AND loc_nCol = 4 AND THIS.this_lTemCor
2102:                     THIS.AbrirLookupCorGrid()
2103:                     NODEFAULT
2104: 
2105:                 CASE par_nKeyCode = 28 AND loc_nCol = 5
2106:                     THIS.AbrirLookupDepartamentoGrid()
2107:                     NODEFAULT
2108: 
2109:                 CASE par_nKeyCode = 9 AND loc_nCol = 5
2110:                     SELECT cursor_4c_MaxProduto
2111:                     loc_lUltimaLinha = (RECNO() = RECCOUNT())
2112:                     IF loc_lUltimaLinha
2113:                         THIS.MNovaLinha()
2114:                         NODEFAULT
2115:                     ENDIF
2116:                 ENDCASE
2117:             ENDIF
2118:         CATCH TO loException
2119:             MsgErro("Erro em GradeKeyPressPage2: " + loException.Message, "Erro")
2120:         ENDTRY
2121:     ENDPROC
2122: 
2123:     *==========================================================================
2124:     * AbrirLookupTamanhoGrid - Abre FormBuscaAuxiliar para SigCdTam (coluna 3)
2125:     * Colunas: cods (codigo), descs (descricao)
2126:     *==========================================================================
2127:     PROCEDURE AbrirLookupTamanhoGrid()
2128:         LOCAL loc_oForm, loc_cValAtual
2129: 
2130:         TRY
2131:             IF USED("cursor_4c_MaxProduto")
2132:                 SELECT cursor_4c_MaxProduto
2133:                 loc_cValAtual = ALLTRIM(codtams)
2134: 
2135:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2136:                     "SigCdTam", "cursor_4c_BuscaTam", "cods", loc_cValAtual, ;
2137:                     "Tamanhos")
2138: 
2139:                 IF VARTYPE(loc_oForm) = "O"
2140:                     IF !loc_oForm.this_lAchouRegistro
2141:                         loc_oForm.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
2142:                         loc_oForm.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2143:                         loc_oForm.Show()
2144:                     ENDIF
2145: 
2146:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaTam")
2147:                         GO TOP IN cursor_4c_BuscaTam
2148:                         SELECT cursor_4c_BuscaTam
2149:                         loc_cValAtual = ALLTRIM(cods)
2150: 
2151:                         SELECT cursor_4c_MaxProduto
2152:                         REPLACE codtams WITH loc_cValAtual
2153:                     ENDIF
2154: 
2155:                     IF USED("cursor_4c_BuscaTam")
2156:                         USE IN cursor_4c_BuscaTam
2157:                     ENDIF
2158: 
2159:                     loc_oForm.Release()
2160:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh
2161:                 ENDIF
2162:             ENDIF
2163:         CATCH TO loException
2164:             MsgErro("Erro em AbrirLookupTamanhoGrid: " + loException.Message, "Erro")
2165:         ENDTRY
2166:     ENDPROC
2167: 
2168:     *==========================================================================
2169:     * AbrirLookupCorGrid - Abre FormBuscaAuxiliar para SigCdCor (coluna 4)
2170:     * Colunas: cods (codigo), descs (descricao)
2171:     *==========================================================================
2172:     PROCEDURE AbrirLookupCorGrid()
2173:         LOCAL loc_oForm, loc_cValAtual
2174: 
2175:         TRY
2176:             IF USED("cursor_4c_MaxProduto")
2177:                 SELECT cursor_4c_MaxProduto
2178:                 loc_cValAtual = ALLTRIM(codcores)
2179: 
2180:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2181:                     "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cValAtual, ;
2182:                     "Cores")
2183: 
2184:                 IF VARTYPE(loc_oForm) = "O"
2185:                     IF !loc_oForm.this_lAchouRegistro
2186:                         loc_oForm.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
2187:                         loc_oForm.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2188:                         loc_oForm.Show()
2189:                     ENDIF
2190: 
2191:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCor")
2192:                         GO TOP IN cursor_4c_BuscaCor
2193:                         SELECT cursor_4c_BuscaCor
2194:                         loc_cValAtual = ALLTRIM(cods)
2195: 
2196:                         SELECT cursor_4c_MaxProduto
2197:                         REPLACE codcores WITH loc_cValAtual
2198:                     ENDIF
2199: 
2200:                     IF USED("cursor_4c_BuscaCor")
2201:                         USE IN cursor_4c_BuscaCor
2202:                     ENDIF
2203: 
2204:                     loc_oForm.Release()
2205:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh
2206:                 ENDIF
2207:             ENDIF
2208:         CATCH TO loException
2209:             MsgErro("Erro em AbrirLookupCorGrid: " + loException.Message, "Erro")
2210:         ENDTRY
2211:     ENDPROC
2212: 
2213:     *==========================================================================
2214:     * AbrirLookupDepartamentoGrid - Abre FormBuscaAuxiliar para SigCdDpt (coluna 5)
2215:     * Colunas: codigos (codigo), Descricaos (descricao)
2216:     *==========================================================================
2217:     PROCEDURE AbrirLookupDepartamentoGrid()
2218:         LOCAL loc_oForm, loc_cValAtual
2219: 
2220:         TRY
2221:             IF USED("cursor_4c_MaxProduto")
2222:                 SELECT cursor_4c_MaxProduto
2223:                 loc_cValAtual = ALLTRIM(deptos)
2224: 
2225:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2226:                     "SigCdDpt", "cursor_4c_BuscaDpt", "codigos", loc_cValAtual, ;
2227:                     "Departamentos")
2228: 
2229:                 IF VARTYPE(loc_oForm) = "O"
2230:                     IF !loc_oForm.this_lAchouRegistro
2231:                         loc_oForm.mAddColuna("codigos",    "", "C" + CHR(243) + "d.")
2232:                         loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2233:                         loc_oForm.Show()
2234:                     ENDIF
2235: 
2236:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaDpt")
2237:                         GO TOP IN cursor_4c_BuscaDpt
2238:                         SELECT cursor_4c_BuscaDpt
2239:                         loc_cValAtual = ALLTRIM(codigos)
2240: 
2241:                         SELECT cursor_4c_MaxProduto
2242:                         REPLACE deptos WITH PADR(loc_cValAtual, 10)
2243:                     ENDIF
2244: 
2245:                     IF USED("cursor_4c_BuscaDpt")
2246:                         USE IN cursor_4c_BuscaDpt
2247:                     ENDIF
2248: 
2249:                     loc_oForm.Release()
2250:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh
2251:                 ENDIF
2252:             ENDIF
2253:         CATCH TO loException
2254:             MsgErro("Erro em AbrirLookupDepartamentoGrid: " + loException.Message, "Erro")
2255:         ENDTRY
2256:     ENDPROC
2257: 
2258:     *==========================================================================
2259:     * MNovaLinha - Insere nova linha em branco no cursor_4c_MaxProduto
2260:     * Chamado pelo Tab na ultima coluna da ultima linha do grid
2261:     *==========================================================================
2262:     PROCEDURE MNovaLinha()
2263:         LOCAL loc_cCpros, loc_oGrd
2264: 
2265:         TRY
2266:             loc_cCpros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__produto.Value)
2267: 
2268:             IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
2269:                 *-- Nao inserir linha em modo leitura
2270:             ELSE
2271:                 IF EMPTY(loc_cCpros)
2272:                 MsgAviso("Selecione um produto antes de adicionar linha.", "Aviso")
2273:             ELSE
2274:                 THIS.this_oBusinessObject.InserirLinhaCursorLocal(loc_cCpros)
2275: 
2276:                 IF USED("cursor_4c_MaxProduto")
2277:                     GO BOTTOM IN cursor_4c_MaxProduto
2278:                     loc_oGrd = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
2279:                     loc_oGrd.ActivateCell(RECNO("cursor_4c_MaxProduto"), 1)
2280:                     loc_oGrd.Refresh
2281:                 ENDIF
2282:                 ENDIF
2283:             ENDIF
2284:         CATCH TO loException
2285:             MsgErro("Erro em MNovaLinha: " + loException.Message, "Erro")
2286:         ENDTRY
2287:     ENDPROC
2288: 
2289:     *==========================================================================
2290:     * LimparPage2 - Limpa campos da Page2 (chamado em modo INSERIR)
2291:     *==========================================================================
2292:     PROCEDURE LimparPage2()
2293:         LOCAL loc_oPag2
2294: 

*-- Linhas 2303 a 2333:
2303:             loc_oPag2.txt_4c_Dfor.Value         = ""
2304:             loc_oPag2.txt_4c_Refs.Value         = ""
2305:             loc_oPag2.obj_4c_Opc_situacao.Value = 1
2306:             loc_oPag2.grd_4c_Dados.RecordSource = ""
2307: 
2308:             IF USED("cursor_4c_MaxProduto")
2309:                 USE IN cursor_4c_MaxProduto
2310:             ENDIF
2311:         CATCH TO loException
2312:             MsgErro("Erro em LimparPage2: " + loException.Message, "Erro")
2313:         ENDTRY
2314:     ENDPROC
2315: 
2316:     *==========================================================================
2317:     * FormParaBO - Transfere campos do form para o Business Object
2318:     * Neste form especial, a edicao acontece no grid (cursor_4c_MaxProduto).
2319:     * FormParaBO captura o produto selecionado e as flags de modo.
2320:     *==========================================================================
2321:     PROCEDURE FormParaBO()
2322:         LOCAL loc_oPag2
2323:         loc_oPag2 = .NULL.
2324: 
2325:         TRY
2326:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2327: 
2328:             WITH THIS.this_oBusinessObject
2329:                 .this_cCpros     = ALLTRIM(loc_oPag2.txt_4c__produto.Value)
2330:                 .this_cDpros     = ALLTRIM(loc_oPag2.txt_4c_Dpro.Value)
2331:                 .this_cCgrus     = ALLTRIM(loc_oPag2.txt_4c_Cgru.Value)
2332:                 .this_cDgrus     = ALLTRIM(loc_oPag2.txt_4c_Dgru.Value)
2333:                 .this_cIfors     = ALLTRIM(loc_oPag2.txt_4c_Ifor.Value)

*-- Linhas 2466 a 2484:
2466: 
2467:         *-- Fechar cursores de dados abertos
2468:         IF USED("cursor_4c_Dados")
2469:             USE IN cursor_4c_Dados
2470:         ENDIF
2471:         IF USED("cursor_4c_MaxProduto")
2472:             USE IN cursor_4c_MaxProduto
2473:         ENDIF
2474:         IF USED("cursor_4c_Copia")
2475:             USE IN cursor_4c_Copia
2476:         ENDIF
2477:         IF USED("cursor_4c_Cabecalho")
2478:             USE IN cursor_4c_Cabecalho
2479:         ENDIF
2480: 
2481:         DODEFAULT()
2482:     ENDPROC
2483: 
2484: ENDDEFINE


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

