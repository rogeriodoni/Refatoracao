# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [LAYOUT-POSITION] Controle 'optCalculo' (parent: SIGPRCFN): Top original=140 vs migrado 'obj_4c_OptCalculo' Top=2 (diff=138px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optCalculo' (parent: SIGPRCFN): Left original=351 vs migrado 'obj_4c_OptCalculo' Left=5 (diff=346px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optDias' (parent: SIGPRCFN): Top original=158 vs migrado 'obj_4c_OptDias' Top=2 (diff=156px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optDias' (parent: SIGPRCFN): Left original=351 vs migrado 'obj_4c_OptDias' Left=5 (diff=346px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCfn.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1835 linhas total):

*-- Linhas 34 a 42:
34: * FASE 7 - EVENTOS PRINCIPAIS DOS BOTOES
35: * ---------------------------------------
36: * O legado tem UM UNICO botao: btnOK (fwbtng, Caption "Sair", Click =
37: * "ThisForm.Release"), ja entregue na Fase 4 como cnt_4c_Saida.cmd_4c_Sair com
38: * o handler BtnSairClick. Os outros dois "commandgroup" do SCX tem
39: * ButtonCount = 0 e NAO sao botoes: Commandgroup1 (Height = 1) eh o filete
40: * divisorio e Commandgroup3 eh a moldura em volta do btnOK.
41: *
42: * NAO existem BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/

*-- Linhas 87 a 95:
87: *                     hook de FormBase. Chamado por AtualizarResultado,
88: *                     ValidarJurosMes e ValidarJurosDia.
89: *   BOParaForm      - caminho inverso, novo nesta fase. Referente: o bloco
90: *                     "With ThisForm / .getValorBase.Value = ..." do Init
91: *                     legado. Chamado por InicializarForm e LimparCampos.
92: *   HabilitarCampos - transcricao do bloco "llEnable" (7 alvos), que o legado
93: *                     repete IDENTICO no Init (.f.) e em getValorBase.Valid
94: *                     (.t.). Os dois chamadores reproduzem esses dois pontos.
95: *   LimparCampos    - zera BO + tela para o estado de abertura. Referente: o

*-- Linhas 232 a 241:
232:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
233: 
234:                 THIS.ConfigurarCabecalho()
235:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
236:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
237: 
238:                 THIS.ConfigurarCampos()
239:                 THIS.ConfigurarCamposResultado()
240:                 THIS.ConfigurarCamposVencimentos()
241:                 THIS.ConfigurarEventosCampos()

*-- Linhas 275 a 323:
275:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
276:         loc_oCnt = THIS.cnt_4c_Cabecalho
277:         WITH loc_oCnt
278:             .Top         = 0
279:             .Left        = 0
280:             .Width       = THIS.Width
281:             .Height      = 80
282:             .BorderWidth = 0
283:             .BackColor   = RGB(100, 100, 100)
284:             .Visible     = .T.
285:         ENDWITH
286: 
287:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
288:         WITH loc_oCnt.lbl_4c_Sombra
289:             .FontBold      = .T.
290:             .FontName      = "Tahoma"
291:             .FontSize      = 18
292:             .FontUnderline = .F.
293:             .WordWrap      = .T.
294:             .Alignment     = 0
295:             .BackStyle     = 0
296:             .AutoSize      = .F.
297:             .Caption       = THIS.Caption
298:             .Height        = 40
299:             .Left          = 10
300:             .Top           = 18
301:             .Width         = THIS.Width - 20
302:             .ForeColor     = RGB(0, 0, 0)
303:             .Visible       = .T.
304:         ENDWITH
305: 
306:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
307:         WITH loc_oCnt.lbl_4c_Titulo
308:             .FontBold   = .T.
309:             .FontName   = "Tahoma"
310:             .FontSize   = 18
311:             .WordWrap   = .T.
312:             .Alignment  = 0
313:             .BackStyle  = 0
314:             .AutoSize   = .F.
315:             .Caption    = THIS.Caption
316:             .Height     = 46
317:             .Left       = 10
318:             .Top        = 17
319:             .Width      = THIS.Width - 20
320:             .ForeColor  = RGB(255, 255, 255)
321:             .Visible    = .T.
322:         ENDWITH
323:     ENDPROC

*-- Linhas 347 a 452:
347:         loc_oBO = THIS.this_oBusinessObject
348: 
349:         *-- Valor Base (unico campo que nasce sempre habilitado)
350:         THIS.AddObject("lbl_4c_Label1", "Label")
351:         WITH THIS.lbl_4c_Label1
352:             .FontName  = "Tahoma"
353:             .FontSize  = 8
354:             .FontBold  = .F.
355:             .BackStyle = 0
356:             .AutoSize  = .F.
357:             .Alignment = 0
358:             .Left      = 36
359:             .Top       = 91
360:             .Width     = 57
361:             .Height    = 17
362:             .ForeColor = RGB(90, 90, 90)
363:             .Caption   = "Valor Base :"
364:             .Visible   = .T.
365:         ENDWITH
366: 
367:         THIS.AddObject("txt_4c_ValorBase", "TextBox")
368:         WITH THIS.txt_4c_ValorBase
369:             .FontName      = "Tahoma"
370:             .FontSize      = 8
371:             .Alignment     = 3
372:             .InputMask     = "99,999,999.99"
373:             .Left          = 97
374:             .Top           = 87
375:             .Width         = 115
376:             .Height        = 23
377:             .SpecialEffect = 1
378:             .ForeColor     = RGB(0, 0, 0)
379:             .BorderColor   = RGB(100, 100, 100)
380:             .Themes        = .F.
381:             .Value         = loc_oBO.this_nValorBase
382:             .Enabled       = .T.
383:             .Visible       = .T.
384:         ENDWITH
385: 
386:         *-- Data Base
387:         THIS.AddObject("lbl_4c_Label6", "Label")
388:         WITH THIS.lbl_4c_Label6
389:             .FontName  = "Tahoma"
390:             .FontSize  = 8
391:             .FontBold  = .F.
392:             .BackStyle = 0
393:             .AutoSize  = .F.
394:             .Alignment = 0
395:             .Left      = 295
396:             .Top       = 91
397:             .Width     = 56
398:             .Height    = 17
399:             .ForeColor = RGB(90, 90, 90)
400:             .Caption   = "Data Base :"
401:             .Visible   = .T.
402:         ENDWITH
403: 
404:         THIS.AddObject("txt_4c_DataBase", "TextBox")
405:         WITH THIS.txt_4c_DataBase
406:             .FontName      = "Tahoma"
407:             .FontSize      = 8
408:             .Alignment     = 3
409:             .Left          = 355
410:             .Top           = 87
411:             .Width         = 80
412:             .Height        = 23
413:             .SpecialEffect = 1
414:             .ForeColor     = RGB(0, 0, 0)
415:             .BorderColor   = RGB(100, 100, 100)
416:             .Themes        = .F.
417:             .Value         = loc_oBO.this_dDataBase
418:             .Enabled       = .F.
419:             .Visible       = .T.
420:         ENDWITH
421: 
422:         *-- Juros ao Mes
423:         THIS.AddObject("lbl_4c_Label3", "Label")
424:         WITH THIS.lbl_4c_Label3
425:             .FontName  = "Tahoma"
426:             .FontSize  = 8
427:             .FontBold  = .F.
428:             .BackStyle = 0
429:             .AutoSize  = .F.
430:             .Alignment = 0
431:             .Left      = 37
432:             .Top       = 119
433:             .Width     = 56
434:             .Height    = 17
435:             .ForeColor = RGB(90, 90, 90)
436:             .Caption   = "Juros/M" + CHR(234) + "s :"
437:             .Visible   = .T.
438:         ENDWITH
439: 
440:         THIS.AddObject("txt_4c_JurosMes", "TextBox")
441:         WITH THIS.txt_4c_JurosMes
442:             .FontName      = "Tahoma"
443:             .FontSize      = 8
444:             .Alignment     = 3
445:             .InputMask     = "9999.99"
446:             .Left          = 97
447:             .Top           = 115
448:             .Width         = 59
449:             .Height        = 23
450:             .SpecialEffect = 1
451:             .ForeColor     = RGB(0, 0, 0)
452:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 458 a 543:
458:             .Visible       = .T.
459:         ENDWITH
460: 
461:         THIS.AddObject("lbl_4c_Label4", "Label")
462:         WITH THIS.lbl_4c_Label4
463:             .FontName  = "Tahoma"
464:             .FontSize  = 8
465:             .FontBold  = .F.
466:             .BackStyle = 0
467:             .AutoSize  = .F.
468:             .Alignment = 0
469:             .Left      = 159
470:             .Top       = 119
471:             .Width     = 20
472:             .Height    = 17
473:             .ForeColor = RGB(90, 90, 90)
474:             .Caption   = "%"
475:             .Visible   = .T.
476:         ENDWITH
477: 
478:         *-- Data Final / Dias
479:         THIS.AddObject("lbl_4c_Label7", "Label")
480:         WITH THIS.lbl_4c_Label7
481:             .FontName  = "Tahoma"
482:             .FontSize  = 8
483:             .FontBold  = .F.
484:             .BackStyle = 0
485:             .AutoSize  = .F.
486:             .Alignment = 0
487:             .Left      = 266
488:             .Top       = 119
489:             .Width     = 85
490:             .Height    = 17
491:             .ForeColor = RGB(90, 90, 90)
492:             .Caption   = "Data Final / Dias :"
493:             .Visible   = .T.
494:         ENDWITH
495: 
496:         THIS.AddObject("txt_4c_DataFinal", "TextBox")
497:         WITH THIS.txt_4c_DataFinal
498:             .FontName      = "Tahoma"
499:             .FontSize      = 8
500:             .Alignment     = 3
501:             .Left          = 355
502:             .Top           = 115
503:             .Width         = 80
504:             .Height        = 23
505:             .SpecialEffect = 1
506:             .ForeColor     = RGB(0, 0, 0)
507:             .BorderColor   = RGB(100, 100, 100)
508:             .Themes        = .F.
509:             .Value         = loc_oBO.this_dDataFinal
510:             .Enabled       = .F.
511:             .Visible       = .T.
512:         ENDWITH
513: 
514:         THIS.AddObject("lbl_4c_Label8", "Label")
515:         WITH THIS.lbl_4c_Label8
516:             .FontName  = "Tahoma"
517:             .FontSize  = 8
518:             .FontBold  = .F.
519:             .BackStyle = 0
520:             .AutoSize  = .F.
521:             .Alignment = 0
522:             .Left      = 441
523:             .Top       = 116
524:             .Width     = 10
525:             .Height    = 17
526:             .ForeColor = RGB(90, 90, 90)
527:             .Caption   = "/"
528:             .Visible   = .T.
529:         ENDWITH
530: 
531:         THIS.AddObject("txt_4c_Dias", "TextBox")
532:         WITH THIS.txt_4c_Dias
533:             .FontName      = "Tahoma"
534:             .FontSize      = 8
535:             .Alignment     = 3
536:             .InputMask     = "9999"
537:             .Left          = 453
538:             .Top           = 115
539:             .Width         = 38
540:             .Height        = 23
541:             .SpecialEffect = 1
542:             .ForeColor     = RGB(0, 0, 0)
543:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 550 a 582:
550:         ENDWITH
551: 
552:         *-- Juros por Dia
553:         THIS.AddObject("lbl_4c_Label5", "Label")
554:         WITH THIS.lbl_4c_Label5
555:             .FontName  = "Tahoma"
556:             .FontSize  = 8
557:             .FontBold  = .F.
558:             .BackStyle = 0
559:             .AutoSize  = .F.
560:             .Alignment = 0
561:             .Left      = 23
562:             .Top       = 148
563:             .Width     = 70
564:             .Height    = 17
565:             .ForeColor = RGB(90, 90, 90)
566:             .Caption   = "Juros por Dia :"
567:             .Visible   = .T.
568:         ENDWITH
569: 
570:         THIS.AddObject("txt_4c_JurosDia", "TextBox")
571:         WITH THIS.txt_4c_JurosDia
572:             .FontName      = "Tahoma"
573:             .FontSize      = 8
574:             .Alignment     = 3
575:             .InputMask     = "9999.999999999"
576:             .Left          = 97
577:             .Top           = 144
578:             .Width         = 136
579:             .Height        = 23
580:             .SpecialEffect = 1
581:             .ForeColor     = RGB(0, 0, 0)
582:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 589 a 642:
589:         ENDWITH
590: 
591:         *-- Tipo de Calculo (Simples/Composto)
592:         THIS.AddObject("lbl_4c_Label2", "Label")
593:         WITH THIS.lbl_4c_Label2
594:             .FontName  = "Tahoma"
595:             .FontSize  = 8
596:             .FontBold  = .F.
597:             .BackStyle = 0
598:             .AutoSize  = .F.
599:             .Alignment = 0
600:             .Left      = 310
601:             .Top       = 143
602:             .Width     = 37
603:             .Height    = 17
604:             .ForeColor = RGB(90, 90, 90)
605:             .Caption   = "C" + CHR(225) + "lculo :"
606:             .Visible   = .T.
607:         ENDWITH
608: 
609:         THIS.AddObject("obj_4c_OptCalculo", "OptionGroup")
610:         WITH THIS.obj_4c_OptCalculo
611:             .Top         = 140
612:             .Left        = 351
613:             .Width       = 153
614:             .Height      = 21
615:             .BackStyle   = 0
616:             .BorderStyle = 0
617:             .ButtonCount = 2
618:             .Value       = loc_oBO.this_nTipoCalculo
619:             .Visible     = .T.
620:             WITH .Buttons(1)
621:                 .Caption           = "\<Simples"
622:                 .Top               = 2
623:                 .Left              = 5
624:                 .Width             = 76
625:                 .Height            = 17
626:                 .Style             = 0
627:                 .AutoSize          = .F.
628:                 .BackStyle         = 0
629:                 .ForeColor         = RGB(90, 90, 90)
630:                 .DisabledForeColor = RGB(128, 128, 128)
631:                 .Themes            = .F.
632:                 .Enabled           = .F.
633:             ENDWITH
634:             WITH .Buttons(2)
635:                 .Caption           = "\<Composto"
636:                 .Top               = 2
637:                 .Left              = 72
638:                 .Width             = 76
639:                 .Height            = 17
640:                 .Style             = 0
641:                 .AutoSize          = .F.
642:                 .BackStyle         = 0

*-- Linhas 648 a 701:
648:         ENDWITH
649: 
650:         *-- Tipo de Dias (Corridos/Uteis) - fora do grupo desabilitado
651:         THIS.AddObject("lbl_4c_Label13", "Label")
652:         WITH THIS.lbl_4c_Label13
653:             .FontName  = "Tahoma"
654:             .FontSize  = 8
655:             .FontBold  = .F.
656:             .BackStyle = 0
657:             .AutoSize  = .F.
658:             .Alignment = 0
659:             .Left      = 324
660:             .Top       = 161
661:             .Width     = 23
662:             .Height    = 17
663:             .ForeColor = RGB(90, 90, 90)
664:             .Caption   = "Dias :"
665:             .Visible   = .T.
666:         ENDWITH
667: 
668:         THIS.AddObject("obj_4c_OptDias", "OptionGroup")
669:         WITH THIS.obj_4c_OptDias
670:             .Top         = 158
671:             .Left        = 351
672:             .Width       = 153
673:             .Height      = 21
674:             .BackStyle   = 0
675:             .BorderStyle = 0
676:             .ButtonCount = 2
677:             .Value       = loc_oBO.this_nTipoDias
678:             .Visible     = .T.
679:             WITH .Buttons(1)
680:                 .Caption           = "Corridos"
681:                 .Top               = 2
682:                 .Left              = 5
683:                 .Width             = 76
684:                 .Height            = 17
685:                 .Style             = 0
686:                 .AutoSize          = .F.
687:                 .BackStyle         = 0
688:                 .ForeColor         = RGB(90, 90, 90)
689:                 .DisabledForeColor = RGB(128, 128, 128)
690:                 .Themes            = .F.
691:                 .Enabled           = .T.
692:             ENDWITH
693:             WITH .Buttons(2)
694:                 .Caption           = CHR(218) + "teis"
695:                 .Top               = 2
696:                 .Left              = 72
697:                 .Width             = 76
698:                 .Height            = 17
699:                 .Style             = 0
700:                 .AutoSize          = .F.
701:                 .BackStyle         = 0

*-- Linhas 725 a 758:
725:         loc_oBO = THIS.this_oBusinessObject
726: 
727:         *-- Juros (resultado)
728:         THIS.AddObject("lbl_4c_Label9", "Label")
729:         WITH THIS.lbl_4c_Label9
730:             .FontName  = "Tahoma"
731:             .FontSize  = 8
732:             .FontBold  = .F.
733:             .BackStyle = 0
734:             .AutoSize  = .F.
735:             .Alignment = 0
736:             .Left      = 60
737:             .Top       = 187
738:             .Width     = 33
739:             .Height    = 17
740:             .ForeColor = RGB(90, 90, 90)
741:             .Caption   = "Juros :"
742:             .Visible   = .T.
743:         ENDWITH
744: 
745:         THIS.AddObject("txt_4c_ValorJuros", "TextBox")
746:         WITH THIS.txt_4c_ValorJuros
747:             .FontName          = "Tahoma"
748:             .FontSize          = 8
749:             .FontBold          = .T.
750:             .Alignment         = 3
751:             .InputMask         = "999,999,999.99"
752:             .Left              = 97
753:             .Top               = 183
754:             .Width             = 136
755:             .Height            = 23
756:             .SpecialEffect     = 1
757:             .ForeColor         = RGB(0, 0, 0)
758:             .BackColor         = RGB(255, 253, 179)

*-- Linhas 766 a 799:
766:         ENDWITH
767: 
768:         *-- Total (resultado)
769:         THIS.AddObject("lbl_4c_Label10", "Label")
770:         WITH THIS.lbl_4c_Label10
771:             .FontName  = "Tahoma"
772:             .FontSize  = 8
773:             .FontBold  = .F.
774:             .BackStyle = 0
775:             .AutoSize  = .F.
776:             .Alignment = 0
777:             .Left      = 276
778:             .Top       = 187
779:             .Width     = 31
780:             .Height    = 17
781:             .ForeColor = RGB(90, 90, 90)
782:             .Caption   = "Total :"
783:             .Visible   = .T.
784:         ENDWITH
785: 
786:         THIS.AddObject("txt_4c_ValorTotal", "TextBox")
787:         WITH THIS.txt_4c_ValorTotal
788:             .FontName          = "Tahoma"
789:             .FontSize          = 8
790:             .FontBold          = .T.
791:             .Alignment         = 3
792:             .InputMask         = "999,999,999.99"
793:             .Left              = 311
794:             .Top               = 183
795:             .Width             = 136
796:             .Height            = 23
797:             .SpecialEffect     = 1
798:             .ForeColor         = RGB(0, 0, 0)
799:             .BackColor         = RGB(255, 253, 179)

*-- Linhas 807 a 840:
807:         ENDWITH
808: 
809:         *-- Parcela (resultado - "mena 11/12/2014" no legado)
810:         THIS.AddObject("lbl_4c_Label12", "Label")
811:         WITH THIS.lbl_4c_Label12
812:             .FontName  = "Tahoma"
813:             .FontSize  = 8
814:             .FontBold  = .F.
815:             .BackStyle = 0
816:             .AutoSize  = .F.
817:             .Alignment = 0
818:             .Left      = 265
819:             .Top       = 211
820:             .Width     = 42
821:             .Height    = 17
822:             .ForeColor = RGB(90, 90, 90)
823:             .Caption   = "Parcela :"
824:             .Visible   = .T.
825:         ENDWITH
826: 
827:         THIS.AddObject("txt_4c_Valorpar", "TextBox")
828:         WITH THIS.txt_4c_Valorpar
829:             .FontName          = "Tahoma"
830:             .FontSize          = 8
831:             .FontBold          = .T.
832:             .Alignment         = 3
833:             .InputMask         = "999,999,999.99"
834:             .Left              = 311
835:             .Top               = 207
836:             .Width             = 136
837:             .Height            = 23
838:             .SpecialEffect     = 1
839:             .ForeColor         = RGB(0, 0, 0)
840:             .BackColor         = RGB(255, 253, 179)

*-- Linhas 877 a 909:
877:         LOCAL loc_oBO
878:         loc_oBO = THIS.this_oBusinessObject
879: 
880:         THIS.AddObject("lbl_4c_Label11", "Label")
881:         WITH THIS.lbl_4c_Label11
882:             .FontName  = "Tahoma"
883:             .FontSize  = 8
884:             .FontBold  = .F.
885:             .BackStyle = 0
886:             .AutoSize  = .F.
887:             .Alignment = 0
888:             .Left      = 26
889:             .Top       = 235
890:             .Width     = 67
891:             .Height    = 17
892:             .ForeColor = RGB(90, 90, 90)
893:             .Caption   = "Vencimentos :"
894:             .Visible   = .T.
895:         ENDWITH
896: 
897: 
898:         THIS.AddObject("txt_4c_Venc1", "TextBox")
899:         WITH THIS.txt_4c_Venc1
900:             .FontName      = "Tahoma"
901:             .FontSize      = 8
902:             .Alignment     = 3
903:             .Left          = 97
904:             .Top           = 231
905:             .Width         = 80
906:             .Height        = 23
907:             .SpecialEffect = 1
908:             .ForeColor     = RGB(0, 0, 0)
909:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 918 a 927:
918:             .FontName      = "Tahoma"
919:             .FontSize      = 8
920:             .Alignment     = 3
921:             .Left          = 97
922:             .Top           = 258
923:             .Width         = 80
924:             .Height        = 23
925:             .SpecialEffect = 1
926:             .ForeColor     = RGB(0, 0, 0)
927:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 936 a 945:
936:             .FontName      = "Tahoma"
937:             .FontSize      = 8
938:             .Alignment     = 3
939:             .Left          = 184
940:             .Top           = 231
941:             .Width         = 80
942:             .Height        = 23
943:             .SpecialEffect = 1
944:             .ForeColor     = RGB(0, 0, 0)
945:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 954 a 963:
954:             .FontName      = "Tahoma"
955:             .FontSize      = 8
956:             .Alignment     = 3
957:             .Left          = 184
958:             .Top           = 258
959:             .Width         = 80
960:             .Height        = 23
961:             .SpecialEffect = 1
962:             .ForeColor     = RGB(0, 0, 0)
963:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 972 a 981:
972:             .FontName      = "Tahoma"
973:             .FontSize      = 8
974:             .Alignment     = 3
975:             .Left          = 271
976:             .Top           = 231
977:             .Width         = 80
978:             .Height        = 23
979:             .SpecialEffect = 1
980:             .ForeColor     = RGB(0, 0, 0)
981:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 990 a 999:
990:             .FontName      = "Tahoma"
991:             .FontSize      = 8
992:             .Alignment     = 3
993:             .Left          = 271
994:             .Top           = 258
995:             .Width         = 80
996:             .Height        = 23
997:             .SpecialEffect = 1
998:             .ForeColor     = RGB(0, 0, 0)
999:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1008 a 1017:
1008:             .FontName      = "Tahoma"
1009:             .FontSize      = 8
1010:             .Alignment     = 3
1011:             .Left          = 358
1012:             .Top           = 231
1013:             .Width         = 80
1014:             .Height        = 23
1015:             .SpecialEffect = 1
1016:             .ForeColor     = RGB(0, 0, 0)
1017:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1026 a 1035:
1026:             .FontName      = "Tahoma"
1027:             .FontSize      = 8
1028:             .Alignment     = 3
1029:             .Left          = 358
1030:             .Top           = 258
1031:             .Width         = 80
1032:             .Height        = 23
1033:             .SpecialEffect = 1
1034:             .ForeColor     = RGB(0, 0, 0)
1035:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1044 a 1053:
1044:             .FontName      = "Tahoma"
1045:             .FontSize      = 8
1046:             .Alignment     = 3
1047:             .Left          = 445
1048:             .Top           = 231
1049:             .Width         = 80
1050:             .Height        = 23
1051:             .SpecialEffect = 1
1052:             .ForeColor     = RGB(0, 0, 0)
1053:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1062 a 1071:
1062:             .FontName      = "Tahoma"
1063:             .FontSize      = 8
1064:             .Alignment     = 3
1065:             .Left          = 445
1066:             .Top           = 258
1067:             .Width         = 80
1068:             .Height        = 23
1069:             .SpecialEffect = 1
1070:             .ForeColor     = RGB(0, 0, 0)
1071:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1183 a 1191:
1183:     * BOParaForm - Caminho inverso de FormParaBO: espelha o estado INTEIRO do
1184:     * BO (entradas + vencimentos + os tres mostradores) de volta nos
1185:     * controles. Equivalente ao bloco "With ThisForm / .getValorBase.Value =
1186:     * ... / .getDataFinal.Value = ..." que abre o PROCEDURE Init do legado -
1187:     * la os valores vinham dos parametros direto para os controles; aqui eles
1188:     * passam pelo BO, entao carregar a tela eh justamente copiar o BO de volta.
1189:     *
1190:     * Chamado em InicializarForm (depois de os controles existirem) e por
1191:     * LimparCampos. Tambem eh o hook que FormBase.Cancelar invoca para

*-- Linhas 1759 a 1782:
1759:     PROTECTED PROCEDURE ConfigurarShellSaida()
1760:         THIS.AddObject("cnt_4c_Saida", "Container")
1761:         WITH THIS.cnt_4c_Saida
1762:             .Top         = 7
1763:             .Left        = 917
1764:             .Width       = 90
1765:             .Height      = 109
1766:             .BackStyle   = 0
1767:             .BorderWidth = 0
1768:             .Visible     = .T.
1769:         ENDWITH
1770: 
1771:         THIS.cnt_4c_Saida.AddObject("cmd_4c_Sair", "CommandButton")
1772:         WITH THIS.cnt_4c_Saida.cmd_4c_Sair
1773:             .Top             = 17
1774:             .Left            = 7
1775:             .Width           = 75
1776:             .Height          = 75
1777:             .Caption         = "Encerrar"
1778:             .Cancel          = .T.
1779:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1780:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1781:             .Themes          = .T.
1782:             .FontName        = "Comic Sans MS"

*-- Linhas 1793 a 1813:
1793:             .Visible         = .T.
1794:         ENDWITH
1795: 
1796:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
1797:     ENDPROC
1798: 
1799:     *==========================================================================
1800:     * ConfigurarDivisor - Linha horizontal decorativa que separa os campos
1801:     * de entrada da area de resultado (equivalente ao Commandgroup1 do
1802:     * legado, um CommandGroup sem botoes usado apenas como filete visual).
1803:     *==========================================================================
1804:     PROTECTED PROCEDURE ConfigurarDivisor()
1805:         THIS.AddObject("shp_4c_Divisor", "Line")
1806:         WITH THIS.shp_4c_Divisor
1807:             .Left        = 6
1808:             .Top         = 180
1809:             .Width       = 586
1810:             .Height      = 0
1811:             .BorderColor = RGB(90, 90, 90)
1812:             .BorderWidth = 1
1813:             .Visible     = .T.


### BO (C:\4c\projeto\app\classes\SigPrCfnBO.prg):
*============================================================================
* SigPrCfnBO.prg - Business Object para Calculo de Juros (dialogo utilitario)
*
* Origem legado: SIGPRCFN.SCX ("Calculo de Juros")
* Sem tabela de persistencia - o form eh um dialogo modal de calculo em
* memoria, aberto via CREATEOBJECT com parametros (Valor Base, Tipo de
* Calculo, Juros ao Mes/Dia, Data Base, Data Final) e fechado com btnOK.
* Nao ha INSERT/UPDATE/DELETE no legado (comportamento.json: totalQueries=0,
* tabelasUsadas=[]).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrCfnBO AS BusinessBase

    *==========================================================================
    * Propriedades de entrada - espelham os parametros do Init legado
    * Lparameters pVal, pTip, pJMe, pJDi, pDtB, pDtF
    *==========================================================================
    this_nValorBase   = 0     && Valor Base do calculo (getValorBase)
    this_nTipoCalculo = 1     && 1=Simples, 2=Composto (optCalculo.Value)
    this_nJurosMes    = 0     && Juros ao Mes, percentual (getJurosMes)
    this_nJurosDia    = 0     && Juros ao Dia, percentual - relevante so quando
                               && Juros ao Mes nao foi informado (getJurosDia)
    this_dDataBase    = {}    && Data Base do calculo (getDataBase)
    this_dDataFinal   = {}    && Data Final do calculo (getDataFinal)
    this_nDias        = 0     && Quantidade de dias entre Data Base e Data Final
                               && ou entre Data Base e o ultimo vencimento (getDias)
    this_nTipoDias    = 1     && 1=Corridos, 2=Uteis (optDias.Value)

    *==========================================================================
    * Vencimentos (parcelamento) - ate 10 datas (getvenc1..getvenc10)
    *==========================================================================
    this_dVenc1  = {}
    this_dVenc2  = {}
    this_dVenc3  = {}
    this_dVenc4  = {}
    this_dVenc5  = {}
    this_dVenc6  = {}
    this_dVenc7  = {}
    this_dVenc8  = {}
    this_dVenc9  = {}
    this_dVenc10 = {}

    *==========================================================================
    * Propriedades de saida - resultado do calculo (nao persistidas)
    *==========================================================================
    this_nValorJuros   = 0    && Valor de juros calculado (getValorJuros)
    this_nValorTotal   = 0    && Valor Base + Valor de Juros (getValorTotal)
    this_nValorParcela = 0    && Valor Total dividido pela quantidade de
                               && vencimentos preenchidos (GetValorpar)

    *==========================================================================
    * Cache de feriados (SigCdFer), usado no calculo de dias uteis
    * (optDias = 2). Formato "|AAAAMMDD|AAAAMMDD|..." evita um SELECT por
    * dia dentro do laco de calculo.
    *==========================================================================
    this_cFeriados           = ""
    this_lFeriadosCarregados = .F.

    *==========================================================================
    * Init - Business Object sem tabela de persistencia. Nao repassa nome de
    * tabela ao DODEFAULT() (BusinessBase.Init so cria o DataAccess quando
    * recebe um nome de tabela nao vazio).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Decisao de design: este BO NAO sobrescreve CarregarDoCursor()/Inserir()/
    * Atualizar()/ExecutarExclusao()/ObterChavePrimaria(). O legado (PROCEDURE
    * calculos do SIGPRCFN.SCX) e um dialogo modal de calculo em memoria - abre
    * via CREATEOBJECT com parametros, calcula e fecha com btnOK.Click =
    * ThisForm.Release. Nao ha SELECT/INSERT/UPDATE/DELETE em lugar nenhum do
    * dump (comportamento.json: totalQueries=0, tabelasUsadas=[]). O
    * comportamento padrao herdado de BusinessBase (recusar a operacao) ja eh
    * o correto para este caso. A funcionalidade REAL do legado - o metodo
    * Calculos() - eh implementada abaixo, transcrita literalmente (formula,
    * sinal, guards e ordem identicos ao dump, conforme regra de negocio).
    *==========================================================================

    *==========================================================================
    * Calcular - Equivalente a PROCEDURE calculos do legado. Le as propriedades
    * de entrada (this_nValorBase, this_nTipoCalculo, this_nJurosMes,
    * this_nJurosDia, this_dDataBase, this_dDataFinal, this_nDias,
    * this_dVenc1..10) e grava this_nValorJuros/this_nValorTotal/
    * this_nValorParcela - e, quando ha vencimentos preenchidos, TAMBEM
    * this_nDias (efeito colateral identico ao legado: "If lnTotDia > 0 /
    * thisform.getDias.Value = lnTotDia").
    *
    * Formula TRANSCRITA do dump, sem "corrigir" nada (regra #17):
    *   Simples : Juros = Round(ValorBase * (JurosMes/100)  * (Dias/30), 2)
    *   Composto: Juros = Round(ValorBase * (((1+JurosDia/100)^Dias)-1), 2)
    * Cada vencimento preenchido REINICIA o acumulador na primeira parcela
    * encontrada (lnParc = 0 -> lnJuros = 0) e soma o juros daquela parcela
    * usando os dias entre a Data Base e o proprio vencimento - igual ao
    * legado, inclusive o "bug" de this_nDias ficar com os dias do ULTIMO
    * vencimento (nao a media, apesar do comentario morto no legado).
    *==========================================================================
    PROCEDURE Calcular()
        LOCAL loc_lResultado, loc_nJuros, loc_nParc, loc_nTotDia, loc_nDia, ;
              loc_nX, loc_dVenc
        loc_lResultado = .F.
        loc_nParc      = 0

        TRY
            IF EMPTY(THIS.this_nValorBase)  OR EMPTY(THIS.this_nJurosMes) OR ;
               EMPTY(THIS.this_nJurosDia)   OR EMPTY(THIS.this_dDataBase) OR ;
               EMPTY(THIS.this_dDataFinal)  OR EMPTY(THIS.this_nDias)

                THIS.this_nValorJuros = 0
                THIS.this_nValorTotal = 0
            ELSE
                IF THIS.this_nTipoCalculo = 1
                    *-- Juros Simples
                    loc_nJuros = ROUND(THIS.this_nValorBase * ;
                        (THIS.this_nJurosMes / 100) * (THIS.this_nDias / 30), 2)
                ELSE
                    *-- Juros Compostos
                    loc_nJuros = ROUND(THIS.this_nValorBase * ;
                        (((1 + THIS.this_nJurosDia / 100) ^ (THIS.this_nDias)) - 1), 2)
                ENDIF

                loc_nTotDia = 0
                loc_nParc   = 0

                FOR loc_nX = 1 TO 10
                    loc_dVenc = EVALUATE("THIS.this_dVenc" + ALLTRIM(STR(loc_nX)))

                    IF !EMPTY(loc_dVenc)
                        IF loc_nParc = 0
                            *-- quando calcula por parcelas, zera o calculo feito acima
                            loc_nJuros = 0
                        ENDIF

                        loc_nDia = loc_dVenc - THIS.this_dDataBase

                        IF THIS.this_nTipoCalculo = 1
                            loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                (THIS.this_nJurosMes / 100) * (loc_nDia / 30), 2)
                        ELSE
                            loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                (((1 + THIS.this_nJurosDia / 100) ^ (loc_nDia)) - 1), 2)
                        ENDIF

                        loc_nTotDia = loc_nDia
                        loc_nParc   = loc_nParc + 1
                    ENDIF
                ENDFOR

                IF loc_nTotDia > 0
                    THIS.this_nDias = loc_nTotDia
                ENDIF

                THIS.this_nValorJuros = loc_nJuros
                THIS.this_nValorTotal = THIS.this_nValorBase + loc_nJuros
            ENDIF

            *-- mena 11/12/2014 (legado): calcula valor de cada parcela
            THIS.this_nValorParcela = THIS.this_nValorTotal / IIF(loc_nParc <> 0, loc_nParc, 1)

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CalcularJurosDiaAPartirDoMes - Equivalente a getJurosMes.Valid do legado.
    * Recebe o Juros ao Mes recem-digitado e devolve o Juros ao Dia
    * correspondente (o Form grava o retorno em this_nJurosDia).
    *==========================================================================
    FUNCTION CalcularJurosDiaAPartirDoMes(par_nJurosMes)
        LOCAL loc_nJurosDia

        IF THIS.this_nTipoCalculo = 1
            *-- Juros Simples
            loc_nJurosDia = ROUND(par_nJurosMes / 30, 9)
        ELSE
            *-- Juros Compostos
            loc_nJurosDia = ROUND((((1 + par_nJurosMes / 100) ^ (1 / 30)) - 1) * 100, 9)
        ENDIF

        RETURN loc_nJurosDia
    ENDFUNC

    *==========================================================================
    * CalcularJurosMesAPartirDoDia - Equivalente a getJurosDia.Valid do legado.
    * Recebe o Juros ao Dia recem-digitado e devolve o Juros ao Mes
    * correspondente (o Form grava o retorno em this_nJurosMes).
    *==========================================================================
    FUNCTION CalcularJurosMesAPartirDoDia(par_nJurosDia)
        LOCAL loc_nJurosMes

        IF THIS.this_nTipoCalculo = 1
            *-- Juros Simples
            loc_nJurosMes = ROUND(par_nJurosDia * 30, 2)
        ELSE
            *-- Juros Compostos
            loc_nJurosMes = ROUND((((1 + par_nJurosDia / 100) ^ (30)) - 1) * 100, 2)
        ENDIF

        RETURN loc_nJurosMes
    ENDFUNC

    *==========================================================================
    * CalcularDiasEfetivos - Centraliza o bloco "dias uteis" repetido no
    * legado em getDataFinal.Valid/getDias.Valid/optDias.InteractiveChange:
    *   lnDia = <dias corridos ja calculados pelo Form>
    *   If (lnDia > 0) And optDias.Value = 2
    *       ...percorre par_dDataBase..par_dDataFinal subtraindo sabado,
    *          domingo e feriado (SigCdFer)...
    *   EndIf
    * par_nDiasBrutos eh o valor JA calculado pelo Form (diferenca de datas
    * ou o proprio valor digitado em getDias, conforme o handler de origem -
    * o legado usa a MESMA variavel lnDia nos tres lugares, so a origem dela
    * muda). This_nTipoDias = 2 equivale a optDias.Value = 2 (Uteis).
    *==========================================================================
    FUNCTION CalcularDiasEfetivos(par_dDataBase, par_dDataFinal, par_nDiasBrutos)
        LOCAL loc_nDias, loc_dAtual

        loc_nDias = par_nDiasBrutos

        IF loc_nDias > 0 AND THIS.this_nTipoDias = 2 AND ;
           !ISNULL(par_dDataBase) AND !EMPTY(par_dDataBase) AND ;
           !ISNULL(par_dDataFinal) AND !EMPTY(par_dDataFinal)

            THIS.CarregarFeriados()

            loc_dAtual = par_dDataBase
            DO WHILE loc_dAtual <= par_dDataFinal
                IF THIS.VerificarFeriado(loc_dAtual)
                    loc_nDias = loc_nDias - 1
                ENDIF
                loc_dAtual = loc_dAtual + 1
            ENDDO
        ENDIF

        RETURN loc_nDias
    ENDFUNC

    *==========================================================================
    * CarregarFeriados - Le SigCdFer uma unica vez para this_cFeriados
    * (string "|AAAAMMDD|..."), evitando um SELECT por dia dentro do laco.
    * Equivalente ao cache usado por fChkFeriado(ThisForm.poDataMgr, ...) do
    * legado.
    *==========================================================================
    PROTECTED PROCEDURE CarregarFeriados()
        LOCAL loc_cSQL, loc_nRet, loc_cLista, loc_cAliasAnt

        IF THIS.this_lFeriadosCarregados
            RETURN .T.
        ENDIF

        loc_cLista    = "|"
        loc_cAliasAnt = ALIAS()

        TRY
            IF USED("cursor_4c_FerLoad")
                USE IN cursor_4c_FerLoad
            ENDIF

            loc_cSQL = "SELECT DISTINCT datas FROM SigCdFer WHERE datas IS NOT NULL"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerLoad")

            IF loc_nRet > 0 AND USED("cursor_4c_FerLoad")
                SELECT cursor_4c_FerLoad
                SCAN
                    IF !ISNULL(datas) AND !EMPTY(datas)
                        loc_cLista = loc_cLista + DTOS(ConverterParaData(datas)) + "|"
                    ENDIF
                ENDSCAN
                USE IN cursor_4c_FerLoad
            ENDIF

            THIS.this_cFeriados           = loc_cLista
            THIS.this_lFeriadosCarregados = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarFeriados")
        ENDTRY

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * VerificarFeriado - .T. se a data eh sabado, domingo ou feriado
    * (SigCdFer.datas). Equivalente a fChkFeriado(poDataMgr, ldDia, .T., .T.)
    * do legado (DOW: 1=Domingo, 7=Sabado no calendario padrao VFP9).
    *==========================================================================
    PROTECTED PROCEDURE VerificarFeriado(par_dData)
        LOCAL loc_nDow, loc_lNaoUtil

        loc_lNaoUtil = .F.
        loc_nDow     = DOW(par_dData)

        IF loc_nDow = 1 OR loc_nDow = 7
            loc_lNaoUtil = .T.
        ELSE
            loc_lNaoUtil = ("|" + DTOS(par_dData) + "|") $ THIS.this_cFeriados
        ENDIF

        RETURN loc_lNaoUtil
    ENDPROC

ENDDEFINE

