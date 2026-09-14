# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CITENS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, EMPDOPNUMS, DOPES, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, EMPDOPNUMS, DOPES, CPROS

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
  DeleteMark = .F.
  DeleteMark = .F.
  ControlSource = "crGrade.DPros"
  ControlSource = "crGrade.Obs"
  DeleteMark = .F.
		.DeleteMark 	   = .f.
		.Column1.ControlSource  = 'crGrade.CItens'
		.Column2.ControlSource  = 'crGrade.CPros'
		.Column3.ControlSource  = 'crGrade.CUnis'
		.Column4.ControlSource  = 'crGrade.Volumes'
		.Column5.ControlSource  = 'crGrade.Opers'
		.Column6.ControlSource  = 'crGrade.QtdOs'
		.Column7.ControlSource  = 'crGrade.QtdBs'
		.Column8.ControlSource  = 'crGrade.QtdSs' 
		.Column9.ControlSource  = 'crGrade.Units'
		.Column10.ControlSource = 'crGrade.CMoes'
		.Column11.ControlSource = 'crGrade.Totas'
		.DeleteMark 	   = .f.
		.Column1.ControlSource  = 'crRodape.CPros'
		.Column2.ControlSource  = 'crRodape.CPros'
		.Column3.ControlSource  = 'crRodape.CPros'
		.Column4.ControlSource  = 'crRodape.Volumes'
		.Column5.ControlSource  = 'crRodape.CPros'
		.Column6.ControlSource  = 'crRodape.QtdOs'
		.Column7.ControlSource  = 'crRodape.QtdBs'
		.Column8.ControlSource  = 'crRodape.QtdSs' 
		.Column9.ControlSource  = 'crRodape.CPros'
		.Column10.ControlSource = 'crRodape.CMoes'
		.Column11.ControlSource = 'crRodape.Totas'
lcQuery = [Select a.CItens, a.CPros, a.DPros, a.Obs, a.CUnis, c.Volumes, a.Opers, a.Qtds as QtdOs, ] + ;
		    [From SigMvItn a, SigCdOpe b, SigCdPro c ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crDados') < 1)
Select crDados
	Insert Into crGrade From Memvar
Select CMoes, Sum(Volumes) as Volumes, Sum(QtdOs) as QtdOs, Sum(QtdBs) as QtdBs, ;
  From crDados ;
Select crTotal
	Insert Into crRodape From Memvar
Select crGrade

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprite.prg) - TRECHOS RELEVANTES PARA PASS SQL (1568 linhas total):

*-- Linhas 353 a 452:
353:             .FontName         = "Arial"
354:             .AllowHeaderSizing = .F.
355:             .AllowRowSizing   = .F.
356:             .DeleteMark       = .F.
357:             .RecordMark       = .F.
358:             .ReadOnly         = .T.
359:             .ScrollBars       = 0
360:             .HeaderHeight     = 17
361:             .Panel            = 1
362:             .RecordSource     = "cursor_4c_Itens"
363:             .Visible          = .T.
364: 
365:             *-- Coluna 1: Produto (codigo)
366:             WITH .Column1
367:                 .FontName       = "Arial"
368:                 .Width          = 226
369:                 .ReadOnly       = .T.
370:                 .ControlSource  = "cursor_4c_Itens.CPros"
371:                 WITH .Header1
372:                     .FontBold   = .T.
373:                     .FontName   = "Tahoma"
374:                     .FontSize   = 8
375:                     .Alignment  = 2
376:                     .Caption    = "Produto"
377:                 ENDWITH
378:                 WITH .Text1
379:                     .FontName   = "Arial"
380:                     .BorderStyle = 0
381:                     .Margin     = 0
382:                     .ReadOnly   = .T.
383:                     .ForeColor  = RGB(0, 0, 0)
384:                     .BackColor  = RGB(255, 255, 255)
385:                 ENDWITH
386:             ENDWITH
387: 
388:             *-- Coluna 2: (vazia - separador visual no legado)
389:             WITH .Column2
390:                 .FontName       = "Arial"
391:                 .Width          = 20
392:                 .ReadOnly       = .T.
393:                 .ControlSource  = "cursor_4c_Itens.Opers"
394:                 WITH .Header1
395:                     .FontBold   = .T.
396:                     .FontName   = "Tahoma"
397:                     .FontSize   = 8
398:                     .Alignment  = 2
399:                     .Caption    = ""
400:                 ENDWITH
401:                 WITH .Text1
402:                     .FontName   = "Arial"
403:                     .BorderStyle = 0
404:                     .Margin     = 0
405:                     .ReadOnly   = .T.
406:                     .ForeColor  = RGB(0, 0, 0)
407:                     .BackColor  = RGB(255, 255, 255)
408:                 ENDWITH
409:             ENDWITH
410: 
411:             *-- Coluna 3: Quantidade
412:             WITH .Column3
413:                 .FontName       = "Arial"
414:                 .Width          = 242
415:                 .ReadOnly       = .T.
416:                 .ControlSource  = "cursor_4c_Itens.QtdOs"
417:                 WITH .Header1
418:                     .FontBold   = .T.
419:                     .FontName   = "Tahoma"
420:                     .FontSize   = 8
421:                     .Alignment  = 2
422:                     .Caption    = "Quantidade"
423:                 ENDWITH
424:                 WITH .Text1
425:                     .BorderStyle = 0
426:                     .Margin     = 0
427:                     .ForeColor  = RGB(0, 0, 0)
428:                     .BackColor  = RGB(255, 255, 255)
429:                 ENDWITH
430:             ENDWITH
431: 
432:             *-- Coluna 4: Valor
433:             WITH .Column4
434:                 .FontName       = "Arial"
435:                 .Width          = 238
436:                 .ReadOnly       = .T.
437:                 .ControlSource  = "cursor_4c_Itens.Totas"
438:                 WITH .Header1
439:                     .FontBold   = .T.
440:                     .FontName   = "Tahoma"
441:                     .FontSize   = 8
442:                     .Alignment  = 2
443:                     .Caption    = "Valor"
444:                 ENDWITH
445:                 WITH .Text1
446:                     .BorderStyle = 0
447:                     .Margin     = 0
448:                     .ForeColor  = RGB(0, 0, 0)
449:                     .BackColor  = RGB(255, 255, 255)
450:                 ENDWITH
451:             ENDWITH
452: 

