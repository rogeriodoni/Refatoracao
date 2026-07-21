# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_GRADE. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH .T. define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: .T..RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprnfe.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2195 linhas total):

*-- Linhas 29 a 199:
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
78:             THIS.ConfigurarOperacoes()
79:             THIS.ConfigurarGrade()
80:             THIS.ConfigurarBotoesForm()
81:             THIS.ConfigurarBotoesGrade()
82:             THIS.ConfigurarCntInu()
83:             THIS.TornarControlesVisiveis()
84:             THIS.ConfigurarBINDEVENTs()
85: 
86:             IF !EMPTY(THIS.pMovimentacao)
87:                 THIS.BtnSelecionarClick(.T.)
88:             ENDIF
89: 
90:             loc_lSucesso = .T.
91:         CATCH TO loc_oErro
92:             THIS.this_cMensagemErro = loc_oErro.Message
93:             MsgErro(loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
94:                     " | Proc: " + loc_oErro.Procedure, ;
95:                     "Erro ao inicializar form")
96:         ENDTRY
97:         RETURN loc_lSucesso
98:     ENDPROC
99: 
100:     *==========================================================================
101:     PROTECTED PROCEDURE ConfigurarPageFrame()
102:     *==========================================================================
103:         LOCAL loc_cImg
104:         loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
105:         IF FILE(loc_cImg)
106:             THIS.Picture = loc_cImg
107:         ENDIF
108:     ENDPROC
109: 
110:     *==========================================================================
111:     PROTECTED PROCEDURE ConfigurarCabecalho()
112:     *==========================================================================
113:         LOCAL loc_cCaption, loc_oCnt
114:         loc_cCaption = "Processamento de NF-e"
115:         THIS.AddObject("cnt_4c_Sombra", "Container")
116:         loc_oCnt = THIS.cnt_4c_Sombra
117:         WITH loc_oCnt
118:             .Top         = 0
119:             .Left        = 0
120:             .Width       = 1004
121:             .Height      = 80
122:             .BorderWidth = 0
123:             .BackStyle   = 1
124:             .BackColor   = RGB(100, 100, 100)
125:         ENDWITH
126:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
127:         WITH loc_oCnt.lbl_4c_Sombra
128:             .AutoSize  = .F.
129:             .FontBold  = .T.
130:             .FontName  = "Tahoma"
131:             .FontSize  = 18
132:             .WordWrap  = .T.
133:             .BackStyle = 0
134:             .ForeColor = RGB(0, 0, 0)
135:             .Caption   = loc_cCaption
136:             .Height    = 40
137:             .Left      = 10
138:             .Top       = 18
139:             .Width     = THIS.Width
140:         ENDWITH
141:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
142:         WITH loc_oCnt.lbl_4c_Titulo
143:             .AutoSize  = .F.
144:             .FontBold  = .T.
145:             .FontName  = "Tahoma"
146:             .FontSize  = 18
147:             .WordWrap  = .T.
148:             .BackStyle = 0
149:             .ForeColor = RGB(255, 255, 255)
150:             .Caption   = loc_cCaption
151:             .Height    = 46
152:             .Left      = 10
153:             .Top       = 17
154:             .Width     = THIS.Width
155:         ENDWITH
156:     ENDPROC
157: 
158:     *==========================================================================
159:     PROTECTED PROCEDURE ConfigurarOperacoes()
160:     *==========================================================================
161:         LOCAL loc_oCnt, loc_oOpt
162: 
163:         THIS.AddObject("cnt_4c_Operacoes", "Container")
164:         loc_oCnt = THIS.cnt_4c_Operacoes
165:         WITH loc_oCnt
166:             .Top         = 83
167:             .Left        = 4
168:             .Width       = 824
169:             .Height      = 161
170:             .BorderWidth = 1
171:             .BackStyle   = 1
172:             .BackColor   = RGB(240, 240, 240)
173:         ENDWITH
174: 
175:         *-- Labels descritivos
176:         loc_oCnt.AddObject("lbl_4c_LblEmpresa", "Label")
177:         WITH loc_oCnt.lbl_4c_LblEmpresa
178:             .AutoSize  = .F.
179:             .BackStyle = 0
180:             .Caption   = "Empresa :"
181:             .FontName  = "Tahoma"
182:             .FontSize  = 8
183:             .Height    = 15
184:             .Left      = 35
185:             .Top       = 6
186:             .Width     = 55
187:         ENDWITH
188: 
189:         loc_oCnt.AddObject("lbl_4c_LblSerie", "Label")
190:         WITH loc_oCnt.lbl_4c_LblSerie
191:             .AutoSize  = .F.
192:             .BackStyle = 0
193:             .Caption   = "S" + CHR(233) + "rie :"
194:             .FontName  = "Tahoma"
195:             .FontSize  = 8
196:             .Height    = 15
197:             .Left      = 135
198:             .Top       = 6
199:             .Width     = 40

*-- Linhas 541 a 709:
541:             .Visible = .F.
542:         ENDWITH
543: 
544:         *-- OptionGroups com WITH ANINHADO
545:         loc_oCnt.AddObject("opt_4c_Processados", "OptionGroup")
546:         loc_oOpt = loc_oCnt.opt_4c_Processados
547:         WITH loc_oOpt
548:             .ButtonCount = 2
549:             .Top         = 83
550:             .Left        = 89
551:             .Width       = 235
552:             .Height      = 17
553:             .BackStyle   = 0
554:             .BorderStyle = 0
555:             .Value       = 1
556:             WITH .Buttons(1)
557:                 .Caption   = "N" + CHR(227) + "o Processados"
558:                 .Width     = 115
559:                 .Left      = 0
560:                 .FontName  = "Tahoma"
561:                 .FontSize  = 8
562:                 .BackStyle = 0
563:             ENDWITH
564:             WITH .Buttons(2)
565:                 .Caption   = "J" + CHR(225) + " Processados"
566:                 .Width     = 115
567:                 .Left      = 118
568:                 .FontName  = "Tahoma"
569:                 .FontSize  = 8
570:                 .BackStyle = 0
571:             ENDWITH
572:         ENDWITH
573: 
574:         loc_oCnt.AddObject("opt_4c_Tipos", "OptionGroup")
575:         loc_oOpt = loc_oCnt.opt_4c_Tipos
576:         WITH loc_oOpt
577:             .ButtonCount = 2
578:             .Top         = 6
579:             .Left        = 590
580:             .Width       = 142
581:             .Height      = 15
582:             .BackStyle   = 0
583:             .BorderStyle = 0
584:             .Value       = 1
585:             WITH .Buttons(1)
586:                 .Caption   = "Sa" + CHR(237) + "da"
587:                 .Width     = 65
588:                 .Left      = 0
589:                 .FontName  = "Tahoma"
590:                 .FontSize  = 8
591:                 .BackStyle = 0
592:             ENDWITH
593:             WITH .Buttons(2)
594:                 .Caption   = "Entrada"
595:                 .Width     = 65
596:                 .Left      = 68
597:                 .FontName  = "Tahoma"
598:                 .FontSize  = 8
599:                 .BackStyle = 0
600:             ENDWITH
601:         ENDWITH
602: 
603:         loc_oCnt.AddObject("opt_4c_Ambiente", "OptionGroup")
604:         loc_oOpt = loc_oCnt.opt_4c_Ambiente
605:         WITH loc_oOpt
606:             .ButtonCount = 2
607:             .Top         = 54
608:             .Left        = 89
609:             .Width       = 173
610:             .Height      = 25
611:             .BackStyle   = 0
612:             .BorderStyle = 0
613:             .Value       = 1
614:             WITH .Buttons(1)
615:                 .Caption   = "Produ" + CHR(231) + CHR(227) + "o"
616:                 .Width     = 85
617:                 .Left      = 0
618:                 .FontName  = "Tahoma"
619:                 .FontSize  = 8
620:                 .BackStyle = 0
621:             ENDWITH
622:             WITH .Buttons(2)
623:                 .Caption   = "Homologa" + CHR(231) + CHR(227) + "o"
624:                 .Width     = 85
625:                 .Left      = 88
626:                 .FontName  = "Tahoma"
627:                 .FontSize  = 8
628:                 .BackStyle = 0
629:             ENDWITH
630:         ENDWITH
631: 
632:         loc_oCnt.AddObject("opt_4c_Impressao", "OptionGroup")
633:         loc_oOpt = loc_oCnt.opt_4c_Impressao
634:         WITH loc_oOpt
635:             .ButtonCount = 3
636:             .Top         = 59
637:             .Left        = 569
638:             .Width       = 151
639:             .Height      = 15
640:             .BackStyle   = 0
641:             .BorderStyle = 0
642:             .Value       = 1
643:             WITH .Buttons(1)
644:                 .Caption   = "Retrato"
645:                 .Width     = 48
646:                 .Left      = 0
647:                 .FontName  = "Tahoma"
648:                 .FontSize  = 8
649:                 .BackStyle = 0
650:             ENDWITH
651:             WITH .Buttons(2)
652:                 .Caption   = "Paisagem"
653:                 .Width     = 55
654:                 .Left      = 50
655:                 .FontName  = "Tahoma"
656:                 .FontSize  = 8
657:                 .BackStyle = 0
658:             ENDWITH
659:             WITH .Buttons(3)
660:                 .Caption   = "Sem"
661:                 .Width     = 44
662:                 .Left      = 107
663:                 .FontName  = "Tahoma"
664:                 .FontSize  = 8
665:                 .BackStyle = 0
666:             ENDWITH
667:         ENDWITH
668: 
669:         loc_oCnt.AddObject("opt_4c_Acao", "OptionGroup")
670:         loc_oOpt = loc_oCnt.opt_4c_Acao
671:         WITH loc_oOpt
672:             .ButtonCount = 7
673:             .Top         = 101
674:             .Left        = 92
675:             .Width       = 397
676:             .Height      = 38
677:             .BackStyle   = 0
678:             .BorderStyle = 0
679:             .Value       = 1
680:             WITH .Buttons(1)
681:                 .Caption   = "Enviar"
682:                 .Width     = 55
683:                 .Left      = 0
684:                 .FontName  = "Tahoma"
685:                 .FontSize  = 8
686:                 .BackStyle = 0
687:             ENDWITH
688:             WITH .Buttons(2)
689:                 .Caption   = "Consultar"
690:                 .Width     = 60
691:                 .Left      = 57
692:                 .FontName  = "Tahoma"
693:                 .FontSize  = 8
694:                 .BackStyle = 0
695:             ENDWITH
696:             WITH .Buttons(3)
697:                 .Caption   = "Cancelar"
698:                 .Width     = 58
699:                 .Left      = 119
700:                 .FontName  = "Tahoma"
701:                 .FontSize  = 8
702:                 .BackStyle = 0
703:             ENDWITH
704:             WITH .Buttons(4)
705:                 .Caption   = "Inutilizar"
706:                 .Width     = 60
707:                 .Left      = 179
708:                 .FontName  = "Tahoma"
709:                 .FontSize  = 8

