# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH 0 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: 0.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREEQR.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1689 linhas total):

*-- Linhas 82 a 90:
82:         loc_lSucesso   = .F.
83:         loc_lContinuar = .T.
84:         TRY
85:             THIS.Caption = "Relat" + CHR(243) + "rio de Posi" + CHR(231) + ;
86:                            CHR(227) + "o de Estoque Retroativo"
87: 
88:             IF TYPE("gc_4c_CaminhoIcones") = "U"
89:                 gc_4c_CaminhoIcones = ""
90:             ENDIF

*-- Linhas 119 a 128:
119:                 *-- Inicializa campos com valores padrao (empresa corrente)
120:                 THIS.LimparCampos()
121: 
122:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
123:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
124: 
125:                 THIS.Visible   = .T.
126:                 loc_lSucesso   = .T.
127:             ENDIF
128:         CATCH TO loc_oErro

*-- Linhas 141 a 182:
141:     PROTECTED PROCEDURE ConfigurarCabecalho()
142:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
143:         WITH THIS.cnt_4c_Cabecalho
144:             .Top         = 0
145:             .Left        = 0
146:             .Width       = THIS.Width
147:             .Height      = 80
148:             .BackStyle   = 1
149:             .BackColor   = RGB(100, 100, 100)
150:             .BorderWidth = 0
151:             .Visible     = .T.
152: 
153:             *-- Sombra deslocada (efeito 3D)
154:             .AddObject("lbl_4c_Sombra", "Label")
155:             WITH .lbl_4c_Sombra
156:                 .Top       = 22
157:                 .Left      = 22
158:                 .Width     = THIS.Width
159:                 .Height    = 30
160:                 .Caption   = "Relat" + CHR(243) + "rio de Posi" + CHR(231) + ;
161:                              CHR(227) + "o de Estoque Retroativo"
162:                 .FontName  = "Tahoma"
163:                 .FontSize  = 14
164:                 .FontBold  = .T.
165:                 .ForeColor = RGB(0, 0, 0)
166:                 .BackStyle = 0
167:                 .Visible   = .T.
168:             ENDWITH
169: 
170:             *-- Titulo em branco sobre fundo escuro
171:             .AddObject("lbl_4c_Titulo", "Label")
172:             WITH .lbl_4c_Titulo
173:                 .Top       = 20
174:                 .Left      = 20
175:                 .Width     = THIS.Width
176:                 .Height    = 30
177:                 .Caption   = "Relat" + CHR(243) + "rio de Posi" + CHR(231) + ;
178:                              CHR(227) + "o de Estoque Retroativo"
179:                 .FontName  = "Tahoma"
180:                 .FontSize  = 14
181:                 .FontBold  = .T.
182:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 188 a 220:
188: 
189:     *--------------------------------------------------------------------------
190:     * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
191:     *   Posicao: cmg_4c_Botoes.Left=529, seguindo geometria do framework.vcx
192:     *   Buttons(2)=Imprimir tem Visible=.F. conforme original (ocultado no legado)
193:     *--------------------------------------------------------------------------
194:     PROTECTED PROCEDURE ConfigurarBotoes()
195:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
196:         WITH THIS.cmg_4c_Botoes
197:             .Top           = 0
198:             .Left          = 529
199:             .Width         = 273
200:             .Height        = 80
201:             .ButtonCount   = 4
202:             .BackStyle     = 0
203:             .BorderStyle   = 0
204:             .BorderColor   = RGB(136, 189, 188)
205:             .SpecialEffect = 1
206:             .Themes        = .F.
207:             .Visible       = .T.
208: 
209:             *-- Visualizar (ToolTipText="Processar" conforme original)
210:             WITH .Buttons(1)
211:                 .Top             = 5
212:                 .Left            = 5
213:                 .Width           = 65
214:                 .Height          = 70
215:                 .Caption         = "Visualizar"
216:                 .FontBold        = .T.
217:                 .FontItalic      = .T.
218:                 .BackColor       = RGB(255, 255, 255)
219:                 .ForeColor       = RGB(90, 90, 90)
220:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 228 a 240:
228: 
229:             *-- Imprimir (Visible=.F. conforme original)
230:             WITH .Buttons(2)
231:                 .Top             = 5
232:                 .Left            = 71
233:                 .Width           = 65
234:                 .Height          = 70
235:                 .Caption         = "Imprimir"
236:                 .FontName        = "Tahoma"
237:                 .FontBold        = .T.
238:                 .FontItalic      = .T.
239:                 .FontSize        = 8
240:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 250 a 262:
250: 
251:             *-- Excel
252:             WITH .Buttons(3)
253:                 .Top             = 5
254:                 .Left            = 137
255:                 .Width           = 65
256:                 .Height          = 70
257:                 .Caption         = "Excel"
258:                 .FontName        = "Tahoma"
259:                 .FontBold        = .T.
260:                 .FontItalic      = .T.
261:                 .FontSize        = 8
262:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 272 a 284:
272: 
273:             *-- Encerrar - Cancel=.T. garante que ESC fecha o form
274:             WITH .Buttons(4)
275:                 .Top             = 5
276:                 .Left            = 203
277:                 .Width           = 65
278:                 .Height          = 70
279:                 .Caption         = "Encerrar"
280:                 .Cancel          = .T.
281:                 .FontName        = "Tahoma"
282:                 .FontBold        = .T.
283:                 .FontItalic      = .T.
284:                 .FontSize        = 8

