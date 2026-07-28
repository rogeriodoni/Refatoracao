# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1288: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormBch.prg) - TRECHOS RELEVANTES PARA PASS GRID (2832 linhas total):

*-- Linhas 371 a 391:
371:         BINDEVENT(loc_oPg1.cmd_4c_Fecha, "Click", THIS, "BtnFechaClick")
372: 
373:         *-- Grid da lista: top=129+29=158, left=33, width=941, height=461
374:         loc_oPg1.AddObject("grd_4c_Dados", "Grid")
375:         loc_oGrid = loc_oPg1.grd_4c_Dados
376:         loc_oGrid.ColumnCount = 6
377:         WITH loc_oGrid
378:             .Top                = 158
379:             .Left               = 33
380:             .Width              = 941
381:             .Height             = 461
382:             .FontName           = "Verdana"
383:             .FontSize           = 8
384:             .ForeColor          = RGB(90, 90, 90)
385:             .BackColor          = RGB(255, 255, 255)
386:             .GridLineColor      = RGB(238, 238, 238)
387:             .HighlightBackColor = RGB(255, 255, 255)
388:             .HighlightForeColor = RGB(15, 41, 104)
389:             .HighlightStyle     = 2
390:             .DeleteMark         = .F.
391:             .RecordMark         = .F.

*-- Linhas 397 a 435:
397: 
398:         WITH loc_oGrid.Column1
399:             .Width = 60
400:             .Header1.Caption = "C" + CHR(243) + "digo"
401:         ENDWITH
402:         WITH loc_oGrid.Column2
403:             .Width = 90
404:             .Header1.Caption = "In" + CHR(237) + "cio"
405:         ENDWITH
406:         WITH loc_oGrid.Column3
407:             .Width = 90
408:             .Header1.Caption = "T" + CHR(233) + "rmino"
409:         ENDWITH
410:         WITH loc_oGrid.Column4
411:             .Width = 120
412:             .Header1.Caption = "Tipo"
413:         ENDWITH
414:         WITH loc_oGrid.Column5
415:             .Width = 80
416:             .Header1.Caption = "Grupo"
417:         ENDWITH
418:         WITH loc_oGrid.Column6
419:             .Width = 80
420:             .Header1.Caption = "Conta"
421:         ENDWITH
422: 
423:         THIS.TornarControlesVisiveis(loc_oPg1)
424:     ENDPROC
425: 
426:     *--------------------------------------------------------------------------
427:     * ConfigurarPaginaDados - Page2: container salva + todos os campos de edicao
428:     * Compensacao +29 em todos os Top pelo PageFrame.Top=-29
429:     * Lookups/Valid handlers implementados na Fase 6
430:     *--------------------------------------------------------------------------
431:     PROTECTED PROCEDURE ConfigurarPaginaDados()
432:         LOCAL loc_oPg2, loc_oSalva
433: 
434:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
435: 

