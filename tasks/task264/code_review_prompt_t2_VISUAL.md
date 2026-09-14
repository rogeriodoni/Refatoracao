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
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCfn.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1664 linhas total):

*-- Linhas 46 a 54:
46:     *---------------------------------------------------------------------------
47:         LPARAMETERS par_nVal, par_nTip, par_nJMe, par_nJDi, par_dDtB, par_dDtF
48: 
49:         THIS.Caption = "C" + CHR(225) + "lculo de Juros"
50: 
51:         IF VARTYPE(par_nVal) = "N" AND par_nVal > 0
52:             THIS.this_nParVal = par_nVal
53:         ENDIF
54:         IF VARTYPE(par_nTip) = "N" AND INLIST(par_nTip, 1, 2)

*-- Linhas 93 a 102:
93: 
94:                 THIS.ConfigurarCabecalho()
95:                 THIS.ConfigurarPageFrame()
96:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
97:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
98:                 THIS.ConfigurarBotoes()
99:                 THIS.ConfigurarPaginaLista()
100:                 THIS.ConfigurarPaginaVencimentos()
101:                 THIS.ConfigurarPaginaDados()
102:                 THIS.PopularCamposIniciais()

*-- Linhas 130 a 179:
130: 
131:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
132:         WITH THIS.cnt_4c_Cabecalho
133:             .Top         = 0
134:             .Left        = 0
135:             .Width       = loc_nW
136:             .Height      = 80
137:             .BorderWidth = 0
138:             .BackStyle   = 1
139:             .BackColor   = RGB(100, 100, 100)
140:             .Visible     = .T.
141: 
142:             .AddObject("lbl_4c_Sombra", "Label")
143:             WITH .lbl_4c_Sombra
144:                 .FontBold  = .T.
145:                 .FontName  = "Tahoma"
146:                 .FontSize  = 18
147:                 .WordWrap  = .T.
148:                 .Alignment = 0
149:                 .BackStyle = 0
150:                 .AutoSize  = .F.
151:                 .Width     = loc_nW
152:                 .Height    = 40
153:                 .Left      = 10
154:                 .Top       = 18
155:                 .ForeColor = RGB(0, 0, 0)
156:                 .Caption   = "C" + CHR(225) + "lculo de Juros"
157:                 .Visible   = .T.
158:             ENDWITH
159: 
160:             .AddObject("lbl_4c_Titulo", "Label")
161:             WITH .lbl_4c_Titulo
162:                 .FontBold  = .T.
163:                 .FontName  = "Tahoma"
164:                 .FontSize  = 18
165:                 .WordWrap  = .T.
166:                 .Alignment = 0
167:                 .BackStyle = 0
168:                 .AutoSize  = .F.
169:                 .Width     = loc_nW
170:                 .Height    = 46
171:                 .Left      = 10
172:                 .Top       = 17
173:                 .ForeColor = RGB(255, 255, 255)
174:                 .Caption   = "C" + CHR(225) + "lculo de Juros"
175:                 .Visible   = .T.
176:             ENDWITH
177:         ENDWITH
178:     ENDPROC
179: 

*-- Linhas 188 a 231:
188:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
189:         WITH THIS.pgf_4c_Paginas
190:             .PageCount   = 2
191:             .Top         = 80
192:             .Left        = 0
193:             .Width       = 600
194:             .Height      = 220
195:             .Tabs        = .F.
196:             .BorderWidth = 0
197:             .BackStyle   = 0
198:             .Visible     = .T.
199: 
200:             .Page1.Caption = "C" + CHR(225) + "lculo"
201:             .Page2.Caption = "Vencimentos"
202:         ENDWITH
203:     ENDPROC
204: 
205:     *---------------------------------------------------------------------------
206:     * ConfigurarBotoes - Container do botao Sair (equivalente ao btnOK legado).
207:     * Posicao original: Top=3, Left=525, Width=75, Height=75 (icone-only).
208:     *---------------------------------------------------------------------------
209:     PROTECTED PROCEDURE ConfigurarBotoes()
210:         THIS.AddObject("cnt_4c_Botoes", "Container")
211:         WITH THIS.cnt_4c_Botoes
212:             .Top         = 3
213:             .Left        =  542
214:             .Width       = 78
215:             .Height      = 77
216:             .BorderWidth = 0
217:             .BackStyle   = 0
218:             .Visible     = .T.
219: 
220:             .AddObject("cmd_4c_BtnOK", "CommandButton")
221:             WITH .cmd_4c_BtnOK
222:                 .Top             = 1
223:                 .Left            =  542
224:                 .Height          = 75
225:                 .Width           = 75
226:                 .Caption         = "Sair"
227:                 .Cancel          = .T.
228:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
229:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
230:                 .FontName        = "Tahoma"
231:                 .FontBold        = .T.

