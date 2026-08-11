# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.GravarDados()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDrs.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2061 linhas total):

*-- Linhas 36 a 166:
36:     *===========================================================================
37:     * Init - Recebe par_cTits antes de delegar ao FormBase
38:     *===========================================================================
39:     PROCEDURE Init(par_cTits)
40:         IF VARTYPE(par_cTits) = "C"
41:             THIS.this_cTits = PADR(ALLTRIM(par_cTits), 20)
42:         ENDIF
43:         RETURN DODEFAULT()
44:     ENDPROC
45: 
46:     *===========================================================================
47:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
48:     *===========================================================================
49:     PROTECTED PROCEDURE InicializarForm()
50:         LOCAL loc_lSucesso
51:         loc_lSucesso = .F.
52: 
53:         TRY
54:             THIS.this_oBusinessObject = CREATEOBJECT("DrsBO")
55: 
56:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
57:                 MostrarErro("Erro ao criar DrsBO" + CHR(13) + ;
58:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
59:                     "FormDrs.InicializarForm")
60:             ELSE
61:                 THIS.this_oBusinessObject.this_cTits = THIS.this_cTits
62: 
63:                 IF !THIS.this_oBusinessObject.CarregarSigSyCit()
64:                     MostrarErro("Erro ao carregar SigSyCit para Tits=" + ;
65:                         ALLTRIM(THIS.this_cTits), "FormDrs.InicializarForm")
66:                 ELSE
67:                     THIS.this_oBusinessObject.InicializarCursores()
68: 
69:                     THIS.ConfigurarPageFrame()
70:                     THIS.Caption = "Ficha T" + CHR(233) + "cnica - " + ALLTRIM(THIS.this_cTits)
71:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
72:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
73:                     THIS.pgf_4c_Paginas.Visible    = .T.
74:                     THIS.pgf_4c_Paginas.ActivePage = 1
75:                     THIS.this_cModoAtual           = "LISTA"
76: 
77:                     IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
78:                         THIS.CarregarLista()
79:                     ENDIF
80: 
81:                     loc_lSucesso = .T.
82:                 ENDIF
83:             ENDIF
84: 
85:         CATCH TO loc_oErro
86:             MostrarErro("Erro ao inicializar FormDrs:" + CHR(13) + ;
87:                 loc_oErro.Message + CHR(13) + ;
88:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
89:                 "FormDrs.InicializarForm")
90:         ENDTRY
91: 
92:         RETURN loc_lSucesso
93:     ENDPROC
94: 
95:     *===========================================================================
96:     * ConfigurarPageFrame - PageFrame com 2 paginas (Top=-29, Tabs=.F.)
97:     *===========================================================================
98:     PROTECTED PROCEDURE ConfigurarPageFrame()
99:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
100: 
101:         WITH THIS.pgf_4c_Paginas
102:             .PageCount = 2
103:             .Top       = -29
104:             .Left      = 0
105:             .Width     = THIS.Width
106:             .Height    = THIS.Height + 29
107:             .Tabs      = .F.
108:             .Visible   = .T.
109: 
110:             .Page1.Caption   = "Lista"
111:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:             .Page1.BackColor = RGB(255, 255, 255)
113: 
114:             .Page2.Caption   = "Dados"
115:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
116:             .Page2.BackColor = RGB(255, 255, 255)
117:         ENDWITH
118: 
119:         THIS.ConfigurarPaginaLista()
120:         THIS.ConfigurarPaginaDados()
121:     ENDPROC
122: 
123:     *===========================================================================
124:     * ConfigurarPaginaLista - Page1: cabecalho + CRUD + filtro + workflow + grid
125:     *===========================================================================
126:     PROTECTED PROCEDURE ConfigurarPaginaLista()
127:         LOCAL loc_oPagina
128:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
129: 
130:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
131: 
132:         *-- Cabecalho cinza
133:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
134:         WITH loc_oPagina.cnt_4c_Cabecalho
135:             .Top         = 31
136:             .Left        = 0
137:             .Width       = THIS.Width
138:             .Height      = 80
139:             .BackColor   = RGB(100, 100, 100)
140:             .BorderWidth = 0
141:             .Visible     = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
146:             .Caption   = THIS.Caption
147:             .Top       = 15
148:             .Left      = 10
149:             .Width     = 750
150:             .Height    = 40
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.
154:             .ForeColor = RGB(0, 0, 0)
155:             .BackStyle = 0
156:             .AutoSize  = .F.
157:             .Visible   = .T.
158:         ENDWITH
159: 
160:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
161:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
162:             .Caption   = THIS.Caption
163:             .Top       = 18
164:             .Left      = 10
165:             .Width     = 750
166:             .Height    = 46

