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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprnfe.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2211 linhas total):

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

*-- Linhas 1246 a 2006:
1246:     ENDPROC
1247: 
1248:     *==========================================================================
1249:     * TornarControlesVisiveis: torna visiveis todos os controles de nivel raiz,
1250:     * exceto os containers gerenciados individualmente (INLIST). cnt_4c_Inu e
1251:     * cmd_4c_Inu sao reocultados explicitamente apos o loop.
1252:     *==========================================================================
1253:     PROCEDURE TornarControlesVisiveis()
1254:         LOCAL loc_oErro, loc_oCtrl, loc_cNome
1255:         TRY
1256:             FOR EACH loc_oCtrl IN THIS.Controls
1257:                 IF VARTYPE(loc_oCtrl) = "O"
1258:                     loc_cNome = LOWER(loc_oCtrl.Name)
1259:                     IF INLIST(loc_cNome, "cnt_4c_sombra", "cnt_4c_grade")
1260:                         *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
1261:                         IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1262:                             THIS.TornarControlesVisiveis(loc_oControl)
1263:                         ENDIF
1264:                         LOOP
1265:                     ENDIF
1266:                     loc_oCtrl.Visible = .T.
1267:                 ENDIF
1268:             ENDFOR
1269:             IF PEMSTATUS(THIS, "cnt_4c_Inu", 5)
1270:                 THIS.cnt_4c_Inu.Visible = .F.
1271:             ENDIF
1272:             IF PEMSTATUS(THIS, "cnt_4c_Operacoes", 5)
1273:                 IF PEMSTATUS(THIS.cnt_4c_Operacoes, "cmd_4c_Inu", 5)
1274:                     THIS.cnt_4c_Operacoes.cmd_4c_Inu.Visible = .F.
1275:                 ENDIF
1276:             ENDIF
1277:         CATCH TO loc_oErro
1278:             MsgErro(loc_oErro.Message, "Erro TornarControlesVisiveis")
1279:         ENDTRY
1280:     ENDPROC
1281: 
1282:     *==========================================================================
1283:     * ConfigurarPaginaLista - Restaura visao principal do form OPERACIONAL
1284:     * (grade + botoes de acao + filtros) escondendo o painel flutuante de
1285:     * inutilizacao. Equivalente ao Page1=LISTA dos forms CRUD; chamado por
1286:     * AlternarPagina(1) e apos cada processamento para reset visual.
1287:     *==========================================================================
1288:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1289:         LOCAL loc_oErro
1290:         TRY
1291:             IF PEMSTATUS(THIS, "cnt_4c_Inu", 5)
1292:                 THIS.cnt_4c_Inu.Visible = .F.
1293:             ENDIF
1294:             IF PEMSTATUS(THIS, "cnt_4c_Operacoes", 5)
1295:                 THIS.cnt_4c_Operacoes.Visible = .T.
1296:             ENDIF
1297:             IF PEMSTATUS(THIS, "cnt_4c_Grade", 5)
1298:                 THIS.cnt_4c_Grade.Visible = .T.
1299:                 IF PEMSTATUS(THIS.cnt_4c_Grade, "grd_4c_Operacoes", 5)
1300:                     THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1301:                 ENDIF
1302:             ENDIF
1303:             IF PEMSTATUS(THIS, "cmd_4c_Selecionar", 5)
1304:                 THIS.cmd_4c_Selecionar.Enabled = .T.
1305:             ENDIF
1306:         CATCH TO loc_oErro
1307:             MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaLista")
1308:         ENDTRY
1309:     ENDPROC
1310: 
1311:     *==========================================================================
1312:     * ConfigurarPaginaDados - Exibe painel flutuante de inutilizacao (overlay)
1313:     * Form OPERACIONAL nao possui PageFrame; cnt_4c_Inu atua como "Page2=Dados"
1314:     * para captura da grade de inutilizacao. Chamado por AlternarPagina(2) e
1315:     * CmdInuClick apos SelecionarInutilizadas popular csInutil. Refresh() garante
1316:     * repaint do grid apos GO TOP e cursor recem-carregado.
1317:     *==========================================================================
1318:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1319:         LOCAL loc_oErro
1320:         TRY
1321:             IF PEMSTATUS(THIS, "cnt_4c_Inu", 5)
1322:                 THIS.cnt_4c_Inu.Visible = .T.
1323:                 IF PEMSTATUS(THIS.cnt_4c_Inu, "grd_4c_Inu", 5)
1324:                     IF USED("csInutil")
1325:                         THIS.cnt_4c_Inu.grd_4c_Inu.RecordSource = "csInutil"
1326:                     ENDIF
1327:                     THIS.cnt_4c_Inu.grd_4c_Inu.Refresh()
1328:                 ENDIF
1329:                 IF PEMSTATUS(THIS.cnt_4c_Inu, "cmd_4c_BtnProcInu", 5)
1330:                     THIS.cnt_4c_Inu.cmd_4c_BtnProcInu.Enabled = ;
1331:                         (USED("csInutil") AND RECCOUNT("csInutil") > 0)
1332:                 ENDIF
1333:                 THIS.cnt_4c_Inu.ZOrder(0)
1334:             ENDIF
1335:         CATCH TO loc_oErro
1336:             MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaDados")
1337:         ENDTRY
1338:     ENDPROC
1339: 
1340:     *==========================================================================
1341:     * AlternarPagina - Alterna entre visao principal (1) e overlay Inutilizar (2)
1342:     * Form OPERACIONAL nao possui PageFrame; usa cnt_4c_Inu como painel flutuante
1343:     * que funciona logicamente como uma "segunda pagina" para captura de dados
1344:     * de inutilizacao. par_nPagina = 1 restaura visao principal; = 2 abre overlay.
1345:     *==========================================================================
1346:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1347:         LOCAL loc_nPag, loc_oErro
1348:         loc_nPag = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
1349:         TRY
1350:             DO CASE
1351:                 CASE loc_nPag = 2
1352:                     THIS.ConfigurarPaginaDados()
1353:                 OTHERWISE
1354:                     THIS.ConfigurarPaginaLista()
1355:             ENDCASE
1356:         CATCH TO loc_oErro
1357:             MsgErro(loc_oErro.Message, "Erro AlternarPagina")
1358:         ENDTRY
1359:     ENDPROC
1360: 
1361:     *==========================================================================
1362:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
1363:     *==========================================================================
1364:         LOCAL loc_oGrd
1365:         BINDEVENT(THIS.cmd_4c_Selecionar, "Click", THIS, "BtnSelecionarClick")
1366:         BINDEVENT(THIS.cmd_4c_BtnLimpar,  "Click", THIS, "BtnLimparClick")
1367:         BINDEVENT(THIS.cmd_4c_BtnCopiar,  "Click", THIS, "BtnCopiarClick")
1368:         BINDEVENT(THIS.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
1369:         BINDEVENT(THIS.cmd_4c_MarcaTudo,  "Click", THIS, "BtnMarcaTudoClick")
1370:         BINDEVENT(THIS.cmd_4c_Desmarcar,  "Click", THIS, "BtnDesmarcarClick")
1371:         BINDEVENT(THIS.cmd_4c_Documentos, "Click", THIS, "BtnDocumentosClick")
1372:         BINDEVENT(THIS.cmd_4c_ImpDSimpl,  "Click", THIS, "BtnImpDSimplClick")
1373:         BINDEVENT(THIS.cnt_4c_Inu.cmd_4c_BtnCancelaInu, "Click", THIS, "BtnCancelaInuClick")
1374:         BINDEVENT(THIS.cnt_4c_Inu.cmd_4c_BtnProcInu,    "Click", THIS, "BtnProcInuClick")
1375:         BINDEVENT(THIS.cnt_4c_Operacoes.txt_4c_Emps,    "KeyPress", THIS, "EmpsLostFocus")
1376:         BINDEVENT(THIS.cnt_4c_Operacoes.txt_4c_Series,  "KeyPress", THIS, "SeriesLostFocus")
1377:         BINDEVENT(THIS.cnt_4c_Operacoes.opt_4c_Acao, "InteractiveChange", THIS, "AcaoInteractiveChange")
1378:         BINDEVENT(THIS.cnt_4c_Operacoes.cmd_4c_Inu,  "Click", THIS, "CmdInuClick")
1379:         loc_oGrd = THIS.cnt_4c_Grade.grd_4c_Operacoes
1380:         BINDEVENT(loc_oGrd.Column1.chk_4c_SelImp, "MouseUp",  THIS, "GridChkMouseUp")
1381:         BINDEVENT(loc_oGrd.Column1.chk_4c_SelImp, "KeyPress", THIS, "GridChkKeyPress")
1382:     ENDPROC
1383: 
1384:     *==========================================================================
1385:     * HANDLERS DE EVENTOS
1386:     *==========================================================================
1387: 
1388:     PROCEDURE BtnSelecionarClick
1389:         LPARAMETERS par_lForcado
1390:         LOCAL loc_cEmps, loc_cSeries, loc_dDtIni, loc_dDtFin
1391:         LOCAL loc_nProcessados, loc_nTipos, loc_nAcao
1392:         LOCAL loc_cInuIni, loc_cInuFim, loc_oBO, loc_oErro, loc_lSelOk
1393: 
1394:         loc_oBO = THIS.this_oBusinessObject
1395: 
1396:         loc_cEmps        = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
1397:         loc_cSeries      = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3)
1398:         loc_dDtIni       = THIS.cnt_4c_Operacoes.txt_4c_DtIni.Value
1399:         loc_dDtFin       = THIS.cnt_4c_Operacoes.txt_4c_DtFin.Value
1400:         loc_nProcessados = THIS.cnt_4c_Operacoes.opt_4c_Processados.Value
1401:         loc_nTipos       = THIS.cnt_4c_Operacoes.opt_4c_Tipos.Value
1402:         loc_nAcao        = THIS.cnt_4c_Operacoes.opt_4c_Acao.Value
1403:         loc_cInuIni      = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuIni.Value)
1404:         loc_cInuFim      = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuFim.Value)
1405: 
1406:         IF VARTYPE(par_lForcado) != "L" OR !par_lForcado
1407:             IF loc_nProcessados = 2
1408:                 IF !MsgConfirma("Confirma a Sele" + CHR(231) + CHR(227) + "o de Opera" + ;
1409:                                 CHR(231) + CHR(245) + "es J" + CHR(225) + " Processadas Anteriormente?")
1410:                     THIS.cnt_4c_Operacoes.opt_4c_Processados.Value = 1
1411:                     RETURN
1412:                 ENDIF
1413:             ENDIF
1414:         ENDIF
1415: 
1416:         IF EMPTY(ALLTRIM(loc_cEmps))
1417:             MsgAviso("A Empresa N" + CHR(227) + "o Foi Informada!!!")
1418:             THIS.cnt_4c_Operacoes.txt_4c_Emps.SetFocus()
1419:             RETURN
1420:         ENDIF
1421:         IF EMPTY(loc_dDtIni)
1422:             MsgAviso("A Data Inicial N" + CHR(227) + "o Foi Informada!!!")
1423:             THIS.cnt_4c_Operacoes.txt_4c_DtIni.SetFocus()
1424:             RETURN
1425:         ENDIF
1426:         IF EMPTY(loc_dDtFin)
1427:             MsgAviso("A Data Final N" + CHR(227) + "o Foi Informada!!!")
1428:             THIS.cnt_4c_Operacoes.txt_4c_DtFin.SetFocus()
1429:             RETURN
1430:         ENDIF
1431:         IF loc_dDtFin < loc_dDtIni
1432:             MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!")
1433:             THIS.cnt_4c_Operacoes.txt_4c_DtFin.SetFocus()
1434:             RETURN
1435:         ENDIF
1436:         IF INLIST(loc_nAcao, 4, 7)
1437:             IF (loc_cInuFim < loc_cInuIni) OR EMPTY(loc_cInuFim) OR EMPTY(loc_cInuIni)
1438:                 MsgAviso("A Numera" + CHR(231) + CHR(227) + "o informada est" + CHR(225) + " inconsistente!!!")
1439:                 THIS.cnt_4c_Operacoes.txt_4c_InuFim.SetFocus()
1440:                 RETURN
1441:             ENDIF
1442:         ENDIF
1443: 
1444:         loc_oBO.this_cEmps        = loc_cEmps
1445:         loc_oBO.this_cSeries      = loc_cSeries
1446:         loc_oBO.this_dDtIni       = loc_dDtIni
1447:         loc_oBO.this_dDtFin       = loc_dDtFin
1448:         loc_oBO.this_nProcessados = loc_nProcessados
1449:         loc_oBO.this_nTipos       = loc_nTipos
1450:         loc_oBO.this_nAcao        = loc_nAcao
1451:         loc_oBO.this_cInuIni      = loc_cInuIni
1452:         loc_oBO.this_cInuFim      = loc_cInuFim
1453: 
1454:         loc_lSelOk = .T.
1455:         TRY
1456:             loc_oBO.Selecionar("csOperacoes")
1457:         CATCH TO loc_oErro
1458:             MsgErro(loc_oErro.Message, "Erro Selecionar")
1459:             loc_lSelOk = .F.
1460:         ENDTRY
1461:         IF !loc_lSelOk
1462:             RETURN
1463:         ENDIF
1464: 
1465:         THIS.HabilitarControles(.F.)
1466: 
1467:         SELECT csOperacoes
1468:         SET ORDER TO Notas
1469:         GO TOP IN csOperacoes
1470:         IF EOF("csOperacoes")
1471:             IF INLIST(loc_nAcao, 1, 2, 3, 5)
1472:                 MsgAviso("Nenhuma Nota Foi Encontrada Para Processamento!!!")
1473:                 THIS.LimpaSelecao()
1474:                 THIS.cnt_4c_Operacoes.txt_4c_Series.SetFocus()
1475:             ENDIF
1476:         ELSE
1477:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1478:         ENDIF
1479:     ENDPROC
1480: 
1481:     PROCEDURE BtnLimparClick()
1482:         THIS.LimpaSelecao()
1483:     ENDPROC
1484: 
1485:     PROCEDURE BtnCopiarClick()
1486:         LOCAL loc_nAcao, loc_nSel, loc_oBO, loc_oErro
1487:         loc_nAcao = THIS.cnt_4c_Operacoes.opt_4c_Acao.Value
1488:         IF INLIST(loc_nAcao, 1, 2, 3, 5, 6)
1489:             IF USED("cursor_4c_SelChk")
1490:                 USE IN cursor_4c_SelChk
1491:             ENDIF
1492:             SELECT COUNT(*) AS nSel FROM csOperacoes WHERE SelImp INTO CURSOR cursor_4c_SelChk
1493:             loc_nSel = cursor_4c_SelChk.nSel
1494:             USE IN cursor_4c_SelChk
1495:             IF loc_nSel < 1
1496:                 MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Selecionado para Processamento!!!")
1497:                 THIS.cnt_4c_Grade.grd_4c_Operacoes.SetFocus()
1498:                 RETURN
1499:             ENDIF
1500:         ENDIF
1501:         loc_oBO = THIS.this_oBusinessObject
1502:         loc_oBO.this_nAcao      = loc_nAcao
1503:         loc_oBO.this_nAmbiente  = THIS.cnt_4c_Operacoes.opt_4c_Ambiente.Value
1504:         loc_oBO.this_nTipos     = THIS.cnt_4c_Operacoes.opt_4c_Tipos.Value
1505:         loc_oBO.this_nImpressao = THIS.cnt_4c_Operacoes.opt_4c_Impressao.Value
1506:         loc_oBO.this_nContin    = THIS.cnt_4c_Operacoes.opt_4c_Contin.Value
1507:         loc_oBO.this_cArquivos  = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Arquivos.Value)
1508:         loc_oBO.this_lHVerao    = (THIS.cnt_4c_Operacoes.chk_4c_HVerao.Value = 1)
1509:         loc_oBO.this_lVenc      = (THIS.cnt_4c_Operacoes.chk_4c_Venc.Value = 1)
1510:         loc_oBO.this_lOptSub    = (THIS.cnt_4c_Operacoes.chk_4c_OptSub.Value = 1)
1511:         loc_oBO.this_lOptArq    = (THIS.cnt_4c_Operacoes.chk_4c_OptArq.Value = 1)
1512:         TRY
1513:             loc_oBO.Processamento( ;
1514:                 PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3), ;
1515:                 PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3))
1516:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1517:         CATCH TO loc_oErro
1518:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1519:                     "Erro Processar")
1520:         ENDTRY
1521:     ENDPROC
1522: 
1523:     PROCEDURE BtnEncerrarClick()
1524:         THIS.Release()
1525:     ENDPROC
1526: 
1527:     PROCEDURE BtnMarcaTudoClick()
1528:         IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
1529:             SELECT csOperacoes
1530:             REPLACE ALL SelImp WITH .T.
1531:             GO TOP IN csOperacoes
1532:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1533:         ENDIF
1534:     ENDPROC
1535: 
1536:     PROCEDURE BtnDesmarcarClick()
1537:         IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
1538:             SELECT csOperacoes
1539:             REPLACE ALL SelImp WITH .F.
1540:             GO TOP IN csOperacoes
1541:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1542:         ENDIF
1543:     ENDPROC
1544: 
1545:     PROCEDURE BtnDocumentosClick()
1546:         LOCAL loc_cDopes, loc_nNumes, loc_cEmps, loc_oForm, loc_oErro
1547:         IF !USED("csOperacoes") OR EOF("csOperacoes")
1548:             MsgAviso("Posicione o cursor em um registro.")
1549:             RETURN
1550:         ENDIF
1551:         SELECT csOperacoes
1552:         loc_cDopes = ALLTRIM(csOperacoes.Dopes)
1553:         loc_nNumes = csOperacoes.Numes
1554:         loc_cEmps  = ALLTRIM(csOperacoes.Emps)
1555:         TRY
1556:             loc_oForm = CREATEOBJECT("Formsigmvexp", loc_cDopes, "C", loc_nNumes, loc_cEmps)
1557:             IF VARTYPE(loc_oForm) = "O"
1558:                 loc_oForm.Show()
1559:             ELSE
1560:                 MsgErro("Erro ao criar Formsigmvexp. VARTYPE retornou: " + ;
1561:                         VARTYPE(loc_oForm), "Documentos")
1562:             ENDIF
1563:         CATCH TO loc_oErro
1564:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1565:                     "Erro ao abrir Documentos")
1566:         ENDTRY
1567:     ENDPROC
1568: 
1569:     PROCEDURE BtnImpDSimplClick()
1570:         LOCAL loc_oBO, loc_oErro
1571:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
1572:             MsgAviso("Nenhuma nota encontrada para impress" + CHR(227) + "o.")
1573:             RETURN
1574:         ENDIF
1575:         loc_oBO = THIS.this_oBusinessObject
1576:         TRY
1577:             loc_oBO.ImprimirSimplificado("csOperacoes")
1578:         CATCH TO loc_oErro
1579:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1580:                     "Erro Impress" + CHR(227) + "o")
1581:         ENDTRY
1582:     ENDPROC
1583: 
1584:     PROCEDURE BtnCancelaInuClick()
1585:         THIS.AlternarPagina(1)
1586:     ENDPROC
1587: 
1588:     PROCEDURE BtnProcInuClick()
1589:         LOCAL loc_cEmps, loc_cSeries, loc_cCnpj, loc_cNIni, loc_cNFim, loc_oBO, loc_oErro
1590:         IF !INLIST(THIS.cnt_4c_Operacoes.opt_4c_Acao.Value, 4, 7)
1591:             MsgAviso("Selecione a a" + CHR(231) + CHR(227) + "o Inutilizar ou Status.")
1592:             RETURN
1593:         ENDIF
1594:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value))
1595:             MsgAviso("Empresa n" + CHR(227) + "o informada.")
1596:             RETURN
1597:         ENDIF
1598:         IF !USED("csInutil") OR RECCOUNT("csInutil") = 0
1599:             MsgAviso("Nenhuma nota fiscal para inutilizar.")
1600:             RETURN
1601:         ENDIF
1602:         loc_cEmps   = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
1603:         loc_cSeries = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3)
1604:         loc_cNIni   = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuIni.Value)
1605:         loc_cNFim   = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuFim.Value)
1606:         SELECT csInutil
1607:         GO TOP IN csInutil
1608:         loc_cCnpj = ALLTRIM(csInutil.cnpj)
1609:         loc_oBO = THIS.this_oBusinessObject
1610:         TRY
1611:             loc_oBO.ProcessaInutilizadas(loc_cEmps, loc_cSeries, loc_cCnpj, loc_cNIni, loc_cNFim)
1612:         CATCH TO loc_oErro
1613:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1614:                     "Erro Inutilizar")
1615:         ENDTRY
1616:         THIS.AlternarPagina(1)
1617:     ENDPROC
1618: 
1619:     PROCEDURE AcaoInteractiveChange()
1620:         IF PEMSTATUS(THIS.cnt_4c_Operacoes, "cmd_4c_Inu", 5)
1621:             THIS.cnt_4c_Operacoes.cmd_4c_Inu.Visible = ;
1622:                 INLIST(THIS.cnt_4c_Operacoes.opt_4c_Acao.Value, 4, 7)
1623:         ENDIF
1624:     ENDPROC
1625: 
1626:     PROCEDURE CmdInuClick()
1627:         LOCAL loc_cEmps, loc_oBO, loc_oErro
1628:         loc_cEmps = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
1629:         IF EMPTY(ALLTRIM(loc_cEmps))
1630:             MsgAviso("Informe a empresa antes de consultar inutiliza" + CHR(231) + CHR(245) + "es.")
1631:             RETURN
1632:         ENDIF
1633:         loc_oBO = THIS.this_oBusinessObject
1634:         TRY
1635:             *-- Carrega nfAinu com gap analysis via BO
1636:             loc_oBO.SelecionarInutilizadas(loc_cEmps)
1637:             IF USED("nfAinu")
1638:                 SELECT 1 AS nMarca, emps, series, notai, notaf, cnpj ;
1639:                     FROM nfAinu ;
1640:                     WHERE RTRIM(emps) = RTRIM(loc_cEmps) ;
1641:                     INTO CURSOR csInutil READWRITE
1642:                 IF USED("csInutil") AND RECCOUNT("csInutil") > 0
1643:                     GO TOP IN csInutil
1644:                     THIS.cnt_4c_Inu.grd_4c_Inu.RecordSource = "csInutil"
1645:                     WITH THIS.cnt_4c_Inu.grd_4c_Inu
1646:                         .Column1.ControlSource = "csInutil.emps"
1647:                         .Column2.ControlSource = "csInutil.series"
1648:                         .Column3.ControlSource = "csInutil.notai"
1649:                         .Column4.ControlSource = "csInutil.notaf"
1650:                         .Column5.ControlSource = "csInutil.cnpj"
1651:                         .Column6.ControlSource = "csInutil.nMarca"
1652:                         .Refresh()
1653:                     ENDWITH
1654:                     THIS.AlternarPagina(2)
1655:                 ELSE
1656:                     MsgAviso("Nenhuma nota para inutilizar encontrada para esta empresa.")
1657:                 ENDIF
1658:             ELSE
1659:                 MsgAviso("Nenhuma nota para inutilizar encontrada.")
1660:             ENDIF
1661:         CATCH TO loc_oErro
1662:             MsgErro(loc_oErro.Message, "Erro CmdInu")
1663:         ENDTRY
1664:     ENDPROC
1665: 
1666:     PROCEDURE EmpsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1667:         IF !INLIST(par_nKeyCode, 9, 13, 115)
1668:             RETURN
1669:         ENDIF
1670:         IF par_nKeyCode = 115  && F4 - abrir picker direto
1671:             THIS.AbrirBuscaEmps()
1672:             RETURN
1673:         ENDIF
1674:         LOCAL loc_cEmps, loc_oBO, loc_oErro
1675:         loc_cEmps = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
1676:         IF EMPTY(ALLTRIM(loc_cEmps))
1677:             RETURN
1678:         ENDIF
1679:         loc_oBO = THIS.this_oBusinessObject
1680:         TRY
1681:             IF loc_oBO.CarregarEmpresa(ALLTRIM(loc_cEmps))
1682:                 THIS.PreencherRegimeEmpresa(loc_oBO)
1683:             ELSE
1684:                 THIS.AbrirBuscaEmps()
1685:             ENDIF
1686:         CATCH TO loc_oErro
1687:             MsgErro(loc_oErro.Message, "Erro ao carregar empresa")
1688:         ENDTRY
1689:     ENDPROC
1690: 
1691:     PROTECTED PROCEDURE PreencherRegimeEmpresa(par_oBO)
1692:         DO CASE
1693:             CASE par_oBO.this_nRegimeEmp = 1
1694:                 THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Simples Nacional"
1695:             CASE par_oBO.this_nRegimeEmp = 2
1696:                 THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Lucro Presumido"
1697:             CASE par_oBO.this_nRegimeEmp = 3
1698:                 THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Lucro Real"
1699:             CASE par_oBO.this_nRegimeEmp = 4
1700:                 THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Lucro Arbitrado"
1701:         ENDCASE
1702:         IF !EMPTY(par_oBO.this_cArquivos)
1703:             THIS.cnt_4c_Operacoes.txt_4c_Arquivos.Value = par_oBO.this_cArquivos
1704:         ENDIF
1705:     ENDPROC
1706: 
1707:     PROCEDURE AbrirBuscaEmps()
1708:         LOCAL loc_oBusca, loc_cCemps, loc_oBO, loc_oErro
1709:         TRY
1710:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1711:                 "SigCdEmp", ;
1712:                 "cursor_4c_BuscaEmp", ;
1713:                 "Cemps", ;
1714:                 ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), ;
1715:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
1716:                 .T., .T., "Ativas <> 2")
1717:             loc_oBusca.mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
1718:             loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
1719:             loc_oBusca.Show()
1720:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1721:                 loc_cCemps = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1722:                 THIS.cnt_4c_Operacoes.txt_4c_Emps.Value = loc_cCemps
1723:                 loc_oBO = THIS.this_oBusinessObject
1724:                 IF loc_oBO.CarregarEmpresa(loc_cCemps)
1725:                     THIS.PreencherRegimeEmpresa(loc_oBO)
1726:                 ENDIF
1727:             ENDIF
1728:         CATCH TO loc_oErro
1729:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaEmps")
1730:         ENDTRY
1731:         IF USED("cursor_4c_BuscaEmp")
1732:             USE IN cursor_4c_BuscaEmp
1733:         ENDIF
1734:         IF VARTYPE(loc_oBusca) = "O"
1735:             loc_oBusca.Release()
1736:         ENDIF
1737:     ENDPROC
1738: 
1739:     PROCEDURE SeriesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1740:         IF !INLIST(par_nKeyCode, 9, 13, 115)
1741:             RETURN
1742:         ENDIF
1743:         IF par_nKeyCode = 115  && F4 - abrir picker direto
1744:             THIS.AbrirBuscaSeries()
1745:             RETURN
1746:         ENDIF
1747:         LOCAL loc_cSeries, loc_nResult, loc_oErro
1748:         loc_cSeries = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value)
1749:         IF EMPTY(loc_cSeries)
1750:             RETURN
1751:         ENDIF
1752:         TRY
1753:             loc_nResult = SQLEXEC(gnConnHandle, ;
1754:                 "SELECT Cods FROM SigCdSer WHERE ImpNfs = 3 AND LTRIM(RTRIM(Cods)) = " + ;
1755:                 EscaparSQL(loc_cSeries), "cursor_4c_SerValid")
1756:             IF loc_nResult > 0 AND USED("cursor_4c_SerValid") AND !EOF("cursor_4c_SerValid")
1757:                 THIS.cnt_4c_Operacoes.txt_4c_Series.Value = ALLTRIM(cursor_4c_SerValid.Cods)
1758:             ELSE
1759:                 THIS.AbrirBuscaSeries()
1760:             ENDIF
1761:             IF USED("cursor_4c_SerValid")
1762:                 USE IN cursor_4c_SerValid
1763:             ENDIF
1764:         CATCH TO loc_oErro
1765:             MsgErro(loc_oErro.Message, "Erro ao validar s" + CHR(233) + "rie")
1766:         ENDTRY
1767:     ENDPROC
1768: 
1769:     PROCEDURE AbrirBuscaSeries()
1770:         LOCAL loc_oBusca, loc_cCods, loc_oErro
1771:         TRY
1772:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1773:                 "SigCdSer", ;
1774:                 "cursor_4c_BuscaSeries", ;
1775:                 "Cods", ;
1776:                 ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), ;
1777:                 "Sele" + CHR(231) + CHR(227) + "o de S" + CHR(233) + "rie", ;
1778:                 .T., .T., "ImpNfs = 3")
1779:             loc_oBusca.mAddColuna("Cods", "", "S" + CHR(233) + "rie")
1780:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1781:             loc_oBusca.Show()
1782:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSeries")
1783:                 loc_cCods = ALLTRIM(cursor_4c_BuscaSeries.Cods)
1784:                 THIS.cnt_4c_Operacoes.txt_4c_Series.Value = loc_cCods
1785:             ENDIF
1786:         CATCH TO loc_oErro
1787:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaSeries")
1788:         ENDTRY
1789:         IF USED("cursor_4c_BuscaSeries")
1790:             USE IN cursor_4c_BuscaSeries
1791:         ENDIF
1792:         IF VARTYPE(loc_oBusca) = "O"
1793:             loc_oBusca.Release()
1794:         ENDIF
1795:     ENDPROC
1796: 
1797:     *-- MouseUp no CheckBox de selecao: toggle SelImp do registro corrente
1798:     PROCEDURE GridChkMouseUp
1799:         LPARAMETERS par_nButton, par_nShift, par_nXCoord, par_nYCoord
1800:         IF USED("csOperacoes") AND !EOF("csOperacoes")
1801:             m.SelImp = (NOT csOperacoes.SelImp)
1802:             SELECT csOperacoes
1803:             GATHER MEMVAR FIELDS SelImp
1804:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1805:         ENDIF
1806:         NODEFAULT
1807:     ENDPROC
1808: 
1809:     *-- KeyPress no CheckBox de selecao: Enter/Space faz toggle
1810:     PROCEDURE GridChkKeyPress
1811:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1812:         IF INLIST(par_nKeyCode, 13, 32) AND USED("csOperacoes") AND !EOF("csOperacoes")
1813:             m.SelImp = (NOT csOperacoes.SelImp)
1814:             SELECT csOperacoes
1815:             GATHER MEMVAR FIELDS SelImp
1816:             THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
1817:             NODEFAULT
1818:         ENDIF
1819:     ENDPROC
1820: 
1821:     PROCEDURE LimpaSelecao()
1822:         IF USED("csOperacoes")
1823:             ZAP IN csOperacoes
1824:         ENDIF
1825:         THIS.HabilitarControles(.T.)
1826:         THIS.cmd_4c_ImpDSimpl.Enabled = .F.
1827:         THIS.Refresh()
1828:     ENDPROC
1829: 
1830:     PROCEDURE HabilitarControles(par_lHabilitar)
1831:         WITH THIS.cnt_4c_Operacoes
1832:             .txt_4c_Emps.Enabled                   = par_lHabilitar
1833:             .txt_4c_Series.Enabled                 = par_lHabilitar
1834:             .txt_4c_DtIni.Enabled                  = par_lHabilitar
1835:             .txt_4c_DtFin.Enabled                  = par_lHabilitar
1836:             .txt_4c_InuIni.Enabled                 = par_lHabilitar
1837:             .txt_4c_InuFim.Enabled                 = par_lHabilitar
1838:             .cmb_4c_Regime.Enabled                 = par_lHabilitar
1839:             .opt_4c_Processados.Buttons(1).Enabled = par_lHabilitar
1840:             .opt_4c_Processados.Buttons(2).Enabled = par_lHabilitar
1841:             .Visible     = .T.
1842:         ENDWITH
1843:         THIS.cmd_4c_Selecionar.Enabled = par_lHabilitar
1844:         THIS.cmd_4c_BtnLimpar.Enabled  = !par_lHabilitar
1845:         THIS.cmd_4c_BtnCopiar.Enabled  = !par_lHabilitar
1846:         THIS.cmd_4c_MarcaTudo.Enabled  = !par_lHabilitar
1847:         THIS.cmd_4c_Desmarcar.Enabled  = !par_lHabilitar
1848:         THIS.cmd_4c_Documentos.Enabled = !par_lHabilitar
1849:         THIS.cmd_4c_ImpDSimpl.Enabled  = !par_lHabilitar
1850:     ENDPROC
1851: 
1852:     *==========================================================================
1853:     * Eventos CRUD adaptados ao contexto OPERACIONAL de processamento de NFe.
1854:     * Em forms de processamento fiscal, as semanticas CRUD tradicionais mapeiam
1855:     * para operacoes especificas do fluxo de trabalho de NFe.
1856:     *==========================================================================
1857: 
1858:     PROCEDURE BtnIncluirClick()
1859:         * Incluir notas fiscais na fila de processamento.
1860:         * No contexto NFe, "Incluir" equivale a Selecionar registros do banco
1861:         * (SigMvNfi) para o cursor csOperacoes segundo os filtros informados.
1862:         LOCAL loc_cEmps
1863:         loc_cEmps = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value)
1864:         IF EMPTY(loc_cEmps)
1865:             MsgAviso("Informe a Empresa antes de incluir notas na fila.")
1866:             THIS.cnt_4c_Operacoes.txt_4c_Emps.SetFocus()
1867:             RETURN
1868:         ENDIF
1869:         THIS.BtnSelecionarClick()
1870:     ENDPROC
1871: 
1872:     PROCEDURE BtnAlterarClick()
1873:         * Alterar dados fiscais da nota corrente. Abre Formsigmvexp
1874:         * (mesma janela usada pelo botao "Documentos" do grid) para
1875:         * edicao dos dados fiscais da NF apontada em csOperacoes.
1876:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
1877:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas na fila. Utilize Incluir primeiro.")
1878:             RETURN
1879:         ENDIF
1880:         SELECT csOperacoes
1881:         IF EOF("csOperacoes")
1882:             GO TOP IN csOperacoes
1883:         ENDIF
1884:         IF EMPTY(csOperacoes.Emps) OR EMPTY(csOperacoes.Dopes)
1885:             MsgAviso("Posicione o cursor sobre uma nota v" + CHR(225) + "lida.")
1886:             RETURN
1887:         ENDIF
1888:         THIS.BtnDocumentosClick()
1889:     ENDPROC
1890: 
1891:     PROCEDURE BtnVisualizarClick()
1892:         * Visualizar detalhes tecnicos (chave, protocolo, status)
1893:         * da nota fiscal apontada. Consulta SigMvNfi diretamente
1894:         * para exibir dados que nao aparecem no grid principal.
1895:         LOCAL loc_cChave, loc_cSQL, loc_oErro, loc_cMsg
1896:         LOCAL loc_cChv, loc_cProt, loc_cStat, loc_cXml
1897:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
1898:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas na fila para visualizar.")
1899:             RETURN
1900:         ENDIF
1901:         SELECT csOperacoes
1902:         IF EOF("csOperacoes")
1903:             GO TOP IN csOperacoes
1904:         ENDIF
1905:         loc_cChave = ALLTRIM(csOperacoes.Emps) + ALLTRIM(csOperacoes.Dopes) + ;
1906:                      PADL(ALLTRIM(TRANSFORM(csOperacoes.Numes)), 6, "0")
1907:         loc_cSQL = "SELECT TOP 1 nfechv, nfexml, prots, stats FROM SigMvNfi WHERE empdopnums = " + ;
1908:                    EscaparSQL(loc_cChave)
1909:         TRY
1910:             IF USED("cursor_4c_VisNfe")
1911:                 USE IN cursor_4c_VisNfe
1912:             ENDIF
1913:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VisNfe") < 1
1914:                 MsgErro("Falha ao consultar SigMvNfi para a nota selecionada.", "Visualizar")
1915:                 RETURN
1916:             ENDIF
1917:             IF RECCOUNT("cursor_4c_VisNfe") = 0
1918:                 MsgAviso("Nota fiscal ainda n" + CHR(227) + "o transmitida (sem registro em SigMvNfi).")
1919:             ELSE
1920:                 loc_cChv  = ALLTRIM(NVL(cursor_4c_VisNfe.nfechv, "N/D"))
1921:                 loc_cProt = ALLTRIM(NVL(cursor_4c_VisNfe.prots, "N/D"))
1922:                 loc_cStat = ALLTRIM(NVL(cursor_4c_VisNfe.stats, "N/D"))
1923:                 loc_cXml  = IIF(EMPTY(NVL(cursor_4c_VisNfe.nfexml, "")), "N" + CHR(227) + "o", "Sim")
1924:                 loc_cMsg = "Nota: " + ALLTRIM(csOperacoes.Notas) + CHR(13) + ;
1925:                            "S" + CHR(233) + "rie: " + ALLTRIM(csOperacoes.Series) + CHR(13) + ;
1926:                            "Chave: " + loc_cChv + CHR(13) + ;
1927:                            "Protocolo: " + loc_cProt + CHR(13) + ;
1928:                            "Status: " + loc_cStat + CHR(13) + ;
1929:                            "XML dispon" + CHR(237) + "vel: " + loc_cXml
1930:                 MsgInfo(loc_cMsg)
1931:             ENDIF
1932:             IF USED("cursor_4c_VisNfe")
1933:                 USE IN cursor_4c_VisNfe
1934:             ENDIF
1935:         CATCH TO loc_oErro
1936:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1937:                     "Erro Visualizar")
1938:         ENDTRY
1939:     ENDPROC
1940: 
1941:     PROCEDURE BtnExcluirClick()
1942:         * Excluir (limpar) a fila de processamento.
1943:         * NAO remove NFe do banco - apenas limpa csOperacoes e reabilita
1944:         * os filtros para nova selecao. Confirmacao obrigatoria.
1945:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
1946:             MsgAviso("A fila de processamento j" + CHR(225) + " est" + CHR(225) + " vazia.")
1947:             RETURN
1948:         ENDIF
1949:         IF MsgConfirma("Confirma a limpeza da fila de processamento de NFe?" + CHR(13) + ;
1950:                        "Os registros n" + CHR(227) + "o ser" + CHR(227) + "o removidos do banco de dados.")
1951:             THIS.LimpaSelecao()
1952:         ENDIF
1953:     ENDPROC
1954: 
1955:     *==========================================================================
1956:     * FASE 8 - FormParaBO / BOParaForm / HabilitarCampos / LimparCampos
1957:     * CarregarLista / AjustarBotoesPorModo / BtnSalvar / BtnCancelar / BtnBuscar
1958:     *==========================================================================
1959: 
1960:     *--------------------------------------------------------------------------
1961:     * FormParaBO - Copia TODOS os valores da UI para o Business Object.
1962:     * Cobre os 3 blocos de propriedades: parametros de sele" + CHR(231) + CHR(227) + "o
1963:     * (empresa/serie/datas/acao), flags/checkboxes e o registro corrente
1964:     * de csOperacoes (linha selecionada no grid).
1965:     *--------------------------------------------------------------------------
1966:     PROCEDURE FormParaBO()
1967:         LOCAL loc_oBO, loc_oCnt
1968:         loc_oBO = THIS.this_oBusinessObject
1969:         IF VARTYPE(loc_oBO) != "O"
1970:             RETURN .F.
1971:         ENDIF
1972:         loc_oCnt = THIS.cnt_4c_Operacoes
1973: 
1974:         *-- Bloco 1: parametros de selecao/processamento
1975:         loc_oBO.this_cEmps        = PADR(ALLTRIM(loc_oCnt.txt_4c_Emps.Value), 3)
1976:         loc_oBO.this_cSeries      = PADR(ALLTRIM(loc_oCnt.txt_4c_Series.Value), 3)
1977:         loc_oBO.this_dDtIni       = loc_oCnt.txt_4c_DtIni.Value
1978:         loc_oBO.this_dDtFin       = loc_oCnt.txt_4c_DtFin.Value
1979:         loc_oBO.this_nProcessados = loc_oCnt.opt_4c_Processados.Value
1980:         loc_oBO.this_nTipos       = loc_oCnt.opt_4c_Tipos.Value
1981:         loc_oBO.this_nAmbiente    = loc_oCnt.opt_4c_Ambiente.Value
1982:         loc_oBO.this_nAcao        = loc_oCnt.opt_4c_Acao.Value
1983:         loc_oBO.this_nImpressao   = loc_oCnt.opt_4c_Impressao.Value
1984:         loc_oBO.this_nContin      = loc_oCnt.opt_4c_Contin.Value
1985:         loc_oBO.this_cInuIni      = ALLTRIM(loc_oCnt.txt_4c_InuIni.Value)
1986:         loc_oBO.this_cInuFim      = ALLTRIM(loc_oCnt.txt_4c_InuFim.Value)
1987:         loc_oBO.this_cRegime      = ALLTRIM(loc_oCnt.cmb_4c_Regime.Value)
1988:         loc_oBO.this_cArquivos    = ALLTRIM(loc_oCnt.txt_4c_Arquivos.Value)
1989:         IF EMPTY(loc_oCnt.txt_4c_IniContin.Value)
1990:             loc_oBO.this_dIniContin = {}
1991:         ELSE
1992:             IF VARTYPE(loc_oCnt.txt_4c_IniContin.Value) = "D"
1993:                 loc_oBO.this_dIniContin = loc_oCnt.txt_4c_IniContin.Value
1994:             ELSE
1995:                 loc_oBO.this_dIniContin = CTOD(TRANSFORM(loc_oCnt.txt_4c_IniContin.Value))
1996:             ENDIF
1997:         ENDIF
1998: 
1999:         *-- Bloco 2: flags/checkboxes (Value NUMERICO 0/1 -> LOGICAL no BO)
2000:         loc_oBO.this_lHVerao  = (loc_oCnt.chk_4c_HVerao.Value = 1)
2001:         loc_oBO.this_lVenc    = (loc_oCnt.chk_4c_Venc.Value = 1)
2002:         loc_oBO.this_lOptSub  = (loc_oCnt.chk_4c_OptSub.Value = 1)
2003:         loc_oBO.this_lOptArq  = (loc_oCnt.chk_4c_OptArq.Value = 1)
2004: 
2005:         *-- Bloco 3: registro corrente do grid csOperacoes
2006:         IF USED("csOperacoes") AND !EOF("csOperacoes") AND !BOF("csOperacoes")

