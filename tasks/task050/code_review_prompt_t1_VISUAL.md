# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 201: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 221: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 241: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreche.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2201 linhas total):

*-- Linhas 55 a 63:
55:                 THIS.this_oRelatorio.InicializarCursores()
56: 
57:                 THIS.ConfigurarCabecalho()
58:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
59: 
60:                 THIS.ConfigurarBotoes()
61:                 THIS.ConfigurarPaginaLista()
62: 
63:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

*-- Linhas 87 a 95:
87:     * adicionados diretamente ao Form em ConfigurarCabecalho/ConfigurarBotoes.
88:     *==========================================================================
89:     PROTECTED PROCEDURE ConfigurarPageFrame()
90:         THIS.Caption     = "Relat" + CHR(243) + "rio de Cheques"
91:         THIS.Picture     = gc_4c_CaminhoIcones + "new_background.jpg"
92:         THIS.Icon        = gc_4c_CaminhoIcones + "icon.ico"
93:         THIS.AutoCenter  = .T.
94:         THIS.BorderStyle = 2
95:         THIS.WindowType  = 1

*-- Linhas 108 a 151:
108:     PROTECTED PROCEDURE ConfigurarCabecalho()
109:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
110:         WITH THIS.cnt_4c_Cabecalho
111:             .Top       = 0
112:             .Left      = 0
113:             .Width     = THIS.Width
114:             .Height    = 80
115:             .BackStyle = 1
116:             .BackColor = RGB(100, 100, 100)
117:             .BorderWidth = 0
118:             .Visible   = .T.
119: 
120:             .AddObject("lbl_4c_Sombra", "Label")
121:             WITH .lbl_4c_Sombra
122:                 .Top       = 15
123:                 .Left      = 12
124:                 .Width     = THIS.Width
125:                 .Height    = 40
126:                 .FontName  = "Tahoma"
127:                 .FontSize  = 16
128:                 .FontBold  = .T.
129:                 .BackStyle = 0
130:                 .ForeColor = RGB(0, 0, 0)
131:                 .Caption   = THIS.Parent.Caption
132:                 .Visible   = .T.
133:             ENDWITH
134: 
135:             .AddObject("lbl_4c_Titulo", "Label")
136:             WITH .lbl_4c_Titulo
137:                 .Top       = 18
138:                 .Left      = 10
139:                 .Width     = THIS.Width
140:                 .Height    = 40
141:                 .FontName  = "Tahoma"
142:                 .FontSize  = 16
143:                 .FontBold  = .T.
144:                 .BackStyle = 0
145:                 .ForeColor = RGB(255, 255, 255)
146:                 .Caption   = THIS.Parent.Caption
147:                 .Visible   = .T.
148:             ENDWITH
149:         ENDWITH
150:     ENDPROC
151: 

*-- Linhas 161 a 186:
161: 
162:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
163:         WITH THIS.cmg_4c_Botoes
164:             .Top         = 6
165:             .Left        = 726
166:             .Width       = 273
167:             .Height      = 80
168:             .ButtonCount = 4
169:             .BackStyle   = 0
170:             .BorderStyle = 0
171:             .BorderColor = RGB(136, 189, 188)
172:             .SpecialEffect = 1
173:             .Themes      = .F.
174:             .Visible     = .T.
175: 
176:             WITH .Buttons(1)
177:                 .Top             = 5
178:                 .Left            = 5
179:                 .Width           = 65
180:                 .Height          = 70
181:                 .Caption         = "Visualizar"
182:                 .Picture         = loc_cIcones + "ideo.jpg"
183:                 .FontBold        = .T.
184:                 .FontItalic      = .T.
185:                 .BackColor       = RGB(255, 255, 255)
186:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 192 a 247:
192:             ENDWITH
193: 
194:             WITH .Buttons(2)
195:                 .Top             = 5
196:                 .Left            = 71
197:                 .Width           = 65
198:                 .Height          = 70
199:                 .Caption         = "Imprimir"
200:                 .Picture         = loc_cIcones + "impressora.jpg"
201:                 .FontName        = "Comic Sans MS"
202:                 .FontBold        = .T.
203:                 .FontItalic      = .T.
204:                 .FontSize        = 8
205:                 .BackColor       = RGB(255, 255, 255)
206:                 .ForeColor       = RGB(90, 90, 90)
207:                 .PicturePosition = 13
208:                 .SpecialEffect   = 0
209:                 .MousePointer    = 15
210:                 .Themes          = .F.
211:                 .WordWrap        = .T.
212:             ENDWITH
213: 
214:             WITH .Buttons(3)
215:                 .Top             = 5
216:                 .Left            = 137
217:                 .Width           = 65
218:                 .Height          = 70
219:                 .Caption         = "Excel"
220:                 .Picture         = loc_cIcones + "excel.jpg"
221:                 .FontName        = "Comic Sans MS"
222:                 .FontBold        = .T.
223:                 .FontItalic      = .T.
224:                 .FontSize        = 8
225:                 .BackColor       = RGB(255, 255, 255)
226:                 .ForeColor       = RGB(90, 90, 90)
227:                 .PicturePosition = 13
228:                 .SpecialEffect   = 0
229:                 .MousePointer    = 15
230:                 .Themes          = .F.
231:                 .WordWrap        = .T.
232:             ENDWITH
233: 
234:             WITH .Buttons(4)
235:                 .Top             = 5
236:                 .Left            = 203
237:                 .Width           = 65
238:                 .Height          = 70
239:                 .Caption         = "Sair"
240:                 .Picture         = loc_cIcones + "otao_encerrar.jpg"
241:                 .FontName        = "Comic Sans MS"
242:                 .FontBold        = .T.
243:                 .FontItalic      = .T.
244:                 .FontSize        = 8
245:                 .BackColor       = RGB(255, 255, 255)
246:                 .ForeColor       = RGB(90, 90, 90)
247:                 .PicturePosition = 13

*-- Linhas 326 a 334:
326:             IF PEMSTATUS(THIS, "cbo_4c_Ordem", 5)
327:                 .this_nOrdem = THIS.cbo_4c_Ordem.Value
328:             ENDIF
329:             *-- Apenas ultima movimentacao (CheckBox - valor numerico 0/1)
330:             IF PEMSTATUS(THIS, "chk_4c_Ultima", 5)
331:                 .this_lUltima = (THIS.chk_4c_Ultima.Value = 1)
332:             ENDIF
333:             *-- Periodo
334:             IF PEMSTATUS(THIS, "txt_4c_DtInicial", 5)

