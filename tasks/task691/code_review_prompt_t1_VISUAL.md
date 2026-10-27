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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCGF.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (5888 linhas total):

*-- Linhas 146 a 170:
146:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
147: 
148:         WITH THIS.pgf_4c_Paginas
149:             .Top       = 0
150:             .Left      = 0
151:             .Width     = THIS.Width
152:             .Height    = THIS.Height
153:             .PageCount = 2
154:             .Tabs      = .F.
155:             .Visible   = .F.
156: 
157:             .Page1.Caption   = "Filtros"
158:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
159:             .Page1.FontName  = "Verdana"
160:             .Page1.FontSize  = 8
161:             .Page1.FontBold  = .T.
162:             .Page1.BackColor = RGB(255, 255, 255)
163:             .Page1.ForeColor = RGB(36, 84, 155)
164: 
165:             .Page2.Caption   = "Dados"
166:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
167:             .Page2.FontName  = "Verdana"
168:             .Page2.FontSize  = 8
169:             .Page2.FontBold  = .T.
170:             .Page2.BackColor = RGB(255, 255, 255)

*-- Linhas 269 a 366:
269:     * de navegacao (cmgFiltros: Consultar/Sair). SCX: Top=-3,Left=835,W=173,
270:     * H=110, Buttons 75x75 (Comic Sans MS), icones cadastro_procurar_60.jpg /
271:     * cadastro_sair_60.jpg.
272:     *--------------------------------------------------------------------------
273:     PROTECTED PROCEDURE ConfigurarCabecalhoFiltros(par_oPag)
274:         par_oPag.AddObject("cnt_4c_Sombra", "Container")
275:         WITH par_oPag.cnt_4c_Sombra
276:             .Top         = 0
277:             .Left        = 0
278:             .Width       = THIS.Width
279:             .Height      = 80
280:             .BackColor   = RGB(100, 100, 100)
281:             .BorderWidth = 0
282: 
283:             .AddObject("lbl_4c_Sombra", "Label")
284:             WITH .lbl_4c_Sombra
285:                 .Top       = 25
286:                 .Left      = 10
287:                 .Width     = THIS.Width
288:                 .Height    = 40
289:                 .AutoSize  = .F.
290:                 .BackStyle = 0
291:                 .WordWrap  = .T.
292:                 .FontName  = "Tahoma"
293:                 .FontSize  = 18
294:                 .FontBold  = .T.
295:                 .ForeColor = RGB(0, 0, 0)
296:                 .Caption   = THIS.Caption
297:                 .Visible   = .T.
298:             ENDWITH
299: 
300:             .AddObject("lbl_4c_TituloCabecalho", "Label")
301:             WITH .lbl_4c_TituloCabecalho
302:                 .Top       = 24
303:                 .Left      = 10
304:                 .Width     = THIS.Width
305:                 .Height    = 46
306:                 .AutoSize  = .F.
307:                 .BackStyle = 0
308:                 .WordWrap  = .T.
309:                 .FontName  = "Tahoma"
310:                 .FontSize  = 18
311:                 .FontBold  = .T.
312:                 .ForeColor = RGB(255, 255, 255)
313:                 .Caption   = THIS.Caption
314:                 .Visible   = .T.
315:             ENDWITH
316: 
317:             .Visible = .T.
318:         ENDWITH
319: 
320:         par_oPag.AddObject("cmg_4c_Filtros", "CommandGroup")
321:         WITH par_oPag.cmg_4c_Filtros
322:             .Top           = -3
323:             .Left          = 835
324:             .Width         = 173
325:             .Height        = 110
326:             .ButtonCount   = 2
327:             .BackStyle     = 0
328:             .BorderStyle   = 0
329:             .SpecialEffect = 1
330:             .BorderColor   = RGB(136, 189, 188)
331:             .Themes        = .F.
332: 
333:             WITH .Buttons(1)
334:                 .Top         = 5
335:                 .Left        = 11
336:                 .Width       = 75
337:                 .Height      = 75
338:                 .FontName    = "Comic Sans MS"
339:                 .FontSize    = 8
340:                 .FontBold    = .T.
341:                 .FontItalic  = .T.
342:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
343:                 .Caption     = "\<Consultar"
344:                 .ToolTipText = "Consultar Usando os Filtros Informados"
345:                 .ForeColor   = RGB(90, 90, 90)
346:                 .BackColor   = RGB(255, 255, 255)
347:                 .Themes      = .F.
348:             ENDWITH
349: 
350:             WITH .Buttons(2)
351:                 .Top         = 5
352:                 .Left        = 87
353:                 .Width       = 75
354:                 .Height      = 75
355:                 .FontName    = "Comic Sans MS"
356:                 .FontSize    = 8
357:                 .FontBold    = .T.
358:                 .FontItalic  = .T.
359:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
360:                 .Cancel      = .T.
361:                 .Caption     = "\<Sair"
362:                 .ToolTipText = "[ESC] Sair"
363:                 .ForeColor   = RGB(90, 90, 90)
364:                 .BackColor   = RGB(255, 255, 255)
365:                 .Themes      = .F.
366:             ENDWITH

*-- Linhas 372 a 726:
372:     ENDPROC
373: 
374:     *--------------------------------------------------------------------------
375:     * ConfigurarCamposFiltros - Labels + TextBoxes/CheckBoxes de filtro (datas,
376:     * titulo, titulo banco, especie NF, NF, moedas, saldo, publicidade,
377:     * empresa, filtro nomeado). Geometria e Format/InputMask transcritos do
378:     * dump do SCX legado.
379:     *--------------------------------------------------------------------------
380:     PROTECTED PROCEDURE ConfigurarCamposFiltros(par_oPag)
381:         LOCAL loc_cAte
382:         loc_cAte = "at" + CHR(233)
383: 
384:         *-- Emissao
385:         par_oPag.AddObject("lbl_4c_SayPed", "Label")
386:         WITH par_oPag.lbl_4c_SayPed
387:             .Top = 132
388:             .Left = 139
389:             .Width = 47
390:             .FontName = "Tahoma"
391:             .FontSize = 8
392:             .ForeColor = RGB(90, 90, 90)
393:             .Caption = "Emiss" + CHR(227) + "o :"
394:             .Visible = .T.
395:         ENDWITH
396: 
397:         par_oPag.AddObject("txt_4c_DtEmiI", "TextBox")
398:         WITH par_oPag.txt_4c_DtEmiI
399:             .Top = 128
400:             .Left = 190
401:             .Width = 80
402:             .Height = 23
403:             .Alignment = 3
404:             .Value = {}
405:             .FontName = "Tahoma"
406:             .SpecialEffect = 1
407:             .Visible = .T.
408:         ENDWITH
409: 
410:         par_oPag.AddObject("lbl_4c_Label2", "Label")
411:         WITH par_oPag.lbl_4c_Label2
412:             .Top = 132
413:             .Left = 275
414:             .Width = 18
415:             .FontName = "Tahoma"
416:             .FontSize = 8
417:             .BackStyle = 0
418:             .ForeColor = RGB(90, 90, 90)
419:             .Caption = loc_cAte
420:             .Visible = .T.
421:         ENDWITH
422: 
423:         par_oPag.AddObject("txt_4c_DtEmiF", "TextBox")
424:         WITH par_oPag.txt_4c_DtEmiF
425:             .Top = 129
426:             .Left = 299
427:             .Width = 80
428:             .Height = 23
429:             .Alignment = 3
430:             .Value = {}
431:             .FontName = "Tahoma"
432:             .SpecialEffect = 1
433:             .Visible = .T.
434:         ENDWITH
435: 
436:         *-- Vencimento
437:         par_oPag.AddObject("lbl_4c_Say1", "Label")
438:         WITH par_oPag.lbl_4c_Say1
439:             .Top = 158
440:             .Left = 122
441:             .Width = 64
442:             .FontName = "Tahoma"
443:             .FontSize = 8
444:             .ForeColor = RGB(90, 90, 90)
445:             .Caption = "Vencimento :"
446:             .Visible = .T.
447:         ENDWITH
448: 
449:         par_oPag.AddObject("txt_4c_VencsI", "TextBox")
450:         WITH par_oPag.txt_4c_VencsI
451:             .Top = 154
452:             .Left = 190
453:             .Width = 80
454:             .Height = 23
455:             .Alignment = 3
456:             .Value = {}
457:             .FontName = "Tahoma"
458:             .SpecialEffect = 1
459:             .Visible = .T.
460:         ENDWITH
461: 
462:         par_oPag.AddObject("lbl_4c_Label1", "Label")
463:         WITH par_oPag.lbl_4c_Label1
464:             .Top = 158
465:             .Left = 275
466:             .Width = 18
467:             .FontName = "Tahoma"
468:             .FontSize = 8
469:             .BackStyle = 0
470:             .ForeColor = RGB(90, 90, 90)
471:             .Caption = loc_cAte
472:             .Visible = .T.
473:         ENDWITH
474: 
475:         par_oPag.AddObject("txt_4c_VencsF", "TextBox")
476:         WITH par_oPag.txt_4c_VencsF
477:             .Top = 154
478:             .Left = 299
479:             .Width = 80
480:             .Height = 23
481:             .Alignment = 3
482:             .Value = {}
483:             .FontName = "Tahoma"
484:             .SpecialEffect = 1
485:             .Visible = .T.
486:         ENDWITH
487: 
488:         *-- Lancamento
489:         par_oPag.AddObject("lbl_4c_Say2", "Label")
490:         WITH par_oPag.lbl_4c_Say2
491:             .Top = 184
492:             .Left = 119
493:             .Width = 67
494:             .FontName = "Tahoma"
495:             .FontSize = 8
496:             .ForeColor = RGB(90, 90, 90)
497:             .Caption = "Lan" + CHR(231) + "amento :"
498:             .Visible = .T.
499:         ENDWITH
500: 
501:         par_oPag.AddObject("txt_4c_DatasI", "TextBox")
502:         WITH par_oPag.txt_4c_DatasI
503:             .Top = 180
504:             .Left = 190
505:             .Width = 80
506:             .Height = 23
507:             .Alignment = 3
508:             .Value = {}
509:             .FontName = "Tahoma"
510:             .SpecialEffect = 1
511:             .Visible = .T.
512:         ENDWITH
513: 
514:         par_oPag.AddObject("lbl_4c_Label3", "Label")
515:         WITH par_oPag.lbl_4c_Label3
516:             .Top = 184
517:             .Left = 275
518:             .Width = 18
519:             .FontName = "Tahoma"
520:             .FontSize = 8
521:             .BackStyle = 0
522:             .ForeColor = RGB(90, 90, 90)
523:             .Caption = loc_cAte
524:             .Visible = .T.
525:         ENDWITH
526: 
527:         par_oPag.AddObject("txt_4c_DatasF", "TextBox")
528:         WITH par_oPag.txt_4c_DatasF
529:             .Top = 180
530:             .Left = 299
531:             .Width = 80
532:             .Height = 23
533:             .Alignment = 3
534:             .Value = {}
535:             .FontName = "Tahoma"
536:             .SpecialEffect = 1
537:             .Visible = .T.
538:         ENDWITH
539: 
540:         *-- Acerto (Baixa)
541:         par_oPag.AddObject("lbl_4c_Say13", "Label")
542:         WITH par_oPag.lbl_4c_Say13
543:             .Top = 210
544:             .Left = 145
545:             .Width = 41
546:             .FontName = "Tahoma"
547:             .FontSize = 8
548:             .ForeColor = RGB(90, 90, 90)
549:             .Caption = "Acerto :"
550:             .Visible = .T.
551:         ENDWITH
552: 
553:         par_oPag.AddObject("txt_4c_DtBxI", "TextBox")
554:         WITH par_oPag.txt_4c_DtBxI
555:             .Top = 206
556:             .Left = 190
557:             .Width = 80
558:             .Height = 23
559:             .Alignment = 3
560:             .Value = {}
561:             .FontName = "Tahoma"
562:             .SpecialEffect = 1
563:             .Visible = .T.
564:         ENDWITH
565: 
566:         par_oPag.AddObject("lbl_4c_Label4", "Label")
567:         WITH par_oPag.lbl_4c_Label4
568:             .Top = 210
569:             .Left = 275
570:             .Width = 18
571:             .FontName = "Tahoma"
572:             .FontSize = 8
573:             .BackStyle = 0
574:             .ForeColor = RGB(90, 90, 90)
575:             .Caption = loc_cAte
576:             .Visible = .T.
577:         ENDWITH
578: 
579:         par_oPag.AddObject("txt_4c_DtBxF", "TextBox")
580:         WITH par_oPag.txt_4c_DtBxF
581:             .Top = 206
582:             .Left = 299
583:             .Width = 80
584:             .Height = 23
585:             .Alignment = 3
586:             .Value = {}
587:             .FontName = "Tahoma"
588:             .SpecialEffect = 1
589:             .Visible = .T.
590:         ENDWITH
591: 
592:         *-- Branco (checkbox ao lado da faixa de Emissao)
593:         par_oPag.AddObject("chk_4c_Brancos", "CheckBox")
594:         WITH par_oPag.chk_4c_Brancos
595:             .Top = 134
596:             .Left = 382
597:             .Width = 46
598:             .Height = 13
599:             .FontSize = 7
600:             .Alignment = 0
601:             .Caption = "Branco"
602:             .Value = 0
603:             .SpecialEffect = 1
604:             .Visible = .T.
605:         ENDWITH
606: 
607:         *-- Titulo
608:         par_oPag.AddObject("lbl_4c_Say4", "Label")
609:         WITH par_oPag.lbl_4c_Say4
610:             .Top = 133
611:             .Left = 466
612:             .Width = 35
613:             .FontName = "Tahoma"
614:             .FontSize = 8
615:             .ForeColor = RGB(90, 90, 90)
616:             .Caption = "T" + CHR(237) + "tulo :"
617:             .Visible = .T.
618:         ENDWITH
619: 
620:         par_oPag.AddObject("txt_4c_Titulos", "TextBox")
621:         WITH par_oPag.txt_4c_Titulos
622:             .Top = 129
623:             .Left = 504
624:             .Width = 80
625:             .Height = 23
626:             .Alignment = 3
627:             .Value = ""
628:             .MaxLength = 10
629:             .FontName = "Tahoma"
630:             .SpecialEffect = 1
631:             .Visible = .T.
632:         ENDWITH
633: 
634:         *-- Nota Fiscal
635:         par_oPag.AddObject("lbl_4c_Say20", "Label")
636:         WITH par_oPag.lbl_4c_Say20
637:             .Top = 158
638:             .Left = 440
639:             .FontName = "Tahoma"
640:             .ForeColor = RGB(90, 90, 90)
641:             .Caption = "Nota Fiscal :"
642:             .Visible = .T.
643:         ENDWITH
644: 
645:         par_oPag.AddObject("txt_4c_NFs", "TextBox")
646:         WITH par_oPag.txt_4c_NFs
647:             .Top = 154
648:             .Left = 504
649:             .Width = 80
650:             .Height = 23
651:             .Value = ""
652:             .Format = "K!"
653:             .FontName = "Tahoma"
654:             .SpecialEffect = 1
655:             .Visible = .T.
656:         ENDWITH
657: 
658:         *-- Titulo Banco
659:         par_oPag.AddObject("lbl_4c_Say12", "Label")
660:         WITH par_oPag.lbl_4c_Say12
661:             .Top = 184
662:             .Left = 434
663:             .Width = 67
664:             .FontName = "Tahoma"
665:             .ForeColor = RGB(90, 90, 90)
666:             .Caption = "T" + CHR(237) + "tulo Banco :"
667:             .Visible = .T.
668:         ENDWITH
669: 
670:         par_oPag.AddObject("txt_4c_TitBans", "TextBox")
671:         WITH par_oPag.txt_4c_TitBans
672:             .Top = 180
673:             .Left = 504
674:             .Width = 80
675:             .Height = 23
676:             .Value = ""
677:             .FontName = "Tahoma"
678:             .SpecialEffect = 1
679:             .Visible = .T.
680:         ENDWITH
681: 
682:         *-- Especie da NF
683:         par_oPag.AddObject("lbl_4c_Say25", "Label")
684:         WITH par_oPag.lbl_4c_Say25
685:             .Top = 210
686:             .Left = 456
687:             .Width = 45
688:             .FontName = "Tahoma"
689:             .ForeColor = RGB(90, 90, 90)
690:             .Caption = "Esp" + CHR(233) + "cie :"
691:             .Visible = .T.
692:         ENDWITH
693: 
694:         par_oPag.AddObject("txt_4c_EspecieNfs", "TextBox")
695:         WITH par_oPag.txt_4c_EspecieNfs
696:             .Top = 206
697:             .Left = 504
698:             .Width = 52
699:             .Height = 23
700:             .Value = ""
701:             .FontName = "Tahoma"
702:             .SpecialEffect = 1
703:             .Visible = .T.
704:         ENDWITH
705: 
706:         *-- Moeda Filtro
707:         par_oPag.AddObject("lbl_4c_LblFator", "Label")
708:         WITH par_oPag.lbl_4c_LblFator
709:             .Top = 236
710:             .Left = 118
711:             .Width = 68
712:             .FontName = "Tahoma"
713:             .ForeColor = RGB(90, 90, 90)
714:             .Caption = "Moeda Filtro :"
715:             .Visible = .T.
716:         ENDWITH
717: 
718:         par_oPag.AddObject("txt_4c_CMoes", "TextBox")
719:         WITH par_oPag.txt_4c_CMoes
720:             .Top = 232
721:             .Left = 190
722:             .Width = 31
723:             .Height = 23
724:             .Value = ""
725:             .Format = "K"
726:             .MaxLength = 3

