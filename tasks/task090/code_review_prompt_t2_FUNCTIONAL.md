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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReEsp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2213 linhas total):

*-- Linhas 5 a 213:
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
78:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
79:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
80: 
81:             *-- Page1: grid de selecao de tipos de operacao + botoes Sel/Des todos
82:             *-- (em forms REPORT, ConfigurarPaginaLista monta a "pagina de selecao" -
83:             *--  equivalente ao papel da Page1/Lista em forms CRUD)
84:             THIS.ConfigurarPaginaLista()
85: 
86:             *-- Controles de filtro - primeira metade (Periodo, Operacao, Tipo, Conta, Vendedor)
87:             THIS.ConfigurarPaginaDados()
88: 
89:             *-- Carregar tipos de operacao via SQL (pular em modo validacao UI)
90:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
91:                 THIS.CarregarOperacoes()
92:             ENDIF
93: 
94:             *-- Tornar form visivel
95:             THIS.Visible = .T.
96: 
97:             loc_lSucesso = .T.
98: 
99:         CATCH TO loc_oErro
100:             THIS.this_cMensagemErro = loc_oErro.Message
101:             MsgErro(loc_oErro.Message, "InicializarForm - FormSigReEsp")
102:         ENDTRY
103: 
104:         RETURN loc_lSucesso
105:     ENDPROC
106: 
107:     *==========================================================================
108:     * CONFIGURARPAGEFRAME - PageFrame com 2 paginas (Filtros / Dados)
109:     *
110:     *   O SCX legado SIGREESP eh FLAT mas no novo padrao do sistema os
111:     *   controles abaixo do cabecalho ficam encapsulados num PageFrame com
112:     *   PageCount=2 para consistencia com o ciclo de navegacao do FormBase
113:     *   (Page1 = "lista" / filtros, Page2 = "dados" reservado para extensoes).
114:     *
115:     *   Geometria: inicia logo abaixo do cabecalho (Top=80), ocupa toda a
116:     *   largura do form e o espaco restante na altura. Tabs ocultos (Tabs=.F.)
117:     *   - a navegacao eh feita via AlternarPagina().
118:     *==========================================================================
119:     PROTECTED PROCEDURE ConfigurarPageFrame()
120:         LOCAL loc_oPgf
121: 
122:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
123:         loc_oPgf = THIS.pgf_4c_Paginas
124: 
125:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1/Page2
126:         loc_oPgf.PageCount = 2
127: 
128:         loc_oPgf.Top    = 80
129:         loc_oPgf.Left   = -1
130:         loc_oPgf.Width  = THIS.Width + 2
131:         loc_oPgf.Height = THIS.Height - 80
132:         loc_oPgf.Tabs   = .F.
133: 
134:         *-- Page1 = "Filtros" (lista de selecao + filtros)
135:         loc_oPgf.Page1.Caption   = "Filtros"
136:         loc_oPgf.Page1.FontName  = "Tahoma"
137:         loc_oPgf.Page1.FontSize  = 8
138:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
139:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
140:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
141: 
142:         *-- Page2 = "Dados" (reservada - frmrelatorio nao usa, mantida para
143:         *--                  compatibilidade com o ciclo padrao do FormBase)
144:         loc_oPgf.Page2.Caption   = "Dados"
145:         loc_oPgf.Page2.FontName  = "Tahoma"
146:         loc_oPgf.Page2.FontSize  = 8
147:         loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
148:         loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
149:         loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)
150: 
151:         loc_oPgf.Visible    = .T.
152:         loc_oPgf.ActivePage = 1
153:     ENDPROC
154: 
155:     *==========================================================================
156:     * CRIARCURSOROPERACOES - Cria cursor vazio de tipos de operacao
157:     * Espelha o "Create Cursor crOperacoes" do Init() original + Index
158:     * Fase 4 ira popular com dados do SQL Server (SigCdTom) e configurar grid
159:     *==========================================================================
160:     PROTECTED PROCEDURE CriarCursorOperacoes()
161:         IF USED("crOperacoes")
162:             USE IN crOperacoes
163:         ENDIF
164:         CREATE CURSOR crOperacoes (SelImp L(1), Codigos N(2), Descrs C(30), SelImp2 L(1), SelImp3 L(1))
165:         INDEX ON Codigos TAG Codigos
166:     ENDPROC
167: 
168:     *==========================================================================
169:     * CONFIGURARCABECALHO - Cabecalho escuro com titulo
170:     * Equivalente a cntSombra do framework.vcx
171:     * BackColor=RGB(100,100,100), Width=THIS.Width (nao subtrair!)
172:     *==========================================================================
173:     PROTECTED PROCEDURE ConfigurarCabecalho()
174:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
175:         WITH THIS.cnt_4c_Cabecalho
176:             .Top        = 0
177:             .Left       = 0
178:             .Width      = THIS.Width
179:             .Height     = 80
180:             .BackStyle  = 1
181:             .BackColor  = RGB(100, 100, 100)
182:             .BorderWidth = 0
183:             .Visible    = .T.
184: 
185:             *-- Sombra preta (deslocada 3px para efeito de profundidade)
186:             .AddObject("lbl_4c_Sombra", "Label")
187:             WITH .lbl_4c_Sombra
188:                 .Top       = 18
189:                 .Left      = 12
190:                 .Width     = THIS.Width
191:                 .Height    = 46
192:                 .Caption   = THIS.Caption
193:                 .FontName  = "Tahoma"
194:                 .FontSize  = 16
195:                 .FontBold  = .T.
196:                 .ForeColor = RGB(0, 0, 0)
197:                 .BackStyle = 0
198:                 .Visible   = .T.
199:             ENDWITH
200: 
201:             *-- Titulo branco (sobre o fundo cinza escuro)
202:             .AddObject("lbl_4c_Titulo", "Label")
203:             WITH .lbl_4c_Titulo
204:                 .Top       = 15
205:                 .Left      = 10
206:                 .Width     = THIS.Width
207:                 .Height    = 46
208:                 .Caption   = THIS.Caption
209:                 .FontName  = "Tahoma"
210:                 .FontSize  = 16
211:                 .FontBold  = .T.
212:                 .ForeColor = RGB(255, 255, 255)
213:                 .BackStyle = 0

*-- Linhas 223 a 266:
223:     *   Botoes: Width=65, Height=70, Lefts=5,71,137,203
224:     * Imagens: ideo.jpg / impressora.jpg / excel.jpg / otao_encerrar.jpg
225:     *==========================================================================
226:     PROTECTED PROCEDURE ConfigurarBotoes()
227:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
228:         WITH THIS.cmg_4c_Botoes
229:             .Top           = 0
230:             .Left          = 529
231:             .Width         = 273
232:             .Height        = 80
233:             .ButtonCount   = 4
234:             .BackStyle     = 0
235:             .BorderStyle   = 0
236:             .BorderColor   = RGB(136, 189, 188)
237:             .SpecialEffect = 1
238:             .Themes        = .F.
239:             .Visible       = .T.
240: 
241:             WITH .Buttons(1)
242:                 .Top             = 5
243:                 .Left            = 5
244:                 .Width           = 65
245:                 .Height          = 70
246:                 .Caption         = "Visualizar"
247:                 .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
248:                 .FontBold        = .T.
249:                 .FontItalic      = .T.
250:                 .ForeColor       = RGB(90, 90, 90)
251:                 .BackColor       = RGB(255, 255, 255)
252:                 .PicturePosition = 13
253:                 .SpecialEffect   = 0
254:                 .MousePointer    = 15
255:                 .Themes          = .F.
256:                 .WordWrap        = .T.
257:             ENDWITH
258: 
259:             WITH .Buttons(2)
260:                 .Top             = 5
261:                 .Left            = 71
262:                 .Width           = 65
263:                 .Height          = 70
264:                 .Caption         = "Imprimir"
265:                 .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
266:                 .FontName        = "Tahoma"

