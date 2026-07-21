# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'N°' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'N°' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'N°' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdis.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2350 linhas total):

*-- Linhas 83 a 127:
83:                 THIS.ConfigurarPaginaLista()
84:                 THIS.ConfigurarPaginaDados()
85: 
86:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
87:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
88: 
89:                 *-- Page1 BINDEVENTs
90:                 LOCAL loc_oPg1 AS Object
91:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
92:                 BINDEVENT(loc_oPg1.txt_4c_DtInicial, "LostFocus",     THIS, "TxtDtInicialValid")
93:                 BINDEVENT(loc_oPg1.txt_4c_DtFinal,   "LostFocus",     THIS, "TxtDtFinalValid")
94:                 BINDEVENT(loc_oPg1.txt_4c_DtFinal,   "KeyPress", THIS, "TxtDtFinalLostFocus")
95:                 BINDEVENT(loc_oPg1.cmd_4c_Novo,       "Click",    THIS, "BtnNovoClick")
96:                 BINDEVENT(loc_oPg1.cmd_4c_Abrir,      "Click",    THIS, "BtnAbrirClick")
97:                 BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
98: 
99:                 *-- Page2 BINDEVENTs
100:                 LOCAL loc_oPg2 AS Object
101:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
102:                 BINDEVENT(loc_oPg2.cmd_4c_VoltarLista, "Click", THIS, "BtnVoltarListaClick")
103: 
104:                 *-- Inner pageframe sub-page BINDEVENTs
105:                 LOCAL loc_oPf1 AS Object
106:                 loc_oPf1 = loc_oPg2.pgf_4c_Pageframe1
107: 
108:                 *-- SubPage1 (Estoques)
109:                 LOCAL loc_oSub1 AS Object
110:                 loc_oSub1 = loc_oPf1.Page1
111:                 BINDEVENT(loc_oSub1.cmdg_4c_MarcaDesmarca.Buttons(1), "Click", THIS, "BtnMarcarClick")
112:                 BINDEVENT(loc_oSub1.cmdg_4c_MarcaDesmarca.Buttons(2), "Click", THIS, "BtnDesmarcarClick")
113:                 BINDEVENT(loc_oSub1.cmd_4c_Processar,                  "Click", THIS, "BtnProcessarPage1Click")
114:                 BINDEVENT(loc_oSub1.grd_4c_Estoques.Column1.chk_4c_Marca, "MouseUp",  THIS, "ChkMarcaMouseUp")
115:                 BINDEVENT(loc_oSub1.grd_4c_Estoques.Column1.chk_4c_Marca, "KeyPress", THIS, "ChkMarcaKeyPress")
116: 
117:                 *-- SubPage2 (Distribuicao)
118:                 LOCAL loc_oSub2 AS Object
119:                 loc_oSub2 = loc_oPf1.Page2
120:                 BINDEVENT(loc_oSub2.cmd_4c_VoltarEst,      "Click",              THIS, "BtnVoltarEstClick")
121:                 BINDEVENT(loc_oSub2.cmd_4c_Salvar,         "Click",              THIS, "BtnSalvarClick")
122:                 BINDEVENT(loc_oSub2.cmd_4c_Filtrar,        "Click",              THIS, "BtnFiltrarClick")
123:                 BINDEVENT(loc_oSub2.img_4c_FigJpg,         "Click",              THIS, "ImgFotoClick")
124:                 BINDEVENT(loc_oSub2.txt_4c_CodGrupo,       "KeyPress",             THIS, "TxtCGrupoValid")
125:                 BINDEVENT(loc_oSub2.txt_4c_DsGrupo,        "KeyPress",             THIS, "TxtDGrupoValid")
126:                 BINDEVENT(loc_oSub2.txt_4c_CodSgrupo,      "KeyPress",             THIS, "TxtCodSgrupoValid")
127:                 BINDEVENT(loc_oSub2.txt_4c_DsSgrupo,       "KeyPress",             THIS, "TxtDsSgrupoValid")

*-- Linhas 157 a 165:
157:                 IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
158:                     loc_oPg1.grd_4c_Grade.SetFocus()
159:                 ELSE
160:                     loc_oPg1.cmd_4c_Novo.SetFocus()
161:                 ENDIF
162: 
163:                 loc_lSucesso = .T.
164:             ENDIF
165:         CATCH TO loc_oErro

*-- Linhas 183 a 191:
183: 
184:             IF VARTYPE(loc_oControl) = "O"
185:                 IF INLIST(UPPER(loc_oControl.Name), ;
186:                     "LBL_4C_LBLTITF", "LBL_4C_LBLTITT", "LBL_4C_LABEL3")
187:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
188:                        loc_oControl.ControlCount > 0
189:                         THIS.TornarControlesVisiveis(loc_oControl)
190:                     ENDIF
191:                     LOOP

*-- Linhas 208 a 243:
208:     *==========================================================================
209:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
210:         WITH THIS.cnt_4c_Cabecalho
211:             .Top        = 0
212:             .Left       = 0
213:             .Width      = THIS.Width
214:             .Height     = 45
215:             .BorderWidth= 0
216:             .BackStyle  = 1
217:             .BackColor  = RGB(90,90,90)
218:             .Visible     = .T.
219:         ENDWITH
220:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
221:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
222:             .Caption   = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
223:             .Top       = 12
224:             .Left      = 12
225:             .Width     = THIS.Width
226:             .Height    = 30
227:             .AutoSize  = .F.
228:             .BackStyle = 0
229:             .ForeColor = RGB(0,0,0)
230:             .FontName  = "Tahoma"
231:             .FontSize  = 14
232:             .FontBold  = .T.
233:         ENDWITH
234:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
235:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
236:             .Caption   = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
237:             .Top       = 10
238:             .Left      = 10
239:             .Width     = THIS.Width
240:             .Height    = 30
241:             .AutoSize  = .F.
242:             .BackStyle = 0
243:             .ForeColor = RGB(255,255,255)

*-- Linhas 256 a 398:
256: 
257:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
258:         WITH THIS.pgf_4c_Paginas
259:             .Left      = 0
260:             .Top       = 45
261:             .Width     = THIS.Width
262:             .Height    = THIS.Height - 45
263:             .PageCount = 2
264:             .Tabs      = .F.
265:             .Page1.Caption = "Lista"
266:             .Page2.Caption = "Dados"
267:         ENDWITH
268:     ENDPROC
269: 
270:     *==========================================================================
271:     PROTECTED PROCEDURE ConfigurarSaida()
272:     *==========================================================================
273:         THIS.AddObject("cnt_4c_Saida", "Container")
274:         WITH THIS.cnt_4c_Saida
275:             .Name        = "cnt_4c_Saida"
276:             .Left        = 917
277:             .Top         = 45
278:             .Width       = 90
279:             .Height      = 85
280:             .BackStyle = 1
281:             .BackColor = RGB(255, 255, 255)
282:             .BorderWidth = 0
283:             .Visible     = .T.
284:             .ZOrder(0)
285:         ENDWITH
286:         THIS.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
287:         WITH THIS.cnt_4c_Saida.cmd_4c_Encerrar
288:             .Name     = "cmd_4c_Encerrar"
289:             .Left     = 5
290:             .Top      = 5
291:             .Width    = 75
292:             .Height   = 75
293:             .Caption  = "Encerrar"
294:             .FontName = "Tahoma"
295:             .FontSize = 8
296:             .Visible  = .T.
297:         ENDWITH
298:     ENDPROC
299: 
300:     *==========================================================================
301:     PROTECTED PROCEDURE ConfigurarPaginaLista()
302:     *==========================================================================
303:         LOCAL loc_oPg1 AS Object
304:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
305: 
306:         loc_oPg1.AddObject("lbl_4c_Periodo", "Label")
307:         WITH loc_oPg1.lbl_4c_Periodo
308:             .Caption   = "Per" + CHR(237) + "odo :"
309:             .Left      = 35
310:             .Top       = 89
311:             .Width     = 60
312:             .Height    = 15
313:             .AutoSize  = .F.
314:             .BackStyle = 0
315:             .FontName  = "Tahoma"
316:             .FontSize  = 8
317:         ENDWITH
318: 
319:         loc_oPg1.AddObject("txt_4c_DtInicial", "TextBox")
320:         WITH loc_oPg1.txt_4c_DtInicial
321:             .Left     = 103
322:             .Top      = 105
323:             .Width    = 90
324:             .Height   = 22
325:             .Value    = DATE()
326:             .Format   = "D"
327:             .FontName = "Tahoma"
328:             .FontSize = 8
329:         ENDWITH
330: 
331:         loc_oPg1.AddObject("lbl_4c_Sep", "Label")
332:         WITH loc_oPg1.lbl_4c_Sep
333:             .Caption   = CHR(224)
334:             .Left      = 195
335:             .Top       = 109
336:             .Width     = 12
337:             .Height    = 15
338:             .AutoSize  = .F.
339:             .BackStyle = 0
340:         ENDWITH
341: 
342:         loc_oPg1.AddObject("txt_4c_DtFinal", "TextBox")
343:         WITH loc_oPg1.txt_4c_DtFinal
344:             .Left     = 206
345:             .Top      = 105
346:             .Width    = 90
347:             .Height   = 22
348:             .Value    = DATE()
349:             .Format   = "D"
350:             .FontName = "Tahoma"
351:             .FontSize = 8
352:         ENDWITH
353: 
354:         loc_oPg1.AddObject("cmd_4c_Novo", "CommandButton")
355:         WITH loc_oPg1.cmd_4c_Novo
356:             .Caption  = "Nova Distribui" + CHR(231) + CHR(227) + "o"
357:             .Left     = 315
358:             .Top      = 102
359:             .Width    = 140
360:             .Height   = 28
361:             .FontName = "Tahoma"
362:             .FontSize = 8
363:         ENDWITH
364: 
365:         loc_oPg1.AddObject("cmd_4c_Abrir", "CommandButton")
366:         WITH loc_oPg1.cmd_4c_Abrir
367:             .Caption  = "Abrir Selecionado"
368:             .Left     = 465
369:             .Top      = 102
370:             .Width    = 130
371:             .Height   = 28
372:             .FontName = "Tahoma"
373:             .FontSize = 8
374:         ENDWITH
375: 
376:         loc_oPg1.AddObject("lbl_4c_TituloLista", "Label")
377:         WITH loc_oPg1.lbl_4c_TituloLista
378:             .Caption   = "Lotes de Distribui" + CHR(231) + CHR(227) + "o"
379:             .Left      = 35
380:             .Top       = 140
381:             .Width     = 200
382:             .Height    = 15
383:             .AutoSize  = .F.
384:             .BackStyle = 0
385:             .FontName  = "Tahoma"
386:             .FontSize  = 8
387:             .FontBold  = .T.
388:         ENDWITH
389: 
390:         loc_oPg1.AddObject("grd_4c_Grade", "Grid")
391:         WITH loc_oPg1.grd_4c_Grade
392:             .Left              = 24
393:             .Top               = 157
394:             .Width             = 870
395:             .Height            = 340
396:             .RecordSource      = ""
397:             .RecordSourceType  = 1
398:             .ColumnCount       = 2

