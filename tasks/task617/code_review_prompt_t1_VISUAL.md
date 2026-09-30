# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [ALINHAMENTO] Botao 'cmd_4c_CancelaLin' tem Top=10 mas grupo usa Top=3 (diferenca de 7px)
- [ALINHAMENTO] Botao 'cmd_4c_CancelaDisp' tem Top=10 mas grupo usa Top=3 (diferenca de 7px)
- [ALINHAMENTO] Botao 'cmd_4c_CancelaDisp' tem Top=10 mas grupo usa Top=3 (diferenca de 7px)
- [ALINHAMENTO] Botao 'cmd_4c_CancelaDisp' tem Top=10 mas grupo usa Top=3 (diferenca de 7px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (4730 linhas total):

*-- Linhas 181 a 189:
181:                 IF THIS.this_oBusinessObject.this_lReserva
182:                     loc_cCaption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
183:                 ENDIF
184:                 THIS.Caption = loc_cCaption
185: 
186:                 *-- SigKey (Thisform.SigKey = CrSigCdPac.sigKeys do Init
187:                 *-- legado) - CrSigCdPac eh cursor global que o form pai ja
188:                 *-- populou, visivel aqui porque a DataSessionId eh
189:                 *-- compartilhada (ver Init acima)

*-- Linhas 195 a 204:
195: 
196:                 THIS.ConfigurarPageFrame()
197: 
198:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
199:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
200: 
201:                 *-- Carga inicial da grade principal - o bind + "Go Top" +
202:                 *-- ".Refresh" com que o Init legado termina. Passa pelo funil
203:                 *-- CarregarLista porque ConfigurarGradeItens so consegue ligar
204:                 *-- o RecordSource se TmpFinal JA existia quando o grid foi

*-- Linhas 254 a 262:
254:     *                     TornarControlesVisiveis), os campos totais da
255:     *                     grade principal (txt_4c_TotQtd/TotEst/TotPrz),
256:     *                     img_4c_ImgFigJpg (foto do item selecionado),
257:     *                     lbl_4c_TxtObsItens/obj_4c_ObsItens e os LOOKUPS
258:     *                     de SigCdPro das colunas Produto/Produto
259:     *                     substituto do grd_4c_Pedras (Valid legado ->
260:     *                     ValidarPedraProduto/ValidarPedraSubstituto +
261:     *                     AbrirLookupPedraProduto/AbrirLookupPedraSubstituto
262:     *                     via FormBuscaAuxiliar), o gate do When das

*-- Linhas 318 a 366:
318:             THIS.AddObject("cnt_4c_Sombra", "Container")
319:             loc_oCnt = THIS.cnt_4c_Sombra
320:             WITH loc_oCnt
321:                 .Top         = 0
322:                 .Left        = 0
323:                 .Width       = THIS.Width
324:                 .Height      = 80
325:                 .BorderWidth = 0
326:                 .BackColor   = RGB(100, 100, 100)
327:                 .Visible     = .T.
328:             ENDWITH
329: 
330:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
331:             WITH loc_oCnt.lbl_4c_LblSombra
332:                 .FontBold      = .T.
333:                 .FontName      = "Tahoma"
334:                 .FontSize      = 18
335:                 .FontUnderline = .F.
336:                 .WordWrap      = .T.
337:                 .Alignment     = 0
338:                 .BackStyle     = 0
339:                 .AutoSize      = .F.
340:                 .Caption       = THIS.Caption
341:                 .Height        = 40
342:                 .Left          = 10
343:                 .Top           = 18
344:                 .Width         = 769
345:                 .ForeColor     = RGB(0, 0, 0)
346:                 .Visible       = .T.
347:             ENDWITH
348: 
349:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
350:             WITH loc_oCnt.lbl_4c_LblTitulo
351:                 .FontBold  = .T.
352:                 .FontName  = "Tahoma"
353:                 .FontSize  = 18
354:                 .WordWrap  = .T.
355:                 .Alignment = 0
356:                 .BackStyle = 0
357:                 .AutoSize  = .F.
358:                 .Caption   = THIS.Caption
359:                 .Height    = 46
360:                 .Left      = 10
361:                 .Top       = 17
362:                 .Width     = 769
363:                 .ForeColor = RGB(255, 255, 255)
364:                 .Visible   = .T.
365:             ENDWITH
366:         CATCH TO loc_oErro

*-- Linhas 383 a 404:
383:         TRY
384:             THIS.AddObject("shp_4c_Shape2", "Shape")
385:             WITH THIS.shp_4c_Shape2
386:                 .Top         = 9
387:                 .Left        = 9
388:                 .Width       = 279
389:                 .Height      = 51
390:                 .BackStyle   = 0
391:                 .BorderStyle = 0
392:                 .BorderColor = RGB(136, 189, 188)
393:                 .Visible     = .T.
394:             ENDWITH
395: 
396:             THIS.AddObject("shp_4c_Shape3", "Shape")
397:             WITH THIS.shp_4c_Shape3
398:                 .Top         = 10
399:                 .Left        = 820
400:                 .Width       = 116
401:                 .Height      = 38
402:                 .BackStyle   = 0
403:                 .BorderStyle = 0
404:                 .BorderColor = RGB(136, 189, 188)

*-- Linhas 429 a 459:
429:         LOCAL loc_oErro
430: 
431:         TRY
432:             THIS.AddObject("cmd_4c_Disponivel", "CommandButton")
433:             WITH THIS.cmd_4c_Disponivel
434:                 .Top        = 3
435:                 .Left       = 622
436:                 .Width      = 75
437:                 .Height     = 75
438:                 .FontBold   = .T.
439:                 .FontItalic = .T.
440:                 .FontName   = "Comic Sans MS"
441:                 .FontSize   = 8
442:                 .WordWrap   = .T.
443:                 .Picture    = gc_4c_CaminhoIcones + "geral_palete_60.jpg"
444:                 .Caption    = "\<Disponiveis"
445:                 .ForeColor  = RGB(90, 90, 90)
446:                 .BackColor  = RGB(255, 255, 255)
447:                 .Themes     = .F.
448:                 .Visible    = .T.
449:             ENDWITH
450: 
451:             THIS.AddObject("cmd_4c_Pedras", "CommandButton")
452:             WITH THIS.cmd_4c_Pedras
453:                 .Top             = 3
454:                 .Left            = 472
455:                 .Width           = 75
456:                 .Height          = 75
457:                 .FontBold        = .T.
458:                 .FontItalic      = .T.
459:                 .FontName        = "Comic Sans MS"

