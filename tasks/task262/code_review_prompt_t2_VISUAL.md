# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (21)
- [FONTNAME-ERRADO] Linha 190: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 206: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 224: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 839: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 848: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 934: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 944: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 955: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 993: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1002: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1012: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1069: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1082: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1095: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1109: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1122: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1135: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1148: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1162: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1257: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1266: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3043 linhas total):

*-- Linhas 58 a 74:
58:                     THIS.ConfigurarDados()
59:                     THIS.ConfigurarGrade()
60: 
61:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
62:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
63: 
64:                     BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnProcessarClick")
65:                     BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnAtualizarClick")
66:                     BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnEncerrarClick")
67:                     BINDEVENT(THIS.cmd_4c_Imprimir,          "Click", THIS, "BtnImprimirClick")
68:                     BINDEVENT(THIS.cmd_4c_SelTudo,           "Click", THIS, "BtnSelTudoClick")
69:                     BINDEVENT(THIS.cmd_4c_Desmarcar,         "Click", THIS, "BtnDesmarcarClick")
70: 
71:                     BINDEVENT(THIS.opt_4c_Recalc, "InteractiveChange", THIS, "OptRecalcChange")
72: 
73:                     BINDEVENT(THIS.txt_4c_CFornecs, "KeyPress", THIS, "TxtCFornecKeyPress")
74:                     BINDEVENT(THIS.txt_4c_MercI,   "KeyPress", THIS, "TxtMercIKeyPress")

*-- Linhas 123 a 166:
123:     *==========================================================================
124:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
125:         WITH THIS.cnt_4c_Cabecalho
126:             .Top         = 0
127:             .Left        = 0
128:             .Width       = THIS.Width
129:             .Height      = 80
130:             .BackStyle   = 1
131:             .BackColor   = RGB(100, 100, 100)
132:             .BorderWidth = 0
133: 
134:             .AddObject("lbl_4c_Sombra", "Label")
135:             WITH .lbl_4c_Sombra
136:                 .Top       = 18
137:                 .Left      = 10
138:                 .Width     = THIS.Width
139:                 .Height    = 40
140:                 .AutoSize  = .F.
141:                 .FontName  = "Tahoma"
142:                 .FontSize  = 18
143:                 .FontBold  = .T.
144:                 .BackStyle = 0
145:                 .ForeColor = RGB(0, 0, 0)
146:                 .Caption   = THIS.Caption
147:             ENDWITH
148: 
149:             .AddObject("lbl_4c_Titulo", "Label")
150:             WITH .lbl_4c_Titulo
151:                 .Top       = 17
152:                 .Left      = 10
153:                 .Width     = THIS.Width
154:                 .Height    = 46
155:                 .AutoSize  = .F.
156:                 .FontName  = "Tahoma"
157:                 .FontSize  = 18
158:                 .FontBold  = .T.
159:                 .BackStyle = 0
160:                 .ForeColor = RGB(255, 255, 255)
161:                 .Caption   = THIS.Caption
162:             ENDWITH
163:         ENDWITH
164:     ENDPROC
165: 
166:     *==========================================================================

