# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 661: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1852 linhas total):

*-- Linhas 102 a 122:
102:     ENDPROC
103: 
104:     *==========================================================================
105:     * ConfigurarPageFrame - Orquestrador de montagem do layout
106:     * Form OPERACIONAL nao usa PageFrame Page1/Page2 - usa layout container-based:
107:     *   1) cnt_4c_Sombra (cabecalho cinza no topo)
108:     *   2) cnt_4c_Container1 (filtros - preenchido na Fase 5-6)
109:     *   3) cmg_4c_Sair (CommandGroup Consultar+Encerrar)
110:     * Mantido este nome para compatibilidade com o contrato do FormBase e para
111:     * refletir o papel de "montador da regiao central" do form.
112:     *==========================================================================
113:     PROTECTED PROCEDURE ConfigurarPageFrame()
114:         THIS.ConfigurarCabecalho()
115:         THIS.ConfigurarPaginaLista()
116:     ENDPROC
117: 
118:     *==========================================================================
119:     * ConfigurarPaginaLista - Configura a area principal de trabalho do form
120:     * OPERACIONAL. Como este form nao usa PageFrame CRUD Page1=Lista/Page2=Dados,
121:     * este metodo agrega a construcao do container de filtros e os botoes de
122:     * acao (Consultar + Encerrar), que juntos compoem a "pagina" ativa do form.

*-- Linhas 154 a 232:
154:                 ENDIF
155:         ENDCASE
156:     ENDPROC
157: 
158:     *==========================================================================
159:     * ConfigurarCabecalho - Cria background e cabecalho cinza superior (cnt_4c_Sombra)
160:     * Equivale ao cntSombra do legado (Top=0, Left=-12, Width=840, Height=80)
161:     * Novo: Top=0, Left=0, Width=1000, Height=80
162:     *==========================================================================
163:     PROTECTED PROCEDURE ConfigurarCabecalho()
164:         LOCAL loc_cCaption
165:         loc_cCaption = "Posi" + CHR(231) + CHR(227) + ;
166:                        "o Por Movimenta" + CHR(231) + CHR(227) + "o"
167: 
168:         *-- Imagem de fundo (forms OPERACIONAIS usam new_background.jpg)
169:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
170: 
171:         THIS.AddObject("cnt_4c_Sombra", "Container")
172:         WITH THIS.cnt_4c_Sombra
173:             .Top         = 0
174:             .Left        = 0
175:             .Width       = THIS.Width
176:             .Height      = 80
177:             .BackColor   = RGB(100, 100, 100)
178:             .BackStyle   = 1
179:             .BorderWidth = 0
180: 
181:             *-- Sombra (legado: lblSombra ForeColor=0,0,0 offset +1px)
182:             .AddObject("lbl_4c_Sombra", "Label")
183:             WITH .lbl_4c_Sombra
184:                 .Top       = 18
185:                 .Left      = 10
186:                 .Width     = THIS.Width
187:                 .Height    = 40
188:                 .AutoSize  = .F.
189:                 .FontBold  = .T.
190:                 .FontName  = "Tahoma"
191:                 .FontSize  = 18
192:                 .BackStyle = 0
193:                 .ForeColor = RGB(0, 0, 0)
194:                 .WordWrap  = .T.
195:                 .Caption   = loc_cCaption
196:             ENDWITH
197: 
198:             *-- Titulo branco (legado: lblTitulo ForeColor=255,255,255)
199:             .AddObject("lbl_4c_Titulo", "Label")
200:             WITH .lbl_4c_Titulo
201:                 .Top       = 17
202:                 .Left      = 10
203:                 .Width     = THIS.Width
204:                 .Height    = 46
205:                 .AutoSize  = .F.
206:                 .FontBold  = .T.
207:                 .FontName  = "Tahoma"
208:                 .FontSize  = 18
209:                 .BackStyle = 0
210:                 .ForeColor = RGB(255, 255, 255)
211:                 .WordWrap  = .T.
212:                 .Caption   = loc_cCaption
213:             ENDWITH
214:         ENDWITH
215:     ENDPROC
216: 
217:     *==========================================================================
218:     * ConfigurarContainerFiltros - Container dos campos de filtro (Fase 5-6)
219:     * Equivale ao Container1 do legado (Top=84, Left=84, Width=618, Height=249)
220:     * Novo escalado: Top=85, Left=0, Width=820, Height=480
221:     * Conteudo (TextBoxes, Labels, OptionGroups, CheckBox) preenchido na Fase 5-6
222:     *==========================================================================
223:     PROTECTED PROCEDURE ConfigurarContainerFiltros()
224:         THIS.AddObject("cnt_4c_Container1", "Container")
225:         WITH THIS.cnt_4c_Container1
226:             .Top         = 85
227:             .Left        = 0
228:             .Width       = 820
229:             .Height      = 490
230:             .BackStyle   = 0
231:             .BorderWidth = 0
232:             .Visible     = .T.

*-- Linhas 253 a 277:
253:         *-- -----------------------------------------------------------------------
254:         *-- LINHA 1: Empresa (y_orig=10-14)
255:         *-- -----------------------------------------------------------------------
256:         loc_oCnt.AddObject("lbl_4c_Lbl_empresa", "Label")
257:         WITH loc_oCnt.lbl_4c_Lbl_empresa
258:             .Top       = 26
259:             .Left      = 59
260:             .Height    = 15
261:             .AutoSize  = .T.
262:             .FontName  = "Tahoma"
263:             .FontSize  = 8
264:             .BackStyle = 0
265:             .ForeColor = RGB(90, 90, 90)
266:             .Caption   = "Empresa :"
267:         ENDWITH
268: 
269:         loc_oCnt.AddObject("txt_4c__cd_empresa", "TextBox")
270:         WITH loc_oCnt.txt_4c__cd_empresa
271:             .Top           = 20
272:             .Left          = 133
273:             .Width         = 41
274:             .Height        = 23
275:             .Value         = go_4c_Sistema.cCodEmpresa
276:             .Format        = "K!"
277:             .MaxLength     = 3

