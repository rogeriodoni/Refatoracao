# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 1253: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1270: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1287: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrRet.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3321 linhas total):

*-- Linhas 174 a 218:
174: 
175:         THIS.AddObject("cnt_4c_Sombra", "Container")
176:         WITH THIS.cnt_4c_Sombra
177:             .Top         = 0
178:             .Left        = 0
179:             .Width       = THIS.Width
180:             .Height      = 80
181:             .BackStyle   = 1
182:             .BackColor   = RGB(100, 100, 100)
183:             .BorderWidth = 0
184:             .Visible     = .T.
185:         ENDWITH
186: 
187:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
188:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
189:             .Top           = 18
190:             .Left          = 10
191:             .Width         = THIS.Width
192:             .Height        = 40
193:             .AutoSize      = .F.
194:             .Caption       = THIS.Caption
195:             .FontName      = "Tahoma"
196:             .FontSize      = 18
197:             .FontBold      = .T.
198:             .FontUnderline = .F.
199:             .WordWrap      = .T.
200:             .Alignment     = 0
201:             .BackStyle     = 0
202:             .ForeColor     = RGB(0, 0, 0)
203:             .Visible       = .T.
204:         ENDWITH
205: 
206:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
207:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
208:             .Top           = 17
209:             .Left          = 10
210:             .Width         = THIS.Width
211:             .Height        = 46
212:             .AutoSize      = .F.
213:             .Caption       = THIS.Caption
214:             .FontName      = "Tahoma"
215:             .FontSize      = 18
216:             .FontBold      = .T.
217:             .WordWrap      = .T.
218:             .Alignment     = 0

*-- Linhas 230 a 255:
230:     PROTECTED PROCEDURE ConfigurarFiltros()
231: 
232:         *-- ?? Empresa ??????????????????????????????????????????????????????????
233:         THIS.AddObject("lbl_4c_Empresa", "Label")
234:         WITH THIS.lbl_4c_Empresa
235:             .Caption   = "Empresa :"
236:             .Top       = 136
237:             .Left      = 248
238:             .Width     = 50
239:             .Height    = 15
240:             .AutoSize  = .T.
241:             .FontName  = "Tahoma"
242:             .FontSize  = 8
243:             .BackStyle = 0
244:             .ForeColor = RGB(90, 90, 90)
245:         ENDWITH
246: 
247:         THIS.AddObject("txt_4c_CdEmpresa", "TextBox")
248:         WITH THIS.txt_4c_CdEmpresa
249:             .Top           = 132
250:             .Left          = 303
251:             .Width         = 31
252:             .Height        = 23
253:             .FontName      = "Tahoma"
254:             .FontSize      = 9
255:             .Value         = ""

*-- Linhas 263 a 354:
263: 
264:         THIS.AddObject("txt_4c_DsEmpresa", "TextBox")
265:         WITH THIS.txt_4c_DsEmpresa
266:             .Top           = 132
267:             .Left          = 336
268:             .Width         = 290
269:             .Height        = 23
270:             .FontName      = "Tahoma"
271:             .Value         = ""
272:             .MaxLength     = 40
273:             .BorderStyle   = 1
274:             .SpecialEffect = 1
275:             .Format        = "K"
276:             .ForeColor     = RGB(0, 0, 0)
277:         ENDWITH
278: 
279:         *-- ?? Periodo ??????????????????????????????????????????????????????????
280:         THIS.AddObject("lbl_4c_Periodo", "Label")
281:         WITH THIS.lbl_4c_Periodo
282:             .Caption   = "Per" + CHR(237) + "odo :"
283:             .Top       = 111
284:             .Left      = 253
285:             .Height    = 15
286:             .AutoSize  = .T.
287:             .FontName  = "Tahoma"
288:             .FontSize  = 8
289:             .BackStyle = 0
290:             .ForeColor = RGB(90, 90, 90)
291:         ENDWITH
292: 
293:         THIS.AddObject("txt_4c_Datai", "TextBox")
294:         WITH THIS.txt_4c_Datai
295:             .Top           = 107
296:             .Left          = 303
297:             .Width         = 80
298:             .FontName      = "Tahoma"
299:             .Alignment     = 3
300:             .BorderStyle   = 1
301:             .Value         = {}
302:             .SpecialEffect = 1
303:             .ForeColor     = RGB(0, 0, 0)
304:             .Themes        = .T.
305:         ENDWITH
306: 
307:         THIS.AddObject("lbl_4c_Ate1", "Label")
308:         WITH THIS.lbl_4c_Ate1
309:             .Caption   = "at" + CHR(233)
310:             .Top       = 111
311:             .Left      = 388
312:             .Height    = 15
313:             .AutoSize  = .T.
314:             .FontName  = "Tahoma"
315:             .BackStyle = 0
316:         ENDWITH
317: 
318:         THIS.AddObject("txt_4c_Dataf", "TextBox")
319:         WITH THIS.txt_4c_Dataf
320:             .Top           = 107
321:             .Left          = 411
322:             .Width         = 80
323:             .FontName      = "Tahoma"
324:             .Alignment     = 3
325:             .BorderStyle   = 1
326:             .Value         = {}
327:             .SpecialEffect = 1
328:             .ForeColor     = RGB(0, 0, 0)
329:             .Themes        = .T.
330:         ENDWITH
331: 
332:         *-- ?? Operacao / Numero De-Ate / Industria ?????????????????????????????
333:         THIS.AddObject("lbl_4c_Operacao", "Label")
334:         WITH THIS.lbl_4c_Operacao
335:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
336:             .Top       = 162
337:             .Left      = 242
338:             .Height    = 15
339:             .AutoSize  = .T.
340:             .FontName  = "Tahoma"
341:             .FontSize  = 8
342:             .BackStyle = 0
343:             .ForeColor = RGB(90, 90, 90)
344:         ENDWITH
345: 
346:         THIS.AddObject("txt_4c_NmOperacao", "TextBox")
347:         WITH THIS.txt_4c_NmOperacao
348:             .Top           = 157
349:             .Left          = 303
350:             .Width         = 150
351:             .Height        = 25
352:             .FontName      = "Tahoma"
353:             .FontSize      = 9
354:             .Value         = ""

