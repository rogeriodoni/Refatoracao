# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [FONTNAME-ERRADO] Linha 430: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 454: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 478: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 505: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1040: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprftp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2654 linhas total):

*-- Linhas 180 a 189:
180:         THIS.AddObject("cnt_4c_Container1", "Container")
181:         loc_oCnt = THIS.cnt_4c_Container1
182:         WITH loc_oCnt
183:             .Top         = 128
184:             .Left        = 88
185:             .Width       = 620
186:             .Height      = 194
187:             .BackStyle   = 0
188:             .BorderWidth = 0
189:             .Visible     = .T.

*-- Linhas 195 a 233:
195:         loc_oCnt.AddObject("pgf_4c_Loc", "PageFrame")
196:         loc_oPgLoc = loc_oCnt.pgf_4c_Loc
197:         WITH loc_oPgLoc
198:             .Top        = 4
199:             .Left       = 3
200:             .Width      = 294
201:             .Height     = 186
202:             .PageCount  = 2
203:             .Tabs       = .T.
204:             .TabStyle   = 0
205:             .Themes     = .F.
206:             .Visible    = .T.
207:         ENDWITH
208:         loc_oPgLoc.Page1.Caption = "Envio Local"
209:         loc_oPgLoc.Page2.Caption = "Recebimento Local"
210: 
211:         *-- PageFrame FTP (pgfftp - pastas remotas no servidor FTP)
212:         *--   Page1 = Recebimento FTP (arquivos remotos p/ baixar)
213:         *--   Page2 = Envio FTP (destino remoto de arquivos enviados)
214:         loc_oCnt.AddObject("pgf_4c_Ftp", "PageFrame")
215:         loc_oPgFtp = loc_oCnt.pgf_4c_Ftp
216:         WITH loc_oPgFtp
217:             .Top        = 4
218:             .Left       = 326
219:             .Width      = 294
220:             .Height     = 186
221:             .PageCount  = 2
222:             .Tabs       = .T.
223:             .TabStyle   = 0
224:             .Themes     = .F.
225:             .Visible    = .T.
226:         ENDWITH
227:         loc_oPgFtp.Page1.Caption = "Recebimento FTP"
228:         loc_oPgFtp.Page2.Caption = "Envio FTP"
229: 
230:         *-- Tornar filhos visiveis (AddObject cria com Visible=.F.)
231:         THIS.TornarControlesVisiveis(loc_oCnt)
232:     ENDPROC
233: 

*-- Linhas 379 a 437:
379:     *==========================================================================
380:     PROTECTED PROCEDURE ConfigurarPaginaDados
381:         *-- Conteudo do PageFrame LOCAL (pgfloc)
382:         *--   Page1 "A Enviar"    = txt_4c_Direnvftp + cmd_4c_Cmdbrowloc + lst_4c_Lstenvftp
383:         *--   Page2 "Recebidos"   = txt_4c_Dirrecftp + cmd_4c_Cmdbrowloc + lst_4c_Lstrecftp
384:         THIS.ConfigurarConteudoPgLoc()
385: 
386:         *-- Conteudo do PageFrame FTP (pgfftp)
387:         *--   Page1 "A Baixar"    = txt_4c_Dirrecloc + cmd_4c_Cmdbrowftp + lst_4c_Lstrecloc
388:         *--   Page2 "Enviados"    = txt_4c_Direnvloc + cmd_4c_Cmdbrowftp + lst_4c_Lstenvloc
389:         THIS.ConfigurarConteudoPgFtp()
390: 
391:         *-- Grid de log (GrdInf): mensagens de status coloridas (logftp.cor)
392:         THIS.ConfigurarGrdInf()
393: 
394:         *-- Grid de progresso (GrdProc): arquivo/tamanho/local/host/status (tmpprog)
395:         THIS.ConfigurarGrdProc()
396:     ENDPROC
397: 
398:     *==========================================================================
399:     * ConfigurarBotoesSuperiores - Cria botoes de acao no topo do form:
400:     *   cmd_4c_Cmdload  (Conecta - carrega listagens FTP e local)
401:     *   cmd_4c_Cmdtran  (Transfere - envia todos para FTP)
402:     *   cmd_4c_Cmdrec   (Recebe - baixa todos do FTP)
403:     *   cmd_4c_Cmdsair  (Encerrar - posicao canonica 917)
404:     *   shp_4c_Shape1   (Shape decorativo ao redor do Encerrar)
405:     * Posicoes proporcional ao SCX original (800px -> 1000px).
406:     *==========================================================================
407:     PROTECTED PROCEDURE ConfigurarBotoesSuperiores
408:         LOCAL loc_cIcones, loc_cBmps
409:         loc_cIcones = gc_4c_CaminhoIcones
410:         loc_cBmps   = gc_4c_CaminhoIcones + "..\vbmp\"
411: 
412:         *-- Shape decorativo ao redor do botao Encerrar
413:         THIS.AddObject("shp_4c_Shape1", "Shape")
414:         WITH THIS.shp_4c_Shape1
415:             .Top         = 7
416:             .Left        = 912
417:             .Width       = 90
418:             .Height      = 110
419:             .BackStyle   = 0
420:             .BorderStyle = 0
421:             .BorderColor = RGB(0, 0, 0)
422:             .Visible     = .T.
423:         ENDWITH
424: 
425:         *-- Botao Conecta (cmdload) - carrega listagens FTP e locais
426:         THIS.AddObject("cmd_4c_Cmdload", "CommandButton")
427:         WITH THIS.cmd_4c_Cmdload
428:             .Top             = 12
429:             .Left            = 23
430:             .Width           = 75
431:             .Height          = 75
432:             .Caption         = CHR(92) + "<Conecta"
433:             .FontName        = "Comic Sans MS"
434:             .FontSize        = 8
435:             .FontBold        = .T.
436:             .FontItalic      = .T.
437:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 444 a 461:
444:             .MousePointer    = 15
445:             .Visible         = .T.
446:         ENDWITH
447:         BINDEVENT(THIS.cmd_4c_Cmdload, "Click", THIS, "CmdCmdloadClick")
448: 
449:         *-- Botao Transfere (cmdtran) - envia todos os arquivos para o FTP
450:         THIS.AddObject("cmd_4c_Cmdtran", "CommandButton")
451:         WITH THIS.cmd_4c_Cmdtran
452:             .Top             = 12
453:             .Left            = 103
454:             .Width           = 75
455:             .Height          = 75
456:             .Caption         = CHR(92) + "<Transfere"
457:             .FontName        = "Comic Sans MS"
458:             .FontSize        = 8
459:             .FontBold        = .T.
460:             .FontItalic      = .T.
461:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 468 a 485:
468:             .MousePointer    = 15
469:             .Visible         = .T.
470:         ENDWITH
471:         BINDEVENT(THIS.cmd_4c_Cmdtran, "Click", THIS, "CmdCmdtranClick")
472: 
473:         *-- Botao Recebe (cmdrec) - baixa todos os arquivos do FTP
474:         THIS.AddObject("cmd_4c_Cmdrec", "CommandButton")
475:         WITH THIS.cmd_4c_Cmdrec
476:             .Top             = 12
477:             .Left            = 183
478:             .Width           = 75
479:             .Height          = 75
480:             .Caption         = CHR(92) + "<Recebe"
481:             .FontName        = "Comic Sans MS"
482:             .FontSize        = 8
483:             .FontBold        = .T.
484:             .FontItalic      = .T.
485:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 492 a 511:
492:             .MousePointer    = 15
493:             .Visible         = .T.
494:         ENDWITH
495:         BINDEVENT(THIS.cmd_4c_Cmdrec, "Click", THIS, "CmdCmdrecClick")
496: 
497:         *-- Botao Encerrar (cmdsair) - posicao canonica CLAUDE.md
498:         THIS.AddObject("cmd_4c_Cmdsair", "CommandButton")
499:         WITH THIS.cmd_4c_Cmdsair
500:             .Top             = 12
501:             .Left            = 917
502:             .Width           = 75
503:             .Height          = 75
504:             .Caption         = "Encerrar"
505:             .Cancel          = .T.
506:             .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
507:             .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
508:             .FontName        = "Comic Sans MS"
509:             .FontSize        = 8
510:             .FontBold        = .T.
511:             .FontItalic      = .T.