*-- Linhas 242 a 250:
242:             ENDWITH
243:         ENDWITH
244: 
245:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_BtnOK, "Click", THIS, "BtnSairClick")
246:     ENDPROC
247: 
248:     *---------------------------------------------------------------------------
249:     * BtnSairClick - Fecha o form (botao Sair - Cancel=.T., dispara com ESC).
250:     *---------------------------------------------------------------------------

*-- Linhas 493 a 692:
493:         loc_oPag = THIS.pgf_4c_Paginas.Page1
494: 
495:         *-- Linha 1: Valor Base (esq) | Data Base (dir)
496:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
497:         WITH loc_oPag.lbl_4c_Label1
498:             .Caption   = "Valor Base :"
499:             .FontName  = "Tahoma"
500:             .FontSize  = 8
501:             .BackStyle = 0
502:             .ForeColor = RGB(0, 0, 0)
503:             .Left      = 36
504:             .Top       = 11
505:             .AutoSize  = .T.
506:         ENDWITH
507: 
508:         loc_oPag.AddObject("txt_4c_ValorBase", "TextBox")
509:         WITH loc_oPag.txt_4c_ValorBase
510:             .Alignment     = 3
511:             .Value         = 0
512:             .InputMask     = "99,999,999.99"
513:             .Left          = 97
514:             .Top           = 7
515:             .Width         = 115
516:             .Height        = 20
517:             .SpecialEffect = 1
518:             .ForeColor     = RGB(0, 0, 0)
519:             .BorderColor   = RGB(100, 100, 100)
520:             .FontName      = "Tahoma"
521:             .FontSize      = 8
522:         ENDWITH
523: 
524:         loc_oPag.AddObject("lbl_4c_Label6", "Label")
525:         WITH loc_oPag.lbl_4c_Label6
526:             .Caption   = "Data Base :"
527:             .FontName  = "Tahoma"
528:             .FontSize  = 8
529:             .BackStyle = 0
530:             .ForeColor = RGB(0, 0, 0)
531:             .Left      = 295
532:             .Top       = 11
533:             .AutoSize  = .T.
534:         ENDWITH
535: 
536:         loc_oPag.AddObject("txt_4c_DataBase", "TextBox")
537:         WITH loc_oPag.txt_4c_DataBase
538:             .Value         = {}
539:             .Left          = 355
540:             .Top           = 7
541:             .Width         = 80
542:             .Height        = 20
543:             .SpecialEffect = 1
544:             .ForeColor     = RGB(0, 0, 0)
545:             .BorderColor   = RGB(100, 100, 100)
546:             .FontName      = "Tahoma"
547:             .FontSize      = 8
548:             .Enabled       = .F.
549:         ENDWITH
550: 
551:         *-- Linha 2: Juros/Mes % (esq) | Data Final / Dias (dir)
552:         loc_oPag.AddObject("lbl_4c_Label3", "Label")
553:         WITH loc_oPag.lbl_4c_Label3
554:             .Caption   = "Juros/M" + CHR(234) + "s :"
555:             .FontName  = "Tahoma"
556:             .FontSize  = 8
557:             .BackStyle = 0
558:             .ForeColor = RGB(0, 0, 0)
559:             .Left      = 37
560:             .Top       = 39
561:             .AutoSize  = .T.
562:         ENDWITH
563: 
564:         loc_oPag.AddObject("txt_4c_JurosMes", "TextBox")
565:         WITH loc_oPag.txt_4c_JurosMes
566:             .Alignment     = 3
567:             .Value         = 0
568:             .InputMask     = "9999.99"
569:             .Left          = 97
570:             .Top           = 35
571:             .Width         = 59
572:             .Height        = 23
573:             .SpecialEffect = 1
574:             .ForeColor     = RGB(0, 0, 0)
575:             .BorderColor   = RGB(100, 100, 100)
576:             .FontName      = "Tahoma"
577:             .FontSize      = 8
578:             .Enabled       = .F.
579:         ENDWITH
580: 
581:         loc_oPag.AddObject("lbl_4c_Label4", "Label")
582:         WITH loc_oPag.lbl_4c_Label4
583:             .Caption   = "%"
584:             .FontName  = "Tahoma"
585:             .FontSize  = 8
586:             .BackStyle = 0
587:             .ForeColor = RGB(0, 0, 0)
588:             .Left      = 159
589:             .Top       = 39
590:             .AutoSize  = .T.
591:         ENDWITH
592: 
593:         loc_oPag.AddObject("lbl_4c_Label7", "Label")
594:         WITH loc_oPag.lbl_4c_Label7
595:             .Caption   = "Data Final / Dias :"
596:             .FontName  = "Tahoma"
597:             .FontSize  = 8
598:             .BackStyle = 0
599:             .ForeColor = RGB(0, 0, 0)
600:             .Left      = 266
601:             .Top       = 39
602:             .AutoSize  = .T.
603:         ENDWITH
604: 
605:         loc_oPag.AddObject("txt_4c_DataFinal", "TextBox")
606:         WITH loc_oPag.txt_4c_DataFinal
607:             .Value         = {}
608:             .Left          = 355
609:             .Top           = 35
610:             .Width         = 80
611:             .Height        = 20
612:             .SpecialEffect = 1
613:             .ForeColor     = RGB(0, 0, 0)
614:             .BorderColor   = RGB(100, 100, 100)
615:             .FontName      = "Tahoma"
616:             .FontSize      = 8
617:             .Enabled       = .F.
618:         ENDWITH
619: 
620:         loc_oPag.AddObject("lbl_4c_Label8", "Label")
621:         WITH loc_oPag.lbl_4c_Label8
622:             .Caption   = "/"
623:             .FontName  = "Tahoma"
624:             .FontSize  = 8
625:             .BackStyle = 0
626:             .ForeColor = RGB(0, 0, 0)
627:             .Left      = 441
628:             .Top       = 36
629:             .AutoSize  = .T.
630:         ENDWITH
631: 
632:         loc_oPag.AddObject("txt_4c_Dias", "TextBox")
633:         WITH loc_oPag.txt_4c_Dias
634:             .Alignment     = 3
635:             .Value         = 0
636:             .InputMask     = "9999"
637:             .Left          = 453
638:             .Top           = 35
639:             .Width         = 38
640:             .Height        = 23
641:             .SpecialEffect = 1
642:             .ForeColor     = RGB(0, 0, 0)
643:             .BorderColor   = RGB(100, 100, 100)
644:             .FontName      = "Tahoma"
645:             .FontSize      = 8
646:             .Enabled       = .F.
647:         ENDWITH
648: 
649:         *-- Linha 3: Juros por Dia (esq) | Calculo Simples/Composto (dir)
650:         loc_oPag.AddObject("lbl_4c_Label5", "Label")
651:         WITH loc_oPag.lbl_4c_Label5
652:             .Caption   = "Juros por Dia :"
653:             .FontName  = "Tahoma"
654:             .FontSize  = 8
655:             .BackStyle = 0
656:             .ForeColor = RGB(0, 0, 0)
657:             .Left      = 23
658:             .Top       = 68
659:             .AutoSize  = .T.
660:         ENDWITH
661: 
662:         loc_oPag.AddObject("txt_4c_JurosDia", "TextBox")
663:         WITH loc_oPag.txt_4c_JurosDia
664:             .Alignment     = 3
665:             .Value         = 0
666:             .InputMask     = "9999.999999999"
667:             .Left          = 97
668:             .Top           = 64
669:             .Width         = 136
670:             .Height        = 20
671:             .SpecialEffect = 1
672:             .ForeColor     = RGB(0, 0, 0)
673:             .BorderColor   = RGB(100, 100, 100)
674:             .FontName      = "Tahoma"
675:             .FontSize      = 8
676:             .Enabled       = .F.
677:         ENDWITH
678: 
679:         loc_oPag.AddObject("lbl_4c_Label2", "Label")
680:         WITH loc_oPag.lbl_4c_Label2
681:             .Caption   = "C" + CHR(225) + "lculo :"
682:             .FontName  = "Tahoma"
683:             .FontSize  = 8
684:             .BackStyle = 0
685:             .ForeColor = RGB(0, 0, 0)
686:             .Left      = 310
687:             .Top       = 63
688:             .AutoSize  = .T.
689:         ENDWITH
690: 
691:         loc_oPag.AddObject("obj_4c_OptCalculo", "OptionGroup")
692:         WITH loc_oPag.obj_4c_OptCalculo

