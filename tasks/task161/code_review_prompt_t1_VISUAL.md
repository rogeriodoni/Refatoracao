# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 275: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCfn.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1827 linhas total):

*-- Linhas 99 a 107:
99: 
100:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
101:                 *-- Definir caption do form
102:                 THIS.Caption = "C" + CHR(225) + "lculo de Juros"
103: 
104:                 *-- Construir cabecalho com titulo
105:                 THIS.ConfigurarCabecalho()
106: 
107:                 *-- Construir PageFrame com Page1 (Calculo) e Page2 (Vencimentos)

*-- Linhas 153 a 204:
153:         *-- Container cabecalho escuro (cntSombra)
154:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
155:         WITH THIS.cnt_4c_Cabecalho
156:             .Top         = 0
157:             .Left        = 0
158:             .Width       = loc_nFormWidth
159:             .Height      = 80
160:             .BackStyle   = 1
161:             .BackColor   = RGB(100, 100, 100)
162:             .BorderWidth = 0
163:             .Visible     = .T.
164: 
165:             *-- Label sombra (preto, deslocado 1px para efeito 3D)
166:             .AddObject("lbl_4c_Sombra", "Label")
167:             WITH .lbl_4c_Sombra
168:                 .FontBold  = .T.
169:                 .FontName  = "Tahoma"
170:                 .FontSize  = 18
171:                 .WordWrap  = .T.
172:                 .Alignment = 0
173:                 .BackStyle = 0
174:                 .AutoSize  = .F.
175:                 .Width     = loc_nFormWidth
176:                 .Height    = 40
177:                 .Top       = 18
178:                 .Left      = 10
179:                 .ForeColor = RGB(0, 0, 0)
180:                 .Caption   = loc_cCaption
181:                 .Visible   = .T.
182:             ENDWITH
183: 
184:             *-- Label titulo (branco - texto visivel)
185:             .AddObject("lbl_4c_Titulo", "Label")
186:             WITH .lbl_4c_Titulo
187:                 .FontBold  = .T.
188:                 .FontName  = "Tahoma"
189:                 .FontSize  = 18
190:                 .WordWrap  = .T.
191:                 .Alignment = 0
192:                 .BackStyle = 0
193:                 .AutoSize  = .F.
194:                 .Width     = loc_nFormWidth
195:                 .Height    = 46
196:                 .Top       = 17
197:                 .Left      = 10
198:                 .ForeColor = RGB(255, 255, 255)
199:                 .Caption   = loc_cCaption
200:                 .Visible   = .T.
201:             ENDWITH
202:         ENDWITH
203:     ENDPROC
204: 

*-- Linhas 219 a 245:
219:         *-- Container do PageFrame principal
220:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
221:         WITH THIS.pgf_4c_Paginas
222:             .Top        = loc_nTopPgf
223:             .Left       = 0
224:             .Width      = loc_nWidthPgf
225:             .Height     = loc_nHeightPgf
226:             .PageCount  = 2
227:             .Tabs       = .F.
228:             .BorderWidth = 0
229:             .BackStyle   = 0
230:             .Themes     = .F.
231:             .Visible    = .T.
232: 
233:             *-- Page1: Calculo principal (campos serao adicionados nas Fases 4-6)
234:             WITH .Page1
235:                 .Caption = "C" + CHR(225) + "lculo"
236:             ENDWITH
237: 
238:             *-- Page2: Vencimentos (parcelas serao adicionadas nas Fases 5-6)
239:             WITH .Page2
240:                 .Caption = "Vencimentos"
241:                 .BackColor = RGB(240, 240, 240)
242:             ENDWITH
243: 
244:             .ActivePage = 1
245:         ENDWITH

*-- Linhas 257 a 281:
257:         *-- Container do botao Encerrar (transparente sobre cabecalho)
258:         THIS.AddObject("cnt_4c_Botoes", "Container")
259:         WITH THIS.cnt_4c_Botoes
260:             .Top         = 0
261:             .Left        = loc_nFormWidth - 90
262:             .Width       = 90
263:             .Height      = 85
264:             .BackStyle   = 0
265:             .BorderWidth = 0
266:             .Visible     = .T.
267: 
268:             .AddObject("cmd_4c_Encerrar", "CommandButton")
269:             WITH .cmd_4c_Encerrar
270:                 .Top             = 5
271:                 .Left            =  542
272:                 .Width           = 75
273:                 .Height          = 75
274:                 .Caption         = "Encerrar"
275:                 .FontName        = "Comic Sans MS"
276:                 .FontBold        = .T.
277:                 .FontItalic      = .T.
278:                 .FontSize        = 8
279:                 .ForeColor       = RGB(90, 90, 90)
280:                 .BackColor       = RGB(255, 255, 255)
281:                 .SpecialEffect   = 0

*-- Linhas 290 a 298:
290:             ENDWITH
291:         ENDWITH
292: 
293:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
294:     ENDPROC
295: 
296:     *===========================================================================
297:     * ConfigurarBotoesAcao - Cria container cnt_4c_BotoesAcao (botoes de acao)
298:     * Container reservado para botoes de acao especificos (adicionados nas Fases 4-7)

*-- Linhas 305 a 337:
305:         *-- Container de botoes de acao (posicionado no rodape das paginas)
306:         THIS.AddObject("cnt_4c_BotoesAcao", "Container")
307:         WITH THIS.cnt_4c_BotoesAcao
308:             .Top         = THIS.Height - 40
309:             .Left        = 0
310:             .Width       = loc_nFormWidth
311:             .Height      = 40
312:             .BackStyle   = 0
313:             .BorderWidth = 0
314:             .Visible     = .T.
315: 
316:             .AddObject("cmd_4c_Limpar", "CommandButton")
317:             WITH .cmd_4c_Limpar
318:                 .Top          = 5
319:                 .Left         = 10
320:                 .Width        = 90
321:                 .Height       = 28
322:                 .Caption      = "Limpar"
323:                 .FontName     = "Tahoma"
324:                 .FontBold     = .T.
325:                 .FontSize     = 8
326:                 .ForeColor    = RGB(90, 90, 90)
327:                 .BackColor    = RGB(240, 240, 240)
328:                 .MousePointer = 15
329:             ENDWITH
330:         ENDWITH
331: 
332:         BINDEVENT(THIS.cnt_4c_BotoesAcao.cmd_4c_Limpar, "Click", THIS, "CmdLimparClick")
333:     ENDPROC
334: 
335:     *===========================================================================
336:     * CmdEncerrarClick - Fecha o formulario (ESC ou clique no botao Encerrar)
337:     *===========================================================================