*-- Linhas 470 a 571:
470:             .FontName         = "Arial"
471:             .AllowHeaderSizing = .F.
472:             .AllowRowSizing   = .F.
473:             .DeleteMark       = .F.
474:             .RecordMark       = .F.
475:             .ReadOnly         = .T.
476:             .ScrollBars       = 2
477:             .HeaderHeight     = 17
478:             .RecordSource     = "cursor_4c_Itens"
479:             .HighlightBackColor = RGB(255, 255, 255)
480:             .HighlightForeColor = RGB(15, 41, 104)
481:             .HighlightStyle   = 2
482:             .Visible          = .T.
483: 
484:             *-- Col 1: CItens (sequencial do item - sem header)
485:             WITH .Column1
486:                 .FontName       = "Courier New"
487:                 .Width          = 31
488:                 .ReadOnly       = .T.
489:                 .ControlSource  = "cursor_4c_Itens.CItens"
490:                 .InputMask      = "999999"
491:                 WITH .Header1
492:                     .FontName   = "Tahoma"
493:                     .FontSize   = 8
494:                     .Alignment  = 2
495:                     .Caption    = ""
496:                 ENDWITH
497:                 WITH .Text1
498:                     .FontName   = "Courier New"
499:                     .BorderStyle = 0
500:                     .Margin     = 0
501:                     .ReadOnly   = .T.
502:                     .ForeColor  = RGB(0, 0, 0)
503:                     .BackColor  = RGB(255, 255, 255)
504:                 ENDWITH
505:             ENDWITH
506: 
507:             *-- Col 2: CPros (codigo produto - clickavel para abrir SIGOPCGP)
508:             WITH .Column2
509:                 .FontName       = "Courier New"
510:                 .Width          = 108
511:                 .ReadOnly       = .T.
512:                 .ControlSource  = "cursor_4c_Itens.CPros"
513:                 WITH .Header1
514:                     .FontName   = "Tahoma"
515:                     .FontSize   = 8
516:                     .Alignment  = 2
517:                     .Caption    = "Produto"
518:                 ENDWITH
519:                 WITH .Text1
520:                     .FontName   = "Courier New"
521:                     .BorderStyle = 0
522:                     .Margin     = 0
523:                     .MousePointer = 99
524:                     .ReadOnly   = .T.
525:                     .ForeColor  = RGB(0, 0, 0)
526:                     .BackColor  = RGB(255, 255, 255)
527:                 ENDWITH
528:             ENDWITH
529: 
530:             *-- Col 3: CUnis (unidade)
531:             WITH .Column3
532:                 .FontName       = "Courier New"
533:                 .Width          = 42
534:                 .ReadOnly       = .T.
535:                 .ControlSource  = "cursor_4c_Itens.CUnis"
536:                 WITH .Header1
537:                     .FontName   = "Tahoma"
538:                     .FontSize   = 8
539:                     .Alignment  = 2
540:                     .Caption    = "Unidade"
541:                 ENDWITH
542:                 WITH .Text1
543:                     .FontName   = "Courier New"
544:                     .BorderStyle = 0
545:                     .Margin     = 0
546:                     .ForeColor  = RGB(0, 0, 0)
547:                     .BackColor  = RGB(255, 255, 255)
548:                 ENDWITH
549:             ENDWITH
550: 
551:             *-- Col 4: Volumes
552:             WITH .Column4
553:                 .FontName       = "Courier New"
554:                 .Width          = 42
555:                 .ReadOnly       = .T.
556:                 .ControlSource  = "cursor_4c_Itens.Volumes"
557:                 .InputMask      = "999"
558:                 WITH .Header1
559:                     .FontName   = "Tahoma"
560:                     .FontSize   = 8
561:                     .Alignment  = 2
562:                     .Caption    = "Volume"
563:                 ENDWITH
564:                 WITH .Text1
565:                     .FontName   = "Courier New"
566:                     .BorderStyle = 0
567:                     .Margin     = 0
568:                     .ForeColor  = RGB(0, 0, 0)
569:                     .BackColor  = RGB(255, 255, 255)
570:                 ENDWITH
571:             ENDWITH

