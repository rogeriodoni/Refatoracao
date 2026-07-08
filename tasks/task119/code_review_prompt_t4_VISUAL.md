# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [LAYOUT-POSITION] Controle 'optGtprel' (parent: SIGREIFV): Top original=84 vs migrado 'obj_4c_OptGtprel' Top=0 (diff=84px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optGtprel' (parent: SIGREIFV): Left original=161 vs migrado 'obj_4c_OptGtprel' Left=0 (diff=161px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_moeda' (parent: SIGREIFV): Top original=189 vs migrado 'lbl_4c_Lbl_moeda' Top=104 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'CmdApgEmp' (parent: SIGREIFV): Top original=372 vs migrado 'cmd_4c_CmdApgEmp' Top=287 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'cmdSelemp' (parent: SIGREIFV): Top original=332 vs migrado 'cmd_4c_CmdSelemp' Top=247 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIfv.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1922 linhas total):

*-- Linhas 14 a 22:
14: *   - Grupo de Estoque (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o)
15: *   - Conta de Estoque (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o)
16: *   - N" + CHR(250) + "mero de Barra/Etiqueta - apenas tipo Consulta Barra
17: *   - Grid de empresas com CheckBox de sele" + CHR(231) + CHR(227) + "o - apenas tipo Sint" + CHR(233) + "tico
18: *
19: * FASE 7/8 - Eventos Principais (COMPLETO)
20: *   * Propriedades visuais do form (exatas do original)
21: *   * Init() / InicializarForm() / Destroy()
22: *   * ConfigurarCabecalho() (cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo)

*-- Linhas 71 a 79:
71:         loc_lSucesso   = .F.
72:         loc_lContinuar = .T.
73:         TRY
74:             THIS.Caption = "Relat" + CHR(243) + "rio de Fechamento de Invent" + CHR(225) + "rio"
75: 
76:             IF TYPE("gc_4c_CaminhoIcones") = "U"
77:                 gc_4c_CaminhoIcones = ""
78:             ENDIF
79:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 111 a 120:
111:                 *-- BINDEVENTs dos campos de filtro (primeira metade: empresa, datas)
112:                 THIS.ConfigurarPaginaDados()
113: 
114:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
115:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
116: 
117:                 THIS.LimparCampos()
118:                 THIS.Visible = .T.
119:                 loc_lSucesso = .T.
120:             ENDIF

*-- Linhas 135 a 213:
135:     PROTECTED PROCEDURE ConfigurarCabecalho()
136:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
137:         WITH THIS.cnt_4c_Cabecalho
138:             .Top         = 0
139:             .Left        = 0
140:             .Width       = THIS.Width
141:             .Height      = 80
142:             .BackStyle   = 1
143:             .BackColor   = RGB(100, 100, 100)
144:             .BorderWidth = 0
145:             .Visible     = .T.
146: 
147:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
148:             .AddObject("lbl_4c_Sombra", "Label")
149:             WITH .lbl_4c_Sombra
150:                 .Top       = 22
151:                 .Left      = 22
152:                 .Width     = THIS.Width
153:                 .Height    = 30
154:                 .Caption   = "Relat" + CHR(243) + "rio de Fechamento de Invent" + CHR(225) + "rio"
155:                 .FontName  = "Tahoma"
156:                 .FontSize  = 14
157:                 .FontBold  = .T.
158:                 .ForeColor = RGB(0, 0, 0)
159:                 .BackStyle = 0
160:                 .Visible   = .T.
161:             ENDWITH
162: 
163:             *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
164:             .AddObject("lbl_4c_Titulo", "Label")
165:             WITH .lbl_4c_Titulo
166:                 .Top       = 20
167:                 .Left      = 20
168:                 .Width     = THIS.Width
169:                 .Height    = 30
170:                 .Caption   = "Relat" + CHR(243) + "rio de Fechamento de Invent" + CHR(225) + "rio"
171:                 .FontName  = "Tahoma"
172:                 .FontSize  = 14
173:                 .FontBold  = .T.
174:                 .ForeColor = RGB(255, 255, 255)
175:                 .BackStyle = 0
176:                 .Visible   = .T.
177:             ENDWITH
178:         ENDWITH
179:     ENDPROC
180: 
181:     *--------------------------------------------------------------------------
182:     * ConfigurarBotoes - CommandGroup de bot" + CHR(245) + "es do relat" + CHR(243) + "rio (btnReport area)
183:     *   Original: btnReport.Left=529, Height=80, Width=273
184:     *   Bot" + CHR(245) + "es: Visualizar(5) / Imprimir(71) / Excel(137) / Encerrar(203)
185:     *   Eventos Click vinculados em ConfigurarPaginaDados() via BINDEVENT.
186:     *--------------------------------------------------------------------------
187:     PROTECTED PROCEDURE ConfigurarBotoes()
188:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
189:         WITH THIS.cmg_4c_Botoes
190:             .Top           = 0
191:             .Left          = 529
192:             .Width         = 273
193:             .Height        = 80
194:             .ButtonCount   = 4
195:             .BackStyle     = 0
196:             .BorderStyle   = 0
197:             .BorderColor   = RGB(136, 189, 188)
198:             .SpecialEffect = 1
199:             .Themes        = .F.
200:             .Visible       = .T.
201: 
202:             *-- Visualizar (preview em tela)
203:             WITH .Buttons(1)
204:                 .Top             = 5
205:                 .Left            = 5
206:                 .Width           = 65
207:                 .Height          = 70
208:                 .Caption         = "Visualizar"
209:                 .FontBold        = .T.
210:                 .FontItalic      = .T.
211:                 .BackColor       = RGB(255, 255, 255)
212:                 .ForeColor       = RGB(90, 90, 90)
213:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 221 a 233:
221: 
222:             *-- Imprimir (impressora padr" + CHR(227) + "o)
223:             WITH .Buttons(2)
224:                 .Top             = 5
225:                 .Left            = 71
226:                 .Width           = 65
227:                 .Height          = 70
228:                 .Caption         = "Imprimir"
229:                 .FontName        = "Tahoma"
230:                 .FontBold        = .T.
231:                 .FontItalic      = .T.
232:                 .FontSize        = 8
233:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 243 a 255:
243: 
244:             *-- Excel (exportar dados)
245:             WITH .Buttons(3)
246:                 .Top             = 5
247:                 .Left            = 137
248:                 .Width           = 65
249:                 .Height          = 70
250:                 .Caption         = "Excel"
251:                 .FontName        = "Tahoma"
252:                 .FontBold        = .T.
253:                 .FontItalic      = .T.
254:                 .FontSize        = 8
255:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 265 a 277:
265: 
266:             *-- Encerrar (fechar form - ESC)
267:             WITH .Buttons(4)
268:                 .Top             = 5
269:                 .Left            = 203
270:                 .Width           = 65
271:                 .Height          = 70
272:                 .Caption         = "Encerrar"
273:                 .Cancel          = .T.
274:                 .FontName        = "Tahoma"
275:                 .FontBold        = .T.
276:                 .FontItalic      = .T.
277:                 .FontSize        = 8

