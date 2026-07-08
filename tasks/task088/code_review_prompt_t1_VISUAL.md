# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [GRID-WITH] Bloco WITH 0 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: 0.RecordSource).
- [LAYOUT-POSITION] Controle 'apaga' (parent: SIGREEQR): Top original=419 vs migrado 'cmd_4c_Apaga' Top=334 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'SelTudo' (parent: SIGREEQR): Top original=374 vs migrado 'cmd_4c_SelTudo' Top=289 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optRfestoque' (parent: SIGREEQR): Top original=147 vs migrado 'obj_4c_OptRfestoque' Top=2 (diff=145px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optRfestoque' (parent: SIGREEQR): Left original=195 vs migrado 'obj_4c_OptRfestoque' Left=5 (diff=190px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREEQR.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1708 linhas total):

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

*-- Linhas 354 a 662:
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
373:             .Top         = 62
374:             .Left        = 195
375:             .Width       = 142
376:             .Height      = 52
377:             .ButtonCount = 2
378:             .BackStyle   = 0
379:             .BorderStyle = 0
380:             .Themes      = .F.
381:             .Value       = 1
382:             .Visible     = .T.
383:             WITH .Buttons(1)
384:                 .Top       = 2
385:                 .Left      = 5
386:                 .Width     = 132
387:                 .Height    = 22
388:                 .Caption   = "Atual"
389:                 .ForeColor = RGB(90, 90, 90)
390:             ENDWITH
391:             WITH .Buttons(2)
392:                 .Top       = 28
393:                 .Left      = 5
394:                 .Width     = 132
395:                 .Height    = 22
396:                 .Caption   = "Retroativo"
397:                 .FontName  = "Tahoma"
398:                 .FontSize  = 8
399:                 .ForeColor = RGB(90, 90, 90)
400:             ENDWITH
401:         ENDWITH
402:         BINDEVENT(loc_oPag.obj_4c_OptRfestoque, "Click", THIS, "OptRfestoqueClick")
403: 
404:         loc_oPag.AddObject("lbl_4c_DataSaldo", "Label")
405:         WITH loc_oPag.lbl_4c_DataSaldo
406:             .Top       = 86
407:             .Left      = 220
408:             .Width     = 78
409:             .Height    = 18
410:             .Caption   = "Data Saldo:"
411:             .FontName  = "Tahoma"
412:             .FontSize  = 8
413:             .ForeColor = RGB(90, 90, 90)
414:             .BackStyle = 0
415:             .Visible   = .T.
416:         ENDWITH
417: 
418:         loc_oPag.AddObject("txt_4c_DataSaldo", "TextBox")
419:         WITH loc_oPag.txt_4c_DataSaldo
420:             .Top      = 82
421:             .Left     = 301
422:             .Width    = 79
423:             .Height   = 25
424:             .Value    = {}
425:             .FontName = "Tahoma"
426:             .FontSize = 8
427:             .Enabled  = .F.
428:             .Visible  = .T.
429:         ENDWITH
430: 
431:         *-- Sec 2: Empresa (codigo + descricao)
432:         loc_oPag.AddObject("lbl_4c_Empresa", "Label")
433:         WITH loc_oPag.lbl_4c_Empresa
434:             .Top       = 114
435:             .Left      = 247
436:             .Width     = 50
437:             .Height    = 18
438:             .Caption   = "Empresa :"
439:             .FontName  = "Tahoma"
440:             .FontSize  = 8
441:             .ForeColor = RGB(90, 90, 90)
442:             .BackStyle = 0
443:             .Visible   = .T.
444:         ENDWITH
445: 
446:         loc_oPag.AddObject("txt_4c_CdEmpresa", "TextBox")
447:         WITH loc_oPag.txt_4c_CdEmpresa
448:             .Top      = 109
449:             .Left     = 301
450:             .Width    = 33
451:             .Height   = 25
452:             .Value    = ""
453:             .FontName = "Tahoma"
454:             .FontSize = 8
455:             .Visible  = .T.
456:         ENDWITH
457:         BINDEVENT(loc_oPag.txt_4c_CdEmpresa, "KeyPress", THIS, "TxtCdEmpresaKeyPress")
458:         BINDEVENT(loc_oPag.txt_4c_CdEmpresa, "DblClick", THIS, "TxtCdEmpresaDblClick")
459: 
460:         loc_oPag.AddObject("txt_4c_DsEmpresa", "TextBox")
461:         WITH loc_oPag.txt_4c_DsEmpresa
462:             .Top      = 109
463:             .Left     = 336
464:             .Width    = 290
465:             .Height   = 25
466:             .Value    = ""
467:             .FontName = "Tahoma"
468:             .FontSize = 8
469:             .Visible  = .T.
470:         ENDWITH
471:         BINDEVENT(loc_oPag.txt_4c_DsEmpresa, "KeyPress", THIS, "TxtDsEmpresaKeyPress")
472:         BINDEVENT(loc_oPag.txt_4c_DsEmpresa, "DblClick", THIS, "TxtDsEmpresaDblClick")
473: 
474:         *-- Sec 3: Grupo de Produto (codigo + descricao)
475:         loc_oPag.AddObject("lbl_4c_GrupoProd", "Label")
476:         WITH loc_oPag.lbl_4c_GrupoProd
477:             .Top       = 141
478:             .Left      = 221
479:             .Width     = 77
480:             .Height    = 18
481:             .Caption   = "Grupo Produto:"
482:             .FontName  = "Tahoma"
483:             .FontSize  = 8
484:             .ForeColor = RGB(90, 90, 90)
485:             .BackStyle = 0
486:             .Visible   = .T.
487:         ENDWITH
488: 
489:         loc_oPag.AddObject("txt_4c_CdGrupo", "TextBox")
490:         WITH loc_oPag.txt_4c_CdGrupo
491:             .Top      = 136
492:             .Left     = 301
493:             .Width    = 33
494:             .Height   = 25
495:             .Value    = ""
496:             .FontName = "Tahoma"
497:             .FontSize = 8
498:             .Visible  = .T.
499:         ENDWITH
500:         BINDEVENT(loc_oPag.txt_4c_CdGrupo, "KeyPress", THIS, "TxtCdGrupoKeyPress")
501:         BINDEVENT(loc_oPag.txt_4c_CdGrupo, "DblClick", THIS, "TxtCdGrupoDblClick")
502: 
503:         loc_oPag.AddObject("txt_4c_DsGrupo", "TextBox")
504:         WITH loc_oPag.txt_4c_DsGrupo
505:             .Top      = 136
506:             .Left     = 336
507:             .Width    = 290
508:             .Height   = 25
509:             .Value    = ""
510:             .FontName = "Tahoma"
511:             .FontSize = 8
512:             .Visible  = .T.
513:         ENDWITH
514:         BINDEVENT(loc_oPag.txt_4c_DsGrupo, "KeyPress", THIS, "TxtDsGrupoKeyPress")
515:         BINDEVENT(loc_oPag.txt_4c_DsGrupo, "DblClick", THIS, "TxtDsGrupoDblClick")
516: 
517:         *-- Sec 4: Moeda para Conversao (codigo + descricao)
518:         loc_oPag.AddObject("lbl_4c_Moeda", "Label")
519:         WITH loc_oPag.lbl_4c_Moeda
520:             .Top       = 168
521:             .Left      = 191
522:             .Width     = 108
523:             .Height    = 18
524:             .Caption   = "Moeda p/Convers" + CHR(227) + "o :"
525:             .FontName  = "Tahoma"
526:             .FontSize  = 8
527:             .ForeColor = RGB(90, 90, 90)
528:             .BackStyle = 0
529:             .Visible   = .T.
530:         ENDWITH
531: 
532:         loc_oPag.AddObject("txt_4c_CdMoeda", "TextBox")
533:         WITH loc_oPag.txt_4c_CdMoeda
534:             .Top      = 163
535:             .Left     = 301
536:             .Width    = 33
537:             .Height   = 25
538:             .Value    = ""
539:             .FontName = "Tahoma"
540:             .FontSize = 8
541:             .Visible  = .T.
542:         ENDWITH
543:         BINDEVENT(loc_oPag.txt_4c_CdMoeda, "KeyPress", THIS, "TxtCdMoedaKeyPress")
544:         BINDEVENT(loc_oPag.txt_4c_CdMoeda, "DblClick", THIS, "TxtCdMoedaDblClick")
545: 
546:         loc_oPag.AddObject("txt_4c_DsMoeda", "TextBox")
547:         WITH loc_oPag.txt_4c_DsMoeda
548:             .Top      = 163
549:             .Left     = 336
550:             .Width    = 107
551:             .Height   = 23
552:             .Value    = ""
553:             .FontName = "Tahoma"
554:             .FontSize = 8
555:             .Visible  = .T.
556:         ENDWITH
557:         BINDEVENT(loc_oPag.txt_4c_DsMoeda, "KeyPress", THIS, "TxtDsMoedaKeyPress")
558:         BINDEVENT(loc_oPag.txt_4c_DsMoeda, "DblClick", THIS, "TxtDsMoedaDblClick")
559: 
560:         *-- Sec 5: Grupo de Calculo de Custo - inicialmente oculto
561:         loc_oPag.AddObject("lbl_4c_GrupoCalc", "Label")
562:         WITH loc_oPag.lbl_4c_GrupoCalc
563:             .Top       = 193
564:             .Left      = 259
565:             .Width     = 40
566:             .Height    = 18
567:             .Caption   = "Grupo :"
568:             .FontName  = "Tahoma"
569:             .FontSize  = 8
570:             .ForeColor = RGB(90, 90, 90)
571:             .BackStyle = 0
572:             .Visible   = .F.
573:         ENDWITH
574: 
575:         loc_oPag.AddObject("txt_4c_CdGrupoCalc", "TextBox")
576:         WITH loc_oPag.txt_4c_CdGrupoCalc
577:             .Top      = 188
578:             .Left     = 301
579:             .Width    = 33
580:             .Height   = 25
581:             .Value    = ""
582:             .FontName = "Tahoma"
583:             .FontSize = 8
584:             .Visible  = .F.
585:         ENDWITH
586:         BINDEVENT(loc_oPag.txt_4c_CdGrupoCalc, "KeyPress", THIS, "TxtCdGrupoCalcKeyPress")
587:         BINDEVENT(loc_oPag.txt_4c_CdGrupoCalc, "DblClick", THIS, "TxtCdGrupoCalcDblClick")
588: 
589:         loc_oPag.AddObject("txt_4c_DsGrupoCalc", "TextBox")
590:         WITH loc_oPag.txt_4c_DsGrupoCalc
591:             .Top      = 188
592:             .Left     = 336
593:             .Width    = 290
594:             .Height   = 25
595:             .Value    = ""
596:             .FontName = "Tahoma"
597:             .FontSize = 8
598:             .Visible  = .F.
599:         ENDWITH
600:         BINDEVENT(loc_oPag.txt_4c_DsGrupoCalc, "KeyPress", THIS, "TxtDsGrupoCalcKeyPress")
601:         BINDEVENT(loc_oPag.txt_4c_DsGrupoCalc, "DblClick", THIS, "TxtDsGrupoCalcDblClick")
602: 
603:         *-- Sec 6: Calculo de Custo (Total / Por Grupo)
604:         loc_oPag.AddObject("lbl_4c_CalcCusto", "Label")
605:         WITH loc_oPag.lbl_4c_CalcCusto
606:             .Top       = 218
607:             .Left      = 211
608:             .Width     = 86
609:             .Height    = 18
610:             .Caption   = "C" + CHR(225) + "lculo de Custo:"
611:             .FontName  = "Tahoma"
612:             .FontSize  = 8
613:             .ForeColor = RGB(90, 90, 90)
614:             .BackStyle = 0
615:             .Visible   = .T.
616:         ENDWITH
617: 
618:         loc_oPag.AddObject("obj_4c_OptCalcusto", "OptionGroup")
619:         WITH loc_oPag.obj_4c_OptCalcusto
620:             .Top         = 213
621:             .Left        = 300
622:             .Width       = 108
623:             .Height      = 25
624:             .ButtonCount = 2
625:             .BackStyle   = 0
626:             .BorderStyle = 0
627:             .Themes      = .F.
628:             .Value       = 1
629:             .Visible     = .T.
630:             WITH .Buttons(1)
631:                 .Top       = 2
632:                 .Left      = 0
633:                 .Width     = 53
634:                 .Height    = 21
635:                 .Caption   = "Total"
636:                 .ForeColor = RGB(90, 90, 90)
637:             ENDWITH
638:             WITH .Buttons(2)
639:                 .Top       = 2
640:                 .Left      = 55
641:                 .Width     = 53
642:                 .Height    = 21
643:                 .Caption   = "Por Grupo"
644:                 .FontName  = "Tahoma"
645:                 .FontSize  = 8
646:                 .ForeColor = RGB(90, 90, 90)
647:             ENDWITH
648:         ENDWITH
649:         BINDEVENT(loc_oPag.obj_4c_OptCalcusto, "Click", THIS, "OptCalcustoClick")
650: 
651:         *-- Sec 7: Grade interativa de grupos/contas de estoque
652:         *   Column1: CheckBox marcas | Column2: grupos (RO) | Column3: contas (RO)
653:         loc_oPag.AddObject("grd_4c_Grade", "Grid")
654:         loc_oGrd = loc_oPag.grd_4c_Grade
655:         WITH loc_oGrd
656:             .Top                = 246
657:             .Left               = 302
658:             .Width              = 244
659:             .Height             = 167
660:             .ColumnCount        = 3
661:             .FontName           = "Verdana"
662:             .FontSize           = 8

*-- Linhas 672 a 703:
672:             .ScrollBars         = 2
673:             .Visible            = .T.
674: 
675:             *-- Column1: CheckBox para marcar/desmarcar grupos e contas
676:             WITH .Column1
677:                 .AddObject("Check1", "CheckBox")
678:                 .Check1.Caption = ""
679:                 .CurrentControl = "Check1"
680:                 .ControlSource  = "Selecao.marcas"
681:                 .Width          = 30
682:                 .Header1.Caption = ""
683:             ENDWITH
684: 
685:             *-- Column2: Grupo (somente leitura)
686:             WITH .Column2
687:                 .ControlSource   = "Selecao.grupos"
688:                 .Width           = 107
689:                 .ReadOnly        = .T.
690:                 .Header1.Caption = "Grupo"
691:             ENDWITH
692: 
693:             *-- Column3: Conta (somente leitura)
694:             WITH .Column3
695:                 .ControlSource   = "Selecao.contas"
696:                 .Width           = 107
697:                 .ReadOnly        = .T.
698:                 .Header1.Caption = "Conta"
699:             ENDWITH
700:         ENDWITH
701: 
702:         *-- RecordSource apenas se cursor Selecao foi populado
703:         IF USED("Selecao")

*-- Linhas 712 a 772:
712:             BINDEVENT(loc_oGrd.Column3.Text1, "GotFocus", THIS, "GradeRedirecionarFoco")
713:         CATCH
714:         ENDTRY
715: 
716:         *-- Sec 8: Botoes de selecao da grade (ao lado direito da grade)
717:         loc_oPag.AddObject("cmd_4c_SelTudo", "CommandButton")
718:         WITH loc_oPag.cmd_4c_SelTudo
719:             .Top           = 289
720:             .Left          = 549
721:             .Width         = 45
722:             .Height        = 45
723:             .Caption       = "Todos"
724:             .FontName      = "Tahoma"
725:             .FontSize      = 7
726:             .FontBold      = .T.
727:             .ForeColor     = RGB(90, 90, 90)
728:             .BackColor     = RGB(255, 255, 255)
729:             .SpecialEffect = 0
730:             .MousePointer  = 15
731:             .ToolTipText   = "Selecionar Todos"
732:             .Themes        = .F.
733:             .WordWrap      = .T.
734:             .Visible       = .T.
735:         ENDWITH
736:         BINDEVENT(loc_oPag.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
737: 
738:         loc_oPag.AddObject("cmd_4c_Apaga", "CommandButton")
739:         WITH loc_oPag.cmd_4c_Apaga
740:             .Top           = 334
741:             .Left          = 549
742:             .Width         = 45
743:             .Height        = 45
744:             .Caption       = "Limpar"
745:             .FontName      = "Tahoma"
746:             .FontSize      = 7
747:             .FontBold      = .T.
748:             .ForeColor     = RGB(90, 90, 90)
749:             .BackColor     = RGB(255, 255, 255)
750:             .SpecialEffect = 0
751:             .MousePointer  = 15
752:             .ToolTipText   = "Desmarcar Todos"
753:             .Themes        = .F.
754:             .WordWrap      = .T.
755:             .Visible       = .T.
756:         ENDWITH
757:         BINDEVENT(loc_oPag.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
758:     ENDPROC
759: 
760:     *--------------------------------------------------------------------------
761:     * ConfigurarPaginaLista - Alias canonico do pipeline (delega para filtros)
762:     *--------------------------------------------------------------------------
763:     PROTECTED PROCEDURE ConfigurarPaginaLista()
764:         THIS.ConfigurarPaginaFiltros()
765:     ENDPROC
766: 
767:     *--------------------------------------------------------------------------
768:     * ConfigurarPaginaDados - Alias canonico do pipeline (delega para filtros)
769:     *--------------------------------------------------------------------------
770:     PROTECTED PROCEDURE ConfigurarPaginaDados()
771:         THIS.ConfigurarPaginaFiltros()
772:     ENDPROC

*-- Linhas 1026 a 1046:
1026: 
1027:     *--------------------------------------------------------------------------
1028:     * BtnExcluirClick - Acao destrutiva no contexto report: limpa selecoes
1029:     *   Em um cadastro CRUD excluiria o registro corrente; em um relatorio o
1030:     *   equivalente proximo e limpar as selecoes da grade de contas/grupos
1031:     *   (mesma logica do botao cmd_4c_Apaga do legado).
1032:     *--------------------------------------------------------------------------
1033:     PROCEDURE BtnExcluirClick()
1034:         IF !USED("Selecao")
1035:             MsgAviso("Nenhuma sele" + CHR(231) + CHR(227) + "o para limpar.", ;
1036:                 "Sem Sele" + CHR(231) + CHR(227) + "o")
1037:             RETURN
1038:         ENDIF
1039:         IF !MsgConfirma("Limpar todas as sele" + CHR(231) + CHR(245) + ;
1040:                 "es da grade?", "Confirmar")
1041:             RETURN
1042:         ENDIF
1043:         SELECT Selecao
1044:         REPLACE ALL marcas WITH 0
1045:         GO TOP
1046:         IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)

*-- Linhas 1288 a 1296:
1288:         LOCAL loc_oPag, loc_lPorGrupo
1289:         loc_oPag      = THIS.pgf_4c_Paginas.Page1
1290:         loc_lPorGrupo = (loc_oPag.obj_4c_OptCalcusto.Value = 2)
1291:         loc_oPag.lbl_4c_GrupoCalc.Visible   = loc_lPorGrupo
1292:         loc_oPag.txt_4c_CdGrupoCalc.Visible = loc_lPorGrupo
1293:         loc_oPag.txt_4c_DsGrupoCalc.Visible = loc_lPorGrupo
1294:         IF !loc_lPorGrupo
1295:             loc_oPag.txt_4c_CdGrupoCalc.Value = ""
1296:             loc_oPag.txt_4c_DsGrupoCalc.Value = ""

*-- Linhas 1621 a 1639:
1621:         ENDIF
1622:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1623:         WITH THIS.this_oRelatorio
1624:             loc_oPag.txt_4c_CdEmpresa.Value    = .this_cCdEmpresa
1625:             loc_oPag.txt_4c_DsEmpresa.Value    = .this_cDsEmpresa
1626:             loc_oPag.txt_4c_CdGrupo.Value      = .this_cCdGrupo
1627:             loc_oPag.txt_4c_DsGrupo.Value      = .this_cDsGrupo
1628:             loc_oPag.txt_4c_CdMoeda.Value      = .this_cCdMoeda
1629:             loc_oPag.txt_4c_DsMoeda.Value      = .this_cDsMoeda
1630:             loc_oPag.txt_4c_CdGrupoCalc.Value  = .this_cCdGrupoCalc
1631:             loc_oPag.txt_4c_DsGrupoCalc.Value  = .this_cDsGrupoCalc
1632:             loc_oPag.obj_4c_OptRfestoque.Value = .this_nRfEstoque
1633:             loc_oPag.obj_4c_OptCalcusto.Value  = .this_nCalcusto
1634:             loc_oPag.txt_4c_DataSaldo.Value    = .this_dDataSaldo
1635:         ENDWITH
1636:         THIS.AjustarCamposPorRefEstoque()
1637:         THIS.AjustarCamposPorCalcusto()
1638:     ENDPROC
1639: 


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

