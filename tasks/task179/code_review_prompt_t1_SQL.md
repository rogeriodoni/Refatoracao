# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (13)
- [GRID-SQL] Campo 'CPros' usado em ControlSource de cursor_4c_ItensPam mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Produzido' usado em ControlSource de cursor_4c_ItensPam mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Ntrans' usado em ControlSource de cursor_4c_ItensPam mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Saldo' usado em ControlSource de cursor_4c_ItensPam mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Valobxs' usado em ControlSource de cursor_4c_ItensPam mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Produzir' usado em ControlSource de cursor_4c_ItensPam mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Nparcs' usado em ControlSource de cursor_4c_ItensPam mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Pesos' usado em ControlSource de cursor_4c_ItensPam mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'PctEnt' usado em ControlSource de cursor_4c_ItensPam mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Locals' usado em ControlSource de cursor_4c_ItensPam mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GCTPINSTALAS, CPROS, CITENS, EMPDOPNUMS, BLQDATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GCTPINSTALAS, CPROS, CITENS, EMPDOPNUMS, BLQDATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MASCNUMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GCTPINSTALAS, CPROS, CITENS, EMPDOPNUMS, BLQDATAS

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg) - TRECHOS RELEVANTES PARA PASS SQL (1928 linhas total):

*-- Linhas 226 a 244:
226:             .Left               = 26
227:             .Width              = 890
228:             .Height             = 460
229:             .DeleteMark         = .F.
230:             .RecordMark         = .F.
231:             .GridLineColor      = RGB(238, 238, 238)
232:             .HighlightBackColor = RGB(255, 255, 255)
233:             .HighlightForeColor = RGB(15, 41, 104)
234:             .HighlightStyle     = 2
235:             .FontName           = "Verdana"
236:             .FontSize           = 8
237:             .ForeColor          = RGB(90, 90, 90)
238:             .BackColor          = RGB(255, 255, 255)
239:             .RowHeight          = 16
240:             .ScrollBars         = 2
241:             .GridLines          = 3
242:             .Visible            = .T.
243:         ENDWITH
244: 

*-- Linhas 330 a 348:
330:             .Left               = 679
331:             .Width              = 112
332:             .Height             = 148
333:             .DeleteMark         = .F.
334:             .RecordMark         = .F.
335:             .GridLineColor      = RGB(238, 238, 238)
336:             .HighlightBackColor = RGB(255, 255, 255)
337:             .HighlightForeColor = RGB(15, 41, 104)
338:             .HighlightStyle     = 2
339:             .FontName           = "Verdana"
340:             .FontSize           = 8
341:             .ForeColor          = RGB(90, 90, 90)
342:             .BackColor          = RGB(255, 255, 255)
343:             .RowHeight          = 16
344:             .ScrollBars         = 2
345:             .GridLines          = 1
346:             .Visible            = .T.
347:         ENDWITH
348: 

*-- Linhas 977 a 995:
977:             .Left               = 23
978:             .Width              = 732
979:             .Height             = 191
980:             .DeleteMark         = .F.
981:             .RecordMark         = .F.
982:             .AllowHeaderSizing  = .F.
983:             .GridLineColor      = RGB(238, 238, 238)
984:             .HighlightBackColor = RGB(255, 255, 255)
985:             .HighlightForeColor = RGB(15, 41, 104)
986:             .HighlightStyle     = 2
987:             .FontName           = "Tahoma"
988:             .FontSize           = 8
989:             .ForeColor          = RGB(0, 0, 0)
990:             .BackColor          = RGB(255, 255, 255)
991:             .RowHeight          = 17
992:             .HeaderHeight       = 17
993:             .ScrollBars         = 2
994:             .ReadOnly           = .T.
995:             .Visible            = .T.

