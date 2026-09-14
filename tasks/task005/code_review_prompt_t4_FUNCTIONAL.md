# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=7 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Top original=171 vs migrado 'cnt_4c_Botoes' Top=28 (diff=143px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Left original=959 vs migrado 'cnt_4c_Botoes' Left=542 (diff=417px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (5784 linhas total):

*-- Linhas 7 a 386:
7: *
8: * ESTRUTURA PILAR 1 (UX FIDELITY):
9: *   Page1 (Lista): Filtros + Grade (7 colunas) + Botoes CRUD + Saida
10: *   Page2 (Dados): OptionGroup-nav (7 botoes) + pgf_4c_DadosInternos (7 sub-paginas)
11: *                  + Salvar/Cancelar
12: * PILAR 2 (DB): SigCdPro, campos cpros/dpros/cbars/cgrus/ifors/reffs/etc.
13: * PILAR 3 (CODE): FormBase > FormProduto | ProdutoBO
14: *==============================================================================
15: 
16: DEFINE CLASS FormProduto AS FormBase
17: 
18:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY - Width=1000, Height=600 do legado)
19:     Height       = 600
20:     Width        = 1000
21:     Caption      = "Cadastro de Produtos"
22:     AutoCenter   = .T.
23:     ShowWindow   = 1
24:     WindowType   = 1
25:     ControlBox   = .F.
26:     Closable     = .F.
27:     MaxButton    = .F.
28:     TitleBar     = 0
29:     ClipControls = .F.
30:     Themes       = .F.
31:     BorderStyle  = 2
32: 
33:     *-- Propriedades do formulario
34:     this_oBusinessObject = .NULL.
35:     this_cMensagemErro   = ""      && OBRIGATORIO - nao herdado de FormBase
36:     this_cModoAtual      = "LISTA"
37:     this_lNovoRegistro   = .F.
38: 
39:     *--------------------------------------------------------------------------
40:     * Init - Inicializacao do formulario
41:     *--------------------------------------------------------------------------
42:     PROCEDURE Init()
43:         *-- DODEFAULT() ja chama InicializarForm() via FormBase.Init()
44:         RETURN DODEFAULT()
45:     ENDPROC
46: 
47:     *--------------------------------------------------------------------------
48:     * InicializarForm - Configuracao inicial: BO + estrutura visual
49:     *--------------------------------------------------------------------------
50:     PROTECTED PROCEDURE InicializarForm()
51:         LOCAL loc_lSucesso
52:         loc_lSucesso = .F.
53: 
54:         TRY
55:             THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")
56: 
57:             IF ISNULL(THIS.this_oBusinessObject)
58:                 MsgErro("Erro ao criar Business Object ProdutoBO", "Erro Cr" + CHR(237) + "tico")
59:             ELSE
60:                 THIS.ConfigurarPageFrame()
61:                 THIS.ConfigurarPaginaLista()
62:                 THIS.ConfigurarPaginaDados()
63: 
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
65: 
66:                 *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
67:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
68:                     IF !THIS.CarregarLista()
69:                         *-- Falha ao carregar nao impede abertura do formulario
70:                     ENDIF
71:                 ENDIF
72: 
73:                 THIS.pgf_4c_Paginas.Visible   = .T.
74:                 THIS.pgf_4c_Paginas.ActivePage = 1
75:                 THIS.this_cModoAtual           = "LISTA"
76:                 loc_lSucesso                   = .T.
77:             ENDIF
78: 
79:         CATCH TO loc_oErro
80:             MsgErro("Erro ao inicializar FormProduto:" + CHR(13) + ;
81:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
82:                 loc_oErro.Message, "Erro")
83:         ENDTRY
84: 
85:         RETURN loc_lSucesso
86:     ENDPROC
87: 
88:     *--------------------------------------------------------------------------
89:     * ConfigurarPageFrame - PageFrame principal (Top=-29 oculta abas)
90:     * Legado: Pagina Width=1003, Height=600, PageCount=2
91:     *--------------------------------------------------------------------------
92:     PROTECTED PROCEDURE ConfigurarPageFrame()
93:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
94: 
95:         WITH THIS.pgf_4c_Paginas
96:             .Top        = -29
97:             .Left       = 0
98:             .Width      = 1003
99:             .Height     = 600
100:             .PageCount  = 2
101:             .Tabs       = .F.
102:             .Visible    = .T.
103: 
104:             *-- Page1 - Lista
105:             .Page1.Caption   = "Lista"
106:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107:             .Page1.BackColor = RGB(255, 255, 255)
108: 
109:             *-- Page2 - Dados
110:             .Page2.Caption   = "Dados"
111:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:             .Page2.BackColor = RGB(255, 255, 255)
113:         ENDWITH
114:     ENDPROC
115: 
116:     *--------------------------------------------------------------------------
117:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, grid
118:     * Compensacao +29: Top legado -> Top migrado (+29px por PageFrame.Top=-29)
119:     * Grupo_op: Top=-1+29=28  | cntFiltros: Top=82+29=111 | Grade: Top=173+29=202
120:     *--------------------------------------------------------------------------
121:     PROTECTED PROCEDURE ConfigurarPaginaLista()
122:         LOCAL loc_oPagina
123:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
124: 
125:         *----------------------------------------------------------------------
126:         *-- Container cabecalho (novo padrao arquitetura - topo escuro)
127:         *----------------------------------------------------------------------
128:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
129:         WITH loc_oPagina.cnt_4c_Cabecalho
130:             .Top         = 29
131:             .Left        = 0
132:             .Width       = 1003
133:             .Height      = 80
134:             .BackStyle   = 1
135:             .BackColor   = RGB(53, 53, 53)
136:             .BorderWidth = 0
137:             .Visible     = .T.
138:         ENDWITH
139: 
140:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
141:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
142:             .Caption   = "Cadastro de Produtos"
143:             .Top       = 20
144:             .Left      = 20
145:             .Width     = 400
146:             .Height    = 30
147:             .FontName  = "Tahoma"
148:             .FontSize  = 14
149:             .FontBold  = .T.
150:             .BackStyle = 0
151:             .ForeColor = RGB(255, 255, 255)
152:             .Visible   = .T.
153:         ENDWITH
154: 
155:         *----------------------------------------------------------------------
156:         *-- Container botoes CRUD (Grupo_op: Left=542, Top=-1 -> 28)
157:         *----------------------------------------------------------------------
158:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
159:         WITH loc_oPagina.cnt_4c_Botoes
160:             .Top         = 28
161:             .Left        = 542
162:             .Width       = 390
163:             .Height      = 85
164:             .BackStyle = 1
165:             .BackColor = RGB(53, 53, 53)
166:             .BorderWidth = 0
167:             .Visible     = .T.
168:         ENDWITH
169: 
170:         *-- Botao Incluir (Inserir: Left=5)
171:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
172:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
173:             .Caption         = "Incluir"
174:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
175:             .PicturePosition = 13
176:             .Width           = 75
177:             .Height          = 75
178:             .Left            = 5
179:             .Top             = 5
180:             .FontName        = "Tahoma"
181:             .FontSize        = 8
182:             .Themes          = .F.
183:             .SpecialEffect   = 0
184:             .BackColor       = RGB(255, 255, 255)
185:             .ForeColor       = RGB(90, 90, 90)
186:             .Visible         = .T.
187:         ENDWITH
188:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
189: 
190:         *-- Botao Visualizar (Consultar: Left=80)
191:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
192:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
193:             .Caption         = "Visualizar"
194:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
195:             .PicturePosition = 13
196:             .Width           = 75
197:             .Height          = 75
198:             .Left            = 80
199:             .Top             = 5
200:             .FontName        = "Tahoma"
201:             .FontSize        = 8
202:             .Themes          = .F.
203:             .SpecialEffect   = 0
204:             .BackColor       = RGB(255, 255, 255)
205:             .ForeColor       = RGB(90, 90, 90)
206:             .Visible         = .T.
207:         ENDWITH
208:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
209: 
210:         *-- Botao Alterar (Left=155)
211:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
212:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
213:             .Caption         = "Alterar"
214:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
215:             .PicturePosition = 13
216:             .Width           = 75
217:             .Height          = 75
218:             .Left            = 155
219:             .Top             = 5
220:             .FontName        = "Tahoma"
221:             .FontSize        = 8
222:             .Themes          = .F.
223:             .SpecialEffect   = 0
224:             .BackColor       = RGB(255, 255, 255)
225:             .ForeColor       = RGB(90, 90, 90)
226:             .Visible         = .T.
227:         ENDWITH
228:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
229: 
230:         *-- Botao Excluir (Left=230)
231:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
232:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
233:             .Caption         = "Excluir"
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
235:             .PicturePosition = 13
236:             .Width           = 75
237:             .Height          = 75
238:             .Left            = 230
239:             .Top             = 5
240:             .FontName        = "Tahoma"
241:             .FontSize        = 8
242:             .Themes          = .F.
243:             .SpecialEffect   = 0
244:             .BackColor       = RGB(255, 255, 255)
245:             .ForeColor       = RGB(90, 90, 90)
246:             .Visible         = .T.
247:         ENDWITH
248:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
249: 
250:         *-- Botao Buscar (Procurar: Left=305)
251:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
252:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
253:             .Caption         = "Buscar"
254:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
255:             .PicturePosition = 13
256:             .Width           = 75
257:             .Height          = 75
258:             .Left            = 305
259:             .Top             = 5
260:             .FontName        = "Tahoma"
261:             .FontSize        = 8
262:             .Themes          = .F.
263:             .SpecialEffect   = 0
264:             .BackColor       = RGB(255, 255, 255)
265:             .ForeColor       = RGB(90, 90, 90)
266:             .Visible         = .T.
267:         ENDWITH
268:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
269: 
270:         *----------------------------------------------------------------------
271:         *-- Container saida (Grupo_Saida: Left=917, Top=-1 -> 28)
272:         *----------------------------------------------------------------------
273:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
274:         WITH loc_oPagina.cnt_4c_Saida
275:             .Top         = 28
276:             .Left        = 917
277:             .Width       = 90
278:             .Height      = 85
279:             .BackStyle = 1
280:             .BackColor = RGB(53, 53, 53)
281:             .BorderWidth = 0
282:             .Visible     = .T.
283:         ENDWITH
284: 
285:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
286:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
287:             .Caption         = "Encerrar"
288:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
289:             .PicturePosition = 13
290:             .Width           = 75
291:             .Height          = 75
292:             .Left            = 5
293:             .Top             = 5
294:             .FontName        = "Tahoma"
295:             .FontSize        = 8
296:             .Themes          = .F.
297:             .SpecialEffect   = 0
298:             .BackColor       = RGB(255, 255, 255)
299:             .ForeColor       = RGB(90, 90, 90)
300:             .Visible         = .T.
301:         ENDWITH
302:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
303: 
304:         *----------------------------------------------------------------------
305:         *-- Container filtros (cntFiltros: Top=82+29=111, Left=0, W=383, H=87)
306:         *-- Conteudo: lblGrupo, getCgru, getDgru, lblData1, getDtIni, lblData2, getDtFim, optFilSituas
307:         *----------------------------------------------------------------------
308:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
309:         WITH loc_oPagina.cnt_4c_Filtros
310:             .Top         = 111
311:             .Left        = 0
312:             .Width       = 383
313:             .Height      = 87
314:             .BackStyle   = 0
315:             .BorderWidth = 0
316:             .Visible     = .T.
317:         ENDWITH
318: 
319:         *-- Label "Grupo de Produto :" (lblGrupo: Top=18, Left=21, W=94)
320:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblGrupo", "Label")
321:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblGrupo
322:             .Caption   = "Grupo de Produto :"
323:             .Top       = 18
324:             .Left      = 21
325:             .Width     = 94
326:             .Height    = 15
327:             .FontName  = "Tahoma"
328:             .FontSize  = 8
329:             .BackStyle = 0
330:             .Visible   = .T.
331:         ENDWITH
332: 
333:         *-- Codigo grupo (getCgru: Top=14, Left=116, W=31, H=23) + F4 abre lookup
334:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Cgru", "TextBox")
335:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru
336:             .Value    = ""
337:             .Top      = 14
338:             .Left     = 116
339:             .Width    = 31
340:             .Height   = 23
341:             .FontName = "Tahoma"
342:             .FontSize = 8
343:             .Themes   = .F.
344:             .Visible  = .T.
345:         ENDWITH
346:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru, "KeyPress", THIS, "FiltroGrupoKeyPress")
347: 
348:         *-- Descricao grupo (getDgru: Top=14, Left=149, W=148, H=23 - somente leitura)
349:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Dgru", "TextBox")
350:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru
351:             .Value     = ""
352:             .Top       = 14
353:             .Left      = 149
354:             .Width     = 148
355:             .Height    = 23
356:             .FontName  = "Tahoma"
357:             .FontSize  = 8
358:             .ReadOnly  = .T.
359:             .Themes    = .F.
360:             .BackColor = RGB(240, 240, 240)
361:             .Visible   = .T.
362:         ENDWITH
363: 
364:         *-- Label "Ult. Alteracao :" (lblData1: Top=43, Left=28, W=87)
365:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData1", "Label")
366:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData1
367:             .Caption   = CHR(218) + "lt. Altera" + CHR(231) + CHR(227) + "o :"
368:             .Top       = 43
369:             .Left      = 28
370:             .Width     = 87
371:             .Height    = 15
372:             .FontName  = "Tahoma"
373:             .FontSize  = 8
374:             .BackStyle = 0
375:             .Visible   = .T.
376:         ENDWITH
377: 
378:         *-- Data inicial (getDtIni: Top=39, Left=116, W=80, H=23)
379:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtIni", "TextBox")
380:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtIni
381:             .Value    = {^1900-01-01}
382:             .Format   = "D"
383:             .Top      = 39
384:             .Left     = 116
385:             .Width    = 80
386:             .Height   = 23

*-- Linhas 419 a 535:
419:             .Visible  = .T.
420:         ENDWITH
421: 
422:         *-- OptionGroup situacao (optFilSituas: Top=19, Left=303, W=78, H=46, ButtonCount=3)
423:         *-- Value=1 Todos, 2 Ativos (Situas=1), 3 Inativos (Situas=2)
424:         loc_oPagina.cnt_4c_Filtros.AddObject("obj_4c_Situa", "OptionGroup")
425:         WITH loc_oPagina.cnt_4c_Filtros.obj_4c_Situa
426:             .ButtonCount = 3
427:             .BorderStyle = 0
428:             .Value       = 1
429:             .Top         = 19
430:             .Left        = 303
431:             .Width       = 78
432:             .Height      = 46
433:             .AutoSize    = .F.
434: 
435:             WITH .Buttons(1)
436:                 .Caption   = "Todos"
437:                 .Left      = 2
438:                 .Top       = 2
439:                 .Width     = 74
440:                 .Height    = 14
441:                 .Themes    = .F.
442:                 .Visible   = .T.
443:             ENDWITH
444: 
445:             WITH .Buttons(2)
446:                 .Caption   = "Ativos"
447:                 .Left      = 2
448:                 .Top       = 17
449:                 .Width     = 74
450:                 .Height    = 14
451:                 .FontName  = "Tahoma"
452:                 .FontSize  = 8
453:                 .Themes    = .F.
454:                 .Visible   = .T.
455:             ENDWITH
456: 
457:             WITH .Buttons(3)
458:                 .Caption   = "Inativos"
459:                 .Left      = 2
460:                 .Top       = 32
461:                 .Width     = 74
462:                 .Height    = 14
463:                 .FontName  = "Tahoma"
464:                 .FontSize  = 8
465:                 .Themes    = .F.
466:                 .Visible   = .T.
467:             ENDWITH
468:         ENDWITH
469:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.obj_4c_Situa, "InteractiveChange", THIS, "FiltroSituaChange")
470: 
471:         *----------------------------------------------------------------------
472:         *-- Grid lista principal (Grade: Top=173+29=202, Left=38, W=922, H=409)
473:         *-- 7 colunas: cpros, dpros, cgrus, subgru, reffs, usuario, inativo(chk)
474:         *-- Conteudo detalhado (colunas, ControlSource): FASE 4
475:         *----------------------------------------------------------------------
476:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
477:         WITH loc_oPagina.grd_4c_Lista
478:             .Top             = 202
479:             .Left            = 38
480:             .Width           = 922
481:             .Height          = 409
482:             .FontName        = "Tahoma"
483:             .FontSize        = 8
484:             .GridLines       = 1
485:             .GridLineColor   = RGB(200, 200, 200)
486:             .HeaderHeight    = 23
487:             .RowHeight       = 20
488:             .DeleteMark      = .F.
489:             .RecordMark      = .F.
490:             .Themes          = .F.
491:             .ReadOnly        = .T.
492:             .ColumnCount     = 0
493:             .Visible         = .T.
494:         ENDWITH
495:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GrdListaDblClick")
496: 
497:         *-- Criar cursor placeholder ANTES do RecordSource (evita auto-bind errado)
498:         *-- Campos: cpros, dpros, cgrus, sgrus, reffs, colecoes, ImpEtiqs(L), Situas(N)
499:         IF USED("cursor_4c_Lista")
500:             USE IN cursor_4c_Lista
501:         ENDIF
502:         SET NULL ON
503:         CREATE CURSOR cursor_4c_Lista ;
504:             (cpros C(25), dpros C(80), cgrus C(5), sgrus C(5), ;
505:              reffs C(25), colecoes C(20), ImpEtiqs L, Situas N(1,0))
506:         SET NULL OFF
507: 
508:         *-- RecordSource + ColumnCount OBRIGATORIAMENTE FORA do WITH (regra VFP9)
509:         LOCAL loc_oGrid
510:         loc_oGrid = loc_oPagina.grd_4c_Lista
511:         loc_oGrid.RecordSource = "cursor_4c_Lista"
512:         loc_oGrid.ColumnCount  = 7
513: 
514:         *-- Re-definir ControlSource de TODAS as colunas apos RecordSource (GRID-AUTOBIND)
515:         *-- VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior
516:         loc_oGrid.Column1.ControlSource = "cursor_4c_Lista.cpros"
517:         loc_oGrid.Column2.ControlSource = "cursor_4c_Lista.dpros"
518:         loc_oGrid.Column3.ControlSource = "cursor_4c_Lista.cgrus"
519:         loc_oGrid.Column4.ControlSource = "cursor_4c_Lista.sgrus"
520:         loc_oGrid.Column5.ControlSource = "cursor_4c_Lista.reffs"
521:         loc_oGrid.Column6.ControlSource = "cursor_4c_Lista.colecoes"
522:         *-- Column7 (CheckBox): ControlSource definido apos AddObject/CurrentControl abaixo
523: 
524:         *-- Coluna 1: Produto (CPros) - 100px
525:         WITH loc_oGrid.Column1
526:             .ControlSource   = "cursor_4c_Lista.cpros"
527:             .Width           = 100
528:             .ReadOnly        = .T.
529:             .Header1.Caption = "Produto"
530:             .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
531:         ENDWITH
532: 
533:         *-- Coluna 2: Descricao (DPros) - 305px
534:         WITH loc_oGrid.Column2
535:             .ControlSource   = "cursor_4c_Lista.dpros"

*-- Linhas 605 a 666:
605:             .Visible   = .T.
606:         ENDWITH
607: 
608:         THIS.TornarControlesVisiveis(loc_oPagina)
609:     ENDPROC
610: 
611:     *--------------------------------------------------------------------------
612:     * ConfigurarPaginaDados - Page2: OptionGroup-nav + pgf_4c_DadosInternos (7pp)
613:     *                         + Salvar/Cancelar
614:     * Compensacao +29 aplicada: Top legado -> Top migrado
615:     * Optiongroup1: Top=5+29=34 | Grupo_Salva: Top=5+29=34, Left=842
616:     * pgframeDados: Top=-54+29=-25, Left=-1, W=1003, H=656, PageCount=7
617:     *--------------------------------------------------------------------------
618:     PROTECTED PROCEDURE ConfigurarPaginaDados()
619:         LOCAL loc_oPagina
620:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
621: 
622:         *----------------------------------------------------------------------
623:         *-- OptionGroup de navegacao entre sub-paginas
624:         *-- Optiongroup1: Left=5, Top=5+29=34, Width=535, Height=85, ButtonCount=7
625:         *----------------------------------------------------------------------
626:         loc_oPagina.AddObject("obj_4c_NavegacaoDados", "OptionGroup")
627:         WITH loc_oPagina.obj_4c_NavegacaoDados
628:             .ButtonCount   = 7
629:             .AutoSize      = .T.
630:             .BorderStyle   = 0
631:             .Value         = 1
632:             .Top           = 34
633:             .Left          = 5
634:             .Width         = 535
635:             .Height        = 85
636: 
637:             *-- Option 1: Principal (optDados)
638:             WITH .Buttons(1)
639:                 .Caption       = "\<Principal"
640:                 .Picture       = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
641:                 .Height        = 75
642:                 .Width         = 75
643:                 .Left          = 5
644:                 .Top           = 5
645:                 .Style         = 1
646:                 .SpecialEffect = 0
647:                 .FontBold      = .T.
648:                 .FontItalic    = .T.
649:                 .ForeColor     = RGB(90, 90, 90)
650:                 .BackColor     = RGB(255, 255, 255)
651:                 .Themes        = .F.
652:                 .AutoSize      = .F.
653:                 .Visible       = .T.
654:             ENDWITH
655: 
656:             *-- Option 2: Componente (optComposicao) -> pgComposicao (PageOrder=2)
657:             WITH .Buttons(2)
658:                 .Caption       = "Componen\<te"
659:                 .Picture       = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
660:                 .Height        = 75
661:                 .Width         = 75
662:                 .Left          = 80
663:                 .Top           = 5
664:                 .Style         = 1
665:                 .SpecialEffect = 0
666:                 .FontBold      = .T.

*-- Linhas 779 a 877:
779:                 .Visible       = .T.
780:             ENDWITH
781:         ENDWITH
782:         BINDEVENT(loc_oPagina.obj_4c_NavegacaoDados, "InteractiveChange", THIS, "NavegacaoDadosChange")
783: 
784:         *----------------------------------------------------------------------
785:         *-- Container botoes Salvar/Cancelar
786:         *-- Grupo_Salva: Left=842, Top=5+29=34, Width=165, Height=85
787:         *----------------------------------------------------------------------
788:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
789:         WITH loc_oPagina.cnt_4c_Salva
790:             .Top         = 34
791:             .Left        = 842
792:             .Width       = 165
793:             .Height      = 85
794:             .BackStyle   = 0
795:             .BorderWidth = 0
796:             .Visible     = .T.
797:         ENDWITH
798: 
799:         *-- Botao Confirmar/Salvar (Salva: Left=5)
800:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
801:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
802:             .Caption         = "Confirmar"
803:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
804:             .PicturePosition = 13
805:             .Width           = 75
806:             .Height          = 75
807:             .Left            = 5
808:             .Top             = 5
809:             .FontName        = "Tahoma"
810:             .FontSize        = 8
811:             .Themes          = .F.
812:             .SpecialEffect   = 0
813:             .BackColor       = RGB(255, 255, 255)
814:             .ForeColor       = RGB(90, 90, 90)
815:             .Visible         = .T.
816:         ENDWITH
817:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
818: 
819:         *-- Botao Cancelar (Left=80)
820:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
821:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
822:             .Caption         = "Cancelar"
823:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
824:             .PicturePosition = 13
825:             .Width           = 75
826:             .Height          = 75
827:             .Left            = 80
828:             .Top             = 5
829:             .FontName        = "Tahoma"
830:             .FontSize        = 8
831:             .Themes          = .F.
832:             .SpecialEffect   = 0
833:             .BackColor       = RGB(255, 255, 255)
834:             .ForeColor       = RGB(90, 90, 90)
835:             .Visible         = .T.
836:         ENDWITH
837:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
838: 
839:         *----------------------------------------------------------------------
840:         *-- PageFrame interno com 7 sub-paginas (pgframeDados migrado)
841:         *-- Top=-54+29=-25, Left=-1, Width=1003, Height=656, PageCount=7
842:         *-- Tabs posicionados acima da area visivel; nav via obj_4c_NavegacaoDados
843:         *----------------------------------------------------------------------
844:         loc_oPagina.AddObject("pgf_4c_DadosInternos", "PageFrame")
845:         WITH loc_oPagina.pgf_4c_DadosInternos
846:             .Top        = -25
847:             .Left       = -1
848:             .Width      = 1003
849:             .Height     = 656
850:             .PageCount  = 7
851:             .Tabs       = .T.
852:             .Visible    = .T.
853: 
854:             *-- Page1: Dados Principais (pgDados - PageOrder=1)
855:             .Page1.Caption   = "Dados Principais"
856:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
857:             .Page1.BackColor = RGB(255, 255, 255)
858:             .Page1.FontBold  = .T.
859:             .Page1.ForeColor = RGB(36, 84, 155)
860: 
861:             *-- Page2: Custos - nome pgComposicao no legado (PageOrder=2)
862:             .Page2.Caption   = "Custos"
863:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
864:             .Page2.BackColor = RGB(255, 255, 255)
865:             .Page2.FontBold  = .T.
866:             .Page2.FontName  = "Verdana"
867:             .Page2.FontSize  = 8
868:             .Page2.ForeColor = RGB(36, 84, 155)
869: 
870:             *-- Page3: Dados Fiscais (pgDadosFiscais - PageOrder=3)
871:             .Page3.Caption   = "Dados Fiscais"
872:             .Page3.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
873:             .Page3.BackColor = RGB(255, 255, 255)
874:             .Page3.FontBold  = .T.
875:             .Page3.FontName  = "Verdana"
876:             .Page3.FontSize  = 8
877:             .Page3.ForeColor = RGB(36, 84, 155)

*-- Linhas 912 a 1015:
912: 
913:         THIS.ConfigurarPgDados1()
914:         THIS.ConfigurarPgDados1b()
915:         THIS.TornarControlesVisiveis(loc_oPagina)
916:     ENDPROC
917: 
918:     *--------------------------------------------------------------------------
919:     * ConfigurarPgDados1 - Page1 dos Dados Internos (pgDados) - Parte 1/2
920:     * Campos: identificacao, grupos, fornecedor, codigos, status, EAN, Cor, Tam
921:     * Top values: FROM layout.json AS-IS (sem compensacao - pageframe interno)
922:     *--------------------------------------------------------------------------
923:     PROTECTED PROCEDURE ConfigurarPgDados1()
924:         LOCAL loc_oPg1
925:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
926: 
927:         *----------------------------------------------------------------------
928:         *-- ROW 1 (Top=130): Produto + Descricao + Status + DtSituas
929:         *----------------------------------------------------------------------
930:         *-- Label "Produto:" (top=134, left=58, w=53)
931:         loc_oPg1.AddObject("lbl_4c_LblProduto", "Label")
932:         WITH loc_oPg1.lbl_4c_LblProduto
933:             .Caption   = "Produto :"
934:             .Top       = 134
935:             .Left      = 58
936:             .Width     = 53
937:             .Height    = 15
938:             .FontName  = "Tahoma"
939:             .FontSize  = 8
940:             .BackStyle = 0
941:             .Visible   = .T.
942:         ENDWITH
943: 
944:         *-- getCpro -> txt_4c_Cpro (top=130, left=113, w=108, h=23)
945:         loc_oPg1.AddObject("txt_4c_Cpro", "TextBox")
946:         WITH loc_oPg1.txt_4c_Cpro
947:             .Value    = ""
948:             .Top      = 130
949:             .Left     = 113
950:             .Width    = 108
951:             .Height   = 23
952:             .FontName = "Tahoma"
953:             .FontSize = 8
954:             .Themes   = .F.
955:             .Visible  = .T.
956:         ENDWITH
957:         BINDEVENT(loc_oPg1.txt_4c_Cpro, "KeyPress", THIS, "DadosCproKeyPress")
958: 
959:         *-- getDpro -> txt_4c_Dpro (top=130, left=222, w=290, h=23)
960:         loc_oPg1.AddObject("txt_4c_Dpro", "TextBox")
961:         WITH loc_oPg1.txt_4c_Dpro
962:             .Value    = ""
963:             .Top      = 130
964:             .Left     = 222
965:             .Width    = 290
966:             .Height   = 23
967:             .FontName = "Tahoma"
968:             .FontSize = 8
969:             .Themes   = .F.
970:             .Visible  = .T.
971:         ENDWITH
972: 
973:         *-- opc_situacao -> obj_4c_OpcSituacao (top=130, left=735, w=142, h=25)
974:         *-- Situas: 1=Ativo, 2=Inativo
975:         loc_oPg1.AddObject("obj_4c_OpcSituacao", "OptionGroup")
976:         WITH loc_oPg1.obj_4c_OpcSituacao
977:             .ButtonCount = 2
978:             .BorderStyle = 0
979:             .Value       = 1
980:             .Top         = 130
981:             .Left        = 735
982:             .Width       = 142
983:             .Height      = 25
984:             WITH .Buttons(1)
985:                 .Caption  = "Ativo"
986:                 .Left     = 2
987:                 .Top      = 4
988:                 .Width    = 55
989:                 .Height   = 14
990:                 .Themes   = .F.
991:                 .Visible  = .T.
992:             ENDWITH
993:             WITH .Buttons(2)
994:                 .Caption  = "Inativo"
995:                 .Left     = 60
996:                 .Top      = 4
997:                 .Width    = 75
998:                 .Height   = 14
999:                 .FontName = "Tahoma"
1000:                 .FontSize = 8
1001:                 .Themes   = .F.
1002:                 .Visible  = .T.
1003:             ENDWITH
1004:         ENDWITH
1005: 
1006:         *-- getDtSituas -> txt_4c_DtSituas (top=132, left=878, w=80, h=21) - data do status
1007:         loc_oPg1.AddObject("txt_4c_DtSituas", "TextBox")
1008:         WITH loc_oPg1.txt_4c_DtSituas
1009:             .Value     = {^2000-01-01}
1010:             .Format    = "D"
1011:             .Top       = 132
1012:             .Left      = 878
1013:             .Width     = 80
1014:             .Height    = 21
1015:             .FontName  = "Tahoma"

*-- Linhas 1078 a 1121:
1078:             .Themes   = .F.
1079:             .Visible  = .T.
1080:         ENDWITH
1081:         BINDEVENT(loc_oPg1.txt_4c_CProEq, "KeyPress", THIS, "DadosCProEqKeyPress")
1082: 
1083:         *-- Label "Barra:" (top=157, left=590, w=35)
1084:         loc_oPg1.AddObject("lbl_4c_LblCbar", "Label")
1085:         WITH loc_oPg1.lbl_4c_LblCbar
1086:             .Caption   = "Barra :"
1087:             .Top       = 157
1088:             .Left      = 590
1089:             .Width     = 35
1090:             .Height    = 15
1091:             .FontName  = "Tahoma"
1092:             .FontSize  = 8
1093:             .BackStyle = 0
1094:             .Visible   = .T.
1095:         ENDWITH
1096: 
1097:         *-- getCbar -> txt_4c_Cbar (top=155, left=626, w=108, h=21) - numeric
1098:         loc_oPg1.AddObject("txt_4c_Cbar", "TextBox")
1099:         WITH loc_oPg1.txt_4c_Cbar
1100:             .Value    = 0
1101:             .Top      = 155
1102:             .Left     = 626
1103:             .Width    = 108
1104:             .Height   = 21
1105:             .FontName = "Tahoma"
1106:             .FontSize = 8
1107:             .Themes   = .F.
1108:             .Visible  = .T.
1109:         ENDWITH
1110: 
1111:         *-- Label "Lote M" + CHR(237) + "nimo:" (top=157, left=812, w=65)
1112:         loc_oPg1.AddObject("lbl_4c_LblLtMins", "Label")
1113:         WITH loc_oPg1.lbl_4c_LblLtMins
1114:             .Caption   = "Lote M" + CHR(237) + "nimo :"
1115:             .Top       = 157
1116:             .Left      = 812
1117:             .Width     = 65
1118:             .Height    = 15
1119:             .FontName  = "Tahoma"
1120:             .FontSize  = 8
1121:             .BackStyle = 0

*-- Linhas 1166 a 1209:
1166:             .Themes   = .F.
1167:             .Visible  = .T.
1168:         ENDWITH
1169:         BINDEVENT(loc_oPg1.txt_4c_Cgru, "KeyPress", THIS, "DadosCgruKeyPress")
1170: 
1171:         *-- getDgru -> txt_4c_Dgru (top=178, left=145, w=171, h=23) - somente leitura
1172:         loc_oPg1.AddObject("txt_4c_Dgru", "TextBox")
1173:         WITH loc_oPg1.txt_4c_Dgru
1174:             .Value     = ""
1175:             .Top       = 178
1176:             .Left      = 145
1177:             .Width     = 171
1178:             .Height    = 23
1179:             .FontName  = "Tahoma"
1180:             .FontSize  = 8
1181:             .ReadOnly  = .T.
1182:             .BackColor = RGB(240, 240, 240)
1183:             .Themes    = .F.
1184:             .Visible   = .T.
1185:         ENDWITH
1186: 
1187:         *-- getMerc -> txt_4c_Merc (top=178, left=318, w=31, h=23) - no label in layout
1188:         loc_oPg1.AddObject("txt_4c_Merc", "TextBox")
1189:         WITH loc_oPg1.txt_4c_Merc
1190:             .Value    = ""
1191:             .Top      = 178
1192:             .Left     = 318
1193:             .Width    = 31
1194:             .Height   = 23
1195:             .FontName = "Tahoma"
1196:             .FontSize = 8
1197:             .Themes   = .F.
1198:             .Visible  = .T.
1199:         ENDWITH
1200: 
1201:         *-- Label "Identificador:" (top=182, left=408, w=70)
1202:         loc_oPg1.AddObject("lbl_4c_LblIdeCPros", "Label")
1203:         WITH loc_oPg1.lbl_4c_LblIdeCPros
1204:             .Caption   = "Identificador :"
1205:             .Top       = 182
1206:             .Left      = 408
1207:             .Width     = 70
1208:             .Height    = 15
1209:             .FontName  = "Tahoma"

*-- Linhas 1270 a 1313:
1270: 
1271:         *-- Fwoption1 -> obj_4c_ProdWeb (top=172, left=879, w=117, h=42, 4 botoes)
1272:         *-- Varias field mapeado: 0=Nenhum, 1=Sim, 2=Nao, 3=Destaque
1273:         loc_oPg1.AddObject("obj_4c_ProdWeb", "OptionGroup")
1274:         WITH loc_oPg1.obj_4c_ProdWeb
1275:             .ButtonCount = 4
1276:             .BorderStyle = 0
1277:             .Value       = 1
1278:             .Top         = 172
1279:             .Left        = 879
1280:             .Width       = 117
1281:             .Height      = 42
1282:             WITH .Buttons(1)
1283:                 .Caption  = "Nenhum"
1284:                 .Left     = 2
1285:                 .Top      = 2
1286:                 .Width    = 55
1287:                 .Height   = 14
1288:                 .Themes   = .F.
1289:                 .Visible  = .T.
1290:             ENDWITH
1291:             WITH .Buttons(2)
1292:                 .Caption  = "Sim"
1293:                 .Left     = 60
1294:                 .Top      = 2
1295:                 .Width    = 55
1296:                 .Height   = 14
1297:                 .FontName = "Tahoma"
1298:                 .FontSize = 8
1299:                 .Themes   = .F.
1300:                 .Visible  = .T.
1301:             ENDWITH
1302:             WITH .Buttons(3)
1303:                 .Caption  = "N" + CHR(227) + "o"
1304:                 .Left     = 2
1305:                 .Top      = 18
1306:                 .Width    = 55
1307:                 .Height   = 14
1308:                 .FontName = "Tahoma"
1309:                 .FontSize = 8
1310:                 .Themes   = .F.
1311:                 .Visible  = .T.
1312:             ENDWITH
1313:             WITH .Buttons(4)

*-- Linhas 1387 a 1430:
1387: 
1388:         *-- Fwoption2 -> obj_4c_Variacao (top=203, left=874, w=107, h=22, 2 botoes)
1389:         *-- 0=Nenhum / 1=Cor-Tam (mapeado em Varias de SigCdPro)
1390:         loc_oPg1.AddObject("obj_4c_Variacao", "OptionGroup")
1391:         WITH loc_oPg1.obj_4c_Variacao
1392:             .ButtonCount = 2
1393:             .BorderStyle = 0
1394:             .Value       = 1
1395:             .Top         = 203
1396:             .Left        = 874
1397:             .Width       = 107
1398:             .Height      = 22
1399:             WITH .Buttons(1)
1400:                 .Caption  = "Nenhum"
1401:                 .Left     = 2
1402:                 .Top      = 4
1403:                 .Width    = 50
1404:                 .Height   = 14
1405:                 .Themes   = .F.
1406:                 .Visible  = .T.
1407:             ENDWITH
1408:             WITH .Buttons(2)
1409:                 .Caption  = "Cor-Tam"
1410:                 .Left     = 55
1411:                 .Top      = 4
1412:                 .Width    = 50
1413:                 .Height   = 14
1414:                 .FontName = "Tahoma"
1415:                 .FontSize = 8
1416:                 .Themes   = .F.
1417:                 .Visible  = .T.
1418:             ENDWITH
1419:         ENDWITH
1420: 
1421:         *----------------------------------------------------------------------
1422:         *-- ROW 5 (Top=226): Linha + QtPed + Garantia + ChkGarVit
1423:         *----------------------------------------------------------------------
1424:         *-- Label "Linha:" (top=230, left=77, w=34)
1425:         loc_oPg1.AddObject("lbl_4c_LblLin", "Label")
1426:         WITH loc_oPg1.lbl_4c_LblLin
1427:             .Caption   = "Linha :"
1428:             .Top       = 230
1429:             .Left      = 77
1430:             .Width     = 34

*-- Linhas 1448 a 1491:
1448:             .Themes   = .F.
1449:             .Visible  = .T.
1450:         ENDWITH
1451:         BINDEVENT(loc_oPg1.txt_4c_Lin, "KeyPress", THIS, "DadosLinKeyPress")
1452: 
1453:         *-- GetDLin -> txt_4c_DLin (top=226, left=194, w=318, h=23) - somente leitura
1454:         loc_oPg1.AddObject("txt_4c_DLin", "TextBox")
1455:         WITH loc_oPg1.txt_4c_DLin
1456:             .Value     = ""
1457:             .Top       = 226
1458:             .Left      = 194
1459:             .Width     = 318
1460:             .Height    = 23
1461:             .FontName  = "Tahoma"
1462:             .FontSize  = 8
1463:             .ReadOnly  = .T.
1464:             .BackColor = RGB(240, 240, 240)
1465:             .Themes    = .F.
1466:             .Visible   = .T.
1467:         ENDWITH
1468: 
1469:         *-- Label "Garantia:" (top=228, left=827, w=50)
1470:         loc_oPg1.AddObject("lbl_4c_LblDiasGar", "Label")
1471:         WITH loc_oPg1.lbl_4c_LblDiasGar
1472:             .Caption   = "Garantia :"
1473:             .Top       = 228
1474:             .Left      = 827
1475:             .Width     = 50
1476:             .Height    = 15
1477:             .FontName  = "Tahoma"
1478:             .FontSize  = 8
1479:             .BackStyle = 0
1480:             .Visible   = .T.
1481:         ENDWITH
1482: 
1483:         *-- getDiasGar -> txt_4c_DiasGar (top=224, left=880, w=34, h=21)
1484:         loc_oPg1.AddObject("txt_4c_DiasGar", "TextBox")
1485:         WITH loc_oPg1.txt_4c_DiasGar
1486:             .Value    = 0
1487:             .Top      = 224
1488:             .Left     = 880
1489:             .Width    = 34
1490:             .Height   = 21
1491:             .FontName = "Tahoma"

*-- Linhas 1554 a 1597:
1554:             .Themes   = .F.
1555:             .Visible  = .T.
1556:         ENDWITH
1557:         BINDEVENT(loc_oPg1.txt_4c_Col, "KeyPress", THIS, "DadosColKeyPress")
1558: 
1559:         *-- GetDCol -> txt_4c_DCol (top=250, left=194, w=318, h=23) - somente leitura
1560:         loc_oPg1.AddObject("txt_4c_DCol", "TextBox")
1561:         WITH loc_oPg1.txt_4c_DCol
1562:             .Value     = ""
1563:             .Top       = 250
1564:             .Left      = 194
1565:             .Width     = 318
1566:             .Height    = 23
1567:             .FontName  = "Tahoma"
1568:             .FontSize  = 8
1569:             .ReadOnly  = .T.
1570:             .BackColor = RGB(240, 240, 240)
1571:             .Themes    = .F.
1572:             .Visible   = .T.
1573:         ENDWITH
1574: 
1575:         *-- Label "Obs. Componente:" (top=247, left=529, w=96)
1576:         loc_oPg1.AddObject("lbl_4c_LblObsComp", "Label")
1577:         WITH loc_oPg1.lbl_4c_LblObsComp
1578:             .Caption   = "Obs. Componente :"
1579:             .Top       = 247
1580:             .Left      = 529
1581:             .Width     = 96
1582:             .Height    = 15
1583:             .FontName  = "Tahoma"
1584:             .FontSize  = 8
1585:             .BackStyle = 0
1586:             .Visible   = .T.
1587:         ENDWITH
1588: 
1589:         *-- GetObs3 -> txt_4c_Obs3 (top=243, left=626, w=80, h=21) -> obsetqs
1590:         loc_oPg1.AddObject("txt_4c_Obs3", "TextBox")
1591:         WITH loc_oPg1.txt_4c_Obs3
1592:             .Value    = ""
1593:             .Top      = 243
1594:             .Left     = 626
1595:             .Width    = 80
1596:             .Height   = 21
1597:             .FontName = "Tahoma"

*-- Linhas 1630 a 1673:
1630:             .Themes   = .F.
1631:             .Visible  = .T.
1632:         ENDWITH
1633:         BINDEVENT(loc_oPg1.txt_4c_Ifor, "KeyPress", THIS, "DadosIforKeyPress")
1634: 
1635:         *-- getDfor -> txt_4c_Dfor (top=274, left=194, w=318, h=23) - somente leitura
1636:         loc_oPg1.AddObject("txt_4c_Dfor", "TextBox")
1637:         WITH loc_oPg1.txt_4c_Dfor
1638:             .Value     = ""
1639:             .Top       = 274
1640:             .Left      = 194
1641:             .Width     = 318
1642:             .Height    = 23
1643:             .FontName  = "Tahoma"
1644:             .FontSize  = 8
1645:             .ReadOnly  = .T.
1646:             .BackColor = RGB(240, 240, 240)
1647:             .Themes    = .F.
1648:             .Visible   = .T.
1649:         ENDWITH
1650: 
1651:         *-- Label "Observacao:" (top=269, left=558, w=67)
1652:         loc_oPg1.AddObject("lbl_4c_LblObs1", "Label")
1653:         WITH loc_oPg1.lbl_4c_LblObs1
1654:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
1655:             .Top       = 269
1656:             .Left      = 558
1657:             .Width     = 67
1658:             .Height    = 15
1659:             .FontName  = "Tahoma"
1660:             .FontSize  = 8
1661:             .BackStyle = 0
1662:             .Visible   = .T.
1663:         ENDWITH
1664: 
1665:         *-- getObs1 -> txt_4c_Obs1 (top=265, left=626, w=220, h=21) -> obspeds
1666:         loc_oPg1.AddObject("txt_4c_Obs1", "TextBox")
1667:         WITH loc_oPg1.txt_4c_Obs1
1668:             .Value    = ""
1669:             .Top      = 265
1670:             .Left     = 626
1671:             .Width    = 220
1672:             .Height   = 21
1673:             .FontName = "Tahoma"

*-- Linhas 1762 a 1938:
1762:             .Themes   = .F.
1763:             .Visible  = .T.
1764:         ENDWITH
1765:         BINDEVENT(loc_oPg1.txt_4c_Cor, "KeyPress", THIS, "DadosCorKeyPress")
1766: 
1767:         *-- Label "Tam:" (top=302, left=442)
1768:         loc_oPg1.AddObject("lbl_4c_LblTam", "Label")
1769:         WITH loc_oPg1.lbl_4c_LblTam
1770:             .Caption   = "Tam:"
1771:             .Top       = 302
1772:             .Left      = 442
1773:             .Width     = 30
1774:             .Height    = 15
1775:             .FontName  = "Tahoma"
1776:             .FontSize  = 8
1777:             .BackStyle = 0
1778:             .Visible   = .T.
1779:         ENDWITH
1780: 
1781:         *-- getTam -> txt_4c_Tam (top=298, left=474, w=38) -> codtams
1782:         loc_oPg1.AddObject("txt_4c_Tam", "TextBox")
1783:         WITH loc_oPg1.txt_4c_Tam
1784:             .Value    = ""
1785:             .Top      = 298
1786:             .Left     = 474
1787:             .Width    = 38
1788:             .Height   = 23
1789:             .FontName = "Tahoma"
1790:             .FontSize = 8
1791:             .Themes   = .F.
1792:             .Visible  = .T.
1793:         ENDWITH
1794:         BINDEVENT(loc_oPg1.txt_4c_Tam, "KeyPress", THIS, "DadosTamKeyPress")
1795: 
1796:         *----------------------------------------------------------------------
1797:         *-- ROW 9 (Top=322): Modelo (getCodFinP)
1798:         *----------------------------------------------------------------------
1799:         *-- Label "Modelo:" (top=326, left=7, w=104)
1800:         loc_oPg1.AddObject("lbl_4c_LblModelo", "Label")
1801:         WITH loc_oPg1.lbl_4c_LblModelo
1802:             .Caption   = "Modelo :"
1803:             .Top       = 326
1804:             .Left      = 7
1805:             .Width     = 104
1806:             .Height    = 15
1807:             .FontName  = "Tahoma"
1808:             .FontSize  = 8
1809:             .BackStyle = 0
1810:             .Visible   = .T.
1811:         ENDWITH
1812: 
1813:         *-- getCodFinP -> txt_4c_CodFinP (top=322, left=113, w=31, h=23)
1814:         loc_oPg1.AddObject("txt_4c_CodFinP", "TextBox")
1815:         WITH loc_oPg1.txt_4c_CodFinP
1816:             .Value    = ""
1817:             .Top      = 322
1818:             .Left     = 113
1819:             .Width    = 31
1820:             .Height   = 23
1821:             .FontName = "Tahoma"
1822:             .FontSize = 8
1823:             .Themes   = .F.
1824:             .Visible  = .T.
1825:         ENDWITH
1826:         BINDEVENT(loc_oPg1.txt_4c_CodFinP, "KeyPress", THIS, "DadosCodFinPKeyPress")
1827: 
1828:         *-- getDesFinP -> txt_4c_DesFinP (top=322, left=145, w=150, h=23) - somente leitura
1829:         loc_oPg1.AddObject("txt_4c_DesFinP", "TextBox")
1830:         WITH loc_oPg1.txt_4c_DesFinP
1831:             .Value     = ""
1832:             .Top       = 322
1833:             .Left      = 145
1834:             .Width     = 150
1835:             .Height    = 23
1836:             .FontName  = "Tahoma"
1837:             .FontSize  = 8
1838:             .ReadOnly  = .T.
1839:             .BackColor = RGB(240, 240, 240)
1840:             .Themes    = .F.
1841:             .Visible   = .T.
1842:         ENDWITH
1843: 
1844:         *----------------------------------------------------------------------
1845:         *-- ROW 10 (Top=346): Acabamento (get_codacb)
1846:         *----------------------------------------------------------------------
1847:         *-- Label "Acabamento:" (top=350, left=7, w=104)
1848:         loc_oPg1.AddObject("lbl_4c_LblAcabamento", "Label")
1849:         WITH loc_oPg1.lbl_4c_LblAcabamento
1850:             .Caption   = "Acabamento :"
1851:             .Top       = 350
1852:             .Left      = 7
1853:             .Width     = 104
1854:             .Height    = 15
1855:             .FontName  = "Tahoma"
1856:             .FontSize  = 8
1857:             .BackStyle = 0
1858:             .Visible   = .T.
1859:         ENDWITH
1860: 
1861:         *-- get_codacb -> txt_4c_Codacb (top=346, left=113, w=31, h=23) -> codacbs
1862:         loc_oPg1.AddObject("txt_4c_Codacb", "TextBox")
1863:         WITH loc_oPg1.txt_4c_Codacb
1864:             .Value    = ""
1865:             .Top      = 346
1866:             .Left     = 113
1867:             .Width    = 31
1868:             .Height   = 23
1869:             .FontName = "Tahoma"
1870:             .FontSize = 8
1871:             .Themes   = .F.
1872:             .Visible  = .T.
1873:         ENDWITH
1874:         BINDEVENT(loc_oPg1.txt_4c_Codacb, "KeyPress", THIS, "DadosCodacbKeyPress")
1875: 
1876:         *-- get_Dacb -> txt_4c_Dacb (top=346, left=145, w=150, h=23) - somente leitura
1877:         loc_oPg1.AddObject("txt_4c_Dacb", "TextBox")
1878:         WITH loc_oPg1.txt_4c_Dacb
1879:             .Value     = ""
1880:             .Top       = 346
1881:             .Left      = 145
1882:             .Width     = 150
1883:             .Height    = 23
1884:             .FontName  = "Tahoma"
1885:             .FontSize  = 8
1886:             .ReadOnly  = .T.
1887:             .BackColor = RGB(240, 240, 240)
1888:             .Themes    = .F.
1889:             .Visible   = .T.
1890:         ENDWITH
1891: 
1892:     ENDPROC
1893: 
1894:     *--------------------------------------------------------------------------
1895:     * ConfigurarPgDados1b - Page1 dos Dados Internos (pgDados) - Parte 2/2
1896:     * Campos: unidades, local, classe, precos, auditoria, dimensoes, checkboxes, memos
1897:     *--------------------------------------------------------------------------
1898:     PROTECTED PROCEDURE ConfigurarPgDados1b()
1899:         LOCAL loc_oPg1
1900:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
1901: 
1902:         *----------------------------------------------------------------------
1903:         *-- ROW 4 adicoes (Top=199-202): getConjunto + getQmin + CmdQtMin
1904:         *----------------------------------------------------------------------
1905:         *-- Label "Conjunto :" (top=206, left=408, w=53)
1906:         loc_oPg1.AddObject("lbl_4c_LblConjunto", "Label")
1907:         WITH loc_oPg1.lbl_4c_LblConjunto
1908:             .Caption   = "Conjunto :"
1909:             .Top       = 206
1910:             .Left      = 408
1911:             .Width     = 53
1912:             .Height    = 15
1913:             .FontName  = "Tahoma"
1914:             .FontSize  = 8
1915:             .BackStyle = 0
1916:             .Visible   = .T.
1917:         ENDWITH
1918: 
1919:         *-- getConjunto -> txt_4c_Conjunto (top=202, left=460, w=52, h=23)
1920:         loc_oPg1.AddObject("txt_4c_Conjunto", "TextBox")
1921:         WITH loc_oPg1.txt_4c_Conjunto
1922:             .Value    = ""
1923:             .Top      = 202
1924:             .Left     = 460
1925:             .Width    = 52
1926:             .Height   = 23
1927:             .FontName = "Tahoma"
1928:             .FontSize = 8
1929:             .Themes   = .F.
1930:             .Visible  = .T.
1931:         ENDWITH
1932: 
1933:         *-- Label "Qtde. Minima :" (top=203, left=553, w=72)
1934:         loc_oPg1.AddObject("lbl_4c_LblQmin", "Label")
1935:         WITH loc_oPg1.lbl_4c_LblQmin
1936:             .Caption   = "Qtde. M" + CHR(237) + "nima :"
1937:             .Top       = 203
1938:             .Left      = 553