*-- Linhas 735 a 817:
735:             ENDWITH
736:         ENDWITH
737: 
738:         loc_oCnt.AddObject("opt_4c_Contin", "OptionGroup")
739:         loc_oOpt = loc_oCnt.opt_4c_Contin
740:         WITH loc_oOpt
741:             .ButtonCount = 3
742:             .Top         = 140
743:             .Left        = 92
744:             .Width       = 258
745:             .Height      = 21
746:             .BackStyle   = 0
747:             .BorderStyle = 0
748:             .Value       = 1
749:             WITH .Buttons(1)
750:                 .Caption   = "Nenhuma"
751:                 .Width     = 75
752:                 .Left      = 0
753:                 .FontName  = "Tahoma"
754:                 .FontSize  = 8
755:                 .BackStyle = 0
756:             ENDWITH
757:             WITH .Buttons(2)
758:                 .Caption   = "EPEC"
759:                 .Width     = 52
760:                 .Left      = 77
761:                 .FontName  = "Tahoma"
762:                 .FontSize  = 8
763:                 .BackStyle = 0
764:             ENDWITH
765:             WITH .Buttons(3)
766:                 .Caption   = "SCAN/SVC"
767:                 .Width     = 75
768:                 .Left      = 131
769:                 .FontName  = "Tahoma"
770:                 .FontSize  = 8
771:                 .BackStyle = 0
772:             ENDWITH
773:         ENDWITH
774:     ENDPROC
775: 
776:     *==========================================================================
777:     PROTECTED PROCEDURE ConfigurarGrade()
778:     *==========================================================================
779:         LOCAL loc_oCnt, loc_oGrd
780: 
781:         THIS.AddObject("cnt_4c_Grade", "Container")
782:         loc_oCnt = THIS.cnt_4c_Grade
783:         WITH loc_oCnt
784:             .Top         = 247
785:             .Left        = 50
786:             .Width       = 820
787:             .Height      = 344
788:             .BorderWidth = 1
789:             .BackStyle   = 1
790:             .BackColor   = RGB(220, 220, 220)
791:         ENDWITH
792: 
793:         loc_oCnt.AddObject("grd_4c_Operacoes", "Grid")
794:         loc_oGrd = loc_oCnt.grd_4c_Operacoes
795:         WITH loc_oGrd
796:             .Top           = 1
797:             .Left          = 3
798:             .Width         = 813
799:             .Height        = 340
800:             .ColumnCount   = 9
801:             .RecordSource  = "csOperacoes"
802:             .ReadOnly      = .T.
803:             .GridLines     = 1
804:             .GridLineWidth = 1
805:             .HeaderHeight  = 22
806:             .RowHeight     = 20
807:             .DeleteMark    = .F.
808:             .RecordMark    = .F.
809:             .ScrollBars    = 3
810:             .FontName      = "Tahoma"
811:             .FontSize      = 8
812:         ENDWITH
813: 
814:         *-- Column1: selecao (CheckBox com Sparse=.F.)
815:         WITH loc_oGrd.Column1
816:             .Width         = 25
817:             .ReadOnly      = .F.

*-- Linhas 912 a 955:
912:     ENDPROC
913: 
914:     *==========================================================================
915:     PROTECTED PROCEDURE ConfigurarBotoesForm()
916:     *==========================================================================
917:         *-- Botao Selecionar
918:         THIS.AddObject("cmd_4c_Selecionar", "CommandButton")
919:         WITH THIS.cmd_4c_Selecionar
920:             .Top             = 83
921:             .Left            = 843
922:             .Width           = 75
923:             .Height          = 75
924:             .Caption         = "\<Selecionar"
925:             .Picture         = gc_4c_CaminhoIcones + "geral_buscar_60.jpg"
926:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_buscar_60.jpg"
927:             .PicturePosition = 7
928:             .FontName        = "Tahoma"
929:             .FontBold        = .T.
930:             .FontItalic      = .T.
931:             .FontSize        = 8
932:             .ForeColor       = RGB(90, 90, 90)
933:             .BackColor       = RGB(255, 255, 255)
934:             .Themes          = .T.
935:             .SpecialEffect   = 0
936:             .MousePointer    = 15
937:             .WordWrap        = .T.
938:             .AutoSize        = .F.
939:         ENDWITH
940: 
941:         *-- Botao Limpar (desabilitado ate selecionar)
942:         THIS.AddObject("cmd_4c_BtnLimpar", "CommandButton")
943:         WITH THIS.cmd_4c_BtnLimpar
944:             .Top             = 162
945:             .Left            = 843
946:             .Width           = 75
947:             .Height          = 37
948:             .Caption         = "Limpar"
949:             .Picture         = gc_4c_CaminhoIcones + "geral_apagar_26.jpg"
950:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_apagar_26.jpg"
951:             .PicturePosition = 13
952:             .FontName        = "Tahoma"
953:             .FontBold        = .T.
954:             .FontItalic      = .T.
955:             .FontSize        = 8

*-- Linhas 1011 a 1054:
1011:     ENDPROC
1012: 
1013:     *==========================================================================
1014:     PROTECTED PROCEDURE ConfigurarBotoesGrade()
1015:     *==========================================================================
1016:         THIS.AddObject("cmd_4c_MarcaTudo", "CommandButton")
1017:         WITH THIS.cmd_4c_MarcaTudo
1018:             .Top             = 264
1019:             .Left            = 873
1020:             .Width           = 75
1021:             .Height          = 55
1022:             .Caption         = "Marca Tudo"
1023:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1024:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1025:             .PicturePosition = 13
1026:             .FontName        = "Tahoma"
1027:             .FontBold        = .T.
1028:             .FontItalic      = .T.
1029:             .FontSize        = 8
1030:             .ForeColor       = RGB(90, 90, 90)
1031:             .BackColor       = RGB(255, 255, 255)
1032:             .Themes          = .T.
1033:             .SpecialEffect   = 0
1034:             .MousePointer    = 15
1035:             .Enabled         = .F.
1036:         ENDWITH
1037: 
1038:         THIS.AddObject("cmd_4c_Desmarcar", "CommandButton")
1039:         WITH THIS.cmd_4c_Desmarcar
1040:             .Top             = 322
1041:             .Left            = 873
1042:             .Width           = 75
1043:             .Height          = 55
1044:             .Caption         = "Desmarcar"
1045:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1046:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1047:             .PicturePosition = 13
1048:             .FontName        = "Tahoma"
1049:             .FontBold        = .T.
1050:             .FontItalic      = .T.
1051:             .FontSize        = 8
1052:             .ForeColor       = RGB(90, 90, 90)
1053:             .BackColor       = RGB(255, 255, 255)
1054:             .Themes          = .T.