*-- Linhas 407 a 491:
407:         WITH loc_oPg1.grd_4c_Grade.Column1
408:             .ControlSource   = "cursor_4c_Dados.Codigos"
409:             .Width           = 140
410:             .Header1.Caption = "C" + CHR(243) + "digo"
411:         ENDWITH
412:         WITH loc_oPg1.grd_4c_Grade.Column2
413:             .ControlSource   = "cursor_4c_Dados.Datas"
414:             .Width           = 700
415:             .Header1.Caption = "Data"
416:         ENDWITH
417:     ENDPROC
418: 
419:     *==========================================================================
420:     PROTECTED PROCEDURE ConfigurarPaginaDados()
421:     *==========================================================================
422:         LOCAL loc_oPg2 AS Object
423:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
424: 
425:         loc_oPg2.AddObject("cmd_4c_VoltarLista", "CommandButton")
426:         WITH loc_oPg2.cmd_4c_VoltarLista
427:             .Caption  = CHR(171) + " Lista"
428:             .Left     = 5
429:             .Top      = 5
430:             .Width    = 80
431:             .Height   = 25
432:             .FontName = "Tahoma"
433:             .FontSize = 8
434:         ENDWITH
435: 
436:         loc_oPg2.AddObject("lbl_4c_Lote", "Label")
437:         WITH loc_oPg2.lbl_4c_Lote
438:             .Caption   = "Lote:"
439:             .Left      = 96
440:             .Top       = 10
441:             .Width     = 35
442:             .Height    = 15
443:             .AutoSize  = .F.
444:             .BackStyle = 0
445:             .FontName  = "Tahoma"
446:             .FontSize  = 8
447:         ENDWITH
448: 
449:         loc_oPg2.AddObject("txt_4c_LoteCodigo", "TextBox")
450:         WITH loc_oPg2.txt_4c_LoteCodigo
451:             .Left      = 132
452:             .Top       = 7
453:             .Width     = 180
454:             .Height    = 22
455:             .ReadOnly  = .T.
456:             .BackColor = RGB(230,230,230)
457:             .FontName  = "Tahoma"
458:             .FontSize  = 8
459:         ENDWITH
460: 
461:         loc_oPg2.AddObject("lbl_4c_Modo", "Label")
462:         WITH loc_oPg2.lbl_4c_Modo
463:             .Caption   = ""
464:             .Left      = 320
465:             .Top       = 10
466:             .Width     = 70
467:             .Height    = 15
468:             .AutoSize  = .F.
469:             .BackStyle = 0
470:             .FontName  = "Tahoma"
471:             .FontSize  = 8
472:             .ForeColor = RGB(0,0,180)
473:         ENDWITH
474: 
475:         *-- Inner pageframe (3 sub-pages: Estoques, Distribuicao, Operacoes)
476:         loc_oPg2.AddObject("pgf_4c_Pageframe1", "PageFrame")
477:         WITH loc_oPg2.pgf_4c_Pageframe1
478:             .Left      = 0
479:             .Top       = 35
480:             .Width     = 910
481:             .Height    = 515
482:             .PageCount = 3
483:             .Tabs      = .T.
484:             .Page1.Caption = "1 - Estoques"
485:             .Page2.Caption = "2 - Distribui" + CHR(231) + CHR(227) + "o"
486:             .Page3.Caption = "3 - Opera" + CHR(231) + CHR(245) + "es"
487:         ENDWITH
488: 
489:         THIS.ConfigurarSubPaginaEstoques()
490:         THIS.ConfigurarSubPaginaDistribuicao()
491:         THIS.ConfigurarSubPaginaOperacoes()

*-- Linhas 497 a 556:
497:         LOCAL loc_oSub AS Object
498:         loc_oSub = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1
499: 
500:         loc_oSub.AddObject("lbl_4c_TituloEst", "Label")
501:         WITH loc_oSub.lbl_4c_TituloEst
502:             .Caption   = "Estoques para distribuir"
503:             .Left      = 338
504:             .Top       = 189
505:             .Width     = 200
506:             .Height    = 15
507:             .AutoSize  = .F.
508:             .BackStyle = 0
509:             .FontName  = "Tahoma"
510:             .FontSize  = 8
511:             .FontBold  = .T.
512:         ENDWITH
513: 
514:         loc_oSub.AddObject("cmd_4c_Processar", "CommandButton")
515:         WITH loc_oSub.cmd_4c_Processar
516:             .Caption  = "Processar >>"
517:             .Left     = 730
518:             .Top      = 10
519:             .Width    = 120
520:             .Height   = 28
521:             .FontName = "Tahoma"
522:             .FontSize = 8
523:         ENDWITH
524: 
525:         loc_oSub.AddObject("cmdg_4c_MarcaDesmarca", "CommandGroup")
526:         WITH loc_oSub.cmdg_4c_MarcaDesmarca
527:             .Left        = 617
528:             .Top         = 351
529:             .Width       = 160
530:             .Height      = 50
531:             .ButtonCount = 2
532:         ENDWITH
533:         WITH loc_oSub.cmdg_4c_MarcaDesmarca.Buttons(1)
534:             .Caption = "Marcar Todos"
535:             .Left    = 5
536:             .Top     = 5
537:             .Width   = 72
538:             .Height  = 40
539:         ENDWITH
540:         WITH loc_oSub.cmdg_4c_MarcaDesmarca.Buttons(2)
541:             .Caption = "Desmarcar"
542:             .Left    = 82
543:             .Top     = 5
544:             .Width   = 72
545:             .Height  = 40
546:         ENDWITH
547: 
548:         loc_oSub.AddObject("grd_4c_Estoques", "Grid")
549:         WITH loc_oSub.grd_4c_Estoques
550:             .Left             = 335
551:             .Top              = 207
552:             .Width            = 280
553:             .Height           = 244
554:             .RecordSource     = ""
555:             .RecordSourceType = 1
556:             .ColumnCount      = 4

*-- Linhas 565 a 723:
565:             .ControlSource   = "cursor_4c_Estoques.nMarca"
566:             .Width           = 30
567:             .Sparse          = .F.
568:             .Header1.Caption = ""
569:         ENDWITH
570:         loc_oSub.grd_4c_Estoques.Column1.AddObject("chk_4c_Marca", "CheckBox")
571:         WITH loc_oSub.grd_4c_Estoques.Column1.chk_4c_Marca
572:             .Caption = ""
573:             .Width   = 24
574:             .Height  = 17
575:         ENDWITH
576:         loc_oSub.grd_4c_Estoques.Column1.CurrentControl = "chk_4c_Marca"
577:         WITH loc_oSub.grd_4c_Estoques.Column2
578:             .ControlSource   = "cursor_4c_Estoques.emps"
579:             .Width           = 55
580:             .ReadOnly        = .T.
581:             .Header1.Caption = "Empresa"
582:         ENDWITH
583:         WITH loc_oSub.grd_4c_Estoques.Column3
584:             .ControlSource   = "cursor_4c_Estoques.grupos"
585:             .Width           = 90
586:             .ReadOnly        = .T.
587:             .Header1.Caption = "Grupo"
588:         ENDWITH
589:         WITH loc_oSub.grd_4c_Estoques.Column4
590:             .ControlSource   = "cursor_4c_Estoques.contas"
591:             .Width           = 90
592:             .ReadOnly        = .T.
593:             .Header1.Caption = "Conta"
594:         ENDWITH
595:     ENDPROC
596: 
597:     *==========================================================================
598:     PROTECTED PROCEDURE ConfigurarSubPaginaDistribuicao()
599:     *==========================================================================
600:         LOCAL loc_oSub AS Object
601:         loc_oSub = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
602: 
603:         loc_oSub.AddObject("cmd_4c_VoltarEst", "CommandButton")
604:         WITH loc_oSub.cmd_4c_VoltarEst
605:             .Caption  = CHR(171) + " Estoques"
606:             .Left     = 5
607:             .Top      = 5
608:             .Width    = 90
609:             .Height   = 25
610:             .FontName = "Tahoma"
611:             .FontSize = 8
612:         ENDWITH
613: 
614:         loc_oSub.AddObject("cmd_4c_Salvar", "CommandButton")
615:         WITH loc_oSub.cmd_4c_Salvar
616:             .Caption  = "Salvar"
617:             .Left     = 730
618:             .Top      = 5
619:             .Width    = 80
620:             .Height   = 25
621:             .FontName = "Tahoma"
622:             .FontSize = 8
623:         ENDWITH
624: 
625:         *-- Product image area
626:         loc_oSub.AddObject("shp_4c_Shape5", "Shape")
627:         WITH loc_oSub.shp_4c_Shape5
628:             .Left      = 4
629:             .Top       = 35
630:             .Width     = 163
631:             .Height    = 93
632:             .BackStyle = 1
633:             .BackColor = RGB(200,200,200)
634:         ENDWITH
635: 
636:         loc_oSub.AddObject("img_4c_FigJpg", "Image")
637:         WITH loc_oSub.img_4c_FigJpg
638:             .Left    = 7
639:             .Top     = 36
640:             .Width   = 159
641:             .Height  = 89
642:             .Stretch = 1
643:         ENDWITH
644: 
645:         *-- Group filter
646:         loc_oSub.AddObject("lbl_4c_LblGrupo", "Label")
647:         WITH loc_oSub.lbl_4c_LblGrupo
648:             .Caption   = "Grupo :"
649:             .Left      = 174
650:             .Top       = 59
651:             .Width     = 45
652:             .Height    = 15
653:             .AutoSize  = .F.
654:             .BackStyle = 0
655:             .FontName  = "Tahoma"
656:             .FontSize  = 8
657:         ENDWITH
658: 
659:         loc_oSub.AddObject("txt_4c_CodGrupo", "TextBox")
660:         WITH loc_oSub.txt_4c_CodGrupo
661:             .Left     = 175
662:             .Top      = 74
663:             .Width    = 35
664:             .Height   = 23
665:             .FontName = "Tahoma"
666:             .FontSize = 8
667:         ENDWITH
668: 
669:         loc_oSub.AddObject("txt_4c_DsGrupo", "TextBox")
670:         WITH loc_oSub.txt_4c_DsGrupo
671:             .Left     = 211
672:             .Top      = 74
673:             .Width    = 208
674:             .Height   = 23
675:             .FontName = "Tahoma"
676:             .FontSize = 8
677:         ENDWITH
678: 
679:         loc_oSub.AddObject("cmd_4c_Filtrar", "CommandButton")
680:         WITH loc_oSub.cmd_4c_Filtrar
681:             .Caption  = "Filtrar"
682:             .Left     = 424
683:             .Top      = 73
684:             .Width    = 60
685:             .Height   = 25
686:             .FontName = "Tahoma"
687:             .FontSize = 8
688:         ENDWITH
689: 
690:         *-- Product search
691:         loc_oSub.AddObject("lbl_4c_LblProduto", "Label")
692:         WITH loc_oSub.lbl_4c_LblProduto
693:             .Caption   = "Procurar"
694:             .Left      = 4
695:             .Top       = 100
696:             .Width     = 50
697:             .Height    = 15
698:             .AutoSize  = .F.
699:             .BackStyle = 0
700:             .FontName  = "Tahoma"
701:             .FontSize  = 8
702:         ENDWITH
703: 
704:         loc_oSub.AddObject("txt_4c_ProdutoInicial", "TextBox")
705:         WITH loc_oSub.txt_4c_ProdutoInicial
706:             .Left     = 2
707:             .Top      = 116
708:             .Width    = 108
709:             .Height   = 22
710:             .FontName = "Tahoma"
711:             .FontSize = 8
712:         ENDWITH
713: 
714:         *-- Disponivel grid
715:         loc_oSub.AddObject("grd_4c_Disponivel", "Grid")
716:         WITH loc_oSub.grd_4c_Disponivel
717:             .Left             = 1
718:             .Top              = 141
719:             .Width            = 663
720:             .Height           = 327
721:             .RecordSource     = ""
722:             .RecordSourceType = 1
723:             .ColumnCount      = 7

