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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCGF.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (5909 linhas total):

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

*-- Linhas 276 a 373:
276:     * de navegacao (cmgFiltros: Consultar/Sair). SCX: Top=-3,Left=835,W=173,
277:     * H=110, Buttons 75x75 (Comic Sans MS), icones cadastro_procurar_60.jpg /
278:     * cadastro_sair_60.jpg.
279:     *--------------------------------------------------------------------------
280:     PROTECTED PROCEDURE ConfigurarCabecalhoFiltros(par_oPag)
281:         par_oPag.AddObject("cnt_4c_Sombra", "Container")
282:         WITH par_oPag.cnt_4c_Sombra
283:             .Top         = 0
284:             .Left        = 0
285:             .Width       = THIS.Width
286:             .Height      = 80
287:             .BackColor   = RGB(100, 100, 100)
288:             .BorderWidth = 0
289: 
290:             .AddObject("lbl_4c_Sombra", "Label")
291:             WITH .lbl_4c_Sombra
292:                 .Top       = 25
293:                 .Left      = 10
294:                 .Width     = THIS.Width
295:                 .Height    = 40
296:                 .AutoSize  = .F.
297:                 .BackStyle = 0
298:                 .WordWrap  = .T.
299:                 .FontName  = "Tahoma"
300:                 .FontSize  = 18
301:                 .FontBold  = .T.
302:                 .ForeColor = RGB(0, 0, 0)
303:                 .Caption   = THIS.Caption
304:                 .Visible   = .T.
305:             ENDWITH
306: 
307:             .AddObject("lbl_4c_TituloCabecalho", "Label")
308:             WITH .lbl_4c_TituloCabecalho
309:                 .Top       = 24
310:                 .Left      = 10
311:                 .Width     = THIS.Width
312:                 .Height    = 46
313:                 .AutoSize  = .F.
314:                 .BackStyle = 0
315:                 .WordWrap  = .T.
316:                 .FontName  = "Tahoma"
317:                 .FontSize  = 18
318:                 .FontBold  = .T.
319:                 .ForeColor = RGB(255, 255, 255)
320:                 .Caption   = THIS.Caption
321:                 .Visible   = .T.
322:             ENDWITH
323: 
324:             .Visible = .T.
325:         ENDWITH
326: 
327:         par_oPag.AddObject("cmg_4c_Filtros", "CommandGroup")
328:         WITH par_oPag.cmg_4c_Filtros
329:             .Top           = -3
330:             .Left          = 835
331:             .Width         = 173
332:             .Height        = 110
333:             .ButtonCount   = 2
334:             .BackStyle     = 0
335:             .BorderStyle   = 0
336:             .SpecialEffect = 1
337:             .BorderColor   = RGB(136, 189, 188)
338:             .Themes        = .F.
339: 
340:             WITH .Buttons(1)
341:                 .Top         = 5
342:                 .Left        = 11
343:                 .Width       = 75
344:                 .Height      = 75
345:                 .FontName    = "Comic Sans MS"
346:                 .FontSize    = 8
347:                 .FontBold    = .T.
348:                 .FontItalic  = .T.
349:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
350:                 .Caption     = "\<Consultar"
351:                 .ToolTipText = "Consultar Usando os Filtros Informados"
352:                 .ForeColor   = RGB(90, 90, 90)
353:                 .BackColor   = RGB(255, 255, 255)
354:                 .Themes      = .F.
355:             ENDWITH
356: 
357:             WITH .Buttons(2)
358:                 .Top         = 5
359:                 .Left        = 87
360:                 .Width       = 75
361:                 .Height      = 75
362:                 .FontName    = "Comic Sans MS"
363:                 .FontSize    = 8
364:                 .FontBold    = .T.
365:                 .FontItalic  = .T.
366:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
367:                 .Cancel      = .T.
368:                 .Caption     = "\<Sair"
369:                 .ToolTipText = "[ESC] Sair"
370:                 .ForeColor   = RGB(90, 90, 90)
371:                 .BackColor   = RGB(255, 255, 255)
372:                 .Themes      = .F.
373:             ENDWITH

*-- Linhas 379 a 733:
379:     ENDPROC
380: 
381:     *--------------------------------------------------------------------------
382:     * ConfigurarCamposFiltros - Labels + TextBoxes/CheckBoxes de filtro (datas,
383:     * titulo, titulo banco, especie NF, NF, moedas, saldo, publicidade,
384:     * empresa, filtro nomeado). Geometria e Format/InputMask transcritos do
385:     * dump do SCX legado.
386:     *--------------------------------------------------------------------------
387:     PROTECTED PROCEDURE ConfigurarCamposFiltros(par_oPag)
388:         LOCAL loc_cAte
389:         loc_cAte = "at" + CHR(233)
390: 
391:         *-- Emissao
392:         par_oPag.AddObject("lbl_4c_SayPed", "Label")
393:         WITH par_oPag.lbl_4c_SayPed
394:             .Top = 132
395:             .Left = 139
396:             .Width = 47
397:             .FontName = "Tahoma"
398:             .FontSize = 8
399:             .ForeColor = RGB(90, 90, 90)
400:             .Caption = "Emiss" + CHR(227) + "o :"
401:             .Visible = .T.
402:         ENDWITH
403: 
404:         par_oPag.AddObject("txt_4c_DtEmiI", "TextBox")
405:         WITH par_oPag.txt_4c_DtEmiI
406:             .Top = 128
407:             .Left = 190
408:             .Width = 80
409:             .Height = 23
410:             .Alignment = 3
411:             .Value = {}
412:             .FontName = "Tahoma"
413:             .SpecialEffect = 1
414:             .Visible = .T.
415:         ENDWITH
416: 
417:         par_oPag.AddObject("lbl_4c_Label2", "Label")
418:         WITH par_oPag.lbl_4c_Label2
419:             .Top = 132
420:             .Left = 275
421:             .Width = 18
422:             .FontName = "Tahoma"
423:             .FontSize = 8
424:             .BackStyle = 0
425:             .ForeColor = RGB(90, 90, 90)
426:             .Caption = loc_cAte
427:             .Visible = .T.
428:         ENDWITH
429: 
430:         par_oPag.AddObject("txt_4c_DtEmiF", "TextBox")
431:         WITH par_oPag.txt_4c_DtEmiF
432:             .Top = 129
433:             .Left = 299
434:             .Width = 80
435:             .Height = 23
436:             .Alignment = 3
437:             .Value = {}
438:             .FontName = "Tahoma"
439:             .SpecialEffect = 1
440:             .Visible = .T.
441:         ENDWITH
442: 
443:         *-- Vencimento
444:         par_oPag.AddObject("lbl_4c_Say1", "Label")
445:         WITH par_oPag.lbl_4c_Say1
446:             .Top = 158
447:             .Left = 122
448:             .Width = 64
449:             .FontName = "Tahoma"
450:             .FontSize = 8
451:             .ForeColor = RGB(90, 90, 90)
452:             .Caption = "Vencimento :"
453:             .Visible = .T.
454:         ENDWITH
455: 
456:         par_oPag.AddObject("txt_4c_VencsI", "TextBox")
457:         WITH par_oPag.txt_4c_VencsI
458:             .Top = 154
459:             .Left = 190
460:             .Width = 80
461:             .Height = 23
462:             .Alignment = 3
463:             .Value = {}
464:             .FontName = "Tahoma"
465:             .SpecialEffect = 1
466:             .Visible = .T.
467:         ENDWITH
468: 
469:         par_oPag.AddObject("lbl_4c_Label1", "Label")
470:         WITH par_oPag.lbl_4c_Label1
471:             .Top = 158
472:             .Left = 275
473:             .Width = 18
474:             .FontName = "Tahoma"
475:             .FontSize = 8
476:             .BackStyle = 0
477:             .ForeColor = RGB(90, 90, 90)
478:             .Caption = loc_cAte
479:             .Visible = .T.
480:         ENDWITH
481: 
482:         par_oPag.AddObject("txt_4c_VencsF", "TextBox")
483:         WITH par_oPag.txt_4c_VencsF
484:             .Top = 154
485:             .Left = 299
486:             .Width = 80
487:             .Height = 23
488:             .Alignment = 3
489:             .Value = {}
490:             .FontName = "Tahoma"
491:             .SpecialEffect = 1
492:             .Visible = .T.
493:         ENDWITH
494: 
495:         *-- Lancamento
496:         par_oPag.AddObject("lbl_4c_Say2", "Label")
497:         WITH par_oPag.lbl_4c_Say2
498:             .Top = 184
499:             .Left = 119
500:             .Width = 67
501:             .FontName = "Tahoma"
502:             .FontSize = 8
503:             .ForeColor = RGB(90, 90, 90)
504:             .Caption = "Lan" + CHR(231) + "amento :"
505:             .Visible = .T.
506:         ENDWITH
507: 
508:         par_oPag.AddObject("txt_4c_DatasI", "TextBox")
509:         WITH par_oPag.txt_4c_DatasI
510:             .Top = 180
511:             .Left = 190
512:             .Width = 80
513:             .Height = 23
514:             .Alignment = 3
515:             .Value = {}
516:             .FontName = "Tahoma"
517:             .SpecialEffect = 1
518:             .Visible = .T.
519:         ENDWITH
520: 
521:         par_oPag.AddObject("lbl_4c_Label3", "Label")
522:         WITH par_oPag.lbl_4c_Label3
523:             .Top = 184
524:             .Left = 275
525:             .Width = 18
526:             .FontName = "Tahoma"
527:             .FontSize = 8
528:             .BackStyle = 0
529:             .ForeColor = RGB(90, 90, 90)
530:             .Caption = loc_cAte
531:             .Visible = .T.
532:         ENDWITH
533: 
534:         par_oPag.AddObject("txt_4c_DatasF", "TextBox")
535:         WITH par_oPag.txt_4c_DatasF
536:             .Top = 180
537:             .Left = 299
538:             .Width = 80
539:             .Height = 23
540:             .Alignment = 3
541:             .Value = {}
542:             .FontName = "Tahoma"
543:             .SpecialEffect = 1
544:             .Visible = .T.
545:         ENDWITH
546: 
547:         *-- Acerto (Baixa)
548:         par_oPag.AddObject("lbl_4c_Say13", "Label")
549:         WITH par_oPag.lbl_4c_Say13
550:             .Top = 210
551:             .Left = 145
552:             .Width = 41
553:             .FontName = "Tahoma"
554:             .FontSize = 8
555:             .ForeColor = RGB(90, 90, 90)
556:             .Caption = "Acerto :"
557:             .Visible = .T.
558:         ENDWITH
559: 
560:         par_oPag.AddObject("txt_4c_DtBxI", "TextBox")
561:         WITH par_oPag.txt_4c_DtBxI
562:             .Top = 206
563:             .Left = 190
564:             .Width = 80
565:             .Height = 23
566:             .Alignment = 3
567:             .Value = {}
568:             .FontName = "Tahoma"
569:             .SpecialEffect = 1
570:             .Visible = .T.
571:         ENDWITH
572: 
573:         par_oPag.AddObject("lbl_4c_Label4", "Label")
574:         WITH par_oPag.lbl_4c_Label4
575:             .Top = 210
576:             .Left = 275
577:             .Width = 18
578:             .FontName = "Tahoma"
579:             .FontSize = 8
580:             .BackStyle = 0
581:             .ForeColor = RGB(90, 90, 90)
582:             .Caption = loc_cAte
583:             .Visible = .T.
584:         ENDWITH
585: 
586:         par_oPag.AddObject("txt_4c_DtBxF", "TextBox")
587:         WITH par_oPag.txt_4c_DtBxF
588:             .Top = 206
589:             .Left = 299
590:             .Width = 80
591:             .Height = 23
592:             .Alignment = 3
593:             .Value = {}
594:             .FontName = "Tahoma"
595:             .SpecialEffect = 1
596:             .Visible = .T.
597:         ENDWITH
598: 
599:         *-- Branco (checkbox ao lado da faixa de Emissao)
600:         par_oPag.AddObject("chk_4c_Brancos", "CheckBox")
601:         WITH par_oPag.chk_4c_Brancos
602:             .Top = 134
603:             .Left = 382
604:             .Width = 46
605:             .Height = 13
606:             .FontSize = 7
607:             .Alignment = 0
608:             .Caption = "Branco"
609:             .Value = 0
610:             .SpecialEffect = 1
611:             .Visible = .T.
612:         ENDWITH
613: 
614:         *-- Titulo
615:         par_oPag.AddObject("lbl_4c_Say4", "Label")
616:         WITH par_oPag.lbl_4c_Say4
617:             .Top = 133
618:             .Left = 466
619:             .Width = 35
620:             .FontName = "Tahoma"
621:             .FontSize = 8
622:             .ForeColor = RGB(90, 90, 90)
623:             .Caption = "T" + CHR(237) + "tulo :"
624:             .Visible = .T.
625:         ENDWITH
626: 
627:         par_oPag.AddObject("txt_4c_Titulos", "TextBox")
628:         WITH par_oPag.txt_4c_Titulos
629:             .Top = 129
630:             .Left = 504
631:             .Width = 80
632:             .Height = 23
633:             .Alignment = 3
634:             .Value = ""
635:             .MaxLength = 10
636:             .FontName = "Tahoma"
637:             .SpecialEffect = 1
638:             .Visible = .T.
639:         ENDWITH
640: 
641:         *-- Nota Fiscal
642:         par_oPag.AddObject("lbl_4c_Say20", "Label")
643:         WITH par_oPag.lbl_4c_Say20
644:             .Top = 158
645:             .Left = 440
646:             .FontName = "Tahoma"
647:             .ForeColor = RGB(90, 90, 90)
648:             .Caption = "Nota Fiscal :"
649:             .Visible = .T.
650:         ENDWITH
651: 
652:         par_oPag.AddObject("txt_4c_NFs", "TextBox")
653:         WITH par_oPag.txt_4c_NFs
654:             .Top = 154
655:             .Left = 504
656:             .Width = 80
657:             .Height = 23
658:             .Value = ""
659:             .Format = "K!"
660:             .FontName = "Tahoma"
661:             .SpecialEffect = 1
662:             .Visible = .T.
663:         ENDWITH
664: 
665:         *-- Titulo Banco
666:         par_oPag.AddObject("lbl_4c_Say12", "Label")
667:         WITH par_oPag.lbl_4c_Say12
668:             .Top = 184
669:             .Left = 434
670:             .Width = 67
671:             .FontName = "Tahoma"
672:             .ForeColor = RGB(90, 90, 90)
673:             .Caption = "T" + CHR(237) + "tulo Banco :"
674:             .Visible = .T.
675:         ENDWITH
676: 
677:         par_oPag.AddObject("txt_4c_TitBans", "TextBox")
678:         WITH par_oPag.txt_4c_TitBans
679:             .Top = 180
680:             .Left = 504
681:             .Width = 80
682:             .Height = 23
683:             .Value = ""
684:             .FontName = "Tahoma"
685:             .SpecialEffect = 1
686:             .Visible = .T.
687:         ENDWITH
688: 
689:         *-- Especie da NF
690:         par_oPag.AddObject("lbl_4c_Say25", "Label")
691:         WITH par_oPag.lbl_4c_Say25
692:             .Top = 210
693:             .Left = 456
694:             .Width = 45
695:             .FontName = "Tahoma"
696:             .ForeColor = RGB(90, 90, 90)
697:             .Caption = "Esp" + CHR(233) + "cie :"
698:             .Visible = .T.
699:         ENDWITH
700: 
701:         par_oPag.AddObject("txt_4c_EspecieNfs", "TextBox")
702:         WITH par_oPag.txt_4c_EspecieNfs
703:             .Top = 206
704:             .Left = 504
705:             .Width = 52
706:             .Height = 23
707:             .Value = ""
708:             .FontName = "Tahoma"
709:             .SpecialEffect = 1
710:             .Visible = .T.
711:         ENDWITH
712: 
713:         *-- Moeda Filtro
714:         par_oPag.AddObject("lbl_4c_LblFator", "Label")
715:         WITH par_oPag.lbl_4c_LblFator
716:             .Top = 236
717:             .Left = 118
718:             .Width = 68
719:             .FontName = "Tahoma"
720:             .ForeColor = RGB(90, 90, 90)
721:             .Caption = "Moeda Filtro :"
722:             .Visible = .T.
723:         ENDWITH
724: 
725:         par_oPag.AddObject("txt_4c_CMoes", "TextBox")
726:         WITH par_oPag.txt_4c_CMoes
727:             .Top = 232
728:             .Left = 190
729:             .Width = 31
730:             .Height = 23
731:             .Value = ""
732:             .Format = "K"
733:             .MaxLength = 3

