# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 271: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 288: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormCliente.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1968 linhas total):

*-- Linhas 119 a 127:
119: 
120:                 *-- Inicializar clsconta
121:                 THIS.cnt_4c_Conta.mIniConta()
122:                 THIS.cnt_4c_Conta.pgframeDados.Top = 0
123:                 THIS.cnt_4c_Conta.cmdgPessoal.cmdPessoal.ToolTipText = "F5 - Dados Pessoais/Comerciais"
124: 
125:                 *-- Ajustar navegacao inicial do PageFrame interno (pgframeDados)
126:                 THIS.ConfigurarPaginaLista()
127:                 THIS.ConfigurarPaginaDados()

*-- Linhas 166 a 211:
166:         THIS.AddObject("cnt_4c_Sombra", "Container")
167:         loc_oCnt = THIS.cnt_4c_Sombra
168:         WITH loc_oCnt
169:             .Top        = -1
170:             .Left       = -1
171:             .Width      = THIS.Width
172:             .Height     = 80
173:             .BorderWidth = 0
174:             .BackColor  = RGB(100,100,100)
175:         ENDWITH
176:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
177:         WITH loc_oCnt.lbl_4c_LblSombra
178:             .FontBold      = .T.
179:             .FontName      = "Tahoma"
180:             .FontSize      = 18
181:             .FontUnderline = .F.
182:             .WordWrap      = .T.
183:             .Alignment     = 0
184:             .BackStyle     = 0
185:             .AutoSize      = .F.
186:             .Caption       = "Cadastro de Cliente"
187:             .Height        = 40
188:             .Left          = 10
189:             .Top           = 18
190:             .Width         = 769
191:             .ForeColor     = RGB(0,0,0)
192:             .Visible       = .T.
193:         ENDWITH
194:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
195:         WITH loc_oCnt.lbl_4c_LblTitulo
196:             .FontBold   = .T.
197:             .FontName   = "Tahoma"
198:             .FontSize   = 18
199:             .WordWrap   = .T.
200:             .Alignment  = 0
201:             .BackStyle  = 0
202:             .AutoSize   = .F.
203:             .Caption    = "Cadastro de Cliente"
204:             .Height     = 46
205:             .Left       = 10
206:             .Top        = 17
207:             .Width      = 769
208:             .ForeColor  = RGB(255,255,255)
209:             .Visible    = .T.
210:         ENDWITH
211:         THIS.cnt_4c_Sombra.Visible = .T.

*-- Linhas 235 a 244:
235: 
236:         THIS.AddObject("cnt_4c_Conta", "clsconta")
237:         WITH THIS.cnt_4c_Conta
238:             .Top    = 132
239:             .Left   = 12
240:             .Width  = 768
241:             .Height = 450
242:             .Visible     = .T.
243:         ENDWITH
244:         *-- cnt_4c_Conta permanece oculto ate mLeDados retornar .T. em InicializarForm

*-- Linhas 256 a 298:
256:             .BorderStyle   = 0
257:             .Value         = 1
258:             .Height        = 85
259:             .Left          = 688
260:             .SpecialEffect = 1
261:             .Top           = -2
262:             .Width         = 161
263:         ENDWITH
264:         WITH loc_oCmg.Buttons(1)
265:             .Top        = 5
266:             .Left       = 5
267:             .Height     = 75
268:             .Width      = 75
269:             .FontBold   = .T.
270:             .FontItalic = .T.
271:             .FontName   = "Comic Sans MS"
272:             .FontSize   = 8
273:             .WordWrap   = .T.
274:             .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
275:             .Caption    = "\<Ok"
276:             .ForeColor  = RGB(90,90,90)
277:             .BackColor  = RGB(255,255,255)
278:             .Themes     = .F.
279:             .Visible    = .T.
280:         ENDWITH
281:         WITH loc_oCmg.Buttons(2)
282:             .Top        = 5
283:             .Left       = 81
284:             .Height     = 75
285:             .Width      = 75
286:             .FontBold   = .T.
287:             .FontItalic = .T.
288:             .FontName   = "Comic Sans MS"
289:             .FontSize   = 8
290:             .WordWrap   = .T.
291:             .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
292:             .Cancel     = .T.
293:             .Caption    = "\<Cancelar"
294:             .ForeColor  = RGB(90,90,90)
295:             .BackColor  = RGB(255,255,255)
296:             .Themes     = .F.
297:             .Visible    = .T.
298:         ENDWITH

*-- Linhas 406 a 414:
406: 
407:         loc_oPgf = THIS.cnt_4c_Conta.pgframeDados
408: 
409:         loc_oPgf.Top        = 0
410:         loc_oPgf.ActivePage = 1
411:         loc_oPgf.Visible    = .T.
412: 
413:         *-- Realcar botao da pagina ativa (cmdgCadastro se existir)
414:         IF PEMSTATUS(THIS.cnt_4c_Conta, "cmdgCadastro", 5) AND ;