*-- Linhas 208 a 695:
208:             .AutoSize        = .F.
209:             .Visible         = .T.
210:         ENDWITH
211:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
212: 
213:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
214:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
215:             .Caption         = "Visualizar"
216:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
217:             .PicturePosition = 13
218:             .Top             = 5
219:             .Left            = 80
220:             .Width           = 75
221:             .Height          = 75
222:             .FontName        = "Tahoma"
223:             .FontBold        = .T.
224:             .FontItalic      = .T.
225:             .FontSize        = 8
226:             .ForeColor       = RGB(90, 90, 90)
227:             .BackColor       = RGB(255, 255, 255)
228:             .Themes          = .F.
229:             .SpecialEffect   = 0
230:             .MousePointer    = 15
231:             .WordWrap        = .T.
232:             .AutoSize        = .F.
233:             .Visible         = .T.
234:         ENDWITH
235:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
236: 
237:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
238:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
239:             .Caption         = "Alterar"
240:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
241:             .PicturePosition = 13
242:             .Top             = 5
243:             .Left            = 155
244:             .Width           = 75
245:             .Height          = 75
246:             .FontName        = "Tahoma"
247:             .FontBold        = .T.
248:             .FontItalic      = .T.
249:             .FontSize        = 8
250:             .ForeColor       = RGB(90, 90, 90)
251:             .BackColor       = RGB(255, 255, 255)
252:             .Themes          = .F.
253:             .SpecialEffect   = 0
254:             .MousePointer    = 15
255:             .WordWrap        = .T.
256:             .AutoSize        = .F.
257:             .Visible         = .T.
258:         ENDWITH
259:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
260: 
261:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
262:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
263:             .Caption         = "Excluir"
264:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
265:             .PicturePosition = 13
266:             .Top             = 5
267:             .Left            = 230
268:             .Width           = 75
269:             .Height          = 75
270:             .FontName        = "Tahoma"
271:             .FontBold        = .T.
272:             .FontItalic      = .T.
273:             .FontSize        = 8
274:             .ForeColor       = RGB(90, 90, 90)
275:             .BackColor       = RGB(255, 255, 255)
276:             .Themes          = .F.
277:             .SpecialEffect   = 0
278:             .MousePointer    = 15
279:             .WordWrap        = .T.
280:             .AutoSize        = .F.
281:             .Visible         = .T.
282:         ENDWITH
283:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
284: 
285:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
286:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
287:             .Caption         = "Buscar"
288:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
289:             .PicturePosition = 13
290:             .Top             = 5
291:             .Left            = 305
292:             .Width           = 75
293:             .Height          = 75
294:             .FontName        = "Tahoma"
295:             .FontBold        = .T.
296:             .FontItalic      = .T.
297:             .FontSize        = 8
298:             .ForeColor       = RGB(90, 90, 90)
299:             .BackColor       = RGB(255, 255, 255)
300:             .Themes          = .F.
301:             .SpecialEffect   = 0
302:             .MousePointer    = 15
303:             .WordWrap        = .T.
304:             .AutoSize        = .F.
305:             .Visible         = .T.
306:         ENDWITH
307:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
308: 
309:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
310:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
311:         WITH loc_oPagina.cnt_4c_Saida
312:             .Top         = 29
313:             .Left        = 917
314:             .Width       = 90
315:             .Height      = 85
316:             .BackStyle   = 0
317:             .BorderWidth = 0
318:             .Visible     = .T.
319:         ENDWITH
320: 
321:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
322:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
323:             .Caption         = "Encerrar"
324:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
325:             .PicturePosition = 13
326:             .Top             = 5
327:             .Left            = 5
328:             .Width           = 75
329:             .Height          = 75
330:             .FontName        = "Tahoma"
331:             .FontBold        = .T.
332:             .FontItalic      = .T.
333:             .FontSize        = 8
334:             .ForeColor       = RGB(90, 90, 90)
335:             .BackColor       = RGB(255, 255, 255)
336:             .Themes          = .F.
337:             .SpecialEffect   = 0
338:             .MousePointer    = 15
339:             .WordWrap        = .T.
340:             .AutoSize        = .F.
341:             .Visible         = .T.
342:         ENDWITH
343:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
344: 
345:         *-- optFiltro: 3 opcoes (Todas / em aberto / baixadas)
346:         *-- Original: Left=35, Top=87. Compensado: Top=116 (87+29)
347:         loc_oPagina.AddObject("opt_4c_Filtro", "OptionGroup")
348:         WITH loc_oPagina.opt_4c_Filtro
349:             .ButtonCount  = 3
350:             .AutoSize     = .F.
351:             .Height       = 58
352:             .Left         = 35
353:             .Top          = 116
354:             .Width        = 82
355:             .BackStyle    = 0
356:             .BorderStyle  = 0
357:             .Value        = 1
358:             .Visible      = .T.
359: 
360:             WITH .Buttons(1)
361:                 .Caption   = "Todas"
362:                 .Height    = 17
363:                 .Left      = 3
364:                 .Top       = 3
365:                 .Width     = 74
366:                 .ForeColor = RGB(90, 90, 90)
367:                 .AutoSize  = .F.
368:             ENDWITH
369: 
370:             WITH .Buttons(2)
371:                 .Caption   = "Pendentes"
372:                 .Height    = 17
373:                 .Left      = 3
374:                 .Top       = 21
375:                 .Width     = 74
376:                 .FontName  = "Tahoma"
377:                 .FontSize  = 8
378:                 .ForeColor = RGB(90, 90, 90)
379:                 .AutoSize  = .F.
380:             ENDWITH
381: 
382:             WITH .Buttons(3)
383:                 .Caption   = "Baixadas"
384:                 .Height    = 17
385:                 .Left      = 3
386:                 .Top       = 39
387:                 .Width     = 74
388:                 .FontName  = "Tahoma"
389:                 .FontSize  = 8
390:                 .ForeColor = RGB(90, 90, 90)
391:                 .AutoSize  = .F.
392:             ENDWITH
393:         ENDWITH
394:         BINDEVENT(loc_oPagina.opt_4c_Filtro, "InteractiveChange", THIS, "OptFiltroInteractiveChange")
395: 
396:         *-- Botoes de Workflow: Aprovar/Desaprovar e Baixar/Canc Baixa
397:         *-- Original Commandgroup1: Left=115, Top=91. Compensado: Top=120 (91+29)
398:         loc_oPagina.AddObject("cnt_4c_Workflow", "Container")
399:         WITH loc_oPagina.cnt_4c_Workflow
400:             .Top         = 120
401:             .Left        = 122
402:             .Width       = 250
403:             .Height      = 55
404:             .BackStyle   = 0
405:             .BorderWidth = 0
406:             .Visible     = .T.
407:         ENDWITH
408: 
409:         loc_oPagina.cnt_4c_Workflow.AddObject("cmd_4c_Aprovar", "CommandButton")
410:         WITH loc_oPagina.cnt_4c_Workflow.cmd_4c_Aprovar
411:             .Caption         = "Aprovar"
412:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_32.jpg"
413:             .PicturePosition = 1
414:             .Top             = 5
415:             .Left            = 4
416:             .Width           = 115
417:             .Height          = 45
418:             .FontName        = "Tahoma"
419:             .FontBold        = .T.
420:             .FontItalic      = .T.
421:             .FontSize        = 8
422:             .ForeColor       = RGB(90, 90, 90)
423:             .BackColor       = RGB(255, 255, 255)
424:             .Themes          = .T.
425:             .SpecialEffect   = 0
426:             .MousePointer    = 15
427:             .WordWrap        = .T.
428:             .AutoSize        = .F.
429:             .Enabled         = .F.
430:             .Visible         = .T.
431:         ENDWITH
432:         BINDEVENT(loc_oPagina.cnt_4c_Workflow.cmd_4c_Aprovar, "Click", THIS, "BtnAprovarClick")
433: 
434:         loc_oPagina.cnt_4c_Workflow.AddObject("cmd_4c_Baixar", "CommandButton")
435:         WITH loc_oPagina.cnt_4c_Workflow.cmd_4c_Baixar
436:             .Caption         = "Baixar"
437:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
438:             .PicturePosition = 1
439:             .Top             = 5
440:             .Left            = 127
441:             .Width           = 115
442:             .Height          = 45
443:             .FontName        = "Tahoma"
444:             .FontBold        = .T.
445:             .FontItalic      = .T.
446:             .FontSize        = 8
447:             .ForeColor       = RGB(90, 90, 90)
448:             .BackColor       = RGB(255, 255, 255)
449:             .Themes          = .T.
450:             .SpecialEffect   = 0
451:             .MousePointer    = 15
452:             .WordWrap        = .T.
453:             .AutoSize        = .F.
454:             .Enabled         = .F.
455:             .Visible         = .T.
456:         ENDWITH
457:         BINDEVENT(loc_oPagina.cnt_4c_Workflow.cmd_4c_Baixar, "Click", THIS, "BtnBaixarClick")
458: 
459:         *-- Grid de listagem (colunas montadas em MontarColunasGrid apos Buscar)
460:         *-- Original grade: Left=29, Top=142. Compensado Top: 175 (142+29+4)
461:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
462:         loc_oPagina.grd_4c_Lista.ColumnCount = 0
463:         WITH loc_oPagina.grd_4c_Lista
464:             .Top                = 180
465:             .Left               = 29
466:             .Width              = 880
467:             .Height             = 425
468:             .FontName           = "Verdana"
469:             .FontSize           = 8
470:             .ForeColor          = RGB(90, 90, 90)
471:             .BackColor          = RGB(255, 255, 255)
472:             .GridLineColor      = RGB(238, 238, 238)
473:             .HighlightBackColor = RGB(255, 255, 255)
474:             .HighlightForeColor = RGB(15, 41, 104)
475:             .HighlightStyle     = 2
476:             .DeleteMark         = .F.
477:             .RecordMark         = .F.
478:             .RowHeight          = 16
479:             .ScrollBars         = 3
480:             .GridLines          = 3
481:             .Visible            = .T.
482:         ENDWITH
483:         BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GrdAfterRowColChange")
484:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick",          THIS, "BtnVisualizarClick")
485: 
486:         THIS.TornarControlesVisiveis(loc_oPagina)
487:     ENDPROC
488: 
489:     *===========================================================================
490:     * ConfigurarPaginaDados - Page2: botoes acao + codigo + container dinamico
491:     *===========================================================================
492:     PROTECTED PROCEDURE ConfigurarPaginaDados()
493:         LOCAL loc_oPagina
494:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
495: 
496:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
497: 
498:         *-- Botoes Confirmar/Cancelar
499:         *-- Original grupo_salva: Top=9. Compensado: Top=38 (9+29)
500:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
501:         WITH loc_oPagina.cnt_4c_BotoesAcao
502:             .Top         = 38
503:             .Left        = 840
504:             .Width       = 160
505:             .Height      = 85
506:             .BackStyle = 0
507:             .BackColor   = RGB(255, 255, 255)
508:             .BorderWidth = 0
509:             .Visible     = .T.
510:         ENDWITH
511: 
512:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
513:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
514:             .Caption         = "Confirmar"
515:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
516:             .PicturePosition = 13
517:             .Top             = 5
518:             .Left            = 5
519:             .Width           = 75
520:             .Height          = 75
521:             .FontName        = "Tahoma"
522:             .FontBold        = .T.
523:             .FontItalic      = .T.
524:             .FontSize        = 8
525:             .ForeColor       = RGB(90, 90, 90)
526:             .BackColor       = RGB(255, 255, 255)
527:             .Themes          = .F.
528:             .SpecialEffect   = 0
529:             .MousePointer    = 15
530:             .WordWrap        = .T.
531:             .AutoSize        = .F.
532:             .Visible         = .T.
533:         ENDWITH
534:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
535: 
536:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
537:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
538:             .Caption         = "Encerrar"
539:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
540:             .PicturePosition = 13
541:             .Top             = 5
542:             .Left            = 83
543:             .Width           = 75
544:             .Height          = 75
545:             .FontName        = "Tahoma"
546:             .FontBold        = .T.
547:             .FontItalic      = .T.
548:             .FontSize        = 8
549:             .ForeColor       = RGB(90, 90, 90)
550:             .BackColor       = RGB(255, 255, 255)
551:             .Themes          = .F.
552:             .SpecialEffect   = 0
553:             .MousePointer    = 15
554:             .WordWrap        = .T.
555:             .AutoSize        = .F.
556:             .Visible         = .T.
557:         ENDWITH
558:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
559: 
560:         *-- Label e TextBox de Codigo
561:         *-- Original Label1: Left=102, Top=137; getCods: Left=152, Top=134
562:         *-- Compensados: Top Label=166 (137+29), Top getCods=163 (134+29)
563:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
564:         WITH loc_oPagina.lbl_4c_Codigo
565:             .Caption   = "C" + CHR(243) + "digo :"
566:             .Top       = 166
567:             .Left      = 102
568:             .Height    = 16
569:             .FontName  = "Tahoma"
570:             .FontBold  = .T.
571:             .BackStyle = 0
572:             .ForeColor = RGB(90, 90, 90)
573:             .AutoSize  = .T.
574:             .Visible   = .T.
575:         ENDWITH
576: 
577:         loc_oPagina.AddObject("txt_4c_Cods", "TextBox")
578:         WITH loc_oPagina.txt_4c_Cods
579:             .Value             = 0
580:             .Enabled           = .F.
581:             .Left              = 155
582:             .Top               = 163
583:             .Width             = 52
584:             .Height            = 20
585:             .DisabledBackColor = RGB(255, 255, 255)
586:             .FontName          = "Tahoma"
587:             .FontSize          = 8
588:             .Visible           = .T.
589:         ENDWITH
590: 
591:         *-- Container para campos dinamicos de SigSyCit + campos fixos de header
592:         *-- Original Shape1: Top=167, Height=309, Left=65, Width=670 -> compensado Top=196
593:         loc_oPagina.AddObject("cnt_4c_Campos", "Container")
594:         WITH loc_oPagina.cnt_4c_Campos
595:             .Top         = 196
596:             .Left        = 65
597:             .Width       = THIS.Width
598:             .Height      = 420
599:             .BackStyle   = 1
600:             .BackColor   = RGB(255, 255, 255)
601:             .BorderColor = RGB(180, 180, 180)
602:             .BorderWidth = 1
603:             .Visible     = .T.
604:         ENDWITH
605: 
606:         THIS.TornarControlesVisiveis(loc_oPagina)
607:     ENDPROC
608: 
609:     *===========================================================================
610:     * CarregarLista - Busca registros e configura grid dinamico
611:     *===========================================================================
612:     PROCEDURE CarregarLista()
613:         LOCAL loc_cFiltro, loc_oGrd, loc_oPagina
614:         TRY
615:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
616:             loc_oGrd    = loc_oPagina.grd_4c_Lista
617: 
618:             DO CASE
619:                 CASE loc_oPagina.opt_4c_Filtro.Value = 2
620:                     loc_cFiltro = "PENDENTES"
621:                 CASE loc_oPagina.opt_4c_Filtro.Value = 3
622:                     loc_cFiltro = "BAIXADAS"
623:                 OTHERWISE
624:                     loc_cFiltro = "TODAS"
625:             ENDCASE
626: 
627:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
628:                 *-- cursor_4c_Dados: alias padrao do framework de testes
629:                 IF USED("cursor_4c_Dados")
630:                     USE IN cursor_4c_Dados
631:                 ENDIF
632:                 IF USED("crSigSyCrs")
633:                     SELECT * FROM crSigSyCrs INTO CURSOR cursor_4c_Dados NOFILTER READWRITE
634:                     SELECT crSigSyCrs
635:                 ENDIF
636:                 THIS.MontarColunasGrid()
637:                 IF USED("crSigSyCrs")
638:                     loc_oGrd.SetAll("DynamicForeColor", ;
639:                         "Iif(crSigSyCrs.ChkSubn, RGB(0,0,255), Iif(crSigSyCrs.ChkApro, RGB(0,128,0), RGB(0,0,0)))", ;
640:                         "Column")
641:                     loc_oGrd.RecordSource = "crSigSyCrs"
642:                     loc_oGrd.Refresh()
643:                 ENDIF
644:                 THIS.AtualizarBotoesWorkflow()
645:             ENDIF
646:         CATCH TO loc_oErro
647:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
648:                 "FormDrs.CarregarLista")
649:         ENDTRY
650:     ENDPROC
651: 
652:     *===========================================================================
653:     * MontarColunasGrid - Configura colunas do grid baseado em crSigSyCit.Listas=1
654:     *===========================================================================
655:     PROTECTED PROCEDURE MontarColunasGrid()
656:         LOCAL loc_oGrd, loc_nCols, loc_nColIdx, loc_cCampo, loc_nWidth, loc_cHeader
657:         TRY
658:             loc_oGrd  = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
659:             loc_nCols = 1
660: 
661:             IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
662:                 SELECT crSigSyCit
663:                 SCAN
664:                     IF crSigSyCit.Listas = 1
665:                         loc_nCols = loc_nCols + 1
666:                     ENDIF
667:                 ENDSCAN
668:             ENDIF
669: 
670:             loc_oGrd.RecordSource = ""
671:             loc_oGrd.ColumnCount  = loc_nCols
672: 
673:             WITH loc_oGrd.Column1
674:                 .ControlSource       = "crSigSyCrs.Cods"
675:                 .Width               = 60
676:                 .ReadOnly            = .T.
677:                 .Header1.Caption     = "C" + CHR(243) + "digo"
678:                 .Header1.FontName    = "Tahoma"
679:                 .Header1.FontBold    = .T.
680:                 .Header1.FontSize    = 8
681:             ENDWITH
682: 
683:             IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
684:                 loc_nColIdx = 2
685:                 SELECT crSigSyCit
686:                 SCAN
687:                     IF crSigSyCit.Listas = 1
688:                         loc_cCampo  = ALLTRIM(crSigSyCit.Campos)
689:                         loc_cHeader = PROPER(ALLTRIM(crSigSyCit.Descs))
690: 
691:                         DO CASE
692:                             CASE crSigSyCit.Tipos = "D"
693:                                 loc_nWidth = 80
694:                             CASE crSigSyCit.Tipos = "N"
695:                                 loc_nWidth = 100

*-- Linhas 723 a 766:
723:     * MontarObjetos - Popula cnt_4c_Campos com Label+Controle por campo de SigSyCit
724:     * par_cModo: "INSERIR" | "ALTERAR" | "EXCLUIR" | "CONSULTAR"
725:     *===========================================================================
726:     PROCEDURE MontarObjetos(par_cModo)
727:         LOCAL loc_oCnt, loc_nTop, loc_nLef, loc_nWid, loc_nHei
728:         LOCAL loc_cObjName, loc_cLblName, loc_lReadOnly
729:         LOCAL loc_cTipos, loc_cCampo, loc_cDescs, loc_nOrdems, loc_cInputMask
730:         LOCAL loc_nWidCtrl, loc_nIdx, loc_cNome
731:         TRY
732:             THIS.DesmontarObjetos()
733: 
734:             loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos
735:             loc_lReadOnly = INLIST(UPPER(ALLTRIM(par_cModo)), "EXCLUIR", "CONSULTAR")
736:             loc_nTop      = 6
737:             loc_nLef      = 5
738:             loc_nWid      = loc_oCnt.Width - 30
739:             THIS.this_nNroControles = 0
740: 
741:             IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
742:                 SELECT crSigSyCit
743:                 SCAN
744:                     loc_cCampo     = ALLTRIM(crSigSyCit.Campos)
745:                     loc_cDescs     = ALLTRIM(crSigSyCit.Descs)
746:                     loc_cTipos     = ALLTRIM(crSigSyCit.Tipos)
747:                     loc_nOrdems    = crSigSyCit.Ordems
748:                     loc_cInputMask = ALLTRIM(crSigSyCit.Pictures)
749: 
750:                     *-- Label
751:                     loc_cLblName = "lbl_4c_F" + ALLTRIM(STR(loc_nOrdems, 3))
752:                     loc_oCnt.AddObject(loc_cLblName, "Label")
753:                     WITH loc_oCnt.&loc_cLblName.
754:                         .Caption   = PROPER(loc_cDescs)
755:                         .Top       = loc_nTop
756:                         .Left      = loc_nLef + 4
757:                         .FontName  = "Tahoma"
758:                         .FontBold  = .T.
759:                         .FontSize  = 8
760:                         .ForeColor = RGB(0, 0, 128)
761:                         .BackStyle = 0
762:                         .AutoSize  = .T.
763:                         .Visible   = .T.
764:                     ENDWITH
765: 
766:                     loc_nTop = loc_nTop + 14

*-- Linhas 1018 a 1120:
1018:             THIS.this_cModoAtual     = par_cModo
1019:             THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = THIS.this_nCodAtual
1020: 
1021:             THIS.TornarControlesVisiveis(THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos)
1022: 
1023:         CATCH TO loc_oErro
1024:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1025:                 "FormDrs.MontarObjetos")
1026:         ENDTRY
1027:     ENDPROC
1028: 
1029:     *===========================================================================
1030:     * DesmontarObjetos - Remove controles dinamicos de cnt_4c_Campos
1031:     *===========================================================================
1032:     PROCEDURE DesmontarObjetos()
1033:         LOCAL loc_oCnt, loc_cNome, loc_cLbl, loc_nIdx
1034:         LOCAL loc_aFixos[11]
1035:         TRY
1036:             IF THIS.this_lMontouObjetos AND VARTYPE(THIS.pgf_4c_Paginas) = "O"
1037:                 loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos
1038: 
1039:                 FOR loc_nIdx = 1 TO THIS.this_nNroControles
1040:                     loc_cNome = THIS.laControles[loc_nIdx, 1]
1041:                     loc_cLbl  = STRTRAN(loc_cNome, "txt_4c_F", "lbl_4c_F")
1042:                     IF TYPE("loc_oCnt.&loc_cNome.") = "O"
1043:                         loc_oCnt.RemoveObject(loc_cNome)
1044:                     ENDIF
1045:                     IF TYPE("loc_oCnt.&loc_cLbl.") = "O"
1046:                         loc_oCnt.RemoveObject(loc_cLbl)
1047:                     ENDIF
1048:                 ENDFOR
1049: 
1050:                 loc_aFixos[1]  = "shp_4c_Sep1"
1051:                 loc_aFixos[2]  = "lbl_4c_FEmps"
1052:                 loc_aFixos[3]  = "lbl_4c_FDopes"
1053:                 loc_aFixos[4]  = "lbl_4c_FNumes"
1054:                 loc_aFixos[5]  = "lbl_4c_FAprova"
1055:                 loc_aFixos[6]  = "lbl_4c_FDatas"
1056:                 loc_aFixos[7]  = "txt_4c_FEmps"
1057:                 loc_aFixos[8]  = "txt_4c_FDopes"
1058:                 loc_aFixos[9]  = "txt_4c_FNumes"
1059:                 loc_aFixos[10] = "txt_4c_FAprova"
1060:                 loc_aFixos[11] = "txt_4c_FDatas"
1061: 
1062:                 FOR loc_nIdx = 1 TO 11
1063:                     loc_cNome = loc_aFixos[loc_nIdx]
1064:                     IF TYPE("loc_oCnt.&loc_cNome.") = "O"
1065:                         loc_oCnt.RemoveObject(loc_cNome)
1066:                     ENDIF
1067:                 ENDFOR
1068: 
1069:                 THIS.this_lMontouObjetos = .F.
1070:                 THIS.this_nNroControles  = 0
1071:             ENDIF
1072:         CATCH TO loc_oErro
1073:             MsgErro(loc_oErro.Message, "FormDrs.DesmontarObjetos")
1074:         ENDTRY
1075:     ENDPROC
1076: 
1077:     *===========================================================================
1078:     * CarregarDados - Popula controles com valores do registro (via LocalCadRs)
1079:     *===========================================================================
1080:     PROCEDURE CarregarDados()
1081:         LOCAL loc_oCnt, loc_cObjName, loc_cCampo, loc_cTipos, loc_cVal, loc_nIdx
1082:         TRY
1083:             IF !THIS.this_lMontouObjetos
1084:                 RETURN
1085:             ENDIF
1086:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos
1087: 
1088:             IF !USED("LocalCadRs")
1089:                 THIS.this_oBusinessObject.ApanhaRespostas()
1090:             ENDIF
1091: 
1092:             FOR loc_nIdx = 1 TO THIS.this_nNroControles
1093:                 loc_cObjName = THIS.laControles[loc_nIdx, 1]
1094:                 loc_cCampo   = THIS.laControles[loc_nIdx, 3]
1095: 
1096:                 SELECT crSigSyCit
1097:                 LOCATE FOR ALLTRIM(Campos) = loc_cCampo
1098:                 IF !EOF("crSigSyCit")
1099:                     loc_cTipos = ALLTRIM(crSigSyCit.Tipos)
1100:                 ELSE
1101:                     loc_cTipos = "M"
1102:                 ENDIF
1103: 
1104:                 IF SEEK(STR(THIS.this_nCodAtual, 6) + PADR(loc_cCampo, 10), "LocalCadRs", "CodCampos")
1105:                     loc_cVal = ALLTRIM(LocalCadRs.Resps)
1106:                 ELSE
1107:                     loc_cVal = ""
1108:                 ENDIF
1109: 
1110:                 IF TYPE("loc_oCnt.&loc_cObjName.") = "O"
1111:                     DO CASE
1112:                         CASE loc_cTipos = "D"
1113:                             loc_oCnt.&loc_cObjName..Value = IIF(EMPTY(loc_cVal), CTOD(""), CTOD(loc_cVal))
1114:                         CASE loc_cTipos = "N"
1115:                             loc_oCnt.&loc_cObjName..Value = VAL(loc_cVal)
1116:                         OTHERWISE
1117:                             loc_oCnt.&loc_cObjName..Value = loc_cVal
1118:                     ENDCASE
1119:                 ENDIF
1120:             ENDFOR

