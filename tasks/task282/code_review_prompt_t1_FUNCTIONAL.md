# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Operacao' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_OperacaoTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2003 linhas total):

*-- Linhas 4 a 164:
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
88:             THIS.pgf_4c_Paginas.Visible = .T.
89:             THIS.pgf_4c_Paginas.ActivePage = 1
90:             THIS.this_cModoAtual = "LISTA"
91: 
92:             loc_lResultado = .T.
93:         CATCH TO loc_oErro
94:             MsgErro(loc_oErro.Message, "Erro")
95:         ENDTRY
96:         RETURN loc_lResultado
97:     ENDPROC
98: 
99:     *--------------------------------------------------------------------------
100:     * ConfigurarPageFrame - PageFrame com 2 paginas (Top=-29, Tabs=.F.)
101:     *--------------------------------------------------------------------------
102:     PROTECTED PROCEDURE ConfigurarPageFrame()
103:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
104:         WITH THIS.pgf_4c_Paginas
105:             .PageCount = 2
106:             .Top       = -29
107:             .Left      = 0
108:             .Width     = THIS.Width
109:             .Height    = THIS.Height + 29
110:             .Tabs      = .F.
111:             .Page1.Caption   = "Lista"
112:             .Page2.Caption   = "Dados"
113:             .Page1.BackColor = RGB(255, 255, 255)
114:             .Page2.BackColor = RGB(255, 255, 255)
115:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
116:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
117:             .Visible = .T.
118:         ENDWITH
119:     ENDPROC
120: 
121:     *--------------------------------------------------------------------------
122:     * ConfigurarPaginaLista - Page1: cabecalho + grade (csTemporario) + botoes
123:     *--------------------------------------------------------------------------
124:     PROTECTED PROCEDURE ConfigurarPaginaLista()
125:         LOCAL loc_oPagina, loc_oGrid
126:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
127: 
128:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
129:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
130: 
131:         *-- Cabecalho escuro (cntSombra no legado): Top=1+29=30
132:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
133:         WITH loc_oPagina.cnt_4c_Cabecalho
134:             .Top         = 30
135:             .Left        = 0
136:             .Width       = THIS.Width
137:             .Height      = 80
138:             .BackColor   = RGB(100, 100, 100)
139:             .BorderWidth = 0
140:             .Visible     = .T.
141: 
142:             .AddObject("lbl_4c_Sombra", "Label")
143:             WITH .lbl_4c_Sombra
144:                 .Caption   = THIS.Caption
145:                 .Top       = 15
146:                 .Left      = 10
147:                 .Width     = THIS.Width
148:                 .Height    = 40
149:                 .AutoSize  = .F.
150:                 .FontName  = "Tahoma"
151:                 .FontSize  = 16
152:                 .FontBold  = .T.
153:                 .ForeColor = RGB(0, 0, 0)
154:                 .BackStyle = 0
155:                 .Visible   = .T.
156:             ENDWITH
157: 
158:             .AddObject("lbl_4c_Titulo", "Label")
159:             WITH .lbl_4c_Titulo
160:                 .Caption   = THIS.Caption
161:                 .Top       = 18
162:                 .Left      = 10
163:                 .Width     = THIS.Width
164:                 .Height    = 46

*-- Linhas 315 a 368:
315:             .Column11.Header1.Caption = "EmpD"
316:         ENDWITH
317: 
318:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Consultar, "Click", THIS, "BtnConsultarClick")
319:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
320: 
321:         THIS.FormatarGridLista(loc_oGrid)
322:         THIS.TornarControlesVisiveis(loc_oPagina)
323:     ENDPROC
324: 
325:     *--------------------------------------------------------------------------
326:     * ConfigurarPaginaDados - Page2: botoes, grade operacoes, campos header
327:     *--------------------------------------------------------------------------
328:     PROTECTED PROCEDURE ConfigurarPaginaDados()
329:         LOCAL loc_oPagina, loc_oGrid
330:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
331: 
332:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
333:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
334: 
335:         *-- Container salvar/cancelar (Grupo_Salva no legado)
336:         *-- Top=4+29=33, Left=829, Width=160, Height=85
337:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
338:         WITH loc_oPagina.cnt_4c_Salva
339:             .Top         = 33
340:             .Left        = 829
341:             .Width       = 160
342:             .Height      = 85
343:             .BackStyle   = 0
344:             .BorderWidth = 0
345:             .Visible     = .T.
346: 
347:             .AddObject("cmd_4c_Confirmar", "CommandButton")
348:             WITH .cmd_4c_Confirmar
349:                 .Caption         = "Confirmar"
350:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
351:                 .PicturePosition = 13
352:                 .Top             = 5
353:                 .Left            = 5
354:                 .Width           = 75
355:                 .Height          = 75
356:                 .BackColor       = RGB(255, 255, 255)
357:                 .ForeColor       = RGB(90, 90, 90)
358:                 .FontName        = "Comic Sans MS"
359:                 .FontBold        = .T.
360:                 .FontItalic      = .T.
361:                 .FontSize        = 8
362:                 .SpecialEffect   = 0
363:                 .MousePointer    = 15
364:                 .WordWrap        = .T.
365:                 .AutoSize        = .F.
366:                 .Visible         = .T.
367:             ENDWITH
368: 

*-- Linhas 702 a 725:
702:             .MousePointer  = 15
703:             .AutoSize      = .F.
704:             .Visible       = .T.
705:         ENDWITH
706: 
707:         *-- Container Origem/Destino/Representante (cnt_4c_Origem)
708:         *-- Top=173+29=202, Left=27, Width=582, Height=164
709:         loc_oPagina.AddObject("cnt_4c_Origem", "Container")
710:         WITH loc_oPagina.cnt_4c_Origem
711:             .Top         = 202
712:             .Left        = 27
713:             .Width       = 582
714:             .Height      = 164
715:             .BackStyle   = 1
716:             .BackColor   = RGB(240, 240, 240)
717:             .BorderWidth = 0
718:             .Visible     = .T.
719: 
720:             *-- Say8 "Origem"
721:             .AddObject("lbl_4c_LblOrigem", "Label")
722:             WITH .lbl_4c_LblOrigem
723:                 .Caption   = "Origem"
724:                 .Top       = 5
725:                 .Left      = 5

