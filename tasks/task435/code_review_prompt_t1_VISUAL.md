# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [ALINHAMENTO] Botao 'cmd_4c_Retornar' tem Top=11 mas grupo usa Top=5 (diferenca de 6px)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 278: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFUN.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3822 linhas total):

*-- Linhas 123 a 131:
123:                 ENDWITH
124: 
125:                 *-- Vincular eventos base
126:                 BINDEVENT(THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.cmd_4c_Encerrar, ;
127:                     "Click", THIS, "BtnEncerrarClick")
128: 
129:                 *-- Carregar lista inicial
130:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
131:                     THIS.CarregarLista()

*-- Linhas 150 a 173:
150:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
151: 
152:         WITH THIS.pgf_4c_Paginas
153:             .Top       = -29
154:             .Left      = 0
155:             .Width     = THIS.Width
156:             .Height    = THIS.Height + 29
157:             .PageCount = 2
158:             .Tabs      = .F.
159:             .Visible   = .T.
160:         ENDWITH
161: 
162:         WITH THIS.pgf_4c_Paginas.Page1
163:             .Caption   = "Lista"
164:             .BackColor = RGB(255, 255, 255)
165:         ENDWITH
166: 
167:         WITH THIS.pgf_4c_Paginas.Page2
168:             .Caption   = "Dados"
169:             .BackColor = RGB(255, 255, 255)
170:         ENDWITH
171: 
172:         IF FILE(gc_4c_CaminhoIcones + "fundo_cad_1003.jpg")
173:             THIS.pgf_4c_Paginas.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 192 a 230:
192:         *----------------------------------------------------------------------
193:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
194:         WITH loc_oPagina.cnt_4c_Cabecalho
195:             .Top         = 31
196:             .Left        = 0
197:             .Width       = THIS.Width
198:             .Height      = 80
199:             .BackColor   = RGB(100, 100, 100)
200:             .BackStyle   = 1
201:             .BorderWidth = 0
202:             .SpecialEffect = 0
203:             .Visible     = .T.
204:         ENDWITH
205: 
206:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
207:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
208:             .Caption   = "Cadastro de Fundi" + CHR(231) + CHR(245) + "es"
209:             .Top       = 15
210:             .Left      = 10
211:             .Width     = THIS.Width - 20
212:             .Height    = 40
213:             .AutoSize  = .F.
214:             .FontName  = "Tahoma"
215:             .FontSize  = 16
216:             .FontBold  = .T.
217:             .ForeColor = RGB(0, 0, 0)
218:             .BackStyle = 0
219:         ENDWITH
220: 
221:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
222:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
223:             .Caption   = "Cadastro de Fundi" + CHR(231) + CHR(245) + "es"
224:             .Top       = 18
225:             .Left      = 10
226:             .Width     = THIS.Width - 20
227:             .Height    = 46
228:             .AutoSize  = .F.
229:             .FontName  = "Tahoma"
230:             .FontSize  = 16

*-- Linhas 239 a 284:
239:         *----------------------------------------------------------------------
240:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
241:         WITH loc_oPagina.cnt_4c_Botoes
242:             .Top         = 29
243:             .Left        = 542
244:             .Width       = 370
245:             .Height      = 85
246:             .BackStyle = 1
247:             .BackColor = RGB(255, 255, 255)
248:             .BorderWidth = 0
249:             .SpecialEffect = 0
250:             .Visible     = .T.
251:         ENDWITH
252: 
253:         *----------------------------------------------------------------------
254:         * cnt_4c_Saida - Botao Encerrar (padrao canonico)
255:         * Left=917, Width=90, cmd_4c_Encerrar Width=75, Height=75
256:         *----------------------------------------------------------------------
257:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
258:         WITH loc_oPagina.cnt_4c_Saida
259:             .Top         = 29
260:             .Left        = 917
261:             .Width       = 90
262:             .Height      = 85
263:             .BackStyle = 1
264:             .BackColor = RGB(255, 255, 255)
265:             .BorderWidth = 0
266:             .Visible     = .T.
267:         ENDWITH
268: 
269:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
270:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
271:             .Caption         = "Encerrar"
272:             .Top             = 5
273:             .Left            = 5
274:             .Width           = 75
275:             .Height          = 75
276:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
277:             .PicturePosition = 13
278:             .FontName        = "Comic Sans MS"
279:             .FontSize        = 8
280:             .FontBold        = .T.
281:             .FontItalic      = .T.
282:             .ForeColor       = RGB(90, 90, 90)
283:             .BackColor       = RGB(255, 255, 255)
284:             .Themes          = .F.

*-- Linhas 294 a 398:
294:         *----------------------------------------------------------------------
295:         loc_oPagina.AddObject("cnt_4c_Periodo", "Container")
296:         WITH loc_oPagina.cnt_4c_Periodo
297:             .Top         = 148
298:             .Left        = 12
299:             .Width       = 421
300:             .Height      = 36
301:             .BackStyle   = 0
302:             .BorderWidth = 0
303:             .Visible     = .T.
304:         ENDWITH
305: 
306:         loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Empresa", "Label")
307:         WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Empresa
308:             .Caption   = "Empresa : "
309:             .Top       = 9
310:             .Left      = 14
311:             .Width     = 56
312:             .Height    = 15
313:             .FontName  = "Tahoma"
314:             .FontSize  = 8
315:             .BackStyle = 0
316:             .ForeColor = RGB(90, 90, 90)
317:         ENDWITH
318: 
319:         loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_CdEmpresa", "TextBox")
320:         WITH loc_oPagina.cnt_4c_Periodo.txt_4c_CdEmpresa
321:             .Value     = ""
322:             .Top       = 6
323:             .Left      = 77
324:             .Width     = 35
325:             .Height    = 23
326:             .FontName  = "Tahoma"
327:             .FontSize  = 8
328:             .MaxLength = 3
329:             .BackColor = RGB(255, 255, 255)
330:         ENDWITH
331: 
332:         loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Periodo", "Label")
333:         WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Periodo
334:             .Caption   = "Per" + CHR(237) + "odo : "
335:             .Top       = 9
336:             .Left      = 174
337:             .Width     = 54
338:             .Height    = 15
339:             .FontName  = "Tahoma"
340:             .FontSize  = 8
341:             .BackStyle = 0
342:             .ForeColor = RGB(90, 90, 90)
343:         ENDWITH
344: 
345:         loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_DtInicial", "TextBox")
346:         WITH loc_oPagina.cnt_4c_Periodo.txt_4c_DtInicial
347:             .Value     = {}
348:             .Top       = 6
349:             .Left      = 231
350:             .Width     = 80
351:             .Height    = 23
352:             .FontName  = "Tahoma"
353:             .FontSize  = 8
354:             .BackColor = RGB(255, 255, 255)
355:         ENDWITH
356: 
357:         loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Ate", "Label")
358:         WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Ate
359:             .Caption   = CHR(224)
360:             .Top       = 9
361:             .Left      = 316
362:             .Width     = 10
363:             .Height    = 15
364:             .FontName  = "Tahoma"
365:             .FontSize  = 8
366:             .BackStyle = 0
367:             .ForeColor = RGB(90, 90, 90)
368:         ENDWITH
369: 
370:         loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_DtFinal", "TextBox")
371:         WITH loc_oPagina.cnt_4c_Periodo.txt_4c_DtFinal
372:             .Value     = {}
373:             .Top       = 6
374:             .Left      = 329
375:             .Width     = 80
376:             .Height    = 23
377:             .FontName  = "Tahoma"
378:             .FontSize  = 8
379:             .BackColor = RGB(255, 255, 255)
380:         ENDWITH
381:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_CdEmpresa, "KeyPress", THIS, "EmpresaLostFocus")
382:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")
383:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DtFinal,   "KeyPress", THIS, "DtFinalLostFocus")
384: 
385:         *----------------------------------------------------------------------
386:         * cmd_4c_BtnAguarde - Mensagem de espera durante carregamento
387:         * Original: top=266, left=339, width=322, height=72, visible=false -> comp +29 = 295
388:         *----------------------------------------------------------------------
389:         loc_oPagina.AddObject("cmd_4c_BtnAguarde", "CommandButton")
390:         WITH loc_oPagina.cmd_4c_BtnAguarde
391:             .Caption   = "Aguarde!  Atualizando  Dados . . ."
392:             .Top       = 295
393:             .Left      = 339
394:             .Width     = 322
395:             .Height    = 72
396:             .FontName  = "Tahoma"
397:             .FontSize  = 11
398:             .FontBold  = .T.

*-- Linhas 409 a 418:
409:         loc_oPagina.AddObject("txt_4c_Botao1", "TextBox")
410:         WITH loc_oPagina.txt_4c_Botao1
411:             .Value     = ""
412:             .Top       = 161
413:             .Left      = 438
414:             .Width     = 27
415:             .Height    = 22
416:             .FontName  = "Tahoma"
417:             .FontSize  = 8
418:             .BackColor = RGB(255, 255, 255)

*-- Linhas 427 a 441:
427:         *----------------------------------------------------------------------
428:         * Botoes CRUD dentro de cnt_4c_Botoes
429:         *----------------------------------------------------------------------
430:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
431:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
432:             .Caption         = "Incluir"
433:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
434:             .PicturePosition = 13
435:             .Top             = 5
436:             .Left            = 5
437:             .Width           = 75
438:             .Height          = 75
439:             .FontName        = "Tahoma"
440:             .FontBold        = .T.
441:             .FontItalic      = .T.

*-- Linhas 448 a 464:
448:             .WordWrap        = .T.
449:             .AutoSize        = .F.
450:         ENDWITH
451:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
452: 
453:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
454:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
455:             .Caption         = "Visualizar"
456:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
457:             .PicturePosition = 13
458:             .Top             = 5
459:             .Left            = 80
460:             .Width           = 75
461:             .Height          = 75
462:             .FontName        = "Tahoma"
463:             .FontBold        = .T.
464:             .FontItalic      = .T.

*-- Linhas 471 a 487:
471:             .WordWrap        = .T.
472:             .AutoSize        = .F.
473:         ENDWITH
474:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
475: 
476:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
477:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
478:             .Caption         = "Alterar"
479:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
480:             .PicturePosition = 13
481:             .Top             = 5
482:             .Left            = 155
483:             .Width           = 75
484:             .Height          = 75
485:             .FontName        = "Tahoma"
486:             .FontBold        = .T.
487:             .FontItalic      = .T.

*-- Linhas 494 a 510:
494:             .WordWrap        = .T.
495:             .AutoSize        = .F.
496:         ENDWITH
497:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
498: 
499:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
500:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
501:             .Caption         = "Excluir"
502:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
503:             .PicturePosition = 13
504:             .Top             = 5
505:             .Left            = 230
506:             .Width           = 75
507:             .Height          = 75
508:             .FontName        = "Tahoma"
509:             .FontBold        = .T.
510:             .FontItalic      = .T.

*-- Linhas 517 a 533:
517:             .WordWrap        = .T.
518:             .AutoSize        = .F.
519:         ENDWITH
520:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
521: 
522:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
523:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
524:             .Caption         = "Buscar"
525:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
526:             .PicturePosition = 13
527:             .Top             = 5
528:             .Left            = 305
529:             .Width           = 75
530:             .Height          = 75
531:             .FontName        = "Tahoma"
532:             .FontBold        = .T.
533:             .FontItalic      = .T.

