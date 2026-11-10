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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopinf.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3554 linhas total):

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

*-- Linhas 428 a 437:
428:     * titulo do form desenhado duas vezes: lblSombra em preto atras e
429:     * lblTitulo em branco por cima, 1px acima, o que produz o relevo -
430:     * exatamente como o Init legado faz nas duas primeiras linhas:
431:     *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
432:     *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
433:     *
434:     * Geometria transcrita do dump (layout.json), com UMA correcao
435:     * deliberada de Width: o SCX declara cntSombra.Width = 1100 e os dois
436:     * labels com Width = 769, enquanto o proprio Form tem Width = 1000 - o
437:     * container do cabecalho foi desenhado no Form Designer mais largo que a

*-- Linhas 453 a 499:
453:         THIS.AddObject("cnt_4c_Sombra", "Container")
454:         loc_oCnt = THIS.cnt_4c_Sombra
455:         WITH loc_oCnt
456:             .Top         = 0
457:             .Left        = 0
458:             .Width       = THIS.Width
459:             .Height      = 80
460:             .BorderWidth = 0
461:             .BackColor   = RGB(100, 100, 100)
462:             .Visible     = .T.
463:         ENDWITH
464: 
465:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
466:         WITH loc_oCnt.lbl_4c_LblSombra
467:             .FontBold  = .T.
468:             .FontName  = "Tahoma"
469:             .FontSize  = 18
470:             .WordWrap  = .T.
471:             .Alignment = 0
472:             .BackStyle = 0
473:             .AutoSize  = .F.
474:             .Caption   = THIS.Caption
475:             .Left      = 10
476:             .Top       = 18
477:             .Width     = THIS.Width - 20
478:             .Height    = 40
479:             .ForeColor = RGB(0, 0, 0)
480:             .Visible   = .T.
481:         ENDWITH
482: 
483:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
484:         WITH loc_oCnt.lbl_4c_LblTitulo
485:             .FontBold  = .T.
486:             .FontName  = "Tahoma"
487:             .FontSize  = 18
488:             .WordWrap  = .T.
489:             .Alignment = 0
490:             .BackStyle = 0
491:             .AutoSize  = .F.
492:             .Caption   = THIS.Caption
493:             .Left      = 10
494:             .Top        = 17
495:             .Width     = THIS.Width - 20
496:             .Height    = 46
497:             .ForeColor = RGB(255, 255, 255)
498:             .Visible   = .T.
499:         ENDWITH

*-- Linhas 526 a 556:
526:         THIS.AddObject("obj_4c_CntBotoes", "CommandGroup")
527:         loc_oGrp = THIS.obj_4c_CntBotoes
528:         WITH loc_oGrp
529:             .Top           = -2
530:             .Left          = 920
531:             .Width         = 85
532:             .Height        = 85
533:             .ButtonCount   = 1
534:             .BackStyle     = 0
535:             .BorderStyle   = 0
536:             .SpecialEffect = 1
537:             .Visible       = .T.
538:         ENDWITH
539:         WITH loc_oGrp.Buttons(1)
540:             .Top             = 5
541:             .Left            = 5
542:             .Width           = 75
543:             .Height          = 75
544:             .FontBold        = .T.
545:             .FontItalic      = .T.
546:             .FontName        = "Tahoma"
547:             .FontSize        = 8
548:             .WordWrap        = .T.
549:             .PicturePosition = 13
550:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
551:             .Caption         = "\<Salvar"
552:             .MousePointer    = 15
553:             .ToolTipText     = "Gravar os Dados Informados"
554:             .SpecialEffect   = 0
555:             .ForeColor       = RGB(90, 90, 90)
556:             .BackColor       = RGB(255, 255, 255)

*-- Linhas 562 a 592:
562:         THIS.AddObject("obj_4c_CmdCotacao", "CommandGroup")
563:         loc_oGrp = THIS.obj_4c_CmdCotacao
564:         WITH loc_oGrp
565:             .Top           = -2
566:             .Left          = 845
567:             .Width         = 85
568:             .Height        = 85
569:             .ButtonCount   = 1
570:             .BackStyle     = 0
571:             .BorderStyle   = 0
572:             .SpecialEffect = 1
573:             .Visible       = .T.
574:         ENDWITH
575:         WITH loc_oGrp.Buttons(1)
576:             .Top             = 5
577:             .Left            = 5
578:             .Width           = 75
579:             .Height          = 75
580:             .FontBold        = .T.
581:             .FontItalic      = .T.
582:             .FontName        = "Tahoma"
583:             .FontSize        = 8
584:             .WordWrap        = .T.
585:             .PicturePosition = 13
586:             .Picture         = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
587:             .Caption         = "\<Cota" + CHR(231) + CHR(227) + "o"
588:             .MousePointer    = 15
589:             .ToolTipText     = "Alterar Cota" + CHR(231) + CHR(227) + "o Informativa"
590:             .SpecialEffect   = 0
591:             .ForeColor       = RGB(90, 90, 90)
592:             .BackColor       = RGB(255, 255, 255)

*-- Linhas 598 a 628:
598:         THIS.AddObject("obj_4c_CmdEntrega", "CommandGroup")
599:         loc_oGrp = THIS.obj_4c_CmdEntrega
600:         WITH loc_oGrp
601:             .Top           = -2
602:             .Left          = 770
603:             .Width         = 85
604:             .Height        = 85
605:             .ButtonCount   = 1
606:             .BackStyle     = 0
607:             .BorderStyle   = 0
608:             .SpecialEffect = 1
609:             .Visible       = .T.
610:         ENDWITH
611:         WITH loc_oGrp.Buttons(1)
612:             .Top             = 5
613:             .Left            = 5
614:             .Width           = 75
615:             .Height          = 75
616:             .FontBold        = .T.
617:             .FontItalic      = .T.
618:             .FontName        = "Comic Sans MS"
619:             .FontSize        = 8
620:             .WordWrap        = .T.
621:             .PicturePosition = 13
622:             .Picture         = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
623:             .Caption         = "\<Entrega"
624:             .MousePointer    = 15
625:             .ToolTipText     = "Alterar Prazo de Entrega <F3>"
626:             .SpecialEffect   = 0
627:             .ForeColor       = RGB(90, 90, 90)
628:             .BackColor       = RGB(255, 255, 255)