*-- Linhas 1272 a 1752:
1272:     *===========================================================================
1273:     * AtualizarBotoesWorkflow - Atualiza estado dos botoes Aprovar/Baixar
1274:     *===========================================================================
1275:     PROCEDURE AtualizarBotoesWorkflow()
1276:         LOCAL loc_oPagina, loc_oAprovar, loc_oBaixar
1277:         TRY
1278:             loc_oPagina  = THIS.pgf_4c_Paginas.Page1
1279:             loc_oAprovar = loc_oPagina.cnt_4c_Workflow.cmd_4c_Aprovar
1280:             loc_oBaixar  = loc_oPagina.cnt_4c_Workflow.cmd_4c_Baixar
1281: 
1282:             IF USED("crSigSyCrs") AND !EOF("crSigSyCrs")
1283:                 IF crSigSyCrs.ChkSubn
1284:                     loc_oAprovar.Enabled = .F.
1285:                     loc_oAprovar.Caption = "Aprovar"
1286:                     loc_oBaixar.Caption  = "Canc Baixa"
1287:                     loc_oBaixar.Enabled  = .T.
1288:                 ELSE
1289:                     loc_oAprovar.Enabled = .T.
1290:                     loc_oBaixar.Enabled  = .T.
1291:                     loc_oBaixar.Caption  = "Baixar"
1292:                     IF crSigSyCrs.ChkApro
1293:                         loc_oAprovar.Caption = "Desaprovar"
1294:                     ELSE
1295:                         loc_oAprovar.Caption = "Aprovar"
1296:                     ENDIF
1297:                 ENDIF
1298:             ELSE
1299:                 loc_oAprovar.Enabled = .F.
1300:                 loc_oBaixar.Enabled  = .F.
1301:             ENDIF
1302:         CATCH TO loc_oErro
1303:             MsgErro(loc_oErro.Message, "FormDrs.AtualizarBotoesWorkflow")
1304:         ENDTRY
1305:     ENDPROC
1306: 
1307:     *===========================================================================
1308:     * OptFiltroInteractiveChange - Recarrega lista ao mudar filtro
1309:     *===========================================================================
1310:     PROCEDURE OptFiltroInteractiveChange()
1311:         TRY
1312:             THIS.CarregarLista()
1313:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.SetFocus()
1314:         CATCH TO loc_oErro
1315:             MsgErro(loc_oErro.Message, "FormDrs.OptFiltroInteractiveChange")
1316:         ENDTRY
1317:     ENDPROC
1318: 
1319:     *===========================================================================
1320:     * GrdAfterRowColChange - Atualiza botoes ao mudar linha do grid
1321:     *===========================================================================
1322:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1323:         THIS.AtualizarBotoesWorkflow()
1324:     ENDPROC
1325: 
1326:     *===========================================================================
1327:     * BtnIncluirClick - Prepara novo registro
1328:     *===========================================================================
1329:     PROCEDURE BtnIncluirClick()
1330:         LOCAL loc_nNewCods
1331:         TRY
1332:             loc_nNewCods = THIS.this_oBusinessObject.GerarNovoCods()
1333:             IF loc_nNewCods > 0
1334:                 THIS.this_nCodAtual = loc_nNewCods
1335:                 THIS.this_oBusinessObject.this_nCods         = loc_nNewCods
1336:                 THIS.this_oBusinessObject.this_lNovoRegistro = .T.
1337:                 THIS.this_oBusinessObject.this_lEmEdicao     = .T.
1338:                 THIS.this_oBusinessObject.this_lChkApro      = .F.
1339:                 THIS.this_oBusinessObject.this_lChkSubn      = .F.
1340: 
1341:                 THIS.this_oBusinessObject.InicializarCursores()
1342:                 THIS.MontarObjetos("INSERIR")
1343:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = loc_nNewCods
1344:                 THIS.pgf_4c_Paginas.ActivePage = 2
1345:             ELSE
1346:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar novo c" + ;
1347:                     CHR(243) + "digo.", "Fichas T" + CHR(233) + "cnicas")
1348:             ENDIF
1349:         CATCH TO loc_oErro
1350:             MsgErro(loc_oErro.Message, "FormDrs.BtnIncluirClick")
1351:         ENDTRY
1352:     ENDPROC
1353: 
1354:     *===========================================================================
1355:     * BtnAlterarClick - Edita registro selecionado no grid
1356:     *===========================================================================
1357:     PROCEDURE BtnAlterarClick()
1358:         LOCAL loc_nCods
1359:         TRY
1360:             IF !USED("crSigSyCrs") OR EOF("crSigSyCrs")
1361:                 MsgAviso("Nenhum registro selecionado.", "Fichas T" + CHR(233) + "cnicas")
1362:                 RETURN
1363:             ENDIF
1364:             IF crSigSyCrs.ChkApro OR crSigSyCrs.ChkSubn
1365:                 MsgAviso("Registro aprovado ou baixado n" + CHR(227) + ;
1366:                     "o pode ser alterado.", "Fichas T" + CHR(233) + "cnicas")
1367:                 RETURN
1368:             ENDIF
1369: 
1370:             loc_nCods = crSigSyCrs.Cods
1371:             THIS.this_nCodAtual = loc_nCods
1372:             THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCods)
1373:             THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1374:             THIS.this_oBusinessObject.this_lEmEdicao     = .T.
1375:             THIS.this_oBusinessObject.InicializarCursores()
1376:             THIS.MontarObjetos("ALTERAR")
1377:             THIS.CarregarDados()
1378:             THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = loc_nCods
1379:             THIS.pgf_4c_Paginas.ActivePage = 2
1380:         CATCH TO loc_oErro
1381:             MsgErro(loc_oErro.Message, "FormDrs.BtnAlterarClick")
1382:         ENDTRY
1383:     ENDPROC
1384: 
1385:     *===========================================================================
1386:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
1387:     *===========================================================================
1388:     PROCEDURE BtnExcluirClick()
1389:         LOCAL loc_nCods, loc_lConfirma
1390:         TRY
1391:             IF !USED("crSigSyCrs") OR EOF("crSigSyCrs")
1392:                 MsgAviso("Nenhum registro selecionado.", "Fichas T" + CHR(233) + "cnicas")
1393:                 RETURN
1394:             ENDIF
1395:             IF crSigSyCrs.ChkApro OR crSigSyCrs.ChkSubn
1396:                 MsgAviso("Registro aprovado ou baixado n" + CHR(227) + "o pode ser exclu" + ;
1397:                     CHR(237) + "do.", "Fichas T" + CHR(233) + "cnicas")
1398:                 RETURN
1399:             ENDIF
1400: 
1401:             loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro " + ;
1402:                 ALLTRIM(STR(crSigSyCrs.Cods)) + "?", "Excluir Ficha")
1403:             IF loc_lConfirma
1404:                 loc_nCods = crSigSyCrs.Cods
1405:                 THIS.this_oBusinessObject.this_nCods = loc_nCods
1406:                 THIS.this_oBusinessObject.this_cTits = THIS.this_cTits
1407:                 IF THIS.this_oBusinessObject.Excluir()
1408:                     THIS.this_oBusinessObject.ApanhaRespostas()
1409:                     THIS.CarregarLista()
1410:                 ENDIF
1411:             ENDIF
1412:         CATCH TO loc_oErro
1413:             MsgErro(loc_oErro.Message, "FormDrs.BtnExcluirClick")
1414:         ENDTRY
1415:     ENDPROC
1416: 
1417:     *===========================================================================
1418:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1419:     *===========================================================================
1420:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1421:         LOCAL loc_lResultado
1422:         loc_lResultado = .F.
1423:         TRY
1424:             IF VARTYPE(par_nPagina) != "N" OR !INLIST(par_nPagina, 1, 2)
1425:                 loc_lResultado = .F.
1426:             ELSE
1427:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1428:                 IF par_nPagina = 1
1429:                     THIS.this_cModoAtual = "LISTA"
1430:                     THIS.CarregarLista()
1431:                 ENDIF
1432:                 loc_lResultado = .T.
1433:             ENDIF
1434:         CATCH TO loc_oErro
1435:             MsgErro(loc_oErro.Message, "FormDrs.AlternarPagina")
1436:         ENDTRY
1437:         RETURN loc_lResultado
1438:     ENDPROC
1439: 
1440:     *===========================================================================
1441:     * BtnVisualizarClick - Exibe registro selecionado em modo leitura (CONSULTAR)
1442:     *===========================================================================
1443:     PROCEDURE BtnVisualizarClick()
1444:         LOCAL loc_nCods
1445:         TRY
1446:             IF !USED("crSigSyCrs") OR EOF("crSigSyCrs")
1447:                 MsgAviso("Nenhum registro selecionado.", "Fichas T" + CHR(233) + "cnicas")
1448:                 RETURN
1449:             ENDIF
1450: 
1451:             loc_nCods = crSigSyCrs.Cods
1452:             THIS.this_nCodAtual = loc_nCods
1453:             THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCods)
1454:             THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1455:             THIS.MontarObjetos("CONSULTAR")
1456:             THIS.CarregarDados()
1457:             THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = loc_nCods
1458:             THIS.this_cModoAtual = "VISUALIZAR"
1459:             THIS.pgf_4c_Paginas.ActivePage = 2
1460:         CATCH TO loc_oErro
1461:             MsgErro(loc_oErro.Message, "FormDrs.BtnVisualizarClick")
1462:         ENDTRY
1463:     ENDPROC
1464: 
1465:     *===========================================================================
1466:     * BtnBuscarClick - Recarrega lista aplicando filtro atual (optFiltro)
1467:     *===========================================================================
1468:     PROCEDURE BtnBuscarClick()
1469:         TRY
1470:             THIS.CarregarLista()
1471:             IF USED("crSigSyCrs") AND RECCOUNT("crSigSyCrs") > 0
1472:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.SetFocus()
1473:             ENDIF
1474:         CATCH TO loc_oErro
1475:             MsgErro(loc_oErro.Message, "FormDrs.BtnBuscarClick")
1476:         ENDTRY
1477:     ENDPROC
1478: 
1479:     *===========================================================================
1480:     * BtnSalvarClick - Valida, grava em crGrvCadRs e persiste via BO
1481:     *===========================================================================
1482:     PROCEDURE BtnSalvarClick()
1483:         LOCAL loc_nIdx, loc_cObjName, loc_oCnt, loc_lValido
1484:         LOCAL loc_cEmps, loc_cDopes, loc_cNumes, loc_lSoDigitos, loc_nChr
1485:         LOCAL loc_cEDN, loc_nResult
1486:         TRY
1487:             IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
1488:                 THIS.BtnCancelarClick()
1489:                 RETURN
1490:             ENDIF
1491: 
1492:             loc_oCnt    = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos
1493:             loc_lValido = .T.
1494: 
1495:             *-- Validar campos obrigatorios
1496:             FOR loc_nIdx = 1 TO THIS.this_nNroControles
1497:                 IF THIS.laControles[loc_nIdx, 2] = 1
1498:                     loc_cObjName = THIS.laControles[loc_nIdx, 1]
1499:                     IF TYPE("loc_oCnt.&loc_cObjName.") = "O"
1500:                         IF EMPTY(loc_oCnt.&loc_cObjName..Value)
1501:                             MsgAviso("Campo de preenchimento obrigat" + CHR(243) + "rio n" + ;
1502:                                 CHR(227) + "o preenchido.", "Fichas T" + CHR(233) + "cnicas")
1503:                             loc_oCnt.&loc_cObjName..SetFocus()
1504:                             loc_lValido = .F.
1505:                             EXIT
1506:                         ENDIF
1507:                     ENDIF
1508:                 ENDIF
1509:             ENDFOR
1510: 
1511:             IF !loc_lValido
1512:                 RETURN
1513:             ENDIF
1514: 
1515:             *-- Validar Numes (somente digitos, se preenchido)
1516:             loc_cNumes = IIF(TYPE("loc_oCnt.txt_4c_FNumes") = "O", ALLTRIM(loc_oCnt.txt_4c_FNumes.Value), "")
1517:             IF !EMPTY(loc_cNumes)
1518:                 loc_lSoDigitos = .T.
1519:                 FOR loc_nChr = 1 TO LEN(loc_cNumes)
1520:                     IF !ISDIGIT(SUBSTR(loc_cNumes, loc_nChr, 1))
1521:                         loc_lSoDigitos = .F.
1522:                         EXIT
1523:                     ENDIF
1524:                 ENDFOR
1525:                 IF !loc_lSoDigitos
1526:                     MsgAviso("O N" + CHR(250) + "mero da Opera" + CHR(231) + CHR(227) + ;
1527:                         "o digitado n" + CHR(227) + "o " + CHR(233) + " v" + CHR(225) + "lido.", ;
1528:                         "Fichas T" + CHR(233) + "cnicas")
1529:                     RETURN
1530:                 ENDIF
1531:             ENDIF
1532: 
1533:             *-- Obter valores dos campos header
1534:             loc_cEmps  = IIF(TYPE("loc_oCnt.txt_4c_FEmps")  = "O", ALLTRIM(loc_oCnt.txt_4c_FEmps.Value),  "")
1535:             loc_cDopes = IIF(TYPE("loc_oCnt.txt_4c_FDopes") = "O", ALLTRIM(loc_oCnt.txt_4c_FDopes.Value), "")
1536:             loc_cNumes = IIF(TYPE("loc_oCnt.txt_4c_FNumes") = "O", ALLTRIM(loc_oCnt.txt_4c_FNumes.Value), "")
1537: 
1538:             *-- Empresa obrigatoria quando Dopes e Numes informados
1539:             IF EMPTY(loc_cEmps) AND !EMPTY(loc_cDopes) AND !EMPTY(loc_cNumes)
1540:                 MsgAviso(CHR(201) + " necess" + CHR(225) + "rio preencher a Empresa ao informar" + ;
1541:                     " a Opera" + CHR(231) + CHR(227) + "o e o N" + CHR(250) + "mero.", ;
1542:                     "Fichas T" + CHR(233) + "cnicas")
1543:                 RETURN
1544:             ENDIF
1545: 
1546:             *-- Se Emps+Dopes+Numes preenchidos: deve estar aprovado
1547:             IF !EMPTY(loc_cEmps) AND !EMPTY(loc_cDopes) AND !EMPTY(loc_cNumes)
1548:                 IF !THIS.this_oBusinessObject.this_lChkApro
1549:                     MsgAviso("Baixa n" + CHR(227) + "o Aprovada!", "Fichas T" + CHR(233) + "cnicas")
1550:                     RETURN
1551:                 ENDIF
1552:             ENDIF
1553: 
1554:             *-- Gravar controles em crGrvCadRs e persistir via BO
1555:             IF THIS.GravarDados()
1556:                 THIS.this_oBusinessObject.this_nCods = THIS.this_nCodAtual
1557:                 THIS.this_oBusinessObject.this_cTits = THIS.this_cTits
1558:                 IF THIS.this_oBusinessObject.Salvar()
1559:                     THIS.this_oBusinessObject.ApanhaRespostas()
1560:                     THIS.DesmontarObjetos()
1561:                     THIS.pgf_4c_Paginas.ActivePage = 1
1562:                     THIS.this_cModoAtual = "LISTA"
1563:                     THIS.CarregarLista()
1564:                 ENDIF
1565:             ENDIF
1566: 
1567:         CATCH TO loc_oErro
1568:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1569:                 "FormDrs.BtnSalvarClick")
1570:         ENDTRY
1571:     ENDPROC
1572: 
1573:     *===========================================================================
1574:     * BtnCancelarClick - Descarta edicao e volta para lista
1575:     *===========================================================================
1576:     PROCEDURE BtnCancelarClick()
1577:         TRY
1578:             THIS.DesmontarObjetos()
1579:             THIS.pgf_4c_Paginas.ActivePage = 1
1580:             THIS.this_cModoAtual = "LISTA"
1581:         CATCH TO loc_oErro
1582:             MsgErro(loc_oErro.Message, "FormDrs.BtnCancelarClick")
1583:         ENDTRY
1584:     ENDPROC
1585: 
1586:     *===========================================================================
1587:     * BtnAprovarClick - Aprova ou Desaprova o registro selecionado
1588:     *===========================================================================
1589:     PROCEDURE BtnAprovarClick()
1590:         LOCAL loc_oAprovar, loc_lConfirma
1591:         TRY
1592:             IF !USED("crSigSyCrs") OR EOF("crSigSyCrs")
1593:                 MsgAviso("Nenhum registro selecionado.", "Fichas T" + CHR(233) + "cnicas")
1594:                 RETURN
1595:             ENDIF
1596: 
1597:             loc_oAprovar = THIS.pgf_4c_Paginas.Page1.cnt_4c_Workflow.cmd_4c_Aprovar
1598: 
1599:             IF !crSigSyCrs.ChkApro
1600:                 loc_lConfirma = MsgConfirma("Confirma Aprova" + CHR(231) + CHR(227) + "o?", ;
1601:                     "Fichas T" + CHR(233) + "cnicas")
1602:                 IF loc_lConfirma
1603:                     THIS.this_oBusinessObject.this_nCods = crSigSyCrs.Cods
1604:                     IF THIS.this_oBusinessObject.Aprovar(ALLTRIM(gc_4c_UsuarioLogado))
1605:                         SELECT crSigSyCrs
1606:                         REPLACE crSigSyCrs.ChkApro WITH .T.
1607:                         loc_oAprovar.Caption = "Desaprovar"
1608:                         THIS.AtualizarBotoesWorkflow()
1609:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1610:                     ENDIF
1611:                 ENDIF
1612:             ELSE
1613:                 loc_lConfirma = MsgConfirma("Confirma Desaprova" + CHR(231) + CHR(227) + "o?", ;
1614:                     "Fichas T" + CHR(233) + "cnicas")
1615:                 IF loc_lConfirma
1616:                     THIS.this_oBusinessObject.this_nCods = crSigSyCrs.Cods
1617:                     IF THIS.this_oBusinessObject.Desaprovar()
1618:                         SELECT crSigSyCrs
1619:                         REPLACE crSigSyCrs.ChkApro WITH .F.
1620:                         loc_oAprovar.Caption = "Aprovar"
1621:                         THIS.AtualizarBotoesWorkflow()
1622:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1623:                     ENDIF
1624:                 ENDIF
1625:             ENDIF
1626:         CATCH TO loc_oErro
1627:             MsgErro(loc_oErro.Message, "FormDrs.BtnAprovarClick")
1628:         ENDTRY
1629:     ENDPROC
1630: 
1631:     *===========================================================================
1632:     * BtnBaixarClick - Baixa (abre Page2 em ALTERAR) ou Cancela Baixa
1633:     *===========================================================================
1634:     PROCEDURE BtnBaixarClick()
1635:         LOCAL loc_oBaixar, loc_lConfirma, loc_nCods
1636:         TRY
1637:             IF !USED("crSigSyCrs") OR EOF("crSigSyCrs")
1638:                 MsgAviso("Nenhum registro selecionado.", "Fichas T" + CHR(233) + "cnicas")
1639:                 RETURN
1640:             ENDIF
1641: 
1642:             loc_oBaixar = THIS.pgf_4c_Paginas.Page1.cnt_4c_Workflow.cmd_4c_Baixar
1643: 
1644:             IF !crSigSyCrs.ChkSubn
1645:                 *-- Baixar: exige aprovacao previa
1646:                 IF !crSigSyCrs.ChkApro
1647:                     MsgAviso("Baixa n" + CHR(227) + "o Aprovada!", "Fichas T" + CHR(233) + "cnicas")
1648:                     RETURN
1649:                 ENDIF
1650:                 *-- Abre Page2 em modo ALTERAR para preencher Emps/Dopes/Numes
1651:                 loc_nCods = crSigSyCrs.Cods
1652:                 THIS.this_nCodAtual = loc_nCods
1653:                 THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCods)
1654:                 THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1655:                 THIS.this_oBusinessObject.this_lEmEdicao     = .T.
1656:                 THIS.this_oBusinessObject.InicializarCursores()
1657:                 THIS.MontarObjetos("ALTERAR")
1658:                 THIS.CarregarDados()
1659:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = loc_nCods
1660:                 THIS.pgf_4c_Paginas.ActivePage = 2
1661:                 THIS.this_cModoAtual = "ALTERAR"
1662:             ELSE
1663:                 *-- Cancelar Baixa
1664:                 loc_lConfirma = MsgConfirma("Confirma Cancelamento da Baixa?", ;
1665:                     "Fichas T" + CHR(233) + "cnicas")
1666:                 IF loc_lConfirma
1667:                     IF THIS.this_oBusinessObject.CancelarBaixa(crSigSyCrs.Cods)
1668:                         SELECT crSigSyCrs
1669:                         REPLACE crSigSyCrs.ChkSubn WITH .F.
1670:                         loc_oBaixar.Caption = "Baixar"
1671:                         THIS.AtualizarBotoesWorkflow()
1672:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1673:                     ENDIF
1674:                 ENDIF
1675:             ENDIF
1676:         CATCH TO loc_oErro
1677:             MsgErro(loc_oErro.Message, "FormDrs.BtnBaixarClick")
1678:         ENDTRY
1679:     ENDPROC
1680: 
1681:     *===========================================================================
1682:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1683:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
1684:     *===========================================================================
1685:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1686:         LOCAL loc_nI, loc_oObjeto, loc_nP
1687: 
1688:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1689:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1690: 
1691:             IF VARTYPE(loc_oObjeto) = "O"
1692:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1693:                     loc_oObjeto.Visible = .T.
1694:                 ENDIF
1695: 
1696:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1697:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1698:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1699:                     ENDFOR
1700:                 ENDIF
1701: 
1702:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1703:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1704:                 ENDIF
1705:             ENDIF
1706:         ENDFOR
1707:     ENDPROC
1708: 
1709:     *===========================================================================
1710:     * BtnEncerrarClick - Fecha o formulario
1711:     *===========================================================================
1712:     PROCEDURE BtnEncerrarClick()
1713:         THIS.Release()
1714:     ENDPROC
1715: 
1716:     *===========================================================================
1717:     * GravarDados - Popula crGrvCadRs com valores dos controles de cnt_4c_Campos
1718:     * Chamado por BtnSalvarClick e FormParaBO antes de BO.Salvar()
1719:     *===========================================================================
1720:     PROTECTED FUNCTION GravarDados()
1721:         LOCAL loc_lResultado, loc_oCnt, loc_nIdx, loc_cObjName, loc_cCampo
1722:         LOCAL loc_cTipos, loc_cVal, loc_cPergs, loc_lChkSubn
1723:         LOCAL loc_cEmps, loc_cDopes, loc_cNumes
1724:         loc_lResultado = .F.
1725: 
1726:         IF !THIS.this_lMontouObjetos
1727:             RETURN loc_lResultado
1728:         ENDIF
1729: 
1730:         TRY
1731:             THIS.this_oBusinessObject.InicializarCursores()
1732: 
1733:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos
1734: 
1735:             *-- Valores dos campos fixos de header da UI
1736:             loc_cEmps  = IIF(TYPE("loc_oCnt.txt_4c_FEmps")  = "O", ALLTRIM(loc_oCnt.txt_4c_FEmps.Value),  "")
1737:             loc_cDopes = IIF(TYPE("loc_oCnt.txt_4c_FDopes") = "O", ALLTRIM(loc_oCnt.txt_4c_FDopes.Value), "")
1738:             loc_cNumes = IIF(TYPE("loc_oCnt.txt_4c_FNumes") = "O", ALLTRIM(loc_oCnt.txt_4c_FNumes.Value), "")
1739: 
1740:             *-- ChkSubn = .T. somente quando Emps+Dopes+Numes todos preenchidos
1741:             loc_lChkSubn = !EMPTY(loc_cEmps) AND !EMPTY(loc_cDopes) AND !EMPTY(loc_cNumes)
1742: 
1743:             *-- Campos dinamicos de SigSyCit
1744:             FOR loc_nIdx = 1 TO THIS.this_nNroControles
1745:                 loc_cObjName = THIS.laControles[loc_nIdx, 1]
1746:                 loc_cCampo   = THIS.laControles[loc_nIdx, 3]
1747: 
1748:                 SELECT crSigSyCit
1749:                 LOCATE FOR ALLTRIM(Campos) = loc_cCampo
1750:                 IF !EOF("crSigSyCit")
1751:                     loc_cTipos = ALLTRIM(crSigSyCit.Tipos)
1752:                     loc_cPergs = ALLTRIM(crSigSyCit.Descs)

