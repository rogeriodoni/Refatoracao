# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (7)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 167: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 193: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 218: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 243: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 270: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 292: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2060 linhas total):

*-- Linhas 93 a 532:
93: 
94:     *==========================================================================
95:     * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
96:     *==========================================================================
97:     PROTECTED PROCEDURE ConfigurarCabecalho
98:         THIS.AddObject("cnt_4c_Sombra", "Container")
99:         WITH THIS.cnt_4c_Sombra
100:             .Visible    = .T.
101:             .Top        = 0
102:             .Left       = 0
103:             .Width      = THIS.Width
104:             .Height     = 80
105:             .BorderWidth= 0
106:             .BackColor  = RGB(100,100,100)
107:             .AddObject("lbl_4c_LblSombra", "Label")
108:             WITH .lbl_4c_LblSombra
109:                 .FontBold      = .T.
110:                 .FontName      = "Tahoma"
111:                 .FontSize      = 18
112:                 .FontUnderline = .F.
113:                 .WordWrap      = .T.
114:                 .Alignment     = 0
115:                 .AutoSize      = .F.
116:                 .BackStyle     = 0
117:                 .Caption       = THIS.Caption
118:                 .Height        = 40
119:                 .Left          = 10
120:                 .Top           = 18
121:                 .Width         = THIS.Width
122:                 .ForeColor     = RGB(0,0,0)
123:             ENDWITH
124:             .AddObject("lbl_4c_LblTitulo", "Label")
125:             WITH .lbl_4c_LblTitulo
126:                 .FontBold   = .T.
127:                 .FontName   = "Tahoma"
128:                 .FontSize   = 18
129:                 .WordWrap   = .T.
130:                 .Alignment  = 0
131:                 .AutoSize   = .F.
132:                 .BackStyle  = 0
133:                 .Caption    = THIS.Caption
134:                 .Height     = 46
135:                 .Left       = 10
136:                 .Top        = 17
137:                 .Width      = THIS.Width
138:                 .ForeColor  = RGB(255,255,255)
139:             ENDWITH
140:         ENDWITH
141:     ENDPROC
142: 
143:     *==========================================================================
144:     * ConfigurarControlesPrincipais - Shape, CheckBoxes, Botoes, LblEnd, Registro
145:     *==========================================================================
146:     PROTECTED PROCEDURE ConfigurarControlesPrincipais
147:         *-- Shape decorativo (Shape1 original)
148:         THIS.AddObject("shp_4c_Shape1", "Shape")
149:         WITH THIS.shp_4c_Shape1
150:             .Top         = 7
151:             .Left        = 697
152:             .Height      = 110
153:             .Width       = 90
154:             .BackStyle   = 0
155:             .BorderStyle = 0
156:             .BorderColor = RGB(136,189,188)
157:         ENDWITH
158: 
159:         *-- CheckBox C.C. (Conta original - Left=350)
160:         THIS.AddObject("chk_4c_Conta", "CheckBox")
161:         WITH THIS.chk_4c_Conta
162:             .Top           = 3
163:             .Left          = 350
164:             .Height        = 75
165:             .Width         = 75
166:             .FontBold      = .T.
167:             .FontItalic    = .T.
168:             .FontName      = "Comic Sans MS"
169:             .FontSize      = 8
170:             .AutoSize      = .F.
171:             .Picture       = gc_4c_CaminhoIcones + "folder42.ico"
172:             .DownPicture   = gc_4c_CaminhoIcones + "a_cash1.bmp"
173:             .Alignment     = 1
174:             .BackStyle     = 0
175:             .Caption       = "C.C."
176:             .Value         = 0
177:             .SpecialEffect = 0
178:             .Style         = 1
179:             .ToolTipText   = "Conta Corrente"
180:             .ForeColor     = RGB(90,90,90)
181:             .BackColor     = RGB(255,255,255)
182:             .Themes        = .F.
183:         ENDWITH
184: 
185:         *-- CheckBox Estoque (Estoque original - Left=425)
186:         THIS.AddObject("chk_4c_Estoque", "CheckBox")
187:         WITH THIS.chk_4c_Estoque
188:             .Top           = 3
189:             .Left          = 425
190:             .Height        = 75
191:             .Width         = 75
192:             .FontBold      = .T.
193:             .FontItalic    = .T.
194:             .FontName      = "Comic Sans MS"
195:             .FontSize      = 8
196:             .AutoSize      = .F.
197:             .Picture       = gc_4c_CaminhoIcones + "folder22.ico"
198:             .DownPicture   = gc_4c_CaminhoIcones + "a_diamd1.bmp"
199:             .Alignment     = 1
200:             .BackStyle     = 0
201:             .Caption       = "Estoque"
202:             .Value         = 0
203:             .SpecialEffect = 0
204:             .Style         = 1
205:             .ForeColor     = RGB(90,90,90)
206:             .BackColor     = RGB(255,255,255)
207:             .Themes        = .F.
208:         ENDWITH
209: 
210:         *-- CheckBox Custo (btnCusto original - Left=500)
211:         THIS.AddObject("chk_4c_BtnCusto", "CheckBox")
212:         WITH THIS.chk_4c_BtnCusto
213:             .Top           = 3
214:             .Left          = 500
215:             .Height        = 75
216:             .Width         = 75
217:             .FontBold      = .T.
218:             .FontItalic    = .T.
219:             .FontName      = "Comic Sans MS"
220:             .FontSize      = 8
221:             .AutoSize      = .F.
222:             .Picture       = gc_4c_CaminhoIcones + "folder34.ico"
223:             .DownPicture   = gc_4c_CaminhoIcones + "d_misc2.bmp"
224:             .Alignment     = 1
225:             .BackStyle     = 0
226:             .Caption       = "Custo"
227:             .Value         = 0
228:             .SpecialEffect = 0
229:             .Style         = 1
230:             .ForeColor     = RGB(90,90,90)
231:             .BackColor     = RGB(255,255,255)
232:             .Themes        = .F.
233:         ENDWITH
234: 
235:         *-- CheckBox Ultima Compra (btnCompra original - Left=575)
236:         THIS.AddObject("chk_4c_BtnCompra", "CheckBox")
237:         WITH THIS.chk_4c_BtnCompra
238:             .Top           = 3
239:             .Left          = 575
240:             .Height        = 75
241:             .Width         = 75
242:             .FontBold      = .T.
243:             .FontItalic    = .T.
244:             .FontName      = "Comic Sans MS"
245:             .FontSize      = 8
246:             .AutoSize      = .F.
247:             .Picture       = gc_4c_CaminhoIcones + "folder27.ico"
248:             .DownPicture   = gc_4c_CaminhoIcones + "d_misc2.bmp"
249:             .Alignment     = 1
250:             .BackStyle     = 0
251:             .Caption       = CHR(218) + "lt. Compra"
252:             .Value         = 0
253:             .SpecialEffect = 0
254:             .Style         = 1
255:             .ToolTipText   = CHR(218) + "ltima Compra"
256:             .ForeColor     = RGB(90,90,90)
257:             .BackColor     = RGB(255,255,255)
258:             .Themes        = .F.
259:         ENDWITH
260: 
261:         *-- Botao Processar (Processa original - Left=650)
262:         *-- Themes=.T. + DisabledPicture obrigatorio para standalone com Picture e Enabled=.F.
263:         THIS.AddObject("cmd_4c_Processa", "CommandButton")
264:         WITH THIS.cmd_4c_Processa
265:             .Top            = 3
266:             .Left           = 650
267:             .Height         = 75
268:             .Width          = 75
269:             .FontBold       = .T.
270:             .FontItalic     = .T.
271:             .FontName       = "Comic Sans MS"
272:             .FontSize       = 8
273:             .Picture        = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
274:             .DisabledPicture= gc_4c_CaminhoIcones + "geral_processar_60.jpg"
275:             .Caption        = "Processar"
276:             .Enabled        = .F.
277:             .SpecialEffect  = 0
278:             .ForeColor      = RGB(90,90,90)
279:             .BackColor      = RGB(255,255,255)
280:             .Themes         = .T.
281:             .ToolTipText    = "Processar"
282:         ENDWITH
283: 
284:         *-- Botao Encerrar/Cancela (Cancela original - Left=725, Cancel=.T.)
285:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
286:         WITH THIS.cmd_4c_Cancela
287:             .Top            = 3
288:             .Left           = 725
289:             .Height         = 75
290:             .Width          = 75
291:             .FontBold       = .T.
292:             .FontItalic     = .T.
293:             .FontName       = "Comic Sans MS"
294:             .FontSize       = 8
295:             .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
296:             .DisabledPicture= gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
297:             .Cancel         = .T.
298:             .Caption        = "Encerrar"
299:             .SpecialEffect  = 0
300:             .ForeColor      = RGB(90,90,90)
301:             .BackColor      = RGB(255,255,255)
302:             .Themes         = .T.
303:             .ToolTipText    = "[ESC] Sair"
304:         ENDWITH
305: 
306:         *-- Label "Processamento Concluido" (LblEnd - inicialmente invisivel)
307:         THIS.AddObject("lbl_4c_LblEnd", "Label")
308:         WITH THIS.lbl_4c_LblEnd
309:             .AutoSize   = .T.
310:             .FontBold   = .T.
311:             .FontItalic = .F.
312:             .FontName   = "Arial"
313:             .FontSize   = 12
314:             .WordWrap   = .F.
315:             .Alignment  = 2
316:             .BackStyle  = 0
317:             .Caption    = "Processamento Conclu" + CHR(237) + "do"
318:             .Height     = 22
319:             .Left       = 361
320:             .Top        = 545
321:             .Width      = 205
322:             .ForeColor  = RGB(255,0,0)
323:             .Visible    = .F.
324:         ENDWITH
325: 
326:         *-- Label "Registros :" (Label1 original)
327:         THIS.AddObject("lbl_4c_LblRegistros", "Label")
328:         WITH THIS.lbl_4c_LblRegistros
329:             .AutoSize   = .T.
330:             .FontBold   = .T.
331:             .FontItalic = .F.
332:             .FontName   = "Tahoma"
333:             .FontSize   = 8
334:             .WordWrap   = .F.
335:             .BackStyle  = 0
336:             .Caption    = "Registros : "
337:             .Height     = 15
338:             .Left       = 171
339:             .Top        = 547
340:             .Width      = 65
341:             .ForeColor  = RGB(90,90,90)
342:         ENDWITH
343: 
344:         *-- TextBox contador de registros (Get_Registro original)
345:         THIS.AddObject("txt_4c_Registro", "TextBox")
346:         WITH THIS.txt_4c_Registro
347:             .FontName      = "Tahoma"
348:             .FontSize      = 8
349:             .Height        = 23
350:             .InputMask     = "999,999,999"
351:             .Left          = 238
352:             .SpecialEffect = 1
353:             .Top           = 543
354:             .Width         = 93
355:             .ReadOnly      = .T.
356:             .Value         = 0
357:         ENDWITH
358:     ENDPROC
359: 
360:     *==========================================================================
361:     * ConfigurarContainerOpConta - Conta Corrente: empresa, grupo, conta, moeda, data
362:     *==========================================================================
363:     PROTECTED PROCEDURE ConfigurarContainerOpConta
364:         THIS.AddObject("cnt_4c_OpConta", "Container")
365:         WITH THIS.cnt_4c_OpConta
366:             .Top           = 114
367:             .Left          = 139
368:             .Width         = THIS.LarguraOpConta
369:             .Height        = 81
370:             .BackStyle     = 0
371:             .BorderWidth   = 2
372:             .SpecialEffect = 2
373:             .Visible       = .F.
374:             .BackColor     = RGB(192,192,255)
375:             .BorderColor   = RGB(90,90,90)
376: 
377:             .AddObject("lbl_4c_TituloOp", "Label")
378:             WITH .lbl_4c_TituloOp
379:                 .AutoSize      = .T.
380:                 .FontBold      = .T.
381:                 .FontName      = "Tahoma"
382:                 .FontSize      = 8
383:                 .FontUnderline = .T.
384:                 .BackStyle     = 0
385:                 .Caption       = "Op" + CHR(231) + CHR(245) + "es de Conta Corrente"
386:                 .Left          = 171
387:                 .Top           = 2
388:                 .ForeColor     = RGB(90,90,90)
389:             ENDWITH
390: 
391:             .AddObject("lbl_4c_LblEmpresa", "Label")
392:             WITH .lbl_4c_LblEmpresa
393:                 .AutoSize   = .T.
394:                 .FontBold   = .T.
395:                 .FontName   = "Tahoma"
396:                 .FontSize   = 8
397:                 .BackStyle  = 0
398:                 .Caption    = "Empresa :"
399:                 .Height     = 15
400:                 .Left       = 16
401:                 .Top        = 23
402:                 .Width      = 57
403:                 .ForeColor  = RGB(90,90,90)
404:             ENDWITH
405:             .AddObject("txt_4c_Empresa", "TextBox")
406:             WITH .txt_4c_Empresa
407:                 .FontName      = "Tahoma"
408:                 .FontSize      = 8
409:                 .Alignment     = 3
410:                 .Height        = 23
411:                 .Left          = 75
412:                 .MaxLength     = 3
413:                 .SpecialEffect = 1
414:                 .Top           = 20
415:                 .Width         = 31
416:                 .ForeColor     = RGB(0,0,0)
417:                 .Value         = go_4c_Sistema.cCodEmpresa
418:             ENDWITH
419: 
420:             .AddObject("lbl_4c_LblGrupos", "Label")
421:             WITH .lbl_4c_LblGrupos
422:                 .AutoSize   = .T.
423:                 .FontBold   = .T.
424:                 .FontName   = "Tahoma"
425:                 .FontSize   = 8
426:                 .BackStyle  = 0
427:                 .Caption    = "Grupo :"
428:                 .Height     = 15
429:                 .Left       = 122
430:                 .Top        = 24
431:                 .Width      = 42
432:                 .ForeColor  = RGB(90,90,90)
433:             ENDWITH
434:             .AddObject("txt_4c_TxtGrupos", "TextBox")
435:             WITH .txt_4c_TxtGrupos
436:                 .FontName      = "Tahoma"
437:                 .FontSize      = 8
438:                 .Format        = "K"
439:                 .Height        = 23
440:                 .Left          = 166
441:                 .MaxLength     = 10
442:                 .SpecialEffect = 1
443:                 .Top           = 20
444:                 .Width         = 80
445:                 .ForeColor     = RGB(0,0,0)
446:             ENDWITH
447: 
448:             .AddObject("lbl_4c_LblContas", "Label")
449:             WITH .lbl_4c_LblContas
450:                 .AutoSize   = .T.
451:                 .FontBold   = .T.
452:                 .FontName   = "Tahoma"
453:                 .FontSize   = 8
454:                 .BackStyle  = 0
455:                 .Caption    = "Conta :"
456:                 .Height     = 15
457:                 .Left       = 255
458:                 .Top        = 24
459:                 .Width      = 41
460:                 .ForeColor  = RGB(90,90,90)
461:             ENDWITH
462:             .AddObject("txt_4c_TxtContas", "TextBox")
463:             WITH .txt_4c_TxtContas
464:                 .FontName      = "Tahoma"
465:                 .FontSize      = 8
466:                 .Format        = "K"
467:                 .Height        = 23
468:                 .Left          = 298
469:                 .MaxLength     = 10
470:                 .SpecialEffect = 1
471:                 .Top           = 20
472:                 .Width         = 80
473:                 .ForeColor     = RGB(0,0,0)
474:             ENDWITH
475: 
476:             .AddObject("lbl_4c_LblMoedas", "Label")
477:             WITH .lbl_4c_LblMoedas
478:                 .AutoSize   = .T.
479:                 .FontBold   = .T.
480:                 .FontName   = "Tahoma"
481:                 .FontSize   = 8
482:                 .BackStyle  = 0
483:                 .Caption    = "Moeda :"
484:                 .Height     = 15
485:                 .Left       = 27
486:                 .Top        = 50
487:                 .Width      = 46
488:                 .ForeColor  = RGB(90,90,90)
489:             ENDWITH
490:             .AddObject("txt_4c_TxtMoedas", "TextBox")
491:             WITH .txt_4c_TxtMoedas
492:                 .FontName      = "Tahoma"
493:                 .FontSize      = 8
494:                 .Format        = "K"
495:                 .Height        = 23
496:                 .Left          = 75
497:                 .MaxLength     = 3
498:                 .SpecialEffect = 1
499:                 .Top           = 46
500:                 .Width         = 31
501:                 .ForeColor     = RGB(0,0,0)
502:             ENDWITH
503: 
504:             .AddObject("lbl_4c_LblData", "Label")
505:             WITH .lbl_4c_LblData
506:                 .AutoSize   = .T.
507:                 .FontBold   = .T.
508:                 .FontName   = "Tahoma"
509:                 .FontSize   = 8
510:                 .BackStyle  = 0
511:                 .Caption    = "A partir de :"
512:                 .Height     = 15
513:                 .Left       = 121
514:                 .Top        = 50
515:                 .Width      = 68
516:                 .ForeColor  = RGB(90,90,90)
517:             ENDWITH
518:             .AddObject("txt_4c_TxtData", "TextBox")
519:             WITH .txt_4c_TxtData
520:                 .FontName      = "Tahoma"
521:                 .FontSize      = 8
522:                 .Alignment     = 3
523:                 .Format        = "D"
524:                 .Height        = 23
525:                 .Left          = 191
526:                 .SpecialEffect = 1
527:                 .Top           = 46
528:                 .Width         = 80
529:                 .ForeColor     = RGB(0,0,0)
530:                 .Value         = {}
531:             ENDWITH
532:         ENDWITH

