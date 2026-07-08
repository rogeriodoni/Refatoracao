# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormUfs.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1941 linhas total):

*-- Linhas 26 a 154:
26:     this_cMensagemErro   = ""
27: 
28:     *==========================================================================
29:     * Init - Delega para FormBase (que chama InicializarForm)
30:     *==========================================================================
31:     PROCEDURE Init()
32:         LOCAL loc_lSucesso
33:         loc_lSucesso = .F.
34: 
35:         TRY
36:             loc_lSucesso = DODEFAULT()
37:         CATCH TO loException
38:             MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
39:         ENDTRY
40: 
41:         RETURN loc_lSucesso
42:     ENDPROC
43: 
44:     *==========================================================================
45:     * InicializarForm - Cria estrutura base do formulario
46:     * Chamado automaticamente pelo FormBase.Init()
47:     *==========================================================================
48:     PROTECTED PROCEDURE InicializarForm()
49:         LOCAL loc_lSucesso
50:         loc_lSucesso = .F.
51: 
52:         TRY
53:             THIS.this_oBusinessObject = CREATEOBJECT("UfsBO")
54: 
55:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
56:                 MsgErro("Erro ao criar UfsBO", "Erro")
57:             ELSE
58:                 THIS.ConfigurarPageFrame()
59:                 THIS.ConfigurarPaginaLista()
60:                 THIS.ConfigurarPaginaDados()
61: 
62:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
64:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
65:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
66: 
67:                 THIS.pgf_4c_Paginas.Visible    = .T.
68:                 THIS.pgf_4c_Paginas.ActivePage = 1
69:                 THIS.this_cModoAtual = "LISTA"
70: 
71:                 *-- Carregar lista inicial (apenas se nao estiver em modo validacao UI)
72:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
73:                     THIS.CarregarLista()
74:                 ENDIF
75: 
76:                 loc_lSucesso = .T.
77:             ENDIF
78:         CATCH TO loException
79:             MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
80:         ENDTRY
81: 
82:         RETURN loc_lSucesso
83:     ENDPROC
84: 
85:     *==========================================================================
86:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
87:     * e containers base de cabecalho/botoes em cada pagina
88:     *==========================================================================
89:     PROTECTED PROCEDURE ConfigurarPageFrame()
90:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
91: 
92:         WITH THIS.pgf_4c_Paginas
93:             .PageCount = 2
94:             .Top       = -29
95:             .Left      = 0
96:             .Width     = 1003
97:             .Height    = 631    && runtime adiciona +4 -> total 635
98:             .Tabs      = .F.
99:         ENDWITH
100: 
101:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
102:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
103:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104: 
105:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
106:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
107:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108: 
109:         *----------------------------------------------------------------------
110:         * PAGE 1 - Container sombra/titulo (cntSombra: Top=2 + 29 = 31)
111:         *----------------------------------------------------------------------
112:         THIS.pgf_4c_Paginas.Page1.AddObject("cnt_4c_Sombra", "Container")
113:         WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra
114:             .Top         = 31
115:             .Left        = 0
116:             .Width       = 1009
117:             .Height      = 80
118:             .BackColor   = RGB(53, 53, 53)
119:             .BorderWidth = 0
120:             .Visible     = .T.
121:         ENDWITH
122: 
123:         THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
124:         WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra
125:             .Caption   = THIS.Caption
126:             .Top       = 45
127:             .Left      = 12
128:             .Width     = 980
129:             .Height    = 30
130:             .FontName  = "Tahoma"
131:             .FontSize  = 18
132:             .FontBold  = .T.
133:             .ForeColor = RGB(30, 30, 30)
134:             .BackStyle = 0
135:             .Visible   = .T.
136:         ENDWITH
137: 
138:         THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
139:         WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo
140:             .Caption   = THIS.Caption
141:             .Top       = 43
142:             .Left      = 10
143:             .Width     = 980
144:             .Height    = 30
145:             .FontName  = "Tahoma"
146:             .FontSize  = 18
147:             .FontBold  = .T.
148:             .ForeColor = RGB(255, 255, 255)
149:             .BackStyle = 0
150:             .Visible   = .T.
151:         ENDWITH
152: 
153:         *-- Container botoes CRUD - Page1 (Grupo_op: Left=543, Top=0; +29 = 29)
154:         THIS.pgf_4c_Paginas.Page1.AddObject("cnt_4c_Botoes", "Container")

*-- Linhas 175 a 222:
175:         ENDWITH
176: 
177:         *----------------------------------------------------------------------
178:         * PAGE 2 - Container sombra/titulo (compensacao Top = 2 + 29 = 31)
179:         *----------------------------------------------------------------------
180:         THIS.pgf_4c_Paginas.Page2.AddObject("cnt_4c_Sombra", "Container")
181:         WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra
182:             .Top         = 31
183:             .Left        = 0
184:             .Width       = 1009
185:             .Height      = 80
186:             .BackColor   = RGB(53, 53, 53)
187:             .BorderWidth = 0
188:             .Visible     = .T.
189:         ENDWITH
190: 
191:         THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.AddObject("lbl_4c_sombra2", "Label")
192:         WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_sombra2
193:             .Caption   = THIS.Caption
194:             .Top       = 45
195:             .Left      = 12
196:             .Width     = 980
197:             .Height    = 30
198:             .FontName  = "Tahoma"
199:             .FontSize  = 18
200:             .FontBold  = .T.
201:             .ForeColor = RGB(30, 30, 30)
202:             .BackStyle = 0
203:             .Visible   = .T.
204:         ENDWITH
205: 
206:         THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.AddObject("lbl_4c_titulo2", "Label")
207:         WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_titulo2
208:             .Caption   = THIS.Caption
209:             .Top       = 43
210:             .Left      = 10
211:             .Width     = 980
212:             .Height    = 30
213:             .FontName  = "Tahoma"
214:             .FontSize  = 18
215:             .FontBold  = .T.
216:             .ForeColor = RGB(255, 255, 255)
217:             .BackStyle = 0
218:             .Visible   = .T.
219:         ENDWITH
220: 
221:         *-- Container botoes Salvar/Cancelar - Page2 (Grupo_Salva: Left=842, Top=4; +29 = 33)
222:         THIS.pgf_4c_Paginas.Page2.AddObject("cnt_4c_BotoesAcao", "Container")

*-- Linhas 234 a 502:
234:     *==========================================================================
235:     * ConfigurarPaginaLista - Cria botoes CRUD e Grid na Page1
236:     *==========================================================================
237:     PROTECTED PROCEDURE ConfigurarPaginaLista()
238:         LOCAL loc_oPagina, loc_oCnt, loc_oSair, loc_oGrid
239:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
240: 
241:         *----------------------------------------------------------------------
242:         * Botoes CRUD no cnt_4c_Botoes (ja criado no ConfigurarPageFrame)
243:         * Posicoes baseadas no Framework: Grupo_op com botoes Left=5,80,155,230,305
244:         *----------------------------------------------------------------------
245:         loc_oCnt = loc_oPagina.cnt_4c_Botoes
246: 
247:         *-- Incluir
248:         loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
249:         WITH loc_oCnt.cmd_4c_Incluir
250:             .Caption         = "Incluir"
251:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
252:             .PicturePosition = 13
253:             .Top             = 5
254:             .Left            = 5
255:             .Width           = 75
256:             .Height          = 75
257:             .FontName        = "Comic Sans MS"
258:             .FontSize        = 8
259:             .FontBold        = .T.
260:             .FontItalic      = .T.
261:             .ForeColor       = RGB(90, 90, 90)
262:             .BackColor       = RGB(255, 255, 255)
263:             .Themes          = .F.
264:             .SpecialEffect   = 0
265:             .MousePointer    = 15
266:             .WordWrap        = .T.
267:             .AutoSize        = .F.
268:             .Visible         = .T.
269:         ENDWITH
270:         BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
271: 
272:         *-- Visualizar
273:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
274:         WITH loc_oCnt.cmd_4c_Visualizar
275:             .Caption         = "Visualizar"
276:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
277:             .PicturePosition = 13
278:             .Top             = 5
279:             .Left            = 80
280:             .Width           = 75
281:             .Height          = 75
282:             .FontName        = "Comic Sans MS"
283:             .FontSize        = 8
284:             .FontBold        = .T.
285:             .FontItalic      = .T.
286:             .ForeColor       = RGB(90, 90, 90)
287:             .BackColor       = RGB(255, 255, 255)
288:             .Themes          = .F.
289:             .SpecialEffect   = 0
290:             .MousePointer    = 15
291:             .WordWrap        = .T.
292:             .AutoSize        = .F.
293:             .Visible         = .T.
294:         ENDWITH
295:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
296: 
297:         *-- Alterar
298:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
299:         WITH loc_oCnt.cmd_4c_Alterar
300:             .Caption         = "Alterar"
301:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
302:             .PicturePosition = 13
303:             .Top             = 5
304:             .Left            = 155
305:             .Width           = 75
306:             .Height          = 75
307:             .FontName        = "Comic Sans MS"
308:             .FontSize        = 8
309:             .FontBold        = .T.
310:             .FontItalic      = .T.
311:             .ForeColor       = RGB(90, 90, 90)
312:             .BackColor       = RGB(255, 255, 255)
313:             .Themes          = .F.
314:             .SpecialEffect   = 0
315:             .MousePointer    = 15
316:             .WordWrap        = .T.
317:             .AutoSize        = .F.
318:             .Visible         = .T.
319:         ENDWITH
320:         BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
321: 
322:         *-- Excluir
323:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
324:         WITH loc_oCnt.cmd_4c_Excluir
325:             .Caption         = "Excluir"
326:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
327:             .PicturePosition = 13
328:             .Top             = 5
329:             .Left            = 230
330:             .Width           = 75
331:             .Height          = 75
332:             .FontName        = "Comic Sans MS"
333:             .FontSize        = 8
334:             .FontBold        = .T.
335:             .FontItalic      = .T.
336:             .ForeColor       = RGB(90, 90, 90)
337:             .BackColor       = RGB(255, 255, 255)
338:             .Themes          = .F.
339:             .SpecialEffect   = 0
340:             .MousePointer    = 15
341:             .WordWrap        = .T.
342:             .AutoSize        = .F.
343:             .Visible         = .T.
344:         ENDWITH
345:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
346: 
347:         *-- Buscar
348:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
349:         WITH loc_oCnt.cmd_4c_Buscar
350:             .Caption         = "Buscar"
351:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
352:             .PicturePosition = 13
353:             .Top             = 5
354:             .Left            = 305
355:             .Width           = 75
356:             .Height          = 75
357:             .FontName        = "Comic Sans MS"
358:             .FontSize        = 8
359:             .FontBold        = .T.
360:             .FontItalic      = .T.
361:             .ForeColor       = RGB(90, 90, 90)
362:             .BackColor       = RGB(255, 255, 255)
363:             .Themes          = .F.
364:             .SpecialEffect   = 0
365:             .MousePointer    = 15
366:             .WordWrap        = .T.
367:             .AutoSize        = .F.
368:             .Visible         = .T.
369:         ENDWITH
370:         BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
371: 
372:         *----------------------------------------------------------------------
373:         * Botao Encerrar no cnt_4c_BotaoSair
374:         *----------------------------------------------------------------------
375:         loc_oSair = loc_oPagina.cnt_4c_BotaoSair
376:         loc_oSair.AddObject("cmd_4c_Encerrar", "CommandButton")
377:         WITH loc_oSair.cmd_4c_Encerrar
378:             .Caption         = "Encerrar"
379:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
380:             .PicturePosition = 13
381:             .Top             = 5
382:             .Left            = 5
383:             .Width           = 65
384:             .Height          = 75
385:             .FontName        = "Comic Sans MS"
386:             .FontSize        = 8
387:             .FontBold        = .T.
388:             .FontItalic      = .T.
389:             .ForeColor       = RGB(90, 90, 90)
390:             .BackColor       = RGB(255, 255, 255)
391:             .Themes          = .F.
392:             .SpecialEffect   = 0
393:             .MousePointer    = 15
394:             .WordWrap        = .T.
395:             .AutoSize        = .F.
396:             .Visible         = .T.
397:         ENDWITH
398:         BINDEVENT(loc_oSair.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
399: 
400:         *----------------------------------------------------------------------
401:         * Grid de listagem (Grade no original: top=121+29=150, left=12)
402:         * Colunas: estados(UF), descrs(Nome), aicms, bicms, areduzidas
403:         *----------------------------------------------------------------------
404:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
405:         loc_oGrid = loc_oPagina.grd_4c_Lista
406:         loc_oGrid.Top         = 150
407:         loc_oGrid.Left        = 12
408:         loc_oGrid.Width       = 941
409:         loc_oGrid.Height      = 470
410:         loc_oGrid.ColumnCount = 5
411: 
412:         WITH loc_oGrid
413:             .FontName           = "Verdana"
414:             .FontSize           = 8
415:             .ForeColor          = RGB(90, 90, 90)
416:             .BackColor          = RGB(255, 255, 255)
417:             .GridLineColor      = RGB(238, 238, 238)
418:             .HighlightBackColor = RGB(255, 255, 255)
419:             .HighlightForeColor = RGB(15, 41, 104)
420:             .HighlightStyle     = 2
421:             .DeleteMark         = .F.
422:             .RecordMark         = .F.
423:             .RowHeight          = 16
424:             .ScrollBars         = 2
425:             .GridLines          = 3
426:             .Visible            = .T.
427:         ENDWITH
428: 
429:         THIS.TornarControlesVisiveis(loc_oPagina)
430:     ENDPROC
431: 
432:     *==========================================================================
433:     * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
434:     *==========================================================================
435:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
436:         LOCAL loc_lResultado
437:         loc_lResultado = .F.
438: 
439:         TRY
440:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
441:                 MsgErro("Par" + CHR(226) + "metro inv" + CHR(225) + "lido em AlternarPagina.", "Erro")
442:             ELSE
443:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
444: 
445:                 IF par_nPagina = 1
446:                     THIS.this_cModoAtual = "LISTA"
447:                     THIS.CarregarLista()
448:                 ENDIF
449: 
450:                 loc_lResultado = .T.
451:             ENDIF
452:         CATCH TO loc_oErro
453:             MostrarErro(loc_oErro, "FormUfs.AlternarPagina")
454:         ENDTRY
455: 
456:         RETURN loc_lResultado
457:     ENDPROC
458: 
459:     *==========================================================================
460:     * CarregarLista - Carrega cursor_4c_Dados no grid da Page1
461:     *==========================================================================
462:     PROCEDURE CarregarLista()
463:         LOCAL loc_lResultado, loc_oGrid
464:         loc_lResultado = .F.
465: 
466:         TRY
467:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
468:                 loc_lResultado = .T.
469:             ELSE
470:                 IF !THIS.this_oBusinessObject.Buscar("")
471:                     loc_lResultado = .F.
472:                 ELSE
473:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
474: 
475:                     *-- RecordSource e ColumnCount FORA de WITH (Problema 36)
476:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
477:                     loc_oGrid.ColumnCount  = 5
478: 
479:                     *-- ControlSource APOS RecordSource (Problema 48)
480:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.estados"
481:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
482:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.aicms"
483:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.bicms"
484:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.areduzidas"
485: 
486:                     *-- Larguras das colunas (originais: 40, 250, 80, 80, 80)
487:                     loc_oGrid.Column1.Width = 60
488:                     loc_oGrid.Column2.Width = 350
489:                     loc_oGrid.Column3.Width = 90
490:                     loc_oGrid.Column4.Width = 100
491:                     loc_oGrid.Column5.Width = 110
492: 
493:                     *-- Headers APOS RecordSource (Problema 6 / Problema 32)
494:                     loc_oGrid.Column1.Header1.Caption = "UF"
495:                     loc_oGrid.Column2.Header1.Caption = "Nome"
496:                     loc_oGrid.Column3.Header1.Caption = "Al" + CHR(237) + "q. ICMS"
497:                     loc_oGrid.Column4.Header1.Caption = "B.ICMS Redu"
498:                     loc_oGrid.Column5.Header1.Caption = "Al" + CHR(237) + "q. Reduzida"
499: 
500:                     *-- Alinhamento das colunas numericas
501:                     loc_oGrid.Column1.Alignment = 0
502:                     loc_oGrid.Column2.Alignment = 0

*-- Linhas 518 a 746:
518:     *==========================================================================
519:     * FormatarGridLista - Aplica formatacao visual ao grid
520:     *==========================================================================
521:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
522:         TRY
523:             WITH par_oGrid
524:                 .FontName = "Tahoma"
525:                 .FontSize = 8
526:             ENDWITH
527:         CATCH TO loc_oErro
528:             MostrarErro(loc_oErro, "FormUfs.FormatarGridLista")
529:         ENDTRY
530:     ENDPROC
531: 
532:     *==========================================================================
533:     * TornarControlesVisiveis - Torna todos os controles do container visiveis
534:     * Percorre recursivamente Pages de PageFrames e Controls de Containers
535:     *==========================================================================
536:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
537:         LOCAL loc_nI, loc_oObjeto, loc_nP
538:         loc_nI = 0
539:         loc_nP = 0
540: 
541:         TRY
542:             FOR loc_nI = 1 TO par_oContainer.ControlCount
543:                 loc_oObjeto = par_oContainer.Controls(loc_nI)
544: 
545:                 IF VARTYPE(loc_oObjeto) = "O"
546:                     IF PEMSTATUS(loc_oObjeto, "Visible", 5)
547:                         loc_oObjeto.Visible = .T.
548:                     ENDIF
549: 
550:                     *-- Trata PageFrame - itera Pages
551:                     IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
552:                         FOR loc_nP = 1 TO loc_oObjeto.PageCount
553:                             THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
554:                         ENDFOR
555:                     ENDIF
556: 
557:                     *-- Trata containers com ControlCount
558:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
559:                         THIS.TornarControlesVisiveis(loc_oObjeto)
560:                     ENDIF
561:                 ENDIF
562:             ENDFOR
563:         CATCH TO loc_oErro
564:             MostrarErro(loc_oErro, "FormUfs.TornarControlesVisiveis")
565:         ENDTRY
566:     ENDPROC
567: 
568:     *==========================================================================
569:     * BtnIncluirClick - Abre Page2 em modo INCLUIR (PUBLIC para BINDEVENT)
570:     *==========================================================================
571:     PROCEDURE BtnIncluirClick()
572:         TRY
573:             THIS.this_oBusinessObject.NovoRegistro()
574:             THIS.LimparCampos()
575:             THIS.this_cModoAtual = "INCLUIR"
576:             THIS.HabilitarCampos(.T.)
577:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
578:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
579:             THIS.pgf_4c_Paginas.ActivePage = 2
580:         CATCH TO loc_oErro
581:             MostrarErro(loc_oErro, "FormUfs.BtnIncluirClick")
582:         ENDTRY
583:     ENDPROC
584: 
585:     *==========================================================================
586:     * BtnVisualizarClick - Abre Page2 em modo VISUALIZAR com registro selecionado
587:     *==========================================================================
588:     PROCEDURE BtnVisualizarClick()
589:         LOCAL loc_cEstado
590:         loc_cEstado = ""
591: 
592:         TRY
593:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
594:                 MsgAviso("Nenhum registro selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
595:             ELSE
596:                 SELECT cursor_4c_Dados
597:                 loc_cEstado = ALLTRIM(cursor_4c_Dados.estados)
598: 
599:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEstado)
600:                     THIS.this_cModoAtual = "VISUALIZAR"
601:                     THIS.BOParaForm()
602:                     THIS.HabilitarCampos(.F.)
603:                     THIS.AjustarChkboxesPorBoConteudo()
604:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
605:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
606:                     THIS.pgf_4c_Paginas.ActivePage = 2
607:                 ENDIF
608:             ENDIF
609:         CATCH TO loc_oErro
610:             MostrarErro(loc_oErro, "FormUfs.BtnVisualizarClick")
611:         ENDTRY
612:     ENDPROC
613: 
614:     *==========================================================================
615:     * BtnAlterarClick - Abre Page2 em modo ALTERAR com registro selecionado
616:     *==========================================================================
617:     PROCEDURE BtnAlterarClick()
618:         LOCAL loc_cEstado
619:         loc_cEstado = ""
620: 
621:         TRY
622:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
623:                 MsgAviso("Nenhum registro selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
624:             ELSE
625:                 SELECT cursor_4c_Dados
626:                 loc_cEstado = ALLTRIM(cursor_4c_Dados.estados)
627: 
628:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEstado)
629:                     THIS.this_oBusinessObject.EditarRegistro()
630:                     THIS.this_cModoAtual = "ALTERAR"
631:                     THIS.BOParaForm()
632:                     THIS.HabilitarCampos(.T.)
633:                     THIS.AjustarChkboxesPorBoConteudo()
634:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
635:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
636:                     THIS.pgf_4c_Paginas.ActivePage = 2
637:                 ENDIF
638:             ENDIF
639:         CATCH TO loc_oErro
640:             MostrarErro(loc_oErro, "FormUfs.BtnAlterarClick")
641:         ENDTRY
642:     ENDPROC
643: 
644:     *==========================================================================
645:     * BtnExcluirClick - Exclui registro selecionado com confirmacao
646:     * Verifica dependencias em SigCdCli antes de excluir
647:     *==========================================================================
648:     PROCEDURE BtnExcluirClick()
649:         LOCAL loc_cEstado, loc_cDescr, loc_nDep, loc_lConfirmado
650:         loc_cEstado    = ""
651:         loc_cDescr     = ""
652:         loc_nDep       = 0
653:         loc_lConfirmado = .F.
654: 
655:         TRY
656:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
657:                 MsgAviso("Nenhum registro selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
658:             ELSE
659:                 SELECT cursor_4c_Dados
660:                 loc_cEstado = ALLTRIM(cursor_4c_Dados.estados)
661:                 loc_cDescr  = ALLTRIM(cursor_4c_Dados.descrs)
662: 
663:                 *-- Verificar dependencia em SigCdCli (clientes cadastrados neste estado)
664:                 SQLEXEC(gnConnHandle, ;
665:                     "SELECT COUNT(*) AS qtd FROM SigCdCli WHERE Estas = " + EscaparSQL(loc_cEstado), ;
666:                     "cursor_4c_DepCli")
667:                 IF USED("cursor_4c_DepCli")
668:                     SELECT cursor_4c_DepCli
669:                     loc_nDep = NVL(cursor_4c_DepCli.qtd, 0)
670:                     USE IN cursor_4c_DepCli
671:                 ENDIF
672: 
673:                 IF loc_nDep > 0
674:                     MsgAviso("UF '" + loc_cEstado + "' n" + CHR(227) + "o pode ser exclu" + ;
675:                         CHR(237) + "do." + CHR(13) + ;
676:                         "Existem " + TRANSFORM(loc_nDep) + " cliente(s) cadastrado(s) neste estado.", ;
677:                         "Depend" + CHR(234) + "ncia")
678:                 ELSE
679:                     loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do estado:" + ;
680:                         CHR(13) + loc_cEstado + " - " + loc_cDescr, ;
681:                         "Confirmar Exclus" + CHR(227) + "o")
682: 
683:                     IF loc_lConfirmado
684:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEstado)
685:                             IF THIS.this_oBusinessObject.Excluir()
686:                                 MsgSucesso("Estado exclu" + CHR(237) + "do com sucesso!")
687:                                 THIS.CarregarLista()
688:                             ENDIF
689:                         ENDIF
690:                     ENDIF
691:                 ENDIF
692:             ENDIF
693:         CATCH TO loc_oErro
694:             MostrarErro(loc_oErro, "FormUfs.BtnExcluirClick")
695:         ENDTRY
696:     ENDPROC
697: 
698:     *==========================================================================
699:     * BtnBuscarClick - Abre pesquisa de estados e recarrega lista com filtro
700:     *==========================================================================
701:     PROCEDURE BtnBuscarClick()
702:         LOCAL loc_oBusca, loc_cFiltro
703:         loc_cFiltro = ""
704: 
705:         TRY
706:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
707:                 "SigCdUfs", "cursor_4c_BuscaEstados", "estados", "", ;
708:                 "Buscar Estado")
709: 
710:             IF VARTYPE(loc_oBusca) = "O"
711:                 loc_oBusca.mAddColuna("estados", "", "UF")
712:                 loc_oBusca.mAddColuna("descrs",  "", "Nome")
713:                 loc_oBusca.Show()
714: 
715:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEstados")
716:                     SELECT cursor_4c_BuscaEstados
717:                     loc_cFiltro = ALLTRIM(cursor_4c_BuscaEstados.estados)
718:                 ENDIF
719: 
720:                 loc_oBusca.Release()
721:             ENDIF
722: 
723:             IF USED("cursor_4c_BuscaEstados")
724:                 USE IN cursor_4c_BuscaEstados
725:             ENDIF
726: 
727:             *-- Recarrega lista com filtro (ou sem filtro se vazio)
728:             IF EMPTY(loc_cFiltro)
729:                 THIS.CarregarLista()
730:             ELSE
731:                 LOCAL loc_oGrid
732:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
733: 
734:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
735:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
736:                     loc_oGrid.ColumnCount  = 5
737: 
738:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.estados"
739:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
740:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.aicms"
741:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.bicms"
742:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.areduzidas"
743: 
744:                     loc_oGrid.Column1.Header1.Caption = "UF"
745:                     loc_oGrid.Column2.Header1.Caption = "Nome"
746:                     loc_oGrid.Column3.Header1.Caption = "Al" + CHR(237) + "q. ICMS"

*-- Linhas 761 a 918:
761:     *==========================================================================
762:     * BtnEncerrarClick - Fecha o formulario
763:     *==========================================================================
764:     PROCEDURE BtnEncerrarClick()
765:         TRY
766:             THIS.Release()
767:         CATCH TO loc_oErro
768:             MostrarErro(loc_oErro, "FormUfs.BtnEncerrarClick")
769:         ENDTRY
770:     ENDPROC
771: 
772:     *==========================================================================
773:     * AjustarChkboxesPorBoConteudo - Ajusta enabled/value dos checkboxes
774:     * conforme o conteudo do BO (logica do Activate original)
775:     * Chamado apos BOParaForm() em VISUALIZAR e ALTERAR
776:     *==========================================================================
777:     PROTECTED PROCEDURE AjustarChkboxesPorBoConteudo()
778:         LOCAL loc_oPg2, loc_lGer50, loc_lGer60
779:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
780:         loc_lGer50 = (THIS.this_oBusinessObject.this_nGer50 <> 0)
781:         loc_lGer60 = (THIS.this_oBusinessObject.this_nGer60 <> 0)
782: 
783:         TRY
784:             *-- Ger50 controla Ger54 (Tipo 54 so valido se Tipo 50 ativo)
785:             IF PEMSTATUS(loc_oPg2, "chk_4c_ChkGer54", 5)
786:                 IF !loc_lGer50
787:                     loc_oPg2.chk_4c_ChkGer54.Value   = 0
788:                     loc_oPg2.chk_4c_ChkGer54.Enabled = .F.
789:                 ELSE
790:                     loc_oPg2.chk_4c_ChkGer54.Enabled = .T.
791:                 ENDIF
792:             ENDIF
793: 
794:             *-- Ger60 controla Ger60I/D/R/P (subcategorias)
795:             IF PEMSTATUS(loc_oPg2, "chk_4c_ChkGer60I", 5)
796:                 IF !loc_lGer60
797:                     loc_oPg2.chk_4c_ChkGer60I.Value   = 0
798:                     loc_oPg2.chk_4c_ChkGer60I.Enabled = .F.
799:                     loc_oPg2.chk_4c_ChkGer60D.Value   = 0
800:                     loc_oPg2.chk_4c_ChkGer60D.Enabled = .F.
801:                     loc_oPg2.chk_4c_ChkGer60R.Value   = 0
802:                     loc_oPg2.chk_4c_ChkGer60R.Enabled = .F.
803:                     loc_oPg2.chk_4c_ChkGer60P.Value   = 0
804:                     loc_oPg2.chk_4c_ChkGer60P.Enabled = .F.
805:                 ELSE
806:                     loc_oPg2.chk_4c_ChkGer60I.Enabled = .T.
807:                     loc_oPg2.chk_4c_ChkGer60D.Enabled = .T.
808:                     loc_oPg2.chk_4c_ChkGer60R.Enabled = .T.
809:                     loc_oPg2.chk_4c_ChkGer60P.Enabled = .T.
810:                 ENDIF
811:             ENDIF
812:         CATCH TO loc_oErro
813:             MostrarErro(loc_oErro, "FormUfs.AjustarChkboxesPorBoConteudo")
814:         ENDTRY
815:     ENDPROC
816: 
817:     *==========================================================================
818:     * ConfigurarPaginaDados - Cria campos de edicao na Page2 (PARTE 1 - 50%)
819:     * Campos principais: Botoes Confirmar/Cancelar, campos de texto,
820:     * labels, combobox IPI, shape separador, label Sintegra
821:     *==========================================================================
822:     PROTECTED PROCEDURE ConfigurarPaginaDados()
823:         LOCAL loc_oPagina, loc_oCnt
824:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
825: 
826:         *----------------------------------------------------------------------
827:         * Botoes Confirmar / Cancelar em cnt_4c_BotoesAcao
828:         * (container ja criado em ConfigurarPageFrame: Top=33, Left=842)
829:         *----------------------------------------------------------------------
830:         loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao
831: 
832:         loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
833:         WITH loc_oCnt.cmd_4c_Confirmar
834:             .Caption         = "Confirmar"
835:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
836:             .PicturePosition = 13
837:             .Top             = 5
838:             .Left            = 5
839:             .Width           = 75
840:             .Height          = 75
841:             .FontName        = "Comic Sans MS"
842:             .FontSize        = 8
843:             .FontBold        = .T.
844:             .FontItalic      = .T.
845:             .ForeColor       = RGB(90, 90, 90)
846:             .BackColor       = RGB(255, 255, 255)
847:             .Themes          = .F.
848:             .SpecialEffect   = 0
849:             .MousePointer    = 15
850:             .WordWrap        = .T.
851:             .AutoSize        = .F.
852:             .Visible         = .T.
853:         ENDWITH
854:         BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
855: 
856:         loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
857:         WITH loc_oCnt.cmd_4c_Cancelar
858:             .Caption         = "Cancelar"
859:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
860:             .PicturePosition = 13
861:             .Top             = 5
862:             .Left            = 80
863:             .Width           = 75
864:             .Height          = 75
865:             .FontName        = "Comic Sans MS"
866:             .FontSize        = 8
867:             .FontBold        = .T.
868:             .FontItalic      = .T.
869:             .ForeColor       = RGB(90, 90, 90)
870:             .BackColor       = RGB(255, 255, 255)
871:             .Themes          = .F.
872:             .SpecialEffect   = 0
873:             .MousePointer    = 15
874:             .WordWrap        = .T.
875:             .AutoSize        = .F.
876:             .Visible         = .T.
877:         ENDWITH
878:         BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
879: 
880:         *----------------------------------------------------------------------
881:         * Label "U.F. :" (Say1: top=116+29=145, left=254, width=33)
882:         *----------------------------------------------------------------------
883:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
884:         WITH loc_oPagina.lbl_4c_Label1
885:             .Caption   = "U.F. :"
886:             .Top       = 145
887:             .Left      = 254
888:             .Width     = 33
889:             .Height    = 15
890:             .FontName  = "Tahoma"
891:             .FontSize  = 8
892:             .ForeColor = RGB(90, 90, 90)
893:             .BackStyle = 0
894:             .Alignment = 1
895:             .Visible   = .T.
896:         ENDWITH
897: 
898:         *----------------------------------------------------------------------
899:         * TextBox getEstado - sigla UF (top=111+29=140, left=289, width=24)
900:         * Editavel apenas nos modos INSERIR/PROCURAR (When event no original)
901:         *----------------------------------------------------------------------
902:         loc_oPagina.AddObject("txt_4c_Estado", "TextBox")
903:         WITH loc_oPagina.txt_4c_Estado
904:             .Value     = ""
905:             .Top       = 140
906:             .Left      = 289
907:             .Width     = 24
908:             .Height    = 25
909:             .FontName  = "Tahoma"
910:             .FontSize  = 8
911:             .MaxLength = 2
912:             .Visible   = .T.
913:         ENDWITH
914: 
915:         *----------------------------------------------------------------------
916:         * TextBox Get_Descr - Descricao (top=111+29=140, left=315, width=276)
917:         *----------------------------------------------------------------------
918:         loc_oPagina.AddObject("txt_4c_Descr", "TextBox")

*-- Linhas 1247 a 1290:
1247:             .ForeColor = RGB(90, 90, 90)
1248:             .Visible   = .T.
1249:         ENDWITH
1250:         BINDEVENT(loc_oPagina.chk_4c_ChkGer50, "InteractiveChange", THIS, "ChkGer50InteractiveChange")
1251: 
1252:         *-- chkGer51: top=270+29=299
1253:         loc_oPagina.AddObject("chk_4c_ChkGer51", "CheckBox")
1254:         WITH loc_oPagina.chk_4c_ChkGer51
1255:             .Caption   = "Tipo 51 - Nota Fiscal de IPI (Modelo 1 e 1A)"
1256:             .Value     = .F.
1257:             .Top       = 299
1258:             .Left      = 21
1259:             .Width     = 226
1260:             .Height    = 15
1261:             .FontName  = "Tahoma"
1262:             .FontSize  = 8
1263:             .ForeColor = RGB(90, 90, 90)
1264:             .Visible   = .T.
1265:         ENDWITH
1266: 
1267:         *-- chkGer53: top=288+29=317
1268:         loc_oPagina.AddObject("chk_4c_ChkGer53", "CheckBox")
1269:         WITH loc_oPagina.chk_4c_ChkGer53
1270:             .Caption   = "Tipo 53 - Registro de Substitui" + CHR(231) + CHR(227) + ;
1271:                          "o Tribut" + CHR(225) + "ria"
1272:             .Value     = .F.
1273:             .Top       = 317
1274:             .Left      = 21
1275:             .Width     = 228
1276:             .Height    = 15
1277:             .FontName  = "Tahoma"
1278:             .FontSize  = 8
1279:             .ForeColor = RGB(90, 90, 90)
1280:             .Visible   = .T.
1281:         ENDWITH
1282: 
1283:         *-- chkGer54: top=305+29=334 (habilitado apenas se chkGer50 ativo)
1284:         loc_oPagina.AddObject("chk_4c_ChkGer54", "CheckBox")
1285:         WITH loc_oPagina.chk_4c_ChkGer54
1286:             .Caption   = "Tipo 54 - Registro de Produtos das Notas Fiscais"
1287:             .Value     = .F.
1288:             .Top       = 334
1289:             .Left      = 21
1290:             .Width     = 249

*-- Linhas 1310 a 1353:
1310:             .ForeColor = RGB(90, 90, 90)
1311:             .Visible   = .T.
1312:         ENDWITH
1313:         BINDEVENT(loc_oPagina.chk_4c_ChkGer60, "InteractiveChange", THIS, "ChkGer60InteractiveChange")
1314: 
1315:         *-- chkGer60I: top=340+29=369
1316:         loc_oPagina.AddObject("chk_4c_ChkGer60I", "CheckBox")
1317:         WITH loc_oPagina.chk_4c_ChkGer60I
1318:             .Caption   = "Tipo 60 - ( I ) " + CHR(205) + "tens dos Cupons"
1319:             .Value     = .F.
1320:             .Top       = 369
1321:             .Left      = 21
1322:             .Width     = 168
1323:             .Height    = 15
1324:             .FontName  = "Tahoma"
1325:             .FontSize  = 8
1326:             .ForeColor = RGB(90, 90, 90)
1327:             .Enabled   = .F.
1328:             .Visible   = .T.
1329:         ENDWITH
1330: 
1331:         *----------------------------------------------------------------------
1332:         * SECAO SINTEGRA - Checkboxes coluna 2 (left=354)
1333:         *----------------------------------------------------------------------
1334:         *-- chkGer60D: top=252+29=281 (habilitado apenas se chkGer60 ativo)
1335:         loc_oPagina.AddObject("chk_4c_ChkGer60D", "CheckBox")
1336:         WITH loc_oPagina.chk_4c_ChkGer60D
1337:             .Caption   = "Tipo 60 - (D) Resumo Di" + CHR(225) + "rio dos Cupons"
1338:             .Value     = .F.
1339:             .Top       = 281
1340:             .Left      = 354
1341:             .Width     = 208
1342:             .Height    = 15
1343:             .FontName  = "Tahoma"
1344:             .FontSize  = 8
1345:             .ForeColor = RGB(90, 90, 90)
1346:             .Enabled   = .F.
1347:             .Visible   = .T.
1348:         ENDWITH
1349: 
1350:         *-- chkGer60R: top=270+29=299
1351:         loc_oPagina.AddObject("chk_4c_ChkGer60R", "CheckBox")
1352:         WITH loc_oPagina.chk_4c_ChkGer60R
1353:             .Caption   = "Tipo 60 - (R) Resumo Mensal dos Cupons"

*-- Linhas 1552 a 1705:
1552:             .Visible   = .F.
1553:         ENDWITH
1554: 
1555:         THIS.TornarControlesVisiveis(loc_oPagina)
1556: 
1557:         *-- Restaurar Visible=.F. para controles que devem iniciar ocultos
1558:         loc_oPagina.chk_4c_Fwcheckbox4.Visible = .F.
1559:     ENDPROC
1560: 
1561:     *==========================================================================
1562:     * ChkGer50InteractiveChange - Controla habilitacao do Ger54
1563:     * (logica do Valid event de chkGer50 no original)
1564:     * PUBLIC para funcionar com BINDEVENT
1565:     *==========================================================================
1566:     PROCEDURE ChkGer50InteractiveChange()
1567:         LOCAL loc_oPg2
1568:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1569: 
1570:         TRY
1571:             IF loc_oPg2.chk_4c_ChkGer50.Value = 0
1572:                 loc_oPg2.chk_4c_ChkGer54.Value   = 0
1573:                 loc_oPg2.chk_4c_ChkGer54.Enabled = .F.
1574:             ELSE
1575:                 loc_oPg2.chk_4c_ChkGer54.Enabled = .T.
1576:             ENDIF
1577:         CATCH TO loc_oErro
1578:             MostrarErro(loc_oErro, "FormUfs.ChkGer50InteractiveChange")
1579:         ENDTRY
1580:     ENDPROC
1581: 
1582:     *==========================================================================
1583:     * ChkGer60InteractiveChange - Controla habilitacao de Ger60I/D/R/P
1584:     * (logica do Valid event de chkGer60 no original)
1585:     * PUBLIC para funcionar com BINDEVENT
1586:     *==========================================================================
1587:     PROCEDURE ChkGer60InteractiveChange()
1588:         LOCAL loc_oPg2
1589:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1590: 
1591:         TRY
1592:             IF loc_oPg2.chk_4c_ChkGer60.Value = 0
1593:                 loc_oPg2.chk_4c_ChkGer60I.Value   = 0
1594:                 loc_oPg2.chk_4c_ChkGer60I.Enabled = .F.
1595:                 loc_oPg2.chk_4c_ChkGer60D.Value   = 0
1596:                 loc_oPg2.chk_4c_ChkGer60D.Enabled = .F.
1597:                 loc_oPg2.chk_4c_ChkGer60R.Value   = 0
1598:                 loc_oPg2.chk_4c_ChkGer60R.Enabled = .F.
1599:                 loc_oPg2.chk_4c_ChkGer60P.Value   = 0
1600:                 loc_oPg2.chk_4c_ChkGer60P.Enabled = .F.
1601:             ELSE
1602:                 loc_oPg2.chk_4c_ChkGer60I.Enabled = .T.
1603:                 loc_oPg2.chk_4c_ChkGer60D.Enabled = .T.
1604:                 loc_oPg2.chk_4c_ChkGer60R.Enabled = .T.
1605:                 loc_oPg2.chk_4c_ChkGer60P.Enabled = .T.
1606:             ENDIF
1607:         CATCH TO loc_oErro
1608:             MostrarErro(loc_oErro, "FormUfs.ChkGer60InteractiveChange")
1609:         ENDTRY
1610:     ENDPROC
1611: 
1612:     *==========================================================================
1613:     * BtnSalvarClick - Valida e salva o registro (PUBLIC para BINDEVENT)
1614:     *==========================================================================
1615:     PROCEDURE BtnSalvarClick()
1616:         LOCAL loc_oPg2, loc_cEstado, loc_cDescr
1617: 
1618:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1619:         loc_cEstado = ALLTRIM(loc_oPg2.txt_4c_Estado.Value)
1620:         loc_cDescr  = ALLTRIM(loc_oPg2.txt_4c_Descr.Value)
1621: 
1622:         *-- Validacoes FORA do TRY (Problema 16)
1623:         IF EMPTY(loc_cEstado)
1624:             MsgAviso("U.F. inv" + CHR(225) + "lido.", "Aten" + CHR(231) + CHR(227) + "o")
1625:             loc_oPg2.txt_4c_Estado.SetFocus()
1626:             RETURN
1627:         ENDIF
1628: 
1629:         IF EMPTY(loc_cDescr)
1630:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria.", ;
1631:                 "Aten" + CHR(231) + CHR(227) + "o")
1632:             loc_oPg2.txt_4c_Descr.SetFocus()
1633:             RETURN
1634:         ENDIF
1635: 
1636:         TRY
1637:             THIS.FormParaBO()
1638: 
1639:             IF THIS.this_oBusinessObject.Salvar()
1640:                 MsgSucesso("Estado salvo com sucesso!")
1641:                 THIS.AlternarPagina(1)
1642:                 THIS.this_cModoAtual = "LISTA"
1643:             ENDIF
1644:         CATCH TO loc_oErro
1645:             MostrarErro(loc_oErro, "FormUfs.BtnSalvarClick")
1646:         ENDTRY
1647:     ENDPROC
1648: 
1649:     *==========================================================================
1650:     * BtnCancelarClick - Cancela edicao e volta para lista (PUBLIC para BINDEVENT)
1651:     *==========================================================================
1652:     PROCEDURE BtnCancelarClick()
1653:         TRY
1654:             THIS.this_cModoAtual = "LISTA"
1655:             THIS.AlternarPagina(1)
1656:             THIS.CarregarLista()
1657:         CATCH TO loc_oErro
1658:             MostrarErro(loc_oErro, "FormUfs.BtnCancelarClick")
1659:         ENDTRY
1660:     ENDPROC
1661: 
1662:     *==========================================================================
1663:     * FormParaBO - Transfere valores do Form para o BO
1664:     *==========================================================================
1665:     PROTECTED PROCEDURE FormParaBO()
1666:         LOCAL loc_oPg2, loc_oBO, loc_cIpi
1667:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1668:         loc_oBO  = THIS.this_oBusinessObject
1669: 
1670:         TRY
1671:             loc_oBO.this_cEstados    = ALLTRIM(loc_oPg2.txt_4c_Estado.Value)
1672:             loc_oBO.this_cDescrs     = ALLTRIM(loc_oPg2.txt_4c_Descr.Value)
1673:             loc_oBO.this_nUFIBGEs   = loc_oPg2.txt_4c_UFIBGES.Value
1674:             loc_oBO.this_nAicms      = loc_oPg2.txt_4c_Aicms.Value
1675:             loc_oBO.this_nBicms      = loc_oPg2.txt_4c_Bicms.Value
1676:             loc_oBO.this_nAliqsbs    = loc_oPg2.txt_4c_AliqSB.Value
1677:             loc_oBO.this_nAreduzidas = loc_oPg2.txt_4c_Areduzida.Value
1678:             loc_oBO.this_cLayoutnf   = ALLTRIM(loc_oPg2.txt_4c_Layoutnf.Value)
1679: 
1680:             *-- IPI: mapear item selecionado para codigo T/I/O
1681:             loc_cIpi = UPPER(ALLTRIM(loc_oPg2.cbo_4c_CmbIpi.Value))
1682:             IF "TRIBUTADO" $ loc_cIpi
1683:                 loc_oBO.this_cIpis = "T"
1684:             ELSE
1685:                 IF "ISENTO" $ loc_cIpi
1686:                     loc_oBO.this_cIpis = "I"
1687:                 ELSE
1688:                     loc_oBO.this_cIpis = "O"
1689:                 ENDIF
1690:             ENDIF
1691: 
1692:             *-- CAT 52
1693:             loc_oBO.this_nNcotepe52s = IIF(loc_oPg2.chk_4c_Fwcheckbox6.Value = 1, 1, 0)
1694: 
1695:             *-- Sintegra flags (CheckBox.Value logico -> NUMERIC 0/1)
1696:             loc_oBO.this_nGer50     = IIF(loc_oPg2.chk_4c_ChkGer50.Value     = 1, 1, 0)
1697:             loc_oBO.this_nGer51     = IIF(loc_oPg2.chk_4c_ChkGer51.Value     = 1, 1, 0)
1698:             loc_oBO.this_nGer53     = IIF(loc_oPg2.chk_4c_ChkGer53.Value     = 1, 1, 0)
1699:             loc_oBO.this_nGer54     = IIF(loc_oPg2.chk_4c_ChkGer54.Value     = 1, 1, 0)
1700:             loc_oBO.this_nGer60     = IIF(loc_oPg2.chk_4c_ChkGer60.Value     = 1, 1, 0)
1701:             loc_oBO.this_nGer60I    = IIF(loc_oPg2.chk_4c_ChkGer60I.Value    = 1, 1, 0)
1702:             loc_oBO.this_nGer60D    = IIF(loc_oPg2.chk_4c_ChkGer60D.Value    = 1, 1, 0)
1703:             loc_oBO.this_nGer60R    = IIF(loc_oPg2.chk_4c_ChkGer60R.Value    = 1, 1, 0)
1704:             loc_oBO.this_nGer60P    = IIF(loc_oPg2.chk_4c_ChkGer60P.Value    = 1, 1, 0)
1705:             loc_oBO.this_nGer61     = IIF(loc_oPg2.chk_4c_ChkGer61.Value     = 1, 1, 0)

*-- Linhas 1721 a 1764:
1721:     *==========================================================================
1722:     * BOParaForm - Transfere valores do BO para o Form
1723:     *==========================================================================
1724:     PROTECTED PROCEDURE BOParaForm()
1725:         LOCAL loc_oPg2, loc_oBO, loc_cIpi
1726:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1727:         loc_oBO  = THIS.this_oBusinessObject
1728: 
1729:         TRY
1730:             loc_oPg2.txt_4c_Estado.Value    = ALLTRIM(loc_oBO.this_cEstados)
1731:             loc_oPg2.txt_4c_Descr.Value     = ALLTRIM(loc_oBO.this_cDescrs)
1732:             loc_oPg2.txt_4c_UFIBGES.Value   = loc_oBO.this_nUFIBGEs
1733:             loc_oPg2.txt_4c_Aicms.Value     = loc_oBO.this_nAicms
1734:             loc_oPg2.txt_4c_Bicms.Value     = loc_oBO.this_nBicms
1735:             loc_oPg2.txt_4c_AliqSB.Value    = loc_oBO.this_nAliqsbs
1736:             loc_oPg2.txt_4c_Areduzida.Value = loc_oBO.this_nAreduzidas
1737:             loc_oPg2.txt_4c_Layoutnf.Value  = ALLTRIM(loc_oBO.this_cLayoutnf)
1738: 
1739:             *-- IPI: mapear codigo T/I/O para item do ComboBox
1740:             loc_cIpi = UPPER(ALLTRIM(loc_oBO.this_cIpis))
1741:             DO CASE
1742:                 CASE loc_cIpi = "T"
1743:                     loc_oPg2.cbo_4c_CmbIpi.Value = PADR("Tributado", 9)
1744:                 CASE loc_cIpi = "I"
1745:                     loc_oPg2.cbo_4c_CmbIpi.Value = PADR("Isento", 9)
1746:                 OTHERWISE
1747:                     loc_oPg2.cbo_4c_CmbIpi.Value = PADR("Outros", 9)
1748:             ENDCASE
1749: 
1750:             *-- CAT 52
1751:             loc_oPg2.chk_4c_Fwcheckbox6.Value = (loc_oBO.this_nNcotepe52s .Value = IIF(loc_oBO.this_nNcotepe52s = 1, 1, 0))
1752: 
1753:             *-- Sintegra flags (NUMERIC 0/1 -> LOGICAL para CheckBox)
1754:             loc_oPg2.chk_4c_ChkGer50.Value     = (loc_oBO.this_nGer50     .Value     = IIF(loc_oBO.this_nGer50     = 1, 1, 0))
1755:             loc_oPg2.chk_4c_ChkGer51.Value     = (loc_oBO.this_nGer51     .Value     = IIF(loc_oBO.this_nGer51     = 1, 1, 0))
1756:             loc_oPg2.chk_4c_ChkGer53.Value     = (loc_oBO.this_nGer53     .Value     = IIF(loc_oBO.this_nGer53     = 1, 1, 0))
1757:             loc_oPg2.chk_4c_ChkGer54.Value     = (loc_oBO.this_nGer54     .Value     = IIF(loc_oBO.this_nGer54     = 1, 1, 0))
1758:             loc_oPg2.chk_4c_ChkGer60.Value     = (loc_oBO.this_nGer60     .Value     = IIF(loc_oBO.this_nGer60     = 1, 1, 0))
1759:             loc_oPg2.chk_4c_ChkGer60I.Value    = (loc_oBO.this_nGer60I    .Value    = IIF(loc_oBO.this_nGer60I    = 1, 1, 0))
1760:             loc_oPg2.chk_4c_ChkGer60D.Value    = (loc_oBO.this_nGer60D    .Value    = IIF(loc_oBO.this_nGer60D    = 1, 1, 0))
1761:             loc_oPg2.chk_4c_ChkGer60R.Value    = (loc_oBO.this_nGer60R    .Value    = IIF(loc_oBO.this_nGer60R    = 1, 1, 0))
1762:             loc_oPg2.chk_4c_ChkGer60P.Value    = (loc_oBO.this_nGer60P    .Value    = IIF(loc_oBO.this_nGer60P    = 1, 1, 0))
1763:             loc_oPg2.chk_4c_ChkGer61.Value     = (loc_oBO.this_nGer61     .Value     = IIF(loc_oBO.this_nGer61     = 1, 1, 0))
1764:             loc_oPg2.chk_4c_ChkGer70.Value     = (loc_oBO.this_nGer70     .Value     = IIF(loc_oBO.this_nGer70     = 1, 1, 0))

*-- Linhas 1784 a 1827:
1784:     *   - fwcheckbox3 (PB): habilitado apenas se estado = "PB"
1785:     *   - fwcheckbox8 (MS): habilitado apenas se estado = "MS"
1786:     *==========================================================================
1787:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1788:         LOCAL loc_oPg2, loc_lIncluir, loc_cEstado
1789:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1790:         loc_lIncluir = (THIS.this_cModoAtual = "INCLUIR")
1791:         loc_cEstado = UPPER(ALLTRIM(loc_oPg2.txt_4c_Estado.Value))
1792: 
1793:         TRY
1794:             *-- Estado e UFIBGES: somente em INCLUIR (When = INSERIR ou PROCURAR)
1795:             loc_oPg2.txt_4c_Estado.Enabled  = par_lHabilitar AND loc_lIncluir
1796:             loc_oPg2.txt_4c_UFIBGES.Enabled = par_lHabilitar AND loc_lIncluir
1797: 
1798:             *-- Campos de texto/numero: habilitados em INCLUIR e ALTERAR
1799:             loc_oPg2.txt_4c_Descr.Enabled     = par_lHabilitar
1800:             loc_oPg2.txt_4c_Aicms.Enabled     = par_lHabilitar
1801:             loc_oPg2.txt_4c_Bicms.Enabled     = par_lHabilitar
1802:             loc_oPg2.txt_4c_AliqSB.Enabled    = par_lHabilitar
1803:             loc_oPg2.txt_4c_Areduzida.Enabled = par_lHabilitar
1804:             loc_oPg2.txt_4c_Layoutnf.Enabled  = par_lHabilitar
1805: 
1806:             *-- ComboBox IPI: habilitado em INCLUIR e ALTERAR
1807:             loc_oPg2.cbo_4c_CmbIpi.Enabled = par_lHabilitar
1808: 
1809:             *-- Checkboxes simples
1810:             loc_oPg2.chk_4c_Fwcheckbox6.Enabled = par_lHabilitar
1811:             loc_oPg2.chk_4c_ChkGer50.Enabled    = par_lHabilitar
1812:             loc_oPg2.chk_4c_ChkGer51.Enabled    = par_lHabilitar
1813:             loc_oPg2.chk_4c_ChkGer53.Enabled    = par_lHabilitar
1814:             loc_oPg2.chk_4c_ChkGer60.Enabled    = par_lHabilitar
1815:             loc_oPg2.chk_4c_ChkGer61.Enabled    = par_lHabilitar
1816:             loc_oPg2.chk_4c_ChkGer70.Enabled    = par_lHabilitar
1817:             loc_oPg2.chk_4c_ChkGer74.Enabled    = par_lHabilitar
1818:             loc_oPg2.chk_4c_ChkGer75.Enabled    = par_lHabilitar
1819:             loc_oPg2.chk_4c_Fwcheckbox1.Enabled = par_lHabilitar
1820:             loc_oPg2.chk_4c_Fwcheckbox2.Enabled = par_lHabilitar
1821:             loc_oPg2.chk_4c_Fwcheckbox5.Enabled = par_lHabilitar
1822:             loc_oPg2.chk_4c_Fwcheckbox7.Enabled = par_lHabilitar
1823: 
1824:             *-- Ger54 habilitado somente se Ger50 estiver marcado
1825:             IF par_lHabilitar
1826:                 loc_oPg2.chk_4c_ChkGer54.Enabled = (loc_oPg2.chk_4c_ChkGer50.Value = 1)
1827:             ELSE

*-- Linhas 1856 a 1899:
1856:     *==========================================================================
1857:     * LimparCampos - Limpa todos os campos de edicao da Page2
1858:     *==========================================================================
1859:     PROTECTED PROCEDURE LimparCampos()
1860:         LOCAL loc_oPg2
1861:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1862: 
1863:         TRY
1864:             loc_oPg2.txt_4c_Estado.Value    = ""
1865:             loc_oPg2.txt_4c_Descr.Value     = ""
1866:             loc_oPg2.txt_4c_UFIBGES.Value   = 0
1867:             loc_oPg2.txt_4c_Aicms.Value     = 0
1868:             loc_oPg2.txt_4c_Bicms.Value     = 0
1869:             loc_oPg2.txt_4c_AliqSB.Value    = 0
1870:             loc_oPg2.txt_4c_Areduzida.Value = 0
1871:             loc_oPg2.txt_4c_Layoutnf.Value  = ""
1872: 
1873:             *-- ComboBox IPI: default "Tributado"
1874:             loc_oPg2.cbo_4c_CmbIpi.Value = PADR("Tributado", 9)
1875: 
1876:             *-- CAT 52
1877:             loc_oPg2.chk_4c_Fwcheckbox6.Value = 0
1878: 
1879:             *-- Sintegra flags
1880:             loc_oPg2.chk_4c_ChkGer50.Value    = 0
1881:             loc_oPg2.chk_4c_ChkGer51.Value    = 0
1882:             loc_oPg2.chk_4c_ChkGer53.Value    = 0
1883:             loc_oPg2.chk_4c_ChkGer54.Value    = 0
1884:             loc_oPg2.chk_4c_ChkGer60.Value    = 0
1885:             loc_oPg2.chk_4c_ChkGer60I.Value   = 0
1886:             loc_oPg2.chk_4c_ChkGer60D.Value   = 0
1887:             loc_oPg2.chk_4c_ChkGer60R.Value   = 0
1888:             loc_oPg2.chk_4c_ChkGer60P.Value   = 0
1889:             loc_oPg2.chk_4c_ChkGer61.Value    = 0
1890:             loc_oPg2.chk_4c_ChkGer70.Value    = 0
1891:             loc_oPg2.chk_4c_ChkGer74.Value    = 0
1892:             loc_oPg2.chk_4c_ChkGer75.Value    = 0
1893:             loc_oPg2.chk_4c_Fwcheckbox1.Value = 0
1894:             loc_oPg2.chk_4c_Fwcheckbox2.Value = 0
1895:             loc_oPg2.chk_4c_Fwcheckbox3.Value = 0
1896:             loc_oPg2.chk_4c_Fwcheckbox4.Value = 0
1897:             loc_oPg2.chk_4c_Fwcheckbox5.Value = 0
1898:             loc_oPg2.chk_4c_Fwcheckbox7.Value = 0
1899:             loc_oPg2.chk_4c_Fwcheckbox8.Value = 0

*-- Linhas 1906 a 1941:
1906:     * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD da Page1
1907:     * conforme disponibilidade de registros no cursor
1908:     *==========================================================================
1909:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1910:         LOCAL loc_oCnt, loc_lTemRegistros
1911:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1912:         loc_lTemRegistros = USED("cursor_4c_Dados") AND ;
1913:                             !EOF("cursor_4c_Dados") AND ;
1914:                             RECCOUNT("cursor_4c_Dados") > 0
1915: 
1916:         TRY
1917:             *-- Incluir, Buscar, Encerrar: sempre habilitados
1918:             loc_oCnt.cmd_4c_Incluir.Enabled  = .T.
1919:             loc_oCnt.cmd_4c_Buscar.Enabled   = .T.
1920:             THIS.pgf_4c_Paginas.Page1.cnt_4c_BotaoSair.cmd_4c_Encerrar.Enabled = .T.
1921: 
1922:             *-- Visualizar, Alterar, Excluir: apenas quando ha registros
1923:             loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lTemRegistros
1924:             loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lTemRegistros
1925:             loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lTemRegistros
1926:         CATCH TO loc_oErro
1927:             MostrarErro(loc_oErro, "FormUfs.AjustarBotoesPorModo")
1928:         ENDTRY
1929:     ENDPROC
1930: 
1931:     *==========================================================================
1932:     * Destroy - Libera recursos ao fechar o formulario
1933:     *==========================================================================
1934:     PROCEDURE Destroy()
1935:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1936:             THIS.this_oBusinessObject = .NULL.
1937:         ENDIF
1938:         DODEFAULT()
1939:     ENDPROC
1940: 
1941: ENDDEFINE


### BO (C:\4c\projeto\app\classes\UfsBO.prg):
*==============================================================================
* UfsBO.prg - Business Object para Cadastro de Estados (UFs)
* Tabela: SigCdUfs
* Chave: estados (char 2)
* Migrado de: SigCdUfs.SCX (SIGCDUFD)
*==============================================================================

DEFINE CLASS UfsBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - campos da tabela SigCdUfs
    *--------------------------------------------------------------------------

    *-- Identificacao (PK)
    this_cEstados                  = ""   && estados CHAR(2) - PK
    this_cDescrs                   = ""   && descrs CHAR(40)

    *-- Aliquotas ICMS
    this_nAicms                    = 0    && aicms NUMERIC(9,2) - Aliquota ICMS
    this_nBicms                    = 0    && bicms NUMERIC(9,2) - Base ICMS Reduzida
    this_nAreduzidas               = 0    && areduzidas NUMERIC(9,2) - Aliquota Reduzida
    this_nAliqsbs                  = 0    && aliqsbs NUMERIC(9,2) - Aliquota Local Substituicao Tributaria

    *-- IPI / Codigo IBGE / Layout NFCe
    this_cIpis                     = ""   && ipis CHAR(1) - T=Tributado I=Isento O=Outros
    this_nUFIBGEs                  = 0    && UFIBGEs NUMERIC(2,0) - Codigo IBGE
    this_cLayoutnf                 = ""   && layoutnf CHAR(20) - Layout NFCe
    this_nChkgnre                  = 0    && chkgnre NUMERIC(1,0)
    this_nNcotepe52s               = 0    && ncotepe52s INT - CAT 52

    *-- Chaves NF-e
    this_cChaveConsultaHomologacao = ""   && ChaveConsultaHomologacao CHAR(80)
    this_cChaveConsultaProducao    = ""   && ChaveConsultaProducao CHAR(80)
    this_cHomologacao              = ""   && Homologacao CHAR(80)
    this_cProducao                 = ""   && Producao CHAR(80)

    *-- Sintegra - flags NUMERIC(1,0)
    this_nGer50                    = 0    && ger50  - Tipo 50 Nota Fiscal (Modelos 1,1A,4,6,21,22)
    this_nGer51                    = 0    && ger51  - Tipo 51 Nota Fiscal de IPI (Modelo 1 e 1A)
    this_nGer53                    = 0    && ger53  - Tipo 53 Registro de Substituicao Tributaria
    this_nGer54                    = 0    && ger54  - Tipo 54 Registro de Produtos das Notas Fiscais
    this_nGer60                    = 0    && ger60  - Tipo 60 Notas Emitidas Por EFC/PDV
    this_nGer60D                   = 0    && ger60d - Tipo 60 (D) Resumo Diario dos Cupons
    this_nGer60I                   = 0    && ger60i - Tipo 60 (I) Itens dos Cupons
    this_nGer60R                   = 0    && ger60r - Tipo 60 (R) Resumo Mensal dos Cupons
    this_nGer60P                   = 0    && ger60p - Tipo 60 (P) Condicoes de Pagamento
    this_nGer61                    = 0    && ger61  - Tipo 61 Nota Fiscal (Modelos 14,15,16,13,2,4)
    this_nGer70                    = 0    && ger70  - Tipo 70 Notas e Conhecimentos de Transportes
    this_nGer74                    = 0    && ger74  - Tipo 74 Inventario
    this_nGer75                    = 0    && ger75  - Tipo 75 Produtos
    this_nGer77                    = 0    && ger77  - Tipo 77 Objetos Para Transportadora
    this_nGer88                    = 0    && ger88  - Tipo 88 Apuracao de ICMS - GIM para PB
    this_nGer88ms                  = 0    && ger88ms - Tipo 88 MS
    this_nGerSefaz                 = 0    && gersefaz - Tipos (16,17,18,19) Selos Para Sefaz
    this_nGerncm                   = 0    && gerncm - Usar barrar no NCM
    this_nCodidents                = 0    && codidents - Usar Codigo de Identidade dos Produtos
    this_nNgersufr1s               = 0    && ngersufr1s INT - sem uso

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdUfs"
            THIS.this_cCampoChave = "estados"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave para auditoria
    *==========================================================================
    PUBLIC FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cEstados
    ENDFUNC

    *==========================================================================
    * Buscar - Seleciona registros com filtro opcional (PUBLIC)
    *==========================================================================
    PUBLIC FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE UPPER(estados) LIKE UPPER(" + ;
                    EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    ") OR UPPER(descrs) LIKE UPPER(" + ;
                    EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")"
            ENDIF

            loc_cSQL = "SELECT estados, descrs, aicms, bicms, areduzidas," + ;
                " aliqsbs, ipis, UFIBGEs, layoutnf," + ;
                " ger50, ger51, ger53, ger54, ger60, ger60d, ger60i, ger60r, ger60p," + ;
                " ger61, ger70, ger74, ger75, ger77, ger88, ger88ms, gersefaz," + ;
                " gerncm, codidents, ngersufr1s, ncotepe52s" + ;
                " FROM SigCdUfs" + loc_cWhere + ;
                " ORDER BY estados"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar estados:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo codigo (estado) (PUBLIC)
    *==========================================================================
    PUBLIC FUNCTION CarregarPorCodigo(par_cEstados)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT estados, descrs, aicms, bicms, areduzidas," + ;
                " aliqsbs, ipis, UFIBGEs, layoutnf," + ;
                " ger50, ger51, ger53, ger54, ger60, ger60d, ger60i, ger60r, ger60p," + ;
                " ger61, ger70, ger74, ger75, ger77, ger88, ger88ms, gersefaz," + ;
                " gerncm, codidents, ngersufr1s, ncotepe52s," + ;
                " chkgnre, ChaveConsultaHomologacao, ChaveConsultaProducao," + ;
                " Homologacao, Producao" + ;
                " FROM SigCdUfs" + ;
                " WHERE estados = " + EscaparSQL(par_cEstados)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.CarregarPorCodigo")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades do BO a partir de cursor (PUBLIC)
    *==========================================================================
    PUBLIC FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cEstados                  = TratarNulo(estados,                   "C")
                THIS.this_cDescrs                   = TratarNulo(descrs,                    "C")
                THIS.this_nAicms                    = TratarNulo(aicms,                     "N")
                THIS.this_nBicms                    = TratarNulo(bicms,                     "N")
                THIS.this_nAreduzidas               = TratarNulo(areduzidas,                "N")
                THIS.this_nAliqsbs                  = TratarNulo(aliqsbs,                   "N")
                THIS.this_cIpis                     = TratarNulo(ipis,                      "C")
                THIS.this_nUFIBGEs                  = TratarNulo(UFIBGEs,                   "N")
                THIS.this_cLayoutnf                 = TratarNulo(layoutnf,                  "C")
                THIS.this_nGer50                    = TratarNulo(ger50,                     "N")
                THIS.this_nGer51                    = TratarNulo(ger51,                     "N")
                THIS.this_nGer53                    = TratarNulo(ger53,                     "N")
                THIS.this_nGer54                    = TratarNulo(ger54,                     "N")
                THIS.this_nGer60                    = TratarNulo(ger60,                     "N")
                THIS.this_nGer60D                   = TratarNulo(ger60d,                    "N")
                THIS.this_nGer60I                   = TratarNulo(ger60i,                    "N")
                THIS.this_nGer60R                   = TratarNulo(ger60r,                    "N")
                THIS.this_nGer60P                   = TratarNulo(ger60p,                    "N")
                THIS.this_nGer61                    = TratarNulo(ger61,                     "N")
                THIS.this_nGer70                    = TratarNulo(ger70,                     "N")
                THIS.this_nGer74                    = TratarNulo(ger74,                     "N")
                THIS.this_nGer75                    = TratarNulo(ger75,                     "N")
                THIS.this_nGer77                    = TratarNulo(ger77,                     "N")
                THIS.this_nGer88                    = TratarNulo(ger88,                     "N")
                THIS.this_nGer88ms                  = TratarNulo(ger88ms,                   "N")
                THIS.this_nGerSefaz                 = TratarNulo(gersefaz,                  "N")
                THIS.this_nGerncm                   = TratarNulo(gerncm,                    "N")
                THIS.this_nCodidents                = TratarNulo(codidents,                 "N")
                THIS.this_nNgersufr1s               = TratarNulo(ngersufr1s,                "N")
                THIS.this_nNcotepe52s               = TratarNulo(ncotepe52s,                "N")

                *-- Campos opcionais (apenas no CarregarPorCodigo completo)
                IF PEMSTATUS(ALIAS(), "chkgnre", 5)
                    THIS.this_nChkgnre              = TratarNulo(chkgnre,                   "N")
                ENDIF
                IF PEMSTATUS(ALIAS(), "ChaveConsultaHomologacao", 5)
                    THIS.this_cChaveConsultaHomologacao = TratarNulo(ChaveConsultaHomologacao, "C")
                ENDIF
                IF PEMSTATUS(ALIAS(), "ChaveConsultaProducao", 5)
                    THIS.this_cChaveConsultaProducao    = TratarNulo(ChaveConsultaProducao,    "C")
                ENDIF
                IF PEMSTATUS(ALIAS(), "Homologacao", 5)
                    THIS.this_cHomologacao              = TratarNulo(Homologacao,              "C")
                ENDIF
                IF PEMSTATUS(ALIAS(), "Producao", 5)
                    THIS.this_cProducao                 = TratarNulo(Producao,                 "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - Insere novo registro na tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdUfs (" + ;
                "estados, descrs, aicms, bicms, areduzidas, aliqsbs, ipis," + ;
                " UFIBGEs, layoutnf, chkgnre," + ;
                " ger50, ger51, ger53, ger54, ger60, ger60d, ger60i, ger60r, ger60p," + ;
                " ger61, ger70, ger74, ger75, ger77, ger88, ger88ms, gersefaz," + ;
                " gerncm, codidents, ngersufr1s, ncotepe52s," + ;
                " ChaveConsultaHomologacao, ChaveConsultaProducao, Homologacao, Producao" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cEstados) + ", " + ;
                EscaparSQL(THIS.this_cDescrs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAicms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBicms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAreduzidas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqsbs) + ", " + ;
                EscaparSQL(THIS.this_cIpis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nUFIBGEs) + ", " + ;
                EscaparSQL(THIS.this_cLayoutnf) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkgnre) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer50) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer51) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer53) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer54) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer60) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer60D) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer60I) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer60R) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer60P) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer61) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer70) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer74) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer75) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer77) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer88) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGer88ms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGerSefaz) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGerncm) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCodidents) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNgersufr1s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcotepe52s) + ", " + ;
                EscaparSQL(THIS.this_cChaveConsultaHomologacao) + ", " + ;
                EscaparSQL(THIS.this_cChaveConsultaProducao) + ", " + ;
                EscaparSQL(THIS.this_cHomologacao) + ", " + ;
                EscaparSQL(THIS.this_cProducao) + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdUfs SET" + ;
                " descrs = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
                " aicms = " + FormatarNumeroSQL(THIS.this_nAicms) + "," + ;
                " bicms = " + FormatarNumeroSQL(THIS.this_nBicms) + "," + ;
                " areduzidas = " + FormatarNumeroSQL(THIS.this_nAreduzidas) + "," + ;
                " aliqsbs = " + FormatarNumeroSQL(THIS.this_nAliqsbs) + "," + ;
                " ipis = " + EscaparSQL(THIS.this_cIpis) + "," + ;
                " UFIBGEs = " + FormatarNumeroSQL(THIS.this_nUFIBGEs) + "," + ;
                " layoutnf = " + EscaparSQL(THIS.this_cLayoutnf) + "," + ;
                " chkgnre = " + FormatarNumeroSQL(THIS.this_nChkgnre) + "," + ;
                " ger50 = " + FormatarNumeroSQL(THIS.this_nGer50) + "," + ;
                " ger51 = " + FormatarNumeroSQL(THIS.this_nGer51) + "," + ;
                " ger53 = " + FormatarNumeroSQL(THIS.this_nGer53) + "," + ;
                " ger54 = " + FormatarNumeroSQL(THIS.this_nGer54) + "," + ;
                " ger60 = " + FormatarNumeroSQL(THIS.this_nGer60) + "," + ;
                " ger60d = " + FormatarNumeroSQL(THIS.this_nGer60D) + "," + ;
                " ger60i = " + FormatarNumeroSQL(THIS.this_nGer60I) + "," + ;
                " ger60r = " + FormatarNumeroSQL(THIS.this_nGer60R) + "," + ;
                " ger60p = " + FormatarNumeroSQL(THIS.this_nGer60P) + "," + ;
                " ger61 = " + FormatarNumeroSQL(THIS.this_nGer61) + "," + ;
                " ger70 = " + FormatarNumeroSQL(THIS.this_nGer70) + "," + ;
                " ger74 = " + FormatarNumeroSQL(THIS.this_nGer74) + "," + ;
                " ger75 = " + FormatarNumeroSQL(THIS.this_nGer75) + "," + ;
                " ger77 = " + FormatarNumeroSQL(THIS.this_nGer77) + "," + ;
                " ger88 = " + FormatarNumeroSQL(THIS.this_nGer88) + "," + ;
                " ger88ms = " + FormatarNumeroSQL(THIS.this_nGer88ms) + "," + ;
                " gersefaz = " + FormatarNumeroSQL(THIS.this_nGerSefaz) + "," + ;
                " gerncm = " + FormatarNumeroSQL(THIS.this_nGerncm) + "," + ;
                " codidents = " + FormatarNumeroSQL(THIS.this_nCodidents) + "," + ;
                " ngersufr1s = " + FormatarNumeroSQL(THIS.this_nNgersufr1s) + "," + ;
                " ncotepe52s = " + FormatarNumeroSQL(THIS.this_nNcotepe52s) + "," + ;
                " ChaveConsultaHomologacao = " + EscaparSQL(THIS.this_cChaveConsultaHomologacao) + "," + ;
                " ChaveConsultaProducao = " + EscaparSQL(THIS.this_cChaveConsultaProducao) + "," + ;
                " Homologacao = " + EscaparSQL(THIS.this_cHomologacao) + "," + ;
                " Producao = " + EscaparSQL(THIS.this_cProducao) + ;
                " WHERE estados = " + EscaparSQL(THIS.this_cEstados)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdUfs WHERE estados = " + ;
                EscaparSQL(THIS.this_cEstados)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "UfsBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

