# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, CGRUS, MERCS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TOTAL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, CGRUS, MERCS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CCLASS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, CGRUS, MERCS

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
  ControlSource = "crSigCdCls.cods"
  ControlSource = "CrSigCdCls.Tipos"
  ControlSource = "CrSigCdCls.descs"
  ControlSource = "CrSigCdCls.Situas"
  DeleteMark = .F.
  Column1.ControlSource = "crGrdCdCom.CGrus"
  Column2.ControlSource = "crGrdCdCom.DGrus"
	If Not ThisForm.poDataMgr.Update([crSigCdCom])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigCdCom)])
	If Not ThisForm.poDataMgr.Update([crSigCdCom])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigCdCom)])
Select crSigCdCls
lcQuery = [Select * ] + ;
		    [From SigCdCla ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCdCom]) < 1)
Select LocalCdCom
	lcQuery = [Select DGrus ] + ;
			    [From SigCdGrp ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalGru]) < 1)
	Insert Into crGrdCdCom (CGrus, DGrus) Values (LocalCdCom.CGrus, LocalGru.DGrus)
Select crSigCdCls
Select crSigCdCls
	lcQuery = [Select * ] + ;
			    [From SigCdCls ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalClas]) < 1)
	Select LocalClas
	lcQuery = [Delete From SigCdCls ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Delete - LocalClas)])
	lcQuery = [Delete From SigCdCla ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Delete - LocalCdCla)])
Select Distinct CGrus ;
  From crGrdCdCom ;
Select crGravar
	Insert Into crSigCdCom (Cods, CGrus, cIdChaves) ;
Select crSigCdCls
Select crGrdCdCom
Delete In crGrdCdCom
Select crGrdCdCom
lcQuery = [Select CGrus, DGrus ] + ;
		    [From SigCdGrp ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalGru]) < 1)
	Delete From crGrdCdCom Where Empty(CGrus)
Select LocalGru
	Select crGrdCdCom
		Insert Into crGrdCdCom (CGrus, DGrus) Values (LocalGru.CGrus, LocalGru.DGrus)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCla.prg) - TRECHOS RELEVANTES PARA PASS SQL (1562 linhas total):

*-- Linhas 65 a 83:
65:                     USE IN crGrdCdCom
66:                 ENDIF
67:                 SET NULL ON
68:                 CREATE CURSOR crGrdCdCom (CGrus C(3), DGrus C(20))
69:                 SET NULL OFF
70: 
71:                 THIS.ConfigurarPageFrame()
72: 
73:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
74:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
75: 
76:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
77:                     THIS.CarregarLista()
78:                 ENDIF
79: 
80:                 THIS.pgf_4c_Paginas.Visible  = .T.
81:                 THIS.pgf_4c_Paginas.ActivePage = 1
82:                 THIS.this_cModoAtual = "LISTA"
83:                 loc_lResultado = .T.