*-- Linhas 313 a 327:
313: 
314:         loc_oPgf.PageCount = 1
315: 
316:         loc_oPgf.Top    = 85
317:         loc_oPgf.Left   = -1
318:         loc_oPgf.Width  = THIS.Width + 2
319:         loc_oPgf.Height = THIS.Height - 85
320:         loc_oPgf.Tabs   = .F.
321: 
322:         loc_oPgf.Page1.Caption   = "Filtros"
323:         loc_oPgf.Page1.FontName  = "Tahoma"
324:         loc_oPgf.Page1.FontSize  = 8
325:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
326:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
327:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 354 a 665:
354:         loc_oPag = THIS.pgf_4c_Paginas.Page1
355: 
356:         *-- Sec 1: Referencia de Estoque + Data Saldo
357:         loc_oPag.AddObject("lbl_4c_RefEstoque", "Label")
358:         WITH loc_oPag.lbl_4c_RefEstoque
359:             .Top       = 62
360:             .Left      = 82
361:             .Width     = 110
362:             .Height    = 18
363:             .Caption   = "Refer. Estoque :"
364:             .FontName  = "Tahoma"
365:             .FontSize  = 8
366:             .ForeColor = RGB(90, 90, 90)
367:             .BackStyle = 0
368:             .Visible   = .T.
369:         ENDWITH
370: 
371:         loc_oPag.AddObject("obj_4c_OptRfestoque", "OptionGroup")
372:         WITH loc_oPag.obj_4c_OptRfestoque
373:             .Top         = 147
374:             .Left        = 195
375:             .Width       = 147
376:             .Height      = 52
377:             .ButtonCount = 2
378:             .BackStyle   = 0
379:             .BorderStyle = 0
380:             .Themes      = .F.
381:             .Value       = 1
382:             .Visible     = .T.
383:         ENDWITH
384:         WITH loc_oPag.obj_4c_OptRfestoque.Buttons(1)
385:             .Top       = 2
386:             .Left      = 5
387:             .Width     = 132
388:             .Height    = 22
389:             .Caption   = "Atual"
390:             .BackStyle = 0
391:             .ForeColor = RGB(90, 90, 90)
392:         ENDWITH
393:         WITH loc_oPag.obj_4c_OptRfestoque.Buttons(2)
394:             .Top       = 28
395:             .Left      = 5
396:             .Width     = 132
397:             .Height    = 22
398:             .Caption   = "Retroativo"
399:             .BackStyle = 0
400:             .FontName  = "Tahoma"
401:             .FontSize  = 8
402:             .ForeColor = RGB(90, 90, 90)
403:         ENDWITH
404:         BINDEVENT(loc_oPag.obj_4c_OptRfestoque, "Click", THIS, "OptRfestoqueClick")
405: 
406:         loc_oPag.AddObject("lbl_4c_DataSaldo", "Label")
407:         WITH loc_oPag.lbl_4c_DataSaldo
408:             .Top       = 86
409:             .Left      = 220
410:             .Width     = 78
411:             .Height    = 18
412:             .Caption   = "Data Saldo:"
413:             .FontName  = "Tahoma"
414:             .FontSize  = 8
415:             .ForeColor = RGB(90, 90, 90)
416:             .BackStyle = 0
417:             .Visible   = .T.
418:         ENDWITH
419: 
420:         loc_oPag.AddObject("txt_4c_DataSaldo", "TextBox")
421:         WITH loc_oPag.txt_4c_DataSaldo
422:             .Top      = 82
423:             .Left     = 301
424:             .Width    = 79
425:             .Height   = 25
426:             .Value    = {}
427:             .FontName = "Tahoma"
428:             .FontSize = 8
429:             .Enabled  = .F.
430:             .Visible  = .T.
431:         ENDWITH
432: 
433:         *-- Sec 2: Empresa (codigo + descricao)
434:         loc_oPag.AddObject("lbl_4c_Empresa", "Label")
435:         WITH loc_oPag.lbl_4c_Empresa
436:             .Top       = 114
437:             .Left      = 247
438:             .Width     = 50
439:             .Height    = 18
440:             .Caption   = "Empresa :"
441:             .FontName  = "Tahoma"
442:             .FontSize  = 8
443:             .ForeColor = RGB(90, 90, 90)
444:             .BackStyle = 0
445:             .Visible   = .T.
446:         ENDWITH
447: 
448:         loc_oPag.AddObject("txt_4c_CdEmpresa", "TextBox")
449:         WITH loc_oPag.txt_4c_CdEmpresa
450:             .Top      = 109
451:             .Left     = 301
452:             .Width    = 33
453:             .Height   = 25
454:             .Value    = ""
455:             .FontName = "Tahoma"
456:             .FontSize = 8
457:             .Visible  = .T.
458:         ENDWITH
459:         BINDEVENT(loc_oPag.txt_4c_CdEmpresa, "KeyPress", THIS, "TxtCdEmpresaKeyPress")
460:         BINDEVENT(loc_oPag.txt_4c_CdEmpresa, "DblClick", THIS, "TxtCdEmpresaDblClick")
461: 
462:         loc_oPag.AddObject("txt_4c_DsEmpresa", "TextBox")
463:         WITH loc_oPag.txt_4c_DsEmpresa
464:             .Top      = 109
465:             .Left     = 336
466:             .Width    = 290
467:             .Height   = 25
468:             .Value    = ""
469:             .FontName = "Tahoma"
470:             .FontSize = 8
471:             .Visible  = .T.
472:         ENDWITH
473:         BINDEVENT(loc_oPag.txt_4c_DsEmpresa, "KeyPress", THIS, "TxtDsEmpresaKeyPress")
474:         BINDEVENT(loc_oPag.txt_4c_DsEmpresa, "DblClick", THIS, "TxtDsEmpresaDblClick")
475: 
476:         *-- Sec 3: Grupo de Produto (codigo + descricao)
477:         loc_oPag.AddObject("lbl_4c_GrupoProd", "Label")
478:         WITH loc_oPag.lbl_4c_GrupoProd
479:             .Top       = 141
480:             .Left      = 221
481:             .Width     = 77
482:             .Height    = 18
483:             .Caption   = "Grupo Produto:"
484:             .FontName  = "Tahoma"
485:             .FontSize  = 8
486:             .ForeColor = RGB(90, 90, 90)
487:             .BackStyle = 0
488:             .Visible   = .T.
489:         ENDWITH
490: 
491:         loc_oPag.AddObject("txt_4c_CdGrupo", "TextBox")
492:         WITH loc_oPag.txt_4c_CdGrupo
493:             .Top      = 136
494:             .Left     = 301
495:             .Width    = 33
496:             .Height   = 25
497:             .Value    = ""
498:             .FontName = "Tahoma"
499:             .FontSize = 8
500:             .Visible  = .T.
501:         ENDWITH
502:         BINDEVENT(loc_oPag.txt_4c_CdGrupo, "KeyPress", THIS, "TxtCdGrupoKeyPress")
503:         BINDEVENT(loc_oPag.txt_4c_CdGrupo, "DblClick", THIS, "TxtCdGrupoDblClick")
504: 
505:         loc_oPag.AddObject("txt_4c_DsGrupo", "TextBox")
506:         WITH loc_oPag.txt_4c_DsGrupo
507:             .Top      = 136
508:             .Left     = 336
509:             .Width    = 290
510:             .Height   = 25
511:             .Value    = ""
512:             .FontName = "Tahoma"
513:             .FontSize = 8
514:             .Visible  = .T.
515:         ENDWITH
516:         BINDEVENT(loc_oPag.txt_4c_DsGrupo, "KeyPress", THIS, "TxtDsGrupoKeyPress")
517:         BINDEVENT(loc_oPag.txt_4c_DsGrupo, "DblClick", THIS, "TxtDsGrupoDblClick")
518: 
519:         *-- Sec 4: Moeda para Conversao (codigo + descricao)
520:         loc_oPag.AddObject("lbl_4c_Moeda", "Label")
521:         WITH loc_oPag.lbl_4c_Moeda
522:             .Top       = 168
523:             .Left      = 191
524:             .Width     = 108
525:             .Height    = 18
526:             .Caption   = "Moeda p/Convers" + CHR(227) + "o :"
527:             .FontName  = "Tahoma"
528:             .FontSize  = 8
529:             .ForeColor = RGB(90, 90, 90)
530:             .BackStyle = 0
531:             .Visible   = .T.
532:         ENDWITH
533: 
534:         loc_oPag.AddObject("txt_4c_CdMoeda", "TextBox")
535:         WITH loc_oPag.txt_4c_CdMoeda
536:             .Top      = 163
537:             .Left     = 301
538:             .Width    = 33
539:             .Height   = 25
540:             .Value    = ""
541:             .FontName = "Tahoma"
542:             .FontSize = 8
543:             .Visible  = .T.
544:         ENDWITH
545:         BINDEVENT(loc_oPag.txt_4c_CdMoeda, "KeyPress", THIS, "TxtCdMoedaKeyPress")
546:         BINDEVENT(loc_oPag.txt_4c_CdMoeda, "DblClick", THIS, "TxtCdMoedaDblClick")
547: 
548:         loc_oPag.AddObject("txt_4c_DsMoeda", "TextBox")
549:         WITH loc_oPag.txt_4c_DsMoeda
550:             .Top      = 163
551:             .Left     = 336
552:             .Width    = 107
553:             .Height   = 23
554:             .Value    = ""
555:             .FontName = "Tahoma"
556:             .FontSize = 8
557:             .Visible  = .T.
558:         ENDWITH
559:         BINDEVENT(loc_oPag.txt_4c_DsMoeda, "KeyPress", THIS, "TxtDsMoedaKeyPress")
560:         BINDEVENT(loc_oPag.txt_4c_DsMoeda, "DblClick", THIS, "TxtDsMoedaDblClick")
561: 
562:         *-- Sec 5: Grupo de Calculo de Custo - inicialmente oculto
563:         loc_oPag.AddObject("lbl_4c_GrupoCalc", "Label")
564:         WITH loc_oPag.lbl_4c_GrupoCalc
565:             .Top       = 193
566:             .Left      = 259
567:             .Width     = 40
568:             .Height    = 18
569:             .Caption   = "Grupo :"
570:             .FontName  = "Tahoma"
571:             .FontSize  = 8
572:             .ForeColor = RGB(90, 90, 90)
573:             .BackStyle = 0
574:             .Visible   = .F.
575:         ENDWITH
576: 
577:         loc_oPag.AddObject("txt_4c_CdGrupoCalc", "TextBox")
578:         WITH loc_oPag.txt_4c_CdGrupoCalc
579:             .Top      = 188
580:             .Left     = 301
581:             .Width    = 33
582:             .Height   = 25
583:             .Value    = ""
584:             .FontName = "Tahoma"
585:             .FontSize = 8
586:             .Visible  = .F.
587:         ENDWITH
588:         BINDEVENT(loc_oPag.txt_4c_CdGrupoCalc, "KeyPress", THIS, "TxtCdGrupoCalcKeyPress")
589:         BINDEVENT(loc_oPag.txt_4c_CdGrupoCalc, "DblClick", THIS, "TxtCdGrupoCalcDblClick")
590: 
591:         loc_oPag.AddObject("txt_4c_DsGrupoCalc", "TextBox")
592:         WITH loc_oPag.txt_4c_DsGrupoCalc
593:             .Top      = 188
594:             .Left     = 336
595:             .Width    = 290
596:             .Height   = 25
597:             .Value    = ""
598:             .FontName = "Tahoma"
599:             .FontSize = 8
600:             .Visible  = .F.
601:         ENDWITH
602:         BINDEVENT(loc_oPag.txt_4c_DsGrupoCalc, "KeyPress", THIS, "TxtDsGrupoCalcKeyPress")
603:         BINDEVENT(loc_oPag.txt_4c_DsGrupoCalc, "DblClick", THIS, "TxtDsGrupoCalcDblClick")
604: 
605:         *-- Sec 6: Calculo de Custo (Total / Por Grupo)
606:         loc_oPag.AddObject("lbl_4c_CalcCusto", "Label")
607:         WITH loc_oPag.lbl_4c_CalcCusto
608:             .Top       = 218
609:             .Left      = 211
610:             .Width     = 86
611:             .Height    = 18
612:             .Caption   = "C" + CHR(225) + "lculo de Custo:"
613:             .FontName  = "Tahoma"
614:             .FontSize  = 8
615:             .ForeColor = RGB(90, 90, 90)
616:             .BackStyle = 0
617:             .Visible   = .T.
618:         ENDWITH
619: 
620:         loc_oPag.AddObject("obj_4c_OptCalcusto", "OptionGroup")
621:         WITH loc_oPag.obj_4c_OptCalcusto
622:             .Top         = 213
623:             .Left        = 300
624:             .Width       = 108
625:             .Height      = 25
626:             .ButtonCount = 2
627:             .BackStyle   = 0
628:             .BorderStyle = 0
629:             .Themes      = .F.
630:             .Value       = 1
631:             .Visible     = .T.
632:             WITH .Buttons(1)
633:                 .Top       = 2
634:                 .Left      = 0
635:                 .Width     = 53
636:                 .Height    = 21
637:                 .Caption   = "Total"
638:                 .ForeColor = RGB(90, 90, 90)
639:             ENDWITH
640:             WITH .Buttons(2)
641:                 .Top       = 2
642:                 .Left      = 55
643:                 .Width     = 53
644:                 .Height    = 21
645:                 .Caption   = "Por Grupo"
646:                 .FontName  = "Tahoma"
647:                 .FontSize  = 8
648:                 .ForeColor = RGB(90, 90, 90)
649:             ENDWITH
650:         ENDWITH
651:         BINDEVENT(loc_oPag.obj_4c_OptCalcusto, "Click", THIS, "OptCalcustoClick")
652: 
653:         *-- Sec 7: Grade interativa de grupos/contas de estoque
654:         *   Column1: CheckBox marcas | Column2: grupos (RO) | Column3: contas (RO)
655:         loc_oPag.AddObject("grd_4c_Grade", "Grid")
656:         loc_oGrd = loc_oPag.grd_4c_Grade
657:         loc_oGrd.ColumnCount = 3
658:         WITH loc_oGrd
659:             .Top                = 246
660:             .Left               = 302
661:             .Width              = 244
662:             .Height             = 167
663:             .FontName           = "Verdana"
664:             .FontSize           = 8
665:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 675 a 701:
675:             .Visible            = .T.
676:         ENDWITH
677: 
678:         *-- Column1: CheckBox para marcar/desmarcar grupos e contas
679:         loc_oGrd.Column1.AddObject("Check1", "CheckBox")
680:         loc_oGrd.Column1.Check1.Caption  = ""
681:         loc_oGrd.Column1.CurrentControl  = "Check1"
682:         loc_oGrd.Column1.ControlSource   = "Selecao.marcas"
683:         loc_oGrd.Column1.Width           = 30
684:         loc_oGrd.Column1.Header1.Caption = ""
685: 
686:         *-- Column2: Grupo (somente leitura)
687:         loc_oGrd.Column2.ControlSource   = "Selecao.grupos"
688:         loc_oGrd.Column2.Width           = 107
689:         loc_oGrd.Column2.ReadOnly        = .T.
690:         loc_oGrd.Column2.Header1.Caption = "Grupo"
691: 
692:         *-- Column3: Conta (somente leitura)
693:         loc_oGrd.Column3.ControlSource   = "Selecao.contas"
694:         loc_oGrd.Column3.Width           = 107
695:         loc_oGrd.Column3.ReadOnly        = .T.
696:         loc_oGrd.Column3.Header1.Caption = "Conta"
697: 
698:         *-- RecordSource apenas se cursor Selecao foi populado
699:         IF USED("Selecao")
700:             loc_oGrd.RecordSource     = "Selecao"
701:             loc_oGrd.RecordSourceType = 1