*-- Linhas 1103 a 1146:
1103:     ENDPROC
1104: 
1105:     *==========================================================================
1106:     PROTECTED PROCEDURE ConfigurarCntInu()
1107:     *==========================================================================
1108:         LOCAL loc_oCnt, loc_oGrd
1109: 
1110:         THIS.AddObject("cnt_4c_Inu", "Container")
1111:         loc_oCnt = THIS.cnt_4c_Inu
1112:         WITH loc_oCnt
1113:             .Top         = 156
1114:             .Left        = 203
1115:             .Width       = 504
1116:             .Height      = 392
1117:             .Visible     = .F.
1118:             .BorderWidth = 2
1119:             .BackStyle   = 1
1120:             .BackColor   = RGB(245, 245, 245)
1121:         ENDWITH
1122: 
1123:         loc_oCnt.AddObject("lbl_4c_TituloInu", "Label")
1124:         WITH loc_oCnt.lbl_4c_TituloInu
1125:             .AutoSize  = .F.
1126:             .Caption   = "Notas Fiscais para Inutilizar"
1127:             .FontName  = "Tahoma"
1128:             .FontSize  = 10
1129:             .FontBold  = .T.
1130:             .BackStyle = 0
1131:             .Height    = 20
1132:             .Left      = 10
1133:             .Top       = 5
1134:             .Width     = 380
1135:         ENDWITH
1136: 
1137:         loc_oCnt.AddObject("cmd_4c_BtnCancelaInu", "CommandButton")
1138:         WITH loc_oCnt.cmd_4c_BtnCancelaInu
1139:             .Top             = 28
1140:             .Left            = 408
1141:             .Width           = 75
1142:             .Height          = 75
1143:             .Caption         = "Encerrar"
1144:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1145:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1146:             .PicturePosition = 7

