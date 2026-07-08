# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (7)
- [LAYOUT-POSITION] Controle 'lbl_vencimento_a' (parent: SIGRECRP): Top original=219 vs migrado 'lbl_4c_Lbl_vencimento_a' Top=134 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_vencimento' (parent: SIGRECRP): Top original=219 vs migrado 'lbl_4c_Lbl_vencimento_a' Top=134 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_vencimento' (parent: SIGRECRP): Left original=177 vs migrado 'lbl_4c_Lbl_vencimento_a' Left=333 (diff=156px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_empresa' (parent: SIGRECRP): Top original=244 vs migrado 'lbl_4c_Lbl_empresa' Top=159 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_oper' (parent: SIGRECRP): Top original=87 vs migrado 'obj_4c_Opt_oper' Top=3 (diff=84px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_oper' (parent: SIGRECRP): Left original=243 vs migrado 'obj_4c_Opt_oper' Left=0 (diff=243px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_moeda' (parent: SIGRECRP): Top original=270 vs migrado 'lbl_4c_Lbl_moeda' Top=185 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecrp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1661 linhas total):

*-- Linhas 78 a 86:
78:         loc_lSucesso   = .F.
79:         loc_lContinuar = .T.
80:         TRY
81:             THIS.Caption = "Relat" + CHR(243) + "rio de D" + CHR(233) + ;
82:                            "bitos/Cr" + CHR(233) + "ditos Pendentes"
83: 
84:             IF TYPE("gc_4c_CaminhoIcones") = "U"
85:                 gc_4c_CaminhoIcones = ""
86:             ENDIF

*-- Linhas 110 a 119:
110:                 *-- BINDEVENTs: Fase 5 cobre Grupo+Conta; Fase 6 completa com demais
111:                 THIS.ConfigurarPaginaDados()
112: 
113:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
114:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
115: 
116:                 THIS.Visible = .T.
117:                 loc_lSucesso = .T.
118:             ENDIF
119:         CATCH TO loc_oErro

*-- Linhas 137 a 177:
137: 
138:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
139:         WITH THIS.cnt_4c_Cabecalho
140:             .Top         = 0
141:             .Left        = 0
142:             .Width       = THIS.Width
143:             .Height      = 80
144:             .BackStyle   = 1
145:             .BackColor   = RGB(100, 100, 100)
146:             .BorderWidth = 0
147:             .Visible     = .T.
148: 
149:             *-- Sombra deslocada 2px para efeito 3D do texto branco
150:             .AddObject("lbl_4c_Sombra", "Label")
151:             WITH .lbl_4c_Sombra
152:                 .Top       = 22
153:                 .Left      = 22
154:                 .Width     = THIS.Width
155:                 .Height    = 30
156:                 .Caption   = loc_cTitulo
157:                 .FontName  = "Tahoma"
158:                 .FontSize  = 14
159:                 .FontBold  = .T.
160:                 .ForeColor = RGB(0, 0, 0)
161:                 .BackStyle = 0
162:                 .Visible   = .T.
163:             ENDWITH
164: 
165:             *-- Titulo em branco (sobre a sombra)
166:             .AddObject("lbl_4c_Titulo", "Label")
167:             WITH .lbl_4c_Titulo
168:                 .Top       = 20
169:                 .Left      = 20
170:                 .Width     = THIS.Width
171:                 .Height    = 30
172:                 .Caption   = loc_cTitulo
173:                 .FontName  = "Tahoma"
174:                 .FontSize  = 14
175:                 .FontBold  = .T.
176:                 .ForeColor = RGB(255, 255, 255)
177:                 .BackStyle = 0

*-- Linhas 191 a 217:
191:     PROTECTED PROCEDURE ConfigurarBotoes()
192:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
193:         WITH THIS.cmg_4c_Botoes
194:             .Top           = 0
195:             .Left          = 526
196:             .Width         = 273
197:             .Height        = 80
198:             .ButtonCount   = 4
199:             .BackStyle     = 0
200:             .BorderStyle   = 0
201:             .BorderColor   = RGB(136, 189, 188)
202:             .SpecialEffect = 1
203:             .Themes        = .F.
204:             .Visible       = .T.
205: 
206:             *-- Visualizar (preview em tela)
207:             WITH .Buttons(1)
208:                 .Top             = 5
209:                 .Left            = 5
210:                 .Width           = 65
211:                 .Height          = 70
212:                 .Caption         = "Visualizar"
213:                 .FontBold        = .T.
214:                 .FontItalic      = .T.
215:                 .BackColor       = RGB(255, 255, 255)
216:                 .ForeColor       = RGB(90, 90, 90)
217:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 225 a 237:
225: 
226:             *-- Imprimir (impressora com dialogo)
227:             WITH .Buttons(2)
228:                 .Top             = 5
229:                 .Left            = 71
230:                 .Width           = 65
231:                 .Height          = 70
232:                 .Caption         = "Imprimir"
233:                 .FontName        = "Tahoma"
234:                 .FontBold        = .T.
235:                 .FontItalic      = .T.
236:                 .FontSize        = 8
237:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 247 a 259:
247: 
248:             *-- Excel (exportar)
249:             WITH .Buttons(3)
250:                 .Top             = 5
251:                 .Left            = 137
252:                 .Width           = 65
253:                 .Height          = 70
254:                 .Caption         = "Excel"
255:                 .FontName        = "Tahoma"
256:                 .FontBold        = .T.
257:                 .FontItalic      = .T.
258:                 .FontSize        = 8
259:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 269 a 281:
269: 
270:             *-- Encerrar (fechar form - Cancel=.T. dispara no ESC)
271:             WITH .Buttons(4)
272:                 .Top             = 5
273:                 .Left            = 203
274:                 .Width           = 65
275:                 .Height          = 70
276:                 .Caption         = "Encerrar"
277:                 .Cancel          = .T.
278:                 .FontName        = "Tahoma"
279:                 .FontBold        = .T.
280:                 .FontItalic      = .T.
281:                 .FontSize        = 8

*-- Linhas 306 a 673:
306:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
307:         loc_oPgf.PageCount = 1
308: 
309:         loc_oPgf.Top    = 85
310:         loc_oPgf.Left   = -1
311:         loc_oPgf.Width  = THIS.Width + 2
312:         loc_oPgf.Height = THIS.Height - 85
313:         loc_oPgf.Tabs   = .F.
314: 
315:         *-- Configurar Page1 (FORA de qualquer WITH - usar referencia direta)
316:         loc_oPgf.Page1.Caption   = "Filtros"
317:         loc_oPgf.Page1.FontName  = "Tahoma"
318:         loc_oPgf.Page1.FontSize  = 8
319:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
320:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
321:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
322: 
323:         loc_oPgf.Visible    = .T.
324:         loc_oPgf.ActivePage = 1
325:     ENDPROC
326: 
327:     *--------------------------------------------------------------------------
328:     * ConfigurarPaginaLista - Adiciona todos os controles de filtro na Page1
329:     *   Coordenadas relativas a Page1: top_original - 85 (PageFrame.Top=85)
330:     *--------------------------------------------------------------------------
331:     PROTECTED PROCEDURE ConfigurarPaginaLista()
332:         LOCAL loc_oPag
333:         loc_oPag = THIS.pgf_4c_Paginas.Page1
334: 
335:         *-- === Linha 1: Label + OptionGroup (D<e9>bito / Cr<e9>dito) ===
336:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
337:         WITH loc_oPag.lbl_4c_Label1
338:             .Top       = 7
339:             .Left      = 201
340:             .Width     = 43
341:             .Height    = 17
342:             .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
343:             .FontName  = "Tahoma"
344:             .FontSize  = 8
345:             .ForeColor = RGB(90, 90, 90)
346:             .BackStyle = 0
347:             .AutoSize  = .F.
348:             .Visible   = .T.
349:         ENDWITH
350: 
351:         loc_oPag.AddObject("obj_4c_Opt_oper", "OptionGroup")
352:         WITH loc_oPag.obj_4c_Opt_oper
353:             .Top         = 2
354:             .Left        = 243
355:             .Width       = 268
356:             .Height      = 27
357:             .ButtonCount = 2
358:             .BackStyle   = 0
359:             .Value       = 1
360:             .Visible     = .T.
361:             WITH .Buttons(1)
362:                 .Caption  = "D" + CHR(233) + "bito"
363:                 .Top      = 3
364:                 .Left     = 0
365:                 .Width    = 130
366:                 .Height   = 20
367:                 .Visible  = .T.
368:             ENDWITH
369:             WITH .Buttons(2)
370:                 .Caption  = "Cr" + CHR(233) + "dito"
371:                 .Top      = 3
372:                 .Left     = 133
373:                 .Width    = 130
374:                 .Height   = 20
375:                 .FontName = "Tahoma"
376:                 .FontSize = 8
377:                 .Visible  = .T.
378:             ENDWITH
379:         ENDWITH
380: 
381:         *-- === Linha 2: Grupo cont<e1>bil principal ===
382:         loc_oPag.AddObject("lbl_4c_Label4", "Label")
383:         WITH loc_oPag.lbl_4c_Label4
384:             .Top       = 29
385:             .Left      = 203
386:             .Width     = 43
387:             .Height    = 17
388:             .Caption   = "Grupo :"
389:             .FontName  = "Tahoma"
390:             .FontSize  = 8
391:             .ForeColor = RGB(90, 90, 90)
392:             .BackStyle = 0
393:             .AutoSize  = .F.
394:             .Visible   = .T.
395:         ENDWITH
396: 
397:         loc_oPag.AddObject("txt_4c_Grupo", "TextBox")
398:         WITH loc_oPag.txt_4c_Grupo
399:             .Top      = 27
400:             .Left     = 248
401:             .Width    = 79
402:             .Height   = 23
403:             .Value    = ""
404:             .FontName = "Tahoma"
405:             .FontSize = 8
406:             .Visible  = .T.
407:         ENDWITH
408: 
409:         loc_oPag.AddObject("txt_4c__Ds_Grupo", "TextBox")
410:         WITH loc_oPag.txt_4c__Ds_Grupo
411:             .Top      = 27
412:             .Left     = 329
413:             .Width    = 150
414:             .Height   = 23
415:             .Value    = ""
416:             .FontName = "Tahoma"
417:             .FontSize = 8
418:             .Visible  = .T.
419:         ENDWITH
420: 
421:         *-- === Linha 3: Conta cont<e1>bil principal ===
422:         loc_oPag.AddObject("lbl_4c_Label5", "Label")
423:         WITH loc_oPag.lbl_4c_Label5
424:             .Top       = 55
425:             .Left      = 203
426:             .Width     = 43
427:             .Height    = 17
428:             .Caption   = "Conta :"
429:             .FontName  = "Tahoma"
430:             .FontSize  = 8
431:             .ForeColor = RGB(90, 90, 90)
432:             .BackStyle = 0
433:             .AutoSize  = .F.
434:             .Visible   = .T.
435:         ENDWITH
436: 
437:         loc_oPag.AddObject("txt_4c_Conta", "TextBox")
438:         WITH loc_oPag.txt_4c_Conta
439:             .Top      = 52
440:             .Left     = 248
441:             .Width    = 79
442:             .Height   = 23
443:             .Value    = ""
444:             .FontName = "Tahoma"
445:             .FontSize = 8
446:             .Visible  = .T.
447:         ENDWITH
448: 
449:         loc_oPag.AddObject("txt_4c_DCONTA", "TextBox")
450:         WITH loc_oPag.txt_4c_DCONTA
451:             .Top      = 52
452:             .Left     = 329
453:             .Width    = 327
454:             .Height   = 23
455:             .Value    = ""
456:             .FontName = "Tahoma"
457:             .FontSize = 8
458:             .Visible  = .T.
459:         ENDWITH
460: 
461:         *-- === Linha 4: Subgrupo contra-partida ===
462:         loc_oPag.AddObject("lbl_4c_Label2", "Label")
463:         WITH loc_oPag.lbl_4c_Label2
464:             .Top       = 80
465:             .Left      = 174
466:             .Width     = 70
467:             .Height    = 15
468:             .Caption   = "Grupo (C.P.) :"
469:             .FontName  = "Tahoma"
470:             .FontSize  = 8
471:             .ForeColor = RGB(90, 90, 90)
472:             .BackStyle = 0
473:             .AutoSize  = .F.
474:             .Visible   = .T.
475:         ENDWITH
476: 
477:         loc_oPag.AddObject("txt_4c_Sgrupo", "TextBox")
478:         WITH loc_oPag.txt_4c_Sgrupo
479:             .Top      = 77
480:             .Left     = 248
481:             .Width    = 79
482:             .Height   = 25
483:             .Value    = ""
484:             .FontName = "Tahoma"
485:             .FontSize = 8
486:             .Visible  = .T.
487:         ENDWITH
488: 
489:         loc_oPag.AddObject("txt_4c_Dsgrupo", "TextBox")
490:         WITH loc_oPag.txt_4c_Dsgrupo
491:             .Top      = 77
492:             .Left     = 329
493:             .Width    = 150
494:             .Height   = 25
495:             .Value    = ""
496:             .FontName = "Tahoma"
497:             .FontSize = 8
498:             .Visible  = .T.
499:         ENDWITH
500: 
501:         *-- === Linha 5: Subconta contra-partida ===
502:         loc_oPag.AddObject("lbl_4c_Label3", "Label")
503:         WITH loc_oPag.lbl_4c_Label3
504:             .Top       = 108
505:             .Left      = 174
506:             .Width     = 70
507:             .Height    = 17
508:             .Caption   = "Conta (C.P.) :"
509:             .FontName  = "Tahoma"
510:             .FontSize  = 8
511:             .ForeColor = RGB(90, 90, 90)
512:             .BackStyle = 0
513:             .AutoSize  = .F.
514:             .Visible   = .T.
515:         ENDWITH
516: 
517:         loc_oPag.AddObject("txt_4c_Sconta", "TextBox")
518:         WITH loc_oPag.txt_4c_Sconta
519:             .Top      = 104
520:             .Left     = 248
521:             .Width    = 79
522:             .Height   = 25
523:             .Value    = ""
524:             .FontName = "Tahoma"
525:             .FontSize = 8
526:             .Visible  = .T.
527:         ENDWITH
528: 
529:         loc_oPag.AddObject("txt_4c_DsConta", "TextBox")
530:         WITH loc_oPag.txt_4c_DsConta
531:             .Top      = 104
532:             .Left     = 329
533:             .Width    = 327
534:             .Height   = 25
535:             .Value    = ""
536:             .FontName = "Tahoma"
537:             .FontSize = 8
538:             .Visible  = .T.
539:         ENDWITH
540: 
541:         *-- === Linha 6: Per<ed>odo de vencimento ===
542:         loc_oPag.AddObject("lbl_4c_Lbl_vencimento", "Label")
543:         WITH loc_oPag.lbl_4c_Lbl_vencimento
544:             .Top       = 134
545:             .Left      = 177
546:             .Width     = 67
547:             .Height    = 17
548:             .Caption   = "Vencimento :"
549:             .FontName  = "Tahoma"
550:             .FontSize  = 8
551:             .ForeColor = RGB(90, 90, 90)
552:             .BackStyle = 0
553:             .AutoSize  = .F.
554:             .Visible   = .T.
555:         ENDWITH
556: 
557:         loc_oPag.AddObject("txt_4c__dt_inicial", "TextBox")
558:         WITH loc_oPag.txt_4c__dt_inicial
559:             .Top       = 131
560:             .Left      = 248
561:             .Width     = 80
562:             .Height    = 23
563:             .Value     = {}
564:             .InputMask = "99/99/9999"
565:             .FontName  = "Tahoma"
566:             .FontSize  = 8
567:             .Visible   = .T.
568:         ENDWITH
569: 
570:         loc_oPag.AddObject("lbl_4c_Lbl_vencimento_a", "Label")
571:         WITH loc_oPag.lbl_4c_Lbl_vencimento_a
572:             .Top       = 134
573:             .Left      = 333
574:             .Width     = 10
575:             .Height    = 17
576:             .Caption   = "a"
577:             .FontName  = "Tahoma"
578:             .FontSize  = 8
579:             .ForeColor = RGB(90, 90, 90)
580:             .BackStyle = 0
581:             .Visible   = .T.
582:         ENDWITH
583: 
584:         loc_oPag.AddObject("txt_4c__dt_final", "TextBox")
585:         WITH loc_oPag.txt_4c__dt_final
586:             .Top       = 131
587:             .Left      = 345
588:             .Width     = 80
589:             .Height    = 23
590:             .Value     = {}
591:             .InputMask = "99/99/9999"
592:             .FontName  = "Tahoma"
593:             .FontSize  = 8
594:             .Visible   = .T.
595:         ENDWITH
596: 
597:         *-- === Linha 7: Empresa ===
598:         loc_oPag.AddObject("lbl_4c_Lbl_empresa", "Label")
599:         WITH loc_oPag.lbl_4c_Lbl_empresa
600:             .Top       = 159
601:             .Left      = 191
602:             .Width     = 53
603:             .Height    = 17
604:             .Caption   = "Empresa :"
605:             .FontName  = "Tahoma"
606:             .FontSize  = 8
607:             .ForeColor = RGB(90, 90, 90)
608:             .BackStyle = 0
609:             .AutoSize  = .F.
610:             .Visible   = .T.
611:         ENDWITH
612: 
613:         loc_oPag.AddObject("txt_4c__cd_empresa", "TextBox")
614:         WITH loc_oPag.txt_4c__cd_empresa
615:             .Top      = 156
616:             .Left     = 248
617:             .Width    = 31
618:             .Height   = 23
619:             .Value    = ""
620:             .FontName = "Tahoma"
621:             .FontSize = 8
622:             .Visible  = .T.
623:         ENDWITH
624: 
625:         loc_oPag.AddObject("txt_4c__ds_empresa", "TextBox")
626:         WITH loc_oPag.txt_4c__ds_empresa
627:             .Top      = 156
628:             .Left     = 281
629:             .Width    = 290
630:             .Height   = 23
631:             .Value    = ""
632:             .FontName = "Tahoma"
633:             .FontSize = 8
634:             .Visible  = .T.
635:         ENDWITH
636: 
637:         *-- === Linha 8: Moeda ===
638:         loc_oPag.AddObject("lbl_4c_Lbl_moeda", "Label")
639:         WITH loc_oPag.lbl_4c_Lbl_moeda
640:             .Top       = 185
641:             .Left      = 200
642:             .Width     = 44
643:             .Height    = 15
644:             .Caption   = "Moeda :"
645:             .FontName  = "Tahoma"
646:             .FontSize  = 8
647:             .ForeColor = RGB(90, 90, 90)
648:             .BackStyle = 0
649:             .AutoSize  = .F.
650:             .Visible   = .T.
651:         ENDWITH
652: 
653:         loc_oPag.AddObject("txt_4c__cd_moeda", "TextBox")
654:         WITH loc_oPag.txt_4c__cd_moeda
655:             .Top      = 181
656:             .Left     = 248
657:             .Width    = 31
658:             .Height   = 21
659:             .Value    = ""
660:             .FontName = "Tahoma"
661:             .FontSize = 8
662:             .Visible  = .T.
663:         ENDWITH
664: 
665:         loc_oPag.AddObject("txt_4c__ds_moeda", "TextBox")
666:         WITH loc_oPag.txt_4c__ds_moeda
667:             .Top      = 181
668:             .Left     = 281
669:             .Width    = 290
670:             .Height   = 21
671:             .Value    = ""
672:             .FontName = "Tahoma"
673:             .FontSize = 8

*-- Linhas 1640 a 1658:
1640:         ENDIF
1641:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1642:         WITH THIS.this_oRelatorio
1643:             loc_oPag.obj_4c_Opt_oper.Value  = .this_nOper
1644:             loc_oPag.txt_4c_Grupo.Value     = ALLTRIM(.this_cGrupo)
1645:             loc_oPag.txt_4c__Ds_Grupo.Value = ALLTRIM(.this_cDsGrupo)
1646:             loc_oPag.txt_4c_Conta.Value     = ALLTRIM(.this_cConta)
1647:             loc_oPag.txt_4c_DCONTA.Value    = ALLTRIM(.this_cDConta)
1648:             loc_oPag.txt_4c_Sgrupo.Value    = ALLTRIM(.this_cSgrupo)
1649:             loc_oPag.txt_4c_Dsgrupo.Value   = ALLTRIM(.this_cDsgrupo)
1650:             loc_oPag.txt_4c_Sconta.Value    = ALLTRIM(.this_cSconta)
1651:             loc_oPag.txt_4c_DsConta.Value   = ALLTRIM(.this_cDsConta)
1652:             loc_oPag.txt_4c__dt_inicial.Value = .this_dDtInicial
1653:             loc_oPag.txt_4c__dt_final.Value   = .this_dDtFinal
1654:             loc_oPag.txt_4c__cd_empresa.Value = ALLTRIM(.this_cCdEmpresa)
1655:             loc_oPag.txt_4c__ds_empresa.Value = ALLTRIM(.this_cDsEmpresa)
1656:             loc_oPag.txt_4c__cd_moeda.Value   = ALLTRIM(.this_cCdMoeda)
1657:             loc_oPag.txt_4c__ds_moeda.Value   = ALLTRIM(.this_cDsMoeda)
1658:         ENDWITH


### BO (C:\4c\projeto\app\classes\sigrecrpBO.prg):
*==============================================================================
* SIGRECRPBO.PRG
* Business Object para SIGRECRP - Debitos e Creditos em Aberto
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigrecrpBO AS RelatorioBase

    this_cArquivoFRX    = ""
    this_cTitulo        = ""
    this_cCursorDados   = "cursor_4c_Dados"
    this_lMensagemAviso = .F.

    *-- Opcao: 1=Debito (D), 2=Credito (C)
    this_nOper          = 1

    *-- Grupo conta contabil principal
    this_cGrupo         = ""
    this_cDsGrupo       = ""

    *-- Conta contabil principal
    this_cConta         = ""
    this_cDConta        = ""

    *-- Subgrupo contra partida
    this_cSgrupo        = ""
    this_cDsgrupo       = ""

    *-- Subconta contra partida
    this_cSconta        = ""
    this_cDsConta       = ""

    *-- Empresa
    this_cCdEmpresa     = ""
    this_cDsEmpresa     = ""

    *-- Periodo de vencimento
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Moeda
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "RelSigrecrp.frx"
        THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de D" + CHR(233) + "bitos/Cr" + CHR(233) + "ditos Pendentes"
        THIS.this_dDtInicial  = DATE()
        THIS.this_dDtFinal    = DATE()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa processamento e popula cursor_4c_Dados e cursor_4c_Cabecalho
    * Replica logica completa do procedimento "processamento" do SIGRECRP.SCX
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_nResult, loc_cSQL
        LOCAL loc_nOper, loc_cOperacao
        LOCAL loc_cGrupo, loc_cConta, loc_cSgrupo, loc_cSconta
        LOCAL loc_cCdEmpresa, loc_cMoeda
        LOCAL loc_cCbEmpresa, loc_cCbTitulo, loc_cCbPeriodo
        LOCAL loc_nX, loc_cCampoGrupo, loc_cCampoConta
        LOCAL loc_cCodigoGrupo
        LOCAL loc_cContasCab, loc_cNomeCab, loc_dDataCab, loc_cEmpdopnums
        LOCAL loc_cEmps, loc_cDopes, loc_cNumes, loc_cHist
        LOCAL loc_nValor, loc_nTipo, loc_cOpers
        LOCAL ldInicial, ldFinal

        THIS.this_cMensagemErro  = ""
        THIS.this_lMensagemAviso = .F.

        *-- Mapear filtros das propriedades
        loc_nOper      = THIS.this_nOper
        loc_cGrupo     = ALLTRIM(THIS.this_cGrupo)
        loc_cConta     = ALLTRIM(THIS.this_cConta)
        loc_cSgrupo    = ALLTRIM(THIS.this_cSgrupo)
        loc_cSconta    = ALLTRIM(THIS.this_cSconta)
        loc_cCdEmpresa = ALLTRIM(THIS.this_cCdEmpresa)
        loc_cMoeda     = ALLTRIM(THIS.this_cCdMoeda)
        ldInicial      = THIS.this_dDtInicial
        ldFinal        = THIS.this_dDtFinal

        *-- Busca dados da empresa para cabecalho
        loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp" + ;
                   " WHERE CEmps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpEmp")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                      "Falha na Conex" + CHR(227) + "o (SigCdEmp)"
            RETURN .F.
        ENDIF
        loc_cCbEmpresa = ""
        SELECT cursor_4c_SigrecrpEmp
        IF !EOF()
            loc_cCbEmpresa = ALLTRIM(cursor_4c_SigrecrpEmp.Razas)
        ENDIF
        USE IN cursor_4c_SigrecrpEmp

        *-- Monta strings de cabecalho
        loc_cOperacao  = IIF(loc_nOper = 1, "D", "C")
        loc_cCbTitulo  = "Relat" + CHR(243) + "rio de " + ;
                         IIF(loc_nOper = 1, "D" + CHR(233) + "bitos", "Cr" + CHR(233) + "ditos") + ;
                         " Pendentes"
        loc_cCbPeriodo = " de " + DTOC(ldInicial) + " " + CHR(224) + " " + DTOC(ldFinal)
        loc_cCbTitulo  = loc_cCbTitulo + loc_cCbPeriodo

        *-- Cursor de cabecalho para o relatorio
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Cabecalho (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80))
        SET NULL OFF
        INSERT INTO cursor_4c_Cabecalho (cb_empresa, cb_titulo, cb_periodo) ;
            VALUES (loc_cCbEmpresa, loc_cCbTitulo, loc_cCbPeriodo)

        *-- Cursor principal de resultado
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Dados ( ;
            Tipo      N(1), ;
            Grupo     C(10), ;
            Conta     C(10), ;
            Nome      C(40), ;
            Empresa   C(3), ;
            Data      D, ;
            Vecto     D, ;
            Historico C(40), ;
            Integral  N(12,2), ;
            Pendente  N(12,2), ;
            Moeda     C(3))
        SET NULL OFF

        *-- Busca grupos contabeis conforme filtro
        loc_cSQL = "SELECT * FROM SigCdGcr" + ;
                   IIF(!EMPTY(loc_cGrupo), " WHERE Codigos = " + EscaparSQL(loc_cGrupo), "") + ;
                   " ORDER BY Codigos"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpGcr")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                      "Falha na Conex" + CHR(227) + "o (SigCdGcr)"
            RETURN .F.
        ENDIF

        *-- Itera grupos contabeis
        SELECT cursor_4c_SigrecrpGcr
        SCAN
            loc_cCodigoGrupo = ALLTRIM(cursor_4c_SigrecrpGcr.Codigos)

            IF USED("cursor_4c_SigrecrpMvCcr")
                SELECT cursor_4c_SigrecrpMvCcr
                ZAP
                USE IN cursor_4c_SigrecrpMvCcr
            ENDIF

            *-- Busca movimentos conta corrente (SigMvCcr)
            loc_cSQL = "SELECT a.contas, a.grupos, a.Nopers, a.Tipos," + ;
                       " a.Emps, a.Dopes, a.Numes, a.opers, a.Datas," + ;
                       " a.Valors, a.ValPags, a.Moedas, a.Vencs, a.Hists," + ;
                       " b.iclis, b.rclis" + ;
                       " FROM SigMvCcr a, SigCdCli b" + ;
                       " WHERE b.iclis = a.contas" + ;
                       IIF(!EMPTY(loc_cConta),     " AND a.Contas = "  + EscaparSQL(loc_cConta), " ") + ;
                       IIF(!EMPTY(loc_cCdEmpresa), " AND a.Emps = "    + EscaparSQL(loc_cCdEmpresa), "") + ;
                       IIF(!EMPTY(loc_cSgrupo),    " AND a.Sgrupos = " + EscaparSQL(loc_cSgrupo), " ") + ;
                       IIF(!EMPTY(loc_cSconta),    " AND a.SContas = " + EscaparSQL(loc_cSconta), " ") + ;
                       IIF(!EMPTY(loc_cMoeda),     " AND a.Moedas = "  + EscaparSQL(loc_cMoeda), " ") + ;
                       " AND a.Nopers <> 0 AND (a.Tipos = ' ' OR a.Tipos = 'X')" + ;
                       " AND a.Opers = " + EscaparSQL(loc_cOperacao) + ;
                       " AND a.grupos = " + EscaparSQL(loc_cCodigoGrupo) + ;
                       " AND a.Vencs BETWEEN ?ldInicial AND ?ldFinal" + ;
                       " ORDER BY GruConMoes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpMvCcr")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                          "Falha na Conex" + CHR(227) + "o (SigMvCcr)"
                RETURN .F.
            ENDIF

            *-- Processa movimentos conta corrente
            SELECT cursor_4c_SigrecrpMvCcr
            SCAN
                IF !EMPTY(cursor_4c_SigrecrpMvCcr.Dopes) AND ;
                   !EMPTY(cursor_4c_SigrecrpMvCcr.Numes) AND ;
                   ALLTRIM(cursor_4c_SigrecrpMvCcr.Tipos) <> "X"
                    LOOP
                ENDIF
                loc_nValor = cursor_4c_SigrecrpMvCcr.Valors - cursor_4c_SigrecrpMvCcr.ValPags
                IF loc_nValor <> 0
                    INSERT INTO cursor_4c_Dados (Tipo, Grupo, Conta, Nome, Empresa, ;
                        Data, Vecto, Historico, Integral, Pendente, Moeda) ;
                        VALUES (1, loc_cCodigoGrupo, ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.Contas), ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.RClis), ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.Emps), ;
                            NVL(cursor_4c_SigrecrpMvCcr.Datas, CTOD(SPACE(8))), ;
                            NVL(cursor_4c_SigrecrpMvCcr.Vencs, CTOD(SPACE(8))), ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.Hists), ;
                            cursor_4c_SigrecrpMvCcr.Valors, ;
                            loc_nValor, ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.Moedas))
                ENDIF
            ENDSCAN

            *-- Loop x=1 (Grupods/Contads) e x=2 (Grupoos/Contaos) - SigMvCab
            FOR loc_nX = 1 TO 2
                IF loc_nX = 1
                    loc_cCampoGrupo = "Grupods"
                    loc_cCampoConta = "Contads"
                ELSE
                    loc_cCampoGrupo = "Grupoos"
                    loc_cCampoConta = "Contaos"
                ENDIF

                loc_cSQL = "SELECT a.empdopnums, a." + loc_cCampoGrupo + ;
                           ", a." + loc_cCampoConta + ", a.Datas," + ;
                           " b.Dopes, b.ValPends, b.parcs, b.Copers, c.iclis, c.rclis" + ;
                           " FROM SigMvCab a, SigCdOpe b, SigCdCli c" + ;
                           " WHERE a." + loc_cCampoGrupo + " = " + EscaparSQL(loc_cCodigoGrupo) + ;
                           IIF(!EMPTY(loc_cConta), " AND a." + loc_cCampoConta + " = " + EscaparSQL(loc_cConta), "") + ;
                           " AND (b.Dopes = a.Dopes AND b.ValPends = 1 AND b.parcs = 1)" + ;
                           IIF(!EMPTY(loc_cCdEmpresa), " AND a.Emps = " + EscaparSQL(loc_cCdEmpresa), "") + ;
                           IIF(!EMPTY(loc_cSgrupo), " AND 0 = 1", "") + ;
                           IIF(!EMPTY(loc_cSconta), " AND 0 = 1", "") + ;
                           " AND c.iclis = a." + loc_cCampoConta + ;
                           " ORDER BY " + loc_cCampoGrupo + ", " + loc_cCampoConta
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpMvCab")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                              "Falha na Conex" + CHR(227) + "o (SigMvCab)"
                    RETURN .F.
                ENDIF

                SELECT cursor_4c_SigrecrpMvCab
                GO TOP
                SCAN
                    *-- Captura valores da linha atual de MvCab antes de entrar no SCAN interno
                    loc_cContasCab  = EVALUATE("cursor_4c_SigrecrpMvCab." + loc_cCampoConta)
                    loc_cNomeCab    = ALLTRIM(cursor_4c_SigrecrpMvCab.rclis)
                    loc_dDataCab    = cursor_4c_SigrecrpMvCab.Datas
                    loc_cEmpdopnums = ALLTRIM(cursor_4c_SigrecrpMvCab.empdopnums)

                    loc_cSQL = "SELECT a.empdopnums, a.VPags, a.Valos, a.FPags, a.Moefpgs," + ;
                               " a.Bancos, a.Agencias, a.Contas, a.Numeros, a.Nopers, a.Vencs" + ;
                               " FROM SigMvPar a" + ;
                               " WHERE a.Vencs BETWEEN ?ldInicial AND ?ldFinal" + ;
                               " AND a.empdopnums = " + EscaparSQL(loc_cEmpdopnums) + ;
                               IIF(EMPTY(loc_cMoeda), "", " AND a.Moefpgs = " + EscaparSQL(loc_cMoeda))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpMvPar")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                                  "Falha na Conex" + CHR(227) + "o (SigMvPar)"
                        RETURN .F.
                    ENDIF

                    SELECT cursor_4c_SigrecrpMvPar
                    SCAN
                        loc_cSQL = "SELECT a.FPags, a.ValPends, a.Infos, a.Grupods, a.contads" + ;
                                   " FROM SigOpFp a" + ;
                                   " WHERE a.FPags = " + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.FPags))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpOpFp")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                                      "Falha na Conex" + CHR(227) + "o (SigOpFps)"
                            RETURN .F.
                        ENDIF

                        IF (cursor_4c_SigrecrpOpFp.Valpends <> 1 OR ;
                            cursor_4c_SigrecrpMvPar.Nopers = 0) AND ;
                           cursor_4c_SigrecrpMvPar.VPags = cursor_4c_SigrecrpMvPar.Valos
                            LOOP
                        ENDIF
                        IF !EMPTY(cursor_4c_SigrecrpOpFp.Grupods) AND ;
                           !EMPTY(cursor_4c_SigrecrpOpFp.Contads) AND ;
                           cursor_4c_SigrecrpMvPar.VPags = cursor_4c_SigrecrpMvPar.Valos
                            LOOP
                        ENDIF

                        *-- Verifica cheque se forma de pagamento = "C"
                        IF ALLTRIM(cursor_4c_SigrecrpOpFp.Infos) = "C"
                            loc_cSQL = "SELECT a.UMovs FROM SigChe a" + ;
                                       " WHERE a.Bancos = "   + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.Bancos)) + ;
                                       " AND a.Agencias = "   + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.Agencias)) + ;
                                       " AND a.Contas = "     + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.Contas)) + ;
                                       " AND a.ncheques = "   + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.Numeros))
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpChe")
                            IF loc_nResult < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                                          "Falha na Conex" + CHR(227) + "o (SigChe)"
                                RETURN .F.
                            ENDIF

                            loc_cSQL = "SELECT a.operacaos FROM SigCdOpt a" + ;
                                       " WHERE a.Operacaos = " + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpChe.UMovs)) + ;
                                       " AND a.Tipos = 'DB'"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpOpt")
                            IF loc_nResult < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                                          "Falha na Conex" + CHR(227) + "o (SigCdOpt)"
                                RETURN .F.
                            ENDIF

                            SELECT cursor_4c_SigrecrpOpt
                            GO TOP
                            IF EOF()
                                SELECT cursor_4c_SigrecrpMvPar
                                LOOP
                            ENDIF
                        ENDIF

                        *-- Determina direcao da operacao (D=debito, C=credito)
                        IF cursor_4c_SigrecrpOpFp.Valpends <> 1 AND ;
                           cursor_4c_SigrecrpMvPar.VPags <> cursor_4c_SigrecrpMvPar.Valos
                            loc_cOpers = IIF(cursor_4c_SigrecrpMvCab.Copers = 1, "C", "D")
                        ELSE
                            loc_cOpers = IIF(cursor_4c_SigrecrpMvCab.Copers = 1, "D", "C")
                        ENDIF

                        *-- Filtra por tipo de operacao solicitado
                        IF (loc_nOper = 1 AND loc_cOpers = "C") OR ;
                           (loc_nOper = 2 AND loc_cOpers = "D")
                            SELECT cursor_4c_SigrecrpMvPar
                            LOOP
                        ENDIF

                        loc_cEmps  = SUBSTR(ALLTRIM(cursor_4c_SigrecrpMvPar.empdopnums), 1, 3)
                        loc_cDopes = SUBSTR(ALLTRIM(cursor_4c_SigrecrpMvPar.empdopnums), 4, 20)
                        loc_cNumes = SUBSTR(ALLTRIM(cursor_4c_SigrecrpMvPar.empdopnums), 24, 6)
                        loc_cHist  = ALLTRIM(cursor_4c_SigrecrpMvPar.FPags) + " " + ;
                                     loc_cEmps + ALLTRIM(loc_cDopes) + " " + ALLTRIM(loc_cNumes)
                        loc_nValor = cursor_4c_SigrecrpMvPar.Valos - cursor_4c_SigrecrpMvPar.VPags

                        IF loc_nValor = 0
                            SELECT cursor_4c_SigrecrpMvPar
                            LOOP
                        ENDIF

                        INSERT INTO cursor_4c_Dados (Tipo, Grupo, Conta, Nome, Empresa, ;
                            Data, Vecto, Historico, Integral, Pendente, Moeda) ;
                            VALUES (1, loc_cCodigoGrupo, ALLTRIM(loc_cContasCab), ;
                                ALLTRIM(loc_cNomeCab), ALLTRIM(loc_cEmps), ;
                                loc_dDataCab, cursor_4c_SigrecrpMvPar.Vencs, ;
                                ALLTRIM(loc_cHist), cursor_4c_SigrecrpMvPar.Valos, ;
                                loc_nValor, ALLTRIM(cursor_4c_SigrecrpMvPar.Moefpgs))

                        SELECT cursor_4c_SigrecrpMvPar
                    ENDSCAN

                    IF USED("cursor_4c_SigrecrpMvPar")
                        USE IN cursor_4c_SigrecrpMvPar
                    ENDIF

                    SELECT cursor_4c_SigrecrpMvCab
                ENDSCAN

                IF USED("cursor_4c_SigrecrpMvCab")
                    USE IN cursor_4c_SigrecrpMvCab
                ENDIF
            ENDFOR

            SELECT cursor_4c_SigrecrpGcr
        ENDSCAN

        IF USED("cursor_4c_SigrecrpGcr")
            USE IN cursor_4c_SigrecrpGcr
        ENDIF
        IF USED("cursor_4c_SigrecrpMvCcr")
            USE IN cursor_4c_SigrecrpMvCcr
        ENDIF

        *-- Verifica se ha dados no resultado
        SELECT cursor_4c_Dados
        INDEX ON STR(Tipo, 1) + Empresa + Grupo + Conta + DTOS(Vecto) TAG GruConVec
        GO TOP
        IF EOF()
            THIS.this_cMensagemErro  = "N" + CHR(227) + "o h" + CHR(225) + " " + ;
                IIF(loc_nOper = 1, "D" + CHR(233) + "bitos", "Cr" + CHR(233) + "ditos") + ;
                " pendente nesta conta!"
            THIS.this_lMensagemAviso = .T.
            RETURN .F.
        ENDIF

        *-- Totaliza por moeda e insere linhas de totalizacao
        IF USED("cursor_4c_SigrecrpTotaliza")
            USE IN cursor_4c_SigrecrpTotaliza
        ENDIF
        SELECT Moeda, SUM(Integral) AS Integral, SUM(Pendente) AS Pendente ;
            FROM cursor_4c_Dados ;
            GROUP BY Moeda ;
            ORDER BY Moeda ;
            INTO CURSOR cursor_4c_SigrecrpTotaliza

        loc_nTipo = 2
        SELECT cursor_4c_SigrecrpTotaliza
        SCAN
            SELECT cursor_4c_Dados
            INSERT INTO cursor_4c_Dados (Tipo, Moeda, Pendente, Integral) ;
                VALUES (loc_nTipo, ALLTRIM(cursor_4c_SigrecrpTotaliza.Moeda), ;
                    cursor_4c_SigrecrpTotaliza.Pendente, ;
                    cursor_4c_SigrecrpTotaliza.Integral)
            IF loc_nTipo = 2
                loc_nTipo = 3
            ENDIF
            SELECT cursor_4c_SigrecrpTotaliza
        ENDSCAN

        IF USED("cursor_4c_SigrecrpTotaliza")
            USE IN cursor_4c_SigrecrpTotaliza
        ENDIF

        SELECT cursor_4c_Dados
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em tela (preview)
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    IF THIS.this_lMensagemAviso
                        MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                    ENDIF
                    THIS.this_cMensagemErro = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio na impressora com dialogo de escolha
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    IF THIS.this_lMensagemAviso
                        MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                    ENDIF
                    THIS.this_cMensagemErro = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave logica do relatorio (filtros aplicados)
    * Relatorios nao tem PK fisica - chave eh composta pelos filtros.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "SIGRECRP|" + ;
                     STR(THIS.this_nOper, 1) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cConta) + "|" + ;
                     ALLTRIM(THIS.this_cSgrupo) + "|" + ;
                     ALLTRIM(THIS.this_cSconta) + "|" + ;
                     ALLTRIM(THIS.this_cCdMoeda)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de cursor
    * Permite restaurar configuracao de filtros previamente salva.
    * par_cAliasCursor: alias do cursor com colunas Oper, DtInicial, DtFinal,
    *   CdEmpresa, DsEmpresa, Grupo, DsGrupo, Conta, DConta, Sgrupo, Dsgrupo,
    *   Sconta, DsConta, CdMoeda, DsMoeda
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErr, loc_cAlias
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + ;
                                      CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                                      TRANSFORM(par_cAliasCursor)
            RETURN .F.
        ENDIF

        loc_cAlias = par_cAliasCursor

        TRY
            SELECT (loc_cAlias)
            IF !EOF()
                IF TYPE(loc_cAlias + ".Oper") = "N"
                    THIS.this_nOper = EVALUATE(loc_cAlias + ".Oper")
                ENDIF
                IF TYPE(loc_cAlias + ".DtInicial") = "D"
                    THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".DtInicial")
                ENDIF
                IF TYPE(loc_cAlias + ".DtFinal") = "D"
                    THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".DtFinal")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEmpresa") = "C"
                    THIS.this_cCdEmpresa = EVALUATE(loc_cAlias + ".CdEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmpresa") = "C"
                    THIS.this_cDsEmpresa = EVALUATE(loc_cAlias + ".DsEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".Grupo") = "C"
                    THIS.this_cGrupo = EVALUATE(loc_cAlias + ".Grupo")
                ENDIF
                IF TYPE(loc_cAlias + ".DsGrupo") = "C"
                    THIS.this_cDsGrupo = EVALUATE(loc_cAlias + ".DsGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".Conta") = "C"
                    THIS.this_cConta = EVALUATE(loc_cAlias + ".Conta")
                ENDIF
                IF TYPE(loc_cAlias + ".DConta") = "C"
                    THIS.this_cDConta = EVALUATE(loc_cAlias + ".DConta")
                ENDIF
                IF TYPE(loc_cAlias + ".Sgrupo") = "C"
                    THIS.this_cSgrupo = EVALUATE(loc_cAlias + ".Sgrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".Dsgrupo") = "C"
                    THIS.this_cDsgrupo = EVALUATE(loc_cAlias + ".Dsgrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".Sconta") = "C"
                    THIS.this_cSconta = EVALUATE(loc_cAlias + ".Sconta")
                ENDIF
                IF TYPE(loc_cAlias + ".DsConta") = "C"
                    THIS.this_cDsConta = EVALUATE(loc_cAlias + ".DsConta")
                ENDIF
                IF TYPE(loc_cAlias + ".CdMoeda") = "C"
                    THIS.this_cCdMoeda = EVALUATE(loc_cAlias + ".CdMoeda")
                ENDIF
                IF TYPE(loc_cAlias + ".DsMoeda") = "C"
                    THIS.this_cDsMoeda = EVALUATE(loc_cAlias + ".DsMoeda")
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + ;
                                          "metros vazio"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra execucao do relatorio em LogAuditoria
    * Para relatorios, "Inserir" significa registrar nova execucao,
    * permitindo rastrear quem rodou qual relatorio e quando.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar execu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Registra reexecucao do relatorio em LogAuditoria
    * Para relatorios, "Atualizar" significa registrar uma reexecucao
    * (usuario alterou filtros e gerou o relatorio novamente).
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RERUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar reexecu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de todos os cursors abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_SigrecrpEmp")
            USE IN cursor_4c_SigrecrpEmp
        ENDIF
        IF USED("cursor_4c_SigrecrpGcr")
            USE IN cursor_4c_SigrecrpGcr
        ENDIF
        IF USED("cursor_4c_SigrecrpMvCcr")
            USE IN cursor_4c_SigrecrpMvCcr
        ENDIF
        IF USED("cursor_4c_SigrecrpMvCab")
            USE IN cursor_4c_SigrecrpMvCab
        ENDIF
        IF USED("cursor_4c_SigrecrpMvPar")
            USE IN cursor_4c_SigrecrpMvPar
        ENDIF
        IF USED("cursor_4c_SigrecrpOpFp")
            USE IN cursor_4c_SigrecrpOpFp
        ENDIF
        IF USED("cursor_4c_SigrecrpChe")
            USE IN cursor_4c_SigrecrpChe
        ENDIF
        IF USED("cursor_4c_SigrecrpOpt")
            USE IN cursor_4c_SigrecrpOpt
        ENDIF
        IF USED("cursor_4c_SigrecrpTotaliza")
            USE IN cursor_4c_SigrecrpTotaliza
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