*-- Linhas 658 a 696:
658:         THIS.AddObject("cnt_4c_Codigos", "Container")
659:         loc_oCnt = THIS.cnt_4c_Codigos
660:         WITH loc_oCnt
661:             .Top         = 96
662:             .Left        = 2
663:             .Width       = 67
664:             .Height      = 45
665:             .BackStyle   = 0
666:             .BorderWidth = 0
667:             .Visible     = .T.
668:         ENDWITH
669: 
670:         loc_oCnt.AddObject("lbl_4c_LblCodigos", "Label")
671:         WITH loc_oCnt.lbl_4c_LblCodigos
672:             .FontBold  = .F.
673:             .FontName  = "Tahoma"
674:             .FontSize  = 8
675:             .BackStyle = 0
676:             .Alignment = 0
677:             .AutoSize  = .F.
678:             .Caption   = "C" + CHR(243) + "digo "
679:             .Left      = 3
680:             .Top       = 3
681:             .Width     = 61
682:             .ForeColor = RGB(90, 90, 90)
683:             .Visible   = .T.
684:         ENDWITH
685: 
686:         loc_oCnt.AddObject("txt_4c_Codigos", "TextBox")
687:         WITH loc_oCnt.txt_4c_Codigos
688:             .FontBold      = .T.
689:             .FontSize      = 8
690:             .Left          = 3
691:             .Top           = 20
692:             .Width         = 61
693:             .MaxLength     = 10
694:             .SpecialEffect = 1
695:             .ForeColor     = RGB(0, 0, 0)
696:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 705 a 741:
705:         THIS.AddObject("cnt_4c_Documentos", "Container")
706:         loc_oCnt = THIS.cnt_4c_Documentos
707:         WITH loc_oCnt
708:             .Top         = 96
709:             .Left        = 69
710:             .Width       = 170
711:             .Height      = 45
712:             .BackStyle   = 0
713:             .BorderWidth = 0
714:             .Visible     = .T.
715:         ENDWITH
716: 
717:         loc_oCnt.AddObject("lbl_4c_LblDocumentos", "Label")
718:         WITH loc_oCnt.lbl_4c_LblDocumentos
719:             .FontBold  = .F.
720:             .FontName  = "Tahoma"
721:             .FontSize  = 8
722:             .BackStyle = 0
723:             .Alignment = 0
724:             .AutoSize  = .F.
725:             .Caption   = "Documento"
726:             .Left      = 3
727:             .Top       = 3
728:             .Width     = 56
729:             .ForeColor = RGB(90, 90, 90)
730:             .Visible   = .T.
731:         ENDWITH
732: 
733:         loc_oCnt.AddObject("txt_4c_Documentos", "TextBox")
734:         WITH loc_oCnt.txt_4c_Documentos
735:             .Left          = 3
736:             .Top           = 20
737:             .Width         = 67
738:             .Margin        = 0
739:             .MaxLength     = 6
740:             .SpecialEffect = 1
741:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 747 a 774:
747:         ENDIF
748:         BINDEVENT(loc_oCnt.txt_4c_Documentos, "When", THIS, "DocumentosWhen")
749: 
750:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
751:         WITH loc_oCnt.lbl_4c_Label1
752:             .FontBold  = .F.
753:             .FontName  = "Tahoma"
754:             .FontSize  = 8
755:             .BackStyle = 0
756:             .Alignment = 0
757:             .AutoSize  = .F.
758:             .Caption   = "Nota"
759:             .Left      = 73
760:             .Top       = 3
761:             .Width     = 25
762:             .ForeColor = RGB(90, 90, 90)
763:             .Visible   = .T.
764:         ENDWITH
765: 
766:         loc_oCnt.AddObject("txt_4c_NumeroNota", "TextBox")
767:         WITH loc_oCnt.txt_4c_NumeroNota
768:             .Left          = 73
769:             .Top           = 20
770:             .Width         = 94
771:             .Height        = 23
772:             .Margin        = 0
773:             .MaxLength     = 10
774:             .SpecialEffect = 1

*-- Linhas 785 a 822:
785:         THIS.AddObject("cnt_4c_Ecfs", "Container")
786:         loc_oCnt = THIS.cnt_4c_Ecfs
787:         WITH loc_oCnt
788:             .Top         = 96
789:             .Left        = 240
790:             .Width       = 65
791:             .Height      = 45
792:             .BackStyle   = 0
793:             .BorderWidth = 0
794:             .Visible     = .T.
795:         ENDWITH
796: 
797:         loc_oCnt.AddObject("lbl_4c_LblEcfs", "Label")
798:         WITH loc_oCnt.lbl_4c_LblEcfs
799:             .FontBold  = .F.
800:             .FontName  = "Tahoma"
801:             .FontSize  = 8
802:             .BackStyle = 0
803:             .Alignment = 0
804:             .AutoSize  = .F.
805:             .Caption   = "ECF  "
806:             .Left      = 3
807:             .Top       = 3
808:             .Width     = 27
809:             .Height    = 15
810:             .ForeColor = RGB(90, 90, 90)
811:             .Visible   = .T.
812:         ENDWITH
813: 
814:         loc_oCnt.AddObject("txt_4c_Ecfs", "TextBox")
815:         WITH loc_oCnt.txt_4c_Ecfs
816:             .Left          = 3
817:             .Top           = 20
818:             .Width         = 59
819:             .Height        = 23
820:             .Margin        = 0
821:             .InputMask     = "9999999"
822:             .MaxLength     = 7

*-- Linhas 834 a 871:
834:         THIS.AddObject("cnt_4c_Nemps", "Container")
835:         loc_oCnt = THIS.cnt_4c_Nemps
836:         WITH loc_oCnt
837:             .Top         = 96
838:             .Left        = 305
839:             .Width       = 156
840:             .Height      = 45
841:             .BackStyle   = 0
842:             .BorderWidth = 0
843:             .Visible     = .T.
844:         ENDWITH
845: 
846:         loc_oCnt.AddObject("lbl_4c_LblNemps", "Label")
847:         WITH loc_oCnt.lbl_4c_LblNemps
848:             .FontBold  = .F.
849:             .FontName  = "Tahoma"
850:             .FontSize  = 8
851:             .BackStyle = 0
852:             .Alignment = 0
853:             .AutoSize  = .F.
854:             .Caption   = "N" + CHR(186) + " S" + CHR(233) + "rie Imp."
855:             .Left      = 3
856:             .Top       = 3
857:             .Width     = 66
858:             .Height    = 15
859:             .ForeColor = RGB(90, 90, 90)
860:             .Visible   = .T.
861:         ENDWITH
862: 
863:         loc_oCnt.AddObject("txt_4c_Nemps", "TextBox")
864:         WITH loc_oCnt.txt_4c_Nemps
865:             .Left          = 3
866:             .Top           = 20
867:             .Width         = 150
868:             .Height        = 23
869:             .Margin        = 0
870:             .MaxLength     = 20
871:             .SpecialEffect = 1

