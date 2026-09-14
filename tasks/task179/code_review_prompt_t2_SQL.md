# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GCTPINSTALAS, CPROS, CITENS, EMPDOPNUMS, BLQDATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GCTPINSTALAS, CPROS, CITENS, EMPDOPNUMS, BLQDATAS

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
  Pagina.Lista.Grade.Column2.ControlSource = ""
  Pagina.Lista.Grade.Column3.ControlSource = ""
  Pagina.Lista.Grade.Column4.ControlSource = ""
  Pagina.Lista.Grade.Column5.ControlSource = ""
  Pagina.Lista.Grade.Column6.ControlSource = ""
  Pagina.Lista.Grade.Column7.ControlSource = ""
  ControlSource = "xEestI.DPros"
  DeleteMark = .F.
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column10.SelectOnEntry = .T.
  ControlSource = "xeesti.citens"
  ControlSource = "csTemporario.grupoos"
  ControlSource = "csTemporario.contaos"
  ControlSource = ""
  ControlSource = "csTemporario.grupods"
  ControlSource = "csTemporario.contads"
  ControlSource = ""
  ControlSource = "csTemporario.Vends"
  ControlSource = ""
  ControlSource = "csTemporario.grvends"
  ControlSource = "csTemporario.tabds"
  ControlSource = "csTemporario.pstatus"
  ControlSource = "xEestI.OBS"
  ControlSource = "csTemporario.nops"
  ControlSource = "csTemporario.prazoents"
  DeleteMark = .F.
  Column1.ControlSource = ""
  ControlSource = "tmpoperacao.codigos"
  ControlSource = "csTemporario.mascnum"
  ControlSource = "csTemporario.notas"
  ControlSource = "CsTemporario.datas"
  ControlSource = "csTemporario.obses"
	.Column1.ControlSource = 'csTemporario.Numes'
	.Column2.ControlSource = 'csTemporario.Datas'
	.Column3.ControlSource = 'csTemporario.GrupoOs'
	.Column4.ControlSource = 'csTemporario.ContaOs'
	.Column5.ControlSource = 'csTemporario.GrupoDs'
	.Column6.ControlSource = 'csTemporario.ContaDs'
	.Column7.ControlSource = 'csTemporario.Nops'
	.Column8.ControlSource = 'csTemporario.Usuars'	
	.Column9.ControlSource = 'csTemporario.PStatus'
	.Column10.ControlSource = 'csTemporario.Emps'
	.Column11.ControlSource = 'csTemporario.Empds'
		.Column1.ControlSource = 'xEestI.Cpros'
		.Column3.ControlSource = 'xEestI.Qtds'
		.Column5.ControlSource = 'xEestI.QtBaixas'
		.Column4.ControlSource = 'xEestI.QtProds'
		.Column6.ControlSource = 'xEestI.QtBxProds'
		.Column2.ControlSource = 'xEestI.QtProds - xEestI.QtBxProds'
		.Column7.ControlSource = 'xEestI.CItens'
		.Column8.ControlSource = 'xEestI.TPesos'
		.Column9.ControlSource = 'xEestI.DescVals'
		.Column10.ControlSource = 'xEestI.CodTams'
		.Column1.ControlSource = 'xEestI.Cpros'
		.Column2.ControlSource = 'xEestI.QtBxProds'
		.Column3.ControlSource = 'xEestI.Qtds'
		.Column4.ControlSource = 'xEestI.Qtds - xEestI.QtBaixas'
		.Column5.ControlSource = 'xEestI.QtBaixas'
		.Column6.ControlSource = 'xEestI.QtProds'
		.Column7.ControlSource = 'xEestI.CItens'
		.Column8.ControlSource = 'xEestI.TPesos'
		.Column9.ControlSource = 'xEestI.DescVals'
		.Column10.ControlSource = 'xEestI.CodTams'
	.DeleteMark   = .f.
	.Column1.ControlSource = 'TmpOperacao.Codigos'
		Select TmpOperacao
		lcQuery = [select isnull(b.codtams,'') as codtams, isnull(b.codcors,'') as codcors, a.* ] + ;
			[from sigmvitn a ] + ;
			[left join sigmvits b on a.empdopnums = b.empdopnums ] + ; 
		.poDataMgr.SqlExecute(lcQuery,[crSigMvItn])
		.poDataMgr.SqlExecute(lcQuery,[xEestI])
		Select csTemporario
