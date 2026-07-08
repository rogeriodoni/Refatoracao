# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 267: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 927: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1542 linhas total):

*-- Linhas 102 a 149:
102:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
103:         loc_oCab = THIS.cnt_4c_Cabecalho
104:         WITH loc_oCab
105:             .Top         = 0
106:             .Left        = 0
107:             .Width       = THIS.Width
108:             .Height      = 80
109:             .BackStyle   = 1
110:             .BackColor   = RGB(100, 100, 100)
111:             .BorderWidth = 0
112: 
113:             .AddObject("lbl_4c_Sombra", "Label")
114:             WITH .lbl_4c_Sombra
115:                 .AutoSize      = .F.
116:                 .Top           = 18
117:                 .Left          = 10
118:                 .Width         = loc_oCab.Width
119:                 .Height        = 40
120:                 .FontBold      = .T.
121:                 .FontName      = "Tahoma"
122:                 .FontSize      = 18
123:                 .FontUnderline = .F.
124:                 .WordWrap      = .T.
125:                 .Alignment     = 0
126:                 .BackStyle     = 0
127:                 .Caption       = "Capacidade Produtiva"
128:                 .ForeColor     = RGB(0, 0, 0)
129:             ENDWITH
130: 
131:             .AddObject("lbl_4c_Titulo", "Label")
132:             WITH .lbl_4c_Titulo
133:                 .AutoSize  = .F.
134:                 .Top       = 17
135:                 .Left      = 10
136:                 .Width     = loc_oCab.Width
137:                 .Height    = 46
138:                 .FontBold  = .T.
139:                 .FontName  = "Tahoma"
140:                 .FontSize  = 18
141:                 .WordWrap  = .T.
142:                 .Alignment = 0
143:                 .BackStyle = 0
144:                 .Caption   = "Capacidade Produtiva"
145:                 .ForeColor = RGB(255, 255, 255)
146:             ENDWITH
147:         ENDWITH
148: 
149:         loc_oCab.Visible = .T.

*-- Linhas 164 a 184:
164: 
165:         WITH loc_oPgf
166:             .PageCount = 2
167:             .Top       = 80
168:             .Left      = 0
169:             .Width     = THIS.Width
170:             .Height    = THIS.Height - 80
171:             .TabIndex  = 1
172:             .Tabs      = .F.
173:             .BorderWidth = 0
174:             .BackStyle = 0
175: 
176:             .Page1.Caption = "Principal"
177:             .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
178: 
179:             .Page2.Caption = "Detalhes"
180:             .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
181: 
182:             .Visible    = .T.
183:             .ActivePage = 1
184:         ENDWITH

*-- Linhas 256 a 340:
256:         loc_oPg = THIS.pgf_4c_Paginas.Page1
257: 
258:         *-- Botao Encerrar (topo direito da area de conteudo)
259:         loc_oPg.AddObject("cmd_4c_Sair", "CommandButton")
260:         WITH loc_oPg.cmd_4c_Sair
261:             .Top             = 5
262:             .Left            = 725
263:             .Width           = 75
264:             .Height          = 75
265:             .Caption         = "Encerrar"
266:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
267:             .FontName        = "Comic Sans MS"
268:             .FontBold        = .T.
269:             .FontItalic      = .T.
270:             .FontSize        = 8
271:             .ForeColor       = RGB(90, 90, 90)
272:             .BackColor       = RGB(255, 255, 255)
273:             .Themes          = .T.
274:             .SpecialEffect   = 0
275:             .PicturePosition = 13
276:             .MousePointer    = 15
277:             .WordWrap        = .T.
278:         ENDWITH
279:         BINDEVENT(loc_oPg.cmd_4c_Sair, "Click", THIS, "CmdSairClick")
280: 
281:         *-- Container1: parametros de consulta (Fase e Data)
282:         loc_oPg.AddObject("cnt_4c_Container1", "Container")
283:         loc_oCnt1 = loc_oPg.cnt_4c_Container1
284:         WITH loc_oCnt1
285:             .Top         = 24
286:             .Left        = 10
287:             .Width       = 347
288:             .Height      = 36
289:             .BackStyle   = 0
290:             .BorderWidth = 0
291: 
292:             .AddObject("lbl_4c_LblFase", "Label")
293:             WITH .lbl_4c_LblFase
294:                 .Top       = 8
295:                 .Left      = 2
296:                 .Width     = 50
297:                 .Height    = 17
298:                 .Caption   = "Fase :"
299:                 .FontName  = "Tahoma"
300:                 .FontSize  = 8
301:                 .BackStyle = 0
302:                 .ForeColor = RGB(90, 90, 90)
303:             ENDWITH
304: 
305:             .AddObject("txt_4c_Fase", "TextBox")
306:             WITH .txt_4c_Fase
307:                 .Top       = 5
308:                 .Left      = 55
309:                 .Width     = 125
310:                 .Height    = 23
311:                 .FontBold  = .T.
312:                 .FontName  = "Tahoma"
313:                 .FontSize  = 8
314:                 .BackColor = RGB(255, 198, 140)
315:                 .Value     = ""
316:                 .ReadOnly  = .T.
317:             ENDWITH
318: 
319:             .AddObject("lbl_4c_LblData", "Label")
320:             WITH .lbl_4c_LblData
321:                 .Top       = 9
322:                 .Left      = 185
323:                 .Width     = 50
324:                 .Height    = 17
325:                 .Caption   = "Data :"
326:                 .FontName  = "Tahoma"
327:                 .FontSize  = 8
328:                 .BackStyle = 0
329:                 .ForeColor = RGB(90, 90, 90)
330:             ENDWITH
331: 
332:             .AddObject("txt_4c_Data", "TextBox")
333:             WITH .txt_4c_Data
334:                 .Top       = 5
335:                 .Left      = 236
336:                 .Width     = 90
337:                 .Height    = 23
338:                 .FontBold  = .T.
339:                 .FontName  = "Tahoma"
340:                 .FontSize  = 8