*-- Linhas 732 a 767:
732: 
733:         par_oPag.AddObject("txt_4c_DMoes", "TextBox")
734:         WITH par_oPag.txt_4c_DMoes
735:             .Top = 232
736:             .Left = 225
737:             .Width = 154
738:             .Height = 23
739:             .Value = ""
740:             .Format = "K"
741:             .MaxLength = 15
742:             .FontName = "Tahoma"
743:             .SpecialEffect = 1
744:             .Visible = .T.
745:         ENDWITH
746: 
747:         *-- Saldo Inicial + Moeda do Saldo
748:         par_oPag.AddObject("lbl_4c_Say11", "Label")
749:         WITH par_oPag.lbl_4c_Say11
750:             .Top = 236
751:             .Left = 436
752:             .Width = 65
753:             .FontName = "Tahoma"
754:             .ForeColor = RGB(90, 90, 90)
755:             .Caption = "Saldo Inicial :"
756:             .Visible = .T.
757:         ENDWITH
758: 
759:         par_oPag.AddObject("txt_4c_Saldo", "TextBox")
760:         WITH par_oPag.txt_4c_Saldo
761:             .Top = 232
762:             .Left = 504
763:             .Width = 80
764:             .Height = 23
765:             .Alignment = 1
766:             .Value = 0
767:             .Format = "K"

*-- Linhas 774 a 810:
774: 
775:         par_oPag.AddObject("txt_4c_MoeSaldo", "TextBox")
776:         WITH par_oPag.txt_4c_MoeSaldo
777:             .Top = 232
778:             .Left = 587
779:             .Width = 31
780:             .Height = 23
781:             .Value = ""
782:             .Format = "K"
783:             .MaxLength = 3
784:             .FontName = "Tahoma"
785:             .FontSize = 9
786:             .SpecialEffect = 1
787:             .Visible = .T.
788:         ENDWITH
789: 
790:         *-- Moeda Conversao
791:         par_oPag.AddObject("lbl_4c_Say6", "Label")
792:         WITH par_oPag.lbl_4c_Say6
793:             .Top = 262
794:             .Left = 90
795:             .Width = 96
796:             .FontName = "Tahoma"
797:             .ForeColor = RGB(90, 90, 90)
798:             .Caption = "Moeda Convers" + CHR(227) + "o :"
799:             .Visible = .T.
800:         ENDWITH
801: 
802:         par_oPag.AddObject("txt_4c_CMoesC", "TextBox")
803:         WITH par_oPag.txt_4c_CMoesC
804:             .Top = 258
805:             .Left = 190
806:             .Width = 31
807:             .Height = 23
808:             .Value = ""
809:             .Format = "K"
810:             .MaxLength = 3

*-- Linhas 816 a 876:
816: 
817:         par_oPag.AddObject("txt_4c_DMoesC", "TextBox")
818:         WITH par_oPag.txt_4c_DMoesC
819:             .Top = 258
820:             .Left = 225
821:             .Width = 154
822:             .Height = 23
823:             .Value = ""
824:             .Format = "K"
825:             .MaxLength = 15
826:             .FontName = "Tahoma"
827:             .SpecialEffect = 1
828:             .Visible = .T.
829:         ENDWITH
830: 
831:         *-- Empresa
832:         par_oPag.AddObject("lbl_4c_Say17", "Label")
833:         WITH par_oPag.lbl_4c_Say17
834:             .Top = 262
835:             .Left = 451
836:             .FontName = "Tahoma"
837:             .ForeColor = RGB(90, 90, 90)
838:             .Caption = "Empresa :"
839:             .Visible = .T.
840:         ENDWITH
841: 
842:         par_oPag.AddObject("txt_4c_Empresa", "TextBox")
843:         WITH par_oPag.txt_4c_Empresa
844:             .Top = 258
845:             .Left = 504
846:             .Width = 33
847:             .Height = 23
848:             .Value = ""
849:             .FontName = "Tahoma"
850:             .SpecialEffect = 1
851:             .Themes = .F.
852:             .Visible = .T.
853:             .MaxLength   = 3
854:         ENDWITH
855: 
856:         *-- F.Publicidade
857:         par_oPag.AddObject("lbl_4c_Say18", "Label")
858:         WITH par_oPag.lbl_4c_Say18
859:             .Top = 404
860:             .Left = 548
861:             .Width = 72
862:             .FontName = "Tahoma"
863:             .ForeColor = RGB(90, 90, 90)
864:             .Caption = "F.Publicidade :"
865:             .Visible = .T.
866:         ENDWITH
867: 
868:         par_oPag.AddObject("txt_4c_CFPublis", "TextBox")
869:         WITH par_oPag.txt_4c_CFPublis
870:             .Top = 400
871:             .Left = 624
872:             .Width = 31
873:             .Height = 23
874:             .Value = ""
875:             .Format = "K"
876:             .MaxLength = 3

*-- Linhas 882 a 946:
882: 
883:         par_oPag.AddObject("txt_4c_DFPublis", "TextBox")
884:         WITH par_oPag.txt_4c_DFPublis
885:             .Top = 400
886:             .Left = 658
887:             .Width = 181
888:             .Height = 23
889:             .Value = ""
890:             .Format = "K"
891:             .MaxLength = 15
892:             .FontName = "Tahoma"
893:             .SpecialEffect = 1
894:             .Visible = .T.
895:         ENDWITH
896: 
897:         *-- chkValpags "Valor em aberto" (checkbox ao lado das OptionGroups)
898:         par_oPag.AddObject("chk_4c_ValPends", "CheckBox")
899:         WITH par_oPag.chk_4c_ValPends
900:             .Top = 309
901:             .Left = 409
902:             .Width = 82
903:             .Height = 13
904:             .FontSize = 7
905:             .Alignment = 0
906:             .Caption = "Valor Pendente"
907:             .Value = 0
908:             .SpecialEffect = 1
909:             .Visible = .T.
910:         ENDWITH
911: 
912:         *-- Filtros nomeados (Say14 + getFiltros visivel / getNewFiltro oculto)
913:         par_oPag.AddObject("lbl_4c_Say14", "Label")
914:         WITH par_oPag.lbl_4c_Say14
915:             .Top = 103
916:             .Left = 148
917:             .Width = 38
918:             .FontName = "Tahoma"
919:             .ForeColor = RGB(90, 90, 90)
920:             .Caption = "Filtros :"
921:             .Visible = .T.
922:         ENDWITH
923: 
924:         par_oPag.AddObject("txt_4c_Filtros", "TextBox")
925:         WITH par_oPag.txt_4c_Filtros
926:             .Top = 99
927:             .Left = 190
928:             .Width = 312
929:             .Height = 23
930:             .Value = ""
931:             .Format = "K!"
932:             .BackStyle = 1
933:             .FontName = "Tahoma"
934:             .SpecialEffect = 1
935:             .Visible = .T.
936:         ENDWITH
937: 
938:         par_oPag.AddObject("txt_4c_NewFiltro", "TextBox")
939:         WITH par_oPag.txt_4c_NewFiltro
940:             .Top = 99
941:             .Left = 190
942:             .Width = 312
943:             .Height = 23
944:             .Value = ""
945:             .Format = "K!"
946:             .BackStyle = 1

*-- Linhas 964 a 991:
964:         BINDEVENT(par_oPag.txt_4c_TitBans,    "LostFocus", THIS, "ValidarTitBansFiltro")
965: 
966:         *-- Textos fixos sobre as duas grades de clientes
967:         par_oPag.AddObject("lbl_4c_Say15", "Label")
968:         WITH par_oPag.lbl_4c_Say15
969:             .Top = 410
970:             .Left = 81
971:             .Width = 351
972:             .FontBold = .T.
973:             .FontSize = 8
974:             .Caption = "Filtrar lan" + CHR(231) + "amento que contenham uma das condi" + CHR(231) + CHR(245) + "es abaixo:"
975:             .Visible = .T.
976:         ENDWITH
977: 
978:         par_oPag.AddObject("lbl_4c_Say16", "Label")
979:         WITH par_oPag.lbl_4c_Say16
980:             .Top = 559
981:             .Left = 81
982:             .Width = 574
983:             .FontBold = .T.
984:             .FontSize = 8
985:             .ForeColor = RGB(255, 255, 255)
986:             .Caption = "Filtrar lan" + CHR(231) + "amento que contenham uma das condi" + CHR(231) + CHR(245) + "es da grade acima e da grade abaixo contenham :"
987:             .Visible = .T.
988:         ENDWITH
989:     ENDPROC
990: 
991:     *--------------------------------------------------------------------------

