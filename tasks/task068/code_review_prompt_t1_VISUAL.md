# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 191: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 211: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 231: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecrt.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1736 linhas total):

*-- Linhas 50 a 58:
50:                         "InicializarForm")
51:             ELSE
52:                 THIS.ConfigurarCabecalho()
53:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
54: 
55:                 THIS.ConfigurarBotoes()
56:                 THIS.ConfigurarPaginaDados()
57:                 THIS.ConfigurarCamposFiltro()
58: 

*-- Linhas 77 a 85:
77:     * adicionados diretamente ao Form.
78:     *==========================================================================
79:     PROTECTED PROCEDURE ConfigurarPageFrame()
80:         THIS.Caption     = "Relat" + CHR(243) + "rio de Cheques Da Carteira"
81:         THIS.Picture     = gc_4c_CaminhoIcones + "new_background.jpg"
82:         THIS.Icon        = gc_4c_CaminhoIcones + "icon.ico"
83:         THIS.AutoCenter  = .T.
84:         THIS.BorderStyle = 2
85:         THIS.WindowType  = 1

*-- Linhas 98 a 141:
98:     PROTECTED PROCEDURE ConfigurarCabecalho()
99:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
100:         WITH THIS.cnt_4c_Cabecalho
101:             .Top         = 0
102:             .Left        = 0
103:             .Width       = THIS.Width
104:             .Height      = 80
105:             .BackStyle   = 1
106:             .BackColor   = RGB(100, 100, 100)
107:             .BorderWidth = 0
108:             .Visible     = .T.
109: 
110:             .AddObject("lbl_4c_Sombra", "Label")
111:             WITH .lbl_4c_Sombra
112:                 .Top       = 15
113:                 .Left      = 12
114:                 .Width     = THIS.Width
115:                 .Height    = 40
116:                 .FontName  = "Tahoma"
117:                 .FontSize  = 16
118:                 .FontBold  = .T.
119:                 .BackStyle = 0
120:                 .ForeColor = RGB(0, 0, 0)
121:                 .Caption   = THIS.Caption
122:                 .Visible   = .T.
123:             ENDWITH
124: 
125:             .AddObject("lbl_4c_Titulo", "Label")
126:             WITH .lbl_4c_Titulo
127:                 .Top       = 18
128:                 .Left      = 10
129:                 .Width     = THIS.Width
130:                 .Height    = 40
131:                 .FontName  = "Tahoma"
132:                 .FontSize  = 16
133:                 .FontBold  = .T.
134:                 .BackStyle = 0
135:                 .ForeColor = RGB(255, 255, 255)
136:                 .Caption   = THIS.Caption
137:                 .Visible   = .T.
138:             ENDWITH
139:         ENDWITH
140:     ENDPROC
141: 

*-- Linhas 151 a 176:
151: 
152:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
153:         WITH THIS.cmg_4c_Botoes
154:             .Top           = 6
155:             .Left          = 726
156:             .Width         = 273
157:             .Height        = 80
158:             .ButtonCount   = 4
159:             .BackStyle     = 0
160:             .BorderStyle   = 0
161:             .BorderColor   = RGB(136, 189, 188)
162:             .SpecialEffect = 1
163:             .Themes        = .F.
164:             .Visible       = .T.
165: 
166:             WITH .Buttons(1)
167:                 .Top             = 5
168:                 .Left            = 5
169:                 .Width           = 65
170:                 .Height          = 70
171:                 .Caption         = "Visualizar"
172:                 .Picture         = loc_cIcones + "ideo.jpg"
173:                 .FontBold        = .T.
174:                 .FontItalic      = .T.
175:                 .BackColor       = RGB(255, 255, 255)
176:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 182 a 237:
182:             ENDWITH
183: 
184:             WITH .Buttons(2)
185:                 .Top             = 5
186:                 .Left            = 71
187:                 .Width           = 65
188:                 .Height          = 70
189:                 .Caption         = "Imprimir"
190:                 .Picture         = loc_cIcones + "impressora.jpg"
191:                 .FontName        = "Comic Sans MS"
192:                 .FontBold        = .T.
193:                 .FontItalic      = .T.
194:                 .FontSize        = 8
195:                 .BackColor       = RGB(255, 255, 255)
196:                 .ForeColor       = RGB(90, 90, 90)
197:                 .PicturePosition = 13
198:                 .SpecialEffect   = 0
199:                 .MousePointer    = 15
200:                 .Themes          = .F.
201:                 .WordWrap        = .T.
202:             ENDWITH
203: 
204:             WITH .Buttons(3)
205:                 .Top             = 5
206:                 .Left            = 137
207:                 .Width           = 65
208:                 .Height          = 70
209:                 .Caption         = "Excel"
210:                 .Picture         = loc_cIcones + "excel.jpg"
211:                 .FontName        = "Comic Sans MS"
212:                 .FontBold        = .T.
213:                 .FontItalic      = .T.
214:                 .FontSize        = 8
215:                 .BackColor       = RGB(255, 255, 255)
216:                 .ForeColor       = RGB(90, 90, 90)
217:                 .PicturePosition = 13
218:                 .SpecialEffect   = 0
219:                 .MousePointer    = 15
220:                 .Themes          = .F.
221:                 .WordWrap        = .T.
222:             ENDWITH
223: 
224:             WITH .Buttons(4)
225:                 .Top             = 5
226:                 .Left            = 203
227:                 .Width           = 65
228:                 .Height          = 70
229:                 .Caption         = "Sair"
230:                 .Picture         = loc_cIcones + "otao_encerrar.jpg"
231:                 .FontName        = "Comic Sans MS"
232:                 .FontBold        = .T.
233:                 .FontItalic      = .T.
234:                 .FontSize        = 8
235:                 .BackColor       = RGB(255, 255, 255)
236:                 .ForeColor       = RGB(90, 90, 90)
237:                 .PicturePosition = 13

*-- Linhas 626 a 636:
626:         IF PEMSTATUS(THIS, "obj_4c_Opt_nr_opcao", 5)
627:             IF VARTYPE(THIS.obj_4c_Opt_nr_opcao) = "O"
628:                 WITH THIS.obj_4c_Opt_nr_opcao
629:                     .Buttons(1).Caption = THIS.this_oRelatorio.this_cTituloOpcao1
630:                     .Buttons(2).Caption = THIS.this_oRelatorio.this_cTituloOpcao2
631:                     .Buttons(3).Caption = THIS.this_oRelatorio.this_cTituloOpcao3
632:                 ENDWITH
633:             ENDIF
634:         ENDIF
635:     ENDPROC
636: 

