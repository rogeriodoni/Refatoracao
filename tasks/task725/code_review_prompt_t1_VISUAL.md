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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopdtf.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3699 linhas total):

*-- Linhas 253 a 261:
253:         LPARAMETERS par_cEndSiTef, par_nValPago, par_cCupom, par_cCaixa, ;
254:                     par_cDebCred, par_cTipPagto, par_nNumParcs, par_cIdent, par_cOpers
255: 
256:         THIS.Caption = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
257: 
258:         THIS.this_cEndSiTef = IIF(VARTYPE(par_cEndSiTef) = "C", par_cEndSiTef, "")
259:         THIS.this_nValPago  = IIF(VARTYPE(par_nValPago) = "N", par_nValPago, 0)
260:         THIS.this_cCupom    = IIF(VARTYPE(par_cCupom) $ "NC", TRANSFORM(par_cCupom, "@L 999999"), "000000")
261:         THIS.this_cCaixa    = IIF(VARTYPE(par_cCaixa) = "C", par_cCaixa, "")

*-- Linhas 395 a 562:
395:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
396:         loc_oCab = THIS.cnt_4c_Cabecalho
397:         WITH loc_oCab
398:             .Top         = 0
399:             .Left        = 0
400:             .Width       = THIS.Width
401:             .Height      = 80
402:             .BackColor   = RGB(100,100,100)
403:             .BackStyle   = 1
404:             .BorderWidth = 0
405:         ENDWITH
406: 
407:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
408:         WITH loc_oCab.lbl_4c_Sombra
409:             .AutoSize      = .F.
410:             .Width         = loc_oCab.Width - 10
411:             .Height        = 40
412:             .Top           = 18
413:             .Left          = 10
414:             .FontName      = "Tahoma"
415:             .FontSize      = 18
416:             .FontBold      = .T.
417:             .FontUnderline = .F.
418:             .Alignment     = 0
419:             .BackStyle     = 0
420:             .WordWrap      = .T.
421:             .ForeColor     = RGB(0,0,0)
422:             .Caption       = THIS.Caption
423:         ENDWITH
424: 
425:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
426:         WITH loc_oCab.lbl_4c_Titulo
427:             .AutoSize      = .F.
428:             .Width         = loc_oCab.Width - 10
429:             .Height        = 46
430:             .Top           = 17
431:             .Left          = 10
432:             .FontName      = "Tahoma"
433:             .FontSize      = 18
434:             .FontBold      = .T.
435:             .Alignment     = 0
436:             .BackStyle     = 0
437:             .WordWrap      = .T.
438:             .ForeColor     = RGB(255,255,255)
439:             .Caption       = THIS.Caption
440:             *-- SCX legado: lblTitulo.ToolTipText = "Titulo do Relatorio"
441:             .ToolTipText   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
442:         ENDWITH
443:     ENDPROC
444: 
445:     *--------------------------------------------------------------------------
446:     * ConfigurarCampos - cria os campos de captura direto no Form (sem
447:     * PageFrame - controles filhos de THIS, Top/Left transcritos EXATOS do
448:     * dump SIGOPDTF, sem compensacao +29 porque nao ha PageFrame.Top=-29
449:     * aqui). Migrado de: SIGOPDTF.Shape2/Label5/GetValor/Label2/GetDigitos/
450:     * Label8/Container1(.Label1)/GetCartao/Label11/Label4/Optiongroup1/
451:     * Label6/Text1/GetDatas/GetCodSeg/Label12/Label1("0 - Inexistente")/
452:     * Label3("1 - Ilegivel").
453:     *--------------------------------------------------------------------------
454:     PROTECTED PROCEDURE ConfigurarCampos()
455:         LOCAL loc_oCnt
456: 
457:         *-- Shape2 - moldura decorativa ao redor dos campos
458:         THIS.AddObject("shp_4c_Shape2", "Shape")
459:         WITH THIS.shp_4c_Shape2
460:             .Top           = 92
461:             .Left          = 0
462:             .Width         = 466
463:             .Height        = 202
464:             .BackStyle     = 1
465:             .BorderStyle   = 1
466:             .SpecialEffect = 0
467:         ENDWITH
468: 
469:         *-- Label5 "VALOR :" + txt_4c_Valor (GetValor)
470:         THIS.AddObject("lbl_4c_Label5", "Label")
471:         WITH THIS.lbl_4c_Label5
472:             .AutoSize  = .F.
473:             .Alignment = 0
474:             .Top       = 101
475:             .Left      = 138
476:             .Width     = 45
477:             .Height    = 15
478:             .FontName  = "Tahoma"
479:             .FontSize  = 8
480:             .FontBold  = .T.
481:             .ForeColor = RGB(90,90,90)
482:             .BackStyle = 0
483:             .Caption   = "VALOR :"
484:         ENDWITH
485: 
486:         *-- SCX nao sobrescreve Enabled aqui (nasce .T.) - o campo e protegido
487:         *-- de digitacao pelo GetValor.When = "Return .f." (bloqueia foco),
488:         *-- nao por Enabled=.F. (fases de evento, 6-8).
489:         THIS.AddObject("txt_4c_Valor", "TextBox")
490:         WITH THIS.txt_4c_Valor
491:             .Top               = 98
492:             .Left              = 185
493:             .Width             = 100
494:             .Height            = 23
495:             .Alignment         = 3
496:             .Value             = 0
497:             .InputMask         = "99,999,999.99"
498:             .FontName          = "Tahoma"
499:             .FontSize          = 8
500:             .FontBold          = .T.
501:             .DisabledForeColor = RGB(0,0,0)
502:         ENDWITH
503: 
504:         *-- Label2 "4 ULTIMOS DIGITOS :" + txt_4c_Digitos (GetDigitos)
505:         THIS.AddObject("lbl_4c_Label2", "Label")
506:         WITH THIS.lbl_4c_Label2
507:             .AutoSize  = .F.
508:             .Alignment = 0
509:             .Top       = 170
510:             .Left      = 64
511:             .Width     = 119
512:             .Height    = 17
513:             .FontName  = "Tahoma"
514:             .FontSize  = 8
515:             .FontBold  = .T.
516:             .ForeColor = RGB(90,90,90)
517:             .BackStyle = 0
518:             .Caption   = "4 ULTIMOS DIGITOS :"
519:         ENDWITH
520: 
521:         THIS.AddObject("txt_4c_Digitos", "TextBox")
522:         WITH THIS.txt_4c_Digitos
523:             .Top       = 167
524:             .Left      = 185
525:             .Width     = 40
526:             .Height    = 23
527:             .Value     = ""
528:             .InputMask = "9999"
529:             .Enabled   = .T.
530:             .FontName  = "Tahoma"
531:             .FontSize  = 8
532:             .FontBold  = .T.
533:             .BackColor = RGB(212,208,200)
534:         ENDWITH
535: 
536:         *-- Label8 "NUMERO CARTAO :" + txt_4c_Cartao (GetCartao)
537:         THIS.AddObject("lbl_4c_Label8", "Label")
538:         WITH THIS.lbl_4c_Label8
539:             .AutoSize    = .F.
540:             .Alignment   = 0
541:             .BorderStyle = 0
542:             .Top         = 135
543:             .Left        = 79
544:             .Width       = 104
545:             .Height      = 15
546:             .FontName    = "Tahoma"
547:             .FontSize    = 8
548:             .FontBold    = .T.
549:             .ForeColor   = RGB(90,90,90)
550:             .BackStyle   = 0
551:             .Caption     = "NUMERO CARTAO :"
552:         ENDWITH
553: 
554:         THIS.AddObject("txt_4c_Cartao", "TextBox")
555:         WITH THIS.txt_4c_Cartao
556:             .Top               = 132
557:             .Left              = 185
558:             .Width             = 160
559:             .Height            = 23
560:             .Alignment         = 3
561:             .Value             = ""
562:             .InputMask         = "9999999999999999999"

