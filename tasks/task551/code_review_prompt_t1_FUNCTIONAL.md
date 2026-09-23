# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'chkGer60' (parent: SIGCDUFD.Pagina.Dados): Left original=21 vs migrado 'chk_4c_ChkGer60R' Left=354 (diff=333px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormUfs.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1788 linhas total):

*-- Linhas 24 a 162:
24:     *===========================================================================
25:     * Init - Inicializa o formulario
26:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
27:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
28:     *===========================================================================
29:     PROCEDURE Init()
30:         RETURN DODEFAULT()
31:     ENDPROC
32: 
33:     *===========================================================================
34:     * InicializarForm - Configura estrutura completa
35:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
36:     *===========================================================================
37:     PROTECTED PROCEDURE InicializarForm()
38:         LOCAL loc_lSucesso
39:         loc_lSucesso = .F.
40: 
41:         TRY
42:             THIS.this_oBusinessObject = CREATEOBJECT("UfsBO")
43: 
44:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
45:                 MostrarErro("Erro ao criar UfsBO" + CHR(13) + ;
46:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
47:                     "FormUfs.InicializarForm")
48:             ELSE
49:                 THIS.ConfigurarPageFrame()
50:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Visible = .T.
55:                 THIS.pgf_4c_Paginas.ActivePage = 1
56:                 THIS.this_cModoAtual = "LISTA"
57: 
58:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
59:                     IF PEMSTATUS(THIS, "CarregarLista", 5)
60:                         THIS.CarregarLista()
61:                     ENDIF
62:                 ENDIF
63: 
64:                 loc_lSucesso = .T.
65:             ENDIF
66: 
67:         CATCH TO loException
68:             MostrarErro("Erro ao inicializar FormUfs:" + CHR(13) + ;
69:                 loException.Message + CHR(13) + ;
70:                 "Linha: " + TRANSFORM(loException.LineNo), ;
71:                 "FormUfs.InicializarForm")
72:         ENDTRY
73: 
74:         RETURN loc_lSucesso
75:     ENDPROC
76: 
77:     *===========================================================================
78:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
79:     * Top=-29 para esconder abas; controles compensam +29 no Top
80:     *===========================================================================
81:     PROTECTED PROCEDURE ConfigurarPageFrame()
82:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
83: 
84:         WITH THIS.pgf_4c_Paginas
85:             .PageCount = 2
86:             .Top       = -29
87:             .Left      = 0
88:             .Width     = THIS.Width
89:             .Height    = THIS.Height + 29
90:             .Tabs      = .F.
91:             .Visible   = .T.
92: 
93:             .Page1.Caption   = "Lista"
94:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
95:             .Page1.BackColor = RGB(255, 255, 255)
96: 
97:             .Page2.Caption   = "Dados"
98:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page2.BackColor = RGB(255, 255, 255)
100:         ENDWITH
101: 
102:         THIS.ConfigurarPaginaLista()
103:         THIS.ConfigurarPaginaDados()
104:     ENDPROC
105: 
106:     *===========================================================================
107:     * ConfigurarPaginaLista - Estrutura base de Page1 (Lista)
108:     * Cabecalho (faixa cinza - CLAUDE.md regra #11) + container de botoes CRUD
109:     * vazio (botoes e grid entram na Fase 4)
110:     *===========================================================================
111:     PROTECTED PROCEDURE ConfigurarPaginaLista()
112:         LOCAL loc_oPagina
113:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
114: 
115:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
116: 
117:         *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina
118:         *-- Original: Top=1. Com compensacao +29: Top=31
119:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
120:         WITH loc_oPagina.cnt_4c_Cabecalho
121:             .Top         = 31
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
131:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
132:             .Caption   = THIS.Caption
133:             .Top       = 15
134:             .Left      = 10
135:             .Width     = 769
136:             .Height    = 40
137:             .FontName  = "Tahoma"
138:             .FontSize  = 16
139:             .FontBold  = .T.
140:             .ForeColor = RGB(0, 0, 0)
141:             .BackStyle = 0
142:             .AutoSize  = .F.
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
148:             .Caption   = THIS.Caption
149:             .Top       = 18
150:             .Left      = 10
151:             .Width     = 769
152:             .Height    = 46
153:             .FontName  = "Tahoma"
154:             .FontSize  = 16
155:             .FontBold  = .T.
156:             .ForeColor = RGB(255, 255, 255)
157:             .BackStyle = 0
158:             .AutoSize  = .F.
159:             .Visible   = .T.
160:         ENDWITH
161: 
162:         *-- Container Botoes CRUD (Grupo_op no legado: Left=538, Top=0, Width=389, Height=85)

*-- Linhas 195 a 415:
195:             .AutoSize        = .F.
196:             .Visible         = .T.
197:         ENDWITH
198:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
199: 
200:         *-- Botao Visualizar (legado: Consultar.Left=81)
201:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
202:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
203:             .Caption         = "Visualizar"
204:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
205:             .PicturePosition = 13
206:             .Top             = 5
207:             .Left            = 80
208:             .Width           = 75
209:             .Height          = 75
210:             .FontName        = "Tahoma"
211:             .FontBold        = .T.
212:             .FontItalic      = .T.
213:             .FontSize        = 8
214:             .ForeColor       = RGB(90, 90, 90)
215:             .BackColor       = RGB(255, 255, 255)
216:             .Themes          = .F.
217:             .SpecialEffect   = 0
218:             .MousePointer    = 15
219:             .WordWrap        = .T.
220:             .AutoSize        = .F.
221:             .Visible         = .T.
222:         ENDWITH
223:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
224: 
225:         *-- Botao Alterar (legado: Alterar.Left=157)
226:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
227:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
228:             .Caption         = "Alterar"
229:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
230:             .PicturePosition = 13
231:             .Top             = 5
232:             .Left            = 155
233:             .Width           = 75
234:             .Height          = 75
235:             .FontName        = "Tahoma"
236:             .FontBold        = .T.
237:             .FontItalic      = .T.
238:             .FontSize        = 8
239:             .ForeColor       = RGB(90, 90, 90)
240:             .BackColor       = RGB(255, 255, 255)
241:             .Themes          = .F.
242:             .SpecialEffect   = 0
243:             .MousePointer    = 15
244:             .WordWrap        = .T.
245:             .AutoSize        = .F.
246:             .Visible         = .T.
247:         ENDWITH
248:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
249: 
250:         *-- Botao Excluir (legado: Excluir.Left=233)
251:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
252:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
253:             .Caption         = "Excluir"
254:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
255:             .PicturePosition = 13
256:             .Top             = 5
257:             .Left            = 230
258:             .Width           = 75
259:             .Height          = 75
260:             .FontName        = "Tahoma"
261:             .FontBold        = .T.
262:             .FontItalic      = .T.
263:             .FontSize        = 8
264:             .ForeColor       = RGB(90, 90, 90)
265:             .BackColor       = RGB(255, 255, 255)
266:             .Themes          = .F.
267:             .SpecialEffect   = 0
268:             .MousePointer    = 15
269:             .WordWrap        = .T.
270:             .AutoSize        = .F.
271:             .Visible         = .T.
272:         ENDWITH
273:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
274: 
275:         *-- Botao Buscar (legado: Procurar.Left=309)
276:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
277:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
278:             .Caption         = "Buscar"
279:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
280:             .PicturePosition = 13
281:             .Top             = 5
282:             .Left            = 305
283:             .Width           = 75
284:             .Height          = 75
285:             .FontName        = "Tahoma"
286:             .FontBold        = .T.
287:             .FontItalic      = .T.
288:             .FontSize        = 8
289:             .ForeColor       = RGB(90, 90, 90)
290:             .BackColor       = RGB(255, 255, 255)
291:             .Themes          = .F.
292:             .SpecialEffect   = 0
293:             .MousePointer    = 15
294:             .WordWrap        = .T.
295:             .AutoSize        = .F.
296:             .Visible         = .T.
297:         ENDWITH
298:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
299: 
300:         *-- Container Saida - PADRAO CANONICO (prevalece sobre legado, CLAUDE.md regra #10)
301:         *-- Legado: Grupo_Saida.Left=918, Top=0. Canonico: Left=917, Top=29, Width=90
302:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
303:         WITH loc_oPagina.cnt_4c_Saida
304:             .Top         = 29
305:             .Left        = 917
306:             .Width       = 90
307:             .Height      = 85
308:             .BackStyle   = 0
309:             .BorderWidth = 0
310:             .Visible     = .T.
311:         ENDWITH
312: 
313:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
314:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
315:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
316:             .Caption         = "Encerrar"
317:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
318:             .PicturePosition = 13
319:             .Top             = 5
320:             .Left            = 5
321:             .Width           = 75
322:             .Height          = 75
323:             .FontName        = "Tahoma"
324:             .FontBold        = .T.
325:             .FontItalic      = .T.
326:             .FontSize        = 8
327:             .ForeColor       = RGB(90, 90, 90)
328:             .BackColor       = RGB(255, 255, 255)
329:             .Themes          = .F.
330:             .SpecialEffect   = 0
331:             .MousePointer    = 15
332:             .WordWrap        = .T.
333:             .AutoSize        = .F.
334:             .Visible         = .T.
335:         ENDWITH
336:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
337: 
338:         *-- Grid de listagem de estados
339:         *-- Legado (PROCEDURE Init): Estados/UF(40), descrs/Nome(250), aicms/Ali(237)q. ICMS(80),
340:         *-- bicms/B.ICMS Redu(80), areduzidas/Ali(237)q. Redu(80), AliqSbs/Aliq.Sub.Trib(80)
341:         *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
342:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
343:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
344:         loc_oPagina.grd_4c_Lista.ColumnCount = 6
345:         WITH loc_oPagina.grd_4c_Lista
346:             .Top                = 117
347:             .Left               = 26
348:             .Width              = 880
349:             .Height             = 498
350:             .FontName           = "Verdana"
351:             .FontSize           = 8
352:             .ForeColor          = RGB(90, 90, 90)
353:             .BackColor          = RGB(255, 255, 255)
354:             .GridLineColor      = RGB(238, 238, 238)
355:             .HighlightBackColor = RGB(255, 255, 255)
356:             .HighlightForeColor = RGB(15, 41, 104)
357:             .HighlightStyle     = 2
358:             .DeleteMark         = .F.
359:             .RecordMark         = .F.
360:             .RowHeight          = 16
361:             .ScrollBars         = 2
362:             .GridLines          = 3
363:             .Visible            = .T.
364:         ENDWITH
365:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
366: 
367:         THIS.TornarControlesVisiveis(loc_oPagina)
368:     ENDPROC
369: 
370:     *===========================================================================
371:     * CarregarLista - Carrega dados no grid da Page1
372:     * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
373:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
374:     *===========================================================================
375:     PROCEDURE CarregarLista(par_cFiltro)
376:         LOCAL loc_lResultado, loc_oGrid, loc_cFiltro
377:         loc_lResultado = .F.
378:         loc_cFiltro = IIF(VARTYPE(par_cFiltro) = "C", par_cFiltro, "")
379: 
380:         TRY
381:             IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
382:                 loc_lResultado = .F.
383:             ELSE
384:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
385: 
386:                 *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
387:                 loc_oGrid.ColumnCount = 6
388:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
389: 
390:                 *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
391:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.estados"
392:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
393:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.aicms"
394:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.bicms"
395:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.areduzidas"
396:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.aliqsbs"
397: 
398:                 loc_oGrid.Column1.Width = 40
399:                 loc_oGrid.Column2.Width = 250
400:                 loc_oGrid.Column3.Width = 80
401:                 loc_oGrid.Column4.Width = 80
402:                 loc_oGrid.Column5.Width = 80
403:                 loc_oGrid.Column6.Width = 80
404: 
405:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
406:                 loc_oGrid.Column1.Header1.Caption = "UF"
407:                 loc_oGrid.Column2.Header1.Caption = "Nome"
408:                 loc_oGrid.Column3.Header1.Caption = "Al" + CHR(237) + "q. ICMS"
409:                 loc_oGrid.Column4.Header1.Caption = "B.ICMS Redu"
410:                 loc_oGrid.Column5.Header1.Caption = "Al" + CHR(237) + "q. Redu"
411:                 loc_oGrid.Column6.Header1.Caption = "Aliq.Sub.Trib"
412: 
413:                 THIS.FormatarGridLista(loc_oGrid)
414:                 loc_lResultado = .T.
415:             ENDIF

*-- Linhas 427 a 517:
427:     *===========================================================================
428:     * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
429:     *===========================================================================
430:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
431:         TRY
432:             WITH par_oGrid
433:                 .FontName = "Tahoma"
434:                 .FontSize = 8
435:             ENDWITH
436:         CATCH TO loException
437:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
438:                 "FormUfs.FormatarGridLista")
439:         ENDTRY
440:     ENDPROC
441: 
442:     *===========================================================================
443:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
444:     * Ao voltar para Page1, recarrega a lista
445:     *===========================================================================
446:     PROCEDURE AlternarPagina(par_nPagina)
447:         LOCAL loc_lResultado
448:         loc_lResultado = .F.
449: 
450:         TRY
451:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
452:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
453:             ELSE
454:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
455: 
456:                 IF par_nPagina = 1
457:                     THIS.this_cModoAtual = "LISTA"
458:                     THIS.CarregarLista()
459:                 ENDIF
460: 
461:                 loc_lResultado = .T.
462:             ENDIF
463: 
464:         CATCH TO loException
465:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
466:                 "FormUfs.AlternarPagina")
467:         ENDTRY
468: 
469:         RETURN loc_lResultado
470:     ENDPROC
471: 
472:     *===========================================================================
473:     * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
474:     * Cabecalho (faixa cinza nas DUAS paginas - CLAUDE.md regra #11) + container
475:     * de botoes de acao vazio (Confirmar/Cancelar e campos entram nas Fases 4-6)
476:     *===========================================================================
477:     PROTECTED PROCEDURE ConfigurarPaginaDados()
478:         LOCAL loc_oPagina
479:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
480: 
481:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
482: 
483:         *-- Cabecalho cinza (identico ao da pagina Lista) - PRIMEIRO AddObject da pagina
484:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
485:         WITH loc_oPagina.cnt_4c_Cabecalho
486:             .Top           = 29
487:             .Left          = 0
488:             .Width         = THIS.Width
489:             .Height        = 80
490:             .BackColor     = RGB(100, 100, 100)
491:             .BorderWidth   = 0
492:             .SpecialEffect = 0
493:             .Visible       = .T.
494: 
495:             .AddObject("lbl_4c_Sombra", "Label")
496:             WITH .lbl_4c_Sombra
497:                 .Caption   = THIS.Caption
498:                 .Top       = 15
499:                 .Left      = 10
500:                 .Width     = THIS.Width
501:                 .Height    = 40
502:                 .FontName  = "Tahoma"
503:                 .FontSize  = 16
504:                 .FontBold  = .T.
505:                 .ForeColor = RGB(0, 0, 0)
506:                 .BackStyle = 0
507:                 .AutoSize  = .F.
508:                 .Visible   = .T.
509:             ENDWITH
510: 
511:             .AddObject("lbl_4c_Titulo", "Label")
512:             WITH .lbl_4c_Titulo
513:                 .Caption   = THIS.Caption
514:                 .Top       = 18
515:                 .Left      = 10
516:                 .Width     = THIS.Width
517:                 .Height    = 46

*-- Linhas 883 a 926:
883:             .AutoSize  = .T.
884:             .Visible   = .T.
885:         ENDWITH
886:         BINDEVENT(loc_oPagina.chk_4c_ChkGer50, "Valid", THIS, "ValidarChkGer50")
887: 
888:         *-- chkGer51 "Tipo 51 - Nota Fiscal de IPI (Modelo 1 e 1A)" (legado Top=270/Left=21)
889:         loc_oPagina.AddObject("chk_4c_ChkGer51", "CheckBox")
890:         WITH loc_oPagina.chk_4c_ChkGer51
891:             .Caption   = "Tipo 51 - Nota Fiscal de IPI (Modelo 1 e 1A)"
892:             .Value     = 0
893:             .Top       = 299
894:             .Left      = 21
895:             .Width     = 226
896:             .Height    = 15
897:             .FontName  = "Tahoma"
898:             .FontSize  = 8
899:             .ForeColor = RGB(90, 90, 90)
900:             .BackStyle = 0
901:             .Alignment = 0
902:             .AutoSize  = .T.
903:             .Visible   = .T.
904:         ENDWITH
905: 
906:         *-- chkGer53 "Tipo 53 - Registro de Substituicao Tributaria" (legado Top=288/Left=21)
907:         loc_oPagina.AddObject("chk_4c_ChkGer53", "CheckBox")
908:         WITH loc_oPagina.chk_4c_ChkGer53
909:             .Caption   = "Tipo 53 - Registro de Substitui" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria"
910:             .Value     = 0
911:             .Top       = 317
912:             .Left      = 21
913:             .Width     = 228
914:             .Height    = 15
915:             .FontName  = "Tahoma"
916:             .FontSize  = 8
917:             .ForeColor = RGB(90, 90, 90)
918:             .BackStyle = 0
919:             .Alignment = 0
920:             .AutoSize  = .T.
921:             .Visible   = .T.
922:         ENDWITH
923: 
924:         *-- chkGer54 "Tipo 54 - Registro de Produtos das Notas Fiscais" (legado Top=305/Left=21)
925:         loc_oPagina.AddObject("chk_4c_ChkGer54", "CheckBox")
926:         WITH loc_oPagina.chk_4c_ChkGer54

*-- Linhas 957 a 1000:
957:             .AutoSize  = .T.
958:             .Visible   = .T.
959:         ENDWITH
960:         BINDEVENT(loc_oPagina.chk_4c_ChkGer60, "Valid", THIS, "ValidarChkGer60")
961: 
962:         *-- chkGer60I "Tipo 60 - ( I ) Itens dos Cupons" (legado Top=340/Left=21)
963:         loc_oPagina.AddObject("chk_4c_ChkGer60I", "CheckBox")
964:         WITH loc_oPagina.chk_4c_ChkGer60I
965:             .Caption   = "Tipo 60 - ( I ) " + CHR(205) + "tens dos Cupons"
966:             .Value     = 0
967:             .Top       = 369
968:             .Left      = 21
969:             .Width     = 168
970:             .Height    = 15
971:             .FontName  = "Tahoma"
972:             .FontSize  = 8
973:             .ForeColor = RGB(90, 90, 90)
974:             .BackStyle = 0
975:             .Alignment = 0
976:             .AutoSize  = .T.
977:             .Enabled   = .F.
978:             .Visible   = .T.
979:         ENDWITH
980: 
981:         *-- chkGer75 "Tipo 75 - Produtos" (legado Top=252/Left=688)
982:         loc_oPagina.AddObject("chk_4c_ChkGer75", "CheckBox")
983:         WITH loc_oPagina.chk_4c_ChkGer75
984:             .Caption   = "Tipo 75 - Produtos"
985:             .Value     = 0
986:             .Top       = 281
987:             .Left      = 688
988:             .Width     = 106
989:             .Height    = 15
990:             .FontName  = "Tahoma"
991:             .FontSize  = 8
992:             .ForeColor = RGB(90, 90, 90)
993:             .BackStyle = 0
994:             .Alignment = 0
995:             .AutoSize  = .T.
996:             .Visible   = .T.
997:         ENDWITH
998: 
999:         *-- chkGer60D "Tipo 60 - (D) Resumo Diario dos Cupons" (legado Top=252/Left=354)
1000:         loc_oPagina.AddObject("chk_4c_ChkGer60D", "CheckBox")

*-- Linhas 1276 a 1495:
1276:             .AutoSize        = .F.
1277:             .Visible         = .T.
1278:         ENDWITH
1279:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1280: 
1281:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
1282:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
1283:             .Caption         = "Encerrar"
1284:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1285:             .PicturePosition = 13
1286:             .Top             = 5
1287:             .Left            = 80
1288:             .Width           = 75
1289:             .Height          = 75
1290:             .FontName        = "Tahoma"
1291:             .FontBold        = .T.
1292:             .FontItalic      = .T.
1293:             .FontSize        = 8
1294:             .ForeColor       = RGB(90, 90, 90)
1295:             .BackColor       = RGB(255, 255, 255)
1296:             .Themes          = .F.
1297:             .SpecialEffect   = 0
1298:             .MousePointer    = 15
1299:             .WordWrap        = .T.
1300:             .AutoSize        = .F.
1301:             .Visible         = .T.
1302:         ENDWITH
1303:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
1304: 
1305:         THIS.TornarControlesVisiveis(loc_oPagina)
1306:     ENDPROC
1307: 
1308:     *===========================================================================
1309:     * ValidarChkGer50 - Valid de chkGer50 (legado PROCEDURE Valid)
1310:     * chkGer54 so fica habilitado (e marcado) quando chkGer50 esta marcado
1311:     *===========================================================================
1312:     PROCEDURE ValidarChkGer50()
1313:         LOCAL loc_oPagina
1314:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1315: 
1316:         IF loc_oPagina.chk_4c_ChkGer50.Value = 0
1317:             loc_oPagina.chk_4c_ChkGer54.Value   = 0
1318:             loc_oPagina.chk_4c_ChkGer54.Enabled = .F.
1319:         ELSE
1320:             loc_oPagina.chk_4c_ChkGer54.Enabled = .T.
1321:         ENDIF
1322:     ENDPROC
1323: 
1324:     *===========================================================================
1325:     * ValidarChkGer60 - Valid de chkGer60 (legado PROCEDURE Valid)
1326:     * chkGer60I/chkGer60D/chkGer60R/chkGer60P so ficam habilitados (e marcados)
1327:     * quando chkGer60 esta marcado
1328:     *===========================================================================
1329:     PROCEDURE ValidarChkGer60()
1330:         LOCAL loc_oPagina
1331:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1332: 
1333:         IF loc_oPagina.chk_4c_ChkGer60.Value = 0
1334:             loc_oPagina.chk_4c_ChkGer60I.Value   = 0
1335:             loc_oPagina.chk_4c_ChkGer60D.Value   = 0
1336:             loc_oPagina.chk_4c_ChkGer60R.Value   = 0
1337:             loc_oPagina.chk_4c_ChkGer60P.Value   = 0
1338: 
1339:             loc_oPagina.chk_4c_ChkGer60I.Enabled = .F.
1340:             loc_oPagina.chk_4c_ChkGer60D.Enabled = .F.
1341:             loc_oPagina.chk_4c_ChkGer60R.Enabled = .F.
1342:             loc_oPagina.chk_4c_ChkGer60P.Enabled = .F.
1343:         ELSE
1344:             loc_oPagina.chk_4c_ChkGer60I.Enabled = .T.
1345:             loc_oPagina.chk_4c_ChkGer60D.Enabled = .T.
1346:             loc_oPagina.chk_4c_ChkGer60R.Enabled = .T.
1347:             loc_oPagina.chk_4c_ChkGer60P.Enabled = .T.
1348:         ENDIF
1349:     ENDPROC
1350: 
1351:     *===========================================================================
1352:     * BtnIncluirClick - Abre Page2 para incluir novo estado
1353:     * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3)
1354:     *===========================================================================
1355:     PROCEDURE BtnIncluirClick()
1356:         THIS.this_oBusinessObject.NovoRegistro()
1357:         THIS.LimparCampos()
1358:         THIS.this_cModoAtual = "INCLUIR"
1359:         THIS.HabilitarCampos(.T.)
1360:         THIS.AjustarBotoesPorModo()
1361:         THIS.AlternarPagina(2)
1362:     ENDPROC
1363: 
1364:     *===========================================================================
1365:     * BtnVisualizarClick - Abre Page2 em modo somente leitura
1366:     * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3)
1367:     *===========================================================================
1368:     PROCEDURE BtnVisualizarClick()
1369:         LOCAL loc_cEstado
1370:         loc_cEstado = ""
1371: 
1372:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1373:             SELECT cursor_4c_Dados
1374:             loc_cEstado = ALLTRIM(cursor_4c_Dados.estados)
1375:         ENDIF
1376: 
1377:         IF EMPTY(loc_cEstado)
1378:             MsgAviso("Selecione um estado para visualizar.")
1379:         ELSE
1380:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEstado)
1381:                 THIS.this_cModoAtual = "VISUALIZAR"
1382:                 THIS.BOParaForm()
1383:                 THIS.HabilitarCampos(.F.)
1384:                 THIS.AjustarBotoesPorModo()
1385:                 THIS.AlternarPagina(2)
1386:             ENDIF
1387:         ENDIF
1388:     ENDPROC
1389: 
1390:     *===========================================================================
1391:     * BtnAlterarClick - Abre Page2 para alterar o estado selecionado
1392:     * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3)
1393:     *===========================================================================
1394:     PROCEDURE BtnAlterarClick()
1395:         LOCAL loc_cEstado
1396:         loc_cEstado = ""
1397: 
1398:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1399:             SELECT cursor_4c_Dados
1400:             loc_cEstado = ALLTRIM(cursor_4c_Dados.estados)
1401:         ENDIF
1402: 
1403:         IF EMPTY(loc_cEstado)
1404:             MsgAviso("Selecione um estado para alterar.")
1405:         ELSE
1406:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEstado)
1407:                 THIS.this_oBusinessObject.EditarRegistro()
1408:                 THIS.this_cModoAtual = "ALTERAR"
1409:                 THIS.BOParaForm()
1410:                 THIS.HabilitarCampos(.T.)
1411:                 THIS.AjustarBotoesPorModo()
1412:                 THIS.AlternarPagina(2)
1413:             ENDIF
1414:         ENDIF
1415:     ENDPROC
1416: 
1417:     *===========================================================================
1418:     * BtnExcluirClick - Exclui o estado selecionado com confirmacao
1419:     * Transcrito do legado (Salva.Click ramo EXCLUIR): bloqueia exclusao se a UF
1420:     * estiver em uso em SigCdCli/SigCdCee/SigCdCll (verificado no UfsBO)
1421:     * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3)
1422:     *===========================================================================
1423:     PROCEDURE BtnExcluirClick()
1424:         LOCAL loc_cEstado
1425:         loc_cEstado = ""
1426: 
1427:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1428:             SELECT cursor_4c_Dados
1429:             loc_cEstado = ALLTRIM(cursor_4c_Dados.estados)
1430:         ENDIF
1431: 
1432:         IF EMPTY(loc_cEstado)
1433:             MsgAviso("Selecione um estado para excluir.")
1434:         ELSE
1435:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEstado)
1436:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do estado [" + loc_cEstado + "]?", ;
1437:                     "Confirmar Exclus" + CHR(227) + "o")
1438:                     IF THIS.this_oBusinessObject.Excluir()
1439:                         MsgInfo("Estado exclu" + CHR(237) + "do com sucesso!")
1440:                         THIS.CarregarLista()
1441:                     ELSE
1442:                         IF !THIS.this_oBusinessObject.this_lErroExibido
1443:                             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Confirmar")
1444:                         ENDIF
1445:                     ENDIF
1446:                 ENDIF
1447:             ENDIF
1448:         ENDIF
1449:     ENDPROC
1450: 
1451:     *===========================================================================
1452:     * FormParaBO - Transfere dados do Form para o BO antes de salvar
1453:     * Todas as propriedades this_* de UfsBO.prg mapeadas nos campos de Page2
1454:     *===========================================================================
1455:     PROTECTED PROCEDURE FormParaBO()
1456:         LOCAL loc_oPagina, loc_cIpiSel
1457:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1458: 
1459:         THIS.this_oBusinessObject.this_cEstados    = UPPER(ALLTRIM(loc_oPagina.txt_4c_Estado.Value))
1460:         THIS.this_oBusinessObject.this_cDescrs     = ALLTRIM(loc_oPagina.txt_4c_Descr.Value)
1461:         THIS.this_oBusinessObject.this_nAicms      = loc_oPagina.txt_4c_Aicms.Value
1462:         THIS.this_oBusinessObject.this_nBicms      = loc_oPagina.txt_4c_Bicms.Value
1463:         THIS.this_oBusinessObject.this_nAreduzidas = loc_oPagina.txt_4c_Areduzida.Value
1464:         THIS.this_oBusinessObject.this_nAliqsbs    = loc_oPagina.txt_4c_AliqSB.Value
1465:         THIS.this_oBusinessObject.this_nUFIBGEs    = loc_oPagina.txt_4c_UFIBGES.Value
1466:         THIS.this_oBusinessObject.this_cLayoutnf   = ALLTRIM(loc_oPagina.txt_4c_Layoutnf.Value)
1467: 
1468:         *-- cmbIpi: itens "\<Tributado "/"\<Isento   "/"\<Outros   " -> codigo T/I/O (this_cIpis)
1469:         loc_cIpiSel = UPPER(ALLTRIM(STRTRAN(loc_oPagina.cbo_4c_CmbIpi.Value, "\<", "")))
1470:         DO CASE
1471:             CASE loc_cIpiSel = "ISENTO"
1472:                 THIS.this_oBusinessObject.this_cIpis = "I"
1473:             CASE loc_cIpiSel = "OUTROS"
1474:                 THIS.this_oBusinessObject.this_cIpis = "O"
1475:             OTHERWISE
1476:                 THIS.this_oBusinessObject.this_cIpis = "T"
1477:         ENDCASE
1478: 
1479:         THIS.this_oBusinessObject.this_nGer50      = IIF(loc_oPagina.chk_4c_ChkGer50.Value = 1, 1, 0)
1480:         THIS.this_oBusinessObject.this_nGer51      = IIF(loc_oPagina.chk_4c_ChkGer51.Value = 1, 1, 0)
1481:         THIS.this_oBusinessObject.this_nGer53      = IIF(loc_oPagina.chk_4c_ChkGer53.Value = 1, 1, 0)
1482:         THIS.this_oBusinessObject.this_nGer54      = IIF(loc_oPagina.chk_4c_ChkGer54.Value = 1, 1, 0)
1483:         THIS.this_oBusinessObject.this_nGer60      = IIF(loc_oPagina.chk_4c_ChkGer60.Value = 1, 1, 0)
1484:         THIS.this_oBusinessObject.this_nGer60I     = IIF(loc_oPagina.chk_4c_ChkGer60I.Value = 1, 1, 0)
1485:         THIS.this_oBusinessObject.this_nGer60D     = IIF(loc_oPagina.chk_4c_ChkGer60D.Value = 1, 1, 0)
1486:         THIS.this_oBusinessObject.this_nGer60R     = IIF(loc_oPagina.chk_4c_ChkGer60R.Value = 1, 1, 0)
1487:         THIS.this_oBusinessObject.this_nGer60P     = IIF(loc_oPagina.chk_4c_ChkGer60P.Value = 1, 1, 0)
1488:         THIS.this_oBusinessObject.this_nGer61      = IIF(loc_oPagina.chk_4c_ChkGer61.Value = 1, 1, 0)
1489:         THIS.this_oBusinessObject.this_nGer70      = IIF(loc_oPagina.chk_4c_ChkGer70.Value = 1, 1, 0)
1490:         THIS.this_oBusinessObject.this_nGer74      = IIF(loc_oPagina.chk_4c_ChkGer74.Value = 1, 1, 0)
1491:         THIS.this_oBusinessObject.this_nGer75      = IIF(loc_oPagina.chk_4c_ChkGer75.Value = 1, 1, 0)
1492:         THIS.this_oBusinessObject.this_nGer77      = IIF(loc_oPagina.chk_4c_Fwcheckbox1.Value = 1, 1, 0)
1493:         THIS.this_oBusinessObject.this_nGerSefaz   = IIF(loc_oPagina.chk_4c_Fwcheckbox2.Value = 1, 1, 0)
1494:         THIS.this_oBusinessObject.this_nGer88      = IIF(loc_oPagina.chk_4c_Fwcheckbox3.Value = 1, 1, 0)
1495:         THIS.this_oBusinessObject.this_nNgersufr1s = IIF(loc_oPagina.chk_4c_Fwcheckbox4.Value = 1, 1, 0)

*-- Linhas 1503 a 1546:
1503:     *===========================================================================
1504:     * BOParaForm - Transfere dados do BO para o Form apos carregar registro
1505:     *===========================================================================
1506:     PROTECTED PROCEDURE BOParaForm()
1507:         LOCAL loc_oPagina, loc_cIpiTexto
1508:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1509: 
1510:         loc_oPagina.txt_4c_Estado.Value    = THIS.this_oBusinessObject.this_cEstados
1511:         loc_oPagina.txt_4c_Descr.Value     = THIS.this_oBusinessObject.this_cDescrs
1512:         loc_oPagina.txt_4c_Aicms.Value     = THIS.this_oBusinessObject.this_nAicms
1513:         loc_oPagina.txt_4c_Bicms.Value     = THIS.this_oBusinessObject.this_nBicms
1514:         loc_oPagina.txt_4c_Areduzida.Value = THIS.this_oBusinessObject.this_nAreduzidas
1515:         loc_oPagina.txt_4c_AliqSB.Value    = THIS.this_oBusinessObject.this_nAliqsbs
1516:         loc_oPagina.txt_4c_UFIBGES.Value   = THIS.this_oBusinessObject.this_nUFIBGEs
1517:         loc_oPagina.txt_4c_Layoutnf.Value  = THIS.this_oBusinessObject.this_cLayoutnf
1518: 
1519:         DO CASE
1520:             CASE THIS.this_oBusinessObject.this_cIpis = "I"
1521:                 loc_cIpiTexto = "Isento"
1522:             CASE THIS.this_oBusinessObject.this_cIpis = "O"
1523:                 loc_cIpiTexto = "Outros"
1524:             OTHERWISE
1525:                 loc_cIpiTexto = "Tributado"
1526:         ENDCASE
1527:         loc_oPagina.cbo_4c_CmbIpi.Value = "\<" + PADR(loc_cIpiTexto, 9)
1528: 
1529:         loc_oPagina.chk_4c_ChkGer50.Value    = (THIS.this_oBusinessObject.this_nGer50 .Value    = IIF(THIS.this_oBusinessObject.this_nGer50 = 1, 1, 0))
1530:         loc_oPagina.chk_4c_ChkGer51.Value    = (THIS.this_oBusinessObject.this_nGer51 .Value    = IIF(THIS.this_oBusinessObject.this_nGer51 = 1, 1, 0))
1531:         loc_oPagina.chk_4c_ChkGer53.Value    = (THIS.this_oBusinessObject.this_nGer53 .Value    = IIF(THIS.this_oBusinessObject.this_nGer53 = 1, 1, 0))
1532:         loc_oPagina.chk_4c_ChkGer54.Value    = (THIS.this_oBusinessObject.this_nGer54 .Value    = IIF(THIS.this_oBusinessObject.this_nGer54 = 1, 1, 0))
1533:         loc_oPagina.chk_4c_ChkGer60.Value    = (THIS.this_oBusinessObject.this_nGer60 .Value    = IIF(THIS.this_oBusinessObject.this_nGer60 = 1, 1, 0))
1534:         loc_oPagina.chk_4c_ChkGer60I.Value   = (THIS.this_oBusinessObject.this_nGer60I .Value   = IIF(THIS.this_oBusinessObject.this_nGer60I = 1, 1, 0))
1535:         loc_oPagina.chk_4c_ChkGer60D.Value   = (THIS.this_oBusinessObject.this_nGer60D .Value   = IIF(THIS.this_oBusinessObject.this_nGer60D = 1, 1, 0))
1536:         loc_oPagina.chk_4c_ChkGer60R.Value   = (THIS.this_oBusinessObject.this_nGer60R .Value   = IIF(THIS.this_oBusinessObject.this_nGer60R = 1, 1, 0))
1537:         loc_oPagina.chk_4c_ChkGer60P.Value   = (THIS.this_oBusinessObject.this_nGer60P .Value   = IIF(THIS.this_oBusinessObject.this_nGer60P = 1, 1, 0))
1538:         loc_oPagina.chk_4c_ChkGer61.Value    = (THIS.this_oBusinessObject.this_nGer61 .Value    = IIF(THIS.this_oBusinessObject.this_nGer61 = 1, 1, 0))
1539:         loc_oPagina.chk_4c_ChkGer70.Value    = (THIS.this_oBusinessObject.this_nGer70 .Value    = IIF(THIS.this_oBusinessObject.this_nGer70 = 1, 1, 0))
1540:         loc_oPagina.chk_4c_ChkGer74.Value    = (THIS.this_oBusinessObject.this_nGer74 .Value    = IIF(THIS.this_oBusinessObject.this_nGer74 = 1, 1, 0))
1541:         loc_oPagina.chk_4c_ChkGer75.Value    = (THIS.this_oBusinessObject.this_nGer75 .Value    = IIF(THIS.this_oBusinessObject.this_nGer75 = 1, 1, 0))
1542:         loc_oPagina.chk_4c_Fwcheckbox1.Value = (THIS.this_oBusinessObject.this_nGer77 .Value = IIF(THIS.this_oBusinessObject.this_nGer77 = 1, 1, 0))
1543:         loc_oPagina.chk_4c_Fwcheckbox2.Value = (THIS.this_oBusinessObject.this_nGerSefaz .Value = IIF(THIS.this_oBusinessObject.this_nGerSefaz = 1, 1, 0))
1544:         loc_oPagina.chk_4c_Fwcheckbox3.Value = (THIS.this_oBusinessObject.this_nGer88 .Value = IIF(THIS.this_oBusinessObject.this_nGer88 = 1, 1, 0))
1545:         loc_oPagina.chk_4c_Fwcheckbox4.Value = (THIS.this_oBusinessObject.this_nNgersufr1s .Value = IIF(THIS.this_oBusinessObject.this_nNgersufr1s = 1, 1, 0))
1546:         loc_oPagina.chk_4c_Fwcheckbox5.Value = (THIS.this_oBusinessObject.this_nGerncm .Value = IIF(THIS.this_oBusinessObject.this_nGerncm = 1, 1, 0))

*-- Linhas 1556 a 1788:
1556:     * chkGer54/chkGer60I/D/R/P seguem o Enabled dos respectivos "pais"
1557:     * (chkGer50/chkGer60 - mesma regra do Valid legado em ValidarChkGer50/60)
1558:     *===========================================================================
1559:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1560:         LOCAL loc_oPagina, loc_lPKReadOnly
1561:         loc_oPagina     = THIS.pgf_4c_Paginas.Page2
1562:         loc_lPKReadOnly = (THIS.this_cModoAtual != "INCLUIR")
1563: 
1564:         loc_oPagina.txt_4c_Estado.Enabled    = par_lHabilitar AND !loc_lPKReadOnly
1565:         loc_oPagina.txt_4c_Descr.Enabled     = par_lHabilitar
1566:         loc_oPagina.txt_4c_Aicms.Enabled     = par_lHabilitar
1567:         loc_oPagina.txt_4c_Bicms.Enabled     = par_lHabilitar
1568:         loc_oPagina.txt_4c_Areduzida.Enabled = par_lHabilitar
1569:         loc_oPagina.txt_4c_AliqSB.Enabled    = par_lHabilitar
1570:         loc_oPagina.txt_4c_UFIBGES.Enabled   = par_lHabilitar
1571:         loc_oPagina.txt_4c_Layoutnf.Enabled  = par_lHabilitar
1572:         loc_oPagina.cbo_4c_CmbIpi.Enabled    = par_lHabilitar
1573: 
1574:         loc_oPagina.chk_4c_ChkGer50.Enabled    = par_lHabilitar
1575:         loc_oPagina.chk_4c_ChkGer51.Enabled    = par_lHabilitar
1576:         loc_oPagina.chk_4c_ChkGer53.Enabled    = par_lHabilitar
1577:         loc_oPagina.chk_4c_ChkGer54.Enabled    = par_lHabilitar AND loc_oPagina.chk_4c_ChkGer50.Value
1578:         loc_oPagina.chk_4c_ChkGer60.Enabled    = par_lHabilitar
1579:         loc_oPagina.chk_4c_ChkGer60I.Enabled   = par_lHabilitar AND loc_oPagina.chk_4c_ChkGer60.Value
1580:         loc_oPagina.chk_4c_ChkGer60D.Enabled   = par_lHabilitar AND loc_oPagina.chk_4c_ChkGer60.Value
1581:         loc_oPagina.chk_4c_ChkGer60R.Enabled   = par_lHabilitar AND loc_oPagina.chk_4c_ChkGer60.Value
1582:         loc_oPagina.chk_4c_ChkGer60P.Enabled   = par_lHabilitar AND loc_oPagina.chk_4c_ChkGer60.Value
1583:         loc_oPagina.chk_4c_ChkGer61.Enabled    = par_lHabilitar
1584:         loc_oPagina.chk_4c_ChkGer70.Enabled    = par_lHabilitar
1585:         loc_oPagina.chk_4c_ChkGer74.Enabled    = par_lHabilitar
1586:         loc_oPagina.chk_4c_ChkGer75.Enabled    = par_lHabilitar
1587:         loc_oPagina.chk_4c_Fwcheckbox1.Enabled = par_lHabilitar
1588:         loc_oPagina.chk_4c_Fwcheckbox2.Enabled = par_lHabilitar
1589:         loc_oPagina.chk_4c_Fwcheckbox3.Enabled = par_lHabilitar
1590:         loc_oPagina.chk_4c_Fwcheckbox4.Enabled = par_lHabilitar
1591:         loc_oPagina.chk_4c_Fwcheckbox5.Enabled = par_lHabilitar
1592:         loc_oPagina.chk_4c_Fwcheckbox6.Enabled = par_lHabilitar
1593:         loc_oPagina.chk_4c_Fwcheckbox7.Enabled = par_lHabilitar
1594:         loc_oPagina.chk_4c_Fwcheckbox8.Enabled = par_lHabilitar
1595:         loc_oPagina.chk_4c_Fwcheckbox9.Enabled = par_lHabilitar
1596:     ENDPROC
1597: 
1598:     *===========================================================================
1599:     * LimparCampos - Limpa todos os campos da Page2 para novo registro
1600:     *===========================================================================
1601:     PROTECTED PROCEDURE LimparCampos()
1602:         LOCAL loc_oPagina
1603:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1604: 
1605:         loc_oPagina.txt_4c_Estado.Value    = ""
1606:         loc_oPagina.txt_4c_Descr.Value     = ""
1607:         loc_oPagina.txt_4c_Aicms.Value     = 0
1608:         loc_oPagina.txt_4c_Bicms.Value     = 0
1609:         loc_oPagina.txt_4c_Areduzida.Value = 0
1610:         loc_oPagina.txt_4c_AliqSB.Value    = 0
1611:         loc_oPagina.txt_4c_UFIBGES.Value   = 0
1612:         loc_oPagina.txt_4c_Layoutnf.Value  = ""
1613:         loc_oPagina.cbo_4c_CmbIpi.Value    = "\<" + PADR("Tributado", 9)
1614: 
1615:         loc_oPagina.chk_4c_ChkGer50.Value    = 0
1616:         loc_oPagina.chk_4c_ChkGer51.Value    = 0
1617:         loc_oPagina.chk_4c_ChkGer53.Value    = 0
1618:         loc_oPagina.chk_4c_ChkGer54.Value    = 0
1619:         loc_oPagina.chk_4c_ChkGer60.Value    = 0
1620:         loc_oPagina.chk_4c_ChkGer60I.Value   = 0
1621:         loc_oPagina.chk_4c_ChkGer60D.Value   = 0
1622:         loc_oPagina.chk_4c_ChkGer60R.Value   = 0
1623:         loc_oPagina.chk_4c_ChkGer60P.Value   = 0
1624:         loc_oPagina.chk_4c_ChkGer61.Value    = 0
1625:         loc_oPagina.chk_4c_ChkGer70.Value    = 0
1626:         loc_oPagina.chk_4c_ChkGer74.Value    = 0
1627:         loc_oPagina.chk_4c_ChkGer75.Value    = 0
1628:         loc_oPagina.chk_4c_Fwcheckbox1.Value = 0
1629:         loc_oPagina.chk_4c_Fwcheckbox2.Value = 0
1630:         loc_oPagina.chk_4c_Fwcheckbox3.Value = 0
1631:         loc_oPagina.chk_4c_Fwcheckbox4.Value = 0
1632:         loc_oPagina.chk_4c_Fwcheckbox5.Value = 0
1633:         loc_oPagina.chk_4c_Fwcheckbox6.Value = 0
1634:         loc_oPagina.chk_4c_Fwcheckbox7.Value = 0
1635:         loc_oPagina.chk_4c_Fwcheckbox8.Value = 0
1636:         loc_oPagina.chk_4c_Fwcheckbox9.Value = 0
1637:     ENDPROC
1638: 
1639:     *===========================================================================
1640:     * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
1641:     * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
1642:     * PUBLIC: chamado diretamente pelo harness de teste (TesteAutomatico.prg)
1643:     *===========================================================================
1644:     PROCEDURE AjustarBotoesPorModo()
1645:         LOCAL loc_oPagina, loc_lEditando
1646:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1647:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1648: 
1649:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
1650:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1651:     ENDPROC
1652: 
1653:     *===========================================================================
1654:     * BtnBuscarClick - Abre FormBuscaAuxiliar para localizar um estado na lista
1655:     * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3)
1656:     *===========================================================================
1657:     PROCEDURE BtnBuscarClick()
1658:         LOCAL loc_oBusca, loc_cCodigo
1659:         TRY
1660:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1661:                 "SigCdUfs", "cursor_4c_BuscaUfLista", "estados", "", "Buscar Estado")
1662: 
1663:             IF VARTYPE(loc_oBusca) = "O"
1664:                 IF !loc_oBusca.this_lAchouRegistro
1665:                     loc_oBusca.mAddColuna("Estados", "", "U" + "F")
1666:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1667:                     loc_oBusca.Show()
1668:                 ENDIF
1669: 
1670:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUfLista")
1671:                     SELECT cursor_4c_BuscaUfLista
1672:                     loc_cCodigo = ALLTRIM(Estados)
1673:                     THIS.CarregarLista("estados = " + EscaparSQL(loc_cCodigo))
1674:                 ENDIF
1675: 
1676:                 loc_oBusca.Release()
1677:             ENDIF
1678: 
1679:         CATCH TO loException
1680:             MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "FormUfs.BtnBuscarClick")
1681:         ENDTRY
1682: 
1683:         IF USED("cursor_4c_BuscaUfLista")
1684:             USE IN cursor_4c_BuscaUfLista
1685:         ENDIF
1686:     ENDPROC
1687: 
1688:     *===========================================================================
1689:     * BtnSalvarClick - Valida e grava o registro (Confirmar)
1690:     * Validacoes FORA do TRY (transcrito do legado SIGCDUFD.Click - Event Click 38
1691:     * linhas em comportamento.json: "U.F. Invalido." se vazio; "U.F. Ja Cadastrado."
1692:     * se duplicado em modo INCLUIR - mesma checagem de UfsBO.ValidarDados, repetida
1693:     * aqui apenas para reproduzir o SetFocus() do legado). Salvar() sem parametro
1694:     * (CLAUDE.md); falha ja e reportada pelo BusinessBase (regra #20) - so avisa
1695:     * se nao exibido.
1696:     *===========================================================================
1697:     PROCEDURE BtnSalvarClick()
1698:         LOCAL loc_oPg2, loc_cEstado
1699:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1700:         loc_cEstado = UPPER(ALLTRIM(loc_oPg2.txt_4c_Estado.Value))
1701: 
1702:         IF EMPTY(loc_cEstado)
1703:             MsgAviso("U.F. Inv" + CHR(225) + "lido.")
1704:             loc_oPg2.txt_4c_Estado.SetFocus()
1705:             RETURN
1706:         ENDIF
1707: 
1708:         IF THIS.this_cModoAtual = "INCLUIR" AND THIS.this_oBusinessObject.VerificarCodigoExistente(loc_cEstado)
1709:             MsgAviso("U.F. J" + CHR(225) + " Cadastrado.")
1710:             loc_oPg2.txt_4c_Estado.SetFocus()
1711:             RETURN
1712:         ENDIF
1713: 
1714:         THIS.FormParaBO()
1715: 
1716:         IF THIS.this_oBusinessObject.Salvar()
1717:             MsgInfo("Registro salvo com sucesso!", "Confirmar")
1718:             THIS.AlternarPagina(1)
1719:             THIS.CarregarLista()
1720:         ELSE
1721:             IF !THIS.this_oBusinessObject.this_lErroExibido
1722:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
1723:             ENDIF
1724:         ENDIF
1725:     ENDPROC
1726: 
1727:     *===========================================================================
1728:     * BtnCancelarClick - Cancela edicao e volta para a lista (recarregada)
1729:     * Transcrito do legado (Cancela.Click): =DoDefault() If ThisForm.plCancelar
1730:     * ThisForm.mAtivapagina1 Endif
1731:     *===========================================================================
1732:     PROCEDURE BtnCancelarClick()
1733:         THIS.AlternarPagina(1)
1734:         THIS.this_cModoAtual = "LISTA"
1735:         THIS.CarregarLista()
1736:     ENDPROC
1737: 
1738:     *===========================================================================
1739:     * BtnEncerrarClick - Fecha o formulario
1740:     *===========================================================================
1741:     PROCEDURE BtnEncerrarClick()
1742:         THIS.Release()
1743:     ENDPROC
1744: 
1745:     *===========================================================================
1746:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1747:     * Percorre Controls() e Pages() (para PageFrames aninhados)
1748:     *===========================================================================
1749:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1750:         LOCAL loc_nI, loc_oObjeto, loc_nP
1751: 
1752:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1753:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1754: 
1755:             IF VARTYPE(loc_oObjeto) = "O"
1756:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1757:                     loc_oObjeto.Visible = .T.
1758:                 ENDIF
1759: 
1760:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1761:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1762:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1763:                     ENDFOR
1764:                 ENDIF
1765: 
1766:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1767:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1768:                 ENDIF
1769:             ENDIF
1770:         ENDFOR
1771:     ENDPROC
1772: 
1773:     *===========================================================================
1774:     * Destroy - Libera recursos ao fechar o formulario
1775:     *===========================================================================
1776:     PROCEDURE Destroy()
1777:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1778:             THIS.this_oBusinessObject = .NULL.
1779:         ENDIF
1780: 
1781:         IF USED("cursor_4c_Dados")
1782:             USE IN cursor_4c_Dados
1783:         ENDIF
1784: 
1785:         DODEFAULT()
1786:     ENDPROC
1787: 
1788: ENDDEFINE


### BO (C:\4c\projeto\app\classes\UfsBO.prg):
*====================================================================
* UfsBO.prg
*
* Business Object para Ufs (Cadastro de Estados)
* Tabela: SigCdUfs (PK: estados)
*====================================================================

DEFINE CLASS UfsBO AS BusinessBase

	*-- Propriedades da entidade (colunas de SigCdUfs - docs/schema.sql)
	this_cEstados                   = ""   && char(2)  - PK
	this_cDescrs                    = ""   && char(40)
	this_nAicms                     = 0    && numeric(9,2)
	this_nBicms                     = 0    && numeric(9,2)
	this_nAreduzidas                = 0    && numeric(9,2)
	this_cIpis                      = ""   && char(1)
	this_nGer60D                    = 0    && numeric(1,0)
	this_nGer60I                    = 0    && numeric(1,0)
	this_nGer60R                    = 0    && numeric(1,0)
	this_nGer74                     = 0    && numeric(1,0)
	this_nGer75                     = 0    && numeric(1,0)
	this_nGer77                     = 0    && numeric(1,0)
	this_nGerSefaz                  = 0    && numeric(1,0)
	this_nGer50                     = 0    && numeric(1,0)
	this_nGer51                     = 0    && numeric(1,0)
	this_nGer54                     = 0    && numeric(1,0)
	this_nGer60                     = 0    && numeric(1,0)
	this_nGer61                     = 0    && numeric(1,0)
	this_nGer70                     = 0    && numeric(1,0)
	this_nGer88                     = 0    && numeric(1,0)
	this_nAliqsbs                   = 0    && numeric(9,2)
	this_nGer53                     = 0    && numeric(1,0)
	this_nNgersufr1s                = 0    && int
	this_nGerncm                    = 0    && numeric(1,0)
	this_nCodidents                 = 0    && numeric(1,0)
	this_nGer60P                    = 0    && numeric(1,0)
	this_nNcotepe52s                = 0    && int
	this_nGer88ms                   = 0    && numeric(1,0)
	this_nUFIBGEs                   = 0    && numeric(2,0)
	this_cLayoutnf                  = ""   && char(20)
	this_nChkgnre                   = 0    && numeric(1,0)
	this_cChaveConsultaHomologacao  = ""   && char(80)
	this_cChaveConsultaProducao     = ""   && char(80)
	this_cHomologacao               = ""   && char(80)
	this_cProducao                  = ""   && char(80)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela = "SigCdUfs"
			THIS.this_cCampoChave = "estados"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "UfsBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cEstados)
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cEstados                  = TratarNulo(estados,                   "C")
				THIS.this_cDescrs                   = TratarNulo(descrs,                    "C")
				THIS.this_nAicms                    = TratarNulo(aicms,                      "N")
				THIS.this_nBicms                    = TratarNulo(bicms,                      "N")
				THIS.this_nAreduzidas                = TratarNulo(areduzidas,                "N")
				THIS.this_cIpis                     = TratarNulo(ipis,                       "C")
				THIS.this_nGer60D                   = TratarNulo(ger60d,                     "N")
				THIS.this_nGer60I                   = TratarNulo(ger60i,                     "N")
				THIS.this_nGer60R                   = TratarNulo(ger60r,                     "N")
				THIS.this_nGer74                    = TratarNulo(ger74,                      "N")
				THIS.this_nGer75                    = TratarNulo(ger75,                      "N")
				THIS.this_nGer77                    = TratarNulo(ger77,                      "N")
				THIS.this_nGerSefaz                 = TratarNulo(gersefaz,                   "N")
				THIS.this_nGer50                    = TratarNulo(ger50,                      "N")
				THIS.this_nGer51                    = TratarNulo(ger51,                      "N")
				THIS.this_nGer54                    = TratarNulo(ger54,                      "N")
				THIS.this_nGer60                    = TratarNulo(ger60,                      "N")
				THIS.this_nGer61                    = TratarNulo(ger61,                      "N")
				THIS.this_nGer70                    = TratarNulo(ger70,                      "N")
				THIS.this_nGer88                    = TratarNulo(ger88,                      "N")
				THIS.this_nAliqsbs                  = TratarNulo(aliqsbs,                    "N")
				THIS.this_nGer53                    = TratarNulo(ger53,                      "N")
				THIS.this_nNgersufr1s                = TratarNulo(ngersufr1s,                "N")
				THIS.this_nGerncm                   = TratarNulo(gerncm,                     "N")
				THIS.this_nCodidents                = TratarNulo(codidents,                  "N")
				THIS.this_nGer60P                   = TratarNulo(ger60p,                     "N")
				THIS.this_nNcotepe52s                = TratarNulo(ncotepe52s,                "N")
				THIS.this_nGer88ms                  = TratarNulo(ger88ms,                    "N")
				THIS.this_nUFIBGEs                  = TratarNulo(UFIBGEs,                    "N")
				THIS.this_cLayoutnf                 = TratarNulo(layoutnf,                   "C")
				THIS.this_nChkgnre                  = TratarNulo(chkgnre,                    "N")
				THIS.this_cChaveConsultaHomologacao = TratarNulo(ChaveConsultaHomologacao,    "C")
				THIS.this_cChaveConsultaProducao    = TratarNulo(ChaveConsultaProducao,       "C")
				THIS.this_cHomologacao              = TratarNulo(Homologacao,                 "C")
				THIS.this_cProducao                 = TratarNulo(Producao,                    "C")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "UfsBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	* Transcrito do legado: getEstado nao pode ficar vazio; UF duplicada
	* so eh bloqueada na INCLUSAO (Salva.Click, SigCdUfs_form_codigo_fonte.txt)
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		LOCAL loc_lValido
		loc_lValido = .T.

		IF EMPTY(THIS.this_cEstados)
			THIS.this_cMensagemErro = "U.F. Inv" + CHR(225) + "lido."
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_lNovoRegistro
			IF THIS.VerificarCodigoExistente(THIS.this_cEstados)
				THIS.this_cMensagemErro = "U.F. J" + CHR(225) + " Cadastrado."
				loc_lValido = .F.
			ENDIF
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* VerificarCodigoExistente - Verifica se estados ja existe no banco
	*====================================================================
	PROCEDURE VerificarCodigoExistente(par_cEstados)
		LOCAL loc_cSQL, loc_nResultado, loc_lExiste
		loc_lExiste = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdUfs" + ;
				" WHERE estados = " + EscaparSQL(par_cEstados)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
			IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
				SELECT cursor_4c_ChkCod
				loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
				USE IN cursor_4c_ChkCod
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao verificar U.F.:" + CHR(13) + loException.Message, "UfsBO.VerificarCodigoExistente")
		ENDTRY

		RETURN loc_lExiste
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdUfs
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigCdUfs (
					estados, descrs, aicms, bicms, areduzidas, ipis,
					ger60d, ger60i, ger60r, ger74, ger75, ger77, gersefaz,
					ger50, ger51, ger54, ger60, ger61, ger70, ger88,
					aliqsbs, ger53, ngersufr1s, gerncm, codidents, ger60p,
					ncotepe52s, ger88ms, UFIBGEs, layoutnf, chkgnre,
					ChaveConsultaHomologacao, ChaveConsultaProducao, Homologacao, Producao
				)
				VALUES (
					<<EscaparSQL(THIS.this_cEstados)>>,
					<<EscaparSQL(THIS.this_cDescrs)>>,
					<<FormatarNumeroSQL(THIS.this_nAicms, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nBicms, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nAreduzidas, 2)>>,
					<<EscaparSQL(THIS.this_cIpis)>>,
					<<FormatarNumeroSQL(THIS.this_nGer60D, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer60I, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer60R, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer74, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer75, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer77, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGerSefaz, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer50, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer51, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer54, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer60, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer61, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer70, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer88, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nAliqsbs, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nGer53, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNgersufr1s, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGerncm, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nCodidents, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer60P, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNcotepe52s, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer88ms, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nUFIBGEs, 0)>>,
					<<EscaparSQL(THIS.this_cLayoutnf)>>,
					<<FormatarNumeroSQL(THIS.this_nChkgnre, 0)>>,
					<<EscaparSQL(THIS.this_cChaveConsultaHomologacao)>>,
					<<EscaparSQL(THIS.this_cChaveConsultaProducao)>>,
					<<EscaparSQL(THIS.this_cHomologacao)>>,
					<<EscaparSQL(THIS.this_cProducao)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "UfsBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdUfs
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdUfs
				SET descrs      = <<EscaparSQL(THIS.this_cDescrs)>>,
					aicms       = <<FormatarNumeroSQL(THIS.this_nAicms, 2)>>,
					bicms       = <<FormatarNumeroSQL(THIS.this_nBicms, 2)>>,
					areduzidas  = <<FormatarNumeroSQL(THIS.this_nAreduzidas, 2)>>,
					ipis        = <<EscaparSQL(THIS.this_cIpis)>>,
					ger60d      = <<FormatarNumeroSQL(THIS.this_nGer60D, 0)>>,
					ger60i      = <<FormatarNumeroSQL(THIS.this_nGer60I, 0)>>,
					ger60r      = <<FormatarNumeroSQL(THIS.this_nGer60R, 0)>>,
					ger74       = <<FormatarNumeroSQL(THIS.this_nGer74, 0)>>,
					ger75       = <<FormatarNumeroSQL(THIS.this_nGer75, 0)>>,
					ger77       = <<FormatarNumeroSQL(THIS.this_nGer77, 0)>>,
					gersefaz    = <<FormatarNumeroSQL(THIS.this_nGerSefaz, 0)>>,
					ger50       = <<FormatarNumeroSQL(THIS.this_nGer50, 0)>>,
					ger51       = <<FormatarNumeroSQL(THIS.this_nGer51, 0)>>,
					ger54       = <<FormatarNumeroSQL(THIS.this_nGer54, 0)>>,
					ger60       = <<FormatarNumeroSQL(THIS.this_nGer60, 0)>>,
					ger61       = <<FormatarNumeroSQL(THIS.this_nGer61, 0)>>,
					ger70       = <<FormatarNumeroSQL(THIS.this_nGer70, 0)>>,
					ger88       = <<FormatarNumeroSQL(THIS.this_nGer88, 0)>>,
					aliqsbs     = <<FormatarNumeroSQL(THIS.this_nAliqsbs, 2)>>,
					ger53       = <<FormatarNumeroSQL(THIS.this_nGer53, 0)>>,
					ngersufr1s  = <<FormatarNumeroSQL(THIS.this_nNgersufr1s, 0)>>,
					gerncm      = <<FormatarNumeroSQL(THIS.this_nGerncm, 0)>>,
					codidents   = <<FormatarNumeroSQL(THIS.this_nCodidents, 0)>>,
					ger60p      = <<FormatarNumeroSQL(THIS.this_nGer60P, 0)>>,
					ncotepe52s  = <<FormatarNumeroSQL(THIS.this_nNcotepe52s, 0)>>,
					ger88ms     = <<FormatarNumeroSQL(THIS.this_nGer88ms, 0)>>,
					UFIBGEs     = <<FormatarNumeroSQL(THIS.this_nUFIBGEs, 0)>>,
					layoutnf    = <<EscaparSQL(THIS.this_cLayoutnf)>>,
					chkgnre     = <<FormatarNumeroSQL(THIS.this_nChkgnre, 0)>>,
					ChaveConsultaHomologacao = <<EscaparSQL(THIS.this_cChaveConsultaHomologacao)>>,
					ChaveConsultaProducao    = <<EscaparSQL(THIS.this_cChaveConsultaProducao)>>,
					Homologacao = <<EscaparSQL(THIS.this_cHomologacao)>>,
					Producao    = <<EscaparSQL(THIS.this_cProducao)>>
				WHERE estados = <<EscaparSQL(THIS.this_cEstados)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "UfsBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro da tabela SigCdUfs
	* Transcrito do legado (Salva.Click, ramo EXCLUIR): bloqueia exclusao
	* se a UF estiver em uso em SigCdCli.estas, SigCdCee.estas ou SigCdCll.estas
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
		loc_lSucesso = .F.
		loc_nUso     = 0

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT CASE WHEN
					EXISTS (SELECT 1 FROM SigCdCli WHERE estas = <<EscaparSQL(THIS.this_cEstados)>>) OR
					EXISTS (SELECT 1 FROM SigCdCee WHERE estas = <<EscaparSQL(THIS.this_cEstados)>>) OR
					EXISTS (SELECT 1 FROM SigCdCll WHERE estas = <<EscaparSQL(THIS.this_cEstados)>>)
				THEN 1 ELSE 0 END AS nUso
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkUfs")

			IF loc_nResultado < 0
				MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED("cursor_4c_ChkUfs")
					SELECT cursor_4c_ChkUfs
					loc_nUso = NVL(cursor_4c_ChkUfs.nUso, 0)
					USE IN cursor_4c_ChkUfs
				ENDIF

				IF loc_nUso > 0
					THIS.this_cMensagemErro = "Estado n" + CHR(227) + "o pode ser exclu" + CHR(237) + ;
						"do pois est" + CHR(225) + " sendo usado em Clientes!"
				ELSE
					loc_cSQL = "DELETE FROM SigCdUfs WHERE estados = " + EscaparSQL(THIS.this_cEstados)
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("DELETE")
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao excluir estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "UfsBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados com as colunas da grade do legado
	* (Estados, descrs, aicms, bicms, areduzidas, AliqSbs - PROCEDURE Init)
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (estados C(2), descrs C(40), aicms N(9,2), bicms N(9,2), areduzidas N(9,2), aliqsbs N(9,2))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT estados, descrs, aicms, bicms, areduzidas, aliqsbs FROM SigCdUfs"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY estados"

				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
				IF loc_nResultado >= 0
					loc_lSucesso = .T.
				ELSE
					MostrarErro("Erro ao buscar estados:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "UfsBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (estados)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cEstados)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT estados, descrs, aicms, bicms, areduzidas, ipis,
					ger60d, ger60i, ger60r, ger74, ger75, ger77, gersefaz,
					ger50, ger51, ger54, ger60, ger61, ger70, ger88,
					aliqsbs, ger53, ngersufr1s, gerncm, codidents, ger60p,
					ncotepe52s, ger88ms, UFIBGEs, layoutnf, chkgnre,
					ChaveConsultaHomologacao, ChaveConsultaProducao, Homologacao, Producao
				FROM SigCdUfs
				WHERE estados = <<EscaparSQL(par_cEstados)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Estado n" + CHR(227) + "o encontrado!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "UfsBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

