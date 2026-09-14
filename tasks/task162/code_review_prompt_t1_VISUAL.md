# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (11)
- [FONTNAME-ERRADO] Linha 262: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 281: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 299: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 317: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 335: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 354: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 373: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 392: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1066: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1331: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1578: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3527 linhas total):

*-- Linhas 11 a 19:
11: * FASE 3/8: Estrutura base - DEFINE CLASS, Init, InicializarForm,
12: *           ConfigurarPageFrame, ConfigurarCabecalho, TornarControlesVisiveis,
13: *           Destroy. Tambem: ConfigurarGrupoBotoes (obj_4c_CmdGok 9 botoes),
14: *           ConfigurarGrid (grd_4c_Dados 10 colunas, cmd_4c_Tudo1/Apaga1).
15: * FASE 4/8: ConfigurarFiltros (Shape2/Shape1, Grupo/Conta/Periodo lookups,
16: *           Processar, TxtFavorecido), AlternarPagina.
17: * FASE 5/8: Propriedades de estado do form. ConfigurarPaginaDados(),
18: *           ConfigurarContainerJustificativa (cnt_4c_Justificativa),
19: *           ConfigurarContainerProcurar (cnt_4c_Procurar).

*-- Linhas 82 a 91:
82:                 *-- Modo validacao UI: configura estrutura visual sem SQL
83:                 THIS.ConfigurarPageFrame()
84:                 THIS.ConfigurarCabecalho()
85:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
86:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
87:                 THIS.ConfigurarGrupoBotoes()
88:                 THIS.ConfigurarGrid()
89:                 THIS.ConfigurarFiltros()
90:                 THIS.ConfigurarContainerJustificativa()
91:                 THIS.ConfigurarContainerProcurar()

*-- Linhas 111 a 120:
111: 
112:                             *-- Cabecalho cinza escuro com titulo
113:                             THIS.ConfigurarCabecalho()
114:                             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
115:                             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
116: 
117:                             *-- Grupo de botoes, grid e filtros
118:                             THIS.ConfigurarGrupoBotoes()
119:                             THIS.ConfigurarGrid()
120:                             THIS.ConfigurarFiltros()

*-- Linhas 148 a 156:
148:         LOCAL loc_cImgFundo
149: 
150:         *-- Titulo (TitleBar=0, nao exibido, mas util para rastreamento)
151:         THIS.Caption = "Processamento de Cheques"
152: 
153:         *-- Imagem de fundo do framework (identica ao legado new_background.jpg)
154:         loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
155:         IF FILE(loc_cImgFundo)
156:             THIS.Picture = loc_cImgFundo

*-- Linhas 169 a 229:
169:     *--------------------------------------------------------------------------
170:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
171:         WITH THIS.cnt_4c_Cabecalho
172:             .Top         = 0
173:             .Left        = 0
174:             .Width       = 1000
175:             .Height      = 80
176:             .BackStyle   = 1
177:             .BackColor   = RGB(100, 100, 100)
178:             .BorderWidth = 0
179:             .Visible     = .T.
180: 
181:             *-- Label sombra (efeito de profundidade - ForeColor preto, ligeiramente deslocada)
182:             .AddObject("lbl_4c_Sombra", "Label")
183:             WITH .lbl_4c_Sombra
184:                 .Top       = 25
185:                 .Left      = 10
186:                 .Width     = 1000
187:                 .Height    = 40
188:                 .AutoSize  = .F.
189:                 .BackStyle = 0
190:                 .FontBold  = .T.
191:                 .FontName  = "Tahoma"
192:                 .FontSize  = 18
193:                 .ForeColor = RGB(0, 0, 0)
194:                 .Caption   = "Processamento de Cheques"
195:                 .Visible   = .T.
196:             ENDWITH
197: 
198:             *-- Label titulo (ForeColor branco sobre fundo cinza escuro)
199:             .AddObject("lbl_4c_Titulo", "Label")
200:             WITH .lbl_4c_Titulo
201:                 .Top       = 24
202:                 .Left      = 10
203:                 .Width     = 1000
204:                 .Height    = 46
205:                 .AutoSize  = .F.
206:                 .BackStyle = 0
207:                 .FontBold  = .T.
208:                 .FontName  = "Tahoma"
209:                 .FontSize  = 18
210:                 .ForeColor = RGB(255, 255, 255)
211:                 .Caption   = "Processamento de Cheques"
212:                 .Visible   = .T.
213:             ENDWITH
214:         ENDWITH
215:     ENDPROC
216: 
217:     *--------------------------------------------------------------------------
218:     PROTECTED PROCEDURE ConfigurarGrupoBotoes()
219:     *  CommandGroup obj_4c_CmdGok com 9 botoes. Escala 1.25x (original Top=-3, Left=11, Width=789).
220:     *--------------------------------------------------------------------------
221:         THIS.AddObject("obj_4c_CmdGok", "CommandGroup")
222:         WITH THIS.obj_4c_CmdGok
223:             .Top           = -3
224:             .Left          = 14
225:             .Width         = 986
226:             .Height        = 160
227:             .ButtonCount   = 9
228:             .BackStyle     = 0
229:             .BorderStyle   = 0

*-- Linhas 236 a 418:
236: 
237:             *-- Buttons(1): Documento (original Left=473 -> 591)
238:             WITH .Buttons(1)
239:                 .Top             = 121
240:                 .Left            = 591
241:                 .Height          = 37
242:                 .Width           = 120
243:                 .Caption         = "\<Documento"
244:                 .FontBold        = .T.
245:                 .FontItalic      = .T.
246:                 .PicturePosition = 1
247:                 .ForeColor       = RGB(90, 90, 90)
248:                 .BackColor       = RGB(255, 255, 255)
249:                 .Themes          = .F.
250:                 .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
251:             ENDWITH
252: 
253:             *-- Buttons(2): Encerrar (original Left=713 -> 891)
254:             WITH .Buttons(2)
255:                 .Top             = 6
256:                 .Left            = 891
257:                 .Height          = 75
258:                 .Width           = 75
259:                 .Caption         = "Encerrar"
260:                 .FontBold        = .T.
261:                 .FontItalic      = .T.
262:                 .FontName        = "Comic Sans MS"
263:                 .FontSize        = 8
264:                 .Cancel          = .T.
265:                 .ToolTipText     = "[Esc] Encerrar"
266:                 .ForeColor       = RGB(90, 90, 90)
267:                 .BackColor       = RGB(255, 255, 255)
268:                 .Themes          = .F.
269:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
270:             ENDWITH
271: 
272:             *-- Buttons(3): Imprimir (original Left=353 -> 441)
273:             WITH .Buttons(3)
274:                 .Top             = 84
275:                 .Left            = 441
276:                 .Height          = 37
277:                 .Width           = 120
278:                 .Caption         = "\<Imprimir"
279:                 .FontBold        = .T.
280:                 .FontItalic      = .T.
281:                 .FontName        = "Comic Sans MS"
282:                 .FontSize        = 8
283:                 .PicturePosition = 1
284:                 .ForeColor       = RGB(90, 90, 90)
285:                 .BackColor       = RGB(255, 255, 255)
286:                 .Themes          = .F.
287:                 .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
288:             ENDWITH
289: 
290:             *-- Buttons(4): Procurar (original Left=593 -> 741)
291:             WITH .Buttons(4)
292:                 .Top             = 84
293:                 .Left            = 741
294:                 .Height          = 37
295:                 .Width           = 120
296:                 .Caption         = "\<Procurar"
297:                 .FontBold        = .T.
298:                 .FontItalic      = .T.
299:                 .FontName        = "Comic Sans MS"
300:                 .FontSize        = 8
301:                 .PicturePosition = 1
302:                 .ForeColor       = RGB(90, 90, 90)
303:                 .BackColor       = RGB(255, 255, 255)
304:                 .Themes          = .F.
305:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
306:             ENDWITH
307: 
308:             *-- Buttons(5): Recibo (original Left=593 -> 741)
309:             WITH .Buttons(5)
310:                 .Top             = 121
311:                 .Left            = 741
312:                 .Height          = 37
313:                 .Width           = 120
314:                 .Caption         = "\<Recibo"
315:                 .FontBold        = .T.
316:                 .FontItalic      = .T.
317:                 .FontName        = "Comic Sans MS"
318:                 .FontSize        = 8
319:                 .PicturePosition = 1
320:                 .ForeColor       = RGB(90, 90, 90)
321:                 .BackColor       = RGB(255, 255, 255)
322:                 .Themes          = .F.
323:                 .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
324:             ENDWITH
325: 
326:             *-- Buttons(6): Exclui Docto (original Left=473 -> 591)
327:             WITH .Buttons(6)
328:                 .Top             = 84
329:                 .Left            = 591
330:                 .Height          = 37
331:                 .Width           = 120
332:                 .Caption         = "E\<xclui Docto."
333:                 .FontBold        = .T.
334:                 .FontItalic      = .T.
335:                 .FontName        = "Comic Sans MS"
336:                 .FontSize        = 8
337:                 .PicturePosition = 1
338:                 .ToolTipText     = "Exclui Documento"
339:                 .ForeColor       = RGB(90, 90, 90)
340:                 .BackColor       = RGB(255, 255, 255)
341:                 .Themes          = .F.
342:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
343:             ENDWITH
344: 
345:             *-- Buttons(7): Cheque (impressora jacto) (original Left=353 -> 441)
346:             WITH .Buttons(7)
347:                 .Top             = 121
348:                 .Left            = 441
349:                 .Height          = 37
350:                 .Width           = 120
351:                 .Caption         = "Che\<que"
352:                 .FontBold        = .T.
353:                 .FontItalic      = .T.
354:                 .FontName        = "Comic Sans MS"
355:                 .FontSize        = 8
356:                 .PicturePosition = 1
357:                 .ToolTipText     = "Impressora de cheque"
358:                 .ForeColor       = RGB(90, 90, 90)
359:                 .BackColor       = RGB(255, 255, 255)
360:                 .Themes          = .F.
361:                 .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
362:             ENDWITH
363: 
364:             *-- Buttons(8): Chq. Matric. (original Left=233 -> 291)
365:             WITH .Buttons(8)
366:                 .Top             = 84
367:                 .Left            = 291
368:                 .Height          = 37
369:                 .Width           = 120
370:                 .Caption         = "Chq. \<Matric."
371:                 .FontBold        = .T.
372:                 .FontItalic      = .T.
373:                 .FontName        = "Comic Sans MS"
374:                 .FontSize        = 8
375:                 .PicturePosition = 1
376:                 .ToolTipText     = "Impressora matricial"
377:                 .ForeColor       = RGB(90, 90, 90)
378:                 .BackColor       = RGB(255, 255, 255)
379:                 .Themes          = .F.
380:                 .Picture         = gc_4c_CaminhoIcones + "cheque.png"
381:             ENDWITH
382: 
383:             *-- Buttons(9): Excluir Chq. (original Left=233 -> 291)
384:             WITH .Buttons(9)
385:                 .Top             = 121
386:                 .Left            = 291
387:                 .Height          = 37
388:                 .Width           = 120
389:                 .Caption         = "Excluir Chq."
390:                 .FontBold        = .T.
391:                 .FontItalic      = .T.
392:                 .FontName        = "Comic Sans MS"
393:                 .FontSize        = 8
394:                 .PicturePosition = 1
395:                 .ToolTipText     = "Exclui Cheque"
396:                 .ForeColor       = RGB(90, 90, 90)
397:                 .BackColor       = RGB(255, 255, 255)
398:                 .Themes          = .F.
399:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
400:             ENDWITH
401:         ENDWITH
402:     ENDPROC
403: 
404:     *--------------------------------------------------------------------------
405:     PROTECTED PROCEDURE ConfigurarGrid()
406:     *  Grid grd_4c_Dados (10 colunas) + cmd_4c_Tudo1 + cmd_4c_Apaga1.
407:     *  Original: Top=233, Left=24, Width=710, Height=291 -> escala 1.25x.
408:     *--------------------------------------------------------------------------
409:         THIS.AddObject("grd_4c_Dados", "Grid")
410:         THIS.grd_4c_Dados.ColumnCount = 10
411:         WITH THIS.grd_4c_Dados
412:             .Top               = 233
413:             .Left              = 30
414:             .Width             = 888
415:             .Height            = 291
416:             .FontName          = "Tahoma"
417:             .AllowHeaderSizing = .F.
418:             .AllowRowSizing    = .F.

*-- Linhas 430 a 438:
430:                 .Resizable         = .F.
431:                 .ReadOnly          = .T.
432:                 .FontName          = "Tahoma"
433:                 .Header1.Caption   = "Data"
434:                 .Header1.FontName  = "Tahoma"
435:                 .Header1.Alignment = 2
436:                 .Header1.ForeColor = RGB(90, 90, 90)
437:                 .Text1.BorderStyle = 0
438:                 .Text1.Format      = "K"

*-- Linhas 450 a 458:
450:                 .Resizable         = .F.
451:                 .ReadOnly          = .T.
452:                 .FontName          = "Tahoma"
453:                 .Header1.Caption   = "Conta"
454:                 .Header1.FontName  = "Tahoma"
455:                 .Header1.Alignment = 2
456:                 .Header1.ForeColor = RGB(90, 90, 90)
457:                 .Text1.BorderStyle = 0
458:                 .Text1.Format      = "K"

*-- Linhas 469 a 477:
469:                 .Resizable         = .F.
470:                 .ReadOnly          = .T.
471:                 .FontName          = "Tahoma"
472:                 .Header1.Caption   = "C" + CHR(243) + "pia"
473:                 .Header1.FontName  = "Tahoma"
474:                 .Header1.Alignment = 2
475:                 .Header1.ForeColor = RGB(90, 90, 90)
476:                 .Text1.BorderStyle = 0
477:                 .Text1.Format      = "K"

*-- Linhas 489 a 497:
489:                 .Resizable         = .F.
490:                 .ReadOnly          = .T.
491:                 .FontName          = "Tahoma"
492:                 .Header1.Caption   = "Bco"
493:                 .Header1.FontName  = "Tahoma"
494:                 .Header1.Alignment = 2
495:                 .Header1.ForeColor = RGB(90, 90, 90)
496:                 .Text1.BorderStyle = 0
497:                 .Text1.Format      = "K"

*-- Linhas 508 a 516:
508:                 .Resizable         = .F.
509:                 .ReadOnly          = .T.
510:                 .FontName          = "Tahoma"
511:                 .Header1.Caption   = "Ag."
512:                 .Header1.FontName  = "Tahoma"
513:                 .Header1.Alignment = 2
514:                 .Header1.ForeColor = RGB(90, 90, 90)
515:                 .Text1.BorderStyle = 0
516:                 .Text1.Format      = "K"

*-- Linhas 527 a 535:
527:                 .Resizable         = .F.
528:                 .ReadOnly          = .T.
529:                 .FontName          = "Tahoma"
530:                 .Header1.Caption   = "C.Corrente"
531:                 .Header1.FontName  = "Tahoma"
532:                 .Header1.Alignment = 2
533:                 .Header1.ForeColor = RGB(90, 90, 90)
534:                 .Text1.BorderStyle = 0
535:                 .Text1.Format      = "K"

*-- Linhas 546 a 554:
546:                 .Resizable         = .F.
547:                 .ReadOnly          = .T.
548:                 .FontName          = "Tahoma"
549:                 .Header1.Caption   = "Cheque"
550:                 .Header1.FontName  = "Tahoma"
551:                 .Header1.Alignment = 2
552:                 .Header1.ForeColor = RGB(90, 90, 90)
553:                 .Text1.BorderStyle = 0
554:                 .Text1.Format      = "K"

*-- Linhas 565 a 573:
565:                 .Resizable         = .F.
566:                 .ReadOnly          = .T.
567:                 .FontName          = "Tahoma"
568:                 .Header1.Caption   = "Situa" + CHR(231) + CHR(227) + "o"
569:                 .Header1.FontName  = "Tahoma"
570:                 .Header1.Alignment = 2
571:                 .Header1.ForeColor = RGB(90, 90, 90)
572:                 .Text1.BorderStyle = 0
573:                 .Text1.Format      = "K"

*-- Linhas 584 a 620:
584:                 .Resizable         = .F.
585:                 .ReadOnly          = .T.
586:                 .FontName          = "Tahoma"
587:                 .Header1.Caption   = "Valor"
588:                 .Header1.FontName  = "Tahoma"
589:                 .Header1.Alignment = 2
590:                 .Header1.ForeColor = RGB(90, 90, 90)
591:                 .Text1.BorderStyle = 0
592:                 .Text1.Format      = "K"
593:                 .Text1.InputMask   = "999,999,999.99"
594:                 .Text1.Margin      = 0
595:                 .Text1.MaxLength   = 14
596:                 .Text1.ReadOnly    = .T.
597:                 .Text1.FontName    = "Tahoma"
598:             ENDWITH
599: 
600:             *-- Column10 (clnImprime): ColumnOrder=1 (1a coluna), CheckBox para NMarca1s
601:             WITH .Column10
602:                 .ColumnOrder       = 1
603:                 .Width             = 69
604:                 .Movable           = .F.
605:                 .Resizable         = .F.
606:                 .ReadOnly          = .F.
607:                 .Sparse            = .F.
608:                 .FontName          = "Tahoma"
609:                 .Header1.Caption   = "Imprime"
610:                 .Header1.FontName  = "Tahoma"
611:                 .Header1.Alignment = 2
612:                 .Header1.ForeColor = RGB(90, 90, 90)
613:                 .AddObject("chk_4c_Imprime", "CheckBox")
614:                 WITH .chk_4c_Imprime
615:                     .Caption   = ""
616:                     .ReadOnly  = .F.
617:                     .Alignment = 0
618:                     .FontName  = "Tahoma"
619:                     .Visible   = .T.
620:                 ENDWITH

*-- Linhas 637 a 672:
637:         THIS.grd_4c_Dados.Column10.chk_4c_Imprime.ControlSource   = "CsSigCqChi.NMarca1s"
638: 
639:         *-- Botao Marcar Todos (original Top=334, Left=742 -> 928)
640:         THIS.AddObject("cmd_4c_Tudo1", "CommandButton")
641:         WITH THIS.cmd_4c_Tudo1
642:             .Top         = 334
643:             .Left        = 928
644:             .Height      = 40
645:             .Width       = 40
646:             .FontName    = "Verdana"
647:             .FontSize    = 8
648:             .Caption     = ""
649:             .TabStop     = .F.
650:             .ToolTipText = "Marca tudo"
651:             .ForeColor   = RGB(36, 84, 155)
652:             .BackColor   = RGB(255, 255, 255)
653:             .Themes           = .T.
654:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
655:             .Visible     = .T.
656:         ENDWITH
657: 
658:         *-- Botao Desmarcar Todos (original Top=375, Left=742 -> 928)
659:         THIS.AddObject("cmd_4c_Apaga1", "CommandButton")
660:         WITH THIS.cmd_4c_Apaga1
661:             .Top         = 375
662:             .Left        = 928
663:             .Height      = 40
664:             .Width       = 40
665:             .FontName    = "Verdana"
666:             .FontSize    = 8
667:             .Caption     = ""
668:             .TabStop     = .F.
669:             .ToolTipText = "Desmarca tudo"
670:             .ForeColor   = RGB(36, 84, 155)
671:             .BackColor   = RGB(255, 255, 255)
672:             .Themes           = .T.

*-- Linhas 719 a 727:
719:     *  Este metodo agrega a configuracao equivalente a "Page1 (Lista)":
720:     *    - obj_4c_CmdGok (CommandGroup com 9 botoes operacionais)
721:     *    - grd_4c_Dados (Grid principal de cheques, 10 colunas)
722:     *    - cmd_4c_Tudo1 / cmd_4c_Apaga1 (Marcar/Desmarcar Todos)
723:     *    - Filtros (Grupo, Conta, Periodo, Processar, Favorecido)
724:     *  Chamado por InicializarForm (compatibilidade com pipeline de migracao).
725:     *--------------------------------------------------------------------------
726:         THIS.ConfigurarGrupoBotoes()
727:         THIS.ConfigurarGrid()

*-- Linhas 741 a 750:
741:         *-- Shape2: borda ao redor da area de filtros (original Top=156, Width=774)
742:         THIS.AddObject("shp_4c_Shape2", "Shape")
743:         WITH THIS.shp_4c_Shape2
744:             .Top         = 156
745:             .Left        = 23
746:             .Width       = 968
747:             .Height      = 66
748:             .BackStyle   = 0
749:             .BorderStyle = 1
750:             .BorderWidth = 1

