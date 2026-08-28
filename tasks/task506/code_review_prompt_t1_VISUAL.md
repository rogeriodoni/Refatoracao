# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 871: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormPzo.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1953 linhas total):

*-- Linhas 126 a 177:
126:     *==========================================================================
127:     * ConfigurarCabecalho - Container escuro com titulo do form
128:     *==========================================================================
129:     PROTECTED PROCEDURE ConfigurarCabecalho()
130:         LOCAL loc_oCnt
131:         THIS.AddObject("cnt_4c_Sombra", "Container")
132:         loc_oCnt = THIS.cnt_4c_Sombra
133:         WITH loc_oCnt
134:             .Top         = 0
135:             .Left        = 0
136:             .Width       = THIS.Width
137:             .Height      = 80
138:             .BorderWidth = 0
139:             .BackColor   = RGB(100, 100, 100)
140:             .Visible     = .T.
141:         ENDWITH
142:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
143:         WITH loc_oCnt.lbl_4c_Sombra
144:             .FontBold      = .T.
145:             .FontName      = "Tahoma"
146:             .FontSize      = 18
147:             .FontUnderline = .F.
148:             .WordWrap      = .T.
149:             .Alignment     = 0
150:             .BackStyle     = 0
151:             .AutoSize      = .F.
152:             .Caption       = "Prazo / Conta de Entrega"
153:             .Height        = 40
154:             .Left          = 10
155:             .Top           = 18
156:             .Width         = 769
157:             .ForeColor     = RGB(0, 0, 0)
158:             .Visible       = .T.
159:         ENDWITH
160:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
161:         WITH loc_oCnt.lbl_4c_Titulo
162:             .FontBold   = .T.
163:             .FontName   = "Tahoma"
164:             .FontSize   = 18
165:             .WordWrap   = .T.
166:             .Alignment  = 0
167:             .BackStyle  = 0
168:             .AutoSize   = .F.
169:             .Caption    = "Prazo / Conta de Entrega"
170:             .Height     = 46
171:             .Left       = 10
172:             .Top        = 17
173:             .Width      = 769
174:             .ForeColor  = RGB(255, 255, 255)
175:             .Visible    = .T.
176:         ENDWITH
177:     ENDPROC

*-- Linhas 238 a 247:
238:         loc_oGrid = THIS.grd_4c_Dados
239: 
240:         WITH loc_oGrid
241:             .Top               = 89
242:             .Left              = 7
243:             .Width             = 889
244:             .Height            = 246
245:             .ColumnCount       = 5
246:             .FontName          = "Verdana"
247:             .FontSize          = 8

*-- Linhas 266 a 274:
266:             .FontName         = "Verdana"
267:             .FontSize         = 8
268:         ENDWITH
269:         loc_oCol.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
270:         loc_oCol.Header1.FontName  = "Verdana"
271:         loc_oCol.Header1.FontSize  = 8
272:         loc_oCol.Header1.Alignment = 2
273:         loc_oCol.Text1.BorderStyle = 0
274:         loc_oCol.Text1.Margin      = 0

*-- Linhas 285 a 293:
285:             .FontSize             = 8
286:             .DynamicReadOnly      = "!INLIST(CsPrazE.DtEntrs, 1, 4, 6)"
287:         ENDWITH
288:         loc_oCol.Header1.Caption       = "Data"
289:         loc_oCol.Header1.FontName      = "Verdana"
290:         loc_oCol.Header1.FontSize      = 8
291:         loc_oCol.Header1.Alignment     = 2
292:         loc_oCol.Text1.StrictDateEntry = 0
293:         loc_oCol.Text1.BorderStyle     = 0

*-- Linhas 308 a 316:
308:             .FontSize         = 8
309:             .DynamicReadOnly  = "!INLIST(CsPrazE.nFiscals, 1, 2)"
310:         ENDWITH
311:         loc_oCol.Header1.Caption   = "Frete"
312:         loc_oCol.Header1.FontName  = "Verdana"
313:         loc_oCol.Header1.FontSize  = 8
314:         loc_oCol.Header1.Alignment = 2
315:         loc_oCol.Text1.BorderStyle = 0
316:         loc_oCol.Text1.Margin      = 0

*-- Linhas 327 a 335:
327:             .FontSize         = 8
328:             .DynamicReadOnly  = "!INLIST(CsPrazE.nFiscals, 1, 2)"
329:         ENDWITH
330:         loc_oCol.Header1.Caption   = "Despesas Acess" + CHR(243) + "rias"
331:         loc_oCol.Header1.FontName  = "Verdana"
332:         loc_oCol.Header1.FontSize  = 8
333:         loc_oCol.Header1.Alignment = 2
334:         loc_oCol.Text1.BorderStyle = 0
335:         loc_oCol.Text1.Margin      = 0

*-- Linhas 346 a 354:
346:             .FontSize         = 8
347:             .DynamicReadOnly  = "!INLIST(CsPrazE.nFiscals, 1, 2)"
348:         ENDWITH
349:         loc_oCol.Header1.Caption   = "Seguro"
350:         loc_oCol.Header1.FontName  = "Verdana"
351:         loc_oCol.Header1.FontSize  = 8
352:         loc_oCol.Header1.Alignment = 2
353:         loc_oCol.Text1.BorderStyle = 0
354:         loc_oCol.Text1.Margin      = 0