*-- Linhas 739 a 774:
739: 
740:         par_oPag.AddObject("txt_4c_DMoes", "TextBox")
741:         WITH par_oPag.txt_4c_DMoes
742:             .Top = 232
743:             .Left = 225
744:             .Width = 154
745:             .Height = 23
746:             .Value = ""
747:             .Format = "K"
748:             .MaxLength = 15
749:             .FontName = "Tahoma"
750:             .SpecialEffect = 1
751:             .Visible = .T.
752:         ENDWITH
753: 
754:         *-- Saldo Inicial + Moeda do Saldo
755:         par_oPag.AddObject("lbl_4c_Say11", "Label")
756:         WITH par_oPag.lbl_4c_Say11
757:             .Top = 236
758:             .Left = 436
759:             .Width = 65
760:             .FontName = "Tahoma"
761:             .ForeColor = RGB(90, 90, 90)
762:             .Caption = "Saldo Inicial :"
763:             .Visible = .T.
764:         ENDWITH
765: 
766:         par_oPag.AddObject("txt_4c_Saldo", "TextBox")
767:         WITH par_oPag.txt_4c_Saldo
768:             .Top = 232
769:             .Left = 504
770:             .Width = 80
771:             .Height = 23
772:             .Alignment = 1
773:             .Value = 0
774:             .Format = "K"

*-- Linhas 781 a 817:
781: 
782:         par_oPag.AddObject("txt_4c_MoeSaldo", "TextBox")
783:         WITH par_oPag.txt_4c_MoeSaldo
784:             .Top = 232
785:             .Left = 587
786:             .Width = 31
787:             .Height = 23
788:             .Value = ""
789:             .Format = "K"
790:             .MaxLength = 3
791:             .FontName = "Tahoma"
792:             .FontSize = 9
793:             .SpecialEffect = 1
794:             .Visible = .T.
795:         ENDWITH
796: 
797:         *-- Moeda Conversao
798:         par_oPag.AddObject("lbl_4c_Say6", "Label")
799:         WITH par_oPag.lbl_4c_Say6
800:             .Top = 262
801:             .Left = 90
802:             .Width = 96
803:             .FontName = "Tahoma"
804:             .ForeColor = RGB(90, 90, 90)
805:             .Caption = "Moeda Convers" + CHR(227) + "o :"
806:             .Visible = .T.
807:         ENDWITH
808: 
809:         par_oPag.AddObject("txt_4c_CMoesC", "TextBox")
810:         WITH par_oPag.txt_4c_CMoesC
811:             .Top = 258
812:             .Left = 190
813:             .Width = 31
814:             .Height = 23
815:             .Value = ""
816:             .Format = "K"
817:             .MaxLength = 3

*-- Linhas 823 a 883:
823: 
824:         par_oPag.AddObject("txt_4c_DMoesC", "TextBox")
825:         WITH par_oPag.txt_4c_DMoesC
826:             .Top = 258
827:             .Left = 225
828:             .Width = 154
829:             .Height = 23
830:             .Value = ""
831:             .Format = "K"
832:             .MaxLength = 15
833:             .FontName = "Tahoma"
834:             .SpecialEffect = 1
835:             .Visible = .T.
836:         ENDWITH
837: 
838:         *-- Empresa
839:         par_oPag.AddObject("lbl_4c_Say17", "Label")
840:         WITH par_oPag.lbl_4c_Say17
841:             .Top = 262
842:             .Left = 451
843:             .FontName = "Tahoma"
844:             .ForeColor = RGB(90, 90, 90)
845:             .Caption = "Empresa :"
846:             .Visible = .T.
847:         ENDWITH
848: 
849:         par_oPag.AddObject("txt_4c_Empresa", "TextBox")
850:         WITH par_oPag.txt_4c_Empresa
851:             .Top = 258
852:             .Left = 504
853:             .Width = 33
854:             .Height = 23
855:             .Value = ""
856:             .FontName = "Tahoma"
857:             .SpecialEffect = 1
858:             .Themes = .F.
859:             .Visible = .T.
860:             .MaxLength   = 3
861:         ENDWITH
862: 
863:         *-- F.Publicidade
864:         par_oPag.AddObject("lbl_4c_Say18", "Label")
865:         WITH par_oPag.lbl_4c_Say18
866:             .Top = 404
867:             .Left = 548
868:             .Width = 72
869:             .FontName = "Tahoma"
870:             .ForeColor = RGB(90, 90, 90)
871:             .Caption = "F.Publicidade :"
872:             .Visible = .T.
873:         ENDWITH
874: 
875:         par_oPag.AddObject("txt_4c_CFPublis", "TextBox")
876:         WITH par_oPag.txt_4c_CFPublis
877:             .Top = 400
878:             .Left = 624
879:             .Width = 31
880:             .Height = 23
881:             .Value = ""
882:             .Format = "K"
883:             .MaxLength = 3

*-- Linhas 889 a 953:
889: 
890:         par_oPag.AddObject("txt_4c_DFPublis", "TextBox")
891:         WITH par_oPag.txt_4c_DFPublis
892:             .Top = 400
893:             .Left = 658
894:             .Width = 181
895:             .Height = 23
896:             .Value = ""
897:             .Format = "K"
898:             .MaxLength = 15
899:             .FontName = "Tahoma"
900:             .SpecialEffect = 1
901:             .Visible = .T.
902:         ENDWITH
903: 
904:         *-- chkValpags "Valor em aberto" (checkbox ao lado das OptionGroups)
905:         par_oPag.AddObject("chk_4c_ValPends", "CheckBox")
906:         WITH par_oPag.chk_4c_ValPends
907:             .Top = 309
908:             .Left = 409
909:             .Width = 82
910:             .Height = 13
911:             .FontSize = 7
912:             .Alignment = 0
913:             .Caption = "Valor Pendente"
914:             .Value = 0
915:             .SpecialEffect = 1
916:             .Visible = .T.
917:         ENDWITH
918: 
919:         *-- Filtros nomeados (Say14 + getFiltros visivel / getNewFiltro oculto)
920:         par_oPag.AddObject("lbl_4c_Say14", "Label")
921:         WITH par_oPag.lbl_4c_Say14
922:             .Top = 103
923:             .Left = 148
924:             .Width = 38
925:             .FontName = "Tahoma"
926:             .ForeColor = RGB(90, 90, 90)
927:             .Caption = "Filtros :"
928:             .Visible = .T.
929:         ENDWITH
930: 
931:         par_oPag.AddObject("txt_4c_Filtros", "TextBox")
932:         WITH par_oPag.txt_4c_Filtros
933:             .Top = 99
934:             .Left = 190
935:             .Width = 312
936:             .Height = 23
937:             .Value = ""
938:             .Format = "K!"
939:             .BackStyle = 1
940:             .FontName = "Tahoma"
941:             .SpecialEffect = 1
942:             .Visible = .T.
943:         ENDWITH
944: 
945:         par_oPag.AddObject("txt_4c_NewFiltro", "TextBox")
946:         WITH par_oPag.txt_4c_NewFiltro
947:             .Top = 99
948:             .Left = 190
949:             .Width = 312
950:             .Height = 23
951:             .Value = ""
952:             .Format = "K!"
953:             .BackStyle = 1