*-- Linhas 1107 a 1136:
1107:                         loc_oGrid.ColumnCount = 11
1108:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1109: 
1110:                         *-- ControlSource APOS RecordSource (auto-bind e substituido)
1111:                         loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.Numes"
1112:                         loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.Datas"
1113:                         loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.GrupoOs"
1114:                         loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.ContaOs"
1115:                         loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.GrupoDs"
1116:                         loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.ContaDs"
1117:                         loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.Nops"
1118:                         loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.Usuars"
1119:                         loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.PStatus"
1120:                         loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.Emps"
1121:                         loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.Empds"
1122: 
1123:                         loc_oGrid.Column1.Width  = 70
1124:                         loc_oGrid.Column2.Width  = 70
1125:                         loc_oGrid.Column3.Width  = 80
1126:                         loc_oGrid.Column4.Width  = 100
1127:                         loc_oGrid.Column5.Width  = 80
1128:                         loc_oGrid.Column6.Width  = 100
1129:                         loc_oGrid.Column7.Width  = 70
1130:                         loc_oGrid.Column8.Width  = 80
1131:                         loc_oGrid.Column9.Width  = 55
1132:                         loc_oGrid.Column10.Width = 50
1133:                         loc_oGrid.Column11.Width = 55
1134: 
1135:                         *-- Headers APOS RecordSource (RecordSource reseta captions - Problem 2)
1136:                         loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"

*-- Linhas 1161 a 1185:
1161: 
1162:     *==========================================================================
1163:     * Destroy - Libera recursos ao fechar o formulario
1164:     *==========================================================================
1165:     PROCEDURE Destroy()
1166:         IF USED("cursor_4c_ItensPam")
1167:             USE IN cursor_4c_ItensPam
1168:         ENDIF
1169:         IF USED("cursor_4c_ItensPamTemp")
1170:             USE IN cursor_4c_ItensPamTemp
1171:         ENDIF
1172:         IF USED("cursor_4c_FigPro")
1173:             USE IN cursor_4c_FigPro
1174:         ENDIF
1175:         IF USED("cursor_4c_Operacoes")
1176:             USE IN cursor_4c_Operacoes
1177:         ENDIF
1178:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1179:             THIS.this_oBusinessObject = .NULL.
1180:         ENDIF
1181:         DODEFAULT()
1182:     ENDPROC
1183: 
1184:     *==========================================================================
1185:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente

*-- Linhas 1247 a 1265:
1247:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1248:                 MsgAviso("Selecione um registro na lista.", "Consultar")
1249:             ELSE
1250:                 SELECT cursor_4c_Dados
1251:                 loc_cEmpDopNums = ALLTRIM(TratarNulo(EmpDopNums, "C"))
1252: 
1253:                 IF EMPTY(loc_cEmpDopNums)
1254:                     MsgAviso("Registro sem identificador v" + CHR(225) + "lido.", "Consultar")
1255:                 ELSE
1256:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpDopNums)
1257:                         THIS.this_oBusinessObject.CarregarItens(loc_cEmpDopNums)
1258:                         THIS.this_oBusinessObject.CarregarOperacao(THIS.this_cDopes)
1259:                         THIS.BOParaForm()
1260:                         THIS.CarregarOperacaoGrid()
1261:                         THIS.CarregarItensGrid()
1262:                         THIS.pgf_4c_Paginas.ActivePage = 2
1263:                         THIS.this_cModoAtual = "VISUALIZAR"
1264:                         loc_lResultado = .T.
1265:                     ENDIF

*-- Linhas 1298 a 1325:
1298:                     USE IN cursor_4c_Operacoes
1299:                 ENDIF
1300: 
1301:                 loc_cSQL = "SELECT a.Dopes FROM SigCdOpe a ORDER BY a.Dopes"
1302: 
1303:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")
1304:                 IF loc_nResultado >= 0
1305:                     loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Operacao
1306: 
1307:                     IF VARTYPE(loc_oGrid) = "O"
1308:                         loc_oGrid.ColumnCount = 1
1309:                         loc_oGrid.RecordSource = "cursor_4c_Operacoes"
1310:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Operacoes.Dopes"
1311:                         loc_oGrid.Column1.Width = 110
1312:                         loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1313:                         loc_oGrid.Refresh()
1314:                     ENDIF
1315: 
1316:                     loc_lSucesso = .T.
1317:                 ELSE
1318:                     MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + ;
1319:                             CHR(13) + CapturarErroSQL(), "Erro SQL")
1320:                 ENDIF
1321:             ENDIF
1322:         CATCH TO loException
1323:             MostrarErro(loException, "Formsigpres2.CarregarOperacaoGrid")
1324:         ENDTRY
1325: 