*-- Linhas 348 a 495:
348:         loc_oPg.AddObject("cnt_4c_Container2", "Container")
349:         loc_oCnt2 = loc_oPg.cnt_4c_Container2
350:         WITH loc_oCnt2
351:             .Top         = 24
352:             .Left        = 368
353:             .Width       = 540
354:             .Height      = 36
355:             .BackStyle   = 0
356:             .BorderWidth = 0
357: 
358:             .AddObject("lbl_4c_LblCap", "Label")
359:             WITH .lbl_4c_LblCap
360:                 .Top       = 10
361:                 .Left      = 9
362:                 .Width     = 87
363:                 .Height    = 15
364:                 .Caption   = "Capacidade:"
365:                 .FontName  = "Tahoma"
366:                 .FontSize  = 8
367:                 .BackStyle = 0
368:                 .ForeColor = RGB(90, 90, 90)
369:             ENDWITH
370: 
371:             .AddObject("txt_4c_Cap", "TextBox")
372:             WITH .txt_4c_Cap
373:                 .Top       = 5
374:                 .Left      = 100
375:                 .Width     = 79
376:                 .Height    = 23
377:                 .FontBold  = .T.
378:                 .FontName  = "Tahoma"
379:                 .FontSize  = 8
380:                 .BackColor = RGB(255, 216, 176)
381:                 .InputMask = "99999"
382:                 .Value     = 0
383:                 .ReadOnly  = .T.
384:                 .Alignment = 2
385:             ENDWITH
386: 
387:             .AddObject("lbl_4c_LblMin1", "Label")
388:             WITH .lbl_4c_LblMin1
389:                 .Top       = 10
390:                 .Left      = 184
391:                 .Width     = 28
392:                 .Height    = 15
393:                 .Caption   = "Min"
394:                 .FontName  = "Tahoma"
395:                 .FontSize  = 8
396:                 .BackStyle = 0
397:                 .ForeColor = RGB(90, 90, 90)
398:             ENDWITH
399: 
400:             .AddObject("lbl_4c_LblUtz", "Label")
401:             WITH .lbl_4c_LblUtz
402:                 .Top       = 10
403:                 .Left      = 220
404:                 .Width     = 68
405:                 .Height    = 15
406:                 .Caption   = "Utilizado:"
407:                 .FontName  = "Tahoma"
408:                 .FontSize  = 8
409:                 .BackStyle = 0
410:                 .ForeColor = RGB(90, 90, 90)
411:             ENDWITH
412: 
413:             .AddObject("txt_4c_Utz", "TextBox")
414:             WITH .txt_4c_Utz
415:                 .Top       = 5
416:                 .Left      = 290
417:                 .Width     = 79
418:                 .Height    = 23
419:                 .FontBold  = .T.
420:                 .FontName  = "Tahoma"
421:                 .FontSize  = 8
422:                 .BackColor = RGB(255, 216, 176)
423:                 .InputMask = "99999"
424:                 .Value     = 0
425:                 .ReadOnly  = .T.
426:                 .Alignment = 2
427:             ENDWITH
428: 
429:             .AddObject("lbl_4c_LblMin2", "Label")
430:             WITH .lbl_4c_LblMin2
431:                 .Top       = 10
432:                 .Left      = 374
433:                 .Width     = 28
434:                 .Height    = 15
435:                 .Caption   = "Min"
436:                 .FontName  = "Tahoma"
437:                 .FontSize  = 8
438:                 .BackStyle = 0
439:                 .ForeColor = RGB(90, 90, 90)
440:             ENDWITH
441: 
442:             .AddObject("lbl_4c_LblSld", "Label")
443:             WITH .lbl_4c_LblSld
444:                 .Top       = 10
445:                 .Left      = 410
446:                 .Width     = 52
447:                 .Height    = 15
448:                 .Caption   = "Saldo : "
449:                 .FontName  = "Tahoma"
450:                 .FontSize  = 8
451:                 .BackStyle = 0
452:                 .ForeColor = RGB(90, 90, 90)
453:             ENDWITH
454: 
455:             .AddObject("txt_4c_Sld", "TextBox")
456:             WITH .txt_4c_Sld
457:                 .Top       = 5
458:                 .Left      = 468
459:                 .Width     = 79
460:                 .Height    = 23
461:                 .FontBold  = .T.
462:                 .FontName  = "Tahoma"
463:                 .FontSize  = 8
464:                 .BackColor = RGB(255, 216, 176)
465:                 .InputMask = "99999"
466:                 .Value     = 0
467:                 .ReadOnly  = .T.
468:                 .Alignment = 2
469:             ENDWITH
470: 
471:             .AddObject("lbl_4c_LblMin3", "Label")
472:             WITH .lbl_4c_LblMin3
473:                 .Top       = 10
474:                 .Left      = 552
475:                 .Width     = 28
476:                 .Height    = 15
477:                 .Caption   = "Min"
478:                 .FontName  = "Tahoma"
479:                 .FontSize  = 8
480:                 .BackStyle = 0
481:                 .ForeColor = RGB(90, 90, 90)
482:             ENDWITH
483:         ENDWITH
484: 
485:         *-- Grid de capacidade produtiva (8 colunas, read-only)
486:         loc_oPg.AddObject("grd_4c_Dados", "Grid")
487:         loc_oGrid = loc_oPg.grd_4c_Dados
488:         WITH loc_oGrid
489:             .Top                = 59
490:             .Left               = 0
491:             .Width              = 1000
492:             .Height             = 310
493:             .ColumnCount        = 8
494:             .FontName           = "Verdana"
495:             .FontSize           = 8

