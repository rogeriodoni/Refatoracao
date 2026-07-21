# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-HEADER] Header Caption 'Saída' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Saída' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdis.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1753 linhas total):

*-- Linhas 83 a 127:
83:                 THIS.ConfigurarPaginaLista()
84:                 THIS.ConfigurarPaginaDados()
85: 
86:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
87:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
88: 
89:                 *-- Page1 BINDEVENTs
90:                 LOCAL loc_oPg1 AS Object
91:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
92:                 BINDEVENT(loc_oPg1.txt_4c_DtInicial, "LostFocus",     THIS, "TxtDtInicialValid")
93:                 BINDEVENT(loc_oPg1.txt_4c_DtFinal,   "LostFocus",     THIS, "TxtDtFinalValid")
94:                 BINDEVENT(loc_oPg1.txt_4c_DtFinal,   "KeyPress", THIS, "TxtDtFinalLostFocus")
95:                 BINDEVENT(loc_oPg1.cmd_4c_Novo,       "Click",    THIS, "BtnNovoClick")
96:                 BINDEVENT(loc_oPg1.cmd_4c_Abrir,      "Click",    THIS, "BtnAbrirClick")
97:                 BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
98: 
99:                 *-- Page2 BINDEVENTs
100:                 LOCAL loc_oPg2 AS Object
101:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
102:                 BINDEVENT(loc_oPg2.cmd_4c_VoltarLista, "Click", THIS, "BtnVoltarListaClick")
103: 
104:                 *-- Inner pageframe sub-page BINDEVENTs
105:                 LOCAL loc_oPf1 AS Object
106:                 loc_oPf1 = loc_oPg2.pgf_4c_Pageframe1
107: 
108:                 *-- SubPage1 (Estoques)
109:                 LOCAL loc_oSub1 AS Object
110:                 loc_oSub1 = loc_oPf1.Page1
111:                 BINDEVENT(loc_oSub1.cmdg_4c_MarcaDesmarca.Buttons(1), "Click", THIS, "BtnMarcarClick")
112:                 BINDEVENT(loc_oSub1.cmdg_4c_MarcaDesmarca.Buttons(2), "Click", THIS, "BtnDesmarcarClick")
113:                 BINDEVENT(loc_oSub1.cmd_4c_Processar,                  "Click", THIS, "BtnProcessarPage1Click")
114:                 BINDEVENT(loc_oSub1.grd_4c_Estoques.Column1.chk_4c_Marca, "MouseUp",  THIS, "ChkMarcaMouseUp")
115:                 BINDEVENT(loc_oSub1.grd_4c_Estoques.Column1.chk_4c_Marca, "KeyPress", THIS, "ChkMarcaKeyPress")
116: 
117:                 *-- SubPage2 (Distribuicao)
118:                 LOCAL loc_oSub2 AS Object
119:                 loc_oSub2 = loc_oPf1.Page2
120:                 BINDEVENT(loc_oSub2.cmd_4c_VoltarEst,      "Click",              THIS, "BtnVoltarEstClick")
121:                 BINDEVENT(loc_oSub2.cmd_4c_Salvar,         "Click",              THIS, "BtnSalvarClick")
122:                 BINDEVENT(loc_oSub2.cmd_4c_Filtrar,        "Click",              THIS, "BtnFiltrarClick")
123:                 BINDEVENT(loc_oSub2.img_4c_FigJpg,         "Click",              THIS, "ImgFotoClick")
124:                 BINDEVENT(loc_oSub2.txt_4c_CodGrupo,       "KeyPress",             THIS, "TxtCGrupoValid")
125:                 BINDEVENT(loc_oSub2.txt_4c_DsGrupo,        "KeyPress",             THIS, "TxtDGrupoValid")
126:                 BINDEVENT(loc_oSub2.txt_4c_ProdutoInicial, "LostFocus",              THIS, "TxtProdutoInicialValid")
127:                 BINDEVENT(loc_oSub2.grd_4c_Disponivel,     "AfterRowColChange",  THIS, "GrdDisponivelAfterRowColChange")

*-- Linhas 155 a 163:
155:                 IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
156:                     loc_oPg1.grd_4c_Grade.SetFocus()
157:                 ELSE
158:                     loc_oPg1.cmd_4c_Novo.SetFocus()
159:                 ENDIF
160: 
161:                 loc_lSucesso = .T.
162:             ENDIF
163:         CATCH TO loc_oErro

*-- Linhas 181 a 189:
181: 
182:             IF VARTYPE(loc_oControl) = "O"
183:                 IF INLIST(UPPER(loc_oControl.Name), ;
184:                     "LBL_4C_LBLTITF", "LBL_4C_LBLTITT", "LBL_4C_LABEL3")
185:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
186:                        loc_oControl.ControlCount > 0
187:                         THIS.TornarControlesVisiveis(loc_oControl)
188:                     ENDIF
189:                     LOOP

*-- Linhas 206 a 241:
206:     *==========================================================================
207:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
208:         WITH THIS.cnt_4c_Cabecalho
209:             .Top        = 0
210:             .Left       = 0
211:             .Width      = THIS.Width
212:             .Height     = 45
213:             .BorderWidth= 0
214:             .BackStyle  = 1
215:             .BackColor  = RGB(90,90,90)
216:             .Visible     = .T.
217:         ENDWITH
218:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
219:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
220:             .Caption   = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
221:             .Top       = 12
222:             .Left      = 12
223:             .Width     = THIS.Width
224:             .Height    = 30
225:             .AutoSize  = .F.
226:             .BackStyle = 0
227:             .ForeColor = RGB(0,0,0)
228:             .FontName  = "Tahoma"
229:             .FontSize  = 14
230:             .FontBold  = .T.
231:         ENDWITH
232:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
233:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
234:             .Caption   = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
235:             .Top       = 10
236:             .Left      = 10
237:             .Width     = THIS.Width
238:             .Height    = 30
239:             .AutoSize  = .F.
240:             .BackStyle = 0
241:             .ForeColor = RGB(255,255,255)

*-- Linhas 254 a 396:
254: 
255:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
256:         WITH THIS.pgf_4c_Paginas
257:             .Left      = 0
258:             .Top       = 45
259:             .Width     = THIS.Width
260:             .Height    = THIS.Height - 45
261:             .PageCount = 2
262:             .Tabs      = .F.
263:             .Page1.Caption = "Lista"
264:             .Page2.Caption = "Dados"
265:         ENDWITH
266:     ENDPROC
267: 
268:     *==========================================================================
269:     PROTECTED PROCEDURE ConfigurarSaida()
270:     *==========================================================================
271:         THIS.AddObject("cnt_4c_Saida", "Container")
272:         WITH THIS.cnt_4c_Saida
273:             .Name        = "cnt_4c_Saida"
274:             .Left        = 917
275:             .Top         = 45
276:             .Width       = 90
277:             .Height      = 85
278:             .BackStyle = 1
279:             .BackColor = RGB(255, 255, 255)
280:             .BorderWidth = 0
281:             .Visible     = .T.
282:             .ZOrder(0)
283:         ENDWITH
284:         THIS.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
285:         WITH THIS.cnt_4c_Saida.cmd_4c_Encerrar
286:             .Name     = "cmd_4c_Encerrar"
287:             .Left     = 5
288:             .Top      = 5
289:             .Width    = 75
290:             .Height   = 75
291:             .Caption  = "Encerrar"
292:             .FontName = "Tahoma"
293:             .FontSize = 8
294:             .Visible  = .T.
295:         ENDWITH
296:     ENDPROC
297: 
298:     *==========================================================================
299:     PROTECTED PROCEDURE ConfigurarPaginaLista()
300:     *==========================================================================
301:         LOCAL loc_oPg1 AS Object
302:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
303: 
304:         loc_oPg1.AddObject("lbl_4c_Periodo", "Label")
305:         WITH loc_oPg1.lbl_4c_Periodo
306:             .Caption   = "Per" + CHR(237) + "odo :"
307:             .Left      = 35
308:             .Top       = 89
309:             .Width     = 60
310:             .Height    = 15
311:             .AutoSize  = .F.
312:             .BackStyle = 0
313:             .FontName  = "Tahoma"
314:             .FontSize  = 8
315:         ENDWITH
316: 
317:         loc_oPg1.AddObject("txt_4c_DtInicial", "TextBox")
318:         WITH loc_oPg1.txt_4c_DtInicial
319:             .Left     = 103
320:             .Top      = 105
321:             .Width    = 90
322:             .Height   = 22
323:             .Value    = DATE()
324:             .Format   = "D"
325:             .FontName = "Tahoma"
326:             .FontSize = 8
327:         ENDWITH
328: 
329:         loc_oPg1.AddObject("lbl_4c_Sep", "Label")
330:         WITH loc_oPg1.lbl_4c_Sep
331:             .Caption   = CHR(224)
332:             .Left      = 195
333:             .Top       = 109
334:             .Width     = 12
335:             .Height    = 15
336:             .AutoSize  = .F.
337:             .BackStyle = 0
338:         ENDWITH
339: 
340:         loc_oPg1.AddObject("txt_4c_DtFinal", "TextBox")
341:         WITH loc_oPg1.txt_4c_DtFinal
342:             .Left     = 206
343:             .Top      = 105
344:             .Width    = 90
345:             .Height   = 22
346:             .Value    = DATE()
347:             .Format   = "D"
348:             .FontName = "Tahoma"
349:             .FontSize = 8
350:         ENDWITH
351: 
352:         loc_oPg1.AddObject("cmd_4c_Novo", "CommandButton")
353:         WITH loc_oPg1.cmd_4c_Novo
354:             .Caption  = "Nova Distribui" + CHR(231) + CHR(227) + "o"
355:             .Left     = 315
356:             .Top      = 102
357:             .Width    = 140
358:             .Height   = 28
359:             .FontName = "Tahoma"
360:             .FontSize = 8
361:         ENDWITH
362: 
363:         loc_oPg1.AddObject("cmd_4c_Abrir", "CommandButton")
364:         WITH loc_oPg1.cmd_4c_Abrir
365:             .Caption  = "Abrir Selecionado"
366:             .Left     = 465
367:             .Top      = 102
368:             .Width    = 130
369:             .Height   = 28
370:             .FontName = "Tahoma"
371:             .FontSize = 8
372:         ENDWITH
373: 
374:         loc_oPg1.AddObject("lbl_4c_TituloLista", "Label")
375:         WITH loc_oPg1.lbl_4c_TituloLista
376:             .Caption   = "Lotes de Distribui" + CHR(231) + CHR(227) + "o"
377:             .Left      = 35
378:             .Top       = 140
379:             .Width     = 200
380:             .Height    = 15
381:             .AutoSize  = .F.
382:             .BackStyle = 0
383:             .FontName  = "Tahoma"
384:             .FontSize  = 8
385:             .FontBold  = .T.
386:         ENDWITH
387: 
388:         loc_oPg1.AddObject("grd_4c_Grade", "Grid")
389:         WITH loc_oPg1.grd_4c_Grade
390:             .Left              = 24
391:             .Top               = 157
392:             .Width             = 870
393:             .Height            = 340
394:             .RecordSource      = ""
395:             .RecordSourceType  = 1
396:             .ColumnCount       = 2

*-- Linhas 405 a 489:
405:         WITH loc_oPg1.grd_4c_Grade.Column1
406:             .ControlSource   = "cursor_4c_Dados.Codigos"
407:             .Width           = 140
408:             .Header1.Caption = "C" + CHR(243) + "digo"
409:         ENDWITH
410:         WITH loc_oPg1.grd_4c_Grade.Column2
411:             .ControlSource   = "cursor_4c_Dados.Datas"
412:             .Width           = 700
413:             .Header1.Caption = ""
414:         ENDWITH
415:     ENDPROC
416: 
417:     *==========================================================================
418:     PROTECTED PROCEDURE ConfigurarPaginaDados()
419:     *==========================================================================
420:         LOCAL loc_oPg2 AS Object
421:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
422: 
423:         loc_oPg2.AddObject("cmd_4c_VoltarLista", "CommandButton")
424:         WITH loc_oPg2.cmd_4c_VoltarLista
425:             .Caption  = CHR(171) + " Lista"
426:             .Left     = 5
427:             .Top      = 5
428:             .Width    = 80
429:             .Height   = 25
430:             .FontName = "Tahoma"
431:             .FontSize = 8
432:         ENDWITH
433: 
434:         loc_oPg2.AddObject("lbl_4c_Lote", "Label")
435:         WITH loc_oPg2.lbl_4c_Lote
436:             .Caption   = "Lote:"
437:             .Left      = 96
438:             .Top       = 10
439:             .Width     = 35
440:             .Height    = 15
441:             .AutoSize  = .F.
442:             .BackStyle = 0
443:             .FontName  = "Tahoma"
444:             .FontSize  = 8
445:         ENDWITH
446: 
447:         loc_oPg2.AddObject("txt_4c_LoteCodigo", "TextBox")
448:         WITH loc_oPg2.txt_4c_LoteCodigo
449:             .Left      = 132
450:             .Top       = 7
451:             .Width     = 180
452:             .Height    = 22
453:             .ReadOnly  = .T.
454:             .BackColor = RGB(230,230,230)
455:             .FontName  = "Tahoma"
456:             .FontSize  = 8
457:         ENDWITH
458: 
459:         loc_oPg2.AddObject("lbl_4c_Modo", "Label")
460:         WITH loc_oPg2.lbl_4c_Modo
461:             .Caption   = ""
462:             .Left      = 320
463:             .Top       = 10
464:             .Width     = 70
465:             .Height    = 15
466:             .AutoSize  = .F.
467:             .BackStyle = 0
468:             .FontName  = "Tahoma"
469:             .FontSize  = 8
470:             .ForeColor = RGB(0,0,180)
471:         ENDWITH
472: 
473:         *-- Inner pageframe (3 sub-pages: Estoques, Distribuicao, Operacoes)
474:         loc_oPg2.AddObject("pgf_4c_Pageframe1", "PageFrame")
475:         WITH loc_oPg2.pgf_4c_Pageframe1
476:             .Left      = 0
477:             .Top       = 35
478:             .Width     = 910
479:             .Height    = 515
480:             .PageCount = 3
481:             .Tabs      = .T.
482:             .Page1.Caption = "1 - Estoques"
483:             .Page2.Caption = "2 - Distribui" + CHR(231) + CHR(227) + "o"
484:             .Page3.Caption = "3 - Opera" + CHR(231) + CHR(245) + "es"
485:         ENDWITH
486: 
487:         THIS.ConfigurarSubPaginaEstoques()
488:         THIS.ConfigurarSubPaginaDistribuicao()
489:         THIS.ConfigurarSubPaginaOperacoes()

*-- Linhas 495 a 554:
495:         LOCAL loc_oSub AS Object
496:         loc_oSub = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1
497: 
498:         loc_oSub.AddObject("lbl_4c_TituloEst", "Label")
499:         WITH loc_oSub.lbl_4c_TituloEst
500:             .Caption   = "Estoques para distribuir"
501:             .Left      = 338
502:             .Top       = 189
503:             .Width     = 200
504:             .Height    = 15
505:             .AutoSize  = .F.
506:             .BackStyle = 0
507:             .FontName  = "Tahoma"
508:             .FontSize  = 8
509:             .FontBold  = .T.
510:         ENDWITH
511: 
512:         loc_oSub.AddObject("cmd_4c_Processar", "CommandButton")
513:         WITH loc_oSub.cmd_4c_Processar
514:             .Caption  = "Processar >>"
515:             .Left     = 730
516:             .Top      = 10
517:             .Width    = 120
518:             .Height   = 28
519:             .FontName = "Tahoma"
520:             .FontSize = 8
521:         ENDWITH
522: 
523:         loc_oSub.AddObject("cmdg_4c_MarcaDesmarca", "CommandGroup")
524:         WITH loc_oSub.cmdg_4c_MarcaDesmarca
525:             .Left        = 617
526:             .Top         = 351
527:             .Width       = 160
528:             .Height      = 50
529:             .ButtonCount = 2
530:         ENDWITH
531:         WITH loc_oSub.cmdg_4c_MarcaDesmarca.Buttons(1)
532:             .Caption = "Marcar Todos"
533:             .Left    = 5
534:             .Top     = 5
535:             .Width   = 72
536:             .Height  = 40
537:         ENDWITH
538:         WITH loc_oSub.cmdg_4c_MarcaDesmarca.Buttons(2)
539:             .Caption = "Desmarcar"
540:             .Left    = 82
541:             .Top     = 5
542:             .Width   = 72
543:             .Height  = 40
544:         ENDWITH
545: 
546:         loc_oSub.AddObject("grd_4c_Estoques", "Grid")
547:         WITH loc_oSub.grd_4c_Estoques
548:             .Left             = 335
549:             .Top              = 207
550:             .Width            = 280
551:             .Height           = 244
552:             .RecordSource     = ""
553:             .RecordSourceType = 1
554:             .ColumnCount      = 4