*-- Linhas 174 a 1020:
174:             .BorderStyle   = 0
175:             .SpecialEffect = 1
176:             .Themes        = .F.
177:             .Top           = 0
178:             .Left          = 770
179:             .Width         = 235
180:             .Height        = 85
181: 
182:             WITH .Buttons(1)
183:                 .Top        = 5
184:                 .Left       = 5
185:                 .Width      = 75
186:                 .Height     = 75
187:                 .FontBold   = .T.
188:                 .FontItalic = .T.
189:                 .Caption    = "Processar"
190:                 .FontName        = "Comic Sans MS"
191:                 .FontSize        = 8
192:                 .WordWrap   = .T.
193:                 .ForeColor  = RGB(90, 90, 90)
194:                 .BackColor  = RGB(255, 255, 255)
195:                 .Themes     = .F.
196:                 .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
197:             ENDWITH
198: 
199:             WITH .Buttons(2)
200:                 .Top        = 5
201:                 .Left       = 80
202:                 .Width      = 75
203:                 .Height     = 75
204:                 .FontBold   = .T.
205:                 .FontItalic = .T.
206:                 .FontName   = "Comic Sans MS"
207:                 .FontSize   = 8
208:                 .Caption    = "Atualizar"
209:                 .WordWrap   = .T.
210:                 .ForeColor  = RGB(90, 90, 90)
211:                 .BackColor  = RGB(255, 255, 255)
212:                 .Themes     = .F.
213:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
214:                 .Enabled    = .F.
215:             ENDWITH
216: 
217:             WITH .Buttons(3)
218:                 .Top        = 5
219:                 .Left       = 155
220:                 .Width      = 75
221:                 .Height     = 75
222:                 .FontBold   = .T.
223:                 .FontItalic = .T.
224:                 .FontName   = "Comic Sans MS"
225:                 .FontSize   = 8
226:                 .Caption    = "Encerrar"
227:                 .WordWrap   = .T.
228:                 .ForeColor  = RGB(90, 90, 90)
229:                 .BackColor  = RGB(255, 255, 255)
230:                 .Themes     = .F.
231:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
232:                 .Cancel     = .T.
233:             ENDWITH
234:         ENDWITH
235: 
236:         *-- Botao Imprimir (standalone, inicia desabilitado)
237:         THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
238:         WITH THIS.cmd_4c_Imprimir
239:             .Top         = 3
240:             .Left        = 700
241:             .Width       = 65
242:             .Height      = 75
243:             .FontBold    = .T.
244:             .FontItalic  = .T.
245:             .FontName    = "Tahoma"
246:             .FontSize    = 8
247:             .Caption     = "Imprimir"
248:             .WordWrap    = .T.
249:             .ForeColor   = RGB(90, 90, 90)
250:             .BackColor   = RGB(255, 255, 255)
251:             .Themes      = .T.
252:             .Picture     = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
253:             .Enabled     = .F.
254:         ENDWITH
255: 
256:         *-- Botoes de selecao ao lado do grid
257:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
258:         WITH THIS.cmd_4c_SelTudo
259:             .Top         = 433
260:             .Left        = 955
261:             .Width       = 26
262:             .Height      = 26
263:             .Caption     = ""
264:             .Themes      = .T.
265:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
266:             .ToolTipText = "Selecionar Tudo"
267:             .TabStop     = .F.
268:         ENDWITH
269: 
270:         THIS.AddObject("cmd_4c_Desmarcar", "CommandButton")
271:         WITH THIS.cmd_4c_Desmarcar
272:             .Top         = 473
273:             .Left        = 955
274:             .Width       = 26
275:             .Height      = 26
276:             .Caption     = ""
277:             .Themes      = .T.
278:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
279:             .ToolTipText = "Desmarcar Tudo"
280:             .TabStop     = .F.
281:         ENDWITH
282:     ENDPROC
283: 
284:     *==========================================================================
285:     PROTECTED PROCEDURE ConfigurarFiltros()
286:     *==========================================================================
287:         *-- Label secao Filtros
288:         THIS.AddObject("lbl_4c_SecFiltros", "Label")
289:         WITH THIS.lbl_4c_SecFiltros
290:             .Top       = 94
291:             .Left      = 11
292:             .Width     = 53
293:             .Height    = 21
294:             .AutoSize  = .T.
295:             .FontName  = "Tahoma"
296:             .FontSize  = 12
297:             .FontBold  = .T.
298:             .BackStyle = 0
299:             .Caption   = "Filtros"
300:             .ForeColor = RGB(90, 90, 90)
301:         ENDWITH
302: 
303:         *-- Linha separadora abaixo dos filtros
304:         THIS.AddObject("lne_4c_Sep", "Line")
305:         WITH THIS.lne_4c_Sep
306:             .Top    = 258
307:             .Left   = 13
308:             .Height = 0
309:             .Width  = 738
310:         ENDWITH
311: 
312:         *-- Fornecedor
313:         THIS.AddObject("lbl_4c_Fornecedor", "Label")
314:         WITH THIS.lbl_4c_Fornecedor
315:             .Top       = 92
316:             .Left      = 79
317:             .Width     = 64
318:             .Height    = 15
319:             .AutoSize  = .T.
320:             .FontName  = "Tahoma"
321:             .FontSize  = 8
322:             .BackStyle = 0
323:             .Caption   = "Fornecedor :"
324:             .ForeColor = RGB(90, 90, 90)
325:         ENDWITH
326: 
327:         THIS.AddObject("txt_4c_CFornecs", "TextBox")
328:         WITH THIS.txt_4c_CFornecs
329:             .Top           = 88
330:             .Left          = 145
331:             .Width         = 80
332:             .Height        = 23
333:             .FontName      = "Tahoma"
334:             .FontSize      = 8
335:             .MaxLength     = 10
336:             .SpecialEffect = 1
337:             .Format        = "K!"
338:             .Value         = ""
339:         ENDWITH
340: 
341:         THIS.AddObject("txt_4c_DFornecs", "TextBox")
342:         WITH THIS.txt_4c_DFornecs
343:             .Top           = 88
344:             .Left          = 228
345:             .Width         = 197
346:             .Height        = 23
347:             .FontName      = "Tahoma"
348:             .FontSize      = 8
349:             .MaxLength     = 40
350:             .SpecialEffect = 1
351:             .ReadOnly      = .T.
352:             .Value         = ""
353:         ENDWITH
354: 
355:         *-- Linha (direita)
356:         THIS.AddObject("lbl_4c_Linha", "Label")
357:         WITH THIS.lbl_4c_Linha
358:             .Top       = 92
359:             .Left      = 503
360:             .Width     = 34
361:             .Height    = 15
362:             .FontName  = "Tahoma"
363:             .FontSize  = 8
364:             .BackStyle = 0
365:             .Caption   = "Linha :"
366:             .ForeColor = RGB(90, 90, 90)
367:         ENDWITH
368: 
369:         THIS.AddObject("txt_4c_Lini", "TextBox")
370:         WITH THIS.txt_4c_Lini
371:             .Top           = 88
372:             .Left          = 539
373:             .Width         = 84
374:             .Height        = 23
375:             .FontName      = "Tahoma"
376:             .FontSize      = 8
377:             .MaxLength     = 10
378:             .SpecialEffect = 1
379:             .Format        = "K"
380:             .Value         = ""
381:         ENDWITH
382: 
383:         THIS.AddObject("lbl_4c_LinhaAte", "Label")
384:         WITH THIS.lbl_4c_LinhaAte
385:             .Top       = 92
386:             .Left      = 627
387:             .FontName  = "Tahoma"
388:             .FontSize  = 8
389:             .BackStyle = 0
390:             .Caption   = "at" + CHR(233)
391:             .ForeColor = RGB(90, 90, 90)
392:         ENDWITH
393: 
394:         THIS.AddObject("txt_4c_Linf", "TextBox")
395:         WITH THIS.txt_4c_Linf
396:             .Top           = 88
397:             .Left          = 649
398:             .Width         = 84
399:             .Height        = 23
400:             .FontName      = "Tahoma"
401:             .FontSize      = 8
402:             .MaxLength     = 10
403:             .SpecialEffect = 1
404:             .Format        = "K"
405:             .Value         = ""
406:         ENDWITH
407: 
408:         *-- Grande Grupo (esquerda)
409:         THIS.AddObject("lbl_4c_GrGrupo", "Label")
410:         WITH THIS.lbl_4c_GrGrupo
411:             .Top       = 117
412:             .Left      = 67
413:             .Width     = 76
414:             .Height    = 15
415:             .FontName  = "Tahoma"
416:             .FontSize  = 8
417:             .BackStyle = 0
418:             .Caption   = "Grande Grupo :"
419:             .ForeColor = RGB(90, 90, 90)
420:         ENDWITH
421: 
422:         THIS.AddObject("txt_4c_MercI", "TextBox")
423:         WITH THIS.txt_4c_MercI
424:             .Top           = 113
425:             .Left          = 145
426:             .Width         = 31
427:             .Height        = 23
428:             .FontName      = "Tahoma"
429:             .FontSize      = 8
430:             .MaxLength     = 3
431:             .SpecialEffect = 1
432:             .Value         = ""
433:         ENDWITH
434: 
435:         THIS.AddObject("lbl_4c_GrGrupoAte", "Label")
436:         WITH THIS.lbl_4c_GrGrupoAte
437:             .Top       = 117
438:             .Left      = 179
439:             .FontName  = "Tahoma"
440:             .FontSize  = 8
441:             .BackStyle = 0
442:             .Caption   = "at" + CHR(233)
443:             .ForeColor = RGB(90, 90, 90)
444:         ENDWITH
445: 
446:         THIS.AddObject("txt_4c_MercF", "TextBox")
447:         WITH THIS.txt_4c_MercF
448:             .Top           = 113
449:             .Left          = 198
450:             .Width         = 31
451:             .Height        = 23
452:             .FontName      = "Tahoma"
453:             .FontSize      = 8
454:             .MaxLength     = 3
455:             .SpecialEffect = 1
456:             .Value         = ""
457:         ENDWITH
458: 
459:         *-- Grupo Venda/Colecao (direita)
460:         THIS.AddObject("lbl_4c_GrupoVenda", "Label")
461:         WITH THIS.lbl_4c_GrupoVenda
462:             .Top       = 117
463:             .Left      = 466
464:             .Width     = 71
465:             .Height    = 15
466:             .FontName  = "Tahoma"
467:             .FontSize  = 8
468:             .BackStyle = 0
469:             .Caption   = "Grupo Venda :"
470:             .ForeColor = RGB(90, 90, 90)
471:         ENDWITH
472: 
473:         THIS.AddObject("txt_4c_Coli", "TextBox")
474:         WITH THIS.txt_4c_Coli
475:             .Top           = 113
476:             .Left          = 539
477:             .Width         = 84
478:             .Height        = 23
479:             .FontName      = "Tahoma"
480:             .FontSize      = 8
481:             .MaxLength     = 10
482:             .SpecialEffect = 1
483:             .Format        = "K"
484:             .Value         = ""
485:         ENDWITH
486: 
487:         THIS.AddObject("lbl_4c_ColiAte", "Label")
488:         WITH THIS.lbl_4c_ColiAte
489:             .Top       = 117
490:             .Left      = 627
491:             .FontName  = "Tahoma"
492:             .FontSize  = 8
493:             .BackStyle = 0
494:             .Caption   = "at" + CHR(233)
495:             .ForeColor = RGB(90, 90, 90)
496:         ENDWITH
497: 
498:         THIS.AddObject("txt_4c_Colf", "TextBox")
499:         WITH THIS.txt_4c_Colf
500:             .Top           = 113
501:             .Left          = 649
502:             .Width         = 84
503:             .Height        = 23
504:             .FontName      = "Tahoma"
505:             .FontSize      = 8
506:             .MaxLength     = 10
507:             .SpecialEffect = 1
508:             .Format        = "K"
509:             .Value         = ""
510:         ENDWITH
511: 
512:         *-- Grupo (esquerda)
513:         THIS.AddObject("lbl_4c_Grupo", "Label")
514:         WITH THIS.lbl_4c_Grupo
515:             .Top       = 142
516:             .Left      = 105
517:             .Width     = 38
518:             .Height    = 15
519:             .FontName  = "Tahoma"
520:             .FontSize  = 8
521:             .BackStyle = 0
522:             .Caption   = "Grupo :"
523:             .ForeColor = RGB(90, 90, 90)
524:         ENDWITH
525: 
526:         THIS.AddObject("txt_4c_CGrui", "TextBox")
527:         WITH THIS.txt_4c_CGrui
528:             .Top           = 138
529:             .Left          = 145
530:             .Width         = 31
531:             .Height        = 23
532:             .FontName      = "Tahoma"
533:             .FontSize      = 8
534:             .MaxLength     = 3
535:             .SpecialEffect = 1
536:             .Value         = ""
537:         ENDWITH
538: 
539:         THIS.AddObject("lbl_4c_GrupoAte", "Label")
540:         WITH THIS.lbl_4c_GrupoAte
541:             .Top       = 142
542:             .Left      = 179
543:             .FontName  = "Tahoma"
544:             .FontSize  = 8
545:             .BackStyle = 0
546:             .Caption   = "at" + CHR(233)
547:             .ForeColor = RGB(90, 90, 90)
548:         ENDWITH
549: 
550:         THIS.AddObject("txt_4c_CGruf", "TextBox")
551:         WITH THIS.txt_4c_CGruf
552:             .Top           = 138
553:             .Left          = 198
554:             .Width         = 31
555:             .Height        = 23
556:             .FontName      = "Tahoma"
557:             .FontSize      = 8
558:             .MaxLength     = 3
559:             .SpecialEffect = 1
560:             .Value         = ""
561:         ENDWITH
562: 
563:         *-- Markup (direita)
564:         THIS.AddObject("lbl_4c_Markup", "Label")
565:         WITH THIS.lbl_4c_Markup
566:             .Top       = 142
567:             .Left      = 493
568:             .Width     = 44
569:             .Height    = 15
570:             .FontName  = "Tahoma"
571:             .FontSize  = 8
572:             .BackStyle = 0
573:             .Caption   = "Markup :"
574:             .ForeColor = RGB(90, 90, 90)
575:         ENDWITH
576: 
577:         THIS.AddObject("txt_4c_Mrki", "TextBox")
578:         WITH THIS.txt_4c_Mrki
579:             .Top           = 138
580:             .Left          = 539
581:             .Width         = 84
582:             .Height        = 23
583:             .FontName      = "Tahoma"
584:             .FontSize      = 8
585:             .SpecialEffect = 1
586:             .InputMask     = "999.99"
587:             .Format        = "K"
588:             .Value         = 0
589:         ENDWITH
590: 
591:         THIS.AddObject("lbl_4c_MarkupAte", "Label")
592:         WITH THIS.lbl_4c_MarkupAte
593:             .Top       = 142
594:             .Left      = 627
595:             .FontName  = "Tahoma"
596:             .FontSize  = 8
597:             .BackStyle = 0
598:             .Caption   = "at" + CHR(233)
599:             .ForeColor = RGB(90, 90, 90)
600:         ENDWITH
601: 
602:         THIS.AddObject("txt_4c_Mrkf", "TextBox")
603:         WITH THIS.txt_4c_Mrkf
604:             .Top           = 138
605:             .Left          = 649
606:             .Width         = 84
607:             .Height        = 23
608:             .FontName      = "Tahoma"
609:             .FontSize      = 8
610:             .SpecialEffect = 1
611:             .InputMask     = "999.99"
612:             .Format        = "K"
613:             .Value         = 0
614:         ENDWITH
615: 
616:         *-- Subgrupo (esquerda)
617:         THIS.AddObject("lbl_4c_Subgrupo", "Label")
618:         WITH THIS.lbl_4c_Subgrupo
619:             .Top       = 167
620:             .Left      = 88
621:             .Width     = 55
622:             .Height    = 15
623:             .FontName  = "Tahoma"
624:             .FontSize  = 8
625:             .BackStyle = 0
626:             .Caption   = "Subgrupo :"
627:             .ForeColor = RGB(90, 90, 90)
628:         ENDWITH
629: 
630:         THIS.AddObject("txt_4c_SgruI", "TextBox")
631:         WITH THIS.txt_4c_SgruI
632:             .Top           = 163
633:             .Left          = 145
634:             .Width         = 52
635:             .Height        = 23
636:             .FontName      = "Tahoma"
637:             .FontSize      = 8
638:             .MaxLength     = 6
639:             .SpecialEffect = 1
640:             .Value         = ""
641:         ENDWITH
642: 
643:         THIS.AddObject("lbl_4c_SubgrupoAte", "Label")
644:         WITH THIS.lbl_4c_SubgrupoAte
645:             .Top       = 167
646:             .Left      = 201
647:             .FontName  = "Tahoma"
648:             .FontSize  = 8
649:             .BackStyle = 0
650:             .Caption   = "at" + CHR(233)
651:             .ForeColor = RGB(90, 90, 90)
652:         ENDWITH
653: 
654:         THIS.AddObject("txt_4c_SgruF", "TextBox")
655:         WITH THIS.txt_4c_SgruF
656:             .Top           = 163
657:             .Left          = 220
658:             .Width         = 52
659:             .Height        = 23
660:             .FontName      = "Tahoma"
661:             .FontSize      = 8
662:             .MaxLength     = 6
663:             .SpecialEffect = 1
664:             .Value         = ""
665:         ENDWITH
666: 
667:         *-- Encargo (direita)
668:         THIS.AddObject("lbl_4c_EncFiltro", "Label")
669:         WITH THIS.lbl_4c_EncFiltro
670:             .Top       = 167
671:             .Left      = 486
672:             .Width     = 51
673:             .Height    = 15
674:             .FontName  = "Tahoma"
675:             .FontSize  = 8
676:             .BackStyle = 0
677:             .Caption   = "Encargo :"
678:             .ForeColor = RGB(90, 90, 90)
679:         ENDWITH
680: 
681:         THIS.AddObject("txt_4c_EncI", "TextBox")
682:         WITH THIS.txt_4c_EncI
683:             .Top           = 163
684:             .Left          = 539
685:             .Width         = 84
686:             .Height        = 23
687:             .FontName      = "Tahoma"
688:             .FontSize      = 8
689:             .SpecialEffect = 1
690:             .InputMask     = "999.99"
691:             .Format        = "K"
692:             .Value         = 0
693:         ENDWITH
694: 
695:         THIS.AddObject("lbl_4c_EncAte", "Label")
696:         WITH THIS.lbl_4c_EncAte
697:             .Top       = 167
698:             .Left      = 627
699:             .FontName  = "Tahoma"
700:             .FontSize  = 8
701:             .BackStyle = 0
702:             .Caption   = "at" + CHR(233)
703:             .ForeColor = RGB(90, 90, 90)
704:         ENDWITH
705: 
706:         THIS.AddObject("txt_4c_EncF", "TextBox")
707:         WITH THIS.txt_4c_EncF
708:             .Top           = 163
709:             .Left          = 649
710:             .Width         = 84
711:             .Height        = 23
712:             .FontName      = "Tahoma"
713:             .FontSize      = 8
714:             .SpecialEffect = 1
715:             .InputMask     = "999.99"
716:             .Format        = "K"
717:             .Value         = 0
718:         ENDWITH
719: 
720:         *-- Unidade (esquerda)
721:         THIS.AddObject("lbl_4c_Unidade", "Label")
722:         WITH THIS.lbl_4c_Unidade
723:             .Top       = 193
724:             .Left      = 95
725:             .Width     = 48
726:             .Height    = 15
727:             .FontName  = "Tahoma"
728:             .FontSize  = 8
729:             .BackStyle = 0
730:             .Caption   = "Unidade :"
731:             .ForeColor = RGB(90, 90, 90)
732:         ENDWITH
733: 
734:         THIS.AddObject("txt_4c_CUnii", "TextBox")
735:         WITH THIS.txt_4c_CUnii
736:             .Top           = 189
737:             .Left          = 145
738:             .Width         = 31
739:             .Height        = 23
740:             .FontName      = "Tahoma"
741:             .FontSize      = 8
742:             .MaxLength     = 3
743:             .SpecialEffect = 1
744:             .Value         = ""
745:         ENDWITH
746: 
747:         THIS.AddObject("lbl_4c_UnidadeAte", "Label")
748:         WITH THIS.lbl_4c_UnidadeAte
749:             .Top       = 193
750:             .Left      = 179
751:             .FontName  = "Tahoma"
752:             .FontSize  = 8
753:             .BackStyle = 0
754:             .Caption   = "at" + CHR(233)
755:             .ForeColor = RGB(90, 90, 90)
756:         ENDWITH
757: 
758:         THIS.AddObject("txt_4c_CUnif", "TextBox")
759:         WITH THIS.txt_4c_CUnif
760:             .Top           = 189
761:             .Left          = 198
762:             .Width         = 31
763:             .Height        = 23
764:             .FontName      = "Tahoma"
765:             .FontSize      = 8
766:             .MaxLength     = 3
767:             .SpecialEffect = 1
768:             .Value         = ""
769:         ENDWITH
770: 
771:         *-- Variacao e Feitio (direita)
772:         THIS.AddObject("lbl_4c_Variacao", "Label")
773:         WITH THIS.lbl_4c_Variacao
774:             .Top       = 193
775:             .Left      = 456
776:             .Width     = 81
777:             .Height    = 15
778:             .FontName  = "Tahoma"
779:             .FontSize  = 8
780:             .BackStyle = 0
781:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o ( % ) : "
782:             .ForeColor = RGB(90, 90, 90)
783:         ENDWITH
784: 
785:         THIS.AddObject("txt_4c_Variacao", "TextBox")
786:         WITH THIS.txt_4c_Variacao
787:             .Top           = 189
788:             .Left          = 539
789:             .Width         = 80
790:             .Height        = 23
791:             .FontName      = "Tahoma"
792:             .FontSize      = 8
793:             .SpecialEffect = 1
794:             .InputMask     = "999.99"
795:             .Format        = "K"
796:             .Value         = 0
797:         ENDWITH
798: 
799:         THIS.AddObject("lbl_4c_CodMKP", "Label")
800:         WITH THIS.lbl_4c_CodMKP
801:             .Top       = 193
802:             .Left      = 639
803:             .Width     = 68
804:             .Height    = 15
805:             .FontName  = "Tahoma"
806:             .FontSize  = 8
807:             .BackStyle = 0
808:             .Caption   = "C" + CHR(243) + "digo MKP : "
809:             .ForeColor = RGB(90, 90, 90)
810:         ENDWITH
811: 
812:         THIS.AddObject("txt_4c_Feitio", "TextBox")
813:         WITH THIS.txt_4c_Feitio
814:             .Top           = 189
815:             .Left          = 709
816:             .Width         = 24
817:             .Height        = 23
818:             .FontName      = "Tahoma"
819:             .FontSize      = 8
820:             .MaxLength     = 2
821:             .SpecialEffect = 1
822:             .Value         = ""
823:         ENDWITH
824: 
825:         *-- Tipo Moeda (centro)
826:         THIS.AddObject("opt_4c_TipoMoeda", "OptionGroup")
827:         WITH THIS.opt_4c_TipoMoeda
828:             .Top         = 211
829:             .Left        = 234
830:             .Width       = 106
831:             .Height      = 26
832:             .ButtonCount = 2
833:             .BackStyle   = 0
834:             .BorderStyle = 0
835:             .Value       = 1
836: 
837:             WITH .Buttons(1)
838:                 .Caption  = "Ideal"
839:                 .FontName        = "Comic Sans MS"
840:                 .FontSize        = 8
841:                 .Left     = 5
842:                 .Top      = 5
843:                 .AutoSize = .T.
844:                 .Themes   = .F.
845:             ENDWITH
846:             WITH .Buttons(2)
847:                 .Caption  = "Venda"
848:                 .FontName        = "Comic Sans MS"
849:                 .Left     = 53
850:                 .Top      = 6
851:                 .AutoSize = .T.
852:                 .FontSize = 8
853:                 .Themes   = .F.
854:             ENDWITH
855:         ENDWITH
856: 
857:         *-- Moeda (esquerda)
858:         THIS.AddObject("lbl_4c_Moeda", "Label")
859:         WITH THIS.lbl_4c_Moeda
860:             .Top       = 217
861:             .Left      = 102
862:             .Width     = 41
863:             .Height    = 15
864:             .FontName  = "Tahoma"
865:             .FontSize  = 8
866:             .BackStyle = 0
867:             .Caption   = "Moeda :"
868:             .ForeColor = RGB(90, 90, 90)
869:         ENDWITH
870: 
871:         THIS.AddObject("txt_4c_Moedai", "TextBox")
872:         WITH THIS.txt_4c_Moedai
873:             .Top           = 213
874:             .Left          = 145
875:             .Width         = 31
876:             .Height        = 23
877:             .FontName      = "Tahoma"
878:             .FontSize      = 8
879:             .MaxLength     = 3
880:             .SpecialEffect = 1
881:             .Value         = ""
882:         ENDWITH
883: 
884:         THIS.AddObject("lbl_4c_MoedaAte", "Label")
885:         WITH THIS.lbl_4c_MoedaAte
886:             .Top       = 217
887:             .Left      = 179
888:             .AutoSize  = .T.
889:             .FontName  = "Tahoma"
890:             .FontSize  = 8
891:             .BackStyle = 0
892:             .Caption   = "at" + CHR(233)
893:             .ForeColor = RGB(90, 90, 90)
894:         ENDWITH
895: 
896:         THIS.AddObject("txt_4c_Moedaf", "TextBox")
897:         WITH THIS.txt_4c_Moedaf
898:             .Top           = 213
899:             .Left          = 198
900:             .Width         = 31
901:             .Height        = 23
902:             .FontName      = "Tahoma"
903:             .FontSize      = 8
904:             .MaxLength     = 3
905:             .SpecialEffect = 1
906:             .Value         = ""
907:         ENDWITH
908: 
909:         *-- Situacao (direita)
910:         THIS.AddObject("lbl_4c_Situacao", "Label")
911:         WITH THIS.lbl_4c_Situacao
912:             .Top       = 217
913:             .Left      = 486
914:             .FontName  = "Tahoma"
915:             .FontSize  = 8
916:             .BackStyle = 0
917:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
918:             .ForeColor = RGB(90, 90, 90)
919:         ENDWITH
920: 
921:         THIS.AddObject("opt_4c_Situacao", "OptionGroup")
922:         WITH THIS.opt_4c_Situacao
923:             .Top         = 214
924:             .Left        = 536
925:             .Width       = 189
926:             .Height      = 21
927:             .ButtonCount = 3
928:             .BackStyle   = 0
929:             .BorderStyle = 0
930:             .Value       = 1
931: 
932:             WITH .Buttons(1)
933:                 .Caption       = "Ativos"
934:                 .FontName        = "Comic Sans MS"
935:                 .FontSize        = 8
936:                 .Left          = 5
937:                 .Top           = 3
938:                 .AutoSize      = .T.
939:                 .SpecialEffect = 0
940:                 .Themes        = .F.
941:             ENDWITH
942:             WITH .Buttons(2)
943:                 .Caption       = "Inativos"
944:                 .FontName        = "Comic Sans MS"
945:                 .FontSize        = 8
946:                 .Left          = 59
947:                 .Top           = 2
948:                 .AutoSize      = .F.
949:                 .SpecialEffect = 0
950:                 .Themes        = .F.
951:             ENDWITH
952:             WITH .Buttons(3)
953:                 .Caption       = "Todos"
954:                 .WordWrap        = .T.
955:                 .FontName        = "Comic Sans MS"
956:                 .FontSize        = 8
957:                 .Left          = 125
958:                 .Top           = 2
959:                 .Width         = 61
960:                 .Height        = 17
961:                 .AutoSize      = .F.
962:                 .SpecialEffect = 0
963:                 .ForeColor     = RGB(90, 90, 90)
964:                 .Themes        = .F.
965:             ENDWITH
966:         ENDWITH
967: 
968:         *-- Compra (direita)
969:         THIS.AddObject("lbl_4c_Compra", "Label")
970:         WITH THIS.lbl_4c_Compra
971:             .Top       = 237
972:             .Left      = 490
973:             .FontName  = "Tahoma"
974:             .FontSize  = 8
975:             .BackStyle = 0
976:             .Caption   = "Compra :"
977:             .ForeColor = RGB(90, 90, 90)
978:         ENDWITH
979: 
980:         THIS.AddObject("opt_4c_Compra", "OptionGroup")
981:         WITH THIS.opt_4c_Compra
982:             .Top         = 234
983:             .Left        = 536
984:             .Width       = 204
985:             .Height      = 21
986:             .ButtonCount = 3
987:             .BackStyle   = 0
988:             .BorderStyle = 0
989:             .Value       = 3
990: 
991:             WITH .Buttons(1)
992:                 .Caption  = "Comprar"
993:                 .FontName        = "Comic Sans MS"
994:                 .FontSize        = 8
995:                 .Left     = 5
996:                 .Top      = 3
997:                 .AutoSize = .T.
998:                 .Themes   = .F.
999:             ENDWITH
1000:             WITH .Buttons(2)
1001:                 .Caption  = "N" + CHR(227) + "o Comprar"
1002:                 .FontName        = "Comic Sans MS"
1003:                 .FontSize        = 8
1004:                 .Left     = 67
1005:                 .Top      = 3
1006:                 .AutoSize = .T.
1007:                 .Themes   = .F.
1008:             ENDWITH
1009:             WITH .Buttons(3)
1010:                 .Caption   = "Todos"
1011:                 .WordWrap        = .T.
1012:                 .FontName        = "Comic Sans MS"
1013:                 .FontSize        = 8
1014:                 .Left      = 152
1015:                 .Top       = 2
1016:                 .Width     = 61
1017:                 .Height    = 17
1018:                 .AutoSize  = .F.
1019:                 .ForeColor = RGB(90, 90, 90)
1020:                 .Themes    = .F.