*-- Linhas 538 a 719:
538:     PROTECTED PROCEDURE ConfigurarContainerOpEstoque
539:         THIS.AddObject("cnt_4c_OpEstoque", "Container")
540:         WITH THIS.cnt_4c_OpEstoque
541:             .Top           = 200
542:             .Left          = 139
543:             .Width         = THIS.LarguraOpEstoque
544:             .Height        = 143
545:             .BackStyle     = 0
546:             .BorderWidth   = 2
547:             .SpecialEffect = 2
548:             .Visible       = .F.
549:             .BackColor     = RGB(192,192,255)
550:             .BorderColor   = RGB(90,90,90)
551: 
552:             .AddObject("lbl_4c_TituloOp", "Label")
553:             WITH .lbl_4c_TituloOp
554:                 .AutoSize      = .T.
555:                 .FontBold      = .T.
556:                 .FontName      = "Tahoma"
557:                 .FontSize      = 8
558:                 .FontUnderline = .T.
559:                 .BackStyle     = 0
560:                 .Caption       = "Op" + CHR(231) + CHR(245) + "es de Estoque"
561:                 .Left          = 182
562:                 .Top           = 2
563:                 .ForeColor     = RGB(90,90,90)
564:             ENDWITH
565: 
566:             .AddObject("lbl_4c_LblEmpresa", "Label")
567:             WITH .lbl_4c_LblEmpresa
568:                 .AutoSize   = .T.
569:                 .FontBold   = .T.
570:                 .FontName   = "Tahoma"
571:                 .FontSize   = 8
572:                 .BackStyle  = 0
573:                 .Caption    = "Empresa :"
574:                 .Height     = 15
575:                 .Left       = 31
576:                 .Top        = 15
577:                 .Width      = 57
578:                 .ForeColor  = RGB(90,90,90)
579:             ENDWITH
580:             .AddObject("txt_4c_Empresa", "TextBox")
581:             WITH .txt_4c_Empresa
582:                 .FontName      = "Tahoma"
583:                 .FontSize      = 8
584:                 .Alignment     = 3
585:                 .Height        = 23
586:                 .Left          = 90
587:                 .MaxLength     = 3
588:                 .SpecialEffect = 1
589:                 .Top           = 12
590:                 .Width         = 31
591:                 .ForeColor     = RGB(0,0,0)
592:                 .Value         = go_4c_Sistema.cCodEmpresa
593:             ENDWITH
594: 
595:             .AddObject("lbl_4c_LblGrupos", "Label")
596:             WITH .lbl_4c_LblGrupos
597:                 .AutoSize   = .T.
598:                 .FontBold   = .T.
599:                 .FontName   = "Tahoma"
600:                 .FontSize   = 8
601:                 .BackStyle  = 0
602:                 .Caption    = "Grupo :"
603:                 .Left       = 46
604:                 .Top        = 40
605:                 .Width      = 42
606:                 .ForeColor  = RGB(90,90,90)
607:             ENDWITH
608:             .AddObject("txt_4c_TxtGrupos", "TextBox")
609:             WITH .txt_4c_TxtGrupos
610:                 .FontName      = "Tahoma"
611:                 .FontSize      = 8
612:                 .Format        = "K"
613:                 .Height        = 23
614:                 .Left          = 90
615:                 .MaxLength     = 10
616:                 .SpecialEffect = 1
617:                 .Top           = 37
618:                 .Width         = 80
619:                 .ForeColor     = RGB(0,0,0)
620:             ENDWITH
621: 
622:             .AddObject("lbl_4c_LblEstoque", "Label")
623:             WITH .lbl_4c_LblEstoque
624:                 .AutoSize   = .T.
625:                 .FontBold   = .T.
626:                 .FontName   = "Tahoma"
627:                 .FontSize   = 8
628:                 .BackStyle  = 0
629:                 .Caption    = "Estoque :"
630:                 .Height     = 15
631:                 .Left       = 35
632:                 .Top        = 65
633:                 .Width      = 53
634:                 .ForeColor  = RGB(90,90,90)
635:             ENDWITH
636:             .AddObject("txt_4c_Estoque", "TextBox")
637:             WITH .txt_4c_Estoque
638:                 .FontName      = "Tahoma"
639:                 .FontSize      = 8
640:                 .Alignment     = 3
641:                 .Height        = 23
642:                 .Left          = 90
643:                 .MaxLength     = 10
644:                 .SpecialEffect = 1
645:                 .Top           = 62
646:                 .Width         = 80
647:                 .ForeColor     = RGB(0,0,0)
648:             ENDWITH
649: 
650:             .AddObject("lbl_4c_LblProduto", "Label")
651:             WITH .lbl_4c_LblProduto
652:                 .AutoSize   = .T.
653:                 .FontBold   = .T.
654:                 .FontName   = "Tahoma"
655:                 .FontSize   = 8
656:                 .BackStyle  = 0
657:                 .Caption    = "Produto :"
658:                 .Left       = 35
659:                 .Top        = 90
660:                 .Width      = 53
661:                 .ForeColor  = RGB(90,90,90)
662:             ENDWITH
663:             .AddObject("txt_4c_Produto", "TextBox")
664:             WITH .txt_4c_Produto
665:                 .FontName      = "Tahoma"
666:                 .FontSize      = 8
667:                 .Alignment     = 3
668:                 .Height        = 23
669:                 .Left          = 90
670:                 .MaxLength     = 14
671:                 .SpecialEffect = 1
672:                 .Top           = 87
673:                 .Width         = 108
674:                 .ForeColor     = RGB(0,0,0)
675:             ENDWITH
676:             .AddObject("txt_4c_Descricao", "TextBox")
677:             WITH .txt_4c_Descricao
678:                 .FontName      = "Tahoma"
679:                 .FontSize      = 8
680:                 .Alignment     = 3
681:                 .Height        = 23
682:                 .Left          = 199
683:                 .MaxLength     = 40
684:                 .SpecialEffect = 1
685:                 .Top           = 87
686:                 .Width         = 327
687:                 .ForeColor     = RGB(0,0,0)
688:                 .ReadOnly      = .T.
689:             ENDWITH
690: 
691:             .AddObject("lbl_4c_LblData", "Label")
692:             WITH .lbl_4c_LblData
693:                 .AutoSize   = .T.
694:                 .FontBold   = .T.
695:                 .FontName   = "Tahoma"
696:                 .FontSize   = 8
697:                 .BackStyle  = 0
698:                 .Caption    = "A partir de :"
699:                 .Height     = 15
700:                 .Left       = 20
701:                 .Top        = 115
702:                 .Width      = 68
703:                 .ForeColor  = RGB(90,90,90)
704:             ENDWITH
705:             .AddObject("txt_4c_TxtData", "TextBox")
706:             WITH .txt_4c_TxtData
707:                 .FontName      = "Tahoma"
708:                 .FontSize      = 8
709:                 .Alignment     = 3
710:                 .Format        = "D"
711:                 .Height        = 23
712:                 .Left          = 90
713:                 .SpecialEffect = 1
714:                 .Top           = 112
715:                 .Width         = 80
716:                 .ForeColor     = RGB(0,0,0)
717:                 .Value         = {}
718:             ENDWITH
719:         ENDWITH