*-- Linhas 1972 a 2015:
1972:             .SpecialEffect = 0
1973:             .Visible       = .T.
1974:         ENDWITH
1975:         BINDEVENT(loc_oPg1.cmd_4c_QtMin, "Click", THIS, "CmdQtMinClick")
1976: 
1977:         *----------------------------------------------------------------------
1978:         *-- ROW 5 adicoes (Top=221): getQtPed
1979:         *----------------------------------------------------------------------
1980:         *-- Label "Qtde. Pedido :" (top=225, left=553, w=72)
1981:         loc_oPg1.AddObject("lbl_4c_LblQtPed", "Label")
1982:         WITH loc_oPg1.lbl_4c_LblQtPed
1983:             .Caption   = "Qtde. Pedido :"
1984:             .Top       = 225
1985:             .Left      = 553
1986:             .Width     = 72
1987:             .Height    = 15
1988:             .FontName  = "Tahoma"
1989:             .FontSize  = 8
1990:             .BackStyle = 0
1991:             .Visible   = .T.
1992:         ENDWITH
1993: 
1994:         *-- getQtPed -> txt_4c_QtPed (top=221, left=626, w=80, h=21)
1995:         loc_oPg1.AddObject("txt_4c_QtPed", "TextBox")
1996:         WITH loc_oPg1.txt_4c_QtPed
1997:             .Value    = 0.000
1998:             .Top      = 221
1999:             .Left     = 626
2000:             .Width    = 80
2001:             .Height   = 21
2002:             .FontName = "Tahoma"
2003:             .FontSize = 8
2004:             .Themes   = .F.
2005:             .Visible  = .T.
2006:         ENDWITH
2007: 
2008:         *----------------------------------------------------------------------
2009:         *-- DIMENSOES FISICAS - lado direito (left=923, top=247-335)
2010:         *-- Campos: altura, largura, diametro, espessura, comprimento
2011:         *----------------------------------------------------------------------
2012:         *-- Label "Altura :" (top=474, left=749, w=38)
2013:         loc_oPg1.AddObject("lbl_4c_LblAltura", "Label")
2014:         WITH loc_oPg1.lbl_4c_LblAltura
2015:             .Caption   = "Altura :"

*-- Linhas 2456 a 2544:
2456:             .Themes   = .F.
2457:             .Visible  = .T.
2458:         ENDWITH
2459:         BINDEVENT(loc_oPg1.txt_4c_Class, "KeyPress", THIS, "DadosClassKeyPress")
2460: 
2461:         *-- Get_DClass -> txt_4c_DClass (top=370, left=145, w=150, h=23) - somente leitura
2462:         loc_oPg1.AddObject("txt_4c_DClass", "TextBox")
2463:         WITH loc_oPg1.txt_4c_DClass
2464:             .Value     = ""
2465:             .Top       = 370
2466:             .Left      = 145
2467:             .Width     = 150
2468:             .Height    = 23
2469:             .FontName  = "Tahoma"
2470:             .FontSize  = 8
2471:             .ReadOnly  = .T.
2472:             .BackColor = RGB(240, 240, 240)
2473:             .Themes    = .F.
2474:             .Visible   = .T.
2475:         ENDWITH
2476: 
2477:         *-- Label "Local :" (top=374, left=364, w=33)
2478:         loc_oPg1.AddObject("lbl_4c_LblLocal", "Label")
2479:         WITH loc_oPg1.lbl_4c_LblLocal
2480:             .Caption   = "Local :"
2481:             .Top       = 374
2482:             .Left      = 364
2483:             .Width     = 33
2484:             .Height    = 15
2485:             .FontName  = "Tahoma"
2486:             .FontSize  = 8
2487:             .BackStyle = 0
2488:             .Visible   = .T.
2489:         ENDWITH
2490: 
2491:         *-- Get_Local -> txt_4c_Local (top=370, left=401, w=111, h=23) -> SigPrLcl: codigos/descricaos
2492:         loc_oPg1.AddObject("txt_4c_Local", "TextBox")
2493:         WITH loc_oPg1.txt_4c_Local
2494:             .Value    = ""
2495:             .Top      = 370
2496:             .Left     = 401
2497:             .Width    = 111
2498:             .Height   = 23
2499:             .FontName = "Tahoma"
2500:             .FontSize = 8
2501:             .Themes   = .F.
2502:             .Visible  = .T.
2503:         ENDWITH
2504:         BINDEVENT(loc_oPg1.txt_4c_Local, "KeyPress", THIS, "DadosLocalKeyPress")
2505: 
2506:         *----------------------------------------------------------------------
2507:         *-- PRECOS E CUSTOS (Top=375-419) - direita
2508:         *-- Custo total (top=375): getCtotal + getMctotal
2509:         *-- Preco venda (top=397): getPvenda + getMpvenda
2510:         *-- Fator venda (top=419): getFvenda + getMfvenda
2511:         *----------------------------------------------------------------------
2512:         *-- Label "Valor de Custo :" (top=379, left=546, w=79)
2513:         loc_oPg1.AddObject("lbl_4c_LblCtotal", "Label")
2514:         WITH loc_oPg1.lbl_4c_LblCtotal
2515:             .Caption   = "Valor de Custo :"
2516:             .Top       = 379
2517:             .Left      = 546
2518:             .Width     = 79
2519:             .Height    = 15
2520:             .FontName  = "Tahoma"
2521:             .FontSize  = 8
2522:             .BackStyle = 0
2523:             .Visible   = .T.
2524:         ENDWITH
2525: 
2526:         *-- getCtotal -> txt_4c_Ctotal (top=375, left=626, w=127, h=21) - read-only
2527:         loc_oPg1.AddObject("txt_4c_Ctotal", "TextBox")
2528:         WITH loc_oPg1.txt_4c_Ctotal
2529:             .Value     = 0.00000
2530:             .Top       = 375
2531:             .Left      = 626
2532:             .Width     = 127
2533:             .Height    = 21
2534:             .FontName  = "Tahoma"
2535:             .FontSize  = 8
2536:             .ReadOnly  = .T.
2537:             .BackColor = RGB(240, 240, 240)
2538:             .Themes    = .F.
2539:             .Visible   = .T.
2540:         ENDWITH
2541: 
2542:         *-- getMctotal -> txt_4c_Mctotal (top=375, left=754, w=31, h=21) -> SigCdMoe: cmoes/dmoes
2543:         loc_oPg1.AddObject("txt_4c_Mctotal", "TextBox")
2544:         WITH loc_oPg1.txt_4c_Mctotal

*-- Linhas 2552 a 2758:
2552:             .Themes   = .F.
2553:             .Visible  = .T.
2554:         ENDWITH
2555:         BINDEVENT(loc_oPg1.txt_4c_Mctotal, "KeyPress", THIS, "DadosMctotalKeyPress")
2556: 
2557:         *-- Label "Valor de Venda :" (top=400, left=505, w=120)
2558:         loc_oPg1.AddObject("lbl_4c_LblPvenda", "Label")
2559:         WITH loc_oPg1.lbl_4c_LblPvenda
2560:             .Caption   = "Valor de Venda :"
2561:             .Top       = 400
2562:             .Left      = 505
2563:             .Width     = 120
2564:             .Height    = 15
2565:             .FontName  = "Tahoma"
2566:             .FontSize  = 8
2567:             .BackStyle = 0
2568:             .Visible   = .T.
2569:         ENDWITH
2570: 
2571:         *-- getPvenda -> txt_4c_Pvenda (top=397, left=626, w=127, h=21)
2572:         loc_oPg1.AddObject("txt_4c_Pvenda", "TextBox")
2573:         WITH loc_oPg1.txt_4c_Pvenda
2574:             .Value    = 0.00000
2575:             .Top      = 397
2576:             .Left     = 626
2577:             .Width    = 127
2578:             .Height   = 21
2579:             .FontName = "Tahoma"
2580:             .FontSize = 8
2581:             .Themes   = .F.
2582:             .Visible  = .T.
2583:         ENDWITH
2584: 
2585:         *-- getMpvenda -> txt_4c_Mpvenda (top=397, left=754, w=31, h=21) -> SigCdMoe
2586:         loc_oPg1.AddObject("txt_4c_Mpvenda", "TextBox")
2587:         WITH loc_oPg1.txt_4c_Mpvenda
2588:             .Value    = ""
2589:             .Top      = 397
2590:             .Left     = 754
2591:             .Width    = 31
2592:             .Height   = 21
2593:             .FontName = "Tahoma"
2594:             .FontSize = 8
2595:             .Themes   = .F.
2596:             .Visible  = .T.
2597:         ENDWITH
2598:         BINDEVENT(loc_oPg1.txt_4c_Mpvenda, "KeyPress", THIS, "DadosMpvendaKeyPress")
2599: 
2600:         *-- Label "Fator de Venda :" (top=422, left=539, w=86)
2601:         loc_oPg1.AddObject("lbl_4c_LblFvenda", "Label")
2602:         WITH loc_oPg1.lbl_4c_LblFvenda
2603:             .Caption   = "Fator  de Venda :"
2604:             .Top       = 422
2605:             .Left      = 539
2606:             .Width     = 86
2607:             .Height    = 15
2608:             .FontName  = "Tahoma"
2609:             .FontSize  = 8
2610:             .BackStyle = 0
2611:             .Visible   = .T.
2612:         ENDWITH
2613: 
2614:         *-- getFvenda -> txt_4c_Fvenda (top=419, left=626, w=127, h=21)
2615:         loc_oPg1.AddObject("txt_4c_Fvenda", "TextBox")
2616:         WITH loc_oPg1.txt_4c_Fvenda
2617:             .Value    = 1.000
2618:             .Top      = 419
2619:             .Left     = 626
2620:             .Width    = 127
2621:             .Height   = 21
2622:             .FontName = "Tahoma"
2623:             .FontSize = 8
2624:             .Themes   = .F.
2625:             .Visible  = .T.
2626:         ENDWITH
2627: 
2628:         *-- getMfvenda -> txt_4c_Mfvenda (top=419, left=754, w=31, h=21) -> SigCdMoe
2629:         loc_oPg1.AddObject("txt_4c_Mfvenda", "TextBox")
2630:         WITH loc_oPg1.txt_4c_Mfvenda
2631:             .Value    = ""
2632:             .Top      = 419
2633:             .Left     = 754
2634:             .Width    = 31
2635:             .Height   = 21
2636:             .FontName = "Tahoma"
2637:             .FontSize = 8
2638:             .Themes   = .F.
2639:             .Visible  = .T.
2640:         ENDWITH
2641:         BINDEVENT(loc_oPg1.txt_4c_Mfvenda, "KeyPress", THIS, "DadosMfvendaKeyPress")
2642: 
2643:         *----------------------------------------------------------------------
2644:         *-- ROW 12 - NEW (Top=394): Unidade (1) + Unidade (2)
2645:         *----------------------------------------------------------------------
2646:         *-- Label "Unidades (1) :" (top=398, left=41, w=70)
2647:         loc_oPg1.AddObject("lbl_4c_LblCuni", "Label")
2648:         WITH loc_oPg1.lbl_4c_LblCuni
2649:             .Caption   = "Unidades (1) :"
2650:             .Top       = 398
2651:             .Left      = 41
2652:             .Width     = 70
2653:             .Height    = 15
2654:             .FontName  = "Tahoma"
2655:             .FontSize  = 8
2656:             .BackStyle = 0
2657:             .Visible   = .T.
2658:         ENDWITH
2659: 
2660:         *-- Get_Cuni -> txt_4c_Cuni (top=394, left=113, w=31, h=23) -> SigCdUni: CUnis/DUnis
2661:         loc_oPg1.AddObject("txt_4c_Cuni", "TextBox")
2662:         WITH loc_oPg1.txt_4c_Cuni
2663:             .Value    = ""
2664:             .Top      = 394
2665:             .Left     = 113
2666:             .Width    = 31
2667:             .Height   = 23
2668:             .FontName = "Tahoma"
2669:             .FontSize = 8
2670:             .Themes   = .F.
2671:             .Visible  = .T.
2672:         ENDWITH
2673:         BINDEVENT(loc_oPg1.txt_4c_Cuni, "KeyPress", THIS, "DadosCuniKeyPress")
2674: 
2675:         *-- Get_Duni -> txt_4c_Duni (top=394, left=145, w=150, h=23) - somente leitura
2676:         loc_oPg1.AddObject("txt_4c_Duni", "TextBox")
2677:         WITH loc_oPg1.txt_4c_Duni
2678:             .Value     = ""
2679:             .Top       = 394
2680:             .Left      = 145
2681:             .Width     = 150
2682:             .Height    = 23
2683:             .FontName  = "Tahoma"
2684:             .FontSize  = 8
2685:             .ReadOnly  = .T.
2686:             .BackColor = RGB(240, 240, 240)
2687:             .Themes    = .F.
2688:             .Visible   = .T.
2689:         ENDWITH
2690: 
2691:         *-- Label "(2) :" (top=398, left=301, w=23)
2692:         loc_oPg1.AddObject("lbl_4c_LblCunip", "Label")
2693:         WITH loc_oPg1.lbl_4c_LblCunip
2694:             .Caption   = "(2) :"
2695:             .Top       = 398
2696:             .Left      = 301
2697:             .Width     = 23
2698:             .Height    = 15
2699:             .FontName  = "Tahoma"
2700:             .FontSize  = 8
2701:             .BackStyle = 0
2702:             .Visible   = .T.
2703:         ENDWITH
2704: 
2705:         *-- Get_cunip -> txt_4c_Cunip (top=394, left=330, w=31, h=23) -> SigCdUni
2706:         loc_oPg1.AddObject("txt_4c_Cunip", "TextBox")
2707:         WITH loc_oPg1.txt_4c_Cunip
2708:             .Value    = ""
2709:             .Top      = 394
2710:             .Left     = 330
2711:             .Width    = 31
2712:             .Height   = 23
2713:             .FontName = "Tahoma"
2714:             .FontSize = 8
2715:             .Themes   = .F.
2716:             .Visible  = .T.
2717:         ENDWITH
2718:         BINDEVENT(loc_oPg1.txt_4c_Cunip, "KeyPress", THIS, "DadosCunipKeyPress")
2719: 
2720:         *-- get_dunip -> txt_4c_Dunip (top=394, left=362, w=150, h=23) - somente leitura
2721:         loc_oPg1.AddObject("txt_4c_Dunip", "TextBox")
2722:         WITH loc_oPg1.txt_4c_Dunip
2723:             .Value     = ""
2724:             .Top       = 394
2725:             .Left      = 362
2726:             .Width     = 150
2727:             .Height    = 23
2728:             .FontName  = "Tahoma"
2729:             .FontSize  = 8
2730:             .ReadOnly  = .T.
2731:             .BackColor = RGB(240, 240, 240)
2732:             .Themes    = .F.
2733:             .Visible   = .T.
2734:         ENDWITH
2735: 
2736:         *----------------------------------------------------------------------
2737:         *-- AUDITORIA (read-only, Top=397-419): DtIncs/Usuario/DataAlts/UsuaAlts
2738:         *----------------------------------------------------------------------
2739:         *-- Label "Data / Usuario" (top=365, left=833, w=84)
2740:         loc_oPg1.AddObject("lbl_4c_LblDtUsu", "Label")
2741:         WITH loc_oPg1.lbl_4c_LblDtUsu
2742:             .Caption   = "Data / Usu" + CHR(225) + "rio"
2743:             .Top       = 365
2744:             .Left      = 833
2745:             .Width     = 84
2746:             .Height    = 15
2747:             .FontName  = "Tahoma"
2748:             .FontSize  = 8
2749:             .BackStyle = 0
2750:             .Visible   = .T.
2751:         ENDWITH
2752: 
2753:         *-- Label "Inclusao" (top=384, left=833, w=42)
2754:         loc_oPg1.AddObject("lbl_4c_LblIncs", "Label")
2755:         WITH loc_oPg1.lbl_4c_LblIncs
2756:             .Caption   = "Inclus" + CHR(227) + "o"
2757:             .Top       = 384
2758:             .Left      = 833

*-- Linhas 3178 a 3258:
3178:     ENDPROC
3179: 
3180:     *--------------------------------------------------------------------------
3181:     * NavegacaoDadosChange - Troca sub-pagina ativa via OptionGroup (BINDEVENT)
3182:     * Mapeamento: Value 1=Dados(p1), 2=Componente(p2), 3=Fiscal(p3),
3183:     *             4=Processo(p4), 5=Consumo(p5), 6=Custo(p6), 7=Designer(p7)
3184:     * NOTA: Legado mapeava Value=3 -> pgCusto(PageOrder=6), Value=4 -> pgDadosFiscais(3)
3185:     *       Aqui os botoes foram reordenados para sequencia logica (1..7 = pagina 1..7)
3186:     *--------------------------------------------------------------------------
3187:     PROCEDURE NavegacaoDadosChange()
3188:         LOCAL loc_nValor, loc_nPagina
3189:         loc_nValor  = THIS.pgf_4c_Paginas.Page2.obj_4c_NavegacaoDados.Value
3190:         loc_nPagina = 1
3191: 
3192:         DO CASE
3193:             CASE loc_nValor = 1    && Principal -> pgDados (PageOrder=1)
3194:                 loc_nPagina = 1
3195:             CASE loc_nValor = 2    && Componente -> pgComposicao (PageOrder=2)
3196:                 loc_nPagina = 2
3197:             CASE loc_nValor = 3    && Fiscal -> pgDadosFiscais (PageOrder=3)
3198:                 loc_nPagina = 3
3199:             CASE loc_nValor = 4    && Processo -> PgDadosFaseP (PageOrder=4)
3200:                 loc_nPagina = 4
3201:             CASE loc_nValor = 5    && Consumo -> PgDadosConsP (PageOrder=5)
3202:                 loc_nPagina = 5
3203:             CASE loc_nValor = 6    && Custo -> pgCusto (PageOrder=6)
3204:                 loc_nPagina = 6
3205:             CASE loc_nValor = 7    && Designer -> pgDesigner (PageOrder=7)
3206:                 loc_nPagina = 7
3207:         ENDCASE
3208: 
3209:         THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.ActivePage = loc_nPagina
3210:     ENDPROC
3211: 
3212:     *--------------------------------------------------------------------------
3213:     * CarregarLista - Carrega grid da pagina Lista com dados do SQL Server
3214:     * Filtros: getCgru (grupo), getDtIni/getDtFim (DataAlts), optFilSituas (Situas)
3215:     * Situacao: Situas=1 Ativo(verde/preto), Situas=2 Inativo(vermelho)
3216:     * Padrao SQLEXEC: query em temp ? ZAP cursor_4c_Lista ? APPEND FROM DBF
3217:     *--------------------------------------------------------------------------
3218:     PROCEDURE CarregarLista()
3219:         LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cCgru, loc_dIni, loc_dFim
3220:         LOCAL loc_nStI, loc_nStF, loc_cFiltroGrupo, loc_cFiltroSitua, loc_oGrid, loc_oPg1
3221:         LOCAL loc_aErros(1)
3222:         loc_lSucesso = .F.
3223: 
3224:         TRY
3225:             IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
3226:                 loc_lSucesso = .T.
3227:             ELSE
3228:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
3229: 
3230:                 *-- Ler filtros com defaults seguros
3231:                 loc_cCgru = ""
3232:                 loc_dIni  = {^1900-01-01}
3233:                 loc_dFim  = {^2900-12-31}
3234:                 loc_nStI  = 1
3235:                 loc_nStF  = 2
3236: 
3237:                 IF PEMSTATUS(loc_oPg1, "cnt_4c_Filtros", 5)
3238:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_Cgru", 5)
3239:                         loc_cCgru = ALLTRIM(loc_oPg1.cnt_4c_Filtros.txt_4c_Cgru.Value)
3240:                     ENDIF
3241:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_DtIni", 5)
3242:                         IF !EMPTY(loc_oPg1.cnt_4c_Filtros.txt_4c_DtIni.Value)
3243:                             loc_dIni = loc_oPg1.cnt_4c_Filtros.txt_4c_DtIni.Value
3244:                         ENDIF
3245:                     ENDIF
3246:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_DtFim", 5)
3247:                         IF !EMPTY(loc_oPg1.cnt_4c_Filtros.txt_4c_DtFim.Value)
3248:                             loc_dFim = loc_oPg1.cnt_4c_Filtros.txt_4c_DtFim.Value
3249:                         ENDIF
3250:                     ENDIF
3251:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "obj_4c_Situa", 5)
3252:                         LOCAL loc_nSitua
3253:                         loc_nSitua = loc_oPg1.cnt_4c_Filtros.obj_4c_Situa.Value
3254:                         *-- Value=1 Todos: IN(1,2) | Value=2 Ativos: IN(1,1) | Value=3 Inativos: IN(2,2)
3255:                         loc_nStI = IIF(loc_nSitua = 3, 2, 1)
3256:                         loc_nStF = IIF(loc_nSitua = 2, 1, 2)
3257:                     ENDIF
3258:                 ENDIF

*-- Linhas 3334 a 3377:
3334:     * BOParaForm - Transfere dados do BO para os campos do formulario
3335:     * FASE 5: Implementar apos adicionar campos em ConfigurarPaginaDados
3336:     *--------------------------------------------------------------------------
3337:     PROTECTED PROCEDURE BOParaForm()
3338:         LOCAL loc_oPg1, loc_oBO
3339:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
3340:         loc_oBO  = THIS.this_oBusinessObject
3341: 
3342:         *-- ROW 1: Produto + Descricao + Status + DtSituas
3343:         loc_oPg1.txt_4c_Cpro.Value        = ALLTRIM(loc_oBO.this_cCpros)
3344:         loc_oPg1.txt_4c_Dpro.Value        = ALLTRIM(loc_oBO.this_cDpros)
3345:         loc_oPg1.obj_4c_OpcSituacao.Value = IIF(loc_oBO.this_nSituas = 2, 2, 1)
3346:         IF !EMPTY(loc_oBO.this_dDatas)
3347:             loc_oPg1.txt_4c_DtSituas.Value = loc_oBO.this_dDatas
3348:         ELSE
3349:             loc_oPg1.txt_4c_DtSituas.Value = DATE()
3350:         ENDIF
3351: 
3352:         *-- ROW 2: Descritivo + CProEq + Cbar + LtMinsV
3353:         loc_oPg1.txt_4c_DPro2s.Value      = ALLTRIM(loc_oBO.this_cDpro2s)
3354:         loc_oPg1.txt_4c_CProEq.Value      = ALLTRIM(loc_oBO.this_cCproeqs)
3355:         loc_oPg1.txt_4c_Cbar.Value        = loc_oBO.this_nCbars
3356:         loc_oPg1.txt_4c_LtMinsV.Value     = loc_oBO.this_nLtminsv
3357: 
3358:         *-- ROW 3: Grupo + Merc + IdeCPros + EAN13 + ProdWeb
3359:         loc_oPg1.txt_4c_Cgru.Value        = ALLTRIM(loc_oBO.this_cCgrus)
3360:         loc_oPg1.txt_4c_Dgru.Value        = ""
3361:         loc_oPg1.txt_4c_Merc.Value        = ALLTRIM(loc_oBO.this_cMercs)
3362:         loc_oPg1.txt_4c_IdeCPros.Value    = ALLTRIM(loc_oBO.this_cIdecpros)
3363:         loc_oPg1.txt_4c_EAN13.Value       = loc_oBO.this_nEan13
3364:         loc_oPg1.obj_4c_ProdWeb.Value     = loc_oBO.this_nWebpros + 1
3365: 
3366:         *-- ROW 4: Subgrupo + Variacao
3367:         loc_oPg1.txt_4c_CSGru.Value       = ALLTRIM(loc_oBO.this_cSgrus)
3368:         loc_oPg1.txt_4c_DsGru.Value       = ""
3369:         loc_oPg1.obj_4c_Variacao.Value    = IIF(loc_oBO.this_nVarias = 1, 2, 1)
3370: 
3371:         *-- ROW 5: Linha + Garantia
3372:         loc_oPg1.txt_4c_Lin.Value         = ALLTRIM(loc_oBO.this_cLinhas)
3373:         loc_oPg1.txt_4c_DLin.Value        = ""
3374:         loc_oPg1.txt_4c_DiasGar.Value     = loc_oBO.this_nDiasinas
3375:         loc_oPg1.chk_4c_GarVit.Value      = 0
3376: 
3377:         *-- ROW 6: Colecao/Grupo de Venda + Obs3

*-- Linhas 3476 a 3519:
3476:     *--------------------------------------------------------------------------
3477:     * FormParaBO - Transfere dados dos campos para o BO
3478:     *--------------------------------------------------------------------------
3479:     PROTECTED PROCEDURE FormParaBO()
3480:         LOCAL loc_oPg1, loc_oBO
3481:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
3482:         loc_oBO  = THIS.this_oBusinessObject
3483: 
3484:         *-- ROW 1: Produto + Descricao + Status + DtSituas
3485:         loc_oBO.this_cCpros    = ALLTRIM(loc_oPg1.txt_4c_Cpro.Value)
3486:         loc_oBO.this_cDpros    = ALLTRIM(loc_oPg1.txt_4c_Dpro.Value)
3487:         loc_oBO.this_nSituas   = loc_oPg1.obj_4c_OpcSituacao.Value
3488:         IF !EMPTY(loc_oPg1.txt_4c_DtSituas.Value)
3489:             loc_oBO.this_dDatas = loc_oPg1.txt_4c_DtSituas.Value
3490:         ELSE
3491:             loc_oBO.this_dDatas = DATE()
3492:         ENDIF
3493: 
3494:         *-- ROW 2: Descritivo + CProEq + Cbar + LtMinsV
3495:         loc_oBO.this_cDpro2s   = ALLTRIM(loc_oPg1.txt_4c_DPro2s.Value)
3496:         loc_oBO.this_cCproeqs  = ALLTRIM(loc_oPg1.txt_4c_CProEq.Value)
3497:         loc_oBO.this_nCbars    = loc_oPg1.txt_4c_Cbar.Value
3498:         loc_oBO.this_nLtminsv  = loc_oPg1.txt_4c_LtMinsV.Value
3499: 
3500:         *-- ROW 3: Grupo + Merc + IdeCPros + EAN13 + ProdWeb
3501:         loc_oBO.this_cCgrus    = ALLTRIM(loc_oPg1.txt_4c_Cgru.Value)
3502:         loc_oBO.this_cMercs    = ALLTRIM(loc_oPg1.txt_4c_Merc.Value)
3503:         loc_oBO.this_cIdecpros = ALLTRIM(loc_oPg1.txt_4c_IdeCPros.Value)
3504:         loc_oBO.this_nEan13    = loc_oPg1.txt_4c_EAN13.Value
3505:         loc_oBO.this_nWebpros  = loc_oPg1.obj_4c_ProdWeb.Value - 1
3506: 
3507:         *-- ROW 4: Subgrupo + Variacao
3508:         loc_oBO.this_cSgrus    = ALLTRIM(loc_oPg1.txt_4c_CSGru.Value)
3509:         loc_oBO.this_nVarias   = IIF(loc_oPg1.obj_4c_Variacao.Value = 2, 1, 0)
3510: 
3511:         *-- ROW 5: Linha + Garantia
3512:         loc_oBO.this_cLinhas   = ALLTRIM(loc_oPg1.txt_4c_Lin.Value)
3513:         loc_oBO.this_nDiasinas = loc_oPg1.txt_4c_DiasGar.Value
3514: 
3515:         *-- ROW 6: Colecao/Grupo de Venda + Obs3
3516:         loc_oBO.this_cColecoes = ALLTRIM(loc_oPg1.txt_4c_Col.Value)
3517:         loc_oBO.this_cObsetqs  = ALLTRIM(loc_oPg1.txt_4c_Obs3.Value)
3518: 
3519:         *-- ROW 7: Fornecedor + Obs1 + Obs2

*-- Linhas 3564 a 3607:
3564:     * par_lHabilitar: .T.=editar, .F.=somente leitura (VISUALIZAR)
3565:     * par_lHabilitarCodigo: .T.=codigo editavel (INCLUIR), .F.=codigo bloqueado (ALTERAR)
3566:     *--------------------------------------------------------------------------
3567:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar, par_lHabilitarCodigo)
3568:         LOCAL loc_oPg1
3569:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
3570: 
3571:         *-- Codigo produto: editavel apenas em INCLUIR
3572:         loc_oPg1.txt_4c_Cpro.ReadOnly      = !par_lHabilitarCodigo
3573:         loc_oPg1.txt_4c_Cpro.BackColor     = IIF(par_lHabilitarCodigo, RGB(255,255,255), RGB(240,240,240))
3574: 
3575:         *-- Campos editaveis (ROW1-ROW10 exceto os ReadOnly permanentes)
3576:         loc_oPg1.txt_4c_Dpro.ReadOnly      = !par_lHabilitar
3577:         loc_oPg1.txt_4c_Dpro.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3578: 
3579:         loc_oPg1.obj_4c_OpcSituacao.Enabled = par_lHabilitar
3580: 
3581:         loc_oPg1.txt_4c_DPro2s.ReadOnly    = !par_lHabilitar
3582:         loc_oPg1.txt_4c_DPro2s.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3583: 
3584:         loc_oPg1.txt_4c_CProEq.ReadOnly    = !par_lHabilitar
3585:         loc_oPg1.txt_4c_CProEq.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3586: 
3587:         loc_oPg1.txt_4c_Cbar.ReadOnly      = !par_lHabilitar
3588:         loc_oPg1.txt_4c_Cbar.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3589: 
3590:         loc_oPg1.txt_4c_LtMinsV.ReadOnly   = !par_lHabilitar
3591:         loc_oPg1.txt_4c_LtMinsV.BackColor  = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3592: 
3593:         loc_oPg1.txt_4c_Cgru.ReadOnly      = !par_lHabilitar
3594:         loc_oPg1.txt_4c_Cgru.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3595: 
3596:         loc_oPg1.txt_4c_Merc.ReadOnly      = !par_lHabilitar
3597:         loc_oPg1.txt_4c_Merc.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3598: 
3599:         loc_oPg1.txt_4c_IdeCPros.ReadOnly  = !par_lHabilitar
3600:         loc_oPg1.txt_4c_IdeCPros.BackColor = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3601: 
3602:         loc_oPg1.txt_4c_EAN13.ReadOnly     = !par_lHabilitar
3603:         loc_oPg1.txt_4c_EAN13.BackColor    = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3604: 
3605:         loc_oPg1.obj_4c_ProdWeb.Enabled    = par_lHabilitar
3606: 
3607:         loc_oPg1.txt_4c_CSGru.ReadOnly     = !par_lHabilitar