*-- Linhas 577 a 727:
577:                 .Alignment      = 2
578:                 .Width          = 20
579:                 .ReadOnly       = .T.
580:                 .ControlSource  = "cursor_4c_Itens.Opers"
581:                 WITH .Header1
582:                     .FontName   = "Tahoma"
583:                     .FontSize   = 8
584:                     .Alignment  = 2
585:                     .Caption    = "O"
586:                 ENDWITH
587:                 WITH .Text1
588:                     .FontBold   = .T.
589:                     .Alignment  = 2
590:                     .FontName   = "Courier New"
591:                     .BorderStyle = 0
592:                     .Margin     = 0
593:                     .ForeColor  = RGB(0, 0, 0)
594:                     .BackColor  = RGB(255, 255, 255)
595:                 ENDWITH
596:             ENDWITH
597: 
598:             *-- Col 6: QtdOs (quantidade original)
599:             WITH .Column6
600:                 .FontName       = "Courier New"
601:                 .Width          = 80
602:                 .ReadOnly       = .T.
603:                 .ControlSource  = "cursor_4c_Itens.QtdOs"
604:                 .InputMask      = "9999999.99"
605:                 WITH .Header1
606:                     .FontName   = "Tahoma"
607:                     .FontSize   = 8
608:                     .Alignment  = 2
609:                     .Caption    = "Original"
610:                 ENDWITH
611:                 WITH .Text1
612:                     .FontName   = "Courier New"
613:                     .BorderStyle = 0
614:                     .Margin     = 0
615:                     .ForeColor  = RGB(0, 0, 0)
616:                     .BackColor  = RGB(255, 255, 255)
617:                 ENDWITH
618:             ENDWITH
619: 
620:             *-- Col 7: QtdBs (quantidade baixada)
621:             WITH .Column7
622:                 .FontName       = "Courier New"
623:                 .Width          = 80
624:                 .ReadOnly       = .T.
625:                 .ControlSource  = "cursor_4c_Itens.QtdBs"
626:                 .InputMask      = "9999999.99"
627:                 WITH .Header1
628:                     .FontName   = "Tahoma"
629:                     .FontSize   = 8
630:                     .Alignment  = 2
631:                     .Caption    = "Baixada"
632:                 ENDWITH
633:                 WITH .Text1
634:                     .FontName   = "Courier New"
635:                     .BorderStyle = 0
636:                     .Margin     = 0
637:                     .ForeColor  = RGB(0, 0, 0)
638:                     .BackColor  = RGB(255, 255, 255)
639:                 ENDWITH
640:             ENDWITH
641: 
642:             *-- Col 8: QtdSs (saldo = original - baixada)
643:             WITH .Column8
644:                 .FontName       = "Courier New"
645:                 .Width          = 80
646:                 .ReadOnly       = .T.
647:                 .ControlSource  = "cursor_4c_Itens.QtdSs"
648:                 .InputMask      = "9999999.99"
649:                 WITH .Header1
650:                     .FontName   = "Tahoma"
651:                     .FontSize   = 8
652:                     .Alignment  = 2
653:                     .Caption    = "Saldo"
654:                 ENDWITH
655:                 WITH .Text1
656:                     .FontName   = "Courier New"
657:                     .BorderStyle = 0
658:                     .Margin     = 0
659:                     .ForeColor  = RGB(0, 0, 0)
660:                     .BackColor  = RGB(255, 255, 255)
661:                 ENDWITH
662:             ENDWITH
663: 
664:             *-- Col 9: Units (preco unitario)
665:             WITH .Column9
666:                 .FontName       = "Courier New"
667:                 .Width          = 100
668:                 .ReadOnly       = .T.
669:                 .ControlSource  = "cursor_4c_Itens.Units"
670:                 .InputMask      = "999999999.99"
671:                 WITH .Header1
672:                     .FontName   = "Tahoma"
673:                     .FontSize   = 8
674:                     .Alignment  = 2
675:                     .Caption    = "Unit" + CHR(225) + "rio"
676:                 ENDWITH
677:                 WITH .Text1
678:                     .FontName   = "Courier New"
679:                     .BorderStyle = 0
680:                     .Margin     = 0
681:                     .ForeColor  = RGB(0, 0, 0)
682:                     .BackColor  = RGB(255, 255, 255)
683:                 ENDWITH
684:             ENDWITH
685: 
686:             *-- Col 10: CMoes (codigo da moeda)
687:             WITH .Column10
688:                 .FontName       = "Courier New"
689:                 .Width          = 36
690:                 .ReadOnly       = .T.
691:                 .ControlSource  = "cursor_4c_Itens.CMoes"
692:                 WITH .Header1
693:                     .FontName   = "Tahoma"
694:                     .FontSize   = 8
695:                     .Alignment  = 2
696:                     .Caption    = "Moeda"
697:                 ENDWITH
698:                 WITH .Text1
699:                     .FontName   = "Courier New"
700:                     .BorderStyle = 0
701:                     .Margin     = 0
702:                     .ForeColor  = RGB(0, 0, 0)
703:                     .BackColor  = RGB(255, 255, 255)
704:                 ENDWITH
705:             ENDWITH
706: 
707:             *-- Col 11: Totas (valor total)
708:             WITH .Column11
709:                 .FontName       = "Courier New"
710:                 .Width          = 100
711:                 .ReadOnly       = .T.
712:                 .ControlSource  = "cursor_4c_Itens.Totas"
713:                 .InputMask      = "999999999.99"
714:                 WITH .Header1
715:                     .FontName   = "Tahoma"
716:                     .FontSize   = 8
717:                     .Alignment  = 2
718:                     .Caption    = "Valor Total"
719:                 ENDWITH
720:                 WITH .Text1
721:                     .FontName   = "Courier New"
722:                     .BorderStyle = 0
723:                     .Margin     = 0
724:                     .ForeColor  = RGB(0, 0, 0)
725:                     .BackColor  = RGB(255, 255, 255)
726:                 ENDWITH
727:             ENDWITH

*-- Linhas 759 a 777:
759:             .Height               = 23
760:             .FontName             = "Tahoma"
761:             .FontSize             = 8
762:             .ControlSource        = "cursor_4c_Itens.DPros"
763:             .ReadOnly             = .T.
764:             .ForeColor            = RGB(0, 0, 0)
765:             .BackColor            = RGB(255, 255, 255)
766:             .DisabledBackColor    = RGB(255, 255, 255)
767:             .DisabledForeColor    = RGB(192, 192, 192)
768:             .BorderColor          = RGB(100, 100, 100)
769:             .Visible              = .T.
770:         ENDWITH
771: 
772:         *-- Label "Observacao Produto"
773:         THIS.AddObject("lbl_4c_ObsPro", "Label")
774:         WITH THIS.lbl_4c_ObsPro
775:             .Top        = 481
776:             .Left       = 30
777:             .FontSize   = 8

