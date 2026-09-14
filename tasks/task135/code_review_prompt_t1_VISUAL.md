# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [FONTNAME-ERRADO] Linha 1363: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdM10.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2172 linhas total):

*-- Linhas 40 a 60:
40:         BorderWidth = 0, BackColor = RGB(100,100,100)
41: 
42:     *-- Labels de secao (visibilidade ajustada por AjustarLayoutVisibilidade)
43:     ADD OBJECT lbl_4c_Envelopes AS Label WITH ;
44:         AutoSize = .T., FontName = "Tahoma", FontSize = 8, ;
45:         BackStyle = 0, Caption = "Movimentacao de Pesos", ;
46:         Height = 15, Left = 13, Top = 85, ;
47:         ForeColor = RGB(90,90,90), Visible = .F.
48: 
49:     ADD OBJECT lbl_4c_Label1 AS Label WITH ;
50:         AutoSize = .T., FontName = "Tahoma", FontSize = 8, ;
51:         BackStyle = 0, Caption = "Movimentacoes Finalizadas", ;
52:         Height = 15, Left = 13, Top = 215, ;
53:         ForeColor = RGB(90,90,90), Visible = .F.
54: 
55:     ADD OBJECT lbl_4c_Materiais AS Label WITH ;
56:         AutoSize = .T., FontName = "Tahoma", FontSize = 8, ;
57:         BackStyle = 0, Caption = "Componentes Baixados", ;
58:         Height = 15, Left = 13, Top = 405, ;
59:         ForeColor = RGB(90,90,90), Visible = .F.
60: 

*-- Linhas 121 a 129:
121:         ENDIF
122: 
123:         TRY
124:             THIS.Caption = "Resumo da Movimenta" + CHR(231) + CHR(227) + "o"
125:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
126: 
127:             *-- Propaga modo do form pai (INSERIR/ALTERAR) para controle de DtFechas
128:             IF VARTYPE(THIS.this_ParentForm) = "O"
129:                 IF TYPE("THIS.this_ParentForm.this_cModo") = "C"

*-- Linhas 185 a 237:
185:         loc_cCaption = THIS.Caption
186: 
187:         WITH THIS.cnt_4c_Sombra
188:             .ADDOBJECT("lbl_4c_LblSombra", "Label")
189:             WITH .lbl_4c_LblSombra
190:                 .FontBold    = .T.
191:                 .FontName    = "Tahoma"
192:                 .FontSize    = 18
193:                 .WordWrap    = .T.
194:                 .Alignment   = 0
195:                 .BackStyle   = 0
196:                 .Caption     = loc_cCaption
197:                 .Height      = 40
198:                 .Left        = 10
199:                 .Top         = 18
200:                 .Width       = 769
201:                 .ForeColor   = RGB(0,0,0)
202:                 .Visible     = .T.
203:             ENDWITH
204: 
205:             .ADDOBJECT("lbl_4c_LblTitulo", "Label")
206:             WITH .lbl_4c_LblTitulo
207:                 .FontBold    = .T.
208:                 .FontName    = "Tahoma"
209:                 .FontSize    = 18
210:                 .WordWrap    = .T.
211:                 .Alignment   = 0
212:                 .BackStyle   = 0
213:                 .Caption     = loc_cCaption
214:                 .Height      = 46
215:                 .Left        = 10
216:                 .Top         = 17
217:                 .Width       = 769
218:                 .ForeColor   = RGB(255,255,255)
219:                 .Visible     = .T.
220:             ENDWITH
221:         ENDWITH
222:     ENDPROC
223: 
224:     *==========================================================================
225:     * ConfigurarGradeEnvelopes - Configura grd_4c_GradeEnvelopes (xTotEnv)
226:     *==========================================================================
227:     PROTECTED PROCEDURE ConfigurarGradeEnvelopes()
228:         IF NOT EMPTY(THIS.this_oBusinessObject.this_cTituloEnvelopes)
229:             THIS.lbl_4c_Envelopes.Caption = "Peso por " + ;
230:                 THIS.this_oBusinessObject.this_cTituloEnvelopes
231:         ELSE
232:             THIS.lbl_4c_Envelopes.Caption = "Movimenta" + CHR(231) + CHR(227) + "o de Pesos"
233:         ENDIF
234: 
235:         WITH THIS.grd_4c_GradeEnvelopes
236:             .ColumnCount  = 3
237:             .RecordMark   = .F.

*-- Linhas 248 a 256:
248:                     .FontName  = "Tahoma"
249:                     .FontSize  = 8
250:                     .Alignment = 2
251:                     .Caption   = "Industrializa" + CHR(231) + CHR(227) + "o"
252:                 ENDWITH
253:                 WITH .Text1
254:                     .BorderStyle = 0
255:                     .Margin      = 0
256:                     .ReadOnly    = .T.

*-- Linhas 269 a 277:
269:                     .FontName  = "Tahoma"
270:                     .FontSize  = 8
271:                     .Alignment = 2
272:                     .Caption   = "Peso Entrada"
273:                 ENDWITH
274:                 WITH .Text1
275:                     .BorderStyle = 0
276:                     .Margin      = 0
277:                     .ReadOnly    = .T.

*-- Linhas 290 a 298:
290:                     .FontName  = "Tahoma"
291:                     .FontSize  = 8
292:                     .Alignment = 2
293:                     .Caption   = "Peso Sa" + CHR(237) + "da"
294:                 ENDWITH
295:                 WITH .Text1
296:                     .BorderStyle = 0
297:                     .Margin      = 0
298:                     .ReadOnly    = .T.

*-- Linhas 312 a 320:
312:     * ConfigurarGradePedidos - Configura grd_4c_GradePedidos (xTotPed)
313:     *==========================================================================
314:     PROTECTED PROCEDURE ConfigurarGradePedidos()
315:         THIS.lbl_4c_Label1.Caption = "Movimenta" + CHR(231) + CHR(245) + "es Finalizadas"
316:         WITH THIS.grd_4c_GradePedidos
317:             .ColumnCount  = 4
318:             .RecordMark   = .F.
319:             .DeleteMark   = .F.
320:             .RecordSource = "xTotPed"

*-- Linhas 329 a 337:
329:                     .FontName  = "Tahoma"
330:                     .FontSize  = 8
331:                     .Alignment = 2
332:                     .Caption   = "C" + CHR(243) + "digo"
333:                 ENDWITH
334:                 WITH .Text1
335:                     .BorderStyle = 0
336:                     .Margin      = 0
337:                     .ReadOnly    = .T.

*-- Linhas 350 a 358:
350:                     .FontName  = "Tahoma"
351:                     .FontSize  = 8
352:                     .Alignment = 2
353:                     .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
354:                 ENDWITH
355:                 WITH .Text1
356:                     .BorderStyle = 0
357:                     .Margin      = 0
358:                     .ReadOnly    = .T.

*-- Linhas 371 a 379:
371:                     .FontName  = "Tahoma"
372:                     .FontSize  = 8
373:                     .Alignment = 2
374:                     .Caption   = "Conta"
375:                 ENDWITH
376:                 WITH .Text1
377:                     .BorderStyle = 0
378:                     .Margin      = 0
379:                     .ReadOnly    = .T.

*-- Linhas 392 a 400:
392:                     .FontName  = "Tahoma"
393:                     .FontSize  = 8
394:                     .Alignment = 2
395:                     .Caption   = "Respons" + CHR(225) + "vel"
396:                 ENDWITH
397:                 WITH .Text1
398:                     .BorderStyle = 0
399:                     .Margin      = 0
400:                     .ReadOnly    = .T.

*-- Linhas 430 a 438:
430:                     .FontName  = "Tahoma"
431:                     .FontSize  = 8
432:                     .Alignment = 2
433:                     .Caption   = "Componente"
434:                 ENDWITH
435:                 WITH .Text1
436:                     .BorderStyle = 0
437:                     .Margin      = 0
438:                     .ReadOnly    = .T.

*-- Linhas 451 a 459:
451:                     .FontName  = "Tahoma"
452:                     .FontSize  = 8
453:                     .Alignment = 2
454:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
455:                 ENDWITH
456:                 WITH .Text1
457:                     .BorderStyle = 0
458:                     .Margin      = 0
459:                     .ReadOnly    = .T.

*-- Linhas 472 a 480:
472:                     .FontName  = "Tahoma"
473:                     .FontSize  = 8
474:                     .Alignment = 2
475:                     .Caption   = "Quantidade"
476:                 ENDWITH
477:                 WITH .Text1
478:                     .BorderStyle = 0
479:                     .Margin      = 0
480:                     .ReadOnly    = .T.

*-- Linhas 493 a 501:
493:                     .FontName  = "Tahoma"
494:                     .FontSize  = 8
495:                     .Alignment = 2
496:                     .Caption   = "Uni"
497:                 ENDWITH
498:                 WITH .Text1
499:                     .BorderStyle = 0
500:                     .Margin      = 0
501:                     .ReadOnly    = .T.

*-- Linhas 514 a 522:
514:                     .FontName  = "Tahoma"
515:                     .FontSize  = 8
516:                     .Alignment = 2
517:                     .Caption   = "Peso Atual"
518:                 ENDWITH
519:                 WITH .Text1
520:                     .BorderStyle = 0
521:                     .Margin      = 0
522:                     .ReadOnly    = .T.