*-- Linhas 511 a 760:
511:     PROTECTED PROCEDURE ConfigurarCamposFiltro()
512: 
513:         *-- == PERIODO ==
514:         THIS.AddObject("lbl_4c_Periodo", "Label")
515:         WITH THIS.lbl_4c_Periodo
516:             .Top       = 113
517:             .Left      = 52
518:             .Width     = 50
519:             .Height    = 18
520:             .Caption   = "Per" + CHR(237) + "odo :"
521:             .FontName  = "Tahoma"
522:             .FontSize  = 8
523:             .FontBold  = .F.
524:             .BackStyle = 0
525:             .AutoSize  = .F.
526:             .Visible   = .T.
527:         ENDWITH
528: 
529:         THIS.AddObject("txt_4c_DtInicial", "TextBox")
530:         WITH THIS.txt_4c_DtInicial
531:             .Top       = 107
532:             .Left      = 101
533:             .Width     = 80
534:             .Height    = 23
535:             .Value     = DATE()
536:             .InputMask = "99/99/9999"
537:             .FontName  = "Tahoma"
538:             .FontSize  = 8
539:             .Visible   = .T.
540:         ENDWITH
541: 
542:         THIS.AddObject("lbl_4c_PeriodoA", "Label")
543:         WITH THIS.lbl_4c_PeriodoA
544:             .Top       = 112
545:             .Left      = 186
546:             .Width     = 10
547:             .Height    = 18
548:             .Caption   = "a"
549:             .FontName  = "Tahoma"
550:             .FontSize  = 8
551:             .BackStyle = 0
552:             .AutoSize  = .F.
553:             .Visible   = .T.
554:         ENDWITH
555: 
556:         THIS.AddObject("txt_4c_DtFinal", "TextBox")
557:         WITH THIS.txt_4c_DtFinal
558:             .Top       = 107
559:             .Left      = 200
560:             .Width     = 80
561:             .Height    = 23
562:             .Value     = DATE()
563:             .InputMask = "99/99/9999"
564:             .FontName  = "Tahoma"
565:             .FontSize  = 8
566:             .Visible   = .T.
567:         ENDWITH
568: 
569:         *-- == EMPRESA ==
570:         THIS.AddObject("lbl_4c_Empresa", "Label")
571:         WITH THIS.lbl_4c_Empresa
572:             .Top       = 137
573:             .Left      = 47
574:             .Width     = 54
575:             .Height    = 18
576:             .Caption   = "Empresa :"
577:             .FontName  = "Tahoma"
578:             .FontSize  = 8
579:             .BackStyle = 0
580:             .AutoSize  = .F.
581:             .Visible   = .T.
582:         ENDWITH
583: 
584:         THIS.AddObject("txt_4c_CdEmpresa", "TextBox")
585:         WITH THIS.txt_4c_CdEmpresa
586:             .Top      = 132
587:             .Left     = 101
588:             .Width    = 31
589:             .Height   = 23
590:             .Value    = ""
591:             .FontName = "Tahoma"
592:             .FontSize = 8
593:             .Visible  = .T.
594:         ENDWITH
595: 
596:         THIS.AddObject("txt_4c_DsEmpresa", "TextBox")
597:         WITH THIS.txt_4c_DsEmpresa
598:             .Top      = 132
599:             .Left     = 132
600:             .Width    = 290
601:             .Height   = 23
602:             .Value    = ""
603:             .FontName = "Tahoma"
604:             .FontSize = 8
605:             .Visible  = .T.
606:         ENDWITH
607: 
608:         *-- == DEPOSITO - GRUPO ==
609:         THIS.AddObject("lbl_4c_DepGrupo", "Label")
610:         WITH THIS.lbl_4c_DepGrupo
611:             .Top       = 275
612:             .Left      = 451
613:             .Width     = 84
614:             .Height    = 18
615:             .Caption   = "Grupo/Dep" + CHR(243) + "sito :"
616:             .FontName  = "Tahoma"
617:             .FontSize  = 8
618:             .BackStyle = 0
619:             .AutoSize  = .F.
620:             .Visible   = .T.
621:         ENDWITH
622: 
623:         THIS.AddObject("txt_4c_CdDepGrupo", "TextBox")
624:         WITH THIS.txt_4c_CdDepGrupo
625:             .Top      = 270
626:             .Left     = 540
627:             .Width    = 79
628:             .Height   = 23
629:             .Value    = ""
630:             .FontName = "Tahoma"
631:             .FontSize = 8
632:             .Visible  = .T.
633:         ENDWITH
634: 
635:         THIS.AddObject("txt_4c_DsDepGrupo", "TextBox")
636:         WITH THIS.txt_4c_DsDepGrupo
637:             .Top      = 270
638:             .Left     = 621
639:             .Width    = 365
640:             .Height   = 23
641:             .Value    = ""
642:             .FontName = "Tahoma"
643:             .FontSize = 8
644:             .Visible  = .T.
645:         ENDWITH
646: 
647:         *-- == DEPOSITO - CONTA ==
648:         THIS.AddObject("lbl_4c_DepConta", "Label")
649:         WITH THIS.lbl_4c_DepConta
650:             .Top       = 300
651:             .Left      = 451
652:             .Width     = 84
653:             .Height    = 18
654:             .Caption   = "Conta/Dep" + CHR(243) + "sito :"
655:             .FontName  = "Tahoma"
656:             .FontSize  = 8
657:             .BackStyle = 0
658:             .AutoSize  = .F.
659:             .Visible   = .T.
660:         ENDWITH
661: 
662:         THIS.AddObject("txt_4c_CdDepConta", "TextBox")
663:         WITH THIS.txt_4c_CdDepConta
664:             .Top      = 295
665:             .Left     = 540
666:             .Width    = 79
667:             .Height   = 23
668:             .Value    = ""
669:             .FontName = "Tahoma"
670:             .FontSize = 8
671:             .Visible  = .T.
672:         ENDWITH
673: 
674:         THIS.AddObject("txt_4c_DsDepConta", "TextBox")
675:         WITH THIS.txt_4c_DsDepConta
676:             .Top      = 295
677:             .Left     = 621
678:             .Width    = 365
679:             .Height   = 23
680:             .Value    = ""
681:             .FontName = "Tahoma"
682:             .FontSize = 8
683:             .Visible  = .T.
684:         ENDWITH
685: 
686:         *-- == EMISSOR - GRUPO ==
687:         THIS.AddObject("lbl_4c_EmiGrupo", "Label")
688:         WITH THIS.lbl_4c_EmiGrupo
689:             .Top       = 325
690:             .Left      = 457
691:             .Width     = 78
692:             .Height    = 18
693:             .Caption   = "Grupo/Emissor :"
694:             .FontName  = "Tahoma"
695:             .FontSize  = 8
696:             .BackStyle = 0
697:             .AutoSize  = .F.
698:             .Visible   = .T.
699:         ENDWITH
700: 
701:         THIS.AddObject("txt_4c_CdEmiGrupo", "TextBox")
702:         WITH THIS.txt_4c_CdEmiGrupo
703:             .Top      = 320
704:             .Left     = 540
705:             .Width    = 79
706:             .Height   = 23
707:             .Value    = ""
708:             .FontName = "Tahoma"
709:             .FontSize = 8
710:             .Visible  = .T.
711:         ENDWITH
712: 
713:         THIS.AddObject("txt_4c_DsEmiGrupo", "TextBox")
714:         WITH THIS.txt_4c_DsEmiGrupo
715:             .Top      = 320
716:             .Left     = 621
717:             .Width    = 365
718:             .Height   = 23
719:             .Value    = ""
720:             .FontName = "Tahoma"
721:             .FontSize = 8
722:             .Visible  = .T.
723:         ENDWITH
724: 
725:         *-- == EMISSOR - CONTA ==
726:         THIS.AddObject("lbl_4c_EmiConta", "Label")
727:         WITH THIS.lbl_4c_EmiConta
728:             .Top       = 350
729:             .Left      = 457
730:             .Width     = 78
731:             .Height    = 18
732:             .Caption   = "Conta/Emissor :"
733:             .FontName  = "Tahoma"
734:             .FontSize  = 8
735:             .BackStyle = 0
736:             .AutoSize  = .F.
737:             .Visible   = .T.
738:         ENDWITH
739: 
740:         THIS.AddObject("txt_4c_CdEmiConta", "TextBox")
741:         WITH THIS.txt_4c_CdEmiConta
742:             .Top      = 345
743:             .Left     = 540
744:             .Width    = 79
745:             .Height   = 23
746:             .Value    = ""
747:             .FontName = "Tahoma"
748:             .FontSize = 8
749:             .Visible  = .T.
750:         ENDWITH
751: 
752:         THIS.AddObject("txt_4c_DsEmiConta", "TextBox")
753:         WITH THIS.txt_4c_DsEmiConta
754:             .Top      = 345
755:             .Left     = 621
756:             .Width    = 365
757:             .Height   = 23
758:             .Value    = ""
759:             .FontName = "Tahoma"
760:             .FontSize = 8

