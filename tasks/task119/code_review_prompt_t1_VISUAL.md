# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 229: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 251: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 274: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIfv.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1919 linhas total):

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

*-- Linhas 221 a 235:
221: 
222:             *-- Imprimir (impressora padr" + CHR(227) + "o)
223:             WITH .Buttons(2)
224:                 .Top             = 5
225:                 .Left            = 71
226:                 .Width           = 65
227:                 .Height          = 70
228:                 .Caption         = "Imprimir"
229:                 .FontName        = "Comic Sans MS"
230:                 .FontBold        = .T.
231:                 .FontItalic      = .T.
232:                 .FontSize        = 8
233:                 .BackColor       = RGB(255, 255, 255)
234:                 .ForeColor       = RGB(90, 90, 90)
235:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 243 a 257:
243: 
244:             *-- Excel (exportar dados)
245:             WITH .Buttons(3)
246:                 .Top             = 5
247:                 .Left            = 137
248:                 .Width           = 65
249:                 .Height          = 70
250:                 .Caption         = "Excel"
251:                 .FontName        = "Comic Sans MS"
252:                 .FontBold        = .T.
253:                 .FontItalic      = .T.
254:                 .FontSize        = 8
255:                 .BackColor       = RGB(255, 255, 255)
256:                 .ForeColor       = RGB(90, 90, 90)
257:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 265 a 280:
265: 
266:             *-- Encerrar (fechar form - ESC)
267:             WITH .Buttons(4)
268:                 .Top             = 5
269:                 .Left            = 203
270:                 .Width           = 65
271:                 .Height          = 70
272:                 .Caption         = "Encerrar"
273:                 .Cancel          = .T.
274:                 .FontName        = "Comic Sans MS"
275:                 .FontBold        = .T.
276:                 .FontItalic      = .T.
277:                 .FontSize        = 8
278:                 .BackColor       = RGB(255, 255, 255)
279:                 .ForeColor       = RGB(90, 90, 90)
280:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

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

*-- Linhas 335 a 439:
335:         *   Original: Top=84, Left=161, Width=247, Height=27, ButtonCount=3
336:         loc_oPag.AddObject("obj_4c_OptGtprel", "OptionGroup")
337:         WITH loc_oPag.obj_4c_OptGtprel
338:             .Top         = 4
339:             .Left        = 161
340:             .Width       = 247
341:             .Height      = 27
342:             .ButtonCount = 3
343:             .BackStyle   = 0
344:             .BorderStyle = 0
345:             .Themes      = .F.
346:             .Value       = 1
347:             .Visible     = .T.
348: 
349:             WITH .Buttons(1)
350:                 .Caption  = "Anal" + CHR(237) + "tico"
351:                 .Width    = 80
352:                 .Left     = 0
353:             ENDWITH
354:             WITH .Buttons(2)
355:                 .Caption  = "Sint" + CHR(233) + "tico"
356:                 .Width    = 80
357:                 .Left     = 83
358:                 .FontName = "Tahoma"
359:                 .FontSize = 8
360:             ENDWITH
361:             WITH .Buttons(3)
362:                 .Caption  = "Consulta Barra"
363:                 .Width    = 84
364:                 .Left     = 163
365:                 .FontName = "Tahoma"
366:                 .FontSize = 8
367:             ENDWITH
368:         ENDWITH
369: 
370:         *-- Label "Tipo :" (Say2 original: Top=90, Left=131)
371:         loc_oPag.AddObject("lbl_4c_Label2", "Label")
372:         WITH loc_oPag.lbl_4c_Label2
373:             .Top       = 10
374:             .Left      = 131
375:             .Width     = 29
376:             .Height    = 18
377:             .Caption   = "Tipo :"
378:             .FontName  = "Tahoma"
379:             .FontSize  = 8
380:             .ForeColor = RGB(90, 90, 90)
381:             .BackStyle = 0
382:             .Visible   = .T.
383:         ENDWITH
384: 
385:         *-- Label "Barra :" (Label4 original: Top=114, Left=125) - Tipo=3 only
386:         loc_oPag.AddObject("lbl_4c_Barra", "Label")
387:         WITH loc_oPag.lbl_4c_Barra
388:             .Top       = 29
389:             .Left      = 125
390:             .Width     = 35
391:             .Height    = 15
392:             .Caption   = "Barra :"
393:             .FontName  = "Tahoma"
394:             .FontSize  = 8
395:             .ForeColor = RGB(90, 90, 90)
396:             .BackStyle = 0
397:             .Visible   = .F.
398:         ENDWITH
399: 
400:         *-- Campo N" + CHR(250) + "mero de Barra/Etiqueta (GetiBarra original: Top=110, Left=164, Width=67)
401:         *   When original: OptGtpRel.Value = 3
402:         loc_oPag.AddObject("txt_4c_IBarra", "TextBox")
403:         WITH loc_oPag.txt_4c_IBarra
404:             .Top      = 25
405:             .Left     = 164
406:             .Width    = 67
407:             .Height   = 23
408:             .Value    = 0
409:             .FontName = "Tahoma"
410:             .FontSize = 8
411:             .Visible  = .F.
412:         ENDWITH
413: 
414:         *-- Label "Empresa :" (Say3 original: Top=139, Left=110) - Tipo=1 e Tipo=3
415:         loc_oPag.AddObject("lbl_4c_Label3", "Label")
416:         WITH loc_oPag.lbl_4c_Label3
417:             .Top       = 59
418:             .Left      = 110
419:             .Width     = 52
420:             .Height    = 18
421:             .Caption   = "Empresa :"
422:             .FontName  = "Tahoma"
423:             .FontSize  = 8
424:             .ForeColor = RGB(90, 90, 90)
425:             .BackStyle = 0
426:             .Visible   = .T.
427:         ENDWITH
428: 
429:         *-- Campo c" + CHR(243) + "digo da Empresa (Get_Empresa original: Top=135, Left=164, Width=33)
430:         *   When original: InList(OptGtpRel.Value, 1, 3)
431:         loc_oPag.AddObject("txt_4c_Empresa", "TextBox")
432:         WITH loc_oPag.txt_4c_Empresa
433:             .Top       = 55
434:             .Left      = 164
435:             .Width     = 33
436:             .Height    = 23
437:             .Value     = ""
438:             .InputMask = "XXX"
439:             .FontName  = "Tahoma"

*-- Linhas 445 a 659:
445:         *   When original: Empty(Get_Empresa.Value)
446:         loc_oPag.AddObject("txt_4c_Dempresa", "TextBox")
447:         WITH loc_oPag.txt_4c_Dempresa
448:             .Top      = 55
449:             .Left     = 197
450:             .Width    = 205
451:             .Height   = 23
452:             .Value    = ""
453:             .FontName = "Tahoma"
454:             .FontSize = 8
455:             .Visible  = .T.
456:         ENDWITH
457: 
458:         *-- Label "Data Base:" (Say1 original: Top=164, Left=105)
459:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
460:         WITH loc_oPag.lbl_4c_Label1
461:             .Top       = 84
462:             .Left      = 105
463:             .Width     = 57
464:             .Height    = 18
465:             .Caption   = "Data Base:"
466:             .FontName  = "Tahoma"
467:             .FontSize  = 8
468:             .ForeColor = RGB(90, 90, 90)
469:             .BackStyle = 0
470:             .Visible   = .T.
471:         ENDWITH
472: 
473:         *-- Campo Data Base MM/YYYY (Get_DtBase original: Top=160, Left=164, Width=59)
474:         *   Busca em CsBases (datas base dispon" + CHR(237) + "veis no sistema)
475:         *   Formato: MM/AAAA conforme Right(value,4)+Left(value,2) no c" + CHR(243) + "digo original
476:         loc_oPag.AddObject("txt_4c_DtBase", "TextBox")
477:         WITH loc_oPag.txt_4c_DtBase
478:             .Top       = 80
479:             .Left      = 164
480:             .Width     = 59
481:             .Height    = 23
482:             .Value     = ""
483:             .InputMask = "99/9999"
484:             .FontName  = "Tahoma"
485:             .FontSize  = 8
486:             .Visible   = .T.
487:         ENDWITH
488: 
489:         *-- Label "Data Base Anterior :" (Say4 original: Top=164, Left=267) - Tipo=2 only
490:         loc_oPag.AddObject("lbl_4c_DtBaseAnt", "Label")
491:         WITH loc_oPag.lbl_4c_DtBaseAnt
492:             .Top       = 84
493:             .Left      = 267
494:             .Width     = 100
495:             .Height    = 18
496:             .Caption   = "Data Base Anterior :"
497:             .FontName  = "Tahoma"
498:             .FontSize  = 8
499:             .ForeColor = RGB(90, 90, 90)
500:             .BackStyle = 0
501:             .Visible   = .F.
502:         ENDWITH
503: 
504:         *-- Campo Data Base Anterior MM/YYYY (Get_dtBasea original: Top=160, Left=370, Width=59)
505:         *   When original: OptGtpRel.Value = 2 (Tipo Sint" + CHR(233) + "tico)
506:         loc_oPag.AddObject("txt_4c_DtBasea", "TextBox")
507:         WITH loc_oPag.txt_4c_DtBasea
508:             .Top       = 80
509:             .Left      = 370
510:             .Width     = 59
511:             .Height    = 23
512:             .Value     = ""
513:             .InputMask = "99/9999"
514:             .FontName  = "Tahoma"
515:             .FontSize  = 8
516:             .Visible   = .F.
517:         ENDWITH
518: 
519:         *-- Label "Moeda :" (lbl_moeda original: Top=189, Left=119, Width=41)
520:         loc_oPag.AddObject("lbl_4c_Lbl_moeda", "Label")
521:         WITH loc_oPag.lbl_4c_Lbl_moeda
522:             .Top       = 109
523:             .Left      = 119
524:             .Width     = 41
525:             .Height    = 18
526:             .Caption   = "Moeda :"
527:             .FontName  = "Tahoma"
528:             .FontSize  = 8
529:             .ForeColor = RGB(90, 90, 90)
530:             .BackStyle = 0
531:             .Visible   = .T.
532:         ENDWITH
533: 
534:         *-- Campo c" + CHR(243) + "digo da Moeda (get_cd_moeda original: Top=185, Left=164, Width=31)
535:         *   When original: InList(OptGtpRel.Value, 1, 2)
536:         loc_oPag.AddObject("txt_4c__cd_moeda", "TextBox")
537:         WITH loc_oPag.txt_4c__cd_moeda
538:             .Top      = 105
539:             .Left     = 164
540:             .Width    = 31
541:             .Height   = 23
542:             .Value    = ""
543:             .FontName = "Tahoma"
544:             .FontSize = 8
545:             .Visible  = .T.
546:         ENDWITH
547: 
548:         *-- Campo descri" + CHR(231) + CHR(227) + "o da Moeda (get_ds_moeda original: Top=185, Left=197, Width=115)
549:         *   When original: Empty(get_cd_moeda.Value) AND InList(OptGtpRel.Value, 1, 2)
550:         loc_oPag.AddObject("txt_4c__ds_moeda", "TextBox")
551:         WITH loc_oPag.txt_4c__ds_moeda
552:             .Top      = 105
553:             .Left     = 197
554:             .Width    = 115
555:             .Height   = 23
556:             .Value    = ""
557:             .FontName = "Tahoma"
558:             .FontSize = 8
559:             .Visible  = .T.
560:         ENDWITH
561: 
562:         *-- Label "Grupo  :" (Say5 original: Top=215, Left=119, Width=41)
563:         loc_oPag.AddObject("lbl_4c_Label5", "Label")
564:         WITH loc_oPag.lbl_4c_Label5
565:             .Top       = 135
566:             .Left      = 119
567:             .Width     = 41
568:             .Height    = 15
569:             .Caption   = "Grupo  :"
570:             .FontName  = "Tahoma"
571:             .FontSize  = 8
572:             .ForeColor = RGB(90, 90, 90)
573:             .BackStyle = 0
574:             .Visible   = .T.
575:         ENDWITH
576: 
577:         *-- Campo c" + CHR(243) + "digo do Grupo de Estoque (get_Cd_GrEstoque: Top=210, Left=164, Width=80)
578:         loc_oPag.AddObject("txt_4c__Cd_GrEstoque", "TextBox")
579:         WITH loc_oPag.txt_4c__Cd_GrEstoque
580:             .Top      = 130
581:             .Left     = 164
582:             .Width    = 80
583:             .Height   = 25
584:             .Value    = ""
585:             .FontName = "Tahoma"
586:             .FontSize = 8
587:             .Visible  = .T.
588:         ENDWITH
589: 
590:         *-- Campo descri" + CHR(231) + CHR(227) + "o do Grupo de Estoque (get_Ds_GrEstoque: Top=210, Left=246, Width=290)
591:         *   When original: Empty(get_Cd_GrEstoque.Value)
592:         loc_oPag.AddObject("txt_4c__Ds_GrEstoque", "TextBox")
593:         WITH loc_oPag.txt_4c__Ds_GrEstoque
594:             .Top      = 130
595:             .Left     = 246
596:             .Width    = 290
597:             .Height   = 25
598:             .Value    = ""
599:             .FontName = "Tahoma"
600:             .FontSize = 8
601:             .Visible  = .T.
602:         ENDWITH
603: 
604:         *-- Label "Conta :" (Say7 original: Top=242, Left=122, Width=38)
605:         loc_oPag.AddObject("lbl_4c_Label7", "Label")
606:         WITH loc_oPag.lbl_4c_Label7
607:             .Top       = 162
608:             .Left      = 122
609:             .Width     = 38
610:             .Height    = 15
611:             .Caption   = "Conta :"
612:             .FontName  = "Tahoma"
613:             .FontSize  = 8
614:             .ForeColor = RGB(90, 90, 90)
615:             .BackStyle = 0
616:             .Visible   = .T.
617:         ENDWITH
618: 
619:         *-- Campo c" + CHR(243) + "digo da Conta de Estoque (Get_Cd_Estoque: Top=237, Left=164, Width=80)
620:         loc_oPag.AddObject("txt_4c_Cd_Estoque", "TextBox")
621:         WITH loc_oPag.txt_4c_Cd_Estoque
622:             .Top      = 157
623:             .Left     = 164
624:             .Width    = 80
625:             .Height   = 25
626:             .Value    = ""
627:             .FontName = "Tahoma"
628:             .FontSize = 8
629:             .Visible  = .T.
630:         ENDWITH
631: 
632:         *-- Campo descri" + CHR(231) + CHR(227) + "o da Conta de Estoque (Get_Ds_Estoque: Top=237, Left=246, Width=290)
633:         *   When original: Empty(Get_Cd_Estoque.Value)
634:         loc_oPag.AddObject("txt_4c_Ds_Estoque", "TextBox")
635:         WITH loc_oPag.txt_4c_Ds_Estoque
636:             .Top      = 157
637:             .Left     = 246
638:             .Width    = 290
639:             .Height   = 25
640:             .Value    = ""
641:             .FontName = "Tahoma"
642:             .FontSize = 8
643:             .Visible  = .T.
644:         ENDWITH
645: 
646:         *-- Grid de sele" + CHR(231) + CHR(227) + "o de Empresas (GrdEmp original: Top=266, Left=163, W=342, H=147)
647:         *   3 colunas: CheckBox(lMarca) | C" + CHR(243) + "d.(CEmps) | Nome da Empresa(DEmps)
648:         *   Vis" + CHR(237) + "vel apenas quando Tipo=2 (Sint" + CHR(233) + "tico)
649:         *   Ordem OBRIGAT" + CHR(211) + "RIA da Column1: AddObject(Check1) -> CurrentControl -> ControlSource
650:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
651:         loc_oGrd = loc_oPag.grd_4c_Dados
652:         WITH loc_oGrd
653:             .Top                = 186
654:             .Left               = 163
655:             .Width              = 342
656:             .Height             = 147
657:             .ColumnCount        = 3
658:             .FontName           = "Verdana"
659:             .FontSize           = 8

*-- Linhas 672 a 736:
672:             WITH .Column1
673:                 .Width           = 25
674:                 .Resizable       = .F.
675:                 .Header1.Caption = ""
676:                 .AddObject("Check1", "CheckBox")
677:                 .Check1.Caption  = ""
678:                 .Check1.Value    = 0
679:                 .CurrentControl  = "Check1"
680:             ENDWITH
681: 
682:             WITH .Column2
683:                 .Width           = 60
684:                 .Resizable       = .F.
685:                 .Header1.Caption = "C" + CHR(243) + "d."
686:             ENDWITH
687: 
688:             WITH .Column3
689:                 .Width           = 250
690:                 .Resizable       = .T.
691:                 .Header1.Caption = "Nome da Empresa"
692:             ENDWITH
693:         ENDWITH
694: 
695:         *-- RecordSource e ControlSource ap" + CHR(243) + "s WITH (evita reset de cabe" + CHR(231) + "alhos)
696:         *   ControlSource da Column1 DEPOIS de CurrentControl (regra Error 1767)
697:         IF USED("CsSigCdEmp")
698:             loc_oGrd.RecordSource          = "CsSigCdEmp"
699:             loc_oGrd.Column1.ControlSource = "CsSigCdEmp.lMarca"
700:             loc_oGrd.Column2.ControlSource = "CsSigCdEmp.CEmps"
701:             loc_oGrd.Column3.ControlSource = "CsSigCdEmp.Razas"
702:             loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "d."
703:             loc_oGrd.Column3.Header1.Caption = "Nome da Empresa"
704:         ENDIF
705: 
706:         *-- Bot" + CHR(227) + "o Marcar Todas as Empresas (cmdSelemp original: Top=332, Left=508, W=40, H=40)
707:         loc_oPag.AddObject("cmd_4c_CmdSelemp", "CommandButton")
708:         WITH loc_oPag.cmd_4c_CmdSelemp
709:             .Top           = 252
710:             .Left          = 508
711:             .Width         = 40
712:             .Height        = 40
713:             .Caption       = ""
714:             .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
715:             .ToolTipText   = "Marcar Todas as Empresas"
716:             .FontName      = "Tahoma"
717:             .FontSize      = 8
718:             .Themes        = .F.
719:             .SpecialEffect = 0
720:             .MousePointer  = 15
721:             .Visible       = .F.
722:         ENDWITH
723: 
724:         *-- Bot" + CHR(227) + "o Desmarcar Todas as Empresas (CmdApgEmp original: Top=372, Left=508, W=40, H=40)
725:         loc_oPag.AddObject("cmd_4c_CmdApgEmp", "CommandButton")
726:         WITH loc_oPag.cmd_4c_CmdApgEmp
727:             .Top           = 292
728:             .Left          = 508
729:             .Width         = 40
730:             .Height        = 40
731:             .Caption       = ""
732:             .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
733:             .ToolTipText   = "Desmarcar Todas as Empresas"
734:             .FontName      = "Tahoma"
735:             .FontSize      = 8
736:             .Themes        = .F.

*-- Linhas 754 a 780:
754: 
755:         IF loc_nTipo = 2
756:             loc_oPag.grd_4c_Dados.Visible     = .T.
757:             loc_oPag.cmd_4c_CmdApgEmp.Visible = .T.
758:             loc_oPag.cmd_4c_CmdSelemp.Visible = .T.
759:             loc_oPag.lbl_4c_Label3.Visible    = .F.
760:             loc_oPag.txt_4c_Empresa.Visible   = .F.
761:             loc_oPag.txt_4c_Dempresa.Visible  = .F.
762:             loc_oPag.lbl_4c_DtBaseAnt.Visible = .T.
763:             loc_oPag.txt_4c_DtBasea.Visible   = .T.
764:             loc_oPag.lbl_4c_Barra.Visible     = .F.
765:             loc_oPag.txt_4c_IBarra.Visible    = .F.
766:         ELSE
767:             loc_oPag.grd_4c_Dados.Visible     = .F.
768:             loc_oPag.cmd_4c_CmdApgEmp.Visible = .F.
769:             loc_oPag.cmd_4c_CmdSelemp.Visible = .F.
770:             loc_oPag.lbl_4c_Label3.Visible    = .T.
771:             loc_oPag.txt_4c_Empresa.Visible   = .T.
772:             loc_oPag.txt_4c_Dempresa.Visible  = .T.
773:             loc_oPag.lbl_4c_DtBaseAnt.Visible = .F.
774:             loc_oPag.txt_4c_DtBasea.Visible   = .F.
775:             loc_oPag.lbl_4c_Barra.Visible     = (loc_nTipo = 3)
776:             loc_oPag.txt_4c_IBarra.Visible    = (loc_nTipo = 3)
777:         ENDIF
778: 
779:         THIS.Refresh
780:     ENDPROC

*-- Linhas 853 a 862:
853:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
854: 
855:         *-- Botoes de controle do grid de selecao de empresas (Tipo=2)
856:         BINDEVENT(loc_oPag.cmd_4c_CmdSelemp, "Click", THIS, "CmdSelempClick")
857:         BINDEVENT(loc_oPag.cmd_4c_CmdApgEmp, "Click", THIS, "CmdApgEmpClick")
858:     ENDPROC
859: 
860:     *--------------------------------------------------------------------------
861:     * LimparCampos - Reseta todos os campos de filtro para estado inicial
862:     *--------------------------------------------------------------------------

*-- Linhas 1843 a 1862:
1843:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1844: 
1845:         WITH THIS.this_oRelatorio
1846:             loc_oPag.obj_4c_OptGtprel.Value     = .this_nTipo
1847:             loc_oPag.txt_4c_DtBase.Value        = .this_cDtBase
1848:             loc_oPag.txt_4c_DtBasea.Value       = .this_cDtBaseA
1849:             loc_oPag.txt_4c_Empresa.Value       = .this_cCdEmpresa
1850:             loc_oPag.txt_4c_Dempresa.Value      = .this_cDsEmpresa
1851:             loc_oPag.txt_4c__cd_moeda.Value     = .this_cCdMoeda
1852:             loc_oPag.txt_4c__ds_moeda.Value     = .this_cDsMoeda
1853:             loc_oPag.txt_4c__Cd_GrEstoque.Value = .this_cCdGrEstoque
1854:             loc_oPag.txt_4c__Ds_GrEstoque.Value = .this_cDsGrEstoque
1855:             loc_oPag.txt_4c_Cd_Estoque.Value    = .this_cCdEstoque
1856:             loc_oPag.txt_4c_Ds_Estoque.Value    = .this_cDsEstoque
1857:             loc_oPag.txt_4c_IBarra.Value        = .this_nIBarra
1858:         ENDWITH
1859: 
1860:         THIS.AjustarVisibilidadePorTipo()
1861:     ENDPROC
1862: 

*-- Linhas 1897 a 1906:
1897:             loc_oGrd.Column1.ControlSource = "CsSigCdEmp.lMarca"
1898:             loc_oGrd.Column2.ControlSource = "CsSigCdEmp.CEmps"
1899:             loc_oGrd.Column3.ControlSource = "CsSigCdEmp.Razas"
1900:             loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "d."
1901:             loc_oGrd.Column3.Header1.Caption = "Nome da Empresa"
1902:             loc_oGrd.Refresh
1903:         ENDIF
1904:     ENDPROC
1905: 
1906:     *--------------------------------------------------------------------------


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
                WHERE IIF(loc_nTipo = 1, Emps = loc_cEmp, .T.) ;
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