*-- Linhas 411 a 641:
411:         *-- Background da area de totais
412:         THIS.AddObject("cnt_4c_BgTotais", "Container")
413:         WITH THIS.cnt_4c_BgTotais
414:             .Top         = 342
415:             .Left        = 7
416:             .Width       = 889
417:             .Height      = 73
418:             .BackStyle   = 1
419:             .BackColor   = RGB(188, 201, 254)
420:             .BorderWidth = 0
421:             .Visible     = .T.
422:         ENDWITH
423: 
424:         *-- === FRETE ===
425:         THIS.AddObject("lbl_4c_FrtTit", "Label")
426:         WITH THIS.lbl_4c_FrtTit
427:             .AutoSize  = .T.
428:             .FontBold  = .T.
429:             .FontName  = "Tahoma"
430:             .FontSize  = 8
431:             .BackStyle = 0
432:             .Caption   = "Frete"
433:             .Left      = 44
434:             .Top       = 347
435:             .ForeColor = RGB(90, 90, 90)
436:             .Visible   = .T.
437:         ENDWITH
438: 
439:         THIS.AddObject("lbl_4c_FrtTot", "Label")
440:         WITH THIS.lbl_4c_FrtTot
441:             .AutoSize  = .T.
442:             .FontBold  = .F.
443:             .FontName  = "Tahoma"
444:             .FontSize  = 8
445:             .BackStyle = 0
446:             .Caption   = "Total"
447:             .Left      = 44
448:             .Top       = 372
449:             .ForeColor = RGB(90, 90, 90)
450:             .Visible   = .T.
451:         ENDWITH
452: 
453:         THIS.AddObject("txt_4c_FrtT", "TextBox")
454:         WITH THIS.txt_4c_FrtT
455:             .FontBold  = .T.
456:             .Alignment = 3
457:             .Value     = 0
458:             .Height    = 23
459:             .InputMask = "9999,999.99"
460:             .Left      = 44
461:             .Top       = 385
462:             .Width     = 95
463:             .ForeColor = RGB(0, 0, 0)
464:             .ReadOnly  = .T.
465:             .Visible   = .T.
466:         ENDWITH
467: 
468:         THIS.AddObject("lbl_4c_FrtInf", "Label")
469:         WITH THIS.lbl_4c_FrtInf
470:             .AutoSize  = .T.
471:             .FontBold  = .F.
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .BackStyle = 0
475:             .Caption   = "Informado"
476:             .Left      = 142
477:             .Top       = 372
478:             .ForeColor = RGB(90, 90, 90)
479:             .Visible   = .T.
480:         ENDWITH
481: 
482:         THIS.AddObject("txt_4c_FrtI", "TextBox")
483:         WITH THIS.txt_4c_FrtI
484:             .FontBold  = .T.
485:             .Alignment = 3
486:             .Value     = 0
487:             .Height    = 23
488:             .InputMask = "9999,999.99"
489:             .Left      = 142
490:             .Top       = 385
491:             .Width     = 95
492:             .ForeColor = RGB(0, 0, 0)
493:             .ReadOnly  = .T.
494:             .Visible   = .T.
495:         ENDWITH
496: 
497:         *-- === DESPESAS ACESSORIAS ===
498:         THIS.AddObject("lbl_4c_DespTit", "Label")
499:         WITH THIS.lbl_4c_DespTit
500:             .AutoSize  = .T.
501:             .FontBold  = .T.
502:             .FontName  = "Tahoma"
503:             .FontSize  = 8
504:             .BackStyle = 0
505:             .Caption   = "Despesas Acess" + CHR(243) + "rias"
506:             .Left      = 315
507:             .Top       = 347
508:             .ForeColor = RGB(90, 90, 90)
509:             .Visible   = .T.
510:         ENDWITH
511: 
512:         THIS.AddObject("lbl_4c_DespTot", "Label")
513:         WITH THIS.lbl_4c_DespTot
514:             .AutoSize  = .T.
515:             .FontBold  = .F.
516:             .FontName  = "Tahoma"
517:             .FontSize  = 8
518:             .BackStyle = 0
519:             .Caption   = "Total"
520:             .Left      = 315
521:             .Top       = 372
522:             .ForeColor = RGB(90, 90, 90)
523:             .Visible   = .T.
524:         ENDWITH
525: 
526:         THIS.AddObject("txt_4c_DespT", "TextBox")
527:         WITH THIS.txt_4c_DespT
528:             .FontBold  = .T.
529:             .Alignment = 3
530:             .Value     = 0
531:             .Height    = 23
532:             .InputMask = "9999,999.99"
533:             .Left      = 315
534:             .Top       = 385
535:             .Width     = 95
536:             .ForeColor = RGB(0, 0, 0)
537:             .ReadOnly  = .T.
538:             .Visible   = .T.
539:         ENDWITH
540: 
541:         THIS.AddObject("lbl_4c_DespInf", "Label")
542:         WITH THIS.lbl_4c_DespInf
543:             .AutoSize  = .T.
544:             .FontBold  = .F.
545:             .FontName  = "Tahoma"
546:             .FontSize  = 8
547:             .BackStyle = 0
548:             .Caption   = "Informado"
549:             .Left      = 413
550:             .Top       = 372
551:             .ForeColor = RGB(90, 90, 90)
552:             .Visible   = .T.
553:         ENDWITH
554: 
555:         THIS.AddObject("txt_4c_DespI", "TextBox")
556:         WITH THIS.txt_4c_DespI
557:             .FontBold  = .T.
558:             .Alignment = 3
559:             .Value     = 0
560:             .Height    = 23
561:             .InputMask = "9999,999.99"
562:             .Left      = 413
563:             .Top       = 385
564:             .Width     = 95
565:             .ForeColor = RGB(0, 0, 0)
566:             .ReadOnly  = .T.
567:             .Visible   = .T.
568:         ENDWITH
569: 
570:         *-- === SEGURO ===
571:         THIS.AddObject("lbl_4c_SegTit", "Label")
572:         WITH THIS.lbl_4c_SegTit
573:             .AutoSize  = .T.
574:             .FontBold  = .T.
575:             .FontName  = "Tahoma"
576:             .FontSize  = 8
577:             .BackStyle = 0
578:             .Caption   = "Seguro"
579:             .Left      = 586
580:             .Top       = 347
581:             .ForeColor = RGB(90, 90, 90)
582:             .Visible   = .T.
583:         ENDWITH
584: 
585:         THIS.AddObject("lbl_4c_SegTot", "Label")
586:         WITH THIS.lbl_4c_SegTot
587:             .AutoSize  = .T.
588:             .FontBold  = .F.
589:             .FontName  = "Tahoma"
590:             .FontSize  = 8
591:             .BackStyle = 0
592:             .Caption   = "Total"
593:             .Left      = 586
594:             .Top       = 372
595:             .ForeColor = RGB(90, 90, 90)
596:             .Visible   = .T.
597:         ENDWITH
598: 
599:         THIS.AddObject("txt_4c_SegT", "TextBox")
600:         WITH THIS.txt_4c_SegT
601:             .FontBold  = .T.
602:             .Alignment = 3
603:             .Value     = 0
604:             .Height    = 23
605:             .InputMask = "9999,999.99"
606:             .Left      = 586
607:             .Top       = 385
608:             .Width     = 95
609:             .ForeColor = RGB(0, 0, 0)
610:             .ReadOnly  = .T.
611:             .Visible   = .T.
612:         ENDWITH
613: 
614:         THIS.AddObject("lbl_4c_SegInf", "Label")
615:         WITH THIS.lbl_4c_SegInf
616:             .AutoSize  = .T.
617:             .FontBold  = .F.
618:             .FontName  = "Tahoma"
619:             .FontSize  = 8
620:             .BackStyle = 0
621:             .Caption   = "Informado"
622:             .Left      = 684
623:             .Top       = 372
624:             .ForeColor = RGB(90, 90, 90)
625:             .Visible   = .T.
626:         ENDWITH
627: 
628:         THIS.AddObject("txt_4c_SegI", "TextBox")
629:         WITH THIS.txt_4c_SegI
630:             .FontBold  = .T.
631:             .Alignment = 3
632:             .Value     = 0
633:             .Height    = 23
634:             .InputMask = "9999,999.99"
635:             .Left      = 684
636:             .Top       = 385
637:             .Width     = 95
638:             .ForeColor = RGB(0, 0, 0)
639:             .ReadOnly  = .T.
640:             .Visible   = .T.
641:         ENDWITH