*-- Linhas 519 a 561:
519:             .MousePointer    = 15
520:             .Visible         = .T.
521:         ENDWITH
522:         BINDEVENT(THIS.cmd_4c_Cmdsair, "Click", THIS, "CmdCmdsairClick")
523: 
524:         *-- Imagens dos botoes de acao (vbmp/ do legado)
525:         IF FILE(loc_cBmps + "a_arrow1.bmp")
526:             THIS.cmd_4c_Cmdload.Picture         = loc_cBmps + "a_arrow1.bmp"
527:             THIS.cmd_4c_Cmdload.DisabledPicture = loc_cBmps + "a_arrow1.bmp"
528:         ENDIF
529:         IF FILE(loc_cBmps + "baix_aut.bmp")
530:             THIS.cmd_4c_Cmdtran.Picture         = loc_cBmps + "baix_aut.bmp"
531:             THIS.cmd_4c_Cmdtran.DisabledPicture = loc_cBmps + "baix_aut.bmp"
532:         ENDIF
533:         IF FILE(loc_cBmps + "d_disk1.bmp")
534:             THIS.cmd_4c_Cmdrec.Picture         = loc_cBmps + "d_disk1.bmp"
535:             THIS.cmd_4c_Cmdrec.DisabledPicture = loc_cBmps + "d_disk1.bmp"
536:         ENDIF
537: 
538:         *-- Labels "MASTER" (decorativos, variam por empresa - ocultos por default)
539:         THIS.AddObject("lbl_4c_Label8", "Label")
540:         WITH THIS.lbl_4c_Label8
541:             .Top       = 138
542:             .Left      = 805
543:             .Caption   = "MASTER"
544:             .FontName  = "Verdana"
545:             .FontSize  = 8
546:             .FontBold  = .T.
547:             .ForeColor = RGB(0, 255, 0)
548:             .BackStyle = 0
549:             .Visible   = .F.
550:         ENDWITH
551: 
552:         THIS.AddObject("lbl_4c_Label9", "Label")
553:         WITH THIS.lbl_4c_Label9
554:             .Top       = 137
555:             .Left      = 804
556:             .Caption   = "MASTER"
557:             .FontName  = "Verdana"
558:             .FontSize  = 8
559:             .FontBold  = .T.
560:             .ForeColor = RGB(255, 0, 0)
561:             .BackStyle = 0