*-- Linhas 362 a 371:
362: 
363:         THIS.AddObject("txt_4c_Numero", "TextBox")
364:         WITH THIS.txt_4c_Numero
365:             .Top           = 157
366:             .Left          = 454
367:             .Width         = 55
368:             .Height        = 25
369:             .FontName      = "Tahoma"
370:             .Alignment     = 3
371:             .BorderStyle   = 1

*-- Linhas 377 a 399:
377:             .Themes        = .T.
378:         ENDWITH
379: 
380:         THIS.AddObject("lbl_4c_Ate2", "Label")
381:         WITH THIS.lbl_4c_Ate2
382:             .Caption   = "at" + CHR(233)
383:             .Top       = 162
384:             .Left      = 514
385:             .Height    = 15
386:             .AutoSize  = .T.
387:             .FontName  = "Tahoma"
388:             .BackStyle = 0
389:         ENDWITH
390: 
391:         THIS.AddObject("txt_4c_Numerof", "TextBox")
392:         WITH THIS.txt_4c_Numerof
393:             .Top           = 157
394:             .Left          = 536
395:             .Width         = 55
396:             .Height        = 25
397:             .FontName      = "Tahoma"
398:             .Alignment     = 3
399:             .BorderStyle   = 1

*-- Linhas 405 a 429:
405:             .Themes        = .T.
406:         ENDWITH
407: 
408:         THIS.AddObject("lbl_4c_Industria", "Label")
409:         WITH THIS.lbl_4c_Industria
410:             .Caption   = "Ind" + CHR(250) + "stria :"
411:             .Top       = 189
412:             .Left      = 246
413:             .Height    = 15
414:             .AutoSize  = .T.
415:             .FontName  = "Tahoma"
416:             .FontSize  = 8
417:             .BackStyle = 0
418:             .ForeColor = RGB(90, 90, 90)
419:         ENDWITH
420: 
421:         THIS.AddObject("txt_4c_NmIndustria", "TextBox")
422:         WITH THIS.txt_4c_NmIndustria
423:             .Top           = 184
424:             .Left          = 303
425:             .Width         = 150
426:             .Height        = 25
427:             .FontName      = "Tahoma"
428:             .FontSize      = 9
429:             .Value         = ""