*-- Linhas 516 a 662:
516:             *-- Shape1 (borda secao principal)
517:             IF PEMSTATUS(loc_oPg1, "Shape1", 5)
518:                 WITH loc_oPg1.Shape1
519:                     .Top           = 2
520:                     .Left          = 6
521:                     .Height        = 195
522:                     .Width         = 751
523:                     .SpecialEffect = 1
524:                     .BorderColor   = RGB(136,188,189)
525:                 ENDWITH
526:             ENDIF
527: 
528:             *-- Shape2 (borda secao dados pessoais)
529:             IF PEMSTATUS(loc_oPg1, "Shape2", 5)
530:                 WITH loc_oPg1.Shape2
531:                     .Top           = 196
532:                     .Left          = 6
533:                     .Width         = 751
534:                     .SpecialEffect = 1
535:                     .BorderColor   = RGB(136,188,189)
536:                 ENDWITH
537:             ENDIF
538: 
539:             *-- Shape4 (borda secao observacoes)
540:             IF PEMSTATUS(loc_oPg1, "Shape4", 5)
541:                 WITH loc_oPg1.Shape4
542:                     .Top           = 344
543:                     .Left          = 6
544:                     .SpecialEffect = 1
545:                     .BorderColor   = RGB(136,188,189)
546:                 ENDWITH
547:             ENDIF
548: 
549:             *-- Shape3 (area foto)
550:             IF PEMSTATUS(loc_oPg1, "Shape3", 5)
551:                 WITH loc_oPg1.Shape3
552:                     .Top    = 71
553:                     .Left   = 573
554:                     .Height = 77
555:                     .Width  = 182
556:                 ENDWITH
557:             ENDIF
558: 
559:             *-- Shape5 (borda cabecalho foto)
560:             IF PEMSTATUS(loc_oPg1, "Shape5", 5)
561:                 WITH loc_oPg1.Shape5
562:                     .Top         = 8
563:                     .Left        = 573
564:                     .Width       = 182
565:                     .BorderColor = RGB(100,100,100)
566:                 ENDWITH
567:             ENDIF
568: 
569:             *-- Say2 (label nome/razao)
570:             IF PEMSTATUS(loc_oPg1, "Say2", 5)
571:                 WITH loc_oPg1.Say2
572:                     .FontName  = "Tahoma"
573:                     .Left      = 31
574:                     .Top       = 58
575:                     .ForeColor = RGB(90,90,90)
576:                 ENDWITH
577:             ENDIF
578: 
579:             *-- Say12 (label empresa)
580:             IF PEMSTATUS(loc_oPg1, "Say12", 5)
581:                 WITH loc_oPg1.Say12
582:                     .AutoSize  = .T.
583:                     .FontName  = "Tahoma"
584:                     .Left      = 17
585:                     .Top       = 81
586:                     .ForeColor = RGB(90,90,90)
587:                 ENDWITH
588:             ENDIF
589: 
590:             *-- Say16 (label codigo)
591:             IF PEMSTATUS(loc_oPg1, "Say16", 5)
592:                 WITH loc_oPg1.Say16
593:                     .FontName  = "Tahoma"
594:                     .Left      = 67
595:                     .Top       = 15
596:                     .ForeColor = RGB(90,90,90)
597:                 ENDWITH
598:             ENDIF
599: 
600:             *-- Say22 (label inscr. estadual)
601:             IF PEMSTATUS(loc_oPg1, "Say22", 5)
602:                 WITH loc_oPg1.Say22
603:                     .FontName  = "Tahoma"
604:                     .Left      = 17
605:                     .Top       = 104
606:                     .ForeColor = RGB(90,90,90)
607:                 ENDWITH
608:             ENDIF
609: 
610:             *-- sayConjuges (label conjuge)
611:             IF PEMSTATUS(loc_oPg1, "sayConjuges", 5)
612:                 WITH loc_oPg1.sayConjuges
613:                     .AutoSize  = .T.
614:                     .FontName  = "Tahoma"
615:                     .Left      = 19
616:                     .Top       = 150
617:                     .ForeColor = RGB(90,90,90)
618:                 ENDWITH
619:             ENDIF
620: 
621:             *-- sayDtncons (label aniversario)
622:             IF PEMSTATUS(loc_oPg1, "sayDtncons", 5)
623:                 WITH loc_oPg1.sayDtncons
624:                     .FontName  = "Tahoma"
625:                     .Caption   = "Aniv : "
626:                     .Left      = 362
627:                     .Top       = 150
628:                     .ForeColor = RGB(90,90,90)
629:                 ENDWITH
630:             ENDIF
631: 
632:             *-- sayDtcasas (label data casamento)
633:             IF PEMSTATUS(loc_oPg1, "sayDtcasas", 5)
634:                 WITH loc_oPg1.sayDtcasas
635:                     .FontName  = "Tahoma"
636:                     .Left      = 330
637:                     .Top       = 173
638:                     .ForeColor = RGB(90,90,90)
639:                 ENDWITH
640:             ENDIF
641: 
642:             *-- Say29 (label usuario alt.)
643:             IF PEMSTATUS(loc_oPg1, "Say29", 5)
644:                 WITH loc_oPg1.Say29
645:                     .FontName  = "Tahoma"
646:                     .Left      = 575
647:                     .Top       = 45
648:                     .ForeColor = RGB(90,90,90)
649:                 ENDWITH
650:             ENDIF
651: 
652:             *-- Say30 (label usuario cadastro)
653:             IF PEMSTATUS(loc_oPg1, "Say30", 5)
654:                 WITH loc_oPg1.Say30
655:                     .FontName  = "Tahoma"
656:                     .Left      = 578
657:                     .Top       = 17
658:                     .ForeColor = RGB(90,90,90)
659:                 ENDWITH
660:             ENDIF
661: 
662:             *-- Say3 (label)