*-- Linhas 1848 a 1926:
1848:     * Wrapper canonico do padrao CRUD; delega para GravarDados() que popula
1849:     * crGrvCadRs (usado pelo DrsBO.Salvar) e propriedades this_ do BO.
1850:     *===========================================================================
1851:     PROCEDURE FormParaBO()
1852:         LOCAL loc_lResultado
1853:         loc_lResultado = .F.
1854:         TRY
1855:             THIS.this_oBusinessObject.this_nCods = THIS.this_nCodAtual
1856:             THIS.this_oBusinessObject.this_cTits = THIS.this_cTits
1857:             loc_lResultado = THIS.GravarDados()
1858:         CATCH TO loc_oErro
1859:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1860:                 "FormDrs.FormParaBO")
1861:         ENDTRY
1862:         RETURN loc_lResultado
1863:     ENDPROC
1864: 
1865:     *===========================================================================
1866:     * BOParaForm - Transfere valores do BO para a UI (via LocalCadRs)
1867:     * Wrapper canonico do padrao CRUD; delega para CarregarDados() que le
1868:     * LocalCadRs (cursor mantido pelo DrsBO.ApanhaRespostas) e popula controles.
1869:     *===========================================================================
1870:     PROCEDURE BOParaForm()
1871:         TRY
1872:             THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = THIS.this_oBusinessObject.this_nCods
1873:             THIS.this_nCodAtual = THIS.this_oBusinessObject.this_nCods
1874:             THIS.CarregarDados()
1875:         CATCH TO loc_oErro
1876:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1877:                 "FormDrs.BOParaForm")
1878:         ENDTRY
1879:     ENDPROC
1880: 
1881:     *===========================================================================
1882:     * HabilitarCampos - Habilita/desabilita controles editaveis de cnt_4c_Campos
1883:     * par_lHabilitar: .T. para habilitar (INSERIR/ALTERAR), .F. para bloquear (CONSULTAR)
1884:     * txt_4c_FAprova e txt_4c_FDatas permanecem sempre readonly (populados pelo sistema).
1885:     *===========================================================================
1886:     PROCEDURE HabilitarCampos(par_lHabilitar)
1887:         LOCAL loc_oCnt, loc_nIdx, loc_cObjName, loc_lReadOnly, loc_cNome, loc_oCtl
1888:         LOCAL loc_aEdit[3], loc_aReadOnly[2]
1889:         TRY
1890:             IF !THIS.this_lMontouObjetos
1891:                 RETURN
1892:             ENDIF
1893:             loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos
1894:             loc_lReadOnly = !par_lHabilitar
1895: 
1896:             *-- Campos dinamicos de SigSyCit
1897:             FOR loc_nIdx = 1 TO THIS.this_nNroControles
1898:                 loc_cObjName = THIS.laControles[loc_nIdx, 1]
1899:                 IF TYPE("loc_oCnt.&loc_cObjName.") = "O"
1900:                     loc_oCnt.&loc_cObjName..ReadOnly = loc_lReadOnly
1901:                     loc_oCnt.&loc_cObjName..Enabled  = .T.
1902:                 ENDIF
1903:             ENDFOR
1904: 
1905:             *-- Campos fixos editaveis
1906:             loc_aEdit[1] = "txt_4c_FEmps"
1907:             loc_aEdit[2] = "txt_4c_FDopes"
1908:             loc_aEdit[3] = "txt_4c_FNumes"
1909:             FOR loc_nIdx = 1 TO 3
1910:                 loc_cNome = loc_aEdit[loc_nIdx]
1911:                 IF TYPE("loc_oCnt.&loc_cNome.") = "O"
1912:                     loc_oCtl          = EVALUATE("loc_oCnt." + loc_cNome)
1913:                     loc_oCtl.ReadOnly = loc_lReadOnly
1914:                     loc_oCtl.Enabled  = .T.
1915:                 ENDIF
1916:             ENDFOR
1917: 
1918:             *-- Campos fixos sempre readonly
1919:             loc_aReadOnly[1] = "txt_4c_FAprova"
1920:             loc_aReadOnly[2] = "txt_4c_FDatas"
1921:             FOR loc_nIdx = 1 TO 2
1922:                 loc_cNome = loc_aReadOnly[loc_nIdx]
1923:                 IF TYPE("loc_oCnt.&loc_cNome.") = "O"
1924:                     loc_oCtl          = EVALUATE("loc_oCnt." + loc_cNome)
1925:                     loc_oCtl.ReadOnly = .T.
1926:                 ENDIF