*-- Linhas 508 a 713:
508:             WITH .Column1
509:                 .Width               = 70
510:                 .Alignment           = 2
511:                 .Header1.Caption     = "Envelope"
512:                 .Text1.FontName      = "Verdana"
513:                 .Text1.FontSize      = 8
514:                 .Text1.Alignment     = 2
515:             ENDWITH
516: 
517:             WITH .Column2
518:                 .Width               = 120
519:                 .Header1.Caption     = "O.P."
520:                 .Text1.FontName      = "Verdana"
521:                 .Text1.FontSize      = 8
522:             ENDWITH
523: 
524:             WITH .Column3
525:                 .Width               = 40
526:                 .Alignment           = 2
527:                 .Header1.Caption     = "Seq"
528:                 .Text1.FontName      = "Verdana"
529:                 .Text1.FontSize      = 8
530:                 .Text1.Alignment     = 2
531:             ENDWITH
532: 
533:             WITH .Column4
534:                 .Width               = 65
535:                 .Alignment           = 2
536:                 .Header1.Caption     = "Minutos"
537:                 .Text1.FontName      = "Verdana"
538:                 .Text1.FontSize      = 8
539:                 .Text1.Alignment     = 2
540:             ENDWITH
541: 
542:             WITH .Column5
543:                 .Width               = 100
544:                 .Header1.Caption     = "Produto"
545:                 .Text1.FontName      = "Verdana"
546:                 .Text1.FontSize      = 8
547:             ENDWITH
548: 
549:             WITH .Column6
550:                 .Width               = 160
551:                 .Header1.Caption     = "Opera" + CHR(231) + CHR(227) + "o"
552:                 .Text1.FontName      = "Verdana"
553:                 .Text1.FontSize      = 8
554:             ENDWITH
555: 
556:             WITH .Column7
557:                 .Width               = 265
558:                 .Header1.Caption     = "Cliente"
559:                 .Text1.FontName      = "Verdana"
560:                 .Text1.FontSize      = 8
561:             ENDWITH
562: 
563:             WITH .Column8
564:                 .Width               = 180
565:                 .Header1.Caption     = "Unidade Prod."
566:                 .Text1.FontName      = "Verdana"
567:                 .Text1.FontSize      = 8
568:             ENDWITH
569:         ENDWITH
570:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
571:         BINDEVENT(loc_oGrid, "DblClick", THIS, "GrdDadosDblClick")
572: 
573:         *-- Labels e campos informativos abaixo do grid
574:         loc_oPg.AddObject("lbl_4c_LblQtde", "Label")
575:         WITH loc_oPg.lbl_4c_LblQtde
576:             .Top       = 378
577:             .Left      = 11
578:             .Width     = 80
579:             .Height    = 15
580:             .Caption   = "Quantidade"
581:             .FontName  = "Tahoma"
582:             .FontSize  = 8
583:             .BackStyle = 0
584:             .ForeColor = RGB(90, 90, 90)
585:         ENDWITH
586: 
587:         loc_oPg.AddObject("txt_4c_Qtde", "TextBox")
588:         WITH loc_oPg.txt_4c_Qtde
589:             .Top       = 391
590:             .Left      = 9
591:             .Width     = 92
592:             .Height    = 23
593:             .FontBold  = .T.
594:             .FontName  = "Tahoma"
595:             .FontSize  = 8
596:             .BackColor = RGB(255, 255, 198)
597:             .InputMask = "99999.999"
598:             .Value     = 0
599:             .ReadOnly  = .T.
600:         ENDWITH
601: 
602:         loc_oPg.AddObject("lbl_4c_LblDescr", "Label")
603:         WITH loc_oPg.lbl_4c_LblDescr
604:             .Top       = 378
605:             .Left      = 112
606:             .Width     = 180
607:             .Height    = 15
608:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Produto"
609:             .FontName  = "Tahoma"
610:             .FontSize  = 8
611:             .BackStyle = 0
612:             .ForeColor = RGB(90, 90, 90)
613:         ENDWITH
614: 
615:         loc_oPg.AddObject("txt_4c_Descr", "TextBox")
616:         WITH loc_oPg.txt_4c_Descr
617:             .Top       = 391
618:             .Left      = 112
619:             .Width     = 431
620:             .Height    = 23
621:             .FontBold  = .T.
622:             .FontName  = "Tahoma"
623:             .FontSize  = 8
624:             .BackColor = RGB(255, 255, 198)
625:             .Value     = ""
626:             .ReadOnly  = .T.
627:         ENDWITH
628: 
629:         loc_oPg.AddObject("lbl_4c_LblPrioridade", "Label")
630:         WITH loc_oPg.lbl_4c_LblPrioridade
631:             .Top       = 378
632:             .Left      = 716
633:             .Width     = 200
634:             .Height    = 15
635:             .Caption   = "[ Opera" + CHR(231) + CHR(227) + "o com Prioridade ]"
636:             .FontName  = "Tahoma"
637:             .FontSize  = 8
638:             .BackStyle = 0
639:             .ForeColor = RGB(90, 90, 90)
640:         ENDWITH
641: 
642:         *-- Imagem do produto (Visible=.F. - gerenciada por AfterRowColChange)
643:         loc_oPg.AddObject("shp_4c_Shape4", "Shape")
644:         WITH loc_oPg.shp_4c_Shape4
645:             .Top           = 376
646:             .Left          = 567
647:             .Width         = 148
648:             .Height        = 109
649:             .Visible       = .F.
650:             .BackStyle     = 0
651:             .BorderColor   = RGB(90, 90, 90)
652:             .SpecialEffect = 0
653:         ENDWITH
654: 
655:         loc_oPg.AddObject("img_4c_FigJpg", "Image")
656:         WITH loc_oPg.img_4c_FigJpg
657:             .Top     = 378
658:             .Left    = 570
659:             .Width   = 143
660:             .Height  = 105
661:             .Visible = .F.
662:             .Stretch = 2
663:         ENDWITH
664: 
665:         loc_oPg.AddObject("lbl_4c_LblCliente", "Label")
666:         WITH loc_oPg.lbl_4c_LblCliente
667:             .Top       = 419
668:             .Left      = 11
669:             .Width     = 50
670:             .Height    = 15
671:             .Caption   = "Cliente"
672:             .FontName  = "Tahoma"
673:             .FontSize  = 8
674:             .BackStyle = 0
675:             .ForeColor = RGB(90, 90, 90)
676:         ENDWITH
677: 
678:         loc_oPg.AddObject("txt_4c_Cliente", "TextBox")
679:         WITH loc_oPg.txt_4c_Cliente
680:             .Top       = 432
681:             .Left      = 9
682:             .Width     = 531
683:             .Height    = 23
684:             .FontBold  = .T.
685:             .FontName  = "Tahoma"
686:             .FontSize  = 8
687:             .BackColor = RGB(255, 255, 221)
688:             .Value     = ""
689:             .ReadOnly  = .T.
690:         ENDWITH
691: 
692:         loc_oPg.AddObject("lbl_4c_LblTEnv", "Label")
693:         WITH loc_oPg.lbl_4c_LblTEnv
694:             .Top       = 457
695:             .Left      = 11
696:             .Width     = 160
697:             .Height    = 15
698:             .Caption   = "Tempo Total do Envelope"
699:             .FontName  = "Tahoma"
700:             .FontSize  = 8
701:             .BackStyle = 0
702:             .ForeColor = RGB(90, 90, 90)
703:         ENDWITH
704: 
705:         loc_oPg.AddObject("txt_4c_TEnv", "TextBox")
706:         WITH loc_oPg.txt_4c_TEnv
707:             .Top       = 470
708:             .Left      = 9
709:             .Width     = 92
710:             .Height    = 23
711:             .FontBold  = .T.
712:             .FontName  = "Tahoma"
713:             .FontSize  = 8

