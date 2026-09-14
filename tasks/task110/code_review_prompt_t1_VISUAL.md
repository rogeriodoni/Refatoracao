# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [LAYOUT-POSITION] Controle 'Check1' (parent: SIGREHBR): Top original=469 vs migrado 'chk_4c_Check1' Top=333 (diff=136px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Check2' (parent: SIGREHBR): Top original=469 vs migrado 'chk_4c_Check2' Top=333 (diff=136px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Check3' (parent: SIGREHBR): Top original=469 vs migrado 'chk_4c_Check3' Top=333 (diff=136px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Check4' (parent: SIGREHBR): Top original=469 vs migrado 'chk_4c_Check4' Top=333 (diff=136px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Check5' (parent: SIGREHBR): Top original=469 vs migrado 'chk_4c_Check5' Top=333 (diff=136px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrehbr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2786 linhas total):

*-- Linhas 61 a 69:
61:         loc_lSucesso   = .F.
62:         loc_lContinuar = .T.
63:         TRY
64:             THIS.Caption = "C" + CHR(243) + "digos de Barras Por Estoque"
65: 
66:             IF TYPE("gc_4c_CaminhoIcones") = "U"
67:                 gc_4c_CaminhoIcones = ""
68:             ENDIF
69:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 82 a 91:
82:                 THIS.ConfigurarPageFrame()
83:                 THIS.ConfigurarPaginaLista()
84: 
85:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
86:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
87: 
88:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
89:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
90:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
91:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

*-- Linhas 112 a 150:
112:     PROTECTED PROCEDURE ConfigurarCabecalho()
113:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
114:         WITH THIS.cnt_4c_Cabecalho
115:             .Top         = 0
116:             .Left        = 0
117:             .Width       = THIS.Width
118:             .Height      = 80
119:             .BackStyle   = 1
120:             .BackColor   = RGB(100, 100, 100)
121:             .BorderWidth = 0
122:             .Visible     = .T.
123: 
124:             .AddObject("lbl_4c_Sombra", "Label")
125:             WITH .lbl_4c_Sombra
126:                 .Top       = 22
127:                 .Left      = 22
128:                 .Width     = THIS.Width
129:                 .Height    = 30
130:                 .Caption   = "C" + CHR(243) + "digos de Barras Por Estoque"
131:                 .FontName  = "Tahoma"
132:                 .FontSize  = 14
133:                 .FontBold  = .T.
134:                 .ForeColor = RGB(0, 0, 0)
135:                 .BackStyle = 0
136:                 .Visible   = .T.
137:             ENDWITH
138: 
139:             .AddObject("lbl_4c_Titulo", "Label")
140:             WITH .lbl_4c_Titulo
141:                 .Top       = 20
142:                 .Left      = 20
143:                 .Width     = THIS.Width
144:                 .Height    = 30
145:                 .Caption   = "C" + CHR(243) + "digos de Barras Por Estoque"
146:                 .FontName  = "Tahoma"
147:                 .FontSize  = 14
148:                 .FontBold  = .T.
149:                 .ForeColor = RGB(255, 255, 255)
150:                 .BackStyle = 0

*-- Linhas 161 a 186:
161:     PROTECTED PROCEDURE ConfigurarBotoes()
162:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
163:         WITH THIS.cmg_4c_Botoes
164:             .Top           = 0
165:             .Left          = 529
166:             .Width         = 273
167:             .Height        = 80
168:             .ButtonCount   = 4
169:             .BackStyle     = 0
170:             .BorderStyle   = 0
171:             .BorderColor   = RGB(136, 189, 188)
172:             .SpecialEffect = 1
173:             .Themes        = .F.
174:             .Visible       = .T.
175: 
176:             WITH .Buttons(1)
177:                 .Top             = 5
178:                 .Left            = 5
179:                 .Width           = 65
180:                 .Height          = 70
181:                 .Caption         = "Visualizar"
182:                 .FontBold        = .T.
183:                 .FontItalic      = .T.
184:                 .BackColor       = RGB(255, 255, 255)
185:                 .ForeColor       = RGB(90, 90, 90)
186:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 193 a 205:
193:             ENDWITH
194: 
195:             WITH .Buttons(2)
196:                 .Top             = 5
197:                 .Left            = 71
198:                 .Width           = 65
199:                 .Height          = 70
200:                 .Caption         = "Imprimir"
201:                 .FontName        = "Tahoma"
202:                 .FontBold        = .T.
203:                 .FontItalic      = .T.
204:                 .FontSize        = 8
205:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 214 a 226:
214:             ENDWITH
215: 
216:             WITH .Buttons(3)
217:                 .Top             = 5
218:                 .Left            = 137
219:                 .Width           = 65
220:                 .Height          = 70
221:                 .Caption         = "Documento"
222:                 .FontName        = "Tahoma"
223:                 .FontBold        = .T.
224:                 .FontItalic      = .T.
225:                 .FontSize        = 8
226:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 236 a 248:
236:             ENDWITH
237: 
238:             WITH .Buttons(4)
239:                 .Top             = 5
240:                 .Left            = 203
241:                 .Width           = 65
242:                 .Height          = 70
243:                 .Caption         = "Encerrar"
244:                 .Cancel          = .T.
245:                 .FontName        = "Tahoma"
246:                 .FontBold        = .T.
247:                 .FontItalic      = .T.
248:                 .FontSize        = 8