*-- Linhas 303 a 318:
303:         loc_oPgf.PageCount = 1
304: 
305:         *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho ate o fim do form
306:         loc_oPgf.Top    = 85
307:         loc_oPgf.Left   = -1
308:         loc_oPgf.Width  = THIS.Width + 2
309:         loc_oPgf.Height = THIS.Height - 85
310:         loc_oPgf.Tabs   = .F.
311: 
312:         *-- Configurar Page1 (FORA de qualquer WITH - usar refer" + CHR(234) + "ncia direta)
313:         loc_oPgf.Page1.Caption   = "Filtros"
314:         loc_oPgf.Page1.FontName  = "Tahoma"
315:         loc_oPgf.Page1.FontSize  = 8
316:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
317:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
318:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 345 a 450:
345:             .Visible     = .T.
346: 
347:             WITH .Buttons(1)
348:                 .Caption  = "Anal" + CHR(237) + "tico"
349:                 .Top      = 0
350:                 .Left     = 0
351:                 .Width    = 80
352:                 .Height   = 27
353:                 .AutoSize = .F.
354:             ENDWITH
355:             WITH .Buttons(2)
356:                 .Caption  = "Sint" + CHR(233) + "tico"
357:                 .Top      = 0
358:                 .Left     = 83
359:                 .Width    = 80
360:                 .Height   = 27
361:                 .AutoSize = .F.
362:                 .FontName = "Tahoma"
363:                 .FontSize = 8
364:             ENDWITH
365:             WITH .Buttons(3)
366:                 .Caption  = "Consulta Barra"
367:                 .Top      = 0
368:                 .Left     = 163
369:                 .Width    = 84
370:                 .Height   = 27
371:                 .AutoSize = .F.
372:                 .FontName = "Tahoma"
373:                 .FontSize = 8
374:             ENDWITH
375: 
376:             *-- Top/Left definidos apos os Buttons para evitar confusao do parser com WITHs aninhados
377:             .Top  = 0
378:             .Left = 161
379:         ENDWITH
380: 
381:         *-- Label "Tipo :" (Say2 original: Top=90, Left=131)
382:         loc_oPag.AddObject("lbl_4c_Label2", "Label")
383:         WITH loc_oPag.lbl_4c_Label2
384:             .Top       = 10
385:             .Left      = 131
386:             .Width     = 29
387:             .Height    = 18
388:             .Caption   = "Tipo :"
389:             .FontName  = "Tahoma"
390:             .FontSize  = 8
391:             .ForeColor = RGB(90, 90, 90)
392:             .BackStyle = 0
393:             .Visible   = .T.
394:         ENDWITH
395: 
396:         *-- Label "Barra :" (Label4 original: Top=114, Left=125) - Tipo=3 only
397:         loc_oPag.AddObject("lbl_4c_Barra", "Label")
398:         WITH loc_oPag.lbl_4c_Barra
399:             .Top       = 29
400:             .Left      = 125
401:             .Width     = 35
402:             .Height    = 15
403:             .Caption   = "Barra :"
404:             .FontName  = "Tahoma"
405:             .FontSize  = 8
406:             .ForeColor = RGB(90, 90, 90)
407:             .BackStyle = 0
408:             .Visible   = .F.
409:         ENDWITH
410: 
411:         *-- Campo N" + CHR(250) + "mero de Barra/Etiqueta (GetiBarra original: Top=110, Left=164, Width=67)
412:         *   When original: OptGtpRel.Value = 3
413:         loc_oPag.AddObject("txt_4c_IBarra", "TextBox")
414:         WITH loc_oPag.txt_4c_IBarra
415:             .Top      = 25
416:             .Left     = 164
417:             .Width    = 67
418:             .Height   = 23
419:             .Value    = 0
420:             .FontName = "Tahoma"
421:             .FontSize = 8
422:             .Visible  = .F.
423:         ENDWITH
424: 
425:         *-- Label "Empresa :" (Say3 original: Top=139, Left=110) - Tipo=1 e Tipo=3
426:         loc_oPag.AddObject("lbl_4c_Label3", "Label")
427:         WITH loc_oPag.lbl_4c_Label3
428:             .Top       = 59
429:             .Left      = 110
430:             .Width     = 52
431:             .Height    = 18
432:             .Caption   = "Empresa :"
433:             .FontName  = "Tahoma"
434:             .FontSize  = 8
435:             .ForeColor = RGB(90, 90, 90)
436:             .BackStyle = 0
437:             .Visible   = .T.
438:         ENDWITH
439: 
440:         *-- Campo c" + CHR(243) + "digo da Empresa (Get_Empresa original: Top=135, Left=164, Width=33)
441:         *   When original: InList(OptGtpRel.Value, 1, 3)
442:         loc_oPag.AddObject("txt_4c_Empresa", "TextBox")
443:         WITH loc_oPag.txt_4c_Empresa
444:             .Top       = 55
445:             .Left      = 164
446:             .Width     = 33
447:             .Height    = 23
448:             .Value     = ""
449:             .InputMask = "XXX"
450:             .FontName  = "Tahoma"