*-- Linhas 754 a 769:
754:             .Column8.ControlSource = "cursor_4c_Dados.UniPrdts"
755: 
756:             *-- Redefine cabecalhos (RecordSource reseta headers)
757:             .Column1.Header1.Caption = "Envelope"
758:             .Column2.Header1.Caption = "O.P."
759:             .Column3.Header1.Caption = "Seq"
760:             .Column4.Header1.Caption = "Minutos"
761:             .Column5.Header1.Caption = "Produto"
762:             .Column6.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
763:             .Column7.Header1.Caption = "Cliente"
764:             .Column8.Header1.Caption = "Unidade Prod."
765: 
766:             *-- Ordem visual: Column8=UniPrdts na 1a posicao (conforme SCX original)
767:             .Column1.ColumnOrder = 2
768:             .Column2.ColumnOrder = 3
769:             .Column3.ColumnOrder = 4

*-- Linhas 916 a 1002:
916:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
917: 
918:         *-- Botao Voltar (retorna a Page1)
919:         loc_oPg2.AddObject("cmd_4c_Voltar", "CommandButton")
920:         WITH loc_oPg2.cmd_4c_Voltar
921:             .Top             = 5
922:             .Left            = 916
923:             .Width           = 75
924:             .Height          = 75
925:             .Caption         = "Voltar"
926:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
927:             .FontName        = "Comic Sans MS"
928:             .FontBold        = .T.
929:             .FontItalic      = .T.
930:             .FontSize        = 8
931:             .ForeColor       = RGB(90, 90, 90)
932:             .BackColor       = RGB(255, 255, 255)
933:             .Themes          = .T.
934:             .SpecialEffect   = 0
935:             .PicturePosition = 13
936:             .MousePointer    = 15
937:             .WordWrap        = .T.
938:         ENDWITH
939:         BINDEVENT(loc_oPg2.cmd_4c_Voltar, "Click", THIS, "CmdVoltarClick")
940: 
941:         *-- Container de informacoes do produto (primeira metade dos campos de Page2)
942:         loc_oPg2.AddObject("cnt_4c_InfoProd", "Container")
943:         loc_oCnt = loc_oPg2.cnt_4c_InfoProd
944:         WITH loc_oCnt
945:             .Top         = 10
946:             .Left        = 10
947:             .Width       = 500
948:             .Height      = 490
949:             .BackStyle   = 0
950:             .BorderWidth = 0
951: 
952:             .AddObject("lbl_4c_LblProd2", "Label")
953:             WITH .lbl_4c_LblProd2
954:                 .Top       = 10
955:                 .Left      = 5
956:                 .Width     = 150
957:                 .Height    = 17
958:                 .Caption   = "C" + CHR(243) + "d. Produto:"
959:                 .FontName  = "Tahoma"
960:                 .FontBold  = .T.
961:                 .FontSize  = 8
962:                 .BackStyle = 0
963:                 .ForeColor = RGB(90, 90, 90)
964:             ENDWITH
965: 
966:             .AddObject("txt_4c_Prod2", "TextBox")
967:             WITH .txt_4c_Prod2
968:                 .Top       = 30
969:                 .Left      = 5
970:                 .Width     = 200
971:                 .Height    = 23
972:                 .FontName  = "Tahoma"
973:                 .FontBold  = .T.
974:                 .FontSize  = 8
975:                 .Value     = ""
976:                 .ReadOnly  = .T.
977:                 .BackColor = RGB(255, 255, 198)
978:             ENDWITH
979: 
980:             .AddObject("lbl_4c_LblDescr2", "Label")
981:             WITH .lbl_4c_LblDescr2
982:                 .Top       = 65
983:                 .Left      = 5
984:                 .Width     = 300
985:                 .Height    = 17
986:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o Produto:"
987:                 .FontName  = "Tahoma"
988:                 .FontBold  = .T.
989:                 .FontSize  = 8
990:                 .BackStyle = 0
991:                 .ForeColor = RGB(90, 90, 90)
992:             ENDWITH
993: 
994:             .AddObject("txt_4c_Descr2", "TextBox")
995:             WITH .txt_4c_Descr2
996:                 .Top       = 85
997:                 .Left      = 5
998:                 .Width     = 490
999:                 .Height    = 23
1000:                 .FontName  = "Tahoma"
1001:                 .FontBold  = .T.
1002:                 .FontSize  = 8

