# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (20)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'optAnaSin' (parent: SIGREESP): Top original=347 vs migrado 'obj_4c_OptAnaSin' Top=5 (diff=342px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optAnaSin' (parent: SIGREESP): Left original=89 vs migrado 'obj_4c_OptAnaSin' Left=5 (diff=84px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_dopes' (parent: SIGREESP): Top original=124 vs migrado 'lbl_4c_Lbl_dopes' Top=44 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGREESP): Top original=232 vs migrado 'lbl_4c_Say3' Top=152 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGREESP): Top original=232 vs migrado 'lbl_4c_Say2' Top=152 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGREESP): Top original=325 vs migrado 'lbl_4c_Say5' Top=245 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_estoque' (parent: SIGREESP): Top original=178 vs migrado 'lbl_4c_Lbl_estoque' Top=98 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo' (parent: SIGREESP): Top original=97 vs migrado 'lbl_4c_Lbl_periodo_a' Top=17 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo' (parent: SIGREESP): Left original=47 vs migrado 'lbl_4c_Lbl_periodo_a' Left=188 (diff=141px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGREESP): Top original=259 vs migrado 'lbl_4c_Say1' Top=179 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo_a' (parent: SIGREESP): Top original=97 vs migrado 'lbl_4c_Lbl_periodo_a' Top=17 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'estado' (parent: SIGREESP): Top original=227 vs migrado 'txt_4c_Estado' Top=147 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cidade' (parent: SIGREESP): Top original=227 vs migrado 'txt_4c_Cidade' Top=147 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGREESP): Top original=352 vs migrado 'lbl_4c_Say7' Top=272 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkTpope' (parent: SIGREESP): Top original=369 vs migrado 'chk_4c_ChkTpope' Top=289 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkItens' (parent: SIGREESP): Top original=304 vs migrado 'chk_4c_ChkItens' Top=224 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkIndus' (parent: SIGREESP): Top original=387 vs migrado 'chk_4c_ChkIndus' Top=307 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkSemVals' (parent: SIGREESP): Top original=369 vs migrado 'chk_4c_ChkSemVals' Top=289 (diff=80px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReEsp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2208 linhas total):

*-- Linhas 5 a 210:
5: * Migrado de: SigReEsp.SCX (frmrelatorio)
6: * Layout: FLAT (sem PageFrame de lista+dados - todos os controles direto no form)
7: *
8: * Fase 3/8: Estrutura base - Init, InicializarForm, Cabecalho, Botoes, Destroy
9: * Fase 4: grdOperacoes + cmdBtnGradeS + CarregarOperacoes
10: * Fases 5-6: controles de filtro (TextBox, OptionGroup, ComboBox, CheckBox)
11: * Fases 7-8: FormParaRelatorio, LimparCampos, eventos de lookup (KeyPress/LostFocus)
12: *==============================================================================
13: 
14: DEFINE CLASS FormSigReEsp AS FormBase
15: 
16:     *-- Dimensoes e aparencia (EXATAS do original SCX)
17:     Height      = 420
18:     Width       = 810
19:     DataSession = 2
20:     ShowWindow  = 1
21:     WindowType  = 1
22:     AutoCenter  = .T.
23:     BorderStyle = 2
24:     ControlBox  = .F.
25:     MaxButton   = .F.
26:     MinButton   = .F.
27:     TitleBar    = 0
28:     Themes      = .F.
29:     ShowTips    = .T.
30: 
31:     *-- BO do relatorio (relatorios usam this_oRelatorio, nao this_oBusinessObject)
32:     this_oRelatorio    = .NULL.
33:     this_cMensagemErro = ""
34: 
35:     *==========================================================================
36:     * INIT - Delegado ao FormBase, que chama THIS.InicializarForm()
37:     *==========================================================================
38:     PROCEDURE Init()
39:         RETURN DODEFAULT()
40:     ENDPROC
41: 
42:     *==========================================================================
43:     * INICIALIZARFORM - Cria todos os controles visuais do form
44:     *==========================================================================
45:     PROTECTED PROCEDURE InicializarForm()
46:         LOCAL loc_lSucesso
47:         loc_lSucesso = .F.
48: 
49:         TRY
50:             IF TYPE("gc_4c_CaminhoIcones") != "C"
51:                 gc_4c_CaminhoIcones = ""
52:             ENDIF
53: 
54:             THIS.Caption = "Estat" + CHR(237) + "stica de Pedidos"
55:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
56: 
57:             *-- Instanciar BO do relatorio
58:             THIS.this_oRelatorio = CREATEOBJECT("SigReEspBO")
59:             IF VARTYPE(THIS.this_oRelatorio) != "O"
60:                 THIS.this_cMensagemErro = "Falha ao criar SigReEspBO (VARTYPE=" + ;
61:                     VARTYPE(THIS.this_oRelatorio) + ")"
62:                 loc_lSucesso = .F.
63:             ENDIF
64: 
65:             *-- Cursor placeholder para grdOperacoes (cria estrutura vazia)
66:             *-- Equivalente ao "Create Cursor crOperacoes" do Init() legado
67:             THIS.CriarCursorOperacoes()
68: 
69:             *-- Cabecalho escuro com titulo (padrao frmrelatorio - cntSombra)
70:             THIS.ConfigurarCabecalho()
71: 
72:             *-- CommandGroup de 4 botoes de relatorio (padrao framework.vcx - btnReport)
73:             THIS.ConfigurarBotoes()
74: 
75:             *-- PageFrame com 1 pagina (Filtros) - container dos controles abaixo do cabecalho
76:             THIS.ConfigurarPageFrame()
77: 
78:             *-- Page1: grid de selecao de tipos de operacao + botoes Sel/Des todos
79:             *-- (em forms REPORT, ConfigurarPaginaLista monta a "pagina de selecao" -
80:             *--  equivalente ao papel da Page1/Lista em forms CRUD)
81:             THIS.ConfigurarPaginaLista()
82: 
83:             *-- Controles de filtro - primeira metade (Periodo, Operacao, Tipo, Conta, Vendedor)
84:             THIS.ConfigurarPaginaDados()
85: 
86:             *-- Carregar tipos de operacao via SQL (pular em modo validacao UI)
87:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
88:                 THIS.CarregarOperacoes()
89:             ENDIF
90: 
91:             *-- Tornar form visivel
92:             THIS.Visible = .T.
93: 
94:             loc_lSucesso = .T.
95: 
96:         CATCH TO loc_oErro
97:             THIS.this_cMensagemErro = loc_oErro.Message
98:             MsgErro(loc_oErro.Message, "InicializarForm - FormSigReEsp")
99:         ENDTRY
100: 
101:         RETURN loc_lSucesso
102:     ENDPROC
103: 
104:     *==========================================================================
105:     * CONFIGURARPAGEFRAME - PageFrame com 2 paginas (Filtros / Dados)
106:     *
107:     *   O SCX legado SIGREESP eh FLAT mas no novo padrao do sistema os
108:     *   controles abaixo do cabecalho ficam encapsulados num PageFrame com
109:     *   PageCount=2 para consistencia com o ciclo de navegacao do FormBase
110:     *   (Page1 = "lista" / filtros, Page2 = "dados" reservado para extensoes).
111:     *
112:     *   Geometria: inicia logo abaixo do cabecalho (Top=80), ocupa toda a
113:     *   largura do form e o espaco restante na altura. Tabs ocultos (Tabs=.F.)
114:     *   - a navegacao eh feita via AlternarPagina().
115:     *==========================================================================
116:     PROTECTED PROCEDURE ConfigurarPageFrame()
117:         LOCAL loc_oPgf
118: 
119:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
120:         loc_oPgf = THIS.pgf_4c_Paginas
121: 
122:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1/Page2
123:         loc_oPgf.PageCount = 2
124: 
125:         loc_oPgf.Top    = 80
126:         loc_oPgf.Left   = -1
127:         loc_oPgf.Width  = THIS.Width + 2
128:         loc_oPgf.Height = THIS.Height - 80
129:         loc_oPgf.Tabs   = .F.
130: 
131:         *-- Page1 = "Filtros" (lista de selecao + filtros)
132:         loc_oPgf.Page1.Caption   = "Filtros"
133:         loc_oPgf.Page1.FontName  = "Tahoma"
134:         loc_oPgf.Page1.FontSize  = 8
135:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
136:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
137:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
138: 
139:         *-- Page2 = "Dados" (reservada - frmrelatorio nao usa, mantida para
140:         *--                  compatibilidade com o ciclo padrao do FormBase)
141:         loc_oPgf.Page2.Caption   = "Dados"
142:         loc_oPgf.Page2.FontName  = "Tahoma"
143:         loc_oPgf.Page2.FontSize  = 8
144:         loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
145:         loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
146:         loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)
147: 
148:         loc_oPgf.Visible    = .T.
149:         loc_oPgf.ActivePage = 1
150:     ENDPROC
151: 
152:     *==========================================================================
153:     * CRIARCURSOROPERACOES - Cria cursor vazio de tipos de operacao
154:     * Espelha o "Create Cursor crOperacoes" do Init() original + Index
155:     * Fase 4 ira popular com dados do SQL Server (SigCdTom) e configurar grid
156:     *==========================================================================
157:     PROTECTED PROCEDURE CriarCursorOperacoes()
158:         IF USED("crOperacoes")
159:             USE IN crOperacoes
160:         ENDIF
161:         CREATE CURSOR crOperacoes (SelImp L(1), Codigos N(2), Descrs C(30), SelImp2 L(1), SelImp3 L(1))
162:         INDEX ON Codigos TAG Codigos
163:     ENDPROC
164: 
165:     *==========================================================================
166:     * CONFIGURARCABECALHO - Cabecalho escuro com titulo
167:     * Equivalente a cntSombra do framework.vcx
168:     * BackColor=RGB(100,100,100), Width=THIS.Width (nao subtrair!)
169:     *==========================================================================
170:     PROTECTED PROCEDURE ConfigurarCabecalho()
171:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
172:         WITH THIS.cnt_4c_Cabecalho
173:             .Top        = 0
174:             .Left       = 0
175:             .Width      = THIS.Width
176:             .Height     = 80
177:             .BackStyle  = 1
178:             .BackColor  = RGB(100, 100, 100)
179:             .BorderWidth = 0
180:             .Visible    = .T.
181: 
182:             *-- Sombra preta (deslocada 3px para efeito de profundidade)
183:             .AddObject("lbl_4c_Sombra", "Label")
184:             WITH .lbl_4c_Sombra
185:                 .Top       = 18
186:                 .Left      = 12
187:                 .Width     = THIS.Width
188:                 .Height    = 46
189:                 .Caption   = THIS.Caption
190:                 .FontName  = "Tahoma"
191:                 .FontSize  = 16
192:                 .FontBold  = .T.
193:                 .ForeColor = RGB(0, 0, 0)
194:                 .BackStyle = 0
195:                 .Visible   = .T.
196:             ENDWITH
197: 
198:             *-- Titulo branco (sobre o fundo cinza escuro)
199:             .AddObject("lbl_4c_Titulo", "Label")
200:             WITH .lbl_4c_Titulo
201:                 .Top       = 15
202:                 .Left      = 10
203:                 .Width     = THIS.Width
204:                 .Height    = 46
205:                 .Caption   = THIS.Caption
206:                 .FontName  = "Tahoma"
207:                 .FontSize  = 16
208:                 .FontBold  = .T.
209:                 .ForeColor = RGB(255, 255, 255)
210:                 .BackStyle = 0