*-- Linhas 389 a 442:
389:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
390: 
391:         *-- Label "Valor Base :"
392:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
393:         WITH loc_oPagina.lbl_4c_Label1
394:             .Top       = 11
395:             .Left      = 36
396:             .AutoSize  = .T.
397:             .BackStyle = 0
398:             .Caption   = "Valor Base :"
399:             .FontName  = "Tahoma"
400:             .FontSize  = 8
401:             .ForeColor = RGB(90, 90, 90)
402:         ENDWITH
403: 
404:         *-- Campo Valor Base
405:         loc_oPagina.AddObject("txt_4c_ValorBase", "TextBox")
406:         WITH loc_oPagina.txt_4c_ValorBase
407:             .Top       = 7
408:             .Left      = 97
409:             .Width     = 115
410:             .Height    = 23
411:             .Value     = 0
412:             .Format    = "NR"
413:             .InputMask = "################.##"
414:             .Alignment = 1
415:             .FontName  = "Tahoma"
416:             .FontSize  = 8
417:             .ForeColor = RGB(90, 90, 90)
418:         ENDWITH
419: 
420:         *-- Label "Juros/Mes :"
421:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
422:         WITH loc_oPagina.lbl_4c_Label3
423:             .Top       = 39
424:             .Left      = 37
425:             .AutoSize  = .T.
426:             .BackStyle = 0
427:             .Caption   = "Juros/M" + CHR(234) + "s :"
428:             .FontName  = "Tahoma"
429:             .FontSize  = 8
430:             .ForeColor = RGB(90, 90, 90)
431:         ENDWITH
432: 
433:         *-- Campo Juros/Mes
434:         loc_oPagina.AddObject("txt_4c_JurosMes", "TextBox")
435:         WITH loc_oPagina.txt_4c_JurosMes
436:             .Top       = 35
437:             .Left      = 97
438:             .Width     = 59
439:             .Height    = 23
440:             .Value     = 0
441:             .Format    = "NR"
442:             .InputMask = "###.#####"

*-- Linhas 448 a 543:
448:         ENDWITH
449: 
450:         *-- Label "%"
451:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
452:         WITH loc_oPagina.lbl_4c_Label4
453:             .Top       = 39
454:             .Left      = 159
455:             .AutoSize  = .T.
456:             .BackStyle = 0
457:             .Caption   = "%"
458:             .FontName  = "Tahoma"
459:             .FontSize  = 8
460:             .ForeColor = RGB(90, 90, 90)
461:         ENDWITH
462: 
463:         *-- Label "Data Base :"
464:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
465:         WITH loc_oPagina.lbl_4c_Label6
466:             .Top       = 11
467:             .Left      = 295
468:             .AutoSize  = .T.
469:             .BackStyle = 0
470:             .Caption   = "Data Base :"
471:             .FontName  = "Tahoma"
472:             .FontSize  = 8
473:             .ForeColor = RGB(90, 90, 90)
474:         ENDWITH
475: 
476:         *-- Campo Data Base
477:         loc_oPagina.AddObject("txt_4c_DataBase", "TextBox")
478:         WITH loc_oPagina.txt_4c_DataBase
479:             .Top       = 7
480:             .Left      = 355
481:             .Width     = 80
482:             .Height    = 23
483:             .Value     = {}
484:             .Format    = "D"
485:             .InputMask = "99/99/9999"
486:             .FontName  = "Tahoma"
487:             .FontSize  = 8
488:             .ForeColor = RGB(90, 90, 90)
489:             .Enabled   = .F.
490:         ENDWITH
491: 
492:         *-- Label "Data Final / Dias :"
493:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
494:         WITH loc_oPagina.lbl_4c_Label7
495:             .Top       = 39
496:             .Left      = 266
497:             .AutoSize  = .T.
498:             .BackStyle = 0
499:             .Caption   = "Data Final / Dias :"
500:             .FontName  = "Tahoma"
501:             .FontSize  = 8
502:             .ForeColor = RGB(90, 90, 90)
503:         ENDWITH
504: 
505:         *-- Campo Data Final
506:         loc_oPagina.AddObject("txt_4c_DataFinal", "TextBox")
507:         WITH loc_oPagina.txt_4c_DataFinal
508:             .Top       = 35
509:             .Left      = 355
510:             .Width     = 80
511:             .Height    = 23
512:             .Value     = {}
513:             .Format    = "D"
514:             .InputMask = "99/99/9999"
515:             .FontName  = "Tahoma"
516:             .FontSize  = 8
517:             .ForeColor = RGB(90, 90, 90)
518:             .Enabled   = .F.
519:         ENDWITH
520: 
521:         *-- Label "/"
522:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
523:         WITH loc_oPagina.lbl_4c_Label8
524:             .Top       = 39
525:             .Left      = 441
526:             .AutoSize  = .T.
527:             .BackStyle = 0
528:             .Caption   = "/"
529:             .FontName  = "Tahoma"
530:             .FontSize  = 8
531:             .ForeColor = RGB(90, 90, 90)
532:         ENDWITH
533: 
534:         *-- Campo Dias (numero de dias entre datas)
535:         loc_oPagina.AddObject("txt_4c_Dias", "TextBox")
536:         WITH loc_oPagina.txt_4c_Dias
537:             .Top       = 35
538:             .Left      = 453
539:             .Width     = 38
540:             .Height    = 23
541:             .Value     = 0
542:             .Format    = "NR"
543:             .InputMask = "####"