*-- Linhas 732 a 777:
732:         WITH loc_oSub.grd_4c_Disponivel.Column1
733:             .ControlSource   = "cursor_4c_Disponivel.cpros"
734:             .Width           = 90
735:             .Header1.Caption = "C" + CHR(243) + "digo"
736:         ENDWITH
737:         WITH loc_oSub.grd_4c_Disponivel.Column2
738:             .ControlSource   = "cursor_4c_Disponivel.dpros"
739:             .Width           = 140
740:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
741:         ENDWITH
742:         WITH loc_oSub.grd_4c_Disponivel.Column3
743:             .ControlSource   = "cursor_4c_Disponivel.codcors"
744:             .Width           = 55
745:             .Header1.Caption = "Cor"
746:         ENDWITH
747:         WITH loc_oSub.grd_4c_Disponivel.Column4
748:             .ControlSource   = "cursor_4c_Disponivel.codtams"
749:             .Width           = 55
750:             .Header1.Caption = "Tam"
751:         ENDWITH
752:         WITH loc_oSub.grd_4c_Disponivel.Column5
753:             .ControlSource   = "cursor_4c_Disponivel.QtdEstoque"
754:             .Width           = 80
755:             .Header1.Caption = "Estoque"
756:         ENDWITH
757:         WITH loc_oSub.grd_4c_Disponivel.Column6
758:             .ControlSource   = "cursor_4c_Disponivel.QtdSaida"
759:             .Width           = 80
760:             .Header1.Caption = "Distribuido"
761:         ENDWITH
762:         WITH loc_oSub.grd_4c_Disponivel.Column7
763:             .ControlSource   = "cursor_4c_Disponivel.QtdSaldo"
764:             .Width           = 80
765:             .Header1.Caption = "Saldo"
766:         ENDWITH
767: 
768:         *-- Distribui grid (Column3=QtdDistr editable, Column4=locals editable)
769:         loc_oSub.AddObject("grd_4c_Distribui", "Grid")
770:         WITH loc_oSub.grd_4c_Distribui
771:             .Left             = 664
772:             .Top              = 141
773:             .Width            = 234
774:             .Height           = 327
775:             .RecordSource     = ""
776:             .RecordSourceType = 1
777:             .ColumnCount      = 4

*-- Linhas 786 a 1134:
786:             .ControlSource   = "cursor_4c_Distribui.emps"
787:             .Width           = 50
788:             .ReadOnly        = .T.
789:             .Header1.Caption = "Empresa"
790:         ENDWITH
791:         WITH loc_oSub.grd_4c_Distribui.Column2
792:             .ControlSource   = "cursor_4c_Distribui.QtdSaldo"
793:             .Width           = 55
794:             .ReadOnly        = .T.
795:             .Header1.Caption = "Saldo"
796:         ENDWITH
797:         WITH loc_oSub.grd_4c_Distribui.Column3
798:             .ControlSource   = "cursor_4c_Distribui.QtdDistr"
799:             .Width           = 65
800:             .Header1.Caption = "Quantidade"
801:         ENDWITH
802:         WITH loc_oSub.grd_4c_Distribui.Column4
803:             .ControlSource   = "cursor_4c_Distribui.locals"
804:             .Width           = 55
805:             .Header1.Caption = "Local"
806:         ENDWITH
807: 
808:         *-- Product info panel (read-only) - bottom of page
809:         loc_oSub.AddObject("lbl_4c_LblGrupoP", "Label")
810:         WITH loc_oSub.lbl_4c_LblGrupoP
811:             .Caption   = "Grupo :"
812:             .Left      = 67
813:             .Top       = 474
814:             .Width     = 45
815:             .Height    = 15
816:             .AutoSize  = .F.
817:             .BackStyle = 0
818:             .FontName  = "Tahoma"
819:             .FontSize  = 8
820:         ENDWITH
821:         loc_oSub.AddObject("txt_4c_CdGrupo", "TextBox")
822:         WITH loc_oSub.txt_4c_CdGrupo
823:             .Left      = 116
824:             .Top       = 470
825:             .Width     = 65
826:             .Height    = 21
827:             .ReadOnly  = .T.
828:             .BackColor = RGB(230,230,230)
829:             .FontName  = "Tahoma"
830:             .FontSize  = 8
831:         ENDWITH
832:         loc_oSub.AddObject("txt_4c_DsGrupoP", "TextBox")
833:         WITH loc_oSub.txt_4c_DsGrupoP
834:             .Left      = 182
835:             .Top       = 470
836:             .Width     = 270
837:             .Height    = 21
838:             .ReadOnly  = .T.
839:             .BackColor = RGB(230,230,230)
840:             .FontName  = "Tahoma"
841:             .FontSize  = 8
842:         ENDWITH
843: 
844:         *-- Row 470 right side: Linha
845:         loc_oSub.AddObject("lbl_4c_LblLinha", "Label")
846:         WITH loc_oSub.lbl_4c_LblLinha
847:             .Caption   = "Linha :"
848:             .Left      = 549
849:             .Top       = 473
850:             .Width     = 40
851:             .Height    = 15
852:             .AutoSize  = .F.
853:             .BackStyle = 0
854:             .FontName  = "Tahoma"
855:             .FontSize  = 8
856:         ENDWITH
857:         loc_oSub.AddObject("txt_4c_CdLinha", "TextBox")
858:         WITH loc_oSub.txt_4c_CdLinha
859:             .Left      = 593
860:             .Top       = 470
861:             .Width     = 80
862:             .Height    = 21
863:             .ReadOnly  = .T.
864:             .BackColor = RGB(230,230,230)
865:             .FontName  = "Tahoma"
866:             .FontSize  = 8
867:         ENDWITH
868:         loc_oSub.AddObject("txt_4c_DsLinha", "TextBox")
869:         WITH loc_oSub.txt_4c_DsLinha
870:             .Left      = 674
871:             .Top       = 470
872:             .Width     = 220
873:             .Height    = 21
874:             .ReadOnly  = .T.
875:             .BackColor = RGB(230,230,230)
876:             .FontName  = "Tahoma"
877:             .FontSize  = 8
878:         ENDWITH
879: 
880:         *-- Row 492 left side: Subgrupo (produto)
881:         loc_oSub.AddObject("lbl_4c_LblSgrupoP", "Label")
882:         WITH loc_oSub.lbl_4c_LblSgrupoP
883:             .Caption   = "Subgrupo :"
884:             .Left      = 50
885:             .Top       = 497
886:             .Width     = 60
887:             .Height    = 15
888:             .AutoSize  = .F.
889:             .BackStyle = 0
890:             .FontName  = "Tahoma"
891:             .FontSize  = 8
892:         ENDWITH
893:         loc_oSub.AddObject("txt_4c_CdSgrupoP", "TextBox")
894:         WITH loc_oSub.txt_4c_CdSgrupoP
895:             .Left      = 116
896:             .Top       = 492
897:             .Width     = 65
898:             .Height    = 21
899:             .ReadOnly  = .T.
900:             .BackColor = RGB(230,230,230)
901:             .FontName  = "Tahoma"
902:             .FontSize  = 8
903:         ENDWITH
904:         loc_oSub.AddObject("txt_4c_DsSgrupoP", "TextBox")
905:         WITH loc_oSub.txt_4c_DsSgrupoP
906:             .Left      = 182
907:             .Top       = 492
908:             .Width     = 270
909:             .Height    = 21
910:             .ReadOnly  = .T.
911:             .BackColor = RGB(230,230,230)
912:             .FontName  = "Tahoma"
913:             .FontSize  = 8
914:         ENDWITH
915: 
916:         *-- Row 492 right side: Fornecedor
917:         loc_oSub.AddObject("lbl_4c_LblForn", "Label")
918:         WITH loc_oSub.lbl_4c_LblForn
919:             .Caption   = "Fornecedor :"
920:             .Left      = 519
921:             .Top       = 496
922:             .Width     = 72
923:             .Height    = 15
924:             .AutoSize  = .F.
925:             .BackStyle = 0
926:             .FontName  = "Tahoma"
927:             .FontSize  = 8
928:         ENDWITH
929:         loc_oSub.AddObject("txt_4c_CdFornecedor", "TextBox")
930:         WITH loc_oSub.txt_4c_CdFornecedor
931:             .Left      = 593
932:             .Top       = 492
933:             .Width     = 80
934:             .Height    = 21
935:             .ReadOnly  = .T.
936:             .BackColor = RGB(230,230,230)
937:             .FontName  = "Tahoma"
938:             .FontSize  = 8
939:         ENDWITH
940:         loc_oSub.AddObject("txt_4c_DsFornecedor", "TextBox")
941:         WITH loc_oSub.txt_4c_DsFornecedor
942:             .Left      = 674
943:             .Top       = 492
944:             .Width     = 220
945:             .Height    = 21
946:             .ReadOnly  = .T.
947:             .BackColor = RGB(230,230,230)
948:             .FontName  = "Tahoma"
949:             .FontSize  = 8
950:         ENDWITH
951: 
952:         *-- Row 514: Modelo (left) + Ref Fornecedor (right)
953:         loc_oSub.AddObject("lbl_4c_LblModelo", "Label")
954:         WITH loc_oSub.lbl_4c_LblModelo
955:             .Caption   = "Modelo :"
956:             .Left      = 62
957:             .Top       = 517
958:             .Width     = 50
959:             .Height    = 15
960:             .AutoSize  = .F.
961:             .BackStyle = 0
962:             .FontName  = "Tahoma"
963:             .FontSize  = 8
964:         ENDWITH
965:         loc_oSub.AddObject("txt_4c_CodFinP", "TextBox")
966:         WITH loc_oSub.txt_4c_CodFinP
967:             .Left      = 116
968:             .Top       = 514
969:             .Width     = 65
970:             .Height    = 21
971:             .ReadOnly  = .T.
972:             .BackColor = RGB(230,230,230)
973:             .FontName  = "Tahoma"
974:             .FontSize  = 8
975:         ENDWITH
976:         loc_oSub.AddObject("txt_4c_DesFinP", "TextBox")
977:         WITH loc_oSub.txt_4c_DesFinP
978:             .Left      = 182
979:             .Top       = 514
980:             .Width     = 270
981:             .Height    = 21
982:             .ReadOnly  = .T.
983:             .BackColor = RGB(230,230,230)
984:             .FontName  = "Tahoma"
985:             .FontSize  = 8
986:         ENDWITH
987:         loc_oSub.AddObject("lbl_4c_LblRefForn", "Label")
988:         WITH loc_oSub.lbl_4c_LblRefForn
989:             .Caption   = "Ref. Fornecedor :"
990:             .Left      = 495
991:             .Top       = 517
992:             .Width     = 92
993:             .Height    = 15
994:             .AutoSize  = .F.
995:             .BackStyle = 0
996:             .FontName  = "Tahoma"
997:             .FontSize  = 8
998:         ENDWITH
999:         loc_oSub.AddObject("txt_4c_RefFornecedor", "TextBox")
1000:         WITH loc_oSub.txt_4c_RefFornecedor
1001:             .Left      = 593
1002:             .Top       = 514
1003:             .Width     = 190
1004:             .Height    = 21
1005:             .ReadOnly  = .T.
1006:             .BackColor = RGB(230,230,230)
1007:             .FontName  = "Tahoma"
1008:             .FontSize  = 8
1009:         ENDWITH
1010: 
1011:         *-- Row 537: Grupo de Venda (left) + PrecoVenda/Peso (right)
1012:         loc_oSub.AddObject("lbl_4c_LblGrpVenda", "Label")
1013:         WITH loc_oSub.lbl_4c_LblGrpVenda
1014:             .Caption   = "Grupo de Venda :"
1015:             .Left      = 19
1016:             .Top       = 540
1017:             .Width     = 92
1018:             .Height    = 15
1019:             .AutoSize  = .F.
1020:             .BackStyle = 0
1021:             .FontName  = "Tahoma"
1022:             .FontSize  = 8
1023:         ENDWITH
1024:         loc_oSub.AddObject("txt_4c_GrpVenda", "TextBox")
1025:         WITH loc_oSub.txt_4c_GrpVenda
1026:             .Left      = 116
1027:             .Top       = 537
1028:             .Width     = 80
1029:             .Height    = 21
1030:             .ReadOnly  = .T.
1031:             .BackColor = RGB(230,230,230)
1032:             .FontName  = "Tahoma"
1033:             .FontSize  = 8
1034:         ENDWITH
1035:         loc_oSub.AddObject("txt_4c_GrDvenda", "TextBox")
1036:         WITH loc_oSub.txt_4c_GrDvenda
1037:             .Left      = 197
1038:             .Top       = 537
1039:             .Width     = 255
1040:             .Height    = 21
1041:             .ReadOnly  = .T.
1042:             .BackColor = RGB(230,230,230)
1043:             .FontName  = "Tahoma"
1044:             .FontSize  = 8
1045:         ENDWITH
1046:         loc_oSub.AddObject("lbl_4c_LblPrVenda", "Label")
1047:         WITH loc_oSub.lbl_4c_LblPrVenda
1048:             .Caption   = "Pre" + CHR(231) + "o Venda :"
1049:             .Left      = 538
1050:             .Top       = 540
1051:             .Width     = 70
1052:             .Height    = 15
1053:             .AutoSize  = .F.
1054:             .BackStyle = 0
1055:             .FontName  = "Tahoma"
1056:             .FontSize  = 8
1057:         ENDWITH
1058:         loc_oSub.AddObject("txt_4c_PrVenda", "TextBox")
1059:         WITH loc_oSub.txt_4c_PrVenda
1060:             .Left      = 593
1061:             .Top       = 536
1062:             .Width     = 108
1063:             .Height    = 21
1064:             .ReadOnly  = .T.
1065:             .BackColor = RGB(230,230,230)
1066:             .FontName  = "Tahoma"
1067:             .FontSize  = 8
1068:         ENDWITH
1069:         loc_oSub.AddObject("txt_4c_MoedaPrVenda", "TextBox")
1070:         WITH loc_oSub.txt_4c_MoedaPrVenda
1071:             .Left      = 703
1072:             .Top       = 536
1073:             .Width     = 31
1074:             .Height    = 21
1075:             .ReadOnly  = .T.
1076:             .BackColor = RGB(230,230,230)
1077:             .FontName  = "Tahoma"
1078:             .FontSize  = 8
1079:         ENDWITH
1080:         loc_oSub.AddObject("lbl_4c_LblPeso", "Label")
1081:         WITH loc_oSub.lbl_4c_LblPeso
1082:             .Caption   = "Peso :"
1083:             .Left      = 740
1084:             .Top       = 540
1085:             .Width     = 40
1086:             .Height    = 15
1087:             .AutoSize  = .F.
1088:             .BackStyle = 0
1089:             .FontName  = "Tahoma"
1090:             .FontSize  = 8
1091:         ENDWITH
1092:         loc_oSub.AddObject("txt_4c_PesoMedio", "TextBox")
1093:         WITH loc_oSub.txt_4c_PesoMedio
1094:             .Left      = 781
1095:             .Top       = 537
1096:             .Width     = 75
1097:             .Height    = 21
1098:             .ReadOnly  = .T.
1099:             .BackColor = RGB(230,230,230)
1100:             .FontName  = "Tahoma"
1101:             .FontSize  = 8
1102:         ENDWITH
1103: 
1104:         *-- Filter row 2: Subgrupo filter
1105:         loc_oSub.AddObject("lbl_4c_LblSgrupoF", "Label")
1106:         WITH loc_oSub.lbl_4c_LblSgrupoF
1107:             .Caption   = "Subgrupo :"
1108:             .Left      = 174
1109:             .Top       = 100
1110:             .Width     = 55
1111:             .Height    = 15
1112:             .AutoSize  = .F.
1113:             .BackStyle = 0
1114:             .FontName  = "Tahoma"
1115:             .FontSize  = 8
1116:         ENDWITH
1117:         loc_oSub.AddObject("txt_4c_CodSgrupo", "TextBox")
1118:         WITH loc_oSub.txt_4c_CodSgrupo
1119:             .Left     = 175
1120:             .Top      = 115
1121:             .Width    = 52
1122:             .Height   = 23
1123:             .FontName = "Tahoma"
1124:             .FontSize = 8
1125:         ENDWITH
1126:         loc_oSub.AddObject("txt_4c_DsSgrupo", "TextBox")
1127:         WITH loc_oSub.txt_4c_DsSgrupo
1128:             .Left     = 228
1129:             .Top      = 115
1130:             .Width    = 236
1131:             .Height   = 23
1132:             .FontName = "Tahoma"
1133:             .FontSize = 8
1134:         ENDWITH