*-- Linhas 220 a 263:
220:     *   Botoes: Width=65, Height=70, Lefts=5,71,137,203
221:     * Imagens: ideo.jpg / impressora.jpg / excel.jpg / otao_encerrar.jpg
222:     *==========================================================================
223:     PROTECTED PROCEDURE ConfigurarBotoes()
224:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
225:         WITH THIS.cmg_4c_Botoes
226:             .Top           = 0
227:             .Left          = 529
228:             .Width         = 273
229:             .Height        = 80
230:             .ButtonCount   = 4
231:             .BackStyle     = 0
232:             .BorderStyle   = 0
233:             .BorderColor   = RGB(136, 189, 188)
234:             .SpecialEffect = 1
235:             .Themes        = .F.
236:             .Visible       = .T.
237: 
238:             WITH .Buttons(1)
239:                 .Top             = 5
240:                 .Left            = 5
241:                 .Width           = 65
242:                 .Height          = 70
243:                 .Caption         = "Visualizar"
244:                 .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
245:                 .FontBold        = .T.
246:                 .FontItalic      = .T.
247:                 .ForeColor       = RGB(90, 90, 90)
248:                 .BackColor       = RGB(255, 255, 255)
249:                 .PicturePosition = 13
250:                 .SpecialEffect   = 0
251:                 .MousePointer    = 15
252:                 .Themes          = .F.
253:                 .WordWrap        = .T.
254:             ENDWITH
255: 
256:             WITH .Buttons(2)
257:                 .Top             = 5
258:                 .Left            = 71
259:                 .Width           = 65
260:                 .Height          = 70
261:                 .Caption         = "Imprimir"
262:                 .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
263:                 .FontName        = "Comic Sans MS"

*-- Linhas 315 a 459:
315:             ENDWITH
316:         ENDWITH
317: 
318:         *-- BINDEVENT em Buttons(N) - metodos PUBLIC obrigatorio
319:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
320:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
321:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocExcelClick")
322:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
323:     ENDPROC
324: 
325:     *==========================================================================
326:     * ATUALIZARESTADOCONTROLES - Override: relatorio nao tem estado CRUD
327:     *==========================================================================
328:     PROCEDURE AtualizarEstadoControles()
329:         RETURN
330:     ENDPROC
331: 
332:     *==========================================================================
333:     * BTNVISUALIZARCLICK - Exibe relatorio em preview na tela
334:     *==========================================================================
335:     PROCEDURE BtnVisualizarClick()
336:         THIS.FormParaRelatorio()
337:         IF !THIS.this_oRelatorio.Visualizar()
338:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao visualizar")
339:         ENDIF
340:     ENDPROC
341: 
342:     *==========================================================================
343:     * BTNIMPRIMIRCLICK - Imprime relatorio sem dialogo de impressora
344:     *==========================================================================
345:     PROCEDURE BtnImprimirClick()
346:         THIS.FormParaRelatorio()
347:         IF !THIS.this_oRelatorio.Imprimir()
348:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao imprimir")
349:         ENDIF
350:     ENDPROC
351: 
352:     *==========================================================================
353:     * BTNDOCEXCELCLICK - Imprime com selecao de impressora (dialogo)
354:     *==========================================================================
355:     PROCEDURE BtnDocExcelClick()
356:         THIS.FormParaRelatorio()
357:         IF !THIS.this_oRelatorio.ImprimirComPrompt()
358:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao imprimir")
359:         ENDIF
360:     ENDPROC
361: 
362:     *==========================================================================
363:     * BTNSAIRCLICK - Fecha o formulario (Cancel=.T. no Buttons(4) cobre ESC)
364:     *==========================================================================
365:     PROCEDURE BtnSairClick()
366:         THIS.Release()
367:     ENDPROC
368: 
369:     *==========================================================================
370:     * BTNINCLUIRCLICK - Override no-op: form REPORT nao tem operacao Incluir
371:     *==========================================================================
372:     PROCEDURE BtnIncluirClick()
373:         RETURN
374:     ENDPROC
375: 
376:     *==========================================================================
377:     * BTNALTERARCLICK - Override no-op: form REPORT nao tem operacao Alterar
378:     *==========================================================================
379:     PROCEDURE BtnAlterarClick()
380:         RETURN
381:     ENDPROC
382: 
383:     *==========================================================================
384:     * BTNEXCLUIRCLICK - Override no-op: form REPORT nao tem operacao Excluir
385:     *==========================================================================
386:     PROCEDURE BtnExcluirClick()
387:         RETURN
388:     ENDPROC
389: 
390:     *==========================================================================
391:     * ALTERNARPAGINA - Navega para a pagina solicitada no PageFrame
392:     *   Form REPORT possui PageCount=2; navega apenas se o indice for valido
393:     *   (1..PageCount). Usado pelo ciclo padrao do FormBase (BtnIncluir/Cancelar).
394:     *==========================================================================
395:     PROCEDURE AlternarPagina(par_nPagina)
396:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
397:            VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND ;
398:            par_nPagina <= THIS.pgf_4c_Paginas.PageCount
399:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
400:         ENDIF
401:     ENDPROC
402: 
403:     *==========================================================================
404:     * CONFIGURARPAGINALISTA - Monta a Page1 (lista de selecao do relatorio)
405:     *
406:     *   Em forms REPORT, a "pagina de lista" corresponde aa pagina de filtros
407:     *   contendo o grid de selecao + botoes Selecionar/Desmarcar todos.
408:     *   Equivale aa Page1/Lista de forms CRUD (carrega grid + botoes associados).
409:     *
410:     *   Coordenadas internas da Page1 = coordenadas originais - 80 (PageFrame
411:     *   inicia em Top=80, entao Top_Page1 = Top_original - 80).
412:     *
413:     *   Componentes adicionados:
414:     *     - grd_4c_Operacoes  : grid 5 colunas (M/Codigos/Descrs/E/C)
415:     *       Top original=290 -> Top_Page1=210
416:     *     - cmg_4c_GradeS     : CommandGroup 2 botoes (Sel./Des. todos)
417:     *       Top original=300 -> Top_Page1=220
418:     *==========================================================================
419:     PROTECTED PROCEDURE ConfigurarPaginaLista()
420:         LOCAL loc_oPagina, loc_oGrid
421: 
422:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
423:             RETURN
424:         ENDIF
425:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
426: 
427:         *-- ========================== GRID grd_4c_Operacoes ==========================
428:         loc_oPagina.AddObject("grd_4c_Operacoes", "Grid")
429:         loc_oGrid = loc_oPagina.grd_4c_Operacoes
430: 
431:         *-- ColumnCount ANTES de configurar colunas (cria Column1..ColumnN)
432:         loc_oGrid.ColumnCount = 5
433: 
434:         WITH loc_oGrid
435:             .Top                = 210
436:             .Left               = 439
437:             .Width              = 309
438:             .Height             = 115
439:             .DeleteMark         = .F.
440:             .RecordMark         = .F.
441:             .HighlightStyle     = 2
442:             .HighlightBackColor = RGB(255, 255, 255)
443:             .HighlightForeColor = RGB(15, 41, 104)
444:             .GridLineColor      = RGB(238, 238, 238)
445:             .FontName           = "Verdana"
446:             .FontSize           = 8
447:             .ScrollBars         = 2
448:             .RowHeight          = 16
449:         ENDWITH
450: 
451:         *-- Coluna 1: CheckBox para SelImp (selecao principal - Header "M")
452:         *-- REGRA: AddObject ANTES de CurrentControl; ControlSource DEPOIS
453:         WITH loc_oGrid.Column1
454:             .Width = 22
455:             .AddObject("Check1", "CheckBox")
456:             .Check1.Caption = ""
457:             .Check1.Value   = 0
458:             .CurrentControl = "Check1"
459:             .ControlSource  = "crOperacoes.SelImp"