*-- Linhas 272 a 286:
272: 
273:         loc_oPgf.PageCount = 1
274: 
275:         loc_oPgf.Top    = 85
276:         loc_oPgf.Left   = -1
277:         loc_oPgf.Width  = THIS.Width + 2
278:         loc_oPgf.Height = THIS.Height - 85
279:         loc_oPgf.Tabs   = .F.
280: 
281:         loc_oPgf.Page1.Caption   = "Filtros"
282:         loc_oPgf.Page1.FontName  = "Tahoma"
283:         loc_oPgf.Page1.FontSize  = 8
284:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
285:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
286:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 778 a 858:
778:             loc_oPg = THIS.pgf_4c_Paginas.Page1
779:             WITH THIS.this_oRelatorio
780:                 IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
781:                     loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
782:                 ENDIF
783:                 IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
784:                     loc_oPg.txt_4c_DtFinal.Value = .this_dDtFinal
785:                 ENDIF
786:                 IF PEMSTATUS(loc_oPg, "txt_4c_CdGrEstoque", 5)
787:                     loc_oPg.txt_4c_CdGrEstoque.Value = .this_cCdGrEstoque
788:                 ENDIF
789:                 IF PEMSTATUS(loc_oPg, "txt_4c_DsGrEstoque", 5)
790:                     loc_oPg.txt_4c_DsGrEstoque.Value = .this_cDsGrEstoque
791:                 ENDIF
792:                 IF PEMSTATUS(loc_oPg, "txt_4c_CdEstoque", 5)
793:                     loc_oPg.txt_4c_CdEstoque.Value = .this_cCdEstoque
794:                 ENDIF
795:                 IF PEMSTATUS(loc_oPg, "txt_4c_DsEstoque", 5)
796:                     loc_oPg.txt_4c_DsEstoque.Value = .this_cDsEstoque
797:                 ENDIF
798:                 IF PEMSTATUS(loc_oPg, "txt_4c_IFors", 5)
799:                     loc_oPg.txt_4c_IFors.Value = .this_cIFors
800:                 ENDIF
801:                 IF PEMSTATUS(loc_oPg, "txt_4c_DFors", 5)
802:                     loc_oPg.txt_4c_DFors.Value = .this_cDFors
803:                 ENDIF
804:                 IF PEMSTATUS(loc_oPg, "txt_4c_CdEmpresa", 5)
805:                     loc_oPg.txt_4c_CdEmpresa.Value = .this_cCdEmpresa
806:                 ENDIF
807:                 IF PEMSTATUS(loc_oPg, "txt_4c_DsEmpresa", 5)
808:                     loc_oPg.txt_4c_DsEmpresa.Value = .this_cDsEmpresa
809:                 ENDIF
810:                 IF PEMSTATUS(loc_oPg, "txt_4c_CGgps", 5)
811:                     loc_oPg.txt_4c_CGgps.Value = .this_cCGgps
812:                 ENDIF
813:                 IF PEMSTATUS(loc_oPg, "txt_4c_DGgps", 5)
814:                     loc_oPg.txt_4c_DGgps.Value = .this_cDGgps
815:                 ENDIF
816:                 IF PEMSTATUS(loc_oPg, "txt_4c_CdGPro", 5)
817:                     loc_oPg.txt_4c_CdGPro.Value = .this_cCdGPro
818:                 ENDIF
819:                 IF PEMSTATUS(loc_oPg, "txt_4c_DsGPro", 5)
820:                     loc_oPg.txt_4c_DsGPro.Value = .this_cDsGPro
821:                 ENDIF
822:                 IF PEMSTATUS(loc_oPg, "txt_4c_CdSgrupo", 5)
823:                     loc_oPg.txt_4c_CdSgrupo.Value = .this_cCdSgrupo
824:                 ENDIF
825:                 IF PEMSTATUS(loc_oPg, "txt_4c_DsSgrupo", 5)
826:                     loc_oPg.txt_4c_DsSgrupo.Value = .this_cDsSgrupo
827:                 ENDIF
828:                 IF PEMSTATUS(loc_oPg, "txt_4c_CdCodigo", 5)
829:                     loc_oPg.txt_4c_CdCodigo.Value = .this_cCdCodigo
830:                 ENDIF
831:                 IF PEMSTATUS(loc_oPg, "txt_4c_DsCodigo", 5)
832:                     loc_oPg.txt_4c_DsCodigo.Value = .this_cDsCodigo
833:                 ENDIF
834:                 IF PEMSTATUS(loc_oPg, "txt_4c_CBars", 5)
835:                     loc_oPg.txt_4c_CBars.Value = .this_cCBars
836:                 ENDIF
837:                 IF PEMSTATUS(loc_oPg, "txt_4c_Reduzs", 5)
838:                     loc_oPg.txt_4c_Reduzs.Value = .this_cReduzs
839:                 ENDIF
840:                 IF PEMSTATUS(loc_oPg, "chk_4c_Check1", 5)
841:                     loc_oPg.chk_4c_Check1.Value = .this_nCheck1
842:                 ENDIF
843:                 IF PEMSTATUS(loc_oPg, "chk_4c_Check2", 5)
844:                     loc_oPg.chk_4c_Check2.Value = .this_nCheck2
845:                 ENDIF
846:                 IF PEMSTATUS(loc_oPg, "chk_4c_Check3", 5)
847:                     loc_oPg.chk_4c_Check3.Value = .this_nCheck3
848:                 ENDIF
849:                 IF PEMSTATUS(loc_oPg, "chk_4c_Check4", 5)
850:                     loc_oPg.chk_4c_Check4.Value = .this_nCheck4
851:                 ENDIF
852:                 IF PEMSTATUS(loc_oPg, "chk_4c_Check5", 5)
853:                     loc_oPg.chk_4c_Check5.Value = .this_nCheck5
854:                 ENDIF
855:             ENDWITH
856:             THIS.AtualizarEstadoControles()
857:         CATCH TO loc_oErro
858:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 1009 a 1064:
1009:         loc_oPg = THIS.pgf_4c_Paginas.Page1
1010: 
1011:         *-- ===== PERIODO =====
1012:         loc_oPg.AddObject("lbl_4c_LblPeriodo", "Label")
1013:         WITH loc_oPg.lbl_4c_LblPeriodo
1014:             .Top       = 24
1015:             .Left      = 206
1016:             .Width     = 45
1017:             .Height    = 15
1018:             .Caption   = "Per" + CHR(237) + "odo :"
1019:             .FontName  = "Tahoma"
1020:             .FontSize  = 8
1021:             .ForeColor = RGB(90, 90, 90)
1022:             .BackStyle = 0
1023:             .Visible   = .T.
1024:         ENDWITH
1025: 
1026:         loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
1027:         WITH loc_oPg.txt_4c_DtInicial
1028:             .Top         = 20
1029:             .Left        = 256
1030:             .Width       = 80
1031:             .Height      = 25
1032:             .Value       = {}
1033:             .Format      = "D"
1034:             .FontName    = "Tahoma"
1035:             .FontSize    = 8
1036:             .BackColor   = RGB(255, 255, 255)
1037:             .ForeColor   = RGB(90, 90, 90)
1038:             .BorderStyle = 1
1039:             .Visible     = .T.
1040:         ENDWITH
1041: 
1042:         loc_oPg.AddObject("lbl_4c_PeriodoA", "Label")
1043:         WITH loc_oPg.lbl_4c_PeriodoA
1044:             .Top       = 24
1045:             .Left      = 341
1046:             .Width     = 8
1047:             .Height    = 15
1048:             .Caption   = "a"
1049:             .FontName  = "Tahoma"
1050:             .FontSize  = 8
1051:             .ForeColor = RGB(90, 90, 90)
1052:             .BackStyle = 0
1053:             .Visible   = .T.
1054:         ENDWITH
1055: 
1056:         loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
1057:         WITH loc_oPg.txt_4c_DtFinal
1058:             .Top         = 20
1059:             .Left        = 353
1060:             .Width       = 80
1061:             .Height      = 25
1062:             .Value       = {}
1063:             .Format      = "D"
1064:             .FontName    = "Tahoma"