*-- Linhas 1143 a 1227:
1143:         *-- Obs container
1144:         loc_oSub.AddObject("cnt_4c_Operacao", "Container")
1145:         WITH loc_oSub.cnt_4c_Operacao
1146:             .Left        = 3
1147:             .Top         = 13
1148:             .Width       = 564
1149:             .Height      = 165
1150:             .BackColor   = RGB(240,240,240)
1151:             .BorderWidth = 1
1152:             .BackStyle   = 1
1153:             .Visible     = .T.
1154:         ENDWITH
1155:         loc_oSub.cnt_4c_Operacao.AddObject("lbl_4c__Obs", "Label")
1156:         WITH loc_oSub.cnt_4c_Operacao.lbl_4c__Obs
1157:             .Caption   = "Obs. :"
1158:             .Left      = 12
1159:             .Top       = 10
1160:             .Width     = 40
1161:             .Height    = 15
1162:             .AutoSize  = .F.
1163:             .BackStyle = 0
1164:             .FontBold  = .T.
1165:             .FontName  = "Tahoma"
1166:             .FontSize  = 8
1167:         ENDWITH
1168:         loc_oSub.cnt_4c_Operacao.AddObject("txt_4c_CodObs", "TextBox")
1169:         WITH loc_oSub.cnt_4c_Operacao.txt_4c_CodObs
1170:             .Left     = 52
1171:             .Top      = 10
1172:             .Width    = 27
1173:             .Height   = 20
1174:             .FontName = "Tahoma"
1175:             .FontSize = 8
1176:         ENDWITH
1177:         loc_oSub.cnt_4c_Operacao.AddObject("obj_4c_GetObs", "EditBox")
1178:         WITH loc_oSub.cnt_4c_Operacao.obj_4c_GetObs
1179:             .Left     = 83
1180:             .Top      = 10
1181:             .Width    = 407
1182:             .Height   = 112
1183:             .FontName = "Tahoma"
1184:             .FontSize = 8
1185:         ENDWITH
1186: 
1187:         *-- Process commandgroup (1 button: Processar Distribuicao)
1188:         loc_oSub.AddObject("cmdg_4c_ProcOper", "CommandGroup")
1189:         WITH loc_oSub.cmdg_4c_ProcOper
1190:             .Left        = 733
1191:             .Top         = 11
1192:             .Width       = 120
1193:             .Height      = 122
1194:             .ButtonCount = 1
1195:         ENDWITH
1196:         WITH loc_oSub.cmdg_4c_ProcOper.Buttons(1)
1197:             .Caption = "Processar Distribui" + CHR(231) + CHR(227) + "o"
1198:             .Left    = 5
1199:             .Top     = 5
1200:             .Width   = 106
1201:             .Height  = 110
1202:             .Picture = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
1203:         ENDWITH
1204: 
1205:         *-- Operations pageframe (Movimentacoes + Itens)
1206:         loc_oSub.AddObject("pgf_4c_Operacoes", "PageFrame")
1207:         WITH loc_oSub.pgf_4c_Operacoes
1208:             .Left      = 1
1209:             .Top       = 191
1210:             .Width     = 997
1211:             .Height    = 377
1212:             .PageCount = 2
1213:             .Tabs      = .T.
1214:             .Page1.Caption = "Movimenta" + CHR(231) + CHR(245) + "es"
1215:             .Page2.Caption = "Itens"
1216:         ENDWITH
1217: 
1218:         *-- grdCabOperas: 8 columns matching legacy (emps/dopes/numes/empds/grupos/contaos/grupods/contads)
1219:         loc_oSub.pgf_4c_Operacoes.Page1.AddObject("grd_4c_CabOperas", "Grid")
1220:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas
1221:             .Left             = 9
1222:             .Top              = 6
1223:             .Width            = 975
1224:             .Height           = 339
1225:             .RecordSource     = ""
1226:             .RecordSourceType = 1
1227:             .ColumnCount      = 8