*-- Linhas 318 a 462:
318:             ENDWITH
319:         ENDWITH
320: 
321:         *-- BINDEVENT em Buttons(N) - metodos PUBLIC obrigatorio
322:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
323:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
324:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocExcelClick")
325:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
326:     ENDPROC
327: 
328:     *==========================================================================
329:     * ATUALIZARESTADOCONTROLES - Override: relatorio nao tem estado CRUD
330:     *==========================================================================
331:     PROCEDURE AtualizarEstadoControles()
332:         RETURN
333:     ENDPROC
334: 
335:     *==========================================================================
336:     * BTNVISUALIZARCLICK - Exibe relatorio em preview na tela
337:     *==========================================================================
338:     PROCEDURE BtnVisualizarClick()
339:         THIS.FormParaRelatorio()
340:         IF !THIS.this_oRelatorio.Visualizar()
341:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao visualizar")
342:         ENDIF
343:     ENDPROC
344: 
345:     *==========================================================================
346:     * BTNIMPRIMIRCLICK - Imprime relatorio sem dialogo de impressora
347:     *==========================================================================
348:     PROCEDURE BtnImprimirClick()
349:         THIS.FormParaRelatorio()
350:         IF !THIS.this_oRelatorio.Imprimir()
351:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao imprimir")
352:         ENDIF
353:     ENDPROC
354: 
355:     *==========================================================================
356:     * BTNDOCEXCELCLICK - Imprime com selecao de impressora (dialogo)
357:     *==========================================================================
358:     PROCEDURE BtnDocExcelClick()
359:         THIS.FormParaRelatorio()
360:         IF !THIS.this_oRelatorio.ImprimirComPrompt()
361:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao imprimir")
362:         ENDIF
363:     ENDPROC
364: 
365:     *==========================================================================
366:     * BTNSAIRCLICK - Fecha o formulario (Cancel=.T. no Buttons(4) cobre ESC)
367:     *==========================================================================
368:     PROCEDURE BtnSairClick()
369:         THIS.Release()
370:     ENDPROC
371: 
372:     *==========================================================================
373:     * BTNINCLUIRCLICK - Override no-op: form REPORT nao tem operacao Incluir
374:     *==========================================================================
375:     PROCEDURE BtnIncluirClick()
376:         RETURN
377:     ENDPROC
378: 
379:     *==========================================================================
380:     * BTNALTERARCLICK - Override no-op: form REPORT nao tem operacao Alterar
381:     *==========================================================================
382:     PROCEDURE BtnAlterarClick()
383:         RETURN
384:     ENDPROC
385: 
386:     *==========================================================================
387:     * BTNEXCLUIRCLICK - Override no-op: form REPORT nao tem operacao Excluir
388:     *==========================================================================
389:     PROCEDURE BtnExcluirClick()
390:         RETURN
391:     ENDPROC
392: 
393:     *==========================================================================
394:     * ALTERNARPAGINA - Navega para a pagina solicitada no PageFrame
395:     *   Form REPORT possui PageCount=2; navega apenas se o indice for valido
396:     *   (1..PageCount). Usado pelo ciclo padrao do FormBase (BtnIncluir/Cancelar).
397:     *==========================================================================
398:     PROCEDURE AlternarPagina(par_nPagina)
399:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
400:            VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND ;
401:            par_nPagina <= THIS.pgf_4c_Paginas.PageCount
402:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
403:         ENDIF
404:     ENDPROC
405: 
406:     *==========================================================================
407:     * CONFIGURARPAGINALISTA - Monta a Page1 (lista de selecao do relatorio)
408:     *
409:     *   Em forms REPORT, a "pagina de lista" corresponde aa pagina de filtros
410:     *   contendo o grid de selecao + botoes Selecionar/Desmarcar todos.
411:     *   Equivale aa Page1/Lista de forms CRUD (carrega grid + botoes associados).
412:     *
413:     *   Coordenadas internas da Page1 = coordenadas originais - 80 (PageFrame
414:     *   inicia em Top=80, entao Top_Page1 = Top_original - 80).
415:     *
416:     *   Componentes adicionados:
417:     *     - grd_4c_Operacoes  : grid 5 colunas (M/Codigos/Descrs/E/C)
418:     *       Top original=290 -> Top_Page1=210
419:     *     - cmg_4c_GradeS     : CommandGroup 2 botoes (Sel./Des. todos)
420:     *       Top original=300 -> Top_Page1=220
421:     *==========================================================================
422:     PROTECTED PROCEDURE ConfigurarPaginaLista()
423:         LOCAL loc_oPagina, loc_oGrid
424: 
425:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
426:             RETURN
427:         ENDIF
428:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
429: 
430:         *-- ========================== GRID grd_4c_Operacoes ==========================
431:         loc_oPagina.AddObject("grd_4c_Operacoes", "Grid")
432:         loc_oGrid = loc_oPagina.grd_4c_Operacoes
433: 
434:         *-- ColumnCount ANTES de configurar colunas (cria Column1..ColumnN)
435:         loc_oGrid.ColumnCount = 5
436: 
437:         WITH loc_oGrid
438:             .Top                = 210
439:             .Left               = 439
440:             .Width              = 309
441:             .Height             = 115
442:             .DeleteMark         = .F.
443:             .RecordMark         = .F.
444:             .HighlightStyle     = 2
445:             .HighlightBackColor = RGB(255, 255, 255)
446:             .HighlightForeColor = RGB(15, 41, 104)
447:             .GridLineColor      = RGB(238, 238, 238)
448:             .FontName           = "Verdana"
449:             .FontSize           = 8
450:             .ScrollBars         = 2
451:             .RowHeight          = 16
452:         ENDWITH
453: 
454:         *-- Coluna 1: CheckBox para SelImp (selecao principal - Header "M")
455:         *-- REGRA: AddObject ANTES de CurrentControl; ControlSource DEPOIS
456:         WITH loc_oGrid.Column1
457:             .Width = 22
458:             .AddObject("Check1", "CheckBox")
459:             .Check1.Caption = ""
460:             .Check1.Value   = 0
461:             .CurrentControl = "Check1"
462:             .ControlSource  = "crOperacoes.SelImp"

*-- Linhas 512 a 607:
512:         loc_oGrid.Visible = .T.
513: 
514:         *-- KeyPress Enter(13)/Espaco(32) em Col1.Check1 -> togla SelImp
515:         BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress", THIS, "GrdOpeCheck1KeyPress")
516: 
517:         *-- ===================== COMMANDGROUP cmg_4c_GradeS ==========================
518:         *-- Botoes Sel./Des. todos (cmdBtnGradeS do original)
519:         *-- Top original=300 -> Top_Page1=220, Left=746, Width=50, Height=90
520:         loc_oPagina.AddObject("cmg_4c_GradeS", "CommandGroup")
521:         WITH loc_oPagina.cmg_4c_GradeS
522:             .Top         = 220
523:             .Left        = 746
524:             .Width       = 50
525:             .Height      = 90
526:             .ButtonCount = 2
527:             .BackStyle   = 0
528:             .BorderStyle = 0
529:             .Themes      = .F.
530:             .Visible     = .T.
531: 
532:             WITH .Buttons(1)
533:                 .Top      = 0
534:                 .Left     = 0
535:                 .Width    = 50
536:                 .Height   = 45
537:                 .Caption  = "Sel."
538:                 .Themes   = .F.
539:             ENDWITH
540: 
541:             WITH .Buttons(2)
542:                 .Top      = 45
543:                 .Left     = 0
544:                 .Width    = 50
545:                 .Height   = 45
546:                 .Caption  = "Des."
547:                 .FontName = "Tahoma"
548:                 .FontSize = 8
549:                 .Themes   = .F.
550:             ENDWITH
551:         ENDWITH
552: 
553:         BINDEVENT(loc_oPagina.cmg_4c_GradeS, "Click", THIS, "BtnGradeSClick")
554:     ENDPROC
555: 
556:     *==========================================================================
557:     * CONFIGURARPAGINADADOS - Fase 5/8: primeiros 50% dos controles de filtro
558:     *   Linha 1: Periodo (datas inicial/final + opcoes tipo periodo)
559:     *   Linha 2: Movimentacao (codigo operacao + numero pedido)
560:     *   Linha 3: Tipo de Operacao (codigo + descricao)
561:     *   Linha 4: Conta/Estoque (codigo + descricao)
562:     *   Linha 5: Vendedor (codigo + descricao)
563:     *
564:     *   Todos os controles vao em Page1 (form relatorio = layout flat).
565:     *   Coordenadas: Top_Page1 = Top_original - 80 (PageFrame.Top=80)
566:     *==========================================================================
567:     PROTECTED PROCEDURE ConfigurarPaginaDados()
568:         LOCAL loc_oPagina
569: 
570:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
571:             RETURN
572:         ENDIF
573:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
574: 
575:         *-- ===========================================================
576:         *-- LINHA 1: Periodo / Datas / Tipo de periodo
577:         *-- ===========================================================
578: 
579:         *-- Label "Periodo :" (lbl_periodo - TabIndex=1)
580:         *-- Top original=97 -> Top_Page1=17
581:         loc_oPagina.AddObject("lbl_4c_Lbl_periodo", "Label")
582:         WITH loc_oPagina.lbl_4c_Lbl_periodo
583:             .AutoSize  = .T.
584:             .Caption   = "Per" + CHR(237) + "odo :"
585:             .Left      = 47
586:             .Top       = 17
587:             .Width     = 45
588:             .FontName  = "Tahoma"
589:             .FontSize  = 8
590:             .BackStyle = 0
591:             .Visible   = .T.
592:         ENDWITH
593: 
594:         *-- TextBox data inicial (get_dt_inicial - TabIndex=2)
595:         *-- Top original=92 -> Top_Page1=12
596:         loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
597:         WITH loc_oPagina.txt_4c_DtInicial
598:             .FontName      = "Tahoma"
599:             .FontSize      = 8
600:             .Format        = "K"
601:             .Height        = 25
602:             .Left          = 94
603:             .SpecialEffect = 1
604:             .Top           = 12
605:             .Width         = 80
606:             .ForeColor     = RGB(0, 0, 0)
607:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 641 a 687:
641:             .Visible       = .T.
642:         ENDWITH
643: 
644:         *-- OptionGroup tipo de periodo (Opt_nr_periodo - TabIndex=5)
645:         *-- Top original=83 -> Top_Page1=3
646:         *-- ButtonCount=4: Lancamento / Prazo Entrega / Ult. Alteracao / Fechamento
647:         loc_oPagina.AddObject("obj_4c_OptNrPeriodo", "OptionGroup")
648:         WITH loc_oPagina.obj_4c_OptNrPeriodo
649:             .Top           = 3
650:             .Left          = 306
651:             .Width         = 200
652:             .Height        = 41
653:             .ButtonCount   = 4
654:             .BackStyle     = 0
655:             .BorderStyle   = 0
656:             .Value         = 1
657:             .SpecialEffect = 0
658:             .Themes        = .F.
659:             .Visible       = .T.
660: 
661:             WITH .Buttons(1)
662:                 .BackStyle = 0
663:                 .Caption   = "Lan" + CHR(231) + "amento"
664:                 .Value     = 1
665:                 .Height    = 15
666:                 .Left      = 5
667:                 .Top       = 5
668:                 .Width     = 76
669:                 .AutoSize  = .T.
670:                 .ForeColor = RGB(90, 90, 90)
671:             ENDWITH
672: 
673:             WITH .Buttons(2)
674:                 .FontName  = "Tahoma"
675:                 .FontSize  = 8
676:                 .BackStyle = 0
677:                 .Caption   = "Prazo Entrega"
678:                 .Value     = 0
679:                 .Left      = 100
680:                 .Top       = 5
681:                 .AutoSize  = .T.
682:                 .ForeColor = RGB(90, 90, 90)
683:             ENDWITH
684: 
685:             WITH .Buttons(3)
686:                 .FontName  = "Tahoma"
687:                 .FontSize  = 8