*-- Linhas 1070 a 1095:
1070:         ENDWITH
1071: 
1072:         *-- ===== GRUPO DE ESTOQUE =====
1073:         loc_oPg.AddObject("lbl_4c_LblGrupo", "Label")
1074:         WITH loc_oPg.lbl_4c_LblGrupo
1075:             .Top       = 53
1076:             .Left      = 213
1077:             .Width     = 38
1078:             .Height    = 15
1079:             .Caption   = "Grupo :"
1080:             .FontName  = "Tahoma"
1081:             .FontSize  = 8
1082:             .ForeColor = RGB(90, 90, 90)
1083:             .BackStyle = 0
1084:             .Visible   = .T.
1085:         ENDWITH
1086: 
1087:         loc_oPg.AddObject("txt_4c_CdGrEstoque", "TextBox")
1088:         WITH loc_oPg.txt_4c_CdGrEstoque
1089:             .Top         = 48
1090:             .Left        = 256
1091:             .Width       = 80
1092:             .Height      = 25
1093:             .Value       = ""
1094:             .FontName    = "Tahoma"
1095:             .FontSize    = 8

*-- Linhas 1101 a 1140:
1101: 
1102:         loc_oPg.AddObject("txt_4c_DsGrEstoque", "TextBox")
1103:         WITH loc_oPg.txt_4c_DsGrEstoque
1104:             .Top         = 48
1105:             .Left        = 339
1106:             .Width       = 316
1107:             .Height      = 25
1108:             .Value       = ""
1109:             .FontName    = "Tahoma"
1110:             .FontSize    = 8
1111:             .BackColor   = RGB(255, 255, 255)
1112:             .ForeColor   = RGB(90, 90, 90)
1113:             .BorderStyle = 1
1114:             .Visible     = .T.
1115:         ENDWITH
1116: 
1117:         *-- ===== CONTA DE ESTOQUE =====
1118:         loc_oPg.AddObject("lbl_4c_LblConta", "Label")
1119:         WITH loc_oPg.lbl_4c_LblConta
1120:             .Top       = 81
1121:             .Left      = 213
1122:             .Width     = 38
1123:             .Height    = 15
1124:             .Caption   = "Conta :"
1125:             .FontName  = "Tahoma"
1126:             .FontSize  = 8
1127:             .ForeColor = RGB(90, 90, 90)
1128:             .BackStyle = 0
1129:             .Visible   = .T.
1130:         ENDWITH
1131: 
1132:         loc_oPg.AddObject("txt_4c_CdEstoque", "TextBox")
1133:         WITH loc_oPg.txt_4c_CdEstoque
1134:             .Top         = 76
1135:             .Left        = 256
1136:             .Width       = 80
1137:             .Height      = 25
1138:             .Value       = ""
1139:             .FontName    = "Tahoma"
1140:             .FontSize    = 8

*-- Linhas 1146 a 1185:
1146: 
1147:         loc_oPg.AddObject("txt_4c_DsEstoque", "TextBox")
1148:         WITH loc_oPg.txt_4c_DsEstoque
1149:             .Top         = 76
1150:             .Left        = 339
1151:             .Width       = 316
1152:             .Height      = 25
1153:             .Value       = ""
1154:             .FontName    = "Tahoma"
1155:             .FontSize    = 8
1156:             .BackColor   = RGB(255, 255, 255)
1157:             .ForeColor   = RGB(90, 90, 90)
1158:             .BorderStyle = 1
1159:             .Visible     = .T.
1160:         ENDWITH
1161: 
1162:         *-- ===== FORNECEDOR =====
1163:         loc_oPg.AddObject("lbl_4c_LblFornecedor", "Label")
1164:         WITH loc_oPg.lbl_4c_LblFornecedor
1165:             .Top       = 109
1166:             .Left      = 187
1167:             .Width     = 64
1168:             .Height    = 15
1169:             .Caption   = "Fornecedor :"
1170:             .FontName  = "Tahoma"
1171:             .FontSize  = 8
1172:             .ForeColor = RGB(90, 90, 90)
1173:             .BackStyle = 0
1174:             .Visible   = .T.
1175:         ENDWITH
1176: 
1177:         loc_oPg.AddObject("txt_4c_IFors", "TextBox")
1178:         WITH loc_oPg.txt_4c_IFors
1179:             .Top         = 104
1180:             .Left        = 256
1181:             .Width       = 80
1182:             .Height      = 25
1183:             .Value       = ""
1184:             .FontName    = "Tahoma"
1185:             .FontSize    = 8

*-- Linhas 1191 a 1230:
1191: 
1192:         loc_oPg.AddObject("txt_4c_DFors", "TextBox")
1193:         WITH loc_oPg.txt_4c_DFors
1194:             .Top         = 104
1195:             .Left        = 339
1196:             .Width       = 316
1197:             .Height      = 25
1198:             .Value       = ""
1199:             .FontName    = "Tahoma"
1200:             .FontSize    = 8
1201:             .BackColor   = RGB(255, 255, 255)
1202:             .ForeColor   = RGB(90, 90, 90)
1203:             .BorderStyle = 1
1204:             .Visible     = .T.
1205:         ENDWITH
1206: 
1207:         *-- ===== EMPRESA =====
1208:         loc_oPg.AddObject("lbl_4c_LblEmpresa", "Label")
1209:         WITH loc_oPg.lbl_4c_LblEmpresa
1210:             .Top       = 137
1211:             .Left      = 201
1212:             .Width     = 50
1213:             .Height    = 15
1214:             .Caption   = "Empresa :"
1215:             .FontName  = "Tahoma"
1216:             .FontSize  = 8
1217:             .ForeColor = RGB(90, 90, 90)
1218:             .BackStyle = 0
1219:             .Visible   = .T.
1220:         ENDWITH
1221: 
1222:         loc_oPg.AddObject("txt_4c_CdEmpresa", "TextBox")
1223:         WITH loc_oPg.txt_4c_CdEmpresa
1224:             .Top         = 132
1225:             .Left        = 256
1226:             .Width       = 31
1227:             .Height      = 25
1228:             .Value       = ""
1229:             .FontName    = "Tahoma"
1230:             .FontSize    = 8

*-- Linhas 1236 a 1275:
1236: 
1237:         loc_oPg.AddObject("txt_4c_DsEmpresa", "TextBox")
1238:         WITH loc_oPg.txt_4c_DsEmpresa
1239:             .Top         = 132
1240:             .Left        = 290
1241:             .Width       = 365
1242:             .Height      = 25
1243:             .Value       = ""
1244:             .FontName    = "Tahoma"
1245:             .FontSize    = 8
1246:             .BackColor   = RGB(255, 255, 255)
1247:             .ForeColor   = RGB(90, 90, 90)
1248:             .BorderStyle = 1
1249:             .Visible     = .T.
1250:         ENDWITH
1251: 
1252:         *-- ===== GRANDE GRUPO =====
1253:         loc_oPg.AddObject("lbl_4c_LblGGpro", "Label")
1254:         WITH loc_oPg.lbl_4c_LblGGpro
1255:             .Top       = 165
1256:             .Left      = 175
1257:             .Width     = 76
1258:             .Height    = 15
1259:             .Caption   = "Grande Grupo :"
1260:             .FontName  = "Tahoma"
1261:             .FontSize  = 8
1262:             .ForeColor = RGB(90, 90, 90)
1263:             .BackStyle = 0
1264:             .Visible   = .T.
1265:         ENDWITH
1266: 
1267:         loc_oPg.AddObject("txt_4c_CGgps", "TextBox")
1268:         WITH loc_oPg.txt_4c_CGgps
1269:             .Top         = 160
1270:             .Left        = 256
1271:             .Width       = 31
1272:             .Height      = 25
1273:             .Value       = ""
1274:             .FontName    = "Tahoma"
1275:             .FontSize    = 8

*-- Linhas 1281 a 1290:
1281: 
1282:         loc_oPg.AddObject("txt_4c_DGgps", "TextBox")
1283:         WITH loc_oPg.txt_4c_DGgps
1284:             .Top         = 160
1285:             .Left        = 290
1286:             .Width       = 365
1287:             .Height      = 25
1288:             .Value       = ""
1289:             .FontName    = "Tahoma"
1290:             .FontSize    = 8

*-- Linhas 1308 a 1333:
1308:         THIS.ConfigurarPaginaDados()
1309: 
1310:         *-- ===== GRUPO DE PRODUTO =====
1311:         loc_oPg.AddObject("lbl_4c_LblGPro", "Label")
1312:         WITH loc_oPg.lbl_4c_LblGPro
1313:             .Top       = 193
1314:             .Left      = 157
1315:             .Width     = 94
1316:             .Height    = 15
1317:             .Caption   = "Grupo de Produto :"
1318:             .FontName  = "Tahoma"
1319:             .FontSize  = 8
1320:             .ForeColor = RGB(90, 90, 90)
1321:             .BackStyle = 0
1322:             .Visible   = .T.
1323:         ENDWITH
1324: 
1325:         loc_oPg.AddObject("txt_4c_CdGPro", "TextBox")
1326:         WITH loc_oPg.txt_4c_CdGPro
1327:             .Top         = 188
1328:             .Left        = 256
1329:             .Width       = 31
1330:             .Height      = 25
1331:             .Value       = ""
1332:             .FontName    = "Tahoma"
1333:             .FontSize    = 8

*-- Linhas 1339 a 1378:
1339: 
1340:         loc_oPg.AddObject("txt_4c_DsGPro", "TextBox")
1341:         WITH loc_oPg.txt_4c_DsGPro
1342:             .Top         = 188
1343:             .Left        = 290
1344:             .Width       = 365
1345:             .Height      = 25
1346:             .Value       = ""
1347:             .FontName    = "Tahoma"
1348:             .FontSize    = 8
1349:             .BackColor   = RGB(255, 255, 255)
1350:             .ForeColor   = RGB(90, 90, 90)
1351:             .BorderStyle = 1
1352:             .Visible     = .T.
1353:         ENDWITH
1354: 
1355:         *-- ===== SUBGRUPO DE PRODUTO =====
1356:         loc_oPg.AddObject("lbl_4c_LblSgrupo", "Label")
1357:         WITH loc_oPg.lbl_4c_LblSgrupo
1358:             .Top       = 221
1359:             .Left      = 140
1360:             .Width     = 111
1361:             .Height    = 15
1362:             .Caption   = "Subgrupo de Produto :"
1363:             .FontName  = "Tahoma"
1364:             .FontSize  = 8
1365:             .ForeColor = RGB(90, 90, 90)
1366:             .BackStyle = 0
1367:             .Visible   = .T.
1368:         ENDWITH
1369: 
1370:         loc_oPg.AddObject("txt_4c_CdSgrupo", "TextBox")
1371:         WITH loc_oPg.txt_4c_CdSgrupo
1372:             .Top         = 216
1373:             .Left        = 256
1374:             .Width       = 52
1375:             .Height      = 25
1376:             .Value       = ""
1377:             .FontName    = "Tahoma"
1378:             .FontSize    = 8

*-- Linhas 1384 a 1423:
1384: 
1385:         loc_oPg.AddObject("txt_4c_DsSgrupo", "TextBox")
1386:         WITH loc_oPg.txt_4c_DsSgrupo
1387:             .Top         = 216
1388:             .Left        = 311
1389:             .Width       = 344
1390:             .Height      = 25
1391:             .Value       = ""
1392:             .FontName    = "Tahoma"
1393:             .FontSize    = 8
1394:             .BackColor   = RGB(255, 255, 255)
1395:             .ForeColor   = RGB(90, 90, 90)
1396:             .BorderStyle = 1
1397:             .Visible     = .T.
1398:         ENDWITH
1399: 
1400:         *-- ===== PRODUTO =====
1401:         loc_oPg.AddObject("lbl_4c_LblProduto", "Label")
1402:         WITH loc_oPg.lbl_4c_LblProduto
1403:             .Top       = 249
1404:             .Left      = 204
1405:             .Width     = 47
1406:             .Height    = 15
1407:             .Caption   = "Produto :"
1408:             .FontName  = "Tahoma"
1409:             .FontSize  = 8
1410:             .ForeColor = RGB(90, 90, 90)
1411:             .BackStyle = 0
1412:             .Visible   = .T.
1413:         ENDWITH
1414: 
1415:         loc_oPg.AddObject("txt_4c_CdCodigo", "TextBox")
1416:         WITH loc_oPg.txt_4c_CdCodigo
1417:             .Top         = 244
1418:             .Left        = 256
1419:             .Width       = 108
1420:             .Height      = 25
1421:             .Value       = ""
1422:             .FontName    = "Tahoma"
1423:             .FontSize    = 8

*-- Linhas 1429 a 1591:
1429: 
1430:         loc_oPg.AddObject("txt_4c_DsCodigo", "TextBox")
1431:         WITH loc_oPg.txt_4c_DsCodigo
1432:             .Top         = 244
1433:             .Left        = 367
1434:             .Width       = 288
1435:             .Height      = 25
1436:             .Value       = ""
1437:             .FontName    = "Tahoma"
1438:             .FontSize    = 8
1439:             .BackColor   = RGB(255, 255, 255)
1440:             .ForeColor   = RGB(90, 90, 90)
1441:             .BorderStyle = 1
1442:             .Visible     = .T.
1443:         ENDWITH
1444: 
1445:         *-- ===== CODIGO DE BARRAS =====
1446:         loc_oPg.AddObject("lbl_4c_LblBarra", "Label")
1447:         WITH loc_oPg.lbl_4c_LblBarra
1448:             .Top       = 277
1449:             .Left      = 216
1450:             .Width     = 35
1451:             .Height    = 15
1452:             .Caption   = "Barra :"
1453:             .FontName  = "Tahoma"
1454:             .FontSize  = 8
1455:             .ForeColor = RGB(90, 90, 90)
1456:             .BackStyle = 0
1457:             .Visible   = .T.
1458:         ENDWITH
1459: 
1460:         loc_oPg.AddObject("txt_4c_CBars", "TextBox")
1461:         WITH loc_oPg.txt_4c_CBars
1462:             .Top         = 272
1463:             .Left        = 256
1464:             .Width       = 108
1465:             .Height      = 25
1466:             .Value       = ""
1467:             .FontName    = "Tahoma"
1468:             .FontSize    = 8
1469:             .BackColor   = RGB(255, 255, 255)
1470:             .ForeColor   = RGB(90, 90, 90)
1471:             .BorderStyle = 1
1472:             .Visible     = .T.
1473:         ENDWITH
1474: 
1475:         *-- ===== CODIGO REDUZIDO =====
1476:         loc_oPg.AddObject("lbl_4c_LblReduzido", "Label")
1477:         WITH loc_oPg.lbl_4c_LblReduzido
1478:             .Top       = 305
1479:             .Left      = 162
1480:             .Width     = 89
1481:             .Height    = 15
1482:             .Caption   = "C" + CHR(243) + "digo Reduzido :"
1483:             .FontName  = "Tahoma"
1484:             .FontSize  = 8
1485:             .ForeColor = RGB(90, 90, 90)
1486:             .BackStyle = 0
1487:             .Visible   = .T.
1488:         ENDWITH
1489: 
1490:         loc_oPg.AddObject("txt_4c_Reduzs", "TextBox")
1491:         WITH loc_oPg.txt_4c_Reduzs
1492:             .Top         = 300
1493:             .Left        = 256
1494:             .Width       = 31
1495:             .Height      = 25
1496:             .Value       = ""
1497:             .FontName    = "Tahoma"
1498:             .FontSize    = 8
1499:             .BackColor   = RGB(255, 255, 255)
1500:             .ForeColor   = RGB(90, 90, 90)
1501:             .BorderStyle = 1
1502:             .Visible     = .T.
1503:         ENDWITH
1504: 
1505:         *-- ===== IMPRESSAO / CHECKBOXES =====
1506:         loc_oPg.AddObject("lbl_4c_LblImpressao", "Label")
1507:         WITH loc_oPg.lbl_4c_LblImpressao
1508:             .Top       = 333
1509:             .Left      = 192
1510:             .Width     = 59
1511:             .Height    = 15
1512:             .Caption   = "Impress" + CHR(227) + "o :"
1513:             .FontName  = "Tahoma"
1514:             .FontSize  = 8
1515:             .ForeColor = RGB(90, 90, 90)
1516:             .BackStyle = 0
1517:             .Visible   = .T.
1518:         ENDWITH
1519: 
1520:         loc_oPg.AddObject("chk_4c_Check3", "CheckBox")
1521:         WITH loc_oPg.chk_4c_Check3
1522:             .Top       = 333
1523:             .Left      = 257
1524:             .Width     = 58
1525:             .Height    = 15
1526:             .Caption   = "Dura" + CHR(231) + CHR(227) + "o"
1527:             .Value     = 0
1528:             .FontName  = "Tahoma"
1529:             .FontSize  = 8
1530:             .ForeColor = RGB(90, 90, 90)
1531:             .BackStyle = 0
1532:             .Visible   = .T.
1533:         ENDWITH
1534: 
1535:         loc_oPg.AddObject("chk_4c_Check4", "CheckBox")
1536:         WITH loc_oPg.chk_4c_Check4
1537:             .Top       = 333
1538:             .Left      = 340
1539:             .Width     = 56
1540:             .Height    = 15
1541:             .Caption   = "Imagem"
1542:             .Value     = 0
1543:             .FontName  = "Tahoma"
1544:             .FontSize  = 8
1545:             .ForeColor = RGB(90, 90, 90)
1546:             .BackStyle = 0
1547:             .Visible   = .T.
1548:         ENDWITH
1549: 
1550:         loc_oPg.AddObject("chk_4c_Check2", "CheckBox")
1551:         WITH loc_oPg.chk_4c_Check2
1552:             .Top       = 333
1553:             .Left      = 429
1554:             .Width     = 46
1555:             .Height    = 15
1556:             .Caption   = "Custo"
1557:             .Value     = 0
1558:             .FontName  = "Tahoma"
1559:             .FontSize  = 8
1560:             .ForeColor = RGB(90, 90, 90)
1561:             .BackStyle = 0
1562:             .Visible   = .T.
1563:         ENDWITH
1564: 
1565:         loc_oPg.AddObject("chk_4c_Check1", "CheckBox")
1566:         WITH loc_oPg.chk_4c_Check1
1567:             .Top       = 333
1568:             .Left      = 504
1569:             .Width     = 48
1570:             .Height    = 15
1571:             .Caption   = "Venda"
1572:             .Value     = 0
1573:             .FontName  = "Tahoma"
1574:             .FontSize  = 8
1575:             .ForeColor = RGB(90, 90, 90)
1576:             .BackStyle = 0
1577:             .Visible   = .T.
1578:         ENDWITH
1579: 
1580:         loc_oPg.AddObject("chk_4c_Check5", "CheckBox")
1581:         WITH loc_oPg.chk_4c_Check5
1582:             .Top       = 333
1583:             .Left      = 578
1584:             .Width     = 58
1585:             .Height    = 15
1586:             .Caption   = "Anal" + CHR(237) + "tico"
1587:             .Value     = 0
1588:             .FontName  = "Tahoma"
1589:             .FontSize  = 8
1590:             .ForeColor = RGB(90, 90, 90)
1591:             .BackStyle = 0


