# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCNB.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2225 linhas total):

*-- Linhas 36 a 46:
36: * (THIS.ProcessarTitulos(), transcrito de PROCEDURE processamento do
37: * legado), Encerrar, Marcar/Desmarcar Tudo (Page1), e o "round-trip" da
38: * Page2: grade de titulos (grd_4c_Titulos, 8 colunas + DynamicForeColor
39: * para EndErro), Marcar/Desmarcar Tudo dos titulos, checkbox individual
40: * (guard EndErro=1, equivalente ao Column1.Check1.When do legado) e Voltar
41: * (cmd_4c_Encerrar de Page2, que reaproveita o Caption/Picture "Encerrar"
42: * do legado mas volta para o filtro, nao fecha o form). O aviso de
43: * endereco longo (Say2/Botao1) foi reposicionado para LOGO ABAIXO do grupo
44: * "Protestar apos" (regra #11/#39 - a faixa do cabecalho ocupa o lugar que
45: * ele tinha no legado).
46: *

*-- Linhas 138 a 156:
138:         loc_oPgf = THIS.pgf_4c_Paginas
139: 
140:         loc_oPgf.PageCount = 2
141:         loc_oPgf.Top       = -29
142:         loc_oPgf.Left      = 0
143:         loc_oPgf.Width     = THIS.Width
144:         loc_oPgf.Height    = THIS.Height + 29
145:         loc_oPgf.TabIndex  = 1
146:         loc_oPgf.Tabs      = .F.
147: 
148:         loc_oPgf.Page1.Caption = "Filtro"
149:         loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
150: 
151:         loc_oPgf.Page2.Caption = "Dados"
152:         loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
153: 
154:         loc_oPgf.Visible    = .T.
155:         loc_oPgf.ActivePage = 1
156:     ENDPROC

