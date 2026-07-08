# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Operacoes' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_OperacoesTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_ItensPam' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_ItensPamTemp'), depois ZAP + APPEND FROM DBF() no cursor original.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1928 linhas total):

*-- Linhas 30 a 147:
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
55:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
56:                     THIS.CarregarLista()
57:                 ENDIF
58: 
59:                 THIS.pgf_4c_Paginas.Visible = .T.
60:                 THIS.pgf_4c_Paginas.ActivePage = 1
61:                 THIS.this_cModoAtual = "LISTA"
62:                 loc_lSucesso = .T.
63:             ENDIF
64:         CATCH TO loException
65:             MostrarErro(loException, "Formsigpres2.InicializarForm")
66:         ENDTRY
67: 
68:         RETURN loc_lSucesso
69:     ENDPROC
70: 
71:     *==========================================================================
72:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas
73:     *==========================================================================
74:     PROTECTED PROCEDURE ConfigurarPageFrame()
75:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
76:         WITH THIS.pgf_4c_Paginas
77:             .PageCount = 2
78:             .Top       = -29
79:             .Left      = 0
80:             .Width     = THIS.Width
81:             .Height    = THIS.Height + 29
82:             .Tabs      = .F.
83:             .Visible   = .T.
84:             .Page1.Caption   = "Lista"
85:             .Page1.BackColor = RGB(100, 100, 100)
86:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
87:             .Page2.Caption   = "Dados"
88:             .Page2.BackColor = RGB(100, 100, 100)
89:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
90:         ENDWITH
91:     ENDPROC
92: 
93:     *==========================================================================
94:     * ConfigurarPaginaLista - Configura Page1 (lista de movimentos)
95:     *==========================================================================
96:     PROTECTED PROCEDURE ConfigurarPaginaLista()
97:         LOCAL loc_oPagina
98:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
99: 
100:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
101:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102: 
103:         *-- Cabecalho (cntSombra: Top=2+29=31 compensacao PageFrame)
104:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
105:         WITH loc_oPagina.cnt_4c_Cabecalho
106:             .Top         = 31
107:             .Left        = 0
108:             .Width       = THIS.Width
109:             .Height      = 80
110:             .BackColor   = RGB(100, 100, 100)
111:             .BorderWidth = 0
112:             .Visible     = .T.
113:         ENDWITH
114: 
115:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
116:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
117:             .Caption   = THIS.Caption
118:             .Top       = 15
119:             .Left      = 10
120:             .Width     = THIS.Width - 20
121:             .Height    = 40
122:             .FontName  = "Tahoma"
123:             .FontSize  = 16
124:             .FontBold  = .T.
125:             .ForeColor = RGB(0, 0, 0)
126:             .BackStyle = 0
127:             .AutoSize  = .F.
128:             .Visible   = .T.
129:         ENDWITH
130: 
131:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
132:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
133:             .Caption   = THIS.Caption
134:             .Top       = 18
135:             .Left      = 10
136:             .Width     = THIS.Width - 20
137:             .Height    = 46
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(255, 255, 255)
142:             .BackStyle = 0
143:             .AutoSize  = .F.
144:             .Visible   = .T.
145:         ENDWITH
146: 
147:         *-- Container botao Consultar (Grupo_Op original: Width=10+80=90, apenas Consultar visivel)

*-- Linhas 242 a 298:
242:             .Visible            = .T.
243:         ENDWITH
244: 
245:         *-- BINDEVENTs dos botoes (metodos PUBLIC, sem PROTECTED)
246:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Consultar, "Click", ;
247:                   THIS, "BtnConsultarClick")
248:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", ;
249:                   THIS, "BtnEncerrarClick")
250: 
251:         THIS.TornarControlesVisiveis(loc_oPagina)
252:     ENDPROC
253: 
254:     *==========================================================================
255:     * ConfigurarPaginaDados - Configura Page2 (detalhe do movimento)
256:     * FASE 5: cabecalho, grid operacao, cmdEntrega, SubNiveis
257:     *==========================================================================
258:     PROTECTED PROCEDURE ConfigurarPaginaDados()
259:         LOCAL loc_oPagina
260:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
261: 
262:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
263:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
264: 
265:         *-- Container botoes acao (Grupo_Salva: top=4+29=33)
266:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
267:         WITH loc_oPagina.cnt_4c_BotoesAcao
268:             .Top         = 33
269:             .Left        = 842
270:             .Width       = 160
271:             .Height      = 85
272:             .BackStyle = 1
273:             .BackColor = RGB(255, 255, 255)
274:             .Visible     = .T.
275:         ENDWITH
276: 
277:         *-- Botao Confirmar (Salva/OK no CONSULTAR)
278:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
279:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
280:             .Caption         = "Confirmar"
281:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
282:             .PicturePosition = 13
283:             .Top             = 5
284:             .Left            = 5
285:             .Width           = 75
286:             .Height          = 75
287:             .BackColor       = RGB(255, 255, 255)
288:             .ForeColor       = RGB(90, 90, 90)
289:             .FontName        = "Comic Sans MS"
290:             .FontSize        = 8
291:             .FontBold        = .T.
292:             .FontItalic      = .T.
293:             .Themes          = .F.
294:             .SpecialEffect   = 0
295:             .MousePointer    = 15
296:             .WordWrap        = .T.
297:             .AutoSize        = .F.
298:             .Visible         = .T.