Select csTemporario
			Select csTemporario
Select crSigMvPec
	Insert Into TmpOperacao From MemVar
lcQuery = [select isnull(b.codtams,'') as codtams, isnull(b.codcors,'') as codcors, b.qtds as QtdsS, a.* ] + ;
			[from sigmvitn a ] + ;
			[left join sigmvits b on a.empdopnums = b.empdopnums ] + ; 
ThisForm.poDataMgr.SqlExecute(lcQuery,[crSigMvItn])
SELECT empdopnums, cpros, codcors, codtams, SUM(qtds) as qtds, SUM(qtdss) as qtdss, Max(qtbaixas) as qtbaixas, Max(qtprods) as qtprods, ;
from crSigMvItn group by empdopnums, cpros, codcors, codtams into cursor crSigMvItn
Select crSigMvItn
	Insert Into xEestI From Memvar
Select xEestI
Select xEestI
Select xEestI
lcSql = [Select a.cpros,a.FigJpgs From SigCdPro a Where a.cpros = ']+lcCodPro+[' ]
ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpPro')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg) - TRECHOS RELEVANTES PARA PASS SQL (1960 linhas total):

*-- Linhas 229 a 247:
229:             .Left               = 26
230:             .Width              = 890
231:             .Height             = 460
232:             .DeleteMark         = .F.
233:             .RecordMark         = .F.
234:             .GridLineColor      = RGB(238, 238, 238)
235:             .HighlightBackColor = RGB(255, 255, 255)
236:             .HighlightForeColor = RGB(15, 41, 104)
237:             .HighlightStyle     = 2
238:             .FontName           = "Verdana"
239:             .FontSize           = 8
240:             .ForeColor          = RGB(90, 90, 90)
241:             .BackColor          = RGB(255, 255, 255)
242:             .RowHeight          = 16
243:             .ScrollBars         = 2
244:             .GridLines          = 3
245:             .Visible            = .T.
246:         ENDWITH
247: 

*-- Linhas 333 a 351:
333:             .Left               = 679
334:             .Width              = 112
335:             .Height             = 148
336:             .DeleteMark         = .F.
337:             .RecordMark         = .F.
338:             .GridLineColor      = RGB(238, 238, 238)
339:             .HighlightBackColor = RGB(255, 255, 255)
340:             .HighlightForeColor = RGB(15, 41, 104)
341:             .HighlightStyle     = 2
342:             .FontName           = "Verdana"
343:             .FontSize           = 8
344:             .ForeColor          = RGB(90, 90, 90)
345:             .BackColor          = RGB(255, 255, 255)
346:             .RowHeight          = 16
347:             .ScrollBars         = 2
348:             .GridLines          = 1
349:             .Visible            = .T.
350:         ENDWITH
351: 

*-- Linhas 980 a 998:
980:             .Left               = 23
981:             .Width              = 732
982:             .Height             = 191
983:             .DeleteMark         = .F.
984:             .RecordMark         = .F.
985:             .AllowHeaderSizing  = .F.
986:             .GridLineColor      = RGB(238, 238, 238)
987:             .HighlightBackColor = RGB(255, 255, 255)
988:             .HighlightForeColor = RGB(15, 41, 104)
989:             .HighlightStyle     = 2
990:             .FontName           = "Tahoma"
991:             .FontSize           = 8
992:             .ForeColor          = RGB(0, 0, 0)
993:             .BackColor          = RGB(255, 255, 255)
994:             .RowHeight          = 17
995:             .HeaderHeight       = 17
996:             .ScrollBars         = 2
997:             .ReadOnly           = .T.
998:             .Visible            = .T.