*-- Linhas 1244 a 1990:
1244:     ENDPROC
1245: 
1246:     *==========================================================================
1247:     * TornarControlesVisiveis: oculta cnt_4c_Inu e cmd_4c_Inu apos DODEFAULT
1248:     *==========================================================================
1249:     PROCEDURE TornarControlesVisiveis()
1250:         LOCAL loc_oErro
1251:         TRY
1252:             DODEFAULT()
1253:             IF PEMSTATUS(THIS, "cnt_4c_Inu", 5)
1254:                 THIS.cnt_4c_Inu.Visible = .F.
1255:             ENDIF
1256:             IF PEMSTATUS(THIS, "cnt_4c_Operacoes", 5)
1257:                 IF PEMSTATUS(THIS.cnt_4c_Operacoes, "cmd_4c_Inu", 5)
1258:                     THIS.cnt_4c_Operacoes.cmd_4c_Inu.Visible = .F.
1259:                 ENDIF
1260:             ENDIF
1261:         CATCH TO loc_oErro
1262:             MsgErro(loc_oErro.Message, "Erro TornarControlesVisiveis")
1263:         ENDTRY
1264:     ENDPROC
1265: 
1266:     *==========================================================================
1267:     * ConfigurarPaginaLista - Restaura visao principal do form OPERACIONAL
1268:     * (grade + botoes de acao + filtros) escondendo o painel flutuante de
1269:     * inutilizacao. Equivalente ao Page1=LISTA dos forms CRUD; chamado por
1270:     * AlternarPagina(1) e apos cada processamento para reset visual.
1271:     *==========================================================================
1272:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1273:         LOCAL loc_oErro
1274:         TRY
1275:             IF PEMSTATUS(THIS, "cnt_4c_Inu", 5)
1276:                 THIS.cnt_4c_Inu.Visible = .F.
1277:             ENDIF
1278:             IF PEMSTATUS(THIS, "cnt_4c_Operacoes", 5)
1279:                 THIS.cnt_4c_Operacoes.Visible = .T.
1280:             ENDIF
1281:             IF PEMSTATUS(THIS, "cnt_4c_Grade", 5)
1282:                 THIS.cnt_4c_Grade.Visible = .T.
1283:                 IF PEMSTATUS(THIS.cnt_4c_Grade, "grd_4c_Operacoes", 5)
1284:                     THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1285:                 ENDIF
1286:             ENDIF
1287:             IF PEMSTATUS(THIS, "cmd_4c_Selecionar", 5)
1288:                 THIS.cmd_4c_Selecionar.Enabled = .T.
1289:             ENDIF
1290:         CATCH TO loc_oErro
1291:             MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaLista")
1292:         ENDTRY
1293:     ENDPROC
1294: 
1295:     *==========================================================================
1296:     * ConfigurarPaginaDados - Exibe painel flutuante de inutilizacao (overlay)
1297:     * Form OPERACIONAL nao possui PageFrame; cnt_4c_Inu atua como "Page2=Dados"
1298:     * para captura da grade de inutilizacao. Chamado por AlternarPagina(2) e
1299:     * CmdInuClick apos SelecionarInutilizadas popular csInutil. Refresh() garante
1300:     * repaint do grid apos GO TOP e cursor recem-carregado.
1301:     *==========================================================================
1302:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1303:         LOCAL loc_oErro
1304:         TRY
1305:             IF PEMSTATUS(THIS, "cnt_4c_Inu", 5)
1306:                 THIS.cnt_4c_Inu.Visible = .T.
1307:                 IF PEMSTATUS(THIS.cnt_4c_Inu, "grd_4c_Inu", 5)
1308:                     IF USED("csInutil")
1309:                         THIS.cnt_4c_Inu.grd_4c_Inu.RecordSource = "csInutil"
1310:                     ENDIF
1311:                     THIS.cnt_4c_Inu.grd_4c_Inu.Refresh()
1312:                 ENDIF
1313:                 IF PEMSTATUS(THIS.cnt_4c_Inu, "cmd_4c_BtnProcInu", 5)
1314:                     THIS.cnt_4c_Inu.cmd_4c_BtnProcInu.Enabled = ;
1315:                         (USED("csInutil") AND RECCOUNT("csInutil") > 0)
1316:                 ENDIF
1317:                 THIS.cnt_4c_Inu.ZOrder(0)
1318:             ENDIF
1319:         CATCH TO loc_oErro
1320:             MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaDados")
1321:         ENDTRY
1322:     ENDPROC
1323: 
1324:     *==========================================================================
1325:     * AlternarPagina - Alterna entre visao principal (1) e overlay Inutilizar (2)
1326:     * Form OPERACIONAL nao possui PageFrame; usa cnt_4c_Inu como painel flutuante
1327:     * que funciona logicamente como uma "segunda pagina" para captura de dados
1328:     * de inutilizacao. par_nPagina = 1 restaura visao principal; = 2 abre overlay.
1329:     *==========================================================================
1330:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1331:         LOCAL loc_nPag, loc_oErro
1332:         loc_nPag = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
1333:         TRY
1334:             DO CASE
1335:                 CASE loc_nPag = 2
1336:                     THIS.ConfigurarPaginaDados()
1337:                 OTHERWISE
1338:                     THIS.ConfigurarPaginaLista()
1339:             ENDCASE
1340:         CATCH TO loc_oErro
1341:             MsgErro(loc_oErro.Message, "Erro AlternarPagina")
1342:         ENDTRY
1343:     ENDPROC
1344: 
1345:     *==========================================================================
1346:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
1347:     *==========================================================================
1348:         LOCAL loc_oGrd
1349:         BINDEVENT(THIS.cmd_4c_Selecionar, "Click", THIS, "BtnSelecionarClick")
1350:         BINDEVENT(THIS.cmd_4c_BtnLimpar,  "Click", THIS, "BtnLimparClick")
1351:         BINDEVENT(THIS.cmd_4c_BtnCopiar,  "Click", THIS, "BtnCopiarClick")
1352:         BINDEVENT(THIS.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
1353:         BINDEVENT(THIS.cmd_4c_MarcaTudo,  "Click", THIS, "BtnMarcaTudoClick")
1354:         BINDEVENT(THIS.cmd_4c_Desmarcar,  "Click", THIS, "BtnDesmarcarClick")
1355:         BINDEVENT(THIS.cmd_4c_Documentos, "Click", THIS, "BtnDocumentosClick")
1356:         BINDEVENT(THIS.cmd_4c_ImpDSimpl,  "Click", THIS, "BtnImpDSimplClick")
1357:         BINDEVENT(THIS.cnt_4c_Inu.cmd_4c_BtnCancelaInu, "Click", THIS, "BtnCancelaInuClick")
1358:         BINDEVENT(THIS.cnt_4c_Inu.cmd_4c_BtnProcInu,    "Click", THIS, "BtnProcInuClick")
1359:         BINDEVENT(THIS.cnt_4c_Operacoes.txt_4c_Emps,    "KeyPress", THIS, "EmpsLostFocus")
1360:         BINDEVENT(THIS.cnt_4c_Operacoes.txt_4c_Series,  "KeyPress", THIS, "SeriesLostFocus")
1361:         BINDEVENT(THIS.cnt_4c_Operacoes.opt_4c_Acao, "InteractiveChange", THIS, "AcaoInteractiveChange")
1362:         BINDEVENT(THIS.cnt_4c_Operacoes.cmd_4c_Inu,  "Click", THIS, "CmdInuClick")
1363:         loc_oGrd = THIS.cnt_4c_Grade.grd_4c_Operacoes
1364:         BINDEVENT(loc_oGrd.Column1.chk_4c_SelImp, "MouseUp",  THIS, "GridChkMouseUp")
1365:         BINDEVENT(loc_oGrd.Column1.chk_4c_SelImp, "KeyPress", THIS, "GridChkKeyPress")
1366:     ENDPROC
1367: 
1368:     *==========================================================================
1369:     * HANDLERS DE EVENTOS
1370:     *==========================================================================
1371: 
1372:     PROCEDURE BtnSelecionarClick
1373:         LPARAMETERS par_lForcado
1374:         LOCAL loc_cEmps, loc_cSeries, loc_dDtIni, loc_dDtFin
1375:         LOCAL loc_nProcessados, loc_nTipos, loc_nAcao
1376:         LOCAL loc_cInuIni, loc_cInuFim, loc_oBO, loc_oErro, loc_lSelOk
1377: 
1378:         loc_oBO = THIS.this_oBusinessObject
1379: 
1380:         loc_cEmps        = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
1381:         loc_cSeries      = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3)
1382:         loc_dDtIni       = THIS.cnt_4c_Operacoes.txt_4c_DtIni.Value
1383:         loc_dDtFin       = THIS.cnt_4c_Operacoes.txt_4c_DtFin.Value
1384:         loc_nProcessados = THIS.cnt_4c_Operacoes.opt_4c_Processados.Value
1385:         loc_nTipos       = THIS.cnt_4c_Operacoes.opt_4c_Tipos.Value
1386:         loc_nAcao        = THIS.cnt_4c_Operacoes.opt_4c_Acao.Value
1387:         loc_cInuIni      = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuIni.Value)
1388:         loc_cInuFim      = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuFim.Value)
1389: 
1390:         IF VARTYPE(par_lForcado) != "L" OR !par_lForcado
1391:             IF loc_nProcessados = 2
1392:                 IF !MsgConfirma("Confirma a Sele" + CHR(231) + CHR(227) + "o de Opera" + ;
1393:                                 CHR(231) + CHR(245) + "es J" + CHR(225) + " Processadas Anteriormente?")
1394:                     THIS.cnt_4c_Operacoes.opt_4c_Processados.Value = 1
1395:                     RETURN
1396:                 ENDIF
1397:             ENDIF
1398:         ENDIF
1399: 
1400:         IF EMPTY(ALLTRIM(loc_cEmps))
1401:             MsgAviso("A Empresa N" + CHR(227) + "o Foi Informada!!!")
1402:             THIS.cnt_4c_Operacoes.txt_4c_Emps.SetFocus()
1403:             RETURN
1404:         ENDIF
1405:         IF EMPTY(loc_dDtIni)
1406:             MsgAviso("A Data Inicial N" + CHR(227) + "o Foi Informada!!!")
1407:             THIS.cnt_4c_Operacoes.txt_4c_DtIni.SetFocus()
1408:             RETURN
1409:         ENDIF
1410:         IF EMPTY(loc_dDtFin)
1411:             MsgAviso("A Data Final N" + CHR(227) + "o Foi Informada!!!")
1412:             THIS.cnt_4c_Operacoes.txt_4c_DtFin.SetFocus()
1413:             RETURN
1414:         ENDIF
1415:         IF loc_dDtFin < loc_dDtIni
1416:             MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!")
1417:             THIS.cnt_4c_Operacoes.txt_4c_DtFin.SetFocus()
1418:             RETURN
1419:         ENDIF
1420:         IF INLIST(loc_nAcao, 4, 7)
1421:             IF (loc_cInuFim < loc_cInuIni) OR EMPTY(loc_cInuFim) OR EMPTY(loc_cInuIni)
1422:                 MsgAviso("A Numera" + CHR(231) + CHR(227) + "o informada est" + CHR(225) + " inconsistente!!!")
1423:                 THIS.cnt_4c_Operacoes.txt_4c_InuFim.SetFocus()
1424:                 RETURN
1425:             ENDIF
1426:         ENDIF
1427: 
1428:         loc_oBO.this_cEmps        = loc_cEmps
1429:         loc_oBO.this_cSeries      = loc_cSeries
1430:         loc_oBO.this_dDtIni       = loc_dDtIni
1431:         loc_oBO.this_dDtFin       = loc_dDtFin
1432:         loc_oBO.this_nProcessados = loc_nProcessados
1433:         loc_oBO.this_nTipos       = loc_nTipos
1434:         loc_oBO.this_nAcao        = loc_nAcao
1435:         loc_oBO.this_cInuIni      = loc_cInuIni
1436:         loc_oBO.this_cInuFim      = loc_cInuFim
1437: 
1438:         loc_lSelOk = .T.
1439:         TRY
1440:             loc_oBO.Selecionar("csOperacoes")
1441:         CATCH TO loc_oErro
1442:             MsgErro(loc_oErro.Message, "Erro Selecionar")
1443:             loc_lSelOk = .F.
1444:         ENDTRY
1445:         IF !loc_lSelOk
1446:             RETURN
1447:         ENDIF
1448: 
1449:         THIS.HabilitarControles(.F.)
1450: 
1451:         SELECT csOperacoes
1452:         SET ORDER TO Notas
1453:         GO TOP IN csOperacoes
1454:         IF EOF("csOperacoes")
1455:             IF INLIST(loc_nAcao, 1, 2, 3, 5)
1456:                 MsgAviso("Nenhuma Nota Foi Encontrada Para Processamento!!!")
1457:                 THIS.LimpaSelecao()
1458:                 THIS.cnt_4c_Operacoes.txt_4c_Series.SetFocus()
1459:             ENDIF
1460:         ELSE
1461:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1462:         ENDIF
1463:     ENDPROC
1464: 
1465:     PROCEDURE BtnLimparClick()
1466:         THIS.LimpaSelecao()
1467:     ENDPROC
1468: 
1469:     PROCEDURE BtnCopiarClick()
1470:         LOCAL loc_nAcao, loc_nSel, loc_oBO, loc_oErro
1471:         loc_nAcao = THIS.cnt_4c_Operacoes.opt_4c_Acao.Value
1472:         IF INLIST(loc_nAcao, 1, 2, 3, 5, 6)
1473:             IF USED("cursor_4c_SelChk")
1474:                 USE IN cursor_4c_SelChk
1475:             ENDIF
1476:             SELECT COUNT(*) AS nSel FROM csOperacoes WHERE SelImp INTO CURSOR cursor_4c_SelChk
1477:             loc_nSel = cursor_4c_SelChk.nSel
1478:             USE IN cursor_4c_SelChk
1479:             IF loc_nSel < 1
1480:                 MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Selecionado para Processamento!!!")
1481:                 THIS.cnt_4c_Grade.grd_4c_Operacoes.SetFocus()
1482:                 RETURN
1483:             ENDIF
1484:         ENDIF
1485:         loc_oBO = THIS.this_oBusinessObject
1486:         loc_oBO.this_nAcao      = loc_nAcao
1487:         loc_oBO.this_nAmbiente  = THIS.cnt_4c_Operacoes.opt_4c_Ambiente.Value
1488:         loc_oBO.this_nTipos     = THIS.cnt_4c_Operacoes.opt_4c_Tipos.Value
1489:         loc_oBO.this_nImpressao = THIS.cnt_4c_Operacoes.opt_4c_Impressao.Value
1490:         loc_oBO.this_nContin    = THIS.cnt_4c_Operacoes.opt_4c_Contin.Value
1491:         loc_oBO.this_cArquivos  = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Arquivos.Value)
1492:         loc_oBO.this_lHVerao    = (THIS.cnt_4c_Operacoes.chk_4c_HVerao.Value = 1)
1493:         loc_oBO.this_lVenc      = (THIS.cnt_4c_Operacoes.chk_4c_Venc.Value = 1)
1494:         loc_oBO.this_lOptSub    = (THIS.cnt_4c_Operacoes.chk_4c_OptSub.Value = 1)
1495:         loc_oBO.this_lOptArq    = (THIS.cnt_4c_Operacoes.chk_4c_OptArq.Value = 1)
1496:         TRY
1497:             loc_oBO.Processamento( ;
1498:                 PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3), ;
1499:                 PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3))
1500:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1501:         CATCH TO loc_oErro
1502:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1503:                     "Erro Processar")
1504:         ENDTRY
1505:     ENDPROC
1506: 
1507:     PROCEDURE BtnEncerrarClick()
1508:         THIS.Release()
1509:     ENDPROC
1510: 
1511:     PROCEDURE BtnMarcaTudoClick()
1512:         IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
1513:             SELECT csOperacoes
1514:             REPLACE ALL SelImp WITH .T.
1515:             GO TOP IN csOperacoes
1516:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1517:         ENDIF
1518:     ENDPROC
1519: 
1520:     PROCEDURE BtnDesmarcarClick()
1521:         IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
1522:             SELECT csOperacoes
1523:             REPLACE ALL SelImp WITH .F.
1524:             GO TOP IN csOperacoes
1525:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1526:         ENDIF
1527:     ENDPROC
1528: 
1529:     PROCEDURE BtnDocumentosClick()
1530:         LOCAL loc_cDopes, loc_nNumes, loc_cEmps, loc_oForm, loc_oErro
1531:         IF !USED("csOperacoes") OR EOF("csOperacoes")
1532:             MsgAviso("Posicione o cursor em um registro.")
1533:             RETURN
1534:         ENDIF
1535:         SELECT csOperacoes
1536:         loc_cDopes = ALLTRIM(csOperacoes.Dopes)
1537:         loc_nNumes = csOperacoes.Numes
1538:         loc_cEmps  = ALLTRIM(csOperacoes.Emps)
1539:         TRY
1540:             loc_oForm = CREATEOBJECT("Formsigmvexp", loc_cDopes, "C", loc_nNumes, loc_cEmps)
1541:             IF VARTYPE(loc_oForm) = "O"
1542:                 loc_oForm.Show()
1543:             ELSE
1544:                 MsgErro("Erro ao criar Formsigmvexp. VARTYPE retornou: " + ;
1545:                         VARTYPE(loc_oForm), "Documentos")
1546:             ENDIF
1547:         CATCH TO loc_oErro
1548:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1549:                     "Erro ao abrir Documentos")
1550:         ENDTRY
1551:     ENDPROC
1552: 
1553:     PROCEDURE BtnImpDSimplClick()
1554:         LOCAL loc_oBO, loc_oErro
1555:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
1556:             MsgAviso("Nenhuma nota encontrada para impress" + CHR(227) + "o.")
1557:             RETURN
1558:         ENDIF
1559:         loc_oBO = THIS.this_oBusinessObject
1560:         TRY
1561:             loc_oBO.ImprimirSimplificado("csOperacoes")
1562:         CATCH TO loc_oErro
1563:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1564:                     "Erro Impress" + CHR(227) + "o")
1565:         ENDTRY
1566:     ENDPROC
1567: 
1568:     PROCEDURE BtnCancelaInuClick()
1569:         THIS.AlternarPagina(1)
1570:     ENDPROC
1571: 
1572:     PROCEDURE BtnProcInuClick()
1573:         LOCAL loc_cEmps, loc_cSeries, loc_cCnpj, loc_cNIni, loc_cNFim, loc_oBO, loc_oErro
1574:         IF !INLIST(THIS.cnt_4c_Operacoes.opt_4c_Acao.Value, 4, 7)
1575:             MsgAviso("Selecione a a" + CHR(231) + CHR(227) + "o Inutilizar ou Status.")
1576:             RETURN
1577:         ENDIF
1578:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value))
1579:             MsgAviso("Empresa n" + CHR(227) + "o informada.")
1580:             RETURN
1581:         ENDIF
1582:         IF !USED("csInutil") OR RECCOUNT("csInutil") = 0
1583:             MsgAviso("Nenhuma nota fiscal para inutilizar.")
1584:             RETURN
1585:         ENDIF
1586:         loc_cEmps   = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
1587:         loc_cSeries = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3)
1588:         loc_cNIni   = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuIni.Value)
1589:         loc_cNFim   = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuFim.Value)
1590:         SELECT csInutil
1591:         GO TOP IN csInutil
1592:         loc_cCnpj = ALLTRIM(csInutil.cnpj)
1593:         loc_oBO = THIS.this_oBusinessObject
1594:         TRY
1595:             loc_oBO.ProcessaInutilizadas(loc_cEmps, loc_cSeries, loc_cCnpj, loc_cNIni, loc_cNFim)
1596:         CATCH TO loc_oErro
1597:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1598:                     "Erro Inutilizar")
1599:         ENDTRY
1600:         THIS.AlternarPagina(1)
1601:     ENDPROC
1602: 
1603:     PROCEDURE AcaoInteractiveChange()
1604:         IF PEMSTATUS(THIS.cnt_4c_Operacoes, "cmd_4c_Inu", 5)
1605:             THIS.cnt_4c_Operacoes.cmd_4c_Inu.Visible = ;
1606:                 INLIST(THIS.cnt_4c_Operacoes.opt_4c_Acao.Value, 4, 7)
1607:         ENDIF
1608:     ENDPROC
1609: 
1610:     PROCEDURE CmdInuClick()
1611:         LOCAL loc_cEmps, loc_oBO, loc_oErro
1612:         loc_cEmps = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
1613:         IF EMPTY(ALLTRIM(loc_cEmps))
1614:             MsgAviso("Informe a empresa antes de consultar inutiliza" + CHR(231) + CHR(245) + "es.")
1615:             RETURN
1616:         ENDIF
1617:         loc_oBO = THIS.this_oBusinessObject
1618:         TRY
1619:             *-- Carrega nfAinu com gap analysis via BO
1620:             loc_oBO.SelecionarInutilizadas(loc_cEmps)
1621:             IF USED("nfAinu")
1622:                 SELECT 1 AS nMarca, emps, series, notai, notaf, cnpj ;
1623:                     FROM nfAinu ;
1624:                     WHERE RTRIM(emps) = RTRIM(loc_cEmps) ;
1625:                     INTO CURSOR csInutil READWRITE
1626:                 IF USED("csInutil") AND RECCOUNT("csInutil") > 0
1627:                     GO TOP IN csInutil
1628:                     WITH THIS.cnt_4c_Inu.grd_4c_Inu
1629:                         .RecordSource          = "csInutil"
1630:                         .Column1.ControlSource = "csInutil.emps"
1631:                         .Column2.ControlSource = "csInutil.series"
1632:                         .Column3.ControlSource = "csInutil.notai"
1633:                         .Column4.ControlSource = "csInutil.notaf"
1634:                         .Column5.ControlSource = "csInutil.cnpj"
1635:                         .Column6.ControlSource = "csInutil.nMarca"
1636:                         .Refresh()
1637:                     ENDWITH
1638:                     THIS.AlternarPagina(2)
1639:                 ELSE
1640:                     MsgAviso("Nenhuma nota para inutilizar encontrada para esta empresa.")
1641:                 ENDIF
1642:             ELSE
1643:                 MsgAviso("Nenhuma nota para inutilizar encontrada.")
1644:             ENDIF
1645:         CATCH TO loc_oErro
1646:             MsgErro(loc_oErro.Message, "Erro CmdInu")
1647:         ENDTRY
1648:     ENDPROC
1649: 
1650:     PROCEDURE EmpsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1651:         IF !INLIST(par_nKeyCode, 9, 13, 115)
1652:             RETURN
1653:         ENDIF
1654:         IF par_nKeyCode = 115  && F4 - abrir picker direto
1655:             THIS.AbrirBuscaEmps()
1656:             RETURN
1657:         ENDIF
1658:         LOCAL loc_cEmps, loc_oBO, loc_oErro
1659:         loc_cEmps = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
1660:         IF EMPTY(ALLTRIM(loc_cEmps))
1661:             RETURN
1662:         ENDIF
1663:         loc_oBO = THIS.this_oBusinessObject
1664:         TRY
1665:             IF loc_oBO.CarregarEmpresa(ALLTRIM(loc_cEmps))
1666:                 THIS.PreencherRegimeEmpresa(loc_oBO)
1667:             ELSE
1668:                 THIS.AbrirBuscaEmps()
1669:             ENDIF
1670:         CATCH TO loc_oErro
1671:             MsgErro(loc_oErro.Message, "Erro ao carregar empresa")
1672:         ENDTRY
1673:     ENDPROC
1674: 
1675:     PROTECTED PROCEDURE PreencherRegimeEmpresa(par_oBO)
1676:         DO CASE
1677:             CASE par_oBO.this_nRegimeEmp = 1
1678:                 THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Simples Nacional"
1679:             CASE par_oBO.this_nRegimeEmp = 2
1680:                 THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Lucro Presumido"
1681:             CASE par_oBO.this_nRegimeEmp = 3
1682:                 THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Lucro Real"
1683:             CASE par_oBO.this_nRegimeEmp = 4
1684:                 THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Lucro Arbitrado"
1685:         ENDCASE
1686:         IF !EMPTY(par_oBO.this_cArquivos)
1687:             THIS.cnt_4c_Operacoes.txt_4c_Arquivos.Value = par_oBO.this_cArquivos
1688:         ENDIF
1689:     ENDPROC
1690: 
1691:     PROCEDURE AbrirBuscaEmps()
1692:         LOCAL loc_oBusca, loc_cCemps, loc_oBO, loc_oErro
1693:         TRY
1694:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1695:                 "SigCdEmp", ;
1696:                 "cursor_4c_BuscaEmp", ;
1697:                 "Cemps", ;
1698:                 ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), ;
1699:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
1700:                 .T., .T., "Ativas <> 2")
1701:             loc_oBusca.mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
1702:             loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
1703:             loc_oBusca.Show()
1704:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1705:                 loc_cCemps = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1706:                 THIS.cnt_4c_Operacoes.txt_4c_Emps.Value = loc_cCemps
1707:                 loc_oBO = THIS.this_oBusinessObject
1708:                 IF loc_oBO.CarregarEmpresa(loc_cCemps)
1709:                     THIS.PreencherRegimeEmpresa(loc_oBO)
1710:                 ENDIF
1711:             ENDIF
1712:         CATCH TO loc_oErro
1713:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaEmps")
1714:         ENDTRY
1715:         IF USED("cursor_4c_BuscaEmp")
1716:             USE IN cursor_4c_BuscaEmp
1717:         ENDIF
1718:         IF VARTYPE(loc_oBusca) = "O"
1719:             loc_oBusca.Release()
1720:         ENDIF
1721:     ENDPROC
1722: 
1723:     PROCEDURE SeriesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1724:         IF !INLIST(par_nKeyCode, 9, 13, 115)
1725:             RETURN
1726:         ENDIF
1727:         IF par_nKeyCode = 115  && F4 - abrir picker direto
1728:             THIS.AbrirBuscaSeries()
1729:             RETURN
1730:         ENDIF
1731:         LOCAL loc_cSeries, loc_nResult, loc_oErro
1732:         loc_cSeries = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value)
1733:         IF EMPTY(loc_cSeries)
1734:             RETURN
1735:         ENDIF
1736:         TRY
1737:             loc_nResult = SQLEXEC(gnConnHandle, ;
1738:                 "SELECT Cods FROM SigCdSer WHERE ImpNfs = 3 AND LTRIM(RTRIM(Cods)) = " + ;
1739:                 EscaparSQL(loc_cSeries), "cursor_4c_SerValid")
1740:             IF loc_nResult > 0 AND USED("cursor_4c_SerValid") AND !EOF("cursor_4c_SerValid")
1741:                 THIS.cnt_4c_Operacoes.txt_4c_Series.Value = ALLTRIM(cursor_4c_SerValid.Cods)
1742:             ELSE
1743:                 THIS.AbrirBuscaSeries()
1744:             ENDIF
1745:             IF USED("cursor_4c_SerValid")
1746:                 USE IN cursor_4c_SerValid
1747:             ENDIF
1748:         CATCH TO loc_oErro
1749:             MsgErro(loc_oErro.Message, "Erro ao validar s" + CHR(233) + "rie")
1750:         ENDTRY
1751:     ENDPROC
1752: 
1753:     PROCEDURE AbrirBuscaSeries()
1754:         LOCAL loc_oBusca, loc_cCods, loc_oErro
1755:         TRY
1756:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1757:                 "SigCdSer", ;
1758:                 "cursor_4c_BuscaSeries", ;
1759:                 "Cods", ;
1760:                 ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), ;
1761:                 "Sele" + CHR(231) + CHR(227) + "o de S" + CHR(233) + "rie", ;
1762:                 .T., .T., "ImpNfs = 3")
1763:             loc_oBusca.mAddColuna("Cods", "", "S" + CHR(233) + "rie")
1764:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1765:             loc_oBusca.Show()
1766:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSeries")
1767:                 loc_cCods = ALLTRIM(cursor_4c_BuscaSeries.Cods)
1768:                 THIS.cnt_4c_Operacoes.txt_4c_Series.Value = loc_cCods
1769:             ENDIF
1770:         CATCH TO loc_oErro
1771:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaSeries")
1772:         ENDTRY
1773:         IF USED("cursor_4c_BuscaSeries")
1774:             USE IN cursor_4c_BuscaSeries
1775:         ENDIF
1776:         IF VARTYPE(loc_oBusca) = "O"
1777:             loc_oBusca.Release()
1778:         ENDIF
1779:     ENDPROC
1780: 
1781:     *-- MouseUp no CheckBox de selecao: toggle SelImp do registro corrente
1782:     PROCEDURE GridChkMouseUp
1783:         LPARAMETERS par_nButton, par_nShift, par_nXCoord, par_nYCoord
1784:         IF USED("csOperacoes") AND !EOF("csOperacoes")
1785:             m.SelImp = (NOT csOperacoes.SelImp)
1786:             SELECT csOperacoes
1787:             GATHER MEMVAR FIELDS SelImp
1788:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1789:         ENDIF
1790:         NODEFAULT
1791:     ENDPROC
1792: 
1793:     *-- KeyPress no CheckBox de selecao: Enter/Space faz toggle
1794:     PROCEDURE GridChkKeyPress
1795:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1796:         IF INLIST(par_nKeyCode, 13, 32) AND USED("csOperacoes") AND !EOF("csOperacoes")
1797:             m.SelImp = (NOT csOperacoes.SelImp)
1798:             SELECT csOperacoes
1799:             GATHER MEMVAR FIELDS SelImp
1800:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1801:             NODEFAULT
1802:         ENDIF
1803:     ENDPROC
1804: 
1805:     PROCEDURE LimpaSelecao()
1806:         IF USED("csOperacoes")
1807:             ZAP IN csOperacoes
1808:         ENDIF
1809:         THIS.HabilitarControles(.T.)
1810:         THIS.cmd_4c_ImpDSimpl.Enabled = .F.
1811:         THIS.Refresh()
1812:     ENDPROC
1813: 
1814:     PROCEDURE HabilitarControles(par_lHabilitar)
1815:         WITH THIS.cnt_4c_Operacoes
1816:             .txt_4c_Emps.Enabled                   = par_lHabilitar
1817:             .txt_4c_Series.Enabled                 = par_lHabilitar
1818:             .txt_4c_DtIni.Enabled                  = par_lHabilitar
1819:             .txt_4c_DtFin.Enabled                  = par_lHabilitar
1820:             .txt_4c_InuIni.Enabled                 = par_lHabilitar
1821:             .txt_4c_InuFim.Enabled                 = par_lHabilitar
1822:             .cmb_4c_Regime.Enabled                 = par_lHabilitar
1823:             .opt_4c_Processados.Buttons(1).Enabled = par_lHabilitar
1824:             .opt_4c_Processados.Buttons(2).Enabled = par_lHabilitar
1825:             .Visible     = .T.
1826:         ENDWITH
1827:         THIS.cmd_4c_Selecionar.Enabled = par_lHabilitar
1828:         THIS.cmd_4c_BtnLimpar.Enabled  = !par_lHabilitar
1829:         THIS.cmd_4c_BtnCopiar.Enabled  = !par_lHabilitar
1830:         THIS.cmd_4c_MarcaTudo.Enabled  = !par_lHabilitar
1831:         THIS.cmd_4c_Desmarcar.Enabled  = !par_lHabilitar
1832:         THIS.cmd_4c_Documentos.Enabled = !par_lHabilitar
1833:         THIS.cmd_4c_ImpDSimpl.Enabled  = !par_lHabilitar
1834:     ENDPROC
1835: 
1836:     *==========================================================================
1837:     * Eventos CRUD adaptados ao contexto OPERACIONAL de processamento de NFe.
1838:     * Em forms de processamento fiscal, as semanticas CRUD tradicionais mapeiam
1839:     * para operacoes especificas do fluxo de trabalho de NFe.
1840:     *==========================================================================
1841: 
1842:     PROCEDURE BtnIncluirClick()
1843:         * Incluir notas fiscais na fila de processamento.
1844:         * No contexto NFe, "Incluir" equivale a Selecionar registros do banco
1845:         * (SigMvNfi) para o cursor csOperacoes segundo os filtros informados.
1846:         LOCAL loc_cEmps
1847:         loc_cEmps = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value)
1848:         IF EMPTY(loc_cEmps)
1849:             MsgAviso("Informe a Empresa antes de incluir notas na fila.")
1850:             THIS.cnt_4c_Operacoes.txt_4c_Emps.SetFocus()
1851:             RETURN
1852:         ENDIF
1853:         THIS.BtnSelecionarClick()
1854:     ENDPROC
1855: 
1856:     PROCEDURE BtnAlterarClick()
1857:         * Alterar dados fiscais da nota corrente. Abre Formsigmvexp
1858:         * (mesma janela usada pelo botao "Documentos" do grid) para
1859:         * edicao dos dados fiscais da NF apontada em csOperacoes.
1860:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
1861:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas na fila. Utilize Incluir primeiro.")
1862:             RETURN
1863:         ENDIF
1864:         SELECT csOperacoes
1865:         IF EOF("csOperacoes")
1866:             GO TOP IN csOperacoes
1867:         ENDIF
1868:         IF EMPTY(csOperacoes.Emps) OR EMPTY(csOperacoes.Dopes)
1869:             MsgAviso("Posicione o cursor sobre uma nota v" + CHR(225) + "lida.")
1870:             RETURN
1871:         ENDIF
1872:         THIS.BtnDocumentosClick()
1873:     ENDPROC
1874: 
1875:     PROCEDURE BtnVisualizarClick()
1876:         * Visualizar detalhes tecnicos (chave, protocolo, status)
1877:         * da nota fiscal apontada. Consulta SigMvNfi diretamente
1878:         * para exibir dados que nao aparecem no grid principal.
1879:         LOCAL loc_cChave, loc_cSQL, loc_oErro, loc_cMsg
1880:         LOCAL loc_cChv, loc_cProt, loc_cStat, loc_cXml
1881:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
1882:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas na fila para visualizar.")
1883:             RETURN
1884:         ENDIF
1885:         SELECT csOperacoes
1886:         IF EOF("csOperacoes")
1887:             GO TOP IN csOperacoes
1888:         ENDIF
1889:         loc_cChave = ALLTRIM(csOperacoes.Emps) + ALLTRIM(csOperacoes.Dopes) + ;
1890:                      PADL(ALLTRIM(TRANSFORM(csOperacoes.Numes)), 6, "0")
1891:         loc_cSQL = "SELECT TOP 1 nfechv, nfexml, prots, stats FROM SigMvNfi WHERE empdopnums = " + ;
1892:                    EscaparSQL(loc_cChave)
1893:         TRY
1894:             IF USED("cursor_4c_VisNfe")
1895:                 USE IN cursor_4c_VisNfe
1896:             ENDIF
1897:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VisNfe") < 1
1898:                 MsgErro("Falha ao consultar SigMvNfi para a nota selecionada.", "Visualizar")
1899:                 RETURN
1900:             ENDIF
1901:             IF RECCOUNT("cursor_4c_VisNfe") = 0
1902:                 MsgAviso("Nota fiscal ainda n" + CHR(227) + "o transmitida (sem registro em SigMvNfi).")
1903:             ELSE
1904:                 loc_cChv  = ALLTRIM(NVL(cursor_4c_VisNfe.nfechv, "N/D"))
1905:                 loc_cProt = ALLTRIM(NVL(cursor_4c_VisNfe.prots, "N/D"))
1906:                 loc_cStat = ALLTRIM(NVL(cursor_4c_VisNfe.stats, "N/D"))
1907:                 loc_cXml  = IIF(EMPTY(NVL(cursor_4c_VisNfe.nfexml, "")), "N" + CHR(227) + "o", "Sim")
1908:                 loc_cMsg = "Nota: " + ALLTRIM(csOperacoes.Notas) + CHR(13) + ;
1909:                            "S" + CHR(233) + "rie: " + ALLTRIM(csOperacoes.Series) + CHR(13) + ;
1910:                            "Chave: " + loc_cChv + CHR(13) + ;
1911:                            "Protocolo: " + loc_cProt + CHR(13) + ;
1912:                            "Status: " + loc_cStat + CHR(13) + ;
1913:                            "XML dispon" + CHR(237) + "vel: " + loc_cXml
1914:                 MsgInfo(loc_cMsg)
1915:             ENDIF
1916:             IF USED("cursor_4c_VisNfe")
1917:                 USE IN cursor_4c_VisNfe
1918:             ENDIF
1919:         CATCH TO loc_oErro
1920:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1921:                     "Erro Visualizar")
1922:         ENDTRY
1923:     ENDPROC
1924: 
1925:     PROCEDURE BtnExcluirClick()
1926:         * Excluir (limpar) a fila de processamento.
1927:         * NAO remove NFe do banco - apenas limpa csOperacoes e reabilita
1928:         * os filtros para nova selecao. Confirmacao obrigatoria.
1929:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
1930:             MsgAviso("A fila de processamento j" + CHR(225) + " est" + CHR(225) + " vazia.")
1931:             RETURN
1932:         ENDIF
1933:         IF MsgConfirma("Confirma a limpeza da fila de processamento de NFe?" + CHR(13) + ;
1934:                        "Os registros n" + CHR(227) + "o ser" + CHR(227) + "o removidos do banco de dados.")
1935:             THIS.LimpaSelecao()
1936:         ENDIF
1937:     ENDPROC
1938: 
1939:     *==========================================================================
1940:     * FASE 8 - FormParaBO / BOParaForm / HabilitarCampos / LimparCampos
1941:     * CarregarLista / AjustarBotoesPorModo / BtnSalvar / BtnCancelar / BtnBuscar
1942:     *==========================================================================
1943: 
1944:     *--------------------------------------------------------------------------
1945:     * FormParaBO - Copia TODOS os valores da UI para o Business Object.
1946:     * Cobre os 3 blocos de propriedades: parametros de sele" + CHR(231) + CHR(227) + "o
1947:     * (empresa/serie/datas/acao), flags/checkboxes e o registro corrente
1948:     * de csOperacoes (linha selecionada no grid).
1949:     *--------------------------------------------------------------------------
1950:     PROCEDURE FormParaBO()
1951:         LOCAL loc_oBO, loc_oCnt
1952:         loc_oBO = THIS.this_oBusinessObject
1953:         IF VARTYPE(loc_oBO) != "O"
1954:             RETURN .F.
1955:         ENDIF
1956:         loc_oCnt = THIS.cnt_4c_Operacoes
1957: 
1958:         *-- Bloco 1: parametros de selecao/processamento
1959:         loc_oBO.this_cEmps        = PADR(ALLTRIM(loc_oCnt.txt_4c_Emps.Value), 3)
1960:         loc_oBO.this_cSeries      = PADR(ALLTRIM(loc_oCnt.txt_4c_Series.Value), 3)
1961:         loc_oBO.this_dDtIni       = loc_oCnt.txt_4c_DtIni.Value
1962:         loc_oBO.this_dDtFin       = loc_oCnt.txt_4c_DtFin.Value
1963:         loc_oBO.this_nProcessados = loc_oCnt.opt_4c_Processados.Value
1964:         loc_oBO.this_nTipos       = loc_oCnt.opt_4c_Tipos.Value
1965:         loc_oBO.this_nAmbiente    = loc_oCnt.opt_4c_Ambiente.Value
1966:         loc_oBO.this_nAcao        = loc_oCnt.opt_4c_Acao.Value
1967:         loc_oBO.this_nImpressao   = loc_oCnt.opt_4c_Impressao.Value
1968:         loc_oBO.this_nContin      = loc_oCnt.opt_4c_Contin.Value
1969:         loc_oBO.this_cInuIni      = ALLTRIM(loc_oCnt.txt_4c_InuIni.Value)
1970:         loc_oBO.this_cInuFim      = ALLTRIM(loc_oCnt.txt_4c_InuFim.Value)
1971:         loc_oBO.this_cRegime      = ALLTRIM(loc_oCnt.cmb_4c_Regime.Value)
1972:         loc_oBO.this_cArquivos    = ALLTRIM(loc_oCnt.txt_4c_Arquivos.Value)
1973:         IF EMPTY(loc_oCnt.txt_4c_IniContin.Value)
1974:             loc_oBO.this_dIniContin = {}
1975:         ELSE
1976:             IF VARTYPE(loc_oCnt.txt_4c_IniContin.Value) = "D"
1977:                 loc_oBO.this_dIniContin = loc_oCnt.txt_4c_IniContin.Value
1978:             ELSE
1979:                 loc_oBO.this_dIniContin = CTOD(TRANSFORM(loc_oCnt.txt_4c_IniContin.Value))
1980:             ENDIF
1981:         ENDIF
1982: 
1983:         *-- Bloco 2: flags/checkboxes (Value NUMERICO 0/1 -> LOGICAL no BO)
1984:         loc_oBO.this_lHVerao  = (loc_oCnt.chk_4c_HVerao.Value = 1)
1985:         loc_oBO.this_lVenc    = (loc_oCnt.chk_4c_Venc.Value = 1)
1986:         loc_oBO.this_lOptSub  = (loc_oCnt.chk_4c_OptSub.Value = 1)
1987:         loc_oBO.this_lOptArq  = (loc_oCnt.chk_4c_OptArq.Value = 1)
1988: 
1989:         *-- Bloco 3: registro corrente do grid csOperacoes
1990:         IF USED("csOperacoes") AND !EOF("csOperacoes") AND !BOF("csOperacoes")