*-- Linhas 1008 a 1237:
1008:             *-- Foto do produto ampliada (inicialmente oculta ate selecionar registro com foto)
1009:             .AddObject("shp_4c_Shape2", "Shape")
1010:             WITH .shp_4c_Shape2
1011:                 .Top           = 120
1012:                 .Left          = 5
1013:                 .Width         = 240
1014:                 .Height        = 240
1015:                 .Visible       = .F.
1016:                 .BackStyle     = 0
1017:                 .BorderColor   = RGB(90, 90, 90)
1018:                 .SpecialEffect = 0
1019:             ENDWITH
1020: 
1021:             .AddObject("img_4c_FigJpg2", "Image")
1022:             WITH .img_4c_FigJpg2
1023:                 .Top     = 122
1024:                 .Left    = 7
1025:                 .Width   = 236
1026:                 .Height  = 236
1027:                 .Visible = .F.
1028:                 .Stretch = 2
1029:             ENDWITH
1030:         ENDWITH
1031: 
1032:         *-- Container com detalhe da linha selecionada no grid (envelope, OP, seq, tempo, operacao, cliente, unidade)
1033:         loc_oPg2.AddObject("cnt_4c_DetalheLinha", "Container")
1034:         WITH loc_oPg2.cnt_4c_DetalheLinha
1035:             .Top         = 10
1036:             .Left        = 520
1037:             .Width       = 460
1038:             .Height      = 280
1039:             .BackStyle   = 0
1040:             .BorderWidth = 0
1041: 
1042:             .AddObject("lbl_4c_LblEnvDet", "Label")
1043:             WITH .lbl_4c_LblEnvDet
1044:                 .Top       = 5
1045:                 .Left      = 5
1046:                 .Width     = 100
1047:                 .Height    = 17
1048:                 .Caption   = "Envelope:"
1049:                 .FontBold  = .T.
1050:                 .FontName  = "Tahoma"
1051:                 .FontSize  = 8
1052:                 .BackStyle = 0
1053:                 .ForeColor = RGB(90, 90, 90)
1054:             ENDWITH
1055: 
1056:             .AddObject("txt_4c_Nenvs2", "TextBox")
1057:             WITH .txt_4c_Nenvs2
1058:                 .Top       = 22
1059:                 .Left      = 5
1060:                 .Width     = 100
1061:                 .Height    = 23
1062:                 .FontBold  = .T.
1063:                 .FontName  = "Tahoma"
1064:                 .FontSize  = 8
1065:                 .BackColor = RGB(255, 255, 198)
1066:                 .Value     = 0
1067:                 .ReadOnly  = .T.
1068:                 .Alignment = 2
1069:             ENDWITH
1070: 
1071:             .AddObject("lbl_4c_LblOpsDet", "Label")
1072:             WITH .lbl_4c_LblOpsDet
1073:                 .Top       = 5
1074:                 .Left      = 120
1075:                 .Width     = 80
1076:                 .Height    = 17
1077:                 .Caption   = "O.P.:"
1078:                 .FontBold  = .T.
1079:                 .FontName  = "Tahoma"
1080:                 .FontSize  = 8
1081:                 .BackStyle = 0
1082:                 .ForeColor = RGB(90, 90, 90)
1083:             ENDWITH
1084: 
1085:             .AddObject("txt_4c_Nops2", "TextBox")
1086:             WITH .txt_4c_Nops2
1087:                 .Top       = 22
1088:                 .Left      = 120
1089:                 .Width     = 100
1090:                 .Height    = 23
1091:                 .FontBold  = .T.
1092:                 .FontName  = "Tahoma"
1093:                 .FontSize  = 8
1094:                 .BackColor = RGB(255, 255, 198)
1095:                 .Value     = 0
1096:                 .ReadOnly  = .T.
1097:                 .Alignment = 2
1098:             ENDWITH
1099: 
1100:             .AddObject("lbl_4c_LblSeqDet", "Label")
1101:             WITH .lbl_4c_LblSeqDet
1102:                 .Top       = 5
1103:                 .Left      = 240
1104:                 .Width     = 50
1105:                 .Height    = 17
1106:                 .Caption   = "Seq:"
1107:                 .FontBold  = .T.
1108:                 .FontName  = "Tahoma"
1109:                 .FontSize  = 8
1110:                 .BackStyle = 0
1111:                 .ForeColor = RGB(90, 90, 90)
1112:             ENDWITH
1113: 
1114:             .AddObject("txt_4c_Seqs2", "TextBox")
1115:             WITH .txt_4c_Seqs2
1116:                 .Top       = 22
1117:                 .Left      = 240
1118:                 .Width     = 70
1119:                 .Height    = 23
1120:                 .FontBold  = .T.
1121:                 .FontName  = "Tahoma"
1122:                 .FontSize  = 8
1123:                 .BackColor = RGB(255, 255, 198)
1124:                 .Value     = 0
1125:                 .ReadOnly  = .T.
1126:                 .Alignment = 2
1127:             ENDWITH
1128: 
1129:             .AddObject("lbl_4c_LblTRealDet", "Label")
1130:             WITH .lbl_4c_LblTRealDet
1131:                 .Top       = 5
1132:                 .Left      = 330
1133:                 .Width     = 100
1134:                 .Height    = 17
1135:                 .Caption   = "Minutos:"
1136:                 .FontBold  = .T.
1137:                 .FontName  = "Tahoma"
1138:                 .FontSize  = 8
1139:                 .BackStyle = 0
1140:                 .ForeColor = RGB(90, 90, 90)
1141:             ENDWITH
1142: 
1143:             .AddObject("txt_4c_TReal2", "TextBox")
1144:             WITH .txt_4c_TReal2
1145:                 .Top       = 22
1146:                 .Left      = 330
1147:                 .Width     = 100
1148:                 .Height    = 23
1149:                 .FontBold  = .T.
1150:                 .FontName  = "Tahoma"
1151:                 .FontSize  = 8
1152:                 .BackColor = RGB(255, 255, 198)
1153:                 .InputMask = "99999"
1154:                 .Value     = 0
1155:                 .ReadOnly  = .T.
1156:                 .Alignment = 2
1157:             ENDWITH
1158: 
1159:             .AddObject("lbl_4c_LblDopesDet", "Label")
1160:             WITH .lbl_4c_LblDopesDet
1161:                 .Top       = 60
1162:                 .Left      = 5
1163:                 .Width     = 200
1164:                 .Height    = 17
1165:                 .Caption   = "Opera" + CHR(231) + CHR(227) + "o:"
1166:                 .FontBold  = .T.
1167:                 .FontName  = "Tahoma"
1168:                 .FontSize  = 8
1169:                 .BackStyle = 0
1170:                 .ForeColor = RGB(90, 90, 90)
1171:             ENDWITH
1172: 
1173:             .AddObject("txt_4c_Dopes2", "TextBox")
1174:             WITH .txt_4c_Dopes2
1175:                 .Top       = 77
1176:                 .Left      = 5
1177:                 .Width     = 450
1178:                 .Height    = 23
1179:                 .FontBold  = .T.
1180:                 .FontName  = "Tahoma"
1181:                 .FontSize  = 8
1182:                 .BackColor = RGB(255, 255, 198)
1183:                 .Value     = ""
1184:                 .ReadOnly  = .T.
1185:             ENDWITH
1186: 
1187:             .AddObject("lbl_4c_LblUniPDet", "Label")
1188:             WITH .lbl_4c_LblUniPDet
1189:                 .Top       = 115
1190:                 .Left      = 5
1191:                 .Width     = 160
1192:                 .Height    = 17
1193:                 .Caption   = "Unidade Produtiva:"
1194:                 .FontBold  = .T.
1195:                 .FontName  = "Tahoma"
1196:                 .FontSize  = 8
1197:                 .BackStyle = 0
1198:                 .ForeColor = RGB(90, 90, 90)
1199:             ENDWITH
1200: 
1201:             .AddObject("txt_4c_UniP2", "TextBox")
1202:             WITH .txt_4c_UniP2
1203:                 .Top       = 132
1204:                 .Left      = 5
1205:                 .Width     = 220
1206:                 .Height    = 23
1207:                 .FontBold  = .T.
1208:                 .FontName  = "Tahoma"
1209:                 .FontSize  = 8
1210:                 .BackColor = RGB(255, 255, 198)
1211:                 .Value     = ""
1212:                 .ReadOnly  = .T.
1213:             ENDWITH
1214: 
1215:             .AddObject("lbl_4c_LblRclisDet", "Label")
1216:             WITH .lbl_4c_LblRclisDet
1217:                 .Top       = 170
1218:                 .Left      = 5
1219:                 .Width     = 60
1220:                 .Height    = 17
1221:                 .Caption   = "Cliente:"
1222:                 .FontBold  = .T.
1223:                 .FontName  = "Tahoma"
1224:                 .FontSize  = 8
1225:                 .BackStyle = 0
1226:                 .ForeColor = RGB(90, 90, 90)
1227:             ENDWITH
1228: 
1229:             .AddObject("txt_4c_Rclis2", "TextBox")
1230:             WITH .txt_4c_Rclis2
1231:                 .Top       = 187
1232:                 .Left      = 5
1233:                 .Width     = 450
1234:                 .Height    = 23
1235:                 .FontBold  = .T.
1236:                 .FontName  = "Tahoma"
1237:                 .FontSize  = 8

