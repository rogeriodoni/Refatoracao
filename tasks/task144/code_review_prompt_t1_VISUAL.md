# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [LAYOUT-POSITION] Controle 'Container1' (parent: SIGPDMP9): Top original=97 vs migrado 'cnt_4c_Container1' Top=1 (diff=96px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Origem' (parent: SIGPDMP9): Top original=170 vs migrado 'cnt_4c_Origem' Top=1 (diff=169px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Destino' (parent: SIGPDMP9): Top original=244 vs migrado 'cnt_4c_Destino' Top=1 (diff=243px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp3.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2234 linhas total):

*-- Linhas 64 a 101:
64:     ADD OBJECT img_4c_FigJpg AS Image WITH ;
65:         Stretch = 1, Height = 213, Left = 510, Top = 99, ;
66:         Visible = .F., Width = 284
67: 
68:     *-- Container info movimentacao (Container1 no legado)
69:     ADD OBJECT cnt_4c_Container1 AS Container WITH ;
70:         Top = 97, Left = 13, Width = 491, Height = 70, ;
71:         BackStyle = 1, SpecialEffect = 0, ;
72:         BackColor = RGB(255,255,255), BorderColor = RGB(136,189,188)
73: 
74:     *-- Container cabecalho da operacao - empresa/operacao/codigo (Opera<ao no legado)
75:     ADD OBJECT cnt_4c_Operacao AS Container WITH ;
76:         Top = 122, Left = 18, Width = 391, Height = 40, ;
77:         BackStyle = 0, BorderWidth = 0, BackColor = RGB(255,255,255)
78: 
79:     *-- Container conta de origem (Origem no legado)
80:     ADD OBJECT cnt_4c_Origem AS Container WITH ;
81:         Top = 170, Left = 13, Width = 491, Height = 70, ;
82:         BackStyle = 1, SpecialEffect = 0, ;
83:         BackColor = RGB(255,255,255), BorderColor = RGB(136,189,188)
84: 
85:     *-- Container conta de destino (Destino no legado)
86:     ADD OBJECT cnt_4c_Destino AS Container WITH ;
87:         Top = 244, Left = 13, Width = 491, Height = 70, ;
88:         SpecialEffect = 0, ;
89:         BackColor = RGB(255,255,255), BorderColor = RGB(136,189,188)
90: 
91:     *==========================================================================
92:     * Init - Compartilha datasession com o form pai e inicializa o form
93:     * Parametro: par_oFormPai - referencia ao form que chamou este form
94:     * CRITICO: DataSessionId deve ser compartilhado ANTES de DODEFAULT()
95:     * para que InicializarForm() acesse xOpi, xPesa, TmpNens, crSigCdOpd
96:     *==========================================================================
97:     PROCEDURE Init(par_oFormPai)
98:         IF VARTYPE(par_oFormPai) = "O"
99:             THIS.this_oFormPai = par_oFormPai
100:             THIS.this_cEscolha = ALLTRIM(par_oFormPai.pcEscolha)
101:             THIS.this_cDopp    = ALLTRIM(par_oFormPai._Dopp)

*-- Linhas 128 a 136:
128:             IF TYPE("gc_4c_CaminhoIcones") = "C"
129:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
130:             ENDIF
131:             THIS.Caption = "Emiss" + CHR(227) + "o de Etiquetas"
132: 
133:             *-- Configura layout visual base
134:             THIS.ConfigurarPageFrame()
135:             THIS.ConfigurarCabecalho()
136:             THIS.ConfigurarContainerMovimentacao()

*-- Linhas 171 a 251:
171:         IF TYPE("gc_4c_CaminhoIcones") = "C"
172:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
173:         ENDIF
174:         THIS.Caption = "Emiss" + CHR(227) + "o de Etiquetas"
175:     ENDPROC
176: 
177:     *==========================================================================
178:     * ConfigurarCabecalho - Adiciona labels de titulo no cnt_4c_Sombra
179:     * Replica lblSombra (sombra preta) e lblTitulo (texto branco) do legado
180:     *==========================================================================
181:     PROTECTED PROCEDURE ConfigurarCabecalho()
182:         LOCAL loc_cCaption
183:         loc_cCaption = "Emiss" + CHR(227) + "o de Etiquetas"
184: 
185:         WITH THIS.cnt_4c_Sombra
186:             .AddObject("lbl_4c_LblSombra", "Label")
187:             WITH .lbl_4c_LblSombra
188:                 .FontBold      = .T.
189:                 .FontName      = "Tahoma"
190:                 .FontSize      = 18
191:                 .FontUnderline = .F.
192:                 .WordWrap      = .T.
193:                 .Alignment     = 0
194:                 .BackStyle     = 0
195:                 .Caption       = loc_cCaption
196:                 .Height        = 40
197:                 .Left          = 10
198:                 .Top           = 18
199:                 .Width         = 769
200:                 .ForeColor     = RGB(0, 0, 0)
201:                 .Visible       = .T.
202:             ENDWITH
203: 
204:             .AddObject("lbl_4c_LblTitulo", "Label")
205:             WITH .lbl_4c_LblTitulo
206:                 .FontBold   = .T.
207:                 .FontName   = "Tahoma"
208:                 .FontSize   = 18
209:                 .WordWrap   = .T.
210:                 .Alignment  = 0
211:                 .BackStyle  = 0
212:                 .Caption    = loc_cCaption
213:                 .Height     = 46
214:                 .Left       = 10
215:                 .Top        = 17
216:                 .Width      = 769
217:                 .ForeColor  = RGB(255, 255, 255)
218:                 .Visible    = .T.
219:             ENDWITH
220:         ENDWITH
221:     ENDPROC
222: 
223:     *==========================================================================
224:     * ConfigurarContainerMovimentacao - Configura cnt_4c_Container1
225:     * Label "Movimenta=ao" + linha decorativa (Say4 + Line1 do legado)
226:     *==========================================================================
227:     PROTECTED PROCEDURE ConfigurarContainerMovimentacao()
228:         WITH THIS.cnt_4c_Container1
229:             .AddObject("lbl_4c_LblMovimentacao", "Label")
230:             WITH .lbl_4c_LblMovimentacao
231:                 .FontBold  = .T.
232:                 .FontSize  = 8
233:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
234:                 .Left      = 8
235:                 .Top       = 1
236:                 .ForeColor = RGB(90, 90, 90)
237:                 .BackStyle = 0
238:                 .Visible   = .T.
239:             ENDWITH
240: 
241:             .AddObject("lin_4c_Line1", "Line")
242:             WITH .lin_4c_Line1
243:                 .BorderWidth = 2
244:                 .Height      = 0
245:                 .Left        = 8
246:                 .Top         = 16
247:                 .Width       = 316
248:                 .BorderColor = RGB(90, 90, 90)
249:                 .Visible     = .T.
250:             ENDWITH
251:         ENDWITH

*-- Linhas 260 a 269:
260:         WITH THIS.cnt_4c_Operacao
261:             .AddObject("txt_4c_Empresa", "TextBox")
262:             WITH .txt_4c_Empresa
263:                 .Left              = 3
264:                 .Top               = 2
265:                 .Width             = 36
266:                 .Height            = 23
267:                 .ReadOnly          = .T.
268:                 .FontName          = "Tahoma"
269:                 .FontSize          = 8

*-- Linhas 280 a 289:
280: 
281:             .AddObject("txt_4c_Operacao", "TextBox")
282:             WITH .txt_4c_Operacao
283:                 .Left              = 41
284:                 .Top               = 2
285:                 .Width             = 156
286:                 .Height            = 23
287:                 .ReadOnly          = .T.
288:                 .FontName          = "Tahoma"
289:                 .FontSize          = 8

*-- Linhas 301 a 310:
301: 
302:             .AddObject("txt_4c_Codigo", "TextBox")
303:             WITH .txt_4c_Codigo
304:                 .Left              = 199
305:                 .Top               = 2
306:                 .Width             = 81
307:                 .Height            = 23
308:                 .ReadOnly          = .T.
309:                 .Format            = "L"
310:                 .InputMask         = "9999999999"

