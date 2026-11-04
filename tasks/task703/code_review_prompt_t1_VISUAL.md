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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopclg.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2023 linhas total):

*-- Linhas 57 a 65:
57: * legado, nao o dump"): Usuario Rede/Data/Hora/Programa/Operacao (ligada a
58: * cOpers, a descricao calculada, nao a Opers crua)/Usuario Sistema/
59: * Parametro. Geometria do Grid (Top=197/Left=63/Width=656/Height=307) =
60: * valores do dump + compensacao +29 do PageFrame.Top=-29 (regra #1/#11) -
61: * sem rescala horizontal, pois a faixa de botoes Left=917 nao alcanca essa
62: * altura (Top>=197). AlternarPagina(par_nPagina) tambem entra nesta fase,
63: * com o guard que o legado tem no proprio fluxo (Processamento so chega em
64: * "ActivePage = 2" quando a consulta devolve linha - "If Eof() Then
65: * Return" - aqui expresso contra this_oBusinessObject.this_nQtdeLog, que

*-- Linhas 78 a 86:
78: * "99:99" transcritos do dump) e txt_4c_Prg (Programa) + os labels
79: * correspondentes (Say1/Say2/Say3/Say4/Say5/Say6 do legado). Todos filhos
80: * DIRETOS da Page1 (sem container de agrupamento no dump), Top = dump + 29
81: * (compensacao PageFrame.Top=-29), Left mantido igual ao dump (so os
82: * containers de botao usam posicao canonica rescalada - Fase 3/4).
83: * Caracteres acentuados via CHR() (regra CLAUDE.md #4): CHR(225)=a-acute,
84: * CHR(237)=i-acute, CHR(224)=a-grave (confirmado no .scx - byte 0xE0 -
85: * usado entre as duas datas/horarios do periodo, ex. "01/01 " + CHR(224) +
86: * " 31/01"). O lookup de Programa (SigCdPrg.Programas) entrou na Fase 6/8,

*-- Linhas 358 a 376:
358:         loc_oPgf = THIS.pgf_4c_Paginas
359: 
360:         loc_oPgf.PageCount = 2
361:         loc_oPgf.Top       = -29
362:         loc_oPgf.Left      = 0
363:         loc_oPgf.Width     = THIS.Width
364:         loc_oPgf.Height    = THIS.Height + 29
365:         loc_oPgf.TabIndex  = 1
366:         loc_oPgf.Tabs      = .F.
367: 
368:         loc_oPgf.Page1.Caption = "Dados"
369:         loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
370: 
371:         loc_oPgf.Page2.Caption = "Resultado"
372:         loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
373: 
374:         loc_oPgf.Visible    = .T.
375:         loc_oPgf.ActivePage = 1
376:     ENDPROC

*-- Linhas 394 a 733:
394:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
395:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
396:         WITH loc_oCab
397:             .Top           = 29
398:             .Left          = 0
399:             .Width         = THIS.Width
400:             .Height        = 80
401:             .BorderWidth   = 0
402:             .SpecialEffect = 0
403:             .BackColor     = RGB(100, 100, 100)
404: 
405:             .AddObject("lbl_4c_Sombra", "Label")
406:             WITH .lbl_4c_Sombra
407:                 .Top       = 15
408:                 .Left      = 10
409:                 .Width     = THIS.Width
410:                 .Height    = 40
411:                 .FontName  = "Tahoma"
412:                 .FontSize  = 16
413:                 .FontBold  = .T.
414:                 .WordWrap  = .T.
415:                 .Alignment = 0
416:                 .BackStyle = 0
417:                 .ForeColor = RGB(0, 0, 0)
418:                 .Caption   = THIS.Caption
419:             ENDWITH
420: 
421:             .AddObject("lbl_4c_Titulo", "Label")
422:             WITH .lbl_4c_Titulo
423:                 .Top       = 18
424:                 .Left      = 10
425:                 .Width     = THIS.Width
426:                 .Height    = 46
427:                 .FontName  = "Tahoma"
428:                 .FontSize  = 16
429:                 .FontBold  = .T.
430:                 .WordWrap  = .T.
431:                 .Alignment = 0
432:                 .BackStyle = 0
433:                 .ForeColor = RGB(255, 255, 255)
434:                 .Caption   = THIS.Caption
435:             ENDWITH
436:         ENDWITH
437: 
438:         *-- Container com o botao Processar + Encerrar (cmdProcessar do
439:         *-- legado - CommandGroup com 2 botoes: Command1/btnProcessar
440:         *-- dispara sigopclgBO.BuscarLog() [Fase 7/8], Command2/btnSair
441:         *-- fecha a tela com ThisForm.Release [Fase 7/8]). Width/Height do
442:         *-- container = Width/Height do cmdProcessar legado (160x85).
443:         loc_oPag.AddObject("cnt_4c_Botoes", "Container")
444:         WITH loc_oPag.cnt_4c_Botoes
445:             .Top         = 29
446:             .Left        = 542
447:             .Width       = 160
448:             .Height      = 85
449:             .BackStyle   = 0
450:             .BorderWidth = 0
451:             .Visible     = .T.
452: 
453:             .AddObject("cmg_4c_Acoes", "CommandGroup")
454:             WITH .cmg_4c_Acoes
455:                 .Top         = 0
456:                 .Left        = 0
457:                 .Width       = 160
458:                 .Height      = 85
459:                 .ButtonCount = 2
460:                 .BackStyle   = 0
461:                 .BorderStyle = 0
462:                 .Themes      = .F.
463:             ENDWITH
464: 
465:             *-- Command1/btnProcessar do legado
466:             WITH .cmg_4c_Acoes.Buttons(1)
467:                 .Top         = 5
468:                 .Left        = 5
469:                 .Width       = 75
470:                 .Height      = 75
471:                 .FontName    = "Comic Sans MS"
472:                 .FontSize    = 8
473:                 .FontBold    = .T.
474:                 .FontItalic  = .T.
475:                 .WordWrap    = .T.
476:                 .ForeColor   = RGB(90, 90, 90)
477:                 .BackColor   = RGB(255, 255, 255)
478:                 .Themes      = .F.
479:                 .Picture     = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
480:                 .Caption     = "\<Processar"
481:                 .ToolTipText = "Processar"
482:             ENDWITH
483: 
484:             *-- Command2/btnSair do legado
485:             WITH .cmg_4c_Acoes.Buttons(2)
486:                 .Top         = 5
487:                 .Left        = 80
488:                 .Width       = 75
489:                 .Height      = 75
490:                 .FontName    = "Comic Sans MS"
491:                 .FontSize    = 8
492:                 .FontBold    = .T.
493:                 .FontItalic  = .T.
494:                 .WordWrap    = .T.
495:                 .Cancel      = .T.
496:                 .ForeColor   = RGB(90, 90, 90)
497:                 .BackColor   = RGB(255, 255, 255)
498:                 .Themes      = .F.
499:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
500:                 .Caption     = "Encerrar"
501:                 .ToolTipText = "[ESC] Sair"
502:             ENDWITH
503:         ENDWITH
504: 
505:         *-- FASE 5/8 (PARTE 1/2): primeira metade dos campos de filtro -
506:         *-- Usuario de Rede, Periodo (Data Inicial/Final), Horario de
507:         *-- Acesso (Inicial/Final) e Programa. Sao filhos DIRETOS da
508:         *-- pagina no legado (sem container de agrupamento no dump), por
509:         *-- isso ficam direto em loc_oPag, sem rescala horizontal (so os
510:         *-- containers de botao usam a posicao canonica - Fase 3/4/8); Top
511:         *-- de cada controle = Top do dump + 29 (compensacao
512:         *-- PageFrame.Top=-29, regra CLAUDE.md #1/#11).
513:         *--
514:         *-- Parte 2 (Fase 6/8, abaixo): Operacao (ComboBox), Usuario do
515:         *-- Sistema, Parametros, Transacao + os BINDEVENT dos lookups de
516:         *-- Programa (SigCdPrg) e Usuario do Sistema (SigCdUsu).
517: 
518:         *-- Say4 "Usuario da Rede :" (Left=98/Top=197 no dump)
519:         loc_oPag.AddObject("lbl_4c_Label4", "Label")
520:         WITH loc_oPag.lbl_4c_Label4
521:             .Top       = 226
522:             .Left      = 98
523:             .Width     = 85
524:             .Height    = 15
525:             .FontName  = "Tahoma"
526:             .FontSize  = 8
527:             .FontBold  = .F.
528:             .Alignment = 0
529:             .AutoSize  = .F.
530:             .BackStyle = 0
531:             .ForeColor = RGB(90, 90, 90)
532:             .Caption   = "Usu" + CHR(225) + "rio da Rede :"
533:         ENDWITH
534: 
535:         *-- GetUserRede do legado - Usuario de Rede (this_cUserRede no BO)
536:         loc_oPag.AddObject("txt_4c_UserRede", "TextBox")
537:         WITH loc_oPag.txt_4c_UserRede
538:             .Top       = 223
539:             .Left      = 189
540:             .Width     = 152
541:             .Height    = 23
542:             .FontName  = "Tahoma"
543:             .FontSize  = 8
544:             .MaxLength = 20
545:             .Value     = ""
546:             .TabIndex  = 1
547:         ENDWITH
548: 
549:         *-- Say2 "Periodo :" (Left=141/Top=224 no dump)
550:         loc_oPag.AddObject("lbl_4c_Label2", "Label")
551:         WITH loc_oPag.lbl_4c_Label2
552:             .Top       = 253
553:             .Left      = 141
554:             .Width     = 45
555:             .Height    = 15
556:             .FontName  = "Tahoma"
557:             .FontSize  = 8
558:             .FontBold  = .F.
559:             .Alignment = 0
560:             .AutoSize  = .F.
561:             .BackStyle = 0
562:             .ForeColor = RGB(90, 90, 90)
563:             .Caption   = "Per" + CHR(237) + "odo :"
564:         ENDWITH
565: 
566:         *-- getDtIni do legado - Periodo: data inicial (this_dDtIni no BO)
567:         loc_oPag.AddObject("txt_4c_DtIni", "TextBox")
568:         WITH loc_oPag.txt_4c_DtIni
569:             .Top       = 250
570:             .Left      = 189
571:             .Width     = 80
572:             .Height    = 23
573:             .FontName  = "Tahoma"
574:             .FontSize  = 8
575:             .Alignment = 3
576:             .Value     = {}
577:             .TabIndex  = 2
578:         ENDWITH
579: 
580:         *-- Say3 "a" (CHR(224)) entre as duas datas do periodo
581:         loc_oPag.AddObject("lbl_4c_Label3", "Label")
582:         WITH loc_oPag.lbl_4c_Label3
583:             .Top       = 254
584:             .Left      = 276
585:             .Width     = 12
586:             .Height    = 15
587:             .FontName  = "Tahoma"
588:             .FontSize  = 8
589:             .FontBold  = .F.
590:             .Alignment = 0
591:             .AutoSize  = .F.
592:             .BackStyle = 0
593:             .ForeColor = RGB(90, 90, 90)
594:             .Caption   = CHR(224)
595:         ENDWITH
596: 
597:         *-- getDtFin do legado - Periodo: data final (this_dDtFin no BO)
598:         loc_oPag.AddObject("txt_4c_DtFin", "TextBox")
599:         WITH loc_oPag.txt_4c_DtFin
600:             .Top       = 250
601:             .Left      = 290
602:             .Width     = 80
603:             .Height    = 23
604:             .FontName  = "Tahoma"
605:             .FontSize  = 8
606:             .Alignment = 3
607:             .Value     = {}
608:             .TabIndex  = 3
609:         ENDWITH
610: 
611:         *-- Say1 "Horario de Acesso :" (Left=90/Top=253 no dump)
612:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
613:         WITH loc_oPag.lbl_4c_Label1
614:             .Top       = 282
615:             .Left      = 90
616:             .Width     = 95
617:             .Height    = 15
618:             .FontName  = "Tahoma"
619:             .FontSize  = 8
620:             .FontBold  = .F.
621:             .Alignment = 0
622:             .AutoSize  = .F.
623:             .BackStyle = 0
624:             .ForeColor = RGB(90, 90, 90)
625:             .Caption   = "Hor" + CHR(225) + "rio de Acesso :"
626:         ENDWITH
627: 
628:         *-- GetHrIni do legado - Horario inicial, HH:MM (this_cHrIni no BO -
629:         *-- Format "R" + InputMask "99:99" fazem do .Value um HHMM sem
630:         *-- separador, regra CLAUDE.md #24/#49: transcrever o par literal)
631:         loc_oPag.AddObject("txt_4c_HrIni", "TextBox")
632:         WITH loc_oPag.txt_4c_HrIni
633:             .Top       = 278
634:             .Left      = 189
635:             .Width     = 51
636:             .Height    = 23
637:             .FontName  = "Tahoma"
638:             .FontSize  = 8
639:             .Alignment = 3
640:             .Format    = "R"
641:             .InputMask = "99:99"
642:             .Value     = ""
643:             .TabIndex  = 4
644:         ENDWITH
645: 
646:         *-- Say5 "a" (CHR(224)) entre os dois horarios
647:         loc_oPag.AddObject("lbl_4c_Label5", "Label")
648:         WITH loc_oPag.lbl_4c_Label5
649:             .Top       = 282
650:             .Left      = 245
651:             .Width     = 13
652:             .Height    = 15
653:             .FontName  = "Tahoma"
654:             .FontSize  = 8
655:             .FontBold  = .F.
656:             .Alignment = 0
657:             .AutoSize  = .F.
658:             .BackStyle = 0
659:             .ForeColor = RGB(90, 90, 90)
660:             .Caption   = CHR(224)
661:         ENDWITH
662: 
663:         *-- GetHrFin do legado - Horario final, HH:MM (this_cHrFin no BO)
664:         loc_oPag.AddObject("txt_4c_HrFin", "TextBox")
665:         WITH loc_oPag.txt_4c_HrFin
666:             .Top       = 278
667:             .Left      = 260
668:             .Width     = 51
669:             .Height    = 23
670:             .FontName  = "Tahoma"
671:             .FontSize  = 8
672:             .Alignment = 3
673:             .Format    = "R"
674:             .InputMask = "99:99"
675:             .Value     = ""
676:             .TabIndex  = 5
677:         ENDWITH
678: 
679:         *-- Say6 "Programa :" (Left=131/Top=278 no dump)
680:         loc_oPag.AddObject("lbl_4c_Label6", "Label")
681:         WITH loc_oPag.lbl_4c_Label6
682:             .Top       = 307
683:             .Left      = 131
684:             .Width     = 55
685:             .Height    = 15
686:             .FontName  = "Tahoma"
687:             .FontSize  = 8
688:             .FontBold  = .F.
689:             .Alignment = 0
690:             .AutoSize  = .F.
691:             .BackStyle = 0
692:             .ForeColor = RGB(90, 90, 90)
693:             .Caption   = "Programa :"
694:         ENDWITH
695: 
696:         *-- GetPrg do legado - Programa (this_cPrg no BO; lookup contra
697:         *-- SigCdPrg.Programas em ValidarPrgLostFocus, Fase 6/8 - BINDEVENT
698:         *-- no fim deste metodo). Format/InputMask do dump sao override
699:         *-- VAZIO do Form Designer - nao transcritos (regra CLAUDE.md #49).
700:         loc_oPag.AddObject("txt_4c_Prg", "TextBox")
701:         WITH loc_oPag.txt_4c_Prg
702:             .Top       = 305
703:             .Left      = 189
704:             .Width     = 152
705:             .Height    = 23
706:             .FontName  = "Tahoma"
707:             .FontSize  = 8
708:             .Alignment = 3
709:             .MaxLength = 20
710:             .Value     = ""
711:             .TabIndex  = 6
712:         ENDWITH
713: 
714:         *-- Say8 "Operacao :" (Left=130/Top=306 no dump)
715:         loc_oPag.AddObject("lbl_4c_Label8", "Label")
716:         WITH loc_oPag.lbl_4c_Label8
717:             .Top       = 335
718:             .Left      = 130
719:             .Width     = 55
720:             .Height    = 15
721:             .FontName  = "Tahoma"
722:             .FontSize  = 8
723:             .FontBold  = .F.
724:             .Alignment = 0
725:             .AutoSize  = .F.
726:             .BackStyle = 0
727:             .ForeColor = RGB(90, 90, 90)
728:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
729:         ENDWITH
730: 
731:         *-- GetOperacao do legado - ComboBox de Operacao (this_cOperacao no
732:         *-- BO). RowSourceType = 1 (lista literal) + Style = 2 (DropDownList):
733:         *-- o .Value eh o TEXTO da opcao escolhida, e eh esse texto que

*-- Linhas 739 a 748:
739:         *-- EM BRANCO (o ", " final), que eh como o usuario zera o filtro.
740:         loc_oPag.AddObject("cbo_4c_GetOperacao", "ComboBox")
741:         WITH loc_oPag.cbo_4c_GetOperacao
742:             .Top           = 331
743:             .Left          = 189
744:             .Width         = 152
745:             .Height        = 24
746:             .FontName      = "Tahoma"
747:             .FontSize      = 8
748:             .Style         = 2

*-- Linhas 754 a 858:
754:         ENDWITH
755: 
756:         *-- Say7 "Usuario do Sistema :" (Left=86/Top=333 no dump)
757:         loc_oPag.AddObject("lbl_4c_Label7", "Label")
758:         WITH loc_oPag.lbl_4c_Label7
759:             .Top       = 362
760:             .Left      = 86
761:             .Width     = 100
762:             .Height    = 15
763:             .FontName  = "Tahoma"
764:             .FontSize  = 8
765:             .FontBold  = .F.
766:             .Alignment = 0
767:             .AutoSize  = .F.
768:             .BackStyle = 0
769:             .ForeColor = RGB(90, 90, 90)
770:             .Caption   = "Usuario do Sistema :"
771:         ENDWITH
772: 
773:         *-- GetUserSis do legado - Usuario do Sistema (this_cUserSis no BO;
774:         *-- lookup contra SigCdUsu.Usuarios - ver ValidarUserSisLostFocus).
775:         *-- MaxLength = 20 = largura de SigOpLog.usuasis char(20), que eh a
776:         *-- coluna filtrada (SigCdUsu.usuarios eh char(10) - o legado tem a
777:         *-- mesma folga).
778:         loc_oPag.AddObject("txt_4c_UserSis", "TextBox")
779:         WITH loc_oPag.txt_4c_UserSis
780:             .Top       = 359
781:             .Left      = 189
782:             .Width     = 152
783:             .Height    = 23
784:             .FontName  = "Tahoma"
785:             .FontSize  = 8
786:             .Alignment = 3
787:             .MaxLength = 20
788:             .Value     = ""
789:             .TabIndex  = 8
790:         ENDWITH
791: 
792:         *-- Say9 "Parametros :" (Left=122/Top=360 no dump)
793:         loc_oPag.AddObject("lbl_4c_Label9", "Label")
794:         WITH loc_oPag.lbl_4c_Label9
795:             .Top       = 389
796:             .Left      = 122
797:             .Width     = 62
798:             .Height    = 15
799:             .FontName  = "Tahoma"
800:             .FontSize  = 8
801:             .FontBold  = .F.
802:             .Alignment = 0
803:             .AutoSize  = .F.
804:             .BackStyle = 0
805:             .ForeColor = RGB(90, 90, 90)
806:             .Caption   = "Parametros :"
807:         ENDWITH
808: 
809:         *-- GetParam do legado - Parametros (this_cParam no BO; filtro
810:         *-- "Parametros Like 'valor%'"). MaxLength = 10 = SigOpLog.parametros
811:         *-- char(10) (regra CLAUDE.md #19 - MaxLength vem da COLUNA, nunca do
812:         *-- Width em pixels, que aqui eh 82).
813:         loc_oPag.AddObject("txt_4c_Param", "TextBox")
814:         WITH loc_oPag.txt_4c_Param
815:             .Top       = 386
816:             .Left      = 189
817:             .Width     = 82
818:             .Height    = 23
819:             .FontName  = "Tahoma"
820:             .FontSize  = 8
821:             .Alignment = 3
822:             .MaxLength = 10
823:             .Value     = ""
824:             .TabIndex  = 9
825:         ENDWITH
826: 
827:         *-- Say10 "Transacao :" (Left=127/Top=387 no dump)
828:         loc_oPag.AddObject("lbl_4c_Label10", "Label")
829:         WITH loc_oPag.lbl_4c_Label10
830:             .Top       = 416
831:             .Left      = 127
832:             .Width     = 58
833:             .Height    = 15
834:             .FontName  = "Tahoma"
835:             .FontSize  = 8
836:             .FontBold  = .F.
837:             .Alignment = 0
838:             .AutoSize  = .F.
839:             .BackStyle = 0
840:             .ForeColor = RGB(90, 90, 90)
841:             .Caption   = "Transa" + CHR(231) + CHR(227) + "o :"
842:         ENDWITH
843: 
844:         *-- GetTrans do legado - Transacao (this_cTrans no BO; filtro
845:         *-- "Transacaos Like 'valor%'"). MaxLength = 150 transcrito do dump:
846:         *-- a coluna filtrada eh SigOpLog.transacaos char(100), mas aqui o
847:         *-- campo eh FILTRO (nenhum INSERT passa por ele), entao a folga do
848:         *-- legado nao trunca gravacao nenhuma - mexer nela mudaria UX
849:         *-- (PILAR 1) sem corrigir defeito.
850:         loc_oPag.AddObject("txt_4c_Trans", "TextBox")
851:         WITH loc_oPag.txt_4c_Trans
852:             .Top       = 413
853:             .Left      = 189
854:             .Width     = 527
855:             .Height    = 23
856:             .FontName  = "Tahoma"
857:             .FontSize  = 8
858:             .Alignment = 3

*-- Linhas 921 a 1029:
921:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
922:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
923:         WITH loc_oCab
924:             .Top           = 29
925:             .Left          = 0
926:             .Width         = THIS.Width
927:             .Height        = 80
928:             .BorderWidth   = 0
929:             .SpecialEffect = 0
930:             .BackColor     = RGB(100, 100, 100)
931: 
932:             .AddObject("lbl_4c_Sombra", "Label")
933:             WITH .lbl_4c_Sombra
934:                 .Top       = 15
935:                 .Left      = 10
936:                 .Width     = THIS.Width
937:                 .Height    = 40
938:                 .FontName  = "Tahoma"
939:                 .FontSize  = 16
940:                 .FontBold  = .T.
941:                 .WordWrap  = .T.
942:                 .Alignment = 0
943:                 .BackStyle = 0
944:                 .ForeColor = RGB(0, 0, 0)
945:                 .Caption   = THIS.Caption
946:             ENDWITH
947: 
948:             .AddObject("lbl_4c_Titulo", "Label")
949:             WITH .lbl_4c_Titulo
950:                 .Top       = 18
951:                 .Left      = 10
952:                 .Width     = THIS.Width
953:                 .Height    = 46
954:                 .FontName  = "Tahoma"
955:                 .FontSize  = 16
956:                 .FontBold  = .T.
957:                 .WordWrap  = .T.
958:                 .Alignment = 0
959:                 .BackStyle = 0
960:                 .ForeColor = RGB(255, 255, 255)
961:                 .Caption   = THIS.Caption
962:             ENDWITH
963:         ENDWITH
964: 
965:         *-- Container com o botao de retorno (cmdBotoes do legado -
966:         *-- CommandGroup com 1 botao, legenda "Encerrar" + icone
967:         *-- cadastro_sair_60.jpg, mas o Click real [Fase 7/8] volta para a
968:         *-- pagina de filtros - "ThisForm.PgfPagina.PgResultado.Enabled=.f.
969:         *-- / ActivePage=1" - por isso o handler se chamara BtnVoltarClick:
970:         *-- o nome segue a ACAO real do legado, nao a legenda do botao).
971:         *-- Left/Width = padrao canonico de saida (CLAUDE.md regra #10).
972:         loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
973:         WITH loc_oPag.cnt_4c_BotoesAcao
974:             .Top         = 29
975:             .Left        = 917
976:             .Width       = 90
977:             .Height      = 85
978:             .BackStyle   = 0
979:             .BorderWidth = 0
980:             .Visible     = .T.
981: 
982:             .AddObject("cmg_4c_Voltar", "CommandGroup")
983:             WITH .cmg_4c_Voltar
984:                 .Top         = 0
985:                 .Left        = 0
986:                 .Width       = 90
987:                 .Height      = 85
988:                 .ButtonCount = 1
989:                 .BackStyle   = 0
990:                 .BorderStyle = 0
991:                 .Themes      = .F.
992:             ENDWITH
993: 
994:             *-- Command1/btnDados do legado
995:             WITH .cmg_4c_Voltar.Buttons(1)
996:                 .Top         = 5
997:                 .Left        = 5
998:                 .Width       = 75
999:                 .Height      = 75
1000:                 .FontName    = "Comic Sans MS"
1001:                 .FontSize    = 8
1002:                 .FontBold    = .T.
1003:                 .FontItalic  = .T.
1004:                 .WordWrap    = .T.
1005:                 .Cancel      = .T.
1006:                 .ForeColor   = RGB(90, 90, 90)
1007:                 .BackColor   = RGB(255, 255, 255)
1008:                 .Themes      = .F.
1009:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1010:                 .Caption     = "Encerrar"
1011:                 .ToolTipText = "[ESC] Sair"
1012:             ENDWITH
1013:         ENDWITH
1014: 
1015:         *-- GrdLog do legado - grade de resultado. Geometria = dump + 29
1016:         *-- (compensacao PageFrame.Top=-29, regra CLAUDE.md #1/#11); sem
1017:         *-- rescala horizontal (a barra de botoes Left=917 nao alcanca
1018:         *-- Top=197+). ControlSource/Header1.Caption/Width ficam em
1019:         *-- VincularGradeLog (Fase 8 do dialogo) - FONTE UNICA do bind,
1020:         *-- compartilhada com a repintura apos a consulta (Fase 7/8).
1021:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
1022:         WITH loc_oPag.grd_4c_Dados
1023:             .Top           = 197
1024:             .Left          = 63
1025:             .Width         = 656
1026:             .Height        = 307
1027:             .FontName      = "Tahoma"
1028:             .FontSize      = 8
1029:             .ReadOnly      = .T.

*-- Linhas 1038 a 1072:
1038:         *-- FontBold = .T. aqui, ao contrario do Say10 homonimo da pagina de
1039:         *-- filtros). Criado ANTES do campo para o TextBox desenhar por cima
1040:         *-- (regra CLAUDE.md #23).
1041:         loc_oPag.AddObject("lbl_4c_Label10", "Label")
1042:         WITH loc_oPag.lbl_4c_Label10
1043:             .Top       = 511
1044:             .Left      = 62
1045:             .Width     = 62
1046:             .Height    = 15
1047:             .FontName  = "Tahoma"
1048:             .FontSize  = 8
1049:             .FontBold  = .T.
1050:             .Alignment = 0
1051:             .AutoSize  = .F.
1052:             .BackStyle = 0
1053:             .ForeColor = RGB(90, 90, 90)
1054:             .Caption   = "Transa" + CHR(231) + CHR(227) + "o :"
1055:         ENDWITH
1056: 
1057:         *-- fwget1 do legado - Transacao do registro corrente da grade.
1058:         *-- Enabled = .F. no dump: o campo eh somente EXIBICAO (o conteudo
1059:         *-- vem do cursor via ControlSource, ligado em VincularGradeLog -
1060:         *-- FONTE UNICA do bind, igual ao bloco final do PROCEDURE
1061:         *-- processamento legado, que liga a grade e o fwget1 juntos).
1062:         *-- DisabledBackColor transcrito do dump para o texto desabilitado
1063:         *-- continuar legivel sobre branco.
1064:         loc_oPag.AddObject("txt_4c_Fwget1", "TextBox")
1065:         WITH loc_oPag.txt_4c_Fwget1
1066:             .Top               = 508
1067:             .Left              = 140
1068:             .Width             = 578
1069:             .Height            = 23
1070:             .FontName          = "Tahoma"
1071:             .FontSize          = 8
1072:             .Alignment         = 3

*-- Linhas 1152 a 1214:
1152:                 .Width             = 130
1153:                 .Movable           = .F.
1154:                 .Resizable         = .F.
1155:                 .Header1.Caption   = "Usuario Rede"
1156:                 .Header1.Alignment = 2
1157:                 .Header1.ForeColor = RGB(36, 84, 155)
1158:             ENDWITH
1159: 
1160:             WITH loc_oGrid.Column2
1161:                 .Width             = 65
1162:                 .Movable           = .F.
1163:                 .Resizable         = .F.
1164:                 .Header1.Caption   = "Data"
1165:                 .Header1.Alignment = 2
1166:                 .Header1.ForeColor = RGB(36, 84, 155)
1167:             ENDWITH
1168: 
1169:             WITH loc_oGrid.Column3
1170:                 .Width             = 50
1171:                 .Movable           = .F.
1172:                 .Resizable         = .F.
1173:                 .Header1.Caption   = "Hora"
1174:                 .Header1.Alignment = 2
1175:                 .Header1.ForeColor = RGB(36, 84, 155)
1176:             ENDWITH
1177: 
1178:             WITH loc_oGrid.Column4
1179:                 .Width             = 65
1180:                 .Movable           = .F.
1181:                 .Resizable         = .F.
1182:                 .Header1.Caption   = "Programa"
1183:                 .Header1.Alignment = 2
1184:                 .Header1.ForeColor = RGB(36, 84, 155)
1185:             ENDWITH
1186: 
1187:             WITH loc_oGrid.Column5
1188:                 .Width             = 95
1189:                 .Movable           = .F.
1190:                 .Resizable         = .F.
1191:                 .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1192:                 .Header1.Alignment = 2
1193:                 .Header1.ForeColor = RGB(36, 84, 155)
1194:             ENDWITH
1195: 
1196:             WITH loc_oGrid.Column6
1197:                 .Width             = 130
1198:                 .Movable           = .F.
1199:                 .Resizable         = .F.
1200:                 .Header1.Caption   = "Usu" + CHR(225) + "rio Sistema"
1201:                 .Header1.Alignment = 2
1202:                 .Header1.ForeColor = RGB(36, 84, 155)
1203:             ENDWITH
1204: 
1205:             WITH loc_oGrid.Column7
1206:                 .Width             = 85
1207:                 .Movable           = .T.
1208:                 .Resizable         = .F.
1209:                 .Header1.Caption   = "Parametro"
1210:                 .Header1.Alignment = 2
1211:                 .Header1.ForeColor = RGB(36, 84, 155)
1212:             ENDWITH
1213: 
1214:             *-- fwget1 - Transacao do registro corrente. O legado liga este


### BO (C:\4c\projeto\app\classes\sigopclgBO.prg):
*============================================================================
* sigopclgBO.prg - Business Object para Consulta do Log (SigOpLog)
*
* Tabela principal : SigOpLog (PK: cidchaves char(20))
* Form OPERACIONAL de consulta - o legado SIGOPCLG nao grava em tabela
* nenhuma: o PROCEDURE Processamento monta um SELECT dinamico conforme os
* filtros preenchidos e exibe o resultado na Page "Resultado".
*
* Lookups usados pelo form (nao persistidos nesta entidade):
*   GetPrg.Valid     -> SigCdPrg.Programas (lista de programas)
*   GetUserSis.Valid -> SigCdUsu.Usuarios  (usuario do sistema)
*
* Herda de: BusinessBase
* Fase 1: propriedades de filtro + Init + BuscarLog
* Fase 2: CarregarDoCursor (TODAS as colunas de SigOpLog), ObterChavePrimaria,
*         DescreverOperacao, LimparRegistro, LimparDados e BuscarProgramas
*============================================================================

DEFINE CLASS sigopclgBO AS BusinessBase

    *==========================================================================
    * Propriedades de filtro (espelham os campos da Page "Dados" do legado)
    *==========================================================================
    this_cUserRede = ""    && char(20) - Usuario de Rede (filtro SigOpLog.Usuaredes =)
    this_dDtIni    = {}    && date     - Periodo: data inicial (filtro SigOpLog.Datars >=)
    this_dDtFin    = {}    && date     - Periodo: data final (filtro SigOpLog.Datars <=)
    this_cHrIni    = ""    && char(4)  - Horario de Acesso inicial, HHMM (Format "R" + InputMask 99:99)
    this_cHrFin    = ""    && char(4)  - Horario de Acesso final, HHMM (Format "R" + InputMask 99:99)
    this_cPrg      = ""    && char(20) - Programa (filtro SigOpLog.Progs =; lookup SigCdPrg.Programas)
    this_cOperacao = ""    && char(20) - Operacao: "Liberacao"/"Entrada"/"Saida"/"Transacao" (filtro SigOpLog.Opers)
    this_cUserSis  = ""    && char(20) - Usuario do Sistema (filtro SigOpLog.Usuasis =; lookup SigCdUsu.Usuarios)
    this_cParam    = ""    && char(10) - Parametros (filtro SigOpLog.Parametros LIKE "valor%")
    this_cTrans    = ""    && char(100) - Transacao (filtro SigOpLog.Transacaos LIKE "valor%")

    *==========================================================================
    * Resultado da consulta (grid da Page "Resultado")
    *==========================================================================
    this_cCursorLog       = "cursor_4c_Log"        && Alias do cursor com o resultado da pesquisa
    this_cCursorProgramas = "cursor_4c_Programas"  && Alias do cursor do lookup de Programas (SigCdPrg)
    this_nQtdeLog         = 0                      && Quantidade de linhas retornadas pela ultima pesquisa

    *==========================================================================
    * Registro corrente do Log - TODAS as colunas de SigOpLog mais a descricao
    * calculada cOpers. Preenchidas por CarregarDoCursor() a partir da linha
    * corrente do cursor do grid (o legado usa o proprio cursor como
    * ControlSource das 7 colunas do GrdLog e do fwget1 da Transacao; estas
    * propriedades existem para o form ler o registro selecionado sem precisar
    * tocar o cursor direto).
    *
    * Os nomes espelham as colunas do schema (docs/schema.sql):
    *   usuaredes  char(20)  NOT NULL | datars     datetime NULL  | horas    char(8)  NOT NULL
    *   progs      char(20)  NOT NULL | opers      char(1)  NOT NULL | usuasis char(20) NOT NULL
    *   parametros char(10)  NOT NULL | transacaos char(100) NOT NULL| cversaos char(70) NOT NULL
    *   cidchaves  char(20)  NOT NULL | copias     bit      NOT NULL
    *==========================================================================
    this_cUsuaRedes    = ""    && usuaredes  - Usuario de rede que gerou o registro
    this_dDatars       = {}    && datars     - Data do acesso (a hora fica em this_cHoras)
    this_cHoras        = ""    && horas      - Hora do acesso, formato HH:MM:SS
    this_cProgs        = ""    && progs      - Programa acessado
    this_cOpers        = ""    && opers      - Codigo da operacao: E, S, L ou outro
    this_cUsuaSis      = ""    && usuasis    - Usuario do sistema
    this_cParametros   = ""    && parametros - Parametros da chamada
    this_cTransacaos   = ""    && transacaos - Transacao registrada
    this_cCVersaos     = ""    && cversaos   - Versao do executavel que gravou o log
    this_cCidChaves    = ""    && cidchaves  - Chave primaria do registro
    this_nCopias       = 0     && copias     - Coluna bit: 1 ou 0 (bit chega Logico ou Numerico conforme o driver)
    this_cOperacaoDesc = ""    && cOpers     - Descricao da operacao (Entrada/Saida/Liberacao/Transacao)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpLog"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarLog - Monta a consulta dinamica do Log de Acessos conforme os
    * filtros preenchidos pelo usuario (equivalente ao PROCEDURE Processamento
    * do legado SIGOPCLG) e popula THIS.this_cCursorLog ("cursor_4c_Log").
    *
    * Cada filtro so entra no WHERE se a propriedade correspondente estiver
    * preenchida (mesma logica condicional do legado, transcrita literalmente -
    * inclusive o guard de "nenhum parametro preenchido" e o mapeamento de
    * Operacao para o codigo de 1 letra gravado em Opers).
    *
    * Retorna .T. quando a consulta foi executada (mesmo com zero linhas) e
    * .F. quando nenhum filtro foi informado ou o SQL falhou; nos dois casos
    * de falha THIS.this_cMensagemErro traz o motivo, para o form decidir
    * entre MsgAviso (validacao) e MsgErro (falha tecnica) - este BO nao
    * chama MsgAviso/MsgErro diretamente nesse caminho.
    *
    * Responsabilidade do FORM apos chamar este metodo (Problema 48): limpar
    * e reatribuir Grid.RecordSource + cada Column.ControlSource +
    * Column.Header1.Caption, porque o SQLEXEC recria o cursor a cada busca -
    * exatamente como o legado faz em Processamento (RecordSource = '' no
    * inicio do metodo, RecordSource + ControlSource de novo no fim).
    *==========================================================================
    PROCEDURE BuscarLog()
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_cHrIniSQL, loc_cHrFinSQL
        LOCAL loc_cOperFiltro, loc_dDtFinCompleta, loc_nResultado, loc_oErro

        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_nQtdeLog = 0

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cUserRede))  AND ;
               EMPTY(THIS.this_dDtIni)              AND ;
               EMPTY(THIS.this_dDtFin)              AND ;
               EMPTY(ALLTRIM(THIS.this_cHrIni))     AND ;
               EMPTY(ALLTRIM(THIS.this_cHrFin))     AND ;
               EMPTY(ALLTRIM(THIS.this_cPrg))       AND ;
               EMPTY(ALLTRIM(THIS.this_cOperacao))  AND ;
               EMPTY(ALLTRIM(THIS.this_cUserSis))   AND ;
               EMPTY(ALLTRIM(THIS.this_cParam))     AND ;
               EMPTY(ALLTRIM(THIS.this_cTrans))

                THIS.this_cMensagemErro = "Pesquisa n" + CHR(227) + "o pode ser realizada," + CHR(13) + ;
                    "Nenhum Parametro de Sele" + CHR(231) + CHR(227) + "o foi Preenchido"
                loc_lResultado = .F.

            ELSE

                *-- Monta o WHERE dinamico - so entra o que o usuario preencheu
                loc_cWhere = ""

                IF !EMPTY(ALLTRIM(THIS.this_cUserRede))
                    loc_cWhere = loc_cWhere + " UsuaRedes = " + EscaparSQL(ALLTRIM(THIS.this_cUserRede))
                ENDIF

                IF !EMPTY(THIS.this_dDtIni)
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Datars >= " + FormatarDataSQL(THIS.this_dDtIni)
                ENDIF

                IF !EMPTY(THIS.this_dDtFin)
                    *-- Legado soma 23:59:59 ao fim do periodo (fDtoSQL(ldDtFin,'23:59:59'))
                    loc_dDtFinCompleta = DATETIME(YEAR(THIS.this_dDtFin), MONTH(THIS.this_dDtFin), ;
                        DAY(THIS.this_dDtFin), 23, 59, 59)
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Datars <= " + FormatarDataSQL(loc_dDtFinCompleta)
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cHrIni))
                    loc_cHrIniSQL = PADL(ALLTRIM(THIS.this_cHrIni), 4, "0")
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Horas >= " + EscaparSQL(SUBSTR(loc_cHrIniSQL, 1, 2) + ":" + SUBSTR(loc_cHrIniSQL, 3, 2) + ":00")
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cHrFin))
                    loc_cHrFinSQL = PADL(ALLTRIM(THIS.this_cHrFin), 4, "0")
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Horas <= " + EscaparSQL(SUBSTR(loc_cHrFinSQL, 1, 2) + ":" + SUBSTR(loc_cHrFinSQL, 3, 2) + ":00")
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cPrg))
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Progs = " + EscaparSQL(ALLTRIM(THIS.this_cPrg))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cOperacao))
                    *-- Mapeamento identico ao legado: Entrada=E, Saida=S, Liberacao=L,
                    *-- qualquer outra opcao (Transacao) = nenhum dos tres codigos acima.
                    *-- Medido no VFP9 em 2026-10-29: UPPER() converte os acentos
                    *-- (CHR(231) -> CHR(199), CHR(227) -> CHR(195)), por isso a comparacao
                    *-- com "LIBERA" + CHR(199) + CHR(195) + "O" casa com a opcao acentuada
                    *-- escolhida no ComboBox, igual ao Upper(lcOperacao) do legado.
                    DO CASE
                        CASE UPPER(ALLTRIM(THIS.this_cOperacao)) == "ENTRADA"
                            loc_cOperFiltro = " Opers = 'E'"
                        CASE UPPER(ALLTRIM(THIS.this_cOperacao)) == "SAIDA"
                            loc_cOperFiltro = " Opers = 'S'"
                        CASE UPPER(ALLTRIM(THIS.this_cOperacao)) == "LIBERA" + CHR(199) + CHR(195) + "O"
                            loc_cOperFiltro = " Opers = 'L'"
                        OTHERWISE
                            loc_cOperFiltro = " Opers <> 'E' AND Opers <> 'S' AND Opers <> 'L'"
                    ENDCASE
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + loc_cOperFiltro
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cUserSis))
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Usuasis = " + EscaparSQL(ALLTRIM(THIS.this_cUserSis))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cParam))
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Parametros LIKE " + EscaparSQL(ALLTRIM(THIS.this_cParam) + "%")
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cTrans))
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Transacaos LIKE " + EscaparSQL(ALLTRIM(THIS.this_cTrans) + "%")
                ENDIF

                *-- Colunas: cOpers (descricao calculada) primeiro, depois TODAS as
                *-- colunas de SigOpLog - o legado faz [Select '          ' As cOpers, a.*].
                *-- A descricao sai de um CASE no proprio SELECT porque cursor de SQL
                *-- pass-through nasce somente-leitura no VFP e o
                *-- "Replace All cOpers With Iif(...)" do legado nao teria onde gravar;
                *-- o mapeamento eh o MESMO de THIS.DescreverOperacao().
                loc_cSQL = "SELECT " + ;
                    "CASE a.Opers " + ;
                        "WHEN 'E' THEN 'Entrada' " + ;
                        "WHEN 'S' THEN 'Saida' " + ;
                        "WHEN 'L' THEN 'Libera" + CHR(231) + CHR(227) + "o' " + ;
                        "ELSE 'Transa" + CHR(231) + CHR(227) + "o' " + ;
                    "END AS cOpers, " + ;
                    "a.UsuaRedes, a.Datars, a.Horas, a.Progs, a.Opers, a.Usuasis, " + ;
                    "a.Parametros, a.Transacaos, a.CVersaos, a.cidchaves, a.Copias " + ;
                    "FROM SigOpLog a " + ;
                    "WHERE " + loc_cWhere

                IF USED(THIS.this_cCursorLog)
                    IF CURSORGETPROP("Buffering", THIS.this_cCursorLog) > 1
                        TABLEREVERT(.T., THIS.this_cCursorLog)
                    ENDIF
                    USE IN (THIS.this_cCursorLog)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorLog)

                IF loc_nResultado >= 0
                    SELECT (THIS.this_cCursorLog)
                    GO TOP
                    THIS.this_nQtdeLog = RECCOUNT()

                    IF THIS.this_nQtdeLog = 0
                        THIS.this_cMensagemErro = "Nenhum Registro Encontrado para Sele" + CHR(231) + CHR(227) + "o"
                        THIS.LimparRegistro()
                    ELSE
                        *-- Deixa o registro corrente do BO espelhando a 1a linha da grade
                        THIS.CarregarDoCursor(THIS.this_cCursorLog)
                    ENDIF

                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao executar a pesquisa do Log:" + CHR(13) + CapturarErroSQL()
                    loc_lResultado = .F.
                ENDIF

            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao executar a pesquisa do Log: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha CORRENTE do cursor do resultado para
    * as propriedades do registro, mapeando TODAS as colunas de SigOpLog mais
    * a descricao calculada cOpers.
    *
    * par_cCursor eh opcional: sem ele usa THIS.this_cCursorLog.
    *
    * Chamado pelo form no AfterRowColChange do GrdLog - no legado esse evento
    * faz "ThisForm.PgfPagina.PgResultado.fwget1.Refresh", porque o fwget1 da
    * Transacao tem ControlSource no cursor; aqui o form le
    * THIS.this_cTransacaos depois desta chamada.
    *
    * O alias que estava selecionado eh restaurado no fim, para a chamada nao
    * mexer na area de trabalho corrente de quem chamou.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cCursor)
        LOCAL loc_lResultado, loc_cAlias, loc_cAliasAnterior, loc_uCopias, loc_oErro

        loc_lResultado = .F.
        loc_cAliasAnterior = ALIAS()
        THIS.this_cMensagemErro = ""

        TRY
            IF VARTYPE(par_cCursor) = "C" AND !EMPTY(ALLTRIM(par_cCursor))
                loc_cAlias = ALLTRIM(par_cCursor)
            ELSE
                loc_cAlias = THIS.this_cCursorLog
            ENDIF

            DO CASE
                CASE !USED(loc_cAlias)
                    THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                        "o est" + CHR(225) + " aberto para leitura do Log."

                CASE RECCOUNT(loc_cAlias) = 0
                    THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                        "o possui registros."
                    THIS.LimparRegistro()

                OTHERWISE
                    SELECT (loc_cAlias)

                    IF EOF() OR BOF()
                        GO TOP
                    ENDIF

                    THIS.this_cUsuaRedes  = ALLTRIM(TratarNulo(UsuaRedes, ""))
                    THIS.this_dDatars     = ConverterParaData(TratarNulo(Datars, {}))
                    THIS.this_cHoras      = ALLTRIM(TratarNulo(Horas, ""))
                    THIS.this_cProgs      = ALLTRIM(TratarNulo(Progs, ""))
                    THIS.this_cOpers      = TratarNulo(Opers, "")
                    THIS.this_cUsuaSis    = ALLTRIM(TratarNulo(Usuasis, ""))
                    THIS.this_cParametros = ALLTRIM(TratarNulo(Parametros, ""))
                    THIS.this_cTransacaos = ALLTRIM(TratarNulo(Transacaos, ""))
                    THIS.this_cCVersaos   = ALLTRIM(TratarNulo(CVersaos, ""))
                    THIS.this_cCidChaves  = ALLTRIM(TratarNulo(cidchaves, ""))

                    *-- copias eh coluna bit: conforme o driver chega Logico (.T./.F.)
                    *-- ou Numerico (0/1), por isso testar VARTYPE antes de usar o valor
                    loc_uCopias = NVL(Copias, 0)
                    IF VARTYPE(loc_uCopias) = "L"
                        THIS.this_nCopias = IIF(loc_uCopias, 1, 0)
                    ELSE
                        THIS.this_nCopias = loc_uCopias
                    ENDIF

                    *-- cOpers so existe no cursor vindo de BuscarLog(); vindo de outro
                    *-- lugar, a descricao sai do mesmo mapeamento usado pelo legado
                    IF TYPE(loc_cAlias + ".cOpers") == "C"
                        THIS.this_cOperacaoDesc = ALLTRIM(TratarNulo(cOpers, ""))
                    ELSE
                        THIS.this_cOperacaoDesc = THIS.DescreverOperacao(THIS.this_cOpers)
                    ENDIF

                    loc_lResultado = .T.
            ENDCASE
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar o registro do Log: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lResultado = .F.
        ENDTRY

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DescreverOperacao - Converte o codigo gravado em SigOpLog.Opers na
    * descricao exibida na coluna "Operacao" do grid.
    *
    * Transcricao do legado (PROCEDURE Processamento):
    *   Replace All cOpers With Iif(Opers='E','Entrada',Iif(Opers='S','Saida',
    *               Iif(Opers='L','Liberacao','Transacao')))
    *==========================================================================
    PROCEDURE DescreverOperacao(par_cOpers)
        LOCAL loc_cCodigo, loc_cDescricao

        IF VARTYPE(par_cOpers) = "C"
            loc_cCodigo = UPPER(ALLTRIM(par_cOpers))
        ELSE
            loc_cCodigo = ""
        ENDIF

        DO CASE
            CASE loc_cCodigo == "E"
                loc_cDescricao = "Entrada"
            CASE loc_cCodigo == "S"
                loc_cDescricao = "Saida"
            CASE loc_cCodigo == "L"
                loc_cDescricao = "Libera" + CHR(231) + CHR(227) + "o"
            OTHERWISE
                loc_cDescricao = "Transa" + CHR(231) + CHR(227) + "o"
        ENDCASE

        RETURN loc_cDescricao
    ENDPROC

    *==========================================================================
    * BuscarProgramas - Popula o cursor do lookup de Programas usado pelo
    * Valid do campo Programa (GetPrg) do legado:
    *   SqlExecute([Select Distinct Programas From SigCdPrg Order By Programas],
    *              "crSigCdPrg")
    *
    * par_cCursor eh opcional: sem ele usa THIS.this_cCursorProgramas.
    * Retorna .T. quando a consulta rodou (mesmo com zero linhas).
    *
    * Nos dois caminhos de falha (SQL e excecao) o motivo fica em
    * THIS.this_cMensagemErro e quem EXIBE eh o FORM - mesma convencao
    * documentada em BuscarLog, deste mesmo BO. A excecao NAO eh engolida: o
    * unico chamador (o lookup de Programa em Formsigopclg) reporta com
    * MsgErro, e exibir aqui TAMBEM empilharia dois dialogos sobre a mesma
    * falha (regra CLAUDE.md #20 - fonte unica de reporte).
    *==========================================================================
    PROCEDURE BuscarProgramas(par_cCursor)
        LOCAL loc_lResultado, loc_cAlias, loc_cSQL, loc_nResultado, loc_oErro

        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF VARTYPE(par_cCursor) = "C" AND !EMPTY(ALLTRIM(par_cCursor))
                loc_cAlias = ALLTRIM(par_cCursor)
            ELSE
                loc_cAlias = THIS.this_cCursorProgramas
            ENDIF

            loc_cSQL = "SELECT DISTINCT Programas FROM SigCdPrg ORDER BY Programas"

            IF USED(loc_cAlias)
                IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                    TABLEREVERT(.T., loc_cAlias)
                ENDIF
                USE IN (loc_cAlias)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

            IF loc_nResultado >= 0
                SELECT (loc_cAlias)
                GO TOP
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar a lista de Programas:" + CHR(13) + CapturarErroSQL()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar a lista de Programas: " + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * LimparRegistro - Zera somente as propriedades do registro corrente do
    * Log, preservando os filtros digitados pelo usuario (usado quando a
    * pesquisa nao retorna linha nenhuma)
    *==========================================================================
    PROCEDURE LimparRegistro()
        THIS.this_cUsuaRedes    = ""
        THIS.this_dDatars       = {}
        THIS.this_cHoras        = ""
        THIS.this_cProgs        = ""
        THIS.this_cOpers        = ""
        THIS.this_cUsuaSis      = ""
        THIS.this_cParametros   = ""
        THIS.this_cTransacaos   = ""
        THIS.this_cCVersaos     = ""
        THIS.this_cCidChaves    = ""
        THIS.this_nCopias       = 0
        THIS.this_cOperacaoDesc = ""
    ENDPROC

    *==========================================================================
    * LimparDados - Zera filtros e registro corrente, deixando o BO como na
    * abertura da tela (o form chama este metodo ao voltar da Page "Resultado"
    * para a Page "Dados", para a consulta seguinte comecar limpa)
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cUserRede = ""
        THIS.this_dDtIni    = {}
        THIS.this_dDtFin    = {}
        THIS.this_cHrIni    = ""
        THIS.this_cHrFin    = ""
        THIS.this_cPrg      = ""
        THIS.this_cOperacao = ""
        THIS.this_cUserSis  = ""
        THIS.this_cParam    = ""
        THIS.this_cTrans    = ""

        THIS.this_nQtdeLog = 0
        THIS.LimparRegistro()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave do registro corrente (SigOpLog.cidchaves),
    * conforme THIS.this_cCampoChave definido no Init
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *==========================================================================
    * Este BO eh somente-leitura: SIGOPCLG eh um visualizador do Log de
    * Acessos e o legado nao tem gravacao nesta tela - o dump
    * sigopclg_form_codigo_fonte.txt nao tem nenhum TABLEUPDATE, nenhum
    * .AddCursor e nenhum Insert Into / Update / Delete From (o log eh gravado
    * por outros pontos da aplicacao). O comportamento padrao herdado de
    * BusinessBase - recusar a operacao preenchendo this_cMensagemErro, que o
    * Salvar()/Excluir() reportam pelo ExibirFalha() - ja eh o correto para
    * Inserir(), Atualizar() e ExecutarExclusao(), por isso eles ficam
    * herdados em vez de sobrescritos: sobrescrever exigiria inventar a lista
    * de colunas de um INSERT ou de um UPDATE que o legado nao faz, e a regra
    * #22 do CLAUDE.md manda tirar essa lista do schema, nunca de adivinhacao.
    * RegistrarAuditoria() tambem fica herdado de BusinessBase - ele eh
    * acionado por Inserir/Atualizar/ExecutarExclusao, que aqui nunca gravam -
    * e ObterChavePrimaria() acima ja devolve a chave certa (cidchaves) caso
    * alguma rotina de auditoria venha a ser acionada sobre este BO.
    *==========================================================================

ENDDEFINE