*-- Linhas 2014 a 2057:
2014:     * Espelho de FormParaBO, cobrindo os 3 blocos (parametros, flags e
2015:     * registro corrente do grid).
2016:     *--------------------------------------------------------------------------
2017:     PROCEDURE BOParaForm()
2018:         LOCAL loc_oBO, loc_oCnt
2019:         loc_oBO = THIS.this_oBusinessObject
2020:         IF VARTYPE(loc_oBO) != "O"
2021:             RETURN .F.
2022:         ENDIF
2023:         loc_oCnt = THIS.cnt_4c_Operacoes
2024: 
2025:         *-- Bloco 1: parametros de selecao/processamento
2026:         loc_oCnt.txt_4c_Emps.Value       = loc_oBO.this_cEmps
2027:         loc_oCnt.txt_4c_Series.Value     = loc_oBO.this_cSeries
2028:         loc_oCnt.txt_4c_DtIni.Value      = loc_oBO.this_dDtIni
2029:         loc_oCnt.txt_4c_DtFin.Value      = loc_oBO.this_dDtFin
2030:         IF loc_oBO.this_nProcessados > 0
2031:             loc_oCnt.opt_4c_Processados.Value = loc_oBO.this_nProcessados
2032:         ENDIF
2033:         IF loc_oBO.this_nTipos > 0
2034:             loc_oCnt.opt_4c_Tipos.Value = loc_oBO.this_nTipos
2035:         ENDIF
2036:         IF loc_oBO.this_nAmbiente > 0
2037:             loc_oCnt.opt_4c_Ambiente.Value = loc_oBO.this_nAmbiente
2038:         ENDIF
2039:         IF loc_oBO.this_nAcao > 0
2040:             loc_oCnt.opt_4c_Acao.Value = loc_oBO.this_nAcao
2041:         ENDIF
2042:         IF loc_oBO.this_nImpressao > 0
2043:             loc_oCnt.opt_4c_Impressao.Value = loc_oBO.this_nImpressao
2044:         ENDIF
2045:         IF loc_oBO.this_nContin > 0
2046:             loc_oCnt.opt_4c_Contin.Value = loc_oBO.this_nContin
2047:         ENDIF
2048:         loc_oCnt.txt_4c_InuIni.Value   = loc_oBO.this_cInuIni
2049:         loc_oCnt.txt_4c_InuFim.Value   = loc_oBO.this_cInuFim
2050:         loc_oCnt.cmb_4c_Regime.Value   = loc_oBO.this_cRegime
2051:         loc_oCnt.txt_4c_Arquivos.Value = loc_oBO.this_cArquivos
2052:         loc_oCnt.txt_4c_IniContin.Value = loc_oBO.this_dIniContin
2053: 
2054:         *-- Bloco 2: flags/checkboxes (LOGICAL BO -> NUMERICO 0/1 CheckBox)
2055:         loc_oCnt.chk_4c_HVerao.Value = IIF(loc_oBO.this_lHVerao, 1, 0)
2056:         loc_oCnt.chk_4c_Venc.Value   = IIF(loc_oBO.this_lVenc, 1, 0)
2057:         loc_oCnt.chk_4c_OptSub.Value = IIF(loc_oBO.this_lOptSub, 1, 0)