*-- Linhas 357 a 375:
357:             .HighlightBackColor = RGB(255, 255, 255)
358:             .HighlightForeColor = RGB(15, 41, 104)
359:             .HighlightStyle     = 2
360:             .DeleteMark         = .F.
361:             .RecordMark         = .F.
362:             .RowHeight          = 16
363:             .ScrollBars         = 2
364:             .Visible            = .T.
365:         ENDWITH
366:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridListaAfterRowColChange")
367: 
368:         THIS.TornarControlesVisiveis(loc_oPg1)
369:     ENDPROC
370: 
371:     *--------------------------------------------------------------------------
372:     * ConfigurarPaginaDados - Page2: botoes Confirmar/Cancelar + campos principais
373:     * Fase 5: Container de botoes + primeiros 50% dos campos
374:     *--------------------------------------------------------------------------
375:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 646 a 683:
646:             .FontSize          = 8
647:             .AllowHeaderSizing = .F.
648:             .AllowRowSizing    = .F.
649:             .DeleteMark        = .F.
650:             .HeaderHeight      = 16
651:             .RecordMark        = .T.
652:             .RowHeight         = 15
653:             .ScrollBars        = 2
654:             .GridLineColor     = RGB(238, 238, 238)
655:             .GridLines         = 3
656:             .Visible           = .T.
657:         ENDWITH
658:         WITH loc_oGridGrp.Column1
659:             .ControlSource = "crGrdCdCom.CGrus"
660:             .Width         = 34
661:             .Movable       = .F.
662:             .Resizable     = .F.
663:             .FontSize      = 8
664:         ENDWITH
665:         loc_oGridGrp.Column1.Header1.Caption   = "Grupo"
666:         loc_oGridGrp.Column1.Header1.Alignment = 2
667:         WITH loc_oGridGrp.Column2
668:             .ControlSource = "crGrdCdCom.DGrus"
669:             .Width         = 150
670:             .Movable       = .F.
671:             .Resizable     = .F.
672:             .ReadOnly      = .F.
673:             .FontSize      = 8
674:         ENDWITH
675:         loc_oGridGrp.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
676:         loc_oGridGrp.Column2.Header1.Alignment = 2
677:         BINDEVENT(loc_oGridGrp, "AfterRowColChange", THIS, "GridGruposAfterRowColChange")
678: 
679:         *-------- cmd_4c_BtnCarregar: Carregar Grande Grupo (Top=180+29=209, Left=550) --
680:         loc_oPg2.AddObject("cmd_4c_BtnCarregar", "CommandButton")
681:         WITH loc_oPg2.cmd_4c_BtnCarregar
682:             .Caption     = ""
683:             .Picture     = gc_4c_CaminhoIcones + "importar_48.png"

*-- Linhas 725 a 754:
725:         TRY
726:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
727:                 SET NULL ON
728:                 CREATE CURSOR cursor_4c_Dados (cods C(3), descs C(20))
729:                 SET NULL OFF
730:                 loc_lResultado = .T.
731:             ELSE
732:                 IF THIS.this_oBusinessObject.Buscar("")
733:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
734:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
735: 
736:                         loc_oGrid.ColumnCount  = 2
737:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
738:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
739:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
740: 
741:                         loc_oGrid.Column1.Width   = 80
742:                         loc_oGrid.Column2.Width   = 800
743: 
744:                         loc_oGrid.Column1.ReadOnly = .T.
745:                         loc_oGrid.Column2.ReadOnly = .T.
746: 
747:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
748:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
749: 
750:                         THIS.FormatarGridLista(loc_oGrid)
751:                     ENDIF
752:                     loc_lResultado = .T.
753:                 ENDIF
754:             ENDIF

*-- Linhas 900 a 918:
900:         ENDIF
901: 
902:         TRY
903:             SELECT cursor_4c_Dados
904:             loc_cCodigo = ALLTRIM(cods)
905:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
906:                 THIS.this_cModoAtual = "VISUALIZAR"
907:                 THIS.BOParaForm()
908:                 THIS.HabilitarCampos(.F.)
909:                 THIS.AlternarPagina(2)
910:             ENDIF
911:         CATCH TO loc_oErro
912:             MsgErro(loc_oErro.Message, "FormCla.BtnVisualizarClick")
913:         ENDTRY
914:     ENDPROC
915: 
916:     *--------------------------------------------------------------------------
917:     * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
918:     *--------------------------------------------------------------------------

*-- Linhas 924 a 942:
924:         ENDIF
925: 
926:         TRY
927:             SELECT cursor_4c_Dados
928:             loc_cCodigo = ALLTRIM(cods)
929:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
930:                 THIS.this_oBusinessObject.EditarRegistro()
931:                 THIS.this_cModoAtual = "ALTERAR"
932:                 THIS.BOParaForm()
933:                 THIS.HabilitarCampos(.T.)
934:                 THIS.AlternarPagina(2)
935:             ENDIF
936:         CATCH TO loc_oErro
937:             MsgErro(loc_oErro.Message, "FormCla.BtnAlterarClick")
938:         ENDTRY
939:     ENDPROC
940: 
941:     *--------------------------------------------------------------------------
942:     * BtnExcluirClick - Confirma e exclui registro selecionado