*-- Linhas 1067 a 1132:
1067:             .Visible = .F.
1068:         ENDWITH
1069: 
1070:         *-- BINDEVENTs (metodos PUBLIC para funcionar com BINDEVENT)
1071:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", ;
1072:                   THIS, "BtnConfirmarClick")
1073:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", ;
1074:                   THIS, "BtnCancelarClick")
1075:         BINDEVENT(loc_oPagina.cmd_4c_Entrega, "Click", ;
1076:                   THIS, "BtnEntregaClick")
1077:         BINDEVENT(loc_oPagina.cmd_4c_SubNiveis, "Click", ;
1078:                   THIS, "BtnSubNiveisClick")
1079:         BINDEVENT(loc_oPagina.cnt_4c_Origem.cmd_4c_BtnCadastros, "Click", ;
1080:                   THIS, "BtnCadastrosClick")
1081:         BINDEVENT(loc_oPagina.grd_4c_Itens, "AfterRowColChange", ;
1082:                   THIS, "GrdItensAfterRowColChange")
1083:         BINDEVENT(loc_oPagina.img_4c_FigJpg, "Click", ;
1084:                   THIS, "ImgFigJpgClick")
1085: 
1086:         THIS.TornarControlesVisiveis(loc_oPagina)
1087:     ENDPROC
1088: 
1089:     *==========================================================================
1090:     * CarregarLista - Carrega movimentos do tipo this_cDopes
1091:     *==========================================================================
1092:     PROCEDURE CarregarLista()
1093:         LOCAL loc_lResultado, loc_oGrid
1094:         loc_lResultado = .F.
1095: 
1096:         TRY
1097:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1098:                 loc_lResultado = .T.
1099:             ELSE
1100:                 THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
1101: 
1102:                 IF THIS.this_oBusinessObject.Buscar("")
1103:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1104: 
1105:                     IF VARTYPE(loc_oGrid) = "O"
1106:                         *-- RecordSource fora de WITH (Problem 36: evita "Unknown member COLUMN1")
1107:                         loc_oGrid.ColumnCount = 11
1108:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1109: 
1110:                         *-- ControlSource APOS RecordSource (auto-bind e substituido)
1111:                         loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.Numes"
1112:                         loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.Datas"
1113:                         loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.GrupoOs"
1114:                         loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.ContaOs"
1115:                         loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.GrupoDs"
1116:                         loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.ContaDs"
1117:                         loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.Nops"
1118:                         loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.Usuars"
1119:                         loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.PStatus"
1120:                         loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.Emps"
1121:                         loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.Empds"
1122: 
1123:                         loc_oGrid.Column1.Width  = 70
1124:                         loc_oGrid.Column2.Width  = 70
1125:                         loc_oGrid.Column3.Width  = 80
1126:                         loc_oGrid.Column4.Width  = 100
1127:                         loc_oGrid.Column5.Width  = 80
1128:                         loc_oGrid.Column6.Width  = 100
1129:                         loc_oGrid.Column7.Width  = 70
1130:                         loc_oGrid.Column8.Width  = 80
1131:                         loc_oGrid.Column9.Width  = 55
1132:                         loc_oGrid.Column10.Width = 50