*-- Linhas 650 a 700:
650:         THIS.AddObject("cnt_4c_Observacao", "Container")
651:         loc_oCnt = THIS.cnt_4c_Observacao
652:         WITH loc_oCnt
653:             .Top         = 422
654:             .Left        = 7
655:             .Width       = 889
656:             .Height      = 105
657:             .BackStyle   = 1
658:             .BackColor   = RGB(188, 201, 254)
659:             .BorderWidth = 1
660:             .Visible     = .F.
661:         ENDWITH
662: 
663:         loc_oCnt.AddObject("lbl_4c_TitObs", "Label")
664:         WITH loc_oCnt.lbl_4c_TitObs
665:             .FontBold  = .T.
666:             .FontName  = "Tahoma"
667:             .FontSize  = 8
668:             .BackStyle = 0
669:             .Caption   = " Observa" + CHR(231) + CHR(227) + "o "
670:             .Left      = 5
671:             .Top       = 4
672:             .ForeColor = RGB(90, 90, 90)
673:             .Visible   = .T.
674:         ENDWITH
675: 
676:         *-- Codigo da observacao
677:         loc_oCnt.AddObject("txt_4c_CodObs", "TextBox")
678:         WITH loc_oCnt.txt_4c_CodObs
679:             .Alignment = 3
680:             .Value     = 0
681:             .Height    = 24
682:             .InputMask = "999"
683:             .Left      = 10
684:             .Margin    = 0
685:             .Top       = 21
686:             .Width     = 32
687:             .Visible   = .T.
688:         ENDWITH
689: 
690:         *-- Texto da observacao
691:         loc_oCnt.AddObject("txt_4c_Obs", "EditBox")
692:         WITH loc_oCnt.txt_4c_Obs
693:             .Height     = 77
694:             .Left       = 43
695:             .Top        = 21
696:             .Width      = 838
697:             .ScrollBars = 2
698:             .ReadOnly   = .T.
699:             .Visible    = .T.
700:         ENDWITH

*-- Linhas 709 a 877:
709:         THIS.AddObject("cnt_4c_Entrega", "Container")
710:         loc_oCnt = THIS.cnt_4c_Entrega
711:         WITH loc_oCnt
712:             .Top         = 534
713:             .Left        = 7
714:             .Width       = 889
715:             .Height      = 59
716:             .BackStyle   = 1
717:             .BackColor   = RGB(188, 201, 254)
718:             .BorderWidth = 1
719:             .Visible     = .F.
720:         ENDWITH
721: 
722:         loc_oCnt.AddObject("lbl_4c_TitEnt", "Label")
723:         WITH loc_oCnt.lbl_4c_TitEnt
724:             .FontBold  = .T.
725:             .FontName  = "Tahoma"
726:             .FontSize  = 8
727:             .BackStyle = 0
728:             .Caption   = " Entrega "
729:             .Left      = 6
730:             .Top       = 3
731:             .ForeColor = RGB(90, 90, 90)
732:             .Visible   = .T.
733:         ENDWITH
734: 
735:         loc_oCnt.AddObject("lbl_4c_LblConta", "Label")
736:         WITH loc_oCnt.lbl_4c_LblConta
737:             .FontBold  = .F.
738:             .FontName  = "Tahoma"
739:             .FontSize  = 8
740:             .BackStyle = 0
741:             .Caption   = "Conta"
742:             .Left      = 10
743:             .Top       = 19
744:             .ForeColor = RGB(90, 90, 90)
745:             .Visible   = .T.
746:         ENDWITH
747: 
748:         *-- Campo conta de entrega (ControlSource vincula direto ao cursor)
749:         loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
750:         WITH loc_oCnt.txt_4c_Conta
751:             .FontName      = "Arial"
752:             .FontSize      = 8
753:             .ControlSource = "CsPrazE.ContaEs"
754:             .Height        = 21
755:             .Left          = 10
756:             .Margin        = 0
757:             .MaxLength     = 10
758:             .SpecialEffect = 1
759:             .Top           = 33
760:             .Width         = 72
761:             .Visible       = .T.
762:         ENDWITH
763: 
764:         loc_oCnt.AddObject("lbl_4c_LblCpf", "Label")
765:         WITH loc_oCnt.lbl_4c_LblCpf
766:             .FontBold  = .F.
767:             .FontName  = "Tahoma"
768:             .FontSize  = 8
769:             .BackStyle = 0
770:             .Caption   = "CPF / CNPJ"
771:             .Height    = 15
772:             .Left      = 84
773:             .Top       = 19
774:             .Width     = 56
775:             .ForeColor = RGB(90, 90, 90)
776:             .Visible   = .T.
777:         ENDWITH
778: 
779:         loc_oCnt.AddObject("txt_4c_Cpf", "TextBox")
780:         WITH loc_oCnt.txt_4c_Cpf
781:             .FontName      = "Arial"
782:             .FontSize      = 8
783:             .Height        = 21
784:             .Left          = 84
785:             .Margin        = 0
786:             .MaxLength     = 20
787:             .SpecialEffect = 1
788:             .Top           = 33
789:             .Width         = 131
790:             .ReadOnly      = .F.
791:             .Visible       = .T.
792:         ENDWITH
793: 
794:         loc_oCnt.AddObject("lbl_4c_LblNome", "Label")
795:         WITH loc_oCnt.lbl_4c_LblNome
796:             .FontBold  = .F.
797:             .FontName  = "Tahoma"
798:             .FontSize  = 8
799:             .BackStyle = 0
800:             .Caption   = "Nome"
801:             .Height    = 15
802:             .Left      = 217
803:             .Top       = 19
804:             .Width     = 29
805:             .ForeColor = RGB(90, 90, 90)
806:             .Visible   = .T.
807:         ENDWITH
808: 
809:         loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
810:         WITH loc_oCnt.txt_4c_DConta
811:             .FontName      = "Arial"
812:             .FontSize      = 8
813:             .Height        = 21
814:             .Left          = 217
815:             .Margin        = 0
816:             .MaxLength     = 50
817:             .SpecialEffect = 1
818:             .Top           = 33
819:             .Width         = 300
820:             .ReadOnly      = .F.
821:             .Visible       = .T.
822:         ENDWITH
823: 
824:         *-- Botao de selecao do local de entrega
825:         loc_oCnt.AddObject("btn_4c_EntLocal", "CommandButton")
826:         WITH loc_oCnt.btn_4c_EntLocal
827:             .Top           = 11
828:             .Left          = 521
829:             .Width         = 43
830:             .Height        = 43
831:             .Caption       = ""
832:             .Picture       = gc_4c_CaminhoIcones + "geral_calendario_26.jpg"
833:             .ToolTipText   = "Local de Entrega <F2>"
834:             .SpecialEffect = 1
835:             .BackColor     = RGB(255, 255, 255)
836:             .Themes        = .F.
837:             .Visible       = .T.
838:         ENDWITH
839:     ENDPROC
840: 
841:     *==========================================================================
842:     * ConfigurarBotaoEncerrar - cnt_4c_Saida com cmd_4c_Encerrar (canonico)
843:     *==========================================================================
844:     PROTECTED PROCEDURE ConfigurarBotaoEncerrar()
845:         LOCAL loc_oCnt
846: 
847:         THIS.AddObject("cnt_4c_Saida", "Container")
848:         loc_oCnt = THIS.cnt_4c_Saida
849:         WITH loc_oCnt
850:             .Top         = 3
851:             .Left        = 917
852:             .Width       = 90
853:             .Height      = 85
854:             .BackStyle   = 0
855:             .BorderWidth = 0
856:             .Visible     = .T.
857:         ENDWITH
858: 
859:         loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
860:         WITH loc_oCnt.cmd_4c_Encerrar
861:             .Top         = 5
862:             .Left        = 5
863:             .Width       = 75
864:             .Height      = 75
865:             .Caption     = "Encerrar"
866:             .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
867:             .FontBold    = .T.
868:             .FontItalic  = .T.
869:             .FontName    = "Comic Sans MS"
870:             .FontSize    = 8
871:             .WordWrap    = .T.
872:             .ForeColor   = RGB(90, 90, 90)
873:             .BackColor   = RGB(255, 255, 255)
874:             .Themes      = .F.
875:             .ToolTipText = "[ESC] Encerrar"
876:             .Cancel      = .T.
877:             .Visible     = .T.