*-- Linhas 574 a 630:
574:         loc_oPgLoc = THIS.cnt_4c_Container1.pgf_4c_Loc
575: 
576:         *-- Captions e cores das abas (do SCX original)
577:         loc_oPgLoc.Page1.Caption   = "A Enviar"
578:         loc_oPgLoc.Page1.FontBold  = .T.
579:         loc_oPgLoc.Page1.FontName  = "Verdana"
580:         loc_oPgLoc.Page1.FontSize  = 8
581:         loc_oPgLoc.Page1.BackColor = RGB(255, 255, 255)
582:         loc_oPgLoc.Page1.ForeColor = RGB(0, 0, 255)
583:         loc_oPgLoc.Page2.Caption   = "Recebidos"
584:         loc_oPgLoc.Page2.FontBold  = .T.
585:         loc_oPgLoc.Page2.FontName  = "Verdana"
586:         loc_oPgLoc.Page2.FontSize  = 8
587:         loc_oPgLoc.Page2.BackColor = RGB(255, 255, 255)
588:         loc_oPgLoc.Page2.ForeColor = RGB(255, 0, 0)
589: 
590:         *-- PAGE 1: A Enviar (arquivos locais que serao enviados ao FTP)
591:         loc_oPage1 = loc_oPgLoc.Page1
592:         loc_oPage1.AddObject("txt_4c_Direnvftp", "TextBox")
593:         WITH loc_oPage1.txt_4c_Direnvftp
594:             .Top      = 2
595:             .Left     = 2
596:             .Width    = 217
597:             .Height   = 23
598:             .Value    = ""
599:             .FontName = "Verdana"
600:             .FontSize = 8
601:             .ReadOnly = .T.
602:             .Visible  = .T.
603:         ENDWITH
604: 
605:         loc_oPage1.AddObject("cmd_4c_BrowlocEnvio", "CommandButton")
606:         WITH loc_oPage1.cmd_4c_BrowlocEnvio
607:             .Top      = 2
608:             .Left     = 222
609:             .Width    = 22
610:             .Height   = 22
611:             .Caption  = "..."
612:             .Enabled  = .F.
613:             .FontName = "Verdana"
614:             .FontSize = 8
615:             .ForeColor = RGB(36, 84, 155)
616:             .BackColor = RGB(255, 255, 255)
617:             .Themes   = .F.
618:             .Visible  = .T.
619:         ENDWITH
620:         BINDEVENT(loc_oPage1.cmd_4c_BrowlocEnvio, "Click", THIS, "CmdBrowlocEnvioClick")
621: 
622:         loc_oPage1.AddObject("obj_4c_Lstenvftp", "ListBox")
623:         WITH loc_oPage1.obj_4c_Lstenvftp
624:             .Top          = 26
625:             .Left         = 2
626:             .Width        = 286
627:             .Height       = 130
628:             .ColumnCount  = 3
629:             .ColumnWidths = "130,62,83"
630:             .ColumnLines  = .T.

*-- Linhas 639 a 678:
639:         loc_oPage2 = loc_oPgLoc.Page2
640:         loc_oPage2.AddObject("txt_4c_Dirrecftp", "TextBox")
641:         WITH loc_oPage2.txt_4c_Dirrecftp
642:             .Top      = 2
643:             .Left     = 2
644:             .Width    = 217
645:             .Height   = 23
646:             .Value    = ""
647:             .FontName = "Verdana"
648:             .FontSize = 8
649:             .ReadOnly = .T.
650:             .Visible  = .T.
651:         ENDWITH
652: 
653:         loc_oPage2.AddObject("cmd_4c_BrowlocReceb", "CommandButton")
654:         WITH loc_oPage2.cmd_4c_BrowlocReceb
655:             .Top      = 2
656:             .Left     = 222
657:             .Width    = 22
658:             .Height   = 22
659:             .Caption  = "..."
660:             .Enabled  = .F.
661:             .FontName = "Verdana"
662:             .FontSize = 8
663:             .ForeColor = RGB(36, 84, 155)
664:             .BackColor = RGB(255, 255, 255)
665:             .Themes   = .F.
666:             .Visible  = .T.
667:         ENDWITH
668:         BINDEVENT(loc_oPage2.cmd_4c_BrowlocReceb, "Click", THIS, "CmdBrowlocRecebClick")
669: 
670:         loc_oPage2.AddObject("obj_4c_Lstrecftp", "ListBox")
671:         WITH loc_oPage2.obj_4c_Lstrecftp
672:             .Top          = 26
673:             .Left         = 2
674:             .Width        = 286
675:             .Height       = 130
676:             .ColumnCount  = 3
677:             .ColumnWidths = "135,58,82"
678:             .ColumnLines  = .T.

