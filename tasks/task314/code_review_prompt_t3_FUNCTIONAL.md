# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_GRADE. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprnfe.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2200 linhas total):

*-- Linhas 29 a 201:
29:     this_cMensagemErro = ""
30: 
31:     *==========================================================================
32:     PROCEDURE Init(par_cMovimentacao, par_cSerie, par_cOperas)
33:     *==========================================================================
34:         LOCAL loc_lResultado, loc_oErro
35:         loc_lResultado = .F.
36:         TRY
37:             THIS.this_oBusinessObject = CREATEOBJECT("sigprnfeBO")
38:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
39:                 MsgErro("Erro ao criar sigprnfeBO.", ;
40:                         "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
41:                 loc_lResultado = .F.
42:             ELSE
43:                 IF VARTYPE(par_cMovimentacao) = "C"
44:                     THIS.pMovimentacao = ALLTRIM(par_cMovimentacao)
45:                 ENDIF
46:                 IF VARTYPE(par_cSerie) = "C"
47:                     THIS.pSerie = ALLTRIM(par_cSerie)
48:                 ENDIF
49:                 loc_lResultado = DODEFAULT()
50:             ENDIF
51:         CATCH TO loc_oErro
52:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
53:                     "Erro Init")
54:         ENDTRY
55:         RETURN loc_lResultado
56:     ENDPROC
57: 
58:     *==========================================================================
59:     PROCEDURE InicializarForm()
60:     *==========================================================================
61:         LOCAL loc_lSucesso, loc_oErro
62:         loc_lSucesso = .F.
63:         THIS.Caption = "Processamento de NF-e"
64:         TRY
65:             SET NULL ON
66:             IF USED("csOperacoes")
67:                 USE IN csOperacoes
68:             ENDIF
69:             CREATE CURSOR csOperacoes (SelImp l(1), Emps c(3), Dopes c(20), ;
70:                 Numes n(6,0), Datas d(8), Valos n(12,2), Notas c(10), Series c(3), ;
71:                 NFMemo m(4), Erros m(4), Tipos n(1), stats c(3), ids c(47), ;
72:                 lotes c(15), recibos c(15), prots c(15), statts c(1))
73:             INDEX ON Notas+Emps+Dopes+STR(Numes,6) TAG Notas
74:             SET NULL OFF
75: 
76:             THIS.ConfigurarPageFrame()
77:             THIS.ConfigurarCabecalho()
78:             THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
79:             THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
80:             THIS.ConfigurarOperacoes()
81:             THIS.ConfigurarGrade()
82:             THIS.ConfigurarBotoesForm()
83:             THIS.ConfigurarBotoesGrade()
84:             THIS.ConfigurarCntInu()
85:             THIS.TornarControlesVisiveis()
86:             THIS.ConfigurarBINDEVENTs()
87: 
88:             IF !EMPTY(THIS.pMovimentacao)
89:                 THIS.BtnSelecionarClick(.T.)
90:             ENDIF
91: 
92:             loc_lSucesso = .T.
93:         CATCH TO loc_oErro
94:             THIS.this_cMensagemErro = loc_oErro.Message
95:             MsgErro(loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
96:                     " | Proc: " + loc_oErro.Procedure, ;
97:                     "Erro ao inicializar form")
98:         ENDTRY
99:         RETURN loc_lSucesso
100:     ENDPROC
101: 
102:     *==========================================================================
103:     PROTECTED PROCEDURE ConfigurarPageFrame()
104:     *==========================================================================
105:         LOCAL loc_cImg
106:         loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
107:         IF FILE(loc_cImg)
108:             THIS.Picture = loc_cImg
109:         ENDIF
110:     ENDPROC
111: 
112:     *==========================================================================
113:     PROTECTED PROCEDURE ConfigurarCabecalho()
114:     *==========================================================================
115:         LOCAL loc_cCaption, loc_oCnt
116:         loc_cCaption = "Processamento de NF-e"
117:         THIS.AddObject("cnt_4c_Sombra", "Container")
118:         loc_oCnt = THIS.cnt_4c_Sombra
119:         WITH loc_oCnt
120:             .Top         = 0
121:             .Left        = 0
122:             .Width       = 1004
123:             .Height      = 80
124:             .BorderWidth = 0
125:             .BackStyle   = 1
126:             .BackColor   = RGB(100, 100, 100)
127:         ENDWITH
128:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
129:         WITH loc_oCnt.lbl_4c_Sombra
130:             .AutoSize  = .F.
131:             .FontBold  = .T.
132:             .FontName  = "Tahoma"
133:             .FontSize  = 18
134:             .WordWrap  = .T.
135:             .BackStyle = 0
136:             .ForeColor = RGB(0, 0, 0)
137:             .Caption   = loc_cCaption
138:             .Height    = 40
139:             .Left      = 10
140:             .Top       = 18
141:             .Width     = THIS.Width
142:         ENDWITH
143:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
144:         WITH loc_oCnt.lbl_4c_Titulo
145:             .AutoSize  = .F.
146:             .FontBold  = .T.
147:             .FontName  = "Tahoma"
148:             .FontSize  = 18
149:             .WordWrap  = .T.
150:             .BackStyle = 0
151:             .ForeColor = RGB(255, 255, 255)
152:             .Caption   = loc_cCaption
153:             .Height    = 46
154:             .Left      = 10
155:             .Top       = 17
156:             .Width     = THIS.Width
157:         ENDWITH
158:     ENDPROC
159: 
160:     *==========================================================================
161:     PROTECTED PROCEDURE ConfigurarOperacoes()
162:     *==========================================================================
163:         LOCAL loc_oCnt, loc_oOpt
164: 
165:         THIS.AddObject("cnt_4c_Operacoes", "Container")
166:         loc_oCnt = THIS.cnt_4c_Operacoes
167:         WITH loc_oCnt
168:             .Top         = 83
169:             .Left        = 4
170:             .Width       = 824
171:             .Height      = 161
172:             .BorderWidth = 1
173:             .BackStyle   = 1
174:             .BackColor   = RGB(240, 240, 240)
175:         ENDWITH
176: 
177:         *-- Labels descritivos
178:         loc_oCnt.AddObject("lbl_4c_LblEmpresa", "Label")
179:         WITH loc_oCnt.lbl_4c_LblEmpresa
180:             .AutoSize  = .F.
181:             .BackStyle = 0
182:             .Caption   = "Empresa :"
183:             .FontName  = "Tahoma"
184:             .FontSize  = 8
185:             .Height    = 15
186:             .Left      = 35
187:             .Top       = 6
188:             .Width     = 55
189:         ENDWITH
190: 
191:         loc_oCnt.AddObject("lbl_4c_LblSerie", "Label")
192:         WITH loc_oCnt.lbl_4c_LblSerie
193:             .AutoSize  = .F.
194:             .BackStyle = 0
195:             .Caption   = "S" + CHR(233) + "rie :"
196:             .FontName  = "Tahoma"
197:             .FontSize  = 8
198:             .Height    = 15
199:             .Left      = 135
200:             .Top       = 6
201:             .Width     = 40