*-- Linhas 572 a 738:
572:         THIS.AddObject("cnt_4c_Container1", "Container")
573:         loc_oCnt = THIS.cnt_4c_Container1
574:         WITH loc_oCnt
575:             .Top           = 302
576:             .Left          = 37
577:             .Width         = 392
578:             .Height        = 58
579:             .SpecialEffect = 0
580:         ENDWITH
581: 
582:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
583:         WITH loc_oCnt.lbl_4c_Label1
584:             .AutoSize  = .F.
585:             .Alignment = 2
586:             .Top       = 13
587:             .Left      = 21
588:             .Width     = 349
589:             .Height    = 26
590:             .FontName  = "Tahoma"
591:             .FontSize  = 18
592:             .FontBold  = .T.
593:             .ForeColor = RGB(90,90,90)
594:             .BackStyle = 0
595:             .Caption   = "Insira ou Passe o Cartao"
596:         ENDWITH
597: 
598:         *-- Label11 "1a PARCELA/VENCTO :" + txt_4c_Datas (GetDatas)
599:         THIS.AddObject("lbl_4c_Label11", "Label")
600:         WITH THIS.lbl_4c_Label11
601:             .AutoSize  = .F.
602:             .Alignment = 0
603:             .Top       = 267
604:             .Left      = 61
605:             .Width     = 122
606:             .Height    = 15
607:             .FontName  = "Tahoma"
608:             .FontSize  = 8
609:             .FontBold  = .T.
610:             .ForeColor = RGB(90,90,90)
611:             .BackStyle = 0
612:             .Caption   = "1" + CHR(170) + " PARCELA/VENCTO :"
613:         ENDWITH
614: 
615:         THIS.AddObject("txt_4c_Datas", "TextBox")
616:         WITH THIS.txt_4c_Datas
617:             .Top               = 265
618:             .Left              = 185
619:             .Width             = 75
620:             .Height            = 23
621:             .Alignment         = 3
622:             .Value             = {}
623:             .Enabled           = .F.
624:             .FontName          = "Tahoma"
625:             .FontSize          = 8
626:             .FontBold          = .T.
627:             .DisabledForeColor = RGB(0,0,0)
628:         ENDWITH
629: 
630:         *-- Label4 "TIPO DE VENDA :" + obj_4c_Optiongroup1
631:         THIS.AddObject("lbl_4c_Label4", "Label")
632:         WITH THIS.lbl_4c_Label4
633:             .AutoSize  = .F.
634:             .Alignment = 0
635:             .Top       = 203
636:             .Left      = 92
637:             .Width     = 91
638:             .Height    = 15
639:             .FontName  = "Tahoma"
640:             .FontSize  = 8
641:             .FontBold  = .T.
642:             .ForeColor = RGB(90,90,90)
643:             .BackStyle = 0
644:             .Caption   = "TIPO DE VENDA :"
645:         ENDWITH
646: 
647:         THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
648:         WITH THIS.obj_4c_Optiongroup1
649:             .ButtonCount = 2
650:             .Top         = 199
651:             .Left        = 185
652:             .Width       = 161
653:             .Height      = 26
654:             .Enabled     = .T.
655:             .Value       = 1
656: 
657:             WITH .Buttons(1)
658:                 .Caption  = " A vista"
659:                 .Top      = 4
660:                 .Left     = 5
661:                 .Width    = 61
662:                 .Height   = 17
663:                 .FontName = "Tahoma"
664:                 .FontSize = 8
665:                 .FontBold = .T.
666:             ENDWITH
667: 
668:             WITH .Buttons(2)
669:                 .Caption  = " Predatado"
670:                 .Top      = 5
671:                 .Left     = 73
672:                 .Width    = 80
673:                 .Height   = 17
674:                 .FontName = "Tahoma"
675:                 .FontSize = 8
676:                 .FontBold = .T.
677:             ENDWITH
678:         ENDWITH
679: 
680:         *-- Label6 "No PARCELAS :" + txt_4c_Text1 (Text1)
681:         THIS.AddObject("lbl_4c_Label6", "Label")
682:         WITH THIS.lbl_4c_Label6
683:             .AutoSize  = .F.
684:             .Alignment = 0
685:             .Top       = 237
686:             .Left      = 102
687:             .Width     = 81
688:             .Height    = 15
689:             .FontName  = "Tahoma"
690:             .FontSize  = 8
691:             .FontBold  = .T.
692:             .ForeColor = RGB(90,90,90)
693:             .BackStyle = 0
694:             .Caption   = "N" + CHR(186) + " PARCELAS :"
695:         ENDWITH
696: 
697:         THIS.AddObject("txt_4c_Text1", "TextBox")
698:         WITH THIS.txt_4c_Text1
699:             .Top               = 233
700:             .Left              = 185
701:             .Width             = 27
702:             .Height            = 23
703:             .Value             = ""
704:             .InputMask         = "99"
705:             .Enabled           = .F.
706:             .FontName          = "Tahoma"
707:             .FontSize          = 8
708:             .FontBold          = .T.
709:             .DisabledForeColor = RGB(0,0,0)
710:         ENDWITH
711: 
712:         *-- Label12 "COD. SEG. :" + txt_4c_Codigo (GetCodSeg)
713:         THIS.AddObject("lbl_4c_Label12", "Label")
714:         WITH THIS.lbl_4c_Label12
715:             .AutoSize   = .F.
716:             .Alignment  = 0
717:             .FontItalic = .F.
718:             .Top        = 169
719:             .Left       = 237
720:             .Width      = 62
721:             .Height     = 17
722:             .FontName   = "Tahoma"
723:             .FontSize   = 8
724:             .FontBold   = .T.
725:             .ForeColor  = RGB(90,90,90)
726:             .BackStyle  = 0
727:             .Caption    = "COD. SEG. :"
728:         ENDWITH
729: 
730:         THIS.AddObject("txt_4c_Codigo", "TextBox")
731:         WITH THIS.txt_4c_Codigo
732:             .Top               = 165
733:             .Left              = 302
734:             .Width             = 52
735:             .Height            = 23
736:             .Value             = ""
737:             .InputMask         = "99999"
738:             .Enabled           = .F.

*-- Linhas 746 a 785:
746:         *-- Legenda fixa do codigo de seguranca (SIGOPDTF.Label1/Label3 -
747:         *-- "0 - Inexistente" / "1 - Ilegivel", filhos DIRETOS do form, NAO do
748:         *-- Container1 - mesmo nome de objeto, parent diferente, sem colisao)
749:         THIS.AddObject("lbl_4c_Label1", "Label")
750:         WITH THIS.lbl_4c_Label1
751:             .AutoSize   = .F.
752:             .Alignment  = 0
753:             .FontItalic = .F.
754:             .Top        = 162
755:             .Left       = 357
756:             .Width      = 86
757:             .Height     = 15
758:             .FontName   = "Tahoma"
759:             .FontSize   = 8
760:             .FontBold   = .T.
761:             .ForeColor  = RGB(90,90,90)
762:             .BackStyle  = 0
763:             .Caption    = "0 - Inexistente"
764:         ENDWITH
765: 
766:         THIS.AddObject("lbl_4c_Label3", "Label")
767:         WITH THIS.lbl_4c_Label3
768:             .AutoSize   = .F.
769:             .Alignment  = 0
770:             .FontItalic = .F.
771:             .Top        = 178
772:             .Left       = 356
773:             .Width      = 62
774:             .Height     = 15
775:             .FontName   = "Tahoma"
776:             .FontSize   = 8
777:             .FontBold   = .T.
778:             .ForeColor  = RGB(90,90,90)
779:             .BackStyle  = 0
780:             .Caption    = "1 - Ilegivel"
781:         ENDWITH
782:     ENDPROC
783: 
784:     *--------------------------------------------------------------------------
785:     * ConfigurarBotaoSaida - CommandGroup obj_4c_SAIDA com o botao Cancelar

*-- Linhas 792 a 821:
792:         THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
793:         WITH THIS.obj_4c_SAIDA
794:             .ButtonCount = 1
795:             .Top         = -2
796:             .Left        = 387
797:             .Width       = 85
798:             .Height      = 85
799:             .BorderStyle = 0
800:             *-- SCX legado: SAIDA.BackStyle = 0 (transparente). CommandGroup TEM
801:             *-- BackStyle - sem esta linha o grupo nasce opaco (default 1) e
802:             *-- pinta um retangulo branco sobre a faixa cinza do cabecalho.
803:             .BackStyle   = 0
804:             .Value       = 0
805: 
806:             WITH .Buttons(1)
807:                 .Top        = 5
808:                 .Left       = 5
809:                 .Width      = 75
810:                 .Height     = 75
811:                 .FontName   = "Comic Sans MS"
812:                 .FontSize   = 8
813:                 .FontBold   = .T.
814:                 .FontItalic = .T.
815:                 .Cancel     = .F.
816:                 .Caption    = "\<Cancelar"
817:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
818:                 .ForeColor  = RGB(90,90,90)
819:                 .BackColor  = RGB(255,255,255)
820:                 .Themes     = .F.
821:             ENDWITH

*-- Linhas 851 a 867:
851:     *         .GetValor.Value = lnValPago
852:     *         IF crSigOpFp.lCartao = "S"
853:     *             .GetCartao.Enabled = .t.
854:     *             .Label2.Caption    = "Validade Cartao :"
855:     *         EndIf
856:     *     Endwith
857:     *     ThisForm.Container1.Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
858:     *     IF !Thisform.getDatas.Enabled
859:     *         IF crSigOpFp.lCartao = "N"
860:     *             ...Caption = "Insira ou Passe"  + CHR(13) + "o Cartao"
861:     *         ELSE
862:     *             ...Caption = "Digite o Numero"  + CHR(13) + "do Cartao"
863:     *         EndIf
864:     *     EndIf
865:     *     ThisForm.Text1.Value = TRANSFORM(lnNumParcs, "@L 99")
866:     *     ThisForm.GetValor.SetFocus
867:     *

*-- Linhas 921 a 941:
921: 
922:         IF loc_lCartao
923:             THIS.txt_4c_Cartao.Enabled = .T.
924:             THIS.lbl_4c_Label2.Caption = "Validade Cartao :"
925:         ENDIF
926: 
927:         *-- O legado atribui a legenda, depois a REATRIBUI dentro do
928:         *-- "IF !getDatas.Enabled". Como o SCX declara GetDatas.Enabled = .F.
929:         *-- (e a Fase 4 transcreveu), esse IF eh SEMPRE verdadeiro na abertura
930:         *-- e quem decide eh o ramo interno - transcrito nessa ordem.
931:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
932:         IF !THIS.txt_4c_Datas.Enabled
933:             IF !loc_lCartao
934:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
935:             ELSE
936:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Numero" + CHR(13) + "do Cartao"
937:             ENDIF
938:         ENDIF
939: 
940:         *-- lnParcs do legado (mascara "@L 99"), espelhado no campo e na
941:         *-- property que alimenta o retorno da tela.

*-- Linhas 1549 a 1557:
1549:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
1550: 
1551:             IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf))
1552:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1553:             ENDIF
1554: 
1555:             IF loc_nRetorno = 0
1556:                 EXIT
1557:             ENDIF

*-- Linhas 1575 a 1583:
1575:                     IF loc_lParcelas
1576:                         THIS.txt_4c_Text1.Enabled        = .T.
1577:                         THIS.obj_4c_Optiongroup1.Enabled = .F.
1578:                         *-- Legado: "This.Value=.f." - atribuir LOGICO a um
1579:                         *-- TextBox cujo Value eh CARACTERE (.Value = "" na
1580:                         *-- criacao) troca o tipo do controle e faz o
1581:                         *-- ALLTRIM seguinte estourar. Limpa com "" , que eh o
1582:                         *-- efeito pretendido (apagar os digitos digitados).
1583:                         THIS.txt_4c_Digitos.Value = ""

*-- Linhas 1604 a 1612:
1604:             ENDIF
1605: 
1606:             IF loc_oBO.this_nProximoComando = 23
1607:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1608:             ENDIF
1609: 
1610:             IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 510
1611:                 IF loc_oBO.this_lOpFpGarantias
1612:                     loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)

*-- Linhas 1651 a 1659:
1651:             ENDIF
1652: 
1653:             IF UPPER(ALLTRIM(loc_cBuf)) = "DIGITE A SENHA"
1654:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1655:             ENDIF
1656: 
1657:             IF loc_oBO.this_nProximoComando = 3
1658:                 loc_oBO.this_cMensagemRetorno = ALLTRIM(loc_cBuf)
1659:             ENDIF

*-- Linhas 1734 a 1745:
1734:         ENDIF
1735: 
1736:         IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 514
1737:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Codigo" + CHR(13) + "de Seguranca"
1738:         ELSE
1739:             IF THIS.this_cDebCred != "P" AND !loc_oBO.this_lDataConfirmada
1740:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
1741:                 THIS.obj_4c_Optiongroup1.Enabled = .T.
1742:                 THIS.txt_4c_Datas.Enabled        = .T.
1743:             ELSE
1744:                 THIS.obj_4c_Optiongroup1.Enabled = .F.
1745:             ENDIF

*-- Linhas 1847 a 1855:
1847:             ENDIF
1848: 
1849:             IF UPPER(ALLTRIM(loc_cBuf)) = "DIGITE A SENHA"
1850:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1851:             ENDIF
1852: 
1853:             IF loc_nRetorno = 0
1854:                 EXIT
1855:             ENDIF

*-- Linhas 2017 a 2025:
2017:             ENDIF
2018:         ENDDO
2019: 
2020:         THIS.cnt_4c_Container1.lbl_4c_Label1.Visible = .T.
2021: 
2022:         IF loc_nRetorno < 0 OR THIS.this_lAbandona
2023:             THIS.EncerrarDialogo()
2024:             RETURN
2025:         ENDIF

*-- Linhas 2046 a 2067:
2046: 
2047:         IF loc_lTipoVenda
2048:             IF !THIS.txt_4c_Text1.Enabled
2049:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Informe o Tipo" + CHR(13) + "da Venda"
2050:                 THIS.txt_4c_Digitos.Enabled      = .F.
2051:                 THIS.obj_4c_Optiongroup1.Enabled = .T.
2052:                 THIS.txt_4c_Datas.Enabled        = .T.
2053:                 *-- O legado faz "Optiongroup1.Option1.SetFocus". Em VFP9 o
2054:                 *-- foco de OptionGroup vai no grupo (ele mesmo roteia para o
2055:                 *-- botao marcado) e SetFocus num Buttons(N) de grupo recem
2056:                 *-- habilitado falha quando o form ainda nao esta visivel.
2057:                 IF THIS.obj_4c_Optiongroup1.Visible AND THIS.obj_4c_Optiongroup1.Enabled
2058:                     THIS.obj_4c_Optiongroup1.SetFocus()
2059:                 ENDIF
2060:             ENDIF
2061:         ELSE
2062:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite os 4 Ultimos" + CHR(13) + "Digitos do Cartao"
2063:             THIS.obj_4c_Optiongroup1.Enabled = .T.
2064:         ENDIF
2065: 
2066:         THIS.obj_4c_SAIDA.Enabled = .T.
2067:     ENDPROC

