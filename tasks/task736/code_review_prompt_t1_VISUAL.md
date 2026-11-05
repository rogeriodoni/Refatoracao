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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpFpg.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (4750 linhas total):

*-- Linhas 24 a 44:
24: * FASE 3/8: estrutura base - DEFINE CLASS, propriedades que espelham o
25: * contexto recebido do form pai e o estado do painel (Leitor/Digpar/CotUsu),
26: * Init(par_oFormPai, par_nDataSessionPai, par_lAltDireta) equivalente a
27: * Lparameters pForm, DatSes, llAltDireta, InicializarForm() (cria o BO,
28: * espelha Op_Escolha/AltDireta nele, desabilita o form pai) e os elementos
29: * puramente decorativos do layout (faixa do cabecalho cnt_4c_Sombra e os dois
30: * elementos graficos soltos do form - shp_4c_Shape1/lin_4c_Line1).
31: *
32: * FASE 4/8: Grade de formas de pagamento (grd_4c_Dados, equivalente
33: * a Grade/xPar do legado - cursor local cursor_4c_Dados com as 5 colunas
34: * usadas pelo grid: FPags/Valos/Vencs/MoeFpgs/CotFpgs) e os botoes Apaga/Ok/
35: * Cancela (cmd_4c_Apaga/cmd_4c_Ok/cmd_4c_Cancela), adicionados ao form DEPOIS
36: * da faixa do cabecalho para desenhar por cima dela (regra #11 - os botoes
37: * ficam em Top=3, dentro da faixa de Top=0..80). Os demais campos de xPar
38: * (bancos/agencias/contas/numeros/cartaos/nocreditos/ncarnes/outros/obs), que
39: * so os paineis flutuantes da Fase 6 usam, entram quando essa fase ampliar a
40: * mesma CREATE CURSOR (nao criar um segundo cursor_4c_Dados em outro lugar -
41: * regra de forms OPERACIONAIS: mesmo cursor, mesma ordem de campos sempre).
42: *
43: * Junto com a grade vem o FUNIL de carga/repintura - CarregarDados() - que
44: * transcreve o que o Init legado faz com a grade:

*-- Linhas 358 a 438:
358: 
359:     *--------------------------------------------------------------------------
360:     * ConfigurarCabecalho - Faixa cinza do topo (cntSombra no legado)
361:     *--------------------------------------------------------------------------
362:     PROTECTED PROCEDURE ConfigurarCabecalho()
363:         THIS.AddObject("cnt_4c_Sombra", "Container")
364:         WITH THIS.cnt_4c_Sombra
365:             .Top         = 0
366:             .Left        = 0
367:             .Width       = THIS.Width
368:             .Height      = 80
369:             .BorderWidth = 0
370:             .BackStyle   = 1
371:             .BackColor   = RGB(100, 100, 100)
372:             .Visible     = .T.
373:         ENDWITH
374: 
375:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
376:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
377:             .FontBold  = .T.
378:             .FontName  = "Tahoma"
379:             .FontSize  = 18
380:             .WordWrap  = .T.
381:             .Alignment = 0
382:             .BackStyle = 0
383:             .AutoSize  = .F.
384:             .Top       = 18
385:             .Left      = 10
386:             .Width     = 769
387:             .Height    = 40
388:             .ForeColor = RGB(0, 0, 0)
389:             .Caption   = THIS.Caption
390:             .Visible   = .T.
391:         ENDWITH
392: 
393:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
394:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
395:             .FontBold  = .T.
396:             .FontName  = "Tahoma"
397:             .FontSize  = 18
398:             .WordWrap  = .T.
399:             .Alignment = 0
400:             .BackStyle = 0
401:             .AutoSize  = .F.
402:             .Top       = 17
403:             .Left      = 10
404:             .Width     = 769
405:             .Height    = 46
406:             .ForeColor = RGB(255, 255, 255)
407:             .Caption   = THIS.Caption
408:             .Visible   = .T.
409:         ENDWITH
410:     ENDPROC
411: 
412:     *--------------------------------------------------------------------------
413:     * ConfigurarDecoracao - Elementos graficos soltos do form legado, sem
414:     * dado nem comportamento (Shape1 em torno do bloco de moeda/cotacao,
415:     * Line1 separando o bloco de totais).
416:     *--------------------------------------------------------------------------
417:     PROTECTED PROCEDURE ConfigurarDecoracao()
418:         THIS.AddObject("shp_4c_Shape1", "Shape")
419:         WITH THIS.shp_4c_Shape1
420:             .Top         = 7
421:             .Left        = 622
422:             .Width       = 173
423:             .Height      = 110
424:             .BackStyle   = 0
425:             .BorderStyle = 0
426:             .BorderColor = RGB(136, 189, 188)
427:             .Visible     = .T.
428:         ENDWITH
429: 
430:         THIS.AddObject("lin_4c_Line1", "Line")
431:         WITH THIS.lin_4c_Line1
432:             .Top         = 173
433:             .Left        = 429
434:             .Width       = 108
435:             .Height      = 0
436:             .BorderWidth = 2
437:             .Visible     = .T.
438:         ENDWITH

*-- Linhas 471 a 544:
471:     * parcelas). A alternancia de Visible fica para a Fase 8 - aqui os dois
472:     * sao criados nas coordenadas exatas do SCX.
473:     *
474:     * Get_COTACAO/cmd_4c_Alteracotacao e GetObs/lbl_4c_Obs nascem Visible=.F.
475:     * (dump) - permanecem assim: TornarControlesVisiveis so forca Visible=.T.
476:     * em controles que ja estao .T., preservando os .F. explicitos aplicados
477:     * DEPOIS dele (igual ao padrao de AjustarBotoesPorModo/cmd_4c_Apaga).
478:     *--------------------------------------------------------------------------
479:     PROTECTED PROCEDURE ConfigurarCampos()
480: 
481:         *-- Say12 "Cond. Pagto : " + Get_fpg -------------------------------
482:         THIS.AddObject("lbl_4c_Label12", "Label")
483:         WITH THIS.lbl_4c_Label12
484:             .FontName  = "Tahoma"
485:             .FontSize  = 8
486:             .AutoSize  = .F.
487:             .Alignment = 0
488:             .BackStyle = 0
489:             .WordWrap  = .F.
490:             .Caption   = "Cond. Pagto : "
491:             .Left      = 108
492:             .Top       = 127
493:             .Width     = 70
494:             .Height    = 15
495:             .ForeColor = RGB(90, 90, 90)
496:             .Visible   = .T.
497:         ENDWITH
498: 
499:         THIS.AddObject("txt_4c_Fpg", "TextBox")
500:         WITH THIS.txt_4c_Fpg
501:             .FontName    = "Tahoma"
502:             .FontSize    = 8
503:             .Value       = ""
504:             .MaxLength   = 12
505:             .Left        = 181
506:             .Top         = 123
507:             .Width       = 94
508:             .Height      = 23
509:             .ToolTipText = "Digite a forma de pagamento"
510:             .TabIndex    = 1
511:             .Visible     = .T.
512:         ENDWITH
513: 
514:         *-- Say13 "Qtde. Parcelas : " + Get_npar ----------------------------
515:         THIS.AddObject("lbl_4c_Label13", "Label")
516:         WITH THIS.lbl_4c_Label13
517:             .FontName  = "Tahoma"
518:             .FontSize  = 8
519:             .AutoSize  = .F.
520:             .Alignment = 0
521:             .BackStyle = 0
522:             .WordWrap  = .F.
523:             .Caption   = "Qtde. Parcelas : "
524:             .Left      = 97
525:             .Top       = 152
526:             .Width     = 80
527:             .Height    = 15
528:             .ForeColor = RGB(90, 90, 90)
529:             .Visible   = .T.
530:         ENDWITH
531: 
532:         THIS.AddObject("txt_4c_Npar", "TextBox")
533:         WITH THIS.txt_4c_Npar
534:             .FontName    = "Tahoma"
535:             .FontSize    = 8
536:             .Value       = 0
537:             .InputMask   = "99"
538:             .Left        = 181
539:             .Top         = 148
540:             .Width       = 24
541:             .Height      = 23
542:             .ToolTipText = "N" + CHR(250) + "mero de Parcelas"
543:             .TabIndex    = 2
544:             .Visible     = .T.

*-- Linhas 552 a 561:
552:             .Alignment = 3
553:             .Value     = 0
554:             .InputMask = "999.9%"
555:             .Left      = 235
556:             .Top       = 148
557:             .Width     = 54
558:             .Height    = 23
559:             .TabIndex  = 3
560:             .Visible   = .T.
561:         ENDWITH

*-- Linhas 568 a 626:
568:             .FontSize  = 9
569:             .Value     = 0
570:             .InputMask = "999,999,999.99"
571:             .Left      = 181
572:             .Top       = 148
573:             .Width     = 31
574:             .Height    = 23
575:             .TabIndex  = 16
576:             *-- Get_MoeOcr.When legado = Return(.F.) - nunca digitavel
577:             .Enabled   = .F.
578:             .Visible   = .T.
579:         ENDWITH
580: 
581:         *-- Say_Cotacao "Cotacao : " + Get_COTACAO + alteracotacao (\<C$) --
582:         *-- os tres nascem Visible = .F. no dump (bloco de alteracao manual
583:         *-- de cotacao, habilitado so quando o usuario clica no botao C$) --
584:         THIS.AddObject("lbl_4c__Cotacao", "Label")
585:         WITH THIS.lbl_4c__Cotacao
586:             .FontName  = "Tahoma"
587:             .FontSize  = 8
588:             .AutoSize  = .F.
589:             .Alignment = 0
590:             .BackStyle = 0
591:             .WordWrap  = .F.
592:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o : "
593:             .Left      = 128
594:             .Top       = 177
595:             .Width     = 49
596:             .Height    = 15
597:             .ForeColor = RGB(90, 90, 90)
598:             .Visible   = .F.
599:         ENDWITH
600: 
601:         THIS.AddObject("txt_4c_COTACAO", "TextBox")
602:         WITH THIS.txt_4c_COTACAO
603:             .FontName  = "Courier New"
604:             .FontSize  = 9
605:             .Value     = 0
606:             .InputMask = "999.9999"
607:             .Left      = 181
608:             .Top       = 173
609:             .Width     = 74
610:             .Height    = 23
611:             .TabIndex  = 4
612:             .Visible   = .F.
613:         ENDWITH
614: 
615:         THIS.AddObject("cmd_4c_Alteracotacao", "CommandButton")
616:         WITH THIS.cmd_4c_Alteracotacao
617:             .Top        = 172
618:             .Left       = 261
619:             .Width      = 28
620:             .Height     = 24
621:             .Caption    = "\<C$"
622:             .FontBold   = .T.
623:             .FontItalic = .T.
624:             .FontName   = "Comic Sans MS"
625:             .FontSize   = 8
626:             .TabStop    = .F.

*-- Linhas 632 a 650:
632:         ENDWITH
633: 
634:         *-- Say17 "Valor : " + Get_vpar -------------------------------------
635:         THIS.AddObject("lbl_4c_Label17", "Label")
636:         WITH THIS.lbl_4c_Label17
637:             .FontName  = "Tahoma"
638:             .FontSize  = 8
639:             .AutoSize  = .F.
640:             .Alignment = 0
641:             .BackStyle = 0
642:             .WordWrap  = .F.
643:             .Caption   = "Valor : "
644:             .Left      = 144
645:             .Top       = 203
646:             .Width     = 34
647:             .Height    = 15
648:             .ForeColor = RGB(90, 90, 90)
649:             .Visible   = .T.
650:         ENDWITH

*-- Linhas 656 a 684:
656:             .Alignment   = 3
657:             .Value       = 0
658:             .InputMask   = "999,999,999.99"
659:             .Left        = 181
660:             .Top         = 198
661:             .Width       = 108
662:             .Height      = 23
663:             .ToolTipText = "Valor de cada Parcela"
664:             .TabIndex    = 6
665:             .Visible     = .T.
666:         ENDWITH
667: 
668:         *-- Say1 "Enc. Financ. : " + Get_PEncargo ---------------------------
669:         THIS.AddObject("lbl_4c_Label1", "Label")
670:         WITH THIS.lbl_4c_Label1
671:             .FontName  = "Tahoma"
672:             .FontSize  = 8
673:             .AutoSize  = .F.
674:             .Alignment = 0
675:             .BackStyle = 0
676:             .WordWrap  = .F.
677:             .Caption   = "Enc. Financ. : "
678:             .Left      = 109
679:             .Top       = 228
680:             .Width     = 68
681:             .Height    = 15
682:             .ForeColor = RGB(90, 90, 90)
683:             .Visible   = .T.
684:         ENDWITH

*-- Linhas 690 a 717:
690:             .Alignment = 3
691:             .Value     = 0
692:             .InputMask = "999,999.99 %"
693:             .Left      = 181
694:             .Top       = 223
695:             .Width     = 96
696:             .Height    = 23
697:             .TabIndex  = 7
698:             .Visible   = .T.
699:         ENDWITH
700: 
701:         *-- Say19 "Valor Encargo : " + Get_VEncargo -------------------------
702:         THIS.AddObject("lbl_4c_Label19", "Label")
703:         WITH THIS.lbl_4c_Label19
704:             .FontName  = "Tahoma"
705:             .FontSize  = 8
706:             .AutoSize  = .F.
707:             .Alignment = 0
708:             .BackStyle = 0
709:             .WordWrap  = .F.
710:             .Caption   = "Valor Encargo : "
711:             .Left      = 102
712:             .Top       = 253
713:             .Width     = 75
714:             .Height    = 15
715:             .ForeColor = RGB(90, 90, 90)
716:             .Visible   = .T.
717:         ENDWITH

*-- Linhas 723 a 752:
723:             .Alignment = 3
724:             .Value     = 0
725:             .InputMask = "999,999,999.99"
726:             .Left      = 181
727:             .Top       = 248
728:             .Width     = 108
729:             .Height    = 23
730:             .TabIndex  = 8
731:             *-- Get_VEncargo.When legado = Return .f. - nunca digitavel
732:             .Enabled   = .F.
733:             .Visible   = .T.
734:         ENDWITH
735: 
736:         *-- Say18 "Vencimento : " + fweditdata_venc -------------------------
737:         THIS.AddObject("lbl_4c_Label18", "Label")
738:         WITH THIS.lbl_4c_Label18
739:             .FontName  = "Tahoma"
740:             .FontSize  = 8
741:             .AutoSize  = .F.
742:             .Alignment = 0
743:             .BackStyle = 0
744:             .WordWrap  = .F.
745:             .Caption   = "Vencimento : "
746:             .Left      = 113
747:             .Top       = 277
748:             .Width     = 64
749:             .Height    = 15
750:             .ForeColor = RGB(90, 90, 90)
751:             .Visible   = .T.
752:         ENDWITH

*-- Linhas 760 a 788:
760:             .FontSize    = 8
761:             .Themes      = .F.
762:             .Value       = {}
763:             .Left        = 181
764:             .Top         = 273
765:             .Width       = 80
766:             .Height      = 23
767:             .ToolTipText = "Data de Vencimento"
768:             .TabIndex    = 9
769:             .Visible     = .T.
770:         ENDWITH
771: 
772:         *-- Say20 "Moeda dos Cheques : " + Get_MoeOper ----------------------
773:         THIS.AddObject("lbl_4c_Label20", "Label")
774:         WITH THIS.lbl_4c_Label20
775:             .FontName  = "Tahoma"
776:             .FontSize  = 8
777:             .AutoSize  = .F.
778:             .Alignment = 0
779:             .BackStyle = 0
780:             .WordWrap  = .F.
781:             .Caption   = "Moeda dos Cheques : "
782:             .Left      = 318
783:             .Top       = 128
784:             .Width     = 105
785:             .Height    = 15
786:             .ForeColor = RGB(90, 90, 90)
787:             .Visible   = .T.
788:         ENDWITH

*-- Linhas 795 a 824:
795:             .FontName  = "Courier New"
796:             .FontSize  = 9
797:             .Value     = ""
798:             .Left      = 429
799:             .Top       = 122
800:             .Width     = 31
801:             .Height    = 23
802:             .TabIndex  = 17
803:             *-- Get_MoeOper.When legado = Return(.F.) - nunca digitavel
804:             .Enabled   = .F.
805:             .Visible   = .T.
806:         ENDWITH
807: 
808:         *-- Say24 "Total dos Cheques : " + Get_ValTotChqs -------------------
809:         THIS.AddObject("lbl_4c_Label24", "Label")
810:         WITH THIS.lbl_4c_Label24
811:             .FontName  = "Tahoma"
812:             .FontSize  = 8
813:             .AutoSize  = .F.
814:             .Alignment = 0
815:             .BackStyle = 0
816:             .WordWrap  = .F.
817:             .Caption   = "Total dos Cheques : "
818:             .Left      = 326
819:             .Top       = 152
820:             .Width     = 98
821:             .Height    = 15
822:             .ForeColor = RGB(90, 90, 90)
823:             .Visible   = .T.
824:         ENDWITH

*-- Linhas 831 a 860:
831:             .Value     = 0
832:             .InputMask = "999,999,999.99"
833:             .Margin    = 0
834:             .Left      = 429
835:             .Top       = 148
836:             .Width     = 108
837:             .Height    = 20
838:             .TabIndex  = 28
839:             *-- Get_ValTotChqs.When legado = Return(.f.) - nunca digitavel
840:             .Enabled   = .F.
841:             .Visible   = .T.
842:         ENDWITH
843: 
844:         *-- Say23 "Total Forma Pagto : " + Get_TotForma ---------------------
845:         THIS.AddObject("lbl_4c_Label23", "Label")
846:         WITH THIS.lbl_4c_Label23
847:             .FontName  = "Tahoma"
848:             .FontSize  = 8
849:             .AutoSize  = .F.
850:             .Alignment = 0
851:             .BackStyle = 0
852:             .WordWrap  = .F.
853:             .Caption   = "Total Forma Pagto : "
854:             .Left      = 327
855:             .Top       = 179
856:             .Width     = 98
857:             .Height    = 15
858:             .ForeColor = RGB(90, 90, 90)
859:             .Visible   = .T.
860:         ENDWITH

*-- Linhas 868 a 911:
868:             .Format    = "K"
869:             .InputMask = "999,999,999.99"
870:             .Margin    = 0
871:             .Left      = 429
872:             .Top       = 177
873:             .Width     = 108
874:             .Height    = 20
875:             .TabIndex  = 30
876:             *-- Get_TotForma.When legado = Return(.F.) - nunca digitavel
877:             .Enabled   = .F.
878:             .Visible   = .T.
879:         ENDWITH
880: 
881:         *-- SayObs "Observacao" + GetObs (EditBox) - nascem Visible = .F.;
882:         *-- o legado so mostra quando CrSigOpFp.Obs = 1 (MostrarObservacao) -
883:         THIS.AddObject("lbl_4c_Obs", "Label")
884:         WITH THIS.lbl_4c_Obs
885:             .FontName  = "Tahoma"
886:             .FontSize  = 8
887:             .AutoSize  = .F.
888:             .Alignment = 0
889:             .BackStyle = 0
890:             .WordWrap  = .F.
891:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
892:             .Left      = 521
893:             .Top       = 297
894:             .Width     = 90
895:             .Height    = 15
896:             .ForeColor = RGB(90, 90, 90)
897:             .Visible   = .F.
898:         ENDWITH
899: 
900:         THIS.AddObject("obj_4c_GetObs", "EditBox")
901:         WITH THIS.obj_4c_GetObs
902:             .FontName  = "Tahoma"
903:             .FontSize  = 8
904:             .ForeColor = RGB(0, 0, 0)
905:             .Left      = 519
906:             .Top       = 314
907:             .Width     = 192
908:             .Height    = 138
909:             .TabIndex  = 36
910:             .Visible   = .F.
911:         ENDWITH

*-- Linhas 919 a 956:
919:             .Stretch     = 0
920:             .BorderStyle = 0
921:             .Enabled     = .F.
922:             .Left        = 556
923:             .Top         = 117
924:             .Width       = 25
925:             .Height      = 25
926:             .Visible     = .T.
927:         ENDWITH
928: 
929:         THIS.AddObject("img_4c_AvisoPortaT", "Image")
930:         WITH THIS.img_4c_AvisoPortaT
931:             .Picture     = gc_4c_CaminhoIcones + "B_ALPHAT.BMP"
932:             .Stretch     = 0
933:             .BackStyle   = 1
934:             .BorderStyle = 0
935:             .Enabled     = .F.
936:             .Left        = 580
937:             .Top         = 117
938:             .Width       = 25
939:             .Height      = 25
940:             .Visible     = .T.
941:         ENDWITH
942: 
943:         THIS.AddObject("img_4c_AvisoPortaS", "Image")
944:         WITH THIS.img_4c_AvisoPortaS
945:             .Picture     = gc_4c_CaminhoIcones + "B_ALPHAS.BMP"
946:             .Stretch     = 0
947:             .BackStyle   = 1
948:             .BorderStyle = 0
949:             .Enabled     = .F.
950:             .Left        = 604
951:             .Top         = 117
952:             .Width       = 25
953:             .Height      = 25
954:             .Visible     = .T.
955:         ENDWITH
956:     ENDPROC

*-- Linhas 979 a 988:
979: 
980:         THIS.AddObject("grd_4c_Dados", "Grid")
981:         WITH THIS.grd_4c_Dados
982:             .Top        = 304
983:             .Left       = 89
984:             .Width      = 425
985:             .Height     = 149
986:             *-- TabIndex do dump (SIGOPFPG.Grade.TabIndex = 10). O VFP limita o
987:             *-- valor ao numero de controles ja existentes no container, entao
988:             *-- enquanto os campos do cabecalho e os paineis flutuantes nao

*-- Linhas 1187 a 1215:
1187:             .Column1.Header1.FontName  = "Tahoma"
1188:             .Column1.Header1.FontSize  = 8
1189:             .Column1.Header1.Alignment = 2
1190:             .Column1.Header1.Caption   = "Cond. Pagto"
1191: 
1192:             .Column2.Header1.FontName  = "Tahoma"
1193:             .Column2.Header1.FontSize  = 8
1194:             .Column2.Header1.Alignment = 2
1195:             .Column2.Header1.Caption   = "Valor"
1196: 
1197:             .Column3.Header1.FontName  = "Tahoma"
1198:             .Column3.Header1.FontSize  = 8
1199:             .Column3.Header1.Alignment = 2
1200:             .Column3.Header1.Caption   = "Vencimento"
1201: 
1202:             .Column4.Header1.FontName  = "Tahoma"
1203:             .Column4.Header1.FontSize  = 8
1204:             .Column4.Header1.Alignment = 2
1205:             .Column4.Header1.Caption   = "Moe"
1206: 
1207:             .Column5.Header1.FontName  = "Tahoma"
1208:             .Column5.Header1.FontSize  = 8
1209:             .Column5.Header1.Alignment = 2
1210:             .Column5.Header1.Caption   = "Cota" + CHR(231) + CHR(227) + "o"
1211:         ENDWITH
1212: 
1213:         *-- Celulas de Valor/Vencimento validam no PROPRIO Valid - regra #46:
1214:         *-- NUNCA em AfterRowColChange (nColIndex ali eh a coluna de DESTINO).
1215:         *-- BINDEVENT em Valid de TextBox de Column nao eh confiavel - por

*-- Linhas 1302 a 1351:
1302:     * automatico (regra #3).
1303:     *--------------------------------------------------------------------------
1304:     PROCEDURE AjustarBotoesPorModo()
1305:         THIS.cmd_4c_Apaga.Visible = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), ;
1306:                                            "INSERIR", "ALTERAR")
1307:     ENDPROC
1308: 
1309:     *--------------------------------------------------------------------------
1310:     * OcultarCamposCondicionais - Reaplica o Visible = .F. dos controles que
1311:     * o dump do SCX ja nasce ocultos (Say_Cotacao/Get_COTACAO/alteracotacao -
1312:     * bloco de alteracao manual de cotacao; SayObs/GetObs - observacao livre,
1313:     * so aparece quando CrSigOpFp.Obs = 1). TornarControlesVisiveis forca
1314:     * Visible = .T. em TODO controle criado por AddObject, entao esses quatro
1315:     * tem de ser reescondidos DEPOIS dele - mesmo padrao de
1316:     * AjustarBotoesPorModo()/cmd_4c_Apaga.
1317:     *
1318:     * A alternancia real (mostrar quando o usuario clica "C$" ou quando o
1319:     * registro tem Obs = 1) esta em MostrarObservacao (Fase 7); aqui o estado
1320:     * INICIAL, igual ao SCX, eh preservado.
1321:     *--------------------------------------------------------------------------
1322:     PROTECTED PROCEDURE OcultarCamposCondicionais()
1323:         THIS.lbl_4c__Cotacao.Visible       = .F.
1324:         THIS.txt_4c_COTACAO.Visible        = .F.
1325:         THIS.cmd_4c_Alteracotacao.Visible  = .F.
1326:         THIS.lbl_4c_Obs.Visible            = .F.
1327:         THIS.obj_4c_GetObs.Visible         = .F.
1328:     ENDPROC
1329: 
1330:     *--------------------------------------------------------------------------
1331:     * ConfigurarBotoes - Botoes Apaga/Ok/Cancela (SIGOPFPG.Apaga/Ok/Cancela
1332:     * no legado). Adicionados DIRETO no form (sem container, igual ao dump),
1333:     * DEPOIS de ConfigurarCabecalho/ConfigurarDecoracao para desenhar por
1334:     * cima de cnt_4c_Sombra - Top=3 cai DENTRO da faixa (Top=0..80, regra
1335:     * #11 do CLAUDE.md). Picture/Caption/ToolTipText/Cancel transcritos do
1336:     * dump; Width/Height=75 com Lefts em incrementos de 75 (575/650/725),
1337:     * igual ao padrao canonico dos botoes CRUD do framework.
1338:     *--------------------------------------------------------------------------
1339:     PROTECTED PROCEDURE ConfigurarBotoes()
1340:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
1341:         WITH THIS.cmd_4c_Apaga
1342:             .Top             = 3
1343:             .Left            = 575
1344:             .Width           = 75
1345:             .Height          = 75
1346:             .Caption         = "Apagar"
1347:             .ToolTipText     = "Apagar"
1348:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1349:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1350:             .Themes          = .T.
1351:             .FontName        = "Comic Sans MS"

*-- Linhas 1361 a 1375:
1361:             .Visible         = .T.
1362:         ENDWITH
1363: 
1364:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
1365:         WITH THIS.cmd_4c_Ok
1366:             .Top             = 3
1367:             .Left            = 650
1368:             .Width           = 75
1369:             .Height          = 75
1370:             .Caption         = "\<Confirmar"
1371:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1372:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1373:             .Themes          = .T.
1374:             .FontName        = "Comic Sans MS"
1375:             .FontBold        = .T.

*-- Linhas 1384 a 1399:
1384:             .Visible         = .T.
1385:         ENDWITH
1386: 
1387:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
1388:         WITH THIS.cmd_4c_Cancela
1389:             .Top             = 3
1390:             .Left            = 725
1391:             .Width           = 75
1392:             .Height          = 75
1393:             .Cancel          = .T.
1394:             .Caption         = "Cancelar"
1395:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1396:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1397:             .Themes          = .T.
1398:             .FontName        = "Comic Sans MS"
1399:             .FontBold        = .T.

*-- Linhas 1438 a 1548:
1438:         *-- CntCCred - cartao de credito (painel que o usuario VE) ----------
1439:         THIS.AddObject("cnt_4c_CCred", "Container")
1440:         WITH THIS.cnt_4c_CCred
1441:             .Top           = 216
1442:             .Left          = 304
1443:             .Width         = 400
1444:             .Height        = 74
1445:             .SpecialEffect = 0
1446:             .BackColor     = RGB(255, 255, 255)
1447:             .BorderColor   = RGB(36, 84, 155)
1448:             .TabIndex      = 12
1449:             .Visible       = .F.
1450:         ENDWITH
1451: 
1452:         THIS.cnt_4c_CCred.AddObject("lbl_4c_TituloCartao", "Label")
1453:         WITH THIS.cnt_4c_CCred.lbl_4c_TituloCartao
1454:             .FontName  = "Tahoma"
1455:             .FontSize  = 8
1456:             .FontBold  = .T.
1457:             .AutoSize  = .F.
1458:             .Alignment = 0
1459:             .BackStyle = 0
1460:             .Caption   = "Cart" + CHR(227) + "o Cr" + CHR(233) + "dito"
1461:             .Left      = 4
1462:             .Top       = 5
1463:             .Width     = 84
1464:             .Height    = 15
1465:             .ForeColor = RGB(90, 90, 90)
1466:             .Visible   = .T.
1467:         ENDWITH
1468: 
1469:         THIS.cnt_4c_CCred.AddObject("lbl_4c_LabelCartao", "Label")
1470:         WITH THIS.cnt_4c_CCred.lbl_4c_LabelCartao
1471:             .FontName  = "Tahoma"
1472:             .FontSize  = 8
1473:             .AutoSize  = .F.
1474:             .Alignment = 0
1475:             .BackStyle = 0
1476:             .Caption   = "Cart" + CHR(227) + "o : "
1477:             .Left      = 9
1478:             .Top       = 39
1479:             .Width     = 40
1480:             .Height    = 15
1481:             .ForeColor = RGB(90, 90, 90)
1482:             .Visible   = .T.
1483:         ENDWITH
1484: 
1485:         THIS.cnt_4c_CCred.AddObject("txt_4c_Cartao", "TextBox")
1486:         WITH THIS.cnt_4c_CCred.txt_4c_Cartao
1487:             .FontName  = "Tahoma"
1488:             .Value     = ""
1489:             .Format    = "K"
1490:             .InputMask = "99999999999999999999"
1491:             .Left      = 53
1492:             .Top       = 35
1493:             .Width     = 150
1494:             .Height    = 23
1495:             .ForeColor = RGB(0, 0, 0)
1496:             .TabIndex  = 13
1497:             *-- Get_cartao.When legado: INLIST(op_escolha,'INSERIR','ALTERAR')
1498:             .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
1499:             .Visible   = .T.
1500:         ENDWITH
1501: 
1502:         THIS.cnt_4c_CCred.AddObject("lbl_4c_LabelCredito", "Label")
1503:         WITH THIS.cnt_4c_CCred.lbl_4c_LabelCredito
1504:             .FontName  = "Tahoma"
1505:             .FontSize  = 8
1506:             .AutoSize  = .F.
1507:             .Alignment = 0
1508:             .BackStyle = 0
1509:             .Caption   = "Cr" + CHR(233) + "dito : "
1510:             .Left      = 218
1511:             .Top       = 39
1512:             .Width     = 40
1513:             .Height    = 15
1514:             .ForeColor = RGB(90, 90, 90)
1515:             .Visible   = .T.
1516:         ENDWITH
1517: 
1518:         THIS.cnt_4c_CCred.AddObject("txt_4c_Cred", "TextBox")
1519:         WITH THIS.cnt_4c_CCred.txt_4c_Cred
1520:             .FontName  = "Tahoma"
1521:             .Value     = ""
1522:             .InputMask = "XXXXXXXXXX"
1523:             .Left      = 264
1524:             .Top       = 35
1525:             .Width     = 80
1526:             .Height    = 23
1527:             .ForeColor = RGB(0, 0, 0)
1528:             .TabIndex  = 14
1529:             *-- Get_cred.When legado: vazio se Cartao vazio (comeca .F.)
1530:             .Enabled   = .F.
1531:             .Visible   = .T.
1532:         ENDWITH
1533: 
1534:         THIS.cnt_4c_CCred.AddObject("cmd_4c_Confirma", "CommandButton")
1535:         WITH THIS.cnt_4c_CCred.cmd_4c_Confirma
1536:             .Top         = 24
1537:             .Left        = 348
1538:             .Width       = 40
1539:             .Height      = 40
1540:             .FontName    = "Verdana"
1541:             .FontSize    = 8
1542:             .Picture     = gc_4c_CaminhoIcones + "geral_escudo_ok_32.jpg"
1543:             .Caption     = ""
1544:             .ToolTipText = "Confirmar"
1545:             .ForeColor   = RGB(36, 84, 155)
1546:             .BackColor   = RGB(255, 255, 255)
1547:             .Themes      = .F.
1548:             .TabIndex    = 15

*-- Linhas 1555 a 1582:
1555:         *-- Fase 7, em MostrarObservacao) ------------------------------
1556:         THIS.AddObject("cnt_4c_CCredFP", "Container")
1557:         WITH THIS.cnt_4c_CCredFP
1558:             .Top           = 462
1559:             .Left          = 91
1560:             .Width         = 344
1561:             .Height        = 42
1562:             .SpecialEffect = 0
1563:             .BackColor     = RGB(255, 255, 255)
1564:             .TabIndex      = 16
1565:             .Visible       = .F.
1566:         ENDWITH
1567: 
1568:         THIS.cnt_4c_CCredFP.AddObject("lbl_4c_LabelCartaoFp", "Label")
1569:         WITH THIS.cnt_4c_CCredFP.lbl_4c_LabelCartaoFp
1570:             .FontName  = "Tahoma"
1571:             .FontSize  = 8
1572:             .AutoSize  = .F.
1573:             .Alignment = 0
1574:             .BackStyle = 0
1575:             .Caption   = "Cart" + CHR(227) + "o"
1576:             .Left      = 10
1577:             .Top       = 12
1578:             .Width     = 40
1579:             .Height    = 15
1580:             .ForeColor = RGB(90, 90, 90)
1581:             .Visible   = .T.
1582:         ENDWITH

*-- Linhas 1590 a 1634:
1590:             .ControlSource = THIS.this_cCursorGrade + ".Cartaos"
1591:             .FontName  = "Tahoma"
1592:             .InputMask = "99999999999999999999"
1593:             .Left      = 47
1594:             .Top       = 8
1595:             .Width     = 150
1596:             .Height    = 23
1597:             .ForeColor = RGB(0, 0, 0)
1598:             .TabIndex  = 17
1599:             *-- Get_cartao.When legado: INLIST(op_escolha,...) AND
1600:             *-- carauts#'S' - refinado por AtualizarEnabledCreditoFp quando a
1601:             *-- forma de pagamento eh escolhida
1602:             .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
1603:             .Visible   = .T.
1604:         ENDWITH
1605: 
1606:         THIS.cnt_4c_CCredFP.AddObject("lbl_4c_LabelCreditoFp", "Label")
1607:         WITH THIS.cnt_4c_CCredFP.lbl_4c_LabelCreditoFp
1608:             .FontName  = "Tahoma"
1609:             .FontSize  = 8
1610:             .AutoSize  = .F.
1611:             .Alignment = 0
1612:             .BackStyle = 0
1613:             .Caption   = "Credito"
1614:             .Left      = 214
1615:             .Top       = 12
1616:             .Width     = 40
1617:             .Height    = 15
1618:             .ForeColor = RGB(90, 90, 90)
1619:             .Visible   = .T.
1620:         ENDWITH
1621: 
1622:         THIS.cnt_4c_CCredFP.AddObject("txt_4c_CredFp", "TextBox")
1623:         WITH THIS.cnt_4c_CCredFP.txt_4c_CredFp
1624:             *-- Espelho de xPar.nocreditos (ver comentario de txt_4c_CartaoFp)
1625:             .ControlSource = THIS.this_cCursorGrade + ".Nocreditos"
1626:             .FontName  = "Tahoma"
1627:             .InputMask = "XXXXXXXXXX"
1628:             .Left      = 253
1629:             .Top       = 8
1630:             .Width     = 80
1631:             .Height    = 23
1632:             .ForeColor = RGB(0, 0, 0)
1633:             .TabIndex  = 18
1634:             *-- Get_cred.When legado: vazio se Cartao vazio, senao igual ao

*-- Linhas 1640 a 1667:
1640:         *-- CntCarneFP - numero do carne ------------------------------------
1641:         THIS.AddObject("cnt_4c_CarneFP", "Container")
1642:         WITH THIS.cnt_4c_CarneFP
1643:             .Top           = 510
1644:             .Left          = 197
1645:             .Width         = 154
1646:             .Height        = 42
1647:             .SpecialEffect = 0
1648:             .BackColor     = RGB(255, 255, 255)
1649:             .TabIndex      = 19
1650:             .Visible       = .F.
1651:         ENDWITH
1652: 
1653:         THIS.cnt_4c_CarneFP.AddObject("lbl_4c_LabelCarne", "Label")
1654:         WITH THIS.cnt_4c_CarneFP.lbl_4c_LabelCarne
1655:             .FontName  = "Tahoma"
1656:             .FontSize  = 8
1657:             .AutoSize  = .F.
1658:             .Alignment = 0
1659:             .BackStyle = 0
1660:             .Caption   = "Carne"
1661:             .Left      = 13
1662:             .Top       = 9
1663:             .Width     = 30
1664:             .Height    = 15
1665:             .ForeColor = RGB(90, 90, 90)
1666:             .Visible   = .T.
1667:         ENDWITH

*-- Linhas 1673 a 1726:
1673:             *-- digitado pelo usuario
1674:             .ControlSource = THIS.this_cCursorGrade + ".Ncarnes"
1675:             .FontName  = "Tahoma"
1676:             .Left      = 46
1677:             .Top       = 6
1678:             .Width     = 100
1679:             .Height    = 23
1680:             .ForeColor = RGB(0, 0, 0)
1681:             .TabIndex  = 20
1682:             .Enabled   = .F.
1683:             .Visible   = .T.
1684:         ENDWITH
1685: 
1686:         *-- CntOutrosFP - observacao livre ----------------------------------
1687:         THIS.AddObject("cnt_4c_OutrosFP", "Container")
1688:         WITH THIS.cnt_4c_OutrosFP
1689:             .Top           = 510
1690:             .Left          = 370
1691:             .Width         = 230
1692:             .Height        = 42
1693:             .SpecialEffect = 0
1694:             .BackColor     = RGB(255, 255, 255)
1695:             .TabIndex      = 21
1696:             .Visible       = .F.
1697:         ENDWITH
1698: 
1699:         THIS.cnt_4c_OutrosFP.AddObject("lbl_4c_LabelOutros", "Label")
1700:         WITH THIS.cnt_4c_OutrosFP.lbl_4c_LabelOutros
1701:             .FontName  = "Tahoma"
1702:             .FontSize  = 8
1703:             .AutoSize  = .F.
1704:             .Alignment = 0
1705:             .BackStyle = 0
1706:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
1707:             .Left      = 11
1708:             .Top       = 11
1709:             .Width     = 60
1710:             .Height    = 15
1711:             .ForeColor = RGB(90, 90, 90)
1712:             .Visible   = .T.
1713:         ENDWITH
1714: 
1715:         THIS.cnt_4c_OutrosFP.AddObject("txt_4c_Outros", "TextBox")
1716:         WITH THIS.cnt_4c_OutrosFP.txt_4c_Outros
1717:             *-- Espelho de xPar.outros (observacao livre da forma "Outros")
1718:             .ControlSource = THIS.this_cCursorGrade + ".Outros"
1719:             .FontName  = "Tahoma"
1720:             .Left      = 73
1721:             .Top       = 7
1722:             .Width     = 150
1723:             .Height    = 23
1724:             .ForeColor = RGB(0, 0, 0)
1725:             .TabIndex  = 22
1726:             *-- Get_OBS.When legado: desabilitado so em CONSULTAR/EXCLUIR -

*-- Linhas 1732 a 1759:
1732:         *-- CntChequeFP - dados do cheque (Banco/Agencia/Conta/Numero) ------
1733:         THIS.AddObject("cnt_4c_ChequeFP", "Container")
1734:         WITH THIS.cnt_4c_ChequeFP
1735:             .Top           = 462
1736:             .Left          = 455
1737:             .Width         = 230
1738:             .Height        = 42
1739:             .SpecialEffect = 0
1740:             .BackColor     = RGB(255, 255, 255)
1741:             .TabIndex      = 23
1742:             .Visible       = .F.
1743:         ENDWITH
1744: 
1745:         THIS.cnt_4c_ChequeFP.AddObject("lbl_4c_LabelBco", "Label")
1746:         WITH THIS.cnt_4c_ChequeFP.lbl_4c_LabelBco
1747:             .FontName  = "Tahoma"
1748:             .FontSize  = 8
1749:             .AutoSize  = .F.
1750:             .Alignment = 0
1751:             .BackStyle = 0
1752:             .Caption   = "Bco"
1753:             .Left      = 8
1754:             .Top       = 1
1755:             .Width     = 36
1756:             .Height    = 15
1757:             .ForeColor = RGB(90, 90, 90)
1758:             .Visible   = .T.
1759:         ENDWITH

*-- Linhas 1765 a 1873:
1765:             .ControlSource = THIS.this_cCursorGrade + ".Bancos"
1766:             .FontName  = "Tahoma"
1767:             .MaxLength = 3
1768:             .Left      = 8
1769:             .Top       = 13
1770:             .Width     = 36
1771:             .Height    = 23
1772:             .ForeColor = RGB(0, 0, 0)
1773:             .TabIndex  = 24
1774:             *-- Get_bco.When legado: INLIST(op_escolha,'INSERIR','ALTERAR') -
1775:             *-- a ramificacao de leitora serial dentro do When eh so efeito
1776:             *-- colateral (aviso), replicado em TxtBcoGotFocus
1777:             .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
1778:             .Visible   = .T.
1779:         ENDWITH
1780: 
1781:         THIS.cnt_4c_ChequeFP.AddObject("lbl_4c_LabelAgencia", "Label")
1782:         WITH THIS.cnt_4c_ChequeFP.lbl_4c_LabelAgencia
1783:             .FontName  = "Tahoma"
1784:             .FontSize  = 8
1785:             .AutoSize  = .F.
1786:             .Alignment = 0
1787:             .BackStyle = 0
1788:             .Caption   = "Agencia"
1789:             .Left      = 44
1790:             .Top       = 1
1791:             .Width     = 38
1792:             .Height    = 15
1793:             .ForeColor = RGB(90, 90, 90)
1794:             .Visible   = .T.
1795:         ENDWITH
1796: 
1797:         THIS.cnt_4c_ChequeFP.AddObject("txt_4c_Age", "TextBox")
1798:         WITH THIS.cnt_4c_ChequeFP.txt_4c_Age
1799:             *-- Espelho de xPar.agencias (ver comentario de txt_4c_Bco)
1800:             .ControlSource = THIS.this_cCursorGrade + ".Agencias"
1801:             .FontName  = "Tahoma"
1802:             .MaxLength = 4
1803:             .Left      = 45
1804:             .Top       = 13
1805:             .Width     = 38
1806:             .Height    = 23
1807:             .ForeColor = RGB(0, 0, 0)
1808:             .TabIndex  = 25
1809:             .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
1810:             .Visible   = .T.
1811:         ENDWITH
1812: 
1813:         THIS.cnt_4c_ChequeFP.AddObject("lbl_4c_LabelConta", "Label")
1814:         WITH THIS.cnt_4c_ChequeFP.lbl_4c_LabelConta
1815:             .FontName  = "Tahoma"
1816:             .FontSize  = 8
1817:             .AutoSize  = .F.
1818:             .Alignment = 0
1819:             .BackStyle = 0
1820:             .Caption   = "Conta"
1821:             .Left      = 86
1822:             .Top       = 1
1823:             .Width     = 80
1824:             .Height    = 15
1825:             .ForeColor = RGB(90, 90, 90)
1826:             .Visible   = .T.
1827:         ENDWITH
1828: 
1829:         THIS.cnt_4c_ChequeFP.AddObject("txt_4c_Conta", "TextBox")
1830:         WITH THIS.cnt_4c_ChequeFP.txt_4c_Conta
1831:             *-- Espelho de xPar.contas (ver comentario de txt_4c_Bco)
1832:             .ControlSource = THIS.this_cCursorGrade + ".Contas"
1833:             .FontName  = "Tahoma"
1834:             .MaxLength = 10
1835:             .Left      = 85
1836:             .Top       = 13
1837:             .Width     = 80
1838:             .Height    = 23
1839:             .ForeColor = RGB(0, 0, 0)
1840:             .TabIndex  = 26
1841:             .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
1842:             .Visible   = .T.
1843:         ENDWITH
1844: 
1845:         THIS.cnt_4c_ChequeFP.AddObject("lbl_4c_LabelNumero", "Label")
1846:         WITH THIS.cnt_4c_ChequeFP.lbl_4c_LabelNumero
1847:             .FontName  = "Tahoma"
1848:             .FontSize  = 8
1849:             .AutoSize  = .F.
1850:             .Alignment = 0
1851:             .BackStyle = 0
1852:             .Caption   = "Numero"
1853:             .Left      = 166
1854:             .Top       = 1
1855:             .Width     = 52
1856:             .Height    = 15
1857:             .ForeColor = RGB(90, 90, 90)
1858:             .Visible   = .T.
1859:         ENDWITH
1860: 
1861:         THIS.cnt_4c_ChequeFP.AddObject("txt_4c_Num", "TextBox")
1862:         WITH THIS.cnt_4c_ChequeFP.txt_4c_Num
1863:             *-- Espelho de xPar.numeros (ver comentario de txt_4c_Bco)
1864:             .ControlSource = THIS.this_cCursorGrade + ".Numeros"
1865:             .FontName  = "Tahoma"
1866:             .MaxLength = 6
1867:             .Left      = 166
1868:             .Top       = 13
1869:             .Width     = 52
1870:             .Height    = 23
1871:             .ForeColor = RGB(0, 0, 0)
1872:             .TabIndex  = 27
1873:             .Enabled   = INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")

*-- Linhas 2329 a 2337:
2329:                         THIS.AtualizarEnabledCreditoFp()
2330: 
2331:                         *-- Bloco de cotacao/cambio do Valid legado (o que vinha
2332:                         *-- depois do `ThisForm.Get_PEncargo.Value = ...`):
2333:                         *--     =Seek( CrSigOpFp.Moefpgs, 'crSigCdMoe', 'CMoes' )
2334:                         *--     =Seek( Padr(Alltrim(Usuar),10), 'crUsuario', 'Usuarios' )
2335:                         *--     llCota = ((!Seek(Ccargs,'crSigCdCrg','Ccargs') Or
2336:                         *--                AltCots#'S') And Inlist(op_escolha,...)
2337:                         *--                And crSigCdMoe.Cotas)

*-- Linhas 2349 a 2360:
2349:                             INLIST(ALLTRIM(UPPER(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR") AND ;
2350:                             loc_lMoedaCotas
2351: 
2352:                         THIS.lbl_4c__Cotacao.Visible      = loc_lMoedaCotas
2353:                         THIS.txt_4c_COTACAO.Visible       = loc_lMoedaCotas
2354:                         THIS.txt_4c_COTACAO.Enabled       = loc_lCargoAltCots
2355:                         THIS.cmd_4c_Alteracotacao.Visible = loc_lCota
2356: 
2357:                         loc_nCotOper  = THIS.CarregarCambio(THIS.txt_4c_MoeOper.Value, ;
2358:                             THIS.this_oBusinessObject.this_dDtEnts)
2359:                         loc_nCotacao  = THIS.CarregarCambio(NVL(cursor_4c_FpgSel.moefpgs, ""), ;
2360:                             THIS.this_oBusinessObject.this_dDtEnts)

*-- Linhas 2412 a 2421:
2412:     * ConfigurarEventosBotoes (FASE 7/8) - Liga o Click dos cinco botoes do
2413:     * dialogo aos handlers desta fase. Chamado no fim de
2414:     * ConfigurarEstruturaBase, DEPOIS de ConfigurarBotoes (que cria Apaga/Ok/
2415:     * Cancela), de ConfigurarCampos (cmd_4c_Alteracotacao) e de
2416:     * ConfigurarPaineisFlutuantes (cmd_4c_Confirma, filho de cnt_4c_CCred):
2417:     * BINDEVENT exige o objeto JA criado.
2418:     *
2419:     * Equivalencia com o legado, um para um:
2420:     *   SIGOPFPG.Apaga.Click             -> CmdApagaClick
2421:     *   SIGOPFPG.Ok.Click                -> CmdOkClick

*-- Linhas 2428 a 2441:
2428:     * nao faz nada (regra #3).
2429:     *--------------------------------------------------------------------------
2430:     PROTECTED PROCEDURE ConfigurarEventosBotoes()
2431:         BINDEVENT(THIS.cmd_4c_Apaga,         "Click", THIS, "CmdApagaClick")
2432:         BINDEVENT(THIS.cmd_4c_Ok,            "Click", THIS, "CmdOkClick")
2433:         BINDEVENT(THIS.cmd_4c_Cancela,       "Click", THIS, "CmdCancelaClick")
2434:         BINDEVENT(THIS.cmd_4c_Alteracotacao, "Click", THIS, "CmdAlteraCotacaoClick")
2435: 
2436:         BINDEVENT(THIS.cnt_4c_CCred.cmd_4c_Confirma, "Click", THIS, ;
2437:                   "CmdConfirmaCartaoClick")
2438:     ENDPROC
2439: 
2440:     *--------------------------------------------------------------------------
2441:     * CmdApagaClick - SIGOPFPG.Apaga.Click do legado:

*-- Linhas 2735 a 2743:
2735:     *             .Get_Cotacao.Value = Val( MLine( lcRetorno, 2 ) )
2736:     *             .CotUsu = MLine( lcRetorno, 3 )
2737:     *         Else
2738:     *             .Get_Cotacao.Value = .Get_Cotacao.peantvalue
2739:     *             .CotUsu = ''
2740:     *         Endif
2741:     *         .Get_VPar.SetFocus
2742:     *     Endwith
2743:     *

*-- Linhas 2965 a 2973:
2965: 
2966:         *-- `ThisForm.GetObs.Visible = ( CrSigOpFp.Obs = 1 )` e o SayObs
2967:         THIS.obj_4c_GetObs.Visible = loc_lObs
2968:         THIS.lbl_4c_Obs.Visible    = loc_lObs
2969: 
2970:         *-- Cheque
2971:         THIS.cnt_4c_ChequeFP.Visible = (loc_cInfo == "C")
2972:         IF THIS.cnt_4c_ChequeFP.Visible
2973:             THIS.cnt_4c_ChequeFP.txt_4c_Bco.Refresh()

*-- Linhas 4179 a 4188:
4179:             THIS.txt_4c_VEncargo.Value         = 0
4180:             THIS.txt_4c_COTACAO.Value          = 0
4181:             THIS.txt_4c_COTACAO.Visible        = .F.
4182:             THIS.lbl_4c__Cotacao.Visible       = .F.
4183:             THIS.cmd_4c_Alteracotacao.Visible  = .F.
4184:             THIS.txt_4c_Porc.Value             = 0
4185: 
4186:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
4187:                 THIS.this_oBusinessObject.this_cFPags    = ""
4188:                 THIS.this_oBusinessObject.this_nNPar     = 0


### BO (C:\4c\projeto\app\classes\SigOpFpgBO.prg):
*==============================================================================
* SigOpFpgBO.prg
*
* Business Object para SigOpFpg (Forma de Pagamento)
* Dialogo filho chamado por formularios de movimento (ex.: Fluxo de Caixa /
* Baixa de Titulos) para distribuir o valor de um titulo/cheque em uma ou
* mais formas de pagamento (dinheiro, cartao, carne, cheque, outros).
*
* Nao possui tabela principal propria: a grade de formas de pagamento
* trabalha sobre o cursor local xPar (populado/consumido pelo form) e os
* dados sao devolvidos ao formulario pai, que grava no titulo/movimento
* de origem (SigChLcq e afins).
*
* FASE 1/8: Propriedades e Init. FASE 8/8: propriedades adicionais lidas
* pelo gerador de parcelas (this_cEmps/this_nEntradas/this_nDias/
* this_cTvens/this_cDcarts), populadas pelo FormSigOpFpg em
* AplicarFormaPagamento/DefinirDadosTitulo.
*==============================================================================

DEFINE CLASS SigOpFpgBO AS BusinessBase

    *-- Contexto recebido do formulario pai (Init do form legado:
    *-- Lparameters pForm, DatSes, llAltDireta)
    this_cOpEscolha     = ""    && op_escolha herdado do form pai (INSERIR/ALTERAR/CONSULTAR/EXCLUIR)
    this_lAltDireta     = .F.   && llAltDireta - fluxo de alteracao direta de forma de pagamento

    *-- Dados do titulo/movimento sendo pago (resolvidos a partir do cursor
    *-- do form pai - equivalente a CrSigChLcq no legado)
    this_dDtEnts        = {}    && datetime - data de entrada/movimentacao do titulo
    this_nValTots       = 0     && numeric  - valor total do titulo/cheque a pagar
    this_cEmps          = ""    && char     - empresa do titulo (SigChLcq.Emps), gravada em cada parcela

    *-- Linha corrente da grade de formas de pagamento (xPar), espelhando as
    *-- colunas usadas pelo legado: FPags, Valos, Vencs, Moedas, CotFpgs
    this_cFPags         = ""    && char     - codigo da forma de pagamento (SigCdOpFp.FPags)
    this_nValos         = 0     && numeric  - valor da parcela/linha
    this_dVencs         = {}    && date     - data de vencimento da parcela
    this_cMoedas        = ""    && char     - moeda da parcela
    this_nCotFpgs       = 0     && numeric  - cotacao aplicada na parcela

    *-- Totais e campos de cabecalho do dialogo
    this_cMoeOper       = ""    && char     - moeda de operacao (Get_MoeOper)
    this_nTotForma      = 0     && numeric  - total ja distribuido nas formas de pagamento
    this_nNPar          = 0     && numeric  - numero de parcelas
    this_nVPar          = 0     && numeric  - valor da parcela calculada
    this_nPEncargo      = 0     && numeric  - percentual de encargo financeiro
    this_nVEncargo      = 0     && numeric  - valor de encargo financeiro
    this_nCotacao       = 0     && numeric  - cotacao atual da moeda de operacao
    this_cCotUsu        = ""    && char     - indicador de cotacao alterada manualmente (SigOpAlC)
    this_nValTotChqs    = 0     && numeric  - valor total ja distribuido em cheques
    this_cObs           = ""    && memo     - observacao (forma "Outros")

    *-- Regras de vencimento/parcelamento da forma de pagamento escolhida
    *-- (SigOpFp.entradas/dias/tvens/dcarts), lidas em AplicarFormaPagamento e
    *-- consumidas pelo gerador de parcelas (fweditdata_venc.Valid do legado)
    this_nEntradas      = 0     && numeric - dias da data do titulo at? o 1o vencimento
    this_nDias          = 0     && numeric - intervalo entre parcelas (dias)
    this_cTvens         = ""    && char    - "F"=dias Fixos (GoMonth) / "C"=dias Corridos
    this_cDcarts        = ""    && char    - descricao do cartao, gravada em cada parcela

    *-- Painel Cartao de Credito (CntCCred / CntCCredFP)
    this_cCartao        = ""    && char     - numero do cartao de credito
    this_nCred          = 0     && numeric  - numero de parcelas do credito

    *-- Painel Carne (CntCarneFP)
    this_cCarne         = ""    && char     - codigo do carne

    *-- Painel Cheque (CntChequeFP)
    this_cBco           = ""    && char     - codigo do banco
    this_cAge           = ""    && char     - codigo da agencia
    this_cConta         = ""    && char     - numero da conta
    this_cNum           = ""    && char     - numero do cheque

    *-- Estado de controle (leitora serial de cheques / flags do legado)
    this_lLeitor        = .F.   && leitora serial de cheques habilitada
    this_cLeituraSerial = ""    && buffer com a leitura recebida da porta serial
    this_cTipoLeitora   = ""    && "S" = leitora serial configurada
    this_lDigpar        = .F.   && habilita digitacao manual de numero de parcelas
    this_lCarAuts       = .F.   && SigCdOpFp.CarAuts - cartao de credito sem validacao de digitos

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object. Sem tabela principal (dialogo
    * trabalha sobre cursor local do form pai).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel. Este dialogo nao tem tabela principal
    * (ver cabecalho da classe): a linha corrente da grade de formas de
    * pagamento chega por propriedade (this_cFPags/this_nValos/this_dVencs/
    * this_cMoedas/this_nCotFpgs), preenchida pelo proprio form a partir do
    * cursor local xPar - nao por SELECT (par_cAliasCursor).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel. Este dialogo nao grava em tabela do SQL
    * Server: a gravacao efetiva do titulo/movimento ocorre no formulario
    * pai (SigChLcq e afins), a partir do cursor xPar devolvido no Return.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel, pelo mesmo motivo de Inserir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel: sem tabela nem chave primaria
    * propria neste dialogo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Nao aplicavel: sem gravacao em tabela do SQL
    * Server neste dialogo, nao ha operacao para auditar aqui. O registro
    * de auditoria do titulo/movimento fica a cargo do formulario pai.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN
    ENDPROC

ENDDEFINE