*-- Linhas 789 a 807:
789:             .Height        = 57
790:             .FontName      = "Tahoma"
791:             .FontSize      = 8
792:             .ControlSource = "cursor_4c_Itens.Obs"
793:             .ReadOnly      = .T.
794:             .ForeColor     = RGB(0, 0, 0)
795:             .BorderColor   = RGB(100, 100, 100)
796:             .NullDisplay   = " "
797:             .Visible       = .T.
798:         ENDWITH
799: 
800:         *-- Label de disponibilidade do produto (so visivel se pDis=.T.)
801:         THIS.AddObject("lbl_4c_Disps", "Label")
802:         WITH THIS.lbl_4c_Disps
803:             .Top        = 441
804:             .Left       = 270
805:             .FontSize   = 8
806:             .Caption    = "Disponibilidade do Produto"
807:             .ForeColor  = RGB(90, 90, 90)

*-- Linhas 834 a 868:
834:             .FontName         = "Arial"
835:             .AllowHeaderSizing = .F.
836:             .AllowRowSizing   = .F.
837:             .DeleteMark       = .F.
838:             .RecordMark       = .F.
839:             .ReadOnly         = .T.
840:             .ScrollBars       = 2
841:             .HeaderHeight     = 4
842:             .RecordSource     = "cursor_4c_Rodape"
843:             .Visible          = .T.
844: 
845:             *-- As colunas do rodape espelham as do grdItens em largura
846:             *-- mas exibem os totais acumulados por moeda (sem header caption)
847:             *-- Col 1: vazia (alinha com CItens do grdItens)
848:             WITH .Column1
849:                 .FontName       = "Courier New"
850:                 .Width          = 31
851:                 .ReadOnly       = .T.
852:                 .BackColor      = RGB(255, 255, 223)
853:                 .ControlSource  = "cursor_4c_Rodape.CPros"
854:                 WITH .Header1
855:                     .FontName   = "Tahoma"
856:                     .FontSize   = 8
857:                     .Alignment  = 2
858:                     .Caption    = ""
859:                     .BackColor  = RGB(255, 255, 0)
860:                 ENDWITH
861:                 WITH .Text1
862:                     .FontName   = "Courier New"
863:                     .BorderStyle = 0
864:                     .Margin     = 0
865:                     .ReadOnly   = .T.
866:                     .ForeColor  = RGB(0, 0, 0)
867:                     .BackColor  = RGB(255, 255, 223)
868:                 ENDWITH

*-- Linhas 874 a 892:
874:                 .Width          = 108
875:                 .ReadOnly       = .T.
876:                 .BackColor      = RGB(255, 255, 223)
877:                 .ControlSource  = "cursor_4c_Rodape.CPros"
878:                 WITH .Header1
879:                     .FontName   = "Arial"
880:                     .FontSize   = 8
881:                     .Alignment  = 2
882:                     .Caption    = ""
883:                     .BackColor  = RGB(255, 255, 0)
884:                 ENDWITH
885:                 WITH .Text1
886:                     .FontName   = "Courier New"
887:                     .BorderStyle = 0
888:                     .Margin     = 0
889:                     .ReadOnly   = .T.
890:                     .ForeColor  = RGB(0, 0, 0)
891:                     .BackColor  = RGB(255, 255, 223)
892:                 ENDWITH

*-- Linhas 898 a 1096:
898:                 .Width          = 42
899:                 .ReadOnly       = .T.
900:                 .BackColor      = RGB(255, 255, 223)
901:                 .ControlSource  = "cursor_4c_Rodape.CPros"
902:                 WITH .Header1
903:                     .FontSize   = 8
904:                     .Alignment  = 2
905:                     .Caption    = ""
906:                     .BackColor  = RGB(255, 255, 0)
907:                 ENDWITH
908:                 WITH .Text1
909:                     .FontName   = "Courier New"
910:                     .BorderStyle = 0
911:                     .Margin     = 0
912:                     .ForeColor  = RGB(0, 0, 0)
913:                     .BackColor  = RGB(255, 255, 223)
914:                 ENDWITH
915:             ENDWITH
916: 
917:             *-- Col 4: Volumes total
918:             WITH .Column4
919:                 .FontName       = "Courier New"
920:                 .Width          = 42
921:                 .ReadOnly       = .T.
922:                 .BackColor      = RGB(255, 255, 223)
923:                 .ControlSource  = "cursor_4c_Rodape.Volumes"
924:                 .InputMask      = "999"
925:                 WITH .Header1
926:                     .FontSize   = 8
927:                     .Alignment  = 2
928:                     .Caption    = ""
929:                     .BackColor  = RGB(255, 255, 0)
930:                 ENDWITH
931:                 WITH .Text1
932:                     .FontName   = "Courier New"
933:                     .BorderStyle = 0
934:                     .Margin     = 0
935:                     .ForeColor  = RGB(0, 0, 0)
936:                     .BackColor  = RGB(255, 255, 223)
937:                 ENDWITH
938:             ENDWITH
939: 
940:             *-- Col 5: vazia (alinha com Opers)
941:             WITH .Column5
942:                 .FontName       = "Courier New"
943:                 .Width          = 20
944:                 .ReadOnly       = .T.
945:                 .BackColor      = RGB(255, 255, 223)
946:                 .ControlSource  = "cursor_4c_Rodape.CPros"
947:                 WITH .Header1
948:                     .FontSize   = 8
949:                     .Alignment  = 2
950:                     .Caption    = ""
951:                     .BackColor  = RGB(255, 255, 0)
952:                 ENDWITH
953:                 WITH .Text1
954:                     .FontName   = "Courier New"
955:                     .BorderStyle = 0
956:                     .Margin     = 0
957:                     .ForeColor  = RGB(0, 0, 0)
958:                     .BackColor  = RGB(255, 255, 223)
959:                 ENDWITH
960:             ENDWITH
961: 
962:             *-- Col 6: QtdOs total
963:             WITH .Column6
964:                 .FontName       = "Courier New"
965:                 .Width          = 80
966:                 .ReadOnly       = .T.
967:                 .BackColor      = RGB(255, 255, 223)
968:                 .ControlSource  = "cursor_4c_Rodape.QtdOs"
969:                 .InputMask      = "9999999.99"
970:                 WITH .Header1
971:                     .FontSize   = 8
972:                     .Alignment  = 2
973:                     .Caption    = ""
974:                     .BackColor  = RGB(255, 255, 0)
975:                 ENDWITH
976:                 WITH .Text1
977:                     .FontName   = "Courier New"
978:                     .BorderStyle = 0
979:                     .Margin     = 0
980:                     .ForeColor  = RGB(0, 0, 0)
981:                     .BackColor  = RGB(255, 255, 223)
982:                 ENDWITH
983:             ENDWITH
984: 
985:             *-- Col 7: QtdBs total
986:             WITH .Column7
987:                 .FontName       = "Courier New"
988:                 .Width          = 80
989:                 .ReadOnly       = .T.
990:                 .BackColor      = RGB(255, 255, 223)
991:                 .ControlSource  = "cursor_4c_Rodape.QtdBs"
992:                 .InputMask      = "9999999.99"
993:                 WITH .Header1
994:                     .FontSize   = 8
995:                     .Alignment  = 2
996:                     .Caption    = ""
997:                     .BackColor  = RGB(255, 255, 0)
998:                 ENDWITH
999:                 WITH .Text1
1000:                     .FontName   = "Courier New"
1001:                     .BorderStyle = 0
1002:                     .Margin     = 0
1003:                     .ForeColor  = RGB(0, 0, 0)
1004:                     .BackColor  = RGB(255, 255, 223)
1005:                 ENDWITH
1006:             ENDWITH
1007: 
1008:             *-- Col 8: QtdSs total
1009:             WITH .Column8
1010:                 .FontName       = "Courier New"
1011:                 .Width          = 80
1012:                 .ReadOnly       = .T.
1013:                 .BackColor      = RGB(255, 255, 223)
1014:                 .ControlSource  = "cursor_4c_Rodape.QtdSs"
1015:                 .InputMask      = "9999999.99"
1016:                 WITH .Header1
1017:                     .FontSize   = 8
1018:                     .Alignment  = 2
1019:                     .Caption    = ""
1020:                     .BackColor  = RGB(255, 255, 0)
1021:                 ENDWITH
1022:                 WITH .Text1
1023:                     .FontName   = "Courier New"
1024:                     .BorderStyle = 0
1025:                     .Margin     = 0
1026:                     .ForeColor  = RGB(0, 0, 0)
1027:                     .BackColor  = RGB(255, 255, 223)
1028:                 ENDWITH
1029:             ENDWITH
1030: 
1031:             *-- Col 9: vazia (alinha com Units)
1032:             WITH .Column9
1033:                 .FontName       = "Courier New"
1034:                 .Width          = 100
1035:                 .ReadOnly       = .T.
1036:                 .BackColor      = RGB(255, 255, 223)
1037:                 .ControlSource  = "cursor_4c_Rodape.CPros"
1038:                 WITH .Header1
1039:                     .FontSize   = 8
1040:                     .Alignment  = 2
1041:                     .Caption    = ""
1042:                     .BackColor  = RGB(255, 255, 0)
1043:                 ENDWITH
1044:                 WITH .Text1
1045:                     .FontName   = "Courier New"
1046:                     .BorderStyle = 0
1047:                     .Margin     = 0
1048:                     .ForeColor  = RGB(0, 0, 0)
1049:                     .BackColor  = RGB(255, 255, 223)
1050:                 ENDWITH
1051:             ENDWITH
1052: 
1053:             *-- Col 10: CMoes (moeda)
1054:             WITH .Column10
1055:                 .FontName       = "Courier New"
1056:                 .Width          = 36
1057:                 .ReadOnly       = .T.
1058:                 .BackColor      = RGB(255, 255, 223)
1059:                 .ControlSource  = "cursor_4c_Rodape.CMoes"
1060:                 WITH .Header1
1061:                     .FontSize   = 8
1062:                     .Alignment  = 2
1063:                     .Caption    = ""
1064:                     .BackColor  = RGB(255, 255, 0)
1065:                 ENDWITH
1066:                 WITH .Text1
1067:                     .FontName   = "Courier New"
1068:                     .BorderStyle = 0
1069:                     .Margin     = 0
1070:                     .ForeColor  = RGB(0, 0, 0)
1071:                     .BackColor  = RGB(255, 255, 223)
1072:                 ENDWITH
1073:             ENDWITH
1074: 
1075:             *-- Col 11: Totas total
1076:             WITH .Column11
1077:                 .FontName       = "Courier New"
1078:                 .Width          = 100
1079:                 .ReadOnly       = .T.
1080:                 .BackColor      = RGB(255, 255, 223)
1081:                 .ControlSource  = "cursor_4c_Rodape.Totas"
1082:                 .InputMask      = "999999999.99"
1083:                 WITH .Header1
1084:                     .FontSize   = 8
1085:                     .Alignment  = 2
1086:                     .Caption    = ""
1087:                     .BackColor  = RGB(255, 255, 0)
1088:                 ENDWITH
1089:                 WITH .Text1
1090:                     .FontName   = "Courier New"
1091:                     .BorderStyle = 0
1092:                     .Margin     = 0
1093:                     .ForeColor  = RGB(0, 0, 0)
1094:                     .BackColor  = RGB(255, 255, 223)
1095:                 ENDWITH
1096:             ENDWITH