*-- Linhas 509 a 604:
509:         loc_oGrid.Visible = .T.
510: 
511:         *-- KeyPress Enter(13)/Espaco(32) em Col1.Check1 -> togla SelImp
512:         BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress", THIS, "GrdOpeCheck1KeyPress")
513: 
514:         *-- ===================== COMMANDGROUP cmg_4c_GradeS ==========================
515:         *-- Botoes Sel./Des. todos (cmdBtnGradeS do original)
516:         *-- Top original=300 -> Top_Page1=220, Left=746, Width=50, Height=90
517:         loc_oPagina.AddObject("cmg_4c_GradeS", "CommandGroup")
518:         WITH loc_oPagina.cmg_4c_GradeS
519:             .Top         = 220
520:             .Left        = 746
521:             .Width       = 50
522:             .Height      = 90
523:             .ButtonCount = 2
524:             .BackStyle   = 0
525:             .BorderStyle = 0
526:             .Themes      = .F.
527:             .Visible     = .T.
528: 
529:             WITH .Buttons(1)
530:                 .Top      = 0
531:                 .Left     = 0
532:                 .Width    = 50
533:                 .Height   = 45
534:                 .Caption  = "Sel."
535:                 .Themes   = .F.
536:             ENDWITH
537: 
538:             WITH .Buttons(2)
539:                 .Top      = 45
540:                 .Left     = 0
541:                 .Width    = 50
542:                 .Height   = 45
543:                 .Caption  = "Des."
544:                 .FontName = "Tahoma"
545:                 .FontSize = 8
546:                 .Themes   = .F.
547:             ENDWITH
548:         ENDWITH
549: 
550:         BINDEVENT(loc_oPagina.cmg_4c_GradeS, "Click", THIS, "BtnGradeSClick")
551:     ENDPROC
552: 
553:     *==========================================================================
554:     * CONFIGURARPAGINADADOS - Fase 5/8: primeiros 50% dos controles de filtro
555:     *   Linha 1: Periodo (datas inicial/final + opcoes tipo periodo)
556:     *   Linha 2: Movimentacao (codigo operacao + numero pedido)
557:     *   Linha 3: Tipo de Operacao (codigo + descricao)
558:     *   Linha 4: Conta/Estoque (codigo + descricao)
559:     *   Linha 5: Vendedor (codigo + descricao)
560:     *
561:     *   Todos os controles vao em Page1 (form relatorio = layout flat).
562:     *   Coordenadas: Top_Page1 = Top_original - 80 (PageFrame.Top=80)
563:     *==========================================================================
564:     PROTECTED PROCEDURE ConfigurarPaginaDados()
565:         LOCAL loc_oPagina
566: 
567:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
568:             RETURN
569:         ENDIF
570:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
571: 
572:         *-- ===========================================================
573:         *-- LINHA 1: Periodo / Datas / Tipo de periodo
574:         *-- ===========================================================
575: 
576:         *-- Label "Periodo :" (lbl_periodo - TabIndex=1)
577:         *-- Top original=97 -> Top_Page1=17
578:         loc_oPagina.AddObject("lbl_4c_Lbl_periodo", "Label")
579:         WITH loc_oPagina.lbl_4c_Lbl_periodo
580:             .AutoSize  = .T.
581:             .Caption   = "Per" + CHR(237) + "odo :"
582:             .Left      = 47
583:             .Top       = 17
584:             .Width     = 45
585:             .FontName  = "Tahoma"
586:             .FontSize  = 8
587:             .BackStyle = 0
588:             .Visible   = .T.
589:         ENDWITH
590: 
591:         *-- TextBox data inicial (get_dt_inicial - TabIndex=2)
592:         *-- Top original=92 -> Top_Page1=12
593:         loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
594:         WITH loc_oPagina.txt_4c_DtInicial
595:             .FontName      = "Tahoma"
596:             .FontSize      = 8
597:             .Format        = "K"
598:             .Height        = 25
599:             .Left          = 94
600:             .SpecialEffect = 1
601:             .Top           = 12
602:             .Width         = 80
603:             .ForeColor     = RGB(0, 0, 0)
604:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 638 a 684:
638:             .Visible       = .T.
639:         ENDWITH
640: 
641:         *-- OptionGroup tipo de periodo (Opt_nr_periodo - TabIndex=5)
642:         *-- Top original=83 -> Top_Page1=3
643:         *-- ButtonCount=4: Lancamento / Prazo Entrega / Ult. Alteracao / Fechamento
644:         loc_oPagina.AddObject("obj_4c_OptNrPeriodo", "OptionGroup")
645:         WITH loc_oPagina.obj_4c_OptNrPeriodo
646:             .Top           = 3
647:             .Left          = 306
648:             .Width         = 200
649:             .Height        = 41
650:             .ButtonCount   = 4
651:             .BackStyle     = 0
652:             .BorderStyle   = 0
653:             .Value         = 1
654:             .SpecialEffect = 0
655:             .Themes        = .F.
656:             .Visible       = .T.
657: 
658:             WITH .Buttons(1)
659:                 .BackStyle = 0
660:                 .Caption   = "Lan" + CHR(231) + "amento"
661:                 .Value     = 1
662:                 .Height    = 15
663:                 .Left      = 5
664:                 .Top       = 5
665:                 .Width     = 76
666:                 .AutoSize  = .T.
667:                 .ForeColor = RGB(90, 90, 90)
668:             ENDWITH
669: 
670:             WITH .Buttons(2)
671:                 .FontName  = "Tahoma"
672:                 .FontSize  = 8
673:                 .BackStyle = 0
674:                 .Caption   = "Prazo Entrega"
675:                 .Value     = 0
676:                 .Left      = 100
677:                 .Top       = 5
678:                 .AutoSize  = .T.
679:                 .ForeColor = RGB(90, 90, 90)
680:             ENDWITH
681: 
682:             WITH .Buttons(3)
683:                 .FontName  = "Tahoma"
684:                 .FontSize  = 8

*-- Linhas 949 a 970:
949:             .BackStyle = 0
950:             .Visible   = .T.
951:         ENDWITH
952: 
953:         *-- TextBox cidade (Cidade - Top original=227 -> Top_Page1=147)
954:         loc_oPagina.AddObject("txt_4c_Cidade", "TextBox")
955:         WITH loc_oPagina.txt_4c_Cidade
956:             .FontName      = "Tahoma"
957:             .FontSize      = 8
958:             .Format        = "K"
959:             .Height        = 25
960:             .Left          = 94
961:             .MaxLength     = 30
962:             .SpecialEffect = 1
963:             .Top           = 147
964:             .Width         = 207
965:             .ForeColor     = RGB(0, 0, 0)
966:             .BorderColor   = RGB(100, 100, 100)
967:             .Value         = SPACE(30)
968:             .Visible       = .T.
969:         ENDWITH
970: 

*-- Linhas 980 a 1001:
980:             .BackStyle = 0
981:             .Visible   = .T.
982:         ENDWITH
983: 
984:         *-- TextBox estado (estado - Top original=227 -> Top_Page1=147)
985:         loc_oPagina.AddObject("txt_4c_Estado", "TextBox")
986:         WITH loc_oPagina.txt_4c_Estado
987:             .FontName      = "Tahoma"
988:             .FontSize      = 8
989:             .Format        = "K!"
990:             .Height        = 25
991:             .Left          = 359
992:             .MaxLength     = 2
993:             .SpecialEffect = 1
994:             .Top           = 147
995:             .Width         = 24
996:             .ForeColor     = RGB(0, 0, 0)
997:             .BorderColor   = RGB(100, 100, 100)
998:             .Value         = SPACE(2)
999:             .Visible       = .T.
1000:         ENDWITH
1001: 

*-- Linhas 1100 a 1145:
1100:             .Visible   = .T.
1101:         ENDWITH
1102: 
1103:         *-- OptionGroup situacao filtro (opt_filtro - Top original=281 -> Top_Page1=201)
1104:         *-- ButtonCount=3: Encerrados/Abertos/Ambos, Value=3 (Ambos)
1105:         loc_oPagina.AddObject("obj_4c_OptFiltro", "OptionGroup")
1106:         WITH loc_oPagina.obj_4c_OptFiltro
1107:             .Top           = 201
1108:             .Left          = 89
1109:             .Width         = 235
1110:             .Height        = 20
1111:             .ButtonCount   = 3
1112:             .BackStyle     = 0
1113:             .BorderStyle   = 0
1114:             .Value         = 3
1115:             .SpecialEffect = 0
1116:             .Themes        = .F.
1117:             .Visible       = .T.
1118: 
1119:             WITH .Buttons(1)
1120:                 .BackStyle = 0
1121:                 .Caption   = "Encerrados"
1122:                 .Height    = 15
1123:                 .Left      = 5
1124:                 .Top       = 3
1125:                 .AutoSize  = .T.
1126:                 .ForeColor = RGB(90, 90, 90)
1127:             ENDWITH
1128: 
1129:             WITH .Buttons(2)
1130:                 .FontName  = "Tahoma"
1131:                 .FontSize  = 8
1132:                 .BackStyle = 0
1133:                 .Caption   = "Abertos"
1134:                 .Height    = 15
1135:                 .Left      = 95
1136:                 .Top       = 3
1137:                 .AutoSize  = .T.
1138:                 .ForeColor = RGB(90, 90, 90)
1139:             ENDWITH
1140: 
1141:             WITH .Buttons(3)
1142:                 .FontName  = "Tahoma"
1143:                 .FontSize  = 8
1144:                 .BackStyle = 0
1145:                 .Caption   = "Ambos"

*-- Linhas 1187 a 1233:
1187:             .Visible   = .T.
1188:         ENDWITH
1189: 
1190:         *-- OptionGroup imprimir por (Opc_Imp - Top original=321 -> Top_Page1=241)
1191:         *-- ButtonCount=3: Vendedor/Cidade/Data Encerramento, Value=1
1192:         *-- Enabled=.F.: habilitado somente quando opt_filtro.Value=1 (Encerrados)
1193:         loc_oPagina.AddObject("obj_4c_OpcImp", "OptionGroup")
1194:         WITH loc_oPagina.obj_4c_OpcImp
1195:             .Top           = 241
1196:             .Left          = 89
1197:             .Width         = 288
1198:             .Height        = 25
1199:             .ButtonCount   = 3
1200:             .BackStyle     = 0
1201:             .BorderStyle   = 0
1202:             .Value         = 1
1203:             .SpecialEffect = 0
1204:             .Themes        = .F.
1205:             .Enabled       = .F.
1206:             .Visible       = .T.
1207: 
1208:             WITH .Buttons(1)
1209:                 .BackStyle = 0
1210:                 .Caption   = "Vendedor"
1211:                 .Height    = 15
1212:                 .Left      = 5
1213:                 .Top       = 5
1214:                 .AutoSize  = .T.
1215:                 .ForeColor = RGB(90, 90, 90)
1216:             ENDWITH
1217: 
1218:             WITH .Buttons(2)
1219:                 .FontName  = "Tahoma"
1220:                 .FontSize  = 8
1221:                 .BackStyle = 0
1222:                 .Caption   = "Cidade"
1223:                 .Height    = 15
1224:                 .Left      = 90
1225:                 .Top       = 5
1226:                 .AutoSize  = .T.
1227:                 .ForeColor = RGB(90, 90, 90)
1228:             ENDWITH
1229: 
1230:             WITH .Buttons(3)
1231:                 .FontName  = "Tahoma"
1232:                 .FontSize  = 8
1233:                 .BackStyle = 0

*-- Linhas 1257 a 1302:
1257:             .Visible   = .T.
1258:         ENDWITH
1259: 
1260:         *-- OptionGroup analitico/sintetico (optAnaSin - Top original=347 -> Top_Page1=267)
1261:         *-- ButtonCount=2: Analitico/Sintetico, Value=2 (Sintetico)
1262:         loc_oPagina.AddObject("obj_4c_OptAnaSin", "OptionGroup")
1263:         WITH loc_oPagina.obj_4c_OptAnaSin
1264:             .Top           = 267
1265:             .Left          = 89
1266:             .Width         = 158
1267:             .Height        = 25
1268:             .ButtonCount   = 2
1269:             .BackStyle     = 0
1270:             .BorderStyle   = 0
1271:             .Value         = 2
1272:             .SpecialEffect = 0
1273:             .Themes        = .F.
1274:             .Visible       = .T.
1275: 
1276:             WITH .Buttons(1)
1277:                 .BackStyle = 0
1278:                 .Caption   = "Anal" + CHR(237) + "tico"
1279:                 .Height    = 15
1280:                 .Left      = 5
1281:                 .Top       = 5
1282:                 .AutoSize  = .T.
1283:                 .ForeColor = RGB(90, 90, 90)
1284:             ENDWITH
1285: 
1286:             WITH .Buttons(2)
1287:                 .FontName  = "Tahoma"
1288:                 .FontSize  = 8
1289:                 .BackStyle = 0
1290:                 .Caption   = "Sint" + CHR(233) + "tico"
1291:                 .Height    = 15
1292:                 .Left      = 80
1293:                 .Top       = 5
1294:                 .AutoSize  = .T.
1295:                 .ForeColor = RGB(90, 90, 90)
1296:             ENDWITH
1297:         ENDWITH
1298: 
1299:         *-- ===========================================================
1300:         *-- LINHA 12: chkTpope / chkSemVals
1301:         *-- ===========================================================
1302: 