*-- Linhas 952 a 973:
952:             .BackStyle = 0
953:             .Visible   = .T.
954:         ENDWITH
955: 
956:         *-- TextBox cidade (Cidade - Top original=227 -> Top_Page1=147)
957:         loc_oPagina.AddObject("txt_4c_Cidade", "TextBox")
958:         WITH loc_oPagina.txt_4c_Cidade
959:             .FontName      = "Tahoma"
960:             .FontSize      = 8
961:             .Format        = "K"
962:             .Height        = 25
963:             .Left          = 94
964:             .MaxLength     = 30
965:             .SpecialEffect = 1
966:             .Top           = 147
967:             .Width         = 207
968:             .ForeColor     = RGB(0, 0, 0)
969:             .BorderColor   = RGB(100, 100, 100)
970:             .Value         = SPACE(30)
971:             .Visible       = .T.
972:         ENDWITH
973: 

*-- Linhas 983 a 1004:
983:             .BackStyle = 0
984:             .Visible   = .T.
985:         ENDWITH
986: 
987:         *-- TextBox estado (estado - Top original=227 -> Top_Page1=147)
988:         loc_oPagina.AddObject("txt_4c_Estado", "TextBox")
989:         WITH loc_oPagina.txt_4c_Estado
990:             .FontName      = "Tahoma"
991:             .FontSize      = 8
992:             .Format        = "K!"
993:             .Height        = 25
994:             .Left          = 359
995:             .MaxLength     = 2
996:             .SpecialEffect = 1
997:             .Top           = 147
998:             .Width         = 24
999:             .ForeColor     = RGB(0, 0, 0)
1000:             .BorderColor   = RGB(100, 100, 100)
1001:             .Value         = SPACE(2)
1002:             .Visible       = .T.
1003:         ENDWITH
1004: 

*-- Linhas 1103 a 1148:
1103:             .Visible   = .T.
1104:         ENDWITH
1105: 
1106:         *-- OptionGroup situacao filtro (opt_filtro - Top original=281 -> Top_Page1=201)
1107:         *-- ButtonCount=3: Encerrados/Abertos/Ambos, Value=3 (Ambos)
1108:         loc_oPagina.AddObject("obj_4c_OptFiltro", "OptionGroup")
1109:         WITH loc_oPagina.obj_4c_OptFiltro
1110:             .Top           = 201
1111:             .Left          = 89
1112:             .Width         = 235
1113:             .Height        = 20
1114:             .ButtonCount   = 3
1115:             .BackStyle     = 0
1116:             .BorderStyle   = 0
1117:             .Value         = 3
1118:             .SpecialEffect = 0
1119:             .Themes        = .F.
1120:             .Visible       = .T.
1121: 
1122:             WITH .Buttons(1)
1123:                 .BackStyle = 0
1124:                 .Caption   = "Encerrados"
1125:                 .Height    = 15
1126:                 .Left      = 5
1127:                 .Top       = 3
1128:                 .AutoSize  = .T.
1129:                 .ForeColor = RGB(90, 90, 90)
1130:             ENDWITH
1131: 
1132:             WITH .Buttons(2)
1133:                 .FontName  = "Tahoma"
1134:                 .FontSize  = 8
1135:                 .BackStyle = 0
1136:                 .Caption   = "Abertos"
1137:                 .Height    = 15
1138:                 .Left      = 95
1139:                 .Top       = 3
1140:                 .AutoSize  = .T.
1141:                 .ForeColor = RGB(90, 90, 90)
1142:             ENDWITH
1143: 
1144:             WITH .Buttons(3)
1145:                 .FontName  = "Tahoma"
1146:                 .FontSize  = 8
1147:                 .BackStyle = 0
1148:                 .Caption   = "Ambos"

*-- Linhas 1190 a 1236:
1190:             .Visible   = .T.
1191:         ENDWITH
1192: 
1193:         *-- OptionGroup imprimir por (Opc_Imp - Top original=321 -> Top_Page1=241)
1194:         *-- ButtonCount=3: Vendedor/Cidade/Data Encerramento, Value=1
1195:         *-- Enabled=.F.: habilitado somente quando opt_filtro.Value=1 (Encerrados)
1196:         loc_oPagina.AddObject("obj_4c_OpcImp", "OptionGroup")
1197:         WITH loc_oPagina.obj_4c_OpcImp
1198:             .Top           = 241
1199:             .Left          = 89
1200:             .Width         = 288
1201:             .Height        = 25
1202:             .ButtonCount   = 3
1203:             .BackStyle     = 0
1204:             .BorderStyle   = 0
1205:             .Value         = 1
1206:             .SpecialEffect = 0
1207:             .Themes        = .F.
1208:             .Enabled       = .F.
1209:             .Visible       = .T.
1210: 
1211:             WITH .Buttons(1)
1212:                 .BackStyle = 0
1213:                 .Caption   = "Vendedor"
1214:                 .Height    = 15
1215:                 .Left      = 5
1216:                 .Top       = 5
1217:                 .AutoSize  = .T.
1218:                 .ForeColor = RGB(90, 90, 90)
1219:             ENDWITH
1220: 
1221:             WITH .Buttons(2)
1222:                 .FontName  = "Tahoma"
1223:                 .FontSize  = 8
1224:                 .BackStyle = 0
1225:                 .Caption   = "Cidade"
1226:                 .Height    = 15
1227:                 .Left      = 90
1228:                 .Top       = 5
1229:                 .AutoSize  = .T.
1230:                 .ForeColor = RGB(90, 90, 90)
1231:             ENDWITH
1232: 
1233:             WITH .Buttons(3)
1234:                 .FontName  = "Tahoma"
1235:                 .FontSize  = 8
1236:                 .BackStyle = 0