*-- Linhas 698 a 738:
698:             .Enabled     = .F.
699: 
700:             WITH .Buttons(1)
701:                 .Caption   = "Simples"
702:                 .Height    = 17
703:                 .Left      = 5
704:                 .Top       = 2
705:                 .Width     = 76
706:                 .AutoSize  = .F.
707:                 .BackStyle = 0
708:             ENDWITH
709: 
710:             WITH .Buttons(2)
711:                 .Caption   = "Composto"
712:                 .Height    = 17
713:                 .Left      = 72
714:                 .Top       = 2
715:                 .Width     = 76
716:                 .AutoSize  = .F.
717:                 .BackStyle = 0
718:             ENDWITH
719: 
720:             .Left = 351
721:             .Top  = 60
722:         ENDWITH
723: 
724:         *-- Linha 4: Tipo de dias (Corridos/Uteis)
725:         loc_oPag.AddObject("lbl_4c_Label13", "Label")
726:         WITH loc_oPag.lbl_4c_Label13
727:             .Caption   = "Dias :"
728:             .FontName  = "Tahoma"
729:             .FontSize  = 8
730:             .BackStyle = 0
731:             .ForeColor = RGB(0, 0, 0)
732:             .Left      = 324
733:             .Top       = 81
734:             .AutoSize  = .T.
735:         ENDWITH
736: 
737:         loc_oPag.AddObject("obj_4c_OptDias", "OptionGroup")
738:         WITH loc_oPag.obj_4c_OptDias

*-- Linhas 744 a 808:
744:             .Enabled     = .F.
745: 
746:             WITH .Buttons(1)
747:                 .Caption   = "Corridos"
748:                 .Height    = 17
749:                 .Left      = 5
750:                 .Top       = 2
751:                 .Width     = 76
752:                 .AutoSize  = .F.
753:                 .BackStyle = 0
754:             ENDWITH
755: 
756:             WITH .Buttons(2)
757:                 .Caption   = CHR(218) + "teis"
758:                 .Height    = 17
759:                 .Left      = 72
760:                 .Top       = 2
761:                 .Width     = 76
762:                 .AutoSize  = .F.
763:                 .BackStyle = 0
764:             ENDWITH
765: 
766:             .Left = 351
767:             .Top  = 78
768:         ENDWITH
769: 
770:         *-- Separador horizontal (original: Commandgroup1 Height=1, Top=180)
771:         loc_oPag.AddObject("lbl_4c_Separador", "Label")
772:         WITH loc_oPag.lbl_4c_Separador
773:             .Caption   = ""
774:             .BackStyle = 1
775:             .BackColor = RGB(90, 90, 90)
776:             .Top       = 100
777:             .Left      = 6
778:             .Width     = 586
779:             .Height    = 1
780:         ENDWITH
781: 
782:         *-- Resultado: Juros
783:         loc_oPag.AddObject("lbl_4c_Label9", "Label")
784:         WITH loc_oPag.lbl_4c_Label9
785:             .Caption   = "Juros :"
786:             .FontName  = "Tahoma"
787:             .FontSize  = 8
788:             .BackStyle = 0
789:             .ForeColor = RGB(0, 0, 0)
790:             .Left      = 60
791:             .Top       = 107
792:             .AutoSize  = .T.
793:         ENDWITH
794: 
795:         loc_oPag.AddObject("txt_4c_ValorJuros", "TextBox")
796:         WITH loc_oPag.txt_4c_ValorJuros
797:             .FontBold          = .T.
798:             .Alignment         = 3
799:             .Value             = 0
800:             .Enabled           = .F.
801:             .InputMask         = "999,999,999.99"
802:             .Left              = 97
803:             .Top               = 103
804:             .Width             = 136
805:             .Height            = 20
806:             .SpecialEffect     = 1
807:             .ForeColor         = RGB(0, 0, 0)
808:             .BackColor         = RGB(255, 253, 179)

*-- Linhas 814 a 842:
814:         ENDWITH
815: 
816:         *-- Resultado: Total
817:         loc_oPag.AddObject("lbl_4c_Label10", "Label")
818:         WITH loc_oPag.lbl_4c_Label10
819:             .Caption   = "Total :"
820:             .FontName  = "Tahoma"
821:             .FontSize  = 8
822:             .BackStyle = 0
823:             .ForeColor = RGB(0, 0, 0)
824:             .Left      = 276
825:             .Top       = 107
826:             .AutoSize  = .T.
827:         ENDWITH
828: 
829:         loc_oPag.AddObject("txt_4c_ValorTotal", "TextBox")
830:         WITH loc_oPag.txt_4c_ValorTotal
831:             .FontBold          = .T.
832:             .Alignment         = 3
833:             .Value             = 0
834:             .Enabled           = .F.
835:             .InputMask         = "999,999,999.99"
836:             .Left              = 311
837:             .Top               = 103
838:             .Width             = 136
839:             .Height            = 20
840:             .SpecialEffect     = 1
841:             .ForeColor         = RGB(0, 0, 0)
842:             .BackColor         = RGB(255, 253, 179)

*-- Linhas 848 a 876:
848:         ENDWITH
849: 
850:         *-- Resultado: Parcela
851:         loc_oPag.AddObject("lbl_4c_Label12", "Label")
852:         WITH loc_oPag.lbl_4c_Label12
853:             .Caption   = "Parcela :"
854:             .FontName  = "Tahoma"
855:             .FontSize  = 8
856:             .BackStyle = 0
857:             .ForeColor = RGB(0, 0, 0)
858:             .Left      = 265
859:             .Top       = 131
860:             .AutoSize  = .T.
861:         ENDWITH
862: 
863:         loc_oPag.AddObject("txt_4c_Valorpar", "TextBox")
864:         WITH loc_oPag.txt_4c_Valorpar
865:             .FontBold          = .T.
866:             .Alignment         = 3
867:             .Value             = 0
868:             .Enabled           = .F.
869:             .InputMask         = "999,999,999.99"
870:             .Left              = 311
871:             .Top               = 127
872:             .Width             = 136
873:             .Height            = 20
874:             .SpecialEffect     = 1
875:             .ForeColor         = RGB(0, 0, 0)
876:             .BackColor         = RGB(255, 253, 179)

