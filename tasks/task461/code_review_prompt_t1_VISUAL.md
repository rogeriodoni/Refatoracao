# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (23)
- [ALINHAMENTO] Botao 'cmd_4c_ImpExcel' tem Top=3 mas grupo usa Top=5 (diferenca de 2px)
- [ALINHAMENTO] Botao 'cmd_4c_ImpVideo' tem Top=3 mas grupo usa Top=5 (diferenca de 2px)
- [ALINHAMENTO] Botao 'cmd_4c_ImpImpressora' tem Top=3 mas grupo usa Top=5 (diferenca de 2px)
- [FONTNAME-ERRADO] Linha 245: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 268: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 291: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 314: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 337: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 375: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 460: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 487: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 641: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 665: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 689: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 713: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 829: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 852: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1193: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1215: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1237: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1259: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1281: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1515: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormLpr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3490 linhas total):

*-- Linhas 87 a 97:
87:         TRY
88:             *-- Caption com acentos (regra CLAUDE.md #4 - usar CHR())
89:             IF THIS.this_cCompVenda = "C"
90:                 THIS.Caption = "Listas de Compra"
91:             ELSE
92:                 THIS.Caption = "Listas de Precifica" + CHR(231) + CHR(227) + "o"
93:             ENDIF
94: 
95:             *-- Salvar decimais originais (restaurados no Destroy)
96:             THIS.this_nOldCasas = SET("Decimals")
97: 

*-- Linhas 103 a 112:
103:                 THIS.ConfigurarPageFrame()
104: 
105:                 *-- Propagar caption para labels do cabecalho
106:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
107:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
108: 
109:                 THIS.ConfigurarPaginaLista()
110:                 THIS.ConfigurarPaginaDados()
111: 
112:                 *-- Carregar dados apenas se nao estiver validando UI (sem conexao SQL)

*-- Linhas 143 a 158:
143:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
144:             WITH THIS.pgf_4c_Paginas
145:                 .PageCount     = 2
146:                 .Top           = -29
147:                 .Left          = 0
148:                 .Width         = THIS.Width
149:                 .Height        = THIS.Height + 29
150:                 .Tabs          = .F.
151:                 .Visible       = .T.
152:                 .Page1.Caption = "Lista"
153:                 .Page2.Caption = "Dados"
154:                 .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
155:                 .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
156:             ENDWITH
157:         CATCH TO loException
158:             MsgErro("Erro: " + loException.Message, "FormLpr.ConfigurarPageFrame")

*-- Linhas 172 a 212:
172: 
173:             *----------------------------------------------------------------------
174:             * Cabecalho cinza superior (cntSombra do legado)
175:             * Top=31 = 2 (original) + 29 (compensacao PageFrame.Top=-29)
176:             *----------------------------------------------------------------------
177:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
178:             WITH loc_oPagina.cnt_4c_Cabecalho
179:                 .Top         = 31
180:                 .Left        = 0
181:                 .Width       = THIS.Width
182:                 .Height      = 80
183:                 .BackColor   = RGB(100, 100, 100)
184:                 .BorderWidth = 0
185:                 .Visible     = .T.
186: 
187:                 .AddObject("lbl_4c_Sombra", "Label")
188:                 WITH .lbl_4c_Sombra
189:                     .Caption   = THIS.Caption
190:                     .Top       = 15
191:                     .Left      = 12
192:                     .Width     = THIS.Width
193:                     .Height    = 40
194:                     .AutoSize  = .F.
195:                     .FontName  = "Tahoma"
196:                     .FontSize  = 16
197:                     .FontBold  = .T.
198:                     .ForeColor = RGB(0, 0, 0)
199:                     .BackStyle = 0
200:                     .Visible   = .T.
201:                 ENDWITH
202: 
203:                 .AddObject("lbl_4c_Titulo", "Label")
204:                 WITH .lbl_4c_Titulo
205:                     .Caption   = THIS.Caption
206:                     .Top       = 18
207:                     .Left      = 10
208:                     .Width     = THIS.Width
209:                     .Height    = 46
210:                     .AutoSize  = .F.
211:                     .FontName  = "Tahoma"
212:                     .FontSize  = 16

*-- Linhas 224 a 343:
224:             loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
225:             loc_oCnt = loc_oPagina.cnt_4c_Botoes
226:             WITH loc_oCnt
227:                 .Top         = 29
228:                 .Left        = 542
229:                 .Width       = 390
230:                 .Height      = 85
231:                 .BackStyle   = 1
232:                 .BackColor   = RGB(100, 100, 100)
233:                 .BorderWidth = 0
234:                 .Visible     = .T.
235: 
236:                 .AddObject("cmd_4c_Incluir", "CommandButton")
237:                 WITH .cmd_4c_Incluir
238:                     .Caption         = "Incluir"
239:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
240:                     .PicturePosition = 13
241:                     .Top             = 5
242:                     .Left            =  542
243:                     .Width           = 75
244:                     .Height          = 75
245:                     .FontName        = "Comic Sans MS"
246:                     .FontSize        = 8
247:                     .FontBold        = .T.
248:                     .FontItalic      = .T.
249:                     .ForeColor       = RGB(90, 90, 90)
250:                     .BackColor       = RGB(255, 255, 255)
251:                     .Themes          = .F.
252:                     .SpecialEffect   = 0
253:                     .MousePointer    = 15
254:                     .WordWrap        = .T.
255:                     .AutoSize        = .F.
256:                     .Visible         = .T.
257:                 ENDWITH
258: 
259:                 .AddObject("cmd_4c_Visualizar", "CommandButton")
260:                 WITH .cmd_4c_Visualizar
261:                     .Caption         = "Visualizar"
262:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
263:                     .PicturePosition = 13
264:                     .Top             = 5
265:                     .Left            =  542
266:                     .Width           = 75
267:                     .Height          = 75
268:                     .FontName        = "Comic Sans MS"
269:                     .FontSize        = 8
270:                     .FontBold        = .T.
271:                     .FontItalic      = .T.
272:                     .ForeColor       = RGB(90, 90, 90)
273:                     .BackColor       = RGB(255, 255, 255)
274:                     .Themes          = .F.
275:                     .SpecialEffect   = 0
276:                     .MousePointer    = 15
277:                     .WordWrap        = .T.
278:                     .AutoSize        = .F.
279:                     .Visible         = .T.
280:                 ENDWITH
281: 
282:                 .AddObject("cmd_4c_Alterar", "CommandButton")
283:                 WITH .cmd_4c_Alterar
284:                     .Caption         = "Alterar"
285:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
286:                     .PicturePosition = 13
287:                     .Top             = 5
288:                     .Left            =  542
289:                     .Width           = 75
290:                     .Height          = 75
291:                     .FontName        = "Comic Sans MS"
292:                     .FontSize        = 8
293:                     .FontBold        = .T.
294:                     .FontItalic      = .T.
295:                     .ForeColor       = RGB(90, 90, 90)
296:                     .BackColor       = RGB(255, 255, 255)
297:                     .Themes          = .F.
298:                     .SpecialEffect   = 0
299:                     .MousePointer    = 15
300:                     .WordWrap        = .T.
301:                     .AutoSize        = .F.
302:                     .Visible         = .T.
303:                 ENDWITH
304: 
305:                 .AddObject("cmd_4c_Excluir", "CommandButton")
306:                 WITH .cmd_4c_Excluir
307:                     .Caption         = "Excluir"
308:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
309:                     .PicturePosition = 13
310:                     .Top             = 5
311:                     .Left            =  542
312:                     .Width           = 75
313:                     .Height          = 75
314:                     .FontName        = "Comic Sans MS"
315:                     .FontSize        = 8
316:                     .FontBold        = .T.
317:                     .FontItalic      = .T.
318:                     .ForeColor       = RGB(90, 90, 90)
319:                     .BackColor       = RGB(255, 255, 255)
320:                     .Themes          = .F.
321:                     .SpecialEffect   = 0
322:                     .MousePointer    = 15
323:                     .WordWrap        = .T.
324:                     .AutoSize        = .F.
325:                     .Visible         = .T.
326:                 ENDWITH
327: 
328:                 .AddObject("cmd_4c_Buscar", "CommandButton")
329:                 WITH .cmd_4c_Buscar
330:                     .Caption         = "Buscar"
331:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
332:                     .PicturePosition = 13
333:                     .Top             = 5
334:                     .Left            =  542
335:                     .Width           = 75
336:                     .Height          = 75
337:                     .FontName        = "Comic Sans MS"
338:                     .FontSize        = 8
339:                     .FontBold        = .T.
340:                     .FontItalic      = .T.
341:                     .ForeColor       = RGB(90, 90, 90)
342:                     .BackColor       = RGB(255, 255, 255)
343:                     .Themes          = .F.

*-- Linhas 351 a 381:
351: 
352:             *----------------------------------------------------------------------
353:             * Container Saida (padrao canonico - CLAUDE.md regra #10)
354:             * Left=917, Width=90, cmd_4c_Encerrar (Width=75, Height=75)
355:             *----------------------------------------------------------------------
356:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
357:             WITH loc_oPagina.cnt_4c_Saida
358:                 .Top         = 29
359:                 .Left        = 917
360:                 .Width       = 90
361:                 .Height      = 85
362:                 .BackStyle   = 0
363:                 .BorderWidth = 0
364:                 .Visible     = .T.
365: 
366:                 .AddObject("cmd_4c_Encerrar", "CommandButton")
367:                 WITH .cmd_4c_Encerrar
368:                     .Caption         = "Encerrar"
369:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
370:                     .PicturePosition = 13
371:                     .Top             = 5
372:                     .Left            = 917
373:                     .Width           = 90
374:                     .Height          = 75
375:                     .FontName        = "Comic Sans MS"
376:                     .FontSize        = 8
377:                     .FontBold        = .T.
378:                     .FontItalic      = .T.
379:                     .ForeColor       = RGB(90, 90, 90)
380:                     .BackColor       = RGB(255, 255, 255)
381:                     .SpecialEffect   = 0

*-- Linhas 393 a 441:
393:             *----------------------------------------------------------------------
394:             loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
395:             WITH loc_oPagina.cnt_4c_Filtros
396:                 .Top         = 115
397:                 .Left        = 2
398:                 .Width       = 260
399:                 .Height      = 33
400:                 .BackStyle   = 0
401:                 .BorderWidth = 0
402:                 .Visible     = .T.
403: 
404:                 .AddObject("opt_4c_Vencimento", "OptionGroup")
405:                 WITH .opt_4c_Vencimento
406:                     .ButtonCount = 3
407:                     .Top         = 4
408:                     .Left        = 6
409:                     .Width       = 238
410:                     .Height      = 25
411:                     .BackStyle   = 0
412:                     .Value       = 1
413:                     .Visible     = .T.
414:                     WITH .Buttons(1)
415:                         .Caption   = "Todos"
416:                         .Left      = 0
417:                         .Top       = 3
418:                         .Width     = 50
419:                         .AutoSize  = .T.
420:                         .ForeColor = RGB(90, 90, 90)
421:                     ENDWITH
422:                     WITH .Buttons(2)
423:                         .Caption   = "A Vencer"
424:                         .Left      = 60
425:                         .Top       = 3
426:                         .Width     = 72
427:                         .AutoSize  = .T.
428:                         .FontName  = "Tahoma"
429:                         .FontSize  = 8
430:                         .ForeColor = RGB(90, 90, 90)
431:                         .Themes    = .F.
432:                     ENDWITH
433:                     WITH .Buttons(3)
434:                         .Caption   = "Vencidos"
435:                         .Left      = 140
436:                         .Top       = 3
437:                         .Width     = 72
438:                         .AutoSize  = .T.
439:                         .FontName  = "Tahoma"
440:                         .FontSize  = 8
441:                         .ForeColor = RGB(90, 90, 90)

*-- Linhas 448 a 466:
448:             * Botao Atualizar (bnt_Atualiza do legado)
449:             * Publica lista no sistema (flags=1). Top=119 = 90+29, Left=287
450:             *----------------------------------------------------------------------
451:             loc_oPagina.AddObject("cmd_4c_Atualizar", "CommandButton")
452:             WITH loc_oPagina.cmd_4c_Atualizar
453:                 .Caption         = "Atualizar"
454:                 .Picture         = gc_4c_CaminhoIcones + "geral_confirmar_32.jpg"
455:                 .PicturePosition = 13
456:                 .Top             = 119
457:                 .Left            = 287
458:                 .Width           = 75
459:                 .Height          = 75
460:                 .FontName        = "Comic Sans MS"
461:                 .FontSize        = 8
462:                 .FontBold        = .T.
463:                 .FontItalic      = .T.
464:                 .ForeColor       = RGB(90, 90, 90)
465:                 .BackColor       = RGB(255, 255, 255)
466:                 .Themes          = .F.

*-- Linhas 475 a 493:
475:             * Botao Imprimir standalone (imprimir do legado)
476:             * Abre painel ImpLista. Top=119 = 90+29, Left=367
477:             *----------------------------------------------------------------------
478:             loc_oPagina.AddObject("cmd_4c_ImprimirLista", "CommandButton")
479:             WITH loc_oPagina.cmd_4c_ImprimirLista
480:                 .Caption         = "Imprimir"
481:                 .Picture         = gc_4c_CaminhoIcones + "geral_imprimir_32.jpg"
482:                 .PicturePosition = 13
483:                 .Top             = 119
484:                 .Left            = 367
485:                 .Width           = 75
486:                 .Height          = 75
487:                 .FontName        = "Comic Sans MS"
488:                 .FontSize        = 8
489:                 .FontBold        = .T.
490:                 .FontItalic      = .T.
491:                 .ForeColor       = RGB(90, 90, 90)
492:                 .BackColor       = RGB(255, 255, 255)
493:                 .Themes          = .F.

*-- Linhas 505 a 719:
505:             *----------------------------------------------------------------------
506:             loc_oPagina.AddObject("cnt_4c_ImpLista", "Container")
507:             WITH loc_oPagina.cnt_4c_ImpLista
508:                 .Top         = 273
509:                 .Left        = 211
510:                 .Width       = 577
511:                 .Height      = 129
512:                 .BackStyle   = 1
513:                 .BackColor   = RGB(240, 240, 240)
514:                 .BorderWidth = 1
515:                 .Visible     = .F.
516: 
517:                 .AddObject("lbl_4c_TituloImp", "Label")
518:                 WITH .lbl_4c_TituloImp
519:                     .Caption   = "Impress" + CHR(227) + "o de Listas"
520:                     .Top       = 9
521:                     .Left      = 25
522:                     .Width     = 203
523:                     .Height    = 26
524:                     .FontName  = "Tahoma"
525:                     .FontSize  = 10
526:                     .FontBold  = .T.
527:                     .BackStyle = 0
528:                     .Visible   = .T.
529:                 ENDWITH
530: 
531:                 .AddObject("lbl_4c_TipoImpLabel", "Label")
532:                 WITH .lbl_4c_TipoImpLabel
533:                     .Caption   = "Tipo :"
534:                     .Top       = 45
535:                     .Left      = 30
536:                     .Width     = 29
537:                     .Height    = 15
538:                     .FontName  = "Tahoma"
539:                     .FontSize  = 8
540:                     .BackStyle = 0
541:                     .Visible   = .T.
542:                 ENDWITH
543: 
544:                 .AddObject("opt_4c_TipoImp", "OptionGroup")
545:                 WITH .opt_4c_TipoImp
546:                     .ButtonCount = 4
547:                     .Top         = 41
548:                     .Left        = 57
549:                     .Width       = 214
550:                     .Height      = 51
551:                     .BackStyle   = 0
552:                     .Value       = 1
553:                     .Visible     = .T.
554:                     WITH .Buttons(1)
555:                         .Caption  = "Vendas"
556:                         .Left     = 0
557:                         .Top      = 3
558:                         .AutoSize = .T.
559:                         .Themes   = .F.
560:                     ENDWITH
561:                     WITH .Buttons(2)
562:                         .Caption  = "Compras"
563:                         .Left     = 70
564:                         .Top      = 3
565:                         .AutoSize = .T.
566:                         .FontName = "Tahoma"
567:                         .FontSize = 8
568:                         .Themes   = .F.
569:                     ENDWITH
570:                     WITH .Buttons(3)
571:                         .Caption  = "An" + CHR(225) + "lise"
572:                         .Left     = 0
573:                         .Top      = 28
574:                         .AutoSize = .T.
575:                         .FontName = "Tahoma"
576:                         .FontSize = 8
577:                         .Themes   = .F.
578:                     ENDWITH
579:                     WITH .Buttons(4)
580:                         .Caption  = "Embalagem"
581:                         .Left     = 70
582:                         .Top      = 28
583:                         .AutoSize = .T.
584:                         .FontName = "Tahoma"
585:                         .FontSize = 8
586:                         .Themes   = .F.
587:                     ENDWITH
588:                 ENDWITH
589: 
590:                 .AddObject("lbl_4c_FotoLabel", "Label")
591:                 WITH .lbl_4c_FotoLabel
592:                     .Caption   = "Imagem :"
593:                     .Top       = 88
594:                     .Left      = 13
595:                     .Width     = 47
596:                     .Height    = 15
597:                     .FontName  = "Tahoma"
598:                     .FontSize  = 8
599:                     .BackStyle = 0
600:                     .Visible   = .T.
601:                 ENDWITH
602: 
603:                 .AddObject("opt_4c_FotoImp", "OptionGroup")
604:                 WITH .opt_4c_FotoImp
605:                     .ButtonCount = 2
606:                     .Top         = 84
607:                     .Left        = 57
608:                     .Width       = 97
609:                     .Height      = 25
610:                     .BackStyle   = 0
611:                     .Value       = 2
612:                     .Visible     = .T.
613:                     WITH .Buttons(1)
614:                         .Caption  = "Com"
615:                         .Left     = 0
616:                         .Top      = 3
617:                         .AutoSize = .T.
618:                         .Themes   = .F.
619:                     ENDWITH
620:                     WITH .Buttons(2)
621:                         .Caption  = "Sem"
622:                         .Left     = 45
623:                         .Top      = 3
624:                         .AutoSize = .T.
625:                         .FontName = "Tahoma"
626:                         .FontSize = 8
627:                         .Themes   = .F.
628:                     ENDWITH
629:                 ENDWITH
630: 
631:                 *-- Botao Excel
632:                 .AddObject("cmd_4c_ImpExcel", "CommandButton")
633:                 WITH .cmd_4c_ImpExcel
634:                     .Caption         = "\<Excel"
635:                     .Picture         = gc_4c_CaminhoIcones + "geral_excel_32.jpg"
636:                     .PicturePosition = 13
637:                     .Top             = 3
638:                     .Left            = 422
639:                     .Width           = 75
640:                     .Height          = 75
641:                     .FontName        = "Comic Sans MS"
642:                     .FontSize        = 8
643:                     .FontBold        = .T.
644:                     .FontItalic      = .T.
645:                     .ForeColor       = RGB(90, 90, 90)
646:                     .BackColor       = RGB(255, 255, 255)
647:                     .Themes          = .F.
648:                     .SpecialEffect   = 0
649:                     .MousePointer    = 15
650:                     .WordWrap        = .T.
651:                     .AutoSize        = .F.
652:                     .Visible         = .T.
653:                 ENDWITH
654: 
655:                 *-- Botao Video (Visualizar relatorio)
656:                 .AddObject("cmd_4c_ImpVideo", "CommandButton")
657:                 WITH .cmd_4c_ImpVideo
658:                     .Caption         = "\<V" + CHR(237) + "deo"
659:                     .Picture         = gc_4c_CaminhoIcones + "geral_visualizar_32.jpg"
660:                     .PicturePosition = 13
661:                     .Top             = 3
662:                     .Left            = 347
663:                     .Width           = 75
664:                     .Height          = 75
665:                     .FontName        = "Comic Sans MS"
666:                     .FontSize        = 8
667:                     .FontBold        = .T.
668:                     .FontItalic      = .T.
669:                     .ForeColor       = RGB(90, 90, 90)
670:                     .BackColor       = RGB(255, 255, 255)
671:                     .Themes          = .F.
672:                     .SpecialEffect   = 0
673:                     .MousePointer    = 15
674:                     .WordWrap        = .T.
675:                     .AutoSize        = .F.
676:                     .Visible         = .T.
677:                 ENDWITH
678: 
679:                 *-- Botao Impressora
680:                 .AddObject("cmd_4c_ImpImpressora", "CommandButton")
681:                 WITH .cmd_4c_ImpImpressora
682:                     .Caption         = "\<Impressora"
683:                     .Picture         = gc_4c_CaminhoIcones + "geral_imprimir_32.jpg"
684:                     .PicturePosition = 13
685:                     .Top             = 3
686:                     .Left            = 272
687:                     .Width           = 75
688:                     .Height          = 75
689:                     .FontName        = "Comic Sans MS"
690:                     .FontSize        = 8
691:                     .FontBold        = .T.
692:                     .FontItalic      = .T.
693:                     .ForeColor       = RGB(90, 90, 90)
694:                     .BackColor       = RGB(255, 255, 255)
695:                     .Themes          = .F.
696:                     .SpecialEffect   = 0
697:                     .MousePointer    = 15
698:                     .WordWrap        = .T.
699:                     .AutoSize        = .F.
700:                     .Visible         = .T.
701:                 ENDWITH
702: 
703:                 *-- Botao Fechar painel (cmd_grupo do legado)
704:                 .AddObject("cmd_4c_ImpFechar", "CommandButton")
705:                 WITH .cmd_4c_ImpFechar
706:                     .Caption         = "Fechar"
707:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
708:                     .PicturePosition = 13
709:                     .Top             = -2
710:                     .Left            = 493
711:                     .Width           = 85
712:                     .Height          = 85
713:                     .FontName        = "Comic Sans MS"
714:                     .FontSize        = 8
715:                     .FontBold        = .T.
716:                     .FontItalic      = .T.
717:                     .ForeColor       = RGB(90, 90, 90)
718:                     .BackColor       = RGB(255, 255, 255)
719:                     .Themes          = .F.

*-- Linhas 732 a 741:
732:             *----------------------------------------------------------------------
733:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
734:             loc_oGrid = loc_oPagina.grd_4c_Lista
735:             loc_oGrid.Top               = 200
736:             loc_oGrid.Left              = 2
737:             loc_oGrid.Width             = 910
738:             loc_oGrid.Height            = 389
739:             loc_oGrid.FontName          = "Verdana"
740:             loc_oGrid.FontSize          = 8
741:             loc_oGrid.ForeColor         = RGB(90, 90, 90)

*-- Linhas 754 a 800:
754:             *-- ColumnCount FORA do WITH para criar colunas imediatamente
755:             loc_oGrid.ColumnCount       = 4
756:             WITH loc_oGrid
757:                 .Column1.Header1.Caption  = "Lista de Pre" + CHR(231) + "os"
758:                 .Column1.Width            = 250
759:                 .Column1.ReadOnly         = .T.
760:                 .Column2.Header1.Caption  = "Cond. Pagamento"
761:                 .Column2.Width            = 130
762:                 .Column2.ReadOnly         = .T.
763:                 .Column3.Header1.Caption  = "Vencimento"
764:                 .Column3.Width            = 120
765:                 .Column3.ReadOnly         = .T.
766:                 .Column4.Header1.Caption  = "Atualizada"
767:                 .Column4.Width            = 80
768:                 .Column4.ReadOnly         = .T.
769:             ENDWITH
770: 
771:             *----------------------------------------------------------------------
772:             * BINDEVENTs dos botoes (todos os handlers devem ser PUBLIC)
773:             *----------------------------------------------------------------------
774:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
775:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
776:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
777:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
778:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
779:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
780:             BINDEVENT(loc_oPagina.cmd_4c_Atualizar,                "Click", THIS, "BtnAtualizarClick")
781:             BINDEVENT(loc_oPagina.cmd_4c_ImprimirLista,            "Click", THIS, "BtnImprimirListaClick")
782:             BINDEVENT(loc_oPagina.cnt_4c_Filtros.opt_4c_Vencimento, "InteractiveChange", THIS, "FiltroVencimentoChanged")
783:             BINDEVENT(loc_oPagina.cnt_4c_ImpLista.cmd_4c_ImpVideo,      "Click", THIS, "BtnImpVideoClick")
784:             BINDEVENT(loc_oPagina.cnt_4c_ImpLista.cmd_4c_ImpImpressora, "Click", THIS, "BtnImpImpressoraClick")
785:             BINDEVENT(loc_oPagina.cnt_4c_ImpLista.cmd_4c_ImpExcel,      "Click", THIS, "BtnImpExcelClick")
786:             BINDEVENT(loc_oPagina.cnt_4c_ImpLista.cmd_4c_ImpFechar,     "Click", THIS, "BtnImpFecharClick")
787: 
788:             THIS.TornarControlesVisiveis(loc_oPagina)
789: 
790:         CATCH TO loException
791:             MsgErro("Erro: " + loException.Message, "FormLpr.ConfigurarPaginaLista")
792:         ENDTRY
793:     ENDPROC
794: 
795:     *==========================================================================
796:     * ConfigurarPaginaDados - Page2: campos do cabecalho SigCdLpc (Fase 5)
797:     * Campos: Empresa, Codigo, Lpreco, Fpg, area de busca na grade, botoes
798:     * Fase 6 adiciona: Grade/GradeC (itens SigCdLpi) e controles ocultos
799:     *==========================================================================
800:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 810 a 858:
810:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
811:             loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao
812:             WITH loc_oCnt
813:                 .Top         = 33
814:                 .Left        = 842
815:                 .Width       = 160
816:                 .Height      = 85
817:                 .BackStyle   = 0
818:                 .Visible     = .T.
819: 
820:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
821:                 WITH .cmd_4c_Confirmar
822:                     .Caption         = "Confirmar"
823:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
824:                     .PicturePosition = 13
825:                     .Top             = 5
826:                     .Left            = 5
827:                     .Width           = 75
828:                     .Height          = 75
829:                     .FontName        = "Comic Sans MS"
830:                     .FontSize        = 8
831:                     .FontBold        = .T.
832:                     .FontItalic      = .T.
833:                     .ForeColor       = RGB(90, 90, 90)
834:                     .BackColor       = RGB(255, 255, 255)
835:                     .Themes          = .F.
836:                     .SpecialEffect   = 0
837:                     .MousePointer    = 15
838:                     .WordWrap        = .T.
839:                     .AutoSize        = .F.
840:                     .Visible         = .T.
841:                 ENDWITH
842: 
843:                 .AddObject("cmd_4c_Cancelar", "CommandButton")
844:                 WITH .cmd_4c_Cancelar
845:                     .Caption         = "Encerrar"
846:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
847:                     .PicturePosition = 13
848:                     .Top             = 5
849:                     .Left            = 80
850:                     .Width           = 75
851:                     .Height          = 75
852:                     .FontName        = "Comic Sans MS"
853:                     .FontSize        = 8
854:                     .FontBold        = .T.
855:                     .FontItalic      = .T.
856:                     .ForeColor       = RGB(90, 90, 90)
857:                     .BackColor       = RGB(255, 255, 255)
858:                     .Themes          = .F.

*-- Linhas 870 a 879:
870:             *----------------------------------------------------------------------
871:             loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
872:             WITH loc_oPagina.shp_4c_Shape1
873:                 .Top         = 37
874:                 .Left        = 723
875:                 .Width       = 91
876:                 .Height      = 110
877:                 .BorderStyle = 1
878:                 .BorderColor = RGB(90, 90, 90)
879:                 .BackStyle   = 0

*-- Linhas 885 a 911:
885:             * Say4: top=16+29=45, left=56, width=50, height=15
886:             * txt_4c_Emps: top=12+29=41, left=108, width=35, height=23
887:             *----------------------------------------------------------------------
888:             loc_oPagina.AddObject("lbl_4c_Say4", "Label")
889:             WITH loc_oPagina.lbl_4c_Say4
890:                 .Caption   = "Empresa :"
891:                 .Top       = 45
892:                 .Left      = 56
893:                 .Width     = 50
894:                 .Height    = 15
895:                 .FontName  = "Tahoma"
896:                 .FontSize  = 8
897:                 .ForeColor = RGB(90, 90, 90)
898:                 .BackStyle = 0
899:                 .Visible   = .T.
900:             ENDWITH
901: 
902:             loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
903:             WITH loc_oPagina.txt_4c_Emps
904:                 .Value     = ""
905:                 .Top       = 41
906:                 .Left      = 108
907:                 .Width     = 35
908:                 .Height    = 23
909:                 .FontName  = "Tahoma"
910:                 .FontSize  = 8
911:                 .MaxLength = 3

*-- Linhas 917 a 943:
917:             * Say3: top=42+29=71, left=64, width=42, height=15
918:             * txt_4c_Codigo: top=38+29=67, left=108, width=94, height=23
919:             *----------------------------------------------------------------------
920:             loc_oPagina.AddObject("lbl_4c_Say3", "Label")
921:             WITH loc_oPagina.lbl_4c_Say3
922:                 .Caption   = "C" + CHR(243) + "digo :"
923:                 .Top       = 71
924:                 .Left      = 64
925:                 .Width     = 42
926:                 .Height    = 15
927:                 .FontName  = "Tahoma"
928:                 .FontSize  = 8
929:                 .ForeColor = RGB(90, 90, 90)
930:                 .BackStyle = 0
931:                 .Visible   = .T.
932:             ENDWITH
933: 
934:             loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
935:             WITH loc_oPagina.txt_4c_Codigo
936:                 .Value     = ""
937:                 .Top       = 67
938:                 .Left      = 108
939:                 .Width     = 94
940:                 .Height    = 23
941:                 .FontName  = "Tahoma"
942:                 .FontSize  = 8
943:                 .MaxLength = 30

*-- Linhas 952 a 961:
952:             loc_oPagina.AddObject("txt_4c_Lpreco", "TextBox")
953:             WITH loc_oPagina.txt_4c_Lpreco
954:                 .Value     = ""
955:                 .Top       = 67
956:                 .Left      = 205
957:                 .Width     = 290
958:                 .Height    = 23
959:                 .FontName  = "Tahoma"
960:                 .FontSize  = 8
961:                 .MaxLength = 30

*-- Linhas 967 a 993:
967:             * Say12: top=68+29=97, left=37, width=69, height=15
968:             * txt_4c_Fpg: top=65+29=94, left=108, width=94, height=23
969:             *----------------------------------------------------------------------
970:             loc_oPagina.AddObject("lbl_4c_Say12", "Label")
971:             WITH loc_oPagina.lbl_4c_Say12
972:                 .Caption   = "Cond. Pagto :"
973:                 .Top       = 97
974:                 .Left      = 37
975:                 .Width     = 69
976:                 .Height    = 15
977:                 .FontName  = "Tahoma"
978:                 .FontSize  = 8
979:                 .ForeColor = RGB(90, 90, 90)
980:                 .BackStyle = 0
981:                 .Visible   = .T.
982:             ENDWITH
983: 
984:             loc_oPagina.AddObject("txt_4c_Fpg", "TextBox")
985:             WITH loc_oPagina.txt_4c_Fpg
986:                 .Value     = ""
987:                 .Top       = 94
988:                 .Left      = 108
989:                 .Width     = 94
990:                 .Height    = 23
991:                 .FontName  = "Tahoma"
992:                 .FontSize  = 8
993:                 .MaxLength = 12

*-- Linhas 999 a 1070:
999:             *----------------------------------------------------------------------
1000:             loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
1001:             WITH loc_oPagina.shp_4c_Shape2
1002:                 .Top         = 174
1003:                 .Left        = 9
1004:                 .Width       = 980
1005:                 .Height      = 1
1006:                 .BorderStyle = 1
1007:                 .BorderColor = RGB(90, 90, 90)
1008:                 .BackStyle   = 0
1009:                 .Visible     = .T.
1010:             ENDWITH
1011: 
1012:             *----------------------------------------------------------------------
1013:             * Area de busca na grade (abaixo da linha separadora):
1014:             * lbl_4c_LblProcura: top=158+29=187, left=56, width=55, height=13
1015:             * txt_4c_Txtcpros:   top=154+29=183, left=108, width=119, height=22
1016:             * txt_4c_Txtdpros:   top=154+29=183, left=230, width=342, height=22
1017:             * cmd_4c_Busca:      top=149+29=178, left=576, width=36,  height=33
1018:             *----------------------------------------------------------------------
1019:             loc_oPagina.AddObject("lbl_4c_LblProcura", "Label")
1020:             WITH loc_oPagina.lbl_4c_LblProcura
1021:                 .Caption   = "Busca :"
1022:                 .Top       = 187
1023:                 .Left      = 56
1024:                 .Width     = 55
1025:                 .Height    = 13
1026:                 .FontName  = "Tahoma"
1027:                 .FontSize  = 8
1028:                 .ForeColor = RGB(90, 90, 90)
1029:                 .BackStyle = 0
1030:                 .Visible   = .T.
1031:             ENDWITH
1032: 
1033:             loc_oPagina.AddObject("txt_4c_Txtcpros", "TextBox")
1034:             WITH loc_oPagina.txt_4c_Txtcpros
1035:                 .Value     = ""
1036:                 .Top       = 183
1037:                 .Left      = 108
1038:                 .Width     = 119
1039:                 .Height    = 22
1040:                 .FontName  = "Tahoma"
1041:                 .FontSize  = 8
1042:                 .MaxLength = 14
1043:                 .Visible   = .T.
1044:             ENDWITH
1045: 
1046:             loc_oPagina.AddObject("txt_4c_Txtdpros", "TextBox")
1047:             WITH loc_oPagina.txt_4c_Txtdpros
1048:                 .Value     = ""
1049:                 .Top       = 183
1050:                 .Left      = 230
1051:                 .Width     = 342
1052:                 .Height    = 22
1053:                 .FontName  = "Tahoma"
1054:                 .FontSize  = 8
1055:                 .MaxLength = 40
1056:                 .Visible   = .T.
1057:             ENDWITH
1058: 
1059:             loc_oPagina.AddObject("cmd_4c_Busca", "CommandButton")
1060:             WITH loc_oPagina.cmd_4c_Busca
1061:                 .Caption         = ""
1062:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
1063:                 .PicturePosition = 0
1064:                 .Top             = 178
1065:                 .Left            = 576
1066:                 .Width           = 36
1067:                 .Height          = 33
1068:                 .FontName        = "Tahoma"
1069:                 .FontSize        = 8
1070:                 .Themes          = .F.

*-- Linhas 1076 a 1101:
1076:             *----------------------------------------------------------------------
1077:             * BINDEVENTs dos controles da Page2 (Fase 5)
1078:             *----------------------------------------------------------------------
1079:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click",     THIS, "BtnSalvarClick")
1080:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click",     THIS, "BtnCancelarClick")
1081:             BINDEVENT(loc_oPagina.txt_4c_Emps,    "KeyPress",                     THIS, "ValidarEmpresa")
1082:             BINDEVENT(loc_oPagina.txt_4c_Lpreco,  "KeyPress",                     THIS, "ValidarLpreco")
1083:             BINDEVENT(loc_oPagina.txt_4c_Fpg,     "KeyPress",                     THIS, "ValidarFpg")
1084:             BINDEVENT(loc_oPagina.txt_4c_Txtcpros, "KeyPress",                    THIS, "ValidarCpros")
1085:             BINDEVENT(loc_oPagina.txt_4c_Txtdpros, "KeyPress",                    THIS, "ValidarDpros")
1086:             BINDEVENT(loc_oPagina.cmd_4c_Busca,   "Click",                         THIS, "BtnBuscaGradeClick")
1087: 
1088:             *----------------------------------------------------------------------
1089:             * grd_4c_GradeC - Grade modo COMPRA (7 colunas)
1090:             * top=184+29=213, left=8, width=982, height=293
1091:             * ControlSources sao vinculados em VincularGrade() quando cursor existe
1092:             *----------------------------------------------------------------------
1093:             loc_oPagina.AddObject("grd_4c_GradeC", "Grid")
1094:             WITH loc_oPagina.grd_4c_GradeC
1095:                 .Top          = 213
1096:                 .Left         = 8
1097:                 .Width        = 982
1098:                 .Height       = 293
1099:                 .ColumnCount  = 7
1100:                 .ReadOnly     = .F.
1101:                 .GridLines    = 1

*-- Linhas 1134 a 1143:
1134:             *----------------------------------------------------------------------
1135:             loc_oPagina.AddObject("grd_4c_Grade", "Grid")
1136:             WITH loc_oPagina.grd_4c_Grade
1137:                 .Top          = 213
1138:                 .Left         = 8
1139:                 .Width        = 982
1140:                 .Height       = 293
1141:                 .ColumnCount  = 9
1142:                 .ReadOnly     = .F.
1143:                 .GridLines    = 1

*-- Linhas 1181 a 1287:
1181:             * INSERE=left28, DELETE=left103, COPIA=left178, Seleciona=left253
1182:             * CmdVencimento=left328 - todos width=75, height=75
1183:             *----------------------------------------------------------------------
1184:             loc_oPagina.AddObject("cmd_4c_INSERE", "CommandButton")
1185:             WITH loc_oPagina.cmd_4c_INSERE
1186:                 .Caption         = "Inserir"
1187:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
1188:                 .PicturePosition = 13
1189:                 .Top             = 528
1190:                 .Left            = 28
1191:                 .Width           = 75
1192:                 .Height          = 75
1193:                 .FontName        = "Comic Sans MS"
1194:                 .FontSize        = 8
1195:                 .FontBold        = .T.
1196:                 .FontItalic      = .T.
1197:                 .ForeColor       = RGB(90, 90, 90)
1198:                 .Themes          = .F.
1199:                 .SpecialEffect   = 0
1200:                 .MousePointer    = 15
1201:                 .WordWrap        = .T.
1202:                 .AutoSize        = .F.
1203:                 .Visible         = .T.
1204:             ENDWITH
1205: 
1206:             loc_oPagina.AddObject("cmd_4c_DELETE", "CommandButton")
1207:             WITH loc_oPagina.cmd_4c_DELETE
1208:                 .Caption         = "Excluir"
1209:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1210:                 .PicturePosition = 13
1211:                 .Top             = 528
1212:                 .Left            = 103
1213:                 .Width           = 75
1214:                 .Height          = 75
1215:                 .FontName        = "Comic Sans MS"
1216:                 .FontSize        = 8
1217:                 .FontBold        = .T.
1218:                 .FontItalic      = .T.
1219:                 .ForeColor       = RGB(90, 90, 90)
1220:                 .Themes          = .F.
1221:                 .SpecialEffect   = 0
1222:                 .MousePointer    = 15
1223:                 .WordWrap        = .T.
1224:                 .AutoSize        = .F.
1225:                 .Visible         = .T.
1226:             ENDWITH
1227: 
1228:             loc_oPagina.AddObject("cmd_4c_COPIA", "CommandButton")
1229:             WITH loc_oPagina.cmd_4c_COPIA
1230:                 .Caption         = "Duplicar"
1231:                 .Picture         = gc_4c_CaminhoIcones + "geral_duplicar_60.jpg"
1232:                 .PicturePosition = 13
1233:                 .Top             = 528
1234:                 .Left            = 178
1235:                 .Width           = 75
1236:                 .Height          = 75
1237:                 .FontName        = "Comic Sans MS"
1238:                 .FontSize        = 8
1239:                 .FontBold        = .T.
1240:                 .FontItalic      = .T.
1241:                 .ForeColor       = RGB(90, 90, 90)
1242:                 .Themes          = .F.
1243:                 .SpecialEffect   = 0
1244:                 .MousePointer    = 15
1245:                 .WordWrap        = .T.
1246:                 .AutoSize        = .F.
1247:                 .Visible         = .T.
1248:             ENDWITH
1249: 
1250:             loc_oPagina.AddObject("cmd_4c_Seleciona", "CommandButton")
1251:             WITH loc_oPagina.cmd_4c_Seleciona
1252:                 .Caption         = "Selecionar"
1253:                 .Picture         = gc_4c_CaminhoIcones + "geral_marcar_60.jpg"
1254:                 .PicturePosition = 13
1255:                 .Top             = 528
1256:                 .Left            = 253
1257:                 .Width           = 75
1258:                 .Height          = 75
1259:                 .FontName        = "Comic Sans MS"
1260:                 .FontSize        = 8
1261:                 .FontBold        = .T.
1262:                 .FontItalic      = .T.
1263:                 .ForeColor       = RGB(90, 90, 90)
1264:                 .Themes          = .F.
1265:                 .SpecialEffect   = 0
1266:                 .MousePointer    = 15
1267:                 .WordWrap        = .T.
1268:                 .AutoSize        = .F.
1269:                 .Visible         = .T.
1270:             ENDWITH
1271: 
1272:             loc_oPagina.AddObject("cmd_4c_CmdVencimento", "CommandButton")
1273:             WITH loc_oPagina.cmd_4c_CmdVencimento
1274:                 .Caption         = "Vencimento"
1275:                 .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
1276:                 .PicturePosition = 13
1277:                 .Top             = 528
1278:                 .Left            = 328
1279:                 .Width           = 75
1280:                 .Height          = 75
1281:                 .FontName        = "Comic Sans MS"
1282:                 .FontSize        = 8
1283:                 .FontBold        = .T.
1284:                 .FontItalic      = .T.
1285:                 .ForeColor       = RGB(90, 90, 90)
1286:                 .Themes          = .F.
1287:                 .SpecialEffect   = 0

*-- Linhas 1297 a 1355:
1297:             *----------------------------------------------------------------------
1298:             loc_oPagina.AddObject("cnt_4c_Vencimentos", "Container")
1299:             WITH loc_oPagina.cnt_4c_Vencimentos
1300:                 .Top         = 528
1301:                 .Left        = 415
1302:                 .Width       = 200
1303:                 .Height      = 75
1304:                 .BackStyle   = 1
1305:                 .BackColor   = RGB(255, 255, 220)
1306:                 .Visible     = .F.
1307: 
1308:                 .AddObject("lbl_4c_VencSay", "Label")
1309:                 WITH .lbl_4c_VencSay
1310:                     .Caption   = "Vencimento Em:"
1311:                     .Top       = 10
1312:                     .Left      = 10
1313:                     .Width     = 90
1314:                     .Height    = 15
1315:                     .BackStyle = 0
1316:                     .FontName  = "Tahoma"
1317:                     .FontSize  = 8
1318:                     .Visible   = .T.
1319:                 ENDWITH
1320: 
1321:                 .AddObject("txt_4c_GetVencs", "TextBox")
1322:                 WITH .txt_4c_GetVencs
1323:                     .Value    = {}
1324:                     .Top      = 30
1325:                     .Left     = 10
1326:                     .Width    = 80
1327:                     .Height   = 23
1328:                     .FontName = "Tahoma"
1329:                     .FontSize = 8
1330:                     .Visible  = .T.
1331:                 ENDWITH
1332: 
1333:                 .AddObject("cmd_4c_SalvaVenc", "CommandButton")
1334:                 WITH .cmd_4c_SalvaVenc
1335:                     .Caption   = "OK"
1336:                     .Top       = 15
1337:                     .Left      = 100
1338:                     .Width     = 42
1339:                     .Height    = 42
1340:                     .FontName  = "Tahoma"
1341:                     .FontSize  = 8
1342:                     .Themes    = .F.
1343:                     .Visible   = .T.
1344:                 ENDWITH
1345: 
1346:                 .AddObject("cmd_4c_FechaVenc", "CommandButton")
1347:                 WITH .cmd_4c_FechaVenc
1348:                     .Caption   = "X"
1349:                     .Top       = 15
1350:                     .Left      = 148
1351:                     .Width     = 42
1352:                     .Height    = 42
1353:                     .FontName  = "Tahoma"
1354:                     .FontSize  = 8
1355:                     .Themes    = .F.

*-- Linhas 1363 a 1549:
1363:             * opt_4c_Opt_ApliTabD  : top=91+29=120, left=621 - aplica tab.desconto
1364:             * opt_4c_Opt_Vencimento: top=63+29=92,  left=621 - tipo vencimento
1365:             * opt_4c_Opt_Formula   : top=38+29=67,  left=621 - tipo formula
1366:             * lbl_4c_Say9          : top=42+29=71,  left=540 - "Aplica Formulas"
1367:             * txt_4c_Tabd          : top=91+29=120, left=108 - tabela desconto
1368:             * txt_4c_Juros         : top=91+29=120, left=294 - % juros a.m.
1369:             * cmd_4c_SelecionaC    : top=2+29=31,   left=773 - sel.produtos compra
1370:             *----------------------------------------------------------------------
1371:             loc_oPagina.AddObject("opt_4c_Opt_Comissao", "OptionGroup")
1372:             WITH loc_oPagina.opt_4c_Opt_Comissao
1373:                 .ButtonCount = 2
1374:                 .Top         = 92
1375:                 .Left        = 288
1376:                 .Width       = 94
1377:                 .Height      = 22
1378:                 .Value       = 1
1379:                 .BackStyle   = 0
1380:                 .Visible     = .F.
1381:                 WITH .Buttons(1)
1382:                     .Caption   = "Sim"
1383:                     .Left      = 0
1384:                     .Top       = 3
1385:                     .Width     = 40
1386:                     .AutoSize  = .T.
1387:                     .ForeColor = RGB(90, 90, 90)
1388:                     .Themes    = .F.
1389:                 ENDWITH
1390:                 WITH .Buttons(2)
1391:                     .Caption   = "N" + CHR(227) + "o"
1392:                     .Left      = 44
1393:                     .Top       = 3
1394:                     .Width     = 50
1395:                     .AutoSize  = .T.
1396:                     .ForeColor = RGB(90, 90, 90)
1397:                     .FontName  = "Tahoma"
1398:                     .FontSize  = 8
1399:                     .Themes    = .F.
1400:                 ENDWITH
1401:             ENDWITH
1402: 
1403:             loc_oPagina.AddObject("opt_4c_Opt_ApliTabD", "OptionGroup")
1404:             WITH loc_oPagina.opt_4c_Opt_ApliTabD
1405:                 .ButtonCount = 2
1406:                 .Top         = 120
1407:                 .Left        = 621
1408:                 .Width       = 94
1409:                 .Height      = 22
1410:                 .Value       = 1
1411:                 .BackStyle   = 0
1412:                 .Visible     = .F.
1413:                 WITH .Buttons(1)
1414:                     .Caption   = "Sim"
1415:                     .Left      = 0
1416:                     .Top       = 3
1417:                     .Width     = 40
1418:                     .AutoSize  = .T.
1419:                     .ForeColor = RGB(90, 90, 90)
1420:                     .Themes    = .F.
1421:                 ENDWITH
1422:                 WITH .Buttons(2)
1423:                     .Caption   = "N" + CHR(227) + "o"
1424:                     .Left      = 44
1425:                     .Top       = 3
1426:                     .Width     = 50
1427:                     .AutoSize  = .T.
1428:                     .ForeColor = RGB(90, 90, 90)
1429:                     .FontName  = "Tahoma"
1430:                     .FontSize  = 8
1431:                     .Themes    = .F.
1432:                 ENDWITH
1433:             ENDWITH
1434: 
1435:             loc_oPagina.AddObject("opt_4c_Opt_Vencimento", "OptionGroup")
1436:             WITH loc_oPagina.opt_4c_Opt_Vencimento
1437:                 .ButtonCount = 2
1438:                 .Top         = 92
1439:                 .Left        = 621
1440:                 .Width       = 94
1441:                 .Height      = 22
1442:                 .Value       = 1
1443:                 .BackStyle   = 0
1444:                 .Visible     = .F.
1445:                 WITH .Buttons(1)
1446:                     .Caption   = "Sim"
1447:                     .Left      = 0
1448:                     .Top       = 3
1449:                     .Width     = 40
1450:                     .AutoSize  = .T.
1451:                     .ForeColor = RGB(90, 90, 90)
1452:                     .Themes    = .F.
1453:                 ENDWITH
1454:                 WITH .Buttons(2)
1455:                     .Caption   = "N" + CHR(227) + "o"
1456:                     .Left      = 44
1457:                     .Top       = 3
1458:                     .Width     = 50
1459:                     .AutoSize  = .T.
1460:                     .ForeColor = RGB(90, 90, 90)
1461:                     .FontName  = "Tahoma"
1462:                     .FontSize  = 8
1463:                     .Themes    = .F.
1464:                 ENDWITH
1465:             ENDWITH
1466: 
1467:             loc_oPagina.AddObject("opt_4c_Opt_Formula", "OptionGroup")
1468:             WITH loc_oPagina.opt_4c_Opt_Formula
1469:                 .ButtonCount = 2
1470:                 .Top         = 67
1471:                 .Left        = 621
1472:                 .Width       = 94
1473:                 .Height      = 22
1474:                 .Value       = 1
1475:                 .BackStyle   = 0
1476:                 .Visible     = .F.
1477:                 WITH .Buttons(1)
1478:                     .Caption   = "Sim"
1479:                     .Left      = 0
1480:                     .Top       = 3
1481:                     .Width     = 40
1482:                     .AutoSize  = .T.
1483:                     .ForeColor = RGB(90, 90, 90)
1484:                     .Themes    = .F.
1485:                 ENDWITH
1486:                 WITH .Buttons(2)
1487:                     .Caption   = "N" + CHR(227) + "o"
1488:                     .Left      = 44
1489:                     .Top       = 3
1490:                     .Width     = 50
1491:                     .AutoSize  = .T.
1492:                     .ForeColor = RGB(90, 90, 90)
1493:                     .FontName  = "Tahoma"
1494:                     .FontSize  = 8
1495:                     .Themes    = .F.
1496:                 ENDWITH
1497:             ENDWITH
1498: 
1499:             loc_oPagina.AddObject("lbl_4c_Say9", "Label")
1500:             WITH loc_oPagina.lbl_4c_Say9
1501:                 .Caption   = "Aplica F" + CHR(243) + "rmulas :"
1502:                 .Top       = 71
1503:                 .Left      = 540
1504:                 .Width     = 80
1505:                 .Height    = 15
1506:                 .FontName  = "Tahoma"
1507:                 .FontSize  = 8
1508:                 .ForeColor = RGB(90, 90, 90)
1509:                 .BackStyle = 0
1510:                 .Visible   = .F.
1511:             ENDWITH
1512: 
1513:             loc_oPagina.AddObject("txt_4c_Tabd", "TextBox")
1514:             WITH loc_oPagina.txt_4c_Tabd
1515:                 .Value     = ""
1516:                 .Top       = 120
1517:                 .Left      = 108
1518:                 .Width     = 94
1519:                 .Height    = 23
1520:                 .FontName  = "Tahoma"
1521:                 .FontSize  = 8
1522:                 .MaxLength = 10
1523:                 .Visible   = .F.
1524:             ENDWITH
1525: 
1526:             loc_oPagina.AddObject("txt_4c_Juros", "TextBox")
1527:             WITH loc_oPagina.txt_4c_Juros
1528:                 .Value    = 0
1529:                 .Top      = 120
1530:                 .Left     = 294
1531:                 .Width    = 69
1532:                 .Height   = 23
1533:                 .FontName = "Tahoma"
1534:                 .FontSize = 8
1535:                 .Visible  = .F.
1536:             ENDWITH
1537: 
1538:             loc_oPagina.AddObject("cmd_4c_SelecionaC", "CommandButton")
1539:             WITH loc_oPagina.cmd_4c_SelecionaC
1540:                 .Caption         = "Selecionar Produtos"
1541:                 .Picture         = gc_4c_CaminhoIcones + "geral_marcar_60.jpg"
1542:                 .PicturePosition = 13
1543:                 .Top             = 31
1544:                 .Left            = 773
1545:                 .Width           = 75
1546:                 .Height          = 75
1547:                 .FontName        = "Comic Sans MS"
1548:                 .FontSize        = 8
1549:                 .FontBold        = .T.

*-- Linhas 1563 a 1676:
1563:             *----------------------------------------------------------------------
1564:             loc_oPagina.AddObject("cnt_4c_Compra", "Container")
1565:             WITH loc_oPagina.cnt_4c_Compra
1566:                 .Top         = 118
1567:                 .Left        = -15
1568:                 .Width       = 512
1569:                 .Height      = 51
1570:                 .BackStyle   = 0
1571:                 .Visible     = .F.
1572: 
1573:                 .AddObject("lbl_4c_CompraIndice", "Label")
1574:                 WITH .lbl_4c_CompraIndice
1575:                     .Caption   = CHR(205) + "ndice Reajuste :"
1576:                     .Top       = 32
1577:                     .Left      = 37
1578:                     .Width     = 85
1579:                     .Height    = 15
1580:                     .BackStyle = 0
1581:                     .FontName  = "Tahoma"
1582:                     .FontSize  = 8
1583:                     .Visible   = .T.
1584:                 ENDWITH
1585: 
1586:                 .AddObject("txt_4c_GetIndice", "TextBox")
1587:                 WITH .txt_4c_GetIndice
1588:                     .Value    = ""
1589:                     .Top      = 28
1590:                     .Left     = 123
1591:                     .Width    = 94
1592:                     .Height   = 23
1593:                     .FontName = "Tahoma"
1594:                     .FontSize = 8
1595:                     .Visible  = .T.
1596:                 ENDWITH
1597: 
1598:                 .AddObject("lbl_4c_CompraForn", "Label")
1599:                 WITH .lbl_4c_CompraForn
1600:                     .Caption   = "Fornecedor :"
1601:                     .Top       = 5
1602:                     .Left      = 57
1603:                     .Width     = 70
1604:                     .Height    = 15
1605:                     .BackStyle = 0
1606:                     .FontName  = "Tahoma"
1607:                     .FontSize  = 8
1608:                     .Visible   = .F.
1609:                 ENDWITH
1610: 
1611:                 .AddObject("txt_4c_GetConta", "TextBox")
1612:                 WITH .txt_4c_GetConta
1613:                     .Value    = ""
1614:                     .Top      = 2
1615:                     .Left     = 123
1616:                     .Width    = 94
1617:                     .Height   = 23
1618:                     .FontName = "Tahoma"
1619:                     .FontSize = 8
1620:                     .Visible  = .F.
1621:                 ENDWITH
1622: 
1623:                 .AddObject("txt_4c_GetDconta", "TextBox")
1624:                 WITH .txt_4c_GetDconta
1625:                     .Value    = ""
1626:                     .Top      = 2
1627:                     .Left     = 219
1628:                     .Width    = 290
1629:                     .Height   = 23
1630:                     .FontName = "Tahoma"
1631:                     .FontSize = 8
1632:                     .Visible  = .F.
1633:                 ENDWITH
1634: 
1635:                 .AddObject("lbl_4c_CompraDataIni", "Label")
1636:                 WITH .lbl_4c_CompraDataIni
1637:                     .Caption   = "Data Inicial :"
1638:                     .Top       = 32
1639:                     .Left      = 246
1640:                     .Width     = 70
1641:                     .Height    = 15
1642:                     .BackStyle = 0
1643:                     .FontName  = "Tahoma"
1644:                     .FontSize  = 8
1645:                     .Visible   = .F.
1646:                 ENDWITH
1647: 
1648:                 .AddObject("txt_4c_FwVenc", "TextBox")
1649:                 WITH .txt_4c_FwVenc
1650:                     .Value    = {}
1651:                     .Top      = 28
1652:                     .Left     = 310
1653:                     .Width    = 80
1654:                     .Height   = 23
1655:                     .FontName = "Tahoma"
1656:                     .FontSize = 8
1657:                     .Visible  = .F.
1658:                 ENDWITH
1659:             ENDWITH
1660: 
1661:             *----------------------------------------------------------------------
1662:             * BINDEVENTs para controles adicionados na Fase 6
1663:             *----------------------------------------------------------------------
1664:             BINDEVENT(loc_oPagina.cmd_4c_INSERE,        "Click",            THIS, "BtnINSEREClick")
1665:             BINDEVENT(loc_oPagina.cmd_4c_DELETE,        "Click",            THIS, "BtnDELETEClick")
1666:             BINDEVENT(loc_oPagina.cmd_4c_COPIA,         "Click",            THIS, "BtnCOPIAClick")
1667:             BINDEVENT(loc_oPagina.cmd_4c_Seleciona,     "Click",            THIS, "BtnSelecionaClick")
1668:             BINDEVENT(loc_oPagina.cmd_4c_CmdVencimento, "Click",            THIS, "BtnCmdVencimentoClick")
1669:             BINDEVENT(loc_oPagina.cnt_4c_Vencimentos.cmd_4c_SalvaVenc, "Click", THIS, "BtnSalvaVencimentoClick")
1670:             BINDEVENT(loc_oPagina.cnt_4c_Vencimentos.cmd_4c_FechaVenc, "Click", THIS, "BtnFechaVencimentoClick")
1671:             BINDEVENT(loc_oPagina.cmd_4c_SelecionaC,   "Click",            THIS, "BtnSelecionaCClick")
1672:             BINDEVENT(loc_oPagina.grd_4c_Grade,  "AfterRowColChange", THIS, "GradeAfterRowColChange")
1673:             BINDEVENT(loc_oPagina.grd_4c_GradeC, "AfterRowColChange", THIS, "GradeAfterRowColChange")
1674:             BINDEVENT(loc_oPagina.txt_4c_Tabd, "KeyPress", THIS, "ValidarTabd")
1675:             BINDEVENT(loc_oPagina.txt_4c_Tabd, "KeyPress",  THIS, "TeclaTabd")
1676:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetConta,  "KeyPress", THIS, "ValidarGetConta")

*-- Linhas 1685 a 1705:
1685:             loc_oPagina.opt_4c_Opt_ApliTabD.Visible   = .F.
1686:             loc_oPagina.opt_4c_Opt_Vencimento.Visible = .F.
1687:             loc_oPagina.opt_4c_Opt_Formula.Visible    = .F.
1688:             loc_oPagina.lbl_4c_Say9.Visible           = .F.
1689:             loc_oPagina.txt_4c_Tabd.Visible           = .F.
1690:             loc_oPagina.txt_4c_Juros.Visible          = .F.
1691:             loc_oPagina.cmd_4c_SelecionaC.Visible     = .F.
1692: 
1693:         CATCH TO loException
1694:             MsgErro("Erro: " + loException.Message, "FormLpr.ConfigurarPaginaDados")
1695:         ENDTRY
1696:     ENDPROC
1697: 
1698:     *==========================================================================
1699:     * BtnSalvarClick - Salva o cabecalho da lista de precos (SigCdLpc)
1700:     * Chamado pelo cmd_4c_Confirmar da Page2
1701:     *==========================================================================
1702:     PROCEDURE BtnSalvarClick()
1703:         LOCAL loc_lSucesso
1704:         loc_lSucesso = .F.
1705: 

*-- Linhas 2148 a 2157:
2148:             loc_oPg2.txt_4c_Txtcpros.ReadOnly = !par_lHabilitar
2149:             loc_oPg2.txt_4c_Txtdpros.ReadOnly = !par_lHabilitar
2150:             *-- Botoes acao
2151:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
2152:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2153: 
2154:         CATCH TO loException
2155:             MsgErro("Erro: " + loException.Message, "FormLpr.HabilitarCampos")
2156:         ENDTRY
2157:     ENDPROC

*-- Linhas 2214 a 2228:
2214:                     ELSE
2215:                         loc_oGrid.RecordSource = ""
2216:                     ENDIF
2217:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
2218:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
2219:                     loc_oGrid.Column3.Header1.Caption = "Ref.Fornecedor"
2220:                     loc_oGrid.Column4.Header1.Caption = "EAN"
2221:                     loc_oGrid.Column5.Header1.Caption = "Custo Atual"
2222:                     loc_oGrid.Column6.Header1.Caption = "Moe"
2223:                     loc_oGrid.Column7.Header1.Caption = "Custo Novo"
2224:                     loc_oGrid.FontName = "Verdana"
2225:                     loc_oGrid.FontSize = 8
2226:                     loc_oGrid.Visible = .T.
2227:                     loc_oGrid.Refresh()
2228:                 ENDIF

*-- Linhas 2248 a 2264:
2248:                     ELSE
2249:                         loc_oGrid.RecordSource = ""
2250:                     ENDIF
2251:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
2252:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
2253:                     loc_oGrid.Column3.Header1.Caption = "Pr. Venda"
2254:                     loc_oGrid.Column4.Header1.Caption = "Moe"
2255:                     loc_oGrid.Column5.Header1.Caption = "Comiss."
2256:                     loc_oGrid.Column6.Header1.Caption = "Venc. Inicial"
2257:                     loc_oGrid.Column7.Header1.Caption = "Venc. Final"
2258:                     loc_oGrid.Column8.Header1.Caption = "C"
2259:                     loc_oGrid.Column9.Header1.Caption = "Pr. De"
2260:                     loc_oGrid.FontName = "Verdana"
2261:                     loc_oGrid.FontSize = 8
2262:                     loc_oGrid.Visible = .T.
2263:                     loc_oGrid.Refresh()
2264:                 ENDIF

*-- Linhas 2685 a 2696:
2685:                             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.fpags"
2686:                             loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.vencis"
2687:                             loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.flags"
2688:                             loc_oGrid.Column1.Header1.Caption = "Lista de Pre" + CHR(231) + "os"
2689:                             loc_oGrid.Column2.Header1.Caption = "Cond. Pagamento"
2690:                             loc_oGrid.Column3.Header1.Caption = "Vencimento"
2691:                             loc_oGrid.Column4.Header1.Caption = "Atualizada"
2692:                             THIS.FormatarGridLista(loc_oGrid)
2693:                             loc_oGrid.Refresh()
2694:                         ENDIF
2695:                     ENDIF
2696: 


### BO (C:\4c\projeto\app\classes\LprBO.prg):
*------------------------------------------------------------------------------
* LprBO.prg - Business Object para Listas de Precificacao
* Tabela principal: SigCdLpc (cabecalho da lista)
* Tabela detalhe  : SigCdLpi (itens da lista)
* Herda de        : BusinessBase
*------------------------------------------------------------------------------

DEFINE CLASS LprBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades SigCdLpc - campo a campo conforme schema.sql
    *--------------------------------------------------------------------------
    this_cLprecos    = ""    && c(30) PK  - codigo da lista de precos
    this_cFpags      = ""    && c(12)     - condicao de pagamento (FK SigOpFp)
    this_nFormulas   = 0     && n(1,0)    - tipo formula de calculo
    this_nComiss     = 0     && n(1,0)    - tipo calculo comissao
    this_nNvencs     = 0     && n(1,0)    - tipo vencimento
    this_cContas     = ""    && c(10)     - conta (modo compra: fornecedor)
    this_lFlags      = .F.   && bit       - ja atualizada no sistema
    this_cTipos      = ""    && c(1)      - tipo: "C"=compra, " "=venda
    this_dVencis     = {}    && datetime  - data vencimento inicial
    this_nAplictabds = 0     && n(1,0)    - aplica tabela de desconto
    this_cCidchaves  = ""    && c(20)     - chave unica
    this_nDescos     = 0     && n(5,2)    - percentual de desconto
    this_cTabds      = ""    && c(10)     - codigo tabela desconto (FK SigOpTdz)
    this_nCodigos    = 0     && n(6,0)    - codigo sequencial (gerado por fGerUniqueKey)
    this_cEmps       = ""    && c(3)      - empresa (FK SigCdEmp)
    this_nNqtdes     = 0     && n(5,0)    - quantidade minima

    *--------------------------------------------------------------------------
    * Propriedades auxiliares - descricoes (nao persistidas no banco)
    *--------------------------------------------------------------------------
    this_cDfpags     = ""    && descricao da condicao de pagamento
    this_cDtabds     = ""    && descricao da tabela de desconto
    this_cDemps      = ""    && razao social da empresa
    this_cDcontas    = ""    && descricao da conta (modo compra)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdLpc"
        THIS.this_cCampoChave = "lprecos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cLprecos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista cabecalhos SigCdLpc filtrados por empresa e tipo
    * par_cFiltro: "C"=compra, " "=venda (vazio = venda)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cTipos
        loc_lSucesso = .F.

        TRY
            loc_cTipos = IIF(VARTYPE(par_cFiltro) = "C" AND ALLTRIM(par_cFiltro) = "C", "C", " ")

            loc_cSQL = "SELECT DISTINCT a.lprecos, a.fpags, a.formulas, a.ncomiss," + ;
                       " a.nvencs, a.contas, a.flags, a.tipos, a.vencis," + ;
                       " a.aplictabds, a.cidchaves, a.descos, a.tabds," + ;
                       " a.codigos, a.emps, a.nqtdes" + ;
                       " FROM SigCdLpc a" + ;
                       " INNER JOIN SigCdLpi b ON a.lprecos = b.lprecos" + ;
                       " WHERE a.Tipos = " + EscaparSQL(loc_cTipos) + ;
                       " AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " ORDER BY a.lprecos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar listas de precifica" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar listas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um SigCdLpc pela PK lprecos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cLprecos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.lprecos, a.fpags, a.formulas, a.ncomiss," + ;
                       " a.nvencs, a.contas, a.flags, a.tipos, a.vencis," + ;
                       " a.aplictabds, a.cidchaves, a.descos, a.tabds," + ;
                       " a.codigos, a.emps, a.nqtdes" + ;
                       " FROM SigCdLpc a" + ;
                       " WHERE a.lprecos = " + EscaparSQL(par_cLprecos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cLprecos     = TratarNulo(lprecos,     "C")
            THIS.this_cFpags       = TratarNulo(fpags,       "C")
            THIS.this_nFormulas    = TratarNulo(formulas,    "N")
            THIS.this_nComiss      = TratarNulo(ncomiss,     "N")
            THIS.this_nNvencs      = TratarNulo(nvencs,      "N")
            THIS.this_cContas      = TratarNulo(contas,      "C")
            THIS.this_lFlags       = (TratarNulo(flags, "N") = 1)
            THIS.this_cTipos       = TratarNulo(tipos,       "C")
            THIS.this_dVencis      = TratarNulo(vencis,      "D")
            THIS.this_nAplictabds  = TratarNulo(aplictabds,  "N")
            THIS.this_cCidchaves   = TratarNulo(cidchaves,   "C")
            THIS.this_nDescos      = TratarNulo(descos,      "N")
            THIS.this_cTabds       = TratarNulo(tabds,       "C")
            THIS.this_nCodigos     = TratarNulo(codigos,     "N")
            THIS.this_cEmps        = TratarNulo(emps,        "C")
            THIS.this_nNqtdes      = TratarNulo(nqtdes,      "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdLpc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdLpc" + ;
                       " (lprecos, fpags, formulas, ncomiss, nvencs, contas," + ;
                       " flags, tipos, vencis, aplictabds, cidchaves, descos," + ;
                       " tabds, codigos, emps, nqtdes)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cLprecos) + "," + ;
                       EscaparSQL(THIS.this_cFpags) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFormulas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNvencs) + "," + ;
                       EscaparSQL(THIS.this_cContas) + "," + ;
                       IIF(THIS.this_lFlags, "1", "0") + "," + ;
                       EscaparSQL(THIS.this_cTipos) + "," + ;
                       FormatarDataSQL(THIS.this_dVencis) + "," + ;
                       FormatarNumeroSQL(THIS.this_nAplictabds) + "," + ;
                       EscaparSQL(THIS.this_cCidchaves) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDescos) + "," + ;
                       EscaparSQL(THIS.this_cTabds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                       EscaparSQL(THIS.this_cEmps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNqtdes) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdLpc (lprecos eh PK, nao alterar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdLpc SET" + ;
                       " fpags = " + EscaparSQL(THIS.this_cFpags) + "," + ;
                       " formulas = " + FormatarNumeroSQL(THIS.this_nFormulas) + "," + ;
                       " ncomiss = " + FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       " nvencs = " + FormatarNumeroSQL(THIS.this_nNvencs) + "," + ;
                       " contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " flags = " + IIF(THIS.this_lFlags, "1", "0") + "," + ;
                       " tipos = " + EscaparSQL(THIS.this_cTipos) + "," + ;
                       " vencis = " + FormatarDataSQL(THIS.this_dVencis) + "," + ;
                       " aplictabds = " + FormatarNumeroSQL(THIS.this_nAplictabds) + "," + ;
                       " descos = " + FormatarNumeroSQL(THIS.this_nDescos) + "," + ;
                       " tabds = " + EscaparSQL(THIS.this_cTabds) + "," + ;
                       " codigos = " + FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                       " emps = " + EscaparSQL(THIS.this_cEmps) + "," + ;
                       " nqtdes = " + FormatarNumeroSQL(THIS.this_nNqtdes) + ;
                       " WHERE lprecos = " + EscaparSQL(THIS.this_cLprecos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdLpi (itens) e SigCdLpc (cabecalho)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir itens primeiro (FK)
            loc_cSQL = "DELETE FROM SigCdLpi WHERE lprecos = " + ;
                       EscaparSQL(THIS.this_cLprecos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir cabecalho
                loc_cSQL = "DELETE FROM SigCdLpc WHERE lprecos = " + ;
                           EscaparSQL(THIS.this_cLprecos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - Carrega SigCdLpi de uma lista no cursor_4c_Itens
    * par_cLprecos: codigo da lista de precos
    * par_cTipos  : "C"=compra, " "=venda (determina colunas do grid)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens(par_cLprecos, par_cTipos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cLprecos))
            RETURN .F.
        ENDIF

        TRY

            IF VARTYPE(par_cTipos) != "C"
                par_cTipos = " "
            ENDIF

            IF ALLTRIM(par_cTipos) = "C"
                *-- Modo compra: colunas cpros, dpros, reffs, ean13, pcuss, moevs + custo novo
                loc_cSQL = "SELECT a.cidchaves, a.lprecos, a.cpros, a.dpros," + ;
                           " a.reffs, a.ean13, a.pcuss, a.moevs," + ;
                           " a.pvens, a.vencis, a.vencfs, a.comiss," + ;
                           " a.cgrus, a.flagutabs, a.ordems, a.ccontroles, a.precode" + ;
                           " FROM SigCdLpi a" + ;
                           " WHERE a.lprecos = " + EscaparSQL(par_cLprecos) + ;
                           " ORDER BY a.cpros"
            ELSE
                *-- Modo venda: colunas cpros, dpros, pvens, moevs, comiss, vencis, vencfs
                loc_cSQL = "SELECT a.cidchaves, a.lprecos, a.cpros, a.dpros," + ;
                           " a.pvens, a.moevs, a.comiss, a.vencis, a.vencfs," + ;
                           " a.cgrus, a.flagutabs, a.ordems, a.ccontroles," + ;
                           " a.ean13, a.pcuss, a.reffs, a.precode" + ;
                           " FROM SigCdLpi a" + ;
                           " WHERE a.lprecos = " + EscaparSQL(par_cLprecos) + ;
                           " ORDER BY a.cpros"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")
            IF loc_nResultado >= 0
                GO TOP IN cursor_4c_Itens
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar itens:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarItens - Persiste cursor_4c_Itens no SQL Server via DELETE+INSERT
    * par_cLprecos: codigo da lista de precos
    * Estrategia: DELETE todos do lprecos + INSERT dos nao-deletados do cursor
    *--------------------------------------------------------------------------
    PROCEDURE SalvarItens(par_cLprecos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lErroItem
        LOCAL loc_cCidchave, loc_cCpros, loc_cDpros, loc_cMoevs
        LOCAL loc_nPvens, loc_nComiss, loc_dVencis, loc_dVencfs
        LOCAL loc_cCgrus, loc_cReffs, loc_nEan13, loc_nPcuss
        LOCAL loc_nPrecode, loc_cOrdems
        loc_lSucesso = .F.
        loc_lErroItem = .F.

        IF !USED("cursor_4c_Itens")
            RETURN .F.
        ENDIF

        TRY
            *-- Excluir todos os itens existentes para este lprecos
            loc_cSQL = "DELETE FROM SigCdLpi WHERE lprecos = " + EscaparSQL(par_cLprecos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao limpar itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Inserir todos os itens nao-deletados do cursor
                SELECT cursor_4c_Itens
                GO TOP
                DO WHILE !EOF("cursor_4c_Itens") AND !loc_lErroItem
                    IF !DELETED("cursor_4c_Itens")
                        loc_cCpros   = ALLTRIM(TratarNulo(cpros,  "C"))
                        loc_cDpros   = ALLTRIM(TratarNulo(dpros,  "C"))
                        loc_cMoevs   = ALLTRIM(TratarNulo(moevs,  "C"))
                        loc_nPvens   = TratarNulo(pvens,   "N")
                        loc_nComiss  = TratarNulo(comiss,  "N")
                        loc_dVencis  = TratarNulo(vencis,  "D")
                        loc_dVencfs  = TratarNulo(vencfs,  "D")
                        loc_cCgrus   = ALLTRIM(TratarNulo(cgrus,  "C"))
                        loc_cReffs   = ALLTRIM(TratarNulo(reffs,  "C"))
                        loc_nEan13   = TratarNulo(ean13,   "N")
                        loc_nPcuss   = TratarNulo(pcuss,   "N")
                        loc_nPrecode = TratarNulo(precode, "N")
                        loc_cOrdems  = ALLTRIM(TratarNulo(ordems, "C"))

                        *-- Gerar cidchaves unico se vazio
                        loc_cCidchave = ALLTRIM(TratarNulo(cidchaves, "C"))
                        IF EMPTY(loc_cCidchave)
                            loc_cCidchave = THIS.GerarCidchave()
                        ENDIF

                        IF !EMPTY(loc_cCpros)
                            loc_cSQL = "INSERT INTO SigCdLpi" + ;
                                       " (cidchaves, lprecos, cpros, dpros, moevs," + ;
                                       " pvens, comiss, vencis, vencfs, cgrus," + ;
                                       " reffs, ean13, pcuss, precode, ordems," + ;
                                       " flagutabs, ccontroles)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cCidchave) + "," + ;
                                       EscaparSQL(par_cLprecos) + "," + ;
                                       EscaparSQL(loc_cCpros) + "," + ;
                                       EscaparSQL(loc_cDpros) + "," + ;
                                       EscaparSQL(loc_cMoevs) + "," + ;
                                       FormatarNumeroSQL(loc_nPvens) + "," + ;
                                       FormatarNumeroSQL(loc_nComiss) + "," + ;
                                       FormatarDataSQL(loc_dVencis) + "," + ;
                                       FormatarDataSQL(loc_dVencfs) + "," + ;
                                       EscaparSQL(loc_cCgrus) + "," + ;
                                       EscaparSQL(loc_cReffs) + "," + ;
                                       FormatarNumeroSQL(loc_nEan13) + "," + ;
                                       FormatarNumeroSQL(loc_nPcuss) + "," + ;
                                       FormatarNumeroSQL(loc_nPrecode) + "," + ;
                                       EscaparSQL(loc_cOrdems) + "," + ;
                                       "0,'')"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                MsgErro("Erro ao inserir item [" + loc_cCpros + "]:" + ;
                                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lErroItem = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_Itens
                    SKIP
                ENDDO

                IF !loc_lErroItem
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar itens:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCidchave - Gera chave unica para SigCdLpi.cidchaves (char 20)
    * Formato: emps(3) + lprecos(8) + cpros(5) + seq(4)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarCidchave()
        LOCAL loc_cChave, loc_nSeq, loc_cSQL, loc_nResult
        loc_nSeq = 0

        TRY
            loc_cSQL = "SELECT COUNT(1) AS nTotal FROM SigCdLpi" + ;
                       " WHERE lprecos = " + EscaparSQL(THIS.this_cLprecos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Seq")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Seq")
                loc_nSeq = TratarNulo(cursor_4c_Seq.nTotal, "N")
            ENDIF
            IF USED("cursor_4c_Seq")
                USE IN cursor_4c_Seq
            ENDIF
        CATCH TO loc_oErro
            *-- ignorar, loc_nSeq = 0
        ENDTRY

        loc_cChave = PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3) + ;
                     PADR(LEFT(ALLTRIM(THIS.this_cLprecos), 8), 8) + ;
                     TRANSFORM(DATETIME(), "YYYYMMDDHHMMSS")
        loc_cChave = LEFT(ALLTRIM(loc_cChave) + TRANSFORM(loc_nSeq), 20)

        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * ChecaGrpVenda - Verifica se produto pertence a grupo permitido para venda
    * Consulta SigCdPam.GrPadFors para obter grupo padrao e valida no produto
    * Retorna .T. se pode alterar preco, .F. se grupo bloqueado
    *--------------------------------------------------------------------------
    PROCEDURE ChecaGrpVenda(par_cCpros)
        LOCAL loc_cSQL, loc_nResult, loc_lPode, loc_cGrPadFors, loc_cCgrus
        loc_lPode = .T.

        TRY
            *-- Ler grupo padrao de fornecedores em SigCdPam
            loc_cSQL = "SELECT GrPadFors FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Pam") AND !EMPTY(ALLTRIM(cursor_4c_Pam.GrPadFors))
                loc_cGrPadFors = ALLTRIM(cursor_4c_Pam.GrPadFors)
            ELSE
                loc_cGrPadFors = ""
            ENDIF
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            IF EMPTY(loc_cGrPadFors) OR EMPTY(ALLTRIM(par_cCpros))
                loc_lPode = .T.
            ELSE
                *-- Verificar grupo do produto
                loc_cSQL = "SELECT cgrus FROM SigCdPro WHERE cpros = " + EscaparSQL(par_cCpros)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pro")
                IF loc_nResult >= 0 AND !EOF("cursor_4c_Pro")
                    loc_cCgrus = ALLTRIM(cursor_4c_Pro.cgrus)
                    IF loc_cCgrus = loc_cGrPadFors
                        MsgAviso("Produto do grupo " + loc_cGrPadFors + " n" + CHR(227) + "o pode ter pre" + ;
                                 CHR(231) + "o alterado nesta lista!", "Aviso")
                        loc_lPode = .F.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Pro")
                    USE IN cursor_4c_Pro
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lPode
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarFlags - Marca SigCdLpc.flags=1 (lista atualizada no sistema)
    * e persiste os itens de SigCdLpi via SalvarItens
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarFlags(par_cLprecos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdLpc SET flags = 1" + ;
                       " WHERE lprecos = " + EscaparSQL(par_cLprecos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.this_lFlags = .T.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar flags:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar flags:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlterarVencimentos - Altera vencfs de todos os itens de uma lista
    * Equivalente ao cmdSalva do cntVencimentos no legado
    *--------------------------------------------------------------------------
    PROCEDURE AlterarVencimentos(par_cLprecos, par_dVencfs)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(par_dVencfs)
            MsgErro("Data de vencimento inv" + CHR(225) + "lida!", "Aviso")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdLpi SET vencfs = " + FormatarDataSQL(par_dVencfs) + ;
                       " WHERE lprecos = " + EscaparSQL(par_cLprecos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
                MsgInfo("Vencimentos alterados para " + DTOC(par_dVencfs) + "!", "")
            ELSE
                MsgErro("Erro ao alterar vencimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao alterar vencimentos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