*-- Linhas 549 a 626:
549:         ENDWITH
550: 
551:         *-- Label "Calculo :"
552:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
553:         WITH loc_oPagina.lbl_4c_Label2
554:             .Top       = 63
555:             .Left      = 310
556:             .AutoSize  = .T.
557:             .BackStyle = 0
558:             .Caption   = "C" + CHR(225) + "lculo :"
559:             .FontName  = "Tahoma"
560:             .FontSize  = 8
561:             .ForeColor = RGB(90, 90, 90)
562:         ENDWITH
563: 
564:         *-- OptionGroup tipo de calculo (Simples/Composto)
565:         loc_oPagina.AddObject("obj_4c_OptCalculo", "OptionGroup")
566:         WITH loc_oPagina.obj_4c_OptCalculo
567:             .Top         = 60
568:             .Left        = 351
569:             .Width       = 155
570:             .Height      = 21
571:             .ButtonCount = 2
572:             .BackStyle   = 0
573:             .BorderStyle = 0
574:             .Value       = THIS.this_nParTipoCalculo
575:             .Enabled     = .F.
576: 
577:             WITH .Buttons(1)
578:                 .Caption   = "Simples"
579:                 .BackStyle = 0
580:                 .ForeColor = RGB(90, 90, 90)
581:                 .Width     = 60
582:                 .Height    = 21
583:                 .Top       = 0
584:                 .Left      = 0
585:                 .AutoSize  = .F.
586:                 .Themes    = .F.
587:             ENDWITH
588: 
589:             WITH .Buttons(2)
590:                 .Caption   = "Composto"
591:                 .BackStyle = 0
592:                 .FontName  = "Tahoma"
593:                 .FontSize  = 8
594:                 .ForeColor = RGB(90, 90, 90)
595:                 .Width     = 75
596:                 .Height    = 21
597:                 .Top       = 0
598:                 .Left      = 63
599:                 .AutoSize  = .F.
600:                 .Themes    = .F.
601:             ENDWITH
602:         ENDWITH
603: 
604:         *-- Label "Juros por Dia :"
605:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
606:         WITH loc_oPagina.lbl_4c_Label5
607:             .Top       = 68
608:             .Left      = 23
609:             .AutoSize  = .T.
610:             .BackStyle = 0
611:             .Caption   = "Juros por Dia :"
612:             .FontName  = "Tahoma"
613:             .FontSize  = 8
614:             .ForeColor = RGB(90, 90, 90)
615:         ENDWITH
616: 
617:         *-- Campo Juros por Dia
618:         loc_oPagina.AddObject("txt_4c_JurosDia", "TextBox")
619:         WITH loc_oPagina.txt_4c_JurosDia
620:             .Top       = 64
621:             .Left      = 97
622:             .Width     = 136
623:             .Height    = 23
624:             .Value     = 0
625:             .Format    = "NR"
626:             .InputMask = "###.#########"

*-- Linhas 632 a 721:
632:         ENDWITH
633: 
634:         *-- Label "Dias :"
635:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
636:         WITH loc_oPagina.lbl_4c_Label13
637:             .Top       = 81
638:             .Left      = 324
639:             .AutoSize  = .T.
640:             .BackStyle = 0
641:             .Caption   = "Dias :"
642:             .FontName  = "Tahoma"
643:             .FontSize  = 8
644:             .ForeColor = RGB(90, 90, 90)
645:         ENDWITH
646: 
647:         *-- OptionGroup tipo de contagem de dias (Corridos/Nao Corridos)
648:         loc_oPagina.AddObject("obj_4c_OptDias", "OptionGroup")
649:         WITH loc_oPagina.obj_4c_OptDias
650:             .Top         = 78
651:             .Left        = 351
652:             .Width       = 175
653:             .Height      = 21
654:             .ButtonCount = 2
655:             .BackStyle   = 0
656:             .BorderStyle = 0
657:             .Value       = 1
658:             .Enabled     = .F.
659: 
660:             WITH .Buttons(1)
661:                 .Caption   = "Corridos"
662:                 .BackStyle = 0
663:                 .ForeColor = RGB(90, 90, 90)
664:                 .Width     = 65
665:                 .Height    = 21
666:                 .Top       = 0
667:                 .Left      = 0
668:                 .AutoSize  = .F.
669:                 .Themes    = .F.
670:             ENDWITH
671: 
672:             WITH .Buttons(2)
673:                 .Caption   = "N" + CHR(227) + "o Corridos"
674:                 .BackStyle = 0
675:                 .FontName  = "Tahoma"
676:                 .FontSize  = 8
677:                 .ForeColor = RGB(90, 90, 90)
678:                 .Width     = 100
679:                 .Height    = 21
680:                 .Top       = 0
681:                 .Left      = 68
682:                 .AutoSize  = .F.
683:                 .Themes    = .F.
684:             ENDWITH
685:         ENDWITH
686: 
687:         *-- Separador visual (equivalente ao Commandgroup1 Height=1 do original)
688:         loc_oPagina.AddObject("lbl_4c_Separador", "Label")
689:         WITH loc_oPagina.lbl_4c_Separador
690:             .Top       = 100
691:             .Left      = 6
692:             .Width     = 586
693:             .Height    = 1
694:             .BackStyle = 1
695:             .BackColor = RGB(180, 180, 180)
696:             .Caption   = ""
697:         ENDWITH
698: 
699:         *-- Label "Juros :"
700:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
701:         WITH loc_oPagina.lbl_4c_Label9
702:             .Top       = 107
703:             .Left      = 60
704:             .AutoSize  = .T.
705:             .BackStyle = 0
706:             .Caption   = "Juros :"
707:             .FontName  = "Tahoma"
708:             .FontSize  = 8
709:             .ForeColor = RGB(90, 90, 90)
710:         ENDWITH
711: 
712:         *-- Campo Valor Juros (resultado - somente leitura)
713:         loc_oPagina.AddObject("txt_4c_ValorJuros", "TextBox")
714:         WITH loc_oPagina.txt_4c_ValorJuros
715:             .Top       = 103
716:             .Left      = 97
717:             .Width     = 136
718:             .Height    = 23
719:             .Value     = 0
720:             .Format    = "NR"
721:             .InputMask = "################.##"

*-- Linhas 727 a 751:
727:         ENDWITH
728: 
729:         *-- Label "Total :"
730:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
731:         WITH loc_oPagina.lbl_4c_Label10
732:             .Top       = 107
733:             .Left      = 276
734:             .AutoSize  = .T.
735:             .BackStyle = 0
736:             .Caption   = "Total :"
737:             .FontName  = "Tahoma"
738:             .FontSize  = 8
739:             .ForeColor = RGB(90, 90, 90)
740:         ENDWITH
741: 
742:         *-- Campo Valor Total (resultado - somente leitura)
743:         loc_oPagina.AddObject("txt_4c_ValorTotal", "TextBox")
744:         WITH loc_oPagina.txt_4c_ValorTotal
745:             .Top       = 103
746:             .Left      = 311
747:             .Width     = 136
748:             .Height    = 23
749:             .Value     = 0
750:             .Format    = "NR"
751:             .InputMask = "################.##"

*-- Linhas 757 a 781:
757:         ENDWITH
758: 
759:         *-- Label "Parcela :"
760:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
761:         WITH loc_oPagina.lbl_4c_Label12
762:             .Top       = 131
763:             .Left      = 265
764:             .AutoSize  = .T.
765:             .BackStyle = 0
766:             .Caption   = "Parcela :"
767:             .FontName  = "Tahoma"
768:             .FontSize  = 8
769:             .ForeColor = RGB(90, 90, 90)
770:         ENDWITH
771: 
772:         *-- Campo Valor Parcela (resultado - somente leitura)
773:         loc_oPagina.AddObject("txt_4c_Valorpar", "TextBox")
774:         WITH loc_oPagina.txt_4c_Valorpar
775:             .Top       = 127
776:             .Left      = 311
777:             .Width     = 136
778:             .Height    = 23
779:             .Value     = 0
780:             .Format    = "NR"
781:             .InputMask = "################.##"

*-- Linhas 787 a 811:
787:         ENDWITH
788: 
789:         *-- Botao para navegar para Page2 (Vencimentos)
790:         loc_oPagina.AddObject("cmd_4c_Vencimentos", "CommandButton")
791:         WITH loc_oPagina.cmd_4c_Vencimentos
792:             .Top          = 127
793:             .Left         = 97
794:             .Width        = 136
795:             .Height       = 23
796:             .Caption      = "Vencimentos >>"
797:             .FontName     = "Tahoma"
798:             .FontBold     = .T.
799:             .FontSize     = 8
800:             .ForeColor    = RGB(90, 90, 90)
801:             .BackColor    = RGB(240, 240, 240)
802:             .Themes       = .T.
803:             .MousePointer = 15
804:         ENDWITH
805: 
806:         BINDEVENT(loc_oPagina.cmd_4c_Vencimentos, "Click",           THIS, "CmdVencimentosClick")
807:         BINDEVENT(loc_oPagina.txt_4c_ValorBase,   "KeyPress",        THIS, "TxtValorBaseKeyPress")
808:         BINDEVENT(loc_oPagina.txt_4c_JurosMes,    "KeyPress",        THIS, "TxtJurosMesKeyPress")
809:         BINDEVENT(loc_oPagina.txt_4c_JurosDia,    "KeyPress",        THIS, "TxtJurosDiaKeyPress")
810:         BINDEVENT(loc_oPagina.txt_4c_DataBase,    "KeyPress",        THIS, "TxtDataBaseKeyPress")
811:         BINDEVENT(loc_oPagina.txt_4c_DataFinal,   "KeyPress",        THIS, "TxtDataFinalKeyPress")

*-- Linhas 1238 a 1293:
1238:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1239: 
1240:         *-- Botao Voltar (navega de volta para Page1 - Calculo)
1241:         loc_oPagina.AddObject("cmd_4c_Voltar", "CommandButton")
1242:         WITH loc_oPagina.cmd_4c_Voltar
1243:             .Top          = 5
1244:             .Left         = 5
1245:             .Width        = 110
1246:             .Height       = 23
1247:             .Caption      = "< C" + CHR(225) + "lculo"
1248:             .FontName     = "Tahoma"
1249:             .FontBold     = .T.
1250:             .FontSize     = 8
1251:             .ForeColor    = RGB(90, 90, 90)
1252:             .BackColor    = RGB(240, 240, 240)
1253:             .Themes       = .T.
1254:             .MousePointer = 15
1255:         ENDWITH
1256: 
1257:         *-- Label "Vencimentos :"
1258:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
1259:         WITH loc_oPagina.lbl_4c_Label11
1260:             .Top       = 75
1261:             .Left      = 26
1262:             .AutoSize  = .T.
1263:             .BackStyle = 0
1264:             .Caption   = "Vencimentos :"
1265:             .FontName  = "Tahoma"
1266:             .FontSize  = 8
1267:             .ForeColor = RGB(90, 90, 90)
1268:         ENDWITH
1269: 
1270:         *-- Coluna 1: venc1 (linha 1) + venc2 (linha 2)
1271:         loc_oPagina.AddObject("txt_4c_Venc1", "TextBox")
1272:         WITH loc_oPagina.txt_4c_Venc1
1273:             .Top       = 71
1274:             .Left      = 97
1275:             .Width     = 80
1276:             .Height    = 23
1277:             .Value     = {}
1278:             .Format    = "D"
1279:             .InputMask = "99/99/9999"
1280:             .FontName  = "Tahoma"
1281:             .FontSize  = 8
1282:             .ForeColor = RGB(90, 90, 90)
1283:         ENDWITH
1284: 
1285:         loc_oPagina.AddObject("txt_4c_Venc2", "TextBox")
1286:         WITH loc_oPagina.txt_4c_Venc2
1287:             .Top       = 98
1288:             .Left      = 97
1289:             .Width     = 80
1290:             .Height    = 23
1291:             .Value     = {}
1292:             .Format    = "D"
1293:             .InputMask = "99/99/9999"