*-- Linhas 540 a 559:
540:             .WordWrap        = .T.
541:             .AutoSize        = .F.
542:         ENDWITH
543:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
544: 
545:         *----------------------------------------------------------------------
546:         * grd_4c_Dados - Grade principal de listagem
547:         * Original: Grade.Top=157, Left=12, Width=944, Height=434 -> comp +29 = 186
548:         * ColumnCount DEVE ser setado FORA do WITH (nao cria colunas dentro do WITH)
549:         *----------------------------------------------------------------------
550:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
551:         loc_oPagina.grd_4c_Dados.ColumnCount = 5
552:         WITH loc_oPagina.grd_4c_Dados
553:             .Top                = 186
554:             .Left               = 12
555:             .Width              = 944
556:             .Height             = 434
557:             .FontName           = "Tahoma"
558:             .FontSize           = 8
559:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 576 a 608:
576:             .ControlSource   = "cursor_4c_Dados.codigos"
577:             .Width           = 52
578:             .Alignment       = 2
579:             .Header1.Caption = "C" + CHR(243) + "digo"
580:         ENDWITH
581: 
582:         WITH loc_oPagina.grd_4c_Dados.Column2
583:             .ControlSource   = "cursor_4c_Dados.datas"
584:             .Width           = 75
585:             .Header1.Caption = "Data"
586:         ENDWITH
587: 
588:         WITH loc_oPagina.grd_4c_Dados.Column3
589:             .ControlSource   = "cursor_4c_Dados.usuars"
590:             .Width           = 80
591:             .Header1.Caption = "Usu" + CHR(225) + "rio"
592:         ENDWITH
593: 
594:         WITH loc_oPagina.grd_4c_Dados.Column4
595:             .ControlSource   = "cursor_4c_Dados.codmaqfs"
596:             .Width           = 80
597:             .Header1.Caption = "M" + CHR(225) + "quina"
598:         ENDWITH
599: 
600:         WITH loc_oPagina.grd_4c_Dados.Column5
601:             .ControlSource   = "cursor_4c_Dados.obss"
602:             .Width           = 330
603:             .Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
604:         ENDWITH
605: 
606:         BINDEVENT(loc_oPagina.grd_4c_Dados, "DblClick", THIS, "BtnVisualizarClick")
607: 
608:         THIS.TornarControlesVisiveis(loc_oPagina)

*-- Linhas 623 a 648:
623:         *----------------------------------------------------------------------
624:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
625:         WITH loc_oPagina.cnt_4c_Salva
626:             .Top           = 33
627:             .Left          = 842
628:             .Width         = 160
629:             .Height        = 85
630:             .BackStyle = 1
631:             .BackColor = RGB(255, 255, 255)
632:             .SpecialEffect = 0
633:             .Visible     = .T.
634:         ENDWITH
635: 
636:         *----------------------------------------------------------------------
637:         * cnt_4c_Container2 - 24 checkboxes de tubos + opt_status (Fase 5)
638:         * Original: top=5, left=9, width=296, height=594 -> comp +29 = 34
639:         *----------------------------------------------------------------------
640:         loc_oPagina.AddObject("cnt_4c_Container2", "Container")
641:         WITH loc_oPagina.cnt_4c_Container2
642:             .Top         = 34
643:             .Left        = 9
644:             .Width       = 296
645:             .Height      = 594
646:             .BackStyle   = 1
647:             .BackColor   = RGB(225, 225, 225)
648:             .BorderWidth = 0

*-- Linhas 655 a 664:
655:         *----------------------------------------------------------------------
656:         loc_oPagina.AddObject("cnt_4c_Container1", "Container")
657:         WITH loc_oPagina.cnt_4c_Container1
658:             .Top         = 44
659:             .Left        = 320
660:             .Width       = 348
661:             .Height      = 72
662:             .BackStyle   = 0
663:             .BorderWidth = 0
664:             .Visible     = .T.

*-- Linhas 670 a 679:
670:         *----------------------------------------------------------------------
671:         loc_oPagina.AddObject("cnt_4c_Container5", "Container")
672:         WITH loc_oPagina.cnt_4c_Container5
673:             .Top         = 169
674:             .Left        = 303
675:             .Width       = 247
676:             .Height      = 148
677:             .BackStyle   = 0
678:             .BorderWidth = 0
679:             .Visible     = .T.

*-- Linhas 685 a 694:
685:         *----------------------------------------------------------------------
686:         loc_oPagina.AddObject("cnt_4c_Container3", "Container")
687:         WITH loc_oPagina.cnt_4c_Container3
688:             .Top         = 161
689:             .Left        = 549
690:             .Width       = 445
691:             .Height      = 345
692:             .BackStyle   = 0
693:             .BorderWidth = 0
694:             .Visible     = .T.

*-- Linhas 700 a 709:
700:         *----------------------------------------------------------------------
701:         loc_oPagina.AddObject("cnt_4c_Container6", "Container")
702:         WITH loc_oPagina.cnt_4c_Container6
703:             .Top         = 329
704:             .Left        = 303
705:             .Width       = 247
706:             .Height      = 126
707:             .BackStyle   = 0
708:             .BorderWidth = 0
709:             .Visible     = .T.

*-- Linhas 715 a 724:
715:         *----------------------------------------------------------------------
716:         loc_oPagina.AddObject("cnt_4c_Container4", "Container")
717:         WITH loc_oPagina.cnt_4c_Container4
718:             .Top         = 508
719:             .Left        = 311
720:             .Width       = 679
721:             .Height      = 118
722:             .BackStyle   = 0
723:             .BorderWidth = 0
724:             .Visible     = .T.

*-- Linhas 730 a 758:
730:         *----------------------------------------------------------------------
731:         loc_oPagina.AddObject("cnt_4c_Total", "Container")
732:         WITH loc_oPagina.cnt_4c_Total
733:             .Top         = 231
734:             .Left        = 246
735:             .Width       = 508
736:             .Height      = 200
737:             .BackStyle   = 1
738:             .BackColor   = RGB(240, 240, 240)
739:             .BorderWidth = 1
740:             .Visible     = .F.
741:         ENDWITH
742: 
743:         *----------------------------------------------------------------------
744:         * Botoes Confirmar/Cancelar dentro de cnt_4c_Salva
745:         * Original Grupo_Salva: Salva.Left=5, Cancelar.Left=88 (ambos Top=5)
746:         *----------------------------------------------------------------------
747:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
748:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
749:             .Caption         = "Confirmar"
750:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
751:             .PicturePosition = 13
752:             .Top             = 5
753:             .Left            = 5
754:             .Width           = 75
755:             .Height          = 75
756:             .FontName        = "Tahoma"
757:             .FontBold        = .T.
758:             .FontItalic      = .T.

*-- Linhas 765 a 781:
765:             .WordWrap        = .T.
766:             .AutoSize        = .F.
767:         ENDWITH
768:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
769: 
770:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
771:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
772:             .Caption         = "Encerrar"
773:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
774:             .PicturePosition = 13
775:             .Top             = 5
776:             .Left            = 80
777:             .Width           = 75
778:             .Height          = 75
779:             .FontName        = "Tahoma"
780:             .FontBold        = .T.
781:             .FontItalic      = .T.

*-- Linhas 788 a 796:
788:             .WordWrap        = .T.
789:             .AutoSize        = .F.
790:         ENDWITH
791:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
792: 
793:         THIS.ConfigurarContainer1(loc_oPagina)
794:         THIS.ConfigurarContainer2(loc_oPagina)
795:         THIS.ConfigurarContainer3(loc_oPagina)
796:         THIS.ConfigurarContainer4(loc_oPagina)

*-- Linhas 867 a 876:
867:                 THIS.this_dAntDtF  = loc_dDtFim
868: 
869:                 *-- Mostrar aguarde
870:                 THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnAguarde.Visible = .T.
871:                 THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnAguarde.Refresh()
872: 
873:                 *-- Formatar datas para SQL Server DATETIME
874:                 loc_cDtIniSQL = "'" + STUFF(STUFF(DTOS(loc_dDtIni), 5, 0, "-"), 8, 0, "-") + " 00:00:00'"
875:                 loc_cDtFimSQL = "'" + STUFF(STUFF(DTOS(loc_dDtFim), 5, 0, "-"), 8, 0, "-") + " 23:59:59'"
876: 

*-- Linhas 894 a 907:
894:                 ENDIF
895: 
896:                 *-- Ocultar aguarde
897:                 THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnAguarde.Visible = .F.
898:             ENDIF
899:         CATCH TO loc_oErro
900:             MsgErro("Erro em FormFUN.CarregarLista: " + loc_oErro.Message, "Erro")
901:             TRY
902:                 THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnAguarde.Visible = .F.
903:             CATCH
904:             ENDTRY
905:             loc_lSucesso = .F.
906:         ENDTRY
907: 

*-- Linhas 1178 a 1200:
1178:             IF loc_lOk
1179:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1180:                 IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
1181:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1182:                         loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lEmLista
1183:                         loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEmLista
1184:                         loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lEmLista
1185:                         loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lEmLista
1186:                         loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lEmLista
1187:                     ENDIF
1188:                 ENDIF
1189: 
1190:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1191:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
1192:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1193:                         loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
1194:                             (loc_lEmEdicao AND THIS.this_cModoAtual != "VISUALIZAR")
1195:                         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
1196:                     ENDIF
1197:                 ENDIF
1198:             ENDIF
1199:         CATCH TO loc_oErro
1200:             MsgErro("Erro em FormFUN.AtualizarEstadoControles: " + loc_oErro.Message, "Erro")