*-- Linhas 1110 a 1139:
1110:                         loc_oGrid.ColumnCount = 11
1111:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1112: 
1113:                         *-- ControlSource APOS RecordSource (auto-bind e substituido)
1114:                         loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.Numes"
1115:                         loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.Datas"
1116:                         loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.GrupoOs"
1117:                         loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.ContaOs"
1118:                         loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.GrupoDs"
1119:                         loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.ContaDs"
1120:                         loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.Nops"
1121:                         loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.Usuars"
1122:                         loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.PStatus"
1123:                         loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.Emps"
1124:                         loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.Empds"
1125: 
1126:                         loc_oGrid.Column1.Width  = 70
1127:                         loc_oGrid.Column2.Width  = 70
1128:                         loc_oGrid.Column3.Width  = 80
1129:                         loc_oGrid.Column4.Width  = 100
1130:                         loc_oGrid.Column5.Width  = 80
1131:                         loc_oGrid.Column6.Width  = 100
1132:                         loc_oGrid.Column7.Width  = 70
1133:                         loc_oGrid.Column8.Width  = 80
1134:                         loc_oGrid.Column9.Width  = 55
1135:                         loc_oGrid.Column10.Width = 50
1136:                         loc_oGrid.Column11.Width = 55
1137: 
1138:                         *-- Headers APOS RecordSource (RecordSource reseta captions - Problem 2)
1139:                         loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"

*-- Linhas 1257 a 1275:
1257:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1258:                 MsgAviso("Selecione um registro na lista.", "Consultar")
1259:             ELSE
1260:                 SELECT cursor_4c_Dados
1261:                 loc_cEmpDopNums = ALLTRIM(TratarNulo(EmpDopNums, "C"))
1262: 
1263:                 IF EMPTY(loc_cEmpDopNums)
1264:                     MsgAviso("Registro sem identificador v" + CHR(225) + "lido.", "Consultar")
1265:                 ELSE
1266:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpDopNums)
1267:                         THIS.this_oBusinessObject.CarregarItens(loc_cEmpDopNums)
1268:                         THIS.this_oBusinessObject.CarregarOperacao(THIS.this_cDopes)
1269:                         THIS.BOParaForm()
1270:                         THIS.CarregarOperacaoGrid()
1271:                         THIS.CarregarItensGrid()
1272:                         THIS.pgf_4c_Paginas.ActivePage = 2
1273:                         THIS.this_cModoAtual = "VISUALIZAR"
1274:                         loc_lResultado = .T.
1275:                     ENDIF

*-- Linhas 1308 a 1346:
1308:                     USE IN cursor_4c_OperacoesTemp
1309:                 ENDIF
1310: 
1311:                 loc_cSQL = "SELECT a.Dopes FROM SigCdOpe a ORDER BY a.Dopes"
1312: 
1313:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacoesTemp")
1314:                 IF loc_nResultado >= 0
1315:                     IF USED("cursor_4c_Operacoes")
1316:                         SELECT cursor_4c_Operacoes
1317:                         ZAP
1318:                         APPEND FROM DBF("cursor_4c_OperacoesTemp")
1319:                     ELSE
1320:                         SELECT * FROM cursor_4c_OperacoesTemp INTO CURSOR cursor_4c_Operacoes READWRITE
1321:                     ENDIF
1322:                     IF USED("cursor_4c_OperacoesTemp")
1323:                         USE IN cursor_4c_OperacoesTemp
1324:                     ENDIF
1325: 
1326:                     loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Operacao
1327: 
1328:                     IF VARTYPE(loc_oGrid) = "O"
1329:                         loc_oGrid.ColumnCount = 1
1330:                         loc_oGrid.RecordSource = "cursor_4c_Operacoes"
1331:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Operacoes.Dopes"
1332:                         loc_oGrid.Column1.Width = 110
1333:                         loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1334:                         loc_oGrid.Refresh()
1335:                     ENDIF
1336: 
1337:                     loc_lSucesso = .T.
1338:                 ELSE
1339:                     MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + ;
1340:                             CHR(13) + CapturarErroSQL(), "Erro SQL")
1341:                 ENDIF
1342:             ENDIF
1343:         CATCH TO loException
1344:             MostrarErro(loException, "Formsigpres2.CarregarOperacaoGrid")
1345:         ENDTRY
1346: 

*-- Linhas 1516 a 1601:
1516: 
1517:     *==========================================================================
1518:     * CarregarItensGrid - Carrega itens do movimento em grd_4c_Itens
1519:     * JOIN SigMvPec + SigCdPam para descricao do produto (DPros)
1520:     *==========================================================================
1521:     PROTECTED PROCEDURE CarregarItensGrid()
1522:         LOCAL loc_cEmpDopNums, loc_cSQL, loc_nResultado, loc_oGrid, loc_lSucesso
1523:         loc_cEmpDopNums = ""
1524:         loc_lSucesso    = .F.
1525: 
1526:         TRY
1527:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1528:                 loc_lSucesso = .T.
1529:             ELSE
1530:                 loc_cEmpDopNums = THIS.this_oBusinessObject.this_cEmpDopNums
1531: 
1532:                 IF !EMPTY(loc_cEmpDopNums)
1533:                     IF USED("cursor_4c_ItensPamTemp")
1534:                         USE IN cursor_4c_ItensPamTemp
1535:                     ENDIF
1536: 
1537:                     loc_cSQL = "SELECT a.Codigos AS CPros," + ;
1538:                                " ISNULL(a.Cidchaves, 0) AS Produzido," + ;
1539:                                " ISNULL(a.Ntrans, 0) AS Ntrans," + ;
1540:                                " (ISNULL(a.Ntrans, 0) - ISNULL(a.Valobxs, 0)) AS Saldo," + ;
1541:                                " ISNULL(a.Valobxs, 0) AS Valobxs," + ;
1542:                                " CASE WHEN (ISNULL(a.Ntrans,0)-ISNULL(a.Valobxs,0)-ISNULL(a.Cidchaves,0))>0" + ;
1543:                                " THEN (ISNULL(a.Ntrans,0)-ISNULL(a.Valobxs,0)-ISNULL(a.Cidchaves,0))" + ;
1544:                                " ELSE 0 END AS Produzir," + ;
1545:                                " ISNULL(a.Nparcs, 0) AS Nparcs," + ;
1546:                                " CAST(0 AS DECIMAL(8,2)) AS Pesos," + ;
1547:                                " CASE WHEN ISNULL(a.Ntrans,0)>0" + ;
1548:                                " THEN CAST((ISNULL(a.Valobxs,0)*100.0/a.Ntrans) AS DECIMAL(8,2))" + ;
1549:                                " ELSE CAST(0 AS DECIMAL(8,2)) END AS PctEnt," + ;
1550:                                " ISNULL(a.Locals,'') AS Locals," + ;
1551:                                " ISNULL(p.DPros,'') AS DPros" + ;
1552:                                " FROM SigMvPec a" + ;
1553:                                " LEFT JOIN SigCdPam p ON p.MascNums = a.Codigos" + ;
1554:                                " WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + ;
1555:                                " ORDER BY a.Codigos"
1556: 
1557:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensPamTemp")
1558: 
1559:                     IF loc_nResultado >= 0
1560:                         IF USED("cursor_4c_ItensPam")
1561:                             SELECT cursor_4c_ItensPam
1562:                             ZAP
1563:                             APPEND FROM DBF("cursor_4c_ItensPamTemp")
1564:                         ELSE
1565:                             SELECT * FROM cursor_4c_ItensPamTemp INTO CURSOR cursor_4c_ItensPam READWRITE
1566:                         ENDIF
1567:                         IF USED("cursor_4c_ItensPamTemp")
1568:                             USE IN cursor_4c_ItensPamTemp
1569:                         ENDIF
1570: 
1571:                         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
1572: 
1573:                         IF VARTYPE(loc_oGrid) = "O"
1574:                             loc_oGrid.ColumnCount = 10
1575:                             loc_oGrid.RecordSource = "cursor_4c_ItensPam"
1576: 
1577:                             loc_oGrid.Column1.ControlSource  = "cursor_4c_ItensPam.CPros"
1578:                             loc_oGrid.Column2.ControlSource  = "cursor_4c_ItensPam.Produzido"
1579:                             loc_oGrid.Column3.ControlSource  = "cursor_4c_ItensPam.Ntrans"
1580:                             loc_oGrid.Column4.ControlSource  = "cursor_4c_ItensPam.Saldo"
1581:                             loc_oGrid.Column5.ControlSource  = "cursor_4c_ItensPam.Valobxs"
1582:                             loc_oGrid.Column6.ControlSource  = "cursor_4c_ItensPam.Produzir"
1583:                             loc_oGrid.Column7.ControlSource  = "cursor_4c_ItensPam.Nparcs"
1584:                             loc_oGrid.Column8.ControlSource  = "cursor_4c_ItensPam.Pesos"
1585:                             loc_oGrid.Column9.ControlSource  = "cursor_4c_ItensPam.PctEnt"
1586:                             loc_oGrid.Column10.ControlSource = "cursor_4c_ItensPam.Locals"
1587: 
1588:                             loc_oGrid.Column1.Width  = 80
1589:                             loc_oGrid.Column2.Width  = 65
1590:                             loc_oGrid.Column3.Width  = 55
1591:                             loc_oGrid.Column4.Width  = 55
1592:                             loc_oGrid.Column5.Width  = 60
1593:                             loc_oGrid.Column6.Width  = 55
1594:                             loc_oGrid.Column7.Width  = 35
1595:                             loc_oGrid.Column8.Width  = 55
1596:                             loc_oGrid.Column9.Width  = 45
1597:                             loc_oGrid.Column10.Width = 40
1598: 
1599:                             loc_oGrid.Column1.Header1.Caption  = "Produto"
1600:                             loc_oGrid.Column2.Header1.Caption  = "Produzido"
1601:                             loc_oGrid.Column3.Header1.Caption  = "Qtd."