*-- Linhas 1161 a 1373:
1161: 
1162:     *==========================================================================
1163:     * Destroy - Libera recursos ao fechar o formulario
1164:     *==========================================================================
1165:     PROCEDURE Destroy()
1166:         IF USED("cursor_4c_ItensPam")
1167:             USE IN cursor_4c_ItensPam
1168:         ENDIF
1169:         IF USED("cursor_4c_ItensPamTemp")
1170:             USE IN cursor_4c_ItensPamTemp
1171:         ENDIF
1172:         IF USED("cursor_4c_FigPro")
1173:             USE IN cursor_4c_FigPro
1174:         ENDIF
1175:         IF USED("cursor_4c_Operacoes")
1176:             USE IN cursor_4c_Operacoes
1177:         ENDIF
1178:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1179:             THIS.this_oBusinessObject = .NULL.
1180:         ENDIF
1181:         DODEFAULT()
1182:     ENDPROC
1183: 
1184:     *==========================================================================
1185:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1186:     *==========================================================================
1187:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1188:         LOCAL loc_nI, loc_oObjeto
1189: 
1190:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1191:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1192: 
1193:             IF VARTYPE(loc_oObjeto) = "O"
1194:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1195:                     loc_oObjeto.Visible = .T.
1196:                 ENDIF
1197: 
1198:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1199:                     LOCAL loc_nP
1200:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1201:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1202:                     ENDFOR
1203:                 ENDIF
1204: 
1205:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1206:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1207:                 ENDIF
1208:             ENDIF
1209:         ENDFOR
1210:     ENDPROC
1211: 
1212:     *==========================================================================
1213:     * AlternarPagina - Alterna entre Page1 (lista) e Page2 (detalhe)
1214:     *==========================================================================
1215:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1216:         LOCAL loc_lResultado
1217:         loc_lResultado = .F.
1218: 
1219:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1220:             RETURN .F.
1221:         ENDIF
1222: 
1223:         TRY
1224:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1225: 
1226:             IF par_nPagina = 1
1227:                 THIS.this_cModoAtual = "LISTA"
1228:                 THIS.CarregarLista()
1229:             ENDIF
1230: 
1231:             loc_lResultado = .T.
1232:         CATCH TO loException
1233:             MostrarErro(loException, "Formsigpres2.AlternarPagina")
1234:         ENDTRY
1235: 
1236:         RETURN loc_lResultado
1237:     ENDPROC
1238: 
1239:     *==========================================================================
1240:     * BtnConsultarClick - Carrega movimento selecionado e navega para Page2
1241:     *==========================================================================
1242:     PROCEDURE BtnConsultarClick()
1243:         LOCAL loc_cEmpDopNums, loc_lResultado
1244:         loc_lResultado = .F.
1245: 
1246:         TRY
1247:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1248:                 MsgAviso("Selecione um registro na lista.", "Consultar")
1249:             ELSE
1250:                 SELECT cursor_4c_Dados
1251:                 loc_cEmpDopNums = ALLTRIM(TratarNulo(EmpDopNums, "C"))
1252: 
1253:                 IF EMPTY(loc_cEmpDopNums)
1254:                     MsgAviso("Registro sem identificador v" + CHR(225) + "lido.", "Consultar")
1255:                 ELSE
1256:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpDopNums)
1257:                         THIS.this_oBusinessObject.CarregarItens(loc_cEmpDopNums)
1258:                         THIS.this_oBusinessObject.CarregarOperacao(THIS.this_cDopes)
1259:                         THIS.BOParaForm()
1260:                         THIS.CarregarOperacaoGrid()
1261:                         THIS.CarregarItensGrid()
1262:                         THIS.pgf_4c_Paginas.ActivePage = 2
1263:                         THIS.this_cModoAtual = "VISUALIZAR"
1264:                         loc_lResultado = .T.
1265:                     ENDIF
1266:                 ENDIF
1267:             ENDIF
1268:         CATCH TO loException
1269:             MostrarErro(loException, "Formsigpres2.BtnConsultarClick")
1270:         ENDTRY
1271: 
1272:         RETURN loc_lResultado
1273:     ENDPROC
1274: 
1275:     *==========================================================================
1276:     * BtnEncerrarClick - Fecha o formulario
1277:     *==========================================================================
1278:     PROCEDURE BtnEncerrarClick()
1279:         TRY
1280:             THIS.Release()
1281:         CATCH TO loException
1282:             MostrarErro(loException, "Formsigpres2.BtnEncerrarClick")
1283:         ENDTRY
1284:     ENDPROC
1285: 
1286:     *==========================================================================
1287:     * CarregarOperacaoGrid - Carrega lista de operacoes no grd_4c_Operacao
1288:     *==========================================================================
1289:     PROTECTED PROCEDURE CarregarOperacaoGrid()
1290:         LOCAL loc_cSQL, loc_nResultado, loc_oGrid, loc_lSucesso
1291:         loc_lSucesso = .F.
1292: 
1293:         TRY
1294:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1295:                 loc_lSucesso = .T.
1296:             ELSE
1297:                 IF USED("cursor_4c_Operacoes")
1298:                     USE IN cursor_4c_Operacoes
1299:                 ENDIF
1300: 
1301:                 loc_cSQL = "SELECT a.Dopes FROM SigCdOpe a ORDER BY a.Dopes"
1302: 
1303:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")
1304:                 IF loc_nResultado >= 0
1305:                     loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Operacao
1306: 
1307:                     IF VARTYPE(loc_oGrid) = "O"
1308:                         loc_oGrid.ColumnCount = 1
1309:                         loc_oGrid.RecordSource = "cursor_4c_Operacoes"
1310:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Operacoes.Dopes"
1311:                         loc_oGrid.Column1.Width = 110
1312:                         loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1313:                         loc_oGrid.Refresh()
1314:                     ENDIF
1315: 
1316:                     loc_lSucesso = .T.
1317:                 ELSE
1318:                     MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + ;
1319:                             CHR(13) + CapturarErroSQL(), "Erro SQL")
1320:                 ENDIF
1321:             ENDIF
1322:         CATCH TO loException
1323:             MostrarErro(loException, "Formsigpres2.CarregarOperacaoGrid")
1324:         ENDTRY
1325: 
1326:         RETURN loc_lSucesso
1327:     ENDPROC
1328: 
1329:     *==========================================================================
1330:     * BOParaForm - Popula campos da Page2 a partir do Business Object
1331:     * (Fase 5: campos do cabecalho - Numes, Datas, PrazoEnts, Nops, Notas, Tabds, PStatus)
1332:     *==========================================================================
1333:     PROTECTED PROCEDURE BOParaForm()
1334:         LOCAL loc_oBO, loc_oPagina
1335:         loc_oBO     = THIS.this_oBusinessObject
1336:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1337: 
1338:         TRY
1339:             *-- Codigo do movimento (MascNum mascarado ou Numes numerico)
1340:             IF VARTYPE(loc_oPagina.txt_4c_Codigo) = "O"
1341:                 IF !EMPTY(loc_oBO.this_cMascNum)
1342:                     loc_oPagina.txt_4c_Codigo.Value = ALLTRIM(loc_oBO.this_cMascNum)
1343:                 ELSE
1344:                     loc_oPagina.txt_4c_Codigo.Value = TRANSFORM(loc_oBO.this_nNumes)
1345:                 ENDIF
1346:             ENDIF
1347: 
1348:             *-- Data do movimento
1349:             IF VARTYPE(loc_oPagina.txt_4c_Data) = "O"
1350:                 loc_oPagina.txt_4c_Data.Value = loc_oBO.this_dDatas
1351:             ENDIF
1352: 
1353:             *-- Prazo de entrega
1354:             IF VARTYPE(loc_oPagina.txt_4c_PrvEnts) = "O"
1355:                 loc_oPagina.txt_4c_PrvEnts.Value = loc_oBO.this_dPrazoEnts
1356:             ENDIF
1357: 
1358:             *-- Numero da OP
1359:             IF VARTYPE(loc_oPagina.txt_4c_Nop) = "O"
1360:                 IF loc_oBO.this_nNops > 0
1361:                     loc_oPagina.txt_4c_Nop.Value = TRANSFORM(loc_oBO.this_nNops)
1362:                 ELSE
1363:                     loc_oPagina.txt_4c_Nop.Value = ""
1364:                 ENDIF
1365:             ENDIF
1366: 
1367:             *-- Numero do documento (Notas)
1368:             IF VARTYPE(loc_oPagina.txt_4c_Nota) = "O"
1369:                 loc_oPagina.txt_4c_Nota.Value = ALLTRIM(loc_oBO.this_cNotas)
1370:             ENDIF
1371: 
1372:             *-- Tabela de desconto
1373:             IF VARTYPE(loc_oPagina.txt_4c_Tabd) = "O"