*-- Linhas 948 a 966:
948:             RETURN
949:         ENDIF
950: 
951:         SELECT cursor_4c_Dados
952:         loc_cCodigo = ALLTRIM(cods)
953: 
954:         IF MsgConfirma("Confirma exclus" + CHR(227) + "o do registro '" + ;
955:                 loc_cCodigo + "'?", "Confirmar Exclus" + CHR(227) + "o")
956:             TRY
957:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
958:                     IF THIS.this_oBusinessObject.Excluir()
959:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Sucesso")
960:                         THIS.CarregarLista()
961:                     ENDIF
962:                 ENDIF
963:             CATCH TO loc_oErro
964:                 MsgErro(loc_oErro.Message, "FormCla.BtnExcluirClick")
965:             ENDTRY
966:         ENDIF

*-- Linhas 982 a 1000:
982:                 loc_oBusca.Show()
983: 
984:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
985:                     SELECT cursor_4c_Dados
986:                     LOCATE FOR ALLTRIM(cods) = ALLTRIM(cursor_4c_Busca.Cods)
987:                     IF FOUND()
988:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
989:                     ENDIF
990:                 ENDIF
991: 
992:                 loc_oBusca.Release()
993:             ENDIF
994:         CATCH TO loc_oErro
995:             MsgErro(loc_oErro.Message, "FormCla.BtnBuscarClick")
996:         ENDTRY
997: 
998:         IF USED("cursor_4c_Busca")
999:             USE IN cursor_4c_Busca
1000:         ENDIF

*-- Linhas 1232 a 1252:
1232:             IF THIS.this_oBusinessObject.BuscarGrupos(THIS.this_oBusinessObject.this_cCodigo)
1233:                 IF USED("cursor_4c_Grupos") AND RECCOUNT("cursor_4c_Grupos") > 0
1234:                     GO TOP IN cursor_4c_Grupos
1235:                     SELECT cursor_4c_Grupos
1236:                     SCAN
1237:                         INSERT INTO crGrdCdCom (CGrus, DGrus) ;
1238:                             VALUES (cursor_4c_Grupos.CGrus, cursor_4c_Grupos.DGrus)
1239:                     ENDSCAN
1240:                 ENDIF
1241:                 IF USED("cursor_4c_Grupos")
1242:                     USE IN cursor_4c_Grupos
1243:                 ENDIF
1244:             ENDIF
1245: 
1246:             *-- Linha em branco para inclusao de novo grupo em modo edicao
1247:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1248:                 IF USED("crGrdCdCom") AND (RECCOUNT("crGrdCdCom") = 0 OR EOF("crGrdCdCom"))
1249:                     APPEND BLANK IN crGrdCdCom
1250:                 ENDIF
1251:             ENDIF
1252: 