*-- Linhas 543 a 711:
543:             .Visible = .F.
544:         ENDWITH
545: 
546:         *-- OptionGroups com WITH ANINHADO
547:         loc_oCnt.AddObject("opt_4c_Processados", "OptionGroup")
548:         loc_oOpt = loc_oCnt.opt_4c_Processados
549:         WITH loc_oOpt
550:             .ButtonCount = 2
551:             .Top         = 83
552:             .Left        = 89
553:             .Width       = 235
554:             .Height      = 17
555:             .BackStyle   = 0
556:             .BorderStyle = 0
557:             .Value       = 1
558:             WITH .Buttons(1)
559:                 .Caption   = "N" + CHR(227) + "o Processados"
560:                 .Width     = 115
561:                 .Left      = 0
562:                 .FontName  = "Tahoma"
563:                 .FontSize  = 8
564:                 .BackStyle = 0
565:             ENDWITH
566:             WITH .Buttons(2)
567:                 .Caption   = "J" + CHR(225) + " Processados"
568:                 .Width     = 115
569:                 .Left      = 118
570:                 .FontName  = "Tahoma"
571:                 .FontSize  = 8
572:                 .BackStyle = 0
573:             ENDWITH
574:         ENDWITH
575: 
576:         loc_oCnt.AddObject("opt_4c_Tipos", "OptionGroup")
577:         loc_oOpt = loc_oCnt.opt_4c_Tipos
578:         WITH loc_oOpt
579:             .ButtonCount = 2
580:             .Top         = 6
581:             .Left        = 590
582:             .Width       = 142
583:             .Height      = 15
584:             .BackStyle   = 0
585:             .BorderStyle = 0
586:             .Value       = 1
587:             WITH .Buttons(1)
588:                 .Caption   = "Sa" + CHR(237) + "da"
589:                 .Width     = 65
590:                 .Left      = 0
591:                 .FontName  = "Tahoma"
592:                 .FontSize  = 8
593:                 .BackStyle = 0
594:             ENDWITH
595:             WITH .Buttons(2)
596:                 .Caption   = "Entrada"
597:                 .Width     = 65
598:                 .Left      = 68
599:                 .FontName  = "Tahoma"
600:                 .FontSize  = 8
601:                 .BackStyle = 0
602:             ENDWITH
603:         ENDWITH
604: 
605:         loc_oCnt.AddObject("opt_4c_Ambiente", "OptionGroup")
606:         loc_oOpt = loc_oCnt.opt_4c_Ambiente
607:         WITH loc_oOpt
608:             .ButtonCount = 2
609:             .Top         = 54
610:             .Left        = 89
611:             .Width       = 173
612:             .Height      = 25
613:             .BackStyle   = 0
614:             .BorderStyle = 0
615:             .Value       = 1
616:             WITH .Buttons(1)
617:                 .Caption   = "Produ" + CHR(231) + CHR(227) + "o"
618:                 .Width     = 85
619:                 .Left      = 0
620:                 .FontName  = "Tahoma"
621:                 .FontSize  = 8
622:                 .BackStyle = 0
623:             ENDWITH
624:             WITH .Buttons(2)
625:                 .Caption   = "Homologa" + CHR(231) + CHR(227) + "o"
626:                 .Width     = 85
627:                 .Left      = 88
628:                 .FontName  = "Tahoma"
629:                 .FontSize  = 8
630:                 .BackStyle = 0
631:             ENDWITH
632:         ENDWITH
633: 
634:         loc_oCnt.AddObject("opt_4c_Impressao", "OptionGroup")
635:         loc_oOpt = loc_oCnt.opt_4c_Impressao
636:         WITH loc_oOpt
637:             .ButtonCount = 3
638:             .Top         = 59
639:             .Left        = 569
640:             .Width       = 151
641:             .Height      = 15
642:             .BackStyle   = 0
643:             .BorderStyle = 0
644:             .Value       = 1
645:             WITH .Buttons(1)
646:                 .Caption   = "Retrato"
647:                 .Width     = 48
648:                 .Left      = 0
649:                 .FontName  = "Tahoma"
650:                 .FontSize  = 8
651:                 .BackStyle = 0
652:             ENDWITH
653:             WITH .Buttons(2)
654:                 .Caption   = "Paisagem"
655:                 .Width     = 55
656:                 .Left      = 50
657:                 .FontName  = "Tahoma"
658:                 .FontSize  = 8
659:                 .BackStyle = 0
660:             ENDWITH
661:             WITH .Buttons(3)
662:                 .Caption   = "Sem"
663:                 .Width     = 44
664:                 .Left      = 107
665:                 .FontName  = "Tahoma"
666:                 .FontSize  = 8
667:                 .BackStyle = 0
668:             ENDWITH
669:         ENDWITH
670: 
671:         loc_oCnt.AddObject("opt_4c_Acao", "OptionGroup")
672:         loc_oOpt = loc_oCnt.opt_4c_Acao
673:         WITH loc_oOpt
674:             .ButtonCount = 7
675:             .Top         = 101
676:             .Left        = 92
677:             .Width       = 397
678:             .Height      = 38
679:             .BackStyle   = 0
680:             .BorderStyle = 0
681:             .Value       = 1
682:             WITH .Buttons(1)
683:                 .Caption   = "Enviar"
684:                 .Width     = 55
685:                 .Left      = 0
686:                 .FontName  = "Tahoma"
687:                 .FontSize  = 8
688:                 .BackStyle = 0
689:             ENDWITH
690:             WITH .Buttons(2)
691:                 .Caption   = "Consultar"
692:                 .Width     = 60
693:                 .Left      = 57
694:                 .FontName  = "Tahoma"
695:                 .FontSize  = 8
696:                 .BackStyle = 0
697:             ENDWITH
698:             WITH .Buttons(3)
699:                 .Caption   = "Cancelar"
700:                 .Width     = 58
701:                 .Left      = 119
702:                 .FontName  = "Tahoma"
703:                 .FontSize  = 8
704:                 .BackStyle = 0
705:             ENDWITH
706:             WITH .Buttons(4)
707:                 .Caption   = "Inutilizar"
708:                 .Width     = 60
709:                 .Left      = 179
710:                 .FontName  = "Tahoma"
711:                 .FontSize  = 8

*-- Linhas 737 a 819:
737:             ENDWITH
738:         ENDWITH
739: 
740:         loc_oCnt.AddObject("opt_4c_Contin", "OptionGroup")
741:         loc_oOpt = loc_oCnt.opt_4c_Contin
742:         WITH loc_oOpt
743:             .ButtonCount = 3
744:             .Top         = 140
745:             .Left        = 92
746:             .Width       = 258
747:             .Height      = 21
748:             .BackStyle   = 0
749:             .BorderStyle = 0
750:             .Value       = 1
751:             WITH .Buttons(1)
752:                 .Caption   = "Nenhuma"
753:                 .Width     = 75
754:                 .Left      = 0
755:                 .FontName  = "Tahoma"
756:                 .FontSize  = 8
757:                 .BackStyle = 0
758:             ENDWITH
759:             WITH .Buttons(2)
760:                 .Caption   = "EPEC"
761:                 .Width     = 52
762:                 .Left      = 77
763:                 .FontName  = "Tahoma"
764:                 .FontSize  = 8
765:                 .BackStyle = 0
766:             ENDWITH
767:             WITH .Buttons(3)
768:                 .Caption   = "SCAN/SVC"
769:                 .Width     = 75
770:                 .Left      = 131
771:                 .FontName  = "Tahoma"
772:                 .FontSize  = 8
773:                 .BackStyle = 0
774:             ENDWITH
775:         ENDWITH
776:     ENDPROC
777: 
778:     *==========================================================================
779:     PROTECTED PROCEDURE ConfigurarGrade()
780:     *==========================================================================
781:         LOCAL loc_oCnt, loc_oGrd
782: 
783:         THIS.AddObject("cnt_4c_Grade", "Container")
784:         loc_oCnt = THIS.cnt_4c_Grade
785:         WITH loc_oCnt
786:             .Top         = 247
787:             .Left        = 50
788:             .Width       = 820
789:             .Height      = 344
790:             .BorderWidth = 1
791:             .BackStyle   = 1
792:             .BackColor   = RGB(220, 220, 220)
793:         ENDWITH
794: 
795:         loc_oCnt.AddObject("grd_4c_Operacoes", "Grid")
796:         loc_oGrd = loc_oCnt.grd_4c_Operacoes
797:         WITH loc_oGrd
798:             .Top           = 1
799:             .Left          = 3
800:             .Width         = 813
801:             .Height        = 340
802:             .ColumnCount   = 9
803:             .RecordSource  = "csOperacoes"
804:             .ReadOnly      = .T.
805:             .GridLines     = 1
806:             .GridLineWidth = 1
807:             .HeaderHeight  = 22
808:             .RowHeight     = 20
809:             .DeleteMark    = .F.
810:             .RecordMark    = .F.
811:             .ScrollBars    = 3
812:             .FontName      = "Tahoma"
813:             .FontSize      = 8
814:         ENDWITH
815: 
816:         *-- Column1: selecao (CheckBox com Sparse=.F.)
817:         WITH loc_oGrd.Column1
818:             .Width         = 25
819:             .ReadOnly      = .F.

*-- Linhas 914 a 957:
914:     ENDPROC
915: 
916:     *==========================================================================
917:     PROTECTED PROCEDURE ConfigurarBotoesForm()
918:     *==========================================================================
919:         *-- Botao Selecionar
920:         THIS.AddObject("cmd_4c_Selecionar", "CommandButton")
921:         WITH THIS.cmd_4c_Selecionar
922:             .Top             = 83
923:             .Left            = 843
924:             .Width           = 75
925:             .Height          = 75
926:             .Caption         = "\<Selecionar"
927:             .Picture         = gc_4c_CaminhoIcones + "geral_buscar_60.jpg"
928:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_buscar_60.jpg"
929:             .PicturePosition = 7
930:             .FontName        = "Tahoma"
931:             .FontBold        = .T.
932:             .FontItalic      = .T.
933:             .FontSize        = 8
934:             .ForeColor       = RGB(90, 90, 90)
935:             .BackColor       = RGB(255, 255, 255)
936:             .Themes          = .T.
937:             .SpecialEffect   = 0
938:             .MousePointer    = 15
939:             .WordWrap        = .T.
940:             .AutoSize        = .F.
941:         ENDWITH
942: 
943:         *-- Botao Limpar (desabilitado ate selecionar)
944:         THIS.AddObject("cmd_4c_BtnLimpar", "CommandButton")
945:         WITH THIS.cmd_4c_BtnLimpar
946:             .Top             = 162
947:             .Left            = 843
948:             .Width           = 75
949:             .Height          = 37
950:             .Caption         = "Limpar"
951:             .Picture         = gc_4c_CaminhoIcones + "geral_apagar_26.jpg"
952:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_apagar_26.jpg"
953:             .PicturePosition = 13
954:             .FontName        = "Tahoma"
955:             .FontBold        = .T.
956:             .FontItalic      = .T.
957:             .FontSize        = 8