*-- Linhas 1352 a 1511:
1352:         ENDWITH
1353: 
1354:         *-- ===========================================================
1355:         *-- BINDEVENTS: KeyPress para lookups + InteractiveChange
1356:         *-- ===========================================================
1357: 
1358:         BINDEVENT(loc_oPagina.txt_4c_CdTpOpe,    "KeyPress",          THIS, "CdTpOpeLookupKeyPress")
1359:         BINDEVENT(loc_oPagina.txt_4c_DsTpOpe,    "KeyPress",          THIS, "DsTpOpeLookupKeyPress")
1360:         BINDEVENT(loc_oPagina.txt_4c_CdEstoque,  "KeyPress",          THIS, "CdEstoqueLookupKeyPress")
1361:         BINDEVENT(loc_oPagina.txt_4c_DsEstoque,  "KeyPress",          THIS, "DsEstoqueLookupKeyPress")
1362:         BINDEVENT(loc_oPagina.txt_4c_CdVendedor, "KeyPress",          THIS, "CdVendedorLookupKeyPress")
1363:         BINDEVENT(loc_oPagina.txt_4c_DsVendedor, "KeyPress",          THIS, "DsVendedorLookupKeyPress")
1364:         BINDEVENT(loc_oPagina.txt_4c_Estado,     "KeyPress",          THIS, "EstadoLookupKeyPress")
1365:         BINDEVENT(loc_oPagina.txt_4c_CdMoeda,    "KeyPress",          THIS, "CdMoedaLookupKeyPress")
1366:         BINDEVENT(loc_oPagina.txt_4c_DsMoeda,    "KeyPress",          THIS, "DsMoedaLookupKeyPress")
1367:         BINDEVENT(loc_oPagina.obj_4c_OptFiltro,  "InteractiveChange", THIS, "OptFiltroInteractiveChange")
1368:         BINDEVENT(loc_oPagina.chk_4c_ChkTpope,   "InteractiveChange", THIS, "ChkTpopeInteractiveChange")
1369:     ENDPROC
1370: 
1371:     *==========================================================================
1372:     * CARREGAROPERACOES - Carrega tipos de operacao de SigCdTom no crOperacoes
1373:     * Equivalente a logica SQL do Init() original do SIGREESP
1374:     * Inicializa SelImp=.T., SelImp2=.T., SelImp3=.F. para todos os registros
1375:     *==========================================================================
1376:     PROCEDURE CarregarOperacoes()
1377:         LOCAL loc_cSQL, loc_nResult, loc_nCodigos, loc_cDescrs
1378:         loc_cSQL = "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos"
1379: 
1380:         TRY
1381:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
1382:             IF loc_nResult > 0
1383:                 SELECT crOperacoes
1384:                 ZAP
1385:                 SELECT cursor_4c_TmpOpe
1386:                 SCAN
1387:                     loc_nCodigos = cursor_4c_TmpOpe.Codigos
1388:                     loc_cDescrs  = ALLTRIM(cursor_4c_TmpOpe.Descrs)
1389:                     SELECT crOperacoes
1390:                     APPEND BLANK
1391:                     REPLACE SelImp  WITH .T., ;
1392:                             SelImp2 WITH .T., ;
1393:                             SelImp3 WITH .F., ;
1394:                             Codigos WITH loc_nCodigos, ;
1395:                             Descrs  WITH loc_cDescrs
1396:                     SELECT cursor_4c_TmpOpe
1397:                 ENDSCAN
1398:                 IF USED("cursor_4c_TmpOpe")
1399:                     USE IN cursor_4c_TmpOpe
1400:                 ENDIF
1401:                 SELECT crOperacoes
1402:                 GO TOP
1403:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
1404:                    VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes) = "O"
1405:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1406:                 ENDIF
1407:             ENDIF
1408:         CATCH TO loc_oErro
1409:             MsgErro(loc_oErro.Message, "CarregarOperacoes")
1410:         ENDTRY
1411:     ENDPROC
1412: 
1413:     *==========================================================================
1414:     * BTNGRADESCLICK - Seleciona ou desmarca todos os tipos de operacao
1415:     *   Value=1 -> marca todos (SelImp=.T., SelImp2=.T.)
1416:     *   Value=2 -> desmarca todos (SelImp=.F., SelImp2=.F.)
1417:     *   Logica identica ao cmdBtnGradeS.Click original.
1418:     *==========================================================================
1419:     PROCEDURE BtnGradeSClick()
1420:         LOCAL loc_lMarcar, loc_oGrid
1421:         loc_lMarcar = (THIS.pgf_4c_Paginas.Page1.cmg_4c_GradeS.Value = 1)
1422:         IF USED("crOperacoes")
1423:             UPDATE crOperacoes SET SelImp = loc_lMarcar, SelImp2 = loc_lMarcar
1424:             GO TOP IN crOperacoes
1425:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes
1426:             IF VARTYPE(loc_oGrid) = "O"
1427:                 loc_oGrid.Refresh()
1428:             ENDIF
1429:         ENDIF
1430:     ENDPROC
1431: 
1432:     *==========================================================================
1433:     * GRDOPECHECK1KEYPRESS - Togla SelImp via teclado (Enter=13, Espaco=32)
1434:     * Equivalente ao KeyPress do Check1 da Column1 do grdOperacoes original
1435:     *==========================================================================
1436:     PROCEDURE GrdOpeCheck1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1437:         LOCAL loc_oGrid
1438:         IF INLIST(par_nKeyCode, 13, 32)
1439:             IF USED("crOperacoes") AND !EOF("crOperacoes")
1440:                 SELECT crOperacoes
1441:                 REPLACE SelImp WITH !crOperacoes.SelImp
1442:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
1443:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes
1444:                     IF VARTYPE(loc_oGrid) = "O"
1445:                         loc_oGrid.Refresh()
1446:                     ENDIF
1447:                 ENDIF
1448:             ENDIF
1449:             NODEFAULT
1450:         ENDIF
1451:     ENDPROC
1452: 
1453:     *==========================================================================
1454:     * DESTROY - Limpeza de recursos
1455:     * NAO usar .Release() em BO Custom - apenas .NULL.
1456:     *==========================================================================
1457:     PROCEDURE Destroy()
1458:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1459:             THIS.this_oRelatorio = .NULL.
1460:         ENDIF
1461:         IF USED("crOperacoes")
1462:             USE IN crOperacoes
1463:         ENDIF
1464:         DODEFAULT()
1465:     ENDPROC
1466: 
1467:     *==========================================================================
1468:     * FORMPARARELATORIO - Transfere controles da tela para o BO do relatorio
1469:     * Chamado por BtnVisualizarClick, BtnImprimirClick, BtnDocExcelClick
1470:     *==========================================================================
1471:     PROCEDURE FormParaRelatorio()
1472:         LOCAL loc_oPag, loc_cTpOpeM, loc_cTpOpeE, loc_cTpOpeC
1473:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1474:             RETURN
1475:         ENDIF
1476:         loc_oPag     = THIS.pgf_4c_Paginas.Page1
1477:         loc_cTpOpeM  = ""
1478:         loc_cTpOpeE  = ""
1479:         loc_cTpOpeC  = ""
1480:         TRY
1481:             WITH THIS.this_oRelatorio
1482:                 .this_dDtInicial  = loc_oPag.txt_4c_DtInicial.Value
1483:                 .this_dDtFinal    = loc_oPag.txt_4c_DtFinal.Value
1484:                 .this_nPeriodo    = loc_oPag.obj_4c_OptNrPeriodo.Value
1485:                 .this_cNmOperacao = ALLTRIM(loc_oPag.txt_4c__nm_operacao.Value)
1486:                 .this_nNumero     = loc_oPag.txt_4c_Numero.Value
1487:                 .this_nCdTpOpe    = loc_oPag.txt_4c_CdTpOpe.Value
1488:                 .this_cDsTpOpe    = ALLTRIM(loc_oPag.txt_4c_DsTpOpe.Value)
1489:                 .this_cCdConta    = ALLTRIM(loc_oPag.txt_4c_CdEstoque.Value)
1490:                 .this_cDsConta    = ALLTRIM(loc_oPag.txt_4c_DsEstoque.Value)
1491:                 .this_cCdVendedor = ALLTRIM(loc_oPag.txt_4c_CdVendedor.Value)
1492:                 .this_cDsVendedor = ALLTRIM(loc_oPag.txt_4c_DsVendedor.Value)
1493:                 .this_cCidade     = ALLTRIM(loc_oPag.txt_4c_Cidade.Value)
1494:                 .this_cEstado     = ALLTRIM(loc_oPag.txt_4c_Estado.Value)
1495:                 .this_nFiltro     = loc_oPag.obj_4c_OptFiltro.Value
1496:                 .this_nOpcImp     = loc_oPag.obj_4c_OpcImp.Value
1497:                 .this_nOrdem      = loc_oPag.cbo_4c_Ordem1.ListIndex
1498:                 .this_nAnaSin     = loc_oPag.obj_4c_OptAnaSin.Value
1499:                 .this_lTpOpe      = (loc_oPag.chk_4c_ChkTpope.Value = 1)
1500:                 .this_lItens      = (loc_oPag.chk_4c_ChkItens.Value = 1)
1501:                 .this_lIndus      = (loc_oPag.chk_4c_ChkIndus.Value = 1)
1502:                 .this_lSemVals    = (loc_oPag.chk_4c_ChkSemVals.Value = 1)
1503:                 .this_cCdMoeda    = ALLTRIM(loc_oPag.txt_4c_CdMoeda.Value)
1504:                 .this_cDsMoeda    = ALLTRIM(loc_oPag.txt_4c_DsMoeda.Value)
1505:             ENDWITH
1506:             IF USED("crOperacoes")
1507:                 SELECT crOperacoes
1508:                 GO TOP
1509:                 SCAN
1510:                     IF crOperacoes.SelImp
1511:                         loc_cTpOpeM = loc_cTpOpeM + IIF(EMPTY(loc_cTpOpeM),"",",") + ALLTRIM(STR(crOperacoes.Codigos))