*-- Linhas 784 a 1031:
784:     PROTECTED PROCEDURE ConfigurarPaginaDados()
785: 
786:         *-- == OPCAO (OptionGroup - com/sem nota fiscal) ==
787:         THIS.AddObject("lbl_4c_LblOpcao", "Label")
788:         WITH THIS.lbl_4c_LblOpcao
789:             .Top       = 121
790:             .Left      = 495
791:             .Width     = 44
792:             .Height    = 18
793:             .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
794:             .FontName  = "Tahoma"
795:             .FontSize  = 8
796:             .BackStyle = 0
797:             .AutoSize  = .F.
798:             .Visible   = .T.
799:         ENDWITH
800: 
801:         THIS.AddObject("obj_4c_NrOpcao", "OptionGroup")
802:         WITH THIS.obj_4c_NrOpcao
803:             .Top         = 117
804:             .Left        = 540
805:             .Width       = 182
806:             .Height      = 23
807:             .ButtonCount = 3
808:             .BackStyle   = 0
809:             .BorderStyle = 0
810:             .Themes      = .F.
811:             .Value       = 3
812:             .Visible     = .T.
813:             WITH .Buttons(1)
814:                 .Caption = "Sim"
815:                 .Left    = 0
816:                 .Top     = 3
817:                 .Width   = 60
818:                 .Height  = 17
819:                 .Visible = .T.
820:             ENDWITH
821:             WITH .Buttons(2)
822:                 .Caption  = "N" + CHR(227) + "o"
823:                 .Left     = 61
824:                 .Top      = 3
825:                 .Width    = 60
826:                 .Height   = 17
827:                 .FontName = "Tahoma"
828:                 .FontSize = 8
829:                 .Visible  = .T.
830:             ENDWITH
831:             WITH .Buttons(3)
832:                 .Caption  = "Ambos"
833:                 .Left     = 122
834:                 .Top      = 3
835:                 .Width    = 60
836:                 .Height   = 17
837:                 .FontName = "Tahoma"
838:                 .FontSize = 8
839:                 .Visible  = .T.
840:             ENDWITH
841:         ENDWITH
842: 
843:         *-- == SITUACAO / TIPO (abertos/geral/dt operacao/dt vencto) ==
844:         THIS.AddObject("lbl_4c_Situacao", "Label")
845:         WITH THIS.lbl_4c_Situacao
846:             .Top       = 148
847:             .Left      = 485
848:             .Width     = 52
849:             .Height    = 18
850:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
851:             .FontName  = "Tahoma"
852:             .FontSize  = 8
853:             .BackStyle = 0
854:             .AutoSize  = .F.
855:             .Visible   = .T.
856:         ENDWITH
857: 
858:         THIS.AddObject("obj_4c_NrTipo", "OptionGroup")
859:         WITH THIS.obj_4c_NrTipo
860:             .Top         = 143
861:             .Left        = 541
862:             .Width       = 213
863:             .Height      = 26
864:             .ButtonCount = 4
865:             .BackStyle   = 0
866:             .BorderStyle = 0
867:             .Themes      = .F.
868:             .Value       = 2
869:             .Visible     = .T.
870:             WITH .Buttons(1)
871:                 .Caption = "Abertos"
872:                 .Left    = 0
873:                 .Top     = 5
874:                 .Width   = 51
875:                 .Height  = 17
876:                 .Visible = .T.
877:             ENDWITH
878:             WITH .Buttons(2)
879:                 .Caption  = "Geral"
880:                 .Left     = 52
881:                 .Top      = 5
882:                 .Width    = 51
883:                 .Height   = 17
884:                 .FontName = "Tahoma"
885:                 .FontSize = 8
886:                 .Visible  = .T.
887:             ENDWITH
888:             WITH .Buttons(3)
889:                 .Caption  = "Dt Opera" + CHR(231) + CHR(227) + "o"
890:                 .Left     = 104
891:                 .Top      = 5
892:                 .Width    = 55
893:                 .Height   = 17
894:                 .FontName = "Tahoma"
895:                 .FontSize = 8
896:                 .Visible  = .T.
897:             ENDWITH
898:             WITH .Buttons(4)
899:                 .Caption  = "Dt Vencto"
900:                 .Left     = 160
901:                 .Top      = 5
902:                 .Width    = 53
903:                 .Height   = 17
904:                 .FontName = "Tahoma"
905:                 .FontSize = 8
906:                 .Visible  = .T.
907:             ENDWITH
908:         ENDWITH
909: 
910:         *-- == ORDEM (ComboBox de classificacao do relatorio) ==
911:         THIS.AddObject("lbl_4c_Ordem", "Label")
912:         WITH THIS.lbl_4c_Ordem
913:             .Top       = 172
914:             .Left      = 494
915:             .Width     = 44
916:             .Height    = 18
917:             .Caption   = "Ordem :"
918:             .FontName  = "Tahoma"
919:             .FontSize  = 8
920:             .BackStyle = 0
921:             .AutoSize  = .F.
922:             .Visible   = .T.
923:         ENDWITH
924: 
925:         THIS.AddObject("cbo_4c_Ordem", "ComboBox")
926:         WITH THIS.cbo_4c_Ordem
927:             .Top           = 168
928:             .Left          = 543
929:             .Width         = 189
930:             .Height        = 24
931:             .FontName      = "Tahoma"
932:             .FontSize      = 8
933:             .RowSourceType = 1
934:             .RowSource     = "Carteira,Dep" + CHR(243) + "sito,Emissor," + ;
935:                              "Dt Entrada,C.P.F.,Nome"
936:             .Style         = 2
937:             .Value         = 1
938:             .Visible       = .T.
939:         ENDWITH
940: 
941:         *-- == ULTIMA MOVIMENTACAO (CheckBox) ==
942:         THIS.AddObject("chk_4c_Ultima", "CheckBox")
943:         WITH THIS.chk_4c_Ultima
944:             .Top       = 195
945:             .Left      = 543
946:             .Width     = 141
947:             .Height    = 17
948:             .Caption   = CHR(218) + "ltima Movimenta" + CHR(231) + CHR(227) + "o"
949:             .FontName  = "Tahoma"
950:             .FontSize  = 8
951:             .Value     = 1
952:             .BackStyle = 0
953:             .Themes    = .F.
954:             .Visible   = .T.
955:         ENDWITH
956: 
957:         *-- == CARTEIRA - GRUPO ==
958:         THIS.AddObject("lbl_4c_CarGrupo", "Label")
959:         WITH THIS.lbl_4c_CarGrupo
960:             .Top       = 225
961:             .Left      = 454
962:             .Width     = 84
963:             .Height    = 18
964:             .Caption   = "Grupo/Carteira :"
965:             .FontName  = "Tahoma"
966:             .FontSize  = 8
967:             .BackStyle = 0
968:             .AutoSize  = .F.
969:             .Visible   = .T.
970:         ENDWITH
971: 
972:         THIS.AddObject("txt_4c_CdCarGrupo", "TextBox")
973:         WITH THIS.txt_4c_CdCarGrupo
974:             .Top      = 220
975:             .Left     = 540
976:             .Width    = 79
977:             .Height   = 23
978:             .Value    = ""
979:             .FontName = "Tahoma"
980:             .FontSize = 8
981:             .Visible  = .T.
982:         ENDWITH
983: 
984:         THIS.AddObject("txt_4c_DsCarGrupo", "TextBox")
985:         WITH THIS.txt_4c_DsCarGrupo
986:             .Top      = 220
987:             .Left     = 621
988:             .Width    = 365
989:             .Height   = 23
990:             .Value    = ""
991:             .FontName = "Tahoma"
992:             .FontSize = 8
993:             .Visible  = .T.
994:         ENDWITH
995: 
996:         *-- == CARTEIRA - CONTA ==
997:         THIS.AddObject("lbl_4c_CarConta", "Label")
998:         WITH THIS.lbl_4c_CarConta
999:             .Top       = 250
1000:             .Left      = 454
1001:             .Width     = 84
1002:             .Height    = 18
1003:             .Caption   = "Conta/Carteira :"
1004:             .FontName  = "Tahoma"
1005:             .FontSize  = 8
1006:             .BackStyle = 0
1007:             .AutoSize  = .F.
1008:             .Visible   = .T.
1009:         ENDWITH
1010: 
1011:         THIS.AddObject("txt_4c_CdCarConta", "TextBox")
1012:         WITH THIS.txt_4c_CdCarConta
1013:             .Top      = 245
1014:             .Left     = 540
1015:             .Width    = 79
1016:             .Height   = 23
1017:             .Value    = ""
1018:             .FontName = "Tahoma"
1019:             .FontSize = 8
1020:             .Visible  = .T.
1021:         ENDWITH
1022: 
1023:         THIS.AddObject("txt_4c_DsCarConta", "TextBox")
1024:         WITH THIS.txt_4c_DsCarConta
1025:             .Top      = 245
1026:             .Left     = 621
1027:             .Width    = 365
1028:             .Height   = 23
1029:             .Value    = ""
1030:             .FontName = "Tahoma"
1031:             .FontSize = 8