*-- Linhas 1026 a 1342:
1026:     PROTECTED PROCEDURE ConfigurarDados()
1027:     *==========================================================================
1028:         *-- Label secao Dados
1029:         THIS.AddObject("lbl_4c_SecDados", "Label")
1030:         WITH THIS.lbl_4c_SecDados
1031:             .Top       = 270
1032:             .Left      = 12
1033:             .Width     = 52
1034:             .Height    = 21
1035:             .AutoSize  = .T.
1036:             .FontName  = "Tahoma"
1037:             .FontSize  = 12
1038:             .FontBold  = .T.
1039:             .BackStyle = 0
1040:             .Caption   = "Dados"
1041:             .ForeColor = RGB(90, 90, 90)
1042:         ENDWITH
1043: 
1044:         *-- Recalcula (8 opcoes em 2 linhas)
1045:         THIS.AddObject("lbl_4c_Recalcula", "Label")
1046:         WITH THIS.lbl_4c_Recalcula
1047:             .Top       = 263
1048:             .Left      = 89
1049:             .FontName  = "Tahoma"
1050:             .FontSize  = 8
1051:             .BackStyle = 0
1052:             .Caption   = "Recalcula :"
1053:             .ForeColor = RGB(90, 90, 90)
1054:         ENDWITH
1055: 
1056:         THIS.AddObject("opt_4c_Recalc", "OptionGroup")
1057:         WITH THIS.opt_4c_Recalc
1058:             .Top         = 258
1059:             .Left        = 142
1060:             .Width       = 439
1061:             .Height      = 41
1062:             .ButtonCount = 8
1063:             .BackStyle   = 0
1064:             .BorderStyle = 0
1065:             .Value       = 1
1066: 
1067:             WITH .Buttons(1)
1068:                 .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
1069:                 .FontName        = "Comic Sans MS"
1070:                 .FontSize        = 8
1071:                 .Left      = 5
1072:                 .Top       = 5
1073:                 .AutoSize  = .T.
1074:                 .ForeColor = RGB(90, 90, 90)
1075:                 .Themes    = .F.
1076:             ENDWITH
1077:             WITH .Buttons(2)
1078:                 .Caption   = "Custo Venda"
1079:                 .Left      = 98
1080:                 .Top       = 5
1081:                 .AutoSize  = .T.
1082:                 .FontName  = "Comic Sans MS"
1083:                 .FontSize  = 8
1084:                 .ForeColor = RGB(90, 90, 90)
1085:                 .Themes    = .F.
1086:             ENDWITH
1087:             WITH .Buttons(3)
1088:                 .Caption   = "Ambos"
1089:                 .WordWrap        = .T.
1090:                 .Left      = 213
1091:                 .Top       = 5
1092:                 .Width     = 50
1093:                 .Height    = 15
1094:                 .AutoSize  = .T.
1095:                 .FontName  = "Comic Sans MS"
1096:                 .FontSize  = 8
1097:                 .BackStyle = 0
1098:                 .ForeColor = RGB(90, 90, 90)
1099:                 .Themes    = .F.
1100:             ENDWITH
1101:             WITH .Buttons(4)
1102:                 .Caption   = "Peso Componentes"
1103:                 .WordWrap        = .T.
1104:                 .Left      = 312
1105:                 .Top       = 4
1106:                 .Width     = 110
1107:                 .Height    = 15
1108:                 .AutoSize  = .T.
1109:                 .FontName  = "Comic Sans MS"
1110:                 .FontSize  = 8
1111:                 .BackStyle = 0
1112:                 .ForeColor = RGB(90, 90, 90)
1113:                 .Themes    = .F.
1114:             ENDWITH
1115:             WITH .Buttons(5)
1116:                 .Caption   = "C" + CHR(226) + "mbio"
1117:                 .Left      = 5
1118:                 .Top       = 23
1119:                 .Width     = 53
1120:                 .Height    = 15
1121:                 .AutoSize  = .T.
1122:                 .FontName  = "Comic Sans MS"
1123:                 .FontSize  = 8
1124:                 .BackStyle = 0
1125:                 .ForeColor = RGB(90, 90, 90)
1126:                 .Themes    = .F.
1127:             ENDWITH
1128:             WITH .Buttons(6)
1129:                 .Caption   = "C" + CHR(226) + "mbio (Inteiros)"
1130:                 .Left      = 98
1131:                 .Top       = 23
1132:                 .Width     = 101
1133:                 .Height    = 15
1134:                 .AutoSize  = .T.
1135:                 .FontName  = "Comic Sans MS"
1136:                 .FontSize  = 8
1137:                 .BackStyle = 0
1138:                 .ForeColor = RGB(90, 90, 90)
1139:                 .Themes    = .F.
1140:             ENDWITH
1141:             WITH .Buttons(7)
1142:                 .Caption       = "Markup Custo"
1143:                 .Left          = 213
1144:                 .Top           = 23
1145:                 .Width         = 84
1146:                 .Height        = 15
1147:                 .AutoSize      = .T.
1148:                 .FontName      = "Comic Sans MS"
1149:                 .FontSize      = 8
1150:                 .BackStyle     = 0
1151:                 .SpecialEffect = 0
1152:                 .ForeColor     = RGB(90, 90, 90)
1153:                 .Themes        = .F.
1154:             ENDWITH
1155:             WITH .Buttons(8)
1156:                 .Caption   = "Markup Venda"
1157:                 .Left      = 312
1158:                 .Top       = 22
1159:                 .Width     = 86
1160:                 .Height    = 15
1161:                 .AutoSize  = .T.
1162:                 .FontName  = "Comic Sans MS"
1163:                 .FontSize  = 8
1164:                 .BackStyle = 0
1165:                 .ForeColor = RGB(90, 90, 90)
1166:                 .Themes    = .F.
1167:             ENDWITH
1168:         ENDWITH
1169: 
1170:         *-- Reajuste
1171:         THIS.AddObject("lbl_4c_Reajuste", "Label")
1172:         WITH THIS.lbl_4c_Reajuste
1173:             .Top       = 304
1174:             .Left      = 91
1175:             .Width     = 52
1176:             .Height    = 15
1177:             .FontName  = "Tahoma"
1178:             .FontSize  = 8
1179:             .BackStyle = 0
1180:             .Caption   = "Reajuste :"
1181:             .ForeColor = RGB(90, 90, 90)
1182:         ENDWITH
1183: 
1184:         THIS.AddObject("txt_4c_Reajuste", "TextBox")
1185:         WITH THIS.txt_4c_Reajuste
1186:             .Top           = 300
1187:             .Left          = 148
1188:             .Width         = 80
1189:             .Height        = 23
1190:             .FontName      = "Tahoma"
1191:             .FontSize      = 8
1192:             .Alignment     = 3
1193:             .SpecialEffect = 1
1194:             .InputMask     = "999,999.999"
1195:             .Format        = "K"
1196:             .Value         = 0
1197:         ENDWITH
1198: 
1199:         *-- Novo Encargo
1200:         THIS.AddObject("lbl_4c_NovoEncargo", "Label")
1201:         WITH THIS.lbl_4c_NovoEncargo
1202:             .Top       = 304
1203:             .Left      = 245
1204:             .Width     = 79
1205:             .Height    = 15
1206:             .FontName  = "Tahoma"
1207:             .FontSize  = 8
1208:             .BackStyle = 0
1209:             .Caption   = "Novo Encargo : "
1210:             .ForeColor = RGB(90, 90, 90)
1211:         ENDWITH
1212: 
1213:         THIS.AddObject("txt_4c_Encargo", "TextBox")
1214:         WITH THIS.txt_4c_Encargo
1215:             .Top           = 300
1216:             .Left          = 326
1217:             .Width         = 80
1218:             .Height        = 23
1219:             .FontName      = "Tahoma"
1220:             .FontSize      = 8
1221:             .Alignment     = 3
1222:             .SpecialEffect = 1
1223:             .InputMask     = "999,999.99"
1224:             .Format        = "K"
1225:             .Value         = 0
1226:         ENDWITH
1227: 
1228:         *-- Atualiza Val.Venda
1229:         THIS.AddObject("lbl_4c_AtuVenda", "Label")
1230:         WITH THIS.lbl_4c_AtuVenda
1231:             .Top       = 304
1232:             .Left      = 448
1233:             .Width     = 98
1234:             .Height    = 15
1235:             .AutoSize  = .T.
1236:             .FontName  = "Tahoma"
1237:             .FontSize  = 8
1238:             .BackStyle = 0
1239:             .Caption   = "Atualiza Val.Venda :"
1240:             .ForeColor = RGB(90, 90, 90)
1241:         ENDWITH
1242: 
1243:         THIS.AddObject("opt_4c_Pven", "OptionGroup")
1244:         WITH THIS.opt_4c_Pven
1245:             .Top         = 298
1246:             .Left        = 544
1247:             .Width       = 102
1248:             .Height      = 27
1249:             .ButtonCount = 2
1250:             .BackStyle   = 0
1251:             .BorderStyle = 0
1252:             .AutoSize    = .F.
1253:             .Value       = 2
1254: 
1255:             WITH .Buttons(1)
1256:                 .Caption  = "Sim"
1257:                 .FontName        = "Comic Sans MS"
1258:                 .FontSize        = 8
1259:                 .Left     = 5
1260:                 .Top      = 5
1261:                 .AutoSize = .T.
1262:                 .Themes   = .F.
1263:             ENDWITH
1264:             WITH .Buttons(2)
1265:                 .Caption  = "N" + CHR(227) + "o"
1266:                 .FontName        = "Comic Sans MS"
1267:                 .FontSize        = 8
1268:                 .Left     = 53
1269:                 .Top      = 5
1270:                 .Width    = 44
1271:                 .Height   = 17
1272:                 .AutoSize = .F.
1273:                 .Themes   = .F.
1274:             ENDWITH
1275:         ENDWITH
1276: 
1277:         *-- Novo Markup
1278:         THIS.AddObject("lbl_4c_NovoMarkup", "Label")
1279:         WITH THIS.lbl_4c_NovoMarkup
1280:             .Top       = 330
1281:             .Left      = 71
1282:             .Width     = 72
1283:             .Height    = 15
1284:             .FontName  = "Tahoma"
1285:             .FontSize  = 8
1286:             .BackStyle = 0
1287:             .Caption   = "Novo Markup :"
1288:             .ForeColor = RGB(90, 90, 90)
1289:         ENDWITH
1290: 
1291:         THIS.AddObject("txt_4c_NMrk", "TextBox")
1292:         WITH THIS.txt_4c_NMrk
1293:             .Top           = 326
1294:             .Left          = 148
1295:             .Width         = 80
1296:             .Height        = 23
1297:             .FontName      = "Tahoma"
1298:             .FontSize      = 8
1299:             .Alignment     = 3
1300:             .SpecialEffect = 1
1301:             .InputMask     = "999,999.99"
1302:             .Format        = "K"
1303:             .Value         = 0
1304:         ENDWITH
1305: 
1306:         *-- Novo MKP
1307:         THIS.AddObject("lbl_4c_NovoMkp", "Label")
1308:         WITH THIS.lbl_4c_NovoMkp
1309:             .Top       = 330
1310:             .Left      = 264
1311:             .Width     = 60
1312:             .Height    = 15
1313:             .FontName  = "Tahoma"
1314:             .FontSize  = 8
1315:             .BackStyle = 0
1316:             .Caption   = "Novo MKP : "
1317:             .ForeColor = RGB(90, 90, 90)
1318:         ENDWITH
1319: 
1320:         THIS.AddObject("txt_4c_NewMkp", "TextBox")
1321:         WITH THIS.txt_4c_NewMkp
1322:             .Top           = 326
1323:             .Left          = 326
1324:             .Width         = 24
1325:             .Height        = 23
1326:             .FontName      = "Tahoma"
1327:             .FontSize      = 8
1328:             .MaxLength     = 2
1329:             .SpecialEffect = 1
1330:             .Value         = ""
1331:         ENDWITH
1332: 
1333:         *-- Imagem do produto (inicia oculta)
1334:         THIS.AddObject("img_4c_Produto", "Image")
1335:         WITH THIS.img_4c_Produto
1336:             .Top     = 128
1337:             .Left    = 764
1338:             .Width   = 223
1339:             .Height  = 190
1340:             .Stretch = 1
1341:             .Visible = .F.
1342:         ENDWITH