*-- Linhas 983 a 1019:
983:         THIS.AddObject("cnt_4c_Emiss", "Container")
984:         loc_oCnt = THIS.cnt_4c_Emiss
985:         WITH loc_oCnt
986:             .Top         = 147
987:             .Left        = 2
988:             .Width       = 86
989:             .Height      = 45
990:             .BackStyle   = 0
991:             .BorderWidth = 0
992:             .Visible     = .T.
993:         ENDWITH
994: 
995:         loc_oCnt.AddObject("lbl_4c_LblEmiss", "Label")
996:         WITH loc_oCnt.lbl_4c_LblEmiss
997:             .FontBold  = .F.
998:             .FontName  = "Tahoma"
999:             .FontSize  = 8
1000:             .BackStyle = 0
1001:             .Alignment = 0
1002:             .AutoSize  = .F.
1003:             .Caption   = "Data Emiss" + CHR(227) + "o "
1004:             .Left      = 3
1005:             .Top       = 3
1006:             .Width     = 80
1007:             .ForeColor = RGB(90, 90, 90)
1008:             .Visible   = .T.
1009:         ENDWITH
1010: 
1011:         loc_oCnt.AddObject("txt_4c_Emiss", "TextBox")
1012:         WITH loc_oCnt.txt_4c_Emiss
1013:             .Left          = 3
1014:             .Top           = 20
1015:             .Width         = 80
1016:             .Margin        = 0
1017:             .SpecialEffect = 1
1018:             .ForeColor     = RGB(0, 0, 0)
1019:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1030 a 1066:
1030:         THIS.AddObject("cnt_4c_Entregas", "Container")
1031:         loc_oCnt = THIS.cnt_4c_Entregas
1032:         WITH loc_oCnt
1033:             .Top         = 147
1034:             .Left        = 88
1035:             .Width       = 86
1036:             .Height      = 45
1037:             .BackStyle   = 0
1038:             .BorderWidth = 0
1039:             .Visible     = .T.
1040:         ENDWITH
1041: 
1042:         loc_oCnt.AddObject("lbl_4c_LblEntregas", "Label")
1043:         WITH loc_oCnt.lbl_4c_LblEntregas
1044:             .FontBold  = .F.
1045:             .FontName  = "Tahoma"
1046:             .FontSize  = 8
1047:             .BackStyle = 0
1048:             .Alignment = 0
1049:             .AutoSize  = .F.
1050:             .Caption   = "Prz. Entrega "
1051:             .Left      = 3
1052:             .Top       = 3
1053:             .Width     = 80
1054:             .ForeColor = RGB(90, 90, 90)
1055:             .Visible   = .T.
1056:         ENDWITH
1057: 
1058:         loc_oCnt.AddObject("txt_4c_Entregas", "TextBox")
1059:         WITH loc_oCnt.txt_4c_Entregas
1060:             .Left          = 3
1061:             .Top           = 20
1062:             .Width         = 80
1063:             .Margin        = 0
1064:             .SpecialEffect = 1
1065:             .ForeColor     = RGB(0, 0, 0)
1066:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1077 a 1113:
1077:         THIS.AddObject("cnt_4c_Recepcaos", "Container")
1078:         loc_oCnt = THIS.cnt_4c_Recepcaos
1079:         WITH loc_oCnt
1080:             .Top         = 147
1081:             .Left        = 174
1082:             .Width       = 86
1083:             .Height      = 45
1084:             .BackStyle   = 0
1085:             .BorderWidth = 0
1086:             .Visible     = .T.
1087:         ENDWITH
1088: 
1089:         loc_oCnt.AddObject("lbl_4c_LblRecepcaos", "Label")
1090:         WITH loc_oCnt.lbl_4c_LblRecepcaos
1091:             .FontBold  = .F.
1092:             .FontName  = "Tahoma"
1093:             .FontSize  = 8
1094:             .BackStyle = 0
1095:             .Alignment = 0
1096:             .AutoSize  = .F.
1097:             .Caption   = "Recep" + CHR(231) + CHR(227) + "o "
1098:             .Left      = 3
1099:             .Top       = 3
1100:             .Width     = 80
1101:             .ForeColor = RGB(90, 90, 90)
1102:             .Visible   = .T.
1103:         ENDWITH
1104: 
1105:         loc_oCnt.AddObject("txt_4c_Recepcaos", "TextBox")
1106:         WITH loc_oCnt.txt_4c_Recepcaos
1107:             .Left          = 3
1108:             .Top           = 20
1109:             .Width         = 80
1110:             .Margin        = 0
1111:             .SpecialEffect = 1
1112:             .ForeColor     = RGB(0, 0, 0)
1113:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1124 a 1160:
1124:         THIS.AddObject("cnt_4c_PrzEnts", "Container")
1125:         loc_oCnt = THIS.cnt_4c_PrzEnts
1126:         WITH loc_oCnt
1127:             .Top         = 147
1128:             .Left        = 260
1129:             .Width       = 86
1130:             .Height      = 45
1131:             .BackStyle   = 0
1132:             .BorderWidth = 0
1133:             .Visible     = .T.
1134:         ENDWITH
1135: 
1136:         loc_oCnt.AddObject("lbl_4c_LblPrzEnts", "Label")
1137:         WITH loc_oCnt.lbl_4c_LblPrzEnts
1138:             .FontBold  = .F.
1139:             .FontName  = "Tahoma"
1140:             .FontSize  = 8
1141:             .BackStyle = 0
1142:             .Alignment = 0
1143:             .AutoSize  = .F.
1144:             .Caption   = "Dt. Prometida"
1145:             .Left      = 3
1146:             .Top       = 3
1147:             .Width     = 80
1148:             .ForeColor = RGB(90, 90, 90)
1149:             .Visible   = .T.
1150:         ENDWITH
1151: 
1152:         loc_oCnt.AddObject("txt_4c_PrzEnts", "TextBox")
1153:         WITH loc_oCnt.txt_4c_PrzEnts
1154:             .Left          = 3
1155:             .Top           = 20
1156:             .Width         = 80
1157:             .Margin        = 0
1158:             .SpecialEffect = 1
1159:             .ForeColor     = RGB(0, 0, 0)
1160:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1256 a 1311:
1256:         THIS.AddObject("cnt_4c_Volumes", "Container")
1257:         loc_oCnt = THIS.cnt_4c_Volumes
1258:         WITH loc_oCnt
1259:             .Top         = 264
1260:             .Left        = 488
1261:             .Width       = 509
1262:             .Height      = 66
1263:             .BackStyle   = 0
1264:             .BorderWidth = 0
1265:             .Visible     = .T.
1266:         ENDWITH
1267: 
1268:         loc_oCnt.AddObject("lbl_4c_Label16", "Label")
1269:         WITH loc_oCnt.lbl_4c_Label16
1270:             .FontBold  = .T.
1271:             .FontName  = "Tahoma"
1272:             .FontSize  = 8
1273:             .BackStyle = 0
1274:             .Alignment = 0
1275:             .AutoSize  = .F.
1276:             .Caption   = "Transporte"
1277:             .Left      = 3
1278:             .Top       = 3
1279:             .Width     = 100
1280:             .ForeColor = RGB(90, 90, 90)
1281:             .Visible   = .T.
1282:         ENDWITH
1283: 
1284:         loc_oCnt.AddObject("lbl_4c_LblQtds", "Label")
1285:         WITH loc_oCnt.lbl_4c_LblQtds
1286:             .FontName  = "Tahoma"
1287:             .FontSize  = 8
1288:             .BackStyle = 0
1289:             .Alignment = 0
1290:             .AutoSize  = .F.
1291:             .Caption   = "Qtde."
1292:             .Left      = 3
1293:             .Top        = 23
1294:             .Width     = 50
1295:             .ForeColor = RGB(90, 90, 90)
1296:             .Visible   = .T.
1297:         ENDWITH
1298: 
1299:         loc_oCnt.AddObject("txt_4c_Qtds", "TextBox")
1300:         WITH loc_oCnt.txt_4c_Qtds
1301:             .Alignment     = 3
1302:             .Format        = "K"
1303:             .InputMask     = "999999"
1304:             .MaxLength     = 6
1305:             .Left          = 3
1306:             .Top           = 40
1307:             .Width         = 51
1308:             .Height        = 23
1309:             .Margin        = 0
1310:             .SpecialEffect = 1
1311:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1317 a 1345:
1317:         ENDIF
1318:         BINDEVENT(loc_oCnt.txt_4c_Qtds, "When", THIS, "VolumesWhen")
1319: 
1320:         loc_oCnt.AddObject("lbl_4c_LblEspes", "Label")
1321:         WITH loc_oCnt.lbl_4c_LblEspes
1322:             .FontName  = "Tahoma"
1323:             .FontSize  = 8
1324:             .BackStyle = 0
1325:             .Alignment = 0
1326:             .AutoSize  = .F.
1327:             .Caption   = "Esp" + CHR(233) + "cie"
1328:             .Left      = 57
1329:             .Top       = 23
1330:             .Width     = 85
1331:             .ForeColor = RGB(90, 90, 90)
1332:             .Visible   = .T.
1333:         ENDWITH
1334: 
1335:         loc_oCnt.AddObject("txt_4c_Espes", "TextBox")
1336:         WITH loc_oCnt.txt_4c_Espes
1337:             .Alignment     = 3
1338:             .MaxLength     = 10
1339:             .Left          = 57
1340:             .Top           = 40
1341:             .Width         = 87
1342:             .Height        = 23
1343:             .Margin        = 0
1344:             .SpecialEffect = 1
1345:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1351 a 1379:
1351:         ENDIF
1352:         BINDEVENT(loc_oCnt.txt_4c_Espes, "When", THIS, "VolumesWhen")
1353: 
1354:         loc_oCnt.AddObject("lbl_4c_LblPLiqs", "Label")
1355:         WITH loc_oCnt.lbl_4c_LblPLiqs
1356:             .FontName  = "Tahoma"
1357:             .FontSize  = 8
1358:             .BackStyle = 0
1359:             .Alignment = 0
1360:             .AutoSize  = .F.
1361:             .Caption   = "Peso L" + CHR(237) + "quido"
1362:             .Left      = 147
1363:             .Top       = 23
1364:             .Width     = 75
1365:             .ForeColor = RGB(90, 90, 90)
1366:             .Visible   = .T.
1367:         ENDWITH
1368: 
1369:         loc_oCnt.AddObject("txt_4c_PLiqs", "TextBox")
1370:         WITH loc_oCnt.txt_4c_PLiqs
1371:             .Alignment     = 3
1372:             .InputMask     = "99,999.99"
1373:             .Left          = 147
1374:             .Top           = 40
1375:             .Width         = 73
1376:             .Height        = 23
1377:             .Margin        = 0
1378:             .SpecialEffect = 1
1379:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1385 a 1413:
1385:         ENDIF
1386:         BINDEVENT(loc_oCnt.txt_4c_PLiqs, "When", THIS, "VolumesWhen")
1387: 
1388:         loc_oCnt.AddObject("lbl_4c_LblPBrus", "Label")
1389:         WITH loc_oCnt.lbl_4c_LblPBrus
1390:             .FontName  = "Tahoma"
1391:             .FontSize  = 8
1392:             .BackStyle = 0
1393:             .Alignment = 0
1394:             .AutoSize  = .F.
1395:             .Caption   = "Peso Bruto"
1396:             .Left      = 223
1397:             .Top       = 23
1398:             .Width     = 75
1399:             .ForeColor = RGB(90, 90, 90)
1400:             .Visible   = .T.
1401:         ENDWITH
1402: 
1403:         loc_oCnt.AddObject("txt_4c_PBrus", "TextBox")
1404:         WITH loc_oCnt.txt_4c_PBrus
1405:             .Alignment     = 3
1406:             .InputMask     = "99,999.99"
1407:             .Left          = 223
1408:             .Top           = 40
1409:             .Width         = 73
1410:             .Height        = 23
1411:             .Margin        = 0
1412:             .SpecialEffect = 1
1413:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1419 a 1447:
1419:         ENDIF
1420:         BINDEVENT(loc_oCnt.txt_4c_PBrus, "When", THIS, "VolumesWhen")
1421: 
1422:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1423:         WITH loc_oCnt.lbl_4c_Label1
1424:             .FontName  = "Tahoma"
1425:             .FontSize  = 8
1426:             .BackStyle = 0
1427:             .Alignment = 0
1428:             .AutoSize  = .F.
1429:             .Caption   = "Valor Transporte"
1430:             .Left      = 299
1431:             .Top       = 23
1432:             .Width     = 100
1433:             .ForeColor = RGB(90, 90, 90)
1434:             .Visible   = .T.
1435:         ENDWITH
1436: 
1437:         loc_oCnt.AddObject("txt_4c_ValTrans", "TextBox")
1438:         WITH loc_oCnt.txt_4c_ValTrans
1439:             .Alignment     = 3
1440:             .InputMask     = "999,999.99"
1441:             .Left          = 299
1442:             .Top           = 40
1443:             .Width         = 90
1444:             .Height        = 23
1445:             .Margin        = 0
1446:             .SpecialEffect = 1
1447:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1479 a 1517:
1479:         THIS.AddObject("cnt_4c_Observacao", "Container")
1480:         loc_oCnt = THIS.cnt_4c_Observacao
1481:         WITH loc_oCnt
1482:             .Top         = 228
1483:             .Left        = 12
1484:             .Width       = 528
1485:             .Height      = 303
1486:             .BackStyle   = 0
1487:             .BorderWidth = 0
1488:             .Visible     = .T.
1489:         ENDWITH
1490: 
1491:         loc_oCnt.AddObject("lbl_4c_LblObservas", "Label")
1492:         WITH loc_oCnt.lbl_4c_LblObservas
1493:             .FontBold  = .T.
1494:             .FontName  = "Tahoma"
1495:             .FontSize  = 8
1496:             .BackStyle = 0
1497:             .Alignment = 0
1498:             .AutoSize  = .F.
1499:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
1500:             .Left      = 3
1501:             .Top       = 23
1502:             .Width     = 85
1503:             .ForeColor = RGB(90, 90, 90)
1504:             .Visible   = .T.
1505:         ENDWITH
1506: 
1507:         loc_oCnt.AddObject("txt_4c_CodObs", "TextBox")
1508:         WITH loc_oCnt.txt_4c_CodObs
1509:             .Alignment     = 3
1510:             .InputMask     = "999"
1511:             .Left          = 92
1512:             .Top           = 19
1513:             .Width         = 32
1514:             .Height        = 23
1515:             .Margin        = 0
1516:             .Value         = 0
1517:             .SpecialEffect = 1

*-- Linhas 1529 a 1574:
1529:         loc_oCnt.AddObject("obj_4c_GetDesObs", "EditBox")
1530:         WITH loc_oCnt.obj_4c_GetDesObs
1531:             .FontSize      = 8
1532:             .Left          = 3
1533:             .Top           = 46
1534:             .Width         = 453
1535:             .Height        = 254
1536:             .SpecialEffect = 1
1537:             .ForeColor     = RGB(0, 0, 0)
1538:             .BorderColor   = RGB(100, 100, 100)
1539:             .Visible       = .T.
1540:         ENDWITH
1541:         IF loc_lTemCursorPai
1542:             loc_oCnt.obj_4c_GetDesObs.ControlSource = "TprMvCab.obses"
1543:         ENDIF
1544:         BINDEVENT(loc_oCnt.obj_4c_GetDesObs, "When", THIS, "DesObsWhen")
1545: 
1546:         loc_oCnt.AddObject("cmd_4c_BtnMultObs", "CommandButton")
1547:         WITH loc_oCnt.cmd_4c_BtnMultObs
1548:             .Top          = 5
1549:             .Left         = 135
1550:             .Width        = 24
1551:             .Height       = 24
1552:             .Caption      = ""
1553:             .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1554:             .ToolTipText  = "Selecionar M" + CHR(250) + "ltiplas Observa" + CHR(231) + CHR(245) + "es"
1555:             .Themes       = .T.
1556:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1557:             .Visible      = .T.
1558:         ENDWITH
1559:         BINDEVENT(loc_oCnt.cmd_4c_BtnMultObs, "Click", THIS, "BtnMultObsObservacaoClick")
1560:     ENDPROC
1561: 
1562:     *==========================================================================
1563:     * CodObsGotFocus - "This.Tag = Str(This.Value, 10)" do legado (getCodObs.
1564:     * GotFocus): guarda o valor de entrada no Tag para o LostFocus saber se
1565:     * o usuario realmente alterou o codigo (evita reabrir o lookup so por
1566:     * entrar/sair do campo sem digitar nada).
1567:     *
1568:     * PUBLIC: alvo de BINDEVENT("GotFocus").
1569:     *==========================================================================
1570:     PROCEDURE CodObsGotFocus()
1571:         LOCAL loc_oTxt
1572:         loc_oTxt = THIS.cnt_4c_Observacao.txt_4c_CodObs
1573:         loc_oTxt.Tag = STR(loc_oTxt.Value, 10)
1574:     ENDPROC