*-- Linhas 971 a 998:
971:         BINDEVENT(par_oPag.txt_4c_TitBans,    "LostFocus", THIS, "ValidarTitBansFiltro")
972: 
973:         *-- Textos fixos sobre as duas grades de clientes
974:         par_oPag.AddObject("lbl_4c_Say15", "Label")
975:         WITH par_oPag.lbl_4c_Say15
976:             .Top = 410
977:             .Left = 81
978:             .Width = 351
979:             .FontBold = .T.
980:             .FontSize = 8
981:             .Caption = "Filtrar lan" + CHR(231) + "amento que contenham uma das condi" + CHR(231) + CHR(245) + "es abaixo:"
982:             .Visible = .T.
983:         ENDWITH
984: 
985:         par_oPag.AddObject("lbl_4c_Say16", "Label")
986:         WITH par_oPag.lbl_4c_Say16
987:             .Top = 559
988:             .Left = 81
989:             .Width = 574
990:             .FontBold = .T.
991:             .FontSize = 8
992:             .ForeColor = RGB(255, 255, 255)
993:             .Caption = "Filtrar lan" + CHR(231) + "amento que contenham uma das condi" + CHR(231) + CHR(245) + "es da grade acima e da grade abaixo contenham :"
994:             .Visible = .T.
995:         ENDWITH
996:     ENDPROC
997: 
998:     *--------------------------------------------------------------------------

*-- Linhas 1005 a 1401:
1005:         loc_cNao = "N" + CHR(227) + "o"
1006: 
1007:         *-- Pagamento
1008:         par_oPag.AddObject("lbl_4c_Say3", "Label")
1009:         WITH par_oPag.lbl_4c_Say3
1010:             .Top = 308
1011:             .Left = 123
1012:             .Width = 63
1013:             .FontName = "Tahoma"
1014:             .ForeColor = RGB(90, 90, 90)
1015:             .Caption = "Pagamento :"
1016:             .Visible = .T.
1017:         ENDWITH
1018: 
1019:         par_oPag.AddObject("opt_4c_Pagos", "OptionGroup")
1020:         WITH par_oPag.opt_4c_Pagos
1021:             .Top = 303
1022:             .Left = 185
1023:             .Width = 217
1024:             .Height = 25
1025:             .ButtonCount = 3
1026:             .BackStyle = 0
1027:             .BorderStyle = 0
1028:             .Value = 1
1029:             WITH .Buttons(1)
1030:                 .Top = 5
1031:                 .Left = 5
1032:                 .Width = 43
1033:                 .FontName = "Tahoma"
1034:                 .FontSize = 8
1035:                 .BackStyle = 0
1036:                 .Caption = "Geral"
1037:                 .ForeColor = RGB(90, 90, 90)
1038:             ENDWITH
1039:             WITH .Buttons(2)
1040:                 .Top = 5
1041:                 .Left = 85
1042:                 .Width = 34
1043:                 .FontName = "Tahoma"
1044:                 .FontSize = 8
1045:                 .BackStyle = 0
1046:                 .Caption = "Sim"
1047:                 .ForeColor = RGB(90, 90, 90)
1048:             ENDWITH
1049:             WITH .Buttons(3)
1050:                 .Top = 5
1051:                 .Left = 175
1052:                 .Width = 37
1053:                 .FontName = "Tahoma"
1054:                 .FontSize = 8
1055:                 .BackStyle = 0
1056:                 .Caption = loc_cNao
1057:                 .ForeColor = RGB(90, 90, 90)
1058:             ENDWITH
1059:             .Visible = .T.
1060:         ENDWITH
1061: 
1062:         *-- Opcao
1063:         par_oPag.AddObject("lbl_4c_Say5", "Label")
1064:         WITH par_oPag.lbl_4c_Say5
1065:             .Top = 329
1066:             .Left = 146
1067:             .Width = 40
1068:             .FontName = "Tahoma"
1069:             .ForeColor = RGB(90, 90, 90)
1070:             .Caption = "Op" + CHR(231) + CHR(227) + "o :"
1071:             .Visible = .T.
1072:         ENDWITH
1073: 
1074:         par_oPag.AddObject("opt_4c_Opcao", "OptionGroup")
1075:         WITH par_oPag.opt_4c_Opcao
1076:             .Top = 324
1077:             .Left = 185
1078:             .Width = 217
1079:             .Height = 25
1080:             .ButtonCount = 3
1081:             .BackStyle = 0
1082:             .BorderStyle = 0
1083:             .Value = 1
1084:             WITH .Buttons(1)
1085:                 .Top = 5
1086:                 .Left = 5
1087:                 .Width = 43
1088:                 .FontName = "Tahoma"
1089:                 .FontSize = 8
1090:                 .BackStyle = 0
1091:                 .Caption = "Geral"
1092:                 .ForeColor = RGB(90, 90, 90)
1093:             ENDWITH
1094:             WITH .Buttons(2)
1095:                 .Top = 5
1096:                 .Left = 85
1097:                 .Width = 34
1098:                 .FontName = "Tahoma"
1099:                 .FontSize = 8
1100:                 .BackStyle = 0
1101:                 .Caption = "Sim"
1102:                 .ForeColor = RGB(90, 90, 90)
1103:             ENDWITH
1104:             WITH .Buttons(3)
1105:                 .Top = 5
1106:                 .Left = 175
1107:                 .Width = 37
1108:                 .FontName = "Tahoma"
1109:                 .FontSize = 8
1110:                 .BackStyle = 0
1111:                 .Caption = loc_cNao
1112:                 .ForeColor = RGB(90, 90, 90)
1113:             ENDWITH
1114:             .Visible = .T.
1115:         ENDWITH
1116: 
1117:         *-- Conversao em
1118:         par_oPag.AddObject("lbl_4c_Say7", "Label")
1119:         WITH par_oPag.lbl_4c_Say7
1120:             .Top = 287
1121:             .Left = 108
1122:             .Width = 78
1123:             .FontName = "Tahoma"
1124:             .ForeColor = RGB(90, 90, 90)
1125:             .Caption = "Convers" + CHR(227) + "o em :"
1126:             .Visible = .T.
1127:         ENDWITH
1128: 
1129:         par_oPag.AddObject("opt_4c_CotEm", "OptionGroup")
1130:         WITH par_oPag.opt_4c_CotEm
1131:             .Top = 282
1132:             .Left = 185
1133:             .Width = 405
1134:             .Height = 25
1135:             .ButtonCount = 5
1136:             .BackStyle = 0
1137:             .BorderStyle = 0
1138:             .Value = 1
1139:             WITH .Buttons(1)
1140:                 .Top = 5
1141:                 .Left = 5
1142:                 .Width = 56
1143:                 .FontName = "Tahoma"
1144:                 .FontSize = 8
1145:                 .BackStyle = 0
1146:                 .Caption = "Emiss" + CHR(227) + "o"
1147:                 .ForeColor = RGB(90, 90, 90)
1148:             ENDWITH
1149:             WITH .Buttons(2)
1150:                 .Top = 5
1151:                 .Left = 85
1152:                 .Width = 73
1153:                 .FontName = "Tahoma"
1154:                 .FontSize = 8
1155:                 .BackStyle = 0
1156:                 .Caption = "Vencimento"
1157:                 .ForeColor = RGB(90, 90, 90)
1158:             ENDWITH
1159:             WITH .Buttons(3)
1160:                 .Top = 5
1161:                 .Left = 175
1162:                 .Width = 76
1163:                 .FontName = "Tahoma"
1164:                 .FontSize = 8
1165:                 .BackStyle = 0
1166:                 .Caption = "Lan" + CHR(231) + "amento"
1167:                 .ForeColor = RGB(90, 90, 90)
1168:             ENDWITH
1169:             WITH .Buttons(4)
1170:                 .Top = 5
1171:                 .Left = 281
1172:                 .Width = 43
1173:                 .FontName = "Tahoma"
1174:                 .FontSize = 8
1175:                 .BackStyle = 0
1176:                 .Caption = "Atual"
1177:                 .ForeColor = RGB(90, 90, 90)
1178:             ENDWITH
1179:             WITH .Buttons(5)
1180:                 .Top = 5
1181:                 .Left = 350
1182:                 .Width = 50
1183:                 .FontName = "Tahoma"
1184:                 .FontSize = 8
1185:                 .BackStyle = 0
1186:                 .Caption = "Acerto"
1187:                 .ForeColor = RGB(90, 90, 90)
1188:             ENDWITH
1189:             .Visible = .T.
1190:         ENDWITH
1191: 
1192:         *-- Cancelamento
1193:         par_oPag.AddObject("lbl_4c_Say8", "Label")
1194:         WITH par_oPag.lbl_4c_Say8
1195:             .Top = 349
1196:             .Left = 109
1197:             .Width = 77
1198:             .FontName = "Tahoma"
1199:             .ForeColor = RGB(90, 90, 90)
1200:             .Caption = "Cancelamento :"
1201:             .Visible = .T.
1202:         ENDWITH
1203: 
1204:         par_oPag.AddObject("opt_4c_Cancs", "OptionGroup")
1205:         WITH par_oPag.opt_4c_Cancs
1206:             .Top = 344
1207:             .Left = 185
1208:             .Width = 217
1209:             .Height = 25
1210:             .ButtonCount = 3
1211:             .BackStyle = 0
1212:             .BorderStyle = 0
1213:             .Value = 1
1214:             WITH .Buttons(1)
1215:                 .Top = 5
1216:                 .Left = 5
1217:                 .Width = 43
1218:                 .FontName = "Tahoma"
1219:                 .FontSize = 8
1220:                 .BackStyle = 0
1221:                 .Caption = "Geral"
1222:                 .ForeColor = RGB(90, 90, 90)
1223:             ENDWITH
1224:             WITH .Buttons(2)
1225:                 .Top = 5
1226:                 .Left = 85
1227:                 .Width = 34
1228:                 .FontName = "Tahoma"
1229:                 .FontSize = 8
1230:                 .BackStyle = 0
1231:                 .Caption = "Sim"
1232:                 .ForeColor = RGB(90, 90, 90)
1233:             ENDWITH
1234:             WITH .Buttons(3)
1235:                 .Top = 5
1236:                 .Left = 175
1237:                 .Width = 37
1238:                 .FontName = "Tahoma"
1239:                 .FontSize = 8
1240:                 .BackStyle = 0
1241:                 .Caption = loc_cNao
1242:                 .ForeColor = RGB(90, 90, 90)
1243:             ENDWITH
1244:             .Visible = .T.
1245:         ENDWITH
1246: 
1247:         *-- Conciliacao
1248:         par_oPag.AddObject("lbl_4c_Say9", "Label")
1249:         WITH par_oPag.lbl_4c_Say9
1250:             .Top = 369
1251:             .Left = 124
1252:             .Width = 62
1253:             .FontName = "Tahoma"
1254:             .ForeColor = RGB(90, 90, 90)
1255:             .Caption = "Concilia" + CHR(231) + CHR(227) + "o :"
1256:             .Visible = .T.
1257:         ENDWITH
1258: 
1259:         par_oPag.AddObject("opt_4c_Concs", "OptionGroup")
1260:         WITH par_oPag.opt_4c_Concs
1261:             .Top = 364
1262:             .Left = 185
1263:             .Width = 217
1264:             .Height = 25
1265:             .ButtonCount = 3
1266:             .BackStyle = 0
1267:             .BorderStyle = 0
1268:             .Value = 1
1269:             WITH .Buttons(1)
1270:                 .Top = 5
1271:                 .Left = 5
1272:                 .Width = 43
1273:                 .FontName = "Tahoma"
1274:                 .FontSize = 8
1275:                 .BackStyle = 0
1276:                 .Caption = "Geral"
1277:                 .ForeColor = RGB(90, 90, 90)
1278:             ENDWITH
1279:             WITH .Buttons(2)
1280:                 .Top = 5
1281:                 .Left = 85
1282:                 .Width = 34
1283:                 .FontName = "Tahoma"
1284:                 .FontSize = 8
1285:                 .BackStyle = 0
1286:                 .Caption = "Sim"
1287:                 .ForeColor = RGB(90, 90, 90)
1288:             ENDWITH
1289:             WITH .Buttons(3)
1290:                 .Top = 5
1291:                 .Left = 175
1292:                 .Width = 37
1293:                 .FontName = "Tahoma"
1294:                 .FontSize = 8
1295:                 .BackStyle = 0
1296:                 .Caption = loc_cNao
1297:                 .ForeColor = RGB(90, 90, 90)
1298:             ENDWITH
1299:             .Visible = .T.
1300:         ENDWITH
1301: 
1302:         *-- Prorrogacao
1303:         par_oPag.AddObject("lbl_4c_Say10", "Label")
1304:         WITH par_oPag.lbl_4c_Say10
1305:             .Top = 388
1306:             .Left = 118
1307:             .Width = 68
1308:             .FontName = "Tahoma"
1309:             .ForeColor = RGB(90, 90, 90)
1310:             .Caption = "Prorroga" + CHR(231) + CHR(227) + "o :"
1311:             .Visible = .T.
1312:         ENDWITH
1313: 
1314:         par_oPag.AddObject("opt_4c_Prorrogs", "OptionGroup")
1315:         WITH par_oPag.opt_4c_Prorrogs
1316:             .Top = 383
1317:             .Left = 185
1318:             .Width = 217
1319:             .Height = 25
1320:             .ButtonCount = 3
1321:             .BackStyle = 0
1322:             .BorderStyle = 0
1323:             .Value = 1
1324:             WITH .Buttons(1)
1325:                 .Top = 5
1326:                 .Left = 5
1327:                 .Width = 43
1328:                 .FontName = "Tahoma"
1329:                 .FontSize = 8
1330:                 .BackStyle = 0
1331:                 .Caption = "Geral"
1332:                 .ForeColor = RGB(90, 90, 90)
1333:             ENDWITH
1334:             WITH .Buttons(2)
1335:                 .Top = 5
1336:                 .Left = 85
1337:                 .Width = 34
1338:                 .FontName = "Tahoma"
1339:                 .FontSize = 8
1340:                 .BackStyle = 0
1341:                 .Caption = "Sim"
1342:                 .ForeColor = RGB(90, 90, 90)
1343:             ENDWITH
1344:             WITH .Buttons(3)
1345:                 .Top = 5
1346:                 .Left = 175
1347:                 .Width = 37
1348:                 .FontName = "Tahoma"
1349:                 .FontSize = 8
1350:                 .BackStyle = 0
1351:                 .Caption = loc_cNao
1352:                 .ForeColor = RGB(90, 90, 90)
1353:             ENDWITH
1354:             .Visible = .T.
1355:         ENDWITH
1356: 
1357:         *-- Filtro da grade 2 (Todas/Alguma) - sobre fundo escuro, texto branco
1358:         par_oPag.AddObject("opt_4c_FilGrd2", "OptionGroup")
1359:         WITH par_oPag.opt_4c_FilGrd2
1360:             .Top = 557
1361:             .Left = 748
1362:             .Width = 139
1363:             .Height = 17
1364:             .ButtonCount = 2
1365:             .AutoSize = .F.
1366:             .BackStyle = 0
1367:             .BorderStyle = 0
1368:             .Value = 1
1369:             WITH .Buttons(1)
1370:                 .Top = 1
1371:                 .Left = 5
1372:                 .Width = 58
1373:                 .FontName = "Verdana"
1374:                 .FontSize = 8
1375:                 .FontBold = .T.
1376:                 .BackStyle = 0
1377:                 .Caption = "Todas"
1378:                 .ForeColor = RGB(255, 255, 255)
1379:             ENDWITH
1380:             WITH .Buttons(2)
1381:                 .Top = 1
1382:                 .Left = 68
1383:                 .Width = 68
1384:                 .FontName = "Verdana"
1385:                 .FontSize = 8
1386:                 .FontBold = .T.
1387:                 .BackStyle = 0
1388:                 .Caption = "Alguma"
1389:                 .ForeColor = RGB(255, 255, 255)
1390:             ENDWITH
1391:             .Visible = .T.
1392:         ENDWITH
1393:     ENDPROC
1394: 
1395:     *--------------------------------------------------------------------------
1396:     * ConfigurarGradesFiltros - grdTipo (Column1=Imps checkbox + Column2=Dopes
1397:     * texto, bound a cursor_4c_Tipos) e as duas grades de Grupo/Conta
1398:     * (Grd_Clientes/Grd_Clientes2, 8 colunas: Grupo/NomeGrupo/Conta/Nome +
1399:     * CheckE/CheckP/CheckC/CheckA). ColumnOrder transcrito do dump (a ordem
1400:     * visual NAO segue a ordem numerica das colunas).
1401:     *--------------------------------------------------------------------------