*-- Linhas 897 a 905:
897:         BINDEVENT(THIS.cnt_4c_Observacao.txt_4c_CodObs, "LostFocus", THIS, "ValidarObservacao")
898: 
899:         *-- Botao Encerrar: confirmar e fechar
900:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "EncerrarClick")
901: 
902:         *-- Botao local de entrega: abrir FormEnd
903:         BINDEVENT(THIS.cnt_4c_Entrega.btn_4c_EntLocal, "Click", THIS, "EntLocalClick")
904: 
905:         *-- CPF/CNPJ e Nome: KeyPress (Enter/Tab/F4) para lookup

*-- Linhas 1415 a 1438:
1415:         *-- Borda decorativa ao redor do container Encerrar
1416:         THIS.AddObject("shp_4c_Shape5", "Shape")
1417:         WITH THIS.shp_4c_Shape5
1418:             .Top         = 7
1419:             .Left        = 903
1420:             .Width       = 86
1421:             .Height      = 86
1422:             .ShapeType   = 0
1423:             .FillStyle   = 1
1424:             .BorderColor = RGB(53, 53, 53)
1425:             .BorderWidth = 2
1426:             .Visible     = .T.
1427:         ENDWITH
1428: 
1429:         *-- Linha separadora horizontal abaixo do label "Total" da area Frete
1430:         THIS.AddObject("shp_4c_Shape1", "Shape")
1431:         WITH THIS.shp_4c_Shape1
1432:             .Top         = 365
1433:             .Left        = 44
1434:             .Width       = 194
1435:             .Height      = 2
1436:             .ShapeType   = 0
1437:             .FillStyle   = 0
1438:             .BackColor   = RGB(90, 90, 90)

*-- Linhas 1444 a 1453:
1444:         *-- Linha separadora horizontal abaixo do label "Total" da area Despesas
1445:         THIS.AddObject("shp_4c_Shape3", "Shape")
1446:         WITH THIS.shp_4c_Shape3
1447:             .Top         = 365
1448:             .Left        = 315
1449:             .Width       = 194
1450:             .Height      = 2
1451:             .ShapeType   = 0
1452:             .FillStyle   = 0
1453:             .BackColor   = RGB(90, 90, 90)

*-- Linhas 1459 a 1468:
1459:         *-- Linha separadora horizontal abaixo do label "Total" da area Seguro
1460:         THIS.AddObject("shp_4c_Shape4", "Shape")
1461:         WITH THIS.shp_4c_Shape4
1462:             .Top         = 365
1463:             .Left        = 586
1464:             .Width       = 194
1465:             .Height      = 2
1466:             .ShapeType   = 0
1467:             .FillStyle   = 0
1468:             .BackColor   = RGB(90, 90, 90)


### BO (C:\4c\projeto\app\classes\PzoBO.prg):
*==============================================================================
* PzoBO.prg - Business Object para Prazo / Conta de Entrega
* Entidade: Pzo (SIGCDPZO - Prazo e Conta de Entrega por Opera??o)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (sub-form de movimenta??o)
*
* Contexto: Sub-form modal chamado por formularios de movimento (ex: SigAtCrp).
* Recebe referencia ao form pai com cursores TprMvCab, CrSigCdOpe, CrSigMvNfi,
* crTpmMvItn, TprMvCabG. Edita CsPrazE (prazos/fretes por opera??o) e grava
* de volta em crTpmMvItn ao confirmar.
*==============================================================================

