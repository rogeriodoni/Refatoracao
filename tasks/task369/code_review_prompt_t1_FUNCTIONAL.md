# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BINDEVENT-PARAMS] Handler 'ValidarTipos' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarTipos(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCla.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1562 linhas total):

*-- Linhas 30 a 163:
30:     this_cModoAtual      = "LISTA"
31: 
32:     *--------------------------------------------------------------------------
33:     * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
34:     *--------------------------------------------------------------------------
35:     PROCEDURE Init()
36:         LOCAL loc_lResultado
37:         loc_lResultado = .F.
38: 
39:         TRY
40:             loc_lResultado = DODEFAULT()
41:         CATCH TO loc_oErro
42:             MsgErro(loc_oErro.Message, "FormCla.Init")
43:         ENDTRY
44: 
45:         RETURN loc_lResultado
46:     ENDPROC
47: 
48:     *--------------------------------------------------------------------------
49:     * InicializarForm - Configura estrutura completa
50:     *--------------------------------------------------------------------------
51:     PROTECTED PROCEDURE InicializarForm()
52:         LOCAL loc_lResultado
53:         loc_lResultado = .F.
54: 
55:         TRY
56:             THIS.Caption = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Produto"
57: 
58:             THIS.this_oBusinessObject = CREATEOBJECT("ClaBO")
59: 
60:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
61:                 MsgErro("Falha ao criar ClaBO", "Erro")
62:             ELSE
63:                 *-- Cursor local para grade de grupos (equivalente ao Load.crGrdCdCom original)
64:                 IF USED("crGrdCdCom")
65:                     USE IN crGrdCdCom
66:                 ENDIF
67:                 SET NULL ON
68:                 CREATE CURSOR crGrdCdCom (CGrus C(3), DGrus C(20))
69:                 SET NULL OFF
70: 
71:                 THIS.ConfigurarPageFrame()
72: 
73:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
74:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
75: 
76:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
77:                     THIS.CarregarLista()
78:                 ENDIF
79: 
80:                 THIS.pgf_4c_Paginas.Visible  = .T.
81:                 THIS.pgf_4c_Paginas.ActivePage = 1
82:                 THIS.this_cModoAtual = "LISTA"
83:                 loc_lResultado = .T.
84:             ENDIF
85:         CATCH TO loc_oErro
86:             MsgErro(loc_oErro.Message, "FormCla.InicializarForm")
87:         ENDTRY
88: 
89:         RETURN loc_lResultado
90:     ENDPROC
91: 
92:     *--------------------------------------------------------------------------
93:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
94:     *--------------------------------------------------------------------------
95:     PROTECTED PROCEDURE ConfigurarPageFrame()
96:         LOCAL loc_oPgf
97:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
98:         loc_oPgf = THIS.pgf_4c_Paginas
99: 
100:         WITH loc_oPgf
101:             .PageCount       = 2
102:             .Top             = -29
103:             .Left            = 0
104:             .Width           = THIS.Width
105:             .Height          = THIS.Height + 29
106:             .Tabs            = .F.
107:             .Visible         = .T.
108:             .Page1.Caption   = "Lista"
109:             .Page1.BackColor = RGB(100, 100, 100)
110:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111:             .Page2.Caption   = "Dados"
112:             .Page2.BackColor = RGB(100, 100, 100)
113:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114:         ENDWITH
115: 
116:         THIS.ConfigurarPaginaLista()
117:         THIS.ConfigurarPaginaDados()
118:     ENDPROC
119: 
120:     *--------------------------------------------------------------------------
121:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid
122:     *--------------------------------------------------------------------------
123:     PROTECTED PROCEDURE ConfigurarPaginaLista()
124:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
125:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
126: 
127:         *-- Cabecalho cinza
128:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
129:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
130:         WITH loc_oCab
131:             .Top         = 31
132:             .Left        = 0
133:             .Width       = THIS.Width
134:             .Height      = 80
135:             .BackColor   = RGB(100, 100, 100)
136:             .BorderWidth = 0
137:             .Visible     = .T.
138:         ENDWITH
139: 
140:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
141:         WITH loc_oCab.lbl_4c_Sombra
142:             .AutoSize  = .F.
143:             .Caption   = THIS.Caption
144:             .Top       = 15
145:             .Left      = 10
146:             .Width     = THIS.Width
147:             .Height    = 40
148:             .FontName  = "Tahoma"
149:             .FontSize  = 16
150:             .FontBold  = .T.
151:             .ForeColor = RGB(0, 0, 0)
152:             .BackStyle = 0
153:             .Visible   = .T.
154:         ENDWITH
155: 
156:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
157:         WITH loc_oCab.lbl_4c_Titulo
158:             .AutoSize  = .F.
159:             .Caption   = THIS.Caption
160:             .Top       = 18
161:             .Left      = 10
162:             .Width     = THIS.Width
163:             .Height    = 46

*-- Linhas 205 a 478:
205:             .AutoSize        = .F.
206:             .Visible         = .T.
207:         ENDWITH
208:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
209: 
210:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
211:         WITH loc_oBotoes.cmd_4c_Visualizar
212:             .Caption         = "Visualizar"
213:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
214:             .PicturePosition = 13
215:             .Top             = 5
216:             .Left            = 80
217:             .Width           = 75
218:             .Height          = 75
219:             .BackColor       = RGB(255, 255, 255)
220:             .ForeColor       = RGB(90, 90, 90)
221:             .FontName        = "Comic Sans MS"
222:             .FontSize        = 8
223:             .FontBold        = .T.
224:             .FontItalic      = .T.
225:             .Themes          = .F.
226:             .SpecialEffect   = 0
227:             .MousePointer    = 15
228:             .WordWrap        = .T.
229:             .AutoSize        = .F.
230:             .Visible         = .T.
231:         ENDWITH
232:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
233: 
234:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
235:         WITH loc_oBotoes.cmd_4c_Alterar
236:             .Caption         = "Alterar"
237:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
238:             .PicturePosition = 13
239:             .Top             = 5
240:             .Left            = 155
241:             .Width           = 75
242:             .Height          = 75
243:             .BackColor       = RGB(255, 255, 255)
244:             .ForeColor       = RGB(90, 90, 90)
245:             .FontName        = "Comic Sans MS"
246:             .FontSize        = 8
247:             .FontBold        = .T.
248:             .FontItalic      = .T.
249:             .Themes          = .F.
250:             .SpecialEffect   = 0
251:             .MousePointer    = 15
252:             .WordWrap        = .T.
253:             .AutoSize        = .F.
254:             .Visible         = .T.
255:         ENDWITH
256:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
257: 
258:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
259:         WITH loc_oBotoes.cmd_4c_Excluir
260:             .Caption         = "Excluir"
261:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
262:             .PicturePosition = 13
263:             .Top             = 5
264:             .Left            = 230
265:             .Width           = 75
266:             .Height          = 75
267:             .BackColor       = RGB(255, 255, 255)
268:             .ForeColor       = RGB(90, 90, 90)
269:             .FontName        = "Comic Sans MS"
270:             .FontSize        = 8
271:             .FontBold        = .T.
272:             .FontItalic      = .T.
273:             .Themes          = .F.
274:             .SpecialEffect   = 0
275:             .MousePointer    = 15
276:             .WordWrap        = .T.
277:             .AutoSize        = .F.
278:             .Visible         = .T.
279:         ENDWITH
280:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
281: 
282:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
283:         WITH loc_oBotoes.cmd_4c_Buscar
284:             .Caption         = "Buscar"
285:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
286:             .PicturePosition = 13
287:             .Top             = 5
288:             .Left            = 305
289:             .Width           = 75
290:             .Height          = 75
291:             .BackColor       = RGB(255, 255, 255)
292:             .ForeColor       = RGB(90, 90, 90)
293:             .FontName        = "Comic Sans MS"
294:             .FontSize        = 8
295:             .FontBold        = .T.
296:             .FontItalic      = .T.
297:             .Themes          = .F.
298:             .SpecialEffect   = 0
299:             .MousePointer    = 15
300:             .WordWrap        = .T.
301:             .AutoSize        = .F.
302:             .Visible         = .T.
303:         ENDWITH
304:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
305: 
306:         *-- Container Encerrar canonico
307:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
308:         loc_oSaida = loc_oPg1.cnt_4c_Saida
309:         WITH loc_oSaida
310:             .Top         = 29
311:             .Left        = 917
312:             .Width       = 90
313:             .Height      = 85
314:             .BackStyle   = 0
315:             .BorderWidth = 0
316:             .Visible     = .T.
317:         ENDWITH
318: 
319:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
320:         WITH loc_oSaida.cmd_4c_Encerrar
321:             .Caption         = "Encerrar"
322:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
323:             .PicturePosition = 13
324:             .Top             = 5
325:             .Left            = 5
326:             .Width           = 75
327:             .Height          = 75
328:             .BackColor       = RGB(255, 255, 255)
329:             .ForeColor       = RGB(90, 90, 90)
330:             .FontName        = "Comic Sans MS"
331:             .FontSize        = 8
332:             .FontBold        = .T.
333:             .FontItalic      = .T.
334:             .Themes          = .F.
335:             .SpecialEffect   = 0
336:             .MousePointer    = 15
337:             .WordWrap        = .T.
338:             .AutoSize        = .F.
339:             .Visible         = .T.
340:         ENDWITH
341:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
342: 
343:         *-- Grid de listagem (dados carregados por CarregarLista)
344:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
345:         loc_oGrid = loc_oPg1.grd_4c_Lista
346:         WITH loc_oGrid
347:             .Top                = 117
348:             .Left               = 12
349:             .Width              = 890
350:             .Height             = 498
351:             .FontName           = "Verdana"
352:             .FontSize           = 8
353:             .ForeColor          = RGB(90, 90, 90)
354:             .BackColor          = RGB(255, 255, 255)
355:             .GridLineColor      = RGB(238, 238, 238)
356:             .GridLines          = 3
357:             .HighlightBackColor = RGB(255, 255, 255)
358:             .HighlightForeColor = RGB(15, 41, 104)
359:             .HighlightStyle     = 2
360:             .DeleteMark         = .F.
361:             .RecordMark         = .F.
362:             .RowHeight          = 16
363:             .ScrollBars         = 2
364:             .Visible            = .T.
365:         ENDWITH
366:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridListaAfterRowColChange")
367: 
368:         THIS.TornarControlesVisiveis(loc_oPg1)
369:     ENDPROC
370: 
371:     *--------------------------------------------------------------------------
372:     * ConfigurarPaginaDados - Page2: botoes Confirmar/Cancelar + campos principais
373:     * Fase 5: Container de botoes + primeiros 50% dos campos
374:     *--------------------------------------------------------------------------
375:     PROTECTED PROCEDURE ConfigurarPaginaDados()
376:         LOCAL loc_oPg2, loc_oBotoesAcao, loc_oOpt
377:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
378: 
379:         *-- Container Confirmar/Cancelar (Grupo_Salva.Left=820, Top=8+29=37)
380:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
381:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
382:         WITH loc_oBotoesAcao
383:             .Top         = 37
384:             .Left        = 820
385:             .Width       = 160
386:             .Height      = 85
387:             .BackStyle   = 0
388:             .BorderWidth = 0
389:             .Visible     = .T.
390:         ENDWITH
391: 
392:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
393:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
394:             .Caption         = "Confirmar"
395:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
396:             .PicturePosition = 13
397:             .Top             = 5
398:             .Left            = 5
399:             .Width           = 75
400:             .Height          = 75
401:             .BackColor       = RGB(255, 255, 255)
402:             .ForeColor       = RGB(90, 90, 90)
403:             .FontName        = "Comic Sans MS"
404:             .FontSize        = 8
405:             .FontBold        = .T.
406:             .FontItalic      = .T.
407:             .Themes          = .F.
408:             .SpecialEffect   = 0
409:             .MousePointer    = 15
410:             .WordWrap        = .T.
411:             .AutoSize        = .F.
412:             .Visible         = .T.
413:         ENDWITH
414:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
415: 
416:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
417:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
418:             .Caption         = "Encerrar"
419:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
420:             .PicturePosition = 13
421:             .Top             = 5
422:             .Left            = 80
423:             .Width           = 75
424:             .Height          = 75
425:             .BackColor       = RGB(255, 255, 255)
426:             .ForeColor       = RGB(90, 90, 90)
427:             .FontName        = "Comic Sans MS"
428:             .FontSize        = 8
429:             .FontBold        = .T.
430:             .FontItalic      = .T.
431:             .Themes          = .F.
432:             .SpecialEffect   = 0
433:             .MousePointer    = 15
434:             .WordWrap        = .T.
435:             .AutoSize        = .F.
436:             .Visible         = .T.
437:         ENDWITH
438:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
439: 
440:         *-------- Say1 + Getcods: Codigo (Top=85+29=114, Left=280 / Top=81+29=110, Left=326) ----
441:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
442:         WITH loc_oPg2.lbl_4c_Label1
443:             .AutoSize  = .F.
444:             .Caption   = "Codigo :"
445:             .Top       = 114
446:             .Left      = 280
447:             .Width     = 42
448:             .Height    = 15
449:             .FontName  = "Tahoma"
450:             .FontSize  = 8
451:             .FontBold  = .F.
452:             .ForeColor = RGB(90, 90, 90)
453:             .BackStyle = 0
454:             .Visible   = .T.
455:         ENDWITH
456: 
457:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
458:         WITH loc_oPg2.txt_4c_Codigo
459:             .Value         = ""
460:             .Alignment     = 3
461:             .Height        = 24
462:             .Left          = 326
463:             .Top           = 110
464:             .Width         = 38
465:             .MaxLength     = 3
466:             .SpecialEffect = 1
467:             .FontName      = "Tahoma"
468:             .FontSize      = 8
469:             .Visible       = .T.
470:         ENDWITH
471: 
472:         *-------- Say2 + Getdescs: Descricao (Top=112+29=141 / Top=108+29=137) ----------------
473:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")
474:         WITH loc_oPg2.lbl_4c_Label2
475:             .AutoSize  = .F.
476:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
477:             .Top       = 141
478:             .Left      = 267

*-- Linhas 532 a 594:
532:             .ToolTipText   = "O = Ouro, P = Prata, R = Rel" + CHR(243) + "gio, J = Jolie"
533:             .Visible       = .T.
534:         ENDWITH
535:         BINDEVENT(loc_oPg2.txt_4c_Tipos, "KeyPress", THIS, "ValidarTipos")
536: 
537:         *-------- Say3 + optSituas: Usada em Produtos (Top=163+29=192 / Top=158+29=187) -------
538:         loc_oPg2.AddObject("lbl_4c_Label3", "Label")
539:         WITH loc_oPg2.lbl_4c_Label3
540:             .AutoSize  = .F.
541:             .Caption   = "Usada em Produtos :"
542:             .Top       = 192
543:             .Left      = 220
544:             .Width     = 102
545:             .Height    = 15
546:             .FontName  = "Tahoma"
547:             .FontSize  = 8
548:             .FontBold  = .F.
549:             .ForeColor = RGB(90, 90, 90)
550:             .BackStyle = 0
551:             .Visible   = .T.
552:         ENDWITH
553: 
554:         loc_oPg2.AddObject("obj_4c_OptSituas", "OptionGroup")
555:         loc_oOpt = loc_oPg2.obj_4c_OptSituas
556:         WITH loc_oOpt
557:             .ButtonCount = 3
558:             .Top         = 187
559:             .Left        = 320
560:             .Width       = 188
561:             .Height      = 25
562:             .BackStyle   = 0
563:             .BorderStyle = 0
564:             .Value       = 1
565:             .Visible     = .T.
566:             WITH .Buttons(1)
567:                 .Caption   = "Ativos"
568:                 .Left      = 5
569:                 .Top       = 5
570:                 .Width     = 48
571:                 .AutoSize  = .T.
572:                 .FontName  = "Tahoma"
573:                 .FontSize  = 8
574:                 .BackStyle = 0
575:                 .ForeColor = RGB(90, 90, 90)
576:             ENDWITH
577:             WITH .Buttons(2)
578:                 .Caption   = "Inativos"
579:                 .Left      = 63
580:                 .Top       = 5
581:                 .Width     = 57
582:                 .AutoSize  = .T.
583:                 .FontName  = "Tahoma"
584:                 .FontSize  = 8
585:                 .BackStyle = 0
586:                 .ForeColor = RGB(90, 90, 90)
587:             ENDWITH
588:             WITH .Buttons(3)
589:                 .Caption   = "Ambos"
590:                 .Left      = 133
591:                 .Top       = 5
592:                 .Width     = 50
593:                 .AutoSize  = .T.
594:                 .FontName  = "Tahoma"

*-- Linhas 629 a 1526:
629:             .FontSize      = 8
630:             .Visible       = .T.
631:         ENDWITH
632:         BINDEVENT(loc_oPg2.txt_4c_GdeGrps, "KeyPress", THIS, "GdeGrpsKeyPress")
633:         BINDEVENT(loc_oPg2.txt_4c_GdeGrps, "DblClick", THIS, "GdeGrpsDblClick")
634: 
635:         *-------- grd_4c_Dados: Grid de Grupos (RecordSource = crGrdCdCom) ---------------
636:         LOCAL loc_oGridGrp
637:         loc_oPg2.AddObject("grd_4c_Dados", "Grid")
638:         loc_oGridGrp = loc_oPg2.grd_4c_Dados
639:         loc_oGridGrp.RecordSource = "crGrdCdCom"
640:         loc_oGridGrp.ColumnCount  = 2
641:         WITH loc_oGridGrp
642:             .Top               = 210
643:             .Left              = 326
644:             .Width             = 217
645:             .Height            = 365
646:             .FontSize          = 8
647:             .AllowHeaderSizing = .F.
648:             .AllowRowSizing    = .F.
649:             .DeleteMark        = .F.
650:             .HeaderHeight      = 16
651:             .RecordMark        = .T.
652:             .RowHeight         = 15
653:             .ScrollBars        = 2
654:             .GridLineColor     = RGB(238, 238, 238)
655:             .GridLines         = 3
656:             .Visible           = .T.
657:         ENDWITH
658:         WITH loc_oGridGrp.Column1
659:             .ControlSource = "crGrdCdCom.CGrus"
660:             .Width         = 34
661:             .Movable       = .F.
662:             .Resizable     = .F.
663:             .FontSize      = 8
664:         ENDWITH
665:         loc_oGridGrp.Column1.Header1.Caption   = "Grupo"
666:         loc_oGridGrp.Column1.Header1.Alignment = 2
667:         WITH loc_oGridGrp.Column2
668:             .ControlSource = "crGrdCdCom.DGrus"
669:             .Width         = 150
670:             .Movable       = .F.
671:             .Resizable     = .F.
672:             .ReadOnly      = .F.
673:             .FontSize      = 8
674:         ENDWITH
675:         loc_oGridGrp.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
676:         loc_oGridGrp.Column2.Header1.Alignment = 2
677:         BINDEVENT(loc_oGridGrp, "AfterRowColChange", THIS, "GridGruposAfterRowColChange")
678: 
679:         *-------- cmd_4c_BtnCarregar: Carregar Grande Grupo (Top=180+29=209, Left=550) --
680:         loc_oPg2.AddObject("cmd_4c_BtnCarregar", "CommandButton")
681:         WITH loc_oPg2.cmd_4c_BtnCarregar
682:             .Caption     = ""
683:             .Picture     = gc_4c_CaminhoIcones + "importar_48.png"
684:             .Top         = 209
685:             .Left        = 550
686:             .Width       = 52
687:             .Height      = 52
688:             .BackColor   = RGB(255, 255, 255)
689:             .FontName    = "Verdana"
690:             .FontSize    = 8
691:             .Themes      = .F.
692:             .ToolTipText = "Carregar Grande Grupo"
693:             .Visible     = .T.
694:         ENDWITH
695:         BINDEVENT(loc_oPg2.cmd_4c_BtnCarregar, "Click", THIS, "BtnCarregarClick")
696: 
697:         *-------- cmd_4c_CmdExcluir: Excluir Grupo (Top=341+29=370, Left=550) ----------
698:         loc_oPg2.AddObject("cmd_4c_CmdExcluir", "CommandButton")
699:         WITH loc_oPg2.cmd_4c_CmdExcluir
700:             .Caption     = ""
701:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
702:             .Top         = 370
703:             .Left        = 550
704:             .Width       = 52
705:             .Height      = 52
706:             .BackColor   = RGB(255, 255, 255)
707:             .FontName    = "Verdana"
708:             .FontSize    = 8
709:             .Themes      = .F.
710:             .ToolTipText = "Excluir Grupo"
711:             .Visible     = .T.
712:         ENDWITH
713:         BINDEVENT(loc_oPg2.cmd_4c_CmdExcluir, "Click", THIS, "CmdExcluirClick")
714: 
715:         THIS.TornarControlesVisiveis(loc_oPg2)
716:     ENDPROC
717: 
718:     *--------------------------------------------------------------------------
719:     * CarregarLista - Carrega cursor de SigCdCls no grid da Page1
720:     *--------------------------------------------------------------------------
721:     PROCEDURE CarregarLista()
722:         LOCAL loc_lResultado, loc_oGrid
723:         loc_lResultado = .F.
724: 
725:         TRY
726:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
727:                 SET NULL ON
728:                 CREATE CURSOR cursor_4c_Dados (cods C(3), descs C(20))
729:                 SET NULL OFF
730:                 loc_lResultado = .T.
731:             ELSE
732:                 IF THIS.this_oBusinessObject.Buscar("")
733:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
734:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
735: 
736:                         loc_oGrid.ColumnCount  = 2
737:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
738:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
739:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
740: 
741:                         loc_oGrid.Column1.Width   = 80
742:                         loc_oGrid.Column2.Width   = 800
743: 
744:                         loc_oGrid.Column1.ReadOnly = .T.
745:                         loc_oGrid.Column2.ReadOnly = .T.
746: 
747:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
748:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
749: 
750:                         THIS.FormatarGridLista(loc_oGrid)
751:                     ENDIF
752:                     loc_lResultado = .T.
753:                 ENDIF
754:             ENDIF
755:         CATCH TO loc_oErro
756:             MsgErro(loc_oErro.Message, "FormCla.CarregarLista")
757:         ENDTRY
758: 
759:         RETURN loc_lResultado
760:     ENDPROC
761: 
762:     *--------------------------------------------------------------------------
763:     * AlternarPagina - Alterna entre Lista (1) e Dados (2)
764:     *--------------------------------------------------------------------------
765:     PROCEDURE AlternarPagina(par_nPagina)
766:         LOCAL loc_lResultado
767:         loc_lResultado = .F.
768: 
769:         TRY
770:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
771:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
772:                 IF par_nPagina = 1
773:                     THIS.CarregarLista()
774:                 ENDIF
775:                 loc_lResultado = .T.
776:             ENDIF
777:         CATCH TO loc_oErro
778:             MsgErro(loc_oErro.Message, "FormCla.AlternarPagina")
779:         ENDTRY
780: 
781:         RETURN loc_lResultado
782:     ENDPROC
783: 
784:     *--------------------------------------------------------------------------
785:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
786:     *--------------------------------------------------------------------------
787:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
788:         LOCAL loc_nI, loc_oObjeto, loc_nP
789:         loc_nI = 0
790:         loc_nP = 0
791: 
792:         FOR loc_nI = 1 TO par_oContainer.ControlCount
793:             loc_oObjeto = par_oContainer.Controls(loc_nI)
794: 
795:             IF VARTYPE(loc_oObjeto) = "O"
796:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
797:                     loc_oObjeto.Visible = .T.
798:                 ENDIF
799: 
800:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
801:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
802:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
803:                     ENDFOR
804:                 ENDIF
805: 
806:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
807:                     THIS.TornarControlesVisiveis(loc_oObjeto)
808:                 ENDIF
809:             ENDIF
810:         ENDFOR
811:     ENDPROC
812: 
813:     *--------------------------------------------------------------------------
814:     * FormatarGridLista - Aplica fonte padrao ao grid da lista
815:     *--------------------------------------------------------------------------
816:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
817:         WITH par_oGrid
818:             .FontName = "Tahoma"
819:             .FontSize = 8
820:         ENDWITH
821:     ENDPROC
822: 
823:     *--------------------------------------------------------------------------
824:     * Destroy - Libera recursos
825:     *--------------------------------------------------------------------------
826:     PROCEDURE Destroy()
827:         TRY
828:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
829:                 THIS.this_oBusinessObject = .NULL.
830:             ENDIF
831:             IF USED("cursor_4c_Dados")
832:                 USE IN cursor_4c_Dados
833:             ENDIF
834:             IF USED("cursor_4c_Grupos")
835:                 USE IN cursor_4c_Grupos
836:             ENDIF
837:             IF USED("crGrdCdCom")
838:                 USE IN crGrdCdCom
839:             ENDIF
840:         CATCH TO loc_oErro
841:             MsgErro(loc_oErro.Message, "FormCla.Destroy")
842:         ENDTRY
843: 
844:         DODEFAULT()
845:     ENDPROC
846: 
847:     *--------------------------------------------------------------------------
848:     * GridListaAfterRowColChange - Atualiza estado dos botoes ao mudar linha
849:     *--------------------------------------------------------------------------
850:     PROCEDURE GridListaAfterRowColChange(par_nColIndex)
851:         THIS.AjustarBotoesModo()
852:     ENDPROC
853: 
854:     *--------------------------------------------------------------------------
855:     * AjustarBotoesModo - Habilita/desabilita botoes conforme existencia de registro
856:     *--------------------------------------------------------------------------
857:     PROTECTED PROCEDURE AjustarBotoesModo()
858:         LOCAL loc_lTemRegistro, loc_oBotoes
859:         loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
860:             RECCOUNT("cursor_4c_Dados") > 0 AND ;
861:             !EOF("cursor_4c_Dados")
862:         loc_oBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
863: 
864:         IF VARTYPE(loc_oBotoes) = "O"
865:             IF PEMSTATUS(loc_oBotoes, "cmd_4c_Visualizar", 5)
866:                 loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
867:             ENDIF
868:             IF PEMSTATUS(loc_oBotoes, "cmd_4c_Alterar", 5)
869:                 loc_oBotoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
870:             ENDIF
871:             IF PEMSTATUS(loc_oBotoes, "cmd_4c_Excluir", 5)
872:                 loc_oBotoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
873:             ENDIF
874:         ENDIF
875:     ENDPROC
876: 
877:     *--------------------------------------------------------------------------
878:     * BtnIncluirClick - Prepara BO e navega para Page2 em modo INCLUIR
879:     *--------------------------------------------------------------------------
880:     PROCEDURE BtnIncluirClick()
881:         TRY
882:             THIS.this_oBusinessObject.NovoRegistro()
883:             THIS.this_cModoAtual = "INCLUIR"
884:             THIS.LimparCampos()
885:             THIS.HabilitarCampos(.T.)
886:             THIS.AlternarPagina(2)
887:         CATCH TO loc_oErro
888:             MsgErro(loc_oErro.Message, "FormCla.BtnIncluirClick")
889:         ENDTRY
890:     ENDPROC
891: 
892:     *--------------------------------------------------------------------------
893:     * BtnVisualizarClick - Carrega registro selecionado em modo VISUALIZAR
894:     *--------------------------------------------------------------------------
895:     PROCEDURE BtnVisualizarClick()
896:         LOCAL loc_cCodigo
897:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
898:             MsgAviso("Selecione um registro para visualizar.", "Aviso")
899:             RETURN
900:         ENDIF
901: 
902:         TRY
903:             SELECT cursor_4c_Dados
904:             loc_cCodigo = ALLTRIM(cods)
905:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
906:                 THIS.this_cModoAtual = "VISUALIZAR"
907:                 THIS.BOParaForm()
908:                 THIS.HabilitarCampos(.F.)
909:                 THIS.AlternarPagina(2)
910:             ENDIF
911:         CATCH TO loc_oErro
912:             MsgErro(loc_oErro.Message, "FormCla.BtnVisualizarClick")
913:         ENDTRY
914:     ENDPROC
915: 
916:     *--------------------------------------------------------------------------
917:     * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
918:     *--------------------------------------------------------------------------
919:     PROCEDURE BtnAlterarClick()
920:         LOCAL loc_cCodigo
921:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
922:             MsgAviso("Selecione um registro para alterar.", "Aviso")
923:             RETURN
924:         ENDIF
925: 
926:         TRY
927:             SELECT cursor_4c_Dados
928:             loc_cCodigo = ALLTRIM(cods)
929:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
930:                 THIS.this_oBusinessObject.EditarRegistro()
931:                 THIS.this_cModoAtual = "ALTERAR"
932:                 THIS.BOParaForm()
933:                 THIS.HabilitarCampos(.T.)
934:                 THIS.AlternarPagina(2)
935:             ENDIF
936:         CATCH TO loc_oErro
937:             MsgErro(loc_oErro.Message, "FormCla.BtnAlterarClick")
938:         ENDTRY
939:     ENDPROC
940: 
941:     *--------------------------------------------------------------------------
942:     * BtnExcluirClick - Confirma e exclui registro selecionado
943:     *--------------------------------------------------------------------------
944:     PROCEDURE BtnExcluirClick()
945:         LOCAL loc_cCodigo
946:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
947:             MsgAviso("Selecione um registro para excluir.", "Aviso")
948:             RETURN
949:         ENDIF
950: 
951:         SELECT cursor_4c_Dados
952:         loc_cCodigo = ALLTRIM(cods)
953: 
954:         IF MsgConfirma("Confirma exclus" + CHR(227) + "o do registro '" + ;
955:                 loc_cCodigo + "'?", "Confirmar Exclus" + CHR(227) + "o")
956:             TRY
957:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
958:                     IF THIS.this_oBusinessObject.Excluir()
959:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Sucesso")
960:                         THIS.CarregarLista()
961:                     ENDIF
962:                 ENDIF
963:             CATCH TO loc_oErro
964:                 MsgErro(loc_oErro.Message, "FormCla.BtnExcluirClick")
965:             ENDTRY
966:         ENDIF
967:     ENDPROC
968: 
969:     *--------------------------------------------------------------------------
970:     * BtnBuscarClick - Abre FormBuscaAuxiliar para pesquisar classificacao
971:     *--------------------------------------------------------------------------
972:     PROCEDURE BtnBuscarClick()
973:         LOCAL loc_oBusca
974:         TRY
975:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
976:                 "SigCdCls", "cursor_4c_Busca", "Cods", "", ;
977:                 "Buscar Classifica" + CHR(231) + CHR(227) + "o")
978: 
979:             IF VARTYPE(loc_oBusca) = "O"
980:                 loc_oBusca.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
981:                 loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
982:                 loc_oBusca.Show()
983: 
984:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
985:                     SELECT cursor_4c_Dados
986:                     LOCATE FOR ALLTRIM(cods) = ALLTRIM(cursor_4c_Busca.Cods)
987:                     IF FOUND()
988:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
989:                     ENDIF
990:                 ENDIF
991: 
992:                 loc_oBusca.Release()
993:             ENDIF
994:         CATCH TO loc_oErro
995:             MsgErro(loc_oErro.Message, "FormCla.BtnBuscarClick")
996:         ENDTRY
997: 
998:         IF USED("cursor_4c_Busca")
999:             USE IN cursor_4c_Busca
1000:         ENDIF
1001:     ENDPROC
1002: 
1003:     *--------------------------------------------------------------------------
1004:     * BtnEncerrarClick - Fecha o formulario
1005:     *--------------------------------------------------------------------------
1006:     PROCEDURE BtnEncerrarClick()
1007:         THIS.Release()
1008:     ENDPROC
1009: 
1010:     *--------------------------------------------------------------------------
1011:     * BtnSalvarClick - Valida, mapeia Form->BO e salva (Confirmar)
1012:     *--------------------------------------------------------------------------
1013:     PROCEDURE BtnSalvarClick()
1014:         LOCAL loc_cCodigo, loc_cTipo, loc_nSitua, loc_oPg2
1015:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1016: 
1017:         *-- Validacoes FORA do TRY (podem usar RETURN)
1018:         loc_cCodigo = ""
1019:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1020:             loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1021:         ENDIF
1022:         IF THIS.this_cModoAtual = "INCLUIR" AND EMPTY(loc_cCodigo)
1023:             MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o informado!", ;
1024:                      "Aten" + CHR(231) + CHR(227) + "o")
1025:             IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1026:                 loc_oPg2.txt_4c_Codigo.SetFocus
1027:             ENDIF
1028:             RETURN
1029:         ENDIF
1030: 
1031:         loc_cTipo = ""
1032:         IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
1033:             loc_cTipo = ALLTRIM(UPPER(loc_oPg2.txt_4c_Tipos.Value))
1034:         ENDIF
1035:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND EMPTY(loc_cTipo)
1036:             MsgAviso("Tipo inv" + CHR(225) + "lido! Informe: O=Ouro, P=Prata, R=Rel" + ;
1037:                      CHR(243) + "gio, J=Jolie", "Aten" + CHR(231) + CHR(227) + "o")
1038:             IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
1039:                 loc_oPg2.txt_4c_Tipos.SetFocus
1040:             ENDIF
1041:             RETURN
1042:         ENDIF
1043: 
1044:         loc_nSitua = 0
1045:         IF PEMSTATUS(loc_oPg2, "obj_4c_OptSituas", 5)
1046:             loc_nSitua = loc_oPg2.obj_4c_OptSituas.Value
1047:         ENDIF
1048:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND loc_nSitua = 0
1049:             MsgAviso("Situa" + CHR(231) + CHR(227) + "o de uso em produtos inv" + CHR(225) + "lida!", ;
1050:                      "Aten" + CHR(231) + CHR(227) + "o")
1051:             RETURN
1052:         ENDIF
1053: 
1054:         TRY
1055:             THIS.FormParaBO()
1056: 
1057:             IF THIS.this_oBusinessObject.Salvar()
1058:                 *-- Salvar grupos associados (SigCdCla) a partir do cursor do grid
1059:                 THIS.this_oBusinessObject.SalvarGrupos( ;
1060:                     THIS.this_oBusinessObject.this_cCodigo, "crGrdCdCom")
1061: 
1062:                 MsgInfo("Registro salvo com sucesso!", "Sucesso")
1063:                 THIS.AlternarPagina(1)
1064:             ENDIF
1065:         CATCH TO loc_oErro
1066:             MsgErro(loc_oErro.Message, "FormCla.BtnSalvarClick")
1067:         ENDTRY
1068:     ENDPROC
1069: 
1070:     *--------------------------------------------------------------------------
1071:     * BtnCancelarClick - Cancela edicao e volta para lista
1072:     *--------------------------------------------------------------------------
1073:     PROCEDURE BtnCancelarClick()
1074:         THIS.this_cModoAtual = "LISTA"
1075:         THIS.AlternarPagina(1)
1076:         THIS.CarregarLista()
1077:     ENDPROC
1078: 
1079:     *--------------------------------------------------------------------------
1080:     * ValidarTipos - Valida conteudo do campo Tipo (O/P/R/J)
1081:     *--------------------------------------------------------------------------
1082:     PROCEDURE ValidarTipos(par_nKeyCode, par_nShiftAltCtrl)
1083:         LOCAL loc_cTipo
1084:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Tipos", 5)
1085:             loc_cTipo = ALLTRIM(UPPER(THIS.pgf_4c_Paginas.Page2.txt_4c_Tipos.Value))
1086:             IF !EMPTY(loc_cTipo) AND !INLIST(loc_cTipo, "O", "P", "R", "J")
1087:                 MsgAviso("Favor informar os Tipos (O=Ouro, P=Prata, R=Rel" + CHR(243) + ;
1088:                          "gio, J=Jolie)", "Aten" + CHR(231) + CHR(227) + "o")
1089:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Tipos.SetFocus
1090:             ENDIF
1091:         ENDIF
1092:     ENDPROC
1093: 
1094:     *--------------------------------------------------------------------------
1095:     * FormParaBO - Transfere valores do Form para as propriedades do BO
1096:     *--------------------------------------------------------------------------
1097:     PROTECTED PROCEDURE FormParaBO()
1098:         LOCAL loc_oPg2
1099:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1100: 
1101:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1102:             THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1103:         ENDIF
1104:         IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
1105:             THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
1106:         ENDIF
1107:         IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
1108:             THIS.this_oBusinessObject.this_cTipo      = ALLTRIM(UPPER(loc_oPg2.txt_4c_Tipos.Value))
1109:         ENDIF
1110:         IF PEMSTATUS(loc_oPg2, "obj_4c_OptSituas", 5)
1111:             THIS.this_oBusinessObject.this_nSitua     = loc_oPg2.obj_4c_OptSituas.Value
1112:         ENDIF
1113:     ENDPROC
1114: 
1115:     *--------------------------------------------------------------------------
1116:     * BOParaForm - Transfere propriedades do BO para os controles do Form
1117:     *--------------------------------------------------------------------------
1118:     PROTECTED PROCEDURE BOParaForm()
1119:         LOCAL loc_oPg2, loc_nSitua
1120:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1121: 
1122:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1123:             loc_oPg2.txt_4c_Codigo.Value    = THIS.this_oBusinessObject.this_cCodigo
1124:         ENDIF
1125:         IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
1126:             loc_oPg2.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cDescricao
1127:         ENDIF
1128:         IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
1129:             loc_oPg2.txt_4c_Tipos.Value     = THIS.this_oBusinessObject.this_cTipo
1130:         ENDIF
1131:         IF PEMSTATUS(loc_oPg2, "obj_4c_OptSituas", 5)
1132:             loc_nSitua = THIS.this_oBusinessObject.this_nSitua
1133:             loc_oPg2.obj_4c_OptSituas.Value = IIF(loc_nSitua = 0, 1, loc_nSitua)
1134:         ENDIF
1135: 
1136:         *-- Carregar grupos no grid (Phase 6: grd_4c_Dados)
1137:         IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5) AND ;
1138:                 !EMPTY(THIS.this_oBusinessObject.this_cCodigo)
1139:             THIS.CarregarGruposGrid()
1140:         ENDIF
1141:     ENDPROC
1142: 
1143:     *--------------------------------------------------------------------------
1144:     * HabilitarCampos - Habilita/desabilita controles conforme modo de edicao
1145:     *--------------------------------------------------------------------------
1146:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1147:         LOCAL loc_oPg2, loc_lHabilitar
1148:         loc_lHabilitar = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)
1149:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1150: 
1151:         *-- Codigo: editavel apenas em INCLUIR
1152:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1153:             loc_oPg2.txt_4c_Codigo.Enabled    = (loc_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
1154:         ENDIF
1155:         IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
1156:             loc_oPg2.txt_4c_Descricao.Enabled = loc_lHabilitar
1157:         ENDIF
1158:         IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
1159:             loc_oPg2.txt_4c_Tipos.Enabled     = loc_lHabilitar
1160:         ENDIF
1161:         IF PEMSTATUS(loc_oPg2, "obj_4c_OptSituas", 5)
1162:             loc_oPg2.obj_4c_OptSituas.Enabled = loc_lHabilitar
1163:         ENDIF
1164:         *-- Controles da Phase 6
1165:         IF PEMSTATUS(loc_oPg2, "txt_4c_GdeGrps", 5)
1166:             loc_oPg2.txt_4c_GdeGrps.Enabled   = loc_lHabilitar
1167:         ENDIF
1168:         IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
1169:             loc_oPg2.grd_4c_Dados.Enabled     = loc_lHabilitar
1170:         ENDIF
1171:         IF PEMSTATUS(loc_oPg2, "cmd_4c_BtnCarregar", 5)
1172:             loc_oPg2.cmd_4c_BtnCarregar.Enabled = loc_lHabilitar
1173:         ENDIF
1174:         IF PEMSTATUS(loc_oPg2, "cmd_4c_CmdExcluir", 5)
1175:             loc_oPg2.cmd_4c_CmdExcluir.Enabled  = loc_lHabilitar
1176:         ENDIF
1177:         *-- Botao Confirmar
1178:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
1179:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1180:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHabilitar
1181:             ENDIF
1182:         ENDIF
1183:     ENDPROC
1184: 
1185:     *--------------------------------------------------------------------------
1186:     * LimparCampos - Limpa todos os controles do formulario de dados
1187:     *--------------------------------------------------------------------------
1188:     PROTECTED PROCEDURE LimparCampos()
1189:         LOCAL loc_oPg2
1190:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1191: 
1192:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1193:             loc_oPg2.txt_4c_Codigo.Value    = ""
1194:         ENDIF
1195:         IF PEMSTATUS(loc_oPg2, "txt_4c_Descricao", 5)
1196:             loc_oPg2.txt_4c_Descricao.Value = ""
1197:         ENDIF
1198:         IF PEMSTATUS(loc_oPg2, "txt_4c_Tipos", 5)
1199:             loc_oPg2.txt_4c_Tipos.Value     = ""
1200:         ENDIF
1201:         IF PEMSTATUS(loc_oPg2, "obj_4c_OptSituas", 5)
1202:             loc_oPg2.obj_4c_OptSituas.Value = 1
1203:         ENDIF
1204:         IF PEMSTATUS(loc_oPg2, "txt_4c_GdeGrps", 5)
1205:             loc_oPg2.txt_4c_GdeGrps.Value   = ""
1206:         ENDIF
1207:         *-- Limpar cursor do grid de grupos
1208:         IF USED("crGrdCdCom")
1209:             ZAP IN crGrdCdCom
1210:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1211:                 APPEND BLANK IN crGrdCdCom
1212:                 GO TOP IN crGrdCdCom
1213:             ENDIF
1214:         ENDIF
1215:         IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
1216:             loc_oPg2.grd_4c_Dados.Refresh()
1217:         ENDIF
1218:     ENDPROC
1219: 
1220:     *--------------------------------------------------------------------------
1221:     * CarregarGruposGrid - Popula crGrdCdCom com grupos do registro carregado
1222:     *--------------------------------------------------------------------------
1223:     PROTECTED PROCEDURE CarregarGruposGrid()
1224:         LOCAL loc_oPg2
1225:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1226: 
1227:         TRY
1228:             IF USED("crGrdCdCom")
1229:                 ZAP IN crGrdCdCom
1230:             ENDIF
1231: 
1232:             IF THIS.this_oBusinessObject.BuscarGrupos(THIS.this_oBusinessObject.this_cCodigo)
1233:                 IF USED("cursor_4c_Grupos") AND RECCOUNT("cursor_4c_Grupos") > 0
1234:                     GO TOP IN cursor_4c_Grupos
1235:                     SELECT cursor_4c_Grupos
1236:                     SCAN
1237:                         INSERT INTO crGrdCdCom (CGrus, DGrus) ;
1238:                             VALUES (cursor_4c_Grupos.CGrus, cursor_4c_Grupos.DGrus)
1239:                     ENDSCAN
1240:                 ENDIF
1241:                 IF USED("cursor_4c_Grupos")
1242:                     USE IN cursor_4c_Grupos
1243:                 ENDIF
1244:             ENDIF
1245: 
1246:             *-- Linha em branco para inclusao de novo grupo em modo edicao
1247:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1248:                 IF USED("crGrdCdCom") AND (RECCOUNT("crGrdCdCom") = 0 OR EOF("crGrdCdCom"))
1249:                     APPEND BLANK IN crGrdCdCom
1250:                 ENDIF
1251:             ENDIF
1252: 
1253:             IF USED("crGrdCdCom")
1254:                 GO TOP IN crGrdCdCom
1255:             ENDIF
1256: 
1257:             IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
1258:                 loc_oPg2.grd_4c_Dados.Refresh()
1259:             ENDIF
1260: 
1261:         CATCH TO loc_oErro
1262:             MsgErro(loc_oErro.Message, "FormCla.CarregarGruposGrid")
1263:         ENDTRY
1264:     ENDPROC
1265: 
1266:     *--------------------------------------------------------------------------
1267:     * GdeGrpsKeyPress - Abre lookup ao pressionar F4 no campo Grande Grupo
1268:     *--------------------------------------------------------------------------
1269:     PROCEDURE GdeGrpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1270:         IF par_nKeyCode = 28  && F4
1271:             THIS.AbrirLookupGdeGrps()
1272:         ENDIF
1273:     ENDPROC
1274: 
1275:     *--------------------------------------------------------------------------
1276:     * GdeGrpsDblClick - Abre lookup ao dar DblClick no campo Grande Grupo
1277:     *--------------------------------------------------------------------------
1278:     PROCEDURE GdeGrpsDblClick()
1279:         THIS.AbrirLookupGdeGrps()
1280:     ENDPROC
1281: 
1282:     *--------------------------------------------------------------------------
1283:     * AbrirLookupGdeGrps - FormBuscaAuxiliar para SigCdGpr (Grande Grupo)
1284:     * SigCdGpr: Codigos (pk), Descs (desc)
1285:     *--------------------------------------------------------------------------
1286:     PROCEDURE AbrirLookupGdeGrps()
1287:         LOCAL loc_oPg2, loc_oBusca, loc_cCodigo
1288:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1289: 
1290:         IF !PEMSTATUS(loc_oPg2, "txt_4c_GdeGrps", 5) OR !loc_oPg2.txt_4c_GdeGrps.Enabled
1291:             RETURN
1292:         ENDIF
1293: 
1294:         TRY
1295:             loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_GdeGrps.Value)
1296: 
1297:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1298:                 "SigCdGpr", "cursor_4c_BuscaGdeGrp", "Codigos", loc_cCodigo, ;
1299:                 "Grande Grupo")
1300: 
1301:             IF VARTYPE(loc_oBusca) = "O"
1302:                 IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
1303:                     IF USED("cursor_4c_BuscaGdeGrp")
1304:                         loc_oPg2.txt_4c_GdeGrps.Value = ALLTRIM(cursor_4c_BuscaGdeGrp.Codigos)
1305:                     ENDIF
1306:                 ELSE
1307:                     IF !loc_oBusca.this_lAchouRegistro
1308:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1309:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1310:                     loc_oBusca.Show()
1311:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGdeGrp")
1312:                         loc_oPg2.txt_4c_GdeGrps.Value = ALLTRIM(cursor_4c_BuscaGdeGrp.Codigos)
1313:                     ENDIF
1314:                     ENDIF
1315:                 ENDIF
1316:                 loc_oBusca.Release()
1317:             ENDIF
1318:         CATCH TO loc_oErro
1319:             MsgErro(loc_oErro.Message, "FormCla.AbrirLookupGdeGrps")
1320:         ENDTRY
1321: 
1322:         IF USED("cursor_4c_BuscaGdeGrp")
1323:             USE IN cursor_4c_BuscaGdeGrp
1324:         ENDIF
1325:     ENDPROC
1326: 
1327:     *--------------------------------------------------------------------------
1328:     * GridGruposAfterRowColChange - Valida coluna do grid de grupos ao navegar
1329:     *--------------------------------------------------------------------------
1330:     PROCEDURE GridGruposAfterRowColChange(par_nColIndex)
1331:         IF par_nColIndex = 1
1332:             THIS.ValidarCGrusGrid()
1333:         ELSE
1334:             IF par_nColIndex = 2
1335:             THIS.ValidarDGrusGrid()
1336:             ENDIF
1337:         ENDIF
1338:     ENDPROC
1339: 
1340:     *--------------------------------------------------------------------------
1341:     * ValidarCGrusGrid - Ao sair de Column1 (CGrus): valida e preenche DGrus
1342:     * SigCdGrp: CGrus (pk), DGrus (desc)
1343:     *--------------------------------------------------------------------------
1344:     PROTECTED PROCEDURE ValidarCGrusGrid()
1345:         LOCAL loc_oBusca, loc_cCGrus, loc_cDGrus
1346: 
1347:         IF !USED("crGrdCdCom") OR EOF("crGrdCdCom")
1348:             RETURN
1349:         ENDIF
1350: 
1351:         SELECT crGrdCdCom
1352:         loc_cCGrus = ALLTRIM(crGrdCdCom.CGrus)
1353: 
1354:         IF EMPTY(loc_cCGrus)
1355:             REPLACE DGrus WITH "" IN crGrdCdCom
1356:             RETURN
1357:         ENDIF
1358: 
1359:         TRY
1360:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1361:                 "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cCGrus, ;
1362:                 "Selecionar Grupo")
1363: 
1364:             IF VARTYPE(loc_oBusca) = "O"
1365:                 IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
1366:                     IF USED("cursor_4c_BuscaGrp")
1367:                         loc_cCGrus = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1368:                         loc_cDGrus = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
1369:                         SELECT crGrdCdCom
1370:                         REPLACE CGrus WITH loc_cCGrus, DGrus WITH loc_cDGrus IN crGrdCdCom
1371:                     ENDIF
1372:                 ELSE
1373:                     IF !loc_oBusca.this_lAchouRegistro
1374:                     loc_oBusca.mAddColuna("CGrus", "", "Grupo")
1375:                     loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1376:                     loc_oBusca.Show()
1377:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1378:                         loc_cCGrus = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1379:                         loc_cDGrus = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
1380:                         SELECT crGrdCdCom
1381:                         REPLACE CGrus WITH loc_cCGrus, DGrus WITH loc_cDGrus IN crGrdCdCom
1382:                     ELSE
1383:                         SELECT crGrdCdCom
1384:                         REPLACE DGrus WITH "" IN crGrdCdCom
1385:                     ENDIF
1386:                     ENDIF
1387:                 ENDIF
1388:                 loc_oBusca.Release()
1389:             ENDIF
1390:         CATCH TO loc_oErro
1391:             MsgErro(loc_oErro.Message, "FormCla.ValidarCGrusGrid")
1392:         ENDTRY
1393: 
1394:         IF USED("cursor_4c_BuscaGrp")
1395:             USE IN cursor_4c_BuscaGrp
1396:         ENDIF
1397: 
1398:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Dados", 5)
1399:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1400:         ENDIF
1401:     ENDPROC
1402: 
1403:     *--------------------------------------------------------------------------
1404:     * ValidarDGrusGrid - Ao sair de Column2 (DGrus): valida e preenche CGrus
1405:     * SigCdGrp: CGrus (pk), DGrus (desc)
1406:     *--------------------------------------------------------------------------
1407:     PROTECTED PROCEDURE ValidarDGrusGrid()
1408:         LOCAL loc_oBusca, loc_cCGrus, loc_cDGrus
1409: 
1410:         IF !USED("crGrdCdCom") OR EOF("crGrdCdCom")
1411:             RETURN
1412:         ENDIF
1413: 
1414:         SELECT crGrdCdCom
1415:         loc_cDGrus = ALLTRIM(crGrdCdCom.DGrus)
1416: 
1417:         IF EMPTY(crGrdCdCom.CGrus) AND EMPTY(loc_cDGrus)
1418:             RETURN
1419:         ENDIF
1420: 
1421:         IF EMPTY(loc_cDGrus)
1422:             REPLACE CGrus WITH "" IN crGrdCdCom
1423:             RETURN
1424:         ENDIF
1425: 
1426:         TRY
1427:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1428:                 "SigCdGrp", "cursor_4c_BuscaGrp", "DGrus", loc_cDGrus, ;
1429:                 "Selecionar Grupo")
1430: 
1431:             IF VARTYPE(loc_oBusca) = "O"
1432:                 IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
1433:                     IF USED("cursor_4c_BuscaGrp")
1434:                         loc_cCGrus = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1435:                         loc_cDGrus = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
1436:                         SELECT crGrdCdCom
1437:                         REPLACE CGrus WITH loc_cCGrus, DGrus WITH loc_cDGrus IN crGrdCdCom
1438:                     ENDIF
1439:                 ELSE
1440:                     IF !loc_oBusca.this_lAchouRegistro
1441:                     loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1442:                     loc_oBusca.mAddColuna("CGrus", "", "Grupo")
1443:                     loc_oBusca.Show()
1444:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1445:                         loc_cCGrus = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1446:                         loc_cDGrus = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
1447:                         SELECT crGrdCdCom
1448:                         REPLACE CGrus WITH loc_cCGrus, DGrus WITH loc_cDGrus IN crGrdCdCom
1449:                     ELSE
1450:                         SELECT crGrdCdCom
1451:                         REPLACE CGrus WITH "" IN crGrdCdCom
1452:                     ENDIF
1453:                     ENDIF
1454:                 ENDIF
1455:                 loc_oBusca.Release()
1456:             ENDIF
1457:         CATCH TO loc_oErro
1458:             MsgErro(loc_oErro.Message, "FormCla.ValidarDGrusGrid")
1459:         ENDTRY
1460: 
1461:         IF USED("cursor_4c_BuscaGrp")
1462:             USE IN cursor_4c_BuscaGrp
1463:         ENDIF
1464: 
1465:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Dados", 5)
1466:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1467:         ENDIF
1468:     ENDPROC
1469: 
1470:     *--------------------------------------------------------------------------
1471:     * BtnCarregarClick - Carrega grupos de SigCdGrp filtrados pelo Grande Grupo
1472:     * Equivale ao btnCarregar.Click original: SELECT CGrus,DGrus FROM SigCdGrp
1473:     * WHERE Mercs = lcGde, inserindo apenas grupos nao existentes em crGrdCdCom
1474:     *--------------------------------------------------------------------------
1475:     PROCEDURE BtnCarregarClick()
1476:         LOCAL loc_oPg2, loc_cGde, loc_cSQL, loc_nResult
1477:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1478: 
1479:         IF !PEMSTATUS(loc_oPg2, "txt_4c_GdeGrps", 5)
1480:             RETURN
1481:         ENDIF
1482: 
1483:         loc_cGde = ALLTRIM(loc_oPg2.txt_4c_GdeGrps.Value)
1484: 
1485:         IF EMPTY(loc_cGde)
1486:             MsgAviso("Preencha o Grande Grupo antes de processar!", ;
1487:                      "Aten" + CHR(231) + CHR(227) + "o")
1488:             loc_oPg2.txt_4c_GdeGrps.SetFocus
1489:             RETURN
1490:         ENDIF
1491: 
1492:         TRY
1493:             loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp WHERE Mercs = " + ;
1494:                        EscaparSQL(loc_cGde)
1495:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalGru")
1496: 
1497:             IF loc_nResult < 1
1498:                 MsgErro("Falha ao consultar grupos: " + CapturarErroSQL(), "Erro SQL")
1499:             ELSE
1500:                 GO TOP IN cursor_4c_LocalGru
1501: 
1502:                 IF !EOF("cursor_4c_LocalGru")
1503:                     DELETE FROM crGrdCdCom WHERE EMPTY(CGrus)
1504:                 ENDIF
1505: 
1506:                 SELECT cursor_4c_LocalGru
1507:                 SCAN
1508:                     SELECT crGrdCdCom
1509:                     GO TOP IN crGrdCdCom
1510:                     LOCATE FOR CGrus = cursor_4c_LocalGru.CGrus
1511:                     IF EOF("crGrdCdCom")
1512:                         INSERT INTO crGrdCdCom (CGrus, DGrus) ;
1513:                             VALUES (cursor_4c_LocalGru.CGrus, cursor_4c_LocalGru.DGrus)
1514:                     ENDIF
1515:                 ENDSCAN
1516: 
1517:                 GO TOP IN cursor_4c_LocalGru
1518:                 IF !EOF("cursor_4c_LocalGru")
1519:                     APPEND BLANK IN crGrdCdCom
1520:                 ENDIF
1521: 
1522:                 USE IN cursor_4c_LocalGru
1523:                 GO BOTTOM IN crGrdCdCom
1524: 
1525:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
1526:                     loc_oPg2.grd_4c_Dados.Refresh()

*-- Linhas 1538 a 1562:
1538:     *--------------------------------------------------------------------------
1539:     * CmdExcluirClick - Exclui a linha corrente do grid de grupos (crGrdCdCom)
1540:     *--------------------------------------------------------------------------
1541:     PROCEDURE CmdExcluirClick()
1542:         LOCAL loc_oPg2
1543:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1544: 
1545:         IF !USED("crGrdCdCom") OR EOF("crGrdCdCom")
1546:             RETURN
1547:         ENDIF
1548: 
1549:         TRY
1550:             SELECT crGrdCdCom
1551:             DELETE IN crGrdCdCom
1552: 
1553:             IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
1554:                 loc_oPg2.grd_4c_Dados.Refresh()
1555:                 THIS.Refresh()
1556:             ENDIF
1557:         CATCH TO loc_oErro
1558:             MsgErro(loc_oErro.Message, "FormCla.CmdExcluirClick")
1559:         ENDTRY
1560:     ENDPROC
1561: 
1562: ENDDEFINE


### BO (C:\4c\projeto\app\classes\ClaBO.prg):
*------------------------------------------------------------------------------
* ClaBO.prg - Business Object para Classificacao de Produtos
* Tabela principal: SigCdCls
* Tabela detalhe:   SigCdCla (grupos associados)
*------------------------------------------------------------------------------

DEFINE CLASS ClaBO AS BusinessBase

    *-- Propriedades da entidade SigCdCls
    this_cCodigo    = ""   && SigCdCls.Cods     (PK char(3))
    this_cDescricao = ""   && SigCdCls.Descs    (char(40))
    this_cTipo      = ""   && SigCdCls.Tipos    (char(1): O=Ouro, P=Prata, R=Rel+CHR(243)+gio, J=Jolie)
    this_nSitua     = 0    && SigCdCls.Situas   (numeric(1,0): 1=Ativos, 2=Inativos, 3=Ambos)

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCls"
        THIS.this_cCampoChave = "Cods"
        RETURN .T.
    ENDPROC

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SigCdCls filtrados opcionalmente
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            IF EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT Cods, Descs, Tipos, Situas" + ;
                           " FROM SigCdCls" + ;
                           " ORDER BY Cods"
            ELSE
                loc_cSQL = "SELECT Cods, Descs, Tipos, Situas" + ;
                           " FROM SigCdCls" + ;
                           " WHERE Cods LIKE " + EscaparSQL("%" + par_cFiltro + "%") + ;
                           " ORDER BY Cods"
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.Buscar: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCodigo))
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "SELECT Cods, Descs, Tipos, Situas" + ;
                           " FROM SigCdCls" + ;
                           " WHERE Cods = " + EscaparSQL(par_cCodigo)

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                        loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                        THIS.this_lNovoRegistro = .F.
                    ELSE
                        loc_lResultado = .F.
                    ENDIF

                    IF USED("cursor_4c_Carrega")
                        USE IN cursor_4c_Carrega
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = ALLTRIM(NVL(Cods,  ""))
                THIS.this_cDescricao = ALLTRIM(NVL(Descs, ""))
                THIS.this_cTipo      = ALLTRIM(NVL(Tipos, ""))
                THIS.this_nSitua     = NVL(Situas, 0)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.CarregarDoCursor: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdCls (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCodigo))
                MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o informado!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "INSERT INTO SigCdCls (Cods, Descs, Tipos, Situas)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCodigo)    + "," + ;
                           EscaparSQL(THIS.this_cDescricao) + "," + ;
                           EscaparSQL(THIS.this_cTipo)      + "," + ;
                           FormatarNumeroSQL(THIS.this_nSitua) + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MsgErro("Erro ao inserir classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.Inserir: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdCls (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCls SET" + ;
                       "  Descs  = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       "  Tipos  = " + EscaparSQL(THIS.this_cTipo)      + "," + ;
                       "  Situas = " + FormatarNumeroSQL(THIS.this_nSitua) + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.Atualizar: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdCla e SigCdCls (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            *-- Excluir registros de detalhe (SigCdCla)
            loc_cSQL = "DELETE FROM SigCdCla WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir grupos da classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Excluir registro principal (SigCdCls)
                loc_cSQL = "DELETE FROM SigCdCls WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MsgErro("Erro ao excluir classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.ExecutarExclusao: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Carrega grupos associados (SigCdCla + SigCdGrp) para o grid
    *--------------------------------------------------------------------------
    FUNCTION BuscarGrupos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.CGrus, b.DGrus" + ;
                       " FROM SigCdCla a" + ;
                       " LEFT JOIN SigCdGrp b ON b.CGrus = a.CGrus" + ;
                       " WHERE a.Cods = " + EscaparSQL(par_cCodigo) + ;
                       " ORDER BY a.CGrus"

            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grupos")

            IF loc_nResultado < 0
                MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Grupos")
                    GO TOP IN cursor_4c_Grupos
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.BuscarGrupos: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarGrupos - Salva grupos associados em SigCdCla (DELETE + INSERT)
    *   par_cCodigo       = codigo da classificacao (SigCdCls.Cods)
    *   par_cCursorGrupos = alias do cursor local com CGrus/DGrus
    *--------------------------------------------------------------------------
    FUNCTION SalvarGrupos(par_cCodigo, par_cCursorGrupos)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cCGrus, loc_cCidchaves
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCodigo))
                loc_lResultado = .F.
            ELSE
                *-- Remover grupos antigos
                loc_cSQL = "DELETE FROM SigCdCla WHERE Cods = " + EscaparSQL(par_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MsgErro("Erro ao limpar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    loc_lResultado = .T.

                    *-- Inserir grupos do cursor (apenas CGrus nao vazio e distintos)
                    IF USED(par_cCursorGrupos) AND RECCOUNT(par_cCursorGrupos) > 0
                        SELECT DISTINCT CGrus FROM (par_cCursorGrupos) ;
                            WHERE !EMPTY(CGrus) ;
                            ORDER BY CGrus ;
                            INTO CURSOR cursor_4c_GruposGrav

                        IF USED("cursor_4c_GruposGrav") AND RECCOUNT("cursor_4c_GruposGrav") > 0
                            GO TOP IN cursor_4c_GruposGrav
                            SELECT cursor_4c_GruposGrav
                            SCAN
                                loc_cCGrus      = ALLTRIM(cursor_4c_GruposGrav.CGrus)
                                loc_cCidchaves  = LEFT(fUniqueIds(), 20)

                                loc_cSQL = "INSERT INTO SigCdCla (CGrus, CIdChaves, Cods)" + ;
                                           " VALUES (" + ;
                                           EscaparSQL(loc_cCGrus)     + "," + ;
                                           EscaparSQL(loc_cCidchaves) + "," + ;
                                           EscaparSQL(par_cCodigo)    + ;
                                           ")"

                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                                IF loc_nResultado < 0
                                    MsgErro("Erro ao inserir grupo " + loc_cCGrus + ":" + CHR(13) + ;
                                            CapturarErroSQL(), "Erro SQL")
                                    loc_lResultado = .F.
                                    EXIT
                                ENDIF
                            ENDSCAN
                        ENDIF

                        IF USED("cursor_4c_GruposGrav")
                            USE IN cursor_4c_GruposGrav
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.SalvarGrupos: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