*-- Linhas 323 a 555:
323:             ENDIF
324:         ENDWITH
325:     ENDPROC
326: 
327:     *==========================================================================
328:     * ConfigurarContainerOrigem - Configura cnt_4c_Origem
329:     * Labels "Origem"/"Grupo"/"Conta"/"Nome" + TextBoxes ReadOnly de tmpnens
330:     * Replica Origem.Say1-4, Origem.Get_grupo, Get_conta, Get_dconta do legado
331:     *==========================================================================
332:     PROTECTED PROCEDURE ConfigurarContainerOrigem()
333:         WITH THIS.cnt_4c_Origem
334:             .AddObject("lbl_4c_LblOrigem", "Label")
335:             WITH .lbl_4c_LblOrigem
336:                 .FontBold  = .T.
337:                 .FontSize  = 8
338:                 .Caption   = "Origem"
339:                 .Left      = 8
340:                 .Top       = 1
341:                 .ForeColor = RGB(90, 90, 90)
342:                 .BackStyle = 0
343:                 .Visible   = .T.
344:             ENDWITH
345: 
346:             .AddObject("lin_4c_Line1", "Line")
347:             WITH .lin_4c_Line1
348:                 .BorderWidth = 2
349:                 .Height      = 0
350:                 .Left        = 8
351:                 .Top         = 16
352:                 .Width       = 316
353:                 .BorderColor = RGB(90, 90, 90)
354:                 .Visible     = .T.
355:             ENDWITH
356: 
357:             .AddObject("lbl_4c_LblGrupo", "Label")
358:             WITH .lbl_4c_LblGrupo
359:                 .FontSize  = 8
360:                 .Caption   = "Grupo"
361:                 .Left      = 8
362:                 .Top       = 21
363:                 .ForeColor = RGB(90, 90, 90)
364:                 .BackStyle = 0
365:                 .Visible   = .T.
366:             ENDWITH
367: 
368:             .AddObject("lbl_4c_LblConta", "Label")
369:             WITH .lbl_4c_LblConta
370:                 .FontSize  = 8
371:                 .Caption   = "Conta"
372:                 .Left      = 93
373:                 .Top       = 21
374:                 .ForeColor = RGB(90, 90, 90)
375:                 .BackStyle = 0
376:                 .Visible   = .T.
377:             ENDWITH
378: 
379:             .AddObject("lbl_4c_LblNome", "Label")
380:             WITH .lbl_4c_LblNome
381:                 .FontSize  = 8
382:                 .Caption   = "Nome"
383:                 .Left      = 176
384:                 .Top       = 20
385:                 .ForeColor = RGB(90, 90, 90)
386:                 .BackStyle = 0
387:                 .Visible   = .T.
388:             ENDWITH
389: 
390:             .AddObject("txt_4c_Grupo", "TextBox")
391:             WITH .txt_4c_Grupo
392:                 .Left          = 8
393:                 .Top           = 33
394:                 .Width         = 80
395:                 .ReadOnly      = .T.
396:                 .SpecialEffect = 1
397:                 .FontName      = "Tahoma"
398:                 .FontSize      = 8
399:                 .ForeColor     = RGB(0, 0, 0)
400:                 .BorderColor   = RGB(100, 100, 100)
401:                 .Themes        = .F.
402:                 .Visible       = .T.
403:             ENDWITH
404:             IF USED("tmpnens")
405:                 THIS.cnt_4c_Origem.txt_4c_Grupo.ControlSource = "tmpnens.grupoos"
406:             ENDIF
407: 
408:             .AddObject("txt_4c_Conta", "TextBox")
409:             WITH .txt_4c_Conta
410:                 .Left          = 93
411:                 .Top           = 33
412:                 .Width         = 80
413:                 .ReadOnly      = .T.
414:                 .SpecialEffect = 1
415:                 .FontName      = "Tahoma"
416:                 .FontSize      = 8
417:                 .ForeColor     = RGB(0, 0, 0)
418:                 .BorderColor   = RGB(100, 100, 100)
419:                 .Themes        = .F.
420:                 .Visible       = .T.
421:             ENDWITH
422:             IF USED("tmpnens")
423:                 THIS.cnt_4c_Origem.txt_4c_Conta.ControlSource = "tmpnens.contaos"
424:             ENDIF
425: 
426:             .AddObject("txt_4c_Dconta", "TextBox")
427:             WITH .txt_4c_Dconta
428:                 .Left          = 176
429:                 .Top           = 32
430:                 .Width         = 302
431:                 .Height        = 23
432:                 .ReadOnly      = .T.
433:                 .SpecialEffect = 1
434:                 .FontName      = "Tahoma"
435:                 .FontSize      = 8
436:                 .ForeColor     = RGB(0, 0, 0)
437:                 .BorderColor   = RGB(100, 100, 100)
438:                 .Themes        = .F.
439:                 .Visible       = .T.
440:             ENDWITH
441:         ENDWITH
442:     ENDPROC
443: 
444:     *==========================================================================
445:     * ConfigurarContainerDestino - Configura cnt_4c_Destino
446:     * Labels "Destino"/"Grupo"/"Conta"/"Nome" + TextBoxes ReadOnly de tmpnens
447:     * Replica Destino.Say1-4, Destino.Get_grupo, Get_conta, Get_dconta do legado
448:     *==========================================================================
449:     PROTECTED PROCEDURE ConfigurarContainerDestino()
450:         WITH THIS.cnt_4c_Destino
451:             .AddObject("lbl_4c_LblDestino", "Label")
452:             WITH .lbl_4c_LblDestino
453:                 .FontBold  = .T.
454:                 .FontSize  = 8
455:                 .Caption   = "Destino"
456:                 .Left      = 4
457:                 .Top       = 1
458:                 .ForeColor = RGB(90, 90, 90)
459:                 .BackStyle = 0
460:                 .Visible   = .T.
461:             ENDWITH
462: 
463:             .AddObject("lin_4c_Line1", "Line")
464:             WITH .lin_4c_Line1
465:                 .BorderWidth = 2
466:                 .Height      = 0
467:                 .Left        = 4
468:                 .Top         = 16
469:                 .Width       = 316
470:                 .BorderColor = RGB(90, 90, 90)
471:                 .Visible     = .T.
472:             ENDWITH
473: 
474:             .AddObject("lbl_4c_LblGrupo", "Label")
475:             WITH .lbl_4c_LblGrupo
476:                 .FontSize  = 8
477:                 .Caption   = "Grupo"
478:                 .Left      = 4
479:                 .Top       = 20
480:                 .ForeColor = RGB(90, 90, 90)
481:                 .BackStyle = 0
482:                 .Visible   = .T.
483:             ENDWITH
484: 
485:             .AddObject("lbl_4c_LblConta", "Label")
486:             WITH .lbl_4c_LblConta
487:                 .FontSize  = 8
488:                 .Caption   = "Conta"
489:                 .Left      = 93
490:                 .Top       = 20
491:                 .ForeColor = RGB(90, 90, 90)
492:                 .BackStyle = 0
493:                 .Visible   = .T.
494:             ENDWITH
495: 
496:             .AddObject("lbl_4c_LblNome", "Label")
497:             WITH .lbl_4c_LblNome
498:                 .FontSize  = 8
499:                 .Caption   = "Nome"
500:                 .Left      = 176
501:                 .Top       = 20
502:                 .ForeColor = RGB(90, 90, 90)
503:                 .BackStyle = 0
504:                 .Visible   = .T.
505:             ENDWITH
506: 
507:             .AddObject("txt_4c_Grupo", "TextBox")
508:             WITH .txt_4c_Grupo
509:                 .Left          = 4
510:                 .Top           = 32
511:                 .Width         = 80
512:                 .ReadOnly      = .T.
513:                 .SpecialEffect = 1
514:                 .FontName      = "Tahoma"
515:                 .FontSize      = 8
516:                 .ForeColor     = RGB(0, 0, 0)
517:                 .BorderColor   = RGB(100, 100, 100)
518:                 .Themes        = .F.
519:                 .Visible       = .T.
520:             ENDWITH
521:             IF USED("tmpnens")
522:                 THIS.cnt_4c_Destino.txt_4c_Grupo.ControlSource = "tmpnens.grupods"
523:             ENDIF
524: 
525:             .AddObject("txt_4c_Conta", "TextBox")
526:             WITH .txt_4c_Conta
527:                 .Left          = 93
528:                 .Top           = 32
529:                 .Width         = 80
530:                 .ReadOnly      = .T.
531:                 .SpecialEffect = 1
532:                 .FontName      = "Tahoma"
533:                 .FontSize      = 8
534:                 .ForeColor     = RGB(0, 0, 0)
535:                 .BorderColor   = RGB(100, 100, 100)
536:                 .Themes        = .F.
537:                 .Visible       = .T.
538:             ENDWITH
539:             IF USED("tmpnens")
540:                 THIS.cnt_4c_Destino.txt_4c_Conta.ControlSource = "tmpnens.contads"
541:             ENDIF
542: 
543:             .AddObject("txt_4c_Dconta", "TextBox")
544:             WITH .txt_4c_Dconta
545:                 .Left          = 176
546:                 .Top           = 32
547:                 .Width         = 302
548:                 .Height        = 23
549:                 .ReadOnly      = .T.
550:                 .SpecialEffect = 1
551:                 .FontName      = "Tahoma"
552:                 .FontSize      = 8
553:                 .ForeColor     = RGB(0, 0, 0)
554:                 .BorderColor   = RGB(100, 100, 100)
555:                 .Themes        = .F.

*-- Linhas 564 a 620:
564:     * Usa BO.ObterDescricaoConta para buscar RClis por ICli
565:     *==========================================================================
566:     PROTECTED PROCEDURE PopularDescricoesConta()
567:         LOCAL loc_cICli, loc_cDescr
568: 
569:         THIS.cnt_4c_Origem.txt_4c_Dconta.Value  = ""
570:         THIS.cnt_4c_Destino.txt_4c_Dconta.Value = ""
571: 
572:         IF NOT USED("tmpnens") OR EOF("tmpnens")
573:             RETURN
574:         ENDIF
575: 
576:         SELECT tmpnens
577: 
578:         *-- Origem: ICli = tmpnens.contaos
579:         loc_cICli = ALLTRIM(NVL(tmpnens.contaos, ""))
580:         IF NOT EMPTY(loc_cICli)
581:             loc_cDescr = THIS.this_oBusinessObject.ObterDescricaoConta(loc_cICli)
582:             IF NOT EMPTY(loc_cDescr)
583:                 THIS.cnt_4c_Origem.txt_4c_Dconta.Value = loc_cDescr
584:             ENDIF
585:         ENDIF
586: 
587:         *-- Destino: ICli = tmpnens.contads
588:         loc_cICli = ALLTRIM(NVL(tmpnens.contads, ""))
589:         IF NOT EMPTY(loc_cICli)
590:             loc_cDescr = THIS.this_oBusinessObject.ObterDescricaoConta(loc_cICli)
591:             IF NOT EMPTY(loc_cDescr)
592:                 THIS.cnt_4c_Destino.txt_4c_Dconta.Value = loc_cDescr
593:             ENDIF
594:         ENDIF
595:     ENDPROC
596: 
597:     *==========================================================================
598:     * AjustarVisibilidadeContainers - Mostra/oculta Origem e Destino conforme
599:     * crSigCdOpd.Origems e crSigCdOpd.Destinos
600:     * Replica: .Origem.Visible=(crSigCdOpd.Origems=1) do Init do legado
601:     *==========================================================================
602:     PROCEDURE AjustarVisibilidadeContainers()
603:         IF USED("crSigCdOpd") AND NOT EOF("crSigCdOpd")
604:             THIS.cnt_4c_Origem.Visible  = (crSigCdOpd.Origems = 1)
605:             THIS.cnt_4c_Destino.Visible = (crSigCdOpd.Destinos = 1)
606:         ENDIF
607:     ENDPROC
608: 
609:     *==========================================================================
610:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
611:     * EXCECAO: img_4c_FigJpg e shp_4c_Shape4 permanecem ocultos (controlados
612:     * pelo AfterRowColChange do grid conforme crSigCdOpd.Imagems)
613:     *==========================================================================
614:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
615:         LOCAL loc_i, loc_oControl
616: 
617:         FOR loc_i = 1 TO par_oContainer.ControlCount
618:             loc_oControl = par_oContainer.Controls(loc_i)
619: 
620:             IF VARTYPE(loc_oControl) = "O"

*-- Linhas 658 a 667:
658:             *-- Grid principal (Grade no legado)
659:             THIS.AddObject("grd_4c_Dados", "Grid")
660:             WITH THIS.grd_4c_Dados
661:                 .Top                = 319
662:                 .Left               = 12
663:                 .Width              = 979
664:                 .Height             = 162
665:                 .ColumnCount        = 7
666:                 .FontName           = "Verdana"
667:                 .FontSize           = 8

*-- Linhas 700 a 755:
700:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
701: 
702:             *-- Label "Descricao" (Say2 no legado, Top=485, Left=12)
703:             THIS.AddObject("lbl_4c_LblDescricao", "Label")
704:             WITH THIS.lbl_4c_LblDescricao
705:                 .Top       = 485
706:                 .Left      = 12
707:                 .AutoSize  = .T.
708:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o "
709:                 .FontName  = "Tahoma"
710:                 .FontSize  = 8
711:                 .ForeColor = RGB(90, 90, 90)
712:                 .BackStyle = 0
713:                 .Visible   = .T.
714:             ENDWITH
715: 
716:             *-- TextBox descricao do produto (Get_descr no legado, Top=501, Left=12, W=363)
717:             THIS.AddObject("txt_4c_Descr", "TextBox")
718:             WITH THIS.txt_4c_Descr
719:                 .Top       = 501
720:                 .Left      = 12
721:                 .Width     = 363
722:                 .Height    = 23
723:                 .ReadOnly  = .T.
724:                 .FontName  = "Tahoma"
725:                 .FontSize  = 8
726:                 .ForeColor = RGB(0, 0, 0)
727:                 .BackColor = RGB(255, 255, 255)
728:                 .Themes    = .F.
729:                 .Visible   = .T.
730:             ENDWITH
731: 
732:             *-- Label "Observacao" (Say3 no legado, Top=484, Left=379)
733:             THIS.AddObject("lbl_4c_LblObs", "Label")
734:             WITH THIS.lbl_4c_LblObs
735:                 .Top       = 484
736:                 .Left      = 379
737:                 .AutoSize  = .T.
738:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o "
739:                 .FontName  = "Tahoma"
740:                 .FontSize  = 8
741:                 .ForeColor = RGB(90, 90, 90)
742:                 .BackStyle = 0
743:                 .Visible   = .T.
744:             ENDWITH
745: 
746:             *-- EditBox de observacoes (Mm_obs no legado, Top=500, Left=379, W=612, H=81)
747:             THIS.AddObject("obj_4c_MmObs", "EditBox")
748:             WITH THIS.obj_4c_MmObs
749:                 .Top       = 500
750:                 .Left      = 379
751:                 .Width     = 612
752:                 .Height    = 81
753:                 .ReadOnly  = .T.
754:                 .FontName  = "Tahoma"
755:                 .FontSize  = 8

*-- Linhas 763 a 776:
763:             ENDIF
764: 
765:             *-- Label aviso peso medio (Say1 no legado, Top=532, Left=12)
766:             THIS.AddObject("lbl_4c_LblAtencao", "Label")
767:             WITH THIS.lbl_4c_LblAtencao
768:                 .Top       = 532
769:                 .Left      = 12
770:                 .AutoSize  = .T.
771:                 .Caption   = "Aten" + CHR(231) + CHR(227) + "o: a finaliza" + CHR(231) + CHR(227) + "o considera o Peso M" + CHR(233) + "dio Real"
772:                 .FontName  = "Tahoma"
773:                 .FontSize  = 8
774:                 .ForeColor = RGB(90, 90, 90)
775:                 .BackStyle = 0
776:                 .Visible   = .T.

*-- Linhas 784 a 809:
784:     *==========================================================================
785:     * ConfigurarGrade - Configura as 7 colunas do grd_4c_Dados
786:     * Column1: Ordem Fabricacao (xOpi.nops)  - ReadOnly
787:     * Column2: Pedido (xOpi.oper)            - ReadOnly + Tab->cmd_4c_Ok
788:     * Column3: Quantidade (xOpi.qtds)        - Editavel, KeyPress processa xPesa
789:     * Column4: Produto (xOpi.cpros)          - ReadOnly
790:     * Column5: Ind (xOpi.indiv)             - CheckBox condicional
791:     * Column6: Conta (xOpi.conta)            - ReadOnly
792:     * Column7: PM (xOpi.divs)              - CheckBox condicional
793:     *==========================================================================
794:     PROTECTED PROCEDURE ConfigurarGrade()
795:         LOCAL loc_oGrid, loc_oErro
796:         TRY
797:             loc_oGrid = THIS.grd_4c_Dados
798: 
799:             *-- Column1: Ordem Fabricacao (xOpi.nops) - largura 133 conforme original
800:             WITH loc_oGrid.Column1
801:                 .Width             = 133
802:                 .ReadOnly          = .T.
803:                 .FontName          = "Arial"
804:                 .Header1.Caption   = "Ordem Fabrica" + CHR(231) + CHR(227) + "o"
805:                 .Header1.Alignment = 2
806:                 .ControlSource     = "xOpi.nops"
807:             ENDWITH
808:             WITH loc_oGrid.Column1.Text1
809:                 .FontName    = "Arial"

*-- Linhas 817 a 825:
817:             WITH loc_oGrid.Column2
818:                 .Width             = 310
819:                 .ReadOnly          = .T.
820:                 .Header1.Caption   = "Pedido"
821:                 .Header1.Alignment = 2
822:                 .ControlSource     = "xOpi.oper"
823:             ENDWITH
824:             WITH loc_oGrid.Column2.Text1
825:                 .Alignment   = 0

*-- Linhas 834 a 842:
834:             WITH loc_oGrid.Column3
835:                 .Width             = 150
836:                 .ReadOnly          = .F.
837:                 .Header1.Caption   = "Quantidade"
838:                 .Header1.Alignment = 2
839:                 .ControlSource     = "xOpi.qtds"
840:             ENDWITH
841:             WITH loc_oGrid.Column3.Text1
842:                 .BorderStyle = 0

*-- Linhas 850 a 883:
850:             WITH loc_oGrid.Column4
851:                 .Width             = 150
852:                 .ReadOnly          = .T.
853:                 .Header1.Caption   = "Produto"
854:                 .Header1.Alignment = 2
855:                 .ControlSource     = "xOpi.cpros"
856:             ENDWITH
857:             WITH loc_oGrid.Column4.Text1
858:                 .BorderStyle = 0
859:                 .Margin      = 0
860:                 .ForeColor   = RGB(0, 0, 0)
861:                 .BackColor   = RGB(255, 255, 255)
862:             ENDWITH
863: 
864:             *-- Column5: Ind (xOpi.indiv) - largura 25 conforme original; CheckBox
865:             *-- CRITICO: AddObject Check1 ANTES de CurrentControl e ControlSource
866:             loc_oGrid.Column5.AddObject("Check1", "CheckBox")
867:             WITH loc_oGrid.Column5.Check1
868:                 .Caption   = ""
869:                 .Value     = 0
870:                 .Width     = 40
871:                 .Height    = 16
872:                 .Alignment = 2
873:                 .Centered  = .T.
874:             ENDWITH
875:             WITH loc_oGrid.Column5
876:                 .Width             = 25
877:                 .CurrentControl    = "Check1"
878:                 .Header1.Caption   = "Ind"
879:                 .Header1.Alignment = 2
880:                 .ControlSource     = "xOpi.indiv"
881:             ENDWITH
882:             IF THIS.this_cEscolha <> "INSERIR"
883:                 loc_oGrid.Column5.ReadOnly = .T.

*-- Linhas 889 a 923:
889:             WITH loc_oGrid.Column6
890:                 .Width             = 146
891:                 .ReadOnly          = .T.
892:                 .Header1.Caption   = "Conta"
893:                 .Header1.Alignment = 2
894:                 .ControlSource     = "xOpi.conta"
895:             ENDWITH
896:             WITH loc_oGrid.Column6.Text1
897:                 .BorderStyle = 0
898:                 .Margin      = 0
899:                 .ReadOnly    = .T.
900:                 .ForeColor   = RGB(0, 0, 0)
901:                 .BackColor   = RGB(255, 255, 255)
902:             ENDWITH
903: 
904:             *-- Column7: PM (xOpi.divs) - largura 25 conforme original; CheckBox
905:             *-- CRITICO: mesma ordem que Column5 (AddObject antes de CurrentControl/ControlSource)
906:             loc_oGrid.Column7.AddObject("Check1", "CheckBox")
907:             WITH loc_oGrid.Column7.Check1
908:                 .Caption   = ""
909:                 .Value     = 0
910:                 .Width     = 40
911:                 .Height    = 16
912:                 .Alignment = 2
913:                 .Centered  = .T.
914:             ENDWITH
915:             WITH loc_oGrid.Column7
916:                 .Width             = 25
917:                 .CurrentControl    = "Check1"
918:                 .Header1.Caption   = "PM"
919:                 .Header1.Alignment = 2
920:                 .ControlSource     = "xOpi.divs"
921:             ENDWITH
922:             IF THIS.this_cEscolha <> "INSERIR"
923:                 loc_oGrid.Column7.ReadOnly = .T.

*-- Linhas 942 a 956:
942:             loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")
943: 
944:             *-- Botao Encerrar - padrao canonico sistema novo (sem equivalente direto no legado)
945:             THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
946:             WITH THIS.cmd_4c_Encerrar
947:                 .Top             = 3
948:                 .Left            = 775
949:                 .Width           = 75
950:                 .Height          = 75
951:                 .Caption         = "Encerrar"
952:                 .FontName        = "Tahoma"
953:                 .FontSize        = 8
954:                 .FontBold        = .T.
955:                 .FontItalic      = .T.
956:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 964 a 983:
964:                 .Visible         = .T.
965:             ENDWITH
966:             IF NOT EMPTY(loc_cIcones)
967:                 THIS.cmd_4c_Encerrar.Picture = loc_cIcones + "cadastro_sair_60.jpg"
968:             ENDIF
969:             BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
970: 
971:             *-- Botao Pesagem (replica "Pesagem" do legado: Left=850, W=75, H=75)
972:             THIS.AddObject("cmd_4c_Pesagem", "CommandButton")
973:             WITH THIS.cmd_4c_Pesagem
974:                 .Top             = 3
975:                 .Left            = 850
976:                 .Width           = 75
977:                 .Height          = 75
978:                 .Caption         = "Pesagem"
979:                 .FontName        = "Tahoma"
980:                 .FontSize        = 8
981:                 .FontBold        = .T.
982:                 .FontItalic      = .T.
983:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 991 a 1010:
991:                 .Visible         = .T.
992:             ENDWITH
993:             IF NOT EMPTY(loc_cIcones)
994:                 THIS.cmd_4c_Pesagem.Picture = loc_cIcones + "geral_balanca_60.jpg"
995:             ENDIF
996:             BINDEVENT(THIS.cmd_4c_Pesagem, "Click", THIS, "BtnPesagemClick")
997: 
998:             *-- Botao OK (replica "ok" do legado: Left=925, W=75, H=75)
999:             THIS.AddObject("cmd_4c_Ok", "CommandButton")
1000:             WITH THIS.cmd_4c_Ok
1001:                 .Top             = 3
1002:                 .Left            = 925
1003:                 .Width           = 75
1004:                 .Height          = 75
1005:                 .Caption         = "OK"
1006:                 .FontName        = "Tahoma"
1007:                 .FontSize        = 8
1008:                 .FontBold        = .T.
1009:                 .FontItalic      = .T.
1010:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 1018 a 1028:
1018:                 .Visible         = .T.
1019:             ENDWITH
1020:             IF NOT EMPTY(loc_cIcones)
1021:                 THIS.cmd_4c_Ok.Picture = loc_cIcones + "cadastro_salvar_60.jpg"
1022:             ENDIF
1023:             BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
1024: 
1025:         CATCH TO loc_oErro
1026:             MsgErro(loc_oErro.Message, "Erro")
1027:         ENDTRY
1028:     ENDPROC