*-- Linhas 1242 a 1340:
1242:         LOCAL loc_oCnt
1243:         loc_oCnt = par_oPagina.cnt_4c_Container1
1244: 
1245:         *-- lbl_4c_FundNo (Say2): "Fundicao No :"
1246:         loc_oCnt.AddObject("lbl_4c_FundNo", "Label")
1247:         WITH loc_oCnt.lbl_4c_FundNo
1248:             .Caption   = "Fundi" + CHR(231) + CHR(227) + "o N" + CHR(186) + " :"
1249:             .Left      = 5
1250:             .Top       = 10
1251:             .AutoSize  = .T.
1252:             .FontBold  = .T.
1253:             .BackStyle = 0
1254:             .ForeColor = RGB(36, 84, 155)
1255:         ENDWITH
1256: 
1257:         *-- txt_4c_Codigos (getCodigos): numero sequencial, somente leitura
1258:         loc_oCnt.AddObject("txt_4c_Codigos", "TextBox")
1259:         WITH loc_oCnt.txt_4c_Codigos
1260:             .Value     = 0
1261:             .InputMask = "999999"
1262:             .MaxLength = 7
1263:             .Left      = 96
1264:             .Top       = 5
1265:             .Width     = 52
1266:             .Height    = 25
1267:             .ReadOnly  = .T.
1268:         ENDWITH
1269: 
1270:         *-- lbl_4c_MaquinaLabel (Say4): "Maquina :"
1271:         loc_oCnt.AddObject("lbl_4c_MaquinaLabel", "Label")
1272:         WITH loc_oCnt.lbl_4c_MaquinaLabel
1273:             .Caption   = "M" + CHR(225) + "quina :"
1274:             .Left      = 188
1275:             .Top       = 10
1276:             .AutoSize  = .T.
1277:             .FontBold  = .T.
1278:             .BackStyle = 0
1279:             .ForeColor = RGB(36, 84, 155)
1280:         ENDWITH
1281: 
1282:         *-- txt_4c_Maq (GetMaq): codigo da maquina, lookup LostFocus -> ValidarMaquina
1283:         loc_oCnt.AddObject("txt_4c_Maq", "TextBox")
1284:         WITH loc_oCnt.txt_4c_Maq
1285:             .Value     = ""
1286:             .MaxLength = 10
1287:             .Left      = 254
1288:             .Top       = 5
1289:             .Width     = 79
1290:             .Height    = 25
1291:         ENDWITH
1292:         BINDEVENT(loc_oCnt.txt_4c_Maq, "KeyPress", THIS, "ValidarMaquina")
1293: 
1294:         *-- lbl_4c_DataLabel (Say3): "Data :"
1295:         loc_oCnt.AddObject("lbl_4c_DataLabel", "Label")
1296:         WITH loc_oCnt.lbl_4c_DataLabel
1297:             .Caption   = "Data :"
1298:             .Left      = 54
1299:             .Top       = 41
1300:             .AutoSize  = .T.
1301:             .FontBold  = .T.
1302:             .BackStyle = 0
1303:             .ForeColor = RGB(36, 84, 155)
1304:         ENDWITH
1305: 
1306:         *-- txt_4c_Datas (getDatas): data da fundicao
1307:         loc_oCnt.AddObject("txt_4c_Datas", "TextBox")
1308:         WITH loc_oCnt.txt_4c_Datas
1309:             .Value     = {}
1310:             .MaxLength = 10
1311:             .Left      = 96
1312:             .Top       = 36
1313:             .Width     = 79
1314:             .Height    = 25
1315:         ENDWITH
1316: 
1317:         *-- lbl_4c_UsuarioLabel (Say1): "Usuario :"
1318:         loc_oCnt.AddObject("lbl_4c_UsuarioLabel", "Label")
1319:         WITH loc_oCnt.lbl_4c_UsuarioLabel
1320:             .Caption   = "Usu" + CHR(225) + "rio :"
1321:             .Left      = 192
1322:             .Top       = 41
1323:             .AutoSize  = .T.
1324:             .FontBold  = .T.
1325:             .BackStyle = 0
1326:             .ForeColor = RGB(36, 84, 155)
1327:         ENDWITH
1328: 
1329:         *-- txt_4c_Usu (Getusu): usuario que registrou, sempre somente leitura
1330:         loc_oCnt.AddObject("txt_4c_Usu", "TextBox")
1331:         WITH loc_oCnt.txt_4c_Usu
1332:             .Value     = ""
1333:             .MaxLength = 10
1334:             .Left      = 254
1335:             .Top       = 36
1336:             .Width     = 79
1337:             .Height    = 25
1338:             .ReadOnly  = .T.
1339:         ENDWITH
1340:     ENDPROC

*-- Linhas 1353 a 1366:
1353:         loc_oCnt.BackColor = RGB(255, 0, 0)
1354:         loc_oCnt.BackStyle = 0
1355: 
1356:         *-- lbl_4c_Tubos (Label1): cabecalho da secao de tubos
1357:         loc_oCnt.AddObject("lbl_4c_Tubos", "Label")
1358:         WITH loc_oCnt.lbl_4c_Tubos
1359:             .Caption   = "\<Tubos"
1360:             .Left      = 5
1361:             .Top       = 1
1362:             .AutoSize  = .T.
1363:             .FontName  = "Verdana"
1364:             .FontBold  = .T.
1365:             .FontSize  = 8
1366:             .BackStyle = 0

*-- Linhas 1372 a 1417:
1372:         loc_oCnt.AddObject("opt_4c_Status", "OptionGroup")
1373:         WITH loc_oCnt.opt_4c_Status
1374:             .ButtonCount    = 4
1375:             .Left           = 69
1376:             .Top            = -3
1377:             .Width          = 228
1378:             .Height         = 25
1379:             .AutoSize       = .T.
1380:             .BackStyle      = 0
1381:             .Buttons(1).Caption  = "Nenhum"
1382:             .Buttons(1).Left     = 5
1383:             .Buttons(1).Top      = 5
1384:             .Buttons(1).AutoSize = .T.
1385:             .Buttons(2).Caption  = "Cera"
1386:             .Buttons(2).Left     = 72
1387:             .Buttons(2).Top      = 5
1388:             .Buttons(2).AutoSize = .T.
1389:             .Buttons(3).Caption  = "Fundir"
1390:             .Buttons(3).Left     = 120
1391:             .Buttons(3).Top      = 5
1392:             .Buttons(3).Width    = 54
1393:             .Buttons(3).Height   = 15
1394:             .Buttons(3).AutoSize = .T.
1395:             .Buttons(3).FontName = "Verdana"
1396:             .Buttons(3).FontSize = 8
1397:             .Buttons(3).BackStyle = 0
1398:             .Buttons(3).ForeColor = RGB(36, 84, 155)
1399:             .Buttons(4).Caption  = "Pe" + CHR(231) + "a"
1400:             .Buttons(4).Left     = 177
1401:             .Buttons(4).Top      = 5
1402:             .Buttons(4).Width    = 46
1403:             .Buttons(4).Height   = 15
1404:             .Buttons(4).AutoSize = .T.
1405:             .Buttons(4).FontName = "Verdana"
1406:             .Buttons(4).FontSize = 8
1407:             .Buttons(4).BackStyle = 0
1408:             .Buttons(4).ForeColor = RGB(36, 84, 155)
1409:         ENDWITH
1410:         BINDEVENT(loc_oCnt.opt_4c_Status, "InteractiveChange", THIS, "OptStatusChanged")
1411: 
1412:         *-- 24 CheckBoxes: grade 4 colunas x 6 linhas (Style=1 grafico, PicturePosition=13)
1413:         *   Colunas  Left: 3, 76, 149, 222
1414:         *   Linhas   Top:  20, 116, 212, 308, 404, 500
1415:         loc_aTops[1]  = 20
1416:         loc_aTops[2]  = 116
1417:         loc_aTops[3]  = 212

*-- Linhas 1441 a 1457:
1441:                     loc_cPic = ""
1442:             ENDCASE
1443: 
1444:             loc_oCnt.AddObject(loc_cNomeChk, "CheckBox")
1445:             loc_oChk = EVALUATE("loc_oCnt." + loc_cNomeChk)
1446:             WITH loc_oChk
1447:                 .Caption         = PADL(TRANSFORM(loc_n), 2, "0")
1448:                 .Style           = 1
1449:                 .PicturePosition = 13
1450:                 .Alignment       = 0
1451:                 .Top             = loc_nTop
1452:                 .Left            = loc_nLeft
1453:                 .Height          = 90
1454:                 .Width           = 70
1455:                 .FontName        = "Verdana"
1456:                 .FontSize        = 8
1457:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 1536 a 1590:
1536: 
1537:             IF EMPTY(loc_cCodMaq)
1538:                 THIS.this_nMaqTubos = 0
1539:                 THIS.AtualizarVisibilidadeCheckboxes(0)
1540:             ELSE
1541:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1542:                     "SELECT m.codigos, m.tubos FROM SigCfMqf m WHERE m.codigos = " + ;
1543:                     EscaparSQL(loc_cCodMaq), ;
1544:                     "cursor_4c_BuscaMaq")
1545: 
1546:                 loc_nTubos = 0
1547:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaMaq") AND ;
1548:                         RECCOUNT("cursor_4c_BuscaMaq") > 0
1549:                     SELECT cursor_4c_BuscaMaq
1550:                     loc_nTubos = cursor_4c_BuscaMaq.tubos
1551:                     THIS.this_nMaqTubos = loc_nTubos
1552:                     THIS.AtualizarVisibilidadeCheckboxes(loc_nTubos)
1553:                 ELSE
1554:                     MsgAviso("M" + CHR(225) + "quina '" + loc_cCodMaq + ;
1555:                         "' n" + CHR(227) + "o encontrada.", ;
1556:                         "M" + CHR(225) + "quina")
1557:                     loc_oCnt1.txt_4c_Maq.Value = ""
1558:                     THIS.this_nMaqTubos = 0
1559:                     THIS.AtualizarVisibilidadeCheckboxes(0)
1560:                 ENDIF
1561: 
1562:                 IF USED("cursor_4c_BuscaMaq")
1563:                     USE IN cursor_4c_BuscaMaq
1564:                 ENDIF
1565:             ENDIF
1566:         CATCH TO loc_oErro
1567:             MsgErro("Erro em FormFUN.ValidarMaquina: " + loc_oErro.Message, "Erro")
1568:         ENDTRY
1569:     ENDPROC
1570: 
1571:     *==========================================================================
1572:     PROTECTED PROCEDURE AtualizarVisibilidadeCheckboxes(par_nMaqTubos)
1573:     *==========================================================================
1574:         LOCAL loc_oCnt, loc_n, loc_cNomeChk
1575: 
1576:         TRY
1577:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2
1578:             FOR loc_n = 1 TO 24
1579:                 loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
1580:                 IF PEMSTATUS(loc_oCnt, loc_cNomeChk, 5)
1581:                     loc_oCnt.Visible = (loc_n <= par_nMaqTubos)
1582:                 ENDIF
1583:             ENDFOR
1584:         CATCH TO loc_oErro
1585:             MsgErro("Erro em FormFUN.AtualizarVisibilidadeCheckboxes: " + loc_oErro.Message, "Erro")
1586:         ENDTRY
1587:     ENDPROC
1588: 
1589:     *==========================================================================
1590:     PROCEDURE ChkTubo(par_nTubo)

*-- Linhas 1601 a 1619:
1601:             loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2
1602:             loc_nMaqTubos = THIS.this_nMaqTubos
1603: 
1604:             *-- Atualizar caption do tubo corrente em Container4 (se lbl_4c_SayTubo existir)
1605:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4, "lbl_4c_SayTubo", 5)
1606:                 IF par_nTubo > 0
1607:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4.lbl_4c_SayTubo.Caption = ;
1608:                         "( " + PADL(TRANSFORM(par_nTubo), 2, "0") + " )"
1609:                 ELSE
1610:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4.lbl_4c_SayTubo.Caption = "( )"
1611:                 ENDIF
1612:             ENDIF
1613: 
1614:             *-- Atualizar imagens dos checkboxes baseado em TmpTrf/TmpNop/TmpCera
1615:             FOR loc_n = 1 TO loc_nMaqTubos
1616:                 loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
1617:                 IF PEMSTATUS(loc_oCnt, loc_cNomeChk, 5)
1618:                     loc_cPic = ""
1619: 

*-- Linhas 1741 a 1749:
1741:                 loc_oCnt1.txt_4c_Maq.Value = ""
1742:             ENDIF
1743: 
1744:             *-- Resetar OptionGroup e checkboxes (Container2)
1745:             IF PEMSTATUS(loc_oCnt2, "opt_4c_Status", 5)
1746:                 loc_oCnt2.opt_4c_Status.Value = 1
1747:             ENDIF
1748: 
1749:             FOR loc_n = 1 TO 24