*-- Linhas 1489 a 1511:
1489:     *==========================================================================
1490:     PROCEDURE LimparCampos()
1491:         IF USED("cursor_4c_Itens")
1492:             SELECT cursor_4c_Itens
1493:             ZAP
1494:         ENDIF
1495:         IF USED("cursor_4c_Rodape")
1496:             SELECT cursor_4c_Rodape
1497:             ZAP
1498:         ENDIF
1499:         THIS.img_4c_FigJpg.Visible = .F.
1500:         THIS.img_4c_FigJpg.Picture = ""
1501:         IF VARTYPE(THIS.grd_4c_Itens) = "O"
1502:             THIS.grd_4c_Itens.Refresh
1503:         ENDIF
1504:         IF VARTYPE(THIS.grd_4c_Rodape) = "O"
1505:             THIS.grd_4c_Rodape.Refresh
1506:         ENDIF
1507:     ENDPROC
1508: 
1509:     *==========================================================================
1510:     * FormParaBO - Form OPERACIONAL viewer: nao ha campos editaveis.
1511:     * Apenas atualiza os parametros de contexto no BO caso o chamador

*-- Linhas 1523 a 1541:
1523: 
1524:     *==========================================================================
1525:     * BOParaForm - Atualiza o titulo do form com base nos parametros correntes
1526:     * do BO. Os grids sao bound ao cursor via ControlSource; o refresh visual
1527:     * eh feito diretamente em CarregarItens/AlternarPagina.
1528:     *==========================================================================
1529:     PROCEDURE BOParaForm()
1530:         THIS.Caption = THIS.this_oBusinessObject.this_cEmp + " - " + ;
1531:                        THIS.this_oBusinessObject.this_cDop + " - " + ;
1532:                        ALLTRIM(STR(THIS.this_oBusinessObject.this_nNum, 6)) + " - Itens"
1533:         IF VARTYPE(THIS.cnt_4c_Sombra) = "O"
1534:             THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
1535:             THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
1536:         ENDIF
1537:     ENDPROC
1538: 
1539:     *==========================================================================
1540:     PROCEDURE Destroy()
1541:     *==========================================================================


### BO (C:\4c\projeto\app\classes\sigpriteBO.prg):
*==============================================================================
* sigpriteBO.prg - Business Object para SIGPRITE (Itens de Ordem de Producao)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (consulta de itens de OP - somente leitura)
*==============================================================================