*-- Linhas 1162 a 1170:
1162:     ENDPROC
1163: 
1164:     *==========================================================================
1165:     * GradeColumn2KeyPress - Tab=SetFocus cmd_4c_Ok; Enter+oper vazio=SetFocus Ok
1166:     * Replica Column2.Text1.KeyPress e LostFocus do legado
1167:     *==========================================================================
1168:     PROCEDURE GradeColumn2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1169:         LOCAL loc_lSetFocus
1170:         loc_lSetFocus = .F.

*-- Linhas 1181 a 1190:
1181:             ENDIF
1182:         ENDIF
1183:         IF loc_lSetFocus
1184:             IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
1185:                 THIS.cmd_4c_Ok.SetFocus
1186:             ENDIF
1187:         ENDIF
1188:     ENDPROC
1189: 
1190:     *==========================================================================

*-- Linhas 1227 a 1237:
1227:     ENDPROC
1228: 
1229:     *==========================================================================
1230:     * GradeColumn5InteractiveChange - CheckBox Ind: pesagem individual via BO
1231:     * Equivale a Column5.Check1.InteractiveChange do legado
1232:     * Se condicao nao atendida (nao INSERIR ou Obrigs), reverte o checkbox
1233:     *==========================================================================
1234:     PROCEDURE GradeColumn5InteractiveChange()
1235:         LOCAL loc_lCondicaoOk, loc_lObrigs, loc_oErro
1236:         TRY
1237:             IF USED("xOpi") AND NOT EOF("xOpi")

*-- Linhas 1269 a 1277:
1269:                             SELECT CrSigCdPam
1270:                             THIS.this_oBusinessObject.this_cOuros = ALLTRIM(NVL(CrSigCdPam.Ouros, ""))
1271:                         ENDIF
1272:                         THIS.this_oBusinessObject.InserirPorCheckbox()
1273:                     ENDIF
1274:                 ELSE
1275:                     *-- Reverte mudanca (condicoes nao atendidas)
1276:                     SELECT xOpi
1277:                     IF VARTYPE(indiv) = "L"

*-- Linhas 1322 a 1332:
1322:     ENDPROC
1323: 
1324:     *==========================================================================
1325:     * GradeColumn7InteractiveChange - CheckBox PM: atualiza Divs no xPesa
1326:     * Equivale a Column7.Check1.InteractiveChange do legado
1327:     * Se condicao nao atendida (nao INSERIR, Obrigs ou Indiv), reverte checkbox
1328:     *==========================================================================
1329:     PROCEDURE GradeColumn7InteractiveChange()
1330:         LOCAL loc_lCondicaoOk, loc_lObrigs, loc_lIndiv, loc_oErro
1331:         TRY
1332:             IF USED("xOpi") AND NOT EOF("xOpi")

*-- Linhas 1743 a 1751:
1743:     *   Column6: ColumnOrder=3 (Conta exibida 3a no legado)
1744:     *   Column7: Sparse=.F., Check1 Alignment=2, Centered=.T.
1745:     * - txt_4c_Descr: FontUnderline=.T. (replica legado Get_descr)
1746:     * - lbl_4c_LblAtencao: FontBold=.T. (replica legado Say1)
1747:     *==========================================================================
1748:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1749:         LOCAL loc_oGrid, loc_oErro
1750:         TRY
1751:             IF NOT PEMSTATUS(THIS, "grd_4c_Dados", 5)

*-- Linhas 1844 a 1854:
1844:                 THIS.txt_4c_Descr.FontUnderline = .T.
1845:             ENDIF
1846: 
1847:             *-- lbl_4c_LblAtencao: FontBold=.T. (replica Say1 do legado)
1848:             IF PEMSTATUS(THIS, "lbl_4c_LblAtencao", 5)
1849:                 THIS.lbl_4c_LblAtencao.FontBold = .T.
1850:             ENDIF
1851: 
1852:         CATCH TO loc_oErro
1853:             MsgErro(loc_oErro.Message, "Erro")
1854:         ENDTRY

*-- Linhas 1903 a 1931:
1903:                     loc_oBO.this_cDopesOpd = ALLTRIM(NVL(crSigCdOpd.Dopes, ""))
1904:                 ENDIF
1905:             ENDIF
1906: 
1907:             *-- Descricoes de conta de origem/destino (campos visiveis)
1908:             IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Grupo", 5)
1909:                 loc_oBO.this_cGrupoOs  = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Grupo.Value)
1910:                 loc_oBO.this_cContaOs  = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Conta.Value)
1911:                 loc_oBO.this_cDcontaOs = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Dconta.Value)
1912:             ENDIF
1913:             IF PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_Grupo", 5)
1914:                 loc_oBO.this_cGrupoDs  = ALLTRIM(THIS.cnt_4c_Destino.txt_4c_Grupo.Value)
1915:                 loc_oBO.this_cContaDs  = ALLTRIM(THIS.cnt_4c_Destino.txt_4c_Conta.Value)
1916:                 loc_oBO.this_cDcontaDs = ALLTRIM(THIS.cnt_4c_Destino.txt_4c_Dconta.Value)
1917:             ENDIF
1918: 
1919:             *-- Descricao do produto (Get_descr) e observacao (Mm_obs)
1920:             IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
1921:                 loc_oBO.this_cDescr = ALLTRIM(THIS.txt_4c_Descr.Value)
1922:             ENDIF
1923:             IF PEMSTATUS(THIS, "obj_4c_Mm_obs", 5)
1924:                 loc_oBO.this_cObs = THIS.obj_4c_Mm_obs.Value
1925:             ENDIF
1926: 
1927:             *-- Contexto do form pai
1928:             loc_oBO.this_cEscolha = THIS.this_cEscolha
1929:             loc_oBO.this_cDopp    = THIS.this_cDopp
1930: 
1931:             loc_lResultado = .T.

*-- Linhas 1977 a 2005:
1977:                     THIS.img_4c_FigJpg.Visible = .F.
1978:                 ENDIF
1979:             ENDIF
1980: 
1981:             *-- Contas de origem/destino
1982:             IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Grupo", 5)
1983:                 THIS.cnt_4c_Origem.txt_4c_Grupo.Value  = loc_oBO.this_cGrupoOs
1984:                 THIS.cnt_4c_Origem.txt_4c_Conta.Value  = loc_oBO.this_cContaOs
1985:                 THIS.cnt_4c_Origem.txt_4c_Dconta.Value = loc_oBO.this_cDcontaOs
1986:             ENDIF
1987:             IF PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_Grupo", 5)
1988:                 THIS.cnt_4c_Destino.txt_4c_Grupo.Value  = loc_oBO.this_cGrupoDs
1989:                 THIS.cnt_4c_Destino.txt_4c_Conta.Value  = loc_oBO.this_cContaDs
1990:                 THIS.cnt_4c_Destino.txt_4c_Dconta.Value = loc_oBO.this_cDcontaDs
1991:             ENDIF
1992: 
1993:             *-- Observacao
1994:             IF PEMSTATUS(THIS, "obj_4c_Mm_obs", 5)
1995:                 IF NOT EMPTY(loc_oBO.this_cObs)
1996:                     THIS.obj_4c_Mm_obs.Value = loc_oBO.this_cObs
1997:                 ENDIF
1998:             ENDIF
1999: 
2000:             *-- Visibilidade dos containers segundo flags do BO
2001:             THIS.AjustarVisibilidadeContainers()
2002: 
2003:             loc_lResultado = .T.
2004:         CATCH TO loc_oErro
2005:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 2054 a 2084:
2054:         TRY
2055:             loc_lInserir = (THIS.this_cEscolha == "INSERIR")
2056: 
2057:             IF PEMSTATUS(THIS, "cmd_4c_Incluir", 5)
2058:                 THIS.cmd_4c_Incluir.Enabled = loc_lInserir
2059:             ENDIF
2060:             IF PEMSTATUS(THIS, "cmd_4c_Alterar", 5)
2061:                 THIS.cmd_4c_Alterar.Enabled = loc_lInserir
2062:             ENDIF
2063:             IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
2064:                 THIS.cmd_4c_Excluir.Enabled = loc_lInserir
2065:             ENDIF
2066:             IF PEMSTATUS(THIS, "cmd_4c_Visualizar", 5)
2067:                 THIS.cmd_4c_Visualizar.Enabled = .T.
2068:             ENDIF
2069:             IF PEMSTATUS(THIS, "cmd_4c_Buscar", 5)
2070:                 THIS.cmd_4c_Buscar.Enabled = .T.
2071:             ENDIF
2072:             IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
2073:                 THIS.cmd_4c_Ok.Enabled = .T.
2074:             ENDIF
2075:             IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
2076:                 THIS.cmd_4c_Encerrar.Enabled = .T.
2077:             ENDIF
2078:             IF PEMSTATUS(THIS, "cmd_4c_Pesagem", 5)
2079:                 THIS.cmd_4c_Pesagem.Enabled = loc_lInserir
2080:             ENDIF
2081: 
2082:         CATCH TO loc_oErro
2083:             MsgErro(loc_oErro.Message, "Erro")
2084:         ENDTRY