*-- Linhas 998 a 1394:
998:         loc_cNao = "N" + CHR(227) + "o"
999: 
1000:         *-- Pagamento
1001:         par_oPag.AddObject("lbl_4c_Say3", "Label")
1002:         WITH par_oPag.lbl_4c_Say3
1003:             .Top = 308
1004:             .Left = 123
1005:             .Width = 63
1006:             .FontName = "Tahoma"
1007:             .ForeColor = RGB(90, 90, 90)
1008:             .Caption = "Pagamento :"
1009:             .Visible = .T.
1010:         ENDWITH
1011: 
1012:         par_oPag.AddObject("opt_4c_Pagos", "OptionGroup")
1013:         WITH par_oPag.opt_4c_Pagos
1014:             .Top = 303
1015:             .Left = 185
1016:             .Width = 217
1017:             .Height = 25
1018:             .ButtonCount = 3
1019:             .BackStyle = 0
1020:             .BorderStyle = 0
1021:             .Value = 1
1022:             WITH .Buttons(1)
1023:                 .Top = 5
1024:                 .Left = 5
1025:                 .Width = 43
1026:                 .FontName = "Tahoma"
1027:                 .FontSize = 8
1028:                 .BackStyle = 0
1029:                 .Caption = "Geral"
1030:                 .ForeColor = RGB(90, 90, 90)
1031:             ENDWITH
1032:             WITH .Buttons(2)
1033:                 .Top = 5
1034:                 .Left = 85
1035:                 .Width = 34
1036:                 .FontName = "Tahoma"
1037:                 .FontSize = 8
1038:                 .BackStyle = 0
1039:                 .Caption = "Sim"
1040:                 .ForeColor = RGB(90, 90, 90)
1041:             ENDWITH
1042:             WITH .Buttons(3)
1043:                 .Top = 5
1044:                 .Left = 175
1045:                 .Width = 37
1046:                 .FontName = "Tahoma"
1047:                 .FontSize = 8
1048:                 .BackStyle = 0
1049:                 .Caption = loc_cNao
1050:                 .ForeColor = RGB(90, 90, 90)
1051:             ENDWITH
1052:             .Visible = .T.
1053:         ENDWITH
1054: 
1055:         *-- Opcao
1056:         par_oPag.AddObject("lbl_4c_Say5", "Label")
1057:         WITH par_oPag.lbl_4c_Say5
1058:             .Top = 329
1059:             .Left = 146
1060:             .Width = 40
1061:             .FontName = "Tahoma"
1062:             .ForeColor = RGB(90, 90, 90)
1063:             .Caption = "Op" + CHR(231) + CHR(227) + "o :"
1064:             .Visible = .T.
1065:         ENDWITH
1066: 
1067:         par_oPag.AddObject("opt_4c_Opcao", "OptionGroup")
1068:         WITH par_oPag.opt_4c_Opcao
1069:             .Top = 324
1070:             .Left = 185
1071:             .Width = 217
1072:             .Height = 25
1073:             .ButtonCount = 3
1074:             .BackStyle = 0
1075:             .BorderStyle = 0
1076:             .Value = 1
1077:             WITH .Buttons(1)
1078:                 .Top = 5
1079:                 .Left = 5
1080:                 .Width = 43
1081:                 .FontName = "Tahoma"
1082:                 .FontSize = 8
1083:                 .BackStyle = 0
1084:                 .Caption = "Geral"
1085:                 .ForeColor = RGB(90, 90, 90)
1086:             ENDWITH
1087:             WITH .Buttons(2)
1088:                 .Top = 5
1089:                 .Left = 85
1090:                 .Width = 34
1091:                 .FontName = "Tahoma"
1092:                 .FontSize = 8
1093:                 .BackStyle = 0
1094:                 .Caption = "Sim"
1095:                 .ForeColor = RGB(90, 90, 90)
1096:             ENDWITH
1097:             WITH .Buttons(3)
1098:                 .Top = 5
1099:                 .Left = 175
1100:                 .Width = 37
1101:                 .FontName = "Tahoma"
1102:                 .FontSize = 8
1103:                 .BackStyle = 0
1104:                 .Caption = loc_cNao
1105:                 .ForeColor = RGB(90, 90, 90)
1106:             ENDWITH
1107:             .Visible = .T.
1108:         ENDWITH
1109: 
1110:         *-- Conversao em
1111:         par_oPag.AddObject("lbl_4c_Say7", "Label")
1112:         WITH par_oPag.lbl_4c_Say7
1113:             .Top = 287
1114:             .Left = 108
1115:             .Width = 78
1116:             .FontName = "Tahoma"
1117:             .ForeColor = RGB(90, 90, 90)
1118:             .Caption = "Convers" + CHR(227) + "o em :"
1119:             .Visible = .T.
1120:         ENDWITH
1121: 
1122:         par_oPag.AddObject("opt_4c_CotEm", "OptionGroup")
1123:         WITH par_oPag.opt_4c_CotEm
1124:             .Top = 282
1125:             .Left = 185
1126:             .Width = 405
1127:             .Height = 25
1128:             .ButtonCount = 5
1129:             .BackStyle = 0
1130:             .BorderStyle = 0
1131:             .Value = 1
1132:             WITH .Buttons(1)
1133:                 .Top = 5
1134:                 .Left = 5
1135:                 .Width = 56
1136:                 .FontName = "Tahoma"
1137:                 .FontSize = 8
1138:                 .BackStyle = 0
1139:                 .Caption = "Emiss" + CHR(227) + "o"
1140:                 .ForeColor = RGB(90, 90, 90)
1141:             ENDWITH
1142:             WITH .Buttons(2)
1143:                 .Top = 5
1144:                 .Left = 85
1145:                 .Width = 73
1146:                 .FontName = "Tahoma"
1147:                 .FontSize = 8
1148:                 .BackStyle = 0
1149:                 .Caption = "Vencimento"
1150:                 .ForeColor = RGB(90, 90, 90)
1151:             ENDWITH
1152:             WITH .Buttons(3)
1153:                 .Top = 5
1154:                 .Left = 175
1155:                 .Width = 76
1156:                 .FontName = "Tahoma"
1157:                 .FontSize = 8
1158:                 .BackStyle = 0
1159:                 .Caption = "Lan" + CHR(231) + "amento"
1160:                 .ForeColor = RGB(90, 90, 90)
1161:             ENDWITH
1162:             WITH .Buttons(4)
1163:                 .Top = 5
1164:                 .Left = 281
1165:                 .Width = 43
1166:                 .FontName = "Tahoma"
1167:                 .FontSize = 8
1168:                 .BackStyle = 0
1169:                 .Caption = "Atual"
1170:                 .ForeColor = RGB(90, 90, 90)
1171:             ENDWITH
1172:             WITH .Buttons(5)
1173:                 .Top = 5
1174:                 .Left = 350
1175:                 .Width = 50
1176:                 .FontName = "Tahoma"
1177:                 .FontSize = 8
1178:                 .BackStyle = 0
1179:                 .Caption = "Acerto"
1180:                 .ForeColor = RGB(90, 90, 90)
1181:             ENDWITH
1182:             .Visible = .T.
1183:         ENDWITH
1184: 
1185:         *-- Cancelamento
1186:         par_oPag.AddObject("lbl_4c_Say8", "Label")
1187:         WITH par_oPag.lbl_4c_Say8
1188:             .Top = 349
1189:             .Left = 109
1190:             .Width = 77
1191:             .FontName = "Tahoma"
1192:             .ForeColor = RGB(90, 90, 90)
1193:             .Caption = "Cancelamento :"
1194:             .Visible = .T.
1195:         ENDWITH
1196: 
1197:         par_oPag.AddObject("opt_4c_Cancs", "OptionGroup")
1198:         WITH par_oPag.opt_4c_Cancs
1199:             .Top = 344
1200:             .Left = 185
1201:             .Width = 217
1202:             .Height = 25
1203:             .ButtonCount = 3
1204:             .BackStyle = 0
1205:             .BorderStyle = 0
1206:             .Value = 1
1207:             WITH .Buttons(1)
1208:                 .Top = 5
1209:                 .Left = 5
1210:                 .Width = 43
1211:                 .FontName = "Tahoma"
1212:                 .FontSize = 8
1213:                 .BackStyle = 0
1214:                 .Caption = "Geral"
1215:                 .ForeColor = RGB(90, 90, 90)
1216:             ENDWITH
1217:             WITH .Buttons(2)
1218:                 .Top = 5
1219:                 .Left = 85
1220:                 .Width = 34
1221:                 .FontName = "Tahoma"
1222:                 .FontSize = 8
1223:                 .BackStyle = 0
1224:                 .Caption = "Sim"
1225:                 .ForeColor = RGB(90, 90, 90)
1226:             ENDWITH
1227:             WITH .Buttons(3)
1228:                 .Top = 5
1229:                 .Left = 175
1230:                 .Width = 37
1231:                 .FontName = "Tahoma"
1232:                 .FontSize = 8
1233:                 .BackStyle = 0
1234:                 .Caption = loc_cNao
1235:                 .ForeColor = RGB(90, 90, 90)
1236:             ENDWITH
1237:             .Visible = .T.
1238:         ENDWITH
1239: 
1240:         *-- Conciliacao
1241:         par_oPag.AddObject("lbl_4c_Say9", "Label")
1242:         WITH par_oPag.lbl_4c_Say9
1243:             .Top = 369
1244:             .Left = 124
1245:             .Width = 62
1246:             .FontName = "Tahoma"
1247:             .ForeColor = RGB(90, 90, 90)
1248:             .Caption = "Concilia" + CHR(231) + CHR(227) + "o :"
1249:             .Visible = .T.
1250:         ENDWITH
1251: 
1252:         par_oPag.AddObject("opt_4c_Concs", "OptionGroup")
1253:         WITH par_oPag.opt_4c_Concs
1254:             .Top = 364
1255:             .Left = 185
1256:             .Width = 217
1257:             .Height = 25
1258:             .ButtonCount = 3
1259:             .BackStyle = 0
1260:             .BorderStyle = 0
1261:             .Value = 1
1262:             WITH .Buttons(1)
1263:                 .Top = 5
1264:                 .Left = 5
1265:                 .Width = 43
1266:                 .FontName = "Tahoma"
1267:                 .FontSize = 8
1268:                 .BackStyle = 0
1269:                 .Caption = "Geral"
1270:                 .ForeColor = RGB(90, 90, 90)
1271:             ENDWITH
1272:             WITH .Buttons(2)
1273:                 .Top = 5
1274:                 .Left = 85
1275:                 .Width = 34
1276:                 .FontName = "Tahoma"
1277:                 .FontSize = 8
1278:                 .BackStyle = 0
1279:                 .Caption = "Sim"
1280:                 .ForeColor = RGB(90, 90, 90)
1281:             ENDWITH
1282:             WITH .Buttons(3)
1283:                 .Top = 5
1284:                 .Left = 175
1285:                 .Width = 37
1286:                 .FontName = "Tahoma"
1287:                 .FontSize = 8
1288:                 .BackStyle = 0
1289:                 .Caption = loc_cNao
1290:                 .ForeColor = RGB(90, 90, 90)
1291:             ENDWITH
1292:             .Visible = .T.
1293:         ENDWITH
1294: 
1295:         *-- Prorrogacao
1296:         par_oPag.AddObject("lbl_4c_Say10", "Label")
1297:         WITH par_oPag.lbl_4c_Say10
1298:             .Top = 388
1299:             .Left = 118
1300:             .Width = 68
1301:             .FontName = "Tahoma"
1302:             .ForeColor = RGB(90, 90, 90)
1303:             .Caption = "Prorroga" + CHR(231) + CHR(227) + "o :"
1304:             .Visible = .T.
1305:         ENDWITH
1306: 
1307:         par_oPag.AddObject("opt_4c_Prorrogs", "OptionGroup")
1308:         WITH par_oPag.opt_4c_Prorrogs
1309:             .Top = 383
1310:             .Left = 185
1311:             .Width = 217
1312:             .Height = 25
1313:             .ButtonCount = 3
1314:             .BackStyle = 0
1315:             .BorderStyle = 0
1316:             .Value = 1
1317:             WITH .Buttons(1)
1318:                 .Top = 5
1319:                 .Left = 5
1320:                 .Width = 43
1321:                 .FontName = "Tahoma"
1322:                 .FontSize = 8
1323:                 .BackStyle = 0
1324:                 .Caption = "Geral"
1325:                 .ForeColor = RGB(90, 90, 90)
1326:             ENDWITH
1327:             WITH .Buttons(2)
1328:                 .Top = 5
1329:                 .Left = 85
1330:                 .Width = 34
1331:                 .FontName = "Tahoma"
1332:                 .FontSize = 8
1333:                 .BackStyle = 0
1334:                 .Caption = "Sim"
1335:                 .ForeColor = RGB(90, 90, 90)
1336:             ENDWITH
1337:             WITH .Buttons(3)
1338:                 .Top = 5
1339:                 .Left = 175
1340:                 .Width = 37
1341:                 .FontName = "Tahoma"
1342:                 .FontSize = 8
1343:                 .BackStyle = 0
1344:                 .Caption = loc_cNao
1345:                 .ForeColor = RGB(90, 90, 90)
1346:             ENDWITH
1347:             .Visible = .T.
1348:         ENDWITH
1349: 
1350:         *-- Filtro da grade 2 (Todas/Alguma) - sobre fundo escuro, texto branco
1351:         par_oPag.AddObject("opt_4c_FilGrd2", "OptionGroup")
1352:         WITH par_oPag.opt_4c_FilGrd2
1353:             .Top = 557
1354:             .Left = 748
1355:             .Width = 139
1356:             .Height = 17
1357:             .ButtonCount = 2
1358:             .AutoSize = .F.
1359:             .BackStyle = 0
1360:             .BorderStyle = 0
1361:             .Value = 1
1362:             WITH .Buttons(1)
1363:                 .Top = 1
1364:                 .Left = 5
1365:                 .Width = 58
1366:                 .FontName = "Verdana"
1367:                 .FontSize = 8
1368:                 .FontBold = .T.
1369:                 .BackStyle = 0
1370:                 .Caption = "Todas"
1371:                 .ForeColor = RGB(255, 255, 255)
1372:             ENDWITH
1373:             WITH .Buttons(2)
1374:                 .Top = 1
1375:                 .Left = 68
1376:                 .Width = 68
1377:                 .FontName = "Verdana"
1378:                 .FontSize = 8
1379:                 .FontBold = .T.
1380:                 .BackStyle = 0
1381:                 .Caption = "Alguma"
1382:                 .ForeColor = RGB(255, 255, 255)
1383:             ENDWITH
1384:             .Visible = .T.
1385:         ENDWITH
1386:     ENDPROC
1387: 
1388:     *--------------------------------------------------------------------------
1389:     * ConfigurarGradesFiltros - grdTipo (Column1=Imps checkbox + Column2=Dopes
1390:     * texto, bound a cursor_4c_Tipos) e as duas grades de Grupo/Conta
1391:     * (Grd_Clientes/Grd_Clientes2, 8 colunas: Grupo/NomeGrupo/Conta/Nome +
1392:     * CheckE/CheckP/CheckC/CheckA). ColumnOrder transcrito do dump (a ordem
1393:     * visual NAO segue a ordem numerica das colunas).
1394:     *--------------------------------------------------------------------------

*-- Linhas 1401 a 1410:
1401:         *-- grdTipo
1402:         par_oPag.AddObject("grd_4c_Tipos", "Grid")
1403:         WITH par_oPag.grd_4c_Tipos
1404:             .Top = 100
1405:             .Left = 624
1406:             .Width = 259
1407:             .Height = 275
1408:             .FontName = "Tahoma"
1409:             .AllowHeaderSizing = .F.
1410:             .AllowRowSizing = .F.

*-- Linhas 1421 a 1444:
1421:             .Column1.Width = 17
1422:             .Column1.Alignment = 0
1423:             .Column1.Sparse = .F.
1424:             .Column1.Header1.Caption = ""
1425:             .Column1.AddObject("Check1", "CheckBox")
1426:             .Column1.Check1.Top = 23
1427:             .Column1.Check1.Left = 35
1428:             .Column1.Check1.Width = 60
1429:             .Column1.Check1.Height = 17
1430:             .Column1.Check1.Caption = ""
1431:             .Column1.CurrentControl = "Check1"
1432: 
1433:             .Column2.ControlSource = loc_cTipos + ".Dopes"
1434:             .Column2.Width = 220
1435:             .Column2.Movable = .F.
1436:             .Column2.Resizable = .F.
1437:             .Column2.ReadOnly = .T.
1438:             .Column2.Text1.ReadOnly = .T.
1439:             .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o de T" + CHR(237) + "tulos"
1440:             .Column2.Header1.Alignment = 2
1441:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
1442: 
1443:             .Visible = .T.
1444:         ENDWITH