*-- Linhas 1430 a 1569:
1430:     *==========================================================================
1431:     * BtnConfirmarClick - Confirma consulta e volta para lista (OK)
1432:     *==========================================================================
1433:     PROCEDURE BtnConfirmarClick()
1434:         THIS.AlternarPagina(1)
1435:     ENDPROC
1436: 
1437:     *==========================================================================
1438:     * BtnCancelarClick - Cancela e volta para lista
1439:     *==========================================================================
1440:     PROCEDURE BtnCancelarClick()
1441:         THIS.AlternarPagina(1)
1442:     ENDPROC
1443: 
1444:     *==========================================================================
1445:     * BtnEntregaClick - Abre form de entrega SigOpEnt (se disponivel)
1446:     *==========================================================================
1447:     PROCEDURE BtnEntregaClick()
1448:         LOCAL loc_oBO, loForm, loException
1449:         loc_oBO = THIS.this_oBusinessObject
1450: 
1451:         IF EMPTY(loc_oBO.this_cEmpDopNums)
1452:             MsgAviso("Nenhum movimento carregado.", "Entrega")
1453:             RETURN
1454:         ENDIF
1455: 
1456:         TRY
1457:             loForm = CREATEOBJECT("Formsigopent")
1458:             IF VARTYPE(loForm) = "O"
1459:                 loForm.Show()
1460:             ELSE
1461:                 MsgAviso("Form de entrega (SigOpEnt) n" + CHR(227) + "o dispon" + ;
1462:                          CHR(237) + "vel.", "Entrega")
1463:             ENDIF
1464:         CATCH TO loException
1465:             MsgAviso("Form de entrega (SigOpEnt) n" + CHR(227) + "o dispon" + ;
1466:                      CHR(237) + "vel.", "Entrega")
1467:         ENDTRY
1468:     ENDPROC
1469: 
1470:     *==========================================================================
1471:     * BtnSubNiveisClick - Abre form de subniveis SigMvSbn (se disponivel)
1472:     *==========================================================================
1473:     PROCEDURE BtnSubNiveisClick()
1474:         LOCAL loc_oBO, loForm, loException
1475:         loc_oBO = THIS.this_oBusinessObject
1476: 
1477:         IF EMPTY(loc_oBO.this_cEmpDopNums)
1478:             MsgAviso("Nenhum movimento carregado.", "Sub" + CHR(237) + "veis")
1479:             RETURN
1480:         ENDIF
1481: 
1482:         TRY
1483:             loForm = CREATEOBJECT("Formsigmvsbn")
1484:             IF VARTYPE(loForm) = "O"
1485:                 loForm.Show()
1486:             ELSE
1487:                 MsgAviso("Form de sub" + CHR(237) + "veis (SigMvSbn) n" + CHR(227) + ;
1488:                          "o dispon" + CHR(237) + "vel.", "Sub" + CHR(237) + "veis")
1489:             ENDIF
1490:         CATCH TO loException
1491:             MsgAviso("Form de sub" + CHR(237) + "veis (SigMvSbn) n" + CHR(227) + ;
1492:                      "o dispon" + CHR(237) + "vel.", "Sub" + CHR(237) + "veis")
1493:         ENDTRY
1494:     ENDPROC
1495: 
1496:     *==========================================================================
1497:     * CarregarItensGrid - Carrega itens do movimento em grd_4c_Itens
1498:     * JOIN SigMvPec + SigCdPam para descricao do produto (DPros)
1499:     *==========================================================================
1500:     PROTECTED PROCEDURE CarregarItensGrid()
1501:         LOCAL loc_cEmpDopNums, loc_cSQL, loc_nResultado, loc_oGrid, loc_lSucesso
1502:         loc_cEmpDopNums = ""
1503:         loc_lSucesso    = .F.
1504: 
1505:         TRY
1506:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1507:                 loc_lSucesso = .T.
1508:             ELSE
1509:                 loc_cEmpDopNums = THIS.this_oBusinessObject.this_cEmpDopNums
1510: 
1511:                 IF !EMPTY(loc_cEmpDopNums)
1512:                     IF USED("cursor_4c_ItensPam")
1513:                         USE IN cursor_4c_ItensPam
1514:                     ENDIF
1515: 
1516:                     loc_cSQL = "SELECT a.Codigos AS CPros," + ;
1517:                                " ISNULL(a.Cidchaves, 0) AS Produzido," + ;
1518:                                " ISNULL(a.Ntrans, 0) AS Ntrans," + ;
1519:                                " (ISNULL(a.Ntrans, 0) - ISNULL(a.Valobxs, 0)) AS Saldo," + ;
1520:                                " ISNULL(a.Valobxs, 0) AS Valobxs," + ;
1521:                                " CASE WHEN (ISNULL(a.Ntrans,0)-ISNULL(a.Valobxs,0)-ISNULL(a.Cidchaves,0))>0" + ;
1522:                                " THEN (ISNULL(a.Ntrans,0)-ISNULL(a.Valobxs,0)-ISNULL(a.Cidchaves,0))" + ;
1523:                                " ELSE 0 END AS Produzir," + ;
1524:                                " ISNULL(a.Nparcs, 0) AS Nparcs," + ;
1525:                                " CAST(0 AS DECIMAL(8,2)) AS Pesos," + ;
1526:                                " CASE WHEN ISNULL(a.Ntrans,0)>0" + ;
1527:                                " THEN CAST((ISNULL(a.Valobxs,0)*100.0/a.Ntrans) AS DECIMAL(8,2))" + ;
1528:                                " ELSE CAST(0 AS DECIMAL(8,2)) END AS PctEnt," + ;
1529:                                " ISNULL(a.Locals,'') AS Locals," + ;
1530:                                " ISNULL(p.DPros,'') AS DPros" + ;
1531:                                " FROM SigMvPec a" + ;
1532:                                " LEFT JOIN SigCdPam p ON p.MascNums = a.Codigos" + ;
1533:                                " WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + ;
1534:                                " ORDER BY a.Codigos"
1535: 
1536:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensPam")
1537: 
1538:                     IF loc_nResultado >= 0
1539:                         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
1540: 
1541:                         IF VARTYPE(loc_oGrid) = "O"
1542:                             loc_oGrid.ColumnCount = 10
1543:                             loc_oGrid.RecordSource = "cursor_4c_ItensPam"
1544: 
1545:                             loc_oGrid.Column1.ControlSource  = "cursor_4c_ItensPam.CPros"
1546:                             loc_oGrid.Column2.ControlSource  = "cursor_4c_ItensPam.Produzido"
1547:                             loc_oGrid.Column3.ControlSource  = "cursor_4c_ItensPam.Ntrans"
1548:                             loc_oGrid.Column4.ControlSource  = "cursor_4c_ItensPam.Saldo"
1549:                             loc_oGrid.Column5.ControlSource  = "cursor_4c_ItensPam.Valobxs"
1550:                             loc_oGrid.Column6.ControlSource  = "cursor_4c_ItensPam.Produzir"
1551:                             loc_oGrid.Column7.ControlSource  = "cursor_4c_ItensPam.Nparcs"
1552:                             loc_oGrid.Column8.ControlSource  = "cursor_4c_ItensPam.Pesos"
1553:                             loc_oGrid.Column9.ControlSource  = "cursor_4c_ItensPam.PctEnt"
1554:                             loc_oGrid.Column10.ControlSource = "cursor_4c_ItensPam.Locals"
1555: 
1556:                             loc_oGrid.Column1.Width  = 80
1557:                             loc_oGrid.Column2.Width  = 65
1558:                             loc_oGrid.Column3.Width  = 55
1559:                             loc_oGrid.Column4.Width  = 55
1560:                             loc_oGrid.Column5.Width  = 60
1561:                             loc_oGrid.Column6.Width  = 55
1562:                             loc_oGrid.Column7.Width  = 35
1563:                             loc_oGrid.Column8.Width  = 55
1564:                             loc_oGrid.Column9.Width  = 45
1565:                             loc_oGrid.Column10.Width = 40
1566: 
1567:                             loc_oGrid.Column1.Header1.Caption  = "Produto"
1568:                             loc_oGrid.Column2.Header1.Caption  = "Produzido"
1569:                             loc_oGrid.Column3.Header1.Caption  = "Qtd."