*-- Linhas 444 a 654:
444:             .BorderStyle = 0
445:             .Value       = 2
446:             .Height      = 25
447:             .Left        = 606
448:             .Top         = 157
449:             .Width       = 200
450:             WITH .Buttons(1)
451:                 .Caption   = "Sim"
452:                 .Height    = 15
453:                 .Left      = 5
454:                 .Top       = 5
455:                 .Width     = 34
456:                 .AutoSize  = .T.
457:                 .BackStyle = 0
458:                 .ForeColor = RGB(90, 90, 90)
459:             ENDWITH
460:             WITH .Buttons(2)
461:                 .Caption   = "N" + CHR(227) + "o"
462:                 .Height    = 15
463:                 .Left      = 50
464:                 .Top       = 5
465:                 .Width     = 37
466:                 .AutoSize  = .T.
467:                 .BackStyle = 0
468:                 .FontName  = "Tahoma"
469:                 .FontSize  = 8
470:                 .ForeColor = RGB(90, 90, 90)
471:             ENDWITH
472:             WITH .Buttons(3)
473:                 .Caption   = "Ideal"
474:                 .Height    = 15
475:                 .Left      = 97
476:                 .Top       = 5
477:                 .Width     = 42
478:                 .AutoSize  = .T.
479:                 .BackStyle = 0
480:                 .FontName  = "Tahoma"
481:                 .FontSize  = 8
482:                 .ForeColor = RGB(90, 90, 90)
483:             ENDWITH
484:             WITH .Buttons(4)
485:                 .Caption   = "Atual"
486:                 .Height    = 15
487:                 .Left      = 152
488:                 .Top       = 5
489:                 .Width     = 43
490:                 .AutoSize  = .T.
491:                 .BackStyle = 0
492:                 .FontName  = "Tahoma"
493:                 .FontSize  = 8
494:                 .ForeColor = RGB(90, 90, 90)
495:             ENDWITH
496:         ENDWITH
497: 
498:         *-- ?? Codigo / Descricao Produto ???????????????????????????????????????
499:         THIS.AddObject("lbl_4c_Codigo", "Label")
500:         WITH THIS.lbl_4c_Codigo
501:             .Caption   = "C" + CHR(243) + "digo :"
502:             .Top       = 215
503:             .Left      = 256
504:             .Height    = 15
505:             .AutoSize  = .T.
506:             .FontName  = "Tahoma"
507:             .BackStyle = 0
508:             .ForeColor = RGB(90, 90, 90)
509:         ENDWITH
510: 
511:         THIS.AddObject("txt_4c_Cod", "TextBox")
512:         WITH THIS.txt_4c_Cod
513:             .Top           = 211
514:             .Left          = 303
515:             .Width         = 108
516:             .FontName      = "Tahoma"
517:             .Value         = ""
518:             .MaxLength     = 14
519:             .BorderStyle   = 1
520:             .SpecialEffect = 1
521:             .ForeColor     = RGB(0, 0, 0)
522:             .Themes        = .T.
523:         ENDWITH
524: 
525:         THIS.AddObject("txt_4c_Dcod", "TextBox")
526:         WITH THIS.txt_4c_Dcod
527:             .Top           = 211
528:             .Left          = 413
529:             .Width         = 290
530:             .FontName      = "Tahoma"
531:             .Value         = ""
532:             .BorderStyle   = 1
533:             .SpecialEffect = 1
534:             .ForeColor     = RGB(0, 0, 0)
535:             .Themes        = .T.
536:         ENDWITH
537: 
538:         *-- ?? Etiquetas (faixa de/ate e quantidade) ????????????????????????????
539:         THIS.AddObject("lbl_4c_Etiquetas", "Label")
540:         WITH THIS.lbl_4c_Etiquetas
541:             .Caption   = "Etiquetas :"
542:             .Top       = 240
543:             .Left      = 244
544:             .Height    = 15
545:             .AutoSize  = .T.
546:             .FontName  = "Tahoma"
547:             .BackStyle = 0
548:             .ForeColor = RGB(90, 90, 90)
549:         ENDWITH
550: 
551:         THIS.AddObject("txt_4c_Etii", "TextBox")
552:         WITH THIS.txt_4c_Etii
553:             .Top           = 236
554:             .Left          = 303
555:             .Width         = 108
556:             .FontName      = "Tahoma"
557:             .Alignment     = 3
558:             .BorderStyle   = 1
559:             .Value         = 0
560:             .SpecialEffect = 1
561:             .ForeColor     = RGB(0, 0, 0)
562:             .Themes        = .T.
563:         ENDWITH
564: 
565:         THIS.AddObject("lbl_4c_Ate3", "Label")
566:         WITH THIS.lbl_4c_Ate3
567:             .Caption   = "at" + CHR(233)
568:             .Top       = 240
569:             .Left      = 413
570:             .Height    = 15
571:             .AutoSize  = .T.
572:             .FontName  = "Tahoma"
573:             .BackStyle = 0
574:         ENDWITH
575: 
576:         THIS.AddObject("txt_4c_Etif", "TextBox")
577:         WITH THIS.txt_4c_Etif
578:             .Top           = 236
579:             .Left          = 436
580:             .Width         = 108
581:             .Height        = 23
582:             .FontName      = "Tahoma"
583:             .Alignment     = 3
584:             .BorderStyle   = 1
585:             .Value         = 0
586:             .SpecialEffect = 1
587:             .ForeColor     = RGB(0, 0, 0)
588:             .Themes        = .T.
589:         ENDWITH
590: 
591:         THIS.AddObject("lbl_4c_Ou", "Label")
592:         WITH THIS.lbl_4c_Ou
593:             .Caption   = "Ou"
594:             .Top       = 240
595:             .Left      = 547
596:             .Height    = 15
597:             .AutoSize  = .T.
598:             .FontName  = "Tahoma"
599:             .BackStyle = 0
600:         ENDWITH
601: 
602:         THIS.AddObject("txt_4c_QtdEti", "TextBox")
603:         WITH THIS.txt_4c_QtdEti
604:             .Top           = 236
605:             .Left          = 570
606:             .Width         = 60
607:             .Height        = 23
608:             .FontName      = "Tahoma"
609:             .BorderStyle   = 1
610:             .SpecialEffect = 1
611:             .InputMask     = "99999"
612:             .Value         = 0
613:             .MaxLength     = 5
614:             .ForeColor     = RGB(0, 0, 0)
615:             .Themes        = .T.
616:         ENDWITH
617: 
618:         THIS.AddObject("lbl_4c_EtqSufixo", "Label")
619:         WITH THIS.lbl_4c_EtqSufixo
620:             .Caption   = "Etiquetas"
621:             .Top       = 240
622:             .Left      = 636
623:             .Width     = 47
624:             .Height    = 15
625:             .AutoSize  = .T.
626:             .FontName  = "Tahoma"
627:             .FontSize  = 8
628:             .BackStyle = 0
629:             .ForeColor = RGB(90, 90, 90)
630:         ENDWITH
631: 
632:         *-- ?? Grupo Estoque ?????????????????????????????????????????????????????
633:         THIS.AddObject("lbl_4c_GrupoEstoque", "Label")
634:         WITH THIS.lbl_4c_GrupoEstoque
635:             .Caption   = "Grupo Estoque :"
636:             .Top       = 266
637:             .Left      = 218
638:             .Height    = 15
639:             .AutoSize  = .T.
640:             .FontName  = "Tahoma"
641:             .FontSize  = 8
642:             .BackStyle = 0
643:             .ForeColor = RGB(90, 90, 90)
644:         ENDWITH
645: 
646:         THIS.AddObject("txt_4c_CdGrEstoque", "TextBox")
647:         WITH THIS.txt_4c_CdGrEstoque
648:             .Top           = 261
649:             .Left          = 303
650:             .Width         = 80
651:             .Height        = 25
652:             .FontName      = "Tahoma"
653:             .Value         = ""
654:             .MaxLength     = 10

*-- Linhas 661 a 670:
661: 
662:         THIS.AddObject("txt_4c_DsGrEstoque", "TextBox")
663:         WITH THIS.txt_4c_DsGrEstoque
664:             .Top           = 261
665:             .Left          = 384
666:             .Width         = 290
667:             .Height        = 25
668:             .FontName      = "Tahoma"
669:             .Value         = ""
670:             .MaxLength     = 20

*-- Linhas 676 a 700:
676:         ENDWITH
677: 
678:         *-- ?? Estoque ???????????????????????????????????????????????????????????
679:         THIS.AddObject("lbl_4c_Estoque", "Label")
680:         WITH THIS.lbl_4c_Estoque
681:             .Caption   = "Estoque :"
682:             .Top       = 293
683:             .Left      = 250
684:             .Height    = 15
685:             .AutoSize  = .T.
686:             .FontName  = "Tahoma"
687:             .FontSize  = 8
688:             .BackStyle = 0
689:             .ForeColor = RGB(90, 90, 90)
690:         ENDWITH
691: 
692:         THIS.AddObject("txt_4c_CdEstoque", "TextBox")
693:         WITH THIS.txt_4c_CdEstoque
694:             .Top           = 288
695:             .Left          = 303
696:             .Width         = 80
697:             .Height        = 25
698:             .FontName      = "Tahoma"
699:             .FontSize      = 9
700:             .Value         = ""