*-- Linhas 1495 a 1569:
1495: 
1496:     *==========================================================================
1497:     * CarregarItensGrid - Carrega itens do movimento em grd_4c_Itens
1498:     * JOIN SigMvPec + SigCdPam para descricao do produto (DPros)
1499:     *==========================================================================
1500:     PROTECTED PROCEDURE CarregarItensGrid()
1501:         LOCAL loc_cEmpDopNums, loc_cSQL, loc_nResultado, loc_oGrid, loc_lSucesso
1502:         loc_cEmpDopNums = ""
1503:         loc_lSucesso    = .F.
1504: 
1505:         TRY
1506:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1507:                 loc_lSucesso = .T.
1508:             ELSE
1509:                 loc_cEmpDopNums = THIS.this_oBusinessObject.this_cEmpDopNums
1510: 
1511:                 IF !EMPTY(loc_cEmpDopNums)
1512:                     IF USED("cursor_4c_ItensPam")
1513:                         USE IN cursor_4c_ItensPam
1514:                     ENDIF
1515: 
1516:                     loc_cSQL = "SELECT a.Codigos AS CPros," + ;
1517:                                " ISNULL(a.Cidchaves, 0) AS Produzido," + ;
1518:                                " ISNULL(a.Ntrans, 0) AS Ntrans," + ;
1519:                                " (ISNULL(a.Ntrans, 0) - ISNULL(a.Valobxs, 0)) AS Saldo," + ;
1520:                                " ISNULL(a.Valobxs, 0) AS Valobxs," + ;
1521:                                " CASE WHEN (ISNULL(a.Ntrans,0)-ISNULL(a.Valobxs,0)-ISNULL(a.Cidchaves,0))>0" + ;
1522:                                " THEN (ISNULL(a.Ntrans,0)-ISNULL(a.Valobxs,0)-ISNULL(a.Cidchaves,0))" + ;
1523:                                " ELSE 0 END AS Produzir," + ;
1524:                                " ISNULL(a.Nparcs, 0) AS Nparcs," + ;
1525:                                " CAST(0 AS DECIMAL(8,2)) AS Pesos," + ;
1526:                                " CASE WHEN ISNULL(a.Ntrans,0)>0" + ;
1527:                                " THEN CAST((ISNULL(a.Valobxs,0)*100.0/a.Ntrans) AS DECIMAL(8,2))" + ;
1528:                                " ELSE CAST(0 AS DECIMAL(8,2)) END AS PctEnt," + ;
1529:                                " ISNULL(a.Locals,'') AS Locals," + ;
1530:                                " ISNULL(p.DPros,'') AS DPros" + ;
1531:                                " FROM SigMvPec a" + ;
1532:                                " LEFT JOIN SigCdPam p ON p.MascNums = a.Codigos" + ;
1533:                                " WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + ;
1534:                                " ORDER BY a.Codigos"
1535: 
1536:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensPam")
1537: 
1538:                     IF loc_nResultado >= 0
1539:                         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
1540: 
1541:                         IF VARTYPE(loc_oGrid) = "O"
1542:                             loc_oGrid.ColumnCount = 10
1543:                             loc_oGrid.RecordSource = "cursor_4c_ItensPam"
1544: 
1545:                             loc_oGrid.Column1.ControlSource  = "cursor_4c_ItensPam.CPros"
1546:                             loc_oGrid.Column2.ControlSource  = "cursor_4c_ItensPam.Produzido"
1547:                             loc_oGrid.Column3.ControlSource  = "cursor_4c_ItensPam.Ntrans"
1548:                             loc_oGrid.Column4.ControlSource  = "cursor_4c_ItensPam.Saldo"
1549:                             loc_oGrid.Column5.ControlSource  = "cursor_4c_ItensPam.Valobxs"
1550:                             loc_oGrid.Column6.ControlSource  = "cursor_4c_ItensPam.Produzir"
1551:                             loc_oGrid.Column7.ControlSource  = "cursor_4c_ItensPam.Nparcs"
1552:                             loc_oGrid.Column8.ControlSource  = "cursor_4c_ItensPam.Pesos"
1553:                             loc_oGrid.Column9.ControlSource  = "cursor_4c_ItensPam.PctEnt"
1554:                             loc_oGrid.Column10.ControlSource = "cursor_4c_ItensPam.Locals"
1555: 
1556:                             loc_oGrid.Column1.Width  = 80
1557:                             loc_oGrid.Column2.Width  = 65
1558:                             loc_oGrid.Column3.Width  = 55
1559:                             loc_oGrid.Column4.Width  = 55
1560:                             loc_oGrid.Column5.Width  = 60
1561:                             loc_oGrid.Column6.Width  = 55
1562:                             loc_oGrid.Column7.Width  = 35
1563:                             loc_oGrid.Column8.Width  = 55
1564:                             loc_oGrid.Column9.Width  = 45
1565:                             loc_oGrid.Column10.Width = 40
1566: 
1567:                             loc_oGrid.Column1.Header1.Caption  = "Produto"
1568:                             loc_oGrid.Column2.Header1.Caption  = "Produzido"
1569:                             loc_oGrid.Column3.Header1.Caption  = "Qtd."

