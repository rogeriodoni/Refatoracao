# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3040 linhas total):

*-- Linhas 24 a 207:
24:     this_lAutomatico = .F.
25: 
26:     *==========================================================================
27:     PROCEDURE Init()
28:     *==========================================================================
29:         RETURN DODEFAULT()
30:     ENDPROC
31: 
32:     *==========================================================================
33:     PROTECTED PROCEDURE ConfigurarPageFrame()
34:     *==========================================================================
35:         THIS.Picture    = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
36:         THIS.ScrollBars = 0
37:         THIS.ShowTips   = .T.
38:     ENDPROC
39: 
40:     *==========================================================================
41:     PROTECTED PROCEDURE InicializarForm()
42:     *==========================================================================
43:         LOCAL loc_lSucesso, loc_oErro
44:         loc_lSucesso = .F.
45:         TRY
46:             THIS.ConfigurarPageFrame()
47: 
48:             THIS.this_oBusinessObject = CREATEOBJECT("sigprccpBO")
49:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
50:                 MsgErro("Erro ao criar sigprccpBO.", "Erro InicializarForm")
51:             ELSE
52:                 IF !THIS.this_oBusinessObject.InicializarCursores()
53:                     MsgErro("Falha ao inicializar cursores.", "Erro InicializarForm")
54:                 ELSE
55:                     THIS.ConfigurarCabecalho()
56:                     THIS.ConfigurarBotoes()
57:                     THIS.ConfigurarFiltros()
58:                     THIS.ConfigurarDados()
59:                     THIS.ConfigurarGrade()
60: 
61:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
62:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
63: 
64:                     BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnProcessarClick")
65:                     BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnAtualizarClick")
66:                     BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnEncerrarClick")
67:                     BINDEVENT(THIS.cmd_4c_Imprimir,          "Click", THIS, "BtnImprimirClick")
68:                     BINDEVENT(THIS.cmd_4c_SelTudo,           "Click", THIS, "BtnSelTudoClick")
69:                     BINDEVENT(THIS.cmd_4c_Desmarcar,         "Click", THIS, "BtnDesmarcarClick")
70: 
71:                     BINDEVENT(THIS.opt_4c_Recalc, "InteractiveChange", THIS, "OptRecalcChange")
72: 
73:                     BINDEVENT(THIS.txt_4c_CFornecs, "KeyPress", THIS, "TxtCFornecKeyPress")
74:                     BINDEVENT(THIS.txt_4c_MercI,   "KeyPress", THIS, "TxtMercIKeyPress")
75:                     BINDEVENT(THIS.txt_4c_MercF,   "KeyPress", THIS, "TxtMercFKeyPress")
76:                     BINDEVENT(THIS.txt_4c_CGrui,   "KeyPress", THIS, "TxtCGruiKeyPress")
77:                     BINDEVENT(THIS.txt_4c_CGruf,   "KeyPress", THIS, "TxtCGrufKeyPress")
78:                     BINDEVENT(THIS.txt_4c_SgruI,   "KeyPress", THIS, "TxtSgruIKeyPress")
79:                     BINDEVENT(THIS.txt_4c_SgruF,   "KeyPress", THIS, "TxtSgruFKeyPress")
80:                     BINDEVENT(THIS.txt_4c_CUnii,   "KeyPress", THIS, "TxtCUniiKeyPress")
81:                     BINDEVENT(THIS.txt_4c_CUnif,   "KeyPress", THIS, "TxtCUnifKeyPress")
82:                     BINDEVENT(THIS.txt_4c_Lini,    "KeyPress", THIS, "TxtLiniKeyPress")
83:                     BINDEVENT(THIS.txt_4c_Linf,    "KeyPress", THIS, "TxtLinfKeyPress")
84:                     BINDEVENT(THIS.txt_4c_Coli,    "KeyPress", THIS, "TxtColiKeyPress")
85:                     BINDEVENT(THIS.txt_4c_Colf,    "KeyPress", THIS, "TxtColfKeyPress")
86:                     BINDEVENT(THIS.txt_4c_Moedai,  "KeyPress", THIS, "TxtMoedaiKeyPress")
87:                     BINDEVENT(THIS.txt_4c_Moedaf,  "KeyPress", THIS, "TxtMoedafKeyPress")
88:                     BINDEVENT(THIS.txt_4c_Feitio,  "KeyPress", THIS, "TxtFeitioKeyPress")
89:                     BINDEVENT(THIS.txt_4c_NewMkp,  "KeyPress", THIS, "TxtNewMkpKeyPress")
90:                     BINDEVENT(THIS.txt_4c_Reajuste,"KeyPress", THIS, "TxtReajusteKeyPress")
91:                     BINDEVENT(THIS.txt_4c_NMrk,    "KeyPress", THIS, "TxtNMrkKeyPress")
92:                     BINDEVENT(THIS.txt_4c_Encargo, "KeyPress", THIS, "TxtEncargoKeyPress")
93: 
94:                     BINDEVENT(THIS.grd_4c_Produto, "AfterRowColChange", THIS, "GrdAfterRowColChange")
95: 
96:                     THIS.TornarControlesVisiveis(THIS)
97: 
98:                     THIS.opt_4c_Compra.Value   = 3
99:                     THIS.opt_4c_Pven.Value     = 2
100: 
101:                     THIS.OptRecalcChange()
102: 
103:                     THIS.txt_4c_CFornecs.SetFocus()
104: 
105:                     IF THIS.this_lAutomatico
106:                         THIS.this_oBusinessObject.ProcessaAutomatico()
107:                         THIS.Release()
108:                         loc_lSucesso = .T.
109:                     ENDIF
110: 
111:                     loc_lSucesso = .T.
112:                 ENDIF
113:             ENDIF
114:         CATCH TO loc_oErro
115:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
116:                     " PROC=" + loc_oErro.Procedure, "Erro InicializarForm Formsigprccp")
117:         ENDTRY
118:         RETURN loc_lSucesso
119:     ENDPROC
120: 
121:     *==========================================================================
122:     PROTECTED PROCEDURE ConfigurarCabecalho()
123:     *==========================================================================
124:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
125:         WITH THIS.cnt_4c_Cabecalho
126:             .Top         = 0
127:             .Left        = 0
128:             .Width       = THIS.Width
129:             .Height      = 80
130:             .BackStyle   = 1
131:             .BackColor   = RGB(100, 100, 100)
132:             .BorderWidth = 0
133: 
134:             .AddObject("lbl_4c_Sombra", "Label")
135:             WITH .lbl_4c_Sombra
136:                 .Top       = 18
137:                 .Left      = 10
138:                 .Width     = THIS.Width
139:                 .Height    = 40
140:                 .AutoSize  = .F.
141:                 .FontName  = "Tahoma"
142:                 .FontSize  = 18
143:                 .FontBold  = .T.
144:                 .BackStyle = 0
145:                 .ForeColor = RGB(0, 0, 0)
146:                 .Caption   = THIS.Caption
147:             ENDWITH
148: 
149:             .AddObject("lbl_4c_Titulo", "Label")
150:             WITH .lbl_4c_Titulo
151:                 .Top       = 17
152:                 .Left      = 10
153:                 .Width     = THIS.Width
154:                 .Height    = 46
155:                 .AutoSize  = .F.
156:                 .FontName  = "Tahoma"
157:                 .FontSize  = 18
158:                 .FontBold  = .T.
159:                 .BackStyle = 0
160:                 .ForeColor = RGB(255, 255, 255)
161:                 .Caption   = THIS.Caption
162:             ENDWITH
163:         ENDWITH
164:     ENDPROC
165: 
166:     *==========================================================================
167:     PROTECTED PROCEDURE ConfigurarBotoes()
168:     *==========================================================================
169:         *-- CommandGroup: Processar / Atualizar / Encerrar
170:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
171:         WITH THIS.cmg_4c_Botoes
172:             .ButtonCount   = 3
173:             .BackStyle     = 0
174:             .BorderStyle   = 0
175:             .SpecialEffect = 1
176:             .Themes        = .F.
177:             .Top           = 0
178:             .Left          = 770
179:             .Width         = 235
180:             .Height        = 85
181: 
182:             WITH .Buttons(1)
183:                 .Top        = 5
184:                 .Left       = 5
185:                 .Width      = 75
186:                 .Height     = 75
187:                 .FontBold   = .T.
188:                 .FontItalic = .T.
189:                 .Caption    = "Processar"
190:                 .FontName        = "Comic Sans MS"
191:                 .FontSize        = 8
192:                 .WordWrap   = .T.
193:                 .ForeColor  = RGB(90, 90, 90)
194:                 .BackColor  = RGB(255, 255, 255)
195:                 .Themes     = .F.
196:                 .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
197:             ENDWITH
198: 
199:             WITH .Buttons(2)
200:                 .Top        = 5
201:                 .Left       = 80
202:                 .Width      = 75
203:                 .Height     = 75
204:                 .FontBold   = .T.
205:                 .FontItalic = .T.
206:                 .FontName   = "Comic Sans MS"
207:                 .FontSize   = 8

*-- Linhas 282 a 325:
282:     ENDPROC
283: 
284:     *==========================================================================
285:     PROTECTED PROCEDURE ConfigurarFiltros()
286:     *==========================================================================
287:         *-- Label secao Filtros
288:         THIS.AddObject("lbl_4c_SecFiltros", "Label")
289:         WITH THIS.lbl_4c_SecFiltros
290:             .Top       = 94
291:             .Left      = 11
292:             .Width     = 53
293:             .Height    = 21
294:             .AutoSize  = .T.
295:             .FontName  = "Tahoma"
296:             .FontSize  = 12
297:             .FontBold  = .T.
298:             .BackStyle = 0
299:             .Caption   = "Filtros"
300:             .ForeColor = RGB(90, 90, 90)
301:         ENDWITH
302: 
303:         *-- Linha separadora abaixo dos filtros
304:         THIS.AddObject("lne_4c_Sep", "Line")
305:         WITH THIS.lne_4c_Sep
306:             .Top    = 258
307:             .Left   = 13
308:             .Height = 0
309:             .Width  = 738
310:         ENDWITH
311: 
312:         *-- Fornecedor
313:         THIS.AddObject("lbl_4c_Fornecedor", "Label")
314:         WITH THIS.lbl_4c_Fornecedor
315:             .Top       = 92
316:             .Left      = 79
317:             .Width     = 64
318:             .Height    = 15
319:             .AutoSize  = .T.
320:             .FontName  = "Tahoma"
321:             .FontSize  = 8
322:             .BackStyle = 0
323:             .Caption   = "Fornecedor :"
324:             .ForeColor = RGB(90, 90, 90)
325:         ENDWITH

*-- Linhas 823 a 866:
823:         ENDWITH
824: 
825:         *-- Tipo Moeda (centro)
826:         THIS.AddObject("opt_4c_TipoMoeda", "OptionGroup")
827:         WITH THIS.opt_4c_TipoMoeda
828:             .Top         = 211
829:             .Left        = 234
830:             .Width       = 106
831:             .Height      = 26
832:             .ButtonCount = 2
833:             .BackStyle   = 0
834:             .BorderStyle = 0
835:             .Value       = 1
836: 
837:             WITH .Buttons(1)
838:                 .Caption  = "Ideal"
839:                 .FontName        = "Comic Sans MS"
840:                 .FontSize        = 8
841:                 .Left     = 5
842:                 .Top      = 5
843:                 .AutoSize = .T.
844:                 .Themes   = .F.
845:             ENDWITH
846:             WITH .Buttons(2)
847:                 .Caption  = "Venda"
848:                 .FontName        = "Comic Sans MS"
849:                 .Left     = 53
850:                 .Top      = 6
851:                 .AutoSize = .T.
852:                 .FontSize = 8
853:                 .Themes   = .F.
854:             ENDWITH
855:         ENDWITH
856: 
857:         *-- Moeda (esquerda)
858:         THIS.AddObject("lbl_4c_Moeda", "Label")
859:         WITH THIS.lbl_4c_Moeda
860:             .Top       = 217
861:             .Left      = 102
862:             .Width     = 41
863:             .Height    = 15
864:             .FontName  = "Tahoma"
865:             .FontSize  = 8
866:             .BackStyle = 0