*-- Linhas 2113 a 2141:
2113:             IF PEMSTATUS(THIS.cnt_4c_Operacao, "txt_4c_Empresa", 5)
2114:                 THIS.cnt_4c_Operacao.txt_4c_Empresa.ReadOnly  = .T.
2115:                 THIS.cnt_4c_Operacao.txt_4c_Operacao.ReadOnly = .T.
2116:                 THIS.cnt_4c_Operacao.txt_4c_Codigo.ReadOnly   = .T.
2117:             ENDIF
2118:             IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Grupo", 5)
2119:                 THIS.cnt_4c_Origem.txt_4c_Grupo.ReadOnly  = .T.
2120:                 THIS.cnt_4c_Origem.txt_4c_Conta.ReadOnly  = .T.
2121:                 THIS.cnt_4c_Origem.txt_4c_Dconta.ReadOnly = .T.
2122:             ENDIF
2123:             IF PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_Grupo", 5)
2124:                 THIS.cnt_4c_Destino.txt_4c_Grupo.ReadOnly  = .T.
2125:                 THIS.cnt_4c_Destino.txt_4c_Conta.ReadOnly  = .T.
2126:                 THIS.cnt_4c_Destino.txt_4c_Dconta.ReadOnly = .T.
2127:             ENDIF
2128: 
2129:             *-- Grid: edicao de Indiv/PM (Check1) ja controlada por Column.When
2130:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2131:                 THIS.grd_4c_Dados.Enabled = .T.
2132:             ENDIF
2133: 
2134:         CATCH TO loc_oErro
2135:             MsgErro(loc_oErro.Message, "Erro")
2136:         ENDTRY
2137:     ENDPROC
2138: 
2139:     *==========================================================================
2140:     * LimparCampos - Limpa campos do form e resseta estado do BO.
2141:     * Nao toca em xOpi/xPesa/TmpNens (cursores do form pai compartilhados).

*-- Linhas 2155 a 2183:
2155:                 THIS.img_4c_FigJpg.Visible = .F.
2156:             ENDIF
2157:             IF PEMSTATUS(THIS, "shp_4c_Shape4", 5)
2158:                 THIS.shp_4c_Shape4.Visible = .F.
2159:             ENDIF
2160:             IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Grupo", 5)
2161:                 THIS.cnt_4c_Origem.txt_4c_Grupo.Value  = ""
2162:                 THIS.cnt_4c_Origem.txt_4c_Conta.Value  = ""
2163:                 THIS.cnt_4c_Origem.txt_4c_Dconta.Value = ""
2164:             ENDIF
2165:             IF PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_Grupo", 5)
2166:                 THIS.cnt_4c_Destino.txt_4c_Grupo.Value  = ""
2167:                 THIS.cnt_4c_Destino.txt_4c_Conta.Value  = ""
2168:                 THIS.cnt_4c_Destino.txt_4c_Dconta.Value = ""
2169:             ENDIF
2170:             IF PEMSTATUS(THIS.cnt_4c_Operacao, "txt_4c_Empresa", 5)
2171:                 THIS.cnt_4c_Operacao.txt_4c_Empresa.Value  = ""
2172:                 THIS.cnt_4c_Operacao.txt_4c_Operacao.Value = ""
2173:                 THIS.cnt_4c_Operacao.txt_4c_Codigo.Value   = ""
2174:             ENDIF
2175: 
2176:             *-- Reseta propriedades de transito do BO (mantem contexto da operacao)
2177:             loc_oBO = THIS.this_oBusinessObject
2178:             IF VARTYPE(loc_oBO) = "O"
2179:                 loc_oBO.this_cDPros     = ""
2180:                 loc_oBO.this_cFigJpgs   = ""
2181:                 loc_oBO.this_cMatPrincs = ""
2182:                 loc_oBO.this_cCgrus     = ""
2183:                 loc_oBO.this_nPesoms    = 0