*-- Linhas 1236 a 1286:
1236:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1
1237:             .ControlSource   = "cursor_4c_CabOpera.emps"
1238:             .Width           = 45
1239:             .Header1.Caption = "Emp O"
1240:         ENDWITH
1241:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2
1242:             .ControlSource   = "cursor_4c_CabOpera.dopes"
1243:             .Width           = 250
1244:             .Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1245:         ENDWITH
1246:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3
1247:             .ControlSource   = "cursor_4c_CabOpera.numes"
1248:             .Width           = 80
1249:             .Header1.Caption = "N" + CHR(176)
1250:         ENDWITH
1251:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4
1252:             .ControlSource   = "cursor_4c_CabOpera.empds"
1253:             .Width           = 45
1254:             .Header1.Caption = "Emp D"
1255:         ENDWITH
1256:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5
1257:             .ControlSource   = "cursor_4c_CabOpera.grupos"
1258:             .Width           = 80
1259:             .Header1.Caption = "Grupo Orig"
1260:         ENDWITH
1261:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6
1262:             .ControlSource   = "cursor_4c_CabOpera.contaos"
1263:             .Width           = 80
1264:             .Header1.Caption = "Conta Orig"
1265:         ENDWITH
1266:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column7
1267:             .ControlSource   = "cursor_4c_CabOpera.grupods"
1268:             .Width           = 80
1269:             .Header1.Caption = "Grupo Dest"
1270:         ENDWITH
1271:         WITH loc_oSub.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column8
1272:             .ControlSource   = "cursor_4c_CabOpera.contads"
1273:             .Width           = 80
1274:             .Header1.Caption = "Conta Dest"
1275:         ENDWITH
1276: 
1277:         *-- grdItnOperas: 6 columns (cpros/dpros/codcors/codtams/qtds/locals)
1278:         loc_oSub.pgf_4c_Operacoes.Page2.AddObject("grd_4c_ItnOperas", "Grid")
1279:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas
1280:             .Left             = 9
1281:             .Top              = 5
1282:             .Width            = 975
1283:             .Height           = 340
1284:             .RecordSource     = ""
1285:             .RecordSourceType = 1
1286:             .ColumnCount      = 6

*-- Linhas 1295 a 1328:
1295:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column1
1296:             .ControlSource   = "cursor_4c_ItensOper.cpros"
1297:             .Width           = 106
1298:             .Header1.Caption = "C" + CHR(243) + "digo"
1299:         ENDWITH
1300:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column2
1301:             .ControlSource   = "cursor_4c_ItensOper.dpros"
1302:             .Width           = 382
1303:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1304:         ENDWITH
1305:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column3
1306:             .ControlSource   = "cursor_4c_ItensOper.codcors"
1307:             .Width           = 60
1308:             .Header1.Caption = "Cor"
1309:         ENDWITH
1310:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column4
1311:             .ControlSource   = "cursor_4c_ItensOper.codtams"
1312:             .Width           = 60
1313:             .Header1.Caption = "Tam"
1314:         ENDWITH
1315:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column5
1316:             .ControlSource   = "cursor_4c_ItensOper.qtds"
1317:             .Width           = 150
1318:             .Header1.Caption = "Quantidade"
1319:         ENDWITH
1320:         WITH loc_oSub.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column6
1321:             .ControlSource   = "cursor_4c_ItensOper.locals"
1322:             .Width           = 150
1323:             .Header1.Caption = "Local"
1324:         ENDWITH
1325:     ENDPROC
1326: 
1327:     *==========================================================================
1328:     * METODOS DE NEGOCIO

*-- Linhas 1340 a 1404:
1340:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.ColumnCount = 2
1341:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = "cursor_4c_Dados"
1342:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.ControlSource = "cursor_4c_Dados.Codigos"
1343:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1344:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column2.ControlSource = "cursor_4c_Dados.Datas"
1345:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column2.Header1.Caption = "Data"
1346:         ENDIF
1347:         THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
1348:     ENDPROC
1349: 
1350:     PROCEDURE AbrirNovoBatch()
1351:     *==========================================================================
1352:         THIS.this_cEscolha = "INSERIR"
1353:         THIS.this_cCodigos = ALLTRIM(TRANSFORM(fGerUniqueKey("SIGPRDIS"), "@L 9999999999"))
1354:         THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = THIS.this_cCodigos
1355:         THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = "NOVO"
1356: 
1357:         IF THIS.this_oBusinessObject.BuscarEstoques()
1358:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = ""
1359:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.ColumnCount = 4
1360:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = "cursor_4c_Estoques"
1361:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.ControlSource = "cursor_4c_Estoques.nMarca"
1362:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.Header1.Caption = ""
1363:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.ControlSource = "cursor_4c_Estoques.emps"
1364:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.Header1.Caption = "Empresa"
1365:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.ControlSource = "cursor_4c_Estoques.grupos"
1366:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.Header1.Caption = "Grupo"
1367:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.ControlSource = "cursor_4c_Estoques.contas"
1368:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.Header1.Caption = "Conta"
1369:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1370:         ENDIF
1371: 
1372:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
1373:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .F.
1374:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 1
1375:         THIS.pgf_4c_Paginas.ActivePage = 2
1376:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1377:     ENDPROC
1378: 
1379:     PROCEDURE AbrirBatchExistente(par_cCodigos)
1380:     *==========================================================================
1381:         THIS.this_cEscolha = "ALTERAR"
1382:         THIS.this_cCodigos = par_cCodigos
1383:         THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = par_cCodigos
1384:         THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = "EDITAR"
1385: 
1386:         THIS.this_oBusinessObject.InicializarLote(par_cCodigos)
1387: 
1388:         IF THIS.this_oBusinessObject.BuscarEstoques()
1389:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = ""
1390:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.ColumnCount = 4
1391:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = "cursor_4c_Estoques"
1392:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.ControlSource = "cursor_4c_Estoques.nMarca"
1393:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.Header1.Caption = ""
1394:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.ControlSource = "cursor_4c_Estoques.emps"
1395:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.Header1.Caption = "Empresa"
1396:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.ControlSource = "cursor_4c_Estoques.grupos"
1397:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.Header1.Caption = "Grupo"
1398:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.ControlSource = "cursor_4c_Estoques.contas"
1399:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.Header1.Caption = "Conta"
1400:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1401:         ENDIF
1402: 
1403:         *-- Pre-marcar estoques do lote
1404:         IF USED("cursor_4c_Estoques") AND USED("cursor_4c_LotePrDis")

*-- Linhas 1427 a 1457:
1427:             loc_oGrdCab.ColumnCount  = 8
1428:             loc_oGrdCab.RecordSource = "cursor_4c_CabOpera"
1429:             loc_oGrdCab.Column1.ControlSource   = "cursor_4c_CabOpera.emps"
1430:             loc_oGrdCab.Column1.Header1.Caption = "Emp O"
1431:             loc_oGrdCab.Column2.ControlSource   = "cursor_4c_CabOpera.dopes"
1432:             loc_oGrdCab.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1433:             loc_oGrdCab.Column3.ControlSource   = "cursor_4c_CabOpera.numes"
1434:             loc_oGrdCab.Column3.Header1.Caption = "N" + CHR(176)
1435:             loc_oGrdCab.Column4.ControlSource   = "cursor_4c_CabOpera.empds"
1436:             loc_oGrdCab.Column4.Header1.Caption = "Emp D"
1437:             loc_oGrdCab.Column5.ControlSource   = "cursor_4c_CabOpera.grupos"
1438:             loc_oGrdCab.Column5.Header1.Caption = "Grupo Orig"
1439:             loc_oGrdCab.Column6.ControlSource   = "cursor_4c_CabOpera.contaos"
1440:             loc_oGrdCab.Column6.Header1.Caption = "Conta Orig"
1441:             loc_oGrdCab.Column7.ControlSource   = "cursor_4c_CabOpera.grupods"
1442:             loc_oGrdCab.Column7.Header1.Caption = "Grupo Dest"
1443:             loc_oGrdCab.Column8.ControlSource   = "cursor_4c_CabOpera.contads"
1444:             loc_oGrdCab.Column8.Header1.Caption = "Conta Dest"
1445:             loc_oGrdCab.Refresh()
1446:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .T.
1447:         ENDIF
1448: 
1449:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
1450:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 1
1451:         THIS.pgf_4c_Paginas.ActivePage = 2
1452:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1453:     ENDPROC
1454: 
1455:     *==========================================================================
1456:     PROCEDURE AlternarPagina(par_nPagina)
1457:     *==========================================================================

*-- Linhas 1466 a 1474:
1466:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1467:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
1468:             ELSE
1469:                 THIS.pgf_4c_Paginas.Page1.cmd_4c_Novo.SetFocus()
1470:             ENDIF
1471:         ENDIF
1472:         loc_lResultado = .T.
1473:         RETURN loc_lResultado
1474:     ENDPROC

*-- Linhas 1536 a 1551:
1536:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1537:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
1538:         ELSE
1539:             THIS.pgf_4c_Paginas.Page1.cmd_4c_Novo.SetFocus()
1540:         ENDIF
1541:     ENDPROC
1542: 
1543:     PROCEDURE BtnVoltarEstClick()
1544:     *==========================================================================
1545:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage = 1
1546:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1547:     ENDPROC
1548: 
1549:     PROCEDURE BtnMarcarClick()
1550:     *==========================================================================
1551:         IF USED("cursor_4c_Estoques")

*-- Linhas 1596 a 1630:
1596:                 loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
1597:                 loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_Disponivel"
1598:                 loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_Disponivel.cpros"
1599:                 loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1600:                 loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_Disponivel.dpros"
1601:                 loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1602:                 loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_Disponivel.codcors"
1603:                 loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
1604:                 loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_Disponivel.codtams"
1605:                 loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
1606:                 loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_Disponivel.QtdEstoque"
1607:                 loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
1608:                 loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
1609:                 loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
1610:                 loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
1611:                 loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
1612:             ENDIF
1613:             loc_oSub2.grd_4c_Disponivel.Refresh()
1614:             loc_oSub2.grd_4c_Distribui.RecordSource = ""
1615:             IF USED("cursor_4c_Distribui")
1616:                 loc_oSub2.grd_4c_Distribui.ColumnCount = 4
1617:                 loc_oSub2.grd_4c_Distribui.RecordSource = "cursor_4c_Distribui"
1618:                 loc_oSub2.grd_4c_Distribui.Column1.ControlSource = "cursor_4c_Distribui.emps"
1619:                 loc_oSub2.grd_4c_Distribui.Column1.Header1.Caption = "Empresa"
1620:                 loc_oSub2.grd_4c_Distribui.Column2.ControlSource = "cursor_4c_Distribui.QtdSaldo"
1621:                 loc_oSub2.grd_4c_Distribui.Column2.Header1.Caption = "Saldo"
1622:                 loc_oSub2.grd_4c_Distribui.Column3.ControlSource = "cursor_4c_Distribui.QtdDistr"
1623:                 loc_oSub2.grd_4c_Distribui.Column3.Header1.Caption = "Quantidade"
1624:                 loc_oSub2.grd_4c_Distribui.Column4.ControlSource = "cursor_4c_Distribui.locals"
1625:                 loc_oSub2.grd_4c_Distribui.Column4.Header1.Caption = "Local"
1626:             ENDIF
1627:             loc_oSub2.grd_4c_Distribui.Refresh()
1628:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .T.
1629:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 2
1630:             loc_oSub2.grd_4c_Disponivel.SetFocus()