DEFINE CLASS PzoBO AS BusinessBase

    *-- Identificacao da entidade (referencia principal: SigMvCab)
    this_cTabela         = "SigMvCab"
    this_cCampoChave     = "EmpDnCrds"

    *-- Chave composta do pedido (monta EmpDnCrds = Emps + Dopes + STR(Numes,6))
    this_cEmps           = ""
    this_cDopesParent    = ""
    this_nNumesParent    = 0
    this_cEmpDnCrds      = ""

    *-- Modo de operacao do form pai (INSERIR / ALTERAR / VISUALIZAR)
    this_cEscolha        = ""

    *-- Dados do cabecalho do movimento (TprMvCab) necessarios para validacoes
    this_dDatasParent    = {}
    this_nPrazoEnts      = 0
    this_cLocalEntsParent = ""
    this_cContaEsParent  = ""
    this_nCodObsParent   = 0
    this_cObsEsParent    = ""
    this_cContaDs        = ""
    this_cContaOs        = ""
    this_nValVars        = 0

    *-- Dados da linha corrente do cursor CsPrazE (por opera??o/abreviacao)
    *   Estrutura: CsPrazE (Dopes c(20), Abrevs c(3), Prazos T, DtEntrs n(1),
    *              nMinEnts n(3), nMaxEnts n(3), VlFretes n(12,2), nFiscals n(1),
    *              LocalEnts n(10), ContaEs c(10), LocEntObs n(1),
    *              DespAces n(12,2), VlSeguros n(12,2))
    this_cDopes          = ""
    this_cAbrevs         = ""
    this_dPrazos         = {}
    this_nDtEntrs        = 0
    this_nMinEnts        = 0
    this_nMaxEnts        = 0
    this_nVlFretes       = 0
    this_nFiscals        = 0
    this_nLocalEnts      = 0
    this_cContaEs        = ""
    this_nLocEntObs      = 0
    this_nDespAces       = 0
    this_nVlSeguros      = 0

    *-- Dados da opera??o corrente (LocTmpOpe: SigCdOpe + SigOpCdc)
    this_nExibSits       = 0
    this_nChCtEntrs      = 0
    this_nDtEntrsOpe     = 0
    this_nDigObs         = 0

    *-- Dados de validacao de valores minimos (crTodosOpe2: SigOpCdd)
    this_nChkUteis       = 0
    this_nMinFretes      = 0
    this_nMinSeguros     = 0
    this_nMinDesps       = 0

    *-- Conta de entrega (lookup SigCdCli via LocTmpOpe + CsPrazE.ContaEs)
    this_cGetConta       = ""
    this_cGetDConta      = ""
    this_cGetCpf         = ""

    *-- Observa??o da linha (TprMvCabG: CodObs, ObsEs / Obses)
    this_nCodObs         = 0
    this_cObsEs          = ""

    *-- Totalizadores exibidos no rodape do form
    *   FrtTotal / DespTotal / SegTotal vem de CrSigMvNfi (nota fiscal)
    *   FrtInformado / DespInformado / SegInformado sao somados do CsPrazE
    this_nFrtTotal       = 0
    this_nFrtInformado   = 0
    this_nDespTotal      = 0
    this_nDespInformado  = 0
    this_nSegTotal       = 0
    this_nSegInformado   = 0

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "EmpDnCrds"

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.Init")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cEmpDnCrds
    ENDPROC

    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
    *-- Carrega this_ a partir da linha corrente do cursor nomeado.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDopes     = TratarNulo(Dopes,     "C")
                THIS.this_cAbrevs    = TratarNulo(Abrevs,    "C")
                THIS.this_dPrazos    = IIF(ISNULL(Prazos), DTOT({}), Prazos)
                THIS.this_nDtEntrs   = TratarNulo(DtEntrs,   "N")
                THIS.this_nMinEnts   = TratarNulo(nMinEnts,  "N")
                THIS.this_nMaxEnts   = TratarNulo(nMaxEnts,  "N")
                THIS.this_nVlFretes  = TratarNulo(VlFretes,  "N")
                THIS.this_nFiscals   = TratarNulo(nFiscals,  "N")
                THIS.this_nLocalEnts = TratarNulo(LocalEnts, "N")
                THIS.this_cContaEs   = TratarNulo(ContaEs,   "C")
                THIS.this_nLocEntObs = TratarNulo(LocEntObs, "N")
                THIS.this_nDespAces  = TratarNulo(DespAces,  "N")
                THIS.this_nVlSeguros = TratarNulo(VlSeguros, "N")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION InicializarDados(par_oFormPai)
    *==========================================================================
    *-- Inicializa CsPrazE a partir dos cursores do formulario pai.
    *-- par_oFormPai: referencia ao form pai (ex: Formsigatcrp).
    *-- Pre-requisito: TprMvCab, CrSigCdOpe, CrSigMvNfi, crTpmMvItn abertos.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL, loc_nResult, loc_cEmpDopNum
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                MsgErro("Conex" + CHR(227) + "o com banco de dados n" + ;
                        CHR(227) + "o estabelecida.", "Erro")
            ELSE
                IF !USED("TprMvCab")
                    MsgErro("Cursor TprMvCab n" + CHR(227) + "o est" + ;
                            CHR(225) + " aberto.", "Erro")
                ELSE
                    IF !USED("CrSigCdOpe")
                        MsgErro("Cursor CrSigCdOpe n" + CHR(227) + "o est" + ;
                                CHR(225) + " aberto.", "Erro")
                    ELSE
                        *-- Armazenar dados do cabecalho do movimento
                        SELECT TprMvCab
                        THIS.this_cEmps            = ALLTRIM(TprMvCab.Emps)
                        THIS.this_cDopesParent     = ALLTRIM(TprMvCab.Dopes)
                        THIS.this_nNumesParent     = TprMvCab.Numes
                        THIS.this_cEmpDnCrds       = ALLTRIM(TprMvCab.Emps) + ;
                                                     ALLTRIM(TprMvCab.Dopes) + ;
                                                     STR(TprMvCab.Numes, 6)
                        THIS.this_dDatasParent     = TprMvCab.Datas
                        THIS.this_cLocalEntsParent = ALLTRIM(TprMvCab.LocalEnts)
                        THIS.this_cContaEsParent   = ALLTRIM(TprMvCab.ContaEs)
                        THIS.this_nCodObsParent    = TprMvCab.CodObs
                        THIS.this_cObsEsParent     = ALLTRIM(TprMvCab.ObsEs)
                        THIS.this_cContaDs         = ALLTRIM(TprMvCab.ContaDs)
                        THIS.this_cContaOs         = ALLTRIM(TprMvCab.ContaOs)
                        THIS.this_nValVars         = NVL(TprMvCab.ValVars, 0)

                        *-- Carregar totais das notas fiscais
                        IF USED("CrSigMvNfi")
                            SELECT CrSigMvNfi
                            THIS.this_nFrtTotal  = NVL(CrSigMvNfi.VlFretes, 0)
                            THIS.this_nDespTotal = NVL(CrSigMvNfi.DespAces, 0)
                            THIS.this_nSegTotal  = NVL(CrSigMvNfi.VlSeguros, 0)
                        ENDIF

                        *-- Query 1: dados anteriores do movimento em SigMvCab
                        loc_cEmpDopNum = THIS.this_cEmpDnCrds
                        loc_cSQL = "SELECT Dopes, PrazoEnts, LocalEnts, ContaEs, " + ;
                                   "CodObs, ObsEs " + ;
                                   "FROM SigMvCab " + ;
                                   "WHERE EmpDnCrds = '" + ALLTRIM(loc_cEmpDopNum) + "'"
                        IF USED("CsPedAnt")
                            USE IN CsPedAnt
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsPedAnt")
                        IF loc_nResult < 1
                            MsgErro("Falha ao carregar dados anteriores (CsPedAnt).", "Erro")
                        ELSE
                            SELECT CsPedAnt
                            INDEX ON Dopes TAG Dopes

                            *-- Query 2: operacoes via SigCdMop + SigCdOpe + SigOpCdc
                            IF USED("CsPed")
                                USE IN CsPed
                            ENDIF
                            loc_cSQL = "SELECT a.cDopes, a.cnivels AS Dopes, " + ;
                                       "a.nCors, a.padraos, " + ;
                                       "b.abrevs, b.DtEntrs, b.nFiscals, " + ;
                                       "c.nMinEnts, c.nMaxEnts " + ;
                                       "FROM SigCdMop a, SigCdOpe b, SigOpCdc c " + ;
                                       "WHERE a.cDopes = '" + ALLTRIM(CrSigCdOpe.Dopes) + "' " + ;
                                       "AND a.cnivels = b.dopes " + ;
                                       "AND b.Abrevs <> ' ' AND b.Dopes = c.Dopes"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsPed")
                            IF loc_nResult < 1
                                MsgErro("Falha ao carregar opera" + CHR(231) + CHR(245) + ;
                                        "es do pedido (CsPed).", "Erro")
                            ELSE
                                SELECT CsPed
                                INDEX ON nCors  TAG nCors
                                INDEX ON Abrevs TAG Abrevs

                                *-- Query 3: valores minimos por operacao (SigOpCdd)
                                IF USED("crTodosOpe2")
                                    USE IN crTodosOpe2
                                ENDIF
                                loc_cSQL = "SELECT Dopes, chkUteis, MinFretes, " + ;
                                           "MinSeguros, MinDesps FROM SigOpCdd"
                                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTodosOpe2")
                                IF loc_nResult < 1
                                    MsgErro("Falha ao carregar valores m" + CHR(237) + ;
                                            "nimos (crTodosOpe2).", "Erro")
                                ELSE
                                    SELECT crTodosOpe2
                                    INDEX ON Dopes TAG Dopes

                                    *-- Query 4: LocEntObs/chkUteis por operacao
                                    IF USED("CsPedOpe2")
                                        USE IN CsPedOpe2
                                    ENDIF
                                    loc_cSQL = "SELECT b.dopes, c.LocEntObs, c.chkUteis " + ;
                                               "FROM SigCdMop a, SigCdOpe b, SigOpCdd c " + ;
                                               "WHERE a.cDopes = '" + ;
                                               ALLTRIM(CrSigCdOpe.Dopes) + "' " + ;
                                               "AND a.cnivels = b.dopes " + ;
                                               "AND b.Abrevs <> ' ' AND b.Dopes = c.Dopes"
                                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsPedOpe2")
                                    IF loc_nResult < 1
                                        MsgErro("Falha ao carregar dados de opera" + ;
                                                CHR(231) + CHR(227) + "o (CsPedOpe2).", "Erro")
                                    ELSE
                                        SELECT CsPedOpe2
                                        INDEX ON Dopes TAG Dopes

                                        *-- Abreviaturas distintas dos itens do movimento
                                        IF USED("Itens")
                                            USE IN Itens
                                        ENDIF
                                        SELECT DISTINCT AbrevIs FROM crTpmMvItn ;
                                            WHERE Cpros <> ' ' AND Qtds <> 0 ;
                                            INTO CURSOR Itens READWRITE

                                        *-- Montar CsPedidos: CsPed x Itens
                                        IF USED("CsPedidos")
                                            USE IN CsPedidos
                                        ENDIF
                                        SELECT a.*, 0 AS LocEntObs ;
                                            FROM CsPed a, Itens b ;
                                            WHERE a.Abrevs = b.AbrevIs ;
                                            INTO CURSOR CsPedidos READWRITE
                                        SELECT CsPedidos
                                        INDEX ON nCors  TAG nCors
                                        INDEX ON Abrevs TAG Abrevs

                                        *-- Criar CsPrazE
                                        IF USED("CsPrazE")
                                            USE IN CsPrazE
                                        ENDIF
                                        SET NULL ON
                                        CREATE CURSOR CsPrazE ( ;
                                            Dopes     C(20)    NULL, ;
                                            Abrevs    C(3)     NULL, ;
                                            Prazos    T        NULL, ;
                                            DtEntrs   N(1)     NULL, ;
                                            nMinEnts  N(3)     NULL, ;
                                            nMaxEnts  N(3)     NULL, ;
                                            VlFretes  N(12,2)  NULL, ;
                                            nFiscals  N(1)     NULL, ;
                                            LocalEnts N(10)    NULL, ;
                                            ContaEs   C(10)    NULL, ;
                                            LocEntObs N(1)     NULL, ;
                                            DespAces  N(12,2)  NULL, ;
                                            VlSeguros N(12,2)  NULL )
                                        SET NULL OFF

                                        *-- Popular CsPrazE escaneando CsPedidos
                                        SELECT CsPedidos
                                        SCAN
                                            =SEEK(CsPedidos.Dopes, "CsPedOpe2", "Dopes")

                                            INSERT INTO CsPrazE ;
                                                (Dopes, Abrevs, Prazos, DtEntrs, ;
                                                 nMinEnts, nMaxEnts, VlFretes, ;
                                                 nFiscals, LocEntObs) ;
                                                VALUES ( ;
                                                    CsPedidos.Dopes, ;
                                                    CsPedidos.Abrevs, ;
                                                    IIF(EMPTY(TprMvCab.PrazoEnts), ;
                                                        DTOT({}), ;
                                                        TprMvCab.PrazoEnts), ;
                                                    CsPedidos.DtEntrs, ;
                                                    CsPedidos.nMinEnts, ;
                                                    CsPedidos.nMaxEnts, ;
                                                    0, ;
                                                    CsPedidos.nfiscals, ;
                                                    NVL(CsPedOpe2.LocEntObs, 0) )

                                            SELECT CsPedidos

                                            IF INLIST(CsPedidos.DtEntrs, 3, 4, 5, 6)
                                                REPLACE LocalEnts WITH TprMvCab.LocalEnts, ;
                                                        ContaEs   WITH TprMvCab.ContaEs ;
                                                        IN CsPrazE
                                            ENDIF

                                            INSERT INTO TprMvCabG ;
                                                (Dopes, Abrevs, CodObs, ObsEs) ;
                                                VALUES (CsPedidos.Dopes, ;
                                                        CsPedidos.Abrevs, ;
                                                        TprMvCab.CodObs, ;
                                                        TprMvCab.ObsEs)

                                            SELECT CsPedidos

                                            *-- Restaurar prazos/contas do pedido anterior
                                            =SEEK(CsPedidos.Dopes, "CsPedAnt", "Dopes")
                                            IF !EOF("CsPedAnt")
                                                REPLACE Prazos WITH IIF( ;
                                                        EMPTY(TprMvCab.PrazoEnts), ;
                                                        IIF(EMPTY(CsPedAnt.PrazoEnts), ;
                                                            DTOT({}), ;
                                                            CsPedAnt.PrazoEnts), ;
                                                        TprMvCab.PrazoEnts), ;
                                                        LocalEnts WITH CsPedAnt.LocalEnts, ;
                                                        ContaEs   WITH CsPedAnt.ContaEs ;
                                                        IN CsPrazE
                                                REPLACE CodObs WITH CsPedAnt.CodObs, ;
                                                        ObsEs  WITH CsPedAnt.ObsEs ;
                                                        IN TprMvCabG
                                                SELECT CsPedidos
                                            ENDIF
                                        ENDSCAN

                                        SELECT CsPrazE
                                        GO TOP
                                        IF RECCOUNT("CsPrazE") = 0
                                            MsgAviso("N" + CHR(227) + "o h" + ;
                                                     CHR(225) + " opera" + CHR(231) + ;
                                                     CHR(245) + "es de prazo para " + ;
                                                     "este movimento.", "Aviso")
                                        ELSE
                                            THIS.AtualizarTotais()
                                            loc_lSucesso = .T.
                                        ENDIF
                                    ENDIF  && CsPedOpe2
                                ENDIF  && crTodosOpe2
                            ENDIF  && CsPed
                        ENDIF  && CsPedAnt
                    ENDIF  && CrSigCdOpe
                ENDIF  && TprMvCab
            ENDIF  && gnConnHandle

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION CarregarInfoLinhaGrid(par_cDopes)
    *==========================================================================
    *-- Carrega dados de SigCdOpe+SigOpCdc para a linha corrente do grid.
    *-- Popula this_nExibSits, this_nChCtEntrs, this_nDtEntrsOpe, this_nDigObs.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Dopes, a.ExibSits, b.ChCtEntrs, b.DtEntrs, b.DigObs " + ;
                       "FROM SigCdOpe a, SigOpCdc b " + ;
                       "WHERE a.Dopes = '" + ALLTRIM(par_cDopes) + "' " + ;
                       "AND a.dopes = b.dopes"
            IF USED("LocTmpOpe")
                USE IN LocTmpOpe
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocTmpOpe")
            IF loc_nResult >= 1
                SELECT LocTmpOpe
                GO TOP
                THIS.this_nExibSits   = NVL(LocTmpOpe.ExibSits,  0)
                THIS.this_nChCtEntrs  = NVL(LocTmpOpe.ChCtEntrs, 0)
                THIS.this_nDtEntrsOpe = NVL(LocTmpOpe.DtEntrs,   0)
                THIS.this_nDigObs     = NVL(LocTmpOpe.DigObs,    0)
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.CarregarInfoLinhaGrid")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION Confirmar()
    *==========================================================================
    *-- Valida todos os prazos e atualiza crTpmMvItn com os dados de CsPrazE.
    *-- Retorna .T. se confirmado com sucesso.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_lcMsg, loc_ldDat, loc_ldEnt, loc_tEmpty
        loc_lSucesso = .F.
        loc_tEmpty   = DTOT({})

        TRY
            IF !USED("CsPrazE")
                MsgErro("Cursor CsPrazE n" + CHR(227) + "o est" + CHR(225) + ;
                        " aberto.", "Erro")
            ELSE
                IF !USED("crTpmMvItn")
                    MsgErro("Cursor crTpmMvItn n" + CHR(227) + "o est" + ;
                            CHR(225) + " aberto.", "Erro")
                ELSE
                    *-- Limpar campos de entrega antes de regravar
                    UPDATE crTpmMvItn ;
                        SET PrzEnts   = m.loc_tEmpty, ;
                            ValFrts   = 0, ;
                            LocalEnts = 0, ;
                            ValSegs   = 0, ;
                            ContaEs   = "", ;
                            DespAces  = 0

                    loc_lSucesso = .T.

                    *-- Escanear CsPrazE validando e atualizando crTpmMvItn
                    SELECT CsPrazE
                    SCAN WHILE loc_lSucesso
                        *-- Validar prazo de entrega se operacao exige data
                        IF INLIST(CsPrazE.DtEntrs, 1, 4, 6)
                            IF EMPTY(CsPrazE.Prazos)
                                MsgAviso("Prazo de Entrega da Opera" + CHR(231) + ;
                                         CHR(227) + "o " + ALLTRIM(CsPrazE.Dopes) + ;
                                         " deve ser informado...", ;
                                         "Obrigat" + CHR(243) + "rio")
                                loc_lSucesso = .F.
                            ENDIF

                            IF loc_lSucesso
                                loc_ldDat = TTOD(CsPrazE.Prazos)
                                IF loc_ldDat < THIS.this_dDatasParent
                                    MsgAviso("Prazo de Entrega da Opera" + ;
                                             CHR(231) + CHR(227) + "o " + ;
                                             ALLTRIM(CsPrazE.Dopes) + ;
                                             " deve ser maior que a Data da " + ;
                                             "Movimenta" + CHR(231) + CHR(227) + "o...", ;
                                             "Data Inv" + CHR(225) + "lida")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            IF loc_lSucesso AND CsPrazE.nMinEnts > 0
                                loc_ldEnt = THIS.this_dDatasParent + CsPrazE.nMinEnts
                                IF TTOD(CsPrazE.Prazos) < loc_ldEnt
                                    MsgAviso("Prazo de Entrega M" + CHR(237) + ;
                                             "nimo da Opera" + CHR(231) + CHR(227) + ;
                                             "o " + ALLTRIM(CsPrazE.Dopes) + ;
                                             " " + CHR(233) + " " + DTOC(loc_ldEnt) + ;
                                             "...", "Data Inv" + CHR(225) + "lida")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            IF loc_lSucesso AND CsPrazE.nMaxEnts > 0
                                loc_ldEnt = THIS.this_dDatasParent + CsPrazE.nMaxEnts
                                IF TTOD(CsPrazE.Prazos) > loc_ldEnt
                                    MsgAviso("Prazo de Entrega M" + CHR(225) + ;
                                             "ximo da Opera" + CHR(231) + CHR(227) + ;
                                             "o " + ALLTRIM(CsPrazE.Dopes) + ;
                                             " " + CHR(233) + " " + DTOC(loc_ldEnt) + ;
                                             "...", "Data Inv" + CHR(225) + "lida")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Validar local de entrega obrigatorio
                        IF loc_lSucesso AND CsPrazE.LocEntObs = 1 AND ;
                           INLIST(CsPrazE.DtEntrs, 3, 4, 5, 6) AND ;
                           CsPrazE.LocalEnts = 0
                            MsgAviso("Local de Entrega da Opera" + CHR(231) + ;
                                     CHR(227) + "o " + ALLTRIM(CsPrazE.Dopes) + ;
                                     " n" + CHR(227) + "o Informado!!!", ;
                                     "Obrigat" + CHR(243) + "rio")
                            loc_lSucesso = .F.
                        ENDIF

                        *-- Validar valores minimos (Frete / Desp. Acessorias)
                        IF loc_lSucesso AND USED("crTodosOpe2")
                            =SEEK(CsPrazE.Dopes, "crTodosOpe2", "Dopes")
                            loc_lcMsg = ""
                            IF !EOF("crTodosOpe2")
                                IF !EMPTY(crTodosOpe2.MinFretes) AND ;
                                   (CsPrazE.VlFretes < crTodosOpe2.MinFretes)
                                    loc_lcMsg = loc_lcMsg + ;
                                                IIF(EMPTY(loc_lcMsg), "", " / ") + ;
                                                "Frete"
                                ENDIF
                                IF !EMPTY(crTodosOpe2.MinDesps) AND ;
                                   (CsPrazE.DespAces < crTodosOpe2.MinDesps)
                                    loc_lcMsg = loc_lcMsg + ;
                                                IIF(EMPTY(loc_lcMsg), "", " / ") + ;
                                                "Desp. Acess" + CHR(243) + "rias"
                                ENDIF
                                IF !EMPTY(loc_lcMsg)
                                    MsgAviso("Existem Valores Na Opera" + CHR(231) + ;
                                             CHR(227) + "o Abaixo do M" + CHR(237) + ;
                                             "nimo : " + loc_lcMsg, "ERRO")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF
                            SELECT CsPrazE
                        ENDIF

                        *-- Atualizar crTpmMvItn com dados validados
                        IF loc_lSucesso
                            UPDATE crTpmMvItn SET ;
                                PrzEnts   = CsPrazE.Prazos, ;
                                ValFrts   = CsPrazE.VlFretes, ;
                                LocalEnts = CsPrazE.LocalEnts, ;
                                ValSegs   = CsPrazE.VlSeguros, ;
                                ContaEs   = CsPrazE.ContaEs, ;
                                DespAces  = CsPrazE.DespAces ;
                                WHERE ALLTRIM(AbrevIs) = ALLTRIM(CsPrazE.Abrevs)
                            SELECT CsPrazE
                        ENDIF
                    ENDSCAN

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("ATUALIZAR")
                    ENDIF
                ENDIF  && crTpmMvItn
            ENDIF  && CsPrazE

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.Confirmar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE AtualizarTotais()
    *==========================================================================
    *-- Recalcula this_nFrtInformado/this_nDespInformado/this_nSegInformado.
    *==========================================================================
        LOCAL loc_oErro
        TRY
            IF USED("CsPrazE")
                SELECT SUM(NVL(VlFretes, 0))  AS TotFrt, ;
                       SUM(NVL(DespAces, 0))  AS TotDesp, ;
                       SUM(NVL(VlSeguros, 0)) AS TotSeg ;
                    FROM CsPrazE ;
                    INTO CURSOR cursor_4c_TotaisPzo READWRITE
                IF USED("cursor_4c_TotaisPzo")
                    SELECT cursor_4c_TotaisPzo
                    GO TOP
                    THIS.this_nFrtInformado  = NVL(TotFrt,  0)
                    THIS.this_nDespInformado = NVL(TotDesp, 0)
                    THIS.this_nSegInformado  = NVL(TotSeg,  0)
                    USE IN cursor_4c_TotaisPzo
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.AtualizarTotais")
        ENDTRY
    ENDPROC

    *==========================================================================
    FUNCTION CarregarInfoConta(par_cConta, par_nChCtEntrs)
    *==========================================================================
    *-- Carrega dados de cliente (conta de entrega) de SigCdCli.
    *-- Popula this_cGetConta, this_cGetDConta, this_cGetCpf.
    *-- Retorna .T. se encontrou e passou nas validacoes.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cConta)
                THIS.this_cGetConta  = ""
                THIS.this_cGetDConta = ""
                THIS.this_cGetCpf    = ""
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT IClis, RClis, Cpfs FROM SigCdCli " + ;
                           "WHERE IClis = '" + ALLTRIM(par_cConta) + "'"
                IF USED("CrTmpCli")
                    USE IN CrTmpCli
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpCli")
                IF loc_nResult < 1
                    MsgErro("Falha ao carregar dados do cliente.", "Erro")
                ELSE
                    SELECT CrTmpCli
                    GO TOP
                    IF !EOF("CrTmpCli")
                        *-- Validar conta de entrega (nao pode ser igual a destino/origem)
                        IF par_nChCtEntrs = 1 AND ;
                           ALLTRIM(CrTmpCli.IClis) == ALLTRIM(THIS.this_cContaDs)
                            MsgAviso("Conta de Entrega Tem que ser diferente da " + ;
                                     "Conta de Destino", ;
                                     "Valida" + CHR(231) + CHR(227) + "o")
                        ELSE
                            IF par_nChCtEntrs = 2 AND ;
                               ALLTRIM(CrTmpCli.IClis) == ALLTRIM(THIS.this_cContaOs)
                                MsgAviso("Conta de Entrega Tem que ser diferente da " + ;
                                         "Conta de Origem", ;
                                         "Valida" + CHR(231) + CHR(227) + "o")
                            ELSE
                                THIS.this_cGetConta  = ALLTRIM(CrTmpCli.IClis)
                                THIS.this_cGetDConta = ALLTRIM(CrTmpCli.RClis)
                                THIS.this_cGetCpf    = ALLTRIM(CrTmpCli.Cpfs)
                                loc_lSucesso = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                    IF USED("CrTmpCli")
                        USE IN CrTmpCli
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.CarregarInfoConta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION CarregarInfoObservacao(par_nCodObs, par_cDopesOpe)
    *==========================================================================
    *-- Busca observacao de SigCdObs filtrando pela faixa da operacao.
    *-- Popula this_nCodObs e this_cObsEs. Retorna .T. se encontrou.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        LOCAL loc_nIni, loc_nFim
        loc_lSucesso = .F.

        TRY
            *-- Buscar faixa de observacoes da operacao
            loc_cSQL = "SELECT ObsPads, ObsInis, ObsFins FROM SigCdOpe " + ;
                       "WHERE Dopes = '" + ALLTRIM(par_cDopesOpe) + "'"
            IF USED("LocalOpe")
                USE IN LocalOpe
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalOpe")
            IF loc_nResult < 1
                MsgErro("Falha ao carregar dados da opera" + CHR(231) + ;
                        CHR(227) + "o.", "Erro")
            ELSE
                SELECT LocalOpe
                GO TOP
                loc_nIni = IIF(!EOF("LocalOpe") AND !EMPTY(LocalOpe.ObsInis), ;
                               LocalOpe.ObsInis, 0)
                loc_nFim = IIF(!EOF("LocalOpe") AND !EMPTY(LocalOpe.ObsFins), ;
                               LocalOpe.ObsFins, 999)
                IF USED("LocalOpe")
                    USE IN LocalOpe
                ENDIF

                *-- Carregar observacoes na faixa da operacao
                loc_cSQL = "SELECT Codigos, Descrs, Observas FROM SigCdObs " + ;
                           "WHERE Codigos BETWEEN " + TRANSFORM(loc_nIni) + ;
                           " AND " + TRANSFORM(loc_nFim)
                IF USED("crLocalObs")
                    USE IN crLocalObs
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocalObs")
                IF loc_nResult < 1
                    MsgErro("Falha ao carregar observa" + CHR(231) + CHR(245) + ;
                            "es (crLocalObs).", "Erro")
                ELSE
                    SELECT crLocalObs
                    INDEX ON Codigos TAG Codigos

                    IF SEEK(par_nCodObs, "crLocalObs", "Codigos")
                        THIS.this_nCodObs = NVL(crLocalObs.Codigos, 0)
                        THIS.this_cObsEs  = ALLTRIM(NVL(crLocalObs.Observas, ""))
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.CarregarInfoObservacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION Inserir()
    *==========================================================================
    *-- Operacional: registra auditoria de insercao se CsPrazE inicializado.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("CsPrazE") AND RECCOUNT("CsPrazE") > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("CsPrazE n" + CHR(227) + "o inicializado. " + ;
                        "Chamar InicializarDados() antes de Inserir().", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION Atualizar()
    *==========================================================================
    *-- Operacional: delega para Confirmar() que valida e salva CsPrazE.
    *==========================================================================
        RETURN THIS.Confirmar()
    ENDPROC

    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
    *==========================================================================
        LOCAL loc_oErro, loc_cSQL
        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND ;
               !EMPTY(THIS.this_cEmpDnCrds) AND !EMPTY(gc_4c_UsuarioLogado)
                loc_cSQL = "INSERT INTO LogAuditoria " + ;
                           "(DataHora, Usuario, Operacao, Tabela, " + ;
                           "ChavePrimaria, Empresa) " + ;
                           "VALUES (" + ;
                           "GETDATE(), " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           EscaparSQL(par_cOperacao) + ", " + ;
                           EscaparSQL("SigMvCab") + ", " + ;
                           EscaparSQL(THIS.this_cEmpDnCrds) + ", " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa) + ")"
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE

