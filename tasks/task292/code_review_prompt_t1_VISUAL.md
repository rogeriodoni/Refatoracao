# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (15)
- [ALINHAMENTO] Botao 'cmd_4c_CancelaLin' tem Top=10 mas grupo usa Top=3 (diferenca de 7px)
- [ALINHAMENTO] Botao 'cmd_4c_CancelaDisp' tem Top=10 mas grupo usa Top=3 (diferenca de 7px)
- [ALINHAMENTO] Botao 'cmd_4c_CancelaDisp' tem Top=10 mas grupo usa Top=3 (diferenca de 7px)
- [ALINHAMENTO] Botao 'cmd_4c_CancelaDisp' tem Top=10 mas grupo usa Top=3 (diferenca de 7px)
- [FONTNAME-ERRADO] Linha 231: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 254: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 277: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 300: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 324: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 347: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 370: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 816: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 909: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1071: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1176: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2856 linhas total):

*-- Linhas 91 a 107:
91:                 ENDWITH
92: 
93:                 IF THIS.this_lReserva
94:                     THIS.Caption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
95:                 ELSE
96:                     THIS.Caption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
97:                 ENDIF
98: 
99:                 THIS.ConfigurarPageFrame()
100:                 THIS.ConfigurarCabecalho()
101:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
102:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
103: 
104:                 THIS.this_oBusinessObject.InicializarConexaoTemp()
105:                 THIS.this_oBusinessObject.CarregarParametros()
106:                 THIS.this_oBusinessObject.CarregarComposicao()
107:                 THIS.this_oBusinessObject.InicializarTmpSaldU()

*-- Linhas 118 a 132:
118:                 THIS.TornarControlesVisiveis()
119: 
120:                 *-- Estado inicial do botao Pedras
121:                 THIS.cmd_4c_Pedras.Enabled = .F.
122:                 IF USED("crSigCdPam")
123:                     SELECT crSigCdPam
124:                     IF !EMPTY(crSigCdPam.DopEmphs) AND !EMPTY(crSigCdPam.DopReqcs) AND ;
125:                        !EMPTY(crSigCdPam.DopPedcs) AND !EMPTY(crSigCdPam.DopComps) AND ;
126:                        !THIS.this_lReserva
127:                         THIS.cmd_4c_Pedras.Enabled = .T.
128:                     ENDIF
129:                 ENDIF
130: 
131:                 IF USED("TmpFinal")
132:                     SELECT TmpFinal

*-- Linhas 164 a 207:
164:     *==========================================================================
165:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
166:         WITH THIS.cnt_4c_Cabecalho
167:             .Top         = 0
168:             .Left        = 0
169:             .Width       = THIS.Width
170:             .Height      = 80
171:             .BackStyle   = 1
172:             .BackColor   = RGB(100, 100, 100)
173:             .BorderWidth = 0
174: 
175:             .AddObject("lbl_4c_Sombra", "Label")
176:             WITH .lbl_4c_Sombra
177:                 .AutoSize  = .F.
178:                 .Top       = 18
179:                 .Left      = 10
180:                 .Width     = THIS.Width
181:                 .Height    = 40
182:                 .FontBold  = .T.
183:                 .FontName  = "Tahoma"
184:                 .FontSize  = 18
185:                 .BackStyle = 0
186:                 .ForeColor = RGB(0, 0, 0)
187:                 .Caption   = " "
188:             ENDWITH
189: 
190:             .AddObject("lbl_4c_Titulo", "Label")
191:             WITH .lbl_4c_Titulo
192:                 .AutoSize  = .F.
193:                 .Top       = 17
194:                 .Left      = 10
195:                 .Width     = THIS.Width
196:                 .Height    = 46
197:                 .FontBold  = .T.
198:                 .FontName  = "Tahoma"
199:                 .FontSize  = 18
200:                 .BackStyle = 0
201:                 .ForeColor = RGB(255, 255, 255)
202:                 .Caption   = " "
203:             ENDWITH
204:         ENDWITH
205:     ENDPROC
206: 
207:     *==========================================================================

