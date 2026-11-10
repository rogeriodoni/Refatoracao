# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [ALINHAMENTO] Botao 'cmd_4c_BtnMultObs' tem Top=5 mas grupo usa Top=20 (diferenca de 15px)
- [ALINHAMENTO] Botao 'cmd_4c_CmdEntrega' tem Top=0 mas grupo usa Top=20 (diferenca de 20px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopinf.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3573 linhas total):

*-- Linhas 93 a 113:
93: *     UI, FormBuscaAuxiliar para o restante) e cmdEntrega ("Local de
94: *     Entrega", abre SigCdEnd - fora do acervo, AvisarLegadoNaoPortado)
95: *   - ConfigurarPedido()/ConfigurarObs2()/ConfigurarLivre(): cntPedido,
96: *     CntObs2 (abre SigOpIns - fora do acervo) e cntLivre
97: *   - KeyPress do Form (F2/F3 do legado) para os dois botoes de navegacao
98: *     por atalho, agora que cntEntrega.cmd_4c_CmdEntrega existe
99: *
100: * FASE 7/8 - EVENTOS PRINCIPAIS DO CICLO DE VIDA. Este dialogo NAO tem
101: * botoes de Incluir/Alterar/Visualizar/Excluir (nao e form CRUD - ver
102: * comentario de cabecalho acima, "Tipo: OPERACIONAL"); o template generico
103: * de Fase 7 (BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
104: * BtnExcluirClick) nao se aplica aqui e NAO foi criado - inventar esses
105: * quatro metodos seria codigo morto, sem botao nenhum para dispara-los, e
106: * violaria o PILAR 1 (o legado nao tem essas acoes nesta tela). Os
107: * "eventos principais" reais desta tela sao o que falta do Init legado
108: * (205 linhas) para o form deixar de operar em modo falso-seguro. Entrega:
109: *   - CarregarCursoresOperacao(): "With ThisForm.ParentForm.poDataMgr /
110: *     .Cursorquery('SigCdOpe','CrSigCdOpe','Dopes',TprMvCab.Dopes) /
111: *     .Cursorquery('SigOpCdc','CrSigOpCdc','Dopes',TprMvCab.Dopes) /
112: *     .Cursorquery('SigOpCdd','CrSigOpCdd','Dopes',TprMvCab.Dopes)" do Init
113: *     legado (a 4a CursorQuery, SigCdEmp/CrEmp, fica de fora - so e usada

*-- Linhas 437 a 446:
437:     * titulo do form desenhado duas vezes: lblSombra em preto atras e
438:     * lblTitulo em branco por cima, 1px acima, o que produz o relevo -
439:     * exatamente como o Init legado faz nas duas primeiras linhas:
440:     *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
441:     *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
442:     *
443:     * Geometria transcrita do dump (layout.json), com UMA correcao
444:     * deliberada de Width: o SCX declara cntSombra.Width = 1100 e os dois
445:     * labels com Width = 769, enquanto o proprio Form tem Width = 1000 - o
446:     * container do cabecalho foi desenhado no Form Designer mais largo que a

*-- Linhas 462 a 508:
462:         THIS.AddObject("cnt_4c_Sombra", "Container")
463:         loc_oCnt = THIS.cnt_4c_Sombra
464:         WITH loc_oCnt
465:             .Top         = 0
466:             .Left        = 0
467:             .Width       = THIS.Width
468:             .Height      = 80
469:             .BorderWidth = 0
470:             .BackColor   = RGB(100, 100, 100)
471:             .Visible     = .T.
472:         ENDWITH
473: 
474:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
475:         WITH loc_oCnt.lbl_4c_LblSombra
476:             .FontBold  = .T.
477:             .FontName  = "Tahoma"
478:             .FontSize  = 18
479:             .WordWrap  = .T.
480:             .Alignment = 0
481:             .BackStyle = 0
482:             .AutoSize  = .F.
483:             .Caption   = THIS.Caption
484:             .Left      = 10
485:             .Top       = 18
486:             .Width     = THIS.Width - 20
487:             .Height    = 40
488:             .ForeColor = RGB(0, 0, 0)
489:             .Visible   = .T.
490:         ENDWITH
491: 
492:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
493:         WITH loc_oCnt.lbl_4c_LblTitulo
494:             .FontBold  = .T.
495:             .FontName  = "Tahoma"
496:             .FontSize  = 18
497:             .WordWrap  = .T.
498:             .Alignment = 0
499:             .BackStyle = 0
500:             .AutoSize  = .F.
501:             .Caption   = THIS.Caption
502:             .Left      = 10
503:             .Top        = 17
504:             .Width     = THIS.Width - 20
505:             .Height    = 46
506:             .ForeColor = RGB(255, 255, 255)
507:             .Visible   = .T.
508:         ENDWITH

*-- Linhas 535 a 565:
535:         THIS.AddObject("obj_4c_CntBotoes", "CommandGroup")
536:         loc_oGrp = THIS.obj_4c_CntBotoes
537:         WITH loc_oGrp
538:             .Top           = -2
539:             .Left          = 920
540:             .Width         = 85
541:             .Height        = 85
542:             .ButtonCount   = 1
543:             .BackStyle     = 0
544:             .BorderStyle   = 0
545:             .SpecialEffect = 1
546:             .Visible       = .T.
547:         ENDWITH
548:         WITH loc_oGrp.Buttons(1)
549:             .Top             = 5
550:             .Left            = 5
551:             .Width           = 75
552:             .Height          = 75
553:             .FontBold        = .T.
554:             .FontItalic      = .T.
555:             .FontName        = "Tahoma"
556:             .FontSize        = 8
557:             .WordWrap        = .T.
558:             .PicturePosition = 13
559:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
560:             .Caption         = "\<Salvar"
561:             .MousePointer    = 15
562:             .ToolTipText     = "Gravar os Dados Informados"
563:             .SpecialEffect   = 0
564:             .ForeColor       = RGB(90, 90, 90)
565:             .BackColor       = RGB(255, 255, 255)

*-- Linhas 571 a 601:
571:         THIS.AddObject("obj_4c_CmdCotacao", "CommandGroup")
572:         loc_oGrp = THIS.obj_4c_CmdCotacao
573:         WITH loc_oGrp
574:             .Top           = -2
575:             .Left          = 845
576:             .Width         = 85
577:             .Height        = 85
578:             .ButtonCount   = 1
579:             .BackStyle     = 0
580:             .BorderStyle   = 0
581:             .SpecialEffect = 1
582:             .Visible       = .T.
583:         ENDWITH
584:         WITH loc_oGrp.Buttons(1)
585:             .Top             = 5
586:             .Left            = 5
587:             .Width           = 75
588:             .Height          = 75
589:             .FontBold        = .T.
590:             .FontItalic      = .T.
591:             .FontName        = "Tahoma"
592:             .FontSize        = 8
593:             .WordWrap        = .T.
594:             .PicturePosition = 13
595:             .Picture         = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
596:             .Caption         = "\<Cota" + CHR(231) + CHR(227) + "o"
597:             .MousePointer    = 15
598:             .ToolTipText     = "Alterar Cota" + CHR(231) + CHR(227) + "o Informativa"
599:             .SpecialEffect   = 0
600:             .ForeColor       = RGB(90, 90, 90)
601:             .BackColor       = RGB(255, 255, 255)

*-- Linhas 607 a 637:
607:         THIS.AddObject("obj_4c_CmdEntrega", "CommandGroup")
608:         loc_oGrp = THIS.obj_4c_CmdEntrega
609:         WITH loc_oGrp
610:             .Top           = -2
611:             .Left          = 770
612:             .Width         = 85
613:             .Height        = 85
614:             .ButtonCount   = 1
615:             .BackStyle     = 0
616:             .BorderStyle   = 0
617:             .SpecialEffect = 1
618:             .Visible       = .T.
619:         ENDWITH
620:         WITH loc_oGrp.Buttons(1)
621:             .Top             = 5
622:             .Left            = 5
623:             .Width           = 75
624:             .Height          = 75
625:             .FontBold        = .T.
626:             .FontItalic      = .T.
627:             .FontName        = "Comic Sans MS"
628:             .FontSize        = 8
629:             .WordWrap        = .T.
630:             .PicturePosition = 13
631:             .Picture         = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
632:             .Caption         = "\<Entrega"
633:             .MousePointer    = 15
634:             .ToolTipText     = "Alterar Prazo de Entrega <F3>"
635:             .SpecialEffect   = 0
636:             .ForeColor       = RGB(90, 90, 90)
637:             .BackColor       = RGB(255, 255, 255)

*-- Linhas 667 a 705:
667:         THIS.AddObject("cnt_4c_Codigos", "Container")
668:         loc_oCnt = THIS.cnt_4c_Codigos
669:         WITH loc_oCnt
670:             .Top         = 96
671:             .Left        = 2
672:             .Width       = 67
673:             .Height      = 45
674:             .BackStyle   = 0
675:             .BorderWidth = 0
676:             .Visible     = .T.
677:         ENDWITH
678: 
679:         loc_oCnt.AddObject("lbl_4c_LblCodigos", "Label")
680:         WITH loc_oCnt.lbl_4c_LblCodigos
681:             .FontBold  = .F.
682:             .FontName  = "Tahoma"
683:             .FontSize  = 8
684:             .BackStyle = 0
685:             .Alignment = 0
686:             .AutoSize  = .F.
687:             .Caption   = "C" + CHR(243) + "digo "
688:             .Left      = 3
689:             .Top       = 3
690:             .Width     = 61
691:             .ForeColor = RGB(90, 90, 90)
692:             .Visible   = .T.
693:         ENDWITH
694: 
695:         loc_oCnt.AddObject("txt_4c_Codigos", "TextBox")
696:         WITH loc_oCnt.txt_4c_Codigos
697:             .FontBold      = .T.
698:             .FontSize      = 8
699:             .Left          = 3
700:             .Top           = 20
701:             .Width         = 61
702:             .MaxLength     = 10
703:             .SpecialEffect = 1
704:             .ForeColor     = RGB(0, 0, 0)
705:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 714 a 750:
714:         THIS.AddObject("cnt_4c_Documentos", "Container")
715:         loc_oCnt = THIS.cnt_4c_Documentos
716:         WITH loc_oCnt
717:             .Top         = 96
718:             .Left        = 69
719:             .Width       = 170
720:             .Height      = 45
721:             .BackStyle   = 0
722:             .BorderWidth = 0
723:             .Visible     = .T.
724:         ENDWITH
725: 
726:         loc_oCnt.AddObject("lbl_4c_LblDocumentos", "Label")
727:         WITH loc_oCnt.lbl_4c_LblDocumentos
728:             .FontBold  = .F.
729:             .FontName  = "Tahoma"
730:             .FontSize  = 8
731:             .BackStyle = 0
732:             .Alignment = 0
733:             .AutoSize  = .F.
734:             .Caption   = "Documento"
735:             .Left      = 3
736:             .Top       = 3
737:             .Width     = 56
738:             .ForeColor = RGB(90, 90, 90)
739:             .Visible   = .T.
740:         ENDWITH
741: 
742:         loc_oCnt.AddObject("txt_4c_Documentos", "TextBox")
743:         WITH loc_oCnt.txt_4c_Documentos
744:             .Left          = 3
745:             .Top           = 20
746:             .Width         = 67
747:             .Margin        = 0
748:             .MaxLength     = 6
749:             .SpecialEffect = 1
750:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 756 a 783:
756:         ENDIF
757:         BINDEVENT(loc_oCnt.txt_4c_Documentos, "When", THIS, "DocumentosWhen")
758: 
759:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
760:         WITH loc_oCnt.lbl_4c_Label1
761:             .FontBold  = .F.
762:             .FontName  = "Tahoma"
763:             .FontSize  = 8
764:             .BackStyle = 0
765:             .Alignment = 0
766:             .AutoSize  = .F.
767:             .Caption   = "Nota"
768:             .Left      = 73
769:             .Top       = 3
770:             .Width     = 25
771:             .ForeColor = RGB(90, 90, 90)
772:             .Visible   = .T.
773:         ENDWITH
774: 
775:         loc_oCnt.AddObject("txt_4c_NumeroNota", "TextBox")
776:         WITH loc_oCnt.txt_4c_NumeroNota
777:             .Left          = 73
778:             .Top           = 20
779:             .Width         = 94
780:             .Height        = 23
781:             .Margin        = 0
782:             .MaxLength     = 10
783:             .SpecialEffect = 1

*-- Linhas 794 a 831:
794:         THIS.AddObject("cnt_4c_Ecfs", "Container")
795:         loc_oCnt = THIS.cnt_4c_Ecfs
796:         WITH loc_oCnt
797:             .Top         = 96
798:             .Left        = 240
799:             .Width       = 65
800:             .Height      = 45
801:             .BackStyle   = 0
802:             .BorderWidth = 0
803:             .Visible     = .T.
804:         ENDWITH
805: 
806:         loc_oCnt.AddObject("lbl_4c_LblEcfs", "Label")
807:         WITH loc_oCnt.lbl_4c_LblEcfs
808:             .FontBold  = .F.
809:             .FontName  = "Tahoma"
810:             .FontSize  = 8
811:             .BackStyle = 0
812:             .Alignment = 0
813:             .AutoSize  = .F.
814:             .Caption   = "ECF  "
815:             .Left      = 3
816:             .Top       = 3
817:             .Width     = 27
818:             .Height    = 15
819:             .ForeColor = RGB(90, 90, 90)
820:             .Visible   = .T.
821:         ENDWITH
822: 
823:         loc_oCnt.AddObject("txt_4c_Ecfs", "TextBox")
824:         WITH loc_oCnt.txt_4c_Ecfs
825:             .Left          = 3
826:             .Top           = 20
827:             .Width         = 59
828:             .Height        = 23
829:             .Margin        = 0
830:             .InputMask     = "9999999"
831:             .MaxLength     = 7

*-- Linhas 843 a 880:
843:         THIS.AddObject("cnt_4c_Nemps", "Container")
844:         loc_oCnt = THIS.cnt_4c_Nemps
845:         WITH loc_oCnt
846:             .Top         = 96
847:             .Left        = 305
848:             .Width       = 156
849:             .Height      = 45
850:             .BackStyle   = 0
851:             .BorderWidth = 0
852:             .Visible     = .T.
853:         ENDWITH
854: 
855:         loc_oCnt.AddObject("lbl_4c_LblNemps", "Label")
856:         WITH loc_oCnt.lbl_4c_LblNemps
857:             .FontBold  = .F.
858:             .FontName  = "Tahoma"
859:             .FontSize  = 8
860:             .BackStyle = 0
861:             .Alignment = 0
862:             .AutoSize  = .F.
863:             .Caption   = "N" + CHR(186) + " S" + CHR(233) + "rie Imp."
864:             .Left      = 3
865:             .Top       = 3
866:             .Width     = 66
867:             .Height    = 15
868:             .ForeColor = RGB(90, 90, 90)
869:             .Visible   = .T.
870:         ENDWITH
871: 
872:         loc_oCnt.AddObject("txt_4c_Nemps", "TextBox")
873:         WITH loc_oCnt.txt_4c_Nemps
874:             .Left          = 3
875:             .Top           = 20
876:             .Width         = 150
877:             .Height        = 23
878:             .Margin        = 0
879:             .MaxLength     = 20
880:             .SpecialEffect = 1

*-- Linhas 992 a 1028:
992:         THIS.AddObject("cnt_4c_Emiss", "Container")
993:         loc_oCnt = THIS.cnt_4c_Emiss
994:         WITH loc_oCnt
995:             .Top         = 147
996:             .Left        = 2
997:             .Width       = 86
998:             .Height      = 45
999:             .BackStyle   = 0
1000:             .BorderWidth = 0
1001:             .Visible     = .T.
1002:         ENDWITH
1003: 
1004:         loc_oCnt.AddObject("lbl_4c_LblEmiss", "Label")
1005:         WITH loc_oCnt.lbl_4c_LblEmiss
1006:             .FontBold  = .F.
1007:             .FontName  = "Tahoma"
1008:             .FontSize  = 8
1009:             .BackStyle = 0
1010:             .Alignment = 0
1011:             .AutoSize  = .F.
1012:             .Caption   = "Data Emiss" + CHR(227) + "o "
1013:             .Left      = 3
1014:             .Top       = 3
1015:             .Width     = 80
1016:             .ForeColor = RGB(90, 90, 90)
1017:             .Visible   = .T.
1018:         ENDWITH
1019: 
1020:         loc_oCnt.AddObject("txt_4c_Emiss", "TextBox")
1021:         WITH loc_oCnt.txt_4c_Emiss
1022:             .Left          = 3
1023:             .Top           = 20
1024:             .Width         = 80
1025:             .Margin        = 0
1026:             .SpecialEffect = 1
1027:             .ForeColor     = RGB(0, 0, 0)
1028:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1039 a 1075:
1039:         THIS.AddObject("cnt_4c_Entregas", "Container")
1040:         loc_oCnt = THIS.cnt_4c_Entregas
1041:         WITH loc_oCnt
1042:             .Top         = 147
1043:             .Left        = 88
1044:             .Width       = 86
1045:             .Height      = 45
1046:             .BackStyle   = 0
1047:             .BorderWidth = 0
1048:             .Visible     = .T.
1049:         ENDWITH
1050: 
1051:         loc_oCnt.AddObject("lbl_4c_LblEntregas", "Label")
1052:         WITH loc_oCnt.lbl_4c_LblEntregas
1053:             .FontBold  = .F.
1054:             .FontName  = "Tahoma"
1055:             .FontSize  = 8
1056:             .BackStyle = 0
1057:             .Alignment = 0
1058:             .AutoSize  = .F.
1059:             .Caption   = "Prz. Entrega "
1060:             .Left      = 3
1061:             .Top       = 3
1062:             .Width     = 80
1063:             .ForeColor = RGB(90, 90, 90)
1064:             .Visible   = .T.
1065:         ENDWITH
1066: 
1067:         loc_oCnt.AddObject("txt_4c_Entregas", "TextBox")
1068:         WITH loc_oCnt.txt_4c_Entregas
1069:             .Left          = 3
1070:             .Top           = 20
1071:             .Width         = 80
1072:             .Margin        = 0
1073:             .SpecialEffect = 1
1074:             .ForeColor     = RGB(0, 0, 0)
1075:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1086 a 1122:
1086:         THIS.AddObject("cnt_4c_Recepcaos", "Container")
1087:         loc_oCnt = THIS.cnt_4c_Recepcaos
1088:         WITH loc_oCnt
1089:             .Top         = 147
1090:             .Left        = 174
1091:             .Width       = 86
1092:             .Height      = 45
1093:             .BackStyle   = 0
1094:             .BorderWidth = 0
1095:             .Visible     = .T.
1096:         ENDWITH
1097: 
1098:         loc_oCnt.AddObject("lbl_4c_LblRecepcaos", "Label")
1099:         WITH loc_oCnt.lbl_4c_LblRecepcaos
1100:             .FontBold  = .F.
1101:             .FontName  = "Tahoma"
1102:             .FontSize  = 8
1103:             .BackStyle = 0
1104:             .Alignment = 0
1105:             .AutoSize  = .F.
1106:             .Caption   = "Recep" + CHR(231) + CHR(227) + "o "
1107:             .Left      = 3
1108:             .Top       = 3
1109:             .Width     = 80
1110:             .ForeColor = RGB(90, 90, 90)
1111:             .Visible   = .T.
1112:         ENDWITH
1113: 
1114:         loc_oCnt.AddObject("txt_4c_Recepcaos", "TextBox")
1115:         WITH loc_oCnt.txt_4c_Recepcaos
1116:             .Left          = 3
1117:             .Top           = 20
1118:             .Width         = 80
1119:             .Margin        = 0
1120:             .SpecialEffect = 1
1121:             .ForeColor     = RGB(0, 0, 0)
1122:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1133 a 1169:
1133:         THIS.AddObject("cnt_4c_PrzEnts", "Container")
1134:         loc_oCnt = THIS.cnt_4c_PrzEnts
1135:         WITH loc_oCnt
1136:             .Top         = 147
1137:             .Left        = 260
1138:             .Width       = 86
1139:             .Height      = 45
1140:             .BackStyle   = 0
1141:             .BorderWidth = 0
1142:             .Visible     = .T.
1143:         ENDWITH
1144: 
1145:         loc_oCnt.AddObject("lbl_4c_LblPrzEnts", "Label")
1146:         WITH loc_oCnt.lbl_4c_LblPrzEnts
1147:             .FontBold  = .F.
1148:             .FontName  = "Tahoma"
1149:             .FontSize  = 8
1150:             .BackStyle = 0
1151:             .Alignment = 0
1152:             .AutoSize  = .F.
1153:             .Caption   = "Dt. Prometida"
1154:             .Left      = 3
1155:             .Top       = 3
1156:             .Width     = 80
1157:             .ForeColor = RGB(90, 90, 90)
1158:             .Visible   = .T.
1159:         ENDWITH
1160: 
1161:         loc_oCnt.AddObject("txt_4c_PrzEnts", "TextBox")
1162:         WITH loc_oCnt.txt_4c_PrzEnts
1163:             .Left          = 3
1164:             .Top           = 20
1165:             .Width         = 80
1166:             .Margin        = 0
1167:             .SpecialEffect = 1
1168:             .ForeColor     = RGB(0, 0, 0)
1169:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1265 a 1320:
1265:         THIS.AddObject("cnt_4c_Volumes", "Container")
1266:         loc_oCnt = THIS.cnt_4c_Volumes
1267:         WITH loc_oCnt
1268:             .Top         = 264
1269:             .Left        = 488
1270:             .Width       = 509
1271:             .Height      = 66
1272:             .BackStyle   = 0
1273:             .BorderWidth = 0
1274:             .Visible     = .T.
1275:         ENDWITH
1276: 
1277:         loc_oCnt.AddObject("lbl_4c_Label16", "Label")
1278:         WITH loc_oCnt.lbl_4c_Label16
1279:             .FontBold  = .T.
1280:             .FontName  = "Tahoma"
1281:             .FontSize  = 8
1282:             .BackStyle = 0
1283:             .Alignment = 0
1284:             .AutoSize  = .F.
1285:             .Caption   = "Transporte"
1286:             .Left      = 3
1287:             .Top       = 3
1288:             .Width     = 100
1289:             .ForeColor = RGB(90, 90, 90)
1290:             .Visible   = .T.
1291:         ENDWITH
1292: 
1293:         loc_oCnt.AddObject("lbl_4c_LblQtds", "Label")
1294:         WITH loc_oCnt.lbl_4c_LblQtds
1295:             .FontName  = "Tahoma"
1296:             .FontSize  = 8
1297:             .BackStyle = 0
1298:             .Alignment = 0
1299:             .AutoSize  = .F.
1300:             .Caption   = "Qtde."
1301:             .Left      = 3
1302:             .Top        = 23
1303:             .Width     = 50
1304:             .ForeColor = RGB(90, 90, 90)
1305:             .Visible   = .T.
1306:         ENDWITH
1307: 
1308:         loc_oCnt.AddObject("txt_4c_Qtds", "TextBox")
1309:         WITH loc_oCnt.txt_4c_Qtds
1310:             .Alignment     = 3
1311:             .Format        = "K"
1312:             .InputMask     = "999999"
1313:             .MaxLength     = 6
1314:             .Left          = 3
1315:             .Top           = 40
1316:             .Width         = 51
1317:             .Height        = 23
1318:             .Margin        = 0
1319:             .SpecialEffect = 1
1320:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1326 a 1354:
1326:         ENDIF
1327:         BINDEVENT(loc_oCnt.txt_4c_Qtds, "When", THIS, "VolumesWhen")
1328: 
1329:         loc_oCnt.AddObject("lbl_4c_LblEspes", "Label")
1330:         WITH loc_oCnt.lbl_4c_LblEspes
1331:             .FontName  = "Tahoma"
1332:             .FontSize  = 8
1333:             .BackStyle = 0
1334:             .Alignment = 0
1335:             .AutoSize  = .F.
1336:             .Caption   = "Esp" + CHR(233) + "cie"
1337:             .Left      = 57
1338:             .Top       = 23
1339:             .Width     = 85
1340:             .ForeColor = RGB(90, 90, 90)
1341:             .Visible   = .T.
1342:         ENDWITH
1343: 
1344:         loc_oCnt.AddObject("txt_4c_Espes", "TextBox")
1345:         WITH loc_oCnt.txt_4c_Espes
1346:             .Alignment     = 3
1347:             .MaxLength     = 10
1348:             .Left          = 57
1349:             .Top           = 40
1350:             .Width         = 87
1351:             .Height        = 23
1352:             .Margin        = 0
1353:             .SpecialEffect = 1
1354:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1360 a 1388:
1360:         ENDIF
1361:         BINDEVENT(loc_oCnt.txt_4c_Espes, "When", THIS, "VolumesWhen")
1362: 
1363:         loc_oCnt.AddObject("lbl_4c_LblPLiqs", "Label")
1364:         WITH loc_oCnt.lbl_4c_LblPLiqs
1365:             .FontName  = "Tahoma"
1366:             .FontSize  = 8
1367:             .BackStyle = 0
1368:             .Alignment = 0
1369:             .AutoSize  = .F.
1370:             .Caption   = "Peso L" + CHR(237) + "quido"
1371:             .Left      = 147
1372:             .Top       = 23
1373:             .Width     = 75
1374:             .ForeColor = RGB(90, 90, 90)
1375:             .Visible   = .T.
1376:         ENDWITH
1377: 
1378:         loc_oCnt.AddObject("txt_4c_PLiqs", "TextBox")
1379:         WITH loc_oCnt.txt_4c_PLiqs
1380:             .Alignment     = 3
1381:             .InputMask     = "99,999.99"
1382:             .Left          = 147
1383:             .Top           = 40
1384:             .Width         = 73
1385:             .Height        = 23
1386:             .Margin        = 0
1387:             .SpecialEffect = 1
1388:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1394 a 1422:
1394:         ENDIF
1395:         BINDEVENT(loc_oCnt.txt_4c_PLiqs, "When", THIS, "VolumesWhen")
1396: 
1397:         loc_oCnt.AddObject("lbl_4c_LblPBrus", "Label")
1398:         WITH loc_oCnt.lbl_4c_LblPBrus
1399:             .FontName  = "Tahoma"
1400:             .FontSize  = 8
1401:             .BackStyle = 0
1402:             .Alignment = 0
1403:             .AutoSize  = .F.
1404:             .Caption   = "Peso Bruto"
1405:             .Left      = 223
1406:             .Top       = 23
1407:             .Width     = 75
1408:             .ForeColor = RGB(90, 90, 90)
1409:             .Visible   = .T.
1410:         ENDWITH
1411: 
1412:         loc_oCnt.AddObject("txt_4c_PBrus", "TextBox")
1413:         WITH loc_oCnt.txt_4c_PBrus
1414:             .Alignment     = 3
1415:             .InputMask     = "99,999.99"
1416:             .Left          = 223
1417:             .Top           = 40
1418:             .Width         = 73
1419:             .Height        = 23
1420:             .Margin        = 0
1421:             .SpecialEffect = 1
1422:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1428 a 1456:
1428:         ENDIF
1429:         BINDEVENT(loc_oCnt.txt_4c_PBrus, "When", THIS, "VolumesWhen")
1430: 
1431:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1432:         WITH loc_oCnt.lbl_4c_Label1
1433:             .FontName  = "Tahoma"
1434:             .FontSize  = 8
1435:             .BackStyle = 0
1436:             .Alignment = 0
1437:             .AutoSize  = .F.
1438:             .Caption   = "Valor Transporte"
1439:             .Left      = 299
1440:             .Top       = 23
1441:             .Width     = 100
1442:             .ForeColor = RGB(90, 90, 90)
1443:             .Visible   = .T.
1444:         ENDWITH
1445: 
1446:         loc_oCnt.AddObject("txt_4c_ValTrans", "TextBox")
1447:         WITH loc_oCnt.txt_4c_ValTrans
1448:             .Alignment     = 3
1449:             .InputMask     = "999,999.99"
1450:             .Left          = 299
1451:             .Top           = 40
1452:             .Width         = 90
1453:             .Height        = 23
1454:             .Margin        = 0
1455:             .SpecialEffect = 1
1456:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1488 a 1526:
1488:         THIS.AddObject("cnt_4c_Observacao", "Container")
1489:         loc_oCnt = THIS.cnt_4c_Observacao
1490:         WITH loc_oCnt
1491:             .Top         = 228
1492:             .Left        = 12
1493:             .Width       = 528
1494:             .Height      = 303
1495:             .BackStyle   = 0
1496:             .BorderWidth = 0
1497:             .Visible     = .T.
1498:         ENDWITH
1499: 
1500:         loc_oCnt.AddObject("lbl_4c_LblObservas", "Label")
1501:         WITH loc_oCnt.lbl_4c_LblObservas
1502:             .FontBold  = .T.
1503:             .FontName  = "Tahoma"
1504:             .FontSize  = 8
1505:             .BackStyle = 0
1506:             .Alignment = 0
1507:             .AutoSize  = .F.
1508:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
1509:             .Left      = 3
1510:             .Top       = 23
1511:             .Width     = 85
1512:             .ForeColor = RGB(90, 90, 90)
1513:             .Visible   = .T.
1514:         ENDWITH
1515: 
1516:         loc_oCnt.AddObject("txt_4c_CodObs", "TextBox")
1517:         WITH loc_oCnt.txt_4c_CodObs
1518:             .Alignment     = 3
1519:             .InputMask     = "999"
1520:             .Left          = 92
1521:             .Top           = 19
1522:             .Width         = 32
1523:             .Height        = 23
1524:             .Margin        = 0
1525:             .Value         = 0
1526:             .SpecialEffect = 1

*-- Linhas 1538 a 1583:
1538:         loc_oCnt.AddObject("obj_4c_GetDesObs", "EditBox")
1539:         WITH loc_oCnt.obj_4c_GetDesObs
1540:             .FontSize      = 8
1541:             .Left          = 3
1542:             .Top           = 46
1543:             .Width         = 453
1544:             .Height        = 254
1545:             .SpecialEffect = 1
1546:             .ForeColor     = RGB(0, 0, 0)
1547:             .BorderColor   = RGB(100, 100, 100)
1548:             .Visible       = .T.
1549:         ENDWITH
1550:         IF loc_lTemCursorPai
1551:             loc_oCnt.obj_4c_GetDesObs.ControlSource = "TprMvCab.obses"
1552:         ENDIF
1553:         BINDEVENT(loc_oCnt.obj_4c_GetDesObs, "When", THIS, "DesObsWhen")
1554: 
1555:         loc_oCnt.AddObject("cmd_4c_BtnMultObs", "CommandButton")
1556:         WITH loc_oCnt.cmd_4c_BtnMultObs
1557:             .Top          = 5
1558:             .Left         = 135
1559:             .Width        = 24
1560:             .Height       = 24
1561:             .Caption      = ""
1562:             .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1563:             .ToolTipText  = "Selecionar M" + CHR(250) + "ltiplas Observa" + CHR(231) + CHR(245) + "es"
1564:             .Themes       = .T.
1565:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1566:             .Visible      = .T.
1567:         ENDWITH
1568:         BINDEVENT(loc_oCnt.cmd_4c_BtnMultObs, "Click", THIS, "BtnMultObsObservacaoClick")
1569:     ENDPROC
1570: 
1571:     *==========================================================================
1572:     * CodObsGotFocus - "This.Tag = Str(This.Value, 10)" do legado (getCodObs.
1573:     * GotFocus): guarda o valor de entrada no Tag para o LostFocus saber se
1574:     * o usuario realmente alterou o codigo (evita reabrir o lookup so por
1575:     * entrar/sair do campo sem digitar nada).
1576:     *
1577:     * PUBLIC: alvo de BINDEVENT("GotFocus").
1578:     *==========================================================================
1579:     PROCEDURE CodObsGotFocus()
1580:         LOCAL loc_oTxt
1581:         loc_oTxt = THIS.cnt_4c_Observacao.txt_4c_CodObs
1582:         loc_oTxt.Tag = STR(loc_oTxt.Value, 10)
1583:     ENDPROC

*-- Linhas 1815 a 1854:
1815:         THIS.AddObject("cnt_4c_Protocolo", "Container")
1816:         loc_oCnt = THIS.cnt_4c_Protocolo
1817:         WITH loc_oCnt
1818:             .Top         = 96
1819:             .Left        = 461
1820:             .Width       = 61
1821:             .Height      = 45
1822:             .BackStyle   = 0
1823:             .BorderWidth = 0
1824:             .Visible     = .T.
1825:         ENDWITH
1826: 
1827:         loc_oCnt.AddObject("lbl_4c_LblProtocolos", "Label")
1828:         WITH loc_oCnt.lbl_4c_LblProtocolos
1829:             .FontName  = "Tahoma"
1830:             .FontSize  = 8
1831:             .BackStyle = 0
1832:             .Alignment = 0
1833:             .AutoSize  = .F.
1834:             .Caption   = "Protocolo"
1835:             .Left      = 3
1836:             .Top       = 3
1837:             .Width     = 55
1838:             .ForeColor = RGB(90, 90, 90)
1839:             .Visible   = .T.
1840:         ENDWITH
1841: 
1842:         loc_oCnt.AddObject("txt_4c_Protocolos", "TextBox")
1843:         WITH loc_oCnt.txt_4c_Protocolos
1844:             .Alignment     = 3
1845:             .Format        = "K"
1846:             .InputMask     = "999999"
1847:             .MaxLength     = 6
1848:             .Left          = 3
1849:             .Top           = 20
1850:             .Width         = 55
1851:             .Height        = 23
1852:             .Margin        = 0
1853:             .SpecialEffect = 1
1854:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1874 a 1958:
1874:         THIS.AddObject("cnt_4c_Entrega", "Container")
1875:         loc_oCnt = THIS.cnt_4c_Entrega
1876:         WITH loc_oCnt
1877:             .Top         = 192
1878:             .Left        = 489
1879:             .Width       = 504
1880:             .Height      = 66
1881:             .BackStyle   = 0
1882:             .BorderWidth = 0
1883:             .Visible     = .T.
1884:         ENDWITH
1885: 
1886:         loc_oCnt.AddObject("lbl_4c_LblEntregas", "Label")
1887:         WITH loc_oCnt.lbl_4c_LblEntregas
1888:             .FontBold  = .T.
1889:             .FontName  = "Tahoma"
1890:             .FontSize  = 8
1891:             .BackStyle = 0
1892:             .Alignment = 0
1893:             .AutoSize  = .F.
1894:             .Caption   = "Entrega"
1895:             .Left      = 3
1896:             .Top       = 3
1897:             .Width     = 85
1898:             .ForeColor = RGB(90, 90, 90)
1899:             .Visible   = .T.
1900:         ENDWITH
1901: 
1902:         loc_oCnt.AddObject("lbl_4c_LblContas", "Label")
1903:         WITH loc_oCnt.lbl_4c_LblContas
1904:             .FontName  = "Tahoma"
1905:             .FontSize  = 8
1906:             .BackStyle = 0
1907:             .Alignment = 0
1908:             .AutoSize  = .F.
1909:             .Caption   = "Conta"
1910:             .Left      = 3
1911:             .Top       = 23
1912:             .Width     = 70
1913:             .ForeColor = RGB(90, 90, 90)
1914:             .Visible   = .T.
1915:         ENDWITH
1916: 
1917:         loc_oCnt.AddObject("lbl_4c_LblCpfs", "Label")
1918:         WITH loc_oCnt.lbl_4c_LblCpfs
1919:             .FontName  = "Tahoma"
1920:             .FontSize  = 8
1921:             .BackStyle = 0
1922:             .Alignment = 0
1923:             .AutoSize  = .F.
1924:             .Caption   = "CPF / CNPJ"
1925:             .Left      = 77
1926:             .Top       = 23
1927:             .Width     = 56
1928:             .Height    = 15
1929:             .ForeColor = RGB(90, 90, 90)
1930:             .Visible   = .T.
1931:         ENDWITH
1932: 
1933:         loc_oCnt.AddObject("lbl_4c_LblDConta", "Label")
1934:         WITH loc_oCnt.lbl_4c_LblDConta
1935:             .FontName  = "Tahoma"
1936:             .FontSize  = 8
1937:             .BackStyle = 0
1938:             .Alignment = 0
1939:             .AutoSize  = .F.
1940:             .Caption   = "Nome"
1941:             .Left      = 210
1942:             .Top       = 23
1943:             .Width     = 29
1944:             .Height    = 15
1945:             .ForeColor = RGB(90, 90, 90)
1946:             .Visible   = .T.
1947:         ENDWITH
1948: 
1949:         loc_oCnt.AddObject("txt_4c_Contas", "TextBox")
1950:         WITH loc_oCnt.txt_4c_Contas
1951:             .MaxLength     = 10
1952:             .Left          = 3
1953:             .Top           = 40
1954:             .Width         = 72
1955:             .Height        = 23
1956:             .Margin        = 0
1957:             .SpecialEffect = 1
1958:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1967 a 1976:
1967: 
1968:         loc_oCnt.AddObject("txt_4c_Cpfs", "TextBox")
1969:         WITH loc_oCnt.txt_4c_Cpfs
1970:             .Left          = 77
1971:             .Top           = 40
1972:             .Width         = 131
1973:             .Height        = 23
1974:             .Margin        = 0
1975:             .SpecialEffect = 1
1976:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1982 a 2026:
1982: 
1983:         loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
1984:         WITH loc_oCnt.txt_4c_DConta
1985:             .Left          = 210
1986:             .Top           = 40
1987:             .Width         = 285
1988:             .Height        = 23
1989:             .Margin        = 0
1990:             .SpecialEffect = 1
1991:             .ForeColor     = RGB(0, 0, 0)
1992:             .BorderColor   = RGB(100, 100, 100)
1993:             .Visible       = .T.
1994:         ENDWITH
1995:         BINDEVENT(loc_oCnt.txt_4c_DConta, "LostFocus", THIS, "DContaLostFocus")
1996:         BINDEVENT(loc_oCnt.txt_4c_DConta, "When",      THIS, "EntregaCamposLiberadosWhen")
1997: 
1998:         loc_oCnt.AddObject("cmd_4c_CmdEntrega", "CommandButton")
1999:         WITH loc_oCnt.cmd_4c_CmdEntrega
2000:             .Top             = 0
2001:             .Left            = 455
2002:             .Width           = 24
2003:             .Height          = 24
2004:             .Caption         = ""
2005:             .Picture         = gc_4c_CaminhoIcones + "geral_relogio_26.jpg"
2006:             .ToolTipText     = "Local de Entrega"
2007:             .Themes          = .T.
2008:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_relogio_26.jpg"
2009:             .Visible         = .T.
2010:         ENDWITH
2011:         BINDEVENT(loc_oCnt.cmd_4c_CmdEntrega, "Click", THIS, "EntregaLocalClick")
2012:     ENDPROC
2013: 
2014:     *==========================================================================
2015:     * ContasLostFocus/DContaLostFocus/CpfsLostFocus - equivalentes ao Valid/
2016:     * LostFocus legado de getContas/getDConta/getCpfs (regra #47). Os tres
2017:     * campos sao intercambiaveis: preencher QUALQUER um localiza a conta em
2018:     * SigCdCli e preenche os outros dois.
2019:     *
2020:     * fAcessoContas(..., pSt1=.NULL., pSt2=.NULL.) - modo BACKEND (regra do
2021:     * projeto: AcessoContas() NUNCA em modo lookup-UI, que auto-popula com o
2022:     * PRIMEIRO registro que contem o valor digitado - aqui ele so confere
2023:     * ACESSO, sem objeto de TextBox nenhum).
2024:     *
2025:     * Guard this_cUltimo<X>LostFocusValidado: LostFocus dispara mesmo sem o
2026:     * usuario mudar o valor (diferente do Valid legado, que so dispara na

*-- Linhas 2369 a 2408:
2369:         THIS.AddObject("cnt_4c_Pedido", "Container")
2370:         loc_oCnt = THIS.cnt_4c_Pedido
2371:         WITH loc_oCnt
2372:             .Top         = 96
2373:             .Left        = 522
2374:             .Width       = 61
2375:             .Height      = 45
2376:             .BackStyle   = 0
2377:             .BorderWidth = 0
2378:             .Visible     = .T.
2379:         ENDWITH
2380: 
2381:         loc_oCnt.AddObject("lbl_4c_LblPedido", "Label")
2382:         WITH loc_oCnt.lbl_4c_LblPedido
2383:             .FontName  = "Tahoma"
2384:             .FontSize  = 8
2385:             .BackStyle = 0
2386:             .Alignment = 0
2387:             .AutoSize  = .F.
2388:             .Caption   = "Pedido"
2389:             .Left      = 3
2390:             .Top       = 3
2391:             .Width     = 55
2392:             .ForeColor = RGB(90, 90, 90)
2393:             .Visible   = .T.
2394:         ENDWITH
2395: 
2396:         loc_oCnt.AddObject("txt_4c_Pedido", "TextBox")
2397:         WITH loc_oCnt.txt_4c_Pedido
2398:             .Alignment     = 3
2399:             .Format        = "K"
2400:             .InputMask     = "999999"
2401:             .MaxLength     = 6
2402:             .Left          = 3
2403:             .Top           = 20
2404:             .Width         = 55
2405:             .Height        = 23
2406:             .Margin        = 0
2407:             .SpecialEffect = 1
2408:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 2445 a 2500:
2445:         THIS.AddObject("cnt_4c_Obs2", "Container")
2446:         loc_oCnt = THIS.cnt_4c_Obs2
2447:         WITH loc_oCnt
2448:             .Top         = 96
2449:             .Left        = 582
2450:             .Width       = 66
2451:             .Height      = 64
2452:             .BackStyle   = 0
2453:             .BorderWidth = 0
2454:             .Visible     = .T.
2455:         ENDWITH
2456: 
2457:         loc_oCnt.AddObject("lbl_4c_LblPedido", "Label")
2458:         WITH loc_oCnt.lbl_4c_LblPedido
2459:             .FontName  = "Tahoma"
2460:             .FontSize  = 8
2461:             .BackStyle = 0
2462:             .Alignment = 0
2463:             .AutoSize  = .F.
2464:             .Caption   = "Finalidade"
2465:             .Left      = 3
2466:             .Top       = 3
2467:             .Width     = 60
2468:             .ForeColor = RGB(90, 90, 90)
2469:             .Visible   = .T.
2470:         ENDWITH
2471: 
2472:         loc_oCnt.AddObject("cmd_4c_BtnMultObs", "CommandButton")
2473:         WITH loc_oCnt.cmd_4c_BtnMultObs
2474:             .Top             = 20
2475:             .Left            = 3
2476:             .Width           = 24
2477:             .Height          = 24
2478:             .Caption         = ""
2479:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
2480:             .ToolTipText     = "Selecionar Finalidade da opera" + CHR(231) + CHR(227) + "o para ser usada no relat" + CHR(243) + "rio de opera" + CHR(231) + CHR(245) + "es."
2481:             .Themes          = .T.
2482:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
2483:             .Visible         = .T.
2484:         ENDWITH
2485:         BINDEVENT(loc_oCnt.cmd_4c_BtnMultObs, "Click", THIS, "BtnMultObsFinalidadeClick")
2486:     ENDPROC
2487: 
2488:     *==========================================================================
2489:     * BtnMultObsFinalidadeClick - CntObs2.btnMultObs.Valid legado:
2490:     *   Do Form SigOpIns With ThisForm.ParentForm.poDataMgr, TprMvCab.CodObs2
2491:     *   replace CodObs2 with ALLTRIM(listaObs) in TprMvCab
2492:     * SigOpIns nao veio no acervo - sem a tela (e sem a lista que ela
2493:     * devolveria em listaObs), nao ha resultado para gravar em CodObs2.
2494:     *
2495:     * PUBLIC: alvo de BINDEVENT("Click").
2496:     *==========================================================================
2497:     PROCEDURE BtnMultObsFinalidadeClick()
2498:         THIS.AvisarLegadoNaoPortado("Tela de Sele" + CHR(231) + CHR(227) + "o de Finalidade (SigOpIns)", ;
2499:             "selecionar a finalidade da opera" + CHR(231) + CHR(227) + "o")
2500:     ENDPROC

*-- Linhas 2509 a 2548:
2509:         THIS.AddObject("cnt_4c_Livre", "Container")
2510:         loc_oCnt = THIS.cnt_4c_Livre
2511:         WITH loc_oCnt
2512:             .Top         = 189
2513:             .Left        = 2
2514:             .Width       = 352
2515:             .Height      = 45
2516:             .BackStyle   = 0
2517:             .BorderWidth = 0
2518:             .Visible     = .T.
2519:         ENDWITH
2520: 
2521:         loc_oCnt.AddObject("lbl_4c_LblNLivDg", "Label")
2522:         WITH loc_oCnt.lbl_4c_LblNLivDg
2523:             .FontName  = "Tahoma"
2524:             .FontSize  = 8
2525:             .BackStyle = 0
2526:             .Alignment = 0
2527:             .AutoSize  = .F.
2528:             .Caption   = "Lacre"
2529:             .Left      = 3
2530:             .Top       = 3
2531:             .Width     = 60
2532:             .Height    = 15
2533:             .ForeColor = RGB(90, 90, 90)
2534:             .Visible   = .T.
2535:         ENDWITH
2536: 
2537:         loc_oCnt.AddObject("txt_4c_NLivDg", "TextBox")
2538:         WITH loc_oCnt.txt_4c_NLivDg
2539:             .Alignment     = 3
2540:             .MaxLength     = 15
2541:             .Value         = 0
2542:             .Left          = 3
2543:             .Top           = 20
2544:             .Width         = 169
2545:             .Height        = 23
2546:             .Margin        = 0
2547:             .SpecialEffect = 1
2548:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 2840 a 2848:
2840:         *-- dialogo. Falso seguro parcial: ao menos confirma/preenche
2841:         *-- Nome e CPF/CNPJ a partir do codigo JA presente em
2842:         *-- TprMvCab.ContaEs, igual ao "lcCliente = TprMvCab.ContaEs /
2843:         *-- CursorQuery(...) / getDConta.Value = ... / getCpfs.Value = ..."
2844:         *-- que fecha esse trecho do Init legado.
2845:         IF !EMPTY(TprMvCab.ContaEs)
2846:             THIS.BuscarContaEntrega("IClis", ALLTRIM(TprMvCab.ContaEs))
2847:         ENDIF
2848: 

*-- Linhas 2855 a 2876:
2855: 
2856:         *** Digita Data de Entrega
2857:         THIS.cnt_4c_Entregas.Visible = INLIST(crSigCdOpe.DtEntrs, 1, 4, 6)
2858:         THIS.cnt_4c_Entregas.lbl_4c_LblEntregas.Caption = "Prz. Entrega "
2859:         IF USED("CrSigOpCdc") ;
2860:            AND (CrSigOpCdc.DckPrze = 1 OR CrSigOpCdc.ChkPrzEnts = 1) ;
2861:            AND !EMPTY(CrSigOpCdc.DocPrzE)
2862:             THIS.cnt_4c_Entregas.lbl_4c_LblEntregas.Caption = ALLTRIM(PROPER(CrSigOpCdc.DocPrzE))
2863:         ENDIF
2864: 
2865:         *** Digita Data de Recepcao
2866:         THIS.cnt_4c_Recepcaos.Visible = (crSigCdOpe.DigRecs = 1)
2867: 
2868:         *** Digita Data Prometida
2869:         IF USED("CrSigOpCdd")
2870:             THIS.cnt_4c_PrzEnts.Visible = (CrSigOpCdd.PrzLjs = 1)
2871:             THIS.cnt_4c_PrzEnts.lbl_4c_LblPrzEnts.Caption = ;
2872:                 IIF(!EMPTY(CrSigOpCdd.DocPrzLjs), CrSigOpCdd.DocPrzLjs, "Dt. Prometida")
2873:         ENDIF
2874: 
2875:         THIS.CarregarPrazoEntregaPadrao()
2876: 

*-- Linhas 2903 a 3022:
2903:         loc_nTop = loc_nTp0
2904: 
2905:         IF THIS.cnt_4c_Ecfs.Visible
2906:             THIS.cnt_4c_Ecfs.Left = loc_nLft
2907:             THIS.cnt_4c_Ecfs.Top  = loc_nTop
2908:             loc_nLft = loc_nLft + THIS.cnt_4c_Ecfs.Width
2909:         ENDIF
2910: 
2911:         IF THIS.cnt_4c_Nemps.Visible
2912:             THIS.cnt_4c_Nemps.Left = loc_nLft
2913:             THIS.cnt_4c_Nemps.Top  = loc_nTop
2914:             loc_nLft = loc_nLft + THIS.cnt_4c_Nemps.Width
2915:         ENDIF
2916: 
2917:         IF THIS.cnt_4c_Protocolo.Visible
2918:             THIS.cnt_4c_Protocolo.Left = loc_nLft
2919:             THIS.cnt_4c_Protocolo.Top  = loc_nTop
2920:             loc_nLft = loc_nLft + THIS.cnt_4c_Protocolo.Width
2921:         ENDIF
2922: 
2923:         IF THIS.cnt_4c_Pedido.Visible
2924:             THIS.cnt_4c_Pedido.Left = loc_nLft
2925:             THIS.cnt_4c_Pedido.Top  = loc_nTop
2926:             loc_nLft = loc_nLft + THIS.cnt_4c_Pedido.Width
2927:         ENDIF
2928: 
2929:         loc_nLft = loc_nLf0
2930:         loc_nTop = loc_nTp0 + THIS.cnt_4c_Codigos.Height + 1
2931: 
2932:         *-- Ajustando Segunda Linha de Campos
2933:         IF THIS.cnt_4c_Emiss.Visible
2934:             THIS.cnt_4c_Emiss.Left = loc_nLft
2935:             THIS.cnt_4c_Emiss.Top  = loc_nTop
2936:             loc_nLft = loc_nLft + THIS.cnt_4c_Emiss.Width
2937:         ENDIF
2938: 
2939:         IF THIS.cnt_4c_Entregas.Visible
2940:             THIS.cnt_4c_Entregas.Left = loc_nLft
2941:             THIS.cnt_4c_Entregas.Top  = loc_nTop
2942:             loc_nLft = loc_nLft + THIS.cnt_4c_Entregas.Width
2943:         ENDIF
2944: 
2945:         IF THIS.cnt_4c_Recepcaos.Visible
2946:             THIS.cnt_4c_Recepcaos.Left = loc_nLft
2947:             THIS.cnt_4c_Recepcaos.Top  = loc_nTop
2948:             loc_nLft = loc_nLft + THIS.cnt_4c_Recepcaos.Width
2949:         ENDIF
2950: 
2951:         IF THIS.cnt_4c_PrzEnts.Visible
2952:             THIS.cnt_4c_PrzEnts.Left = loc_nLft
2953:             THIS.cnt_4c_PrzEnts.Top  = loc_nTop
2954:             loc_nLft = loc_nLft + THIS.cnt_4c_PrzEnts.Width
2955:         ENDIF
2956: 
2957:         IF THIS.cnt_4c_Livre.Visible
2958:             THIS.cnt_4c_Livre.Left = loc_nLft
2959:             THIS.cnt_4c_Livre.Top  = loc_nTop
2960:             loc_nLft = loc_nLft + THIS.cnt_4c_Livre.Width
2961:         ENDIF
2962: 
2963:         loc_nLft = loc_nLf0
2964:         IF THIS.cnt_4c_Emiss.Visible OR THIS.cnt_4c_Entregas.Visible ;
2965:            OR THIS.cnt_4c_Recepcaos.Visible OR THIS.cnt_4c_PrzEnts.Visible ;
2966:            OR THIS.cnt_4c_Livre.Visible
2967:             loc_nTop = loc_nTop + THIS.cnt_4c_Codigos.Height + 1
2968:         ENDIF
2969: 
2970:         *-- Ajustando Conteiner da Observacao
2971:         IF THIS.cnt_4c_Observacao.Visible
2972:             THIS.cnt_4c_Observacao.Left = loc_nLft
2973:             THIS.cnt_4c_Observacao.Top  = loc_nTop
2974:             loc_nTop = loc_nTop + THIS.cnt_4c_Observacao.Height + 1
2975:         ENDIF
2976: 
2977:         *-- Ajustando Conteiner da Entrega
2978:         IF THIS.cnt_4c_Entrega.Visible
2979:             THIS.cnt_4c_Entrega.Left = loc_nLft
2980:             THIS.cnt_4c_Entrega.Top  = loc_nTop
2981:             loc_nTop = loc_nTop + THIS.cnt_4c_Entrega.Height + 1
2982:         ENDIF
2983: 
2984:         *-- Ajustando Conteiner de Volumes
2985:         IF THIS.cnt_4c_Volumes.Visible
2986:             THIS.cnt_4c_Volumes.Left = loc_nLft
2987:             THIS.cnt_4c_Volumes.Top  = loc_nTop
2988:         ENDIF
2989:     ENDPROC
2990: 
2991:     *==========================================================================
2992:     * KeyPress - "Lparameters nKeyCode, nShiftAltCtrl / If ThisForm.cntEntrega.
2993:     * cmdEntrega.Visible And (nKeyCode = -1) -> SetFocus + Keyboard '{ENTER}'
2994:     * NoDefault / If ThisForm.cmdEntrega.Visible And (nKeyCode = -2) ->
2995:     * SetFocus + Keyboard '{ENTER}' NoDefault" do legado - F2 aciona o botao
2996:     * "Local de Entrega" (cnt_4c_Entrega.cmd_4c_CmdEntrega) e F3 aciona o
2997:     * botao "Entrega" (obj_4c_CmdEntrega, Prazo de Entrega, Fase 4). Em vez
2998:     * de SetFocus + Keyboard '{ENTER}' (fragil em execucao headless/teste),
2999:     * chama o Click do botao direto - mesmo efeito observavel.
3000:     *
3001:     * KeyPreview = .T. (propriedade do Form, ver cabecalho da classe) faz o
3002:     * Form receber o KeyPress ANTES dos controles - exigido para capturar
3003:     * F2/F3 em qualquer campo focado, como no legado.
3004:     *==========================================================================
3005:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
3006:         IF PEMSTATUS(THIS, "cnt_4c_Entrega", 5) AND VARTYPE(THIS.cnt_4c_Entrega) = "O"
3007:             IF THIS.cnt_4c_Entrega.cmd_4c_CmdEntrega.Visible AND par_nKeyCode = -1
3008:                 THIS.EntregaLocalClick()
3009:                 NODEFAULT
3010:                 RETURN
3011:             ENDIF
3012:         ENDIF
3013: 
3014:         IF PEMSTATUS(THIS, "obj_4c_CmdEntrega", 5) AND VARTYPE(THIS.obj_4c_CmdEntrega) = "O"
3015:             IF THIS.obj_4c_CmdEntrega.Visible AND par_nKeyCode = -2
3016:                 THIS.CmdEntregaClick()
3017:                 NODEFAULT
3018:             ENDIF
3019:         ENDIF
3020:     ENDPROC
3021: 
3022:     *==========================================================================


### BO (C:\4c\projeto\app\classes\sigopinfBO.prg):
*====================================================================
* sigopinfBO.prg
*
* Business Object para o dialogo "Informacoes Gerais" (SIGOPINF)
* Entidade base: SigMvCab (cabecalho do movimento/operacao)
* Herda de: BusinessBase
*
* NOTA: SIGOPINF e um dialogo FILHO, aberto pelo form de cabecalho da
* operacao (ParentForm) e que edita um SUBCONJUNTO de colunas do cursor
* TprMvCab (cursor de trabalho do pai, equivalente a SigMvCab). Este BO
* nao persiste diretamente em SigMvCab - quem grava o cabecalho e o
* form pai, quando a operacao principal e salva (os controles desta
* tela ja escrevem direto em TprMvCab via ControlSource).
*
* O UNICO caminho de gravacao direta no legado (SIGOPINF.cntBotoes.Click,
* ramo Else) acontece em modo CONSULTAR, quando o usuario tem acesso
* ALTINFO liberado: um UPDATE pontual da coluna Obses, pela chave
* CidChaves. E esse caminho que Atualizar() reproduz aqui.
*
* Nomes de coluna confirmados em docs/schema.sql (UTF-16) e no dump
* SIGOPINF.ControlSource (tasks/task751/sigopinf_form_codigo_fonte.txt):
*   cntVolumes.getQtds      -> Qtdes       (numeric)
*   cntVolumes.getEspes     -> Espes       (char)
*   cntVolumes.getPLiqs     -> PLiqs       (numeric)
*   cntVolumes.getPBrus     -> PBrus       (numeric)
*   cntVolumes.getValTrans  -> ValTrans    (numeric)
*   cntObservacao.getCodObs -> CodObs      (numeric)
*   cntObservacao.getDesObs -> Obses       (text/memo)
*   CntObs2.btnMultObs      -> CodObs2     (char)
*   cntProtocolo.getProtocolos -> Protats  (numeric)
*   cntEntrega.getContas    -> ContaEs     (char)
*   cntCodigos.getCodigos   -> MascNum     (char)
*   cntDocumentos.getDocumentos -> Notas   (char)
*   cntDocumentos.GetNumeroNota -> NumeroNota (char)
*   cntEcfs.getEcfs         -> Ecfs        (char)
*   cntNemps.getNemps       -> Nemps       (char)
*   cntEmiss.getEmiss       -> DtEmis      (datetime)
*   cntEntregas.getEntregas -> PrazoEnts   (datetime)
*   cntRecepcaos.getRecepcaos -> DtRecs    (datetime)
*   cntPrzEnts.getPrzEnts   -> PrzClis     (datetime)
*   cntPedido.getPedido     -> nPedClis    (numeric)
*   cntLivre.getNLivDg      -> NLivDg      (numeric)
*====================================================================

DEFINE CLASS sigopinfBO AS BusinessBase

    *-- Identificacao do movimento (TprMvCab - chave posicional)
    this_cEmps        = ""    && TprMvCab.Emps char(3) - empresa
    this_cDopes       = ""    && TprMvCab.Dopes char(20) - tipo de documento/operacao
    this_nNumes       = 0     && TprMvCab.Numes numeric - numero do documento
    this_cEmpDopNums  = ""    && TprMvCab.EmpDopNums char(29) - chave posicional (Emps + Dopes + Str(Numes,6))
    this_cCidChaves   = ""    && TprMvCab.CidChaves char - chave do registro, usada no UPDATE pontual de Obses (modo CONSULTAR + acesso ALTINFO)

    *-- Datas (containers cntEmiss/cntEntregas/cntPrzEnts/cntRecepcaos)
    this_dDatas       = {}    && TprMvCab.Datas - data do movimento (usada em validacoes de prazo; nao editavel nesta tela)
    this_dDtEmis      = {}    && TprMvCab.DtEmis - data de emissao do documento
    this_dPrazoEnts   = {}    && TprMvCab.PrazoEnts - prazo de entrega
    this_dPrzClis     = {}    && TprMvCab.PrzClis - data prometida ao cliente
    this_dRecepcaos   = {}    && TprMvCab.DtRecs - data de recepcao

    *-- Contas (container cntEntrega - conta/nome/cpf-cnpj da entrega)
    this_cContaDs     = ""    && TprMvCab.ContaDs - conta (duplicata)
    this_cContaOs     = ""    && TprMvCab.ContaOs - conta (ordem de servico)
    this_cContaEs     = ""    && TprMvCab.ContaEs - conta de entrega
    this_cDescContaEs = ""    && Nome/razao social da conta de entrega (consulta auxiliar SigCdCli - NAO persistido em TprMvCab)
    this_cCpfContaEs  = ""    && CPF/CNPJ da conta de entrega (consulta auxiliar SigCdCli - NAO persistido em TprMvCab)

    *-- Observacoes (container cntObservacao/CntObs2)
    this_nCodObs      = 0     && TprMvCab.CodObs - codigo da observacao (crSigCdObs.Codigos)
    this_cObses       = ""    && TprMvCab.Obses - texto da observacao (memo)
    this_cCodObs2     = ""    && TprMvCab.CodObs2 - codigos de observacoes de finalidade (lista concatenada)

    *-- Entrega/protocolo/documentos
    this_nLocalEnts   = 0     && TprMvCab.LocalEnts numeric - codigo do endereco alternativo de entrega (SigCdCee.Codigos)
    this_nProtocolos  = 0     && TprMvCab.Protats numeric - protocolo
    this_cCodigos     = ""    && TprMvCab.MascNum - mascara/codigo de referencia da tela (cntCodigos)
    this_cDocumentos  = ""    && TprMvCab.Notas - numero do documento
    this_cNumeroNota  = ""    && TprMvCab.NumeroNota - numero da nota fiscal
    this_cEcfs        = ""    && TprMvCab.Ecfs - identificacao do ECF
    this_cNemps       = ""    && TprMvCab.Nemps - numero de serie da impressora fiscal (criptografado)
    this_nPedido      = 0     && TprMvCab.nPedClis numeric - numero do pedido
    this_nNLivDg      = 0     && TprMvCab.NLivDg numeric - numero do lacre

    *-- Volumes/transporte (container cntVolumes)
    this_nQtds        = 0     && TprMvCab.Qtdes - quantidade de volumes
    this_cEspes       = ""    && TprMvCab.Espes - especie do volume
    this_nPLiqs       = 0     && TprMvCab.PLiqs - peso liquido
    this_nPBrus       = 0     && TprMvCab.PBrus - peso bruto
    this_nValTrans    = 0     && TprMvCab.ValTrans - valor do transporte

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "CidChaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - chave do registro corrente (TprMvCab.CidChaves)
    * Usada por RegistrarAuditoria() apos o UPDATE pontual de Obses.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades do BO a partir do cursor
    * de trabalho do form pai (TprMvCab). Cada campo e lido sob guarda de
    * TYPE() porque o alias recebido pode trazer so um subconjunto das
    * colunas (ex.: cursor de teste automatizado).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Identificacao do movimento
                IF TYPE("Emps") != "U"
                    THIS.this_cEmps = TratarNulo(Emps, "C")
                ENDIF
                IF TYPE("Dopes") != "U"
                    THIS.this_cDopes = TratarNulo(Dopes, "C")
                ENDIF
                IF TYPE("Numes") != "U"
                    THIS.this_nNumes = TratarNulo(Numes, "N")
                ENDIF
                IF TYPE("EmpDopNums") != "U"
                    THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
                ENDIF
                IF TYPE("CidChaves") != "U"
                    THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
                ENDIF

                *-- Datas
                IF TYPE("Datas") != "U"
                    THIS.this_dDatas = TratarNulo(Datas, "D")
                ENDIF
                IF TYPE("DtEmis") != "U"
                    THIS.this_dDtEmis = TratarNulo(DtEmis, "D")
                ENDIF
                IF TYPE("PrazoEnts") != "U"
                    THIS.this_dPrazoEnts = TratarNulo(PrazoEnts, "D")
                ENDIF
                IF TYPE("PrzClis") != "U"
                    THIS.this_dPrzClis = TratarNulo(PrzClis, "D")
                ENDIF
                IF TYPE("DtRecs") != "U"
                    THIS.this_dRecepcaos = TratarNulo(DtRecs, "D")
                ENDIF

                *-- Contas
                IF TYPE("ContaDs") != "U"
                    THIS.this_cContaDs = TratarNulo(ContaDs, "C")
                ENDIF
                IF TYPE("ContaOs") != "U"
                    THIS.this_cContaOs = TratarNulo(ContaOs, "C")
                ENDIF
                IF TYPE("ContaEs") != "U"
                    THIS.this_cContaEs = TratarNulo(ContaEs, "C")
                ENDIF

                *-- Observacoes
                IF TYPE("CodObs") != "U"
                    THIS.this_nCodObs = TratarNulo(CodObs, "N")
                ENDIF
                IF TYPE("Obses") != "U"
                    THIS.this_cObses = TratarNulo(Obses, "C")
                ENDIF
                IF TYPE("CodObs2") != "U"
                    THIS.this_cCodObs2 = TratarNulo(CodObs2, "C")
                ENDIF

                *-- Entrega/protocolo/documentos
                IF TYPE("LocalEnts") != "U"
                    THIS.this_nLocalEnts = TratarNulo(LocalEnts, "N")
                ENDIF
                IF TYPE("Protats") != "U"
                    THIS.this_nProtocolos = TratarNulo(Protats, "N")
                ENDIF
                IF TYPE("MascNum") != "U"
                    THIS.this_cCodigos = TratarNulo(MascNum, "C")
                ENDIF
                IF TYPE("Notas") != "U"
                    THIS.this_cDocumentos = TratarNulo(Notas, "C")
                ENDIF
                IF TYPE("NumeroNota") != "U"
                    THIS.this_cNumeroNota = TratarNulo(NumeroNota, "C")
                ENDIF
                IF TYPE("Ecfs") != "U"
                    THIS.this_cEcfs = TratarNulo(Ecfs, "C")
                ENDIF
                IF TYPE("Nemps") != "U"
                    THIS.this_cNemps = TratarNulo(Nemps, "C")
                ENDIF
                IF TYPE("nPedClis") != "U"
                    THIS.this_nPedido = TratarNulo(nPedClis, "N")
                ENDIF
                IF TYPE("NLivDg") != "U"
                    THIS.this_nNLivDg = TratarNulo(NLivDg, "N")
                ENDIF

                *-- Volumes/transporte
                IF TYPE("Qtdes") != "U"
                    THIS.this_nQtds = TratarNulo(Qtdes, "N")
                ENDIF
                IF TYPE("Espes") != "U"
                    THIS.this_cEspes = TratarNulo(Espes, "C")
                ENDIF
                IF TYPE("PLiqs") != "U"
                    THIS.this_nPLiqs = TratarNulo(PLiqs, "N")
                ENDIF
                IF TYPE("PBrus") != "U"
                    THIS.this_nPBrus = TratarNulo(PBrus, "N")
                ENDIF
                IF TYPE("ValTrans") != "U"
                    THIS.this_nValTrans = TratarNulo(ValTrans, "N")
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Inserir - Nao aplicavel a este dialogo. O cabecalho do movimento
    * (SigMvCab) e criado pelo form PAI (operacao principal) quando a
    * operacao e salva; SIGOPINF so edita colunas do cursor TprMvCab
    * (ja atualizado em memoria pelos proprios controles via
    * ControlSource) e devolve o controle com ThisForm.Return.
    *====================================================================
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *====================================================================
    * Atualizar - Reproduz o UNICO caminho de gravacao direta do legado
    * (SIGOPINF.cntBotoes.Click, ramo Else): em modo CONSULTAR, com
    * acesso ALTINFO liberado, confirma apenas a observacao (Obses) do
    * cabecalho, pela chave CidChaves. O Form e quem decide, antes de
    * chamar Salvar()/Atualizar(), se o acesso ALTINFO permite a acao -
    * este metodo so executa a gravacao em si.
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cMensagemErro = "Chave do registro n" + CHR(227) + "o informada."
            ELSE
                loc_cSQL = "UPDATE SigMvCab SET " + ;
                           "Obses = " + EscaparSQL(ALLTRIM(THIS.this_cObses)) + " " + ;
                           "WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Erro ao atualizar a observa" + CHR(231) + CHR(227) + "o do movimento."
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                ELSE
                    THIS.RegistrarAuditoria("A")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