*-- Linhas 918 a 961:
918:             .ForeColor = RGB(90, 90, 90)
919:         ENDWITH
920: 
921:         THIS.AddObject("opt_4c_Situacao", "OptionGroup")
922:         WITH THIS.opt_4c_Situacao
923:             .Top         = 214
924:             .Left        = 536
925:             .Width       = 189
926:             .Height      = 21
927:             .ButtonCount = 3
928:             .BackStyle   = 0
929:             .BorderStyle = 0
930:             .Value       = 1
931: 
932:             WITH .Buttons(1)
933:                 .Caption       = "Ativos"
934:                 .FontName        = "Comic Sans MS"
935:                 .FontSize        = 8
936:                 .Left          = 5
937:                 .Top           = 3
938:                 .AutoSize      = .T.
939:                 .SpecialEffect = 0
940:                 .Themes        = .F.
941:             ENDWITH
942:             WITH .Buttons(2)
943:                 .Caption       = "Inativos"
944:                 .FontName        = "Comic Sans MS"
945:                 .FontSize        = 8
946:                 .Left          = 59
947:                 .Top           = 2
948:                 .AutoSize      = .F.
949:                 .SpecialEffect = 0
950:                 .Themes        = .F.
951:             ENDWITH
952:             WITH .Buttons(3)
953:                 .Caption       = "Todos"
954:                 .WordWrap        = .T.
955:                 .FontName        = "Comic Sans MS"
956:                 .FontSize        = 8
957:                 .Left          = 125
958:                 .Top           = 2
959:                 .Width         = 61
960:                 .Height        = 17
961:                 .AutoSize      = .F.

*-- Linhas 977 a 1096:
977:             .ForeColor = RGB(90, 90, 90)
978:         ENDWITH
979: 
980:         THIS.AddObject("opt_4c_Compra", "OptionGroup")
981:         WITH THIS.opt_4c_Compra
982:             .Top         = 234
983:             .Left        = 536
984:             .Width       = 204
985:             .Height      = 21
986:             .ButtonCount = 3
987:             .BackStyle   = 0
988:             .BorderStyle = 0
989:             .Value       = 3
990: 
991:             WITH .Buttons(1)
992:                 .Caption  = "Comprar"
993:                 .FontName        = "Comic Sans MS"
994:                 .FontSize        = 8
995:                 .Left     = 5
996:                 .Top      = 3
997:                 .AutoSize = .T.
998:                 .Themes   = .F.
999:             ENDWITH
1000:             WITH .Buttons(2)
1001:                 .Caption  = "N" + CHR(227) + "o Comprar"
1002:                 .FontName        = "Comic Sans MS"
1003:                 .FontSize        = 8
1004:                 .Left     = 67
1005:                 .Top      = 3
1006:                 .AutoSize = .T.
1007:                 .Themes   = .F.
1008:             ENDWITH
1009:             WITH .Buttons(3)
1010:                 .Caption   = "Todos"
1011:                 .WordWrap        = .T.
1012:                 .FontName        = "Comic Sans MS"
1013:                 .FontSize        = 8
1014:                 .Left      = 152
1015:                 .Top       = 2
1016:                 .Width     = 61
1017:                 .Height    = 17
1018:                 .AutoSize  = .F.
1019:                 .ForeColor = RGB(90, 90, 90)
1020:                 .Themes    = .F.
1021:             ENDWITH
1022:         ENDWITH
1023:     ENDPROC
1024: 
1025:     *==========================================================================
1026:     PROTECTED PROCEDURE ConfigurarDados()
1027:     *==========================================================================
1028:         *-- Label secao Dados
1029:         THIS.AddObject("lbl_4c_SecDados", "Label")
1030:         WITH THIS.lbl_4c_SecDados
1031:             .Top       = 270
1032:             .Left      = 12
1033:             .Width     = 52
1034:             .Height    = 21
1035:             .AutoSize  = .T.
1036:             .FontName  = "Tahoma"
1037:             .FontSize  = 12
1038:             .FontBold  = .T.
1039:             .BackStyle = 0
1040:             .Caption   = "Dados"
1041:             .ForeColor = RGB(90, 90, 90)
1042:         ENDWITH
1043: 
1044:         *-- Recalcula (8 opcoes em 2 linhas)
1045:         THIS.AddObject("lbl_4c_Recalcula", "Label")
1046:         WITH THIS.lbl_4c_Recalcula
1047:             .Top       = 263
1048:             .Left      = 89
1049:             .FontName  = "Tahoma"
1050:             .FontSize  = 8
1051:             .BackStyle = 0
1052:             .Caption   = "Recalcula :"
1053:             .ForeColor = RGB(90, 90, 90)
1054:         ENDWITH
1055: 
1056:         THIS.AddObject("opt_4c_Recalc", "OptionGroup")
1057:         WITH THIS.opt_4c_Recalc
1058:             .Top         = 258
1059:             .Left        = 142
1060:             .Width       = 439
1061:             .Height      = 41
1062:             .ButtonCount = 8
1063:             .BackStyle   = 0
1064:             .BorderStyle = 0
1065:             .Value       = 1
1066: 
1067:             WITH .Buttons(1)
1068:                 .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
1069:                 .FontName        = "Comic Sans MS"
1070:                 .FontSize        = 8
1071:                 .Left      = 5
1072:                 .Top       = 5
1073:                 .AutoSize  = .T.
1074:                 .ForeColor = RGB(90, 90, 90)
1075:                 .Themes    = .F.
1076:             ENDWITH
1077:             WITH .Buttons(2)
1078:                 .Caption   = "Custo Venda"
1079:                 .Left      = 98
1080:                 .Top       = 5
1081:                 .AutoSize  = .T.
1082:                 .FontName  = "Comic Sans MS"
1083:                 .FontSize  = 8
1084:                 .ForeColor = RGB(90, 90, 90)
1085:                 .Themes    = .F.
1086:             ENDWITH
1087:             WITH .Buttons(3)
1088:                 .Caption   = "Ambos"
1089:                 .WordWrap        = .T.
1090:                 .Left      = 213
1091:                 .Top       = 5
1092:                 .Width     = 50
1093:                 .Height    = 15
1094:                 .AutoSize  = .T.
1095:                 .FontName  = "Comic Sans MS"
1096:                 .FontSize  = 8

*-- Linhas 1240 a 1283:
1240:             .ForeColor = RGB(90, 90, 90)
1241:         ENDWITH
1242: 
1243:         THIS.AddObject("opt_4c_Pven", "OptionGroup")
1244:         WITH THIS.opt_4c_Pven
1245:             .Top         = 298
1246:             .Left        = 544
1247:             .Width       = 102
1248:             .Height      = 27
1249:             .ButtonCount = 2
1250:             .BackStyle   = 0
1251:             .BorderStyle = 0
1252:             .AutoSize    = .F.
1253:             .Value       = 2
1254: 
1255:             WITH .Buttons(1)
1256:                 .Caption  = "Sim"
1257:                 .FontName        = "Comic Sans MS"
1258:                 .FontSize        = 8
1259:                 .Left     = 5
1260:                 .Top      = 5
1261:                 .AutoSize = .T.
1262:                 .Themes   = .F.
1263:             ENDWITH
1264:             WITH .Buttons(2)
1265:                 .Caption  = "N" + CHR(227) + "o"
1266:                 .FontName        = "Comic Sans MS"
1267:                 .FontSize        = 8
1268:                 .Left     = 53
1269:                 .Top      = 5
1270:                 .Width    = 44
1271:                 .Height   = 17
1272:                 .AutoSize = .F.
1273:                 .Themes   = .F.
1274:             ENDWITH
1275:         ENDWITH
1276: 
1277:         *-- Novo Markup
1278:         THIS.AddObject("lbl_4c_NovoMarkup", "Label")
1279:         WITH THIS.lbl_4c_NovoMarkup
1280:             .Top       = 330
1281:             .Left      = 71
1282:             .Width     = 72
1283:             .Height    = 15

*-- Linhas 1343 a 1386:
1343:     ENDPROC
1344: 
1345:     *==========================================================================
1346:     PROTECTED PROCEDURE ConfigurarGrade()
1347:     *==========================================================================
1348:         THIS.AddObject("grd_4c_Produto", "Grid")
1349:         WITH THIS.grd_4c_Produto
1350:             .Top          = 351
1351:             .Left         = 12
1352:             .Width        = 935
1353:             .Height       = 244
1354:             .ColumnCount  = 9
1355:             .FontName     = "Tahoma"
1356:             .FontSize     = 8
1357:             .RowHeight    = 18
1358:             .ScrollBars   = 2
1359:             .RecordSource = "cursor_4c_Produtos"
1360:             .ReadOnly     = .F.
1361: 
1362:             *-- Column1: CheckBox lMarca
1363:             WITH .Column1
1364:                 .Width        = 17
1365:                 .HeaderHeight       = 0
1366:                 .Alignment    = 3
1367:                 .Movable      = .F.
1368:                 .Resizable    = .F.
1369:                 .Sparse       = .F.
1370:                 .FontName     = "Tahoma"
1371:                 .FontSize     = 8
1372:                 .AddObject("Check1", "CheckBox")
1373:                 .Check1.Caption = ""
1374:                 .Check1.Value   = 0
1375:                 .CurrentControl = "Check1"
1376:                 .ControlSource  = "cursor_4c_Produtos.lMarca"
1377:                 WITH .Header1
1378:                     .Caption   = ""
1379:                     .FontName  = "Tahoma"
1380:                     .FontSize  = 8
1381:                     .Alignment = 2
1382:                     .ForeColor = RGB(36, 84, 155)
1383:                 ENDWITH
1384:             ENDWITH
1385: 
1386:             *-- Column2: CPros

*-- Linhas 1529 a 3040:
1529:     ENDPROC
1530: 
1531:     *==========================================================================
1532:     PROTECTED PROCEDURE ReconfigurarGrade()
1533:     *==========================================================================
1534:         WITH THIS.grd_4c_Produto
1535:             .RecordSource          = "cursor_4c_Produtos"
1536:             .Column1.ControlSource = "cursor_4c_Produtos.lMarca"
1537:             .Column2.ControlSource = "cursor_4c_Produtos.CPros"
1538:             .Column3.ControlSource = "cursor_4c_Produtos.DPros"
1539:             .Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
1540:             .Column5.ControlSource = "cursor_4c_Produtos.ValAtu"
1541:             .Column6.ControlSource = "cursor_4c_Produtos.PVarias"
1542:             .Column7.ControlSource = "cursor_4c_Produtos.CustoAfs"
1543:             .Column8.ControlSource = "cursor_4c_Produtos.CustoFs"
1544:             .Column9.ControlSource = "cursor_4c_Produtos.CVarias"
1545:         ENDWITH
1546:     ENDPROC
1547: 
1548:     *==========================================================================
1549:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1550:     *==========================================================================
1551:         LOCAL loc_i, loc_oControl
1552:         FOR loc_i = 1 TO par_oContainer.ControlCount
1553:             loc_oControl = par_oContainer.Controls(loc_i)
1554:             IF UPPER(loc_oControl.Name) = "IMG_4C_PRODUTO"
1555:                 LOOP
1556:             ENDIF
1557:             loc_oControl.Visible = .T.
1558:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1559:                 THIS.TornarControlesVisiveis(loc_oControl)
1560:             ENDIF
1561:         ENDFOR
1562:     ENDPROC
1563: 
1564:     *==========================================================================
1565:     PROTECTED PROCEDURE FormParaBO()
1566:     *==========================================================================
1567:         WITH THIS.this_oBusinessObject
1568:             .this_cCFornecs    = ALLTRIM(THIS.txt_4c_CFornecs.Value)
1569:             .this_cMercI       = ALLTRIM(THIS.txt_4c_MercI.Value)
1570:             .this_cMercF       = ALLTRIM(THIS.txt_4c_MercF.Value)
1571:             .this_cCGrui       = ALLTRIM(THIS.txt_4c_CGrui.Value)
1572:             .this_cCGruf       = ALLTRIM(THIS.txt_4c_CGruf.Value)
1573:             .this_cSGruI       = ALLTRIM(THIS.txt_4c_SgruI.Value)
1574:             .this_cSGruF       = ALLTRIM(THIS.txt_4c_SgruF.Value)
1575:             .this_cCUniI       = ALLTRIM(THIS.txt_4c_CUnii.Value)
1576:             .this_cCUnif       = ALLTRIM(THIS.txt_4c_CUnif.Value)
1577:             .this_cLini        = ALLTRIM(THIS.txt_4c_Lini.Value)
1578:             .this_cLinf        = ALLTRIM(THIS.txt_4c_Linf.Value)
1579:             .this_cColi        = ALLTRIM(THIS.txt_4c_Coli.Value)
1580:             .this_cColf        = ALLTRIM(THIS.txt_4c_Colf.Value)
1581:             .this_cMoedai      = ALLTRIM(THIS.txt_4c_Moedai.Value)
1582:             .this_cMoedaf      = ALLTRIM(THIS.txt_4c_Moedaf.Value)
1583:             .this_nOpcMoedaTp  = THIS.opt_4c_TipoMoeda.Value
1584:             .this_nMrki        = THIS.txt_4c_Mrki.Value
1585:             .this_nMrkf        = THIS.txt_4c_Mrkf.Value
1586:             .this_nEnci        = THIS.txt_4c_EncI.Value
1587:             .this_nEncf        = THIS.txt_4c_EncF.Value
1588:             .this_nVariacao    = THIS.txt_4c_Variacao.Value
1589:             .this_cFeitio      = ALLTRIM(THIS.txt_4c_Feitio.Value)
1590:             .this_nOpcSituacao = THIS.opt_4c_Situacao.Value
1591:             .this_nOpcRecalc   = THIS.opt_4c_Recalc.Value
1592:             .this_nReajuste    = THIS.txt_4c_Reajuste.Value
1593:             .this_nEncargo     = THIS.txt_4c_Encargo.Value
1594:             .this_nNMrk        = THIS.txt_4c_NMrk.Value
1595:             .this_nOpcPven     = THIS.opt_4c_Pven.Value
1596:             .this_cNewMkp      = ALLTRIM(THIS.txt_4c_NewMkp.Value)
1597:             .this_nOpcCompra   = THIS.opt_4c_Compra.Value
1598:         ENDWITH
1599:     ENDPROC
1600: 
1601:     *==========================================================================
1602:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1603:     *==========================================================================
1604:         THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1605:         THIS.cmd_4c_Imprimir.Enabled          = .F.
1606:     ENDPROC
1607: 
1608:     *==========================================================================
1609:     * ConfigurarPaginaLista - Reseta form OPERACIONAL ao estado inicial
1610:     * Form OPERACIONAL de layout plano: mapeia "Pagina Lista" para
1611:     * "estado inicial de sele" + CHR(231) + CHR(227) + "o de filtros" (equivalente
1612:     * a limpar filtros, resetar op" + CHR(231) + CHR(245) + "es, zerar grid de
1613:     * produtos e devolver o foco para o primeiro campo de filtro).
1614:     *==========================================================================
1615:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1616:         LOCAL loc_oErro
1617:         TRY
1618:             *-- Zera cursor de produtos (grid principal)
1619:             IF USED("cursor_4c_Produtos")
1620:                 SELECT cursor_4c_Produtos
1621:                 ZAP
1622:             ENDIF
1623: 
1624:             *-- Limpa filtros (textboxes de sele" + CHR(231) + CHR(227) + "o)
1625:             THIS.txt_4c_CFornecs.Value = ""
1626:             THIS.txt_4c_DFornecs.Value = ""
1627:             THIS.txt_4c_MercI.Value    = ""
1628:             THIS.txt_4c_MercF.Value    = ""
1629:             THIS.txt_4c_CGrui.Value    = ""
1630:             THIS.txt_4c_CGruf.Value    = ""
1631:             THIS.txt_4c_SgruI.Value    = ""
1632:             THIS.txt_4c_SgruF.Value    = ""
1633:             THIS.txt_4c_CUnii.Value    = ""
1634:             THIS.txt_4c_CUnif.Value    = ""
1635:             THIS.txt_4c_Lini.Value     = ""
1636:             THIS.txt_4c_Linf.Value     = ""
1637:             THIS.txt_4c_Coli.Value     = ""
1638:             THIS.txt_4c_Colf.Value     = ""
1639:             THIS.txt_4c_Moedai.Value   = ""
1640:             THIS.txt_4c_Moedaf.Value   = ""
1641:             THIS.txt_4c_Mrki.Value     = 0
1642:             THIS.txt_4c_Mrkf.Value     = 0
1643:             THIS.txt_4c_EncI.Value     = 0
1644:             THIS.txt_4c_EncF.Value     = 0
1645: 
1646:             *-- Reseta campos de recalculo
1647:             THIS.txt_4c_Reajuste.Value = 0
1648:             THIS.txt_4c_NMrk.Value     = 0
1649:             THIS.txt_4c_Variacao.Value = 0
1650:             THIS.txt_4c_NewMkp.Value   = ""
1651:             THIS.txt_4c_Feitio.Value   = ""
1652:             THIS.txt_4c_Encargo.Value  = 0
1653: 
1654:             *-- Reseta OptionGroups aos valores default
1655:             THIS.opt_4c_Recalc.Value   = 1
1656:             THIS.opt_4c_Pven.Value     = 2
1657:             THIS.opt_4c_Compra.Value   = 3
1658:             THIS.opt_4c_Situacao.Value = 1
1659: 
1660:             *-- Oculta imagem de produto (aparece apenas ao selecionar linha)
1661:             THIS.img_4c_Produto.Visible = .F.
1662:             THIS.img_4c_Produto.Picture = ""
1663: 
1664:             *-- Reseta estado dos botoes (Processar habilitado, Atualizar/Imprimir desabilitados)
1665:             THIS.AjustarBotoesPorModo()
1666: 
1667:             *-- Recalcula habilitacao condicional (Reajuste/NMrk/Variacao/NewMkp)
1668:             THIS.OptRecalcChange()
1669: 
1670:             *-- Foco inicial no primeiro filtro
1671:             THIS.txt_4c_CFornecs.SetFocus()
1672:             THIS.Refresh()
1673:         CATCH TO loc_oErro
1674:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1675:                     "Erro ConfigurarPaginaLista")
1676:         ENDTRY
1677:     ENDPROC
1678: 
1679:     *==========================================================================
1680:     * AlternarPagina - Alterna o "modo de trabalho" do form OPERACIONAL
1681:     * Form OPERACIONAL de layout plano: n" + CHR(227) + "o h" + CHR(225) + ;
1682:     * " PageFrame; este metodo mapeia "alternar pagina" para "alternar contexto".
1683:     *   par_nPagina = 1 -> LISTA/FILTROS (foco no primeiro filtro, reseta form)
1684:     *   par_nPagina = 2 -> DADOS/GRID    (foco no grid de produtos apos processar)
1685:     *   par_nPagina = 0 -> reset completo (equivale a ConfigurarPaginaLista)
1686:     *==========================================================================
1687:     PROCEDURE AlternarPagina(par_nPagina)
1688:         LOCAL loc_nPagina, loc_oErro
1689:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
1690: 
1691:         TRY
1692:             DO CASE
1693:                 CASE loc_nPagina = 1
1694:                     *-- Modo LISTA/FILTROS: foco no primeiro campo, botoes iniciais
1695:                     THIS.AjustarBotoesPorModo()
1696:                     THIS.txt_4c_CFornecs.SetFocus()
1697:                 CASE loc_nPagina = 2
1698:                     *-- Modo DADOS/GRID: foco no grid apos processamento
1699:                     IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
1700:                         SELECT cursor_4c_Produtos
1701:                         SET ORDER TO CPros
1702:                         GO TOP
1703:                         THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1704:                         THIS.cmd_4c_Imprimir.Enabled          = .T.
1705:                         THIS.grd_4c_Produto.SetFocus()
1706:                     ELSE
1707:                         MsgAviso("Nenhum produto para exibir. Execute o processamento primeiro.")
1708:                         THIS.txt_4c_CFornecs.SetFocus()
1709:                     ENDIF
1710:                 OTHERWISE
1711:                     THIS.ConfigurarPaginaLista()
1712:             ENDCASE
1713: 
1714:             THIS.Refresh()
1715:         CATCH TO loc_oErro
1716:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1717:                     "Erro AlternarPagina")
1718:         ENDTRY
1719:     ENDPROC
1720: 
1721:     *==========================================================================
1722:     PROCEDURE OptRecalcChange()
1723:     *==========================================================================
1724:         LOCAL loc_nOpcRec
1725:         loc_nOpcRec = THIS.opt_4c_Recalc.Value
1726:         THIS.txt_4c_Reajuste.Enabled = (loc_nOpcRec <> 2)
1727:         THIS.txt_4c_NMrk.Enabled     = (THIS.txt_4c_Reajuste.Value = 0) AND (loc_nOpcRec <> 2)
1728:         THIS.txt_4c_Variacao.Enabled = (THIS.txt_4c_Reajuste.Value = 0) AND (loc_nOpcRec <> 2)
1729:         THIS.txt_4c_NewMkp.Enabled   = INLIST(loc_nOpcRec, 7, 8)
1730:         THIS.txt_4c_Reajuste.Refresh()
1731:         THIS.txt_4c_NMrk.Refresh()
1732:         THIS.txt_4c_Variacao.Refresh()
1733:         THIS.txt_4c_NewMkp.Refresh()
1734:     ENDPROC
1735: 
1736:     *==========================================================================
1737:     * BtnIncluirClick - Inicia nova sessao de recalculo de precos
1738:     *   Semantica OPERACIONAL: equivale a "novo lote". Descarta resultado
1739:     *   anterior (cursor de produtos), reseta todos os filtros e opcoes ao
1740:     *   estado inicial e devolve o foco ao primeiro filtro (Fornecedor).
1741:     *==========================================================================
1742:     PROCEDURE BtnIncluirClick()
1743:         LOCAL loc_oErro
1744:         TRY
1745:             IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
1746:                 IF !MsgConfirma("Existem dados processados. Descartar e iniciar novo rec" + ;
1747:                                 CHR(225) + "lculo?", ;
1748:                                 "Confirma" + CHR(231) + CHR(227) + "o")
1749:                     RETURN
1750:                 ENDIF
1751:             ENDIF
1752: 
1753:             *-- Reset completo do form (limpa filtros, zera cursor, reseta UI)
1754:             THIS.ConfigurarPaginaLista()
1755:         CATCH TO loc_oErro
1756:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1757:                     "Erro BtnIncluirClick")
1758:         ENDTRY
1759:     ENDPROC
1760: 
1761:     *==========================================================================
1762:     * BtnAlterarClick - Executa recalculo de precos com filtros atuais
1763:     *   Semantica OPERACIONAL: equivale a "alterar" (aplicar novo calculo)
1764:     *   sobre os produtos que atendem aos filtros. Delega para o fluxo de
1765:     *   processamento (Processar do BO) para preencher o grid com os precos
1766:     *   propostos. A gravacao definitiva no banco ocorre em BtnAtualizarClick.
1767:     *==========================================================================
1768:     PROCEDURE BtnAlterarClick()
1769:         LOCAL loc_oErro
1770:         TRY
1771:             *-- Delega para o fluxo de processamento (mesma logica do botao Processar)
1772:             THIS.BtnProcessarClick()
1773:         CATCH TO loc_oErro
1774:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1775:                     "Erro BtnAlterarClick")
1776:         ENDTRY
1777:     ENDPROC
1778: 
1779:     *==========================================================================
1780:     * BtnVisualizarClick - Exibe detalhes/imagem do produto selecionado
1781:     *   Semantica OPERACIONAL: equivale a "consultar registro". Exige que ja
1782:     *   exista resultado processado no grid e uma linha selecionada; abre a
1783:     *   figura do produto via GrdAfterRowColChange (mesma logica do click do
1784:     *   ImgProduto no legado).
1785:     *==========================================================================
1786:     PROCEDURE BtnVisualizarClick()
1787:         LOCAL loc_oErro
1788:         TRY
1789:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
1790:                 MsgAviso("Nenhum produto processado. Execute o rec" + CHR(225) + ;
1791:                          "lculo antes de visualizar.", "Aviso")
1792:                 RETURN
1793:             ENDIF
1794: 
1795:             SELECT cursor_4c_Produtos
1796:             IF EOF() OR EMPTY(cursor_4c_Produtos.CPros)
1797:                 MsgAviso("Selecione um produto no grid para visualizar.", "Aviso")
1798:                 THIS.grd_4c_Produto.SetFocus()
1799:                 RETURN
1800:             ENDIF
1801: 
1802:             *-- Renderiza figura do produto corrente (mesma logica do AfterRowColChange)
1803:             THIS.GrdAfterRowColChange(1)
1804:             THIS.img_4c_Produto.Visible = .T.
1805:             THIS.img_4c_Produto.Refresh()
1806:         CATCH TO loc_oErro
1807:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1808:                     "Erro BtnVisualizarClick")
1809:         ENDTRY
1810:     ENDPROC
1811: 
1812:     *==========================================================================
1813:     * BtnExcluirClick - Remove produto(s) do resultado corrente do recalculo
1814:     *   Semantica OPERACIONAL: NAO exclui da tabela SigCdPro (fluxo de recalculo
1815:     *   nao altera cadastro). Remove do cursor de trabalho a(s) linha(s)
1816:     *   marcada(s) (lMarca = 1) ou apenas a linha corrente se nenhuma estiver
1817:     *   marcada. Assim o usuario refina o conjunto antes de gravar via Atualizar.
1818:     *==========================================================================
1819:     PROCEDURE BtnExcluirClick()
1820:         LOCAL loc_nMarcados, loc_cCodPro, loc_oErro
1821:         TRY
1822:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
1823:                 MsgAviso("Nenhum produto processado para remover.", "Aviso")
1824:                 RETURN
1825:             ENDIF
1826: 
1827:             SELECT cursor_4c_Produtos
1828:             COUNT FOR lMarca = 1 TO loc_nMarcados
1829: 
1830:             IF loc_nMarcados > 0
1831:                 IF !MsgConfirma("Remover " + TRANSFORM(loc_nMarcados) + ;
1832:                                 " produto(s) marcado(s) do rec" + CHR(225) + ;
1833:                                 "lculo?", ;
1834:                                 "Confirma" + CHR(231) + CHR(227) + "o")
1835:                     RETURN
1836:                 ENDIF
1837:                 SELECT cursor_4c_Produtos
1838:                 DELETE FOR lMarca = 1
1839:                 PACK
1840:             ELSE
1841:                 IF EOF() OR EMPTY(cursor_4c_Produtos.CPros)
1842:                     MsgAviso("Selecione um produto no grid ou marque na primeira coluna.", ;
1843:                              "Aviso")
1844:                     THIS.grd_4c_Produto.SetFocus()
1845:                     RETURN
1846:                 ENDIF
1847:                 loc_cCodPro = ALLTRIM(cursor_4c_Produtos.CPros)
1848:                 IF !MsgConfirma("Remover o produto " + loc_cCodPro + ;
1849:                                 " do rec" + CHR(225) + "lculo?", ;
1850:                                 "Confirma" + CHR(231) + CHR(227) + "o")
1851:                     RETURN
1852:                 ENDIF
1853:                 SELECT cursor_4c_Produtos
1854:                 DELETE
1855:                 PACK
1856:             ENDIF
1857: 
1858:             *-- Se cursor ficou vazio, desabilita Atualizar/Imprimir
1859:             IF RECCOUNT("cursor_4c_Produtos") = 0
1860:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1861:                 THIS.cmd_4c_Imprimir.Enabled          = .F.
1862:                 THIS.img_4c_Produto.Visible           = .F.
1863:                 THIS.img_4c_Produto.Picture           = ""
1864:             ENDIF
1865: 
1866:             THIS.grd_4c_Produto.Refresh()
1867:         CATCH TO loc_oErro
1868:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1869:                     "Erro BtnExcluirClick")
1870:         ENDTRY
1871:     ENDPROC
1872: 
1873:     *==========================================================================
1874:     PROCEDURE BtnProcessarClick()
1875:     *==========================================================================
1876:         LOCAL loc_lSucesso, loc_nVaria, loc_oErro
1877:         loc_lSucesso = .F.
1878:         TRY
1879:             IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
1880:                 IF !MsgConfirma("Existem Dados Gerados. Deseja Reprocessar?")
1881:                     RETURN
1882:                 ENDIF
1883:             ENDIF
1884:             ZAP IN cursor_4c_Produtos
1885: 
1886:             THIS.FormParaBO()
1887: 
1888:             IF THIS.this_oBusinessObject.Processar()
1889:                 loc_nVaria = THIS.txt_4c_Variacao.Value
1890:                 SELECT cursor_4c_Produtos
1891:                 IF loc_nVaria > 0
1892:                     DELETE FOR PVarias < loc_nVaria
1893:                 ENDIF
1894:                 IF loc_nVaria < 0
1895:                     DELETE FOR PVarias > loc_nVaria
1896:                 ENDIF
1897:                 SET ORDER TO CPros
1898:                 GO TOP
1899:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1900:                 THIS.cmg_4c_Botoes.Buttons(2).Refresh()
1901:                 THIS.cmd_4c_Imprimir.Enabled = .T.
1902:                 THIS.cmd_4c_Imprimir.Refresh()
1903:                 THIS.ReconfigurarGrade()
1904:                 THIS.grd_4c_Produto.Column1.SetFocus()
1905:                 THIS.grd_4c_Produto.Refresh()
1906:                 loc_lSucesso = .T.
1907:             ENDIF
1908:         CATCH TO loc_oErro
1909:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnProcessarClick")
1910:         ENDTRY
1911:         RETURN loc_lSucesso
1912:     ENDPROC
1913: 
1914:     *==========================================================================
1915:     PROCEDURE BtnAtualizarClick()
1916:     *==========================================================================
1917:         LOCAL loc_lImpEtiq, loc_oErro
1918:         TRY
1919:             loc_lImpEtiq = MsgConfirma("Confirma a Impress" + CHR(227) + "o das Etiquetas?")
1920:             IF THIS.this_oBusinessObject.AtualizarPrecos(loc_lImpEtiq)
1921:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1922:                 THIS.cmd_4c_Imprimir.Enabled = .F.
1923:                 THIS.grd_4c_Produto.Refresh()
1924:             ENDIF
1925:         CATCH TO loc_oErro
1926:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnAtualizarClick")
1927:         ENDTRY
1928:     ENDPROC
1929: 
1930:     *==========================================================================
1931:     PROCEDURE BtnEncerrarClick()
1932:     *==========================================================================
1933:         THIS.Release()
1934:     ENDPROC
1935: 
1936:     *==========================================================================
1937:     PROCEDURE BtnImprimirClick()
1938:     *==========================================================================
1939:         LOCAL loc_oForm, loc_oErro
1940:         TRY
1941:             loc_oForm = CREATEOBJECT("FormSIGPRCCR")
1942:             IF VARTYPE(loc_oForm) = "O"
1943:                 loc_oForm.Show()
1944:             ELSE
1945:                 MsgErro("Erro ao abrir impress" + CHR(227) + "o de pre" + CHR(231) + "os." + ;
1946:                     CHR(13) + "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
1947:             ENDIF
1948:         CATCH TO loc_oErro
1949:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnImprimirClick")
1950:         ENDTRY
1951:     ENDPROC
1952: 
1953:     *==========================================================================
1954:     PROCEDURE BtnSelTudoClick()
1955:     *==========================================================================
1956:         LOCAL loc_oErro
1957:         TRY
1958:             UPDATE cursor_4c_Produtos SET lMarca = 1
1959:             THIS.grd_4c_Produto.Refresh()
1960:         CATCH TO loc_oErro
1961:             MsgErro(loc_oErro.Message, "Erro BtnSelTudoClick")
1962:         ENDTRY
1963:     ENDPROC
1964: 
1965:     *==========================================================================
1966:     PROCEDURE BtnDesmarcarClick()
1967:     *==========================================================================
1968:         LOCAL loc_oErro
1969:         TRY
1970:             UPDATE cursor_4c_Produtos SET lMarca = 0
1971:             THIS.grd_4c_Produto.Refresh()
1972:         CATCH TO loc_oErro
1973:             MsgErro(loc_oErro.Message, "Erro BtnDesmarcarClick")
1974:         ENDTRY
1975:     ENDPROC
1976: 
1977:     *==========================================================================
1978:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1979:     *==========================================================================
1980:         LOCAL loc_cArquivo, loc_cCodPro, loc_cSQL, loc_cFoto, loc_oErro
1981:         TRY
1982:             IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
1983:                 RETURN
1984:             ENDIF
1985:             loc_cArquivo = SYS(2023) + "\TempCj.jpg"
1986:             SELECT cursor_4c_Produtos
1987:             loc_cCodPro = ALLTRIM(cursor_4c_Produtos.CPros)
1988:             loc_cSQL    = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cCodPro)
1989:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFig") < 1
1990:                 THIS.img_4c_Produto.Visible = .F.
1991:                 RETURN
1992:             ENDIF
1993:             SELECT cursor_4c_TmpFig
1994:             THIS.img_4c_Produto.Visible  = .F.
1995:             THIS.img_4c_Produto.Picture  = ""
1996:             IF !ISNULL(cursor_4c_TmpFig.FigJpgs) AND !EMPTY(cursor_4c_TmpFig.FigJpgs)
1997:                 loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_TmpFig.FigJpgs, ;
1998:                     "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
1999:                     "data:image/jpg;base64,", ""), 14)
2000:                 STRTOFILE(loc_cFoto, loc_cArquivo)
2001:                 THIS.img_4c_Produto.Picture = loc_cArquivo
2002:                 THIS.img_4c_Produto.Visible = .T.
2003:             ENDIF
2004:             IF USED("cursor_4c_TmpFig")
2005:                 USE IN cursor_4c_TmpFig
2006:             ENDIF
2007:         CATCH TO loc_oErro
2008:             IF USED("cursor_4c_TmpFig")
2009:                 USE IN cursor_4c_TmpFig
2010:             ENDIF
2011:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro GrdAfterRowColChange")
2012:         ENDTRY
2013:     ENDPROC
2014: 
2015:     *-- ==== LOOKUP: Fornecedor ====
2016:     PROCEDURE TxtCFornecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2017:         LOCAL loc_cVal, loc_oErro
2018:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2019:             RETURN
2020:         ENDIF
2021:         TRY
2022:             loc_cVal = ALLTRIM(THIS.txt_4c_CFornecs.Value)
2023:             IF EMPTY(loc_cVal)
2024:                 THIS.txt_4c_DFornecs.Value = ""
2025:                 RETURN
2026:             ENDIF
2027:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
2028:                        EscaparSQL(loc_cVal), "cursor_4c_TmpFor") > 0
2029:                 SELECT cursor_4c_TmpFor
2030:                 IF !EOF("cursor_4c_TmpFor")
2031:                     THIS.txt_4c_CFornecs.Value = ALLTRIM(cursor_4c_TmpFor.IClis)
2032:                     THIS.txt_4c_DFornecs.Value = ALLTRIM(cursor_4c_TmpFor.RClis)
2033:                     USE IN cursor_4c_TmpFor
2034:                     RETURN
2035:                 ENDIF
2036:                 USE IN cursor_4c_TmpFor
2037:             ENDIF
2038:             THIS.AbrirBuscaFornecedor()
2039:         CATCH TO loc_oErro
2040:             IF USED("cursor_4c_TmpFor")
2041:                 USE IN cursor_4c_TmpFor
2042:             ENDIF
2043:             MsgErro(loc_oErro.Message, "Erro TxtCFornecKeyPress")
2044:         ENDTRY
2045:     ENDPROC
2046: 
2047:     PROTECTED PROCEDURE AbrirBuscaFornecedor()
2048:         LOCAL loc_cVal, loc_oForm, loc_oErro
2049:         TRY
2050:             loc_cVal  = ALLTRIM(THIS.txt_4c_CFornecs.Value)
2051:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2052:                 "SigCdCli", "cursor_4c_BuscaFor", "IClis", loc_cVal, "Fornecedores")
2053:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2054:                 RETURN
2055:             ENDIF
2056:             IF !loc_oForm.this_lSelecionou
2057:                 loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2058:                 loc_oForm.mAddColuna("RClis", "", "Nome")
2059:                 loc_oForm.Show()
2060:             ENDIF
2061:             IF loc_oForm.this_lSelecionou
2062:                 IF USED("cursor_4c_BuscaFor")
2063:                     THIS.txt_4c_CFornecs.Value = ALLTRIM(cursor_4c_BuscaFor.IClis)
2064:                     THIS.txt_4c_DFornecs.Value = ALLTRIM(cursor_4c_BuscaFor.RClis)
2065:                 ENDIF
2066:             ENDIF
2067:             IF USED("cursor_4c_BuscaFor")
2068:                 USE IN cursor_4c_BuscaFor
2069:             ENDIF
2070:             loc_oForm.Release()
2071:         CATCH TO loc_oErro
2072:             IF USED("cursor_4c_BuscaFor")
2073:                 USE IN cursor_4c_BuscaFor
2074:             ENDIF
2075:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaFornecedor")
2076:         ENDTRY
2077:     ENDPROC
2078: 
2079:     *-- ==== LOOKUP: Grande Grupo ====
2080:     PROCEDURE TxtMercIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2081:         LOCAL loc_oErro
2082:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2083:             RETURN
2084:         ENDIF
2085:         TRY
2086:             IF EMPTY(ALLTRIM(THIS.txt_4c_MercI.Value))
2087:                 RETURN
2088:             ENDIF
2089:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descs FROM SigCdGpr WHERE Codigos = " + ;
2090:                        EscaparSQL(ALLTRIM(THIS.txt_4c_MercI.Value)), "cursor_4c_TmpGGr") > 0
2091:                 SELECT cursor_4c_TmpGGr
2092:                 IF !EOF("cursor_4c_TmpGGr")
2093:                     THIS.txt_4c_MercI.Value = ALLTRIM(cursor_4c_TmpGGr.Codigos)
2094:                     USE IN cursor_4c_TmpGGr
2095:                     RETURN
2096:                 ENDIF
2097:                 USE IN cursor_4c_TmpGGr
2098:             ENDIF
2099:             THIS.AbrirBuscaGrandeGrupo(.T.)
2100:         CATCH TO loc_oErro
2101:             IF USED("cursor_4c_TmpGGr")
2102:                 USE IN cursor_4c_TmpGGr
2103:             ENDIF
2104:             MsgErro(loc_oErro.Message, "Erro TxtMercIKeyPress")
2105:         ENDTRY
2106:     ENDPROC
2107: 
2108:     PROCEDURE TxtMercFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2109:         LOCAL loc_oErro
2110:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2111:             RETURN
2112:         ENDIF
2113:         TRY
2114:             IF EMPTY(ALLTRIM(THIS.txt_4c_MercF.Value))
2115:                 RETURN
2116:             ENDIF
2117:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descs FROM SigCdGpr WHERE Codigos = " + ;
2118:                        EscaparSQL(ALLTRIM(THIS.txt_4c_MercF.Value)), "cursor_4c_TmpGGr") > 0
2119:                 SELECT cursor_4c_TmpGGr
2120:                 IF !EOF("cursor_4c_TmpGGr")
2121:                     THIS.txt_4c_MercF.Value = ALLTRIM(cursor_4c_TmpGGr.Codigos)
2122:                     USE IN cursor_4c_TmpGGr
2123:                     RETURN
2124:                 ENDIF
2125:                 USE IN cursor_4c_TmpGGr
2126:             ENDIF
2127:             THIS.AbrirBuscaGrandeGrupo(.F.)
2128:         CATCH TO loc_oErro
2129:             IF USED("cursor_4c_TmpGGr")
2130:                 USE IN cursor_4c_TmpGGr
2131:             ENDIF
2132:             MsgErro(loc_oErro.Message, "Erro TxtMercFKeyPress")
2133:         ENDTRY
2134:     ENDPROC
2135: 
2136:     PROTECTED PROCEDURE AbrirBuscaGrandeGrupo(par_lIni)
2137:         LOCAL loc_cVal, loc_oForm, loc_oErro
2138:         TRY
2139:             loc_cVal = ALLTRIM(IIF(par_lIni, THIS.txt_4c_MercI.Value, THIS.txt_4c_MercF.Value))
2140:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2141:                 "SigCdGpr", "cursor_4c_BuscaGGr", "Codigos", loc_cVal, "Grande Grupo")
2142:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2143:                 RETURN
2144:             ENDIF
2145:             IF !loc_oForm.this_lSelecionou
2146:                 loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2147:                 loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
2148:                 loc_oForm.Show()
2149:             ENDIF
2150:             IF loc_oForm.this_lSelecionou
2151:                 IF USED("cursor_4c_BuscaGGr")
2152:                     IF par_lIni
2153:                         THIS.txt_4c_MercI.Value = ALLTRIM(cursor_4c_BuscaGGr.Codigos)
2154:                     ELSE
2155:                         THIS.txt_4c_MercF.Value = ALLTRIM(cursor_4c_BuscaGGr.Codigos)
2156:                     ENDIF
2157:                 ENDIF
2158:             ENDIF
2159:             IF USED("cursor_4c_BuscaGGr")
2160:                 USE IN cursor_4c_BuscaGGr
2161:             ENDIF
2162:             loc_oForm.Release()
2163:         CATCH TO loc_oErro
2164:             IF USED("cursor_4c_BuscaGGr")
2165:                 USE IN cursor_4c_BuscaGGr
2166:             ENDIF
2167:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaGrandeGrupo")
2168:         ENDTRY
2169:     ENDPROC
2170: 
2171:     *-- ==== LOOKUP: Grupo ====
2172:     PROCEDURE TxtCGruiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2173:         LOCAL loc_oErro
2174:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2175:             RETURN
2176:         ENDIF
2177:         TRY
2178:             IF EMPTY(ALLTRIM(THIS.txt_4c_CGrui.Value))
2179:                 RETURN
2180:             ENDIF
2181:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
2182:                        EscaparSQL(ALLTRIM(THIS.txt_4c_CGrui.Value)), "cursor_4c_TmpGrp") > 0
2183:                 SELECT cursor_4c_TmpGrp
2184:                 IF !EOF("cursor_4c_TmpGrp")
2185:                     THIS.txt_4c_CGrui.Value = ALLTRIM(cursor_4c_TmpGrp.CGrus)
2186:                     USE IN cursor_4c_TmpGrp
2187:                     RETURN
2188:                 ENDIF
2189:                 USE IN cursor_4c_TmpGrp
2190:             ENDIF
2191:             THIS.AbrirBuscaGrupo(.T.)
2192:         CATCH TO loc_oErro
2193:             IF USED("cursor_4c_TmpGrp")
2194:                 USE IN cursor_4c_TmpGrp
2195:             ENDIF
2196:             MsgErro(loc_oErro.Message, "Erro TxtCGruiKeyPress")
2197:         ENDTRY
2198:     ENDPROC
2199: 
2200:     PROCEDURE TxtCGrufKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2201:         LOCAL loc_oErro
2202:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2203:             RETURN
2204:         ENDIF
2205:         TRY
2206:             IF EMPTY(ALLTRIM(THIS.txt_4c_CGruf.Value))
2207:                 RETURN
2208:             ENDIF
2209:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
2210:                        EscaparSQL(ALLTRIM(THIS.txt_4c_CGruf.Value)), "cursor_4c_TmpGrp") > 0
2211:                 SELECT cursor_4c_TmpGrp
2212:                 IF !EOF("cursor_4c_TmpGrp")
2213:                     THIS.txt_4c_CGruf.Value = ALLTRIM(cursor_4c_TmpGrp.CGrus)
2214:                     USE IN cursor_4c_TmpGrp
2215:                     RETURN
2216:                 ENDIF
2217:                 USE IN cursor_4c_TmpGrp
2218:             ENDIF
2219:             THIS.AbrirBuscaGrupo(.F.)
2220:         CATCH TO loc_oErro
2221:             IF USED("cursor_4c_TmpGrp")
2222:                 USE IN cursor_4c_TmpGrp
2223:             ENDIF
2224:             MsgErro(loc_oErro.Message, "Erro TxtCGrufKeyPress")
2225:         ENDTRY
2226:     ENDPROC
2227: 
2228:     PROTECTED PROCEDURE AbrirBuscaGrupo(par_lIni)
2229:         LOCAL loc_cVal, loc_oForm, loc_oErro
2230:         TRY
2231:             loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_CGrui.Value, THIS.txt_4c_CGruf.Value))
2232:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2233:                 "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cVal, "Grupos")
2234:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2235:                 RETURN
2236:             ENDIF
2237:             IF !loc_oForm.this_lSelecionou
2238:                 loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
2239:                 loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
2240:                 loc_oForm.Show()
2241:             ENDIF
2242:             IF loc_oForm.this_lSelecionou
2243:                 IF USED("cursor_4c_BuscaGrp")
2244:                     IF par_lIni
2245:                         THIS.txt_4c_CGrui.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
2246:                     ELSE
2247:                         THIS.txt_4c_CGruf.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
2248:                     ENDIF
2249:                 ENDIF
2250:             ENDIF
2251:             IF USED("cursor_4c_BuscaGrp")
2252:                 USE IN cursor_4c_BuscaGrp
2253:             ENDIF
2254:             loc_oForm.Release()
2255:         CATCH TO loc_oErro
2256:             IF USED("cursor_4c_BuscaGrp")
2257:                 USE IN cursor_4c_BuscaGrp
2258:             ENDIF
2259:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaGrupo")
2260:         ENDTRY
2261:     ENDPROC
2262: 
2263:     *-- ==== LOOKUP: Subgrupo ====
2264:     PROCEDURE TxtSgruIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2265:         LOCAL loc_oErro
2266:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2267:             RETURN
2268:         ENDIF
2269:         TRY
2270:             IF EMPTY(ALLTRIM(THIS.txt_4c_SgruI.Value))
2271:                 RETURN
2272:             ENDIF
2273:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + ;
2274:                        EscaparSQL(ALLTRIM(THIS.txt_4c_SgruI.Value)), "cursor_4c_TmpSgr") > 0
2275:                 SELECT cursor_4c_TmpSgr
2276:                 IF !EOF("cursor_4c_TmpSgr")
2277:                     THIS.txt_4c_SgruI.Value = ALLTRIM(cursor_4c_TmpSgr.Codigos)
2278:                     USE IN cursor_4c_TmpSgr
2279:                     RETURN
2280:                 ENDIF
2281:                 USE IN cursor_4c_TmpSgr
2282:             ENDIF
2283:             THIS.AbrirBuscaSubgrupo(.T.)
2284:         CATCH TO loc_oErro
2285:             IF USED("cursor_4c_TmpSgr")
2286:                 USE IN cursor_4c_TmpSgr
2287:             ENDIF
2288:             MsgErro(loc_oErro.Message, "Erro TxtSgruIKeyPress")
2289:         ENDTRY
2290:     ENDPROC
2291: 
2292:     PROCEDURE TxtSgruFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2293:         LOCAL loc_oErro
2294:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2295:             RETURN
2296:         ENDIF
2297:         TRY
2298:             IF EMPTY(ALLTRIM(THIS.txt_4c_SgruF.Value))
2299:                 RETURN
2300:             ENDIF
2301:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + ;
2302:                        EscaparSQL(ALLTRIM(THIS.txt_4c_SgruF.Value)), "cursor_4c_TmpSgr") > 0
2303:                 SELECT cursor_4c_TmpSgr
2304:                 IF !EOF("cursor_4c_TmpSgr")
2305:                     THIS.txt_4c_SgruF.Value = ALLTRIM(cursor_4c_TmpSgr.Codigos)
2306:                     USE IN cursor_4c_TmpSgr
2307:                     RETURN
2308:                 ENDIF
2309:                 USE IN cursor_4c_TmpSgr
2310:             ENDIF
2311:             THIS.AbrirBuscaSubgrupo(.F.)
2312:         CATCH TO loc_oErro
2313:             IF USED("cursor_4c_TmpSgr")
2314:                 USE IN cursor_4c_TmpSgr
2315:             ENDIF
2316:             MsgErro(loc_oErro.Message, "Erro TxtSgruFKeyPress")
2317:         ENDTRY
2318:     ENDPROC
2319: 
2320:     PROTECTED PROCEDURE AbrirBuscaSubgrupo(par_lIni)
2321:         LOCAL loc_cVal, loc_oForm, loc_oErro
2322:         TRY
2323:             loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_SgruI.Value, THIS.txt_4c_SgruF.Value))
2324:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2325:                 "SigCdPsg", "cursor_4c_BuscaSgr", "Codigos", loc_cVal, "Subgrupos")
2326:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2327:                 RETURN
2328:             ENDIF
2329:             IF !loc_oForm.this_lSelecionou
2330:                 loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
2331:                 loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2332:                 loc_oForm.Show()
2333:             ENDIF
2334:             IF loc_oForm.this_lSelecionou
2335:                 IF USED("cursor_4c_BuscaSgr")
2336:                     IF par_lIni
2337:                         THIS.txt_4c_SgruI.Value = ALLTRIM(cursor_4c_BuscaSgr.Codigos)
2338:                     ELSE
2339:                         THIS.txt_4c_SgruF.Value = ALLTRIM(cursor_4c_BuscaSgr.Codigos)
2340:                     ENDIF
2341:                 ENDIF
2342:             ENDIF
2343:             IF USED("cursor_4c_BuscaSgr")
2344:                 USE IN cursor_4c_BuscaSgr
2345:             ENDIF
2346:             loc_oForm.Release()
2347:         CATCH TO loc_oErro
2348:             IF USED("cursor_4c_BuscaSgr")
2349:                 USE IN cursor_4c_BuscaSgr
2350:             ENDIF
2351:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaSubgrupo")
2352:         ENDTRY
2353:     ENDPROC
2354: 
2355:     *-- ==== LOOKUP: Unidade ====
2356:     PROCEDURE TxtCUniiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2357:         LOCAL loc_oErro
2358:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2359:             RETURN
2360:         ENDIF
2361:         TRY
2362:             IF EMPTY(ALLTRIM(THIS.txt_4c_CUnii.Value))
2363:                 RETURN
2364:             ENDIF
2365:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CUnis, DUnis FROM SigCdUni WHERE CUnis = " + ;
2366:                        EscaparSQL(ALLTRIM(THIS.txt_4c_CUnii.Value)), "cursor_4c_TmpUni") > 0
2367:                 SELECT cursor_4c_TmpUni
2368:                 IF !EOF("cursor_4c_TmpUni")
2369:                     THIS.txt_4c_CUnii.Value = ALLTRIM(cursor_4c_TmpUni.CUnis)
2370:                     USE IN cursor_4c_TmpUni
2371:                     RETURN
2372:                 ENDIF
2373:                 USE IN cursor_4c_TmpUni
2374:             ENDIF
2375:             THIS.AbrirBuscaUnidade(.T.)
2376:         CATCH TO loc_oErro
2377:             IF USED("cursor_4c_TmpUni")
2378:                 USE IN cursor_4c_TmpUni
2379:             ENDIF
2380:             MsgErro(loc_oErro.Message, "Erro TxtCUniiKeyPress")
2381:         ENDTRY
2382:     ENDPROC
2383: 
2384:     PROCEDURE TxtCUnifKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2385:         LOCAL loc_oErro
2386:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2387:             RETURN
2388:         ENDIF
2389:         TRY
2390:             IF EMPTY(ALLTRIM(THIS.txt_4c_CUnif.Value))
2391:                 RETURN
2392:             ENDIF
2393:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CUnis, DUnis FROM SigCdUni WHERE CUnis = " + ;
2394:                        EscaparSQL(ALLTRIM(THIS.txt_4c_CUnif.Value)), "cursor_4c_TmpUni") > 0
2395:                 SELECT cursor_4c_TmpUni
2396:                 IF !EOF("cursor_4c_TmpUni")
2397:                     THIS.txt_4c_CUnif.Value = ALLTRIM(cursor_4c_TmpUni.CUnis)
2398:                     USE IN cursor_4c_TmpUni
2399:                     RETURN
2400:                 ENDIF
2401:                 USE IN cursor_4c_TmpUni
2402:             ENDIF
2403:             THIS.AbrirBuscaUnidade(.F.)
2404:         CATCH TO loc_oErro
2405:             IF USED("cursor_4c_TmpUni")
2406:                 USE IN cursor_4c_TmpUni
2407:             ENDIF
2408:             MsgErro(loc_oErro.Message, "Erro TxtCUnifKeyPress")
2409:         ENDTRY
2410:     ENDPROC
2411: 
2412:     PROTECTED PROCEDURE AbrirBuscaUnidade(par_lIni)
2413:         LOCAL loc_cVal, loc_oForm, loc_oErro
2414:         TRY
2415:             loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_CUnii.Value, THIS.txt_4c_CUnif.Value))
2416:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2417:                 "SigCdUni", "cursor_4c_BuscaUni", "CUnis", loc_cVal, "Unidades")
2418:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2419:                 RETURN
2420:             ENDIF
2421:             IF !loc_oForm.this_lSelecionou
2422:                 loc_oForm.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
2423:                 loc_oForm.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
2424:                 loc_oForm.Show()
2425:             ENDIF
2426:             IF loc_oForm.this_lSelecionou
2427:                 IF USED("cursor_4c_BuscaUni")
2428:                     IF par_lIni
2429:                         THIS.txt_4c_CUnii.Value = ALLTRIM(cursor_4c_BuscaUni.CUnis)
2430:                     ELSE
2431:                         THIS.txt_4c_CUnif.Value = ALLTRIM(cursor_4c_BuscaUni.CUnis)
2432:                     ENDIF
2433:                 ENDIF
2434:             ENDIF
2435:             IF USED("cursor_4c_BuscaUni")
2436:                 USE IN cursor_4c_BuscaUni
2437:             ENDIF
2438:             loc_oForm.Release()
2439:         CATCH TO loc_oErro
2440:             IF USED("cursor_4c_BuscaUni")
2441:                 USE IN cursor_4c_BuscaUni
2442:             ENDIF
2443:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaUnidade")
2444:         ENDTRY
2445:     ENDPROC
2446: 
2447:     *-- ==== LOOKUP: Linha ====
2448:     PROCEDURE TxtLiniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2449:         LOCAL loc_oErro
2450:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2451:             RETURN
2452:         ENDIF
2453:         TRY
2454:             IF EMPTY(ALLTRIM(THIS.txt_4c_Lini.Value))
2455:                 RETURN
2456:             ENDIF
2457:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
2458:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Lini.Value)), "cursor_4c_TmpLin") > 0
2459:                 SELECT cursor_4c_TmpLin
2460:                 IF !EOF("cursor_4c_TmpLin")
2461:                     THIS.txt_4c_Lini.Value = ALLTRIM(cursor_4c_TmpLin.Linhas)
2462:                     USE IN cursor_4c_TmpLin
2463:                     RETURN
2464:                 ENDIF
2465:                 USE IN cursor_4c_TmpLin
2466:             ENDIF
2467:             THIS.AbrirBuscaLinha(.T.)
2468:         CATCH TO loc_oErro
2469:             IF USED("cursor_4c_TmpLin")
2470:                 USE IN cursor_4c_TmpLin
2471:             ENDIF
2472:             MsgErro(loc_oErro.Message, "Erro TxtLiniKeyPress")
2473:         ENDTRY
2474:     ENDPROC
2475: 
2476:     PROCEDURE TxtLinfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2477:         LOCAL loc_oErro
2478:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2479:             RETURN
2480:         ENDIF
2481:         TRY
2482:             IF EMPTY(ALLTRIM(THIS.txt_4c_Linf.Value))
2483:                 RETURN
2484:             ENDIF
2485:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
2486:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Linf.Value)), "cursor_4c_TmpLin") > 0
2487:                 SELECT cursor_4c_TmpLin
2488:                 IF !EOF("cursor_4c_TmpLin")
2489:                     THIS.txt_4c_Linf.Value = ALLTRIM(cursor_4c_TmpLin.Linhas)
2490:                     USE IN cursor_4c_TmpLin
2491:                     RETURN
2492:                 ENDIF
2493:                 USE IN cursor_4c_TmpLin
2494:             ENDIF
2495:             THIS.AbrirBuscaLinha(.F.)
2496:         CATCH TO loc_oErro
2497:             IF USED("cursor_4c_TmpLin")
2498:                 USE IN cursor_4c_TmpLin
2499:             ENDIF
2500:             MsgErro(loc_oErro.Message, "Erro TxtLinfKeyPress")
2501:         ENDTRY
2502:     ENDPROC
2503: 
2504:     PROTECTED PROCEDURE AbrirBuscaLinha(par_lIni)
2505:         LOCAL loc_cVal, loc_oForm, loc_oErro
2506:         TRY
2507:             loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_Lini.Value, THIS.txt_4c_Linf.Value))
2508:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2509:                 "SigCdLin", "cursor_4c_BuscaLin", "Linhas", loc_cVal, "Linhas")
2510:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2511:                 RETURN
2512:             ENDIF
2513:             IF !loc_oForm.this_lSelecionou
2514:                 loc_oForm.mAddColuna("Linhas", "", "Linha")
2515:                 loc_oForm.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2516:                 loc_oForm.Show()
2517:             ENDIF
2518:             IF loc_oForm.this_lSelecionou
2519:                 IF USED("cursor_4c_BuscaLin")
2520:                     IF par_lIni
2521:                         THIS.txt_4c_Lini.Value = ALLTRIM(cursor_4c_BuscaLin.Linhas)
2522:                     ELSE
2523:                         THIS.txt_4c_Linf.Value = ALLTRIM(cursor_4c_BuscaLin.Linhas)
2524:                     ENDIF
2525:                 ENDIF
2526:             ENDIF
2527:             IF USED("cursor_4c_BuscaLin")
2528:                 USE IN cursor_4c_BuscaLin
2529:             ENDIF
2530:             loc_oForm.Release()
2531:         CATCH TO loc_oErro
2532:             IF USED("cursor_4c_BuscaLin")
2533:                 USE IN cursor_4c_BuscaLin
2534:             ENDIF
2535:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaLinha")
2536:         ENDTRY
2537:     ENDPROC
2538: 
2539:     *-- ==== LOOKUP: Colecao ====
2540:     PROCEDURE TxtColiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2541:         LOCAL loc_oErro
2542:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2543:             RETURN
2544:         ENDIF
2545:         TRY
2546:             IF EMPTY(ALLTRIM(THIS.txt_4c_Coli.Value))
2547:                 RETURN
2548:             ENDIF
2549:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
2550:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Coli.Value)), "cursor_4c_TmpCol") > 0
2551:                 SELECT cursor_4c_TmpCol
2552:                 IF !EOF("cursor_4c_TmpCol")
2553:                     THIS.txt_4c_Coli.Value = ALLTRIM(cursor_4c_TmpCol.Colecoes)
2554:                     USE IN cursor_4c_TmpCol
2555:                     RETURN
2556:                 ENDIF
2557:                 USE IN cursor_4c_TmpCol
2558:             ENDIF
2559:             THIS.AbrirBuscaColecao(.T.)
2560:         CATCH TO loc_oErro
2561:             IF USED("cursor_4c_TmpCol")
2562:                 USE IN cursor_4c_TmpCol
2563:             ENDIF
2564:             MsgErro(loc_oErro.Message, "Erro TxtColiKeyPress")
2565:         ENDTRY
2566:     ENDPROC
2567: 
2568:     PROCEDURE TxtColfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2569:         LOCAL loc_oErro
2570:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2571:             RETURN
2572:         ENDIF
2573:         TRY
2574:             IF EMPTY(ALLTRIM(THIS.txt_4c_Colf.Value))
2575:                 RETURN
2576:             ENDIF
2577:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
2578:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Colf.Value)), "cursor_4c_TmpCol") > 0
2579:                 SELECT cursor_4c_TmpCol
2580:                 IF !EOF("cursor_4c_TmpCol")
2581:                     THIS.txt_4c_Colf.Value = ALLTRIM(cursor_4c_TmpCol.Colecoes)
2582:                     USE IN cursor_4c_TmpCol
2583:                     RETURN
2584:                 ENDIF
2585:                 USE IN cursor_4c_TmpCol
2586:             ENDIF
2587:             THIS.AbrirBuscaColecao(.F.)
2588:         CATCH TO loc_oErro
2589:             IF USED("cursor_4c_TmpCol")
2590:                 USE IN cursor_4c_TmpCol
2591:             ENDIF
2592:             MsgErro(loc_oErro.Message, "Erro TxtColfKeyPress")
2593:         ENDTRY
2594:     ENDPROC
2595: 
2596:     PROTECTED PROCEDURE AbrirBuscaColecao(par_lIni)
2597:         LOCAL loc_cVal, loc_oForm, loc_oErro
2598:         TRY
2599:             loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_Coli.Value, THIS.txt_4c_Colf.Value))
2600:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2601:                 "SigCdCol", "cursor_4c_BuscaCol", "Colecoes", loc_cVal, "Cole" + CHR(231) + CHR(245) + "es")
2602:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2603:                 RETURN
2604:             ENDIF
2605:             IF !loc_oForm.this_lSelecionou
2606:                 loc_oForm.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
2607:                 loc_oForm.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
2608:                 loc_oForm.Show()
2609:             ENDIF
2610:             IF loc_oForm.this_lSelecionou
2611:                 IF USED("cursor_4c_BuscaCol")
2612:                     IF par_lIni
2613:                         THIS.txt_4c_Coli.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
2614:                     ELSE
2615:                         THIS.txt_4c_Colf.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
2616:                     ENDIF
2617:                 ENDIF
2618:             ENDIF
2619:             IF USED("cursor_4c_BuscaCol")
2620:                 USE IN cursor_4c_BuscaCol
2621:             ENDIF
2622:             loc_oForm.Release()
2623:         CATCH TO loc_oErro
2624:             IF USED("cursor_4c_BuscaCol")
2625:                 USE IN cursor_4c_BuscaCol
2626:             ENDIF
2627:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaColecao")
2628:         ENDTRY
2629:     ENDPROC
2630: 
2631:     *-- ==== LOOKUP: Moeda ====
2632:     PROCEDURE TxtMoedaiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2633:         LOCAL loc_oErro
2634:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2635:             RETURN
2636:         ENDIF
2637:         TRY
2638:             IF EMPTY(ALLTRIM(THIS.txt_4c_Moedai.Value))
2639:                 RETURN
2640:             ENDIF
2641:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
2642:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Moedai.Value)), "cursor_4c_TmpMoe") > 0
2643:                 SELECT cursor_4c_TmpMoe
2644:                 IF !EOF("cursor_4c_TmpMoe")
2645:                     THIS.txt_4c_Moedai.Value = ALLTRIM(cursor_4c_TmpMoe.CMoes)
2646:                     USE IN cursor_4c_TmpMoe
2647:                     RETURN
2648:                 ENDIF
2649:                 USE IN cursor_4c_TmpMoe
2650:             ENDIF
2651:             THIS.AbrirBuscaMoeda(.T.)
2652:         CATCH TO loc_oErro
2653:             IF USED("cursor_4c_TmpMoe")
2654:                 USE IN cursor_4c_TmpMoe
2655:             ENDIF
2656:             MsgErro(loc_oErro.Message, "Erro TxtMoedaiKeyPress")
2657:         ENDTRY
2658:     ENDPROC
2659: 
2660:     PROCEDURE TxtMoedafKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2661:         LOCAL loc_oErro
2662:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2663:             RETURN
2664:         ENDIF
2665:         TRY
2666:             IF EMPTY(ALLTRIM(THIS.txt_4c_Moedaf.Value))
2667:                 RETURN
2668:             ENDIF
2669:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
2670:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Moedaf.Value)), "cursor_4c_TmpMoe") > 0
2671:                 SELECT cursor_4c_TmpMoe
2672:                 IF !EOF("cursor_4c_TmpMoe")
2673:                     THIS.txt_4c_Moedaf.Value = ALLTRIM(cursor_4c_TmpMoe.CMoes)
2674:                     USE IN cursor_4c_TmpMoe
2675:                     RETURN
2676:                 ENDIF
2677:                 USE IN cursor_4c_TmpMoe
2678:             ENDIF
2679:             THIS.AbrirBuscaMoeda(.F.)
2680:         CATCH TO loc_oErro
2681:             IF USED("cursor_4c_TmpMoe")
2682:                 USE IN cursor_4c_TmpMoe
2683:             ENDIF
2684:             MsgErro(loc_oErro.Message, "Erro TxtMoedafKeyPress")
2685:         ENDTRY
2686:     ENDPROC
2687: 
2688:     PROTECTED PROCEDURE AbrirBuscaMoeda(par_lIni)
2689:         LOCAL loc_cVal, loc_oForm, loc_oErro
2690:         TRY
2691:             loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_Moedai.Value, THIS.txt_4c_Moedaf.Value))
2692:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2693:                 "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cVal, "Moedas")
2694:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2695:                 RETURN
2696:             ENDIF
2697:             IF !loc_oForm.this_lSelecionou
2698:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2699:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2700:                 loc_oForm.Show()
2701:             ENDIF
2702:             IF loc_oForm.this_lSelecionou
2703:                 IF USED("cursor_4c_BuscaMoe")
2704:                     IF par_lIni
2705:                         THIS.txt_4c_Moedai.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2706:                     ELSE
2707:                         THIS.txt_4c_Moedaf.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2708:                     ENDIF
2709:                 ENDIF
2710:             ENDIF
2711:             IF USED("cursor_4c_BuscaMoe")
2712:                 USE IN cursor_4c_BuscaMoe
2713:             ENDIF
2714:             loc_oForm.Release()
2715:         CATCH TO loc_oErro
2716:             IF USED("cursor_4c_BuscaMoe")
2717:                 USE IN cursor_4c_BuscaMoe
2718:             ENDIF
2719:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaMoeda")
2720:         ENDTRY
2721:     ENDPROC
2722: 
2723:     *-- ==== LOOKUP: Feitio (Codigo MKP) ====
2724:     PROCEDURE TxtFeitioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2725:         LOCAL loc_oErro
2726:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2727:             RETURN
2728:         ENDIF
2729:         TRY
2730:             IF EMPTY(ALLTRIM(THIS.txt_4c_Feitio.Value))
2731:                 RETURN
2732:             ENDIF
2733:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
2734:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Feitio.Value)), "cursor_4c_TmpFti") > 0
2735:                 SELECT cursor_4c_TmpFti
2736:                 IF !EOF("cursor_4c_TmpFti")
2737:                     THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_TmpFti.Cods)
2738:                     USE IN cursor_4c_TmpFti
2739:                     RETURN
2740:                 ENDIF
2741:                 USE IN cursor_4c_TmpFti
2742:             ENDIF
2743:             THIS.AbrirBuscaFeitio()
2744:         CATCH TO loc_oErro
2745:             IF USED("cursor_4c_TmpFti")
2746:                 USE IN cursor_4c_TmpFti
2747:             ENDIF
2748:             MsgErro(loc_oErro.Message, "Erro TxtFeitioKeyPress")
2749:         ENDTRY
2750:     ENDPROC
2751: 
2752:     PROTECTED PROCEDURE AbrirBuscaFeitio()
2753:         LOCAL loc_cVal, loc_oForm, loc_oErro
2754:         TRY
2755:             loc_cVal  = ALLTRIM(THIS.txt_4c_Feitio.Value)
2756:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2757:                 "SigPrFti", "cursor_4c_BuscaFti", "Cods", loc_cVal, "Feitios")
2758:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2759:                 RETURN
2760:             ENDIF
2761:             IF !loc_oForm.this_lSelecionou
2762:                 loc_oForm.mAddColuna("Cods",  "", "Cod")
2763:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2764:                 loc_oForm.Show()
2765:             ENDIF
2766:             IF loc_oForm.this_lSelecionou
2767:                 IF USED("cursor_4c_BuscaFti")
2768:                     THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_BuscaFti.Cods)
2769:                 ENDIF
2770:             ENDIF
2771:             IF USED("cursor_4c_BuscaFti")
2772:                 USE IN cursor_4c_BuscaFti
2773:             ENDIF
2774:             loc_oForm.Release()
2775:         CATCH TO loc_oErro
2776:             IF USED("cursor_4c_BuscaFti")
2777:                 USE IN cursor_4c_BuscaFti
2778:             ENDIF
2779:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaFeitio")
2780:         ENDTRY
2781:     ENDPROC
2782: 
2783:     *-- ==== LOOKUP: Novo MKP ====
2784:     PROCEDURE TxtNewMkpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2785:         LOCAL loc_oErro
2786:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2787:             RETURN
2788:         ENDIF
2789:         TRY
2790:             IF EMPTY(ALLTRIM(THIS.txt_4c_NewMkp.Value))
2791:                 RETURN
2792:             ENDIF
2793:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
2794:                        EscaparSQL(ALLTRIM(THIS.txt_4c_NewMkp.Value)) + " AND Tipos = 1", "cursor_4c_TmpNMkp") > 0
2795:                 SELECT cursor_4c_TmpNMkp
2796:                 IF !EOF("cursor_4c_TmpNMkp")
2797:                     THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_TmpNMkp.Cods)
2798:                     USE IN cursor_4c_TmpNMkp
2799:                     RETURN
2800:                 ENDIF
2801:                 USE IN cursor_4c_TmpNMkp
2802:             ENDIF
2803:             THIS.AbrirBuscaNewMkp()
2804:         CATCH TO loc_oErro
2805:             IF USED("cursor_4c_TmpNMkp")
2806:                 USE IN cursor_4c_TmpNMkp
2807:             ENDIF
2808:             MsgErro(loc_oErro.Message, "Erro TxtNewMkpKeyPress")
2809:         ENDTRY
2810:     ENDPROC
2811: 
2812:     PROTECTED PROCEDURE AbrirBuscaNewMkp()
2813:         LOCAL loc_cVal, loc_oForm, loc_oErro
2814:         TRY
2815:             loc_cVal  = ALLTRIM(THIS.txt_4c_NewMkp.Value)
2816:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2817:                 "SigPrFti WHERE Tipos = 1", "cursor_4c_BuscaNMkp", "Cods", loc_cVal, "Novo MKP")
2818:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2819:                 RETURN
2820:             ENDIF
2821:             IF !loc_oForm.this_lSelecionou
2822:                 loc_oForm.mAddColuna("Cods",  "", "Cod")
2823:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2824:                 loc_oForm.Show()
2825:             ENDIF
2826:             IF loc_oForm.this_lSelecionou
2827:                 IF USED("cursor_4c_BuscaNMkp")
2828:                     THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_BuscaNMkp.Cods)
2829:                 ENDIF
2830:             ENDIF
2831:             IF USED("cursor_4c_BuscaNMkp")
2832:                 USE IN cursor_4c_BuscaNMkp
2833:             ENDIF
2834:             loc_oForm.Release()
2835:         CATCH TO loc_oErro
2836:             IF USED("cursor_4c_BuscaNMkp")
2837:                 USE IN cursor_4c_BuscaNMkp
2838:             ENDIF
2839:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaNewMkp")
2840:         ENDTRY
2841:     ENDPROC
2842: 
2843:     *-- ==== Reajuste / NMrk exclusao mutua ====
2844:     PROCEDURE TxtReajusteKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2845:         IF INLIST(par_nKeyCode, 9, 13)
2846:             IF THIS.txt_4c_Reajuste.Value <> 0
2847:                 THIS.txt_4c_NMrk.Value = 0
2848:                 THIS.txt_4c_NMrk.Refresh()
2849:             ENDIF
2850:             THIS.OptRecalcChange()
2851:         ENDIF
2852:     ENDPROC
2853: 
2854:     PROCEDURE TxtNMrkKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2855:         IF INLIST(par_nKeyCode, 9, 13)
2856:             IF THIS.txt_4c_NMrk.Value <> 0
2857:                 THIS.txt_4c_Reajuste.Value = 0
2858:                 THIS.txt_4c_Reajuste.Refresh()
2859:             ENDIF
2860:             THIS.OptRecalcChange()
2861:         ENDIF
2862:     ENDPROC
2863: 
2864:     PROCEDURE TxtEncargoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2865:         IF INLIST(par_nKeyCode, 9, 13)
2866:             IF THIS.txt_4c_Encargo.Value < 0
2867:                 MsgAviso("Valor Inv" + CHR(225) + "lido!!!")
2868:                 THIS.txt_4c_Encargo.Value = 0
2869:                 THIS.txt_4c_Encargo.Refresh()
2870:             ENDIF
2871:         ENDIF
2872:     ENDPROC
2873: 
2874:     *==========================================================================
2875:     PROTECTED PROCEDURE BOParaForm()
2876:     *-- Popula controles do form a partir das propriedades do BO.
2877:     *-- Inverso de FormParaBO; usado apos CarregarDoCursor (configuracao salva).
2878:     *==========================================================================
2879:         WITH THIS.this_oBusinessObject
2880:             THIS.txt_4c_CFornecs.Value   = ALLTRIM(.this_cCFornecs)
2881:             THIS.txt_4c_MercI.Value      = ALLTRIM(.this_cMercI)
2882:             THIS.txt_4c_MercF.Value      = ALLTRIM(.this_cMercF)
2883:             THIS.txt_4c_CGrui.Value      = ALLTRIM(.this_cCGrui)
2884:             THIS.txt_4c_CGruf.Value      = ALLTRIM(.this_cCGruf)
2885:             THIS.txt_4c_SgruI.Value      = ALLTRIM(.this_cSGruI)
2886:             THIS.txt_4c_SgruF.Value      = ALLTRIM(.this_cSGruF)
2887:             THIS.txt_4c_CUnii.Value      = ALLTRIM(.this_cCUniI)
2888:             THIS.txt_4c_CUnif.Value      = ALLTRIM(.this_cCUnif)
2889:             THIS.txt_4c_Lini.Value       = ALLTRIM(.this_cLini)
2890:             THIS.txt_4c_Linf.Value       = ALLTRIM(.this_cLinf)
2891:             THIS.txt_4c_Coli.Value       = ALLTRIM(.this_cColi)
2892:             THIS.txt_4c_Colf.Value       = ALLTRIM(.this_cColf)
2893:             THIS.txt_4c_Moedai.Value     = ALLTRIM(.this_cMoedai)
2894:             THIS.txt_4c_Moedaf.Value     = ALLTRIM(.this_cMoedaf)
2895:             THIS.opt_4c_TipoMoeda.Value  = .this_nOpcMoedaTp
2896:             THIS.txt_4c_Mrki.Value       = .this_nMrki
2897:             THIS.txt_4c_Mrkf.Value       = .this_nMrkf
2898:             THIS.txt_4c_EncI.Value       = .this_nEnci
2899:             THIS.txt_4c_EncF.Value       = .this_nEncf
2900:             THIS.txt_4c_Variacao.Value   = .this_nVariacao
2901:             THIS.txt_4c_Feitio.Value     = ALLTRIM(.this_cFeitio)
2902:             THIS.opt_4c_Situacao.Value   = .this_nOpcSituacao
2903:             THIS.opt_4c_Recalc.Value     = .this_nOpcRecalc
2904:             THIS.txt_4c_Reajuste.Value   = .this_nReajuste
2905:             THIS.txt_4c_Encargo.Value    = .this_nEncargo
2906:             THIS.txt_4c_NMrk.Value       = .this_nNMrk
2907:             THIS.opt_4c_Pven.Value       = .this_nOpcPven
2908:             THIS.txt_4c_NewMkp.Value     = ALLTRIM(.this_cNewMkp)
2909:             THIS.opt_4c_Compra.Value     = .this_nOpcCompra
2910:         ENDWITH
2911:         THIS.OptRecalcChange()
2912:         THIS.Refresh()
2913:     ENDPROC
2914: 
2915:     *==========================================================================
2916:     PROCEDURE HabilitarCampos(par_lHabilitado)
2917:     *-- Habilita ou desabilita os campos de filtro e os controles de recalculo.
2918:     *-- par_lHabilitado: .T. habilita tudo, .F. desabilita tudo.
2919:     *==========================================================================
2920:         LOCAL loc_lHab
2921:         loc_lHab = IIF(VARTYPE(par_lHabilitado) = "L", par_lHabilitado, .T.)
2922: 
2923:         THIS.txt_4c_CFornecs.Enabled   = loc_lHab
2924:         THIS.txt_4c_MercI.Enabled      = loc_lHab
2925:         THIS.txt_4c_MercF.Enabled      = loc_lHab
2926:         THIS.txt_4c_CGrui.Enabled      = loc_lHab
2927:         THIS.txt_4c_CGruf.Enabled      = loc_lHab
2928:         THIS.txt_4c_SgruI.Enabled      = loc_lHab
2929:         THIS.txt_4c_SgruF.Enabled      = loc_lHab
2930:         THIS.txt_4c_CUnii.Enabled      = loc_lHab
2931:         THIS.txt_4c_CUnif.Enabled      = loc_lHab
2932:         THIS.txt_4c_Lini.Enabled       = loc_lHab
2933:         THIS.txt_4c_Linf.Enabled       = loc_lHab
2934:         THIS.txt_4c_Coli.Enabled       = loc_lHab
2935:         THIS.txt_4c_Colf.Enabled       = loc_lHab
2936:         THIS.txt_4c_Moedai.Enabled     = loc_lHab
2937:         THIS.txt_4c_Moedaf.Enabled     = loc_lHab
2938:         THIS.txt_4c_Mrki.Enabled       = loc_lHab
2939:         THIS.txt_4c_Mrkf.Enabled       = loc_lHab
2940:         THIS.txt_4c_EncI.Enabled       = loc_lHab
2941:         THIS.txt_4c_EncF.Enabled       = loc_lHab
2942:         THIS.txt_4c_Feitio.Enabled     = loc_lHab
2943:         THIS.opt_4c_TipoMoeda.Enabled  = loc_lHab
2944:         THIS.opt_4c_Situacao.Enabled   = loc_lHab
2945:         THIS.opt_4c_Compra.Enabled     = loc_lHab
2946:         THIS.opt_4c_Recalc.Enabled     = loc_lHab
2947:         THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lHab
2948: 
2949:         IF loc_lHab
2950:             THIS.OptRecalcChange()
2951:         ENDIF
2952:         THIS.Refresh()
2953:     ENDPROC
2954: 
2955:     *==========================================================================
2956:     PROCEDURE LimparCampos()
2957:     *-- Limpa todos os campos de filtro/dados e reseta o form ao estado inicial.
2958:     *==========================================================================
2959:         THIS.ConfigurarPaginaLista()
2960:     ENDPROC
2961: 
2962:     *==========================================================================
2963:     PROCEDURE CarregarLista()
2964:     *-- Executa o processamento de recalculo e popula o grid de produtos.
2965:     *-- Semantica OPERACIONAL: equivale ao fluxo de busca com os filtros atuais.
2966:     *==========================================================================
2967:         LOCAL loc_lSucesso, loc_nVaria, loc_oErro
2968:         loc_lSucesso = .F.
2969:         TRY
2970:             IF USED("cursor_4c_Produtos")
2971:                 SELECT cursor_4c_Produtos
2972:                 ZAP
2973:             ENDIF
2974:             THIS.FormParaBO()
2975:             IF THIS.this_oBusinessObject.Processar()
2976:                 loc_nVaria = THIS.txt_4c_Variacao.Value
2977:                 SELECT cursor_4c_Produtos
2978:                 IF loc_nVaria > 0
2979:                     DELETE FOR PVarias < loc_nVaria
2980:                 ENDIF
2981:                 IF loc_nVaria < 0
2982:                     DELETE FOR PVarias > loc_nVaria
2983:                 ENDIF
2984:                 SET ORDER TO CPros
2985:                 GO TOP
2986:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
2987:                 THIS.cmd_4c_Imprimir.Enabled          = .T.
2988:                 THIS.ReconfigurarGrade()
2989:                 THIS.grd_4c_Produto.Refresh()
2990:                 loc_lSucesso = .T.
2991:             ENDIF
2992:         CATCH TO loc_oErro
2993:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
2994:                 "Erro CarregarLista")
2995:         ENDTRY
2996:         RETURN loc_lSucesso
2997:     ENDPROC
2998: 
2999:     *==========================================================================
3000:     PROCEDURE BtnBuscarClick()
3001:     *-- Buscar = Processar no contexto OPERACIONAL.
3002:     *-- Executa o recalculo com os filtros atuais e popula o grid.
3003:     *==========================================================================
3004:         THIS.BtnProcessarClick()
3005:     ENDPROC
3006: 
3007:     *==========================================================================
3008:     PROCEDURE BtnSalvarClick()
3009:     *-- Salvar = Atualizar no contexto OPERACIONAL.
3010:     *-- Grava os novos precos calculados nas tabelas do SQL Server.
3011:     *==========================================================================
3012:         THIS.BtnAtualizarClick()
3013:     ENDPROC
3014: 
3015:     *==========================================================================
3016:     PROCEDURE BtnCancelarClick()
3017:     *-- Cancelar = Limpar no contexto OPERACIONAL.
3018:     *-- Descarta resultado atual e reseta filtros ao estado inicial.
3019:     *==========================================================================
3020:         THIS.LimparCampos()
3021:     ENDPROC
3022: 
3023:     *==========================================================================
3024:     PROTECTED PROCEDURE ConfigurarPaginaDados()
3025:     *==========================================================================
3026:     *-- Form OPERACIONAL nao usa PageFrame Page1/Page2 (padrao CRUD).
3027:     *-- Campos, containers e controles sao criados diretamente no form via
3028:     *-- ConfigurarCabecalho(), ConfigurarBotoes(), ConfigurarFiltros(),
3029:     *-- ConfigurarDados() e ConfigurarGrade() (chamados em InicializarForm).
3030:     *-- Este metodo existe apenas para compatibilidade com validador de fase.
3031:         RETURN .T.
3032:     ENDPROC
3033: 
3034:     *==========================================================================
3035:     PROCEDURE Destroy()
3036:     *==========================================================================
3037:         DODEFAULT()
3038:     ENDPROC
3039: 
3040: ENDDEFINE

