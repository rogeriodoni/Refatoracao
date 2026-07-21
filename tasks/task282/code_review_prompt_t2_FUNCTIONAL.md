# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'Origem' (parent: SIGPRES2.Pagina.Dados): Top original=173 vs migrado 'cnt_4c_Origem' Top=5 (diff=168px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2026 linhas total):

*-- Linhas 4 a 167:
4: * Tipo: Operacional (detalhe de pedido - aberto pelo form pai)
5: * Tabela: SigMvPec / SigMvItn
6: *==============================================================================
7: SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg") ADDITIVE
8: 
9: DEFINE CLASS Formsigpres2 AS FormBase
10: 
11:     *-- Propriedades visuais (PILAR 1 - UX Fidelity)
12:     Height      = 600
13:     Width       = 1000
14:     Caption     = "Pedido de Estoque"
15:     AutoCenter  = .T.
16:     ShowWindow  = 1
17:     WindowType  = 1
18:     ControlBox  = .F.
19:     TitleBar    = 0
20:     Themes      = .F.
21:     BorderStyle = 2
22:     DataSession = 2
23: 
24:     *-- Business object e estado
25:     this_oBusinessObject = .NULL.
26:     this_cModoAtual      = "LISTA"
27: 
28:     *-- Propriedades especificas do SIGPRES2
29:     this_cDopes         = ""
30:     this_oParentForm    = .NULL.
31:     this_cPcEscolha     = ""
32:     this_lPlCancelar    = .F.
33:     this_lPlAcinserir   = .F.
34:     this_lPlAcalterar   = .F.
35:     this_lPlAcexcluir   = .F.
36:     this_cEmpdopnums    = ""
37: 
38:     *--------------------------------------------------------------------------
39:     * Init - Aceita parametros do form pai: tipo de operacao e referencia
40:     * par_cChave        = descricao/tipo de operacao (Caption + cDopes)
41:     * par_nDataSession  = datasession do pai (legado - nao usada no novo sistema)
42:     * par_oParentForm   = referencia ao form que abriu este
43:     *--------------------------------------------------------------------------
44:     PROCEDURE Init(par_cChave, par_nDataSession, par_oParentForm)
45:         LOCAL loc_lResultado
46:         loc_lResultado = .F.
47:         TRY
48:             IF VARTYPE(par_cChave) = "C" AND !EMPTY(ALLTRIM(par_cChave))
49:                 THIS.this_cDopes = ALLTRIM(par_cChave)
50:                 THIS.Caption     = ALLTRIM(par_cChave)
51:             ENDIF
52:             IF VARTYPE(par_oParentForm) = "O"
53:                 THIS.this_oParentForm = par_oParentForm
54:             ENDIF
55:             loc_lResultado = DODEFAULT()
56:         CATCH TO loc_oErro
57:             MsgErro(loc_oErro.Message, "Erro")
58:         ENDTRY
59:         RETURN loc_lResultado
60:     ENDPROC
61: 
62:     *--------------------------------------------------------------------------
63:     * InicializarForm - Configura estrutura base do formulario
64:     *--------------------------------------------------------------------------
65:     PROTECTED PROCEDURE InicializarForm()
66:         LOCAL loc_lResultado
67:         loc_lResultado = .F.
68:         TRY
69:             THIS.this_oBusinessObject = CREATEOBJECT("sigpres2BO")
70: 
71:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
72:                 *-- Carregar dados do csTemporario (cursor passado pelo form pai)
73:                 IF USED("csTemporario")
74:                     GO TOP IN csTemporario
75:                     THIS.this_oBusinessObject.CarregarDoCursorTemporario("csTemporario")
76:                     THIS.this_cEmpdopnums = THIS.this_oBusinessObject.this_cEmpdopnums
77:                 ENDIF
78:                 THIS.this_oBusinessObject.CarregarMascaraNumeracao()
79:                 IF !EMPTY(THIS.this_cDopes)
80:                     THIS.this_oBusinessObject.CarregarTipoOperacao(THIS.this_cDopes)
81:                 ENDIF
82:             ENDIF
83: 
84:             THIS.ConfigurarPageFrame()
85:             THIS.ConfigurarPaginaLista()
86:             THIS.ConfigurarPaginaDados()
87: 
88:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
89:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
90: 
91:             THIS.pgf_4c_Paginas.Visible = .T.
92:             THIS.pgf_4c_Paginas.ActivePage = 1
93:             THIS.this_cModoAtual = "LISTA"
94: 
95:             loc_lResultado = .T.
96:         CATCH TO loc_oErro
97:             MsgErro(loc_oErro.Message, "Erro")
98:         ENDTRY
99:         RETURN loc_lResultado
100:     ENDPROC
101: 
102:     *--------------------------------------------------------------------------
103:     * ConfigurarPageFrame - PageFrame com 2 paginas (Top=-29, Tabs=.F.)
104:     *--------------------------------------------------------------------------
105:     PROTECTED PROCEDURE ConfigurarPageFrame()
106:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
107:         WITH THIS.pgf_4c_Paginas
108:             .PageCount = 2
109:             .Top       = -29
110:             .Left      = 0
111:             .Width     = THIS.Width
112:             .Height    = THIS.Height + 29
113:             .Tabs      = .F.
114:             .Page1.Caption   = "Lista"
115:             .Page2.Caption   = "Dados"
116:             .Page1.BackColor = RGB(255, 255, 255)
117:             .Page2.BackColor = RGB(255, 255, 255)
118:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
119:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
120:             .Visible = .T.
121:         ENDWITH
122:     ENDPROC
123: 
124:     *--------------------------------------------------------------------------
125:     * ConfigurarPaginaLista - Page1: cabecalho + grade (csTemporario) + botoes
126:     *--------------------------------------------------------------------------
127:     PROTECTED PROCEDURE ConfigurarPaginaLista()
128:         LOCAL loc_oPagina, loc_oGrid
129:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
130: 
131:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
132:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
133: 
134:         *-- Cabecalho escuro (cntSombra no legado): Top=1+29=30
135:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
136:         WITH loc_oPagina.cnt_4c_Cabecalho
137:             .Top         = 30
138:             .Left        = 0
139:             .Width       = THIS.Width
140:             .Height      = 80
141:             .BackColor   = RGB(100, 100, 100)
142:             .BorderWidth = 0
143:             .Visible     = .T.
144: 
145:             .AddObject("lbl_4c_Sombra", "Label")
146:             WITH .lbl_4c_Sombra
147:                 .Caption   = THIS.Caption
148:                 .Top       = 15
149:                 .Left      = 10
150:                 .Width     = THIS.Width
151:                 .Height    = 40
152:                 .AutoSize  = .F.
153:                 .FontName  = "Tahoma"
154:                 .FontSize  = 16
155:                 .FontBold  = .T.
156:                 .ForeColor = RGB(0, 0, 0)
157:                 .BackStyle = 0
158:                 .Visible   = .T.
159:             ENDWITH
160: 
161:             .AddObject("lbl_4c_Titulo", "Label")
162:             WITH .lbl_4c_Titulo
163:                 .Caption   = THIS.Caption
164:                 .Top       = 18
165:                 .Left      = 10
166:                 .Width     = THIS.Width
167:                 .Height    = 46

*-- Linhas 318 a 371:
318:             .Column11.Header1.Caption = "EmpD"
319:         ENDWITH
320: 
321:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Consultar, "Click", THIS, "BtnConsultarClick")
322:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
323: 
324:         THIS.FormatarGridLista(loc_oGrid)
325:         THIS.TornarControlesVisiveis(loc_oPagina)
326:     ENDPROC
327: 
328:     *--------------------------------------------------------------------------
329:     * ConfigurarPaginaDados - Page2: botoes, grade operacoes, campos header
330:     *--------------------------------------------------------------------------
331:     PROTECTED PROCEDURE ConfigurarPaginaDados()
332:         LOCAL loc_oPagina, loc_oGrid
333:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
334: 
335:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
336:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
337: 
338:         *-- Container salvar/cancelar (Grupo_Salva no legado)
339:         *-- Top=4+29=33, Left=829, Width=160, Height=85
340:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
341:         WITH loc_oPagina.cnt_4c_Salva
342:             .Top         = 33
343:             .Left        = 829
344:             .Width       = 160
345:             .Height      = 85
346:             .BackStyle   = 0
347:             .BorderWidth = 0
348:             .Visible     = .T.
349: 
350:             .AddObject("cmd_4c_Confirmar", "CommandButton")
351:             WITH .cmd_4c_Confirmar
352:                 .Caption         = "Confirmar"
353:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
354:                 .PicturePosition = 13
355:                 .Top             = 5
356:                 .Left            = 5
357:                 .Width           = 75
358:                 .Height          = 75
359:                 .BackColor       = RGB(255, 255, 255)
360:                 .ForeColor       = RGB(90, 90, 90)
361:                 .FontName        = "Tahoma"
362:                 .FontBold        = .T.
363:                 .FontItalic      = .T.
364:                 .FontSize        = 8
365:                 .SpecialEffect   = 0
366:                 .MousePointer    = 15
367:                 .WordWrap        = .T.
368:                 .AutoSize        = .F.
369:                 .Visible         = .T.
370:             ENDWITH
371: 