*-- Linhas 1047 a 1072:
1047:     PROTECTED PROCEDURE ConfigurarGridOperacoes()
1048:         LOCAL loc_oGrid, loc_oCol
1049: 
1050:         THIS.AddObject("lbl_4c_Operacao", "Label")
1051:         WITH THIS.lbl_4c_Operacao
1052:             .Top       = 160
1053:             .Left      = 41
1054:             .Width     = 57
1055:             .Height    = 18
1056:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
1057:             .FontName  = "Tahoma"
1058:             .FontSize  = 8
1059:             .BackStyle = 0
1060:             .AutoSize  = .F.
1061:             .Visible   = .T.
1062:         ENDWITH
1063: 
1064:         THIS.AddObject("grd_4c_Operacoes", "Grid")
1065:         WITH THIS.grd_4c_Operacoes
1066:             .Top          = 158
1067:             .Left         = 101
1068:             .Width        = 188
1069:             .Height       = 147
1070:             .ColumnCount  = 3
1071:             .RecordSource = "cursor_4c_Operacoes"
1072:             .RecordMark   = .F.

*-- Linhas 1081 a 1117:
1081:             .HighlightStyle = 2
1082:             .Visible      = .T.
1083: 
1084:             *-- Coluna 1: CheckBox para marcar operacao (LOGICAL)
1085:             WITH .Column1
1086:                 .Width   = 22
1087:                 .Resizable = .F.
1088:                 .AddObject("Check1", "CheckBox")
1089:                 WITH .Check1
1090:                     .Caption  = ""
1091:                     .Value    = 0
1092:                     .Visible  = .T.
1093:                 ENDWITH
1094:                 .CurrentControl  = "Check1"
1095:                 .ControlSource   = "cursor_4c_Operacoes.Marcas"
1096:                 .Header1.Caption = ""
1097:             ENDWITH
1098: 
1099:             *-- Coluna 2: Descricao da operacao
1100:             WITH .Column2
1101:                 .Width          = 96
1102:                 .ControlSource  = "cursor_4c_Operacoes.Operacaos"
1103:                 .ReadOnly       = .T.
1104:                 .Header1.Caption = ""
1105:             ENDWITH
1106: 
1107:             *-- Coluna 3: Tipo da operacao
1108:             WITH .Column3
1109:                 .Width          = 40
1110:                 .ControlSource  = "cursor_4c_Operacoes.Tipos"
1111:                 .ReadOnly       = .T.
1112:                 .Header1.Caption = ""
1113:             ENDWITH
1114:         ENDWITH
1115: 
1116:         loc_oGrid = THIS.grd_4c_Operacoes
1117:         BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress", THIS, "TeclaCheckOperacoes")

*-- Linhas 1126 a 1151:
1126:     PROTECTED PROCEDURE ConfigurarGridImprimir()
1127:         LOCAL loc_oGrid
1128: 
1129:         THIS.AddObject("lbl_4c_Campos", "Label")
1130:         WITH THIS.lbl_4c_Campos
1131:             .Top       = 311
1132:             .Left      = 50
1133:             .Width     = 50
1134:             .Height    = 18
1135:             .Caption   = "Campos :"
1136:             .FontName  = "Tahoma"
1137:             .FontSize  = 8
1138:             .BackStyle = 0
1139:             .AutoSize  = .F.
1140:             .Visible   = .T.
1141:         ENDWITH
1142: 
1143:         THIS.AddObject("grd_4c_Imprimir", "Grid")
1144:         WITH THIS.grd_4c_Imprimir
1145:             .Top          = 311
1146:             .Left         = 101
1147:             .Width        = 188
1148:             .Height       = 58
1149:             .ColumnCount  = 2
1150:             .RecordSource = "cursor_4c_Imprimir"
1151:             .RecordMark   = .F.

*-- Linhas 1160 a 1188:
1160:             .HighlightStyle = 2
1161:             .Visible      = .T.
1162: 
1163:             *-- Coluna 1: CheckBox para marcar campo (LOGICAL)
1164:             WITH .Column1
1165:                 .Width   = 22
1166:                 .Resizable = .F.
1167:                 .AddObject("Check1", "CheckBox")
1168:                 WITH .Check1
1169:                     .Caption  = ""
1170:                     .Value    = 0
1171:                     .Visible  = .T.
1172:                 ENDWITH
1173:                 .CurrentControl  = "Check1"
1174:                 .ControlSource   = "cursor_4c_Imprimir.Marcas"
1175:                 .Header1.Caption = ""
1176:             ENDWITH
1177: 
1178:             *-- Coluna 2: Nome do campo de impressao
1179:             WITH .Column2
1180:                 .Width           = 146
1181:                 .ControlSource   = "cursor_4c_Imprimir.Campos"
1182:                 .ReadOnly        = .T.
1183:                 .Header1.Caption = ""
1184:             ENDWITH
1185:         ENDWITH
1186: 
1187:         loc_oGrid = THIS.grd_4c_Imprimir
1188:         BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress", THIS, "TeclaCheckImprimir")

*-- Linhas 1267 a 1277:
1267:             RETURN
1268:         ENDIF
1269:         WITH THIS.obj_4c_NrOpcao
1270:             .Buttons(1).Caption = THIS.this_oRelatorio.this_cTituloOpcao1
1271:             .Buttons(2).Caption = THIS.this_oRelatorio.this_cTituloOpcao2
1272:             .Buttons(3).Caption = THIS.this_oRelatorio.this_cTituloOpcao3
1273:         ENDWITH
1274:     ENDPROC
1275: 
1276:     *==========================================================================
1277:     * HANDLERS DE TECLA - KeyPress para campos de filtro (F4=115, ENTER=13, TAB=9)