*-- Linhas 1575 a 1596:
1575:                             loc_oGrid.Column9.Header1.Caption  = "%Ent."
1576:                             loc_oGrid.Column10.Header1.Caption = "Tam."
1577: 
1578:                             loc_oGrid.Refresh()
1579: 
1580:                             IF RECCOUNT("cursor_4c_ItensPam") > 0
1581:                                 SELECT cursor_4c_ItensPam
1582:                                 GO TOP
1583:                                 THIS.GrdItensAfterRowColChange(0)
1584:                             ELSE
1585:                                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_Descr) = "O"
1586:                                     THIS.pgf_4c_Paginas.Page2.txt_4c_Descr.Value = ""
1587:                                 ENDIF
1588:                                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_ObsItem) = "O"
1589:                                     THIS.pgf_4c_Paginas.Page2.txt_4c_ObsItem.Value = ""
1590:                                 ENDIF
1591:                                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg) = "O"
1592:                                     THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg.Picture = ""
1593:                                     THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg.Visible = .F.
1594:                                 ENDIF
1595:                             ENDIF
1596:                         ENDIF

*-- Linhas 1622 a 1645:
1622:         loc_nFig     = 0
1623:         loc_cFigJpgs = ""
1624:         loc_lVazio   = .F.
1625: 
1626:         TRY
1627:             IF !USED("cursor_4c_ItensPam") OR EOF("cursor_4c_ItensPam")
1628:                 loc_lVazio = .T.
1629:             ELSE
1630:                 SELECT cursor_4c_ItensPam
1631:                 loc_cCPros = ALLTRIM(TratarNulo(CPros, "C"))
1632:                 loc_cDPros = ALLTRIM(TratarNulo(DPros, "C"))
1633:             ENDIF
1634: 
1635:             IF loc_lVazio
1636:                 IF VARTYPE(loc_oPagina.txt_4c_Descr) = "O"
1637:                     loc_oPagina.txt_4c_Descr.Value = ""
1638:                 ENDIF
1639:                 IF VARTYPE(loc_oPagina.txt_4c_ObsItem) = "O"
1640:                     loc_oPagina.txt_4c_ObsItem.Value = ""
1641:                 ENDIF
1642:                 IF VARTYPE(loc_oPagina.img_4c_FigJpg) = "O"
1643:                     loc_oPagina.img_4c_FigJpg.Picture = ""
1644:                     loc_oPagina.img_4c_FigJpg.Visible = .F.
1645:                 ENDIF

*-- Linhas 1656 a 1678:
1656:                     IF USED("cursor_4c_FigPro")
1657:                         USE IN cursor_4c_FigPro
1658:                     ENDIF
1659:                     loc_cSQLFig = "SELECT TOP 1 a.FigJpgs FROM SigCdPro a" + ;
1660:                                   " WHERE a.MascNums = " + EscaparSQL(loc_cCPros)
1661:                     loc_nFig = SQLEXEC(gnConnHandle, loc_cSQLFig, "cursor_4c_FigPro")
1662:                     IF loc_nFig >= 0 AND RECCOUNT("cursor_4c_FigPro") > 0
1663:                         SELECT cursor_4c_FigPro
1664:                         loc_cFigJpgs = ALLTRIM(TratarNulo(FigJpgs, "C"))
1665:                     ENDIF
1666:                     IF USED("cursor_4c_FigPro")
1667:                         USE IN cursor_4c_FigPro
1668:                     ENDIF
1669:                 ENDIF
1670: 
1671:                 IF VARTYPE(loc_oPagina.img_4c_FigJpg) = "O"
1672:                     IF !EMPTY(loc_cFigJpgs) AND FILE(loc_cFigJpgs)
1673:                         loc_oPagina.img_4c_FigJpg.Picture = loc_cFigJpgs
1674:                         loc_oPagina.img_4c_FigJpg.Visible = .T.
1675:                     ELSE
1676:                         loc_oPagina.img_4c_FigJpg.Picture = ""
1677:                         loc_oPagina.img_4c_FigJpg.Visible = .F.
1678:                     ENDIF


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

