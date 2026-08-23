# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'Ccusto' (parent: SIGCDOPE.Pagina.Lista): Top original=574 vs migrado 'cmd_4c_Ccusto' Top=54 (diff=520px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Ccusto' (parent: SIGCDOPE.Pagina.Lista): Left original=810 vs migrado 'cmd_4c_Ccusto' Left=463 (diff=347px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormOPE.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2519 linhas total):

*-- Linhas 54 a 63:
54:                 THIS.ConfigurarPageFrame()
55: 
56:                 WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
57:                     .lbl_4c_Sombra.Caption = THIS.Caption
58:                     .lbl_4c_Titulo.Caption = THIS.Caption
59:                     .Visible = .T.
60:                 ENDWITH
61: 
62:                 THIS.pgf_4c_Paginas.Visible   = .T.
63:                 THIS.pgf_4c_Paginas.ActivePage = 1

*-- Linhas 89 a 108:
89: 
90:         WITH THIS.pgf_4c_Paginas
91:             .PageCount = 2
92:             .Top       = -29
93:             .Left      = 0
94:             .Width     = THIS.Width
95:             .Height    = THIS.Height + 29
96:             .Tabs      = .F.
97:             .Visible   = .T.
98: 
99:             .Page1.Caption  = "Lista"
100:             .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page1.BackColor = RGB(255, 255, 255)
102: 
103:             .Page2.Caption  = "Dados"
104:             .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
105:             .Page2.BackColor = RGB(255, 255, 255)
106:         ENDWITH
107: 
108:         THIS.ConfigurarPaginaLista()

*-- Linhas 122 a 159:
122:         *-- Container Cabecalho (compensacao +29: Top=30)
123:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
124:         WITH loc_oPagina.cnt_4c_Cabecalho
125:             .Top       = 30
126:             .Left      = 0
127:             .Width     = THIS.Width
128:             .Height    = 80
129:             .BackColor = RGB(100, 100, 100)
130:             .BorderWidth = 0
131:             .Visible   = .T.
132:         ENDWITH
133: 
134:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
135:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
136:             .Caption   = THIS.Caption
137:             .Top       = 15
138:             .Left      = 10
139:             .Width     = THIS.Width - 20
140:             .Height    = 40
141:             .FontName  = "Tahoma"
142:             .FontSize  = 16
143:             .FontBold  = .T.
144:             .ForeColor = RGB(0, 0, 0)
145:             .BackStyle = 0
146:             .AutoSize  = .F.
147:             .Visible   = .T.
148:         ENDWITH
149: 
150:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
151:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
152:             .Caption   = THIS.Caption
153:             .Top       = 18
154:             .Left      = 10
155:             .Width     = THIS.Width - 20
156:             .Height    = 46
157:             .FontName  = "Tahoma"
158:             .FontSize  = 16
159:             .FontBold  = .T.

*-- Linhas 166 a 190:
166:         *-- Container Botoes CRUD (Left=542, Top=29, Width=385, Height=85)
167:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
168:         WITH loc_oPagina.cnt_4c_Botoes
169:             .Top       = 29
170:             .Left      = 542
171:             .Width     = 385
172:             .Height    = 85
173:             .BackStyle = 0
174:             .BorderWidth = 0
175:             .Visible   = .T.
176:         ENDWITH
177: 
178:         *-- Botao Incluir
179:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
180:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
181:             .Caption         = "Incluir"
182:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
183:             .PicturePosition = 13
184:             .Top             = 5
185:             .Left            = 5
186:             .Width           = 75
187:             .Height          = 75
188:             .FontName        = "Tahoma"
189:             .FontBold        = .T.
190:             .FontItalic      = .T.

*-- Linhas 198 a 215:
198:             .AutoSize        = .F.
199:             .Visible         = .T.
200:         ENDWITH
201:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
202: 
203:         *-- Botao Alterar
204:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
205:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
206:             .Caption         = "Alterar"
207:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
208:             .PicturePosition = 13
209:             .Top             = 5
210:             .Left            = 80
211:             .Width           = 75
212:             .Height          = 75
213:             .FontName        = "Tahoma"
214:             .FontBold        = .T.
215:             .FontItalic      = .T.

*-- Linhas 223 a 240:
223:             .AutoSize        = .F.
224:             .Visible         = .T.
225:         ENDWITH
226:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
227: 
228:         *-- Botao Visualizar
229:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
230:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
231:             .Caption         = "Visualizar"
232:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
233:             .PicturePosition = 13
234:             .Top             = 5
235:             .Left            = 155
236:             .Width           = 75
237:             .Height          = 75
238:             .FontName        = "Tahoma"
239:             .FontBold        = .T.
240:             .FontItalic      = .T.

*-- Linhas 248 a 265:
248:             .AutoSize        = .F.
249:             .Visible         = .T.
250:         ENDWITH
251:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
252: 
253:         *-- Botao Excluir
254:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
255:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
256:             .Caption         = "Excluir"
257:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
258:             .PicturePosition = 13
259:             .Top             = 5
260:             .Left            = 230
261:             .Width           = 75
262:             .Height          = 75
263:             .FontName        = "Tahoma"
264:             .FontBold        = .T.
265:             .FontItalic      = .T.

*-- Linhas 273 a 290:
273:             .AutoSize        = .F.
274:             .Visible         = .T.
275:         ENDWITH
276:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
277: 
278:         *-- Botao Buscar
279:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
280:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
281:             .Caption         = "Buscar"
282:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
283:             .PicturePosition = 13
284:             .Top             = 5
285:             .Left            = 305
286:             .Width           = 75
287:             .Height          = 75
288:             .FontName        = "Tahoma"
289:             .FontBold        = .T.
290:             .FontItalic      = .T.

*-- Linhas 298 a 326:
298:             .AutoSize        = .F.
299:             .Visible         = .T.
300:         ENDWITH
301:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
302: 
303:         *-- Container Saida (Encerrar) - PADRAO CANONICO (CLAUDE.md regra #10)
304:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
305:         WITH loc_oPagina.cnt_4c_Saida
306:             .Left      = 917
307:             .Top       = 29
308:             .Width     = 90
309:             .Height    = 85
310:             .BackStyle = 0
311:             .BorderWidth = 0
312:             .Visible   = .T.
313:         ENDWITH
314: 
315:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
316:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
317:             .Caption         = "Encerrar"
318:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
319:             .PicturePosition = 13
320:             .Top             = 5
321:             .Left            = 5
322:             .Width           = 75
323:             .Height          = 75
324:             .FontName        = "Tahoma"
325:             .FontBold        = .T.
326:             .FontItalic      = .T.

*-- Linhas 334 a 387:
334:             .AutoSize        = .F.
335:             .Visible         = .T.
336:         ENDWITH
337:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
338: 
339:         *-- Filtro optFilSituas (legado: optFilSituas Top=93, Left=11, Width=181, Height=25)
340:         *-- Compensacao +29: Top=122
341:         loc_oPagina.AddObject("opt_4c_FilSituas", "OptionGroup")
342:         WITH loc_oPagina.opt_4c_FilSituas
343:             .Top         = 122
344:             .Left        = 11
345:             .Width       = 181
346:             .Height      = 25
347:             .ButtonCount = 3
348:             .BackStyle   = 0
349:             .BorderStyle = 0
350:             .SpecialEffect = 1
351:             .Themes      = .F.
352:             .Value       = 1
353:             .Visible     = .T.
354:         ENDWITH
355:         WITH loc_oPagina.opt_4c_FilSituas
356:             .Buttons(1).Caption = "Todos"
357:             .Buttons(1).Left    = 0
358:             .Buttons(1).Top     = 0
359:             .Buttons(1).Width   = 60
360:             .Buttons(1).Height  = 25
361:             .Buttons(1).Themes  = .F.
362:             .Buttons(2).Caption = "Ativos"
363:             .Buttons(2).Left    = 60
364:             .Buttons(2).Top     = 0
365:             .Buttons(2).Width   = 60
366:             .Buttons(2).Height  = 25
367:             .Buttons(2).Themes  = .F.
368:             .Buttons(3).Caption = "Inativos"
369:             .Buttons(3).Left    = 120
370:             .Buttons(3).Top     = 0
371:             .Buttons(3).Width   = 61
372:             .Buttons(3).Height  = 25
373:             .Buttons(3).Themes  = .F.
374:         ENDWITH
375:         BINDEVENT(loc_oPagina.opt_4c_FilSituas, "InteractiveChange", THIS, "FiltroSituaClick")
376: 
377:         *-- Grid principal cursor_4c_Dados
378:         *-- Legado: Grade Top=127 (compensado +29 = 156), Left=5, Width=997, Height=441
379:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
380:         WITH loc_oPagina.grd_4c_Dados
381:             .Top         = 156
382:             .Left        = 5
383:             .Width       = 992
384:             .Height      = 410
385:             .ColumnCount = 2
386:             .DeleteMark  = .F.
387:             .RecordMark  = .F.

*-- Linhas 400 a 782:
400: 
401:         *-- Botoes de acao no topo (legado top=82, compensado +29 = 111)
402:         *-- btnExpXML (Exportar): left=519
403:         loc_oPagina.AddObject("cmd_4c_BtnExpXML", "CommandButton")
404:         WITH loc_oPagina.cmd_4c_BtnExpXML
405:             .Caption         = "Exportar"
406:             .Top             = 111
407:             .Left            = 519
408:             .Width           = 120
409:             .Height          = 40
410:             .FontName        = "Tahoma"
411:             .FontSize        = 8
412:             .FontBold        = .T.
413:             .ForeColor       = RGB(90, 90, 90)
414:             .BackColor       = RGB(255, 255, 255)
415:             .Themes          = .F.
416:             .SpecialEffect   = 0
417:             .Visible         = .T.
418:         ENDWITH
419:         BINDEVENT(loc_oPagina.cmd_4c_BtnExpXML, "Click", THIS, "BtnExpXMLClick")
420: 
421:         *-- btnImpXML (Importar): left=639
422:         loc_oPagina.AddObject("cmd_4c_BtnImpXML", "CommandButton")
423:         WITH loc_oPagina.cmd_4c_BtnImpXML
424:             .Caption         = "Importar"
425:             .Top             = 111
426:             .Left            = 639
427:             .Width           = 120
428:             .Height          = 40
429:             .FontName        = "Tahoma"
430:             .FontSize        = 8
431:             .FontBold        = .T.
432:             .ForeColor       = RGB(90, 90, 90)
433:             .BackColor       = RGB(255, 255, 255)
434:             .Themes          = .F.
435:             .SpecialEffect   = 0
436:             .Visible         = .T.
437:         ENDWITH
438:         BINDEVENT(loc_oPagina.cmd_4c_BtnImpXML, "Click", THIS, "BtnImpXMLClick")
439: 
440:         *-- CmdCopia (Copiar): left=759
441:         loc_oPagina.AddObject("cmd_4c_Copia", "CommandButton")
442:         WITH loc_oPagina.cmd_4c_Copia
443:             .Caption         = "Copiar"
444:             .Top             = 111
445:             .Left            = 759
446:             .Width           = 120
447:             .Height          = 40
448:             .FontName        = "Tahoma"
449:             .FontSize        = 8
450:             .FontBold        = .T.
451:             .ForeColor       = RGB(90, 90, 90)
452:             .BackColor       = RGB(255, 255, 255)
453:             .Themes          = .F.
454:             .SpecialEffect   = 0
455:             .Visible         = .T.
456:         ENDWITH
457:         BINDEVENT(loc_oPagina.cmd_4c_Copia, "Click", THIS, "BtnCopiaClick")
458: 
459:         *-- btnMapa (Mapa): left=879
460:         loc_oPagina.AddObject("cmd_4c_Mapa", "CommandButton")
461:         WITH loc_oPagina.cmd_4c_Mapa
462:             .Caption         = "Mapa"
463:             .Top             = 111
464:             .Left            = 879
465:             .Width           = 120
466:             .Height          = 40
467:             .FontName        = "Tahoma"
468:             .FontSize        = 8
469:             .FontBold        = .T.
470:             .ForeColor       = RGB(90, 90, 90)
471:             .BackColor       = RGB(255, 255, 255)
472:             .Themes          = .F.
473:             .SpecialEffect   = 0
474:             .Visible         = .T.
475:         ENDWITH
476:         BINDEVENT(loc_oPagina.cmd_4c_Mapa, "Click", THIS, "BtnMapaClick")
477: 
478:         *-- Botoes de acao inferiores (legado top=574, compensado +29 = 603)
479:         *-- Credito (Ger. Creditos): left=4
480:         loc_oPagina.AddObject("cmd_4c_Credito", "CommandButton")
481:         WITH loc_oPagina.cmd_4c_Credito
482:             .Caption     = "Ger. Cr" + CHR(233) + "ditos"
483:             .Top         = 603
484:             .Left        = 4
485:             .Width       = 62
486:             .Height      = 59
487:             .FontName    = "Tahoma"
488:             .FontSize    = 7
489:             .FontBold    = .T.
490:             .ForeColor   = RGB(90, 90, 90)
491:             .BackColor   = RGB(255, 255, 255)
492:             .Themes      = .F.
493:             .WordWrap    = .T.
494:             .SpecialEffect = 0
495:             .Visible     = .T.
496:         ENDWITH
497:         BINDEVENT(loc_oPagina.cmd_4c_Credito, "Click", THIS, "BtnCreditoClick")
498: 
499:         *-- Deprecia (Depreciacao): left=66
500:         loc_oPagina.AddObject("cmd_4c_Deprecia", "CommandButton")
501:         WITH loc_oPagina.cmd_4c_Deprecia
502:             .Caption     = "Deprecia" + CHR(231) + CHR(227) + "o"
503:             .Top         = 603
504:             .Left        = 66
505:             .Width       = 62
506:             .Height      = 59
507:             .FontName    = "Tahoma"
508:             .FontSize    = 7
509:             .FontBold    = .T.
510:             .ForeColor   = RGB(90, 90, 90)
511:             .BackColor   = RGB(255, 255, 255)
512:             .Themes      = .F.
513:             .WordWrap    = .T.
514:             .SpecialEffect = 0
515:             .Visible     = .T.
516:         ENDWITH
517:         BINDEVENT(loc_oPagina.cmd_4c_Deprecia, "Click", THIS, "BtnDepreciaClick")
518: 
519:         *-- cmdEtiquetas (Etiquetas): left=128
520:         loc_oPagina.AddObject("cmd_4c_Etiquetas", "CommandButton")
521:         WITH loc_oPagina.cmd_4c_Etiquetas
522:             .Caption     = "Etiquetas"
523:             .Top         = 603
524:             .Left        = 128
525:             .Width       = 62
526:             .Height      = 59
527:             .FontName    = "Tahoma"
528:             .FontSize    = 7
529:             .FontBold    = .T.
530:             .ForeColor   = RGB(90, 90, 90)
531:             .BackColor   = RGB(255, 255, 255)
532:             .Themes      = .F.
533:             .WordWrap    = .T.
534:             .SpecialEffect = 0
535:             .Visible     = .T.
536:         ENDWITH
537:         BINDEVENT(loc_oPagina.cmd_4c_Etiquetas, "Click", THIS, "BtnEtiquetasClick")
538: 
539:         *-- Transporte (Transportes): left=190
540:         loc_oPagina.AddObject("cmd_4c_Transporte", "CommandButton")
541:         WITH loc_oPagina.cmd_4c_Transporte
542:             .Caption     = "Transportes"
543:             .Top         = 603
544:             .Left        = 190
545:             .Width       = 62
546:             .Height      = 59
547:             .FontName    = "Tahoma"
548:             .FontSize    = 7
549:             .FontBold    = .T.
550:             .ForeColor   = RGB(90, 90, 90)
551:             .BackColor   = RGB(255, 255, 255)
552:             .Themes      = .F.
553:             .WordWrap    = .T.
554:             .SpecialEffect = 0
555:             .Visible     = .T.
556:         ENDWITH
557:         BINDEVENT(loc_oPagina.cmd_4c_Transporte, "Click", THIS, "BtnTransporteClick")
558: 
559:         *-- Frete (Fretes): left=252
560:         loc_oPagina.AddObject("cmd_4c_Frete", "CommandButton")
561:         WITH loc_oPagina.cmd_4c_Frete
562:             .Caption     = "Fretes"
563:             .Top         = 603
564:             .Left        = 252
565:             .Width       = 62
566:             .Height      = 59
567:             .FontName    = "Tahoma"
568:             .FontSize    = 7
569:             .FontBold    = .T.
570:             .ForeColor   = RGB(90, 90, 90)
571:             .BackColor   = RGB(255, 255, 255)
572:             .Themes      = .F.
573:             .WordWrap    = .T.
574:             .SpecialEffect = 0
575:             .Visible     = .T.
576:         ENDWITH
577:         BINDEVENT(loc_oPagina.cmd_4c_Frete, "Click", THIS, "BtnFreteClick")
578: 
579:         *-- Caixa (Sequencia Cx): left=314
580:         loc_oPagina.AddObject("cmd_4c_Caixa", "CommandButton")
581:         WITH loc_oPagina.cmd_4c_Caixa
582:             .Caption     = "Sequ" + CHR(234) + "ncia Cx"
583:             .Top         = 603
584:             .Left        = 314
585:             .Width       = 62
586:             .Height      = 59
587:             .FontName    = "Tahoma"
588:             .FontSize    = 7
589:             .FontBold    = .T.
590:             .ForeColor   = RGB(90, 90, 90)
591:             .BackColor   = RGB(255, 255, 255)
592:             .Themes      = .F.
593:             .WordWrap    = .T.
594:             .SpecialEffect = 0
595:             .Visible     = .T.
596:         ENDWITH
597:         BINDEVENT(loc_oPagina.cmd_4c_Caixa, "Click", THIS, "BtnCaixaClick")
598: 
599:         *-- TabDesconto (Tabelas): left=438
600:         loc_oPagina.AddObject("cmd_4c_TabDesconto", "CommandButton")
601:         WITH loc_oPagina.cmd_4c_TabDesconto
602:             .Caption     = "Tabelas"
603:             .Top         = 603
604:             .Left        = 438
605:             .Width       = 62
606:             .Height      = 59
607:             .FontName    = "Tahoma"
608:             .FontSize    = 7
609:             .FontBold    = .T.
610:             .ForeColor   = RGB(90, 90, 90)
611:             .BackColor   = RGB(255, 255, 255)
612:             .Themes      = .F.
613:             .WordWrap    = .T.
614:             .SpecialEffect = 0
615:             .Visible     = .T.
616:         ENDWITH
617:         BINDEVENT(loc_oPagina.cmd_4c_TabDesconto, "Click", THIS, "BtnTabDescontoClick")
618: 
619:         *-- MontaLista (Monta Grade): left=500
620:         loc_oPagina.AddObject("cmd_4c_MontaLista", "CommandButton")
621:         WITH loc_oPagina.cmd_4c_MontaLista
622:             .Caption     = "Monta Grade"
623:             .Top         = 603
624:             .Left        = 500
625:             .Width       = 62
626:             .Height      = 59
627:             .FontName    = "Tahoma"
628:             .FontSize    = 7
629:             .FontBold    = .T.
630:             .ForeColor   = RGB(90, 90, 90)
631:             .BackColor   = RGB(255, 255, 255)
632:             .Themes      = .F.
633:             .WordWrap    = .T.
634:             .SpecialEffect = 0
635:             .Visible     = .T.
636:         ENDWITH
637:         BINDEVENT(loc_oPagina.cmd_4c_MontaLista, "Click", THIS, "BtnMontaListaClick")
638: 
639:         *-- CmdTrf (Automaticas): left=562
640:         loc_oPagina.AddObject("cmd_4c_Trf", "CommandButton")
641:         WITH loc_oPagina.cmd_4c_Trf
642:             .Caption     = "Autom" + CHR(225) + "ticas"
643:             .Top         = 603
644:             .Left        = 562
645:             .Width       = 62
646:             .Height      = 59
647:             .FontName    = "Tahoma"
648:             .FontSize    = 7
649:             .FontBold    = .T.
650:             .ForeColor   = RGB(90, 90, 90)
651:             .BackColor   = RGB(255, 255, 255)
652:             .Themes      = .F.
653:             .WordWrap    = .T.
654:             .SpecialEffect = 0
655:             .Visible     = .T.
656:         ENDWITH
657:         BINDEVENT(loc_oPagina.cmd_4c_Trf, "Click", THIS, "BtnTrfClick")
658: 
659:         *-- cmdMultiSubN (Multiplos): left=624
660:         loc_oPagina.AddObject("cmd_4c_MultiSubN", "CommandButton")
661:         WITH loc_oPagina.cmd_4c_MultiSubN
662:             .Caption     = "M" + CHR(250) + "ltiplos"
663:             .Top         = 603
664:             .Left        = 624
665:             .Width       = 62
666:             .Height      = 59
667:             .FontName    = "Tahoma"
668:             .FontSize    = 7
669:             .FontBold    = .T.
670:             .ForeColor   = RGB(90, 90, 90)
671:             .BackColor   = RGB(255, 255, 255)
672:             .Themes      = .F.
673:             .WordWrap    = .T.
674:             .SpecialEffect = 0
675:             .Visible     = .T.
676:         ENDWITH
677:         BINDEVENT(loc_oPagina.cmd_4c_MultiSubN, "Click", THIS, "BtnMultiSubNClick")
678: 
679:         *-- SubNivel2 (Subnivel +): left=686
680:         loc_oPagina.AddObject("cmd_4c_SubNivel2", "CommandButton")
681:         WITH loc_oPagina.cmd_4c_SubNivel2
682:             .Caption     = "Subn" + CHR(237) + "vel (+)"
683:             .Top         = 603
684:             .Left        = 686
685:             .Width       = 62
686:             .Height      = 59
687:             .FontName    = "Tahoma"
688:             .FontSize    = 7
689:             .FontBold    = .T.
690:             .ForeColor   = RGB(90, 90, 90)
691:             .BackColor   = RGB(255, 255, 255)
692:             .Themes      = .F.
693:             .WordWrap    = .T.
694:             .SpecialEffect = 0
695:             .Visible     = .T.
696:         ENDWITH
697:         BINDEVENT(loc_oPagina.cmd_4c_SubNivel2, "Click", THIS, "BtnSubNivel2Click")
698: 
699:         *-- Multiplas (Subnivel -): left=748
700:         loc_oPagina.AddObject("cmd_4c_Multiplas", "CommandButton")
701:         WITH loc_oPagina.cmd_4c_Multiplas
702:             .Caption     = "Subn" + CHR(237) + "vel (-)"
703:             .Top         = 603
704:             .Left        = 748
705:             .Width       = 62
706:             .Height      = 59
707:             .FontName    = "Tahoma"
708:             .FontSize    = 7
709:             .FontBold    = .T.
710:             .ForeColor   = RGB(90, 90, 90)
711:             .BackColor   = RGB(255, 255, 255)
712:             .Themes      = .F.
713:             .WordWrap    = .T.
714:             .SpecialEffect = 0
715:             .Visible     = .T.
716:         ENDWITH
717:         BINDEVENT(loc_oPagina.cmd_4c_Multiplas, "Click", THIS, "BtnMultiplasClick")
718: 
719:         *-- Ccusto (C.C.): left=810
720:         loc_oPagina.AddObject("cmd_4c_Ccusto", "CommandButton")
721:         WITH loc_oPagina.cmd_4c_Ccusto
722:             .Caption     = "C.C."
723:             .Top         = 603
724:             .Left        = 810
725:             .Width       = 62
726:             .Height      = 59
727:             .FontName    = "Tahoma"
728:             .FontSize    = 7
729:             .FontBold    = .T.
730:             .ForeColor   = RGB(90, 90, 90)
731:             .BackColor   = RGB(255, 255, 255)
732:             .Themes      = .F.
733:             .WordWrap    = .T.
734:             .SpecialEffect = 0
735:             .Visible     = .T.
736:         ENDWITH
737:         BINDEVENT(loc_oPagina.cmd_4c_Ccusto, "Click", THIS, "BtnCcustoClick")
738: 
739:         *-- GrupoConta (Grupo/Conta): left=872
740:         loc_oPagina.AddObject("cmd_4c_GrupoConta", "CommandButton")
741:         WITH loc_oPagina.cmd_4c_GrupoConta
742:             .Caption     = "Grupo/Conta"
743:             .Top         = 603
744:             .Left        = 872
745:             .Width       = 62
746:             .Height      = 59
747:             .FontName    = "Tahoma"
748:             .FontSize    = 7
749:             .FontBold    = .T.
750:             .ForeColor   = RGB(90, 90, 90)
751:             .BackColor   = RGB(255, 255, 255)
752:             .Themes      = .F.
753:             .WordWrap    = .T.
754:             .SpecialEffect = 0
755:             .Visible     = .T.
756:         ENDWITH
757:         BINDEVENT(loc_oPagina.cmd_4c_GrupoConta, "Click", THIS, "BtnGrupoContaClick")
758: 
759:         *-- Status: left=934
760:         loc_oPagina.AddObject("cmd_4c_Status", "CommandButton")
761:         WITH loc_oPagina.cmd_4c_Status
762:             .Caption     = "Status"
763:             .Top         = 603
764:             .Left        = 934
765:             .Width       = 62
766:             .Height      = 59
767:             .FontName    = "Tahoma"
768:             .FontSize    = 7
769:             .FontBold    = .T.
770:             .ForeColor   = RGB(90, 90, 90)
771:             .BackColor   = RGB(255, 255, 255)
772:             .Themes      = .F.
773:             .WordWrap    = .T.
774:             .SpecialEffect = 0
775:             .Visible     = .T.
776:         ENDWITH
777:         BINDEVENT(loc_oPagina.cmd_4c_Status, "Click", THIS, "BtnStatusClick")
778: 
779:         THIS.TornarControlesVisiveis(loc_oPagina)
780:     ENDPROC
781: 
782:     *==========================================================================

*-- Linhas 792 a 816:
792:         *-- Container Salvar/Cancelar (legado: Grupo_Salva Top=-2, Left=840; canonico Top=27)
793:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
794:         WITH loc_oPagina.cnt_4c_Salva
795:             .Top       = 27
796:             .Left      = 840
797:             .Width     = 160
798:             .Height    = 85
799:             .BackStyle = 1
800:             .BackColor = RGB(255, 255, 255)
801:             .BorderWidth = 0
802:             .Visible   = .T.
803:         ENDWITH
804: 
805:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
806:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
807:             .Caption         = "Confirmar"
808:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
809:             .PicturePosition = 13
810:             .Top             = 5
811:             .Left            = 5
812:             .Width           = 75
813:             .Height          = 75
814:             .FontName        = "Tahoma"
815:             .FontBold        = .T.
816:             .FontItalic      = .T.

*-- Linhas 824 a 840:
824:             .AutoSize        = .F.
825:             .Visible         = .T.
826:         ENDWITH
827:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
828: 
829:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
830:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
831:             .Caption         = "Encerrar"
832:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
833:             .PicturePosition = 13
834:             .Top             = 5
835:             .Left            = 80
836:             .Width           = 75
837:             .Height          = 75
838:             .FontName        = "Tahoma"
839:             .FontBold        = .T.
840:             .FontItalic      = .T.

*-- Linhas 848 a 867:
848:             .AutoSize        = .F.
849:             .Visible         = .T.
850:         ENDWITH
851:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
852: 
853:         *-- Cabecalho de identificacao da operacao (acima do PagDados)
854:         *-- Legado: campos no topo da Page2 (top < 130) sem container explicito
855:         *-- Compensacao +29: tops originais + 29
856: 
857:         *-- Label "Codigo :" (Say1 legado: top=7)
858:         loc_oPagina.AddObject("lbl_4c_LCodigo", "Label")
859:         WITH loc_oPagina.lbl_4c_LCodigo
860:             .Caption   = "C" + CHR(243) + "digo :"
861:             .Top       = 36
862:             .Left      = 30
863:             .Width     = 50
864:             .Height    = 15
865:             .FontName  = "Tahoma"
866:             .FontSize  = 8
867:             .FontBold  = .T.

*-- Linhas 875 a 884:
875:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
876:         WITH loc_oPagina.txt_4c_Codigo
877:             .Value         = ""
878:             .Top           = 32
879:             .Left          = 73
880:             .Width         = 179
881:             .Height        = 23
882:             .FontName      = "Tahoma"
883:             .FontSize      = 8
884:             .MaxLength     = 20

*-- Linhas 890 a 902:
890:         ENDWITH
891: 
892:         *-- Label "Descricao :" (Say28 legado: top=32)
893:         loc_oPagina.AddObject("lbl_4c_LDescricao", "Label")
894:         WITH loc_oPagina.lbl_4c_LDescricao
895:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
896:             .Top       = 61
897:             .Left      = 17
898:             .Width     = 55
899:             .Height    = 15
900:             .FontName  = "Tahoma"
901:             .FontSize  = 8
902:             .FontBold  = .T.

*-- Linhas 911 a 920:
911:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
912:         WITH loc_oPagina.txt_4c_Descricao
913:             .Value         = ""
914:             .Top           = 57
915:             .Left          = 73
916:             .Width         = 250
917:             .Height        = 23
918:             .FontName      = "Tahoma"
919:             .FontSize      = 8
920:             .MaxLength     = 30

*-- Linhas 926 a 938:
926:         ENDWITH
927: 
928:         *-- Label "Menu :" (menus char(10))
929:         loc_oPagina.AddObject("lbl_4c_LMenu", "Label")
930:         WITH loc_oPagina.lbl_4c_LMenu
931:             .Caption   = "Menu :"
932:             .Top       = 86
933:             .Left      = 37
934:             .Width     = 35
935:             .Height    = 15
936:             .FontName  = "Tahoma"
937:             .FontSize  = 8
938:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 945 a 954:
945:         loc_oPagina.AddObject("cbo_4c_Menu", "ComboBox")
946:         WITH loc_oPagina.cbo_4c_Menu
947:             .Value         = ""
948:             .Top           = 82
949:             .Left          = 73
950:             .Width         = 150
951:             .Height        = 23
952:             .RowSourceType = 1
953:             .RowSource     = ",SISTEMA,OPERACIONA,CAIXA"
954:             .Style         = 2

*-- Linhas 961 a 973:
961:         ENDWITH
962: 
963:         *-- Label "Tipo :" (Say4 legado: top=32, left=295)
964:         loc_oPagina.AddObject("lbl_4c_LTipo", "Label")
965:         WITH loc_oPagina.lbl_4c_LTipo
966:             .Caption   = "Tipo :"
967:             .Top       = 61
968:             .Left      = 295
969:             .Width     = 29
970:             .Height    = 15
971:             .FontName  = "Tahoma"
972:             .FontSize  = 8
973:             .FontBold  = .T.

*-- Linhas 981 a 990:
981:         loc_oPagina.AddObject("txt_4c_Tipo", "TextBox")
982:         WITH loc_oPagina.txt_4c_Tipo
983:             .Value         = ""
984:             .Top           = 57
985:             .Left          = 325
986:             .Width         = 100
987:             .Height        = 23
988:             .FontName      = "Tahoma"
989:             .FontSize      = 8
990:             .MaxLength     = 10

*-- Linhas 999 a 1032:
999:         *-- Compensacao +29: top=159
1000:         loc_oPagina.AddObject("pgf_4c_PagDados", "PageFrame")
1001:         WITH loc_oPagina.pgf_4c_PagDados
1002:             .Top       = 159
1003:             .Left      = 0
1004:             .Width     = THIS.Width
1005:             .Height    = THIS.Height + 29 - 159
1006:             .PageCount = 18
1007:             .Tabs      = .T.
1008:             .Visible   = .T.
1009:             *-- Captions das 18 abas (Fase A: stubs)
1010:             .Page1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
1011:             .Page2.Caption  = "Itens"
1012:             .Page3.Caption  = "Financeiro"
1013:             .Page4.Caption  = "Fiscal"
1014:             .Page5.Caption  = "Documento"
1015:             .Page6.Caption  = "Pre" + CHR(231) + "o"
1016:             .Page7.Caption  = "Div"
1017:             .Page8.Caption  = "Diversos"
1018:             .Page9.Caption  = "Subn" + CHR(237) + "vel"
1019:             .Page10.Caption = "Estoque"
1020:             .Page11.Caption = "Boleto"
1021:             .Page12.Caption = "Config. Fin."
1022:             .Page13.Caption = "Invoices"
1023:             .Page14.Caption = "Div2"
1024:             .Page15.Caption = "Itens2"
1025:             .Page16.Caption = "Jobs"
1026:             .Page17.Caption = "Comiss" + CHR(227) + "o"
1027:             .Page18.Caption = "T" + CHR(237) + "tulos"
1028:         ENDWITH
1029: 
1030:         *-- Fase C: Popular paginas internas com controles
1031:         THIS.ConfigurarPagOperacao(loc_oPagina.pgf_4c_PagDados.Page1)
1032:         THIS.ConfigurarPagItens(loc_oPagina.pgf_4c_PagDados.Page2)

*-- Linhas 1114 a 1123:
1114:                         loc_oGrid.RecordSource          = "cursor_4c_Dados"
1115:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.dopes"
1116:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.titopes"
1117:                         loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1118:                         loc_oGrid.Column2.Header1.Caption = "Origem dos Valores a Serem Lan" + CHR(231) + "ados na Movimenta" + CHR(231) + CHR(227) + "o Financeira"
1119:                         THIS.FormatarGridLista(loc_oGrid)
1120:                     ENDIF
1121:                     SELECT cursor_4c_Dados
1122:                     GO TOP
1123:                 ENDIF

*-- Linhas 1814 a 1822:
1814:                     IF PEMSTATUS(loc_oObj, "ReadOnly", 5)
1815:                         loc_oObj.ReadOnly = !par_lHabilitar
1816:                     ENDIF
1817:                 CASE loc_cCls = "CHECKBOX" OR loc_cCls = "OPTIONGROUP" OR loc_cCls = "COMBOBOX" OR loc_cCls = "SPINNER"
1818:                     IF PEMSTATUS(loc_oObj, "Enabled", 5)
1819:                         loc_oObj.Enabled = par_lHabilitar
1820:                     ENDIF
1821:                 CASE loc_cCls = "PAGEFRAME"
1822:                     FOR loc_nP = 1 TO loc_oObj.PageCount

*-- Linhas 1881 a 1889:
1881:                             loc_oObj.Value = ""
1882:                         ENDIF
1883:                     ENDIF
1884:                 CASE loc_cCls = "CHECKBOX"
1885:                     loc_oObj.Value = 0
1886:                 CASE loc_cCls = "OPTIONGROUP"
1887:                     loc_oObj.Value = 1
1888:                 CASE loc_cCls = "COMBOBOX"
1889:                     loc_oObj.Value = ""

*-- Linhas 1988 a 1998:
1988:     PROTECTED PROCEDURE AddLabel(par_oPag, par_cName, par_cCaption, par_nTop, par_nLeft, par_nWidth)
1989:         par_oPag.AddObject(par_cName, "Label")
1990:         WITH EVALUATE("par_oPag." + par_cName)
1991:             .Caption   = par_cCaption
1992:             .Top       = par_nTop
1993:             .Left      = par_nLeft
1994:             .Width     = par_nWidth
1995:             .Height    = 15
1996:             .FontName  = "Tahoma"
1997:             .FontSize  = 8
1998:             .BackStyle = 0

*-- Linhas 2006 a 2015:
2006:         par_oPag.AddObject(par_cName, "TextBox")
2007:         WITH EVALUATE("par_oPag." + par_cName)
2008:             .Value         = ""
2009:             .Top           = par_nTop
2010:             .Left          = par_nLeft
2011:             .Width         = par_nWidth
2012:             .Height        = 20
2013:             .FontName      = "Tahoma"
2014:             .FontSize      = 8
2015:             .MaxLength     = par_nMaxLen

*-- Linhas 2021 a 2034:
2021:         ENDWITH
2022:     ENDPROC
2023: 
2024:     PROTECTED PROCEDURE AddCheckBox(par_oPag, par_cName, par_cCaption, par_nTop, par_nLeft, par_nWidth)
2025:         par_oPag.AddObject(par_cName, "CheckBox")
2026:         WITH EVALUATE("par_oPag." + par_cName)
2027:             .Caption   = par_cCaption
2028:             .Top       = par_nTop
2029:             .Left      = par_nLeft
2030:             .Width     = par_nWidth
2031:             .Height    = 17
2032:             .FontName  = "Tahoma"
2033:             .FontSize  = 8
2034:             .BackStyle = 0

*-- Linhas 2047 a 2076:
2047:             .BackStyle     = 0
2048:             .BorderStyle   = 1
2049:             .SpecialEffect = 1
2050:             .Top           = par_nTop
2051:             .Left          = par_nLeft
2052:             .Width         = par_nWidth
2053:             .Height        = 22
2054:             .Value         = 1
2055:             .Themes        = .F.
2056:             .Buttons(1).Caption   = "Sim"
2057:             .Buttons(1).FontName  = "Tahoma"
2058:             .Buttons(1).FontSize  = 8
2059:             .Buttons(1).BackStyle = 0
2060:             .Buttons(1).Top       = 3
2061:             .Buttons(1).Left      = 5
2062:             .Buttons(1).Width     = 45
2063:             .Buttons(1).Height    = 17
2064:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2065:             .Buttons(1).AutoSize  = .F.
2066:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2067:             .Buttons(2).FontName  = "Tahoma"
2068:             .Buttons(2).FontSize  = 8
2069:             .Buttons(2).BackStyle = 0
2070:             .Buttons(2).Top       = 3
2071:             .Buttons(2).Left      = 60
2072:             .Buttons(2).Width     = 45
2073:             .Buttons(2).Height    = 17
2074:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2075:             .Buttons(2).AutoSize  = .F.
2076:             .Visible = .T.

*-- Linhas 2083 a 2232:
2083:     PROTECTED PROCEDURE ConfigurarPagOperacao(par_oPagina)
2084:         TRY
2085:             *-- Numeracao label
2086:             THIS.AddLabel(par_oPagina, "lbl_4c_Numeracao", "Numera" + CHR(231) + CHR(227) + "o :", 11, 78, 63)
2087:             *-- Bloqueio de alterar data (OptionGroup 4 botoes)
2088:             THIS.AddLabel(par_oPagina, "lbl_4c_BlqDt", "Bloq. Alterar Data :", 45, 46, 95)
2089:             par_oPagina.AddObject("opt_4c_Blqdt", "OptionGroup")
2090:             WITH par_oPagina.opt_4c_Blqdt
2091:                 .ButtonCount   = 4
2092:                 .BackStyle     = 0
2093:                 .BorderStyle   = 1
2094:                 .SpecialEffect = 1
2095:                 .Top           = 43
2096:                 .Left          = 145
2097:                 .Width         = 248
2098:                 .Height        = 32
2099:                 .Value         = 1
2100:                 .Themes        = .F.
2101:                 .Buttons(1).Caption = "Sim"
2102:                 .Buttons(1).Value   = 1
2103:                 .Buttons(1).Top     = 2
2104:                 .Buttons(1).Left    = 5
2105:                 .Buttons(1).Width   = 40
2106:                 .Buttons(1).Height  = 17
2107:                 .Buttons(1).BackStyle = 0
2108:                 .Buttons(1).FontName  = "Tahoma"
2109:                 .Buttons(1).FontSize  = 8
2110:                 .Buttons(1).ForeColor = RGB(90, 90, 90)
2111:                 .Buttons(1).AutoSize  = .F.
2112:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
2113:                 .Buttons(2).Top     = 15
2114:                 .Buttons(2).Left    = 5
2115:                 .Buttons(2).Width   = 40
2116:                 .Buttons(2).Height  = 17
2117:                 .Buttons(2).BackStyle = 0
2118:                 .Buttons(2).FontName  = "Tahoma"
2119:                 .Buttons(2).FontSize  = 8
2120:                 .Buttons(2).ForeColor = RGB(90, 90, 90)
2121:                 .Buttons(2).AutoSize  = .F.
2122:                 .Buttons(3).Caption = "Subn" + CHR(237) + "vel Sim"
2123:                 .Buttons(3).Top     = 2
2124:                 .Buttons(3).Left    = 110
2125:                 .Buttons(3).Width   = 100
2126:                 .Buttons(3).Height  = 15
2127:                 .Buttons(3).BackStyle = 0
2128:                 .Buttons(3).FontName  = "Tahoma"
2129:                 .Buttons(3).FontSize  = 8
2130:                 .Buttons(3).ForeColor = RGB(90, 90, 90)
2131:                 .Buttons(3).AutoSize  = .T.
2132:                 .Buttons(4).Caption = "Subn" + CHR(237) + "vel N" + CHR(227) + "o"
2133:                 .Buttons(4).Top     = 15
2134:                 .Buttons(4).Left    = 110
2135:                 .Buttons(4).Width   = 100
2136:                 .Buttons(4).Height  = 15
2137:                 .Buttons(4).BackStyle = 0
2138:                 .Buttons(4).FontName  = "Tahoma"
2139:                 .Buttons(4).FontSize  = 8
2140:                 .Buttons(4).ForeColor = RGB(90, 90, 90)
2141:                 .Buttons(4).AutoSize  = .T.
2142:                 .Visible = .T.
2143:             ENDWITH
2144:             BINDEVENT(par_oPagina.opt_4c_Blqdt, "InteractiveChange", THIS, "OptBlqdtChange")
2145: 
2146:             *-- Conferencia (S/N)
2147:             THIS.AddLabel(par_oPagina, "lbl_4c_Conf", "Confer" + CHR(234) + "ncia :", 181, 74, 67)
2148:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Conf", 179, 145, 248)
2149: 
2150:             *-- Verificar Bloqueio (Aciosens)
2151:             THIS.AddLabel(par_oPagina, "lbl_4c_VerBlq", "Verificar Bloqueio :", 221, 516, 91)
2152:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Bloqueio", 219, 611, 175)
2153: 
2154:             *-- Transferencia de Saida
2155:             THIS.AddLabel(par_oPagina, "lbl_4c_MovSai", "Movimenta" + CHR(231) + CHR(227) + "o de Sa" + CHR(237) + "da :", 309, 340, 145)
2156:             THIS.AddTextBox(par_oPagina, "txt_4c_DopeSTrfs", 306, 486, 150, 20)
2157: 
2158:             *-- Movimentacao de Entrada
2159:             THIS.AddLabel(par_oPagina, "lbl_4c_MovEnt", "Movimenta" + CHR(231) + CHR(227) + "o de Entrada :", 331, 340, 145)
2160:             THIS.AddTextBox(par_oPagina, "txt_4c_DopeETrfs", 328, 486, 150, 20)
2161: 
2162:             *-- Central
2163:             THIS.AddLabel(par_oPagina, "lbl_4c_Central", "Central :", 258, 90, 50)
2164:             THIS.AddTextBox(par_oPagina, "txt_4c_Central", 255, 145, 50, 2)
2165: 
2166:             *-- Empresa Padrao
2167:             THIS.AddLabel(par_oPagina, "lbl_4c_EmpPad", "Empresa Padr" + CHR(227) + "o :", 388, 60, 80)
2168:             THIS.AddTextBox(par_oPagina, "txt_4c_EmpPad", 385, 145, 50, 3)
2169: 
2170:             *-- CheckBoxes
2171:             THIS.AddCheckBox(par_oPagina, "chk_4c_CarESubN", "Carregar E-Subn" + CHR(237) + "vel", 415, 145, 180)
2172:             THIS.AddCheckBox(par_oPagina, "chk_4c_VincEstM", "Vincular Est. Mestre", 435, 145, 180)
2173: 
2174:             *-- Tipo (Opers)
2175:             THIS.AddLabel(par_oPagina, "lbl_4c_Tipo1", "Tipo :", 460, 100, 45)
2176:             par_oPagina.AddObject("opt_4c_Tipo", "OptionGroup")
2177:             WITH par_oPagina.opt_4c_Tipo
2178:                 .ButtonCount   = 3
2179:                 .BackStyle     = 0
2180:                 .BorderStyle   = 1
2181:                 .SpecialEffect = 1
2182:                 .Top           = 458
2183:                 .Left          = 145
2184:                 .Width         = 250
2185:                 .Height        = 22
2186:                 .Value         = 1
2187:                 .Themes        = .F.
2188:                 .Buttons(1).Caption = "Sa" + CHR(237) + "da"
2189:                 .Buttons(1).Value   = 1
2190:                 .Buttons(1).Top     = 3
2191:                 .Buttons(1).Left    = 5
2192:                 .Buttons(1).Width   = 60
2193:                 .Buttons(1).BackStyle = 0
2194:                 .Buttons(1).FontName  = "Tahoma"
2195:                 .Buttons(1).FontSize  = 8
2196:                 .Buttons(1).ForeColor = RGB(90, 90, 90)
2197:                 .Buttons(2).Caption = "Entrada"
2198:                 .Buttons(2).Top     = 3
2199:                 .Buttons(2).Left    = 70
2200:                 .Buttons(2).Width   = 60
2201:                 .Buttons(2).BackStyle = 0
2202:                 .Buttons(2).FontName  = "Tahoma"
2203:                 .Buttons(2).FontSize  = 8
2204:                 .Buttons(2).ForeColor = RGB(90, 90, 90)
2205:                 .Buttons(3).Caption = "Nenhum"
2206:                 .Buttons(3).Top     = 3
2207:                 .Buttons(3).Left    = 140
2208:                 .Buttons(3).Width   = 60
2209:                 .Buttons(3).BackStyle = 0
2210:                 .Buttons(3).FontName  = "Tahoma"
2211:                 .Buttons(3).FontSize  = 8
2212:                 .Buttons(3).ForeColor = RGB(90, 90, 90)
2213:                 .Visible = .T.
2214:             ENDWITH
2215:             BINDEVENT(par_oPagina.opt_4c_Tipo, "InteractiveChange", THIS, "OptTipoChange")
2216: 
2217:             *-- Caixa
2218:             THIS.AddLabel(par_oPagina, "lbl_4c_Cai", "Caixa :", 490, 100, 45)
2219:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Cai", 488, 145, 120)
2220: 
2221:             *-- Observacao (EditBox)
2222:             THIS.AddLabel(par_oPagina, "lbl_4c_ObsOpe", "Observa" + CHR(231) + CHR(245) + "es :", 520, 60, 80)
2223:             par_oPagina.AddObject("mem_4c_ObsOpe", "EditBox")
2224:             WITH par_oPagina.mem_4c_ObsOpe
2225:                 .Value       = ""
2226:                 .Top         = 518
2227:                 .Left        = 145
2228:                 .Width       = 640
2229:                 .Height      = 60
2230:                 .FontName    = "Tahoma"
2231:                 .FontSize    = 8
2232:                 .BackColor   = RGB(255, 255, 255)

*-- Linhas 2248 a 2271:
2248:     *==========================================================================
2249:     PROTECTED PROCEDURE ConfigurarPagItens(par_oPagina)
2250:         TRY
2251:             THIS.AddLabel(par_oPagina, "lbl_4c_CBar", "C" + CHR(243) + "d. Barras :", 20, 30, 80)
2252:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Cbar", 18, 120, 120)
2253: 
2254:             THIS.AddLabel(par_oPagina, "lbl_4c_Imagem", "Imagem :", 50, 30, 80)
2255:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Imagem", 48, 120, 120)
2256: 
2257:             THIS.AddLabel(par_oPagina, "lbl_4c_ObsItems", "Obs. Itens :", 80, 30, 80)
2258:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_ObsItems", 78, 120, 120)
2259: 
2260:             THIS.AddLabel(par_oPagina, "lbl_4c_Desmemb", "Desmembra :", 110, 30, 80)
2261:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Desmemb", 108, 120, 120)
2262: 
2263:             THIS.AddLabel(par_oPagina, "lbl_4c_ChkQtds", "Check Qtd :", 140, 30, 80)
2264:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_ChkQtds", 138, 120, 120)
2265: 
2266:             THIS.AddLabel(par_oPagina, "lbl_4c_QtdIte", "Qtde. Itens :", 175, 30, 80)
2267:             THIS.AddTextBox(par_oPagina, "txt_4c_QtdIte", 172, 120, 60, 4)
2268: 
2269:         CATCH TO loc_oErro
2270:             MsgErro(loc_oErro.Message + CHR(13) + ;
2271:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;

*-- Linhas 2278 a 2307:
2278:     *==========================================================================
2279:     PROTECTED PROCEDURE ConfigurarPagFinanceiro(par_oPagina)
2280:         TRY
2281:             THIS.AddLabel(par_oPagina, "lbl_4c_Che", "Cheque :", 20, 30, 80)
2282:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Che", 18, 120, 120)
2283: 
2284:             THIS.AddLabel(par_oPagina, "lbl_4c_Contas", "Contas :", 50, 30, 80)
2285:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Contas", 48, 120, 120)
2286: 
2287:             THIS.AddLabel(par_oPagina, "lbl_4c_LimCre", "Lim. Cr" + CHR(233) + "dito :", 80, 30, 80)
2288:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_LimCre", 78, 120, 120)
2289: 
2290:             THIS.AddLabel(par_oPagina, "lbl_4c_Troco", "Troco Auto :", 110, 30, 80)
2291:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Troco", 108, 120, 120)
2292: 
2293:             THIS.AddLabel(par_oPagina, "lbl_4c_OpChqEnt", "Op. Cheq. Entr. :", 145, 30, 100)
2294:             THIS.AddTextBox(par_oPagina, "txt_4c_OpChqEnt", 142, 145, 150, 15)
2295: 
2296:             THIS.AddLabel(par_oPagina, "lbl_4c_OpChqSai", "Op. Cheq. Sa" + CHR(237) + "da :", 175, 30, 100)
2297:             THIS.AddTextBox(par_oPagina, "txt_4c_OpChqSai", 172, 145, 150, 15)
2298: 
2299:             THIS.AddLabel(par_oPagina, "lbl_4c_Conta", "Conta :", 205, 30, 60)
2300:             THIS.AddTextBox(par_oPagina, "txt_4c_Conta", 202, 145, 100, 10)
2301: 
2302:             THIS.AddLabel(par_oPagina, "lbl_4c_Grupo", "Grupo :", 235, 30, 60)
2303:             THIS.AddTextBox(par_oPagina, "txt_4c_Grupo", 232, 145, 100, 10)
2304: 
2305:         CATCH TO loc_oErro
2306:             MsgErro(loc_oErro.Message + CHR(13) + ;
2307:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;

*-- Linhas 2314 a 2360:
2314:     *==========================================================================
2315:     PROTECTED PROCEDURE ConfigurarPagFiscal(par_oPagina)
2316:         TRY
2317:             THIS.AddLabel(par_oPagina, "lbl_4c_Especies", "Esp" + CHR(233) + "cie :", 20, 30, 60)
2318:             THIS.AddTextBox(par_oPagina, "txt_4c_Especies", 17, 120, 80, 6)
2319: 
2320:             THIS.AddLabel(par_oPagina, "lbl_4c_Series", "S" + CHR(233) + "rie :", 50, 30, 60)
2321:             THIS.AddTextBox(par_oPagina, "txt_4c_Series", 47, 120, 80, 3)
2322: 
2323:             THIS.AddLabel(par_oPagina, "lbl_4c_CfoPad", "CFO Padr" + CHR(227) + "o :", 80, 30, 80)
2324:             THIS.AddTextBox(par_oPagina, "txt_4c_CfoPad", 77, 120, 100, 10)
2325: 
2326:             THIS.AddLabel(par_oPagina, "lbl_4c_TipoNF", "Tipo NF :", 110, 30, 60)
2327:             par_oPagina.AddObject("opt_4c_TipoNF", "OptionGroup")
2328:             WITH par_oPagina.opt_4c_TipoNF
2329:                 .ButtonCount   = 3
2330:                 .BackStyle     = 0
2331:                 .BorderStyle   = 1
2332:                 .SpecialEffect = 1
2333:                 .Top           = 108
2334:                 .Left          = 120
2335:                 .Width         = 260
2336:                 .Height        = 22
2337:                 .Value         = 1
2338:                 .Themes        = .F.
2339:                 .Buttons(1).Caption = "Entrada"
2340:                 .Buttons(1).Top     = 3
2341:                 .Buttons(1).Left    = 5
2342:                 .Buttons(1).Width   = 70
2343:                 .Buttons(1).BackStyle = 0
2344:                 .Buttons(1).FontName  = "Tahoma"
2345:                 .Buttons(1).FontSize  = 8
2346:                 .Buttons(2).Caption = "Sa" + CHR(237) + "da"
2347:                 .Buttons(2).Top     = 3
2348:                 .Buttons(2).Left    = 80
2349:                 .Buttons(2).Width   = 70
2350:                 .Buttons(2).BackStyle = 0
2351:                 .Buttons(2).FontName  = "Tahoma"
2352:                 .Buttons(2).FontSize  = 8
2353:                 .Buttons(3).Caption = "Nenhum"
2354:                 .Buttons(3).Top     = 3
2355:                 .Buttons(3).Left    = 155
2356:                 .Buttons(3).Width   = 70
2357:                 .Buttons(3).BackStyle = 0
2358:                 .Buttons(3).FontName  = "Tahoma"
2359:                 .Buttons(3).FontSize  = 8
2360:                 .Visible = .T.

*-- Linhas 2373 a 2384:
2373:     *==========================================================================
2374:     PROTECTED PROCEDURE ConfigurarPagDocumento(par_oPagina)
2375:         TRY
2376:             THIS.AddLabel(par_oPagina, "lbl_4c_DigDoc", "Digita Doc :", 20, 30, 80)
2377:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_DigDoc", 18, 120, 120)
2378: 
2379:             THIS.AddLabel(par_oPagina, "lbl_4c_EditDocs", "Editar Docs :", 50, 30, 80)
2380:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_EditDocs", 48, 120, 120)
2381: 
2382:         CATCH TO loc_oErro
2383:             MsgErro(loc_oErro.Message + CHR(13) + ;
2384:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;

*-- Linhas 2391 a 2405:
2391:     *==========================================================================
2392:     PROTECTED PROCEDURE ConfigurarPagPreco(par_oPagina)
2393:         TRY
2394:             THIS.AddLabel(par_oPagina, "lbl_4c_AltPreco", "Altera Pre" + CHR(231) + "o :", 20, 30, 100)
2395:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_AltPreco", 18, 140, 120)
2396: 
2397:             THIS.AddLabel(par_oPagina, "lbl_4c_AltPeso", "Altera Peso :", 50, 30, 100)
2398:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_AltPeso", 48, 140, 120)
2399: 
2400:             THIS.AddLabel(par_oPagina, "lbl_4c_LPrecoPad", "Lista Pre" + CHR(231) + "o Padr" + CHR(227) + "o :", 80, 30, 120)
2401:             THIS.AddTextBox(par_oPagina, "txt_4c_LPrecoPad", 77, 155, 200, 30)
2402: 
2403:         CATCH TO loc_oErro
2404:             MsgErro(loc_oErro.Message + CHR(13) + ;
2405:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;

*-- Linhas 2412 a 2420:
2412:     *==========================================================================
2413:     PROTECTED PROCEDURE ConfigurarPagDiv(par_oPagina)
2414:         TRY
2415:             THIS.AddLabel(par_oPagina, "lbl_4c_DivVar", "Var. Div. :", 20, 30, 80)
2416:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_DivVar", 18, 120, 120)
2417: 
2418:         CATCH TO loc_oErro
2419:             MsgErro(loc_oErro.Message + CHR(13) + ;
2420:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;

*-- Linhas 2427 a 2436:
2427:     *==========================================================================
2428:     PROTECTED PROCEDURE ConfigurarPagDiversos(par_oPagina)
2429:         TRY
2430:             THIS.AddCheckBox(par_oPagina, "chk_4c_Digenves", "Digitar Envelope", 20, 30, 200)
2431:             THIS.AddCheckBox(par_oPagina, "chk_4c_Digrecs", "Digitar Recebimento", 45, 30, 200)
2432: 
2433:         CATCH TO loc_oErro
2434:             MsgErro(loc_oErro.Message + CHR(13) + ;
2435:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2436:                 "Erro em ConfigurarPagDiversos")

*-- Linhas 2442 a 2519:
2442:     *==========================================================================
2443:     PROTECTED PROCEDURE ConfigurarPagComissao(par_oPagina)
2444:         TRY
2445:             THIS.AddCheckBox(par_oPagina, "chk_4c_Grupov", "Fixar Grupo Vend.", 20, 30, 180)
2446:             THIS.AddLabel(par_oPagina, "lbl_4c_Grupov", "Grupo Vend. :", 45, 30, 90)
2447:             THIS.AddTextBox(par_oPagina, "txt_4c_Grupov", 42, 130, 120, 20)
2448: 
2449:             THIS.AddLabel(par_oPagina, "lbl_4c_MascVen", "M" + CHR(225) + "scara Vend. :", 75, 30, 90)
2450:             THIS.AddTextBox(par_oPagina, "txt_4c_MascVen", 72, 130, 120, 20)
2451: 
2452:             THIS.AddLabel(par_oPagina, "lbl_4c_Vende", "Vendedor :", 105, 30, 80)
2453:             par_oPagina.AddObject("opt_4c_Vende", "OptionGroup")
2454:             WITH par_oPagina.opt_4c_Vende
2455:                 .ButtonCount   = 3
2456:                 .BackStyle     = 0
2457:                 .BorderStyle   = 1
2458:                 .SpecialEffect = 1
2459:                 .Top           = 103
2460:                 .Left          = 130
2461:                 .Width         = 260
2462:                 .Height        = 22
2463:                 .Value         = 1
2464:                 .Themes        = .F.
2465:                 .Buttons(1).Caption = "Obrigat" + CHR(243) + "rio"
2466:                 .Buttons(1).Top     = 3
2467:                 .Buttons(1).Left    = 5
2468:                 .Buttons(1).Width   = 80
2469:                 .Buttons(1).BackStyle = 0
2470:                 .Buttons(1).FontName  = "Tahoma"
2471:                 .Buttons(1).FontSize  = 8
2472:                 .Buttons(2).Caption = "Opcional"
2473:                 .Buttons(2).Top     = 3
2474:                 .Buttons(2).Left    = 90
2475:                 .Buttons(2).Width   = 70
2476:                 .Buttons(2).BackStyle = 0
2477:                 .Buttons(2).FontName  = "Tahoma"
2478:                 .Buttons(2).FontSize  = 8
2479:                 .Buttons(3).Caption = "N" + CHR(227) + "o"
2480:                 .Buttons(3).Top     = 3
2481:                 .Buttons(3).Left    = 165
2482:                 .Buttons(3).Width   = 50
2483:                 .Buttons(3).BackStyle = 0
2484:                 .Buttons(3).FontName  = "Tahoma"
2485:                 .Buttons(3).FontSize  = 8
2486:                 .Visible = .T.
2487:             ENDWITH
2488:             BINDEVENT(par_oPagina.opt_4c_Vende, "InteractiveChange", THIS, "OptVendeChange")
2489: 
2490:             THIS.AddLabel(par_oPagina, "lbl_4c_CadCli", "Cad. Cliente :", 140, 30, 90)
2491:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_CadCli", 138, 130, 120)
2492: 
2493:             *-- Ccusto: legado PgComissao Top=54, Left=463
2494:             par_oPagina.AddObject("cmd_4c_Ccusto", "CommandButton")
2495:             WITH par_oPagina.cmd_4c_Ccusto
2496:                 .Caption       = "C.C."
2497:                 .Top           = 54
2498:                 .Left          = 463
2499:                 .Width         = 80
2500:                 .Height        = 23
2501:                 .FontName      = "Tahoma"
2502:                 .FontSize      = 8
2503:                 .FontBold      = .T.
2504:                 .ForeColor     = RGB(90, 90, 90)
2505:                 .BackColor     = RGB(255, 255, 255)
2506:                 .Themes        = .F.
2507:                 .SpecialEffect = 0
2508:                 .Visible       = .T.
2509:             ENDWITH
2510:             BINDEVENT(par_oPagina.cmd_4c_Ccusto, "Click", THIS, "BtnCcustoClick")
2511: 
2512:         CATCH TO loc_oErro
2513:             MsgErro(loc_oErro.Message + CHR(13) + ;
2514:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2515:                 "Erro em ConfigurarPagComissao")
2516:         ENDTRY
2517:     ENDPROC
2518: 
2519: ENDDEFINE