*-- Linhas 1013 a 1056:
1013:     ENDPROC
1014: 
1015:     *==========================================================================
1016:     PROTECTED PROCEDURE ConfigurarBotoesGrade()
1017:     *==========================================================================
1018:         THIS.AddObject("cmd_4c_MarcaTudo", "CommandButton")
1019:         WITH THIS.cmd_4c_MarcaTudo
1020:             .Top             = 264
1021:             .Left            = 873
1022:             .Width           = 75
1023:             .Height          = 55
1024:             .Caption         = "Marca Tudo"
1025:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1026:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1027:             .PicturePosition = 13
1028:             .FontName        = "Tahoma"
1029:             .FontBold        = .T.
1030:             .FontItalic      = .T.
1031:             .FontSize        = 8
1032:             .ForeColor       = RGB(90, 90, 90)
1033:             .BackColor       = RGB(255, 255, 255)
1034:             .Themes          = .T.
1035:             .SpecialEffect   = 0
1036:             .MousePointer    = 15
1037:             .Enabled         = .F.
1038:         ENDWITH
1039: 
1040:         THIS.AddObject("cmd_4c_Desmarcar", "CommandButton")
1041:         WITH THIS.cmd_4c_Desmarcar
1042:             .Top             = 322
1043:             .Left            = 873
1044:             .Width           = 75
1045:             .Height          = 55
1046:             .Caption         = "Desmarcar"
1047:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1048:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1049:             .PicturePosition = 13
1050:             .FontName        = "Tahoma"
1051:             .FontBold        = .T.
1052:             .FontItalic      = .T.
1053:             .FontSize        = 8
1054:             .ForeColor       = RGB(90, 90, 90)
1055:             .BackColor       = RGB(255, 255, 255)
1056:             .Themes          = .T.

*-- Linhas 1105 a 1148:
1105:     ENDPROC
1106: 
1107:     *==========================================================================
1108:     PROTECTED PROCEDURE ConfigurarCntInu()
1109:     *==========================================================================
1110:         LOCAL loc_oCnt, loc_oGrd
1111: 
1112:         THIS.AddObject("cnt_4c_Inu", "Container")
1113:         loc_oCnt = THIS.cnt_4c_Inu
1114:         WITH loc_oCnt
1115:             .Top         = 156
1116:             .Left        = 203
1117:             .Width       = 504
1118:             .Height      = 392
1119:             .Visible     = .F.
1120:             .BorderWidth = 2
1121:             .BackStyle   = 1
1122:             .BackColor   = RGB(245, 245, 245)
1123:         ENDWITH
1124: 
1125:         loc_oCnt.AddObject("lbl_4c_TituloInu", "Label")
1126:         WITH loc_oCnt.lbl_4c_TituloInu
1127:             .AutoSize  = .F.
1128:             .Caption   = "Notas Fiscais para Inutilizar"
1129:             .FontName  = "Tahoma"
1130:             .FontSize  = 10
1131:             .FontBold  = .T.
1132:             .BackStyle = 0
1133:             .Height    = 20
1134:             .Left      = 10
1135:             .Top       = 5
1136:             .Width     = 380
1137:         ENDWITH
1138: 
1139:         loc_oCnt.AddObject("cmd_4c_BtnCancelaInu", "CommandButton")
1140:         WITH loc_oCnt.cmd_4c_BtnCancelaInu
1141:             .Top             = 28
1142:             .Left            = 408
1143:             .Width           = 75
1144:             .Height          = 75
1145:             .Caption         = "Encerrar"
1146:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1147:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1148:             .PicturePosition = 7