*-- Linhas 701 a 756:
701:         loc_oPgFtp = THIS.cnt_4c_Container1.pgf_4c_Ftp
702: 
703:         *-- Captions e cores das abas (do SCX original)
704:         loc_oPgFtp.Page1.Caption   = "Enviados"
705:         loc_oPgFtp.Page1.FontBold  = .T.
706:         loc_oPgFtp.Page1.FontName  = "Verdana"
707:         loc_oPgFtp.Page1.FontSize  = 8
708:         loc_oPgFtp.Page1.BackColor = RGB(255, 255, 255)
709:         loc_oPgFtp.Page1.ForeColor = RGB(0, 0, 255)
710:         loc_oPgFtp.Page2.Caption   = "A Receber"
711:         loc_oPgFtp.Page2.FontBold  = .T.
712:         loc_oPgFtp.Page2.FontName  = "Verdana"
713:         loc_oPgFtp.Page2.FontSize  = 8
714:         loc_oPgFtp.Page2.BackColor = RGB(255, 255, 255)
715:         loc_oPgFtp.Page2.ForeColor = RGB(255, 0, 0)
716: 
717:         *-- PAGE 1: Enviados (diretorio remoto FTP de destino dos enviados)
718:         loc_oPage1 = loc_oPgFtp.Page1
719:         loc_oPage1.AddObject("txt_4c_Dirrecloc", "TextBox")
720:         WITH loc_oPage1.txt_4c_Dirrecloc
721:             .Top      = 2
722:             .Left     = 2
723:             .Width    = 217
724:             .Height   = 23
725:             .Value    = ""
726:             .FontName = "Verdana"
727:             .FontSize = 8
728:             .ReadOnly = .T.
729:             .Visible  = .T.
730:         ENDWITH
731: 
732:         loc_oPage1.AddObject("cmd_4c_BrowftpEnviados", "CommandButton")
733:         WITH loc_oPage1.cmd_4c_BrowftpEnviados
734:             .Top      = 2
735:             .Left     = 223
736:             .Width    = 22
737:             .Height   = 22
738:             .Caption  = "..."
739:             .Enabled  = .F.
740:             .FontName = "Verdana"
741:             .FontSize = 8
742:             .ForeColor = RGB(36, 84, 155)
743:             .BackColor = RGB(255, 255, 255)
744:             .Themes   = .F.
745:             .Visible  = .T.
746:         ENDWITH
747: 
748:         loc_oPage1.AddObject("obj_4c_Lstrecloc", "ListBox")
749:         WITH loc_oPage1.obj_4c_Lstrecloc
750:             .Top          = 26
751:             .Left         = 2
752:             .Width        = 286
753:             .Height       = 130
754:             .ColumnCount  = 3
755:             .ColumnWidths = "135,58,82"
756:             .ColumnLines  = .T.

*-- Linhas 765 a 803:
765:         loc_oPage2 = loc_oPgFtp.Page2
766:         loc_oPage2.AddObject("txt_4c_Direnvloc", "TextBox")
767:         WITH loc_oPage2.txt_4c_Direnvloc
768:             .Top      = 2
769:             .Left     = 2
770:             .Width    = 217
771:             .Height   = 23
772:             .Value    = ""
773:             .FontName = "Verdana"
774:             .FontSize = 8
775:             .ReadOnly = .T.
776:             .Visible  = .T.
777:         ENDWITH
778: 
779:         loc_oPage2.AddObject("cmd_4c_BrowftpAReceber", "CommandButton")
780:         WITH loc_oPage2.cmd_4c_BrowftpAReceber
781:             .Top      = 2
782:             .Left     = 223
783:             .Width    = 22
784:             .Height   = 22
785:             .Caption  = "..."
786:             .Enabled  = .F.
787:             .FontName = "Verdana"
788:             .FontSize = 8
789:             .ForeColor = RGB(36, 84, 155)
790:             .BackColor = RGB(255, 255, 255)
791:             .Themes   = .F.
792:             .Visible  = .T.
793:         ENDWITH
794: 
795:         loc_oPage2.AddObject("obj_4c_Lstenvloc", "ListBox")
796:         WITH loc_oPage2.obj_4c_Lstenvloc
797:             .Top          = 26
798:             .Left         = 2
799:             .Width        = 286
800:             .Height       = 130
801:             .ColumnCount  = 3
802:             .ColumnWidths = "130,62,83"
803:             .ColumnLines  = .T.

*-- Linhas 818 a 888:
818:     *==========================================================================
819:     * ConfigurarBotoesTransferencia - Cria as setas de transferencia individual
820:     * dentro do cnt_4c_Container1 (entre pgf_4c_Loc e pgf_4c_Ftp):
821:     *   cmd_4c_Cmdtransfere (>) transfere arquivo selecionado local->FTP
822:     *   cmd_4c_Cmdrecebe    (<) recebe arquivo selecionado FTP->local
823:     *==========================================================================
824:     PROTECTED PROCEDURE ConfigurarBotoesTransferencia
825:         LOCAL loc_oCnt
826:         loc_oCnt = THIS.cnt_4c_Container1
827: 
828:         loc_oCnt.AddObject("cmd_4c_Cmdtransfere", "CommandButton")
829:         WITH loc_oCnt.cmd_4c_Cmdtransfere
830:             .Top         = 83
831:             .Left        = 299
832:             .Width       = 25
833:             .Height      = 24
834:             .Caption     = ""
835:             .ToolTipText = "Transfere para FTP"
836:             .FontName    = "Verdana"
837:             .FontSize    = 8
838:             .ForeColor   = RGB(36, 84, 155)
839:             .BackColor   = RGB(255, 255, 255)
840:             .Enabled     = .T.
841:             .Visible     = .T.
842:         ENDWITH
843:         BINDEVENT(loc_oCnt.cmd_4c_Cmdtransfere, "Click", THIS, "CmdCmdtransfereClick")
844: 
845:         loc_oCnt.AddObject("cmd_4c_Cmdrecebe", "CommandButton")
846:         WITH loc_oCnt.cmd_4c_Cmdrecebe
847:             .Top         = 116
848:             .Left        = 299
849:             .Width       = 25
850:             .Height      = 24
851:             .Caption     = ""
852:             .ToolTipText = "Recebe do FTP"
853:             .FontName    = "Verdana"
854:             .FontSize    = 8
855:             .ForeColor   = RGB(36, 84, 155)
856:             .BackColor   = RGB(255, 255, 255)
857:             .Enabled     = .F.
858:             .Visible     = .T.
859:         ENDWITH
860:         BINDEVENT(loc_oCnt.cmd_4c_Cmdrecebe, "Click", THIS, "CmdCmdrecebeClick")
861: 
862:         *-- Imagens das setas de transferencia individual (vbmp/ legado)
863:         LOCAL loc_cVbmp
864:         loc_cVbmp = gc_4c_CaminhoIcones + "..\vbmp\"
865:         IF FILE(loc_cVbmp + "b_arrow2.bmp")
866:             loc_oCnt.cmd_4c_Cmdtransfere.Picture = loc_cVbmp + "b_arrow2.bmp"
867:         ENDIF
868:         IF FILE(loc_cVbmp + "b_arrow1.bmp")
869:             loc_oCnt.cmd_4c_Cmdrecebe.Picture = loc_cVbmp + "b_arrow1.bmp"
870:         ENDIF
871:     ENDPROC
872: 
873:     *==========================================================================
874:     * ConfigurarGrdInf - Grid de log de operacoes FTP (equivalente ao GrdInf)
875:     * RecordSource = "logftp" | DynamicBackColor/ForeColor por cor (R/G/B)
876:     *==========================================================================
877:     PROTECTED PROCEDURE ConfigurarGrdInf
878:         LOCAL loc_oGrid
879:         THIS.AddObject("grd_4c_GrdInf", "Grid")
880:         loc_oGrid = THIS.grd_4c_GrdInf
881:         WITH loc_oGrid
882:             .Top                = 323
883:             .Left               = 89
884:             .Width              = 622
885:             .Height             = 52
886:             .ColumnCount        = 1
887:             .RecordMark         = .F.
888:             .DeleteMark         = .F.