*-- Linhas 756 a 795:
756:         *-- Shape1: borda ao redor da grade de cheques (original Top=227, Width=774)
757:         THIS.AddObject("shp_4c_Shape1", "Shape")
758:         WITH THIS.shp_4c_Shape1
759:             .Top         = 227
760:             .Left        = 23
761:             .Width       = 968
762:             .Height      = 301
763:             .BackStyle   = 0
764:             .BorderStyle = 1
765:             .BorderWidth = 1
766:             .BorderColor = RGB(136, 189, 188)
767:             .Visible     = .T.
768:         ENDWITH
769:         THIS.shp_4c_Shape1.ZOrder(1)
770: 
771:         *-- Label "Grupo :" (original Label3: Top=167, Left=34)
772:         THIS.AddObject("lbl_4c_Label3", "Label")
773:         WITH THIS.lbl_4c_Label3
774:             .Top       = 167
775:             .Left      = 43
776:             .Width     = 48
777:             .Height    = 15
778:             .Caption   = "Grupo :"
779:             .FontName  = "Tahoma"
780:             .FontSize  = 8
781:             .BackStyle = 0
782:             .ForeColor = RGB(0, 0, 0)
783:             .Visible   = .T.
784:         ENDWITH
785: 
786:         *-- TextBox codigo grupo (original GetCdGrupos: Top=163, Left=75, Width=100)
787:         THIS.AddObject("txt_4c_CdGrupos", "TextBox")
788:         WITH THIS.txt_4c_CdGrupos
789:             .Top         = 163
790:             .Left        = 94
791:             .Width       = 125
792:             .Height      = 25
793:             .Value       = ""
794:             .MaxLength   = 10
795:             .FontName    = "Tahoma"

*-- Linhas 801 a 917:
801:         *-- TextBox descricao grupo (original GetDsGrupos: Top=163, Left=177, Width=360) - somente leitura
802:         THIS.AddObject("txt_4c_DsGrupos", "TextBox")
803:         WITH THIS.txt_4c_DsGrupos
804:             .Top         = 163
805:             .Left        = 221
806:             .Width       = 450
807:             .Height      = 25
808:             .Value       = ""
809:             .FontName    = "Tahoma"
810:             .FontSize    = 8
811:             .BorderStyle = 1
812:             .ReadOnly    = .T.
813:             .Visible     = .T.
814:         ENDWITH
815: 
816:         *-- Label "Per[i]odo :" (original Label2: Top=167, Left=550, Width=45)
817:         THIS.AddObject("lbl_4c_Label2", "Label")
818:         WITH THIS.lbl_4c_Label2
819:             .Top       = 167
820:             .Left      = 688
821:             .Width     = 56
822:             .Height    = 15
823:             .Caption   = "Per" + CHR(237) + "odo :"
824:             .FontName  = "Tahoma"
825:             .FontSize  = 8
826:             .BackStyle = 0
827:             .ForeColor = RGB(0, 0, 0)
828:             .Visible   = .T.
829:         ENDWITH
830: 
831:         *-- TextBox data inicial (original Dt_inicial: Top=163, Left=598, class fweditdata)
832:         THIS.AddObject("txt_4c_Dt_inicial", "TextBox")
833:         WITH THIS.txt_4c_Dt_inicial
834:             .Top         = 163
835:             .Left        = 748
836:             .Width       = 86
837:             .Height      = 25
838:             .Value       = DATE()
839:             .Format      = "D"
840:             .FontName    = "Tahoma"
841:             .FontSize    = 8
842:             .BorderStyle = 1
843:             .Visible     = .T.
844:         ENDWITH
845: 
846:         *-- Label "a" (original Say2: Top=167, Left=686)
847:         THIS.AddObject("lbl_4c_Say2", "Label")
848:         WITH THIS.lbl_4c_Say2
849:             .Top       = 167
850:             .Left      = 840
851:             .Width     = 15
852:             .Height    = 15
853:             .Caption   = "a"
854:             .FontName  = "Tahoma"
855:             .FontSize  = 8
856:             .BackStyle = 0
857:             .ForeColor = RGB(0, 0, 0)
858:             .Visible   = .T.
859:         ENDWITH
860: 
861:         *-- TextBox data final (original Dt_final: Top=163, Left=701, class fweditdata)
862:         THIS.AddObject("txt_4c_Dt_final", "TextBox")
863:         WITH THIS.txt_4c_Dt_final
864:             .Top         = 163
865:             .Left        = 858
866:             .Width       = 86
867:             .Height      = 25
868:             .Value       = DATE()
869:             .Format      = "D"
870:             .FontName    = "Tahoma"
871:             .FontSize    = 8
872:             .BorderStyle = 1
873:             .Visible     = .T.
874:         ENDWITH
875: 
876:         *-- Botao Processar (original Command2: Top=191, Left=598, Width=88, Height=24)
877:         THIS.AddObject("cmd_4c_Command2", "CommandButton")
878:         WITH THIS.cmd_4c_Command2
879:             .Top         = 191
880:             .Left        = 748
881:             .Width       = 110
882:             .Height      = 24
883:             .Caption     = "Processar"
884:             .FontName    = "Tahoma"
885:             .FontSize    = 8
886:             .FontBold    = .F.
887:             .ForeColor   = RGB(0, 0, 0)
888:             .BackColor   = RGB(236, 233, 216)
889:             .Themes      = .T.
890:             .Visible     = .T.
891:         ENDWITH
892: 
893:         *-- Label "Conta :" (original Label1: Top=194, Left=34, Width=38)
894:         THIS.AddObject("lbl_4c_Label1", "Label")
895:         WITH THIS.lbl_4c_Label1
896:             .Top       = 194
897:             .Left      = 43
898:             .Width     = 48
899:             .Height    = 15
900:             .Caption   = "Conta :"
901:             .FontName  = "Tahoma"
902:             .FontSize  = 8
903:             .BackStyle = 0
904:             .ForeColor = RGB(0, 0, 0)
905:             .Visible   = .T.
906:         ENDWITH
907: 
908:         *-- TextBox codigo conta (original getCdContas: Top=190, Left=75, Width=100)
909:         THIS.AddObject("txt_4c_CdContas", "TextBox")
910:         WITH THIS.txt_4c_CdContas
911:             .Top         = 190
912:             .Left        = 94
913:             .Width       = 125
914:             .Height      = 25
915:             .Value       = ""
916:             .MaxLength   = 10
917:             .FontName    = "Tahoma"

*-- Linhas 923 a 963:
923:         *-- TextBox descricao conta (original getDsContas: Top=190, Left=177, Width=360) - somente leitura
924:         THIS.AddObject("txt_4c_DsContas", "TextBox")
925:         WITH THIS.txt_4c_DsContas
926:             .Top         = 190
927:             .Left        = 221
928:             .Width       = 450
929:             .Height      = 25
930:             .Value       = ""
931:             .FontName    = "Tahoma"
932:             .FontSize    = 8
933:             .BorderStyle = 1
934:             .ReadOnly    = .T.
935:             .Visible     = .T.
936:         ENDWITH
937: 
938:         *-- Label "Favorecido :" (original Label5: Top=534, Left=24, Width=62)
939:         THIS.AddObject("lbl_4c_Label5", "Label")
940:         WITH THIS.lbl_4c_Label5
941:             .Top       = 534
942:             .Left      = 30
943:             .Width     = 78
944:             .Height    = 15
945:             .Caption   = "Favorecido :"
946:             .FontName  = "Tahoma"
947:             .FontSize  = 8
948:             .BackStyle = 0
949:             .ForeColor = RGB(0, 0, 0)
950:             .Visible   = .T.
951:         ENDWITH
952: 
953:         *-- TextBox favorecido (original txtFavorecido: Top=530, Left=99, Width=286, Height=25)
954:         *-- When retorna .F. no legado: nao editavel pelo usuario
955:         THIS.AddObject("txt_4c_TxtFavorecido", "TextBox")
956:         WITH THIS.txt_4c_TxtFavorecido
957:             .Top         = 530
958:             .Left        = 124
959:             .Width       = 358
960:             .Height      = 25
961:             .Value       = ""
962:             .FontName    = "Tahoma"
963:             .FontSize    = 8

*-- Linhas 987 a 1024:
987:     *--------------------------------------------------------------------------
988:         THIS.AddObject("cnt_4c_Justificativa", "Container")
989:         WITH THIS.cnt_4c_Justificativa
990:             .Top         = 532
991:             .Left        = 494
992:             .Width       = 438
993:             .Height      = 69
994:             .BackStyle   = 1
995:             .BackColor   = RGB(236, 233, 216)
996:             .BorderWidth = 1
997:             .Visible     = .F.
998: 
999:             *-- Label descricao (original: Label5, top=5, left=6, width=143)
1000:             .AddObject("lbl_4c_Label5", "Label")
1001:             WITH .lbl_4c_Label5
1002:                 .Top       = 5
1003:                 .Left      = 6
1004:                 .Width     = 179
1005:                 .Height    = 15
1006:                 .Caption   = "Justificativa do cancelamento"
1007:                 .FontName  = "Tahoma"
1008:                 .FontSize  = 8
1009:                 .BackStyle = 0
1010:                 .ForeColor = RGB(0, 0, 0)
1011:                 .Visible   = .T.
1012:             ENDWITH
1013: 
1014:             *-- EditBox para digitar a justificativa (original: get_justificativa, fwmemo)
1015:             *  Top=21, Left=3, Width=238, Height=44 -> Width=298 (escala 1.25x)
1016:             .AddObject("obj_4c_Get_justificativa", "EditBox")
1017:             WITH .obj_4c_Get_justificativa
1018:                 .Top         = 21
1019:                 .Left        = 3
1020:                 .Width       = 298
1021:                 .Height      = 44
1022:                 .Value       = ""
1023:                 .MaxLength   = 200
1024:                 .FontName    = "Tahoma"

*-- Linhas 1030 a 1072:
1030:             *  Escala 1.25x -> Left=304, Width=134
1031:             .AddObject("obj_4c_CmdGconf", "CommandGroup")
1032:             WITH .obj_4c_CmdGconf
1033:                 .Top           = 18
1034:                 .Left          = 304
1035:                 .Width         = 134
1036:                 .Height        = 47
1037:                 .ButtonCount   = 2
1038:                 .BackStyle     = 0
1039:                 .SpecialEffect = 1
1040:                 .Themes        = .F.
1041:                 .Visible       = .T.
1042: 
1043:                 *-- Buttons(1): Confirmar cancelamento (original: cmConfirmar)
1044:                 WITH .Buttons(1)
1045:                     .Top             = 2
1046:                     .Left            = 2
1047:                     .Width           = 60
1048:                     .Height          = 40
1049:                     .Caption         = "Confirmar"
1050:                     .FontBold        = .T.
1051:                     .FontItalic      = .T.
1052:                     .PicturePosition = 13
1053:                     .ForeColor       = RGB(90, 90, 90)
1054:                     .BackColor       = RGB(255, 255, 255)
1055:                     .Themes          = .F.
1056:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1057:                     .Visible         = .T.
1058:                 ENDWITH
1059: 
1060:                 *-- Buttons(2): Cancelar (fecha container sem confirmar)
1061:                 WITH .Buttons(2)
1062:                     .Top             = 2
1063:                     .Left            = 70
1064:                     .Width           = 60
1065:                     .Height          = 40
1066:                     .Caption         = "Cancelar"
1067:                     .FontName        = "Comic Sans MS"
1068:                     .FontBold        = .T.
1069:                     .FontItalic      = .T.
1070:                     .FontSize        = 8
1071:                     .PicturePosition = 13
1072:                     .ForeColor       = RGB(90, 90, 90)

*-- Linhas 1089 a 1259:
1089:     *--------------------------------------------------------------------------
1090:         THIS.AddObject("cnt_4c_Procurar", "Container")
1091:         WITH THIS.cnt_4c_Procurar
1092:             .Top         = 284
1093:             .Left        = 300
1094:             .Width       = 393
1095:             .Height      = 218
1096:             .BackStyle   = 1
1097:             .BackColor   = RGB(236, 233, 216)
1098:             .BorderWidth = 1
1099:             .Visible     = .F.
1100: 
1101:             *-- Label titulo (original: Label1, top=8, left=12, width=54, caption="Procurar")
1102:             .AddObject("lbl_4c_Label1", "Label")
1103:             WITH .lbl_4c_Label1
1104:                 .Top       = 8
1105:                 .Left      = 12
1106:                 .Width     = 68
1107:                 .Height    = 16
1108:                 .Caption   = "Procurar"
1109:                 .FontName  = "Tahoma"
1110:                 .FontSize  = 8
1111:                 .FontBold  = .T.
1112:                 .BackStyle = 0
1113:                 .ForeColor = RGB(0, 0, 0)
1114:                 .Visible   = .T.
1115:             ENDWITH
1116: 
1117:             *-- Label "Banco :" (original: lblBanco, top=139, left=36)
1118:             .AddObject("lbl_4c_LblBanco", "Label")
1119:             WITH .lbl_4c_LblBanco
1120:                 .Top       = 139
1121:                 .Left      = 45
1122:                 .Width     = 48
1123:                 .Height    = 15
1124:                 .Caption   = "Banco :"
1125:                 .FontName  = "Tahoma"
1126:                 .FontSize  = 8
1127:                 .BackStyle = 0
1128:                 .ForeColor = RGB(0, 0, 0)
1129:                 .Visible   = .T.
1130:             ENDWITH
1131: 
1132:             *-- Label "Agencia :" (original: lblAgencia, top=163, left=27)
1133:             .AddObject("lbl_4c_LblAgencia", "Label")
1134:             WITH .lbl_4c_LblAgencia
1135:                 .Top       = 163
1136:                 .Left      = 34
1137:                 .Width     = 59
1138:                 .Height    = 15
1139:                 .Caption   = "Ag" + CHR(234) + "ncia :"
1140:                 .FontName  = "Tahoma"
1141:                 .FontSize  = 8
1142:                 .BackStyle = 0
1143:                 .ForeColor = RGB(0, 0, 0)
1144:                 .Visible   = .T.
1145:             ENDWITH
1146: 
1147:             *-- Label "Conta :" (original: lblConta, top=187, left=36)
1148:             .AddObject("lbl_4c_LblConta", "Label")
1149:             WITH .lbl_4c_LblConta
1150:                 .Top       = 187
1151:                 .Left      = 45
1152:                 .Width     = 48
1153:                 .Height    = 15
1154:                 .Caption   = "Conta :"
1155:                 .FontName  = "Tahoma"
1156:                 .FontSize  = 8
1157:                 .BackStyle = 0
1158:                 .ForeColor = RGB(0, 0, 0)
1159:                 .Visible   = .T.
1160:             ENDWITH
1161: 
1162:             *-- Label "Cheque :" (original: lblCheque, top=139, left=164)
1163:             .AddObject("lbl_4c_LblCheque", "Label")
1164:             WITH .lbl_4c_LblCheque
1165:                 .Top       = 139
1166:                 .Left      = 205
1167:                 .Width     = 58
1168:                 .Height    = 15
1169:                 .Caption   = "Cheque :"
1170:                 .FontName  = "Tahoma"
1171:                 .FontSize  = 8
1172:                 .BackStyle = 0
1173:                 .ForeColor = RGB(0, 0, 0)
1174:                 .Visible   = .T.
1175:             ENDWITH
1176: 
1177:             *-- Label "Emissao :" (original: lblEmissao, top=163, left=163)
1178:             .AddObject("lbl_4c_LblEmissao", "Label")
1179:             WITH .lbl_4c_LblEmissao
1180:                 .Top       = 163
1181:                 .Left      = 204
1182:                 .Width     = 59
1183:                 .Height    = 15
1184:                 .Caption   = "Emiss" + CHR(227) + "o :"
1185:                 .FontName  = "Tahoma"
1186:                 .FontSize  = 8
1187:                 .BackStyle = 0
1188:                 .ForeColor = RGB(0, 0, 0)
1189:                 .Visible   = .T.
1190:             ENDWITH
1191: 
1192:             *-- Label "Valor :" (original: lblValor, top=187, left=177)
1193:             .AddObject("lbl_4c_LblValor", "Label")
1194:             WITH .lbl_4c_LblValor
1195:                 .Top       = 187
1196:                 .Left      = 221
1197:                 .Width     = 41
1198:                 .Height    = 15
1199:                 .Caption   = "Valor :"
1200:                 .FontName  = "Tahoma"
1201:                 .FontSize  = 8
1202:                 .BackStyle = 0
1203:                 .ForeColor = RGB(0, 0, 0)
1204:                 .Visible   = .T.
1205:             ENDWITH
1206: 
1207:             *-- TextBox Banco (original: getBanco, top=135, left=77, width=31)
1208:             *  Tambem recebe input do leitor CMC-7 via KeyPress (Fase 6)
1209:             .AddObject("txt_4c_Banco", "TextBox")
1210:             WITH .txt_4c_Banco
1211:                 .Top         = 135
1212:                 .Left        = 96
1213:                 .Width       = 39
1214:                 .Height      = 22
1215:                 .Value       = ""
1216:                 .MaxLength   = 3
1217:                 .FontName    = "Tahoma"
1218:                 .FontSize    = 8
1219:                 .Visible     = .T.
1220:             ENDWITH
1221: 
1222:             *-- TextBox Agencia (original: getAgencia, top=158, left=77, width=40)
1223:             .AddObject("txt_4c_Agencia", "TextBox")
1224:             WITH .txt_4c_Agencia
1225:                 .Top         = 158
1226:                 .Left        = 96
1227:                 .Width       = 50
1228:                 .Height      = 22
1229:                 .Value       = ""
1230:                 .MaxLength   = 4
1231:                 .FontName    = "Tahoma"
1232:                 .FontSize    = 8
1233:                 .Visible     = .T.
1234:             ENDWITH
1235: 
1236:             *-- TextBox Conta corrente (original: getConta, top=181, left=77, width=81, height=23)
1237:             .AddObject("txt_4c_Conta", "TextBox")
1238:             WITH .txt_4c_Conta
1239:                 .Top         = 181
1240:                 .Left        = 96
1241:                 .Width       = 101
1242:                 .Height      = 23
1243:                 .Value       = ""
1244:                 .MaxLength   = 10
1245:                 .FontName    = "Tahoma"
1246:                 .FontSize    = 8
1247:                 .Visible     = .T.
1248:             ENDWITH
1249: 
1250:             *-- TextBox Numero do cheque (original: getCheque, top=135, left=213, width=52, height=23)
1251:             .AddObject("txt_4c_Cheque", "TextBox")
1252:             WITH .txt_4c_Cheque
1253:                 .Top         = 135
1254:                 .Left        = 266
1255:                 .Width       = 65
1256:                 .Height      = 23
1257:                 .Value       = ""
1258:                 .MaxLength   = 6
1259:                 .FontName    = "Tahoma"

*-- Linhas 1265 a 1274:
1265:             *  Mutualmente exclusivo com txt_4c_Valor (When = Empty(Valor))
1266:             .AddObject("txt_4c_Emissao", "TextBox")
1267:             WITH .txt_4c_Emissao
1268:                 .Top         = 158
1269:                 .Left        = 266
1270:                 .Width       = 101
1271:                 .Height      = 23
1272:                 .Value       = {}
1273:                 .Format      = "D"
1274:                 .FontName    = "Tahoma"

*-- Linhas 1280 a 1289:
1280:             *  Mutualmente exclusivo com txt_4c_Emissao (When = Empty(Emissao))
1281:             .AddObject("txt_4c_Valor", "TextBox")
1282:             WITH .txt_4c_Valor
1283:                 .Top         = 181
1284:                 .Left        = 266
1285:                 .Width       = 101
1286:                 .Height      = 23
1287:                 .Value       = 0
1288:                 .InputMask   = "999,999,999.99"
1289:                 .FontName    = "Tahoma"

*-- Linhas 1295 a 1337:
1295:             *  Escala 1.25x -> Left=169, Width=216
1296:             .AddObject("obj_4c_Cmdgprocurar", "CommandGroup")
1297:             WITH .obj_4c_Cmdgprocurar
1298:                 .Top           = 7
1299:                 .Left          = 169
1300:                 .Width         = 216
1301:                 .Height        = 110
1302:                 .ButtonCount   = 2
1303:                 .BackStyle     = 0
1304:                 .SpecialEffect = 1
1305:                 .Themes        = .F.
1306:                 .Visible       = .T.
1307: 
1308:                 *-- Buttons(1): Pesquisar cheque pelos criterios informados
1309:                 WITH .Buttons(1)
1310:                     .Top             = 5
1311:                     .Left            = 2
1312:                     .Width           = 100
1313:                     .Height          = 100
1314:                     .Caption         = "Pesquisar"
1315:                     .FontBold        = .T.
1316:                     .FontItalic      = .T.
1317:                     .PicturePosition = 13
1318:                     .ForeColor       = RGB(90, 90, 90)
1319:                     .BackColor       = RGB(255, 255, 255)
1320:                     .Themes          = .F.
1321:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
1322:                     .Visible         = .T.
1323:                 ENDWITH
1324: 
1325:                 *-- Buttons(2): Voltar para visao principal
1326:                 WITH .Buttons(2)
1327:                     .Top             = 5
1328:                     .Left            = 110
1329:                     .Width           = 100
1330:                     .Height          = 100
1331:                     .Caption         = "Voltar"
1332:                     .FontName        = "Comic Sans MS"
1333:                     .FontBold        = .T.
1334:                     .FontItalic      = .T.
1335:                     .FontSize        = 8
1336:                     .PicturePosition = 13
1337:                     .ForeColor       = RGB(90, 90, 90)