*-- Linhas 2068 a 2195:
2068:     * (nome nativo deste form OPERACIONAL) que implementa a logica real de
2069:     * bloquear filtros durante processamento.
2070:     *--------------------------------------------------------------------------
2071:     PROCEDURE HabilitarCampos(par_lHabilitar)
2072:         LOCAL loc_lHab
2073:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2074:         THIS.HabilitarControles(loc_lHab)
2075:     ENDPROC
2076: 
2077:     *--------------------------------------------------------------------------
2078:     * LimparCampos - Interface CRUD-padrao. Reseta filtros para valores default
2079:     * e limpa a fila de csOperacoes chamando LimpaSelecao.
2080:     *--------------------------------------------------------------------------
2081:     PROCEDURE LimparCampos()
2082:         LOCAL loc_oCnt
2083:         loc_oCnt = THIS.cnt_4c_Operacoes
2084:         loc_oCnt.txt_4c_Emps.Value        = ""
2085:         loc_oCnt.txt_4c_Series.Value      = ""
2086:         loc_oCnt.txt_4c_DtIni.Value       = {}
2087:         loc_oCnt.txt_4c_DtFin.Value       = {}
2088:         loc_oCnt.txt_4c_InuIni.Value      = ""
2089:         loc_oCnt.txt_4c_InuFim.Value      = ""
2090:         loc_oCnt.txt_4c_Arquivos.Value    = ""
2091:         loc_oCnt.opt_4c_Processados.Value = 1
2092:         loc_oCnt.opt_4c_Tipos.Value       = 1
2093:         loc_oCnt.opt_4c_Ambiente.Value    = 1
2094:         loc_oCnt.opt_4c_Acao.Value        = 1
2095:         loc_oCnt.opt_4c_Impressao.Value   = 1
2096:         loc_oCnt.opt_4c_Contin.Value      = 1
2097:         loc_oCnt.chk_4c_HVerao.Value      = 0
2098:         loc_oCnt.chk_4c_Venc.Value        = 0
2099:         loc_oCnt.chk_4c_OptSub.Value      = 0
2100:         loc_oCnt.chk_4c_OptArq.Value      = 0
2101:         THIS.LimpaSelecao()
2102:     ENDPROC
2103: 
2104:     *--------------------------------------------------------------------------
2105:     * CarregarLista - Interface CRUD-padrao. Executa a selecao inicial das
2106:     * notas fiscais no banco (SigMvNfi) para o cursor csOperacoes que popula
2107:     * o grid principal. Delega para BtnSelecionarClick que reproduz o Selecionar
2108:     * do form legado.
2109:     *--------------------------------------------------------------------------
2110:     PROCEDURE CarregarLista()
2111:         LOCAL loc_cEmps, loc_dDtIni, loc_dDtFin
2112:         loc_cEmps  = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value)
2113:         loc_dDtIni = THIS.cnt_4c_Operacoes.txt_4c_DtIni.Value
2114:         loc_dDtFin = THIS.cnt_4c_Operacoes.txt_4c_DtFin.Value
2115:         IF EMPTY(loc_cEmps) OR EMPTY(loc_dDtIni) OR EMPTY(loc_dDtFin)
2116:             RETURN .F.
2117:         ENDIF
2118:         THIS.BtnSelecionarClick(.T.)
2119:         RETURN USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
2120:     ENDPROC
2121: 
2122:     *--------------------------------------------------------------------------
2123:     * AjustarBotoesPorModo - Interface CRUD-padrao. Neste form OPERACIONAL
2124:     * ha 2 modos logicos:
2125:     *   MODO=1 (LIVRE):     filtros habilitados, botoes de acao em grid off.
2126:     *   MODO=2 (SELECAO):   filtros bloqueados, botoes de acao em grid on.
2127:     * A rotina espelha o comportamento de HabilitarControles com semantica
2128:     * de "modo" para compatibilidade com o pipeline CRUD.
2129:     *--------------------------------------------------------------------------
2130:     PROCEDURE AjustarBotoesPorModo(par_nModo)
2131:         LOCAL loc_nModo
2132:         loc_nModo = IIF(VARTYPE(par_nModo) = "N", par_nModo, 1)
2133:         IF loc_nModo = 1
2134:             THIS.HabilitarControles(.T.)
2135:         ELSE
2136:             THIS.HabilitarControles(.F.)
2137:         ENDIF
2138:     ENDPROC
2139: 
2140:     *--------------------------------------------------------------------------
2141:     * BtnSalvarClick - Interface CRUD-padrao. Em contexto NFe "Salvar" equivale
2142:     * a processar (transmitir SEFAZ / gerar TXT / imprimir DANFE) as notas
2143:     * marcadas no grid. Delega para BtnCopiarClick que aciona o
2144:     * BO.Processar/Processamento conforme opt_4c_Acao.
2145:     *--------------------------------------------------------------------------
2146:     PROCEDURE BtnSalvarClick()
2147:         LOCAL loc_nSel
2148:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
2149:             MsgAviso("A fila de processamento est" + CHR(225) + " vazia. Use Buscar/Selecionar antes.")
2150:             RETURN
2151:         ENDIF
2152:         SELECT COUNT(*) AS nSel FROM csOperacoes WHERE SelImp INTO CURSOR cursor_4c_SelSalv
2153:         loc_nSel = cursor_4c_SelSalv.nSel
2154:         USE IN cursor_4c_SelSalv
2155:         IF loc_nSel < 1
2156:             MsgAviso("Nenhuma nota est" + CHR(225) + " marcada para processamento.")
2157:             RETURN
2158:         ENDIF
2159:         THIS.FormParaBO()
2160:         THIS.BtnCopiarClick()
2161:     ENDPROC
2162: 
2163:     *--------------------------------------------------------------------------
2164:     * BtnCancelarClick - Interface CRUD-padrao. Cancela a selecao atual e
2165:     * reabilita os filtros de busca (equivale ao Limpar do form legado).
2166:     *--------------------------------------------------------------------------
2167:     PROCEDURE BtnCancelarClick()
2168:         IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
2169:             IF !MsgConfirma("Confirma o cancelamento da sele" + CHR(231) + CHR(227) + ;
2170:                             "o? A fila ser" + CHR(225) + " limpa.")
2171:                 RETURN
2172:             ENDIF
2173:         ENDIF
2174:         THIS.BtnLimparClick()
2175:     ENDPROC
2176: 
2177:     *--------------------------------------------------------------------------
2178:     * BtnBuscarClick - Interface CRUD-padrao. Aciona a selecao no banco
2179:     * segundo os filtros informados. Delega para BtnSelecionarClick que
2180:     * reproduz o Selecionar do form legado (grupo de botoes cmdSelecionar).
2181:     *--------------------------------------------------------------------------
2182:     PROCEDURE BtnBuscarClick()
2183:         THIS.BtnSelecionarClick()
2184:     ENDPROC
2185: 
2186:     *==========================================================================
2187:     PROCEDURE Destroy()
2188:     *==========================================================================
2189:         IF USED("csOperacoes")
2190:             USE IN csOperacoes
2191:         ENDIF
2192:         DODEFAULT()
2193:     ENDPROC
2194: 
2195: ENDDEFINE