*-- Linhas 563 a 721:
563:             .ControlSource   = "cursor_4c_Estoques.nMarca"
564:             .Width           = 30
565:             .Sparse          = .F.
566:             .Header1.Caption = ""
567:         ENDWITH
568:         loc_oSub.grd_4c_Estoques.Column1.AddObject("chk_4c_Marca", "CheckBox")
569:         WITH loc_oSub.grd_4c_Estoques.Column1.chk_4c_Marca
570:             .Caption = ""
571:             .Width   = 24
572:             .Height  = 17
573:         ENDWITH
574:         loc_oSub.grd_4c_Estoques.Column1.CurrentControl = "chk_4c_Marca"
575:         WITH loc_oSub.grd_4c_Estoques.Column2
576:             .ControlSource   = "cursor_4c_Estoques.emps"
577:             .Width           = 55
578:             .ReadOnly        = .T.
579:             .Header1.Caption = "Empresa"
580:         ENDWITH
581:         WITH loc_oSub.grd_4c_Estoques.Column3
582:             .ControlSource   = "cursor_4c_Estoques.grupos"
583:             .Width           = 90
584:             .ReadOnly        = .T.
585:             .Header1.Caption = "Grupo"
586:         ENDWITH
587:         WITH loc_oSub.grd_4c_Estoques.Column4
588:             .ControlSource   = "cursor_4c_Estoques.contas"
589:             .Width           = 90
590:             .ReadOnly        = .T.
591:             .Header1.Caption = "Conta"
592:         ENDWITH
593:     ENDPROC
594: 
595:     *==========================================================================
596:     PROTECTED PROCEDURE ConfigurarSubPaginaDistribuicao()
597:     *==========================================================================
598:         LOCAL loc_oSub AS Object
599:         loc_oSub = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
600: 
601:         loc_oSub.AddObject("cmd_4c_VoltarEst", "CommandButton")
602:         WITH loc_oSub.cmd_4c_VoltarEst
603:             .Caption  = CHR(171) + " Estoques"
604:             .Left     = 5
605:             .Top      = 5
606:             .Width    = 90
607:             .Height   = 25
608:             .FontName = "Tahoma"
609:             .FontSize = 8
610:         ENDWITH
611: 
612:         loc_oSub.AddObject("cmd_4c_Salvar", "CommandButton")
613:         WITH loc_oSub.cmd_4c_Salvar
614:             .Caption  = "Salvar"
615:             .Left     = 730
616:             .Top      = 5
617:             .Width    = 80
618:             .Height   = 25
619:             .FontName = "Tahoma"
620:             .FontSize = 8
621:         ENDWITH
622: 
623:         *-- Product image area
624:         loc_oSub.AddObject("shp_4c_Shape5", "Shape")
625:         WITH loc_oSub.shp_4c_Shape5
626:             .Left      = 4
627:             .Top       = 35
628:             .Width     = 163
629:             .Height    = 93
630:             .BackStyle = 1
631:             .BackColor = RGB(200,200,200)
632:         ENDWITH
633: 
634:         loc_oSub.AddObject("img_4c_FigJpg", "Image")
635:         WITH loc_oSub.img_4c_FigJpg
636:             .Left    = 7
637:             .Top     = 36
638:             .Width   = 159
639:             .Height  = 89
640:             .Stretch = 1
641:         ENDWITH
642: 
643:         *-- Group filter
644:         loc_oSub.AddObject("lbl_4c_LblGrupo", "Label")
645:         WITH loc_oSub.lbl_4c_LblGrupo
646:             .Caption   = "Grupo :"
647:             .Left      = 174
648:             .Top       = 59
649:             .Width     = 45
650:             .Height    = 15
651:             .AutoSize  = .F.
652:             .BackStyle = 0
653:             .FontName  = "Tahoma"
654:             .FontSize  = 8
655:         ENDWITH
656: 
657:         loc_oSub.AddObject("txt_4c_CodGrupo", "TextBox")
658:         WITH loc_oSub.txt_4c_CodGrupo
659:             .Left     = 175
660:             .Top      = 74
661:             .Width    = 35
662:             .Height   = 23
663:             .FontName = "Tahoma"
664:             .FontSize = 8
665:         ENDWITH
666: 
667:         loc_oSub.AddObject("txt_4c_DsGrupo", "TextBox")
668:         WITH loc_oSub.txt_4c_DsGrupo
669:             .Left     = 211
670:             .Top      = 74
671:             .Width    = 208
672:             .Height   = 23
673:             .FontName = "Tahoma"
674:             .FontSize = 8
675:         ENDWITH
676: 
677:         loc_oSub.AddObject("cmd_4c_Filtrar", "CommandButton")
678:         WITH loc_oSub.cmd_4c_Filtrar
679:             .Caption  = "Filtrar"
680:             .Left     = 424
681:             .Top      = 73
682:             .Width    = 60
683:             .Height   = 25
684:             .FontName = "Tahoma"
685:             .FontSize = 8
686:         ENDWITH
687: 
688:         *-- Product search
689:         loc_oSub.AddObject("lbl_4c_LblProduto", "Label")
690:         WITH loc_oSub.lbl_4c_LblProduto
691:             .Caption   = "Procurar"
692:             .Left      = 4
693:             .Top       = 100
694:             .Width     = 50
695:             .Height    = 15
696:             .AutoSize  = .F.
697:             .BackStyle = 0
698:             .FontName  = "Tahoma"
699:             .FontSize  = 8
700:         ENDWITH
701: 
702:         loc_oSub.AddObject("txt_4c_ProdutoInicial", "TextBox")
703:         WITH loc_oSub.txt_4c_ProdutoInicial
704:             .Left     = 2
705:             .Top      = 116
706:             .Width    = 108
707:             .Height   = 22
708:             .FontName = "Tahoma"
709:             .FontSize = 8
710:         ENDWITH
711: 
712:         *-- Disponivel grid
713:         loc_oSub.AddObject("grd_4c_Disponivel", "Grid")
714:         WITH loc_oSub.grd_4c_Disponivel
715:             .Left             = 1
716:             .Top              = 141
717:             .Width            = 663
718:             .Height           = 327
719:             .RecordSource     = ""
720:             .RecordSourceType = 1
721:             .ColumnCount      = 7

*-- Linhas 730 a 775:
730:         WITH loc_oSub.grd_4c_Disponivel.Column1
731:             .ControlSource   = "cursor_4c_Disponivel.cpros"
732:             .Width           = 90
733:             .Header1.Caption = "C" + CHR(243) + "digo"
734:         ENDWITH
735:         WITH loc_oSub.grd_4c_Disponivel.Column2
736:             .ControlSource   = "cursor_4c_Disponivel.dpros"
737:             .Width           = 140
738:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
739:         ENDWITH
740:         WITH loc_oSub.grd_4c_Disponivel.Column3
741:             .ControlSource   = "cursor_4c_Disponivel.codcors"
742:             .Width           = 55
743:             .Header1.Caption = "Cor"
744:         ENDWITH
745:         WITH loc_oSub.grd_4c_Disponivel.Column4
746:             .ControlSource   = "cursor_4c_Disponivel.codtams"
747:             .Width           = 55
748:             .Header1.Caption = "Tam"
749:         ENDWITH
750:         WITH loc_oSub.grd_4c_Disponivel.Column5
751:             .ControlSource   = "cursor_4c_Disponivel.QtdEstoque"
752:             .Width           = 80
753:             .Header1.Caption = "Estoque"
754:         ENDWITH
755:         WITH loc_oSub.grd_4c_Disponivel.Column6
756:             .ControlSource   = "cursor_4c_Disponivel.QtdSaida"
757:             .Width           = 80
758:             .Header1.Caption = "Sa" + CHR(237) + "da"
759:         ENDWITH
760:         WITH loc_oSub.grd_4c_Disponivel.Column7
761:             .ControlSource   = "cursor_4c_Disponivel.QtdSaldo"
762:             .Width           = 80
763:             .Header1.Caption = "Saldo"
764:         ENDWITH
765: 
766:         *-- Distribui grid (Column3=QtdDistr editable, Column4=locals editable)
767:         loc_oSub.AddObject("grd_4c_Distribui", "Grid")
768:         WITH loc_oSub.grd_4c_Distribui
769:             .Left             = 664
770:             .Top              = 141
771:             .Width            = 234
772:             .Height           = 327
773:             .RecordSource     = ""
774:             .RecordSourceType = 1
775:             .ColumnCount      = 4

*-- Linhas 784 a 908:
784:             .ControlSource   = "cursor_4c_Distribui.emps"
785:             .Width           = 50
786:             .ReadOnly        = .T.
787:             .Header1.Caption = "Empresa"
788:         ENDWITH
789:         WITH loc_oSub.grd_4c_Distribui.Column2
790:             .ControlSource   = "cursor_4c_Distribui.QtdSaldo"
791:             .Width           = 55
792:             .ReadOnly        = .T.
793:             .Header1.Caption = "Saldo"
794:         ENDWITH
795:         WITH loc_oSub.grd_4c_Distribui.Column3
796:             .ControlSource   = "cursor_4c_Distribui.QtdDistr"
797:             .Width           = 65
798:             .Header1.Caption = "Quantidade"
799:         ENDWITH
800:         WITH loc_oSub.grd_4c_Distribui.Column4
801:             .ControlSource   = "cursor_4c_Distribui.locals"
802:             .Width           = 55
803:             .Header1.Caption = "Local"
804:         ENDWITH
805: 
806:         *-- Product info panel (read-only) - bottom of page
807:         loc_oSub.AddObject("lbl_4c_LblGrupoP", "Label")
808:         WITH loc_oSub.lbl_4c_LblGrupoP
809:             .Caption   = "Grupo :"
810:             .Left      = 67
811:             .Top       = 474
812:             .Width     = 45
813:             .Height    = 15
814:             .AutoSize  = .F.
815:             .BackStyle = 0
816:             .FontName  = "Tahoma"
817:             .FontSize  = 8
818:         ENDWITH
819:         loc_oSub.AddObject("txt_4c_CdGrupo", "TextBox")
820:         WITH loc_oSub.txt_4c_CdGrupo
821:             .Left      = 116
822:             .Top       = 470
823:             .Width     = 65
824:             .Height    = 21
825:             .ReadOnly  = .T.
826:             .BackColor = RGB(230,230,230)
827:             .FontName  = "Tahoma"
828:             .FontSize  = 8
829:         ENDWITH
830:         loc_oSub.AddObject("txt_4c_DsGrupoP", "TextBox")
831:         WITH loc_oSub.txt_4c_DsGrupoP
832:             .Left      = 182
833:             .Top       = 470
834:             .Width     = 270
835:             .Height    = 21
836:             .ReadOnly  = .T.
837:             .BackColor = RGB(230,230,230)
838:             .FontName  = "Tahoma"
839:             .FontSize  = 8
840:         ENDWITH
841: 
842:         loc_oSub.AddObject("lbl_4c_LblForn", "Label")
843:         WITH loc_oSub.lbl_4c_LblForn
844:             .Caption   = "Fornecedor :"
845:             .Left      = 519
846:             .Top       = 474
847:             .Width     = 72
848:             .Height    = 15
849:             .AutoSize  = .F.
850:             .BackStyle = 0
851:             .FontName  = "Tahoma"
852:             .FontSize  = 8
853:         ENDWITH
854:         loc_oSub.AddObject("txt_4c_CdFornecedor", "TextBox")
855:         WITH loc_oSub.txt_4c_CdFornecedor
856:             .Left      = 593
857:             .Top       = 470
858:             .Width     = 80
859:             .Height    = 21
860:             .ReadOnly  = .T.
861:             .BackColor = RGB(230,230,230)
862:             .FontName  = "Tahoma"
863:             .FontSize  = 8
864:         ENDWITH
865:         loc_oSub.AddObject("txt_4c_DsFornecedor", "TextBox")
866:         WITH loc_oSub.txt_4c_DsFornecedor
867:             .Left      = 674
868:             .Top       = 470
869:             .Width     = 220
870:             .Height    = 21
871:             .ReadOnly  = .T.
872:             .BackColor = RGB(230,230,230)
873:             .FontName  = "Tahoma"
874:             .FontSize  = 8
875:         ENDWITH
876: 
877:         loc_oSub.AddObject("lbl_4c_LblPrVenda", "Label")
878:         WITH loc_oSub.lbl_4c_LblPrVenda
879:             .Caption   = "Pre" + CHR(231) + "o Venda :"
880:             .Left      = 514
881:             .Top       = 497
882:             .Width     = 75
883:             .Height    = 15
884:             .AutoSize  = .F.
885:             .BackStyle = 0
886:             .FontName  = "Tahoma"
887:             .FontSize  = 8
888:         ENDWITH
889:         loc_oSub.AddObject("txt_4c_MoedaPrVenda", "TextBox")
890:         WITH loc_oSub.txt_4c_MoedaPrVenda
891:             .Left      = 590
892:             .Top       = 493
893:             .Width     = 31
894:             .Height    = 21
895:             .ReadOnly  = .T.
896:             .BackColor = RGB(230,230,230)
897:             .FontName  = "Tahoma"
898:             .FontSize  = 8
899:         ENDWITH
900:         loc_oSub.AddObject("txt_4c_PrVenda", "TextBox")
901:         WITH loc_oSub.txt_4c_PrVenda
902:             .Left      = 622
903:             .Top       = 493
904:             .Width     = 100
905:             .Height    = 21
906:             .ReadOnly  = .T.
907:             .BackColor = RGB(230,230,230)
908:             .FontName  = "Tahoma"

*-- Linhas 919 a 999:
919:         *-- Obs container
920:         loc_oSub.AddObject("cntOperacao", "Container")
921:         WITH loc_oSub.cntOperacao
922:             .Left        = 3
923:             .Top         = 13
924:             .Width       = 564
925:             .Height      = 165
926:             .BackColor   = RGB(240,240,240)
927:             .BorderWidth = 1
928:         ENDWITH
929:         loc_oSub.cntOperacao.AddObject("lbl_4c_Obs", "Label")
930:         WITH loc_oSub.cntOperacao.lbl_4c_Obs
931:             .Caption   = "Obs. :"
932:             .Left      = 12
933:             .Top       = 10
934:             .Width     = 40
935:             .Height    = 15
936:             .AutoSize  = .F.
937:             .BackStyle = 0
938:             .FontName  = "Tahoma"
939:             .FontSize  = 8
940:         ENDWITH
941:         loc_oSub.cntOperacao.AddObject("txt_4c_CodObs", "TextBox")
942:         WITH loc_oSub.cntOperacao.txt_4c_CodObs
943:             .Left     = 52
944:             .Top      = 10
945:             .Width    = 27
946:             .Height   = 20
947:             .FontName = "Tahoma"
948:             .FontSize = 8
949:         ENDWITH
950:         loc_oSub.cntOperacao.AddObject("edt_4c_Obs", "EditBox")
951:         WITH loc_oSub.cntOperacao.edt_4c_Obs
952:             .Left     = 83
953:             .Top      = 10
954:             .Width    = 407
955:             .Height   = 112
956:             .FontName = "Tahoma"
957:             .FontSize = 8
958:         ENDWITH
959: 
960:         *-- Process commandgroup (1 button: Processar Lote)
961:         loc_oSub.AddObject("cmdg_4c_ProcOper", "CommandGroup")
962:         WITH loc_oSub.cmdg_4c_ProcOper
963:             .Left        = 733
964:             .Top         = 11
965:             .Width       = 120
966:             .Height      = 122
967:             .ButtonCount = 1
968:         ENDWITH
969:         WITH loc_oSub.cmdg_4c_ProcOper.Buttons(1)
970:             .Caption = "Processar Lote"
971:             .Left    = 5
972:             .Top     = 5
973:             .Width   = 106
974:             .Height  = 110
975:         ENDWITH
976: 
977:         *-- Operations pageframe (Cab + Itens)
978:         loc_oSub.AddObject("pgf_4c_Operacoes", "PageFrame")
979:         WITH loc_oSub.pgf_4c_Operacoes
980:             .Left      = 1
981:             .Top       = 191
982:             .Width     = 900
983:             .Height    = 310
984:             .PageCount = 2
985:             .Tabs      = .T.
986:             .Page1.Caption = "Opera" + CHR(231) + CHR(245) + "es"
987:             .Page2.Caption = "Itens"
988:         ENDWITH
989: 
990:         *-- grdCabOperas
991:         loc_oSub.pgf_4c_Operacoes.Page1.AddObject("grd_4c_CabOperas", "Grid")
992:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas
993:             .Left             = 5
994:             .Top              = 5
995:             .Width            = 880
996:             .Height           = 280
997:             .RecordSource     = ""
998:             .RecordSourceType = 1
999:             .ColumnCount      = 6

*-- Linhas 1008 a 1048:
1008:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1
1009:             .ControlSource   = "cursor_4c_CabOpera.emps"
1010:             .Width           = 55
1011:             .Header1.Caption = "Emp O"
1012:         ENDWITH
1013:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2
1014:             .ControlSource   = "cursor_4c_CabOpera.dopes"
1015:             .Width           = 110
1016:             .Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1017:         ENDWITH
1018:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3
1019:             .ControlSource   = "cursor_4c_CabOpera.numes"
1020:             .Width           = 80
1021:             .Header1.Caption = ""
1022:         ENDWITH
1023:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4
1024:             .ControlSource   = "cursor_4c_CabOpera.datas"
1025:             .Width           = 130
1026:             .Header1.Caption = ""
1027:         ENDWITH
1028:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5
1029:             .ControlSource   = "cursor_4c_CabOpera.grupos"
1030:             .Width           = 100
1031:             .Header1.Caption = "Grupo Orig"
1032:         ENDWITH
1033:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6
1034:             .ControlSource   = "cursor_4c_CabOpera.empdopnums"
1035:             .Width           = 180
1036:             .Header1.Caption = "Emp+Op+Num"
1037:         ENDWITH
1038: 
1039:         *-- grdItnOperas
1040:         loc_oSub.pgf_4c_Operacoes.Page2.AddObject("grd_4c_ItnOperas", "Grid")
1041:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas
1042:             .Left             = 5
1043:             .Top              = 5
1044:             .Width            = 880
1045:             .Height           = 280
1046:             .RecordSource     = ""
1047:             .RecordSourceType = 1
1048:             .ColumnCount      = 5