*-- Linhas 708 a 717:
708: 
709:         THIS.AddObject("txt_4c_DsEstoque", "TextBox")
710:         WITH THIS.txt_4c_DsEstoque
711:             .Top           = 288
712:             .Left          = 384
713:             .Width         = 290
714:             .Height        = 25
715:             .FontName      = "Tahoma"
716:             .Value         = ""
717:             .MaxLength     = 40

*-- Linhas 723 a 776:
723:         ENDWITH
724: 
725:         *-- ?? Grande Grupo ??????????????????????????????????????????????????????
726:         THIS.AddObject("lbl_4c_GrandeGrupo", "Label")
727:         WITH THIS.lbl_4c_GrandeGrupo
728:             .Caption   = "Grande Grupo :"
729:             .Top       = 319
730:             .Left      = 222
731:             .Width     = 76
732:             .Height    = 15
733:             .FontName  = "Tahoma"
734:             .FontSize  = 8
735:             .BackStyle = 0
736:             .ForeColor = RGB(90, 90, 90)
737:         ENDWITH
738: 
739:         THIS.AddObject("txt_4c_GdeGrupo", "TextBox")
740:         WITH THIS.txt_4c_GdeGrupo
741:             .Top           = 315
742:             .Left          = 303
743:             .Width         = 31
744:             .Height        = 23
745:             .FontName      = "Tahoma"
746:             .Value         = ""
747:             .MaxLength     = 3
748:             .BorderStyle   = 1
749:             .SpecialEffect = 1
750:             .ForeColor     = RGB(0, 0, 0)
751:             .Themes        = .T.
752:         ENDWITH
753: 
754:         *-- ?? Grupo Produto ?????????????????????????????????????????????????????
755:         THIS.AddObject("lbl_4c_GrupoProduto", "Label")
756:         WITH THIS.lbl_4c_GrupoProduto
757:             .Caption   = "Grupo Produto :"
758:             .Top       = 344
759:             .Left      = 219
760:             .Width     = 79
761:             .Height    = 15
762:             .FontName  = "Tahoma"
763:             .FontSize  = 8
764:             .BackStyle = 0
765:             .ForeColor = RGB(90, 90, 90)
766:         ENDWITH
767: 
768:         THIS.AddObject("txt_4c_Cgru", "TextBox")
769:         WITH THIS.txt_4c_Cgru
770:             .Top           = 340
771:             .Left          = 303
772:             .Width         = 31
773:             .Height        = 23
774:             .FontName      = "Tahoma"
775:             .Value         = ""
776:             .MaxLength     = 3

*-- Linhas 782 a 821:
782: 
783:         THIS.AddObject("txt_4c_Dgru", "TextBox")
784:         WITH THIS.txt_4c_Dgru
785:             .Top           = 340
786:             .Left          = 336
787:             .Width         = 171
788:             .Height        = 23
789:             .FontName      = "Tahoma"
790:             .Value         = ""
791:             .MaxLength     = 20
792:             .BorderStyle   = 1
793:             .SpecialEffect = 1
794:             .ForeColor     = RGB(0, 0, 0)
795:             .Themes        = .T.
796:         ENDWITH
797: 
798:         *-- ?? Subgrupo Produto ??????????????????????????????????????????????????
799:         THIS.AddObject("lbl_4c_Subgrupo", "Label")
800:         WITH THIS.lbl_4c_Subgrupo
801:             .Caption   = "Subgrupo Produto :"
802:             .Top       = 370
803:             .Left      = 202
804:             .Width     = 96
805:             .Height    = 15
806:             .AutoSize  = .T.
807:             .FontName  = "Tahoma"
808:             .FontSize  = 8
809:             .BackStyle = 0
810:             .ForeColor = RGB(90, 90, 90)
811:         ENDWITH
812: 
813:         THIS.AddObject("txt_4c_CSGru", "TextBox")
814:         WITH THIS.txt_4c_CSGru
815:             .Top           = 366
816:             .Left          = 303
817:             .Width         = 80
818:             .Height        = 21
819:             .FontName      = "Tahoma"
820:             .FontSize      = 9
821:             .Value         = ""

*-- Linhas 829 a 867:
829: 
830:         THIS.AddObject("txt_4c_DSGru", "TextBox")
831:         WITH THIS.txt_4c_DSGru
832:             .Top           = 366
833:             .Left          = 385
834:             .Width         = 156
835:             .Height        = 21
836:             .FontName      = "Tahoma"
837:             .Value         = ""
838:             .MaxLength     = 20
839:             .BorderStyle   = 1
840:             .SpecialEffect = 1
841:             .Format        = "K"
842:             .ForeColor     = RGB(0, 0, 0)
843:         ENDWITH
844: 
845:         *-- ?? Grupo Venda / Colecao ?????????????????????????????????????????????
846:         THIS.AddObject("lbl_4c_GrupoVenda", "Label")
847:         WITH THIS.lbl_4c_GrupoVenda
848:             .Caption   = "Grupo Venda :"
849:             .Top       = 394
850:             .Left      = 227
851:             .Width     = 71
852:             .Height    = 15
853:             .FontName  = "Tahoma"
854:             .FontSize  = 8
855:             .BackStyle = 0
856:             .ForeColor = RGB(90, 90, 90)
857:         ENDWITH
858: 
859:         THIS.AddObject("txt_4c_Col", "TextBox")
860:         WITH THIS.txt_4c_Col
861:             .Top           = 390
862:             .Left          = 303
863:             .Width         = 80
864:             .Height        = 23
865:             .FontName      = "Tahoma"
866:             .Value         = ""
867:             .BorderStyle   = 1