*-- Linhas 671 a 740:
671:             IF PEMSTATUS(loc_oPg1, "SayIm", 5)
672:                 WITH loc_oPg1.SayIm
673:                     .FontName  = "Tahoma"
674:                     .Left      = 390
675:                     .Top       = 105
676:                     .ForeColor = RGB(90,90,90)
677:                 ENDWITH
678:             ENDIF
679: 
680:             *-- lblCpf2 (label CPF/CNPJ socio)
681:             IF PEMSTATUS(loc_oPg1, "lblCpf2", 5)
682:                 WITH loc_oPg1.lblCpf2
683:                     .FontName  = "Tahoma"
684:                     .Left      = 39
685:                     .Top       = 173
686:                     .ForeColor = RGB(90,90,90)
687:                 ENDWITH
688:             ENDIF
689: 
690:             *-- Say31 (label foto)
691:             IF PEMSTATUS(loc_oPg1, "Say31", 5)
692:                 WITH loc_oPg1.Say31
693:                     .FontName  = "Tahoma"
694:                     .Left      = 619
695:                     .Top       = 77
696:                     .ForeColor = RGB(90,90,90)
697:                 ENDWITH
698:             ENDIF
699: 
700:             *-- lblRg2 (label RG socio)
701:             IF PEMSTATUS(loc_oPg1, "lblRg2", 5)
702:                 WITH loc_oPg1.lblRg2
703:                     .FontName  = "Tahoma"
704:                     .Left      = 181
705:                     .Top       = 173
706:                     .ForeColor = RGB(90,90,90)
707:                 ENDWITH
708:             ENDIF
709: 
710:             *-- SayRgIe (label RG/IE)
711:             IF PEMSTATUS(loc_oPg1, "SayRgIe", 5)
712:                 WITH loc_oPg1.SayRgIe
713:                     .FontName  = "Tahoma"
714:                     .Left      = 263
715:                     .Top       = 35
716:                     .ForeColor = RGB(90,90,90)
717:                 ENDWITH
718:             ENDIF
719: 
720:             *-- sayDatNas (label data nascimento)
721:             IF PEMSTATUS(loc_oPg1, "sayDatNas", 5)
722:                 WITH loc_oPg1.sayDatNas
723:                     .FontName  = "Tahoma"
724:                     .Left      = 444
725:                     .Top       = 58
726:                     .ForeColor = RGB(90,90,90)
727:                 ENDWITH
728:             ENDIF
729: 
730:             *-- SayResp (label responsavel)
731:             IF PEMSTATUS(loc_oPg1, "SayResp", 5)
732:                 WITH loc_oPg1.SayResp
733:                     .FontName  = "Tahoma"
734:                     .Left      = 29
735:                     .Top       = 128
736:                     .ForeColor = RGB(90,90,90)
737:                 ENDWITH
738:             ENDIF
739: 
740:             *-- Say1 (label)

*-- Linhas 749 a 758:
749:             IF PEMSTATUS(loc_oPg1, "SaySexo", 5)
750:                 WITH loc_oPg1.SaySexo
751:                     .FontName  = "Tahoma"
752:                     .Left      = 443
753:                     .Top       = 35
754:                     .ForeColor = RGB(90,90,90)
755:                 ENDWITH
756:             ENDIF
757: 
758:             *-- Say21 (label)