*-- Linhas 1348 a 1398:
1348:             RETURN
1349:         ENDIF
1350: 
1351:         SELECT crGrdCdCom
1352:         loc_cCGrus = ALLTRIM(crGrdCdCom.CGrus)
1353: 
1354:         IF EMPTY(loc_cCGrus)
1355:             REPLACE DGrus WITH "" IN crGrdCdCom
1356:             RETURN
1357:         ENDIF
1358: 
1359:         TRY
1360:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1361:                 "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cCGrus, ;
1362:                 "Selecionar Grupo")
1363: 
1364:             IF VARTYPE(loc_oBusca) = "O"
1365:                 IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
1366:                     IF USED("cursor_4c_BuscaGrp")
1367:                         loc_cCGrus = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1368:                         loc_cDGrus = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
1369:                         SELECT crGrdCdCom
1370:                         REPLACE CGrus WITH loc_cCGrus, DGrus WITH loc_cDGrus IN crGrdCdCom
1371:                     ENDIF
1372:                 ELSE
1373:                     IF !loc_oBusca.this_lAchouRegistro
1374:                     loc_oBusca.mAddColuna("CGrus", "", "Grupo")
1375:                     loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1376:                     loc_oBusca.Show()
1377:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1378:                         loc_cCGrus = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1379:                         loc_cDGrus = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
1380:                         SELECT crGrdCdCom
1381:                         REPLACE CGrus WITH loc_cCGrus, DGrus WITH loc_cDGrus IN crGrdCdCom
1382:                     ELSE
1383:                         SELECT crGrdCdCom
1384:                         REPLACE DGrus WITH "" IN crGrdCdCom
1385:                     ENDIF
1386:                     ENDIF
1387:                 ENDIF
1388:                 loc_oBusca.Release()
1389:             ENDIF
1390:         CATCH TO loc_oErro
1391:             MsgErro(loc_oErro.Message, "FormCla.ValidarCGrusGrid")
1392:         ENDTRY
1393: 
1394:         IF USED("cursor_4c_BuscaGrp")
1395:             USE IN cursor_4c_BuscaGrp
1396:         ENDIF
1397: 
1398:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Dados", 5)