*-- Linhas 1252 a 1995:
1252:     ENDPROC
1253: 
1254:     *==========================================================================
1255:     * TornarControlesVisiveis: torna visiveis todos os controles de nivel raiz.
1256:     * cnt_4c_Inu e cmd_4c_Inu sao reocultados explicitamente apos o loop.
1257:     *==========================================================================
1258:     PROCEDURE TornarControlesVisiveis()
1259:         LOCAL loc_oErro, loc_oCtrl
1260:         TRY
1261:             FOR EACH loc_oCtrl IN THIS.Controls
1262:                 IF VARTYPE(loc_oCtrl) = "O"
1263:                     loc_oCtrl.Visible = .T.
1264:                 ENDIF
1265:             ENDFOR
1266:             IF PEMSTATUS(THIS, "cnt_4c_Inu", 5)
1267:                 THIS.cnt_4c_Inu.Visible = .F.
1268:             ENDIF
1269:             IF PEMSTATUS(THIS, "cnt_4c_Operacoes", 5)
1270:                 IF PEMSTATUS(THIS.cnt_4c_Operacoes, "cmd_4c_Inu", 5)
1271:                     THIS.cnt_4c_Operacoes.cmd_4c_Inu.Visible = .F.
1272:                 ENDIF
1273:             ENDIF
1274:         CATCH TO loc_oErro
1275:             MsgErro(loc_oErro.Message, "Erro TornarControlesVisiveis")
1276:         ENDTRY
1277:     ENDPROC
1278: 
1279:     *==========================================================================
1280:     * ConfigurarPaginaLista - Restaura visao principal do form OPERACIONAL
1281:     * (grade + botoes de acao + filtros) escondendo o painel flutuante de
1282:     * inutilizacao. Equivalente ao Page1=LISTA dos forms CRUD; chamado por
1283:     * AlternarPagina(1) e apos cada processamento para reset visual.
1284:     *==========================================================================
1285:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1286:         LOCAL loc_oErro
1287:         TRY
1288:             IF PEMSTATUS(THIS, "cnt_4c_Inu", 5)
1289:                 THIS.cnt_4c_Inu.Visible = .F.
1290:             ENDIF
1291:             IF PEMSTATUS(THIS, "cnt_4c_Operacoes", 5)
1292:                 THIS.cnt_4c_Operacoes.Visible = .T.
1293:             ENDIF
1294:             IF PEMSTATUS(THIS, "cnt_4c_Grade", 5)
1295:                 THIS.cnt_4c_Grade.Visible = .T.
1296:                 IF PEMSTATUS(THIS.cnt_4c_Grade, "grd_4c_Operacoes", 5)
1297:                     THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1298:                 ENDIF
1299:             ENDIF
1300:             IF PEMSTATUS(THIS, "cmd_4c_Selecionar", 5)
1301:                 THIS.cmd_4c_Selecionar.Enabled = .T.
1302:             ENDIF
1303:         CATCH TO loc_oErro
1304:             MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaLista")
1305:         ENDTRY
1306:     ENDPROC
1307: 
1308:     *==========================================================================
1309:     * ConfigurarPaginaDados - Exibe painel flutuante de inutilizacao (overlay)
1310:     * Form OPERACIONAL nao possui PageFrame; cnt_4c_Inu atua como "Page2=Dados"
1311:     * para captura da grade de inutilizacao. Chamado por AlternarPagina(2) e
1312:     * CmdInuClick apos SelecionarInutilizadas popular csInutil. Refresh() garante
1313:     * repaint do grid apos GO TOP e cursor recem-carregado.
1314:     *==========================================================================
1315:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1316:         LOCAL loc_oErro
1317:         TRY
1318:             IF PEMSTATUS(THIS, "cnt_4c_Inu", 5)
1319:                 THIS.cnt_4c_Inu.Visible = .T.
1320:                 IF PEMSTATUS(THIS.cnt_4c_Inu, "grd_4c_Inu", 5)
1321:                     IF USED("csInutil")
1322:                         THIS.cnt_4c_Inu.grd_4c_Inu.RecordSource = "csInutil"
1323:                     ENDIF
1324:                     THIS.cnt_4c_Inu.grd_4c_Inu.Refresh()
1325:                 ENDIF
1326:                 IF PEMSTATUS(THIS.cnt_4c_Inu, "cmd_4c_BtnProcInu", 5)
1327:                     THIS.cnt_4c_Inu.cmd_4c_BtnProcInu.Enabled = ;
1328:                         (USED("csInutil") AND RECCOUNT("csInutil") > 0)
1329:                 ENDIF
1330:                 THIS.cnt_4c_Inu.ZOrder(0)
1331:             ENDIF
1332:         CATCH TO loc_oErro
1333:             MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaDados")
1334:         ENDTRY
1335:     ENDPROC
1336: 
1337:     *==========================================================================
1338:     * AlternarPagina - Alterna entre visao principal (1) e overlay Inutilizar (2)
1339:     * Form OPERACIONAL nao possui PageFrame; usa cnt_4c_Inu como painel flutuante
1340:     * que funciona logicamente como uma "segunda pagina" para captura de dados
1341:     * de inutilizacao. par_nPagina = 1 restaura visao principal; = 2 abre overlay.
1342:     *==========================================================================
1343:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1344:         LOCAL loc_nPag, loc_oErro
1345:         loc_nPag = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
1346:         TRY
1347:             DO CASE
1348:                 CASE loc_nPag = 2
1349:                     THIS.ConfigurarPaginaDados()
1350:                 OTHERWISE
1351:                     THIS.ConfigurarPaginaLista()
1352:             ENDCASE
1353:         CATCH TO loc_oErro
1354:             MsgErro(loc_oErro.Message, "Erro AlternarPagina")
1355:         ENDTRY
1356:     ENDPROC
1357: 
1358:     *==========================================================================
1359:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
1360:     *==========================================================================
1361:         LOCAL loc_oGrd
1362:         BINDEVENT(THIS.cmd_4c_Selecionar, "Click", THIS, "BtnSelecionarClick")
1363:         BINDEVENT(THIS.cmd_4c_BtnLimpar,  "Click", THIS, "BtnLimparClick")
1364:         BINDEVENT(THIS.cmd_4c_BtnCopiar,  "Click", THIS, "BtnCopiarClick")
1365:         BINDEVENT(THIS.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
1366:         BINDEVENT(THIS.cmd_4c_MarcaTudo,  "Click", THIS, "BtnMarcaTudoClick")
1367:         BINDEVENT(THIS.cmd_4c_Desmarcar,  "Click", THIS, "BtnDesmarcarClick")
1368:         BINDEVENT(THIS.cmd_4c_Documentos, "Click", THIS, "BtnDocumentosClick")
1369:         BINDEVENT(THIS.cmd_4c_ImpDSimpl,  "Click", THIS, "BtnImpDSimplClick")
1370:         BINDEVENT(THIS.cnt_4c_Inu.cmd_4c_BtnCancelaInu, "Click", THIS, "BtnCancelaInuClick")
1371:         BINDEVENT(THIS.cnt_4c_Inu.cmd_4c_BtnProcInu,    "Click", THIS, "BtnProcInuClick")
1372:         BINDEVENT(THIS.cnt_4c_Operacoes.txt_4c_Emps,    "KeyPress", THIS, "EmpsLostFocus")
1373:         BINDEVENT(THIS.cnt_4c_Operacoes.txt_4c_Series,  "KeyPress", THIS, "SeriesLostFocus")
1374:         BINDEVENT(THIS.cnt_4c_Operacoes.opt_4c_Acao, "InteractiveChange", THIS, "AcaoInteractiveChange")
1375:         BINDEVENT(THIS.cnt_4c_Operacoes.cmd_4c_Inu,  "Click", THIS, "CmdInuClick")
1376:         loc_oGrd = THIS.cnt_4c_Grade.grd_4c_Operacoes
1377:         BINDEVENT(loc_oGrd.Column1.chk_4c_SelImp, "MouseUp",  THIS, "GridChkMouseUp")
1378:         BINDEVENT(loc_oGrd.Column1.chk_4c_SelImp, "KeyPress", THIS, "GridChkKeyPress")
1379:     ENDPROC
1380: 
1381:     *==========================================================================
1382:     * HANDLERS DE EVENTOS
1383:     *==========================================================================
1384: 
1385:     PROCEDURE BtnSelecionarClick
1386:         LPARAMETERS par_lForcado
1387:         LOCAL loc_cEmps, loc_cSeries, loc_dDtIni, loc_dDtFin
1388:         LOCAL loc_nProcessados, loc_nTipos, loc_nAcao
1389:         LOCAL loc_cInuIni, loc_cInuFim, loc_oBO, loc_oErro, loc_lSelOk
1390: 
1391:         loc_oBO = THIS.this_oBusinessObject
1392: 
1393:         loc_cEmps        = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
1394:         loc_cSeries      = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3)
1395:         loc_dDtIni       = THIS.cnt_4c_Operacoes.txt_4c_DtIni.Value
1396:         loc_dDtFin       = THIS.cnt_4c_Operacoes.txt_4c_DtFin.Value
1397:         loc_nProcessados = THIS.cnt_4c_Operacoes.opt_4c_Processados.Value
1398:         loc_nTipos       = THIS.cnt_4c_Operacoes.opt_4c_Tipos.Value
1399:         loc_nAcao        = THIS.cnt_4c_Operacoes.opt_4c_Acao.Value
1400:         loc_cInuIni      = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuIni.Value)
1401:         loc_cInuFim      = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuFim.Value)
1402: 
1403:         IF VARTYPE(par_lForcado) != "L" OR !par_lForcado
1404:             IF loc_nProcessados = 2
1405:                 IF !MsgConfirma("Confirma a Sele" + CHR(231) + CHR(227) + "o de Opera" + ;
1406:                                 CHR(231) + CHR(245) + "es J" + CHR(225) + " Processadas Anteriormente?")
1407:                     THIS.cnt_4c_Operacoes.opt_4c_Processados.Value = 1
1408:                     RETURN
1409:                 ENDIF
1410:             ENDIF
1411:         ENDIF
1412: 
1413:         IF EMPTY(ALLTRIM(loc_cEmps))
1414:             MsgAviso("A Empresa N" + CHR(227) + "o Foi Informada!!!")
1415:             THIS.cnt_4c_Operacoes.txt_4c_Emps.SetFocus()
1416:             RETURN
1417:         ENDIF
1418:         IF EMPTY(loc_dDtIni)
1419:             MsgAviso("A Data Inicial N" + CHR(227) + "o Foi Informada!!!")
1420:             THIS.cnt_4c_Operacoes.txt_4c_DtIni.SetFocus()
1421:             RETURN
1422:         ENDIF
1423:         IF EMPTY(loc_dDtFin)
1424:             MsgAviso("A Data Final N" + CHR(227) + "o Foi Informada!!!")
1425:             THIS.cnt_4c_Operacoes.txt_4c_DtFin.SetFocus()
1426:             RETURN
1427:         ENDIF
1428:         IF loc_dDtFin < loc_dDtIni
1429:             MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!")
1430:             THIS.cnt_4c_Operacoes.txt_4c_DtFin.SetFocus()
1431:             RETURN
1432:         ENDIF
1433:         IF INLIST(loc_nAcao, 4, 7)
1434:             IF (loc_cInuFim < loc_cInuIni) OR EMPTY(loc_cInuFim) OR EMPTY(loc_cInuIni)
1435:                 MsgAviso("A Numera" + CHR(231) + CHR(227) + "o informada est" + CHR(225) + " inconsistente!!!")
1436:                 THIS.cnt_4c_Operacoes.txt_4c_InuFim.SetFocus()
1437:                 RETURN
1438:             ENDIF
1439:         ENDIF
1440: 
1441:         loc_oBO.this_cEmps        = loc_cEmps
1442:         loc_oBO.this_cSeries      = loc_cSeries
1443:         loc_oBO.this_dDtIni       = loc_dDtIni
1444:         loc_oBO.this_dDtFin       = loc_dDtFin
1445:         loc_oBO.this_nProcessados = loc_nProcessados
1446:         loc_oBO.this_nTipos       = loc_nTipos
1447:         loc_oBO.this_nAcao        = loc_nAcao
1448:         loc_oBO.this_cInuIni      = loc_cInuIni
1449:         loc_oBO.this_cInuFim      = loc_cInuFim
1450: 
1451:         loc_lSelOk = .T.
1452:         TRY
1453:             loc_oBO.Selecionar("csOperacoes")
1454:         CATCH TO loc_oErro
1455:             MsgErro(loc_oErro.Message, "Erro Selecionar")
1456:             loc_lSelOk = .F.
1457:         ENDTRY
1458:         IF !loc_lSelOk
1459:             RETURN
1460:         ENDIF
1461: 
1462:         THIS.HabilitarControles(.F.)
1463: 
1464:         SELECT csOperacoes
1465:         SET ORDER TO Notas
1466:         GO TOP IN csOperacoes
1467:         IF EOF("csOperacoes")
1468:             IF INLIST(loc_nAcao, 1, 2, 3, 5)
1469:                 MsgAviso("Nenhuma Nota Foi Encontrada Para Processamento!!!")
1470:                 THIS.LimpaSelecao()
1471:                 THIS.cnt_4c_Operacoes.txt_4c_Series.SetFocus()
1472:             ENDIF
1473:         ELSE
1474:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1475:         ENDIF
1476:     ENDPROC
1477: 
1478:     PROCEDURE BtnLimparClick()
1479:         THIS.LimpaSelecao()
1480:     ENDPROC
1481: 
1482:     PROCEDURE BtnCopiarClick()
1483:         LOCAL loc_nAcao, loc_nSel, loc_oBO, loc_oErro
1484:         loc_nAcao = THIS.cnt_4c_Operacoes.opt_4c_Acao.Value
1485:         IF INLIST(loc_nAcao, 1, 2, 3, 5, 6)
1486:             IF USED("cursor_4c_SelChk")
1487:                 USE IN cursor_4c_SelChk
1488:             ENDIF
1489:             SELECT COUNT(*) AS nSel FROM csOperacoes WHERE SelImp INTO CURSOR cursor_4c_SelChk
1490:             loc_nSel = cursor_4c_SelChk.nSel
1491:             USE IN cursor_4c_SelChk
1492:             IF loc_nSel < 1
1493:                 MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Selecionado para Processamento!!!")
1494:                 THIS.cnt_4c_Grade.grd_4c_Operacoes.SetFocus()
1495:                 RETURN
1496:             ENDIF
1497:         ENDIF
1498:         loc_oBO = THIS.this_oBusinessObject
1499:         loc_oBO.this_nAcao      = loc_nAcao
1500:         loc_oBO.this_nAmbiente  = THIS.cnt_4c_Operacoes.opt_4c_Ambiente.Value
1501:         loc_oBO.this_nTipos     = THIS.cnt_4c_Operacoes.opt_4c_Tipos.Value
1502:         loc_oBO.this_nImpressao = THIS.cnt_4c_Operacoes.opt_4c_Impressao.Value
1503:         loc_oBO.this_nContin    = THIS.cnt_4c_Operacoes.opt_4c_Contin.Value
1504:         loc_oBO.this_cArquivos  = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Arquivos.Value)
1505:         loc_oBO.this_lHVerao    = (THIS.cnt_4c_Operacoes.chk_4c_HVerao.Value = 1)
1506:         loc_oBO.this_lVenc      = (THIS.cnt_4c_Operacoes.chk_4c_Venc.Value = 1)
1507:         loc_oBO.this_lOptSub    = (THIS.cnt_4c_Operacoes.chk_4c_OptSub.Value = 1)
1508:         loc_oBO.this_lOptArq    = (THIS.cnt_4c_Operacoes.chk_4c_OptArq.Value = 1)
1509:         TRY
1510:             loc_oBO.Processamento( ;
1511:                 PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3), ;
1512:                 PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3))
1513:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1514:         CATCH TO loc_oErro
1515:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1516:                     "Erro Processar")
1517:         ENDTRY
1518:     ENDPROC
1519: 
1520:     PROCEDURE BtnEncerrarClick()
1521:         THIS.Release()
1522:     ENDPROC
1523: 
1524:     PROCEDURE BtnMarcaTudoClick()
1525:         IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
1526:             SELECT csOperacoes
1527:             REPLACE ALL SelImp WITH .T.
1528:             GO TOP IN csOperacoes
1529:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1530:         ENDIF
1531:     ENDPROC
1532: 
1533:     PROCEDURE BtnDesmarcarClick()
1534:         IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
1535:             SELECT csOperacoes
1536:             REPLACE ALL SelImp WITH .F.
1537:             GO TOP IN csOperacoes
1538:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1539:         ENDIF
1540:     ENDPROC
1541: 
1542:     PROCEDURE BtnDocumentosClick()
1543:         LOCAL loc_cDopes, loc_nNumes, loc_cEmps, loc_oForm, loc_oErro
1544:         IF !USED("csOperacoes") OR EOF("csOperacoes")
1545:             MsgAviso("Posicione o cursor em um registro.")
1546:             RETURN
1547:         ENDIF
1548:         SELECT csOperacoes
1549:         loc_cDopes = ALLTRIM(csOperacoes.Dopes)
1550:         loc_nNumes = csOperacoes.Numes
1551:         loc_cEmps  = ALLTRIM(csOperacoes.Emps)
1552:         TRY
1553:             loc_oForm = CREATEOBJECT("Formsigmvexp", loc_cDopes, "C", loc_nNumes, loc_cEmps)
1554:             IF VARTYPE(loc_oForm) = "O"
1555:                 loc_oForm.Show()
1556:             ELSE
1557:                 MsgErro("Erro ao criar Formsigmvexp. VARTYPE retornou: " + ;
1558:                         VARTYPE(loc_oForm), "Documentos")
1559:             ENDIF
1560:         CATCH TO loc_oErro
1561:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1562:                     "Erro ao abrir Documentos")
1563:         ENDTRY
1564:     ENDPROC
1565: 
1566:     PROCEDURE BtnImpDSimplClick()
1567:         LOCAL loc_oBO, loc_oErro
1568:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
1569:             MsgAviso("Nenhuma nota encontrada para impress" + CHR(227) + "o.")
1570:             RETURN
1571:         ENDIF
1572:         loc_oBO = THIS.this_oBusinessObject
1573:         TRY
1574:             loc_oBO.ImprimirSimplificado("csOperacoes")
1575:         CATCH TO loc_oErro
1576:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1577:                     "Erro Impress" + CHR(227) + "o")
1578:         ENDTRY
1579:     ENDPROC
1580: 
1581:     PROCEDURE BtnCancelaInuClick()
1582:         THIS.AlternarPagina(1)
1583:     ENDPROC
1584: 
1585:     PROCEDURE BtnProcInuClick()
1586:         LOCAL loc_cEmps, loc_cSeries, loc_cCnpj, loc_cNIni, loc_cNFim, loc_oBO, loc_oErro
1587:         IF !INLIST(THIS.cnt_4c_Operacoes.opt_4c_Acao.Value, 4, 7)
1588:             MsgAviso("Selecione a a" + CHR(231) + CHR(227) + "o Inutilizar ou Status.")
1589:             RETURN
1590:         ENDIF
1591:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value))
1592:             MsgAviso("Empresa n" + CHR(227) + "o informada.")
1593:             RETURN
1594:         ENDIF
1595:         IF !USED("csInutil") OR RECCOUNT("csInutil") = 0
1596:             MsgAviso("Nenhuma nota fiscal para inutilizar.")
1597:             RETURN
1598:         ENDIF
1599:         loc_cEmps   = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
1600:         loc_cSeries = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3)
1601:         loc_cNIni   = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuIni.Value)
1602:         loc_cNFim   = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuFim.Value)
1603:         SELECT csInutil
1604:         GO TOP IN csInutil
1605:         loc_cCnpj = ALLTRIM(csInutil.cnpj)
1606:         loc_oBO = THIS.this_oBusinessObject
1607:         TRY
1608:             loc_oBO.ProcessaInutilizadas(loc_cEmps, loc_cSeries, loc_cCnpj, loc_cNIni, loc_cNFim)
1609:         CATCH TO loc_oErro
1610:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1611:                     "Erro Inutilizar")
1612:         ENDTRY
1613:         THIS.AlternarPagina(1)
1614:     ENDPROC
1615: 
1616:     PROCEDURE AcaoInteractiveChange()
1617:         IF PEMSTATUS(THIS.cnt_4c_Operacoes, "cmd_4c_Inu", 5)
1618:             THIS.cnt_4c_Operacoes.cmd_4c_Inu.Visible = ;
1619:                 INLIST(THIS.cnt_4c_Operacoes.opt_4c_Acao.Value, 4, 7)
1620:         ENDIF
1621:     ENDPROC
1622: 
1623:     PROCEDURE CmdInuClick()
1624:         LOCAL loc_cEmps, loc_oBO, loc_oErro
1625:         loc_cEmps = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
1626:         IF EMPTY(ALLTRIM(loc_cEmps))
1627:             MsgAviso("Informe a empresa antes de consultar inutiliza" + CHR(231) + CHR(245) + "es.")
1628:             RETURN
1629:         ENDIF
1630:         loc_oBO = THIS.this_oBusinessObject
1631:         TRY
1632:             *-- Carrega nfAinu com gap analysis via BO
1633:             loc_oBO.SelecionarInutilizadas(loc_cEmps)
1634:             IF USED("nfAinu")
1635:                 SELECT 1 AS nMarca, emps, series, notai, notaf, cnpj ;
1636:                     FROM nfAinu ;
1637:                     WHERE RTRIM(emps) = RTRIM(loc_cEmps) ;
1638:                     INTO CURSOR csInutil READWRITE
1639:                 IF USED("csInutil") AND RECCOUNT("csInutil") > 0
1640:                     GO TOP IN csInutil
1641:                     THIS.cnt_4c_Inu.grd_4c_Inu.RecordSource = "csInutil"
1642:                     THIS.cnt_4c_Inu.grd_4c_Inu.Refresh()
1643:                     THIS.AlternarPagina(2)
1644:                 ELSE
1645:                     MsgAviso("Nenhuma nota para inutilizar encontrada para esta empresa.")
1646:                 ENDIF
1647:             ELSE
1648:                 MsgAviso("Nenhuma nota para inutilizar encontrada.")
1649:             ENDIF
1650:         CATCH TO loc_oErro
1651:             MsgErro(loc_oErro.Message, "Erro CmdInu")
1652:         ENDTRY
1653:     ENDPROC
1654: 
1655:     PROCEDURE EmpsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1656:         IF !INLIST(par_nKeyCode, 9, 13, 115)
1657:             RETURN
1658:         ENDIF
1659:         IF par_nKeyCode = 115  && F4 - abrir picker direto
1660:             THIS.AbrirBuscaEmps()
1661:             RETURN
1662:         ENDIF
1663:         LOCAL loc_cEmps, loc_oBO, loc_oErro
1664:         loc_cEmps = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
1665:         IF EMPTY(ALLTRIM(loc_cEmps))
1666:             RETURN
1667:         ENDIF
1668:         loc_oBO = THIS.this_oBusinessObject
1669:         TRY
1670:             IF loc_oBO.CarregarEmpresa(ALLTRIM(loc_cEmps))
1671:                 THIS.PreencherRegimeEmpresa(loc_oBO)
1672:             ELSE
1673:                 THIS.AbrirBuscaEmps()
1674:             ENDIF
1675:         CATCH TO loc_oErro
1676:             MsgErro(loc_oErro.Message, "Erro ao carregar empresa")
1677:         ENDTRY
1678:     ENDPROC
1679: 
1680:     PROTECTED PROCEDURE PreencherRegimeEmpresa(par_oBO)
1681:         DO CASE
1682:             CASE par_oBO.this_nRegimeEmp = 1
1683:                 THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Simples Nacional"
1684:             CASE par_oBO.this_nRegimeEmp = 2
1685:                 THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Lucro Presumido"
1686:             CASE par_oBO.this_nRegimeEmp = 3
1687:                 THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Lucro Real"
1688:             CASE par_oBO.this_nRegimeEmp = 4
1689:                 THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Lucro Arbitrado"
1690:         ENDCASE
1691:         IF !EMPTY(par_oBO.this_cArquivos)
1692:             THIS.cnt_4c_Operacoes.txt_4c_Arquivos.Value = par_oBO.this_cArquivos
1693:         ENDIF
1694:     ENDPROC
1695: 
1696:     PROCEDURE AbrirBuscaEmps()
1697:         LOCAL loc_oBusca, loc_cCemps, loc_oBO, loc_oErro
1698:         TRY
1699:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1700:                 "SigCdEmp", ;
1701:                 "cursor_4c_BuscaEmp", ;
1702:                 "Cemps", ;
1703:                 ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), ;
1704:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
1705:                 .T., .T., "Ativas <> 2")
1706:             loc_oBusca.mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
1707:             loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
1708:             loc_oBusca.Show()
1709:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1710:                 loc_cCemps = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1711:                 THIS.cnt_4c_Operacoes.txt_4c_Emps.Value = loc_cCemps
1712:                 loc_oBO = THIS.this_oBusinessObject
1713:                 IF loc_oBO.CarregarEmpresa(loc_cCemps)
1714:                     THIS.PreencherRegimeEmpresa(loc_oBO)
1715:                 ENDIF
1716:             ENDIF
1717:         CATCH TO loc_oErro
1718:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaEmps")
1719:         ENDTRY
1720:         IF USED("cursor_4c_BuscaEmp")
1721:             USE IN cursor_4c_BuscaEmp
1722:         ENDIF
1723:         IF VARTYPE(loc_oBusca) = "O"
1724:             loc_oBusca.Release()
1725:         ENDIF
1726:     ENDPROC
1727: 
1728:     PROCEDURE SeriesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1729:         IF !INLIST(par_nKeyCode, 9, 13, 115)
1730:             RETURN
1731:         ENDIF
1732:         IF par_nKeyCode = 115  && F4 - abrir picker direto
1733:             THIS.AbrirBuscaSeries()
1734:             RETURN
1735:         ENDIF
1736:         LOCAL loc_cSeries, loc_nResult, loc_oErro
1737:         loc_cSeries = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value)
1738:         IF EMPTY(loc_cSeries)
1739:             RETURN
1740:         ENDIF
1741:         TRY
1742:             loc_nResult = SQLEXEC(gnConnHandle, ;
1743:                 "SELECT Cods FROM SigCdSer WHERE ImpNfs = 3 AND LTRIM(RTRIM(Cods)) = " + ;
1744:                 EscaparSQL(loc_cSeries), "cursor_4c_SerValid")
1745:             IF loc_nResult > 0 AND USED("cursor_4c_SerValid") AND !EOF("cursor_4c_SerValid")
1746:                 THIS.cnt_4c_Operacoes.txt_4c_Series.Value = ALLTRIM(cursor_4c_SerValid.Cods)
1747:             ELSE
1748:                 THIS.AbrirBuscaSeries()
1749:             ENDIF
1750:             IF USED("cursor_4c_SerValid")
1751:                 USE IN cursor_4c_SerValid
1752:             ENDIF
1753:         CATCH TO loc_oErro
1754:             MsgErro(loc_oErro.Message, "Erro ao validar s" + CHR(233) + "rie")
1755:         ENDTRY
1756:     ENDPROC
1757: 
1758:     PROCEDURE AbrirBuscaSeries()
1759:         LOCAL loc_oBusca, loc_cCods, loc_oErro
1760:         TRY
1761:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1762:                 "SigCdSer", ;
1763:                 "cursor_4c_BuscaSeries", ;
1764:                 "Cods", ;
1765:                 ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), ;
1766:                 "Sele" + CHR(231) + CHR(227) + "o de S" + CHR(233) + "rie", ;
1767:                 .T., .T., "ImpNfs = 3")
1768:             loc_oBusca.mAddColuna("Cods", "", "S" + CHR(233) + "rie")
1769:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1770:             loc_oBusca.Show()
1771:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSeries")
1772:                 loc_cCods = ALLTRIM(cursor_4c_BuscaSeries.Cods)
1773:                 THIS.cnt_4c_Operacoes.txt_4c_Series.Value = loc_cCods
1774:             ENDIF
1775:         CATCH TO loc_oErro
1776:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaSeries")
1777:         ENDTRY
1778:         IF USED("cursor_4c_BuscaSeries")
1779:             USE IN cursor_4c_BuscaSeries
1780:         ENDIF
1781:         IF VARTYPE(loc_oBusca) = "O"
1782:             loc_oBusca.Release()
1783:         ENDIF
1784:     ENDPROC
1785: 
1786:     *-- MouseUp no CheckBox de selecao: toggle SelImp do registro corrente
1787:     PROCEDURE GridChkMouseUp
1788:         LPARAMETERS par_nButton, par_nShift, par_nXCoord, par_nYCoord
1789:         IF USED("csOperacoes") AND !EOF("csOperacoes")
1790:             m.SelImp = (NOT csOperacoes.SelImp)
1791:             SELECT csOperacoes
1792:             GATHER MEMVAR FIELDS SelImp
1793:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1794:         ENDIF
1795:         NODEFAULT
1796:     ENDPROC
1797: 
1798:     *-- KeyPress no CheckBox de selecao: Enter/Space faz toggle
1799:     PROCEDURE GridChkKeyPress
1800:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1801:         IF INLIST(par_nKeyCode, 13, 32) AND USED("csOperacoes") AND !EOF("csOperacoes")
1802:             m.SelImp = (NOT csOperacoes.SelImp)
1803:             SELECT csOperacoes
1804:             GATHER MEMVAR FIELDS SelImp
1805:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1806:             NODEFAULT
1807:         ENDIF
1808:     ENDPROC
1809: 
1810:     PROCEDURE LimpaSelecao()
1811:         IF USED("csOperacoes")
1812:             ZAP IN csOperacoes
1813:         ENDIF
1814:         THIS.HabilitarControles(.T.)
1815:         THIS.cmd_4c_ImpDSimpl.Enabled = .F.
1816:         THIS.Refresh()
1817:     ENDPROC
1818: 
1819:     PROCEDURE HabilitarControles(par_lHabilitar)
1820:         WITH THIS.cnt_4c_Operacoes
1821:             .txt_4c_Emps.Enabled                   = par_lHabilitar
1822:             .txt_4c_Series.Enabled                 = par_lHabilitar
1823:             .txt_4c_DtIni.Enabled                  = par_lHabilitar
1824:             .txt_4c_DtFin.Enabled                  = par_lHabilitar
1825:             .txt_4c_InuIni.Enabled                 = par_lHabilitar
1826:             .txt_4c_InuFim.Enabled                 = par_lHabilitar
1827:             .cmb_4c_Regime.Enabled                 = par_lHabilitar
1828:             .opt_4c_Processados.Buttons(1).Enabled = par_lHabilitar
1829:             .opt_4c_Processados.Buttons(2).Enabled = par_lHabilitar
1830:             .Visible     = .T.
1831:         ENDWITH
1832:         THIS.cmd_4c_Selecionar.Enabled = par_lHabilitar
1833:         THIS.cmd_4c_BtnLimpar.Enabled  = !par_lHabilitar
1834:         THIS.cmd_4c_BtnCopiar.Enabled  = !par_lHabilitar
1835:         THIS.cmd_4c_MarcaTudo.Enabled  = !par_lHabilitar
1836:         THIS.cmd_4c_Desmarcar.Enabled  = !par_lHabilitar
1837:         THIS.cmd_4c_Documentos.Enabled = !par_lHabilitar
1838:         THIS.cmd_4c_ImpDSimpl.Enabled  = !par_lHabilitar
1839:     ENDPROC
1840: 
1841:     *==========================================================================
1842:     * Eventos CRUD adaptados ao contexto OPERACIONAL de processamento de NFe.
1843:     * Em forms de processamento fiscal, as semanticas CRUD tradicionais mapeiam
1844:     * para operacoes especificas do fluxo de trabalho de NFe.
1845:     *==========================================================================
1846: 
1847:     PROCEDURE BtnIncluirClick()
1848:         * Incluir notas fiscais na fila de processamento.
1849:         * No contexto NFe, "Incluir" equivale a Selecionar registros do banco
1850:         * (SigMvNfi) para o cursor csOperacoes segundo os filtros informados.
1851:         LOCAL loc_cEmps
1852:         loc_cEmps = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value)
1853:         IF EMPTY(loc_cEmps)
1854:             MsgAviso("Informe a Empresa antes de incluir notas na fila.")
1855:             THIS.cnt_4c_Operacoes.txt_4c_Emps.SetFocus()
1856:             RETURN
1857:         ENDIF
1858:         THIS.BtnSelecionarClick()
1859:     ENDPROC
1860: 
1861:     PROCEDURE BtnAlterarClick()
1862:         * Alterar dados fiscais da nota corrente. Abre Formsigmvexp
1863:         * (mesma janela usada pelo botao "Documentos" do grid) para
1864:         * edicao dos dados fiscais da NF apontada em csOperacoes.
1865:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
1866:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas na fila. Utilize Incluir primeiro.")
1867:             RETURN
1868:         ENDIF
1869:         SELECT csOperacoes
1870:         IF EOF("csOperacoes")
1871:             GO TOP IN csOperacoes
1872:         ENDIF
1873:         IF EMPTY(csOperacoes.Emps) OR EMPTY(csOperacoes.Dopes)
1874:             MsgAviso("Posicione o cursor sobre uma nota v" + CHR(225) + "lida.")
1875:             RETURN
1876:         ENDIF
1877:         THIS.BtnDocumentosClick()
1878:     ENDPROC
1879: 
1880:     PROCEDURE BtnVisualizarClick()
1881:         * Visualizar detalhes tecnicos (chave, protocolo, status)
1882:         * da nota fiscal apontada. Consulta SigMvNfi diretamente
1883:         * para exibir dados que nao aparecem no grid principal.
1884:         LOCAL loc_cChave, loc_cSQL, loc_oErro, loc_cMsg
1885:         LOCAL loc_cChv, loc_cProt, loc_cStat, loc_cXml
1886:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
1887:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas na fila para visualizar.")
1888:             RETURN
1889:         ENDIF
1890:         SELECT csOperacoes
1891:         IF EOF("csOperacoes")
1892:             GO TOP IN csOperacoes
1893:         ENDIF
1894:         loc_cChave = ALLTRIM(csOperacoes.Emps) + ALLTRIM(csOperacoes.Dopes) + ;
1895:                      PADL(ALLTRIM(TRANSFORM(csOperacoes.Numes)), 6, "0")
1896:         loc_cSQL = "SELECT TOP 1 nfechv, nfexml, prots, stats FROM SigMvNfi WHERE empdopnums = " + ;
1897:                    EscaparSQL(loc_cChave)
1898:         TRY
1899:             IF USED("cursor_4c_VisNfe")
1900:                 USE IN cursor_4c_VisNfe
1901:             ENDIF
1902:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VisNfe") < 1
1903:                 MsgErro("Falha ao consultar SigMvNfi para a nota selecionada.", "Visualizar")
1904:                 RETURN
1905:             ENDIF
1906:             IF RECCOUNT("cursor_4c_VisNfe") = 0
1907:                 MsgAviso("Nota fiscal ainda n" + CHR(227) + "o transmitida (sem registro em SigMvNfi).")
1908:             ELSE
1909:                 loc_cChv  = ALLTRIM(NVL(cursor_4c_VisNfe.nfechv, "N/D"))
1910:                 loc_cProt = ALLTRIM(NVL(cursor_4c_VisNfe.prots, "N/D"))
1911:                 loc_cStat = ALLTRIM(NVL(cursor_4c_VisNfe.stats, "N/D"))
1912:                 loc_cXml  = IIF(EMPTY(NVL(cursor_4c_VisNfe.nfexml, "")), "N" + CHR(227) + "o", "Sim")
1913:                 loc_cMsg = "Nota: " + ALLTRIM(csOperacoes.Notas) + CHR(13) + ;
1914:                            "S" + CHR(233) + "rie: " + ALLTRIM(csOperacoes.Series) + CHR(13) + ;
1915:                            "Chave: " + loc_cChv + CHR(13) + ;
1916:                            "Protocolo: " + loc_cProt + CHR(13) + ;
1917:                            "Status: " + loc_cStat + CHR(13) + ;
1918:                            "XML dispon" + CHR(237) + "vel: " + loc_cXml
1919:                 MsgInfo(loc_cMsg)
1920:             ENDIF
1921:             IF USED("cursor_4c_VisNfe")
1922:                 USE IN cursor_4c_VisNfe
1923:             ENDIF
1924:         CATCH TO loc_oErro
1925:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1926:                     "Erro Visualizar")
1927:         ENDTRY
1928:     ENDPROC
1929: 
1930:     PROCEDURE BtnExcluirClick()
1931:         * Excluir (limpar) a fila de processamento.
1932:         * NAO remove NFe do banco - apenas limpa csOperacoes e reabilita
1933:         * os filtros para nova selecao. Confirmacao obrigatoria.
1934:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
1935:             MsgAviso("A fila de processamento j" + CHR(225) + " est" + CHR(225) + " vazia.")
1936:             RETURN
1937:         ENDIF
1938:         IF MsgConfirma("Confirma a limpeza da fila de processamento de NFe?" + CHR(13) + ;
1939:                        "Os registros n" + CHR(227) + "o ser" + CHR(227) + "o removidos do banco de dados.")
1940:             THIS.LimpaSelecao()
1941:         ENDIF
1942:     ENDPROC
1943: 
1944:     *==========================================================================
1945:     * FASE 8 - FormParaBO / BOParaForm / HabilitarCampos / LimparCampos
1946:     * CarregarLista / AjustarBotoesPorModo / BtnSalvar / BtnCancelar / BtnBuscar
1947:     *==========================================================================
1948: 
1949:     *--------------------------------------------------------------------------
1950:     * FormParaBO - Copia TODOS os valores da UI para o Business Object.
1951:     * Cobre os 3 blocos de propriedades: parametros de sele" + CHR(231) + CHR(227) + "o
1952:     * (empresa/serie/datas/acao), flags/checkboxes e o registro corrente
1953:     * de csOperacoes (linha selecionada no grid).
1954:     *--------------------------------------------------------------------------
1955:     PROCEDURE FormParaBO()
1956:         LOCAL loc_oBO, loc_oCnt
1957:         loc_oBO = THIS.this_oBusinessObject
1958:         IF VARTYPE(loc_oBO) != "O"
1959:             RETURN .F.
1960:         ENDIF
1961:         loc_oCnt = THIS.cnt_4c_Operacoes
1962: 
1963:         *-- Bloco 1: parametros de selecao/processamento
1964:         loc_oBO.this_cEmps        = PADR(ALLTRIM(loc_oCnt.txt_4c_Emps.Value), 3)
1965:         loc_oBO.this_cSeries      = PADR(ALLTRIM(loc_oCnt.txt_4c_Series.Value), 3)
1966:         loc_oBO.this_dDtIni       = loc_oCnt.txt_4c_DtIni.Value
1967:         loc_oBO.this_dDtFin       = loc_oCnt.txt_4c_DtFin.Value
1968:         loc_oBO.this_nProcessados = loc_oCnt.opt_4c_Processados.Value
1969:         loc_oBO.this_nTipos       = loc_oCnt.opt_4c_Tipos.Value
1970:         loc_oBO.this_nAmbiente    = loc_oCnt.opt_4c_Ambiente.Value
1971:         loc_oBO.this_nAcao        = loc_oCnt.opt_4c_Acao.Value
1972:         loc_oBO.this_nImpressao   = loc_oCnt.opt_4c_Impressao.Value
1973:         loc_oBO.this_nContin      = loc_oCnt.opt_4c_Contin.Value
1974:         loc_oBO.this_cInuIni      = ALLTRIM(loc_oCnt.txt_4c_InuIni.Value)
1975:         loc_oBO.this_cInuFim      = ALLTRIM(loc_oCnt.txt_4c_InuFim.Value)
1976:         loc_oBO.this_cRegime      = ALLTRIM(loc_oCnt.cmb_4c_Regime.Value)
1977:         loc_oBO.this_cArquivos    = ALLTRIM(loc_oCnt.txt_4c_Arquivos.Value)
1978:         IF EMPTY(loc_oCnt.txt_4c_IniContin.Value)
1979:             loc_oBO.this_dIniContin = {}
1980:         ELSE
1981:             IF VARTYPE(loc_oCnt.txt_4c_IniContin.Value) = "D"
1982:                 loc_oBO.this_dIniContin = loc_oCnt.txt_4c_IniContin.Value
1983:             ELSE
1984:                 loc_oBO.this_dIniContin = CTOD(TRANSFORM(loc_oCnt.txt_4c_IniContin.Value))
1985:             ENDIF
1986:         ENDIF
1987: 
1988:         *-- Bloco 2: flags/checkboxes (Value NUMERICO 0/1 -> LOGICAL no BO)
1989:         loc_oBO.this_lHVerao  = (loc_oCnt.chk_4c_HVerao.Value = 1)
1990:         loc_oBO.this_lVenc    = (loc_oCnt.chk_4c_Venc.Value = 1)
1991:         loc_oBO.this_lOptSub  = (loc_oCnt.chk_4c_OptSub.Value = 1)
1992:         loc_oBO.this_lOptArq  = (loc_oCnt.chk_4c_OptArq.Value = 1)
1993: 
1994:         *-- Bloco 3: registro corrente do grid csOperacoes
1995:         IF USED("csOperacoes") AND !EOF("csOperacoes") AND !BOF("csOperacoes")