*-- Linhas 1410 a 1418:
1410:     ENDPROC
1411: 
1412:     *==========================================================================
1413:     * TECLACHECK* - Toggle de checkbox nos grids via teclado (ENTER=13 / SPACE=32)
1414:     *==========================================================================
1415:     PROCEDURE TeclaCheckOperacoes(par_nKeyCode, par_nShift)
1416:         IF par_nKeyCode = 13 OR par_nKeyCode = 32
1417:             IF USED("cursor_4c_Operacoes") AND !EOF("cursor_4c_Operacoes")
1418:                 SELECT cursor_4c_Operacoes

*-- Linhas 2011 a 2034:
2011:         ENDIF
2012:         WITH THIS.this_oRelatorio
2013:             IF PEMSTATUS(THIS, "obj_4c_NrTipo", 5)
2014:                 THIS.obj_4c_NrTipo.Value = .this_nNrTipo
2015:             ENDIF
2016:             IF PEMSTATUS(THIS, "obj_4c_NrOpcao", 5)
2017:                 THIS.obj_4c_NrOpcao.Value = .this_nNrOpcao
2018:             ENDIF
2019:             IF PEMSTATUS(THIS, "cbo_4c_Ordem", 5)
2020:                 THIS.cbo_4c_Ordem.Value = .this_nOrdem
2021:             ENDIF
2022:             IF PEMSTATUS(THIS, "chk_4c_Ultima", 5)
2023:                 THIS.chk_4c_Ultima.Value = IIF(.this_lUltima = .T., 1, 0)
2024:             ENDIF
2025:             IF PEMSTATUS(THIS, "txt_4c_DtInicial", 5)
2026:                 THIS.txt_4c_DtInicial.Value = .this_dDtInicial
2027:             ENDIF
2028:             IF PEMSTATUS(THIS, "txt_4c_DtFinal", 5)
2029:                 THIS.txt_4c_DtFinal.Value = .this_dDtFinal
2030:             ENDIF
2031:             IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
2032:                 THIS.txt_4c_CdEmpresa.Value = ALLTRIM(.this_cCdEmpresa)
2033:             ENDIF
2034:             IF PEMSTATUS(THIS, "txt_4c_DsEmpresa", 5)


### BO (C:\4c\projeto\app\classes\sigrecheBO.prg):
*==============================================================================
* SIGRECHEBO.PRG
* Business Object para Relatorio de Cheques (SIGRECHE)
*
* Herda de RelatorioBase
* Filtros: periodo, empresa, tipo, opcao, ordem, ultima movimentacao,
*          carteira (grupo/conta), deposito (grupo/conta), emissor (grupo/conta)
* Tabelas principais: SigCqChm, SigChe, SigCdCli, SigCdOpt, SigCdPac, SigCdEmp
*==============================================================================

DEFINE CLASS sigrecheBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoFrx        = ""
    this_cTitulo            = ""

    *-- Nomes dos cursores
    this_cCursorDados       = "cursor_4c_Dados"
    this_cCursorCabecalho   = "cursor_4c_Cabecalho"
    this_cCursorOperacoes   = "cursor_4c_Operacoes"
    this_cCursorImprimir    = "cursor_4c_Imprimir"

    *-- Filtros de periodo (get_dt_inicial / get_dt_final)
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtros de empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa         = ""
    this_cDsEmpresa         = ""

    *-- Tipo de relatorio: 1=Abertos, 2=Geral, 3=DtOperacao, 4=DtVencimento
    this_nNrTipo            = 1

    *-- Opcao (com/sem nota): 1=Sim, 2=Nao, 3=Ambos
    this_nNrOpcao           = 3

    *-- Ordem de classificacao: 1=Carteira,2=Deposito,3=Emissor,4=DtEntrada,5=CPF,6=Nome
    this_nOrdem             = 1

    *-- Apenas ultima movimentacao por cheque
    this_lUltima            = .T.

    *-- Titulos dinamicos carregados de SigCdPac
    this_cTituloOpcao1      = "Sim"
    this_cTituloOpcao2      = "N" + CHR(227) + "o"
    this_cTituloOpcao3      = "Ambos"

    *-- Filtros de carteira (get_cd_car_grupo / get_ds_car_grupo / ...)
    this_cCdCarGrupo        = ""
    this_cDsCarGrupo        = ""
    this_cCdCarConta        = ""
    this_cDsCarConta        = ""

    *-- Filtros de deposito (get_cd_dep_grupo / get_ds_dep_grupo / ...)
    this_cCdDepGrupo        = ""
    this_cDsDepGrupo        = ""
    this_cCdDepConta        = ""
    this_cDsDepConta        = ""

    *-- Filtros de emissor (get_cd_emi_grupo / get_ds_emi_grupo / ...)
    this_cCdEmiGrupo        = ""
    this_cDsEmiGrupo        = ""
    this_cCdEmiConta        = ""
    this_cDsEmiConta        = ""

    *--------------------------------------------------------------------------
    * Init - Configura caminho do FRX e titulo; inicializa datas com hoje
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cArquivoFrx = gc_4c_CaminhoReports + "SigReChe.frx"
        THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Cheques"
        THIS.this_dDtInicial  = DATE()
        THIS.this_dDtFinal    = DATE()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria cursor_4c_Imprimir (campos opcionals de impressao)
    * e cursor_4c_Operacoes vazio (preenchido por CarregarOpcoes)
    * Chamado pelo Form em InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorImprimir)
                USE IN (THIS.this_cCursorImprimir)
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Imprimir (Marcas L(1), Campos C(20))
            SET NULL OFF
            INSERT INTO cursor_4c_Imprimir (Marcas, Campos) VALUES (.T., "C" + CHR(243) + "digo")
            INSERT INTO cursor_4c_Imprimir (Marcas, Campos) VALUES (.F., "C.P.F.")
            INSERT INTO cursor_4c_Imprimir (Marcas, Campos) VALUES (.F., "Nome")
            INSERT INTO cursor_4c_Imprimir (Marcas, Campos) VALUES (.F., "C.P.F. T")
            GO TOP IN cursor_4c_Imprimir

            IF USED(THIS.this_cCursorOperacoes)
                USE IN (THIS.this_cCursorOperacoes)
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Operacoes (Marcas L(1), Operacaos C(15), Tipos C(2))
            SET NULL OFF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarCursores")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOpcoes - Carrega SigCdOpt ? cursor_4c_Operacoes
    * e titulos de opcao de SigCdPac (para o OptionGroup do form)
    * Chamado pelo Form apos InicializarCursores()
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOpcoes()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT Operacaos, Tipos FROM SigCdOpt"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpt")
            IF loc_nResult > 0 AND USED("cursor_4c_TmpOpt")
                SELECT cursor_4c_TmpOpt
                GO TOP
                SCAN
                    INSERT INTO cursor_4c_Operacoes (Marcas, Operacaos, Tipos) ;
                        VALUES (.F., cursor_4c_TmpOpt.Operacaos, cursor_4c_TmpOpt.Tipos)
                ENDSCAN
                USE IN cursor_4c_TmpOpt
            ENDIF
            GO TOP IN cursor_4c_Operacoes

            loc_cSQL = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPac")
            IF loc_nResult > 0 AND USED("cursor_4c_TmpPac")
                SELECT cursor_4c_TmpPac
                GO TOP
                IF !EOF()
                    IF !EMPTY(ALLTRIM(TitOpcS))
                        THIS.this_cTituloOpcao1 = ALLTRIM(TitOpcS)
                    ENDIF
                    IF !EMPTY(ALLTRIM(TitOpcN))
                        THIS.this_cTituloOpcao2 = ALLTRIM(TitOpcN)
                    ENDIF
                    IF !EMPTY(ALLTRIM(TitOpcA))
                        THIS.this_cTituloOpcao3 = ALLTRIM(TitOpcA)
                    ENDIF
                ENDIF
                USE IN cursor_4c_TmpPac
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarOpcoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Validar - Valida filtros antes de gerar relatorio
    * Retorna .T. se tudo ok; caso contrario seta this_cMensagemErro
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_nMarcados

        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cMensagemErro = "Data inicial inv" + CHR(225) + "lida!"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cMensagemErro = "Data final inv" + CHR(225) + "lida!"
            RETURN .F.
        ENDIF
        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            THIS.this_cMensagemErro = "Data inicial maior que data final!"
            RETURN .F.
        ENDIF

        loc_nMarcados = 0
        IF USED(THIS.this_cCursorOperacoes)
            SELECT (THIS.this_cCursorOperacoes)
            SCAN
                IF Marcas
                    loc_nMarcados = loc_nMarcados + 1
                ENDIF
            ENDSCAN
        ENDIF
        IF loc_nMarcados = 0
            THIS.this_cMensagemErro = "Selecione ao menos uma Opera" + CHR(231) + CHR(227) + "o!"
            RETURN .F.
        ENDIF

        loc_nMarcados = 0
        IF USED(THIS.this_cCursorImprimir)
            SELECT (THIS.this_cCursorImprimir)
            SCAN
                IF Marcas
                    loc_nMarcados = loc_nMarcados + 1
                ENDIF
            ENDSCAN
        ENDIF
        IF loc_nMarcados = 0
            THIS.this_cMensagemErro = "Selecione ao menos um Campo para Impress" + CHR(227) + "o!"
            RETURN .F.
        ENDIF

        IF USED(THIS.this_cCursorImprimir)
            SELECT (THIS.this_cCursorImprimir)
            SCAN
                IF !Marcas
                    IF (Campos = "C.P.F." .AND. THIS.this_nOrdem = 5) .OR. ;
                       (Campos = "Nome"   .AND. THIS.this_nOrdem = 6)
                        THIS.this_cMensagemErro = "Esta Ordem Necessita Que Selecione o " + ;
                            "Campo de Impress" + CHR(227) + "o " + ALLTRIM(Campos) + "!"
                        RETURN .F.
                    ENDIF
                ENDIF
            ENDSCAN
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros, executa via SQLEXEC, filtra
    * por operacoes selecionadas e popula cursor_4c_Cabecalho + cursor_4c_Relatorio
    * Chamado por Imprimir() e Visualizar()
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult
        LOCAL loc_cVerData, loc_cVerEmpresa, loc_cVerOpcao
        LOCAL loc_cVerCarGrupo, loc_cVerCarConta
        LOCAL loc_cVerDepGrupo, loc_cVerDepConta
        LOCAL loc_cVerEmiGrupo, loc_cVerEmiConta
        LOCAL loc_cVerAberto, loc_cOrdenaPor, loc_cQuebra, loc_cTituloOrdem
        LOCAL loc_cTitulo, loc_cNomeEmpresa, loc_cPeriodo
        LOCAL loc_cCarteira, loc_cDeposito, loc_cEmissor, loc_cOperacao
        LOCAL loc_lCpfs, loc_lRclis, loc_lCpft
        LOCAL loc_cSQL, loc_cNum

        loc_lSucesso = .F.
        loc_lCpfs    = .F.
        loc_lRclis   = .F.
        loc_lCpft    = .F.

        TRY
            *-- 1. Condicao de data conforme tipo
            IF THIS.this_nNrTipo = 3
                loc_cVerData = " AND a.dtents BETWEEN " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                               " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            ELSE
                loc_cVerData = " AND b.vencs BETWEEN " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                               " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            ENDIF

            *-- 2. Filtros opcionais de empresa, opcao, carteira, deposito, emissor
            IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                loc_cVerEmpresa = ""
            ELSE
                loc_cVerEmpresa = " AND a.Emps = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmpresa))
            ENDIF

            IF THIS.this_nNrOpcao = 1
                loc_cVerOpcao = " AND a.notas <> '" + SPACE(6) + "'"
            ENDIF
            IF THIS.this_nNrOpcao = 2
                loc_cVerOpcao = " AND a.notas = '" + SPACE(6) + "'"
            ENDIF
            IF THIS.this_nNrOpcao = 3
                loc_cVerOpcao = ""
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCdCarGrupo))
                loc_cVerCarGrupo = ""
            ELSE
                loc_cVerCarGrupo = " AND a.grucarts = " + EscaparSQL(ALLTRIM(THIS.this_cCdCarGrupo))
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cCdCarConta))
                loc_cVerCarConta = ""
            ELSE
                loc_cVerCarConta = " AND a.concarts = " + EscaparSQL(ALLTRIM(THIS.this_cCdCarConta))
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCdDepGrupo))
                loc_cVerDepGrupo = ""
            ELSE
                loc_cVerDepGrupo = " AND a.grupos = " + EscaparSQL(ALLTRIM(THIS.this_cCdDepGrupo))
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cCdDepConta))
                loc_cVerDepConta = ""
            ELSE
                loc_cVerDepConta = " AND a.contas = " + EscaparSQL(ALLTRIM(THIS.this_cCdDepConta))
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCdEmiGrupo))
                loc_cVerEmiGrupo = ""
            ELSE
                loc_cVerEmiGrupo = " AND a.grclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmiGrupo))
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cCdEmiConta))
                loc_cVerEmiConta = ""
            ELSE
                loc_cVerEmiConta = " AND a.iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmiConta))
            ENDIF

            *-- Filtro de abertos aplicado no filtro local pos-SQLEXEC
            IF THIS.this_nNrTipo = 1
                loc_cVerAberto = " AND c.Tipos = 'DB'"
            ELSE
                loc_cVerAberto = ""
            ENDIF

            *-- 3. ORDER BY, campo Quebra e sufixo do titulo conforme ordem
            DO CASE
                CASE THIS.this_nOrdem = 1
                    loc_cOrdenaPor  = "a.GruCarts, a.ConCarts, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Grupo/Conta Carteira: ' + a.GruCarts + '/' + a.ConCarts"
                    loc_cTituloOrdem = "Carteira"
                CASE THIS.this_nOrdem = 2
                    loc_cOrdenaPor  = "a.Grupos, a.Contas, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Grupo/Conta Dep' + CHR(243) + 'sito: ' + a.Grupos + '/' + a.Contas"
                    loc_cTituloOrdem = "Dep" + CHR(243) + "sito"
                CASE THIS.this_nOrdem = 3
                    loc_cOrdenaPor  = "a.Grclis, a.Iclis, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Grupo/Conta Emissor: ' + a.Grclis + '/' + a.Iclis"
                    loc_cTituloOrdem = "Emissor"
                CASE THIS.this_nOrdem = 4
                    loc_cOrdenaPor  = "a.Dtents, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Entrada: ' + DTOC(a.Dtents)"
                    loc_cTituloOrdem = "Data de Entrada"
                CASE THIS.this_nOrdem = 5
                    loc_cOrdenaPor  = "a.Cpfs, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'C.P.F.: ' + a.Cpfs"
                    loc_cTituloOrdem = "C.P.F."
                OTHERWISE
                    loc_cOrdenaPor  = "a.Rclis, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Nome: ' + a.Rclis"
                    loc_cTituloOrdem = "Nome do Cliente"
            ENDCASE

            *-- 4. Titulo do relatorio
            loc_cTitulo = "Relat" + CHR(243) + "rio de Cheques - "
            DO CASE
                CASE THIS.this_nNrTipo = 1
                    loc_cTitulo = loc_cTitulo + "Abertos"
                CASE THIS.this_nNrTipo = 2
                    loc_cTitulo = loc_cTitulo + "Geral"
                CASE THIS.this_nNrTipo = 3
                    loc_cTitulo = loc_cTitulo + "Data de Opera" + CHR(231) + CHR(227) + "o"
                OTHERWISE
                    loc_cTitulo = loc_cTitulo + "Data de Vencimento"
            ENDCASE
            loc_cTitulo = loc_cTitulo + " - Ordem: " + loc_cTituloOrdem

            *-- 5. Nome da empresa corrente
            loc_cNomeEmpresa = ""
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE cEmps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmp")
            IF loc_nResult > 0 AND USED("cursor_4c_TmpEmp")
                SELECT cursor_4c_TmpEmp
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(Razas)
                ENDIF
                USE IN cursor_4c_TmpEmp
            ENDIF

            *-- 6. Textos descritivos para o cabecalho do relatorio
            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                           " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + " - " + ;
                           "Empresa: " + IIF(EMPTY(ALLTRIM(THIS.this_cCdEmpresa)), ;
                               "Geral", ;
                               ALLTRIM(THIS.this_cCdEmpresa) + " - " + ALLTRIM(THIS.this_cDsEmpresa))

            loc_cCarteira = "Grupo / Conta Carteira : " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdCarGrupo)), "Todos", ;
                    ALLTRIM(THIS.this_cCdCarGrupo) + " - " + ALLTRIM(THIS.this_cDsCarGrupo)) + ;
                " / " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdCarConta)), "Todas", ;
                    ALLTRIM(THIS.this_cCdCarConta) + " - " + ALLTRIM(THIS.this_cDsCarConta))

            loc_cDeposito = "Grupo / Conta Deposito : " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdDepGrupo)), "Todos", ;
                    ALLTRIM(THIS.this_cCdDepGrupo) + " - " + ALLTRIM(THIS.this_cDsDepGrupo)) + ;
                " / " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdDepConta)), "Todas", ;
                    ALLTRIM(THIS.this_cCdDepConta) + " - " + ALLTRIM(THIS.this_cDsDepConta))

            loc_cEmissor = "Grupo / Conta Emissor  : " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdEmiGrupo)), "Todos", ;
                    ALLTRIM(THIS.this_cCdEmiGrupo) + " - " + ALLTRIM(THIS.this_cDsEmiGrupo)) + ;
                " / " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdEmiConta)), "Todas", ;
                    ALLTRIM(THIS.this_cCdEmiConta) + " - " + ALLTRIM(THIS.this_cDsEmiConta))

            *-- 7. Texto das operacoes selecionadas
            loc_cOperacao = "Opera" + CHR(231) + CHR(227) + "o : "
            IF USED(THIS.this_cCursorOperacoes)
                SELECT (THIS.this_cCursorOperacoes)
                SCAN
                    IF Marcas
                        IF LEN(ALLTRIM(loc_cOperacao)) > 12
                            loc_cOperacao = loc_cOperacao + " / "
                        ENDIF
                        loc_cOperacao = loc_cOperacao + ALLTRIM(Operacaos)
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 8. Flags de campos de impressao (Cpfs, Rclis, CpfsT)
            IF USED(THIS.this_cCursorImprimir)
                SELECT (THIS.this_cCursorImprimir)
                SCAN
                    IF Marcas
                        IF Campos = "C.P.F."
                            loc_lCpfs = (THIS.this_nOrdem # 5)
                        ENDIF
                        IF Campos = "Nome"
                            loc_lRclis = (THIS.this_nOrdem # 6)
                        ENDIF
                        IF Campos = "C.P.F. T"
                            loc_lCpft = .T.
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 9. Cursor de cabecalho do relatorio
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Cabecalho (NomeEmpresa C(80), Titulo C(80), Periodo C(80), ;
                                               Operacao C(200), Carteira C(80), Deposito C(80), ;
                                               Emissor C(80), Tipo N(1), ;
                                               Cpfs L(1), Rclis L(1), Cpfst L(1))
            SET NULL OFF
            INSERT INTO cursor_4c_Cabecalho ;
                (NomeEmpresa, Titulo, Periodo, Operacao, Carteira, ;
                 Deposito, Emissor, Tipo, Cpfs, Rclis, Cpfst) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, loc_cOperacao, ;
                        loc_cCarteira, loc_cDeposito, loc_cEmissor, THIS.this_nOrdem, ;
                        loc_lCpfs, loc_lRclis, loc_lCpft)

            *-- 10. SQL principal via SQLEXEC (SigCqChm + SigChe + SigCdCli x3)
            IF USED("cursor_4c_Relatorio0")
                USE IN cursor_4c_Relatorio0
            ENDIF
            loc_cSQL = "SELECT a.Nums, a.NumLotes, a.Dtents, a.GruCarts, a.ConCarts, a.Grupos, " + ;
                       "a.Contas + '-' + e.rclis AS Contas, a.Grclis, a.Iclis, a.Dtsis, " + ;
                       "b.Vencs, b.Valors, b.Emps, b.Bancos, b.Agencias, b.Ncontas, b.Ncheques, " + ;
                       "b.Bancos + '-' + b.Agencias + '-' + b.Ncontas + '-' + b.Ncheques AS Cheques, " + ;
                       "a.codigos AS Operacaos, d.Cpfs, d.Rclis, a.hists, f.cpfs AS cpfsT " + ;
                       "FROM SigCqChm a, SigCdCli d, SigCdCli e, " + ;
                       "SigChe b LEFT JOIN SigCdCli f ON b.grupot = f.grupos AND b.contat = f.iclis " + ;
                       "WHERE a.Nums = b.Nums AND b.Iclis = d.Iclis AND a.contas = e.Iclis" + ;
                       loc_cVerData + loc_cVerEmpresa + loc_cVerOpcao + ;
                       loc_cVerCarGrupo + loc_cVerCarConta + ;
                       loc_cVerDepGrupo + loc_cVerDepConta + ;
                       loc_cVerEmiGrupo + loc_cVerEmiConta
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Relatorio0")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de cheques."
                loc_lSucesso = .F.
            ENDIF

            *-- 11. Filtrar por operacoes selecionadas e montar cursor final
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF

            IF THIS.this_lUltima
                *-- Apenas ultima movimentacao por numero de cheque
                *-- Cria cursor-modelo com campo Quebra adicional
                SELECT *, SPACE(100) AS Quebra ;
                    FROM cursor_4c_Relatorio0 ;
                    WHERE 0 = 1 ;
                    INTO CURSOR cursor_4c_Resultado READWRITE

                *-- Seleciona com Quebra calculada, ordenado por Nums + Dtsis DESC
                SELECT a.Nums, a.NumLotes, a.Dtents, a.GruCarts, a.ConCarts, a.Grupos, ;
                       a.Contas, a.Grclis, a.Iclis, a.Dtsis, ;
                       a.Vencs, a.Valors, a.Emps, a.Cheques, ;
                       a.Operacaos, a.Cpfs, a.Rclis, a.cpfsT, ;
                       &loc_cQuebra. AS Quebra, a.hists ;
                       FROM cursor_4c_Relatorio0 a, cursor_4c_Operacoes c ;
                       WHERE c.Marcas AND a.Operacaos = c.Operacaos &loc_cVerAberto. ;
                       INTO CURSOR cursor_4c_Selecao ;
                       ORDER BY a.Nums, a.Dtsis DESCENDING

                *-- Pega primeiro registro de cada grupo Nums (= mais recente)
                SELECT cursor_4c_Selecao
                GO TOP
                SCAN
                    loc_cNum = Nums
                    SCATTER MEMVAR MEMO
                    SELECT cursor_4c_Resultado
                    APPEND BLANK
                    GATHER MEMVAR MEMO
                    SELECT cursor_4c_Selecao
                    SCAN WHILE Nums = loc_cNum
                    ENDSCAN
                    SKIP -1
                ENDSCAN

                SELECT a.* FROM cursor_4c_Resultado a ;
                    ORDER BY &loc_cOrdenaPor. ;
                    INTO CURSOR cursor_4c_Relatorio

                IF USED("cursor_4c_Resultado")
                    USE IN cursor_4c_Resultado
                ENDIF
                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF
            ELSE
                *-- Todas as movimentacoes
                SELECT a.Nums, a.NumLotes, a.Dtents, a.GruCarts, a.ConCarts, a.Grupos, ;
                       a.Contas, a.Grclis, a.Iclis, a.Dtsis, ;
                       a.Vencs, a.Valors, a.Emps, a.Cheques, ;
                       a.Operacaos, a.Cpfs, a.Rclis, &loc_cQuebra. AS Quebra, a.hists, a.cpfsT ;
                       FROM cursor_4c_Relatorio0 a, cursor_4c_Operacoes c ;
                       WHERE c.Marcas AND a.Operacaos = c.Operacaos &loc_cVerAberto. ;
                       ORDER BY &loc_cOrdenaPor. ;
                       INTO CURSOR cursor_4c_Relatorio
            ENDIF

            IF USED("cursor_4c_Relatorio0")
                USE IN cursor_4c_Relatorio0
            ENDIF

            SELECT cursor_4c_Relatorio
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Valida, prepara dados e envia para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.Validar()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (THIS.this_cArquivoFrx) TO PRINTER PROMPT NOCONSOLE
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Valida, prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.Validar()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (THIS.this_cArquivoFrx) PREVIEW NOCONSOLE
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros do relatorio
    * Usada pela auditoria para identificar a execucao do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TIPO=" + ALLTRIM(STR(THIS.this_nNrTipo, 1)) + ;
                     ";OPC="  + ALLTRIM(STR(THIS.this_nNrOpcao, 1)) + ;
                     ";ORD="  + ALLTRIM(STR(THIS.this_nOrdem, 1)) + ;
                     ";DT="   + DTOC(THIS.this_dDtInicial) + ;
                     "-"      + DTOC(THIS.this_dDtFinal) + ;
                     ";EMP="  + ALLTRIM(THIS.this_cCdEmpresa) + ;
                     ";CAR="  + ALLTRIM(THIS.this_cCdCarGrupo) + "/" + ALLTRIM(THIS.this_cCdCarConta) + ;
                     ";DEP="  + ALLTRIM(THIS.this_cCdDepGrupo) + "/" + ALLTRIM(THIS.this_cCdDepConta) + ;
                     ";EMI="  + ALLTRIM(THIS.this_cCdEmiGrupo) + "/" + ALLTRIM(THIS.this_cCdEmiConta) + ;
                     ";ULT="  + IIF(THIS.this_lUltima, "S", "N")
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de cursor de preset
    * Para BO de relatorio, o cursor pode armazenar parametros previamente usados
    * par_cAliasCursor: nome do cursor com colunas dos filtros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                ELSE
                    SCATTER MEMVAR

                    IF TYPE("m.dDtInicial") = "D"
                        THIS.this_dDtInicial = m.dDtInicial
                    ENDIF
                    IF TYPE("m.dDtFinal") = "D"
                        THIS.this_dDtFinal = m.dDtFinal
                    ENDIF
                    IF TYPE("m.cCdEmpresa") = "C"
                        THIS.this_cCdEmpresa = ALLTRIM(m.cCdEmpresa)
                    ENDIF
                    IF TYPE("m.cDsEmpresa") = "C"
                        THIS.this_cDsEmpresa = ALLTRIM(m.cDsEmpresa)
                    ENDIF
                    IF TYPE("m.nNrTipo") = "N"
                        THIS.this_nNrTipo = m.nNrTipo
                    ENDIF
                    IF TYPE("m.nNrOpcao") = "N"
                        THIS.this_nNrOpcao = m.nNrOpcao
                    ENDIF
                    IF TYPE("m.nOrdem") = "N"
                        THIS.this_nOrdem = m.nOrdem
                    ENDIF
                    IF TYPE("m.lUltima") = "L"
                        THIS.this_lUltima = m.lUltima
                    ENDIF
                    IF TYPE("m.cCdCarGrupo") = "C"
                        THIS.this_cCdCarGrupo = ALLTRIM(m.cCdCarGrupo)
                    ENDIF
                    IF TYPE("m.cDsCarGrupo") = "C"
                        THIS.this_cDsCarGrupo = ALLTRIM(m.cDsCarGrupo)
                    ENDIF
                    IF TYPE("m.cCdCarConta") = "C"
                        THIS.this_cCdCarConta = ALLTRIM(m.cCdCarConta)
                    ENDIF
                    IF TYPE("m.cDsCarConta") = "C"
                        THIS.this_cDsCarConta = ALLTRIM(m.cDsCarConta)
                    ENDIF
                    IF TYPE("m.cCdDepGrupo") = "C"
                        THIS.this_cCdDepGrupo = ALLTRIM(m.cCdDepGrupo)
                    ENDIF
                    IF TYPE("m.cDsDepGrupo") = "C"
                        THIS.this_cDsDepGrupo = ALLTRIM(m.cDsDepGrupo)
                    ENDIF
                    IF TYPE("m.cCdDepConta") = "C"
                        THIS.this_cCdDepConta = ALLTRIM(m.cCdDepConta)
                    ENDIF
                    IF TYPE("m.cDsDepConta") = "C"
                        THIS.this_cDsDepConta = ALLTRIM(m.cDsDepConta)
                    ENDIF
                    IF TYPE("m.cCdEmiGrupo") = "C"
                        THIS.this_cCdEmiGrupo = ALLTRIM(m.cCdEmiGrupo)
                    ENDIF
                    IF TYPE("m.cDsEmiGrupo") = "C"
                        THIS.this_cDsEmiGrupo = ALLTRIM(m.cDsEmiGrupo)
                    ENDIF
                    IF TYPE("m.cCdEmiConta") = "C"
                        THIS.this_cCdEmiConta = ALLTRIM(m.cCdEmiConta)
                    ENDIF
                    IF TYPE("m.cDsEmiConta") = "C"
                        THIS.this_cDsEmiConta = ALLTRIM(m.cDsEmiConta)
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Delega para Imprimir e registra auditoria de IMPRESSAO
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Imprimir()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: recalcular e visualizar
    * Delega para Visualizar e registra auditoria de VISUALIZACAO
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Visualizar()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult
        LOCAL loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReChe") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores locais e chama base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_Relatorio")
            USE IN cursor_4c_Relatorio
        ENDIF
        IF USED(THIS.this_cCursorOperacoes)
            USE IN (THIS.this_cCursorOperacoes)
        ENDIF
        IF USED(THIS.this_cCursorImprimir)
            USE IN (THIS.this_cCursorImprimir)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