*-- Linhas 1575 a 1596:
1575:                             loc_oGrid.Column9.Header1.Caption  = "%Ent."
1576:                             loc_oGrid.Column10.Header1.Caption = "Tam."
1577: 
1578:                             loc_oGrid.Refresh()
1579: 
1580:                             IF RECCOUNT("cursor_4c_ItensPam") > 0
1581:                                 SELECT cursor_4c_ItensPam
1582:                                 GO TOP
1583:                                 THIS.GrdItensAfterRowColChange(0)
1584:                             ELSE
1585:                                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_Descr) = "O"
1586:                                     THIS.pgf_4c_Paginas.Page2.txt_4c_Descr.Value = ""
1587:                                 ENDIF
1588:                                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_ObsItem) = "O"
1589:                                     THIS.pgf_4c_Paginas.Page2.txt_4c_ObsItem.Value = ""
1590:                                 ENDIF
1591:                                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg) = "O"
1592:                                     THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg.Picture = ""
1593:                                     THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg.Visible = .F.
1594:                                 ENDIF
1595:                             ENDIF
1596:                         ENDIF

*-- Linhas 1612 a 1655:
1612:     *==========================================================================
1613:     * GrdItensAfterRowColChange - Atualiza descricao, obs e imagem do item
1614:     *==========================================================================
1615:     PROCEDURE GrdItensAfterRowColChange(par_nColIndex)
1616:         LOCAL loc_oPagina, loc_cCPros, loc_cDPros, loc_cSQLFig, loc_nFig
1617:         LOCAL loc_cFigJpgs, loc_lVazio
1618:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
1619:         loc_cCPros   = ""
1620:         loc_cDPros   = ""
1621:         loc_cSQLFig  = ""
1622:         loc_nFig     = 0
1623:         loc_cFigJpgs = ""
1624:         loc_lVazio   = .F.
1625: 
1626:         TRY
1627:             IF !USED("cursor_4c_ItensPam") OR EOF("cursor_4c_ItensPam")
1628:                 loc_lVazio = .T.
1629:             ELSE
1630:                 SELECT cursor_4c_ItensPam
1631:                 loc_cCPros = ALLTRIM(TratarNulo(CPros, "C"))
1632:                 loc_cDPros = ALLTRIM(TratarNulo(DPros, "C"))
1633:             ENDIF
1634: 
1635:             IF loc_lVazio
1636:                 IF VARTYPE(loc_oPagina.txt_4c_Descr) = "O"
1637:                     loc_oPagina.txt_4c_Descr.Value = ""
1638:                 ENDIF
1639:                 IF VARTYPE(loc_oPagina.txt_4c_ObsItem) = "O"
1640:                     loc_oPagina.txt_4c_ObsItem.Value = ""
1641:                 ENDIF
1642:                 IF VARTYPE(loc_oPagina.img_4c_FigJpg) = "O"
1643:                     loc_oPagina.img_4c_FigJpg.Picture = ""
1644:                     loc_oPagina.img_4c_FigJpg.Visible = .F.
1645:                 ENDIF
1646:             ELSE
1647:                 IF VARTYPE(loc_oPagina.txt_4c_Descr) = "O"
1648:                     loc_oPagina.txt_4c_Descr.Value = loc_cDPros
1649:                 ENDIF
1650:                 IF VARTYPE(loc_oPagina.txt_4c_ObsItem) = "O"
1651:                     loc_oPagina.txt_4c_ObsItem.Value = ""
1652:                 ENDIF
1653: 
1654:                 *-- Imagem do produto via SigCdPro.FigJpgs
1655:                 IF !EMPTY(loc_cCPros)