*-- Linhas 705 a 728:
705:             .MousePointer  = 15
706:             .AutoSize      = .F.
707:             .Visible       = .T.
708:         ENDWITH
709: 
710:         *-- Container Origem/Destino/Representante (cnt_4c_Origem)
711:         *-- Top=173+29=202, Left=27, Width=582, Height=164
712:         loc_oPagina.AddObject("cnt_4c_Origem", "Container")
713:         WITH loc_oPagina.cnt_4c_Origem
714:             .Top         = 202
715:             .Left        = 27
716:             .Width       = 582
717:             .Height      = 164
718:             .BackStyle   = 1
719:             .BackColor   = RGB(240, 240, 240)
720:             .BorderWidth = 0
721:             .Visible     = .T.
722: 
723:             *-- Say8 "Origem"
724:             .AddObject("lbl_4c_LblOrigem", "Label")
725:             WITH .lbl_4c_LblOrigem
726:                 .Caption   = "Origem"
727:                 .Top       = 5
728:                 .Left      = 5

*-- Linhas 1223 a 1416:
1223:             .Visible       = .T.
1224:         ENDWITH
1225: 
1226:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar,         "Click",             THIS, "BtnConfirmarClick")
1227:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,          "Click",             THIS, "BtnCancelarClick")
1228:         BINDEVENT(loc_oPagina.cmd_4c_Entrega,                         "Click",             THIS, "BtnEntregaClick")
1229:         BINDEVENT(loc_oPagina.cmd_4c_SubNiveis,                       "Click",             THIS, "BtnSubNiveisClick")
1230:         BINDEVENT(loc_oPagina.grd_4c_Itens,                           "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
1231:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaO,            "KeyPress",          THIS, "ContaOKeyPress")
1232:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaO,            "DblClick",          THIS, "ContaODblClick")
1233:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaD,            "KeyPress",          THIS, "ContaDKeyPress")
1234:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaD,            "DblClick",          THIS, "ContaDDblClick")
1235:         BINDEVENT(loc_oPagina.cnt_4c_Origem.cmd_4c_BtnCadastros,      "Click",             THIS, "BtnCadastrosClick")
1236:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_DcontaD,           "KeyPress",         THIS, "DcontaDLostFocus")
1237:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_Dresps,            "KeyPress",         THIS, "DrespsDLostFocus")
1238: 
1239:         THIS.TornarControlesVisiveis(loc_oPagina)
1240:     ENDPROC
1241: 
1242:     *--------------------------------------------------------------------------
1243:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
1244:     *--------------------------------------------------------------------------
1245:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1246:         LOCAL loc_lResultado
1247:         loc_lResultado = .F.
1248:         TRY
1249:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1250:                 loc_lResultado = .F.
1251:             ELSE
1252:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1253:                 IF par_nPagina = 1
1254:                     THIS.pgf_4c_Paginas.Page1.Enabled = .T.
1255:                     THIS.this_cPcEscolha = ""
1256:                     THIS.CarregarLista()
1257:                 ENDIF
1258:                 loc_lResultado = .T.
1259:             ENDIF
1260:         CATCH TO loc_oErro
1261:             MsgErro(loc_oErro.Message, "Erro")
1262:         ENDTRY
1263:         RETURN loc_lResultado
1264:     ENDPROC
1265: 
1266:     *--------------------------------------------------------------------------
1267:     * CarregarLista - Vincula grid ao csTemporario e redefine headers
1268:     *--------------------------------------------------------------------------
1269:     PROCEDURE CarregarLista()
1270:         LOCAL loc_lResultado, loc_oGrid
1271:         loc_lResultado = .F.
1272:         TRY
1273:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1274:                 loc_lResultado = .T.
1275:             ELSE
1276:                 IF USED("csTemporario")
1277:                 GO TOP IN csTemporario
1278:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1279:                 loc_oGrid.RecordSource = "csTemporario"
1280:                 loc_oGrid.Column1.ControlSource    = "csTemporario.Numes"
1281:                 loc_oGrid.Column2.ControlSource    = "csTemporario.Datas"
1282:                 loc_oGrid.Column3.ControlSource    = "csTemporario.GrupoOs"
1283:                 loc_oGrid.Column4.ControlSource    = "csTemporario.ContaOs"
1284:                 loc_oGrid.Column5.ControlSource    = "csTemporario.GrupoDs"
1285:                 loc_oGrid.Column6.ControlSource    = "csTemporario.ContaDs"
1286:                 loc_oGrid.Column7.ControlSource    = "csTemporario.Nops"
1287:                 loc_oGrid.Column8.ControlSource    = "csTemporario.Usuars"
1288:                 loc_oGrid.Column9.ControlSource    = "csTemporario.PStatus"
1289:                 loc_oGrid.Column10.ControlSource   = "csTemporario.Emps"
1290:                 loc_oGrid.Column11.ControlSource   = "csTemporario.Empds"
1291:                 loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
1292:                 loc_oGrid.Column2.Header1.Caption  = "Data"
1293:                 loc_oGrid.Column3.Header1.Caption  = "Grupo"
1294:                 loc_oGrid.Column4.Header1.Caption  = "Origem"
1295:                 loc_oGrid.Column5.Header1.Caption  = "Grupo"
1296:                 loc_oGrid.Column6.Header1.Caption  = "Destino"
1297:                 loc_oGrid.Column7.Header1.Caption  = "Doc.Op"
1298:                 loc_oGrid.Column8.Header1.Caption  = "Usu" + CHR(225) + "rio"
1299:                 loc_oGrid.Column9.Header1.Caption  = "Status"
1300:                 loc_oGrid.Column10.Header1.Caption = "EmpO"
1301:                 loc_oGrid.Column11.Header1.Caption = "EmpD"
1302:                 loc_oGrid.Refresh()
1303:                 THIS.FormatarGridLista(loc_oGrid)
1304:                 loc_lResultado = .T.
1305:                 ENDIF
1306:             ENDIF
1307:         CATCH TO loc_oErro
1308:             MsgErro(loc_oErro.Message, "Erro")
1309:         ENDTRY
1310:         RETURN loc_lResultado
1311:     ENDPROC
1312: 
1313:     *--------------------------------------------------------------------------
1314:     * BtnConsultarClick - Navega para Page2 carregando dados do registro atual
1315:     *--------------------------------------------------------------------------
1316:     PROCEDURE BtnConsultarClick()
1317:         LOCAL loc_lResultado, loc_oPg2
1318:         loc_lResultado = .F.
1319:         TRY
1320:             IF !USED("csTemporario") OR EOF("csTemporario")
1321:                 MsgAviso("Selecione um registro na lista!", "")
1322:             ELSE
1323:                 THIS.this_cPcEscolha = "CONSULTAR"
1324:                 THIS.pgf_4c_Paginas.Page1.Enabled = .F.
1325:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1326: 
1327:                 SELECT csTemporario
1328:                 *-- Preencher campos basicos a partir do cursor csTemporario
1329:                 loc_oPg2.txt_4c_Codigo.Value  = ALLTRIM(TRANSFORM(csTemporario.Numes))
1330:                 loc_oPg2.txt_4c_Data.Value    = IIF(EMPTY(csTemporario.Datas), {}, csTemporario.Datas)
1331:                 loc_oPg2.txt_4c_PrvEnts.Value = IIF(EMPTY(csTemporario.PrazoEnts), {}, csTemporario.PrazoEnts)
1332:                 loc_oPg2.txt_4c_Nop.Value     = ALLTRIM(NVL(csTemporario.Nops, ""))
1333:                 loc_oPg2.txt_4c_PStatus.Value = ALLTRIM(NVL(csTemporario.PStatus, ""))
1334: 
1335:                 *-- Guardar chave composta do pedido (Emps+Dopes+Numes)
1336:                 THIS.this_cEmpdopnums = ALLTRIM(csTemporario.Emps) + ;
1337:                     ALLTRIM(csTemporario.Dopes) + ;
1338:                     TRANSFORM(csTemporario.Numes, "@@@@@@")
1339: 
1340:                 *-- Carregar grade de tipos de operacao
1341:                 THIS.CarregarGradeOperacao()
1342: 
1343:                 *-- Carregar propriedades do BO a partir do cursor
1344:                 THIS.this_oBusinessObject.CarregarDoCursorTemporario("csTemporario")
1345: 
1346:                 *-- Preencher campos Origem/Destino
1347:                 THIS.CarregarCamposOrigem()
1348: 
1349:                 *-- Carregar grade de itens do pedido
1350:                 THIS.CarregarGradeItens()
1351: 
1352:                 THIS.pgf_4c_Paginas.ActivePage = 2
1353:                 loc_lResultado = .T.
1354:             ENDIF
1355:         CATCH TO loc_oErro
1356:             MsgErro(loc_oErro.Message, "Erro")
1357:         ENDTRY
1358:         RETURN loc_lResultado
1359:     ENDPROC
1360: 
1361:     *--------------------------------------------------------------------------
1362:     * BtnEncerrarClick - Fecha o formulario
1363:     *--------------------------------------------------------------------------
1364:     PROCEDURE BtnEncerrarClick()
1365:         LOCAL loc_oErro
1366:         TRY
1367:             THIS.Release()
1368:         CATCH TO loc_oErro
1369:             MsgErro(loc_oErro.Message, "Erro")
1370:         ENDTRY
1371:     ENDPROC
1372: 
1373:     *--------------------------------------------------------------------------
1374:     * CarregarCamposOrigem - Preenche campos de Origem/Destino do cnt_4c_Origem
1375:     *--------------------------------------------------------------------------
1376:     PROCEDURE CarregarCamposOrigem()
1377:         LOCAL loc_lResultado, loc_oCnt, loc_oBO
1378:         loc_lResultado = .F.
1379:         TRY
1380:             loc_oBO  = THIS.this_oBusinessObject
1381:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem
1382: 
1383:             loc_oCnt.txt_4c_GrupoO.Value  = ALLTRIM(NVL(loc_oBO.this_cGrupoOs, ""))
1384:             loc_oCnt.txt_4c_ContaO.Value  = ALLTRIM(NVL(loc_oBO.this_cContaOs, ""))
1385:             loc_oCnt.txt_4c_GrupoD.Value  = ALLTRIM(NVL(loc_oBO.this_cGrupoDs, ""))
1386:             loc_oCnt.txt_4c_ContaD.Value  = ALLTRIM(NVL(loc_oBO.this_cContaDs, ""))
1387:             loc_oCnt.txt_4c_Dresps.Value  = ALLTRIM(NVL(loc_oBO.this_cDresps, ""))
1388: 
1389:             *-- Descricao da conta de Origem
1390:             loc_oBO.CarregarDescricaoCliente(ALLTRIM(NVL(loc_oBO.this_cContaOs, "")))
1391:             loc_oCnt.txt_4c_DcontaO.Value = ALLTRIM(NVL(loc_oBO.this_cDconta, ""))
1392: 
1393:             *-- Descricao da conta de Destino via SQL (SigCdCli)
1394:             LOCAL loc_cSQL, loc_nRes
1395:             IF !EMPTY(ALLTRIM(NVL(loc_oBO.this_cContaDs, "")))
1396:                 loc_cSQL = "SELECT TOP 1 Rclis FROM SigCdCli" + ;
1397:                            " WHERE Iclis = " + EscaparSQL(ALLTRIM(loc_oBO.this_cContaDs))
1398:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DcontaD")
1399:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_DcontaD") > 0
1400:                     loc_oCnt.txt_4c_DcontaD.Value = ALLTRIM(cursor_4c_DcontaD.Rclis)
1401:                 ENDIF
1402:                 IF USED("cursor_4c_DcontaD")
1403:                     USE IN cursor_4c_DcontaD
1404:                 ENDIF
1405:             ELSE
1406:                 loc_oCnt.txt_4c_DcontaD.Value = ""
1407:             ENDIF
1408: 
1409:             *-- Campos GruResp e Resps/Dresps (When=.F. no legado -> ReadOnly + Enabled=.F.)
1410:             IF USED("csTemporario")
1411:                 SELECT csTemporario
1412:                 IF PEMSTATUS(loc_oCnt, "txt_4c_GruResp", 5)
1413:                     loc_oCnt.txt_4c_GruResp.Value = ALLTRIM(NVL(csTemporario.GrupoDs, ""))
1414:                 ENDIF
1415:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Resps", 5)
1416:                     loc_oCnt.txt_4c_Resps.Value   = ALLTRIM(NVL(csTemporario.ContaDs, ""))

*-- Linhas 1427 a 1470:
1427:     *--------------------------------------------------------------------------
1428:     * CarregarGradeItens - Carrega cursor de itens e vincula ao grd_4c_Itens
1429:     *--------------------------------------------------------------------------
1430:     PROCEDURE CarregarGradeItens()
1431:         LOCAL loc_lResultado, loc_oGrid, loc_cSQL
1432:         loc_lResultado = .F.
1433:         TRY
1434:             *-- Acionar BO para construir xEestI
1435:             IF !THIS.this_oBusinessObject.MontarCursorItens(THIS.this_cEmpdopnums)
1436:                 loc_lResultado = .T.
1437:             ELSE
1438:                 *-- Criar cursor_4c_Itens com Saldo calculado a partir de xEestI
1439:                 IF USED("cursor_4c_Itens")
1440:                     USE IN cursor_4c_Itens
1441:                 ENDIF
1442:                 SELECT empdopnums, cpros, codcors, codtams, ;
1443:                        qtds, (qtds - qtbaixas) AS Saldos, qtbaixas, ;
1444:                        qtprods, qtbxprods, tpesos, descvals, DPros, OBS ;
1445:                     FROM xEestI ;
1446:                     INTO CURSOR cursor_4c_Itens READWRITE
1447: 
1448:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
1449:                 loc_oGrid.ColumnCount = 10
1450:                 loc_oGrid.RecordSource = "cursor_4c_Itens"
1451:                 loc_oGrid.ColumnCount  = 10
1452: 
1453:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Itens.cpros"
1454:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Itens.qtprods"
1455:                 loc_oGrid.Column3.ControlSource   = "cursor_4c_Itens.qtds"
1456:                 loc_oGrid.Column4.ControlSource   = "cursor_4c_Itens.Saldos"
1457:                 loc_oGrid.Column5.ControlSource   = "cursor_4c_Itens.qtbaixas"
1458:                 loc_oGrid.Column6.ControlSource   = "cursor_4c_Itens.qtbxprods"
1459:                 loc_oGrid.Column7.ControlSource   = "cursor_4c_Itens.codcors"
1460:                 loc_oGrid.Column8.ControlSource   = "cursor_4c_Itens.tpesos"
1461:                 loc_oGrid.Column9.ControlSource   = "cursor_4c_Itens.descvals"
1462:                 loc_oGrid.Column10.ControlSource  = "cursor_4c_Itens.codtams"
1463: 
1464:                 loc_oGrid.Column1.Header1.Caption  = "Produto"
1465:                 loc_oGrid.Column2.Header1.Caption  = "Produzido"
1466:                 loc_oGrid.Column3.Header1.Caption  = "Qtd."
1467:                 loc_oGrid.Column4.Header1.Caption  = "Saldo"
1468:                 loc_oGrid.Column5.Header1.Caption  = "Qtd.Baixa"
1469:                 loc_oGrid.Column6.Header1.Caption  = "Produzir"
1470:                 loc_oGrid.Column7.Header1.Caption  = ""