*-- Linhas 708 a 756:
708:         ENDTRY
709: 
710:         *-- Sec 8: Botoes de selecao da grade (ao lado direito da grade)
711:         loc_oPag.AddObject("cmd_4c_SelTudo", "CommandButton")
712:         WITH loc_oPag.cmd_4c_SelTudo
713:             .Top           = 374
714:             .Left          = 549
715:             .Width         = 45
716:             .Height        = 45
717:             .Caption       = "Todos"
718:             .FontName      = "Tahoma"
719:             .FontSize      = 7
720:             .FontBold      = .T.
721:             .ForeColor     = RGB(90, 90, 90)
722:             .BackColor     = RGB(255, 255, 255)
723:             .SpecialEffect = 0
724:             .MousePointer  = 15
725:             .ToolTipText   = "Selecionar Todos"
726:             .Themes        = .F.
727:             .WordWrap      = .T.
728:             .Visible       = .T.
729:         ENDWITH
730:         BINDEVENT(loc_oPag.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
731: 
732:         loc_oPag.AddObject("cmd_4c_Apaga", "CommandButton")
733:         WITH loc_oPag.cmd_4c_Apaga
734:             .Top           = 419
735:             .Left          = 549
736:             .Width         = 45
737:             .Height        = 45
738:             .Caption       = "Limpar"
739:             .FontName      = "Tahoma"
740:             .FontSize      = 7
741:             .FontBold      = .T.
742:             .ForeColor     = RGB(90, 90, 90)
743:             .BackColor     = RGB(255, 255, 255)
744:             .SpecialEffect = 0
745:             .MousePointer  = 15
746:             .ToolTipText   = "Desmarcar Todos"
747:             .Themes        = .F.
748:             .WordWrap      = .T.
749:             .Visible       = .T.
750:         ENDWITH
751:         BINDEVENT(loc_oPag.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
752:     ENDPROC
753: 
754:     *--------------------------------------------------------------------------
755:     * ConfigurarPaginaLista - Alias canonico do pipeline (delega para filtros)
756:     *--------------------------------------------------------------------------

*-- Linhas 1022 a 1030:
1022:     * BtnExcluirClick - Acao destrutiva no contexto report: limpa selecoes
1023:     *   Em um cadastro CRUD excluiria o registro corrente; em um relatorio o
1024:     *   equivalente proximo e limpar as selecoes da grade de contas/grupos
1025:     *   (mesma logica do botao cmd_4c_Apaga do legado).
1026:     *--------------------------------------------------------------------------
1027:     PROCEDURE BtnExcluirClick()
1028:         IF !USED("Selecao")
1029:             MsgAviso("Nenhuma sele" + CHR(231) + CHR(227) + "o para limpar.", ;
1030:                 "Sem Sele" + CHR(231) + CHR(227) + "o")

*-- Linhas 1282 a 1290:
1282:         LOCAL loc_oPag, loc_lPorGrupo
1283:         loc_oPag      = THIS.pgf_4c_Paginas.Page1
1284:         loc_lPorGrupo = (loc_oPag.obj_4c_OptCalcusto.Value = 2)
1285:         loc_oPag.lbl_4c_GrupoCalc.Visible   = loc_lPorGrupo
1286:         loc_oPag.txt_4c_CdGrupoCalc.Visible = loc_lPorGrupo
1287:         loc_oPag.txt_4c_DsGrupoCalc.Visible = loc_lPorGrupo
1288:         IF !loc_lPorGrupo
1289:             loc_oPag.txt_4c_CdGrupoCalc.Value = ""
1290:             loc_oPag.txt_4c_DsGrupoCalc.Value = ""

*-- Linhas 1602 a 1620:
1602:         ENDIF
1603:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1604:         WITH THIS.this_oRelatorio
1605:             loc_oPag.txt_4c_CdEmpresa.Value    = .this_cCdEmpresa
1606:             loc_oPag.txt_4c_DsEmpresa.Value    = .this_cDsEmpresa
1607:             loc_oPag.txt_4c_CdGrupo.Value      = .this_cCdGrupo
1608:             loc_oPag.txt_4c_DsGrupo.Value      = .this_cDsGrupo
1609:             loc_oPag.txt_4c_CdMoeda.Value      = .this_cCdMoeda
1610:             loc_oPag.txt_4c_DsMoeda.Value      = .this_cDsMoeda
1611:             loc_oPag.txt_4c_CdGrupoCalc.Value  = .this_cCdGrupoCalc
1612:             loc_oPag.txt_4c_DsGrupoCalc.Value  = .this_cDsGrupoCalc
1613:             loc_oPag.obj_4c_OptRfestoque.Value = .this_nRfEstoque
1614:             loc_oPag.obj_4c_OptCalcusto.Value  = .this_nCalcusto
1615:             loc_oPag.txt_4c_DataSaldo.Value    = .this_dDataSaldo
1616:         ENDWITH
1617:         THIS.AjustarCamposPorRefEstoque()
1618:         THIS.AjustarCamposPorCalcusto()
1619:     ENDPROC
1620: 


### BO (C:\4c\projeto\app\classes\SIGREEQRBO.prg):
*==============================================================================
* SIGREEQRBO.PRG
* Business Object para Relatorio de Posicao de Estoque Retroativo
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS SIGREEQRBO AS RelatorioBase

    *-- Filtros: Empresa
    this_cCdEmpresa     = ""
    this_cDsEmpresa     = ""

    *-- Filtros: Grupo de Produto
    this_cCdGrupo       = ""
    this_cDsGrupo       = ""

    *-- Filtros: Data de Saldo (usada quando this_nRfEstoque = 2)
    this_dDataSaldo     = {}

    *-- Filtros: Moeda para Conversao
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *-- Filtros: Grupo de Calculo de Custo (visivel quando this_nCalcusto = 2)
    this_cCdGrupoCalc   = ""
    this_cDsGrupoCalc   = ""

    *-- Opcao de referencia de estoque: 1=Atual, 2=em data especifica
    this_nRfEstoque     = 1

    *-- Opcao de calculo de custo: 1=Total, 2=por Grupo
    this_nCalcusto      = 1

    *-- Nomes dos cursores de resultado produzidos pelo processamento
    this_cCursorGrupos      = "csTempoGr"
    this_cCursorProdutos    = "CsTempoCp"
    this_cCursorCabecalho   = "dbCabecalho"
    this_cCursorSelecao     = "Selecao"

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarSelecao - Cria cursor Selecao com grupos/contas de estoque
    * Chamado pelo Form no Init para popular o grid de selecao interativa
    *--------------------------------------------------------------------------
    PROCEDURE InicializarSelecao()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                *-- Grupos de estoque ativos (estoques = 1)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT codigos FROM SigCdGcr WHERE estoques = 1", ;
                    "TmpGccr")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar grupos de estoque"
                    EXIT
                ENDIF

                *-- Clientes vinculados aos grupos de estoque
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT b.grupos, b.iclis" + ;
                    " FROM SigCdCli b INNER JOIN SigCdGcr c ON b.grupos = c.codigos" + ;
                    " WHERE c.internos = '                    '" + ;
                    " AND c.estoques = 1", ;
                    "TmpCliGccr")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar clientes por grupo"
                    EXIT
                ENDIF

                *-- Combina grupos (linhas pai) e contas (linhas filhas) em Selecao
                IF USED("Selecao")
                    USE IN Selecao
                ENDIF

                SELECT 0 AS marcas, codigos AS grupos, SPACE(10) AS contas ;
                    FROM TmpGccr ;
                UNION ALL ;
                SELECT 0 AS marcas, grupos, iclis AS contas ;
                    FROM TmpCliGccr ;
                INTO CURSOR Selecao READWRITE

                IF !USED("Selecao")
                    CREATE CURSOR Selecao (marcas n(1), grupos c(10), contas c(10))
                ENDIF

                SELECT Selecao
                GO TOP
                INDEX ON grupos + contas TAG grucon

                IF USED("TmpGccr")
                    USE IN TmpGccr
                ENDIF
                IF USED("TmpCliGccr")
                    USE IN TmpCliGccr
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio de posicao de estoque retroativo
    * Usa: cursor Selecao (populado e marcado pelo usuario no form)
    * Produz: cursors csTempoGr, CsTempoCp, dbCabecalho
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult
        LOCAL loc_cCdEmpresa, loc_cCdGrupo, loc_nImpCusto, loc_nRfEstoque
        LOCAL loc_dDataSaldo, loc_cMoeda, loc_cGrpCalc
        LOCAL loc_cDatas, loc_dDataConv
        LOCAL loc_cCbTitulo, loc_cCbGrupo, loc_cCbEmpresa
        LOCAL loc_lcCpro, loc_mValGr
        LOCAL loc_cAno, loc_cMes, loc_cDia

        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                loc_cCdEmpresa = ALLTRIM(THIS.this_cCdEmpresa)
                loc_cCdGrupo   = ALLTRIM(THIS.this_cCdGrupo)
                loc_nImpCusto  = THIS.this_nCalcusto
                loc_nRfEstoque = THIS.this_nRfEstoque
                loc_dDataSaldo = THIS.this_dDataSaldo
                loc_cMoeda     = ALLTRIM(THIS.this_cCdMoeda)
                loc_cGrpCalc   = ALLTRIM(THIS.this_cCdGrupoCalc)

                *-- Formata data para SQL Server: YYYY-MM-DD HH:MM:SS
                IF EMPTY(loc_dDataSaldo)
                    loc_dDataSaldo = DATE()
                ENDIF
                loc_dDataSaldo = MAX(loc_dDataSaldo, CTOD("01/01/1900"))
                loc_cAno   = PADL(TRANSFORM(YEAR(loc_dDataSaldo)),  4, "0")
                loc_cMes   = PADL(TRANSFORM(MONTH(loc_dDataSaldo)), 2, "0")
                loc_cDia   = PADL(TRANSFORM(DAY(loc_dDataSaldo)),   2, "0")
                loc_cDatas = loc_cAno + "-" + loc_cMes + "-" + loc_cDia + " 23:59:59"

                *-- Cursor de cabecalho para o relatorio
                IF USED("dbCabecalho")
                    USE IN dbCabecalho
                ENDIF
                CREATE CURSOR dbCabecalho (Titulo c(100), SubTitulo c(100), NomeEmpresa c(100))
                loc_cCbEmpresa = ALLTRIM(THIS.this_cDsEmpresa)
                loc_cCbTitulo  = "Posi" + CHR(231) + CHR(227) + "o de Estoque Retroativo " + ;
                    IIF(loc_nRfEstoque = 1, "Atual", "em " + DTOC(loc_dDataSaldo))
                loc_cCbGrupo   = "Grupo p/Calculo de Custo : " + ;
                    IIF(EMPTY(loc_cGrpCalc), "Geral", loc_cGrpCalc) + ;
                    "  Grupo de Produto: " + ;
                    IIF(EMPTY(loc_cCdGrupo), "Geral", ;
                        loc_cCdGrupo + " - " + ALLTRIM(THIS.this_cDsGrupo))
                INSERT INTO dbCabecalho (Titulo, SubTitulo, NomeEmpresa) ;
                    VALUES (loc_cCbTitulo, loc_cCbGrupo, loc_cCbEmpresa)

                *-- Cursor de agrupamentos (totais por grupo/conta/linha)
                IF USED("csTempoGr")
                    USE IN csTempoGr
                ENDIF
                CREATE CURSOR csTempoGr ( ;
                    grupos c(10), contas c(10), linhas c(10), ;
                    tpesos n(12,2), tqtds n(12,3), vlvenda n(12,2), ;
                    moevenda c(3), vlcusto n(12,2), moecusto c(3), ;
                    tipos c(1), Quebra c(1))
                INDEX ON tipos + grupos + contas + Quebra + linhas + ;
                    moevenda + moecusto TAG Imprimir

                *-- Cursor de produtos (detalhe por produto)
                IF USED("CsTempoCp")
                    USE IN CsTempoCp
                ENDIF
                CREATE CURSOR CsTempoCp ( ;
                    cpros c(14), dpros c(40), tpesos n(12,2), tqtds n(12,3), ;
                    vlvenda n(12,2), moevenda c(3), vlcusto n(12,2), moecusto c(3), ;
                    tipos c(1), grupos c(10), contas c(10), linhas c(10), Quebra c(1))
                INDEX ON Tipos + grupos + contas + Quebra + linhas + cpros TAG Imprimir
                INDEX ON Grupos + Contas + Linhas + Cpros TAG visualizar

                *-- Busca movimentacoes conforme modo: estoque atual ou retroativo
                IF loc_nRfEstoque = 1
                    *-- Estoque atual: saldo corrente em SigMvEst
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT a.cpros, a.emps, a.grupos, a.estos," + ;
                        " a.sqtds, a.sqtds AS qtds, c.Dpros, c.Linhas," + ;
                        " c.custofs, c.pvens, c.fvendas, c.moepvs," + ;
                        " c.pesoms, c.moecusfs, c.moevs, d.tpcustos, d.tpvendas" + ;
                        " FROM SigMvEst a" + ;
                        " INNER JOIN SigCdPro c ON a.cpros = c.cpros" + ;
                        " INNER JOIN SigCdLin d ON c.Linhas = d.Linhas" + ;
                        " WHERE a.emps = " + EscaparSQL(loc_cCdEmpresa) + ;
                        " AND a.sqtds <> 0" + ;
                        IIF(!EMPTY(loc_cCdGrupo), ;
                            " AND c.cgrus = " + EscaparSQL(loc_cCdGrupo), "") + ;
                        " ORDER BY a.cpros, a.emps, a.grupos, a.estos", ;
                        "CsTmpEst")
                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar estoque atual"
                        EXIT
                    ENDIF
                    loc_dDataConv = DATE()
                ELSE
                    *-- Estoque retroativo: historico SigMvHst ate a data informada
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT a.emps, a.grupos, a.estos, a.cpros," + ;
                        " a.qtds, a.opers, c.Dpros, c.Linhas," + ;
                        " c.custofs, c.pvens, c.fvendas, c.moepvs," + ;
                        " c.pesoms, c.moecusfs, c.moevs, f.tpcustos, f.tpvendas" + ;
                        " FROM SigMvHst a" + ;
                        " LEFT JOIN SigCdPro c ON a.cpros = c.Cpros" + ;
                        " LEFT JOIN SigCdLin f ON c.Linhas = f.Linhas" + ;
                        " WHERE a.emps = " + EscaparSQL(loc_cCdEmpresa) + ;
                        " AND a.datas <= '" + loc_cDatas + "'" + ;
                        IIF(!EMPTY(loc_cCdGrupo), ;
                            " AND c.cgrus = " + EscaparSQL(loc_cCdGrupo), ""), ;
                        "TmpEstPro")
                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar historico de estoque"
                        EXIT
                    ENDIF

                    *-- Calcula saldo: soma entradas (E=+1) e saidas (S=-1)
                    SELECT emps, grupos, estos, cpros, ;
                        SUM(qtds * IIF(opers = "E", 1, -1)) AS qtds, ;
                        Dpros, Linhas, custofs, pvens, fvendas, moepvs, ;
                        pesoms, moecusfs, moevs, tpcustos, tpvendas ;
                    FROM TmpEstPro ;
                    GROUP BY emps, grupos, estos, cpros, Dpros, Linhas, ;
                        custofs, pvens, fvendas, moepvs, pesoms, ;
                        moecusfs, moevs, tpcustos, tpvendas ;
                    HAVING SUM(qtds * IIF(opers = "E", 1, -1)) <> 0 ;
                    INTO CURSOR CsTmpEst

                    IF USED("TmpEstPro")
                        USE IN TmpEstPro
                    ENDIF
                    loc_dDataConv = loc_dDataSaldo
                ENDIF

                *-- Filtra pelos grupos/contas marcados no grid Selecao
                IF USED("TmpEst")
                    USE IN TmpEst
                ENDIF
                SELECT DISTINCT ;
                    a.cpros, a.emps, a.grupos, a.estos, a.qtds, ;
                    a.Dpros, a.Linhas, a.custofs, a.pvens, a.fvendas, ;
                    a.moepvs, a.pesoms, a.moecusfs, a.moevs, ;
                    a.tpcustos, a.tpvendas ;
                FROM CsTmpEst a, Selecao b ;
                WHERE a.grupos = b.grupos ;
                    AND IIF(!EMPTY(b.contas), a.estos = b.contas, .T.) ;
                    AND b.marcas = 1 ;
                INTO CURSOR TmpEst ;
                ORDER BY a.cpros

                IF USED("CsTmpEst")
                    USE IN CsTmpEst
                ENDIF

                *-- Processa produtos: calcula custos, converte moeda, acumula por grupo
                SELECT TmpEst
                GO TOP
                loc_lcCpro = SPACE(14)

                SCAN
                    SCATTER MEMVAR
                    m.vlCusto  = m.custofs
                    m.vlvenda  = ROUND(m.pvens * ;
                        IIF(m.fvendas <> 0 .AND. !EMPTY(m.moepvs), m.fvendas, 1), 2)
                    m.moecusto = m.moecusfs
                    m.moevenda = m.moevs
                    m.tqtds    = m.qtds
                    m.tpesos   = m.pesoms * m.qtds
                    m.contas   = m.estos
                    m.tipos    = " "
                    m.Quebra   = " "

                    IF m.tpcustos = "2"
                        m.vlCusto = m.pesoms * m.vlCusto
                    ENDIF
                    IF m.tpvendas = "2"
                        m.vlvenda = m.pesoms * m.vlvenda
                    ENDIF

                    *-- Custo por composicao (quando opt_calcusto = 2 = por grupo)
                    IF loc_nImpCusto = 2
                        IF m.cpros <> loc_lcCpro
                            loc_nResult = SQLEXEC(gnConnHandle, ;
                                "SELECT cpros, cgrus, pcompos, qtds, moeds" + ;
                                " FROM SigPrCpo" + ;
                                " WHERE cpros = " + EscaparSQL(m.cpros) + ;
                                " AND cgrus = " + EscaparSQL(loc_cGrpCalc), ;
                                "CrSigPrCpo")
                        ENDIF
                        IF loc_nResult >= 0
                            loc_mValGr = 0
                            SELECT CrSigPrCpo
                            SCAN
                                loc_mValGr = loc_mValGr + ;
                                    ((CrSigPrCpo.pcompos * CrSigPrCpo.qtds) * ;
                                    fBuscarCotacao(CrSigPrCpo.moeds, loc_dDataConv, gnConnHandle) / ;
                                    fBuscarCotacao(m.moecusto, loc_dDataConv, gnConnHandle))
                            ENDSCAN
                            m.vlcusto = loc_mValGr
                            IF USED("CrSigPrCpo")
                                USE IN CrSigPrCpo
                            ENDIF
                        ENDIF
                    ENDIF

                    *-- Converte valores para moeda solicitada (quando informada)
                    IF !EMPTY(loc_cMoeda)
                        m.vlcusto  = m.vlcusto * ;
                            fBuscarCotacao(m.moecusto, loc_dDataConv, gnConnHandle) / ;
                            fBuscarCotacao(loc_cMoeda,  loc_dDataConv, gnConnHandle)
                        m.vlvenda  = m.vlvenda * ;
                            fBuscarCotacao(m.moevenda, loc_dDataConv, gnConnHandle) / ;
                            fBuscarCotacao(loc_cMoeda,  loc_dDataConv, gnConnHandle)
                        m.moecusto = loc_cMoeda
                        m.moevenda = loc_cMoeda
                    ENDIF

                    m.vlvenda = m.vlvenda * m.qtds
                    m.vlcusto = m.vlcusto * m.qtds

                    *-- Registra detalhe do produto em CsTempoCp
                    SELECT CsTempoCp
                    APPEND BLANK
                    GATHER MEMVAR

                    *-- Acumula totais por grupo em csTempoGr (usa index Imprimir)
                    SELECT csTempoGr
                    IF !SEEK(" " + m.grupos + m.contas + " " + m.linhas + ;
                            m.moevenda + m.moecusto)
                        APPEND BLANK
                        GATHER MEMVAR
                        REPLACE csTempoGr.tqtds   WITH 0
                        REPLACE csTempoGr.tpesos  WITH 0
                        REPLACE csTempoGr.vlvenda WITH 0
                        REPLACE csTempoGr.vlCusto WITH 0
                    ENDIF
                    REPLACE csTempoGr.tqtds   WITH csTempoGr.tqtds   + m.tqtds
                    REPLACE csTempoGr.tpesos  WITH csTempoGr.tpesos  + m.tpesos
                    REPLACE csTempoGr.vlVenda WITH csTempoGr.vlVenda + m.vlvenda
                    REPLACE csTempoGr.vlcusto WITH csTempoGr.vlcusto + m.vlcusto

                    IF m.cpros <> loc_lcCpro
                        loc_lcCpro = m.cpros
                    ENDIF
                    SELECT TmpEst
                ENDSCAN

                *-- Calcula totais: por linha (tipo 5), geral (tipo 6), subtotal por grupo
                IF USED("Tempo")
                    USE IN Tempo
                ENDIF
                SELECT "5" AS tipos, PADR("Tot Linha", 10) AS grupos, ;
                    SPACE(10) AS contas, linhas, ;
                    SUM(tpesos) AS tpesos, SUM(tqtds) AS tqtds, ;
                    SUM(vlvenda) AS vlvenda, moevenda, ;
                    SUM(vlcusto) AS vlcusto, moecusto, ;
                    SPACE(14) AS Cpros, SPACE(40) AS Dpros, " " AS Quebra ;
                    FROM csTempoGr GROUP BY 1, 4, 8, 10 ;
                UNION ALL ;
                SELECT "6" AS tipos, PADR("Tot Geral", 10) AS grupos, ;
                    SPACE(10) AS contas, SPACE(10) AS linhas, ;
                    SUM(tpesos) AS tpesos, SUM(tqtds) AS tqtds, ;
                    SUM(vlvenda) AS vlvenda, moevenda, ;
                    SUM(vlcusto) AS vlcusto, moecusto, ;
                    SPACE(14) AS Cpros, SPACE(40) AS Dpros, " " AS Quebra ;
                    FROM csTempoGr GROUP BY 1, 8, 10 ;
                UNION ALL ;
                SELECT " " AS tipos, grupos, contas, PADR("Total", 10) AS linhas, ;
                    SUM(tpesos) AS tpesos, SUM(tqtds) AS tqtds, ;
                    SUM(vlvenda) AS vlvenda, moevenda, ;
                    SUM(vlcusto) AS vlcusto, moecusto, ;
                    SPACE(14) AS Cpros, SPACE(40) AS Dpros, "1" AS Quebra ;
                    FROM csTempoGr GROUP BY 1, 2, 3, 8, 10 ;
                INTO CURSOR Tempo

                *-- Linha separadora no cursor de grupos
                SELECT csTempoGr
                APPEND BLANK
                REPLACE csTempoGr.Tipos    WITH "2"
                REPLACE csTempoGr.Grupos   WITH "----------"
                REPLACE csTempoGr.Contas   WITH "----------"
                REPLACE csTempoGr.Linhas   WITH "----------"
                REPLACE csTempoGr.moevenda WITH "---"
                REPLACE csTempoGr.moecusto WITH "---"

                *-- Mescla totais calculados nos cursores de saida
                SELECT Tempo
                SCAN
                    SCATTER MEMVAR
                    SELECT csTempoGr
                    APPEND BLANK
                    GATHER MEMVAR
                    SELECT CsTempoCp
                    APPEND BLANK
                    GATHER MEMVAR
                ENDSCAN

                IF USED("Tempo")
                    USE IN Tempo
                ENDIF
                IF USED("TmpEst")
                    USE IN TmpEst
                ENDIF

                SELECT csTempoGr
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                REPORT FORM (gc_4c_CaminhoReports + "SigReEqr") PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                REPORT FORM (gc_4c_CaminhoReports + "SigReEqr") TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    * Retorna identificador composto dos filtros para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cData
        loc_cData = IIF(EMPTY(THIS.this_dDataSaldo), "", DTOC(THIS.this_dDataSaldo))
        loc_cChave = "EMP=" + ALLTRIM(THIS.this_cCdEmpresa) + ;
                     ";GRU=" + ALLTRIM(THIS.this_cCdGrupo) + ;
                     ";RFE=" + TRANSFORM(THIS.this_nRfEstoque) + ;
                     ";DTS=" + loc_cData + ;
                     ";MOE=" + ALLTRIM(THIS.this_cCdMoeda) + ;
                     ";CUS=" + TRANSFORM(THIS.this_nCalcusto) + ;
                     ";GCC=" + ALLTRIM(THIS.this_cCdGrupoCalc)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de cursor de preset
    * Permite restaurar parametros previamente salvos para reexecucao
    * par_cAliasCursor: cursor com colunas no formato preset
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + "o dispon" + ;
                                          CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
                loc_lSucesso = .F.
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                    loc_lSucesso = .F.
                ELSE
                    SCATTER MEMVAR

                    IF TYPE("m.cCdEmpresa") = "C"
                        THIS.this_cCdEmpresa = ALLTRIM(m.cCdEmpresa)
                    ENDIF
                    IF TYPE("m.cDsEmpresa") = "C"
                        THIS.this_cDsEmpresa = ALLTRIM(m.cDsEmpresa)
                    ENDIF
                    IF TYPE("m.cCdGrupo") = "C"
                        THIS.this_cCdGrupo = ALLTRIM(m.cCdGrupo)
                    ENDIF
                    IF TYPE("m.cDsGrupo") = "C"
                        THIS.this_cDsGrupo = ALLTRIM(m.cDsGrupo)
                    ENDIF
                    IF TYPE("m.dDataSaldo") = "D"
                        THIS.this_dDataSaldo = m.dDataSaldo
                    ENDIF
                    IF TYPE("m.cCdMoeda") = "C"
                        THIS.this_cCdMoeda = ALLTRIM(m.cCdMoeda)
                    ENDIF
                    IF TYPE("m.cDsMoeda") = "C"
                        THIS.this_cDsMoeda = ALLTRIM(m.cDsMoeda)
                    ENDIF
                    IF TYPE("m.cCdGrupoCalc") = "C"
                        THIS.this_cCdGrupoCalc = ALLTRIM(m.cCdGrupoCalc)
                    ENDIF
                    IF TYPE("m.cDsGrupoCalc") = "C"
                        THIS.this_cDsGrupoCalc = ALLTRIM(m.cDsGrupoCalc)
                    ENDIF
                    IF TYPE("m.nRfEstoque") = "N"
                        THIS.this_nRfEstoque = m.nRfEstoque
                    ENDIF
                    IF TYPE("m.nCalcusto") = "N"
                        THIS.this_nCalcusto = m.nCalcusto
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Valida filtros obrigatorios, delega para Imprimir() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_lValido
        loc_lSucesso = .F.
        loc_lValido = .T.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida."
                loc_lValido = .F.
            ENDIF
            IF loc_lValido .AND. THIS.this_nCalcusto = 2 .AND. ;
               EMPTY(ALLTRIM(THIS.this_cCdGrupoCalc))
                THIS.this_cMensagemErro = "Grupo de C" + CHR(225) + "lculo Obrigat" + ;
                                          CHR(243) + "rio"
                loc_lValido = .F.
            ENDIF
            IF loc_lValido .AND. THIS.this_nRfEstoque = 2 .AND. ;
               EMPTY(THIS.this_dDataSaldo)
                THIS.this_cMensagemErro = "Data do Saldo obrigat" + CHR(243) + ;
                                          "ria para estoque retroativo"
                loc_lValido = .F.
            ENDIF

            IF loc_lValido
                loc_lSucesso = THIS.Imprimir()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("IMPRESSAO")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: recalcular e visualizar
    * Valida filtros obrigatorios, delega para Visualizar() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_lValido
        loc_lSucesso = .F.
        loc_lValido = .T.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida."
                loc_lValido = .F.
            ENDIF
            IF loc_lValido .AND. THIS.this_nCalcusto = 2 .AND. ;
               EMPTY(ALLTRIM(THIS.this_cCdGrupoCalc))
                THIS.this_cMensagemErro = "Grupo de C" + CHR(225) + "lculo Obrigat" + ;
                                          CHR(243) + "rio"
                loc_lValido = .F.
            ENDIF
            IF loc_lValido .AND. THIS.this_nRfEstoque = 2 .AND. ;
               EMPTY(THIS.this_dDataSaldo)
                THIS.this_cMensagemErro = "Data do Saldo obrigat" + CHR(243) + ;
                                          "ria para estoque retroativo"
                loc_lValido = .F.
            ENDIF

            IF loc_lValido
                loc_lSucesso = THIS.Visualizar()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("VISUALIZACAO")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO, EXCEL)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReEqr") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
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
    * Destroy - Libera cursores temporarios do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("Selecao")
            USE IN Selecao
        ENDIF
        IF USED("csTempoGr")
            USE IN csTempoGr
        ENDIF
        IF USED("CsTempoCp")
            USE IN CsTempoCp
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("TmpGccr")
            USE IN TmpGccr
        ENDIF
        IF USED("TmpCliGccr")
            USE IN TmpCliGccr
        ENDIF
        IF USED("CsTmpEst")
            USE IN CsTmpEst
        ENDIF
        IF USED("TmpEstPro")
            USE IN TmpEstPro
        ENDIF
        IF USED("TmpEst")
            USE IN TmpEst
        ENDIF
        IF USED("Tempo")
            USE IN Tempo
        ENDIF
        IF USED("CrSigPrCpo")
            USE IN CrSigPrCpo
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