*-- Linhas 1299 a 1322:
1299:         *-- Coluna 2: venc3 (linha 1) + venc4 (linha 2)
1300:         loc_oPagina.AddObject("txt_4c_Venc3", "TextBox")
1301:         WITH loc_oPagina.txt_4c_Venc3
1302:             .Top       = 71
1303:             .Left      = 184
1304:             .Width     = 80
1305:             .Height    = 23
1306:             .Value     = {}
1307:             .Format    = "D"
1308:             .InputMask = "99/99/9999"
1309:             .FontName  = "Tahoma"
1310:             .FontSize  = 8
1311:             .ForeColor = RGB(90, 90, 90)
1312:         ENDWITH
1313: 
1314:         loc_oPagina.AddObject("txt_4c_Venc4", "TextBox")
1315:         WITH loc_oPagina.txt_4c_Venc4
1316:             .Top       = 98
1317:             .Left      = 184
1318:             .Width     = 80
1319:             .Height    = 23
1320:             .Value     = {}
1321:             .Format    = "D"
1322:             .InputMask = "99/99/9999"

*-- Linhas 1328 a 1351:
1328:         *-- Coluna 3: venc5 (linha 1) + venc6 (linha 2)
1329:         loc_oPagina.AddObject("txt_4c_Venc5", "TextBox")
1330:         WITH loc_oPagina.txt_4c_Venc5
1331:             .Top       = 71
1332:             .Left      = 271
1333:             .Width     = 80
1334:             .Height    = 23
1335:             .Value     = {}
1336:             .Format    = "D"
1337:             .InputMask = "99/99/9999"
1338:             .FontName  = "Tahoma"
1339:             .FontSize  = 8
1340:             .ForeColor = RGB(90, 90, 90)
1341:         ENDWITH
1342: 
1343:         loc_oPagina.AddObject("txt_4c_Venc6", "TextBox")
1344:         WITH loc_oPagina.txt_4c_Venc6
1345:             .Top       = 98
1346:             .Left      = 271
1347:             .Width     = 80
1348:             .Height    = 23
1349:             .Value     = {}
1350:             .Format    = "D"
1351:             .InputMask = "99/99/9999"

*-- Linhas 1357 a 1380:
1357:         *-- Coluna 4: venc7 (linha 1) + venc8 (linha 2)
1358:         loc_oPagina.AddObject("txt_4c_Venc7", "TextBox")
1359:         WITH loc_oPagina.txt_4c_Venc7
1360:             .Top       = 71
1361:             .Left      = 358
1362:             .Width     = 80
1363:             .Height    = 23
1364:             .Value     = {}
1365:             .Format    = "D"
1366:             .InputMask = "99/99/9999"
1367:             .FontName  = "Tahoma"
1368:             .FontSize  = 8
1369:             .ForeColor = RGB(90, 90, 90)
1370:         ENDWITH
1371: 
1372:         loc_oPagina.AddObject("txt_4c_Venc8", "TextBox")
1373:         WITH loc_oPagina.txt_4c_Venc8
1374:             .Top       = 98
1375:             .Left      = 358
1376:             .Width     = 80
1377:             .Height    = 23
1378:             .Value     = {}
1379:             .Format    = "D"
1380:             .InputMask = "99/99/9999"

*-- Linhas 1386 a 1420:
1386:         *-- Coluna 5: venc9 (linha 1) + venc10 (linha 2)
1387:         loc_oPagina.AddObject("txt_4c_Venc9", "TextBox")
1388:         WITH loc_oPagina.txt_4c_Venc9
1389:             .Top       = 71
1390:             .Left      = 445
1391:             .Width     = 80
1392:             .Height    = 23
1393:             .Value     = {}
1394:             .Format    = "D"
1395:             .InputMask = "99/99/9999"
1396:             .FontName  = "Tahoma"
1397:             .FontSize  = 8
1398:             .ForeColor = RGB(90, 90, 90)
1399:         ENDWITH
1400: 
1401:         loc_oPagina.AddObject("txt_4c_Venc10", "TextBox")
1402:         WITH loc_oPagina.txt_4c_Venc10
1403:             .Top       = 98
1404:             .Left      = 445
1405:             .Width     = 80
1406:             .Height    = 23
1407:             .Value     = {}
1408:             .Format    = "D"
1409:             .InputMask = "99/99/9999"
1410:             .FontName  = "Tahoma"
1411:             .FontSize  = 8
1412:             .ForeColor = RGB(90, 90, 90)
1413:         ENDWITH
1414: 
1415:         BINDEVENT(loc_oPagina.cmd_4c_Voltar,  "Click",    THIS, "CmdVoltarClick")
1416:         BINDEVENT(loc_oPagina.txt_4c_Venc1,   "KeyPress", THIS, "TxtVencKeyPress")
1417:         BINDEVENT(loc_oPagina.txt_4c_Venc2,   "KeyPress", THIS, "TxtVencKeyPress")
1418:         BINDEVENT(loc_oPagina.txt_4c_Venc3,   "KeyPress", THIS, "TxtVencKeyPress")
1419:         BINDEVENT(loc_oPagina.txt_4c_Venc4,   "KeyPress", THIS, "TxtVencKeyPress")
1420:         BINDEVENT(loc_oPagina.txt_4c_Venc5,   "KeyPress", THIS, "TxtVencKeyPress")