*-- Linhas 539 a 613:
539:         WITH THIS.cnt_4c_Ops
540: 
541:             *-- Labels de secao
542:             .ADDOBJECT("lbl_4c_Label1", "Label")
543:             WITH .lbl_4c_Label1
544:                 .AutoSize  = .T.
545:                 .FontName  = "Tahoma"
546:                 .FontSize  = 8
547:                 .BackStyle = 0
548:                 .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es Finalizadas"
549:                 .Height    = 15
550:                 .Left      = 15
551:                 .Top       = -1
552:                 .ForeColor = RGB(90,90,90)
553:                 .Visible   = .T.
554:             ENDWITH
555: 
556:             .ADDOBJECT("lbl_4c_Materiais", "Label")
557:             WITH .lbl_4c_Materiais
558:                 .AutoSize  = .T.
559:                 .FontName  = "Tahoma"
560:                 .FontSize  = 8
561:                 .BackStyle = 0
562:                 .Caption   = "Componentes Baixados"
563:                 .Height    = 15
564:                 .Left      = 637
565:                 .Top       = 0
566:                 .ForeColor = RGB(90,90,90)
567:                 .Visible   = .T.
568:             ENDWITH
569: 
570:             .ADDOBJECT("lbl_4c_Label2", "Label")
571:             WITH .lbl_4c_Label2
572:                 .AutoSize  = .T.
573:                 .FontName  = "Tahoma"
574:                 .FontSize  = 8
575:                 .BackStyle = 0
576:                 .Caption   = "Componentes Baixados por OP"
577:                 .Height    = 15
578:                 .Left      = 15
579:                 .Top       = 189
580:                 .ForeColor = RGB(90,90,90)
581:                 .Visible   = .T.
582:             ENDWITH
583: 
584:             *-- Grid: Pedidos por OP (xTotPedOp)
585:             .ADDOBJECT("grd_4c_GradePedOp", "Grid")
586:             WITH .grd_4c_GradePedOp
587:                 .ColumnCount  = 4
588:                 .Height       = 167
589:                 .Left         = 15
590:                 .ReadOnly     = .T.
591:                 .RecordMark   = .F.
592:                 .DeleteMark   = .F.
593:                 .RecordSource = "xTotPedOp"
594:                 .TabIndex     = 5
595:                 .Top          = 15
596:                 .Width        = 619
597:                 .GridLineColor = RGB(238,238,238)
598:                 WITH .Column1
599:                     .Width         = 130
600:                     .Movable       = .F.
601:                     .Resizable     = .F.
602:                     .ReadOnly      = .T.
603:                     .ControlSource = "xTotPedOp.Dopes"
604:                     WITH .Header1
605:                         .FontName  = "Tahoma"
606:                         .FontSize  = 8
607:                         .Alignment = 2
608:                         .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
609:                     ENDWITH
610:                     WITH .Text1
611:                         .BorderStyle = 0
612:                         .Margin      = 0
613:                         .ReadOnly    = .T.

*-- Linhas 625 a 633:
625:                         .FontName  = "Tahoma"
626:                         .FontSize  = 8
627:                         .Alignment = 2
628:                         .Caption   = "C" + CHR(243) + "digo"
629:                     ENDWITH
630:                     WITH .Text1
631:                         .BorderStyle = 0
632:                         .Margin      = 0
633:                         .ReadOnly    = .T.

*-- Linhas 645 a 653:
645:                         .FontName  = "Tahoma"
646:                         .FontSize  = 8
647:                         .Alignment = 2
648:                         .Caption   = "Industrializa" + CHR(231) + CHR(227) + "o"
649:                     ENDWITH
650:                     WITH .Text1
651:                         .BorderStyle = 0
652:                         .Margin      = 0
653:                         .ReadOnly    = .T.

*-- Linhas 665 a 673:
665:                         .FontName  = "Tahoma"
666:                         .FontSize  = 8
667:                         .Alignment = 2
668:                         .Caption   = "Conta"
669:                     ENDWITH
670:                     WITH .Text1
671:                         .BorderStyle = 0
672:                         .Margin      = 0
673:                         .ReadOnly    = .T.

*-- Linhas 683 a 710:
683:             WITH .grd_4c_GradeMatOp
684:                 .ColumnCount  = 5
685:                 .Height       = 167
686:                 .Left         = 15
687:                 .ReadOnly     = .T.
688:                 .RecordMark   = .F.
689:                 .DeleteMark   = .F.
690:                 .RecordSource = "xMatOp"
691:                 .TabIndex     = 7
692:                 .Top          = 210
693:                 .Width        = 619
694:                 .GridLineColor = RGB(238,238,238)
695:                 WITH .Column1
696:                     .Width         = 100
697:                     .Movable       = .F.
698:                     .Resizable     = .F.
699:                     .ReadOnly      = .T.
700:                     .ControlSource = "xMatOp.CMats"
701:                     WITH .Header1
702:                         .FontName  = "Tahoma"
703:                         .FontSize  = 8
704:                         .Alignment = 2
705:                         .Caption   = "Componente"
706:                     ENDWITH
707:                     WITH .Text1
708:                         .BorderStyle = 0
709:                         .Margin      = 0
710:                         .ReadOnly    = .T.

*-- Linhas 722 a 730:
722:                         .FontName  = "Tahoma"
723:                         .FontSize  = 8
724:                         .Alignment = 2
725:                         .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
726:                     ENDWITH
727:                     WITH .Text1
728:                         .BorderStyle = 0
729:                         .Margin      = 0
730:                         .ReadOnly    = .T.

*-- Linhas 742 a 750:
742:                         .FontName  = "Tahoma"
743:                         .FontSize  = 8
744:                         .Alignment = 2
745:                         .Caption   = "Quantidade"
746:                     ENDWITH
747:                     WITH .Text1
748:                         .BorderStyle = 0
749:                         .Margin      = 0
750:                         .ReadOnly    = .T.

*-- Linhas 762 a 770:
762:                         .FontName  = "Tahoma"
763:                         .FontSize  = 8
764:                         .Alignment = 2
765:                         .Caption   = "Uni"
766:                     ENDWITH
767:                     WITH .Text1
768:                         .BorderStyle = 0
769:                         .Margin      = 0
770:                         .ReadOnly    = .T.

*-- Linhas 782 a 790:
782:                         .FontName  = "Tahoma"
783:                         .FontSize  = 8
784:                         .Alignment = 2
785:                         .Caption   = "Peso Atual"
786:                     ENDWITH
787:                     WITH .Text1
788:                         .BorderStyle = 0
789:                         .Margin      = 0
790:                         .ReadOnly    = .T.

*-- Linhas 800 a 826:
800:             WITH .grd_4c_MatGeral
801:                 .ColumnCount  = 4
802:                 .Height       = 363
803:                 .Left         = 637
804:                 .ReadOnly     = .T.
805:                 .RecordMark   = .F.
806:                 .RecordSource = "xTotMatOp"
807:                 .TabIndex     = 7
808:                 .Top          = 15
809:                 .Width        = 354
810:                 .GridLineColor = RGB(238,238,238)
811:                 WITH .Column1
812:                     .Width         = 100
813:                     .Movable       = .F.
814:                     .Resizable     = .F.
815:                     .ReadOnly      = .T.
816:                     .ControlSource = "xTotMatOp.CMats"
817:                     WITH .Header1
818:                         .FontName  = "Tahoma"
819:                         .FontSize  = 8
820:                         .Alignment = 2
821:                         .Caption   = "Componente"
822:                     ENDWITH
823:                     WITH .Text1
824:                         .BorderStyle = 0
825:                         .Margin      = 0
826:                         .ReadOnly    = .T.

*-- Linhas 838 a 846:
838:                         .FontName  = "Tahoma"
839:                         .FontSize  = 8
840:                         .Alignment = 2
841:                         .Caption   = "Quantidade"
842:                     ENDWITH
843:                     WITH .Text1
844:                         .BorderStyle = 0
845:                         .Margin      = 0
846:                         .ReadOnly    = .T.

*-- Linhas 858 a 866:
858:                         .FontName  = "Tahoma"
859:                         .FontSize  = 8
860:                         .Alignment = 2
861:                         .Caption   = "Uni"
862:                     ENDWITH
863:                     WITH .Text1
864:                         .BorderStyle = 0
865:                         .Margin      = 0
866:                         .ReadOnly    = .T.

*-- Linhas 878 a 886:
878:                         .FontName  = "Tahoma"
879:                         .FontSize  = 8
880:                         .Alignment = 2
881:                         .Caption   = "Peso Atual"
882:                     ENDWITH
883:                     WITH .Text1
884:                         .BorderStyle = 0
885:                         .Margin      = 0
886:                         .ReadOnly    = .T.

*-- Linhas 931 a 1074:
931:                 *-- Shapes decorativos
932:                 .ADDOBJECT("shp_4c_Shape2", "Shape")
933:                 WITH .shp_4c_Shape2
934:                     .Top         = 136
935:                     .Left        = 188
936:                     .Height      = 109
937:                     .Width       = 185
938:                     .BackStyle   = 0
939:                     .BorderColor = RGB(90,90,90)
940:                     .Visible     = .T.
941:                 ENDWITH
942: 
943:                 .ADDOBJECT("shp_4c_Shape1", "Shape")
944:                 WITH .shp_4c_Shape1
945:                     .Top         = 45
946:                     .Left        = 453
947:                     .Height      = 28
948:                     .Width       = 90
949:                     .BackStyle   = 0
950:                     .BorderStyle = 0
951:                     .BorderColor = RGB(136,189,188)
952:                     .Visible     = .T.
953:                 ENDWITH
954: 
955:                 *-- Label: Modelo de Etiqueta
956:                 .ADDOBJECT("lbl_4c_Label2", "Label")
957:                 WITH .lbl_4c_Label2
958:                     .AutoSize  = .T.
959:                     .FontName  = "Tahoma"
960:                     .FontSize  = 8
961:                     .BackStyle = 0
962:                     .Caption   = "Modelo de Etiqueta "
963:                     .Height    = 15
964:                     .Left      = 6
965:                     .Top       = 120
966:                     .ForeColor = RGB(90,90,90)
967:                     .BackColor = RGB(255,255,255)
968:                     .Visible   = .T.
969:                 ENDWITH
970: 
971:                 *-- Label: Impressora
972:                 .ADDOBJECT("lbl_4c_Label3", "Label")
973:                 WITH .lbl_4c_Label3
974:                     .AutoSize  = .T.
975:                     .FontName  = "Tahoma"
976:                     .FontSize  = 8
977:                     .BackStyle = 0
978:                     .Caption   = "Impressora"
979:                     .Height    = 15
980:                     .Left      = 193
981:                     .Top       = 120
982:                     .ForeColor = RGB(90,90,90)
983:                     .BackColor = RGB(255,255,255)
984:                     .Visible   = .T.
985:                 ENDWITH
986: 
987:                 *-- Label: Sistema (bold) - cabecalho coluna impressoras SQL
988:                 .ADDOBJECT("lbl_4c_Label1", "Label")
989:                 WITH .lbl_4c_Label1
990:                     .FontBold  = .T.
991:                     .FontName  = "Tahoma"
992:                     .FontSize  = 8
993:                     .BackStyle = 0
994:                     .Caption   = "Sistema"
995:                     .Height    = 15
996:                     .Left      = 197
997:                     .Top       = 144
998:                     .ForeColor = RGB(90,90,90)
999:                     .Visible   = .T.
1000:                 ENDWITH
1001: 
1002:                 *-- Label: Windows (bold) - cabecalho coluna impressoras Windows
1003:                 .ADDOBJECT("lbl_4c_Label6", "Label")
1004:                 WITH .lbl_4c_Label6
1005:                     .FontBold  = .T.
1006:                     .FontName  = "Tahoma"
1007:                     .FontSize  = 8
1008:                     .BackStyle = 0
1009:                     .Caption   = "Windows"
1010:                     .Height    = 15
1011:                     .Left      = 311
1012:                     .Top       = 144
1013:                     .ForeColor = RGB(90,90,90)
1014:                     .Visible   = .T.
1015:                 ENDWITH
1016: 
1017:                 *-- Label: Preco
1018:                 .ADDOBJECT("lbl_4c_Label4", "Label")
1019:                 WITH .lbl_4c_Label4
1020:                     .AutoSize  = .T.
1021:                     .FontName  = "Tahoma"
1022:                     .FontSize  = 8
1023:                     .BackStyle = 0
1024:                     .Caption   = "Pre" + CHR(231) + "o :"
1025:                     .Height    = 15
1026:                     .Left      = 378
1027:                     .Top       = 169
1028:                     .ForeColor = RGB(90,90,90)
1029:                     .BackColor = RGB(255,255,255)
1030:                     .Visible   = .T.
1031:                 ENDWITH
1032: 
1033:                 *-- Label: Peso
1034:                 .ADDOBJECT("lbl_4c_Label5", "Label")
1035:                 WITH .lbl_4c_Label5
1036:                     .AutoSize  = .T.
1037:                     .FontName  = "Tahoma"
1038:                     .FontSize  = 8
1039:                     .BackStyle = 0
1040:                     .Caption   = "Peso :"
1041:                     .Height    = 15
1042:                     .Left      = 517
1043:                     .Top       = 169
1044:                     .ForeColor = RGB(90,90,90)
1045:                     .BackColor = RGB(255,255,255)
1046:                     .Visible   = .T.
1047:                 ENDWITH
1048: 
1049:                 *-- Opt_Tipo: tipos de etiqueta (montado dinamicamente em CarregarTiposEtiqueta)
1050:                 .ADDOBJECT("obj_4c_Opt_Tipo", "OptionGroup")
1051:                 WITH .obj_4c_Opt_Tipo
1052:                     .ButtonCount   = 1
1053:                     .BackStyle     = 0
1054:                     .Value         = 1
1055:                     .Height        = 35
1056:                     .Left          = 4
1057:                     .SpecialEffect = 1
1058:                     .Top           = 136
1059:                     .Width         = 180
1060:                     .BorderColor   = RGB(90,90,90)
1061:                     .Themes        = .F.
1062:                     WITH .Option1
1063:                         .BackStyle = 0
1064:                         .Caption   = " \<a. Rabicho"
1065:                         .AutoSize  = .F.
1066:                         .Width     = 160
1067:                         .Height    = 16
1068:                         .Left      = 9
1069:                         .Top       = 10
1070:                         .ForeColor = RGB(90,90,90)
1071:                         .Themes    = .F.
1072:                         .Tag       = "1"
1073:                     ENDWITH
1074:                     .Visible = .T.