*-- Linhas 283 a 363:
283: 
284:         loc_oCnt.AddObject("txt_4c__ds_empresa", "TextBox")
285:         WITH loc_oCnt.txt_4c__ds_empresa
286:             .Top           = 20
287:             .Left          = 178
288:             .Width         = 386
289:             .Height        = 23
290:             .Value         = ""
291:             .Format        = "K!"
292:             .MaxLength     = 40
293:             .SpecialEffect = 1
294:             .FontName      = "Tahoma"
295:             .ForeColor     = RGB(0, 0, 0)
296:             .Themes        = .F.
297:         ENDWITH
298: 
299:         loc_oCnt.AddObject("chk_4c_ChkEmpD", "CheckBox")
300:         WITH loc_oCnt.chk_4c_ChkEmpD
301:             .Top       = 28
302:             .Left      = 579
303:             .Width     = 130
304:             .Height    = 15
305:             .Value     = 0
306:             .Caption   = "Empresa Destino"
307:             .FontName  = "Tahoma"
308:             .FontSize  = 8
309:             .BackStyle = 0
310:             .Alignment = 0
311:             .ForeColor = RGB(90, 90, 90)
312:         ENDWITH
313: 
314:         *-- -----------------------------------------------------------------------
315:         *-- LINHA 2: Periodo (y_orig=36-41)
316:         *-- -----------------------------------------------------------------------
317:         loc_oCnt.AddObject("lbl_4c_Lbl_periodo", "Label")
318:         WITH loc_oCnt.lbl_4c_Lbl_periodo
319:             .Top       = 81
320:             .Left      = 66
321:             .Height    = 15
322:             .AutoSize  = .T.
323:             .FontName  = "Tahoma"
324:             .BackStyle = 0
325:             .ForeColor = RGB(90, 90, 90)
326:             .Caption   = "Per" + CHR(237) + "odo :"
327:         ENDWITH
328: 
329:         loc_oCnt.AddObject("txt_4c__dt_inicial", "TextBox")
330:         WITH loc_oCnt.txt_4c__dt_inicial
331:             .Top           = 73
332:             .Left          = 133
333:             .Width         = 106
334:             .Height        = 23
335:             .Value         = DATE()
336:             .Format        = "K"
337:             .SpecialEffect = 1
338:             .FontName      = "Tahoma"
339:             .ForeColor     = RGB(0, 0, 0)
340:             .Themes        = .F.
341:         ENDWITH
342: 
343:         loc_oCnt.AddObject("lbl_4c_Lbl_periodo_a", "Label")
344:         WITH loc_oCnt.lbl_4c_Lbl_periodo_a
345:             .Top       = 81
346:             .Left      = 243
347:             .Height    = 15
348:             .AutoSize  = .T.
349:             .FontName  = "Tahoma"
350:             .BackStyle = 0
351:             .ForeColor = RGB(90, 90, 90)
352:             .Caption   = CHR(224)
353:         ENDWITH
354: 
355:         loc_oCnt.AddObject("txt_4c__dt_final", "TextBox")
356:         WITH loc_oCnt.txt_4c__dt_final
357:             .Top           = 73
358:             .Left          = 256
359:             .Width         = 106
360:             .Height        = 23
361:             .Value         = DATE()
362:             .Format        = "K"
363:             .SpecialEffect = 1

*-- Linhas 369 a 432:
369:         *-- OptionGroup: tipo de periodo (Lancamento / Prazo Entrega)
370:         loc_oCnt.AddObject("obj_4c_Opt_nr_periodo", "OptionGroup")
371:         WITH loc_oCnt.obj_4c_Opt_nr_periodo
372:             .Top           = 71
373:             .Left          = 362
374:             .Width         = 246
375:             .Height        = 25
376:             .BackStyle     = 0
377:             .BorderStyle   = 0
378:             .SpecialEffect = 0
379:             .ButtonCount   = 2
380: 
381:             WITH .Buttons(1)
382:                 .Caption   = "Lan" + CHR(231) + "amento"
383:                 .AutoSize  = .F.
384:                 .BackStyle = 0
385:                 .ForeColor = RGB(90, 90, 90)
386:                 .Themes    = .F.
387:                 .Height    = 15
388:                 .Left      = 5
389:                 .Top       = 5
390:                 .Width     = 101
391:             ENDWITH
392: 
393:             WITH .Buttons(2)
394:                 .Caption   = "Prazo Entrega"
395:                 .AutoSize  = .F.
396:                 .BackStyle = 0
397:                 .ForeColor = RGB(90, 90, 90)
398:                 .FontName  = "Tahoma"
399:                 .Themes    = .F.
400:                 .Height    = 15
401:                 .Left      = 125
402:                 .Top       = 5
403:                 .Width     = 116
404:             ENDWITH
405: 
406:             .Value = 1
407:         ENDWITH
408: 
409:         *-- -----------------------------------------------------------------------
410:         *-- LINHA 3: Movimentacao / Numero / OP / Status (y_orig=63-67)
411:         *-- -----------------------------------------------------------------------
412:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
413:         WITH loc_oCnt.lbl_4c_Label1
414:             .Top       = 132
415:             .Left      = 23
416:             .Height    = 15
417:             .AutoSize  = .T.
418:             .FontName  = "Tahoma"
419:             .BackStyle = 0
420:             .ForeColor = RGB(90, 90, 90)
421:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
422:         ENDWITH
423: 
424:         loc_oCnt.AddObject("txt_4c__nm_operacao", "TextBox")
425:         WITH loc_oCnt.txt_4c__nm_operacao
426:             .Top           = 124
427:             .Left          = 133
428:             .Width         = 199
429:             .Height        = 23
430:             .Value         = ""
431:             .Format        = "K!"
432:             .MaxLength     = 20