*-- Linhas 1260 a 1305:
1260:             .Visible   = .T.
1261:         ENDWITH
1262: 
1263:         *-- OptionGroup analitico/sintetico (optAnaSin - Top original=347 -> Top_Page1=267)
1264:         *-- ButtonCount=2: Analitico/Sintetico, Value=2 (Sintetico)
1265:         loc_oPagina.AddObject("obj_4c_OptAnaSin", "OptionGroup")
1266:         WITH loc_oPagina.obj_4c_OptAnaSin
1267:             .Top           = 267
1268:             .Left          = 89
1269:             .Width         = 158
1270:             .Height        = 25
1271:             .ButtonCount   = 2
1272:             .BackStyle     = 0
1273:             .BorderStyle   = 0
1274:             .Value         = 2
1275:             .SpecialEffect = 0
1276:             .Themes        = .F.
1277:             .Visible       = .T.
1278: 
1279:             WITH .Buttons(1)
1280:                 .BackStyle = 0
1281:                 .Caption   = "Anal" + CHR(237) + "tico"
1282:                 .Height    = 15
1283:                 .Left      = 5
1284:                 .Top       = 5
1285:                 .AutoSize  = .T.
1286:                 .ForeColor = RGB(90, 90, 90)
1287:                 .Themes    = .F.
1288:             ENDWITH
1289: 
1290:             WITH .Buttons(2)
1291:                 .FontName  = "Tahoma"
1292:                 .FontSize  = 8
1293:                 .BackStyle = 0
1294:                 .Caption   = "Sint" + CHR(233) + "tico"
1295:                 .Height    = 15
1296:                 .Left      = 80
1297:                 .Top       = 5
1298:                 .AutoSize  = .T.
1299:                 .ForeColor = RGB(90, 90, 90)
1300:                 .Themes    = .F.
1301:             ENDWITH
1302:         ENDWITH
1303: 
1304:         *-- ===========================================================
1305:         *-- LINHA 12: chkTpope / chkSemVals

*-- Linhas 1357 a 1516:
1357:         ENDWITH
1358: 
1359:         *-- ===========================================================
1360:         *-- BINDEVENTS: KeyPress para lookups + InteractiveChange
1361:         *-- ===========================================================
1362: 
1363:         BINDEVENT(loc_oPagina.txt_4c_CdTpOpe,    "KeyPress",          THIS, "CdTpOpeLookupKeyPress")
1364:         BINDEVENT(loc_oPagina.txt_4c_DsTpOpe,    "KeyPress",          THIS, "DsTpOpeLookupKeyPress")
1365:         BINDEVENT(loc_oPagina.txt_4c_CdEstoque,  "KeyPress",          THIS, "CdEstoqueLookupKeyPress")
1366:         BINDEVENT(loc_oPagina.txt_4c_DsEstoque,  "KeyPress",          THIS, "DsEstoqueLookupKeyPress")
1367:         BINDEVENT(loc_oPagina.txt_4c_CdVendedor, "KeyPress",          THIS, "CdVendedorLookupKeyPress")
1368:         BINDEVENT(loc_oPagina.txt_4c_DsVendedor, "KeyPress",          THIS, "DsVendedorLookupKeyPress")
1369:         BINDEVENT(loc_oPagina.txt_4c_Estado,     "KeyPress",          THIS, "EstadoLookupKeyPress")
1370:         BINDEVENT(loc_oPagina.txt_4c_CdMoeda,    "KeyPress",          THIS, "CdMoedaLookupKeyPress")
1371:         BINDEVENT(loc_oPagina.txt_4c_DsMoeda,    "KeyPress",          THIS, "DsMoedaLookupKeyPress")
1372:         BINDEVENT(loc_oPagina.obj_4c_OptFiltro,  "InteractiveChange", THIS, "OptFiltroInteractiveChange")
1373:         BINDEVENT(loc_oPagina.chk_4c_ChkTpope,   "InteractiveChange", THIS, "ChkTpopeInteractiveChange")
1374:     ENDPROC
1375: 
1376:     *==========================================================================
1377:     * CARREGAROPERACOES - Carrega tipos de operacao de SigCdTom no crOperacoes
1378:     * Equivalente a logica SQL do Init() original do SIGREESP
1379:     * Inicializa SelImp=.T., SelImp2=.T., SelImp3=.F. para todos os registros
1380:     *==========================================================================
1381:     PROCEDURE CarregarOperacoes()
1382:         LOCAL loc_cSQL, loc_nResult, loc_nCodigos, loc_cDescrs
1383:         loc_cSQL = "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos"
1384: 
1385:         TRY
1386:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
1387:             IF loc_nResult > 0
1388:                 SELECT crOperacoes
1389:                 ZAP
1390:                 SELECT cursor_4c_TmpOpe
1391:                 SCAN
1392:                     loc_nCodigos = cursor_4c_TmpOpe.Codigos
1393:                     loc_cDescrs  = ALLTRIM(cursor_4c_TmpOpe.Descrs)
1394:                     SELECT crOperacoes
1395:                     APPEND BLANK
1396:                     REPLACE SelImp  WITH .T., ;
1397:                             SelImp2 WITH .T., ;
1398:                             SelImp3 WITH .F., ;
1399:                             Codigos WITH loc_nCodigos, ;
1400:                             Descrs  WITH loc_cDescrs
1401:                     SELECT cursor_4c_TmpOpe
1402:                 ENDSCAN
1403:                 IF USED("cursor_4c_TmpOpe")
1404:                     USE IN cursor_4c_TmpOpe
1405:                 ENDIF
1406:                 SELECT crOperacoes
1407:                 GO TOP
1408:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
1409:                    VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes) = "O"
1410:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1411:                 ENDIF
1412:             ENDIF
1413:         CATCH TO loc_oErro
1414:             MsgErro(loc_oErro.Message, "CarregarOperacoes")
1415:         ENDTRY
1416:     ENDPROC
1417: 
1418:     *==========================================================================
1419:     * BTNGRADESCLICK - Seleciona ou desmarca todos os tipos de operacao
1420:     *   Value=1 -> marca todos (SelImp=.T., SelImp2=.T.)
1421:     *   Value=2 -> desmarca todos (SelImp=.F., SelImp2=.F.)
1422:     *   Logica identica ao cmdBtnGradeS.Click original.
1423:     *==========================================================================
1424:     PROCEDURE BtnGradeSClick()
1425:         LOCAL loc_lMarcar, loc_oGrid
1426:         loc_lMarcar = (THIS.pgf_4c_Paginas.Page1.cmg_4c_GradeS.Value = 1)
1427:         IF USED("crOperacoes")
1428:             UPDATE crOperacoes SET SelImp = loc_lMarcar, SelImp2 = loc_lMarcar
1429:             GO TOP IN crOperacoes
1430:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes
1431:             IF VARTYPE(loc_oGrid) = "O"
1432:                 loc_oGrid.Refresh()
1433:             ENDIF
1434:         ENDIF
1435:     ENDPROC
1436: 
1437:     *==========================================================================
1438:     * GRDOPECHECK1KEYPRESS - Togla SelImp via teclado (Enter=13, Espaco=32)
1439:     * Equivalente ao KeyPress do Check1 da Column1 do grdOperacoes original
1440:     *==========================================================================
1441:     PROCEDURE GrdOpeCheck1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1442:         LOCAL loc_oGrid
1443:         IF INLIST(par_nKeyCode, 13, 32)
1444:             IF USED("crOperacoes") AND !EOF("crOperacoes")
1445:                 SELECT crOperacoes
1446:                 REPLACE SelImp WITH !crOperacoes.SelImp
1447:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
1448:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes
1449:                     IF VARTYPE(loc_oGrid) = "O"
1450:                         loc_oGrid.Refresh()
1451:                     ENDIF
1452:                 ENDIF
1453:             ENDIF
1454:             NODEFAULT
1455:         ENDIF
1456:     ENDPROC
1457: 
1458:     *==========================================================================
1459:     * DESTROY - Limpeza de recursos
1460:     * NAO usar .Release() em BO Custom - apenas .NULL.
1461:     *==========================================================================
1462:     PROCEDURE Destroy()
1463:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1464:             THIS.this_oRelatorio = .NULL.
1465:         ENDIF
1466:         IF USED("crOperacoes")
1467:             USE IN crOperacoes
1468:         ENDIF
1469:         DODEFAULT()
1470:     ENDPROC
1471: 
1472:     *==========================================================================
1473:     * FORMPARARELATORIO - Transfere controles da tela para o BO do relatorio
1474:     * Chamado por BtnVisualizarClick, BtnImprimirClick, BtnDocExcelClick
1475:     *==========================================================================
1476:     PROCEDURE FormParaRelatorio()
1477:         LOCAL loc_oPag, loc_cTpOpeM, loc_cTpOpeE, loc_cTpOpeC
1478:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1479:             RETURN
1480:         ENDIF
1481:         loc_oPag     = THIS.pgf_4c_Paginas.Page1
1482:         loc_cTpOpeM  = ""
1483:         loc_cTpOpeE  = ""
1484:         loc_cTpOpeC  = ""
1485:         TRY
1486:             WITH THIS.this_oRelatorio
1487:                 .this_dDtInicial  = loc_oPag.txt_4c_DtInicial.Value
1488:                 .this_dDtFinal    = loc_oPag.txt_4c_DtFinal.Value
1489:                 .this_nPeriodo    = loc_oPag.obj_4c_OptNrPeriodo.Value
1490:                 .this_cNmOperacao = ALLTRIM(loc_oPag.txt_4c__nm_operacao.Value)
1491:                 .this_nNumero     = loc_oPag.txt_4c_Numero.Value
1492:                 .this_nCdTpOpe    = loc_oPag.txt_4c_CdTpOpe.Value
1493:                 .this_cDsTpOpe    = ALLTRIM(loc_oPag.txt_4c_DsTpOpe.Value)
1494:                 .this_cCdConta    = ALLTRIM(loc_oPag.txt_4c_CdEstoque.Value)
1495:                 .this_cDsConta    = ALLTRIM(loc_oPag.txt_4c_DsEstoque.Value)
1496:                 .this_cCdVendedor = ALLTRIM(loc_oPag.txt_4c_CdVendedor.Value)
1497:                 .this_cDsVendedor = ALLTRIM(loc_oPag.txt_4c_DsVendedor.Value)
1498:                 .this_cCidade     = ALLTRIM(loc_oPag.txt_4c_Cidade.Value)
1499:                 .this_cEstado     = ALLTRIM(loc_oPag.txt_4c_Estado.Value)
1500:                 .this_nFiltro     = loc_oPag.obj_4c_OptFiltro.Value
1501:                 .this_nOpcImp     = loc_oPag.obj_4c_OpcImp.Value
1502:                 .this_nOrdem      = loc_oPag.cbo_4c_Ordem1.ListIndex
1503:                 .this_nAnaSin     = loc_oPag.obj_4c_OptAnaSin.Value
1504:                 .this_lTpOpe      = (loc_oPag.chk_4c_ChkTpope.Value = 1)
1505:                 .this_lItens      = (loc_oPag.chk_4c_ChkItens.Value = 1)
1506:                 .this_lIndus      = (loc_oPag.chk_4c_ChkIndus.Value = 1)
1507:                 .this_lSemVals    = (loc_oPag.chk_4c_ChkSemVals.Value = 1)
1508:                 .this_cCdMoeda    = ALLTRIM(loc_oPag.txt_4c_CdMoeda.Value)
1509:                 .this_cDsMoeda    = ALLTRIM(loc_oPag.txt_4c_DsMoeda.Value)
1510:             ENDWITH
1511:             IF USED("crOperacoes")
1512:                 SELECT crOperacoes
1513:                 GO TOP
1514:                 SCAN
1515:                     IF crOperacoes.SelImp
1516:                         loc_cTpOpeM = loc_cTpOpeM + IIF(EMPTY(loc_cTpOpeM),"",",") + ALLTRIM(STR(crOperacoes.Codigos))