*-- Linhas 725 a 851:
725:     PROTECTED PROCEDURE ConfigurarContainerOpCusto
726:         THIS.AddObject("cnt_4c_OpCusto", "Container")
727:         WITH THIS.cnt_4c_OpCusto
728:             .Top           = 349
729:             .Left          = 139
730:             .Width         = THIS.LarguraOpCusto
731:             .Height        = 92
732:             .BackStyle     = 0
733:             .BorderWidth   = 2
734:             .SpecialEffect = 2
735:             .Visible       = .F.
736:             .BackColor     = RGB(192,192,255)
737:             .BorderColor   = RGB(90,90,90)
738: 
739:             .AddObject("lbl_4c_TituloOp", "Label")
740:             WITH .lbl_4c_TituloOp
741:                 .AutoSize      = .T.
742:                 .FontBold      = .T.
743:                 .FontName      = "Tahoma"
744:                 .FontSize      = 8
745:                 .FontUnderline = .T.
746:                 .BackStyle     = 0
747:                 .Caption       = "Op" + CHR(231) + CHR(245) + "es de Custo de Produto"
748:                 .Left          = 155
749:                 .Top           = 2
750:                 .ForeColor     = RGB(90,90,90)
751:             ENDWITH
752: 
753:             .AddObject("lbl_4c_LblEmpresa", "Label")
754:             WITH .lbl_4c_LblEmpresa
755:                 .AutoSize   = .T.
756:                 .FontBold   = .T.
757:                 .FontName   = "Tahoma"
758:                 .FontSize   = 8
759:                 .BackStyle  = 0
760:                 .Caption    = "Empresa :"
761:                 .Height     = 15
762:                 .Left       = 31
763:                 .Top        = 14
764:                 .Width      = 57
765:                 .ForeColor  = RGB(90,90,90)
766:             ENDWITH
767:             .AddObject("txt_4c_Empresa", "TextBox")
768:             WITH .txt_4c_Empresa
769:                 .FontName      = "Tahoma"
770:                 .FontSize      = 8
771:                 .Alignment     = 3
772:                 .Height        = 23
773:                 .Left          = 90
774:                 .MaxLength     = 3
775:                 .SpecialEffect = 1
776:                 .Top           = 11
777:                 .Width         = 31
778:                 .ForeColor     = RGB(0,0,0)
779:                 .Value         = go_4c_Sistema.cCodEmpresa
780:             ENDWITH
781: 
782:             .AddObject("lbl_4c_LblProduto", "Label")
783:             WITH .lbl_4c_LblProduto
784:                 .AutoSize   = .T.
785:                 .FontBold   = .T.
786:                 .FontName   = "Tahoma"
787:                 .FontSize   = 8
788:                 .BackStyle  = 0
789:                 .Caption    = "Produto :"
790:                 .Left       = 35
791:                 .Top        = 39
792:                 .Width      = 53
793:                 .ForeColor  = RGB(90,90,90)
794:             ENDWITH
795:             .AddObject("txt_4c_Produto", "TextBox")
796:             WITH .txt_4c_Produto
797:                 .FontName      = "Tahoma"
798:                 .FontSize      = 8
799:                 .Alignment     = 3
800:                 .Height        = 23
801:                 .Left          = 90
802:                 .MaxLength     = 14
803:                 .SpecialEffect = 1
804:                 .Top           = 36
805:                 .Width         = 108
806:                 .ForeColor     = RGB(0,0,0)
807:             ENDWITH
808:             .AddObject("txt_4c_Descricao", "TextBox")
809:             WITH .txt_4c_Descricao
810:                 .FontName      = "Tahoma"
811:                 .FontSize      = 8
812:                 .Alignment     = 3
813:                 .Height        = 23
814:                 .Left          = 199
815:                 .MaxLength     = 40
816:                 .SpecialEffect = 1
817:                 .Top           = 36
818:                 .Width         = 327
819:                 .ForeColor     = RGB(0,0,0)
820:                 .ReadOnly      = .T.
821:             ENDWITH
822: 
823:             .AddObject("lbl_4c_LblData", "Label")
824:             WITH .lbl_4c_LblData
825:                 .AutoSize   = .T.
826:                 .FontBold   = .T.
827:                 .FontName   = "Tahoma"
828:                 .FontSize   = 8
829:                 .BackStyle  = 0
830:                 .Caption    = "A partir de :"
831:                 .Height     = 15
832:                 .Left       = 20
833:                 .Top        = 64
834:                 .Width      = 68
835:                 .ForeColor  = RGB(90,90,90)
836:             ENDWITH
837:             .AddObject("txt_4c_TxtData", "TextBox")
838:             WITH .txt_4c_TxtData
839:                 .FontName      = "Tahoma"
840:                 .FontSize      = 8
841:                 .Alignment     = 3
842:                 .Format        = "D"
843:                 .Height        = 23
844:                 .Left          = 90
845:                 .SpecialEffect = 1
846:                 .Top           = 61
847:                 .Width         = 80
848:                 .ForeColor     = RGB(0,0,0)
849:                 .Value         = {}
850:             ENDWITH
851:         ENDWITH