*-- Linhas 1610 a 1628:
1610:                             loc_oGrid.Refresh()
1611: 
1612:                             IF RECCOUNT("cursor_4c_ItensPam") > 0
1613:                                 SELECT cursor_4c_ItensPam
1614:                                 GO TOP
1615:                                 THIS.GrdItensAfterRowColChange(0)
1616:                             ELSE
1617:                                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_Descr) = "O"
1618:                                     THIS.pgf_4c_Paginas.Page2.txt_4c_Descr.Value = ""
1619:                                 ENDIF
1620:                                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_ObsItem) = "O"
1621:                                     THIS.pgf_4c_Paginas.Page2.txt_4c_ObsItem.Value = ""
1622:                                 ENDIF
1623:                                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg) = "O"
1624:                                     THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg.Picture = ""
1625:                                     THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg.Visible = .F.
1626:                                 ENDIF
1627:                             ENDIF
1628:                         ENDIF

*-- Linhas 1659 a 1677:
1659:             IF !USED("cursor_4c_ItensPam") OR EOF("cursor_4c_ItensPam")
1660:                 loc_lVazio = .T.
1661:             ELSE
1662:                 SELECT cursor_4c_ItensPam
1663:                 loc_cCPros = ALLTRIM(TratarNulo(CPros, "C"))
1664:                 loc_cDPros = ALLTRIM(TratarNulo(DPros, "C"))
1665:             ENDIF
1666: 
1667:             IF loc_lVazio
1668:                 IF VARTYPE(loc_oPagina.txt_4c_Descr) = "O"
1669:                     loc_oPagina.txt_4c_Descr.Value = ""
1670:                 ENDIF
1671:                 IF VARTYPE(loc_oPagina.txt_4c_ObsItem) = "O"
1672:                     loc_oPagina.txt_4c_ObsItem.Value = ""
1673:                 ENDIF
1674:                 IF VARTYPE(loc_oPagina.img_4c_FigJpg) = "O"
1675:                     loc_oPagina.img_4c_FigJpg.Picture = ""
1676:                     loc_oPagina.img_4c_FigJpg.Visible = .F.
1677:                 ENDIF