*-- Linhas 1686 a 1847:
1686:     *==========================================================================
1687:     * ImgFigJpgClick - Abre imagem do produto no visualizador padrao
1688:     *==========================================================================
1689:     PROCEDURE ImgFigJpgClick()
1690:         LOCAL loc_cPicture
1691:         loc_cPicture = ""
1692: 
1693:         TRY
1694:             IF VARTYPE(THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg) = "O"
1695:                 loc_cPicture = THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg.Picture
1696:             ENDIF
1697:             IF !EMPTY(loc_cPicture) AND FILE(loc_cPicture)
1698:                 DECLARE INTEGER ShellExecute IN shell32 ;
1699:                     INTEGER hwnd, STRING lpVerb, STRING lpFile, ;
1700:                     STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
1701:                 ShellExecute(0, "open", loc_cPicture, "", "", 1)
1702:             ENDIF
1703:         CATCH TO loException
1704:             MostrarErro(loException, "Formsigpres2.ImgFigJpgClick")
1705:         ENDTRY
1706:     ENDPROC
1707: 
1708:     *==========================================================================
1709:     * BtnIncluirClick - Nao aplicavel: form OPERACIONAL (consulta apenas)
1710:     * Original: Inlist(This.Value, 1,3,4,5) -> mAtivaPagina1 (retorna lista)
1711:     *==========================================================================
1712:     PROCEDURE BtnIncluirClick()
1713:         THIS.AlternarPagina(1)
1714:     ENDPROC
1715: 
1716:     *==========================================================================
1717:     * BtnAlterarClick - Nao aplicavel: form OPERACIONAL (consulta apenas)
1718:     * Original: Inlist(This.Value, 1,3,4,5) -> mAtivaPagina1 (retorna lista)
1719:     *==========================================================================
1720:     PROCEDURE BtnAlterarClick()
1721:         THIS.AlternarPagina(1)
1722:     ENDPROC
1723: 
1724:     *==========================================================================
1725:     * BtnVisualizarClick - Carrega movimento selecionado e navega para Page2
1726:     * Equivalente ao BtnConsultarClick (Value=2 no CommandGroup original)
1727:     *==========================================================================
1728:     PROCEDURE BtnVisualizarClick()
1729:         THIS.BtnConsultarClick()
1730:     ENDPROC
1731: 
1732:     *==========================================================================
1733:     * BtnExcluirClick - Nao aplicavel: form OPERACIONAL (consulta apenas)
1734:     * Original: Inlist(This.Value, 1,3,4,5) -> mAtivaPagina1 (retorna lista)
1735:     *==========================================================================
1736:     PROCEDURE BtnExcluirClick()
1737:         THIS.AlternarPagina(1)
1738:     ENDPROC
1739: 
1740:     *==========================================================================
1741:     * BtnCadastrosClick - Abre cadastro da conta destino selecionada
1742:     *==========================================================================
1743:     PROCEDURE BtnCadastrosClick()
1744:         LOCAL loc_cContaD, loForm
1745:         loc_cContaD = ""
1746: 
1747:         TRY
1748:             IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem) = "O"
1749:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_ContaD) = "O"
1750:                     loc_cContaD = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_ContaD.Value)
1751:                 ENDIF
1752:             ENDIF
1753: 
1754:             IF EMPTY(loc_cContaD)
1755:                 MsgAviso("Nenhuma conta destino definida.", "Cadastro")
1756:             ELSE
1757:                 loForm = CREATEOBJECT("Formsigcdcli")
1758:                 IF VARTYPE(loForm) = "O"
1759:                     loForm.Show()
1760:                 ELSE
1761:                     MsgAviso("Form de cadastro de contas n" + CHR(227) + ;
1762:                              "o dispon" + CHR(237) + "vel.", "Cadastro")
1763:                 ENDIF
1764:             ENDIF
1765:         CATCH TO loException
1766:             MostrarErro(loException, "Formsigpres2.BtnCadastrosClick")
1767:         ENDTRY
1768:     ENDPROC
1769: 
1770:     *==========================================================================
1771:     * BtnBuscarClick - Recarrega lista de movimentos (Procurar oculto no original)
1772:     *==========================================================================
1773:     PROCEDURE BtnBuscarClick()
1774:         TRY
1775:             THIS.CarregarLista()
1776:         CATCH TO loException
1777:             MostrarErro(loException, "Formsigpres2.BtnBuscarClick")
1778:         ENDTRY
1779:     ENDPROC
1780: 
1781:     *==========================================================================
1782:     * BtnSalvarClick - Alias de BtnConfirmarClick (confirmar consulta = volta lista)
1783:     *==========================================================================
1784:     PROCEDURE BtnSalvarClick()
1785:         THIS.BtnConfirmarClick()
1786:     ENDPROC
1787: 
1788:     *==========================================================================
1789:     * FormParaBO - Nao aplicavel: form OPERACIONAL (todos campos ReadOnly)
1790:     * Implementado para conformidade com a interface padrao FormBase
1791:     *==========================================================================
1792:     PROTECTED PROCEDURE FormParaBO()
1793:         RETURN .T.
1794:     ENDPROC
1795: 
1796:     *==========================================================================
1797:     * HabilitarCampos - Nao aplicavel: form OPERACIONAL (todos ReadOnly)
1798:     * Implementado para conformidade com a interface padrao FormBase
1799:     *==========================================================================
1800:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1801:         RETURN .T.
1802:     ENDPROC
1803: 
1804:     *==========================================================================
1805:     * LimparCampos - Limpa todos os campos de exibicao da Page2
1806:     *==========================================================================
1807:     PROTECTED PROCEDURE LimparCampos()
1808:         LOCAL loc_oPg2, loc_oCnt
1809:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1810: 
1811:         TRY
1812:             IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
1813:                 loc_oPg2.txt_4c_Codigo.Value = ""
1814:             ENDIF
1815:             IF VARTYPE(loc_oPg2.txt_4c_Data) = "O"
1816:                 loc_oPg2.txt_4c_Data.Value = {}
1817:             ENDIF
1818:             IF VARTYPE(loc_oPg2.txt_4c_PrvEnts) = "O"
1819:                 loc_oPg2.txt_4c_PrvEnts.Value = {}
1820:             ENDIF
1821:             IF VARTYPE(loc_oPg2.txt_4c_Nop) = "O"
1822:                 loc_oPg2.txt_4c_Nop.Value = ""
1823:             ENDIF
1824:             IF VARTYPE(loc_oPg2.txt_4c_Nota) = "O"
1825:                 loc_oPg2.txt_4c_Nota.Value = ""
1826:             ENDIF
1827:             IF VARTYPE(loc_oPg2.txt_4c_Tabd) = "O"
1828:                 loc_oPg2.txt_4c_Tabd.Value = ""
1829:             ENDIF
1830:             IF VARTYPE(loc_oPg2.txt_4c_PStatus) = "O"
1831:                 loc_oPg2.txt_4c_PStatus.Value = ""
1832:             ENDIF
1833:             IF VARTYPE(loc_oPg2.txt_4c_Descr) = "O"
1834:                 loc_oPg2.txt_4c_Descr.Value = ""
1835:             ENDIF
1836:             IF VARTYPE(loc_oPg2.txt_4c_ObsItem) = "O"
1837:                 loc_oPg2.txt_4c_ObsItem.Value = ""
1838:             ENDIF
1839: 
1840:             loc_oCnt = loc_oPg2.cnt_4c_Origem
1841:             IF VARTYPE(loc_oCnt) = "O"
1842:                 IF VARTYPE(loc_oCnt.txt_4c_GrupoOs) = "O"
1843:                     loc_oCnt.txt_4c_GrupoOs.Value = ""
1844:                 ENDIF
1845:                 IF VARTYPE(loc_oCnt.txt_4c_ContaOs) = "O"
1846:                     loc_oCnt.txt_4c_ContaOs.Value = ""
1847:                 ENDIF