*-- Linhas 456 a 670:
456:         *   When original: Empty(Get_Empresa.Value)
457:         loc_oPag.AddObject("txt_4c_Dempresa", "TextBox")
458:         WITH loc_oPag.txt_4c_Dempresa
459:             .Top      = 55
460:             .Left     = 197
461:             .Width    = 205
462:             .Height   = 23
463:             .Value    = ""
464:             .FontName = "Tahoma"
465:             .FontSize = 8
466:             .Visible  = .T.
467:         ENDWITH
468: 
469:         *-- Label "Data Base:" (Say1 original: Top=164, Left=105)
470:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
471:         WITH loc_oPag.lbl_4c_Label1
472:             .Top       = 84
473:             .Left      = 105
474:             .Width     = 57
475:             .Height    = 18
476:             .Caption   = "Data Base:"
477:             .FontName  = "Tahoma"
478:             .FontSize  = 8
479:             .ForeColor = RGB(90, 90, 90)
480:             .BackStyle = 0
481:             .Visible   = .T.
482:         ENDWITH
483: 
484:         *-- Campo Data Base MM/YYYY (Get_DtBase original: Top=160, Left=164, Width=59)
485:         *   Busca em CsBases (datas base dispon" + CHR(237) + "veis no sistema)
486:         *   Formato: MM/AAAA conforme Right(value,4)+Left(value,2) no c" + CHR(243) + "digo original
487:         loc_oPag.AddObject("txt_4c_DtBase", "TextBox")
488:         WITH loc_oPag.txt_4c_DtBase
489:             .Top       = 80
490:             .Left      = 164
491:             .Width     = 59
492:             .Height    = 23
493:             .Value     = ""
494:             .InputMask = "99/9999"
495:             .FontName  = "Tahoma"
496:             .FontSize  = 8
497:             .Visible   = .T.
498:         ENDWITH
499: 
500:         *-- Label "Data Base Anterior :" (Say4 original: Top=164, Left=267) - Tipo=2 only
501:         loc_oPag.AddObject("lbl_4c_DtBaseAnt", "Label")
502:         WITH loc_oPag.lbl_4c_DtBaseAnt
503:             .Top       = 84
504:             .Left      = 267
505:             .Width     = 100
506:             .Height    = 18
507:             .Caption   = "Data Base Anterior :"
508:             .FontName  = "Tahoma"
509:             .FontSize  = 8
510:             .ForeColor = RGB(90, 90, 90)
511:             .BackStyle = 0
512:             .Visible   = .F.
513:         ENDWITH
514: 
515:         *-- Campo Data Base Anterior MM/YYYY (Get_dtBasea original: Top=160, Left=370, Width=59)
516:         *   When original: OptGtpRel.Value = 2 (Tipo Sint" + CHR(233) + "tico)
517:         loc_oPag.AddObject("txt_4c_DtBasea", "TextBox")
518:         WITH loc_oPag.txt_4c_DtBasea
519:             .Top       = 80
520:             .Left      = 370
521:             .Width     = 59
522:             .Height    = 23
523:             .Value     = ""
524:             .InputMask = "99/9999"
525:             .FontName  = "Tahoma"
526:             .FontSize  = 8
527:             .Visible   = .F.
528:         ENDWITH
529: 
530:         *-- Label "Moeda :" (lbl_moeda original: Top=189, Left=119, Width=41)
531:         loc_oPag.AddObject("lbl_4c_Lbl_moeda", "Label")
532:         WITH loc_oPag.lbl_4c_Lbl_moeda
533:             .Top       = 104
534:             .Left      = 119
535:             .Width     = 41
536:             .Height    = 18
537:             .Caption   = "Moeda :"
538:             .FontName  = "Tahoma"
539:             .FontSize  = 8
540:             .ForeColor = RGB(90, 90, 90)
541:             .BackStyle = 0
542:             .Visible   = .T.
543:         ENDWITH
544: 
545:         *-- Campo c" + CHR(243) + "digo da Moeda (get_cd_moeda original: Top=185, Left=164, Width=31)
546:         *   When original: InList(OptGtpRel.Value, 1, 2)
547:         loc_oPag.AddObject("txt_4c__cd_moeda", "TextBox")
548:         WITH loc_oPag.txt_4c__cd_moeda
549:             .Top      = 105
550:             .Left     = 164
551:             .Width    = 31
552:             .Height   = 23
553:             .Value    = ""
554:             .FontName = "Tahoma"
555:             .FontSize = 8
556:             .Visible  = .T.
557:         ENDWITH
558: 
559:         *-- Campo descri" + CHR(231) + CHR(227) + "o da Moeda (get_ds_moeda original: Top=185, Left=197, Width=115)
560:         *   When original: Empty(get_cd_moeda.Value) AND InList(OptGtpRel.Value, 1, 2)
561:         loc_oPag.AddObject("txt_4c__ds_moeda", "TextBox")
562:         WITH loc_oPag.txt_4c__ds_moeda
563:             .Top      = 105
564:             .Left     = 197
565:             .Width    = 115
566:             .Height   = 23
567:             .Value    = ""
568:             .FontName = "Tahoma"
569:             .FontSize = 8
570:             .Visible  = .T.
571:         ENDWITH
572: 
573:         *-- Label "Grupo  :" (Say5 original: Top=215, Left=119, Width=41)
574:         loc_oPag.AddObject("lbl_4c_Label5", "Label")
575:         WITH loc_oPag.lbl_4c_Label5
576:             .Top       = 135
577:             .Left      = 119
578:             .Width     = 41
579:             .Height    = 15
580:             .Caption   = "Grupo  :"
581:             .FontName  = "Tahoma"
582:             .FontSize  = 8
583:             .ForeColor = RGB(90, 90, 90)
584:             .BackStyle = 0
585:             .Visible   = .T.
586:         ENDWITH
587: 
588:         *-- Campo c" + CHR(243) + "digo do Grupo de Estoque (get_Cd_GrEstoque: Top=210, Left=164, Width=80)
589:         loc_oPag.AddObject("txt_4c__Cd_GrEstoque", "TextBox")
590:         WITH loc_oPag.txt_4c__Cd_GrEstoque
591:             .Top      = 130
592:             .Left     = 164
593:             .Width    = 80
594:             .Height   = 25
595:             .Value    = ""
596:             .FontName = "Tahoma"
597:             .FontSize = 8
598:             .Visible  = .T.
599:         ENDWITH
600: 
601:         *-- Campo descri" + CHR(231) + CHR(227) + "o do Grupo de Estoque (get_Ds_GrEstoque: Top=210, Left=246, Width=290)
602:         *   When original: Empty(get_Cd_GrEstoque.Value)
603:         loc_oPag.AddObject("txt_4c__Ds_GrEstoque", "TextBox")
604:         WITH loc_oPag.txt_4c__Ds_GrEstoque
605:             .Top      = 130
606:             .Left     = 246
607:             .Width    = 290
608:             .Height   = 25
609:             .Value    = ""
610:             .FontName = "Tahoma"
611:             .FontSize = 8
612:             .Visible  = .T.
613:         ENDWITH
614: 
615:         *-- Label "Conta :" (Say7 original: Top=242, Left=122, Width=38)
616:         loc_oPag.AddObject("lbl_4c_Label7", "Label")
617:         WITH loc_oPag.lbl_4c_Label7
618:             .Top       = 162
619:             .Left      = 122
620:             .Width     = 38
621:             .Height    = 15
622:             .Caption   = "Conta :"
623:             .FontName  = "Tahoma"
624:             .FontSize  = 8
625:             .ForeColor = RGB(90, 90, 90)
626:             .BackStyle = 0
627:             .Visible   = .T.
628:         ENDWITH
629: 
630:         *-- Campo c" + CHR(243) + "digo da Conta de Estoque (Get_Cd_Estoque: Top=237, Left=164, Width=80)
631:         loc_oPag.AddObject("txt_4c_Cd_Estoque", "TextBox")
632:         WITH loc_oPag.txt_4c_Cd_Estoque
633:             .Top      = 157
634:             .Left     = 164
635:             .Width    = 80
636:             .Height   = 25
637:             .Value    = ""
638:             .FontName = "Tahoma"
639:             .FontSize = 8
640:             .Visible  = .T.
641:         ENDWITH
642: 
643:         *-- Campo descri" + CHR(231) + CHR(227) + "o da Conta de Estoque (Get_Ds_Estoque: Top=237, Left=246, Width=290)
644:         *   When original: Empty(Get_Cd_Estoque.Value)
645:         loc_oPag.AddObject("txt_4c_Ds_Estoque", "TextBox")
646:         WITH loc_oPag.txt_4c_Ds_Estoque
647:             .Top      = 157
648:             .Left     = 246
649:             .Width    = 290
650:             .Height   = 25
651:             .Value    = ""
652:             .FontName = "Tahoma"
653:             .FontSize = 8
654:             .Visible  = .T.
655:         ENDWITH
656: 
657:         *-- Grid de sele" + CHR(231) + CHR(227) + "o de Empresas (GrdEmp original: Top=266, Left=163, W=342, H=147)
658:         *   3 colunas: CheckBox(lMarca) | C" + CHR(243) + "d.(CEmps) | Nome da Empresa(DEmps)
659:         *   Vis" + CHR(237) + "vel apenas quando Tipo=2 (Sint" + CHR(233) + "tico)
660:         *   Ordem OBRIGAT" + CHR(211) + "RIA da Column1: AddObject(Check1) -> CurrentControl -> ControlSource
661:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
662:         loc_oGrd = loc_oPag.grd_4c_Dados
663:         WITH loc_oGrd
664:             .Top                = 186
665:             .Left               = 163
666:             .Width              = 342
667:             .Height             = 147
668:             .ColumnCount        = 3
669:             .FontName           = "Verdana"
670:             .FontSize           = 8