*-- Linhas 1083 a 1118:
1083:                     .BorderStyle   = 0
1084:                     .Value         = 1
1085:                     .Height        = 18
1086:                     .Left          = 423
1087:                     .SpecialEffect = 1
1088:                     .Top           = 167
1089:                     .Width         = 85
1090:                     .BorderColor   = RGB(136,189,188)
1091:                     .Themes        = .F.
1092:                     WITH .Option1
1093:                         .BackStyle = 0
1094:                         .Caption   = "Sim"
1095:                         .Value     = 1
1096:                         .Height    = 17
1097:                         .Left      = 1
1098:                         .Style     = 0
1099:                         .Top       = 0
1100:                         .Width     = 41
1101:                         .AutoSize  = .F.
1102:                         .ForeColor = RGB(90,90,90)
1103:                         .Themes    = .F.
1104:                     ENDWITH
1105:                     WITH .Option2
1106:                         .FontName  = "Tahoma"
1107:                         .FontSize  = 8
1108:                         .BackStyle = 0
1109:                         .Caption   = "N" + CHR(227) + "o"
1110:                         .Height    = 17
1111:                         .Left      = 42
1112:                         .Style     = 0
1113:                         .Top       = 0
1114:                         .Width     = 41
1115:                         .AutoSize  = .F.
1116:                         .ForeColor = RGB(90,90,90)
1117:                         .Themes    = .F.
1118:                     ENDWITH

*-- Linhas 1128 a 1163:
1128:                     .BorderStyle   = 0
1129:                     .Value         = 1
1130:                     .Height        = 18
1131:                     .Left          = 557
1132:                     .SpecialEffect = 1
1133:                     .Top           = 167
1134:                     .Width         = 85
1135:                     .BorderColor   = RGB(136,189,188)
1136:                     .Themes        = .F.
1137:                     WITH .Option1
1138:                         .BackStyle = 0
1139:                         .Caption   = "Sim"
1140:                         .Value     = 1
1141:                         .Height    = 17
1142:                         .Left      = 1
1143:                         .Style     = 0
1144:                         .Top       = 0
1145:                         .Width     = 41
1146:                         .AutoSize  = .F.
1147:                         .ForeColor = RGB(90,90,90)
1148:                         .Themes    = .F.
1149:                     ENDWITH
1150:                     WITH .Option2
1151:                         .FontName  = "Tahoma"
1152:                         .FontSize  = 8
1153:                         .BackStyle = 0
1154:                         .Caption   = "N" + CHR(227) + "o"
1155:                         .Height    = 17
1156:                         .Left      = 42
1157:                         .Style     = 0
1158:                         .Top       = 0
1159:                         .Width     = 41
1160:                         .AutoSize  = .F.
1161:                         .ForeColor = RGB(90,90,90)
1162:                         .Themes    = .F.
1163:                     ENDWITH

*-- Linhas 1173 a 1383:
1173:                     .RowSourceType     = 2
1174:                     .RowSource         = "crImpreV"
1175:                     .Height            = 23
1176:                     .Left              = 195
1177:                     .SpecialEffect     = 1
1178:                     .Style             = 2
1179:                     .TabIndex          = 1
1180:                     .Top               = 161
1181:                     .Width             = 173
1182:                     .DisabledBackColor = RGB(238,238,238)
1183:                     .DisabledForeColor = RGB(0,0,128)
1184:                     .BorderColor       = RGB(100,100,100)
1185:                     .BoundTo           = .F.
1186:                     .Visible           = .T.
1187:                 ENDWITH
1188: 
1189:                 *-- Container de configuracoes de impressao (Opcao tipo, ajustes)
1190:                 .ADDOBJECT("cnt_4c__Impressora", "Container")
1191:                 WITH .cnt_4c__Impressora
1192:                     .Top         = 183
1193:                     .Left        = 374
1194:                     .Width       = 267
1195:                     .Height      = 65
1196:                     .BackStyle   = 0
1197:                     .BorderWidth = 0
1198:                     .BackColor   = RGB(255,255,255)
1199: 
1200:                     .ADDOBJECT("obj_4c_Opcao_imp", "OptionGroup")
1201:                     WITH .obj_4c_Opcao_imp
1202:                         .ButtonCount = 3
1203:                         .Height      = 25
1204:                         .Left        = -2
1205:                         .Top         = 1
1206:                         .Width       = 250
1207:                         .Value       = 1
1208:                         WITH .Option1
1209:                             .Caption   = "Allegro"
1210:                             .Left      = 5
1211:                             .Top       = 5
1212:                             .Width     = 51
1213:                             .AutoSize  = .T.
1214:                             .ForeColor = RGB(90,90,90)
1215:                         ENDWITH
1216:                         WITH .Option2
1217:                             .FontName  = "Tahoma"
1218:                             .FontSize  = 8
1219:                             .Caption   = "Zebra ZPL"
1220:                             .Left      = 80
1221:                             .Top       = 5
1222:                             .Width     = 66
1223:                             .AutoSize  = .T.
1224:                             .ForeColor = RGB(90,90,90)
1225:                         ENDWITH
1226:                         WITH .Option3
1227:                             .FontName  = "Tahoma"
1228:                             .FontSize  = 8
1229:                             .BackStyle = 0
1230:                             .Caption   = "Zebra EPL"
1231:                             .Height    = 15
1232:                             .Left      = 168
1233:                             .Top       = 5
1234:                             .Width     = 66
1235:                             .AutoSize  = .T.
1236:                             .ForeColor = RGB(90,90,90)
1237:                         ENDWITH
1238:                         .Visible = .T.
1239:                     ENDWITH
1240: 
1241:                     .ADDOBJECT("lbl_4c_LbVertical", "Label")
1242:                     WITH .lbl_4c_LbVertical
1243:                         .FontName  = "Tahoma"
1244:                         .FontSize  = 8
1245:                         .Caption   = "Vertical"
1246:                         .Height    = 15
1247:                         .Left      = 6
1248:                         .Top       = 23
1249:                         .Width     = 37
1250:                         .Visible   = .F.
1251:                         .ForeColor = RGB(90,90,90)
1252:                     ENDWITH
1253: 
1254:                     .ADDOBJECT("lbl_4c_LbHorizontal", "Label")
1255:                     WITH .lbl_4c_LbHorizontal
1256:                         .FontName  = "Tahoma"
1257:                         .FontSize  = 8
1258:                         .Caption   = "Horizontal"
1259:                         .Left      = 65
1260:                         .Top       = 23
1261:                         .Visible   = .F.
1262:                         .ForeColor = RGB(90,90,90)
1263:                     ENDWITH
1264: 
1265:                     .ADDOBJECT("lbl_4c_LbDensidade", "Label")
1266:                     WITH .lbl_4c_LbDensidade
1267:                         .FontName  = "Tahoma"
1268:                         .FontSize  = 8
1269:                         .Caption   = "Densidade"
1270:                         .Left      = 125
1271:                         .Top       = 23
1272:                         .ForeColor = RGB(90,90,90)
1273:                         .Visible   = .T.
1274:                     ENDWITH
1275: 
1276:                     .ADDOBJECT("lbl_4c_LbVelocidade", "Label")
1277:                     WITH .lbl_4c_LbVelocidade
1278:                         .FontName  = "Tahoma"
1279:                         .FontSize  = 8
1280:                         .Caption   = "Velocidade"
1281:                         .Left      = 186
1282:                         .Top       = 23
1283:                         .ForeColor = RGB(90,90,90)
1284:                         .Visible   = .T.
1285:                     ENDWITH
1286: 
1287:                     .ADDOBJECT("obj_4c_Spn_AjVerts", "Spinner")
1288:                     WITH .obj_4c_Spn_AjVerts
1289:                         .FontName          = "Tahoma"
1290:                         .FontSize          = 8
1291:                         .Height            = 26
1292:                         .KeyboardHighValue = 999
1293:                         .KeyboardLowValue  = 0
1294:                         .Left              = 6
1295:                         .SpinnerHighValue  = 999
1296:                         .SpinnerLowValue   = 0
1297:                         .Top               = 36
1298:                         .Width             = 55
1299:                         .Value             = 0
1300:                         .Visible           = .F.
1301:                     ENDWITH
1302: 
1303:                     .ADDOBJECT("obj_4c_Spn_AjHorzs", "Spinner")
1304:                     WITH .obj_4c_Spn_AjHorzs
1305:                         .FontName          = "Tahoma"
1306:                         .FontSize          = 8
1307:                         .Height            = 26
1308:                         .KeyboardHighValue = 999
1309:                         .KeyboardLowValue  = 0
1310:                         .Left              = 65
1311:                         .SpinnerHighValue  = 999
1312:                         .SpinnerLowValue   = 0
1313:                         .Top               = 36
1314:                         .Width             = 55
1315:                         .Value             = 0
1316:                         .Visible           = .F.
1317:                     ENDWITH
1318: 
1319:                     .ADDOBJECT("obj_4c_Spn_AjDenss", "Spinner")
1320:                     WITH .obj_4c_Spn_AjDenss
1321:                         .FontName          = "Tahoma"
1322:                         .FontSize          = 8
1323:                         .Height            = 26
1324:                         .KeyboardHighValue = 20
1325:                         .KeyboardLowValue  = 10
1326:                         .Left              = 125
1327:                         .SpinnerHighValue  = 20
1328:                         .SpinnerLowValue   = 10
1329:                         .Top               = 36
1330:                         .Width             = 55
1331:                         .Value             = 10
1332:                         .Visible           = .T.
1333:                     ENDWITH
1334: 
1335:                     .ADDOBJECT("obj_4c_Spn_AjVelos", "Spinner")
1336:                     WITH .obj_4c_Spn_AjVelos
1337:                         .FontName          = "Tahoma"
1338:                         .FontSize          = 8
1339:                         .Height            = 26
1340:                         .KeyboardHighValue = 3
1341:                         .KeyboardLowValue  = 1
1342:                         .Left              = 186
1343:                         .SpinnerHighValue  = 3
1344:                         .SpinnerLowValue   = 1
1345:                         .Top               = 35
1346:                         .Width             = 57
1347:                         .Value             = 3
1348:                         .Visible           = .T.
1349:                     ENDWITH
1350: 
1351:                     .Visible = .T.
1352:                 ENDWITH
1353: 
1354:                 *-- Botao Imprimir
1355:                 .ADDOBJECT("cmd_4c_Imprimir", "CommandButton")
1356:                 WITH .cmd_4c_Imprimir
1357:                     .Top             = 38
1358:                     .Left            = 498
1359:                     .Height          = 75
1360:                     .Width           = 75
1361:                     .FontBold        = .T.
1362:                     .FontItalic      = .T.
1363:                     .FontName        = "Comic Sans MS"
1364:                     .FontSize        = 8
1365:                     .Caption         = "\<Imprimir"
1366:                     .PicturePosition = 13
1367:                     .ForeColor       = RGB(90,90,90)
1368:                     .BackColor       = RGB(255,255,255)
1369:                     .Themes          = .F.
1370:                     .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
1371:                     .Visible         = .T.
1372:                 ENDWITH
1373:             ENDWITH
1374: 
1375:             *-- BINDEVENTs do container Etiquetas
1376:             BINDEVENT(THIS.cnt_4c_Etiquetas.cbo_4c_Get_Printer, "InteractiveChange", ;
1377:                       THIS, "ImpressoraInteractiveChange")
1378:             BINDEVENT(THIS.cnt_4c_Etiquetas.cmd_4c_Imprimir, "Click", ;
1379:                       THIS, "BtnImprimirClick")
1380: 
1381:             *-- Carrega tipos de etiqueta e constroi Opt_Tipo dinamicamente
1382:             THIS.CarregarTiposEtiqueta()
1383: 