*-- Linhas 655 a 923:
655: 
656:         THIS.AddObject("obj_4c_GetTipoDat", "OptionGroup")
657:         WITH THIS.obj_4c_GetTipoDat
658:             .Top         = 104
659:             .Left        = 237
660:             .Width       = 157
661:             .Height      = 25
662:             .ButtonCount = 2
663:             .BackStyle   = 0
664:             .BorderStyle = 0
665:             .ToolTipText = "Emiss" + CHR(227) + "o = a data de inclus" + CHR(227) + ;
666:                            "o da movimenta" + CHR(231) + CHR(227) + "o"
667:             .Visible     = .T.
668:             WITH .Buttons(1)
669:                 .Caption   = "Vencimento"
670:                 .Left      = 0
671:                 .Top       = 0
672:                 .Width     = 78
673:                 .Height    = 22
674:                 .AutoSize  = .F.
675:                 .ForeColor = RGB(90, 90, 90)
676:                 .BackStyle = 0
677:             ENDWITH
678:             WITH .Buttons(2)
679:                 .Caption   = "Emiss" + CHR(227) + "o"
680:                 .Left      = 80
681:                 .Top       = 0
682:                 .Width     = 72
683:                 .Height    = 22
684:                 .AutoSize  = .F.
685:                 .FontName  = loc_cFonte
686:                 .FontSize  = 9
687:                 .ForeColor = RGB(90, 90, 90)
688:                 .BackStyle = 0
689:             ENDWITH
690:         ENDWITH
691: 
692:         THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
693:         WITH THIS.lbl_4c_Lbl_empresa
694:             .Top       = 221
695:             .Left      = 183
696:             .Width     = 50
697:             .Height    = 17
698:             .FontName  = loc_cFonte
699:             .FontSize  = 9
700:             .BackStyle = 0
701:             .Caption   = "Empresa :"
702:             .ForeColor = RGB(90, 90, 90)
703:             .Visible   = .T.
704:         ENDWITH
705: 
706:         THIS.AddObject("lbl_4c_Label7", "Label")
707:         WITH THIS.lbl_4c_Label7
708:             .Top       = 135
709:             .Left      = 435
710:             .Width     = 123
711:             .Height    = 17
712:             .FontName  = loc_cFonte
713:             .FontSize  = 9
714:             .BackStyle = 0
715:             .Caption   = "Juros :                  ao m" + CHR(234) + "s"
716:             .ForeColor = RGB(90, 90, 90)
717:             .Visible   = .T.
718:         ENDWITH
719: 
720:         THIS.AddObject("txt_4c__ds_empresa", "TextBox")
721:         WITH THIS.txt_4c__ds_empresa
722:             .Top       = 217
723:             .Left      = 270
724:             .Width     = 337
725:             .Height    = 20
726:             .MaxLength = 40
727:             .ReadOnly  = .T.
728:             .FontName  = loc_cFonte
729:             .FontSize  = 9
730:             .BackColor = RGB(245, 245, 245)
731:             .Visible   = .T.
732:         ENDWITH
733: 
734:         THIS.AddObject("txt_4c_Juros", "TextBox")
735:         WITH THIS.txt_4c_Juros
736:             .Top       = 131
737:             .Left      = 471
738:             .Width     = 45
739:             .Height    = 20
740:             .FontName  = loc_cFonte
741:             .FontSize  = 9
742:             .InputMask = "999.99"
743:             .BackColor = RGB(255, 255, 255)
744:             .Visible   = .T.
745:         ENDWITH
746: 
747:         THIS.AddObject("txt_4c__cd_empresa", "TextBox")
748:         WITH THIS.txt_4c__cd_empresa
749:             .Top       = 217
750:             .Left      = 237
751:             .Width     = 31
752:             .Height    = 20
753:             .MaxLength = 3
754:             .FontName  = loc_cFonte
755:             .FontSize  = 9
756:             .BackColor = RGB(255, 255, 255)
757:             .Visible   = .T.
758:         ENDWITH
759: 
760:         THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
761:         WITH THIS.lbl_4c_Lbl_periodo
762:             .Top       = 136
763:             .Left      = 188
764:             .Width     = 45
765:             .Height    = 17
766:             .FontName  = loc_cFonte
767:             .FontSize  = 9
768:             .BackStyle = 0
769:             .Caption   = "Per" + CHR(237) + "odo :"
770:             .ForeColor = RGB(90, 90, 90)
771:             .Visible   = .T.
772:         ENDWITH
773: 
774:         THIS.AddObject("txt_4c__dt_inicial", "TextBox")
775:         WITH THIS.txt_4c__dt_inicial
776:             .Top       = 132
777:             .Left      = 237
778:             .Width     = 80
779:             .Height    = 20
780:             .FontName  = loc_cFonte
781:             .FontSize  = 9
782:             .Format    = "D"
783:             .BackColor = RGB(255, 255, 255)
784:             .Visible   = .T.
785:         ENDWITH
786: 
787:         THIS.AddObject("lbl_4c_Lbl_periodo_a", "Label")
788:         WITH THIS.lbl_4c_Lbl_periodo_a
789:             .Top       = 136
790:             .Left      = 323
791:             .Width     = 8
792:             .Height    = 17
793:             .FontName  = loc_cFonte
794:             .FontSize  = 9
795:             .BackStyle = 0
796:             .Caption   = CHR(225)
797:             .ForeColor = RGB(90, 90, 90)
798:             .Visible   = .T.
799:         ENDWITH
800: 
801:         THIS.AddObject("txt_4c__dt_final", "TextBox")
802:         WITH THIS.txt_4c__dt_final
803:             .Top       = 132
804:             .Left      = 336
805:             .Width     = 80
806:             .Height    = 20
807:             .FontName  = loc_cFonte
808:             .FontSize  = 9
809:             .Format    = "D"
810:             .BackColor = RGB(255, 255, 255)
811:             .Visible   = .T.
812:         ENDWITH
813: 
814:         THIS.AddObject("lbl_4c_Label1", "Label")
815:         WITH THIS.lbl_4c_Label1
816:             .Top       = 193
817:             .Left      = 192
818:             .Width     = 41
819:             .Height    = 17
820:             .FontName  = loc_cFonte
821:             .FontSize  = 9
822:             .BackStyle = 0
823:             .Caption   = "Ordem :"
824:             .ForeColor = RGB(90, 90, 90)
825:             .Visible   = .T.
826:         ENDWITH
827: 
828:         THIS.AddObject("lbl_4c_Lbl_operacao", "Label")
829:         WITH THIS.lbl_4c_Lbl_operacao
830:             .Top       = 165
831:             .Left      = 177
832:             .Width     = 56
833:             .Height    = 17
834:             .FontName  = loc_cFonte
835:             .FontSize  = 9
836:             .BackStyle = 0
837:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
838:             .ForeColor = RGB(90, 90, 90)
839:             .Visible   = .T.
840:         ENDWITH
841: 
842:         THIS.AddObject("lbl_4c_Lbl_opcao", "Label")
843:         WITH THIS.lbl_4c_Lbl_opcao
844:             .Top       = 193
845:             .Left      = 382
846:             .Width     = 50
847:             .Height    = 17
848:             .FontName  = loc_cFonte
849:             .FontSize  = 9
850:             .BackStyle = 0
851:             .Caption   = "Op" + CHR(231) + CHR(227) + "o : "
852:             .ForeColor = RGB(90, 90, 90)
853:             .Visible   = .T.
854:         ENDWITH
855: 
856:         THIS.AddObject("obj_4c_Opt_nr_opcao", "OptionGroup")
857:         WITH THIS.obj_4c_Opt_nr_opcao
858:             .Top         = 189
859:             .Left        = 428
860:             .Width       = 192
861:             .Height      = 23
862:             .ButtonCount = 3
863:             .BackStyle   = 0
864:             .BorderStyle = 0
865:             .Visible     = .T.
866:             WITH .Buttons(1)
867:                 .Caption   = "Sim"
868:                 .Left      = 0
869:                 .Top       = 0
870:                 .Width     = 63
871:                 .Height    = 21
872:                 .AutoSize  = .F.
873:                 .ForeColor = RGB(90, 90, 90)
874:                 .BackStyle = 0
875:             ENDWITH
876:             WITH .Buttons(2)
877:                 .Caption   = "N" + CHR(227) + "o"
878:                 .Left      = 65
879:                 .Top       = 0
880:                 .Width     = 63
881:                 .Height    = 21
882:                 .AutoSize  = .F.
883:                 .FontName  = loc_cFonte
884:                 .FontSize  = 9
885:                 .ForeColor = RGB(90, 90, 90)
886:                 .BackStyle = 0
887:             ENDWITH
888:             WITH .Buttons(3)
889:                 .Caption   = "Ambos"
890:                 .Left      = 130
891:                 .Top       = 0
892:                 .Width     = 60
893:                 .Height    = 21
894:                 .AutoSize  = .F.
895:                 .FontName  = loc_cFonte
896:                 .FontSize  = 9
897:                 .ForeColor = RGB(90, 90, 90)
898:                 .BackStyle = 0
899:             ENDWITH
900:         ENDWITH
901: 
902:         THIS.AddObject("txt_4c__cd_emi_grupo", "TextBox")
903:         WITH THIS.txt_4c__cd_emi_grupo
904:             .Top       = 261
905:             .Left      = 237
906:             .Width     = 79
907:             .Height    = 20
908:             .MaxLength = 10
909:             .FontName  = loc_cFonte
910:             .FontSize  = 9
911:             .BackColor = RGB(255, 255, 255)
912:             .Visible   = .T.
913:         ENDWITH
914: 
915:         THIS.AddObject("txt_4c__ds_emi_grupo", "TextBox")
916:         WITH THIS.txt_4c__ds_emi_grupo
917:             .Top         = 261
918:             .Left        = 319
919:             .Width       = 150
920:             .Height      = 20
921:             .MaxLength   = 20
922:             .ReadOnly    = .T.
923:             .FontName    = loc_cFonte