DEFINE CLASS sigpriteBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Parametros de contexto da OP
    *--------------------------------------------------------------------------
    this_cEmp        = ""    && Empresa (char 3)
    this_cDop        = ""    && Operacao/Documento (char 20)
    this_nNum        = 0     && Numero da OP (numeric 6,0)
    this_cEmpDopNum  = ""    && Chave concatenada: PADR(cEmp,3)+PADR(cDop,20)+STR(nNum,6) = char 29
    this_lChecaDisps = .F.   && Flag: verificar disponibilidade do produto

    *--------------------------------------------------------------------------
    * Item corrente (linha selecionada em grd_4c_Itens)
    *--------------------------------------------------------------------------
    this_nCItens  = 0     && Sequencial do item (numeric 10,0)
    this_cCPros   = ""    && Codigo produto (char 14)
    this_cDPros   = ""    && Descricao produto (char 65)
    this_cObs     = ""    && Observacao (text)
    this_cCUnis   = ""    && Unidade (char 3)
    this_nVolumes = 0     && Volume (numeric 3,0)
    this_cOpers   = ""    && Tipo operacao (char 1)
    this_nQtdOs   = 0     && Quantidade original/SigMvItn.Qtds (numeric 9,3)
    this_nQtdBs   = 0     && Quantidade baixada/SigMvItn.QtBaixas (numeric 9,3)
    this_nQtdSs   = 0     && Quantidade saldo calculada (Qtds - QtBaixas)
    this_nUnits   = 0     && Preco unitario/SigMvItn.Units (numeric 15,6)
    this_cCMoes   = ""    && Codigo moeda/SigMvItn.Moedas (char 3)
    this_nTotas   = 0     && Valor total/SigMvItn.Totas (numeric 11,2)
    this_nDisps   = 0     && Disponibilidade do produto (numeric 9,3)

    *--------------------------------------------------------------------------
    * Controle interno
    *--------------------------------------------------------------------------
    this_cArquivo  = ""    && Caminho arquivo temporario para imagem do produto
    this_nImagems  = 0     && SigCdOpe.Imagems: 1=exibir foto produto, 0=nao

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        THIS.this_cTabela     = "SigMvItn"
        THIS.this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROCEDURE InicializarCursores()
    *==========================================================================
        SET NULL ON
        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            ZAP
        ELSE
            CREATE CURSOR cursor_4c_Itens (CItens n(10), CPros c(14), DPros c(40), ;
                Obs m(4), CUnis c(3), Volumes n(3), Opers c(1), ;
                QtdOs n(10,3), QtdBs n(10,3), QtdSs n(10,3), ;
                Units n(12,2), CMoes c(3), Totas n(12,2), Disps n(10,3))
        ENDIF
        IF USED("cursor_4c_Rodape")
            SELECT cursor_4c_Rodape
            ZAP
        ELSE
            CREATE CURSOR cursor_4c_Rodape (CPros c(14), Volumes n(3), ;
                QtdOs n(10,3), QtdBs n(10,3), QtdSs n(10,3), ;
                CMoes c(3), Totas n(12,2))
        ENDIF
        SET NULL OFF
    ENDPROC

    *==========================================================================
    PROCEDURE BuscarItens()
    *==========================================================================
        LOCAL loc_cSQL, loc_lResultado, loc_nRec
        loc_lResultado = .F.
        loc_nRec       = 0

        TRY
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF

            loc_cSQL = "SELECT a.CItens, a.CPros, a.DPros, a.Obs, a.CUnis, c.Volumes, " + ;
                       "a.Opers, a.Qtds AS QtdOs, a.QtBaixas AS QtdBs, " + ;
                       "(a.Qtds - a.QtBaixas) AS QtdSs, a.Units, a.Moedas AS CMoes, a.Totas " + ;
                       "FROM SigMvItn a, SigCdOpe b, SigCdPro c " + ;
                       "WHERE a.EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNum) + ;
                       " AND a.Dopes = b.Dopes AND a.CPros = c.CPros " + ;
                       "ORDER BY a.CItens, a.CPros"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp") < 1
                MsgErro("Falha ao executar consulta de itens da OP.", "Erro SQL")
            ELSE
                IF USED("cursor_4c_Itens")
                    SELECT cursor_4c_Itens
                    ZAP
                ENDIF
                IF USED("cursor_4c_Rodape")
                    SELECT cursor_4c_Rodape
                    ZAP
                ENDIF

                *-- Popular cursor_4c_Itens (CItens = numero sequencial como no legado)
                SELECT cursor_4c_DadosTemp
                SCAN
                    loc_nRec = loc_nRec + 1
                    INSERT INTO cursor_4c_Itens ;
                        (CItens, CPros, DPros, Obs, CUnis, Volumes, Opers, ;
                         QtdOs, QtdBs, QtdSs, Units, CMoes, Totas, Disps) ;
                    VALUES ;
                        (loc_nRec, ;
                         cursor_4c_DadosTemp.CPros, ;
                         cursor_4c_DadosTemp.DPros, ;
                         NVL(cursor_4c_DadosTemp.Obs, ""), ;
                         cursor_4c_DadosTemp.CUnis, ;
                         cursor_4c_DadosTemp.Volumes, ;
                         cursor_4c_DadosTemp.Opers, ;
                         cursor_4c_DadosTemp.QtdOs, ;
                         cursor_4c_DadosTemp.QtdBs, ;
                         cursor_4c_DadosTemp.QtdSs, ;
                         cursor_4c_DadosTemp.Units, ;
                         cursor_4c_DadosTemp.CMoes, ;
                         cursor_4c_DadosTemp.Totas, ;
                         0)
                ENDSCAN

                *-- Popular cursor_4c_Rodape (totais por moeda)
                IF USED("cursor_4c_TotalTemp")
                    USE IN cursor_4c_TotalTemp
                ENDIF
                SELECT CMoes, SUM(Volumes) AS Volumes, SUM(QtdOs) AS QtdOs, ;
                       SUM(QtdBs) AS QtdBs, SUM(QtdSs) AS QtdSs, SUM(Totas) AS Totas ;
                  FROM cursor_4c_DadosTemp ;
                 GROUP BY CMoes ;
                  INTO CURSOR cursor_4c_TotalTemp READWRITE

                SELECT cursor_4c_TotalTemp
                SCAN
                    INSERT INTO cursor_4c_Rodape ;
                        (CPros, Volumes, QtdOs, QtdBs, QtdSs, CMoes, Totas) ;
                    VALUES ;
                        ("", ;
                         cursor_4c_TotalTemp.Volumes, ;
                         cursor_4c_TotalTemp.QtdOs, ;
                         cursor_4c_TotalTemp.QtdBs, ;
                         cursor_4c_TotalTemp.QtdSs, ;
                         cursor_4c_TotalTemp.CMoes, ;
                         cursor_4c_TotalTemp.Totas)
                ENDSCAN

                IF USED("cursor_4c_TotalTemp")
                    USE IN cursor_4c_TotalTemp
                ENDIF
                IF USED("cursor_4c_DadosTemp")
                    USE IN cursor_4c_DadosTemp
                ENDIF

                IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
                    GO TOP IN cursor_4c_Itens
                ENDIF
                IF USED("cursor_4c_Rodape") AND !EOF("cursor_4c_Rodape")
                    GO TOP IN cursor_4c_Rodape
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao buscar itens")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nCItens  = NVL(CItens, 0)
            THIS.this_cCPros   = ALLTRIM(NVL(CPros, ""))
            THIS.this_cDPros   = ALLTRIM(NVL(DPros, ""))
            THIS.this_cObs     = NVL(Obs, "")
            THIS.this_cCUnis   = ALLTRIM(NVL(CUnis, ""))
            THIS.this_nVolumes = NVL(Volumes, 0)
            THIS.this_cOpers   = ALLTRIM(NVL(Opers, ""))
            THIS.this_nQtdOs   = NVL(QtdOs, 0)
            THIS.this_nQtdBs   = NVL(QtdBs, 0)
            THIS.this_nQtdSs   = NVL(QtdSs, 0)
            THIS.this_nUnits   = NVL(Units, 0)
            THIS.this_cCMoes   = ALLTRIM(NVL(CMoes, ""))
            THIS.this_nTotas   = NVL(Totas, 0)
            THIS.this_nDisps   = NVL(Disps, 0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarInfoOperacao(par_cDopes)
    *==========================================================================
        LOCAL loc_cSQL, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_SigCdOpeInfo")
                USE IN cursor_4c_SigCdOpeInfo
            ENDIF

            loc_cSQL = "SELECT TOP 1 Imagems FROM SigCdOpe " + ;
                       "WHERE Dopes = " + EscaparSQL(PADR(par_cDopes, 20))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpeInfo") > 0
                SELECT cursor_4c_SigCdOpeInfo
                IF !EOF()
                    THIS.this_nImagems = NVL(Imagems, 0)
                ENDIF
                loc_lResultado = .T.
            ENDIF

            IF USED("cursor_4c_SigCdOpeInfo")
                USE IN cursor_4c_SigCdOpeInfo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                "Erro ao carregar opera" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarImagemProduto(par_cCPros, par_cArquivo)
    *==========================================================================
        LOCAL loc_cSQL, loc_cFoto, loc_lResultado
        loc_lResultado       = .F.
        THIS.this_cArquivo   = ""

        TRY
            IF USED("cursor_4c_ImgPro")
                USE IN cursor_4c_ImgPro
            ENDIF

            loc_cSQL = "SELECT TOP 1 FigJpgs FROM SigCdPro " + ;
                       "WHERE CPros = " + EscaparSQL(par_cCPros)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImgPro") > 0
                SELECT cursor_4c_ImgPro
                IF !EOF() AND !EMPTY(FigJpgs) AND !ISNULL(FigJpgs)
                    CLEAR RESOURCES
                    loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(FigJpgs, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    STRTOFILE(loc_cFoto, par_cArquivo)
                    THIS.this_cArquivo = par_cArquivo
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_ImgPro")
                USE IN cursor_4c_ImgPro
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                "Erro ao carregar imagem do produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN PADR(THIS.this_cEmpDopNum, 29) + TRANSFORM(THIS.this_nCItens)
    ENDFUNC

    *==========================================================================
    * ValidarDados - Valida propriedades obrigatorias antes de Inserir/Atualizar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        THIS.this_cMensagemErro = ""

        IF EMPTY(THIS.this_cEmp)
            THIS.this_cMensagemErro = "Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cDop)
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        IF THIS.this_nNum <= 0
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero da OP " + CHR(233) + " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cCPros)
            THIS.this_cMensagemErro = "Produto " + CHR(233) + " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        IF THIS.this_nQtdOs < 0
            THIS.this_cMensagemErro = "Quantidade n" + CHR(227) + "o pode ser negativa."
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cEmpDopNum)
            THIS.this_cEmpDopNum = PADR(THIS.this_cEmp, 3) + PADR(THIS.this_cDop, 20) + ;
                                    STR(THIS.this_nNum, 6)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Inserir - INSERT em SigMvItn dos campos gerenciados pelo BO
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_lResultado, loc_oErro, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigMvItn " + ;
                       "(Emps, Dopes, Numes, EmpDopNums, CItens, CPros, DPros, Obs, " + ;
                       "CUnis, Opers, Qtds, QtBaixas, Units, Moedas, Totas, DtAlts) " + ;
                       "VALUES (" + ;
                       EscaparSQL(PADR(THIS.this_cEmp, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cDop, 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNum, 0) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cEmpDopNum, 29)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCItens, 0) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cCPros, 14)) + ", " + ;
                       EscaparSQL(PADR(LEFT(THIS.this_cDPros, 65), 65)) + ", " + ;
                       EscaparSQL(THIS.this_cObs) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cCUnis, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cOpers, 1)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdOs, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdBs, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nUnits, 6) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cCMoes, 3)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotas, 2) + ", " + ;
                       "GETDATE())"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir item da OP."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao inserir item")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE em SigMvItn dos campos gerenciados pelo BO
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_lResultado, loc_oErro, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigMvItn SET " + ;
                       "CPros    = " + EscaparSQL(PADR(THIS.this_cCPros, 14)) + ", " + ;
                       "DPros    = " + EscaparSQL(PADR(LEFT(THIS.this_cDPros, 65), 65)) + ", " + ;
                       "Obs      = " + EscaparSQL(THIS.this_cObs) + ", " + ;
                       "CUnis    = " + EscaparSQL(PADR(THIS.this_cCUnis, 3)) + ", " + ;
                       "Opers    = " + EscaparSQL(PADR(THIS.this_cOpers, 1)) + ", " + ;
                       "Qtds     = " + FormatarNumeroSQL(THIS.this_nQtdOs, 3) + ", " + ;
                       "QtBaixas = " + FormatarNumeroSQL(THIS.this_nQtdBs, 3) + ", " + ;
                       "Units    = " + FormatarNumeroSQL(THIS.this_nUnits, 6) + ", " + ;
                       "Moedas   = " + EscaparSQL(PADR(THIS.this_cCMoes, 3)) + ", " + ;
                       "Totas    = " + FormatarNumeroSQL(THIS.this_nTotas, 2) + ", " + ;
                       "DtAlts   = GETDATE() " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(PADR(THIS.this_cEmpDopNum, 29)) + " " + ;
                       "  AND CItens = " + FormatarNumeroSQL(THIS.this_nCItens, 0)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar item da OP."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao atualizar item")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE em SigMvItn do item corrente
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_lResultado, loc_oErro, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigMvItn " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(PADR(THIS.this_cEmpDopNum, 29)) + " " + ;
                       "  AND CItens = " + FormatarNumeroSQL(THIS.this_nCItens, 0)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao excluir item da OP."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao excluir item")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