*-- Linhas 1534 a 2213:
1534:     *==========================================================================
1535:     * LIMPARCAMPOS - Restaura todos os filtros aos valores padrao
1536:     *==========================================================================
1537:     PROCEDURE LimparCampos()
1538:         LOCAL loc_oPag
1539:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1540:             RETURN
1541:         ENDIF
1542:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1543:         TRY
1544:             loc_oPag.txt_4c_DtInicial.Value        = DATE()
1545:             loc_oPag.txt_4c_DtFinal.Value          = DATE()
1546:             loc_oPag.obj_4c_OptNrPeriodo.Value     = 1
1547:             loc_oPag.txt_4c__nm_operacao.Value     = SPACE(20)
1548:             loc_oPag.txt_4c_Numero.Value           = 0
1549:             loc_oPag.txt_4c_CdTpOpe.Value          = 0
1550:             loc_oPag.txt_4c_DsTpOpe.Value          = "TODOS"
1551:             loc_oPag.txt_4c_CdEstoque.Value        = SPACE(10)
1552:             loc_oPag.txt_4c_DsEstoque.Value        = SPACE(40)
1553:             loc_oPag.txt_4c_CdVendedor.Value       = SPACE(10)
1554:             loc_oPag.txt_4c_DsVendedor.Value       = SPACE(40)
1555:             loc_oPag.txt_4c_Cidade.Value           = SPACE(30)
1556:             loc_oPag.txt_4c_Estado.Value           = SPACE(2)
1557:             loc_oPag.cbo_4c_Ordem1.Value           = "Cliente"
1558:             loc_oPag.txt_4c_CdMoeda.Value          = SPACE(3)
1559:             loc_oPag.txt_4c_DsMoeda.Value          = SPACE(15)
1560:             loc_oPag.obj_4c_OptFiltro.Value        = 3
1561:             loc_oPag.obj_4c_OpcImp.Enabled         = .F.
1562:             loc_oPag.obj_4c_OpcImp.Value           = 1
1563:             loc_oPag.obj_4c_OptAnaSin.Value        = 2
1564:             loc_oPag.chk_4c_ChkItens.Value         = 0
1565:             loc_oPag.chk_4c_ChkTpope.Value         = 0
1566:             loc_oPag.chk_4c_ChkSemVals.Value       = 0
1567:             loc_oPag.chk_4c_ChkSemVals.Enabled     = .F.
1568:             loc_oPag.chk_4c_ChkIndus.Value         = 0
1569:         CATCH TO loc_oErro
1570:             MsgErro(loc_oErro.Message, "LimparCampos")
1571:         ENDTRY
1572:     ENDPROC
1573: 
1574:     *==========================================================================
1575:     * OPTFILTROINTERACTIVECHANGE - Controla estado de OpcImp e ChkItens
1576:     *   Value=1 (Encerrados): habilita OpcImp, zera ChkItens
1577:     *   Value=2/3: desabilita OpcImp
1578:     *==========================================================================
1579:     PROCEDURE OptFiltroInteractiveChange()
1580:         LOCAL loc_oPag, loc_lEncerrados
1581:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1582:             RETURN
1583:         ENDIF
1584:         loc_oPag        = THIS.pgf_4c_Paginas.Page1
1585:         loc_lEncerrados = (loc_oPag.obj_4c_OptFiltro.Value = 1)
1586:         loc_oPag.obj_4c_OpcImp.Enabled = loc_lEncerrados
1587:         IF loc_lEncerrados
1588:             loc_oPag.chk_4c_ChkItens.Value = 0
1589:         ENDIF
1590:     ENDPROC
1591: 
1592:     *==========================================================================
1593:     * CHKTPOPEINTERACTIVECHANGE - Controla estado de ChkSemVals
1594:     *   Value=1: habilita ChkSemVals
1595:     *   Value=0: desabilita e zera ChkSemVals
1596:     *==========================================================================
1597:     PROCEDURE ChkTpopeInteractiveChange()
1598:         LOCAL loc_oPag
1599:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1600:             RETURN
1601:         ENDIF
1602:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1603:         IF loc_oPag.chk_4c_ChkTpope.Value = 1
1604:             loc_oPag.chk_4c_ChkSemVals.Enabled = .T.
1605:         ELSE
1606:             loc_oPag.chk_4c_ChkSemVals.Value   = 0
1607:             loc_oPag.chk_4c_ChkSemVals.Enabled = .F.
1608:         ENDIF
1609:     ENDPROC
1610: 
1611:     *==========================================================================
1612:     * HANDLERS KEYPRESS - F4/F5 dispara lookup nos campos de filtro
1613:     *==========================================================================
1614:     PROCEDURE CdTpOpeLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1615:         IF INLIST(par_nKeyCode, 115, 116)
1616:             THIS.AbrirLookupTpOpePorCodigo()
1617:         ENDIF
1618:     ENDPROC
1619: 
1620:     PROCEDURE DsTpOpeLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1621:         IF INLIST(par_nKeyCode, 115, 116)
1622:             THIS.AbrirLookupTpOpePorDescricao()
1623:         ENDIF
1624:     ENDPROC
1625: 
1626:     PROCEDURE CdEstoqueLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1627:         IF INLIST(par_nKeyCode, 115, 116)
1628:             THIS.AbrirLookupEstoquePorCodigo()
1629:         ENDIF
1630:     ENDPROC
1631: 
1632:     PROCEDURE DsEstoqueLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1633:         IF INLIST(par_nKeyCode, 115, 116)
1634:             THIS.AbrirLookupEstoquePorDescricao()
1635:         ENDIF
1636:     ENDPROC
1637: 
1638:     PROCEDURE CdVendedorLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1639:         IF INLIST(par_nKeyCode, 115, 116)
1640:             THIS.AbrirLookupVendedorPorCodigo()
1641:         ENDIF
1642:     ENDPROC
1643: 
1644:     PROCEDURE DsVendedorLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1645:         IF INLIST(par_nKeyCode, 115, 116)
1646:             THIS.AbrirLookupVendedorPorDescricao()
1647:         ENDIF
1648:     ENDPROC
1649: 
1650:     PROCEDURE EstadoLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1651:         IF INLIST(par_nKeyCode, 115, 116)
1652:             THIS.AbrirLookupEstado()
1653:         ENDIF
1654:     ENDPROC
1655: 
1656:     PROCEDURE CdMoedaLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1657:         IF INLIST(par_nKeyCode, 115, 116)
1658:             THIS.AbrirLookupMoedaPorCodigo()
1659:         ENDIF
1660:     ENDPROC
1661: 
1662:     PROCEDURE DsMoedaLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1663:         IF INLIST(par_nKeyCode, 115, 116)
1664:             THIS.AbrirLookupMoedaPorDescricao()
1665:         ENDIF
1666:     ENDPROC
1667: 
1668:     *==========================================================================
1669:     * LOOKUPS TIPO DE OPERACAO (SigCdTom: Codigos, Descrs)
1670:     *==========================================================================
1671:     PROCEDURE AbrirLookupTpOpePorCodigo()
1672:         LOCAL loc_oBusca, loc_cValor
1673:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1674:             RETURN
1675:         ENDIF
1676:         loc_cValor = ALLTRIM(STR(THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value))
1677:         TRY
1678:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1679:                 "SigCdTom", "cursor_4c_BuscaTpOpe", "Codigos", loc_cValor, ;
1680:                 "Tipo de Opera" + CHR(231) + CHR(227) + "o")
1681:             IF VARTYPE(loc_oBusca) = "O"
1682:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1683:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = cursor_4c_BuscaTpOpe.Codigos
1684:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_BuscaTpOpe.Descrs)
1685:                 ELSE
1686:                     IF !loc_oBusca.this_lAchouRegistro
1687:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1688:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1689:                     loc_oBusca.Show()
1690:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpOpe")
1691:                         THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = cursor_4c_BuscaTpOpe.Codigos
1692:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_BuscaTpOpe.Descrs)
1693:                     ENDIF
1694:                     ENDIF
1695:                 ENDIF
1696:                 loc_oBusca.Release()
1697:             ENDIF
1698:         CATCH TO loc_oErro
1699:             MsgErro(loc_oErro.Message, "AbrirLookupTpOpePorCodigo")
1700:         ENDTRY
1701:         IF USED("cursor_4c_BuscaTpOpe")
1702:             USE IN cursor_4c_BuscaTpOpe
1703:         ENDIF
1704:     ENDPROC
1705: 
1706:     PROCEDURE AbrirLookupTpOpePorDescricao()
1707:         LOCAL loc_oBusca, loc_cValor
1708:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1709:             RETURN
1710:         ENDIF
1711:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value)
1712:         IF loc_cValor = "TODOS"
1713:             loc_cValor = ""
1714:         ENDIF
1715:         TRY
1716:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1717:                 "SigCdTom", "cursor_4c_BuscaTpOpe", "Descrs", loc_cValor, ;
1718:                 "Tipo de Opera" + CHR(231) + CHR(227) + "o")
1719:             IF VARTYPE(loc_oBusca) = "O"
1720:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1721:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = cursor_4c_BuscaTpOpe.Codigos
1722:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_BuscaTpOpe.Descrs)
1723:                 ELSE
1724:                     IF !loc_oBusca.this_lAchouRegistro
1725:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1726:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1727:                     loc_oBusca.Show()
1728:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpOpe")
1729:                         THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = cursor_4c_BuscaTpOpe.Codigos
1730:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_BuscaTpOpe.Descrs)
1731:                     ENDIF
1732:                     ENDIF
1733:                 ENDIF
1734:                 loc_oBusca.Release()
1735:             ENDIF
1736:         CATCH TO loc_oErro
1737:             MsgErro(loc_oErro.Message, "AbrirLookupTpOpePorDescricao")
1738:         ENDTRY
1739:         IF USED("cursor_4c_BuscaTpOpe")
1740:             USE IN cursor_4c_BuscaTpOpe
1741:         ENDIF
1742:     ENDPROC
1743: 
1744:     PROCEDURE ValidarTpOpeCodigo()
1745:         LOCAL loc_cSQL, loc_nRes, loc_nCod
1746:         loc_nCod = THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value
1747:         IF loc_nCod = 0
1748:             THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = "TODOS"
1749:             RETURN
1750:         ENDIF
1751:         TRY
1752:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdTom WHERE Codigos = " + FormatarNumeroSQL(loc_nCod, 0)
1753:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValTpOpe")
1754:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValTpOpe") = 1
1755:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = ALLTRIM(cursor_4c_ValTpOpe.Descrs)
1756:             ELSE
1757:                 MsgAviso("C" + CHR(243) + "digo de tipo n" + CHR(227) + "o encontrado.")
1758:                 THIS.pgf_4c_Paginas.Page1.txt_4c_CdTpOpe.Value = 0
1759:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsTpOpe.Value = "TODOS"
1760:                 THIS.AbrirLookupTpOpePorCodigo()
1761:             ENDIF
1762:         CATCH TO loc_oErro
1763:             MsgErro(loc_oErro.Message, "ValidarTpOpeCodigo")
1764:         ENDTRY
1765:         IF USED("cursor_4c_ValTpOpe")
1766:             USE IN cursor_4c_ValTpOpe
1767:         ENDIF
1768:     ENDPROC
1769: 
1770:     *==========================================================================
1771:     * LOOKUPS CONTA/ESTOQUE (SigCdCli: iclis, nomes)
1772:     *==========================================================================
1773:     PROCEDURE AbrirLookupEstoquePorCodigo()
1774:         LOCAL loc_oBusca, loc_cValor
1775:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1776:             RETURN
1777:         ENDIF
1778:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value)
1779:         TRY
1780:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1781:                 "SigCdCli", "cursor_4c_BuscaEstoque", "iclis", loc_cValor, ;
1782:                 "Conta/Estoque")
1783:             IF VARTYPE(loc_oBusca) = "O"
1784:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1785:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
1786:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.nomes)
1787:                 ELSE
1788:                     IF !loc_oBusca.this_lAchouRegistro
1789:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1790:                     loc_oBusca.mAddColuna("nomes", "", "Nome")
1791:                     loc_oBusca.Show()
1792:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEstoque")
1793:                         THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
1794:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.nomes)
1795:                     ENDIF
1796:                     ENDIF
1797:                 ENDIF
1798:                 loc_oBusca.Release()
1799:             ENDIF
1800:         CATCH TO loc_oErro
1801:             MsgErro(loc_oErro.Message, "AbrirLookupEstoquePorCodigo")
1802:         ENDTRY
1803:         IF USED("cursor_4c_BuscaEstoque")
1804:             USE IN cursor_4c_BuscaEstoque
1805:         ENDIF
1806:     ENDPROC
1807: 
1808:     PROCEDURE AbrirLookupEstoquePorDescricao()
1809:         LOCAL loc_oBusca, loc_cValor
1810:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1811:             RETURN
1812:         ENDIF
1813:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value)
1814:         TRY
1815:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1816:                 "SigCdCli", "cursor_4c_BuscaEstoque", "nomes", loc_cValor, ;
1817:                 "Conta/Estoque")
1818:             IF VARTYPE(loc_oBusca) = "O"
1819:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1820:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
1821:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.nomes)
1822:                 ELSE
1823:                     IF !loc_oBusca.this_lAchouRegistro
1824:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1825:                     loc_oBusca.mAddColuna("nomes", "", "Nome")
1826:                     loc_oBusca.Show()
1827:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEstoque")
1828:                         THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
1829:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.nomes)
1830:                     ENDIF
1831:                     ENDIF
1832:                 ENDIF
1833:                 loc_oBusca.Release()
1834:             ENDIF
1835:         CATCH TO loc_oErro
1836:             MsgErro(loc_oErro.Message, "AbrirLookupEstoquePorDescricao")
1837:         ENDTRY
1838:         IF USED("cursor_4c_BuscaEstoque")
1839:             USE IN cursor_4c_BuscaEstoque
1840:         ENDIF
1841:     ENDPROC
1842: 
1843:     PROCEDURE ValidarEstoqueCodigo()
1844:         LOCAL loc_cSQL, loc_nRes, loc_cCod
1845:         loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value)
1846:         IF EMPTY(loc_cCod)
1847:             THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = SPACE(40)
1848:             RETURN
1849:         ENDIF
1850:         TRY
1851:             loc_cSQL = "SELECT iclis, nomes FROM SigCdCli WHERE CAST(iclis AS VARCHAR(20)) = " + EscaparSQL(loc_cCod)
1852:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValEstoque")
1853:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValEstoque") = 1
1854:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_ValEstoque.nomes)
1855:             ELSE
1856:                 MsgAviso("C" + CHR(243) + "digo de conta n" + CHR(227) + "o encontrado.")
1857:                 THIS.pgf_4c_Paginas.Page1.txt_4c_CdEstoque.Value = SPACE(10)
1858:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsEstoque.Value = SPACE(40)
1859:                 THIS.AbrirLookupEstoquePorCodigo()
1860:             ENDIF
1861:         CATCH TO loc_oErro
1862:             MsgErro(loc_oErro.Message, "ValidarEstoqueCodigo")
1863:         ENDTRY
1864:         IF USED("cursor_4c_ValEstoque")
1865:             USE IN cursor_4c_ValEstoque
1866:         ENDIF
1867:     ENDPROC
1868: 
1869:     *==========================================================================
1870:     * LOOKUPS VENDEDOR (SigCdCli: iclis, nomes)
1871:     *==========================================================================
1872:     PROCEDURE AbrirLookupVendedorPorCodigo()
1873:         LOCAL loc_oBusca, loc_cValor
1874:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1875:             RETURN
1876:         ENDIF
1877:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value)
1878:         TRY
1879:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1880:                 "SigCdCli", "cursor_4c_BuscaVendedor", "iclis", loc_cValor, ;
1881:                 "Vendedor")
1882:             IF VARTYPE(loc_oBusca) = "O"
1883:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1884:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.iclis)
1885:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.nomes)
1886:                 ELSE
1887:                     IF !loc_oBusca.this_lAchouRegistro
1888:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1889:                     loc_oBusca.mAddColuna("nomes", "", "Nome")
1890:                     loc_oBusca.Show()
1891:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVendedor")
1892:                         THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.iclis)
1893:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.nomes)
1894:                     ENDIF
1895:                     ENDIF
1896:                 ENDIF
1897:                 loc_oBusca.Release()
1898:             ENDIF
1899:         CATCH TO loc_oErro
1900:             MsgErro(loc_oErro.Message, "AbrirLookupVendedorPorCodigo")
1901:         ENDTRY
1902:         IF USED("cursor_4c_BuscaVendedor")
1903:             USE IN cursor_4c_BuscaVendedor
1904:         ENDIF
1905:     ENDPROC
1906: 
1907:     PROCEDURE AbrirLookupVendedorPorDescricao()
1908:         LOCAL loc_oBusca, loc_cValor
1909:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1910:             RETURN
1911:         ENDIF
1912:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value)
1913:         TRY
1914:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1915:                 "SigCdCli", "cursor_4c_BuscaVendedor", "nomes", loc_cValor, ;
1916:                 "Vendedor")
1917:             IF VARTYPE(loc_oBusca) = "O"
1918:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1919:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.iclis)
1920:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.nomes)
1921:                 ELSE
1922:                     IF !loc_oBusca.this_lAchouRegistro
1923:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1924:                     loc_oBusca.mAddColuna("nomes", "", "Nome")
1925:                     loc_oBusca.Show()
1926:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVendedor")
1927:                         THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.iclis)
1928:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_BuscaVendedor.nomes)
1929:                     ENDIF
1930:                     ENDIF
1931:                 ENDIF
1932:                 loc_oBusca.Release()
1933:             ENDIF
1934:         CATCH TO loc_oErro
1935:             MsgErro(loc_oErro.Message, "AbrirLookupVendedorPorDescricao")
1936:         ENDTRY
1937:         IF USED("cursor_4c_BuscaVendedor")
1938:             USE IN cursor_4c_BuscaVendedor
1939:         ENDIF
1940:     ENDPROC
1941: 
1942:     PROCEDURE ValidarVendedorCodigo()
1943:         LOCAL loc_cSQL, loc_nRes, loc_cCod
1944:         loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value)
1945:         IF EMPTY(loc_cCod)
1946:             THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = SPACE(40)
1947:             RETURN
1948:         ENDIF
1949:         TRY
1950:             loc_cSQL = "SELECT iclis, nomes FROM SigCdCli WHERE CAST(iclis AS VARCHAR(20)) = " + EscaparSQL(loc_cCod)
1951:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValVendedor")
1952:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValVendedor") = 1
1953:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ALLTRIM(cursor_4c_ValVendedor.nomes)
1954:             ELSE
1955:                 MsgAviso("C" + CHR(243) + "digo de vendedor n" + CHR(227) + "o encontrado.")
1956:                 THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = SPACE(10)
1957:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = SPACE(40)
1958:                 THIS.AbrirLookupVendedorPorCodigo()
1959:             ENDIF
1960:         CATCH TO loc_oErro
1961:             MsgErro(loc_oErro.Message, "ValidarVendedorCodigo")
1962:         ENDTRY
1963:         IF USED("cursor_4c_ValVendedor")
1964:             USE IN cursor_4c_ValVendedor
1965:         ENDIF
1966:     ENDPROC
1967: 
1968:     *==========================================================================
1969:     * LOOKUP ESTADO (SigCdUfs: Estados)
1970:     *==========================================================================
1971:     PROCEDURE AbrirLookupEstado()
1972:         LOCAL loc_oBusca, loc_cValor
1973:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
1974:             RETURN
1975:         ENDIF
1976:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Estado.Value)
1977:         TRY
1978:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1979:                 "SigCdUfs", "cursor_4c_BuscaEstado", "Estados", loc_cValor, ;
1980:                 "Estado (UF)")
1981:             IF VARTYPE(loc_oBusca) = "O"
1982:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1983:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Estado.Value = ALLTRIM(cursor_4c_BuscaEstado.Estados)
1984:                 ELSE
1985:                     IF !loc_oBusca.this_lAchouRegistro
1986:                     loc_oBusca.mAddColuna("Estados", "", "UF")
1987:                     loc_oBusca.Show()
1988:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEstado")
1989:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Estado.Value = ALLTRIM(cursor_4c_BuscaEstado.Estados)
1990:                     ENDIF
1991:                     ENDIF
1992:                 ENDIF
1993:                 loc_oBusca.Release()
1994:             ENDIF
1995:         CATCH TO loc_oErro
1996:             MsgErro(loc_oErro.Message, "AbrirLookupEstado")
1997:         ENDTRY
1998:         IF USED("cursor_4c_BuscaEstado")
1999:             USE IN cursor_4c_BuscaEstado
2000:         ENDIF
2001:     ENDPROC
2002: 
2003:     *==========================================================================
2004:     * LOOKUPS MOEDA (SigCdMoe: cmoes, dmoes)
2005:     *==========================================================================
2006:     PROCEDURE AbrirLookupMoedaPorCodigo()
2007:         LOCAL loc_oBusca, loc_cValor
2008:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
2009:             RETURN
2010:         ENDIF
2011:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value)
2012:         TRY
2013:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2014:                 "SigCdMoe", "cursor_4c_BuscaMoeda", "cmoes", loc_cValor, ;
2015:                 "Moeda")
2016:             IF VARTYPE(loc_oBusca) = "O"
2017:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2018:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
2019:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
2020:                 ELSE
2021:                     IF !loc_oBusca.this_lAchouRegistro
2022:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
2023:                     loc_oBusca.mAddColuna("dmoes", "", "Moeda")
2024:                     loc_oBusca.Show()
2025:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
2026:                         THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
2027:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
2028:                     ENDIF
2029:                     ENDIF
2030:                 ENDIF
2031:                 loc_oBusca.Release()
2032:             ENDIF
2033:         CATCH TO loc_oErro
2034:             MsgErro(loc_oErro.Message, "AbrirLookupMoedaPorCodigo")
2035:         ENDTRY
2036:         IF USED("cursor_4c_BuscaMoeda")
2037:             USE IN cursor_4c_BuscaMoeda
2038:         ENDIF
2039:     ENDPROC
2040: 
2041:     PROCEDURE AbrirLookupMoedaPorDescricao()
2042:         LOCAL loc_oBusca, loc_cValor
2043:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
2044:             RETURN
2045:         ENDIF
2046:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value)
2047:         TRY
2048:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2049:                 "SigCdMoe", "cursor_4c_BuscaMoeda", "dmoes", loc_cValor, ;
2050:                 "Moeda")
2051:             IF VARTYPE(loc_oBusca) = "O"
2052:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2053:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
2054:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
2055:                 ELSE
2056:                     IF !loc_oBusca.this_lAchouRegistro
2057:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
2058:                     loc_oBusca.mAddColuna("dmoes", "", "Moeda")
2059:                     loc_oBusca.Show()
2060:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
2061:                         THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
2062:                         THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
2063:                     ENDIF
2064:                     ENDIF
2065:                 ENDIF
2066:                 loc_oBusca.Release()
2067:             ENDIF
2068:         CATCH TO loc_oErro
2069:             MsgErro(loc_oErro.Message, "AbrirLookupMoedaPorDescricao")
2070:         ENDTRY
2071:         IF USED("cursor_4c_BuscaMoeda")
2072:             USE IN cursor_4c_BuscaMoeda
2073:         ENDIF
2074:     ENDPROC
2075: 
2076:     PROCEDURE ValidarMoedaCodigo()
2077:         LOCAL loc_cSQL, loc_nRes, loc_cCod
2078:         loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value)
2079:         IF EMPTY(loc_cCod)
2080:             THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = SPACE(15)
2081:             RETURN
2082:         ENDIF
2083:         TRY
2084:             loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE CAST(cmoes AS VARCHAR(10)) = " + EscaparSQL(loc_cCod)
2085:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValMoeda")
2086:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_ValMoeda") = 1
2087:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_ValMoeda.dmoes)
2088:             ELSE
2089:                 MsgAviso("C" + CHR(243) + "digo de moeda n" + CHR(227) + "o encontrado.")
2090:                 THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = SPACE(3)
2091:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = SPACE(15)
2092:                 THIS.AbrirLookupMoedaPorCodigo()
2093:             ENDIF
2094:         CATCH TO loc_oErro
2095:             MsgErro(loc_oErro.Message, "ValidarMoedaCodigo")
2096:         ENDTRY
2097:         IF USED("cursor_4c_ValMoeda")
2098:             USE IN cursor_4c_ValMoeda
2099:         ENDIF
2100:     ENDPROC
2101: 
2102:     *==========================================================================
2103:     * BTNBUSCARCLICK - Override no-op: form REPORT nao tem operacao Buscar CRUD
2104:     *   FormBase pode chamar este metodo; aqui nao faz nada.
2105:     *==========================================================================
2106:     PROCEDURE BtnBuscarClick()
2107:         RETURN
2108:     ENDPROC
2109: 
2110:     *==========================================================================
2111:     * BTNENCERRARCLICK - Fecha o formulario de relatorio
2112:     *==========================================================================
2113:     PROCEDURE BtnEncerrarClick()
2114:         THIS.Release()
2115:     ENDPROC
2116: 
2117:     *==========================================================================
2118:     * BTNSALVARCLICK - Override no-op: form REPORT nao salva registros CRUD
2119:     *==========================================================================
2120:     PROCEDURE BtnSalvarClick()
2121:         RETURN
2122:     ENDPROC
2123: 
2124:     *==========================================================================
2125:     * BTNCANCELARCLICK - Override no-op: form REPORT nao tem cancelar CRUD
2126:     *   Para relatorio, cancela equivale a limpar os filtros.
2127:     *==========================================================================
2128:     PROCEDURE BtnCancelarClick()
2129:         THIS.LimparCampos()
2130:     ENDPROC
2131: 
2132:     *==========================================================================
2133:     * FORMPARA BO - Alias para FormParaRelatorio (compatibilidade com FormBase)
2134:     *   FormBase pode chamar FormParaBO(); para relatorios isso equivale a
2135:     *   transferir os filtros da tela para o BO do relatorio.
2136:     *==========================================================================
2137:     PROTECTED PROCEDURE FormParaBO()
2138:         THIS.FormParaRelatorio()
2139:     ENDPROC
2140: 
2141:     *==========================================================================
2142:     * BOPARAFORM - Nao aplicavel para relatorios (dados fluem Form -> BO)
2143:     *   Override para evitar chamada de metodo inexistente em FormBase.
2144:     *==========================================================================
2145:     PROTECTED PROCEDURE BOParaForm()
2146:         RETURN
2147:     ENDPROC
2148: 
2149:     *==========================================================================
2150:     * HABILITARCAMPOS - Habilita/desabilita controles de filtro
2151:     *   Em formulario REPORT todos os campos de filtro ficam sempre habilitados.
2152:     *   O unico controle com habilitacao condicional e obj_4c_OpcImp (controlado
2153:     *   pelo OptFiltroInteractiveChange) e chk_4c_ChkSemVals (pelo ChkTpope).
2154:     *   Este metodo garante que os controles principais estejam habilitados.
2155:     *==========================================================================
2156:     PROCEDURE HabilitarCampos()
2157:         LOCAL loc_oPag
2158:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
2159:             RETURN
2160:         ENDIF
2161:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2162:         TRY
2163:             loc_oPag.txt_4c_DtInicial.Enabled        = .T.
2164:             loc_oPag.txt_4c_DtFinal.Enabled          = .T.
2165:             loc_oPag.obj_4c_OptNrPeriodo.Enabled     = .T.
2166:             loc_oPag.txt_4c__nm_operacao.Enabled     = .T.
2167:             loc_oPag.txt_4c_Numero.Enabled           = .T.
2168:             loc_oPag.txt_4c_CdTpOpe.Enabled         = .T.
2169:             loc_oPag.txt_4c_DsTpOpe.Enabled         = .T.
2170:             loc_oPag.txt_4c_CdEstoque.Enabled       = .T.
2171:             loc_oPag.txt_4c_DsEstoque.Enabled       = .T.
2172:             loc_oPag.txt_4c_CdVendedor.Enabled      = .T.
2173:             loc_oPag.txt_4c_DsVendedor.Enabled      = .T.
2174:             loc_oPag.txt_4c_Cidade.Enabled          = .T.
2175:             loc_oPag.txt_4c_Estado.Enabled          = .T.
2176:             loc_oPag.cbo_4c_Ordem1.Enabled          = .T.
2177:             loc_oPag.txt_4c_CdMoeda.Enabled         = .T.
2178:             loc_oPag.txt_4c_DsMoeda.Enabled         = .T.
2179:             loc_oPag.obj_4c_OptFiltro.Enabled       = .T.
2180:             loc_oPag.obj_4c_OptAnaSin.Enabled       = .T.
2181:             loc_oPag.chk_4c_ChkItens.Enabled        = .T.
2182:             loc_oPag.chk_4c_ChkTpope.Enabled        = .T.
2183:             loc_oPag.chk_4c_ChkIndus.Enabled        = .T.
2184:             loc_oPag.grd_4c_Operacoes.Enabled       = .T.
2185:             loc_oPag.cmg_4c_GradeS.Enabled          = .T.
2186:         CATCH TO loc_oErro
2187:             MsgErro(loc_oErro.Message, "HabilitarCampos")
2188:         ENDTRY
2189:     ENDPROC
2190: 
2191:     *==========================================================================
2192:     * CARREGARLISTA - Recarrega a lista de tipos de operacao no grid
2193:     *   Em formulario REPORT "lista" equivale ao grid de selecao de operacoes.
2194:     *   Chamado pelo FormBase quando necessario recarregar dados.
2195:     *==========================================================================
2196:     PROCEDURE CarregarLista()
2197:         IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
2198:             THIS.CarregarOperacoes()
2199:         ENDIF
2200:     ENDPROC
2201: 
2202:     *==========================================================================
2203:     * AJUSTARBOTOESPORMODO - Override: form REPORT nao tem modos CRUD
2204:     *   FormBase chama este metodo ao mudar de modo (INCLUIR/ALTERAR/etc.).
2205:     *   Para relatorio, os botoes de relatorio ficam sempre habilitados.
2206:     *==========================================================================
2207:     PROCEDURE AjustarBotoesPorModo()
2208:         IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
2209:             THIS.cmg_4c_Botoes.Enabled = .T.
2210:         ENDIF
2211:     ENDPROC
2212: 
2213: ENDDEFINE