*-- Linhas 1767 a 1775:
1767: 
1768:             THIS.this_nMaqTubos  = 0
1769:             THIS.this_nTuboAtual = 0
1770:             THIS.AtualizarVisibilidadeCheckboxes(0)
1771: 
1772:             *-- Limpar campos de entrada de Container3 se ja existem
1773:             loc_oCnt3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
1774:             IF PEMSTATUS(loc_oCnt3, "txt_4c_Nop", 5)
1775:                 loc_oCnt3.txt_4c_Nop.Value  = 0

*-- Linhas 1833 a 1843:
1833:                 loc_oCnt1.txt_4c_Maq.Value = ALLTRIM(loc_oBO.this_cCodMaqfs)
1834:             ENDIF
1835: 
1836:             *-- Numero de tubos da maquina -> visibilidade dos checkboxes
1837:             THIS.this_nMaqTubos = loc_oBO.this_nNTubos
1838:             THIS.AtualizarVisibilidadeCheckboxes(THIS.this_nMaqTubos)
1839: 
1840:             *-- Limpar cursores antes de recarregar
1841:             IF USED("TmpCera")
1842:                 ZAP IN TmpCera
1843:             ENDIF

*-- Linhas 1981 a 1989:
1981:                     NVL(loc_oBO.this_mObsG, "")
1982:             ENDIF
1983: 
1984:             *-- Atualizar imagens dos checkboxes baseado em TmpCera.nStatus
1985:             IF USED("TmpCera") AND RECCOUNT("TmpCera") > 0
1986:                 SELECT TmpCera
1987:                 SET ORDER TO Tubos
1988:                 GO TOP
1989:                 DO WHILE !EOF()

*-- Linhas 2055 a 2164:
2055:         LOCAL loc_oCnt
2056:         loc_oCnt = par_oPagina.cnt_4c_Container3
2057: 
2058:         loc_oCnt.AddObject("lbl_4c_SayNop", "Label")
2059:         WITH loc_oCnt.lbl_4c_SayNop
2060:             .Caption   = "O.P. n" + CHR(186) + " :"
2061:             .Left      = 20
2062:             .Top       = 6
2063:             .AutoSize  = .T.
2064:             .FontBold  = .T.
2065:             .BackStyle = 0
2066:             .ForeColor = RGB(36, 84, 155)
2067:         ENDWITH
2068: 
2069:         loc_oCnt.AddObject("txt_4c_Nop", "TextBox")
2070:         WITH loc_oCnt.txt_4c_Nop
2071:             .Value     = 0
2072:             .InputMask = "9999999999"
2073:             .Left      = 73
2074:             .Top       = 4
2075:             .Width     = 94
2076:             .Height    = 20
2077:             .FontName  = "Tahoma"
2078:             .FontSize  = 8
2079:         ENDWITH
2080:         BINDEVENT(loc_oCnt.txt_4c_Nop, "KeyPress", THIS, "NopLostFocus")
2081: 
2082:         loc_oCnt.AddObject("lbl_4c_SayComp", "Label")
2083:         WITH loc_oCnt.lbl_4c_SayComp
2084:             .Caption   = "Componentes:"
2085:             .Left      = 171
2086:             .Top       = 6
2087:             .AutoSize  = .T.
2088:             .FontBold  = .T.
2089:             .BackStyle = 0
2090:             .ForeColor = RGB(36, 84, 155)
2091:         ENDWITH
2092: 
2093:         loc_oCnt.AddObject("txt_4c_Qtd", "TextBox")
2094:         WITH loc_oCnt.txt_4c_Qtd
2095:             .Value     = 0
2096:             .Left      = 260
2097:             .Top       = 4
2098:             .Width     = 87
2099:             .Height    = 20
2100:             .ReadOnly  = .T.
2101:             .FontName  = "Tahoma"
2102:             .FontSize  = 8
2103:             .BackColor = RGB(240, 240, 240)
2104:         ENDWITH
2105: 
2106:         loc_oCnt.AddObject("lbl_4c_SayQtTb", "Label")
2107:         WITH loc_oCnt.lbl_4c_SayQtTb
2108:             .Caption   = "Qtde Tubo :"
2109:             .Left      = 2
2110:             .Top       = 27
2111:             .AutoSize  = .T.
2112:             .FontBold  = .T.
2113:             .BackStyle = 0
2114:             .ForeColor = RGB(36, 84, 155)
2115:         ENDWITH
2116: 
2117:         loc_oCnt.AddObject("txt_4c_QtTb", "TextBox")
2118:         WITH loc_oCnt.txt_4c_QtTb
2119:             .Value     = 0
2120:             .InputMask = "9999999999.999"
2121:             .Left      = 73
2122:             .Top       = 25
2123:             .Width     = 94
2124:             .Height    = 20
2125:             .FontName  = "Tahoma"
2126:             .FontSize  = 8
2127:         ENDWITH
2128:         BINDEVENT(loc_oCnt.txt_4c_QtTb, "KeyPress", THIS, "QtTbLostFocus")
2129: 
2130:         loc_oCnt.AddObject("lbl_4c_SayPecas", "Label")
2131:         WITH loc_oCnt.lbl_4c_SayPecas
2132:             .Caption   = "Qtd. Pe" + CHR(231) + "as :"
2133:             .Left      = 185
2134:             .Top       = 27
2135:             .AutoSize  = .T.
2136:             .FontBold  = .T.
2137:             .BackStyle = 0
2138:             .ForeColor = RGB(36, 84, 155)
2139:         ENDWITH
2140: 
2141:         loc_oCnt.AddObject("txt_4c_Pecas", "TextBox")
2142:         WITH loc_oCnt.txt_4c_Pecas
2143:             .Value     = 0
2144:             .Left      = 260
2145:             .Top       = 25
2146:             .Width     = 87
2147:             .Height    = 20
2148:             .ReadOnly  = .T.
2149:             .FontName  = "Tahoma"
2150:             .FontSize  = 8
2151:             .BackColor = RGB(240, 240, 240)
2152:         ENDWITH
2153: 
2154:         loc_oCnt.AddObject("grd_4c_Gradenop", "Grid")
2155:         loc_oCnt.grd_4c_Gradenop.ColumnCount = 5
2156:         loc_oCnt.grd_4c_Gradenop.RecordSource = "TmpNop"
2157:         WITH loc_oCnt.grd_4c_Gradenop
2158:             .Top          = 48
2159:             .Left         = 7
2160:             .Width        = 435
2161:             .Height       = 122
2162:             .FontName     = "Tahoma"
2163:             .FontSize     = 8
2164:             .ReadOnly     = .T.

*-- Linhas 2170 a 2302:
2170:         ENDWITH
2171: 
2172:         WITH loc_oCnt.grd_4c_Gradenop.Column1
2173:             .Header1.Caption = "O.P."
2174:             .ControlSource   = "TmpNop.Nops"
2175:             .Width           = 60
2176:         ENDWITH
2177: 
2178:         WITH loc_oCnt.grd_4c_Gradenop.Column2
2179:             .Header1.Caption = "Produto"
2180:             .ControlSource   = "TmpNop.Cpros"
2181:             .Width           = 110
2182:         ENDWITH
2183: 
2184:         WITH loc_oCnt.grd_4c_Gradenop.Column3
2185:             .Header1.Caption = "Qtde"
2186:             .ControlSource   = "TmpNop.Qtds"
2187:             .Width           = 60
2188:         ENDWITH
2189: 
2190:         WITH loc_oCnt.grd_4c_Gradenop.Column4
2191:             .Header1.Caption = "Pedido"
2192:             .ControlSource   = "TmpNop.Numes"
2193:             .Width           = 50
2194:         ENDWITH
2195: 
2196:         WITH loc_oCnt.grd_4c_Gradenop.Column5
2197:             .Header1.Caption = "Data Entrega"
2198:             .ControlSource   = "TmpNop.DtEnts"
2199:             .Width           = 90
2200:         ENDWITH
2201:         BINDEVENT(loc_oCnt.grd_4c_Gradenop, "AfterRowColChange", THIS, "GradenopAfterRowColChange")
2202: 
2203:         loc_oCnt.AddObject("txt_4c_Operacao", "TextBox")
2204:         WITH loc_oCnt.txt_4c_Operacao
2205:             .Value     = ""
2206:             .Left      = 18
2207:             .Top       = 171
2208:             .Width     = 290
2209:             .Height    = 25
2210:             .ReadOnly  = .T.
2211:             .FontName  = "Tahoma"
2212:             .FontSize  = 8
2213:             .BackColor = RGB(240, 240, 240)
2214:         ENDWITH
2215: 
2216:         loc_oCnt.AddObject("cmd_4c_AdicionarNop", "CommandButton")
2217:         WITH loc_oCnt.cmd_4c_AdicionarNop
2218:             .Caption         = ""
2219:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
2220:             .PicturePosition = 4
2221:             .Top             = 172
2222:             .Left            = 384
2223:             .Width           = 40
2224:             .Height          = 40
2225:             .Themes          = .T.
2226:             .SpecialEffect   = 0
2227:             .MousePointer    = 15
2228:         ENDWITH
2229:         BINDEVENT(loc_oCnt.cmd_4c_AdicionarNop, "Click", THIS, "AdicionarNopClick")
2230: 
2231:         loc_oCnt.AddObject("lbl_4c_SayCopiar", "Label")
2232:         WITH loc_oCnt.lbl_4c_SayCopiar
2233:             .Caption   = "Copiar Tubo :"
2234:             .Left      = 5
2235:             .Top       = 232
2236:             .AutoSize  = .T.
2237:             .FontBold  = .T.
2238:             .BackStyle = 0
2239:             .ForeColor = RGB(36, 84, 155)
2240:         ENDWITH
2241: 
2242:         loc_oCnt.AddObject("txt_4c_Tubo", "TextBox")
2243:         WITH loc_oCnt.txt_4c_Tubo
2244:             .Value     = 0
2245:             .InputMask = "99"
2246:             .Left      = 89
2247:             .Top       = 230
2248:             .Width     = 21
2249:             .Height    = 20
2250:             .FontName  = "Tahoma"
2251:             .FontSize  = 8
2252:         ENDWITH
2253:         BINDEVENT(loc_oCnt.txt_4c_Tubo, "KeyPress", THIS, "TuboLostFocus")
2254: 
2255:         loc_oCnt.AddObject("chk_4c_ChkRep", "CheckBox")
2256:         WITH loc_oCnt.chk_4c_ChkRep
2257:             .Caption   = "Repetir nosTubos"
2258:             .Left      = 5
2259:             .Top       = 253
2260:             .Width     = 118
2261:             .Height    = 15
2262:             .Value     = 0
2263:             .FontName  = "Tahoma"
2264:             .FontSize  = 8
2265:             .BackStyle = 0
2266:         ENDWITH
2267: 
2268:         loc_oCnt.AddObject("lbl_4c_SayTrf", "Label")
2269:         WITH loc_oCnt.lbl_4c_SayTrf
2270:             .Caption   = "Transforma" + CHR(231) + CHR(245) + "es :"
2271:             .Left      = 5
2272:             .Top       = 275
2273:             .AutoSize  = .T.
2274:             .FontBold  = .T.
2275:             .BackStyle = 0
2276:             .ForeColor = RGB(36, 84, 155)
2277:         ENDWITH
2278: 
2279:         loc_oCnt.AddObject("txt_4c_Trf", "TextBox")
2280:         WITH loc_oCnt.txt_4c_Trf
2281:             .Value     = ""
2282:             .MaxLength = 20
2283:             .Left      = 108
2284:             .Top       = 273
2285:             .Width     = 80
2286:             .Height    = 20
2287:             .FontName  = "Tahoma"
2288:             .FontSize  = 8
2289:         ENDWITH
2290:         BINDEVENT(loc_oCnt.txt_4c_Trf, "KeyPress", THIS, "TrfLostFocus")
2291: 
2292:         loc_oCnt.AddObject("grd_4c_GradeTrf", "Grid")
2293:         loc_oCnt.grd_4c_GradeTrf.ColumnCount = 2
2294:         loc_oCnt.grd_4c_GradeTrf.RecordSource = "TmpTrf"
2295:         WITH loc_oCnt.grd_4c_GradeTrf
2296:             .Top          = 216
2297:             .Left         = 209
2298:             .Width        = 233
2299:             .Height       = 122
2300:             .FontName     = "Tahoma"
2301:             .FontSize     = 8
2302:             .ReadOnly     = .T.