*-- Linhas 1220 a 1413:
1220:             .Visible       = .T.
1221:         ENDWITH
1222: 
1223:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar,         "Click",             THIS, "BtnConfirmarClick")
1224:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,          "Click",             THIS, "BtnCancelarClick")
1225:         BINDEVENT(loc_oPagina.cmd_4c_Entrega,                         "Click",             THIS, "BtnEntregaClick")
1226:         BINDEVENT(loc_oPagina.cmd_4c_SubNiveis,                       "Click",             THIS, "BtnSubNiveisClick")
1227:         BINDEVENT(loc_oPagina.grd_4c_Itens,                           "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
1228:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaO,            "KeyPress",          THIS, "ContaOKeyPress")
1229:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaO,            "DblClick",          THIS, "ContaODblClick")
1230:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaD,            "KeyPress",          THIS, "ContaDKeyPress")
1231:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaD,            "DblClick",          THIS, "ContaDDblClick")
1232:         BINDEVENT(loc_oPagina.cnt_4c_Origem.cmd_4c_BtnCadastros,      "Click",             THIS, "BtnCadastrosClick")
1233:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_DcontaD,           "KeyPress",         THIS, "DcontaDLostFocus")
1234:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_Dresps,            "KeyPress",         THIS, "DrespsDLostFocus")
1235: 
1236:         THIS.TornarControlesVisiveis(loc_oPagina)
1237:     ENDPROC
1238: 
1239:     *--------------------------------------------------------------------------
1240:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
1241:     *--------------------------------------------------------------------------
1242:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1243:         LOCAL loc_lResultado
1244:         loc_lResultado = .F.
1245:         TRY
1246:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1247:                 loc_lResultado = .F.
1248:             ELSE
1249:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1250:                 IF par_nPagina = 1
1251:                     THIS.pgf_4c_Paginas.Page1.Enabled = .T.
1252:                     THIS.this_cPcEscolha = ""
1253:                     THIS.CarregarLista()
1254:                 ENDIF
1255:                 loc_lResultado = .T.
1256:             ENDIF
1257:         CATCH TO loc_oErro
1258:             MsgErro(loc_oErro.Message, "Erro")
1259:         ENDTRY
1260:         RETURN loc_lResultado
1261:     ENDPROC
1262: 
1263:     *--------------------------------------------------------------------------
1264:     * CarregarLista - Vincula grid ao csTemporario e redefine headers
1265:     *--------------------------------------------------------------------------
1266:     PROCEDURE CarregarLista()
1267:         LOCAL loc_lResultado, loc_oGrid
1268:         loc_lResultado = .F.
1269:         TRY
1270:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1271:                 loc_lResultado = .T.
1272:             ELSE
1273:                 IF USED("csTemporario")
1274:                 GO TOP IN csTemporario
1275:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1276:                 loc_oGrid.RecordSource = "csTemporario"
1277:                 loc_oGrid.Column1.ControlSource    = "csTemporario.Numes"
1278:                 loc_oGrid.Column2.ControlSource    = "csTemporario.Datas"
1279:                 loc_oGrid.Column3.ControlSource    = "csTemporario.GrupoOs"
1280:                 loc_oGrid.Column4.ControlSource    = "csTemporario.ContaOs"
1281:                 loc_oGrid.Column5.ControlSource    = "csTemporario.GrupoDs"
1282:                 loc_oGrid.Column6.ControlSource    = "csTemporario.ContaDs"
1283:                 loc_oGrid.Column7.ControlSource    = "csTemporario.Nops"
1284:                 loc_oGrid.Column8.ControlSource    = "csTemporario.Usuars"
1285:                 loc_oGrid.Column9.ControlSource    = "csTemporario.PStatus"
1286:                 loc_oGrid.Column10.ControlSource   = "csTemporario.Emps"
1287:                 loc_oGrid.Column11.ControlSource   = "csTemporario.Empds"
1288:                 loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
1289:                 loc_oGrid.Column2.Header1.Caption  = "Data"
1290:                 loc_oGrid.Column3.Header1.Caption  = "Grupo"
1291:                 loc_oGrid.Column4.Header1.Caption  = "Origem"
1292:                 loc_oGrid.Column5.Header1.Caption  = "Grupo"
1293:                 loc_oGrid.Column6.Header1.Caption  = "Destino"
1294:                 loc_oGrid.Column7.Header1.Caption  = "Doc.Op"
1295:                 loc_oGrid.Column8.Header1.Caption  = "Usu" + CHR(225) + "rio"
1296:                 loc_oGrid.Column9.Header1.Caption  = "Status"
1297:                 loc_oGrid.Column10.Header1.Caption = "EmpO"
1298:                 loc_oGrid.Column11.Header1.Caption = "EmpD"
1299:                 loc_oGrid.Refresh()
1300:                 THIS.FormatarGridLista(loc_oGrid)
1301:                 loc_lResultado = .T.
1302:                 ENDIF
1303:             ENDIF
1304:         CATCH TO loc_oErro
1305:             MsgErro(loc_oErro.Message, "Erro")
1306:         ENDTRY
1307:         RETURN loc_lResultado
1308:     ENDPROC
1309: 
1310:     *--------------------------------------------------------------------------
1311:     * BtnConsultarClick - Navega para Page2 carregando dados do registro atual
1312:     *--------------------------------------------------------------------------
1313:     PROCEDURE BtnConsultarClick()
1314:         LOCAL loc_lResultado, loc_oPg2
1315:         loc_lResultado = .F.
1316:         TRY
1317:             IF !USED("csTemporario") OR EOF("csTemporario")
1318:                 MsgAviso("Selecione um registro na lista!", "")
1319:             ELSE
1320:                 THIS.this_cPcEscolha = "CONSULTAR"
1321:                 THIS.pgf_4c_Paginas.Page1.Enabled = .F.
1322:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1323: 
1324:                 SELECT csTemporario
1325:                 *-- Preencher campos basicos a partir do cursor csTemporario
1326:                 loc_oPg2.txt_4c_Codigo.Value  = ALLTRIM(TRANSFORM(csTemporario.Numes))
1327:                 loc_oPg2.txt_4c_Data.Value    = IIF(EMPTY(csTemporario.Datas), {}, csTemporario.Datas)
1328:                 loc_oPg2.txt_4c_PrvEnts.Value = IIF(EMPTY(csTemporario.PrazoEnts), {}, csTemporario.PrazoEnts)
1329:                 loc_oPg2.txt_4c_Nop.Value     = ALLTRIM(NVL(csTemporario.Nops, ""))
1330:                 loc_oPg2.txt_4c_PStatus.Value = ALLTRIM(NVL(csTemporario.PStatus, ""))
1331: 
1332:                 *-- Guardar chave composta do pedido (Emps+Dopes+Numes)
1333:                 THIS.this_cEmpdopnums = ALLTRIM(csTemporario.Emps) + ;
1334:                     ALLTRIM(csTemporario.Dopes) + ;
1335:                     TRANSFORM(csTemporario.Numes, "@@@@@@")
1336: 
1337:                 *-- Carregar grade de tipos de operacao
1338:                 THIS.CarregarGradeOperacao()
1339: 
1340:                 *-- Carregar propriedades do BO a partir do cursor
1341:                 THIS.this_oBusinessObject.CarregarDoCursorTemporario("csTemporario")
1342: 
1343:                 *-- Preencher campos Origem/Destino
1344:                 THIS.CarregarCamposOrigem()
1345: 
1346:                 *-- Carregar grade de itens do pedido
1347:                 THIS.CarregarGradeItens()
1348: 
1349:                 THIS.pgf_4c_Paginas.ActivePage = 2
1350:                 loc_lResultado = .T.
1351:             ENDIF
1352:         CATCH TO loc_oErro
1353:             MsgErro(loc_oErro.Message, "Erro")
1354:         ENDTRY
1355:         RETURN loc_lResultado
1356:     ENDPROC
1357: 
1358:     *--------------------------------------------------------------------------
1359:     * BtnEncerrarClick - Fecha o formulario
1360:     *--------------------------------------------------------------------------
1361:     PROCEDURE BtnEncerrarClick()
1362:         LOCAL loc_oErro
1363:         TRY
1364:             THIS.Release()
1365:         CATCH TO loc_oErro
1366:             MsgErro(loc_oErro.Message, "Erro")
1367:         ENDTRY
1368:     ENDPROC
1369: 
1370:     *--------------------------------------------------------------------------
1371:     * CarregarCamposOrigem - Preenche campos de Origem/Destino do cnt_4c_Origem
1372:     *--------------------------------------------------------------------------
1373:     PROCEDURE CarregarCamposOrigem()
1374:         LOCAL loc_lResultado, loc_oCnt, loc_oBO
1375:         loc_lResultado = .F.
1376:         TRY
1377:             loc_oBO  = THIS.this_oBusinessObject
1378:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem
1379: 
1380:             loc_oCnt.txt_4c_GrupoO.Value  = ALLTRIM(NVL(loc_oBO.this_cGrupoOs, ""))
1381:             loc_oCnt.txt_4c_ContaO.Value  = ALLTRIM(NVL(loc_oBO.this_cContaOs, ""))
1382:             loc_oCnt.txt_4c_GrupoD.Value  = ALLTRIM(NVL(loc_oBO.this_cGrupoDs, ""))
1383:             loc_oCnt.txt_4c_ContaD.Value  = ALLTRIM(NVL(loc_oBO.this_cContaDs, ""))
1384:             loc_oCnt.txt_4c_Dresps.Value  = ALLTRIM(NVL(loc_oBO.this_cDresps, ""))
1385: 
1386:             *-- Descricao da conta de Origem
1387:             loc_oBO.CarregarDescricaoCliente(ALLTRIM(NVL(loc_oBO.this_cContaOs, "")))
1388:             loc_oCnt.txt_4c_DcontaO.Value = ALLTRIM(NVL(loc_oBO.this_cDconta, ""))
1389: 
1390:             *-- Descricao da conta de Destino via SQL (SigCdCli)
1391:             LOCAL loc_cSQL, loc_nRes
1392:             IF !EMPTY(ALLTRIM(NVL(loc_oBO.this_cContaDs, "")))
1393:                 loc_cSQL = "SELECT TOP 1 Rclis FROM SigCdCli" + ;
1394:                            " WHERE Iclis = " + EscaparSQL(ALLTRIM(loc_oBO.this_cContaDs))
1395:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DcontaD")
1396:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_DcontaD") > 0
1397:                     loc_oCnt.txt_4c_DcontaD.Value = ALLTRIM(cursor_4c_DcontaD.Rclis)
1398:                 ENDIF
1399:                 IF USED("cursor_4c_DcontaD")
1400:                     USE IN cursor_4c_DcontaD
1401:                 ENDIF
1402:             ELSE
1403:                 loc_oCnt.txt_4c_DcontaD.Value = ""
1404:             ENDIF
1405: 
1406:             *-- Campos GruResp e Resps/Dresps (When=.F. no legado -> ReadOnly + Enabled=.F.)
1407:             IF USED("csTemporario")
1408:                 SELECT csTemporario
1409:                 IF PEMSTATUS(loc_oCnt, "txt_4c_GruResp", 5)
1410:                     loc_oCnt.txt_4c_GruResp.Value = ALLTRIM(NVL(csTemporario.GrupoDs, ""))
1411:                 ENDIF
1412:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Resps", 5)
1413:                     loc_oCnt.txt_4c_Resps.Value   = ALLTRIM(NVL(csTemporario.ContaDs, ""))