*-- Linhas 929 a 938:
929: 
930:         THIS.AddObject("txt_4c__cd_emi_conta", "TextBox")
931:         WITH THIS.txt_4c__cd_emi_conta
932:             .Top       = 289
933:             .Left      = 237
934:             .Width     = 79
935:             .Height    = 20
936:             .MaxLength = 10
937:             .FontName  = loc_cFonte
938:             .FontSize  = 9

*-- Linhas 961 a 970:
961: 
962:         THIS.AddObject("txt_4c__ds_emi_conta", "TextBox")
963:         WITH THIS.txt_4c__ds_emi_conta
964:             .Top         = 289
965:             .Left        = 319
966:             .Width       = 290
967:             .Height      = 20
968:             .MaxLength   = 50
969:             .ReadOnly    = .T.
970:             .FontName    = loc_cFonte

*-- Linhas 976 a 985:
976: 
977:         THIS.AddObject("cbo_4c_Get_ordem", "ComboBox")
978:         WITH THIS.cbo_4c_Get_ordem
979:             .Top           = 188
980:             .Left          = 237
981:             .Width         = 134
982:             .Height        = 20
983:             .Style         = 2
984:             .RowSourceType = 1
985:             .RowSource     = "VALOR,DATA VENCIMENTO,DATA OPERA" + CHR(199) + CHR(195) + "O"

*-- Linhas 991 a 1034:
991: 
992:         THIS.AddObject("obj_4c_Opt_Bons", "OptionGroup")
993:         WITH THIS.obj_4c_Opt_Bons
994:             .Top         = 160
995:             .Left        = 378
996:             .Width       = 163
997:             .Height      = 22
998:             .ButtonCount = 2
999:             .BackStyle   = 0
1000:             .BorderStyle = 0
1001:             .Visible     = .F.
1002:             WITH .Buttons(1)
1003:                 .Caption   = "Ativos"
1004:                 .Left      = 0
1005:                 .Top       = 0
1006:                 .Width     = 78
1007:                 .Height    = 22
1008:                 .AutoSize  = .F.
1009:                 .ForeColor = RGB(90, 90, 90)
1010:                 .BackStyle = 0
1011:             ENDWITH
1012:             WITH .Buttons(2)
1013:                 .Caption   = "Todos"
1014:                 .Left      = 80
1015:                 .Top       = 0
1016:                 .Width     = 78
1017:                 .Height    = 22
1018:                 .AutoSize  = .F.
1019:                 .FontName  = loc_cFonte
1020:                 .FontSize  = 9
1021:                 .ForeColor = RGB(90, 90, 90)
1022:                 .BackStyle = 0
1023:             ENDWITH
1024:         ENDWITH
1025: 
1026:         THIS.AddObject("cbo_4c_GetTipoRel", "ComboBox")
1027:         WITH THIS.cbo_4c_GetTipoRel
1028:             .Top           = 160
1029:             .Left          = 237
1030:             .Width         = 134
1031:             .Height        = 20
1032:             .Style         = 2
1033:             .RowSourceType = 1
1034:             .RowSource     = "ATIVOS,BAIXADOS,NEG.PG,BONS,DEVOLVIDOS"

*-- Linhas 1042 a 1078:
1042: 
1043:         THIS.AddObject("txt_4c__cd_dep_grupo", "TextBox")
1044:         WITH THIS.txt_4c__cd_dep_grupo
1045:             .Top       = 372
1046:             .Left      = 237
1047:             .Width     = 79
1048:             .Height    = 20
1049:             .MaxLength = 10
1050:             .FontName  = loc_cFonte
1051:             .FontSize  = 9
1052:             .BackColor = RGB(255, 255, 255)
1053:             .Visible   = .T.
1054:         ENDWITH
1055: 
1056:         THIS.AddObject("lbl_4c_Label6", "Label")
1057:         WITH THIS.lbl_4c_Label6
1058:             .Top       = 404
1059:             .Left      = 170
1060:             .Width     = 63
1061:             .Height    = 17
1062:             .FontName  = loc_cFonte
1063:             .FontSize  = 9
1064:             .BackStyle = 0
1065:             .Caption   = "Conta Dest :"
1066:             .ForeColor = RGB(90, 90, 90)
1067:             .Visible   = .T.
1068:         ENDWITH
1069: 
1070:         THIS.AddObject("txt_4c__ds_dep_grupo", "TextBox")
1071:         WITH THIS.txt_4c__ds_dep_grupo
1072:             .Top         = 372
1073:             .Left        = 319
1074:             .Width       = 150
1075:             .Height      = 20
1076:             .MaxLength   = 20
1077:             .ReadOnly    = .T.
1078:             .FontName    = loc_cFonte