*-- Linhas 2030 a 2073:
2030:     * Espelho de FormParaBO, cobrindo os 3 blocos (parametros, flags e
2031:     * registro corrente do grid).
2032:     *--------------------------------------------------------------------------
2033:     PROCEDURE BOParaForm()
2034:         LOCAL loc_oBO, loc_oCnt
2035:         loc_oBO = THIS.this_oBusinessObject
2036:         IF VARTYPE(loc_oBO) != "O"
2037:             RETURN .F.
2038:         ENDIF
2039:         loc_oCnt = THIS.cnt_4c_Operacoes
2040: 
2041:         *-- Bloco 1: parametros de selecao/processamento
2042:         loc_oCnt.txt_4c_Emps.Value       = loc_oBO.this_cEmps
2043:         loc_oCnt.txt_4c_Series.Value     = loc_oBO.this_cSeries
2044:         loc_oCnt.txt_4c_DtIni.Value      = loc_oBO.this_dDtIni
2045:         loc_oCnt.txt_4c_DtFin.Value      = loc_oBO.this_dDtFin
2046:         IF loc_oBO.this_nProcessados > 0
2047:             loc_oCnt.opt_4c_Processados.Value = loc_oBO.this_nProcessados
2048:         ENDIF
2049:         IF loc_oBO.this_nTipos > 0
2050:             loc_oCnt.opt_4c_Tipos.Value = loc_oBO.this_nTipos
2051:         ENDIF
2052:         IF loc_oBO.this_nAmbiente > 0
2053:             loc_oCnt.opt_4c_Ambiente.Value = loc_oBO.this_nAmbiente
2054:         ENDIF
2055:         IF loc_oBO.this_nAcao > 0
2056:             loc_oCnt.opt_4c_Acao.Value = loc_oBO.this_nAcao
2057:         ENDIF
2058:         IF loc_oBO.this_nImpressao > 0
2059:             loc_oCnt.opt_4c_Impressao.Value = loc_oBO.this_nImpressao
2060:         ENDIF
2061:         IF loc_oBO.this_nContin > 0
2062:             loc_oCnt.opt_4c_Contin.Value = loc_oBO.this_nContin
2063:         ENDIF
2064:         loc_oCnt.txt_4c_InuIni.Value   = loc_oBO.this_cInuIni
2065:         loc_oCnt.txt_4c_InuFim.Value   = loc_oBO.this_cInuFim
2066:         loc_oCnt.cmb_4c_Regime.Value   = loc_oBO.this_cRegime
2067:         loc_oCnt.txt_4c_Arquivos.Value = loc_oBO.this_cArquivos
2068:         loc_oCnt.txt_4c_IniContin.Value = loc_oBO.this_dIniContin
2069: 
2070:         *-- Bloco 2: flags/checkboxes (LOGICAL BO -> NUMERICO 0/1 CheckBox)
2071:         loc_oCnt.chk_4c_HVerao.Value = IIF(loc_oBO.this_lHVerao, 1, 0)
2072:         loc_oCnt.chk_4c_Venc.Value   = IIF(loc_oBO.this_lVenc, 1, 0)
2073:         loc_oCnt.chk_4c_OptSub.Value = IIF(loc_oBO.this_lOptSub, 1, 0)

