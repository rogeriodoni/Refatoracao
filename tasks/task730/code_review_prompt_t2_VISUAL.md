# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpEnc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1708 linhas total):

*-- Linhas 59 a 67:
59: *   AjustarBotoesPorModo() -> nao existem no legado (nao ha modo
60: *                             INCLUIR/ALTERAR/VISUALIZAR; os campos do filtro
61: *                             ficam sempre editaveis, e o unico Enabled
62: *                             condicional e cmd_4c_CmdProcessa, ja tratado em
63: *                             CarregarDados())
64: *
65: * O "Procedure Load" do legado (=fConfigGeral()) fica de fora pela mesma
66: * decisao ja documentada em FormSIGPRMEI.prg/FormSigMvExp.prg/
67: * FormSigOpCcl.prg: fConfigGeral era funcao GLOBAL do legado (sig.prg/

*-- Linhas 178 a 231:
178:     * titulo do form duplicado (sombra preta + texto branco por cima)
179:     *==========================================================================
180:     PROTECTED PROCEDURE ConfigurarCabecalho()
181:         LOCAL loc_oCnt
182: 
183:         THIS.AddObject("cnt_4c_Sombra", "Container")
184:         loc_oCnt = THIS.cnt_4c_Sombra
185:         WITH loc_oCnt
186:             .Top         = 0
187:             .Left        = 0
188:             .Width       = THIS.Width
189:             .Height      = 80
190:             .BorderWidth = 0
191:             .BackColor   = RGB(100, 100, 100)
192:             .Visible     = .T.
193:         ENDWITH
194: 
195:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
196:         WITH loc_oCnt.lbl_4c_Sombra
197:             .FontBold      = .T.
198:             .FontName      = "Tahoma"
199:             .FontSize      = 18
200:             .FontUnderline = .F.
201:             .WordWrap      = .T.
202:             .Alignment     = 0
203:             .BackStyle     = 0
204:             .AutoSize      = .F.
205:             .Caption       = THIS.Caption
206:             .Height        = 40
207:             .Left          = 10
208:             .Top           = 18
209:             .Width         = 769
210:             .ForeColor     = RGB(0, 0, 0)
211:             .Visible       = .T.
212:         ENDWITH
213: 
214:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
215:         WITH loc_oCnt.lbl_4c_Titulo
216:             .FontBold  = .T.
217:             .FontName  = "Tahoma"
218:             .FontSize  = 18
219:             .WordWrap  = .T.
220:             .Alignment = 0
221:             .BackStyle = 0
222:             .AutoSize  = .F.
223:             .Caption   = THIS.Caption
224:             .Height    = 46
225:             .Left      = 10
226:             .Top       = 17
227:             .Width     = 769
228:             .ForeColor = RGB(255, 255, 255)
229:             .Visible   = .T.
230:         ENDWITH
231:     ENDPROC

*-- Linhas 244 a 253:
244:     PROTECTED PROCEDURE ConfigurarContainerFiltro()
245:         THIS.AddObject("cnt_4c_Filtro", "Container")
246:         WITH THIS.cnt_4c_Filtro
247:             .Top         = 106
248:             .Left        = 60
249:             .Width       = 679
250:             .Height      = 132
251:             .BackStyle   = 0
252:             .BorderColor = RGB(90, 90, 90)
253:             .Visible     = .T.

*-- Linhas 267 a 279:
267:     * Top = -29 neste form (layout FLAT), logo nao ha compensacao a aplicar.
268:     *
269:     * Mapa legado -> migrado:
270:     *   Label1     "Filtro"  -> lbl_4c_Filtro
271:     *   lbl_grupo  "Grupo :" -> lbl_4c_Grupo
272:     *   Get_Grupo            -> txt_4c_Grupo    (SigCdGcr.codigos char(10))
273:     *   Get_DGrupo           -> txt_4c_DGrupo   (SigCdGcr.descrs  char(40))
274:     *   Say1       "Conta :" -> lbl_4c_Conta
275:     *   Get_Conta            -> txt_4c_Conta    (SigCdCli.iclis   char(10))
276:     *   get_Dconta           -> txt_4c_DConta   (SigCdCli.rclis   char(50))
277:     *
278:     * ForeColor dos rotulos: Label1 declara 255,0,0 EXPLICITO no dump (titulo
279:     * de secao em Verdana 10 bold, igual ao Label4/Label2 do mesmo container);

*-- Linhas 324 a 370:
324:         loc_oCnt = THIS.cnt_4c_Filtro
325: 
326:         *-- Label1 "Filtro" (titulo da secao)
327:         loc_oCnt.AddObject("lbl_4c_Filtro", "Label")
328:         WITH loc_oCnt.lbl_4c_Filtro
329:             .Top       = 2
330:             .Left      = 3
331:             .Width     = 40
332:             .Height    = 17
333:             .AutoSize  = .F.
334:             .Alignment = 0
335:             .BackStyle = 0
336:             .FontName  = "Verdana"
337:             .FontSize  = 10
338:             .FontBold  = .T.
339:             .ForeColor = RGB(255, 0, 0)
340:             .Caption   = "Filtro"
341:             .Visible   = .T.
342:         ENDWITH
343: 
344:         *-- lbl_grupo "Grupo :"
345:         loc_oCnt.AddObject("lbl_4c_Grupo", "Label")
346:         WITH loc_oCnt.lbl_4c_Grupo
347:             .Top       = 7
348:             .Left      = 83
349:             .Width     = 38
350:             .Height    = 15
351:             .AutoSize  = .F.
352:             .Alignment = 0
353:             .BackStyle = 0
354:             .FontName  = "Tahoma"
355:             .FontSize  = 8
356:             .ForeColor = RGB(90, 90, 90)
357:             .Caption   = "Grupo :"
358:             .Visible   = .T.
359:         ENDWITH
360: 
361:         *-- Get_Grupo - codigo do Grupo de Contas do filtro (SigCdGcr.codigos)
362:         loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
363:         WITH loc_oCnt.txt_4c_Grupo
364:             .Top       = 3
365:             .Left      = 123
366:             .Width     = 80
367:             .Height    = 25
368:             .FontName  = "Tahoma"
369:             .FontSize  = 8
370:             .Format    = "!"

*-- Linhas 378 a 420:
378:         *-- Get_DGrupo - descricao do Grupo do filtro (SigCdGcr.descrs)
379:         loc_oCnt.AddObject("txt_4c_DGrupo", "TextBox")
380:         WITH loc_oCnt.txt_4c_DGrupo
381:             .Top       = 3
382:             .Left      = 204
383:             .Width     = 290
384:             .Height    = 25
385:             .FontName  = "Tahoma"
386:             .FontSize  = 8
387:             .MaxLength = 20
388:             .ForeColor = RGB(0, 0, 0)
389:             .TabIndex  = 2
390:             .Value     = ""
391:             .Visible   = .T.
392:         ENDWITH
393: 
394:         *-- Say1 "Conta :"
395:         loc_oCnt.AddObject("lbl_4c_Conta", "Label")
396:         WITH loc_oCnt.lbl_4c_Conta
397:             .Top       = 32
398:             .Left      = 83
399:             .Width     = 38
400:             .Height    = 15
401:             .AutoSize  = .F.
402:             .Alignment = 0
403:             .BackStyle = 0
404:             .FontName  = "Tahoma"
405:             .FontSize  = 8
406:             .ForeColor = RGB(90, 90, 90)
407:             .Caption   = "Conta :"
408:             .Visible   = .T.
409:         ENDWITH
410: 
411:         *-- Get_Conta - codigo da Conta do filtro (SigCdCli.iclis)
412:         loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
413:         WITH loc_oCnt.txt_4c_Conta
414:             .Top               = 29
415:             .Left              = 123
416:             .Width             = 80
417:             .Height            = 23
418:             .FontName          = "Tahoma"
419:             .FontSize          = 8
420:             .Format            = "K"

*-- Linhas 431 a 440:
431:         *-- get_Dconta - descricao da Conta do filtro (SigCdCli.rclis)
432:         loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
433:         WITH loc_oCnt.txt_4c_DConta
434:             .Top               = 29
435:             .Left              = 204
436:             .Width             = 290
437:             .Height            = 23
438:             .FontName          = "Tahoma"
439:             .FontSize          = 8
440:             .Format            = "K"

*-- Linhas 473 a 485:
473:     * DisabledForeColor.
474:     *
475:     * Mapa legado -> migrado:
476:     *   Label4     "Contra-Partida" -> lbl_4c_ContraPartida
477:     *   Say4       "Grupo :"        -> lbl_4c_GrupoC
478:     *   Get_GrupoC                  -> txt_4c_GrupoC   (SigCdGcr.codigos char(10))
479:     *   Get_DgrupoC                 -> txt_4c_DGrupoC  (SigCdGcr.descrs  char(40))
480:     *   Say5       "Conta :"        -> lbl_4c_ContaC
481:     *   Get_contaC                  -> txt_4c_ContaC   (SigCdCli.iclis   char(10))
482:     *   Get_DcontaC                 -> txt_4c_DContaC  (SigCdCli.rclis   char(50))
483:     *
484:     * ForeColor: Label4 declara 255,0,0 (mesmo vermelho de Label1, titulo de
485:     * secao); Say4/Say5 declaram 90,90,90 (classe say sobre a textura clara

*-- Linhas 499 a 545:
499:         loc_oCnt = THIS.cnt_4c_Filtro
500: 
501:         *-- Label4 "Contra-Partida" (titulo da secao)
502:         loc_oCnt.AddObject("lbl_4c_ContraPartida", "Label")
503:         WITH loc_oCnt.lbl_4c_ContraPartida
504:             .Top       = 53
505:             .Left      = 2
506:             .Width     = 110
507:             .Height    = 18
508:             .AutoSize  = .F.
509:             .Alignment = 0
510:             .BackStyle = 0
511:             .FontName  = "Verdana"
512:             .FontSize  = 10
513:             .FontBold  = .T.
514:             .ForeColor = RGB(255, 0, 0)
515:             .Caption   = "Contra-Partida"
516:             .Visible   = .T.
517:         ENDWITH
518: 
519:         *-- Say4 "Grupo :" (rotulo do par GrupoC/DgrupoC)
520:         loc_oCnt.AddObject("lbl_4c_GrupoC", "Label")
521:         WITH loc_oCnt.lbl_4c_GrupoC
522:             .Top       = 78
523:             .Left      = 83
524:             .Width     = 38
525:             .Height    = 15
526:             .AutoSize  = .F.
527:             .Alignment = 0
528:             .BackStyle = 0
529:             .FontName  = "Tahoma"
530:             .FontSize  = 8
531:             .ForeColor = RGB(90, 90, 90)
532:             .Caption   = "Grupo :"
533:             .Visible   = .T.
534:         ENDWITH
535: 
536:         *-- Get_GrupoC - codigo do Grupo contra-partida (SigCdGcr.codigos)
537:         loc_oCnt.AddObject("txt_4c_GrupoC", "TextBox")
538:         WITH loc_oCnt.txt_4c_GrupoC
539:             .Top               = 75
540:             .Left              = 123
541:             .Width             = 80
542:             .Height            = 23
543:             .FontName          = "Tahoma"
544:             .FontSize          = 8
545:             .MaxLength         = 10

*-- Linhas 554 a 563:
554:         *-- Get_DgrupoC - descricao do Grupo contra-partida (SigCdGcr.descrs)
555:         loc_oCnt.AddObject("txt_4c_DGrupoC", "TextBox")
556:         WITH loc_oCnt.txt_4c_DGrupoC
557:             .Top               = 75
558:             .Left              = 204
559:             .Width             = 290
560:             .Height            = 23
561:             .FontName          = "Tahoma"
562:             .FontSize          = 8
563:             .MaxLength         = 40

*-- Linhas 570 a 598:
570:         ENDWITH
571: 
572:         *-- Say5 "Conta :" (rotulo do par ContaC/DContaC)
573:         loc_oCnt.AddObject("lbl_4c_ContaC", "Label")
574:         WITH loc_oCnt.lbl_4c_ContaC
575:             .Top       = 102
576:             .Left      = 83
577:             .Width     = 38
578:             .Height    = 15
579:             .AutoSize  = .F.
580:             .Alignment = 0
581:             .BackStyle = 0
582:             .FontName  = "Tahoma"
583:             .FontSize  = 8
584:             .ForeColor = RGB(90, 90, 90)
585:             .Caption   = "Conta :"
586:             .Visible   = .T.
587:         ENDWITH
588: 
589:         *-- Get_contaC - codigo da Conta contra-partida (SigCdCli.iclis)
590:         loc_oCnt.AddObject("txt_4c_ContaC", "TextBox")
591:         WITH loc_oCnt.txt_4c_ContaC
592:             .Top               = 99
593:             .Left              = 123
594:             .Width             = 80
595:             .Height            = 23
596:             .FontName          = "Tahoma"
597:             .FontSize          = 8
598:             .MaxLength         = 10

*-- Linhas 607 a 616:
607:         *-- Get_DcontaC - descricao da Conta contra-partida (SigCdCli.rclis)
608:         loc_oCnt.AddObject("txt_4c_DContaC", "TextBox")
609:         WITH loc_oCnt.txt_4c_DContaC
610:             .Top               = 99
611:             .Left              = 204
612:             .Width             = 290
613:             .Height            = 23
614:             .FontName          = "Tahoma"
615:             .FontSize          = 8
616:             .MaxLength         = 50

*-- Linhas 654 a 694:
654: 
655:         loc_oCnt.AddObject("shp_4c_Operacao", "Shape")
656:         WITH loc_oCnt.shp_4c_Operacao
657:             .Top         = 72
658:             .Left        = 509
659:             .Width       = 166
660:             .Height      = 57
661:             .BackStyle   = 0
662:             .Curvature   = 0
663:             .BorderColor = RGB(90, 90, 90)
664:             .Visible     = .T.
665:         ENDWITH
666: 
667:         *-- Label2 "Operacao" (titulo da secao)
668:         loc_oCnt.AddObject("lbl_4c_Operacao", "Label")
669:         WITH loc_oCnt.lbl_4c_Operacao
670:             .Top       = 78
671:             .Left      = 517
672:             .Width     = 72
673:             .Height    = 18
674:             .AutoSize  = .F.
675:             .Alignment = 0
676:             .BackStyle = 0
677:             .FontName  = "Verdana"
678:             .FontSize  = 10
679:             .FontBold  = .T.
680:             .ForeColor = RGB(255, 0, 0)
681:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
682:             .Visible   = .T.
683:         ENDWITH
684: 
685:         *-- Get_Dope - operacao de movimento de estoque (SigCdPac.DopZers)
686:         loc_oCnt.AddObject("txt_4c_Dope", "TextBox")
687:         WITH loc_oCnt.txt_4c_Dope
688:             .Top       = 99
689:             .Left      = 516
690:             .Width     = 151
691:             .Height    = 23
692:             .FontName  = "Tahoma"
693:             .FontSize  = 8
694:             .FontBold  = .T.

*-- Linhas 718 a 733:
718:         loc_oCnt.txt_4c_DGrupoC.TabIndex        = 6
719:         loc_oCnt.txt_4c_ContaC.TabIndex         = 7
720:         loc_oCnt.txt_4c_DContaC.TabIndex        = 8
721:         loc_oCnt.lbl_4c_Grupo.TabIndex          = 9
722:         loc_oCnt.lbl_4c_Filtro.TabIndex         = 10
723:         loc_oCnt.lbl_4c_ContraPartida.TabIndex  = 11
724:         loc_oCnt.txt_4c_Dope.TabIndex           = 12
725:         loc_oCnt.lbl_4c_GrupoC.TabIndex         = 13
726:         loc_oCnt.lbl_4c_ContaC.TabIndex         = 14
727:         loc_oCnt.lbl_4c_Conta.TabIndex          = 15
728:         loc_oCnt.lbl_4c_Operacao.TabIndex       = 16
729:     ENDPROC
730: 
731:     *==========================================================================
732:     * DGrupoWhen / ContaWhen / DContaWhen - equivalentes aos "Procedure When"
733:     * do legado, transcritos um a um:

*-- Linhas 1220 a 1247:
1220:     PROTECTED PROCEDURE ConfigurarAreaSaldo()
1221:         THIS.AddObject("shp_4c_Saldo", "Shape")
1222:         WITH THIS.shp_4c_Saldo
1223:             .Top         = 262
1224:             .Left        = 81
1225:             .Width       = 613
1226:             .Height      = 254
1227:             .BackStyle   = 0
1228:             .Curvature   = 0
1229:             .BorderColor = RGB(90, 90, 90)
1230:             .Visible     = .T.
1231:         ENDWITH
1232: 
1233:         THIS.AddObject("lbl_4c_Saldo", "Label")
1234:         WITH THIS.lbl_4c_Saldo
1235:             .AutoSize  = .T.
1236:             .FontBold  = .T.
1237:             .FontName  = "Tahoma"
1238:             .FontSize  = 8
1239:             .BackStyle = 0
1240:             .Caption   = " Contas / Saldos "
1241:             .Top       = 248
1242:             .Left      = 90
1243:             .ForeColor = RGB(90, 90, 90)
1244:             .Visible   = .T.
1245:         ENDWITH
1246: 
1247:         THIS.CriarCursorSaldosPlaceholder()

*-- Linhas 1300 a 1309:
1300:         THIS.grd_4c_Dados.RecordSource = loc_cCursor
1301: 
1302:         WITH THIS.grd_4c_Dados
1303:             .Top           = 268
1304:             .Left          = 87
1305:             .Width         = 601
1306:             .Height        = 244
1307:             .FontName      = "Tahoma"
1308:             .FontSize      = 8
1309:             .DeleteMark    = .F.

*-- Linhas 1317 a 1421:
1317:             .Column1.Movable           = .F.
1318:             .Column1.Resizable         = .F.
1319:             .Column1.ReadOnly          = .T.
1320:             .Column1.Header1.Caption   = "Conta"
1321:             .Column1.Header1.Alignment = 2
1322: 
1323:             .Column2.ControlSource     = loc_cCursor + ".rclis"
1324:             .Column2.Width             = 320
1325:             .Column2.Movable           = .F.
1326:             .Column2.Resizable         = .F.
1327:             .Column2.ReadOnly          = .T.
1328:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1329:             .Column2.Header1.Alignment = 2
1330: 
1331:             .Column3.ControlSource     = loc_cCursor + ".moedas"
1332:             .Column3.Alignment         = 3
1333:             .Column3.Width             = 40
1334:             .Column3.Movable           = .F.
1335:             .Column3.Resizable         = .F.
1336:             .Column3.ReadOnly          = .T.
1337:             .Column3.Header1.Caption   = "Moeda"
1338:             .Column3.Header1.Alignment = 2
1339: 
1340:             .Column4.ControlSource      = loc_cCursor + ".saldos"
1341:             .Column4.Width              = 94
1342:             .Column4.Movable            = .F.
1343:             .Column4.Resizable          = .F.
1344:             .Column4.ReadOnly           = .T.
1345:             .Column4.Text1.InputMask    = "999,999,999.99"
1346:             .Column4.Header1.Caption    = "Saldo"
1347:             .Column4.Header1.Alignment  = 2
1348: 
1349:             .Column5.AddObject("Check1", "CheckBox")
1350:             .Column5.Check1.Caption    = ""
1351:             .Column5.Check1.Value      = 0
1352:             .Column5.CurrentControl    = "Check1"
1353:             .Column5.Sparse            = .F.
1354:             .Column5.ReadOnly          = .F.
1355:             .Column5.Width             = 21
1356:             .Column5.ControlSource     = loc_cCursor + ".marcas"
1357:             .Column5.Header1.Caption   = ""
1358: 
1359:             .SetAll("DynamicBackColor", ;
1360:                 "IIF(" + loc_cCursor + ".Flag = 1, RGB(220,255,220), RGB(255,255,255))", ;
1361:                 "Column")
1362: 
1363:             .Visible = .T.
1364:         ENDWITH
1365:     ENDPROC
1366: 
1367:     *==========================================================================
1368:     * ConfigurarBotoesAcao - SelTudo/Apaga (manipulam o cursor_4c_Saldos),
1369:     * cmd_4c_CmdProcessa (cmdProcessa.Click do legado) e cmd_4c_Encerrar
1370:     * (cmdGprocessa.cmdSair do legado). O CommandGroup de 1 botao do dump
1371:     * (BackStyle=0, BorderStyle=0 - sem efeito visual nenhum) foi achatado
1372:     * para um CommandButton avulso, seguindo o padrao ja usado em outros
1373:     * forms OPERACIONAIS do projeto (ex.: FormDCC.cmd_4c_Encerrar).
1374:     *==========================================================================
1375:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
1376:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
1377:         WITH THIS.cmd_4c_SelTudo
1378:             .Top         = 519
1379:             .Left        = 90
1380:             .Width       = 40
1381:             .Height      = 40
1382:             .Caption     = ""
1383:             .Picture     = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
1384:             .ToolTipText = "Seleciona tudo"
1385:             .FontName    = "Verdana"
1386:             .FontSize    = 8
1387:             .ForeColor   = RGB(36, 84, 155)
1388:             .BackColor   = RGB(255, 255, 255)
1389:             .Themes      = .T.
1390:             .Visible     = .T.
1391:         ENDWITH
1392: 
1393:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
1394:         WITH THIS.cmd_4c_Apaga
1395:             .Top         = 519
1396:             .Left        = 132
1397:             .Width       = 40
1398:             .Height      = 40
1399:             .Caption     = ""
1400:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1401:             .ToolTipText = "Desmarca tudo"
1402:             .FontName    = "Verdana"
1403:             .FontSize    = 8
1404:             .ForeColor   = RGB(36, 84, 155)
1405:             .BackColor   = RGB(255, 255, 255)
1406:             .Themes      = .T.
1407:             .Visible     = .T.
1408:         ENDWITH
1409: 
1410:         THIS.AddObject("cmd_4c_CmdProcessa", "CommandButton")
1411:         WITH THIS.cmd_4c_CmdProcessa
1412:             .Top             = 3
1413:             .Left            = 650
1414:             .Width           = 75
1415:             .Height          = 75
1416:             .Caption         = "\<Processar"
1417:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1418:             .FontBold        = .T.
1419:             .FontItalic      = .T.
1420:             .FontName        = "Comic Sans MS"
1421:             .FontSize        = 8

*-- Linhas 1431 a 1445:
1431:             .Visible         = .T.
1432:         ENDWITH
1433: 
1434:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
1435:         WITH THIS.cmd_4c_Encerrar
1436:             .Top             = 3
1437:             .Left            = 725
1438:             .Width           = 75
1439:             .Height          = 75
1440:             .Caption         = "Encerrar"
1441:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1442:             .Cancel          = .T.
1443:             .FontBold        = .T.
1444:             .FontItalic      = .T.
1445:             .FontName        = "Comic Sans MS"

*-- Linhas 1455 a 1466:
1455:             .Visible         = .T.
1456:         ENDWITH
1457: 
1458:         BINDEVENT(THIS.cmd_4c_SelTudo,     "Click", THIS, "BtnSelTudoClick")
1459:         BINDEVENT(THIS.cmd_4c_Apaga,       "Click", THIS, "BtnApagaClick")
1460:         BINDEVENT(THIS.cmd_4c_CmdProcessa, "Click", THIS, "BtnProcessarClick")
1461:         BINDEVENT(THIS.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
1462:     ENDPROC
1463: 
1464:     *==========================================================================
1465:     * CarregarDados - MontaTela() do legado: recarrega a grade de saldos a
1466:     * partir do filtro corrente (Grupo / Conta, guardados no BO) e habilita o

*-- Linhas 1509 a 1517:
1509: 
1510:             *-- MontaTela(): If Reccount('CrSigMvSlc') > 0 /
1511:             *-- CmdProcessa.Enabled = .t. / Else / .Enabled = .f. / EndIf
1512:             THIS.cmd_4c_CmdProcessa.Enabled = (loc_nLinhas > 0)
1513: 
1514:             THIS.grd_4c_Dados.Refresh()
1515:         CATCH TO loc_oErro
1516:             MsgErro(loc_oErro.Message + CHR(13) + ;
1517:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