*-- Linhas 1350 a 1379:
1350:         laLeft(4) = 358
1351:         laLeft(5) = 445
1352: 
1353:         loc_oPag.AddObject("lbl_4c_LblVenc", "Label")
1354:         loc_oCtrl = loc_oPag.Controls(loc_oPag.ControlCount)
1355:         WITH loc_oCtrl
1356:             .Caption   = "Vencimentos :"
1357:             .FontName  = "Tahoma"
1358:             .FontSize  = 8
1359:             .BackStyle = 0
1360:             .ForeColor = RGB(0, 0, 0)
1361:             .Left      = 26
1362:             .Top       = 152
1363:             .AutoSize  = .T.
1364:         ENDWITH
1365: 
1366:         FOR loc_x = 1 TO 5
1367:             loc_nLeft = laLeft(loc_x)
1368: 
1369:             loc_oPag.AddObject("txt_4c_Venc" + ALLTRIM(STR(2*loc_x-1)), "TextBox")
1370:             loc_oCtrl = loc_oPag.Controls(loc_oPag.ControlCount)
1371:             WITH loc_oCtrl
1372:                 .Value         = {}
1373:                 .Left          = loc_nLeft
1374:                 .Top           = 152
1375:                 .Width         = 82
1376:                 .Height        = 20
1377:                 .SpecialEffect = 1
1378:                 .ForeColor     = RGB(0, 0, 0)
1379:                 .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1386 a 1395:
1386:             loc_oCtrl = loc_oPag.Controls(loc_oPag.ControlCount)
1387:             WITH loc_oCtrl
1388:                 .Value         = {}
1389:                 .Left          = loc_nLeft
1390:                 .Top           = 177
1391:                 .Width         = 82
1392:                 .Height        = 20
1393:                 .SpecialEffect = 1
1394:                 .ForeColor     = RGB(0, 0, 0)
1395:                 .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1611 a 1620:
1611:     *---------------------------------------------------------------------------
1612:     PROCEDURE AjustarBotoesPorModo()
1613:         IF VARTYPE(THIS.cnt_4c_Botoes) = "O" AND ;
1614:            VARTYPE(THIS.cnt_4c_Botoes.cmd_4c_BtnOK) = "O"
1615:             THIS.cnt_4c_Botoes.cmd_4c_BtnOK.Enabled = .T.
1616:         ENDIF
1617:     ENDPROC
1618: 
1619:     *---------------------------------------------------------------------------
1620:     * BtnBuscarClick - Recalcula com os valores correntes do form.


### BO (C:\4c\projeto\app\classes\SigPrCfnBO.prg):
*******************************************************************************
* SigPrCfnBO.prg - Business Object: Calculo de Juros
* Herda de BusinessBase
* Form OPERACIONAL - sem tabela BD (calculo puro)
* Migrado de: SigPrCfn.SCX
*******************************************************************************

DEFINE CLASS SigPrCfnBO AS BusinessBase

    *-- Sem tabela BD: form de calculo puro
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Entradas do calculo
    this_nValorBase    = 0    && Valor Base (positivo)
    this_nTipoCalculo  = 1    && 1=Simples, 2=Composto
    this_nJurosMes     = 0    && Juros ao Mes (%)
    this_nJurosDia     = 0    && Juros ao Dia (%)
    this_dDataBase     = {}   && Data Base do calculo
    this_dDataFinal    = {}   && Data Final do calculo
    this_nDias         = 0    && Numero de dias entre DataBase e DataFinal
    this_nTipoDias     = 1    && 1=Corridos, 2=Uteis

    *-- Vencimentos (ate 10 parcelas)
    this_dVenc1        = {}
    this_dVenc2        = {}
    this_dVenc3        = {}
    this_dVenc4        = {}
    this_dVenc5        = {}
    this_dVenc6        = {}
    this_dVenc7        = {}
    this_dVenc8        = {}
    this_dVenc9        = {}
    this_dVenc10       = {}

    *-- Resultados do calculo
    this_nValorJuros   = 0    && Valor dos juros calculados
    this_nValorTotal   = 0    && Valor Total (Base + Juros)
    this_nValorParcela = 0    && Valor de cada parcela

    *---------------------------------------------------------------------------
    PROCEDURE Init()
    *---------------------------------------------------------------------------
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
        THIS.LimparPropriedades()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE LimparPropriedades()
    *---------------------------------------------------------------------------
        THIS.this_nValorBase    = 0
        THIS.this_nTipoCalculo  = 1
        THIS.this_nJurosMes     = 0
        THIS.this_nJurosDia     = 0
        THIS.this_dDataBase     = {}
        THIS.this_dDataFinal    = {}
        THIS.this_nDias         = 0
        THIS.this_nTipoDias     = 1
        THIS.this_dVenc1        = {}
        THIS.this_dVenc2        = {}
        THIS.this_dVenc3        = {}
        THIS.this_dVenc4        = {}
        THIS.this_dVenc5        = {}
        THIS.this_dVenc6        = {}
        THIS.this_dVenc7        = {}
        THIS.this_dVenc8        = {}
        THIS.this_dVenc9        = {}
        THIS.this_dVenc10       = {}
        THIS.this_nValorJuros   = 0
        THIS.this_nValorTotal   = 0
        THIS.this_nValorParcela = 0
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *---------------------------------------------------------------------------
        RETURN ""
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *---------------------------------------------------------------------------
        IF THIS.this_nValorBase < 0
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * InicializarComParametros - Popula propriedades a partir dos parametros
    * recebidos pelo form (equivalente ao Init do legado com LPARAMETERS)
    *---------------------------------------------------------------------------
    PROCEDURE InicializarComParametros(par_nValor, par_nTipo, par_nJurosMes, par_nJurosDia, par_dDataBase, par_dDataFinal)
        THIS.LimparPropriedades()

        IF VARTYPE(par_nValor) = "N" AND par_nValor > 0
            THIS.this_nValorBase = par_nValor
        ENDIF

        IF VARTYPE(par_nTipo) = "N" AND INLIST(par_nTipo, 1, 2)
            THIS.this_nTipoCalculo = par_nTipo
        ELSE
            THIS.this_nTipoCalculo = 1
        ENDIF

        IF VARTYPE(par_nJurosMes) = "N" AND par_nJurosMes > 0
            THIS.this_nJurosMes = par_nJurosMes
            THIS.this_nJurosDia = THIS.CalcularJurosDia(par_nJurosMes)
        ELSE
            IF VARTYPE(par_nJurosDia) = "N" AND par_nJurosDia > 0
            THIS.this_nJurosDia = par_nJurosDia
            THIS.this_nJurosMes = THIS.CalcularJurosMes(par_nJurosDia)
            ENDIF
        ENDIF

        IF VARTYPE(par_dDataBase) = "D"
            THIS.this_dDataBase = par_dDataBase
        ENDIF

        IF VARTYPE(par_dDataFinal) = "D"
            THIS.this_dDataFinal = par_dDataFinal
        ELSE
            IF !EMPTY(THIS.this_dDataBase)
            THIS.this_dDataFinal = DATE()
            ENDIF
        ENDIF

        IF !EMPTY(THIS.this_dDataBase) AND !EMPTY(THIS.this_dDataFinal)
            THIS.this_nDias = THIS.this_dDataFinal - THIS.this_dDataBase
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    * Calcular - Logica central de calculo de juros (equivalente a calculos()
    * do legado). Usa propriedades this_* como entrada e atualiza os resultados.
    *---------------------------------------------------------------------------
    PROCEDURE Calcular()
        LOCAL loc_nJuros, loc_nParc, loc_nTotDia, loc_x, loc_dVenc, loc_nDia
        LOCAL ARRAY loc_aVenc[10]

        loc_nJuros  = 0
        loc_nParc   = 0
        loc_nTotDia = 0

        *-- Sem dados minimos: zerar resultados
        IF EMPTY(THIS.this_nValorBase)  OR ;
           EMPTY(THIS.this_nJurosMes)   OR ;
           EMPTY(THIS.this_nJurosDia)   OR ;
           EMPTY(THIS.this_dDataBase)   OR ;
           EMPTY(THIS.this_dDataFinal)  OR ;
           EMPTY(THIS.this_nDias)
            THIS.this_nValorJuros   = 0
            THIS.this_nValorTotal   = 0
            THIS.this_nValorParcela = 0
            RETURN .T.
        ENDIF

        *-- Calculo base (sem vencimentos)
        IF THIS.this_nTipoCalculo = 1
            *-- Juros Simples
            loc_nJuros = ROUND(THIS.this_nValorBase * ;
                               (THIS.this_nJurosMes / 100) * ;
                               (THIS.this_nDias / 30), 2)
        ELSE
            *-- Juros Compostos
            loc_nJuros = ROUND(THIS.this_nValorBase * ;
                               (((1 + THIS.this_nJurosDia / 100) ^ ;
                               THIS.this_nDias) - 1), 2)
        ENDIF

        *-- Iterar vencimentos (ate 10 parcelas)
        loc_aVenc[1]  = THIS.this_dVenc1
        loc_aVenc[2]  = THIS.this_dVenc2
        loc_aVenc[3]  = THIS.this_dVenc3
        loc_aVenc[4]  = THIS.this_dVenc4
        loc_aVenc[5]  = THIS.this_dVenc5
        loc_aVenc[6]  = THIS.this_dVenc6
        loc_aVenc[7]  = THIS.this_dVenc7
        loc_aVenc[8]  = THIS.this_dVenc8
        loc_aVenc[9]  = THIS.this_dVenc9
        loc_aVenc[10] = THIS.this_dVenc10

        FOR loc_x = 1 TO 10
            loc_dVenc = loc_aVenc[loc_x]
            IF !EMPTY(loc_dVenc)
                IF loc_nParc = 0
                    *-- Primeira parcela encontrada: zerar calculo base
                    loc_nJuros = 0
                ENDIF
                loc_nDia = loc_dVenc - THIS.this_dDataBase
                IF THIS.this_nTipoCalculo = 1
                    *-- Juros Simples por parcela
                    loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                                    (THIS.this_nJurosMes / 100) * ;
                                                    (loc_nDia / 30), 2)
                ELSE
                    *-- Juros Compostos por parcela
                    loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                                    (((1 + THIS.this_nJurosDia / 100) ^ ;
                                                    loc_nDia) - 1), 2)
                ENDIF
                loc_nTotDia = loc_nDia
                loc_nParc   = loc_nParc + 1
            ENDIF
        ENDFOR

        IF loc_nTotDia > 0
            THIS.this_nDias = loc_nTotDia
        ENDIF

        THIS.this_nValorJuros   = loc_nJuros
        THIS.this_nValorTotal   = THIS.this_nValorBase + loc_nJuros
        THIS.this_nValorParcela = THIS.this_nValorTotal / IIF(loc_nParc <> 0, loc_nParc, 1)

        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularJurosDia - Converte juros mensais em diarios
    * Atualiza this_nJurosDia e retorna o valor calculado
    *---------------------------------------------------------------------------
    PROCEDURE CalcularJurosDia(par_nJurosMes)
        LOCAL loc_nJurosDia

        IF THIS.this_nTipoCalculo = 1
            *-- Juros Simples: dividir por 30
            loc_nJurosDia = ROUND(par_nJurosMes / 30, 9)
        ELSE
            *-- Juros Compostos: formula de equivalencia
            loc_nJurosDia = ROUND((((1 + par_nJurosMes / 100) ^ (1/30)) - 1) * 100, 9)
        ENDIF

        THIS.this_nJurosDia = loc_nJurosDia
        RETURN loc_nJurosDia
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularJurosMes - Converte juros diarios em mensais
    * Atualiza this_nJurosMes e retorna o valor calculado
    *---------------------------------------------------------------------------
    PROCEDURE CalcularJurosMes(par_nJurosDia)
        LOCAL loc_nJurosMes

        IF THIS.this_nTipoCalculo = 1
            *-- Juros Simples: multiplicar por 30
            loc_nJurosMes = ROUND(par_nJurosDia * 30, 2)
        ELSE
            *-- Juros Compostos: formula de equivalencia
            loc_nJurosMes = ROUND((((1 + par_nJurosDia / 100) ^ 30) - 1) * 100, 2)
        ENDIF

        THIS.this_nJurosMes = loc_nJurosMes
        RETURN loc_nJurosMes
    ENDPROC

    *---------------------------------------------------------------------------
    * AjustarDiasUteis - Conta dias uteis entre duas datas (exclui fins de
    * semana e feriados cadastrados em SigCdFer). Atualiza this_nDias.
    * Equivalente ao bloco fChkFeriado do legado em getDataFinal.Valid/
    * getDias.Valid/optDias.InteractiveChange.
    *---------------------------------------------------------------------------
    PROCEDURE AjustarDiasUteis(par_dDataBase, par_dDataFinal)
        LOCAL loc_nDias, loc_dAtual

        loc_nDias  = par_dDataFinal - par_dDataBase
        loc_dAtual = par_dDataBase

        DO WHILE loc_dAtual <= par_dDataFinal
            IF THIS.VerificarFeriado(loc_dAtual)
                loc_nDias = loc_nDias - 1
            ENDIF
            loc_dAtual = loc_dAtual + 1
        ENDDO

        THIS.this_nDias = loc_nDias
        RETURN loc_nDias
    ENDPROC

    *---------------------------------------------------------------------------
    * VerificarFeriado - Retorna .T. se a data e fim de semana ou feriado
    * cadastrado em SigCdFer (equivalente a fChkFeriado do legado).
    *---------------------------------------------------------------------------
    PROCEDURE VerificarFeriado(par_dData)
        LOCAL loc_nDow, loc_lNaoUtil, loc_cSQL, loc_nRet

        *-- Verificar fim de semana (DOW: Domingo=1, Sabado=7)
        loc_nDow = DOW(par_dData)
        IF loc_nDow = 1 OR loc_nDow = 7
            RETURN .T.
        ENDIF

        *-- Verificar feriado cadastrado no banco
        loc_lNaoUtil = .F.
        loc_cSQL = "SELECT COUNT(*) AS nFeriado FROM SigCdFer " + ;
                   "WHERE CAST(datas AS DATE) = CAST(" + FormatarDataSQL(par_dData) + " AS DATE)"

        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerCheck")
        IF loc_nRet > 0 AND USED("cursor_4c_FerCheck")
            SELECT cursor_4c_FerCheck
            IF NVL(nFeriado, 0) > 0
                loc_lNaoUtil = .T.
            ENDIF
            USE IN cursor_4c_FerCheck
        ENDIF

        RETURN loc_lNaoUtil
    ENDPROC

    *---------------------------------------------------------------------------
    * ValidarValorBase - Valida que o valor base e positivo
    *---------------------------------------------------------------------------
    PROCEDURE ValidarValorBase(par_nValor)
        IF par_nValor < 0
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * ValidarDatas - Valida que DataBase nao e maior que DataFinal
    *---------------------------------------------------------------------------
    PROCEDURE ValidarDatas(par_dDataBase, par_dDataFinal)
        IF !EMPTY(par_dDataBase) AND !EMPTY(par_dDataFinal)
            IF par_dDataBase > par_dDataFinal
                RETURN .F.
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * ValidarDataVencimento - Valida que data de vencimento nao e anterior
    * a DataBase
    *---------------------------------------------------------------------------
    PROCEDURE ValidarDataVencimento(par_dVenc, par_dDataBase)
        IF !EMPTY(par_dDataBase) AND !EMPTY(par_dVenc)
            IF par_dVenc < par_dDataBase
                RETURN .F.
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades de entrada do calculo a partir
    * de cursor (usado quando o form eh chamado por outra rotina que ja tem
    * os parametros num cursor VFP). Mapeamento por campos que existirem.
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o encontrado: " + TRANSFORM(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)

            IF TYPE(par_cAliasCursor + ".ValorBase") != "U"
                THIS.this_nValorBase = NVL(EVALUATE(par_cAliasCursor + ".ValorBase"), 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".TipoCalculo") != "U"
                THIS.this_nTipoCalculo = NVL(EVALUATE(par_cAliasCursor + ".TipoCalculo"), 1)
            ENDIF
            IF TYPE(par_cAliasCursor + ".JurosMes") != "U"
                THIS.this_nJurosMes = NVL(EVALUATE(par_cAliasCursor + ".JurosMes"), 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".JurosDia") != "U"
                THIS.this_nJurosDia = NVL(EVALUATE(par_cAliasCursor + ".JurosDia"), 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".DataBase") != "U"
                THIS.this_dDataBase = NVL(EVALUATE(par_cAliasCursor + ".DataBase"), {})
            ENDIF
            IF TYPE(par_cAliasCursor + ".DataFinal") != "U"
                THIS.this_dDataFinal = NVL(EVALUATE(par_cAliasCursor + ".DataFinal"), {})
            ENDIF
            IF TYPE(par_cAliasCursor + ".Dias") != "U"
                THIS.this_nDias = NVL(EVALUATE(par_cAliasCursor + ".Dias"), 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".TipoDias") != "U"
                THIS.this_nTipoDias = NVL(EVALUATE(par_cAliasCursor + ".TipoDias"), 1)
            ENDIF

            IF !EMPTY(THIS.this_dDataBase) AND !EMPTY(THIS.this_dDataFinal) AND THIS.this_nDias = 0
                THIS.this_nDias = THIS.this_dDataFinal - THIS.this_dDataBase
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar cursor: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - Sobrescreve BusinessBase.Inserir()
    * Form OPERACIONAL de calculo puro (this_cTabela vazio): nao persiste
    * dados em tabela CRUD. Executa o calculo e retorna resultado.
    * Chamada via BusinessBase.Salvar() apos ValidarDados().
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.Calcular()

        IF !loc_lSucesso
            THIS.this_cMensagemErro = "Falha ao executar c" + CHR(225) + "lculo de juros"
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Sobrescreve BusinessBase.Atualizar()
    * Form OPERACIONAL de calculo puro: recalcula com parametros correntes.
    * Chamada via BusinessBase.Salvar() em modo edicao apos ValidarDados().
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.Calcular()

        IF !loc_lSucesso
            THIS.this_cMensagemErro = "Falha ao recalcular juros"
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * RegistrarAuditoria - Sobrescreve BusinessBase.RegistrarAuditoria()
    * Como o form nao tem tabela associada (this_cTabela vazio), registra no
    * LogAuditoria a operacao de calculo com resumo dos parametros usados.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cResumo, loc_cUsuario, loc_nRet

        loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

        loc_cResumo = "VB=" + TRANSFORM(THIS.this_nValorBase, "@Z 999999999.99") + ;
                      "|TC=" + TRANSFORM(THIS.this_nTipoCalculo) + ;
                      "|JM=" + TRANSFORM(THIS.this_nJurosMes, "@Z 999.999999") + ;
                      "|D=" + TRANSFORM(THIS.this_nDias) + ;
                      "|VJ=" + TRANSFORM(THIS.this_nValorJuros, "@Z 999999999.99")

        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + EscaparSQL("SigPrCfn") + ", " + ;
                   EscaparSQL(par_cOperacao) + ", " + ;
                   EscaparSQL(LEFT(loc_cResumo, 100)) + ", " + ;
                   EscaparSQL(loc_cUsuario) + ", GETDATE())"

        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
        RETURN (loc_nRet > 0)
    ENDPROC

ENDDEFINE