*-- Linhas 1266 a 1351:
1266:         * 6. Grade de historico de leitura (GradeLeitura)
1267:         *    cursor_4c_Historico: bancos, agencias, ncontas, ncheques, vencs, valors
1268:         *======================================================
1269:         loc_oPg3.AddObject("grd_4c_Leitura", "GridBase")
1270:         loc_oGrid = loc_oPg3.grd_4c_Leitura
1271:         WITH loc_oGrid
1272:             .Top           = 345
1273:             .Left          = 357
1274:             .Width         = 475
1275:             .Height        = 192
1276:             .ReadOnly      = .T.
1277:             .RecordMark    = .F.
1278:             .DeleteMark    = .F.
1279:             .GridLines     = 2
1280:             .GridLineWidth = 1
1281:             .GridLineColor = RGB(192, 192, 192)
1282:             .HeaderHeight  = 20
1283:             .RowHeight     = 20
1284:             .ScrollBars    = 3
1285:             .Visible       = .T.
1286:         ENDWITH
1287:         loc_oGrid.ColumnCount  = 6
1288:         loc_oGrid.RecordSource = "cursor_4c_Historico"
1289: 
1290:         WITH loc_oGrid.Column1
1291:             .Width         = 55
1292:             .ControlSource = "cursor_4c_Historico.bancos"
1293:             .ReadOnly      = .T.
1294:             .Resizable     = .T.
1295:         ENDWITH
1296:         loc_oGrid.Column1.Header1.Caption = "Banco"
1297: 
1298:         WITH loc_oGrid.Column2
1299:             .Width         = 55
1300:             .ControlSource = "cursor_4c_Historico.agencias"
1301:             .ReadOnly      = .T.
1302:             .Resizable     = .T.
1303:         ENDWITH
1304:         loc_oGrid.Column2.Header1.Caption = "Ag" + CHR(234) + "ncia"
1305: 
1306:         WITH loc_oGrid.Column3
1307:             .Width         = 70
1308:             .ControlSource = "cursor_4c_Historico.ncontas"
1309:             .ReadOnly      = .T.
1310:             .Resizable     = .T.
1311:         ENDWITH
1312:         loc_oGrid.Column3.Header1.Caption = "N" + CHR(250) + ". Conta"
1313: 
1314:         WITH loc_oGrid.Column4
1315:             .Width         = 70
1316:             .ControlSource = "cursor_4c_Historico.ncheques"
1317:             .ReadOnly      = .T.
1318:             .Resizable     = .T.
1319:         ENDWITH
1320:         loc_oGrid.Column4.Header1.Caption = "N" + CHR(250) + ". Cheque"
1321: 
1322:         WITH loc_oGrid.Column5
1323:             .Width         = 75
1324:             .ControlSource = "cursor_4c_Historico.vencs"
1325:             .ReadOnly      = .T.
1326:             .Resizable     = .T.
1327:         ENDWITH
1328:         loc_oGrid.Column5.Header1.Caption = "Vencimento"
1329: 
1330:         WITH loc_oGrid.Column6
1331:             .Width         = 80
1332:             .ControlSource = "cursor_4c_Historico.valors"
1333:             .ReadOnly      = .T.
1334:             .Resizable     = .T.
1335:         ENDWITH
1336:         loc_oGrid.Column6.Header1.Caption = "Valor"
1337: 
1338:         *======================================================
1339:         * 7. Container botoes: Excluir / Gravar / Cancelar
1340:         *======================================================
1341:         loc_oPg3.AddObject("cnt_4c_BotoesLeitura", "Container")
1342:         loc_oBotoesLeitura = loc_oPg3.cnt_4c_BotoesLeitura
1343:         WITH loc_oBotoesLeitura
1344:             .Top         = 31
1345:             .Left        = 773
1346:             .Width       = 225
1347:             .Height      = 85
1348:             .BackStyle   = 0
1349:             .BorderWidth = 0
1350:             .Visible     = .T.
1351:         ENDWITH

*-- Linhas 1430 a 1471:
1430:                 IF !THIS.this_oBusinessObject.Buscar("")
1431:                     loc_lResultado = .F.
1432:                 ELSE
1433:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados) = "O"
1434:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1435: 
1436:                         loc_oGrid.ColumnCount = 6
1437:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1438: 
1439:                         *-- ControlSource APOS RecordSource (RecordSource reseta auto-bind)
1440:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1441:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datainis"
1442:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.datafims"
1443:                         loc_oGrid.Column4.ControlSource = ;
1444:                             "IIF(cursor_4c_Dados.tipos=1,'1a.Entrada'," + ;
1445:                             "IIF(cursor_4c_Dados.tipos=2,'Pendentes'," + ;
1446:                             "IIF(cursor_4c_Dados.tipos=3,'Devolvidos','Todos')))"
1447:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.grupos"
1448:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.contas"
1449: 
1450:                         *-- Reconfigurar headers (RecordSource reseta captions)
1451:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1452:                         loc_oGrid.Column2.Header1.Caption = "In" + CHR(237) + "cio"
1453:                         loc_oGrid.Column3.Header1.Caption = "T" + CHR(233) + "rmino"
1454:                         loc_oGrid.Column4.Header1.Caption = "Tipo"
1455:                         loc_oGrid.Column5.Header1.Caption = "Grupo"
1456:                         loc_oGrid.Column6.Header1.Caption = "Conta"
1457: 
1458:                         THIS.FormatarGridLista(loc_oGrid)
1459:                     ENDIF
1460:                     loc_lResultado = .T.
1461:                 ENDIF
1462:             ENDIF
1463:         CATCH TO loc_oErro
1464:             MsgErro(loc_oErro.Message, "FormBch.CarregarLista")
1465:         ENDTRY
1466: 
1467:         RETURN loc_lResultado
1468:     ENDPROC
1469: 
1470:     *--------------------------------------------------------------------------
1471:     * AlternarPagina - Alterna entre as 3 paginas do PageFrame