*-- Linhas 767 a 1264:
767:             IF PEMSTATUS(loc_oPg1, "Say25", 5)
768:                 WITH loc_oPg1.Say25
769:                     .FontName  = "Tahoma"
770:                     .Left      = 581
771:                     .Top       = 139
772:                     .ForeColor = RGB(90,90,90)
773:                 ENDWITH
774:             ENDIF
775: 
776:             *-- Say32 (label)
777:             IF PEMSTATUS(loc_oPg1, "Say32", 5)
778:                 WITH loc_oPg1.Say32
779:                     .FontName  = "Tahoma"
780:                     .Left      = 244
781:                     .Top       = 10
782:                     .ForeColor = RGB(90,90,90)
783:                 ENDWITH
784:             ENDIF
785: 
786:             *-- Say23 (label)
787:             IF PEMSTATUS(loc_oPg1, "Say23", 5)
788:                 WITH loc_oPg1.Say23
789:                     .FontName  = "Tahoma"
790:                     .Left      = 600
791:                     .Top       = 123
792:                     .ForeColor = RGB(90,90,90)
793:                 ENDWITH
794:             ENDIF
795: 
796:             *-- Say33 (label)
797:             IF PEMSTATUS(loc_oPg1, "Say33", 5)
798:                 WITH loc_oPg1.Say33
799:                     .FontName  = "Tahoma"
800:                     .Left      = 594
801:                     .Top       = 100
802:                     .ForeColor = RGB(90,90,90)
803:                 ENDWITH
804:             ENDIF
805: 
806:             *-- lblEstCivil (label estado civil)
807:             IF PEMSTATUS(loc_oPg1, "lblEstCivil", 5)
808:                 WITH loc_oPg1.lblEstCivil
809:                     .FontName  = "Tahoma"
810:                     .Left      = 503
811:                     .Top       = 174
812:                     .ForeColor = RGB(90,90,90)
813:                 ENDWITH
814:             ENDIF
815: 
816:             *-- Get_usualt (TextBox usuario alteracao)
817:             IF PEMSTATUS(loc_oPg1, "Get_usualt", 5)
818:                 WITH loc_oPg1.Get_usualt
819:                     .Left      = 590
820:                     .Top       = 42
821:                     .ForeColor = RGB(90,90,90)
822:                 ENDWITH
823:             ENDIF
824: 
825:             *-- Get_usuar (TextBox usuario cadastro)
826:             IF PEMSTATUS(loc_oPg1, "Get_usuar", 5)
827:                 WITH loc_oPg1.Get_usuar
828:                     .Left      = 590
829:                     .Top       = 14
830:                     .ForeColor = RGB(90,90,90)
831:                 ENDWITH
832:             ENDIF
833: 
834:             *-- Data_ent (TextBox data entrada)
835:             IF PEMSTATUS(loc_oPg1, "Data_ent", 5)
836:                 WITH loc_oPg1.Data_ent
837:                     .Left      = 670
838:                     .Top       = 14
839:                     .ForeColor = RGB(90,90,90)
840:                 ENDWITH
841:             ENDIF
842: 
843:             *-- Data_alt (TextBox data alteracao)
844:             IF PEMSTATUS(loc_oPg1, "Data_alt", 5)
845:                 WITH loc_oPg1.Data_alt
846:                     .Left      = 670
847:                     .Top       = 42
848:                     .ForeColor = RGB(90,90,90)
849:                 ENDWITH
850:             ENDIF
851: 
852:             *-- GetCodigo (TextBox codigo)
853:             IF PEMSTATUS(loc_oPg1, "GetCodigo", 5)
854:                 WITH loc_oPg1.GetCodigo
855:                     .Left = 290
856:                     .Top  = 8
857:                 ENDWITH
858:             ENDIF
859: 
860:             *-- Get_Grupo (TextBox grupo)
861:             IF PEMSTATUS(loc_oPg1, "Get_Grupo", 5)
862:                 WITH loc_oPg1.Get_Grupo
863:                     .Left = 108
864:                     .Top  = 8
865:                 ENDWITH
866:             ENDIF
867: 
868:             *-- GetNome (TextBox nome)
869:             IF PEMSTATUS(loc_oPg1, "GetNome", 5)
870:                 WITH loc_oPg1.GetNome
871:                     .Left = 70
872:                     .Top  = 55
873:                 ENDWITH
874:             ENDIF
875: 
876:             *-- GetCPFCGC (TextBox CPF/CNPJ)
877:             IF PEMSTATUS(loc_oPg1, "GetCPFCGC", 5)
878:                 WITH loc_oPg1.GetCPFCGC
879:                     .Left = 108
880:                     .Top  = 32
881:                 ENDWITH
882:             ENDIF
883: 
884:             *-- GetRG (TextBox RG/IE)
885:             IF PEMSTATUS(loc_oPg1, "GetRG", 5)
886:                 WITH loc_oPg1.GetRG
887:                     .Height = 23
888:                     .Left   = 290
889:                     .Top    = 32
890:                     .Width  = 149
891:                 ENDWITH
892:             ENDIF
893: 
894:             *-- getSexo (ComboBox sexo)
895:             IF PEMSTATUS(loc_oPg1, "getSexo", 5)
896:                 WITH loc_oPg1.getSexo
897:                     .Left = 483
898:                     .Top  = 32
899:                 ENDWITH
900:             ENDIF
901: 
902:             *-- GetDatNas (TextBox data nascimento)
903:             IF PEMSTATUS(loc_oPg1, "GetDatNas", 5)
904:                 WITH loc_oPg1.GetDatNas
905:                     .Left = 483
906:                     .Top  = 55
907:                 ENDWITH
908:             ENDIF
909: 
910:             *-- getResp (TextBox codigo responsavel)
911:             IF PEMSTATUS(loc_oPg1, "getResp", 5)
912:                 WITH loc_oPg1.getResp
913:                     .Left = 151
914:                     .Top  = 124
915:                 ENDWITH
916:             ENDIF
917: 
918:             *-- Get_grupoven (TextBox grupo de vendas)
919:             IF PEMSTATUS(loc_oPg1, "Get_grupoven", 5)
920:                 WITH loc_oPg1.Get_grupoven
921:                     .Left = 70
922:                     .Top  = 124
923:                 ENDWITH
924:             ENDIF
925: 
926:             *-- getNresp (TextBox numero do responsavel)
927:             IF PEMSTATUS(loc_oPg1, "getNresp", 5)
928:                 WITH loc_oPg1.getNresp
929:                     .Left = 232
930:                     .Top  = 124
931:                 ENDWITH
932:             ENDIF
933: 
934:             *-- Get_Emps (TextBox codigo empresa)
935:             IF PEMSTATUS(loc_oPg1, "Get_Emps", 5)
936:                 WITH loc_oPg1.Get_Emps
937:                     .Left = 70
938:                     .Top  = 101
939:                 ENDWITH
940:             ENDIF
941: 
942:             *-- Get_DEmps (TextBox descricao empresa)
943:             IF PEMSTATUS(loc_oPg1, "Get_DEmps", 5)
944:                 WITH loc_oPg1.Get_DEmps
945:                     .Left = 100
946:                     .Top  = 101
947:                 ENDWITH
948:             ENDIF
949: 
950:             *-- Get_InsMuns (TextBox inscricao municipal)
951:             IF PEMSTATUS(loc_oPg1, "Get_InsMuns", 5)
952:                 WITH loc_oPg1.Get_InsMuns
953:                     .Height = 23
954:                     .Left   = 431
955:                     .Top    = 101
956:                     .Width  = 141
957:                 ENDWITH
958:             ENDIF
959: 
960:             *-- Get_Situa (TextBox situacao do cliente)
961:             IF PEMSTATUS(loc_oPg1, "Get_Situa", 5)
962:                 WITH loc_oPg1.Get_Situa
963:                     .Left = 673
964:                     .Top  = 74
965:                 ENDWITH
966:             ENDIF
967: 
968:             *-- getTelem (TextBox telefone celular)
969:             IF PEMSTATUS(loc_oPg1, "getTelem", 5)
970:                 WITH loc_oPg1.getTelem
971:                     .Left = 673
972:                     .Top  = 97
973:                 ENDWITH
974:             ENDIF
975: 
976:             *-- getClacod (TextBox classe do codigo)
977:             IF PEMSTATUS(loc_oPg1, "getClacod", 5)
978:                 WITH loc_oPg1.getClacod
979:                     .Left = 673
980:                     .Top  = 120
981:                 ENDWITH
982:             ENDIF
983: 
984:             *-- getConjuges (TextBox conjuge)
985:             IF PEMSTATUS(loc_oPg1, "getConjuges", 5)
986:                 WITH loc_oPg1.getConjuges
987:                     .Left = 70
988:                     .Top  = 147
989:                 ENDWITH
990:             ENDIF
991: 
992:             *-- getDtncons (TextBox aniversario conjuge)
993:             IF PEMSTATUS(loc_oPg1, "getDtncons", 5)
994:                 WITH loc_oPg1.getDtncons
995:                     .Left = 396
996:                     .Top  = 147
997:                 ENDWITH
998:             ENDIF
999: 
1000:             *-- getDtcasas (TextBox data casamento)
1001:             IF PEMSTATUS(loc_oPg1, "getDtcasas", 5)
1002:                 WITH loc_oPg1.getDtcasas
1003:                     .Left = 396
1004:                     .Top  = 170
1005:                 ENDWITH
1006:             ENDIF
1007: 
1008:             IF PEMSTATUS(loc_oPg1, "getCpf2", 5)
1009:                 WITH loc_oPg1.getCpf2
1010:                     .Left = 70
1011:                     .Top  = 170
1012:                 ENDWITH
1013:             ENDIF
1014: 
1015:             IF PEMSTATUS(loc_oPg1, "getRG2", 5)
1016:                 WITH loc_oPg1.getRG2
1017:                     .Left = 211
1018:                     .Top  = 170
1019:                 ENDWITH
1020:             ENDIF
1021: 
1022:             *-- cmbEstcivils (ComboBox estado civil)
1023:             IF PEMSTATUS(loc_oPg1, "cmbEstcivils", 5)
1024:                 WITH loc_oPg1.cmbEstcivils
1025:                     .Left = 572
1026:                     .Top  = 170
1027:                 ENDWITH
1028:             ENDIF
1029: 
1030:             *-- chkInativa (CheckBox cliente inativado)
1031:             IF PEMSTATUS(loc_oPg1, "chkInativa", 5)
1032:                 WITH loc_oPg1.chkInativa
1033:                     .FontName  = "Tahoma"
1034:                     .Alignment = 0
1035:                     .ForeColor = RGB(90,90,90)
1036:                 ENDWITH
1037:             ENDIF
1038: 
1039:             *-- OpcaoCPFCGC (OptionGroup tipo documento - posicao)
1040:             IF PEMSTATUS(loc_oPg1, "OpcaoCPFCGC", 5)
1041:                 WITH loc_oPg1.OpcaoCPFCGC
1042:                     .Left = 14
1043:                     .Top  = 33
1044:                 ENDWITH
1045:             ENDIF
1046: 
1047:             *-- GetCEP (TextBox CEP)
1048:             IF PEMSTATUS(loc_oPg1, "GetCEP", 5)
1049:                 WITH loc_oPg1.GetCEP
1050:                     .Left = 102
1051:                     .Top  = 200
1052:                 ENDWITH
1053:             ENDIF
1054: 
1055:             *-- GetPais (TextBox pais)
1056:             IF PEMSTATUS(loc_oPg1, "GetPais", 5)
1057:                 WITH loc_oPg1.GetPais
1058:                     .Left = 230
1059:                     .Top  = 200
1060:                 ENDWITH
1061:             ENDIF
1062: 
1063:             *-- GetEndere?o (TextBox endereco - nome com cedilha CHR(231))
1064:             loc_cNomeEndCtrl = "GetEndere" + CHR(231) + "o"
1065:             IF PEMSTATUS(loc_oPg1, loc_cNomeEndCtrl, 5)
1066:                 loc_oEndCtrl = EVALUATE("loc_oPg1." + loc_cNomeEndCtrl)
1067:                 WITH loc_oEndCtrl
1068:                     .Left = 102
1069:                     .Top  = 223
1070:                 ENDWITH
1071:                 loc_oEndCtrl = .NULL.
1072:             ENDIF
1073: 
1074:             *-- Get_num (TextBox numero do endereco)
1075:             IF PEMSTATUS(loc_oPg1, "Get_num", 5)
1076:                 WITH loc_oPg1.Get_num
1077:                     .Left = 561
1078:                     .Top  = 223
1079:                 ENDWITH
1080:             ENDIF
1081: 
1082:             *-- Get_comp (TextBox complemento)
1083:             IF PEMSTATUS(loc_oPg1, "Get_comp", 5)
1084:                 WITH loc_oPg1.Get_comp
1085:                     .Left = 102
1086:                     .Top  = 246
1087:                 ENDWITH
1088:             ENDIF
1089: 
1090:             *-- GetBairro (TextBox bairro)
1091:             IF PEMSTATUS(loc_oPg1, "GetBairro", 5)
1092:                 WITH loc_oPg1.GetBairro
1093:                     .Left = 334
1094:                     .Top  = 246
1095:                 ENDWITH
1096:             ENDIF
1097: 
1098:             *-- GetCidade (TextBox cidade)
1099:             IF PEMSTATUS(loc_oPg1, "GetCidade", 5)
1100:                 WITH loc_oPg1.GetCidade
1101:                     .Height = 23
1102:                     .Left   = 102
1103:                     .Top    = 269
1104:                     .Width  = 230
1105:                 ENDWITH
1106:             ENDIF
1107: 
1108:             *-- getCidasIBGE (TextBox codigo IBGE da cidade)
1109:             IF PEMSTATUS(loc_oPg1, "getCidasIBGE", 5)
1110:                 WITH loc_oPg1.getCidasIBGE
1111:                     .Left = 334
1112:                     .Top  = 269
1113:                 ENDWITH
1114:             ENDIF
1115: 
1116:             *-- GetEstado (TextBox UF/Estado)
1117:             IF PEMSTATUS(loc_oPg1, "GetEstado", 5)
1118:                 WITH loc_oPg1.GetEstado
1119:                     .Left = 483
1120:                     .Top  = 269
1121:                 ENDWITH
1122:             ENDIF
1123: 
1124:             *-- getUFIBGE (TextBox codigo IBGE da UF)
1125:             IF PEMSTATUS(loc_oPg1, "getUFIBGE", 5)
1126:                 WITH loc_oPg1.getUFIBGE
1127:                     .Left = 508
1128:                     .Top  = 269
1129:                 ENDWITH
1130:             ENDIF
1131: 
1132:             *-- Get_Regiao (TextBox regiao)
1133:             IF PEMSTATUS(loc_oPg1, "Get_Regiao", 5)
1134:                 WITH loc_oPg1.Get_Regiao
1135:                     .Left = 596
1136:                     .Top  = 269
1137:                 ENDWITH
1138:             ENDIF
1139: 
1140:             *-- getDdds (TextBox DDD)
1141:             IF PEMSTATUS(loc_oPg1, "getDdds", 5)
1142:                 WITH loc_oPg1.getDdds
1143:                     .Left = 102
1144:                     .Top  = 292
1145:                 ENDWITH
1146:             ENDIF
1147: 
1148:             *-- GetTel1 (TextBox telefone 1)
1149:             IF PEMSTATUS(loc_oPg1, "GetTel1", 5)
1150:                 WITH loc_oPg1.GetTel1
1151:                     .Left = 179
1152:                     .Top  = 292
1153:                 ENDWITH
1154:             ENDIF
1155: 
1156:             *-- GetTel2 (TextBox telefone 2)
1157:             IF PEMSTATUS(loc_oPg1, "GetTel2", 5)
1158:                 WITH loc_oPg1.GetTel2
1159:                     .Left = 385
1160:                     .Top  = 292
1161:                 ENDWITH
1162:             ENDIF
1163: 
1164:             *-- GetFax (TextBox fax)
1165:             IF PEMSTATUS(loc_oPg1, "GetFax", 5)
1166:                 WITH loc_oPg1.GetFax
1167:                     .Left = 596
1168:                     .Top  = 292
1169:                 ENDWITH
1170:             ENDIF
1171: 
1172:             *-- Say13 (label secao dados comerciais/endereco)
1173:             IF PEMSTATUS(loc_oPg1, "Say13", 5)
1174:                 WITH loc_oPg1.Say13
1175:                     .Left = 61
1176:                     .Top  = 295
1177:                 ENDWITH
1178:             ENDIF
1179: 
1180:             *-- GetEmail (TextBox e-mail)
1181:             IF PEMSTATUS(loc_oPg1, "GetEmail", 5)
1182:                 WITH loc_oPg1.GetEmail
1183:                     .Left = 102
1184:                     .Top  = 315
1185:                 ENDWITH
1186:             ENDIF
1187: 
1188:             *-- Say19 (label e-mail)
1189:             IF PEMSTATUS(loc_oPg1, "Say19", 5)
1190:                 WITH loc_oPg1.Say19
1191:                     .Left = 55
1192:                     .Top  = 318
1193:                 ENDWITH
1194:             ENDIF
1195: 
1196:             *-- GetCodFun (TextBox codigo funcao)
1197:             IF PEMSTATUS(loc_oPg1, "GetCodFun", 5)
1198:                 WITH loc_oPg1.GetCodFun
1199:                     .Left = 97
1200:                     .Top  = 349
1201:                 ENDWITH
1202:             ENDIF
1203: 
1204:             *-- GetDesFun (TextBox descricao funcao)
1205:             IF PEMSTATUS(loc_oPg1, "GetDesFun", 5)
1206:                 WITH loc_oPg1.GetDesFun
1207:                     .Left = 130
1208:                     .Top  = 349
1209:                 ENDWITH
1210:             ENDIF
1211: 
1212:             *-- Say17 (label funcao/cargo do cliente)
1213:             IF PEMSTATUS(loc_oPg1, "Say17", 5)
1214:                 WITH loc_oPg1.Say17
1215:                     .Left = 13
1216:                     .Top  = 352
1217:                 ENDWITH
1218:             ENDIF
1219: 
1220:             *-- cmdEnderecos (CommandGroup multiplos enderecos)
1221:             IF PEMSTATUS(loc_oPg1, "cmdEnderecos", 5)
1222:                 WITH loc_oPg1.cmdEnderecos
1223:                     .Left = 444
1224:                     .Top  = 360
1225:                 ENDWITH
1226:             ENDIF
1227: 
1228:             *-- lblObs (label area de observacoes)
1229:             IF PEMSTATUS(loc_oPg1, "lblObs", 5)
1230:                 WITH loc_oPg1.lblObs
1231:                     .Left = 62
1232:                     .Top  = 371
1233:                 ENDWITH
1234:             ENDIF
1235: 
1236:             *-- chkObservas (CheckBox filtrar por observacao)
1237:             IF PEMSTATUS(loc_oPg1, "chkObservas", 5)
1238:                 WITH loc_oPg1.chkObservas
1239:                     .Top       = 387
1240:                     .Left      = 59
1241:                     .Alignment = 0
1242:                 ENDWITH
1243:             ENDIF
1244: 
1245:             *-- MemoFun (EditBox observacoes/memo)
1246:             IF PEMSTATUS(loc_oPg1, "MemoFun", 5)
1247:                 WITH loc_oPg1.MemoFun
1248:                     .Left = 97
1249:                     .Top  = 373
1250:                 ENDWITH
1251:             ENDIF
1252: 
1253:             *-- GetRaz?o (TextBox razao social - nome com til CHR(227))
1254:             loc_cNomeRazCtrl = "GetRaz" + CHR(227) + "o"
1255:             IF PEMSTATUS(loc_oPg1, loc_cNomeRazCtrl, 5)
1256:                 loc_oRazCtrl = EVALUATE("loc_oPg1." + loc_cNomeRazCtrl)
1257:                 WITH loc_oRazCtrl
1258:                     .Left = 70
1259:                     .Top  = 78
1260:                 ENDWITH
1261:                 loc_oRazCtrl = .NULL.
1262:             ENDIF
1263: 
1264:             *-- Say9 (label)