*-- Linhas 2252 a 2260:
2252:         THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
2253: 
2254:         IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf)) OR loc_oBO.this_nProximoComando = 23
2255:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
2256:         ENDIF
2257: 
2258:         IF loc_oBO.this_nProximoComando = 22
2259:             THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
2260:                 ALLTRIM(SUBSTR(loc_cBuf, 1, 32)), ALLTRIM(SUBSTR(loc_cBuf, 33, 32)))

*-- Linhas 2415 a 2423:
2415:         loc_oBO.this_cFinaliza        = ""
2416:         loc_oBO.this_cMensagemRetorno = ""
2417: 
2418:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
2419: 
2420:         *-- Condicao de entrada do legado - fora dela, so a legenda acima.
2421:         IF !(THIS.this_cDebCred != "P" AND !loc_oBO.this_lDataConfirmada AND ;
2422:              loc_oBO.this_cOpFpTcdc != "S")
2423:             RETURN

*-- Linhas 2441 a 2449:
2441:                 ENDIF
2442: 
2443:                 IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf)) OR loc_oBO.this_nProximoComando = 23
2444:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
2445:                 ENDIF
2446: 
2447:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
2448: 
2449:                 IF loc_nRetorno < 0

*-- Linhas 2481 a 2489:
2481:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
2482: 
2483:             IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf))
2484:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
2485:             ENDIF
2486: 
2487:             IF loc_nRetorno < 0
2488:                 THIS.ErroTef(loc_nRetorno)
2489:                 THIS.EncerrarDialogo()

*-- Linhas 2576 a 2584:
2576:             *-- Com buffer vazio isso eh sempre verdadeiro. Transcrito como
2577:             *-- esta: trocar a ordem mudaria quando a legenda aparece.
2578:             IF UPPER(ALLTRIM(loc_oBO.this_cBuffer)) $ "DIGITE A SENHA"
2579:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
2580:             ENDIF
2581: 
2582:             IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
2583:                 THIS.ObterValorSaque()
2584:                 loc_oBO.this_cBuffer = loc_oBO.this_cValorSaque + ;

*-- Linhas 2649 a 2657:
2649:             ENDIF
2650:         ENDIF
2651: 
2652:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
2653:     ENDPROC
2654: 
2655:     *--------------------------------------------------------------------------
2656:     * DatasKeyPress - migrado de SIGOPDTF.GetDatas.Valid, o laco que FECHA a
2657:     * transacao: envia a data de vencimento e, aprovada a venda, grava o

*-- Linhas 2711 a 2719:
2711:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
2712: 
2713:             IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf)) OR loc_oBO.this_nProximoComando = 23
2714:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
2715:             ENDIF
2716: 
2717:             IF loc_nRetorno < 0
2718:                 THIS.ErroTef(loc_nRetorno)
2719:                 THIS.EncerrarDialogo()

*-- Linhas 2751 a 2759:
2751:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
2752: 
2753:             IF "SENHA" $ UPPER(ALLTRIM(loc_cBuf)) OR loc_oBO.this_nProximoComando = 23
2754:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
2755:             ENDIF
2756: 
2757:             IF loc_nRetorno < 0
2758:                 THIS.ErroTef(loc_nRetorno)
2759:                 THIS.EncerrarDialogo()

*-- Linhas 2792 a 2800:
2792:             ENDIF
2793: 
2794:             IF loc_oBO.this_nProximoComando = 23
2795:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
2796:             ENDIF
2797: 
2798:             IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 500
2799:                 loc_cSenha = THIS.ObterSenhaSupervisor()
2800:                 IF EMPTY(loc_cSenha)

*-- Linhas 2926 a 2944:
2926: 
2927:     *--------------------------------------------------------------------------
2928:     * CodSegGotFocus - migrado de SIGOPDTF.GetCodSeg.GotFocus
2929:     * ("Container1.Label1.Caption = 'Digite o Codigo' + CHR(13) + 'de Seguranca'")
2930:     * mais o SET CONFIRM OFF do GetCodSeg.When, que BINDEVENT nao alcanca e que
2931:     * no legado eh condicionado a campo vazio.
2932:     * PUBLIC: alvo de BINDEVENT.
2933:     *--------------------------------------------------------------------------
2934:     PROCEDURE CodSegGotFocus()
2935:         IF EMPTY(ALLTRIM(THIS.txt_4c_Codigo.Value))
2936:             SET CONFIRM OFF
2937:         ENDIF
2938: 
2939:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Codigo" + CHR(13) + "de Seguranca"
2940:     ENDPROC
2941: 
2942:     *--------------------------------------------------------------------------
2943:     * CodSegLostFocus - migrado de SIGOPDTF.GetCodSeg.LostFocus: envia o
2944:     * codigo de seguranca (CSEG) ao terminal e conduz o parcelamento.

*-- Linhas 3070 a 3078:
3070:             *-- CONTIDO no literal (ver nota igual em DatasGotFocusExec).
3071:             IF UPPER(ALLTRIM(loc_oBO.this_cBuffer)) $ "DIGITE A SENHA" OR ;
3072:                loc_oBO.this_nProximoComando = 23
3073:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
3074:             ENDIF
3075: 
3076:             loc_cBuf = loc_oBO.this_cBuffer
3077: 
3078:             IF loc_oBO.this_nProximoComando = 3

*-- Linhas 3139 a 3152:
3139:         *-- Rearranjo final dos campos, transcrito na ordem do legado: a
3140:         *-- primeira legenda eh SOBREPOSTA pelo ramo de baixo quando a venda
3141:         *-- nao eh a prazo - esta assim no original.
3142:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Resp." + CHR(13) + "Parcelamento"
3143:         THIS.txt_4c_Digitos.Enabled = .F.
3144:         THIS.txt_4c_Text1.Enabled   = .T.
3145: 
3146:         IF THIS.this_cDebCred != "P" AND !loc_oBO.this_lDataConfirmada
3147:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
3148:             THIS.obj_4c_Optiongroup1.Enabled = .T.
3149:             THIS.txt_4c_Datas.Enabled        = .T.
3150:             THIS.txt_4c_Text1.Enabled        = .F.
3151:         ELSE
3152:             THIS.obj_4c_Optiongroup1.Enabled = .F.