*-- Linhas 1989 a 2009:
1989:             loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
1990:             loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_Disponivel"
1991:             loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_Disponivel.cpros"
1992:             loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1993:             loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_Disponivel.dpros"
1994:             loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1995:             loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_Disponivel.codcors"
1996:             loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
1997:             loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_Disponivel.codtams"
1998:             loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
1999:             loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_Disponivel.QtdEstoque"
2000:             loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
2001:             loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
2002:             loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
2003:             loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
2004:             loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
2005:             loc_oSub2.grd_4c_Disponivel.Refresh()
2006:         ELSE
2007:             TRY
2008:                 IF USED("cursor_4c_DispFiltro")
2009:                     USE IN cursor_4c_DispFiltro

*-- Linhas 2026 a 2046:
2026:                     loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
2027:                     loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_DispFiltro"
2028:                     loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_DispFiltro.cpros"
2029:                     loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2030:                     loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_DispFiltro.dpros"
2031:                     loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2032:                     loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_DispFiltro.codcors"
2033:                     loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
2034:                     loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_DispFiltro.codtams"
2035:                     loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
2036:                     loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_DispFiltro.QtdEstoque"
2037:                     loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
2038:                     loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_DispFiltro.QtdSaida"
2039:                     loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Distribuido"
2040:                     loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_DispFiltro.QtdSaldo"
2041:                     loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
2042:                     loc_oSub2.grd_4c_Disponivel.Refresh()
2043:                 ENDIF
2044:             CATCH TO loc_oErro
2045:                 MsgErro(loc_oErro.Message, "Erro Filtrar")
2046:             ENDTRY

*-- Linhas 2096 a 2130:
2096:         IF THIS.this_oBusinessObject.ProcessarDistribuicao(THIS.this_cCodigos, THIS.this_cEscolha)
2097:             MsgInfo("Distribui" + CHR(231) + CHR(227) + "o salva com sucesso.", "Sucesso")
2098:             THIS.this_cEscolha = "ALTERAR"
2099:             THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption = "EDITAR"
2100:             *-- Switch to operacoes page
2101:             IF THIS.this_oBusinessObject.BuscarOperacoes(THIS.this_cCodigos)
2102:                 LOCAL loc_oSub3 AS Object
2103:                 loc_oSub3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
2104:                 LOCAL loc_oGrdCab2 AS Object
2105:                 loc_oGrdCab2 = loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas
2106:                 loc_oGrdCab2.RecordSource = ""
2107:                 IF USED("cursor_4c_CabOpera")
2108:                     loc_oGrdCab2.ColumnCount  = 8
2109:                     loc_oGrdCab2.RecordSource = "cursor_4c_CabOpera"
2110:                     loc_oGrdCab2.Column1.ControlSource   = "cursor_4c_CabOpera.emps"
2111:                     loc_oGrdCab2.Column1.Header1.Caption = "Emp O"
2112:                     loc_oGrdCab2.Column2.ControlSource   = "cursor_4c_CabOpera.dopes"
2113:                     loc_oGrdCab2.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2114:                     loc_oGrdCab2.Column3.ControlSource   = "cursor_4c_CabOpera.numes"
2115:                     loc_oGrdCab2.Column3.Header1.Caption = "N" + CHR(176)
2116:                     loc_oGrdCab2.Column4.ControlSource   = "cursor_4c_CabOpera.empds"
2117:                     loc_oGrdCab2.Column4.Header1.Caption = "Emp D"
2118:                     loc_oGrdCab2.Column5.ControlSource   = "cursor_4c_CabOpera.grupos"
2119:                     loc_oGrdCab2.Column5.Header1.Caption = "Grupo Orig"
2120:                     loc_oGrdCab2.Column6.ControlSource   = "cursor_4c_CabOpera.contaos"
2121:                     loc_oGrdCab2.Column6.Header1.Caption = "Conta Orig"
2122:                     loc_oGrdCab2.Column7.ControlSource   = "cursor_4c_CabOpera.grupods"
2123:                     loc_oGrdCab2.Column7.Header1.Caption = "Grupo Dest"
2124:                     loc_oGrdCab2.Column8.ControlSource   = "cursor_4c_CabOpera.contads"
2125:                     loc_oGrdCab2.Column8.Header1.Caption = "Conta Dest"
2126:                 ENDIF
2127:                 loc_oGrdCab2.Refresh()
2128:                 loc_oSub3.Enabled = .T.
2129:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage = 3
2130:             ENDIF

*-- Linhas 2158 a 2176:
2158:                     loc_oGrdItn.ColumnCount  = 6
2159:                     loc_oGrdItn.RecordSource = "cursor_4c_ItensOper"
2160:                     loc_oGrdItn.Column1.ControlSource   = "cursor_4c_ItensOper.cpros"
2161:                     loc_oGrdItn.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2162:                     loc_oGrdItn.Column2.ControlSource   = "cursor_4c_ItensOper.dpros"
2163:                     loc_oGrdItn.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2164:                     loc_oGrdItn.Column3.ControlSource   = "cursor_4c_ItensOper.codcors"
2165:                     loc_oGrdItn.Column3.Header1.Caption = "Cor"
2166:                     loc_oGrdItn.Column4.ControlSource   = "cursor_4c_ItensOper.codtams"
2167:                     loc_oGrdItn.Column4.Header1.Caption = "Tam"
2168:                     loc_oGrdItn.Column5.ControlSource   = "cursor_4c_ItensOper.qtds"
2169:                     loc_oGrdItn.Column5.Header1.Caption = "Quantidade"
2170:                     loc_oGrdItn.Column6.ControlSource   = "cursor_4c_ItensOper.locals"
2171:                     loc_oGrdItn.Column6.Header1.Caption = "Local"
2172:                 ENDIF
2173:                 loc_oGrdItn.Refresh()
2174:             ENDIF
2175:         ENDIF
2176:     ENDPROC

*-- Linhas 2210 a 2239:
2210:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
2211:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
2212:         ELSE
2213:             THIS.pgf_4c_Paginas.Page1.cmd_4c_Novo.SetFocus()
2214:         ENDIF
2215:     ENDPROC
2216: 
2217:     *==========================================================================
2218:     * BtnCancelarClick - Cancela operacao em Page2 e volta para a lista
2219:     *==========================================================================
2220:     PROCEDURE BtnCancelarClick()
2221:         IF MsgConfirma("Cancelar e voltar para a lista de lotes?", ;
2222:                 "Cancelar Opera" + CHR(231) + CHR(227) + "o")
2223:             THIS.this_cEscolha = ""
2224:             THIS.this_cCodigos = ""
2225:             THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = ""
2226:             THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = ""
2227:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
2228:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .F.
2229:             THIS.pgf_4c_Paginas.ActivePage = 1
2230:             THIS.CarregarLista()
2231:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
2232:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
2233:             ELSE
2234:                 THIS.pgf_4c_Paginas.Page1.cmd_4c_Novo.SetFocus()
2235:             ENDIF
2236:         ENDIF
2237:     ENDPROC
2238: 
2239:     *==========================================================================

*-- Linhas 2247 a 2256:
2247:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2248:         loc_oPg1.txt_4c_DtInicial.Enabled = par_lHabilitar
2249:         loc_oPg1.txt_4c_DtFinal.Enabled   = par_lHabilitar
2250:         loc_oPg1.cmd_4c_Novo.Enabled       = par_lHabilitar
2251:         loc_oPg1.cmd_4c_Abrir.Enabled      = par_lHabilitar
2252:     ENDPROC
2253: 
2254:     *==========================================================================
2255:     * LimparCampos - Reseta filtros de data para hoje e recarrega lista
2256:     *==========================================================================


### BO (C:\4c\projeto\app\classes\sigprdisBO.prg):
*=============================================================================*
* sigprdisBO.prg - Business Object para Distribuicao de Produtos
*=============================================================================*
* Herda de: BusinessBase
* Form associado: Formsigprdis.prg (forms\operacionais\)
* Tabela principal: sigprdis (PK: cidchaves)
* Tabela auxiliar : SIGTEMPD  (cidchaves C64 - temp de processamento)
*
* Descricao: Gerencia a distribuicao de produtos entre empresas/estoques.
*   - Page1 (Lista): lista de distribuicoes por periodo (TmpSigPrDis)
*   - Page2 (Dados): grade de disponivel (crDisponivel) e distribuicao
*                    (crDistribui) por empresa/grupo/conta
*   - Page3 (Ops)  : historico de operacoes geradas pelo processamento
*
* Campos sigprdis:
*   cidchaves C(20)   PK auto (fUniqueIds por linha)
*   codigos   C(10)   chave de lote (agrupa N linhas do mesmo lote)
*   datas     T       data/hora do lote
*   dtalts    T       data/hora ultima alteracao
*   cpros     C(14)   codigo do produto
*   codcors   C(4)    codigo da cor
*   codtams   C(4)    codigo do tamanho
*   empdopnums C(29)  empresa+operacao+numero destino gerado
*   empds     C(3)    empresa destino
*   empgruests C(23)  empresa+grupo+conta (composto 3+10+10)
*   locals    C(10)   localizacao/enderecamento
*   qtds      N(10,2) quantidade distribuida
*   qtdos     N(10,2) quantidade original (pre-distribuicao)
*   usuars    C(10)   usuario que criou
*   usualts   C(10)   usuario que alterou por ultimo
*   oridopnums C(29)  empresa+operacao+numero origem
*=============================================================================*