*-- Linhas 1396 a 1468:
1396:             IF PEMSTATUS(loc_oPg2, "Say4", 5)
1397:                 WITH loc_oPg2.Say4
1398:                     .FontName  = "Tahoma"
1399:                     .Left      = 72
1400:                     .ForeColor = RGB(90,90,90)
1401:                 ENDWITH
1402:             ENDIF
1403: 
1404:             *-- Say5 (label)
1405:             IF PEMSTATUS(loc_oPg2, "Say5", 5)
1406:                 WITH loc_oPg2.Say5
1407:                     .FontName  = "Tahoma"
1408:                     .Left      = 76
1409:                     .ForeColor = RGB(90,90,90)
1410:                 ENDWITH
1411:             ENDIF
1412: 
1413:             *-- sayDtcasas (label data casamento - pg2)
1414:             IF PEMSTATUS(loc_oPg2, "sayDtcasas", 5)
1415:                 WITH loc_oPg2.sayDtcasas
1416:                     .FontName  = "Tahoma"
1417:                     .Left      = 296
1418:                     .ForeColor = RGB(90,90,90)
1419:                 ENDWITH
1420:             ENDIF
1421: 
1422:             *-- Say6 (label)
1423:             IF PEMSTATUS(loc_oPg2, "Say6", 5)
1424:                 WITH loc_oPg2.Say6
1425:                     .FontName  = "Tahoma"
1426:                     .Left      = 316
1427:                     .Top       = 231
1428:                     .ForeColor = RGB(90,90,90)
1429:                 ENDWITH
1430:             ENDIF
1431: 
1432:             *-- Say7 (label)
1433:             IF PEMSTATUS(loc_oPg2, "Say7", 5)
1434:                 WITH loc_oPg2.Say7
1435:                     .FontName  = "Tahoma"
1436:                     .Left      = 52
1437:                     .ForeColor = RGB(90,90,90)
1438:                 ENDWITH
1439:             ENDIF
1440: 
1441:             *-- Say8 (label)
1442:             IF PEMSTATUS(loc_oPg2, "Say8", 5)
1443:                 WITH loc_oPg2.Say8
1444:                     .FontName  = "Tahoma"
1445:                     .Left      = 98
1446:                     .ForeColor = RGB(90,90,90)
1447:                 ENDWITH
1448:             ENDIF
1449: 
1450:             *-- Say9 (label - pg2)
1451:             IF PEMSTATUS(loc_oPg2, "Say9", 5)
1452:                 WITH loc_oPg2.Say9
1453:                     .FontName  = "Tahoma"
1454:                     .Left      = 84
1455:                     .ForeColor = RGB(90,90,90)
1456:                 ENDWITH
1457:             ENDIF
1458: 
1459:             *-- Say10 (label)
1460:             IF PEMSTATUS(loc_oPg2, "Say10", 5)
1461:                 WITH loc_oPg2.Say10
1462:                     .FontName  = "Tahoma"
1463:                     .Left      = 537
1464:                     .ForeColor = RGB(90,90,90)
1465:                 ENDWITH
1466:             ENDIF
1467: 
1468:             *-- Say11 (label - pg2)

