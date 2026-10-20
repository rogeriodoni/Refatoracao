# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_DanfeSimpl' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGPRNFE.cntOperacoes): Left original=223 vs migrado 'lbl_4c_Say1' Left=117 (diff=106px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprnfe.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3428 linhas total):

*-- Linhas 80 a 89:
80:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
81:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
82:                 THIS.ConfigurarPageFrame()
83:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
84:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
85:                 THIS.TornarControlesVisiveis(THIS)
86: 
87:                 *-- Estado inicial do Init legado: criterios livres, grade
88:                 *-- vazia e Limpar/Processar/marcacao desabilitados. Vai pelo
89:                 *-- FUNIL para o caminho de volta (LimparSelecao) devolver

*-- Linhas 135 a 185:
135: 
136:         THIS.AddObject("cnt_4c_Sombra", "Container")
137:         WITH THIS.cnt_4c_Sombra
138:             .Top         = 0
139:             .Left        = 0
140:             .Width       = THIS.Width
141:             .Height      = 80
142:             .BackStyle   = 1
143:             .BackColor   = RGB(100, 100, 100)
144:             .BorderWidth = 0
145:             .Visible     = .T.
146:         ENDWITH
147:         loc_oCab = THIS.cnt_4c_Sombra
148: 
149:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
150:         WITH loc_oCab.lbl_4c_LblSombra
151:             .Top       = 18
152:             .Left      = 10
153:             .Width     = 769
154:             .Height    = 40
155:             .AutoSize  = .F.
156:             .WordWrap  = .T.
157:             .Alignment = 0
158:             .BackStyle = 0
159:             .FontBold  = .T.
160:             .FontName  = "Tahoma"
161:             .FontSize  = 18
162:             .ForeColor = RGB(0, 0, 0)
163:             .Caption   = THIS.Caption
164:         ENDWITH
165: 
166:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
167:         WITH loc_oCab.lbl_4c_LblTitulo
168:             .Top       = 17
169:             .Left      = 10
170:             .Width     = 769
171:             .Height    = 46
172:             .AutoSize  = .F.
173:             .WordWrap  = .T.
174:             .Alignment = 0
175:             .BackStyle = 0
176:             .FontBold  = .T.
177:             .FontName  = "Tahoma"
178:             .FontSize  = 18
179:             .ForeColor = RGB(255, 255, 255)
180:             .Caption   = THIS.Caption
181:         ENDWITH
182:     ENDPROC
183: 
184:     *--------------------------------------------------------------------------
185:     * ConfigurarPainelOperacoes - Painel de criterios de selecao (cntOperacoes

*-- Linhas 198 a 403:
198: 
199:         THIS.AddObject("cnt_4c_Operacoes", "Container")
200:         WITH THIS.cnt_4c_Operacoes
201:             .Top           = 83
202:             .Left          = 4
203:             .Width         = 824
204:             .Height        = 161
205:             .BackStyle     = 0
206:             .BorderWidth   = 0
207:             .SpecialEffect = 0
208:             .Visible       = .T.
209:         ENDWITH
210:         loc_oPnl = THIS.cnt_4c_Operacoes
211: 
212:         *-- Empresa
213:         loc_oPnl.AddObject("lbl_4c_Say5", "Label")
214:         WITH loc_oPnl.lbl_4c_Say5
215:             .Top       = 6
216:             .Left      = 35
217:             .AutoSize  = .T.
218:             .Alignment = 0
219:             .BackStyle = 0
220:             .FontName  = "Tahoma"
221:             .FontSize  = 8
222:             .ForeColor = RGB(90, 90, 90)
223:             .Caption   = "Empresa :"
224:             .Visible   = .T.
225:         ENDWITH
226: 
227:         loc_oPnl.AddObject("txt_4c_Emps", "TextBox")
228:         WITH loc_oPnl.txt_4c_Emps
229:             .Top           = 2
230:             .Left          = 93
231:             .Width         = 34
232:             .Height        = 23
233:             .MaxLength     = 3
234:             .SpecialEffect = 1
235:             .BorderColor   = RGB(90, 90, 90)
236:             .Value         = ""
237:             .ToolTipText   = "C" + CHR(243) + "digo da Empresa"
238:             .Visible       = .T.
239:         ENDWITH
240: 
241:         *-- Serie
242:         loc_oPnl.AddObject("lbl_4c_Say3", "Label")
243:         WITH loc_oPnl.lbl_4c_Say3
244:             .Top       = 6
245:             .Left      = 135
246:             .AutoSize  = .T.
247:             .Alignment = 0
248:             .BackStyle = 0
249:             .FontName  = "Tahoma"
250:             .FontSize  = 8
251:             .ForeColor = RGB(90, 90, 90)
252:             .Caption   = "S" + CHR(233) + "rie :"
253:             .Visible   = .T.
254:         ENDWITH
255: 
256:         loc_oPnl.AddObject("txt_4c_Series", "TextBox")
257:         WITH loc_oPnl.txt_4c_Series
258:             .Top           = 2
259:             .Left          = 178
260:             .Width         = 34
261:             .Height        = 23
262:             .MaxLength     = 3
263:             .SpecialEffect = 1
264:             .BorderColor   = RGB(90, 90, 90)
265:             .Value         = ""
266:             .Visible       = .T.
267:         ENDWITH
268: 
269:         *-- Data de Emissao (De / Ate)
270:         loc_oPnl.AddObject("lbl_4c_Say1", "Label")
271:         WITH loc_oPnl.lbl_4c_Say1
272:             .Top       = 6
273:             .Left      = 223
274:             .AutoSize  = .T.
275:             .Alignment = 0
276:             .BackStyle = 0
277:             .FontName  = "Tahoma"
278:             .FontSize  = 8
279:             .ForeColor = RGB(90, 90, 90)
280:             .Caption   = "Data de Emiss" + CHR(227) + "o :"
281:             .Visible   = .T.
282:         ENDWITH
283: 
284:         loc_oPnl.AddObject("txt_4c_DtIni", "TextBox")
285:         WITH loc_oPnl.txt_4c_DtIni
286:             .Top           = 2
287:             .Left          = 331
288:             .Width         = 80
289:             .Height        = 23
290:             .SpecialEffect = 1
291:             .BorderColor   = RGB(90, 90, 90)
292:             .Value         = {}
293:             .ToolTipText   = "Data Inicial Para Sele" + CHR(231) + CHR(227) + "o das Opera" + CHR(231) + CHR(245) + "es "
294:             .Visible       = .T.
295:         ENDWITH
296: 
297:         loc_oPnl.AddObject("lbl_4c_Say2", "Label")
298:         WITH loc_oPnl.lbl_4c_Say2
299:             .Top       = 6
300:             .Left      = 416
301:             .AutoSize  = .T.
302:             .Alignment = 0
303:             .BackStyle = 0
304:             .FontName  = "Tahoma"
305:             .FontSize  = 8
306:             .ForeColor = RGB(90, 90, 90)
307:             .Caption   = CHR(224)
308:             .Visible   = .T.
309:         ENDWITH
310: 
311:         loc_oPnl.AddObject("txt_4c_DtFin", "TextBox")
312:         WITH loc_oPnl.txt_4c_DtFin
313:             .Top           = 2
314:             .Left          = 428
315:             .Width         = 80
316:             .Height        = 23
317:             .SpecialEffect = 1
318:             .BorderColor   = RGB(90, 90, 90)
319:             .Value         = {}
320:             .ToolTipText   = "Data Final Para Sele" + CHR(231) + CHR(227) + "o das Opera" + CHR(231) + CHR(245) + "es "
321:             .Visible       = .T.
322:         ENDWITH
323: 
324:         *-- Movimento (Saidas/Entradas)
325:         loc_oPnl.AddObject("lbl_4c_Label2", "Label")
326:         WITH loc_oPnl.lbl_4c_Label2
327:             .Top       = 6
328:             .Left      = 517
329:             .Width     = 61
330:             .Height    = 15
331:             .AutoSize  = .T.
332:             .Alignment = 0
333:             .BackStyle = 0
334:             .FontBold  = .F.
335:             .FontItalic = .F.
336:             .FontName  = "Tahoma"
337:             .FontSize  = 8
338:             .ForeColor = RGB(90, 90, 90)
339:             .Caption   = "Movimento :"
340:             .Visible   = .T.
341:         ENDWITH
342: 
343:         loc_oPnl.AddObject("obj_4c_OptTipos", "OptionGroup")
344:         WITH loc_oPnl.obj_4c_OptTipos
345:             .ButtonCount   = 2
346:             .BackStyle     = 0
347:             .BorderStyle   = 0
348:             .Top           = 6
349:             .Left          = 590
350:             .Width         = 142
351:             .Height        = 15
352:             .Value         = 1
353:             .Visible       = .T.
354:         ENDWITH
355:         WITH loc_oPnl.obj_4c_OptTipos.Buttons(1)
356:             .FontName  = "Tahoma"
357:             .FontSize  = 8
358:             .BackStyle = 0
359:             .Caption   = "Sa" + CHR(237) + "das"
360:             .Left      = 5
361:             .Top       = -1
362:             .AutoSize  = .T.
363:             .ForeColor = RGB(90, 90, 90)
364:             .Themes    = .T.
365:         ENDWITH
366:         WITH loc_oPnl.obj_4c_OptTipos.Buttons(2)
367:             .FontName  = "Tahoma"
368:             .FontSize  = 8
369:             .BackStyle = 0
370:             .Caption   = "Entradas"
371:             .Left      = 69
372:             .Top       = -1
373:             .AutoSize  = .T.
374:             .ForeColor = RGB(90, 90, 90)
375:             .Themes    = .T.
376:         ENDWITH
377: 
378:         *-- Notas Fiscais (caminho do arquivo de origem - nasce desabilitado,
379:         *-- igual ao legado, e o limpaselecao NAO o devolve - regra ja
380:         *-- reproduzida em AjustarBotoesPorModo)
381:         loc_oPnl.AddObject("lbl_4c_Say4", "Label")
382:         WITH loc_oPnl.lbl_4c_Say4
383:             .Top       = 33
384:             .Left      = 14
385:             .AutoSize  = .T.
386:             .Alignment = 0
387:             .BackStyle = 0
388:             .FontName  = "Tahoma"
389:             .FontSize  = 8
390:             .ForeColor = RGB(90, 90, 90)
391:             .Caption   = "Notas Fiscais :"
392:             .Visible   = .T.
393:         ENDWITH
394: 
395:         loc_oPnl.AddObject("txt_4c_Arquivos", "TextBox")
396:         WITH loc_oPnl.txt_4c_Arquivos
397:             .Top               = 29
398:             .Left              = 93
399:             .Width             = 636
400:             .Height            = 23
401:             .SpecialEffect     = 1
402:             .BorderColor       = RGB(90, 90, 90)
403:             .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 414 a 627:
414:             .ButtonCount   = 2
415:             .BackStyle     = 0
416:             .BorderStyle   = 0
417:             .Top           = 54
418:             .Left          = 89
419:             .Width         = 173
420:             .Height        = 25
421:             .Value         = 1
422:             .Visible       = .T.
423:         ENDWITH
424:         WITH loc_oPnl.obj_4c_OptAmbiente.Buttons(1)
425:             .FontName  = "Tahoma"
426:             .FontSize  = 8
427:             .BackStyle = 0
428:             .Caption   = "Produ" + CHR(231) + CHR(227) + "o"
429:             .Left      = 5
430:             .Top       = 5
431:             .AutoSize  = .T.
432:             .ForeColor = RGB(90, 90, 90)
433:             .Themes    = .T.
434:         ENDWITH
435:         WITH loc_oPnl.obj_4c_OptAmbiente.Buttons(2)
436:             .FontName  = "Tahoma"
437:             .FontSize  = 8
438:             .BackStyle = 0
439:             .Caption   = "Homologa" + CHR(231) + CHR(227) + "o"
440:             .Left      = 86
441:             .Top       = 5
442:             .AutoSize  = .T.
443:             .ForeColor = RGB(90, 90, 90)
444:             .Themes    = .T.
445:         ENDWITH
446: 
447:         loc_oPnl.AddObject("lbl_4c_Label3", "Label")
448:         WITH loc_oPnl.lbl_4c_Label3
449:             .Top       = 59
450:             .Left      = 31
451:             .Width     = 54
452:             .Height    = 15
453:             .AutoSize  = .T.
454:             .Alignment = 0
455:             .BackStyle = 0
456:             .FontBold  = .F.
457:             .FontItalic = .F.
458:             .FontName  = "Tahoma"
459:             .FontSize  = 8
460:             .ForeColor = RGB(90, 90, 90)
461:             .Caption   = "Ambiente :"
462:             .Visible   = .T.
463:         ENDWITH
464: 
465:         *-- Impressao (Retrato/Paisagem)
466:         loc_oPnl.AddObject("obj_4c_OptImpressao", "OptionGroup")
467:         WITH loc_oPnl.obj_4c_OptImpressao
468:             .ButtonCount   = 2
469:             .BackStyle     = 0
470:             .BorderStyle   = 0
471:             .Top           = 59
472:             .Left          = 569
473:             .Width         = 151
474:             .Height        = 15
475:             .Value         = 1
476:             .Visible       = .T.
477:         ENDWITH
478:         WITH loc_oPnl.obj_4c_OptImpressao.Buttons(1)
479:             .FontName  = "Tahoma"
480:             .FontSize  = 8
481:             .BackStyle = 0
482:             .Caption   = "Retrato"
483:             .Left      = 5
484:             .Top       = -1
485:             .AutoSize  = .T.
486:             .ForeColor = RGB(90, 90, 90)
487:             .Themes    = .T.
488:         ENDWITH
489:         WITH loc_oPnl.obj_4c_OptImpressao.Buttons(2)
490:             .FontName  = "Tahoma"
491:             .FontSize  = 8
492:             .BackStyle = 0
493:             .Caption   = "Paisagem"
494:             .Left      = 72
495:             .Top       = -1
496:             .AutoSize  = .T.
497:             .ForeColor = RGB(90, 90, 90)
498:             .Themes    = .T.
499:         ENDWITH
500: 
501:         loc_oPnl.AddObject("lbl_4c_Label6", "Label")
502:         WITH loc_oPnl.lbl_4c_Label6
503:             .Top       = 59
504:             .Left      = 499
505:             .Width     = 59
506:             .Height    = 15
507:             .AutoSize  = .T.
508:             .Alignment = 0
509:             .BackStyle = 0
510:             .FontBold  = .F.
511:             .FontItalic = .F.
512:             .FontName  = "Tahoma"
513:             .FontSize  = 8
514:             .ForeColor = RGB(90, 90, 90)
515:             .Caption   = "Impress" + CHR(227) + "o :"
516:             .Visible   = .T.
517:         ENDWITH
518: 
519:         *-- Versao - caption estatico aqui ("Versao :"); o legado concatena a
520:         *-- versao do layout do XML (thisform.versaol) no fim do Init, DEPOIS
521:         *-- de ler SigCdPac. AplicarFiltrosIniciais reescreve esta Caption com
522:         *-- "Versao :" + this_cVersaoL assim que a versao do layout e resolvida.
523:         loc_oPnl.AddObject("lbl_4c_Versao", "Label")
524:         WITH loc_oPnl.lbl_4c_Versao
525:             .Top       = 61
526:             .Left      = 283
527:             .Width     = 42
528:             .Height    = 15
529:             .AutoSize  = .T.
530:             .Alignment = 0
531:             .BackStyle = 0
532:             .FontBold  = .F.
533:             .FontItalic = .F.
534:             .FontName  = "Tahoma"
535:             .FontSize  = 8
536:             .ForeColor = RGB(90, 90, 90)
537:             .Caption   = "Versao :"
538:             .Visible   = .T.
539:         ENDWITH
540: 
541:         *-- PARTE 2/2 (Fase 6): Situacao, Regime Tributario, Acao, Inutilizar
542:         *-- de, Usar TXT-ALT, Horario de Verao, Venc Futuros, Subst. Codigo
543:         *-- por Referencia, cmdInu e Contingencia. Posicoes/tamanhos/captions
544:         *-- EXATOS do dump (PILAR 1).
545: 
546:         *-- Situacao (Nao Processadas/Processadas)
547:         loc_oPnl.AddObject("lbl_4c_Label1", "Label")
548:         WITH loc_oPnl.lbl_4c_Label1
549:             .Top        = 83
550:             .Left       = 35
551:             .Width      = 50
552:             .Height     = 15
553:             .AutoSize   = .T.
554:             .Alignment  = 0
555:             .BackStyle  = 0
556:             .FontBold   = .F.
557:             .FontItalic = .F.
558:             .FontName   = "Tahoma"
559:             .FontSize   = 8
560:             .ForeColor  = RGB(90, 90, 90)
561:             .Caption    = "Situa" + CHR(231) + CHR(227) + "o :"
562:             .Visible    = .T.
563:         ENDWITH
564: 
565:         loc_oPnl.AddObject("obj_4c_OptProcessados", "OptionGroup")
566:         WITH loc_oPnl.obj_4c_OptProcessados
567:             .ButtonCount   = 2
568:             .BackStyle     = 0
569:             .BorderStyle   = 0
570:             .Top           = 83
571:             .Left          = 89
572:             .Width         = 235
573:             .Height        = 17
574:             .Value         = 1
575:             .Visible       = .T.
576:         ENDWITH
577:         WITH loc_oPnl.obj_4c_OptProcessados.Buttons(1)
578:             .FontName  = "Tahoma"
579:             .FontSize  = 8
580:             .BackStyle = 0
581:             .Caption   = "N" + CHR(227) + "o Processadas"
582:             .Left      = 5
583:             .Top       = -1
584:             .AutoSize  = .T.
585:             .ForeColor = RGB(90, 90, 90)
586:             .Themes    = .T.
587:         ENDWITH
588:         WITH loc_oPnl.obj_4c_OptProcessados.Buttons(2)
589:             .FontName  = "Tahoma"
590:             .FontSize  = 8
591:             .BackStyle = 0
592:             .Caption   = "Processadas"
593:             .Left      = 126
594:             .Top       = -1
595:             .AutoSize  = .T.
596:             .ForeColor = RGB(90, 90, 90)
597:             .Themes    = .T.
598:         ENDWITH
599: 
600:         *-- Regime Tributario (combo, carregado por tabela, nao editavel)
601:         loc_oPnl.AddObject("lbl_4c_Label5", "Label")
602:         WITH loc_oPnl.lbl_4c_Label5
603:             .Top        = 83
604:             .Left       = 465
605:             .Width      = 93
606:             .Height     = 15
607:             .AutoSize   = .T.
608:             .Alignment  = 0
609:             .BackStyle  = 0
610:             .FontBold   = .F.
611:             .FontItalic = .F.
612:             .FontName   = "Tahoma"
613:             .FontSize   = 8
614:             .ForeColor  = RGB(90, 90, 90)
615:             .Caption    = "Regime Tribut" + CHR(225) + "rio :"
616:             .Visible    = .T.
617:         ENDWITH
618: 
619:         loc_oPnl.AddObject("cbo_4c_CmbRegime", "ComboBox")
620:         WITH loc_oPnl.cbo_4c_CmbRegime
621:             .Top           = 79
622:             .Left          = 572
623:             .Width         = 206
624:             .Height        = 22
625:             .Style         = 2
626:             .RowSourceType = 1
627:             .RowSource     = "Simples Nacional,Lucro Presumido,Lucro Real,Lucro Arbitrado"

*-- Linhas 633 a 802:
633:         ENDWITH
634: 
635:         *-- Acao (o que o botao Processar vai fazer com a selecao)
636:         loc_oPnl.AddObject("lbl_4c_Label4", "Label")
637:         WITH loc_oPnl.lbl_4c_Label4
638:             .Top        = 107
639:             .Left       = 52
640:             .Width      = 33
641:             .Height     = 15
642:             .AutoSize   = .T.
643:             .Alignment  = 0
644:             .BackStyle  = 0
645:             .FontBold   = .F.
646:             .FontItalic = .F.
647:             .FontName   = "Tahoma"
648:             .FontSize   = 8
649:             .ForeColor  = RGB(90, 90, 90)
650:             .Caption    = "A" + CHR(231) + CHR(227) + "o :"
651:             .Visible    = .T.
652:         ENDWITH
653: 
654:         loc_oPnl.AddObject("obj_4c_OptAcao", "OptionGroup")
655:         WITH loc_oPnl.obj_4c_OptAcao
656:             .ButtonCount   = 7
657:             .BackStyle     = 0
658:             .BorderStyle   = 0
659:             .Top           = 101
660:             .Left          = 92
661:             .Width         = 397
662:             .Height        = 38
663:             .Value         = 1
664:             .Visible       = .T.
665:         ENDWITH
666:         WITH loc_oPnl.obj_4c_OptAcao.Buttons(1)
667:             .FontName  = "Tahoma"
668:             .FontSize  = 8
669:             .BackStyle = 0
670:             .Caption   = "Emitir"
671:             .Left      = 2
672:             .Top       = 4
673:             .AutoSize  = .T.
674:             .ForeColor = RGB(90, 90, 90)
675:             .Themes    = .T.
676:         ENDWITH
677:         WITH loc_oPnl.obj_4c_OptAcao.Buttons(2)
678:             .FontName  = "Tahoma"
679:             .FontSize  = 8
680:             .BackStyle = 0
681:             .Caption   = "Cancelar"
682:             .Left      = 2
683:             .Top       = 21
684:             .AutoSize  = .T.
685:             .ForeColor = RGB(90, 90, 90)
686:             .Themes    = .T.
687:         ENDWITH
688:         WITH loc_oPnl.obj_4c_OptAcao.Buttons(3)
689:             .FontName  = "Tahoma"
690:             .FontSize  = 8
691:             .BackStyle = 0
692:             .Caption   = "Consultar Status"
693:             .Height    = 17
694:             .Left      = 79
695:             .Top       = 3
696:             .Width     = 117
697:             .ForeColor = RGB(90, 90, 90)
698:             .Themes    = .T.
699:         ENDWITH
700:         WITH loc_oPnl.obj_4c_OptAcao.Buttons(4)
701:             .FontName  = "Tahoma"
702:             .FontSize  = 8
703:             .BackStyle = 0
704:             .Caption   = "Inutilizar"
705:             .Height    = 17
706:             .Left      = 201
707:             .Top       = 3
708:             .Width     = 71
709:             .ForeColor = RGB(90, 90, 90)
710:             .Themes    = .T.
711:         ENDWITH
712:         WITH loc_oPnl.obj_4c_OptAcao.Buttons(5)
713:             .FontName  = "Tahoma"
714:             .FontSize  = 8
715:             .BackStyle = 0
716:             .Caption   = "Visualizar Danfe"
717:             .Height    = 17
718:             .Left      = 79
719:             .Top       = 20
720:             .Width     = 112
721:             .ForeColor = RGB(90, 90, 90)
722:             .Themes    = .T.
723:         ENDWITH
724:         WITH loc_oPnl.obj_4c_OptAcao.Buttons(6)
725:             .FontName  = "Tahoma"
726:             .FontSize  = 8
727:             .BackStyle = 0
728:             .Caption   = "Verificar Servi" + CHR(231) + "o"
729:             .Height    = 17
730:             .Left      = 201
731:             .Top       = 20
732:             .Width     = 116
733:             .ForeColor = RGB(90, 90, 90)
734:             .Themes    = .T.
735:         ENDWITH
736:         WITH loc_oPnl.obj_4c_OptAcao.Buttons(7)
737:             .FontName    = "Tahoma"
738:             .FontSize    = 8
739:             .BackStyle   = 0
740:             .Caption     = "Inutilizar NFCe"
741:             .Height      = 17
742:             .Left        = 276
743:             .Top         = 3
744:             .Width       = 110
745:             .ToolTipText = "Inutiliza NFCe pelo Invoicy"
746:             .ForeColor   = RGB(90, 90, 90)
747:             .Themes      = .T.
748:         ENDWITH
749: 
750:         *-- Inutilizar de / a (faixa de numeracao - acoes 4 e 7 de optAcao)
751:         loc_oPnl.AddObject("lbl_4c_Say7", "Label")
752:         WITH loc_oPnl.lbl_4c_Say7
753:             .Top       = 108
754:             .Left      = 493
755:             .AutoSize  = .T.
756:             .Alignment = 0
757:             .BackStyle = 0
758:             .FontName  = "Tahoma"
759:             .FontSize  = 8
760:             .ForeColor = RGB(90, 90, 90)
761:             .Caption   = "Inutilizar de :"
762:             .Visible   = .T.
763:         ENDWITH
764: 
765:         loc_oPnl.AddObject("txt_4c_InuIni", "TextBox")
766:         WITH loc_oPnl.txt_4c_InuIni
767:             .Top               = 104
768:             .Left              = 572
769:             .Width             = 91
770:             .Height            = 23
771:             .MaxLength         = 8
772:             .SpecialEffect     = 1
773:             .BorderColor       = RGB(90, 90, 90)
774:             .ForeColor         = RGB(0, 0, 0)
775:             .DisabledBackColor = RGB(255, 255, 255)
776:             .Value             = ""
777:             .Visible           = .T.
778:         ENDWITH
779: 
780:         loc_oPnl.AddObject("lbl_4c_Say6", "Label")
781:         WITH loc_oPnl.lbl_4c_Say6
782:             .Top       = 108
783:             .Left      = 672
784:             .AutoSize  = .T.
785:             .Alignment = 0
786:             .BackStyle = 0
787:             .FontName  = "Tahoma"
788:             .FontSize  = 8
789:             .ForeColor = RGB(90, 90, 90)
790:             .Caption   = CHR(224)
791:             .Visible   = .T.
792:         ENDWITH
793: 
794:         loc_oPnl.AddObject("txt_4c_InuFim", "TextBox")
795:         WITH loc_oPnl.txt_4c_InuFim
796:             .Top               = 104
797:             .Left              = 687
798:             .Width             = 91
799:             .Height            = 23
800:             .MaxLength         = 8
801:             .SpecialEffect     = 1
802:             .BorderColor       = RGB(90, 90, 90)

*-- Linhas 810 a 970:
810:         *-- inutilizar da propria Serie/Empresa digitada. Nasce oculto
811:         *-- (Visible=.F. no legado) e so aparece quando optAcao.Value in (4,7)
812:         *-- - toggle e Click ligados em ConfigurarBotoesAcao.
813:         loc_oPnl.AddObject("cmd_4c_CmdInu", "CommandButton")
814:         WITH loc_oPnl.cmd_4c_CmdInu
815:             .Top       = 105
816:             .Left      = 779
817:             .Width     = 29
818:             .Height    = 22
819:             .FontBold   = .T.
820:             .FontItalic = .T.
821:             .FontName   = "Comic Sans MS"
822:             .FontSize   = 8
823:             .Caption    = "..."
824:             .ForeColor  = RGB(90, 90, 90)
825:             .BackColor  = RGB(255, 255, 255)
826:             .Themes     = .F.
827:             .Visible    = .F.
828:         ENDWITH
829: 
830:         *-- Usar TXT-ALT / Horario de Verao / Venc Futuros / Subst. Codigo do
831:         *-- Produto por Referencia (checkboxes de criterio)
832:         loc_oPnl.AddObject("chk_4c_OptArq", "CheckBox")
833:         WITH loc_oPnl.chk_4c_OptArq
834:             .Top       = 129
835:             .Left      = 566
836:             .Width     = 103
837:             .Height    = 17
838:             .FontName  = "Tahoma"
839:             .FontSize  = 8
840:             .Alignment = 0
841:             .Caption   = "Usar TXT-ALT"
842:             .ForeColor = RGB(90, 90, 90)
843:             .Value     = 0
844:             .Visible   = .T.
845:         ENDWITH
846: 
847:         loc_oPnl.AddObject("chk_4c_ChkHVerao", "CheckBox")
848:         WITH loc_oPnl.chk_4c_ChkHVerao
849:             .Top         = 128
850:             .Left        = 682
851:             .Width       = 121
852:             .Height      = 17
853:             .FontName    = "Tahoma"
854:             .FontSize    = 8
855:             .Alignment   = 0
856:             .Caption     = "Hor" + CHR(225) + "rio de Ver" + CHR(227) + "o"
857:             .ToolTipText = "Informar se " + CHR(233) + " hor" + CHR(225) + "rio de ver" + CHR(227) + "o para montar os campos de data"
858:             .ForeColor   = RGB(90, 90, 90)
859:             .Value       = 0
860:             .Visible     = .T.
861:         ENDWITH
862: 
863:         loc_oPnl.AddObject("chk_4c_ChkVenc", "CheckBox")
864:         WITH loc_oPnl.chk_4c_ChkVenc
865:             .Top         = 58
866:             .Left        = 726
867:             .Width       = 121
868:             .Height      = 17
869:             .FontName    = "Tahoma"
870:             .FontSize    = 8
871:             .Alignment   = 0
872:             .Caption     = "Venc Futuros"
873:             .ToolTipText = "Este flag monta forma de pagamento com vencimento depois de hoje"
874:             .ForeColor   = RGB(90, 90, 90)
875:             .Value       = 0
876:             .Visible     = .T.
877:         ENDWITH
878: 
879:         loc_oPnl.AddObject("chk_4c_OptSub", "CheckBox")
880:         WITH loc_oPnl.chk_4c_OptSub
881:             .Top       = 145
882:             .Left      = 566
883:             .Width     = 215
884:             .Height    = 15
885:             .FontName  = "Tahoma"
886:             .FontSize  = 8
887:             .Alignment = 0
888:             .BackStyle = 0
889:             .Caption   = "Subst. C" + CHR(243) + "digo do Produto por Refer" + CHR(234) + "ncia"
890:             .ForeColor = RGB(90, 90, 90)
891:             .Themes    = .F.
892:             .Value     = 0
893:             .Visible   = .T.
894:         ENDWITH
895: 
896:         *-- Contingencia (Nao / SVC-AN / SVC-RS) + data inicial da contingencia
897:         loc_oPnl.AddObject("lbl_4c_Label7", "Label")
898:         WITH loc_oPnl.lbl_4c_Label7
899:             .Top        = 146
900:             .Left       = 14
901:             .Width      = 71
902:             .Height     = 15
903:             .AutoSize   = .T.
904:             .Alignment  = 0
905:             .BackStyle  = 0
906:             .FontBold   = .F.
907:             .FontItalic = .F.
908:             .FontName   = "Tahoma"
909:             .FontSize   = 8
910:             .ForeColor  = RGB(90, 90, 90)
911:             .Caption    = "Conting" + CHR(234) + "ncia :"
912:             .Visible    = .T.
913:         ENDWITH
914: 
915:         loc_oPnl.AddObject("obj_4c_OptContin", "OptionGroup")
916:         WITH loc_oPnl.obj_4c_OptContin
917:             .ButtonCount   = 3
918:             .BackStyle     = 0
919:             .BorderStyle   = 0
920:             .Top           = 140
921:             .Left          = 92
922:             .Width         = 258
923:             .Height        = 21
924:             .Value         = 1
925:             .Visible       = .T.
926:         ENDWITH
927:         WITH loc_oPnl.obj_4c_OptContin.Buttons(1)
928:             .FontName  = "Tahoma"
929:             .FontSize  = 8
930:             .BackStyle = 0
931:             .Caption   = "N" + CHR(227) + "o"
932:             .Left      = 2
933:             .Top       = 4
934:             .AutoSize  = .T.
935:             .ForeColor = RGB(90, 90, 90)
936:             .Themes    = .T.
937:         ENDWITH
938:         WITH loc_oPnl.obj_4c_OptContin.Buttons(2)
939:             .FontName  = "Tahoma"
940:             .FontSize  = 8
941:             .BackStyle = 0
942:             .Caption   = "SVC-AN"
943:             .Left      = 79
944:             .Top       = 4
945:             .AutoSize  = .T.
946:             .ForeColor = RGB(90, 90, 90)
947:             .Themes    = .T.
948:         ENDWITH
949:         WITH loc_oPnl.obj_4c_OptContin.Buttons(3)
950:             .FontName  = "Tahoma"
951:             .FontSize  = 8
952:             .BackStyle = 0
953:             .Caption   = "SVC-RS"
954:             .Height    = 17
955:             .Left      = 201
956:             .Top       = 3
957:             .Width     = 117
958:             .ForeColor = RGB(90, 90, 90)
959:             .Themes    = .T.
960:         ENDWITH
961: 
962:         loc_oPnl.AddObject("txt_4c_IniContin", "TextBox")
963:         WITH loc_oPnl.txt_4c_IniContin
964:             .Top           = 141
965:             .Left          = 361
966:             .Width         = 80
967:             .Height        = 20
968:             .SpecialEffect = 1
969:             .BorderColor   = RGB(90, 90, 90)
970:             .Value         = {}

*-- Linhas 979 a 996:
979:         BINDEVENT(loc_oPnl.txt_4c_Emps, "LostFocus", THIS, "ValidarEmpresa")
980:         BINDEVENT(loc_oPnl.txt_4c_Series, "LostFocus", THIS, "ValidarSerie")
981: 
982:         *-- optAcao.Valid legado: mostra/esconde o botao "..." (cmd_4c_CmdInu)
983:         *-- quando a acao e inutilizacao (4=NF-e / 7=NFC-e). optContin.Valid
984:         *-- do dump tem o MESMO corpo mas compara o PROPRIO Value (max 3)
985:         *-- contra 4/7 - nunca verdadeiro, dead code do legado; nao replicado.
986:         BINDEVENT(loc_oPnl.obj_4c_OptAcao, "InteractiveChange", THIS, "AjustarVisibilidadeInutilizar")
987: 
988:         *-- cmdInu.Click legado: abre o painel cnt_4c_Inu filtrado pela
989:         *-- Empresa digitada (regra #35b/#41 - painel so pode ser populado
990:         *-- com o cursor_4c_NotasAInutilizar ja calculado por "A Inutilizar")
991:         BINDEVENT(loc_oPnl.cmd_4c_CmdInu, "Click", THIS, "AbrirPainelInutilizacao")
992:     ENDPROC
993: 
994:     *--------------------------------------------------------------------------
995:     * EmpsGotFocus - GotFocus legado do getEmps (This.Tag = Padr(Value,3)):
996:     * guarda o valor com que o campo foi aberto, para ValidarEmpresa saber se

*-- Linhas 1166 a 1189:
1166: 
1167:         THIS.AddObject("cnt_4c_Grade", "Container")
1168:         WITH THIS.cnt_4c_Grade
1169:             .Top           = 247
1170:             .Left          = 50
1171:             .Width         = 820
1172:             .Height        = 344
1173:             .BackStyle     = 0
1174:             .BorderWidth   = 0
1175:             .SpecialEffect = 0
1176:             .Visible       = .T.
1177:         ENDWITH
1178:         loc_oCnt = THIS.cnt_4c_Grade
1179: 
1180:         loc_oCnt.AddObject("grd_4c_Dados", "Grid")
1181:         loc_oGrd = loc_oCnt.grd_4c_Dados
1182:         WITH loc_oGrd
1183:             .Top           = 1
1184:             .Left          = 3
1185:             .Width         = 813
1186:             .Height        = 340
1187:             .FontName      = "Tahoma"
1188:             .FontSize      = 8
1189:             .AllowHeaderSizing = .F.

*-- Linhas 1200 a 1230:
1200:         ENDWITH
1201: 
1202:         *-- Column1: Check1 (SelImp) - unica coluna editavel da grade
1203:         loc_oGrd.Column1.AddObject("chk_4c_Check1", "CheckBox")
1204:         WITH loc_oGrd.Column1
1205:             .Width          = 19
1206:             .ControlSource  = "cursor_4c_Operacoes.SelImp"
1207:             .CurrentControl = "chk_4c_Check1"
1208:             .Sparse         = .F.
1209:             .Header1.Caption   = ""
1210:             .Header1.Alignment = 2
1211:             .Header1.ForeColor = RGB(36, 84, 155)
1212:         ENDWITH
1213:         WITH loc_oGrd.Column1.chk_4c_Check1
1214:             .Top         = 9
1215:             .Left        = 2
1216:             .Height      = 17
1217:             .Width       = 22
1218:             .Alignment   = 0
1219:             .Caption     = ""
1220:             .ToolTipText = "Marca/Desmarca Esta Opera" + CHR(231) + CHR(227) + "o Para o Processamento"
1221:             .ReadOnly    = .F.
1222:             .Visible     = .T.
1223:         ENDWITH
1224: 
1225:         *-- CheckBox de coluna de Grid nao alterna pelo binding nativo: o
1226:         *-- legado suprime o toggle padrao (Click/MouseDown com NoDefault) e
1227:         *-- inverte o valor por codigo no MouseUp e no KeyPress (Enter/Espaco).
1228:         *-- Os quatro handlers sao PUBLIC - BINDEVENT ignora PROTECTED
1229:         *-- silenciosamente (regra #3).
1230:         BINDEVENT(loc_oGrd.Column1.chk_4c_Check1, "Click", ;

*-- Linhas 1240 a 1248:
1240:         WITH loc_oGrd.Column2
1241:             .Width          = 63
1242:             .ControlSource  = "cursor_4c_Operacoes.Dopes"
1243:             .Header1.Caption   = "C" + CHR(243) + "digo"
1244:             .Header1.Alignment = 2
1245:             .Header1.ForeColor = RGB(36, 84, 155)
1246:             .Text1.BorderStyle = 1
1247:             .Text1.Margin      = 0
1248:             .Text1.ReadOnly    = .T.

*-- Linhas 1254 a 1274:
1254:         WITH loc_oGrd.Column3
1255:             .Width          = 80
1256:             .ControlSource  = "cursor_4c_Operacoes.Datas"
1257:             .Header1.Caption   = "Emiss" + CHR(227) + "o"
1258:             .Header1.Alignment = 2
1259:             .Header1.ForeColor = RGB(36, 84, 155)
1260:             .Text1.Margin      = 0
1261:             .Text1.ReadOnly    = .T.
1262:             .Text1.ToolTipText = "Data da Opera" + CHR(231) + CHR(227) + "o na Origem"
1263:         ENDWITH
1264: 
1265:         *-- Column4: Valor (Valos)
1266:         WITH loc_oGrd.Column4
1267:             .Width          = 129
1268:             .ControlSource  = "cursor_4c_Operacoes.Valos"
1269:             .Header1.Caption   = "Valor"
1270:             .Header1.Alignment = 2
1271:             .Header1.ForeColor = RGB(36, 84, 155)
1272:             .Text1.BorderStyle = 0
1273:             .Text1.Margin      = 0
1274:             .Text1.ReadOnly    = .T.

*-- Linhas 1281 a 1289:
1281:         WITH loc_oGrd.Column5
1282:             .Width          = 75
1283:             .ControlSource  = "cursor_4c_Operacoes.Notas"
1284:             .Header1.Caption   = "Nota Fiscal"
1285:             .Header1.Alignment = 2
1286:             .Header1.ForeColor = RGB(36, 84, 155)
1287:             .Text1.BorderStyle = 0
1288:             .Text1.Margin      = 0
1289:             .Text1.ReadOnly    = .T.

*-- Linhas 1296 a 1304:
1296:         WITH loc_oGrd.Column6
1297:             .Width          = 40
1298:             .ControlSource  = "cursor_4c_Operacoes.Series"
1299:             .Header1.Caption   = "S" + CHR(233) + "rie"
1300:             .Header1.Alignment = 2
1301:             .Header1.ForeColor = RGB(36, 84, 155)
1302:             .Text1.BorderStyle = 0
1303:             .Text1.Margin      = 0
1304:             .Text1.ReadOnly    = .T.

*-- Linhas 1311 a 1319:
1311:         WITH loc_oGrd.Column7
1312:             .Width          = 307
1313:             .ControlSource  = "cursor_4c_Operacoes.Numes"
1314:             .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
1315:             .Header1.Alignment = 2
1316:             .Header1.ForeColor = RGB(36, 84, 155)
1317:             .Text1.BorderStyle = 0
1318:             .Text1.Margin      = 0
1319:             .Text1.ReadOnly    = .T.

*-- Linhas 1326 a 1334:
1326:         WITH loc_oGrd.Column8
1327:             .Width          = 38
1328:             .ControlSource  = "cursor_4c_Operacoes.Emps"
1329:             .Header1.Caption   = "Emp"
1330:             .Header1.Alignment = 2
1331:             .Header1.ForeColor = RGB(36, 84, 155)
1332:             .Text1.BorderStyle = 0
1333:             .Text1.Margin      = 0
1334:             .Text1.ReadOnly    = .T.

*-- Linhas 1341 a 1349:
1341:         WITH loc_oGrd.Column9
1342:             .Width          = 33
1343:             .ControlSource  = "cursor_4c_Operacoes.stats"
1344:             .Header1.Caption   = "Stat"
1345:             .Header1.Alignment = 2
1346:             .Header1.ForeColor = RGB(36, 84, 155)
1347:             .Text1.Alignment   = 2
1348:             .Text1.BorderStyle = 0
1349:             .Text1.Margin      = 0

*-- Linhas 1374 a 1461:
1374:             .BorderStyle   = 0
1375:             .Value         = 1
1376:             .Height        = 157
1377:             .Left          = 841
1378:             .SpecialEffect = 1
1379:             .Top           = 78
1380:             .Width         = 159
1381:             .BorderColor   = RGB(136, 189, 188)
1382:             .Themes        = .F.
1383:             .Visible       = .T.
1384:         ENDWITH
1385:         loc_oGrp = THIS.obj_4c_CmdBtnForm
1386: 
1387:         WITH loc_oGrp.Buttons(1)
1388:             .Top          = 80
1389:             .Left         = 6
1390:             .Height       = 75
1391:             .Width        = 75
1392:             .FontBold     = .T.
1393:             .FontItalic   = .T.
1394:             .FontName     = "Comic Sans MS"
1395:             .FontSize     = 8
1396:             .WordWrap     = .T.
1397:             .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_60.jpg"
1398:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_60.jpg"
1399:             .Caption      = "Limpar Sele" + CHR(231) + CHR(227) + "o"
1400:             .ToolTipText  = "Limpar Sele" + CHR(231) + CHR(227) + "o"
1401:             .ForeColor    = RGB(90, 90, 90)
1402:             .BackColor    = RGB(255, 255, 255)
1403:             .Themes       = .T.
1404:         ENDWITH
1405:         WITH loc_oGrp.Buttons(2)
1406:             .Top          = 80
1407:             .Left         = 82
1408:             .Height       = 75
1409:             .Width        = 75
1410:             .FontBold     = .T.
1411:             .FontItalic   = .T.
1412:             .FontName     = "Comic Sans MS"
1413:             .FontSize     = 8
1414:             .WordWrap     = .T.
1415:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1416:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1417:             .Caption      = "Processar"
1418:             .ToolTipText  = "Processar"
1419:             .ForeColor    = RGB(90, 90, 90)
1420:             .BackColor    = RGB(255, 255, 255)
1421:             .Themes       = .T.
1422:         ENDWITH
1423:         WITH loc_oGrp.Buttons(3)
1424:             .Top          = 5
1425:             .Left         = 82
1426:             .Height       = 75
1427:             .Width        = 75
1428:             .FontBold     = .T.
1429:             .FontItalic   = .T.
1430:             .FontName     = "Comic Sans MS"
1431:             .FontSize     = 8
1432:             .WordWrap     = .T.
1433:             .Cancel       = .T.
1434:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1435:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1436:             .Caption      = "Encerrar"
1437:             .ToolTipText  = "[ESC] Sair"
1438:             .ForeColor    = RGB(90, 90, 90)
1439:             .BackColor    = RGB(255, 255, 255)
1440:             .Themes       = .T.
1441:         ENDWITH
1442: 
1443:         *-- cmdSelecionar: botao avulso que dispara a selecao das operacoes
1444:         THIS.AddObject("cmd_4c_CmdSelecionar", "CommandButton")
1445:         WITH THIS.cmd_4c_CmdSelecionar
1446:             .Top          = 83
1447:             .Left         = 848
1448:             .Height       = 75
1449:             .Width        = 75
1450:             .FontBold     = .T.
1451:             .FontItalic   = .T.
1452:             .FontName     = "Comic Sans MS"
1453:             .FontSize     = 8
1454:             .Picture         = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
1455:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
1456:             .Caption      = "\<Selecionar"
1457:             .ToolTipText  = "Seleciona as Opera" + CHR(231) + CHR(245) + "es Conforme os Dados Digitados"
1458:             .ForeColor    = RGB(90, 90, 90)
1459:             .BackColor    = RGB(255, 255, 255)
1460:             .Themes       = .T.
1461:             .Visible      = .T.

*-- Linhas 1470 a 1498:
1470:             .BorderStyle   = 0
1471:             .Value         = 0
1472:             .Height        = 85
1473:             .Left          = 865
1474:             .SpecialEffect = 1
1475:             .Top           = 491
1476:             .Width         = 85
1477:             .BorderColor   = RGB(136, 189, 188)
1478:             .Themes        = .F.
1479:             .Visible       = .T.
1480:         ENDWITH
1481:         WITH THIS.obj_4c_Commandgroup1.Buttons(1)
1482:             .Top          = 5
1483:             .Left         = 5
1484:             .Height       = 75
1485:             .Width        = 75
1486:             .FontBold     = .T.
1487:             .FontItalic   = .T.
1488:             .FontName     = "Comic Sans MS"
1489:             .FontSize     = 8
1490:             .WordWrap     = .T.
1491:             .Picture         = gc_4c_CaminhoIcones + "geral_documento_60.jpg"
1492:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_documento_60.jpg"
1493:             .Caption      = "A inutilizar"
1494:             .ToolTipText  = "Mostra lista de notas a inutilizar"
1495:             .ForeColor    = RGB(90, 90, 90)
1496:             .BackColor    = RGB(255, 255, 255)
1497:             .Themes       = .T.
1498:         ENDWITH

*-- Linhas 1507 a 1603:
1507:             .BorderStyle   = 0
1508:             .Value         = 1
1509:             .Height        = 232
1510:             .Left          = 865
1511:             .SpecialEffect = 1
1512:             .Top           = 264
1513:             .Width         = 85
1514:             .BorderColor   = RGB(136, 189, 188)
1515:             .Themes        = .F.
1516:             .Visible       = .T.
1517:         ENDWITH
1518:         loc_oGrp = THIS.obj_4c_CmdBtnGrade
1519: 
1520:         WITH loc_oGrp.Buttons(1)
1521:             .Top          = 5
1522:             .Left         = 5
1523:             .Height       = 55
1524:             .Width        = 75
1525:             .FontBold     = .T.
1526:             .FontItalic   = .T.
1527:             .FontName     = "Comic Sans MS"
1528:             .FontSize     = 8
1529:             .WordWrap     = .T.
1530:             .Picture         = gc_4c_CaminhoIcones + "geral_selecionar_60.jpg"
1531:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_selecionar_60.jpg"
1532:             .Caption      = "Selecionar"
1533:             .ToolTipText  = "Selecionar"
1534:             .ForeColor    = RGB(90, 90, 90)
1535:             .BackColor    = RGB(255, 255, 255)
1536:             .Themes       = .T.
1537:             .Enabled      = .F.
1538:         ENDWITH
1539:         WITH loc_oGrp.Buttons(2)
1540:             .Top          = 61
1541:             .Left         = 5
1542:             .Height       = 55
1543:             .Width        = 75
1544:             .FontBold     = .T.
1545:             .FontItalic   = .T.
1546:             .FontName     = "Comic Sans MS"
1547:             .FontSize     = 8
1548:             .WordWrap     = .T.
1549:             .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
1550:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
1551:             .Caption      = "Desmarcar"
1552:             .ToolTipText  = "Desmarcar"
1553:             .ForeColor    = RGB(90, 90, 90)
1554:             .BackColor    = RGB(255, 255, 255)
1555:             .Themes       = .T.
1556:             .Enabled      = .F.
1557:         ENDWITH
1558:         WITH loc_oGrp.Buttons(3)
1559:             .Top          = 116
1560:             .Left         = 5
1561:             .Height       = 55
1562:             .Width        = 75
1563:             .FontBold     = .T.
1564:             .FontItalic   = .T.
1565:             .FontName     = "Comic Sans MS"
1566:             .FontSize     = 8
1567:             .WordWrap     = .T.
1568:             .Picture         = gc_4c_CaminhoIcones + "geral_documento_60.jpg"
1569:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_documento_60.jpg"
1570:             .Caption      = "Documento"
1571:             .ToolTipText  = "Documento"
1572:             .ForeColor    = RGB(90, 90, 90)
1573:             .BackColor    = RGB(255, 255, 255)
1574:             .Themes       = .T.
1575:             .Enabled      = .F.
1576:         ENDWITH
1577:         WITH loc_oGrp.Buttons(4)
1578:             .Top          = 172
1579:             .Left         = 5
1580:             .Height       = 55
1581:             .Width        = 75
1582:             .FontBold     = .T.
1583:             .FontItalic   = .T.
1584:             .FontName     = "Comic Sans MS"
1585:             .FontSize     = 8
1586:             .Picture         = gc_4c_CaminhoIcones + "geral_documento_60.jpg"
1587:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_documento_60.jpg"
1588:             .Caption      = "Danfe Simpl"
1589:             .ToolTipText  = "Imprime Danfe Simplificado"
1590:             .ForeColor    = RGB(90, 90, 90)
1591:             .BackColor    = RGB(255, 255, 255)
1592:             .Themes       = .T.
1593:         ENDWITH
1594: 
1595:         *-- Eventos principais dos botoes (Fase 7). CommandGroup dispara UM
1596:         *-- Click so para o grupo inteiro - o handler le .Value para saber
1597:         *-- qual Buttons(N) foi clicado, igual ao legado.
1598:         BINDEVENT(THIS.cmd_4c_CmdSelecionar, "Click", THIS, "BtnSelecionarClick")
1599:         BINDEVENT(THIS.obj_4c_CmdBtnForm, "Click", THIS, "BtnAcaoFormClick")
1600:         BINDEVENT(THIS.obj_4c_Commandgroup1, "Click", THIS, "BtnPrepararInutilizacaoClick")
1601:         BINDEVENT(THIS.obj_4c_CmdBtnGrade, "Click", THIS, "BtnAcaoGradeClick")
1602:     ENDPROC
1603: 

*-- Linhas 1645 a 1717:
1645: 
1646:         THIS.AddObject("cnt_4c_Inu", "Container")
1647:         WITH THIS.cnt_4c_Inu
1648:             .Top           = 156
1649:             .Left          = 203
1650:             .Width         = 504
1651:             .Height        = 392
1652:             .SpecialEffect = 0
1653:             .BackColor     = RGB(255, 255, 255)
1654:             .Visible       = .F.
1655:         ENDWITH
1656:         loc_oPnl = THIS.cnt_4c_Inu
1657: 
1658:         loc_oPnl.AddObject("shp_4c_Shape5", "Shape")
1659:         WITH loc_oPnl.shp_4c_Shape5
1660:             .Top          = 9
1661:             .Left         = 404
1662:             .Height       = 15
1663:             .Width        = 16
1664:             .BackStyle    = 0
1665:             .BorderStyle  = 0
1666:             .BorderWidth  = 1
1667:             .SpecialEffect = 1
1668:             .Visible      = .T.
1669:         ENDWITH
1670: 
1671:         loc_oPnl.AddObject("lbl_4c_Say1", "Label")
1672:         WITH loc_oPnl.lbl_4c_Say1
1673:             .Top       = 2
1674:             .Left      = 117
1675:             .Width     = 280
1676:             .Height    = 20
1677:             .AutoSize  = .F.
1678:             .Alignment = 0
1679:             .BackStyle = 0
1680:             .FontBold  = .T.
1681:             .FontName  = "Tahoma"
1682:             .FontSize  = 14
1683:             .ForeColor = RGB(90, 90, 90)
1684:             .Caption   = "Notas Fiscais para Inutilizar"
1685:             .Visible   = .T.
1686:         ENDWITH
1687: 
1688:         loc_oPnl.AddObject("cmd_4c_BtnCancela", "CommandButton")
1689:         WITH loc_oPnl.cmd_4c_BtnCancela
1690:             .Top          = 28
1691:             .Left         = 408
1692:             .Height       = 75
1693:             .Width        = 75
1694:             .FontBold     = .T.
1695:             .FontItalic   = .T.
1696:             .FontName     = "Comic Sans MS"
1697:             .FontSize     = 8
1698:             .WordWrap     = .T.
1699:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1700:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1701:             .Caption      = "Encerrar"
1702:             .ForeColor    = RGB(90, 90, 90)
1703:             .BackColor    = RGB(255, 255, 255)
1704:             .Themes       = .T.
1705:             .Visible      = .T.
1706:         ENDWITH
1707: 
1708:         loc_oPnl.AddObject("grd_4c_Inu", "Grid")
1709:         loc_oGrd = loc_oPnl.grd_4c_Inu
1710:         WITH loc_oGrd
1711:             .Top           = 28
1712:             .Left          = 17
1713:             .Width         = 382
1714:             .Height        = 355
1715:             .FontName      = "Tahoma"
1716:             .FontSize      = 8
1717:             .DeleteMark    = .F.

*-- Linhas 1734 a 1742:
1734:             .Resizable   = .F.
1735:             .ReadOnly    = .T.
1736:             .ControlSource     = "cursor_4c_Inutil.Emps"
1737:             .Header1.Caption   = "Emp"
1738:             .Header1.Alignment = 2
1739:             .Text1.BorderStyle = 0
1740:             .Text1.Margin      = 0
1741:             .Text1.ReadOnly    = .T.
1742:             .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1749 a 1757:
1749:             .Resizable   = .F.
1750:             .ReadOnly    = .T.
1751:             .ControlSource     = "cursor_4c_Inutil.Series"
1752:             .Header1.Caption   = "S" + CHR(233) + "rie"
1753:             .Header1.Alignment = 2
1754:             .Text1.BorderStyle = 0
1755:             .Text1.Margin      = 0
1756:             .Text1.ReadOnly    = .T.
1757:             .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1764 a 1772:
1764:             .Resizable   = .F.
1765:             .ReadOnly    = .T.
1766:             .ControlSource     = "cursor_4c_Inutil.Notai"
1767:             .Header1.Caption   = "Nota Inicial"
1768:             .Header1.Alignment = 2
1769:             .Text1.BorderStyle = 0
1770:             .Text1.Margin      = 0
1771:             .Text1.ReadOnly    = .T.
1772:             .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1779 a 1787:
1779:             .Resizable   = .F.
1780:             .ReadOnly    = .T.
1781:             .ControlSource     = "cursor_4c_Inutil.Notaf"
1782:             .Header1.Caption   = "Nota Final"
1783:             .Header1.Alignment = 2
1784:             .Text1.BorderStyle = 0
1785:             .Text1.Margin      = 0
1786:             .Text1.ReadOnly    = .T.
1787:             .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 1794 a 1867:
1794:             .Resizable   = .F.
1795:             .ReadOnly    = .T.
1796:             .ControlSource     = "cursor_4c_Inutil.Cnpj"
1797:             .Header1.Caption   = "CPF/CNPJ"
1798:             .Header1.Alignment = 2
1799:             .Text1.BorderStyle = 0
1800:             .Text1.Margin      = 0
1801:             .Text1.ReadOnly    = .T.
1802:             .Text1.ForeColor   = RGB(0, 0, 0)
1803:             .Text1.BackColor   = RGB(255, 255, 255)
1804:         ENDWITH
1805: 
1806:         *-- Column6: Check1 (nMarca) - unica coluna editavel, 1a na ordem visual
1807:         *-- ORDEM OBRIGATORIA: o ControlSource da COLUNA vem ANTES do
1808:         *-- AddObject do CheckBox. O RecordSource do Grid ja amarrou Column6 ao
1809:         *-- 6o campo do cursor (Notaf, char) e o controle novo HERDA essa
1810:         *-- amarracao: adicionar o CheckBox antes de reapontar a coluna para
1811:         *-- nMarca (numerico) estoura "Error with CHK_4C_CHECK1 - Value : Data
1812:         *-- type mismatch" dentro do Init, o CREATEOBJECT devolve .F. e a tela
1813:         *-- NAO ABRE. Medido no VFP9 em 2026-10-17.
1814:         WITH loc_oGrd.Column6
1815:             .ColumnOrder    = 1
1816:             .Width          = 21
1817:             .Movable        = .F.
1818:             .Resizable      = .F.
1819:             .Sparse         = .F.
1820:             .ControlSource  = "cursor_4c_Inutil.nMarca"
1821:             .Header1.Caption = ""
1822:         ENDWITH
1823:         loc_oGrd.Column6.AddObject("chk_4c_Check1", "CheckBox")
1824:         WITH loc_oGrd.Column6.chk_4c_Check1
1825:             .Top       = 19
1826:             .Left      = 12
1827:             .Height    = 17
1828:             .Width     = 60
1829:             .Alignment = 0
1830:             .Caption   = ""
1831:             .ReadOnly  = .F.
1832:             .Visible   = .T.
1833:         ENDWITH
1834:         *-- CurrentControl por ULTIMO: sem ele a coluna segue desenhando o
1835:         *-- Text1 e o CheckBox nunca aparece (regra #18)
1836:         loc_oGrd.Column6.CurrentControl = "chk_4c_Check1"
1837: 
1838:         loc_oPnl.AddObject("cmd_4c_CmdProc", "CommandButton")
1839:         WITH loc_oPnl.cmd_4c_CmdProc
1840:             .Top          = 105
1841:             .Left         = 408
1842:             .Height       = 75
1843:             .Width        = 75
1844:             .FontBold     = .T.
1845:             .FontItalic   = .T.
1846:             .FontName     = "Comic Sans MS"
1847:             .FontSize     = 8
1848:             .WordWrap     = .T.
1849:             .Picture         = gc_4c_CaminhoIcones + "geral_multiplos_60.jpg"
1850:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_multiplos_60.jpg"
1851:             .Caption      = "Processar"
1852:             .ForeColor    = RGB(90, 90, 90)
1853:             .BackColor    = RGB(255, 255, 255)
1854:             .Themes       = .T.
1855:             .Visible      = .T.
1856:         ENDWITH
1857: 
1858:         *-- Eventos do painel (Fase 7): Encerrar fecha (CntInu.LostFocus do
1859:         *-- legado, chamado direto pelo botao); Processar valida e dispara a
1860:         *-- inutilizacao das linhas marcadas (cmdProc.Click).
1861:         BINDEVENT(loc_oPnl.cmd_4c_BtnCancela, "Click", THIS, "BtnCancelarClick")
1862:         BINDEVENT(loc_oPnl.cmd_4c_CmdProc, "Click", THIS, "BtnProcessarInutilizacaoClick")
1863:     ENDPROC
1864: 
1865: 
1866:     *--------------------------------------------------------------------------
1867:     * AplicarFiltrosIniciais - Valores com que o Init legado abre a tela:

*-- Linhas 1942 a 1951:
1942:                 THIS.BOParaForm()
1943: 
1944:                 *-- Versao do layout no rodape do painel (legado:
1945:                 *-- versao.Caption = [Versao :] + thisform.versaol)
1946:                 THIS.cnt_4c_Operacoes.lbl_4c_Versao.Caption = "Versao :" + THIS.this_cVersaoL
1947: 
1948:                 IF loc_lTemConexao
1949:                     IF !THIS.ChecarDirs()
1950:                         loc_lSucesso = .F.
1951:                     ENDIF

*-- Linhas 2222 a 2230:
2222:     * que mascararia o usuario ter limpado o campo de proposito.
2223:     *
2224:     * Conversoes obrigatorias ao atravessar a fronteira:
2225:     *   CheckBox.Value e' NUMERICO (0/1) e a property do BO e' LOGICA -> usar
2226:     *     (ctl.Value = 1), nunca atribuir direto (dispara "Data type mismatch"
2227:     *     na primeira expressao AND dentro do BO).
2228:     *   ComboBox devolve CARACTERE; OptionGroup devolve o INDICE 1-based, que
2229:     *     e' exatamente o valor que o legado usa nos DO CASE / INLIST.
2230:     *

*-- Linhas 2301 a 2315:
2301:     *
2302:     * Reproduz o bloco de pre-carga do Init legado, que escreve DIRETO nos
2303:     * controles (".cntOperacoes.getEmps.Value = _Empr", "getDtIni.Value =
2304:     * Date()", "getSeries.Value = ... LocalSer.Cods", "optTipos.Value =
2305:     * Iif(pOperas=[E],2,1)", "chkHVerao.Value = LocalParac.nfhverao") e, no
2306:     * fim, o bloco de pMovimentacao ("getDtIni/getDtFin = crAutNfi.Emis,
2307:     * getEmps = crAutNfi.Emps"). Sem este caminho a tela abre com Empresa e
2308:     * Datas em branco e a propria validacao de criterios recusa a selecao.
2309:     *
2310:     * CheckBox.Value e' NUMERICO: converter o Logico do BO com IIF(...,1,0).
2311:     *
2312:     * ESCOPO: igual ao FormParaBO - BOParaForm e' PROTECTED em FormBase e o
2313:     * override herda esse escopo, entao so' se chama com THIS., de dentro da
2314:     * classe (AplicarFiltrosIniciais eh o unico chamador).
2315:     *--------------------------------------------------------------------------

*-- Linhas 2650 a 2658:
2650:             THIS.HabilitarCampos(loc_lLivre)
2651: 
2652:             *-- Selecionar: so faz sentido sem selecao ativa
2653:             THIS.cmd_4c_CmdSelecionar.Enabled = loc_lLivre
2654: 
2655:             *-- cmdBtnForm: 1 = Limpar Selecao / 2 = Processar / 3 = Encerrar
2656:             *-- (Encerrar e a unica saida da tela e NUNCA e desabilitado)
2657:             THIS.obj_4c_CmdBtnForm.Buttons(1).Enabled = loc_lSel
2658:             THIS.obj_4c_CmdBtnForm.Buttons(2).Enabled = loc_lSel

*-- Linhas 2762 a 2773:
2762:     *--------------------------------------------------------------------------
2763:     * AlternarMarcacaoLinha - Inverte o SelImp da linha corrente.
2764:     *
2765:     * CheckBox em coluna de Grid NAO alterna pelo binding nativo: o legado
2766:     * SUPRIME o toggle padrao (Click/MouseDown com NoDefault) e inverte o
2767:     * valor por codigo no MouseUp e no KeyPress (Enter/Espaco). Migrar so o
2768:     * ControlSource deixa o checkbox inerte - o usuario clica e nada muda.
2769:     *--------------------------------------------------------------------------
2770:     PROCEDURE AlternarMarcacaoLinha()
2771:         LOCAL loc_oErro
2772: 
2773:         TRY

*-- Linhas 2828 a 2840:
2828: 
2829:     *--------------------------------------------------------------------------
2830:     * AjustarVisibilidadeInutilizar - optAcao.Valid do legado: o botao "..."
2831:     * (cmd_4c_CmdInu) so aparece quando a acao e inutilizacao de numeracao
2832:     * (4=NF-e / 7=NFC-e).
2833:     *--------------------------------------------------------------------------
2834:     PROCEDURE AjustarVisibilidadeInutilizar()
2835:         THIS.cnt_4c_Operacoes.cmd_4c_CmdInu.Visible = ;
2836:             INLIST(THIS.cnt_4c_Operacoes.obj_4c_OptAcao.Value, 4, 7)
2837:     ENDPROC
2838: 
2839:     *--------------------------------------------------------------------------
2840:     * BtnAcaoFormClick - cmdBtnForm.Click do legado (CommandGroup com os 3

*-- Linhas 3301 a 3334:
3301: 
3302:                 loc_cProtCompleto = loc_cProt + " " + SUBSTR(loc_cDataRec, 9, 2) + "/" + ;
3303:                     SUBSTR(loc_cDataRec, 6, 2) + "/" + SUBSTR(loc_cDataRec, 1, 4) + " " + ;
3304:                     SUBSTR(loc_cDataRec, 12, 8)
3305: 
3306:                 IF USED("cursor_4c_DanfeSimpl")
3307:                     USE IN cursor_4c_DanfeSimpl
3308:                 ENDIF
3309:                 CREATE CURSOR cursor_4c_DanfeSimpl (fin C(30), numero C(30), emissao C(30), ;
3310:                     chavea C(30), chave C(50), linha1e C(70), linha2e C(70), linha1d C(70), ;
3311:                     linha2d C(70), danfes C(30), prot C(60), prota C(60))
3312:                 INSERT INTO cursor_4c_DanfeSimpl (fin, numero, emissao, chavea, chave, linha1e, ;
3313:                     linha2e, linha1d, linha2d, danfes, prot, prota) VALUES ( ;
3314:                     loc_cFin, loc_cNumero, loc_cEmissao, "Chave de acesso", loc_cChave, ;
3315:                     loc_cLinha1E, loc_cLinha2E, loc_cLinha1D, loc_cLinha2D, ;
3316:                     "DANFE SIMPLIFICADO", loc_cProtCompleto, "Protocolo de autorizacao de uso")
3317: 
3318:                 SELECT cursor_4c_DanfeSimpl
3319:                 THIS.ExecutarReportForm("SigReDsi", "PREVIEW", "cursor_4c_DanfeSimpl")
3320:             ENDIF
3321: 
3322:             IF USED("cursor_4c_NfiDsi")
3323:                 USE IN cursor_4c_NfiDsi
3324:             ENDIF
3325:         CATCH TO loc_oErro
3326:             MsgErro(loc_oErro.Message + CHR(13) + ;
3327:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3328:                     "Procedure: " + loc_oErro.Procedure, ;
3329:                     "Erro ao imprimir DANFE simplificado")
3330:         ENDTRY
3331:     ENDPROC
3332: 
3333:     *--------------------------------------------------------------------------
3334:     * ExecutarReportForm (Pattern #117) - executa REPORT FORM so se o FRX

