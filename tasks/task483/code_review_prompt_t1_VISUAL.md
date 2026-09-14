# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'CCUSTO' (parent: SIGCDOPE.Pagina.Dados.PagDados.PgComissao): Top original=54 vs migrado 'cmd_4c_Ccusto' Top=603 (diff=549px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'CCUSTO' (parent: SIGCDOPE.Pagina.Dados.PagDados.PgComissao): Left original=463 vs migrado 'cmd_4c_Ccusto' Left=810 (diff=347px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOPE.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2591 linhas total):

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

*-- Linhas 2060 a 2070:
2060:     PROTECTED PROCEDURE AddLabel(par_oPag, par_cName, par_cCaption, par_nTop, par_nLeft, par_nWidth)
2061:         par_oPag.AddObject(par_cName, "Label")
2062:         WITH EVALUATE("par_oPag." + par_cName)
2063:             .Caption   = par_cCaption
2064:             .Top       = par_nTop
2065:             .Left      = par_nLeft
2066:             .Width     = par_nWidth
2067:             .Height    = 15
2068:             .FontName  = "Tahoma"
2069:             .FontSize  = 8
2070:             .BackStyle = 0

*-- Linhas 2078 a 2087:
2078:         par_oPag.AddObject(par_cName, "TextBox")
2079:         WITH EVALUATE("par_oPag." + par_cName)
2080:             .Value         = ""
2081:             .Top           = par_nTop
2082:             .Left          = par_nLeft
2083:             .Width         = par_nWidth
2084:             .Height        = 20
2085:             .FontName      = "Tahoma"
2086:             .FontSize      = 8
2087:             .MaxLength     = par_nMaxLen

*-- Linhas 2093 a 2106:
2093:         ENDWITH
2094:     ENDPROC
2095: 
2096:     PROTECTED PROCEDURE AddCheckBox(par_oPag, par_cName, par_cCaption, par_nTop, par_nLeft, par_nWidth)
2097:         par_oPag.AddObject(par_cName, "CheckBox")
2098:         WITH EVALUATE("par_oPag." + par_cName)
2099:             .Caption   = par_cCaption
2100:             .Top       = par_nTop
2101:             .Left      = par_nLeft
2102:             .Width     = par_nWidth
2103:             .Height    = 17
2104:             .FontName  = "Tahoma"
2105:             .FontSize  = 8
2106:             .BackStyle = 0

*-- Linhas 2119 a 2148:
2119:             .BackStyle     = 0
2120:             .BorderStyle   = 1
2121:             .SpecialEffect = 1
2122:             .Top           = par_nTop
2123:             .Left          = par_nLeft
2124:             .Width         = par_nWidth
2125:             .Height        = 22
2126:             .Value         = 1
2127:             .Themes        = .F.
2128:             .Buttons(1).Caption   = "Sim"
2129:             .Buttons(1).FontName  = "Tahoma"
2130:             .Buttons(1).FontSize  = 8
2131:             .Buttons(1).BackStyle = 0
2132:             .Buttons(1).Top       = 3
2133:             .Buttons(1).Left      = 5
2134:             .Buttons(1).Width     = 45
2135:             .Buttons(1).Height    = 17
2136:             .Buttons(1).ForeColor = RGB(90, 90, 90)
2137:             .Buttons(1).AutoSize  = .F.
2138:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
2139:             .Buttons(2).FontName  = "Tahoma"
2140:             .Buttons(2).FontSize  = 8
2141:             .Buttons(2).BackStyle = 0
2142:             .Buttons(2).Top       = 3
2143:             .Buttons(2).Left      = 60
2144:             .Buttons(2).Width     = 45
2145:             .Buttons(2).Height    = 17
2146:             .Buttons(2).ForeColor = RGB(90, 90, 90)
2147:             .Buttons(2).AutoSize  = .F.
2148:             .Visible = .T.

*-- Linhas 2155 a 2304:
2155:     PROTECTED PROCEDURE ConfigurarPagOperacao(par_oPagina)
2156:         TRY
2157:             *-- Numeracao label
2158:             THIS.AddLabel(par_oPagina, "lbl_4c_Numeracao", "Numera" + CHR(231) + CHR(227) + "o :", 11, 78, 63)
2159:             *-- Bloqueio de alterar data (OptionGroup 4 botoes)
2160:             THIS.AddLabel(par_oPagina, "lbl_4c_BlqDt", "Bloq. Alterar Data :", 45, 46, 95)
2161:             par_oPagina.AddObject("opt_4c_Blqdt", "OptionGroup")
2162:             WITH par_oPagina.opt_4c_Blqdt
2163:                 .ButtonCount   = 4
2164:                 .BackStyle     = 0
2165:                 .BorderStyle   = 1
2166:                 .SpecialEffect = 1
2167:                 .Top           = 43
2168:                 .Left          = 145
2169:                 .Width         = 248
2170:                 .Height        = 32
2171:                 .Value         = 1
2172:                 .Themes        = .F.
2173:                 .Buttons(1).Caption = "Sim"
2174:                 .Buttons(1).Value   = 1
2175:                 .Buttons(1).Top     = 2
2176:                 .Buttons(1).Left    = 5
2177:                 .Buttons(1).Width   = 40
2178:                 .Buttons(1).Height  = 17
2179:                 .Buttons(1).BackStyle = 0
2180:                 .Buttons(1).FontName  = "Tahoma"
2181:                 .Buttons(1).FontSize  = 8
2182:                 .Buttons(1).ForeColor = RGB(90, 90, 90)
2183:                 .Buttons(1).AutoSize  = .F.
2184:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
2185:                 .Buttons(2).Top     = 15
2186:                 .Buttons(2).Left    = 5
2187:                 .Buttons(2).Width   = 40
2188:                 .Buttons(2).Height  = 17
2189:                 .Buttons(2).BackStyle = 0
2190:                 .Buttons(2).FontName  = "Tahoma"
2191:                 .Buttons(2).FontSize  = 8
2192:                 .Buttons(2).ForeColor = RGB(90, 90, 90)
2193:                 .Buttons(2).AutoSize  = .F.
2194:                 .Buttons(3).Caption = "Subn" + CHR(237) + "vel Sim"
2195:                 .Buttons(3).Top     = 2
2196:                 .Buttons(3).Left    = 110
2197:                 .Buttons(3).Width   = 100
2198:                 .Buttons(3).Height  = 15
2199:                 .Buttons(3).BackStyle = 0
2200:                 .Buttons(3).FontName  = "Tahoma"
2201:                 .Buttons(3).FontSize  = 8
2202:                 .Buttons(3).ForeColor = RGB(90, 90, 90)
2203:                 .Buttons(3).AutoSize  = .T.
2204:                 .Buttons(4).Caption = "Subn" + CHR(237) + "vel N" + CHR(227) + "o"
2205:                 .Buttons(4).Top     = 15
2206:                 .Buttons(4).Left    = 110
2207:                 .Buttons(4).Width   = 100
2208:                 .Buttons(4).Height  = 15
2209:                 .Buttons(4).BackStyle = 0
2210:                 .Buttons(4).FontName  = "Tahoma"
2211:                 .Buttons(4).FontSize  = 8
2212:                 .Buttons(4).ForeColor = RGB(90, 90, 90)
2213:                 .Buttons(4).AutoSize  = .T.
2214:                 .Visible = .T.
2215:             ENDWITH
2216:             BINDEVENT(par_oPagina.opt_4c_Blqdt, "InteractiveChange", THIS, "OptBlqdtChange")
2217: 
2218:             *-- Conferencia (S/N)
2219:             THIS.AddLabel(par_oPagina, "lbl_4c_Conf", "Confer" + CHR(234) + "ncia :", 181, 74, 67)
2220:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Conf", 179, 145, 248)
2221: 
2222:             *-- Verificar Bloqueio (Aciosens)
2223:             THIS.AddLabel(par_oPagina, "lbl_4c_VerBlq", "Verificar Bloqueio :", 221, 516, 91)
2224:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Bloqueio", 219, 611, 175)
2225: 
2226:             *-- Transferencia de Saida
2227:             THIS.AddLabel(par_oPagina, "lbl_4c_MovSai", "Movimenta" + CHR(231) + CHR(227) + "o de Sa" + CHR(237) + "da :", 309, 340, 145)
2228:             THIS.AddTextBox(par_oPagina, "txt_4c_DopeSTrfs", 306, 486, 150, 20)
2229: 
2230:             *-- Movimentacao de Entrada
2231:             THIS.AddLabel(par_oPagina, "lbl_4c_MovEnt", "Movimenta" + CHR(231) + CHR(227) + "o de Entrada :", 331, 340, 145)
2232:             THIS.AddTextBox(par_oPagina, "txt_4c_DopeETrfs", 328, 486, 150, 20)
2233: 
2234:             *-- Central
2235:             THIS.AddLabel(par_oPagina, "lbl_4c_Central", "Central :", 258, 90, 50)
2236:             THIS.AddTextBox(par_oPagina, "txt_4c_Central", 255, 145, 50, 2)
2237: 
2238:             *-- Empresa Padrao
2239:             THIS.AddLabel(par_oPagina, "lbl_4c_EmpPad", "Empresa Padr" + CHR(227) + "o :", 388, 60, 80)
2240:             THIS.AddTextBox(par_oPagina, "txt_4c_EmpPad", 385, 145, 50, 3)
2241: 
2242:             *-- CheckBoxes
2243:             THIS.AddCheckBox(par_oPagina, "chk_4c_CarESubN", "Carregar E-Subn" + CHR(237) + "vel", 415, 145, 180)
2244:             THIS.AddCheckBox(par_oPagina, "chk_4c_VincEstM", "Vincular Est. Mestre", 435, 145, 180)
2245: 
2246:             *-- Tipo (Opers)
2247:             THIS.AddLabel(par_oPagina, "lbl_4c_Tipo1", "Tipo :", 460, 100, 45)
2248:             par_oPagina.AddObject("opt_4c_Tipo", "OptionGroup")
2249:             WITH par_oPagina.opt_4c_Tipo
2250:                 .ButtonCount   = 3
2251:                 .BackStyle     = 0
2252:                 .BorderStyle   = 1
2253:                 .SpecialEffect = 1
2254:                 .Top           = 458
2255:                 .Left          = 145
2256:                 .Width         = 250
2257:                 .Height        = 22
2258:                 .Value         = 1
2259:                 .Themes        = .F.
2260:                 .Buttons(1).Caption = "Sa" + CHR(237) + "da"
2261:                 .Buttons(1).Value   = 1
2262:                 .Buttons(1).Top     = 3
2263:                 .Buttons(1).Left    = 5
2264:                 .Buttons(1).Width   = 60
2265:                 .Buttons(1).BackStyle = 0
2266:                 .Buttons(1).FontName  = "Tahoma"
2267:                 .Buttons(1).FontSize  = 8
2268:                 .Buttons(1).ForeColor = RGB(90, 90, 90)
2269:                 .Buttons(2).Caption = "Entrada"
2270:                 .Buttons(2).Top     = 3
2271:                 .Buttons(2).Left    = 70
2272:                 .Buttons(2).Width   = 60
2273:                 .Buttons(2).BackStyle = 0
2274:                 .Buttons(2).FontName  = "Tahoma"
2275:                 .Buttons(2).FontSize  = 8
2276:                 .Buttons(2).ForeColor = RGB(90, 90, 90)
2277:                 .Buttons(3).Caption = "Nenhum"
2278:                 .Buttons(3).Top     = 3
2279:                 .Buttons(3).Left    = 140
2280:                 .Buttons(3).Width   = 60
2281:                 .Buttons(3).BackStyle = 0
2282:                 .Buttons(3).FontName  = "Tahoma"
2283:                 .Buttons(3).FontSize  = 8
2284:                 .Buttons(3).ForeColor = RGB(90, 90, 90)
2285:                 .Visible = .T.
2286:             ENDWITH
2287:             BINDEVENT(par_oPagina.opt_4c_Tipo, "InteractiveChange", THIS, "OptTipoChange")
2288: 
2289:             *-- Caixa
2290:             THIS.AddLabel(par_oPagina, "lbl_4c_Cai", "Caixa :", 490, 100, 45)
2291:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Cai", 488, 145, 120)
2292: 
2293:             *-- Observacao (EditBox)
2294:             THIS.AddLabel(par_oPagina, "lbl_4c_ObsOpe", "Observa" + CHR(231) + CHR(245) + "es :", 520, 60, 80)
2295:             par_oPagina.AddObject("mem_4c_ObsOpe", "EditBox")
2296:             WITH par_oPagina.mem_4c_ObsOpe
2297:                 .Value       = ""
2298:                 .Top         = 518
2299:                 .Left        = 145
2300:                 .Width       = 640
2301:                 .Height      = 60
2302:                 .FontName    = "Tahoma"
2303:                 .FontSize    = 8
2304:                 .BackColor   = RGB(255, 255, 255)

*-- Linhas 2320 a 2343:
2320:     *==========================================================================
2321:     PROTECTED PROCEDURE ConfigurarPagItens(par_oPagina)
2322:         TRY
2323:             THIS.AddLabel(par_oPagina, "lbl_4c_CBar", "C" + CHR(243) + "d. Barras :", 20, 30, 80)
2324:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Cbar", 18, 120, 120)
2325: 
2326:             THIS.AddLabel(par_oPagina, "lbl_4c_Imagem", "Imagem :", 50, 30, 80)
2327:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Imagem", 48, 120, 120)
2328: 
2329:             THIS.AddLabel(par_oPagina, "lbl_4c_ObsItems", "Obs. Itens :", 80, 30, 80)
2330:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_ObsItems", 78, 120, 120)
2331: 
2332:             THIS.AddLabel(par_oPagina, "lbl_4c_Desmemb", "Desmembra :", 110, 30, 80)
2333:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Desmemb", 108, 120, 120)
2334: 
2335:             THIS.AddLabel(par_oPagina, "lbl_4c_ChkQtds", "Check Qtd :", 140, 30, 80)
2336:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_ChkQtds", 138, 120, 120)
2337: 
2338:             THIS.AddLabel(par_oPagina, "lbl_4c_QtdIte", "Qtde. Itens :", 175, 30, 80)
2339:             THIS.AddTextBox(par_oPagina, "txt_4c_QtdIte", 172, 120, 60, 4)
2340: 
2341:         CATCH TO loc_oErro
2342:             MsgErro(loc_oErro.Message + CHR(13) + ;
2343:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;

*-- Linhas 2350 a 2379:
2350:     *==========================================================================
2351:     PROTECTED PROCEDURE ConfigurarPagFinanceiro(par_oPagina)
2352:         TRY
2353:             THIS.AddLabel(par_oPagina, "lbl_4c_Che", "Cheque :", 20, 30, 80)
2354:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Che", 18, 120, 120)
2355: 
2356:             THIS.AddLabel(par_oPagina, "lbl_4c_Contas", "Contas :", 50, 30, 80)
2357:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Contas", 48, 120, 120)
2358: 
2359:             THIS.AddLabel(par_oPagina, "lbl_4c_LimCre", "Lim. Cr" + CHR(233) + "dito :", 80, 30, 80)
2360:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_LimCre", 78, 120, 120)
2361: 
2362:             THIS.AddLabel(par_oPagina, "lbl_4c_Troco", "Troco Auto :", 110, 30, 80)
2363:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_Troco", 108, 120, 120)
2364: 
2365:             THIS.AddLabel(par_oPagina, "lbl_4c_OpChqEnt", "Op. Cheq. Entr. :", 145, 30, 100)
2366:             THIS.AddTextBox(par_oPagina, "txt_4c_OpChqEnt", 142, 145, 150, 15)
2367: 
2368:             THIS.AddLabel(par_oPagina, "lbl_4c_OpChqSai", "Op. Cheq. Sa" + CHR(237) + "da :", 175, 30, 100)
2369:             THIS.AddTextBox(par_oPagina, "txt_4c_OpChqSai", 172, 145, 150, 15)
2370: 
2371:             THIS.AddLabel(par_oPagina, "lbl_4c_Conta", "Conta :", 205, 30, 60)
2372:             THIS.AddTextBox(par_oPagina, "txt_4c_Conta", 202, 145, 100, 10)
2373: 
2374:             THIS.AddLabel(par_oPagina, "lbl_4c_Grupo", "Grupo :", 235, 30, 60)
2375:             THIS.AddTextBox(par_oPagina, "txt_4c_Grupo", 232, 145, 100, 10)
2376: 
2377:         CATCH TO loc_oErro
2378:             MsgErro(loc_oErro.Message + CHR(13) + ;
2379:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;

*-- Linhas 2386 a 2432:
2386:     *==========================================================================
2387:     PROTECTED PROCEDURE ConfigurarPagFiscal(par_oPagina)
2388:         TRY
2389:             THIS.AddLabel(par_oPagina, "lbl_4c_Especies", "Esp" + CHR(233) + "cie :", 20, 30, 60)
2390:             THIS.AddTextBox(par_oPagina, "txt_4c_Especies", 17, 120, 80, 6)
2391: 
2392:             THIS.AddLabel(par_oPagina, "lbl_4c_Series", "S" + CHR(233) + "rie :", 50, 30, 60)
2393:             THIS.AddTextBox(par_oPagina, "txt_4c_Series", 47, 120, 80, 3)
2394: 
2395:             THIS.AddLabel(par_oPagina, "lbl_4c_CfoPad", "CFO Padr" + CHR(227) + "o :", 80, 30, 80)
2396:             THIS.AddTextBox(par_oPagina, "txt_4c_CfoPad", 77, 120, 100, 10)
2397: 
2398:             THIS.AddLabel(par_oPagina, "lbl_4c_TipoNF", "Tipo NF :", 110, 30, 60)
2399:             par_oPagina.AddObject("opt_4c_TipoNF", "OptionGroup")
2400:             WITH par_oPagina.opt_4c_TipoNF
2401:                 .ButtonCount   = 3
2402:                 .BackStyle     = 0
2403:                 .BorderStyle   = 1
2404:                 .SpecialEffect = 1
2405:                 .Top           = 108
2406:                 .Left          = 120
2407:                 .Width         = 260
2408:                 .Height        = 22
2409:                 .Value         = 1
2410:                 .Themes        = .F.
2411:                 .Buttons(1).Caption = "Entrada"
2412:                 .Buttons(1).Top     = 3
2413:                 .Buttons(1).Left    = 5
2414:                 .Buttons(1).Width   = 70
2415:                 .Buttons(1).BackStyle = 0
2416:                 .Buttons(1).FontName  = "Tahoma"
2417:                 .Buttons(1).FontSize  = 8
2418:                 .Buttons(2).Caption = "Sa" + CHR(237) + "da"
2419:                 .Buttons(2).Top     = 3
2420:                 .Buttons(2).Left    = 80
2421:                 .Buttons(2).Width   = 70
2422:                 .Buttons(2).BackStyle = 0
2423:                 .Buttons(2).FontName  = "Tahoma"
2424:                 .Buttons(2).FontSize  = 8
2425:                 .Buttons(3).Caption = "Nenhum"
2426:                 .Buttons(3).Top     = 3
2427:                 .Buttons(3).Left    = 155
2428:                 .Buttons(3).Width   = 70
2429:                 .Buttons(3).BackStyle = 0
2430:                 .Buttons(3).FontName  = "Tahoma"
2431:                 .Buttons(3).FontSize  = 8
2432:                 .Visible = .T.

*-- Linhas 2445 a 2456:
2445:     *==========================================================================
2446:     PROTECTED PROCEDURE ConfigurarPagDocumento(par_oPagina)
2447:         TRY
2448:             THIS.AddLabel(par_oPagina, "lbl_4c_DigDoc", "Digita Doc :", 20, 30, 80)
2449:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_DigDoc", 18, 120, 120)
2450: 
2451:             THIS.AddLabel(par_oPagina, "lbl_4c_EditDocs", "Editar Docs :", 50, 30, 80)
2452:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_EditDocs", 48, 120, 120)
2453: 
2454:         CATCH TO loc_oErro
2455:             MsgErro(loc_oErro.Message + CHR(13) + ;
2456:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;

*-- Linhas 2463 a 2477:
2463:     *==========================================================================
2464:     PROTECTED PROCEDURE ConfigurarPagPreco(par_oPagina)
2465:         TRY
2466:             THIS.AddLabel(par_oPagina, "lbl_4c_AltPreco", "Altera Pre" + CHR(231) + "o :", 20, 30, 100)
2467:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_AltPreco", 18, 140, 120)
2468: 
2469:             THIS.AddLabel(par_oPagina, "lbl_4c_AltPeso", "Altera Peso :", 50, 30, 100)
2470:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_AltPeso", 48, 140, 120)
2471: 
2472:             THIS.AddLabel(par_oPagina, "lbl_4c_LPrecoPad", "Lista Pre" + CHR(231) + "o Padr" + CHR(227) + "o :", 80, 30, 120)
2473:             THIS.AddTextBox(par_oPagina, "txt_4c_LPrecoPad", 77, 155, 200, 30)
2474: 
2475:         CATCH TO loc_oErro
2476:             MsgErro(loc_oErro.Message + CHR(13) + ;
2477:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;

*-- Linhas 2484 a 2492:
2484:     *==========================================================================
2485:     PROTECTED PROCEDURE ConfigurarPagDiv(par_oPagina)
2486:         TRY
2487:             THIS.AddLabel(par_oPagina, "lbl_4c_DivVar", "Var. Div. :", 20, 30, 80)
2488:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_DivVar", 18, 120, 120)
2489: 
2490:         CATCH TO loc_oErro
2491:             MsgErro(loc_oErro.Message + CHR(13) + ;
2492:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;

*-- Linhas 2499 a 2508:
2499:     *==========================================================================
2500:     PROTECTED PROCEDURE ConfigurarPagDiversos(par_oPagina)
2501:         TRY
2502:             THIS.AddCheckBox(par_oPagina, "chk_4c_Digenves", "Digitar Envelope", 20, 30, 200)
2503:             THIS.AddCheckBox(par_oPagina, "chk_4c_Digrecs", "Digitar Recebimento", 45, 30, 200)
2504: 
2505:         CATCH TO loc_oErro
2506:             MsgErro(loc_oErro.Message + CHR(13) + ;
2507:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2508:                 "Erro em ConfigurarPagDiversos")

*-- Linhas 2514 a 2591:
2514:     *==========================================================================
2515:     PROTECTED PROCEDURE ConfigurarPagComissao(par_oPagina)
2516:         TRY
2517:             THIS.AddCheckBox(par_oPagina, "chk_4c_Grupov", "Fixar Grupo Vend.", 20, 30, 180)
2518:             THIS.AddLabel(par_oPagina, "lbl_4c_Grupov", "Grupo Vend. :", 45, 30, 90)
2519:             THIS.AddTextBox(par_oPagina, "txt_4c_Grupov", 42, 130, 120, 20)
2520: 
2521:             THIS.AddLabel(par_oPagina, "lbl_4c_MascVen", "M" + CHR(225) + "scara Vend. :", 75, 30, 90)
2522:             THIS.AddTextBox(par_oPagina, "txt_4c_MascVen", 72, 130, 120, 20)
2523: 
2524:             THIS.AddLabel(par_oPagina, "lbl_4c_Vende", "Vendedor :", 105, 30, 80)
2525:             par_oPagina.AddObject("opt_4c_Vende", "OptionGroup")
2526:             WITH par_oPagina.opt_4c_Vende
2527:                 .ButtonCount   = 3
2528:                 .BackStyle     = 0
2529:                 .BorderStyle   = 1
2530:                 .SpecialEffect = 1
2531:                 .Top           = 103
2532:                 .Left          = 130
2533:                 .Width         = 260
2534:                 .Height        = 22
2535:                 .Value         = 1
2536:                 .Themes        = .F.
2537:                 .Buttons(1).Caption = "Obrigat" + CHR(243) + "rio"
2538:                 .Buttons(1).Top     = 3
2539:                 .Buttons(1).Left    = 5
2540:                 .Buttons(1).Width   = 80
2541:                 .Buttons(1).BackStyle = 0
2542:                 .Buttons(1).FontName  = "Tahoma"
2543:                 .Buttons(1).FontSize  = 8
2544:                 .Buttons(2).Caption = "Opcional"
2545:                 .Buttons(2).Top     = 3
2546:                 .Buttons(2).Left    = 90
2547:                 .Buttons(2).Width   = 70
2548:                 .Buttons(2).BackStyle = 0
2549:                 .Buttons(2).FontName  = "Tahoma"
2550:                 .Buttons(2).FontSize  = 8
2551:                 .Buttons(3).Caption = "N" + CHR(227) + "o"
2552:                 .Buttons(3).Top     = 3
2553:                 .Buttons(3).Left    = 165
2554:                 .Buttons(3).Width   = 50
2555:                 .Buttons(3).BackStyle = 0
2556:                 .Buttons(3).FontName  = "Tahoma"
2557:                 .Buttons(3).FontSize  = 8
2558:                 .Visible = .T.
2559:             ENDWITH
2560:             BINDEVENT(par_oPagina.opt_4c_Vende, "InteractiveChange", THIS, "OptVendeChange")
2561: 
2562:             THIS.AddLabel(par_oPagina, "lbl_4c_CadCli", "Cad. Cliente :", 140, 30, 90)
2563:             THIS.AddOptGroupSN(par_oPagina, "opt_4c_CadCli", 138, 130, 120)
2564: 
2565:             *-- Ccusto: legado Lista Top=574, compensado +29=603, Left=810
2566:             par_oPagina.AddObject("cmd_4c_Ccusto", "CommandButton")
2567:             WITH par_oPagina.cmd_4c_Ccusto
2568:                 .Caption       = "C.C."
2569:                 .Top           = 603
2570:                 .Left          = 810
2571:                 .Width         = 80
2572:                 .Height        = 23
2573:                 .FontName      = "Tahoma"
2574:                 .FontSize      = 8
2575:                 .FontBold      = .T.
2576:                 .ForeColor     = RGB(90, 90, 90)
2577:                 .BackColor     = RGB(255, 255, 255)
2578:                 .Themes        = .F.
2579:                 .SpecialEffect = 0
2580:                 .Visible       = .T.
2581:             ENDWITH
2582:             BINDEVENT(par_oPagina.cmd_4c_Ccusto, "Click", THIS, "BtnCcustoClick")
2583: 
2584:         CATCH TO loc_oErro
2585:             MsgErro(loc_oErro.Message + CHR(13) + ;
2586:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2587:                 "Erro em ConfigurarPagComissao")
2588:         ENDTRY
2589:     ENDPROC
2590: 
2591: ENDDEFINE