### BO (C:\4c\projeto\app\classes\sigopdtfBO.prg):
*============================================================================
* sigopdtfBO.prg - Business Object para Transacao TEF (Terminal de Pagamento)
*
* Nao possui tabela principal propria - encapsula a interacao com a DLL
* CliSiTef32I.DLL (SiTef Interativo) e as consultas de apoio a
* SigCdEmp (empresa) e SigFiMpF (configuracao do caixa/terminal).
* O unico dado persistido pelo fluxo original e um cursor local
* temporario (crSiTef), usado como buffer de protocolo - nao uma
* tabela de negocio.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS sigopdtfBO AS BusinessBase

    *==========================================================================
    * Propriedades de entrada - recebidas do form/chamador (parametros da
    * transacao original: EndSiTef, ValPago, Cupom, Caixa, DebCred,
    * TipPagto, NumParcs, lcIdent, pcOpers)
    *==========================================================================
    this_cEndSiTef = ""    && Endereco do servidor SiTef
    this_nValPago  = 0     && Valor a ser pago na transacao
    this_cCupom    = ""    && Numero do cupom fiscal associado
    this_cCaixa    = ""    && Codigo do caixa (PDV) que originou a venda
    this_lDebCred  = .F.   && .T. = Debito / .F. = Credito
    this_cTipPagto = ""    && Tipo de pagamento informado pelo caixa
    this_nNumParcs = 0     && Numero de parcelas solicitado pelo caixa
    this_cIdent    = ""    && Identificador da transacao (lcIdent)
    this_cOpers    = ""    && Operador responsavel pelo caixa

    *==========================================================================
    * Propriedades de identificacao do terminal - lidas via SQL em
    * SigCdEmp.nEmps e SigFiMpF.Cncaixas (usadas para montar o
    * identificador do terminal exigido pela DLL do SiTef)
    *==========================================================================
    this_nEmpresa     = 0   && SigCdEmp.nEmps da empresa corrente
    this_cCaixaConfig = ""  && SigFiMpF.Cncaixas (numero do caixa configurado)
    this_cIdTerminal  = ""  && Identificador do terminal montado (empresa+caixa)

    *==========================================================================
    * Propriedades de estado/retorno da transacao TEF - preenchidas ao
    * longo do dialogo com a DLL e devolvidas ao chamador ao final
    *==========================================================================
    this_cTipTran        = ""   && Tipo da transacao retornado pelo SiTef
    this_cDataHora       = ""   && Data/hora da transacao retornada pelo SiTef
    this_cCupomRetorno    = ""   && Cupom confirmado pela transacao
    this_cCartao          = ""   && Numero do cartao (mascarado) utilizado
    this_cBandeira        = ""   && Bandeira do cartao identificada
    this_cNsu             = ""   && NSU (Numero Sequencial Unico) da transacao
    this_cAutoriza        = ""   && Codigo de autorizacao retornado
    this_cFinaliza        = ""   && Codigo de finalizacao da transacao
    this_cCodSeg          = ""   && Codigo de seguranca (CSEG) informado
    this_cDigitos         = ""   && Ultimos digitos do cartao informados
    this_cMensagemRetorno = ""   && Mensagem de retorno/erro da DLL SiTef

    *==========================================================================
    * Propriedades de parcelamento/data - espelham Optiongroup1/GetDatas
    * do formulario original (tipo de venda e 1a parcela/vencimento)
    *==========================================================================
    this_nTipoVenda   = 0    && 1 = A Vista / 2 = A Prazo (Optiongroup1.Value)
    this_dDataVencto  = {}   && Data da 1a parcela/vencimento
    this_lParcelado   = .F.  && .T. quando a venda foi parcelada
    this_nParcelas    = 0    && Numero de parcelas efetivamente confirmado

    *==========================================================================
    * Propriedade de controle de cancelamento (pcKeyEsc/Abandona do legado)
    *==========================================================================
    this_lCancelado = .F.   && .T. quando o usuario cancelou a operacao

    *==========================================================================
    * Configuracao da FORMA DE PAGAMENTO (FASE 8/8) - migrado do cursor global
    * crSigOpFp que o SIGOPDTF.Init popula com
    *     .poDatamgr.SqlExecute([Select * From SigOpFp Where FPags = ?lcOpers], 'crSigOpFp')
    * e que TODOS os lacos do protocolo consultam (GetDigitos.Valid/GotFocus,
    * GetDatas.Valid/GotFocus, GetCodSeg.LostFocus). Sem estes valores o
    * protocolo responde ao terminal com o ramo ERRADO em cada pergunta -
    * sem erro na tela, gravando transacao divergente.
    *
    * Tipos conferidos em docs/schema.sql (UTF-16, lido com Get-Content -Raw -
    * regra #14): lcartao/lsaque/tcdc/garantias sao char(1) ("S"/"N"),
    * dias eh numeric(3,0), mesfec eh numeric(1,0), chkbins eh numeric(1,0)
    * e codestabs eh char(8). chkbins eh NUMERIC (nao bit), por isso eh
    * comparado com 1 e nao com .T. (regra #13).
    *==========================================================================
    this_lOpFpCartao     = .F.     && SigOpFp.lcartao   = "S" - forma aceita cartao
    this_lOpFpSaque      = .F.     && SigOpFp.lsaque    = "S" - permite saque
    this_cOpFpTcdc       = "N"     && SigOpFp.tcdc      - indica consulta CDC
    this_lOpFpGarantias  = .F.     && SigOpFp.garantias = "S"
    this_nOpFpDias       = 0       && SigOpFp.dias
    this_nOpFpMesFec     = 0       && SigOpFp.mesfec
    this_nOpFpChkBins    = 0       && SigOpFp.chkbins   - 1 = validar BIN do cartao
    this_cOpFpCodEstabs  = ""      && SigOpFp.codestabs - "lsLoja" do ConfiguraIntSiTefInterativo

    *==========================================================================
    * Estado intermediario do protocolo que o legado guardava em variaveis
    * PUBLIC / properties soltas do Form (FASE 8/8)
    *==========================================================================
    this_lDataConfirmada = .F.      && DCD do legado - .T. apos o terminal confirmar a data
    this_cCartaoAux      = ""       && ThisForm.lsCartao - Left(Buffer, 5) em TipoCampo = 131
    this_cValorSaque     = "0,00"   && lcSaque - valor de saque (sub-dialogo SigCsTef nao portado)

    *==========================================================================
    * Estado do protocolo interativo (migrado das variaveis PUBLIC do legado:
    * ProximoComando, TipoCampo, TamanhoMinimo, TamanhoMaximo, Buffer,
    * lnContinua). Centralizado aqui porque ContinuarSiTef() precisa passar
    * os quatro primeiros POR REFERENCIA para a DLL, e VFP9 nao garante
    * passagem por referencia de property de objeto direto para DLL externa
    * (mesmo criterio de SigOpCtfBO.ContinuarSiTef/sigprdftBO.ContinuarSiTef).
    *==========================================================================
    this_nProximoComando = 0
    this_nTipoCampo      = 0
    this_nTamanhoMinimo  = 0
    this_nTamanhoMaximo  = 0
    this_cBuffer         = SPACE(2000)
    this_nContinua       = 0

    *==========================================================================
    * Init - Inicializa o Business Object
    * sigopdtf nao possui tabela de negocio propria (dialogo de integracao
    * com a DLL do SiTef) - this_cTabela/this_cCampoChave permanecem vazios
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            THIS.DeclararFuncoesSiTef()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DeclararFuncoesSiTef - DECLARE-DLL das funcoes do protocolo interativo,
    * migrado de SIGOPDTF.Load.
    *
    * CORRIGIDO NA FASE 8/8: eram 3 declaracoes e sao QUATRO. O comentario
    * original afirmava que "este form, ao contrario de SIGPRDFT, NAO declara
    * FinalizaTransacaoSiTefInterativo" - e isso esta errado: a 4a linha do
    * SIGOPDTF.Load eh
    *     DECLARE integer FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL"
    *         Integer lnConfirma, String lsCupom, String lsData, String lsHorario
    * (com "integer" minusculo, o que provavelmente escondeu a linha de quem
    * conferiu). A funcao eh CHAMADA pelo GetDatas.Valid, no ramo em que a
    * senha do supervisor vem em branco - sem este DECLARE aquele caminho
    * estouraria em runtime com "FinalizaTransacaoSiTefInterativo is not
    * found", e o terminal ficaria com a transacao EM ABERTO em vez de
    * finalizada.
    * Redeclarar a mesma assinatura eh inofensivo em VFP9; a falha real (DLL
    * ausente) so aparece quando a funcao eh CHAMADA, nao na declaracao - por
    * isso o TRY aqui eh so para nao derrubar InicializarForm em maquina sem
    * o CliSiTef32I.DLL (mesmo criterio de SigOpCtfBO.DeclararFuncoesSiTef).
    *==========================================================================
    PROTECTED PROCEDURE DeclararFuncoesSiTef()
        LOCAL loc_oErro

        TRY
            DECLARE INTEGER ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                STRING lsEndereco, STRING lsLoja, STRING lsTerminal, INTEGER lnReservado

            DECLARE INTEGER IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER lnModalidade, STRING lsValor, STRING lsCupom, STRING lsData, ;
                STRING lsHorario, STRING lsOperador, STRING lsRestricao

            DECLARE INTEGER ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER @lnComando, INTEGER @lnTipo, INTEGER @lnMinimo, INTEGER @lnMaximo, ;
                STRING @lsBuffer, INTEGER lnTamanho, INTEGER lnResultado

            DECLARE INTEGER FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER lnConfirma, STRING lsCupom, STRING lsData, STRING lsHorario
        CATCH TO loc_oErro
            *-- DLL nao presente nesta maquina (dev/pipeline sem PIN-pad
            *-- SiTef). CATCH sem MsgErro de proposito: o DECLARE falhando
            *-- aqui nao impede a tela de abrir, e em producao a DLL existe.
            *--
            *-- CORRIGIDO NA FASE 8/8 o que este comentario afirmava antes
            *-- ("a chamada real avisa o usuario via ConectarSiTef"): isso eh
            *-- FALSO e foi medido. Sem o DECLARE, o nome da funcao vira nome
            *-- de .prg para o VFP (regra #13) e a primeira chamada estoura
            *-- "File 'continuafuncaositefinterativo.prg' does not exist" -
            *-- mensagem que nao cita DLL nem SiTef e manda o diagnostico
            *-- para o lado errado. Nao foi acrescentada guarda nova aqui
            *-- porque o legado tambem nao tem (em producao a DLL sempre
            *-- existe) e inventa-la divergiria do PILAR 1; o que se conserta
            *-- eh a afirmacao errada, para o proximo leitor nao confiar nela.
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarIdentificacaoTerminal - Migrado do trecho de SIGOPDTF.GetDigitos.
    * GotFocus que monta o identificador de terminal antes de chamar
    * ConfiguraIntSiTefInterativo:
    *     lcIdTerminal = fConverteStr(CrSigCdEmp.nEmps) + ;
    *         TRANSFORM(VAL(crSigFiMpF.Cncaixas), "@L 999999")
    *
    * crSigCdEmp/crSigFiMpF sao cursores globais do Framework legado, nunca
    * populados em nenhum ponto do dump deste form (mesma categoria de
    * dependencia ausente tratada em SigOpCtfBO.CarregarCaixaSiTef). Em vez
    * de depender de cursor global nao documentado, consulta SigCdEmp/
    * SIGFIMPF diretamente pela empresa corrente (go_4c_Sistema.cCodEmpresa)
    * e, quando este_cCaixa (parametro "Caixa" recebido no Init) bate com
    * algum SIGFIMPF.cncaixas da empresa, usa esse registro; caso contrario,
    * cai no mesmo fallback "melhor esforco" do sibling (1o registro da
    * empresa, ou "000000" se nao achar nenhum).
    *==========================================================================
    FUNCTION CarregarIdentificacaoTerminal()
        LOCAL loc_oErro, loc_cSQLEmpresa, loc_cSQLCaixa

        THIS.this_nEmpresa     = 0
        THIS.this_cCaixaConfig = "000000"

        TRY
            IF USED("cursor_4c_SigCdEmpTef")
                USE IN cursor_4c_SigCdEmpTef
            ENDIF
            loc_cSQLEmpresa = "SELECT nemps FROM SigCdEmp WHERE cemps = " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa)
            SQLEXEC(gnConnHandle, loc_cSQLEmpresa, "cursor_4c_SigCdEmpTef")

            IF USED("cursor_4c_SigCdEmpTef") AND !EOF("cursor_4c_SigCdEmpTef")
                THIS.this_nEmpresa = TratarNulo(cursor_4c_SigCdEmpTef.nemps, 0)
            ENDIF
            IF USED("cursor_4c_SigCdEmpTef")
                USE IN cursor_4c_SigCdEmpTef
            ENDIF

            IF USED("cursor_4c_SigFiMpF")
                USE IN cursor_4c_SigFiMpF
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cCaixa))
                loc_cSQLCaixa = "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa) + " AND cncaixas = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cCaixa))
            ELSE
                loc_cSQLCaixa = "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa)
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQLCaixa, "cursor_4c_SigFiMpF")

            IF USED("cursor_4c_SigFiMpF") AND !EOF("cursor_4c_SigFiMpF")
                THIS.this_cCaixaConfig = TRANSFORM(VAL(TratarNulo(cursor_4c_SigFiMpF.cncaixas, "0")), "@L 999999")
            ENDIF
            IF USED("cursor_4c_SigFiMpF")
                USE IN cursor_4c_SigFiMpF
            ENDIF
        CATCH TO loc_oErro
            *-- Sem a tabela/registro, segue com os fallbacks acima - mesmo
            *-- desfecho pratico do legado quando os cursores globais estao vazios.
        ENDTRY

        THIS.this_cIdTerminal = fConvertestr(THIS.this_nEmpresa) + THIS.this_cCaixaConfig

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * CarregarConfiguracaoPagamento - FASE 8/8. Migrado de SIGOPDTF.Init:
    *     .poDatamgr.SqlExecute([Select * From SigOpFp Where FPags = ?lcOpers], 'crSigOpFp')
    *     If Empty(crSigOpFp.CodEstabs)
    *         lsIdTerminal = "00000" + _Empr
    *     Else
    *         lsIdTerminal = crSigOpFp.CodEstabs
    *     Endif
    *
    * lcOpers eh o parametro "pcOpers" recebido no Init (this_cOpers) - o
    * codigo da FORMA DE PAGAMENTO escolhida no caixa, nao um operador de
    * usuario, apesar do nome. Seis das colunas lidas aqui decidem o ramo que
    * o protocolo toma em cada pergunta do terminal; a setima (codestabs) eh
    * o argumento "lsLoja" do ConfiguraIntSiTefInterativo.
    *
    * SELECT com a lista EXPLICITA de colunas em vez do "Select *" do legado:
    * sao as unicas 7 que o dump consulta, de uma tabela com 121 colunas.
    *
    * NAO derruba o form quando a consulta falha: os defaults declarados na
    * classe ("N"/0/.F.) sao o mesmo desfecho pratico que o legado tem quando
    * o cursor global vem vazio - mesmo criterio de
    * CarregarIdentificacaoTerminal.
    *==========================================================================
    FUNCTION CarregarConfiguracaoPagamento()
        LOCAL loc_oErro, loc_cSQL, loc_lAchou

        loc_lAchou = .F.

        TRY
            IF USED("cursor_4c_SigOpFp")
                IF CURSORGETPROP("Buffering", "cursor_4c_SigOpFp") > 1
                    TABLEREVERT(.T., "cursor_4c_SigOpFp")
                ENDIF
                USE IN cursor_4c_SigOpFp
            ENDIF

            loc_cSQL = "SELECT lcartao, lsaque, tcdc, garantias, dias, mesfec, " + ;
                       "chkbins, codestabs FROM SigOpFp WHERE fpags = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cOpers))

            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpFp")

            IF USED("cursor_4c_SigOpFp") AND !EOF("cursor_4c_SigOpFp")
                THIS.this_lOpFpCartao    = (UPPER(TratarNulo(cursor_4c_SigOpFp.lcartao, "N")) = "S")
                THIS.this_lOpFpSaque     = (UPPER(TratarNulo(cursor_4c_SigOpFp.lsaque, "N")) = "S")
                THIS.this_cOpFpTcdc      = UPPER(TratarNulo(cursor_4c_SigOpFp.tcdc, "N"))
                THIS.this_lOpFpGarantias = (UPPER(TratarNulo(cursor_4c_SigOpFp.garantias, "N")) = "S")
                THIS.this_nOpFpDias      = TratarNulo(cursor_4c_SigOpFp.dias, 0)
                THIS.this_nOpFpMesFec    = TratarNulo(cursor_4c_SigOpFp.mesfec, 0)
                THIS.this_nOpFpChkBins   = TratarNulo(cursor_4c_SigOpFp.chkbins, 0)
                THIS.this_cOpFpCodEstabs = ALLTRIM(TratarNulo(cursor_4c_SigOpFp.codestabs, ""))
                loc_lAchou = .T.
            ENDIF

            IF USED("cursor_4c_SigOpFp")
                USE IN cursor_4c_SigOpFp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao ler a forma de pagamento")
        ENDTRY

        RETURN loc_lAchou
    ENDFUNC

    *==========================================================================
    * ValidarBinCartao - FASE 8/8. Migrado do bloco "IF TipoCampo = 136" que o
    * legado REPETE LITERALMENTE em quatro lacos (GetDigitos.Valid,
    * GetDigitos.GotFocus, GetDatas.Valid, GetDatas.GotFocus):
    *     lcQuery = [Select ChkBins From SigOpFp Where FPags = '] + ThisForm.pcOpers + [']
    *     If csTmpFPag.ChkBins = 1
    *         lcQuery = [Select CodBins, DataIs, DataFs From SigOpFpb Where FPags = '...'
    *                    And CodBins = '] + Alltrim(Strtran(Buffer, Chr(0), '')) + [']
    *         If Eof() Or Not Between(Dtos(Date()), Dtos(Nvl(csTmpFPagb.Datais, Ctod('01/01/1900'))),
    *                                               Dtos(Nvl(csTmpFPagb.DataFs, Ctod('31/12/9999'))))
    *             -> aborta a transacao ("Cartao Invalido para esta Condicao de Pagamento")
    *         EndIf
    *     Endif
    *
    * Devolve .T. quando o BIN eh ACEITO (inclusive quando a checagem esta
    * desligada, que eh o caminho em que o legado nao faz nada) e .F. quando o
    * cartao nao vale para esta condicao de pagamento. Os quatro call sites
    * consomem a MESMA funcao de proposito: quatro copias divergiriam em
    * silencio na primeira mudanca de regra (CLAUDE.md #44, item 6).
    *
    * O ChkBins NAO eh reconsultado aqui: a coluna ja vem de
    * CarregarConfiguracaoPagamento (mesma tabela, mesma chave fpags) - o
    * legado refazia o SELECT a cada passagem do laco porque nao guardava o
    * valor em lugar nenhum.
    *
    * Janela de validade: datais/datafs sao datetime (schema.sql). Nulo cai nos
    * mesmos sentinelas do legado (01/01/1900 e 31/12/9999), e a comparacao eh
    * por DTOS, como no original - comparar DATE com DATETIME daria erro 11
    * (regra #16), por isso ConverterParaData normaliza os dois lados.
    *==========================================================================
    FUNCTION ValidarBinCartao(par_cBin)
        LOCAL loc_oErro, loc_cSQL, loc_cBin, loc_lValido, loc_dIni, loc_dFim, loc_cHoje

        *-- Checagem desligada na forma de pagamento: o legado nao consulta
        *-- nada e segue a transacao.
        IF THIS.this_nOpFpChkBins != 1
            RETURN .T.
        ENDIF

        loc_cBin    = ALLTRIM(STRTRAN(IIF(VARTYPE(par_cBin) = "C", par_cBin, ""), CHR(0), ""))
        loc_lValido = .F.

        TRY
            IF USED("cursor_4c_SigOpFpb")
                IF CURSORGETPROP("Buffering", "cursor_4c_SigOpFpb") > 1
                    TABLEREVERT(.T., "cursor_4c_SigOpFpb")
                ENDIF
                USE IN cursor_4c_SigOpFpb
            ENDIF

            loc_cSQL = "SELECT codbins, datais, datafs FROM SigOpFpb WHERE fpags = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cOpers)) + " AND codbins = " + ;
                       EscaparSQL(loc_cBin)

            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpFpb")

            IF USED("cursor_4c_SigOpFpb") AND !EOF("cursor_4c_SigOpFpb")
                loc_dIni  = ConverterParaData(TratarNulo(cursor_4c_SigOpFpb.datais, CTOD("01/01/1900")))
                loc_dFim  = ConverterParaData(TratarNulo(cursor_4c_SigOpFpb.datafs, CTOD("31/12/9999")))
                IF EMPTY(loc_dIni)
                    loc_dIni = CTOD("01/01/1900")
                ENDIF
                IF EMPTY(loc_dFim)
                    loc_dFim = CTOD("31/12/9999")
                ENDIF
                loc_cHoje   = DTOS(DATE())
                loc_lValido = BETWEEN(loc_cHoje, DTOS(loc_dIni), DTOS(loc_dFim))
            ENDIF

            IF USED("cursor_4c_SigOpFpb")
                USE IN cursor_4c_SigOpFpb
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao validar o BIN do cart" + CHR(227) + "o")
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * ConectarSiTef - Migrado de SIGOPDTF.GetDigitos.GotFocus:
    *     IF ConfiguraIntSiTefInterativo(lsEndSitef, lsIdTerminal, lcIdTerminal, 0) <> 0
    *
    * CORRIGIDO NA FASE 8/8. A Fase 1 escreveu, com razao para o que tinha em
    * maos, que "lsIdTerminal (2o argumento, lsLoja) nao tem fonte explicita
    * visivel no dump disponivel para esta fase" e usou o parametro "Caixa"
    * como fallback. O dump COMPLETO, lido nesta fase, tem a fonte - esta no
    * SIGOPDTF.Init, longe do GotFocus que faz a chamada:
    *     If Empty(crSigOpFp.CodEstabs)
    *         lsIdTerminal = "00000" + _Empr
    *     Else
    *         lsIdTerminal = crSigOpFp.CodEstabs
    *     Endif
    * Ou seja "lsLoja" eh o CODIGO DE ESTABELECIMENTO da forma de pagamento
    * (SigOpFp.codestabs, char(8)), nao o numero do caixa. Mantido o fallback
    * "00000" + empresa, que eh o do proprio legado.
    *
    * Nao eh detalhe cosmetico: este argumento identifica a LOJA no servidor
    * SiTef. Enviar o numero do caixa no lugar do estabelecimento faz o
    * servidor recusar a conexao (ou credenciar a transacao na loja errada),
    * e o usuario veria so "Sem comunicacao com SiTef".
    *
    * lcIdTerminal (3o argumento, "lsTerminal") eh THIS.this_cIdTerminal,
    * calculado em CarregarIdentificacaoTerminal.
    *==========================================================================
    FUNCTION ConectarSiTef()
        LOCAL loc_cLoja, loc_nRetorno

        IF !EMPTY(ALLTRIM(THIS.this_cOpFpCodEstabs))
            loc_cLoja = ALLTRIM(THIS.this_cOpFpCodEstabs)
        ELSE
            loc_cLoja = "00000" + ALLTRIM(go_4c_Sistema.cCodEmpresa)
        ENDIF

        loc_nRetorno = ConfiguraIntSiTefInterativo(ALLTRIM(THIS.this_cEndSiTef), ;
            loc_cLoja, THIS.this_cIdTerminal, 0)

        RETURN (loc_nRetorno = 0)
    ENDFUNC

    *==========================================================================
    * IniciarSiTef - Migrado de SIGOPDTF.GetDigitos.GotFocus:
    *     lcValpago = Alltrim(Transform(lnValPago,"99999999.99"))
    *     lcValPago = Strtran(lcValPago,".",",")
    *     lcData    = Str(Year(Date()),4) + Substr(Dtoc(Date()),4,2) + Substr(Dtoc(Date()),1,2)
    *     lchora    = Strtran(Time(),":","")
    *     IF IniciaFuncaoSiTefInterativo(0, lcValPago, lsCupom, lcData, lchora, ...) <> 10000
    *
    * Modalidade (0) eh LITERAL no legado. par_cData/par_cHora chegam ja
    * formatados pelo Form (mesmo calculo acima, repetido em todo ponto do
    * dump que inicia a transacao). 6o argumento (lsOperador) segue o mesmo
    * criterio de sigprdftBO.IniciarSiTef - usa THIS.this_cCaixa, unico dado
    * de identificacao do caixa recebido no Init.
    *==========================================================================
    FUNCTION IniciarSiTef(par_cData, par_cHora)
        LOCAL loc_cValPago, loc_nRetorno

        loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_nValPago, "99999999.99")), ".", ",")

        loc_nRetorno = IniciaFuncaoSiTefInterativo(0, loc_cValPago, THIS.this_cCupom, ;
            par_cData, par_cHora, ALLTRIM(THIS.this_cCaixa), "")

        RETURN (loc_nRetorno = 10000)
    ENDFUNC

    *==========================================================================
    * ContinuarSiTef - Migrado das chamadas ContinuaFuncaoSiTefInterativo
    * espalhadas pelo legado (GetDigitos.Valid, GetCodSeg.LostFocus,
    * GetDatas.Valid/GotFocus, Text1.Valid, SAIDA.Click). Centraliza a
    * chamada por referencia (LOCAL -> DLL -> THIS.this_n*/this_cBuffer) -
    * mesmo criterio de SigOpCtfBO.ContinuarSiTef/sigprdftBO.ContinuarSiTef.
    *==========================================================================
    FUNCTION ContinuarSiTef(par_nContinua)
        LOCAL loc_nProximoComando, loc_nTipoCampo, loc_nTamanhoMinimo, ;
              loc_nTamanhoMaximo, loc_cBuffer, loc_nRetorno

        loc_nProximoComando = THIS.this_nProximoComando
        loc_nTipoCampo      = THIS.this_nTipoCampo
        loc_nTamanhoMinimo  = THIS.this_nTamanhoMinimo
        loc_nTamanhoMaximo  = THIS.this_nTamanhoMaximo
        loc_cBuffer         = IIF(EMPTY(THIS.this_cBuffer), SPACE(2000), THIS.this_cBuffer)

        loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nProximoComando, @loc_nTipoCampo, ;
            @loc_nTamanhoMinimo, @loc_nTamanhoMaximo, @loc_cBuffer, LEN(loc_cBuffer), par_nContinua)

        THIS.this_nProximoComando = loc_nProximoComando
        THIS.this_nTipoCampo      = loc_nTipoCampo
        THIS.this_nTamanhoMinimo  = loc_nTamanhoMinimo
        THIS.this_nTamanhoMaximo  = loc_nTamanhoMaximo
        THIS.this_cBuffer         = loc_cBuffer

        RETURN loc_nRetorno
    ENDFUNC

    *==========================================================================
    * FinalizarTransacaoSiTef - FASE 8/8. Encapsula a 4a funcao da DLL,
    * chamada pelo SIGOPDTF.GetDatas.Valid quando a senha do supervisor vem em
    * branco (o operador desistiu):
    *     FinalizaTransacaoSiTefInterativo(0, IIF(EMPTY(SigTef.nCupom),"1",SigTef.nCupom),
    *                                      lcData, lcHora)
    * O 1o argumento (lnConfirma) eh 0 = NAO confirmar, isto eh desfazer a
    * transacao em aberto no terminal. Literal no legado, e o unico call site.
    *
    * par_cCupom chega do Form: o legado o le do DBF SigTef
    * (goSistema.DirTefEcfs + "\SigTef"), arquivo do modulo fiscal que nao faz
    * parte do acervo migrado, caindo em "1" quando vazio - que eh o valor que
    * o Form passa.
    *==========================================================================
    FUNCTION FinalizarTransacaoSiTef(par_nConfirma, par_cCupom, par_cData, par_cHora)
        LOCAL loc_nRetorno

        loc_nRetorno = FinalizaTransacaoSiTefInterativo( ;
            IIF(VARTYPE(par_nConfirma) = "N", par_nConfirma, 0), ;
            IIF(VARTYPE(par_cCupom) = "C" AND !EMPTY(par_cCupom), par_cCupom, "1"), ;
            IIF(VARTYPE(par_cData) = "C", par_cData, ""), ;
            IIF(VARTYPE(par_cHora) = "C", par_cHora, ""))

        RETURN loc_nRetorno
    ENDFUNC

    *==========================================================================
    * MontarBufferSiTef - carrega this_cBuffer com o valor digitado pelo
    * usuario, completado com CHR(0) ate o tamanho que
    * ContinuaFuncaoSiTefInterativo espera. Migrado do padrao repetido em
    * cada LostFocus/Valid do legado (SENHA/GetDigitos/GetCartao/GetCodSeg):
    *     Buffer = Alltrim(This.Value) + Replicate(Chr(0), 2000 - Len(Alltrim(This.Value)))
    *==========================================================================
    FUNCTION MontarBufferSiTef(par_cValor, par_nComplemento)
        LOCAL loc_cValor, loc_nComplemento

        loc_cValor = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), ;
            ALLTRIM(TRANSFORM(par_cValor)))

        IF VARTYPE(par_nComplemento) = "N" AND par_nComplemento > 0
            loc_nComplemento = par_nComplemento
        ELSE
            loc_nComplemento = 2000 - LEN(loc_cValor)
        ENDIF

        IF loc_nComplemento < 0
            loc_nComplemento = 0
        ENDIF

        THIS.this_cBuffer = loc_cValor + REPLICATE(CHR(0), loc_nComplemento)

        RETURN THIS.this_cBuffer
    ENDFUNC

    *==========================================================================
    * NOTA DE ARQUITETURA - SOMENTE INTEGRACAO COM DLL (sem tabela propria)
    *
    * O dump disponivel para esta fase (comportamento.json) nao mostra
    * nenhum INSERT/UPDATE/DELETE/TABLEUPDATE contra o SQL Server em metodo
    * algum de SIGOPDTF - as 5 queries capturadas sao todas
    * "INSERT INTO crSiTef (...)", um CURSOR LOCAL de memoria (CREATE CURSOR
    * crSiTef) usado so como buffer de protocolo para montar a mensagem de
    * falha exibida ao usuario (RetornoFalha), nunca persistido no banco.
    * A tela processa um pagamento em cartao via DLL (CliSiTef32I.DLL) -
    * mesma natureza de SigOpCtfBO (cancelamento) e sigprdftBO (pagamento a
    * debito), ambos ja migrados com este mesmo criterio.
    *
    * Por isso:
    *   - Inserir(), Atualizar() e ExecutarExclusao() NAO sao sobrescritos
    *     aqui - o comportamento herdado de BusinessBase (recusar a operacao
    *     e deixar o motivo em this_cMensagemErro, reportado pelo
    *     ExibirFalha de Salvar()/Excluir()) ja eh o correto. Sobrescrever
    *     exigiria inventar uma tabela/lista de colunas que o legado nunca
    *     grava, o que a regra #22 do CLAUDE.md proibe;
    *   - RegistrarAuditoria() tambem fica herdado e nunca eh chamado por
    *     este BO: sem Inserir()/Atualizar() proprios nao ha operacao de
    *     escrita para auditar;
    *   - CarregarDoCursor() nao se aplica: os dados digitados na tela
    *     (Valor, Digitos, Cartao, TipoVenda, Parcelas, Data) sao atribuidos
    *     diretamente as properties this_n*/this_c*/this_d* pelo proprio Form
    *     (FormParaBO/BOParaForm), e o retorno da transacao TEF vem do
    *     protocolo ContinuaFuncaoSiTefInterativo via DLL, nao de um SELECT -
    *     nao ha cursor de banco a percorrer aqui.
    *==========================================================================

    *==========================================================================
    * ObterChavePrimaria - SIGOPDTF nao grava registro nenhum (integracao com
    * o terminal SiTef via CliSiTef32I.DLL). Nao existe chave primaria porque
    * nao existe tabela; retornar vazio mantem RegistrarAuditoria() inofensivo
    * (ela ja aborta quando a chave vem vazia - ver BusinessBase.RegistrarAuditoria).
    * PROTECTED: nunca chamado de fora (regra #51 do CLAUDE.md).
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

ENDDEFINE