*-- Linhas 2308 a 2398:
2308:         ENDWITH
2309: 
2310:         WITH loc_oCnt.grd_4c_GradeTrf.Column1
2311:             .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
2312:             .ControlSource   = "TmpTrf.Dopes"
2313:             .Width           = 155
2314:         ENDWITH
2315: 
2316:         WITH loc_oCnt.grd_4c_GradeTrf.Column2
2317:             .Header1.Caption = "Numes"
2318:             .ControlSource   = "TmpTrf.Numes"
2319:             .Width           = 55
2320:         ENDWITH
2321: 
2322:         loc_oCnt.AddObject("cmd_4c_RemoverTrf", "CommandButton")
2323:         WITH loc_oCnt.cmd_4c_RemoverTrf
2324:             .Caption         = ""
2325:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
2326:             .PicturePosition = 4
2327:             .Top             = 297
2328:             .Left            = 165
2329:             .Width           = 40
2330:             .Height          = 40
2331:             .Themes          = .T.
2332:             .SpecialEffect   = 0
2333:             .MousePointer    = 15
2334:         ENDWITH
2335:         BINDEVENT(loc_oCnt.cmd_4c_RemoverTrf, "Click", THIS, "RemoverTrfClick")
2336:     ENDPROC
2337: 
2338:     *==========================================================================
2339:     PROTECTED PROCEDURE ConfigurarContainer4(par_oPagina)
2340:     *==========================================================================
2341:         LOCAL loc_oCnt
2342:         loc_oCnt = par_oPagina.cnt_4c_Container4
2343: 
2344:         loc_oCnt.AddObject("lbl_4c_ObsTubo", "Label")
2345:         WITH loc_oCnt.lbl_4c_ObsTubo
2346:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Tubo"
2347:             .Left      = 14
2348:             .Top       = 3
2349:             .AutoSize  = .T.
2350:             .FontBold  = .T.
2351:             .BackStyle = 0
2352:             .ForeColor = RGB(36, 84, 155)
2353:         ENDWITH
2354: 
2355:         loc_oCnt.AddObject("lbl_4c_SayTubo", "Label")
2356:         WITH loc_oCnt.lbl_4c_SayTubo
2357:             .Caption   = "( )"
2358:             .Left      = 148
2359:             .Top       = 3
2360:             .AutoSize  = .T.
2361:             .BackStyle = 0
2362:             .ForeColor = RGB(36, 84, 155)
2363:         ENDWITH
2364: 
2365:         loc_oCnt.AddObject("lbl_4c_ObsGeral", "Label")
2366:         WITH loc_oCnt.lbl_4c_ObsGeral
2367:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o Geral"
2368:             .Left      = 342
2369:             .Top       = 2
2370:             .AutoSize  = .T.
2371:             .FontBold  = .T.
2372:             .BackStyle = 0
2373:             .ForeColor = RGB(36, 84, 155)
2374:         ENDWITH
2375: 
2376:         loc_oCnt.AddObject("edt_4c_Obs", "EditBox")
2377:         WITH loc_oCnt.edt_4c_Obs
2378:             .Value      = ""
2379:             .Left       = 9
2380:             .Top        = 19
2381:             .Width      = 328
2382:             .Height     = 95
2383:             .FontName   = "Tahoma"
2384:             .FontSize   = 8
2385:             .ScrollBars = 2
2386:         ENDWITH
2387:         BINDEVENT(loc_oCnt.edt_4c_Obs, "LostFocus", THIS, "SalvarDadosTubo")
2388: 
2389:         loc_oCnt.AddObject("edt_4c_ObsG", "EditBox")
2390:         WITH loc_oCnt.edt_4c_ObsG
2391:             .Value      = ""
2392:             .Left       = 340
2393:             .Top        = 18
2394:             .Width      = 328
2395:             .Height     = 95
2396:             .FontName   = "Tahoma"
2397:             .FontSize   = 8
2398:             .ScrollBars = 2

*-- Linhas 2405 a 2581:
2405:         LOCAL loc_oCnt
2406:         loc_oCnt = par_oPagina.cnt_4c_Container5
2407: 
2408:         loc_oCnt.AddObject("lbl_4c_ConvTitle", "Label")
2409:         WITH loc_oCnt.lbl_4c_ConvTitle
2410:             .Caption   = "Convers" + CHR(227) + "o Cera/Metal"
2411:             .Left      = 4
2412:             .Top       = 2
2413:             .AutoSize  = .T.
2414:             .FontBold  = .T.
2415:             .BackStyle = 0
2416:             .ForeColor = RGB(36, 84, 155)
2417:         ENDWITH
2418: 
2419:         loc_oCnt.AddObject("lbl_4c_CorLabel", "Label")
2420:         WITH loc_oCnt.lbl_4c_CorLabel
2421:             .Caption   = "Cor"
2422:             .Left      = 5
2423:             .Top       = 19
2424:             .AutoSize  = .T.
2425:             .BackStyle = 0
2426:             .ForeColor = RGB(36, 84, 155)
2427:         ENDWITH
2428: 
2429:         loc_oCnt.AddObject("txt_4c_Cor", "TextBox")
2430:         WITH loc_oCnt.txt_4c_Cor
2431:             .Value     = ""
2432:             .MaxLength = 4
2433:             .Left      = 5
2434:             .Top       = 33
2435:             .Width     = 38
2436:             .Height    = 23
2437:             .FontName  = "Tahoma"
2438:             .FontSize  = 8
2439:         ENDWITH
2440:         BINDEVENT(loc_oCnt.txt_4c_Cor, "KeyPress",  THIS, "CorKeyPress")
2441:         BINDEVENT(loc_oCnt.txt_4c_Cor, "DblClick",  THIS, "CorDblClick")
2442:         BINDEVENT(loc_oCnt.txt_4c_Cor, "KeyPress", THIS, "ValidarCor")
2443: 
2444:         loc_oCnt.AddObject("lbl_4c_BasecLabel", "Label")
2445:         WITH loc_oCnt.lbl_4c_BasecLabel
2446:             .Caption   = "Base Cera"
2447:             .Left      = 45
2448:             .Top       = 19
2449:             .AutoSize  = .T.
2450:             .BackStyle = 0
2451:             .ForeColor = RGB(36, 84, 155)
2452:         ENDWITH
2453: 
2454:         loc_oCnt.AddObject("txt_4c_Basec", "TextBox")
2455:         WITH loc_oCnt.txt_4c_Basec
2456:             .Value     = 0
2457:             .InputMask = "999999999.99"
2458:             .Left      = 44
2459:             .Top       = 33
2460:             .Width     = 100
2461:             .Height    = 23
2462:             .FontName  = "Tahoma"
2463:             .FontSize  = 8
2464:         ENDWITH
2465:         BINDEVENT(loc_oCnt.txt_4c_Basec, "KeyPress", THIS, "BasecLostFocus")
2466: 
2467:         loc_oCnt.AddObject("lbl_4c_BaseLabel", "Label")
2468:         WITH loc_oCnt.lbl_4c_BaseLabel
2469:             .Caption   = "Base"
2470:             .Left      = 145
2471:             .Top       = 20
2472:             .AutoSize  = .T.
2473:             .BackStyle = 0
2474:             .ForeColor = RGB(36, 84, 155)
2475:         ENDWITH
2476: 
2477:         loc_oCnt.AddObject("txt_4c_Base", "TextBox")
2478:         WITH loc_oCnt.txt_4c_Base
2479:             .Value     = 0
2480:             .InputMask = "999999999.99"
2481:             .Left      = 144
2482:             .Top       = 33
2483:             .Width     = 100
2484:             .Height    = 23
2485:             .FontName  = "Tahoma"
2486:             .FontSize  = 8
2487:         ENDWITH
2488:         BINDEVENT(loc_oCnt.txt_4c_Base, "KeyPress", THIS, "BaseLostFocus")
2489: 
2490:         loc_oCnt.AddObject("lbl_4c_CeraLabel", "Label")
2491:         WITH loc_oCnt.lbl_4c_CeraLabel
2492:             .Caption   = "Cera"
2493:             .Left      = 5
2494:             .Top       = 61
2495:             .AutoSize  = .T.
2496:             .BackStyle = 0
2497:             .ForeColor = RGB(36, 84, 155)
2498:         ENDWITH
2499: 
2500:         loc_oCnt.AddObject("txt_4c_Cera", "TextBox")
2501:         WITH loc_oCnt.txt_4c_Cera
2502:             .Value     = 0
2503:             .InputMask = "999999999.99"
2504:             .Left      = 5
2505:             .Top       = 74
2506:             .Width     = 83
2507:             .Height    = 23
2508:             .ReadOnly  = .T.
2509:             .FontName  = "Tahoma"
2510:             .FontSize  = 8
2511:             .BackColor = RGB(240, 240, 240)
2512:         ENDWITH
2513: 
2514:         loc_oCnt.AddObject("lbl_4c_PesoMetalLabel", "Label")
2515:         WITH loc_oCnt.lbl_4c_PesoMetalLabel
2516:             .Caption   = "Peso Metal"
2517:             .Left      = 88
2518:             .Top       = 61
2519:             .AutoSize  = .T.
2520:             .BackStyle = 0
2521:             .ForeColor = RGB(36, 84, 155)
2522:         ENDWITH
2523: 
2524:         loc_oCnt.AddObject("txt_4c_Metal", "TextBox")
2525:         WITH loc_oCnt.txt_4c_Metal
2526:             .Value     = 0
2527:             .InputMask = "999999999.99"
2528:             .Left      = 88
2529:             .Top       = 74
2530:             .Width     = 82
2531:             .Height    = 23
2532:             .ReadOnly  = .T.
2533:             .FontName  = "Tahoma"
2534:             .FontSize  = 8
2535:             .BackColor = RGB(240, 240, 240)
2536:         ENDWITH
2537: 
2538:         loc_oCnt.AddObject("lbl_4c_PesoRealLabel", "Label")
2539:         WITH loc_oCnt.lbl_4c_PesoRealLabel
2540:             .Caption   = "Peso Metal Real"
2541:             .Left      = 5
2542:             .Top       = 102
2543:             .AutoSize  = .T.
2544:             .BackStyle = 0
2545:             .ForeColor = RGB(36, 84, 155)
2546:         ENDWITH
2547: 
2548:         loc_oCnt.AddObject("txt_4c_Mreal", "TextBox")
2549:         WITH loc_oCnt.txt_4c_Mreal
2550:             .Value     = 0
2551:             .InputMask = "999999999.99"
2552:             .Left      = 5
2553:             .Top       = 115
2554:             .Width     = 100
2555:             .Height    = 23
2556:             .FontName  = "Tahoma"
2557:             .FontSize  = 8
2558:         ENDWITH
2559:         BINDEVENT(loc_oCnt.txt_4c_Mreal, "LostFocus", THIS, "SalvarDadosTubo")
2560: 
2561:         loc_oCnt.AddObject("lbl_4c_MetalNovoLabel", "Label")
2562:         WITH loc_oCnt.lbl_4c_MetalNovoLabel
2563:             .Caption   = "Metal Novo"
2564:             .Left      = 106
2565:             .Top       = 102
2566:             .AutoSize  = .T.
2567:             .BackStyle = 0
2568:             .ForeColor = RGB(36, 84, 155)
2569:         ENDWITH
2570: 
2571:         loc_oCnt.AddObject("txt_4c_metnovo", "TextBox")
2572:         WITH loc_oCnt.txt_4c_metnovo
2573:             .Value     = 0
2574:             .InputMask = "999999999.99"
2575:             .Left      = 106
2576:             .Top       = 115
2577:             .Width     = 100
2578:             .Height    = 23
2579:             .ReadOnly  = .T.
2580:             .FontName  = "Tahoma"
2581:             .FontSize  = 8

*-- Linhas 2589 a 2703:
2589:         LOCAL loc_oCnt
2590:         loc_oCnt = par_oPagina.cnt_4c_Container6
2591: 
2592:         loc_oCnt.AddObject("lbl_4c_TempFundTitle", "Label")
2593:         WITH loc_oCnt.lbl_4c_TempFundTitle
2594:             .Caption   = "Temperatura Fundi" + CHR(231) + CHR(227) + "o"
2595:             .Left      = 5
2596:             .Top       = 2
2597:             .AutoSize  = .T.
2598:             .FontBold  = .T.
2599:             .BackStyle = 0
2600:             .ForeColor = RGB(36, 84, 155)
2601:         ENDWITH
2602: 
2603:         loc_oCnt.AddObject("lbl_4c_TempMetLabel", "Label")
2604:         WITH loc_oCnt.lbl_4c_TempMetLabel
2605:             .Caption   = "Metal"
2606:             .Left      = 5
2607:             .Top       = 20
2608:             .AutoSize  = .T.
2609:             .BackStyle = 0
2610:             .ForeColor = RGB(36, 84, 155)
2611:         ENDWITH
2612: 
2613:         loc_oCnt.AddObject("txt_4c_TempMet", "TextBox")
2614:         WITH loc_oCnt.txt_4c_TempMet
2615:             .Value     = ""
2616:             .MaxLength = 15
2617:             .Left      = 5
2618:             .Top       = 36
2619:             .Width     = 115
2620:             .Height    = 23
2621:             .FontName  = "Tahoma"
2622:             .FontSize  = 8
2623:         ENDWITH
2624:         BINDEVENT(loc_oCnt.txt_4c_TempMet, "LostFocus", THIS, "SalvarDadosTubo")
2625: 
2626:         loc_oCnt.AddObject("lbl_4c_TempTubLabel", "Label")
2627:         WITH loc_oCnt.lbl_4c_TempTubLabel
2628:             .Caption   = "Tubo"
2629:             .Left      = 123
2630:             .Top       = 20
2631:             .AutoSize  = .T.
2632:             .BackStyle = 0
2633:             .ForeColor = RGB(36, 84, 155)
2634:         ENDWITH
2635: 
2636:         loc_oCnt.AddObject("txt_4c_TempTub", "TextBox")
2637:         WITH loc_oCnt.txt_4c_TempTub
2638:             .Value     = ""
2639:             .MaxLength = 15
2640:             .Left      = 123
2641:             .Top       = 36
2642:             .Width     = 115
2643:             .Height    = 23
2644:             .FontName  = "Tahoma"
2645:             .FontSize  = 8
2646:         ENDWITH
2647:         BINDEVENT(loc_oCnt.txt_4c_TempTub, "LostFocus", THIS, "SalvarDadosTubo")
2648: 
2649:         loc_oCnt.AddObject("lbl_4c_TempRevTitle", "Label")
2650:         WITH loc_oCnt.lbl_4c_TempRevTitle
2651:             .Caption   = "Temperatura Revestimento"
2652:             .Left      = 4
2653:             .Top       = 61
2654:             .AutoSize  = .T.
2655:             .FontBold  = .T.
2656:             .BackStyle = 0
2657:             .ForeColor = RGB(36, 84, 155)
2658:         ENDWITH
2659: 
2660:         loc_oCnt.AddObject("lbl_4c_TempAmbLabel", "Label")
2661:         WITH loc_oCnt.lbl_4c_TempAmbLabel
2662:             .Caption   = "Ambiente"
2663:             .Left      = 5
2664:             .Top       = 77
2665:             .AutoSize  = .T.
2666:             .BackStyle = 0
2667:             .ForeColor = RGB(36, 84, 155)
2668:         ENDWITH
2669: 
2670:         loc_oCnt.AddObject("txt_4c_TempAmb", "TextBox")
2671:         WITH loc_oCnt.txt_4c_TempAmb
2672:             .Value     = ""
2673:             .MaxLength = 15
2674:             .Left      = 5
2675:             .Top       = 93
2676:             .Width     = 115
2677:             .Height    = 23
2678:             .FontName  = "Tahoma"
2679:             .FontSize  = 8
2680:         ENDWITH
2681:         BINDEVENT(loc_oCnt.txt_4c_TempAmb, "LostFocus", THIS, "SalvarDadosTubo")
2682: 
2683:         loc_oCnt.AddObject("lbl_4c_TempAguLabel", "Label")
2684:         WITH loc_oCnt.lbl_4c_TempAguLabel
2685:             .Caption   = CHR(193) + "gua"
2686:             .Left      = 123
2687:             .Top       = 77
2688:             .AutoSize  = .T.
2689:             .BackStyle = 0
2690:             .ForeColor = RGB(36, 84, 155)
2691:         ENDWITH
2692: 
2693:         loc_oCnt.AddObject("txt_4c_TempAgu", "TextBox")
2694:         WITH loc_oCnt.txt_4c_TempAgu
2695:             .Value     = ""
2696:             .MaxLength = 15
2697:             .Left      = 123
2698:             .Top       = 93
2699:             .Width     = 115
2700:             .Height    = 23
2701:             .FontName  = "Tahoma"
2702:             .FontSize  = 8
2703:         ENDWITH

*-- Linhas 2710 a 2799:
2710:         LOCAL loc_oCnt
2711:         loc_oCnt = par_oPagina.cnt_4c_Total
2712: 
2713:         loc_oCnt.AddObject("lbl_4c_TotalMetal", "Label")
2714:         WITH loc_oCnt.lbl_4c_TotalMetal
2715:             .Caption   = "Total de Metal"
2716:             .Left      = 6
2717:             .Top       = 5
2718:             .AutoSize  = .T.
2719:             .FontBold  = .T.
2720:             .BackStyle = 0
2721:             .ForeColor = RGB(36, 84, 155)
2722:         ENDWITH
2723: 
2724:         loc_oCnt.AddObject("grd_4c_TmpTot", "Grid")
2725:         loc_oCnt.grd_4c_TmpTot.ColumnCount = 4
2726:         WITH loc_oCnt.grd_4c_TmpTot
2727:             .Top                     = 49
2728:             .Left                    = 28
2729:             .Width                   = 354
2730:             .Height                  = 122
2731:             .FontName                = "Tahoma"
2732:             .FontSize                = 8
2733:             .ReadOnly                = .T.
2734:             .GridLines               = 1
2735:             .HeaderHeight            = 17
2736:             .RowHeight               = 17
2737:             .Column1.Header1.Caption = "Tipo " + CHR(193) + "rvore"
2738:             .Column1.Width           = 80
2739:             .Column2.Header1.Caption = "Metal Real"
2740:             .Column2.Width           = 80
2741:             .Column3.Header1.Caption = "Metal Novo"
2742:             .Column3.Width           = 80
2743:             .Column4.Header1.Caption = "Metal Ligado"
2744:             .Column4.Width           = 80
2745:             .RecordMark   = .F.
2746:             .DeleteMark   = .F.
2747:         ENDWITH
2748: 
2749:         loc_oCnt.AddObject("cmd_4c_Retornar", "CommandButton")
2750:         WITH loc_oCnt.cmd_4c_Retornar
2751:             .Caption         = "Retornar"
2752:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_26.jpg"
2753:             .PicturePosition = 13
2754:             .Top             = 11
2755:             .Left            = 415
2756:             .Width           = 75
2757:             .Height          = 75
2758:             .FontName        = "Tahoma"
2759:             .FontBold        = .T.
2760:             .FontItalic      = .T.
2761:             .FontSize        = 8
2762:             .ForeColor       = RGB(90, 90, 90)
2763:             .BackColor       = RGB(255, 255, 255)
2764:             .Themes          = .F.
2765:             .SpecialEffect   = 0
2766:             .MousePointer    = 15
2767:             .WordWrap        = .T.
2768:             .AutoSize        = .F.
2769:         ENDWITH
2770:         BINDEVENT(loc_oCnt.cmd_4c_Retornar, "Click", THIS, "BtnCancelarTotalClick")
2771:     ENDPROC
2772: 
2773:     *==========================================================================
2774:     PROTECTED PROCEDURE ConfigurarCamposPage2(par_oPagina)
2775:     *==========================================================================
2776:         *-- lbl_4c_TipoArvoreLabel: Say4 top=98+29=127, left=327
2777:         par_oPagina.AddObject("lbl_4c_TipoArvoreLabel", "Label")
2778:         WITH par_oPagina.lbl_4c_TipoArvoreLabel
2779:             .Caption   = "Tipo " + CHR(193) + "rvore :"
2780:             .Left      = 327
2781:             .Top       = 127
2782:             .AutoSize  = .T.
2783:             .FontBold  = .T.
2784:             .BackStyle = 0
2785:             .ForeColor = RGB(36, 84, 155)
2786:         ENDWITH
2787: 
2788:         *-- txt_4c_codarvore: top=93+29=122, left=416
2789:         par_oPagina.AddObject("txt_4c_codarvore", "TextBox")
2790:         WITH par_oPagina.txt_4c_codarvore
2791:             .Value     = ""
2792:             .MaxLength = 10
2793:             .Left      = 416
2794:             .Top       = 122
2795:             .Width     = 79
2796:             .Height    = 25
2797:             .FontName  = "Tahoma"
2798:             .FontSize  = 8
2799:         ENDWITH