DEFINE CLASS sigprdisBO AS BusinessBase

    *-- Identificacao do lote (chave de negocio usada nos SELECTs de listagem)
    this_cCodigos       = ""

    *-- PK fisica de cada linha da distribuicao (gerada por fUniqueIds)
    this_cCidChaves     = ""

    *-- Data e hora do lote
    this_dDatas         = {}

    *-- Data e hora da ultima alteracao
    this_dDtAlts        = {}

    *-- Codigo do produto distribuido
    this_cCpros         = ""

    *-- Codigo da cor do produto
    this_cCodCors       = ""

    *-- Codigo do tamanho do produto
    this_cCodTams       = ""

    *-- Empresa + Operacao + Numero destino (composto char 29)
    this_cEmpDopNums    = ""

    *-- Empresa destino (char 3)
    this_cEmpDs         = ""

    *-- Empresa + Grupo + Conta composto (char 23 = 3+10+10)
    this_cEmpGruEsts    = ""

    *-- Localizacao / enderecamento do estoque (char 10)
    this_cLocals        = ""

    *-- Quantidade distribuida
    this_nQtds          = 0

    *-- Quantidade original (antes da distribuicao, preenchida no processamento)
    this_nQtdOs         = 0

    *-- Usuario que criou o lancamento
    this_cUsuars        = ""

    *-- Usuario da ultima alteracao
    this_cUsuAlts       = ""

    *-- Empresa + Operacao + Numero origem (char 29)
    this_cOriDopNums    = ""

    *-- Filtros de pesquisa de lotes (usados em Buscar)
    this_dDataInicial   = {}
    this_dDataFinal     = {}

    *-- Chave de query temporaria (cidquerys em SIGTEMPD, gerada por fUniqueIds)
    this_cCidQuerys     = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO com tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "sigprdis"
        THIS.this_cCampoChave  = "cidchaves"
        THIS.this_dDataInicial = DATE()
        THIS.this_dDataFinal   = DATE()
    ENDPROC


    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (BusinessBase)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *==========================================================================
    * METODOS CRUD (BusinessBase)
    *==========================================================================

    *--------------------------------------------------------------------------
    * Buscar - Lista lotes de distribuicao por periodo (cursor_4c_Dados)
    * Colunas: Codigos, Datas
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cWhere)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT DISTINCT Codigos, Datas FROM SigPrDis" + ;
                       " WHERE CAST(Datas AS date) BETWEEN " + ;
                       FormatarDataSQL(THIS.this_dDataInicial) + ;
                       " AND " + FormatarDataSQL(THIS.this_dDataFinal) + ;
                       " ORDER BY Datas DESC"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar distribui" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega primeira linha de um lote pelo campo Codigos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT TOP 1 * FROM SigPrDis" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " ORDER BY cidchaves"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso             = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_cCodigos       = ALLTRIM(par_cCodigos)
                THIS.this_lNovoRegistro  = .F.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves   = TratarNulo(cidchaves,   "C")
            THIS.this_cCodigos     = TratarNulo(codigos,     "C")
            THIS.this_dDatas       = IIF(ISNULL(datas),  {}, datas)
            THIS.this_dDtAlts      = IIF(ISNULL(dtalts), {}, dtalts)
            THIS.this_cCpros       = TratarNulo(cpros,       "C")
            THIS.this_cCodCors     = TratarNulo(codcors,     "C")
            THIS.this_cCodTams     = TratarNulo(codtams,     "C")
            THIS.this_cEmpDopNums  = TratarNulo(empdopnums,  "C")
            THIS.this_cEmpDs       = TratarNulo(empds,       "C")
            THIS.this_cEmpGruEsts  = TratarNulo(empgruests,  "C")
            THIS.this_cLocals      = TratarNulo(locals,      "C")
            THIS.this_nQtds        = TratarNulo(qtds,        "N")
            THIS.this_nQtdOs       = TratarNulo(qtdos,       "N")
            THIS.this_cUsuars      = TratarNulo(usuars,      "C")
            THIS.this_cUsuAlts     = TratarNulo(usualts,     "C")
            THIS.this_cOriDopNums  = TratarNulo(oridopnums,  "C")
            loc_lSucesso           = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de uma linha de distribuicao em SigPrDis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidChaves)
            THIS.this_cCidChaves = fUniqueIds()
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SigPrDis" + ;
                       " (cidchaves, codigos, codcors, codtams, cpros," + ;
                       "  datas, dtalts, empdopnums, empds, empgruests," + ;
                       "  locals, qtdos, qtds, usualts, usuars, oridopnums)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves)                       + "," + ;
                       EscaparSQL(THIS.this_cCodigos)                         + "," + ;
                       EscaparSQL(THIS.this_cCodCors)                         + "," + ;
                       EscaparSQL(THIS.this_cCodTams)                         + "," + ;
                       EscaparSQL(THIS.this_cCpros)                           + "," + ;
                       "GETDATE(),"                                                  + ;
                       "GETDATE(),"                                                  + ;
                       EscaparSQL(THIS.this_cEmpDopNums)                      + "," + ;
                       EscaparSQL(THIS.this_cEmpDs)                           + "," + ;
                       EscaparSQL(THIS.this_cEmpGruEsts)                      + "," + ;
                       EscaparSQL(THIS.this_cLocals)                          + "," + ;
                       FormatarNumeroSQL(THIS.this_nQtdOs)                    + "," + ;
                       FormatarNumeroSQL(THIS.this_nQtds)                     + "," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))              + "," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))              + "," + ;
                       EscaparSQL(THIS.this_cOriDopNums)                      + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao inserir distribui" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de uma linha de distribuicao em SigPrDis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrDis SET" + ;
                       "  codcors    = " + EscaparSQL(THIS.this_cCodCors)              + "," + ;
                       "  codtams    = " + EscaparSQL(THIS.this_cCodTams)              + "," + ;
                       "  cpros      = " + EscaparSQL(THIS.this_cCpros)                + "," + ;
                       "  dtalts     = GETDATE(),"                                           + ;
                       "  empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)           + "," + ;
                       "  empds      = " + EscaparSQL(THIS.this_cEmpDs)                + "," + ;
                       "  empgruests = " + EscaparSQL(THIS.this_cEmpGruEsts)           + "," + ;
                       "  locals     = " + EscaparSQL(THIS.this_cLocals)               + "," + ;
                       "  qtdos      = " + FormatarNumeroSQL(THIS.this_nQtdOs)         + "," + ;
                       "  qtds       = " + FormatarNumeroSQL(THIS.this_nQtds)          + "," + ;
                       "  usualts    = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))   + "," + ;
                       "  oridopnums = " + EscaparSQL(THIS.this_cOriDopNums)                  + ;
                       " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar distribui" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE do lote completo de SigPrDis (por Codigos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrDis WHERE Codigos = " + ;
                       EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir lote de distribui" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * METODOS DE NEGOCIO (operacional - distribuicao de produtos)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BuscarEstoques - Carrega SigCdCeg (tpcads=3) com flag nMarca para selecao
    * Cria cursor_4c_Estoques: nMarca, cidchaves, emps, grupos, contas
    *--------------------------------------------------------------------------
    PROCEDURE BuscarEstoques()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Estoques")
                USE IN cursor_4c_Estoques
            ENDIF

            loc_cSQL = "SELECT 0 AS nMarca, cidchaves AS cidchaves, emps AS emps, grupos AS grupos, contas AS contas" + ;
                       " FROM SigCdCeg" + ;
                       " WHERE tpcads = 3" + ;
                       " ORDER BY emps, grupos, contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Estoques")

            IF loc_nResultado < 0
                MsgErro("Erro ao carregar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_Estoques")
                    GO TOP IN cursor_4c_Estoques
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarEstoques:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarLote - Carrega todas as linhas SigPrDis de um lote
    * Cria cursor_4c_LotePrDis com todos os campos de SigPrDis
    *--------------------------------------------------------------------------
    PROCEDURE InicializarLote(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_LotePrDis")
                USE IN cursor_4c_LotePrDis
            ENDIF

            loc_cSQL = "SELECT * FROM SigPrDis" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LotePrDis")

            IF loc_nResultado < 0
                MsgErro("Erro ao inicializar lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_LotePrDis")
                    GO TOP IN cursor_4c_LotePrDis
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em InicializarLote:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursoresDistribuicao
    * Prepara cursor_4c_Disponivel e cursor_4c_Distribui a partir dos
    * estoques marcados em cursor_4c_Estoques.
    * par_cCodigos : codigo do lote (vazio se INSERIR)
    * par_cEscolha : "INSERIR" ou "ALTERAR"
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursoresDistribuicao(par_cCodigos, par_cEscolha)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nSel
        LOCAL loc_cEmp, loc_cGrupo, loc_cConta, loc_nQtdDistr
        loc_lSucesso = .F.

        TRY
            *-- Contar estoques marcados
            loc_nSel = 0
            IF USED("cursor_4c_Estoques")
                SELECT cursor_4c_Estoques
                COUNT FOR nMarca = 1 TO loc_nSel
            ENDIF

            IF loc_nSel = 0
                MsgAviso("Nenhum estoque foi selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Fechar cursores anteriores
            IF USED("cursor_4c_Disponivel")
                USE IN cursor_4c_Disponivel
            ENDIF
            IF USED("cursor_4c_Distribui")
                USE IN cursor_4c_Distribui
            ENDIF

            *-- Montar cursor_4c_Disponivel
            IF UPPER(ALLTRIM(par_cEscolha)) = "ALTERAR" AND !EMPTY(par_cCodigos)
                loc_cSQL = "SELECT a.cpros AS cpros, ISNULL(p.dpros,'') AS dpros," + ;
                           "  a.codcors AS codcors, a.codtams AS codtams," + ;
                           "  SUM(a.qtdos) AS QtdEstoque," + ;
                           "  SUM(a.qtds)  AS QtdSaida," + ;
                           "  (SUM(a.qtdos) - SUM(a.qtds)) AS QtdSaldo" + ;
                           " FROM SigPrDis a" + ;
                           " LEFT JOIN SigCdPro p ON p.cpros = a.cpros" + ;
                           " WHERE a.Codigos = " + EscaparSQL(par_cCodigos) + ;
                           " GROUP BY a.cpros, p.dpros, a.codcors, a.codtams" + ;
                           " ORDER BY a.cpros, a.codcors, a.codtams"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Disponivel")
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar produtos disponivel:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_Disponivel ;
                    (cpros C(14), dpros C(65), codcors C(4), codtams C(4), ;
                     QtdEstoque N(10,2), QtdSaida N(10,2), QtdSaldo N(10,2))
                SET NULL OFF
            ENDIF

            *-- Montar cursor_4c_Distribui a partir dos estoques marcados
            SET NULL ON
            CREATE CURSOR cursor_4c_Distribui ;
                (emps C(3), grupos C(10), contas C(10), ;
                 QtdSaldo N(10,2), QtdDistr N(10,2), locals C(10))
            SET NULL OFF

            SELECT cursor_4c_Estoques
            GO TOP
            DO WHILE !EOF("cursor_4c_Estoques")
                IF cursor_4c_Estoques.nMarca = 1
                    loc_cEmp   = ALLTRIM(cursor_4c_Estoques.emps)
                    loc_cGrupo = ALLTRIM(cursor_4c_Estoques.grupos)
                    loc_cConta = ALLTRIM(cursor_4c_Estoques.contas)
                    loc_nQtdDistr = 0

                    IF UPPER(ALLTRIM(par_cEscolha)) = "ALTERAR" AND ;
                       !EMPTY(par_cCodigos) AND ;
                       USED("cursor_4c_LotePrDis")
                        SELECT cursor_4c_LotePrDis
                        GO TOP
                        SCAN FOR ALLTRIM(empds) = loc_cEmp
                            loc_nQtdDistr = loc_nQtdDistr + qtds
                        ENDSCAN
                    ENDIF

                    INSERT INTO cursor_4c_Distribui ;
                        (emps, grupos, contas, QtdSaldo, QtdDistr, locals) ;
                        VALUES (loc_cEmp, loc_cGrupo, loc_cConta, 0, loc_nQtdDistr, "")
                ENDIF
                SELECT cursor_4c_Estoques
                SKIP
            ENDDO

            IF USED("cursor_4c_Disponivel")
                GO TOP IN cursor_4c_Disponivel
            ENDIF
            IF USED("cursor_4c_Distribui")
                GO TOP IN cursor_4c_Distribui
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em PrepararCursoresDistribuicao:" + CHR(13) + ;
                    loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularSaldo - Recalcula QtdSaldo em cursor_4c_Disponivel
    * Chamado apos edicao de QtdDistr em cursor_4c_Distribui
    * par_cCpros/par_cCodCors/par_cCodTams: produto selecionado
    *--------------------------------------------------------------------------
    PROCEDURE CalcularSaldo(par_cCpros, par_cCodCors, par_cCodTams)
        LOCAL loc_nQtdDistr, loc_nQtdEstoque, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Distribui") OR !USED("cursor_4c_Disponivel")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Distribui
            SUM QtdDistr TO loc_nQtdDistr

            SELECT cursor_4c_Disponivel
            LOCATE FOR ALLTRIM(cpros)   = ALLTRIM(par_cCpros)  AND ;
                        ALLTRIM(codcors) = ALLTRIM(par_cCodCors) AND ;
                        ALLTRIM(codtams) = ALLTRIM(par_cCodTams)

            IF FOUND()
                loc_nQtdEstoque = cursor_4c_Disponivel.QtdEstoque

                IF loc_nQtdEstoque - loc_nQtdDistr < 0
                    MsgAviso("Saldo insuficiente para movimentar.", "Aviso")
                    SELECT cursor_4c_Distribui
                    GO TOP
                    REPLACE ALL QtdDistr WITH 0
                    loc_nQtdDistr = 0
                    *-- Recalcular apos zerar
                    SELECT cursor_4c_Distribui
                    SUM QtdDistr TO loc_nQtdDistr
                ENDIF

                SELECT cursor_4c_Disponivel
                REPLACE QtdSaida WITH loc_nQtdDistr
                REPLACE QtdSaldo WITH (loc_nQtdEstoque - loc_nQtdDistr)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em CalcularSaldo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProduto - Carrega detalhes de produto para exibicao no painel lateral
    * Cria cursor_4c_Produto com campos do SigCdPro + joins
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProduto(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_cSQL = "SELECT a.cpros, a.cgrus, a.dpros, a.sgrus, a.cunis," + ;
                       "  a.reffs, a.valors, a.moedas, a.pvens, a.moevs," + ;
                       "  a.pesoms, a.linhas, a.situas, a.colecoes," + ;
                       "  a.pcuss, a.moecs, a.pvideals, a.ifors, a.codfinp," + ;
                       "  ISNULL(c.Rclis, '') AS rclis," + ;
                       "  ISNULL(g.dgrus, '') AS dgrus," + ;
                       "  ISNULL(l.descs,  '') AS desclin," + ;
                       "  ISNULL(f.descs,  '') AS descfeitio" + ;
                       " FROM SigCdPro a" + ;
                       " LEFT JOIN SigCdCli c ON c.iclis  = a.ifors" + ;
                       " LEFT JOIN SigCdGrp g ON g.cgrus  = a.cgrus" + ;
                       " LEFT JOIN SigCdLin l ON l.linhas = a.linhas" + ;
                       " LEFT JOIN SigPrFti f ON f.cods   = a.cftios" + ;
                       " WHERE a.cpros = " + EscaparSQL(par_cCpros)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Produto") > 0
                GO TOP IN cursor_4c_Produto
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarProduto:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarDistribuicao
    * Grava o lote de distribuicao em SigPrDis a partir de cursor_4c_Distribui
    * e cursor_4c_Disponivel. Usa transacao explicita para garantir atomicidade.
    * par_cCodigos : codigo do lote (Codigos)
    * par_cEscolha : "INSERIR" ou "ALTERAR"
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarDistribuicao(par_cCodigos, par_cEscolha)
        LOCAL loc_lSucesso, loc_lTransacaoAberta
        LOCAL loc_cSQL, loc_nResultado
        LOCAL loc_cCidChaves, loc_cCpros, loc_cCodCors, loc_cCodTams
        LOCAL loc_nQtdDistr, loc_cEmps, loc_cGrupos, loc_cContas
        LOCAL loc_nTotDis, loc_nQtdNeg

        loc_lSucesso         = .F.
        loc_lTransacaoAberta = .F.

        *-- Validar cursor_4c_Distribui tem quantidades
        IF !USED("cursor_4c_Distribui")
            MsgAviso("Cursor de distribui" + CHR(231) + CHR(227) + CHR(227) + ;
                     "o n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Distribui
        SUM QtdDistr TO loc_nTotDis
        IF loc_nTotDis = 0
            MsgAviso("Nenhum produto foi informado para distribuir.", "Aviso")
            RETURN .F.
        ENDIF

        *-- Validar sem saldos negativos em cursor_4c_Disponivel
        IF USED("cursor_4c_Disponivel")
            SELECT cursor_4c_Disponivel
            GO TOP
            COUNT FOR QtdSaldo < 0 TO loc_nQtdNeg
            IF loc_nQtdNeg > 0
                MsgAviso("Existem produtos distribu" + CHR(237) + "dos que est" + ;
                         CHR(227) + "o ficando com saldo negativo." + CHR(13) + ;
                         "Favor checar antes de processar.", "Aviso")
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacaoAberta = .T.

            *-- Se ALTERAR: remover linhas existentes do lote
            IF UPPER(ALLTRIM(par_cEscolha)) = "ALTERAR" AND !EMPTY(par_cCodigos)
                loc_cSQL = "DELETE FROM SigPrDis WHERE Codigos = " + ;
                           EscaparSQL(par_cCodigos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    MsgErro("Erro ao remover lote anterior:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Para cada produto disponivel x empresa distribui: INSERT em SigPrDis
            IF USED("cursor_4c_Disponivel")
                SELECT cursor_4c_Disponivel
                GO TOP
                DO WHILE !EOF("cursor_4c_Disponivel")
                    loc_cCpros   = ALLTRIM(cursor_4c_Disponivel.cpros)
                    loc_cCodCors = ALLTRIM(cursor_4c_Disponivel.codcors)
                    loc_cCodTams = ALLTRIM(cursor_4c_Disponivel.codtams)

                    SELECT cursor_4c_Distribui
                    GO TOP
                    DO WHILE !EOF("cursor_4c_Distribui")
                        loc_nQtdDistr = cursor_4c_Distribui.QtdDistr
                        loc_cEmps     = ALLTRIM(cursor_4c_Distribui.emps)
                        loc_cGrupos   = ALLTRIM(cursor_4c_Distribui.grupos)
                        loc_cContas   = ALLTRIM(cursor_4c_Distribui.contas)

                        IF loc_nQtdDistr > 0
                            loc_cCidChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigPrDis" + ;
                                       " (cidchaves, codigos, codcors, codtams, cpros," + ;
                                       "  datas, dtalts, empdopnums, empds, empgruests," + ;
                                       "  locals, qtdos, qtds, usualts, usuars, oridopnums)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cCidChaves)                               + "," + ;
                                       EscaparSQL(par_cCodigos)                                 + "," + ;
                                       EscaparSQL(loc_cCodCors)                                 + "," + ;
                                       EscaparSQL(loc_cCodTams)                                 + "," + ;
                                       EscaparSQL(loc_cCpros)                                   + "," + ;
                                       "GETDATE(),"                                                    + ;
                                       "GETDATE(),"                                                    + ;
                                       EscaparSQL(loc_cEmps + loc_cGrupos + loc_cContas)        + "," + ;
                                       EscaparSQL(loc_cEmps)                                    + "," + ;
                                       EscaparSQL(loc_cEmps + loc_cGrupos + loc_cContas)        + "," + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Distribui.locals))          + "," + ;
                                       FormatarNumeroSQL(loc_nQtdDistr)                         + "," + ;
                                       FormatarNumeroSQL(loc_nQtdDistr)                         + "," + ;
                                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))                + "," + ;
                                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))                + "," + ;
                                       "'')"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                MsgErro("Erro ao inserir linha de distribui" + ;
                                        CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_Distribui
                        SKIP
                    ENDDO

                    SELECT cursor_4c_Disponivel
                    SKIP
                ENDDO
            ENDIF

            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
            loc_lTransacaoAberta = .F.

            THIS.this_cCodigos = par_cCodigos
            THIS.RegistrarAuditoria(IIF(UPPER(ALLTRIM(par_cEscolha)) = "INSERIR", "INSERT", "UPDATE"))
            loc_lSucesso = .T.

        CATCH TO loException
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            MsgErro("Erro em ProcessarDistribuicao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Carrega operacoes de SigMvCab geradas pela distribuicao
    * Cria cursor_4c_CabOpera: cidchaves, emps, dopes, numes, grupos, datas
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_CabOpera")
                USE IN cursor_4c_CabOpera
            ENDIF

            loc_cSQL = "SELECT m.cidchaves AS cidchaves, m.emps AS emps, m.dopes AS dopes, m.numes AS numes," + ;
                       "  m.empds AS empds, m.grupos AS grupos, m.contaos AS contaos," + ;
                       "  m.grupods AS grupods, m.contads AS contads," + ;
                       "  m.datas AS datas, m.empdopnums AS empdopnums" + ;
                       " FROM SigMvCab m" + ;
                       " WHERE m.empdopnums IN (" + ;
                       "   SELECT DISTINCT empdopnums FROM sigprdis" + ;
                       "   WHERE Codigos = " + EscaparSQL(par_cCodigos) + ")" + ;
                       " ORDER BY m.emps, m.dopes, m.numes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabOpera")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_CabOpera")
                    GO TOP IN cursor_4c_CabOpera
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarOperacoes:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarItensOperacao - Carrega itens distribuidos de uma operacao/lote
    * Cria cursor_4c_ItensOper: cidchaves, cpros, dpros, codcors, codtams, qtds, locals
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItensOperacao(par_cEmpdopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_ItensOper")
                USE IN cursor_4c_ItensOper
            ENDIF

            loc_cSQL = "SELECT d.cidchaves, d.cpros, ISNULL(p.dpros,'') AS dpros," + ;
                       "  d.codcors, d.codtams, d.qtds, d.locals" + ;
                       " FROM sigprdis d" + ;
                       " LEFT JOIN SigCdPro p ON p.cpros = d.cpros" + ;
                       " WHERE d.empdopnums = " + EscaparSQL(par_cEmpdopNums) + ;
                       " ORDER BY d.cpros, d.codcors, d.codtams"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensOper")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar itens da opera" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ItensOper")
                    GO TOP IN cursor_4c_ItensOper
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarItensOperacao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