*-- Linhas 3722 a 5176:
3722:     *--------------------------------------------------------------------------
3723:     * DadosCproKeyPress - Handler KeyPress no txt_4c_Cpro (codigo produto)
3724:     *--------------------------------------------------------------------------
3725:     PROCEDURE DadosCproKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3726:         IF par_nKeyCode = 115
3727:             THIS.AbrirLookupDadosCpro()
3728:         ENDIF
3729:     ENDPROC
3730: 
3731:     *--------------------------------------------------------------------------
3732:     * AbrirLookupDadosCpro - Lookup produto pelo codigo (F4 em txt_4c_Cpro)
3733:     *--------------------------------------------------------------------------
3734:     PROCEDURE AbrirLookupDadosCpro()
3735:         LOCAL loc_oBusca, loc_cCod, loc_oPg1
3736:         loc_oBusca = .NULL.
3737:         loc_cCod   = ""
3738:         TRY
3739:             IF USED("cursor_4c_Busca")
3740:                 USE IN cursor_4c_Busca
3741:             ENDIF
3742:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3743:                 SQLEXEC(gnConnHandle, "SELECT CPros AS cpros, DPros AS dpros FROM SigCdPro ORDER BY CPros", "cursor_4c_Busca")
3744:             ENDIF
3745:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3746:             IF !ISNULL(loc_oBusca)
3747:                 loc_oBusca.this_cTabela        = "SigCdPro"
3748:                 loc_oBusca.this_cCampoChave    = "cpros"
3749:                 loc_oBusca.this_cCampoBusca    = "cpros"
3750:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
3751:                 loc_oBusca.mAddColuna("cpros", "XXXXXXXXXXXXXX",                             "Produto")
3752:                 loc_oBusca.mAddColuna("dpros", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3753:                 loc_oBusca.Caption = "Buscar Produto"
3754:                 loc_oBusca.Show()
3755:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3756:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cpros)
3757:                 ENDIF
3758:                 IF USED("cursor_4c_Busca")
3759:                     USE IN cursor_4c_Busca
3760:                 ENDIF
3761:                 loc_oBusca.Release()
3762:             ENDIF
3763:         CATCH TO loc_oErro
3764:             MsgErro("Erro na busca de produto:" + CHR(13) + loc_oErro.Message, "Erro")
3765:         ENDTRY
3766:         loc_oBusca = .NULL.
3767:         IF !EMPTY(loc_cCod)
3768:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
3769:             loc_oPg1.txt_4c_Cpro.Value = loc_cCod
3770:         ENDIF
3771:     ENDPROC
3772: 
3773:     *--------------------------------------------------------------------------
3774:     * DadosCgruKeyPress - Handler KeyPress no txt_4c_Cgru (grupo)
3775:     *--------------------------------------------------------------------------
3776:     PROCEDURE DadosCgruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3777:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3778:             THIS.ValidarDadosCgru()
3779:         ENDIF
3780:         IF par_nKeyCode = 115
3781:             THIS.AbrirLookupDadosCgru()
3782:         ENDIF
3783:     ENDPROC
3784: 
3785:     *--------------------------------------------------------------------------
3786:     * DadosLinKeyPress - Handler KeyPress no txt_4c_Lin (linha)
3787:     *--------------------------------------------------------------------------
3788:     PROCEDURE DadosLinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3789:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3790:             THIS.ValidarDadosLin()
3791:         ENDIF
3792:         IF par_nKeyCode = 115
3793:             THIS.AbrirLookupDadosLin()
3794:         ENDIF
3795:     ENDPROC
3796: 
3797:     *--------------------------------------------------------------------------
3798:     * DadosColKeyPress - Handler KeyPress no txt_4c_Col (colecao/grupo de venda)
3799:     *--------------------------------------------------------------------------
3800:     PROCEDURE DadosColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3801:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3802:             THIS.ValidarDadosCol()
3803:         ENDIF
3804:         IF par_nKeyCode = 115
3805:             THIS.AbrirLookupDadosCol()
3806:         ENDIF
3807:     ENDPROC
3808: 
3809:     *--------------------------------------------------------------------------
3810:     * DadosIforKeyPress - Handler KeyPress no txt_4c_Ifor (fornecedor)
3811:     *--------------------------------------------------------------------------
3812:     PROCEDURE DadosIforKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3813:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3814:             THIS.ValidarDadosIfor()
3815:         ENDIF
3816:         IF par_nKeyCode = 115
3817:             THIS.AbrirLookupDadosIfor()
3818:         ENDIF
3819:     ENDPROC
3820: 
3821:     *--------------------------------------------------------------------------
3822:     * DadosCorKeyPress - Handler KeyPress no txt_4c_Cor (cor)
3823:     *--------------------------------------------------------------------------
3824:     PROCEDURE DadosCorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3825:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3826:             THIS.ValidarDadosCor()
3827:         ENDIF
3828:         IF par_nKeyCode = 115
3829:             THIS.AbrirLookupDadosCor()
3830:         ENDIF
3831:     ENDPROC
3832: 
3833:     *--------------------------------------------------------------------------
3834:     * DadosTamKeyPress - Handler KeyPress no txt_4c_Tam (tamanho)
3835:     *--------------------------------------------------------------------------
3836:     PROCEDURE DadosTamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3837:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3838:             THIS.ValidarDadosTam()
3839:         ENDIF
3840:         IF par_nKeyCode = 115
3841:             THIS.AbrirLookupDadosTam()
3842:         ENDIF
3843:     ENDPROC
3844: 
3845:     *--------------------------------------------------------------------------
3846:     * DadosCodFinPKeyPress - Handler KeyPress no txt_4c_CodFinP (modelo)
3847:     *--------------------------------------------------------------------------
3848:     PROCEDURE DadosCodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3849:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3850:             THIS.ValidarDadosCodFinP()
3851:         ENDIF
3852:         IF par_nKeyCode = 115
3853:             THIS.AbrirLookupDadosCodFinP()
3854:         ENDIF
3855:     ENDPROC
3856: 
3857:     *--------------------------------------------------------------------------
3858:     * DadosCodacbKeyPress - Handler KeyPress no txt_4c_Codacb (acabamento)
3859:     *--------------------------------------------------------------------------
3860:     PROCEDURE DadosCodacbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3861:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3862:             THIS.ValidarDadosCodacb()
3863:         ENDIF
3864:         IF par_nKeyCode = 115
3865:             THIS.AbrirLookupDadosCodacb()
3866:         ENDIF
3867:     ENDPROC
3868: 
3869:     *--------------------------------------------------------------------------
3870:     * DadosCProEqKeyPress - Handler KeyPress no txt_4c_CProEq (produto equivalente)
3871:     *--------------------------------------------------------------------------
3872:     PROCEDURE DadosCProEqKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3873:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3874:             THIS.ValidarDadosCProEq()
3875:         ENDIF
3876:         IF par_nKeyCode = 115
3877:             THIS.AbrirLookupDadosCProEq()
3878:         ENDIF
3879:     ENDPROC
3880: 
3881:     *--------------------------------------------------------------------------
3882:     * CmdQtMinClick - Handler botao "..." para QtMin por empresa
3883:     *--------------------------------------------------------------------------
3884:     PROCEDURE CmdQtMinClick()
3885:         MsgInfo("Funcionalidade de estoque m" + CHR(237) + "nimo por empresa n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Informa" + CHR(231) + CHR(227) + "o")
3886:     ENDPROC
3887: 
3888:     *--------------------------------------------------------------------------
3889:     * DadosClassKeyPress - Handler KeyPress no txt_4c_Class (classificacao)
3890:     *--------------------------------------------------------------------------
3891:     PROCEDURE DadosClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3892:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3893:             THIS.ValidarDadosClass()
3894:         ENDIF
3895:         IF par_nKeyCode = 115
3896:             THIS.AbrirLookupDadosClass()
3897:         ENDIF
3898:     ENDPROC
3899: 
3900:     *--------------------------------------------------------------------------
3901:     * DadosLocalKeyPress - Handler KeyPress no txt_4c_Local (local de estoque)
3902:     *--------------------------------------------------------------------------
3903:     PROCEDURE DadosLocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3904:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3905:             THIS.ValidarDadosLocal()
3906:         ENDIF
3907:         IF par_nKeyCode = 115
3908:             THIS.AbrirLookupDadosLocal()
3909:         ENDIF
3910:     ENDPROC
3911: 
3912:     *--------------------------------------------------------------------------
3913:     * DadosMctotalKeyPress - Handler KeyPress no txt_4c_Mctotal (moeda custo)
3914:     *--------------------------------------------------------------------------
3915:     PROCEDURE DadosMctotalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3916:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3917:             THIS.ValidarDadosMctotal()
3918:         ENDIF
3919:         IF par_nKeyCode = 115
3920:             THIS.AbrirLookupDadosMctotal()
3921:         ENDIF
3922:     ENDPROC
3923: 
3924:     *--------------------------------------------------------------------------
3925:     * DadosMpvendaKeyPress - Handler KeyPress no txt_4c_Mpvenda (moeda preco venda)
3926:     *--------------------------------------------------------------------------
3927:     PROCEDURE DadosMpvendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3928:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3929:             THIS.ValidarDadosMpvenda()
3930:         ENDIF
3931:         IF par_nKeyCode = 115
3932:             THIS.AbrirLookupDadosMpvenda()
3933:         ENDIF
3934:     ENDPROC
3935: 
3936:     *--------------------------------------------------------------------------
3937:     * DadosMfvendaKeyPress - Handler KeyPress no txt_4c_Mfvenda (moeda fator venda)
3938:     *--------------------------------------------------------------------------
3939:     PROCEDURE DadosMfvendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3940:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3941:             THIS.ValidarDadosMfvenda()
3942:         ENDIF
3943:         IF par_nKeyCode = 115
3944:             THIS.AbrirLookupDadosMfvenda()
3945:         ENDIF
3946:     ENDPROC
3947: 
3948:     *--------------------------------------------------------------------------
3949:     * DadosCuniKeyPress - Handler KeyPress no txt_4c_Cuni (unidade)
3950:     *--------------------------------------------------------------------------
3951:     PROCEDURE DadosCuniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3952:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3953:             THIS.ValidarDadosCuni()
3954:         ENDIF
3955:         IF par_nKeyCode = 115
3956:             THIS.AbrirLookupDadosCuni()
3957:         ENDIF
3958:     ENDPROC
3959: 
3960:     *--------------------------------------------------------------------------
3961:     * DadosCunipKeyPress - Handler KeyPress no txt_4c_Cunip (unidade pauta)
3962:     *--------------------------------------------------------------------------
3963:     PROCEDURE DadosCunipKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3964:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3965:             THIS.ValidarDadosCunip()
3966:         ENDIF
3967:         IF par_nKeyCode = 115
3968:             THIS.AbrirLookupDadosCunip()
3969:         ENDIF
3970:     ENDPROC
3971: 
3972:     *==========================================================================
3973:     *-- VALIDACAO - Valida codigo e carrega descricao (ENTER/TAB)
3974:     *==========================================================================
3975: 
3976:     *--------------------------------------------------------------------------
3977:     * ValidarDadosCgru - Valida grupo (SigCdGrp: cgrus/dgrus)
3978:     *--------------------------------------------------------------------------
3979:     PROTECTED PROCEDURE ValidarDadosCgru()
3980:         LOCAL loc_oPg1, loc_cCgru, loc_cSQL, loc_nResult
3981:         loc_oPg1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
3982:         loc_cCgru = ALLTRIM(loc_oPg1.txt_4c_Cgru.Value)
3983:         IF EMPTY(loc_cCgru)
3984:             loc_oPg1.txt_4c_Dgru.Value = ""
3985:         ELSE
3986:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3987:                 loc_cSQL    = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
3988:                               "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
3989:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruD")
3990:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruD") > 0
3991:                     loc_oPg1.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_GruD.DGrus)
3992:                 ELSE
3993:                     loc_oPg1.txt_4c_Dgru.Value = ""
3994:                     loc_oPg1.txt_4c_Cgru.Value = ""
3995:                     MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cCgru, "Aviso")
3996:                 ENDIF
3997:                 IF USED("cursor_4c_GruD")
3998:                     USE IN cursor_4c_GruD
3999:                 ENDIF
4000:             ENDIF
4001:         ENDIF
4002:         THIS.CarregarLista()
4003:     ENDPROC
4004: 
4005:     *--------------------------------------------------------------------------
4006:     * ValidarDadosLin - Valida linha (SigCdLin: linhas/descs)
4007:     *--------------------------------------------------------------------------
4008:     PROTECTED PROCEDURE ValidarDadosLin()
4009:         LOCAL loc_oPg1, loc_cLin, loc_cSQL, loc_nResult
4010:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4011:         loc_cLin = ALLTRIM(loc_oPg1.txt_4c_Lin.Value)
4012:         IF EMPTY(loc_cLin)
4013:             loc_oPg1.txt_4c_DLin.Value = ""
4014:         ELSE
4015:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4016:                 loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdLin " + ;
4017:                               "WHERE Linhas = " + EscaparSQL(PADR(loc_cLin, 10))
4018:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinD")
4019:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_LinD") > 0
4020:                     loc_oPg1.txt_4c_DLin.Value = ALLTRIM(cursor_4c_LinD.Descs)
4021:                 ELSE
4022:                     loc_oPg1.txt_4c_DLin.Value = ""
4023:                     loc_oPg1.txt_4c_Lin.Value  = ""
4024:                     MsgAviso("Linha n" + CHR(227) + "o encontrada: " + loc_cLin, "Aviso")
4025:                 ENDIF
4026:                 IF USED("cursor_4c_LinD")
4027:                     USE IN cursor_4c_LinD
4028:                 ENDIF
4029:             ENDIF
4030:         ENDIF
4031:         THIS.CarregarLista()
4032:     ENDPROC
4033: 
4034:     *--------------------------------------------------------------------------
4035:     * ValidarDadosCol - Valida colecao/grupo de venda (SIGCDCOL: colecoes/descs)
4036:     *--------------------------------------------------------------------------
4037:     PROTECTED PROCEDURE ValidarDadosCol()
4038:         LOCAL loc_oPg1, loc_cCol, loc_cSQL, loc_nResult
4039:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4040:         loc_cCol = ALLTRIM(loc_oPg1.txt_4c_Col.Value)
4041:         IF EMPTY(loc_cCol)
4042:             loc_oPg1.txt_4c_DCol.Value = ""
4043:         ELSE
4044:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4045:                 loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SIGCDCOL " + ;
4046:                               "WHERE Colecoes = " + EscaparSQL(PADR(loc_cCol, 10))
4047:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ColD")
4048:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ColD") > 0
4049:                     loc_oPg1.txt_4c_DCol.Value = ALLTRIM(cursor_4c_ColD.Descs)
4050:                 ELSE
4051:                     loc_oPg1.txt_4c_DCol.Value = ""
4052:                     loc_oPg1.txt_4c_Col.Value  = ""
4053:                     MsgAviso("Cole" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada: " + loc_cCol, "Aviso")
4054:                 ENDIF
4055:                 IF USED("cursor_4c_ColD")
4056:                     USE IN cursor_4c_ColD
4057:                 ENDIF
4058:             ENDIF
4059:         ENDIF
4060:         THIS.CarregarLista()
4061:     ENDPROC
4062: 
4063:     *--------------------------------------------------------------------------
4064:     * ValidarDadosIfor - Valida fornecedor (SIGCDCLI: iclis/rclis)
4065:     *--------------------------------------------------------------------------
4066:     PROTECTED PROCEDURE ValidarDadosIfor()
4067:         LOCAL loc_oPg1, loc_cIfor, loc_cSQL, loc_nResult
4068:         loc_oPg1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4069:         loc_cIfor = ALLTRIM(loc_oPg1.txt_4c_Ifor.Value)
4070:         IF EMPTY(loc_cIfor)
4071:             loc_oPg1.txt_4c_Dfor.Value = ""
4072:         ELSE
4073:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4074:                 loc_cSQL    = "SELECT ISNULL(RClis,'') AS RClis FROM SIGCDCLI " + ;
4075:                               "WHERE IClis = " + EscaparSQL(PADR(loc_cIfor, 10))
4076:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_IforD")
4077:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_IforD") > 0
4078:                     loc_oPg1.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_IforD.RClis)
4079:                 ELSE
4080:                     loc_oPg1.txt_4c_Dfor.Value = ""
4081:                     loc_oPg1.txt_4c_Ifor.Value = ""
4082:                     MsgAviso("Fornecedor n" + CHR(227) + "o encontrado: " + loc_cIfor, "Aviso")
4083:                 ENDIF
4084:                 IF USED("cursor_4c_IforD")
4085:                     USE IN cursor_4c_IforD
4086:                 ENDIF
4087:             ENDIF
4088:         ENDIF
4089:         THIS.CarregarLista()
4090:     ENDPROC
4091: 
4092:     *--------------------------------------------------------------------------
4093:     * ValidarDadosCor - Valida cor (SigCdCor: cods/descs)
4094:     *--------------------------------------------------------------------------
4095:     PROTECTED PROCEDURE ValidarDadosCor()
4096:         LOCAL loc_oPg1, loc_cCor, loc_cSQL, loc_nResult
4097:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4098:         loc_cCor = ALLTRIM(loc_oPg1.txt_4c_Cor.Value)
4099:         IF EMPTY(loc_cCor)
4100:             *-- Cor vazia e valida (produto sem cor padrao)
4101:         ELSE
4102:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4103:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdCor " + ;
4104:                               "WHERE Cods = " + EscaparSQL(PADR(loc_cCor, 4))
4105:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CorD")
4106:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_CorD") > 0
4107:                     IF cursor_4c_CorD.nExiste = 0
4108:                         loc_oPg1.txt_4c_Cor.Value = ""
4109:                         MsgAviso("Cor n" + CHR(227) + "o encontrada: " + loc_cCor, "Aviso")
4110:                     ENDIF
4111:                 ENDIF
4112:                 IF USED("cursor_4c_CorD")
4113:                     USE IN cursor_4c_CorD
4114:                 ENDIF
4115:             ENDIF
4116:         ENDIF
4117:         THIS.CarregarLista()
4118:     ENDPROC
4119: 
4120:     *--------------------------------------------------------------------------
4121:     * ValidarDadosTam - Valida tamanho (SigCdTam: cods/descs)
4122:     *--------------------------------------------------------------------------
4123:     PROTECTED PROCEDURE ValidarDadosTam()
4124:         LOCAL loc_oPg1, loc_cTam, loc_cSQL, loc_nResult
4125:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4126:         loc_cTam = ALLTRIM(loc_oPg1.txt_4c_Tam.Value)
4127:         IF EMPTY(loc_cTam)
4128:             *-- Tamanho vazio e valido (produto sem tamanho padrao)
4129:         ELSE
4130:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4131:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdTam " + ;
4132:                               "WHERE Cods = " + EscaparSQL(PADR(loc_cTam, 4))
4133:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TamD")
4134:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_TamD") > 0
4135:                     IF cursor_4c_TamD.nExiste = 0
4136:                         loc_oPg1.txt_4c_Tam.Value = ""
4137:                         MsgAviso("Tamanho n" + CHR(227) + "o encontrado: " + loc_cTam, "Aviso")
4138:                     ENDIF
4139:                 ENDIF
4140:                 IF USED("cursor_4c_TamD")
4141:                     USE IN cursor_4c_TamD
4142:                 ENDIF
4143:             ENDIF
4144:         ENDIF
4145:         THIS.CarregarLista()
4146:     ENDPROC
4147: 
4148:     *--------------------------------------------------------------------------
4149:     * ValidarDadosCodFinP - Valida modelo (sigcdmod: pkchave/descs)
4150:     *--------------------------------------------------------------------------
4151:     PROTECTED PROCEDURE ValidarDadosCodFinP()
4152:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4153:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4154:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_CodFinP.Value)
4155:         IF EMPTY(loc_cCod)
4156:             loc_oPg1.txt_4c_DesFinP.Value = ""
4157:         ELSE
4158:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4159:                 loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM sigcdmod " + ;
4160:                               "WHERE Codigos = " + EscaparSQL(PADR(loc_cCod, 3))
4161:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ModD")
4162:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ModD") > 0
4163:                     loc_oPg1.txt_4c_DesFinP.Value = ALLTRIM(cursor_4c_ModD.Descs)
4164:                 ELSE
4165:                     loc_oPg1.txt_4c_DesFinP.Value = ""
4166:                     loc_oPg1.txt_4c_CodFinP.Value = ""
4167:                     MsgAviso("Modelo n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
4168:                 ENDIF
4169:                 IF USED("cursor_4c_ModD")
4170:                     USE IN cursor_4c_ModD
4171:                 ENDIF
4172:             ENDIF
4173:         ENDIF
4174:         THIS.CarregarLista()
4175:     ENDPROC
4176: 
4177:     *--------------------------------------------------------------------------
4178:     * ValidarDadosCodacb - Valida acabamento (SigCdAca: cods/descrs)
4179:     *--------------------------------------------------------------------------
4180:     PROTECTED PROCEDURE ValidarDadosCodacb()
4181:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4182:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4183:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Codacb.Value)
4184:         IF EMPTY(loc_cCod)
4185:             loc_oPg1.txt_4c_Dacb.Value = ""
4186:         ELSE
4187:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4188:                 loc_cSQL    = "SELECT ISNULL(Descrs,'') AS Descrs FROM SigCdAca " + ;
4189:                               "WHERE Cods = " + EscaparSQL(PADR(loc_cCod, 3))
4190:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcaD")
4191:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_AcaD") > 0
4192:                     loc_oPg1.txt_4c_Dacb.Value = ALLTRIM(cursor_4c_AcaD.Descrs)
4193:                 ELSE
4194:                     loc_oPg1.txt_4c_Dacb.Value = ""
4195:                     loc_oPg1.txt_4c_Codacb.Value = ""
4196:                     MsgAviso("Acabamento n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
4197:                 ENDIF
4198:                 IF USED("cursor_4c_AcaD")
4199:                     USE IN cursor_4c_AcaD
4200:                 ENDIF
4201:             ENDIF
4202:         ENDIF
4203:         THIS.CarregarLista()
4204:     ENDPROC
4205: 
4206:     *--------------------------------------------------------------------------
4207:     * ValidarDadosCProEq - Valida produto equivalente (SigCdPro: cpros/dpros)
4208:     *--------------------------------------------------------------------------
4209:     PROTECTED PROCEDURE ValidarDadosCProEq()
4210:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4211:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4212:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_CProEq.Value)
4213:         IF EMPTY(loc_cCod)
4214:             *-- Equivalente vazio e valido
4215:         ELSE
4216:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4217:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdPro " + ;
4218:                               "WHERE CPros = " + EscaparSQL(PADR(loc_cCod, 14))
4219:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EqD")
4220:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_EqD") > 0
4221:                     IF cursor_4c_EqD.nExiste = 0
4222:                         loc_oPg1.txt_4c_CProEq.Value = ""
4223:                         MsgAviso("Produto equivalente n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
4224:                     ENDIF
4225:                 ENDIF
4226:                 IF USED("cursor_4c_EqD")
4227:                     USE IN cursor_4c_EqD
4228:                 ENDIF
4229:             ENDIF
4230:         ENDIF
4231:         THIS.CarregarLista()
4232:     ENDPROC
4233: 
4234:     *--------------------------------------------------------------------------
4235:     * ValidarDadosClass - Valida classificacao (SigCdCls: Cods/Descs)
4236:     *--------------------------------------------------------------------------
4237:     PROTECTED PROCEDURE ValidarDadosClass()
4238:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4239:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4240:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Class.Value)
4241:         IF EMPTY(loc_cCod)
4242:             loc_oPg1.txt_4c_DClass.Value = ""
4243:         ELSE
4244:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4245:                 loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdCls " + ;
4246:                               "WHERE Cods = " + EscaparSQL(PADR(loc_cCod, 3))
4247:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClsD")
4248:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ClsD") > 0
4249:                     loc_oPg1.txt_4c_DClass.Value = ALLTRIM(cursor_4c_ClsD.Descs)
4250:                 ELSE
4251:                     loc_oPg1.txt_4c_DClass.Value = ""
4252:                     loc_oPg1.txt_4c_Class.Value  = ""
4253:                     MsgAviso("Classifica" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4254:                 ENDIF
4255:                 IF USED("cursor_4c_ClsD")
4256:                     USE IN cursor_4c_ClsD
4257:                 ENDIF
4258:             ENDIF
4259:         ENDIF
4260:         THIS.CarregarLista()
4261:     ENDPROC
4262: 
4263:     *--------------------------------------------------------------------------
4264:     * ValidarDadosLocal - Valida local de estoque (SigPrLcl: Codigos/Descricaos)
4265:     *--------------------------------------------------------------------------
4266:     PROTECTED PROCEDURE ValidarDadosLocal()
4267:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4268:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4269:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Local.Value)
4270:         IF !EMPTY(loc_cCod)
4271:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4272:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigPrLcl " + ;
4273:                               "WHERE Codigos = " + EscaparSQL(PADR(loc_cCod, 10))
4274:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LclD")
4275:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_LclD") > 0
4276:                     IF cursor_4c_LclD.nExiste = 0
4277:                         loc_oPg1.txt_4c_Local.Value = ""
4278:                         MsgAviso("Local de estoque n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
4279:                     ENDIF
4280:                 ENDIF
4281:                 IF USED("cursor_4c_LclD")
4282:                     USE IN cursor_4c_LclD
4283:                 ENDIF
4284:             ENDIF
4285:         ENDIF
4286:         THIS.CarregarLista()
4287:     ENDPROC
4288: 
4289:     *--------------------------------------------------------------------------
4290:     * ValidarDadosCuni - Valida unidade (SigCdUni: CUnis/DUnis)
4291:     *--------------------------------------------------------------------------
4292:     PROTECTED PROCEDURE ValidarDadosCuni()
4293:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4294:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4295:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Cuni.Value)
4296:         IF EMPTY(loc_cCod)
4297:             loc_oPg1.txt_4c_Duni.Value = ""
4298:         ELSE
4299:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4300:                 loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
4301:                               "WHERE CUnis = " + EscaparSQL(PADR(loc_cCod, 3))
4302:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniD")
4303:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UniD") > 0
4304:                     loc_oPg1.txt_4c_Duni.Value = ALLTRIM(cursor_4c_UniD.DUnis)
4305:                 ELSE
4306:                     loc_oPg1.txt_4c_Duni.Value = ""
4307:                     loc_oPg1.txt_4c_Cuni.Value = ""
4308:                     MsgAviso("Unidade n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4309:                 ENDIF
4310:                 IF USED("cursor_4c_UniD")
4311:                     USE IN cursor_4c_UniD
4312:                 ENDIF
4313:             ENDIF
4314:         ENDIF
4315:         THIS.CarregarLista()
4316:     ENDPROC
4317: 
4318:     *--------------------------------------------------------------------------
4319:     * ValidarDadosCunip - Valida unidade de pauta (SigCdUni: CUnis/DUnis)
4320:     *--------------------------------------------------------------------------
4321:     PROTECTED PROCEDURE ValidarDadosCunip()
4322:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4323:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4324:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Cunip.Value)
4325:         IF EMPTY(loc_cCod)
4326:             loc_oPg1.txt_4c_Dunip.Value = ""
4327:         ELSE
4328:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4329:                 loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
4330:                               "WHERE CUnis = " + EscaparSQL(PADR(loc_cCod, 3))
4331:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UnipD")
4332:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UnipD") > 0
4333:                     loc_oPg1.txt_4c_Dunip.Value = ALLTRIM(cursor_4c_UnipD.DUnis)
4334:                 ELSE
4335:                     loc_oPg1.txt_4c_Dunip.Value = ""
4336:                     loc_oPg1.txt_4c_Cunip.Value = ""
4337:                     MsgAviso("Unidade n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4338:                 ENDIF
4339:                 IF USED("cursor_4c_UnipD")
4340:                     USE IN cursor_4c_UnipD
4341:                 ENDIF
4342:             ENDIF
4343:         ENDIF
4344:         THIS.CarregarLista()
4345:     ENDPROC
4346: 
4347:     *--------------------------------------------------------------------------
4348:     * ValidarDadosMctotal - Valida moeda custo (SigCdMoe: CMoes/DMoes)
4349:     *--------------------------------------------------------------------------
4350:     PROTECTED PROCEDURE ValidarDadosMctotal()
4351:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4352:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4353:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Mctotal.Value)
4354:         IF !EMPTY(loc_cCod)
4355:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4356:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdMoe " + ;
4357:                               "WHERE CMoes = " + EscaparSQL(PADR(loc_cCod, 3))
4358:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeCtD")
4359:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MoeCtD") > 0
4360:                     IF cursor_4c_MoeCtD.nExiste = 0
4361:                         loc_oPg1.txt_4c_Mctotal.Value = ""
4362:                         MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4363:                     ENDIF
4364:                 ENDIF
4365:                 IF USED("cursor_4c_MoeCtD")
4366:                     USE IN cursor_4c_MoeCtD
4367:                 ENDIF
4368:             ENDIF
4369:         ENDIF
4370:         THIS.CarregarLista()
4371:     ENDPROC
4372: 
4373:     *--------------------------------------------------------------------------
4374:     * ValidarDadosMpvenda - Valida moeda preco venda (SigCdMoe: CMoes/DMoes)
4375:     *--------------------------------------------------------------------------
4376:     PROTECTED PROCEDURE ValidarDadosMpvenda()
4377:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4378:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4379:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Mpvenda.Value)
4380:         IF !EMPTY(loc_cCod)
4381:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4382:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdMoe " + ;
4383:                               "WHERE CMoes = " + EscaparSQL(PADR(loc_cCod, 3))
4384:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoePvD")
4385:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MoePvD") > 0
4386:                     IF cursor_4c_MoePvD.nExiste = 0
4387:                         loc_oPg1.txt_4c_Mpvenda.Value = ""
4388:                         MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4389:                     ENDIF
4390:                 ENDIF
4391:                 IF USED("cursor_4c_MoePvD")
4392:                     USE IN cursor_4c_MoePvD
4393:                 ENDIF
4394:             ENDIF
4395:         ENDIF
4396:         THIS.CarregarLista()
4397:     ENDPROC
4398: 
4399:     *--------------------------------------------------------------------------
4400:     * ValidarDadosMfvenda - Valida moeda fator venda (SigCdMoe: CMoes/DMoes)
4401:     *--------------------------------------------------------------------------
4402:     PROTECTED PROCEDURE ValidarDadosMfvenda()
4403:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4404:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4405:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Mfvenda.Value)
4406:         IF !EMPTY(loc_cCod)
4407:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4408:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdMoe " + ;
4409:                               "WHERE CMoes = " + EscaparSQL(PADR(loc_cCod, 3))
4410:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeFvD")
4411:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MoeFvD") > 0
4412:                     IF cursor_4c_MoeFvD.nExiste = 0
4413:                         loc_oPg1.txt_4c_Mfvenda.Value = ""
4414:                         MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4415:                     ENDIF
4416:                 ENDIF
4417:                 IF USED("cursor_4c_MoeFvD")
4418:                     USE IN cursor_4c_MoeFvD
4419:                 ENDIF
4420:             ENDIF
4421:         ENDIF
4422:         THIS.CarregarLista()
4423:     ENDPROC
4424: 
4425:     *==========================================================================
4426:     *-- LOOKUPS - Abertura de FormBuscaAuxiliar (F4)
4427:     *==========================================================================
4428: 
4429:     *--------------------------------------------------------------------------
4430:     * AbrirLookupDadosCgru - Lookup grupo (SigCdGrp: cgrus/dgrus)
4431:     *--------------------------------------------------------------------------
4432:     PROCEDURE AbrirLookupDadosCgru()
4433:         LOCAL loc_oBusca, loc_cCgru, loc_cDgru, loc_oPg1
4434:         loc_oBusca = .NULL.
4435:         loc_cCgru  = ""
4436:         loc_cDgru  = ""
4437:         TRY
4438:             IF USED("cursor_4c_Busca")
4439:                 USE IN cursor_4c_Busca
4440:             ENDIF
4441:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4442:                 SQLEXEC(gnConnHandle, "SELECT CGrus AS cgrus, DGrus AS dgrus FROM SigCdGrp ORDER BY CGrus", "cursor_4c_Busca")
4443:             ENDIF
4444:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4445:             IF !ISNULL(loc_oBusca)
4446:                 loc_oBusca.this_cTabela        = "SigCdGrp"
4447:                 loc_oBusca.this_cCampoChave    = "cgrus"
4448:                 loc_oBusca.this_cCampoBusca    = "cgrus"
4449:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4450:                 loc_oBusca.mAddColuna("cgrus", "XXXXX",                                  "Grupo")
4451:                 loc_oBusca.mAddColuna("dgrus", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4452:                 loc_oBusca.Caption = "Buscar Grupo de Produto"
4453:                 loc_oBusca.Show()
4454:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4455:                     loc_cCgru = ALLTRIM(cursor_4c_Busca.cgrus)
4456:                     loc_cDgru = ALLTRIM(cursor_4c_Busca.dgrus)
4457:                 ENDIF
4458:                 IF USED("cursor_4c_Busca")
4459:                     USE IN cursor_4c_Busca
4460:                 ENDIF
4461:                 loc_oBusca.Release()
4462:             ENDIF
4463:         CATCH TO loc_oErro
4464:             MsgErro("Erro na busca de grupo:" + CHR(13) + loc_oErro.Message, "Erro")
4465:         ENDTRY
4466:         loc_oBusca = .NULL.
4467:         IF !EMPTY(loc_cCgru)
4468:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4469:             loc_oPg1.txt_4c_Cgru.Value = loc_cCgru
4470:             loc_oPg1.txt_4c_Dgru.Value = loc_cDgru
4471:         ENDIF
4472:     ENDPROC
4473: 
4474:     *--------------------------------------------------------------------------
4475:     * AbrirLookupDadosLin - Lookup linha (SigCdLin: linhas/descs)
4476:     *--------------------------------------------------------------------------
4477:     PROCEDURE AbrirLookupDadosLin()
4478:         LOCAL loc_oBusca, loc_cLin, loc_cDLin, loc_oPg1
4479:         loc_oBusca = .NULL.
4480:         loc_cLin   = ""
4481:         loc_cDLin  = ""
4482:         TRY
4483:             IF USED("cursor_4c_Busca")
4484:                 USE IN cursor_4c_Busca
4485:             ENDIF
4486:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4487:                 SQLEXEC(gnConnHandle, "SELECT Linhas AS linhas, Descs AS descs FROM SigCdLin ORDER BY Linhas", "cursor_4c_Busca")
4488:             ENDIF
4489:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4490:             IF !ISNULL(loc_oBusca)
4491:                 loc_oBusca.this_cTabela        = "SigCdLin"
4492:                 loc_oBusca.this_cCampoChave    = "linhas"
4493:                 loc_oBusca.this_cCampoBusca    = "linhas"
4494:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4495:                 loc_oBusca.mAddColuna("linhas", "XXXXXXXXXX",                               "Linha")
4496:                 loc_oBusca.mAddColuna("descs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4497:                 loc_oBusca.Caption = "Buscar Linha"
4498:                 loc_oBusca.Show()
4499:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4500:                     loc_cLin  = ALLTRIM(cursor_4c_Busca.linhas)
4501:                     loc_cDLin = ALLTRIM(cursor_4c_Busca.descs)
4502:                 ENDIF
4503:                 IF USED("cursor_4c_Busca")
4504:                     USE IN cursor_4c_Busca
4505:                 ENDIF
4506:                 loc_oBusca.Release()
4507:             ENDIF
4508:         CATCH TO loc_oErro
4509:             MsgErro("Erro na busca de linha:" + CHR(13) + loc_oErro.Message, "Erro")
4510:         ENDTRY
4511:         loc_oBusca = .NULL.
4512:         IF !EMPTY(loc_cLin)
4513:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4514:             loc_oPg1.txt_4c_Lin.Value  = loc_cLin
4515:             loc_oPg1.txt_4c_DLin.Value = loc_cDLin
4516:         ENDIF
4517:     ENDPROC
4518: 
4519:     *--------------------------------------------------------------------------
4520:     * AbrirLookupDadosCol - Lookup colecao/grupo de venda (SIGCDCOL: colecoes/descs)
4521:     *--------------------------------------------------------------------------
4522:     PROCEDURE AbrirLookupDadosCol()
4523:         LOCAL loc_oBusca, loc_cCol, loc_cDCol, loc_oPg1
4524:         loc_oBusca = .NULL.
4525:         loc_cCol   = ""
4526:         loc_cDCol  = ""
4527:         TRY
4528:             IF USED("cursor_4c_Busca")
4529:                 USE IN cursor_4c_Busca
4530:             ENDIF
4531:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4532:                 SQLEXEC(gnConnHandle, "SELECT Colecoes AS colecoes, Descs AS descs FROM SIGCDCOL ORDER BY Colecoes", "cursor_4c_Busca")
4533:             ENDIF
4534:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4535:             IF !ISNULL(loc_oBusca)
4536:                 loc_oBusca.this_cTabela        = "SIGCDCOL"
4537:                 loc_oBusca.this_cCampoChave    = "colecoes"
4538:                 loc_oBusca.this_cCampoBusca    = "colecoes"
4539:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4540:                 loc_oBusca.mAddColuna("colecoes", "XXXXXXXXXX",                               "Cole" + CHR(231) + CHR(227) + "o")
4541:                 loc_oBusca.mAddColuna("descs",    "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4542:                 loc_oBusca.Caption = "Buscar Grupo de Venda"
4543:                 loc_oBusca.Show()
4544:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4545:                     loc_cCol  = ALLTRIM(cursor_4c_Busca.colecoes)
4546:                     loc_cDCol = ALLTRIM(cursor_4c_Busca.descs)
4547:                 ENDIF
4548:                 IF USED("cursor_4c_Busca")
4549:                     USE IN cursor_4c_Busca
4550:                 ENDIF
4551:                 loc_oBusca.Release()
4552:             ENDIF
4553:         CATCH TO loc_oErro
4554:             MsgErro("Erro na busca de cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
4555:         ENDTRY
4556:         loc_oBusca = .NULL.
4557:         IF !EMPTY(loc_cCol)
4558:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4559:             loc_oPg1.txt_4c_Col.Value  = loc_cCol
4560:             loc_oPg1.txt_4c_DCol.Value = loc_cDCol
4561:         ENDIF
4562:     ENDPROC
4563: 
4564:     *--------------------------------------------------------------------------
4565:     * AbrirLookupDadosIfor - Lookup fornecedor (SIGCDCLI: iclis/rclis)
4566:     *--------------------------------------------------------------------------
4567:     PROCEDURE AbrirLookupDadosIfor()
4568:         LOCAL loc_oBusca, loc_cIfor, loc_cDfor, loc_oPg1
4569:         loc_oBusca = .NULL.
4570:         loc_cIfor  = ""
4571:         loc_cDfor  = ""
4572:         TRY
4573:             IF USED("cursor_4c_Busca")
4574:                 USE IN cursor_4c_Busca
4575:             ENDIF
4576:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4577:                 SQLEXEC(gnConnHandle, "SELECT IClis AS iclis, RClis AS rclis FROM SIGCDCLI ORDER BY IClis", "cursor_4c_Busca")
4578:             ENDIF
4579:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4580:             IF !ISNULL(loc_oBusca)
4581:                 loc_oBusca.this_cTabela        = "SIGCDCLI"
4582:                 loc_oBusca.this_cCampoChave    = "iclis"
4583:                 loc_oBusca.this_cCampoBusca    = "iclis"
4584:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4585:                 loc_oBusca.mAddColuna("iclis", "XXXXXXXXXX",                               "Fornecedor")
4586:                 loc_oBusca.mAddColuna("rclis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Raz" + CHR(227) + "o Social")
4587:                 loc_oBusca.Caption = "Buscar Fornecedor"
4588:                 loc_oBusca.Show()
4589:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4590:                     loc_cIfor = ALLTRIM(cursor_4c_Busca.iclis)
4591:                     loc_cDfor = ALLTRIM(cursor_4c_Busca.rclis)
4592:                 ENDIF
4593:                 IF USED("cursor_4c_Busca")
4594:                     USE IN cursor_4c_Busca
4595:                 ENDIF
4596:                 loc_oBusca.Release()
4597:             ENDIF
4598:         CATCH TO loc_oErro
4599:             MsgErro("Erro na busca de fornecedor:" + CHR(13) + loc_oErro.Message, "Erro")
4600:         ENDTRY
4601:         loc_oBusca = .NULL.
4602:         IF !EMPTY(loc_cIfor)
4603:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4604:             loc_oPg1.txt_4c_Ifor.Value = loc_cIfor
4605:             loc_oPg1.txt_4c_Dfor.Value = loc_cDfor
4606:         ENDIF
4607:     ENDPROC
4608: 
4609:     *--------------------------------------------------------------------------
4610:     * AbrirLookupDadosCor - Lookup cor (SigCdCor: cods/descs)
4611:     *--------------------------------------------------------------------------
4612:     PROCEDURE AbrirLookupDadosCor()
4613:         LOCAL loc_oBusca, loc_cCod, loc_oPg1
4614:         loc_oBusca = .NULL.
4615:         loc_cCod   = ""
4616:         TRY
4617:             IF USED("cursor_4c_Busca")
4618:                 USE IN cursor_4c_Busca
4619:             ENDIF
4620:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4621:                 SQLEXEC(gnConnHandle, "SELECT Cods AS cods, Descs AS descs FROM SigCdCor ORDER BY Cods", "cursor_4c_Busca")
4622:             ENDIF
4623:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4624:             IF !ISNULL(loc_oBusca)
4625:                 loc_oBusca.this_cTabela        = "SigCdCor"
4626:                 loc_oBusca.this_cCampoChave    = "cods"
4627:                 loc_oBusca.this_cCampoBusca    = "cods"
4628:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4629:                 loc_oBusca.mAddColuna("cods",  "XXXX",                                      "Cor")
4630:                 loc_oBusca.mAddColuna("descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4631:                 loc_oBusca.Caption = "Buscar Cor"
4632:                 loc_oBusca.Show()
4633:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4634:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cods)
4635:                 ENDIF
4636:                 IF USED("cursor_4c_Busca")
4637:                     USE IN cursor_4c_Busca
4638:                 ENDIF
4639:                 loc_oBusca.Release()
4640:             ENDIF
4641:         CATCH TO loc_oErro
4642:             MsgErro("Erro na busca de cor:" + CHR(13) + loc_oErro.Message, "Erro")
4643:         ENDTRY
4644:         loc_oBusca = .NULL.
4645:         IF !EMPTY(loc_cCod)
4646:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4647:             loc_oPg1.txt_4c_Cor.Value = loc_cCod
4648:         ENDIF
4649:     ENDPROC
4650: 
4651:     *--------------------------------------------------------------------------
4652:     * AbrirLookupDadosTam - Lookup tamanho (SigCdTam: cods/descs)
4653:     *--------------------------------------------------------------------------
4654:     PROCEDURE AbrirLookupDadosTam()
4655:         LOCAL loc_oBusca, loc_cCod, loc_oPg1
4656:         loc_oBusca = .NULL.
4657:         loc_cCod   = ""
4658:         TRY
4659:             IF USED("cursor_4c_Busca")
4660:                 USE IN cursor_4c_Busca
4661:             ENDIF
4662:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4663:                 SQLEXEC(gnConnHandle, "SELECT Cods AS cods, Descs AS descs FROM SigCdTam ORDER BY Cods", "cursor_4c_Busca")
4664:             ENDIF
4665:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4666:             IF !ISNULL(loc_oBusca)
4667:                 loc_oBusca.this_cTabela        = "SigCdTam"
4668:                 loc_oBusca.this_cCampoChave    = "cods"
4669:                 loc_oBusca.this_cCampoBusca    = "cods"
4670:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4671:                 loc_oBusca.mAddColuna("cods",  "XXXX",                                      "Tamanho")
4672:                 loc_oBusca.mAddColuna("descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4673:                 loc_oBusca.Caption = "Buscar Tamanho"
4674:                 loc_oBusca.Show()
4675:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4676:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cods)
4677:                 ENDIF
4678:                 IF USED("cursor_4c_Busca")
4679:                     USE IN cursor_4c_Busca
4680:                 ENDIF
4681:                 loc_oBusca.Release()
4682:             ENDIF
4683:         CATCH TO loc_oErro
4684:             MsgErro("Erro na busca de tamanho:" + CHR(13) + loc_oErro.Message, "Erro")
4685:         ENDTRY
4686:         loc_oBusca = .NULL.
4687:         IF !EMPTY(loc_cCod)
4688:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4689:             loc_oPg1.txt_4c_Tam.Value = loc_cCod
4690:         ENDIF
4691:     ENDPROC
4692: 
4693:     *--------------------------------------------------------------------------
4694:     * AbrirLookupDadosCodFinP - Lookup modelo (sigcdmod: pkchave/descs)
4695:     *--------------------------------------------------------------------------
4696:     PROCEDURE AbrirLookupDadosCodFinP()
4697:         LOCAL loc_oBusca, loc_cCod, loc_cDes, loc_oPg1
4698:         loc_oBusca = .NULL.
4699:         loc_cCod   = ""
4700:         loc_cDes   = ""
4701:         TRY
4702:             IF USED("cursor_4c_Busca")
4703:                 USE IN cursor_4c_Busca
4704:             ENDIF
4705:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4706:                 SQLEXEC(gnConnHandle, "SELECT pkchave, Descs AS descs FROM sigcdmod ORDER BY pkchave", "cursor_4c_Busca")
4707:             ENDIF
4708:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4709:             IF !ISNULL(loc_oBusca)
4710:                 loc_oBusca.this_cTabela        = "sigcdmod"
4711:                 loc_oBusca.this_cCampoChave    = "pkchave"
4712:                 loc_oBusca.this_cCampoBusca    = "pkchave"
4713:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4714:                 loc_oBusca.mAddColuna("pkchave", "XXX",                                      "Modelo")
4715:                 loc_oBusca.mAddColuna("descs",   "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4716:                 loc_oBusca.Caption = "Buscar Modelo"
4717:                 loc_oBusca.Show()
4718:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4719:                     loc_cCod = ALLTRIM(cursor_4c_Busca.pkchave)
4720:                     loc_cDes = ALLTRIM(cursor_4c_Busca.descs)
4721:                 ENDIF
4722:                 IF USED("cursor_4c_Busca")
4723:                     USE IN cursor_4c_Busca
4724:                 ENDIF
4725:                 loc_oBusca.Release()
4726:             ENDIF
4727:         CATCH TO loc_oErro
4728:             MsgErro("Erro na busca de modelo:" + CHR(13) + loc_oErro.Message, "Erro")
4729:         ENDTRY
4730:         loc_oBusca = .NULL.
4731:         IF !EMPTY(loc_cCod)
4732:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4733:             loc_oPg1.txt_4c_CodFinP.Value  = loc_cCod
4734:             loc_oPg1.txt_4c_DesFinP.Value  = loc_cDes
4735:         ENDIF
4736:     ENDPROC
4737: 
4738:     *--------------------------------------------------------------------------
4739:     * AbrirLookupDadosCodacb - Lookup acabamento (SigCdAca: cods/descrs)
4740:     *--------------------------------------------------------------------------
4741:     PROCEDURE AbrirLookupDadosCodacb()
4742:         LOCAL loc_oBusca, loc_cCod, loc_cDes, loc_oPg1
4743:         loc_oBusca = .NULL.
4744:         loc_cCod   = ""
4745:         loc_cDes   = ""
4746:         TRY
4747:             IF USED("cursor_4c_Busca")
4748:                 USE IN cursor_4c_Busca
4749:             ENDIF
4750:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4751:                 SQLEXEC(gnConnHandle, "SELECT Cods AS cods, Descrs AS descrs FROM SigCdAca ORDER BY Cods", "cursor_4c_Busca")
4752:             ENDIF
4753:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4754:             IF !ISNULL(loc_oBusca)
4755:                 loc_oBusca.this_cTabela        = "SigCdAca"
4756:                 loc_oBusca.this_cCampoChave    = "cods"
4757:                 loc_oBusca.this_cCampoBusca    = "cods"
4758:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4759:                 loc_oBusca.mAddColuna("cods",   "XXX",                                      "Acabamento")
4760:                 loc_oBusca.mAddColuna("descrs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4761:                 loc_oBusca.Caption = "Buscar Acabamento"
4762:                 loc_oBusca.Show()
4763:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4764:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cods)
4765:                     loc_cDes = ALLTRIM(cursor_4c_Busca.descrs)
4766:                 ENDIF
4767:                 IF USED("cursor_4c_Busca")
4768:                     USE IN cursor_4c_Busca
4769:                 ENDIF
4770:                 loc_oBusca.Release()
4771:             ENDIF
4772:         CATCH TO loc_oErro
4773:             MsgErro("Erro na busca de acabamento:" + CHR(13) + loc_oErro.Message, "Erro")
4774:         ENDTRY
4775:         loc_oBusca = .NULL.
4776:         IF !EMPTY(loc_cCod)
4777:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4778:             loc_oPg1.txt_4c_Codacb.Value = loc_cCod
4779:             loc_oPg1.txt_4c_Dacb.Value   = loc_cDes
4780:         ENDIF
4781:     ENDPROC
4782: 
4783:     *--------------------------------------------------------------------------
4784:     * AbrirLookupDadosCProEq - Lookup produto equivalente (SigCdPro: cpros/dpros)
4785:     *--------------------------------------------------------------------------
4786:     PROCEDURE AbrirLookupDadosCProEq()
4787:         LOCAL loc_oBusca, loc_cCod, loc_oPg1
4788:         loc_oBusca = .NULL.
4789:         loc_cCod   = ""
4790:         TRY
4791:             IF USED("cursor_4c_Busca")
4792:                 USE IN cursor_4c_Busca
4793:             ENDIF
4794:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4795:                 SQLEXEC(gnConnHandle, "SELECT CPros AS cpros, DPros AS dpros FROM SigCdPro ORDER BY CPros", "cursor_4c_Busca")
4796:             ENDIF
4797:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4798:             IF !ISNULL(loc_oBusca)
4799:                 loc_oBusca.this_cTabela        = "SigCdPro"
4800:                 loc_oBusca.this_cCampoChave    = "cpros"
4801:                 loc_oBusca.this_cCampoBusca    = "cpros"
4802:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4803:                 loc_oBusca.mAddColuna("cpros", "XXXXXXXXXXXXXX",                             "Produto")
4804:                 loc_oBusca.mAddColuna("dpros", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4805:                 loc_oBusca.Caption = "Buscar Produto Equivalente"
4806:                 loc_oBusca.Show()
4807:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4808:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cpros)
4809:                 ENDIF
4810:                 IF USED("cursor_4c_Busca")
4811:                     USE IN cursor_4c_Busca
4812:                 ENDIF
4813:                 loc_oBusca.Release()
4814:             ENDIF
4815:         CATCH TO loc_oErro
4816:             MsgErro("Erro na busca de produto equivalente:" + CHR(13) + loc_oErro.Message, "Erro")
4817:         ENDTRY
4818:         loc_oBusca = .NULL.
4819:         IF !EMPTY(loc_cCod)
4820:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4821:             loc_oPg1.txt_4c_CProEq.Value = loc_cCod
4822:         ENDIF
4823:     ENDPROC
4824: 
4825:     *--------------------------------------------------------------------------
4826:     * AbrirLookupDadosClass - Lookup classificacao (SigCdCls: Cods/Descs)
4827:     *--------------------------------------------------------------------------
4828:     PROCEDURE AbrirLookupDadosClass()
4829:         LOCAL loc_oBusca, loc_cCod, loc_cDesc, loc_oPg1
4830:         loc_oBusca = .NULL.
4831:         loc_cCod   = ""
4832:         loc_cDesc  = ""
4833:         TRY
4834:             IF USED("cursor_4c_Busca")
4835:                 USE IN cursor_4c_Busca
4836:             ENDIF
4837:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4838:                 SQLEXEC(gnConnHandle, "SELECT Cods, Descs FROM SigCdCls ORDER BY Cods", "cursor_4c_Busca")
4839:             ENDIF
4840:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4841:             IF !ISNULL(loc_oBusca)
4842:                 loc_oBusca.this_cTabela        = "SigCdCls"
4843:                 loc_oBusca.this_cCampoChave    = "Cods"
4844:                 loc_oBusca.this_cCampoBusca    = "Cods"
4845:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4846:                 loc_oBusca.mAddColuna("Cods",  "XXXXX",                                    "Cod")
4847:                 loc_oBusca.mAddColuna("Descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4848:                 loc_oBusca.Caption = "Buscar Classifica" + CHR(231) + CHR(227) + "o"
4849:                 loc_oBusca.Show()
4850:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4851:                     loc_cCod  = ALLTRIM(cursor_4c_Busca.Cods)
4852:                     loc_cDesc = ALLTRIM(cursor_4c_Busca.Descs)
4853:                 ENDIF
4854:                 IF USED("cursor_4c_Busca")
4855:                     USE IN cursor_4c_Busca
4856:                 ENDIF
4857:                 loc_oBusca.Release()
4858:             ENDIF
4859:         CATCH TO loc_oErro
4860:             MsgErro("Erro na busca de classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
4861:         ENDTRY
4862:         loc_oBusca = .NULL.
4863:         IF !EMPTY(loc_cCod)
4864:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4865:             loc_oPg1.txt_4c_Class.Value  = loc_cCod
4866:             loc_oPg1.txt_4c_DClass.Value = loc_cDesc
4867:         ENDIF
4868:     ENDPROC
4869: 
4870:     *--------------------------------------------------------------------------
4871:     * AbrirLookupDadosLocal - Lookup local de estoque (SigPrLcl: Codigos/Descricaos)
4872:     *--------------------------------------------------------------------------
4873:     PROCEDURE AbrirLookupDadosLocal()
4874:         LOCAL loc_oBusca, loc_cCod, loc_oPg1
4875:         loc_oBusca = .NULL.
4876:         loc_cCod   = ""
4877:         TRY
4878:             IF USED("cursor_4c_Busca")
4879:                 USE IN cursor_4c_Busca
4880:             ENDIF
4881:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4882:                 SQLEXEC(gnConnHandle, "SELECT Codigos, Descricaos FROM SigPrLcl ORDER BY Codigos", "cursor_4c_Busca")
4883:             ENDIF
4884:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4885:             IF !ISNULL(loc_oBusca)
4886:                 loc_oBusca.this_cTabela        = "SigPrLcl"
4887:                 loc_oBusca.this_cCampoChave    = "Codigos"
4888:                 loc_oBusca.this_cCampoBusca    = "Codigos"
4889:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4890:                 loc_oBusca.mAddColuna("Codigos",    "XXXXXXXXXX",                               "Cod")
4891:                 loc_oBusca.mAddColuna("Descricaos", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4892:                 loc_oBusca.Caption = "Buscar Local de Estoque"
4893:                 loc_oBusca.Show()
4894:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4895:                     loc_cCod = ALLTRIM(cursor_4c_Busca.Codigos)
4896:                 ENDIF
4897:                 IF USED("cursor_4c_Busca")
4898:                     USE IN cursor_4c_Busca
4899:                 ENDIF
4900:                 loc_oBusca.Release()
4901:             ENDIF
4902:         CATCH TO loc_oErro
4903:             MsgErro("Erro na busca de local de estoque:" + CHR(13) + loc_oErro.Message, "Erro")
4904:         ENDTRY
4905:         loc_oBusca = .NULL.
4906:         IF !EMPTY(loc_cCod)
4907:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4908:             loc_oPg1.txt_4c_Local.Value = loc_cCod
4909:         ENDIF
4910:     ENDPROC
4911: 
4912:     *--------------------------------------------------------------------------
4913:     * AbrirLookupDadosCuni - Lookup unidade (SigCdUni: CUnis/DUnis)
4914:     *--------------------------------------------------------------------------
4915:     PROCEDURE AbrirLookupDadosCuni()
4916:         LOCAL loc_oBusca, loc_cCod, loc_cDesc, loc_oPg1
4917:         loc_oBusca = .NULL.
4918:         loc_cCod   = ""
4919:         loc_cDesc  = ""
4920:         TRY
4921:             IF USED("cursor_4c_Busca")
4922:                 USE IN cursor_4c_Busca
4923:             ENDIF
4924:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4925:                 SQLEXEC(gnConnHandle, "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", "cursor_4c_Busca")
4926:             ENDIF
4927:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4928:             IF !ISNULL(loc_oBusca)
4929:                 loc_oBusca.this_cTabela        = "SigCdUni"
4930:                 loc_oBusca.this_cCampoChave    = "CUnis"
4931:                 loc_oBusca.this_cCampoBusca    = "CUnis"
4932:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4933:                 loc_oBusca.mAddColuna("CUnis", "XXXXX",                                    "Unidade")
4934:                 loc_oBusca.mAddColuna("DUnis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4935:                 loc_oBusca.Caption = "Buscar Unidade"
4936:                 loc_oBusca.Show()
4937:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4938:                     loc_cCod  = ALLTRIM(cursor_4c_Busca.CUnis)
4939:                     loc_cDesc = ALLTRIM(cursor_4c_Busca.DUnis)
4940:                 ENDIF
4941:                 IF USED("cursor_4c_Busca")
4942:                     USE IN cursor_4c_Busca
4943:                 ENDIF
4944:                 loc_oBusca.Release()
4945:             ENDIF
4946:         CATCH TO loc_oErro
4947:             MsgErro("Erro na busca de unidade:" + CHR(13) + loc_oErro.Message, "Erro")
4948:         ENDTRY
4949:         loc_oBusca = .NULL.
4950:         IF !EMPTY(loc_cCod)
4951:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4952:             loc_oPg1.txt_4c_Cuni.Value = loc_cCod
4953:             loc_oPg1.txt_4c_Duni.Value = loc_cDesc
4954:         ENDIF
4955:     ENDPROC
4956: 
4957:     *--------------------------------------------------------------------------
4958:     * AbrirLookupDadosCunip - Lookup unidade pauta (SigCdUni: CUnis/DUnis)
4959:     *--------------------------------------------------------------------------
4960:     PROCEDURE AbrirLookupDadosCunip()
4961:         LOCAL loc_oBusca, loc_cCod, loc_cDesc, loc_oPg1
4962:         loc_oBusca = .NULL.
4963:         loc_cCod   = ""
4964:         loc_cDesc  = ""
4965:         TRY
4966:             IF USED("cursor_4c_Busca")
4967:                 USE IN cursor_4c_Busca
4968:             ENDIF
4969:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4970:                 SQLEXEC(gnConnHandle, "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", "cursor_4c_Busca")
4971:             ENDIF
4972:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4973:             IF !ISNULL(loc_oBusca)
4974:                 loc_oBusca.this_cTabela        = "SigCdUni"
4975:                 loc_oBusca.this_cCampoChave    = "CUnis"
4976:                 loc_oBusca.this_cCampoBusca    = "CUnis"
4977:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4978:                 loc_oBusca.mAddColuna("CUnis", "XXXXX",                                    "Unidade")
4979:                 loc_oBusca.mAddColuna("DUnis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4980:                 loc_oBusca.Caption = "Buscar Unidade de Pauta"
4981:                 loc_oBusca.Show()
4982:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4983:                     loc_cCod  = ALLTRIM(cursor_4c_Busca.CUnis)
4984:                     loc_cDesc = ALLTRIM(cursor_4c_Busca.DUnis)
4985:                 ENDIF
4986:                 IF USED("cursor_4c_Busca")
4987:                     USE IN cursor_4c_Busca
4988:                 ENDIF
4989:                 loc_oBusca.Release()
4990:             ENDIF
4991:         CATCH TO loc_oErro
4992:             MsgErro("Erro na busca de unidade de pauta:" + CHR(13) + loc_oErro.Message, "Erro")
4993:         ENDTRY
4994:         loc_oBusca = .NULL.
4995:         IF !EMPTY(loc_cCod)
4996:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4997:             loc_oPg1.txt_4c_Cunip.Value = loc_cCod
4998:             loc_oPg1.txt_4c_Dunip.Value = loc_cDesc
4999:         ENDIF
5000:     ENDPROC
5001: 
5002:     *--------------------------------------------------------------------------
5003:     * AbrirLookupDadosMctotal - Lookup moeda custo (SigCdMoe: CMoes/DMoes)
5004:     *--------------------------------------------------------------------------
5005:     PROCEDURE AbrirLookupDadosMctotal()
5006:         LOCAL loc_oBusca, loc_cCod, loc_oPg1
5007:         loc_oBusca = .NULL.
5008:         loc_cCod   = ""
5009:         TRY
5010:             IF USED("cursor_4c_Busca")
5011:                 USE IN cursor_4c_Busca
5012:             ENDIF
5013:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5014:                 SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_Busca")
5015:             ENDIF
5016:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5017:             IF !ISNULL(loc_oBusca)
5018:                 loc_oBusca.this_cTabela        = "SigCdMoe"
5019:                 loc_oBusca.this_cCampoChave    = "CMoes"
5020:                 loc_oBusca.this_cCampoBusca    = "CMoes"
5021:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5022:                 loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
5023:                 loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5024:                 loc_oBusca.Caption = "Buscar Moeda (Custo)"
5025:                 loc_oBusca.Show()
5026:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5027:                     loc_cCod = ALLTRIM(cursor_4c_Busca.CMoes)
5028:                 ENDIF
5029:                 IF USED("cursor_4c_Busca")
5030:                     USE IN cursor_4c_Busca
5031:                 ENDIF
5032:                 loc_oBusca.Release()
5033:             ENDIF
5034:         CATCH TO loc_oErro
5035:             MsgErro("Erro na busca de moeda:" + CHR(13) + loc_oErro.Message, "Erro")
5036:         ENDTRY
5037:         loc_oBusca = .NULL.
5038:         IF !EMPTY(loc_cCod)
5039:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
5040:             loc_oPg1.txt_4c_Mctotal.Value = loc_cCod
5041:         ENDIF
5042:     ENDPROC
5043: 
5044:     *--------------------------------------------------------------------------
5045:     * AbrirLookupDadosMpvenda - Lookup moeda preco venda (SigCdMoe: CMoes/DMoes)
5046:     *--------------------------------------------------------------------------
5047:     PROCEDURE AbrirLookupDadosMpvenda()
5048:         LOCAL loc_oBusca, loc_cCod, loc_oPg1
5049:         loc_oBusca = .NULL.
5050:         loc_cCod   = ""
5051:         TRY
5052:             IF USED("cursor_4c_Busca")
5053:                 USE IN cursor_4c_Busca
5054:             ENDIF
5055:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5056:                 SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_Busca")
5057:             ENDIF
5058:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5059:             IF !ISNULL(loc_oBusca)
5060:                 loc_oBusca.this_cTabela        = "SigCdMoe"
5061:                 loc_oBusca.this_cCampoChave    = "CMoes"
5062:                 loc_oBusca.this_cCampoBusca    = "CMoes"
5063:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5064:                 loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
5065:                 loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5066:                 loc_oBusca.Caption = "Buscar Moeda (Pre" + CHR(231) + "o Venda)"
5067:                 loc_oBusca.Show()
5068:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5069:                     loc_cCod = ALLTRIM(cursor_4c_Busca.CMoes)
5070:                 ENDIF
5071:                 IF USED("cursor_4c_Busca")
5072:                     USE IN cursor_4c_Busca
5073:                 ENDIF
5074:                 loc_oBusca.Release()
5075:             ENDIF
5076:         CATCH TO loc_oErro
5077:             MsgErro("Erro na busca de moeda:" + CHR(13) + loc_oErro.Message, "Erro")
5078:         ENDTRY
5079:         loc_oBusca = .NULL.
5080:         IF !EMPTY(loc_cCod)
5081:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
5082:             loc_oPg1.txt_4c_Mpvenda.Value = loc_cCod
5083:         ENDIF
5084:     ENDPROC
5085: 
5086:     *--------------------------------------------------------------------------
5087:     * AbrirLookupDadosMfvenda - Lookup moeda fator venda (SigCdMoe: CMoes/DMoes)
5088:     *--------------------------------------------------------------------------
5089:     PROCEDURE AbrirLookupDadosMfvenda()
5090:         LOCAL loc_oBusca, loc_cCod, loc_oPg1
5091:         loc_oBusca = .NULL.
5092:         loc_cCod   = ""
5093:         TRY
5094:             IF USED("cursor_4c_Busca")
5095:                 USE IN cursor_4c_Busca
5096:             ENDIF
5097:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5098:                 SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_Busca")
5099:             ENDIF
5100:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5101:             IF !ISNULL(loc_oBusca)
5102:                 loc_oBusca.this_cTabela        = "SigCdMoe"
5103:                 loc_oBusca.this_cCampoChave    = "CMoes"
5104:                 loc_oBusca.this_cCampoBusca    = "CMoes"
5105:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5106:                 loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
5107:                 loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5108:                 loc_oBusca.Caption = "Buscar Moeda (Fator Venda)"
5109:                 loc_oBusca.Show()
5110:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5111:                     loc_cCod = ALLTRIM(cursor_4c_Busca.CMoes)
5112:                 ENDIF
5113:                 IF USED("cursor_4c_Busca")
5114:                     USE IN cursor_4c_Busca
5115:                 ENDIF
5116:                 loc_oBusca.Release()
5117:             ENDIF
5118:         CATCH TO loc_oErro
5119:             MsgErro("Erro na busca de moeda:" + CHR(13) + loc_oErro.Message, "Erro")
5120:         ENDTRY
5121:         loc_oBusca = .NULL.
5122:         IF !EMPTY(loc_cCod)
5123:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
5124:             loc_oPg1.txt_4c_Mfvenda.Value = loc_cCod
5125:         ENDIF
5126:     ENDPROC
5127: 
5128:     *==========================================================================
5129:     *-- AUXILIAR - Carrega descricoes lookup ao abrir registro
5130:     *==========================================================================
5131: 
5132:     *--------------------------------------------------------------------------
5133:     * CarregarDescricoesForm - Carrega descricoes dos campos lookup na pagina Dados
5134:     * Chamado por BOParaForm quando gnConnHandle esta disponivel
5135:     *--------------------------------------------------------------------------
5136:     PROTECTED PROCEDURE CarregarDescricoesForm(par_oPg1)
5137:         LOCAL loc_cSQL, loc_nResult, loc_cCgru, loc_cLin, loc_cCol, loc_cIfor
5138:         LOCAL loc_cCodFinP, loc_cCodacb
5139: 
5140:         *-- Grupo
5141:         loc_cCgru = ALLTRIM(par_oPg1.txt_4c_Cgru.Value)
5142:         IF !EMPTY(loc_cCgru)
5143:             loc_cSQL    = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
5144:                           "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
5145:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruBof")
5146:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruBof") > 0
5147:                 par_oPg1.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_GruBof.DGrus)
5148:             ENDIF
5149:             IF USED("cursor_4c_GruBof")
5150:                 USE IN cursor_4c_GruBof
5151:             ENDIF
5152:         ENDIF
5153: 
5154:         *-- Linha
5155:         loc_cLin = ALLTRIM(par_oPg1.txt_4c_Lin.Value)
5156:         IF !EMPTY(loc_cLin)
5157:             loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdLin " + ;
5158:                           "WHERE Linhas = " + EscaparSQL(PADR(loc_cLin, 10))
5159:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinBof")
5160:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_LinBof") > 0
5161:                 par_oPg1.txt_4c_DLin.Value = ALLTRIM(cursor_4c_LinBof.Descs)
5162:             ENDIF
5163:             IF USED("cursor_4c_LinBof")
5164:                 USE IN cursor_4c_LinBof
5165:             ENDIF
5166:         ENDIF
5167: 
5168:         *-- Colecao/Grupo de Venda
5169:         loc_cCol = ALLTRIM(par_oPg1.txt_4c_Col.Value)
5170:         IF !EMPTY(loc_cCol)
5171:             loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SIGCDCOL " + ;
5172:                           "WHERE Colecoes = " + EscaparSQL(PADR(loc_cCol, 10))
5173:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ColBof")
5174:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ColBof") > 0
5175:                 par_oPg1.txt_4c_DCol.Value = ALLTRIM(cursor_4c_ColBof.Descs)
5176:             ENDIF

*-- Linhas 5269 a 5686:
5269:     *--------------------------------------------------------------------------
5270:     * AjustarBotoesPorModo - Ajusta visibilidade/estado dos botoes por modo atual
5271:     *--------------------------------------------------------------------------
5272:     PROTECTED PROCEDURE AjustarBotoesPorModo()
5273:         LOCAL loc_oPg1, loc_oPg2, loc_lEditing
5274:         loc_oPg1    = THIS.pgf_4c_Paginas.Page1
5275:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
5276:         loc_lEditing = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
5277: 
5278:         *-- Botoes CRUD habilitados apenas em modo LISTA
5279:         IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
5280:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled   = (THIS.this_cModoAtual = "LISTA")
5281:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = (THIS.this_cModoAtual = "LISTA")
5282:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled   = (THIS.this_cModoAtual = "LISTA")
5283:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled   = (THIS.this_cModoAtual = "LISTA")
5284:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled    = (THIS.this_cModoAtual = "LISTA")
5285:         ENDIF
5286: 
5287:         *-- Botoes Confirmar/Cancelar
5288:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
5289:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
5290:             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
5291:         ENDIF
5292:     ENDPROC
5293: 
5294:     *--------------------------------------------------------------------------
5295:     * ObterCodigoSelecionado - Retorna codigo do registro selecionado no grid
5296:     *--------------------------------------------------------------------------
5297:     PROTECTED PROCEDURE ObterCodigoSelecionado()
5298:         IF USED("cursor_4c_Lista") AND RECCOUNT("cursor_4c_Lista") > 0
5299:             SELECT cursor_4c_Lista
5300:             RETURN ALLTRIM(cursor_4c_Lista.cpros)
5301:         ENDIF
5302:         RETURN ""
5303:     ENDPROC
5304: 
5305:     *==========================================================================
5306:     *-- HANDLERS DE BOTOES - Page1 (Lista)
5307:     *==========================================================================
5308: 
5309:     *--------------------------------------------------------------------------
5310:     * BtnIncluirClick - Modo INCLUIR: prepara formulario para novo registro
5311:     *--------------------------------------------------------------------------
5312:     PROCEDURE BtnIncluirClick()
5313:         THIS.this_cModoAtual   = "INCLUIR"
5314:         THIS.this_lNovoRegistro = .T.
5315:         THIS.this_oBusinessObject.NovoRegistro()
5316:         THIS.LimparCampos()
5317:         THIS.HabilitarCampos(.T., .T.)
5318:         THIS.AlternarPagina(2)
5319:     ENDPROC
5320: 
5321:     *--------------------------------------------------------------------------
5322:     * BtnVisualizarClick - Modo VISUALIZAR: abre registro selecionado somente leitura
5323:     *--------------------------------------------------------------------------
5324:     PROCEDURE BtnVisualizarClick()
5325:         LOCAL loc_cCodigo
5326:         loc_cCodigo = THIS.ObterCodigoSelecionado()
5327:         IF EMPTY(loc_cCodigo)
5328:             MsgAviso("Selecione um produto na lista.", "Aviso")
5329:             RETURN
5330:         ENDIF
5331:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
5332:             THIS.this_cModoAtual   = "VISUALIZAR"
5333:             THIS.this_lNovoRegistro = .F.
5334:             THIS.BOParaForm()
5335:             THIS.HabilitarCampos(.F., .F.)
5336:             THIS.AlternarPagina(2)
5337:         ELSE
5338:             MsgErro("Produto n" + CHR(227) + "o encontrado.", "Erro")
5339:         ENDIF
5340:     ENDPROC
5341: 
5342:     *--------------------------------------------------------------------------
5343:     * BtnAlterarClick - Modo ALTERAR: abre registro para edicao
5344:     *--------------------------------------------------------------------------
5345:     PROCEDURE BtnAlterarClick()
5346:         LOCAL loc_cCodigo
5347:         loc_cCodigo = THIS.ObterCodigoSelecionado()
5348:         IF EMPTY(loc_cCodigo)
5349:             MsgAviso("Selecione um produto na lista.", "Aviso")
5350:             RETURN
5351:         ENDIF
5352:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
5353:             THIS.this_cModoAtual   = "ALTERAR"
5354:             THIS.this_lNovoRegistro = .F.
5355:             THIS.this_oBusinessObject.EditarRegistro()
5356:             THIS.BOParaForm()
5357:             THIS.HabilitarCampos(.T., .F.)
5358:             THIS.AlternarPagina(2)
5359:         ELSE
5360:             MsgErro("Produto n" + CHR(227) + "o encontrado.", "Erro")
5361:         ENDIF
5362:     ENDPROC
5363: 
5364:     *--------------------------------------------------------------------------
5365:     * BtnExcluirClick - Confirma e executa exclusao do registro selecionado
5366:     *--------------------------------------------------------------------------
5367:     PROCEDURE BtnExcluirClick()
5368:         LOCAL loc_cCodigo, loc_lConfirmado
5369:         loc_cCodigo     = THIS.ObterCodigoSelecionado()
5370:         loc_lConfirmado = .F.
5371:         IF EMPTY(loc_cCodigo)
5372:             MsgAviso("Selecione um produto na lista.", "Aviso")
5373:             RETURN
5374:         ENDIF
5375:         loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto " + ALLTRIM(loc_cCodigo) + "?", "Confirmar Exclus" + CHR(227) + "o")
5376:         IF loc_lConfirmado
5377:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
5378:                 IF !THIS.this_oBusinessObject.Excluir()
5379:                     MsgErro("Erro ao excluir produto: " + THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
5380:                 ELSE
5381:                     THIS.CarregarLista()
5382:                 ENDIF
5383:             ENDIF
5384:         ENDIF
5385:     ENDPROC
5386: 
5387:     *--------------------------------------------------------------------------
5388:     * BtnBuscarClick - Abre busca auxiliar de produtos
5389:     *--------------------------------------------------------------------------
5390:     PROCEDURE BtnBuscarClick()
5391:         LOCAL loc_oBusca, loc_cCodigo
5392:         loc_oBusca  = .NULL.
5393:         loc_cCodigo = ""
5394:         TRY
5395:             IF USED("cursor_4c_Busca")
5396:                 USE IN cursor_4c_Busca
5397:             ENDIF
5398:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5399:                 SQLEXEC(gnConnHandle, "SELECT CPros AS cpros, DPros AS dpros, CGrus AS cgrus FROM SigCdPro ORDER BY CPros", "cursor_4c_Busca")
5400:             ENDIF
5401:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5402:             IF !ISNULL(loc_oBusca)
5403:                 loc_oBusca.this_cTabela        = "SigCdPro"
5404:                 loc_oBusca.this_cCampoChave    = "cpros"
5405:                 loc_oBusca.this_cCampoBusca    = "cpros"
5406:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5407:                 loc_oBusca.mAddColuna("cpros",  "XXXXXXXXXXXXXXXXXXXXXXXXXX", "Produto")
5408:                 loc_oBusca.mAddColuna("dpros",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5409:                 loc_oBusca.mAddColuna("cgrus",  "XXXXX", "Grupo")
5410:                 loc_oBusca.Caption = "Buscar Produto"
5411:                 loc_oBusca.Show()
5412:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5413:                     loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)
5414:                 ENDIF
5415:                 IF USED("cursor_4c_Busca")
5416:                     USE IN cursor_4c_Busca
5417:                 ENDIF
5418:                 loc_oBusca.Release()
5419:             ENDIF
5420:         CATCH TO loc_oErro
5421:             MsgErro("Erro na busca de produtos:" + CHR(13) + loc_oErro.Message, "Erro")
5422:         ENDTRY
5423:         loc_oBusca = .NULL.
5424:         IF !EMPTY(loc_cCodigo)
5425:             THIS.CarregarLista()
5426:         ENDIF
5427:     ENDPROC
5428: 
5429:     *--------------------------------------------------------------------------
5430:     * BtnEncerrarClick - Encerra o formulario
5431:     *--------------------------------------------------------------------------
5432:     PROCEDURE BtnEncerrarClick()
5433:         THIS.Release()
5434:     ENDPROC
5435: 
5436:     *==========================================================================
5437:     *-- HANDLERS DE BOTOES - Page2 (Dados)
5438:     *==========================================================================
5439: 
5440:     *--------------------------------------------------------------------------
5441:     * BtnConfirmarClick - Salva registro (Inserir ou Atualizar)
5442:     * FASE 5: Implementar FormParaBO() + chamada ao BO
5443:     *--------------------------------------------------------------------------
5444:     PROCEDURE BtnConfirmarClick()
5445:         LOCAL loc_lSucesso
5446:         loc_lSucesso = .F.
5447:         TRY
5448:             THIS.FormParaBO()
5449:             IF THIS.this_lNovoRegistro
5450:                 loc_lSucesso = THIS.this_oBusinessObject.Inserir()
5451:             ELSE
5452:                 loc_lSucesso = THIS.this_oBusinessObject.Atualizar()
5453:             ENDIF
5454:             IF loc_lSucesso
5455:                 THIS.this_cModoAtual = "LISTA"
5456:                 THIS.AlternarPagina(1)
5457:                 THIS.CarregarLista()
5458:             ELSE
5459:                 MsgErro("Erro ao salvar produto: " + THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
5460:             ENDIF
5461:         CATCH TO loc_oErro
5462:             MsgErro("Erro ao confirmar produto:" + CHR(13) + loc_oErro.Message, "Erro")
5463:         ENDTRY
5464:     ENDPROC
5465: 
5466:     *--------------------------------------------------------------------------
5467:     * BtnCancelarClick - Cancela edicao e retorna para Lista
5468:     *--------------------------------------------------------------------------
5469:     PROCEDURE BtnCancelarClick()
5470:         THIS.this_cModoAtual = "LISTA"
5471:         THIS.AlternarPagina(1)
5472:     ENDPROC
5473: 
5474:     *--------------------------------------------------------------------------
5475:     * GrdListaDblClick - Duplo clique no grid abre registro para visualizacao
5476:     *--------------------------------------------------------------------------
5477:     PROCEDURE GrdListaDblClick()
5478:         THIS.BtnVisualizarClick()
5479:     ENDPROC
5480: 
5481:     *--------------------------------------------------------------------------
5482:     * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
5483:     * par_nPagina: 1=Lista, 2=Dados
5484:     *--------------------------------------------------------------------------
5485:     PROCEDURE AlternarPagina(par_nPagina)
5486:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
5487:         IF par_nPagina = 2
5488:             THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.ActivePage = 1
5489:             THIS.pgf_4c_Paginas.Page2.obj_4c_NavegacaoDados.Value      = 1
5490:         ENDIF
5491:         THIS.AjustarBotoesPorModo()
5492:     ENDPROC
5493: 
5494:     *--------------------------------------------------------------------------
5495:     * FiltroGrupoKeyPress - Handler KeyPress no txt_4c_Cgru
5496:     * ENTER(13) ou TAB(9): valida e recarrega lista
5497:     * F4(115): abre lookup de grupos
5498:     *--------------------------------------------------------------------------
5499:     PROCEDURE FiltroGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5500:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
5501:             THIS.ValidarGrupoFiltro()
5502:         ENDIF
5503:         IF par_nKeyCode = 115
5504:             THIS.AbrirLookupGrupo()
5505:         ENDIF
5506:     ENDPROC
5507: 
5508:     *--------------------------------------------------------------------------
5509:     * FiltroSituaChange - Handler InteractiveChange no obj_4c_Situa
5510:     * Recarrega lista quando usuario altera filtro de situacao
5511:     *--------------------------------------------------------------------------
5512:     PROCEDURE FiltroSituaChange()
5513:         THIS.CarregarLista()
5514:     ENDPROC
5515: 
5516:     *--------------------------------------------------------------------------
5517:     * AbrirLookupGrupo - Abre FormBuscaAuxiliar para selecionar grupo de produto
5518:     * Chama SigCdGrp (cgrus, dgrus)
5519:     *--------------------------------------------------------------------------
5520:     PROCEDURE AbrirLookupGrupo()
5521:         LOCAL loc_oBusca, loc_cCgru, loc_cDgru, loc_oPg1
5522:         loc_oBusca = .NULL.
5523:         loc_cCgru  = ""
5524:         loc_cDgru  = ""
5525:         TRY
5526:             IF USED("cursor_4c_Busca")
5527:                 USE IN cursor_4c_Busca
5528:             ENDIF
5529:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5530:                 SQLEXEC(gnConnHandle, "SELECT CGrus AS cgrus, DGrus AS dgrus FROM SigCdGrp ORDER BY CGrus", "cursor_4c_Busca")
5531:             ENDIF
5532:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5533:             IF !ISNULL(loc_oBusca)
5534:                 loc_oBusca.this_cTabela        = "SigCdGrp"
5535:                 loc_oBusca.this_cCampoChave    = "cgrus"
5536:                 loc_oBusca.this_cCampoBusca    = "cgrus"
5537:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5538:                 loc_oBusca.mAddColuna("cgrus", "XXXXX",                                     "Grupo")
5539:                 loc_oBusca.mAddColuna("dgrus", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5540:                 loc_oBusca.Caption = "Buscar Grupo de Produto"
5541:                 loc_oBusca.Show()
5542:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5543:                     loc_cCgru = ALLTRIM(cursor_4c_Busca.cgrus)
5544:                     loc_cDgru = ALLTRIM(cursor_4c_Busca.dgrus)
5545:                 ENDIF
5546:                 IF USED("cursor_4c_Busca")
5547:                     USE IN cursor_4c_Busca
5548:                 ENDIF
5549:                 loc_oBusca.Release()
5550:             ENDIF
5551:         CATCH TO loc_oErro
5552:             MsgErro("Erro na busca de grupo:" + CHR(13) + loc_oErro.Message, "Erro")
5553:         ENDTRY
5554:         loc_oBusca = .NULL.
5555:         IF !EMPTY(loc_cCgru)
5556:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
5557:             loc_oPg1.cnt_4c_Filtros.txt_4c_Cgru.Value = loc_cCgru
5558:             loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = loc_cDgru
5559:             THIS.CarregarLista()
5560:         ENDIF
5561:     ENDPROC
5562: 
5563:     *--------------------------------------------------------------------------
5564:     * ValidarGrupoFiltro - Valida codigo de grupo e carrega descricao + lista
5565:     * Chamado em ENTER/TAB no txt_4c_Cgru
5566:     *--------------------------------------------------------------------------
5567:     PROTECTED PROCEDURE ValidarGrupoFiltro()
5568:         LOCAL loc_oPg1, loc_cCgru, loc_cSQL, loc_nResult
5569:         loc_oPg1  = THIS.pgf_4c_Paginas.Page1
5570:         loc_cCgru = ALLTRIM(loc_oPg1.cnt_4c_Filtros.txt_4c_Cgru.Value)
5571:         IF EMPTY(loc_cCgru)
5572:             loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
5573:         ELSE
5574:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5575:                 loc_cSQL = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
5576:                            "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
5577:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruFiltro")
5578:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruFiltro") > 0
5579:                     loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_GruFiltro.DGrus)
5580:                 ELSE
5581:                     loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
5582:                     loc_oPg1.cnt_4c_Filtros.txt_4c_Cgru.Value = ""
5583:                 ENDIF
5584:                 IF USED("cursor_4c_GruFiltro")
5585:                     USE IN cursor_4c_GruFiltro
5586:                 ENDIF
5587:             ENDIF
5588:         ENDIF
5589:         THIS.CarregarLista()
5590:     ENDPROC
5591: 
5592:     *==========================================================================
5593:     *-- METODOS AUXILIARES
5594:     *==========================================================================
5595: 
5596:     *--------------------------------------------------------------------------
5597:     * FormatarGridLista - Formata visual do grid de lista
5598:     *--------------------------------------------------------------------------
5599:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
5600:         WITH par_oGrid
5601:             IF .ColumnCount > 0
5602:                 .FontName = "Tahoma"
5603:                 .FontSize = 8
5604:             ENDIF
5605:         ENDWITH
5606:     ENDPROC
5607: 
5608:     *--------------------------------------------------------------------------
5609:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
5610:     * Filtro por nome evita tornar visiveis containers flutuantes (Visible=.F.)
5611:     *--------------------------------------------------------------------------
5612:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
5613:         LOCAL loc_nI, loc_oObjeto
5614: 
5615:         FOR loc_nI = 1 TO par_oContainer.ControlCount
5616:             loc_oObjeto = par_oContainer.Controls(loc_nI)
5617: 
5618:             IF VARTYPE(loc_oObjeto) = "O"
5619:                 *-- Nao tornar visiveis containers flutuantes (iniciam com cnt_4c_Float)
5620:                 IF LEFT(LOWER(loc_oObjeto.Name), 13) != "cnt_4c_float_"
5621:                     IF PEMSTATUS(loc_oObjeto, "Visible", 5)
5622:                         loc_oObjeto.Visible = .T.
5623:                     ENDIF
5624:                 ENDIF
5625: 
5626:                 *-- Trata PageFrame - itera Pages
5627:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
5628:                     LOCAL loc_nP
5629:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
5630:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
5631:                     ENDFOR
5632:                 ENDIF
5633: 
5634:                 *-- Trata containers com ControlCount
5635:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
5636:                     THIS.TornarControlesVisiveis(loc_oObjeto)
5637:                 ENDIF
5638:             ENDIF
5639:         ENDFOR
5640:     ENDPROC
5641: 
5642:     *--------------------------------------------------------------------------
5643:     * LimparCampos - Limpa todos os campos do formulario (Page2/pgDados)
5644:     * Chamado ao entrar em modo INCLUIR para garantir campos zerados
5645:     *--------------------------------------------------------------------------
5646:     PROTECTED PROCEDURE LimparCampos()
5647:         LOCAL loc_oPg1
5648:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
5649: 
5650:         TRY
5651:             *-- ROW 1: Produto + Descricao + Status
5652:             loc_oPg1.txt_4c_Cpro.Value          = ""
5653:             loc_oPg1.txt_4c_Dpro.Value          = ""
5654:             loc_oPg1.obj_4c_OpcSituacao.Value   = 1
5655:             loc_oPg1.txt_4c_DtSituas.Value      = DATE()
5656: 
5657:             *-- ROW 2: Descritivo + CProEq + Cbar + LtMinsV
5658:             loc_oPg1.txt_4c_DPro2s.Value        = ""
5659:             loc_oPg1.txt_4c_CProEq.Value        = ""
5660:             loc_oPg1.txt_4c_Cbar.Value          = 0
5661:             loc_oPg1.txt_4c_LtMinsV.Value       = 0
5662: 
5663:             *-- ROW 3: Grupo + Merc + IdeCPros + EAN13 + ProdWeb
5664:             loc_oPg1.txt_4c_Cgru.Value          = ""
5665:             loc_oPg1.txt_4c_Dgru.Value          = ""
5666:             loc_oPg1.txt_4c_Merc.Value          = ""
5667:             loc_oPg1.txt_4c_IdeCPros.Value      = ""
5668:             loc_oPg1.txt_4c_EAN13.Value         = 0
5669:             loc_oPg1.obj_4c_ProdWeb.Value       = 1
5670: 
5671:             *-- ROW 4: Subgrupo + Variacao
5672:             loc_oPg1.txt_4c_CSGru.Value         = ""
5673:             loc_oPg1.txt_4c_DsGru.Value         = ""
5674:             loc_oPg1.obj_4c_Variacao.Value      = 1
5675: 
5676:             *-- ROW 5: Linha + Garantia
5677:             loc_oPg1.txt_4c_Lin.Value           = ""
5678:             loc_oPg1.txt_4c_DLin.Value          = ""
5679:             loc_oPg1.txt_4c_DiasGar.Value       = 0
5680:             loc_oPg1.chk_4c_GarVit.Value        = 0
5681: 
5682:             *-- ROW 6: Colecao/Grupo de Venda + Obs3
5683:             loc_oPg1.txt_4c_Col.Value           = ""
5684:             loc_oPg1.txt_4c_DCol.Value          = ""
5685:             loc_oPg1.txt_4c_Obs3.Value          = ""
5686: 

*-- Linhas 5768 a 5784:
5768:     *--------------------------------------------------------------------------
5769:     * Destroy - Limpeza ao fechar formulario
5770:     *--------------------------------------------------------------------------
5771:     PROCEDURE Destroy()
5772:         IF USED("cursor_4c_Lista")
5773:             USE IN cursor_4c_Lista
5774:         ENDIF
5775:         IF USED("cursor_4c_Dados")
5776:             USE IN cursor_4c_Dados
5777:         ENDIF
5778:         IF !ISNULL(THIS.this_oBusinessObject)
5779:             THIS.this_oBusinessObject = .NULL.
5780:         ENDIF
5781:         DODEFAULT()
5782:     ENDPROC
5783: 
5784: ENDDEFINE


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*==============================================================================
* ProdutoBO.prg - Business Object para Cadastro de Produtos
* Tabela: SigCdPro | PK: cpros (C14)
* Data: 2026-04-09
*==============================================================================

DEFINE CLASS ProdutoBO AS BusinessBase

    *-- Identificacao
    this_cCpros     = ""   && C(14) - Codigo do produto (PK)
    this_cDpros     = ""   && C(65) - Descricao principal
    this_cDpro2s    = ""   && C(45) - Descricao secundaria (descritivo)

    *-- Classificacao/grupo
    this_cCgrus     = ""   && C(3)  - Grupo
    this_cSgrus     = ""   && C(6)  - Subgrupo
    this_cLinhas    = ""   && C(10) - Linha
    this_cColecoes  = ""   && C(10) - Colecao / Grupo de Venda
    this_cMercs     = ""   && C(3)  - Mercado
    this_cIdecpros  = ""   && C(3)  - Identificador
    this_cCclass    = ""   && C(3)  - Classificacao

    *-- Fornecedor
    this_cIfors     = ""   && C(10) - Codigo do fornecedor
    this_cReffs     = ""   && C(40) - Referencia do fornecedor

    *-- Codigos produto
    this_cCodfinp   = ""   && C(3)  - Codigo do modelo (finishing product)
    this_cCodacbs   = ""   && C(3)  - Codigo do acabamento
    this_cCodcors   = ""   && C(4)  - Codigo da cor
    this_cCodtams   = ""   && C(4)  - Codigo do tamanho
    this_cCproeqs   = ""   && C(14) - Produto equivalente

    *-- Status e datas
    this_nSituas    = 1    && N(1)  - Status: 1=Ativo, 2=Inativo
    this_dDatas     = {}   && Date  - Data do status
    this_dDtincs    = {}   && Date  - Data de inclusao (read-only)
    this_cUsuincs   = ""   && C(10) - Usuario de inclusao

    *-- Codigos de barra
    this_nCbars     = 0    && N(14,0) - Codigo de barra
    this_nEan13     = 0    && N(13,0) - EAN13/GTIN

    *-- Quantidades e lotes
    this_nLtminsv   = 0    && N(9,3) - Lote minimo de venda
    this_nQmins     = 0    && N(9,3) - Quantidade minima
    this_nQtped     = 0    && N(9,3) - Quantidade de pedido

    *-- Unidades
    this_cCunis     = ""   && C(3)  - Unidade (1)
    this_cCunips    = ""   && C(3)  - Unidade (2)

    *-- Pesos e dimensoes
    this_nPesobs    = 0    && N(7,3) - Peso bruto
    this_nPesoms    = 0    && N(8,3) - Peso medio/liquido

    *-- Localizacao
    this_cLocals    = ""   && C(10) - Local

    *-- Precos e custos
    this_nPvens     = 0    && N(11,5) - Preco de venda
    this_nFvendas   = 0    && N(7,3)  - Fator de venda
    this_nPcuss     = 0    && N(11,5) - Preco de custo
    this_cMoecs     = ""   && C(3)   - Moeda de custo
    this_cMoepvs    = ""   && C(3)   - Moeda de venda

    *-- Ultima compra
    this_dUltcomps  = {}   && Date  - Data da ultima compra
    this_nVultcomps = 0    && N(11,2) - Valor da ultima compra
    this_cMultcomps = ""   && C(3)   - Moeda da ultima compra
    this_nQultcomp  = 0    && N(9,3) - Qtde da ultima compra

    *-- Dias de garantia
    this_nDiasinas  = 0    && N(5,0) - Dias de garantia/inatividade

    *-- Checkboxes
    this_nConsigs   = 0    && N(1) - Consignado
    this_nFabrproprs= 0    && N(1) - Fabricacao propria
    this_nEncoms    = 0    && N(1) - Encomenda
    this_nChkfunds  = 0    && N(1) - Fundo

    *-- Observacoes
    this_cObspeds   = ""   && C(30) - Observacao 1
    this_cObspes    = ""   && C(30) - Observacao 2
    this_cObsetqs   = ""   && C(10) - Observacao componente

    *-- Memos (text fields)
    this_cDpro3s    = ""   && text  - Descricao completa
    this_cDsccompras= ""   && text  - Descricao compra
    this_cObscompras= ""   && text  - Observacao compra

    *-- Variacao e web
    this_nVarias    = 0    && N(1) - Variacao (0=nenhum, 1=cor-tam)
    this_nWebpros   = 0    && N(1) - Produto web (0=nenhum, 1=sim, 2=nao, 3=destaque)

    *-- Dimensoes
    this_nTamhs     = 0    && N(5,2) - Altura
    this_nTamls     = 0    && N(5,2) - Largura
    this_nTamps     = 0    && N(5,2) - Profundidade
    this_nVolumes   = 0    && N(3,0) - Volumes
    this_nTents     = 0    && N(3,0) - Entradas

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCpros
    ENDPROC

    *--------------------------------------------------------------------------
    * NovoRegistro - Limpa propriedades para inclusao
    *--------------------------------------------------------------------------
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cCpros      = ""
        THIS.this_cDpros      = ""
        THIS.this_cDpro2s     = ""
        THIS.this_cCgrus      = ""
        THIS.this_cSgrus      = ""
        THIS.this_cLinhas     = ""
        THIS.this_cColecoes   = ""
        THIS.this_cMercs      = ""
        THIS.this_cIdecpros   = ""
        THIS.this_cCclass     = ""
        THIS.this_cIfors      = ""
        THIS.this_cReffs      = ""
        THIS.this_cCodfinp    = ""
        THIS.this_cCodacbs    = ""
        THIS.this_cCodcors    = ""
        THIS.this_cCodtams    = ""
        THIS.this_cCproeqs    = ""
        THIS.this_nSituas     = 1
        THIS.this_dDatas      = DATE()
        THIS.this_dDtincs     = DATE()
        THIS.this_cUsuincs    = gc_4c_UsuarioLogado
        THIS.this_nCbars      = 0
        THIS.this_nEan13      = 0
        THIS.this_nLtminsv    = 0
        THIS.this_nQmins      = 0
        THIS.this_nQtped      = 0
        THIS.this_cCunis      = ""
        THIS.this_cCunips     = ""
        THIS.this_nPesobs     = 0
        THIS.this_nPesoms     = 0
        THIS.this_cLocals     = ""
        THIS.this_nPvens      = 0
        THIS.this_nFvendas    = 1
        THIS.this_nPcuss      = 0
        THIS.this_cMoecs      = ""
        THIS.this_cMoepvs     = ""
        THIS.this_dUltcomps   = {}
        THIS.this_nVultcomps  = 0
        THIS.this_cMultcomps  = ""
        THIS.this_nQultcomp   = 0
        THIS.this_nDiasinas   = 0
        THIS.this_nConsigs    = 0
        THIS.this_nFabrproprs = 0
        THIS.this_nEncoms     = 0
        THIS.this_nChkfunds   = 0
        THIS.this_cObspeds    = ""
        THIS.this_cObspes     = ""
        THIS.this_cObsetqs    = ""
        THIS.this_cDpro3s     = ""
        THIS.this_cDsccompras = ""
        THIS.this_cObscompras = ""
        THIS.this_nVarias     = 0
        THIS.this_nWebpros    = 0
        THIS.this_nTamhs      = 0
        THIS.this_nTamls      = 0
        THIS.this_nTamps      = 0
        THIS.this_nVolumes    = 0
        THIS.this_nTents      = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * EditarRegistro - Prepara para edicao (dados ja carregados via CarregarPorCodigo)
    *--------------------------------------------------------------------------
    PROCEDURE EditarRegistro()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega cursor_4c_Dados com registros conforme filtro
    * par_cFiltro: "" = todos | "WHERE ..." = com filtro
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_aErros(1)
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lResultado = .T.
            ELSE
                loc_cSQL = "SELECT " + ;
                    "ISNULL(CPros,'')       AS cpros, " + ;
                    "ISNULL(DPros,'')       AS dpros, " + ;
                    "ISNULL(DPro2s,'')      AS dpro2s, " + ;
                    "ISNULL(CGrus,'')       AS cgrus, " + ;
                    "ISNULL(SGrus,'')       AS sgrus, " + ;
                    "ISNULL(Linhas,'')      AS linhas, " + ;
                    "ISNULL(Colecoes,'')    AS colecoes, " + ;
                    "ISNULL(Mercs,'')       AS mercs, " + ;
                    "ISNULL(IdeCPros,'')    AS idecpros, " + ;
                    "ISNULL(CClass,'')      AS cclass, " + ;
                    "ISNULL(IFors,'')       AS ifors, " + ;
                    "ISNULL(Reffs,'')       AS reffs, " + ;
                    "ISNULL(CodFinP,'')     AS codfinp, " + ;
                    "ISNULL(CodAcbs,'')     AS codacbs, " + ;
                    "ISNULL(CodCors,'')     AS codcors, " + ;
                    "ISNULL(CodTams,'')     AS codtams, " + ;
                    "ISNULL(CProEqs,'')     AS cproeqs, " + ;
                    "ISNULL(Situas,1)       AS situas, " + ;
                    "ISNULL(Datas,GETDATE()) AS datas, " + ;
                    "ISNULL(DtIncs,GETDATE()) AS dtincs, " + ;
                    "ISNULL(UsuIncs,'')     AS usuincs, " + ;
                    "ISNULL(CBars,0)        AS cbars, " + ;
                    "ISNULL(EAN13,0)        AS ean13, " + ;
                    "ISNULL(LtMinsV,0)      AS ltminsv, " + ;
                    "ISNULL(QMins,0)        AS qmins, " + ;
                    "ISNULL(QtPed,0)        AS qtped, " + ;
                    "ISNULL(Locals,'')      AS locals, " + ;
                    "ISNULL(CUnis,'')       AS cunis, " + ;
                    "ISNULL(CUniPs,'')      AS cunips, " + ;
                    "ISNULL(PesoBS,0)       AS pesobs, " + ;
                    "ISNULL(PesoMs,0)       AS pesoms, " + ;
                    "ISNULL(PVens,0)        AS pvens, " + ;
                    "ISNULL(FVendas,1)      AS fvendas, " + ;
                    "ISNULL(PCuss,0)        AS pcuss, " + ;
                    "ISNULL(MoECs,'')       AS moecs, " + ;
                    "ISNULL(MoePVs,'')      AS moepvs, " + ;
                    "ISNULL(UltComps,NULL)  AS ultcomps, " + ;
                    "ISNULL(VultComps,0)    AS vultcomps, " + ;
                    "ISNULL(MultComps,'')   AS multcomps, " + ;
                    "ISNULL(qtdultcomp,0)   AS qultcomp, " + ;
                    "ISNULL(DiasINas,0)     AS diasinas, " + ;
                    "ISNULL(ConSigs,0)      AS consigs, " + ;
                    "ISNULL(FabrProprs,0)   AS fabrproprs, " + ;
                    "ISNULL(EnComs,0)       AS encoms, " + ;
                    "ISNULL(ChkFunds,0)     AS chkfunds, " + ;
                    "ISNULL(ObsPeds,'')     AS obspeds, " + ;
                    "ISNULL(ObsPes,'')      AS obspes, " + ;
                    "ISNULL(ObsEtqs,'')     AS obsetqs, " + ;
                    "ISNULL(DPro3s,'')      AS dpro3s, " + ;
                    "ISNULL(DscCompras,'')  AS dsccompras, " + ;
                    "ISNULL(ObsCompras,'')  AS obscompras, " + ;
                    "ISNULL(Varias,0)       AS varias, " + ;
                    "ISNULL(prodwebs,0)     AS webpros, " + ;
                    "ISNULL(TamHs,0)        AS tamhs, " + ;
                    "ISNULL(TamLs,0)        AS tamls, " + ;
                    "ISNULL(TamPs,0)        AS tamps, " + ;
                    "ISNULL(Volumes,0)      AS volumes, " + ;
                    "ISNULL(TEnts,0)        AS tents " + ;
                    "FROM SigCdPro " + par_cFiltro + " ORDER BY CPros"

                IF USED("cursor_4c_Temp_Dados")
                    USE IN cursor_4c_Temp_Dados
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp_Dados")

                IF loc_nRet > 0
                    IF USED("cursor_4c_Dados")
                        USE IN cursor_4c_Dados
                    ENDIF
                    SELECT cursor_4c_Temp_Dados
                    IF RECCOUNT() > 0
                        SELECT * FROM cursor_4c_Temp_Dados INTO CURSOR cursor_4c_Dados READWRITE
                        SELECT cursor_4c_Dados
                    ELSE
                        SET NULL ON
                        CREATE CURSOR cursor_4c_Dados ;
                            (cpros C(14), dpros C(65), dpro2s C(45), cgrus C(3), sgrus C(6), ;
                             linhas C(10), colecoes C(10), mercs C(3), idecpros C(3), cclass C(3), ;
                             ifors C(10), reffs C(40), codfinp C(3), codacbs C(3), codcors C(4), ;
                             codtams C(4), cproeqs C(14), situas N(1,0), datas D, dtincs D, ;
                             usuincs C(10), cbars N(14,0), ean13 N(13,0), ltminsv N(9,3), ;
                             qmins N(9,3), qtped N(9,3), locals C(10), cunis C(3), cunips C(3), ;
                             pesobs N(7,3), pesoms N(8,3), pvens N(11,5), fvendas N(7,3), ;
                             pcuss N(11,5), moecs C(3), moepvs C(3), ultcomps D, ;
                             vultcomps N(11,2), multcomps C(3), qultcomp N(9,3), ;
                             diasinas N(5,0), consigs N(1,0), fabrproprs N(1,0), ;
                             encoms N(1,0), chkfunds N(1,0), obspeds C(30), obspes C(30), ;
                             obsetqs C(10), dpro3s C(254), dsccompras C(254), obscompras C(254), ;
                             varias N(1,0), webpros N(1,0), tamhs N(5,2), tamls N(5,2), ;
                             tamps N(5,2), volumes N(3,0), tents N(3,0))
                        SET NULL OFF
                    ENDIF
                    IF USED("cursor_4c_Temp_Dados")
                        USE IN cursor_4c_Temp_Dados
                    ENDIF
                    loc_lResultado = .T.
                ELSE
                    AERROR(loc_aErros)
                    THIS.this_cMensagemErro = "Erro SQL ao buscar produtos: " + TRANSFORM(loc_aErros(1,2))
                    IF USED("cursor_4c_Temp_Dados")
                        USE IN cursor_4c_Temp_Dados
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao buscar produtos")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega dados de um produto pelo codigo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_aErros(1)
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lResultado = .T.
            ELSE
                loc_cSQL = "SELECT " + ;
                    "ISNULL(CPros,'')       AS cpros, " + ;
                    "ISNULL(DPros,'')       AS dpros, " + ;
                    "ISNULL(DPro2s,'')      AS dpro2s, " + ;
                    "ISNULL(CGrus,'')       AS cgrus, " + ;
                    "ISNULL(SGrus,'')       AS sgrus, " + ;
                    "ISNULL(Linhas,'')      AS linhas, " + ;
                    "ISNULL(Colecoes,'')    AS colecoes, " + ;
                    "ISNULL(Mercs,'')       AS mercs, " + ;
                    "ISNULL(IdeCPros,'')    AS idecpros, " + ;
                    "ISNULL(CClass,'')      AS cclass, " + ;
                    "ISNULL(IFors,'')       AS ifors, " + ;
                    "ISNULL(Reffs,'')       AS reffs, " + ;
                    "ISNULL(CodFinP,'')     AS codfinp, " + ;
                    "ISNULL(CodAcbs,'')     AS codacbs, " + ;
                    "ISNULL(CodCors,'')     AS codcors, " + ;
                    "ISNULL(CodTams,'')     AS codtams, " + ;
                    "ISNULL(CProEqs,'')     AS cproeqs, " + ;
                    "ISNULL(Situas,1)       AS situas, " + ;
                    "CONVERT(date,ISNULL(Datas,GETDATE())) AS datas, " + ;
                    "CONVERT(date,ISNULL(DtIncs,GETDATE())) AS dtincs, " + ;
                    "ISNULL(UsuIncs,'')     AS usuincs, " + ;
                    "ISNULL(CBars,0)        AS cbars, " + ;
                    "ISNULL(EAN13,0)        AS ean13, " + ;
                    "ISNULL(LtMinsV,0)      AS ltminsv, " + ;
                    "ISNULL(QMins,0)        AS qmins, " + ;
                    "ISNULL(QtPed,0)        AS qtped, " + ;
                    "ISNULL(Locals,'')      AS locals, " + ;
                    "ISNULL(CUnis,'')       AS cunis, " + ;
                    "ISNULL(CUniPs,'')      AS cunips, " + ;
                    "ISNULL(PesoBS,0)       AS pesobs, " + ;
                    "ISNULL(PesoMs,0)       AS pesoms, " + ;
                    "ISNULL(PVens,0)        AS pvens, " + ;
                    "ISNULL(FVendas,1)      AS fvendas, " + ;
                    "ISNULL(PCuss,0)        AS pcuss, " + ;
                    "ISNULL(MoECs,'')       AS moecs, " + ;
                    "ISNULL(MoePVs,'')      AS moepvs, " + ;
                    "CONVERT(date,ISNULL(UltComps,NULL)) AS ultcomps, " + ;
                    "ISNULL(VultComps,0)    AS vultcomps, " + ;
                    "ISNULL(MultComps,'')   AS multcomps, " + ;
                    "ISNULL(qtdultcomp,0)   AS qultcomp, " + ;
                    "ISNULL(DiasINas,0)     AS diasinas, " + ;
                    "ISNULL(ConSigs,0)      AS consigs, " + ;
                    "ISNULL(FabrProprs,0)   AS fabrproprs, " + ;
                    "ISNULL(EnComs,0)       AS encoms, " + ;
                    "ISNULL(ChkFunds,0)     AS chkfunds, " + ;
                    "ISNULL(ObsPeds,'')     AS obspeds, " + ;
                    "ISNULL(ObsPes,'')      AS obspes, " + ;
                    "ISNULL(ObsEtqs,'')     AS obsetqs, " + ;
                    "ISNULL(CONVERT(varchar(2000),DPro3s),'')     AS dpro3s, " + ;
                    "ISNULL(CONVERT(varchar(2000),DscCompras),'') AS dsccompras, " + ;
                    "ISNULL(CONVERT(varchar(2000),ObsCompras),'') AS obscompras, " + ;
                    "ISNULL(Varias,0)       AS varias, " + ;
                    "ISNULL(prodwebs,0)     AS webpros, " + ;
                    "ISNULL(TamHs,0)        AS tamhs, " + ;
                    "ISNULL(TamLs,0)        AS tamls, " + ;
                    "ISNULL(TamPs,0)        AS tamps, " + ;
                    "ISNULL(Volumes,0)      AS volumes, " + ;
                    "ISNULL(TEnts,0)        AS tents " + ;
                    "FROM SigCdPro " + ;
                    "WHERE CPros = " + EscaparSQL(ALLTRIM(par_cCodigo))

                IF USED("cursor_4c_CarregaPro")
                    USE IN cursor_4c_CarregaPro
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaPro")

                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_CarregaPro") > 0
                    THIS.CarregarDoCursor("cursor_4c_CarregaPro")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cCodigo)
                ENDIF

                IF USED("cursor_4c_CarregaPro")
                    USE IN cursor_4c_CarregaPro
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao carregar produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor ativo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        SELECT (par_cAliasCursor)
        THIS.this_cCpros      = ALLTRIM(cpros)
        THIS.this_cDpros      = ALLTRIM(dpros)
        THIS.this_cDpro2s     = ALLTRIM(dpro2s)
        THIS.this_cCgrus      = ALLTRIM(cgrus)
        THIS.this_cSgrus      = ALLTRIM(sgrus)
        THIS.this_cLinhas     = ALLTRIM(linhas)
        THIS.this_cColecoes   = ALLTRIM(colecoes)
        THIS.this_cMercs      = ALLTRIM(mercs)
        THIS.this_cIdecpros   = ALLTRIM(idecpros)
        THIS.this_cCclass     = ALLTRIM(cclass)
        THIS.this_cIfors      = ALLTRIM(ifors)
        THIS.this_cReffs      = ALLTRIM(reffs)
        THIS.this_cCodfinp    = ALLTRIM(codfinp)
        THIS.this_cCodacbs    = ALLTRIM(codacbs)
        THIS.this_cCodcors    = ALLTRIM(codcors)
        THIS.this_cCodtams    = ALLTRIM(codtams)
        THIS.this_cCproeqs    = ALLTRIM(cproeqs)
        THIS.this_nSituas     = NVL(situas, 1)
        THIS.this_dDatas      = IIF(EMPTY(datas), DATE(), datas)
        THIS.this_dDtincs     = IIF(EMPTY(dtincs), DATE(), dtincs)
        THIS.this_cUsuincs    = ALLTRIM(usuincs)
        THIS.this_nCbars      = NVL(cbars, 0)
        THIS.this_nEan13      = NVL(ean13, 0)
        THIS.this_nLtminsv    = NVL(ltminsv, 0)
        THIS.this_nQmins      = NVL(qmins, 0)
        THIS.this_nQtped      = NVL(qtped, 0)
        THIS.this_cLocals     = ALLTRIM(locals)
        THIS.this_cCunis      = ALLTRIM(cunis)
        THIS.this_cCunips     = ALLTRIM(cunips)
        THIS.this_nPesobs     = NVL(pesobs, 0)
        THIS.this_nPesoms     = NVL(pesoms, 0)
        THIS.this_nPvens      = NVL(pvens, 0)
        THIS.this_nFvendas    = NVL(fvendas, 1)
        THIS.this_nPcuss      = NVL(pcuss, 0)
        THIS.this_cMoecs      = ALLTRIM(moecs)
        THIS.this_cMoepvs     = ALLTRIM(moepvs)
        THIS.this_dUltcomps   = IIF(EMPTY(ultcomps), {}, ultcomps)
        THIS.this_nVultcomps  = NVL(vultcomps, 0)
        THIS.this_cMultcomps  = ALLTRIM(multcomps)
        THIS.this_nQultcomp   = NVL(qultcomp, 0)
        THIS.this_nDiasinas   = NVL(diasinas, 0)
        THIS.this_nConsigs    = NVL(consigs, 0)
        THIS.this_nFabrproprs = NVL(fabrproprs, 0)
        THIS.this_nEncoms     = NVL(encoms, 0)
        THIS.this_nChkfunds   = NVL(chkfunds, 0)
        THIS.this_cObspeds    = ALLTRIM(obspeds)
        THIS.this_cObspes     = ALLTRIM(obspes)
        THIS.this_cObsetqs    = ALLTRIM(obsetqs)
        THIS.this_cDpro3s     = ALLTRIM(dpro3s)
        THIS.this_cDsccompras = ALLTRIM(dsccompras)
        THIS.this_cObscompras = ALLTRIM(obscompras)
        THIS.this_nVarias     = NVL(varias, 0)
        THIS.this_nWebpros    = NVL(webpros, 0)
        THIS.this_nTamhs      = NVL(tamhs, 0)
        THIS.this_nTamls      = NVL(tamls, 0)
        THIS.this_nTamps      = NVL(tamps, 0)
        THIS.this_nVolumes    = NVL(volumes, 0)
        THIS.this_nTents      = NVL(tents, 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo produto em SigCdPro
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.

        TRY
            *-- Verificar codigo duplicado
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                LOCAL loc_nExiste
                loc_nExiste = 0
                SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE CPros = " + ;
                    EscaparSQL(THIS.this_cCpros), "cursor_4c_ChkPro")
                IF USED("cursor_4c_ChkPro")
                    SELECT cursor_4c_ChkPro
                    loc_nExiste = nExiste
                    USE IN cursor_4c_ChkPro
                ENDIF
                IF loc_nExiste > 0
                    THIS.this_cMensagemErro = "Produto j" + CHR(225) + " existe: " + ALLTRIM(THIS.this_cCpros)
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            loc_cSQL = THIS.MontarSQL_INSERT()
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros(1)
                AERROR(loc_aErros)
                THIS.this_cMensagemErro = "Erro ao inserir produto: " + TRANSFORM(loc_aErros(1,2))
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao inserir produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza produto existente
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = THIS.MontarSQL_UPDATE()
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros(1)
                AERROR(loc_aErros)
                THIS.this_cMensagemErro = "Erro ao atualizar produto: " + TRANSFORM(loc_aErros(1,2))
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao atualizar produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove produto (chamado por Excluir() da BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, "DELETE FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(THIS.this_cCpros))
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao excluir produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSQL_INSERT - Gera SQL de insercao (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSQL_INSERT()
        LOCAL loc_cSQL
        loc_cSQL = "INSERT INTO SigCdPro " + ;
            "(CPros, DPros, DPro2s, CGrus, SGrus, Linhas, Colecoes, Mercs, IdeCPros, CClass, " + ;
            " IFors, Reffs, CodFinP, CodAcbs, CodCors, CodTams, CProEqs, Situas, Datas, DtIncs, " + ;
            " UsuIncs, CBars, EAN13, LtMinsV, QMins, QtPed, Locals, CUnis, CUniPs, PesoBS, PesoMs, " + ;
            " PVens, FVendas, PCuss, MoECs, MoePVs, UltComps, VultComps, MultComps, qtdultcomp, " + ;
            " DiasINas, ConSigs, FabrProprs, EnComs, ChkFunds, ObsPeds, ObsPes, " + ;
            " ObsEtqs, DPro3s, DscCompras, ObsCompras, Varias, prodwebs, TamHs, TamLs, TamPs, " + ;
            " Volumes, TEnts) " + ;
            "VALUES (" + ;
            EscaparSQL(THIS.this_cCpros)                     + ", " + ;
            EscaparSQL(THIS.this_cDpros)                     + ", " + ;
            EscaparSQL(THIS.this_cDpro2s)                    + ", " + ;
            EscaparSQL(PADR(THIS.this_cCgrus,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cSgrus,6))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cLinhas,10))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cColecoes,10))         + ", " + ;
            EscaparSQL(PADR(THIS.this_cMercs,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cIdecpros,3))          + ", " + ;
            EscaparSQL(PADR(THIS.this_cCclass,3))            + ", " + ;
            EscaparSQL(PADR(THIS.this_cIfors,10))            + ", " + ;
            EscaparSQL(THIS.this_cReffs)                     + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodfinp,3))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodacbs,3))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodcors,4))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodtams,4))           + ", " + ;
            EscaparSQL(THIS.this_cCproeqs)                   + ", " + ;
            FormatarNumeroSQL(THIS.this_nSituas)              + ", " + ;
            FormatarDataSQL(THIS.this_dDatas)                 + ", " + ;
            FormatarDataSQL(DATE())                           + ", " + ;
            EscaparSQL(gc_4c_UsuarioLogado)                  + ", " + ;
            FormatarNumeroSQL(THIS.this_nCbars)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nEan13)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nLtminsv)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nQmins)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nQtped)               + ", " + ;
            EscaparSQL(PADR(THIS.this_cLocals,10))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCunis,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cCunips,3))            + ", " + ;
            FormatarNumeroSQL(THIS.this_nPesobs)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nPesoms)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nPvens)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nFvendas)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nPcuss)               + ", " + ;
            EscaparSQL(PADR(THIS.this_cMoecs,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cMoepvs,3))            + ", " + ;
            FormatarDataSQL(THIS.this_dUltcomps)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nVultcomps)           + ", " + ;
            EscaparSQL(PADR(THIS.this_cMultcomps,3))          + ", " + ;
            FormatarNumeroSQL(THIS.this_nQultcomp)            + ", " + ;
            FormatarNumeroSQL(THIS.this_nDiasinas)            + ", " + ;
            FormatarNumeroSQL(THIS.this_nConsigs)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nFabrproprs)          + ", " + ;
            FormatarNumeroSQL(THIS.this_nEncoms)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nChkfunds)            + ", " + ;
            EscaparSQL(THIS.this_cObspeds)                   + ", " + ;
            EscaparSQL(THIS.this_cObspes)                    + ", " + ;
            EscaparSQL(THIS.this_cObsetqs)                   + ", " + ;
            EscaparSQL(THIS.this_cDpro3s)                    + ", " + ;
            EscaparSQL(THIS.this_cDsccompras)                + ", " + ;
            EscaparSQL(THIS.this_cObscompras)                + ", " + ;
            FormatarNumeroSQL(THIS.this_nVarias)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nWebpros)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nTamhs)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nTamls)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nTamps)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nVolumes)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nTents)               + ")"

        RETURN loc_cSQL
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSQL_UPDATE - Gera SQL de atualizacao (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSQL_UPDATE()
        LOCAL loc_cSQL
        loc_cSQL = "UPDATE SigCdPro SET " + ;
            "DPros = "       + EscaparSQL(THIS.this_cDpros)              + ", " + ;
            "DPro2s = "      + EscaparSQL(THIS.this_cDpro2s)             + ", " + ;
            "CGrus = "       + EscaparSQL(PADR(THIS.this_cCgrus,3))      + ", " + ;
            "SGrus = "       + EscaparSQL(PADR(THIS.this_cSgrus,6))      + ", " + ;
            "Linhas = "      + EscaparSQL(PADR(THIS.this_cLinhas,10))    + ", " + ;
            "Colecoes = "    + EscaparSQL(PADR(THIS.this_cColecoes,10))  + ", " + ;
            "Mercs = "       + EscaparSQL(PADR(THIS.this_cMercs,3))      + ", " + ;
            "IdeCPros = "    + EscaparSQL(PADR(THIS.this_cIdecpros,3))   + ", " + ;
            "CClass = "      + EscaparSQL(PADR(THIS.this_cCclass,3))     + ", " + ;
            "IFors = "       + EscaparSQL(PADR(THIS.this_cIfors,10))     + ", " + ;
            "Reffs = "       + EscaparSQL(THIS.this_cReffs)              + ", " + ;
            "CodFinP = "     + EscaparSQL(PADR(THIS.this_cCodfinp,3))    + ", " + ;
            "CodAcbs = "     + EscaparSQL(PADR(THIS.this_cCodacbs,3))    + ", " + ;
            "CodCors = "     + EscaparSQL(PADR(THIS.this_cCodcors,4))    + ", " + ;
            "CodTams = "     + EscaparSQL(PADR(THIS.this_cCodtams,4))    + ", " + ;
            "CProEqs = "     + EscaparSQL(THIS.this_cCproeqs)            + ", " + ;
            "Situas = "      + FormatarNumeroSQL(THIS.this_nSituas)       + ", " + ;
            "Datas = "       + FormatarDataSQL(THIS.this_dDatas)          + ", " + ;
            "CBars = "       + FormatarNumeroSQL(THIS.this_nCbars)        + ", " + ;
            "EAN13 = "       + FormatarNumeroSQL(THIS.this_nEan13)        + ", " + ;
            "LtMinsV = "     + FormatarNumeroSQL(THIS.this_nLtminsv)      + ", " + ;
            "QMins = "       + FormatarNumeroSQL(THIS.this_nQmins)        + ", " + ;
            "QtPed = "       + FormatarNumeroSQL(THIS.this_nQtped)       + ", " + ;
            "Locals = "      + EscaparSQL(PADR(THIS.this_cLocals,10))    + ", " + ;
            "CUnis = "       + EscaparSQL(PADR(THIS.this_cCunis,3))      + ", " + ;
            "CUniPs = "      + EscaparSQL(PADR(THIS.this_cCunips,3))     + ", " + ;
            "PesoBS = "      + FormatarNumeroSQL(THIS.this_nPesobs)       + ", " + ;
            "PesoMs = "      + FormatarNumeroSQL(THIS.this_nPesoms)       + ", " + ;
            "PVens = "       + FormatarNumeroSQL(THIS.this_nPvens)        + ", " + ;
            "FVendas = "     + FormatarNumeroSQL(THIS.this_nFvendas)      + ", " + ;
            "PCuss = "       + FormatarNumeroSQL(THIS.this_nPcuss)        + ", " + ;
            "MoECs = "       + EscaparSQL(PADR(THIS.this_cMoecs,3))      + ", " + ;
            "MoePVs = "      + EscaparSQL(PADR(THIS.this_cMoepvs,3))     + ", " + ;
            "UltComps = "    + FormatarDataSQL(THIS.this_dUltcomps)       + ", " + ;
            "VultComps = "   + FormatarNumeroSQL(THIS.this_nVultcomps)    + ", " + ;
            "MultComps = "   + EscaparSQL(PADR(THIS.this_cMultcomps,3))   + ", " + ;
            "qtdultcomp = "  + FormatarNumeroSQL(THIS.this_nQultcomp)     + ", " + ;
            "DiasINas = "    + FormatarNumeroSQL(THIS.this_nDiasinas)     + ", " + ;
            "ConSigs = "     + FormatarNumeroSQL(THIS.this_nConsigs)      + ", " + ;
            "FabrProprs = "  + FormatarNumeroSQL(THIS.this_nFabrproprs)   + ", " + ;
            "EnComs = "      + FormatarNumeroSQL(THIS.this_nEncoms)       + ", " + ;
            "ChkFunds = "    + FormatarNumeroSQL(THIS.this_nChkfunds)    + ", " + ;
            "ObsPeds = "     + EscaparSQL(THIS.this_cObspeds)            + ", " + ;
            "ObsPes = "      + EscaparSQL(THIS.this_cObspes)             + ", " + ;
            "ObsEtqs = "     + EscaparSQL(THIS.this_cObsetqs)            + ", " + ;
            "DPro3s = "      + EscaparSQL(THIS.this_cDpro3s)             + ", " + ;
            "DscCompras = "  + EscaparSQL(THIS.this_cDsccompras)         + ", " + ;
            "ObsCompras = "  + EscaparSQL(THIS.this_cObscompras)         + ", " + ;
            "Varias = "      + FormatarNumeroSQL(THIS.this_nVarias)       + ", " + ;
            "prodwebs = "    + FormatarNumeroSQL(THIS.this_nWebpros)      + ", " + ;
            "TamHs = "       + FormatarNumeroSQL(THIS.this_nTamhs)        + ", " + ;
            "TamLs = "       + FormatarNumeroSQL(THIS.this_nTamls)        + ", " + ;
            "TamPs = "       + FormatarNumeroSQL(THIS.this_nTamps)        + ", " + ;
            "Volumes = "     + FormatarNumeroSQL(THIS.this_nVolumes)      + ", " + ;
            "TEnts = "       + FormatarNumeroSQL(THIS.this_nTents)        + " " + ;
            "WHERE CPros = " + EscaparSQL(THIS.this_cCpros)

        RETURN loc_cSQL
    ENDPROC

ENDDEFINE