*-- Linhas 857 a 983:
857:     PROTECTED PROCEDURE ConfigurarContainerOpCompra
858:         THIS.AddObject("cnt_4c_OpCompra", "Container")
859:         WITH THIS.cnt_4c_OpCompra
860:             .Top           = 447
861:             .Left          = 139
862:             .Width         = THIS.LarguraOpCompra
863:             .Height        = 91
864:             .BackStyle     = 0
865:             .BorderWidth   = 2
866:             .SpecialEffect = 2
867:             .Visible       = .F.
868:             .BackColor     = RGB(192,192,255)
869:             .BorderColor   = RGB(90,90,90)
870: 
871:             .AddObject("lbl_4c_TituloOp", "Label")
872:             WITH .lbl_4c_TituloOp
873:                 .AutoSize      = .T.
874:                 .FontBold      = .T.
875:                 .FontName      = "Tahoma"
876:                 .FontSize      = 8
877:                 .FontUnderline = .T.
878:                 .BackStyle     = 0
879:                 .Caption       = "Op" + CHR(231) + CHR(245) + "es de Ultima Compra do Produto/Cliente"
880:                 .Left          = 140
881:                 .Top           = 2
882:                 .ForeColor     = RGB(90,90,90)
883:             ENDWITH
884: 
885:             .AddObject("lbl_4c_LblEmpresa", "Label")
886:             WITH .lbl_4c_LblEmpresa
887:                 .AutoSize   = .T.
888:                 .FontBold   = .T.
889:                 .FontName   = "Tahoma"
890:                 .FontSize   = 8
891:                 .BackStyle  = 0
892:                 .Caption    = "Empresa :"
893:                 .Height     = 15
894:                 .Left       = 31
895:                 .Top        = 14
896:                 .Width      = 57
897:                 .ForeColor  = RGB(90,90,90)
898:             ENDWITH
899:             .AddObject("txt_4c_Empresa", "TextBox")
900:             WITH .txt_4c_Empresa
901:                 .FontName      = "Tahoma"
902:                 .FontSize      = 8
903:                 .Alignment     = 3
904:                 .Height        = 23
905:                 .Left          = 90
906:                 .MaxLength     = 3
907:                 .SpecialEffect = 1
908:                 .Top           = 10
909:                 .Width         = 31
910:                 .ForeColor     = RGB(0,0,0)
911:                 .Value         = go_4c_Sistema.cCodEmpresa
912:             ENDWITH
913: 
914:             .AddObject("lbl_4c_LblProduto", "Label")
915:             WITH .lbl_4c_LblProduto
916:                 .AutoSize   = .T.
917:                 .FontBold   = .T.
918:                 .FontName   = "Tahoma"
919:                 .FontSize   = 8
920:                 .BackStyle  = 0
921:                 .Caption    = "Produto :"
922:                 .Left       = 35
923:                 .Top        = 39
924:                 .Width      = 53
925:                 .ForeColor  = RGB(90,90,90)
926:             ENDWITH
927:             .AddObject("txt_4c_Produto", "TextBox")
928:             WITH .txt_4c_Produto
929:                 .FontName      = "Tahoma"
930:                 .FontSize      = 8
931:                 .Alignment     = 3
932:                 .Height        = 23
933:                 .Left          = 90
934:                 .MaxLength     = 14
935:                 .SpecialEffect = 1
936:                 .Top           = 35
937:                 .Width         = 108
938:                 .ForeColor     = RGB(0,0,0)
939:             ENDWITH
940:             .AddObject("txt_4c_Descricao", "TextBox")
941:             WITH .txt_4c_Descricao
942:                 .FontName      = "Tahoma"
943:                 .FontSize      = 8
944:                 .Alignment     = 3
945:                 .Height        = 23
946:                 .Left          = 199
947:                 .MaxLength     = 40
948:                 .SpecialEffect = 1
949:                 .Top           = 35
950:                 .Width         = 327
951:                 .ForeColor     = RGB(0,0,0)
952:                 .ReadOnly      = .T.
953:             ENDWITH
954: 
955:             .AddObject("lbl_4c_LblData", "Label")
956:             WITH .lbl_4c_LblData
957:                 .AutoSize   = .T.
958:                 .FontBold   = .T.
959:                 .FontName   = "Tahoma"
960:                 .FontSize   = 8
961:                 .BackStyle  = 0
962:                 .Caption    = "A partir de :"
963:                 .Height     = 15
964:                 .Left       = 20
965:                 .Top        = 64
966:                 .Width      = 68
967:                 .ForeColor  = RGB(90,90,90)
968:             ENDWITH
969:             .AddObject("txt_4c_TxtData", "TextBox")
970:             WITH .txt_4c_TxtData
971:                 .FontName      = "Tahoma"
972:                 .FontSize      = 8
973:                 .Alignment     = 3
974:                 .Format        = "D"
975:                 .Height        = 23
976:                 .Left          = 90
977:                 .SpecialEffect = 1
978:                 .Top           = 60
979:                 .Width         = 80
980:                 .ForeColor     = RGB(0,0,0)
981:                 .Value         = {}
982:             ENDWITH
983:         ENDWITH

