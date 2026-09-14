# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Ops' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrehpr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1631 linhas total):

*-- Linhas 45 a 53:
45:         LOCAL loc_lSucesso, loc_oErro
46:         loc_lSucesso = .F.
47:         TRY
48:             THIS.Caption = "Relat" + CHR(243) + "rio de Hist" + CHR(243) + ;
49:                            "rico de Produtos"
50: 
51:             IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
52:                 IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
53:                     MsgErro("Conex" + CHR(227) + "o com banco de dados inv" + ;

*-- Linhas 69 a 78:
69: 
70:             IF loc_lSucesso
71:                 THIS.ConfigurarCabecalho()
72:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
73:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
74:                 THIS.ConfigurarBotoesRelatorio()
75:                 THIS.ConfigurarFiltrosTipo()
76:                 THIS.ConfigurarFiltrosGrEstoque()
77:                 THIS.ConfigurarFiltrosEstoque()
78:                 THIS.ConfigurarFiltrosCodigo()

*-- Linhas 106 a 180:
106:     PROTECTED PROCEDURE ConfigurarCabecalho()
107:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
108:         WITH THIS.cnt_4c_Cabecalho
109:             .Top         = 0
110:             .Left        = 0
111:             .Width       = THIS.Width
112:             .Height      = 80
113:             .BackStyle   = 1
114:             .BackColor   = RGB(100, 100, 100)
115:             .BorderWidth = 0
116:             .Visible     = .T.
117:         ENDWITH
118: 
119:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
120:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
121:             .Top       = 20
122:             .Left      = 14
123:             .AutoSize  = .T.
124:             .Caption   = "Relat" + CHR(243) + "rio de Hist" + CHR(243) + ;
125:                          "rico de Produtos"
126:             .FontName  = "Tahoma"
127:             .FontSize  = 16
128:             .FontBold  = .T.
129:             .ForeColor = RGB(0, 0, 0)
130:             .BackStyle = 0
131:             .Visible   = .T.
132:         ENDWITH
133: 
134:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
135:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
136:             .Top       = 17
137:             .Left      = 12
138:             .AutoSize  = .T.
139:             .Caption   = "Relat" + CHR(243) + "rio de Hist" + CHR(243) + ;
140:                          "rico de Produtos"
141:             .FontName  = "Tahoma"
142:             .FontSize  = 16
143:             .FontBold  = .T.
144:             .ForeColor = RGB(255, 255, 255)
145:             .BackStyle = 0
146:             .Visible   = .T.
147:         ENDWITH
148:     ENDPROC
149: 
150:     *--------------------------------------------------------------------------
151:     * ConfigurarBotoesRelatorio - Botoes Visualizar/Imprimir/Excel/Encerrar
152:     * Posicao original: btnReport.Left=531, Top=0
153:     *--------------------------------------------------------------------------
154:     PROTECTED PROCEDURE ConfigurarBotoesRelatorio()
155:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
156:         WITH THIS.cmg_4c_Botoes
157:             .Top           = 0
158:             .Left          = 529
159:             .Width         = 273
160:             .Height        = 80
161:             .ButtonCount   = 4
162:             .BackStyle     = 0
163:             .BorderStyle   = 0
164:             .BorderColor   = RGB(136, 189, 188)
165:             .SpecialEffect = 1
166:             .Themes        = .F.
167:             .Visible       = .T.
168:         ENDWITH
169: 
170:         WITH THIS.cmg_4c_Botoes.Buttons(1)
171:             .Top             = 5
172:             .Left            = 5
173:             .Width           = 65
174:             .Height          = 70
175:             .Caption         = "Visualizar"
176:             .FontName        = "Tahoma"
177:             .FontBold        = .T.
178:             .FontItalic      = .T.
179:             .FontSize        = 8
180:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"

*-- Linhas 189 a 201:
189:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
190: 
191:         WITH THIS.cmg_4c_Botoes.Buttons(2)
192:             .Top             = 5
193:             .Left            = 71
194:             .Width           = 65
195:             .Height          = 70
196:             .Caption         = "Imprimir"
197:             .FontName        = "Tahoma"
198:             .FontBold        = .T.
199:             .FontItalic      = .T.
200:             .FontSize        = 8
201:             .Picture         = gc_4c_CaminhoIcones + "cadastro_imprimir_60.jpg"

*-- Linhas 210 a 222:
210:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
211: 
212:         WITH THIS.cmg_4c_Botoes.Buttons(3)
213:             .Top             = 5
214:             .Left            = 137
215:             .Width           = 65
216:             .Height          = 70
217:             .Caption         = "Excel"
218:             .FontName        = "Tahoma"
219:             .FontBold        = .T.
220:             .FontItalic      = .T.
221:             .FontSize        = 8
222:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excel_60.jpg"

*-- Linhas 231 a 243:
231:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
232: 
233:         WITH THIS.cmg_4c_Botoes.Buttons(4)
234:             .Top             = 5
235:             .Left            = 203
236:             .Width           = 65
237:             .Height          = 70
238:             .Caption         = "Encerrar"
239:             .Cancel          = .T.
240:             .FontName        = "Tahoma"
241:             .FontBold        = .T.
242:             .FontItalic      = .T.
243:             .FontSize        = 8

*-- Linhas 265 a 285:
265:             .BorderStyle   = 0
266:             .Value         = 1
267:             .Height        = 22
268:             .Left          = 264
269:             .Top           = 85
270:             .Width         = 362
271:             .SpecialEffect = 0
272:             .AutoSize      = .F.
273:             .Themes        = .F.
274:             .Visible       = .T.
275:         ENDWITH
276: 
277:         WITH THIS.opt_4c_NrTipo.Buttons(1)
278:             .Caption   = "\<Refer" + CHR(234) + "ncia"
279:             .Left      = 5
280:             .Top       = 4
281:             .Width     = 70
282:             .Height    = 15
283:             .AutoSize  = .T.
284:             .FontName  = "Tahoma"
285:             .FontSize  = 8

*-- Linhas 291 a 314:
291:         ENDWITH
292: 
293:         WITH THIS.opt_4c_NrTipo.Buttons(2)
294:             .Caption   = "\<C" + CHR(243) + "digo de Barras"
295:             .Left      = 90
296:             .Top       = 4
297:             .AutoSize  = .T.
298:             .FontName  = "Tahoma"
299:             .FontSize  = 8
300:             .BackStyle = 0
301:             .ForeColor = RGB(90, 90, 90)
302:             .Themes    = .F.
303:             .Visible   = .T.
304:         ENDWITH
305: 
306:         WITH THIS.opt_4c_NrTipo.Buttons(3)
307:             .Caption   = "\<Geral Por Refer" + CHR(234) + "ncia"
308:             .Left      = 216
309:             .Top       = 4
310:             .Width     = 136
311:             .Height    = 17
312:             .AutoSize  = .T.
313:             .FontName  = "Tahoma"
314:             .FontSize  = 8

*-- Linhas 324 a 349:
324:     * Original: Say2 L=169,T=115; CdGr L=269,T=110,W=80; DsGr L=351,T=110,W=150
325:     *--------------------------------------------------------------------------
326:     PROTECTED PROCEDURE ConfigurarFiltrosGrEstoque()
327:         THIS.AddObject("lbl_4c_GrEstoque", "Label")
328:         WITH THIS.lbl_4c_GrEstoque
329:             .Caption   = "Grupo de Estoque :"
330:             .Left      = 169
331:             .Top       = 118
332:             .AutoSize  = .T.
333:             .FontName  = "Tahoma"
334:             .FontSize  = 8
335:             .ForeColor = RGB(90, 90, 90)
336:             .BackStyle = 0
337:             .Visible   = .T.
338:         ENDWITH
339: 
340:         THIS.AddObject("txt_4c_CdGrEstoque", "TextBox")
341:         WITH THIS.txt_4c_CdGrEstoque
342:             .Value         = SPACE(10)
343:             .Left          = 269
344:             .Top           = 110
345:             .Width         = 80
346:             .Height        = 25
347:             .MaxLength     = 10
348:             .Format        = "K!"
349:             .FontName      = "Tahoma"

*-- Linhas 356 a 365:
356:         THIS.AddObject("txt_4c_DsGrEstoque", "TextBox")
357:         WITH THIS.txt_4c_DsGrEstoque
358:             .Value     = SPACE(20)
359:             .Left      = 351
360:             .Top       = 110
361:             .Width     = 150
362:             .Height    = 25
363:             .MaxLength = 20
364:             .Format    = "K!"
365:             .FontName  = "Tahoma"

*-- Linhas 374 a 399:
374:     * Original: lbl L=216,T=142; cd L=269,T=137,W=80; ds L=351,T=137,W=290
375:     *--------------------------------------------------------------------------
376:     PROTECTED PROCEDURE ConfigurarFiltrosEstoque()
377:         THIS.AddObject("lbl_4c_Estoque", "Label")
378:         WITH THIS.lbl_4c_Estoque
379:             .Caption   = "Estoque :"
380:             .Left      = 216
381:             .Top       = 145
382:             .AutoSize  = .T.
383:             .FontName  = "Tahoma"
384:             .FontSize  = 8
385:             .ForeColor = RGB(90, 90, 90)
386:             .BackStyle = 0
387:             .Visible   = .T.
388:         ENDWITH
389: 
390:         THIS.AddObject("txt_4c_CdEstoque", "TextBox")
391:         WITH THIS.txt_4c_CdEstoque
392:             .Value         = SPACE(10)
393:             .Left          = 269
394:             .Top           = 137
395:             .Width         = 80
396:             .Height        = 25
397:             .MaxLength     = 10
398:             .Format        = "K!"
399:             .FontName      = "Tahoma"

*-- Linhas 406 a 415:
406:         THIS.AddObject("txt_4c_DsEstoque", "TextBox")
407:         WITH THIS.txt_4c_DsEstoque
408:             .Value     = SPACE(40)
409:             .Left      = 351
410:             .Top       = 137
411:             .Width     = 290
412:             .Height    = 25
413:             .MaxLength = 40
414:             .Format    = "K!"
415:             .FontName  = "Tahoma"

*-- Linhas 424 a 449:
424:     * Original: lbl L=222,T=169; cd L=269,T=164,W=108; ds L=379,T=164,W=290
425:     *--------------------------------------------------------------------------
426:     PROTECTED PROCEDURE ConfigurarFiltrosCodigo()
427:         THIS.AddObject("lbl_4c_Codigo", "Label")
428:         WITH THIS.lbl_4c_Codigo
429:             .Caption   = "C" + CHR(243) + "digo :"
430:             .Left      = 222
431:             .Top       = 172
432:             .AutoSize  = .T.
433:             .FontName  = "Tahoma"
434:             .FontSize  = 8
435:             .ForeColor = RGB(90, 90, 90)
436:             .BackStyle = 0
437:             .Visible   = .T.
438:         ENDWITH
439: 
440:         THIS.AddObject("txt_4c_CdCodigo", "TextBox")
441:         WITH THIS.txt_4c_CdCodigo
442:             .Value         = SPACE(14)
443:             .Left          = 269
444:             .Top           = 164
445:             .Width         = 108
446:             .Height        = 25
447:             .MaxLength     = 14
448:             .Format        = "K!"
449:             .FontName      = "Tahoma"

*-- Linhas 456 a 465:
456:         THIS.AddObject("txt_4c_DsCodigo", "TextBox")
457:         WITH THIS.txt_4c_DsCodigo
458:             .Value     = SPACE(40)
459:             .Left      = 379
460:             .Top       = 164
461:             .Width     = 290
462:             .Height    = 25
463:             .MaxLength = 40
464:             .Format    = "K!"
465:             .FontName  = "Tahoma"

*-- Linhas 474 a 527:
474:     * Original: lbl L=219,T=196; ini L=269,T=191,W=80; "a" L=354; fin L=366,W=80
475:     *--------------------------------------------------------------------------
476:     PROTECTED PROCEDURE ConfigurarFiltrosPeriodo()
477:         THIS.AddObject("lbl_4c_Periodo", "Label")
478:         WITH THIS.lbl_4c_Periodo
479:             .Caption   = "Per" + CHR(237) + "odo :"
480:             .Left      = 219
481:             .Top       = 199
482:             .AutoSize  = .T.
483:             .FontName  = "Tahoma"
484:             .FontSize  = 8
485:             .ForeColor = RGB(90, 90, 90)
486:             .BackStyle = 0
487:             .Visible   = .T.
488:         ENDWITH
489: 
490:         THIS.AddObject("txt_4c_DtInicial", "TextBox")
491:         WITH THIS.txt_4c_DtInicial
492:             .Value     = DATE()
493:             .Left      = 269
494:             .Top       = 191
495:             .Width     = 80
496:             .Height    = 25
497:             .MaxLength = 10
498:             .Format    = "K"
499:             .FontName  = "Tahoma"
500:             .FontSize  = 8
501:             .ForeColor = RGB(0, 0, 0)
502:             .Visible   = .T.
503:         ENDWITH
504: 
505:         THIS.AddObject("lbl_4c_PeriodoA", "Label")
506:         WITH THIS.lbl_4c_PeriodoA
507:             .Caption   = CHR(224)
508:             .Left      = 354
509:             .Top       = 199
510:             .AutoSize  = .T.
511:             .FontName  = "Tahoma"
512:             .FontSize  = 8
513:             .ForeColor = RGB(90, 90, 90)
514:             .BackStyle = 0
515:             .Visible   = .T.
516:         ENDWITH
517: 
518:         THIS.AddObject("txt_4c_DtFinal", "TextBox")
519:         WITH THIS.txt_4c_DtFinal
520:             .Value     = DATE()
521:             .Left      = 366
522:             .Top       = 191
523:             .Width     = 80
524:             .Height    = 25
525:             .MaxLength = 10
526:             .Format    = "K"
527:             .FontName  = "Tahoma"

*-- Linhas 536 a 561:
536:     * Original: Say1 L=173,T=223; barra L=269,T=218,W=108,InputMask=9999999999999
537:     *--------------------------------------------------------------------------
538:     PROTECTED PROCEDURE ConfigurarFiltrosCdBarra()
539:         THIS.AddObject("lbl_4c_CdBarra", "Label")
540:         WITH THIS.lbl_4c_CdBarra
541:             .Caption   = "C" + CHR(243) + "digo de Barras :"
542:             .Left      = 173
543:             .Top       = 226
544:             .AutoSize  = .T.
545:             .FontName  = "Tahoma"
546:             .FontSize  = 8
547:             .ForeColor = RGB(90, 90, 90)
548:             .BackStyle = 0
549:             .Visible   = .T.
550:         ENDWITH
551: 
552:         THIS.AddObject("txt_4c_CdBarra", "TextBox")
553:         WITH THIS.txt_4c_CdBarra
554:             .Value         = 0
555:             .Left          = 269
556:             .Top           = 218
557:             .Width         = 108
558:             .Height        = 25
559:             .MaxLength     = 14
560:             .InputMask     = "9999999999999"
561:             .Format        = "K"

*-- Linhas 573 a 598:
573:     * Original: Say5 L=214,T=248; Empresa L=269,T=245,W=31; DesEmpresa L=302,W=290
574:     *--------------------------------------------------------------------------
575:     PROTECTED PROCEDURE ConfigurarFiltrosEmpresa()
576:         THIS.AddObject("lbl_4c_Empresa", "Label")
577:         WITH THIS.lbl_4c_Empresa
578:             .Caption   = "Empresa :"
579:             .Left      = 214
580:             .Top       = 251
581:             .AutoSize  = .T.
582:             .FontName  = "Tahoma"
583:             .FontSize  = 8
584:             .ForeColor = RGB(90, 90, 90)
585:             .BackStyle = 0
586:             .Visible   = .T.
587:         ENDWITH
588: 
589:         THIS.AddObject("txt_4c_CdEmpresa", "TextBox")
590:         WITH THIS.txt_4c_CdEmpresa
591:             .Value     = ""
592:             .Left      = 269
593:             .Top       = 245
594:             .Width     = 31
595:             .Height    = 25
596:             .MaxLength = 3
597:             .Format    = "K!"
598:             .FontName  = "Tahoma"

*-- Linhas 604 a 613:
604:         THIS.AddObject("txt_4c_DsEmpresa", "TextBox")
605:         WITH THIS.txt_4c_DsEmpresa
606:             .Value     = ""
607:             .Left      = 302
608:             .Top       = 245
609:             .Width     = 290
610:             .Height    = 25
611:             .FontName  = "Tahoma"
612:             .FontSize  = 8
613:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 620 a 632:
620:     * Original: Say3 L=156,T=273; ImpMedio L=327,T=267; Say4 L=157,T=293; Obs L=327,T=287
621:     *--------------------------------------------------------------------------
622:     PROTECTED PROCEDURE ConfigurarFiltrosOpcoes()
623:         THIS.AddObject("lbl_4c_ImpMedio", "Label")
624:         WITH THIS.lbl_4c_ImpMedio
625:             .Caption   = "Imprime Custo M" + CHR(233) + "dio do \<Produto  :"
626:             .Left      = 156
627:             .Top       = 276
628:             .AutoSize  = .T.
629:             .FontName  = "Tahoma"
630:             .FontSize  = 8
631:             .ForeColor = RGB(90, 90, 90)
632:             .BackStyle = 0

*-- Linhas 640 a 660:
640:             .BorderStyle   = 0
641:             .Value         = 1
642:             .Height        = 23
643:             .Left          = 327
644:             .Top           = 267
645:             .Width         = 97
646:             .SpecialEffect = 0
647:             .AutoSize      = .F.
648:             .Themes        = .F.
649:             .Visible       = .T.
650:         ENDWITH
651: 
652:         WITH THIS.opt_4c_ImpMedio.Buttons(1)
653:             .Caption   = "Sim"
654:             .Left      = 5
655:             .Top       = 4
656:             .Width     = 34
657:             .Height    = 15
658:             .AutoSize  = .T.
659:             .FontName  = "Tahoma"
660:             .FontSize  = 8

*-- Linhas 666 a 691:
666:         ENDWITH
667: 
668:         WITH THIS.opt_4c_ImpMedio.Buttons(2)
669:             .Caption   = "N" + CHR(227) + "o"
670:             .Left      = 51
671:             .Top       = 4
672:             .AutoSize  = .T.
673:             .FontName  = "Tahoma"
674:             .FontSize  = 8
675:             .BackStyle = 0
676:             .ForeColor = RGB(90, 90, 90)
677:             .Themes    = .F.
678:             .Visible   = .T.
679:         ENDWITH
680: 
681:         THIS.AddObject("lbl_4c_OptObs", "Label")
682:         WITH THIS.lbl_4c_OptObs
683:             .Caption   = "Imprime Observa" + CHR(231) + CHR(227) + "o do \<Hist" + ;
684:                          CHR(243) + "rico :"
685:             .Left      = 157
686:             .Top       = 296
687:             .AutoSize  = .T.
688:             .FontName  = "Tahoma"
689:             .FontSize  = 8
690:             .ForeColor = RGB(90, 90, 90)
691:             .BackStyle = 0

*-- Linhas 699 a 748:
699:             .BorderStyle   = 0
700:             .Value         = 2
701:             .Height        = 25
702:             .Left          = 327
703:             .Top           = 287
704:             .Width         = 185
705:             .SpecialEffect = 0
706:             .AutoSize      = .F.
707:             .Themes        = .F.
708:             .Visible       = .T.
709:         ENDWITH
710: 
711:         WITH THIS.opt_4c_OptObs.Buttons(1)
712:             .Caption   = "Sim"
713:             .Left      = 5
714:             .Top       = 5
715:             .Width     = 34
716:             .Height    = 15
717:             .AutoSize  = .T.
718:             .FontName  = "Tahoma"
719:             .FontSize  = 8
720:             .BackStyle = 0
721:             .ForeColor = RGB(90, 90, 90)
722:             .Themes    = .F.
723:             .Visible   = .T.
724:         ENDWITH
725: 
726:         WITH THIS.opt_4c_OptObs.Buttons(2)
727:             .Caption   = "N" + CHR(227) + "o"
728:             .Left      = 51
729:             .Top       = 5
730:             .AutoSize  = .T.
731:             .FontName  = "Tahoma"
732:             .FontSize  = 8
733:             .BackStyle = 0
734:             .ForeColor = RGB(90, 90, 90)
735:             .Themes    = .F.
736:             .Value     = 1
737:             .Visible   = .T.
738:         ENDWITH
739: 
740:         WITH THIS.opt_4c_OptObs.Buttons(3)
741:             .Caption   = "C/Documento"
742:             .Left      = 92
743:             .Top       = 5
744:             .Width     = 83
745:             .Height    = 15
746:             .AutoSize  = .T.
747:             .FontName  = "Tahoma"
748:             .FontSize  = 8


### BO (C:\4c\projeto\app\classes\sigrehprBO.prg):
*==============================================================================
* SIGREHPRBO.PRG
* Business Object para Relatorio de Historico de Produtos (SIGREHPR)
*
* Herda de: RelatorioBase
* Tabelas: SigMvHst, SigMvEst, SigCdPro, SigCdEmp, SigCdGrp, SigCdPam
*           SigMvCab, SigCdNec, SigOpEtq, SigCdUni, SigPdMvf, SigMvPec
*==============================================================================

DEFINE CLASS sigrehprBO AS RelatorioBase

    *-- Identificacao
    this_cTabela          = "SigMvHst"
    this_cCampoChave      = ""

    *-- Modo de filtragem
    *-- Valores possiveis: 'REFERENCIA', 'CODIGO DE BARRA', 'GERAL'
    this_cTipo            = "REFERENCIA"
    this_nOptTipo         = 1     && 1=Referencia, 2=Codigo de Barras, 3=Geral por Referencia

    *-- Filtro: Grupo de Estoque (SigCdGrp)
    this_cCdGrEstoque     = ""    && cgrus / MaxLength 10
    this_cDsGrEstoque     = ""    && dgrus / MaxLength 20

    *-- Filtro: Estoque (SigCdEst)
    this_cCdEstoque       = ""    && MaxLength 10
    this_cDsEstoque       = ""    && MaxLength 40

    *-- Filtro: Produto (SigCdPro)
    this_cCdCodigo        = ""    && cpros / MaxLength 14
    this_cDsCodigo        = ""    && dpros / MaxLength 40

    *-- Filtro: Periodo
    this_dDtInicial       = {}
    this_dDtFinal         = {}

    *-- Filtro: Codigo de Barras (SigOpEtq.cbars / SigCdPro.cbars)
    this_nCdBarra         = 0

    *-- Filtro: Empresa (SigCdEmp)
    this_cEmpresa         = ""    && cemps / MaxLength 3
    this_cDesEmpresa      = ""    && razas

    *-- Opcoes de impressao
    this_nOptObs          = 2     && 1=Sim, 2=Nao, 3=C/Documento
    this_nImpMedio        = 1     && 1=Sim, 2=Nao

    *-- Dados calculados para cabecalho do relatorio
    this_cNomeEmpresa     = ""    && SigCdEmp.razas (empresa selecionada)
    this_cTitulo1         = ""    && Titulo principal fixo
    this_cTitulo2         = ""    && Subtitulo (grupo/estoque/empresa filtrados)
    this_cPeriodo         = ""    && Periodo formatado "dd/mm/aa a dd/mm/aa"

    *-- Cursors de saida
    this_cCursorDados     = "CsRelatorio"    && Cursor com registros do historico
    this_cCursorCabecalho = "CsCabecalho"    && Cursor com dados de cabecalho para FRX

    *--------------------------------------------------------------------------
    * Init - Inicializa propriedades com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_dDtInicial  = DATE()
            THIS.this_dDtFinal    = DATE()
            THIS.this_cTipo       = "REFERENCIA"
            THIS.this_nOptTipo    = 1
            THIS.this_nOptObs     = 2
            THIS.this_nImpMedio   = 1
            THIS.this_cEmpresa    = go_4c_Sistema.cCodEmpresa
            THIS.this_cTitulo1    = "Hist" + CHR(243) + "rico de Produtos"
            loc_lSucesso          = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel para relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Coordena preparacao dos dados conforme modo de filtragem
    * Popula CsCabecalho e CsRelatorio (modo 3) ou CrSigMvHst (modo 1/2)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        PRIVATE ldDtInicial, ldDtFinal
        LOCAL loc_lSucesso, loc_nResult
        LOCAL loc_cEmp, loc_cGrEst, loc_cCdEstoque, loc_cDsEstoque
        LOCAL loc_cCdCodigo, loc_cDsCodigo, loc_nCdBarra, loc_nImpMedio
        LOCAL loc_lObs
        LOCAL loc_cTitulo2Grp, loc_cTitulo2Est, loc_cTitulo2Emp

        loc_lSucesso = .F.

        TRY
            THIS.this_cMensagemErro = ""
            THIS.LimparCursors()

            *-- Capturar filtros das propriedades
            loc_cEmp       = PADR(ALLTRIM(THIS.this_cEmpresa), 3)
            loc_cGrEst     = PADR(ALLTRIM(THIS.this_cCdGrEstoque), 10)
            loc_cCdEstoque = PADR(ALLTRIM(THIS.this_cCdEstoque), 10)
            loc_cDsEstoque = THIS.this_cDsEstoque
            loc_cCdCodigo  = PADR(THIS.this_cCdCodigo, 14)
            loc_cDsCodigo  = THIS.this_cDsCodigo
            loc_nCdBarra   = THIS.this_nCdBarra
            loc_nImpMedio  = THIS.this_nImpMedio
            loc_lObs       = INLIST(THIS.this_nOptObs, 1, 3)

            *-- Converter datas para DATETIME com hora (necessario para BETWEEN em SigMvHst.datas)
            ldDtInicial = EVALUATE([{^] + ;
                TRANSFORM((DTOS(MAX(THIS.this_dDtInicial, CTOD('01/01/1900'))) + '000000'), ;
                '@R 9999-99-99 99:99:99') + [}])
            ldDtFinal = EVALUATE([{^] + ;
                TRANSFORM((DTOS(MAX(THIS.this_dDtFinal, CTOD('01/01/1900'))) + '235959'), ;
                '@R 9999-99-99 99:99:99') + [}])

            *-- Buscar nome da empresa selecionada
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cEmp), ;
                "cursor_4c_CrEmpSrh")
            IF loc_nResult > 0
                SELECT cursor_4c_CrEmpSrh
                GO TOP
                IF !EOF()
                    THIS.this_cNomeEmpresa = ALLTRIM(cursor_4c_CrEmpSrh.razas)
                ENDIF
                USE IN cursor_4c_CrEmpSrh
            ENDIF

            *-- Montar periodo formatado
            THIS.this_cPeriodo = "Per" + CHR(237) + "odo: " + ;
                DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal)

            *-- Montar titulo2 (grupo / estoque / empresa filtrados)
            loc_cTitulo2Grp = IIF(EMPTY(loc_cGrEst), "", ;
                ALLTRIM(THIS.this_cCdGrEstoque) + " - " + ALLTRIM(THIS.this_cDsGrEstoque))
            loc_cTitulo2Est = IIF(EMPTY(loc_cCdEstoque), "", ;
                IIF(EMPTY(loc_cGrEst), "", CHR(13)) + ;
                ALLTRIM(THIS.this_cCdEstoque) + " - " + ALLTRIM(THIS.this_cDsEstoque))
            loc_cTitulo2Emp = IIF(EMPTY(loc_cEmp), "", ;
                " / " + ALLTRIM(THIS.this_cEmpresa) + " - " + ALLTRIM(THIS.this_cDesEmpresa))
            THIS.this_cTitulo2 = loc_cTitulo2Grp + loc_cTitulo2Est + loc_cTitulo2Emp

            *-- Buscar tabela de unidades de medida (usada para verificar peso)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cunis, cestos FROM SigCdUni", ;
                "CrTmpUni")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar unidades de medida"
            ELSE
                SELECT CrTmpUni
                INDEX ON cunis TAG cunis

                DO CASE
                CASE THIS.this_nOptTipo = 3
                    loc_lSucesso = THIS.PrepararDadosGeral(loc_cEmp, loc_cGrEst, ;
                        loc_cCdEstoque, loc_lObs, loc_nImpMedio)
                OTHERWISE
                    loc_lSucesso = THIS.PrepararDadosRef(loc_cEmp, loc_cGrEst, ;
                        loc_cCdEstoque, loc_cCdCodigo, loc_cDsCodigo, ;
                        loc_nCdBarra, loc_lObs, loc_nImpMedio)
                ENDCASE
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosGeral - Modo 3: Geral Por Referencia
    * Cruza SigMvEst com SigMvHst para todos os produtos do estoque filtrado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDadosGeral(par_cEmp, par_cGrEst, par_cCdEstoque, par_lObs, par_nImpMedio)
        LOCAL loc_nResult, loc_lSucesso, loc_lErro
        LOCAL loc_cCodPro, loc_cEmpDopNums, loc_cEmpDnps
        LOCAL loc_cGrupoos, loc_cContaos, loc_cGrupods, loc_cContads
        LOCAL loc_cCunis, loc_cDpros

        loc_lSucesso = .F.
        loc_lErro    = .F.

        *-- Cursor de cabecalho (modo 3: sem Produto/Unidade)
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        CREATE CURSOR CsCabecalho (;
            NomeEmpresa C(80), Titulo1 C(80), Titulo2 C(80), Periodo C(80), ;
            Opcao N(1), Obs L, ImpMedio L, ImpPeso L, TRACO L)
        INSERT INTO CsCabecalho (NomeEmpresa, Titulo1, Titulo2, Periodo, Opcao, Obs, ImpMedio, ImpPeso) ;
            VALUES (THIS.this_cNomeEmpresa, THIS.this_cTitulo1, THIS.this_cTitulo2, ;
                    THIS.this_cPeriodo, 3, par_lObs, (par_nImpMedio = 1), .F.)

        *-- Selecionar posicoes de estoque (SigMvEst JOIN SigCdPro)
        IF USED("TmpEst")
            USE IN TmpEst
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT a.emps, a.grupos, a.estos, a.cpros, a.codcors, a.codtams, " + ;
            "a.spesos, b.cunis, b.cunips " + ;
            "FROM SigMvEst a, SigCdPro b " + ;
            "WHERE a.emps = " + EscaparSQL(par_cEmp) + ;
            " AND a.grupos = " + EscaparSQL(par_cGrEst) + ;
            " AND a.estos = " + EscaparSQL(par_cCdEstoque) + ;
            " AND a.cpros = b.cpros", ;
            "TmpEst")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Erro ao selecionar dados do estoque"
            RETURN .F.
        ENDIF
        SELECT TmpEst
        INDEX ON emps   TAG emps
        INDEX ON grupos TAG grupos
        INDEX ON estos  TAG estos
        INDEX ON cpros  TAG cpros

        *-- Selecionar historico de movimentos (SigMvHst) com parametros de data
        IF USED("TmpHis")
            USE IN TmpHis
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT emps, grupos, estos, dopes, numes, empgruests, empdopnums, " + ;
            "cpros, datas, qtds, sqtds, opers, codbarras, unitmeds, moedmeds, " + ;
            "obs, CidChaves, pesos, spesos " + ;
            "FROM SigMvHst " + ;
            "WHERE empgruests = " + EscaparSQL(par_cEmp + par_cGrEst + par_cCdEstoque) + ;
            " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal " + ;
            "ORDER BY emps, grupos, estos, cpros, CidChaves", ;
            "TmpHis")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Erro ao selecionar hist" + CHR(243) + "rico (geral)"
            RETURN .F.
        ENDIF
        SELECT TmpHis
        INDEX ON empgruests TAG empgruests
        INDEX ON cpros      TAG cpros

        *-- JOIN local VFP: TmpEst x TmpHis -> CsRelatorio (READWRITE para REPLACE em seguida)
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        SELECT a.cpros, b.datas, a.codcors, a.codtams, a.estos, a.grupos, ;
               b.emps, b.dopes, b.numes, b.empdopnums, b.qtds, b.opers, ;
               b.sqtds, b.codbarras, b.unitmeds, b.moedmeds, b.obs, ;
               SPACE(40) AS dpros, SPACE(3)  AS cunis, ;
               SPACE(10) AS grupoos, SPACE(10) AS contaos, ;
               SPACE(10) AS grupods, SPACE(10) AS contads, ;
               b.CidChaves, b.pesos, b.spesos, a.cunips ;
        FROM TmpEst a, TmpHis b ;
        WHERE a.emps + a.grupos + a.estos = b.empgruests AND a.cpros = b.cpros ;
        ORDER BY b.emps, a.grupos, a.estos, a.cpros, a.codcors, a.codtams, b.CidChaves ;
        INTO CURSOR CsRelatorio READWRITE

        *-- Enriquecer cada registro com descricoes e grupos contabeis
        SELECT CsRelatorio
        GO TOP
        SCAN
            IF loc_lErro
                EXIT
            ENDIF

            loc_cCodPro     = CsRelatorio.cpros
            loc_cEmpDopNums = CsRelatorio.empdopnums
            loc_cEmpDnps    = LEFT(CsRelatorio.empdopnums, 23) + ;
                              STR(VAL(RIGHT(CsRelatorio.empdopnums, 6)), 10)
            loc_cGrupoos    = ""
            loc_cContaos    = ""
            loc_cGrupods    = ""
            loc_cContads    = ""
            loc_cCunis      = ""
            loc_cDpros      = ""

            *-- Buscar grupos contabeis em SigMvCab
            IF USED("TprMvCab")
                USE IN TprMvCab
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT grupoos, contaos, grupods, contads FROM SigMvCab " + ;
                "WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums), ;
                "TprMvCab")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar movimento contabil"
                loc_lErro = .T.
            ELSE
                SELECT TprMvCab
                GO TOP
                IF !EOF()
                    loc_cGrupoos = ALLTRIM(TprMvCab.grupoos)
                    loc_cContaos = ALLTRIM(TprMvCab.contaos)
                    loc_cGrupods = ALLTRIM(TprMvCab.grupods)
                    loc_cContads = ALLTRIM(TprMvCab.contads)
                    USE IN TprMvCab
                ELSE
                    USE IN TprMvCab
                    *-- Fallback: buscar em SigCdNec usando chave composta longa
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT grupoos, contaos, grupods, contads FROM SigCdNec " + ;
                        "WHERE empdnps = " + EscaparSQL(loc_cEmpDnps), ;
                        "TprMvCab")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Erro ao buscar NEC"
                        loc_lErro = .T.
                    ELSE
                        SELECT TprMvCab
                        GO TOP
                        IF !EOF()
                            loc_cGrupoos = ALLTRIM(TprMvCab.grupoos)
                            loc_cContaos = ALLTRIM(TprMvCab.contaos)
                            loc_cGrupods = ALLTRIM(TprMvCab.grupods)
                            loc_cContads = ALLTRIM(TprMvCab.contads)
                        ENDIF
                        USE IN TprMvCab
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lErro
                *-- Buscar descricao e unidade do produto
                IF USED("TmpPro")
                    USE IN TmpPro
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT cpros, dpros, cunis FROM SigCdPro WHERE cpros = " + ;
                    EscaparSQL(loc_cCodPro), ;
                    "TmpPro")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar produto"
                    loc_lErro = .T.
                ELSE
                    SELECT TmpPro
                    GO TOP
                    IF !EOF()
                        loc_cCunis = ALLTRIM(TmpPro.cunis)
                        loc_cDpros = ALLTRIM(TmpPro.dpros)
                    ENDIF
                    USE IN TmpPro
                ENDIF
            ENDIF

            IF !loc_lErro
                SELECT CsRelatorio
                REPLACE CsRelatorio.grupoos WITH loc_cGrupoos
                REPLACE CsRelatorio.contaos WITH loc_cContaos
                REPLACE CsRelatorio.grupods WITH loc_cGrupods
                REPLACE CsRelatorio.contads WITH loc_cContads
                REPLACE CsRelatorio.cunis   WITH loc_cCunis
                REPLACE CsRelatorio.dpros   WITH loc_cDpros

                *-- Verificar se unidade e de peso (cestos='3') para flag ImpPeso
                IF SEEK(loc_cCunis, "CrTmpUni")
                    IF CrTmpUni.cestos = '3'
                        SELECT CsCabecalho
                        GO TOP
                        REPLACE CsCabecalho.ImpPeso WITH .T.
                        SELECT CsRelatorio
                    ELSE
                        REPLACE CsRelatorio.pesos  WITH 0
                        REPLACE CsRelatorio.spesos WITH 0
                    ENDIF
                ENDIF
            ENDIF

        ENDSCAN

        IF loc_lErro
            RETURN .F.
        ENDIF

        SELECT CsRelatorio
        GO TOP

        loc_lSucesso = .T.
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosRef - Modo 1 (Referencia) e Modo 2 (Codigo de Barra)
    * Processa SigMvHst para um produto especifico ou por codigo de barras
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDadosRef(par_cEmp, par_cGrEst, par_cCdEstoque, ;
                                          par_cCdCodigo, par_cDsCodigo, ;
                                          par_nCdBarra, par_lObs, par_nImpMedio)
        LOCAL loc_nResult, loc_lSucesso, loc_lErro
        LOCAL loc_cUnidade, loc_cGrupo, loc_cProduto, loc_cNmCodigo, loc_cCdBarra
        LOCAL loc_cWhereHis, loc_cOrderBy, loc_cSQL
        LOCAL loc_nTipoEstos, loc_lImpPeso, loc_lImpMedio
        LOCAL loc_cCorIni, loc_cCorFim, loc_cTamIni, loc_cTamFim
        LOCAL loc_cEmpDopNums, loc_cEmpDnps, loc_cNota, loc_lPrimeira
        LOCAL loc_lOpExiste, loc_cNop
        LOCAL loc_nNdope, loc_nNume, loc_cDopePeca, loc_cEDN, loc_cNotaPeca

        loc_lSucesso  = .F.
        loc_lErro     = .F.
        loc_cNmCodigo = ALLTRIM(par_cCdCodigo) + " - " + ALLTRIM(par_cDsCodigo)
        loc_cCdBarra  = ALLTRIM(STR(par_nCdBarra, 8))

        *-- Buscar dados do produto em SigCdPro
        IF USED("CrSigCdPro")
            USE IN CrSigCdPro
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT cunis, cgrus, cpros, dpros, cunips FROM SigCdPro " + ;
            "WHERE cpros = " + EscaparSQL(par_cCdCodigo), ;
            "CrSigCdPro")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Erro ao buscar produto"
            RETURN .F.
        ENDIF
        SELECT CrSigCdPro
        GO TOP
        IF EOF()
            THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cCdCodigo)
            RETURN .F.
        ENDIF
        loc_cUnidade = "Unid: " + ALLTRIM(CrSigCdPro.cunis)
        loc_cGrupo   = ALLTRIM(CrSigCdPro.cgrus)

        *-- Buscar tipo de estoque do grupo (SigCdGrp.tipoestos)
        IF USED("CrSigCdGrp")
            USE IN CrSigCdGrp
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT tipoestos FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cGrupo), ;
            "CrSigCdGrp")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Erro ao buscar grupo de estoque"
            RETURN .F.
        ENDIF
        SELECT CrSigCdGrp
        GO TOP
        loc_nTipoEstos = 0
        IF !EOF()
            loc_nTipoEstos = CrSigCdGrp.tipoestos
        ENDIF

        *-- Montar WHERE e ORDER BY conforme modo e tipo de estoque
        loc_cCorIni = SPACE(4)
        loc_cCorFim = REPLICATE(CHR(254), 4)
        loc_cTamIni = SPACE(2)
        loc_cTamFim = REPLICATE(CHR(254), 2)

        DO CASE
        CASE THIS.this_nOptTipo = 1  && Referencia por produto
            loc_cProduto  = "Produto: " + loc_cNmCodigo
            loc_cWhereHis = "empgruests = " + ;
                EscaparSQL(par_cEmp + par_cGrEst + par_cCdEstoque) + ;
                " AND cpros = " + EscaparSQL(par_cCdCodigo)

            DO CASE
            CASE loc_nTipoEstos = 2  && Codigo/Cor
                loc_cWhereHis = loc_cWhereHis + ;
                    " AND codcors BETWEEN " + EscaparSQL(loc_cCorIni) + ;
                    " AND " + EscaparSQL(loc_cCorFim) + ;
                    " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal"
                loc_cOrderBy = "emps, grupos, estos, codcors, CidChaves, opers"
            CASE loc_nTipoEstos = 3  && Codigo/Tamanho
                loc_cWhereHis = loc_cWhereHis + ;
                    " AND codtams BETWEEN " + EscaparSQL(loc_cTamIni) + ;
                    " AND " + EscaparSQL(loc_cTamFim) + ;
                    " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal"
                loc_cOrderBy = "emps, grupos, estos, codtams, CidChaves, opers"
            CASE loc_nTipoEstos = 4  && Codigo/Cor/Tamanho
                loc_cWhereHis = loc_cWhereHis + ;
                    " AND codcors BETWEEN " + EscaparSQL(loc_cCorIni) + ;
                    " AND " + EscaparSQL(loc_cCorFim) + ;
                    " AND codtams BETWEEN " + EscaparSQL(loc_cTamIni) + ;
                    " AND " + EscaparSQL(loc_cTamFim) + ;
                    " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal"
                loc_cOrderBy = "emps, grupos, estos, codcors, codtams, CidChaves, opers"
            OTHERWISE  && Apenas codigo simples
                loc_cWhereHis = loc_cWhereHis + ;
                    " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal"
                loc_cOrderBy = "emps, grupos, estos, CidChaves, opers"
            ENDCASE

        CASE THIS.this_nOptTipo = 2  && Codigo de Barra
            loc_cProduto  = "Produto: (" + loc_cCdBarra + ") / " + loc_cNmCodigo
            loc_cWhereHis = "emps = " + EscaparSQL(par_cEmp) + ;
                            " AND codbarras = " + TRANSFORM(par_nCdBarra) + ;
                            " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal"
            loc_cOrderBy  = "emps, codbarras, CidChaves"
        ENDCASE

        *-- Verificar se unidade e de peso para ImpPeso do cabecalho
        loc_lImpPeso = .F.
        IF SEEK(ALLTRIM(CrSigCdPro.cunis), "CrTmpUni")
            loc_lImpPeso = (CrTmpUni.cestos = '3')
        ENDIF

        *-- Cursor de cabecalho (modo 1/2: com Produto e Unidade)
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        CREATE CURSOR CsCabecalho (;
            NomeEmpresa C(80), Titulo1 C(80), Titulo2 C(80), Periodo C(80), ;
            Produto C(80), Unidade C(20), Opcao N(1), Obs L, ImpPeso L, ;
            ImpMedio L, TRACO L)
        loc_lImpMedio = (par_nImpMedio = 1)
        INSERT INTO CsCabecalho ;
            (NomeEmpresa, Titulo1, Titulo2, Periodo, Produto, Unidade, ;
             Opcao, Obs, ImpPeso, ImpMedio, Traco) ;
            VALUES (THIS.this_cNomeEmpresa, THIS.this_cTitulo1, THIS.this_cTitulo2, ;
                    THIS.this_cPeriodo, loc_cProduto, loc_cUnidade, ;
                    THIS.this_nOptTipo, par_lObs, loc_lImpPeso, loc_lImpMedio, par_lObs)

        *-- Query principal em SigMvHst com placeholders para campos enriquecidos
        IF USED("CrSigMvHst")
            USE IN CrSigMvHst
        ENDIF
        loc_cSQL = "SELECT emps, grupos, estos, cpros, codcors, codtams, " + ;
                   "CidChaves, codbarras, dopes, numes, qtds, opers, sqtds, " + ;
                   "unitmeds, moedmeds, obs, empdopnums, empos, datas, " + ;
                   "SPACE(10) AS grupoos, SPACE(10) AS grupods, " + ;
                   "SPACE(10) AS contaos, SPACE(10) AS contads, " + ;
                   "pesos, spesos, " + ;
                   "SPACE(40) AS dpros, SPACE(3) AS cunis, SPACE(3) AS cunips " + ;
                   "FROM SigMvHst " + ;
                   "WHERE " + loc_cWhereHis + ;
                   " ORDER BY " + loc_cOrderBy
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigMvHst")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Erro ao selecionar hist" + CHR(243) + "rico"
            RETURN .F.
        ENDIF

        *-- Enriquecer registros com descricoes, grupos contabeis e observacoes
        SELECT CrSigMvHst
        GO TOP
        SCAN
            IF loc_lErro
                EXIT
            ENDIF

            loc_cEmpDopNums = CrSigMvHst.empos + CrSigMvHst.dopes + STR(CrSigMvHst.numes, 6)
            loc_cEmpDnps    = CrSigMvHst.empos + CrSigMvHst.dopes + STR(CrSigMvHst.numes, 10)
            loc_cNota       = ""

            *-- Substituir campos de descricao com dados do produto ja carregado
            SELECT CrSigMvHst
            REPLACE CrSigMvHst.dpros  WITH ALLTRIM(CrSigCdPro.dpros)
            REPLACE CrSigMvHst.cunis  WITH ALLTRIM(CrSigCdPro.cunis)
            REPLACE CrSigMvHst.cunips WITH ALLTRIM(CrSigCdPro.cunips)

            *-- Buscar grupos contabeis em SigMvCab
            IF USED("TprMvCab")
                USE IN TprMvCab
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT grupoos, contaos, grupods, contads, Notas FROM SigMvCab " + ;
                "WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums), ;
                "TprMvCab")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar movimento contabil"
                loc_lErro = .T.
            ELSE
                SELECT TprMvCab
                GO TOP
                IF !EOF()
                    loc_cNota = ALLTRIM(TprMvCab.Notas)
                    SELECT CrSigMvHst
                    REPLACE CrSigMvHst.grupoos WITH ALLTRIM(TprMvCab.grupoos)
                    REPLACE CrSigMvHst.contaos WITH ALLTRIM(TprMvCab.contaos)
                    REPLACE CrSigMvHst.grupods WITH ALLTRIM(TprMvCab.grupods)
                    REPLACE CrSigMvHst.contads WITH ALLTRIM(TprMvCab.contads)
                    USE IN TprMvCab
                ELSE
                    USE IN TprMvCab
                    *-- Fallback: SigCdNec com chave composta longa
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT grupoos, contaos, grupods, contads FROM SigCdNec " + ;
                        "WHERE empdnps = " + EscaparSQL(loc_cEmpDnps), ;
                        "TprMvCab")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Erro ao buscar NEC"
                        loc_lErro = .T.
                    ELSE
                        SELECT TprMvCab
                        GO TOP
                        IF !EOF()
                            SELECT CrSigMvHst
                            REPLACE CrSigMvHst.grupoos WITH ALLTRIM(TprMvCab.grupoos)
                            REPLACE CrSigMvHst.contaos WITH ALLTRIM(TprMvCab.contaos)
                            REPLACE CrSigMvHst.grupods WITH ALLTRIM(TprMvCab.grupods)
                            REPLACE CrSigMvHst.contads WITH ALLTRIM(TprMvCab.contads)
                        ENDIF
                        USE IN TprMvCab
                    ENDIF
                ENDIF
            ENDIF

            *-- Processar observacao com documento (optObs = 3 = C/Documento)
            IF !loc_lErro AND THIS.this_nOptObs = 3
                IF EMPTY(loc_cNota)
                    *-- Verificar se documento e operacao de producao (SigCdOpd)
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT TOP 1 Dopps FROM SigCdOpd " + ;
                        "WHERE Dopps = " + EscaparSQL(CrSigMvHst.dopes), ;
                        "cursor_4c_CkOpd")
                    loc_lOpExiste = (loc_nResult > 0 AND !EOF("cursor_4c_CkOpd"))
                    IF USED("cursor_4c_CkOpd")
                        USE IN cursor_4c_CkOpd
                    ENDIF

                    IF loc_lOpExiste
                        *-- Buscar ordens de producao vinculadas (SigPdMvf)
                        IF USED("cursor_4c_Mfas")
                            USE IN cursor_4c_Mfas
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT Nops FROM SigPdMvf " + ;
                            "WHERE Emps = " + EscaparSQL(CrSigMvHst.empos) + ;
                            " AND Dopps = " + EscaparSQL(CrSigMvHst.dopes) + ;
                            " AND Numps = " + TRANSFORM(CrSigMvHst.numes), ;
                            "cursor_4c_Mfas")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Erro ao buscar OPs de produ" + CHR(231) + CHR(227) + "o"
                            loc_lErro = .T.
                        ELSE
                            *-- Deduplicar OPs (varias linhas podem apontar para mesma OP)
                            IF USED("cursor_4c_Ops")
                                USE IN cursor_4c_Ops
                            ENDIF
                            CREATE CURSOR cursor_4c_Ops (Nops C(6))
                            INDEX ON Nops TAG Nops

                            SELECT cursor_4c_Mfas
                            GO TOP
                            SCAN
                                SET DECIMALS TO 0
                                loc_cNop = STR(INT(cursor_4c_Mfas.Nops / 10000), 6)
                                SET DECIMALS TO 2
                                SELECT cursor_4c_Ops
                                IF !SEEK(loc_cNop)
                                    APPEND BLANK
                                    REPLACE Nops WITH loc_cNop
                                ENDIF
                                SELECT cursor_4c_Mfas
                            ENDSCAN

                            *-- Montar texto de observacao concatenando numeros de OP
                            loc_lPrimeira = .T.
                            SELECT cursor_4c_Ops
                            GO TOP
                            SCAN
                                loc_cNota = loc_cNota + ;
                                    IIF(loc_lPrimeira, "Ref. OP: ", " / ") + ;
                                    ALLTRIM(cursor_4c_Ops.Nops)
                                loc_lPrimeira = .F.
                            ENDSCAN

                            IF !EMPTY(loc_cNota)
                                SELECT CrSigMvHst
                                REPLACE CrSigMvHst.obs WITH loc_cNota
                            ENDIF

                            IF USED("cursor_4c_Mfas")
                                USE IN cursor_4c_Mfas
                            ENDIF
                            IF USED("cursor_4c_Ops")
                                USE IN cursor_4c_Ops
                            ENDIF
                        ENDIF

                    ELSE
                        *-- Nao e OP: buscar pecas no SigMvPec
                        IF USED("cursor_4c_EstPe")
                            USE IN cursor_4c_EstPe
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT Emps, Dopes, Numes, Codigos FROM SigMvPec " + ;
                            "WHERE Emps = " + EscaparSQL(CrSigMvHst.empos) + ;
                            " AND Dopes = " + EscaparSQL(CrSigMvHst.dopes) + ;
                            " AND Numes = " + TRANSFORM(CrSigMvHst.numes), ;
                            "cursor_4c_EstPe")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Erro ao buscar pe" + CHR(231) + "as"
                            loc_lErro = .T.
                        ELSE
                            loc_lPrimeira = .T.
                            SELECT cursor_4c_EstPe
                            GO TOP
                            SCAN
                                IF loc_lErro
                                    EXIT
                                ENDIF

                                *-- Calcular nDope e Numes a partir do campo Codigos (N10)
                                SET DECIMALS TO 0
                                loc_nNdope = VAL(LEFT(STR(cursor_4c_EstPe.Codigos, 10), 4))
                                loc_nNume  = VAL(RIGHT(STR(cursor_4c_EstPe.Codigos, 10), 6))
                                SET DECIMALS TO 2

                                *-- Buscar Dopes em SigCdOpe pelo numero sequencial
                                IF USED("cursor_4c_Ope")
                                    USE IN cursor_4c_Ope
                                ENDIF
                                loc_nResult = SQLEXEC(gnConnHandle, ;
                                    "SELECT Dopes FROM SigCdOpe " + ;
                                    "WHERE nDopes = " + TRANSFORM(loc_nNdope), ;
                                    "cursor_4c_Ope")
                                IF loc_nResult > 0
                                    SELECT cursor_4c_Ope
                                    GO TOP
                                    IF !EOF()
                                        loc_cDopePeca = ALLTRIM(cursor_4c_Ope.Dopes)
                                        loc_cEDN = cursor_4c_EstPe.Emps + ;
                                                   loc_cDopePeca + ;
                                                   STR(loc_nNume, 6)

                                        *-- Buscar nota fiscal em SigMvCab
                                        IF USED("cursor_4c_Est2")
                                            USE IN cursor_4c_Est2
                                        ENDIF
                                        loc_nResult = SQLEXEC(gnConnHandle, ;
                                            "SELECT Notas FROM SigMvCab " + ;
                                            "WHERE empdopnums = " + EscaparSQL(loc_cEDN), ;
                                            "cursor_4c_Est2")
                                        IF loc_nResult > 0
                                            SELECT cursor_4c_Est2
                                            GO TOP
                                            IF !EOF()
                                                loc_cNotaPeca = ALLTRIM(cursor_4c_Est2.Notas)
                                                IF !EMPTY(loc_cNotaPeca)
                                                    SELECT CrSigMvHst
                                                    REPLACE CrSigMvHst.obs WITH ;
                                                        IIF(loc_lPrimeira, ;
                                                            "Ref. N.F.: ", ;
                                                            CrSigMvHst.obs + " / ") + ;
                                                        loc_cNotaPeca
                                                    loc_lPrimeira = .F.
                                                ENDIF
                                            ENDIF
                                            USE IN cursor_4c_Est2
                                        ENDIF
                                    ENDIF
                                    USE IN cursor_4c_Ope
                                ENDIF

                                SELECT cursor_4c_EstPe
                            ENDSCAN

                            IF USED("cursor_4c_EstPe")
                                USE IN cursor_4c_EstPe
                            ENDIF
                        ENDIF
                    ENDIF
                ELSE
                    *-- Nota da NF ja preenchida: substituir observacao diretamente
                    SELECT CrSigMvHst
                    REPLACE CrSigMvHst.obs WITH "Ref. N.F.: " + loc_cNota
                ENDIF
            ENDIF

            SELECT CrSigMvHst
        ENDSCAN

        IF loc_lErro
            RETURN .F.
        ENDIF

        *-- Cursor auxiliar de configuracao para o relatorio FRX
        IF USED("TempCab")
            USE IN TempCab
        ENDIF
        CREATE CURSOR TempCab (ImpMedio L)
        loc_lImpMedio = (par_nImpMedio = 1)
        INSERT INTO TempCab (ImpMedio) VALUES (loc_lImpMedio)

        *-- Cursor de estrutura auxiliar (referenciado pelo relatorio FRX)
        IF USED("TmpHist")
            USE IN TmpHist
        ENDIF
        CREATE CURSOR TmpHist (;
            CPros C(14), CodCors C(4), CodTams C(4), Datas D, ;
            Numes N(6,0), Dopes C(20), Qtds N(12,3), Opers C(1), ;
            SQtds N(12,3), UnitMeds N(16,6), MoedMeds C(3), Codbarras N(8,0))

        SELECT CrSigMvHst
        GO TOP

        loc_lSucesso = .T.
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Pre-visualizacao do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                *-- Posicionar cursor de dados correto no inicio
                IF THIS.this_nOptTipo = 3
                    IF USED("CsRelatorio")
                        SELECT CsRelatorio
                        GO TOP
                    ENDIF
                ELSE
                    IF USED("CrSigMvHst")
                        SELECT CrSigMvHst
                        GO TOP
                    ENDIF
                ENDIF

                *-- Escolher relatorio: SigRehp1 (sem coluna peso) ou SigRehp2 (com peso)
                IF USED("CsCabecalho")
                    SELECT CsCabecalho
                    GO TOP
                    IF !EOF()
                        IF !CsCabecalho.ImpPeso
                            REPORT FORM (gc_4c_CaminhoReports + "SigRehp1") PREVIEW NOCONSOLE
                        ELSE
                            REPORT FORM (gc_4c_CaminhoReports + "SigRehp2") PREVIEW NOCONSOLE
                        ENDIF
                    ENDIF
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora com dialogo de selecao
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOptTipo = 3
                    IF USED("CsRelatorio")
                        SELECT CsRelatorio
                        GO TOP
                    ENDIF
                ELSE
                    IF USED("CrSigMvHst")
                        SELECT CrSigMvHst
                        GO TOP
                    ENDIF
                ENDIF

                IF USED("CsCabecalho")
                    SELECT CsCabecalho
                    GO TOP
                    IF !EOF()
                        IF !CsCabecalho.ImpPeso
                            REPORT FORM (gc_4c_CaminhoReports + "SigRehp1") ;
                                TO PRINTER PROMPT NOCONSOLE
                        ELSE
                            REPORT FORM (gc_4c_CaminhoReports + "SigRehp2") ;
                                TO PRINTER PROMPT NOCONSOLE
                        ENDIF
                    ENDIF
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursors - Fecha todos os cursores abertos por este BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursors()
        LOCAL loc_aCursors[19], loc_nI
        loc_aCursors[1]  = "CsRelatorio"
        loc_aCursors[2]  = "CsCabecalho"
        loc_aCursors[3]  = "CrTmpUni"
        loc_aCursors[4]  = "TmpEst"
        loc_aCursors[5]  = "TmpHis"
        loc_aCursors[6]  = "TprMvCab"
        loc_aCursors[7]  = "TmpPro"
        loc_aCursors[8]  = "CrSigCdPro"
        loc_aCursors[9]  = "CrSigCdGrp"
        loc_aCursors[10] = "CrSigMvHst"
        loc_aCursors[11] = "TempCab"
        loc_aCursors[12] = "TmpHist"
        loc_aCursors[13] = "cursor_4c_CrEmpSrh"
        loc_aCursors[14] = "cursor_4c_Mfas"
        loc_aCursors[15] = "cursor_4c_Ops"
        loc_aCursors[16] = "cursor_4c_EstPe"
        loc_aCursors[17] = "cursor_4c_Ope"
        loc_aCursors[18] = "cursor_4c_Est2"
        loc_aCursors[19] = "cursor_4c_CkOpd"
        FOR loc_nI = 1 TO 19
            IF USED(loc_aCursors[loc_nI])
                USE IN (loc_aCursors[loc_nI])
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE

