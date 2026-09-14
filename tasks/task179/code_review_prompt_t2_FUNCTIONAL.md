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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1960 linhas total):

*-- Linhas 30 a 150:
30:     *==========================================================================
31:     * Init - Inicializa o formulario
32:     *==========================================================================
33:     PROCEDURE Init()
34:         RETURN DODEFAULT()
35:     ENDPROC
36: 
37:     *==========================================================================
38:     * InicializarForm - Configura estrutura completa (chamado por FormBase.Init)
39:     *==========================================================================
40:     PROTECTED PROCEDURE InicializarForm()
41:         LOCAL loc_lSucesso
42:         loc_lSucesso = .F.
43: 
44:         TRY
45:             THIS.this_oBusinessObject = CREATEOBJECT("sigpres2BO")
46: 
47:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
48:                 MostrarErro("Erro ao criar Business Object sigpres2BO." + CHR(13) + ;
49:                             "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
50:             ELSE
51:                 THIS.ConfigurarPageFrame()
52:                 THIS.ConfigurarPaginaLista()
53:                 THIS.ConfigurarPaginaDados()
54: 
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57: 
58:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
59:                     THIS.CarregarLista()
60:                 ENDIF
61: 
62:                 THIS.pgf_4c_Paginas.Visible = .T.
63:                 THIS.pgf_4c_Paginas.ActivePage = 1
64:                 THIS.this_cModoAtual = "LISTA"
65:                 loc_lSucesso = .T.
66:             ENDIF
67:         CATCH TO loException
68:             MostrarErro(loException, "Formsigpres2.InicializarForm")
69:         ENDTRY
70: 
71:         RETURN loc_lSucesso
72:     ENDPROC
73: 
74:     *==========================================================================
75:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas
76:     *==========================================================================
77:     PROTECTED PROCEDURE ConfigurarPageFrame()
78:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
79:         WITH THIS.pgf_4c_Paginas
80:             .PageCount = 2
81:             .Top       = -29
82:             .Left      = 0
83:             .Width     = THIS.Width
84:             .Height    = THIS.Height + 29
85:             .Tabs      = .F.
86:             .Visible   = .T.
87:             .Page1.Caption   = "Lista"
88:             .Page1.BackColor = RGB(100, 100, 100)
89:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
90:             .Page2.Caption   = "Dados"
91:             .Page2.BackColor = RGB(100, 100, 100)
92:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
93:         ENDWITH
94:     ENDPROC
95: 
96:     *==========================================================================
97:     * ConfigurarPaginaLista - Configura Page1 (lista de movimentos)
98:     *==========================================================================
99:     PROTECTED PROCEDURE ConfigurarPaginaLista()
100:         LOCAL loc_oPagina
101:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
102: 
103:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
104:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
105: 
106:         *-- Cabecalho (cntSombra: Top=2+29=31 compensacao PageFrame)
107:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
108:         WITH loc_oPagina.cnt_4c_Cabecalho
109:             .Top         = 31
110:             .Left        = 0
111:             .Width       = THIS.Width
112:             .Height      = 80
113:             .BackColor   = RGB(100, 100, 100)
114:             .BorderWidth = 0
115:             .Visible     = .T.
116:         ENDWITH
117: 
118:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
119:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
120:             .Caption   = THIS.Caption
121:             .Top       = 15
122:             .Left      = 10
123:             .Width     = THIS.Width - 20
124:             .Height    = 40
125:             .FontName  = "Tahoma"
126:             .FontSize  = 16
127:             .FontBold  = .T.
128:             .ForeColor = RGB(0, 0, 0)
129:             .BackStyle = 0
130:             .AutoSize  = .F.
131:             .Visible   = .T.
132:         ENDWITH
133: 
134:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
135:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
136:             .Caption   = THIS.Caption
137:             .Top       = 18
138:             .Left      = 10
139:             .Width     = THIS.Width - 20
140:             .Height    = 46
141:             .FontName  = "Tahoma"
142:             .FontSize  = 16
143:             .FontBold  = .T.
144:             .ForeColor = RGB(255, 255, 255)
145:             .BackStyle = 0
146:             .AutoSize  = .F.
147:             .Visible   = .T.
148:         ENDWITH
149: 
150:         *-- Container botao Consultar (Grupo_Op original: Width=10+80=90, apenas Consultar visivel)

*-- Linhas 245 a 301:
245:             .Visible            = .T.
246:         ENDWITH
247: 
248:         *-- BINDEVENTs dos botoes (metodos PUBLIC, sem PROTECTED)
249:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Consultar, "Click", ;
250:                   THIS, "BtnConsultarClick")
251:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", ;
252:                   THIS, "BtnEncerrarClick")
253: 
254:         THIS.TornarControlesVisiveis(loc_oPagina)
255:     ENDPROC
256: 
257:     *==========================================================================
258:     * ConfigurarPaginaDados - Configura Page2 (detalhe do movimento)
259:     * FASE 5: cabecalho, grid operacao, cmdEntrega, SubNiveis
260:     *==========================================================================
261:     PROTECTED PROCEDURE ConfigurarPaginaDados()
262:         LOCAL loc_oPagina
263:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
264: 
265:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
266:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
267: 
268:         *-- Container botoes acao (Grupo_Salva: top=4+29=33)
269:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
270:         WITH loc_oPagina.cnt_4c_BotoesAcao
271:             .Top         = 33
272:             .Left        = 842
273:             .Width       = 160
274:             .Height      = 85
275:             .BackStyle = 1
276:             .BackColor = RGB(255, 255, 255)
277:             .Visible     = .T.
278:         ENDWITH
279: 
280:         *-- Botao Confirmar (Salva/OK no CONSULTAR)
281:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
282:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
283:             .Caption         = "Confirmar"
284:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
285:             .PicturePosition = 13
286:             .Top             = 5
287:             .Left            = 5
288:             .Width           = 75
289:             .Height          = 75
290:             .BackColor       = RGB(255, 255, 255)
291:             .ForeColor       = RGB(90, 90, 90)
292:             .FontName        = "Tahoma"
293:             .FontSize        = 8
294:             .FontBold        = .T.
295:             .FontItalic      = .T.
296:             .Themes          = .F.
297:             .SpecialEffect   = 0
298:             .MousePointer    = 15
299:             .WordWrap        = .T.
300:             .AutoSize        = .F.
301:             .Visible         = .T.