*-- Linhas 1498 a 1507:
1498:         loc_oGrid = EVALUATE("par_oPag." + par_cNomeGrid)
1499: 
1500:         WITH loc_oGrid
1501:             .Top = par_nTop
1502:             .Left = 81
1503:             .Width = 802
1504:             .Height = par_nHeight
1505:             .FontName = "Tahoma"
1506:             .AllowHeaderSizing = .F.
1507:             .AllowRowSizing = .F.

*-- Linhas 1517 a 1621:
1517:             .Column1.Movable = .F.
1518:             .Column1.Resizable = .F.
1519:             .Column1.Text1.MaxLength = 10
1520:             .Column1.Header1.Caption = "Grupo"
1521:             .Column1.Header1.Alignment = 2
1522:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
1523: 
1524:             .Column4.ColumnOrder = 2
1525:             .Column4.ControlSource = par_cCursor + ".NomeGrupo"
1526:             .Column4.Width = 166
1527:             .Column4.Text1.MaxLength = 20
1528:             .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1529:             .Column4.Header1.Alignment = 2
1530:             .Column4.Header1.ForeColor = RGB(90, 90, 90)
1531: 
1532:             .Column2.ColumnOrder = 3
1533:             .Column2.ControlSource = par_cCursor + ".Conta"
1534:             .Column2.Width = 90
1535:             .Column2.Movable = .F.
1536:             .Column2.Resizable = .F.
1537:             .Column2.Text1.MaxLength = 10
1538:             .Column2.Header1.Caption = "Conta"
1539:             .Column2.Header1.Alignment = 2
1540:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
1541: 
1542:             .Column3.ColumnOrder = 4
1543:             .Column3.ControlSource = par_cCursor + ".Nome"
1544:             .Column3.Width = 360
1545:             .Column3.Movable = .F.
1546:             .Column3.Resizable = .F.
1547:             .Column3.Text1.MaxLength = 50
1548:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1549:             .Column3.Header1.Alignment = 2
1550:             .Column3.Header1.ForeColor = RGB(90, 90, 90)
1551: 
1552:             .Column5.ControlSource = par_cCursor + ".CheckE"
1553:             .Column5.Width = 17
1554:             .Column5.Sparse = .F.
1555:             .Column5.ToolTipText = "Emitente"
1556:             .Column5.Header1.Caption = "E"
1557:             .Column5.Header1.Alignment = 2
1558:             .Column5.Header1.ForeColor = RGB(90, 90, 90)
1559:             .Column5.Header1.ToolTipText = "Emitente"
1560:             .Column5.AddObject("Check1", "CheckBox")
1561:             .Column5.Check1.Top = 31
1562:             .Column5.Check1.Left = 9
1563:             .Column5.Check1.Width = 60
1564:             .Column5.Check1.Height = 17
1565:             .Column5.Check1.Caption = ""
1566:             .Column5.Check1.ToolTipText = "Emitente"
1567:             .Column5.CurrentControl = "Check1"
1568: 
1569:             .Column6.ControlSource = par_cCursor + ".CheckP"
1570:             .Column6.Width = 17
1571:             .Column6.Sparse = .F.
1572:             .Column6.ToolTipText = "Portador"
1573:             .Column6.Header1.Caption = "P"
1574:             .Column6.Header1.Alignment = 2
1575:             .Column6.Header1.ForeColor = RGB(90, 90, 90)
1576:             .Column6.Header1.ToolTipText = "Portador"
1577:             .Column6.AddObject("Check1", "CheckBox")
1578:             .Column6.Check1.Top = 31
1579:             .Column6.Check1.Left = 9
1580:             .Column6.Check1.Width = 60
1581:             .Column6.Check1.Height = 17
1582:             .Column6.Check1.Caption = ""
1583:             .Column6.Check1.ToolTipText = "Portador"
1584:             .Column6.CurrentControl = "Check1"
1585: 
1586:             .Column7.ControlSource = par_cCursor + ".CheckC"
1587:             .Column7.Width = 17
1588:             .Column7.Sparse = .F.
1589:             .Column7.ToolTipText = "Centro de Custo"
1590:             .Column7.Header1.Caption = "C"
1591:             .Column7.Header1.Alignment = 2
1592:             .Column7.Header1.ForeColor = RGB(90, 90, 90)
1593:             .Column7.Header1.ToolTipText = "Centro de Custo"
1594:             .Column7.AddObject("Check1", "CheckBox")
1595:             .Column7.Check1.Top = 30
1596:             .Column7.Check1.Left = 9
1597:             .Column7.Check1.Width = 60
1598:             .Column7.Check1.Height = 17
1599:             .Column7.Check1.Caption = ""
1600:             .Column7.Check1.ToolTipText = "Centro de Custo"
1601:             .Column7.CurrentControl = "Check1"
1602: 
1603:             .Column8.ControlSource = par_cCursor + ".CheckA"
1604:             .Column8.Width = 17
1605:             .Column8.Sparse = .F.
1606:             .Column8.ToolTipText = "Agente Cobrador"
1607:             .Column8.Header1.Caption = "A"
1608:             .Column8.Header1.Alignment = 2
1609:             .Column8.Header1.ForeColor = RGB(90, 90, 90)
1610:             .Column8.Header1.ToolTipText = "Agente Cobrador"
1611:             .Column8.AddObject("Check1", "CheckBox")
1612:             .Column8.Check1.Top = 33
1613:             .Column8.Check1.Left = 11
1614:             .Column8.Check1.Width = 60
1615:             .Column8.Check1.Height = 17
1616:             .Column8.Check1.Caption = ""
1617:             .Column8.Check1.ToolTipText = "Agente Cobrador"
1618:             .Column8.CurrentControl = "Check1"
1619: 
1620:             .Visible = .T.
1621:         ENDWITH