*-- Linhas 438 a 505:
438: 
439:         loc_oCnt.AddObject("txt_4c_Numero", "TextBox")
440:         WITH loc_oCnt.txt_4c_Numero
441:             .Top           = 124
442:             .Left          = 334
443:             .Width         = 73
444:             .Height        = 23
445:             .Value         = 0
446:             .Alignment     = 3
447:             .Format        = "K"
448:             .InputMask     = "999999"
449:             .SpecialEffect = 1
450:             .FontName      = "Tahoma"
451:             .ForeColor     = RGB(0, 0, 0)
452:             .Themes        = .F.
453:         ENDWITH
454: 
455:         loc_oCnt.AddObject("lbl_4c_Label12", "Label")
456:         WITH loc_oCnt.lbl_4c_Label12
457:             .Top       = 132
458:             .Left      = 422
459:             .Height    = 15
460:             .AutoSize  = .T.
461:             .FontName  = "Tahoma"
462:             .FontSize  = 8
463:             .BackStyle = 0
464:             .ForeColor = RGB(90, 90, 90)
465:             .Caption   = "OP :"
466:         ENDWITH
467: 
468:         loc_oCnt.AddObject("txt_4c_Op", "TextBox")
469:         WITH loc_oCnt.txt_4c_Op
470:             .Top           = 124
471:             .Left          = 462
472:             .Width         = 73
473:             .Height        = 23
474:             .Value         = 0
475:             .Alignment     = 3
476:             .Format        = "K"
477:             .InputMask     = "999999"
478:             .SpecialEffect = 1
479:             .FontName      = "Tahoma"
480:             .ForeColor     = RGB(0, 0, 0)
481:             .Themes        = .F.
482:         ENDWITH
483: 
484:         loc_oCnt.AddObject("lbl_4c_Label8", "Label")
485:         WITH loc_oCnt.lbl_4c_Label8
486:             .Top       = 132
487:             .Left      = 544
488:             .Height    = 15
489:             .AutoSize  = .T.
490:             .FontName  = "Tahoma"
491:             .FontSize  = 8
492:             .BackStyle = 0
493:             .ForeColor = RGB(90, 90, 90)
494:             .Caption   = "Status :"
495:         ENDWITH
496: 
497:         loc_oCnt.AddObject("txt_4c_PStatus", "TextBox")
498:         WITH loc_oCnt.txt_4c_PStatus
499:             .Top           = 124
500:             .Left          = 605
501:             .Width         = 23
502:             .Height        = 23
503:             .Value         = ""
504:             .InputMask     = "A"
505:             .Margin        = 2

*-- Linhas 512 a 535:
512:         *-- -----------------------------------------------------------------------
513:         *-- LINHA 4: Grupo (y_orig=89-93)
514:         *-- -----------------------------------------------------------------------
515:         loc_oCnt.AddObject("lbl_4c_Label6", "Label")
516:         WITH loc_oCnt.lbl_4c_Label6
517:             .Top       = 183
518:             .Left      = 76
519:             .Height    = 15
520:             .AutoSize  = .T.
521:             .FontName  = "Tahoma"
522:             .BackStyle = 0
523:             .ForeColor = RGB(90, 90, 90)
524:             .Caption   = "Grupo :"
525:         ENDWITH
526: 
527:         loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
528:         WITH loc_oCnt.txt_4c_Grupo
529:             .Top           = 175
530:             .Left          = 133
531:             .Width         = 106
532:             .Height        = 23
533:             .Value         = SPACE(10)
534:             .Format        = "K"
535:             .MaxLength     = 10

*-- Linhas 541 a 550:
541: 
542:         loc_oCnt.AddObject("txt_4c__Dgrupo", "TextBox")
543:         WITH loc_oCnt.txt_4c__Dgrupo
544:             .Top           = 175
545:             .Left          = 243
546:             .Width         = 385
547:             .Height        = 23
548:             .Value         = SPACE(20)
549:             .Format        = "K"
550:             .MaxLength     = 20

*-- Linhas 557 a 580:
557:         *-- -----------------------------------------------------------------------
558:         *-- LINHA 5: Conta / CPF / Dconta (y_orig=115-119)
559:         *-- -----------------------------------------------------------------------
560:         loc_oCnt.AddObject("lbl_4c_Label4", "Label")
561:         WITH loc_oCnt.lbl_4c_Label4
562:             .Top       = 234
563:             .Left      = 76
564:             .Height    = 15
565:             .AutoSize  = .T.
566:             .FontName  = "Tahoma"
567:             .BackStyle = 0
568:             .ForeColor = RGB(90, 90, 90)
569:             .Caption   = "Conta :"
570:         ENDWITH
571: 
572:         loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
573:         WITH loc_oCnt.txt_4c_Conta
574:             .Top           = 226
575:             .Left          = 133
576:             .Width         = 106
577:             .Height        = 23
578:             .Value         = SPACE(10)
579:             .Format        = "K"
580:             .MaxLength     = 10

*-- Linhas 587 a 596:
587: 
588:         loc_oCnt.AddObject("txt_4c_Cpf", "TextBox")
589:         WITH loc_oCnt.txt_4c_Cpf
590:             .Top           = 226
591:             .Left          = 243
592:             .Width         = 194
593:             .Height        = 23
594:             .Value         = ""
595:             .InputMask     = "XXXXXXXXXXXXXXXXXXXX"
596:             .MaxLength     = 20

*-- Linhas 603 a 612:
603: 
604:         loc_oCnt.AddObject("txt_4c_Dconta", "TextBox")
605:         WITH loc_oCnt.txt_4c_Dconta
606:             .Top           = 226
607:             .Left          = 441
608:             .Width         = 372
609:             .Height        = 23
610:             .Value         = SPACE(40)
611:             .Format        = "K"
612:             .MaxLength     = 40

*-- Linhas 627 a 675:
627:     PROTECTED PROCEDURE ConfigurarBotoes()
628:         THIS.AddObject("cmg_4c_Sair", "CommandGroup")
629:         WITH THIS.cmg_4c_Sair
630:             .Top           = 0
631:             .Left          = 820
632:             .Width         = 180
633:             .Height        = 85
634:             .ButtonCount   = 2
635:             .BackStyle     = 0
636:             .BorderStyle   = 0
637:             .SpecialEffect = 1
638:             .Themes        = .F.
639: 
640:             WITH .Buttons(1)
641:                 .Top             = 5
642:                 .Left            = 5
643:                 .Width           = 75
644:                 .Height          = 75
645:                 .FontBold        = .T.
646:                 .FontItalic      = .T.
647:                 .WordWrap        = .T.
648:                 .Picture         = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
649:                 .Caption         = "Consultar"
650:                 .ForeColor       = RGB(90, 90, 90)
651:                 .BackColor       = RGB(255, 255, 255)
652:                 .Themes          = .F.
653:                 .MousePointer    = 15
654:                 .SpecialEffect   = 0
655:                 .PicturePosition = 13
656:             ENDWITH
657: 
658:             WITH .Buttons(2)
659:                 .Top             = 5
660:                 .Left            = 85
661:                 .Width           = 75
662:                 .Height          = 75
663:                 .FontBold        = .T.
664:                 .FontItalic      = .T.
665:                 .FontName        = "Comic Sans MS"
666:                 .FontSize        = 8
667:                 .WordWrap        = .T.
668:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
669:                 .Cancel          = .T.
670:                 .Caption         = "Encerrar"
671:                 .ForeColor       = RGB(90, 90, 90)
672:                 .BackColor       = RGB(255, 255, 255)
673:                 .Themes          = .F.
674:                 .MousePointer    = 15
675:                 .SpecialEffect   = 0