*-- Linhas 2084 a 2211:
2084:     * (nome nativo deste form OPERACIONAL) que implementa a logica real de
2085:     * bloquear filtros durante processamento.
2086:     *--------------------------------------------------------------------------
2087:     PROCEDURE HabilitarCampos(par_lHabilitar)
2088:         LOCAL loc_lHab
2089:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2090:         THIS.HabilitarControles(loc_lHab)
2091:     ENDPROC
2092: 
2093:     *--------------------------------------------------------------------------
2094:     * LimparCampos - Interface CRUD-padrao. Reseta filtros para valores default
2095:     * e limpa a fila de csOperacoes chamando LimpaSelecao.
2096:     *--------------------------------------------------------------------------
2097:     PROCEDURE LimparCampos()
2098:         LOCAL loc_oCnt
2099:         loc_oCnt = THIS.cnt_4c_Operacoes
2100:         loc_oCnt.txt_4c_Emps.Value        = ""
2101:         loc_oCnt.txt_4c_Series.Value      = ""
2102:         loc_oCnt.txt_4c_DtIni.Value       = {}
2103:         loc_oCnt.txt_4c_DtFin.Value       = {}
2104:         loc_oCnt.txt_4c_InuIni.Value      = ""
2105:         loc_oCnt.txt_4c_InuFim.Value      = ""
2106:         loc_oCnt.txt_4c_Arquivos.Value    = ""
2107:         loc_oCnt.opt_4c_Processados.Value = 1
2108:         loc_oCnt.opt_4c_Tipos.Value       = 1
2109:         loc_oCnt.opt_4c_Ambiente.Value    = 1
2110:         loc_oCnt.opt_4c_Acao.Value        = 1
2111:         loc_oCnt.opt_4c_Impressao.Value   = 1
2112:         loc_oCnt.opt_4c_Contin.Value      = 1
2113:         loc_oCnt.chk_4c_HVerao.Value      = 0
2114:         loc_oCnt.chk_4c_Venc.Value        = 0
2115:         loc_oCnt.chk_4c_OptSub.Value      = 0
2116:         loc_oCnt.chk_4c_OptArq.Value      = 0
2117:         THIS.LimpaSelecao()
2118:     ENDPROC
2119: 
2120:     *--------------------------------------------------------------------------
2121:     * CarregarLista - Interface CRUD-padrao. Executa a selecao inicial das
2122:     * notas fiscais no banco (SigMvNfi) para o cursor csOperacoes que popula
2123:     * o grid principal. Delega para BtnSelecionarClick que reproduz o Selecionar
2124:     * do form legado.
2125:     *--------------------------------------------------------------------------
2126:     PROCEDURE CarregarLista()
2127:         LOCAL loc_cEmps, loc_dDtIni, loc_dDtFin
2128:         loc_cEmps  = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value)
2129:         loc_dDtIni = THIS.cnt_4c_Operacoes.txt_4c_DtIni.Value
2130:         loc_dDtFin = THIS.cnt_4c_Operacoes.txt_4c_DtFin.Value
2131:         IF EMPTY(loc_cEmps) OR EMPTY(loc_dDtIni) OR EMPTY(loc_dDtFin)
2132:             RETURN .F.
2133:         ENDIF
2134:         THIS.BtnSelecionarClick(.T.)
2135:         RETURN USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
2136:     ENDPROC
2137: 
2138:     *--------------------------------------------------------------------------
2139:     * AjustarBotoesPorModo - Interface CRUD-padrao. Neste form OPERACIONAL
2140:     * ha 2 modos logicos:
2141:     *   MODO=1 (LIVRE):     filtros habilitados, botoes de acao em grid off.
2142:     *   MODO=2 (SELECAO):   filtros bloqueados, botoes de acao em grid on.
2143:     * A rotina espelha o comportamento de HabilitarControles com semantica
2144:     * de "modo" para compatibilidade com o pipeline CRUD.
2145:     *--------------------------------------------------------------------------
2146:     PROCEDURE AjustarBotoesPorModo(par_nModo)
2147:         LOCAL loc_nModo
2148:         loc_nModo = IIF(VARTYPE(par_nModo) = "N", par_nModo, 1)
2149:         IF loc_nModo = 1
2150:             THIS.HabilitarControles(.T.)
2151:         ELSE
2152:             THIS.HabilitarControles(.F.)
2153:         ENDIF
2154:     ENDPROC
2155: 
2156:     *--------------------------------------------------------------------------
2157:     * BtnSalvarClick - Interface CRUD-padrao. Em contexto NFe "Salvar" equivale
2158:     * a processar (transmitir SEFAZ / gerar TXT / imprimir DANFE) as notas
2159:     * marcadas no grid. Delega para BtnCopiarClick que aciona o
2160:     * BO.Processar/Processamento conforme opt_4c_Acao.
2161:     *--------------------------------------------------------------------------
2162:     PROCEDURE BtnSalvarClick()
2163:         LOCAL loc_nSel
2164:         IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
2165:             MsgAviso("A fila de processamento est" + CHR(225) + " vazia. Use Buscar/Selecionar antes.")
2166:             RETURN
2167:         ENDIF
2168:         SELECT COUNT(*) AS nSel FROM csOperacoes WHERE SelImp INTO CURSOR cursor_4c_SelSalv
2169:         loc_nSel = cursor_4c_SelSalv.nSel
2170:         USE IN cursor_4c_SelSalv
2171:         IF loc_nSel < 1
2172:             MsgAviso("Nenhuma nota est" + CHR(225) + " marcada para processamento.")
2173:             RETURN
2174:         ENDIF
2175:         THIS.FormParaBO()
2176:         THIS.BtnCopiarClick()
2177:     ENDPROC
2178: 
2179:     *--------------------------------------------------------------------------
2180:     * BtnCancelarClick - Interface CRUD-padrao. Cancela a selecao atual e
2181:     * reabilita os filtros de busca (equivale ao Limpar do form legado).
2182:     *--------------------------------------------------------------------------
2183:     PROCEDURE BtnCancelarClick()
2184:         IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
2185:             IF !MsgConfirma("Confirma o cancelamento da sele" + CHR(231) + CHR(227) + ;
2186:                             "o? A fila ser" + CHR(225) + " limpa.")
2187:                 RETURN
2188:             ENDIF
2189:         ENDIF
2190:         THIS.BtnLimparClick()
2191:     ENDPROC
2192: 
2193:     *--------------------------------------------------------------------------
2194:     * BtnBuscarClick - Interface CRUD-padrao. Aciona a selecao no banco
2195:     * segundo os filtros informados. Delega para BtnSelecionarClick que
2196:     * reproduz o Selecionar do form legado (grupo de botoes cmdSelecionar).
2197:     *--------------------------------------------------------------------------
2198:     PROCEDURE BtnBuscarClick()
2199:         THIS.BtnSelecionarClick()
2200:     ENDPROC
2201: 
2202:     *==========================================================================
2203:     PROCEDURE Destroy()
2204:     *==========================================================================
2205:         IF USED("csOperacoes")
2206:             USE IN csOperacoes
2207:         ENDIF
2208:         DODEFAULT()
2209:     ENDPROC
2210: 
2211: ENDDEFINE