*-- Linhas 173 a 602:
173:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
174:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
175:         WITH loc_oCab
176:             .Top           = 29
177:             .Left          = 0
178:             .Width         = THIS.Width
179:             .Height        = 80
180:             .BorderWidth   = 0
181:             .SpecialEffect = 0
182:             .BackColor     = RGB(100,100,100)
183: 
184:             .AddObject("lbl_4c_Sombra", "Label")
185:             WITH .lbl_4c_Sombra
186:                 .Top       = 15
187:                 .Left      = 10
188:                 .Width     = THIS.Width
189:                 .Height    = 40
190:                 .FontName  = "Tahoma"
191:                 .FontSize  = 16
192:                 .FontBold  = .T.
193:                 .WordWrap  = .T.
194:                 .Alignment = 0
195:                 .BackStyle = 0
196:                 .ForeColor = RGB(0,0,0)
197:                 .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
198:             ENDWITH
199: 
200:             .AddObject("lbl_4c_Titulo", "Label")
201:             WITH .lbl_4c_Titulo
202:                 .Top       = 18
203:                 .Left      = 10
204:                 .Width     = THIS.Width
205:                 .Height    = 46
206:                 .FontName  = "Tahoma"
207:                 .FontSize  = 16
208:                 .FontBold  = .T.
209:                 .WordWrap  = .T.
210:                 .Alignment = 0
211:                 .BackStyle = 0
212:                 .ForeColor = RGB(255,255,255)
213:                 .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
214:             ENDWITH
215:         ENDWITH
216: 
217:         *-- Container de botoes (Processar/Encerrar - cmdTestaPos no legado)
218:         loc_oPag.AddObject("cnt_4c_Botoes", "Container")
219:         WITH loc_oPag.cnt_4c_Botoes
220:             .Top         = 27
221:             .Left        =  542
222:             .Width       = 160
223:             .Height      = 85
224:             .BackStyle   = 0
225:             .BorderWidth = 0
226: 
227:             *-- cmd_4c_Processar (Command1/btnProcessar no legado)
228:             .AddObject("cmd_4c_Processar", "CommandButton")
229:             WITH .cmd_4c_Processar
230:                 .Top             = 5
231:                 .Left            = 5
232:                 .Width           = 75
233:                 .Height          = 75
234:                 .FontName        = "Comic Sans MS"
235:                 .FontSize        = 8
236:                 .FontBold        = .T.
237:                 .FontItalic      = .T.
238:                 .WordWrap        = .T.
239:                 .Alignment       = 2
240:                 .PicturePosition = 13
241:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
242:                 .Caption         = "Processar"
243:                 .ToolTipText     = "Processar"
244:                 .MousePointer    = 15
245:                 .SpecialEffect   = 0
246:                 .ForeColor       = RGB(90,90,90)
247:                 .BackColor       = RGB(255,255,255)
248:             ENDWITH
249: 
250:             *-- cmd_4c_Encerrar (Command2/btnsair no legado)
251:             .AddObject("cmd_4c_Encerrar", "CommandButton")
252:             WITH .cmd_4c_Encerrar
253:                 .Top             = 5
254:                 .Left = 5
255:                 .Width           = 75
256:                 .Height          = 75
257:                 .FontName        = "Comic Sans MS"
258:                 .FontSize        = 8
259:                 .FontBold        = .T.
260:                 .FontItalic      = .T.
261:                 .WordWrap        = .T.
262:                 .Alignment       = 2
263:                 .PicturePosition = 13
264:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
265:                 .Cancel          = .T.
266:                 .Caption         = "Encerrar"
267:                 .ToolTipText     = "[ESC] Encerrar"
268:                 .MousePointer    = 15
269:                 .SpecialEffect   = 0
270:                 .ForeColor       = RGB(90,90,90)
271:                 .BackColor       = RGB(255,255,255)
272:                 .Themes          = .F.
273:             ENDWITH
274:         ENDWITH
275: 
276:         *-- Container Marcar/Desmarcar Tudo (Commandgroup2/btnmarca+btndesmarca no legado)
277:         loc_oPag.AddObject("cnt_4c_Marca", "Container")
278:         WITH loc_oPag.cnt_4c_Marca
279:             .Top         = 344
280:             .Left        = 563
281:             .Width       = 50
282:             .Height      = 91
283:             .BackStyle   = 0
284:             .BorderWidth = 0
285: 
286:             .AddObject("cmd_4c_MarcarTudo", "CommandButton")
287:             WITH .cmd_4c_MarcarTudo
288:                 .Top           = 5
289:                 .Left          = 5
290:                 .Width         = 40
291:                 .Height        = 40
292:                 .FontName      = "Verdana"
293:                 .FontSize      = 7
294:                 .Picture       = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
295:                 .Caption       = ""
296:                 .ToolTipText   = "Marcar tudo"
297:                 .ForeColor     = RGB(36,84,155)
298:                 .BackColor     = RGB(255,255,255)
299:             ENDWITH
300: 
301:             .AddObject("cmd_4c_DesmarcarTudo", "CommandButton")
302:             WITH .cmd_4c_DesmarcarTudo
303:                 .Top           = 46
304:                 .Left          = 5
305:                 .Width         = 40
306:                 .Height        = 40
307:                 .FontName      = "Verdana"
308:                 .FontSize      = 8
309:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
310:                 .Caption       = ""
311:                 .ToolTipText   = "Desmarcar tudo"
312:                 .ForeColor     = RGB(36,84,155)
313:                 .BackColor     = RGB(255,255,255)
314:                 .Themes        = .F.
315:             ENDWITH
316:         ENDWITH
317: 
318:         *-- Grupo "Operacoes :" (Label1) + filtro Processados/Ja Processadas
319:         *-- (optProcessados no legado, Top=95 -> 124 com compensacao +29).
320:         loc_oPag.AddObject("lbl_4c_Operacoes", "Label")
321:         WITH loc_oPag.lbl_4c_Operacoes
322:             .Top       = 125
323:             .Left      = 279
324:             .Width     = 68
325:             .Height    = 15
326:             .FontName  = "Tahoma"
327:             .FontSize  = 8
328:             .FontBold  = .T.
329:             .AutoSize  = .F.
330:             .Alignment = 0
331:             .BackStyle = 0
332:             .ForeColor = RGB(90,90,90)
333:             .Caption   = "Opera" + CHR(231) + CHR(245) + "es :"
334:         ENDWITH
335: 
336:         loc_oPag.AddObject("obj_4c_Processados", "OptionGroup")
337:         WITH loc_oPag.obj_4c_Processados
338:             .Top         = 124
339:             .Left        = 344
340:             .Width       = 235
341:             .Height      = 19
342:             .BackStyle   = 0
343:             .BorderStyle = 0
344:             .ButtonCount = 2
345:             .Value       = 1
346: 
347:             WITH .Buttons(1)
348:                 .FontName  = "Tahoma"
349:                 .FontSize  = 8
350:                 .BackStyle = 0
351:                 .Caption   = "N" + CHR(227) + "o Processadas"
352:                 .ForeColor = RGB(90,90,90)
353:                 .Left      = 5
354:                 .Top       = 2
355:                 .AutoSize  = .T.
356:                 .Themes    = .F.
357:             ENDWITH
358: 
359:             WITH .Buttons(2)
360:                 .FontName  = "Tahoma"
361:                 .FontSize  = 8
362:                 .BackStyle = 0
363:                 .Caption   = "J" + CHR(225) + " Processadas"
364:                 .ForeColor = RGB(90,90,90)
365:                 .Left      = 126
366:                 .Top       = 2
367:                 .AutoSize  = .T.
368:                 .Themes    = .F.
369:             ENDWITH
370:         ENDWITH
371: 
372:         *-- Empresa (Say4 + get_cd_empresa + get_ds_empresa no legado)
373:         loc_oPag.AddObject("lbl_4c_Empresa", "Label")
374:         WITH loc_oPag.lbl_4c_Empresa
375:             .Top       = 152
376:             .Left      = 297
377:             .Width     = 50
378:             .Height    = 15
379:             .FontName  = "Tahoma"
380:             .FontSize  = 8
381:             .AutoSize  = .F.
382:             .Alignment = 0
383:             .BackStyle = 0
384:             .ForeColor = RGB(90,90,90)
385:             .Caption   = "Empresa :"
386:         ENDWITH
387: 
388:         loc_oPag.AddObject("txt_4c_CodEmpresa", "TextBox")
389:         WITH loc_oPag.txt_4c_CodEmpresa
390:             .Top           = 149
391:             .Left          = 349
392:             .Width         = 31
393:             .Height        = 23
394:             .FontName      = "Tahoma"
395:             .FontSize      = 8
396:             .Format        = "K"
397:             .MaxLength     = 3
398:             .SpecialEffect = 1
399:             .Value         = ""
400:         ENDWITH
401: 
402:         loc_oPag.AddObject("txt_4c_NomeEmpresa", "TextBox")
403:         WITH loc_oPag.txt_4c_NomeEmpresa
404:             .Top           = 149
405:             .Left          = 383
406:             .Width         = 290
407:             .Height        = 23
408:             .FontName      = "Tahoma"
409:             .FontSize      = 8
410:             .Format        = "K"
411:             .MaxLength     = 40
412:             .SpecialEffect = 1
413:             .Value         = ""
414:         ENDWITH
415: 
416:         *-- Periodo (Say3 + Get_Datai + Say6 "ate" + Get_Dataf + optPeriodo)
417:         loc_oPag.AddObject("lbl_4c_Periodo", "Label")
418:         WITH loc_oPag.lbl_4c_Periodo
419:             .Top       = 180
420:             .Left      = 302
421:             .Width     = 45
422:             .Height    = 15
423:             .FontName  = "Tahoma"
424:             .FontSize  = 8
425:             .AutoSize  = .F.
426:             .Alignment = 0
427:             .BackStyle = 0
428:             .ForeColor = RGB(90,90,90)
429:             .Caption   = "Per" + CHR(237) + "odo :"
430:         ENDWITH
431: 
432:         loc_oPag.AddObject("txt_4c_DataInicial", "TextBox")
433:         WITH loc_oPag.txt_4c_DataInicial
434:             .Top           = 177
435:             .Left          = 349
436:             .Width         = 80
437:             .Height        = 23
438:             .FontName      = "Tahoma"
439:             .FontSize      = 8
440:             .Alignment     = 3
441:             .SpecialEffect = 1
442:             .Value         = {}
443:         ENDWITH
444: 
445:         loc_oPag.AddObject("lbl_4c_Ate", "Label")
446:         WITH loc_oPag.lbl_4c_Ate
447:             .Top       = 180
448:             .Left      = 434
449:             .Width     = 20
450:             .Height    = 15
451:             .FontName  = "Tahoma"
452:             .FontSize  = 8
453:             .AutoSize  = .F.
454:             .Alignment = 0
455:             .BackStyle = 0
456:             .ForeColor = RGB(90,90,90)
457:             .Caption   = "at" + CHR(233)
458:         ENDWITH
459: 
460:         loc_oPag.AddObject("txt_4c_DataFinal", "TextBox")
461:         WITH loc_oPag.txt_4c_DataFinal
462:             .Top           = 177
463:             .Left          = 457
464:             .Width         = 80
465:             .Height        = 23
466:             .FontName      = "Tahoma"
467:             .FontSize      = 8
468:             .Alignment     = 3
469:             .SpecialEffect = 1
470:             .Value         = {}
471:         ENDWITH
472: 
473:         loc_oPag.AddObject("obj_4c_Periodo", "OptionGroup")
474:         WITH loc_oPag.obj_4c_Periodo
475:             .Top         = 175
476:             .Left        = 544
477:             .Width       = 168
478:             .Height      = 25
479:             .BackStyle   = 0
480:             .BorderStyle = 0
481:             .ButtonCount = 2
482:             .Value       = 1
483: 
484:             WITH .Buttons(1)
485:                 .FontName  = "Tahoma"
486:                 .FontSize  = 8
487:                 .BackStyle = 0
488:                 .Caption   = "Vencimento"
489:                 .ForeColor = RGB(90,90,90)
490:                 .Left      = 5
491:                 .Top       = 5
492:                 .Width     = 73
493:                 .Height    = 15
494:                 .AutoSize  = .T.
495:                 .Themes    = .F.
496:             ENDWITH
497: 
498:             WITH .Buttons(2)
499:                 .FontName  = "Tahoma"
500:                 .FontSize  = 8
501:                 .BackStyle = 0
502:                 .Caption   = "Emiss" + CHR(227) + "o"
503:                 .ForeColor = RGB(90,90,90)
504:                 .Left      = 96
505:                 .Top       = 5
506:                 .AutoSize  = .T.
507:                 .Themes    = .F.
508:             ENDWITH
509:         ENDWITH
510: 
511:         *-- Banco/Conta (Say2 + get_cd_car_conta + get_ds_car_conta)
512:         loc_oPag.AddObject("lbl_4c_Banco", "Label")
513:         WITH loc_oPag.lbl_4c_Banco
514:             .Top       = 209
515:             .Left      = 309
516:             .Width     = 38
517:             .Height    = 15
518:             .FontName  = "Tahoma"
519:             .FontSize  = 8
520:             .AutoSize  = .F.
521:             .Alignment = 0
522:             .BackStyle = 0
523:             .ForeColor = RGB(90,90,90)
524:             .Caption   = "Banco :"
525:         ENDWITH
526: 
527:         loc_oPag.AddObject("txt_4c_CodConta", "TextBox")
528:         WITH loc_oPag.txt_4c_CodConta
529:             .Top           = 205
530:             .Left          = 349
531:             .Width         = 79
532:             .Height        = 23
533:             .FontName      = "Tahoma"
534:             .FontSize      = 8
535:             .Format        = "K"
536:             .MaxLength     = 10
537:             .SpecialEffect = 1
538:             .Value         = ""
539:         ENDWITH
540: 
541:         loc_oPag.AddObject("txt_4c_NomeConta", "TextBox")
542:         WITH loc_oPag.txt_4c_NomeConta
543:             .Top           = 205
544:             .Left          = 430
545:             .Width         = 290
546:             .Height        = 23
547:             .FontName      = "Tahoma"
548:             .FontSize      = 8
549:             .Format        = "K"
550:             .MaxLength     = 40
551:             .SpecialEffect = 1
552:             .Value         = ""
553:         ENDWITH
554: 
555:         *-- Titulo Banco (Say12 + Get_titban -> lookup em SigOpFp.Fpags)
556:         loc_oPag.AddObject("lbl_4c_TituloBanco", "Label")
557:         WITH loc_oPag.lbl_4c_TituloBanco
558:             .Top       = 235
559:             .Left      = 280
560:             .Width     = 70
561:             .Height    = 15
562:             .FontName  = "Tahoma"
563:             .FontSize  = 8
564:             .AutoSize  = .F.
565:             .Alignment = 0
566:             .BackStyle = 0
567:             .ForeColor = RGB(90,90,90)
568:             .Caption   = "T" + CHR(237) + "tulo Banco : "
569:         ENDWITH
570: 
571:         loc_oPag.AddObject("txt_4c_TituloBanco", "TextBox")
572:         WITH loc_oPag.txt_4c_TituloBanco
573:             .Top           = 232
574:             .Left          = 348
575:             .Width         = 94
576:             .Height        = 23
577:             .FontName      = "Tahoma"
578:             .FontSize      = 8
579:             .MaxLength     = 12
580:             .SpecialEffect = 1
581:             .Value         = ""
582:         ENDWITH
583: 
584:         *-- Label "Operacao :" (Say1), ao lado esquerdo da grade
585:         loc_oPag.AddObject("lbl_4c_Operacao", "Label")
586:         WITH loc_oPag.lbl_4c_Operacao
587:             .Top       = 263
588:             .Left      = 291
589:             .Width     = 55
590:             .Height    = 15
591:             .FontName  = "Tahoma"
592:             .FontSize  = 8
593:             .AutoSize  = .F.
594:             .Alignment = 0
595:             .BackStyle = 0
596:             .ForeColor = RGB(90,90,90)
597:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
598:         ENDWITH
599: 
600:         *-- Cursor placeholder da grade de operacoes (regra #41: o ControlSource
601:         *-- das colunas nao pode apontar para cursor que ainda nao existe).
602:         *-- Estrutura identica a THIS.CarregarOperacoes(), que substitui o