*-- Linhas 683 a 752:
683:             WITH .Column1
684:                 .Width           = 25
685:                 .Resizable       = .F.
686:                 .Header1.Caption = ""
687:                 .AddObject("Check1", "CheckBox")
688:                 .Check1.Caption  = ""
689:                 .Check1.Value    = 0
690:                 .CurrentControl  = "Check1"
691:             ENDWITH
692: 
693:             WITH .Column2
694:                 .Width           = 60
695:                 .Resizable       = .F.
696:                 .Header1.Caption = "C" + CHR(243) + "d."
697:             ENDWITH
698: 
699:             WITH .Column3
700:                 .Width           = 250
701:                 .Resizable       = .T.
702:                 .Header1.Caption = "Nome da Empresa"
703:             ENDWITH
704:         ENDWITH
705: 
706:         *-- RecordSource e ControlSource ap" + CHR(243) + "s WITH (evita reset de cabe" + CHR(231) + "alhos)
707:         *   ControlSource da Column1 DEPOIS de CurrentControl (regra Error 1767)
708:         IF USED("CsSigCdEmp")
709:             loc_oGrd.RecordSource          = "CsSigCdEmp"
710:             loc_oGrd.Column1.ControlSource = "CsSigCdEmp.lMarca"
711:             loc_oGrd.Column2.ControlSource = "CsSigCdEmp.CEmps"
712:             loc_oGrd.Column3.ControlSource = "CsSigCdEmp.Razas"
713:             loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "d."
714:             loc_oGrd.Column3.Header1.Caption = "Nome da Empresa"
715:         ENDIF
716: 
717:         *-- Bot" + CHR(227) + "o Marcar Todas as Empresas (cmdSelemp original: Top=332, Left=508, W=40, H=40)
718:         loc_oPag.AddObject("cmd_4c_CmdSelemp", "CommandButton")
719:         WITH loc_oPag.cmd_4c_CmdSelemp
720:             .Top           = 247
721:             .Left          = 508
722:             .Width         = 40
723:             .Height        = 40
724:             .Caption       = ""
725:             .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
726:             .ToolTipText   = "Marcar Todas as Empresas"
727:             .FontName      = "Tahoma"
728:             .FontSize      = 8
729:             .Themes        = .F.
730:             .SpecialEffect = 0
731:             .MousePointer  = 15
732:             .Visible       = .F.
733:         ENDWITH
734: 
735:         *-- Bot" + CHR(227) + "o Desmarcar Todas as Empresas (CmdApgEmp original: Top=372, Left=508, W=40, H=40)
736:         loc_oPag.AddObject("cmd_4c_CmdApgEmp", "CommandButton")
737:         WITH loc_oPag.cmd_4c_CmdApgEmp
738:             .Top           = 287
739:             .Left          = 508
740:             .Width         = 40
741:             .Height        = 40
742:             .Caption       = ""
743:             .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
744:             .ToolTipText   = "Desmarcar Todas as Empresas"
745:             .FontName      = "Tahoma"
746:             .FontSize      = 8
747:             .Themes        = .F.
748:             .SpecialEffect = 0
749:             .MousePointer  = 15
750:             .Visible       = .F.
751:         ENDWITH
752:     ENDPROC

*-- Linhas 763 a 795:
763:         loc_nTipo = THIS.pgf_4c_Paginas.Page1.obj_4c_OptGtprel.Value
764:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
765: 
766:         IF loc_nTipo = 2
767:             loc_oPag.grd_4c_Dados.Visible     = .T.
768:             loc_oPag.cmd_4c_CmdApgEmp.Visible = .T.
769:             loc_oPag.cmd_4c_CmdSelemp.Visible = .T.
770:             loc_oPag.lbl_4c_Label3.Visible    = .F.
771:             loc_oPag.txt_4c_Empresa.Visible   = .F.
772:             loc_oPag.txt_4c_Dempresa.Visible  = .F.
773:             loc_oPag.lbl_4c_DtBaseAnt.Visible = .T.
774:             loc_oPag.txt_4c_DtBasea.Visible   = .T.
775:             loc_oPag.lbl_4c_Barra.Visible     = .F.
776:             loc_oPag.txt_4c_IBarra.Visible    = .F.
777:         ELSE
778:             loc_oPag.grd_4c_Dados.Visible     = .F.
779:             loc_oPag.cmd_4c_CmdApgEmp.Visible = .F.
780:             loc_oPag.cmd_4c_CmdSelemp.Visible = .F.
781:             loc_oPag.lbl_4c_Label3.Visible    = .T.
782:             loc_oPag.txt_4c_Empresa.Visible   = .T.
783:             loc_oPag.txt_4c_Dempresa.Visible  = .T.
784:             loc_oPag.lbl_4c_DtBaseAnt.Visible = .F.
785:             loc_oPag.txt_4c_DtBasea.Visible   = .F.
786:             loc_oPag.lbl_4c_Barra.Visible     = (loc_nTipo = 3)
787:             loc_oPag.txt_4c_IBarra.Visible    = (loc_nTipo = 3)
788:         ENDIF
789: 
790:         THIS.Refresh
791:     ENDPROC
792: 
793:     *--------------------------------------------------------------------------
794:     * AlternarPagina - Navega para a p" + CHR(225) + "gina especificada no PageFrame
795:     *   Este form tem 1 p" + CHR(225) + "gina (Filtros); m" + CHR(233) + "todo preparado para expans" + CHR(227) + "o

*-- Linhas 862 a 883:
862:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
863:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
864:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
865: 
866:         *-- Botoes de controle do grid de selecao de empresas (Tipo=2)
867:         BINDEVENT(loc_oPag.cmd_4c_CmdSelemp, "Click", THIS, "CmdSelempClick")
868:         BINDEVENT(loc_oPag.cmd_4c_CmdApgEmp, "Click", THIS, "CmdApgEmpClick")
869:     ENDPROC
870: 
871:     *--------------------------------------------------------------------------
872:     * LimparCampos - Reseta todos os campos de filtro para estado inicial
873:     *--------------------------------------------------------------------------
874:     PROCEDURE LimparCampos()
875:         LOCAL loc_oPag
876:         loc_oPag = THIS.pgf_4c_Paginas.Page1
877: 
878:         loc_oPag.obj_4c_OptGtprel.Value     = 1
879:         loc_oPag.txt_4c_IBarra.Value        = 0
880:         loc_oPag.txt_4c_Empresa.Value       = ""
881:         loc_oPag.txt_4c_Dempresa.Value      = ""
882:         loc_oPag.txt_4c_DtBase.Value        = ""
883:         loc_oPag.txt_4c_DtBasea.Value       = ""

*-- Linhas 1846 a 1865:
1846:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1847: 
1848:         WITH THIS.this_oRelatorio
1849:             loc_oPag.obj_4c_OptGtprel.Value     = .this_nTipo
1850:             loc_oPag.txt_4c_DtBase.Value        = .this_cDtBase
1851:             loc_oPag.txt_4c_DtBasea.Value       = .this_cDtBaseA
1852:             loc_oPag.txt_4c_Empresa.Value       = .this_cCdEmpresa
1853:             loc_oPag.txt_4c_Dempresa.Value      = .this_cDsEmpresa
1854:             loc_oPag.txt_4c__cd_moeda.Value     = .this_cCdMoeda
1855:             loc_oPag.txt_4c__ds_moeda.Value     = .this_cDsMoeda
1856:             loc_oPag.txt_4c__Cd_GrEstoque.Value = .this_cCdGrEstoque
1857:             loc_oPag.txt_4c__Ds_GrEstoque.Value = .this_cDsGrEstoque
1858:             loc_oPag.txt_4c_Cd_Estoque.Value    = .this_cCdEstoque
1859:             loc_oPag.txt_4c_Ds_Estoque.Value    = .this_cDsEstoque
1860:             loc_oPag.txt_4c_IBarra.Value        = .this_nIBarra
1861:         ENDWITH
1862: 
1863:         THIS.AjustarVisibilidadePorTipo()
1864:     ENDPROC
1865: 

*-- Linhas 1900 a 1909:
1900:             loc_oGrd.Column1.ControlSource = "CsSigCdEmp.lMarca"
1901:             loc_oGrd.Column2.ControlSource = "CsSigCdEmp.CEmps"
1902:             loc_oGrd.Column3.ControlSource = "CsSigCdEmp.Razas"
1903:             loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "d."
1904:             loc_oGrd.Column3.Header1.Caption = "Nome da Empresa"
1905:             loc_oGrd.Refresh
1906:         ENDIF
1907:     ENDPROC
1908: 
1909:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\SigReIfvBO.prg):
*==============================================================================
* SIGREIFVBO.PRG
* Business Object para Relatorio de Fechamento de Inventario
* Herda de RelatorioBase
*
* Relatorio original: SIGREIFV.SCX (frmrelatorio)
* FRX: SigReIf1 (Analitico), SigReIf0 (Sintetico), SigReIf9 (Consulta Barra)
*==============================================================================