*-- Linhas 1938 a 1981:
1938:     * LimparCampos - Zera todos os controles editaveis de Page2
1939:     * Aplicado ao entrar em INSERIR ou apos cancelar edicao.
1940:     *===========================================================================
1941:     PROCEDURE LimparCampos()
1942:         LOCAL loc_oCnt, loc_nIdx, loc_cObjName, loc_cTipos, loc_cCampo, loc_cNome, loc_oCtl
1943:         LOCAL loc_aFixos[5]
1944:         TRY
1945:             THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = 0
1946: 
1947:             IF !THIS.this_lMontouObjetos
1948:                 RETURN
1949:             ENDIF
1950:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos
1951: 
1952:             *-- Campos dinamicos: zerar conforme tipo
1953:             FOR loc_nIdx = 1 TO THIS.this_nNroControles
1954:                 loc_cObjName = THIS.laControles[loc_nIdx, 1]
1955:                 loc_cCampo   = THIS.laControles[loc_nIdx, 3]
1956: 
1957:                 SELECT crSigSyCit
1958:                 LOCATE FOR ALLTRIM(Campos) = loc_cCampo
1959:                 IF !EOF("crSigSyCit")
1960:                     loc_cTipos = ALLTRIM(crSigSyCit.Tipos)
1961:                 ELSE
1962:                     loc_cTipos = "M"
1963:                 ENDIF
1964: 
1965:                 IF TYPE("loc_oCnt.&loc_cObjName.") = "O"
1966:                     DO CASE
1967:                         CASE loc_cTipos = "D"
1968:                             loc_oCnt.&loc_cObjName..Value = CTOD("")
1969:                         CASE loc_cTipos = "N"
1970:                             loc_oCnt.&loc_cObjName..Value = 0
1971:                         OTHERWISE
1972:                             loc_oCnt.&loc_cObjName..Value = ""
1973:                     ENDCASE
1974:                 ENDIF
1975:             ENDFOR
1976: 
1977:             *-- Campos fixos: todos texto
1978:             loc_aFixos[1] = "txt_4c_FEmps"
1979:             loc_aFixos[2] = "txt_4c_FDopes"
1980:             loc_aFixos[3] = "txt_4c_FNumes"
1981:             loc_aFixos[4] = "txt_4c_FAprova"