*-- Linhas 1084 a 1093:
1084: 
1085:         THIS.AddObject("txt_4c_DGrupoO", "TextBox")
1086:         WITH THIS.txt_4c_DGrupoO
1087:             .Top         = 317
1088:             .Left        = 319
1089:             .Width       = 150
1090:             .Height      = 20
1091:             .MaxLength   = 20
1092:             .ReadOnly    = .T.
1093:             .FontName    = loc_cFonte

*-- Linhas 1099 a 1134:
1099: 
1100:         THIS.AddObject("txt_4c_CContaO", "TextBox")
1101:         WITH THIS.txt_4c_CContaO
1102:             .Top       = 345
1103:             .Left      = 237
1104:             .Width     = 79
1105:             .Height    = 20
1106:             .MaxLength = 10
1107:             .FontName  = loc_cFonte
1108:             .FontSize  = 9
1109:             .BackColor = RGB(255, 255, 255)
1110:             .Visible   = .T.
1111:         ENDWITH
1112: 
1113:         THIS.AddObject("txt_4c__cd_dep_conta", "TextBox")
1114:         WITH THIS.txt_4c__cd_dep_conta
1115:             .Top       = 400
1116:             .Left      = 237
1117:             .Width     = 79
1118:             .Height    = 20
1119:             .MaxLength = 10
1120:             .FontName  = loc_cFonte
1121:             .FontSize  = 9
1122:             .BackColor = RGB(255, 255, 255)
1123:             .Visible   = .T.
1124:         ENDWITH
1125: 
1126:         THIS.AddObject("txt_4c__ds_dep_conta", "TextBox")
1127:         WITH THIS.txt_4c__ds_dep_conta
1128:             .Top         = 400
1129:             .Left        = 319
1130:             .Width       = 290
1131:             .Height      = 20
1132:             .MaxLength   = 50
1133:             .ReadOnly    = .T.
1134:             .FontName    = loc_cFonte

*-- Linhas 1140 a 1234:
1140: 
1141:         THIS.AddObject("txt_4c_DContaO", "TextBox")
1142:         WITH THIS.txt_4c_DContaO
1143:             .Top         = 345
1144:             .Left        = 319
1145:             .Width       = 290
1146:             .Height      = 20
1147:             .MaxLength   = 50
1148:             .ReadOnly    = .T.
1149:             .FontName    = loc_cFonte
1150:             .FontSize    = 9
1151:             .BackColor   = RGB(245, 245, 245)
1152:             .ToolTipText = "Passe o Cheque na Leitora"
1153:             .Visible     = .T.
1154:         ENDWITH
1155: 
1156:         THIS.AddObject("lbl_4c_Label3", "Label")
1157:         WITH THIS.lbl_4c_Label3
1158:             .Top       = 293
1159:             .Left      = 155
1160:             .Width     = 78
1161:             .Height    = 17
1162:             .FontName  = loc_cFonte
1163:             .FontSize  = 9
1164:             .BackStyle = 0
1165:             .Caption   = "Conta/Emissor :"
1166:             .ForeColor = RGB(90, 90, 90)
1167:             .Visible   = .T.
1168:         ENDWITH
1169: 
1170:         THIS.AddObject("lbl_4c_Label5", "Label")
1171:         WITH THIS.lbl_4c_Label5
1172:             .Top       = 376
1173:             .Left      = 170
1174:             .Width     = 63
1175:             .Height    = 17
1176:             .FontName  = loc_cFonte
1177:             .FontSize  = 9
1178:             .BackStyle = 0
1179:             .Caption   = "Grupo Dest :"
1180:             .ForeColor = RGB(90, 90, 90)
1181:             .Visible   = .T.
1182:         ENDWITH
1183: 
1184:         THIS.AddObject("lbl_4c_Label4", "Label")
1185:         WITH THIS.lbl_4c_Label4
1186:             .Top       = 321
1187:             .Left      = 172
1188:             .Width     = 61
1189:             .Height    = 17
1190:             .FontName  = loc_cFonte
1191:             .FontSize  = 9
1192:             .BackStyle = 0
1193:             .Caption   = "Grupo Orig :"
1194:             .ForeColor = RGB(90, 90, 90)
1195:             .Visible   = .T.
1196:         ENDWITH
1197: 
1198:         THIS.AddObject("lbl_4c_Label2", "Label")
1199:         WITH THIS.lbl_4c_Label2
1200:             .Top       = 265
1201:             .Left      = 155
1202:             .Width     = 78
1203:             .Height    = 17
1204:             .FontName  = loc_cFonte
1205:             .FontSize  = 9
1206:             .BackStyle = 0
1207:             .Caption   = "Grupo/Emissor :"
1208:             .ForeColor = RGB(90, 90, 90)
1209:             .Visible   = .T.
1210:         ENDWITH
1211: 
1212:         THIS.AddObject("lbl_4c_Lbl_dep_conta", "Label")
1213:         WITH THIS.lbl_4c_Lbl_dep_conta
1214:             .Top       = 349
1215:             .Left      = 172
1216:             .Width     = 61
1217:             .Height    = 17
1218:             .FontName  = loc_cFonte
1219:             .FontSize  = 9
1220:             .BackStyle = 0
1221:             .Caption   = "Conta Orig :"
1222:             .ForeColor = RGB(90, 90, 90)
1223:             .Visible   = .T.
1224:         ENDWITH
1225: 
1226:         THIS.AddObject("txt_4c_CGrupoO", "TextBox")
1227:         WITH THIS.txt_4c_CGrupoO
1228:             .Top       = 317
1229:             .Left      = 237
1230:             .Width     = 79
1231:             .Height    = 20
1232:             .MaxLength = 10
1233:             .FontName  = loc_cFonte
1234:             .FontSize  = 9


### BO (C:\4c\projeto\app\classes\sigrecrtBO.prg):
*==============================================================================
* SIGRECRTBO.PRG
* Business Object para Relatorio de Cheques Da Carteira (SIGRECRT)
* Herda de RelatorioBase
*
* Filtros:
*   - Tipo de data: 1=Vencimento, 2=Emissao
*   - Periodo (data inicial / data final)
*   - Empresa (codigo + descricao)
*   - Tipo de relatorio: 1=Ativos, 2=Baixados, 3=Neg.PG, 4=Bons, 5=Devolvidos
*   - Opcao nota: 1=Sim, 2=Nao, 3=Ambos
*   - Ordem: 1=VALOR, 2=DATA VENCIMENTO, 3=DATA OPERACAO
*   - Juros mensal (%)
*   - Opcao Bons: 1=Ativos, 2=Todos (visivel apenas em TipoRel=4)
*   - Emissor (grupo/conta)
*   - Origem (grupo/conta)
*   - Destino (grupo/conta)
* Tabelas: SigCcChm, SigChe, SigCdCli, SigCdOpt, SigCdPac, SigCdPam, SigCdEmp, SigCqLcm
*==============================================================================