*-- Linhas 1640 a 1649:
1640: 
1641:         loc_lTemCalculo = (THIS.pgf_4c_Paginas.Page1.txt_4c_ValorBase.Value > 0)
1642: 
1643:         IF PEMSTATUS(THIS.cnt_4c_BotoesAcao, "cmd_4c_Limpar", 5)
1644:             THIS.cnt_4c_BotoesAcao.cmd_4c_Limpar.Enabled = loc_lTemCalculo
1645:         ENDIF
1646:     ENDPROC
1647: 
1648:     *===========================================================================
1649:     * LimparCampos - Limpa todos os campos de entrada e resultado


### BO (C:\4c\projeto\app\classes\SigPrCfnBO.prg):
*===============================================================================
* SigPrCfnBO.prg - Business Object para Calculo de Juros (SIGPRCFN)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (sem tabela BD - calculo puro)
*===============================================================================

DEFINE CLASS SigPrCfnBO AS BusinessBase

    *-- Identificacao (sem tabela BD - form de calculo)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Entradas do calculo
    this_nValorBase    = 0
    this_nJurosMes     = 0
    this_nJurosDia     = 0
    this_dDataBase     = {}
    this_dDataFinal    = {}
    this_nDias         = 0
    this_nTipoCalculo  = 1  && 1=Simples, 2=Composto
    this_nTipoDias     = 1  && 1=Corridos, 2=Uteis

    *-- Resultados do calculo
    this_nValorJuros   = 0
    this_nValorTotal   = 0
    this_nValorParcela = 0

    *-- Vencimentos (ate 10 parcelas)
    this_dVenc1  = {}
    this_dVenc2  = {}
    this_dVenc3  = {}
    this_dVenc4  = {}
    this_dVenc5  = {}
    this_dVenc6  = {}
    this_dVenc7  = {}
    this_dVenc8  = {}
    this_dVenc9  = {}
    this_dVenc10 = {}

    *---------------------------------------------------------------------------
    * Init - Inicializa o BO de calculo de juros
    *---------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            this.this_cTabela     = ""
            this.this_cCampoChave = ""

            this.LimparPropriedades()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * LimparPropriedades - Reseta todas as propriedades para valores iniciais
    *---------------------------------------------------------------------------
    PROCEDURE LimparPropriedades()
        THIS.this_nValorBase    = 0
        THIS.this_nJurosMes     = 0
        THIS.this_nJurosDia     = 0
        THIS.this_dDataBase     = {}
        THIS.this_dDataFinal    = {}
        THIS.this_nDias         = 0
        THIS.this_nTipoCalculo  = 1
        THIS.this_nTipoDias     = 1
        THIS.this_nValorJuros   = 0
        THIS.this_nValorTotal   = 0
        THIS.this_nValorParcela = 0
        THIS.this_dVenc1        = {}
        THIS.this_dVenc2        = {}
        THIS.this_dVenc3        = {}
        THIS.this_dVenc4        = {}
        THIS.this_dVenc5        = {}
        THIS.this_dVenc6        = {}
        THIS.this_dVenc7        = {}
        THIS.this_dVenc8        = {}
        THIS.this_dVenc9        = {}
        THIS.this_dVenc10       = {}
    ENDPROC


    *---------------------------------------------------------------------------
    * InicializarComParametros - Recebe parametros do chamador e prepara calculo
    * Logica identica ao Init do SIGPRCFN original (pVal, pTip, pJMe, pJDi, pDtB, pDtF)
    *---------------------------------------------------------------------------
    PROCEDURE InicializarComParametros(par_nValorBase, par_nTipoCalculo, ;
                                        par_nJurosMes, par_nJurosDia, ;
                                        par_dDataBase, par_dDataFinal)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.LimparPropriedades()

            IF VARTYPE(par_nValorBase) = "N" AND par_nValorBase > 0
                THIS.this_nValorBase = par_nValorBase
            ENDIF

            IF VARTYPE(par_nTipoCalculo) = "N" AND INLIST(par_nTipoCalculo, 1, 2)
                THIS.this_nTipoCalculo = par_nTipoCalculo
            ENDIF

            IF VARTYPE(par_nJurosMes) = "N" AND par_nJurosMes > 0
                THIS.this_nJurosMes = par_nJurosMes
                THIS.ConverterJurosMesParaDia()
            ELSE
                IF VARTYPE(par_nJurosDia) = "N" AND par_nJurosDia > 0
                    THIS.this_nJurosDia = par_nJurosDia
                    THIS.ConverterJurosDiaParaMes()
                ENDIF
            ENDIF

            IF VARTYPE(par_dDataBase) = "D"
                THIS.this_dDataBase = par_dDataBase
            ENDIF

            IF VARTYPE(par_dDataFinal) = "D"
                THIS.this_dDataFinal = par_dDataFinal
            ELSE
                IF !EMPTY(THIS.this_dDataBase)
                    THIS.this_dDataFinal = DATE()
                ENDIF
            ENDIF

            IF !EMPTY(THIS.this_dDataBase) AND !EMPTY(THIS.this_dDataFinal)
                THIS.this_nDias = THIS.this_dDataFinal - THIS.this_dDataBase
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularJuros - Executa calculo de juros com as propriedades atuais
    * Logica identica ao metodo Calculos() do SIGPRCFN original
    * Retorna: .T. se calculo realizado, .F. se entradas invalidas
    *---------------------------------------------------------------------------
    PROCEDURE CalcularJuros()
        LOCAL loc_lSucesso, loc_nJuros, loc_nParc, loc_nTotDia, loc_nI, loc_nDia
        LOCAL ARRAY loc_aVenc[10]

        loc_lSucesso = .F.
        loc_nJuros   = 0
        loc_nParc    = 0
        loc_nTotDia  = 0

        TRY
            *-- Se algum campo obrigatorio estiver vazio, zerar resultados
            IF THIS.this_nValorBase = 0 OR ;
               THIS.this_nJurosMes  = 0 OR ;
               THIS.this_nJurosDia  = 0 OR ;
               EMPTY(THIS.this_dDataBase)  OR ;
               EMPTY(THIS.this_dDataFinal) OR ;
               THIS.this_nDias = 0
                THIS.this_nValorJuros   = 0
                THIS.this_nValorTotal   = 0
                THIS.this_nValorParcela = 0
                loc_lSucesso = .F.
            ENDIF

            *-- Calculo base (sem vencimentos)
            IF THIS.this_nTipoCalculo = 1
                *-- Juros Simples: J = PV * (i_mes/100) * (dias/30)
                loc_nJuros = ROUND(THIS.this_nValorBase * ;
                                  (THIS.this_nJurosMes / 100) * ;
                                  (THIS.this_nDias / 30), 2)
            ELSE
                *-- Juros Compostos: J = PV * ((1 + i_dia/100)^dias - 1)
                loc_nJuros = ROUND(THIS.this_nValorBase * ;
                                  (((1 + THIS.this_nJurosDia / 100) ^ THIS.this_nDias) - 1), 2)
            ENDIF

            *-- Verificar vencimentos: se algum informado, recalcular por parcela
            loc_aVenc[1]  = THIS.this_dVenc1
            loc_aVenc[2]  = THIS.this_dVenc2
            loc_aVenc[3]  = THIS.this_dVenc3
            loc_aVenc[4]  = THIS.this_dVenc4
            loc_aVenc[5]  = THIS.this_dVenc5
            loc_aVenc[6]  = THIS.this_dVenc6
            loc_aVenc[7]  = THIS.this_dVenc7
            loc_aVenc[8]  = THIS.this_dVenc8
            loc_aVenc[9]  = THIS.this_dVenc9
            loc_aVenc[10] = THIS.this_dVenc10

            FOR loc_nI = 1 TO 10
                IF !EMPTY(loc_aVenc[loc_nI])
                    IF loc_nParc = 0
                        *-- Primeira parcela encontrada: zera calculo base e recalcula por vencimento
                        loc_nJuros = 0
                    ENDIF

                    loc_nDia = loc_aVenc[loc_nI] - THIS.this_dDataBase

                    IF THIS.this_nTipoCalculo = 1
                        *-- Juros Simples por vencimento
                        loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                                       (THIS.this_nJurosMes / 100) * ;
                                                       (loc_nDia / 30), 2)
                    ELSE
                        *-- Juros Compostos por vencimento
                        loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                                       (((1 + THIS.this_nJurosDia / 100) ^ loc_nDia) - 1), 2)
                    ENDIF

                    loc_nTotDia = loc_nDia
                    loc_nParc   = loc_nParc + 1
                ENDIF
            ENDFOR

            *-- Se vencimentos preenchidos, atualizar this_nDias com o ultimo vencimento
            IF loc_nTotDia > 0
                THIS.this_nDias = loc_nTotDia
            ENDIF

            THIS.this_nValorJuros   = loc_nJuros
            THIS.this_nValorTotal   = THIS.this_nValorBase + loc_nJuros
            THIS.this_nValorParcela = THIS.this_nValorTotal / IIF(loc_nParc <> 0, loc_nParc, 1)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ConverterJurosMesParaDia - Converte taxa mensal para diaria e atualiza this_nJurosDia
    * Logica identica ao Valid de getJurosMes do SIGPRCFN original
    *---------------------------------------------------------------------------
    PROCEDURE ConverterJurosMesParaDia()
        LOCAL loc_nJurosDia

        IF THIS.this_nTipoCalculo = 1
            *-- Simples: i_dia = i_mes / 30
            loc_nJurosDia = ROUND(THIS.this_nJurosMes / 30, 9)
        ELSE
            *-- Composto: i_dia = ((1 + i_mes/100)^(1/30) - 1) * 100
            loc_nJurosDia = ROUND((((1 + THIS.this_nJurosMes / 100) ^ (1/30)) - 1) * 100, 9)
        ENDIF

        THIS.this_nJurosDia = loc_nJurosDia
    ENDPROC

    *---------------------------------------------------------------------------
    * ConverterJurosDiaParaMes - Converte taxa diaria para mensal e atualiza this_nJurosMes
    * Logica identica ao Valid de getJurosDia do SIGPRCFN original
    *---------------------------------------------------------------------------
    PROCEDURE ConverterJurosDiaParaMes()
        LOCAL loc_nJurosMes

        IF THIS.this_nTipoCalculo = 1
            *-- Simples: i_mes = i_dia * 30
            loc_nJurosMes = ROUND(THIS.this_nJurosDia * 30, 2)
        ELSE
            *-- Composto: i_mes = ((1 + i_dia/100)^30 - 1) * 100
            loc_nJurosMes = ROUND((((1 + THIS.this_nJurosDia / 100) ^ 30) - 1) * 100, 2)
        ENDIF

        THIS.this_nJurosMes = loc_nJurosMes
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularDias - Calcula dias entre data base e data final aplicando TipoDias
    * TipoDias 1=Corridos, 2=Uteis (desconta fins de semana e feriados)
    * Logica identica ao calculo de fChkFeriado do SIGPRCFN original
    * Atualiza this_nDias com o resultado
    *---------------------------------------------------------------------------
    PROCEDURE CalcularDias()
        LOCAL loc_nDias, loc_dAtual

        IF EMPTY(THIS.this_dDataBase) OR EMPTY(THIS.this_dDataFinal)
            THIS.this_nDias = 0
            RETURN
        ENDIF

        IF THIS.this_dDataFinal < THIS.this_dDataBase
            THIS.this_nDias = 0
            RETURN
        ENDIF

        *-- Calculo base: dias corridos
        loc_nDias = THIS.this_dDataFinal - THIS.this_dDataBase

        IF THIS.this_nTipoDias = 2 AND loc_nDias > 0
            *-- Subtrair dias nao uteis (fins de semana e feriados)
            loc_dAtual = THIS.this_dDataBase
            DO WHILE loc_dAtual <= THIS.this_dDataFinal
                IF !THIS.VerificarDiaUtil(loc_dAtual)
                    loc_nDias = loc_nDias - 1
                ENDIF
                loc_dAtual = loc_dAtual + 1
            ENDDO
        ENDIF

        THIS.this_nDias = loc_nDias
    ENDPROC

    *---------------------------------------------------------------------------
    * VerificarDiaUtil - Verifica se a data e um dia util
    * par_dData - Data a verificar
    * Retorna: .T. se util, .F. se sabado ou domingo
    * Equivale a fChkFeriado(d,.T.,.T.,.F.) do legado (desconta apenas fins de semana)
    *---------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarDiaUtil(par_dData)
        LOCAL loc_nDow

        loc_nDow = DOW(par_dData)
        IF loc_nDow = 1 OR loc_nDow = 7
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *---------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria (N/A - form de calculo sem tabela)
    *---------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Carrega parametros do calculo a partir de um cursor
    * Util para chamadas em batch onde parametros vem de outro cursor/tabela
    * Mapeia colunas conhecidas (se existirem) para as propriedades do BO
    * par_cAliasCursor: alias do cursor contendo os parametros
    * Retorna .T. em caso de sucesso, .F. se cursor invalido
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)

            *-- Mapear cada coluna somente se existir no cursor (permite cursores
            *-- parciais). Uso de TYPE() para checar existencia da coluna.
            IF TYPE(par_cAliasCursor + ".ValorBase") != "U"
                THIS.this_nValorBase = TratarNulo(EVALUATE(par_cAliasCursor + ".ValorBase"), "N")
            ENDIF
            IF TYPE(par_cAliasCursor + ".JurosMes") != "U"
                THIS.this_nJurosMes = TratarNulo(EVALUATE(par_cAliasCursor + ".JurosMes"), "N")
            ENDIF
            IF TYPE(par_cAliasCursor + ".JurosDia") != "U"
                THIS.this_nJurosDia = TratarNulo(EVALUATE(par_cAliasCursor + ".JurosDia"), "N")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DataBase") != "U"
                THIS.this_dDataBase = TratarNulo(EVALUATE(par_cAliasCursor + ".DataBase"), "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DataFinal") != "U"
                THIS.this_dDataFinal = TratarNulo(EVALUATE(par_cAliasCursor + ".DataFinal"), "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".Dias") != "U"
                THIS.this_nDias = TratarNulo(EVALUATE(par_cAliasCursor + ".Dias"), "N")
            ENDIF
            IF TYPE(par_cAliasCursor + ".TipoCalculo") != "U"
                THIS.this_nTipoCalculo = TratarNulo(EVALUATE(par_cAliasCursor + ".TipoCalculo"), "N")
                IF !INLIST(THIS.this_nTipoCalculo, 1, 2)
                    THIS.this_nTipoCalculo = 1
                ENDIF
            ENDIF
            IF TYPE(par_cAliasCursor + ".TipoDias") != "U"
                THIS.this_nTipoDias = TratarNulo(EVALUATE(par_cAliasCursor + ".TipoDias"), "N")
                IF !INLIST(THIS.this_nTipoDias, 1, 2)
                    THIS.this_nTipoDias = 1
                ENDIF
            ENDIF

            *-- Se DataBase e DataFinal preenchidas mas Dias vazio, calcular
            IF THIS.this_nDias = 0 AND !EMPTY(THIS.this_dDataBase) ;
                                  AND !EMPTY(THIS.this_dDataFinal)
                THIS.this_nDias = THIS.this_dDataFinal - THIS.this_dDataBase
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - Executa calculo e retorna resultado
    * Form de calculo puro (sem tabela BD): Inserir corresponde a executar
    * o calculo de juros com os parametros atuais. Nao ha persistencia em
    * tabela propria porque este BO representa uma calculadora, nao entidade
    * de dominio. O resultado fica nas propriedades this_nValorJuros,
    * this_nValorTotal e this_nValorParcela para consulta pelo chamador.
    * Retorna .T. se calculo executado, .F. em caso de entradas invalidas
    *---------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            *-- Valida entradas minimas
            IF THIS.this_nValorBase <= 0
                MsgAviso("Valor Base deve ser informado.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(THIS.this_dDataBase)
                MsgAviso("Data Base deve ser informada.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(THIS.this_dDataFinal)
                MsgAviso("Data Final deve ser informada.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_nJurosMes <= 0 AND THIS.this_nJurosDia <= 0
                MsgAviso("Taxa de juros deve ser informada.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Garante coerencia entre taxas mes/dia
            IF THIS.this_nJurosMes > 0 AND THIS.this_nJurosDia = 0
                THIS.ConverterJurosMesParaDia()
            ENDIF
            IF THIS.this_nJurosDia > 0 AND THIS.this_nJurosMes = 0
                THIS.ConverterJurosDiaParaMes()
            ENDIF

            *-- Recalcula dias conforme tipo (corridos/uteis)
            THIS.CalcularDias()

            *-- Executa o calculo principal
            loc_lSucesso = THIS.CalcularJuros()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Reexecuta calculo com parametros atualizados
    * Form de calculo puro: Atualizar corresponde a recalcular apos alteracao
    * de qualquer parametro (Valor Base, Taxa, Datas, Vencimentos). Delega a
    * Inserir() pois a semantica eh identica para uma calculadora.
    * Retorna .T. se calculo executado, .F. em caso de entradas invalidas
    *---------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.Inserir()
    ENDPROC

ENDDEFINE