*-- Linhas 1349 a 1383:
1349:         THIS.grd_4c_Produto.ColumnCount  = 9
1350:         THIS.grd_4c_Produto.RecordSource = "cursor_4c_Produtos"
1351:         WITH THIS.grd_4c_Produto
1352:             .Top          = 351
1353:             .Left         = 12
1354:             .Width        = 935
1355:             .Height       = 244
1356:             .FontName     = "Tahoma"
1357:             .FontSize     = 8
1358:             .RowHeight    = 18
1359:             .ScrollBars   = 2
1360:             .ReadOnly     = .F.
1361: 
1362:             *-- Column1: CheckBox lMarca
1363:             WITH .Column1
1364:                 .Width        = 17
1365:                 .HeaderHeight       = 0
1366:                 .Alignment    = 3
1367:                 .Movable      = .F.
1368:                 .Resizable    = .F.
1369:                 .Sparse       = .F.
1370:                 .FontName     = "Tahoma"
1371:                 .FontSize     = 8
1372:                 .AddObject("Check1", "CheckBox")
1373:                 .Check1.Caption = ""
1374:                 .Check1.Value   = 0
1375:                 .CurrentControl = "Check1"
1376:                 .ControlSource  = "cursor_4c_Produtos.lMarca"
1377:                 WITH .Header1
1378:                     .Caption   = ""
1379:                     .FontName  = "Tahoma"
1380:                     .FontSize  = 8
1381:                     .Alignment = 2
1382:                     .ForeColor = RGB(36, 84, 155)
1383:                 ENDWITH