*-- Linhas 1688 a 1710:
1688:                     IF USED("cursor_4c_FigPro")
1689:                         USE IN cursor_4c_FigPro
1690:                     ENDIF
1691:                     loc_cSQLFig = "SELECT TOP 1 a.FigJpgs FROM SigCdPro a" + ;
1692:                                   " WHERE a.CPros = " + EscaparSQL(loc_cCPros)
1693:                     loc_nFig = SQLEXEC(gnConnHandle, loc_cSQLFig, "cursor_4c_FigPro")
1694:                     IF loc_nFig >= 0 AND RECCOUNT("cursor_4c_FigPro") > 0
1695:                         SELECT cursor_4c_FigPro
1696:                         loc_cFigJpgs = ALLTRIM(TratarNulo(FigJpgs, "C"))
1697:                     ENDIF
1698:                     IF USED("cursor_4c_FigPro")
1699:                         USE IN cursor_4c_FigPro
1700:                     ENDIF
1701:                 ENDIF
1702: 
1703:                 IF VARTYPE(loc_oPagina.img_4c_FigJpg) = "O"
1704:                     IF !EMPTY(loc_cFigJpgs) AND FILE(loc_cFigJpgs)
1705:                         loc_oPagina.img_4c_FigJpg.Picture = loc_cFigJpgs
1706:                         loc_oPagina.img_4c_FigJpg.Visible = .T.
1707:                     ELSE
1708:                         loc_oPagina.img_4c_FigJpg.Picture = ""
1709:                         loc_oPagina.img_4c_FigJpg.Visible = .F.
1710:                     ENDIF


### BO (C:\4c\projeto\app\classes\sigpres2BO.prg):
*==============================================================================
* sigpres2BO.prg - Business Object para SIGPRES2 (Detalhe de Movimento)
* Herda de BusinessBase
* Formulario OPERACIONAL - consulta de itens de movimento de pedido
*==============================================================================

DEFINE CLASS sigpres2BO AS BusinessBase

    *-- Chave composta do movimento: Emps+Dopes+Str(Numes,6) padded
    this_cEmpDopNums = ""

    *-- Identificacao do movimento
    this_cEmps        = ""  && Empresa origem C(3)
    this_cDopes       = ""  && Tipo de operacao C(20)
    this_nNumes       = 0   && Numero do movimento N(6,0)
    this_cChave       = ""  && _Chave passado no Init (= Dopes)
    this_cMascNum     = ""  && Codigo mascarado do movimento C(10) - SigMvCab.mascnum

    *-- Cabecalho do movimento (SigMvCab)
    this_dDatas       = {}  && Data do movimento D - SigMvCab.datas
    this_cNotas       = ""  && Numero do documento C(6) - SigMvCab.notas
    this_nNops        = 0   && Numero da OP N - SigMvCab.nops
    this_cPStatus     = ""  && Status do pedido C(1) - SigMvCab.pstatus
    this_cTabds       = ""  && Tabela de desconto C(10) - SigMvCab.tabds
    this_cUsuars      = ""  && Usuario C(10) - SigMvCab.usuars
    this_dPrazoEnts   = {}  && Prazo de entrega D - SigMvCab.prazoents
    this_cObses       = ""  && Observacoes do movimento C/M - SigMvCab.obses
    this_lChkSubn     = .F. && Possui sub-niveis L - SigMvCab.chksubn
    this_lChkBxParcs  = .F. && Baixa parcial L - SigMvCab.chkbxparcs

    *-- Origem (conta origem) - SigMvCab
    this_cGrupoOs     = ""  && Grupo de conta origem C(10) - SigMvCab.grupoos
    this_cContaOs     = ""  && Conta origem C(10) - SigMvCab.contaos
    this_cDContaOs    = ""  && Descricao da conta origem C (de SigCdCli)

    *-- Destino (conta destino) - SigMvCab
    this_cGrupoDs     = ""  && Grupo de conta destino C(10) - SigMvCab.grupods
    this_cContaDs     = ""  && Conta destino C(10) - SigMvCab.contads
    this_cDContaDs    = ""  && Descricao da conta destino C (de SigCdCli)
    this_cEmpds       = ""  && Empresa destino C(3) - SigMvCab.empds

    *-- Vendedor - SigMvCab
    this_cGrvends     = ""  && Grupo do vendedor C(10) - SigMvCab.grvends
    this_cVends       = ""  && Codigo do vendedor C(10) - SigMvCab.vends
    this_cDVends      = ""  && Descricao do vendedor C (de SigCdCli)

    *-- Representante - SigMvCab
    this_cGrresps     = ""  && Grupo do representante C(10) - SigMvCab.grresps
    this_cResps       = ""  && Codigo do representante C(10) - SigMvCab.resps
    this_cDResps      = ""  && Descricao do representante C (de SigCdCli)

    *-- Configuracao da operacao (SigCdOpe)
    this_nBlqDatas    = 0   && Bloqueio de datas N - SigCdOpe.blqdatas
    this_nDtEntrs     = 0   && Tipo de entrega N - SigCdOpe.dtentrs

    *-- Tipo de instalacao (global gcTpInstalas)
    this_cTpInstalas  = ""  && Tipo de instalacao C

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de movimentos filtrados pelo Dopes (operacao)
    * par_cFiltro: filtro SQL adicional (WHERE clause extra, sem WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.EmpDopNums, a.Emps, a.Dopes, a.Numes," + ;
                       " a.Datas, a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs," + ;
                       " a.Nops, a.Usuars, a.PStatus, a.Empds" + ;
                       " FROM SigMvCab a" + ;
                       " WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopes)

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Numes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar movimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega cabecalho do movimento por EmpDopNums
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.EmpDopNums, a.Emps, a.Dopes, a.Numes, a.MascNum," + ;
                       " a.Datas, a.Notas, a.Nops, a.PStatus, a.Tabds, a.Usuars," + ;
                       " a.PrazoEnts, a.Obses, a.ChkSubn, a.ChkBxParcs," + ;
                       " a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, a.Empds," + ;
                       " a.Vends, a.Grvends, a.Resps, a.Grresps" + ;
                       " FROM SigMvCab a" + ;
                       " WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lSucesso
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * REGRA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cEmpDopNums  = ALLTRIM(TratarNulo(EmpDopNums, "C"))
            THIS.this_cEmps        = ALLTRIM(TratarNulo(Emps, "C"))
            THIS.this_cDopes       = ALLTRIM(TratarNulo(Dopes, "C"))
            THIS.this_nNumes       = TratarNulo(Numes, "N")

            *-- MascNum so existe no cursor completo (CarregarPorCodigo)
            IF TYPE("MascNum") != "U"
                THIS.this_cMascNum = ALLTRIM(TratarNulo(MascNum, "C"))
            ENDIF

            THIS.this_dDatas       = TratarNulo(Datas, "D")
            THIS.this_dPrazoEnts   = TratarNulo(PrazoEnts, "D")
            THIS.this_cNotas       = ALLTRIM(TratarNulo(Notas, "C"))
            THIS.this_nNops        = TratarNulo(Nops, "N")
            THIS.this_cPStatus     = ALLTRIM(TratarNulo(PStatus, "C"))
            THIS.this_cTabds       = ALLTRIM(TratarNulo(Tabds, "C"))
            THIS.this_cUsuars      = ALLTRIM(TratarNulo(Usuars, "C"))
            THIS.this_cObses       = TratarNulo(Obses, "C")
            THIS.this_lChkSubn     = (TratarNulo(ChkSubn, "N") = 1)
            THIS.this_lChkBxParcs  = (TratarNulo(ChkBxParcs, "N") = 1)

            THIS.this_cGrupoOs     = ALLTRIM(TratarNulo(GrupoOs, "C"))
            THIS.this_cContaOs     = ALLTRIM(TratarNulo(ContaOs, "C"))
            THIS.this_cGrupoDs     = ALLTRIM(TratarNulo(GrupoDs, "C"))
            THIS.this_cContaDs     = ALLTRIM(TratarNulo(ContaDs, "C"))
            THIS.this_cEmpds       = ALLTRIM(TratarNulo(Empds, "C"))

            THIS.this_cGrvends     = ALLTRIM(TratarNulo(Grvends, "C"))
            THIS.this_cVends       = ALLTRIM(TratarNulo(Vends, "C"))
            THIS.this_cGrresps     = ALLTRIM(TratarNulo(Grresps, "C"))
            THIS.this_cResps       = ALLTRIM(TratarNulo(Resps, "C"))

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - Carrega itens do movimento (SigMvPec) por EmpDopNums
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_cSQL = "SELECT a.EmpDopNums, a.Codigos, a.Emps, a.Dopes, a.Numes," + ;
                       " a.Datas, a.Ntrans, a.Locals, a.Valobxs, a.Cidchaves," + ;
                       " a.ChkSubn, a.ChkPagos, a.Nparcs, a.Valps, a.PStatus" + ;
                       " FROM SigMvPec a" + ;
                       " WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + ;
                       " ORDER BY a.Codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarItens:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacao - Carrega configuracao da operacao (SigCdOpe)
    * Popula this_nBlqDatas e this_nDtEntrs
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacao(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Operacao")
                USE IN cursor_4c_Operacao
            ENDIF

            loc_cSQL = "SELECT a.Dopes, a.BlqDatas, a.DtEntrs" + ;
                       " FROM SigCdOpe a" + ;
                       " WHERE a.Dopes = " + EscaparSQL(par_cDopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacao")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Operacao") > 0
                SELECT cursor_4c_Operacao
                THIS.this_nBlqDatas = TratarNulo(BlqDatas, "N")
                THIS.this_nDtEntrs  = TratarNulo(DtEntrs, "N")
                loc_lSucesso = .T.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar opera" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarOperacao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Operacao")
            USE IN cursor_4c_Operacao
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescricaoConta - Carrega descricao de uma conta (SigCdCli)
    * Retorna a descricao ou string vazia se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescricaoConta(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        IF EMPTY(par_cConta)
            RETURN loc_cDescricao
        ENDIF

        TRY
            IF USED("cursor_4c_DescConta")
                USE IN cursor_4c_DescConta
            ENDIF

            loc_cSQL = "SELECT TOP 1 a.IClis, a.Rclis" + ;
                       " FROM SigCdCli a" + ;
                       " WHERE a.IClis = " + EscaparSQL(par_cConta)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescConta")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescConta") > 0
                SELECT cursor_4c_DescConta
                loc_cDescricao = ALLTRIM(TratarNulo(Rclis, "C"))
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarDescricaoConta:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_DescConta")
            USE IN cursor_4c_DescConta
        ENDIF

        RETURN loc_cDescricao
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO aplicavel para este formulario operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        MsgErro("Inser" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
                CHR(237) + "vel neste formul" + CHR(225) + "rio.", "Aviso")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigMvCab (data, contas origem/destino, obs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cEmpDopNums)
            MsgErro("Chave do movimento n" + CHR(227) + "o definida.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigMvCab SET" + ;
                       " Datas = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " GrupoOs = " + EscaparSQL(THIS.this_cGrupoOs) + "," + ;
                       " ContaOs = " + EscaparSQL(THIS.this_cContaOs) + "," + ;
                       " GrupoDs = " + EscaparSQL(THIS.this_cGrupoDs) + "," + ;
                       " ContaDs = " + EscaparSQL(THIS.this_cContaDs) + "," + ;
                       " Vends = " + EscaparSQL(THIS.this_cVends) + "," + ;
                       " Grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;
                       " PrazoEnts = " + FormatarDataSQL(THIS.this_dPrazoEnts) + "," + ;
                       " Notas = " + EscaparSQL(THIS.this_cNotas) + "," + ;
                       " Tabds = " + EscaparSQL(THIS.this_cTabds) + "," + ;
                       " Obses = " + EscaparSQL(THIS.this_cObses) + "," + ;
                       " DtAlts = GETDATE()" + ;
                       " WHERE EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNums)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")
            IF loc_nResultado >= 0
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - NAO aplicavel para este formulario operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        MsgErro("Exclus" + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
                CHR(237) + "vel neste formul" + CHR(225) + "rio.", "Aviso")
        RETURN .F.
    ENDPROC

ENDDEFINE