*-- Linhas 1477 a 1496:
1477:             IF PEMSTATUS(loc_oPg2, "Say12", 5)
1478:                 WITH loc_oPg2.Say12
1479:                     .FontName  = "Tahoma"
1480:                     .Left      = 92
1481:                     .Top       = 279
1482:                     .ForeColor = RGB(90,90,90)
1483:                 ENDWITH
1484:             ENDIF
1485: 
1486:             *-- Say14 (label - pg2)
1487:             IF PEMSTATUS(loc_oPg2, "Say14", 5)
1488:                 WITH loc_oPg2.Say14
1489:                     .FontName  = "Tahoma"
1490:                     .Left      = 47
1491:                     .Top       = 302
1492:                     .ForeColor = RGB(90,90,90)
1493:                 ENDWITH
1494:             ENDIF
1495: 
1496:             *-- Say15 (label)

*-- Linhas 1505 a 1541:
1505:             IF PEMSTATUS(loc_oPg2, "Say16", 5)
1506:                 WITH loc_oPg2.Say16
1507:                     .FontName  = "Tahoma"
1508:                     .Left      = 25
1509:                     .Top       = 333
1510:                     .ForeColor = RGB(90,90,90)
1511:                 ENDWITH
1512:             ENDIF
1513: 
1514:             *-- Say17 (label - pg2)
1515:             IF PEMSTATUS(loc_oPg2, "Say17", 5)
1516:                 WITH loc_oPg2.Say17
1517:                     .FontName  = "Tahoma"
1518:                     .Left      = 504
1519:                     .ForeColor = RGB(90,90,90)
1520:                 ENDWITH
1521:             ENDIF
1522: 
1523:             *-- Say18 (label)
1524:             IF PEMSTATUS(loc_oPg2, "Say18", 5)
1525:                 WITH loc_oPg2.Say18
1526:                     .FontName  = "Tahoma"
1527:                     .Left      = 294
1528:                     .ForeColor = RGB(90,90,90)
1529:                 ENDWITH
1530:             ENDIF
1531: 
1532:             *-- Say19 (label - pg2)
1533:             IF PEMSTATUS(loc_oPg2, "Say19", 5)
1534:                 WITH loc_oPg2.Say19
1535:                     .FontName  = "Tahoma"
1536:                     .Left      = 536
1537:                     .ForeColor = RGB(90,90,90)
1538:                 ENDWITH
1539:             ENDIF
1540: 
1541:             *-- Say20 (label)

