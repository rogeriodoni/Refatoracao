# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3052 linhas total):

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
1360:             .Column1.ControlSource = "cursor_4c_Produtos.lMarca"
1361:             .Column2.ControlSource = "cursor_4c_Produtos.CPros"
1362:             .Column3.ControlSource = "cursor_4c_Produtos.DPros"
1363:             .Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
1364:             .Column5.ControlSource = "cursor_4c_Produtos.ValAtu"
1365:             .Column6.ControlSource = "cursor_4c_Produtos.PVarias"
1366:             .Column7.ControlSource = "cursor_4c_Produtos.CustoAfs"
1367:             .Column8.ControlSource = "cursor_4c_Produtos.CustoFs"
1368:             .Column9.ControlSource = "cursor_4c_Produtos.CVarias"
1369:             .ReadOnly     = .F.
1370: 
1371:             *-- Column1: CheckBox lMarca
1372:             WITH .Column1
1373:                 .Width        = 17
1374:                 .HeaderHeight       = 0
1375:                 .Alignment    = 3
1376:                 .Movable      = .F.
1377:                 .Resizable    = .F.
1378:                 .Sparse       = .F.
1379:                 .FontName     = "Tahoma"
1380:                 .FontSize     = 8
1381:                 .AddObject("Check1", "CheckBox")
1382:                 .Check1.Caption = ""
1383:                 .Check1.Value   = 0
1384:                 .CurrentControl = "Check1"
1385:                 .ControlSource  = "cursor_4c_Produtos.lMarca"
1386:                 WITH .Header1

*-- Linhas 1538 a 3052:
1538:     ENDPROC
1539: 
1540:     *==========================================================================
1541:     PROTECTED PROCEDURE ReconfigurarGrade()
1542:     *==========================================================================
1543:         WITH THIS.grd_4c_Produto
1544:             .RecordSource          = "cursor_4c_Produtos"
1545:             .Column1.ControlSource = "cursor_4c_Produtos.lMarca"
1546:             .Column2.ControlSource = "cursor_4c_Produtos.CPros"
1547:             .Column3.ControlSource = "cursor_4c_Produtos.DPros"
1548:             .Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
1549:             .Column5.ControlSource = "cursor_4c_Produtos.ValAtu"
1550:             .Column6.ControlSource = "cursor_4c_Produtos.PVarias"
1551:             .Column7.ControlSource = "cursor_4c_Produtos.CustoAfs"
1552:             .Column8.ControlSource = "cursor_4c_Produtos.CustoFs"
1553:             .Column9.ControlSource = "cursor_4c_Produtos.CVarias"
1554:         ENDWITH
1555:     ENDPROC
1556: 
1557:     *==========================================================================
1558:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1559:     *==========================================================================
1560:         LOCAL loc_i, loc_oControl
1561:         FOR loc_i = 1 TO par_oContainer.ControlCount
1562:             loc_oControl = par_oContainer.Controls(loc_i)
1563:             IF INLIST(UPPER(loc_oControl.Name), "IMG_4C_PRODUTO", "CNT_4C_CABECALHO")
1564:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1565:                     THIS.TornarControlesVisiveis(loc_oControl)
1566:                 ENDIF
1567:                 LOOP
1568:             ENDIF
1569:             loc_oControl.Visible = .T.
1570:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1571:                 THIS.TornarControlesVisiveis(loc_oControl)
1572:             ENDIF
1573:         ENDFOR
1574:     ENDPROC
1575: 
1576:     *==========================================================================
1577:     PROTECTED PROCEDURE FormParaBO()
1578:     *==========================================================================
1579:         WITH THIS.this_oBusinessObject
1580:             .this_cCFornecs    = ALLTRIM(THIS.txt_4c_CFornecs.Value)
1581:             .this_cMercI       = ALLTRIM(THIS.txt_4c_MercI.Value)
1582:             .this_cMercF       = ALLTRIM(THIS.txt_4c_MercF.Value)
1583:             .this_cCGrui       = ALLTRIM(THIS.txt_4c_CGrui.Value)
1584:             .this_cCGruf       = ALLTRIM(THIS.txt_4c_CGruf.Value)
1585:             .this_cSGruI       = ALLTRIM(THIS.txt_4c_SgruI.Value)
1586:             .this_cSGruF       = ALLTRIM(THIS.txt_4c_SgruF.Value)
1587:             .this_cCUniI       = ALLTRIM(THIS.txt_4c_CUnii.Value)
1588:             .this_cCUnif       = ALLTRIM(THIS.txt_4c_CUnif.Value)
1589:             .this_cLini        = ALLTRIM(THIS.txt_4c_Lini.Value)
1590:             .this_cLinf        = ALLTRIM(THIS.txt_4c_Linf.Value)
1591:             .this_cColi        = ALLTRIM(THIS.txt_4c_Coli.Value)
1592:             .this_cColf        = ALLTRIM(THIS.txt_4c_Colf.Value)
1593:             .this_cMoedai      = ALLTRIM(THIS.txt_4c_Moedai.Value)
1594:             .this_cMoedaf      = ALLTRIM(THIS.txt_4c_Moedaf.Value)
1595:             .this_nOpcMoedaTp  = THIS.opt_4c_TipoMoeda.Value
1596:             .this_nMrki        = THIS.txt_4c_Mrki.Value
1597:             .this_nMrkf        = THIS.txt_4c_Mrkf.Value
1598:             .this_nEnci        = THIS.txt_4c_EncI.Value
1599:             .this_nEncf        = THIS.txt_4c_EncF.Value
1600:             .this_nVariacao    = THIS.txt_4c_Variacao.Value
1601:             .this_cFeitio      = ALLTRIM(THIS.txt_4c_Feitio.Value)
1602:             .this_nOpcSituacao = THIS.opt_4c_Situacao.Value
1603:             .this_nOpcRecalc   = THIS.opt_4c_Recalc.Value
1604:             .this_nReajuste    = THIS.txt_4c_Reajuste.Value
1605:             .this_nEncargo     = THIS.txt_4c_Encargo.Value
1606:             .this_nNMrk        = THIS.txt_4c_NMrk.Value
1607:             .this_nOpcPven     = THIS.opt_4c_Pven.Value
1608:             .this_cNewMkp      = ALLTRIM(THIS.txt_4c_NewMkp.Value)
1609:             .this_nOpcCompra   = THIS.opt_4c_Compra.Value
1610:         ENDWITH
1611:     ENDPROC
1612: 
1613:     *==========================================================================
1614:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1615:     *==========================================================================
1616:         THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1617:         THIS.cmd_4c_Imprimir.Enabled          = .F.
1618:     ENDPROC
1619: 
1620:     *==========================================================================
1621:     * ConfigurarPaginaLista - Reseta form OPERACIONAL ao estado inicial
1622:     * Form OPERACIONAL de layout plano: mapeia "Pagina Lista" para
1623:     * "estado inicial de sele" + CHR(231) + CHR(227) + "o de filtros" (equivalente
1624:     * a limpar filtros, resetar op" + CHR(231) + CHR(245) + "es, zerar grid de
1625:     * produtos e devolver o foco para o primeiro campo de filtro).
1626:     *==========================================================================
1627:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1628:         LOCAL loc_oErro
1629:         TRY
1630:             *-- Zera cursor de produtos (grid principal)
1631:             IF USED("cursor_4c_Produtos")
1632:                 SELECT cursor_4c_Produtos
1633:                 ZAP
1634:             ENDIF
1635: 
1636:             *-- Limpa filtros (textboxes de sele" + CHR(231) + CHR(227) + "o)
1637:             THIS.txt_4c_CFornecs.Value = ""
1638:             THIS.txt_4c_DFornecs.Value = ""
1639:             THIS.txt_4c_MercI.Value    = ""
1640:             THIS.txt_4c_MercF.Value    = ""
1641:             THIS.txt_4c_CGrui.Value    = ""
1642:             THIS.txt_4c_CGruf.Value    = ""
1643:             THIS.txt_4c_SgruI.Value    = ""
1644:             THIS.txt_4c_SgruF.Value    = ""
1645:             THIS.txt_4c_CUnii.Value    = ""
1646:             THIS.txt_4c_CUnif.Value    = ""
1647:             THIS.txt_4c_Lini.Value     = ""
1648:             THIS.txt_4c_Linf.Value     = ""
1649:             THIS.txt_4c_Coli.Value     = ""
1650:             THIS.txt_4c_Colf.Value     = ""
1651:             THIS.txt_4c_Moedai.Value   = ""
1652:             THIS.txt_4c_Moedaf.Value   = ""
1653:             THIS.txt_4c_Mrki.Value     = 0
1654:             THIS.txt_4c_Mrkf.Value     = 0
1655:             THIS.txt_4c_EncI.Value     = 0
1656:             THIS.txt_4c_EncF.Value     = 0
1657: 
1658:             *-- Reseta campos de recalculo
1659:             THIS.txt_4c_Reajuste.Value = 0
1660:             THIS.txt_4c_NMrk.Value     = 0
1661:             THIS.txt_4c_Variacao.Value = 0
1662:             THIS.txt_4c_NewMkp.Value   = ""
1663:             THIS.txt_4c_Feitio.Value   = ""
1664:             THIS.txt_4c_Encargo.Value  = 0
1665: 
1666:             *-- Reseta OptionGroups aos valores default
1667:             THIS.opt_4c_Recalc.Value   = 1
1668:             THIS.opt_4c_Pven.Value     = 2
1669:             THIS.opt_4c_Compra.Value   = 3
1670:             THIS.opt_4c_Situacao.Value = 1
1671: 
1672:             *-- Oculta imagem de produto (aparece apenas ao selecionar linha)
1673:             THIS.img_4c_Produto.Visible = .F.
1674:             THIS.img_4c_Produto.Picture = ""
1675: 
1676:             *-- Reseta estado dos botoes (Processar habilitado, Atualizar/Imprimir desabilitados)
1677:             THIS.AjustarBotoesPorModo()
1678: 
1679:             *-- Recalcula habilitacao condicional (Reajuste/NMrk/Variacao/NewMkp)
1680:             THIS.OptRecalcChange()
1681: 
1682:             *-- Foco inicial no primeiro filtro
1683:             THIS.txt_4c_CFornecs.SetFocus()
1684:             THIS.Refresh()
1685:         CATCH TO loc_oErro
1686:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1687:                     "Erro ConfigurarPaginaLista")
1688:         ENDTRY
1689:     ENDPROC
1690: 
1691:     *==========================================================================
1692:     * AlternarPagina - Alterna o "modo de trabalho" do form OPERACIONAL
1693:     * Form OPERACIONAL de layout plano: n" + CHR(227) + "o h" + CHR(225) + ;
1694:     * " PageFrame; este metodo mapeia "alternar pagina" para "alternar contexto".
1695:     *   par_nPagina = 1 -> LISTA/FILTROS (foco no primeiro filtro, reseta form)
1696:     *   par_nPagina = 2 -> DADOS/GRID    (foco no grid de produtos apos processar)
1697:     *   par_nPagina = 0 -> reset completo (equivale a ConfigurarPaginaLista)
1698:     *==========================================================================
1699:     PROCEDURE AlternarPagina(par_nPagina)
1700:         LOCAL loc_nPagina, loc_oErro
1701:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
1702: 
1703:         TRY
1704:             DO CASE
1705:                 CASE loc_nPagina = 1
1706:                     *-- Modo LISTA/FILTROS: foco no primeiro campo, botoes iniciais
1707:                     THIS.AjustarBotoesPorModo()
1708:                     THIS.txt_4c_CFornecs.SetFocus()
1709:                 CASE loc_nPagina = 2
1710:                     *-- Modo DADOS/GRID: foco no grid apos processamento
1711:                     IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
1712:                         SELECT cursor_4c_Produtos
1713:                         SET ORDER TO CPros
1714:                         GO TOP
1715:                         THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1716:                         THIS.cmd_4c_Imprimir.Enabled          = .T.
1717:                         THIS.grd_4c_Produto.SetFocus()
1718:                     ELSE
1719:                         MsgAviso("Nenhum produto para exibir. Execute o processamento primeiro.")
1720:                         THIS.txt_4c_CFornecs.SetFocus()
1721:                     ENDIF
1722:                 OTHERWISE
1723:                     THIS.ConfigurarPaginaLista()
1724:             ENDCASE
1725: 
1726:             THIS.Refresh()
1727:         CATCH TO loc_oErro
1728:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1729:                     "Erro AlternarPagina")
1730:         ENDTRY
1731:     ENDPROC
1732: 
1733:     *==========================================================================
1734:     PROCEDURE OptRecalcChange()
1735:     *==========================================================================
1736:         LOCAL loc_nOpcRec
1737:         loc_nOpcRec = THIS.opt_4c_Recalc.Value
1738:         THIS.txt_4c_Reajuste.Enabled = (loc_nOpcRec <> 2)
1739:         THIS.txt_4c_NMrk.Enabled     = (THIS.txt_4c_Reajuste.Value = 0) AND (loc_nOpcRec <> 2)
1740:         THIS.txt_4c_Variacao.Enabled = (THIS.txt_4c_Reajuste.Value = 0) AND (loc_nOpcRec <> 2)
1741:         THIS.txt_4c_NewMkp.Enabled   = INLIST(loc_nOpcRec, 7, 8)
1742:         THIS.txt_4c_Reajuste.Refresh()
1743:         THIS.txt_4c_NMrk.Refresh()
1744:         THIS.txt_4c_Variacao.Refresh()
1745:         THIS.txt_4c_NewMkp.Refresh()
1746:     ENDPROC
1747: 
1748:     *==========================================================================
1749:     * BtnIncluirClick - Inicia nova sessao de recalculo de precos
1750:     *   Semantica OPERACIONAL: equivale a "novo lote". Descarta resultado
1751:     *   anterior (cursor de produtos), reseta todos os filtros e opcoes ao
1752:     *   estado inicial e devolve o foco ao primeiro filtro (Fornecedor).
1753:     *==========================================================================
1754:     PROCEDURE BtnIncluirClick()
1755:         LOCAL loc_oErro
1756:         TRY
1757:             IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
1758:                 IF !MsgConfirma("Existem dados processados. Descartar e iniciar novo rec" + ;
1759:                                 CHR(225) + "lculo?", ;
1760:                                 "Confirma" + CHR(231) + CHR(227) + "o")
1761:                     RETURN
1762:                 ENDIF
1763:             ENDIF
1764: 
1765:             *-- Reset completo do form (limpa filtros, zera cursor, reseta UI)
1766:             THIS.ConfigurarPaginaLista()
1767:         CATCH TO loc_oErro
1768:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1769:                     "Erro BtnIncluirClick")
1770:         ENDTRY
1771:     ENDPROC
1772: 
1773:     *==========================================================================
1774:     * BtnAlterarClick - Executa recalculo de precos com filtros atuais
1775:     *   Semantica OPERACIONAL: equivale a "alterar" (aplicar novo calculo)
1776:     *   sobre os produtos que atendem aos filtros. Delega para o fluxo de
1777:     *   processamento (Processar do BO) para preencher o grid com os precos
1778:     *   propostos. A gravacao definitiva no banco ocorre em BtnAtualizarClick.
1779:     *==========================================================================
1780:     PROCEDURE BtnAlterarClick()
1781:         LOCAL loc_oErro
1782:         TRY
1783:             *-- Delega para o fluxo de processamento (mesma logica do botao Processar)
1784:             THIS.BtnProcessarClick()
1785:         CATCH TO loc_oErro
1786:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1787:                     "Erro BtnAlterarClick")
1788:         ENDTRY
1789:     ENDPROC
1790: 
1791:     *==========================================================================
1792:     * BtnVisualizarClick - Exibe detalhes/imagem do produto selecionado
1793:     *   Semantica OPERACIONAL: equivale a "consultar registro". Exige que ja
1794:     *   exista resultado processado no grid e uma linha selecionada; abre a
1795:     *   figura do produto via GrdAfterRowColChange (mesma logica do click do
1796:     *   ImgProduto no legado).
1797:     *==========================================================================
1798:     PROCEDURE BtnVisualizarClick()
1799:         LOCAL loc_oErro
1800:         TRY
1801:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
1802:                 MsgAviso("Nenhum produto processado. Execute o rec" + CHR(225) + ;
1803:                          "lculo antes de visualizar.", "Aviso")
1804:                 RETURN
1805:             ENDIF
1806: 
1807:             SELECT cursor_4c_Produtos
1808:             IF EOF() OR EMPTY(cursor_4c_Produtos.CPros)
1809:                 MsgAviso("Selecione um produto no grid para visualizar.", "Aviso")
1810:                 THIS.grd_4c_Produto.SetFocus()
1811:                 RETURN
1812:             ENDIF
1813: 
1814:             *-- Renderiza figura do produto corrente (mesma logica do AfterRowColChange)
1815:             THIS.GrdAfterRowColChange(1)
1816:             THIS.img_4c_Produto.Visible = .T.
1817:             THIS.img_4c_Produto.Refresh()
1818:         CATCH TO loc_oErro
1819:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1820:                     "Erro BtnVisualizarClick")
1821:         ENDTRY
1822:     ENDPROC
1823: 
1824:     *==========================================================================
1825:     * BtnExcluirClick - Remove produto(s) do resultado corrente do recalculo
1826:     *   Semantica OPERACIONAL: NAO exclui da tabela SigCdPro (fluxo de recalculo
1827:     *   nao altera cadastro). Remove do cursor de trabalho a(s) linha(s)
1828:     *   marcada(s) (lMarca = 1) ou apenas a linha corrente se nenhuma estiver
1829:     *   marcada. Assim o usuario refina o conjunto antes de gravar via Atualizar.
1830:     *==========================================================================
1831:     PROCEDURE BtnExcluirClick()
1832:         LOCAL loc_nMarcados, loc_cCodPro, loc_oErro
1833:         TRY
1834:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
1835:                 MsgAviso("Nenhum produto processado para remover.", "Aviso")
1836:                 RETURN
1837:             ENDIF
1838: 
1839:             SELECT cursor_4c_Produtos
1840:             COUNT FOR lMarca = 1 TO loc_nMarcados
1841: 
1842:             IF loc_nMarcados > 0
1843:                 IF !MsgConfirma("Remover " + TRANSFORM(loc_nMarcados) + ;
1844:                                 " produto(s) marcado(s) do rec" + CHR(225) + ;
1845:                                 "lculo?", ;
1846:                                 "Confirma" + CHR(231) + CHR(227) + "o")
1847:                     RETURN
1848:                 ENDIF
1849:                 SELECT cursor_4c_Produtos
1850:                 DELETE FOR lMarca = 1
1851:                 PACK
1852:             ELSE
1853:                 IF EOF() OR EMPTY(cursor_4c_Produtos.CPros)
1854:                     MsgAviso("Selecione um produto no grid ou marque na primeira coluna.", ;
1855:                              "Aviso")
1856:                     THIS.grd_4c_Produto.SetFocus()
1857:                     RETURN
1858:                 ENDIF
1859:                 loc_cCodPro = ALLTRIM(cursor_4c_Produtos.CPros)
1860:                 IF !MsgConfirma("Remover o produto " + loc_cCodPro + ;
1861:                                 " do rec" + CHR(225) + "lculo?", ;
1862:                                 "Confirma" + CHR(231) + CHR(227) + "o")
1863:                     RETURN
1864:                 ENDIF
1865:                 SELECT cursor_4c_Produtos
1866:                 DELETE
1867:                 PACK
1868:             ENDIF
1869: 
1870:             *-- Se cursor ficou vazio, desabilita Atualizar/Imprimir
1871:             IF RECCOUNT("cursor_4c_Produtos") = 0
1872:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1873:                 THIS.cmd_4c_Imprimir.Enabled          = .F.
1874:                 THIS.img_4c_Produto.Visible           = .F.
1875:                 THIS.img_4c_Produto.Picture           = ""
1876:             ENDIF
1877: 
1878:             THIS.grd_4c_Produto.Refresh()
1879:         CATCH TO loc_oErro
1880:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1881:                     "Erro BtnExcluirClick")
1882:         ENDTRY
1883:     ENDPROC
1884: 
1885:     *==========================================================================
1886:     PROCEDURE BtnProcessarClick()
1887:     *==========================================================================
1888:         LOCAL loc_lSucesso, loc_nVaria, loc_oErro
1889:         loc_lSucesso = .F.
1890:         TRY
1891:             IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
1892:                 IF !MsgConfirma("Existem Dados Gerados. Deseja Reprocessar?")
1893:                     RETURN
1894:                 ENDIF
1895:             ENDIF
1896:             ZAP IN cursor_4c_Produtos
1897: 
1898:             THIS.FormParaBO()
1899: 
1900:             IF THIS.this_oBusinessObject.Processar()
1901:                 loc_nVaria = THIS.txt_4c_Variacao.Value
1902:                 SELECT cursor_4c_Produtos
1903:                 IF loc_nVaria > 0
1904:                     DELETE FOR PVarias < loc_nVaria
1905:                 ENDIF
1906:                 IF loc_nVaria < 0
1907:                     DELETE FOR PVarias > loc_nVaria
1908:                 ENDIF
1909:                 SET ORDER TO CPros
1910:                 GO TOP
1911:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1912:                 THIS.cmg_4c_Botoes.Buttons(2).Refresh()
1913:                 THIS.cmd_4c_Imprimir.Enabled = .T.
1914:                 THIS.cmd_4c_Imprimir.Refresh()
1915:                 THIS.ReconfigurarGrade()
1916:                 THIS.grd_4c_Produto.Column1.SetFocus()
1917:                 THIS.grd_4c_Produto.Refresh()
1918:                 loc_lSucesso = .T.
1919:             ENDIF
1920:         CATCH TO loc_oErro
1921:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnProcessarClick")
1922:         ENDTRY
1923:         RETURN loc_lSucesso
1924:     ENDPROC
1925: 
1926:     *==========================================================================
1927:     PROCEDURE BtnAtualizarClick()
1928:     *==========================================================================
1929:         LOCAL loc_lImpEtiq, loc_oErro
1930:         TRY
1931:             loc_lImpEtiq = MsgConfirma("Confirma a Impress" + CHR(227) + "o das Etiquetas?")
1932:             IF THIS.this_oBusinessObject.AtualizarPrecos(loc_lImpEtiq)
1933:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1934:                 THIS.cmd_4c_Imprimir.Enabled = .F.
1935:                 THIS.grd_4c_Produto.Refresh()
1936:             ENDIF
1937:         CATCH TO loc_oErro
1938:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnAtualizarClick")
1939:         ENDTRY
1940:     ENDPROC
1941: 
1942:     *==========================================================================
1943:     PROCEDURE BtnEncerrarClick()
1944:     *==========================================================================
1945:         THIS.Release()
1946:     ENDPROC
1947: 
1948:     *==========================================================================
1949:     PROCEDURE BtnImprimirClick()
1950:     *==========================================================================
1951:         LOCAL loc_oForm, loc_oErro
1952:         TRY
1953:             loc_oForm = CREATEOBJECT("FormSIGPRCCR")
1954:             IF VARTYPE(loc_oForm) = "O"
1955:                 loc_oForm.Show()
1956:             ELSE
1957:                 MsgErro("Erro ao abrir impress" + CHR(227) + "o de pre" + CHR(231) + "os." + ;
1958:                     CHR(13) + "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
1959:             ENDIF
1960:         CATCH TO loc_oErro
1961:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnImprimirClick")
1962:         ENDTRY
1963:     ENDPROC
1964: 
1965:     *==========================================================================
1966:     PROCEDURE BtnSelTudoClick()
1967:     *==========================================================================
1968:         LOCAL loc_oErro
1969:         TRY
1970:             UPDATE cursor_4c_Produtos SET lMarca = 1
1971:             THIS.grd_4c_Produto.Refresh()
1972:         CATCH TO loc_oErro
1973:             MsgErro(loc_oErro.Message, "Erro BtnSelTudoClick")
1974:         ENDTRY
1975:     ENDPROC
1976: 
1977:     *==========================================================================
1978:     PROCEDURE BtnDesmarcarClick()
1979:     *==========================================================================
1980:         LOCAL loc_oErro
1981:         TRY
1982:             UPDATE cursor_4c_Produtos SET lMarca = 0
1983:             THIS.grd_4c_Produto.Refresh()
1984:         CATCH TO loc_oErro
1985:             MsgErro(loc_oErro.Message, "Erro BtnDesmarcarClick")
1986:         ENDTRY
1987:     ENDPROC
1988: 
1989:     *==========================================================================
1990:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1991:     *==========================================================================
1992:         LOCAL loc_cArquivo, loc_cCodPro, loc_cSQL, loc_cFoto, loc_oErro
1993:         TRY
1994:             IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
1995:                 RETURN
1996:             ENDIF
1997:             loc_cArquivo = SYS(2023) + "\TempCj.jpg"
1998:             SELECT cursor_4c_Produtos
1999:             loc_cCodPro = ALLTRIM(cursor_4c_Produtos.CPros)
2000:             loc_cSQL    = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cCodPro)
2001:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFig") < 1
2002:                 THIS.img_4c_Produto.Visible = .F.
2003:                 RETURN
2004:             ENDIF
2005:             SELECT cursor_4c_TmpFig
2006:             THIS.img_4c_Produto.Visible  = .F.
2007:             THIS.img_4c_Produto.Picture  = ""
2008:             IF !ISNULL(cursor_4c_TmpFig.FigJpgs) AND !EMPTY(cursor_4c_TmpFig.FigJpgs)
2009:                 loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_TmpFig.FigJpgs, ;
2010:                     "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
2011:                     "data:image/jpg;base64,", ""), 14)
2012:                 STRTOFILE(loc_cFoto, loc_cArquivo)
2013:                 THIS.img_4c_Produto.Picture = loc_cArquivo
2014:                 THIS.img_4c_Produto.Visible = .T.
2015:             ENDIF
2016:             IF USED("cursor_4c_TmpFig")
2017:                 USE IN cursor_4c_TmpFig
2018:             ENDIF
2019:         CATCH TO loc_oErro
2020:             IF USED("cursor_4c_TmpFig")
2021:                 USE IN cursor_4c_TmpFig
2022:             ENDIF
2023:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro GrdAfterRowColChange")
2024:         ENDTRY
2025:     ENDPROC
2026: 
2027:     *-- ==== LOOKUP: Fornecedor ====
2028:     PROCEDURE TxtCFornecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2029:         LOCAL loc_cVal, loc_oErro
2030:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2031:             RETURN
2032:         ENDIF
2033:         TRY
2034:             loc_cVal = ALLTRIM(THIS.txt_4c_CFornecs.Value)
2035:             IF EMPTY(loc_cVal)
2036:                 THIS.txt_4c_DFornecs.Value = ""
2037:                 RETURN
2038:             ENDIF
2039:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
2040:                        EscaparSQL(loc_cVal), "cursor_4c_TmpFor") > 0
2041:                 SELECT cursor_4c_TmpFor
2042:                 IF !EOF("cursor_4c_TmpFor")
2043:                     THIS.txt_4c_CFornecs.Value = ALLTRIM(cursor_4c_TmpFor.IClis)
2044:                     THIS.txt_4c_DFornecs.Value = ALLTRIM(cursor_4c_TmpFor.RClis)
2045:                     USE IN cursor_4c_TmpFor
2046:                     RETURN
2047:                 ENDIF
2048:                 USE IN cursor_4c_TmpFor
2049:             ENDIF
2050:             THIS.AbrirBuscaFornecedor()
2051:         CATCH TO loc_oErro
2052:             IF USED("cursor_4c_TmpFor")
2053:                 USE IN cursor_4c_TmpFor
2054:             ENDIF
2055:             MsgErro(loc_oErro.Message, "Erro TxtCFornecKeyPress")
2056:         ENDTRY
2057:     ENDPROC
2058: 
2059:     PROTECTED PROCEDURE AbrirBuscaFornecedor()
2060:         LOCAL loc_cVal, loc_oForm, loc_oErro
2061:         TRY
2062:             loc_cVal  = ALLTRIM(THIS.txt_4c_CFornecs.Value)
2063:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2064:                 "SigCdCli", "cursor_4c_BuscaFor", "IClis", loc_cVal, "Fornecedores")
2065:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2066:                 RETURN
2067:             ENDIF
2068:             IF !loc_oForm.this_lSelecionou
2069:                 loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2070:                 loc_oForm.mAddColuna("RClis", "", "Nome")
2071:                 loc_oForm.Show()
2072:             ENDIF
2073:             IF loc_oForm.this_lSelecionou
2074:                 IF USED("cursor_4c_BuscaFor")
2075:                     THIS.txt_4c_CFornecs.Value = ALLTRIM(cursor_4c_BuscaFor.IClis)
2076:                     THIS.txt_4c_DFornecs.Value = ALLTRIM(cursor_4c_BuscaFor.RClis)
2077:                 ENDIF
2078:             ENDIF
2079:             IF USED("cursor_4c_BuscaFor")
2080:                 USE IN cursor_4c_BuscaFor
2081:             ENDIF
2082:             loc_oForm.Release()
2083:         CATCH TO loc_oErro
2084:             IF USED("cursor_4c_BuscaFor")
2085:                 USE IN cursor_4c_BuscaFor
2086:             ENDIF
2087:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaFornecedor")
2088:         ENDTRY
2089:     ENDPROC
2090: 
2091:     *-- ==== LOOKUP: Grande Grupo ====
2092:     PROCEDURE TxtMercIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2093:         LOCAL loc_oErro
2094:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2095:             RETURN
2096:         ENDIF
2097:         TRY
2098:             IF EMPTY(ALLTRIM(THIS.txt_4c_MercI.Value))
2099:                 RETURN
2100:             ENDIF
2101:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descs FROM SigCdGpr WHERE Codigos = " + ;
2102:                        EscaparSQL(ALLTRIM(THIS.txt_4c_MercI.Value)), "cursor_4c_TmpGGr") > 0
2103:                 SELECT cursor_4c_TmpGGr
2104:                 IF !EOF("cursor_4c_TmpGGr")
2105:                     THIS.txt_4c_MercI.Value = ALLTRIM(cursor_4c_TmpGGr.Codigos)
2106:                     USE IN cursor_4c_TmpGGr
2107:                     RETURN
2108:                 ENDIF
2109:                 USE IN cursor_4c_TmpGGr
2110:             ENDIF
2111:             THIS.AbrirBuscaGrandeGrupo(.T.)
2112:         CATCH TO loc_oErro
2113:             IF USED("cursor_4c_TmpGGr")
2114:                 USE IN cursor_4c_TmpGGr
2115:             ENDIF
2116:             MsgErro(loc_oErro.Message, "Erro TxtMercIKeyPress")
2117:         ENDTRY
2118:     ENDPROC
2119: 
2120:     PROCEDURE TxtMercFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2121:         LOCAL loc_oErro
2122:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2123:             RETURN
2124:         ENDIF
2125:         TRY
2126:             IF EMPTY(ALLTRIM(THIS.txt_4c_MercF.Value))
2127:                 RETURN
2128:             ENDIF
2129:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descs FROM SigCdGpr WHERE Codigos = " + ;
2130:                        EscaparSQL(ALLTRIM(THIS.txt_4c_MercF.Value)), "cursor_4c_TmpGGr") > 0
2131:                 SELECT cursor_4c_TmpGGr
2132:                 IF !EOF("cursor_4c_TmpGGr")
2133:                     THIS.txt_4c_MercF.Value = ALLTRIM(cursor_4c_TmpGGr.Codigos)
2134:                     USE IN cursor_4c_TmpGGr
2135:                     RETURN
2136:                 ENDIF
2137:                 USE IN cursor_4c_TmpGGr
2138:             ENDIF
2139:             THIS.AbrirBuscaGrandeGrupo(.F.)
2140:         CATCH TO loc_oErro
2141:             IF USED("cursor_4c_TmpGGr")
2142:                 USE IN cursor_4c_TmpGGr
2143:             ENDIF
2144:             MsgErro(loc_oErro.Message, "Erro TxtMercFKeyPress")
2145:         ENDTRY
2146:     ENDPROC
2147: 
2148:     PROTECTED PROCEDURE AbrirBuscaGrandeGrupo(par_lIni)
2149:         LOCAL loc_cVal, loc_oForm, loc_oErro
2150:         TRY
2151:             loc_cVal = ALLTRIM(IIF(par_lIni, THIS.txt_4c_MercI.Value, THIS.txt_4c_MercF.Value))
2152:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2153:                 "SigCdGpr", "cursor_4c_BuscaGGr", "Codigos", loc_cVal, "Grande Grupo")
2154:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2155:                 RETURN
2156:             ENDIF
2157:             IF !loc_oForm.this_lSelecionou
2158:                 loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2159:                 loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
2160:                 loc_oForm.Show()
2161:             ENDIF
2162:             IF loc_oForm.this_lSelecionou
2163:                 IF USED("cursor_4c_BuscaGGr")
2164:                     IF par_lIni
2165:                         THIS.txt_4c_MercI.Value = ALLTRIM(cursor_4c_BuscaGGr.Codigos)
2166:                     ELSE
2167:                         THIS.txt_4c_MercF.Value = ALLTRIM(cursor_4c_BuscaGGr.Codigos)
2168:                     ENDIF
2169:                 ENDIF
2170:             ENDIF
2171:             IF USED("cursor_4c_BuscaGGr")
2172:                 USE IN cursor_4c_BuscaGGr
2173:             ENDIF
2174:             loc_oForm.Release()
2175:         CATCH TO loc_oErro
2176:             IF USED("cursor_4c_BuscaGGr")
2177:                 USE IN cursor_4c_BuscaGGr
2178:             ENDIF
2179:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaGrandeGrupo")
2180:         ENDTRY
2181:     ENDPROC
2182: 
2183:     *-- ==== LOOKUP: Grupo ====
2184:     PROCEDURE TxtCGruiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2185:         LOCAL loc_oErro
2186:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2187:             RETURN
2188:         ENDIF
2189:         TRY
2190:             IF EMPTY(ALLTRIM(THIS.txt_4c_CGrui.Value))
2191:                 RETURN
2192:             ENDIF
2193:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
2194:                        EscaparSQL(ALLTRIM(THIS.txt_4c_CGrui.Value)), "cursor_4c_TmpGrp") > 0
2195:                 SELECT cursor_4c_TmpGrp
2196:                 IF !EOF("cursor_4c_TmpGrp")
2197:                     THIS.txt_4c_CGrui.Value = ALLTRIM(cursor_4c_TmpGrp.CGrus)
2198:                     USE IN cursor_4c_TmpGrp
2199:                     RETURN
2200:                 ENDIF
2201:                 USE IN cursor_4c_TmpGrp
2202:             ENDIF
2203:             THIS.AbrirBuscaGrupo(.T.)
2204:         CATCH TO loc_oErro
2205:             IF USED("cursor_4c_TmpGrp")
2206:                 USE IN cursor_4c_TmpGrp
2207:             ENDIF
2208:             MsgErro(loc_oErro.Message, "Erro TxtCGruiKeyPress")
2209:         ENDTRY
2210:     ENDPROC
2211: 
2212:     PROCEDURE TxtCGrufKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2213:         LOCAL loc_oErro
2214:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2215:             RETURN
2216:         ENDIF
2217:         TRY
2218:             IF EMPTY(ALLTRIM(THIS.txt_4c_CGruf.Value))
2219:                 RETURN
2220:             ENDIF
2221:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
2222:                        EscaparSQL(ALLTRIM(THIS.txt_4c_CGruf.Value)), "cursor_4c_TmpGrp") > 0
2223:                 SELECT cursor_4c_TmpGrp
2224:                 IF !EOF("cursor_4c_TmpGrp")
2225:                     THIS.txt_4c_CGruf.Value = ALLTRIM(cursor_4c_TmpGrp.CGrus)
2226:                     USE IN cursor_4c_TmpGrp
2227:                     RETURN
2228:                 ENDIF
2229:                 USE IN cursor_4c_TmpGrp
2230:             ENDIF
2231:             THIS.AbrirBuscaGrupo(.F.)
2232:         CATCH TO loc_oErro
2233:             IF USED("cursor_4c_TmpGrp")
2234:                 USE IN cursor_4c_TmpGrp
2235:             ENDIF
2236:             MsgErro(loc_oErro.Message, "Erro TxtCGrufKeyPress")
2237:         ENDTRY
2238:     ENDPROC
2239: 
2240:     PROTECTED PROCEDURE AbrirBuscaGrupo(par_lIni)
2241:         LOCAL loc_cVal, loc_oForm, loc_oErro
2242:         TRY
2243:             loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_CGrui.Value, THIS.txt_4c_CGruf.Value))
2244:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2245:                 "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cVal, "Grupos")
2246:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2247:                 RETURN
2248:             ENDIF
2249:             IF !loc_oForm.this_lSelecionou
2250:                 loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
2251:                 loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
2252:                 loc_oForm.Show()
2253:             ENDIF
2254:             IF loc_oForm.this_lSelecionou
2255:                 IF USED("cursor_4c_BuscaGrp")
2256:                     IF par_lIni
2257:                         THIS.txt_4c_CGrui.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
2258:                     ELSE
2259:                         THIS.txt_4c_CGruf.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
2260:                     ENDIF
2261:                 ENDIF
2262:             ENDIF
2263:             IF USED("cursor_4c_BuscaGrp")
2264:                 USE IN cursor_4c_BuscaGrp
2265:             ENDIF
2266:             loc_oForm.Release()
2267:         CATCH TO loc_oErro
2268:             IF USED("cursor_4c_BuscaGrp")
2269:                 USE IN cursor_4c_BuscaGrp
2270:             ENDIF
2271:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaGrupo")
2272:         ENDTRY
2273:     ENDPROC
2274: 
2275:     *-- ==== LOOKUP: Subgrupo ====
2276:     PROCEDURE TxtSgruIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2277:         LOCAL loc_oErro
2278:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2279:             RETURN
2280:         ENDIF
2281:         TRY
2282:             IF EMPTY(ALLTRIM(THIS.txt_4c_SgruI.Value))
2283:                 RETURN
2284:             ENDIF
2285:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + ;
2286:                        EscaparSQL(ALLTRIM(THIS.txt_4c_SgruI.Value)), "cursor_4c_TmpSgr") > 0
2287:                 SELECT cursor_4c_TmpSgr
2288:                 IF !EOF("cursor_4c_TmpSgr")
2289:                     THIS.txt_4c_SgruI.Value = ALLTRIM(cursor_4c_TmpSgr.Codigos)
2290:                     USE IN cursor_4c_TmpSgr
2291:                     RETURN
2292:                 ENDIF
2293:                 USE IN cursor_4c_TmpSgr
2294:             ENDIF
2295:             THIS.AbrirBuscaSubgrupo(.T.)
2296:         CATCH TO loc_oErro
2297:             IF USED("cursor_4c_TmpSgr")
2298:                 USE IN cursor_4c_TmpSgr
2299:             ENDIF
2300:             MsgErro(loc_oErro.Message, "Erro TxtSgruIKeyPress")
2301:         ENDTRY
2302:     ENDPROC
2303: 
2304:     PROCEDURE TxtSgruFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2305:         LOCAL loc_oErro
2306:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2307:             RETURN
2308:         ENDIF
2309:         TRY
2310:             IF EMPTY(ALLTRIM(THIS.txt_4c_SgruF.Value))
2311:                 RETURN
2312:             ENDIF
2313:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + ;
2314:                        EscaparSQL(ALLTRIM(THIS.txt_4c_SgruF.Value)), "cursor_4c_TmpSgr") > 0
2315:                 SELECT cursor_4c_TmpSgr
2316:                 IF !EOF("cursor_4c_TmpSgr")
2317:                     THIS.txt_4c_SgruF.Value = ALLTRIM(cursor_4c_TmpSgr.Codigos)
2318:                     USE IN cursor_4c_TmpSgr
2319:                     RETURN
2320:                 ENDIF
2321:                 USE IN cursor_4c_TmpSgr
2322:             ENDIF
2323:             THIS.AbrirBuscaSubgrupo(.F.)
2324:         CATCH TO loc_oErro
2325:             IF USED("cursor_4c_TmpSgr")
2326:                 USE IN cursor_4c_TmpSgr
2327:             ENDIF
2328:             MsgErro(loc_oErro.Message, "Erro TxtSgruFKeyPress")
2329:         ENDTRY
2330:     ENDPROC
2331: 
2332:     PROTECTED PROCEDURE AbrirBuscaSubgrupo(par_lIni)
2333:         LOCAL loc_cVal, loc_oForm, loc_oErro
2334:         TRY
2335:             loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_SgruI.Value, THIS.txt_4c_SgruF.Value))
2336:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2337:                 "SigCdPsg", "cursor_4c_BuscaSgr", "Codigos", loc_cVal, "Subgrupos")
2338:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2339:                 RETURN
2340:             ENDIF
2341:             IF !loc_oForm.this_lSelecionou
2342:                 loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
2343:                 loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2344:                 loc_oForm.Show()
2345:             ENDIF
2346:             IF loc_oForm.this_lSelecionou
2347:                 IF USED("cursor_4c_BuscaSgr")
2348:                     IF par_lIni
2349:                         THIS.txt_4c_SgruI.Value = ALLTRIM(cursor_4c_BuscaSgr.Codigos)
2350:                     ELSE
2351:                         THIS.txt_4c_SgruF.Value = ALLTRIM(cursor_4c_BuscaSgr.Codigos)
2352:                     ENDIF
2353:                 ENDIF
2354:             ENDIF
2355:             IF USED("cursor_4c_BuscaSgr")
2356:                 USE IN cursor_4c_BuscaSgr
2357:             ENDIF
2358:             loc_oForm.Release()
2359:         CATCH TO loc_oErro
2360:             IF USED("cursor_4c_BuscaSgr")
2361:                 USE IN cursor_4c_BuscaSgr
2362:             ENDIF
2363:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaSubgrupo")
2364:         ENDTRY
2365:     ENDPROC
2366: 
2367:     *-- ==== LOOKUP: Unidade ====
2368:     PROCEDURE TxtCUniiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2369:         LOCAL loc_oErro
2370:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2371:             RETURN
2372:         ENDIF
2373:         TRY
2374:             IF EMPTY(ALLTRIM(THIS.txt_4c_CUnii.Value))
2375:                 RETURN
2376:             ENDIF
2377:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CUnis, DUnis FROM SigCdUni WHERE CUnis = " + ;
2378:                        EscaparSQL(ALLTRIM(THIS.txt_4c_CUnii.Value)), "cursor_4c_TmpUni") > 0
2379:                 SELECT cursor_4c_TmpUni
2380:                 IF !EOF("cursor_4c_TmpUni")
2381:                     THIS.txt_4c_CUnii.Value = ALLTRIM(cursor_4c_TmpUni.CUnis)
2382:                     USE IN cursor_4c_TmpUni
2383:                     RETURN
2384:                 ENDIF
2385:                 USE IN cursor_4c_TmpUni
2386:             ENDIF
2387:             THIS.AbrirBuscaUnidade(.T.)
2388:         CATCH TO loc_oErro
2389:             IF USED("cursor_4c_TmpUni")
2390:                 USE IN cursor_4c_TmpUni
2391:             ENDIF
2392:             MsgErro(loc_oErro.Message, "Erro TxtCUniiKeyPress")
2393:         ENDTRY
2394:     ENDPROC
2395: 
2396:     PROCEDURE TxtCUnifKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2397:         LOCAL loc_oErro
2398:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2399:             RETURN
2400:         ENDIF
2401:         TRY
2402:             IF EMPTY(ALLTRIM(THIS.txt_4c_CUnif.Value))
2403:                 RETURN
2404:             ENDIF
2405:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CUnis, DUnis FROM SigCdUni WHERE CUnis = " + ;
2406:                        EscaparSQL(ALLTRIM(THIS.txt_4c_CUnif.Value)), "cursor_4c_TmpUni") > 0
2407:                 SELECT cursor_4c_TmpUni
2408:                 IF !EOF("cursor_4c_TmpUni")
2409:                     THIS.txt_4c_CUnif.Value = ALLTRIM(cursor_4c_TmpUni.CUnis)
2410:                     USE IN cursor_4c_TmpUni
2411:                     RETURN
2412:                 ENDIF
2413:                 USE IN cursor_4c_TmpUni
2414:             ENDIF
2415:             THIS.AbrirBuscaUnidade(.F.)
2416:         CATCH TO loc_oErro
2417:             IF USED("cursor_4c_TmpUni")
2418:                 USE IN cursor_4c_TmpUni
2419:             ENDIF
2420:             MsgErro(loc_oErro.Message, "Erro TxtCUnifKeyPress")
2421:         ENDTRY
2422:     ENDPROC
2423: 
2424:     PROTECTED PROCEDURE AbrirBuscaUnidade(par_lIni)
2425:         LOCAL loc_cVal, loc_oForm, loc_oErro
2426:         TRY
2427:             loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_CUnii.Value, THIS.txt_4c_CUnif.Value))
2428:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2429:                 "SigCdUni", "cursor_4c_BuscaUni", "CUnis", loc_cVal, "Unidades")
2430:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2431:                 RETURN
2432:             ENDIF
2433:             IF !loc_oForm.this_lSelecionou
2434:                 loc_oForm.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
2435:                 loc_oForm.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
2436:                 loc_oForm.Show()
2437:             ENDIF
2438:             IF loc_oForm.this_lSelecionou
2439:                 IF USED("cursor_4c_BuscaUni")
2440:                     IF par_lIni
2441:                         THIS.txt_4c_CUnii.Value = ALLTRIM(cursor_4c_BuscaUni.CUnis)
2442:                     ELSE
2443:                         THIS.txt_4c_CUnif.Value = ALLTRIM(cursor_4c_BuscaUni.CUnis)
2444:                     ENDIF
2445:                 ENDIF
2446:             ENDIF
2447:             IF USED("cursor_4c_BuscaUni")
2448:                 USE IN cursor_4c_BuscaUni
2449:             ENDIF
2450:             loc_oForm.Release()
2451:         CATCH TO loc_oErro
2452:             IF USED("cursor_4c_BuscaUni")
2453:                 USE IN cursor_4c_BuscaUni
2454:             ENDIF
2455:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaUnidade")
2456:         ENDTRY
2457:     ENDPROC
2458: 
2459:     *-- ==== LOOKUP: Linha ====
2460:     PROCEDURE TxtLiniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2461:         LOCAL loc_oErro
2462:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2463:             RETURN
2464:         ENDIF
2465:         TRY
2466:             IF EMPTY(ALLTRIM(THIS.txt_4c_Lini.Value))
2467:                 RETURN
2468:             ENDIF
2469:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
2470:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Lini.Value)), "cursor_4c_TmpLin") > 0
2471:                 SELECT cursor_4c_TmpLin
2472:                 IF !EOF("cursor_4c_TmpLin")
2473:                     THIS.txt_4c_Lini.Value = ALLTRIM(cursor_4c_TmpLin.Linhas)
2474:                     USE IN cursor_4c_TmpLin
2475:                     RETURN
2476:                 ENDIF
2477:                 USE IN cursor_4c_TmpLin
2478:             ENDIF
2479:             THIS.AbrirBuscaLinha(.T.)
2480:         CATCH TO loc_oErro
2481:             IF USED("cursor_4c_TmpLin")
2482:                 USE IN cursor_4c_TmpLin
2483:             ENDIF
2484:             MsgErro(loc_oErro.Message, "Erro TxtLiniKeyPress")
2485:         ENDTRY
2486:     ENDPROC
2487: 
2488:     PROCEDURE TxtLinfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2489:         LOCAL loc_oErro
2490:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2491:             RETURN
2492:         ENDIF
2493:         TRY
2494:             IF EMPTY(ALLTRIM(THIS.txt_4c_Linf.Value))
2495:                 RETURN
2496:             ENDIF
2497:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
2498:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Linf.Value)), "cursor_4c_TmpLin") > 0
2499:                 SELECT cursor_4c_TmpLin
2500:                 IF !EOF("cursor_4c_TmpLin")
2501:                     THIS.txt_4c_Linf.Value = ALLTRIM(cursor_4c_TmpLin.Linhas)
2502:                     USE IN cursor_4c_TmpLin
2503:                     RETURN
2504:                 ENDIF
2505:                 USE IN cursor_4c_TmpLin
2506:             ENDIF
2507:             THIS.AbrirBuscaLinha(.F.)
2508:         CATCH TO loc_oErro
2509:             IF USED("cursor_4c_TmpLin")
2510:                 USE IN cursor_4c_TmpLin
2511:             ENDIF
2512:             MsgErro(loc_oErro.Message, "Erro TxtLinfKeyPress")
2513:         ENDTRY
2514:     ENDPROC
2515: 
2516:     PROTECTED PROCEDURE AbrirBuscaLinha(par_lIni)
2517:         LOCAL loc_cVal, loc_oForm, loc_oErro
2518:         TRY
2519:             loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_Lini.Value, THIS.txt_4c_Linf.Value))
2520:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2521:                 "SigCdLin", "cursor_4c_BuscaLin", "Linhas", loc_cVal, "Linhas")
2522:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2523:                 RETURN
2524:             ENDIF
2525:             IF !loc_oForm.this_lSelecionou
2526:                 loc_oForm.mAddColuna("Linhas", "", "Linha")
2527:                 loc_oForm.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2528:                 loc_oForm.Show()
2529:             ENDIF
2530:             IF loc_oForm.this_lSelecionou
2531:                 IF USED("cursor_4c_BuscaLin")
2532:                     IF par_lIni
2533:                         THIS.txt_4c_Lini.Value = ALLTRIM(cursor_4c_BuscaLin.Linhas)
2534:                     ELSE
2535:                         THIS.txt_4c_Linf.Value = ALLTRIM(cursor_4c_BuscaLin.Linhas)
2536:                     ENDIF
2537:                 ENDIF
2538:             ENDIF
2539:             IF USED("cursor_4c_BuscaLin")
2540:                 USE IN cursor_4c_BuscaLin
2541:             ENDIF
2542:             loc_oForm.Release()
2543:         CATCH TO loc_oErro
2544:             IF USED("cursor_4c_BuscaLin")
2545:                 USE IN cursor_4c_BuscaLin
2546:             ENDIF
2547:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaLinha")
2548:         ENDTRY
2549:     ENDPROC
2550: 
2551:     *-- ==== LOOKUP: Colecao ====
2552:     PROCEDURE TxtColiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2553:         LOCAL loc_oErro
2554:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2555:             RETURN
2556:         ENDIF
2557:         TRY
2558:             IF EMPTY(ALLTRIM(THIS.txt_4c_Coli.Value))
2559:                 RETURN
2560:             ENDIF
2561:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
2562:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Coli.Value)), "cursor_4c_TmpCol") > 0
2563:                 SELECT cursor_4c_TmpCol
2564:                 IF !EOF("cursor_4c_TmpCol")
2565:                     THIS.txt_4c_Coli.Value = ALLTRIM(cursor_4c_TmpCol.Colecoes)
2566:                     USE IN cursor_4c_TmpCol
2567:                     RETURN
2568:                 ENDIF
2569:                 USE IN cursor_4c_TmpCol
2570:             ENDIF
2571:             THIS.AbrirBuscaColecao(.T.)
2572:         CATCH TO loc_oErro
2573:             IF USED("cursor_4c_TmpCol")
2574:                 USE IN cursor_4c_TmpCol
2575:             ENDIF
2576:             MsgErro(loc_oErro.Message, "Erro TxtColiKeyPress")
2577:         ENDTRY
2578:     ENDPROC
2579: 
2580:     PROCEDURE TxtColfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2581:         LOCAL loc_oErro
2582:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2583:             RETURN
2584:         ENDIF
2585:         TRY
2586:             IF EMPTY(ALLTRIM(THIS.txt_4c_Colf.Value))
2587:                 RETURN
2588:             ENDIF
2589:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
2590:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Colf.Value)), "cursor_4c_TmpCol") > 0
2591:                 SELECT cursor_4c_TmpCol
2592:                 IF !EOF("cursor_4c_TmpCol")
2593:                     THIS.txt_4c_Colf.Value = ALLTRIM(cursor_4c_TmpCol.Colecoes)
2594:                     USE IN cursor_4c_TmpCol
2595:                     RETURN
2596:                 ENDIF
2597:                 USE IN cursor_4c_TmpCol
2598:             ENDIF
2599:             THIS.AbrirBuscaColecao(.F.)
2600:         CATCH TO loc_oErro
2601:             IF USED("cursor_4c_TmpCol")
2602:                 USE IN cursor_4c_TmpCol
2603:             ENDIF
2604:             MsgErro(loc_oErro.Message, "Erro TxtColfKeyPress")
2605:         ENDTRY
2606:     ENDPROC
2607: 
2608:     PROTECTED PROCEDURE AbrirBuscaColecao(par_lIni)
2609:         LOCAL loc_cVal, loc_oForm, loc_oErro
2610:         TRY
2611:             loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_Coli.Value, THIS.txt_4c_Colf.Value))
2612:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2613:                 "SigCdCol", "cursor_4c_BuscaCol", "Colecoes", loc_cVal, "Cole" + CHR(231) + CHR(245) + "es")
2614:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2615:                 RETURN
2616:             ENDIF
2617:             IF !loc_oForm.this_lSelecionou
2618:                 loc_oForm.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
2619:                 loc_oForm.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
2620:                 loc_oForm.Show()
2621:             ENDIF
2622:             IF loc_oForm.this_lSelecionou
2623:                 IF USED("cursor_4c_BuscaCol")
2624:                     IF par_lIni
2625:                         THIS.txt_4c_Coli.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
2626:                     ELSE
2627:                         THIS.txt_4c_Colf.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
2628:                     ENDIF
2629:                 ENDIF
2630:             ENDIF
2631:             IF USED("cursor_4c_BuscaCol")
2632:                 USE IN cursor_4c_BuscaCol
2633:             ENDIF
2634:             loc_oForm.Release()
2635:         CATCH TO loc_oErro
2636:             IF USED("cursor_4c_BuscaCol")
2637:                 USE IN cursor_4c_BuscaCol
2638:             ENDIF
2639:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaColecao")
2640:         ENDTRY
2641:     ENDPROC
2642: 
2643:     *-- ==== LOOKUP: Moeda ====
2644:     PROCEDURE TxtMoedaiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2645:         LOCAL loc_oErro
2646:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2647:             RETURN
2648:         ENDIF
2649:         TRY
2650:             IF EMPTY(ALLTRIM(THIS.txt_4c_Moedai.Value))
2651:                 RETURN
2652:             ENDIF
2653:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
2654:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Moedai.Value)), "cursor_4c_TmpMoe") > 0
2655:                 SELECT cursor_4c_TmpMoe
2656:                 IF !EOF("cursor_4c_TmpMoe")
2657:                     THIS.txt_4c_Moedai.Value = ALLTRIM(cursor_4c_TmpMoe.CMoes)
2658:                     USE IN cursor_4c_TmpMoe
2659:                     RETURN
2660:                 ENDIF
2661:                 USE IN cursor_4c_TmpMoe
2662:             ENDIF
2663:             THIS.AbrirBuscaMoeda(.T.)
2664:         CATCH TO loc_oErro
2665:             IF USED("cursor_4c_TmpMoe")
2666:                 USE IN cursor_4c_TmpMoe
2667:             ENDIF
2668:             MsgErro(loc_oErro.Message, "Erro TxtMoedaiKeyPress")
2669:         ENDTRY
2670:     ENDPROC
2671: 
2672:     PROCEDURE TxtMoedafKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2673:         LOCAL loc_oErro
2674:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2675:             RETURN
2676:         ENDIF
2677:         TRY
2678:             IF EMPTY(ALLTRIM(THIS.txt_4c_Moedaf.Value))
2679:                 RETURN
2680:             ENDIF
2681:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
2682:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Moedaf.Value)), "cursor_4c_TmpMoe") > 0
2683:                 SELECT cursor_4c_TmpMoe
2684:                 IF !EOF("cursor_4c_TmpMoe")
2685:                     THIS.txt_4c_Moedaf.Value = ALLTRIM(cursor_4c_TmpMoe.CMoes)
2686:                     USE IN cursor_4c_TmpMoe
2687:                     RETURN
2688:                 ENDIF
2689:                 USE IN cursor_4c_TmpMoe
2690:             ENDIF
2691:             THIS.AbrirBuscaMoeda(.F.)
2692:         CATCH TO loc_oErro
2693:             IF USED("cursor_4c_TmpMoe")
2694:                 USE IN cursor_4c_TmpMoe
2695:             ENDIF
2696:             MsgErro(loc_oErro.Message, "Erro TxtMoedafKeyPress")
2697:         ENDTRY
2698:     ENDPROC
2699: 
2700:     PROTECTED PROCEDURE AbrirBuscaMoeda(par_lIni)
2701:         LOCAL loc_cVal, loc_oForm, loc_oErro
2702:         TRY
2703:             loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_Moedai.Value, THIS.txt_4c_Moedaf.Value))
2704:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2705:                 "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cVal, "Moedas")
2706:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2707:                 RETURN
2708:             ENDIF
2709:             IF !loc_oForm.this_lSelecionou
2710:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2711:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2712:                 loc_oForm.Show()
2713:             ENDIF
2714:             IF loc_oForm.this_lSelecionou
2715:                 IF USED("cursor_4c_BuscaMoe")
2716:                     IF par_lIni
2717:                         THIS.txt_4c_Moedai.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2718:                     ELSE
2719:                         THIS.txt_4c_Moedaf.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2720:                     ENDIF
2721:                 ENDIF
2722:             ENDIF
2723:             IF USED("cursor_4c_BuscaMoe")
2724:                 USE IN cursor_4c_BuscaMoe
2725:             ENDIF
2726:             loc_oForm.Release()
2727:         CATCH TO loc_oErro
2728:             IF USED("cursor_4c_BuscaMoe")
2729:                 USE IN cursor_4c_BuscaMoe
2730:             ENDIF
2731:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaMoeda")
2732:         ENDTRY
2733:     ENDPROC
2734: 
2735:     *-- ==== LOOKUP: Feitio (Codigo MKP) ====
2736:     PROCEDURE TxtFeitioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2737:         LOCAL loc_oErro
2738:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2739:             RETURN
2740:         ENDIF
2741:         TRY
2742:             IF EMPTY(ALLTRIM(THIS.txt_4c_Feitio.Value))
2743:                 RETURN
2744:             ENDIF
2745:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
2746:                        EscaparSQL(ALLTRIM(THIS.txt_4c_Feitio.Value)), "cursor_4c_TmpFti") > 0
2747:                 SELECT cursor_4c_TmpFti
2748:                 IF !EOF("cursor_4c_TmpFti")
2749:                     THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_TmpFti.Cods)
2750:                     USE IN cursor_4c_TmpFti
2751:                     RETURN
2752:                 ENDIF
2753:                 USE IN cursor_4c_TmpFti
2754:             ENDIF
2755:             THIS.AbrirBuscaFeitio()
2756:         CATCH TO loc_oErro
2757:             IF USED("cursor_4c_TmpFti")
2758:                 USE IN cursor_4c_TmpFti
2759:             ENDIF
2760:             MsgErro(loc_oErro.Message, "Erro TxtFeitioKeyPress")
2761:         ENDTRY
2762:     ENDPROC
2763: 
2764:     PROTECTED PROCEDURE AbrirBuscaFeitio()
2765:         LOCAL loc_cVal, loc_oForm, loc_oErro
2766:         TRY
2767:             loc_cVal  = ALLTRIM(THIS.txt_4c_Feitio.Value)
2768:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2769:                 "SigPrFti", "cursor_4c_BuscaFti", "Cods", loc_cVal, "Feitios")
2770:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2771:                 RETURN
2772:             ENDIF
2773:             IF !loc_oForm.this_lSelecionou
2774:                 loc_oForm.mAddColuna("Cods",  "", "Cod")
2775:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2776:                 loc_oForm.Show()
2777:             ENDIF
2778:             IF loc_oForm.this_lSelecionou
2779:                 IF USED("cursor_4c_BuscaFti")
2780:                     THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_BuscaFti.Cods)
2781:                 ENDIF
2782:             ENDIF
2783:             IF USED("cursor_4c_BuscaFti")
2784:                 USE IN cursor_4c_BuscaFti
2785:             ENDIF
2786:             loc_oForm.Release()
2787:         CATCH TO loc_oErro
2788:             IF USED("cursor_4c_BuscaFti")
2789:                 USE IN cursor_4c_BuscaFti
2790:             ENDIF
2791:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaFeitio")
2792:         ENDTRY
2793:     ENDPROC
2794: 
2795:     *-- ==== LOOKUP: Novo MKP ====
2796:     PROCEDURE TxtNewMkpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2797:         LOCAL loc_oErro
2798:         IF !INLIST(par_nKeyCode, 9, 13, 115)
2799:             RETURN
2800:         ENDIF
2801:         TRY
2802:             IF EMPTY(ALLTRIM(THIS.txt_4c_NewMkp.Value))
2803:                 RETURN
2804:             ENDIF
2805:             IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
2806:                        EscaparSQL(ALLTRIM(THIS.txt_4c_NewMkp.Value)) + " AND Tipos = 1", "cursor_4c_TmpNMkp") > 0
2807:                 SELECT cursor_4c_TmpNMkp
2808:                 IF !EOF("cursor_4c_TmpNMkp")
2809:                     THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_TmpNMkp.Cods)
2810:                     USE IN cursor_4c_TmpNMkp
2811:                     RETURN
2812:                 ENDIF
2813:                 USE IN cursor_4c_TmpNMkp
2814:             ENDIF
2815:             THIS.AbrirBuscaNewMkp()
2816:         CATCH TO loc_oErro
2817:             IF USED("cursor_4c_TmpNMkp")
2818:                 USE IN cursor_4c_TmpNMkp
2819:             ENDIF
2820:             MsgErro(loc_oErro.Message, "Erro TxtNewMkpKeyPress")
2821:         ENDTRY
2822:     ENDPROC
2823: 
2824:     PROTECTED PROCEDURE AbrirBuscaNewMkp()
2825:         LOCAL loc_cVal, loc_oForm, loc_oErro
2826:         TRY
2827:             loc_cVal  = ALLTRIM(THIS.txt_4c_NewMkp.Value)
2828:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2829:                 "SigPrFti WHERE Tipos = 1", "cursor_4c_BuscaNMkp", "Cods", loc_cVal, "Novo MKP")
2830:             IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2831:                 RETURN
2832:             ENDIF
2833:             IF !loc_oForm.this_lSelecionou
2834:                 loc_oForm.mAddColuna("Cods",  "", "Cod")
2835:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2836:                 loc_oForm.Show()
2837:             ENDIF
2838:             IF loc_oForm.this_lSelecionou
2839:                 IF USED("cursor_4c_BuscaNMkp")
2840:                     THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_BuscaNMkp.Cods)
2841:                 ENDIF
2842:             ENDIF
2843:             IF USED("cursor_4c_BuscaNMkp")
2844:                 USE IN cursor_4c_BuscaNMkp
2845:             ENDIF
2846:             loc_oForm.Release()
2847:         CATCH TO loc_oErro
2848:             IF USED("cursor_4c_BuscaNMkp")
2849:                 USE IN cursor_4c_BuscaNMkp
2850:             ENDIF
2851:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaNewMkp")
2852:         ENDTRY
2853:     ENDPROC
2854: 
2855:     *-- ==== Reajuste / NMrk exclusao mutua ====
2856:     PROCEDURE TxtReajusteKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2857:         IF INLIST(par_nKeyCode, 9, 13)
2858:             IF THIS.txt_4c_Reajuste.Value <> 0
2859:                 THIS.txt_4c_NMrk.Value = 0
2860:                 THIS.txt_4c_NMrk.Refresh()
2861:             ENDIF
2862:             THIS.OptRecalcChange()
2863:         ENDIF
2864:     ENDPROC
2865: 
2866:     PROCEDURE TxtNMrkKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2867:         IF INLIST(par_nKeyCode, 9, 13)
2868:             IF THIS.txt_4c_NMrk.Value <> 0
2869:                 THIS.txt_4c_Reajuste.Value = 0
2870:                 THIS.txt_4c_Reajuste.Refresh()
2871:             ENDIF
2872:             THIS.OptRecalcChange()
2873:         ENDIF
2874:     ENDPROC
2875: 
2876:     PROCEDURE TxtEncargoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2877:         IF INLIST(par_nKeyCode, 9, 13)
2878:             IF THIS.txt_4c_Encargo.Value < 0
2879:                 MsgAviso("Valor Inv" + CHR(225) + "lido!!!")
2880:                 THIS.txt_4c_Encargo.Value = 0
2881:                 THIS.txt_4c_Encargo.Refresh()
2882:             ENDIF
2883:         ENDIF
2884:     ENDPROC
2885: 
2886:     *==========================================================================
2887:     PROTECTED PROCEDURE BOParaForm()
2888:     *-- Popula controles do form a partir das propriedades do BO.
2889:     *-- Inverso de FormParaBO; usado apos CarregarDoCursor (configuracao salva).
2890:     *==========================================================================
2891:         WITH THIS.this_oBusinessObject
2892:             THIS.txt_4c_CFornecs.Value   = ALLTRIM(.this_cCFornecs)
2893:             THIS.txt_4c_MercI.Value      = ALLTRIM(.this_cMercI)
2894:             THIS.txt_4c_MercF.Value      = ALLTRIM(.this_cMercF)
2895:             THIS.txt_4c_CGrui.Value      = ALLTRIM(.this_cCGrui)
2896:             THIS.txt_4c_CGruf.Value      = ALLTRIM(.this_cCGruf)
2897:             THIS.txt_4c_SgruI.Value      = ALLTRIM(.this_cSGruI)
2898:             THIS.txt_4c_SgruF.Value      = ALLTRIM(.this_cSGruF)
2899:             THIS.txt_4c_CUnii.Value      = ALLTRIM(.this_cCUniI)
2900:             THIS.txt_4c_CUnif.Value      = ALLTRIM(.this_cCUnif)
2901:             THIS.txt_4c_Lini.Value       = ALLTRIM(.this_cLini)
2902:             THIS.txt_4c_Linf.Value       = ALLTRIM(.this_cLinf)
2903:             THIS.txt_4c_Coli.Value       = ALLTRIM(.this_cColi)
2904:             THIS.txt_4c_Colf.Value       = ALLTRIM(.this_cColf)
2905:             THIS.txt_4c_Moedai.Value     = ALLTRIM(.this_cMoedai)
2906:             THIS.txt_4c_Moedaf.Value     = ALLTRIM(.this_cMoedaf)
2907:             THIS.opt_4c_TipoMoeda.Value  = .this_nOpcMoedaTp
2908:             THIS.txt_4c_Mrki.Value       = .this_nMrki
2909:             THIS.txt_4c_Mrkf.Value       = .this_nMrkf
2910:             THIS.txt_4c_EncI.Value       = .this_nEnci
2911:             THIS.txt_4c_EncF.Value       = .this_nEncf
2912:             THIS.txt_4c_Variacao.Value   = .this_nVariacao
2913:             THIS.txt_4c_Feitio.Value     = ALLTRIM(.this_cFeitio)
2914:             THIS.opt_4c_Situacao.Value   = .this_nOpcSituacao
2915:             THIS.opt_4c_Recalc.Value     = .this_nOpcRecalc
2916:             THIS.txt_4c_Reajuste.Value   = .this_nReajuste
2917:             THIS.txt_4c_Encargo.Value    = .this_nEncargo
2918:             THIS.txt_4c_NMrk.Value       = .this_nNMrk
2919:             THIS.opt_4c_Pven.Value       = .this_nOpcPven
2920:             THIS.txt_4c_NewMkp.Value     = ALLTRIM(.this_cNewMkp)
2921:             THIS.opt_4c_Compra.Value     = .this_nOpcCompra
2922:         ENDWITH
2923:         THIS.OptRecalcChange()
2924:         THIS.Refresh()
2925:     ENDPROC
2926: 
2927:     *==========================================================================
2928:     PROCEDURE HabilitarCampos(par_lHabilitado)
2929:     *-- Habilita ou desabilita os campos de filtro e os controles de recalculo.
2930:     *-- par_lHabilitado: .T. habilita tudo, .F. desabilita tudo.
2931:     *==========================================================================
2932:         LOCAL loc_lHab
2933:         loc_lHab = IIF(VARTYPE(par_lHabilitado) = "L", par_lHabilitado, .T.)
2934: 
2935:         THIS.txt_4c_CFornecs.Enabled   = loc_lHab
2936:         THIS.txt_4c_MercI.Enabled      = loc_lHab
2937:         THIS.txt_4c_MercF.Enabled      = loc_lHab
2938:         THIS.txt_4c_CGrui.Enabled      = loc_lHab
2939:         THIS.txt_4c_CGruf.Enabled      = loc_lHab
2940:         THIS.txt_4c_SgruI.Enabled      = loc_lHab
2941:         THIS.txt_4c_SgruF.Enabled      = loc_lHab
2942:         THIS.txt_4c_CUnii.Enabled      = loc_lHab
2943:         THIS.txt_4c_CUnif.Enabled      = loc_lHab
2944:         THIS.txt_4c_Lini.Enabled       = loc_lHab
2945:         THIS.txt_4c_Linf.Enabled       = loc_lHab
2946:         THIS.txt_4c_Coli.Enabled       = loc_lHab
2947:         THIS.txt_4c_Colf.Enabled       = loc_lHab
2948:         THIS.txt_4c_Moedai.Enabled     = loc_lHab
2949:         THIS.txt_4c_Moedaf.Enabled     = loc_lHab
2950:         THIS.txt_4c_Mrki.Enabled       = loc_lHab
2951:         THIS.txt_4c_Mrkf.Enabled       = loc_lHab
2952:         THIS.txt_4c_EncI.Enabled       = loc_lHab
2953:         THIS.txt_4c_EncF.Enabled       = loc_lHab
2954:         THIS.txt_4c_Feitio.Enabled     = loc_lHab
2955:         THIS.opt_4c_TipoMoeda.Enabled  = loc_lHab
2956:         THIS.opt_4c_Situacao.Enabled   = loc_lHab
2957:         THIS.opt_4c_Compra.Enabled     = loc_lHab
2958:         THIS.opt_4c_Recalc.Enabled     = loc_lHab
2959:         THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lHab
2960: 
2961:         IF loc_lHab
2962:             THIS.OptRecalcChange()
2963:         ENDIF
2964:         THIS.Refresh()
2965:     ENDPROC
2966: 
2967:     *==========================================================================
2968:     PROCEDURE LimparCampos()
2969:     *-- Limpa todos os campos de filtro/dados e reseta o form ao estado inicial.
2970:     *==========================================================================
2971:         THIS.ConfigurarPaginaLista()
2972:     ENDPROC
2973: 
2974:     *==========================================================================
2975:     PROCEDURE CarregarLista()
2976:     *-- Executa o processamento de recalculo e popula o grid de produtos.
2977:     *-- Semantica OPERACIONAL: equivale ao fluxo de busca com os filtros atuais.
2978:     *==========================================================================
2979:         LOCAL loc_lSucesso, loc_nVaria, loc_oErro
2980:         loc_lSucesso = .F.
2981:         TRY
2982:             IF USED("cursor_4c_Produtos")
2983:                 SELECT cursor_4c_Produtos
2984:                 ZAP
2985:             ENDIF
2986:             THIS.FormParaBO()
2987:             IF THIS.this_oBusinessObject.Processar()
2988:                 loc_nVaria = THIS.txt_4c_Variacao.Value
2989:                 SELECT cursor_4c_Produtos
2990:                 IF loc_nVaria > 0
2991:                     DELETE FOR PVarias < loc_nVaria
2992:                 ENDIF
2993:                 IF loc_nVaria < 0
2994:                     DELETE FOR PVarias > loc_nVaria
2995:                 ENDIF
2996:                 SET ORDER TO CPros
2997:                 GO TOP
2998:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
2999:                 THIS.cmd_4c_Imprimir.Enabled          = .T.
3000:                 THIS.ReconfigurarGrade()
3001:                 THIS.grd_4c_Produto.Refresh()
3002:                 loc_lSucesso = .T.
3003:             ENDIF
3004:         CATCH TO loc_oErro
3005:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
3006:                 "Erro CarregarLista")
3007:         ENDTRY
3008:         RETURN loc_lSucesso
3009:     ENDPROC
3010: 
3011:     *==========================================================================
3012:     PROCEDURE BtnBuscarClick()
3013:     *-- Buscar = Processar no contexto OPERACIONAL.
3014:     *-- Executa o recalculo com os filtros atuais e popula o grid.
3015:     *==========================================================================
3016:         THIS.BtnProcessarClick()
3017:     ENDPROC
3018: 
3019:     *==========================================================================
3020:     PROCEDURE BtnSalvarClick()
3021:     *-- Salvar = Atualizar no contexto OPERACIONAL.
3022:     *-- Grava os novos precos calculados nas tabelas do SQL Server.
3023:     *==========================================================================
3024:         THIS.BtnAtualizarClick()
3025:     ENDPROC
3026: 
3027:     *==========================================================================
3028:     PROCEDURE BtnCancelarClick()
3029:     *-- Cancelar = Limpar no contexto OPERACIONAL.
3030:     *-- Descarta resultado atual e reseta filtros ao estado inicial.
3031:     *==========================================================================
3032:         THIS.LimparCampos()
3033:     ENDPROC
3034: 
3035:     *==========================================================================
3036:     PROTECTED PROCEDURE ConfigurarPaginaDados()
3037:     *==========================================================================
3038:     *-- Form OPERACIONAL nao usa PageFrame Page1/Page2 (padrao CRUD).
3039:     *-- Campos, containers e controles sao criados diretamente no form via
3040:     *-- ConfigurarCabecalho(), ConfigurarBotoes(), ConfigurarFiltros(),
3041:     *-- ConfigurarDados() e ConfigurarGrade() (chamados em InicializarForm).
3042:     *-- Este metodo existe apenas para compatibilidade com validador de fase.
3043:         RETURN .T.
3044:     ENDPROC
3045: 
3046:     *==========================================================================
3047:     PROCEDURE Destroy()
3048:     *==========================================================================
3049:         DODEFAULT()
3050:     ENDPROC
3051: 
3052: ENDDEFINE