*-- Linhas 2806 a 2833:
2806:         WITH par_oPagina.txt_4c_descarvore
2807:             .Value     = ""
2808:             .MaxLength = 40
2809:             .Left      = 497
2810:             .Top       = 122
2811:             .Width     = 200
2812:             .Height    = 25
2813:             .ReadOnly  = .T.
2814:             .FontName  = "Tahoma"
2815:             .FontSize  = 8
2816:             .BackColor = RGB(240, 240, 240)
2817:         ENDWITH
2818:         BINDEVENT(par_oPagina.txt_4c_descarvore, "KeyPress", THIS, "ArvoreDescKeyPress")
2819:         BINDEVENT(par_oPagina.txt_4c_descarvore, "DblClick", THIS, "ArvoreDescDblClick")
2820: 
2821:         *-- cmd_4c_BtnTotal: top=12+29=41, left=718
2822:         par_oPagina.AddObject("cmd_4c_BtnTotal", "CommandButton")
2823:         WITH par_oPagina.cmd_4c_BtnTotal
2824:             .Caption         = "Total Metal"
2825:             .Picture         = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
2826:             .PicturePosition = 13
2827:             .Top             = 41
2828:             .Left            = 718
2829:             .Width           = 80
2830:             .Height          = 100
2831:             .FontName        = "Tahoma"
2832:             .FontBold        = .T.
2833:             .FontItalic      = .T.

*-- Linhas 2840 a 2848:
2840:             .WordWrap        = .T.
2841:             .AutoSize        = .F.
2842:         ENDWITH
2843:         BINDEVENT(par_oPagina.cmd_4c_BtnTotal, "Click", THIS, "BtnTotalClick")
2844:     ENDPROC
2845: 
2846:     *==========================================================================
2847:     PROCEDURE SalvarDadosTubo()
2848:     *==========================================================================


### BO (C:\4c\projeto\app\classes\FUNBO.prg):
*==============================================================================
* FUNBO.prg - Business Object para Cadastro de Fundicoes (SIGCDFUN)
* Tabela principal : SIGCDFUN (cabecalho)
* Tabela detalhe   : SigCdFud (tubos, ordens de producao, transferencias)
*==============================================================================