*-- Linhas 2019 a 2062:
2019:     * Espelho de FormParaBO, cobrindo os 3 blocos (parametros, flags e
2020:     * registro corrente do grid).
2021:     *--------------------------------------------------------------------------
2022:     PROCEDURE BOParaForm()
2023:         LOCAL loc_oBO, loc_oCnt
2024:         loc_oBO = THIS.this_oBusinessObject
2025:         IF VARTYPE(loc_oBO) != "O"
2026:             RETURN .F.
2027:         ENDIF
2028:         loc_oCnt = THIS.cnt_4c_Operacoes
2029: 
2030:         *-- Bloco 1: parametros de selecao/processamento
2031:         loc_oCnt.txt_4c_Emps.Value       = loc_oBO.this_cEmps
2032:         loc_oCnt.txt_4c_Series.Value     = loc_oBO.this_cSeries
2033:         loc_oCnt.txt_4c_DtIni.Value      = loc_oBO.this_dDtIni
2034:         loc_oCnt.txt_4c_DtFin.Value      = loc_oBO.this_dDtFin
2035:         IF loc_oBO.this_nProcessados > 0
2036:             loc_oCnt.opt_4c_Processados.Value = loc_oBO.this_nProcessados
2037:         ENDIF
2038:         IF loc_oBO.this_nTipos > 0
2039:             loc_oCnt.opt_4c_Tipos.Value = loc_oBO.this_nTipos
2040:         ENDIF
2041:         IF loc_oBO.this_nAmbiente > 0
2042:             loc_oCnt.opt_4c_Ambiente.Value = loc_oBO.this_nAmbiente
2043:         ENDIF
2044:         IF loc_oBO.this_nAcao > 0
2045:             loc_oCnt.opt_4c_Acao.Value = loc_oBO.this_nAcao
2046:         ENDIF
2047:         IF loc_oBO.this_nImpressao > 0
2048:             loc_oCnt.opt_4c_Impressao.Value = loc_oBO.this_nImpressao
2049:         ENDIF
2050:         IF loc_oBO.this_nContin > 0
2051:             loc_oCnt.opt_4c_Contin.Value = loc_oBO.this_nContin
2052:         ENDIF
2053:         loc_oCnt.txt_4c_InuIni.Value   = loc_oBO.this_cInuIni
2054:         loc_oCnt.txt_4c_InuFim.Value   = loc_oBO.this_cInuFim
2055:         loc_oCnt.cmb_4c_Regime.Value   = loc_oBO.this_cRegime
2056:         loc_oCnt.txt_4c_Arquivos.Value = loc_oBO.this_cArquivos
2057:         loc_oCnt.txt_4c_IniContin.Value = loc_oBO.this_dIniContin
2058: 
2059:         *-- Bloco 2: flags/checkboxes (LOGICAL BO -> NUMERICO 0/1 CheckBox)
2060:         loc_oCnt.chk_4c_HVerao.Value = IIF(loc_oBO.this_lHVerao, 1, 0)
2061:         loc_oCnt.chk_4c_Venc.Value   = IIF(loc_oBO.this_lVenc, 1, 0)
2062:         loc_oCnt.chk_4c_OptSub.Value = IIF(loc_oBO.this_lOptSub, 1, 0)