*-- Linhas 1070 a 1135:
1070:             .Visible = .F.
1071:         ENDWITH
1072: 
1073:         *-- BINDEVENTs (metodos PUBLIC para funcionar com BINDEVENT)
1074:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", ;
1075:                   THIS, "BtnConfirmarClick")
1076:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", ;
1077:                   THIS, "BtnCancelarClick")
1078:         BINDEVENT(loc_oPagina.cmd_4c_Entrega, "Click", ;
1079:                   THIS, "BtnEntregaClick")
1080:         BINDEVENT(loc_oPagina.cmd_4c_SubNiveis, "Click", ;
1081:                   THIS, "BtnSubNiveisClick")
1082:         BINDEVENT(loc_oPagina.cnt_4c_Origem.cmd_4c_BtnCadastros, "Click", ;
1083:                   THIS, "BtnCadastrosClick")
1084:         BINDEVENT(loc_oPagina.grd_4c_Itens, "AfterRowColChange", ;
1085:                   THIS, "GrdItensAfterRowColChange")
1086:         BINDEVENT(loc_oPagina.img_4c_FigJpg, "Click", ;
1087:                   THIS, "ImgFigJpgClick")
1088: 
1089:         THIS.TornarControlesVisiveis(loc_oPagina)
1090:     ENDPROC
1091: 
1092:     *==========================================================================
1093:     * CarregarLista - Carrega movimentos do tipo this_cDopes
1094:     *==========================================================================
1095:     PROCEDURE CarregarLista()
1096:         LOCAL loc_lResultado, loc_oGrid
1097:         loc_lResultado = .F.
1098: 
1099:         TRY
1100:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1101:                 loc_lResultado = .T.
1102:             ELSE
1103:                 THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
1104: 
1105:                 IF THIS.this_oBusinessObject.Buscar("a.Dopes = " + EscaparSQL(THIS.this_cDopes))
1106:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1107: 
1108:                     IF VARTYPE(loc_oGrid) = "O"
1109:                         *-- RecordSource fora de WITH (Problem 36: evita "Unknown member COLUMN1")
1110:                         loc_oGrid.ColumnCount = 11
1111:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1112: 
1113:                         *-- ControlSource APOS RecordSource (auto-bind e substituido)
1114:                         loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.Numes"
1115:                         loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.Datas"
1116:                         loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.GrupoOs"
1117:                         loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.ContaOs"
1118:                         loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.GrupoDs"
1119:                         loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.ContaDs"
1120:                         loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.Nops"
1121:                         loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.Usuars"
1122:                         loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.PStatus"
1123:                         loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.Emps"
1124:                         loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.Empds"
1125: 
1126:                         loc_oGrid.Column1.Width  = 70
1127:                         loc_oGrid.Column2.Width  = 70
1128:                         loc_oGrid.Column3.Width  = 80
1129:                         loc_oGrid.Column4.Width  = 100
1130:                         loc_oGrid.Column5.Width  = 80
1131:                         loc_oGrid.Column6.Width  = 100
1132:                         loc_oGrid.Column7.Width  = 70
1133:                         loc_oGrid.Column8.Width  = 80
1134:                         loc_oGrid.Column9.Width  = 55
1135:                         loc_oGrid.Column10.Width = 50