*-- Linhas 219 a 392:
219:         loc_cImgEstoque    = gc_4c_CaminhoIcones + "geral_estoque_60.jpg"
220: 
221:         *-- Botao Disponiveis (622,3,75,75)
222:         THIS.AddObject("cmd_4c_Disponivel", "CommandButton")
223:         WITH THIS.cmd_4c_Disponivel
224:             .Top         = 3
225:             .Left        = 622
226:             .Width       = 75
227:             .Height      = 75
228:             .Caption     = "\<Dispon" + CHR(237) + "veis"
229:             .FontBold    = .T.
230:             .FontItalic  = .T.
231:             .FontName    = "Comic Sans MS"
232:             .FontSize    = 8
233:             .WordWrap    = .T.
234:             .ForeColor   = RGB(90, 90, 90)
235:             .BackColor   = RGB(255, 255, 255)
236:             .Themes      = .T.
237:             IF FILE(loc_cImgDisp)
238:                 .Picture         = loc_cImgDisp
239:                 .DisabledPicture = loc_cImgDisp
240:             ENDIF
241:         ENDWITH
242:         BINDEVENT(THIS.cmd_4c_Disponivel, "Click", THIS, "BtnDisponiveiClick")
243: 
244:         *-- Botao Total/Linhas (697,3,75,75)
245:         THIS.AddObject("cmd_4c_TotLinha", "CommandButton")
246:         WITH THIS.cmd_4c_TotLinha
247:             .Top         = 3
248:             .Left        = 697
249:             .Width       = 75
250:             .Height      = 75
251:             .Caption     = "\<Total/Linhas"
252:             .FontBold    = .T.
253:             .FontItalic  = .T.
254:             .FontName    = "Comic Sans MS"
255:             .FontSize    = 8
256:             .WordWrap    = .T.
257:             .ForeColor   = RGB(90, 90, 90)
258:             .BackColor   = RGB(255, 255, 255)
259:             .Themes      = .T.
260:             IF FILE(loc_cImgLinhas)
261:                 .Picture         = loc_cImgLinhas
262:                 .DisabledPicture = loc_cImgLinhas
263:             ENDIF
264:         ENDWITH
265:         BINDEVENT(THIS.cmd_4c_TotLinha, "Click", THIS, "BtnTotLinhaClick")
266: 
267:         *-- Botao Pedras/Requisicoes (472,3,75,75)
268:         THIS.AddObject("cmd_4c_Pedras", "CommandButton")
269:         WITH THIS.cmd_4c_Pedras
270:             .Top         = 3
271:             .Left        = 472
272:             .Width       = 75
273:             .Height      = 75
274:             .Caption     = "\<Requisi" + CHR(231) + CHR(245) + "es"
275:             .FontBold    = .T.
276:             .FontItalic  = .T.
277:             .FontName    = "Comic Sans MS"
278:             .FontSize    = 8
279:             .WordWrap    = .T.
280:             .ForeColor   = RGB(90, 90, 90)
281:             .BackColor   = RGB(255, 255, 255)
282:             .Themes      = .T.
283:             IF FILE(loc_cImgPedras)
284:                 .Picture         = loc_cImgPedras
285:                 .DisabledPicture = loc_cImgPedras
286:             ENDIF
287:         ENDWITH
288:         BINDEVENT(THIS.cmd_4c_Pedras, "Click", THIS, "BtnPedrasClick")
289: 
290:         *-- Botao SelEstoque (547,3,75,75)
291:         THIS.AddObject("cmd_4c_SelEstoque", "CommandButton")
292:         WITH THIS.cmd_4c_SelEstoque
293:             .Top         = 3
294:             .Left        = 547
295:             .Width       = 75
296:             .Height      = 75
297:             .Caption     = "\<Estoques"
298:             .FontBold    = .T.
299:             .FontItalic  = .T.
300:             .FontName    = "Comic Sans MS"
301:             .FontSize    = 8
302:             .WordWrap    = .T.
303:             .ForeColor   = RGB(90, 90, 90)
304:             .BackColor   = RGB(255, 255, 255)
305:             .Themes      = .T.
306:             .Enabled     = .F.
307:             IF FILE(loc_cImgEstoque)
308:                 .Picture         = loc_cImgEstoque
309:                 .DisabledPicture = loc_cImgEstoque
310:             ENDIF
311:         ENDWITH
312:         BINDEVENT(THIS.cmd_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")
313: 
314:         *-- Botao Relatorio (772,3,75,75)
315:         THIS.AddObject("cmd_4c_BtnRelatorio", "CommandButton")
316:         WITH THIS.cmd_4c_BtnRelatorio
317:             .Top         = 3
318:             .Left        = 772
319:             .Width       = 75
320:             .Height      = 75
321:             .Caption     = "\<Relat" + CHR(243) + "rio"
322:             .FontBold    = .T.
323:             .FontItalic  = .T.
324:             .FontName    = "Comic Sans MS"
325:             .FontSize    = 8
326:             .WordWrap    = .T.
327:             .ForeColor   = RGB(90, 90, 90)
328:             .BackColor   = RGB(255, 255, 255)
329:             .Themes      = .T.
330:             IF FILE(loc_cImgRelatorio)
331:                 .Picture         = loc_cImgRelatorio
332:                 .DisabledPicture = loc_cImgRelatorio
333:             ENDIF
334:         ENDWITH
335:         BINDEVENT(THIS.cmd_4c_BtnRelatorio, "Click", THIS, "BtnRelatorioClick")
336: 
337:         *-- Botao Processar (847,3,75,75)
338:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
339:         WITH THIS.cmd_4c_Processar
340:             .Top         = 3
341:             .Left        = 847
342:             .Width       = 75
343:             .Height      = 75
344:             .Caption     = "\<Processar"
345:             .FontBold    = .T.
346:             .FontItalic  = .T.
347:             .FontName    = "Comic Sans MS"
348:             .FontSize    = 8
349:             .WordWrap    = .T.
350:             .ForeColor   = RGB(90, 90, 90)
351:             .BackColor   = RGB(255, 255, 255)
352:             .Themes      = .T.
353:             IF FILE(loc_cImgProcessar)
354:                 .Picture         = loc_cImgProcessar
355:                 .DisabledPicture = loc_cImgProcessar
356:             ENDIF
357:         ENDWITH
358:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
359: 
360:         *-- Botao Sair/Cancelar (922,3,75,75)
361:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
362:         WITH THIS.cmd_4c_Cancelar
363:             .Top         = 3
364:             .Left        = 922
365:             .Width       = 75
366:             .Height      = 75
367:             .Caption     = "Encerrar"
368:             .FontBold    = .T.
369:             .FontItalic  = .T.
370:             .FontName    = "Comic Sans MS"
371:             .FontSize    = 8
372:             .WordWrap    = .T.
373:             .ForeColor   = RGB(90, 90, 90)
374:             .BackColor   = RGB(255, 255, 255)
375:             .Themes      = .T.
376:             IF FILE(loc_cImgCancelar)
377:                 .Picture         = loc_cImgCancelar
378:                 .DisabledPicture = loc_cImgCancelar
379:             ENDIF
380:         ENDWITH
381:         BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
382: 
383:         *-- Grid principal GradeItens (Top=125, Left=11, Width=708, Height=224, 9 colunas)
384:         THIS.AddObject("grd_4c_Dados", "Grid")
385:         WITH THIS.grd_4c_Dados
386:             .Top              = 125
387:             .Left             = 11
388:             .Width            = 708
389:             .Height           = 224
390:             .ColumnCount      = 9
391:             .AllowHeaderSizing = .F.
392:             .AllowRowSizing    = .F.

*-- Linhas 403 a 471:
403:                 .ReadOnly       = .T.
404:                 .Movable        = .F.
405:                 .Resizable      = .F.
406:                 .Header1.Caption = "Produto"
407:                 .Header1.FontName = "Verdana"
408:                 .Header1.FontSize = 8
409:                 .Header1.Alignment = 2
410:                 .Header1.ForeColor = RGB(36, 84, 155)
411:             ENDWITH
412:             *-- Col2: Cor
413:             WITH .Column2
414:                 .Width          = 40
415:                 .ReadOnly       = .T.
416:                 .Movable        = .F.
417:                 .Resizable      = .F.
418:                 .Header1.Caption = "Cor"
419:                 .Header1.FontName = "Verdana"
420:                 .Header1.FontSize = 8
421:                 .Header1.Alignment = 2
422:                 .Header1.ForeColor = RGB(36, 84, 155)
423:             ENDWITH
424:             *-- Col3: Movimentacao (Dopes)
425:             WITH .Column3
426:                 .Width          = 80
427:                 .ReadOnly       = .T.
428:                 .Movable        = .F.
429:                 .Resizable      = .F.
430:                 .Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
431:                 .Header1.FontName = "Verdana"
432:                 .Header1.FontSize = 8
433:                 .Header1.Alignment = 2
434:                 .Header1.ForeColor = RGB(36, 84, 155)
435:             ENDWITH
436:             *-- Col4: Codigo (Numes)
437:             WITH .Column4
438:                 .Width          = 55
439:                 .ReadOnly       = .T.
440:                 .Movable        = .F.
441:                 .Resizable      = .F.
442:                 .Header1.Caption = "C" + CHR(243) + "digo"
443:                 .Header1.FontName = "Verdana"
444:                 .Header1.FontSize = 8
445:                 .Header1.Alignment = 2
446:                 .Header1.ForeColor = RGB(36, 84, 155)
447:             ENDWITH
448:             *-- Col5: Quantidade (Saldo)
449:             WITH .Column5
450:                 .Width          = 70
451:                 .ReadOnly       = .T.
452:                 .Movable        = .F.
453:                 .Resizable      = .F.
454:                 .Header1.Caption = "Quantidade"
455:                 .Header1.FontName = "Verdana"
456:                 .Header1.FontSize = 8
457:                 .Header1.Alignment = 2
458:                 .Header1.ForeColor = RGB(36, 84, 155)
459:             ENDWITH
460:             *-- Col6: Produzir (editavel)
461:             WITH .Column6
462:                 .Width          = 70
463:                 .ReadOnly       = .F.
464:                 .Movable        = .F.
465:                 .Resizable      = .F.
466:                 .Header1.Caption = "Produzir"
467:                 .Header1.FontName = "Verdana"
468:                 .Header1.FontSize = 8
469:                 .Header1.FontBold = .T.
470:                 .Header1.Alignment = 2
471:                 .Header1.ForeColor = RGB(36, 84, 155)

*-- Linhas 479 a 511:
479:                 .ReadOnly       = .T.
480:                 .Movable        = .F.
481:                 .Resizable      = .F.
482:                 .Header1.Caption = "Estoque"
483:                 .Header1.FontName = "Verdana"
484:                 .Header1.FontSize = 8
485:                 .Header1.Alignment = 2
486:                 .Header1.ForeColor = RGB(36, 84, 155)
487:             ENDWITH
488:             *-- Col8: Obs
489:             WITH .Column8
490:                 .Width          = 30
491:                 .ReadOnly       = .T.
492:                 .Movable        = .F.
493:                 .Resizable      = .F.
494:                 .Header1.Caption = "Obs"
495:                 .Header1.FontName = "Verdana"
496:                 .Header1.FontSize = 8
497:                 .Header1.Alignment = 2
498:                 .Header1.ForeColor = RGB(36, 84, 155)
499:             ENDWITH
500:             *-- Col9: Tam
501:             WITH .Column9
502:                 .Width          = 30
503:                 .ReadOnly       = .T.
504:                 .Movable        = .F.
505:                 .Resizable      = .F.
506:                 .Header1.Caption = "Tam"
507:                 .Header1.FontName = "Verdana"
508:                 .Header1.FontSize = 8
509:                 .Header1.Alignment = 2
510:                 .Header1.ForeColor = RGB(36, 84, 155)
511:             ENDWITH

*-- Linhas 526 a 637:
526:         *-- Totais abaixo do grid (349,417-662)
527:         THIS.AddObject("txt_4c_Tot_Qtd", "TextBox")
528:         WITH THIS.txt_4c_Tot_Qtd
529:             .Top          = 349
530:             .Left         = 417
531:             .Width        = 80
532:             .Height       = 23
533:             .ReadOnly     = .T.
534:             .FontName     = "Tahoma"
535:             .FontSize     = 8
536:             .SpecialEffect = 1
537:             .Value        = 0
538:         ENDWITH
539: 
540:         THIS.AddObject("txt_4c_Tot_Est", "TextBox")
541:         WITH THIS.txt_4c_Tot_Est
542:             .Top          = 349
543:             .Left         = 498
544:             .Width        = 81
545:             .Height       = 23
546:             .ReadOnly     = .T.
547:             .FontName     = "Tahoma"
548:             .FontSize     = 8
549:             .SpecialEffect = 1
550:             .Value        = 0
551:         ENDWITH
552: 
553:         THIS.AddObject("txt_4c_Tot_Prz", "TextBox")
554:         WITH THIS.txt_4c_Tot_Prz
555:             .Top          = 349
556:             .Left         = 580
557:             .Width        = 82
558:             .Height       = 23
559:             .ReadOnly     = .T.
560:             .FontName     = "Tahoma"
561:             .FontSize     = 8
562:             .SpecialEffect = 1
563:             .Value        = 0
564:         ENDWITH
565: 
566:         *-- Label para observacao (726,369)
567:         THIS.AddObject("lbl_4c_Txt_ObsItens", "Label")
568:         WITH THIS.lbl_4c_Txt_ObsItens
569:             .Top       = 369
570:             .Left      = 726
571:             .Width     = 134
572:             .Height    = 15
573:             .AutoSize  = .F.
574:             .BackStyle = 0
575:             .FontName  = "Tahoma"
576:             .FontSize  = 8
577:             .ForeColor = RGB(90, 90, 90)
578:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item"
579:         ENDWITH
580: 
581:         *-- EditBox observacoes (732,361,266,205)
582:         THIS.AddObject("obj_4c_ObsItens", "EditBox")
583:         WITH THIS.obj_4c_ObsItens
584:             .Top       = 361
585:             .Left      = 732
586:             .Width     = 266
587:             .Height    = 205
588:             .ReadOnly  = .T.
589:             .FontName  = "Tahoma"
590:             .FontSize  = 8
591:         ENDWITH
592: 
593:         *-- Imagem produto (726,125,266,204)
594:         THIS.AddObject("img_4c_ImgFigJpg", "Image")
595:         WITH THIS.img_4c_ImgFigJpg
596:             .Top     = 125
597:             .Left    = 726
598:             .Width   = 266
599:             .Height  = 204
600:             .Visible = .F.
601:         ENDWITH
602: 
603:         *-- Container3: saldo/estoque (sempre visivel, Top=373, Left=12, Width=708, Height=205)
604:         THIS.AddObject("cnt_4c_Container3", "Container")
605:         WITH THIS.cnt_4c_Container3
606:             .Top           = 373
607:             .Left          = 12
608:             .Width         = 708
609:             .Height        = 205
610:             .BackColor     = RGB(255, 255, 255)
611:             .SpecialEffect = 0
612:             .BorderWidth   = 1
613: 
614:             .AddObject("lbl_4c_Label1", "Label")
615:             WITH .lbl_4c_Label1
616:                 .Top       = 5
617:                 .Left      = 6
618:                 .Width     = 118
619:                 .Height    = 16
620:                 .AutoSize  = .F.
621:                 .BackStyle = 0
622:                 .FontBold  = .T.
623:                 .FontName  = "Tahoma"
624:                 .FontSize  = 8
625:                 .ForeColor = RGB(90, 90, 90)
626:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
627:             ENDWITH
628: 
629:             .AddObject("grd_4c_Dados", "Grid")
630:             WITH .grd_4c_Dados
631:                 .Top              = 24
632:                 .Left             = 6
633:                 .Width            = 444
634:                 .Height           = 148
635:                 .ColumnCount      = 6
636:                 .AllowHeaderSizing = .F.
637:                 .AllowRowSizing    = .F.

*-- Linhas 644 a 831:
644:                 WITH .Column1
645:                     .Width = 70
646:                     .ReadOnly = .T.
647:                     .Header1.Caption = "Grupo"
648:                     .Header1.FontName = "Verdana"
649:                     .Header1.FontSize = 8
650:                     .Header1.ForeColor = RGB(36, 84, 155)
651:                 ENDWITH
652:                 WITH .Column2
653:                     .Width = 70
654:                     .ReadOnly = .T.
655:                     .Header1.Caption = "Conta"
656:                     .Header1.FontName = "Verdana"
657:                     .Header1.FontSize = 8
658:                     .Header1.ForeColor = RGB(36, 84, 155)
659:                 ENDWITH
660:                 WITH .Column3
661:                     .Width = 60
662:                     .ReadOnly = .T.
663:                     .Header1.Caption = "Atual"
664:                     .Header1.FontName = "Verdana"
665:                     .Header1.FontSize = 8
666:                     .Header1.ForeColor = RGB(36, 84, 155)
667:                 ENDWITH
668:                 WITH .Column4
669:                     .Width = 60
670:                     .ReadOnly = .T.
671:                     .Header1.Caption = "Utilizado"
672:                     .Header1.FontName = "Verdana"
673:                     .Header1.FontSize = 8
674:                     .Header1.ForeColor = RGB(36, 84, 155)
675:                 ENDWITH
676:                 WITH .Column5
677:                     .Width = 60
678:                     .ReadOnly = .T.
679:                     .Header1.Caption = "Dispon" + CHR(237) + "vel"
680:                     .Header1.FontName = "Verdana"
681:                     .Header1.FontSize = 8
682:                     .Header1.ForeColor = RGB(36, 84, 155)
683:                 ENDWITH
684:                 WITH .Column6
685:                     .Width = 50
686:                     .ReadOnly = .T.
687:                     .Header1.Caption = "Emp"
688:                     .Header1.FontName = "Verdana"
689:                     .Header1.FontSize = 8
690:                     .Header1.ForeColor = RGB(36, 84, 155)
691:                 ENDWITH
692:             ENDWITH
693: 
694:             .AddObject("txt_4c__dgrupo", "TextBox")
695:             WITH .txt_4c__dgrupo
696:                 .Top          = 106
697:                 .Left         = 454
698:                 .Width        = 247
699:                 .Height       = 23
700:                 .ReadOnly     = .T.
701:                 .SpecialEffect = 1
702:                 .FontSize     = 8
703:             ENDWITH
704: 
705:             .AddObject("txt_4c__dconta", "TextBox")
706:             WITH .txt_4c__dconta
707:                 .Top          = 147
708:                 .Left         = 454
709:                 .Width        = 247
710:                 .Height       = 23
711:                 .ReadOnly     = .T.
712:                 .SpecialEffect = 1
713:                 .FontSize     = 8
714:             ENDWITH
715: 
716:             .AddObject("txt_4c_Tot_Qtd", "TextBox")
717:             WITH .txt_4c_Tot_Qtd
718:                 .Top          = 173
719:                 .Left         = 188
720:                 .Width        = 80
721:                 .Height       = 23
722:                 .ReadOnly     = .T.
723:                 .SpecialEffect = 1
724:                 .FontSize     = 8
725:                 .Value        = 0
726:             ENDWITH
727: 
728:             .AddObject("txt_4c_Tot_Est", "TextBox")
729:             WITH .txt_4c_Tot_Est
730:                 .Top          = 173
731:                 .Left         = 269
732:                 .Width        = 80
733:                 .Height       = 23
734:                 .ReadOnly     = .T.
735:                 .SpecialEffect = 1
736:                 .FontSize     = 8
737:                 .Value        = 0
738:             ENDWITH
739: 
740:             .AddObject("txt_4c_Tot_Prz", "TextBox")
741:             WITH .txt_4c_Tot_Prz
742:                 .Top          = 173
743:                 .Left         = 350
744:                 .Width        = 80
745:                 .Height       = 23
746:                 .ReadOnly     = .T.
747:                 .SpecialEffect = 1
748:                 .FontSize     = 8
749:                 .Value        = 0
750:             ENDWITH
751: 
752:             .AddObject("lbl_4c_Label2", "Label")
753:             WITH .lbl_4c_Label2
754:                 .Top = 90
755:                 .Left = 454
756:                 .Width = 36
757:                 .Height = 15
758:                 .AutoSize = .F.
759:                 .BackStyle = 0
760:                 .Caption = "Grupo"
761:                 .FontSize = 8
762:                 .ForeColor = RGB(90, 90, 90)
763:             ENDWITH
764: 
765:             .AddObject("lbl_4c_Label3", "Label")
766:             WITH .lbl_4c_Label3
767:                 .Top = 131
768:                 .Left = 454
769:                 .Width = 35
770:                 .Height = 15
771:                 .AutoSize = .F.
772:                 .BackStyle = 0
773:                 .Caption = "Conta"
774:                 .FontSize = 8
775:                 .ForeColor = RGB(90, 90, 90)
776:             ENDWITH
777:         ENDWITH
778:         BINDEVENT(THIS.cnt_4c_Container3.grd_4c_Dados, "AfterRowColChange", THIS, "Cnt3GradeAfterRowColChange")
779: 
780:         *-- Container1: totais por linha (Visible=.F., sobreposicao)
781:         THIS.AddObject("cnt_4c_Container1", "Container")
782:         WITH THIS.cnt_4c_Container1
783:             .Top           = 125
784:             .Left          = 12
785:             .Width         = 708
786:             .Height        = 465
787:             .BackColor     = RGB(255, 255, 255)
788:             .BackStyle     = 1
789:             .SpecialEffect = 0
790:             .Visible       = .F.
791: 
792:             .AddObject("lbl_4c_Label1", "Label")
793:             WITH .lbl_4c_Label1
794:                 .Top = 10
795:                 .Left = 259
796:                 .Width = 170
797:                 .Height = 18
798:                 .AutoSize = .F.
799:                 .BackStyle = 0
800:                 .FontBold = .T.
801:                 .FontName = "Tahoma"
802:                 .FontSize = 10
803:                 .ForeColor = RGB(90, 90, 90)
804:                 .Caption = "Pe" + CHR(231) + "as a produzir por linha"
805:             ENDWITH
806: 
807:             .AddObject("cmd_4c_CancelaLin", "CommandButton")
808:             WITH .cmd_4c_CancelaLin
809:                 .Top = 10
810:                 .Left = 620
811:                 .Width = 75
812:                 .Height = 75
813:                 .Caption = "OK"
814:                 .FontBold = .T.
815:                 .FontItalic = .T.
816:                 .FontName = "Comic Sans MS"
817:                 .FontSize = 8
818:                 .ForeColor = RGB(90, 90, 90)
819:                 .BackColor = RGB(255, 255, 255)
820:                 .Themes = .F.
821:             ENDWITH
822: 
823:             .AddObject("grd_4c_Dados", "Grid")
824:             WITH .grd_4c_Dados
825:                 .Top = 32
826:                 .Left = 174
827:                 .Width = 359
828:                 .Height = 420
829:                 .ColumnCount = 4
830:                 .AllowHeaderSizing = .F.
831:                 .AllowRowSizing = .F.

*-- Linhas 837 a 924:
837:                 WITH .Column1
838:                     .Width = 80
839:                     .ReadOnly = .T.
840:                     .Header1.Caption = "Linha"
841:                     .Header1.FontName = "Verdana"
842:                     .Header1.FontSize = 8
843:                     .Header1.ForeColor = RGB(36, 84, 155)
844:                 ENDWITH
845:                 WITH .Column2
846:                     .Width = 80
847:                     .ReadOnly = .T.
848:                     .Header1.Caption = "Quantidade"
849:                     .Header1.FontName = "Verdana"
850:                     .Header1.FontSize = 8
851:                     .Header1.ForeColor = RGB(36, 84, 155)
852:                 ENDWITH
853:                 WITH .Column3
854:                     .Width = 80
855:                     .ReadOnly = .T.
856:                     .Header1.Caption = "Estoque"
857:                     .Header1.FontName = "Verdana"
858:                     .Header1.FontSize = 8
859:                     .Header1.ForeColor = RGB(36, 84, 155)
860:                 ENDWITH
861:                 WITH .Column4
862:                     .Width = 80
863:                     .ReadOnly = .T.
864:                     .Header1.Caption = "Produzir"
865:                     .Header1.FontName = "Verdana"
866:                     .Header1.FontSize = 8
867:                     .Header1.ForeColor = RGB(36, 84, 155)
868:                 ENDWITH
869:             ENDWITH
870:         ENDWITH
871:         BINDEVENT(THIS.cnt_4c_Container1.cmd_4c_CancelaLin, "Click", THIS, "BtnCancelaLin1Click")
872: 
873:         *-- Container2: disponivel por produto/cor/tam (Visible=.F.)
874:         THIS.AddObject("cnt_4c_Container2", "Container")
875:         WITH THIS.cnt_4c_Container2
876:             .Top = 125
877:             .Left = 12
878:             .Width = 708
879:             .Height = 465
880:             .BackColor = RGB(255, 255, 255)
881:             .BackStyle = 1
882:             .SpecialEffect = 0
883:             .Visible = .F.
884: 
885:             .AddObject("lbl_4c_Label1", "Label")
886:             WITH .lbl_4c_Label1
887:                 .Top = 10
888:                 .Left = 284
889:                 .Width = 123
890:                 .Height = 18
891:                 .AutoSize = .F.
892:                 .BackStyle = 0
893:                 .FontBold = .T.
894:                 .FontName = "Tahoma"
895:                 .FontSize = 10
896:                 .ForeColor = RGB(90, 90, 90)
897:                 .Caption = "Estoque Dispon" + CHR(237) + "vel"
898:             ENDWITH
899: 
900:             .AddObject("cmd_4c_CancelaDisp", "CommandButton")
901:             WITH .cmd_4c_CancelaDisp
902:                 .Top = 10
903:                 .Left = 620
904:                 .Width = 75
905:                 .Height = 75
906:                 .Caption = "Sair"
907:                 .FontBold = .T.
908:                 .FontItalic = .T.
909:                 .FontName = "Comic Sans MS"
910:                 .FontSize = 8
911:                 .ForeColor = RGB(90, 90, 90)
912:                 .BackColor = RGB(255, 255, 255)
913:                 .Themes = .F.
914:             ENDWITH
915: 
916:             .AddObject("grd_4c_Dados", "Grid")
917:             WITH .grd_4c_Dados
918:                 .Top = 32
919:                 .Left = 169
920:                 .Width = 370
921:                 .Height = 388
922:                 .ColumnCount = 5
923:                 .AllowHeaderSizing = .F.
924:                 .AllowRowSizing = .F.

*-- Linhas 930 a 1086:
930:                 WITH .Column1
931:                     .Width = 80
932:                     .ReadOnly = .T.
933:                     .Header1.Caption = "Produto"
934:                     .Header1.FontName = "Verdana"
935:                     .Header1.FontSize = 8
936:                     .Header1.ForeColor = RGB(36, 84, 155)
937:                 ENDWITH
938:                 WITH .Column2
939:                     .Width = 38
940:                     .ReadOnly = .T.
941:                     .Header1.Caption = "Cor"
942:                     .Header1.FontName = "Verdana"
943:                     .Header1.FontSize = 8
944:                     .Header1.ForeColor = RGB(36, 84, 155)
945:                 ENDWITH
946:                 WITH .Column3
947:                     .Width = 24
948:                     .ReadOnly = .T.
949:                     .Header1.Caption = "Tam"
950:                     .Header1.FontName = "Verdana"
951:                     .Header1.FontSize = 8
952:                     .Header1.ForeColor = RGB(36, 84, 155)
953:                 ENDWITH
954:                 WITH .Column4
955:                     .Width = 75
956:                     .ReadOnly = .T.
957:                     .Header1.Caption = "Disponivel"
958:                     .Header1.FontName = "Verdana"
959:                     .Header1.FontSize = 8
960:                     .Header1.ForeColor = RGB(36, 84, 155)
961:                 ENDWITH
962:                 WITH .Column5
963:                     .Width = 75
964:                     .ReadOnly = .F.
965:                     .Header1.Caption = "Utilizar"
966:                     .Header1.FontName = "Verdana"
967:                     .Header1.FontBold = .T.
968:                     .Header1.FontSize = 8
969:                     .Header1.ForeColor = RGB(36, 84, 155)
970:                     .Text1.FontBold = .T.
971:                     .Text1.BorderStyle = 0
972:                     .Text1.Alignment = 3
973:                     .Text1.Value = 0
974:                 ENDWITH
975:             ENDWITH
976:             BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt2Col5TextValid")
977: 
978:             .AddObject("lbl_4c_Label2", "Label")
979:             WITH .lbl_4c_Label2
980:                 .Top = 432
981:                 .Left = 168
982:                 .Width = 84
983:                 .Height = 15
984:                 .AutoSize = .F.
985:                 .BackStyle = 0
986:                 .FontSize = 8
987:                 .ForeColor = RGB(90, 90, 90)
988:                 .Caption = "Qtde " + CHR(224) + " Produzir :"
989:             ENDWITH
990: 
991:             .AddObject("lbl_4c_Label3", "Label")
992:             WITH .lbl_4c_Label3
993:                 .Top = 431
994:                 .Left = 365
995:                 .Width = 109
996:                 .Height = 17
997:                 .AutoSize = .F.
998:                 .BackStyle = 0
999:                 .FontSize = 8
1000:                 .ForeColor = RGB(90, 90, 90)
1001:                 .Caption = "Qtde " + CHR(224) + " Utilizar :"
1002:             ENDWITH
1003: 
1004:             .AddObject("txt_4c_Qt_pedida", "TextBox")
1005:             WITH .txt_4c_Qt_pedida
1006:                 .Top = 428
1007:                 .Left = 268
1008:                 .Width = 80
1009:                 .Height = 23
1010:                 .ReadOnly = .T.
1011:                 .SpecialEffect = 1
1012:                 .FontSize = 8
1013:                 .Value = 0
1014:             ENDWITH
1015: 
1016:             .AddObject("txt_4c_Qt_Selec", "TextBox")
1017:             WITH .txt_4c_Qt_Selec
1018:                 .Top = 428
1019:                 .Left = 458
1020:                 .Width = 80
1021:                 .Height = 23
1022:                 .ReadOnly = .T.
1023:                 .SpecialEffect = 1
1024:                 .FontSize = 8
1025:                 .Value = 0
1026:             ENDWITH
1027:         ENDWITH
1028:         BINDEVENT(THIS.cnt_4c_Container2.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp2Click")
1029:         *-- Redirecionar foco das colunas somente-leitura para Column5 (QtdDisp editavel)
1030:         BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
1031:         BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
1032:         BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column3.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
1033:         BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column4.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
1034: 
1035:         *-- Container4: pedras/requisicoes adicionais (Visible=.F.)
1036:         THIS.AddObject("cnt_4c_Container4", "Container")
1037:         WITH THIS.cnt_4c_Container4
1038:             .Top = 125
1039:             .Left = 12
1040:             .Width = 708
1041:             .Height = 465
1042:             .BackColor = RGB(255, 255, 255)
1043:             .BackStyle = 1
1044:             .SpecialEffect = 0
1045:             .Visible = .F.
1046: 
1047:             .AddObject("lbl_4c_Label1", "Label")
1048:             WITH .lbl_4c_Label1
1049:                 .Top = 8
1050:                 .Left = 229
1051:                 .Width = 249
1052:                 .Height = 18
1053:                 .AutoSize = .F.
1054:                 .BackStyle = 0
1055:                 .FontBold = .T.
1056:                 .FontName = "Tahoma"
1057:                 .FontSize = 10
1058:                 .ForeColor = RGB(90, 90, 90)
1059:                 .Caption = "Requisi" + CHR(231) + CHR(227) + "o de componentes adicionais"
1060:             ENDWITH
1061: 
1062:             .AddObject("cmd_4c_CancelaDisp", "CommandButton")
1063:             WITH .cmd_4c_CancelaDisp
1064:                 .Top = 10
1065:                 .Left = 620
1066:                 .Width = 75
1067:                 .Height = 75
1068:                 .Caption = "Sair"
1069:                 .FontBold = .T.
1070:                 .FontItalic = .T.
1071:                 .FontName = "Comic Sans MS"
1072:                 .FontSize = 8
1073:                 .ForeColor = RGB(90, 90, 90)
1074:                 .BackColor = RGB(255, 255, 255)
1075:                 .Themes = .F.
1076:             ENDWITH
1077: 
1078:             .AddObject("grd_4c_Dados", "Grid")
1079:             WITH .grd_4c_Dados
1080:                 .Top = 32
1081:                 .Left = 9
1082:                 .Width = 605
1083:                 .Height = 420
1084:                 .ColumnCount = 5
1085:                 .AllowHeaderSizing = .F.
1086:                 .AllowRowSizing = .F.

*-- Linhas 1092 a 1191:
1092:                 WITH .Column1
1093:                     .Width = 80
1094:                     .ReadOnly = .F.
1095:                     .Header1.Caption = "Produto"
1096:                     .Header1.FontName = "Verdana"
1097:                     .Header1.FontSize = 8
1098:                     .Header1.ForeColor = RGB(36, 84, 155)
1099:                 ENDWITH
1100:                 WITH .Column2
1101:                     .Width = 200
1102:                     .ReadOnly = .T.
1103:                     .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1104:                     .Header1.FontName = "Verdana"
1105:                     .Header1.FontSize = 8
1106:                     .Header1.ForeColor = RGB(36, 84, 155)
1107:                 ENDWITH
1108:                 WITH .Column3
1109:                     .Width = 40
1110:                     .ReadOnly = .T.
1111:                     .Header1.Caption = "Uni"
1112:                     .Header1.FontName = "Verdana"
1113:                     .Header1.FontSize = 8
1114:                     .Header1.ForeColor = RGB(36, 84, 155)
1115:                 ENDWITH
1116:                 WITH .Column4
1117:                     .Width = 80
1118:                     .ReadOnly = .F.
1119:                     .Header1.Caption = "Qtde"
1120:                     .Header1.FontName = "Verdana"
1121:                     .Header1.FontSize = 8
1122:                     .Header1.ForeColor = RGB(36, 84, 155)
1123:                 ENDWITH
1124:                 WITH .Column5
1125:                     .Width = 80
1126:                     .ReadOnly = .F.
1127:                     .Header1.Caption = "Produto"
1128:                     .Header1.FontName = "Verdana"
1129:                     .Header1.FontSize = 8
1130:                     .Header1.ForeColor = RGB(36, 84, 155)
1131:                 ENDWITH
1132:             ENDWITH
1133:         ENDWITH
1134:         BINDEVENT(THIS.cnt_4c_Container4.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp4Click")
1135:         BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1, "Valid", THIS, "Cnt4Col1TextValid")
1136:         BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column4.Text1, "When",  THIS, "Cnt4Col4TextWhen")
1137:         BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1, "When",  THIS, "Cnt4Col5TextWhen")
1138:         BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt4Col5TextValid")
1139: 
1140:         *-- Container5: selecao de estoque por grupo/conta (Visible=.F.)
1141:         THIS.AddObject("cnt_4c_Container5", "Container")
1142:         WITH THIS.cnt_4c_Container5
1143:             .Top = 125
1144:             .Left = 12
1145:             .Width = 708
1146:             .Height = 465
1147:             .BackColor = RGB(255, 255, 255)
1148:             .BackStyle = 1
1149:             .SpecialEffect = 0
1150:             .Visible = .F.
1151: 
1152:             .AddObject("lbl_4c_Label1", "Label")
1153:             WITH .lbl_4c_Label1
1154:                 .Top = 10
1155:                 .Left = 284
1156:                 .Width = 123
1157:                 .Height = 18
1158:                 .AutoSize = .F.
1159:                 .BackStyle = 0
1160:                 .FontBold = .T.
1161:                 .FontName = "Tahoma"
1162:                 .FontSize = 10
1163:                 .ForeColor = RGB(90, 90, 90)
1164:                 .Caption = "Estoque Dispon" + CHR(237) + "vel"
1165:             ENDWITH
1166: 
1167:             .AddObject("cmd_4c_CancelaDisp", "CommandButton")
1168:             WITH .cmd_4c_CancelaDisp
1169:                 .Top = 10
1170:                 .Left = 620
1171:                 .Width = 75
1172:                 .Height = 75
1173:                 .Caption = "OK"
1174:                 .FontBold = .T.
1175:                 .FontItalic = .T.
1176:                 .FontName = "Comic Sans MS"
1177:                 .FontSize = 8
1178:                 .ForeColor = RGB(90, 90, 90)
1179:                 .BackColor = RGB(255, 255, 255)
1180:                 .Themes = .F.
1181:             ENDWITH
1182: 
1183:             .AddObject("grd_4c_Dados", "Grid")
1184:             WITH .grd_4c_Dados
1185:                 .Top = 32
1186:                 .Left = 141
1187:                 .Width = 425
1188:                 .Height = 372
1189:                 .ColumnCount = 5
1190:                 .AllowHeaderSizing = .F.
1191:                 .AllowRowSizing = .F.