*-- Linhas 1888 a 1928:
1888:     * LISTA: habilita Consultar, desabilita botoes de Page2
1889:     * VISUALIZAR: habilita Confirmar/Cancelar, SubNiveis, Entrega
1890:     *==========================================================================
1891:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1892:         LOCAL loc_oPg1, loc_oPg2, loc_lLista
1893:         loc_lLista = (THIS.this_cModoAtual == "LISTA")
1894: 
1895:         TRY
1896:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1897:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1898: 
1899:             *-- Page1: botao Consultar habilitado apenas no modo LISTA
1900:             IF VARTYPE(loc_oPg1.cnt_4c_Botoes) = "O"
1901:                 IF VARTYPE(loc_oPg1.cnt_4c_Botoes.cmd_4c_Consultar) = "O"
1902:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Consultar.Enabled = loc_lLista
1903:                 ENDIF
1904:             ENDIF
1905: 
1906:             *-- Page2: botoes de acao habilitados apenas no modo VISUALIZAR
1907:             IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
1908:                 IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar) = "O"
1909:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = !loc_lLista
1910:                 ENDIF
1911:                 IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar) = "O"
1912:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = !loc_lLista
1913:                 ENDIF
1914:             ENDIF
1915: 
1916:             IF VARTYPE(loc_oPg2.cmd_4c_SubNiveis) = "O"
1917:                 loc_oPg2.cmd_4c_SubNiveis.Enabled = !loc_lLista
1918:             ENDIF
1919: 
1920:             IF VARTYPE(loc_oPg2.cmd_4c_Entrega) = "O"
1921:                 loc_oPg2.cmd_4c_Entrega.Enabled = !loc_lLista
1922:             ENDIF
1923:         CATCH TO loException
1924:             MostrarErro(loException, "Formsigpres2.AjustarBotoesPorModo")
1925:         ENDTRY
1926:     ENDPROC
1927: 
1928: ENDDEFINE


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
                       " FROM SigMvCab a" + ;
                       " WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopes)

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " AND " + par_cFiltro
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