*-- Linhas 1796 a 1835:
1796:         THIS.AddObject("cnt_4c_Protocolo", "Container")
1797:         loc_oCnt = THIS.cnt_4c_Protocolo
1798:         WITH loc_oCnt
1799:             .Top         = 96
1800:             .Left        = 461
1801:             .Width       = 61
1802:             .Height      = 45
1803:             .BackStyle   = 0
1804:             .BorderWidth = 0
1805:             .Visible     = .T.
1806:         ENDWITH
1807: 
1808:         loc_oCnt.AddObject("lbl_4c_LblProtocolos", "Label")
1809:         WITH loc_oCnt.lbl_4c_LblProtocolos
1810:             .FontName  = "Tahoma"
1811:             .FontSize  = 8
1812:             .BackStyle = 0
1813:             .Alignment = 0
1814:             .AutoSize  = .F.
1815:             .Caption   = "Protocolo"
1816:             .Left      = 3
1817:             .Top       = 3
1818:             .Width     = 55
1819:             .ForeColor = RGB(90, 90, 90)
1820:             .Visible   = .T.
1821:         ENDWITH
1822: 
1823:         loc_oCnt.AddObject("txt_4c_Protocolos", "TextBox")
1824:         WITH loc_oCnt.txt_4c_Protocolos
1825:             .Alignment     = 3
1826:             .Format        = "K"
1827:             .InputMask     = "999999"
1828:             .MaxLength     = 6
1829:             .Left          = 3
1830:             .Top           = 20
1831:             .Width         = 55
1832:             .Height        = 23
1833:             .Margin        = 0
1834:             .SpecialEffect = 1
1835:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1855 a 1939:
1855:         THIS.AddObject("cnt_4c_Entrega", "Container")
1856:         loc_oCnt = THIS.cnt_4c_Entrega
1857:         WITH loc_oCnt
1858:             .Top         = 192
1859:             .Left        = 489
1860:             .Width       = 504
1861:             .Height      = 66
1862:             .BackStyle   = 0
1863:             .BorderWidth = 0
1864:             .Visible     = .T.
1865:         ENDWITH
1866: 
1867:         loc_oCnt.AddObject("lbl_4c_LblEntregas", "Label")
1868:         WITH loc_oCnt.lbl_4c_LblEntregas
1869:             .FontBold  = .T.
1870:             .FontName  = "Tahoma"
1871:             .FontSize  = 8
1872:             .BackStyle = 0
1873:             .Alignment = 0
1874:             .AutoSize  = .F.
1875:             .Caption   = "Entrega"
1876:             .Left      = 3
1877:             .Top       = 3
1878:             .Width     = 85
1879:             .ForeColor = RGB(90, 90, 90)
1880:             .Visible   = .T.
1881:         ENDWITH
1882: 
1883:         loc_oCnt.AddObject("lbl_4c_LblContas", "Label")
1884:         WITH loc_oCnt.lbl_4c_LblContas
1885:             .FontName  = "Tahoma"
1886:             .FontSize  = 8
1887:             .BackStyle = 0
1888:             .Alignment = 0
1889:             .AutoSize  = .F.
1890:             .Caption   = "Conta"
1891:             .Left      = 3
1892:             .Top       = 23
1893:             .Width     = 70
1894:             .ForeColor = RGB(90, 90, 90)
1895:             .Visible   = .T.
1896:         ENDWITH
1897: 
1898:         loc_oCnt.AddObject("lbl_4c_LblCpfs", "Label")
1899:         WITH loc_oCnt.lbl_4c_LblCpfs
1900:             .FontName  = "Tahoma"
1901:             .FontSize  = 8
1902:             .BackStyle = 0
1903:             .Alignment = 0
1904:             .AutoSize  = .F.
1905:             .Caption   = "CPF / CNPJ"
1906:             .Left      = 77
1907:             .Top       = 23
1908:             .Width     = 56
1909:             .Height    = 15
1910:             .ForeColor = RGB(90, 90, 90)
1911:             .Visible   = .T.
1912:         ENDWITH
1913: 
1914:         loc_oCnt.AddObject("lbl_4c_LblDConta", "Label")
1915:         WITH loc_oCnt.lbl_4c_LblDConta
1916:             .FontName  = "Tahoma"
1917:             .FontSize  = 8
1918:             .BackStyle = 0
1919:             .Alignment = 0
1920:             .AutoSize  = .F.
1921:             .Caption   = "Nome"
1922:             .Left      = 210
1923:             .Top       = 23
1924:             .Width     = 29
1925:             .Height    = 15
1926:             .ForeColor = RGB(90, 90, 90)
1927:             .Visible   = .T.
1928:         ENDWITH
1929: 
1930:         loc_oCnt.AddObject("txt_4c_Contas", "TextBox")
1931:         WITH loc_oCnt.txt_4c_Contas
1932:             .MaxLength     = 10
1933:             .Left          = 3
1934:             .Top           = 40
1935:             .Width         = 72
1936:             .Height        = 23
1937:             .Margin        = 0
1938:             .SpecialEffect = 1
1939:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1948 a 1957:
1948: 
1949:         loc_oCnt.AddObject("txt_4c_Cpfs", "TextBox")
1950:         WITH loc_oCnt.txt_4c_Cpfs
1951:             .Left          = 77
1952:             .Top           = 40
1953:             .Width         = 131
1954:             .Height        = 23
1955:             .Margin        = 0
1956:             .SpecialEffect = 1
1957:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 1963 a 2007:
1963: 
1964:         loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
1965:         WITH loc_oCnt.txt_4c_DConta
1966:             .Left          = 210
1967:             .Top           = 40
1968:             .Width         = 285
1969:             .Height        = 23
1970:             .Margin        = 0
1971:             .SpecialEffect = 1
1972:             .ForeColor     = RGB(0, 0, 0)
1973:             .BorderColor   = RGB(100, 100, 100)
1974:             .Visible       = .T.
1975:         ENDWITH
1976:         BINDEVENT(loc_oCnt.txt_4c_DConta, "LostFocus", THIS, "DContaLostFocus")
1977:         BINDEVENT(loc_oCnt.txt_4c_DConta, "When",      THIS, "EntregaCamposLiberadosWhen")
1978: 
1979:         loc_oCnt.AddObject("cmd_4c_CmdEntrega", "CommandButton")
1980:         WITH loc_oCnt.cmd_4c_CmdEntrega
1981:             .Top             = 0
1982:             .Left            = 455
1983:             .Width           = 24
1984:             .Height          = 24
1985:             .Caption         = ""
1986:             .Picture         = gc_4c_CaminhoIcones + "geral_relogio_26.jpg"
1987:             .ToolTipText     = "Local de Entrega"
1988:             .Themes          = .T.
1989:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_relogio_26.jpg"
1990:             .Visible         = .T.
1991:         ENDWITH
1992:         BINDEVENT(loc_oCnt.cmd_4c_CmdEntrega, "Click", THIS, "EntregaLocalClick")
1993:     ENDPROC
1994: 
1995:     *==========================================================================
1996:     * ContasLostFocus/DContaLostFocus/CpfsLostFocus - equivalentes ao Valid/
1997:     * LostFocus legado de getContas/getDConta/getCpfs (regra #47). Os tres
1998:     * campos sao intercambiaveis: preencher QUALQUER um localiza a conta em
1999:     * SigCdCli e preenche os outros dois.
2000:     *
2001:     * fAcessoContas(..., pSt1=.NULL., pSt2=.NULL.) - modo BACKEND (regra do
2002:     * projeto: AcessoContas() NUNCA em modo lookup-UI, que auto-popula com o
2003:     * PRIMEIRO registro que contem o valor digitado - aqui ele so confere
2004:     * ACESSO, sem objeto de TextBox nenhum).
2005:     *
2006:     * Guard this_cUltimo<X>LostFocusValidado: LostFocus dispara mesmo sem o
2007:     * usuario mudar o valor (diferente do Valid legado, que so dispara na

*-- Linhas 2350 a 2389:
2350:         THIS.AddObject("cnt_4c_Pedido", "Container")
2351:         loc_oCnt = THIS.cnt_4c_Pedido
2352:         WITH loc_oCnt
2353:             .Top         = 96
2354:             .Left        = 522
2355:             .Width       = 61
2356:             .Height      = 45
2357:             .BackStyle   = 0
2358:             .BorderWidth = 0
2359:             .Visible     = .T.
2360:         ENDWITH
2361: 
2362:         loc_oCnt.AddObject("lbl_4c_LblPedido", "Label")
2363:         WITH loc_oCnt.lbl_4c_LblPedido
2364:             .FontName  = "Tahoma"
2365:             .FontSize  = 8
2366:             .BackStyle = 0
2367:             .Alignment = 0
2368:             .AutoSize  = .F.
2369:             .Caption   = "Pedido"
2370:             .Left      = 3
2371:             .Top       = 3
2372:             .Width     = 55
2373:             .ForeColor = RGB(90, 90, 90)
2374:             .Visible   = .T.
2375:         ENDWITH
2376: 
2377:         loc_oCnt.AddObject("txt_4c_Pedido", "TextBox")
2378:         WITH loc_oCnt.txt_4c_Pedido
2379:             .Alignment     = 3
2380:             .Format        = "K"
2381:             .InputMask     = "999999"
2382:             .MaxLength     = 6
2383:             .Left          = 3
2384:             .Top           = 20
2385:             .Width         = 55
2386:             .Height        = 23
2387:             .Margin        = 0
2388:             .SpecialEffect = 1
2389:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 2426 a 2481:
2426:         THIS.AddObject("cnt_4c_Obs2", "Container")
2427:         loc_oCnt = THIS.cnt_4c_Obs2
2428:         WITH loc_oCnt
2429:             .Top         = 96
2430:             .Left        = 582
2431:             .Width       = 66
2432:             .Height      = 64
2433:             .BackStyle   = 0
2434:             .BorderWidth = 0
2435:             .Visible     = .T.
2436:         ENDWITH
2437: 
2438:         loc_oCnt.AddObject("lbl_4c_LblPedido", "Label")
2439:         WITH loc_oCnt.lbl_4c_LblPedido
2440:             .FontName  = "Tahoma"
2441:             .FontSize  = 8
2442:             .BackStyle = 0
2443:             .Alignment = 0
2444:             .AutoSize  = .F.
2445:             .Caption   = "Finalidade"
2446:             .Left      = 3
2447:             .Top       = 3
2448:             .Width     = 60
2449:             .ForeColor = RGB(90, 90, 90)
2450:             .Visible   = .T.
2451:         ENDWITH
2452: 
2453:         loc_oCnt.AddObject("cmd_4c_BtnMultObs", "CommandButton")
2454:         WITH loc_oCnt.cmd_4c_BtnMultObs
2455:             .Top             = 20
2456:             .Left            = 3
2457:             .Width           = 24
2458:             .Height          = 24
2459:             .Caption         = ""
2460:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
2461:             .ToolTipText     = "Selecionar Finalidade da opera" + CHR(231) + CHR(227) + "o para ser usada no relat" + CHR(243) + "rio de opera" + CHR(231) + CHR(245) + "es."
2462:             .Themes          = .T.
2463:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
2464:             .Visible         = .T.
2465:         ENDWITH
2466:         BINDEVENT(loc_oCnt.cmd_4c_BtnMultObs, "Click", THIS, "BtnMultObsFinalidadeClick")
2467:     ENDPROC
2468: 
2469:     *==========================================================================
2470:     * BtnMultObsFinalidadeClick - CntObs2.btnMultObs.Valid legado:
2471:     *   Do Form SigOpIns With ThisForm.ParentForm.poDataMgr, TprMvCab.CodObs2
2472:     *   replace CodObs2 with ALLTRIM(listaObs) in TprMvCab
2473:     * SigOpIns nao veio no acervo - sem a tela (e sem a lista que ela
2474:     * devolveria em listaObs), nao ha resultado para gravar em CodObs2.
2475:     *
2476:     * PUBLIC: alvo de BINDEVENT("Click").
2477:     *==========================================================================
2478:     PROCEDURE BtnMultObsFinalidadeClick()
2479:         THIS.AvisarLegadoNaoPortado("Tela de Sele" + CHR(231) + CHR(227) + "o de Finalidade (SigOpIns)", ;
2480:             "selecionar a finalidade da opera" + CHR(231) + CHR(227) + "o")
2481:     ENDPROC

*-- Linhas 2490 a 2529:
2490:         THIS.AddObject("cnt_4c_Livre", "Container")
2491:         loc_oCnt = THIS.cnt_4c_Livre
2492:         WITH loc_oCnt
2493:             .Top         = 189
2494:             .Left        = 2
2495:             .Width       = 352
2496:             .Height      = 45
2497:             .BackStyle   = 0
2498:             .BorderWidth = 0
2499:             .Visible     = .T.
2500:         ENDWITH
2501: 
2502:         loc_oCnt.AddObject("lbl_4c_LblNLivDg", "Label")
2503:         WITH loc_oCnt.lbl_4c_LblNLivDg
2504:             .FontName  = "Tahoma"
2505:             .FontSize  = 8
2506:             .BackStyle = 0
2507:             .Alignment = 0
2508:             .AutoSize  = .F.
2509:             .Caption   = "Lacre"
2510:             .Left      = 3
2511:             .Top       = 3
2512:             .Width     = 60
2513:             .Height    = 15
2514:             .ForeColor = RGB(90, 90, 90)
2515:             .Visible   = .T.
2516:         ENDWITH
2517: 
2518:         loc_oCnt.AddObject("txt_4c_NLivDg", "TextBox")
2519:         WITH loc_oCnt.txt_4c_NLivDg
2520:             .Alignment     = 3
2521:             .MaxLength     = 15
2522:             .Value         = 0
2523:             .Left          = 3
2524:             .Top           = 20
2525:             .Width         = 169
2526:             .Height        = 23
2527:             .Margin        = 0
2528:             .SpecialEffect = 1
2529:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 2821 a 2829:
2821:         *-- dialogo. Falso seguro parcial: ao menos confirma/preenche
2822:         *-- Nome e CPF/CNPJ a partir do codigo JA presente em
2823:         *-- TprMvCab.ContaEs, igual ao "lcCliente = TprMvCab.ContaEs /
2824:         *-- CursorQuery(...) / getDConta.Value = ... / getCpfs.Value = ..."
2825:         *-- que fecha esse trecho do Init legado.
2826:         IF !EMPTY(TprMvCab.ContaEs)
2827:             THIS.BuscarContaEntrega("IClis", ALLTRIM(TprMvCab.ContaEs))
2828:         ENDIF
2829: 

*-- Linhas 2836 a 2857:
2836: 
2837:         *** Digita Data de Entrega
2838:         THIS.cnt_4c_Entregas.Visible = INLIST(crSigCdOpe.DtEntrs, 1, 4, 6)
2839:         THIS.cnt_4c_Entregas.lbl_4c_LblEntregas.Caption = "Prz. Entrega "
2840:         IF USED("CrSigOpCdc") ;
2841:            AND (CrSigOpCdc.DckPrze = 1 OR CrSigOpCdc.ChkPrzEnts = 1) ;
2842:            AND !EMPTY(CrSigOpCdc.DocPrzE)
2843:             THIS.cnt_4c_Entregas.lbl_4c_LblEntregas.Caption = ALLTRIM(PROPER(CrSigOpCdc.DocPrzE))
2844:         ENDIF
2845: 
2846:         *** Digita Data de Recepcao
2847:         THIS.cnt_4c_Recepcaos.Visible = (crSigCdOpe.DigRecs = 1)
2848: 
2849:         *** Digita Data Prometida
2850:         IF USED("CrSigOpCdd")
2851:             THIS.cnt_4c_PrzEnts.Visible = (CrSigOpCdd.PrzLjs = 1)
2852:             THIS.cnt_4c_PrzEnts.lbl_4c_LblPrzEnts.Caption = ;
2853:                 IIF(!EMPTY(CrSigOpCdd.DocPrzLjs), CrSigOpCdd.DocPrzLjs, "Dt. Prometida")
2854:         ENDIF
2855: 
2856:         THIS.CarregarPrazoEntregaPadrao()
2857: 

*-- Linhas 2884 a 3003:
2884:         loc_nTop = loc_nTp0
2885: 
2886:         IF THIS.cnt_4c_Ecfs.Visible
2887:             THIS.cnt_4c_Ecfs.Left = loc_nLft
2888:             THIS.cnt_4c_Ecfs.Top  = loc_nTop
2889:             loc_nLft = loc_nLft + THIS.cnt_4c_Ecfs.Width
2890:         ENDIF
2891: 
2892:         IF THIS.cnt_4c_Nemps.Visible
2893:             THIS.cnt_4c_Nemps.Left = loc_nLft
2894:             THIS.cnt_4c_Nemps.Top  = loc_nTop
2895:             loc_nLft = loc_nLft + THIS.cnt_4c_Nemps.Width
2896:         ENDIF
2897: 
2898:         IF THIS.cnt_4c_Protocolo.Visible
2899:             THIS.cnt_4c_Protocolo.Left = loc_nLft
2900:             THIS.cnt_4c_Protocolo.Top  = loc_nTop
2901:             loc_nLft = loc_nLft + THIS.cnt_4c_Protocolo.Width
2902:         ENDIF
2903: 
2904:         IF THIS.cnt_4c_Pedido.Visible
2905:             THIS.cnt_4c_Pedido.Left = loc_nLft
2906:             THIS.cnt_4c_Pedido.Top  = loc_nTop
2907:             loc_nLft = loc_nLft + THIS.cnt_4c_Pedido.Width
2908:         ENDIF
2909: 
2910:         loc_nLft = loc_nLf0
2911:         loc_nTop = loc_nTp0 + THIS.cnt_4c_Codigos.Height + 1
2912: 
2913:         *-- Ajustando Segunda Linha de Campos
2914:         IF THIS.cnt_4c_Emiss.Visible
2915:             THIS.cnt_4c_Emiss.Left = loc_nLft
2916:             THIS.cnt_4c_Emiss.Top  = loc_nTop
2917:             loc_nLft = loc_nLft + THIS.cnt_4c_Emiss.Width
2918:         ENDIF
2919: 
2920:         IF THIS.cnt_4c_Entregas.Visible
2921:             THIS.cnt_4c_Entregas.Left = loc_nLft
2922:             THIS.cnt_4c_Entregas.Top  = loc_nTop
2923:             loc_nLft = loc_nLft + THIS.cnt_4c_Entregas.Width
2924:         ENDIF
2925: 
2926:         IF THIS.cnt_4c_Recepcaos.Visible
2927:             THIS.cnt_4c_Recepcaos.Left = loc_nLft
2928:             THIS.cnt_4c_Recepcaos.Top  = loc_nTop
2929:             loc_nLft = loc_nLft + THIS.cnt_4c_Recepcaos.Width
2930:         ENDIF
2931: 
2932:         IF THIS.cnt_4c_PrzEnts.Visible
2933:             THIS.cnt_4c_PrzEnts.Left = loc_nLft
2934:             THIS.cnt_4c_PrzEnts.Top  = loc_nTop
2935:             loc_nLft = loc_nLft + THIS.cnt_4c_PrzEnts.Width
2936:         ENDIF
2937: 
2938:         IF THIS.cnt_4c_Livre.Visible
2939:             THIS.cnt_4c_Livre.Left = loc_nLft
2940:             THIS.cnt_4c_Livre.Top  = loc_nTop
2941:             loc_nLft = loc_nLft + THIS.cnt_4c_Livre.Width
2942:         ENDIF
2943: 
2944:         loc_nLft = loc_nLf0
2945:         IF THIS.cnt_4c_Emiss.Visible OR THIS.cnt_4c_Entregas.Visible ;
2946:            OR THIS.cnt_4c_Recepcaos.Visible OR THIS.cnt_4c_PrzEnts.Visible ;
2947:            OR THIS.cnt_4c_Livre.Visible
2948:             loc_nTop = loc_nTop + THIS.cnt_4c_Codigos.Height + 1
2949:         ENDIF
2950: 
2951:         *-- Ajustando Conteiner da Observacao
2952:         IF THIS.cnt_4c_Observacao.Visible
2953:             THIS.cnt_4c_Observacao.Left = loc_nLft
2954:             THIS.cnt_4c_Observacao.Top  = loc_nTop
2955:             loc_nTop = loc_nTop + THIS.cnt_4c_Observacao.Height + 1
2956:         ENDIF
2957: 
2958:         *-- Ajustando Conteiner da Entrega
2959:         IF THIS.cnt_4c_Entrega.Visible
2960:             THIS.cnt_4c_Entrega.Left = loc_nLft
2961:             THIS.cnt_4c_Entrega.Top  = loc_nTop
2962:             loc_nTop = loc_nTop + THIS.cnt_4c_Entrega.Height + 1
2963:         ENDIF
2964: 
2965:         *-- Ajustando Conteiner de Volumes
2966:         IF THIS.cnt_4c_Volumes.Visible
2967:             THIS.cnt_4c_Volumes.Left = loc_nLft
2968:             THIS.cnt_4c_Volumes.Top  = loc_nTop
2969:         ENDIF
2970:     ENDPROC
2971: 
2972:     *==========================================================================
2973:     * KeyPress - "Lparameters nKeyCode, nShiftAltCtrl / If ThisForm.cntEntrega.
2974:     * cmdEntrega.Visible And (nKeyCode = -1) -> SetFocus + Keyboard '{ENTER}'
2975:     * NoDefault / If ThisForm.cmdEntrega.Visible And (nKeyCode = -2) ->
2976:     * SetFocus + Keyboard '{ENTER}' NoDefault" do legado - F2 aciona o botao
2977:     * "Local de Entrega" (cnt_4c_Entrega.cmd_4c_CmdEntrega) e F3 aciona o
2978:     * botao "Entrega" (obj_4c_CmdEntrega, Prazo de Entrega, Fase 4). Em vez
2979:     * de SetFocus + Keyboard '{ENTER}' (fragil em execucao headless/teste),
2980:     * chama o Click do botao direto - mesmo efeito observavel.
2981:     *
2982:     * KeyPreview = .T. (propriedade do Form, ver cabecalho da classe) faz o
2983:     * Form receber o KeyPress ANTES dos controles - exigido para capturar
2984:     * F2/F3 em qualquer campo focado, como no legado.
2985:     *==========================================================================
2986:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2987:         IF PEMSTATUS(THIS, "cnt_4c_Entrega", 5) AND VARTYPE(THIS.cnt_4c_Entrega) = "O"
2988:             IF THIS.cnt_4c_Entrega.cmd_4c_CmdEntrega.Visible AND par_nKeyCode = -1
2989:                 THIS.EntregaLocalClick()
2990:                 NODEFAULT
2991:                 RETURN
2992:             ENDIF
2993:         ENDIF
2994: 
2995:         IF PEMSTATUS(THIS, "obj_4c_CmdEntrega", 5) AND VARTYPE(THIS.obj_4c_CmdEntrega) = "O"
2996:             IF THIS.obj_4c_CmdEntrega.Visible AND par_nKeyCode = -2
2997:                 THIS.CmdEntregaClick()
2998:                 NODEFAULT
2999:             ENDIF
3000:         ENDIF
3001:     ENDPROC
3002: 
3003:     *==========================================================================


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