*-- Linhas 1408 a 1417:
1408:         *-- grdTipo
1409:         par_oPag.AddObject("grd_4c_Tipos", "Grid")
1410:         WITH par_oPag.grd_4c_Tipos
1411:             .Top = 100
1412:             .Left = 624
1413:             .Width = 259
1414:             .Height = 275
1415:             .FontName = "Tahoma"
1416:             .AllowHeaderSizing = .F.
1417:             .AllowRowSizing = .F.

*-- Linhas 1433 a 1456:
1433:             .Column1.Width = 17
1434:             .Column1.Alignment = 0
1435:             .Column1.Sparse = .F.
1436:             .Column1.Header1.Caption = ""
1437:             .Column1.AddObject("Check1", "CheckBox")
1438:             .Column1.Check1.Top = 23
1439:             .Column1.Check1.Left = 35
1440:             .Column1.Check1.Width = 60
1441:             .Column1.Check1.Height = 17
1442:             .Column1.Check1.Caption = ""
1443:             .Column1.CurrentControl = "Check1"
1444: 
1445:             .Column2.ControlSource = loc_cTipos + ".Dopes"
1446:             .Column2.Width = 220
1447:             .Column2.Movable = .F.
1448:             .Column2.Resizable = .F.
1449:             .Column2.ReadOnly = .T.
1450:             .Column2.Text1.ReadOnly = .T.
1451:             .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o de T" + CHR(237) + "tulos"
1452:             .Column2.Header1.Alignment = 2
1453:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
1454: 
1455:             .Visible = .T.
1456:         ENDWITH

*-- Linhas 1510 a 1519:
1510:         loc_oGrid = EVALUATE("par_oPag." + par_cNomeGrid)
1511: 
1512:         WITH loc_oGrid
1513:             .Top = par_nTop
1514:             .Left = 81
1515:             .Width = 802
1516:             .Height = par_nHeight
1517:             .FontName = "Tahoma"
1518:             .AllowHeaderSizing = .F.
1519:             .AllowRowSizing = .F.

*-- Linhas 1534 a 1638:
1534:             .Column1.Movable = .F.
1535:             .Column1.Resizable = .F.
1536:             .Column1.Text1.MaxLength = 10
1537:             .Column1.Header1.Caption = "Grupo"
1538:             .Column1.Header1.Alignment = 2
1539:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
1540: 
1541:             .Column4.ColumnOrder = 2
1542:             .Column4.ControlSource = par_cCursor + ".NomeGrupo"
1543:             .Column4.Width = 166
1544:             .Column4.Text1.MaxLength = 20
1545:             .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1546:             .Column4.Header1.Alignment = 2
1547:             .Column4.Header1.ForeColor = RGB(90, 90, 90)
1548: 
1549:             .Column2.ColumnOrder = 3
1550:             .Column2.ControlSource = par_cCursor + ".Conta"
1551:             .Column2.Width = 90
1552:             .Column2.Movable = .F.
1553:             .Column2.Resizable = .F.
1554:             .Column2.Text1.MaxLength = 10
1555:             .Column2.Header1.Caption = "Conta"
1556:             .Column2.Header1.Alignment = 2
1557:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
1558: 
1559:             .Column3.ColumnOrder = 4
1560:             .Column3.ControlSource = par_cCursor + ".Nome"
1561:             .Column3.Width = 360
1562:             .Column3.Movable = .F.
1563:             .Column3.Resizable = .F.
1564:             .Column3.Text1.MaxLength = 50
1565:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1566:             .Column3.Header1.Alignment = 2
1567:             .Column3.Header1.ForeColor = RGB(90, 90, 90)
1568: 
1569:             .Column5.ControlSource = par_cCursor + ".CheckE"
1570:             .Column5.Width = 17
1571:             .Column5.Sparse = .F.
1572:             .Column5.ToolTipText = "Emitente"
1573:             .Column5.Header1.Caption = "E"
1574:             .Column5.Header1.Alignment = 2
1575:             .Column5.Header1.ForeColor = RGB(90, 90, 90)
1576:             .Column5.Header1.ToolTipText = "Emitente"
1577:             .Column5.AddObject("Check1", "CheckBox")
1578:             .Column5.Check1.Top = 31
1579:             .Column5.Check1.Left = 9
1580:             .Column5.Check1.Width = 60
1581:             .Column5.Check1.Height = 17
1582:             .Column5.Check1.Caption = ""
1583:             .Column5.Check1.ToolTipText = "Emitente"
1584:             .Column5.CurrentControl = "Check1"
1585: 
1586:             .Column6.ControlSource = par_cCursor + ".CheckP"
1587:             .Column6.Width = 17
1588:             .Column6.Sparse = .F.
1589:             .Column6.ToolTipText = "Portador"
1590:             .Column6.Header1.Caption = "P"
1591:             .Column6.Header1.Alignment = 2
1592:             .Column6.Header1.ForeColor = RGB(90, 90, 90)
1593:             .Column6.Header1.ToolTipText = "Portador"
1594:             .Column6.AddObject("Check1", "CheckBox")
1595:             .Column6.Check1.Top = 31
1596:             .Column6.Check1.Left = 9
1597:             .Column6.Check1.Width = 60
1598:             .Column6.Check1.Height = 17
1599:             .Column6.Check1.Caption = ""
1600:             .Column6.Check1.ToolTipText = "Portador"
1601:             .Column6.CurrentControl = "Check1"
1602: 
1603:             .Column7.ControlSource = par_cCursor + ".CheckC"
1604:             .Column7.Width = 17
1605:             .Column7.Sparse = .F.
1606:             .Column7.ToolTipText = "Centro de Custo"
1607:             .Column7.Header1.Caption = "C"
1608:             .Column7.Header1.Alignment = 2
1609:             .Column7.Header1.ForeColor = RGB(90, 90, 90)
1610:             .Column7.Header1.ToolTipText = "Centro de Custo"
1611:             .Column7.AddObject("Check1", "CheckBox")
1612:             .Column7.Check1.Top = 30
1613:             .Column7.Check1.Left = 9
1614:             .Column7.Check1.Width = 60
1615:             .Column7.Check1.Height = 17
1616:             .Column7.Check1.Caption = ""
1617:             .Column7.Check1.ToolTipText = "Centro de Custo"
1618:             .Column7.CurrentControl = "Check1"
1619: 
1620:             .Column8.ControlSource = par_cCursor + ".CheckA"
1621:             .Column8.Width = 17
1622:             .Column8.Sparse = .F.
1623:             .Column8.ToolTipText = "Agente Cobrador"
1624:             .Column8.Header1.Caption = "A"
1625:             .Column8.Header1.Alignment = 2
1626:             .Column8.Header1.ForeColor = RGB(90, 90, 90)
1627:             .Column8.Header1.ToolTipText = "Agente Cobrador"
1628:             .Column8.AddObject("Check1", "CheckBox")
1629:             .Column8.Check1.Top = 33
1630:             .Column8.Check1.Left = 11
1631:             .Column8.Check1.Width = 60
1632:             .Column8.Check1.Height = 17
1633:             .Column8.Check1.Caption = ""
1634:             .Column8.Check1.ToolTipText = "Agente Cobrador"
1635:             .Column8.CurrentControl = "Check1"
1636: 
1637:             .Visible = .T.
1638:         ENDWITH

*-- Linhas 1645 a 1896:
1645:     *--------------------------------------------------------------------------
1646:     PROTECTED PROCEDURE ConfigurarBotoesFiltros(par_oPag)
1647:         *-- grdTipo: Apaga (desmarca tudo) / SelTudo (marca tudo)
1648:         par_oPag.AddObject("cmd_4c_SelTudo", "CommandButton")
1649:         WITH par_oPag.cmd_4c_SelTudo
1650:             .Top = 295
1651:             .Left = 892
1652:             .Width = 40
1653:             .Height = 40
1654:             .FontName = "Verdana"
1655:             .FontSize = 8
1656:             .WordWrap = .T.
1657:             .Caption = ""
1658:             .Picture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1659:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1660:             .ToolTipText = "Seleciona Tudo"
1661:             .ForeColor = RGB(36, 84, 155)
1662:             .BackColor = RGB(255, 255, 255)
1663:             .Themes = .T.
1664:             .Visible = .T.
1665:         ENDWITH
1666: 
1667:         par_oPag.AddObject("cmd_4c_Apaga", "CommandButton")
1668:         WITH par_oPag.cmd_4c_Apaga
1669:             .Top = 335
1670:             .Left = 892
1671:             .Width = 40
1672:             .Height = 40
1673:             .FontName = "Verdana"
1674:             .FontSize = 8
1675:             .WordWrap = .T.
1676:             .Caption = ""
1677:             .Picture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
1678:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
1679:             .ToolTipText = "Apaga Tudo"
1680:             .ForeColor = RGB(36, 84, 155)
1681:             .BackColor = RGB(255, 255, 255)
1682:             .Themes = .T.
1683:             .Visible = .T.
1684:         ENDWITH
1685: 
1686:         *-- Grd_Clientes: Inserir/Excluir/ApagaG1
1687:         par_oPag.AddObject("cmd_4c_Inserir", "CommandButton")
1688:         WITH par_oPag.cmd_4c_Inserir
1689:             .Top = 436
1690:             .Left = 892
1691:             .Width = 40
1692:             .Height = 40
1693:             .FontName = "Verdana"
1694:             .FontSize = 8
1695:             .WordWrap = .T.
1696:             .Caption = ""
1697:             .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1698:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1699:             .ToolTipText = "Insere Linha Em Branco na Grade"
1700:             .ForeColor = RGB(36, 84, 155)
1701:             .BackColor = RGB(255, 255, 255)
1702:             .Themes = .T.
1703:             .Visible = .T.
1704:         ENDWITH
1705: 
1706:         par_oPag.AddObject("cmd_4c_Excluir", "CommandButton")
1707:         WITH par_oPag.cmd_4c_Excluir
1708:             .Top = 476
1709:             .Left = 892
1710:             .Width = 40
1711:             .Height = 40
1712:             .FontName = "Verdana"
1713:             .FontSize = 8
1714:             .WordWrap = .T.
1715:             .Caption = ""
1716:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1717:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1718:             .ToolTipText = "Apaga Linha da Grade"
1719:             .ForeColor = RGB(36, 84, 155)
1720:             .BackColor = RGB(255, 255, 255)
1721:             .Themes = .T.
1722:             .Visible = .T.
1723:         ENDWITH
1724: 
1725:         par_oPag.AddObject("cmd_4c_ApagaG1", "CommandButton")
1726:         WITH par_oPag.cmd_4c_ApagaG1
1727:             .Top = 516
1728:             .Left = 892
1729:             .Width = 40
1730:             .Height = 40
1731:             .FontName = "Verdana"
1732:             .FontSize = 8
1733:             .WordWrap = .T.
1734:             .Caption = ""
1735:             .Picture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1736:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1737:             .ToolTipText = "Apaga TODAS as Linhas da Grade"
1738:             .ForeColor = RGB(36, 84, 155)
1739:             .BackColor = RGB(255, 255, 255)
1740:             .Themes = .T.
1741:             .Visible = .T.
1742:         ENDWITH
1743: 
1744:         *-- Grd_Clientes2: Inserir/Excluir/ApagaG2
1745:         par_oPag.AddObject("cmd_4c_Inserir2", "CommandButton")
1746:         WITH par_oPag.cmd_4c_Inserir2
1747:             .Top = 568
1748:             .Left = 892
1749:             .Width = 40
1750:             .Height = 40
1751:             .FontName = "Verdana"
1752:             .FontSize = 8
1753:             .WordWrap = .T.
1754:             .Caption = ""
1755:             .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1756:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1757:             .ToolTipText = "Insere Linha Em Branco na Grade"
1758:             .ForeColor = RGB(36, 84, 155)
1759:             .BackColor = RGB(255, 255, 255)
1760:             .Themes = .T.
1761:             .Visible = .T.
1762:         ENDWITH
1763: 
1764:         par_oPag.AddObject("cmd_4c_Excluir2", "CommandButton")
1765:         WITH par_oPag.cmd_4c_Excluir2
1766:             .Top = 608
1767:             .Left = 892
1768:             .Width = 40
1769:             .Height = 40
1770:             .FontName = "Verdana"
1771:             .FontSize = 8
1772:             .WordWrap = .T.
1773:             .Caption = ""
1774:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1775:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1776:             .ToolTipText = "Apaga Linha da Grade"
1777:             .ForeColor = RGB(36, 84, 155)
1778:             .BackColor = RGB(255, 255, 255)
1779:             .Themes = .T.
1780:             .Visible = .T.
1781:         ENDWITH
1782: 
1783:         par_oPag.AddObject("cmd_4c_ApagaG2", "CommandButton")
1784:         WITH par_oPag.cmd_4c_ApagaG2
1785:             .Top = 648
1786:             .Left = 892
1787:             .Width = 40
1788:             .Height = 40
1789:             .FontName = "Verdana"
1790:             .FontSize = 8
1791:             .WordWrap = .T.
1792:             .Caption = ""
1793:             .Picture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1794:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1795:             .ToolTipText = "Apaga TODAS as Linhas da Grade"
1796:             .ForeColor = RGB(36, 84, 155)
1797:             .BackColor = RGB(255, 255, 255)
1798:             .Themes = .T.
1799:             .Visible = .T.
1800:         ENDWITH
1801: 
1802:         *-- Filtro nomeado: AddFiltro/DelFiltro/RecFiltro
1803:         par_oPag.AddObject("cmd_4c_AddFiltro", "CommandButton")
1804:         WITH par_oPag.cmd_4c_AddFiltro
1805:             .Top = 95
1806:             .Left = 505
1807:             .Width = 32
1808:             .Height = 32
1809:             .FontName = "Verdana"
1810:             .FontSize = 8
1811:             .WordWrap = .T.
1812:             .Caption = ""
1813:             .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1814:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1815:             .ToolTipText = "Adicionar Filtro"
1816:             .ForeColor = RGB(36, 84, 155)
1817:             .BackColor = RGB(255, 255, 255)
1818:             .Themes = .T.
1819:             .Visible = .T.
1820:         ENDWITH
1821: 
1822:         par_oPag.AddObject("cmd_4c_DelFiltro", "CommandButton")
1823:         WITH par_oPag.cmd_4c_DelFiltro
1824:             .Top = 95
1825:             .Left = 537
1826:             .Width = 32
1827:             .Height = 32
1828:             .FontName = "Verdana"
1829:             .FontSize = 8
1830:             .WordWrap = .T.
1831:             .Caption = ""
1832:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1833:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1834:             .ToolTipText = "Apagar Filtro"
1835:             .ForeColor = RGB(36, 84, 155)
1836:             .BackColor = RGB(255, 255, 255)
1837:             .Themes = .T.
1838:             .Visible = .T.
1839:         ENDWITH
1840: 
1841:         par_oPag.AddObject("cmd_4c_RecFiltro", "CommandButton")
1842:         WITH par_oPag.cmd_4c_RecFiltro
1843:             .Top = 95
1844:             .Left = 569
1845:             .Width = 32
1846:             .Height = 32
1847:             .FontName = "Verdana"
1848:             .FontSize = 8
1849:             .WordWrap = .T.
1850:             .Caption = ""
1851:             .Picture = gc_4c_CaminhoIcones + "geral_disco2_26.jpg"
1852:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_disco2_26.jpg"
1853:             .ToolTipText = "Gravar Filtro"
1854:             .ForeColor = RGB(36, 84, 155)
1855:             .BackColor = RGB(255, 255, 255)
1856:             .Themes = .T.
1857:             .Visible = .T.
1858:         ENDWITH
1859: 
1860:         *-- F.Publicidade: Carregar clientes para a grade 1
1861:         par_oPag.AddObject("cmd_4c_Carregar", "CommandButton")
1862:         WITH par_oPag.cmd_4c_Carregar
1863:             .Top = 384
1864:             .Left = 843
1865:             .Width = 40
1866:             .Height = 40
1867:             .FontName = "Verdana"
1868:             .FontSize = 8
1869:             .WordWrap = .T.
1870:             .Caption = ""
1871:             .Picture = gc_4c_CaminhoIcones + "cadastro_seta_baixo_20.jpg"
1872:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_seta_baixo_20.jpg"
1873:             .ToolTipText = "Insere Linha Em Branco na Grade"
1874:             .ForeColor = RGB(36, 84, 155)
1875:             .BackColor = RGB(255, 255, 255)
1876:             .Themes = .T.
1877:             .Visible = .T.
1878:         ENDWITH
1879: 
1880:         BINDEVENT(par_oPag.cmd_4c_SelTudo,   "Click", THIS, "SelTudoClick")
1881:         BINDEVENT(par_oPag.cmd_4c_Apaga,     "Click", THIS, "ApagaClick")
1882:         BINDEVENT(par_oPag.cmd_4c_Inserir,   "Click", THIS, "BtnInserirClick")
1883:         BINDEVENT(par_oPag.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
1884:         BINDEVENT(par_oPag.cmd_4c_ApagaG1,   "Click", THIS, "BtnApagaG1Click")
1885:         BINDEVENT(par_oPag.cmd_4c_Inserir2,  "Click", THIS, "BtnInserir2Click")
1886:         BINDEVENT(par_oPag.cmd_4c_Excluir2,  "Click", THIS, "BtnExcluir2Click")
1887:         BINDEVENT(par_oPag.cmd_4c_ApagaG2,   "Click", THIS, "BtnApagaG2Click")
1888:         BINDEVENT(par_oPag.cmd_4c_AddFiltro, "Click", THIS, "CmdAddFiltroClick")
1889:         BINDEVENT(par_oPag.cmd_4c_DelFiltro, "Click", THIS, "CmdDelFiltroClick")
1890:         BINDEVENT(par_oPag.cmd_4c_RecFiltro, "Click", THIS, "BtnRecFiltroClick")
1891:         BINDEVENT(par_oPag.cmd_4c_Carregar,  "Click", THIS, "BtnCarregarClick")
1892:     ENDPROC
1893: 
1894:     *==========================================================================
1895:     * FASE 6 - Lookups de Page1 (Moeda Filtro/Conversao/Saldo, Forma de
1896:     * Publicidade, Especie da NF, Titulo Banco). Transcritos dos PROCEDURE

*-- Linhas 2282 a 2290:
2282:     * PRIMEIRA METADE dos campos de detalhe do registro selecionado na grade
2283:     * (Ordem/Nota Fiscal/Especie/Empresa/Emitente/Portador). A segunda metade
2284:     * dos campos (Centro de Custo/Agente Cobrador/Titulo Banco/Historico/
2285:     * Saldo Inicial/grupos/checkbox Totais/memo de filtros) e o grid
2286:     * grdDados1 ficam para a fase seguinte. Nomes e geometria transcritos de
2287:     * tasks\task691\SIGOPCGF_form_codigo_fonte.txt (SECAO 2).
2288:     *==========================================================================
2289: 
2290:     *--------------------------------------------------------------------------

*-- Linhas 2311 a 2521:
2311:     PROTECTED PROCEDURE ConfigurarBotoesAcaoDados(par_oPag)
2312:         par_oPag.AddObject("shp_4c_Shape1", "Shape")
2313:         WITH par_oPag.shp_4c_Shape1
2314:             .Top         = 83
2315:             .Left        = 6
2316:             .Width       = 462
2317:             .Height      = 88
2318:             .BackStyle   = 0
2319:             .BorderStyle = 0
2320:             .BorderColor = RGB(136, 189, 188)
2321:             .Visible     = .T.
2322:         ENDWITH
2323: 
2324:         *-- cmgRetornar - CommandGroup com 1 botao, volta para a Page1 (Filtros)
2325:         par_oPag.AddObject("obj_4c_CmgRetornar", "CommandGroup")
2326:         WITH par_oPag.obj_4c_CmgRetornar
2327:             .Top         = -2
2328:             .Left        = 918
2329:             .Width       = 85
2330:             .Height      = 85
2331:             .ButtonCount = 1
2332:             .BackStyle   = 0
2333:             .BorderStyle = 0
2334:             .Themes      = .F.
2335:             .Visible     = .T.
2336: 
2337:             WITH .Buttons(1)
2338:                 .Top         = 5
2339:                 .Left        = 5
2340:                 .Width       = 75
2341:                 .Height      = 75
2342:                 .FontName    = "Comic Sans MS"
2343:                 .FontSize    = 8
2344:                 .FontBold    = .T.
2345:                 .FontItalic  = .T.
2346:                 .Caption     = "Retornar"
2347:                 .ToolTipText = "Retornar aos Filtros"
2348:                 .ForeColor   = RGB(90, 90, 90)
2349:                 .BackColor   = RGB(255, 255, 255)
2350:                 .Themes      = .F.
2351:                 .Cancel      = .T.
2352:                 .Picture     = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
2353:             ENDWITH
2354:         ENDWITH
2355:         BINDEVENT(par_oPag.obj_4c_CmgRetornar, "Click", THIS, "CmgRetornarClick")
2356: 
2357:         *-- Recebimento
2358:         par_oPag.AddObject("cmd_4c_BtnRecebe", "CommandButton")
2359:         WITH par_oPag.cmd_4c_BtnRecebe
2360:             .Top             = 88
2361:             .Left            = 12
2362:             .Width           = 75
2363:             .Height          = 75
2364:             .FontName        = "Comic Sans MS"
2365:             .FontSize        = 8
2366:             .FontBold        = .T.
2367:             .FontItalic      = .T.
2368:             .Caption         = "\<Recebimento"
2369:             .ToolTipText     = "Recebimentos"
2370:             .ForeColor       = RGB(90, 90, 90)
2371:             .BackColor       = RGB(255, 255, 255)
2372:             .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
2373:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
2374:             .Themes          = .T.
2375:             .Visible         = .T.
2376:         ENDWITH
2377:         BINDEVENT(par_oPag.cmd_4c_BtnRecebe, "Click", THIS, "BtnRecebeClick")
2378: 
2379:         *-- Movimento
2380:         par_oPag.AddObject("cmd_4c_BtnMovimento", "CommandButton")
2381:         WITH par_oPag.cmd_4c_BtnMovimento
2382:             .Top             = 88
2383:             .Left            = 87
2384:             .Width           = 75
2385:             .Height          = 75
2386:             .FontName        = "Comic Sans MS"
2387:             .FontSize        = 8
2388:             .FontBold        = .T.
2389:             .FontItalic      = .T.
2390:             .Caption         = "\<Movimento"
2391:             .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o"
2392:             .ForeColor       = RGB(90, 90, 90)
2393:             .BackColor       = RGB(255, 255, 255)
2394:             .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
2395:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
2396:             .Themes          = .T.
2397:             .Visible         = .T.
2398:         ENDWITH
2399:         BINDEVENT(par_oPag.cmd_4c_BtnMovimento, "Click", THIS, "BtnMovimentoClick")
2400: 
2401:         *-- Follow-up da Conta
2402:         par_oPag.AddObject("cmd_4c_BtnFollowUpC", "CommandButton")
2403:         WITH par_oPag.cmd_4c_BtnFollowUpC
2404:             .Top             = 88
2405:             .Left            = 162
2406:             .Width           = 75
2407:             .Height          = 75
2408:             .FontName        = "Comic Sans MS"
2409:             .FontSize        = 8
2410:             .FontBold        = .T.
2411:             .FontItalic      = .T.
2412:             .WordWrap        = .T.
2413:             .Caption         = "Follo\<w-up Conta"
2414:             .ToolTipText     = "Follow-up da Conta "
2415:             .ForeColor       = RGB(90, 90, 90)
2416:             .BackColor       = RGB(255, 255, 255)
2417:             .Picture         = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
2418:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
2419:             .Themes          = .T.
2420:             .Visible         = .T.
2421:         ENDWITH
2422:         BINDEVENT(par_oPag.cmd_4c_BtnFollowUpC, "Click", THIS, "BtnFollowUpCClick")
2423: 
2424:         *-- Follow-up do Lancamento (Titulo)
2425:         par_oPag.AddObject("cmd_4c_BtnFollowUpL", "CommandButton")
2426:         WITH par_oPag.cmd_4c_BtnFollowUpL
2427:             .Top             = 88
2428:             .Left            = 237
2429:             .Width           = 75
2430:             .Height          = 75
2431:             .FontName        = "Comic Sans MS"
2432:             .FontSize        = 8
2433:             .FontBold        = .T.
2434:             .FontItalic      = .T.
2435:             .WordWrap        = .T.
2436:             .Caption         = "Follow-\<up Lan" + CHR(231) + "amento"
2437:             .ToolTipText     = "Follow-up do T" + CHR(237) + "tulo"
2438:             .ForeColor       = RGB(90, 90, 90)
2439:             .BackColor       = RGB(255, 255, 255)
2440:             .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
2441:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
2442:             .Themes          = .T.
2443:             .Visible         = .T.
2444:         ENDWITH
2445:         BINDEVENT(par_oPag.cmd_4c_BtnFollowUpL, "Click", THIS, "BtnFollowUpLClick")
2446: 
2447:         *-- Impressao
2448:         par_oPag.AddObject("cmd_4c_BtnImprimir", "CommandButton")
2449:         WITH par_oPag.cmd_4c_BtnImprimir
2450:             .Top             = 88
2451:             .Left            = 312
2452:             .Width           = 75
2453:             .Height          = 75
2454:             .FontName        = "Comic Sans MS"
2455:             .FontSize        = 8
2456:             .FontBold        = .T.
2457:             .FontItalic      = .T.
2458:             .Caption         = "Im\<press" + CHR(227) + "o"
2459:             .ToolTipText     = "Impress" + CHR(227) + "o"
2460:             .ForeColor       = RGB(90, 90, 90)
2461:             .BackColor       = RGB(255, 255, 255)
2462:             .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2463:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2464:             .Themes          = .T.
2465:             .Visible         = .T.
2466:         ENDWITH
2467:         BINDEVENT(par_oPag.cmd_4c_BtnImprimir, "Click", THIS, "BtnImprimirClick")
2468: 
2469:         *-- Planilha (Excel)
2470:         par_oPag.AddObject("cmd_4c_BtnPlanilha", "CommandButton")
2471:         WITH par_oPag.cmd_4c_BtnPlanilha
2472:             .Top             = 88
2473:             .Left            = 387
2474:             .Width           = 75
2475:             .Height          = 75
2476:             .FontName        = "Comic Sans MS"
2477:             .FontSize        = 8
2478:             .FontBold        = .T.
2479:             .FontItalic      = .T.
2480:             .Caption         = "Pla\<nilha"
2481:             .ToolTipText     = "Impress" + CHR(227) + "o"
2482:             .ForeColor       = RGB(90, 90, 90)
2483:             .BackColor       = RGB(255, 255, 255)
2484:             .Picture         = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
2485:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
2486:             .Themes          = .T.
2487:             .Visible         = .T.
2488:         ENDWITH
2489:         BINDEVENT(par_oPag.cmd_4c_BtnPlanilha, "Click", THIS, "BtnPlanilhaClick")
2490:     ENDPROC
2491: 
2492:     *--------------------------------------------------------------------------
2493:     * ConfigurarCamposDados1 - PRIMEIRA METADE dos campos de detalhe:
2494:     * combo de ordem da grade, Nota Fiscal, Especie, Empresa, Emitente e
2495:     * Portador (cada um com codigo + descricao). SCX: faixa Top=152..594,
2496:     * Left=17..992 (abaixo do grdDados1, que fica para a fase seguinte).
2497:     *--------------------------------------------------------------------------
2498:     PROTECTED PROCEDURE ConfigurarCamposDados1(par_oPag)
2499:         *-- Ordem da Grade (Moeda + ...)
2500:         par_oPag.AddObject("lbl_4c_Ordem", "Label")
2501:         WITH par_oPag.lbl_4c_Ordem
2502:             .Top       = 152
2503:             .Left      = 511
2504:             .Width     = 153
2505:             .AutoSize  = .T.
2506:             .FontName  = "Tahoma"
2507:             .FontSize  = 8
2508:             .ForeColor = RGB(90, 90, 90)
2509:             .Caption   = "\<Ordem da Grade (Moeda + ...) "
2510:             .Visible   = .T.
2511:         ENDWITH
2512: 
2513:         par_oPag.AddObject("cbo_4c_Ordem", "ComboBox")
2514:         WITH par_oPag.cbo_4c_Ordem
2515:             .Top               = 170
2516:             .Left              = 510
2517:             .Width             = 182
2518:             .Height            = 23
2519:             .Style             = 2
2520:             .RowSourceType     = 1
2521:             .RowSource         = "Emiss" + CHR(227) + "o,Vencimento,Lan" + CHR(231) + "amento,Baixa,Titulo,Historico,Emitente,Portador"

*-- Linhas 2531 a 2552:
2531:         BINDEVENT(par_oPag.cbo_4c_Ordem, "InteractiveChange", THIS, "CboOrdemInteractiveChange")
2532: 
2533:         *-- Nota Fiscal
2534:         par_oPag.AddObject("lbl_4c_NotaFiscal", "Label")
2535:         WITH par_oPag.lbl_4c_NotaFiscal
2536:             .Top       = 594
2537:             .Left      = 23
2538:             .FontName  = "Tahoma"
2539:             .ForeColor = RGB(90, 90, 90)
2540:             .Caption   = "Nota Fiscal :"
2541:             .Visible   = .T.
2542:         ENDWITH
2543: 
2544:         par_oPag.AddObject("txt_4c_NFs", "TextBox")
2545:         WITH par_oPag.txt_4c_NFs
2546:             .Top           = 590
2547:             .Left          = 89
2548:             .Width         = 100
2549:             .Height        = 23
2550:             .Value         = ""
2551:             .Format        = "K!"
2552:             .FontName      = "Tahoma"

*-- Linhas 2558 a 2608:
2558:         ENDWITH
2559: 
2560:         *-- Especie (da Nota Fiscal)
2561:         par_oPag.AddObject("lbl_4c_Especie", "Label")
2562:         WITH par_oPag.lbl_4c_Especie
2563:             .Top       = 594
2564:             .Left      = 212
2565:             .Width     = 45
2566:             .FontName  = "Tahoma"
2567:             .ForeColor = RGB(90, 90, 90)
2568:             .Caption   = "Esp" + CHR(233) + "cie :"
2569:             .Visible   = .T.
2570:         ENDWITH
2571: 
2572:         par_oPag.AddObject("txt_4c_EspecieNfs", "TextBox")
2573:         WITH par_oPag.txt_4c_EspecieNfs
2574:             .Top           = 590
2575:             .Left          = 262
2576:             .Width         = 52
2577:             .Height        = 23
2578:             .Value         = ""
2579:             .FontName      = "Tahoma"
2580:             .ForeColor     = RGB(0, 0, 0)
2581:             .SpecialEffect = 1
2582:             *-- legado getEspecieNfs (pgDados): When -> Return .f.
2583:             .ReadOnly      = .T.
2584:             .Visible       = .T.
2585:         ENDWITH
2586: 
2587:         *-- Empresa
2588:         par_oPag.AddObject("lbl_4c_Empresa", "Label")
2589:         WITH par_oPag.lbl_4c_Empresa
2590:             .Top       = 621
2591:             .Left      = 207
2592:             .Width     = 50
2593:             .Height    = 15
2594:             .FontName  = "Tahoma"
2595:             .ForeColor = RGB(90, 90, 90)
2596:             .Caption   = "Empresa :"
2597:             .Visible   = .T.
2598:         ENDWITH
2599: 
2600:         par_oPag.AddObject("txt_4c_Emps", "TextBox")
2601:         WITH par_oPag.txt_4c_Emps
2602:             .Top           = 617
2603:             .Left          = 262
2604:             .Width         = 52
2605:             .Height        = 23
2606:             .Value         = ""
2607:             .FontName      = "Tahoma"
2608:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 2614 a 2635:
2614:         ENDWITH
2615: 
2616:         *-- Emitente (codigo + razao social)
2617:         par_oPag.AddObject("lbl_4c_Emitente", "Label")
2618:         WITH par_oPag.lbl_4c_Emitente
2619:             .Top       = 568
2620:             .Left      = 403
2621:             .FontName  = "Tahoma"
2622:             .ForeColor = RGB(90, 90, 90)
2623:             .Caption   = "Emitente :"
2624:             .Visible   = .T.
2625:         ENDWITH
2626: 
2627:         par_oPag.AddObject("txt_4c_ContEms", "TextBox")
2628:         WITH par_oPag.txt_4c_ContEms
2629:             .Top           = 564
2630:             .Left          = 550
2631:             .Width         = 80
2632:             .Height        = 23
2633:             .Value         = ""
2634:             .FontName      = "Tahoma"
2635:             .FontSize      = 8

*-- Linhas 2641 a 2664:
2641:             .Visible       = .T.
2642:         ENDWITH
2643: 
2644:         par_oPag.AddObject("lbl_4c_BarraEmitente", "Label")
2645:         WITH par_oPag.lbl_4c_BarraEmitente
2646:             .Top       = 566
2647:             .Left      = 540
2648:             .FontName  = "Tahoma"
2649:             .FontSize  = 10
2650:             .FontBold  = .T.
2651:             .ForeColor = RGB(90, 90, 90)
2652:             .Caption   = "/"
2653:             .Visible   = .T.
2654:         ENDWITH
2655: 
2656:         par_oPag.AddObject("txt_4c_DContEms", "TextBox")
2657:         WITH par_oPag.txt_4c_DContEms
2658:             .Top           = 564
2659:             .Left          = 632
2660:             .Width         = 360
2661:             .Height        = 23
2662:             .Value         = ""
2663:             .FontName      = "Tahoma"
2664:             .FontSize      = 8

*-- Linhas 2670 a 2719:
2670:         ENDWITH
2671: 
2672:         *-- Portador (codigo + razao social)
2673:         par_oPag.AddObject("lbl_4c_Portador", "Label")
2674:         WITH par_oPag.lbl_4c_Portador
2675:             .Top       = 594
2676:             .Left      = 403
2677:             .FontName  = "Tahoma"
2678:             .ForeColor = RGB(90, 90, 90)
2679:             .Caption   = "Portador :"
2680:             .Visible   = .T.
2681:         ENDWITH
2682: 
2683:         par_oPag.AddObject("txt_4c_Contas", "TextBox")
2684:         WITH par_oPag.txt_4c_Contas
2685:             .Top           = 590
2686:             .Left          = 550
2687:             .Width         = 80
2688:             .Height        = 23
2689:             .Value         = ""
2690:             .FontName      = "Tahoma"
2691:             .FontSize      = 8
2692:             .ForeColor     = RGB(0, 0, 0)
2693:             .SpecialEffect = 1
2694:             *-- legado getContas (pgDados): When -> Return .f.
2695:             .ReadOnly      = .T.
2696:             .Visible       = .T.
2697:         ENDWITH
2698: 
2699:         par_oPag.AddObject("lbl_4c_BarraPortador", "Label")
2700:         WITH par_oPag.lbl_4c_BarraPortador
2701:             .Top       = 592
2702:             .Left      = 540
2703:             .FontName  = "Tahoma"
2704:             .FontSize  = 10
2705:             .FontBold  = .T.
2706:             .ForeColor = RGB(90, 90, 90)
2707:             .Caption   = "/"
2708:             .Visible   = .T.
2709:         ENDWITH
2710: 
2711:         par_oPag.AddObject("txt_4c_DContas", "TextBox")
2712:         WITH par_oPag.txt_4c_DContas
2713:             .Top           = 590
2714:             .Left          = 632
2715:             .Width         = 360
2716:             .Height        = 23
2717:             .Value         = ""
2718:             .FontName      = "Tahoma"
2719:             .FontSize      = 8

*-- Linhas 2729 a 2751:
2729:     * ConfigurarCamposDados2 - SEGUNDA METADE dos campos de detalhe: Grupo do
2730:     * Emitente/Portador (ao lado dos codigos ja criados em
2731:     * ConfigurarCamposDados1), Centro de Custo, Agente Cobrador, Historico,
2732:     * Titulo Banco, Saldo Inicial, checkbox Totais e memo de filtros
2733:     * aplicados. Todos espelham a linha selecionada em grd_4c_Dados (grid
2734:     * ainda nao criado - PROCEDURE When do legado retorna .F. em TODOS estes
2735:     * campos, ou seja, nunca sao digitaveis pelo usuario) - por isso
2736:     * ReadOnly = .T.. O grid grdDados1 e o preenchimento destes campos
2737:     * (AfterRowColChange) ficam para a fase de eventos/acoes, junto com
2738:     * Processamento/MontaGraded/CalcSaldo/Imprimir/Planilha (regra do SCX:
2739:     * esses sao os metodos customizados do form, listados no ClassInfo).
2740:     *--------------------------------------------------------------------------
2741:     PROTECTED PROCEDURE ConfigurarCamposDados2(par_oPag)
2742:         *-- Grupo do Emitente (ao lado de txt_4c_ContEms, ja criado)
2743:         par_oPag.AddObject("txt_4c_GrupEms", "TextBox")
2744:         WITH par_oPag.txt_4c_GrupEms
2745:             .Top           = 564
2746:             .Left          = 459
2747:             .Width         = 80
2748:             .Height        = 23
2749:             .Value         = ""
2750:             .Format        = "K!"
2751:             .FontName      = "Tahoma"

*-- Linhas 2758 a 2793:
2758:         *-- Grupo do Portador (ao lado de txt_4c_Contas, ja criado)
2759:         par_oPag.AddObject("txt_4c_Grupo", "TextBox")
2760:         WITH par_oPag.txt_4c_Grupo
2761:             .Top           = 590
2762:             .Left          = 459
2763:             .Width         = 80
2764:             .Height        = 23
2765:             .Value         = ""
2766:             .Format        = "K!"
2767:             .FontName      = "Tahoma"
2768:             .ForeColor     = RGB(0, 0, 0)
2769:             .SpecialEffect = 1
2770:             .ReadOnly      = .T.
2771:             .Visible       = .T.
2772:         ENDWITH
2773: 
2774:         *-- Centro de Custo (Grupo + codigo + "/" + descricao)
2775:         par_oPag.AddObject("lbl_4c_CentroCusto", "Label")
2776:         WITH par_oPag.lbl_4c_CentroCusto
2777:             .Top       = 621
2778:             .Left      = 366
2779:             .FontName  = "Tahoma"
2780:             .ForeColor = RGB(90, 90, 90)
2781:             .Caption   = "Centro de Custo :"
2782:             .Visible   = .T.
2783:         ENDWITH
2784: 
2785:         par_oPag.AddObject("txt_4c_SGrupos", "TextBox")
2786:         WITH par_oPag.txt_4c_SGrupos
2787:             .Top           = 617
2788:             .Left          = 459
2789:             .Width         = 80
2790:             .Height        = 23
2791:             .Value         = ""
2792:             .Format        = "K!"
2793:             .FontName      = "Tahoma"

*-- Linhas 2799 a 2861:
2799: 
2800:         par_oPag.AddObject("txt_4c_SContas", "TextBox")
2801:         WITH par_oPag.txt_4c_SContas
2802:             .Top           = 617
2803:             .Left          = 550
2804:             .Width         = 80
2805:             .Height        = 23
2806:             .Value         = ""
2807:             .FontName      = "Tahoma"
2808:             .FontSize      = 8
2809:             .ForeColor     = RGB(0, 0, 0)
2810:             .SpecialEffect = 1
2811:             .ReadOnly      = .T.
2812:             .Visible       = .T.
2813:         ENDWITH
2814: 
2815:         par_oPag.AddObject("lbl_4c_BarraCentroCusto", "Label")
2816:         WITH par_oPag.lbl_4c_BarraCentroCusto
2817:             .Top       = 619
2818:             .Left      = 540
2819:             .FontName  = "Tahoma"
2820:             .FontSize  = 10
2821:             .FontBold  = .T.
2822:             .ForeColor = RGB(90, 90, 90)
2823:             .Caption   = "/"
2824:             .Visible   = .T.
2825:         ENDWITH
2826: 
2827:         par_oPag.AddObject("txt_4c_DSContas", "TextBox")
2828:         WITH par_oPag.txt_4c_DSContas
2829:             .Top           = 617
2830:             .Left          = 632
2831:             .Width         = 360
2832:             .Height        = 23
2833:             .Value         = ""
2834:             .FontName      = "Tahoma"
2835:             .FontSize      = 8
2836:             .ForeColor     = RGB(0, 0, 0)
2837:             .SpecialEffect = 1
2838:             .ReadOnly      = .T.
2839:             .Visible       = .T.
2840:         ENDWITH
2841: 
2842:         *-- Agente Cobrador (Grupo + codigo + "/" + descricao)
2843:         par_oPag.AddObject("lbl_4c_AgenteCobrador", "Label")
2844:         WITH par_oPag.lbl_4c_AgenteCobrador
2845:             .Top       = 648
2846:             .Left      = 362
2847:             .FontName  = "Tahoma"
2848:             .ForeColor = RGB(90, 90, 90)
2849:             .Caption   = "Agente Cobrador :"
2850:             .Visible   = .T.
2851:         ENDWITH
2852: 
2853:         par_oPag.AddObject("txt_4c_GrupAges", "TextBox")
2854:         WITH par_oPag.txt_4c_GrupAges
2855:             .Top           = 644
2856:             .Left          = 459
2857:             .Width         = 80
2858:             .Height        = 23
2859:             .Value         = ""
2860:             .Format        = "K!"
2861:             .FontName      = "Tahoma"

*-- Linhas 2867 a 2988:
2867: 
2868:         par_oPag.AddObject("txt_4c_ContAges", "TextBox")
2869:         WITH par_oPag.txt_4c_ContAges
2870:             .Top           = 644
2871:             .Left          = 550
2872:             .Width         = 80
2873:             .Height        = 23
2874:             .Value         = ""
2875:             .FontName      = "Tahoma"
2876:             .FontSize      = 8
2877:             .ForeColor     = RGB(0, 0, 0)
2878:             .SpecialEffect = 1
2879:             .ReadOnly      = .T.
2880:             .Visible       = .T.
2881:         ENDWITH
2882: 
2883:         par_oPag.AddObject("lbl_4c_BarraAgenteCobrador", "Label")
2884:         WITH par_oPag.lbl_4c_BarraAgenteCobrador
2885:             .Top       = 646
2886:             .Left      = 540
2887:             .FontName  = "Tahoma"
2888:             .FontSize  = 10
2889:             .FontBold  = .T.
2890:             .ForeColor = RGB(90, 90, 90)
2891:             .Caption   = "/"
2892:             .Visible   = .T.
2893:         ENDWITH
2894: 
2895:         par_oPag.AddObject("txt_4c_DContAges", "TextBox")
2896:         WITH par_oPag.txt_4c_DContAges
2897:             .Top           = 644
2898:             .Left          = 632
2899:             .Width         = 360
2900:             .Height        = 23
2901:             .Value         = ""
2902:             .FontName      = "Tahoma"
2903:             .FontSize      = 8
2904:             .ForeColor     = RGB(0, 0, 0)
2905:             .SpecialEffect = 1
2906:             .ReadOnly      = .T.
2907:             .Visible       = .T.
2908:         ENDWITH
2909: 
2910:         *-- Historico
2911:         par_oPag.AddObject("lbl_4c_Historico", "Label")
2912:         WITH par_oPag.lbl_4c_Historico
2913:             .Top       = 568
2914:             .Left      = 34
2915:             .Width     = 50
2916:             .AutoSize  = .T.
2917:             .FontName  = "Tahoma"
2918:             .FontSize  = 8
2919:             .ForeColor = RGB(90, 90, 90)
2920:             .Caption   = "Hist" + CHR(243) + "rico :"
2921:             .Visible   = .T.
2922:         ENDWITH
2923: 
2924:         par_oPag.AddObject("txt_4c_Hist2s", "TextBox")
2925:         WITH par_oPag.txt_4c_Hist2s
2926:             .Top           = 564
2927:             .Left          = 89
2928:             .Width         = 290
2929:             .Height        = 23
2930:             .Value         = ""
2931:             .FontName      = "Tahoma"
2932:             .ForeColor     = RGB(0, 0, 0)
2933:             .SpecialEffect = 1
2934:             .ReadOnly      = .T.
2935:             .Visible       = .T.
2936:         ENDWITH
2937: 
2938:         *-- Titulo Banco
2939:         par_oPag.AddObject("lbl_4c_TituloBanco", "Label")
2940:         WITH par_oPag.lbl_4c_TituloBanco
2941:             .Top       = 621
2942:             .Left      = 17
2943:             .Width     = 67
2944:             .Height    = 15
2945:             .FontName  = "Tahoma"
2946:             .ForeColor = RGB(90, 90, 90)
2947:             .Caption   = "T" + CHR(237) + "tulo Banco :"
2948:             .Visible   = .T.
2949:         ENDWITH
2950: 
2951:         par_oPag.AddObject("txt_4c_TitBans", "TextBox")
2952:         WITH par_oPag.txt_4c_TitBans
2953:             .Top           = 617
2954:             .Left          = 89
2955:             .Width         = 100
2956:             .Height        = 23
2957:             .Value         = ""
2958:             .FontName      = "Tahoma"
2959:             .FontSize      = 8
2960:             .ForeColor     = RGB(0, 0, 0)
2961:             .SpecialEffect = 1
2962:             .ReadOnly      = .T.
2963:             .Visible       = .T.
2964:         ENDWITH
2965: 
2966:         *-- Saldo Inicial
2967:         par_oPag.AddObject("lbl_4c_SaldoInicial", "Label")
2968:         WITH par_oPag.lbl_4c_SaldoInicial
2969:             .Top       = 648
2970:             .Left      = 19
2971:             .Width     = 65
2972:             .AutoSize  = .T.
2973:             .FontName  = "Tahoma"
2974:             .FontSize  = 8
2975:             .ForeColor = RGB(90, 90, 90)
2976:             .Caption   = "Saldo Inicial :"
2977:             .Visible   = .T.
2978:         ENDWITH
2979: 
2980:         par_oPag.AddObject("txt_4c_ValOcurs", "TextBox")
2981:         WITH par_oPag.txt_4c_ValOcurs
2982:             .Top           = 644
2983:             .Left          = 89
2984:             .Width         = 100
2985:             .Height        = 23
2986:             .Alignment     = 1
2987:             .Value         = 0
2988:             .Format        = "K"

*-- Linhas 2997 a 3023:
2997: 
2998:         *-- Exibir Totalizadores (chkTotais) - liga/desliga totalizadores na
2999:         *-- ordenacao da grade (OrdenaGrade, fase de eventos/acoes)
3000:         par_oPag.AddObject("chk_4c_Totais", "CheckBox")
3001:         WITH par_oPag.chk_4c_Totais
3002:             .Top         = 174
3003:             .Left        = 697
3004:             .Caption     = "E\<xibir Totalizadores"
3005:             .Value       = 1
3006:             .FontName    = "Tahoma"
3007:             .ForeColor   = RGB(90, 90, 90)
3008:             .BackStyle   = 0
3009:             .Visible     = .T.
3010:         ENDWITH
3011:         BINDEVENT(par_oPag.chk_4c_Totais, "Click", THIS, "ChkTotaisClick")
3012: 
3013:         *-- Memo com a descricao dos filtros aplicados na consulta (somente
3014:         *-- exibicao - alterna altura 66/200 ao clicar, igual ao legado)
3015:         par_oPag.AddObject("obj_4c_GetFiltros", "EditBox")
3016:         WITH par_oPag.obj_4c_GetFiltros
3017:             .Top           = 83
3018:             .Left          = 510
3019:             .Width         = 381
3020:             .Height        = 66
3021:             .Value         = ""
3022:             .ReadOnly      = .T.
3023:             .FontName      = "Tahoma"

*-- Linhas 3031 a 3050:
3031:         *-- digitaveis (PROCEDURE When do legado retorna .f. nos 4).
3032:         par_oPag.AddObject("cnt_4c_Botoes", "Container")
3033:         WITH par_oPag.cnt_4c_Botoes
3034:             .Top         = 643
3035:             .Left        =  542
3036:             .Width       = 115
3037:             .Height      = 24
3038:             .BackStyle   = 0
3039:             .BorderWidth = 0
3040:             .Visible     = .T.
3041: 
3042:             .AddObject("txt_4c_Botao1", "TextBox")
3043:             WITH .txt_4c_Botao1
3044:                 .Top         = 1
3045:                 .Left        = 1
3046:                 .Width       = 29
3047:                 .Height      = 23
3048:                 .Alignment   = 0
3049:                 .Value       = ""
3050:                 .FontBold    = .T.

*-- Linhas 3059 a 3068:
3059: 
3060:             .AddObject("txt_4c_Botao2", "TextBox")
3061:             WITH .txt_4c_Botao2
3062:                 .Top         = 1
3063:                 .Left        = 29
3064:                 .Width       = 29
3065:                 .Height      = 23
3066:                 .Alignment   = 0
3067:                 .Value       = ""
3068:                 .FontBold    = .T.

*-- Linhas 3077 a 3086:
3077: 
3078:             .AddObject("txt_4c_Botao3", "TextBox")
3079:             WITH .txt_4c_Botao3
3080:                 .Top         = 1
3081:                 .Left        = 57
3082:                 .Width       = 29
3083:                 .Height      = 23
3084:                 .Alignment   = 0
3085:                 .Value       = ""
3086:                 .FontBold    = .T.

*-- Linhas 3095 a 3104:
3095: 
3096:             .AddObject("txt_4c_Botao4", "TextBox")
3097:             WITH .txt_4c_Botao4
3098:                 .Top         = 1
3099:                 .Left        = 86
3100:                 .Width       = 29
3101:                 .Height      = 23
3102:                 .Alignment   = 0
3103:                 .Value       = ""
3104:                 .FontBold    = .T.

*-- Linhas 3340 a 3349:
3340: 
3341:     *--------------------------------------------------------------------------
3342:     * AlternarFlagGrade - Alterna (0<->1) a coluna de flag de uma linha de
3343:     * grade (equivalente ao padrao de checkbox de Column regra #46/#185 -
3344:     * toggle feito por codigo, nunca pelo binding nativo do CheckBox).
3345:     *--------------------------------------------------------------------------
3346:     PROTECTED PROCEDURE AlternarFlagGrade(par_cCursor, par_cCampo, par_oGrid)
3347:         IF USED(par_cCursor)
3348:             SELECT (par_cCursor)
3349:             IF !EOF()

*-- Linhas 3902 a 3911:
3902:     PROTECTED PROCEDURE ConfigurarGradeDados(par_oPag)
3903:         par_oPag.AddObject("grd_4c_Dados", "Grid")
3904:         WITH par_oPag.grd_4c_Dados
3905:             .Top               = 202
3906:             .Left              = 7
3907:             .Width             = 986
3908:             .Height            = 355
3909:             .DeleteMark        = .F.
3910:             .RecordMark        = .F.
3911:             .ReadOnly          = .T.

*-- Linhas 3943 a 3997:
3943:         WITH loc_oGrid
3944:             .Column1.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtEmis)))"
3945:             .Column1.Width           = 64
3946:             .Column1.Header1.Caption = "Emiss" + CHR(227) + "o"
3947: 
3948:             .Column2.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Vencs)))"
3949:             .Column2.Width           = 64
3950:             .Column2.Header1.Caption = "Vencto."
3951: 
3952:             .Column3.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Datas)))"
3953:             .Column3.Width           = 64
3954:             .Column3.Header1.Caption = "Lancto."
3955: 
3956:             .Column4.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtBaixa)))"
3957:             .Column4.Width           = 64
3958:             .Column4.Header1.Caption = "Baixa"
3959: 
3960:             .Column5.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', " + loc_cCursor + ".Titulos)"
3961:             .Column5.Width           = 70
3962:             .Column5.Header1.Caption = "T" + CHR(237) + "tulo"
3963: 
3964:             .Column6.ControlSource   = loc_cCursor + ".Hists"
3965:             .Column6.Width           = 240
3966:             .Column6.Header1.Caption = "Hist" + CHR(243) + "rico"
3967: 
3968:             .Column7.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997, '', " + loc_cCursor + ".Moedas)"
3969:             .Column7.Width           = 20
3970:             .Column7.Header1.Caption = "$"
3971: 
3972:             .Column8.ControlSource   = loc_cCursor + ".Valors"
3973:             .Column8.Width           = 68
3974:             .Column8.Header1.Caption = "Valor"
3975: 
3976:             *-- Legado usa goSistema.TxtDebito/TxtCredito (rotulo customizavel
3977:             *-- por cliente) - essa customizacao NAO foi portada; caption fixo.
3978:             .Column9.ControlSource   = loc_cCursor + ".Debitos"
3979:             .Column9.Width           = 68
3980:             .Column9.Header1.Caption = "D" + CHR(233) + "bito"
3981: 
3982:             .Column10.ControlSource   = loc_cCursor + ".Creditos"
3983:             .Column10.Width           = 68
3984:             .Column10.Header1.Caption = "Cr" + CHR(233) + "dito"
3985: 
3986:             .Column11.ControlSource   = loc_cCursor + ".SaldoDia"
3987:             .Column11.Width           = 82
3988:             .Column11.Header1.Caption = "Saldo"
3989: 
3990:             .Column12.ControlSource   = loc_cCursor + ".SaldoTot"
3991:             .Column12.Width           = 82
3992:             .Column12.Header1.Caption = "Acumulado"
3993: 
3994:             .SetAll("DynamicBackColor", loc_cCor, "Column")
3995:             .FontName = "Arial"
3996:             .SetAll("Movable", .F., "Column")
3997:             .SetAll("Resizable", .F., "Column")