*-- Linhas 1366 a 1397:
1366:             THIS.txt_4c_DsContas.Enabled      = .T.
1367:             THIS.txt_4c_TxtFavorecido.Enabled = .T.
1368:             THIS.obj_4c_CmdGok.Enabled        = .T.
1369:             THIS.cmd_4c_Tudo1.Visible         = .T.
1370:             THIS.cmd_4c_Apaga1.Visible        = .T.
1371:         CASE par_nVisao = 1
1372:             *-- Exibe painel Procurar, desabilita grade
1373:             THIS.grd_4c_Dados.Enabled         = .F.
1374:             THIS.txt_4c_CdContas.Enabled      = .F.
1375:             THIS.txt_4c_DsContas.Enabled      = .F.
1376:             THIS.txt_4c_TxtFavorecido.Enabled = .F.
1377:             THIS.obj_4c_CmdGok.Enabled        = .F.
1378:             THIS.cmd_4c_Tudo1.Visible         = .F.
1379:             THIS.cmd_4c_Apaga1.Visible        = .F.
1380:             IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
1381:                 THIS.cnt_4c_Procurar.Enabled = .T.
1382:                 THIS.cnt_4c_Procurar.Visible = .T.
1383:             ENDIF
1384:         CASE par_nVisao = 2
1385:             *-- Exibe painel Impressao Matricial, desabilita grade
1386:             THIS.grd_4c_Dados.Enabled         = .F.
1387:             THIS.txt_4c_CdContas.Enabled      = .F.
1388:             THIS.txt_4c_DsContas.Enabled      = .F.
1389:             THIS.txt_4c_TxtFavorecido.Enabled = .F.
1390:             THIS.obj_4c_CmdGok.Enabled        = .F.
1391:             THIS.cmd_4c_Tudo1.Visible         = .F.
1392:             THIS.cmd_4c_Apaga1.Visible        = .F.
1393:             IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
1394:                 THIS.cnt_4c_Impchmat.Enabled = .T.
1395:                 THIS.cnt_4c_Impchmat.Visible = .T.
1396:             ENDIF
1397:         ENDCASE

*-- Linhas 1423 a 1503:
1423:     *--------------------------------------------------------------------------
1424:         THIS.AddObject("cnt_4c_Impchmat", "Container")
1425:         WITH THIS.cnt_4c_Impchmat
1426:             .Top         = 284
1427:             .Left        = 300
1428:             .Width       = 393
1429:             .Height      = 218
1430:             .BackStyle   = 1
1431:             .BackColor   = RGB(255, 255, 255)
1432:             .BorderWidth = 1
1433:             .Visible     = .F.
1434: 
1435:             .AddObject("lbl_4c_Label1", "Label")
1436:             WITH .lbl_4c_Label1
1437:                 .Top       = 8
1438:                 .Left      = 12
1439:                 .Width     = 81
1440:                 .Height    = 16
1441:                 .Caption   = "Impress" + CHR(227) + "o"
1442:                 .FontName  = "Tahoma"
1443:                 .FontSize  = 8
1444:                 .FontBold  = .T.
1445:                 .BackStyle = 0
1446:                 .ForeColor = RGB(90, 90, 90)
1447:                 .Visible   = .T.
1448:             ENDWITH
1449: 
1450:             .AddObject("lbl_4c_LblBanco", "Label")
1451:             WITH .lbl_4c_LblBanco
1452:                 .Top       = 157
1453:                 .Left      = 83
1454:                 .Width     = 48
1455:                 .Height    = 15
1456:                 .Caption   = "Banco :"
1457:                 .FontName  = "Tahoma"
1458:                 .FontSize  = 8
1459:                 .BackStyle = 0
1460:                 .ForeColor = RGB(90, 90, 90)
1461:                 .Visible   = .T.
1462:             ENDWITH
1463: 
1464:             *-- "Cheque Inicial :" (legado: lblAgencia)
1465:             .AddObject("lbl_4c_LblAgencia", "Label")
1466:             WITH .lbl_4c_LblAgencia
1467:                 .Top       = 185
1468:                 .Left      = 35
1469:                 .Width     = 95
1470:                 .Height    = 15
1471:                 .Caption   = "Cheque Inicial :"
1472:                 .FontName  = "Tahoma"
1473:                 .FontSize  = 8
1474:                 .BackStyle = 0
1475:                 .ForeColor = RGB(90, 90, 90)
1476:                 .Visible   = .T.
1477:             ENDWITH
1478: 
1479:             *-- "Cheque Final :" (legado: lblCheque)
1480:             .AddObject("lbl_4c_LblCheque", "Label")
1481:             WITH .lbl_4c_LblCheque
1482:                 .Top       = 184
1483:                 .Left      = 215
1484:                 .Width     = 89
1485:                 .Height    = 15
1486:                 .Caption   = "Cheque Final :"
1487:                 .FontName  = "Tahoma"
1488:                 .FontSize  = 8
1489:                 .BackStyle = 0
1490:                 .ForeColor = RGB(90, 90, 90)
1491:                 .Visible   = .T.
1492:             ENDWITH
1493: 
1494:             *-- TextBox Banco (original: getBanco, top=153, left=107, width=31, mask=999)
1495:             .AddObject("txt_4c_Banco", "TextBox")
1496:             WITH .txt_4c_Banco
1497:                 .Top         = 153
1498:                 .Left        = 134
1499:                 .Width       = 39
1500:                 .Height      = 22
1501:                 .Value       = ""
1502:                 .InputMask   = "999"
1503:                 .MaxLength   = 3

*-- Linhas 1510 a 1519:
1510:             *-- TextBox Cheque Inicial (original: Getchini, top=179, left=107, mask=999999)
1511:             .AddObject("txt_4c_Chini", "TextBox")
1512:             WITH .txt_4c_Chini
1513:                 .Top         = 179
1514:                 .Left        = 134
1515:                 .Width       = 65
1516:                 .Height      = 23
1517:                 .Value       = ""
1518:                 .InputMask   = "999999"
1519:                 .MaxLength   = 6

*-- Linhas 1526 a 1535:
1526:             *-- TextBox Cheque Final (original: getChfin, top=180, left=245, mask=999999)
1527:             .AddObject("txt_4c_Chfin", "TextBox")
1528:             WITH .txt_4c_Chfin
1529:                 .Top         = 180
1530:                 .Left        = 306
1531:                 .Width       = 65
1532:                 .Height      = 23
1533:                 .Value       = ""
1534:                 .InputMask   = "999999"
1535:                 .MaxLength   = 6