*-- Linhas 873 a 911:
873: 
874:         THIS.AddObject("txt_4c_DCol", "TextBox")
875:         WITH THIS.txt_4c_DCol
876:             .Top           = 390
877:             .Left          = 385
878:             .Width         = 255
879:             .Height        = 23
880:             .FontName      = "Tahoma"
881:             .Value         = ""
882:             .BorderStyle   = 1
883:             .SpecialEffect = 1
884:             .Format        = "K"
885:             .ForeColor     = RGB(0, 0, 0)
886:             .Themes        = .T.
887:         ENDWITH
888: 
889:         *-- ?? Linha ?????????????????????????????????????????????????????????????
890:         THIS.AddObject("lbl_4c_Linha", "Label")
891:         WITH THIS.lbl_4c_Linha
892:             .Caption   = "Linha :"
893:             .Top       = 419
894:             .Left      = 264
895:             .Width     = 34
896:             .Height    = 15
897:             .FontName  = "Tahoma"
898:             .FontSize  = 8
899:             .BackStyle = 0
900:             .ForeColor = RGB(90, 90, 90)
901:         ENDWITH
902: 
903:         THIS.AddObject("txt_4c_Lin", "TextBox")
904:         WITH THIS.txt_4c_Lin
905:             .Top           = 415
906:             .Left          = 303
907:             .Width         = 80
908:             .Height        = 23
909:             .FontName      = "Tahoma"
910:             .Value         = ""
911:             .MaxLength     = 10

*-- Linhas 917 a 999:
917:         ENDWITH
918: 
919:         *-- ?? Local do Produto ??????????????????????????????????????????????????
920:         THIS.AddObject("lbl_4c_LocalProduto", "Label")
921:         WITH THIS.lbl_4c_LocalProduto
922:             .Caption   = "Local do Produto :"
923:             .Top       = 444
924:             .Left      = 209
925:             .Width     = 89
926:             .Height    = 15
927:             .FontName  = "Tahoma"
928:             .FontSize  = 8
929:             .BackStyle = 0
930:             .ForeColor = RGB(90, 90, 90)
931:         ENDWITH
932: 
933:         THIS.AddObject("txt_4c_Local", "TextBox")
934:         WITH THIS.txt_4c_Local
935:             .Top           = 440
936:             .Left          = 303
937:             .Width         = 80
938:             .Height        = 23
939:             .FontName      = "Tahoma"
940:             .Value         = ""
941:             .MaxLength     = 10
942:             .BorderStyle   = 1
943:             .SpecialEffect = 1
944:             .ForeColor     = RGB(0, 0, 0)
945:             .Themes        = .T.
946:         ENDWITH
947: 
948:         *-- ?? Local da Etiqueta ?????????????????????????????????????????????????
949:         THIS.AddObject("lbl_4c_LocalEtq", "Label")
950:         WITH THIS.lbl_4c_LocalEtq
951:             .Caption   = "Local da Etiqueta :"
952:             .Top       = 469
953:             .Left      = 207
954:             .Width     = 91
955:             .Height    = 15
956:             .FontName  = "Tahoma"
957:             .FontSize  = 8
958:             .BackStyle = 0
959:             .ForeColor = RGB(90, 90, 90)
960:         ENDWITH
961: 
962:         THIS.AddObject("txt_4c_Localizas", "TextBox")
963:         WITH THIS.txt_4c_Localizas
964:             .Top           = 465
965:             .Left          = 303
966:             .Width         = 80
967:             .Height        = 23
968:             .FontName      = "Tahoma"
969:             .Value         = ""
970:             .MaxLength     = 10
971:             .BorderStyle   = 1
972:             .SpecialEffect = 1
973:             .ForeColor     = RGB(0, 0, 0)
974:             .Themes        = .T.
975:         ENDWITH
976: 
977:         *-- ?? Promocao ??????????????????????????????????????????????????????????
978:         THIS.AddObject("lbl_4c_Promocao", "Label")
979:         WITH THIS.lbl_4c_Promocao
980:             .Caption   = "Promo" + CHR(231) + CHR(227) + "o :"
981:             .Top       = 494
982:             .Left      = 242
983:             .Height    = 15
984:             .AutoSize  = .T.
985:             .FontName  = "Tahoma"
986:             .FontSize  = 8
987:             .BackStyle = 0
988:             .ForeColor = RGB(90, 90, 90)
989:         ENDWITH
990: 
991:         THIS.AddObject("txt_4c_Promos", "TextBox")
992:         WITH THIS.txt_4c_Promos
993:             .Top           = 490
994:             .Left          = 303
995:             .Width         = 185
996:             .Height        = 23
997:             .FontName      = "Tahoma"
998:             .FontSize      = 9
999:             .Value         = ""

*-- Linhas 1007 a 1019:
1007:         ENDWITH
1008: 
1009:         *-- ?? Ordem (OptionGroup 5 botoes) ?????????????????????????????????????
1010:         THIS.AddObject("lbl_4c_Ordem", "Label")
1011:         WITH THIS.lbl_4c_Ordem
1012:             .Caption   = "Ordem :"
1013:             .Top       = 516
1014:             .Left      = 257
1015:             .Height    = 15
1016:             .AutoSize  = .T.
1017:             .FontName  = "Tahoma"
1018:             .FontSize  = 8
1019:             .BackStyle = 0