*-- Linhas 1197 a 1237:
1197:                 WITH .Column1
1198:                     .Width = 80
1199:                     .ReadOnly = .T.
1200:                     .Header1.Caption = "Grupo"
1201:                     .Header1.FontName = "Verdana"
1202:                     .Header1.FontSize = 8
1203:                     .Header1.ForeColor = RGB(36, 84, 155)
1204:                 ENDWITH
1205:                 WITH .Column2
1206:                     .Width = 80
1207:                     .ReadOnly = .T.
1208:                     .Header1.Caption = "Conta"
1209:                     .Header1.FontName = "Verdana"
1210:                     .Header1.FontSize = 8
1211:                     .Header1.ForeColor = RGB(36, 84, 155)
1212:                 ENDWITH
1213:                 WITH .Column3
1214:                     .Width = 80
1215:                     .ReadOnly = .T.
1216:                     .Header1.Caption = "Prioridade"
1217:                     .Header1.FontName = "Verdana"
1218:                     .Header1.FontSize = 8
1219:                     .Header1.ForeColor = RGB(36, 84, 155)
1220:                 ENDWITH
1221:                 WITH .Column4
1222:                     .Width = 75
1223:                     .ReadOnly = .T.
1224:                     .Header1.Caption = "Dispon" + CHR(237) + "vel"
1225:                     .Header1.FontName = "Verdana"
1226:                     .Header1.FontSize = 8
1227:                     .Header1.ForeColor = RGB(36, 84, 155)
1228:                 ENDWITH
1229:                 WITH .Column5
1230:                     .Width = 75
1231:                     .ReadOnly = .F.
1232:                     .Header1.Caption = "Utilizar"
1233:                     .Header1.FontName = "Verdana"
1234:                     .Header1.FontBold = .T.
1235:                     .Header1.FontSize = 8
1236:                     .Header1.ForeColor = RGB(36, 84, 155)
1237:                     .Text1.FontBold = .T.