*-- Linhas 1424 a 1467:
1424:     *--------------------------------------------------------------------------
1425:     * CarregarGradeItens - Carrega cursor de itens e vincula ao grd_4c_Itens
1426:     *--------------------------------------------------------------------------
1427:     PROCEDURE CarregarGradeItens()
1428:         LOCAL loc_lResultado, loc_oGrid, loc_cSQL
1429:         loc_lResultado = .F.
1430:         TRY
1431:             *-- Acionar BO para construir xEestI
1432:             IF !THIS.this_oBusinessObject.MontarCursorItens(THIS.this_cEmpdopnums)
1433:                 loc_lResultado = .T.
1434:             ELSE
1435:                 *-- Criar cursor_4c_Itens com Saldo calculado a partir de xEestI
1436:                 IF USED("cursor_4c_Itens")
1437:                     USE IN cursor_4c_Itens
1438:                 ENDIF
1439:                 SELECT empdopnums, cpros, codcors, codtams, ;
1440:                        qtds, (qtds - qtbaixas) AS Saldos, qtbaixas, ;
1441:                        qtprods, qtbxprods, tpesos, descvals, DPros, OBS ;
1442:                     FROM xEestI ;
1443:                     INTO CURSOR cursor_4c_Itens READWRITE
1444: 
1445:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
1446:                 loc_oGrid.ColumnCount = 10
1447:                 loc_oGrid.RecordSource = "cursor_4c_Itens"
1448:                 loc_oGrid.ColumnCount  = 10
1449: 
1450:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Itens.cpros"
1451:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Itens.qtprods"
1452:                 loc_oGrid.Column3.ControlSource   = "cursor_4c_Itens.qtds"
1453:                 loc_oGrid.Column4.ControlSource   = "cursor_4c_Itens.Saldos"
1454:                 loc_oGrid.Column5.ControlSource   = "cursor_4c_Itens.qtbaixas"
1455:                 loc_oGrid.Column6.ControlSource   = "cursor_4c_Itens.qtbxprods"
1456:                 loc_oGrid.Column7.ControlSource   = "cursor_4c_Itens.codcors"
1457:                 loc_oGrid.Column8.ControlSource   = "cursor_4c_Itens.tpesos"
1458:                 loc_oGrid.Column9.ControlSource   = "cursor_4c_Itens.descvals"
1459:                 loc_oGrid.Column10.ControlSource  = "cursor_4c_Itens.codtams"
1460: 
1461:                 loc_oGrid.Column1.Header1.Caption  = "Produto"
1462:                 loc_oGrid.Column2.Header1.Caption  = "Produzido"
1463:                 loc_oGrid.Column3.Header1.Caption  = "Qtd."
1464:                 loc_oGrid.Column4.Header1.Caption  = "Saldo"
1465:                 loc_oGrid.Column5.Header1.Caption  = "Qtd.Baixa"
1466:                 loc_oGrid.Column6.Header1.Caption  = "Produzir"
1467:                 loc_oGrid.Column7.Header1.Caption  = ""