*-- Linhas 960 a 1209:
960:         *   Original: Say5 Left=6 Top=192, get_resps Left=80 Top=190 Width=60 H=13
961:         *             get_dresps Left=146 Top=190 Width=200 H=13
962:         *   Escalado ScaleX=1.327 ScaleY=1.968
963:         loc_oCnt.AddObject("lbl_4c_Lbl_responsavel", "Label")
964:         WITH loc_oCnt.lbl_4c_Lbl_responsavel
965:             .Caption   = "Respons" + CHR(225) + "vel"
966:             .Top       = 378
967:             .Left      = 8
968:             .Width     = 90
969:             .Height    = 18
970:             .AutoSize  = .F.
971:             .FontBold  = .T.
972:             .FontSize  = 9
973:             .BackStyle = 0
974:         ENDWITH
975: 
976:         loc_oCnt.AddObject("txt_4c__resps", "TextBox")
977:         WITH loc_oCnt.txt_4c__resps
978:             .Value    = ""
979:             .Top      = 374
980:             .Left     = 106
981:             .Width    = 80
982:             .Height   = 22
983:             .FontSize = 9
984:         ENDWITH
985: 
986:         loc_oCnt.AddObject("txt_4c__dresps", "TextBox")
987:         WITH loc_oCnt.txt_4c__dresps
988:             .Value    = ""
989:             .Top      = 374
990:             .Left     = 192
991:             .Width    = 265
992:             .Height   = 22
993:             .ReadOnly = .T.
994:             .FontSize = 9
995:             .BackColor = RGB(240,240,240)
996:         ENDWITH
997: 
998:         *-- Linha 7: Moeda / Cotacao
999:         *   Original: lbl_moeda Left=6 Top=207, get_cd_moeda Left=80 Top=205 Width=40 H=13
1000:         *             get_ds_moeda Left=125 Top=205 Width=160 H=13
1001:         *             OptCotacao Left=290 Top=205 W=130 H=16 (Option1/Option2)
1002:         *             Say3 Left=285 Top=207 (label "Cotacao")
1003:         loc_oCnt.AddObject("lbl_4c_Lbl_moeda", "Label")
1004:         WITH loc_oCnt.lbl_4c_Lbl_moeda
1005:             .Caption   = "Moeda"
1006:             .Top       = 404
1007:             .Left      = 8
1008:             .Width     = 90
1009:             .Height    = 18
1010:             .AutoSize  = .F.
1011:             .FontBold  = .T.
1012:             .FontSize  = 9
1013:             .BackStyle = 0
1014:         ENDWITH
1015: 
1016:         loc_oCnt.AddObject("txt_4c_cd_moeda", "TextBox")
1017:         WITH loc_oCnt.txt_4c_cd_moeda
1018:             .Value    = ""
1019:             .Top      = 400
1020:             .Left     = 106
1021:             .Width    = 53
1022:             .Height   = 22
1023:             .FontSize = 9
1024:         ENDWITH
1025: 
1026:         loc_oCnt.AddObject("txt_4c_ds_moeda", "TextBox")
1027:         WITH loc_oCnt.txt_4c_ds_moeda
1028:             .Value    = ""
1029:             .Top      = 400
1030:             .Left     = 165
1031:             .Width    = 212
1032:             .Height   = 22
1033:             .ReadOnly = .T.
1034:             .FontSize = 9
1035:             .BackColor = RGB(240,240,240)
1036:         ENDWITH
1037: 
1038:         loc_oCnt.AddObject("lbl_4c_Lbl_cotacao", "Label")
1039:         WITH loc_oCnt.lbl_4c_Lbl_cotacao
1040:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
1041:             .Top       = 404
1042:             .Left      = 385
1043:             .Width     = 70
1044:             .Height    = 18
1045:             .AutoSize  = .F.
1046:             .FontBold  = .T.
1047:             .FontSize  = 9
1048:             .BackStyle = 0
1049:         ENDWITH
1050: 
1051:         loc_oCnt.AddObject("obj_4c_OptCotacao", "OptionGroup")
1052:         WITH loc_oCnt.obj_4c_OptCotacao
1053:             .Top        = 400
1054:             .Left       = 458
1055:             .Width      = 200
1056:             .Height     = 22
1057:             .ButtonCount = 2
1058:             .BorderStyle = 0
1059:             .BackStyle   = 0
1060:             .Value       = 1
1061:             WITH .Buttons(1)
1062:                 .Caption   = "Fechamento"
1063:                 .AutoSize  = .F.
1064:                 .BackStyle = 0
1065:                 .ForeColor = RGB(90, 90, 90)
1066:                 .Themes    = .F.
1067:                 .Left      = 0
1068:                 .Top       = 2
1069:                 .Width     = 95
1070:                 .Height    = 18
1071:             ENDWITH
1072:             WITH .Buttons(2)
1073:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
1074:                 .AutoSize  = .F.
1075:                 .BackStyle = 0
1076:                 .ForeColor = RGB(90, 90, 90)
1077:                 .FontSize  = 9
1078:                 .Themes    = .F.
1079:                 .Left      = 98
1080:                 .Top       = 2
1081:                 .Width     = 100
1082:                 .Height    = 18
1083:             ENDWITH
1084:         ENDWITH
1085: 
1086:         *-- Linha 8: Situacao (OptionGroup 3 opcoes: Quitado/Aberto/Todas)
1087:         loc_oCnt.AddObject("lbl_4c_Lbl_situacao", "Label")
1088:         WITH loc_oCnt.lbl_4c_Lbl_situacao
1089:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o"
1090:             .Top       = 432
1091:             .Left      = 8
1092:             .Width     = 90
1093:             .Height    = 18
1094:             .AutoSize  = .F.
1095:             .FontBold  = .T.
1096:             .FontSize  = 9
1097:             .BackStyle = 0
1098:         ENDWITH
1099: 
1100:         loc_oCnt.AddObject("obj_4c_Opt_Pendente", "OptionGroup")
1101:         WITH loc_oCnt.obj_4c_Opt_Pendente
1102:             .Top         = 428
1103:             .Left        = 106
1104:             .Width       = 225
1105:             .Height      = 22
1106:             .ButtonCount = 3
1107:             .BorderStyle = 0
1108:             .BackStyle   = 0
1109:             .Value       = THIS.this_oBusinessObject.this_nOptPendente
1110:             WITH .Buttons(1)
1111:                 .Caption   = "Pendente"
1112:                 .AutoSize  = .F.
1113:                 .BackStyle = 0
1114:                 .ForeColor = RGB(90, 90, 90)
1115:                 .Themes    = .F.
1116:                 .Left      = 0
1117:                 .Top       = 2
1118:                 .Width     = 72
1119:                 .Height    = 18
1120:             ENDWITH
1121:             WITH .Buttons(2)
1122:                 .Caption   = "Quitado"
1123:                 .AutoSize  = .F.
1124:                 .BackStyle = 0
1125:                 .ForeColor = RGB(90, 90, 90)
1126:                 .FontSize  = 9
1127:                 .Themes    = .F.
1128:                 .Left      = 75
1129:                 .Top       = 2
1130:                 .Width     = 70
1131:                 .Height    = 18
1132:             ENDWITH
1133:             WITH .Buttons(3)
1134:                 .Caption   = "Todas"
1135:                 .AutoSize  = .F.
1136:                 .BackStyle = 0
1137:                 .ForeColor = RGB(90, 90, 90)
1138:                 .FontSize  = 9
1139:                 .Themes    = .F.
1140:                 .Left      = 148
1141:                 .Top       = 2
1142:                 .Width     = 75
1143:                 .Height    = 18
1144:             ENDWITH
1145:         ENDWITH
1146: 
1147:         *-- Linha 9: Impressao (Say7 / opt_impressao)
1148:         *   Original: Say7 Left=6 Top=237, opt_impressao Left=80 Top=235 W=230 H=16
1149:         *             Value=1 (Por Vendedor), 3 options: Por Vendedor/Por Cliente/Ambos
1150:         loc_oCnt.AddObject("lbl_4c_Lbl_impressao", "Label")
1151:         WITH loc_oCnt.lbl_4c_Lbl_impressao
1152:             .Caption   = "Impress" + CHR(227) + "o"
1153:             .Top       = 460
1154:             .Left      = 8
1155:             .Width     = 90
1156:             .Height    = 18
1157:             .AutoSize  = .F.
1158:             .FontBold  = .T.
1159:             .FontSize  = 9
1160:             .BackStyle = 0
1161:         ENDWITH
1162: 
1163:         loc_oCnt.AddObject("obj_4c_Opt_impressao", "OptionGroup")
1164:         WITH loc_oCnt.obj_4c_Opt_impressao
1165:             .Top         = 456
1166:             .Left        = 106
1167:             .Width       = 305
1168:             .Height      = 22
1169:             .ButtonCount = 3
1170:             .BorderStyle = 0
1171:             .BackStyle   = 0
1172:             .Value       = 1
1173:             WITH .Buttons(1)
1174:                 .Caption   = "Por Vendedor"
1175:                 .AutoSize  = .F.
1176:                 .BackStyle = 0
1177:                 .ForeColor = RGB(90, 90, 90)
1178:                 .Themes    = .F.
1179:                 .Left      = 0
1180:                 .Top       = 2
1181:                 .Width     = 98
1182:                 .Height    = 18
1183:             ENDWITH
1184:             WITH .Buttons(2)
1185:                 .Caption   = "Por Cliente"
1186:                 .AutoSize  = .F.
1187:                 .BackStyle = 0
1188:                 .ForeColor = RGB(90, 90, 90)
1189:                 .FontSize  = 9
1190:                 .Themes    = .F.
1191:                 .Left      = 101
1192:                 .Top       = 2
1193:                 .Width     = 98
1194:                 .Height    = 18
1195:             ENDWITH
1196:             WITH .Buttons(3)
1197:                 .Caption   = "Ambos"
1198:                 .AutoSize  = .F.
1199:                 .BackStyle = 0
1200:                 .ForeColor = RGB(90, 90, 90)
1201:                 .FontSize  = 9
1202:                 .Themes    = .F.
1203:                 .Left      = 202
1204:                 .Top       = 2
1205:                 .Width     = 100
1206:                 .Height    = 18
1207:             ENDWITH
1208:         ENDWITH
1209:     ENDPROC


### BO (C:\4c\projeto\app\classes\SigPrEs1BO.prg):
*==============================================================================
* SigPrEs1BO.prg - Business Object: Posicao Por Movimentacao
* Herda de: BusinessBase
* Tipo: OPERACIONAL (filtro/consulta - sem CRUD direto)
* Tabela principal: SigMvCab
*==============================================================================