*-- Linhas 1558 a 1566:
1558:             IF PEMSTATUS(loc_oPg2, "Say22", 5)
1559:                 WITH loc_oPg2.Say22
1560:                     .FontName  = "Tahoma"
1561:                     .Left      = 85
1562:                     .ForeColor = RGB(90,90,90)
1563:                 ENDWITH
1564:             ENDIF
1565: 
1566:             *-- Say23 (label - pg2)

*-- Linhas 1599 a 1607:
1599:             IF PEMSTATUS(loc_oPg2, "SayTel1", 5)
1600:                 WITH loc_oPg2.SayTel1
1601:                     .FontName  = "Tahoma"
1602:                     .Left      = 91
1603:                     .ForeColor = RGB(90,90,90)
1604:                 ENDWITH
1605:             ENDIF
1606: 
1607:             *-- say_Limite (label limite de credito)

*-- Linhas 1615 a 1624:
1615:             *-- getGrauParens (TextBox grau de parentesco)
1616:             IF PEMSTATUS(loc_oPg2, "getGrauParens", 5)
1617:                 WITH loc_oPg2.getGrauParens
1618:                     .Left = 376
1619:                     .Top  = 299
1620:                 ENDWITH
1621:             ENDIF
1622: 
1623:             *-- Cnt_Limite.Say1 (label dentro do container de limite)
1624:             IF PEMSTATUS(loc_oPg2, "Cnt_Limite", 5)