*-- Linhas 466 a 474:
466:                 *-- +Themes=.F. perde o icone em VFP9 (CorretorAutomatico #99)
467:                 .Themes          = .T.
468:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
469:                 .Caption         = "\<Requisi" + CHR(231) + CHR(245) + "es"
470:                 .ForeColor       = RGB(90, 90, 90)
471:                 .BackColor       = RGB(255, 255, 255)
472:                 .Visible         = .T.
473:                 *-- Habilitado so quando o SigCdPam tem as 4 colunas de
474:                 *-- transferencia preenchidas e NAO eh Reserva Automatica

*-- Linhas 481 a 579:
481:                                     !THIS.this_oBusinessObject.this_lReserva
482:             ENDWITH
483: 
484:             THIS.AddObject("cmd_4c_SelEstoque", "CommandButton")
485:             WITH THIS.cmd_4c_SelEstoque
486:                 .Top             = 3
487:                 .Left            = 547
488:                 .Width           = 75
489:                 .Height          = 75
490:                 .FontBold        = .T.
491:                 .FontItalic      = .T.
492:                 .FontName        = "Comic Sans MS"
493:                 .FontSize        = 8
494:                 .WordWrap        = .T.
495:                 .Picture         = gc_4c_CaminhoIcones + "geral_marcar_60.jpg"
496:                 .Caption         = "\<Estoques"
497:                 .PicturePosition = 13
498:                 .ForeColor       = RGB(90, 90, 90)
499:                 .BackColor       = RGB(255, 255, 255)
500:                 .Themes          = .F.
501:                 .Visible         = .T.
502:             ENDWITH
503: 
504:             THIS.AddObject("cmd_4c_TotLinha", "CommandButton")
505:             WITH THIS.cmd_4c_TotLinha
506:                 .Top        = 3
507:                 .Left       = 697
508:                 .Width      = 75
509:                 .Height     = 75
510:                 .FontBold   = .T.
511:                 .FontItalic = .T.
512:                 .FontName   = "Comic Sans MS"
513:                 .FontSize   = 8
514:                 .WordWrap   = .T.
515:                 .Picture    = gc_4c_CaminhoIcones + "geral_grafico_pizza_60.jpg"
516:                 .Caption    = "\<Total/Linhas"
517:                 .ForeColor  = RGB(90, 90, 90)
518:                 .BackColor  = RGB(255, 255, 255)
519:                 .Themes     = .F.
520:                 .Visible    = .T.
521:             ENDWITH
522: 
523:             THIS.AddObject("cmd_4c_BtnRelatorio", "CommandButton")
524:             WITH THIS.cmd_4c_BtnRelatorio
525:                 .Top        = 3
526:                 .Left       = 772
527:                 .Width      = 75
528:                 .Height     = 75
529:                 .FontBold   = .T.
530:                 .FontItalic = .T.
531:                 .FontName   = "Comic Sans MS"
532:                 .FontSize   = 8
533:                 .WordWrap   = .T.
534:                 .Picture    = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
535:                 .Caption    = "\<Relat" + CHR(243) + "rio"
536:                 .ForeColor  = RGB(90, 90, 90)
537:                 .BackColor  = RGB(255, 255, 255)
538:                 .Themes     = .F.
539:                 .Visible    = .T.
540:             ENDWITH
541: 
542:             THIS.AddObject("cmd_4c_Processar", "CommandButton")
543:             WITH THIS.cmd_4c_Processar
544:                 .Top        = 3
545:                 .Left       = 847
546:                 .Width      = 75
547:                 .Height     = 75
548:                 .FontBold   = .T.
549:                 .FontItalic = .T.
550:                 .FontName   = "Comic Sans MS"
551:                 .FontSize   = 8
552:                 .WordWrap   = .T.
553:                 .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
554:                 .Caption    = "\<Processar"
555:                 .ForeColor  = RGB(90, 90, 90)
556:                 .BackColor  = RGB(255, 255, 255)
557:                 .Themes     = .F.
558:                 .Visible    = .T.
559:             ENDWITH
560: 
561:             THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
562:             WITH THIS.cmd_4c_Cancelar
563:                 .Top        = 3
564:                 .Left       = 922
565:                 .Width      = 75
566:                 .Height     = 75
567:                 .FontBold   = .T.
568:                 .FontItalic = .T.
569:                 .FontName   = "Comic Sans MS"
570:                 .FontSize   = 8
571:                 .WordWrap   = .T.
572:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
573:                 .Cancel     = .T.
574:                 .Caption    = "Sair"
575:                 .ForeColor  = RGB(90, 90, 90)
576:                 .BackColor  = RGB(255, 255, 255)
577:                 .Themes     = .F.
578:                 .Visible    = .T.
579:             ENDWITH

*-- Linhas 616 a 625:
616:         TRY
617:             THIS.AddObject("grd_4c_Itens", "Grid")
618:             WITH THIS.grd_4c_Itens
619:                 .Top               = 125
620:                 .Left              = 11
621:                 .Width             = 708
622:                 .Height            = 224
623:                 .FontName          = "Verdana"
624:                 .FontSize          = 8
625:                 .AllowHeaderSizing = .F.

*-- Linhas 647 a 655:
647:                 .Column1.Header1.FontSize  = 8
648:                 .Column1.Header1.Alignment = 2
649:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
650:                 .Column1.Header1.Caption   = "Produto"
651:                 .Column1.Text1.FontSize    = 8
652:                 .Column1.Text1.BorderStyle = 0
653:                 .Column1.Text1.Margin      = 0
654:                 .Column1.Text1.ReadOnly    = .T.
655:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 667 a 675:
667:                 .Column2.Header1.FontSize  = 8
668:                 .Column2.Header1.Alignment = 2
669:                 .Column2.Header1.ForeColor = RGB(36, 84, 155)
670:                 .Column2.Header1.Caption   = "Cor"
671:                 .Column2.Text1.FontSize    = 8
672:                 .Column2.Text1.BorderStyle = 0
673:                 .Column2.Text1.Margin      = 0
674:                 .Column2.Text1.ReadOnly    = .T.
675:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 689 a 697:
689:                 .Column3.Header1.FontSize  = 8
690:                 .Column3.Header1.Alignment = 2
691:                 .Column3.Header1.ForeColor = RGB(36, 84, 155)
692:                 .Column3.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
693:                 .Column3.Text1.FontSize    = 8
694:                 .Column3.Text1.BorderStyle = 0
695:                 .Column3.Text1.Margin      = 0
696:                 .Column3.Text1.ReadOnly    = .T.
697:                 .Column3.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 710 a 718:
710:                 .Column4.Header1.FontSize  = 8
711:                 .Column4.Header1.Alignment = 2
712:                 .Column4.Header1.ForeColor = RGB(36, 84, 155)
713:                 .Column4.Header1.Caption   = "C" + CHR(243) + "digo"
714:                 .Column4.Text1.FontBold    = .T.
715:                 .Column4.Text1.FontSize    = 8
716:                 .Column4.Text1.Alignment   = 2
717:                 .Column4.Text1.BorderStyle = 0
718:                 .Column4.Text1.Margin      = 0

*-- Linhas 733 a 741:
733:                 .Column5.Header1.FontSize  = 8
734:                 .Column5.Header1.Alignment = 2
735:                 .Column5.Header1.ForeColor = RGB(36, 84, 155)
736:                 .Column5.Header1.Caption   = "Quantidade"
737:                 .Column5.Text1.FontBold    = .T.
738:                 .Column5.Text1.FontSize    = 8
739:                 .Column5.Text1.BorderStyle = 0
740:                 .Column5.Text1.Margin      = 0
741:                 .Column5.Text1.ReadOnly    = .T.

*-- Linhas 758 a 766:
758:                 .Column6.Header1.FontSize  = 8
759:                 .Column6.Header1.Alignment = 2
760:                 .Column6.Header1.ForeColor = RGB(36, 84, 155)
761:                 .Column6.Header1.Caption   = "Produzir"
762:                 .Column6.Text1.FontBold    = .T.
763:                 .Column6.Text1.FontSize    = 8
764:                 .Column6.Text1.BorderStyle = 0
765:                 .Column6.Text1.Margin      = 0
766:                 .Column6.Text1.ReadOnly    = .F.

*-- Linhas 779 a 787:
779:                 .Column7.Header1.FontSize  = 8
780:                 .Column7.Header1.Alignment = 2
781:                 .Column7.Header1.ForeColor = RGB(36, 84, 155)
782:                 .Column7.Header1.Caption   = "Estoque"
783:                 .Column7.Text1.FontSize    = 8
784:                 .Column7.Text1.BorderStyle = 0
785:                 .Column7.Text1.Margin      = 0
786:                 .Column7.Text1.ReadOnly    = .T.
787:                 .Column7.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 799 a 807:
799:                 .Column8.Header1.FontSize  = 8
800:                 .Column8.Header1.Alignment = 2
801:                 .Column8.Header1.ForeColor = RGB(36, 84, 155)
802:                 .Column8.Header1.Caption   = "Obs"
803:                 .Column8.Text1.FontSize    = 8
804:                 .Column8.Text1.BorderStyle = 0
805:                 .Column8.Text1.Margin      = 0
806:                 .Column8.Text1.ReadOnly    = .T.
807:                 .Column8.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 819 a 827:
819:                 .Column9.Header1.FontSize  = 8
820:                 .Column9.Header1.Alignment = 2
821:                 .Column9.Header1.ForeColor = RGB(36, 84, 155)
822:                 .Column9.Header1.Caption   = "Tam"
823:                 .Column9.Text1.FontSize    = 8
824:                 .Column9.Text1.BorderStyle = 0
825:                 .Column9.Text1.Margin      = 0
826:                 .Column9.Text1.ReadOnly    = .T.
827:                 .Column9.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 836 a 844:
836: 
837:     *--------------------------------------------------------------------------
838:     * ConfigurarContainer1 - "Pecas a produzir por linha" (Container1 no
839:     * legado), alternado pelo botao cmd_4c_TotLinha (Fase 7-8). Grid
840:     * grd_4c_Linhas 100% somente-leitura (o proprio Grid tem .ReadOnly=.T.
841:     * no dump, alem de cada Column) - Column1..4.ControlSource ficam vazios
842:     * de proposito (assim declarado no SCX): TotLinha.Click monta o cursor
843:     * TmpLinha e liga RecordSource/ControlSource em runtime (Fase 7-8),
844:     * igual ao legado.

*-- Linhas 850 a 908:
850:             THIS.AddObject("cnt_4c_Container1", "Container")
851:             loc_oCnt = THIS.cnt_4c_Container1
852:             WITH loc_oCnt
853:                 .Top           = 125
854:                 .Left          = 12
855:                 .Width         = 708
856:                 .Height        = 465
857:                 .SpecialEffect = 0
858:                 .BackColor     = RGB(255, 255, 255)
859:                 .Visible       = .F.
860:             ENDWITH
861: 
862:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
863:             WITH loc_oCnt.lbl_4c_Label1
864:                 .FontBold  = .T.
865:                 .FontName  = "Tahoma"
866:                 .FontSize  = 10
867:                 .Alignment = 0
868:                 .BackStyle = 0
869:                 .AutoSize  = .F.
870:                 .Caption   = "Pe" + CHR(231) + "as a produzir por linha"
871:                 .Height    = 18
872:                 .Left      = 259
873:                 .Top       = 10
874:                 .Width     = 170
875:                 .ForeColor = RGB(90, 90, 90)
876:                 .Visible   = .T.
877:             ENDWITH
878: 
879:             loc_oCnt.AddObject("cmd_4c_CancelaLin", "CommandButton")
880:             WITH loc_oCnt.cmd_4c_CancelaLin
881:                 .Top         = 10
882:                 .Left        = 620
883:                 .Height      = 75
884:                 .Width       = 75
885:                 .FontBold    = .T.
886:                 .FontItalic  = .T.
887:                 .FontName    = "Comic Sans MS"
888:                 .FontSize    = 8
889:                 .WordWrap    = .T.
890:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
891:                 .Cancel      = .T.
892:                 .Caption     = "OK"
893:                 .ToolTipText = "[ESC] - Encerrar"
894:                 .ForeColor   = RGB(90, 90, 90)
895:                 .BackColor   = RGB(255, 255, 255)
896:                 .Themes      = .F.
897:                 .Visible     = .T.
898:             ENDWITH
899: 
900:             loc_oCnt.AddObject("grd_4c_Linhas", "Grid")
901:             WITH loc_oCnt.grd_4c_Linhas
902:                 .Top               = 32
903:                 .Left              = 174
904:                 .Width             = 359
905:                 .Height            = 420
906:                 .FontSize          = 8
907:                 .AllowHeaderSizing = .F.
908:                 .AllowRowSizing    = .F.

*-- Linhas 927 a 935:
927:                 .Column1.Header1.FontSize  = 8
928:                 .Column1.Header1.Alignment = 2
929:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
930:                 .Column1.Header1.Caption   = "Linha"
931:                 .Column1.Text1.FontName    = "Arial"
932:                 .Column1.Text1.FontSize    = 8
933:                 .Column1.Text1.BorderStyle = 0
934:                 .Column1.Text1.Margin      = 0
935:                 .Column1.Text1.ReadOnly    = .T.

*-- Linhas 947 a 955:
947:                 .Column2.Header1.FontSize  = 8
948:                 .Column2.Header1.Alignment = 2
949:                 .Column2.Header1.ForeColor = RGB(36, 84, 155)
950:                 .Column2.Header1.Caption   = "Quantidade"
951:                 .Column2.Text1.FontSize    = 8
952:                 .Column2.Text1.BorderStyle = 0
953:                 .Column2.Text1.InputMask   = "999,999.99"
954:                 .Column2.Text1.Margin      = 0
955:                 .Column2.Text1.MaxLength   = 10

*-- Linhas 968 a 976:
968:                 .Column3.Header1.FontSize  = 8
969:                 .Column3.Header1.Alignment = 2
970:                 .Column3.Header1.ForeColor = RGB(36, 84, 155)
971:                 .Column3.Header1.Caption   = "Estoque"
972:                 .Column3.Text1.FontName    = "Arial"
973:                 .Column3.Text1.FontSize    = 8
974:                 .Column3.Text1.BorderStyle = 0
975:                 .Column3.Text1.InputMask   = "999,999.99"
976:                 .Column3.Text1.Margin      = 0

*-- Linhas 990 a 998:
990:                 .Column4.Header1.FontSize  = 8
991:                 .Column4.Header1.Alignment = 2
992:                 .Column4.Header1.ForeColor = RGB(36, 84, 155)
993:                 .Column4.Header1.Caption   = "Produzir"
994:                 .Column4.Text1.FontName    = "Arial"
995:                 .Column4.Text1.FontSize    = 8
996:                 .Column4.Text1.BorderStyle = 0
997:                 .Column4.Text1.InputMask   = "999,999.99"
998:                 .Column4.Text1.Margin      = 0

*-- Linhas 1010 a 1075:
1010: 
1011:     *--------------------------------------------------------------------------
1012:     * ConfigurarContainer2 - "Estoque Disponivel" por PRODUTO/COR/TAM,
1013:     * alternado pelo botao cmd_4c_Disponivel (Fase 7-8). RecordSource/
1014:     * ControlSource ficam de fora aqui (o SCX nao declara ControlSource
1015:     * estatico para estas colunas - o Click do legado monta TmpDisp e liga
1016:     * tudo em runtime, mesmo padrao do Container5).
1017:     *--------------------------------------------------------------------------
1018:     PROTECTED PROCEDURE ConfigurarContainer2()
1019:         LOCAL loc_oCnt, loc_oErro
1020: 
1021:         TRY
1022:             THIS.AddObject("cnt_4c_Container2", "Container")
1023:             loc_oCnt = THIS.cnt_4c_Container2
1024:             WITH loc_oCnt
1025:                 .Top           = 125
1026:                 .Left          = 12
1027:                 .Width         = 708
1028:                 .Height        = 465
1029:                 .SpecialEffect = 0
1030:                 .BackColor     = RGB(255, 255, 255)
1031:                 .Visible       = .F.
1032:             ENDWITH
1033: 
1034:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1035:             WITH loc_oCnt.lbl_4c_Label1
1036:                 .FontBold  = .T.
1037:                 .FontName  = "Tahoma"
1038:                 .FontSize  = 10
1039:                 .BackStyle = 0
1040:                 .AutoSize  = .F.
1041:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
1042:                 .Height    = 18
1043:                 .Left      = 284
1044:                 .Top       = 10
1045:                 .Width     = 123
1046:                 .ForeColor = RGB(90, 90, 90)
1047:                 .Visible   = .T.
1048:             ENDWITH
1049: 
1050:             loc_oCnt.AddObject("cmd_4c_CancelaDisp", "CommandButton")
1051:             WITH loc_oCnt.cmd_4c_CancelaDisp
1052:                 .Top       = 10
1053:                 .Left      = 620
1054:                 .Height    = 75
1055:                 .Width     = 75
1056:                 .FontName  = "Comic Sans MS"
1057:                 .FontSize  = 8
1058:                 .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1059:                 .Cancel    = .T.
1060:                 .Caption   = "Sair"
1061:                 .ForeColor = RGB(90, 90, 90)
1062:                 .BackColor = RGB(255, 255, 255)
1063:                 .Themes    = .F.
1064:                 .Visible   = .T.
1065:             ENDWITH
1066: 
1067:             loc_oCnt.AddObject("grd_4c_DispProduto", "Grid")
1068:             WITH loc_oCnt.grd_4c_DispProduto
1069:                 .Top               = 32
1070:                 .Left              = 169
1071:                 .Width             = 370
1072:                 .Height            = 388
1073:                 .FontSize          = 8
1074:                 .AllowHeaderSizing = .F.
1075:                 .AllowRowSizing    = .F.

*-- Linhas 1092 a 1100:
1092:                 .Column1.Header1.FontSize  = 8
1093:                 .Column1.Header1.Alignment = 2
1094:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
1095:                 .Column1.Header1.Caption   = "Produto"
1096:                 .Column1.Text1.FontSize    = 8
1097:                 .Column1.Text1.BorderStyle = 0
1098:                 .Column1.Text1.Margin      = 0
1099:                 .Column1.Text1.ReadOnly    = .T.
1100:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1111 a 1119:
1111:                 .Column2.Header1.FontSize  = 8
1112:                 .Column2.Header1.Alignment = 2
1113:                 .Column2.Header1.ForeColor = RGB(36, 84, 155)
1114:                 .Column2.Header1.Caption   = "Cor"
1115:                 .Column2.Text1.FontBold    = .T.
1116:                 .Column2.Text1.FontSize    = 8
1117:                 .Column2.Text1.BorderStyle = 0
1118:                 .Column2.Text1.Margin      = 0
1119:                 .Column2.Text1.ReadOnly    = .T.

*-- Linhas 1131 a 1139:
1131:                 .Column3.Header1.FontSize  = 8
1132:                 .Column3.Header1.Alignment = 2
1133:                 .Column3.Header1.ForeColor = RGB(36, 84, 155)
1134:                 .Column3.Header1.Caption   = "Tam"
1135:                 .Column3.Text1.FontBold    = .T.
1136:                 .Column3.Text1.FontSize    = 8
1137:                 .Column3.Text1.BorderStyle = 0
1138:                 .Column3.Text1.Margin      = 0
1139:                 .Column3.Text1.ReadOnly    = .T.

*-- Linhas 1150 a 1158:
1150:                 .Column4.Header1.FontSize  = 8
1151:                 .Column4.Header1.Alignment = 2
1152:                 .Column4.Header1.ForeColor = RGB(36, 84, 155)
1153:                 .Column4.Header1.Caption   = "Disponivel"
1154:                 .Column4.Text1.FontSize    = 8
1155:                 .Column4.Text1.BorderStyle = 0
1156:                 .Column4.Text1.Margin      = 0
1157:                 .Column4.Text1.ReadOnly    = .T.
1158:                 .Column4.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1169 a 1235:
1169:                 .Column5.Header1.FontSize  = 8
1170:                 .Column5.Header1.Alignment = 2
1171:                 .Column5.Header1.ForeColor = RGB(36, 84, 155)
1172:                 .Column5.Header1.Caption   = "Utilizar"
1173:                 .Column5.Text1.FontBold    = .T.
1174:                 .Column5.Text1.FontSize    = 8
1175:                 .Column5.Text1.BorderStyle = 0
1176:                 .Column5.Text1.Margin      = 0
1177:                 .Column5.Text1.ReadOnly    = .F.
1178:                 .Column5.Text1.ForeColor   = RGB(0, 0, 0)
1179:                 .Column5.Text1.BackColor   = RGB(255, 255, 255)
1180:             ENDWITH
1181: 
1182:             loc_oCnt.AddObject("lbl_4c_Label2", "Label")
1183:             WITH loc_oCnt.lbl_4c_Label2
1184:                 .FontName  = "Tahoma"
1185:                 .FontSize  = 8
1186:                 .BackStyle = 0
1187:                 .AutoSize  = .F.
1188:                 .Caption   = "Qtde " + CHR(224) + " Produzir :"
1189:                 .Height    = 15
1190:                 .Left      = 168
1191:                 .Top       = 432
1192:                 .Width     = 84
1193:                 .ForeColor = RGB(90, 90, 90)
1194:                 .Visible   = .T.
1195:             ENDWITH
1196: 
1197:             loc_oCnt.AddObject("lbl_4c_Label3", "Label")
1198:             WITH loc_oCnt.lbl_4c_Label3
1199:                 .FontName  = "Tahoma"
1200:                 .FontSize  = 8
1201:                 .BackStyle = 0
1202:                 .AutoSize  = .F.
1203:                 .Caption   = "Qtde " + CHR(224) + " Utilizar :"
1204:                 .Height    = 17
1205:                 .Left      = 365
1206:                 .Top       = 431
1207:                 .Width     = 109
1208:                 .ForeColor = RGB(90, 90, 90)
1209:                 .Visible   = .T.
1210:             ENDWITH
1211: 
1212:             loc_oCnt.AddObject("txt_4c_QtSelec", "TextBox")
1213:             WITH loc_oCnt.txt_4c_QtSelec
1214:                 .Height        = 23
1215:                 .Width         = 80
1216:                 .Left          = 458
1217:                 .Top           = 428
1218:                 .InputMask     = "9,999.99"
1219:                 .SpecialEffect = 1
1220:                 .Value         = 0
1221:                 .ReadOnly      = .T.
1222:                 .Visible       = .T.
1223:             ENDWITH
1224: 
1225:             loc_oCnt.AddObject("txt_4c_QtPedida", "TextBox")
1226:             WITH loc_oCnt.txt_4c_QtPedida
1227:                 .Height        = 23
1228:                 .Width         = 80
1229:                 .Left          = 268
1230:                 .Top           = 428
1231:                 .InputMask     = "9,999.99"
1232:                 .SpecialEffect = 1
1233:                 .Value         = 0
1234:                 .ReadOnly      = .T.
1235:                 .Visible       = .T.

*-- Linhas 1243 a 1312:
1243: 
1244:     *--------------------------------------------------------------------------
1245:     * ConfigurarContainer5 - "Estoque Disponivel" por GRUPO/CONTA, alternado
1246:     * pelo botao cmd_4c_SelEstoque ("Estoques" - Fase 7-8). O ColumnOrder do
1247:     * grid NAO acompanha a ordem de declaracao das colunas (Column3/
1248:     * Prioridade eh a PRIMEIRA visualmente - ColumnOrder=1) - transcrito
1249:     * literal do dump, nao "corrigido".
1250:     *--------------------------------------------------------------------------
1251:     PROTECTED PROCEDURE ConfigurarContainer5()
1252:         LOCAL loc_oCnt, loc_oErro
1253: 
1254:         TRY
1255:             THIS.AddObject("cnt_4c_Container5", "Container")
1256:             loc_oCnt = THIS.cnt_4c_Container5
1257:             WITH loc_oCnt
1258:                 .Top           = 125
1259:                 .Left          = 12
1260:                 .Width         = 708
1261:                 .Height        = 465
1262:                 .SpecialEffect = 0
1263:                 .BackColor     = RGB(255, 255, 255)
1264:                 .Visible       = .F.
1265:             ENDWITH
1266: 
1267:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1268:             WITH loc_oCnt.lbl_4c_Label1
1269:                 .FontBold  = .T.
1270:                 .FontName  = "Tahoma"
1271:                 .FontSize  = 10
1272:                 .BackStyle = 0
1273:                 .AutoSize  = .F.
1274:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
1275:                 .Height    = 18
1276:                 .Left      = 284
1277:                 .Top       = 10
1278:                 .Width     = 123
1279:                 .ForeColor = RGB(90, 90, 90)
1280:                 .Visible   = .T.
1281:             ENDWITH
1282: 
1283:             loc_oCnt.AddObject("cmd_4c_CancelaDisp", "CommandButton")
1284:             WITH loc_oCnt.cmd_4c_CancelaDisp
1285:                 .Top         = 10
1286:                 .Left        = 620
1287:                 .Height      = 75
1288:                 .Width       = 75
1289:                 .FontBold    = .T.
1290:                 .FontItalic  = .T.
1291:                 .FontName    = "Comic Sans MS"
1292:                 .FontSize    = 8
1293:                 .WordWrap    = .T.
1294:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1295:                 .Cancel      = .T.
1296:                 .Caption     = "OK"
1297:                 .ToolTipText = "[ESC] - Encerrar"
1298:                 .ForeColor   = RGB(90, 90, 90)
1299:                 .BackColor   = RGB(255, 255, 255)
1300:                 .Themes      = .F.
1301:                 .Visible     = .T.
1302:             ENDWITH
1303: 
1304:             loc_oCnt.AddObject("grd_4c_DispGrupo", "Grid")
1305:             WITH loc_oCnt.grd_4c_DispGrupo
1306:                 .Top               = 32
1307:                 .Left              = 141
1308:                 .Width             = 425
1309:                 .Height            = 372
1310:                 .FontSize          = 8
1311:                 .AllowHeaderSizing = .F.
1312:                 .AllowRowSizing    = .F.

*-- Linhas 1329 a 1337:
1329:                 .Column1.Header1.FontSize  = 8
1330:                 .Column1.Header1.Alignment = 2
1331:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
1332:                 .Column1.Header1.Caption   = "Grupo"
1333:                 .Column1.Text1.FontSize    = 8
1334:                 .Column1.Text1.BorderStyle = 0
1335:                 .Column1.Text1.Margin      = 0
1336:                 .Column1.Text1.ReadOnly    = .T.
1337:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1347 a 1355:
1347:                 .Column2.Header1.FontSize  = 8
1348:                 .Column2.Header1.Alignment = 2
1349:                 .Column2.Header1.ForeColor = RGB(36, 84, 155)
1350:                 .Column2.Header1.Caption   = "Conta"
1351:                 .Column2.Text1.FontBold    = .F.
1352:                 .Column2.Text1.FontSize    = 8
1353:                 .Column2.Text1.BorderStyle = 0
1354:                 .Column2.Text1.Margin      = 0
1355:                 .Column2.Text1.ReadOnly    = .T.

*-- Linhas 1366 a 1374:
1366:                 .Column3.Header1.FontSize  = 8
1367:                 .Column3.Header1.Alignment = 2
1368:                 .Column3.Header1.ForeColor = RGB(36, 84, 155)
1369:                 .Column3.Header1.Caption   = "Prioridade"
1370:                 .Column3.Text1.FontBold    = .F.
1371:                 .Column3.Text1.FontSize    = 8
1372:                 .Column3.Text1.BorderStyle = 0
1373:                 .Column3.Text1.Margin      = 0
1374:                 .Column3.Text1.ReadOnly    = .T.

*-- Linhas 1385 a 1393:
1385:                 .Column4.Header1.FontSize  = 8
1386:                 .Column4.Header1.Alignment = 2
1387:                 .Column4.Header1.ForeColor = RGB(36, 84, 155)
1388:                 .Column4.Header1.Caption   = "Dispon" + CHR(237) + "vel"
1389:                 .Column4.Text1.FontSize    = 8
1390:                 .Column4.Text1.BorderStyle = 0
1391:                 .Column4.Text1.Margin      = 0
1392:                 .Column4.Text1.ReadOnly    = .T.
1393:                 .Column4.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1404 a 1524:
1404:                 .Column5.Header1.FontSize  = 8
1405:                 .Column5.Header1.Alignment = 2
1406:                 .Column5.Header1.ForeColor = RGB(36, 84, 155)
1407:                 .Column5.Header1.Caption   = "Utilizar"
1408:                 .Column5.Text1.FontBold    = .T.
1409:                 .Column5.Text1.FontSize    = 8
1410:                 .Column5.Text1.Alignment   = 3
1411:                 .Column5.Text1.BorderStyle = 0
1412:                 .Column5.Text1.Value       = 0
1413:                 .Column5.Text1.Margin      = 0
1414:                 .Column5.Text1.ReadOnly    = .F.
1415:                 .Column5.Text1.ForeColor   = RGB(0, 0, 0)
1416:                 .Column5.Text1.BackColor   = RGB(255, 255, 255)
1417:             ENDWITH
1418: 
1419:             loc_oCnt.AddObject("lbl_4c_Label2", "Label")
1420:             WITH loc_oCnt.lbl_4c_Label2
1421:                 .FontName  = "Tahoma"
1422:                 .FontSize  = 8
1423:                 .BackStyle = 0
1424:                 .AutoSize  = .F.
1425:                 .Caption   = "Produzir :"
1426:                 .Height    = 15
1427:                 .Left      = 428
1428:                 .Top       = 413
1429:                 .Width     = 48
1430:                 .ForeColor = RGB(90, 90, 90)
1431:                 .Visible   = .T.
1432:             ENDWITH
1433: 
1434:             loc_oCnt.AddObject("lbl_4c_Label3", "Label")
1435:             WITH loc_oCnt.lbl_4c_Label3
1436:                 .FontName  = "Tahoma"
1437:                 .FontSize  = 8
1438:                 .BackStyle = 0
1439:                 .AutoSize  = .F.
1440:                 .Caption   = "Utilizar :"
1441:                 .Height    = 15
1442:                 .Left      = 435
1443:                 .Top       = 438
1444:                 .Width     = 41
1445:                 .ForeColor = RGB(90, 90, 90)
1446:                 .Visible   = .T.
1447:             ENDWITH
1448: 
1449:             loc_oCnt.AddObject("lbl_4c_Label4", "Label")
1450:             WITH loc_oCnt.lbl_4c_Label4
1451:                 .FontName  = "Tahoma"
1452:                 .FontSize  = 8
1453:                 .BackStyle = 0
1454:                 .AutoSize  = .F.
1455:                 .Caption   = "Grupo :"
1456:                 .Height    = 15
1457:                 .Left      = 93
1458:                 .Top       = 413
1459:                 .Width     = 38
1460:                 .ForeColor = RGB(90, 90, 90)
1461:                 .Visible   = .T.
1462:             ENDWITH
1463: 
1464:             loc_oCnt.AddObject("lbl_4c_Label5", "Label")
1465:             WITH loc_oCnt.lbl_4c_Label5
1466:                 .FontName  = "Tahoma"
1467:                 .FontSize  = 8
1468:                 .BackStyle = 0
1469:                 .AutoSize  = .F.
1470:                 .Caption   = "Conta :"
1471:                 .Height    = 15
1472:                 .Left      = 93
1473:                 .Top       = 438
1474:                 .Width     = 38
1475:                 .ForeColor = RGB(90, 90, 90)
1476:                 .Visible   = .T.
1477:             ENDWITH
1478: 
1479:             loc_oCnt.AddObject("txt_4c_GetDGrupo", "TextBox")
1480:             WITH loc_oCnt.txt_4c_GetDGrupo
1481:                 .Height        = 23
1482:                 .Width         = 277
1483:                 .Left          = 141
1484:                 .Top           = 409
1485:                 .SpecialEffect = 1
1486:                 .ReadOnly      = .T.
1487:                 .Visible       = .T.
1488:             ENDWITH
1489: 
1490:             loc_oCnt.AddObject("txt_4c_GetDConta", "TextBox")
1491:             WITH loc_oCnt.txt_4c_GetDConta
1492:                 .Height        = 23
1493:                 .Width         = 277
1494:                 .Left          = 141
1495:                 .Top           = 434
1496:                 .SpecialEffect = 1
1497:                 .ReadOnly      = .T.
1498:                 .Visible       = .T.
1499:             ENDWITH
1500: 
1501:             loc_oCnt.AddObject("txt_4c_QtPedida", "TextBox")
1502:             WITH loc_oCnt.txt_4c_QtPedida
1503:                 .Height        = 23
1504:                 .Width         = 80
1505:                 .Left          = 486
1506:                 .Top           = 409
1507:                 .InputMask     = "9,999.99"
1508:                 .SpecialEffect = 1
1509:                 .Value         = 0
1510:                 .ReadOnly      = .T.
1511:                 .Visible       = .T.
1512:             ENDWITH
1513: 
1514:             loc_oCnt.AddObject("txt_4c_QtSelec", "TextBox")
1515:             WITH loc_oCnt.txt_4c_QtSelec
1516:                 .Height        = 23
1517:                 .Width         = 80
1518:                 .Left          = 486
1519:                 .Top           = 434
1520:                 .InputMask     = "9,999.99"
1521:                 .SpecialEffect = 1
1522:                 .Value         = 0
1523:                 .ReadOnly      = .T.
1524:                 .Visible       = .T.

*-- Linhas 1532 a 1540:
1532: 
1533:     *--------------------------------------------------------------------------
1534:     * ConfigurarContainer4 - "Requisicao de componentes adicionais"
1535:     * (Container4 no legado), alternado pelo botao cmd_4c_Pedras (Fase 7-8).
1536:     * Grid grd_4c_Pedras liga em runtime ao cursor SelPedra montado pelo
1537:     * Click (mesmo padrao de RecordSource/ControlSource vazio ja usado nos
1538:     * Containers 1/2/5) - Pedras.Click faz .RecordSource='SelPedra' e liga
1539:     * Column1..5 a Cpros/Dpros/Cunis/Qtds/Cpro2s.
1540:     *

*-- Linhas 1554 a 1607:
1554:             THIS.AddObject("cnt_4c_Container4", "Container")
1555:             loc_oCnt = THIS.cnt_4c_Container4
1556:             WITH loc_oCnt
1557:                 .Top           = 125
1558:                 .Left          = 12
1559:                 .Width         = 708
1560:                 .Height        = 465
1561:                 .SpecialEffect = 0
1562:                 .BackColor     = RGB(255, 255, 255)
1563:                 .Visible       = .F.
1564:             ENDWITH
1565: 
1566:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1567:             WITH loc_oCnt.lbl_4c_Label1
1568:                 .FontBold  = .T.
1569:                 .FontName  = "Tahoma"
1570:                 .FontSize  = 10
1571:                 .BackStyle = 0
1572:                 .AutoSize  = .F.
1573:                 .Caption   = "Requisi" + CHR(231) + CHR(227) + "o de componentes adicionais"
1574:                 .Height    = 18
1575:                 .Left      = 229
1576:                 .Top       = 8
1577:                 .Width     = 249
1578:                 .ForeColor = RGB(90, 90, 90)
1579:                 .Visible   = .T.
1580:             ENDWITH
1581: 
1582:             loc_oCnt.AddObject("cmd_4c_CancelaDisp", "CommandButton")
1583:             WITH loc_oCnt.cmd_4c_CancelaDisp
1584:                 .Top       = 10
1585:                 .Left      = 620
1586:                 .Height    = 75
1587:                 .Width     = 75
1588:                 .FontName  = "Comic Sans MS"
1589:                 .FontSize  = 8
1590:                 .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1591:                 .Cancel    = .T.
1592:                 .Caption   = "Sair"
1593:                 .ForeColor = RGB(90, 90, 90)
1594:                 .BackColor = RGB(255, 255, 255)
1595:                 .Themes    = .F.
1596:                 .Visible   = .T.
1597:             ENDWITH
1598: 
1599:             loc_oCnt.AddObject("grd_4c_Pedras", "Grid")
1600:             WITH loc_oCnt.grd_4c_Pedras
1601:                 .Top               = 32
1602:                 .Left              = 9
1603:                 .Width             = 605
1604:                 .Height            = 420
1605:                 .FontSize          = 8
1606:                 .AllowHeaderSizing = .F.
1607:                 .AllowRowSizing    = .F.

*-- Linhas 1626 a 1634:
1626:                 .Column1.Header1.FontSize  = 8
1627:                 .Column1.Header1.Alignment = 2
1628:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
1629:                 .Column1.Header1.Caption   = "Produto"
1630:                 .Column1.Text1.FontSize    = 8
1631:                 .Column1.Text1.BorderStyle = 0
1632:                 .Column1.Text1.Margin      = 0
1633:                 .Column1.Text1.ReadOnly    = .F.
1634:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1645 a 1653:
1645:                 .Column2.Header1.FontSize  = 8
1646:                 .Column2.Header1.Alignment = 2
1647:                 .Column2.Header1.ForeColor = RGB(36, 84, 155)
1648:                 .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1649:                 .Column2.Text1.FontSize    = 8
1650:                 .Column2.Text1.BorderStyle = 0
1651:                 .Column2.Text1.Margin      = 0
1652:                 .Column2.Text1.ReadOnly    = .T.
1653:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1664 a 1672:
1664:                 .Column3.Header1.FontSize  = 8
1665:                 .Column3.Header1.Alignment = 2
1666:                 .Column3.Header1.ForeColor = RGB(36, 84, 155)
1667:                 .Column3.Header1.Caption   = "Uni"
1668:                 .Column3.Text1.FontSize    = 8
1669:                 .Column3.Text1.BorderStyle = 0
1670:                 .Column3.Text1.Margin      = 0
1671:                 .Column3.Text1.ReadOnly    = .T.
1672:                 .Column3.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1684 a 1692:
1684:                 .Column4.Header1.FontSize  = 8
1685:                 .Column4.Header1.Alignment = 2
1686:                 .Column4.Header1.ForeColor = RGB(36, 84, 155)
1687:                 .Column4.Header1.Caption   = "Qtde"
1688:                 .Column4.Text1.FontSize    = 8
1689:                 .Column4.Text1.BorderStyle = 0
1690:                 .Column4.Text1.InputMask   = "999,999.99"
1691:                 .Column4.Text1.Margin      = 0
1692:                 .Column4.Text1.ReadOnly    = .F.

*-- Linhas 1707 a 1715:
1707:                 .Column5.Header1.FontSize  = 8
1708:                 .Column5.Header1.Alignment = 2
1709:                 .Column5.Header1.ForeColor = RGB(36, 84, 155)
1710:                 .Column5.Header1.Caption   = "Produto"
1711:                 .Column5.Text1.FontSize    = 8
1712:                 .Column5.Text1.BorderStyle = 0
1713:                 .Column5.Text1.Margin      = 0
1714:                 .Column5.Text1.ReadOnly    = .F.
1715:                 .Column5.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1772 a 1807:
1772:             THIS.AddObject("cnt_4c_Container3", "Container")
1773:             loc_oCnt = THIS.cnt_4c_Container3
1774:             WITH loc_oCnt
1775:                 .Top           = 373
1776:                 .Left          = 12
1777:                 .Width         = 708
1778:                 .Height        = 205
1779:                 .SpecialEffect = 0
1780:                 .BackColor     = RGB(255, 255, 255)
1781:                 .Visible       = .T.
1782:             ENDWITH
1783: 
1784:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1785:             WITH loc_oCnt.lbl_4c_Label1
1786:                 .FontName  = "Tahoma"
1787:                 .FontSize  = 8
1788:                 .BackStyle = 0
1789:                 .AutoSize  = .F.
1790:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
1791:                 .Height    = 16
1792:                 .Left      = 6
1793:                 .Top       = 5
1794:                 .Width     = 118
1795:                 .ForeColor = RGB(90, 90, 90)
1796:                 .Visible   = .T.
1797:             ENDWITH
1798: 
1799:             loc_oCnt.AddObject("grd_4c_DispConta", "Grid")
1800:             WITH loc_oCnt.grd_4c_DispConta
1801:                 .Top               = 24
1802:                 .Left              = 6
1803:                 .Width             = 444
1804:                 .Height            = 148
1805:                 .FontSize          = 8
1806:                 .AllowHeaderSizing = .F.
1807:                 .AllowRowSizing    = .F.

*-- Linhas 1825 a 1833:
1825:                 .Column1.Header1.FontSize  = 8
1826:                 .Column1.Header1.Alignment = 2
1827:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
1828:                 .Column1.Header1.Caption   = "Grupo"
1829:                 .Column1.Text1.FontSize    = 8
1830:                 .Column1.Text1.BorderStyle = 0
1831:                 .Column1.Text1.Margin      = 0
1832:                 .Column1.Text1.ReadOnly    = .T.
1833:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1843 a 1851:
1843:                 .Column2.Header1.FontSize  = 8
1844:                 .Column2.Header1.Alignment = 2
1845:                 .Column2.Header1.ForeColor = RGB(36, 84, 155)
1846:                 .Column2.Header1.Caption   = "Conta"
1847:                 .Column2.Text1.FontSize    = 8
1848:                 .Column2.Text1.BorderStyle = 0
1849:                 .Column2.Text1.Margin      = 0
1850:                 .Column2.Text1.ReadOnly    = .T.
1851:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1861 a 1869:
1861:                 .Column3.Header1.FontSize  = 8
1862:                 .Column3.Header1.Alignment = 2
1863:                 .Column3.Header1.ForeColor = RGB(36, 84, 155)
1864:                 .Column3.Header1.Caption   = "Atual"
1865:                 .Column3.Text1.FontSize    = 8
1866:                 .Column3.Text1.BorderStyle = 0
1867:                 .Column3.Text1.Margin      = 0
1868:                 .Column3.Text1.ReadOnly    = .T.
1869:                 .Column3.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1879 a 1887:
1879:                 .Column4.Header1.FontSize  = 8
1880:                 .Column4.Header1.Alignment = 2
1881:                 .Column4.Header1.ForeColor = RGB(36, 84, 155)
1882:                 .Column4.Header1.Caption   = "Utilizado"
1883:                 .Column4.Text1.FontSize    = 8
1884:                 .Column4.Text1.BorderStyle = 0
1885:                 .Column4.Text1.Margin      = 0
1886:                 .Column4.Text1.ReadOnly    = .T.
1887:                 .Column4.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1897 a 1905:
1897:                 .Column5.Header1.FontSize  = 8
1898:                 .Column5.Header1.Alignment = 2
1899:                 .Column5.Header1.ForeColor = RGB(36, 84, 155)
1900:                 .Column5.Header1.Caption   = "Dispon" + CHR(237) + "vel"
1901:                 .Column5.Text1.FontSize    = 8
1902:                 .Column5.Text1.BorderStyle = 0
1903:                 .Column5.Text1.Margin      = 0
1904:                 .Column5.Text1.ReadOnly    = .T.
1905:                 .Column5.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1915 a 2015:
1915:                 .Column6.Header1.FontSize  = 8
1916:                 .Column6.Header1.Alignment = 2
1917:                 .Column6.Header1.ForeColor = RGB(36, 84, 155)
1918:                 .Column6.Header1.Caption   = "Emp"
1919:                 .Column6.Text1.FontSize    = 8
1920:                 .Column6.Text1.BorderStyle = 0
1921:                 .Column6.Text1.Margin      = 0
1922:                 .Column6.Text1.ReadOnly    = .T.
1923:                 .Column6.Text1.ForeColor   = RGB(0, 0, 0)
1924:                 .Column6.Text1.BackColor   = RGB(255, 255, 255)
1925:             ENDWITH
1926: 
1927:             loc_oCnt.AddObject("lbl_4c_Label2", "Label")
1928:             WITH loc_oCnt.lbl_4c_Label2
1929:                 .FontName  = "Tahoma"
1930:                 .FontSize  = 8
1931:                 .BackStyle = 0
1932:                 .AutoSize  = .F.
1933:                 .Caption   = "Grupo"
1934:                 .Height    = 15
1935:                 .Left      = 454
1936:                 .Top       = 90
1937:                 .Width     = 36
1938:                 .ForeColor = RGB(90, 90, 90)
1939:                 .Visible   = .T.
1940:             ENDWITH
1941: 
1942:             loc_oCnt.AddObject("txt_4c_GetDGrupo", "TextBox")
1943:             WITH loc_oCnt.txt_4c_GetDGrupo
1944:                 .Height        = 23
1945:                 .Width         = 247
1946:                 .Left          = 454
1947:                 .Top           = 106
1948:                 .SpecialEffect = 1
1949:                 .ReadOnly      = .T.
1950:                 .Visible       = .T.
1951:             ENDWITH
1952: 
1953:             loc_oCnt.AddObject("lbl_4c_Label3", "Label")
1954:             WITH loc_oCnt.lbl_4c_Label3
1955:                 .FontName  = "Tahoma"
1956:                 .FontSize  = 8
1957:                 .BackStyle = 0
1958:                 .AutoSize  = .F.
1959:                 .Caption   = "Conta"
1960:                 .Height    = 15
1961:                 .Left      = 454
1962:                 .Top       = 131
1963:                 .Width     = 35
1964:                 .ForeColor = RGB(90, 90, 90)
1965:                 .Visible   = .T.
1966:             ENDWITH
1967: 
1968:             loc_oCnt.AddObject("txt_4c_GetDConta", "TextBox")
1969:             WITH loc_oCnt.txt_4c_GetDConta
1970:                 .Height        = 23
1971:                 .Width         = 247
1972:                 .Left          = 454
1973:                 .Top           = 147
1974:                 .SpecialEffect = 1
1975:                 .ReadOnly      = .T.
1976:                 .Visible       = .T.
1977:             ENDWITH
1978: 
1979:             loc_oCnt.AddObject("txt_4c_TotQtd", "TextBox")
1980:             WITH loc_oCnt.txt_4c_TotQtd
1981:                 .Height        = 23
1982:                 .Width         = 80
1983:                 .Left          = 188
1984:                 .Top           = 173
1985:                 .InputMask     = "9,999.99"
1986:                 .SpecialEffect = 1
1987:                 .Value         = 0
1988:                 .ReadOnly      = .T.
1989:                 .Visible       = .T.
1990:             ENDWITH
1991: 
1992:             loc_oCnt.AddObject("txt_4c_TotEst", "TextBox")
1993:             WITH loc_oCnt.txt_4c_TotEst
1994:                 .Height        = 23
1995:                 .Width         = 80
1996:                 .Left          = 269
1997:                 .Top           = 173
1998:                 .InputMask     = "9,999.99"
1999:                 .SpecialEffect = 1
2000:                 .Value         = 0
2001:                 .ReadOnly      = .T.
2002:                 .Visible       = .T.
2003:             ENDWITH
2004: 
2005:             loc_oCnt.AddObject("txt_4c_TotPrz", "TextBox")
2006:             WITH loc_oCnt.txt_4c_TotPrz
2007:                 .Height        = 23
2008:                 .Width         = 80
2009:                 .Left          = 350
2010:                 .Top           = 173
2011:                 .InputMask     = "9,999.99"
2012:                 .SpecialEffect = 1
2013:                 .Value         = 0
2014:                 .ReadOnly      = .T.
2015:                 .Visible       = .T.

*-- Linhas 2027 a 2113:
2027:     * logo abaixo de grd_4c_Itens - distintos dos hom?nimos dentro de
2028:     * cnt_4c_Container3, que mostram o detalhe da LINHA selecionada, nao o
2029:     * somatorio geral), a foto do item (img_4c_ImgFigJpg, nasce oculta) e a
2030:     * observacao do item (lbl_4c_TxtObsItens/obj_4c_ObsItens). Todos
2031:     * alimentados por GradeItens.AfterRowColChange/Column6.Text1.LostFocus
2032:     * na Fase 7-8 - aqui e so a moldura visual.
2033:     *--------------------------------------------------------------------------
2034:     PROTECTED PROCEDURE ConfigurarCamposTotais()
2035:         LOCAL loc_oErro
2036: 
2037:         TRY
2038:             THIS.AddObject("txt_4c_TotQtd", "TextBox")
2039:             WITH THIS.txt_4c_TotQtd
2040:                 .Height        = 23
2041:                 .Width         = 80
2042:                 .Left          = 417
2043:                 .Top           = 349
2044:                 .InputMask     = "9,999.99"
2045:                 .SpecialEffect = 1
2046:                 .Value         = 0
2047:                 .ReadOnly      = .T.
2048:                 .Visible       = .T.
2049:             ENDWITH
2050: 
2051:             THIS.AddObject("txt_4c_TotEst", "TextBox")
2052:             WITH THIS.txt_4c_TotEst
2053:                 .Height        = 23
2054:                 .Width         = 81
2055:                 .Left          = 498
2056:                 .Top           = 349
2057:                 .InputMask     = "9,999.99"
2058:                 .SpecialEffect = 1
2059:                 .Value         = 0
2060:                 .ReadOnly      = .T.
2061:                 .Visible       = .T.
2062:             ENDWITH
2063: 
2064:             THIS.AddObject("txt_4c_TotPrz", "TextBox")
2065:             WITH THIS.txt_4c_TotPrz
2066:                 .Height        = 23
2067:                 .Width         = 82
2068:                 .Left          = 580
2069:                 .Top           = 349
2070:                 .InputMask     = "9,999.99"
2071:                 .SpecialEffect = 1
2072:                 .Value         = 0
2073:                 .ReadOnly      = .T.
2074:                 .Visible       = .T.
2075:             ENDWITH
2076: 
2077:             *-- Foto do item selecionado na grade principal - nasce oculta,
2078:             *-- igual ao legado (Visible=.F. no dump); GradeItens.
2079:             *-- AfterRowColChange decide quando mostrar (Fase 7-8).
2080:             THIS.AddObject("img_4c_ImgFigJpg", "Image")
2081:             WITH THIS.img_4c_ImgFigJpg
2082:                 .Top     = 125
2083:                 .Left    = 726
2084:                 .Width   = 266
2085:                 .Height  = 204
2086:                 .Stretch = 2
2087:                 .Visible = .F.
2088:             ENDWITH
2089: 
2090:             THIS.AddObject("lbl_4c_TxtObsItens", "Label")
2091:             WITH THIS.lbl_4c_TxtObsItens
2092:                 .FontName  = "Tahoma"
2093:                 .FontSize  = 8
2094:                 .BackStyle = 0
2095:                 .AutoSize  = .F.
2096:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item"
2097:                 .Height    = 15
2098:                 .Left      = 726
2099:                 .Top       = 369
2100:                 .Width     = 134
2101:                 .ForeColor = RGB(90, 90, 90)
2102:                 .Visible   = .T.
2103:             ENDWITH
2104: 
2105:             THIS.AddObject("obj_4c_ObsItens", "EditBox")
2106:             WITH THIS.obj_4c_ObsItens
2107:                 .Top           = 361
2108:                 .Left          = 732
2109:                 .Width         = 266
2110:                 .Height        = 205
2111:                 .FontName      = "Tahoma"
2112:                 .FontSize      = 8
2113:                 .ScrollBars    = 2

*-- Linhas 2538 a 2546:
2538:     * dependem (transcrito de SIGPRGLP.Init, dump linhas 2891-2959):
2539:     *
2540:     *   SELECT SelPedra / IF RECCOUNT() = 0 / APPEND BLANK    -> a grade de
2541:     *       Requisicoes (cmd_4c_Pedras) abre com UMA linha em branco pronta
2542:     *       para digitacao; sem isso o Click liga o grid a um cursor vazio.
2543:     *   Create Cursor TmpSaldU (Cpros c(14), KeySelm L)       -> marca os
2544:     *       produtos cujo estoque foi escolhido MANUALMENTE (consumido por
2545:     *       BtnConfirmarDispGrupoClick).
2546:     *   crSigCdCom (SigCdTpc + SigCdCom)                      -> tipos de

*-- Linhas 2711 a 2719:
2711: 
2712:                 IF fChecaAcesso("SIGPRGLO", "PRIORIDADE")
2713:                     .Column6.ReadOnly              = .F.
2714:                     THIS.cmd_4c_SelEstoque.Enabled = .T.
2715:                 ENDIF
2716: 
2717:                 .Refresh()
2718:             ENDWITH
2719:         CATCH TO loc_oErro

*-- Linhas 2740 a 2771:
2740:         LOCAL loc_oErro
2741: 
2742:         TRY
2743:             BINDEVENT(THIS.cmd_4c_Disponivel,   "Click", THIS, "BtnDisponivelClick")
2744:             BINDEVENT(THIS.cmd_4c_SelEstoque,   "Click", THIS, "BtnSelEstoqueClick")
2745:             BINDEVENT(THIS.cmd_4c_TotLinha,     "Click", THIS, "BtnTotLinhaClick")
2746:             BINDEVENT(THIS.cmd_4c_Pedras,       "Click", THIS, "BtnPedrasClick")
2747:             BINDEVENT(THIS.cmd_4c_BtnRelatorio, "Click", THIS, "BtnRelatorioClick")
2748:             BINDEVENT(THIS.cmd_4c_Cancelar,     "Click", THIS, "BtnCancelarClick")
2749: 
2750:             BINDEVENT(THIS.cnt_4c_Container2.cmd_4c_CancelaDisp, "Click", ;
2751:                 THIS, "BtnConfirmarDispProdutoClick")
2752:             BINDEVENT(THIS.cnt_4c_Container5.cmd_4c_CancelaDisp, "Click", ;
2753:                 THIS, "BtnConfirmarDispGrupoClick")
2754:             BINDEVENT(THIS.cnt_4c_Container4.cmd_4c_CancelaDisp, "Click", ;
2755:                 THIS, "BtnFecharPedrasClick")
2756:             BINDEVENT(THIS.cnt_4c_Container1.cmd_4c_CancelaLin,  "Click", ;
2757:                 THIS, "BtnFecharLinhasClick")
2758: 
2759:             BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
2760: 
2761:             *-- Grade principal (GradeItens) - troca de linha/coluna alimenta
2762:             *-- Container3/totais/imagem/observacao (legado: AfterRowColChange)
2763:             BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", ;
2764:                 THIS, "GradeItensAfterRowColChange")
2765: 
2766:             *-- Coluna Produzir (Column6, fisica e por .Name - fix do bug de
2767:             *-- troca com a Column3, ver ConfigurarGradeItens) - When/Valid/
2768:             *-- LostFocus do legado
2769:             BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "GotFocus",  THIS, "ItemProduzirGotFocus")
2770:             BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "KeyPress",  THIS, "ItemProduzirKeyPress")
2771:             BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "LostFocus", THIS, "ItemProduzirLostFocus")