*-- Linhas 1057 a 1085:
1057:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column1
1058:             .ControlSource   = "cursor_4c_ItensOper.cpros"
1059:             .Width           = 110
1060:             .Header1.Caption = "C" + CHR(243) + "digo"
1061:         ENDWITH
1062:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column2
1063:             .ControlSource   = "cursor_4c_ItensOper.codcors"
1064:             .Width           = 60
1065:             .Header1.Caption = "Cor"
1066:         ENDWITH
1067:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column3
1068:             .ControlSource   = "cursor_4c_ItensOper.codtams"
1069:             .Width           = 60
1070:             .Header1.Caption = "Tam"
1071:         ENDWITH
1072:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column4
1073:             .ControlSource   = "cursor_4c_ItensOper.qtds"
1074:             .Width           = 90
1075:             .Header1.Caption = "Quantidade"
1076:         ENDWITH
1077:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column5
1078:             .ControlSource   = "cursor_4c_ItensOper.locals"
1079:             .Width           = 110
1080:             .Header1.Caption = "Local"
1081:         ENDWITH
1082:     ENDPROC
1083: 
1084:     *==========================================================================
1085:     * METODOS DE NEGOCIO

*-- Linhas 1097 a 1161:
1097:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.ColumnCount = 3
1098:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = "cursor_4c_Dados"
1099:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.ControlSource = "cursor_4c_Dados.Codigos"
1100:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1101:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column2.ControlSource = "cursor_4c_Dados.Datas"
1102:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column2.Header1.Caption = ""
1103:         ENDIF
1104:         THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
1105:     ENDPROC
1106: 
1107:     PROCEDURE AbrirNovoBatch()
1108:     *==========================================================================
1109:         THIS.this_cEscolha = "INSERIR"
1110:         THIS.this_cCodigos = ALLTRIM(TRANSFORM(fGerUniqueKey("SIGPRDIS"), "@L 9999999999"))
1111:         THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = THIS.this_cCodigos
1112:         THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = "NOVO"
1113: 
1114:         IF THIS.this_oBusinessObject.BuscarEstoques()
1115:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = ""
1116:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.ColumnCount = 4
1117:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = "cursor_4c_Estoques"
1118:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.ControlSource = "cursor_4c_Estoques.nMarca"
1119:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.Header1.Caption = ""
1120:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.ControlSource = "cursor_4c_Estoques.emps"
1121:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.Header1.Caption = "Empresa"
1122:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.ControlSource = "cursor_4c_Estoques.grupos"
1123:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.Header1.Caption = "Grupo"
1124:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.ControlSource = "cursor_4c_Estoques.contas"
1125:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.Header1.Caption = "Conta"
1126:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1127:         ENDIF
1128: 
1129:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
1130:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .F.
1131:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 1
1132:         THIS.pgf_4c_Paginas.ActivePage = 2
1133:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1134:     ENDPROC
1135: 
1136:     PROCEDURE AbrirBatchExistente(par_cCodigos)
1137:     *==========================================================================
1138:         THIS.this_cEscolha = "ALTERAR"
1139:         THIS.this_cCodigos = par_cCodigos
1140:         THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = par_cCodigos
1141:         THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = "EDITAR"
1142: 
1143:         THIS.this_oBusinessObject.InicializarLote(par_cCodigos)
1144: 
1145:         IF THIS.this_oBusinessObject.BuscarEstoques()
1146:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = ""
1147:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.ColumnCount = 4
1148:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = "cursor_4c_Estoques"
1149:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.ControlSource = "cursor_4c_Estoques.nMarca"
1150:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.Header1.Caption = ""
1151:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.ControlSource = "cursor_4c_Estoques.emps"
1152:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.Header1.Caption = "Empresa"
1153:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.ControlSource = "cursor_4c_Estoques.grupos"
1154:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.Header1.Caption = "Grupo"
1155:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.ControlSource = "cursor_4c_Estoques.contas"
1156:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.Header1.Caption = "Conta"
1157:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1158:         ENDIF
1159: 
1160:         *-- Pre-marcar estoques do lote
1161:         IF USED("cursor_4c_Estoques") AND USED("cursor_4c_LotePrDis")

*-- Linhas 1182 a 1208:
1182:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.ColumnCount = 6
1183:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.RecordSource = "cursor_4c_CabOpera"
1184:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1.ControlSource = "cursor_4c_CabOpera.emps"
1185:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1.Header1.Caption = "Emp O"
1186:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2.ControlSource = "cursor_4c_CabOpera.dopes"
1187:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1188:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3.ControlSource = "cursor_4c_CabOpera.numes"
1189:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3.Header1.Caption = ""
1190:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4.ControlSource = "cursor_4c_CabOpera.datas"
1191:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4.Header1.Caption = ""
1192:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5.ControlSource = "cursor_4c_CabOpera.grupos"
1193:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5.Header1.Caption = "Grupo Orig"
1194:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6.ControlSource = "cursor_4c_CabOpera.empdopnums"
1195:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6.Header1.Caption = "Emp+Op+Num"
1196:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Refresh()
1197:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .T.
1198:         ENDIF
1199: 
1200:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
1201:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 1
1202:         THIS.pgf_4c_Paginas.ActivePage = 2
1203:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1204:     ENDPROC
1205: 
1206:     *==========================================================================
1207:     * HANDLERS DE EVENTOS
1208:     *==========================================================================

*-- Linhas 1266 a 1281:
1266:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1267:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
1268:         ELSE
1269:             THIS.pgf_4c_Paginas.Page1.cmd_4c_Novo.SetFocus()
1270:         ENDIF
1271:     ENDPROC
1272: 
1273:     PROCEDURE BtnVoltarEstClick()
1274:     *==========================================================================
1275:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage = 1
1276:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1277:     ENDPROC
1278: 
1279:     PROCEDURE BtnMarcarClick()
1280:     *==========================================================================
1281:         IF USED("cursor_4c_Estoques")

*-- Linhas 1325 a 1359:
1325:                 loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
1326:                 loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_Disponivel"
1327:                 loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_Disponivel.cpros"
1328:                 loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1329:                 loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_Disponivel.dpros"
1330:                 loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1331:                 loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_Disponivel.codcors"
1332:                 loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
1333:                 loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_Disponivel.codtams"
1334:                 loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
1335:                 loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_Disponivel.QtdEstoque"
1336:                 loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
1337:                 loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
1338:                 loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
1339:                 loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
1340:                 loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
1341:             ENDIF
1342:             loc_oSub2.grd_4c_Disponivel.Refresh()
1343:             loc_oSub2.grd_4c_Distribui.RecordSource = ""
1344:             IF USED("cursor_4c_Distribui")
1345:                 loc_oSub2.grd_4c_Distribui.ColumnCount = 4
1346:                 loc_oSub2.grd_4c_Distribui.RecordSource = "cursor_4c_Distribui"
1347:                 loc_oSub2.grd_4c_Distribui.Column1.ControlSource = "cursor_4c_Distribui.emps"
1348:                 loc_oSub2.grd_4c_Distribui.Column1.Header1.Caption = "Empresa"
1349:                 loc_oSub2.grd_4c_Distribui.Column2.ControlSource = "cursor_4c_Distribui.QtdSaldo"
1350:                 loc_oSub2.grd_4c_Distribui.Column2.Header1.Caption = "Saldo"
1351:                 loc_oSub2.grd_4c_Distribui.Column3.ControlSource = "cursor_4c_Distribui.QtdDistr"
1352:                 loc_oSub2.grd_4c_Distribui.Column3.Header1.Caption = "Quantidade"
1353:                 loc_oSub2.grd_4c_Distribui.Column4.ControlSource = "cursor_4c_Distribui.locals"
1354:                 loc_oSub2.grd_4c_Distribui.Column4.Header1.Caption = "Local"
1355:             ENDIF
1356:             loc_oSub2.grd_4c_Distribui.Refresh()
1357:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .T.
1358:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 2
1359:             loc_oSub2.grd_4c_Disponivel.SetFocus()

*-- Linhas 1574 a 1594:
1574:             loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
1575:             loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_Disponivel"
1576:             loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_Disponivel.cpros"
1577:             loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1578:             loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_Disponivel.dpros"
1579:             loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1580:             loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_Disponivel.codcors"
1581:             loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
1582:             loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_Disponivel.codtams"
1583:             loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
1584:             loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_Disponivel.QtdEstoque"
1585:             loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
1586:             loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
1587:             loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
1588:             loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
1589:             loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
1590:             loc_oSub2.grd_4c_Disponivel.Refresh()
1591:         ELSE
1592:             TRY
1593:                 IF USED("cursor_4c_DispFiltro")
1594:                     USE IN cursor_4c_DispFiltro

*-- Linhas 1611 a 1631:
1611:                     loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
1612:                     loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_DispFiltro"
1613:                     loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_DispFiltro.cpros"
1614:                     loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1615:                     loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_DispFiltro.dpros"
1616:                     loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1617:                     loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_DispFiltro.codcors"
1618:                     loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
1619:                     loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_DispFiltro.codtams"
1620:                     loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
1621:                     loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_DispFiltro.QtdEstoque"
1622:                     loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
1623:                     loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_DispFiltro.QtdSaida"
1624:                     loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Sa" + CHR(237) + "da"
1625:                     loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_DispFiltro.QtdSaldo"
1626:                     loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
1627:                     loc_oSub2.grd_4c_Disponivel.Refresh()
1628:                 ENDIF
1629:             CATCH TO loc_oErro
1630:                 MsgErro(loc_oErro.Message, "Erro Filtrar")
1631:             ENDTRY

*-- Linhas 1681 a 1709:
1681:         IF THIS.this_oBusinessObject.ProcessarDistribuicao(THIS.this_cCodigos, THIS.this_cEscolha)
1682:             MsgInfo("Distribui" + CHR(231) + CHR(227) + "o salva com sucesso.", "Sucesso")
1683:             THIS.this_cEscolha = "ALTERAR"
1684:             THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption = "EDITAR"
1685:             *-- Switch to operacoes page
1686:             IF THIS.this_oBusinessObject.BuscarOperacoes(THIS.this_cCodigos)
1687:                 LOCAL loc_oSub3 AS Object
1688:                 loc_oSub3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
1689:                 loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.RecordSource = ""
1690:                 IF USED("cursor_4c_CabOpera")
1691:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.ColumnCount = 6
1692:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.RecordSource = "cursor_4c_CabOpera"
1693:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1.ControlSource = "cursor_4c_CabOpera.emps"
1694:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1.Header1.Caption = "Emp O"
1695:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2.ControlSource = "cursor_4c_CabOpera.dopes"
1696:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1697:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3.ControlSource = "cursor_4c_CabOpera.numes"
1698:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3.Header1.Caption = ""
1699:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4.ControlSource = "cursor_4c_CabOpera.datas"
1700:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4.Header1.Caption = ""
1701:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5.ControlSource = "cursor_4c_CabOpera.grupos"
1702:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5.Header1.Caption = "Grupo Orig"
1703:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6.ControlSource = "cursor_4c_CabOpera.empdopnums"
1704:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6.Header1.Caption = "Emp+Op+Num"
1705:                 ENDIF
1706:                 loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Refresh()
1707:                 loc_oSub3.Enabled = .T.
1708:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage = 3
1709:             ENDIF

*-- Linhas 1735 a 1751:
1735:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.ColumnCount = 5
1736:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.RecordSource = "cursor_4c_ItensOper"
1737:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column1.ControlSource = "cursor_4c_ItensOper.cpros"
1738:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1739:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column2.ControlSource = "cursor_4c_ItensOper.codcors"
1740:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column2.Header1.Caption = "Cor"
1741:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column3.ControlSource = "cursor_4c_ItensOper.codtams"
1742:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column3.Header1.Caption = "Tam"
1743:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column4.ControlSource = "cursor_4c_ItensOper.qtds"
1744:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column4.Header1.Caption = "Quantidade"
1745:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column5.ControlSource = "cursor_4c_ItensOper.locals"
1746:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column5.Header1.Caption = "Local"
1747:                 ENDIF
1748:                 loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Refresh()
1749:             ENDIF
1750:         ENDIF
1751:     ENDPROC


### BO (C:\4c\projeto\app\classes\sigprdisBO.prg):
*=============================================================================*
* sigprdisBO.prg - Business Object para Distribuicao de Produtos
*=============================================================================*
* Herda de: BusinessBase
* Form associado: Formsigprdis.prg (forms\operacionais\)
* Tabela principal: sigprdis (PK: cidchaves)
* Tabela auxiliar : SIGTEMPD  (cidchaves C64 - temp de processamento)
*
* Descricao: Gerencia a distribuicao de produtos entre empresas/estoques.
*   - Page1 (Lista): lista de distribuicoes por periodo (TmpSigPrDis)
*   - Page2 (Dados): grade de disponivel (crDisponivel) e distribuicao
*                    (crDistribui) por empresa/grupo/conta
*   - Page3 (Ops)  : historico de operacoes geradas pelo processamento
*
* Campos sigprdis:
*   cidchaves C(20)   PK auto (fUniqueIds por linha)
*   codigos   C(10)   chave de lote (agrupa N linhas do mesmo lote)
*   datas     T       data/hora do lote
*   dtalts    T       data/hora ultima alteracao
*   cpros     C(14)   codigo do produto
*   codcors   C(4)    codigo da cor
*   codtams   C(4)    codigo do tamanho
*   empdopnums C(29)  empresa+operacao+numero destino gerado
*   empds     C(3)    empresa destino
*   empgruests C(23)  empresa+grupo+conta (composto 3+10+10)
*   locals    C(10)   localizacao/enderecamento
*   qtds      N(10,2) quantidade distribuida
*   qtdos     N(10,2) quantidade original (pre-distribuicao)
*   usuars    C(10)   usuario que criou
*   usualts   C(10)   usuario que alterou por ultimo
*   oridopnums C(29)  empresa+operacao+numero origem
*=============================================================================*

DEFINE CLASS sigprdisBO AS BusinessBase

    *-- Identificacao do lote (chave de negocio usada nos SELECTs de listagem)
    this_cCodigos       = ""

    *-- PK fisica de cada linha da distribuicao (gerada por fUniqueIds)
    this_cCidChaves     = ""

    *-- Data e hora do lote
    this_dDatas         = {}

    *-- Data e hora da ultima alteracao
    this_dDtAlts        = {}

    *-- Codigo do produto distribuido
    this_cCpros         = ""

    *-- Codigo da cor do produto
    this_cCodCors       = ""

    *-- Codigo do tamanho do produto
    this_cCodTams       = ""

    *-- Empresa + Operacao + Numero destino (composto char 29)
    this_cEmpDopNums    = ""

    *-- Empresa destino (char 3)
    this_cEmpDs         = ""

    *-- Empresa + Grupo + Conta composto (char 23 = 3+10+10)
    this_cEmpGruEsts    = ""

    *-- Localizacao / enderecamento do estoque (char 10)
    this_cLocals        = ""

    *-- Quantidade distribuida
    this_nQtds          = 0

    *-- Quantidade original (antes da distribuicao, preenchida no processamento)
    this_nQtdOs         = 0

    *-- Usuario que criou o lancamento
    this_cUsuars        = ""

    *-- Usuario da ultima alteracao
    this_cUsuAlts       = ""

    *-- Empresa + Operacao + Numero origem (char 29)
    this_cOriDopNums    = ""

    *-- Filtros de pesquisa de lotes (usados em Buscar)
    this_dDataInicial   = {}
    this_dDataFinal     = {}

    *-- Chave de query temporaria (cidquerys em SIGTEMPD, gerada por fUniqueIds)
    this_cCidQuerys     = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO com tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "sigprdis"
        THIS.this_cCampoChave  = "cidchaves"
        THIS.this_dDataInicial = DATE()
        THIS.this_dDataFinal   = DATE()
    ENDPROC


    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (BusinessBase)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *==========================================================================
    * METODOS CRUD (BusinessBase)
    *==========================================================================

    *--------------------------------------------------------------------------
    * Buscar - Lista lotes de distribuicao por periodo (cursor_4c_Dados)
    * Colunas: Codigos, Datas
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cWhere)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT DISTINCT Codigos, Datas FROM SigPrDis" + ;
                       " WHERE CAST(Datas AS date) BETWEEN " + ;
                       FormatarDataSQL(THIS.this_dDataInicial) + ;
                       " AND " + FormatarDataSQL(THIS.this_dDataFinal) + ;
                       " ORDER BY Datas DESC"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar distribui" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega primeira linha de um lote pelo campo Codigos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT TOP 1 * FROM SigPrDis" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " ORDER BY cidchaves"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso             = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_cCodigos       = ALLTRIM(par_cCodigos)
                THIS.this_lNovoRegistro  = .F.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves   = TratarNulo(cidchaves,   "C")
            THIS.this_cCodigos     = TratarNulo(codigos,     "C")
            THIS.this_dDatas       = IIF(ISNULL(datas),  {}, datas)
            THIS.this_dDtAlts      = IIF(ISNULL(dtalts), {}, dtalts)
            THIS.this_cCpros       = TratarNulo(cpros,       "C")
            THIS.this_cCodCors     = TratarNulo(codcors,     "C")
            THIS.this_cCodTams     = TratarNulo(codtams,     "C")
            THIS.this_cEmpDopNums  = TratarNulo(empdopnums,  "C")
            THIS.this_cEmpDs       = TratarNulo(empds,       "C")
            THIS.this_cEmpGruEsts  = TratarNulo(empgruests,  "C")
            THIS.this_cLocals      = TratarNulo(locals,      "C")
            THIS.this_nQtds        = TratarNulo(qtds,        "N")
            THIS.this_nQtdOs       = TratarNulo(qtdos,       "N")
            THIS.this_cUsuars      = TratarNulo(usuars,      "C")
            THIS.this_cUsuAlts     = TratarNulo(usualts,     "C")
            THIS.this_cOriDopNums  = TratarNulo(oridopnums,  "C")
            loc_lSucesso           = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de uma linha de distribuicao em SigPrDis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidChaves)
            THIS.this_cCidChaves = fUniqueIds()
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SigPrDis" + ;
                       " (cidchaves, codigos, codcors, codtams, cpros," + ;
                       "  datas, dtalts, empdopnums, empds, empgruests," + ;
                       "  locals, qtdos, qtds, usualts, usuars, oridopnums)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves)                       + "," + ;
                       EscaparSQL(THIS.this_cCodigos)                         + "," + ;
                       EscaparSQL(THIS.this_cCodCors)                         + "," + ;
                       EscaparSQL(THIS.this_cCodTams)                         + "," + ;
                       EscaparSQL(THIS.this_cCpros)                           + "," + ;
                       "GETDATE(),"                                                  + ;
                       "GETDATE(),"                                                  + ;
                       EscaparSQL(THIS.this_cEmpDopNums)                      + "," + ;
                       EscaparSQL(THIS.this_cEmpDs)                           + "," + ;
                       EscaparSQL(THIS.this_cEmpGruEsts)                      + "," + ;
                       EscaparSQL(THIS.this_cLocals)                          + "," + ;
                       FormatarNumeroSQL(THIS.this_nQtdOs)                    + "," + ;
                       FormatarNumeroSQL(THIS.this_nQtds)                     + "," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))              + "," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))              + "," + ;
                       EscaparSQL(THIS.this_cOriDopNums)                      + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao inserir distribui" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de uma linha de distribuicao em SigPrDis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrDis SET" + ;
                       "  codcors    = " + EscaparSQL(THIS.this_cCodCors)              + "," + ;
                       "  codtams    = " + EscaparSQL(THIS.this_cCodTams)              + "," + ;
                       "  cpros      = " + EscaparSQL(THIS.this_cCpros)                + "," + ;
                       "  dtalts     = GETDATE(),"                                           + ;
                       "  empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)           + "," + ;
                       "  empds      = " + EscaparSQL(THIS.this_cEmpDs)                + "," + ;
                       "  empgruests = " + EscaparSQL(THIS.this_cEmpGruEsts)           + "," + ;
                       "  locals     = " + EscaparSQL(THIS.this_cLocals)               + "," + ;
                       "  qtdos      = " + FormatarNumeroSQL(THIS.this_nQtdOs)         + "," + ;
                       "  qtds       = " + FormatarNumeroSQL(THIS.this_nQtds)          + "," + ;
                       "  usualts    = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))   + "," + ;
                       "  oridopnums = " + EscaparSQL(THIS.this_cOriDopNums)                  + ;
                       " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar distribui" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE do lote completo de SigPrDis (por Codigos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrDis WHERE Codigos = " + ;
                       EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir lote de distribui" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * METODOS DE NEGOCIO (operacional - distribuicao de produtos)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BuscarEstoques - Carrega SigCdCeg (tpcads=3) com flag nMarca para selecao
    * Cria cursor_4c_Estoques: nMarca, cidchaves, emps, grupos, contas
    *--------------------------------------------------------------------------
    PROCEDURE BuscarEstoques()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Estoques")
                USE IN cursor_4c_Estoques
            ENDIF

            loc_cSQL = "SELECT 0 AS nMarca, cidchaves AS cidchaves, emps AS emps, grupos AS grupos, contas AS contas" + ;
                       " FROM SigCdCeg" + ;
                       " WHERE tpcads = 3" + ;
                       " ORDER BY emps, grupos, contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Estoques")

            IF loc_nResultado < 0
                MsgErro("Erro ao carregar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_Estoques")
                    GO TOP IN cursor_4c_Estoques
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarEstoques:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarLote - Carrega todas as linhas SigPrDis de um lote
    * Cria cursor_4c_LotePrDis com todos os campos de SigPrDis
    *--------------------------------------------------------------------------
    PROCEDURE InicializarLote(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_LotePrDis")
                USE IN cursor_4c_LotePrDis
            ENDIF

            loc_cSQL = "SELECT * FROM SigPrDis" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LotePrDis")

            IF loc_nResultado < 0
                MsgErro("Erro ao inicializar lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_LotePrDis")
                    GO TOP IN cursor_4c_LotePrDis
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em InicializarLote:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursoresDistribuicao
    * Prepara cursor_4c_Disponivel e cursor_4c_Distribui a partir dos
    * estoques marcados em cursor_4c_Estoques.
    * par_cCodigos : codigo do lote (vazio se INSERIR)
    * par_cEscolha : "INSERIR" ou "ALTERAR"
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursoresDistribuicao(par_cCodigos, par_cEscolha)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nSel
        LOCAL loc_cEmp, loc_cGrupo, loc_cConta, loc_nQtdDistr
        loc_lSucesso = .F.

        TRY
            *-- Contar estoques marcados
            loc_nSel = 0
            IF USED("cursor_4c_Estoques")
                SELECT cursor_4c_Estoques
                COUNT FOR nMarca = 1 TO loc_nSel
            ENDIF

            IF loc_nSel = 0
                MsgAviso("Nenhum estoque foi selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Fechar cursores anteriores
            IF USED("cursor_4c_Disponivel")
                USE IN cursor_4c_Disponivel
            ENDIF
            IF USED("cursor_4c_Distribui")
                USE IN cursor_4c_Distribui
            ENDIF

            *-- Montar cursor_4c_Disponivel
            IF UPPER(ALLTRIM(par_cEscolha)) = "ALTERAR" AND !EMPTY(par_cCodigos)
                loc_cSQL = "SELECT a.cpros AS cpros, ISNULL(p.dpros,'') AS dpros," + ;
                           "  a.codcors AS codcors, a.codtams AS codtams," + ;
                           "  SUM(a.qtdos) AS QtdEstoque," + ;
                           "  SUM(a.qtds)  AS QtdSaida," + ;
                           "  (SUM(a.qtdos) - SUM(a.qtds)) AS QtdSaldo" + ;
                           " FROM SigPrDis a" + ;
                           " LEFT JOIN SigCdPro p ON p.cpros = a.cpros" + ;
                           " WHERE a.Codigos = " + EscaparSQL(par_cCodigos) + ;
                           " GROUP BY a.cpros, p.dpros, a.codcors, a.codtams" + ;
                           " ORDER BY a.cpros, a.codcors, a.codtams"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Disponivel")
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar produtos disponivel:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_Disponivel ;
                    (cpros C(14), dpros C(65), codcors C(4), codtams C(4), ;
                     QtdEstoque N(10,2), QtdSaida N(10,2), QtdSaldo N(10,2))
                SET NULL OFF
            ENDIF

            *-- Montar cursor_4c_Distribui a partir dos estoques marcados
            SET NULL ON
            CREATE CURSOR cursor_4c_Distribui ;
                (emps C(3), grupos C(10), contas C(10), ;
                 QtdSaldo N(10,2), QtdDistr N(10,2), locals C(10))
            SET NULL OFF

            SELECT cursor_4c_Estoques
            GO TOP
            DO WHILE !EOF("cursor_4c_Estoques")
                IF cursor_4c_Estoques.nMarca = 1
                    loc_cEmp   = ALLTRIM(cursor_4c_Estoques.emps)
                    loc_cGrupo = ALLTRIM(cursor_4c_Estoques.grupos)
                    loc_cConta = ALLTRIM(cursor_4c_Estoques.contas)
                    loc_nQtdDistr = 0

                    IF UPPER(ALLTRIM(par_cEscolha)) = "ALTERAR" AND ;
                       !EMPTY(par_cCodigos) AND ;
                       USED("cursor_4c_LotePrDis")
                        SELECT cursor_4c_LotePrDis
                        GO TOP
                        SCAN FOR ALLTRIM(empds) = loc_cEmp
                            loc_nQtdDistr = loc_nQtdDistr + qtds
                        ENDSCAN
                    ENDIF

                    INSERT INTO cursor_4c_Distribui ;
                        (emps, grupos, contas, QtdSaldo, QtdDistr, locals) ;
                        VALUES (loc_cEmp, loc_cGrupo, loc_cConta, 0, loc_nQtdDistr, "")
                ENDIF
                SELECT cursor_4c_Estoques
                SKIP
            ENDDO

            IF USED("cursor_4c_Disponivel")
                GO TOP IN cursor_4c_Disponivel
            ENDIF
            IF USED("cursor_4c_Distribui")
                GO TOP IN cursor_4c_Distribui
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em PrepararCursoresDistribuicao:" + CHR(13) + ;
                    loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularSaldo - Recalcula QtdSaldo em cursor_4c_Disponivel
    * Chamado apos edicao de QtdDistr em cursor_4c_Distribui
    * par_cCpros/par_cCodCors/par_cCodTams: produto selecionado
    *--------------------------------------------------------------------------
    PROCEDURE CalcularSaldo(par_cCpros, par_cCodCors, par_cCodTams)
        LOCAL loc_nQtdDistr, loc_nQtdEstoque, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Distribui") OR !USED("cursor_4c_Disponivel")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Distribui
            SUM QtdDistr TO loc_nQtdDistr

            SELECT cursor_4c_Disponivel
            LOCATE FOR ALLTRIM(cpros)   = ALLTRIM(par_cCpros)  AND ;
                        ALLTRIM(codcors) = ALLTRIM(par_cCodCors) AND ;
                        ALLTRIM(codtams) = ALLTRIM(par_cCodTams)

            IF FOUND()
                loc_nQtdEstoque = cursor_4c_Disponivel.QtdEstoque

                IF loc_nQtdEstoque - loc_nQtdDistr < 0
                    MsgAviso("Saldo insuficiente para movimentar.", "Aviso")
                    SELECT cursor_4c_Distribui
                    GO TOP
                    REPLACE ALL QtdDistr WITH 0
                    loc_nQtdDistr = 0
                    *-- Recalcular apos zerar
                    SELECT cursor_4c_Distribui
                    SUM QtdDistr TO loc_nQtdDistr
                ENDIF

                SELECT cursor_4c_Disponivel
                REPLACE QtdSaida WITH loc_nQtdDistr
                REPLACE QtdSaldo WITH (loc_nQtdEstoque - loc_nQtdDistr)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em CalcularSaldo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProduto - Carrega detalhes de produto para exibicao no painel lateral
    * Cria cursor_4c_Produto com campos do SigCdPro + joins
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProduto(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_cSQL = "SELECT a.cpros, a.cgrus, a.dpros, a.sgrus, a.cunis," + ;
                       "  a.reffs, a.valors, a.moedas, a.pvens, a.moevs," + ;
                       "  a.pesoms, a.linhas, a.situas, a.colecoes," + ;
                       "  a.pcuss, a.moecs, a.pvideals, a.ifors," + ;
                       "  ISNULL(c.Rclis, '') AS rclis," + ;
                       "  ISNULL(g.dgrus, '') AS dgrus" + ;
                       " FROM SigCdPro a" + ;
                       " LEFT JOIN SigCdCli c ON c.iclis = a.ifors" + ;
                       " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
                       " WHERE a.cpros = " + EscaparSQL(par_cCpros)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Produto") > 0
                GO TOP IN cursor_4c_Produto
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarProduto:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarDistribuicao
    * Grava o lote de distribuicao em SigPrDis a partir de cursor_4c_Distribui
    * e cursor_4c_Disponivel. Usa transacao explicita para garantir atomicidade.
    * par_cCodigos : codigo do lote (Codigos)
    * par_cEscolha : "INSERIR" ou "ALTERAR"
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarDistribuicao(par_cCodigos, par_cEscolha)
        LOCAL loc_lSucesso, loc_lTransacaoAberta
        LOCAL loc_cSQL, loc_nResultado
        LOCAL loc_cCidChaves, loc_cCpros, loc_cCodCors, loc_cCodTams
        LOCAL loc_nQtdDistr, loc_cEmps, loc_cGrupos, loc_cContas
        LOCAL loc_nTotDis, loc_nQtdNeg

        loc_lSucesso         = .F.
        loc_lTransacaoAberta = .F.

        *-- Validar cursor_4c_Distribui tem quantidades
        IF !USED("cursor_4c_Distribui")
            MsgAviso("Cursor de distribui" + CHR(231) + CHR(227) + CHR(227) + ;
                     "o n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Distribui
        SUM QtdDistr TO loc_nTotDis
        IF loc_nTotDis = 0
            MsgAviso("Nenhum produto foi informado para distribuir.", "Aviso")
            RETURN .F.
        ENDIF

        *-- Validar sem saldos negativos em cursor_4c_Disponivel
        IF USED("cursor_4c_Disponivel")
            SELECT cursor_4c_Disponivel
            GO TOP
            COUNT FOR QtdSaldo < 0 TO loc_nQtdNeg
            IF loc_nQtdNeg > 0
                MsgAviso("Existem produtos distribu" + CHR(237) + "dos que est" + ;
                         CHR(227) + "o ficando com saldo negativo." + CHR(13) + ;
                         "Favor checar antes de processar.", "Aviso")
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacaoAberta = .T.

            *-- Se ALTERAR: remover linhas existentes do lote
            IF UPPER(ALLTRIM(par_cEscolha)) = "ALTERAR" AND !EMPTY(par_cCodigos)
                loc_cSQL = "DELETE FROM SigPrDis WHERE Codigos = " + ;
                           EscaparSQL(par_cCodigos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    MsgErro("Erro ao remover lote anterior:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Para cada produto disponivel x empresa distribui: INSERT em SigPrDis
            IF USED("cursor_4c_Disponivel")
                SELECT cursor_4c_Disponivel
                GO TOP
                DO WHILE !EOF("cursor_4c_Disponivel")
                    loc_cCpros   = ALLTRIM(cursor_4c_Disponivel.cpros)
                    loc_cCodCors = ALLTRIM(cursor_4c_Disponivel.codcors)
                    loc_cCodTams = ALLTRIM(cursor_4c_Disponivel.codtams)

                    SELECT cursor_4c_Distribui
                    GO TOP
                    DO WHILE !EOF("cursor_4c_Distribui")
                        loc_nQtdDistr = cursor_4c_Distribui.QtdDistr
                        loc_cEmps     = ALLTRIM(cursor_4c_Distribui.emps)
                        loc_cGrupos   = ALLTRIM(cursor_4c_Distribui.grupos)
                        loc_cContas   = ALLTRIM(cursor_4c_Distribui.contas)

                        IF loc_nQtdDistr > 0
                            loc_cCidChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigPrDis" + ;
                                       " (cidchaves, codigos, codcors, codtams, cpros," + ;
                                       "  datas, dtalts, empdopnums, empds, empgruests," + ;
                                       "  locals, qtdos, qtds, usualts, usuars, oridopnums)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cCidChaves)                               + "," + ;
                                       EscaparSQL(par_cCodigos)                                 + "," + ;
                                       EscaparSQL(loc_cCodCors)                                 + "," + ;
                                       EscaparSQL(loc_cCodTams)                                 + "," + ;
                                       EscaparSQL(loc_cCpros)                                   + "," + ;
                                       "GETDATE(),"                                                    + ;
                                       "GETDATE(),"                                                    + ;
                                       EscaparSQL(loc_cEmps + loc_cGrupos + loc_cContas)        + "," + ;
                                       EscaparSQL(loc_cEmps)                                    + "," + ;
                                       EscaparSQL(loc_cEmps + loc_cGrupos + loc_cContas)        + "," + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Distribui.locals))          + "," + ;
                                       FormatarNumeroSQL(loc_nQtdDistr)                         + "," + ;
                                       FormatarNumeroSQL(loc_nQtdDistr)                         + "," + ;
                                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))                + "," + ;
                                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))                + "," + ;
                                       "'')"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                MsgErro("Erro ao inserir linha de distribui" + ;
                                        CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_Distribui
                        SKIP
                    ENDDO

                    SELECT cursor_4c_Disponivel
                    SKIP
                ENDDO
            ENDIF

            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
            loc_lTransacaoAberta = .F.

            THIS.this_cCodigos = par_cCodigos
            THIS.RegistrarAuditoria(IIF(UPPER(ALLTRIM(par_cEscolha)) = "INSERIR", "INSERT", "UPDATE"))
            loc_lSucesso = .T.

        CATCH TO loException
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            MsgErro("Erro em ProcessarDistribuicao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Carrega operacoes de SigMvCab geradas pela distribuicao
    * Cria cursor_4c_CabOpera: cidchaves, emps, dopes, numes, grupos, datas
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_CabOpera")
                USE IN cursor_4c_CabOpera
            ENDIF

            loc_cSQL = "SELECT m.cidchaves AS cidchaves, m.emps AS emps, m.dopes AS dopes, m.numes AS numes," + ;
                       "  m.grupos AS grupos, m.datas AS datas, m.empdopnums AS empdopnums" + ;
                       " FROM SigMvCab m" + ;
                       " WHERE m.empdopnums IN (" + ;
                       "   SELECT DISTINCT empdopnums FROM SigPrDis" + ;
                       "   WHERE Codigos = " + EscaparSQL(par_cCodigos) + ")" + ;
                       " ORDER BY m.emps, m.dopes, m.numes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabOpera")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_CabOpera")
                    GO TOP IN cursor_4c_CabOpera
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarOperacoes:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarItensOperacao - Carrega itens distribuidos de uma operacao/lote
    * Cria cursor_4c_ItnOpera: cidchaves, cpros, dpros, codcors, codtams, qtds, qtdos
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItensOperacao(par_cEmpdopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_ItnOpera")
                USE IN cursor_4c_ItnOpera
            ENDIF

            loc_cSQL = "SELECT d.cidchaves, d.cpros, ISNULL(p.dpros,'') AS dpros," + ;
                       "  d.codcors, d.codtams, d.qtds, d.qtdos" + ;
                       " FROM SigPrDis d" + ;
                       " LEFT JOIN SigCdPro p ON p.cpros = d.cpros" + ;
                       " WHERE d.empdopnums = " + EscaparSQL(par_cEmpdopNums) + ;
                       " ORDER BY d.cpros, d.codcors, d.codtams"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnOpera")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar itens da opera" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ItnOpera")
                    GO TOP IN cursor_4c_ItnOpera
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarItensOperacao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