*-- Linhas 1628 a 1879:
1628:     *--------------------------------------------------------------------------
1629:     PROTECTED PROCEDURE ConfigurarBotoesFiltros(par_oPag)
1630:         *-- grdTipo: Apaga (desmarca tudo) / SelTudo (marca tudo)
1631:         par_oPag.AddObject("cmd_4c_SelTudo", "CommandButton")
1632:         WITH par_oPag.cmd_4c_SelTudo
1633:             .Top = 295
1634:             .Left = 892
1635:             .Width = 40
1636:             .Height = 40
1637:             .FontName = "Verdana"
1638:             .FontSize = 8
1639:             .WordWrap = .T.
1640:             .Caption = ""
1641:             .Picture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1642:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1643:             .ToolTipText = "Seleciona Tudo"
1644:             .ForeColor = RGB(36, 84, 155)
1645:             .BackColor = RGB(255, 255, 255)
1646:             .Themes = .T.
1647:             .Visible = .T.
1648:         ENDWITH
1649: 
1650:         par_oPag.AddObject("cmd_4c_Apaga", "CommandButton")
1651:         WITH par_oPag.cmd_4c_Apaga
1652:             .Top = 335
1653:             .Left = 892
1654:             .Width = 40
1655:             .Height = 40
1656:             .FontName = "Verdana"
1657:             .FontSize = 8
1658:             .WordWrap = .T.
1659:             .Caption = ""
1660:             .Picture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
1661:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
1662:             .ToolTipText = "Apaga Tudo"
1663:             .ForeColor = RGB(36, 84, 155)
1664:             .BackColor = RGB(255, 255, 255)
1665:             .Themes = .T.
1666:             .Visible = .T.
1667:         ENDWITH
1668: 
1669:         *-- Grd_Clientes: Inserir/Excluir/ApagaG1
1670:         par_oPag.AddObject("cmd_4c_Inserir", "CommandButton")
1671:         WITH par_oPag.cmd_4c_Inserir
1672:             .Top = 436
1673:             .Left = 892
1674:             .Width = 40
1675:             .Height = 40
1676:             .FontName = "Verdana"
1677:             .FontSize = 8
1678:             .WordWrap = .T.
1679:             .Caption = ""
1680:             .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1681:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1682:             .ToolTipText = "Insere Linha Em Branco na Grade"
1683:             .ForeColor = RGB(36, 84, 155)
1684:             .BackColor = RGB(255, 255, 255)
1685:             .Themes = .T.
1686:             .Visible = .T.
1687:         ENDWITH
1688: 
1689:         par_oPag.AddObject("cmd_4c_Excluir", "CommandButton")
1690:         WITH par_oPag.cmd_4c_Excluir
1691:             .Top = 476
1692:             .Left = 892
1693:             .Width = 40
1694:             .Height = 40
1695:             .FontName = "Verdana"
1696:             .FontSize = 8
1697:             .WordWrap = .T.
1698:             .Caption = ""
1699:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1700:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1701:             .ToolTipText = "Apaga Linha da Grade"
1702:             .ForeColor = RGB(36, 84, 155)
1703:             .BackColor = RGB(255, 255, 255)
1704:             .Themes = .T.
1705:             .Visible = .T.
1706:         ENDWITH
1707: 
1708:         par_oPag.AddObject("cmd_4c_ApagaG1", "CommandButton")
1709:         WITH par_oPag.cmd_4c_ApagaG1
1710:             .Top = 516
1711:             .Left = 892
1712:             .Width = 40
1713:             .Height = 40
1714:             .FontName = "Verdana"
1715:             .FontSize = 8
1716:             .WordWrap = .T.
1717:             .Caption = ""
1718:             .Picture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1719:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1720:             .ToolTipText = "Apaga TODAS as Linhas da Grade"
1721:             .ForeColor = RGB(36, 84, 155)
1722:             .BackColor = RGB(255, 255, 255)
1723:             .Themes = .T.
1724:             .Visible = .T.
1725:         ENDWITH
1726: 
1727:         *-- Grd_Clientes2: Inserir/Excluir/ApagaG2
1728:         par_oPag.AddObject("cmd_4c_Inserir2", "CommandButton")
1729:         WITH par_oPag.cmd_4c_Inserir2
1730:             .Top = 568
1731:             .Left = 892
1732:             .Width = 40
1733:             .Height = 40
1734:             .FontName = "Verdana"
1735:             .FontSize = 8
1736:             .WordWrap = .T.
1737:             .Caption = ""
1738:             .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1739:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1740:             .ToolTipText = "Insere Linha Em Branco na Grade"
1741:             .ForeColor = RGB(36, 84, 155)
1742:             .BackColor = RGB(255, 255, 255)
1743:             .Themes = .T.
1744:             .Visible = .T.
1745:         ENDWITH
1746: 
1747:         par_oPag.AddObject("cmd_4c_Excluir2", "CommandButton")
1748:         WITH par_oPag.cmd_4c_Excluir2
1749:             .Top = 608
1750:             .Left = 892
1751:             .Width = 40
1752:             .Height = 40
1753:             .FontName = "Verdana"
1754:             .FontSize = 8
1755:             .WordWrap = .T.
1756:             .Caption = ""
1757:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1758:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1759:             .ToolTipText = "Apaga Linha da Grade"
1760:             .ForeColor = RGB(36, 84, 155)
1761:             .BackColor = RGB(255, 255, 255)
1762:             .Themes = .T.
1763:             .Visible = .T.
1764:         ENDWITH
1765: 
1766:         par_oPag.AddObject("cmd_4c_ApagaG2", "CommandButton")
1767:         WITH par_oPag.cmd_4c_ApagaG2
1768:             .Top = 648
1769:             .Left = 892
1770:             .Width = 40
1771:             .Height = 40
1772:             .FontName = "Verdana"
1773:             .FontSize = 8
1774:             .WordWrap = .T.
1775:             .Caption = ""
1776:             .Picture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1777:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1778:             .ToolTipText = "Apaga TODAS as Linhas da Grade"
1779:             .ForeColor = RGB(36, 84, 155)
1780:             .BackColor = RGB(255, 255, 255)
1781:             .Themes = .T.
1782:             .Visible = .T.
1783:         ENDWITH
1784: 
1785:         *-- Filtro nomeado: AddFiltro/DelFiltro/RecFiltro
1786:         par_oPag.AddObject("cmd_4c_AddFiltro", "CommandButton")
1787:         WITH par_oPag.cmd_4c_AddFiltro
1788:             .Top = 95
1789:             .Left = 505
1790:             .Width = 32
1791:             .Height = 32
1792:             .FontName = "Verdana"
1793:             .FontSize = 8
1794:             .WordWrap = .T.
1795:             .Caption = ""
1796:             .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1797:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1798:             .ToolTipText = "Adicionar Filtro"
1799:             .ForeColor = RGB(36, 84, 155)
1800:             .BackColor = RGB(255, 255, 255)
1801:             .Themes = .T.
1802:             .Visible = .T.
1803:         ENDWITH
1804: 
1805:         par_oPag.AddObject("cmd_4c_DelFiltro", "CommandButton")
1806:         WITH par_oPag.cmd_4c_DelFiltro
1807:             .Top = 95
1808:             .Left = 537
1809:             .Width = 32
1810:             .Height = 32
1811:             .FontName = "Verdana"
1812:             .FontSize = 8
1813:             .WordWrap = .T.
1814:             .Caption = ""
1815:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1816:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1817:             .ToolTipText = "Apagar Filtro"
1818:             .ForeColor = RGB(36, 84, 155)
1819:             .BackColor = RGB(255, 255, 255)
1820:             .Themes = .T.
1821:             .Visible = .T.
1822:         ENDWITH
1823: 
1824:         par_oPag.AddObject("cmd_4c_RecFiltro", "CommandButton")
1825:         WITH par_oPag.cmd_4c_RecFiltro
1826:             .Top = 95
1827:             .Left = 569
1828:             .Width = 32
1829:             .Height = 32
1830:             .FontName = "Verdana"
1831:             .FontSize = 8
1832:             .WordWrap = .T.
1833:             .Caption = ""
1834:             .Picture = gc_4c_CaminhoIcones + "geral_disco2_26.jpg"
1835:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_disco2_26.jpg"
1836:             .ToolTipText = "Gravar Filtro"
1837:             .ForeColor = RGB(36, 84, 155)
1838:             .BackColor = RGB(255, 255, 255)
1839:             .Themes = .T.
1840:             .Visible = .T.
1841:         ENDWITH
1842: 
1843:         *-- F.Publicidade: Carregar clientes para a grade 1
1844:         par_oPag.AddObject("cmd_4c_Carregar", "CommandButton")
1845:         WITH par_oPag.cmd_4c_Carregar
1846:             .Top = 384
1847:             .Left = 843
1848:             .Width = 40
1849:             .Height = 40
1850:             .FontName = "Verdana"
1851:             .FontSize = 8
1852:             .WordWrap = .T.
1853:             .Caption = ""
1854:             .Picture = gc_4c_CaminhoIcones + "cadastro_seta_baixo_20.jpg"
1855:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_seta_baixo_20.jpg"
1856:             .ToolTipText = "Insere Linha Em Branco na Grade"
1857:             .ForeColor = RGB(36, 84, 155)
1858:             .BackColor = RGB(255, 255, 255)
1859:             .Themes = .T.
1860:             .Visible = .T.
1861:         ENDWITH
1862: 
1863:         BINDEVENT(par_oPag.cmd_4c_SelTudo,   "Click", THIS, "SelTudoClick")
1864:         BINDEVENT(par_oPag.cmd_4c_Apaga,     "Click", THIS, "ApagaClick")
1865:         BINDEVENT(par_oPag.cmd_4c_Inserir,   "Click", THIS, "BtnInserirClick")
1866:         BINDEVENT(par_oPag.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
1867:         BINDEVENT(par_oPag.cmd_4c_ApagaG1,   "Click", THIS, "BtnApagaG1Click")
1868:         BINDEVENT(par_oPag.cmd_4c_Inserir2,  "Click", THIS, "BtnInserir2Click")
1869:         BINDEVENT(par_oPag.cmd_4c_Excluir2,  "Click", THIS, "BtnExcluir2Click")
1870:         BINDEVENT(par_oPag.cmd_4c_ApagaG2,   "Click", THIS, "BtnApagaG2Click")
1871:         BINDEVENT(par_oPag.cmd_4c_AddFiltro, "Click", THIS, "CmdAddFiltroClick")
1872:         BINDEVENT(par_oPag.cmd_4c_DelFiltro, "Click", THIS, "CmdDelFiltroClick")
1873:         BINDEVENT(par_oPag.cmd_4c_RecFiltro, "Click", THIS, "BtnRecFiltroClick")
1874:         BINDEVENT(par_oPag.cmd_4c_Carregar,  "Click", THIS, "BtnCarregarClick")
1875:     ENDPROC
1876: 
1877:     *==========================================================================
1878:     * FASE 6 - Lookups de Page1 (Moeda Filtro/Conversao/Saldo, Forma de
1879:     * Publicidade, Especie da NF, Titulo Banco). Transcritos dos PROCEDURE

*-- Linhas 2265 a 2273:
2265:     * PRIMEIRA METADE dos campos de detalhe do registro selecionado na grade
2266:     * (Ordem/Nota Fiscal/Especie/Empresa/Emitente/Portador). A segunda metade
2267:     * dos campos (Centro de Custo/Agente Cobrador/Titulo Banco/Historico/
2268:     * Saldo Inicial/grupos/checkbox Totais/memo de filtros) e o grid
2269:     * grdDados1 ficam para a fase seguinte. Nomes e geometria transcritos de
2270:     * tasks\task691\SIGOPCGF_form_codigo_fonte.txt (SECAO 2).
2271:     *==========================================================================
2272: 
2273:     *--------------------------------------------------------------------------

*-- Linhas 2294 a 2504:
2294:     PROTECTED PROCEDURE ConfigurarBotoesAcaoDados(par_oPag)
2295:         par_oPag.AddObject("shp_4c_Shape1", "Shape")
2296:         WITH par_oPag.shp_4c_Shape1
2297:             .Top         = 83
2298:             .Left        = 6
2299:             .Width       = 462
2300:             .Height      = 88
2301:             .BackStyle   = 0
2302:             .BorderStyle = 0
2303:             .BorderColor = RGB(136, 189, 188)
2304:             .Visible     = .T.
2305:         ENDWITH
2306: 
2307:         *-- cmgRetornar - CommandGroup com 1 botao, volta para a Page1 (Filtros)
2308:         par_oPag.AddObject("obj_4c_CmgRetornar", "CommandGroup")
2309:         WITH par_oPag.obj_4c_CmgRetornar
2310:             .Top         = -2
2311:             .Left        = 918
2312:             .Width       = 85
2313:             .Height      = 85
2314:             .ButtonCount = 1
2315:             .BackStyle   = 0
2316:             .BorderStyle = 0
2317:             .Themes      = .F.
2318:             .Visible     = .T.
2319: 
2320:             WITH .Buttons(1)
2321:                 .Top         = 5
2322:                 .Left        = 5
2323:                 .Width       = 75
2324:                 .Height      = 75
2325:                 .FontName    = "Comic Sans MS"
2326:                 .FontSize    = 8
2327:                 .FontBold    = .T.
2328:                 .FontItalic  = .T.
2329:                 .Caption     = "Retornar"
2330:                 .ToolTipText = "Retornar aos Filtros"
2331:                 .ForeColor   = RGB(90, 90, 90)
2332:                 .BackColor   = RGB(255, 255, 255)
2333:                 .Themes      = .F.
2334:                 .Cancel      = .T.
2335:                 .Picture     = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
2336:             ENDWITH
2337:         ENDWITH
2338:         BINDEVENT(par_oPag.obj_4c_CmgRetornar, "Click", THIS, "CmgRetornarClick")
2339: 
2340:         *-- Recebimento
2341:         par_oPag.AddObject("cmd_4c_BtnRecebe", "CommandButton")
2342:         WITH par_oPag.cmd_4c_BtnRecebe
2343:             .Top             = 88
2344:             .Left            = 12
2345:             .Width           = 75
2346:             .Height          = 75
2347:             .FontName        = "Comic Sans MS"
2348:             .FontSize        = 8
2349:             .FontBold        = .T.
2350:             .FontItalic      = .T.
2351:             .Caption         = "\<Recebimento"
2352:             .ToolTipText     = "Recebimentos"
2353:             .ForeColor       = RGB(90, 90, 90)
2354:             .BackColor       = RGB(255, 255, 255)
2355:             .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
2356:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
2357:             .Themes          = .T.
2358:             .Visible         = .T.
2359:         ENDWITH
2360:         BINDEVENT(par_oPag.cmd_4c_BtnRecebe, "Click", THIS, "BtnRecebeClick")
2361: 
2362:         *-- Movimento
2363:         par_oPag.AddObject("cmd_4c_BtnMovimento", "CommandButton")
2364:         WITH par_oPag.cmd_4c_BtnMovimento
2365:             .Top             = 88
2366:             .Left            = 87
2367:             .Width           = 75
2368:             .Height          = 75
2369:             .FontName        = "Comic Sans MS"
2370:             .FontSize        = 8
2371:             .FontBold        = .T.
2372:             .FontItalic      = .T.
2373:             .Caption         = "\<Movimento"
2374:             .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o"
2375:             .ForeColor       = RGB(90, 90, 90)
2376:             .BackColor       = RGB(255, 255, 255)
2377:             .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
2378:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
2379:             .Themes          = .T.
2380:             .Visible         = .T.
2381:         ENDWITH
2382:         BINDEVENT(par_oPag.cmd_4c_BtnMovimento, "Click", THIS, "BtnMovimentoClick")
2383: 
2384:         *-- Follow-up da Conta
2385:         par_oPag.AddObject("cmd_4c_BtnFollowUpC", "CommandButton")
2386:         WITH par_oPag.cmd_4c_BtnFollowUpC
2387:             .Top             = 88
2388:             .Left            = 162
2389:             .Width           = 75
2390:             .Height          = 75
2391:             .FontName        = "Comic Sans MS"
2392:             .FontSize        = 8
2393:             .FontBold        = .T.
2394:             .FontItalic      = .T.
2395:             .WordWrap        = .T.
2396:             .Caption         = "Follo\<w-up Conta"
2397:             .ToolTipText     = "Follow-up da Conta "
2398:             .ForeColor       = RGB(90, 90, 90)
2399:             .BackColor       = RGB(255, 255, 255)
2400:             .Picture         = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
2401:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
2402:             .Themes          = .T.
2403:             .Visible         = .T.
2404:         ENDWITH
2405:         BINDEVENT(par_oPag.cmd_4c_BtnFollowUpC, "Click", THIS, "BtnFollowUpCClick")
2406: 
2407:         *-- Follow-up do Lancamento (Titulo)
2408:         par_oPag.AddObject("cmd_4c_BtnFollowUpL", "CommandButton")
2409:         WITH par_oPag.cmd_4c_BtnFollowUpL
2410:             .Top             = 88
2411:             .Left            = 237
2412:             .Width           = 75
2413:             .Height          = 75
2414:             .FontName        = "Comic Sans MS"
2415:             .FontSize        = 8
2416:             .FontBold        = .T.
2417:             .FontItalic      = .T.
2418:             .WordWrap        = .T.
2419:             .Caption         = "Follow-\<up Lan" + CHR(231) + "amento"
2420:             .ToolTipText     = "Follow-up do T" + CHR(237) + "tulo"
2421:             .ForeColor       = RGB(90, 90, 90)
2422:             .BackColor       = RGB(255, 255, 255)
2423:             .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
2424:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
2425:             .Themes          = .T.
2426:             .Visible         = .T.
2427:         ENDWITH
2428:         BINDEVENT(par_oPag.cmd_4c_BtnFollowUpL, "Click", THIS, "BtnFollowUpLClick")
2429: 
2430:         *-- Impressao
2431:         par_oPag.AddObject("cmd_4c_BtnImprimir", "CommandButton")
2432:         WITH par_oPag.cmd_4c_BtnImprimir
2433:             .Top             = 88
2434:             .Left            = 312
2435:             .Width           = 75
2436:             .Height          = 75
2437:             .FontName        = "Comic Sans MS"
2438:             .FontSize        = 8
2439:             .FontBold        = .T.
2440:             .FontItalic      = .T.
2441:             .Caption         = "Im\<press" + CHR(227) + "o"
2442:             .ToolTipText     = "Impress" + CHR(227) + "o"
2443:             .ForeColor       = RGB(90, 90, 90)
2444:             .BackColor       = RGB(255, 255, 255)
2445:             .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2446:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2447:             .Themes          = .T.
2448:             .Visible         = .T.
2449:         ENDWITH
2450:         BINDEVENT(par_oPag.cmd_4c_BtnImprimir, "Click", THIS, "BtnImprimirClick")
2451: 
2452:         *-- Planilha (Excel)
2453:         par_oPag.AddObject("cmd_4c_BtnPlanilha", "CommandButton")
2454:         WITH par_oPag.cmd_4c_BtnPlanilha
2455:             .Top             = 88
2456:             .Left            = 387
2457:             .Width           = 75
2458:             .Height          = 75
2459:             .FontName        = "Comic Sans MS"
2460:             .FontSize        = 8
2461:             .FontBold        = .T.
2462:             .FontItalic      = .T.
2463:             .Caption         = "Pla\<nilha"
2464:             .ToolTipText     = "Impress" + CHR(227) + "o"
2465:             .ForeColor       = RGB(90, 90, 90)
2466:             .BackColor       = RGB(255, 255, 255)
2467:             .Picture         = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
2468:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
2469:             .Themes          = .T.
2470:             .Visible         = .T.
2471:         ENDWITH
2472:         BINDEVENT(par_oPag.cmd_4c_BtnPlanilha, "Click", THIS, "BtnPlanilhaClick")
2473:     ENDPROC
2474: 
2475:     *--------------------------------------------------------------------------
2476:     * ConfigurarCamposDados1 - PRIMEIRA METADE dos campos de detalhe:
2477:     * combo de ordem da grade, Nota Fiscal, Especie, Empresa, Emitente e
2478:     * Portador (cada um com codigo + descricao). SCX: faixa Top=152..594,
2479:     * Left=17..992 (abaixo do grdDados1, que fica para a fase seguinte).
2480:     *--------------------------------------------------------------------------
2481:     PROTECTED PROCEDURE ConfigurarCamposDados1(par_oPag)
2482:         *-- Ordem da Grade (Moeda + ...)
2483:         par_oPag.AddObject("lbl_4c_Ordem", "Label")
2484:         WITH par_oPag.lbl_4c_Ordem
2485:             .Top       = 152
2486:             .Left      = 511
2487:             .Width     = 153
2488:             .AutoSize  = .T.
2489:             .FontName  = "Tahoma"
2490:             .FontSize  = 8
2491:             .ForeColor = RGB(90, 90, 90)
2492:             .Caption   = "\<Ordem da Grade (Moeda + ...) "
2493:             .Visible   = .T.
2494:         ENDWITH
2495: 
2496:         par_oPag.AddObject("cbo_4c_Ordem", "ComboBox")
2497:         WITH par_oPag.cbo_4c_Ordem
2498:             .Top               = 170
2499:             .Left              = 510
2500:             .Width             = 182
2501:             .Height            = 23
2502:             .Style             = 2
2503:             .RowSourceType     = 1
2504:             .RowSource         = "Emiss" + CHR(227) + "o,Vencimento,Lan" + CHR(231) + "amento,Baixa,Titulo,Historico,Emitente,Portador"

*-- Linhas 2514 a 2535:
2514:         BINDEVENT(par_oPag.cbo_4c_Ordem, "InteractiveChange", THIS, "CboOrdemInteractiveChange")
2515: 
2516:         *-- Nota Fiscal
2517:         par_oPag.AddObject("lbl_4c_NotaFiscal", "Label")
2518:         WITH par_oPag.lbl_4c_NotaFiscal
2519:             .Top       = 594
2520:             .Left      = 23
2521:             .FontName  = "Tahoma"
2522:             .ForeColor = RGB(90, 90, 90)
2523:             .Caption   = "Nota Fiscal :"
2524:             .Visible   = .T.
2525:         ENDWITH
2526: 
2527:         par_oPag.AddObject("txt_4c_NFs", "TextBox")
2528:         WITH par_oPag.txt_4c_NFs
2529:             .Top           = 590
2530:             .Left          = 89
2531:             .Width         = 100
2532:             .Height        = 23
2533:             .Value         = ""
2534:             .Format        = "K!"
2535:             .FontName      = "Tahoma"

*-- Linhas 2541 a 2591:
2541:         ENDWITH
2542: 
2543:         *-- Especie (da Nota Fiscal)
2544:         par_oPag.AddObject("lbl_4c_Especie", "Label")
2545:         WITH par_oPag.lbl_4c_Especie
2546:             .Top       = 594
2547:             .Left      = 212
2548:             .Width     = 45
2549:             .FontName  = "Tahoma"
2550:             .ForeColor = RGB(90, 90, 90)
2551:             .Caption   = "Esp" + CHR(233) + "cie :"
2552:             .Visible   = .T.
2553:         ENDWITH
2554: 
2555:         par_oPag.AddObject("txt_4c_EspecieNfs", "TextBox")
2556:         WITH par_oPag.txt_4c_EspecieNfs
2557:             .Top           = 590
2558:             .Left          = 262
2559:             .Width         = 52
2560:             .Height        = 23
2561:             .Value         = ""
2562:             .FontName      = "Tahoma"
2563:             .ForeColor     = RGB(0, 0, 0)
2564:             .SpecialEffect = 1
2565:             *-- legado getEspecieNfs (pgDados): When -> Return .f.
2566:             .ReadOnly      = .T.
2567:             .Visible       = .T.
2568:         ENDWITH
2569: 
2570:         *-- Empresa
2571:         par_oPag.AddObject("lbl_4c_Empresa", "Label")
2572:         WITH par_oPag.lbl_4c_Empresa
2573:             .Top       = 621
2574:             .Left      = 207
2575:             .Width     = 50
2576:             .Height    = 15
2577:             .FontName  = "Tahoma"
2578:             .ForeColor = RGB(90, 90, 90)
2579:             .Caption   = "Empresa :"
2580:             .Visible   = .T.
2581:         ENDWITH
2582: 
2583:         par_oPag.AddObject("txt_4c_Emps", "TextBox")
2584:         WITH par_oPag.txt_4c_Emps
2585:             .Top           = 617
2586:             .Left          = 262
2587:             .Width         = 52
2588:             .Height        = 23
2589:             .Value         = ""
2590:             .FontName      = "Tahoma"
2591:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 2597 a 2618:
2597:         ENDWITH
2598: 
2599:         *-- Emitente (codigo + razao social)
2600:         par_oPag.AddObject("lbl_4c_Emitente", "Label")
2601:         WITH par_oPag.lbl_4c_Emitente
2602:             .Top       = 568
2603:             .Left      = 403
2604:             .FontName  = "Tahoma"
2605:             .ForeColor = RGB(90, 90, 90)
2606:             .Caption   = "Emitente :"
2607:             .Visible   = .T.
2608:         ENDWITH
2609: 
2610:         par_oPag.AddObject("txt_4c_ContEms", "TextBox")
2611:         WITH par_oPag.txt_4c_ContEms
2612:             .Top           = 564
2613:             .Left          = 550
2614:             .Width         = 80
2615:             .Height        = 23
2616:             .Value         = ""
2617:             .FontName      = "Tahoma"
2618:             .FontSize      = 8

*-- Linhas 2624 a 2647:
2624:             .Visible       = .T.
2625:         ENDWITH
2626: 
2627:         par_oPag.AddObject("lbl_4c_BarraEmitente", "Label")
2628:         WITH par_oPag.lbl_4c_BarraEmitente
2629:             .Top       = 566
2630:             .Left      = 540
2631:             .FontName  = "Tahoma"
2632:             .FontSize  = 10
2633:             .FontBold  = .T.
2634:             .ForeColor = RGB(90, 90, 90)
2635:             .Caption   = "/"
2636:             .Visible   = .T.
2637:         ENDWITH
2638: 
2639:         par_oPag.AddObject("txt_4c_DContEms", "TextBox")
2640:         WITH par_oPag.txt_4c_DContEms
2641:             .Top           = 564
2642:             .Left          = 632
2643:             .Width         = 360
2644:             .Height        = 23
2645:             .Value         = ""
2646:             .FontName      = "Tahoma"
2647:             .FontSize      = 8

*-- Linhas 2653 a 2702:
2653:         ENDWITH
2654: 
2655:         *-- Portador (codigo + razao social)
2656:         par_oPag.AddObject("lbl_4c_Portador", "Label")
2657:         WITH par_oPag.lbl_4c_Portador
2658:             .Top       = 594
2659:             .Left      = 403
2660:             .FontName  = "Tahoma"
2661:             .ForeColor = RGB(90, 90, 90)
2662:             .Caption   = "Portador :"
2663:             .Visible   = .T.
2664:         ENDWITH
2665: 
2666:         par_oPag.AddObject("txt_4c_Contas", "TextBox")
2667:         WITH par_oPag.txt_4c_Contas
2668:             .Top           = 590
2669:             .Left          = 550
2670:             .Width         = 80
2671:             .Height        = 23
2672:             .Value         = ""
2673:             .FontName      = "Tahoma"
2674:             .FontSize      = 8
2675:             .ForeColor     = RGB(0, 0, 0)
2676:             .SpecialEffect = 1
2677:             *-- legado getContas (pgDados): When -> Return .f.
2678:             .ReadOnly      = .T.
2679:             .Visible       = .T.
2680:         ENDWITH
2681: 
2682:         par_oPag.AddObject("lbl_4c_BarraPortador", "Label")
2683:         WITH par_oPag.lbl_4c_BarraPortador
2684:             .Top       = 592
2685:             .Left      = 540
2686:             .FontName  = "Tahoma"
2687:             .FontSize  = 10
2688:             .FontBold  = .T.
2689:             .ForeColor = RGB(90, 90, 90)
2690:             .Caption   = "/"
2691:             .Visible   = .T.
2692:         ENDWITH
2693: 
2694:         par_oPag.AddObject("txt_4c_DContas", "TextBox")
2695:         WITH par_oPag.txt_4c_DContas
2696:             .Top           = 590
2697:             .Left          = 632
2698:             .Width         = 360
2699:             .Height        = 23
2700:             .Value         = ""
2701:             .FontName      = "Tahoma"
2702:             .FontSize      = 8

*-- Linhas 2712 a 2734:
2712:     * ConfigurarCamposDados2 - SEGUNDA METADE dos campos de detalhe: Grupo do
2713:     * Emitente/Portador (ao lado dos codigos ja criados em
2714:     * ConfigurarCamposDados1), Centro de Custo, Agente Cobrador, Historico,
2715:     * Titulo Banco, Saldo Inicial, checkbox Totais e memo de filtros
2716:     * aplicados. Todos espelham a linha selecionada em grd_4c_Dados (grid
2717:     * ainda nao criado - PROCEDURE When do legado retorna .F. em TODOS estes
2718:     * campos, ou seja, nunca sao digitaveis pelo usuario) - por isso
2719:     * ReadOnly = .T.. O grid grdDados1 e o preenchimento destes campos
2720:     * (AfterRowColChange) ficam para a fase de eventos/acoes, junto com
2721:     * Processamento/MontaGraded/CalcSaldo/Imprimir/Planilha (regra do SCX:
2722:     * esses sao os metodos customizados do form, listados no ClassInfo).
2723:     *--------------------------------------------------------------------------
2724:     PROTECTED PROCEDURE ConfigurarCamposDados2(par_oPag)
2725:         *-- Grupo do Emitente (ao lado de txt_4c_ContEms, ja criado)
2726:         par_oPag.AddObject("txt_4c_GrupEms", "TextBox")
2727:         WITH par_oPag.txt_4c_GrupEms
2728:             .Top           = 564
2729:             .Left          = 459
2730:             .Width         = 80
2731:             .Height        = 23
2732:             .Value         = ""
2733:             .Format        = "K!"
2734:             .FontName      = "Tahoma"

*-- Linhas 2741 a 2776:
2741:         *-- Grupo do Portador (ao lado de txt_4c_Contas, ja criado)
2742:         par_oPag.AddObject("txt_4c_Grupo", "TextBox")
2743:         WITH par_oPag.txt_4c_Grupo
2744:             .Top           = 590
2745:             .Left          = 459
2746:             .Width         = 80
2747:             .Height        = 23
2748:             .Value         = ""
2749:             .Format        = "K!"
2750:             .FontName      = "Tahoma"
2751:             .ForeColor     = RGB(0, 0, 0)
2752:             .SpecialEffect = 1
2753:             .ReadOnly      = .T.
2754:             .Visible       = .T.
2755:         ENDWITH
2756: 
2757:         *-- Centro de Custo (Grupo + codigo + "/" + descricao)
2758:         par_oPag.AddObject("lbl_4c_CentroCusto", "Label")
2759:         WITH par_oPag.lbl_4c_CentroCusto
2760:             .Top       = 621
2761:             .Left      = 366
2762:             .FontName  = "Tahoma"
2763:             .ForeColor = RGB(90, 90, 90)
2764:             .Caption   = "Centro de Custo :"
2765:             .Visible   = .T.
2766:         ENDWITH
2767: 
2768:         par_oPag.AddObject("txt_4c_SGrupos", "TextBox")
2769:         WITH par_oPag.txt_4c_SGrupos
2770:             .Top           = 617
2771:             .Left          = 459
2772:             .Width         = 80
2773:             .Height        = 23
2774:             .Value         = ""
2775:             .Format        = "K!"
2776:             .FontName      = "Tahoma"

*-- Linhas 2782 a 2844:
2782: 
2783:         par_oPag.AddObject("txt_4c_SContas", "TextBox")
2784:         WITH par_oPag.txt_4c_SContas
2785:             .Top           = 617
2786:             .Left          = 550
2787:             .Width         = 80
2788:             .Height        = 23
2789:             .Value         = ""
2790:             .FontName      = "Tahoma"
2791:             .FontSize      = 8
2792:             .ForeColor     = RGB(0, 0, 0)
2793:             .SpecialEffect = 1
2794:             .ReadOnly      = .T.
2795:             .Visible       = .T.
2796:         ENDWITH
2797: 
2798:         par_oPag.AddObject("lbl_4c_BarraCentroCusto", "Label")
2799:         WITH par_oPag.lbl_4c_BarraCentroCusto
2800:             .Top       = 619
2801:             .Left      = 540
2802:             .FontName  = "Tahoma"
2803:             .FontSize  = 10
2804:             .FontBold  = .T.
2805:             .ForeColor = RGB(90, 90, 90)
2806:             .Caption   = "/"
2807:             .Visible   = .T.
2808:         ENDWITH
2809: 
2810:         par_oPag.AddObject("txt_4c_DSContas", "TextBox")
2811:         WITH par_oPag.txt_4c_DSContas
2812:             .Top           = 617
2813:             .Left          = 632
2814:             .Width         = 360
2815:             .Height        = 23
2816:             .Value         = ""
2817:             .FontName      = "Tahoma"
2818:             .FontSize      = 8
2819:             .ForeColor     = RGB(0, 0, 0)
2820:             .SpecialEffect = 1
2821:             .ReadOnly      = .T.
2822:             .Visible       = .T.
2823:         ENDWITH
2824: 
2825:         *-- Agente Cobrador (Grupo + codigo + "/" + descricao)
2826:         par_oPag.AddObject("lbl_4c_AgenteCobrador", "Label")
2827:         WITH par_oPag.lbl_4c_AgenteCobrador
2828:             .Top       = 648
2829:             .Left      = 362
2830:             .FontName  = "Tahoma"
2831:             .ForeColor = RGB(90, 90, 90)
2832:             .Caption   = "Agente Cobrador :"
2833:             .Visible   = .T.
2834:         ENDWITH
2835: 
2836:         par_oPag.AddObject("txt_4c_GrupAges", "TextBox")
2837:         WITH par_oPag.txt_4c_GrupAges
2838:             .Top           = 644
2839:             .Left          = 459
2840:             .Width         = 80
2841:             .Height        = 23
2842:             .Value         = ""
2843:             .Format        = "K!"
2844:             .FontName      = "Tahoma"

*-- Linhas 2850 a 2971:
2850: 
2851:         par_oPag.AddObject("txt_4c_ContAges", "TextBox")
2852:         WITH par_oPag.txt_4c_ContAges
2853:             .Top           = 644
2854:             .Left          = 550
2855:             .Width         = 80
2856:             .Height        = 23
2857:             .Value         = ""
2858:             .FontName      = "Tahoma"
2859:             .FontSize      = 8
2860:             .ForeColor     = RGB(0, 0, 0)
2861:             .SpecialEffect = 1
2862:             .ReadOnly      = .T.
2863:             .Visible       = .T.
2864:         ENDWITH
2865: 
2866:         par_oPag.AddObject("lbl_4c_BarraAgenteCobrador", "Label")
2867:         WITH par_oPag.lbl_4c_BarraAgenteCobrador
2868:             .Top       = 646
2869:             .Left      = 540
2870:             .FontName  = "Tahoma"
2871:             .FontSize  = 10
2872:             .FontBold  = .T.
2873:             .ForeColor = RGB(90, 90, 90)
2874:             .Caption   = "/"
2875:             .Visible   = .T.
2876:         ENDWITH
2877: 
2878:         par_oPag.AddObject("txt_4c_DContAges", "TextBox")
2879:         WITH par_oPag.txt_4c_DContAges
2880:             .Top           = 644
2881:             .Left          = 632
2882:             .Width         = 360
2883:             .Height        = 23
2884:             .Value         = ""
2885:             .FontName      = "Tahoma"
2886:             .FontSize      = 8
2887:             .ForeColor     = RGB(0, 0, 0)
2888:             .SpecialEffect = 1
2889:             .ReadOnly      = .T.
2890:             .Visible       = .T.
2891:         ENDWITH
2892: 
2893:         *-- Historico
2894:         par_oPag.AddObject("lbl_4c_Historico", "Label")
2895:         WITH par_oPag.lbl_4c_Historico
2896:             .Top       = 568
2897:             .Left      = 34
2898:             .Width     = 50
2899:             .AutoSize  = .T.
2900:             .FontName  = "Tahoma"
2901:             .FontSize  = 8
2902:             .ForeColor = RGB(90, 90, 90)
2903:             .Caption   = "Hist" + CHR(243) + "rico :"
2904:             .Visible   = .T.
2905:         ENDWITH
2906: 
2907:         par_oPag.AddObject("txt_4c_Hist2s", "TextBox")
2908:         WITH par_oPag.txt_4c_Hist2s
2909:             .Top           = 564
2910:             .Left          = 89
2911:             .Width         = 290
2912:             .Height        = 23
2913:             .Value         = ""
2914:             .FontName      = "Tahoma"
2915:             .ForeColor     = RGB(0, 0, 0)
2916:             .SpecialEffect = 1
2917:             .ReadOnly      = .T.
2918:             .Visible       = .T.
2919:         ENDWITH
2920: 
2921:         *-- Titulo Banco
2922:         par_oPag.AddObject("lbl_4c_TituloBanco", "Label")
2923:         WITH par_oPag.lbl_4c_TituloBanco
2924:             .Top       = 621
2925:             .Left      = 17
2926:             .Width     = 67
2927:             .Height    = 15
2928:             .FontName  = "Tahoma"
2929:             .ForeColor = RGB(90, 90, 90)
2930:             .Caption   = "T" + CHR(237) + "tulo Banco :"
2931:             .Visible   = .T.
2932:         ENDWITH
2933: 
2934:         par_oPag.AddObject("txt_4c_TitBans", "TextBox")
2935:         WITH par_oPag.txt_4c_TitBans
2936:             .Top           = 617
2937:             .Left          = 89
2938:             .Width         = 100
2939:             .Height        = 23
2940:             .Value         = ""
2941:             .FontName      = "Tahoma"
2942:             .FontSize      = 8
2943:             .ForeColor     = RGB(0, 0, 0)
2944:             .SpecialEffect = 1
2945:             .ReadOnly      = .T.
2946:             .Visible       = .T.
2947:         ENDWITH
2948: 
2949:         *-- Saldo Inicial
2950:         par_oPag.AddObject("lbl_4c_SaldoInicial", "Label")
2951:         WITH par_oPag.lbl_4c_SaldoInicial
2952:             .Top       = 648
2953:             .Left      = 19
2954:             .Width     = 65
2955:             .AutoSize  = .T.
2956:             .FontName  = "Tahoma"
2957:             .FontSize  = 8
2958:             .ForeColor = RGB(90, 90, 90)
2959:             .Caption   = "Saldo Inicial :"
2960:             .Visible   = .T.
2961:         ENDWITH
2962: 
2963:         par_oPag.AddObject("txt_4c_ValOcurs", "TextBox")
2964:         WITH par_oPag.txt_4c_ValOcurs
2965:             .Top           = 644
2966:             .Left          = 89
2967:             .Width         = 100
2968:             .Height        = 23
2969:             .Alignment     = 1
2970:             .Value         = 0
2971:             .Format        = "K"

*-- Linhas 2980 a 3006:
2980: 
2981:         *-- Exibir Totalizadores (chkTotais) - liga/desliga totalizadores na
2982:         *-- ordenacao da grade (OrdenaGrade, fase de eventos/acoes)
2983:         par_oPag.AddObject("chk_4c_Totais", "CheckBox")
2984:         WITH par_oPag.chk_4c_Totais
2985:             .Top         = 174
2986:             .Left        = 697
2987:             .Caption     = "E\<xibir Totalizadores"
2988:             .Value       = 1
2989:             .FontName    = "Tahoma"
2990:             .ForeColor   = RGB(90, 90, 90)
2991:             .BackStyle   = 0
2992:             .Visible     = .T.
2993:         ENDWITH
2994:         BINDEVENT(par_oPag.chk_4c_Totais, "Click", THIS, "ChkTotaisClick")
2995: 
2996:         *-- Memo com a descricao dos filtros aplicados na consulta (somente
2997:         *-- exibicao - alterna altura 66/200 ao clicar, igual ao legado)
2998:         par_oPag.AddObject("obj_4c_GetFiltros", "EditBox")
2999:         WITH par_oPag.obj_4c_GetFiltros
3000:             .Top           = 83
3001:             .Left          = 510
3002:             .Width         = 381
3003:             .Height        = 66
3004:             .Value         = ""
3005:             .ReadOnly      = .T.
3006:             .FontName      = "Tahoma"

*-- Linhas 3014 a 3033:
3014:         *-- digitaveis (PROCEDURE When do legado retorna .f. nos 4).
3015:         par_oPag.AddObject("cnt_4c_Botoes", "Container")
3016:         WITH par_oPag.cnt_4c_Botoes
3017:             .Top         = 643
3018:             .Left        =  542
3019:             .Width       = 115
3020:             .Height      = 24
3021:             .BackStyle   = 0
3022:             .BorderWidth = 0
3023:             .Visible     = .T.
3024: 
3025:             .AddObject("txt_4c_Botao1", "TextBox")
3026:             WITH .txt_4c_Botao1
3027:                 .Top         = 1
3028:                 .Left        = 1
3029:                 .Width       = 29
3030:                 .Height      = 23
3031:                 .Alignment   = 0
3032:                 .Value       = ""
3033:                 .FontBold    = .T.

*-- Linhas 3042 a 3051:
3042: 
3043:             .AddObject("txt_4c_Botao2", "TextBox")
3044:             WITH .txt_4c_Botao2
3045:                 .Top         = 1
3046:                 .Left        = 29
3047:                 .Width       = 29
3048:                 .Height      = 23
3049:                 .Alignment   = 0
3050:                 .Value       = ""
3051:                 .FontBold    = .T.

*-- Linhas 3060 a 3069:
3060: 
3061:             .AddObject("txt_4c_Botao3", "TextBox")
3062:             WITH .txt_4c_Botao3
3063:                 .Top         = 1
3064:                 .Left        = 57
3065:                 .Width       = 29
3066:                 .Height      = 23
3067:                 .Alignment   = 0
3068:                 .Value       = ""
3069:                 .FontBold    = .T.

*-- Linhas 3078 a 3087:
3078: 
3079:             .AddObject("txt_4c_Botao4", "TextBox")
3080:             WITH .txt_4c_Botao4
3081:                 .Top         = 1
3082:                 .Left        = 86
3083:                 .Width       = 29
3084:                 .Height      = 23
3085:                 .Alignment   = 0
3086:                 .Value       = ""
3087:                 .FontBold    = .T.

*-- Linhas 3323 a 3332:
3323: 
3324:     *--------------------------------------------------------------------------
3325:     * AlternarFlagGrade - Alterna (0<->1) a coluna de flag de uma linha de
3326:     * grade (equivalente ao padrao de checkbox de Column regra #46/#185 -
3327:     * toggle feito por codigo, nunca pelo binding nativo do CheckBox).
3328:     *--------------------------------------------------------------------------
3329:     PROTECTED PROCEDURE AlternarFlagGrade(par_cCursor, par_cCampo, par_oGrid)
3330:         IF USED(par_cCursor)
3331:             SELECT (par_cCursor)
3332:             IF !EOF()

*-- Linhas 3885 a 3894:
3885:     PROTECTED PROCEDURE ConfigurarGradeDados(par_oPag)
3886:         par_oPag.AddObject("grd_4c_Dados", "Grid")
3887:         WITH par_oPag.grd_4c_Dados
3888:             .Top               = 202
3889:             .Left              = 7
3890:             .Width             = 986
3891:             .Height            = 355
3892:             .DeleteMark        = .F.
3893:             .RecordMark        = .F.
3894:             .ReadOnly          = .T.

*-- Linhas 3924 a 3978:
3924: 
3925:             .Column1.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtEmis)))"
3926:             .Column1.Width           = 64
3927:             .Column1.Header1.Caption = "Emiss" + CHR(227) + "o"
3928: 
3929:             .Column2.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Vencs)))"
3930:             .Column2.Width           = 64
3931:             .Column2.Header1.Caption = "Vencto."
3932: 
3933:             .Column3.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Datas)))"
3934:             .Column3.Width           = 64
3935:             .Column3.Header1.Caption = "Lancto."
3936: 
3937:             .Column4.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtBaixa)))"
3938:             .Column4.Width           = 64
3939:             .Column4.Header1.Caption = "Baixa"
3940: 
3941:             .Column5.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', " + loc_cCursor + ".Titulos)"
3942:             .Column5.Width           = 70
3943:             .Column5.Header1.Caption = "T" + CHR(237) + "tulo"
3944: 
3945:             .Column6.ControlSource   = loc_cCursor + ".Hists"
3946:             .Column6.Width           = 240
3947:             .Column6.Header1.Caption = "Hist" + CHR(243) + "rico"
3948: 
3949:             .Column7.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997, '', " + loc_cCursor + ".Moedas)"
3950:             .Column7.Width           = 20
3951:             .Column7.Header1.Caption = "$"
3952: 
3953:             .Column8.ControlSource   = loc_cCursor + ".Valors"
3954:             .Column8.Width           = 68
3955:             .Column8.Header1.Caption = "Valor"
3956: 
3957:             *-- Legado usa goSistema.TxtDebito/TxtCredito (rotulo customizavel
3958:             *-- por cliente) - essa customizacao NAO foi portada; caption fixo.
3959:             .Column9.ControlSource   = loc_cCursor + ".Debitos"
3960:             .Column9.Width           = 68
3961:             .Column9.Header1.Caption = "D" + CHR(233) + "bito"
3962: 
3963:             .Column10.ControlSource   = loc_cCursor + ".Creditos"
3964:             .Column10.Width           = 68
3965:             .Column10.Header1.Caption = "Cr" + CHR(233) + "dito"
3966: 
3967:             .Column11.ControlSource   = loc_cCursor + ".SaldoDia"
3968:             .Column11.Width           = 82
3969:             .Column11.Header1.Caption = "Saldo"
3970: 
3971:             .Column12.ControlSource   = loc_cCursor + ".SaldoTot"
3972:             .Column12.Width           = 82
3973:             .Column12.Header1.Caption = "Acumulado"
3974: 
3975:             .SetAll("DynamicBackColor", loc_cCor, "Column")
3976:             .FontName = "Arial"
3977:             .SetAll("Movable", .F., "Column")
3978:             .SetAll("Resizable", .F., "Column")

*-- Linhas 5595 a 5610:
5595:             loc_lHabilita = (loc_oBO.this_nLinNopers < 9999998) AND (loc_oBO.this_nLinSInis = 0)
5596:         ENDIF
5597: 
5598:         loc_oPag.cmd_4c_BtnMovimento.Enabled = loc_lHabilita
5599:         loc_oPag.cmd_4c_BtnRecebe.Enabled    = loc_lHabilita
5600:         loc_oPag.cmd_4c_BtnFollowUpC.Enabled = loc_lHabilita
5601:         loc_oPag.cmd_4c_BtnFollowUpL.Enabled = loc_lHabilita
5602: 
5603:         *-- O When do Imprimir tambem libera quando a ordem corrente e por
5604:         *-- Emitente/Portador (saldo por conta), mesmo em linha sintetica.
5605:         loc_oPag.cmd_4c_BtnImprimir.Enabled = loc_lHabilita OR ;
5606:             INLIST(loc_oBO.this_cOrdem, "ContEms", "Contas")
5607:     ENDPROC
5608: 
5609:     *--------------------------------------------------------------------------
5610:     * LimparCampos - Bloco de limpeza que o legado executa no inicio do

*-- Linhas 5737 a 5745:
5737:     * SerializarFiltros() (gravacao do filtro nomeado em SigSyPar) e por
5738:     * RestaurarFiltros() (para preservar o que nao esta no blob salvo).
5739:     *
5740:     * Conversoes explicitas obrigatorias: CheckBox.Value e NUMERICO (0/1) e
5741:     * nao pode ser atribuido direto a property LOGICA; OptionGroup.Value e o
5742:     * INDICE 1-based e vai para property NUMERICA; o TextBox de valor pode
5743:     * trazer CARACTERE conforme o InputMask, dai o VARTYPE antes de usar.
5744:     *--------------------------------------------------------------------------
5745:     PROTECTED PROCEDURE FormParaBO()