### BO (C:\4c\projeto\app\classes\SigPdMp3BO.prg):
*==============================================================================
* SigPdMp3BO.prg - Business Object para Emissao de Etiquetas (SIGPDMP9)
* Herda de: BusinessBase
* Form: FormSigPdMp3 (sub-form de emissao de etiquetas de pesagem)
* Legado: SigPdMp3.SCX / SIGPDMP9
*==============================================================================
DEFINE CLASS SigPdMp3BO AS BusinessBase

    *-- Contexto recebido do form pai
    this_cDopp      = ""    && _Dopp do form pai (operacao corrente)
    this_cEscolha   = ""    && pcEscolha do form pai (INSERIR/CONSULTAR)

    *-- Cabecalho da operacao (TmpNens)
    this_cEmps      = ""    && Empresa (TmpNens.emps)
    this_cDopps     = ""    && Codigo da operacao (TmpNens.dopps)
    this_nNumps     = 0     && Numero da operacao (TmpNens.numps)
    this_cGrupoOs   = ""    && Grupo origem (TmpNens.grupoos)
    this_cContaOs   = ""    && Conta origem (TmpNens.contaos)
    this_cDcontaOs  = ""    && Nome da conta origem (SigCdCli.RClis)
    this_cGrupoDs   = ""    && Grupo destino (TmpNens.grupods)
    this_cContaDs   = ""    && Conta destino (TmpNens.contads)
    this_cDcontaDs  = ""    && Nome da conta destino (SigCdCli.RClis)

    *-- Flags da operacao (crSigCdOpd)
    this_nOrigems   = 0     && Exibir container Origem (crSigCdOpd.Origems)
    this_nDestinos  = 0     && Exibir container Destino (crSigCdOpd.Destinos)
    this_nImagms    = 0     && Exibir imagem do produto (crSigCdOpd.Imagems)
    this_nEtiqs     = 0     && Tipo de etiquetas (crSigCdOpd.Etiqs)
    this_cDopesOpd  = ""    && Dopes de crSigCdOpd

    *-- Linha corrente do grid xOpi
    this_nNops      = 0     && Numero OP / Ordem Fabricacao (xOpi.nops) - Column1
    this_cOper      = ""    && Pedido/operacao (xOpi.oper) - Column2
    this_nQtds      = 0     && Quantidade (xOpi.qtds) - Column3
    this_cCPros     = ""    && Codigo do produto (xOpi.cpros) - Column4
    this_lIndiv     = .F.   && Flag individual (xOpi.indiv) - Column5 checkbox
    this_cConta     = ""    && Conta (xOpi.conta) - Column6
    this_lDivs      = .F.   && Flag divisao PM (xOpi.Divs) - Column7 checkbox
    this_cAmarra    = ""    && Codigo de amarracao (xOpi.amarra)
    this_nCbars     = 0     && Flag codigo de barras (xOpi.cbars)
    this_cCodCors   = ""    && Codigo da cor (xOpi.codcors)
    this_cCodTams   = ""    && Codigo do tamanho (xOpi.codtams)
    this_cEmpds     = ""    && Empresa destino (xOpi.empds)
    this_cDopes     = ""    && Data/operacao (xOpi.dopes)
    this_nNumes     = 0     && Numero (xOpi.numes)
    this_cCitens    = ""    && Codigo do item (xOpi.citens)
    this_nNenvs     = 0     && Numero do envelope (xOpi.nenvs)
    this_lObrigs    = .F.   && Flag obrigatorio (xOpi.obrigs)

    *-- Dados do produto (SigCdPro via CursorQuery)
    this_cDPros     = ""    && Descricao do produto (DPros)
    this_cFigJpgs   = ""    && Imagem base64 (FigJpgs)
    this_cMatPrincs = ""    && Material principal (SigCdPro.MatPrincs)
    this_cCgrus     = ""    && Grupo do produto (SigCdPro.Cgrus)
    this_nPesoms    = 0     && Peso medio (SigCdPro.Pesoms)

    *-- Dados do grupo (SigCdGrp via CursorQuery)
    this_cMercs     = ""    && Mercadoria (SigCdGrp.Mercs)

    *-- Dados do sub-grupo (SigCdGpr via CursorQuery)
    this_cMatPGpr   = ""    && Material do sub-grupo (SigCdGpr.MatPrincs)
    this_nCpQtds    = 0     && Qtde por unidade (SigCdGpr.cpqtds)

    *-- Material e flags calculados
    this_cMatP      = ""    && Material efetivo resolvido (_MatP)
    this_lEspecial  = .F.   && Flag especial (CadProds=3 ou Pesos=1)
    this_nCadProds  = 0     && Tipo de cadastro do produto (SigCdOpe.CadProds)
    this_nPesos     = 0     && Flag de peso (SigCdOpe.Pesos)

    *-- Exibicao e observacao
    this_cDescr     = ""    && Descricao exibida em Get_descr
    this_cObs       = ""    && Observacao (xmfas.obss)

    *-- Auxiliar para impressao de etiquetas (ok.Click)
    this_cPosicao   = ""    && Posicao para Seek crSigCdNec

    *-- Material fallback de CrSigCdPam.Ouros (preenchido pelo Form antes de Inserir)
    this_cOuros     = ""

    *==========================================================================
    * Init - Inicializa o BO
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades da linha corrente do cursor xOpi
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nNops    = NVL(nops, 0)
                THIS.this_cOper    = ALLTRIM(NVL(oper, ""))
                THIS.this_nQtds    = NVL(qtds, 0)
                THIS.this_cCPros   = ALLTRIM(NVL(cpros, ""))
                IF VARTYPE(indiv) = "L"
                    THIS.this_lIndiv = NVL(indiv, .F.)
                ELSE
                    THIS.this_lIndiv = IIF(NVL(indiv, 0) = 1, .T., .F.)
                ENDIF
                THIS.this_cConta   = ALLTRIM(NVL(conta, ""))
                IF VARTYPE(Divs) = "L"
                    THIS.this_lDivs = NVL(Divs, .F.)
                ELSE
                    THIS.this_lDivs = IIF(NVL(Divs, 0) = 1, .T., .F.)
                ENDIF
                THIS.this_cAmarra  = ALLTRIM(NVL(amarra, ""))
                THIS.this_nCbars   = NVL(cbars, 0)
                THIS.this_cCodCors = ALLTRIM(NVL(codcors, ""))
                THIS.this_cCodTams = ALLTRIM(NVL(codtams, ""))
                THIS.this_cEmpds   = ALLTRIM(NVL(empds, ""))
                THIS.this_cDopes   = ALLTRIM(NVL(dopes, ""))
                THIS.this_nNumes   = NVL(numes, 0)
                THIS.this_cCitens  = ALLTRIM(NVL(citens, ""))
                THIS.this_nNenvs   = NVL(nenvs, 0)
                IF VARTYPE(obrigs) = "L"
                    THIS.this_lObrigs = NVL(obrigs, .F.)
                ELSE
                    THIS.this_lObrigs = IIF(NVL(obrigs, 0) = 1, .T., .F.)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterDadosProduto - Consulta SigCdPro, SigCdGrp, SigCdGpr; resolve MatP
    *==========================================================================
    PROCEDURE ObterDadosProduto()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        THIS.this_cMatPrincs = ""
        THIS.this_cCgrus     = ""
        THIS.this_nPesoms    = 0
        THIS.this_cMercs     = ""
        THIS.this_cMatPGpr   = ""
        THIS.this_nCpQtds    = 0
        THIS.this_cMatP      = ""
        THIS.this_cDPros     = ""
        THIS.this_cFigJpgs   = ""
        TRY
            loc_cSQL = "SELECT MatPrincs, Cgrus, PesoMs, DPros, FigJpgs" + ;
                       " FROM SigCdPro" + ;
                       " WHERE CPros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
            IF USED("cursor_4c_LocalPro")
                USE IN cursor_4c_LocalPro
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
            IF loc_nResult > 0 AND NOT EOF("cursor_4c_LocalPro")
                SELECT cursor_4c_LocalPro
                THIS.this_cMatPrincs = ALLTRIM(NVL(MatPrincs, ""))
                THIS.this_cCgrus     = ALLTRIM(NVL(Cgrus, ""))
                THIS.this_nPesoms    = NVL(PesoMs, 0)
                THIS.this_cDPros     = ALLTRIM(NVL(DPros, ""))
                THIS.this_cFigJpgs   = NVL(FigJpgs, "")

                IF NOT EMPTY(THIS.this_cCgrus)
                    loc_cSQL = "SELECT Mercs FROM SigCdGrp WHERE CGrus = " + ;
                               EscaparSQL(ALLTRIM(THIS.this_cCgrus))
                    IF USED("cursor_4c_LocalGru")
                        USE IN cursor_4c_LocalGru
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalGru")
                    IF loc_nResult > 0 AND NOT EOF("cursor_4c_LocalGru")
                        SELECT cursor_4c_LocalGru
                        THIS.this_cMercs = ALLTRIM(NVL(Mercs, ""))

                        IF NOT EMPTY(THIS.this_cMercs)
                            loc_cSQL = "SELECT MatPrincs, cpqtds FROM SigCdGpr" + ;
                                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cMercs))
                            IF USED("cursor_4c_LocalGgrp")
                                USE IN cursor_4c_LocalGgrp
                            ENDIF
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalGgrp")
                            IF loc_nResult > 0 AND NOT EOF("cursor_4c_LocalGgrp")
                                SELECT cursor_4c_LocalGgrp
                                THIS.this_cMatPGpr = ALLTRIM(NVL(MatPrincs, ""))
                                THIS.this_nCpQtds  = NVL(cpqtds, 0)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF NOT EMPTY(THIS.this_cMatPrincs)
                THIS.this_cMatP = THIS.this_cMatPrincs
            ELSE
                IF NOT EMPTY(THIS.this_cMatPGpr)
                    THIS.this_cMatP = THIS.this_cMatPGpr
                ELSE
                    THIS.this_cMatP = THIS.this_cOuros
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterDescricaoConta - Retorna RClis do SigCdCli para o ICli informado
    *==========================================================================
    PROCEDURE ObterDescricaoConta(par_cICli)
        LOCAL loc_cResult, loc_cSQL, loc_nResult
        loc_cResult = ""
        TRY
            IF NOT EMPTY(ALLTRIM(par_cICli))
                loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(ALLTRIM(par_cICli))
                IF USED("cursor_4c_LocalCli")
                    USE IN cursor_4c_LocalCli
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCli")
                IF loc_nResult > 0 AND NOT EOF("cursor_4c_LocalCli")
                    SELECT cursor_4c_LocalCli
                    loc_cResult = ALLTRIM(NVL(RClis, ""))
                ENDIF
                IF USED("cursor_4c_LocalCli")
                    USE IN cursor_4c_LocalCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cResult
    ENDPROC

    *==========================================================================
    * ObterDadosOpe - Busca CadProds e Pesos de SigCdOpe; define this_lEspecial
    *==========================================================================
    PROCEDURE ObterDadosOpe(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        THIS.this_nCadProds = 0
        THIS.this_nPesos    = 0
        THIS.this_lEspecial = .F.
        TRY
            IF NOT EMPTY(ALLTRIM(par_cDopes))
                loc_cSQL = "SELECT CadProds, Pesos FROM SigCdOpe" + ;
                           " WHERE dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
                IF USED("cursor_4c_LocalOpe")
                    USE IN cursor_4c_LocalOpe
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")
                IF loc_nResult > 0 AND NOT EOF("cursor_4c_LocalOpe")
                    SELECT cursor_4c_LocalOpe
                    THIS.this_nCadProds = NVL(CadProds, 0)
                    THIS.this_nPesos    = NVL(Pesos, 0)
                    THIS.this_lEspecial = (THIS.this_nCadProds = 3 OR THIS.this_nPesos = 1)
                    loc_lSucesso = .T.
                ENDIF
                IF USED("cursor_4c_LocalOpe")
                    USE IN cursor_4c_LocalOpe
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida contexto antes de processar pesagem
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cAmarra))
            MsgAviso("Amarra n" + CHR(227) + "o informada.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF THIS.this_nQtds <= 0
            MsgAviso("Quantidade inv" + CHR(225) + "lida.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Inserir - Processa pesagem do item corrente (INSERT xPesa com Especial)
    * Equivalente a Grade.Column3.Text1.Valid do legado
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_nCont, loc_nQtde, loc_nPeso
        loc_lSucesso = .F.
        loc_nCont    = 0
        loc_nQtde    = 0
        loc_nPeso    = 0
        TRY
            SELECT xPesa
            DELETE ALL FOR Amarra = THIS.this_cAmarra

            THIS.ObterDadosProduto()
            THIS.ObterDadosOpe(THIS.this_cDopes)

            IF THIS.this_lIndiv AND (THIS.this_nCbars = 0)
                loc_nCont = INT(THIS.this_nQtds)
                loc_nQtde = 0
                DO WHILE loc_nQtde < loc_nCont
                    loc_nQtde = loc_nQtde + 1
                    loc_nPeso = IIF(THIS.this_nCpQtds = 1, 1, 0)
                    INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                       Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Especial, citens) ;
                        VALUES (THIS.this_cOper, THIS.this_cCPros, 1, loc_nPeso, ;
                                THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                THIS.this_nPesoms, THIS.this_lEspecial, THIS.this_cCitens)
                ENDDO
                IF (THIS.this_nQtds > loc_nQtde)
                    loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds - loc_nQtde, 0)
                    INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                       Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Especial, citens) ;
                        VALUES (THIS.this_cOper, THIS.this_cCPros, THIS.this_nQtds - loc_nQtde, ;
                                loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                THIS.this_nPesoms * (THIS.this_nQtds - loc_nQtde), ;
                                THIS.this_lEspecial, THIS.this_cCitens)
                ENDIF
            ELSE
                loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds, 0)
                INSERT INTO xPesa (cBars, Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                   Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Especial, citens) ;
                    VALUES (THIS.this_nCbars, THIS.this_cOper, THIS.this_cCPros, ;
                            THIS.this_nQtds, loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, ;
                            THIS.this_cEmpds, THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                            THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                            THIS.this_nPesoms * THIS.this_nQtds, THIS.this_lEspecial, THIS.this_cCitens)
            ENDIF

            THIS.RegistrarAuditoria("INSERIR")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirPorCheckbox - Pesagem via checkbox indiv (INSERT xPesa com Divs)
    * Equivalente a Grade.Column5.Check1.InteractiveChange do legado
    *==========================================================================
    PROCEDURE InserirPorCheckbox()
        LOCAL loc_lSucesso, loc_nCont, loc_nQtde, loc_nPeso
        loc_lSucesso = .F.
        loc_nCont    = 0
        loc_nQtde    = 0
        loc_nPeso    = 0
        TRY
            SELECT xPesa
            DELETE ALL FOR Amarra = THIS.this_cAmarra

            THIS.ObterDadosProduto()

            IF THIS.this_lIndiv AND (THIS.this_nCbars = 0)
                loc_nCont = INT(THIS.this_nQtds)
                loc_nQtde = 0
                DO WHILE loc_nQtde < loc_nCont
                    loc_nQtde = loc_nQtde + 1
                    loc_nPeso = IIF(THIS.this_nCpQtds = 1, 1, 0)
                    INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                       Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Divs, citens) ;
                        VALUES (THIS.this_cOper, THIS.this_cCPros, 1, loc_nPeso, ;
                                THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                THIS.this_nPesoms, THIS.this_lDivs, THIS.this_cCitens)
                ENDDO
                IF (THIS.this_nQtds > loc_nQtde)
                    loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds - loc_nQtde, 0)
                    INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                       Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Divs, citens) ;
                        VALUES (THIS.this_cOper, THIS.this_cCPros, THIS.this_nQtds - loc_nQtde, ;
                                loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                THIS.this_nPesoms * (THIS.this_nQtds - loc_nQtde), ;
                                THIS.this_lDivs, THIS.this_cCitens)
                ENDIF
            ELSE
                loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds, 0)
                INSERT INTO xPesa (cBars, Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                   Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, citens) ;
                    VALUES (THIS.this_nCbars, THIS.this_cOper, THIS.this_cCPros, ;
                            THIS.this_nQtds, loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, ;
                            THIS.this_cEmpds, THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                            THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                            THIS.this_nPesoms * THIS.this_nQtds, THIS.this_cCitens)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza flag Divs no xPesa para o amarra corrente
    * Equivalente a Grade.Column7.Check1.InteractiveChange do legado
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            UPDATE xPesa SET Divs = (THIS.this_lDivs) WHERE Amarra = THIS.this_cAmarra
            THIS.RegistrarAuditoria("ATUALIZAR")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarDivsTodas - Atualiza Divs em xPesa para todos os registros xOpi
    * Equivalente a Grade.Column7.Header1.DblClick do legado
    *==========================================================================
    PROCEDURE AtualizarDivsTodas()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT xOpi
            GO TOP
            SCAN
                UPDATE xPesa SET Divs = (xOpi.Divs) WHERE Amarra = xOpi.Amarra
                SELECT xOpi
            ENDSCAN
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ProcessarTodasOpi - Pesagem para todos os registros xOpi (marcar/desmarcar)
    * Equivalente a Grade.Column5.Header1.DblClick do legado
    *==========================================================================
    PROCEDURE ProcessarTodasOpi()
        LOCAL loc_lSucesso, loc_nCont, loc_nQtde, loc_nPeso
        loc_lSucesso = .F.
        loc_nCont    = 0
        loc_nQtde    = 0
        loc_nPeso    = 0
        TRY
            SELECT xOpi
            GO TOP
            SCAN
                IF THIS.CarregarDoCursor("xOpi")
                    THIS.ObterDadosProduto()

                    SELECT xPesa
                    DELETE ALL FOR Amarra = THIS.this_cAmarra

                    IF THIS.this_lIndiv AND (THIS.this_nCbars = 0)
                        loc_nCont = INT(THIS.this_nQtds)
                        loc_nQtde = 0
                        DO WHILE loc_nQtde < loc_nCont
                            loc_nQtde = loc_nQtde + 1
                            loc_nPeso = IIF(THIS.this_nCpQtds = 1, 1, 0)
                            INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                               Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Divs, citens) ;
                                VALUES (THIS.this_cOper, THIS.this_cCPros, 1, loc_nPeso, ;
                                        THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                        THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                        THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                        THIS.this_nPesoms, THIS.this_lDivs, THIS.this_cCitens)
                        ENDDO
                        IF (THIS.this_nQtds > loc_nQtde)
                            loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds - loc_nQtde, 0)
                            INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                               Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Divs, citens) ;
                                VALUES (THIS.this_cOper, THIS.this_cCPros, THIS.this_nQtds - loc_nQtde, ;
                                        loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                        THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                        THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                        THIS.this_nPesoms * (THIS.this_nQtds - loc_nQtde), ;
                                        THIS.this_lDivs, THIS.this_cCitens)
                        ENDIF
                    ELSE
                        loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds, 0)
                        INSERT INTO xPesa (cBars, Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                           Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, citens) ;
                            VALUES (THIS.this_nCbars, THIS.this_cOper, THIS.this_cCPros, ;
                                    THIS.this_nQtds, loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, ;
                                    THIS.this_cEmpds, THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                    THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                    THIS.this_nPesoms * THIS.this_nQtds, THIS.this_cCitens)
                    ENDIF

                    SELECT xOpi
                ENDIF
            ENDSCAN
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna identificador do registro corrente (Amarra)
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cAmarra)
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria - Override: form operacional opera em cursores locais
    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        IF NOT EMPTY(THIS.this_cTabela)
            DODEFAULT(par_cOperacao)
        ENDIF
    ENDPROC

ENDDEFINE