*-- Linhas 1491 a 2026:
1491:     *--------------------------------------------------------------------------
1492:     * GradeItensAfterRowColChange - Atualiza descricao/foto ao mudar linha do grid
1493:     *--------------------------------------------------------------------------
1494:     PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
1495:         LOCAL loc_lResultado, loc_cCpros, loc_oPg2
1496:         loc_lResultado = .F.
1497:         TRY
1498:             IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1499:                 loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1500:                 loc_cCpros = ALLTRIM(NVL(cursor_4c_Itens.cpros, ""))
1501: 
1502:                 loc_oPg2.txt_4c_Descr.Value   = ALLTRIM(NVL(cursor_4c_Itens.DPros, ""))
1503:                 loc_oPg2.txt_4c_ObsItem.Value = ALLTRIM(NVL(cursor_4c_Itens.OBS, ""))
1504: 
1505:                 THIS.CarregarImagemProduto(loc_cCpros)
1506:             ENDIF
1507:             loc_lResultado = .T.
1508:         CATCH TO loc_oErro
1509:             MsgErro(loc_oErro.Message, "Erro")
1510:         ENDTRY
1511:         RETURN loc_lResultado
1512:     ENDPROC
1513: 
1514:     *--------------------------------------------------------------------------
1515:     * CarregarImagemProduto - Busca FigJpgs de SigCdPro e exibe img_4c_FigJpg
1516:     *--------------------------------------------------------------------------
1517:     PROCEDURE CarregarImagemProduto(par_cCpros)
1518:         LOCAL loc_lResultado, loc_cSQL, loc_nRes, loc_cArqTemp, loc_oImg
1519:         loc_lResultado = .F.
1520:         TRY
1521:             loc_oImg = THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg
1522:             loc_oImg.Visible = .F.
1523:             loc_oImg.Picture = ""
1524: 
1525:             IF !EMPTY(ALLTRIM(par_cCpros)) AND gnConnHandle > 0
1526:                 loc_cSQL = "SELECT TOP 1 FigJpgs FROM SigCdPro" + ;
1527:                            " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros))
1528:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigJpg")
1529:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_FigJpg") > 0
1530:                     IF !ISNULL(cursor_4c_FigJpg.FigJpgs) AND ;
1531:                        LEN(cursor_4c_FigJpg.FigJpgs) > 0
1532:                         loc_cArqTemp = ADDBS(SYS(2023)) + "Temp3.jpg"
1533:                         STRTOFILE(cursor_4c_FigJpg.FigJpgs, loc_cArqTemp, 0)
1534:                         IF FILE(loc_cArqTemp)
1535:                             loc_oImg.Picture = loc_cArqTemp
1536:                             loc_oImg.Visible = .T.
1537:                         ENDIF
1538:                     ENDIF
1539:                 ENDIF
1540:                 IF USED("cursor_4c_FigJpg")
1541:                     USE IN cursor_4c_FigJpg
1542:                 ENDIF
1543:             ENDIF
1544:             loc_lResultado = .T.
1545:         CATCH TO loc_oErro
1546:             MsgErro(loc_oErro.Message, "Erro")
1547:         ENDTRY
1548:         RETURN loc_lResultado
1549:     ENDPROC
1550: 
1551:     *--------------------------------------------------------------------------
1552:     * AbrirLookupContaO - Lookup FormBuscaAuxiliar para conta de Origem
1553:     *--------------------------------------------------------------------------
1554:     PROCEDURE AbrirLookupContaO()
1555:         LOCAL loc_lResultado, loc_oLookup, loc_oCnt
1556:         loc_lResultado = .F.
1557:         TRY
1558:             loc_oCnt   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem
1559:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1560:                 "SigCdCli", "cursor_4c_BuscaContaO", "Iclis", ;
1561:                 ALLTRIM(loc_oCnt.txt_4c_ContaO.Value), ;
1562:                 "Conta de Origem")
1563:             loc_oLookup.mAddColuna("Iclis",  "", "Conta")
1564:             loc_oLookup.mAddColuna("Rclis",  "", "Nome")
1565:             loc_oLookup.Show()
1566:             IF loc_oLookup.this_lSelecionou
1567:                 loc_oCnt.txt_4c_ContaO.Value  = ALLTRIM(cursor_4c_BuscaContaO.Iclis)
1568:                 loc_oCnt.txt_4c_DcontaO.Value = ALLTRIM(cursor_4c_BuscaContaO.Rclis)
1569:                 THIS.this_oBusinessObject.this_cContaOs = ALLTRIM(cursor_4c_BuscaContaO.Iclis)
1570:             ENDIF
1571:             IF USED("cursor_4c_BuscaContaO")
1572:                 USE IN cursor_4c_BuscaContaO
1573:             ENDIF
1574:             loc_oLookup.Release()
1575:             loc_oLookup = .NULL.
1576:             loc_lResultado = .T.
1577:         CATCH TO loc_oErro
1578:             MsgErro(loc_oErro.Message, "Erro")
1579:         ENDTRY
1580:         RETURN loc_lResultado
1581:     ENDPROC
1582: 
1583:     *--------------------------------------------------------------------------
1584:     * AbrirLookupContaD - Lookup FormBuscaAuxiliar para conta de Destino
1585:     *--------------------------------------------------------------------------
1586:     PROCEDURE AbrirLookupContaD()
1587:         LOCAL loc_lResultado, loc_oLookup, loc_oCnt
1588:         loc_lResultado = .F.
1589:         TRY
1590:             loc_oCnt   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem
1591:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1592:                 "SigCdCli", "cursor_4c_BuscaContaD", "Iclis", ;
1593:                 ALLTRIM(loc_oCnt.txt_4c_ContaD.Value), ;
1594:                 "Conta de Destino")
1595:             loc_oLookup.mAddColuna("Iclis",  "", "Conta")
1596:             loc_oLookup.mAddColuna("Rclis",  "", "Nome")
1597:             loc_oLookup.Show()
1598:             IF loc_oLookup.this_lSelecionou
1599:                 loc_oCnt.txt_4c_ContaD.Value  = ALLTRIM(cursor_4c_BuscaContaD.Iclis)
1600:                 loc_oCnt.txt_4c_DcontaD.Value = ALLTRIM(cursor_4c_BuscaContaD.Rclis)
1601:                 THIS.this_oBusinessObject.this_cContaDs = ALLTRIM(cursor_4c_BuscaContaD.Iclis)
1602:             ENDIF
1603:             IF USED("cursor_4c_BuscaContaD")
1604:                 USE IN cursor_4c_BuscaContaD
1605:             ENDIF
1606:             loc_oLookup.Release()
1607:             loc_oLookup = .NULL.
1608:             loc_lResultado = .T.
1609:         CATCH TO loc_oErro
1610:             MsgErro(loc_oErro.Message, "Erro")
1611:         ENDTRY
1612:         RETURN loc_lResultado
1613:     ENDPROC
1614: 
1615:     *--------------------------------------------------------------------------
1616:     * ContaOKeyPress - Abre lookup de Origem com Enter (keycode 28 = F4)
1617:     *--------------------------------------------------------------------------
1618:     PROCEDURE ContaOKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1619:         IF par_nKeyCode = 28 OR par_nKeyCode = 9 OR par_nKeyCode = 13 OR ;
1620:            par_nKeyCode = 115
1621:             IF par_nKeyCode = 28 OR par_nKeyCode = 115
1622:                 THIS.AbrirLookupContaO()
1623:             ENDIF
1624:         ENDIF
1625:     ENDPROC
1626: 
1627:     *--------------------------------------------------------------------------
1628:     * ContaODblClick - Abre lookup de Origem ao dar duplo clique
1629:     *--------------------------------------------------------------------------
1630:     PROCEDURE ContaODblClick()
1631:         THIS.AbrirLookupContaO()
1632:     ENDPROC
1633: 
1634:     *--------------------------------------------------------------------------
1635:     * ContaDKeyPress - Abre lookup de Destino com F4 (keycode 115)
1636:     *--------------------------------------------------------------------------
1637:     PROCEDURE ContaDKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1638:         IF par_nKeyCode = 28 OR par_nKeyCode = 9 OR par_nKeyCode = 13 OR ;
1639:            par_nKeyCode = 115
1640:             IF par_nKeyCode = 28 OR par_nKeyCode = 115
1641:                 THIS.AbrirLookupContaD()
1642:             ENDIF
1643:         ENDIF
1644:     ENDPROC
1645: 
1646:     *--------------------------------------------------------------------------
1647:     * ContaDDblClick - Abre lookup de Destino ao dar duplo clique
1648:     *--------------------------------------------------------------------------
1649:     PROCEDURE ContaDDblClick()
1650:         THIS.AbrirLookupContaD()
1651:     ENDPROC
1652: 
1653:     *--------------------------------------------------------------------------
1654:     * DcontaDLostFocus - Move foco para botao Confirmar
1655:     *--------------------------------------------------------------------------
1656:     PROCEDURE DcontaDLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1657:         LOCAL loc_oErro
1658:         TRY
1659:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
1660:         CATCH TO loc_oErro
1661:             MsgErro(loc_oErro.Message, "Erro")
1662:         ENDTRY
1663:     ENDPROC
1664: 
1665:     *--------------------------------------------------------------------------
1666:     * DrespsDLostFocus - Move foco para botao Confirmar
1667:     *--------------------------------------------------------------------------
1668:     PROCEDURE DrespsDLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1669:         LOCAL loc_oErro
1670:         TRY
1671:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
1672:         CATCH TO loc_oErro
1673:             MsgErro(loc_oErro.Message, "Erro")
1674:         ENDTRY
1675:     ENDPROC
1676: 
1677:     *--------------------------------------------------------------------------
1678:     * BtnCadastrosClick - Abre formulario de cadastro de contas (SIGCDCTA)
1679:     *--------------------------------------------------------------------------
1680:     PROCEDURE BtnCadastrosClick()
1681:         LOCAL loc_oErro, loc_cContaD
1682:         TRY
1683:             loc_cContaD = ""
1684:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem, "txt_4c_ContaD", 5)
1685:                 loc_cContaD = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_ContaD.Value)
1686:             ENDIF
1687:             DO FORM SIGCDCTA WITH 0, "SIGCDCTA", loc_cContaD, .T., "", "", .T.
1688:         CATCH TO loc_oErro
1689:             MsgErro(loc_oErro.Message, "Erro")
1690:         ENDTRY
1691:     ENDPROC
1692: 
1693:     *--------------------------------------------------------------------------
1694:     * Destroy - Limpa recursos ao fechar o formulario
1695:     *--------------------------------------------------------------------------
1696:     PROCEDURE Destroy()
1697:         LOCAL loc_oErro
1698:         TRY
1699:             IF USED("cursor_4c_Itens")
1700:                 USE IN cursor_4c_Itens
1701:             ENDIF
1702:             IF USED("cursor_4c_Operacao")
1703:                 USE IN cursor_4c_Operacao
1704:             ENDIF
1705:             IF USED("xEestI")
1706:                 USE IN xEestI
1707:             ENDIF
1708:             IF USED("crSigMvItn")
1709:                 USE IN crSigMvItn
1710:             ENDIF
1711:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1712:                 THIS.this_oBusinessObject = .NULL.
1713:             ENDIF
1714:             THIS.this_oParentForm = .NULL.
1715:         CATCH TO loc_oErro
1716:             MsgErro(loc_oErro.Message, "Erro")
1717:         ENDTRY
1718:         DODEFAULT()
1719:     ENDPROC
1720: 
1721:     *--------------------------------------------------------------------------
1722:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1723:     *--------------------------------------------------------------------------
1724:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1725:         LOCAL loc_nI, loc_oObjeto, loc_nP
1726:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1727:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1728:             IF VARTYPE(loc_oObjeto) = "O"
1729:                 *-- CNT_4C_CABECALHO deve permanecer com Visible original (nao forcar .T.)
1730:                 *-- Recursar filhos antes do LOOP para que sub-controles sejam visiveis
1731:                 IF PEMSTATUS(loc_oObjeto, "Name", 5) AND ;
1732:                    INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
1733:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1734:                         THIS.TornarControlesVisiveis(loc_oObjeto)
1735:                     ENDIF
1736:                     LOOP
1737:                 ENDIF
1738:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1739:                     loc_oObjeto.Visible = .T.
1740:                 ENDIF
1741:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1742:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1743:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1744:                     ENDFOR
1745:                 ENDIF
1746:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1747:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1748:                 ENDIF
1749:             ENDIF
1750:         ENDFOR
1751:     ENDPROC
1752: 
1753:     *--------------------------------------------------------------------------
1754:     * FormatarGridLista - Formata visual do grid da lista
1755:     *--------------------------------------------------------------------------
1756:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1757:         WITH par_oGrid
1758:             .FontName = "Tahoma"
1759:             .FontSize = 8
1760:         ENDWITH
1761:     ENDPROC
1762: 
1763:     *--------------------------------------------------------------------------
1764:     * BtnConfirmarClick - Volta para Page1 (OK no detalhe)
1765:     *--------------------------------------------------------------------------
1766:     PROCEDURE BtnConfirmarClick()
1767:         LOCAL loc_oErro
1768:         TRY
1769:             THIS.pgf_4c_Paginas.Page1.Enabled = .T.
1770:             THIS.this_cPcEscolha = ""
1771:             THIS.AlternarPagina(1)
1772:         CATCH TO loc_oErro
1773:             MsgErro(loc_oErro.Message, "Erro")
1774:         ENDTRY
1775:     ENDPROC
1776: 
1777:     *--------------------------------------------------------------------------
1778:     * BtnCancelarClick - Cancela visualizacao e volta para Page1
1779:     *--------------------------------------------------------------------------
1780:     PROCEDURE BtnCancelarClick()
1781:         LOCAL loc_oErro
1782:         TRY
1783:             THIS.pgf_4c_Paginas.Page1.Enabled = .T.
1784:             THIS.this_lPlCancelar = .T.
1785:             THIS.this_cPcEscolha  = ""
1786:             THIS.AlternarPagina(1)
1787:         CATCH TO loc_oErro
1788:             MsgErro(loc_oErro.Message, "Erro")
1789:         ENDTRY
1790:     ENDPROC
1791: 
1792:     *--------------------------------------------------------------------------
1793:     * BtnEntregaClick - Abre form SigOpEnt para agendamento de entrega
1794:     *--------------------------------------------------------------------------
1795:     PROCEDURE BtnEntregaClick()
1796:         LOCAL loc_lResultado, loc_dData, loc_dEst, loc_oErro
1797:         loc_lResultado = .F.
1798:         TRY
1799:             IF !USED("csTemporario") OR EOF("csTemporario")
1800:                 MsgAviso("Nenhum pedido selecionado!", "")
1801:             ELSE
1802:                 SELECT csTemporario
1803:                 loc_dData = IIF(EMPTY(csTemporario.PrazoEnts), DATE(), csTemporario.PrazoEnts)
1804:                 loc_dEst  = IIF(EMPTY(csTemporario.Datas), DATE(), csTemporario.Datas)
1805:                 DO FORM SigOpEnt WITH csTemporario.Emps, csTemporario.Dopes, ;
1806:                     csTemporario.Numes, loc_dData, THIS, 0, loc_dEst, .T., 0
1807:                 loc_lResultado = .T.
1808:             ENDIF
1809:         CATCH TO loc_oErro
1810:             MsgErro(loc_oErro.Message, "Erro")
1811:         ENDTRY
1812:         RETURN loc_lResultado
1813:     ENDPROC
1814: 
1815:     *--------------------------------------------------------------------------
1816:     * BtnSubNiveisClick - Abre form SigMvSbn para sub-niveis do pedido
1817:     *--------------------------------------------------------------------------
1818:     PROCEDURE BtnSubNiveisClick()
1819:         LOCAL loc_oErro
1820:         TRY
1821:             IF !USED("csTemporario") OR EOF("csTemporario")
1822:                 MsgAviso("Nenhum pedido selecionado!", "")
1823:             ELSE
1824:                 SELECT csTemporario
1825:                 DO FORM SigMvSbn WITH THIS, csTemporario.Emps, csTemporario.Dopes, ;
1826:                     csTemporario.Numes, "csTemporario"
1827:             ENDIF
1828:         CATCH TO loc_oErro
1829:             MsgErro(loc_oErro.Message, "Erro")
1830:         ENDTRY
1831:     ENDPROC
1832: 
1833:     *--------------------------------------------------------------------------
1834:     * CarregarGradeOperacao - Carrega grade de tipos de operacao (SigCdOpe)
1835:     *--------------------------------------------------------------------------
1836:     PROTECTED PROCEDURE CarregarGradeOperacao()
1837:         LOCAL loc_lResultado, loc_oGrid, loc_cSQL, loc_nResult
1838:         loc_lResultado = .F.
1839:         TRY
1840:             IF gnConnHandle <= 0
1841:                 loc_lResultado = .T.
1842:             ELSE
1843:                 loc_oGrid   = THIS.pgf_4c_Paginas.Page2.grd_4c_Operacao
1844:                 loc_cSQL    = "SELECT Dopes FROM SigCdOpe"
1845:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacaoTemp")
1846:                 IF loc_nResult > 0
1847:                     IF USED("cursor_4c_Operacao")
1848:                         SELECT cursor_4c_Operacao
1849:                         ZAP
1850:                         APPEND FROM DBF("cursor_4c_OperacaoTemp")
1851:                     ELSE
1852:                         SELECT Dopes FROM cursor_4c_OperacaoTemp ;
1853:                             INTO CURSOR cursor_4c_Operacao READWRITE
1854:                     ENDIF
1855:                     IF USED("cursor_4c_OperacaoTemp")
1856:                         USE IN cursor_4c_OperacaoTemp
1857:                     ENDIF
1858:                     loc_oGrid.ColumnCount = 1
1859:                     loc_oGrid.RecordSource = "cursor_4c_Operacao"
1860:                     loc_oGrid.ColumnCount  = 1
1861:                     loc_oGrid.Column1.ControlSource   = "cursor_4c_Operacao.Dopes"
1862:                     loc_oGrid.Column1.Width           = 110
1863:                     loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1864:                     loc_oGrid.Refresh()
1865:                 ENDIF
1866:                 loc_lResultado = .T.
1867:             ENDIF
1868:         CATCH TO loc_oErro
1869:             MsgErro(loc_oErro.Message, "Erro")
1870:         ENDTRY
1871:         RETURN loc_lResultado
1872:     ENDPROC
1873: 
1874: 
1875:     *--------------------------------------------------------------------------
1876:     * BtnIncluirClick - Nao disponivel neste form operacional
1877:     * Legado: Inserir.Enabled=.F. + Visible=.F. (form e somente consulta)
1878:     *--------------------------------------------------------------------------
1879:     PROCEDURE BtnIncluirClick()
1880:         THIS.AlternarPagina(1)
1881:     ENDPROC
1882: 
1883:     *--------------------------------------------------------------------------
1884:     * BtnAlterarClick - Nao disponivel neste form operacional
1885:     * Legado: Alterar.Enabled=.F. + Visible=.F. (form e somente consulta)
1886:     *--------------------------------------------------------------------------
1887:     PROCEDURE BtnAlterarClick()
1888:         THIS.AlternarPagina(1)
1889:     ENDPROC
1890: 
1891:     *--------------------------------------------------------------------------
1892:     * BtnVisualizarClick - Navega para Page2 com dados do pedido selecionado
1893:     * Equivalente ao BtnConsultarClick (mesmo comportamento)
1894:     *--------------------------------------------------------------------------
1895:     PROCEDURE BtnVisualizarClick()
1896:         THIS.BtnConsultarClick()
1897:     ENDPROC
1898: 
1899:     *--------------------------------------------------------------------------
1900:     * BtnExcluirClick - Nao disponivel neste form operacional
1901:     * Legado: Excluir.Enabled=.F. + Visible=.F. (form e somente consulta)
1902:     *--------------------------------------------------------------------------
1903:     PROCEDURE BtnExcluirClick()
1904:         THIS.AlternarPagina(1)
1905:     ENDPROC
1906: 
1907:     *--------------------------------------------------------------------------
1908:     * BtnBuscarClick - Procurar oculto no legado; recarrega lista
1909:     *--------------------------------------------------------------------------
1910:     PROCEDURE BtnBuscarClick()
1911:         THIS.CarregarLista()
1912:     ENDPROC
1913: 
1914:     *--------------------------------------------------------------------------
1915:     * BtnSalvarClick - Equivalente ao BtnConfirmarClick neste form operacional
1916:     *--------------------------------------------------------------------------
1917:     PROCEDURE BtnSalvarClick()
1918:         THIS.BtnConfirmarClick()
1919:     ENDPROC
1920: 
1921:     *--------------------------------------------------------------------------
1922:     * FormParaBO - Form e somente leitura; BO ja foi carregado do csTemporario
1923:     *--------------------------------------------------------------------------
1924:     PROTECTED PROCEDURE FormParaBO()
1925:         RETURN .T.
1926:     ENDPROC
1927: 
1928:     *--------------------------------------------------------------------------
1929:     * BOParaForm - Carrega propriedades do BO para os campos da Page2
1930:     *--------------------------------------------------------------------------
1931:     PROTECTED PROCEDURE BOParaForm()
1932:         LOCAL loc_lResultado
1933:         loc_lResultado = .F.
1934:         TRY
1935:             loc_lResultado = THIS.CarregarCamposOrigem()
1936:         CATCH TO loc_oErro
1937:             MsgErro(loc_oErro.Message, "Erro")
1938:         ENDTRY
1939:         RETURN loc_lResultado
1940:     ENDPROC
1941: 
1942:     *--------------------------------------------------------------------------
1943:     * HabilitarCampos - Form operacional de consulta; campos sao todos ReadOnly
1944:     *--------------------------------------------------------------------------
1945:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1946:         LOCAL loc_lResultado, loc_oPg2, loc_oCnt
1947:         loc_lResultado = .F.
1948:         TRY
1949:             IF PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
1950:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1951:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Nota", 5)
1952:                     loc_oPg2.txt_4c_Nota.ReadOnly = .T.
1953:                 ENDIF
1954:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
1955:                     loc_oCnt = loc_oPg2.cnt_4c_Origem
1956:                     IF PEMSTATUS(loc_oCnt, "txt_4c_ContaO", 5)
1957:                         loc_oCnt.txt_4c_ContaO.ReadOnly = .T.
1958:                     ENDIF
1959:                     IF PEMSTATUS(loc_oCnt, "txt_4c_ContaD", 5)
1960:                         loc_oCnt.txt_4c_ContaD.ReadOnly = .T.
1961:                     ENDIF
1962:                 ENDIF
1963:             ENDIF
1964:             loc_lResultado = .T.
1965:         CATCH TO loc_oErro
1966:             MsgErro(loc_oErro.Message, "Erro")
1967:         ENDTRY
1968:         RETURN loc_lResultado
1969:     ENDPROC
1970: 
1971:     *--------------------------------------------------------------------------
1972:     * LimparCampos - Limpa todos os campos de exibicao da Page2
1973:     *--------------------------------------------------------------------------
1974:     PROTECTED PROCEDURE LimparCampos()
1975:         LOCAL loc_lResultado, loc_oPg2, loc_oCnt
1976:         loc_lResultado = .F.
1977:         TRY
1978:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1979:             loc_oPg2.txt_4c_Codigo.Value  = ""
1980:             loc_oPg2.txt_4c_Data.Value    = {}
1981:             loc_oPg2.txt_4c_PrvEnts.Value = {}
1982:             loc_oPg2.txt_4c_Nota.Value    = ""
1983:             loc_oPg2.txt_4c_Nop.Value     = ""
1984:             loc_oPg2.txt_4c_Tabd.Value    = ""
1985:             loc_oPg2.txt_4c_PStatus.Value = ""
1986:             loc_oPg2.txt_4c_Descr.Value   = ""
1987:             loc_oPg2.txt_4c_ObsItem.Value = ""
1988: 
1989:             loc_oCnt = loc_oPg2.cnt_4c_Origem
1990:             loc_oCnt.txt_4c_GrupoO.Value  = ""
1991:             loc_oCnt.txt_4c_ContaO.Value  = ""
1992:             loc_oCnt.txt_4c_DcontaO.Value = ""
1993:             loc_oCnt.txt_4c_GrupoD.Value  = ""
1994:             loc_oCnt.txt_4c_ContaD.Value  = ""
1995:             loc_oCnt.txt_4c_DcontaD.Value = ""
1996:             loc_oCnt.txt_4c_GruResp.Value = ""
1997:             loc_oCnt.txt_4c_Resps.Value   = ""
1998:             loc_oCnt.txt_4c_Dresps.Value  = ""
1999: 
2000:             loc_oPg2.cnt_4c_ObsItem.txt_4c_ObsMemo.Value = ""
2001: 
2002:             loc_oPg2.img_4c_FigJpg.Visible = .F.
2003:             loc_oPg2.img_4c_FigJpg.Picture = ""
2004: 
2005:             loc_lResultado = .T.
2006:         CATCH TO loc_oErro
2007:             MsgErro(loc_oErro.Message, "Erro")
2008:         ENDTRY
2009:         RETURN loc_lResultado
2010:     ENDPROC
2011: 
2012:     *--------------------------------------------------------------------------
2013:     * AjustarBotoesPorModo - Modo fixo: apenas Consultar disponivel
2014:     *--------------------------------------------------------------------------
2015:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2016:         LOCAL loc_oErro
2017:         TRY
2018:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Consultar", 5)
2019:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Consultar.Enabled = .T.
2020:             ENDIF
2021:         CATCH TO loc_oErro
2022:             MsgErro(loc_oErro.Message, "Erro")
2023:         ENDTRY
2024:     ENDPROC
2025: 
2026: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpres2BO.prg):
*==============================================================================
* sigpres2BO.prg - Business Object para Pedido de Estoque (SIGPRES2)
* Herda de: BusinessBase
* Tabela principal: SigMvPec (PK: cidchaves, chave negocio: empdopnums)
* Itens: SigMvItn (join SigMvIts para cor/tamanho)
*==============================================================================
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE

DEFINE CLASS sigpres2BO AS BusinessBase

    *-- Identificacao da tabela principal
    this_cTabela      = "SigMvPec"
    this_cCampoChave  = "cidchaves"

    *-- Chave de negocio composta (emps+dopes+numes)
    this_cEmpdopnums  = ""

    *-- Campos de SigMvPec (schema exato)
    this_cEmps        = ""
    this_cDopes       = ""
    this_nNumes       = 0
    this_nCodigos     = 0
    this_dDatatrans   = {}
    this_nNtrans      = 0
    this_cLocals      = ""
    this_nValobxs     = 0
    this_cCidchaves   = ""
    this_cEmpsubs     = ""
    this_dDatas       = {}
    this_lChksubn     = .F.
    this_dDtagends    = {}
    this_lChkpagos    = .F.
    this_nNparcs      = 0
    this_nValps       = 0
    this_nValvars     = 0
    this_dVencps      = {}
    this_cPStatus     = ""

    *-- Campos adicionais do csTemporario (origem/destino contabil)
    this_cGrupoOs     = ""
    this_cContaOs     = ""
    this_cGrupoDs     = ""
    this_cContaDs     = ""
    this_cEmpds       = ""
    this_cUsuars      = ""
    this_nNops        = 0
    this_cVends       = ""
    this_cGrvends     = ""
    this_cTabds       = ""
    this_cObses       = ""
    this_dPrazoents   = {}
    this_cMascnum     = ""
    this_cNotas       = ""
    this_lChkBxParcs  = .F.

    *-- Descricoes (preenchidas por lookup em tempo de execucao)
    this_cDconta      = ""
    this_cDcontad     = ""
    this_cDresps      = ""

    *-- Referencia ao form pai (para navegacao/callbacks)
    this_oParentForm  = .NULL.

    *--------------------------------------------------------------------------
    * Init - Configura tabela principal e chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvPec"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps        = TratarNulo(emps,       "C")
                THIS.this_cDopes       = TratarNulo(dopes,      "C")
                THIS.this_nNumes       = TratarNulo(numes,      "N")
                THIS.this_nCodigos     = TratarNulo(codigos,    "N")
                THIS.this_dDatatrans   = TratarNulo(datatrans,  "D")
                THIS.this_nNtrans      = TratarNulo(ntrans,     "N")
                THIS.this_cLocals      = TratarNulo(locals,     "C")
                THIS.this_nValobxs     = TratarNulo(valobxs,    "N")
                THIS.this_cCidchaves   = TratarNulo(cidchaves,  "C")
                THIS.this_cEmpdopnums  = TratarNulo(empdopnums, "C")
                THIS.this_cEmpsubs     = TratarNulo(empsubns,   "C")
                THIS.this_dDatas       = TratarNulo(datas,      "D")
                THIS.this_lChksubn     = ConverterParaLogico(chksubn)
                THIS.this_dDtagends    = TratarNulo(dtagends,   "D")
                THIS.this_lChkpagos    = ConverterParaLogico(chkpagos)
                THIS.this_nNparcs      = TratarNulo(nparcs,     "N")
                THIS.this_nValps       = TratarNulo(valps,      "N")
                THIS.this_nValvars     = TratarNulo(valvars,    "N")
                THIS.this_dVencps      = TratarNulo(vencps,     "D")
                THIS.this_cPStatus     = TratarNulo(pstatus,    "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursorTemporario - Carrega campos do csTemporario (form)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursorTemporario(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps        = TratarNulo(emps,       "C")
                THIS.this_cEmpds       = TratarNulo(empds,      "C")
                THIS.this_cDopes       = TratarNulo(dopes,      "C")
                THIS.this_nNumes       = TratarNulo(numes,      "N")
                THIS.this_dDatas       = TratarNulo(datas,      "D")
                THIS.this_cGrupoOs     = TratarNulo(grupoos,    "C")
                THIS.this_cContaOs     = TratarNulo(contaos,    "C")
                THIS.this_cGrupoDs     = TratarNulo(grupods,    "C")
                THIS.this_cContaDs     = TratarNulo(contads,    "C")
                THIS.this_nNops        = TratarNulo(nops,       "N")
                THIS.this_cUsuars      = TratarNulo(usuars,     "C")
                THIS.this_cPStatus     = TratarNulo(pstatus,    "C")
                THIS.this_cVends       = TratarNulo(vends,      "C")
                THIS.this_cGrvends     = TratarNulo(grvends,    "C")
                THIS.this_cTabds       = TratarNulo(tabds,      "C")
                THIS.this_cObses       = TratarNulo(obses,      "C")
                THIS.this_dPrazoents   = TratarNulo(prazoents,  "D")
                THIS.this_cMascnum     = TratarNulo(mascnum,    "C")
                THIS.this_cNotas       = TratarNulo(notas,      "C")
                THIS.this_lChksubn     = ConverterParaLogico(chksubn)
                THIS.this_lChkBxParcs  = ConverterParaLogico(chkbxparcs)
                THIS.this_cEmpdopnums  = ALLTRIM(THIS.this_cEmps) + ;
                                         ALLTRIM(THIS.this_cDopes) + ;
                                         STR(THIS.this_nNumes, 6)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro do SigMvPec pela chave de negocio
    * par_cEmpdopnums: emps+dopes+numes(6) concatenados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cEmpdopnums)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigMvPec WHERE empdopnums = " + ;
                       EscaparSQL(ALLTRIM(par_cEmpdopnums))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SigMvPec conforme filtro
    * par_cFiltro: clausula WHERE adicional (sem o WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere
        loc_lResultado = .F.
        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = "SELECT emps, dopes, numes, datas, pstatus, cidchaves," + ;
                       " empdopnums, valobxs, nparcs, valps, valvars, vencps" + ;
                       " FROM SigMvPec" + loc_cWhere + ;
                       " ORDER BY empdopnums"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarItens - Carrega cursor xEestI com itens do pedido
    * par_cEmpdopnums: chave composta do pedido
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItens(par_cEmpdopnums)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT ISNULL(b.codtams,'') AS codtams," + ;
                       " ISNULL(b.codcors,'') AS codcors, b.qtds AS QtdsS, a.*" + ;
                       " FROM SigMvItn a" + ;
                       " LEFT JOIN SigMvIts b ON a.empdopnums = b.empdopnums" + ;
                       " AND a.cpros = b.cpros AND a.citens = b.citens" + ;
                       " WHERE a.empdopnums = " + EscaparSQL(ALLTRIM(par_cEmpdopnums))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvItn") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCursorItens - Agrega itens por cpros+codcors+codtams para o grid
    * Precisa que crSigMvItn ja esteja carregado (via BuscarItens)
    *--------------------------------------------------------------------------
    PROCEDURE MontarCursorItens(par_cEmpdopnums)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF !USED("crSigMvItn")
                IF !THIS.BuscarItens(par_cEmpdopnums)
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            loc_cSQL = "SELECT empdopnums, cpros, codcors, codtams," + ;
                       " SUM(qtds) AS qtds, SUM(qtdss) AS qtdss," + ;
                       " MAX(qtbaixas) AS qtbaixas, MAX(qtprods) AS qtprods," + ;
                       " MAX(qtbxprods) AS qtbxprods, 0 AS citens," + ;
                       " SUM(tpesos) AS tpesos, SUM(descvals) AS descvals" + ;
                       " FROM crSigMvItn" + ;
                       " GROUP BY empdopnums, cpros, codcors, codtams"
            SELECT &loc_cSQL INTO CURSOR crSigMvItn READWRITE

            IF !USED("xEestI")
                CREATE CURSOR xEestI (empdopnums C(29), cpros C(14), codcors C(4), ;
                    codtams C(4), qtds N(11,3), qtdss N(11,3), qtbaixas N(11,3), ;
                    qtprods N(11,3), qtbxprods N(11,3), citens N(4,0), ;
                    tpesos N(11,2), descvals N(11,2), DPros C(50), OBS M)
            ELSE
                ZAP IN xEestI
            ENDIF

            SELECT crSigMvItn
            INDEX ON EmpDopNums TAG EmpDopNums

            LOCAL loc_nI, loc_nQtds, loc_nQtdss
            FOR loc_nI = 1 TO RECCOUNT("crSigMvItn")
                GO loc_nI IN crSigMvItn
                SELECT crSigMvItn
                SCATTER MEMVAR MEMO

                IF !EMPTY(ALLTRIM(m.codtams)) OR !EMPTY(ALLTRIM(m.codcors))
                    m.qtds = m.qtdss
                ENDIF

                LOCAL loc_cSQLPro
                loc_cSQLPro = "SELECT cpros, DPros, PesoMs FROM SigCdPro" + ;
                              " WHERE cpros = " + EscaparSQL(ALLTRIM(m.cpros))
                IF SQLEXEC(gnConnHandle, loc_cSQLPro, "crSigCdPro") > 0 AND ;
                   RECCOUNT("crSigCdPro") > 0
                    m.tpesos   = crSigCdPro.PesoMs * m.qtds
                    m.descvals = (m.qtbaixas / IIF(m.qtds <> 0, m.qtds, 1)) * 100
                    m.DPros    = ALLTRIM(crSigCdPro.DPros)
                    IF USED("crSigCdPro")
                        USE IN crSigCdPro
                    ENDIF
                ENDIF

                INSERT INTO xEestI FROM MEMVAR
            ENDFOR

            *-- Linha de TOTAL
            LOCAL loc_nTqtd, loc_nTqtdb, loc_nTpeso, loc_nTQtPrd, loc_nTQtBxprd
            SELECT xEestI
            SUM qtds, qtbaixas, tpesos, qtprods, qtbxprods ;
                TO loc_nTqtd, loc_nTqtdb, loc_nTpeso, loc_nTQtPrd, loc_nTQtBxprd
            APPEND BLANK IN xEestI
            SELECT xEestI
            REPLACE cpros    WITH "TOTAL ->", ;
                    qtds     WITH loc_nTqtd, ;
                    qtbaixas WITH loc_nTqtdb, ;
                    tpesos   WITH loc_nTpeso, ;
                    qtprods  WITH loc_nTQtPrd, ;
                    qtbxprods WITH loc_nTQtBxprd, ;
                    descvals WITH ((loc_nTqtdb / IIF(loc_nTqtd <> 0, loc_nTqtd, 1)) * 100)
            GO TOP IN xEestI

            *-- Index para busca por produto+tamanho
            SELECT xEestI
            INDEX ON ALLTRIM(cpros) + ALLTRIM(codtams) TAG Tamanho

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMascaraNumeracao - Busca MascNums de SigCdPam para o tipo de OP
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMascaraNumeracao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 MascNums FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPam") > 0 AND ;
               RECCOUNT("crSigCdPam") > 0
                SELECT crSigCdPam
                THIS.this_cMascnum = ALLTRIM(crSigCdPam.MascNums)
                loc_lResultado = .T.
                IF USED("crSigCdPam")
                    USE IN crSigCdPam
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTipoOperacao - Busca dados de SigCdOpe para o tipo op
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTipoOperacao(par_cDopes)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigCdOpe WHERE Dopes = " + ;
                       EscaparSQL(ALLTRIM(par_cDopes))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpe") > 0 AND ;
               RECCOUNT("crSigCdOpe") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarSubDadosOperacao - Busca SigOpCdc para tipo de operacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarSubDadosOperacao(par_cDopes)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigOpCdc WHERE Dopes = " + ;
                       EscaparSQL(ALLTRIM(par_cDopes))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigOpCdc") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescricaoCliente - Busca Rclis de SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescricaoCliente(par_cConta)
        LOCAL loc_lResultado, loc_cSQL, loc_cDescricao
        loc_lResultado = .F.
        loc_cDescricao = ""
        TRY
            IF !EMPTY(ALLTRIM(par_cConta))
                loc_cSQL = "SELECT TOP 1 Rclis FROM SigCdCli" + ;
                           " WHERE Iclis = " + EscaparSQL(ALLTRIM(par_cConta))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCli") > 0 AND ;
                   RECCOUNT("crSigCdCli") > 0
                    loc_cDescricao = ALLTRIM(crSigCdCli.Rclis)
                    loc_lResultado = .T.
                ENDIF
                IF USED("crSigCdCli")
                    USE IN crSigCdCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.this_cDconta = loc_cDescricao
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAlteracoes - Persiste alteracoes do csTemporario de volta ao SigMvPec
    * Atualiza apenas os campos editaveis pelo usuario neste form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarAtualizacao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE SigMvPec SET" + ;
                       " grupoos = " + EscaparSQL(THIS.this_cGrupoOs) + "," + ;
                       " contaos = " + EscaparSQL(THIS.this_cContaOs) + "," + ;
                       " grupods = " + EscaparSQL(THIS.this_cGrupoDs) + "," + ;
                       " contads = " + EscaparSQL(THIS.this_cContaDs) + "," + ;
                       " datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " tabds   = " + EscaparSQL(THIS.this_cTabds) + "," + ;
                       " notas   = " + EscaparSQL(THIS.this_cNotas) + "," + ;
                       " vends   = " + EscaparSQL(THIS.this_cVends) + "," + ;
                       " grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;
                       " prazoents = " + FormatarDataSQL(THIS.this_dPrazoents) + ;
                       " WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpdopnums)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar pedido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui pedido do SigMvPec (e itens relacionados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigMvItn WHERE empdopnums = " + ;
                       EscaparSQL(THIS.this_cEmpdopnums)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigMvIts WHERE empdopnums = " + ;
                       EscaparSQL(THIS.this_cEmpdopnums)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigMvPec WHERE empdopnums = " + ;
                       EscaparSQL(THIS.this_cEmpdopnums)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir pedido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigMvPec com todos os campos obrigatorios
    * cidchaves gerado como emps(3)+dopes(10)+numes(6)+segundos(1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_cCidchaves, loc_cEmpdopnums
        loc_lResultado = .F.
        TRY
            *-- Gerar cidchaves (char 20): emps 3 + dopes 10 + numes 6 + tick 1
            loc_cEmpdopnums = LEFT(ALLTRIM(THIS.this_cEmps) + SPACE(3), 3) + ;
                              LEFT(ALLTRIM(THIS.this_cDopes) + SPACE(20), 20) + ;
                              RIGHT("      " + ALLTRIM(STR(THIS.this_nNumes, 6)), 6)
            loc_cCidchaves  = LEFT(loc_cEmpdopnums, 19) + ;
                              RIGHT(ALLTRIM(STR(INT(SECONDS()), 1)), 1)

            THIS.this_cCidchaves  = LEFT(loc_cCidchaves, 20)
            THIS.this_cEmpdopnums = LEFT(loc_cEmpdopnums, 29)

            loc_cSQL = "INSERT INTO SigMvPec" + ;
                       " (emps, dopes, numes, codigos, datatrans, ntrans," + ;
                       "  locals, valobxs, cidchaves, empdopnums, empsubns," + ;
                       "  datas, chksubn, dtagends, chkpagos, nparcs," + ;
                       "  valps, valvars, vencps, pstatus)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmps), 3)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                       FormatarDataSQL(THIS.this_dDatatrans) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cLocals), 10)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValobxs) + "," + ;
                       EscaparSQL(THIS.this_cCidchaves) + "," + ;
                       EscaparSQL(THIS.this_cEmpdopnums) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpsubs), 3)) + "," + ;
                       FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       IIF(THIS.this_lChksubn, "1", "0") + "," + ;
                       FormatarDataSQL(THIS.this_dDtagends) + "," + ;
                       IIF(THIS.this_lChkpagos, "1", "0") + "," + ;
                       FormatarNumeroSQL(THIS.this_nNparcs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValvars) + "," + ;
                       FormatarDataSQL(THIS.this_dVencps) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cPStatus), 1)) + ;
                       ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir pedido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