*-- Linhas 5784 a 5792:
5784:         loc_oBO.this_cDFPublis = ALLTRIM(loc_oPag1.txt_4c_DFPublis.Value)
5785:         loc_oBO.this_cEmpresa  = ALLTRIM(loc_oPag1.txt_4c_Empresa.Value)
5786: 
5787:         *-- CheckBox.Value e NUMERICO - converter antes de ir para property logica
5788:         loc_oBO.this_lBrancos  = (loc_oPag1.chk_4c_Brancos.Value = 1)
5789:         loc_oBO.this_lValPends = (loc_oPag1.chk_4c_ValPends.Value = 1)
5790:         loc_oBO.this_lTotais   = (loc_oPag2.chk_4c_Totais.Value = 1)
5791: 
5792:         *-- OptionGroup.Value e o INDICE 1-based do botao selecionado

*-- Linhas 5816 a 5824:
5816:     *
5817:     * OptionGroup/ComboBox sao 1-based: o valor e sempre validado com BETWEEN
5818:     * para nunca atribuir 0 a um controle de indice (regra dos controles
5819:     * 1-based do CLAUDE.md). CheckBox recebe NUMERICO (1/0), nunca .T./.F.
5820:     *--------------------------------------------------------------------------
5821:     PROTECTED PROCEDURE BOParaForm()
5822:         LOCAL loc_oPag1, loc_oPag2, loc_oBO
5823: 
5824:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)