DEFINE CLASS sigrecrtBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoFrx        = ""
    this_cTitulo            = ""

    *-- Nomes dos cursores principais
    this_cCursorDados       = "CsRelatorio"
    this_cCursorCabecalho   = "CsCabecalho"
    this_cCursorOperacoes   = "cursor_4c_SigCdOpt"

    *-- Filtro: tipo de data (1=Vencimento, 2=Emissao)
    this_nTipoDat           = 1

    *-- Filtro: periodo
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtro: empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa         = ""
    this_cDsEmpresa         = ""

    *-- Filtro: tipo relatorio (GetTipoRel.ListIndex)
    *-- 1=Ativos, 2=Baixados, 3=Neg.PG, 4=Bons, 5=Devolvidos
    this_nTipoRel           = 1

    *-- Filtro: opcao nota (opt_nr_opcao.Value): 1=Sim, 2=Nao, 3=Ambos
    this_nNrOpcao           = 3

    *-- Titulos dinamicos carregados de SigCdPac (captions do opt_nr_opcao)
    this_cTituloOpcao1      = "Sim"
    this_cTituloOpcao2      = "N" + CHR(227) + "o"
    this_cTituloOpcao3      = "Ambos"

    *-- Filtro: ordem de classificacao (get_ordem.ListIndex)
    *-- 1=VALOR, 2=DATA VENCIMENTO, 3=DATA OPERACAO
    this_nIndexOrdem        = 1

    *-- Filtro: taxa de juros mensal %
    this_nJuros             = 0

    *-- Filtro: opcao bons (Opt_Bons.Value): 1=Ativos, 2=Todos
    this_nOptBons           = 1

    *-- Tipo de juros de SigCdPam.JuroCarts: 1=Simples, 2=Compostos
    this_nJurosCarts        = 1

    *-- Filtro emissor/carteira
    this_cCdEmiGrupo        = ""
    this_cDsEmiGrupo        = ""
    this_cCdEmiConta        = ""
    this_cDsEmiConta        = ""

    *-- Filtro origem
    this_cCdOriGrupo        = ""
    this_cDsOriGrupo        = ""
    this_cCdOriConta        = ""
    this_cDsOriConta        = ""

    *-- Filtro destino/deposito
    this_cCdDesGrupo        = ""
    this_cDsDesGrupo        = ""
    this_cCdDesConta        = ""
    this_cDsDesConta        = ""

    *--------------------------------------------------------------------------
    * Init - Configura FRX, titulo, datas iniciais e carrega parametros auxiliares
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cArquivoFrx = gc_4c_CaminhoReports + "SigReCrt.frx"
            THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Cheques Da Carteira"
            THIS.this_dDtInicial  = DATE()
            THIS.this_dDtFinal    = DATE()
            IF DODEFAULT()
                loc_lSucesso = THIS.CarregarParametros()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega SigCdOpt (indexado), SigCdPac e SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Operacoes de cheque: necessario para filtros de tipo no PrepararDados
            loc_cSQL = "SELECT * FROM SigCdOpt"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpt")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar SigCdOpt"
            ELSE
                SELECT cursor_4c_SigCdOpt
                INDEX ON operacaos TAG operacaos
                GO TOP

                *-- Titulos das opcoes de nota (SigCdPac)
                loc_cSQL = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac")
                IF loc_nResult > 0
                    SELECT cursor_4c_SigCdPac
                    GO TOP
                    THIS.this_cTituloOpcao1 = IIF(!EMPTY(ALLTRIM(TitOpcS)), ALLTRIM(TitOpcS), "Sim")
                    THIS.this_cTituloOpcao2 = IIF(!EMPTY(ALLTRIM(TitOpcN)), ALLTRIM(TitOpcN), "N" + CHR(227) + "o")
                    THIS.this_cTituloOpcao3 = IIF(!EMPTY(ALLTRIM(TitOpcA)), ALLTRIM(TitOpcA), "Ambos")
                    USE IN cursor_4c_SigCdPac
                ENDIF

                *-- Parametros de juros (SigCdPam.JuroCarts: 1=Simples, 2=Compostos)
                loc_cSQL = "SELECT JuroCarts FROM SigCdPam"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam")
                IF loc_nResult > 0
                    SELECT cursor_4c_SigCdPam
                    GO TOP
                    THIS.this_nJurosCarts = IIF(!EOF(), NVL(JuroCarts, 1), 1)
                    USE IN cursor_4c_SigCdPam
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.CarregarParametros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros, executa e popula CsRelatorio/CsCabecalho
    * Replica o processamento() do form legado SIGRECRT
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro, loc_lOK
        LOCAL loc_nTipoDat, loc_dDtInicial, loc_dDtFinal
        LOCAL loc_cCdEmpresa, loc_cDsEmpresa, loc_nNrOpcao
        LOCAL loc_cCdEmiGrupo, loc_cDsEmiGrupo, loc_cCdEmiConta, loc_cDsEmiConta
        LOCAL loc_cCdOriGrupo, loc_cDsOriGrupo, loc_cCdOriConta, loc_cDsOriConta
        LOCAL loc_cCdDesGrupo, loc_cDsDesGrupo, loc_cCdDesConta, loc_cDsDesConta
        LOCAL loc_nTipoRel, loc_nJuros, loc_nIndexOrdem, loc_nOptBons
        LOCAL loc_cVerData, loc_cVerEmpresa, loc_cVerOpcao
        LOCAL loc_cVerEmiGrupo, loc_cVerEmiConta
        LOCAL loc_cVerOriGrupo, loc_cVerOriConta
        LOCAL loc_cVerDesGrupo, loc_cVerDesConta
        LOCAL loc_cVerOrdem, loc_cVerTipo
        LOCAL loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, loc_cEmissor, loc_cDestino, loc_cOrigem
        LOCAL loc_cTipoD, loc_cSQL, loc_nResult
        LOCAL loc_nDias, loc_nTxDia, loc_nVJuros, loc_dVen, loc_dDat

        loc_lSucesso = .F.
        TRY
            loc_lOK = .T.

            *-- Copiar filtros das propriedades para variaveis locais
            *-- (necessario: ?var em SQLEXEC exige variaveis no escopo local/private)
            loc_nTipoDat    = THIS.this_nTipoDat
            loc_dDtInicial  = THIS.this_dDtInicial
            loc_dDtFinal    = THIS.this_dDtFinal
            loc_cCdEmpresa  = THIS.this_cCdEmpresa
            loc_cDsEmpresa  = THIS.this_cDsEmpresa
            loc_nNrOpcao    = THIS.this_nNrOpcao
            loc_cCdEmiGrupo = THIS.this_cCdEmiGrupo
            loc_cDsEmiGrupo = THIS.this_cDsEmiGrupo
            loc_cCdEmiConta = THIS.this_cCdEmiConta
            loc_cDsEmiConta = THIS.this_cDsEmiConta
            loc_cCdOriGrupo = THIS.this_cCdOriGrupo
            loc_cDsOriGrupo = THIS.this_cDsOriGrupo
            loc_cCdOriConta = THIS.this_cCdOriConta
            loc_cDsOriConta = THIS.this_cDsOriConta
            loc_cCdDesGrupo = THIS.this_cCdDesGrupo
            loc_cDsDesGrupo = THIS.this_cDsDesGrupo
            loc_cCdDesConta = THIS.this_cCdDesConta
            loc_cDsDesConta = THIS.this_cDsDesConta
            loc_nTipoRel    = THIS.this_nTipoRel
            loc_nJuros      = THIS.this_nJuros
            loc_nIndexOrdem = THIS.this_nIndexOrdem
            loc_nOptBons    = THIS.this_nOptBons

            *-- Clausulas WHERE para SQLEXEC (usa ?var para parametrizacao de data/string)
            loc_cVerData = IIF(loc_nTipoDat = 2, ;
                " and b.datas between ?loc_dDtInicial and ?loc_dDtFinal ", ;
                " and b.vencs between ?loc_dDtInicial and ?loc_dDtFinal ")
            loc_cVerEmpresa  = IIF(EMPTY(ALLTRIM(loc_cCdEmpresa)), "", ;
                                   " and a.emps = ?loc_cCdEmpresa ")
            loc_cVerOpcao    = IIF(loc_nNrOpcao = 1, ;
                                   " and not a.notas = '" + SPACE(6) + "' ", ;
                                   IIF(loc_nNrOpcao = 2, ;
                                       " and a.notas = '" + SPACE(6) + "' ", ;
                                       ""))
            loc_cVerEmiGrupo = IIF(EMPTY(ALLTRIM(loc_cCdEmiGrupo)), "", ;
                                   " and b.grupoT = ?loc_cCdEmiGrupo ")
            loc_cVerEmiConta = IIF(EMPTY(ALLTRIM(loc_cCdEmiConta)), "", ;
                                   " and b.contaT = ?loc_cCdEmiConta ")
            loc_cVerOriGrupo = IIF(EMPTY(ALLTRIM(loc_cCdOriGrupo)), "", ;
                                   " and e.grupoOs = ?loc_cCdOriGrupo ")
            loc_cVerOriConta = IIF(EMPTY(ALLTRIM(loc_cCdOriConta)), "", ;
                                   " and e.contaOs = ?loc_cCdOriConta ")
            loc_cVerDesGrupo = IIF(EMPTY(ALLTRIM(loc_cCdDesGrupo)), "", ;
                                   " and e.grupoDs = ?loc_cCdDesGrupo ")
            loc_cVerDesConta = IIF(EMPTY(ALLTRIM(loc_cCdDesConta)), "", ;
                                   " and e.contaDs = ?loc_cCdDesConta ")
            loc_cVerOrdem    = IIF(loc_nIndexOrdem = 1, " ORDER BY 2", ;
                                IIF(loc_nIndexOrdem = 2, " ORDER BY 3", " ORDER BY 4"))

            *-- Filtro de tipo de relatorio: subselects em cursor_4c_SigCdOpt (VFP local)
            DO CASE
            CASE loc_nTipoRel = 2
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where tipos='CR' and devolvidos = 'N'] + ;
                               [ and opants not in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where tipos='DB' and devolvidos = 'S'))]
            CASE loc_nTipoRel = 3
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where tipos='DB' and devolvidos = 'S')]
            CASE loc_nTipoRel = 4
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where devolvidos <> 'S' and ] + ;
                               IIF(loc_nOptBons = 1, [tipos='DB' And Ordens = 1], [0 = 0]) + [)]
                loc_cVerTipo = loc_cVerTipo + ;
                               [ and a.contat Not in(Select Iclis from cursor_4c_CliCqDev)]
            CASE loc_nTipoRel = 5
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where devolvidos = 'S')]
            OTHERWISE
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where tipos='DB' and devolvidos = 'N')]
            ENDCASE

            *-- Clientes com cheque devolvido (necessario para filtro tipo 4 - Bons)
            IF USED("cursor_4c_CliCqDev")
                USE IN cursor_4c_CliCqDev
            ENDIF
            loc_cSQL = "select distinct contat as iclis from sigche" + ;
                       " where umovs in (Select operacaos from SigCdOpt where devolvidos = 'S')"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliCqDev")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar lista de cheques devolvidos"
                loc_lOK = .F.
            ENDIF

            *-- Query principal: cheques com joins em clientes, lancamentos e movimentacoes
            IF loc_lOK
                IF USED("cursor_4c_SqlTmp0")
                    USE IN cursor_4c_SqlTmp0
                ENDIF
                loc_cSQL = "select a.nums, b.valors, b.vencs, b.datas as dtBai, b.datas as dtEmi," + ;
                           " b.grclis, b.iclis, c.rclis as rclisT, d.rclis as rclisO, f.rclis as rclisD," + ;
                           " b.bancos, b.agencias, b.ncontas, b.ncheques, a.numlotes," + ;
                           " b.emps, b.umovs, e.codigos, b.contat, b.grupot, a.valjuros, a.cotas" + ;
                           " from SigCcChm a left join sigcdcli c" + ;
                           " on a.grupot = c.grupos and a.contat = c.iclis," + ;
                           " SigChe b, sigcdcli d, SigCqLcm e, sigcdcli f" + ;
                           " where a.nums = b.nums" + ;
                           " and a.numlotes = e.numlotes" + ;
                           " and b.umovs = e.codigos" + ;
                           " and e.grupoos = d.grupos and e.contaos = d.iclis" + ;
                           " and e.grupods = f.grupos and e.contads = f.iclis" + ;
                           loc_cVerData + loc_cVerEmpresa + loc_cVerOpcao + ;
                           loc_cVerEmiGrupo + loc_cVerEmiConta + ;
                           loc_cVerOriGrupo + loc_cVerOriConta + ;
                           loc_cVerDesGrupo + loc_cVerDesConta + ;
                           " Order by a.nums, a.numlotes, b.datas, b.grclis, b.iclis," + ;
                           " b.vencs, b.bancos, b.agencias, b.ncontas, b.ncheques," + ;
                           " b.valors, b.emps, b.umovs"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlTmp0")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar dados de cheques da carteira"
                    loc_lOK = .F.
                ENDIF
            ENDIF

            IF loc_lOK
                *-- Aplicar filtro de tipo via SELECT local VFP
                *-- (cursor_4c_SigCdOpt e cursor_4c_CliCqDev sao referenciados como VFP aliases)
                IF USED("CsRelatorio")
                    USE IN CsRelatorio
                ENDIF
                SELECT *, 0000000.00 AS cotasE, 0000000.00 AS valsai, 0000000.00 AS valent, ;
                       0000000.00 AS Dif, 0000000.00 AS valliq, SPACE(50) AS NomeCF ;
                    FROM cursor_4c_SqlTmp0 a WHERE 1=1 &loc_cVerTipo ;
                    INTO CURSOR CsRelatorio &loc_cVerOrdem. READWRITE

                *-- Buscar nome da empresa para o cabecalho
                loc_cNomeEmpresa = ""
                loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE cEmps = " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdEmp")
                IF loc_nResult > 0
                    SELECT cursor_4c_SigCdEmp
                    GO TOP
                    IF !EOF()
                        loc_cNomeEmpresa = ALLTRIM(Razas)
                    ENDIF
                    USE IN cursor_4c_SigCdEmp
                ENDIF

                *-- Textos do cabecalho do relatorio
                loc_cTipoD = IIF(loc_nTipoDat = 1, "VENCIMENTO", "EMISSAO")
                DO CASE
                CASE loc_nTipoRel = 1
                    loc_cTitulo = "ATIVOS POR " + loc_cTipoD
                CASE loc_nTipoRel = 2
                    loc_cTitulo = "BAIXADOS POR " + loc_cTipoD
                CASE loc_nTipoRel = 3
                    loc_cTitulo = "NEG.PG"
                CASE loc_nTipoRel = 4
                    loc_cTitulo = "BONS"
                OTHERWISE
                    loc_cTitulo = "DEVOLVIDOS"
                ENDCASE

                loc_cPeriodo = IIF(loc_nTipoDat = 2, "Emiss" + CHR(227) + "o: ", "Vencimento: ") + ;
                               DTOC(loc_dDtInicial) + " " + CHR(224) + " " + DTOC(loc_dDtFinal) + ;
                               " - Empresa: " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdEmpresa)), "Geral", ;
                                   ALLTRIM(loc_cCdEmpresa) + " - " + ALLTRIM(loc_cDsEmpresa))
                loc_cEmissor = "Grupo/Conta Emissor  : " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdEmiGrupo)), "Todos", ;
                                   ALLTRIM(loc_cCdEmiGrupo) + " - " + ALLTRIM(loc_cDsEmiGrupo)) + ;
                               " / " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdEmiConta)), "Todas", ;
                                   ALLTRIM(loc_cCdEmiConta) + " - " + ALLTRIM(loc_cDsEmiConta))
                loc_cDestino = "Grupo/Conta Destino  : " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdDesGrupo)), "Todos", ;
                                   ALLTRIM(loc_cCdDesGrupo) + " - " + ALLTRIM(loc_cDsDesGrupo)) + ;
                               " / " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdDesConta)), "Todas", ;
                                   ALLTRIM(loc_cCdDesConta) + " - " + ALLTRIM(loc_cDsDesConta))
                loc_cOrigem  = "Grupo/Conta Origem   : " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdOriGrupo)), "Todos", ;
                                   ALLTRIM(loc_cCdOriGrupo) + " - " + ALLTRIM(loc_cDsOriGrupo)) + ;
                               " / " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdOriConta)), "Todas", ;
                                   ALLTRIM(loc_cCdOriConta) + " - " + ALLTRIM(loc_cDsOriConta))

                *-- Cursor de cabecalho para o FRX
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                CREATE CURSOR CsCabecalho (NomeEmpresa C(80), Titulo C(80), Periodo C(80), ;
                                           Operacao C(80), Emissor C(80), Destino C(80), Origem C(80))
                INSERT INTO CsCabecalho (NomeEmpresa, Titulo, Periodo, Emissor, Destino, Origem) ;
                    VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, ;
                            loc_cEmissor, loc_cDestino, loc_cOrigem)

                *-- Percorrer registros para calcular cotasE, valsai, Dif, valliq, juros
                SELECT CsRelatorio
                GO TOP
                SCAN
                    *-- Buscar cotas de entrada do cheque para calculo de diferencas
                    loc_cSQL = "select a.cotas, e.codigos from SigCcChm a, SigCqLcm e" + ;
                               " where a.numlotes = e.numlotes" + ;
                               " and a.bancos   ='" + ALLTRIM(CsRelatorio.bancos)   + "'" + ;
                               " and a.agencias ='" + ALLTRIM(CsRelatorio.agencias) + "'" + ;
                               " and a.ncontas  ='" + ALLTRIM(CsRelatorio.ncontas)  + "'" + ;
                               " and a.ncheques ='" + ALLTRIM(CsRelatorio.ncheques) + "'"
                    IF USED("cursor_4c_Cur1")
                        USE IN cursor_4c_Cur1
                    ENDIF
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cur1")

                    IF USED("cursor_4c_Cur2")
                        USE IN cursor_4c_Cur2
                    ENDIF
                    SELECT cotas FROM cursor_4c_Cur1 ;
                        WHERE codigos IN (SELECT operacaos FROM cursor_4c_SigCdOpt ;
                                          WHERE tipos = 'DB' AND devolvidos = 'N') ;
                        INTO CURSOR cursor_4c_Cur2
                    SELECT cursor_4c_Cur2
                    GO TOP
                    SELECT CsRelatorio
                    REPLACE cotasE WITH IIF(!EOF("cursor_4c_Cur2"), cursor_4c_Cur2.cotas, 1.00) ;
                        IN CsRelatorio
                    REPLACE rclisT WITH IIF(ISNULL(rclisT), "", rclisT) IN CsRelatorio
                    REPLACE NomeCF WITH IIF(INLIST(loc_nTipoRel, 1, 3), rclisO, rclisD) IN CsRelatorio

                    DO CASE
                    CASE loc_nTipoRel = 1 AND loc_nTipoDat = 2
                        REPLACE valjuros WITH 0 IN CsRelatorio
                        REPLACE valsai   WITH 0 IN CsRelatorio
                        REPLACE Dif      WITH ROUND(valors / cotas, 2) IN CsRelatorio
                        REPLACE valliq   WITH 0 IN CsRelatorio
                        REPLACE dtBai    WITH CTOD("  /  /  ") IN CsRelatorio

                    CASE loc_nTipoRel = 1 AND loc_nTipoDat = 1
                        REPLACE valsai WITH 0 IN CsRelatorio
                        REPLACE Dif    WITH ROUND(valors / cotas, 2) IN CsRelatorio
                        REPLACE valliq WITH 0 IN CsRelatorio
                        REPLACE dtBai  WITH CTOD("  /  /  ") IN CsRelatorio

                    CASE loc_nTipoRel = 2
                        REPLACE valsai WITH ROUND(valjuros / cotas, 2) IN CsRelatorio
                        REPLACE valent WITH ROUND(valjuros / cotasE, 2) IN CsRelatorio
                        REPLACE Dif    WITH valsai - valent IN CsRelatorio
                        REPLACE valliq WITH valsai + Dif IN CsRelatorio
                        REPLACE dtEmi  WITH CTOD("  /  /  ") IN CsRelatorio
                        REPLACE vencs  WITH CTOD("  /  /  ") IN CsRelatorio

                    CASE loc_nTipoRel = 4 AND loc_nOptBons = 1
                        REPLACE dtBai WITH CTOD("  /  /  ") IN CsRelatorio

                    CASE loc_nTipoRel = 4 AND loc_nOptBons = 2
                        IF SEEK(CsRelatorio.umovs, "cursor_4c_SigCdOpt", "operacaos")
                            IF cursor_4c_SigCdOpt.Ordens = 1
                                REPLACE dtBai WITH CTOD("  /  /  ")
                            ENDIF
                        ENDIF
                        SELECT CsRelatorio

                    CASE INLIST(loc_nTipoRel, 3, 5)
                        REPLACE vencs  WITH CsRelatorio.Vencs IN CsRelatorio
                        REPLACE valsai WITH ROUND(valjuros / cotas, 2) IN CsRelatorio
                        REPLACE Dif    WITH 0 IN CsRelatorio
                        REPLACE valliq WITH 0 IN CsRelatorio

                        IF loc_nJuros > 0
                            loc_dVen   = DATE()
                            loc_dDat   = TTOD(CsRelatorio.Vencs)
                            loc_nDias  = IIF(loc_dDat >= loc_dVen, 0, loc_dVen - loc_dDat)
                            loc_nTxDia = loc_nJuros / 30
                            IF THIS.this_nJurosCarts = 2
                                loc_nVJuros = ROUND(CsRelatorio.valors * ;
                                              (((1 + loc_nTxDia / 100) ^ (loc_nDias)) - 1), 2)
                            ELSE
                                loc_nVJuros = ROUND(CsRelatorio.valors * ;
                                              (loc_nJuros / 100) * (loc_nDias / 30), 2)
                            ENDIF
                            REPLACE ValJuros WITH loc_nVJuros IN CsRelatorio
                        ENDIF
                    ENDCASE
                ENDSCAN

                SELECT CsRelatorio
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                SELECT CsRelatorio
                REPORT FORM (THIS.this_cArquivoFrx) TO PRINTER PROMPT NOCONSOLE
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                SELECT CsRelatorio
                REPORT FORM (THIS.this_cArquivoFrx) PREVIEW NOCONSOLE
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave logica do relatorio (filtros aplicados)
    * Relatorios nao tem PK fisica - chave eh composta pelos filtros principais.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "SIGRECRT|" + ;
                     STR(THIS.this_nTipoDat, 1) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmpresa) + "|" + ;
                     STR(THIS.this_nTipoRel, 1) + "|" + ;
                     STR(THIS.this_nNrOpcao, 1) + "|" + ;
                     STR(THIS.this_nIndexOrdem, 1) + "|" + ;
                     STR(THIS.this_nOptBons, 1) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmiGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmiConta) + "|" + ;
                     ALLTRIM(THIS.this_cCdOriGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cCdOriConta) + "|" + ;
                     ALLTRIM(THIS.this_cCdDesGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cCdDesConta)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de cursor
    * Permite restaurar configuracao de filtros previamente salva.
    * par_cAliasCursor: alias do cursor com colunas TipoDat, DtInicial, DtFinal,
    *   CdEmpresa, DsEmpresa, TipoRel, NrOpcao, IndexOrdem, Juros, OptBons,
    *   CdEmiGrupo, DsEmiGrupo, CdEmiConta, DsEmiConta,
    *   CdOriGrupo, DsOriGrupo, CdOriConta, DsOriConta,
    *   CdDesGrupo, DsDesGrupo, CdDesConta, DsDesConta
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErr, loc_cAlias
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + ;
                                      CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                                      TRANSFORM(par_cAliasCursor)
            RETURN .F.
        ENDIF

        loc_cAlias = par_cAliasCursor

        TRY
            SELECT (loc_cAlias)
            IF !EOF()
                IF TYPE(loc_cAlias + ".TipoDat") = "N"
                    THIS.this_nTipoDat = EVALUATE(loc_cAlias + ".TipoDat")
                ENDIF
                IF TYPE(loc_cAlias + ".DtInicial") = "D"
                    THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".DtInicial")
                ENDIF
                IF TYPE(loc_cAlias + ".DtFinal") = "D"
                    THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".DtFinal")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEmpresa") = "C"
                    THIS.this_cCdEmpresa = EVALUATE(loc_cAlias + ".CdEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmpresa") = "C"
                    THIS.this_cDsEmpresa = EVALUATE(loc_cAlias + ".DsEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".TipoRel") = "N"
                    THIS.this_nTipoRel = EVALUATE(loc_cAlias + ".TipoRel")
                ENDIF
                IF TYPE(loc_cAlias + ".NrOpcao") = "N"
                    THIS.this_nNrOpcao = EVALUATE(loc_cAlias + ".NrOpcao")
                ENDIF
                IF TYPE(loc_cAlias + ".IndexOrdem") = "N"
                    THIS.this_nIndexOrdem = EVALUATE(loc_cAlias + ".IndexOrdem")
                ENDIF
                IF TYPE(loc_cAlias + ".Juros") = "N"
                    THIS.this_nJuros = EVALUATE(loc_cAlias + ".Juros")
                ENDIF
                IF TYPE(loc_cAlias + ".OptBons") = "N"
                    THIS.this_nOptBons = EVALUATE(loc_cAlias + ".OptBons")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEmiGrupo") = "C"
                    THIS.this_cCdEmiGrupo = EVALUATE(loc_cAlias + ".CdEmiGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmiGrupo") = "C"
                    THIS.this_cDsEmiGrupo = EVALUATE(loc_cAlias + ".DsEmiGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEmiConta") = "C"
                    THIS.this_cCdEmiConta = EVALUATE(loc_cAlias + ".CdEmiConta")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmiConta") = "C"
                    THIS.this_cDsEmiConta = EVALUATE(loc_cAlias + ".DsEmiConta")
                ENDIF
                IF TYPE(loc_cAlias + ".CdOriGrupo") = "C"
                    THIS.this_cCdOriGrupo = EVALUATE(loc_cAlias + ".CdOriGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".DsOriGrupo") = "C"
                    THIS.this_cDsOriGrupo = EVALUATE(loc_cAlias + ".DsOriGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".CdOriConta") = "C"
                    THIS.this_cCdOriConta = EVALUATE(loc_cAlias + ".CdOriConta")
                ENDIF
                IF TYPE(loc_cAlias + ".DsOriConta") = "C"
                    THIS.this_cDsOriConta = EVALUATE(loc_cAlias + ".DsOriConta")
                ENDIF
                IF TYPE(loc_cAlias + ".CdDesGrupo") = "C"
                    THIS.this_cCdDesGrupo = EVALUATE(loc_cAlias + ".CdDesGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".DsDesGrupo") = "C"
                    THIS.this_cDsDesGrupo = EVALUATE(loc_cAlias + ".DsDesGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".CdDesConta") = "C"
                    THIS.this_cCdDesConta = EVALUATE(loc_cAlias + ".CdDesConta")
                ENDIF
                IF TYPE(loc_cAlias + ".DsDesConta") = "C"
                    THIS.this_cDsDesConta = EVALUATE(loc_cAlias + ".DsDesConta")
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros vazio"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "sigrecrtBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra execucao do relatorio em LogAuditoria
    * Para relatorios, "Inserir" significa registrar nova execucao,
    * permitindo rastrear quem rodou qual relatorio e quando.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar execu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "sigrecrtBO.Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Registra reexecucao do relatorio em LogAuditoria
    * Para relatorios, "Atualizar" significa registrar uma reexecucao
    * (usuario alterou filtros e gerou o relatorio novamente).
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RERUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar reexecu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "sigrecrtBO.Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores temporarios do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        IF USED("cursor_4c_SqlTmp0")
            USE IN cursor_4c_SqlTmp0
        ENDIF
        IF USED("cursor_4c_CliCqDev")
            USE IN cursor_4c_CliCqDev
        ENDIF
        IF USED("cursor_4c_Cur1")
            USE IN cursor_4c_Cur1
        ENDIF
        IF USED("cursor_4c_Cur2")
            USE IN cursor_4c_Cur2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro registrado
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores permanentes e libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        IF USED("cursor_4c_SigCdOpt")
            USE IN cursor_4c_SigCdOpt
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