*-- Linhas 916 a 924:
916:             .Header1.FontBold  = .T.
917:             .Header1.FontName  = "Arial"
918:             .Header1.FontSize  = 8
919:             .Header1.Caption   = "Memo"
920:             .Header1.Alignment = 2
921:             .Header1.ForeColor = RGB(0, 0, 0)
922:             .Header1.BackColor = RGB(192, 192, 192)
923:         ENDWITH
924:         loc_oGrid.SetAll("DynamicForeColor", ;

*-- Linhas 939 a 948:
939:         THIS.AddObject("grd_4c_GrdProc", "Grid")
940:         loc_oGrid = THIS.grd_4c_GrdProc
941:         WITH loc_oGrid
942:             .Top            = 376
943:             .Left           = 89
944:             .Width          = 622
945:             .Height         = 114
946:             .ColumnCount    = 5
947:             .RecordMark     = .F.
948:             .DeleteMark     = .F.

*-- Linhas 963 a 1071:
963:             .ReadOnly      = .T.
964:             .ForeColor     = RGB(0, 0, 0)
965:             .BackColor     = RGB(255, 255, 255)
966:             .Header1.Caption = "Arquivo"
967:             .Header1.FontSize = 8
968:         ENDWITH
969:         WITH loc_oGrid.Column2
970:             .FontSize      = 8
971:             .Width         = 63
972:             .ControlSource = "tmpprog.size"
973:             .ReadOnly      = .T.
974:             .ForeColor     = RGB(0, 0, 0)
975:             .BackColor     = RGB(255, 255, 255)
976:             .Header1.Caption = "Tamanho"
977:             .Header1.FontSize = 8
978:         ENDWITH
979:         WITH loc_oGrid.Column3
980:             .FontSize      = 8
981:             .Width         = 107
982:             .ControlSource = "tmpprog.local"
983:             .ReadOnly      = .T.
984:             .ForeColor     = RGB(0, 0, 0)
985:             .BackColor     = RGB(255, 255, 255)
986:             .Header1.Caption = "Pasta Local"
987:             .Header1.FontSize = 8
988:         ENDWITH
989:         WITH loc_oGrid.Column4
990:             .FontSize      = 8
991:             .Width         = 136
992:             .ControlSource = "tmpprog.host"
993:             .ReadOnly      = .T.
994:             .ForeColor     = RGB(0, 0, 0)
995:             .BackColor     = RGB(255, 255, 255)
996:             .Header1.Caption = "Pasta Host"
997:             .Header1.FontSize = 8
998:         ENDWITH
999:         WITH loc_oGrid.Column5
1000:             .FontSize      = 8
1001:             .Width         = 207
1002:             .ControlSource = "tmpprog.status"
1003:             .ReadOnly      = .T.
1004:             .ForeColor     = RGB(0, 0, 0)
1005:             .BackColor     = RGB(255, 255, 255)
1006:             .Header1.Caption = "Status"
1007:             .Header1.FontSize = 8
1008:         ENDWITH
1009:     ENDPROC
1010: 
1011:     *==========================================================================
1012:     * ConfigurarRodape - Label de progresso, ComboBox de provedores Dial-Up
1013:     * e botao de conexao Dial-Up (cmdconect)
1014:     *==========================================================================
1015:     PROTECTED PROCEDURE ConfigurarRodape
1016:         *-- Label de progresso de operacoes (lblprog)
1017:         THIS.AddObject("lbl_4c_Lblprog", "Label")
1018:         WITH THIS.lbl_4c_Lblprog
1019:             .Top       = 512
1020:             .Left      = 245
1021:             .Width     = 437
1022:             .Height    = 16
1023:             .Caption   = ""
1024:             .FontBold  = .T.
1025:             .FontName  = "Verdana"
1026:             .FontSize  = 10
1027:             .BackStyle = 0
1028:             .ForeColor = RGB(36, 84, 155)
1029:             .TabStop   = .F.
1030:             .Visible   = .T.
1031:         ENDWITH
1032: 
1033:         *-- Botao Dial-Up (cmdconect) - conecta via RAS
1034:         THIS.AddObject("cmd_4c_Cmdconect", "CommandButton")
1035:         WITH THIS.cmd_4c_Cmdconect
1036:             .Top       = 534
1037:             .Left      = 332
1038:             .Width     = 76
1039:             .Height    = 54
1040:             .Caption   = "Rede " + CHR(92) + "<Dial-Up"
1041:             .FontBold  = .T.
1042:             .FontItalic = .T.
1043:             .FontName  = "Comic Sans MS"
1044:             .FontSize  = 7
1045:             .ForeColor = RGB(90, 90, 90)
1046:             .BackColor = RGB(255, 255, 255)
1047:             .Themes    = .F.
1048:             .PicturePosition = 13
1049:             .WordWrap  = .T.
1050:             .Visible   = .T.
1051:         ENDWITH
1052:         BINDEVENT(THIS.cmd_4c_Cmdconect, "Click", THIS, "CmdCmdconectClick")
1053: 
1054:         *-- Imagem do botao de conexao Dial-Up (vbmp/ legado)
1055:         LOCAL loc_cVbmp
1056:         loc_cVbmp = gc_4c_CaminhoIcones + "..\vbmp\"
1057:         IF FILE(loc_cVbmp + "c_comm1.bmp")
1058:             THIS.cmd_4c_Cmdconect.Picture         = loc_cVbmp + "c_comm1.bmp"
1059:             THIS.cmd_4c_Cmdconect.DisabledPicture = loc_cVbmp + "c_comm1.bmp"
1060:         ENDIF
1061: 
1062:         *-- ComboBox de provedores Dial-Up (CboProvedor)
1063:         THIS.AddObject("cbo_4c_CboProvedor", "ComboBox")
1064:         WITH THIS.cbo_4c_CboProvedor
1065:             .Top           = 550
1066:             .Left          = 90
1067:             .Width         = 235
1068:             .Height        = 24
1069:             .RowSourceType = 0
1070:             .Style         = 2
1071:             .Value         = 0

*-- Linhas 1097 a 1106:
1097:             IF loc_oCnt.pgf_4c_Ftp.ActivePage != par_nPagina
1098:                 loc_oCnt.pgf_4c_Ftp.ActivePage = par_nPagina
1099:             ENDIF
1100:             loc_oCnt.cmd_4c_Cmdtransfere.Enabled = (par_nPagina = 1)
1101:             loc_oCnt.cmd_4c_Cmdrecebe.Enabled    = (par_nPagina = 2)
1102:         CATCH TO loc_oErro
1103:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1104:         ENDTRY
1105:         THIS.this_lAlternandoPagina = .F.
1106:     ENDPROC

*-- Linhas 1164 a 1172:
1164:     PROCEDURE CmdCmdloadClick
1165:         LOCAL loc_lOk, loc_nAtivas, loc_oErro
1166:         loc_lOk = .T.
1167:         THIS.cmd_4c_Cmdload.Enabled = .F.
1168:         TRY
1169:             DO CASE
1170:                 CASE THIS.this_cTpConnect = "D"
1171:                     PUBLIC ARRAY aAtivas(1)
1172:                     loc_nAtivas = THIS.RasAtivas("aAtivas")

*-- Linhas 1190 a 1198:
1190:                     " PROC=" + loc_oErro.Procedure, "Erro")
1191:             loc_lOk = .F.
1192:         ENDTRY
1193:         THIS.cmd_4c_Cmdload.Enabled = .T.
1194:         RETURN loc_lOk
1195:     ENDPROC
1196: 
1197:     *==========================================================================
1198:     * CmdCmdtranClick - Transfere TODOS os arquivos listados para o FTP