*-- Linhas 1243 a 1368:
1243:             BINDEVENT(THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt5Col5TextValid")
1244:             BINDEVENT(THIS.cnt_4c_Container5.grd_4c_Dados, "AfterRowColChange", THIS, "Cnt5GradeAfterRowColChange")
1245: 
1246:             .AddObject("lbl_4c_Label2", "Label")
1247:             WITH .lbl_4c_Label2
1248:                 .Top = 413
1249:                 .Left = 428
1250:                 .Width = 48
1251:                 .Height = 15
1252:                 .AutoSize = .F.
1253:                 .BackStyle = 0
1254:                 .FontSize = 8
1255:                 .ForeColor = RGB(90, 90, 90)
1256:                 .Caption = "Produzir :"
1257:             ENDWITH
1258: 
1259:             .AddObject("lbl_4c_Label3", "Label")
1260:             WITH .lbl_4c_Label3
1261:                 .Top = 438
1262:                 .Left = 435
1263:                 .Width = 41
1264:                 .Height = 15
1265:                 .AutoSize = .F.
1266:                 .BackStyle = 0
1267:                 .FontSize = 8
1268:                 .ForeColor = RGB(90, 90, 90)
1269:                 .Caption = "Utilizar :"
1270:             ENDWITH
1271: 
1272:             .AddObject("lbl_4c_Label4", "Label")
1273:             WITH .lbl_4c_Label4
1274:                 .Top = 413
1275:                 .Left = 93
1276:                 .Width = 38
1277:                 .Height = 15
1278:                 .AutoSize = .F.
1279:                 .BackStyle = 0
1280:                 .FontSize = 8
1281:                 .ForeColor = RGB(90, 90, 90)
1282:                 .Caption = "Grupo :"
1283:             ENDWITH
1284: 
1285:             .AddObject("lbl_4c_Label5", "Label")
1286:             WITH .lbl_4c_Label5
1287:                 .Top = 438
1288:                 .Left = 93
1289:                 .Width = 38
1290:                 .Height = 15
1291:                 .AutoSize = .F.
1292:                 .BackStyle = 0
1293:                 .FontSize = 8
1294:                 .ForeColor = RGB(90, 90, 90)
1295:                 .Caption = "Conta :"
1296:             ENDWITH
1297: 
1298:             .AddObject("txt_4c__dgrupo", "TextBox")
1299:             WITH .txt_4c__dgrupo
1300:                 .Top = 409
1301:                 .Left = 141
1302:                 .Width = 277
1303:                 .Height = 23
1304:                 .ReadOnly = .T.
1305:                 .SpecialEffect = 1
1306:                 .FontSize = 8
1307:             ENDWITH
1308: 
1309:             .AddObject("txt_4c__dconta", "TextBox")
1310:             WITH .txt_4c__dconta
1311:                 .Top = 434
1312:                 .Left = 141
1313:                 .Width = 277
1314:                 .Height = 23
1315:                 .ReadOnly = .T.
1316:                 .SpecialEffect = 1
1317:                 .FontSize = 8
1318:             ENDWITH
1319: 
1320:             .AddObject("txt_4c_Qt_pedida", "TextBox")
1321:             WITH .txt_4c_Qt_pedida
1322:                 .Top = 409
1323:                 .Left = 486
1324:                 .Width = 80
1325:                 .Height = 23
1326:                 .ReadOnly = .T.
1327:                 .SpecialEffect = 1
1328:                 .FontSize = 8
1329:                 .Value = 0
1330:             ENDWITH
1331: 
1332:             .AddObject("txt_4c_Qt_Selec", "TextBox")
1333:             WITH .txt_4c_Qt_Selec
1334:                 .Top = 434
1335:                 .Left = 486
1336:                 .Width = 80
1337:                 .Height = 23
1338:                 .ReadOnly = .T.
1339:                 .SpecialEffect = 1
1340:                 .FontSize = 8
1341:                 .Value = 0
1342:             ENDWITH
1343:         ENDWITH
1344:         BINDEVENT(THIS.cnt_4c_Container5.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp5Click")
1345: 
1346:         *-- Shape2: delineamento visual da area de data/info no topo (9,9,279,51)
1347:         THIS.AddObject("shp_4c_Shape2", "Shape")
1348:         WITH THIS.shp_4c_Shape2
1349:             .Top         = 9
1350:             .Left        = 9
1351:             .Width       = 279
1352:             .Height      = 51
1353:             .BackStyle   = 0
1354:             .BorderColor = RGB(255, 255, 255)
1355:             .BorderWidth = 2
1356:             .SpecialEffect = 0
1357:         ENDWITH
1358: 
1359:         *-- Shape3: delineamento visual da area de numero/referencia (820,10,116,38)
1360:         THIS.AddObject("shp_4c_Shape3", "Shape")
1361:         WITH THIS.shp_4c_Shape3
1362:             .Top         = 10
1363:             .Left        = 820
1364:             .Width       = 116
1365:             .Height      = 38
1366:             .BackStyle   = 0
1367:             .BorderColor = RGB(255, 255, 255)
1368:             .BorderWidth = 2

*-- Linhas 1405 a 1428:
1405:         ENDIF
1406: 
1407:         *-- Reabilitar botoes de acao principal
1408:         THIS.cmd_4c_Processar.Enabled  = .T.
1409:         THIS.cmd_4c_Cancelar.Enabled   = .T.
1410:         THIS.cmd_4c_TotLinha.Enabled   = .T.
1411:         THIS.cmd_4c_Disponivel.Enabled = .T.
1412:         THIS.cmd_4c_BtnRelatorio.Enabled = .T.
1413: 
1414:         *-- Botao Pedras/SelEstoque respeitam regra de negocio
1415:         loc_lPodeAcao = .F.
1416:         IF USED("crSigCdPam")
1417:             SELECT crSigCdPam
1418:             loc_lPodeAcao = !EMPTY(crSigCdPam.DopEmphs) AND !EMPTY(crSigCdPam.DopReqcs) AND ;
1419:                             !EMPTY(crSigCdPam.DopPedcs) AND !EMPTY(crSigCdPam.DopComps) AND ;
1420:                             !THIS.this_lReserva
1421:         ENDIF
1422:         THIS.cmd_4c_Pedras.Enabled     = loc_lPodeAcao
1423:         THIS.cmd_4c_SelEstoque.Enabled = loc_lPodeAcao
1424: 
1425:         *-- Focar grid principal na coluna editavel Produzir
1426:         IF THIS.grd_4c_Dados.Enabled
1427:             THIS.grd_4c_Dados.Refresh
1428:             THIS.grd_4c_Dados.Column6.SetFocus

*-- Linhas 1492 a 1500:
1492:         THIS.obj_4c_ObsItens.Refresh
1493: 
1494:         *-- Rotulo dinamico da observacao
1495:         THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ;
1496:                                             ALLTRIM(TratarNulo(TmpFinal.Cpros, "C"))
1497:     ENDPROC
1498: 
1499:     *==========================================================================
1500:     * AlternarPagina - Alterna entre a visao principal e os overlays

*-- Linhas 1688 a 1700:
1688:                         .Visible     = .T.
1689:                     ENDWITH
1690: 
1691:                     THIS.cmd_4c_Processar.Enabled  = .F.
1692:                     THIS.cmd_4c_Cancelar.Enabled   = .F.
1693:                     THIS.cmd_4c_TotLinha.Enabled   = .F.
1694:                     THIS.cmd_4c_Pedras.Enabled     = .F.
1695:                     THIS.cmd_4c_Disponivel.Enabled = .F.
1696:                     THIS.cnt_4c_Container3.Enabled = .F.
1697:                     THIS.cnt_4c_Container2.Visible = .T.
1698:                     THIS.cnt_4c_Container2.ZOrder
1699:                     THIS.cnt_4c_Container2.grd_4c_Dados.Refresh
1700:                     THIS.cnt_4c_Container2.grd_4c_Dados.Column5.SetFocus

*-- Linhas 1732 a 1744:
1732:                 .SetAll("DynamicForeColor", "IIF(TmpLinha.Linhas = [TOTAIS], RGB(0,0,255), RGB(0,0,0))", "Column")
1733:             ENDWITH
1734: 
1735:             THIS.cmd_4c_Processar.Enabled  = .F.
1736:             THIS.cmd_4c_Cancelar.Enabled   = .F.
1737:             THIS.cmd_4c_TotLinha.Enabled   = .F.
1738:             THIS.cmd_4c_Pedras.Enabled     = .F.
1739:             THIS.cmd_4c_Disponivel.Enabled = .F.
1740:             THIS.grd_4c_Dados.Enabled      = .F.
1741:             THIS.cnt_4c_Container3.Enabled = .F.
1742:             THIS.cnt_4c_Container1.Visible = .T.
1743:             THIS.cnt_4c_Container1.ZOrder
1744:             THIS.cnt_4c_Container1.grd_4c_Dados.Refresh

*-- Linhas 1763 a 1775:
1763:                 .Column5.ControlSource = "SelPedra.Cpro2s"
1764:             ENDWITH
1765: 
1766:             THIS.cmd_4c_Processar.Enabled  = .F.
1767:             THIS.cmd_4c_Cancelar.Enabled   = .F.
1768:             THIS.cmd_4c_TotLinha.Enabled   = .F.
1769:             THIS.cmd_4c_Pedras.Enabled     = .F.
1770:             THIS.cmd_4c_Disponivel.Enabled = .F.
1771:             THIS.grd_4c_Dados.Enabled      = .F.
1772:             THIS.cnt_4c_Container3.Enabled = .F.
1773:             THIS.cnt_4c_Container4.Visible = .T.
1774:             THIS.cnt_4c_Container4.ZOrder
1775:             THIS.cnt_4c_Container4.grd_4c_Dados.Refresh

*-- Linhas 1818 a 1839:
1818:                     ENDWITH
1819: 
1820:                     WITH THIS.cnt_4c_Container5
1821:                         .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel (" + ;
1822:                                                  ALLTRIM(loc_cCpro) + " " + ALLTRIM(loc_cCor) + ;
1823:                                                  "/" + ALLTRIM(loc_cTam) + ")"
1824:                         .txt_4c_Qt_pedida.Value = TmpFinal.Saldo - TmpFinal.Estoque
1825:                         .txt_4c_Qt_Selec.Value  = 0
1826:                         .Visible     = .T.
1827:                     ENDWITH
1828: 
1829:                     THIS.cmd_4c_Processar.Enabled  = .F.
1830:                     THIS.cmd_4c_Cancelar.Enabled   = .F.
1831:                     THIS.cmd_4c_TotLinha.Enabled   = .F.
1832:                     THIS.cmd_4c_Disponivel.Enabled = .F.
1833:                     THIS.cmd_4c_SelEstoque.Enabled = .F.
1834:                     THIS.cmd_4c_Pedras.Enabled     = .F.
1835:                     THIS.cnt_4c_Container3.Enabled = .F.
1836:                     THIS.cnt_4c_Container5.Visible = .T.
1837:                     THIS.cnt_4c_Container5.ZOrder
1838:                     THIS.cnt_4c_Container5.grd_4c_Dados.Refresh
1839:                     THIS.cnt_4c_Container5.grd_4c_Dados.Column5.SetFocus

*-- Linhas 1912 a 1924:
1912: 
1913:     PROCEDURE BtnCancelaLin1Click
1914:         WITH THIS
1915:             .cmd_4c_Processar.Enabled  = .T.
1916:             .cmd_4c_Cancelar.Enabled   = .T.
1917:             .cmd_4c_Pedras.Enabled     = .T.
1918:             .cmd_4c_TotLinha.Enabled   = .T.
1919:             .cmd_4c_Disponivel.Enabled = .T.
1920:             .cnt_4c_Container1.Visible = .F.
1921:             .cnt_4c_Container3.Enabled = .T.
1922:             .grd_4c_Dados.Enabled      = .T.
1923:             .grd_4c_Dados.ZOrder
1924:             .grd_4c_Dados.Refresh

*-- Linhas 1972 a 2001:
1972:         ENDTRY
1973: 
1974:         WITH THIS
1975:             .cmd_4c_Processar.Enabled  = .T.
1976:             .cmd_4c_Cancelar.Enabled   = .T.
1977:             .cmd_4c_TotLinha.Enabled   = .T.
1978:             .cmd_4c_SelEstoque.Enabled = .T.
1979:             .cmd_4c_Pedras.Enabled     = .T.
1980:             .cmd_4c_Disponivel.Enabled = .T.
1981:             .cnt_4c_Container3.Enabled = .T.
1982:             .cnt_4c_Container2.Visible = .F.
1983:             .grd_4c_Dados.Enabled      = .T.
1984:             .grd_4c_Dados.ZOrder
1985:             .grd_4c_Dados.Refresh
1986:             .grd_4c_Dados.Column6.SetFocus
1987:         ENDWITH
1988:     ENDPROC
1989: 
1990:     PROCEDURE BtnCancelaDisp4Click
1991:         WITH THIS
1992:             .cmd_4c_Processar.Enabled  = .T.
1993:             .cmd_4c_Cancelar.Enabled   = .T.
1994:             .cmd_4c_TotLinha.Enabled   = .T.
1995:             .cmd_4c_Pedras.Enabled     = .T.
1996:             .cmd_4c_Disponivel.Enabled = .T.
1997:             .cnt_4c_Container3.Enabled = .T.
1998:             .cnt_4c_Container4.Visible = .F.
1999:             .grd_4c_Dados.Enabled      = .T.
2000:             .grd_4c_Dados.ZOrder
2001:             .grd_4c_Dados.Refresh

*-- Linhas 2047 a 2060:
2047:         ENDTRY
2048: 
2049:         WITH THIS
2050:             .cmd_4c_Processar.Enabled  = .T.
2051:             .cmd_4c_Cancelar.Enabled   = .T.
2052:             .cmd_4c_TotLinha.Enabled   = .T.
2053:             .cmd_4c_Disponivel.Enabled = .T.
2054:             .cmd_4c_SelEstoque.Enabled = .T.
2055:             .cmd_4c_Pedras.Enabled     = .T.
2056:             .cnt_4c_Container3.Enabled = .T.
2057:             .cnt_4c_Container5.Visible = .F.
2058:             .grd_4c_Dados.Enabled      = .T.
2059:             .grd_4c_Dados.ZOrder
2060:             .grd_4c_Dados.Refresh

*-- Linhas 2076 a 2084:
2076:             ENDIF
2077: 
2078:             THIS.obj_4c_ObsItens.Refresh
2079:             THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ALLTRIM(TmpFinal.CPros)
2080: 
2081:             =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2082: 
2083:             SELECT TmpSaldG
2084:             SET ORDER TO Cpros

*-- Linhas 2092 a 2100:
2092:                     .txt_4c_Tot_Prz.Value = TmpSaldo.Disps
2093:                 ENDIF
2094: 
2095:                 .lbl_4c_Label1.Caption = ALLTRIM(TmpFinal.Cpros) + ;
2096:                     IIF(!EMPTY(TmpFinal.CodCors), " Cor:" + TmpFinal.CodCors, "") + ;
2097:                     IIF(!EMPTY(TmpFinal.CodTams), " Tam:" + TmpFinal.CodTams, "")
2098: 
2099:                 .grd_4c_Dados.Refresh
2100:                 .Visible     = .T.

*-- Linhas 2146 a 2154:
2146:                                    ALLTRIM(xTempPro.CGrus) + "'"
2147:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempGru") > 0
2148:                             IF INLIST(xTempGru.TipoEstos, 3, 4)
2149:                                 THIS.cmd_4c_Disponivel.Enabled = .T.
2150:                             ENDIF
2151:                             IF USED("xTempGru")
2152:                                 USE IN xTempGru
2153:                             ENDIF
2154:                         ENDIF

*-- Linhas 2800 a 2809:
2800:             ENDIF
2801: 
2802:             *-- Limpar label de observacao
2803:             IF VARTYPE(THIS.lbl_4c_Txt_ObsItens) = "O"
2804:                 THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item"
2805:             ENDIF
2806: 
2807:             *-- Ocultar overlays flutuantes
2808:             THIS.ConfigurarPaginaLista()
2809:         CATCH TO loc_oErro

*-- Linhas 2841 a 2855:
2841:             ENDIF
2842: 
2843:             *-- Aplicar estado aos botoes
2844:             THIS.cmd_4c_Processar.Enabled    = loc_lTemDados
2845:             THIS.cmd_4c_Cancelar.Enabled     = .T.
2846:             THIS.cmd_4c_TotLinha.Enabled     = loc_lTemDados
2847:             THIS.cmd_4c_Disponivel.Enabled   = loc_lTemDados
2848:             THIS.cmd_4c_BtnRelatorio.Enabled = loc_lTemDados
2849:             THIS.cmd_4c_Pedras.Enabled       = loc_lPodeAcao
2850:             THIS.cmd_4c_SelEstoque.Enabled   = loc_lPodeAcao
2851:         CATCH TO loc_oErro
2852:             MsgErro(loc_oErro.Message, "Erro")
2853:         ENDTRY
2854:     ENDPROC
2855: 