*-- Linhas 1529 a 2208:
1529:     *==========================================================================
1530:     * LIMPARCAMPOS - Restaura todos os filtros aos valores padrao
1531:     *==========================================================================
1532:     PROCEDURE LimparCampos()
1533:         LOCAL loc_oPag
1534:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1535:             RETURN
1536:         ENDIF
1537:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1538:         TRY
1539:             loc_oPag.txt_4c_DtInicial.Value        = DATE()
1540:             loc_oPag.txt_4c_DtFinal.Value          = DATE()
1541:             loc_oPag.obj_4c_OptNrPeriodo.Value     = 1
1542:             loc_oPag.txt_4c__nm_operacao.Value     = SPACE(20)
1543:             loc_oPag.txt_4c_Numero.Value           = 0
1544:             loc_oPag.txt_4c_CdTpOpe.Value          = 0
1545:             loc_oPag.txt_4c_DsTpOpe.Value          = "TODOS"
1546:             loc_oPag.txt_4c_CdEstoque.Value        = SPACE(10)
1547:             loc_oPag.txt_4c_DsEstoque.Value        = SPACE(40)
1548:             loc_oPag.txt_4c_CdVendedor.Value       = SPACE(10)
1549:             loc_oPag.txt_4c_DsVendedor.Value       = SPACE(40)
1550:             loc_oPag.txt_4c_Cidade.Value           = SPACE(30)
1551:             loc_oPag.txt_4c_Estado.Value           = SPACE(2)
1552:             loc_oPag.cbo_4c_Ordem1.Value           = "Cliente"
1553:             loc_oPag.txt_4c_CdMoeda.Value          = SPACE(3)
1554:             loc_oPag.txt_4c_DsMoeda.Value          = SPACE(15)
1555:             loc_oPag.obj_4c_OptFiltro.Value        = 3
1556:             loc_oPag.obj_4c_OpcImp.Enabled         = .F.
1557:             loc_oPag.obj_4c_OpcImp.Value           = 1
1558:             loc_oPag.obj_4c_OptAnaSin.Value        = 2
1559:             loc_oPag.chk_4c_ChkItens.Value         = 0
1560:             loc_oPag.chk_4c_ChkTpope.Value         = 0
1561:             loc_oPag.chk_4c_ChkSemVals.Value       = 0
1562:             loc_oPag.chk_4c_ChkSemVals.Enabled     = .F.
1563:             loc_oPag.chk_4c_ChkIndus.Value         = 0
1564:         CATCH TO loc_oErro
1565:             MsgErro(loc_oErro.Message, "LimparCampos")
1566:         ENDTRY
1567:     ENDPROC
1568: 
1569:     *==========================================================================
1570:     * OPTFILTROINTERACTIVECHANGE - Controla estado de OpcImp e ChkItens
1571:     *   Value=1 (Encerrados): habilita OpcImp, zera ChkItens
1572:     *   Value=2/3: desabilita OpcImp
1573:     *==========================================================================
1574:     PROCEDURE OptFiltroInteractiveChange()
1575:         LOCAL loc_oPag, loc_lEncerrados
1576:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1577:             RETURN
1578:         ENDIF
1579:         loc_oPag        = THIS.pgf_4c_Paginas.Page1
1580:         loc_lEncerrados = (loc_oPag.obj_4c_OptFiltro.Value = 1)
1581:         loc_oPag.obj_4c_OpcImp.Enabled = loc_lEncerrados
1582:         IF loc_lEncerrados
1583:             loc_oPag.chk_4c_ChkItens.Value = 0
1584:         ENDIF
1585:     ENDPROC
1586: 
1587:     *==========================================================================
1588:     * CHKTPOPEINTERACTIVECHANGE - Controla estado de ChkSemVals
1589:     *   Value=1: habilita ChkSemVals
1590:     *   Value=0: desabilita e zera ChkSemVals
1591:     *==========================================================================
1592:     PROCEDURE ChkTpopeInteractiveChange()
1593:         LOCAL loc_oPag
1594:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1595:             RETURN
1596:         ENDIF
1597:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1598:         IF loc_oPag.chk_4c_ChkTpope.Value = 1
1599:             loc_oPag.chk_4c_ChkSemVals.Enabled = .T.
1600:         ELSE
1601:             loc_oPag.chk_4c_ChkSemVals.Value   = 0
1602:             loc_oPag.chk_4c_ChkSemVals.Enabled = .F.
1603:         ENDIF
1604:     ENDPROC
1605: 
1606:     *==========================================================================
1607:     * HANDLERS KEYPRESS - F4/F5 dispara lookup nos campos de filtro
1608:     *==========================================================================
1609:     PROCEDURE CdTpOpeLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1610:         IF INLIST(par_nKeyCode, 115, 116)
1611:             THIS.AbrirLookupTpOpePorCodigo()
1612:         ENDIF
1613:     ENDPROC
1614: 
1615:     PROCEDURE DsTpOpeLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1616:         IF INLIST(par_nKeyCode, 115, 116)
1617:             THIS.AbrirLookupTpOpePorDescricao()
1618:         ENDIF
1619:     ENDPROC
1620: 
1621:     PROCEDURE CdEstoqueLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1622:         IF INLIST(par_nKeyCode, 115, 116)
1623:             THIS.AbrirLookupEstoquePorCodigo()
1624:         ENDIF
1625:     ENDPROC
1626: 
1627:     PROCEDURE DsEstoqueLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1628:         IF INLIST(par_nKeyCode, 115, 116)
1629:             THIS.AbrirLookupEstoquePorDescricao()
1630:         ENDIF
1631:     ENDPROC
1632: 
1633:     PROCEDURE CdVendedorLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1634:         IF INLIST(par_nKeyCode, 115, 116)
1635:             THIS.AbrirLookupVendedorPorCodigo()
1636:         ENDIF
1637:     ENDPROC
1638: 
1639:     PROCEDURE DsVendedorLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1640:         IF INLIST(par_nKeyCode, 115, 116)
1641:             THIS.AbrirLookupVendedorPorDescricao()
1642:         ENDIF
1643:     ENDPROC
1644: 
1645:     PROCEDURE EstadoLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1646:         IF INLIST(par_nKeyCode, 115, 116)
1647:             THIS.AbrirLookupEstado()
1648:         ENDIF
1649:     ENDPROC
1650: 
1651:     PROCEDURE CdMoedaLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1652:         IF INLIST(par_nKeyCode, 115, 116)
1653:             THIS.AbrirLookupMoedaPorCodigo()
1654:         ENDIF
1655:     ENDPROC
1656: 
1657:     PROCEDURE DsMoedaLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1658:         IF INLIST(par_nKeyCode, 115, 116)
1659:             THIS.AbrirLookupMoedaPorDescricao()
1660:         ENDIF
1661:     ENDPROC
1662: 
1663:     *==========================================================================
1664:     * LOOKUPS TIPO DE OPERACAO (SigCdTom: Codigos, Descrs)
1665:     *==========================================================================
1666:     PROCEDURE AbrirLookupTpOpePorCodigo()
1667:         LOCAL loc_oBusca, loc_cValor
1668:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1669:             RETURN
1670:         ENDIF
1671:         loc_cValor = ALLTRIM(STR(THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value))
1672:         TRY
1673:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1674:                 "SigCdTom", "cursor_4c_BuscaTpOpe", "Codigos", loc_cValor, ;
1675:                 "Tipo de Opera" + CHR(231) + CHR(227) + "o")
1676:             IF VARTYPE(loc_oBusca) = "O"
1677:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1678:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = cursor_4c_BuscaTpOpe.Codigos
1679:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_BuscaTpOpe.Descrs)
1680:                 ELSE
1681:                     IF !loc_oBusca.this_lAchouRegistro
1682:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1683:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1684:                     loc_oBusca.Show()
1685:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpOpe")
1686:                         THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = cursor_4c_BuscaTpOpe.Codigos
1687:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_BuscaTpOpe.Descrs)
1688:                     ENDIF
1689:                     ENDIF
1690:                 ENDIF
1691:                 loc_oBusca.Release()
1692:             ENDIF
1693:         CATCH TO loc_oErro
1694:             MsgErro(loc_oErro.Message, "AbrirLookupTpOpePorCodigo")
1695:         ENDTRY
1696:         IF USED("cursor_4c_BuscaTpOpe")
1697:             USE IN cursor_4c_BuscaTpOpe
1698:         ENDIF
1699:     ENDPROC
1700: 
1701:     PROCEDURE AbrirLookupTpOpePorDescricao()
1702:         LOCAL loc_oBusca, loc_cValor
1703:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1704:             RETURN
1705:         ENDIF
1706:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value)
1707:         IF loc_cValor = "TODOS"
1708:             loc_cValor = ""
1709:         ENDIF
1710:         TRY
1711:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1712:                 "SigCdTom", "cursor_4c_BuscaTpOpe", "Descrs", loc_cValor, ;
1713:                 "Tipo de Opera" + CHR(231) + CHR(227) + "o")
1714:             IF VARTYPE(loc_oBusca) = "O"
1715:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1716:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = cursor_4c_BuscaTpOpe.Codigos
1717:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_BuscaTpOpe.Descrs)
1718:                 ELSE
1719:                     IF !loc_oBusca.this_lAchouRegistro
1720:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1721:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1722:                     loc_oBusca.Show()
1723:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpOpe")
1724:                         THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = cursor_4c_BuscaTpOpe.Codigos
1725:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_BuscaTpOpe.Descrs)
1726:                     ENDIF
1727:                     ENDIF
1728:                 ENDIF
1729:                 loc_oBusca.Release()
1730:             ENDIF
1731:         CATCH TO loc_oErro
1732:             MsgErro(loc_oErro.Message, "AbrirLookupTpOpePorDescricao")
1733:         ENDTRY
1734:         IF USED("cursor_4c_BuscaTpOpe")
1735:             USE IN cursor_4c_BuscaTpOpe
1736:         ENDIF
1737:     ENDPROC
1738: 
1739:     PROCEDURE ValidarTpOpeCodigo()
1740:         LOCAL loc_cSQL, loc_nRes, loc_nCod
1741:         loc_nCod = THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value
1742:         IF loc_nCod = 0
1743:             THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = "TODOS"
1744:             RETURN
1745:         ENDIF
1746:         TRY
1747:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdTom WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)
1748:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValTpOpe")
1749:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValTpOpe") = 1
1750:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_ValTpOpe.Descrs)
1751:             ELSE
1752:                 MsgAviso("C" + CHR(243) + "digo de tipo n" + CHR(227) + "o encontrado.")
1753:                 THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = 0
1754:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = "TODOS"
1755:                 THIS.AbrirLookupTpOpePorCodigo()
1756:             ENDIF
1757:         CATCH TO loc_oErro
1758:             MsgErro(loc_oErro.Message, "ValidarTpOpeCodigo")
1759:         ENDTRY
1760:         IF USED("cursor_4c_ValTpOpe")
1761:             USE IN cursor_4c_ValTpOpe
1762:         ENDIF
1763:     ENDPROC
1764: 
1765:     *==========================================================================
1766:     * LOOKUPS CONTA/ESTOQUE (SigCdCli: iclis, nomes)
1767:     *==========================================================================
1768:     PROCEDURE AbrirLookupEstoquePorCodigo()
1769:         LOCAL loc_oBusca, loc_cValor
1770:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1771:             RETURN
1772:         ENDIF
1773:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value)
1774:         TRY
1775:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1776:                 "SigCdCli", "cursor_4c_BuscaEstoque", "iclis", loc_cValor, ;
1777:                 "Conta/Estoque")
1778:             IF VARTYPE(loc_oBusca) = "O"
1779:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1780:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
1781:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.nomes)
1782:                 ELSE
1783:                     IF !loc_oBusca.this_lAchouRegistro
1784:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1785:                     loc_oBusca.mAddColuna("nomes", "", "Nome")
1786:                     loc_oBusca.Show()
1787:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEstoque")
1788:                         THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
1789:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.nomes)
1790:                     ENDIF
1791:                     ENDIF
1792:                 ENDIF
1793:                 loc_oBusca.Release()
1794:             ENDIF
1795:         CATCH TO loc_oErro
1796:             MsgErro(loc_oErro.Message, "AbrirLookupEstoquePorCodigo")
1797:         ENDTRY
1798:         IF USED("cursor_4c_BuscaEstoque")
1799:             USE IN cursor_4c_BuscaEstoque
1800:         ENDIF
1801:     ENDPROC
1802: 
1803:     PROCEDURE AbrirLookupEstoquePorDescricao()
1804:         LOCAL loc_oBusca, loc_cValor
1805:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1806:             RETURN
1807:         ENDIF
1808:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value)
1809:         TRY
1810:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1811:                 "SigCdCli", "cursor_4c_BuscaEstoque", "nomes", loc_cValor, ;
1812:                 "Conta/Estoque")
1813:             IF VARTYPE(loc_oBusca) = "O"
1814:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1815:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
1816:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.nomes)
1817:                 ELSE
1818:                     IF !loc_oBusca.this_lAchouRegistro
1819:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1820:                     loc_oBusca.mAddColuna("nomes", "", "Nome")
1821:                     loc_oBusca.Show()
1822:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEstoque")
1823:                         THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
1824:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.nomes)
1825:                     ENDIF
1826:                     ENDIF
1827:                 ENDIF
1828:                 loc_oBusca.Release()
1829:             ENDIF
1830:         CATCH TO loc_oErro
1831:             MsgErro(loc_oErro.Message, "AbrirLookupEstoquePorDescricao")
1832:         ENDTRY
1833:         IF USED("cursor_4c_BuscaEstoque")
1834:             USE IN cursor_4c_BuscaEstoque
1835:         ENDIF
1836:     ENDPROC
1837: 
1838:     PROCEDURE ValidarEstoqueCodigo()
1839:         LOCAL loc_cSQL, loc_nRes, loc_cCod
1840:         loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value)
1841:         IF EMPTY(loc_cCod)
1842:             THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = SPACE(40)
1843:             RETURN
1844:         ENDIF
1845:         TRY
1846:             loc_cSQL = "SELECT iclis, nomes FROM SigCdCli WHERE CAST(iclis AS VARCHAR(20)) = " + EscaparSQL(loc_cCod)
1847:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValEstoque")
1848:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValEstoque") = 1
1849:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_ValEstoque.nomes)
1850:             ELSE
1851:                 MsgAviso("C" + CHR(243) + "digo de conta n" + CHR(227) + "o encontrado.")
1852:                 THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = SPACE(10)
1853:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = SPACE(40)
1854:                 THIS.AbrirLookupEstoquePorCodigo()
1855:             ENDIF
1856:         CATCH TO loc_oErro
1857:             MsgErro(loc_oErro.Message, "ValidarEstoqueCodigo")
1858:         ENDTRY
1859:         IF USED("cursor_4c_ValEstoque")
1860:             USE IN cursor_4c_ValEstoque
1861:         ENDIF
1862:     ENDPROC
1863: 
1864:     *==========================================================================
1865:     * LOOKUPS VENDEDOR (SigCdCli: iclis, nomes)
1866:     *==========================================================================
1867:     PROCEDURE AbrirLookupVendedorPorCodigo()
1868:         LOCAL loc_oBusca, loc_cValor
1869:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1870:             RETURN
1871:         ENDIF
1872:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value)
1873:         TRY
1874:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1875:                 "SigCdCli", "cursor_4c_BuscaVendedor", "iclis", loc_cValor, ;
1876:                 "Vendedor")
1877:             IF VARTYPE(loc_oBusca) = "O"
1878:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1879:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.iclis)
1880:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.nomes)
1881:                 ELSE
1882:                     IF !loc_oBusca.this_lAchouRegistro
1883:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1884:                     loc_oBusca.mAddColuna("nomes", "", "Nome")
1885:                     loc_oBusca.Show()
1886:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVendedor")
1887:                         THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.iclis)
1888:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.nomes)
1889:                     ENDIF
1890:                     ENDIF
1891:                 ENDIF
1892:                 loc_oBusca.Release()
1893:             ENDIF
1894:         CATCH TO loc_oErro
1895:             MsgErro(loc_oErro.Message, "AbrirLookupVendedorPorCodigo")
1896:         ENDTRY
1897:         IF USED("cursor_4c_BuscaVendedor")
1898:             USE IN cursor_4c_BuscaVendedor
1899:         ENDIF
1900:     ENDPROC
1901: 
1902:     PROCEDURE AbrirLookupVendedorPorDescricao()
1903:         LOCAL loc_oBusca, loc_cValor
1904:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1905:             RETURN
1906:         ENDIF
1907:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value)
1908:         TRY
1909:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1910:                 "SigCdCli", "cursor_4c_BuscaVendedor", "nomes", loc_cValor, ;
1911:                 "Vendedor")
1912:             IF VARTYPE(loc_oBusca) = "O"
1913:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1914:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.iclis)
1915:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.nomes)
1916:                 ELSE
1917:                     IF !loc_oBusca.this_lAchouRegistro
1918:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1919:                     loc_oBusca.mAddColuna("nomes", "", "Nome")
1920:                     loc_oBusca.Show()
1921:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVendedor")
1922:                         THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.iclis)
1923:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.nomes)
1924:                     ENDIF
1925:                     ENDIF
1926:                 ENDIF
1927:                 loc_oBusca.Release()
1928:             ENDIF
1929:         CATCH TO loc_oErro
1930:             MsgErro(loc_oErro.Message, "AbrirLookupVendedorPorDescricao")
1931:         ENDTRY
1932:         IF USED("cursor_4c_BuscaVendedor")
1933:             USE IN cursor_4c_BuscaVendedor
1934:         ENDIF
1935:     ENDPROC
1936: 
1937:     PROCEDURE ValidarVendedorCodigo()
1938:         LOCAL loc_cSQL, loc_nRes, loc_cCod
1939:         loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value)
1940:         IF EMPTY(loc_cCod)
1941:             THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = SPACE(40)
1942:             RETURN
1943:         ENDIF
1944:         TRY
1945:             loc_cSQL = "SELECT iclis, nomes FROM SigCdCli WHERE CAST(iclis AS VARCHAR(20)) = " + EscaparSQL(loc_cCod)
1946:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValVendedor")
1947:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValVendedor") = 1
1948:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_ValVendedor.nomes)
1949:             ELSE
1950:                 MsgAviso("C" + CHR(243) + "digo de vendedor n" + CHR(227) + "o encontrado.")
1951:                 THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = SPACE(10)
1952:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = SPACE(40)
1953:                 THIS.AbrirLookupVendedorPorCodigo()
1954:             ENDIF
1955:         CATCH TO loc_oErro
1956:             MsgErro(loc_oErro.Message, "ValidarVendedorCodigo")
1957:         ENDTRY
1958:         IF USED("cursor_4c_ValVendedor")
1959:             USE IN cursor_4c_ValVendedor
1960:         ENDIF
1961:     ENDPROC
1962: 
1963:     *==========================================================================
1964:     * LOOKUP ESTADO (SigCdUfs: Estados)
1965:     *==========================================================================
1966:     PROCEDURE AbrirLookupEstado()
1967:         LOCAL loc_oBusca, loc_cValor
1968:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1969:             RETURN
1970:         ENDIF
1971:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Estado.Value)
1972:         TRY
1973:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1974:                 "SigCdUfs", "cursor_4c_BuscaEstado", "Estados", loc_cValor, ;
1975:                 "Estado (UF)")
1976:             IF VARTYPE(loc_oBusca) = "O"
1977:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1978:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Estado.Value = ALLTRIM(cursor_4c_BuscaEstado.Estados)
1979:                 ELSE
1980:                     IF !loc_oBusca.this_lAchouRegistro
1981:                     loc_oBusca.mAddColuna("Estados", "", "UF")
1982:                     loc_oBusca.Show()
1983:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEstado")
1984:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Estado.Value = ALLTRIM(cursor_4c_BuscaEstado.Estados)
1985:                     ENDIF
1986:                     ENDIF
1987:                 ENDIF
1988:                 loc_oBusca.Release()
1989:             ENDIF
1990:         CATCH TO loc_oErro
1991:             MsgErro(loc_oErro.Message, "AbrirLookupEstado")
1992:         ENDTRY
1993:         IF USED("cursor_4c_BuscaEstado")
1994:             USE IN cursor_4c_BuscaEstado
1995:         ENDIF
1996:     ENDPROC
1997: 
1998:     *==========================================================================
1999:     * LOOKUPS MOEDA (SigCdMoe: cmoes, dmoes)
2000:     *==========================================================================
2001:     PROCEDURE AbrirLookupMoedaPorCodigo()
2002:         LOCAL loc_oBusca, loc_cValor
2003:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
2004:             RETURN
2005:         ENDIF
2006:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value)
2007:         TRY
2008:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2009:                 "SigCdMoe", "cursor_4c_BuscaMoeda", "cmoes", loc_cValor, ;
2010:                 "Moeda")
2011:             IF VARTYPE(loc_oBusca) = "O"
2012:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2013:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
2014:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
2015:                 ELSE
2016:                     IF !loc_oBusca.this_lAchouRegistro
2017:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
2018:                     loc_oBusca.mAddColuna("dmoes", "", "Moeda")
2019:                     loc_oBusca.Show()
2020:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
2021:                         THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
2022:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
2023:                     ENDIF
2024:                     ENDIF
2025:                 ENDIF
2026:                 loc_oBusca.Release()
2027:             ENDIF
2028:         CATCH TO loc_oErro
2029:             MsgErro(loc_oErro.Message, "AbrirLookupMoedaPorCodigo")
2030:         ENDTRY
2031:         IF USED("cursor_4c_BuscaMoeda")
2032:             USE IN cursor_4c_BuscaMoeda
2033:         ENDIF
2034:     ENDPROC
2035: 
2036:     PROCEDURE AbrirLookupMoedaPorDescricao()
2037:         LOCAL loc_oBusca, loc_cValor
2038:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
2039:             RETURN
2040:         ENDIF
2041:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value)
2042:         TRY
2043:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2044:                 "SigCdMoe", "cursor_4c_BuscaMoeda", "dmoes", loc_cValor, ;
2045:                 "Moeda")
2046:             IF VARTYPE(loc_oBusca) = "O"
2047:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2048:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
2049:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
2050:                 ELSE
2051:                     IF !loc_oBusca.this_lAchouRegistro
2052:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
2053:                     loc_oBusca.mAddColuna("dmoes", "", "Moeda")
2054:                     loc_oBusca.Show()
2055:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
2056:                         THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
2057:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
2058:                     ENDIF
2059:                     ENDIF
2060:                 ENDIF
2061:                 loc_oBusca.Release()
2062:             ENDIF
2063:         CATCH TO loc_oErro
2064:             MsgErro(loc_oErro.Message, "AbrirLookupMoedaPorDescricao")
2065:         ENDTRY
2066:         IF USED("cursor_4c_BuscaMoeda")
2067:             USE IN cursor_4c_BuscaMoeda
2068:         ENDIF
2069:     ENDPROC
2070: 
2071:     PROCEDURE ValidarMoedaCodigo()
2072:         LOCAL loc_cSQL, loc_nRes, loc_cCod
2073:         loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value)
2074:         IF EMPTY(loc_cCod)
2075:             THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = SPACE(15)
2076:             RETURN
2077:         ENDIF
2078:         TRY
2079:             loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE CAST(cmoes AS VARCHAR(10)) = " + EscaparSQL(loc_cCod)
2080:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValMoeda")
2081:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValMoeda") = 1
2082:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_ValMoeda.dmoes)
2083:             ELSE
2084:                 MsgAviso("C" + CHR(243) + "digo de moeda n" + CHR(227) + "o encontrado.")
2085:                 THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = SPACE(3)
2086:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = SPACE(15)
2087:                 THIS.AbrirLookupMoedaPorCodigo()
2088:             ENDIF
2089:         CATCH TO loc_oErro
2090:             MsgErro(loc_oErro.Message, "ValidarMoedaCodigo")
2091:         ENDTRY
2092:         IF USED("cursor_4c_ValMoeda")
2093:             USE IN cursor_4c_ValMoeda
2094:         ENDIF
2095:     ENDPROC
2096: 
2097:     *==========================================================================
2098:     * BTNBUSCARCLICK - Override no-op: form REPORT nao tem operacao Buscar CRUD
2099:     *   FormBase pode chamar este metodo; aqui nao faz nada.
2100:     *==========================================================================
2101:     PROCEDURE BtnBuscarClick()
2102:         RETURN
2103:     ENDPROC
2104: 
2105:     *==========================================================================
2106:     * BTNENCERRARCLICK - Fecha o formulario de relatorio
2107:     *==========================================================================
2108:     PROCEDURE BtnEncerrarClick()
2109:         THIS.Release()
2110:     ENDPROC
2111: 
2112:     *==========================================================================
2113:     * BTNSALVARCLICK - Override no-op: form REPORT nao salva registros CRUD
2114:     *==========================================================================
2115:     PROCEDURE BtnSalvarClick()
2116:         RETURN
2117:     ENDPROC
2118: 
2119:     *==========================================================================
2120:     * BTNCANCELARCLICK - Override no-op: form REPORT nao tem cancelar CRUD
2121:     *   Para relatorio, cancela equivale a limpar os filtros.
2122:     *==========================================================================
2123:     PROCEDURE BtnCancelarClick()
2124:         THIS.LimparCampos()
2125:     ENDPROC
2126: 
2127:     *==========================================================================
2128:     * FORMPARA BO - Alias para FormParaRelatorio (compatibilidade com FormBase)
2129:     *   FormBase pode chamar FormParaBO(); para relatorios isso equivale a
2130:     *   transferir os filtros da tela para o BO do relatorio.
2131:     *==========================================================================
2132:     PROTECTED PROCEDURE FormParaBO()
2133:         THIS.FormParaRelatorio()
2134:     ENDPROC
2135: 
2136:     *==========================================================================
2137:     * BOPARAFORM - Nao aplicavel para relatorios (dados fluem Form -> BO)
2138:     *   Override para evitar chamada de metodo inexistente em FormBase.
2139:     *==========================================================================
2140:     PROTECTED PROCEDURE BOParaForm()
2141:         RETURN
2142:     ENDPROC
2143: 
2144:     *==========================================================================
2145:     * HABILITARCAMPOS - Habilita/desabilita controles de filtro
2146:     *   Em formulario REPORT todos os campos de filtro ficam sempre habilitados.
2147:     *   O unico controle com habilitacao condicional e obj_4c_OpcImp (controlado
2148:     *   pelo OptFiltroInteractiveChange) e chk_4c_ChkSemVals (pelo ChkTpope).
2149:     *   Este metodo garante que os controles principais estejam habilitados.
2150:     *==========================================================================
2151:     PROCEDURE HabilitarCampos()
2152:         LOCAL loc_oPag
2153:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
2154:             RETURN
2155:         ENDIF
2156:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2157:         TRY
2158:             loc_oPag.txt_4c_DtInicial.Enabled        = .T.
2159:             loc_oPag.txt_4c_DtFinal.Enabled          = .T.
2160:             loc_oPag.obj_4c_OptNrPeriodo.Enabled     = .T.
2161:             loc_oPag.txt_4c__nm_operacao.Enabled     = .T.
2162:             loc_oPag.txt_4c_Numero.Enabled           = .T.
2163:             loc_oPag.txt_4c_CdTpOpe.Enabled         = .T.
2164:             loc_oPag.txt_4c_DsTpOpe.Enabled         = .T.
2165:             loc_oPag.txt_4c_CdEstoque.Enabled       = .T.
2166:             loc_oPag.txt_4c_DsEstoque.Enabled       = .T.
2167:             loc_oPag.txt_4c_CdVendedor.Enabled      = .T.
2168:             loc_oPag.txt_4c_DsVendedor.Enabled      = .T.
2169:             loc_oPag.txt_4c_Cidade.Enabled          = .T.
2170:             loc_oPag.txt_4c_Estado.Enabled          = .T.
2171:             loc_oPag.cbo_4c_Ordem1.Enabled          = .T.
2172:             loc_oPag.txt_4c_CdMoeda.Enabled         = .T.
2173:             loc_oPag.txt_4c_DsMoeda.Enabled         = .T.
2174:             loc_oPag.obj_4c_OptFiltro.Enabled       = .T.
2175:             loc_oPag.obj_4c_OptAnaSin.Enabled       = .T.
2176:             loc_oPag.chk_4c_ChkItens.Enabled        = .T.
2177:             loc_oPag.chk_4c_ChkTpope.Enabled        = .T.
2178:             loc_oPag.chk_4c_ChkIndus.Enabled        = .T.
2179:             loc_oPag.grd_4c_Operacoes.Enabled       = .T.
2180:             loc_oPag.cmg_4c_GradeS.Enabled          = .T.
2181:         CATCH TO loc_oErro
2182:             MsgErro(loc_oErro.Message, "HabilitarCampos")
2183:         ENDTRY
2184:     ENDPROC
2185: 
2186:     *==========================================================================
2187:     * CARREGARLISTA - Recarrega a lista de tipos de operacao no grid
2188:     *   Em formulario REPORT "lista" equivale ao grid de selecao de operacoes.
2189:     *   Chamado pelo FormBase quando necessario recarregar dados.
2190:     *==========================================================================
2191:     PROCEDURE CarregarLista()
2192:         IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
2193:             THIS.CarregarOperacoes()
2194:         ENDIF
2195:     ENDPROC
2196: 
2197:     *==========================================================================
2198:     * AJUSTARBOTOESPORMODO - Override: form REPORT nao tem modos CRUD
2199:     *   FormBase chama este metodo ao mudar de modo (INCLUIR/ALTERAR/etc.).
2200:     *   Para relatorio, os botoes de relatorio ficam sempre habilitados.
2201:     *==========================================================================
2202:     PROCEDURE AjustarBotoesPorModo()
2203:         IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
2204:             THIS.cmg_4c_Botoes.Enabled = .T.
2205:         ENDIF
2206:     ENDPROC
2207: 
2208: ENDDEFINE