*-- Linhas 1468 a 1477:
1468:             RETURN
1469:         ENDIF
1470:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1471:         IF TYPE("loc_oPg.cmd_4c_Sair") = "O"
1472:             loc_oPg.cmd_4c_Sair.Enabled = .T.
1473:         ENDIF
1474:     ENDPROC
1475: 
1476:     *==========================================================================
1477:     * BtnBuscarClick - Recarrega consulta com parametros atuais (equivale a refresh)


### BO (C:\4c\projeto\app\classes\sigprcpdBO.prg):
*==============================================================================
* sigprcpdBO.prg - Business Object para Capacidade Produtiva
* Form OPERACIONAL (consulta somente leitura - sem CRUD)
* Tabelas: SigCdPcz, SigCdPcP, SigCdPcg, SigCdPco, SigCdCli, SigCdPro
*==============================================================================
DEFINE CLASS sigprcpdBO AS BusinessBase

    *-- Parametros de consulta (recebidos do chamador via Form.Init)
    this_nCodigo    = 0
    this_cFase      = ""
    this_cUnidade   = ""
    this_dData      = {}

    *-- Resumo de capacidade (vindos de SigCdPcP agrupado)
    this_nCapacidade  = 0
    this_nUtilizado   = 0
    this_nSaldo       = 0

    *-- Detalhe do produto selecionado no grid (SigCdPro)
    this_cDescricaoProduto = ""
    this_cFotoBase64       = ""
    this_cCaminhoFoto      = ""

    *-- Detalhe do envelope/linha selecionada no grid (cursor_4c_Dados)
    this_nQuantidade    = 0
    this_cCliente       = ""
    this_nTempoEnvelope = 0
    this_cProduto       = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "SigCdPcz"
        this_cCampoChave = "codigos"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigo)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega todos os cursores de capacidade produtiva
    *   par_nCodigo  - Codigo do processo (SigCdPcz.codigos)
    *   par_cFase    - Fase/setor de producao
    *   par_cUnidade - Unidade produtiva (vazio = todas as unidades)
    *   par_dData    - Data de consulta
    * Retorna .T. se sucesso, .F. se falha
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados(par_nCodigo, par_cFase, par_cUnidade, par_dData)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_cFiltroUnid

        loc_lSucesso    = .F.
        loc_cFiltroUnid = IIF(EMPTY(par_cUnidade), "", " And UniPrdts = " + EscaparSQL(par_cUnidade))

        THIS.this_nCodigo  = par_nCodigo
        THIS.this_cFase    = par_cFase
        THIS.this_cUnidade = par_cUnidade
        THIS.this_dData    = par_dData

        TRY
            *-- 1. Dados basicos do processo (SigCdPcz)
            IF USED("cursor_4c_Pcp")
                USE IN cursor_4c_Pcp
            ENDIF

            loc_cSQL = "Select * From SigCdPcz Where codigos = " + TRANSFORM(par_nCodigo)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pcp")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar dados do processo (SigCdPcz).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Resumo de capacidade (SigCdPcP agrupado)
            IF USED("cursor_4c_Capacidade")
                USE IN cursor_4c_Capacidade
            ENDIF

            loc_cSQL = "Select Codigos, Sum(minutos) as Minutos, " + ;
                       "sum(minutos-Saldos) as UtilizadoS, Sum(saldos) as Saldos " + ;
                       "From SigCdPcP " + ;
                       "Where Codigos = " + TRANSFORM(par_nCodigo) + ;
                       " And Datas = " + FormatarDataSQL(par_dData) + ;
                       " And Fases = " + EscaparSQL(par_cFase) + ;
                       loc_cFiltroUnid + ;
                       " Group by Codigos"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Capacidade")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar capacidade (SigCdPcP).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF RECCOUNT("cursor_4c_Capacidade") > 0
                SELECT cursor_4c_Capacidade
                GO TOP
                THIS.this_nCapacidade = NVL(cursor_4c_Capacidade.Minutos,    0)
                THIS.this_nUtilizado  = NVL(cursor_4c_Capacidade.UtilizadoS, 0)
                THIS.this_nSaldo      = NVL(cursor_4c_Capacidade.Saldos,     0)
            ELSE
                THIS.this_nCapacidade = 0
                THIS.this_nUtilizado  = 0
                THIS.this_nSaldo      = 0
            ENDIF

            *-- 3. Itens individuais de programacao por item (SigCdPcg)
            IF USED("cursor_4c_PcpPp")
                USE IN cursor_4c_PcpPp
            ENDIF

            loc_cSQL = "Select * from SigCdPcg " + ;
                       "Where datas = " + FormatarDataSQL(par_dData) + ;
                       " And Fases = " + EscaparSQL(par_cFase) + ;
                       " And Codigos = " + TRANSFORM(par_nCodigo) + ;
                       loc_cFiltroUnid + ;
                       " Order by Cidchaves"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PcpPp")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar programa" + CHR(231) + CHR(227) + "o (SigCdPcg).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- 4. Ordens de producao com clientes (SigCdPco + SigCdCli)
            IF USED("cursor_4c_PcpOp2")
                USE IN cursor_4c_PcpOp2
            ENDIF

            loc_cSQL = "Select a.*, " + ;
                       "a.dopes+'-'+RTRIM(STR(a.numes,6)) as Pedido, " + ;
                       "a.contas+'-'+b.rclis as cliente, b.Rclis " + ;
                       "From SigCdPco a, SigCdCli b " + ;
                       "Where a.Codigos = " + TRANSFORM(par_nCodigo) + ;
                       " And a.Fases = " + EscaparSQL(par_cFase) + ;
                       STRTRAN(loc_cFiltroUnid, " UniPrdts", " a.UniPrdts") + ;
                       " And a.Contas = b.Iclis " + ;
                       "Order by a.UniPrdts, a.Seqs, a.Nenvs"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PcpOp2")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar ordens de produ" + CHR(231) + CHR(227) + "o (SigCdPco).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- 5. Agrega minutos por (Fases, UniPrdts, Nenvs, Seqs) via VFP SELECT local
            IF USED("cursor_4c_PcpOp3")
                USE IN cursor_4c_PcpOp3
            ENDIF

            SELECT a.Fases, a.UniPrdts, a.Nenvs, a.Seqs, ;
                   SUM(a.Minutos) AS Minutos ;
            FROM cursor_4c_PcpOp2 a, cursor_4c_PcpPp b ;
            WHERE a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                  b.Fases + b.UniPrdts + STR(b.Nenvs,10) + STR(b.Seqs,2) ;
            INTO CURSOR cursor_4c_PcpOp3 READWRITE ;
            GROUP BY a.Fases, a.UniPrdts, a.Nenvs, a.Seqs

            *-- 6. Cursor final para o grid: combina dados com proporcionalidade de tempo
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            SET NULL ON
            SELECT a.*, b.Minutos AS TempU, c.Minutos AS TempoO, ;
                   fStoM((a.Minutos*60)/(c.Minutos*60)*(b.Minutos*60)) AS TempoReal ;
            FROM cursor_4c_PcpOp2 a, cursor_4c_PcpPp b, cursor_4c_PcpOp3 c ;
            WHERE a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                  b.Fases + b.UniPrdts + STR(b.Nenvs,10) + STR(b.Seqs,2) ;
            AND   a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                  c.Fases + c.UniPrdts + STR(c.Nenvs,10) + STR(c.Seqs,2) ;
            INTO CURSOR cursor_4c_Dados READWRITE ;
            ORDER BY b.Ordems, a.UniPrdts, a.Seqs, a.Nenvs
            SET NULL OFF

            IF RECCOUNT("cursor_4c_Dados") > 0
                SELECT cursor_4c_Dados
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados da linha atual do cursor_4c_Dados para
    * as propriedades da BO. Chamado pelo form em AfterRowColChange do grid,
    * antes de atualizar os labels de descricao, quantidade, cliente e tempo.
    *   par_cAliasCursor - Alias do cursor (normalmente "cursor_4c_Dados")
    * Retorna .T. se carregou, .F. se cursor nao existe ou esta vazio.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Dados", par_cAliasCursor)

        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)

        IF EOF() OR BOF() OR RECCOUNT() = 0
            RETURN .F.
        ENDIF

        *-- Chave do envelope/linha selecionada
        IF TYPE(loc_cAlias + ".Nenvs")    != "U"
            THIS.this_nCodigo = NVL(EVALUATE(loc_cAlias + ".Nenvs"), 0)
        ENDIF

        *-- Produto (para lookup em ObterDetalheProduto)
        IF TYPE(loc_cAlias + ".Cpros") != "U"
            THIS.this_cProduto = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Cpros"), ""))
        ENDIF

        *-- Quantidade (Qtds da OP)
        IF TYPE(loc_cAlias + ".Qtds") != "U"
            THIS.this_nQuantidade = NVL(EVALUATE(loc_cAlias + ".Qtds"), 0)
        ENDIF

        *-- Cliente (Rclis - razao social)
        IF TYPE(loc_cAlias + ".Rclis") != "U"
            THIS.this_cCliente = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Rclis"), ""))
        ENDIF

        *-- Tempo do envelope (TempU calculado em CarregarDados)
        IF TYPE(loc_cAlias + ".TempU") != "U"
            THIS.this_nTempoEnvelope = NVL(EVALUATE(loc_cAlias + ".TempU"), 0)
        ENDIF

        *-- Unidade produtiva (UniPrdts)
        IF TYPE(loc_cAlias + ".UniPrdts") != "U"
            THIS.this_cUnidade = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".UniPrdts"), ""))
        ENDIF

        *-- Fase (Fases)
        IF TYPE(loc_cAlias + ".Fases") != "U"
            THIS.this_cFase = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Fases"), ""))
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Override BusinessBase.
    * Form SIGPRCPD e OPERACIONAL de consulta somente leitura: a tela apenas
    * exibe capacidade produtiva vinda de SigCdPcz/SigCdPcP/SigCdPcg/SigCdPco.
    * Nao ha INSERT em nenhuma tabela no codigo legado. Sobrescrever para
    * bloquear qualquer chamada acidental via BusinessBase.Salvar() e informar
    * o motivo de forma explicita.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Capacidade Produtiva " + CHR(233) + ;
            " uma tela de consulta somente leitura. " + ;
            "Opera" + CHR(231) + CHR(227) + "o de inclus" + CHR(227) + "o n" + ;
            CHR(227) + "o " + CHR(233) + " suportada por este processo."
        MsgAviso(THIS.this_cMensagemErro, "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Override BusinessBase.
    * Mesmo motivo de Inserir(): SIGPRCPD nao altera dados persistidos. Todas
    * as tabelas envolvidas sao apenas lidas (Select * From SigCdPcz, etc.).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Capacidade Produtiva " + CHR(233) + ;
            " uma tela de consulta somente leitura. " + ;
            "Opera" + CHR(231) + CHR(227) + "o de altera" + CHR(231) + CHR(227) + "o n" + ;
            CHR(227) + "o " + CHR(233) + " suportada por este processo."
        MsgAviso(THIS.this_cMensagemErro, "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Override para log de consulta.
    * Como o form eh read-only, registramos apenas a operacao "CONSULTA"
    * para rastrear quem acessou a capacidade produtiva de qual processo.
    *   par_cOperacao - Descartado (sempre gravamos "CONSULTA")
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario

        loc_cChave = THIS.ObterChavePrimaria()

        IF EMPTY(loc_cChave)
            RETURN .F.
        ENDIF

        loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + ;
                   EscaparSQL(THIS.this_cTabela)                     + ", " + ;
                   EscaparSQL("CONSULTA")                            + ", " + ;
                   EscaparSQL(loc_cChave)                            + ", " + ;
                   EscaparSQL(loc_cUsuario)                          + ", " + ;
                   "GETDATE())"

        SQLEXEC(gnConnHandle, loc_cSQL)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDetalheProduto - Carrega foto e descricao do produto da linha atual
    *   par_cCpros    - Codigo do produto (SigCdPro.Cpros)
    * Retorna .T. se produto encontrado com foto valida
    *--------------------------------------------------------------------------
    PROCEDURE ObterDetalheProduto(par_cCpros)
        LOCAL loc_lTemFoto, loc_cSQL, loc_nRet
        LOCAL loc_cFotoBase64, loc_cArquivo

        loc_lTemFoto = .F.

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_cSQL = "Select FigJpgs, Dpros From SigCdPro " + ;
                       "Where Cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")

            IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_Produto") > 0
                SELECT cursor_4c_Produto
                GO TOP

                THIS.this_cDescricaoProduto = NVL(cursor_4c_Produto.Dpros,   "")
                THIS.this_cFotoBase64       = NVL(cursor_4c_Produto.FigJpgs, "")

                IF !EMPTY(THIS.this_cFotoBase64)
                    loc_cFotoBase64 = THIS.this_cFotoBase64
                    loc_cFotoBase64 = STRTRAN(loc_cFotoBase64, "data:image/png;base64,",  "")
                    loc_cFotoBase64 = STRTRAN(loc_cFotoBase64, "data:image/jpeg;base64,", "")
                    loc_cFotoBase64 = STRTRAN(loc_cFotoBase64, "data:image/jpg;base64,",  "")

                    loc_cArquivo    = SYS(2023) + "\sigprcpd.jpg"
                    loc_cFotoBase64 = STRCONV(loc_cFotoBase64, 14)

                    IF STRTOFILE(loc_cFotoBase64, loc_cArquivo) > 0
                        THIS.this_cCaminhoFoto = loc_cArquivo
                        loc_lTemFoto           = .T.
                    ELSE
                        THIS.this_cCaminhoFoto = ""
                    ENDIF
                ELSE
                    THIS.this_cCaminhoFoto = ""
                ENDIF
            ELSE
                THIS.this_cDescricaoProduto = ""
                THIS.this_cFotoBase64       = ""
                THIS.this_cCaminhoFoto      = ""
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lTemFoto
    ENDPROC

ENDDEFINE

*==============================================================================
* fStoM - Converte segundos em minutos (replica funcao fStoM do framework legado)
* Usada nos VFP SELECTs locais dentro de CarregarDados
*==============================================================================
FUNCTION fStoM(par_nSegundos)
    IF VARTYPE(par_nSegundos) != "N" OR par_nSegundos = 0
        RETURN 0
    ENDIF
    RETURN INT(par_nSegundos / 60)
ENDFUNC