*-- Linhas 1392 a 1400:
1392:                 .FontSize      = 8
1393:                 .ControlSource = "cursor_4c_Produtos.CPros"
1394:                 WITH .Header1
1395:                     .Caption   = "Produto"
1396:                     .FontName  = "Tahoma"
1397:                     .FontSize  = 8
1398:                     .Alignment = 2
1399:                     .ForeColor = RGB(36, 84, 155)
1400:                 ENDWITH

*-- Linhas 1409 a 1417:
1409:                 .FontSize      = 8
1410:                 .ControlSource = "cursor_4c_Produtos.DPros"
1411:                 WITH .Header1
1412:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1413:                     .FontName  = "Tahoma"
1414:                     .FontSize  = 8
1415:                     .Alignment = 2
1416:                     .ForeColor = RGB(36, 84, 155)
1417:                 ENDWITH

*-- Linhas 1427 a 1435:
1427:                 .InputMask     = "999,999,999.99"
1428:                 .ControlSource = "cursor_4c_Produtos.ValAnt"
1429:                 WITH .Header1
1430:                     .Caption   = "Venda Ant."
1431:                     .FontName  = "Tahoma"
1432:                     .FontSize  = 8
1433:                     .Alignment = 2
1434:                     .ForeColor = RGB(36, 84, 155)
1435:                 ENDWITH