*-- Linhas 1027 a 1099:
1027:             .BorderStyle = 0
1028:             .Value       = 1
1029:             .Height      = 20
1030:             .Left        = 297
1031:             .Top         = 513
1032:             .Width       = 513
1033:             WITH .Buttons(1)
1034:                 .Caption   = "Produto"
1035:                 .Height    = 15
1036:                 .Left      = 5
1037:                 .Top       = 2
1038:                 .Width     = 63
1039:                 .BackStyle = 0
1040:                 .ForeColor = RGB(90, 90, 90)
1041:             ENDWITH
1042:             WITH .Buttons(2)
1043:                 .Caption   = "Etiqueta"
1044:                 .Height    = 15
1045:                 .Left      = 71
1046:                 .Top       = 2
1047:                 .Width     = 65
1048:                 .BackStyle = 0
1049:                 .FontName  = "Tahoma"
1050:                 .FontSize  = 8
1051:                 .ForeColor = RGB(90, 90, 90)
1052:             ENDWITH
1053:             WITH .Buttons(3)
1054:                 .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1055:                 .Height    = 15
1056:                 .Left      = 141
1057:                 .Top       = 2
1058:                 .Width     = 74
1059:                 .BackStyle = 0
1060:                 .FontName  = "Tahoma"
1061:                 .FontSize  = 8
1062:                 .ForeColor = RGB(90, 90, 90)
1063:             ENDWITH
1064:             WITH .Buttons(4)
1065:                 .Caption   = "Referencia Fornecedor"
1066:                 .Height    = 15
1067:                 .Left      = 220
1068:                 .Top       = 2
1069:                 .Width     = 148
1070:                 .BackStyle = 0
1071:                 .FontName  = "Tahoma"
1072:                 .FontSize  = 8
1073:                 .ForeColor = RGB(90, 90, 90)
1074:             ENDWITH
1075:             WITH .Buttons(5)
1076:                 .Caption   = "Categoria + Grupo"
1077:                 .Height    = 15
1078:                 .Left      = 377
1079:                 .Top       = 2
1080:                 .Width     = 108
1081:                 .AutoSize  = .T.
1082:                 .BackStyle = 0
1083:                 .FontName  = "Tahoma"
1084:                 .FontSize  = 8
1085:                 .ForeColor = RGB(90, 90, 90)
1086:             ENDWITH
1087:         ENDWITH
1088: 
1089:         *-- ?? Marca (OptionGroup 2 botoes: Sim/Nao) ?????????????????????????????
1090:         THIS.AddObject("lbl_4c_Marca", "Label")
1091:         WITH THIS.lbl_4c_Marca
1092:             .Caption   = "Marca :"
1093:             .Top       = 536
1094:             .Left      = 260
1095:             .Height    = 15
1096:             .AutoSize  = .T.
1097:             .FontName  = "Tahoma"
1098:             .FontSize  = 8
1099:             .BackStyle = 0

*-- Linhas 1108 a 1132:
1108:             .BorderStyle = 0
1109:             .Value       = 1
1110:             .Height      = 27
1111:             .Left        = 297
1112:             .Top         = 531
1113:             .Width       = 118
1114:             WITH .Buttons(1)
1115:                 .Caption   = "Sim"
1116:                 .Height    = 17
1117:                 .Left      = 5
1118:                 .Top       = 5
1119:                 .Width     = 42
1120:                 .BackStyle = 0
1121:                 .ForeColor = RGB(90, 90, 90)
1122:             ENDWITH
1123:             WITH .Buttons(2)
1124:                 .Caption   = "N" + CHR(227) + "o"
1125:                 .Height    = 17
1126:                 .Left      = 71
1127:                 .Top       = 5
1128:                 .Width     = 42
1129:                 .BackStyle = 0
1130:                 .FontName  = "Tahoma"
1131:                 .FontSize  = 8
1132:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1143 a 1151:
1143:     * O equivalente logico de "Page1 = Lista" aqui eh o painel de filtros + o
1144:     * CommandGroup de acoes, ambos criados diretamente sobre o form.
1145:     *
1146:     * Delega para ConfigurarFiltros() (todos os txt_4c_*/lbl_4c_* de filtro,
1147:     * OptionGroups Ordem/Marca/Chk_Preco) e ConfigurarBotoes() (obj_4c_Sair
1148:     * com 4 CommandButtons: Consulta, Arquivadas, Digitacao, Encerrar).
1149:     *==========================================================================
1150:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1151:         THIS.ConfigurarFiltros()

*-- Linhas 1222 a 1297:
1222:             .BorderStyle   = 0
1223:             .Value         = 1
1224:             .Height        = 85
1225:             .Left          = 689
1226:             .SpecialEffect = 1
1227:             .Top           = -2
1228:             .Width         = 313
1229:             .Themes        = .F.
1230:             WITH .Buttons(1)
1231:                 .AutoSize   = .F.
1232:                 .Top        = 5
1233:                 .Left       = 5
1234:                 .Height     = 75
1235:                 .Width      = 75
1236:                 .FontBold   = .T.
1237:                 .FontItalic = .T.
1238:                 .WordWrap   = .T.
1239:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
1240:                 .Caption    = "\<Consulta"
1241:                 .ForeColor  = RGB(90, 90, 90)
1242:                 .BackColor  = RGB(255, 255, 255)
1243:                 .Themes     = .F.
1244:             ENDWITH
1245:             WITH .Buttons(2)
1246:                 .AutoSize   = .F.
1247:                 .Top        = 5
1248:                 .Left       = 81
1249:                 .Height     = 75
1250:                 .Width      = 75
1251:                 .FontBold   = .T.
1252:                 .FontItalic = .T.
1253:                 .FontName   = "Comic Sans MS"
1254:                 .FontSize   = 8
1255:                 .WordWrap   = .T.
1256:                 .Picture    = gc_4c_CaminhoIcones + "geral_disco_60.jpg"
1257:                 .Caption    = "\<Arquivadas"
1258:                 .ForeColor  = RGB(90, 90, 90)
1259:                 .BackColor  = RGB(255, 255, 255)
1260:                 .Themes     = .F.
1261:             ENDWITH
1262:             WITH .Buttons(3)
1263:                 .AutoSize   = .F.
1264:                 .Top        = 5
1265:                 .Left       = 157
1266:                 .Height     = 75
1267:                 .Width      = 75
1268:                 .FontBold   = .T.
1269:                 .FontItalic = .T.
1270:                 .FontName   = "Comic Sans MS"
1271:                 .FontSize   = 8
1272:                 .WordWrap   = .T.
1273:                 .Picture    = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
1274:                 .Caption    = "\<Digita" + CHR(231) + CHR(227) + "o"
1275:                 .ForeColor  = RGB(90, 90, 90)
1276:                 .BackColor  = RGB(255, 255, 255)
1277:                 .Themes     = .F.
1278:             ENDWITH
1279:             WITH .Buttons(4)
1280:                 .AutoSize   = .F.
1281:                 .Top        = 5
1282:                 .Left       = 233
1283:                 .Height     = 75
1284:                 .Width      = 75
1285:                 .FontBold   = .T.
1286:                 .FontItalic = .T.
1287:                 .FontName   = "Comic Sans MS"
1288:                 .FontSize   = 8
1289:                 .WordWrap   = .T.
1290:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1291:                 .Cancel     = .T.
1292:                 .Caption    = "Encerrar"
1293:                 .ForeColor  = RGB(90, 90, 90)
1294:                 .BackColor  = RGB(255, 255, 255)
1295:                 .Themes     = .F.
1296:             ENDWITH
1297:         ENDWITH