*-- Linhas 1620 a 1650:
1620:                 "Balan" + CHR(231) + "o de Cheques")
1621: 
1622:             IF VARTYPE(loc_oBusca) = "O"
1623:                 loc_oBusca.mAddColuna("codigos",   "", "C" + CHR(243) + "digo")
1624:                 loc_oBusca.mAddColuna("operacaos", "", "Opera" + CHR(231) + CHR(227) + "o")
1625:                 loc_oBusca.mAddColuna("datainis",  "", "In" + CHR(237) + "cio")
1626:                 loc_oBusca.mAddColuna("datafims",  "", "T" + CHR(233) + "rmino")
1627:                 loc_oBusca.Show()
1628: 
1629:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaBch")
1630:                     SELECT cursor_4c_BuscaBch
1631:                     IF !EOF("cursor_4c_BuscaBch")
1632:                         loc_nCodigo = cursor_4c_BuscaBch.codigos
1633:                         THIS.this_oBusinessObject.Buscar( ;
1634:                             "codigos = " + FormatarNumeroSQL(loc_nCodigo))
1635:                         IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados) = "O"
1636:                             THIS.CarregarLista()
1637:                         ENDIF
1638:                     ENDIF
1639:                 ELSE
1640:                     THIS.CarregarLista()
1641:                 ENDIF
1642: 
1643:                 loc_oBusca.Release()
1644:             ENDIF
1645:         CATCH TO loc_oErro
1646:             MsgErro(loc_oErro.Message, "FormBch.BtnBuscarClick")
1647:         ENDTRY
1648: 
1649:         IF USED("cursor_4c_BuscaBch")
1650:             USE IN cursor_4c_BuscaBch

*-- Linhas 2133 a 2152:
2133:                     "Opera" + CHR(231) + CHR(227) + "o")
2134: 
2135:                 IF VARTYPE(loc_oBusca) = "O"
2136:                     loc_oBusca.mAddColuna("operacaos", "", "C" + CHR(243) + "digo")
2137:                     loc_oBusca.mAddColuna("descrs",    "", "Descri" + CHR(231) + CHR(227) + "o")
2138:                     loc_oBusca.Show()
2139: 
2140:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
2141:                         SELECT cursor_4c_BuscaOpt
2142:                         loc_oPg2.txt_4c_Oper.Value = IIF(!EOF("cursor_4c_BuscaOpt"), ;
2143:                             ALLTRIM(cursor_4c_BuscaOpt.operacaos), "")
2144:                     ELSE
2145:                         loc_oPg2.txt_4c_Oper.Value = ""
2146:                     ENDIF
2147: 
2148:                     loc_oBusca.Release()
2149:                 ENDIF
2150:             ENDIF
2151: 
2152:             IF USED("cursor_4c_ChkOpt")

*-- Linhas 2207 a 2226:
2207:                     "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", loc_cCodigo, "Grupo")
2208: 
2209:                 IF VARTYPE(loc_oBusca) = "O"
2210:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2211:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2212:                     loc_oBusca.Show()
2213: 
2214:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2215:                         SELECT cursor_4c_BuscaGcr
2216:                         IF !EOF("cursor_4c_BuscaGcr")
2217:                             loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2218:                             IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2219:                                 loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2220:                             ENDIF
2221:                         ELSE
2222:                             loc_oPg2.txt_4c_Grupo.Value = ""
2223:                         ENDIF
2224:                     ELSE
2225:                         loc_oPg2.txt_4c_Grupo.Value = ""
2226:                     ENDIF

*-- Linhas 2275 a 2294:
2275:                 "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", "", "Grupo")
2276: 
2277:             IF VARTYPE(loc_oBusca) = "O"
2278:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2279:                 loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2280:                 loc_oBusca.Show()
2281: 
2282:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2283:                     SELECT cursor_4c_BuscaGcr
2284:                     IF !EOF("cursor_4c_BuscaGcr")
2285:                         IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
2286:                             loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2287:                         ENDIF
2288:                         loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2289:                     ELSE
2290:                         loc_oPg2.txt_4c_DGrupo.Value = ""
2291:                     ENDIF
2292:                 ELSE
2293:                     loc_oPg2.txt_4c_DGrupo.Value = ""
2294:                 ENDIF

*-- Linhas 2348 a 2367:
2348:                     "SIGCDCLI", "cursor_4c_BuscaCli", "iclis", loc_cCodigo, "Conta")
2349: 
2350:                 IF VARTYPE(loc_oBusca) = "O"
2351:                     loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
2352:                     loc_oBusca.mAddColuna("razaos", "", "Nome")
2353:                     loc_oBusca.Show()
2354: 
2355:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2356:                         SELECT cursor_4c_BuscaCli
2357:                         IF !EOF("cursor_4c_BuscaCli")
2358:                             loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
2359:                             IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2360:                                 loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.razaos)
2361:                             ENDIF
2362:                         ELSE
2363:                             loc_oPg2.txt_4c_Conta.Value = ""
2364:                         ENDIF
2365:                     ELSE
2366:                         loc_oPg2.txt_4c_Conta.Value = ""
2367:                     ENDIF

*-- Linhas 2416 a 2435:
2416:                 "SIGCDCLI", "cursor_4c_BuscaCli", "iclis", "", "Conta")
2417: 
2418:             IF VARTYPE(loc_oBusca) = "O"
2419:                 loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
2420:                 loc_oBusca.mAddColuna("razaos", "", "Nome")
2421:                 loc_oBusca.Show()
2422: 
2423:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2424:                     SELECT cursor_4c_BuscaCli
2425:                     IF !EOF("cursor_4c_BuscaCli")
2426:                         IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
2427:                             loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.iclis)
2428:                         ENDIF
2429:                         loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.razaos)
2430:                     ELSE
2431:                         loc_oPg2.txt_4c_DConta.Value = ""
2432:                     ENDIF
2433:                 ELSE
2434:                     loc_oPg2.txt_4c_DConta.Value = ""
2435:                 ENDIF

*-- Linhas 2585 a 2635:
2585: 
2586:     *--------------------------------------------------------------------------
2587:     * CarregarGradeLeitura - Carrega SigCqHis em cursor_4c_Historico
2588:     * Usa padrao Problem #34: placeholder CREATE CURSOR + ZAP + APPEND FROM
2589:     *--------------------------------------------------------------------------
2590:     PROTECTED PROCEDURE CarregarGradeLeitura(par_nCodigos)
2591:         LOCAL loc_cSQL, loc_nResultado
2592: 
2593:         TRY
2594:             IF !USED("cursor_4c_Historico")
2595:                 SET NULL ON
2596:                 CREATE CURSOR cursor_4c_Historico ;
2597:                     (codigos N(6,0), bancos C(10), agencias C(10), ncontas C(10), ;
2598:                      ncheques C(10), tipos N(1,0), datas D, usuarios C(15), ;
2599:                      valors N(14,2), vencs D)
2600:                 SET NULL OFF
2601:             ENDIF
2602: 
2603:             loc_cSQL = "SELECT codigos, bancos, agencias, ncontas, ncheques, tipos, datas," + ;
2604:                        " usuarios, valors, vencs" + ;
2605:                        " FROM SigCqHis WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
2606:                        " ORDER BY datas, ncheques"
2607: 
2608:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistoricoTemp")
2609: 
2610:             IF loc_nResultado >= 0
2611:                 SELECT cursor_4c_Historico
2612:                 ZAP
2613:                 IF RECCOUNT("cursor_4c_HistoricoTemp") > 0
2614:                     APPEND FROM DBF("cursor_4c_HistoricoTemp")
2615:                 ENDIF
2616:                 IF USED("cursor_4c_HistoricoTemp")
2617:                     USE IN cursor_4c_HistoricoTemp
2618:                 ENDIF
2619:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura) = "O"
2620:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura.Refresh()
2621:                 ENDIF
2622:             ELSE
2623:                 MsgErro("Erro ao carregar hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
2624:             ENDIF
2625:         CATCH TO loc_oErro
2626:             MsgErro(loc_oErro.Message, "FormBch.CarregarGradeLeitura")
2627:             IF USED("cursor_4c_HistoricoTemp")
2628:                 USE IN cursor_4c_HistoricoTemp
2629:             ENDIF
2630:         ENDTRY
2631:     ENDPROC
2632: 
2633:     *--------------------------------------------------------------------------
2634:     * LimparCamposLeitura - Limpa campos de entrada manual da Page3
2635:     *--------------------------------------------------------------------------