*-- Linhas 5616 a 5631:
5616:             loc_lHabilita = (loc_oBO.this_nLinNopers < 9999998) AND (loc_oBO.this_nLinSInis = 0)
5617:         ENDIF
5618: 
5619:         loc_oPag.cmd_4c_BtnMovimento.Enabled = loc_lHabilita
5620:         loc_oPag.cmd_4c_BtnRecebe.Enabled    = loc_lHabilita
5621:         loc_oPag.cmd_4c_BtnFollowUpC.Enabled = loc_lHabilita
5622:         loc_oPag.cmd_4c_BtnFollowUpL.Enabled = loc_lHabilita
5623: 
5624:         *-- O When do Imprimir tambem libera quando a ordem corrente e por
5625:         *-- Emitente/Portador (saldo por conta), mesmo em linha sintetica.
5626:         loc_oPag.cmd_4c_BtnImprimir.Enabled = loc_lHabilita OR ;
5627:             INLIST(loc_oBO.this_cOrdem, "ContEms", "Contas")
5628:     ENDPROC
5629: 
5630:     *--------------------------------------------------------------------------
5631:     * LimparCampos - Bloco de limpeza que o legado executa no inicio do

*-- Linhas 5758 a 5766:
5758:     * SerializarFiltros() (gravacao do filtro nomeado em SigSyPar) e por
5759:     * RestaurarFiltros() (para preservar o que nao esta no blob salvo).
5760:     *
5761:     * Conversoes explicitas obrigatorias: CheckBox.Value e NUMERICO (0/1) e
5762:     * nao pode ser atribuido direto a property LOGICA; OptionGroup.Value e o
5763:     * INDICE 1-based e vai para property NUMERICA; o TextBox de valor pode
5764:     * trazer CARACTERE conforme o InputMask, dai o VARTYPE antes de usar.
5765:     *--------------------------------------------------------------------------
5766:     PROTECTED PROCEDURE FormParaBO()

*-- Linhas 5805 a 5813:
5805:         loc_oBO.this_cDFPublis = ALLTRIM(loc_oPag1.txt_4c_DFPublis.Value)
5806:         loc_oBO.this_cEmpresa  = ALLTRIM(loc_oPag1.txt_4c_Empresa.Value)
5807: 
5808:         *-- CheckBox.Value e NUMERICO - converter antes de ir para property logica
5809:         loc_oBO.this_lBrancos  = (loc_oPag1.chk_4c_Brancos.Value = 1)
5810:         loc_oBO.this_lValPends = (loc_oPag1.chk_4c_ValPends.Value = 1)
5811:         loc_oBO.this_lTotais   = (loc_oPag2.chk_4c_Totais.Value = 1)
5812: 
5813:         *-- OptionGroup.Value e o INDICE 1-based do botao selecionado

*-- Linhas 5837 a 5845:
5837:     *
5838:     * OptionGroup/ComboBox sao 1-based: o valor e sempre validado com BETWEEN
5839:     * para nunca atribuir 0 a um controle de indice (regra dos controles
5840:     * 1-based do CLAUDE.md). CheckBox recebe NUMERICO (1/0), nunca .T./.F.
5841:     *--------------------------------------------------------------------------
5842:     PROTECTED PROCEDURE BOParaForm()
5843:         LOCAL loc_oPag1, loc_oPag2, loc_oBO
5844: 
5845:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)


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