*-- Linhas 1001 a 1041:
1001:             ENDIF
1002: 
1003:             loc_cNome = UPPER(loc_oControl.Name)
1004: 
1005:             *-- Containers com Visible controlado explicitamente: nao forcar .T.
1006:             IF INLIST(loc_cNome, "CNT_4C_SOMBRA", ;
1007:                                  "CNT_4C_OPCONTA", "CNT_4C_OPESTOQUE", ;
1008:                                  "CNT_4C_OPCUSTO", "CNT_4C_OPCOMPRA")
1009:                 *-- Tornar filhos visiveis sem tocar Visible do proprio container
1010:                 THIS.TornarControlesVisiveis(loc_oControl)
1011:                 LOOP
1012:             ENDIF
1013: 
1014:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1015:                 loc_oControl.Visible = .T.
1016:             ENDIF
1017: 
1018:             *-- Recursar em containers e pageframes
1019:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1020:                loc_oControl.ControlCount > 0
1021:                 THIS.TornarControlesVisiveis(loc_oControl)
1022:             ENDIF
1023:         ENDFOR
1024:     ENDPROC
1025: 
1026:     *==========================================================================
1027:     * ConfigurarBINDEVENTs - handlers dos checkboxes e botoes
1028:     *==========================================================================
1029:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
1030:         *-- CheckBoxes e botoes principais
1031:         BINDEVENT(THIS.chk_4c_Conta,     "Click", THIS, "ChkContaClick")
1032:         BINDEVENT(THIS.chk_4c_Estoque,   "Click", THIS, "ChkEstoqueClick")
1033:         BINDEVENT(THIS.chk_4c_BtnCusto,  "Click", THIS, "ChkCustoClick")
1034:         BINDEVENT(THIS.chk_4c_BtnCompra, "Click", THIS, "ChkCompraClick")
1035:         BINDEVENT(THIS.cmd_4c_Processa,  "Click", THIS, "BtnProcessarClick")
1036:         BINDEVENT(THIS.cmd_4c_Cancela,   "Click", THIS, "BtnCancelaClick")
1037: 
1038:         *-- OpConta: Empresa, Grupos, Contas, Moedas
1039:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_Empresa,   "KeyPress", THIS, "TxtContaEmpresaKeyPress")
1040:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos, "KeyPress", THIS, "TxtContaGruposKeyPress")
1041:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_TxtContas, "KeyPress", THIS, "TxtContaContasKeyPress")

*-- Linhas 1078 a 1088:
1078:             THIS.chk_4c_Estoque.Enabled   = .F.
1079:             THIS.chk_4c_BtnCusto.Enabled  = .F.
1080:             THIS.chk_4c_BtnCompra.Enabled = .F.
1081:             THIS.cmd_4c_Processa.Enabled  = .F.
1082:             THIS.cmd_4c_Cancela.Enabled   = .F.
1083:             THIS.lbl_4c_LblEnd.Visible    = .F.
1084:             THIS.txt_4c_Registro.Value    = 0
1085:             DOEVENTS
1086: 
1087:             loc_oBO = THIS.this_oBusinessObject
1088:             loc_oBO.this_nRegistros = 0

*-- Linhas 1157 a 1165:
1157:             ENDIF
1158: 
1159:             IF loc_lAlgum
1160:                 THIS.lbl_4c_LblEnd.Visible = .T.
1161:             ENDIF
1162: 
1163:             loc_lSucesso = .T.
1164:         CATCH TO loc_oErro
1165:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;

*-- Linhas 1171 a 1179:
1171:         THIS.chk_4c_Estoque.Enabled   = .T.
1172:         THIS.chk_4c_BtnCusto.Enabled  = .T.
1173:         THIS.chk_4c_BtnCompra.Enabled = .T.
1174:         THIS.cmd_4c_Cancela.Enabled   = .T.
1175:         THIS.AtualizarEstadoProcessa()
1176: 
1177:         IF VARTYPE(loc_oProgress) = "O"
1178:             loc_oProgress.Release()
1179:             loc_oProgress = .NULL.

*-- Linhas 1218 a 1226:
1218:                      (THIS.chk_4c_Estoque.Value = 1) OR ;
1219:                      (THIS.chk_4c_BtnCusto.Value = 1) OR ;
1220:                      (THIS.chk_4c_BtnCompra.Value = 1)
1221:         THIS.cmd_4c_Processa.Enabled = loc_lAlgum
1222:     ENDPROC
1223: 
1224:     *==========================================================================
1225:     * KeyPress handlers - OpConta
1226:     *==========================================================================

*-- Linhas 1517 a 1525:
1517:     * Chamado apos processamento concluir OU quando quiser reiniciar selecao.
1518:     *==========================================================================
1519:     PROTECTED PROCEDURE ConfigurarPaginaLista
1520:         *-- Desmarca todos os checkboxes de opcao (Conta, Estoque, Custo, Compra)
1521:         THIS.chk_4c_Conta.Value     = 0
1522:         THIS.chk_4c_Estoque.Value   = 0
1523:         THIS.chk_4c_BtnCusto.Value  = 0
1524:         THIS.chk_4c_BtnCompra.Value = 0
1525: 

*-- Linhas 1531 a 1546:
1531: 
1532:         *-- Limpa contador de registros e oculta label de conclusao
1533:         THIS.txt_4c_Registro.Value  = 0
1534:         THIS.lbl_4c_LblEnd.Visible  = .F.
1535: 
1536:         *-- Reabilita controles (caso venham de processamento anterior)
1537:         THIS.chk_4c_Conta.Enabled     = .T.
1538:         THIS.chk_4c_Estoque.Enabled   = .T.
1539:         THIS.chk_4c_BtnCusto.Enabled  = .T.
1540:         THIS.chk_4c_BtnCompra.Enabled = .T.
1541:         THIS.cmd_4c_Cancela.Enabled   = .T.
1542: 
1543:         *-- Atualiza estado do botao Processar (deve ficar desabilitado sem selecao)
1544:         THIS.AtualizarEstadoProcessa()
1545: 
1546:         RETURN .T.

*-- Linhas 1673 a 1684:
1673:         THIS.LimparCamposContainer(THIS.cnt_4c_OpCompra)
1674: 
1675:         THIS.txt_4c_Registro.Value    = ""
1676:         THIS.lbl_4c_LblEnd.Visible    = .F.
1677: 
1678:         THIS.cmd_4c_Processa.Enabled  = .F.
1679:         THIS.cmd_4c_Cancela.Enabled   = .T.
1680: 
1681:         THIS.Refresh()
1682:     ENDPROC
1683: 
1684:     *==========================================================================

*-- Linhas 1696 a 1704:
1696:         THIS.cnt_4c_OpCusto.Enabled   = (THIS.chk_4c_BtnCusto.Value = 1)
1697:         THIS.cnt_4c_OpCompra.Enabled  = (THIS.chk_4c_BtnCompra.Value = 1)
1698: 
1699:         THIS.cmd_4c_Cancela.Enabled   = .T.
1700:         THIS.AtualizarEstadoProcessa()
1701:         THIS.Refresh()
1702:     ENDPROC
1703: 
1704:     *==========================================================================