*-- Linhas 2867 a 2885:
2867:                         .Column4.Width = 75
2868:                         .Column5.Width = 75
2869: 
2870:                         .Column1.Header1.Caption = "Produto"
2871:                         .Column2.Header1.Caption = "Cor"
2872:                         .Column3.Header1.Caption = "Tam"
2873:                         .Column4.Header1.Caption = "Disponivel"
2874:                         .Column5.Header1.Caption = "Utilizar"
2875:                     ENDWITH
2876: 
2877:                     THIS.cmd_4c_Processar.Enabled  = .F.
2878:                     THIS.cmd_4c_Cancelar.Enabled   = .F.
2879:                     THIS.cmd_4c_TotLinha.Enabled   = .F.
2880:                     THIS.cmd_4c_Disponivel.Enabled = .F.
2881:                     THIS.cnt_4c_Container3.Enabled = .F.
2882:                     THIS.cnt_4c_Container2.Visible = .T.
2883: 
2884:                     THIS.cnt_4c_Container2.ZOrder(0)
2885:                     THIS.cnt_4c_Container2.grd_4c_DispProduto.Refresh()

*-- Linhas 2963 a 2985:
2963:                         .Column4.Width = 75
2964:                         .Column5.Width = 75
2965: 
2966:                         .Column1.Header1.Caption = "Grupo"
2967:                         .Column2.Header1.Caption = "Conta"
2968:                         .Column3.Header1.Caption = "Prior"
2969:                         .Column4.Header1.Caption = "Disponivel"
2970:                         .Column5.Header1.Caption = "Utilizar"
2971:                     ENDWITH
2972: 
2973:                     *-- Bloco do legado com o "Estoques" INCLUSO (eh o unico
2974:                     *-- painel que desabilita o proprio botao que o abriu)
2975:                     THIS.HabilitarCampos(.F., .T.)
2976:                     THIS.cnt_4c_Container5.Visible = .T.
2977: 
2978:                     WITH THIS.cnt_4c_Container5
2979:                         .ZOrder(0)
2980:                         .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel (" + ;
2981:                             loc_cCpro + " " + loc_cCor + "/" + loc_cTam + ")"
2982:                         .txt_4c_QtPedida.Value = TmpFinal.Saldo - TmpFinal.Estoque
2983:                         .txt_4c_QtSelec.Value  = 0
2984:                         .grd_4c_DispGrupo.Refresh()
2985:                         .grd_4c_DispGrupo.Column5.SetFocus()

*-- Linhas 3582 a 3590:
3582:     * Container5 o reabilita, porque so o BtnSelEstoqueClick o desabilita.
3583:     * Dai o parametro par_lReabilitarSelEstoque.
3584:     *
3585:     * NOTA DE FIDELIDADE: o legado reabilita cmd_4c_Pedras
3586:     * INCONDICIONALMENTE aqui, mesmo quando o Init o havia desabilitado por
3587:     * falta das colunas de transferencia em SigCdPam. O comportamento eh
3588:     * transcrito como esta - abrir o painel de Requisicoes nao depende
3589:     * desses parametros (quem depende deles eh o Processar).
3590:     *--------------------------------------------------------------------------

*-- Linhas 3633 a 3641:
3633:         TRY
3634:             IF USED("TmpFinal") AND !EOF("TmpFinal")
3635:                 THIS.obj_4c_ObsItens.Refresh()
3636:                 THIS.lbl_4c_TxtObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ;
3637:                     ALLTRIM(TmpFinal.Cpros)
3638: 
3639:                 IF USED("TmpSaldo")
3640:                     =SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
3641:                 ENDIF

*-- Linhas 3654 a 3662:
3654:                         .txt_4c_TotPrz.Value = TmpSaldo.Disps
3655:                     ENDIF
3656: 
3657:                     .lbl_4c_Label1.Caption = ALLTRIM(TmpFinal.Cpros) + ;
3658:                         IIF(!EMPTY(TmpFinal.CodCors), "Cor:" + ALLTRIM(TmpFinal.CodCors), "") + ;
3659:                         IIF(!EMPTY(TmpFinal.CodTams), " Tam:" + ALLTRIM(TmpFinal.CodTams), "")
3660: 
3661:                     .txt_4c_GetDGrupo.Value = ""
3662:                     .txt_4c_GetDConta.Value = ""

*-- Linhas 3779 a 3787:
3779: 
3780:                             IF USED("TempGru") AND !EOF("TempGru") AND ;
3781:                                     INLIST(TempGru.TipoEstos, 3, 4)
3782:                                 THIS.cmd_4c_Disponivel.Enabled = .T.
3783:                             ENDIF
3784:                         ENDIF
3785:                     ENDIF
3786: 
3787:                     IF USED("TempGru")

*-- Linhas 4373 a 4389:
4373:                 .Column8.Width = 38
4374:                 .Column9.Width = 38
4375: 
4376:                 .Column1.Header1.Caption = "Produto"
4377:                 .Column2.Header1.Caption = "Cor"
4378:                 .Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
4379:                 .Column4.Header1.Caption = "C" + CHR(243) + "digo"
4380:                 .Column5.Header1.Caption = "Quantidade"
4381:                 .Column6.Header1.Caption = "Produzir"
4382:                 .Column7.Header1.Caption = "Estoque"
4383:                 .Column8.Header1.Caption = "Obs"
4384:                 .Column9.Header1.Caption = "Tam"
4385:             ENDWITH
4386:         CATCH TO loc_oErro
4387:             MsgErro(loc_oErro.Message + CHR(13) + ;
4388:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4389:                 "Procedure: " + loc_oErro.Procedure, "Erro em LigarGradeItens")

*-- Linhas 4485 a 4495:
4485:                 IF THIS.this_oBusinessObject.this_lReserva
4486:                     loc_cCaption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
4487:                 ENDIF
4488:                 THIS.Caption = loc_cCaption
4489:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = loc_cCaption
4490:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = loc_cCaption
4491:             ENDIF
4492: 
4493:             IF USED("TmpFinal")
4494:                 SELECT TmpFinal
4495:                 loc_nRecno = RECNO()

*-- Linhas 4508 a 4516:
4508:                 THIS.txt_4c_TotPrz.Value = loc_nPrz
4509: 
4510:                 IF !EOF("TmpFinal")
4511:                     THIS.lbl_4c_TxtObsItens.Caption = "Observa" + CHR(231) + CHR(227) + ;
4512:                         "o do Item " + ALLTRIM(TmpFinal.Cpros)
4513:                 ENDIF
4514:             ELSE
4515:                 THIS.txt_4c_TotQtd.Value = 0
4516:                 THIS.txt_4c_TotEst.Value = 0

*-- Linhas 4541 a 4564:
4541:     * botao que o usuario nao deveria ter - o legado, pelo mesmo motivo, o
4542:     * inclui no bloco do painel de estoque por conta e o omite nos demais.
4543:     *
4544:     * "Sair" (cmd_4c_Cancelar) entra no bloco porque o legado o desabilita
4545:     * junto: com um painel aberto, a saida se da pelo OK/Sair do painel.
4546:     *--------------------------------------------------------------------------
4547:     PROCEDURE HabilitarCampos(par_lHabilitar, par_lIncluirSelEstoque)
4548:         LOCAL loc_lLigar, loc_oErro
4549:         loc_lLigar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
4550: 
4551:         TRY
4552:             THIS.cmd_4c_Processar.Enabled  = loc_lLigar
4553:             THIS.cmd_4c_Cancelar.Enabled   = loc_lLigar
4554:             THIS.cmd_4c_TotLinha.Enabled   = loc_lLigar
4555:             THIS.cmd_4c_Pedras.Enabled     = loc_lLigar
4556:             THIS.cmd_4c_Disponivel.Enabled = loc_lLigar
4557: 
4558:             IF VARTYPE(par_lIncluirSelEstoque) = "L" AND par_lIncluirSelEstoque
4559:                 THIS.cmd_4c_SelEstoque.Enabled = loc_lLigar
4560:             ENDIF
4561: 
4562:             THIS.cnt_4c_Container3.Enabled = loc_lLigar
4563:             THIS.grd_4c_Itens.Enabled      = loc_lLigar
4564:         CATCH TO loc_oErro

*-- Linhas 4604 a 4621:
4604:                               !THIS.this_oBusinessObject.this_lReserva
4605:             ENDIF
4606: 
4607:             THIS.cmd_4c_Pedras.Enabled       = loc_lPedras AND loc_lTemItens
4608:             THIS.cmd_4c_SelEstoque.Enabled   = loc_lTemItens AND fChecaAcesso("SIGPRGLO", "PRIORIDADE")
4609:             THIS.cmd_4c_Processar.Enabled    = loc_lTemItens
4610:             THIS.cmd_4c_TotLinha.Enabled     = loc_lTemItens
4611:             THIS.cmd_4c_Disponivel.Enabled   = loc_lTemItens
4612:             THIS.cmd_4c_BtnRelatorio.Enabled = loc_lTemItens
4613:             THIS.grd_4c_Itens.Enabled        = loc_lTemItens
4614:             THIS.cnt_4c_Container3.Enabled   = loc_lTemItens
4615: 
4616:             THIS.cmd_4c_Cancelar.Enabled     = .T.
4617: 
4618:             *-- "If Empty(crSigCdPam.TransfRes) / .SetAll('ReadOnly', .t.)".
4619:             *-- O ReadOnly do Grid propaga para as colunas, entao este bloco
4620:             *-- fica DEPOIS de qualquer ajuste de coluna (regra #18).
4621:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;

*-- Linhas 4656 a 4676:
4656:             THIS.txt_4c_TotEst.Refresh()
4657:             THIS.txt_4c_TotPrz.Refresh()
4658: 
4659:             THIS.lbl_4c_TxtObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item"
4660: 
4661:             CLEAR RESOURCES
4662:             THIS.img_4c_ImgFigJpg.Picture = ""
4663:             THIS.img_4c_ImgFigJpg.Visible = .F.
4664: 
4665:             WITH THIS.cnt_4c_Container3
4666:                 .txt_4c_TotQtd.Value    = 0
4667:                 .txt_4c_TotEst.Value    = 0
4668:                 .txt_4c_TotPrz.Value    = 0
4669:                 .txt_4c_GetDGrupo.Value = ""
4670:                 .txt_4c_GetDConta.Value = ""
4671:                 .lbl_4c_Label1.Caption  = "Estoque Dispon" + CHR(237) + "vel"
4672:             ENDWITH
4673: 
4674:             WITH THIS.cnt_4c_Container2
4675:                 .txt_4c_QtPedida.Value = 0
4676:                 .txt_4c_QtSelec.Value  = 0