*-- Linhas 1953 a 1989:
1953:     ENDPROC
1954: 
1955:     *==========================================================================
1956:     * FileCtrlUp - Atualiza label de progresso lbl_4c_Lblprog
1957:     * Substitui FileControl (classe Framework nao disponivel no novo sistema)
1958:     * par_pStep  : numero (passo atual) OU logico (.T.=iniciar / .F.=ocultar)
1959:     * par_pTotal : total de passos (usado quando par_pStep eh numerico)
1960:     * par_pMessage: mensagem de status (opcional, tipo C)
1961:     *==========================================================================
1962:     PROCEDURE FileCtrlUp(par_pStep, par_pTotal, par_pMessage)
1963:         LOCAL loc_oErro
1964:         TRY
1965:             IF TYPE("par_pMessage") = "C"
1966:                 IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
1967:                     THIS.lbl_4c_Lblprog.Caption = par_pMessage
1968:                 ENDIF
1969:             ENDIF
1970:             IF TYPE("par_pStep") = "N" AND TYPE("par_pTotal") = "N" AND par_pTotal > 0
1971:                 IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
1972:                     THIS.lbl_4c_Lblprog.Caption = TRANSFORM(INT(par_pStep * 100 / par_pTotal)) + "% " + ;
1973:                                                   IIF(TYPE("par_pMessage") = "C", "- " + par_pMessage, "")
1974:                 ENDIF
1975:                 DOEVENTS
1976:             ENDIF
1977:         CATCH TO loc_oErro
1978:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro FileCtrlUp")
1979:         ENDTRY
1980:     ENDPROC
1981: 
1982:     *==========================================================================
1983:     * Processa - Rastreador de progresso chamado durante transferencias FTP
1984:     * Atualiza cursor tmpprog e lbl_4c_Lblprog com andamento da transferencia.
1985:     * par_cArquivo : nome do arquivo em transferencia
1986:     * par_nTamanho : tamanho total em bytes
1987:     * par_cLocal   : diretorio local
1988:     * par_cHost    : diretorio no host FTP
1989:     * par_nTransf  : bytes ja transferidos