### BO (C:\4c\projeto\app\classes\SigPrRetBO.prg):
*==============================================================================
* SigPrRetBO.PRG
* Business Object - Operacional: Retorno de Estoque (Etiquetas)
*
* Herda de BusinessBase
* Form de filtros que abre SigOpIpE com variaveis PRIVATE.
* Sem CRUD - armazena parametros de filtro para consulta/digitacao/arquivadas.
*==============================================================================

DEFINE CLASS SigPrRetBO AS BusinessBase

    *-- Sem tabela primaria (form operacional de filtros)
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Empresa
    this_cCdEmpresa   = ""
    this_cDsEmpresa   = ""

    *-- Periodo
    this_dDtInicial   = {}
    this_dDtFinal     = {}

    *-- Operacao / Industria / Numero NF
    this_cNmOperacao  = ""
    this_cNmIndustria = ""
    this_nNumero      = 0
    this_nNumerof     = 0

    *-- Produto (SigCdPro: CPros / DPros)
    this_cCodProduto  = ""
    this_cDsProduto   = ""

    *-- Etiqueta (SigOpEtq: CBars n(14))
    this_nEtiqIni     = 0
    this_nEtiqFim     = 0
    this_nQtdEti      = 0

    *-- Grupo Estoque / Estoque
    this_cCdGrEstoque = ""
    this_cDsGrEstoque = ""
    this_cCdEstoque   = ""
    this_cDsEstoque   = ""

    *-- Grande Grupo (SigCdGpr: Codigos char(3))
    this_cGdeGrupo    = ""

    *-- Grupo Produto (SigCdGrp: CGrus char(3) / DGrus char(20))
    this_cCgru        = ""
    this_cDgru        = ""

    *-- Sub-Grupo (SigCdPsg: Codigos char(6) / Descricaos char(20))
    this_cCSGru       = ""
    this_cDSGru       = ""

    *-- Grupo Venda / Colecao (SigCdCol: Colecoes / Descs)
    this_cCol         = ""
    this_cDCol        = ""

    *-- Linha (SigCdLin: linhas char(10))
    this_cLin         = ""

    *-- Local do Produto (SigPrLcl: Codigos char(10))
    this_cLocal       = ""

    *-- Local da Etiqueta (SigPrLcl: Codigos char(10))
    this_cLocalizas   = ""

    *-- Promocao (SigPrPmc: promos char(25))
    this_cPromos      = ""

    *-- Opcoes de impressao / ordenacao
    this_nOrdem       = 1
    this_nOptMarcas   = 1
    this_nChkPreco    = 2

    *-- Controle interno
    this_cTipo        = ""
    this_cOpEscolha   = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional sem tabela primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega this_* a partir de cursor com parametros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCdEmpresa   = TratarNulo(CdEmpresa,   "C")
                THIS.this_cDsEmpresa   = TratarNulo(DsEmpresa,   "C")
                THIS.this_dDtInicial   = TratarNulo(DtInicial,   "D")
                THIS.this_dDtFinal     = TratarNulo(DtFinal,     "D")
                THIS.this_cNmOperacao  = TratarNulo(NmOperacao,  "C")
                THIS.this_cNmIndustria = TratarNulo(NmIndustria, "C")
                THIS.this_nNumero      = TratarNulo(Numero,      "N")
                THIS.this_nNumerof     = TratarNulo(Numerof,     "N")
                THIS.this_cCodProduto  = TratarNulo(CPros,       "C")
                THIS.this_cDsProduto   = TratarNulo(DPros,       "C")
                THIS.this_nEtiqIni     = TratarNulo(EtiqIni,     "N")
                THIS.this_nEtiqFim     = TratarNulo(EtiqFim,     "N")
                THIS.this_nQtdEti      = TratarNulo(QtdEti,      "N")
                THIS.this_cCdGrEstoque = TratarNulo(CdGrEstoque, "C")
                THIS.this_cDsGrEstoque = TratarNulo(DsGrEstoque, "C")
                THIS.this_cCdEstoque   = TratarNulo(CdEstoque,   "C")
                THIS.this_cDsEstoque   = TratarNulo(DsEstoque,   "C")
                THIS.this_cGdeGrupo    = TratarNulo(GdeGrupo,    "C")
                THIS.this_cCgru        = TratarNulo(CGrus,       "C")
                THIS.this_cDgru        = TratarNulo(DGrus,       "C")
                THIS.this_cCSGru       = TratarNulo(CSGru,       "C")
                THIS.this_cDSGru       = TratarNulo(DSGru,       "C")
                THIS.this_cCol         = TratarNulo(Colecoes,    "C")
                THIS.this_cDCol        = TratarNulo(Descs,       "C")
                THIS.this_cLin         = TratarNulo(Linhas,      "C")
                THIS.this_cLocal       = TratarNulo(CdLocal,     "C")
                THIS.this_cLocalizas   = TratarNulo(Localizas,   "C")
                THIS.this_cPromos      = TratarNulo(Promos,      "C")
                THIS.this_nOrdem       = TratarNulo(Ordem,       "N")
                THIS.this_nOptMarcas   = TratarNulo(OptMarcas,   "N")
                THIS.this_nChkPreco    = TratarNulo(ChkPreco,    "N")
                THIS.this_cTipo        = TratarNulo(Tipo,        "C")
                THIS.this_cOpEscolha   = TratarNulo(OpEscolha,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Carrega SigCdOpd para lookup de operacoes por SEEK
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("SigCdOpd")
                USE IN SigCdOpd
            ENDIF
            loc_cSQL = "SELECT a.* FROM SigCdOpd a"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "SigCdOpd") > 0
                SELECT SigCdOpd
                INDEX ON dopps TAG dopps
                SET ORDER TO
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar cursores")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEtiqueta - Resolve CBars via SigOpEtq + SigOpEta (renomeadas)
    * Retorna 0 se invalido, ou o CBars resolvido se encontrado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEtiqueta(par_nCBars)
        LOCAL loc_nResultado, loc_cSQL, loc_oErro, loc_lcCBars
        loc_nResultado = 0
        TRY
            loc_lcCBars = ALLTRIM(STR(par_nCBars, 14))
            loc_cSQL = "SELECT a.CPros, a.CBars " + ;
                       "FROM SigOpEtq a " + ;
                       "LEFT JOIN SigOpEta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
                       "WHERE (a.CBars = " + loc_lcCBars + ;
                       " OR b.cbars_old = " + loc_lcCBars + ")"
            IF USED("cursor_4c_EtiqTemp")
                USE IN cursor_4c_EtiqTemp
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtiqTemp") > 0
                SELECT cursor_4c_EtiqTemp
                GO TOP
                IF !EOF("cursor_4c_EtiqTemp")
                    loc_nResultado = cursor_4c_EtiqTemp.CBars
                ENDIF
                USE IN cursor_4c_EtiqTemp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar etiqueta")
        ENDTRY
        RETURN loc_nResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarEtiquetaCadastrada - Confirma existencia de CBars em SigOpEtq
    *--------------------------------------------------------------------------
    PROCEDURE VerificarEtiquetaCadastrada(par_nCBars)
        LOCAL loc_lExiste, loc_cSQL, loc_oErro
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 CBars FROM SigOpEtq " + ;
                       "WHERE CBars = " + ALLTRIM(STR(par_nCBars, 14))
            IF USED("cursor_4c_EtiqCheck")
                USE IN cursor_4c_EtiqCheck
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtiqCheck") > 0
                SELECT cursor_4c_EtiqCheck
                loc_lExiste = !EOF("cursor_4c_EtiqCheck")
                USE IN cursor_4c_EtiqCheck
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar etiqueta")
        ENDTRY
        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Form OPERACIONAL de filtros sem persistencia em tabela propria.
    * Valida parametros minimos e registra auditoria da operacao (Consulta/Impressao).
    * Nao ha INSERT em base porque o legado usa SigOpIpE via variaveis PRIVATE
    * e a acao efetiva do form eh disparar consulta/impressao para SigCdPro/SigOpEtq.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF
            THIS.RegistrarAuditoria("CONSULTA_ETIQUETA")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar filtros de estoque")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Form OPERACIONAL: re-executa consulta com filtros atualizados.
    * Nao ha UPDATE em base porque nao existe tabela primaria (form de filtros).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF
            THIS.RegistrarAuditoria("REEXECUCAO_FILTRO")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar filtros de estoque")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Verifica coerencia minima dos filtros do form operacional.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF !EMPTY(THIS.this_dDtInicial) AND !EMPTY(THIS.this_dDtFinal)
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
                MsgAviso("Data Final deve ser maior ou igual a Data Inicial.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF
        IF loc_lValido AND THIS.this_nEtiqIni > 0 AND THIS.this_nEtiqFim > 0
            IF THIS.this_nEtiqFim < THIS.this_nEtiqIni
                MsgAviso("Etiqueta Final deve ser maior ou igual a Etiqueta Inicial.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF
        IF loc_lValido AND !EMPTY(THIS.this_nNumero) AND !EMPTY(THIS.this_nNumerof)
            IF THIS.this_nNumerof < THIS.this_nNumero
                MsgAviso("N" + CHR(250) + "mero Final deve ser maior ou igual ao N" + CHR(250) + "mero Inicial.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava operacao do form em LogAuditoria (SQL Server).
    * Como nao ha chave primaria, usa hash textual dos filtros como identificador.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cDetalhe, loc_oErro
        TRY
            loc_cDetalhe = "Emp=" + ALLTRIM(THIS.this_cCdEmpresa) + ;
                           " Prod=" + ALLTRIM(THIS.this_cCodProduto) + ;
                           " Grp=" + ALLTRIM(THIS.this_cCgru) + ;
                           " Est=" + ALLTRIM(THIS.this_cCdEstoque) + ;
                           " DtI=" + DTOC(THIS.this_dDtInicial) + ;
                           " DtF=" + DTOC(THIS.this_dDtFinal) + ;
                           " EtqI=" + ALLTRIM(STR(THIS.this_nEtiqIni, 14)) + ;
                           " EtqF=" + ALLTRIM(STR(THIS.this_nEtiqFim, 14))
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, DataHora, Tabela, ChavePrimaria, Operacao, Detalhes) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL("SigPrRet") + ", " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(LEFT(loc_cDetalhe, 500)) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao registrar auditoria")
        ENDTRY
    ENDPROC

ENDDEFINE