*-- Linhas 1455 a 1468:
1455:                             WITH .Option&loc_cI.
1456:                                 .AutoSize  = .F.
1457:                                 .Width     = 160
1458:                                 .Caption   = " \<" + CHR(96 + loc_nI) + ". " + ;
1459:                                              ALLTRIM(cursor_4c_SigCdTpe.cEtiquetas)
1460:                                 .ForeColor = RGB(90,90,90)
1461:                                 .Themes    = .F.
1462:                                 .Tag       = ALLTRIM(STR(cursor_4c_SigCdTpe.nTipos))
1463:                                 .Top       = loc_nTop
1464:                             ENDWITH
1465:                             loc_nI      = loc_nI + 1
1466:                             loc_nTop    = loc_nTop + 20
1467:                             loc_nHeight = loc_nHeight + 20
1468:                             SKIP IN cursor_4c_SigCdTpe

*-- Linhas 1477 a 1488:
1477:                         WITH .Option1
1478:                             .AutoSize = .F.
1479:                             .Width    = 160
1480:                             .Caption  = " \<z. Rabicho Loja Tipo 1 (*)"
1481:                             .FontSize = 8
1482:                             .Tag      = "1"
1483:                             .Top      = 10
1484:                         ENDWITH
1485:                         .Height  = 35
1486:                         .Enabled = .F.
1487:                     ENDIF
1488:                 ENDWITH

*-- Linhas 1497 a 1520:
1497:     ENDPROC
1498: 
1499:     *==========================================================================
1500:     * ConfigurarSaida - Adiciona cmd_4c_Encerrar no cnt_4c_Saida (padrao canonico)
1501:     *==========================================================================
1502:     PROTECTED PROCEDURE ConfigurarSaida()
1503:         WITH THIS.cnt_4c_Saida
1504:             .ADDOBJECT("cmd_4c_Encerrar", "CommandButton")
1505:             WITH .cmd_4c_Encerrar
1506:                 .Left    = 5
1507:                 .Top     = 5
1508:                 .Width   = 75
1509:                 .Height  = 75
1510:                 .Caption = "Encerrar"
1511:                 .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1512:                 .Visible = .T.
1513:             ENDWITH
1514:         ENDWITH
1515:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
1516:     ENDPROC
1517: 
1518:     *==========================================================================
1519:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1520:     *   Exceto cnt_4c_Ops (controlado por lExibeCntOps) e

*-- Linhas 1552 a 1568:
1552:     PROTECTED PROCEDURE AjustarLayoutVisibilidade()
1553:         IF THIS.this_oBusinessObject.this_lExibeCntOps
1554:             THIS.cnt_4c_Ops.Visible          = .T.
1555:             THIS.lbl_4c_Label1.Visible       = .F.
1556:             THIS.grd_4c_GradePedidos.Visible = .F.
1557:             THIS.lbl_4c_Materiais.Visible    = .F.
1558:             THIS.grd_4c_GradeMateriais.Visible = .F.
1559:         ELSE
1560:             THIS.cnt_4c_Ops.Visible          = .F.
1561:             THIS.lbl_4c_Label1.Visible       = .T.
1562:             THIS.grd_4c_GradePedidos.Visible = .T.
1563:             THIS.lbl_4c_Materiais.Visible    = .T.
1564:             THIS.grd_4c_GradeMateriais.Visible = .T.
1565:         ENDIF
1566: 
1567:         IF THIS.this_lEtiqParam
1568:             THIS.cnt_4c_Etiquetas.SpecialEffect = 2

*-- Linhas 1749 a 1764:
1749:             ENDIF
1750: 
1751:             *-- Garante labels visiveis
1752:             IF PEMSTATUS(THIS, "lbl_4c_Envelopes", 5)
1753:                 THIS.lbl_4c_Envelopes.Visible = .T.
1754:             ENDIF
1755:             IF PEMSTATUS(THIS, "lbl_4c_Materiais", 5)
1756:                 THIS.lbl_4c_Materiais.Visible = .T.
1757:             ENDIF
1758:             IF PEMSTATUS(THIS, "lbl_4c_Label1", 5)
1759:                 THIS.lbl_4c_Label1.Visible = .T.
1760:             ENDIF
1761:         CATCH TO loc_oErro
1762:             MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaLista")
1763:         ENDTRY
1764:     ENDPROC

*-- Linhas 2020 a 2030:
2020:     *==========================================================================
2021:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2022:         IF PEMSTATUS(THIS, "cnt_4c_Saida", 5) AND ;
2023:            PEMSTATUS(THIS.cnt_4c_Saida, "cmd_4c_Encerrar", 5)
2024:             THIS.cnt_4c_Saida.cmd_4c_Encerrar.Visible = .T.
2025:             THIS.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = .T.
2026:         ENDIF
2027:     ENDPROC
2028: 
2029:     *==========================================================================
2030:     * FormParaBO - Popula propriedades do BO com estado atual dos controles

*-- Linhas 2111 a 2120:
2111:     *==========================================================================
2112:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2113:         IF PEMSTATUS(THIS, "cnt_4c_Etiquetas", 5) AND THIS.cnt_4c_Etiquetas.Visible
2114:             IF PEMSTATUS(THIS.cnt_4c_Etiquetas, "cmd_4c_Imprimir", 5)
2115:                 THIS.cnt_4c_Etiquetas.cmd_4c_Imprimir.Enabled = par_lHabilitar
2116:             ENDIF
2117:         ENDIF
2118:     ENDPROC
2119: 
2120:     *==========================================================================


### BO (C:\4c\projeto\app\classes\SigPdM10BO.prg):
*==============================================================================
* SigPdM10BO.prg - Business Object para Resumo da Movimenta" + CHR(231) + CHR(227) + "o
* Form OPERACIONAL: recebe cursores pre-preparados do form pai via Init().
* Nao gerencia tabela CRUD direta - dados sao read-only a partir de cursores
* compartilhados da sessao de dados do form pai (xNensi, xPesa, xMFas).
*==============================================================================

DEFINE CLASS SigPdM10BO AS BusinessBase

    *-- Identificacao da movimentacao (lidos de TmpNens no Init do form)
    this_cEmps      = ""     && Codigo da empresa
    this_cDopps     = ""     && Tipo de operacao
    this_nNumps     = 0      && Numero da movimentacao
    this_dDatas     = {}     && Data da movimentacao
    this_cPosicaor  = ""     && Chave composta Emps+Dopps+Str(Numps,10)

    *-- Controle de modo de exibicao (definido por SigCdOpd.ResumoPOp)
    this_lExibeCntOps      = .F.    && .T. = exibir painel resumo por OP (CntOps)
    this_lMostrarEtiquetas = .F.    && Visibilidade do container de etiquetas

    *-- Configuracao de etiquetas (populados do container Etiquetas)
    this_nTipoEtiqueta   = 0     && Codigo nTipos do tipo selecionado (SigCdTpe.nTipos)
    this_lImpPreco       = .F.   && Imprimir preco na etiqueta
    this_lImpPeso        = .F.   && Imprimir peso na etiqueta
    this_cNomeImpressora = ""    && Nome da impressora Windows selecionada
    this_nTpImpressora   = 0     && Tipo: 1=Allegro, 2=Zebra ZPL, 3=Zebra EPL
    this_nAjVerts        = 0     && Ajuste vertical de impressao
    this_nAjHorzs        = 0     && Ajuste horizontal de impressao
    this_nAjDenss        = 10   && Densidade de impressao (10-20)
    this_nAjVelos        = 3     && Velocidade de impressao (1-3)

    *-- Titulo dinamico do label de pesos (depende do form pai)
    this_cTituloEnvelopes = ""   && Caption dinamico: "Peso por [Titulo do pai]"

    *-- Modo herdado do form pai (INSERIR/ALTERAR) para DtFechas
    this_cModoParent = ""

    *-- Flags de SigCdOpd para controle de impressao de etiquetas
    this_nChkUnis = 0    && Verifica se usa unidades para etiquetas
    this_nEtiqs   = 0    && Flag de etiquetas habilitadas

    *--------------------------------------------------------------------------
    * Init - Configuracao basica do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le cursor TmpNens e popula propriedades do BO
    * par_cAliasCursor: nome do alias "TmpNens" (cursor do form pai)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            GO TOP
            THIS.this_cEmps     = ALLTRIM(NVL(Emps,  ""))
            THIS.this_cDopps    = ALLTRIM(NVL(Dopps, ""))
            THIS.this_nNumps    = NVL(Numps, 0)
            THIS.this_dDatas    = NVL(DataS, {})
            THIS.this_cPosicaor = THIS.this_cEmps + THIS.this_cDopps + STR(THIS.this_nNumps, 10)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta Emps+Dopps+Str(Numps,10)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPosicaor
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel para form operacional sem persistencia direta
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para form operacional
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarModoCntOps - Consulta SigCdOpd.ResumoPOp para determinar layout
    * Popula: this_lExibeCntOps, this_nChkUnis, this_nEtiqs
    *--------------------------------------------------------------------------
    PROCEDURE VerificarModoCntOps()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_TmpOpd")
                TABLEREVERT(.T., "cursor_4c_TmpOpd")
                USE IN cursor_4c_TmpOpd
            ENDIF

            loc_cSQL = "SELECT ResumoPOp, ChkUnis, Etiqs FROM SigCdOpd WHERE Dopes = " + EscaparSQL(THIS.this_cDopps)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpd")

            IF loc_nRet > 0
                SELECT cursor_4c_TmpOpd
                IF NOT EOF()
                    IF VARTYPE(cursor_4c_TmpOpd.ResumoPOp) = "L"
                        THIS.this_lExibeCntOps = cursor_4c_TmpOpd.ResumoPOp
                    ELSE
                        IF VARTYPE(cursor_4c_TmpOpd.ResumoPOp) = "L"
                            THIS.this_lExibeCntOps = cursor_4c_TmpOpd.ResumoPOp
                        ELSE
                            IF VARTYPE(cursor_4c_TmpOpd.ResumoPOp) = "L"
                                THIS.this_lExibeCntOps = cursor_4c_TmpOpd.ResumoPOp
                            ELSE
                                IF VARTYPE(cursor_4c_TmpOpd.ResumoPOp) = "L"
                                    THIS.this_lExibeCntOps = cursor_4c_TmpOpd.ResumoPOp
                                ELSE
                                    THIS.this_lExibeCntOps = (NVL(cursor_4c_TmpOpd.ResumoPOp, 0) = 1)
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                    THIS.this_nChkUnis     = NVL(cursor_4c_TmpOpd.ChkUnis, 0)
                    THIS.this_nEtiqs       = NVL(cursor_4c_TmpOpd.Etiqs,   0)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao verificar modo de exibi" + CHR(231) + CHR(227) + "o.", "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursores - Cria cursores de trabalho para os grids
    * Cursores criados: xTotEnv, xTotMat, xTotPed, xTotMatOp, xMatOp, xTotPedOp
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursores()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            SET NULL ON

            IF USED("xTotEnv")
                USE IN xTotEnv
            ENDIF
            CREATE CURSOR xTotEnv (Nenvs N(10) NULL, Entrada N(12,3) NULL, Saida N(12,3) NULL)
            INDEX ON Nenvs TAG Nenvs

            IF USED("xTotMat")
                USE IN xTotMat
            ENDIF
            CREATE CURSOR xTotMat (CMats C(14) NULL, DPros C(40) NULL, CUnis C(3) NULL, Qtds N(10,3) NULL, Pesos N(10,3) NULL)
            INDEX ON CMats TAG CMats

            IF USED("xTotPed")
                USE IN xTotPed
            ENDIF
            CREATE CURSOR xTotPed (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6) NULL, MascNum C(6) NULL, NConta C(50) NULL, Repres C(50) NULL, Flag N(1) NULL, DtFechas D NULL)
            INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum

            IF USED("xTotMatOp")
                USE IN xTotMatOp
            ENDIF
            CREATE CURSOR xTotMatOp (CMats C(14) NULL, CUnis C(3) NULL, Qtds N(10,3) NULL, Pesos N(10,3) NULL)
            INDEX ON CMats TAG CMats

            IF USED("xMatOp")
                USE IN xMatOp
            ENDIF
            CREATE CURSOR xMatOp (CMats C(14) NULL, DPros C(40) NULL, CUnis C(3) NULL, Qtds N(10,3) NULL, Pesos N(10,3) NULL, Nops N(10) NULL)
            INDEX ON STR(Nops, 10) + CMats TAG NopMats

            IF USED("xTotPedOp")
                USE IN xTotPedOp
            ENDIF
            CREATE CURSOR xTotPedOp (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6) NULL, MascNum C(6) NULL, NConta C(50) NULL, Flag N(1) NULL, DtFechas D NULL, Nops N(10) NULL)
            INDEX ON Emps + Dopes + STR(Numes, 6) + STR(Nops, 10) TAG EdnNops

            SET NULL OFF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            SET NULL OFF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEnvelopes - Processa xPesa e popula xTotEnv.Saida
    * Agrupa pesos por envelope e insere totais em xTotEnv
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEnvelopes()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF NOT USED("xPesa")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SET NULL ON
            IF USED("cursor_4c_TmpEnv")
                USE IN cursor_4c_TmpEnv
            ENDIF
            SELECT Nenvs, SUM(Peso) AS tPeso ;
                FROM xPesa ;
                GROUP BY Nenvs ;
                ORDER BY Nenvs ;
                INTO CURSOR cursor_4c_TmpEnv READWRITE
            SET NULL OFF

            SELECT cursor_4c_TmpEnv
            SCAN
                LOCAL loc_nNenvE, loc_nPesoE
                loc_nNenvE = cursor_4c_TmpEnv.Nenvs
                loc_nPesoE = cursor_4c_TmpEnv.tPeso

                SELECT xTotEnv
                IF NOT SEEK(loc_nNenvE)
                    INSERT INTO xTotEnv (Nenvs, Entrada, Saida) VALUES (loc_nNenvE, 0, 0)
                ENDIF
                REPLACE Saida WITH loc_nPesoE IN xTotEnv

                RELEASE loc_nNenvE, loc_nPesoE
                SELECT cursor_4c_TmpEnv
            ENDSCAN

            IF USED("cursor_4c_TmpEnv")
                USE IN cursor_4c_TmpEnv
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarRateio - Ajusta quantidades/pesos de xNensi conforme logica de rateio
    * Distribui proporcional o peso da pesagem entre os itens de rateio=2
    * Rateio=3: descontado da pesagem total
    * Rateio=2: recebe proporcao + saldo de arredondamento no primeiro registro
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarRateio()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF NOT USED("xPesa") OR NOT USED("xNensi")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SET NULL ON
            IF USED("xRateio")
                USE IN xRateio
            ENDIF
            SELECT Nenvs, SUM(Peso) AS Pesos ;
                FROM xPesa ;
                GROUP BY Nenvs ;
                ORDER BY Nenvs ;
                INTO CURSOR xRateio READWRITE
            SET NULL OFF

            SELECT xRateio
            SCAN
                LOCAL loc_nNenv, loc_nPesagem, loc_nPesoAnt, loc_nRecno, loc_nDifPeso
                loc_nNenv    = xRateio.Nenvs
                loc_nPesagem = xRateio.Pesos
                loc_nPesoAnt = 0
                loc_nRecno   = 0

                SELECT xNensi
                SCAN FOR (Rateio = 3) AND (Nenvs = loc_nNenv) AND NOT FlagIncs
                    loc_nPesagem = loc_nPesagem - Pesos
                ENDSCAN

                SELECT xNensi
                SCAN FOR (Rateio = 2) AND (Nenvs = loc_nNenv) AND NOT FlagIncs
                    IF loc_nRecno = 0
                        loc_nRecno = RECNO()
                    ENDIF
                    loc_nPesoAnt = loc_nPesoAnt + PsFaseAnt
                ENDSCAN

                loc_nDifPeso = loc_nPesagem - loc_nPesoAnt

                SELECT xNensi
                SCAN FOR (Rateio = 2) AND (Nenvs = loc_nNenv) AND NOT FlagIncs
                    LOCAL loc_nDiv, loc_nNovoPeso
                    loc_nDiv      = IIF(loc_nPesoAnt = 0, 1, loc_nPesoAnt)
                    loc_nNovoPeso = ROUND(PsFaseAnt + (PsFaseAnt / loc_nDiv * loc_nDifPeso), 2)
                    REPLACE Pesos WITH loc_nNovoPeso, Qtds WITH loc_nNovoPeso
                    loc_nPesagem  = loc_nPesagem - loc_nNovoPeso
                    RELEASE loc_nDiv, loc_nNovoPeso
                ENDSCAN

                IF (loc_nRecno <> 0) AND (loc_nPesagem <> 0)
                    SELECT xNensi
                    GO loc_nRecno
                    REPLACE Pesos WITH xNensi.Pesos + loc_nPesagem, ;
                            Qtds  WITH xNensi.Qtds  + loc_nPesagem
                ENDIF

                RELEASE loc_nNenv, loc_nPesagem, loc_nPesoAnt, loc_nRecno, loc_nDifPeso
                SELECT xRateio
            ENDSCAN

            IF USED("xRateio")
                USE IN xRateio
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMateriais - Processa xNensi e popula xTotMat + atualiza xTotEnv.Entrada
    * Para cada item com Rateio in (2,3,5): acumula Qtds/Pesos em xTotMat
    * e acumula PsFaseAnt em xTotEnv.Entrada
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMateriais()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCMats, loc_cDPros, loc_cCUnis
        loc_lSucesso = .F.

        IF NOT USED("xNensi")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT xNensi
            SET ORDER TO
            SCAN
                IF INLIST(xNensi.Rateio, 2, 3, 5)
                    loc_cCMats = ALLTRIM(xNensi.CMats)

                    SELECT xTotMat
                    IF NOT SEEK(loc_cCMats)
                        IF USED("cursor_4c_LocalPro")
                            TABLEREVERT(.T., "cursor_4c_LocalPro")
                            USE IN cursor_4c_LocalPro
                        ENDIF
                        loc_cSQL = "SELECT CUnis, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCMats)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                        IF loc_nRet > 0 AND NOT EOF("cursor_4c_LocalPro")
                            SELECT cursor_4c_LocalPro
                            loc_cDPros = ALLTRIM(NVL(DPros, ""))
                            loc_cCUnis = ALLTRIM(NVL(CUnis, ""))
                        ELSE
                            loc_cDPros = ""
                            loc_cCUnis = ""
                        ENDIF

                        INSERT INTO xTotMat (CMats, DPros, CUnis, Qtds, Pesos) ;
                            VALUES (loc_cCMats, loc_cDPros, loc_cCUnis, 0, 0)
                    ENDIF

                    REPLACE Qtds  WITH xTotMat.Qtds  + xNensi.Qtds, ;
                            Pesos WITH xTotMat.Pesos + xNensi.Pesos IN xTotMat

                    SELECT xTotEnv
                    IF NOT SEEK(xNensi.Nenvs)
                        INSERT INTO xTotEnv (Nenvs, Entrada, Saida) VALUES (xNensi.Nenvs, 0, 0)
                    ENDIF
                    REPLACE Entrada WITH xTotEnv.Entrada + xNensi.PsFaseAnt IN xTotEnv

                    SELECT xNensi
                ENDIF
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPedidosBaixados - Processa xMFas e popula xTotPed + xTotPedOp
    * Para cada OP (xMFas.Nops): busca pedidos via SigOpPic, monta NConta via
    * SigMvCab + SigCdCli e insere em xTotPed e xTotPedOp
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPedidosBaixados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cEmp, loc_cEdn, loc_cNConta, loc_cConta, loc_cVends, loc_nNops
        loc_lSucesso = .F.

        IF NOT USED("xMFas")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT xMFas
            SCAN
                loc_nNops = xMFas.Nops

                IF USED("cursor_4c_LocalOpi")
                    TABLEREVERT(.T., "cursor_4c_LocalOpi")
                    USE IN cursor_4c_LocalOpi
                ENDIF
                loc_cSQL = "SELECT Emps, Dopes, Numes, EmpDs FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(loc_nNops)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpi")

                IF loc_nRet > 0
                    SELECT cursor_4c_LocalOpi
                    SCAN
                        loc_cEmp = IIF(EMPTY(cursor_4c_LocalOpi.EmpDs), ;
                                       ALLTRIM(cursor_4c_LocalOpi.Emps), ;
                                       ALLTRIM(cursor_4c_LocalOpi.EmpDs))
                        loc_cEdn = loc_cEmp + ALLTRIM(cursor_4c_LocalOpi.Dopes) + STR(cursor_4c_LocalOpi.Numes, 6)

                        SELECT xTotPed
                        IF NOT SEEK(loc_cEdn)
                            IF USED("cursor_4c_LocalEest")
                                TABLEREVERT(.T., "cursor_4c_LocalEest")
                                USE IN cursor_4c_LocalEest
                            ENDIF
                            loc_cSQL = "SELECT ContaOs, ContaDs, Vends FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)
                            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEest")

                            IF loc_nRet > 0 AND NOT EOF("cursor_4c_LocalEest")
                                SELECT cursor_4c_LocalEest
                                loc_cConta = IIF(EMPTY(cursor_4c_LocalEest.ContaDs), ;
                                                 ALLTRIM(cursor_4c_LocalEest.ContaOs), ;
                                                 ALLTRIM(cursor_4c_LocalEest.ContaDs))
                                loc_cVends = ALLTRIM(NVL(cursor_4c_LocalEest.Vends, ""))
                            ELSE
                                loc_cConta = ""
                                loc_cVends = ""
                            ENDIF

                            IF USED("cursor_4c_LocalCli")
                                TABLEREVERT(.T., "cursor_4c_LocalCli")
                                USE IN cursor_4c_LocalCli
                            ENDIF
                            IF NOT EMPTY(loc_cConta)
                                loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta)
                                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCli")
                                IF loc_nRet > 0 AND NOT EOF("cursor_4c_LocalCli")
                                    SELECT cursor_4c_LocalCli
                                    loc_cNConta = loc_cConta + " / " + ALLTRIM(NVL(RClis, ""))
                                ELSE
                                    loc_cNConta = loc_cConta
                                ENDIF
                            ELSE
                                loc_cNConta = ""
                            ENDIF

                            SELECT cursor_4c_LocalOpi
                            INSERT INTO xTotPed (Emps, Dopes, Numes, MascNum, NConta, Repres, Flag) ;
                                VALUES (loc_cEmp, ALLTRIM(cursor_4c_LocalOpi.Dopes), ;
                                        cursor_4c_LocalOpi.Numes, ;
                                        ALLTRIM(STR(cursor_4c_LocalOpi.Numes, 6)), ;
                                        loc_cNConta, loc_cVends, 0)

                            INSERT INTO xTotPedOp (Emps, Dopes, Numes, MascNum, NConta, Nops, Flag) ;
                                VALUES (loc_cEmp, ALLTRIM(cursor_4c_LocalOpi.Dopes), ;
                                        cursor_4c_LocalOpi.Numes, ;
                                        ALLTRIM(STR(cursor_4c_LocalOpi.Numes, 6)), ;
                                        loc_cNConta, loc_nNops, 0)
                        ENDIF

                        SELECT cursor_4c_LocalOpi
                    ENDSCAN
                ENDIF

                SELECT xMFas
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarResumoPorOP - Processa xNensi e popula xMatOp; copia xTotMat em xTotMatOp
    * Para cada item com Rateio in (2,3,5): acumula em xMatOp indexado por Nops+CMats
    *--------------------------------------------------------------------------
    PROCEDURE CarregarResumoPorOP()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCMats, loc_cDPros, loc_cCUnis, loc_nNops
        loc_lSucesso = .F.

        IF NOT USED("xNensi")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT xNensi
            SET ORDER TO
            SCAN
                IF INLIST(xNensi.Rateio, 2, 3, 5)
                    loc_cCMats = ALLTRIM(xNensi.CMats)
                    loc_nNops  = xNensi.Nops

                    SELECT xMatOp
                    IF NOT SEEK(STR(loc_nNops, 10) + loc_cCMats)
                        IF USED("cursor_4c_LocalPro")
                            TABLEREVERT(.T., "cursor_4c_LocalPro")
                            USE IN cursor_4c_LocalPro
                        ENDIF
                        loc_cSQL = "SELECT CUnis, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCMats)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                        IF loc_nRet > 0 AND NOT EOF("cursor_4c_LocalPro")
                            SELECT cursor_4c_LocalPro
                            loc_cDPros = ALLTRIM(NVL(DPros, ""))
                            loc_cCUnis = ALLTRIM(NVL(CUnis, ""))
                        ELSE
                            loc_cDPros = ""
                            loc_cCUnis = ""
                        ENDIF

                        INSERT INTO xMatOp (CMats, DPros, CUnis, Qtds, Pesos, Nops) ;
                            VALUES (loc_cCMats, loc_cDPros, loc_cCUnis, 0, 0, loc_nNops)
                    ENDIF

                    REPLACE Qtds  WITH xMatOp.Qtds  + xNensi.Qtds, ;
                            Pesos WITH xMatOp.Pesos + xNensi.Pesos IN xMatOp

                    SELECT xNensi
                ENDIF
            ENDSCAN

            SELECT xTotMat
            SCAN
                INSERT INTO xTotMatOp (CMats, CUnis, Qtds, Pesos) ;
                    VALUES (xTotMat.CMats, xTotMat.CUnis, xTotMat.Qtds, xTotMat.Pesos)
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarPedidosFechados - Verifica SigCdNec (ChkSubn) por pedido em xTotPed
    * Remove pedidos em aberto (Flag=0) e preenche DtFechas nos fechados
    *--------------------------------------------------------------------------
    PROCEDURE MarcarPedidosFechados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cChave, loc_lAberto, loc_cChaveP
        loc_lSucesso = .F.

        TRY
            SELECT xTotPed
            SCAN
                loc_cChave  = ALLTRIM(Emps) + ALLTRIM(Dopes) + STR(Numes, 6)
                loc_lAberto = .F.

                IF USED("cursor_4c_LocalOpi")
                    TABLEREVERT(.T., "cursor_4c_LocalOpi")
                    USE IN cursor_4c_LocalOpi
                ENDIF
                loc_cSQL = "SELECT Emps, Dopps, Nops FROM SigOpPic WHERE EmpDopNums = " + EscaparSQL(loc_cChave)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpi")

                IF loc_nRet > 0
                    SELECT cursor_4c_LocalOpi
                    SCAN
                        loc_cChaveP = ALLTRIM(cursor_4c_LocalOpi.Emps) + ;
                                      ALLTRIM(cursor_4c_LocalOpi.Dopps) + ;
                                      STR(cursor_4c_LocalOpi.Nops, 10)

                        IF USED("cursor_4c_LocalNens")
                            TABLEREVERT(.T., "cursor_4c_LocalNens")
                            USE IN cursor_4c_LocalNens
                        ENDIF
                        loc_cSQL = "SELECT ChkSubn FROM SigCdNec WHERE EmpDNPs = " + EscaparSQL(loc_cChaveP)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNens")

                        IF loc_nRet > 0 AND NOT EOF("cursor_4c_LocalNens")
                            SELECT cursor_4c_LocalNens
                            IF NOT NVL(ChkSubn, .F.)
                                loc_lAberto = .T.
                                EXIT
                            ENDIF
                        ELSE
                            loc_lAberto = .T.
                            EXIT
                        ENDIF

                        SELECT cursor_4c_LocalOpi
                    ENDSCAN
                ENDIF

                IF NOT loc_lAberto
                    REPLACE Flag WITH 1 IN xTotPed
                ENDIF

                SELECT xTotPed
            ENDSCAN

            SELECT xTotPed
            DELETE FOR Flag = 0
            PACK

            IF INLIST(THIS.this_cModoParent, "INSERIR", "ALTERAR")
                IF USED("TmpNens")
                    SELECT TmpNens
                    LOCAL loc_dDataS
                    loc_dDataS = NVL(DataS, DATE())
                    SELECT xTotPed
                    SCAN
                        REPLACE DtFechas WITH loc_dDataS
                    ENDSCAN
                    RELEASE loc_dDataS
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Orquestra o processo completo de carregamento de dados
    * Sequencia: PrepararCursores > Envelopes > Rateio > Materiais >
    *            PedidosBaixados > ResumoPorOP > MarcarFechados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.PrepararCursores()
            IF loc_lSucesso
                loc_lSucesso = THIS.CarregarEnvelopes()
            ENDIF
            IF loc_lSucesso
                loc_lSucesso = THIS.ProcessarRateio()
            ENDIF
            IF loc_lSucesso
                loc_lSucesso = THIS.CarregarMateriais()
            ENDIF
            IF loc_lSucesso
                loc_lSucesso = THIS.CarregarPedidosBaixados()
            ENDIF
            IF loc_lSucesso
                loc_lSucesso = THIS.CarregarResumoPorOP()
            ENDIF
            IF loc_lSucesso
                loc_lSucesso = THIS.MarcarPedidosFechados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Cria crImpreV combinando impressoras SQL + Windows
    * Consulta: SigSyImp/SigCdAcG para impressoras autorizadas ao usuario
    *           APRINTERS() para impressoras instaladas no Windows
    *--------------------------------------------------------------------------
    PROCEDURE CarregarImpressoras()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_nPrinters, loc_aPrinters, loc_nI
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT b.* FROM SigSyImp a, SigCdmp b" + ;
                       " WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " AND a.cimps = b.impres" + ;
                       " UNION ALL " + ;
                       "SELECT c.* FROM SigCdAcG a, SigSyImp b, SigCdmp c" + ;
                       " WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " AND a.Grupos = b.GrAcess AND b.Cimps = c.Impres"

            IF USED("cursor_4c_TmpCimp")
                TABLEREVERT(.T., "cursor_4c_TmpCimp")
                USE IN cursor_4c_TmpCimp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCimp")

            IF loc_nRet <= 0
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o com Servidor de Banco de Dados.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_SigCdmp")
                TABLEREVERT(.T., "cursor_4c_SigCdmp")
                USE IN cursor_4c_SigCdmp
            ENDIF

            IF RECCOUNT("cursor_4c_TmpCimp") > 0
                SELECT DISTINCT Impres, nTpImpres FROM cursor_4c_TmpCimp ;
                    INTO CURSOR cursor_4c_SigCdmp READWRITE
                SELECT cursor_4c_SigCdmp
                INDEX ON Impres TAG skImpres
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_SigCdmp (Impres C(50) NULL, nTpImpres N(2) NULL)
                INDEX ON Impres TAG skImpres
                SET NULL OFF
            ENDIF

            DIMENSION loc_aPrinters(1)
            loc_nPrinters = APRINTERS(loc_aPrinters)

            IF loc_nPrinters = 0
                MsgAviso("N" + CHR(227) + "o Foi Encontrada Nenhuma Impressora!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_ImpWin")
                USE IN cursor_4c_ImpWin
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_ImpWin (Impres C(50) NULL)
            SET NULL OFF
            FOR loc_nI = 1 TO loc_nPrinters
                INSERT INTO cursor_4c_ImpWin (Impres) VALUES (UPPER(loc_aPrinters(loc_nI, 1)))
            ENDFOR

            IF USED("cursor_4c_ImpMatch")
                TABLEREVERT(.T., "cursor_4c_ImpMatch")
                USE IN cursor_4c_ImpMatch
            ENDIF
            SELECT PADR(ALLTRIM(a.Impres), 15) + " " + ALLTRIM(b.Impres) AS IDupla, ;
                   b.Impres, a.Impres AS impresS ;
                FROM cursor_4c_SigCdmp a, cursor_4c_ImpWin b ;
                WHERE ALLTRIM(UPPER(a.Impres)) LIKE "%" + ALLTRIM(UPPER(b.Impres)) + "%" ;
                GROUP BY b.Impres, a.Impres ;
                INTO CURSOR cursor_4c_ImpMatch READWRITE

            IF RECCOUNT("cursor_4c_ImpMatch") > 1
                SELECT cursor_4c_ImpMatch
                APPEND BLANK
            ENDIF

            IF USED("crImpreV")
                USE IN crImpreV
            ENDIF
            SELECT * FROM cursor_4c_ImpMatch ORDER BY 1 INTO CURSOR crImpreV READWRITE

            SELECT crImpreV
            GO TOP

            IF USED("cursor_4c_ImpMatch")
                USE IN cursor_4c_ImpMatch
            ENDIF
            IF USED("cursor_4c_ImpWin")
                USE IN cursor_4c_ImpWin
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDbImpressao - Monta cursor dbImpressao para uso por SigOpEtq
    * par_nTipoEtq: codigo do tipo de etiqueta selecionado (SigCdTpe.nTipos)
    * Cursor dbImpressao fica disponivel para o form chamar =SigOpEtq(...)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDbImpressao(par_nTipoEtq)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cChaveNs
        loc_lSucesso = .F.

        TRY
            loc_cChaveNs = THIS.this_cEmps + THIS.this_cDopps + STR(THIS.this_nNumps, 6)

            IF USED("dbImpressao")
                USE IN dbImpressao
            ENDIF
            SET NULL ON
            CREATE CURSOR dbImpressao (Cpros C(14) NULL, Dpros C(40) NULL, Qtds N(1) NULL, ;
                                       QtdeEtiq N(10,3) NULL, Pedido C(30) NULL, Obs C(10) NULL, ;
                                       Nops N(10) NULL, Notas C(6) NULL, Aros C(50) NULL, ;
                                       Pesos N(12,3) NULL, Contas C(10) NULL, ;
                                       EmpDopNums C(29) NULL, Reffs C(20) NULL, ;
                                       empos C(3) NULL, cpros1 C(14) NULL, codtams C(4) NULL)
            SET NULL OFF

            IF par_nTipoEtq = 74
                THIS.PrepararDbImpressaoOP(loc_cChaveNs)
            ELSE
                THIS.PrepararDbImpressaoPadrao(par_nTipoEtq, loc_cChaveNs)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDbImpressaoOP - Preenche dbImpressao para etiqueta de OP (tipo 74)
    * Consulta SigOpEtq + SigEtPos e lookup em SigCdPro, SigCdOpe, SigCdPsg, SigOpPic
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDbImpressaoOP(par_cChaveNs)
        LOCAL loc_cSQL, loc_nRet
        LOCAL loc_cCPros, loc_cDopeOs, loc_cDPros, loc_cCGrus, loc_cSGrus
        LOCAL loc_lColecoes, loc_cClassis, loc_cAro, loc_nNops, loc_cAbrevs

        TRY
            IF USED("cursor_4c_LocalEti")
                TABLEREVERT(.T., "cursor_4c_LocalEti")
                USE IN cursor_4c_LocalEti
            ENDIF

            loc_cSQL = "SELECT Cpros,Nops,Qtds,ObsEtiqs AS Obs,Emps,Numes,Dopes,Empos,DopeOs,NumeOs," + ;
                       "CodTams,Pesos,CodCors,Peso2s FROM SigOpEtq" + ;
                       " WHERE EmpDopNums = " + EscaparSQL(par_cChaveNs) + ;
                       " UNION ALL " + ;
                       "SELECT Cpros,Nops,Qtds,ObsEtiqs AS Obs,Emps,Numes,Dopes,Empos,DopeOs,NumeOs," + ;
                       "CodTams,Pesos,CodCors,Peso2s FROM SigEtPos" + ;
                       " WHERE EmpDopNums = " + EscaparSQL(par_cChaveNs) + ;
                       " ORDER BY Nops"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEti")

            IF loc_nRet <= 0
                RETURN
            ENDIF

            SELECT cursor_4c_LocalEti
            SCAN
                loc_cCPros  = ALLTRIM(cursor_4c_LocalEti.CPros)
                loc_cDopeOs = ALLTRIM(cursor_4c_LocalEti.DopeOs)
                loc_nNops   = cursor_4c_LocalEti.Nops

                IF USED("cursor_4c_LocalPro")
                    TABLEREVERT(.T., "cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF
                loc_cSQL = "SELECT Cpros,CGrus,SGrus,DPros,Colecoes FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")

                IF USED("cursor_4c_LocalOpe")
                    TABLEREVERT(.T., "cursor_4c_LocalOpe")
                    USE IN cursor_4c_LocalOpe
                ENDIF
                loc_cSQL = "SELECT Abrevs FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopeOs)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")

                IF NOT EOF("cursor_4c_LocalPro")
                    SELECT cursor_4c_LocalPro
                    loc_cCGrus    = ALLTRIM(NVL(CGrus, ""))
                    loc_cSGrus    = ALLTRIM(NVL(SGrus, ""))
                    loc_cDPros    = ALLTRIM(NVL(DPros, ""))
                    loc_lColecoes = NOT EMPTY(NVL(Colecoes, ""))
                ELSE
                    loc_cCGrus    = ""
                    loc_cSGrus    = ""
                    loc_cDPros    = ""
                    loc_lColecoes = .F.
                ENDIF

                IF USED("cursor_4c_LocalSGru")
                    TABLEREVERT(.T., "cursor_4c_LocalSGru")
                    USE IN cursor_4c_LocalSGru
                ENDIF
                loc_cSQL = "SELECT Descricaos FROM SigCdPsg WHERE CGruCods = " + EscaparSQL(loc_cCGrus + loc_cSGrus)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalSGru")

                IF USED("cursor_4c_LocalOpi")
                    TABLEREVERT(.T., "cursor_4c_LocalOpi")
                    USE IN cursor_4c_LocalOpi
                ENDIF
                loc_cSQL = "SELECT Notas,CodTams,CodCors,Numes,dopes FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(loc_nNops)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpi")

                loc_cAro = ""

                IF NOT EOF("cursor_4c_LocalOpi")
                    SELECT cursor_4c_LocalOpi
                    LOCAL loc_lNaoN, loc_nNumeOs, loc_cDopesOi
                    loc_lNaoN   = NOT EMPTY(NVL(notas, ""))
                    loc_nNumeOs = NVL(Numes, 0)
                    loc_cDopesOi = ALLTRIM(NVL(dopes, ""))

                    loc_cClassis = PADC(IIF(loc_lColecoes AND loc_cSGrus <> PADR("N", 6), ;
                                            "Fundi" + CHR(231) + CHR(227) + "o", ;
                                            IIF(loc_lNaoN, "Os", "Alian" + CHR(231) + "a")), 10)

                    IF loc_cClassis = PADC("Os", 10)
                        IF USED("cursor_4c_CsSelecao")
                            USE IN cursor_4c_CsSelecao
                        ENDIF
                        SELECT DISTINCT CodTams FROM cursor_4c_LocalOpi ;
                            INTO CURSOR cursor_4c_CsSelecao READWRITE ;
                            ORDER BY CodTams
                        SELECT cursor_4c_CsSelecao
                        SCAN
                            loc_cAro = loc_cAro + ALLTRIM(NVL(CodTams, "")) + "/"
                        ENDSCAN
                        IF USED("cursor_4c_CsSelecao")
                            USE IN cursor_4c_CsSelecao
                        ENDIF
                    ENDIF

                    IF NOT EOF("cursor_4c_LocalOpe")
                        SELECT cursor_4c_LocalOpe
                        loc_cAbrevs = ALLTRIM(NVL(Abrevs, ""))
                    ELSE
                        loc_cAbrevs = ""
                    ENDIF

                    SELECT cursor_4c_LocalEti
                    INSERT INTO dbImpressao (CPros, DPros, Qtds, QtdeEtiq, Pedido, Obs, Nops, Notas, Aros, Pesos) ;
                        VALUES (loc_cCPros, loc_cDPros, 1, ;
                                NVL(cursor_4c_LocalEti.Qtds, 0), ;
                                loc_cAbrevs + " : " + ALLTRIM(STR(NVL(cursor_4c_LocalEti.NumeOs, 0), 6)), ;
                                ALLTRIM(NVL(cursor_4c_LocalEti.Obs, "")), ;
                                loc_nNops, ;
                                PADR(IIF(loc_lNaoN, ALLTRIM(NVL(cursor_4c_LocalOpi.notas, "")), ""), 6), ;
                                PADR(loc_cAro, 50), ;
                                NVL(cursor_4c_LocalEti.Pesos, 0))

                    RELEASE loc_lNaoN, loc_nNumeOs, loc_cDopesOi, loc_cClassis
                ENDIF

                RELEASE loc_cCPros, loc_cDopeOs, loc_cDPros, loc_cCGrus, loc_cSGrus
                RELEASE loc_lColecoes, loc_cAro, loc_nNops, loc_cAbrevs
                SELECT cursor_4c_LocalEti
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDbImpressaoPadrao - Preenche dbImpressao para tipos de etiqueta nao-OP
    * Consulta SigOpEtq; para tipos 14,39,109,113 inclui dados de SigMvCab/SigCdCli
    * Se ChkUnis=1 e Etiqs=1, inclui etiquetas extras de SigEtPos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDbImpressaoPadrao(par_nTipoEtq, par_cChaveNs)
        LOCAL loc_cSQL, loc_nRet
        LOCAL loc_cCPros, loc_cDPros, loc_nCBars, loc_nNops, loc_cAbrevs

        TRY
            IF USED("cursor_4c_LocalEti")
                TABLEREVERT(.T., "cursor_4c_LocalEti")
                USE IN cursor_4c_LocalEti
            ENDIF
            loc_cSQL = "SELECT Cpros,Cbars,Qtds,ObsEtiqs AS Obs,Emps,Numes,Dopes,Empos,DopeOs,NumeOs,Nops" + ;
                       " FROM SigOpEtq" + ;
                       " WHERE EmpDopNums = " + EscaparSQL(par_cChaveNs) + ;
                       " ORDER BY Cbars"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEti")

            IF loc_nRet <= 0
                RETURN
            ENDIF

            SELECT cursor_4c_LocalEti
            SCAN
                loc_cCPros = ALLTRIM(cursor_4c_LocalEti.CPros)
                loc_nCBars = cursor_4c_LocalEti.Cbars
                loc_nNops  = cursor_4c_LocalEti.Nops

                IF USED("cursor_4c_LocalPro")
                    TABLEREVERT(.T., "cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF
                loc_cSQL = "SELECT CGrus, SGrus, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                IF NOT EOF("cursor_4c_LocalPro")
                    SELECT cursor_4c_LocalPro
                    loc_cDPros = ALLTRIM(NVL(DPros, ""))
                ELSE
                    loc_cDPros = ""
                ENDIF

                IF USED("cursor_4c_LocalOpe")
                    TABLEREVERT(.T., "cursor_4c_LocalOpe")
                    USE IN cursor_4c_LocalOpe
                ENDIF
                loc_cSQL = "SELECT Abrevs, globalizas FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(cursor_4c_LocalEti.Dopes))
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")

                IF USED("cursor_4c_LocalOpeO")
                    TABLEREVERT(.T., "cursor_4c_LocalOpeO")
                    USE IN cursor_4c_LocalOpeO
                ENDIF
                loc_cSQL = "SELECT Abrevs, globalizas FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(cursor_4c_LocalEti.DopeOs))
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpeO")

                IF NOT EOF("cursor_4c_LocalOpe")
                    SELECT cursor_4c_LocalOpe
                    loc_cAbrevs = ALLTRIM(NVL(Abrevs, ""))
                ELSE
                    loc_cAbrevs = ""
                ENDIF

                SELECT cursor_4c_LocalEti
                INSERT INTO dbImpressao (CPros, DPros, Qtds, QtdeEtiq, Pedido, Obs) ;
                    VALUES (STR(loc_nCBars, 14), loc_cDPros, 1, ;
                            NVL(cursor_4c_LocalEti.Qtds, 0), ;
                            loc_cAbrevs + " : " + ALLTRIM(STR(NVL(cursor_4c_LocalEti.NumeOs, 0), 6)), ;
                            ALLTRIM(NVL(cursor_4c_LocalEti.Obs, "")))

                IF INLIST(par_nTipoEtq, 14, 39, 109, 113)
                    IF USED("cursor_4c_LocalOpi")
                        TABLEREVERT(.T., "cursor_4c_LocalOpi")
                        USE IN cursor_4c_LocalOpi
                    ENDIF
                    loc_cSQL = "SELECT Emps, Dopes, Numes, EmpDs FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(loc_nNops)
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpi")

                    IF NOT EOF("cursor_4c_LocalOpi")
                        SELECT cursor_4c_LocalOpi

                        LOCAL loc_cEdnL
                        loc_cEdnL = ALLTRIM(cursor_4c_LocalEti.Empos) + ;
                                    ALLTRIM(cursor_4c_LocalEti.DopeOs) + ;
                                    STR(NVL(cursor_4c_LocalEti.NumeOs, 0), 6)

                        IF USED("cursor_4c_LocalEest")
                            TABLEREVERT(.T., "cursor_4c_LocalEest")
                            USE IN cursor_4c_LocalEest
                        ENDIF
                        loc_cSQL = "SELECT ContaOs, ContaDs FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEdnL)
                        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEest")

                        LOCAL loc_lGlobaliza, loc_cContaL
                        IF NOT EOF("cursor_4c_LocalOpeO")
                            SELECT cursor_4c_LocalOpeO
                            IF VARTYPE(globalizas) = "L"
                                loc_lGlobaliza = globalizas
                            ELSE
                                IF VARTYPE(globalizas) = "L"
                                    loc_lGlobaliza = globalizas
                                ELSE
                                    IF VARTYPE(globalizas) = "L"
                                        loc_lGlobaliza = globalizas
                                    ELSE
                                        IF VARTYPE(globalizas) = "L"
                                            loc_lGlobaliza = globalizas
                                        ELSE
                                            loc_lGlobaliza = (NVL(globalizas, 0) = 1)
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ELSE
                            loc_lGlobaliza = .F.
                        ENDIF

                        IF NOT EOF("cursor_4c_LocalEest")
                            SELECT cursor_4c_LocalEest
                            loc_cContaL = IIF(loc_lGlobaliza, ;
                                              ALLTRIM(NVL(ContaOs, "")), ;
                                              ALLTRIM(NVL(ContaDs, "")))
                        ELSE
                            loc_cContaL = ""
                        ENDIF

                        IF INLIST(par_nTipoEtq, 109, 113)
                            IF USED("cursor_4c_LocalCli")
                                TABLEREVERT(.T., "cursor_4c_LocalCli")
                                USE IN cursor_4c_LocalCli
                            ENDIF
                            loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cContaL)
                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCli")
                            IF NOT EOF("cursor_4c_LocalCli")
                                SELECT cursor_4c_LocalCli
                                loc_cContaL = ALLTRIM(NVL(Rclis, ""))
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_LocalEti
                        IF par_nTipoEtq <> 14
                            REPLACE Pedido WITH loc_cContaL + ;
                                IIF(INLIST(par_nTipoEtq, 39), "/" + ALLTRIM(STR(NVL(cursor_4c_LocalEti.NumeOs, 0), 6)), "") ;
                                IN dbImpressao
                        ELSE
                            REPLACE Contas WITH loc_cContaL IN dbImpressao
                        ENDIF

                        RELEASE loc_cEdnL, loc_lGlobaliza, loc_cContaL
                    ENDIF
                ENDIF

                RELEASE loc_cCPros, loc_cDPros, loc_nCBars, loc_nNops, loc_cAbrevs
                SELECT cursor_4c_LocalEti
            ENDSCAN

            IF THIS.this_nChkUnis = 1 AND THIS.this_nEtiqs = 1
                IF USED("cursor_4c_LocalEtiPos")
                    TABLEREVERT(.T., "cursor_4c_LocalEtiPos")
                    USE IN cursor_4c_LocalEtiPos
                ENDIF
                loc_cSQL = "SELECT Cpros,Cbars,Qtds,ObsEtiqs,Emps,Numes,Dopes FROM SigEtPos" + ;
                           " WHERE EmpDopNums = " + EscaparSQL(par_cChaveNs)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEtiPos")

                IF loc_nRet > 0
                    SELECT cursor_4c_LocalEtiPos
                    SCAN
                        INSERT INTO dbImpressao (CPros, Qtds) ;
                            VALUES (cursor_4c_LocalEtiPos.CPros, cursor_4c_LocalEtiPos.Qtds)
                    ENDSCAN
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