DEFINE CLASS FUNBO AS BusinessBase

	*-- SIGCDFUN: campos do cabecalho
	this_nCodigos   = 0    && codigos   numeric(6,0) - ID da fundicao
	this_cCidChaves = ""   && cidchaves char(20)     - PK fisica
	this_cEmps      = ""   && emps      char(3)      - empresa
	this_dDatas     = {}   && datas     datetime     - data da fundicao
	this_cCodMaqfs  = ""   && codmaqfs  char(10)     - codigo da maquina
	this_cUsuars    = ""   && usuars    char(10)      - usuario que registrou
	this_mObsG      = ""   && obss      text         - observacao geral do cabecalho

	*-- Propriedade de trabalho: numero de tubos da maquina (SigCfMqf.Tubos)
	*   Lido no CarregarPorCodigo via JOIN, devolvido ao form em BOParaForm
	this_nNTubos    = 0

	*==========================================================================
	PROCEDURE Init()
	*==========================================================================
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDFUN"
		THIS.this_cCampoChave = "codigos"
		RETURN .T.
	ENDPROC

	*==========================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
	*==========================================================================
		RETURN TRANSFORM(THIS.this_nCodigos)
	ENDPROC

	*==========================================================================
	* Buscar - Retorna lista de fundicoes em cursor_4c_Dados
	* par_cFiltro: fragmento WHERE sem a palavra WHERE
	*==========================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF VARTYPE(par_cFiltro) != "C"
				par_cFiltro = ""
			ENDIF

			loc_cSQL = "SELECT f.codigos, f.emps, f.datas, f.usuars, f.codmaqfs," + ;
			           " f.ntubos," + ;
			           " ISNULL(CAST(f.obss AS NVARCHAR(200)), '') AS obss" + ;
			           " FROM SIGCDFUN f"

			IF !EMPTY(ALLTRIM(par_cFiltro))
				loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY f.datas DESC, f.codigos DESC"

			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (codigos N(6,0), emps C(3), datas T, ;
					    usuars C(10), codmaqfs C(10), ntubos N(2,0), obss C(200))
					SET NULL OFF
				ENDIF
				MsgErro("Erro ao buscar fundi" + CHR(231) + CHR(245) + "es:" + ;
				    CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em FUNBO.Buscar: " + loc_oErro.Message, "Erro")
			IF !USED("cursor_4c_Dados")
				SET NULL ON
				CREATE CURSOR cursor_4c_Dados (codigos N(6,0), emps C(3), datas T, ;
				    usuars C(10), codmaqfs C(10), ntubos N(2,0), obss C(200))
				SET NULL OFF
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CarregarPorCodigo - Carrega registro pelo codigos (ID numerico)
	* Tambem carrega this_nNTubos (numero de tubos da maquina) via JOIN SigCfMqf
	*==========================================================================
	PROCEDURE CarregarPorCodigo(par_nCodigos)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT f.codigos, f.cidchaves, f.emps, f.datas," + ;
			           " f.codmaqfs, f.usuars," + ;
			           " ISNULL(CAST(f.obss AS NVARCHAR(MAX)), '') AS obss," + ;
			           " ISNULL(m.tubos, 24) AS ntubos" + ;
			           " FROM SIGCDFUN f" + ;
			           " LEFT JOIN SigCfMqf m ON m.codigos = f.codmaqfs" + ;
			           " WHERE f.codigos = " + TRANSFORM(par_nCodigos)

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega") AND ;
			        RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				MsgErro("Fundi" + CHR(231) + CHR(227) + "o " + ;
				    TRANSFORM(par_nCodigos) + " n" + CHR(227) + "o encontrada.", "Aviso")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em FUNBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CarregarDoCursor - Popula propriedades a partir de cursor aberto
	*==========================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_nCodigos   = TratarNulo(codigos,   "N")
			THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
			THIS.this_cEmps      = TratarNulo(emps,      "C")
			THIS.this_dDatas     = TratarNulo(datas,     "D")
			THIS.this_cCodMaqfs  = TratarNulo(codmaqfs,  "C")
			THIS.this_cUsuars    = TratarNulo(usuars,    "C")
			THIS.this_mObsG      = TratarNulo(obss,      "C")
			THIS.this_nNTubos    = TratarNulo(ntubos,    "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Inserir - INSERT SIGCDFUN + SigCdFud (PROTECTED - chamado por Salvar())
	*==========================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
		LOCAL loc_nCodigos, loc_cChave, loc_nNTuboFlag
		loc_lSucesso = .F.

		TRY
			*-- Flag de tubos em producao (nTubos em SIGCDFUN): 1 se nStatus 2 ou 3
			loc_nNTuboFlag = THIS.CalcularFlagNTubos()

			*-- Gerar proximo codigos via SQL Server
			loc_nResultado = SQLEXEC(gnConnHandle, ;
			    "SELECT ISNULL(MAX(codigos), 0) + 1 AS prox FROM SIGCDFUN", ;
			    "cursor_4c_FunNextId")
			IF loc_nResultado < 0 OR !USED("cursor_4c_FunNextId")
				MsgErro("Erro ao gerar ID de fundi" + CHR(231) + CHR(227) + "o: " + ;
				    CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_nCodigos = cursor_4c_FunNextId.prox
				USE IN cursor_4c_FunNextId

				THIS.this_nCodigos = loc_nCodigos

				*-- Gerar cidchaves (20 chars via SYS(2015))
				loc_cChave = SYS(2015) + SYS(2015)
				THIS.this_cCidChaves = loc_cChave

				*-- Campos automaticos
				IF EMPTY(THIS.this_cUsuars)
					THIS.this_cUsuars = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
				ENDIF
				IF EMPTY(THIS.this_cEmps)
					THIS.this_cEmps = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
				ENDIF

				SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

				loc_cSQL = "INSERT INTO SIGCDFUN" + ;
				    " (cidchaves, codigos, emps, datas, datars," + ;
				    " codmaqfs, horas, ntubos, usuars, obss)" + ;
				    " VALUES (" + ;
				    EscaparSQL(loc_cChave) + "," + ;
				    TRANSFORM(loc_nCodigos) + "," + ;
				    EscaparSQL(THIS.this_cEmps) + "," + ;
				    FormatarDataSQL(THIS.this_dDatas) + "," + ;
				    GETDATE() + "," + ;
				    EscaparSQL(ALLTRIM(NVL(THIS.this_cCodMaqfs, ""))) + "," + ;
				    EscaparSQL(SUBSTR(TIME(), 1, 8)) + "," + ;
				    TRANSFORM(loc_nNTuboFlag) + "," + ;
				    EscaparSQL(ALLTRIM(NVL(THIS.this_cUsuars, ""))) + "," + ;
				    THIS.PrepararMemoSQL(THIS.this_mObsG) + ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResultado < 0
					SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					MsgErro("Erro ao inserir fundi" + CHR(231) + CHR(227) + "o:" + ;
					    CHR(13) + CapturarErroSQL(), "Erro SQL")
				ELSE
					IF THIS.InserirDetalhesSigCdFud(loc_nCodigos)
						SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
						THIS.RegistrarAuditoria("INSERT")
						loc_lSucesso = .T.
					ELSE
						SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro em FUNBO.Inserir: " + loc_oErro.Message + ;
			    " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Atualizar - UPDATE SIGCDFUN + recriar SigCdFud (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nNTuboFlag
		loc_lSucesso = .F.

		TRY
			loc_nNTuboFlag = THIS.CalcularFlagNTubos()

			IF EMPTY(THIS.this_cUsuars)
				THIS.this_cUsuars = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
			ENDIF

			SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

			loc_cSQL = "UPDATE SIGCDFUN SET" + ;
			    " emps     = " + EscaparSQL(THIS.this_cEmps) + "," + ;
			    " datas    = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
			    " datars   = " + GETDATE() + "," + ;
			    " codmaqfs = " + EscaparSQL(ALLTRIM(NVL(THIS.this_cCodMaqfs, ""))) + "," + ;
			    " horas    = " + EscaparSQL(SUBSTR(TIME(), 1, 8)) + "," + ;
			    " ntubos   = " + TRANSFORM(loc_nNTuboFlag) + "," + ;
			    " usuars   = " + EscaparSQL(ALLTRIM(NVL(THIS.this_cUsuars, ""))) + "," + ;
			    " obss     = " + THIS.PrepararMemoSQL(THIS.this_mObsG) + ;
			    " WHERE codigos = " + TRANSFORM(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado < 0
				SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
				MsgErro("Erro ao atualizar fundi" + CHR(231) + CHR(227) + "o:" + ;
				    CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				*-- Excluir detalhes antigos e reinserir dos cursores de trabalho
				loc_nResultado = SQLEXEC(gnConnHandle, ;
				    "DELETE FROM SigCdFud WHERE codigos = " + TRANSFORM(THIS.this_nCodigos))
				IF loc_nResultado < 0
					SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					MsgErro("Erro ao excluir detalhes antigos da fundi" + CHR(231) + CHR(227) + "o:" + ;
					    CHR(13) + CapturarErroSQL(), "Erro SQL")
				ELSE
					IF THIS.InserirDetalhesSigCdFud(THIS.this_nCodigos)
						SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
						THIS.RegistrarAuditoria("UPDATE")
						loc_lSucesso = .T.
					ELSE
						SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro em FUNBO.Atualizar: " + loc_oErro.Message + ;
			    " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ExecutarExclusao - DELETE SIGCDFUN + SigCdFud (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lSucesso, loc_nResultado
		loc_lSucesso = .F.

		TRY
			SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

			loc_nResultado = SQLEXEC(gnConnHandle, ;
			    "DELETE FROM SIGCDFUN WHERE codigos = " + TRANSFORM(THIS.this_nCodigos))
			IF loc_nResultado < 0
				SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
				MsgErro("Erro ao excluir fundi" + CHR(231) + CHR(227) + "o:" + ;
				    CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_nResultado = SQLEXEC(gnConnHandle, ;
				    "DELETE FROM SigCdFud WHERE codigos = " + TRANSFORM(THIS.this_nCodigos))
				IF loc_nResultado < 0
					SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					MsgErro("Erro ao excluir detalhes da fundi" + CHR(231) + CHR(227) + "o:" + ;
					    CHR(13) + CapturarErroSQL(), "Erro SQL")
				ELSE
					SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
					THIS.RegistrarAuditoria("DELETE")
					loc_lSucesso = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro em FUNBO.ExecutarExclusao: " + loc_oErro.Message + ;
			    " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* InserirDetalhesSigCdFud - Insere linhas de SigCdFud a partir de
	*   TmpTrf (transferencias), TmpNop (ordens de producao), TmpCera (tubos)
	*==========================================================================
	PROTECTED PROCEDURE InserirDetalhesSigCdFud(par_nCodigos)
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cChave
		LOCAL loc_cDopes, loc_nNNumes, loc_nTubos
		LOCAL loc_nNops, loc_nQtds, loc_nQtdos
		LOCAL loc_nBCeras, loc_nBases, loc_cCodCors, loc_cCodArvs
		LOCAL loc_nMetals, loc_nMetalNvs, loc_nNStatus
		LOCAL loc_cTmpMets, loc_cTmpAmbs, loc_cTmpTubs, loc_cTmpAgus
		loc_lSucesso = .T.

		TRY
			*------------------------------------------------------------------
			* 1. TmpTrf -> SigCdFud (transferencias/lancamentos de operacao)
			*    Condicao de skip: Dopes vazio OU nNumes = 0
			*------------------------------------------------------------------
			IF USED("TmpTrf") AND RECCOUNT("TmpTrf") > 0
				SELECT TmpTrf
				SET ORDER TO
				GO TOP
				DO WHILE !EOF() AND loc_lSucesso
					loc_cDopes  = ALLTRIM(TmpTrf.Dopes)
					loc_nNNumes = TmpTrf.nNumes
					loc_nTubos  = TmpTrf.Tubos

					IF !EMPTY(loc_cDopes) AND loc_nNNumes > 0
						loc_cChave  = SYS(2015) + SYS(2015)
						loc_cSQL = "INSERT INTO SigCdFud" + ;
						    " (cidchaves, codigos, tubos, nnumes, nops, qtds, qtdos," + ;
						    " bceras, bases, metals, metalnvs, nstatus," + ;
						    " codcors, codarvs, obss," + ;
						    " tempmets, tempambs, temptubs, tempagus)" + ;
						    " VALUES (" + ;
						    EscaparSQL(loc_cChave) + "," + ;
						    TRANSFORM(par_nCodigos) + "," + ;
						    TRANSFORM(loc_nTubos) + "," + ;
						    TRANSFORM(loc_nNNumes) + "," + ;
						    "0,0,0," + ;
						    "0,0,0,0,0," + ;
						    "'','',NULL," + ;
						    "'','','','')"
						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResultado < 0
							MsgErro("Erro ao inserir transfer" + CHR(234) + "ncia" + ;
							    " (tubo " + TRANSFORM(loc_nTubos) + ") em SigCdFud:" + ;
							    CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ENDIF
					ENDIF

					SELECT TmpTrf
					SKIP
				ENDDO
			ENDIF

			*------------------------------------------------------------------
			* 2. TmpNop -> SigCdFud (ordens de producao)
			*    Condicao de skip: nops = 0 OU qtdos = 0
			*------------------------------------------------------------------
			IF loc_lSucesso AND USED("TmpNop") AND RECCOUNT("TmpNop") > 0
				SELECT TmpNop
				SET ORDER TO
				GO TOP
				DO WHILE !EOF() AND loc_lSucesso
					loc_nNops  = TmpNop.Nops
					loc_nQtds  = TmpNop.Qtds
					loc_nTubos = TmpNop.Tubos
					loc_nQtdos = TmpNop.Qtdos

					IF loc_nNops > 0 AND loc_nQtdos > 0
						loc_cChave = SYS(2015) + SYS(2015)
						loc_cSQL = "INSERT INTO SigCdFud" + ;
						    " (cidchaves, codigos, tubos, nops, qtds, qtdos, nnumes," + ;
						    " bceras, bases, metals, metalnvs, nstatus," + ;
						    " codcors, codarvs, obss," + ;
						    " tempmets, tempambs, temptubs, tempagus)" + ;
						    " VALUES (" + ;
						    EscaparSQL(loc_cChave) + "," + ;
						    TRANSFORM(par_nCodigos) + "," + ;
						    TRANSFORM(loc_nTubos) + "," + ;
						    TRANSFORM(loc_nNops) + "," + ;
						    FormatarNumeroSQL(loc_nQtds, 3) + "," + ;
						    FormatarNumeroSQL(loc_nQtdos, 3) + "," + ;
						    "0," + ;
						    "0,0,0,0,0," + ;
						    "'','',NULL," + ;
						    "'','','','')"
						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResultado < 0
							MsgErro("Erro ao inserir O.P. " + TRANSFORM(loc_nNops) + ;
							    " (tubo " + TRANSFORM(loc_nTubos) + ") em SigCdFud:" + ;
							    CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ENDIF
					ENDIF

					SELECT TmpNop
					SKIP
				ENDDO
			ENDIF

			*------------------------------------------------------------------
			* 3. TmpCera -> SigCdFud (dados de cera/metal por tubo)
			*    Condicao de skip: bceras = 0 E bases = 0 (tubo sem dados)
			*    metals em SigCdFud = pmetalrs (peso real do metal, digitado)
			*------------------------------------------------------------------
			IF loc_lSucesso AND USED("TmpCera") AND RECCOUNT("TmpCera") > 0
				SELECT TmpCera
				SET ORDER TO
				GO TOP
				DO WHILE !EOF() AND loc_lSucesso
					loc_nBCeras   = TmpCera.BCeras
					loc_nBases    = TmpCera.Bases
					loc_nTubos    = TmpCera.Tubos
					loc_cCodCors  = ALLTRIM(NVL(TmpCera.CodCors, ""))
					loc_cCodArvs  = ALLTRIM(NVL(TmpCera.CodArvs, ""))
					loc_nMetals   = TmpCera.pmetalrs   && peso real (digitado)
					loc_nMetalNvs = TmpCera.MetalNvs
					loc_nNStatus  = TmpCera.nStatus
					loc_cTmpMets  = ALLTRIM(NVL(TmpCera.TempMets, ""))
					loc_cTmpAmbs  = ALLTRIM(NVL(TmpCera.TempAmbs, ""))
					loc_cTmpTubs  = ALLTRIM(NVL(TmpCera.TempTubs, ""))
					loc_cTmpAgus  = ALLTRIM(NVL(TmpCera.TempAgus, ""))

					IF !(loc_nBCeras = 0 AND loc_nBases = 0)
						loc_cChave = SYS(2015) + SYS(2015)
						loc_cSQL = "INSERT INTO SigCdFud" + ;
						    " (cidchaves, codigos, tubos," + ;
						    " bceras, bases, metals, metalnvs, nstatus," + ;
						    " codcors, codarvs, nnumes, nops, qtds, qtdos," + ;
						    " obss, tempmets, tempambs, temptubs, tempagus)" + ;
						    " VALUES (" + ;
						    EscaparSQL(loc_cChave) + "," + ;
						    TRANSFORM(par_nCodigos) + "," + ;
						    TRANSFORM(loc_nTubos) + "," + ;
						    FormatarNumeroSQL(loc_nBCeras, 2) + "," + ;
						    FormatarNumeroSQL(loc_nBases,  2) + "," + ;
						    FormatarNumeroSQL(loc_nMetals,   2) + "," + ;
						    FormatarNumeroSQL(loc_nMetalNvs, 2) + "," + ;
						    TRANSFORM(loc_nNStatus) + "," + ;
						    EscaparSQL(loc_cCodCors) + "," + ;
						    EscaparSQL(loc_cCodArvs) + "," + ;
						    "0,0,0,0," + ;
						    THIS.PrepararMemoSQL(NVL(TmpCera.Obss, "")) + "," + ;
						    EscaparSQL(loc_cTmpMets) + "," + ;
						    EscaparSQL(loc_cTmpAmbs) + "," + ;
						    EscaparSQL(loc_cTmpTubs) + "," + ;
						    EscaparSQL(loc_cTmpAgus) + ")"

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResultado < 0
							MsgErro("Erro ao inserir tubo " + TRANSFORM(loc_nTubos) + ;
							    " em SigCdFud:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ENDIF
					ENDIF

					SELECT TmpCera
					SKIP
				ENDDO
			ENDIF

		CATCH TO loc_oErro
			MsgErro("Erro em FUNBO.InserirDetalhesSigCdFud: " + loc_oErro.Message + ;
			    " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CalcularFlagNTubos - Retorna 1 se ha tubos em producao (nStatus 2 ou 3)
	*   Corresponde ao campo SIGCDFUN.ntubos (flag vermelho na grade)
	*==========================================================================
	PROTECTED PROCEDURE CalcularFlagNTubos()
		LOCAL loc_nFlag
		loc_nFlag = 0

		IF USED("TmpCera") AND RECCOUNT("TmpCera") > 0
			SELECT TmpCera
			LOCATE FOR TmpCera.nStatus = 2 OR TmpCera.nStatus = 3
			IF FOUND()
				loc_nFlag = 1
			ENDIF
		ENDIF

		RETURN loc_nFlag
	ENDPROC

	*==========================================================================
	* PrepararMemoSQL - Prepara campo memo/texto para SQL (NULL ou 'texto')
	*==========================================================================
	PROTECTED PROCEDURE PrepararMemoSQL(par_mTexto)
		LOCAL loc_cValor
		loc_cValor = ALLTRIM(NVL(CAST(par_mTexto AS CHARACTER), ""))

		IF EMPTY(loc_cValor)
			RETURN "NULL"
		ENDIF

		loc_cValor = SUBSTR(loc_cValor, 1, 4000)
		loc_cValor = STRTRAN(loc_cValor, "'", "''")

		RETURN "'" + loc_cValor + "'"
	ENDPROC

ENDDEFINE