*-- Linhas 620 a 629:
620:         loc_oGrid.RecordSource = "cursor_4c_Operacoes"
621: 
622:         WITH loc_oGrid
623:             .Top               = 261
624:             .Left              = 350
625:             .Width             = 202
626:             .Height            = 344
627:             .FontName          = "Tahoma"
628:             .AllowHeaderSizing = .F.
629:             .AllowRowSizing    = .F.

*-- Linhas 636 a 652:
636: 
637:             *-- Limpa o ControlSource auto-atribuido pelo Grid (por default ele
638:             *-- liga Column1 ao 1o campo do cursor - Dopes, Character) ANTES de
639:             *-- adicionar o CheckBox, senao o VFP tenta sincronizar o .Value do
640:             *-- controle novo com um campo Character e estoura "Data type
641:             *-- mismatch" (regra #18: AddObject/CurrentControl SEMPRE antes do
642:             *-- ControlSource definitivo).
643:             .Column1.ControlSource = ""
644:             .Column1.AddObject("chk_4c_Marca", "CheckBox")
645:             .Column1.CurrentControl = "chk_4c_Marca"
646:             WITH .Column1.chk_4c_Marca
647:                 .Caption   = ""
648:                 .BackColor = RGB(255,255,255)
649:             ENDWITH
650: 
651:             .Column1.ControlSource  = "cursor_4c_Operacoes.Marca"
652:             .Column2.ControlSource  = "cursor_4c_Operacoes.Dopes"

*-- Linhas 658 a 673:
658:             .Column1.Resizable      = .F.
659:             .Column1.Sparse         = .F.
660:             .Column1.ReadOnly       = .F.
661:             .Column1.Header1.Caption = ""
662: 
663:             .Column2.Width          = 150
664:             .Column2.Movable        = .F.
665:             .Column2.Resizable      = .F.
666:             .Column2.ReadOnly       = .T.
667:             .Column2.Header1.Alignment = 2
668:             .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
669:         ENDWITH
670:     ENDPROC
671: 
672:     *==========================================================================
673:     * ConfigurarPaginaDados - Estrutura base da Page2 (Dados)

*-- Linhas 691 a 844:
691:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
692:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
693:         WITH loc_oCab
694:             .Top           = 29
695:             .Left          = 0
696:             .Width         = THIS.Width
697:             .Height        = 80
698:             .BorderWidth   = 0
699:             .SpecialEffect = 0
700:             .BackColor     = RGB(100,100,100)
701: 
702:             .AddObject("lbl_4c_Sombra", "Label")
703:             WITH .lbl_4c_Sombra
704:                 .Top       = 15
705:                 .Left      = 10
706:                 .Width     = THIS.Width
707:                 .Height    = 40
708:                 .FontName  = "Tahoma"
709:                 .FontSize  = 16
710:                 .FontBold  = .T.
711:                 .WordWrap  = .T.
712:                 .Alignment = 0
713:                 .BackStyle = 0
714:                 .ForeColor = RGB(0,0,0)
715:                 .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
716:             ENDWITH
717: 
718:             .AddObject("lbl_4c_Titulo", "Label")
719:             WITH .lbl_4c_Titulo
720:                 .Top       = 18
721:                 .Left      = 10
722:                 .Width     = THIS.Width
723:                 .Height    = 46
724:                 .FontName  = "Tahoma"
725:                 .FontSize  = 16
726:                 .FontBold  = .T.
727:                 .WordWrap  = .T.
728:                 .Alignment = 0
729:                 .BackStyle = 0
730:                 .ForeColor = RGB(255,255,255)
731:                 .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
732:             ENDWITH
733:         ENDWITH
734: 
735:         *-- Container de botoes de acao (Encerrar / Gerar CNAB / Relatorio / Boleto)
736:         loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
737:         WITH loc_oPag.cnt_4c_BotoesAcao
738:             .Top         = 27
739:             .Left        = 692
740:             .Width       = 310
741:             .Height      = 85
742:             .BackStyle   = 0
743:             .BorderWidth = 0
744: 
745:             *-- cmd_4c_Encerrar (btnsair/cmdTestaPos no legado) - Caption e
746:             *-- Picture IDENTICOS ao Encerrar da Pagina Lista (mesmo icone
747:             *-- "sair"), mas a acao real eh VOLTAR para o filtro
748:             *-- (thisform.pgfprincipal.ActivePage=1) - o legado usa essa
749:             *-- legenda mesmo a acao nao fechando o form; PILAR 1 manda
750:             *-- preservar, nao "corrigir" para "Voltar".
751:             .AddObject("cmd_4c_Encerrar", "CommandButton")
752:             WITH .cmd_4c_Encerrar
753:                 .Top             = 5
754:                 .Left = 5
755:                 .Width           = 75
756:                 .Height          = 75
757:                 .FontName        = "Comic Sans MS"
758:                 .FontSize        = 8
759:                 .FontBold        = .T.
760:                 .FontItalic      = .T.
761:                 .WordWrap        = .T.
762:                 .Alignment       = 2
763:                 .PicturePosition = 13
764:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
765:                 .Cancel          = .T.
766:                 .Caption         = "Encerrar"
767:                 .ToolTipText     = "[ESC] Encerrar"
768:                 .MousePointer    = 15
769:                 .SpecialEffect   = 0
770:                 .ForeColor       = RGB(90,90,90)
771:                 .BackColor       = RGB(255,255,255)
772:             ENDWITH
773: 
774:             *-- obj_4c_Comandos (Commandgroup1 no legado: Gerar CNAB/Relatorio/
775:             *-- Boleto). Fica a esquerda do Encerrar (Left relativo 0..225),
776:             *-- igual ao legado (Commandgroup1.Left=692 < cmdTestaPos.Left=917).
777:             .AddObject("obj_4c_Comandos", "CommandGroup")
778:             WITH .obj_4c_Comandos
779:                 .Top          = 5
780:                 .Left         = 0
781:                 .Width        = 225
782:                 .Height       = 75
783:                 .BackStyle    = 0
784:                 .ButtonCount  = 3
785: 
786:                 WITH .Buttons(1)
787:                     .Top             = 5
788:                     .Left            = 5
789:                     .Width           = 75
790:                     .Height          = 75
791:                     .FontName        = "Comic Sans MS"
792:                     .FontSize        = 8
793:                     .FontBold        = .T.
794:                     .FontItalic      = .T.
795:                     .WordWrap        = .T.
796:                     .Alignment       = 2
797:                     .PicturePosition = 13
798:                     .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
799:                     .Caption         = "Gerar CNAB"
800:                     .ToolTipText     = "Gerar CNAB"
801:                     .ForeColor       = RGB(90,90,90)
802:                     .BackColor       = RGB(255,255,255)
803:                     .Themes          = .F.
804:                 ENDWITH
805: 
806:                 WITH .Buttons(2)
807:                     .Top             = 5
808:                     .Left            = 80
809:                     .Width           = 75
810:                     .Height          = 75
811:                     .FontName        = "Comic Sans MS"
812:                     .FontSize        = 8
813:                     .FontBold        = .T.
814:                     .FontItalic      = .T.
815:                     .WordWrap        = .T.
816:                     .Alignment       = 2
817:                     .PicturePosition = 13
818:                     .Picture         = gc_4c_CaminhoIcones + "geral_video_60.jpg"
819:                     .Caption         = "Relat" + CHR(243) + "rio"
820:                     .ToolTipText     = "Relat" + CHR(243) + "rio"
821:                     .ForeColor       = RGB(90,90,90)
822:                     .BackColor       = RGB(255,255,255)
823:                     .Themes          = .F.
824:                 ENDWITH
825: 
826:                 WITH .Buttons(3)
827:                     .Top             = 5
828:                     .Left            = 155
829:                     .Width           = 75
830:                     .Height          = 75
831:                     .FontName        = "Comic Sans MS"
832:                     .FontSize        = 8
833:                     .FontBold        = .T.
834:                     .FontItalic      = .T.
835:                     .WordWrap        = .T.
836:                     .Alignment       = 2
837:                     .PicturePosition = 13
838:                     .Picture         = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
839:                     .Caption         = "Boleto"
840:                     .ToolTipText     = "Boleto"
841:                     .Enabled         = .F.
842:                     .ForeColor       = RGB(90,90,90)
843:                     .BackColor       = RGB(255,255,255)
844:                     .Themes          = .F.

*-- Linhas 851 a 931:
851:         *-- faixa de cabecalho recem-adicionada, regra #11 re-layout).
852:         *-- this_nDiasProtesto (BO) ja existe com default 5, igual ao
853:         *-- spndias.Value implicito do legado.
854:         loc_oPag.AddObject("lbl_4c_Label12", "Label")
855:         WITH loc_oPag.lbl_4c_Label12
856:             .Top       = 124
857:             .Left      = 370
858:             .Width     = 80
859:             .Height    = 15
860:             .FontName  = "Tahoma"
861:             .FontSize  = 8
862:             .AutoSize  = .F.
863:             .Alignment = 0
864:             .BackStyle = 0
865:             .ForeColor = RGB(90,90,90)
866:             .Caption   = "Protestar ap" + CHR(243) + "s :"
867:         ENDWITH
868: 
869:         loc_oPag.AddObject("spn_4c_DiasProtesto", "Spinner")
870:         WITH loc_oPag.spn_4c_DiasProtesto
871:             .Top          = 120
872:             .Left         = 451
873:             .Width        = 45
874:             .Height       = 24
875:             .FontName     = "Tahoma"
876:             .FontSize     = 8
877:             .SpinnerLowValue  = 0
878:             .SpinnerHighValue = 999
879:             .Increment    = 1
880:             .Value        = 5
881:         ENDWITH
882: 
883:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
884:         WITH loc_oPag.lbl_4c_Label1
885:             .Top       = 124
886:             .Left      = 501
887:             .Width     = 21
888:             .Height    = 15
889:             .FontName  = "Tahoma"
890:             .FontSize  = 8
891:             .AutoSize  = .F.
892:             .Alignment = 0
893:             .BackStyle = 0
894:             .ForeColor = RGB(90,90,90)
895:             .Caption   = "dias"
896:         ENDWITH
897: 
898:         *-- Aviso de endereco longo (Say2/Botao1 no legado, raw Top=14/15 -
899:         *-- ficava ACIMA do grupo "Protestar apos" no SCX original). Com a
900:         *-- faixa do cabecalho ocupando Top 29..109 (regra #11), o aviso foi
901:         *-- reposicionado para LOGO ABAIXO do grupo de dias (que fecha em
902:         *-- Top=139), preservando os dois controles sem sobrepor nada -
903:         *-- re-layout de pagina cheia (regra #11/#39), nao invencao de novo
904:         *-- elemento.
905:         loc_oPag.AddObject("lbl_4c_AvisoEndereco", "Label")
906:         WITH loc_oPag.lbl_4c_AvisoEndereco
907:             .Top       = 154
908:             .Left      = 390
909:             .Width     = 238
910:             .Height    = 15
911:             .FontName  = "Tahoma"
912:             .FontSize  = 8
913:             .AutoSize  = .F.
914:             .Alignment = 0
915:             .BackStyle = 0
916:             .ForeColor = RGB(255,0,0)
917:             .Caption   = "Endere" + CHR(231) + "os com tamanho maior que 40 caracteres"
918:         ENDWITH
919: 
920:         *-- Botao1 no legado eh so uma caixinha vermelha decorativa (When
921:         *-- sempre .F. - nunca recebe foco/clique), legenda de cor ao lado
922:         *-- do aviso acima.
923:         loc_oPag.AddObject("txt_4c_AvisoCor", "TextBox")
924:         WITH loc_oPag.txt_4c_AvisoCor
925:             .Top           = 153
926:             .Left          = 370
927:             .Width         = 17
928:             .Height        = 16
929:             .SpecialEffect = 1
930:             .BackColor     = RGB(255,0,0)
931:             .BorderColor   = RGB(255,0,0)

*-- Linhas 954 a 994:
954: 
955:         *-- Grade de titulos em aberto (grdope no legado, Pagina Dados) - 8
956:         *-- colunas. ColumnOrder visual segue o legado (Column8 "Titulo"
957:         *-- aparece logo apos o checkbox - regra #35b: a grade espelha a
958:         *-- estrutura do legado, nao a ordem de criacao das colunas).
959:         loc_oPag.AddObject("grd_4c_Titulos", "Grid")
960:         loc_oGridTit = loc_oPag.grd_4c_Titulos
961: 
962:         *-- ColumnCount/RecordSource FORA do WITH (regra GRID-WITH): dentro do
963:         *-- mesmo WITH que acessa .Column, o Grid pode nao ter as colunas
964:         *-- prontas ainda, e o acesso a .Column1 logo abaixo estouraria
965:         *-- 'Unknown member COLUMN1'.
966:         loc_oGridTit.ColumnCount  = 8
967:         loc_oGridTit.RecordSource = "cursor_4c_Titulos"
968: 
969:         WITH loc_oGridTit
970:             .Top               = 180
971:             .Left              = 7
972:             .Width             = 981
973:             .Height            = 382
974:             .FontName          = "Tahoma"
975:             .AllowHeaderSizing = .F.
976:             .AllowRowSizing    = .F.
977:             .DeleteMark        = .F.
978:             .RecordMark        = .F.
979:             .GridLineColor     = RGB(238,238,238)
980:             .ScrollBars        = 2
981:             .Themes            = .F.
982: 
983:             *-- Limpa o ControlSource auto-atribuido pelo Grid ANTES de
984:             *-- adicionar o CheckBox (regra #18).
985:             .Column1.ControlSource = ""
986:             .Column1.AddObject("chk_4c_Marca", "CheckBox")
987:             .Column1.CurrentControl = "chk_4c_Marca"
988:             WITH .Column1.chk_4c_Marca
989:                 .Caption   = ""
990:                 .BackColor = RGB(255,255,255)
991:             ENDWITH
992: 
993:             .Column1.ControlSource = "cursor_4c_Titulos.Marca"
994:             .Column2.ControlSource = "cursor_4c_Titulos.Dopes"

*-- Linhas 1004 a 1056:
1004:             .Column1.Resizable       = .F.
1005:             .Column1.Sparse         = .F.
1006:             .Column1.ReadOnly        = .F.
1007:             .Column1.Header1.Caption = ""
1008:         ENDWITH
1009: 
1010:         *-- Largura/legenda/ordem reaplicadas DEPOIS do RecordSource/
1011:         *-- ControlSource (Problema 48 - ambos resetam Column.Width e
1012:         *-- Header1.Caption).
1013:         THIS.FormatarGridTitulos(loc_oGridTit)
1014: 
1015:         *-- Container Marcar/Desmarcar Tudo dos titulos (Commandgroup2 no
1016:         *-- legado, pgdados) - mesmo padrao visual do cnt_4c_Marca da
1017:         *-- Pagina Filtro.
1018:         loc_oPag.AddObject("cnt_4c_Marca", "Container")
1019:         WITH loc_oPag.cnt_4c_Marca
1020:             .Top         = 570
1021:             .Left        = 7
1022:             .Width       = 92
1023:             .Height      = 50
1024:             .BackStyle   = 0
1025:             .BorderWidth = 0
1026: 
1027:             .AddObject("cmd_4c_MarcarTudo", "CommandButton")
1028:             WITH .cmd_4c_MarcarTudo
1029:                 .Top           = 5
1030:                 .Left          = 5
1031:                 .Width         = 40
1032:                 .Height        = 40
1033:                 .FontName      = "Verdana"
1034:                 .FontSize      = 7
1035:                 .Picture       = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
1036:                 .Caption       = ""
1037:                 .ToolTipText   = "Marcar tudo"
1038:                 .ForeColor     = RGB(36,84,155)
1039:                 .BackColor     = RGB(255,255,255)
1040:             ENDWITH
1041: 
1042:             .AddObject("cmd_4c_DesmarcarTudo", "CommandButton")
1043:             WITH .cmd_4c_DesmarcarTudo
1044:                 .Top           = 5
1045:                 .Left          = 45
1046:                 .Width         = 40
1047:                 .Height        = 40
1048:                 .FontName      = "Verdana"
1049:                 .FontSize      = 8
1050:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1051:                 .Caption       = ""
1052:                 .ToolTipText   = "Desmarcar tudo"
1053:                 .ForeColor     = RGB(36,84,155)
1054:                 .BackColor     = RGB(255,255,255)
1055:                 .Themes        = .F.
1056:             ENDWITH

*-- Linhas 1072 a 1146:
1072:             .Column1.Sparse          = .F.
1073:             .Column1.ReadOnly        = .F.
1074:             .Column1.ColumnOrder     = 1
1075:             .Column1.Header1.Caption = ""
1076: 
1077:             .Column2.Width             = 150
1078:             .Column2.Movable           = .F.
1079:             .Column2.Resizable         = .F.
1080:             .Column2.ReadOnly          = .T.
1081:             .Column2.ColumnOrder       = 3
1082:             .Column2.Header1.Alignment = 2
1083:             .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1084: 
1085:             .Column3.Width             = 52
1086:             .Column3.Movable           = .F.
1087:             .Column3.Resizable         = .F.
1088:             .Column3.ReadOnly          = .T.
1089:             .Column3.ColumnOrder       = 4
1090:             .Column3.Header1.Alignment = 2
1091:             .Column3.Header1.Caption   = "C" + CHR(243) + "digo"
1092: 
1093:             .Column4.Width             = 400
1094:             .Column4.Movable           = .F.
1095:             .Column4.Resizable         = .F.
1096:             .Column4.ReadOnly          = .T.
1097:             .Column4.ColumnOrder       = 5
1098:             .Column4.Header1.Alignment = 2
1099:             .Column4.Header1.Caption   = "Cliente"
1100: 
1101:             .Column5.Width             = 72
1102:             .Column5.Movable           = .F.
1103:             .Column5.Resizable         = .F.
1104:             .Column5.ReadOnly          = .T.
1105:             .Column5.ColumnOrder       = 6
1106:             .Column5.Header1.Alignment = 2
1107:             .Column5.Header1.Caption   = "Vencimento"
1108: 
1109:             .Column6.Width             = 87
1110:             .Column6.Movable           = .F.
1111:             .Column6.Resizable         = .F.
1112:             .Column6.ReadOnly          = .T.
1113:             .Column6.ColumnOrder       = 7
1114:             .Column6.Header1.Alignment = 2
1115:             .Column6.Header1.Caption   = "Forma Pagto"
1116: 
1117:             .Column7.Width             = 100
1118:             .Column7.Movable           = .F.
1119:             .Column7.Resizable         = .F.
1120:             .Column7.ReadOnly          = .T.
1121:             .Column7.ColumnOrder       = 8
1122:             .Column7.Header1.Alignment = 2
1123:             .Column7.Header1.Caption   = "Valor"
1124: 
1125:             .Column8.Movable           = .F.
1126:             .Column8.Resizable         = .F.
1127:             .Column8.ReadOnly          = .T.
1128:             .Column8.ColumnOrder       = 2
1129:             .Column8.Header1.Alignment = 2
1130:             .Column8.Header1.Caption   = "T" + CHR(237) + "tulo"
1131: 
1132:             .SetAll("DynamicForeColor", "IIF(cursor_4c_Titulos.EndErro = 1, RGB(255,0,0), RGB(0,0,0))", "Column")
1133:         ENDWITH
1134:     ENDPROC
1135: 
1136:     *==========================================================================
1137:     * CarregarOperacoes - Popula cursor_4c_Operacoes com as operacoes (SigCdOpe)
1138:     * elegiveis para o processo de CNAB (Parcontas=1 e ValPends=1), igual ao
1139:     * legado (Init: "select dopes, ?lltru as marca from SigCdOpe where
1140:     * Parcontas = 1 And ValPends = 1 order by dopes", com lltru=.F.).
1141:     * Cursor eh READWRITE porque a Coluna1 do grid eh um CheckBox editavel
1142:     * (marca/desmarca operacao) - SQLEXEC devolve cursor somente-leitura.
1143:     *==========================================================================
1144:     PROTECTED PROCEDURE CarregarOperacoes()
1145:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
1146:         loc_lSucesso = .F.

*-- Linhas 1231 a 1247:
1231:         LOCAL loc_oPag1, loc_oPag2
1232: 
1233:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
1234:         BINDEVENT(loc_oPag1.cnt_4c_Botoes.cmd_4c_Processar,    "Click", THIS, "BtnProcessarClick")
1235:         BINDEVENT(loc_oPag1.cnt_4c_Botoes.cmd_4c_Encerrar,     "Click", THIS, "BtnEncerrarClick")
1236:         BINDEVENT(loc_oPag1.cnt_4c_Marca.cmd_4c_MarcarTudo,    "Click", THIS, "BtnMarcarTudoClick")
1237:         BINDEVENT(loc_oPag1.cnt_4c_Marca.cmd_4c_DesmarcarTudo, "Click", THIS, "BtnDesmarcarTudoClick")
1238: 
1239:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1240:         BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Encerrar,   "Click", THIS, "BtnVoltarClick")
1241:         BINDEVENT(loc_oPag2.cnt_4c_Marca.cmd_4c_MarcarTudo,      "Click", THIS, "BtnMarcarTudoTitulosClick")
1242:         BINDEVENT(loc_oPag2.cnt_4c_Marca.cmd_4c_DesmarcarTudo,   "Click", THIS, "BtnDesmarcarTudoTitulosClick")
1243:         BINDEVENT(loc_oPag2.grd_4c_Titulos.Column1.chk_4c_Marca, "Click", THIS, "ChkTituloMarcaClick")
1244: 
1245:         *-- obj_4c_Comandos (Commandgroup1 no legado: btncnab/btnrelatorio/btnBoleto)
1246:         BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(1), "Click", THIS, "BtnGerarCnabClick")
1247:         BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(2), "Click", THIS, "BtnRelatorioCnabClick")

*-- Linhas 1325 a 1333:
1325:     * ProcessarTitulos - PROCEDURE processamento no legado. Monta a lista de
1326:     * operacoes marcadas + consulta os titulos em aberto (SigMvPar/SigOpFp/
1327:     * SigMvCab/SigCdCli/SigMvCcr), populando cursor_4c_Titulos (READWRITE -
1328:     * a coluna Marca eh CheckBox editavel no grid). Formula/filtros
1329:     * TRANSCRITOS literalmente do legado (regra CLAUDE.md #17) - inclusive a
1330:     * ausencia de filtro pela conta/carteira na consulta (o legado le
1331:     * get_cd_car_conta so para validar preenchimento, e aplica a conta
1332:     * apenas na geracao do CNAB, fase 8).
1333:     *==========================================================================

*-- Linhas 1469 a 1477:
1469:     * BtnMarcarTudoTitulosClick/BtnDesmarcarTudoTitulosClick - Commandgroup2.
1470:     * btnmarca/btndesmarca.Click (Pagina Dados) no legado - marca/desmarca
1471:     * TODOS os titulos, sem excecao pelo EndErro (igual ao legado - o
1472:     * "Marcar Tudo" bypassa o guard do checkbox individual).
1473:     *==========================================================================
1474:     PROCEDURE BtnMarcarTudoTitulosClick()
1475:         IF USED("cursor_4c_Titulos")
1476:             SELECT cursor_4c_Titulos
1477:             REPLACE ALL Marca WITH .T.

*-- Linhas 1494 a 1502:
1494:     *==========================================================================
1495:     * ChkTituloMarcaClick - Column1.Check1.When no legado (Return
1496:     * crFiltro.EndErro = 0): titulo com endereco muito longo nao pode ser
1497:     * selecionado. O nativo do CheckBox ja alterna Marca no clique; aqui so
1498:     * revertemos quando a linha estiver marcada como EndErro=1.
1499:     *==========================================================================
1500:     PROCEDURE ChkTituloMarcaClick()
1501:         IF USED("cursor_4c_Titulos") AND !EOF("cursor_4c_Titulos")
1502:             IF cursor_4c_Titulos.EndErro = 1 AND cursor_4c_Titulos.Marca

*-- Linhas 1814 a 1823:
1814:                 IF VARTYPE(loc_oBusca) = "O"
1815:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpresa"
1816:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1817:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1818:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1819:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1820:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1821:                     loc_oBusca.Show()
1822:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
1823:                         SELECT cursor_4c_BuscaEmpresa

*-- Linhas 2011 a 2020:
2011:                 IF VARTYPE(loc_oBusca) = "O"
2012:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
2013:                     loc_oBusca.this_cTitulo        = loc_cTitulo
2014:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
2015:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
2016:                     loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2017:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
2018:                     loc_oBusca.Show()
2019:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
2020:                         SELECT cursor_4c_BuscaConta

*-- Linhas 2131 a 2140:
2131:                 IF VARTYPE(loc_oBusca) = "O"
2132:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTituloBanco"
2133:                     loc_oBusca.this_cTitulo        = loc_cTitulo
2134:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
2135:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
2136:                     loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
2137:                     loc_oBusca.Show()
2138:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTituloBanco")
2139:                         SELECT cursor_4c_BuscaTituloBanco
2140:                         loc_oPag.txt_4c_TituloBanco.Value = ALLTRIM(cursor_4c_BuscaTituloBanco.Fpags)

*-- Linhas 2171 a 2220:
2171: 
2172:         loc_oP1 = THIS.pgf_4c_Paginas.Page1
2173:         loc_oP1.cnt_4c_Cabecalho.Visible                       = .T.
2174:         loc_oP1.cnt_4c_Cabecalho.lbl_4c_Sombra.Visible         = .T.
2175:         loc_oP1.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible         = .T.
2176:         loc_oP1.cnt_4c_Botoes.Visible                          = .T.
2177:         loc_oP1.cnt_4c_Botoes.cmd_4c_Processar.Visible         = .T.
2178:         loc_oP1.cnt_4c_Botoes.cmd_4c_Encerrar.Visible          = .T.
2179:         loc_oP1.cnt_4c_Marca.Visible                           = .T.
2180:         loc_oP1.cnt_4c_Marca.cmd_4c_MarcarTudo.Visible         = .T.
2181:         loc_oP1.cnt_4c_Marca.cmd_4c_DesmarcarTudo.Visible      = .T.
2182:         loc_oP1.lbl_4c_Operacoes.Visible                       = .T.
2183:         loc_oP1.obj_4c_Processados.Visible                     = .T.
2184:         loc_oP1.lbl_4c_Empresa.Visible                         = .T.
2185:         loc_oP1.txt_4c_CodEmpresa.Visible                      = .T.
2186:         loc_oP1.txt_4c_NomeEmpresa.Visible                     = .T.
2187:         loc_oP1.lbl_4c_Periodo.Visible                         = .T.
2188:         loc_oP1.txt_4c_DataInicial.Visible                     = .T.
2189:         loc_oP1.lbl_4c_Ate.Visible                             = .T.
2190:         loc_oP1.txt_4c_DataFinal.Visible                       = .T.
2191:         loc_oP1.obj_4c_Periodo.Visible                         = .T.
2192:         loc_oP1.lbl_4c_Banco.Visible                           = .T.
2193:         loc_oP1.txt_4c_CodConta.Visible                        = .T.
2194:         loc_oP1.txt_4c_NomeConta.Visible                       = .T.
2195:         loc_oP1.lbl_4c_TituloBanco.Visible                     = .T.
2196:         loc_oP1.txt_4c_TituloBanco.Visible                     = .T.
2197:         loc_oP1.lbl_4c_Operacao.Visible                        = .T.
2198:         loc_oP1.grd_4c_Operacoes.Visible                       = .T.
2199: 
2200:         loc_oP2 = THIS.pgf_4c_Paginas.Page2
2201:         loc_oP2.cnt_4c_Cabecalho.Visible                       = .T.
2202:         loc_oP2.cnt_4c_Cabecalho.lbl_4c_Sombra.Visible         = .T.
2203:         loc_oP2.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible         = .T.
2204:         loc_oP2.cnt_4c_BotoesAcao.Visible                      = .T.
2205:         loc_oP2.cnt_4c_BotoesAcao.cmd_4c_Encerrar.Visible      = .T.
2206:         loc_oP2.cnt_4c_BotoesAcao.obj_4c_Comandos.Visible      = .T.
2207:         loc_oP2.lbl_4c_Label12.Visible                         = .T.
2208:         loc_oP2.spn_4c_DiasProtesto.Visible                    = .T.
2209:         loc_oP2.lbl_4c_Label1.Visible                          = .T.
2210:         loc_oP2.lbl_4c_AvisoEndereco.Visible                   = .T.
2211:         loc_oP2.txt_4c_AvisoCor.Visible                        = .T.
2212:         loc_oP2.grd_4c_Titulos.Visible                         = .T.
2213:         loc_oP2.cnt_4c_Marca.Visible                           = .T.
2214:         loc_oP2.cnt_4c_Marca.cmd_4c_MarcarTudo.Visible         = .T.
2215:         loc_oP2.cnt_4c_Marca.cmd_4c_DesmarcarTudo.Visible      = .T.
2216:     ENDPROC
2217: 
2218:     *==========================================================================
2219:     * DESTROY - delega para FormBase.Destroy (restaura menu apos fechamento)
2220:     *==========================================================================