*-- Linhas 2073 a 2200:
2073:     * (nome nativo deste form OPERACIONAL) que implementa a logica real de
2074:     * bloquear filtros durante processamento.
2075:     *--------------------------------------------------------------------------
2076:     PROCEDURE HabilitarCampos(par_lHabilitar)
2077:         LOCAL loc_lHab
2078:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2079:         THIS.HabilitarControles(loc_lHab)
2080:     ENDPROC
2081: 
2082:     *--------------------------------------------------------------------------
2083:     * LimparCampos - Interface CRUD-padrao. Reseta filtros para valores default
2084:     * e limpa a fila de csOperacoes chamando LimpaSelecao.
2085:     *--------------------------------------------------------------------------
2086:     PROCEDURE LimparCampos()
2087:         LOCAL loc_oCnt
2088:         loc_oCnt = THIS.cnt_4c_Operacoes
2089:         loc_oCnt.txt_4c_Emps.Value        = ""
2090:         loc_oCnt.txt_4c_Series.Value      = ""
2091:         loc_oCnt.txt_4c_DtIni.Value       = {}
2092:         loc_oCnt.txt_4c_DtFin.Value       = {}
2093:         loc_oCnt.txt_4c_InuIni.Value      = ""
2094:         loc_oCnt.txt_4c_InuFim.Value      = ""
2095:         loc_oCnt.txt_4c_Arquivos.Value    = ""
2096:         loc_oCnt.opt_4c_Processados.Value = 1
2097:         loc_oCnt.opt_4c_Tipos.Value       = 1
2098:         loc_oCnt.opt_4c_Ambiente.Value    = 1
2099:         loc_oCnt.opt_4c_Acao.Value        = 1
2100:         loc_oCnt.opt_4c_Impressao.Value   = 1
2101:         loc_oCnt.opt_4c_Contin.Value      = 1
2102:         loc_oCnt.chk_4c_HVerao.Value      = 0
2103:         loc_oCnt.chk_4c_Venc.Value        = 0
2104:         loc_oCnt.chk_4c_OptSub.Value      = 0
2105:         loc_oCnt.chk_4c_OptArq.Value      = 0
2106:         THIS.LimpaSelecao()
2107:     ENDPROC
2108: 
2109:     *--------------------------------------------------------------------------
2110:     * CarregarLista - Interface CRUD-padrao. Executa a selecao inicial das
2111:     * notas fiscais no banco (SigMvNfi) para o cursor csOperacoes que popula
2112:     * o grid principal. Delega para BtnSelecionarClick que reproduz o Selecionar
2113:     * do form legado.
2114:     *--------------------------------------------------------------------------
2115:     PROCEDURE CarregarLista()
2116:         LOCAL loc_cEmps, loc_dDtIni, loc_dDtFin
2117:         loc_cEmps  = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value)
2118:         loc_dDtIni = THIS.cnt_4c_Operacoes.txt_4c_DtIni.Value
2119:         loc_dDtFin = THIS.cnt_4c_Operacoes.txt_4c_DtFin.Value
2120:         IF EMPTY(loc_cEmps) OR EMPTY(loc_dDtIni) OR EMPTY(loc_dDtFin)
2121:             RETURN .F.
2122:         ENDIF
2123:         THIS.BtnSelecionarClick(.T.)
2124:         RETURN USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
2125:     ENDPROC
2126: 
2127:     *--------------------------------------------------------------------------
2128:     * AjustarBotoesPorModo - Interface CRUD-padrao. Neste form OPERACIONAL
2129:     * ha 2 modos logicos:
2130:     *   MODO=1 (LIVRE):     filtros habilitados, botoes de acao em grid off.
2131:     *   MODO=2 (SELECAO):   filtros bloqueados, botoes de acao em grid on.
2132:     * A rotina espelha o comportamento de HabilitarControles com semantica
2133:     * de "modo" para compatibilidade com o pipeline CRUD.
2134:     *--------------------------------------------------------------------------
2135:     PROCEDURE AjustarBotoesPorModo(par_nModo)
2136:         LOCAL loc_nModo
2137:         loc_nModo = IIF(VARTYPE(par_nModo) = "N", par_nModo, 1)
2138:         IF loc_nModo = 1
2139:             THIS.HabilitarControles(.T.)
2140:         ELSE
2141:             THIS.HabilitarControles(.F.)
2142:         ENDIF
2143:     ENDPROC
2144: 
2145:     *--------------------------------------------------------------------------
2146:     * BtnSalvarClick - Interface CRUD-padrao. Em contexto NFe "Salvar" equivale
2147:     * a processar (transmitir SEFAZ / gerar TXT / imprimir DANFE) as notas
2148:     * marcadas no grid. Delega para BtnCopiarClick que aciona o
2149:     * BO.Processar/Processamento conforme opt_4c_Acao.
2150:     *--------------------------------------------------------------------------
2151:     PROCEDURE BtnSalvarClick()
2152:         LOCAL loc_nSel
2153:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
2154:             MsgAviso("A fila de processamento est" + CHR(225) + " vazia. Use Buscar/Selecionar antes.")
2155:             RETURN
2156:         ENDIF
2157:         SELECT COUNT(*) AS nSel FROM csOperacoes WHERE SelImp INTO CURSOR cursor_4c_SelSalv
2158:         loc_nSel = cursor_4c_SelSalv.nSel
2159:         USE IN cursor_4c_SelSalv
2160:         IF loc_nSel < 1
2161:             MsgAviso("Nenhuma nota est" + CHR(225) + " marcada para processamento.")
2162:             RETURN
2163:         ENDIF
2164:         THIS.FormParaBO()
2165:         THIS.BtnCopiarClick()
2166:     ENDPROC
2167: 
2168:     *--------------------------------------------------------------------------
2169:     * BtnCancelarClick - Interface CRUD-padrao. Cancela a selecao atual e
2170:     * reabilita os filtros de busca (equivale ao Limpar do form legado).
2171:     *--------------------------------------------------------------------------
2172:     PROCEDURE BtnCancelarClick()
2173:         IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
2174:             IF !MsgConfirma("Confirma o cancelamento da sele" + CHR(231) + CHR(227) + ;
2175:                             "o? A fila ser" + CHR(225) + " limpa.")
2176:                 RETURN
2177:             ENDIF
2178:         ENDIF
2179:         THIS.BtnLimparClick()
2180:     ENDPROC
2181: 
2182:     *--------------------------------------------------------------------------
2183:     * BtnBuscarClick - Interface CRUD-padrao. Aciona a selecao no banco
2184:     * segundo os filtros informados. Delega para BtnSelecionarClick que
2185:     * reproduz o Selecionar do form legado (grupo de botoes cmdSelecionar).
2186:     *--------------------------------------------------------------------------
2187:     PROCEDURE BtnBuscarClick()
2188:         THIS.BtnSelecionarClick()
2189:     ENDPROC
2190: 
2191:     *==========================================================================
2192:     PROCEDURE Destroy()
2193:     *==========================================================================
2194:         IF USED("csOperacoes")
2195:             USE IN csOperacoes
2196:         ENDIF
2197:         DODEFAULT()
2198:     ENDPROC
2199: 
2200: ENDDEFINE