*-- Linhas 1542 a 1584:
1542:             *-- CommandGroup Imprimir/Encerrar (original: cmdGprocurar, top=7, left=134, width=173, height=110)
1543:             .AddObject("obj_4c_CmdGprocurar", "CommandGroup")
1544:             WITH .obj_4c_CmdGprocurar
1545:                 .Top           = 7
1546:                 .Left          = 167
1547:                 .Width         = 216
1548:                 .Height        = 110
1549:                 .ButtonCount   = 2
1550:                 .BackStyle     = 0
1551:                 .SpecialEffect = 1
1552:                 .Themes        = .F.
1553:                 .BorderColor   = RGB(136, 189, 188)
1554:                 .Visible       = .T.
1555: 
1556:                 WITH .Buttons(1)
1557:                     .Top             = 1
1558:                     .Left            = 13
1559:                     .Width           = 75
1560:                     .Height          = 75
1561:                     .Caption         = "\<Imprimir"
1562:                     .FontBold        = .T.
1563:                     .FontItalic      = .T.
1564:                     .PicturePosition = 13
1565:                     .ForeColor       = RGB(90, 90, 90)
1566:                     .BackColor       = RGB(255, 255, 255)
1567:                     .Themes          = .F.
1568:                     .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
1569:                     .Visible         = .T.
1570:                 ENDWITH
1571: 
1572:                 WITH .Buttons(2)
1573:                     .Top             = 1
1574:                     .Left            = 119
1575:                     .Width           = 75
1576:                     .Height          = 75
1577:                     .Caption         = "Encerrar"
1578:                     .Cancel          = .T.
1579:                     .FontName        = "Comic Sans MS"
1580:                     .FontBold        = .T.
1581:                     .FontItalic      = .T.
1582:                     .FontSize        = 8
1583:                     .PicturePosition = 13
1584:                     .ForeColor       = RGB(90, 90, 90)

*-- Linhas 1607 a 1622:
1607:         *-- Grid: Header da coluna NCopias
1608:         BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "HeaderNcopiasClick")
1609: 
1610:         *-- Grid: CheckBox coluna Imprime
1611:         BINDEVENT(THIS.grd_4c_Dados.Column10.chk_4c_Imprime, "KeyPress", THIS, "ChkImprimeKeyPress")
1612:         BINDEVENT(THIS.grd_4c_Dados.Column10.chk_4c_Imprime, "MouseUp",  THIS, "ChkImprimeMouseUp")
1613: 
1614:         *-- Botoes marcar/desmarcar
1615:         BINDEVENT(THIS.cmd_4c_Apaga1,   "Click", THIS, "CmdApaga1Click")
1616:         BINDEVENT(THIS.cmd_4c_Tudo1,    "Click", THIS, "CmdTudo1Click")
1617:         BINDEVENT(THIS.cmd_4c_Command2, "Click", THIS, "Command2Click")
1618: 
1619:         *-- Campos de filtro: GotFocus salva valor anterior; KeyPress valida ao sair
1620:         BINDEVENT(THIS.txt_4c_CdGrupos,  "GotFocus", THIS, "CdGruposGotFocus")
1621:         BINDEVENT(THIS.txt_4c_CdGrupos,  "KeyPress", THIS, "CdGruposKeyPress")
1622:         BINDEVENT(THIS.txt_4c_DsGrupos,  "GotFocus", THIS, "DsGruposGotFocus")

*-- Linhas 2040 a 2048:
2040:         ENDIF
2041:     ENDPROC
2042: 
2043:     *-- Grid: CheckBox Imprime - KeyPress (ENTER/SPACE toggle marca)
2044:     PROCEDURE ChkImprimeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2045:         LOCAL loc_nRecno, loc_cChave
2046: 
2047:         IF INLIST(par_nKeyCode, 13, 32)
2048:             IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")

*-- Linhas 2060 a 2068:
2060:         ENDIF
2061:     ENDPROC
2062: 
2063:     *-- Grid: CheckBox Imprime - MouseUp (simula KeyPress com SPACE)
2064:     PROCEDURE ChkImprimeMouseUp(par_nButton, par_nShift, par_nX, par_nY)
2065:         THIS.ChkImprimeKeyPress(32, 0)
2066:     ENDPROC
2067: 
2068:     *==========================================================================

*-- Linhas 3434 a 3463:
3434:         WITH THIS.this_oBusinessObject
3435:             THIS.txt_4c_Dt_inicial.Value   = IIF(EMPTY(.this_dDtInicial), DATE(), .this_dDtInicial)
3436:             THIS.txt_4c_Dt_final.Value     = IIF(EMPTY(.this_dDtFinal), DATE(), .this_dDtFinal)
3437:             THIS.txt_4c_CdGrupos.Value     = .this_cCdGrupo
3438:             THIS.txt_4c_DsGrupos.Value     = .this_cDsGrupo
3439:             THIS.txt_4c_CdContas.Value     = .this_cCdConta
3440:             THIS.txt_4c_DsContas.Value     = .this_cDsConta
3441: 
3442:             IF !EMPTY(.this_cFavos)
3443:                 THIS.txt_4c_TxtFavorecido.Value = .this_cFavos
3444:             ENDIF
3445: 
3446:             IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5) AND THIS.cnt_4c_Impchmat.Visible
3447:                 THIS.cnt_4c_Impchmat.txt_4c_Banco.Value = .this_cBancoMat
3448:                 THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = .this_cChIniMat
3449:                 THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = .this_cChFinMat
3450:             ENDIF
3451: 
3452:             IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5) AND THIS.cnt_4c_Procurar.Visible
3453:                 THIS.cnt_4c_Procurar.txt_4c_Banco.Value   = .this_cBancoPrc
3454:                 THIS.cnt_4c_Procurar.txt_4c_Agencia.Value = .this_cAgenciaPrc
3455:                 THIS.cnt_4c_Procurar.txt_4c_Conta.Value   = .this_cContaPrc
3456:                 THIS.cnt_4c_Procurar.txt_4c_Cheque.Value  = .this_cChequePrc
3457:                 THIS.cnt_4c_Procurar.txt_4c_Emissao.Value = IIF(EMPTY(.this_dEmissaoPrc), {}, .this_dEmissaoPrc)
3458:                 THIS.cnt_4c_Procurar.txt_4c_Valor.Value   = .this_nValorPrc
3459:             ENDIF
3460:         ENDWITH
3461:     ENDPROC
3462: 
3463:     *--------------------------------------------------------------------------

*-- Linhas 3478 a 3493:
3478:         THIS.txt_4c_DsContas.Enabled       = loc_lHab
3479:         THIS.txt_4c_Dt_inicial.Enabled     = loc_lHab
3480:         THIS.txt_4c_Dt_final.Enabled       = loc_lHab
3481:         THIS.cmd_4c_Command2.Enabled       = loc_lHab
3482:         THIS.grd_4c_Dados.Enabled          = loc_lHab
3483:         THIS.txt_4c_TxtFavorecido.Enabled  = loc_lHab
3484:         THIS.obj_4c_CmdGok.Enabled         = loc_lHab
3485: 
3486:         IF loc_lHab
3487:             THIS.cmd_4c_Tudo1.Visible  = .T.
3488:             THIS.cmd_4c_Apaga1.Visible = .T.
3489:         ENDIF
3490:     ENDPROC
3491: 
3492:     *--------------------------------------------------------------------------
3493:     PROCEDURE LimparCampos()