*-- Linhas 1165 a 1339:
1165:     *==========================================================================
1166:     * Destroy - Libera recursos ao fechar o formulario
1167:     *==========================================================================
1168:     PROCEDURE Destroy()
1169:         IF USED("cursor_4c_ItensPam")
1170:             USE IN cursor_4c_ItensPam
1171:         ENDIF
1172:         IF USED("cursor_4c_ItensPamTemp")
1173:             USE IN cursor_4c_ItensPamTemp
1174:         ENDIF
1175:         IF USED("cursor_4c_FigPro")
1176:             USE IN cursor_4c_FigPro
1177:         ENDIF
1178:         IF USED("cursor_4c_Operacoes")
1179:             USE IN cursor_4c_Operacoes
1180:         ENDIF
1181:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1182:             THIS.this_oBusinessObject = .NULL.
1183:         ENDIF
1184:         DODEFAULT()
1185:     ENDPROC
1186: 
1187:     *==========================================================================
1188:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1189:     *==========================================================================
1190:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1191:         LOCAL loc_nI, loc_oObjeto
1192: 
1193:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1194:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1195: 
1196:             IF VARTYPE(loc_oObjeto) = "O"
1197:                 IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
1198:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1199:                         THIS.TornarControlesVisiveis(loc_oObjeto)
1200:                     ENDIF
1201:                     LOOP
1202:                 ENDIF
1203: 
1204:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1205:                     loc_oObjeto.Visible = .T.
1206:                 ENDIF
1207: 
1208:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1209:                     LOCAL loc_nP
1210:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1211:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1212:                     ENDFOR
1213:                 ENDIF
1214: 
1215:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1216:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1217:                 ENDIF
1218:             ENDIF
1219:         ENDFOR
1220:     ENDPROC
1221: 
1222:     *==========================================================================
1223:     * AlternarPagina - Alterna entre Page1 (lista) e Page2 (detalhe)
1224:     *==========================================================================
1225:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1226:         LOCAL loc_lResultado
1227:         loc_lResultado = .F.
1228: 
1229:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1230:             RETURN .F.
1231:         ENDIF
1232: 
1233:         TRY
1234:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1235: 
1236:             IF par_nPagina = 1
1237:                 THIS.this_cModoAtual = "LISTA"
1238:                 THIS.CarregarLista()
1239:             ENDIF
1240: 
1241:             loc_lResultado = .T.
1242:         CATCH TO loException
1243:             MostrarErro(loException, "Formsigpres2.AlternarPagina")
1244:         ENDTRY
1245: 
1246:         RETURN loc_lResultado
1247:     ENDPROC
1248: 
1249:     *==========================================================================
1250:     * BtnConsultarClick - Carrega movimento selecionado e navega para Page2
1251:     *==========================================================================
1252:     PROCEDURE BtnConsultarClick()
1253:         LOCAL loc_cEmpDopNums, loc_lResultado
1254:         loc_lResultado = .F.
1255: 
1256:         TRY
1257:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1258:                 MsgAviso("Selecione um registro na lista.", "Consultar")
1259:             ELSE
1260:                 SELECT cursor_4c_Dados
1261:                 loc_cEmpDopNums = ALLTRIM(TratarNulo(EmpDopNums, "C"))
1262: 
1263:                 IF EMPTY(loc_cEmpDopNums)
1264:                     MsgAviso("Registro sem identificador v" + CHR(225) + "lido.", "Consultar")
1265:                 ELSE
1266:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpDopNums)
1267:                         THIS.this_oBusinessObject.CarregarItens(loc_cEmpDopNums)
1268:                         THIS.this_oBusinessObject.CarregarOperacao(THIS.this_cDopes)
1269:                         THIS.BOParaForm()
1270:                         THIS.CarregarOperacaoGrid()
1271:                         THIS.CarregarItensGrid()
1272:                         THIS.pgf_4c_Paginas.ActivePage = 2
1273:                         THIS.this_cModoAtual = "VISUALIZAR"
1274:                         loc_lResultado = .T.
1275:                     ENDIF
1276:                 ENDIF
1277:             ENDIF
1278:         CATCH TO loException
1279:             MostrarErro(loException, "Formsigpres2.BtnConsultarClick")
1280:         ENDTRY
1281: 
1282:         RETURN loc_lResultado
1283:     ENDPROC
1284: 
1285:     *==========================================================================
1286:     * BtnEncerrarClick - Fecha o formulario
1287:     *==========================================================================
1288:     PROCEDURE BtnEncerrarClick()
1289:         TRY
1290:             THIS.Release()
1291:         CATCH TO loException
1292:             MostrarErro(loException, "Formsigpres2.BtnEncerrarClick")
1293:         ENDTRY
1294:     ENDPROC
1295: 
1296:     *==========================================================================
1297:     * CarregarOperacaoGrid - Carrega lista de operacoes no grd_4c_Operacao
1298:     *==========================================================================
1299:     PROTECTED PROCEDURE CarregarOperacaoGrid()
1300:         LOCAL loc_cSQL, loc_nResultado, loc_oGrid, loc_lSucesso
1301:         loc_lSucesso = .F.
1302: 
1303:         TRY
1304:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1305:                 loc_lSucesso = .T.
1306:             ELSE
1307:                 IF USED("cursor_4c_OperacoesTemp")
1308:                     USE IN cursor_4c_OperacoesTemp
1309:                 ENDIF
1310: 
1311:                 loc_cSQL = "SELECT a.Dopes FROM SigCdOpe a ORDER BY a.Dopes"
1312: 
1313:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacoesTemp")
1314:                 IF loc_nResultado >= 0
1315:                     IF USED("cursor_4c_Operacoes")
1316:                         SELECT cursor_4c_Operacoes
1317:                         ZAP
1318:                         APPEND FROM DBF("cursor_4c_OperacoesTemp")
1319:                     ELSE
1320:                         SELECT * FROM cursor_4c_OperacoesTemp INTO CURSOR cursor_4c_Operacoes READWRITE
1321:                     ENDIF
1322:                     IF USED("cursor_4c_OperacoesTemp")
1323:                         USE IN cursor_4c_OperacoesTemp
1324:                     ENDIF
1325: 
1326:                     loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Operacao
1327: 
1328:                     IF VARTYPE(loc_oGrid) = "O"
1329:                         loc_oGrid.ColumnCount = 1
1330:                         loc_oGrid.RecordSource = "cursor_4c_Operacoes"
1331:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Operacoes.Dopes"
1332:                         loc_oGrid.Column1.Width = 110
1333:                         loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1334:                         loc_oGrid.Refresh()
1335:                     ENDIF
1336: 
1337:                     loc_lSucesso = .T.
1338:                 ELSE
1339:                     MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + ;

*-- Linhas 1351 a 1394:
1351:     * BOParaForm - Popula campos da Page2 a partir do Business Object
1352:     * (Fase 5: campos do cabecalho - Numes, Datas, PrazoEnts, Nops, Notas, Tabds, PStatus)
1353:     *==========================================================================
1354:     PROTECTED PROCEDURE BOParaForm()
1355:         LOCAL loc_oBO, loc_oPagina
1356:         loc_oBO     = THIS.this_oBusinessObject
1357:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1358: 
1359:         TRY
1360:             *-- Codigo do movimento (MascNum mascarado ou Numes numerico)
1361:             IF VARTYPE(loc_oPagina.txt_4c_Codigo) = "O"
1362:                 IF !EMPTY(loc_oBO.this_cMascNum)
1363:                     loc_oPagina.txt_4c_Codigo.Value = ALLTRIM(loc_oBO.this_cMascNum)
1364:                 ELSE
1365:                     loc_oPagina.txt_4c_Codigo.Value = TRANSFORM(loc_oBO.this_nNumes)
1366:                 ENDIF
1367:             ENDIF
1368: 
1369:             *-- Data do movimento
1370:             IF VARTYPE(loc_oPagina.txt_4c_Data) = "O"
1371:                 loc_oPagina.txt_4c_Data.Value = loc_oBO.this_dDatas
1372:             ENDIF
1373: 
1374:             *-- Prazo de entrega
1375:             IF VARTYPE(loc_oPagina.txt_4c_PrvEnts) = "O"
1376:                 loc_oPagina.txt_4c_PrvEnts.Value = loc_oBO.this_dPrazoEnts
1377:             ENDIF
1378: 
1379:             *-- Numero da OP
1380:             IF VARTYPE(loc_oPagina.txt_4c_Nop) = "O"
1381:                 IF loc_oBO.this_nNops > 0
1382:                     loc_oPagina.txt_4c_Nop.Value = TRANSFORM(loc_oBO.this_nNops)
1383:                 ELSE
1384:                     loc_oPagina.txt_4c_Nop.Value = ""
1385:                 ENDIF
1386:             ENDIF
1387: 
1388:             *-- Numero do documento (Notas)
1389:             IF VARTYPE(loc_oPagina.txt_4c_Nota) = "O"
1390:                 loc_oPagina.txt_4c_Nota.Value = ALLTRIM(loc_oBO.this_cNotas)
1391:             ENDIF
1392: 
1393:             *-- Tabela de desconto
1394:             IF VARTYPE(loc_oPagina.txt_4c_Tabd) = "O"

*-- Linhas 1451 a 1561:
1451:     *==========================================================================
1452:     * BtnConfirmarClick - Confirma consulta e volta para lista (OK)
1453:     *==========================================================================
1454:     PROCEDURE BtnConfirmarClick()
1455:         THIS.AlternarPagina(1)
1456:     ENDPROC
1457: 
1458:     *==========================================================================
1459:     * BtnCancelarClick - Cancela e volta para lista
1460:     *==========================================================================
1461:     PROCEDURE BtnCancelarClick()
1462:         THIS.AlternarPagina(1)
1463:     ENDPROC
1464: 
1465:     *==========================================================================
1466:     * BtnEntregaClick - Abre form de entrega SigOpEnt (se disponivel)
1467:     *==========================================================================
1468:     PROCEDURE BtnEntregaClick()
1469:         LOCAL loc_oBO, loForm, loException
1470:         loc_oBO = THIS.this_oBusinessObject
1471: 
1472:         IF EMPTY(loc_oBO.this_cEmpDopNums)
1473:             MsgAviso("Nenhum movimento carregado.", "Entrega")
1474:             RETURN
1475:         ENDIF
1476: 
1477:         TRY
1478:             loForm = CREATEOBJECT("Formsigopent")
1479:             IF VARTYPE(loForm) = "O"
1480:                 loForm.Show()
1481:             ELSE
1482:                 MsgAviso("Form de entrega (SigOpEnt) n" + CHR(227) + "o dispon" + ;
1483:                          CHR(237) + "vel.", "Entrega")
1484:             ENDIF
1485:         CATCH TO loException
1486:             MsgAviso("Form de entrega (SigOpEnt) n" + CHR(227) + "o dispon" + ;
1487:                      CHR(237) + "vel.", "Entrega")
1488:         ENDTRY
1489:     ENDPROC
1490: 
1491:     *==========================================================================
1492:     * BtnSubNiveisClick - Abre form de subniveis SigMvSbn (se disponivel)
1493:     *==========================================================================
1494:     PROCEDURE BtnSubNiveisClick()
1495:         LOCAL loc_oBO, loForm, loException
1496:         loc_oBO = THIS.this_oBusinessObject
1497: 
1498:         IF EMPTY(loc_oBO.this_cEmpDopNums)
1499:             MsgAviso("Nenhum movimento carregado.", "Sub" + CHR(237) + "veis")
1500:             RETURN
1501:         ENDIF
1502: 
1503:         TRY
1504:             loForm = CREATEOBJECT("Formsigmvsbn")
1505:             IF VARTYPE(loForm) = "O"
1506:                 loForm.Show()
1507:             ELSE
1508:                 MsgAviso("Form de sub" + CHR(237) + "veis (SigMvSbn) n" + CHR(227) + ;
1509:                          "o dispon" + CHR(237) + "vel.", "Sub" + CHR(237) + "veis")
1510:             ENDIF
1511:         CATCH TO loException
1512:             MsgAviso("Form de sub" + CHR(237) + "veis (SigMvSbn) n" + CHR(227) + ;
1513:                      "o dispon" + CHR(237) + "vel.", "Sub" + CHR(237) + "veis")
1514:         ENDTRY
1515:     ENDPROC
1516: 
1517:     *==========================================================================
1518:     * CarregarItensGrid - Carrega itens do movimento em grd_4c_Itens
1519:     * JOIN SigMvPec + SigCdPam para descricao do produto (DPros)
1520:     *==========================================================================
1521:     PROTECTED PROCEDURE CarregarItensGrid()
1522:         LOCAL loc_cEmpDopNums, loc_cSQL, loc_nResultado, loc_oGrid, loc_lSucesso
1523:         loc_cEmpDopNums = ""
1524:         loc_lSucesso    = .F.
1525: 
1526:         TRY
1527:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1528:                 loc_lSucesso = .T.
1529:             ELSE
1530:                 loc_cEmpDopNums = THIS.this_oBusinessObject.this_cEmpDopNums
1531: 
1532:                 IF !EMPTY(loc_cEmpDopNums)
1533:                     IF USED("cursor_4c_ItensPamTemp")
1534:                         USE IN cursor_4c_ItensPamTemp
1535:                     ENDIF
1536: 
1537:                     loc_cSQL = "SELECT a.Codigos AS CPros," + ;
1538:                                " ISNULL(a.Cidchaves, 0) AS Produzido," + ;
1539:                                " ISNULL(a.Ntrans, 0) AS Ntrans," + ;
1540:                                " (ISNULL(a.Ntrans, 0) - ISNULL(a.Valobxs, 0)) AS Saldo," + ;
1541:                                " ISNULL(a.Valobxs, 0) AS Valobxs," + ;
1542:                                " CASE WHEN (ISNULL(a.Ntrans,0)-ISNULL(a.Valobxs,0)-ISNULL(a.Cidchaves,0))>0" + ;
1543:                                " THEN (ISNULL(a.Ntrans,0)-ISNULL(a.Valobxs,0)-ISNULL(a.Cidchaves,0))" + ;
1544:                                " ELSE 0 END AS Produzir," + ;
1545:                                " ISNULL(a.Nparcs, 0) AS Nparcs," + ;
1546:                                " CAST(0 AS DECIMAL(8,2)) AS Pesos," + ;
1547:                                " CASE WHEN ISNULL(a.Ntrans,0)>0" + ;
1548:                                " THEN CAST((ISNULL(a.Valobxs,0)*100.0/a.Ntrans) AS DECIMAL(8,2))" + ;
1549:                                " ELSE CAST(0 AS DECIMAL(8,2)) END AS PctEnt," + ;
1550:                                " ISNULL(a.Locals,'') AS Locals," + ;
1551:                                " ISNULL(p.DPros,'') AS DPros" + ;
1552:                                " FROM SigMvPec a" + ;
1553:                                " LEFT JOIN SigCdPam p ON p.MascNums = a.Codigos" + ;
1554:                                " WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + ;
1555:                                " ORDER BY a.Codigos"
1556: 
1557:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensPamTemp")
1558: 
1559:                     IF loc_nResultado >= 0
1560:                         IF USED("cursor_4c_ItensPam")
1561:                             SELECT cursor_4c_ItensPam

*-- Linhas 1644 a 1687:
1644:     *==========================================================================
1645:     * GrdItensAfterRowColChange - Atualiza descricao, obs e imagem do item
1646:     *==========================================================================
1647:     PROCEDURE GrdItensAfterRowColChange(par_nColIndex)
1648:         LOCAL loc_oPagina, loc_cCPros, loc_cDPros, loc_cSQLFig, loc_nFig
1649:         LOCAL loc_cFigJpgs, loc_lVazio
1650:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
1651:         loc_cCPros   = ""
1652:         loc_cDPros   = ""
1653:         loc_cSQLFig  = ""
1654:         loc_nFig     = 0
1655:         loc_cFigJpgs = ""
1656:         loc_lVazio   = .F.
1657: 
1658:         TRY
1659:             IF !USED("cursor_4c_ItensPam") OR EOF("cursor_4c_ItensPam")
1660:                 loc_lVazio = .T.
1661:             ELSE
1662:                 SELECT cursor_4c_ItensPam
1663:                 loc_cCPros = ALLTRIM(TratarNulo(CPros, "C"))
1664:                 loc_cDPros = ALLTRIM(TratarNulo(DPros, "C"))
1665:             ENDIF
1666: 
1667:             IF loc_lVazio
1668:                 IF VARTYPE(loc_oPagina.txt_4c_Descr) = "O"
1669:                     loc_oPagina.txt_4c_Descr.Value = ""
1670:                 ENDIF
1671:                 IF VARTYPE(loc_oPagina.txt_4c_ObsItem) = "O"
1672:                     loc_oPagina.txt_4c_ObsItem.Value = ""
1673:                 ENDIF
1674:                 IF VARTYPE(loc_oPagina.img_4c_FigJpg) = "O"
1675:                     loc_oPagina.img_4c_FigJpg.Picture = ""
1676:                     loc_oPagina.img_4c_FigJpg.Visible = .F.
1677:                 ENDIF
1678:             ELSE
1679:                 IF VARTYPE(loc_oPagina.txt_4c_Descr) = "O"
1680:                     loc_oPagina.txt_4c_Descr.Value = loc_cDPros
1681:                 ENDIF
1682:                 IF VARTYPE(loc_oPagina.txt_4c_ObsItem) = "O"
1683:                     loc_oPagina.txt_4c_ObsItem.Value = ""
1684:                 ENDIF
1685: 
1686:                 *-- Imagem do produto via SigCdPro.FigJpgs
1687:                 IF !EMPTY(loc_cCPros)

*-- Linhas 1718 a 1879:
1718:     *==========================================================================
1719:     * ImgFigJpgClick - Abre imagem do produto no visualizador padrao
1720:     *==========================================================================
1721:     PROCEDURE ImgFigJpgClick()
1722:         LOCAL loc_cPicture
1723:         loc_cPicture = ""
1724: 
1725:         TRY
1726:             IF VARTYPE(THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg) = "O"
1727:                 loc_cPicture = THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg.Picture
1728:             ENDIF
1729:             IF !EMPTY(loc_cPicture) AND FILE(loc_cPicture)
1730:                 DECLARE INTEGER ShellExecute IN shell32 ;
1731:                     INTEGER hwnd, STRING lpVerb, STRING lpFile, ;
1732:                     STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
1733:                 ShellExecute(0, "open", loc_cPicture, "", "", 1)
1734:             ENDIF
1735:         CATCH TO loException
1736:             MostrarErro(loException, "Formsigpres2.ImgFigJpgClick")
1737:         ENDTRY
1738:     ENDPROC
1739: 
1740:     *==========================================================================
1741:     * BtnIncluirClick - Nao aplicavel: form OPERACIONAL (consulta apenas)
1742:     * Original: Inlist(This.Value, 1,3,4,5) -> mAtivaPagina1 (retorna lista)
1743:     *==========================================================================
1744:     PROCEDURE BtnIncluirClick()
1745:         THIS.AlternarPagina(1)
1746:     ENDPROC
1747: 
1748:     *==========================================================================
1749:     * BtnAlterarClick - Nao aplicavel: form OPERACIONAL (consulta apenas)
1750:     * Original: Inlist(This.Value, 1,3,4,5) -> mAtivaPagina1 (retorna lista)
1751:     *==========================================================================
1752:     PROCEDURE BtnAlterarClick()
1753:         THIS.AlternarPagina(1)
1754:     ENDPROC
1755: 
1756:     *==========================================================================
1757:     * BtnVisualizarClick - Carrega movimento selecionado e navega para Page2
1758:     * Equivalente ao BtnConsultarClick (Value=2 no CommandGroup original)
1759:     *==========================================================================
1760:     PROCEDURE BtnVisualizarClick()
1761:         THIS.BtnConsultarClick()
1762:     ENDPROC
1763: 
1764:     *==========================================================================
1765:     * BtnExcluirClick - Nao aplicavel: form OPERACIONAL (consulta apenas)
1766:     * Original: Inlist(This.Value, 1,3,4,5) -> mAtivaPagina1 (retorna lista)
1767:     *==========================================================================
1768:     PROCEDURE BtnExcluirClick()
1769:         THIS.AlternarPagina(1)
1770:     ENDPROC
1771: 
1772:     *==========================================================================
1773:     * BtnCadastrosClick - Abre cadastro da conta destino selecionada
1774:     *==========================================================================
1775:     PROCEDURE BtnCadastrosClick()
1776:         LOCAL loc_cContaD, loForm
1777:         loc_cContaD = ""
1778: 
1779:         TRY
1780:             IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem) = "O"
1781:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_ContaD) = "O"
1782:                     loc_cContaD = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_ContaD.Value)
1783:                 ENDIF
1784:             ENDIF
1785: 
1786:             IF EMPTY(loc_cContaD)
1787:                 MsgAviso("Nenhuma conta destino definida.", "Cadastro")
1788:             ELSE
1789:                 loForm = CREATEOBJECT("Formsigcdcli")
1790:                 IF VARTYPE(loForm) = "O"
1791:                     loForm.Show()
1792:                 ELSE
1793:                     MsgAviso("Form de cadastro de contas n" + CHR(227) + ;
1794:                              "o dispon" + CHR(237) + "vel.", "Cadastro")
1795:                 ENDIF
1796:             ENDIF
1797:         CATCH TO loException
1798:             MostrarErro(loException, "Formsigpres2.BtnCadastrosClick")
1799:         ENDTRY
1800:     ENDPROC
1801: 
1802:     *==========================================================================
1803:     * BtnBuscarClick - Recarrega lista de movimentos (Procurar oculto no original)
1804:     *==========================================================================
1805:     PROCEDURE BtnBuscarClick()
1806:         TRY
1807:             THIS.CarregarLista()
1808:         CATCH TO loException
1809:             MostrarErro(loException, "Formsigpres2.BtnBuscarClick")
1810:         ENDTRY
1811:     ENDPROC
1812: 
1813:     *==========================================================================
1814:     * BtnSalvarClick - Alias de BtnConfirmarClick (confirmar consulta = volta lista)
1815:     *==========================================================================
1816:     PROCEDURE BtnSalvarClick()
1817:         THIS.BtnConfirmarClick()
1818:     ENDPROC
1819: 
1820:     *==========================================================================
1821:     * FormParaBO - Nao aplicavel: form OPERACIONAL (todos campos ReadOnly)
1822:     * Implementado para conformidade com a interface padrao FormBase
1823:     *==========================================================================
1824:     PROTECTED PROCEDURE FormParaBO()
1825:         RETURN .T.
1826:     ENDPROC
1827: 
1828:     *==========================================================================
1829:     * HabilitarCampos - Nao aplicavel: form OPERACIONAL (todos ReadOnly)
1830:     * Implementado para conformidade com a interface padrao FormBase
1831:     *==========================================================================
1832:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1833:         RETURN .T.
1834:     ENDPROC
1835: 
1836:     *==========================================================================
1837:     * LimparCampos - Limpa todos os campos de exibicao da Page2
1838:     *==========================================================================
1839:     PROTECTED PROCEDURE LimparCampos()
1840:         LOCAL loc_oPg2, loc_oCnt
1841:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1842: 
1843:         TRY
1844:             IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
1845:                 loc_oPg2.txt_4c_Codigo.Value = ""
1846:             ENDIF
1847:             IF VARTYPE(loc_oPg2.txt_4c_Data) = "O"
1848:                 loc_oPg2.txt_4c_Data.Value = {}
1849:             ENDIF
1850:             IF VARTYPE(loc_oPg2.txt_4c_PrvEnts) = "O"
1851:                 loc_oPg2.txt_4c_PrvEnts.Value = {}
1852:             ENDIF
1853:             IF VARTYPE(loc_oPg2.txt_4c_Nop) = "O"
1854:                 loc_oPg2.txt_4c_Nop.Value = ""
1855:             ENDIF
1856:             IF VARTYPE(loc_oPg2.txt_4c_Nota) = "O"
1857:                 loc_oPg2.txt_4c_Nota.Value = ""
1858:             ENDIF
1859:             IF VARTYPE(loc_oPg2.txt_4c_Tabd) = "O"
1860:                 loc_oPg2.txt_4c_Tabd.Value = ""
1861:             ENDIF
1862:             IF VARTYPE(loc_oPg2.txt_4c_PStatus) = "O"
1863:                 loc_oPg2.txt_4c_PStatus.Value = ""
1864:             ENDIF
1865:             IF VARTYPE(loc_oPg2.txt_4c_Descr) = "O"
1866:                 loc_oPg2.txt_4c_Descr.Value = ""
1867:             ENDIF
1868:             IF VARTYPE(loc_oPg2.txt_4c_ObsItem) = "O"
1869:                 loc_oPg2.txt_4c_ObsItem.Value = ""
1870:             ENDIF
1871: 
1872:             loc_oCnt = loc_oPg2.cnt_4c_Origem
1873:             IF VARTYPE(loc_oCnt) = "O"
1874:                 IF VARTYPE(loc_oCnt.txt_4c_GrupoOs) = "O"
1875:                     loc_oCnt.txt_4c_GrupoOs.Value = ""
1876:                 ENDIF
1877:                 IF VARTYPE(loc_oCnt.txt_4c_ContaOs) = "O"
1878:                     loc_oCnt.txt_4c_ContaOs.Value = ""
1879:                 ENDIF

*-- Linhas 1920 a 1960:
1920:     * LISTA: habilita Consultar, desabilita botoes de Page2
1921:     * VISUALIZAR: habilita Confirmar/Cancelar, SubNiveis, Entrega
1922:     *==========================================================================
1923:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1924:         LOCAL loc_oPg1, loc_oPg2, loc_lLista
1925:         loc_lLista = (THIS.this_cModoAtual == "LISTA")
1926: 
1927:         TRY
1928:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1929:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1930: 
1931:             *-- Page1: botao Consultar habilitado apenas no modo LISTA
1932:             IF VARTYPE(loc_oPg1.cnt_4c_Botoes) = "O"
1933:                 IF VARTYPE(loc_oPg1.cnt_4c_Botoes.cmd_4c_Consultar) = "O"
1934:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Consultar.Enabled = loc_lLista
1935:                 ENDIF
1936:             ENDIF
1937: 
1938:             *-- Page2: botoes de acao habilitados apenas no modo VISUALIZAR
1939:             IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
1940:                 IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar) = "O"
1941:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = !loc_lLista
1942:                 ENDIF
1943:                 IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar) = "O"
1944:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = !loc_lLista
1945:                 ENDIF
1946:             ENDIF
1947: 
1948:             IF VARTYPE(loc_oPg2.cmd_4c_SubNiveis) = "O"
1949:                 loc_oPg2.cmd_4c_SubNiveis.Enabled = !loc_lLista
1950:             ENDIF
1951: 
1952:             IF VARTYPE(loc_oPg2.cmd_4c_Entrega) = "O"
1953:                 loc_oPg2.cmd_4c_Entrega.Enabled = !loc_lLista
1954:             ENDIF
1955:         CATCH TO loException
1956:             MostrarErro(loException, "Formsigpres2.AjustarBotoesPorModo")
1957:         ENDTRY
1958:     ENDPROC
1959: 
1960: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpres2BO.prg):
*==============================================================================
* sigpres2BO.prg - Business Object para SIGPRES2 (Detalhe de Movimento)
* Herda de BusinessBase
* Formulario OPERACIONAL - consulta de itens de movimento de pedido
*==============================================================================

DEFINE CLASS sigpres2BO AS BusinessBase

    *-- Chave composta do movimento: Emps+Dopes+Str(Numes,6) padded
    this_cEmpDopNums = ""

    *-- Identificacao do movimento
    this_cEmps        = ""  && Empresa origem C(3)
    this_cDopes       = ""  && Tipo de operacao C(20)
    this_nNumes       = 0   && Numero do movimento N(6,0)
    this_cChave       = ""  && _Chave passado no Init (= Dopes)
    this_cMascNum     = ""  && Codigo mascarado do movimento C(10) - SigMvCab.mascnum

    *-- Cabecalho do movimento (SigMvCab)
    this_dDatas       = {}  && Data do movimento D - SigMvCab.datas
    this_cNotas       = ""  && Numero do documento C(6) - SigMvCab.notas
    this_nNops        = 0   && Numero da OP N - SigMvCab.nops
    this_cPStatus     = ""  && Status do pedido C(1) - SigMvCab.pstatus
    this_cTabds       = ""  && Tabela de desconto C(10) - SigMvCab.tabds
    this_cUsuars      = ""  && Usuario C(10) - SigMvCab.usuars
    this_dPrazoEnts   = {}  && Prazo de entrega D - SigMvCab.prazoents
    this_cObses       = ""  && Observacoes do movimento C/M - SigMvCab.obses
    this_lChkSubn     = .F. && Possui sub-niveis L - SigMvCab.chksubn
    this_lChkBxParcs  = .F. && Baixa parcial L - SigMvCab.chkbxparcs

    *-- Origem (conta origem) - SigMvCab
    this_cGrupoOs     = ""  && Grupo de conta origem C(10) - SigMvCab.grupoos
    this_cContaOs     = ""  && Conta origem C(10) - SigMvCab.contaos
    this_cDContaOs    = ""  && Descricao da conta origem C (de SigCdCli)

    *-- Destino (conta destino) - SigMvCab
    this_cGrupoDs     = ""  && Grupo de conta destino C(10) - SigMvCab.grupods
    this_cContaDs     = ""  && Conta destino C(10) - SigMvCab.contads
    this_cDContaDs    = ""  && Descricao da conta destino C (de SigCdCli)
    this_cEmpds       = ""  && Empresa destino C(3) - SigMvCab.empds

    *-- Vendedor - SigMvCab
    this_cGrvends     = ""  && Grupo do vendedor C(10) - SigMvCab.grvends
    this_cVends       = ""  && Codigo do vendedor C(10) - SigMvCab.vends
    this_cDVends      = ""  && Descricao do vendedor C (de SigCdCli)

    *-- Representante - SigMvCab
    this_cGrresps     = ""  && Grupo do representante C(10) - SigMvCab.grresps
    this_cResps       = ""  && Codigo do representante C(10) - SigMvCab.resps
    this_cDResps      = ""  && Descricao do representante C (de SigCdCli)

    *-- Configuracao da operacao (SigCdOpe)
    this_nBlqDatas    = 0   && Bloqueio de datas N - SigCdOpe.blqdatas
    this_nDtEntrs     = 0   && Tipo de entrega N - SigCdOpe.dtentrs

    *-- Tipo de instalacao (global gcTpInstalas)
    this_cTpInstalas  = ""  && Tipo de instalacao C

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de movimentos filtrados pelo Dopes (operacao)
    * par_cFiltro: filtro SQL adicional (WHERE clause extra, sem WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.EmpDopNums, a.Emps, a.Dopes, a.Numes," + ;
                       " a.Datas, a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs," + ;
                       " a.Nops, a.Usuars, a.PStatus, a.Empds" + ;
                       " FROM SigMvCab a"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Numes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar movimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega cabecalho do movimento por EmpDopNums
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.EmpDopNums, a.Emps, a.Dopes, a.Numes, a.MascNum," + ;
                       " a.Datas, a.Notas, a.Nops, a.PStatus, a.Tabds, a.Usuars," + ;
                       " a.PrazoEnts, a.Obses, a.ChkSubn, a.ChkBxParcs," + ;
                       " a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, a.Empds," + ;
                       " a.Vends, a.Grvends, a.Resps, a.Grresps" + ;
                       " FROM SigMvCab a" + ;
                       " WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lSucesso
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * REGRA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cEmpDopNums  = ALLTRIM(TratarNulo(EmpDopNums, "C"))
            THIS.this_cEmps        = ALLTRIM(TratarNulo(Emps, "C"))
            THIS.this_cDopes       = ALLTRIM(TratarNulo(Dopes, "C"))
            THIS.this_nNumes       = TratarNulo(Numes, "N")

            *-- MascNum so existe no cursor completo (CarregarPorCodigo)
            IF TYPE("MascNum") != "U"
                THIS.this_cMascNum = ALLTRIM(TratarNulo(MascNum, "C"))
            ENDIF

            THIS.this_dDatas       = TratarNulo(Datas, "D")
            THIS.this_dPrazoEnts   = TratarNulo(PrazoEnts, "D")
            THIS.this_cNotas       = ALLTRIM(TratarNulo(Notas, "C"))
            THIS.this_nNops        = TratarNulo(Nops, "N")
            THIS.this_cPStatus     = ALLTRIM(TratarNulo(PStatus, "C"))
            THIS.this_cTabds       = ALLTRIM(TratarNulo(Tabds, "C"))
            THIS.this_cUsuars      = ALLTRIM(TratarNulo(Usuars, "C"))
            THIS.this_cObses       = TratarNulo(Obses, "C")
            THIS.this_lChkSubn     = (TratarNulo(ChkSubn, "N") = 1)
            THIS.this_lChkBxParcs  = (TratarNulo(ChkBxParcs, "N") = 1)

            THIS.this_cGrupoOs     = ALLTRIM(TratarNulo(GrupoOs, "C"))
            THIS.this_cContaOs     = ALLTRIM(TratarNulo(ContaOs, "C"))
            THIS.this_cGrupoDs     = ALLTRIM(TratarNulo(GrupoDs, "C"))
            THIS.this_cContaDs     = ALLTRIM(TratarNulo(ContaDs, "C"))
            THIS.this_cEmpds       = ALLTRIM(TratarNulo(Empds, "C"))

            THIS.this_cGrvends     = ALLTRIM(TratarNulo(Grvends, "C"))
            THIS.this_cVends       = ALLTRIM(TratarNulo(Vends, "C"))
            THIS.this_cGrresps     = ALLTRIM(TratarNulo(Grresps, "C"))
            THIS.this_cResps       = ALLTRIM(TratarNulo(Resps, "C"))

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - Carrega itens do movimento (SigMvPec) por EmpDopNums
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_cSQL = "SELECT a.EmpDopNums, a.Codigos, a.Emps, a.Dopes, a.Numes," + ;
                       " a.Datas, a.Ntrans, a.Locals, a.Valobxs, a.Cidchaves," + ;
                       " a.ChkSubn, a.ChkPagos, a.Nparcs, a.Valps, a.PStatus" + ;
                       " FROM SigMvPec a" + ;
                       " WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + ;
                       " ORDER BY a.Codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarItens:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacao - Carrega configuracao da operacao (SigCdOpe)
    * Popula this_nBlqDatas e this_nDtEntrs
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacao(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Operacao")
                USE IN cursor_4c_Operacao
            ENDIF

            loc_cSQL = "SELECT a.Dopes, a.BlqDatas, a.DtEntrs" + ;
                       " FROM SigCdOpe a" + ;
                       " WHERE a.Dopes = " + EscaparSQL(par_cDopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacao")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Operacao") > 0
                SELECT cursor_4c_Operacao
                THIS.this_nBlqDatas = TratarNulo(BlqDatas, "N")
                THIS.this_nDtEntrs  = TratarNulo(DtEntrs, "N")
                loc_lSucesso = .T.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar opera" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarOperacao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Operacao")
            USE IN cursor_4c_Operacao
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescricaoConta - Carrega descricao de uma conta (SigCdCli)
    * Retorna a descricao ou string vazia se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescricaoConta(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        IF EMPTY(par_cConta)
            RETURN loc_cDescricao
        ENDIF

        TRY
            IF USED("cursor_4c_DescConta")
                USE IN cursor_4c_DescConta
            ENDIF

            loc_cSQL = "SELECT TOP 1 a.IClis, a.Rclis" + ;
                       " FROM SigCdCli a" + ;
                       " WHERE a.IClis = " + EscaparSQL(par_cConta)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescConta")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescConta") > 0
                SELECT cursor_4c_DescConta
                loc_cDescricao = ALLTRIM(TratarNulo(Rclis, "C"))
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarDescricaoConta:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_DescConta")
            USE IN cursor_4c_DescConta
        ENDIF

        RETURN loc_cDescricao
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO aplicavel para este formulario operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        MsgErro("Inser" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
                CHR(237) + "vel neste formul" + CHR(225) + "rio.", "Aviso")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigMvCab (data, contas origem/destino, obs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cEmpDopNums)
            MsgErro("Chave do movimento n" + CHR(227) + "o definida.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigMvCab SET" + ;
                       " Datas = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " GrupoOs = " + EscaparSQL(THIS.this_cGrupoOs) + "," + ;
                       " ContaOs = " + EscaparSQL(THIS.this_cContaOs) + "," + ;
                       " GrupoDs = " + EscaparSQL(THIS.this_cGrupoDs) + "," + ;
                       " ContaDs = " + EscaparSQL(THIS.this_cContaDs) + "," + ;
                       " Vends = " + EscaparSQL(THIS.this_cVends) + "," + ;
                       " Grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;
                       " PrazoEnts = " + FormatarDataSQL(THIS.this_dPrazoEnts) + "," + ;
                       " Notas = " + EscaparSQL(THIS.this_cNotas) + "," + ;
                       " Tabds = " + EscaparSQL(THIS.this_cTabds) + "," + ;
                       " Obses = " + EscaparSQL(THIS.this_cObses) + "," + ;
                       " DtAlts = GETDATE()" + ;
                       " WHERE EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNums)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")
            IF loc_nResultado >= 0
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - NAO aplicavel para este formulario operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        MsgErro("Exclus" + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
                CHR(237) + "vel neste formul" + CHR(225) + "rio.", "Aviso")
        RETURN .F.
    ENDPROC

ENDDEFINE