*-- Linhas 1411 a 1527:
1411:             RETURN
1412:         ENDIF
1413: 
1414:         SELECT crGrdCdCom
1415:         loc_cDGrus = ALLTRIM(crGrdCdCom.DGrus)
1416: 
1417:         IF EMPTY(crGrdCdCom.CGrus) AND EMPTY(loc_cDGrus)
1418:             RETURN
1419:         ENDIF
1420: 
1421:         IF EMPTY(loc_cDGrus)
1422:             REPLACE CGrus WITH "" IN crGrdCdCom
1423:             RETURN
1424:         ENDIF
1425: 
1426:         TRY
1427:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1428:                 "SigCdGrp", "cursor_4c_BuscaGrp", "DGrus", loc_cDGrus, ;
1429:                 "Selecionar Grupo")
1430: 
1431:             IF VARTYPE(loc_oBusca) = "O"
1432:                 IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
1433:                     IF USED("cursor_4c_BuscaGrp")
1434:                         loc_cCGrus = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1435:                         loc_cDGrus = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
1436:                         SELECT crGrdCdCom
1437:                         REPLACE CGrus WITH loc_cCGrus, DGrus WITH loc_cDGrus IN crGrdCdCom
1438:                     ENDIF
1439:                 ELSE
1440:                     IF !loc_oBusca.this_lAchouRegistro
1441:                     loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1442:                     loc_oBusca.mAddColuna("CGrus", "", "Grupo")
1443:                     loc_oBusca.Show()
1444:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1445:                         loc_cCGrus = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1446:                         loc_cDGrus = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
1447:                         SELECT crGrdCdCom
1448:                         REPLACE CGrus WITH loc_cCGrus, DGrus WITH loc_cDGrus IN crGrdCdCom
1449:                     ELSE
1450:                         SELECT crGrdCdCom
1451:                         REPLACE CGrus WITH "" IN crGrdCdCom
1452:                     ENDIF
1453:                     ENDIF
1454:                 ENDIF
1455:                 loc_oBusca.Release()
1456:             ENDIF
1457:         CATCH TO loc_oErro
1458:             MsgErro(loc_oErro.Message, "FormCla.ValidarDGrusGrid")
1459:         ENDTRY
1460: 
1461:         IF USED("cursor_4c_BuscaGrp")
1462:             USE IN cursor_4c_BuscaGrp
1463:         ENDIF
1464: 
1465:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Dados", 5)
1466:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1467:         ENDIF
1468:     ENDPROC
1469: 
1470:     *--------------------------------------------------------------------------
1471:     * BtnCarregarClick - Carrega grupos de SigCdGrp filtrados pelo Grande Grupo
1472:     * Equivale ao btnCarregar.Click original: SELECT CGrus,DGrus FROM SigCdGrp
1473:     * WHERE Mercs = lcGde, inserindo apenas grupos nao existentes em crGrdCdCom
1474:     *--------------------------------------------------------------------------
1475:     PROCEDURE BtnCarregarClick()
1476:         LOCAL loc_oPg2, loc_cGde, loc_cSQL, loc_nResult
1477:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1478: 
1479:         IF !PEMSTATUS(loc_oPg2, "txt_4c_GdeGrps", 5)
1480:             RETURN
1481:         ENDIF
1482: 
1483:         loc_cGde = ALLTRIM(loc_oPg2.txt_4c_GdeGrps.Value)
1484: 
1485:         IF EMPTY(loc_cGde)
1486:             MsgAviso("Preencha o Grande Grupo antes de processar!", ;
1487:                      "Aten" + CHR(231) + CHR(227) + "o")
1488:             loc_oPg2.txt_4c_GdeGrps.SetFocus
1489:             RETURN
1490:         ENDIF
1491: 
1492:         TRY
1493:             loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp WHERE Mercs = " + ;
1494:                        EscaparSQL(loc_cGde)
1495:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalGru")
1496: 
1497:             IF loc_nResult < 1
1498:                 MsgErro("Falha ao consultar grupos: " + CapturarErroSQL(), "Erro SQL")
1499:             ELSE
1500:                 GO TOP IN cursor_4c_LocalGru
1501: 
1502:                 IF !EOF("cursor_4c_LocalGru")
1503:                     DELETE FROM crGrdCdCom WHERE EMPTY(CGrus)
1504:                 ENDIF
1505: 
1506:                 SELECT cursor_4c_LocalGru
1507:                 SCAN
1508:                     SELECT crGrdCdCom
1509:                     GO TOP IN crGrdCdCom
1510:                     LOCATE FOR CGrus = cursor_4c_LocalGru.CGrus
1511:                     IF EOF("crGrdCdCom")
1512:                         INSERT INTO crGrdCdCom (CGrus, DGrus) ;
1513:                             VALUES (cursor_4c_LocalGru.CGrus, cursor_4c_LocalGru.DGrus)
1514:                     ENDIF
1515:                 ENDSCAN
1516: 
1517:                 GO TOP IN cursor_4c_LocalGru
1518:                 IF !EOF("cursor_4c_LocalGru")
1519:                     APPEND BLANK IN crGrdCdCom
1520:                 ENDIF
1521: 
1522:                 USE IN cursor_4c_LocalGru
1523:                 GO BOTTOM IN crGrdCdCom
1524: 
1525:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
1526:                     loc_oPg2.grd_4c_Dados.Refresh()
1527:                 ENDIF

*-- Linhas 1547 a 1562:
1547:         ENDIF
1548: 
1549:         TRY
1550:             SELECT crGrdCdCom
1551:             DELETE IN crGrdCdCom
1552: 
1553:             IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
1554:                 loc_oPg2.grd_4c_Dados.Refresh()
1555:                 THIS.Refresh()
1556:             ENDIF
1557:         CATCH TO loc_oErro
1558:             MsgErro(loc_oErro.Message, "FormCla.CmdExcluirClick")
1559:         ENDTRY
1560:     ENDPROC
1561: 
1562: ENDDEFINE


### BO (C:\4c\projeto\app\classes\ClaBO.prg):
*------------------------------------------------------------------------------
* ClaBO.prg - Business Object para Classificacao de Produtos
* Tabela principal: SigCdCls
* Tabela detalhe:   SigCdCla (grupos associados)
*------------------------------------------------------------------------------

DEFINE CLASS ClaBO AS BusinessBase

    *-- Propriedades da entidade SigCdCls
    this_cCodigo    = ""   && SigCdCls.Cods     (PK char(3))
    this_cDescricao = ""   && SigCdCls.Descs    (char(40))
    this_cTipo      = ""   && SigCdCls.Tipos    (char(1): O=Ouro, P=Prata, R=Rel+CHR(243)+gio, J=Jolie)
    this_nSitua     = 0    && SigCdCls.Situas   (numeric(1,0): 1=Ativos, 2=Inativos, 3=Ambos)

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCls"
        THIS.this_cCampoChave = "Cods"
        RETURN .T.
    ENDPROC

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SigCdCls filtrados opcionalmente
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            IF EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT Cods, Descs, Tipos, Situas" + ;
                           " FROM SigCdCls" + ;
                           " ORDER BY Cods"
            ELSE
                loc_cSQL = "SELECT Cods, Descs, Tipos, Situas" + ;
                           " FROM SigCdCls" + ;
                           " WHERE Cods LIKE " + EscaparSQL("%" + par_cFiltro + "%") + ;
                           "    OR Descs LIKE " + EscaparSQL("%" + par_cFiltro + "%") + ;
                           " ORDER BY Cods"
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.Buscar: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCodigo))
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "SELECT Cods, Descs, Tipos, Situas" + ;
                           " FROM SigCdCls" + ;
                           " WHERE Cods = " + EscaparSQL(par_cCodigo)

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                        loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                        THIS.this_lNovoRegistro = .F.
                    ELSE
                        loc_lResultado = .F.
                    ENDIF

                    IF USED("cursor_4c_Carrega")
                        USE IN cursor_4c_Carrega
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = ALLTRIM(NVL(Cods,  ""))
                THIS.this_cDescricao = ALLTRIM(NVL(Descs, ""))
                THIS.this_cTipo      = ALLTRIM(NVL(Tipos, ""))
                THIS.this_nSitua     = NVL(Situas, 0)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.CarregarDoCursor: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdCls (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCodigo))
                MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o informado!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                *-- Verificar duplicidade
                loc_cSQL = "SELECT COUNT(*) AS total FROM SigCdCls WHERE Cods = " + ;
                           EscaparSQL(THIS.this_cCodigo)
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
                IF loc_nResultado > 0 AND USED("cursor_4c_Dup") AND cursor_4c_Dup.total > 0
                    USE IN cursor_4c_Dup
                    MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                ELSE
                    IF USED("cursor_4c_Dup")
                        USE IN cursor_4c_Dup
                    ENDIF

                    loc_cSQL = "INSERT INTO SigCdCls (Cods, Descs, Tipos, Situas)" + ;
                               " VALUES (" + ;
                               EscaparSQL(THIS.this_cCodigo)    + "," + ;
                               EscaparSQL(THIS.this_cDescricao) + "," + ;
                               EscaparSQL(THIS.this_cTipo)      + "," + ;
                               FormatarNumeroSQL(THIS.this_nSitua) + ;
                               ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        MsgErro("Erro ao inserir classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                        loc_lResultado = .F.
                    ELSE
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.Inserir: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdCls (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCls SET" + ;
                       "  Descs  = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       "  Tipos  = " + EscaparSQL(THIS.this_cTipo)      + "," + ;
                       "  Situas = " + FormatarNumeroSQL(THIS.this_nSitua) + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.Atualizar: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdCla e SigCdCls (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            *-- Verificar dependencia em SigCdPro (campo cclass)
            loc_cSQL = "SELECT COUNT(*) AS total FROM SigCdPro WHERE CClass = " + ;
                       EscaparSQL(THIS.this_cCodigo)

            IF USED("cursor_4c_Dep")
                USE IN cursor_4c_Dep
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dep")

            IF loc_nResultado > 0 AND USED("cursor_4c_Dep") AND cursor_4c_Dep.total > 0
                USE IN cursor_4c_Dep
                MsgAviso("Existem produtos cadastrados com esta Classifica" + CHR(231) + CHR(227) + "o!" + ;
                         CHR(13) + "Imposs" + CHR(237) + "vel executar a exclus" + CHR(227) + "o!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Dep")
                    USE IN cursor_4c_Dep
                ENDIF

                *-- Excluir registros de detalhe (SigCdCla)
                loc_cSQL = "DELETE FROM SigCdCla WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MsgErro("Erro ao excluir grupos da classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    *-- Excluir registro principal (SigCdCls)
                    loc_cSQL = "DELETE FROM SigCdCls WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        MsgErro("Erro ao excluir classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                        loc_lResultado = .F.
                    ELSE
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.ExecutarExclusao: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Carrega grupos associados (SigCdCla + SigCdGrp) para o grid
    *--------------------------------------------------------------------------
    FUNCTION BuscarGrupos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.CGrus, b.DGrus" + ;
                       " FROM SigCdCla a" + ;
                       " LEFT JOIN SigCdGrp b ON b.CGrus = a.CGrus" + ;
                       " WHERE a.Cods = " + EscaparSQL(par_cCodigo) + ;
                       " ORDER BY a.CGrus"

            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grupos")

            IF loc_nResultado < 0
                MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Grupos")
                    GO TOP IN cursor_4c_Grupos
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.BuscarGrupos: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarGrupos - Salva grupos associados em SigCdCla (DELETE + INSERT)
    *   par_cCodigo       = codigo da classificacao (SigCdCls.Cods)
    *   par_cCursorGrupos = alias do cursor local com CGrus/DGrus
    *--------------------------------------------------------------------------
    FUNCTION SalvarGrupos(par_cCodigo, par_cCursorGrupos)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cCGrus, loc_cCidchaves
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCodigo))
                loc_lResultado = .F.
            ELSE
                *-- Remover grupos antigos
                loc_cSQL = "DELETE FROM SigCdCla WHERE Cods = " + EscaparSQL(par_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MsgErro("Erro ao limpar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    loc_lResultado = .T.

                    *-- Inserir grupos do cursor (apenas CGrus nao vazio e distintos)
                    IF USED(par_cCursorGrupos) AND RECCOUNT(par_cCursorGrupos) > 0
                        SELECT DISTINCT CGrus FROM (par_cCursorGrupos) ;
                            WHERE !EMPTY(CGrus) ;
                            ORDER BY CGrus ;
                            INTO CURSOR cursor_4c_GruposGrav

                        IF USED("cursor_4c_GruposGrav") AND RECCOUNT("cursor_4c_GruposGrav") > 0
                            GO TOP IN cursor_4c_GruposGrav
                            SELECT cursor_4c_GruposGrav
                            SCAN
                                loc_cCGrus      = ALLTRIM(cursor_4c_GruposGrav.CGrus)
                                loc_cCidchaves  = LEFT(fUniqueIds(), 20)

                                loc_cSQL = "INSERT INTO SigCdCla (CGrus, CIdChaves, Cods)" + ;
                                           " VALUES (" + ;
                                           EscaparSQL(loc_cCGrus)     + "," + ;
                                           EscaparSQL(loc_cCidchaves) + "," + ;
                                           EscaparSQL(par_cCodigo)    + ;
                                           ")"

                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                                IF loc_nResultado < 0
                                    MsgErro("Erro ao inserir grupo " + loc_cCGrus + ":" + CHR(13) + ;
                                            CapturarErroSQL(), "Erro SQL")
                                    loc_lResultado = .F.
                                    EXIT
                                ENDIF
                            ENDSCAN
                        ENDIF

                        IF USED("cursor_4c_GruposGrav")
                            USE IN cursor_4c_GruposGrav
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.SalvarGrupos: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