*-- Linhas 1445 a 1453:
1445:                 .InputMask     = "999,999,999.99"
1446:                 .ControlSource = "cursor_4c_Produtos.ValAtu"
1447:                 WITH .Header1
1448:                     .Caption   = "Venda Atual"
1449:                     .FontName  = "Tahoma"
1450:                     .FontSize  = 8
1451:                     .Alignment = 2
1452:                     .ForeColor = RGB(36, 84, 155)
1453:                 ENDWITH

*-- Linhas 1464 a 1472:
1464:                 .InputMask     = "999,999.99"
1465:                 .ControlSource = "cursor_4c_Produtos.PVarias"
1466:                 WITH .Header1
1467:                     .Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
1468:                     .FontName  = "Tahoma"
1469:                     .FontSize  = 8
1470:                     .Alignment = 2
1471:                     .ForeColor = RGB(36, 84, 155)
1472:                 ENDWITH

*-- Linhas 1483 a 1491:
1483:                 .InputMask     = "999,999,999.9999"
1484:                 .ControlSource = "cursor_4c_Produtos.CustoAfs"
1485:                 WITH .Header1
1486:                     .Caption   = "Custo Ant."
1487:                     .FontName  = "Tahoma"
1488:                     .FontSize  = 8
1489:                     .Alignment = 2
1490:                 ENDWITH
1491:             ENDWITH

*-- Linhas 1501 a 1509:
1501:                 .InputMask     = "999,999,999.9999"
1502:                 .ControlSource = "cursor_4c_Produtos.CustoFs"
1503:                 WITH .Header1
1504:                     .Caption   = "Custo Atual"
1505:                     .FontName  = "Tahoma"
1506:                     .FontSize  = 8
1507:                     .Alignment = 2
1508:                 ENDWITH
1509:             ENDWITH

*-- Linhas 1519 a 1527:
1519:                 .InputMask     = "999,999.99"
1520:                 .ControlSource = "cursor_4c_Produtos.CVarias"
1521:                 WITH .Header1
1522:                     .Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
1523:                     .FontName  = "Tahoma"
1524:                     .FontSize  = 8
1525:                     .Alignment = 2
1526:                 ENDWITH
1527:             ENDWITH

*-- Linhas 1605 a 1613:
1605:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1606:     *==========================================================================
1607:         THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1608:         THIS.cmd_4c_Imprimir.Enabled          = .F.
1609:     ENDPROC
1610: 
1611:     *==========================================================================
1612:     * ConfigurarPaginaLista - Reseta form OPERACIONAL ao estado inicial
1613:     * Form OPERACIONAL de layout plano: mapeia "Pagina Lista" para

*-- Linhas 1704 a 1712:
1704:                         SET ORDER TO CPros
1705:                         GO TOP
1706:                         THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1707:                         THIS.cmd_4c_Imprimir.Enabled          = .T.
1708:                         THIS.grd_4c_Produto.SetFocus()
1709:                     ELSE
1710:                         MsgAviso("Nenhum produto para exibir. Execute o processamento primeiro.")
1711:                         THIS.txt_4c_CFornecs.SetFocus()
1712:                     ENDIF

*-- Linhas 1861 a 1869:
1861:             *-- Se cursor ficou vazio, desabilita Atualizar/Imprimir
1862:             IF RECCOUNT("cursor_4c_Produtos") = 0
1863:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1864:                 THIS.cmd_4c_Imprimir.Enabled          = .F.
1865:                 THIS.img_4c_Produto.Visible           = .F.
1866:                 THIS.img_4c_Produto.Picture           = ""
1867:             ENDIF
1868: 
1869:             THIS.grd_4c_Produto.Refresh()

*-- Linhas 1901 a 1910:
1901:                 GO TOP
1902:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1903:                 THIS.cmg_4c_Botoes.Buttons(2).Refresh()
1904:                 THIS.cmd_4c_Imprimir.Enabled = .T.
1905:                 THIS.cmd_4c_Imprimir.Refresh()
1906:                 THIS.ReconfigurarGrade()
1907:                 THIS.grd_4c_Produto.Column1.SetFocus()
1908:                 THIS.grd_4c_Produto.Refresh()
1909:                 loc_lSucesso = .T.
1910:             ENDIF

*-- Linhas 1922 a 1930:
1922:             loc_lImpEtiq = MsgConfirma("Confirma a Impress" + CHR(227) + "o das Etiquetas?")
1923:             IF THIS.this_oBusinessObject.AtualizarPrecos(loc_lImpEtiq)
1924:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1925:                 THIS.cmd_4c_Imprimir.Enabled = .F.
1926:                 THIS.grd_4c_Produto.Refresh()
1927:             ENDIF
1928:         CATCH TO loc_oErro
1929:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnAtualizarClick")
1930:         ENDTRY

*-- Linhas 2895 a 2917:
2895:             THIS.txt_4c_Colf.Value       = ALLTRIM(.this_cColf)
2896:             THIS.txt_4c_Moedai.Value     = ALLTRIM(.this_cMoedai)
2897:             THIS.txt_4c_Moedaf.Value     = ALLTRIM(.this_cMoedaf)
2898:             THIS.opt_4c_TipoMoeda.Value  = .this_nOpcMoedaTp
2899:             THIS.txt_4c_Mrki.Value       = .this_nMrki
2900:             THIS.txt_4c_Mrkf.Value       = .this_nMrkf
2901:             THIS.txt_4c_EncI.Value       = .this_nEnci
2902:             THIS.txt_4c_EncF.Value       = .this_nEncf
2903:             THIS.txt_4c_Variacao.Value   = .this_nVariacao
2904:             THIS.txt_4c_Feitio.Value     = ALLTRIM(.this_cFeitio)
2905:             THIS.opt_4c_Situacao.Value   = .this_nOpcSituacao
2906:             THIS.opt_4c_Recalc.Value     = .this_nOpcRecalc
2907:             THIS.txt_4c_Reajuste.Value   = .this_nReajuste
2908:             THIS.txt_4c_Encargo.Value    = .this_nEncargo
2909:             THIS.txt_4c_NMrk.Value       = .this_nNMrk
2910:             THIS.opt_4c_Pven.Value       = .this_nOpcPven
2911:             THIS.txt_4c_NewMkp.Value     = ALLTRIM(.this_cNewMkp)
2912:             THIS.opt_4c_Compra.Value     = .this_nOpcCompra
2913:         ENDWITH
2914:         THIS.OptRecalcChange()
2915:         THIS.Refresh()
2916:     ENDPROC
2917: 

*-- Linhas 2987 a 2995:
2987:                 SET ORDER TO CPros
2988:                 GO TOP
2989:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
2990:                 THIS.cmd_4c_Imprimir.Enabled          = .T.
2991:                 THIS.ReconfigurarGrade()
2992:                 THIS.grd_4c_Produto.Refresh()
2993:                 loc_lSucesso = .T.
2994:             ENDIF
2995:         CATCH TO loc_oErro