*-- Linhas 1999 a 2061:
1999:     * INSERIR/ALTERAR: Salvar/Cancelar ativos, CRUD inativos
2000:     * VISUALIZAR: apenas Cancelar (voltar) ativo
2001:     *===========================================================================
2002:     PROCEDURE AjustarBotoesPorModo()
2003:         LOCAL loc_oCrud, loc_oAcao, loc_cModo
2004:         TRY
2005:             loc_oCrud = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
2006:             loc_oAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2007:             loc_cModo = UPPER(ALLTRIM(THIS.this_cModoAtual))
2008: 
2009:             DO CASE
2010:                 CASE loc_cModo = "LISTA"
2011:                     loc_oCrud.cmd_4c_Incluir.Enabled    = .T.
2012:                     loc_oCrud.cmd_4c_Visualizar.Enabled = .T.
2013:                     loc_oCrud.cmd_4c_Alterar.Enabled    = .T.
2014:                     loc_oCrud.cmd_4c_Excluir.Enabled    = .T.
2015:                     loc_oCrud.cmd_4c_Buscar.Enabled     = .T.
2016:                     loc_oAcao.cmd_4c_Confirmar.Enabled  = .F.
2017:                     loc_oAcao.cmd_4c_Cancelar.Enabled   = .F.
2018: 
2019:                 CASE INLIST(loc_cModo, "INSERIR", "ALTERAR")
2020:                     loc_oCrud.cmd_4c_Incluir.Enabled    = .F.
2021:                     loc_oCrud.cmd_4c_Visualizar.Enabled = .F.
2022:                     loc_oCrud.cmd_4c_Alterar.Enabled    = .F.
2023:                     loc_oCrud.cmd_4c_Excluir.Enabled    = .F.
2024:                     loc_oCrud.cmd_4c_Buscar.Enabled     = .F.
2025:                     loc_oAcao.cmd_4c_Confirmar.Enabled  = .T.
2026:                     loc_oAcao.cmd_4c_Cancelar.Enabled   = .T.
2027: 
2028:                 CASE loc_cModo = "VISUALIZAR"
2029:                     loc_oCrud.cmd_4c_Incluir.Enabled    = .F.
2030:                     loc_oCrud.cmd_4c_Visualizar.Enabled = .F.
2031:                     loc_oCrud.cmd_4c_Alterar.Enabled    = .F.
2032:                     loc_oCrud.cmd_4c_Excluir.Enabled    = .F.
2033:                     loc_oCrud.cmd_4c_Buscar.Enabled     = .F.
2034:                     loc_oAcao.cmd_4c_Confirmar.Enabled  = .F.
2035:                     loc_oAcao.cmd_4c_Cancelar.Enabled   = .T.
2036:             ENDCASE
2037:         CATCH TO loc_oErro
2038:             MsgErro(loc_oErro.Message, "FormDrs.AjustarBotoesPorModo")
2039:         ENDTRY
2040:     ENDPROC
2041: 
2042:     *===========================================================================
2043:     * Destroy - Limpa recursos ao fechar
2044:     *===========================================================================
2045:     PROCEDURE Destroy()
2046:         TRY
2047:             THIS.DesmontarObjetos()
2048:             IF USED("cursor_4c_Dados")
2049:                 USE IN cursor_4c_Dados
2050:             ENDIF
2051:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2052:                 THIS.this_oBusinessObject.FecharCursores()
2053:                 THIS.this_oBusinessObject = .NULL.
2054:             ENDIF
2055:         CATCH TO loc_oErro
2056:             MsgErro(loc_oErro.Message, "FormDrs.Destroy")
2057:         ENDTRY
2058:         DODEFAULT()
2059:     ENDPROC
2060: 
2061: ENDDEFINE


### BO (C:\4c\projeto\app\classes\DrsBO.prg):
*===============================================================================
* DrsBO.prg - Business Object para Fichas Tecnicas (SigSyCrs)
* Herda de BusinessBase
*
* Tabela principal: SigSyCrs
* Tabela config: SigSyCit
*
* MODELO DE DADOS (key-value store):
*   SigSyCrs (Tits C20, Cods N, Campos C10, Resps M, Pergs C, cIdChaves C,
*             ChkApro L, ChkSubn L)
*   SigSyCit (Tits C20, Campos C10, Descs C, Tipos C1, Ordems N, Listas N,
*             Linhas N, Files C, Fields C, Chaves C, cIdChaves C, CampoOAs C,
*             CampoDAs C, Associados C, Cadeado N, Vinculados C,
*             Obrigatorios L, Pictures C)
*
* Um "registro logico" = conjunto de rows em SigSyCrs com mesmo (Tits, Cods).
* Cada row armazena um campo: Campos=nome, Resps=valor, Pergs=rotulo.
* cIdChaves e a PK fisica de cada row individual.
*===============================================================================