### BO (C:\4c\projeto\app\classes\sigrehbrBO.prg):
*==============================================================================
* SIGREHBRBO.PRG
* Business Object para Relatorio de Codigos de Barras Por Estoque
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigrehbrBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = ""
    this_cCampoChave    = ""

    *-- Periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Grupo de Estoque (get_cd_grestoque / get_ds_grestoque)
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""

    *-- Conta de Estoque (get_cd_estoque / get_ds_estoque)
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""

    *-- Empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa     = ""
    this_cDsEmpresa     = ""

    *-- Fornecedor (getIFors / getDFors)
    this_cIFors         = ""
    this_cDFors         = ""

    *-- Grande Grupo (getCGgps / getDGgps)
    this_cCGgps         = ""
    this_cDGgps         = ""

    *-- Grupo de Produto (Get_Cd_GPro / Get_Ds_GPro)
    this_cCdGPro        = ""
    this_cDsGPro        = ""

    *-- Subgrupo de Produto (get_cd_sgrupo / get_ds_sgrupo)
    this_cCdSgrupo      = ""
    this_cDsSgrupo      = ""

    *-- Produto (get_cd_codigo / get_ds_codigo)
    this_cCdCodigo      = ""
    this_cDsCodigo      = ""

    *-- Codigo de Barras (getCBars)
    this_cCBars         = ""

    *-- Codigo Reduzido (getReduzs)
    this_cReduzs        = ""

    *-- Opcoes de impressao (checkboxes)
    this_nCheck1        = 0    && Venda
    this_nCheck2        = 0    && Custo
    this_nCheck3        = 0    && Duracao (seleciona SigReHb3)
    this_nCheck4        = 0    && Imagem
    this_nCheck5        = 0    && Analitico (seleciona SigReHb2)

    *-- Cursores e caminhos FRX
    this_cCursorDados       = "TmpEti"
    this_cCursorCabecalho   = "csCabecalho"
    this_cFrxBase1          = ""
    this_cFrxBase2          = ""
    this_cFrxBase3          = ""

    *-- Nome da empresa para cabecalho do relatorio
    this_cNomeEmpresa       = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO configurando caminhos dos relatorios FRX
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        THIS.this_dDtInicial  = DATE()
        THIS.this_dDtFinal    = DATE()
        THIS.this_cFrxBase1   = gc_4c_CaminhoReports + "SigReHb1.frx"
        THIS.this_cFrxBase2   = gc_4c_CaminhoReports + "SigReHb2.frx"
        THIS.this_cFrxBase3   = gc_4c_CaminhoReports + "SigReHb3.frx"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa query principal e prepara TmpEti para relatorio
    * Equivalente ao metodo "processamento" do original SIGREHBR
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cWhere, loc_cSQL, loc_nResult
        LOCAL loc_cGrupo, loc_cSgrupo, loc_cTVen, loc_cTCus, loc_llIImg
        LOCAL loc_cNEmp, loc_cTits, loc_cSubs

        loc_lSucesso = .F.
        TRY
            loc_cTVen  = IIF(THIS.this_nCheck1 = 1, "S", "N")
            loc_cTCus  = IIF(THIS.this_nCheck2 = 1, "S", "N")
            loc_llIImg = (THIS.this_nCheck4 = 1)

            *-- Obtem nome da empresa para o cabecalho
            loc_cNEmp = THIS.BuscarNomeEmpresa()

            *-- Titulo: "Posicao de Codigo de Barras [(codigo reduzido)]"
            loc_cTits = "Posi" + CHR(231) + CHR(227) + "o de C" + CHR(243) + "digo de Barras"
            IF !EMPTY(ALLTRIM(THIS.this_cReduzs))
                loc_cTits = loc_cTits + " (" + ALLTRIM(THIS.this_cReduzs) + ")"
            ENDIF

            *-- Subtitulo: periodo e filtros aplicados
            loc_cSubs = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                        " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal)
            IF !EMPTY(ALLTRIM(THIS.this_cCdGrEstoque))
                loc_cSubs = loc_cSubs + CHR(13) + ALLTRIM(THIS.this_cCdGrEstoque) + ;
                            " - " + ALLTRIM(THIS.this_cDsGrEstoque)
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cCdEstoque))
                loc_cSubs = loc_cSubs + CHR(13) + ALLTRIM(THIS.this_cCdEstoque) + ;
                            " - " + ALLTRIM(THIS.this_cDsEstoque)
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cCdCodigo))
                loc_cSubs = loc_cSubs + CHR(13) + ALLTRIM(THIS.this_cCdCodigo) + ;
                            " - " + ALLTRIM(THIS.this_cDsCodigo)
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cIFors))
                loc_cSubs = loc_cSubs + CHR(13) + ALLTRIM(THIS.this_cIFors) + ;
                            " - " + ALLTRIM(THIS.this_cDFors)
            ENDIF

            *-- Cria cursor de cabecalho para uso no FRX
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho (Empresa C(80), Titulo C(80), SubTitulo C(80), llImpConta L)
            INSERT INTO csCabecalho (Empresa, Titulo, SubTitulo, llImpConta) ;
                VALUES (loc_cNEmp, loc_cTits, loc_cSubs, EMPTY(ALLTRIM(THIS.this_cCdEstoque)))

            *-- Monta clausula WHERE baseada nos filtros
            IF EMPTY(ALLTRIM(THIS.this_cCdGrEstoque))
                loc_cWhere = "1=1"
            ELSE
                loc_cGrupo = PADR(THIS.this_cCdGrEstoque, 10)
                loc_cWhere = "a.Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF

            IF !EMPTY(THIS.this_dDtInicial) AND !EMPTY(THIS.this_dDtFinal)
                loc_cWhere = loc_cWhere + ;
                    " AND a.Datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                    " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDtFinal) + ")"
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                loc_cWhere = loc_cWhere + " AND a.EmpOs = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmpresa))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCdEstoque))
                loc_cWhere = loc_cWhere + " AND a.Contas = " + EscaparSQL(ALLTRIM(THIS.this_cCdEstoque))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCGgps))
                loc_cWhere = loc_cWhere + " AND b.Mercs = " + EscaparSQL(ALLTRIM(THIS.this_cCGgps))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCdGPro))
                loc_cWhere = loc_cWhere + " AND b.CGrus = " + EscaparSQL(ALLTRIM(THIS.this_cCdGPro))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCdSgrupo))
                loc_cSgrupo = PADR(THIS.this_cCdSgrupo, 6)
                loc_cWhere = loc_cWhere + " AND b.SGrus = " + EscaparSQL(loc_cSgrupo)
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCdCodigo))
                loc_cWhere = loc_cWhere + " AND a.CPros = " + EscaparSQL(ALLTRIM(THIS.this_cCdCodigo))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cReduzs))
                loc_cWhere = loc_cWhere + " AND Left(a.CodAmss, 3) = " + EscaparSQL(ALLTRIM(THIS.this_cReduzs))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cIFors))
                loc_cWhere = loc_cWhere + " AND b.IFors = " + EscaparSQL(ALLTRIM(THIS.this_cIFors))
            ENDIF

            *-- Monta query principal (quebrada em multiplas linhas para evitar limite VFP9)
            loc_cSQL = "Select a.EmpOs as Emps, a.Grupos, a.Contas, a.CPros, a.CBars, a.Qtds, a.Pesos, "
            loc_cSQL = loc_cSQL + "b.DPros, a.CodCors, a.CodTams, b.CUnis, b.CUniPs, b.PCuss, b.PVens, "
            loc_cSQL = loc_cSQL + "' ' as CVens, ' ' as CCuss, b.FigJpgs, a.Datas, a.CBars as NDias, 0 as Imps, "
            loc_cSQL = loc_cSQL + "d.rClis, Cast(b.dpro3s as char(200)) as dpro3s, b.Reffs, Left(a.CodAmss, 3) as Reds "
            loc_cSQL = loc_cSQL + "From SigOpEtq a "
            loc_cSQL = loc_cSQL + "Left Join SigCdPro b On a.CPros = b.CPros "
            loc_cSQL = loc_cSQL + "Left Join SigCdCli d on d.iClis = a.Contas "
            loc_cSQL = loc_cSQL + "Where " + loc_cWhere + " "
            loc_cSQL = loc_cSQL + "Order By a.EmpOs, a.Grupos, a.Contas, a.CPros, a.CBars"

            IF USED("TmpEti")
                USE IN TmpEti
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEti")
            IF loc_nResult > 0
                SELECT TmpEti
                GO TOP IN TmpEti

                *-- Zera Datas/NDias e define flags de impressao de venda/custo
                UPDATE TmpEti ;
                    SET Datas = {}, ;
                        NDias = 0, ;
                        CVens = loc_cTVen, ;
                        CCuss = loc_cTCus

                *-- Processa historicos (modo Duracao) ou apenas imagens
                IF THIS.this_nCheck3 = 1
                    loc_lSucesso = THIS.ProcessarHistoricosDuracao(loc_llIImg)
                ELSE
                    IF loc_llIImg
                    loc_lSucesso = THIS.ProcessarImagensSimples()
                ELSE
                    loc_lSucesso = .T.
                    ENDIF
                ENDIF

                SELECT TmpEti
                GO TOP IN TmpEti
            ELSE
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o ao buscar dados de etiquetas."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarNomeEmpresa - Retorna nome da empresa para o cabecalho do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarNomeEmpresa()
        RETURN ALLTRIM(go_4c_Sistema.cEmpresa)
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarHistoricosDuracao - Para cada item em TmpEti busca o ultimo
    * historico de entrada em SigMvHst e calcula dias de permanencia no estoque
    * Equivalente ao bloco SCAN do modo Duracao (Check3=1) no original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarHistoricosDuracao(par_llIImg)
        LOCAL loc_lSucesso, loc_cKey, loc_cBar, loc_cSQL, loc_nResult
        LOCAL loc_cArq, loc_lHasImg, loc_dDataHis, loc_nDias, loc_cFoto

        loc_lSucesso = .T.
        loc_cKey = SPACE(33)

        IF par_llIImg
            THIS.PrepararCursorBranco()
        ENDIF

        SELECT TmpEti
        GO TOP IN TmpEti

        SCAN
            loc_cBar = ALLTRIM(STR(TmpEti.CBars, 14))

            *-- Marca primeiro registro de cada combinacao produto/conta para imagem
            IF par_llIImg AND (loc_cKey <> TmpEti.Emps + TmpEti.Grupos + TmpEti.Contas + TmpEti.CPros)
                loc_cKey = TmpEti.Emps + TmpEti.Grupos + TmpEti.Contas + TmpEti.CPros
                REPLACE Imps WITH 1 IN TmpEti
            ENDIF

            *-- Busca ultimo historico de entrada para esta combinacao de barcode+grupo+estoque+cor+tamanho
            loc_cSQL = "Select Datas, Seqs "
            loc_cSQL = loc_cSQL + "From SigMvHst "
            loc_cSQL = loc_cSQL + "Where CodBarras = " + loc_cBar
            loc_cSQL = loc_cSQL + " And Grupos = " + EscaparSQL(ALLTRIM(TmpEti.Grupos))
            loc_cSQL = loc_cSQL + " And Estos = " + EscaparSQL(ALLTRIM(TmpEti.Contas))
            loc_cSQL = loc_cSQL + " And CodCors = " + EscaparSQL(ALLTRIM(TmpEti.CodCors))
            loc_cSQL = loc_cSQL + " And CodTams = " + EscaparSQL(ALLTRIM(TmpEti.CodTams))
            loc_cSQL = loc_cSQL + " And Opers = 'E' "
            loc_cSQL = loc_cSQL + "Order By Seqs Desc"

            IF USED("TmpHis")
                USE IN TmpHis
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpHis")
            IF loc_nResult < 1
                MsgErro("Falha na conex" + CHR(227) + "o ao buscar hist" + CHR(243) + "rico.", "Erro")
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o ao buscar hist" + CHR(243) + "rico."
                IF USED("TmpHis")
                    USE IN TmpHis
                ENDIF
                loc_lSucesso = .F.
                EXIT
            ENDIF

            SELECT TmpHis
            GO TOP IN TmpHis

            IF !EOF() AND !EMPTY(TmpHis.Datas)
                loc_dDataHis = TTOD(TmpHis.Datas)
                loc_nDias    = DATE() - loc_dDataHis
                REPLACE Datas WITH TTOD(TmpHis.Datas), ;
                        NDias WITH loc_nDias ;
                        IN TmpEti
            ENDIF

            IF USED("TmpHis")
                USE IN TmpHis
            ENDIF

            IF par_llIImg
                loc_cArq = SYS(2023) + "\SigReHb3_" + ;
                           PADL(ALLTRIM(STR(TmpEti.CBars, 14)), 14, "0") + ".jpg"
                CLEAR RESOURCES
                loc_lHasImg = .F.
                IF !ISNULL(TmpEti.FigJpgs)
                    IF !EMPTY(TmpEti.FigJpgs)
                        IF LEN(ALLTRIM(TmpEti.FigJpgs)) > 10
                            loc_lHasImg = .T.
                        ENDIF
                    ENDIF
                ENDIF
                IF loc_lHasImg
                    loc_cFoto = STRCONV( ;
                        STRTRAN( ;
                            STRTRAN( ;
                                STRTRAN(TmpEti.FigJpgs, "data:image/png;base64,", ""), ;
                                "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,", ""), 14)
                    STRTOFILE(loc_cFoto, loc_cArq)
                ELSE
                    THIS.CopiarImagemBranca(loc_cArq)
                ENDIF
            ENDIF

            SELECT TmpEti
        ENDSCAN

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarImagensSimples - Processa imagens sem busca de historico
    * Usado quando Check4=1 e Check3=0 (imagens sem modo Duracao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarImagensSimples()
        LOCAL loc_lSucesso, loc_cKey, loc_cArq, loc_lHasImg, loc_cFoto

        loc_lSucesso = .T.
        loc_cKey = SPACE(33)
        THIS.PrepararCursorBranco()

        SELECT TmpEti
        GO TOP IN TmpEti

        SCAN
            IF (loc_cKey <> TmpEti.Emps + TmpEti.Grupos + TmpEti.Contas + TmpEti.CPros)
                loc_cKey = TmpEti.Emps + TmpEti.Grupos + TmpEti.Contas + TmpEti.CPros
                REPLACE Imps WITH 1 IN TmpEti
            ENDIF

            loc_cArq = SYS(2023) + "\SigReHb3_" + ;
                       PADL(ALLTRIM(STR(TmpEti.CBars, 14)), 14, "0") + ".jpg"
            CLEAR RESOURCES
            loc_lHasImg = .F.
            IF !ISNULL(TmpEti.FigJpgs)
                IF !EMPTY(TmpEti.FigJpgs)
                    IF LEN(ALLTRIM(TmpEti.FigJpgs)) > 10
                        loc_lHasImg = .T.
                    ENDIF
                ENDIF
            ENDIF
            IF loc_lHasImg
                loc_cFoto = STRCONV( ;
                    STRTRAN( ;
                        STRTRAN( ;
                            STRTRAN(TmpEti.FigJpgs, "data:image/png;base64,", ""), ;
                            "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                STRTOFILE(loc_cFoto, loc_cArq)
            ELSE
                THIS.CopiarImagemBranca(loc_cArq)
            ENDIF
        ENDSCAN

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursorBranco - Cria cursor memo com imagem branca para substituir
    * produtos sem foto no relatorio com imagens (Check4=1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararCursorBranco()
        LOCAL loc_cBrc
        loc_cBrc = gc_4c_CaminhoBase + "BrJpg.JPG"
        IF !FILE(loc_cBrc)
            loc_cBrc = gc_4c_CaminhoReports + "BrJpg.JPG"
        ENDIF
        IF !FILE(loc_cBrc)
            RETURN
        ENDIF
        IF USED("crBranco")
            USE IN crBranco
        ENDIF
        CREATE CURSOR crBranco (Branco M)
        SELECT crBranco
        APPEND BLANK IN crBranco
        APPEND MEMO Branco FROM (loc_cBrc) OVERWRITE
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarImagemBranca - Copia imagem branca para o arquivo destino
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CopiarImagemBranca(par_cArquivo)
        IF USED("crBranco")
            COPY MEMO crBranco.Branco TO (par_cArquivo)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparArquivosImagem - Remove arquivos temporarios de imagem apos impressao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparArquivosImagem()
        LOCAL loc_cArq
        loc_cArq = SYS(2023) + "\SigReHb3_*.jpg"
        DELETE FILE &loc_cArq.
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em modo preview na tela
    * Equivalente ao metodo "visualizacao" do original SIGREHBR
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nCheck3 = 1
                    REPORT FORM (THIS.this_cFrxBase3) PREVIEW NOCONSOLE
                ELSE
                    IF THIS.this_nCheck5 = 1
                    REPORT FORM (THIS.this_cFrxBase2) PREVIEW NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cFrxBase1) PREVIEW NOCONSOLE
                    ENDIF
                ENDIF
                THIS.LimparArquivosImagem()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora com dialogo de selecao
    * Equivalente ao metodo "impressao" do original SIGREHBR
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nCheck3 = 1
                    REPORT FORM (THIS.this_cFrxBase3) TO PRINTER PROMPT NOCONSOLE
                ELSE
                    IF THIS.this_nCheck5 = 1
                    REPORT FORM (THIS.this_cFrxBase2) TO PRINTER PROMPT NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cFrxBase1) TO PRINTER PROMPT NOCONSOLE
                    ENDIF
                ENDIF
                THIS.LimparArquivosImagem()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDireto - Envia relatorio para impressora sem dialogo de selecao
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDireto()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nCheck3 = 1
                    REPORT FORM (THIS.this_cFrxBase3) TO PRINTER NOCONSOLE
                ELSE
                    IF THIS.this_nCheck5 = 1
                    REPORT FORM (THIS.this_cFrxBase2) TO PRINTER NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cFrxBase1) TO PRINTER NOCONSOLE
                    ENDIF
                ENDIF
                THIS.LimparArquivosImagem()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

ENDDEFINE