### BO (C:\4c\projeto\app\classes\SIGOPCGFBO.prg):
*============================================================================
* SIGOPCGFBO.prg - Business Object para Consulta Global Financeira
*
* Form OPERACIONAL (sem tabela/PK unica) - consulta sobre titulos financeiros
* (SigCdPit) movimentados contra contas (SigCdCli), com filtros amplos de
* data, titulo, moeda, publicidade, empresa e grupos de contas selecionaveis
* em duas grades auxiliares (equivalentes a TmpCliente/TmpCliente2 do legado).
*
* Legado  : SIGOPCGF.SCX (form generico "form", NAO frmcadastro)
* Cursores de trabalho (equivalentes ao LocalDados/LocalTotais/crSigOpOpe/
* TmpCliente/TmpCliente2/TmpContas/crFiltros do legado):
*   cursor_4c_Dados     - resultado da consulta (um registro por titulo)
*   cursor_4c_Totais    - estrutura vazia usada para acumular totalizadores
*   cursor_4c_Tipos     - tipos de operacao de titulo (SigOpOpe) com flag de
*                         selecao (Imps) para o filtro por tipo de movimento
*   cursor_4c_Clientes  - grade 1 de contas/grupos selecionaveis no filtro
*   cursor_4c_Clientes2 - grade 2 de contas/grupos selecionaveis no filtro
*   cursor_4c_Contas    - cache de contas (IClis/RClis) usado pelas grades
*   cursor_4c_Filtros   - filtros nomeados salvos (SigSyPar)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SIGOPCGFBO AS BusinessBase

    *==========================================================================
    * Nomes dos cursores de trabalho (constantes de instancia - usados pelos
    * metodos de carga/consulta criados nas proximas fases)
    *==========================================================================
    this_cCursorDados     = "cursor_4c_Dados"
    this_cCursorTotais    = "cursor_4c_Totais"
    this_cCursorTipos     = "cursor_4c_Tipos"
    this_cCursorClientes  = "cursor_4c_Clientes"
    this_cCursorClientes2 = "cursor_4c_Clientes2"
    this_cCursorContas    = "cursor_4c_Contas"
    this_cCursorFiltros   = "cursor_4c_Filtros"

    *==========================================================================
    * Filtros de data (getDtEmiI/F, getVencsI/F, getDatasI/F, getDtBxI/F)
    *==========================================================================
    this_dDtEmiI = {}    && Emissao - de
    this_dDtEmiF = {}    && Emissao - ate
    this_dVencsI = {}    && Vencimento - de
    this_dVencsF = {}    && Vencimento - ate
    this_dDatasI = {}    && Lancamento - de
    this_dDatasF = {}    && Lancamento - ate
    this_dDtBxI  = {}    && Baixa - de
    this_dDtBxF  = {}    && Baixa - ate

    *==========================================================================
    * Filtros de texto/codigo (getTitulos, getTitBans, getEspecieNfs, getNFs)
    *==========================================================================
    this_cTitulos    = ""    && Titulo (SigCdPit.Titulos)
    this_cTitBans    = ""    && Titulo Banco (SigCdPgr.FPags, busca local fwBuscaSel)
    this_cEspecieNfs = ""    && Especie da NF - codigo (SigCdEsp.Especies)
    this_cNFs        = ""    && Numero da Nota Fiscal

    *==========================================================================
    * Moeda (getCMoes/getDMoes, getCMoesC/getDMoesC, getMoeSaldo)
    *==========================================================================
    this_cCMoes    = ""    && Moeda Filtro - codigo (SigCdMoe.CMoes)
    this_cDMoes    = ""    && Moeda Filtro - descricao (SigCdMoe.DMoes)
    this_cCMoesC   = ""    && Moeda Conversao - codigo (SigCdMoe.CMoes)
    this_cDMoesC   = ""    && Moeda Conversao - descricao (SigCdMoe.DMoes)
    this_cMoeSaldo = ""    && Moeda do Saldo Inicial - codigo (SigCdMoe.CMoes)
    this_nSaldo    = 0     && Saldo Inicial (valor digitado pelo usuario)

    *==========================================================================
    * Publicidade (getCFPublis/getDFPublis)
    *==========================================================================
    this_cCFPublis = ""    && Forma de Publicidade - codigo (SigCdFpb.Cods)
    this_cDFPublis = ""    && Forma de Publicidade - descricao (SigCdFpb.Descs)

    *==========================================================================
    * Empresa (Get_Empresa)
    *==========================================================================
    this_cEmpresa = ""    && Empresa - codigo (SigCdEmp.Cemps)

    *==========================================================================
    * Flags de filtro (chkBrancos, chkValpags, chkTotais)
    *==========================================================================
    this_lBrancos  = .F.    && Branco (chkBrancos) - filtra lancamentos em branco
    this_lValPends = .F.    && Valor Pendente (chkValpags)
    this_lTotais   = .T.    && Exibir Totalizadores (chkTotais)

    *==========================================================================
    * OptionGroups de filtro - indice 1-based, espelha o Value do grupo
    * (optPagos, optOpcao, optCotEm, optCancs, optConcs, optProrrogs,
    * optFilGrd2)
    *==========================================================================
    this_nPagos    = 1    && Pagamento (3 opcoes)
    this_nOpcao    = 1    && Opcao (3 opcoes)
    this_nCotEm    = 1    && Conversao em (5 opcoes)
    this_nCancs    = 1    && Cancelamento (3 opcoes)
    this_nConcs    = 1    && Conciliacao (3 opcoes)
    this_nProrrogs = 1    && Prorrogacao (3 opcoes)
    this_nFilGrd2  = 1    && Filtro da grade 2 (2 opcoes)

    *==========================================================================
    * Ordenacao da grade de resultado (cmbOrdem.Value + ThisForm.Ordem legado)
    *==========================================================================
    this_nOrdem = 1          && Indice selecionado no combo de ordem
    this_cOrdem = "DtEmis"   && Nome da coluna correspondente, usado no SET ORDER

    *==========================================================================
    * Filtro nomeado (getFiltros/getNewFiltro - SigSyPar)
    *==========================================================================
    this_cFiltros   = ""    && Nome do filtro selecionado/carregado
    this_cNewFiltro = ""    && Nome digitado ao cadastrar um novo filtro

    *==========================================================================
    * Totalizadores calculados sobre cursor_4c_Dados (CalcSaldo/CalcSaldoCta)
    *==========================================================================
    this_nSaldoDia = 0
    this_nSaldoTot = 0
    this_nDebitos  = 0
    this_nCreditos = 0

    *==========================================================================
    * Linha corrente de cursor_4c_Dados (equivalente ao registro corrente de
    * LocalDados no legado) - carregada por CarregarDoCursor() quando o
    * usuario seleciona uma linha na grade, e consumida pelos botoes de
    * acao (Movimento/Recebimento/FollowUp/Imprimir) das proximas fases.
    *==========================================================================
    this_nLinNopers     = 0     && Numero da operacao (chave de navegacao)
    this_cLinTipos      = ""    && Tipo do lancamento
    this_nLinSaldoDia   = 0     && Saldo do dia (linha)
    this_nLinSaldoTot   = 0     && Saldo total/progressivo (linha)
    this_nLinDebitos    = 0     && Debito (linha)
    this_nLinCreditos   = 0     && Credito (linha)
    this_cLinContaCobs  = ""    && Conta cobradora
    this_cLinGrupos     = ""    && Grupo da conta
    this_cLinContas     = ""    && Codigo da conta/portador
    this_cLinContEms    = ""    && Codigo do emitente/cliente
    this_cLinOrdHs      = ""    && Ordem do historico
    this_cLinHists      = ""    && Historico
    this_cLinHist2s     = ""    && Historico complementar
    this_cLinNFs        = ""    && Nota Fiscal
    this_dLinDatas      = {}    && Data de lancamento
    this_dLinVencs      = {}    && Data de vencimento
    this_dLinDtEmis     = {}    && Data de emissao
    this_dLinDtBaixa    = {}    && Data de baixa
    this_cLinTitulos    = ""    && Numero do titulo
    this_cLinMoedas     = ""    && Codigo da moeda
    this_nLinSInis      = 0     && Flag "e totalizador/sintetico" (SInis)
    this_cLinRClis      = ""    && Razao social do cliente/emitente
    this_cLinEmps       = ""    && Empresa (chave de movimento)
    this_cLinDopes      = ""    && Documento de origem (chave de movimento)
    this_nLinNumes      = 0     && Numero do movimento (chave de movimento)
    this_cLinVOpers     = ""    && Movimento vinculado (ContEms+Numos)
    this_nLinAcertos    = 0     && Flag de acerto (usado no Recebimento)
    this_cLinGrupEms    = ""    && Grupo do emitente
    this_cLinSGrupos    = ""    && Grupo do centro de custo
    this_cLinSContas    = ""    && Codigo do centro de custo
    this_cLinGrupAges   = ""    && Grupo do agente cobrador
    this_cLinContAges   = ""    && Codigo do agente cobrador
    this_cLinTitBans    = ""    && Titulo no banco (SigCdPgr.FPags)
    this_cLinEspecieNfs = ""    && Especie da Nota Fiscal
    this_nLinValOcurs   = 0     && Valor ocorrido
    this_nLinTitCancs   = 0     && Flag "titulo cancelado" (Botao1)
    this_cLinPagos      = ""    && Flag/codigo de pagamento - "0"=pendente (Botao2)
    this_lLinConcs      = .F.   && Flag "titulo conciliado" (Botao3)
    this_dLinProrrogs   = {}    && Data de prorrogacao, vazia = nao prorrogado (Botao4)

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Form de consulta sem tabela/PK unica (nao eh CRUD) - this_cTabela e
    * this_cCampoChave ficam vazios de proposito; a consulta principal eh
    * montada dinamicamente (varias tabelas) nos metodos das proximas fases.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha CORRENTE de cursor_4c_Dados (grade
    * de resultado da consulta) para as propriedades this_nLin*/this_cLin*/
    * this_dLin*, equivalente a ler LocalDados.<campo> diretamente no legado
    * (AfterRowColChange/Click dos botoes de acao). Chamado pelo Form sempre
    * que a linha selecionada na grade mudar.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF EOF() OR BOF()
            RETURN .F.
        ENDIF

        THIS.this_nLinNopers    = TratarNulo(Nopers, 0)
        THIS.this_cLinTipos     = TratarNulo(Tipos, "")
        THIS.this_nLinSaldoDia  = TratarNulo(SaldoDia, 0)
        THIS.this_nLinSaldoTot  = TratarNulo(SaldoTot, 0)
        THIS.this_nLinDebitos   = TratarNulo(Debitos, 0)
        THIS.this_nLinCreditos  = TratarNulo(Creditos, 0)
        THIS.this_cLinContaCobs = TratarNulo(ContaCobs, "")
        THIS.this_cLinGrupos    = TratarNulo(Grupos, "")
        THIS.this_cLinContas    = TratarNulo(Contas, "")
        THIS.this_cLinContEms   = TratarNulo(ContEms, "")
        THIS.this_cLinOrdHs     = TratarNulo(OrdHs, "")
        THIS.this_cLinHists     = TratarNulo(Hists, "")
        THIS.this_cLinHist2s    = TratarNulo(Hist2s, "")
        THIS.this_cLinNFs       = TratarNulo(NFs, "")
        THIS.this_dLinDatas     = TratarNulo(Datas, {})
        THIS.this_dLinVencs     = TratarNulo(Vencs, {})
        THIS.this_dLinDtEmis    = TratarNulo(DtEmis, {})
        THIS.this_dLinDtBaixa   = TratarNulo(DtBaixa, {})
        THIS.this_cLinTitulos   = TratarNulo(Titulos, "")
        THIS.this_cLinMoedas    = TratarNulo(Moedas, "")
        THIS.this_nLinSInis     = TratarNulo(SInis, 0)
        THIS.this_cLinRClis     = TratarNulo(RClis, "")

        IF TYPE("Emps") = "C"
            THIS.this_cLinEmps = TratarNulo(Emps, "")
        ENDIF
        IF TYPE("Dopes") = "C"
            THIS.this_cLinDopes = TratarNulo(Dopes, "")
        ENDIF
        IF TYPE("Numes") = "N"
            THIS.this_nLinNumes = TratarNulo(Numes, 0)
        ENDIF
        IF TYPE("VOpers") = "C"
            THIS.this_cLinVOpers = TratarNulo(VOpers, "")
        ENDIF
        IF TYPE("Acertos") = "N"
            THIS.this_nLinAcertos = TratarNulo(Acertos, 0)
        ENDIF
        IF TYPE("GrupEms") = "C"
            THIS.this_cLinGrupEms = TratarNulo(GrupEms, "")
        ENDIF
        IF TYPE("SGrupos") = "C"
            THIS.this_cLinSGrupos = TratarNulo(SGrupos, "")
        ENDIF
        IF TYPE("SContas") = "C"
            THIS.this_cLinSContas = TratarNulo(SContas, "")
        ENDIF
        IF TYPE("GrupAges") = "C"
            THIS.this_cLinGrupAges = TratarNulo(GrupAges, "")
        ENDIF
        IF TYPE("ContAges") = "C"
            THIS.this_cLinContAges = TratarNulo(ContAges, "")
        ENDIF
        IF TYPE("TitBans") = "C"
            THIS.this_cLinTitBans = TratarNulo(TitBans, "")
        ENDIF
        IF TYPE("EspecieNfs") = "C"
            THIS.this_cLinEspecieNfs = TratarNulo(EspecieNfs, "")
        ENDIF
        IF TYPE("ValOcurs") = "N"
            THIS.this_nLinValOcurs = TratarNulo(ValOcurs, 0)
        ENDIF
        IF TYPE("TitCancs") = "N"
            THIS.this_nLinTitCancs = TratarNulo(TitCancs, 0)
        ENDIF
        IF TYPE("Pagos") = "C"
            THIS.this_cLinPagos = TratarNulo(Pagos, "")
        ENDIF
        IF TYPE("Concs") = "L"
            THIS.this_lLinConcs = TratarNulo(Concs, .F.)
        ENDIF
        IF TYPE("Prorrogs") = "D" OR TYPE("Prorrogs") = "T"
            THIS.this_dLinProrrogs = TratarNulo(Prorrogs, {})
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir / Atualizar / ExecutarExclusao
    *
    * SIGOPCGF e um form OPERACIONAL de consulta ("Consulta Global
    * Financeira"): o legado apura o resultado so no cursor local LocalDados
    * (via SqlExecute + filtros), nunca grava numa tabela propria do SQL
    * Server - os dados persistidos que ele le/altera pertencem a outras
    * entidades (SigCdPit/SigMvCab/SigCdPgr/SigSyPar, etc), cada uma com seu
    * proprio BO. Por isso esta tela nao tem INSERT/UPDATE/DELETE proprios;
    * o comportamento padrao herdado de BusinessBase (recusar a operacao e
    * expor THIS.this_cMensagemErro) ja e o correto aqui.
    *==========================================================================
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Esta tela realiza consulta financeira; n" + ;
                                   CHR(227) + "o grava registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Esta tela realiza consulta financeira; n" + ;
                                   CHR(227) + "o grava registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Esta tela realiza consulta financeira; n" + ;
                                   CHR(227) + "o exclui registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Nao ha registro proprio persistido por esta BO
    * (ver Inserir/Atualizar/ExecutarExclusao acima). Mantido PROTECTED para
    * compatibilidade com a interface de BusinessBase, devolvendo o numero
    * da operacao (Nopers) da linha corrente como chave de referencia.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nLinNopers)
    ENDPROC

ENDDEFINE