*-- Linhas 2027 a 2036:
2027:                         THIS.FileCtrlUp(par_nTransf * 100 / IIF(par_nTamanho > 0, par_nTamanho, 1), ;
2028:                                         100, ;
2029:                                         TRANSFORM(par_nTransf / loc_nSec / 1024, "9999.99") + " Kbps")
2030:                         IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
2031:                             THIS.lbl_4c_Lblprog.Caption = "Tempo decorrido: " + loc_cTiEla + ;
2032:                                                           "   Tempo Estimado : " + loc_cTiEst
2033:                         ENDIF
2034:                     ENDIF
2035:                 ENDIF
2036:             ENDIF

*-- Linhas 2045 a 2054:
2045:                         THIS.FileCtrlUp(IIF(par_nTamanho > 0, par_nTransf * 100 / par_nTamanho, 100), ;
2046:                                         100, ;
2047:                                         TRANSFORM(IIF(loc_nSec > 0, par_nBuffer / loc_nSec / 1000, 0), "999.99") + " Kbps")
2048:                         IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
2049:                             THIS.lbl_4c_Lblprog.Caption = " Transfer" + CHR(234) + "ncia do arquivo [ " + ;
2050:                                                           par_cArquivo + " ] Conclu" + CHR(237) + "da. OK"
2051:                         ENDIF
2052:                         THIS.Inf("Arquivo Transferido...", "B")
2053:                         THIS.FileCtrlUp(.F., .F., "")
2054:                         *-- Atualiza listbox: arquivo enviado local->FTP

*-- Linhas 2424 a 2435:
2424:     * Adaptadores CRUD -> OPERACIONAL (FTP)
2425:     *
2426:     * Form operacional FTP: fluxo distinto do padrao CRUD (Incluir/Alterar/Visualizar/Excluir).
2427:     * Os botoes reais sao: Conecta (cmd_4c_Cmdload), Transfere (cmd_4c_Cmdtran),
2428:     * Recebe (cmd_4c_Cmdrec), Rede Dial-Up (cmd_4c_Cmdconect) e Encerrar
2429:     * (cmd_4c_Cmdsair), alem dos botoes por-arquivo cmd_4c_Cmdtransfere e
2430:     * cmd_4c_Cmdrecebe dentro do Container1.
2431:     *
2432:     * Os adaptadores abaixo mapeiam as intencoes CRUD (usadas por menus/pipeline)
2433:     * para as operacoes reais equivalentes do fluxo FTP, evitando codigo morto
2434:     * e mantendo compatibilidade com chamadores genericos.
2435:     *==========================================================================

*-- Linhas 2571 a 2591:
2571:     PROCEDURE HabilitarCampos(par_lHabilitar)
2572:         LOCAL loc_oErro
2573:         TRY
2574:             IF VARTYPE(THIS.cmd_4c_Cmdtran) = "O"
2575:                 THIS.cmd_4c_Cmdtran.Enabled = par_lHabilitar AND !THIS.this_lSomenteRecebimento
2576:             ENDIF
2577:             IF VARTYPE(THIS.cmd_4c_Cmdrec) = "O"
2578:                 THIS.cmd_4c_Cmdrec.Enabled = par_lHabilitar AND !THIS.this_lSomenteEnvio
2579:             ENDIF
2580:             IF VARTYPE(THIS.cmd_4c_Cmdload) = "O"
2581:                 THIS.cmd_4c_Cmdload.Enabled = par_lHabilitar
2582:             ENDIF
2583:             IF VARTYPE(THIS.cnt_4c_Container1) = "O"
2584:                 THIS.cnt_4c_Container1.cmd_4c_Cmdtransfere.Enabled = ;
2585:                     par_lHabilitar AND !THIS.this_lSomenteRecebimento
2586:                 THIS.cnt_4c_Container1.cmd_4c_Cmdrecebe.Enabled = ;
2587:                     par_lHabilitar AND !THIS.this_lSomenteEnvio
2588:             ENDIF
2589:         CATCH TO loc_oErro
2590:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro HabilitarCampos")
2591:         ENDTRY

*-- Linhas 2629 a 2638:
2629:                     THIS.grd_4c_GrdProc.Refresh()
2630:                 ENDIF
2631:             ENDIF
2632:             IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
2633:                 THIS.lbl_4c_Lblprog.Caption = ""
2634:             ENDIF
2635:         CATCH TO loc_oErro
2636:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro LimparCampos")
2637:         ENDTRY
2638:     ENDPROC


### BO (C:\4c\projeto\app\classes\sigprftpBO.prg):
*==============================================================================
* sigprftpBO.prg - Business Object para Transferencia FTP
* Data: 2026-07-16
* Form Operacional: Transferencia e Recebimento de Arquivos via FTP
* Tabelas: SigCdPam (parametros globais), SigCdEmp (config. por empresa)
*==============================================================================

DEFINE CLASS sigprftpBO AS BusinessBase

    *-- Configuracao de conexao FTP (carregados de SigCdPam/SigCdEmp)
    this_cTpConnect  = ""    && Tipo de conexao: "D"=Dial-Up, "B"=Broadband/Direto
    this_cFtpAdd     = ""    && Endereco do servidor FTP
    this_cFtpUser    = ""    && Usuario FTP
    this_cFtpPass    = ""    && Senha FTP
    this_cDirEnvFtp  = ""    && Dir local de origem para envio ao FTP (_direnvftp)
    this_cDirRecFtp  = ""    && Dir local de destino ao receber do FTP (_dirrecftp)
    this_cDirEnvLoc  = ""    && Dir remoto FTP de origem para recebimento (_direnvloc)
    this_cDirRecLoc  = ""    && Dir remoto FTP de destino para envio (_dirrecloc)
    this_lDelLocal   = .F.   && Excluir arquivo local apos transferencia
    this_lDelHost    = .F.   && Excluir arquivo no FTP apos recebimento
    this_cTpEnv      = ""    && Mascara de arquivos para envio (ex: "*.*")
    this_cTpRec      = ""    && Mascara de arquivos para recebimento (ex: "*.*")
    this_nTpConect   = 0     && Tipo execucao: 0=manual, 1=auto-envio, 2=auto-recebimento

    *-- Parametros globais do sistema (SigCdPam)
    this_cTpTrans    = ""    && tptrans    char(6)  - Tipo de transacao
    this_cEmpMasters = ""    && empmasters char(3)  - Empresa master
    this_cGruMccrs   = ""    && grumccrs   char(10) - Grupo Mercosul
    this_cConMccrs   = ""    && conmccrs   char(10) - Conta Mercosul
    this_cVendNts    = ""    && vendnts    char(10) - Vendas NTS

    *-- Configuracao FTP da empresa (SigCdEmp)
    this_cTpConexaoEmp = ""  && tpconexao  char(1)  - Tipo de conexao da empresa
    this_cFtpAddEmp    = ""  && ftpend     char(50) - Endereco FTP da empresa
    this_cFtpUserEmp   = ""  && ftpusuario char(50) - Usuario FTP da empresa
    this_cFtpPassEmp   = ""  && ftpsenha   char(20) - Senha FTP da empresa (criptografada)
    this_cDriveTs      = ""  && drivets    char(60) - Drive/dir local de envio para FTP
    this_cDriveLs      = ""  && drivels    char(60) - Drive/dir local de recebimento do FTP
    this_cDirFtpTs     = ""  && dirftpts   char(60) - Diretorio remoto FTP de destino (envio)
    this_cDirFtpLs     = ""  && dirftpls   char(60) - Diretorio remoto FTP de origem (recebimento)
    this_lLocDel       = .F. && locdel     bit      - Excluir local apos transferencia
    this_lFtpDel       = .F. && ftpdel     bit      - Excluir do FTP apos recebimento

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPam"
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - Carrega parametros globais de SigCdPam
    * Retorno: .T. se sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosSistema()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 " + ;
                       "TpTrans, EmpMasters, GruMccrs, ConMccrs, VendNts " + ;
                       "FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                    SELECT cursor_4c_Pam
                    THIS.this_cTpTrans    = TratarNulo(TpTrans,    "C")
                    THIS.this_cEmpMasters = TratarNulo(EmpMasters, "C")
                    THIS.this_cGruMccrs   = TratarNulo(GruMccrs,   "C")
                    THIS.this_cConMccrs   = TratarNulo(ConMccrs,   "C")
                    THIS.this_cVendNts    = TratarNulo(VendNts,    "C")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Par" + CHR(226) + "metros do sistema (SigCdPam) n" + CHR(227) + "o encontrados"
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao consultar SigCdPam"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConfiguracaoEmpresa - Carrega config FTP de SigCdEmp
    * par_cCodEmp: codigo da empresa (Cemps)
    * Retorno: .T. se sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarConfiguracaoEmpresa(par_cCodEmp)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 " + ;
                       "TpConexao, FtpEnd, FtpUsuario, FtpSenha, " + ;
                       "DriveTs, DriveLs, DirFtpTs, DirFtpLs, " + ;
                       "LocDel, FtpDel " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(par_cCodEmp)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0
                IF USED("cursor_4c_Emp") AND RECCOUNT("cursor_4c_Emp") > 0
                    THIS.CarregarDoCursor("cursor_4c_Emp")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Empresa " + ALLTRIM(par_cCodEmp) + ;
                                              " n" + CHR(227) + "o cadastrada"
                ENDIF
                IF USED("cursor_4c_Emp")
                    USE IN cursor_4c_Emp
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao consultar SigCdEmp"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega config FTP do cursor SigCdEmp para this_*
    * par_cAliasCursor: nome do cursor com dados de SigCdEmp
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cTpConexaoEmp = TratarNulo(TpConexao,  "C")
                THIS.this_cFtpAddEmp    = TratarNulo(FtpEnd,     "C")
                THIS.this_cFtpUserEmp   = TratarNulo(FtpUsuario, "C")
                THIS.this_cFtpPassEmp   = TratarNulo(FtpSenha,   "C")
                THIS.this_cDriveTs      = TratarNulo(DriveTs,    "C")
                THIS.this_cDriveLs      = TratarNulo(DriveLs,    "C")
                THIS.this_cDirFtpTs     = TratarNulo(DirFtpTs,   "C")
                THIS.this_cDirFtpLs     = TratarNulo(DirFtpLs,   "C")
                THIS.this_lLocDel       = IIF(VARTYPE(LocDel) = "L", LocDel, .F.)
                THIS.this_lFtpDel       = IIF(VARTYPE(FtpDel) = "L", FtpDel, .F.)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel (form operacional sem CRUD direto)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel (form operacional - sem INSERT em tabela propria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel (form operacional - sem UPDATE em tabela propria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        RETURN .T.
    ENDPROC

ENDDEFINE