*-- Linhas 1730 a 1738:
1730: 
1731:         IF loc_nSel = 0
1732:             loc_cMsg = "Nenhum tipo de rec" + CHR(225) + "lculo selecionado." + CHR(13) + ;
1733:                        "Marque um dos checkboxes para configurar o processamento."
1734:         ELSE
1735:             loc_cMsg = "Tipos selecionados (" + TRANSFORM(loc_nSel) + "):" + CHR(13) + ;
1736:                        loc_cSelecoes + CHR(13) + ;
1737:                        "Registros processados: " + ALLTRIM(TRANSFORM(THIS.txt_4c_Registro.Value))
1738:         ENDIF

*-- Linhas 1756 a 1764:
1756:         THIS.cnt_4c_OpCompra.Visible  = .F.
1757: 
1758:         THIS.txt_4c_Registro.Value    = ""
1759:         THIS.lbl_4c_LblEnd.Visible    = .F.
1760: 
1761:         THIS.AtualizarEstadoProcessa()
1762:         THIS.Refresh()
1763:     ENDPROC
1764: 

*-- Linhas 1905 a 1936:
1905:     ENDPROC
1906: 
1907:     *==========================================================================
1908:     * HabilitarCampos - Habilita/desabilita containers e checkboxes conforme
1909:     * o estado de processamento (par_lHabilitar). Chamado por Processa e
1910:     * ao terminar o processamento para bloquear a UI durante a execucao SQL.
1911:     *==========================================================================
1912:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1913:         LOCAL loc_lHab
1914:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1915: 
1916:         *-- Checkboxes principais
1917:         THIS.chk_4c_Conta.Enabled     = loc_lHab
1918:         THIS.chk_4c_Estoque.Enabled   = loc_lHab
1919:         THIS.chk_4c_BtnCusto.Enabled  = loc_lHab
1920:         THIS.chk_4c_BtnCompra.Enabled = loc_lHab
1921: 
1922:         *-- Containers de opcoes: enabled apenas se o checkbox correspondente
1923:         *-- estiver marcado E o form estiver habilitado
1924:         THIS.cnt_4c_OpConta.Enabled   = loc_lHab AND (THIS.chk_4c_Conta.Value     = 1)
1925:         THIS.cnt_4c_OpEstoque.Enabled = loc_lHab AND (THIS.chk_4c_Estoque.Value   = 1)
1926:         THIS.cnt_4c_OpCusto.Enabled   = loc_lHab AND (THIS.chk_4c_BtnCusto.Value  = 1)
1927:         THIS.cnt_4c_OpCompra.Enabled  = loc_lHab AND (THIS.chk_4c_BtnCompra.Value = 1)
1928: 
1929:         *-- Botoes de acao
1930:         THIS.cmd_4c_Cancela.Enabled  = loc_lHab
1931:         THIS.cmd_4c_Processa.Enabled = loc_lHab AND ( ;
1932:             THIS.chk_4c_Conta.Value = 1 OR THIS.chk_4c_Estoque.Value = 1 OR ;
1933:             THIS.chk_4c_BtnCusto.Value = 1 OR THIS.chk_4c_BtnCompra.Value = 1)
1934: 
1935:         RETURN .T.
1936:     ENDPROC

*-- Linhas 1953 a 1961:
1953:         THIS.cnt_4c_OpCompra.txt_4c_Empresa.Value  = loc_cEmp
1954: 
1955:         THIS.txt_4c_Registro.Value = 0
1956:         THIS.lbl_4c_LblEnd.Visible = .F.
1957: 
1958:         RETURN .T.
1959:     ENDPROC
1960: 
1961:     *==========================================================================

*-- Linhas 1995 a 2014:
1995: 
1996:         DO CASE
1997:             CASE loc_cModo = "PROCESSANDO"
1998:                 THIS.cmd_4c_Processa.Enabled = .F.
1999:                 THIS.cmd_4c_Cancela.Enabled  = .F.
2000:                 THIS.HabilitarCampos(.F.)
2001:             CASE loc_cModo = "CONCLUIDO"
2002:                 THIS.cmd_4c_Processa.Enabled = .F.
2003:                 THIS.cmd_4c_Cancela.Enabled  = .T.
2004:                 THIS.lbl_4c_LblEnd.Visible   = .T.
2005:                 THIS.HabilitarCampos(.F.)
2006:             OTHERWISE
2007:                 *-- INICIAL: aguardando selecao
2008:                 THIS.cmd_4c_Cancela.Enabled  = .T.
2009:                 THIS.lbl_4c_LblEnd.Visible   = .F.
2010:                 THIS.HabilitarCampos(.T.)
2011:                 THIS.AtualizarEstadoProcessa()
2012:         ENDCASE
2013: 
2014:         RETURN .T.


### BO (C:\4c\projeto\app\classes\SigPrCccBO.prg):
*==============================================================================
* SigPrCccBO.prg - Business Object para Recalculo de Saldos
* Herda de BusinessBase
* Tabela principal: SigOpClU (Ultima Compra por Cliente/Produto)
* Fases 1-2/8: Propriedades, Init e metodos de recalculo completos
*==============================================================================

DEFINE CLASS SigPrCccBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da entidade
    *--------------------------------------------------------------------------
    this_cTabela     = "SigOpClU"
    this_cCampoChave = "CidChaves"

    *--------------------------------------------------------------------------
    * Secao Conta Corrente (OpConta) - recalcula SigMvCcr
    *--------------------------------------------------------------------------
    this_cEmpConta    = ""    && Get_Empresa C(3)  - empresa filtro
    this_cGrupoConta  = ""    && txtGrupos   C(10) - grupo de conta
    this_cConta       = ""    && txtContas   C(10) - conta corrente
    this_cMoedaConta  = ""    && txtMoedas   C(3)  - moeda
    this_dDataConta   = {}    && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Secao Estoque (OpEstoque) - recalcula SigMvHst
    *--------------------------------------------------------------------------
    this_cEmpEst      = ""    && Get_Empresa C(3)  - empresa filtro
    this_cGrupoEst    = ""    && txtGrupos   C(10) - grupo do deposito
    this_cEstoque     = ""    && Get_Estoque C(10) - codigo do deposito/estoque
    this_cProdEst     = ""    && Get_Produto C(14) - codigo do produto
    this_cDescProdEst = ""    && Get_Descs   C(40) - descricao do produto
    this_dDataEst     = {}    && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Secao Custo de Produto (OpCusto) - recalcula custo em SigCdPro
    *--------------------------------------------------------------------------
    this_cEmpCusto      = ""  && Get_Empresa C(3)  - empresa filtro
    this_cProdCusto     = ""  && Get_Produto C(14) - codigo do produto
    this_cDescProdCusto = ""  && Get_Descs   C(40) - descricao do produto
    this_dDataCusto     = {}  && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Secao Ultima Compra (OpCompra) - atualiza SigOpClU, SigCdCli, SigCdPro
    *--------------------------------------------------------------------------
    this_cEmpCompra      = "" && Get_Empresa C(3)  - empresa filtro
    this_cProdCompra     = "" && Get_Produto C(14) - codigo do produto
    this_cDescProdCompra = "" && Get_Descs   C(40) - descricao do produto
    this_dDataCompra     = {} && txtData     D     - data a partir de

    *--------------------------------------------------------------------------
    * Parametros do sistema (carregados de SigCdPam em InicializarDados)
    *--------------------------------------------------------------------------
    this_cMoeCentral  = ""    && MoeCentral  C(3)  - moeda central para cotacao
    this_cGrupoRecs   = ""    && GrupoRecs   C(10) - grupo recebimentos C.C.
    this_cGrupoPags   = ""    && GrupoPags   C(10) - grupo pagamentos C.C.
    this_cContaRecs   = ""    && ContaRecs   C(10) - conta recebimentos C.C.
    this_cContaPags   = ""    && ContaPags   C(10) - conta pagamentos C.C.

    *--------------------------------------------------------------------------
    * Estado do processamento
    *--------------------------------------------------------------------------
    this_nRegistros   = 0     && Get_Registro N    - contador de registros processados
    this_lProcessando = .F.   && .T. enquanto Processa.Click estiver rodando

    *--------------------------------------------------------------------------
    * Propriedades de linha - SigOpClU (CRUD)
    *--------------------------------------------------------------------------
    this_cChaves     = ""    && cidchaves  C(20) PK
    this_cCpros      = ""    && cpros      C(14)
    this_dDatas      = {}    && datas      datetime
    this_cDopes      = ""    && dopes      C(20)
    this_cEmpDopNums = ""    && empdopnums C(29)
    this_cEmps       = ""    && emps       C(3)
    this_cIclis      = ""    && iclis      C(10)
    this_cMoedas     = ""    && moedas     C(3)
    this_nNumes      = 0     && numes      N(6,0)
    this_nValors     = 0     && valors     N(13,2)
    this_nQtds       = 0     && qtds       N(12,0)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigOpClU"
            THIS.this_cCampoChave = "CidChaves"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarDados - carrega parametros de SigCdPam no BO
    *==========================================================================
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT GrupoRecs, GrupoPags, ContaRecs, ContaPags, MoeCentral " + ;
                       "FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                    SELECT cursor_4c_Pam
                    THIS.this_cGrupoRecs  = NVL(GrupoRecs,  "")
                    THIS.this_cGrupoPags  = NVL(GrupoPags,  "")
                    THIS.this_cContaRecs  = NVL(ContaRecs,  "")
                    THIS.this_cContaPags  = NVL(ContaPags,  "")
                    THIS.this_cMoeCentral = NVL(MoeCentral, "")
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar par" + CHR(226) + "metros de SigCdPam.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - carrega colunas de SigOpClU do cursor informado
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cChaves     = NVL(cidchaves,  SPACE(20))
            THIS.this_cCpros      = NVL(cpros,      SPACE(14))
            THIS.this_dDatas      = NVL(datas,      {})
            THIS.this_cDopes      = NVL(dopes,      SPACE(20))
            THIS.this_cEmpDopNums = NVL(empdopnums, SPACE(29))
            THIS.this_cEmps       = NVL(emps,       SPACE(3))
            THIS.this_cIclis      = NVL(iclis,      SPACE(10))
            THIS.this_cMoedas     = NVL(moedas,     SPACE(3))
            THIS.this_nNumes      = NVL(numes,      0)
            THIS.this_nValors     = NVL(valors,     0)
            THIS.this_nQtds       = NVL(qtds,       0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Inserir - insere um registro em SigOpClU
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            THIS.this_cChaves = SYS(2015) + SYS(2015)

            loc_cSQL = "INSERT INTO SigOpClU " + ;
                "(cidchaves, cpros, datas, dopes, empdopnums, " + ;
                " emps, iclis, moedas, numes, valors, qtds) " + ;
                "VALUES (" + ;
                EscaparSQL(LEFT(THIS.this_cChaves, 20))     + ", " + ;
                EscaparSQL(LEFT(THIS.this_cCpros, 14))      + ", " + ;
                FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                EscaparSQL(LEFT(THIS.this_cDopes, 20))      + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmps, 3))        + ", " + ;
                EscaparSQL(LEFT(THIS.this_cIclis, 10))      + ", " + ;
                EscaparSQL(LEFT(THIS.this_cMoedas, 3))      + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumes, 0)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nValors, 2)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtds, 0)       + ")"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro em SigOpClU.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - atualiza registro em SigOpClU pela chave cidchaves
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigOpClU SET " + ;
                "cpros      = " + EscaparSQL(LEFT(THIS.this_cCpros, 14))      + ", " + ;
                "datas      = " + FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                "dopes      = " + EscaparSQL(LEFT(THIS.this_cDopes, 20))      + ", " + ;
                "empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                "emps       = " + EscaparSQL(LEFT(THIS.this_cEmps, 3))        + ", " + ;
                "iclis      = " + EscaparSQL(LEFT(THIS.this_cIclis, 10))      + ", " + ;
                "moedas     = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3))      + ", " + ;
                "numes      = " + FormatarNumeroSQL(THIS.this_nNumes, 0)      + ", " + ;
                "valors     = " + FormatarNumeroSQL(THIS.this_nValors, 2)     + ", " + ;
                "qtds       = " + FormatarNumeroSQL(THIS.this_nQtds, 0)       + " " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cChaves)

            IF SQLEXEC(gnConnHandle, m.loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro em SigOpClU.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna cidchaves do registro atual (para auditoria)
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cChaves
    ENDPROC

    *==========================================================================
    * RecalcularSaldosConta - recalcula saldos em SigMvCcr
    * Processa movimentos em ordem cronologica e atualiza saldos acumulados
    *==========================================================================
    PROCEDURE RecalcularSaldosConta()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere
        LOCAL loc_nSaldo, loc_nRecs, loc_cKeyAnt, loc_cKey

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = ""
            IF !EMPTY(THIS.this_cEmpConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "emps = " + EscaparSQL(THIS.this_cEmpConta)
            ENDIF
            IF !EMPTY(THIS.this_cGrupoConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "grupos = " + EscaparSQL(THIS.this_cGrupoConta)
            ENDIF
            IF !EMPTY(THIS.this_cConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "contas = " + EscaparSQL(THIS.this_cConta)
            ENDIF
            IF !EMPTY(THIS.this_cMoedaConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "moedas = " + EscaparSQL(THIS.this_cMoedaConta)
            ENDIF
            IF !EMPTY(THIS.this_dDataConta)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "datas >= " + FormatarDataSQL(THIS.this_dDataConta)
            ENDIF

            loc_cSQL = "SELECT cidchaves, emps, grupos, contas, moedas, " + ;
                       "       datas, numes, opers, valors " + ;
                       "FROM SigMvCcr" + m.loc_cWhere + ;
                       " ORDER BY emps, grupos, contas, moedas, datas, numes"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CcrRec") > 0
                IF USED("cursor_4c_CcrRec") AND RECCOUNT("cursor_4c_CcrRec") > 0
                    loc_nSaldo  = 0
                    loc_cKeyAnt = ""
                    SELECT cursor_4c_CcrRec
                    SCAN
                        loc_cKey = ALLTRIM(emps) + ALLTRIM(grupos) + ALLTRIM(contas) + ALLTRIM(moedas)
                        IF loc_cKey != loc_cKeyAnt
                            loc_nSaldo  = 0
                            loc_cKeyAnt = loc_cKey
                        ENDIF
                        IF UPPER(ALLTRIM(opers)) = "E"
                            loc_nSaldo = loc_nSaldo + valors
                        ELSE
                            loc_nSaldo = loc_nSaldo - valors
                        ENDIF
                        loc_cSQL = "UPDATE SigMvCcr SET saldos = " + ;
                                   FormatarNumeroSQL(m.loc_nSaldo, 2) + ;
                                   " WHERE cidchaves = " + EscaparSQL(cidchaves)
                        SQLEXEC(gnConnHandle, m.loc_cSQL)
                        loc_nRecs = loc_nRecs + 1
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_CcrRec")
                    USE IN cursor_4c_CcrRec
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar registros de SigMvCcr.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosConta")
            IF USED("cursor_4c_CcrRec")
                USE IN cursor_4c_CcrRec
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularSaldosEstoque - recalcula sqtds em SigMvHst
    * Processa movimentos em ordem e atualiza saldo acumulado de quantidade
    *==========================================================================
    PROCEDURE RecalcularSaldosEstoque()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere
        LOCAL loc_nSqtds, loc_nRecs, loc_cKeyAnt, loc_cKey

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = ""
            IF !EMPTY(THIS.this_cEmpEst)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "emps = " + EscaparSQL(THIS.this_cEmpEst)
            ENDIF
            IF !EMPTY(THIS.this_cGrupoEst)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "grupos = " + EscaparSQL(THIS.this_cGrupoEst)
            ENDIF
            IF !EMPTY(THIS.this_cProdEst)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "cpros = " + EscaparSQL(THIS.this_cProdEst)
            ENDIF
            IF !EMPTY(THIS.this_dDataEst)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "datas >= " + FormatarDataSQL(THIS.this_dDataEst)
            ENDIF

            loc_cSQL = "SELECT cidchaves, cpros, emps, grupos, estos, " + ;
                       "       datas, numes, opers, qtds, sqtds " + ;
                       "FROM SigMvHst" + m.loc_cWhere + ;
                       " ORDER BY cpros, emps, grupos, estos, datas, numes"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_HstRec") > 0
                IF USED("cursor_4c_HstRec") AND RECCOUNT("cursor_4c_HstRec") > 0
                    loc_nSqtds  = 0
                    loc_cKeyAnt = ""
                    SELECT cursor_4c_HstRec
                    SCAN
                        loc_cKey = ALLTRIM(cpros) + ALLTRIM(emps) + ALLTRIM(grupos) + ALLTRIM(estos)
                        IF loc_cKey != loc_cKeyAnt
                            loc_nSqtds  = 0
                            loc_cKeyAnt = loc_cKey
                        ENDIF
                        IF UPPER(ALLTRIM(opers)) = "E"
                            loc_nSqtds = loc_nSqtds + qtds
                        ELSE
                            loc_nSqtds = loc_nSqtds - qtds
                        ENDIF
                        loc_cSQL = "UPDATE SigMvHst SET sqtds = " + ;
                                   FormatarNumeroSQL(m.loc_nSqtds, 3) + ;
                                   " WHERE cidchaves = " + EscaparSQL(cidchaves)
                        SQLEXEC(gnConnHandle, m.loc_cSQL)
                        loc_nRecs = loc_nRecs + 1
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_HstRec")
                    USE IN cursor_4c_HstRec
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar registros de SigMvHst.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosEstoque")
            IF USED("cursor_4c_HstRec")
                USE IN cursor_4c_HstRec
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularSaldosCusto - recalcula custofs em SigCdPro
    * Media ponderada de custo a partir dos movimentos de entrada em SigMvHst
    *==========================================================================
    PROCEDURE RecalcularSaldosCusto()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nRecs

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = ""
            IF !EMPTY(THIS.this_cEmpCusto)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "emps = " + EscaparSQL(THIS.this_cEmpCusto)
            ENDIF
            IF !EMPTY(THIS.this_cProdCusto)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "cpros = " + EscaparSQL(THIS.this_cProdCusto)
            ENDIF
            IF !EMPTY(THIS.this_dDataCusto)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "datas >= " + FormatarDataSQL(THIS.this_dDataCusto)
            ENDIF

            loc_cSQL = "SELECT cpros, " + ;
                       "       SUM(qtds * units) / NULLIF(SUM(qtds), 0) AS custofsMedio " + ;
                       "FROM SigMvHst" + m.loc_cWhere + ;
                       " GROUP BY cpros"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CustoRec") > 0
                IF USED("cursor_4c_CustoRec") AND RECCOUNT("cursor_4c_CustoRec") > 0
                    SELECT cursor_4c_CustoRec
                    SCAN
                        IF !ISNULL(custofsMedio)
                            loc_cSQL = "UPDATE SigCdPro SET custofs = " + ;
                                       FormatarNumeroSQL(custofsMedio, 3) + ;
                                       " WHERE cpros = " + EscaparSQL(cpros)
                            SQLEXEC(gnConnHandle, m.loc_cSQL)
                            loc_nRecs = loc_nRecs + 1
                        ENDIF
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_CustoRec")
                    USE IN cursor_4c_CustoRec
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao calcular custo de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosCusto")
            IF USED("cursor_4c_CustoRec")
                USE IN cursor_4c_CustoRec
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularSaldosCompra - atualiza SigOpClU com ultima compra por produto
    * Localiza a entrada mais recente em SigMvHst e atualiza SigOpClU
    *==========================================================================
    PROCEDURE RecalcularSaldosCompra()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nRecs
        LOCAL loc_cChkSQL, loc_cUpSQL, loc_cPros, loc_cEmps

        loc_lSucesso = .F.
        loc_nRecs    = 0

        TRY
            loc_cWhere = ""
            IF !EMPTY(THIS.this_cEmpCompra)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "emps = " + EscaparSQL(THIS.this_cEmpCompra)
            ENDIF
            IF !EMPTY(THIS.this_cProdCompra)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "cpros = " + EscaparSQL(THIS.this_cProdCompra)
            ENDIF
            IF !EMPTY(THIS.this_dDataCompra)
                loc_cWhere = loc_cWhere + IIF(EMPTY(m.loc_cWhere), " WHERE ", " AND ") + "datas >= " + FormatarDataSQL(THIS.this_dDataCompra)
            ENDIF

            loc_cSQL = "SELECT cpros, emps, " + ;
                       "       MAX(datas) AS ultimaData, " + ;
                       "       MAX(numes) AS ultimoNume " + ;
                       "FROM SigMvHst" + m.loc_cWhere + ;
                       " GROUP BY cpros, emps"

            IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CompraGrp") > 0
                IF USED("cursor_4c_CompraGrp") AND RECCOUNT("cursor_4c_CompraGrp") > 0
                    SELECT cursor_4c_CompraGrp
                    SCAN
                        loc_cPros = ALLTRIM(cpros)
                        loc_cEmps = ALLTRIM(emps)

                        *-- Busca detalhe do movimento mais recente
                        loc_cSQL = "SELECT TOP 1 cidchaves, cpros, emps, datas, numes, " + ;
                                   "            valors, qtds, moedas, dopes, empdopnums " + ;
                                   "FROM SigMvHst " + ;
                                   "WHERE cpros = " + EscaparSQL(m.loc_cPros) + ;
                                   "  AND emps = "  + EscaparSQL(m.loc_cEmps) + ;
                                   " ORDER BY datas DESC, numes DESC"

                        IF SQLEXEC(gnConnHandle, m.loc_cSQL, "cursor_4c_CompraUlt") > 0
                            IF USED("cursor_4c_CompraUlt") AND RECCOUNT("cursor_4c_CompraUlt") > 0
                                SELECT cursor_4c_CompraUlt

                                *-- Verificar se ja existe registro em SigOpClU
                                loc_cChkSQL = "SELECT cidchaves FROM SigOpClU " + ;
                                              "WHERE cpros = " + EscaparSQL(m.loc_cPros) + ;
                                              "  AND emps = "  + EscaparSQL(m.loc_cEmps)
                                IF SQLEXEC(gnConnHandle, m.loc_cChkSQL, "cursor_4c_CompraChk") > 0
                                    IF USED("cursor_4c_CompraChk") AND RECCOUNT("cursor_4c_CompraChk") > 0
                                        *-- UPDATE
                                        SELECT cursor_4c_CompraUlt
                                        loc_cUpSQL = "UPDATE SigOpClU SET " + ;
                                            "datas      = " + FormatarDataSQL(datas)          + ", " + ;
                                            "numes      = " + FormatarNumeroSQL(numes, 0)     + ", " + ;
                                            "valors     = " + FormatarNumeroSQL(valors, 2)    + ", " + ;
                                            "qtds       = " + FormatarNumeroSQL(qtds, 0)      + ", " + ;
                                            "moedas     = " + EscaparSQL(LEFT(moedas, 3))     + ", " + ;
                                            "dopes      = " + EscaparSQL(LEFT(dopes, 20))     + ", " + ;
                                            "empdopnums = " + EscaparSQL(LEFT(empdopnums, 29))+ " " + ;
                                            "WHERE cpros = " + EscaparSQL(m.loc_cPros) + ;
                                            "  AND emps = "  + EscaparSQL(m.loc_cEmps)
                                        SQLEXEC(gnConnHandle, m.loc_cUpSQL)
                                    ELSE
                                        *-- INSERT novo
                                        SELECT cursor_4c_CompraUlt
                                        THIS.this_cCpros      = LEFT(cpros, 14)
                                        THIS.this_cEmps       = LEFT(emps, 3)
                                        THIS.this_dDatas      = datas
                                        THIS.this_nNumes      = numes
                                        THIS.this_nValors     = valors
                                        THIS.this_nQtds       = qtds
                                        THIS.this_cMoedas     = LEFT(moedas, 3)
                                        THIS.this_cDopes      = LEFT(dopes, 20)
                                        THIS.this_cEmpDopNums = LEFT(empdopnums, 29)
                                        THIS.this_cIclis      = SPACE(10)
                                        THIS.Inserir()
                                    ENDIF
                                    IF USED("cursor_4c_CompraChk")
                                        USE IN cursor_4c_CompraChk
                                    ENDIF
                                    loc_nRecs = loc_nRecs + 1
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_CompraUlt")
                                USE IN cursor_4c_CompraUlt
                            ENDIF
                        ENDIF
                    ENDSCAN
                    THIS.this_nRegistros = THIS.this_nRegistros + loc_nRecs
                ENDIF
                IF USED("cursor_4c_CompraGrp")
                    USE IN cursor_4c_CompraGrp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar movimentos de compra.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCccBO.RecalcularSaldosCompra")
            IF USED("cursor_4c_CompraGrp")
                USE IN cursor_4c_CompraGrp
            ENDIF
            IF USED("cursor_4c_CompraUlt")
                USE IN cursor_4c_CompraUlt
            ENDIF
            IF USED("cursor_4c_CompraChk")
                USE IN cursor_4c_CompraChk
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