DEFINE CLASS SigPrEs1BO AS BusinessBase

    *--------------------------------------------------------------------------
    * Filtros de periodo
    *--------------------------------------------------------------------------
    this_dDtInicial    = {}
    this_dDtFinal      = {}
    this_nNrPeriodo    = 1        && 1=Lancamento, 2=Prazo Entrega

    *--------------------------------------------------------------------------
    * Filtro Movimentacao / Operacao
    *--------------------------------------------------------------------------
    this_cNmOperacao   = ""       && C(20) - Nome da movimentacao (SigCdOpe.Dopes)

    *--------------------------------------------------------------------------
    * Filtros Numero / OP
    *--------------------------------------------------------------------------
    this_nNumero       = 0        && N(6,0) - Numero do lancamento (SigMvCab.numes)
    this_nOp           = 0        && N(6,0) - Numero da OP (SigMvCab.nops)

    *--------------------------------------------------------------------------
    * Filtro Status
    *--------------------------------------------------------------------------
    this_cPStatus      = ""       && C(1) - Status (SigMvCab.pstatus)

    *--------------------------------------------------------------------------
    * Filtro Grupo Contabil (SigCdGcr - origem/destino)
    *--------------------------------------------------------------------------
    this_cGrupo        = ""       && C(10) - Codigo do grupo (grupoos/grupods)
    this_cDGrupo       = ""       && C(40) - Descricao do grupo (descrs)

    *--------------------------------------------------------------------------
    * Filtro Conta / CPF/CNPJ (SigCdCli)
    *--------------------------------------------------------------------------
    this_cConta        = ""       && C(10) - Codigo da conta (contaos/contads)
    this_cDConta       = ""       && C(50) - Descricao da conta (rclis)
    this_cCpf          = ""       && C(20) - CPF/CNPJ (SigCdCli.cpfs)

    *--------------------------------------------------------------------------
    * Filtro Moeda (SigCdMoe - exibido em sigpres2, nao filtra SQL principal)
    *--------------------------------------------------------------------------
    this_cCdMoeda      = ""       && C(3)  - Codigo da moeda (cmoes)
    this_cDsMoeda      = ""       && C(15) - Descricao da moeda (dmoes)

    *--------------------------------------------------------------------------
    * Filtro Responsavel / Vendedor (SigCdCli com grupo = GrPadVens)
    *--------------------------------------------------------------------------
    this_cResps        = ""       && C(10) - Codigo do responsavel (vends)
    this_cDResps       = ""       && C(50) - Descricao do responsavel (rclis)

    *--------------------------------------------------------------------------
    * Filtro Empresa (sigcdemp)
    *--------------------------------------------------------------------------
    this_cCdEmpresa    = ""       && C(3)  - Codigo da empresa (emps)
    this_cDsEmpresa    = ""       && C(40) - Descricao da empresa (razas)
    this_nChkEmpD      = 0        && N(1)  - 0=nao filtrar Empds, 1=incluir Empds

    *--------------------------------------------------------------------------
    * OptionGroups - passados a sigpres2 para controle de exibicao/impressao
    *--------------------------------------------------------------------------
    this_nOptCotacao   = 1        && 1=Fechamento, 2=Movimentacao
    this_nOptImpressao = 1        && 1=Por Vendedor, 2=Por Movimentacao
    this_nOptPendente  = 3        && 1=Pendentes, 2=Baixadas, 3=Todas

    *--------------------------------------------------------------------------
    * Parametro operacional carregado de SigCdPam
    *--------------------------------------------------------------------------
    this_cGrPadVens    = ""       && C(10) - Grupo padrao de vendedores (grpadvens)

    *==========================================================================
    * Init - Inicializa o BO configurando tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna identificador para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nNumero)
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega GrPadVens e demais config de SigCdPam
    * Deve ser chamado no Init() do Form apos criar o BO
    * Retorna .T. se carregou com sucesso
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 grpadvens FROM SigCdPam"

            IF USED("cursor_4c_Param")
                USE IN cursor_4c_Param
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param") > 0
                IF !EOF("cursor_4c_Param")
                    SELECT cursor_4c_Param
                    THIS.this_cGrPadVens = NVL(grpadvens, "")
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_Param")
                USE IN cursor_4c_Param
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar par" + CHR(226) + "metros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarFiltros - Valida campos obrigatorios antes da consulta
    * Retorna: "" se valido, mensagem de erro se invalido
    *==========================================================================
    PROCEDURE ValidarFiltros()
        LOCAL loc_cMensagem
        loc_cMensagem = ""

        IF EMPTY(THIS.this_cCdEmpresa)
            RETURN "Empresa Inv" + CHR(225) + "lida!!!"
        ENDIF

        IF EMPTY(THIS.this_cNmOperacao)
            RETURN "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!"
        ENDIF

        IF !EMPTY(THIS.this_dDtFinal) AND !EMPTY(THIS.this_dDtInicial)
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
                RETURN "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! " + ;
                       "Data Final Menor do Que a Inicial!!!"
            ENDIF
        ENDIF

        RETURN loc_cMensagem
    ENDPROC

    *==========================================================================
    * ExecutarConsulta - Monta e executa consulta principal em SigMvCab
    * Popula cursor_4c_MovTemp com resultados indexados por EmpDopNums
    * Requer: this_cCdEmpresa, this_dDtInicial, this_dDtFinal validados
    * Retorna: .T. se consulta gerou ao menos 1 registro
    *==========================================================================
    PROCEDURE ExecutarConsulta()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_cDtI, loc_cDtF, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cDtI = "'" + DTOC(THIS.this_dDtInicial, 1) + "'"
            loc_cDtF = "'" + DTOC(THIS.this_dDtFinal, 1) + " 23:59:59'"

            loc_cWhere = IIF(EMPTY(THIS.this_cNmOperacao), "", ;
                             "a.dopes = " + EscaparSQL(THIS.this_cNmOperacao) + " And ") + ;
                         IIF(THIS.this_nNrPeriodo = 1, "a.datas ", "a.prazoents ") + ;
                             "Between " + loc_cDtI + " And " + loc_cDtF + " And " + ;
                         IIF(EMPTY(THIS.this_cGrupo), "", ;
                             "(a.grupoos = " + EscaparSQL(THIS.this_cGrupo) + ;
                             " Or a.grupods = " + EscaparSQL(THIS.this_cGrupo) + ") And ") + ;
                         IIF(EMPTY(THIS.this_cConta), "", ;
                             "(a.contaos = " + EscaparSQL(THIS.this_cConta) + ;
                             " Or a.contads = " + EscaparSQL(THIS.this_cConta) + ") And ") + ;
                         IIF(THIS.this_nOp = 0, "", ;
                             "a.nops = " + TRANSFORM(THIS.this_nOp) + " And ") + ;
                         IIF(THIS.this_nNumero = 0, "", ;
                             "a.numes = " + TRANSFORM(THIS.this_nNumero) + " And ") + ;
                         IIF(EMPTY(THIS.this_cResps), "", ;
                             "a.vends = " + EscaparSQL(THIS.this_cResps) + " And ") + ;
                         IIF(THIS.this_nOptPendente = 1, "a.chksubn = 0 And ", ;
                             IIF(THIS.this_nOptPendente = 2, "a.chksubn = 1 And ", "")) + ;
                         IIF(EMPTY(THIS.this_cPStatus), "", ;
                             "a.pstatus = " + EscaparSQL(THIS.this_cPStatus) + " And ")

            loc_cSQL = "SELECT a.* " + ;
                       "FROM SigMvCab a, SigCdOpe b " + ;
                       "WHERE (a.emps = " + EscaparSQL(THIS.this_cCdEmpresa) + ;
                           IIF(THIS.this_nChkEmpD = 0, "", ;
                               " Or a.empds = " + EscaparSQL(THIS.this_cCdEmpresa)) + ;
                           ") And " + ;
                       loc_cWhere + ;
                       "a.dopes = b.Dopes"

            IF USED("cursor_4c_MovTemp")
                USE IN cursor_4c_MovTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MovTemp") > 0
                SELECT cursor_4c_MovTemp
                IF !EOF("cursor_4c_MovTemp")
                    INDEX ON empdopnums TAG empdopnums
                    UPDATE cursor_4c_MovTemp ;
                        SET prazoents = IIF(ISNULL(prazoents), {}, prazoents)
                    GO TOP IN cursor_4c_MovTemp
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao executar consulta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarGrupoPorCodigo - Lookup SigCdGcr por codigo (equivale fAcessoContab C)
    * Popula cursor_4c_BuscaGrupo com codigos, descrs
    * Retorna .T. se encontrou exatamente 1 registro
    *==========================================================================
    PROCEDURE BuscarGrupoPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
                       "WHERE RTRIM(codigos) = RTRIM(" + EscaparSQL(par_cCodigo) + ")"

            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaGrupo")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarGrupoPorDescricao - Lookup SigCdGcr por descricao (fAcessoContab D)
    * Popula cursor_4c_BuscaGrupo com codigos, descrs
    * Retorna .T. se encontrou exatamente 1 match (auto-preenche sem picker)
    *==========================================================================
    PROCEDURE BuscarGrupoPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
                       "WHERE RTRIM(descrs) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       " ORDER BY descrs"

            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo") > 0
                SELECT cursor_4c_BuscaGrupo
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaGrupo")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarMoedaPorCodigo - Lookup SigCdMoe por cmoes
    * Popula cursor_4c_BuscaMoeda com cmoes, dmoes
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarMoedaPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
                       "WHERE RTRIM(cmoes) = RTRIM(" + EscaparSQL(par_cCodigo) + ")"

            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaMoeda")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarMoedaPorDescricao - Lookup SigCdMoe por dmoes
    * Popula cursor_4c_BuscaMoeda com cmoes, dmoes
    * Retorna .T. se encontrou exatamente 1 match
    *==========================================================================
    PROCEDURE BuscarMoedaPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
                       "WHERE RTRIM(dmoes) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       " ORDER BY dmoes"

            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda") > 0
                SELECT cursor_4c_BuscaMoeda
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaMoeda")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarContaPorCodigo - Lookup SigCdCli por iclis com filtro de grupo
    * Equivale a fAcessoContas(usu, grupo, 'C', ...)
    * Popula cursor_4c_BuscaConta com iclis, rclis
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarContaPorCodigo(par_cGrupo, par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltroGrupo, loc_oErro
        loc_lSucesso    = .F.
        loc_cFiltroGrupo = IIF(EMPTY(par_cGrupo), "", ;
            " And RTRIM(grupos) = RTRIM(" + EscaparSQL(par_cGrupo) + ")")

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SIGCDCLI " + ;
                       "WHERE RTRIM(iclis) = RTRIM(" + EscaparSQL(par_cCodigo) + ")" + ;
                       loc_cFiltroGrupo

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaConta")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar conta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarContaPorDescricao - Lookup SigCdCli por rclis com filtro de grupo
    * Equivale a fAcessoContas(usu, grupo, 'D', ...)
    * Popula cursor_4c_BuscaConta com iclis, rclis
    * Retorna .T. se encontrou exatamente 1 match
    *==========================================================================
    PROCEDURE BuscarContaPorDescricao(par_cGrupo, par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltroGrupo, loc_oErro
        loc_lSucesso    = .F.
        loc_cFiltroGrupo = IIF(EMPTY(par_cGrupo), "", ;
            " And RTRIM(grupos) = RTRIM(" + EscaparSQL(par_cGrupo) + ")")

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SIGCDCLI " + ;
                       "WHERE RTRIM(rclis) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       loc_cFiltroGrupo + ;
                       " ORDER BY rclis"

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta") > 0
                SELECT cursor_4c_BuscaConta
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaConta")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar conta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarResponsavelPorCodigo - Lookup vendedor/resp por iclis
    * Usa this_cGrPadVens como filtro de grupo (SigCdCli.grupos)
    * Equivale a fAcessoContas(usu, GrPadVens, 'C', ...)
    * Popula cursor_4c_BuscaResp com iclis, rclis
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarResponsavelPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltroGrupo, loc_oErro
        loc_lSucesso    = .F.
        loc_cFiltroGrupo = IIF(EMPTY(THIS.this_cGrPadVens), "", ;
            " And RTRIM(grupos) = RTRIM(" + EscaparSQL(THIS.this_cGrPadVens) + ")")

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SIGCDCLI " + ;
                       "WHERE RTRIM(iclis) = RTRIM(" + EscaparSQL(par_cCodigo) + ")" + ;
                       loc_cFiltroGrupo

            IF USED("cursor_4c_BuscaResp")
                USE IN cursor_4c_BuscaResp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaResp") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaResp")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar respons" + CHR(225) + "vel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarResponsavelPorDescricao - Lookup vendedor/resp por rclis
    * Usa this_cGrPadVens como filtro de grupo
    * Equivale a fAcessoContas(usu, GrPadVens, 'D', ...)
    * Popula cursor_4c_BuscaResp com iclis, rclis
    * Retorna .T. se encontrou exatamente 1 match
    *==========================================================================
    PROCEDURE BuscarResponsavelPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltroGrupo, loc_oErro
        loc_lSucesso    = .F.
        loc_cFiltroGrupo = IIF(EMPTY(THIS.this_cGrPadVens), "", ;
            " And RTRIM(grupos) = RTRIM(" + EscaparSQL(THIS.this_cGrPadVens) + ")")

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SIGCDCLI " + ;
                       "WHERE RTRIM(rclis) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       loc_cFiltroGrupo + ;
                       " ORDER BY rclis"

            IF USED("cursor_4c_BuscaResp")
                USE IN cursor_4c_BuscaResp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaResp") > 0
                SELECT cursor_4c_BuscaResp
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaResp")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar respons" + CHR(225) + "vel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarClientePorCpf - Lookup SigCdCli por cpfs (CPF/CNPJ)
    * Popula cursor_4c_BuscaCliente com iclis, rclis, cpfs
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarClientePorCpf(par_cCpf)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT iclis, rclis, cpfs FROM SIGCDCLI " + ;
                       "WHERE RTRIM(cpfs) = " + EscaparSQL(PADR(ALLTRIM(par_cCpf), 20))

            IF USED("cursor_4c_BuscaCliente")
                USE IN cursor_4c_BuscaCliente
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCliente") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaCliente")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar cliente por CPF")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarOperacaoPorNome - Valida existencia da operacao em SigCdOpe
    * Equivale a fAcessoMovmto - verifica que Dopes existe
    * Popula cursor_4c_BuscaOpe com Dopes
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarOperacaoPorNome(par_cNome)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Dopes FROM SigCdOpe " + ;
                       "WHERE RTRIM(Dopes) = RTRIM(" + EscaparSQL(par_cNome) + ")"

            IF USED("cursor_4c_BuscaOpe")
                USE IN cursor_4c_BuscaOpe
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaOpe")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar opera" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarEmpresaPorCodigo - Lookup sigcdemp por cemps
    * Equivale a fAcessoEmpresa modo C
    * Popula cursor_4c_BuscaEmp com cemps, razas
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarEmpresaPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cemps, razas FROM sigcdemp " + ;
                       "WHERE RTRIM(cemps) = RTRIM(" + EscaparSQL(par_cCodigo) + ")"

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaEmp")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar empresa")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia registro atual de cursor SigMvCab para propriedades
    * Usado quando form carrega movimentacao selecionada (double-click no grid de sigpres2)
    * par_cAliasCursor: nome do cursor com dados de SigMvCab (a.* da ExecutarConsulta)
    * Retorna .T. se mapeou com sucesso
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED(par_cAliasCursor)
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)

            IF EOF() OR BOF()
                loc_lSucesso = .F.
            ENDIF

            IF TYPE(par_cAliasCursor + ".emps") != "U"
                THIS.this_cCdEmpresa = NVL(emps, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".dopes") != "U"
                THIS.this_cNmOperacao = NVL(dopes, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".datas") != "U"
                THIS.this_dDtInicial = IIF(ISNULL(datas), {}, datas)
                THIS.this_dDtFinal   = IIF(ISNULL(datas), {}, datas)
            ENDIF
            IF TYPE(par_cAliasCursor + ".numes") != "U"
                THIS.this_nNumero = NVL(numes, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".nops") != "U"
                THIS.this_nOp = NVL(nops, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".pstatus") != "U"
                THIS.this_cPStatus = NVL(pstatus, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".grupoos") != "U"
                THIS.this_cGrupo = NVL(grupoos, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".contaos") != "U"
                THIS.this_cConta = NVL(contaos, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".vends") != "U"
                THIS.this_cResps = NVL(vends, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".chksubn") != "U"
                IF VARTYPE(chksubn) = "N"
                    THIS.this_nOptPendente = IIF(NVL(chksubn, 0) = 1, 2, 1)
                ELSE
                    THIS.this_nOptPendente = IIF(NVL(chksubn, .F.), 2, 1)
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar do cursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Nao suportado
    * SigPrEs1 eh form OPERACIONAL de consulta/relatorio (Posicao Por Movimentacao).
    * Os registros de SigMvCab sao criados/mantidos pelos forms de movimentacao
    * (sigcdmov e derivados). Este BO apenas consulta - retorna .F. explicitamente
    * para impedir uso indevido em vez de gravar dados inconsistentes.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        MsgAviso("Este relat" + CHR(243) + "rio de posi" + CHR(231) + CHR(227) + "o eh somente leitura. " + ;
                "Use os formul" + CHR(225) + "rios de movimenta" + CHR(231) + CHR(227) + "o para incluir registros.", ;
                "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Atualizar - Nao suportado
    * Ver comentario em Inserir(). Consultas/relatorios nao atualizam SigMvCab.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        MsgAviso("Este relat" + CHR(243) + "rio de posi" + CHR(231) + CHR(227) + "o eh somente leitura. " + ;
                "Use os formul" + CHR(225) + "rios de movimenta" + CHR(231) + CHR(227) + "o para alterar registros.", ;
                "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
        RETURN .F.
    ENDPROC

    *==========================================================================
    * BuscarEmpresaPorDescricao - Lookup sigcdemp por razas
    * Equivale a fAcessoEmpresa modo D
    * Popula cursor_4c_BuscaEmp com cemps, razas
    * Retorna .T. se encontrou exatamente 1 match
    *==========================================================================
    PROCEDURE BuscarEmpresaPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cemps, razas FROM sigcdemp " + ;
                       "WHERE RTRIM(razas) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       " ORDER BY razas"

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp") > 0
                SELECT cursor_4c_BuscaEmp
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaEmp")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar empresa")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