DEFINE CLASS DrsBO AS BusinessBase

    *---------------------------------------------------------------------------
    * Identificacao do registro logico (Tits + Cods formam a PK logica)
    *---------------------------------------------------------------------------
    this_cTits   = ""   && Tipo de ficha C(20) - identifica o formulario/processo
    this_nCods   = 0    && Codigo do registro (PK logica dentro do Tits)

    *---------------------------------------------------------------------------
    * Status do workflow de aprovacao/baixa
    *---------------------------------------------------------------------------
    this_lChkApro  = .F.    && Aprovado
    this_lChkSubn  = .F.    && Baixado/Encerrado (ChkSubn)

    *---------------------------------------------------------------------------
    * Campos fixos de cabecalho (armazenados como key-value em SigSyCrs)
    * Campos = 'Emps', 'Dopes', 'Numes', 'Aprova', 'Datas', 'Baixa'
    *---------------------------------------------------------------------------
    this_cEmps   = ""   && Empresa (C3) - referencia SigCdEmp.CEmps
    this_cDopes  = ""   && Operacao (C20) - referencia SigCdOpe.Dopes
    this_cNumes  = ""   && Numero da operacao (C6)
    this_cAprova = ""   && Aprovador - usuario que aprovou (C10)
    this_cDatas  = ""   && Data de aprovacao como string (C20)
    this_cBaixa  = ""   && Usuario que registrou baixa (C10)

    *---------------------------------------------------------------------------
    * Nomes dos cursores de trabalho (mantidos como constantes aqui para
    * referencia cruzada com o Form)
    *---------------------------------------------------------------------------
    this_cCursorRs    = "crGrvCadRs"    && Cursor escrita SigSyCrs (key=cIdChaves)
    this_cCursorLista = "crSigSyCrs"    && Cursor lista SigSyCrs (key=Cods)
    this_cCursorCit   = "crSigSyCit"    && Cursor config SigSyCit
    this_cCursorLocal = "LocalCadRs"    && Cursor local de respostas (key=CodCampos)

    *===========================================================================
    PROCEDURE Init()
    *===========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigSyCrs"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * Destroy - Fecha cursores ao destruir o BO
    *===========================================================================
    PROCEDURE Destroy()
        THIS.FecharCursores()
        DODEFAULT()
    ENDPROC

    *===========================================================================
    * ObterChavePrimaria - Retorna chave para auditoria
    *===========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN EscaparSQL(ALLTRIM(THIS.this_cTits)) + ", " + ;
               FormatarNumeroSQL(THIS.this_nCods)
    ENDFUNC

    *===========================================================================
    * FecharCursores - Fecha todos os cursores de trabalho
    *===========================================================================
    PROCEDURE FecharCursores()
        IF USED("crSigSyCrs")
            USE IN crSigSyCrs
        ENDIF
        IF USED("LocalCadRs")
            USE IN LocalCadRs
        ENDIF
        IF USED("crSigSyCit")
            USE IN crSigSyCit
        ENDIF
        IF USED("crGrvCadRs")
            USE IN crGrvCadRs
        ENDIF
    ENDPROC

    *===========================================================================
    * InicializarCursores - Cria cursor de escrita crGrvCadRs
    *===========================================================================
    FUNCTION InicializarCursores()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("crGrvCadRs")
                USE IN crGrvCadRs
            ENDIF
            SET NULL ON
            CREATE CURSOR crGrvCadRs ( ;
                Tits      C(20),  ;
                Campos    C(10),  ;
                Cods      N(10,0), ;
                cIdChaves C(38),  ;
                Resps     M,      ;
                Pergs     C(200), ;
                ChkApro   L,      ;
                ChkSubn   L )
            SET NULL OFF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CarregarSigSyCit - Carrega definicoes de campos de SigSyCit para este Tits
    *===========================================================================
    FUNCTION CarregarSigSyCit()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("crSigSyCit")
                USE IN crSigSyCit
            ENDIF

            *-- Test mode without DB: create empty cursor so form can initialize
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                SET NULL ON
                CREATE CURSOR crSigSyCit (Tits C(20), Campos C(10), Descs C(60), Tipos C(1), ;
                    Ordems N(3,0), Listas N(1,0), Linhas N(3,0), Files C(200), Fields C(200), ;
                    Chaves C(100), cIdChaves C(38), CampoOAs C(20), CampoDAs C(20), ;
                    Associados C(100), Cadeado N(1,0), Vinculados C(100), ;
                    Obrigatorios N(1,0), Pictures C(50))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE

            loc_cSQL = "SELECT Tits, Campos, Descs, Tipos, Ordems, Listas, Linhas, Files," + ;
                       " Fields, Chaves, cIdChaves, CampoOAs, CampoDAs, Associados, Cadeado," + ;
                       " Vinculados, Obrigatorios, Pictures FROM SigSyCit" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + " ORDER BY Ordems"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigSyCit")
            IF loc_nResult > 0
                IF RECCOUNT("crSigSyCit") > 0
                    SELECT crSigSyCit
                    INDEX ON STR(Ordems, 2) TAG Ordems ADDITIVE
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar SigSyCit:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            ENDIF && gnConnHandle
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * ApanhaRespostas - Carrega todas as respostas de SigSyCrs em LocalCadRs indexado
    *===========================================================================
    FUNCTION ApanhaRespostas()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("LocalCadRs")
                USE IN LocalCadRs
            ENDIF
            loc_cSQL = "SELECT Cods, Campos, CAST(Resps AS VARCHAR(8000)) AS Resps" + ;
                       " FROM SigSyCrs WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       " ORDER BY Cods, Campos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalCadRs")
            IF loc_nResult > 0
                IF RECCOUNT("LocalCadRs") > 0
                    SELECT LocalCadRs
                    INDEX ON STR(Cods, 6) + Campos TAG CodCampos ADDITIVE
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar respostas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * AlimentaLista - Preenche colunas dinamicas de crSigSyCrs via LocalCadRs
    *===========================================================================
    PROCEDURE AlimentaLista()
        LOCAL loc_cCpo
        TRY
            IF USED("crSigSyCrs") AND USED("LocalCadRs") AND USED("crSigSyCit") ;
                    AND RECCOUNT("crSigSyCrs") > 0 AND RECCOUNT("crSigSyCit") > 0
                SELECT crSigSyCrs
                SCAN
                    SELECT crSigSyCit
                    SCAN
                        IF crSigSyCit.Listas = 1
                            loc_cCpo = ALLTRIM(crSigSyCit.Campos)
                            IF SEEK(STR(crSigSyCrs.Cods, 6) + crSigSyCit.Campos, ;
                                    "LocalCadRs", "CodCampos")
                                IF crSigSyCit.Tipos = "N"
                                    REPLACE &loc_cCpo. WITH VAL(LocalCadRs.Resps) IN crSigSyCrs
                                ELSE
                                    REPLACE &loc_cCpo. WITH LocalCadRs.Resps IN crSigSyCrs
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDSCAN
                    SELECT crSigSyCrs
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Buscar - Lista registros em crSigSyCrs com colunas dinamicas de SigSyCit
    * par_cFiltro: aceita "TODAS"/"" (sem filtro), status=0 (em aberto) ou "BAIXADAS" (ChkSubn=1)
    *===========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lResultado, loc_cCpo
        loc_lResultado = .F.
        IF VARTYPE(par_cFiltro) <> "C"
            par_cFiltro = ""
        ENDIF
        TRY
            IF !USED("crSigSyCit")
                THIS.CarregarSigSyCit()
            ENDIF
            IF !USED("LocalCadRs")
                THIS.ApanhaRespostas()
            ENDIF
            DO CASE
                CASE UPPER(ALLTRIM(par_cFiltro)) = "PENDENTES"
                    loc_cWhere = " AND ChkSubn = 0"
                CASE UPPER(ALLTRIM(par_cFiltro)) = "BAIXADAS"
                    loc_cWhere = " AND ChkSubn = 1"
                OTHERWISE
                    loc_cWhere = ""
            ENDCASE
            loc_cSQL = "SELECT DISTINCT ChkSubn, ChkApro, Cods"
            IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
                SELECT crSigSyCit
                SCAN
                    IF crSigSyCit.Listas = 1
                        loc_cCpo = ALLTRIM(crSigSyCit.Campos)
                        DO CASE
                            CASE crSigSyCit.Tipos = "N"
                                loc_cSQL = loc_cSQL + ;
                                           ", CAST(9999999999.99 AS DECIMAL(14,2)) AS " + loc_cCpo
                            CASE crSigSyCit.Tipos = "M"
                                loc_cSQL = loc_cSQL + ", SPACE(50) AS " + loc_cCpo
                            OTHERWISE
                                loc_cSQL = loc_cSQL + ", SPACE(12) AS " + loc_cCpo
                        ENDCASE
                    ENDIF
                ENDSCAN
            ENDIF
            loc_cSQL = loc_cSQL + ;
                       " FROM SigSyCrs WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       loc_cWhere + " ORDER BY Cods"
            IF USED("crSigSyCrs")
                USE IN crSigSyCrs
            ENDIF
            *-- Test mode without DB: create empty cursor
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                SET NULL ON
                CREATE CURSOR crSigSyCrs (ChkSubn L, ChkApro L, Cods N(10,0))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigSyCrs")
                IF loc_nResult > 0
                    THIS.AlimentaLista()
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao carregar lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * GerarNovoCods - Gera proximo Cods disponivel para este Tits
    *===========================================================================
    FUNCTION GerarNovoCods()
        LOCAL loc_cSQL, loc_nCods, loc_nResult
        loc_nCods = 0
        TRY
            loc_cSQL = "SELECT ISNULL(MAX(Cods), 0) + 1 AS NextCods FROM SigSyCrs" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_NextCods")
                TABLEREVERT(.T., "cursor_4c_NextCods")
                USE IN cursor_4c_NextCods
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NextCods")
            IF loc_nResult > 0 AND !EOF("cursor_4c_NextCods")
                loc_nCods = cursor_4c_NextCods.NextCods
                USE IN cursor_4c_NextCods
            ELSE
                MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_NextCods")
                    USE IN cursor_4c_NextCods
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_nCods
    ENDFUNC

    *===========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *===========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCods    = TratarNulo(Cods, "N")
                THIS.this_lChkApro = (TratarNulo(ChkApro, "N") <> 0)
                THIS.this_lChkSubn = (TratarNulo(ChkSubn, "N") <> 0)
                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CarregarPorCodigo - Carrega propriedades do BO para um Cods especifico
    *===========================================================================
    FUNCTION CarregarPorCodigo(par_nCods)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !USED("LocalCadRs")
                THIS.ApanhaRespostas()
            ENDIF
            IF USED("LocalCadRs")
                THIS.this_nCods = par_nCods
                IF SEEK(STR(par_nCods, 6) + PADR("Emps", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cEmps = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cEmps = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Dopes", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cDopes = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cDopes = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Numes", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cNumes = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cNumes = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Aprova", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cAprova = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cAprova = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Datas", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cDatas = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cDatas = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Baixa", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cBaixa = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cBaixa = ""
                ENDIF
            ENDIF
            IF USED("crSigSyCrs")
                SELECT crSigSyCrs
                LOCATE FOR Cods = par_nCods
                IF !EOF("crSigSyCrs")
                    THIS.this_lChkApro = crSigSyCrs.ChkApro
                    THIS.this_lChkSubn = crSigSyCrs.ChkSubn
                    loc_lResultado = .T.
                ENDIF
            ELSE
                loc_cSQL = "SELECT TOP 1 ChkApro, ChkSubn FROM SigSyCrs" + ;
                           " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                           " AND Cods = " + FormatarNumeroSQL(par_nCods)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_CarregaFlags")
                    TABLEREVERT(.T., "cursor_4c_CarregaFlags")
                    USE IN cursor_4c_CarregaFlags
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaFlags")
                IF loc_nResult > 0 AND !EOF("cursor_4c_CarregaFlags")
                    THIS.this_lChkApro = (cursor_4c_CarregaFlags.ChkApro <> 0)
                    THIS.this_lChkSubn = (cursor_4c_CarregaFlags.ChkSubn <> 0)
                    loc_lResultado = .T.
                ENDIF
                IF USED("cursor_4c_CarregaFlags")
                    USE IN cursor_4c_CarregaFlags
                ENDIF
            ENDIF
            IF loc_lResultado
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * SalvarCampos - PRIVADO - Executa DELETE+INSERT de crGrvCadRs em SigSyCrs
    * Retorna .T. se salvou com sucesso
    *===========================================================================
    PROTECTED FUNCTION SalvarCampos()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_lTransacao
        loc_lResultado = .F.
        loc_lTransacao = .F.
        TRY
            IF SQLEXEC(gnConnHandle, "BEGIN TRANSACTION") >= 0
                loc_lTransacao = .T.
            ELSE
                MsgErro("Erro ao iniciar transa" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF loc_lTransacao
                loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                           EscaparSQL(THIS.this_cTits) + ;
                           " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    MsgErro("Erro ao excluir registros anteriores:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lTransacao = .F.
                ENDIF
            ENDIF
            IF loc_lTransacao AND USED("crGrvCadRs") AND RECCOUNT("crGrvCadRs") > 0
                SELECT crGrvCadRs
                SCAN WHILE loc_lTransacao
                    loc_cSQL = "INSERT INTO SigSyCrs" + ;
                               " (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro, ChkSubn)" + ;
                               " VALUES (" + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Tits)) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Campos)) + ", " + ;
                               FormatarNumeroSQL(crGrvCadRs.Cods) + ", " + ;
                               "CAST(NEWID() AS VARCHAR(38)), " + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Resps)) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Pergs)) + ", " + ;
                               IIF(crGrvCadRs.ChkApro, "1", "0") + ", " + ;
                               IIF(crGrvCadRs.ChkSubn, "1", "0") + ;
                               ")"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro("Erro ao inserir campo '" + ALLTRIM(crGrvCadRs.Campos) + ;
                                "':" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lTransacao = .F.
                    ENDIF
                ENDSCAN
            ENDIF
            IF loc_lTransacao
                IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") >= 0
                    loc_lTransacao = .F.
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro no commit:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                loc_lTransacao = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                loc_lTransacao = .F.
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Inserir - Salva novo registro (chamado por BusinessBase.Salvar)
    *===========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.SalvarCampos()
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Atualizar - Atualiza registro existente (chamado por BusinessBase.Salvar)
    * Usa padrao delete-insert identico ao original
    *===========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.SalvarCampos()
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * ExecutarExclusao - Exclui todos os campos de um registro logico (Tits+Cods)
    *===========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Aprovar - Aprova o registro atual (seta ChkApro=.T., grava Aprova/Datas)
    * par_cUsuario: nome do usuario que esta aprovando
    *===========================================================================
    FUNCTION Aprovar(par_cUsuario)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cDataHora
        loc_lResultado = .F.
        TRY
            loc_cDataHora = TTOC(DATETIME())
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods) + ;
                       " AND Campos IN ('Aprova', 'Datas')"
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "INSERT INTO SigSyCrs" + ;
                       " (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro, ChkSubn)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cTits) + ", 'Aprova', " + ;
                       FormatarNumeroSQL(THIS.this_nCods) + ", " + ;
                       "CAST(NEWID() AS VARCHAR(38)), " + ;
                       EscaparSQL(ALLTRIM(par_cUsuario)) + ", 'Aprovado', 1, 0)"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_cSQL = "INSERT INTO SigSyCrs" + ;
                           " (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro, ChkSubn)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cTits) + ", 'Datas', " + ;
                           FormatarNumeroSQL(THIS.this_nCods) + ", " + ;
                           "CAST(NEWID() AS VARCHAR(38)), " + ;
                           EscaparSQL(loc_cDataHora) + ", 'Data', 1, 0)"
                SQLEXEC(gnConnHandle, loc_cSQL)
                loc_cSQL = "UPDATE SigSyCrs SET ChkApro = 1" + ;
                           " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                           " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult >= 0
                    THIS.this_lChkApro = .T.
                    THIS.this_cAprova  = ALLTRIM(par_cUsuario)
                    THIS.this_cDatas   = loc_cDataHora
                    THIS.ApanhaRespostas()
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao aprovar registro:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao gravar aprovador:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Desaprovar - Remove aprovacao do registro atual (seta ChkApro=.F.)
    *===========================================================================
    FUNCTION Desaprovar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods) + ;
                       " AND Campos IN ('Aprova', 'Datas')"
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "UPDATE SigSyCrs SET ChkApro = 0" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.this_lChkApro = .F.
                THIS.this_cAprova  = ""
                THIS.this_cDatas   = ""
                THIS.ApanhaRespostas()
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao desaprovar registro:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CancelarBaixa - Cancela baixa do registro (seta ChkSubn=.F., remove campos de baixa)
    *===========================================================================
    FUNCTION CancelarBaixa(par_nCods)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(par_nCods) + ;
                       " AND Campos IN ('Emps', 'Dopes', 'Numes', 'Baixa')"
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "UPDATE SigSyCrs SET ChkSubn = 0" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(par_nCods)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.this_lChkSubn = .F.
                THIS.this_cEmps    = ""
                THIS.this_cDopes   = ""
                THIS.this_cNumes   = ""
                THIS.this_cBaixa   = ""
                THIS.ApanhaRespostas()
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao cancelar baixa:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