*-- Linhas 1488 a 2003:
1488:     *--------------------------------------------------------------------------
1489:     * GradeItensAfterRowColChange - Atualiza descricao/foto ao mudar linha do grid
1490:     *--------------------------------------------------------------------------
1491:     PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
1492:         LOCAL loc_lResultado, loc_cCpros, loc_oPg2
1493:         loc_lResultado = .F.
1494:         TRY
1495:             IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1496:                 loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1497:                 loc_cCpros = ALLTRIM(NVL(cursor_4c_Itens.cpros, ""))
1498: 
1499:                 loc_oPg2.txt_4c_Descr.Value   = ALLTRIM(NVL(cursor_4c_Itens.DPros, ""))
1500:                 loc_oPg2.txt_4c_ObsItem.Value = ALLTRIM(NVL(cursor_4c_Itens.OBS, ""))
1501: 
1502:                 THIS.CarregarImagemProduto(loc_cCpros)
1503:             ENDIF
1504:             loc_lResultado = .T.
1505:         CATCH TO loc_oErro
1506:             MsgErro(loc_oErro.Message, "Erro")
1507:         ENDTRY
1508:         RETURN loc_lResultado
1509:     ENDPROC
1510: 
1511:     *--------------------------------------------------------------------------
1512:     * CarregarImagemProduto - Busca FigJpgs de SigCdPro e exibe img_4c_FigJpg
1513:     *--------------------------------------------------------------------------
1514:     PROCEDURE CarregarImagemProduto(par_cCpros)
1515:         LOCAL loc_lResultado, loc_cSQL, loc_nRes, loc_cArqTemp, loc_oImg
1516:         loc_lResultado = .F.
1517:         TRY
1518:             loc_oImg = THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg
1519:             loc_oImg.Visible = .F.
1520:             loc_oImg.Picture = ""
1521: 
1522:             IF !EMPTY(ALLTRIM(par_cCpros)) AND gnConnHandle > 0
1523:                 loc_cSQL = "SELECT TOP 1 FigJpgs FROM SigCdPro" + ;
1524:                            " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros))
1525:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigJpg")
1526:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_FigJpg") > 0
1527:                     IF !ISNULL(cursor_4c_FigJpg.FigJpgs) AND ;
1528:                        LEN(cursor_4c_FigJpg.FigJpgs) > 0
1529:                         loc_cArqTemp = ADDBS(SYS(2023)) + "Temp3.jpg"
1530:                         STRTOFILE(cursor_4c_FigJpg.FigJpgs, loc_cArqTemp, 0)
1531:                         IF FILE(loc_cArqTemp)
1532:                             loc_oImg.Picture = loc_cArqTemp
1533:                             loc_oImg.Visible = .T.
1534:                         ENDIF
1535:                     ENDIF
1536:                 ENDIF
1537:                 IF USED("cursor_4c_FigJpg")
1538:                     USE IN cursor_4c_FigJpg
1539:                 ENDIF
1540:             ENDIF
1541:             loc_lResultado = .T.
1542:         CATCH TO loc_oErro
1543:             MsgErro(loc_oErro.Message, "Erro")
1544:         ENDTRY
1545:         RETURN loc_lResultado
1546:     ENDPROC
1547: 
1548:     *--------------------------------------------------------------------------
1549:     * AbrirLookupContaO - Lookup FormBuscaAuxiliar para conta de Origem
1550:     *--------------------------------------------------------------------------
1551:     PROCEDURE AbrirLookupContaO()
1552:         LOCAL loc_lResultado, loc_oLookup, loc_oCnt
1553:         loc_lResultado = .F.
1554:         TRY
1555:             loc_oCnt   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem
1556:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1557:                 "SigCdCli", "cursor_4c_BuscaContaO", "Iclis", ;
1558:                 ALLTRIM(loc_oCnt.txt_4c_ContaO.Value), ;
1559:                 "Conta de Origem")
1560:             loc_oLookup.mAddColuna("Iclis",  "", "Conta")
1561:             loc_oLookup.mAddColuna("Rclis",  "", "Nome")
1562:             loc_oLookup.Show()
1563:             IF loc_oLookup.this_lSelecionou
1564:                 loc_oCnt.txt_4c_ContaO.Value  = ALLTRIM(cursor_4c_BuscaContaO.Iclis)
1565:                 loc_oCnt.txt_4c_DcontaO.Value = ALLTRIM(cursor_4c_BuscaContaO.Rclis)
1566:                 THIS.this_oBusinessObject.this_cContaOs = ALLTRIM(cursor_4c_BuscaContaO.Iclis)
1567:             ENDIF
1568:             IF USED("cursor_4c_BuscaContaO")
1569:                 USE IN cursor_4c_BuscaContaO
1570:             ENDIF
1571:             loc_oLookup.Release()
1572:             loc_oLookup = .NULL.
1573:             loc_lResultado = .T.
1574:         CATCH TO loc_oErro
1575:             MsgErro(loc_oErro.Message, "Erro")
1576:         ENDTRY
1577:         RETURN loc_lResultado
1578:     ENDPROC
1579: 
1580:     *--------------------------------------------------------------------------
1581:     * AbrirLookupContaD - Lookup FormBuscaAuxiliar para conta de Destino
1582:     *--------------------------------------------------------------------------
1583:     PROCEDURE AbrirLookupContaD()
1584:         LOCAL loc_lResultado, loc_oLookup, loc_oCnt
1585:         loc_lResultado = .F.
1586:         TRY
1587:             loc_oCnt   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem
1588:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1589:                 "SigCdCli", "cursor_4c_BuscaContaD", "Iclis", ;
1590:                 ALLTRIM(loc_oCnt.txt_4c_ContaD.Value), ;
1591:                 "Conta de Destino")
1592:             loc_oLookup.mAddColuna("Iclis",  "", "Conta")
1593:             loc_oLookup.mAddColuna("Rclis",  "", "Nome")
1594:             loc_oLookup.Show()
1595:             IF loc_oLookup.this_lSelecionou
1596:                 loc_oCnt.txt_4c_ContaD.Value  = ALLTRIM(cursor_4c_BuscaContaD.Iclis)
1597:                 loc_oCnt.txt_4c_DcontaD.Value = ALLTRIM(cursor_4c_BuscaContaD.Rclis)
1598:                 THIS.this_oBusinessObject.this_cContaDs = ALLTRIM(cursor_4c_BuscaContaD.Iclis)
1599:             ENDIF
1600:             IF USED("cursor_4c_BuscaContaD")
1601:                 USE IN cursor_4c_BuscaContaD
1602:             ENDIF
1603:             loc_oLookup.Release()
1604:             loc_oLookup = .NULL.
1605:             loc_lResultado = .T.
1606:         CATCH TO loc_oErro
1607:             MsgErro(loc_oErro.Message, "Erro")
1608:         ENDTRY
1609:         RETURN loc_lResultado
1610:     ENDPROC
1611: 
1612:     *--------------------------------------------------------------------------
1613:     * ContaOKeyPress - Abre lookup de Origem com Enter (keycode 28 = F4)
1614:     *--------------------------------------------------------------------------
1615:     PROCEDURE ContaOKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1616:         IF par_nKeyCode = 28 OR par_nKeyCode = 9 OR par_nKeyCode = 13 OR ;
1617:            par_nKeyCode = 115
1618:             IF par_nKeyCode = 28 OR par_nKeyCode = 115
1619:                 THIS.AbrirLookupContaO()
1620:             ENDIF
1621:         ENDIF
1622:     ENDPROC
1623: 
1624:     *--------------------------------------------------------------------------
1625:     * ContaODblClick - Abre lookup de Origem ao dar duplo clique
1626:     *--------------------------------------------------------------------------
1627:     PROCEDURE ContaODblClick()
1628:         THIS.AbrirLookupContaO()
1629:     ENDPROC
1630: 
1631:     *--------------------------------------------------------------------------
1632:     * ContaDKeyPress - Abre lookup de Destino com F4 (keycode 115)
1633:     *--------------------------------------------------------------------------
1634:     PROCEDURE ContaDKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1635:         IF par_nKeyCode = 28 OR par_nKeyCode = 9 OR par_nKeyCode = 13 OR ;
1636:            par_nKeyCode = 115
1637:             IF par_nKeyCode = 28 OR par_nKeyCode = 115
1638:                 THIS.AbrirLookupContaD()
1639:             ENDIF
1640:         ENDIF
1641:     ENDPROC
1642: 
1643:     *--------------------------------------------------------------------------
1644:     * ContaDDblClick - Abre lookup de Destino ao dar duplo clique
1645:     *--------------------------------------------------------------------------
1646:     PROCEDURE ContaDDblClick()
1647:         THIS.AbrirLookupContaD()
1648:     ENDPROC
1649: 
1650:     *--------------------------------------------------------------------------
1651:     * DcontaDLostFocus - Move foco para botao Confirmar
1652:     *--------------------------------------------------------------------------
1653:     PROCEDURE DcontaDLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1654:         LOCAL loc_oErro
1655:         TRY
1656:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
1657:         CATCH TO loc_oErro
1658:             MsgErro(loc_oErro.Message, "Erro")
1659:         ENDTRY
1660:     ENDPROC
1661: 
1662:     *--------------------------------------------------------------------------
1663:     * DrespsDLostFocus - Move foco para botao Confirmar
1664:     *--------------------------------------------------------------------------
1665:     PROCEDURE DrespsDLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1666:         LOCAL loc_oErro
1667:         TRY
1668:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
1669:         CATCH TO loc_oErro
1670:             MsgErro(loc_oErro.Message, "Erro")
1671:         ENDTRY
1672:     ENDPROC
1673: 
1674:     *--------------------------------------------------------------------------
1675:     * BtnCadastrosClick - Abre formulario de cadastro de contas (SIGCDCTA)
1676:     *--------------------------------------------------------------------------
1677:     PROCEDURE BtnCadastrosClick()
1678:         LOCAL loc_oErro, loc_cContaD
1679:         TRY
1680:             loc_cContaD = ""
1681:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem, "txt_4c_ContaD", 5)
1682:                 loc_cContaD = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_ContaD.Value)
1683:             ENDIF
1684:             DO FORM SIGCDCTA WITH 0, "SIGCDCTA", loc_cContaD, .T., "", "", .T.
1685:         CATCH TO loc_oErro
1686:             MsgErro(loc_oErro.Message, "Erro")
1687:         ENDTRY
1688:     ENDPROC
1689: 
1690:     *--------------------------------------------------------------------------
1691:     * Destroy - Limpa recursos ao fechar o formulario
1692:     *--------------------------------------------------------------------------
1693:     PROCEDURE Destroy()
1694:         LOCAL loc_oErro
1695:         TRY
1696:             IF USED("cursor_4c_Itens")
1697:                 USE IN cursor_4c_Itens
1698:             ENDIF
1699:             IF USED("cursor_4c_Operacao")
1700:                 USE IN cursor_4c_Operacao
1701:             ENDIF
1702:             IF USED("xEestI")
1703:                 USE IN xEestI
1704:             ENDIF
1705:             IF USED("crSigMvItn")
1706:                 USE IN crSigMvItn
1707:             ENDIF
1708:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1709:                 THIS.this_oBusinessObject = .NULL.
1710:             ENDIF
1711:             THIS.this_oParentForm = .NULL.
1712:         CATCH TO loc_oErro
1713:             MsgErro(loc_oErro.Message, "Erro")
1714:         ENDTRY
1715:         DODEFAULT()
1716:     ENDPROC
1717: 
1718:     *--------------------------------------------------------------------------
1719:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1720:     *--------------------------------------------------------------------------
1721:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1722:         LOCAL loc_nI, loc_oObjeto, loc_nP
1723:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1724:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1725:             IF VARTYPE(loc_oObjeto) = "O"
1726:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1727:                     loc_oObjeto.Visible = .T.
1728:                 ENDIF
1729:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1730:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1731:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1732:                     ENDFOR
1733:                 ENDIF
1734:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1735:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1736:                 ENDIF
1737:             ENDIF
1738:         ENDFOR
1739:     ENDPROC
1740: 
1741:     *--------------------------------------------------------------------------
1742:     * FormatarGridLista - Formata visual do grid da lista
1743:     *--------------------------------------------------------------------------
1744:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1745:         WITH par_oGrid
1746:             .FontName = "Tahoma"
1747:             .FontSize = 8
1748:         ENDWITH
1749:     ENDPROC
1750: 
1751:     *--------------------------------------------------------------------------
1752:     * BtnConfirmarClick - Volta para Page1 (OK no detalhe)
1753:     *--------------------------------------------------------------------------
1754:     PROCEDURE BtnConfirmarClick()
1755:         LOCAL loc_oErro
1756:         TRY
1757:             THIS.pgf_4c_Paginas.Page1.Enabled = .T.
1758:             THIS.this_cPcEscolha = ""
1759:             THIS.AlternarPagina(1)
1760:         CATCH TO loc_oErro
1761:             MsgErro(loc_oErro.Message, "Erro")
1762:         ENDTRY
1763:     ENDPROC
1764: 
1765:     *--------------------------------------------------------------------------
1766:     * BtnCancelarClick - Cancela visualizacao e volta para Page1
1767:     *--------------------------------------------------------------------------
1768:     PROCEDURE BtnCancelarClick()
1769:         LOCAL loc_oErro
1770:         TRY
1771:             THIS.pgf_4c_Paginas.Page1.Enabled = .T.
1772:             THIS.this_lPlCancelar = .T.
1773:             THIS.this_cPcEscolha  = ""
1774:             THIS.AlternarPagina(1)
1775:         CATCH TO loc_oErro
1776:             MsgErro(loc_oErro.Message, "Erro")
1777:         ENDTRY
1778:     ENDPROC
1779: 
1780:     *--------------------------------------------------------------------------
1781:     * BtnEntregaClick - Abre form SigOpEnt para agendamento de entrega
1782:     *--------------------------------------------------------------------------
1783:     PROCEDURE BtnEntregaClick()
1784:         LOCAL loc_lResultado, loc_dData, loc_dEst, loc_oErro
1785:         loc_lResultado = .F.
1786:         TRY
1787:             IF !USED("csTemporario") OR EOF("csTemporario")
1788:                 MsgAviso("Nenhum pedido selecionado!", "")
1789:             ELSE
1790:                 SELECT csTemporario
1791:                 loc_dData = IIF(EMPTY(csTemporario.PrazoEnts), DATE(), csTemporario.PrazoEnts)
1792:                 loc_dEst  = IIF(EMPTY(csTemporario.Datas), DATE(), csTemporario.Datas)
1793:                 DO FORM SigOpEnt WITH csTemporario.Emps, csTemporario.Dopes, ;
1794:                     csTemporario.Numes, loc_dData, THIS, 0, loc_dEst, .T., 0
1795:                 loc_lResultado = .T.
1796:             ENDIF
1797:         CATCH TO loc_oErro
1798:             MsgErro(loc_oErro.Message, "Erro")
1799:         ENDTRY
1800:         RETURN loc_lResultado
1801:     ENDPROC
1802: 
1803:     *--------------------------------------------------------------------------
1804:     * BtnSubNiveisClick - Abre form SigMvSbn para sub-niveis do pedido
1805:     *--------------------------------------------------------------------------
1806:     PROCEDURE BtnSubNiveisClick()
1807:         LOCAL loc_oErro
1808:         TRY
1809:             IF !USED("csTemporario") OR EOF("csTemporario")
1810:                 MsgAviso("Nenhum pedido selecionado!", "")
1811:             ELSE
1812:                 SELECT csTemporario
1813:                 DO FORM SigMvSbn WITH THIS, csTemporario.Emps, csTemporario.Dopes, ;
1814:                     csTemporario.Numes, "csTemporario"
1815:             ENDIF
1816:         CATCH TO loc_oErro
1817:             MsgErro(loc_oErro.Message, "Erro")
1818:         ENDTRY
1819:     ENDPROC
1820: 
1821:     *--------------------------------------------------------------------------
1822:     * CarregarGradeOperacao - Carrega grade de tipos de operacao (SigCdOpe)
1823:     *--------------------------------------------------------------------------
1824:     PROTECTED PROCEDURE CarregarGradeOperacao()
1825:         LOCAL loc_lResultado, loc_oGrid, loc_cSQL, loc_nResult
1826:         loc_lResultado = .F.
1827:         TRY
1828:             IF gnConnHandle <= 0
1829:                 loc_lResultado = .T.
1830:             ELSE
1831:                 loc_oGrid   = THIS.pgf_4c_Paginas.Page2.grd_4c_Operacao
1832:                 loc_cSQL    = "SELECT Dopes FROM SigCdOpe"
1833:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacao")
1834:                 IF loc_nResult > 0
1835:                     loc_oGrid.ColumnCount = 1
1836:                     loc_oGrid.RecordSource = "cursor_4c_Operacao"
1837:                     loc_oGrid.ColumnCount  = 1
1838:                     loc_oGrid.Column1.ControlSource   = "cursor_4c_Operacao.Dopes"
1839:                     loc_oGrid.Column1.Width           = 110
1840:                     loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1841:                     loc_oGrid.Refresh()
1842:                 ENDIF
1843:                 loc_lResultado = .T.
1844:             ENDIF
1845:         CATCH TO loc_oErro
1846:             MsgErro(loc_oErro.Message, "Erro")
1847:         ENDTRY
1848:         RETURN loc_lResultado
1849:     ENDPROC
1850: 
1851: 
1852:     *--------------------------------------------------------------------------
1853:     * BtnIncluirClick - Nao disponivel neste form operacional
1854:     * Legado: Inserir.Enabled=.F. + Visible=.F. (form e somente consulta)
1855:     *--------------------------------------------------------------------------
1856:     PROCEDURE BtnIncluirClick()
1857:         THIS.AlternarPagina(1)
1858:     ENDPROC
1859: 
1860:     *--------------------------------------------------------------------------
1861:     * BtnAlterarClick - Nao disponivel neste form operacional
1862:     * Legado: Alterar.Enabled=.F. + Visible=.F. (form e somente consulta)
1863:     *--------------------------------------------------------------------------
1864:     PROCEDURE BtnAlterarClick()
1865:         THIS.AlternarPagina(1)
1866:     ENDPROC
1867: 
1868:     *--------------------------------------------------------------------------
1869:     * BtnVisualizarClick - Navega para Page2 com dados do pedido selecionado
1870:     * Equivalente ao BtnConsultarClick (mesmo comportamento)
1871:     *--------------------------------------------------------------------------
1872:     PROCEDURE BtnVisualizarClick()
1873:         THIS.BtnConsultarClick()
1874:     ENDPROC
1875: 
1876:     *--------------------------------------------------------------------------
1877:     * BtnExcluirClick - Nao disponivel neste form operacional
1878:     * Legado: Excluir.Enabled=.F. + Visible=.F. (form e somente consulta)
1879:     *--------------------------------------------------------------------------
1880:     PROCEDURE BtnExcluirClick()
1881:         THIS.AlternarPagina(1)
1882:     ENDPROC
1883: 
1884:     *--------------------------------------------------------------------------
1885:     * BtnBuscarClick - Procurar oculto no legado; recarrega lista
1886:     *--------------------------------------------------------------------------
1887:     PROCEDURE BtnBuscarClick()
1888:         THIS.CarregarLista()
1889:     ENDPROC
1890: 
1891:     *--------------------------------------------------------------------------
1892:     * BtnSalvarClick - Equivalente ao BtnConfirmarClick neste form operacional
1893:     *--------------------------------------------------------------------------
1894:     PROCEDURE BtnSalvarClick()
1895:         THIS.BtnConfirmarClick()
1896:     ENDPROC
1897: 
1898:     *--------------------------------------------------------------------------
1899:     * FormParaBO - Form e somente leitura; BO ja foi carregado do csTemporario
1900:     *--------------------------------------------------------------------------
1901:     PROTECTED PROCEDURE FormParaBO()
1902:         RETURN .T.
1903:     ENDPROC
1904: 
1905:     *--------------------------------------------------------------------------
1906:     * BOParaForm - Carrega propriedades do BO para os campos da Page2
1907:     *--------------------------------------------------------------------------
1908:     PROTECTED PROCEDURE BOParaForm()
1909:         LOCAL loc_lResultado
1910:         loc_lResultado = .F.
1911:         TRY
1912:             loc_lResultado = THIS.CarregarCamposOrigem()
1913:         CATCH TO loc_oErro
1914:             MsgErro(loc_oErro.Message, "Erro")
1915:         ENDTRY
1916:         RETURN loc_lResultado
1917:     ENDPROC
1918: 
1919:     *--------------------------------------------------------------------------
1920:     * HabilitarCampos - Form operacional de consulta; campos sao todos ReadOnly
1921:     *--------------------------------------------------------------------------
1922:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1923:         LOCAL loc_lResultado, loc_oPg2, loc_oCnt
1924:         loc_lResultado = .F.
1925:         TRY
1926:             IF PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
1927:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1928:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Nota", 5)
1929:                     loc_oPg2.txt_4c_Nota.ReadOnly = .T.
1930:                 ENDIF
1931:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
1932:                     loc_oCnt = loc_oPg2.cnt_4c_Origem
1933:                     IF PEMSTATUS(loc_oCnt, "txt_4c_ContaO", 5)
1934:                         loc_oCnt.txt_4c_ContaO.ReadOnly = .T.
1935:                     ENDIF
1936:                     IF PEMSTATUS(loc_oCnt, "txt_4c_ContaD", 5)
1937:                         loc_oCnt.txt_4c_ContaD.ReadOnly = .T.
1938:                     ENDIF
1939:                 ENDIF
1940:             ENDIF
1941:             loc_lResultado = .T.
1942:         CATCH TO loc_oErro
1943:             MsgErro(loc_oErro.Message, "Erro")
1944:         ENDTRY
1945:         RETURN loc_lResultado
1946:     ENDPROC
1947: 
1948:     *--------------------------------------------------------------------------
1949:     * LimparCampos - Limpa todos os campos de exibicao da Page2
1950:     *--------------------------------------------------------------------------
1951:     PROTECTED PROCEDURE LimparCampos()
1952:         LOCAL loc_lResultado, loc_oPg2, loc_oCnt
1953:         loc_lResultado = .F.
1954:         TRY
1955:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1956:             loc_oPg2.txt_4c_Codigo.Value  = ""
1957:             loc_oPg2.txt_4c_Data.Value    = {}
1958:             loc_oPg2.txt_4c_PrvEnts.Value = {}
1959:             loc_oPg2.txt_4c_Nota.Value    = ""
1960:             loc_oPg2.txt_4c_Nop.Value     = ""
1961:             loc_oPg2.txt_4c_Tabd.Value    = ""
1962:             loc_oPg2.txt_4c_PStatus.Value = ""
1963:             loc_oPg2.txt_4c_Descr.Value   = ""
1964:             loc_oPg2.txt_4c_ObsItem.Value = ""
1965: 
1966:             loc_oCnt = loc_oPg2.cnt_4c_Origem
1967:             loc_oCnt.txt_4c_GrupoO.Value  = ""
1968:             loc_oCnt.txt_4c_ContaO.Value  = ""
1969:             loc_oCnt.txt_4c_DcontaO.Value = ""
1970:             loc_oCnt.txt_4c_GrupoD.Value  = ""
1971:             loc_oCnt.txt_4c_ContaD.Value  = ""
1972:             loc_oCnt.txt_4c_DcontaD.Value = ""
1973:             loc_oCnt.txt_4c_GruResp.Value = ""
1974:             loc_oCnt.txt_4c_Resps.Value   = ""
1975:             loc_oCnt.txt_4c_Dresps.Value  = ""
1976: 
1977:             loc_oPg2.cnt_4c_ObsItem.txt_4c_ObsMemo.Value = ""
1978: 
1979:             loc_oPg2.img_4c_FigJpg.Visible = .F.
1980:             loc_oPg2.img_4c_FigJpg.Picture = ""
1981: 
1982:             loc_lResultado = .T.
1983:         CATCH TO loc_oErro
1984:             MsgErro(loc_oErro.Message, "Erro")
1985:         ENDTRY
1986:         RETURN loc_lResultado
1987:     ENDPROC
1988: 
1989:     *--------------------------------------------------------------------------
1990:     * AjustarBotoesPorModo - Modo fixo: apenas Consultar disponivel
1991:     *--------------------------------------------------------------------------
1992:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1993:         LOCAL loc_oErro
1994:         TRY
1995:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Consultar", 5)
1996:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Consultar.Enabled = .T.
1997:             ENDIF
1998:         CATCH TO loc_oErro
1999:             MsgErro(loc_oErro.Message, "Erro")
2000:         ENDTRY
2001:     ENDPROC
2002: 
2003: ENDDEFINE


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