DEFINE CLASS SigReIfvBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = ""
    this_cCampoChave    = ""
    this_cTituloRel     = "Relat" + CHR(243) + "rio de Fechamento de Invent" + CHR(225) + "rio"

    *-- Filtros: tipo de relatorio
    *-- 1 = Analitico (empresa unica)
    *-- 2 = Sintetico (multiplas empresas via grid)
    *-- 3 = Consulta Barra (por numero de etiqueta)
    this_nTipo          = 1

    *-- Filtros: datas (formato MM/YYYY - InputMask "99/9999")
    this_cDtBase        = ""
    this_cDtBaseA       = ""

    *-- Filtros: empresa (codigo + descricao)
    this_cCdEmpresa     = ""
    this_cDsEmpresa     = ""

    *-- Filtros: moeda (codigo + descricao)
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *-- Filtros: grupo de estoque/contabilidade (codigo + descricao)
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""

    *-- Filtros: conta de estoque (codigo + descricao)
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""

    *-- Filtros: numero de barra/etiqueta (apenas tipo 3)
    this_nIBarra        = 0

    *-- Nomes dos arquivos FRX por tipo
    this_cFrxAnalitico     = "SigReIf1"
    this_cFrxSintetico     = "SigReIf0"
    this_cFrxConsultaBarra = "SigReIf9"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de fechamento de inventario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosAuxiliares - Carrega cursores auxiliares para o relatorio
    * Deve ser chamado pelo Form durante InicializarForm()
    * Carrega: CrSigCdEmp, CrSigCdMoe, CrSigCdCot, CrSigBaOco, CsBases
    * Cria: CsSigCdEmp (cursor editavel para grid de selecao de empresas)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosAuxiliares()
        LOCAL loc_lSucesso, loc_oErro, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("CrSigCdEmp")
                USE IN CrSigCdEmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdEmp", "CrSigCdEmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar empresas (CrSigCdEmp)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdEmp
            INDEX ON CEmps TAG CEmps
            GO TOP

            IF USED("CrSigCdMoe")
                USE IN CrSigCdMoe
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdMoe", "CrSigCdMoe")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar moedas (CrSigCdMoe)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdMoe
            INDEX ON CMoes TAG CMoes
            GO TOP

            IF USED("CrSigCdCot")
                USE IN CrSigCdCot
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdCot", "CrSigCdCot")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar cota" + CHR(231) + CHR(245) + "es (CrSigCdCot)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdCot
            INDEX ON CMoes + DTOS(TTOD(Datas)) TAG CMoeData
            GO TOP

            IF USED("CrSigBaOco")
                USE IN CrSigBaOco
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigBaOco", "CrSigBaOco")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar ocorr" + CHR(234) + "ncias (CrSigBaOco)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigBaOco
            INDEX ON Tipos + Codigos TAG TipCods
            GO TOP

            *-- CsBases: datas base disponiveis (para lookup de data base no form)
            IF USED("cursor_4c_IfvTmpBase")
                USE IN cursor_4c_IfvTmpBase
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_IfvTmpBase (Bases c(7))
            INSERT INTO cursor_4c_IfvTmpBase (Bases) VALUES ("  /    ")

            IF USED("cursor_4c_IfvTmpBal")
                USE IN cursor_4c_IfvTmpBal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT DtBases FROM SigCdBal WHERE DtBases IS NOT NULL", ;
                "cursor_4c_IfvTmpBal")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar bases (SigCdBal)"
                loc_lSucesso = .F.
            ENDIF

            IF USED("CsBases")
                USE IN CsBases
            ENDIF
            SELECT SUBSTR(DTOS(DtBases),5,2) + "/" + LEFT(DTOS(DtBases),4) AS Bases ;
            FROM cursor_4c_IfvTmpBal ;
            GROUP BY 1 ;
            UNION ALL ;
            SELECT Bases FROM cursor_4c_IfvTmpBase ;
            GROUP BY 1 ;
            INTO CURSOR CsBases READWRITE

            SET NULL OFF
            SELECT CsBases
            INDEX ON Bases TAG Bases
            GO TOP

            IF USED("cursor_4c_IfvTmpBal")
                USE IN cursor_4c_IfvTmpBal
            ENDIF
            IF USED("cursor_4c_IfvTmpBase")
                USE IN cursor_4c_IfvTmpBase
            ENDIF

            *-- CsSigCdEmp: cursor editavel para grid de selecao de empresas (tipo 2)
            IF USED("CsSigCdEmp")
                USE IN CsSigCdEmp
            ENDIF
            SELECT IIF(Ativas = 1, 1, 0) AS lMarca, CEmps, Razas, Ativas, Nums ;
            FROM CrSigCdEmp ;
            WHERE !EMPTY(CEmps) AND !EMPTY(Razas) ;
            INTO CURSOR CsSigCdEmp READWRITE

            SELECT CsSigCdEmp
            INDEX ON Razas TAG Razas
            INDEX ON CEmps TAG CEmps
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta os cursores de dados para o relatorio
    * Equivalente ao PROCEDURE processamento do sistema legado
    * Resultado: cursores CsCabecalho e CsRelatorio prontos para REPORT FORM
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cDtBase, loc_cDtBaseA, loc_nTipo
        LOCAL loc_cEmp, loc_cMoe, loc_cGrupo, loc_cConta, loc_nBarra
        LOCAL loc_nResult, loc_cNomeEmpresa, loc_cEmpresaCab
        LOCAL loc_cTitulo, loc_cSubTitulo, loc_lProcess

        loc_lSucesso = .F.
        TRY
            loc_cDtBase  = RIGHT(ALLTRIM(THIS.this_cDtBase), 4)  + LEFT(ALLTRIM(THIS.this_cDtBase), 2)
            loc_cDtBaseA = RIGHT(ALLTRIM(THIS.this_cDtBaseA), 4) + LEFT(ALLTRIM(THIS.this_cDtBaseA), 2)
            loc_nTipo    = THIS.this_nTipo
            loc_cEmp     = ALLTRIM(THIS.this_cCdEmpresa)
            loc_cMoe     = ALLTRIM(THIS.this_cCdMoeda)
            loc_cGrupo   = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cConta   = ALLTRIM(THIS.this_cCdEstoque)
            loc_nBarra   = THIS.this_nIBarra

            loc_cNomeEmpresa = ""
            IF USED("CrSigCdEmp")
                IF SEEK(go_4c_Sistema.cCodEmpresa, "CrSigCdEmp", "CEmps")
                    loc_cNomeEmpresa = ALLTRIM(CrSigCdEmp.Razas)
                ENDIF
            ENDIF
            loc_cEmpresaCab = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + loc_cNomeEmpresa

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (;
                Empresa   c(80), ;
                Titulo    c(80), ;
                SubTitulo c(80), ;
                DtBase    c(7),  ;
                DtBaseA   c(7)   ;
            )

            IF loc_nTipo = 3
                INSERT INTO CsCabecalho (Empresa, Titulo, SubTitulo, DtBase) ;
                VALUES (loc_cEmpresaCab, ;
                        "Consulta Barra", ;
                        ALLTRIM(STR(loc_nBarra, 8)), ;
                        THIS.this_cDtBase)
            ELSE
                loc_cTitulo = "Invent" + CHR(225) + "rio Data Base " + THIS.this_cDtBase
                IF loc_nTipo = 1
                    loc_cSubTitulo = "Lj: " + loc_cEmp + "   " + ;
                                     "Anal" + CHR(237) + "tico de Apura" + CHR(231) + CHR(227) + "o - " + loc_cMoe
                ELSE
                    loc_cSubTitulo = "Sint" + CHR(233) + "tico - " + loc_cMoe
                ENDIF
                INSERT INTO CsCabecalho (Empresa, Titulo, SubTitulo, DtBase, DtBaseA) ;
                VALUES (loc_cEmpresaCab, loc_cTitulo, loc_cSubTitulo, ;
                        THIS.this_cDtBase, THIS.this_cDtBaseA)
            ENDIF

            IF USED("CsBal")
                USE IN CsBal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdBal", "CsBal")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar balan" + CHR(231) + "o (CsBal)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CsBal
            GO TOP

            IF USED("Balancos")
                USE IN Balancos
            ENDIF

            IF loc_nTipo <> 2
                SELECT *, LEFT(DTOS(DtBases),6) AS Bases ;
                FROM CsBal ;
                ORDER BY Emps ;
                INTO CURSOR Balancos
            ELSE
                IF USED("cursor_4c_IfvEmps")
                    USE IN cursor_4c_IfvEmps
                ENDIF
                SELECT * FROM CsSigCdEmp WHERE lMarca = 1 INTO CURSOR cursor_4c_IfvEmps

                SELECT a.*, LEFT(DTOS(a.DtBases),6) AS Bases ;
                FROM CsBal a, cursor_4c_IfvEmps b ;
                WHERE a.Emps = b.CEmps ;
                ORDER BY a.Emps ;
                INTO CURSOR Balancos

                IF USED("cursor_4c_IfvEmps")
                    USE IN cursor_4c_IfvEmps
                ENDIF
            ENDIF

            DO CASE
                CASE loc_nTipo = 1
                    loc_lProcess = THIS.ProcessarAnalitico(loc_cDtBase, loc_cDtBaseA, loc_cMoe)
                CASE loc_nTipo = 2
                    loc_lProcess = THIS.ProcessarSintetico(loc_cDtBase, loc_cDtBaseA, loc_cMoe)
                OTHERWISE
                    loc_lProcess = THIS.ProcessarConsultaBarra(loc_cDtBase, loc_cMoe, loc_nBarra)
            ENDCASE

            IF loc_lProcess
                SELECT CsRelatorio
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterFrxAtual()
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterFrxAtual()
                REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFrxAtual - Retorna nome do arquivo FRX conforme tipo selecionado
    *--------------------------------------------------------------------------
    PROCEDURE ObterFrxAtual()
        DO CASE
            CASE THIS.this_nTipo = 1
                RETURN THIS.this_cFrxAnalitico
            CASE THIS.this_nTipo = 2
                RETURN THIS.this_cFrxSintetico
            OTHERWISE
                RETURN THIS.this_cFrxConsultaBarra
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - Retorna cotacao da moeda na data informada
    * Equivalente a fCarregarCambio() do sistema legado
    * Busca a cotacao mais recente <= par_dData para a moeda informada
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cMoeda
        loc_nCotacao = 1
        loc_cMoeda   = ALLTRIM(par_cMoeda)
        IF USED("CrSigCdCot") AND !EMPTY(loc_cMoeda) AND !EMPTY(par_dData)
            SELECT CrSigCdCot
            SET ORDER TO CMoeData
            IF SEEK(loc_cMoeda + DTOS(par_dData))
                loc_nCotacao = CrSigCdCot.Valos
            ELSE
                SKIP -1
                IF !BOF() AND ALLTRIM(CrSigCdCot.CMoes) = loc_cMoeda AND ;
                   TTOD(CrSigCdCot.Datas) <= par_dData
                    loc_nCotacao = CrSigCdCot.Valos
                ENDIF
            ENDIF
        ENDIF
        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarAnalitico - Processa relatorio analitico empresa unica (Tipo 1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarAnalitico(par_cDtBase, par_cDtBaseA, par_cMoe)
        LOCAL loc_nResult, loc_cSQL, loc_nCotaMCC, loc_nCotaMoe, loc_nQtdeQs, loc_lAchou

        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        CREATE CURSOR CsRelatorio (;
            Ocorrencia c(10),   Barras     n(8),    Barra2s   n(8),    ;
            CCustos    n(12,2), CCusto2s   n(12,2), DifCustos n(12,2), ;
            Ocor2s     c(10),   DesOco     c(40),   Obs2s     m,       ;
            DPros      c(40),   Pesos      n(12,2)  ;
        )
        INDEX ON Ocorrencia + STR(Barras,8) TAG Produto

        WAIT WINDOW "Aguarde! Abrindo o Balan" + CHR(231) + "o..." NOWAIT

        SELECT Balancos
        GO TOP
        SCAN
            IF USED("Tratamento")
                USE IN Tratamento
            ENDIF

            loc_cSQL = "SELECT a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia,a.Obs," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.Obs2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros,b.MoecusFs,c.CBars,c.Pesos " + ;
                       "FROM SigIvTrT a " + ;
                       "LEFT JOIN SigCdPro b ON b.CPros = a.Produto " + ;
                       "LEFT JOIN SigOpEtq c ON c.CBars = a.Barras " + ;
                       "WHERE a.Emps = '" + ALLTRIM(Balancos.Emps) + "' " + ;
                       "AND a.Codigos = " + ALLTRIM(STR(Balancos.Codigos,4)) + " " + ;
                       "ORDER BY a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros,b.MoecusFs,c.CBars,c.Pesos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "Tratamento")
            IF loc_nResult < 1
                WAIT CLEAR
                MsgErro("Falha na conex" + CHR(227) + "o (Tratamento)", "Erro")
                RETURN .F.
            ENDIF

            SELECT Tratamento
            GO TOP
            IF EOF()
                SELECT Balancos
                LOOP
            ENDIF

            WAIT WINDOW "Analisando o Tratamento..." NOWAIT

            SELECT Tratamento
            GO TOP
            SCAN
                SCATTER MEMVAR MEMO

                loc_lAchou = SEEK("O" + m.Ocorrencia, "CrSigBaOco", "TipCods")
                IF CrSigBaOco.Apuras <> "S"
                    LOOP
                ENDIF

                m.DPros  = IIF(EMPTY(m.Obs), m.DPros, m.Obs)
                m.DesOco = CrSigBaOco.Descrs

                m.MoeCusFs = NVL(m.MoeCusFs, " ")
                loc_lAchou = SEEK(m.MoeCusFs, "CrSigCdMoe", "CMoes")
                IF !EMPTY(CrSigCdMoe.MoeQs)
                    m.Moedas    = CrSigCdMoe.MoeQs
                    loc_nQtdeQs = IIF(CrSigCdMoe.QtdeQs = 0, 1, CrSigCdMoe.QtdeQs)
                ELSE
                    m.Moedas    = m.MoeCusFs
                    loc_nQtdeQs = 1
                ENDIF

                m.CCustos  = m.CCustos  * loc_nQtdeQs
                m.CCusto2s = m.CCusto2s * loc_nQtdeQs

                IF m.Moedas <> par_cMoe
                    loc_nCotaMCC = THIS.CarregarCambio(par_cMoe,  DATE())
                    loc_nCotaMoe = THIS.CarregarCambio(m.Moedas,  DATE())
                    m.CCustos  = ROUND(m.CCustos  * loc_nCotaMoe / loc_nCotaMCC, 2)
                    m.CCusto2s = ROUND(m.CCusto2s * loc_nCotaMoe / loc_nCotaMCC, 2)
                ENDIF

                m.CCustos   = m.CCustos  * IIF(CrSigBaOco.Opers = "DB", -1, 1)
                m.CCusto2s  = m.CCusto2s * IIF(CrSigBaOco.Opers = "DB", -1, 1)
                m.DifCustos = (m.CCustos - m.CCusto2s)
                m.Obs2s     = NVL(m.Obs2s, "")
                m.Pesos     = NVL(m.Pesos, 0)

                INSERT INTO CsRelatorio FROM MEMVAR

                SELECT Tratamento
            ENDSCAN

            SELECT Balancos
        ENDSCAN

        WAIT CLEAR
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarSintetico - Processa relatorio sintetico multi-empresa (Tipo 2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarSintetico(par_cDtBase, par_cDtBaseA, par_cMoe)
        LOCAL loc_nResult, loc_cSQL, loc_lAchou
        LOCAL loc_nCotaMCC, loc_nCotaMoe, loc_nQtdeQs
        LOCAL loc_cDataBase, loc_nColuna, loc_nQtde, loc_nDif
        LOCAL loc_cCusto, loc_cQtde

        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        CREATE CURSOR CsRelatorio (;
            Emps    c(3),    DtBals  d(8),    ;
            Qtde1   n(12,2), Custo1  n(12,2), ;
            Qtde2   n(12,2), Custo2  n(12,2), ;
            Qtde3   n(12,2), Custo3  n(12,2), ;
            Custo3d n(12,2), Dif3d   n(12,2), ;
            Qtde4   n(12,2), Custo4  n(12,2), ;
            Qtde5   n(12,2), Custo5  n(12,2), ;
            Contac  n(12,2)  ;
        )
        INDEX ON Emps TAG Emps

        WAIT WINDOW "Aguarde! Abrindo o Balan" + CHR(231) + "o..." NOWAIT

        SELECT Balancos
        GO TOP
        SCAN
            loc_cDataBase = Balancos.Bases
            IF USED("Tratamento")
                USE IN Tratamento
            ENDIF

            loc_cSQL = "SELECT a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia,a.Obs," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.Obs2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros,b.MoecusFs " + ;
                       "FROM SigIvTrT a " + ;
                       "LEFT JOIN SigCdPro b ON b.CPros = a.Produto " + ;
                       "WHERE a.Emps = '" + ALLTRIM(Balancos.Emps) + "' " + ;
                       "AND a.Codigos = " + ALLTRIM(STR(Balancos.Codigos,4)) + " " + ;
                       "ORDER BY a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros,b.MoecusFs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "Tratamento")
            IF loc_nResult < 1
                WAIT CLEAR
                MsgErro("Falha na conex" + CHR(227) + "o (Tratamento)", "Erro")
                RETURN .F.
            ENDIF

            SELECT Tratamento
            GO TOP
            IF EOF()
                SELECT Balancos
                LOOP
            ENDIF

            SELECT CsRelatorio
            SEEK Balancos.Emps
            IF EOF()
                INSERT INTO CsRelatorio (Emps) VALUES (ALLTRIM(Balancos.Emps))
            ENDIF
            IF loc_cDataBase = par_cDtBase
                REPLACE DtBals WITH Balancos.DataInis IN CsRelatorio
            ENDIF

            IF USED("cursor_4c_IfvConsulta")
                USE IN cursor_4c_IfvConsulta
            ENDIF
            SELECT a.*, b.Lancas, b.Opers ;
            FROM Tratamento a, CrSigBaOco b ;
            WHERE "O" + a.Ocorrencia = b.Tipos + b.Codigos AND b.Apuras = "S" ;
            INTO CURSOR cursor_4c_IfvConsulta

            WAIT WINDOW "Analisando o Tratamento..." NOWAIT

            SELECT cursor_4c_IfvConsulta
            GO TOP
            SCAN
                SELECT CsRelatorio
                SCATTER MEMVAR BLANK

                SELECT cursor_4c_IfvConsulta
                SCATTER MEMVAR MEMO

                m.MoeCusFs = NVL(m.MoeCusFs, " ")
                loc_lAchou = SEEK(m.MoeCusFs, "CrSigCdMoe", "CMoes")
                IF !EMPTY(CrSigCdMoe.MoeQs)
                    m.Moedas    = CrSigCdMoe.MoeQs
                    loc_nQtdeQs = IIF(CrSigCdMoe.QtdeQs = 0, 1, CrSigCdMoe.QtdeQs)
                ELSE
                    m.Moedas    = m.MoeCusFs
                    loc_nQtdeQs = 1
                ENDIF

                m.CCustos  = m.CCustos  * loc_nQtdeQs
                m.CCusto2s = m.CCusto2s * loc_nQtdeQs

                IF m.Moedas <> par_cMoe
                    loc_nCotaMCC = THIS.CarregarCambio(par_cMoe, DATE())
                    loc_nCotaMoe = THIS.CarregarCambio(m.Moedas, DATE())
                    m.CCustos  = ROUND(m.CCustos  * loc_nCotaMoe / loc_nCotaMCC, 2)
                    m.CCusto2s = ROUND(m.CCusto2s * loc_nCotaMoe / loc_nCotaMCC, 2)
                ENDIF

                m.CCustos  = m.CCustos  * IIF(m.Opers = "DB", -1, 1)
                m.CCusto2s = m.CCusto2s * IIF(m.Opers = "DB", -1, 1)

                loc_nDif    = (m.CCustos - m.CCusto2s)
                loc_nColuna = 0

                DO CASE
                    CASE m.Ocorrencia = "FB"
                        IF loc_cDataBase = par_cDtBase
                            loc_nColuna = 2
                        ELSE
                            loc_nColuna = 1
                        ENDIF
                    CASE m.Ocorrencia = "ET" AND loc_cDataBase = par_cDtBase
                        loc_nColuna = 3
                    CASE m.Ocorrencia = "SB" AND loc_cDataBase = par_cDtBase
                        loc_nColuna = 4
                    CASE m.Ocorrencia = "FE" AND loc_cDataBase = par_cDtBase
                        loc_nColuna = 5
                ENDCASE

                IF loc_nColuna = 0
                    SELECT cursor_4c_IfvConsulta
                    LOOP
                ENDIF

                loc_cCusto = "Custo" + STR(loc_nColuna, 1)
                loc_cQtde  = "Qtde"  + STR(loc_nColuna, 1)
                loc_nQtde  = m.Falta + m.Sobra

                SELECT CsRelatorio
                SEEK ALLTRIM(Balancos.Emps)
                IF EOF()
                    INSERT INTO CsRelatorio (Emps) VALUES (ALLTRIM(Balancos.Emps))
                ENDIF
                IF loc_cDataBase = par_cDtBase
                    REPLACE DtBals WITH Balancos.DataInis IN CsRelatorio
                ENDIF
                REPLACE &loc_cCusto. WITH &loc_cCusto. + m.CCustos, ;
                        &loc_cQtde.  WITH &loc_cQtde.  + IIF(loc_nQtde = 0, m.Apurado, (m.Falta + m.Sobra))

                IF m.Ocorrencia = "ET"
                    REPLACE Custo3d WITH Custo3d + m.CCusto2s, ;
                            Dif3d   WITH Custo3  - Custo3d
                ENDIF

                IF m.Lancas = "S" AND loc_nColuna <> 1
                    REPLACE Contac WITH Contac + loc_nDif IN CsRelatorio
                ENDIF

                SELECT cursor_4c_IfvConsulta
            ENDSCAN

            IF USED("cursor_4c_IfvConsulta")
                USE IN cursor_4c_IfvConsulta
            ENDIF

            SELECT Balancos
        ENDSCAN

        WAIT CLEAR
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarConsultaBarra - Processa consulta por numero de barra (Tipo 3)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarConsultaBarra(par_cDtBase, par_cMoe, par_nBarra)
        LOCAL loc_nResult, loc_cSQL, loc_cDataBase, loc_cObss, loc_lAchou

        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        CREATE CURSOR CsRelatorio (;
            Emps       c(3),  ;
            DtBals     d(8),  ;
            DtBases    c(7),  ;
            Ocorrencia c(10), ;
            DesOco     c(40), ;
            Obss       m      ;
        )
        INDEX ON Emps + DtBases TAG Emps

        WAIT WINDOW "Aguarde! Abrindo o Balan" + CHR(231) + "o..." NOWAIT

        SELECT Balancos
        GO TOP
        SCAN
            loc_cDataBase = RIGHT(Balancos.Bases,2) + "/" + LEFT(Balancos.Bases,4)

            IF USED("Tratamento")
                USE IN Tratamento
            ENDIF

            loc_cSQL = "SELECT a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia,a.Obs," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.Obs2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros " + ;
                       "FROM SigIvTrT a " + ;
                       "LEFT JOIN SigCdPro b ON b.CPros = a.Produto " + ;
                       "WHERE a.Emps = '" + ALLTRIM(Balancos.Emps) + "' " + ;
                       "AND a.Codigos = " + ALLTRIM(STR(Balancos.Codigos,4)) + " " + ;
                       "AND a.Barras = " + ALLTRIM(STR(par_nBarra, 8)) + " " + ;
                       "ORDER BY a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "Tratamento")
            IF loc_nResult < 1
                WAIT CLEAR
                MsgErro("Falha na conex" + CHR(227) + "o (Tratamento)", "Erro")
                RETURN .F.
            ENDIF

            SELECT Tratamento
            GO TOP
            IF EOF()
                SELECT Balancos
                LOOP
            ENDIF

            WAIT WINDOW "Analisando o Tratamento..." NOWAIT

            SELECT Tratamento
            GO TOP
            SCAN
                loc_lAchou = SEEK("O" + Tratamento.Ocorrencia, "CrSigBaOco", "TipCods")
                loc_cObss = IIF(EMPTY(Tratamento.Obs), ;
                               NVL(Tratamento.DPros, ""), ;
                               NVL(Tratamento.Obs, ""))

                INSERT INTO CsRelatorio (Emps, DtBals, DtBases, Ocorrencia, DesOco, Obss) ;
                VALUES (ALLTRIM(Balancos.Emps), Balancos.DataInis, loc_cDataBase, ;
                        ALLTRIM(Tratamento.Ocorrencia), ALLTRIM(CrSigBaOco.Descrs), loc_cObss)

                SELECT Tratamento
            ENDSCAN

            SELECT Balancos
        ENDSCAN

        WAIT CLEAR
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE

