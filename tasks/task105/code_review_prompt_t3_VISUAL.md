# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (6)
- [LAYOUT-POSITION] Controle 'OptRfEstoque' (parent: SIGREFXV): Top original=126 vs migrado 'obj_4c_OptRfEstoque' Top=0 (diff=126px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptRfEstoque' (parent: SIGREFXV): Left original=162 vs migrado 'obj_4c_OptRfEstoque' Left=0 (diff=162px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_moeda' (parent: SIGREFXV): Top original=189 vs migrado 'lbl_4c_Lbl_moeda' Top=104 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_grupo' (parent: SIGREFXV): Top original=270 vs migrado 'lbl_4c_Lbl_grupo' Top=185 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Aguarde' (parent: SIGREFXV): Top original=190 vs migrado 'cnt_4c_Aguarde' Top=13 (diff=177px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Aguarde' (parent: SIGREFXV): Left original=261 vs migrado 'cnt_4c_Aguarde' Left=12 (diff=249px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREFXV.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1545 linhas total):

*-- Linhas 73 a 81:
73:         loc_lContinuar = .T.
74: 
75:         TRY
76:             THIS.Caption = "Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + ;
77:                            "o de Estoque  por Grupo de Produto/Faixa de Valor"
78: 
79:             IF TYPE("gc_4c_CaminhoIcones") = "U"
80:                 gc_4c_CaminhoIcones = ""
81:             ENDIF

*-- Linhas 117 a 126:
117:                 *-- Vincular eventos Click dos botoes de relatorio
118:                 THIS.ConfigurarBotoesBind()
119: 
120:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
121:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
122: 
123:                 THIS.Visible = .T.
124:                 loc_lSucesso = .T.
125:             ENDIF
126: 

*-- Linhas 142 a 225:
142:     PROTECTED PROCEDURE ConfigurarCabecalho()
143:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
144:         WITH THIS.cnt_4c_Cabecalho
145:             .Top         = 0
146:             .Left        = 0
147:             .Width       = THIS.Width
148:             .Height      = 80
149:             .BackStyle   = 1
150:             .BackColor   = RGB(100, 100, 100)
151:             .BorderWidth = 0
152:             .Visible     = .T.
153: 
154:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
155:             .AddObject("lbl_4c_Sombra", "Label")
156:             WITH .lbl_4c_Sombra
157:                 .Top       = 22
158:                 .Left      = 22
159:                 .Width     = THIS.Width
160:                 .Height    = 30
161:                 .Caption   = THIS.Caption
162:                 .FontName  = "Tahoma"
163:                 .FontSize  = 14
164:                 .FontBold  = .T.
165:                 .ForeColor = RGB(0, 0, 0)
166:                 .BackStyle = 0
167:                 .Visible   = .T.
168:             ENDWITH
169: 
170:             *-- Titulo em branco (sobre a sombra)
171:             .AddObject("lbl_4c_Titulo", "Label")
172:             WITH .lbl_4c_Titulo
173:                 .Top       = 20
174:                 .Left      = 20
175:                 .Width     = THIS.Width
176:                 .Height    = 30
177:                 .Caption   = THIS.Caption
178:                 .FontName  = "Tahoma"
179:                 .FontSize  = 14
180:                 .FontBold  = .T.
181:                 .ForeColor = RGB(255, 255, 255)
182:                 .BackStyle = 0
183:                 .Visible   = .T.
184:             ENDWITH
185:         ENDWITH
186:     ENDPROC
187: 
188:     *--------------------------------------------------------------------------
189:     * ConfigurarBotoes - CommandGroup de botoes de relatorio (btnReport area)
190:     *   Original: btnReport.Left=408, Width=348, Height=75 por botao
191:     *   Novo: cmg_4c_Botoes alinhado a direita do form (Width=761)
192:     *   Botoes: Visualizar(5), Imprimir(71), Excel(137), Encerrar(203) - W=65
193:     *   Eventos Click sao vinculados nas fases seguintes (Fase 7).
194:     *--------------------------------------------------------------------------
195:     PROTECTED PROCEDURE ConfigurarBotoes()
196:         *-- Alinhar a direita com margem de 5px
197:         LOCAL loc_nLeft
198:         loc_nLeft = THIS.Width - 273 - 5
199: 
200:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
201:         WITH THIS.cmg_4c_Botoes
202:             .Top           = 0
203:             .Left          = loc_nLeft
204:             .Width         = 273
205:             .Height        = 80
206:             .ButtonCount   = 4
207:             .BackStyle     = 0
208:             .BorderStyle   = 0
209:             .BorderColor   = RGB(136, 189, 188)
210:             .SpecialEffect = 1
211:             .Themes        = .F.
212:             .Visible       = .T.
213: 
214:             *-- Visualizar (preview em tela)
215:             WITH .Buttons(1)
216:                 .Top             = 5
217:                 .Left            = 5
218:                 .Width           = 65
219:                 .Height          = 70
220:                 .Caption         = "Visualizar"
221:                 .FontBold        = .T.
222:                 .FontItalic      = .T.
223:                 .BackColor       = RGB(255, 255, 255)
224:                 .ForeColor       = RGB(90, 90, 90)
225:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 233 a 245:
233: 
234:             *-- Imprimir (com dialogo de impressora)
235:             WITH .Buttons(2)
236:                 .Top             = 5
237:                 .Left            = 71
238:                 .Width           = 65
239:                 .Height          = 70
240:                 .Caption         = "Imprimir"
241:                 .FontName        = "Tahoma"
242:                 .FontBold        = .T.
243:                 .FontItalic      = .T.
244:                 .FontSize        = 8
245:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 255 a 267:
255: 
256:             *-- Excel (exportar dados)
257:             WITH .Buttons(3)
258:                 .Top             = 5
259:                 .Left            = 137
260:                 .Width           = 65
261:                 .Height          = 70
262:                 .Caption         = "Excel"
263:                 .FontName        = "Tahoma"
264:                 .FontBold        = .T.
265:                 .FontItalic      = .T.
266:                 .FontSize        = 8
267:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 277 a 289:
277: 
278:             *-- Encerrar (fechar form - ESC)
279:             WITH .Buttons(4)
280:                 .Top             = 5
281:                 .Left            = 203
282:                 .Width           = 65
283:                 .Height          = 70
284:                 .Caption         = "Encerrar"
285:                 .Cancel          = .T.
286:                 .FontName        = "Tahoma"
287:                 .FontBold        = .T.
288:                 .FontItalic      = .T.
289:                 .FontSize        = 8

*-- Linhas 316 a 331:
316:         loc_oPgf.PageCount = 1
317: 
318:         *-- Posicionamento: logo abaixo do cabecalho ate o fim do form
319:         loc_oPgf.Top    = 85
320:         loc_oPgf.Left   = -1
321:         loc_oPgf.Width  = THIS.Width + 2
322:         loc_oPgf.Height = THIS.Height - 85
323:         loc_oPgf.Tabs   = .F.
324: 
325:         *-- Configurar Page1 - pagina de filtros
326:         loc_oPgf.Page1.Caption   = "Filtros"
327:         loc_oPgf.Page1.FontName  = "Tahoma"
328:         loc_oPgf.Page1.FontSize  = 8
329:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
330:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
331:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 362 a 411:
362:         loc_oPg = THIS.pgf_4c_Paginas.Page1
363: 
364:         *-- Label "Posicao :"
365:         loc_oPg.AddObject("lbl_4c_Label7", "Label")
366:         WITH loc_oPg.lbl_4c_Label7
367:             .Top       = 44
368:             .Left      = 112
369:             .Width     = 45
370:             .Height    = 15
371:             .Caption   = "Posi" + CHR(231) + CHR(227) + "o :"
372:             .FontName  = "Tahoma"
373:             .FontSize  = 8
374:             .ForeColor = RGB(90, 90, 90)
375:             .BackStyle = 0
376:             .Visible   = .T.
377:         ENDWITH
378: 
379:         *-- OptionGroup: Atual (1) / Retroativa (2)
380:         loc_oPg.AddObject("obj_4c_OptRfEstoque", "OptionGroup")
381:         WITH loc_oPg.obj_4c_OptRfEstoque
382:             .Top         = 41
383:             .Left        = 162
384:             .Width       = 143
385:             .Height      = 25
386:             .ButtonCount = 2
387:             .BackStyle   = 0
388:             .BorderStyle = 0
389:             .Value       = 1
390:             .Themes      = .F.
391:             .Visible     = .T.
392:             WITH .Buttons(1)
393:                 .Caption   = "Atual"
394:                 .Top       = 0
395:                 .Left      = 0
396:                 .Width     = 60
397:                 .Height    = 25
398:                 .ForeColor = RGB(90, 90, 90)
399:                 .BackColor = RGB(255, 255, 255)
400:                 .Themes    = .F.
401:                 .Visible   = .T.
402:             ENDWITH
403:             WITH .Buttons(2)
404:                 .Caption   = "Retroativa"
405:                 .Top       = 0
406:                 .Left      = 63
407:                 .Width     = 80
408:                 .Height    = 25
409:                 .FontName  = "Tahoma"
410:                 .FontSize  = 8
411:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 417 a 618:
417:         BINDEVENT(loc_oPg.obj_4c_OptRfEstoque, "InteractiveChange", THIS, "OptRfEstoqueChange")
418: 
419:         *-- Label "em" (oculto - aparece quando Retroativa selecionada)
420:         loc_oPg.AddObject("lbl_4c_EstoqueEm", "Label")
421:         WITH loc_oPg.lbl_4c_EstoqueEm
422:             .Top       = 65
423:             .Left      = 225
424:             .Width     = 16
425:             .Height    = 15
426:             .Caption   = "em"
427:             .FontName  = "Tahoma"
428:             .FontSize  = 8
429:             .ForeColor = RGB(90, 90, 90)
430:             .BackStyle = 0
431:             .Visible   = .F.
432:         ENDWITH
433: 
434:         *-- txt_4c_DataSaldo (data da posicao retroativa - oculto inicialmente)
435:         loc_oPg.AddObject("txt_4c_DataSaldo", "TextBox")
436:         WITH loc_oPg.txt_4c_DataSaldo
437:             .Top      = 61
438:             .Left     = 244
439:             .Width    = 79
440:             .Height   = 25
441:             .Value    = {}
442:             .FontName = "Tahoma"
443:             .FontSize = 8
444:             .Visible  = .F.
445:         ENDWITH
446: 
447:         *-- Label "Moeda :"
448:         loc_oPg.AddObject("lbl_4c_Lbl_moeda", "Label")
449:         WITH loc_oPg.lbl_4c_Lbl_moeda
450:             .Top       = 104
451:             .Left      = 116
452:             .Width     = 41
453:             .Height    = 15
454:             .Caption   = "Moeda :"
455:             .FontName  = "Tahoma"
456:             .FontSize  = 8
457:             .ForeColor = RGB(90, 90, 90)
458:             .BackStyle = 0
459:             .Visible   = .T.
460:         ENDWITH
461: 
462:         *-- txt_4c__cd_moeda (codigo da moeda)
463:         loc_oPg.AddObject("txt_4c__cd_moeda", "TextBox")
464:         WITH loc_oPg.txt_4c__cd_moeda
465:             .Top      = 101
466:             .Left     = 165
467:             .Width    = 31
468:             .Height   = 25
469:             .Value    = ""
470:             .FontName = "Tahoma"
471:             .FontSize = 8
472:             .Visible  = .T.
473:         ENDWITH
474:         BINDEVENT(loc_oPg.txt_4c__cd_moeda, "KeyPress", THIS, "TeclaCdMoeda")
475: 
476:         *-- txt_4c__ds_moeda (descricao da moeda)
477:         loc_oPg.AddObject("txt_4c__ds_moeda", "TextBox")
478:         WITH loc_oPg.txt_4c__ds_moeda
479:             .Top      = 101
480:             .Left     = 198
481:             .Width    = 117
482:             .Height   = 25
483:             .Value    = ""
484:             .FontName = "Tahoma"
485:             .FontSize = 8
486:             .Visible  = .T.
487:         ENDWITH
488:         BINDEVENT(loc_oPg.txt_4c__ds_moeda, "KeyPress", THIS, "TeclaDsMoeda")
489: 
490:         *-- Label "Complemento Caracteristica :"
491:         loc_oPg.AddObject("lbl_4c_LblComplementoCarac", "Label")
492:         WITH loc_oPg.lbl_4c_LblComplementoCarac
493:             .Top       = 124
494:             .Left      = 82
495:             .Width     = 75
496:             .Height    = 28
497:             .Caption   = "Complemento" + CHR(13) + "Caracter" + CHR(237) + "stica :"
498:             .FontName  = "Tahoma"
499:             .FontSize  = 8
500:             .ForeColor = RGB(90, 90, 90)
501:             .BackStyle = 0
502:             .WordWrap  = .T.
503:             .Visible   = .T.
504:         ENDWITH
505: 
506:         *-- txt_4c_FichaT (codigo do titulo de caracteristica - SigPrCpP.Codigos)
507:         loc_oPg.AddObject("txt_4c_FichaT", "TextBox")
508:         WITH loc_oPg.txt_4c_FichaT
509:             .Top      = 128
510:             .Left     = 165
511:             .Width    = 150
512:             .Height   = 25
513:             .Value    = ""
514:             .FontName = "Tahoma"
515:             .FontSize = 8
516:             .Visible  = .T.
517:         ENDWITH
518:         BINDEVENT(loc_oPg.txt_4c_FichaT, "KeyPress", THIS, "TeclaFichaT")
519: 
520:         *-- Label "Grande Grupo :"
521:         loc_oPg.AddObject("lbl_4c_LblGrandeGrupo", "Label")
522:         WITH loc_oPg.lbl_4c_LblGrandeGrupo
523:             .Top       = 158
524:             .Left      = 81
525:             .Width     = 76
526:             .Height    = 15
527:             .Caption   = "Grande Grupo :"
528:             .FontName  = "Tahoma"
529:             .FontSize  = 8
530:             .ForeColor = RGB(90, 90, 90)
531:             .BackStyle = 0
532:             .Visible   = .T.
533:         ENDWITH
534: 
535:         *-- txt_4c_GGrus (codigo do grande grupo - SigCdGpr.Codigos)
536:         loc_oPg.AddObject("txt_4c_GGrus", "TextBox")
537:         WITH loc_oPg.txt_4c_GGrus
538:             .Top      = 155
539:             .Left     = 165
540:             .Width    = 35
541:             .Height   = 25
542:             .Value    = ""
543:             .FontName = "Tahoma"
544:             .FontSize = 8
545:             .Visible  = .T.
546:         ENDWITH
547:         BINDEVENT(loc_oPg.txt_4c_GGrus, "KeyPress", THIS, "TeclaGGrus")
548: 
549:         *-- txt_4c_DGRus (descricao do grande grupo - SigCdGpr.Descs)
550:         loc_oPg.AddObject("txt_4c_DGRus", "TextBox")
551:         WITH loc_oPg.txt_4c_DGRus
552:             .Top      = 155
553:             .Left     = 202
554:             .Width    = 146
555:             .Height   = 25
556:             .Value    = ""
557:             .FontName = "Tahoma"
558:             .FontSize = 8
559:             .Visible  = .T.
560:         ENDWITH
561:         BINDEVENT(loc_oPg.txt_4c_DGRus, "KeyPress", THIS, "TeclaDGRus")
562: 
563:         *-- Label "Grupo :"
564:         loc_oPg.AddObject("lbl_4c_Lbl_grupo", "Label")
565:         WITH loc_oPg.lbl_4c_Lbl_grupo
566:             .Top       = 185
567:             .Left      = 119
568:             .Width     = 38
569:             .Height    = 15
570:             .Caption   = "Grupo :"
571:             .FontName  = "Tahoma"
572:             .FontSize  = 8
573:             .ForeColor = RGB(90, 90, 90)
574:             .BackStyle = 0
575:             .Visible   = .T.
576:         ENDWITH
577: 
578:         *-- txt_4c__cd_grupo (codigo do grupo de produto - SigCdGrp.CGrus)
579:         loc_oPg.AddObject("txt_4c__cd_grupo", "TextBox")
580:         WITH loc_oPg.txt_4c__cd_grupo
581:             .Top      = 182
582:             .Left     = 165
583:             .Width    = 35
584:             .Height   = 25
585:             .Value    = ""
586:             .FontName = "Tahoma"
587:             .FontSize = 8
588:             .Visible  = .T.
589:         ENDWITH
590:         BINDEVENT(loc_oPg.txt_4c__cd_grupo, "KeyPress", THIS, "TeclaCdGrupo")
591: 
592:         *-- txt_4c__ds_grupo (descricao do grupo - SigCdGrp.DGrus)
593:         loc_oPg.AddObject("txt_4c__ds_grupo", "TextBox")
594:         WITH loc_oPg.txt_4c__ds_grupo
595:             .Top      = 182
596:             .Left     = 202
597:             .Width    = 146
598:             .Height   = 25
599:             .Value    = ""
600:             .FontName = "Tahoma"
601:             .FontSize = 8
602:             .Visible  = .T.
603:         ENDWITH
604:         BINDEVENT(loc_oPg.txt_4c__ds_grupo, "KeyPress", THIS, "TeclaDsGrupo")
605: 
606:         *-- Label "Estoques" (cabecalho da grade) - corresponde ao Label1 original (Left=414)
607:         loc_oPg.AddObject("lbl_4c_Estoques", "Label")
608:         WITH loc_oPg.lbl_4c_Estoques
609:             .Top       = 39
610:             .Left      = 414
611:             .Width     = 53
612:             .Height    = 15
613:             .Caption   = "Estoques"
614:             .FontName  = "Tahoma"
615:             .FontSize  = 8
616:             .ForeColor = RGB(90, 90, 90)
617:             .BackStyle = 0
618:             .Visible   = .T.

*-- Linhas 632 a 641:
632:     PROTECTED PROCEDURE ConfigurarGridEstoques(par_oPg)
633:         par_oPg.AddObject("grd_4c_Dados", "Grid")
634:         WITH par_oPg.grd_4c_Dados
635:             .Top               = 56
636:             .Left              = 360
637:             .Width             = 182
638:             .Height            = 224
639:             .ColumnCount       = 2
640:             .RecordSource      = "CsEstoque"
641:             .RecordMark        = .F.

*-- Linhas 652 a 710:
652:             WITH .Column1
653:                 .ControlSource    = "CsEstoque.Emps"
654:                 .Width            = 80
655:                 .Header1.Caption  = "Empresa"
656:             ENDWITH
657: 
658:             WITH .Column2
659:                 .ControlSource    = "CsEstoque.Grupos"
660:                 .Width            = 100
661:                 .Header1.Caption  = "Grupo Estoque"
662:             ENDWITH
663:         ENDWITH
664:         BINDEVENT(par_oPg.grd_4c_Dados, "AfterRowColChange", THIS, ;
665:             "GrdEstoquesAfterRowColChange")
666:     ENDPROC
667: 
668:     *--------------------------------------------------------------------------
669:     * ConfigurarContainerAguarde - Container visivel durante processamento
670:     * Equivalente ao Aguarde do legado (top=190, left=261 no form original)
671:     *--------------------------------------------------------------------------
672:     PROTECTED PROCEDURE ConfigurarContainerAguarde(par_oPg)
673:         par_oPg.AddObject("cnt_4c_Aguarde", "Container")
674:         WITH par_oPg.cnt_4c_Aguarde
675:             .Top         = 105
676:             .Left        = 261
677:             .Width       = 350
678:             .Height      = 110
679:             .BackStyle   = 1
680:             .BackColor   = RGB(255, 255, 204)
681:             .BorderWidth = 1
682:             .Visible     = .F.
683: 
684:             .AddObject("lbl_4c_Label1", "Label")
685:             WITH .lbl_4c_Label1
686:                 .Top       = 13
687:                 .Left      = 12
688:                 .Width     = 326
689:                 .Height    = 27
690:                 .Caption   = "Aguarde..."
691:                 .FontName  = "Tahoma"
692:                 .FontSize  = 14
693:                 .FontBold  = .T.
694:                 .ForeColor = RGB(90, 90, 90)
695:                 .BackStyle = 0
696:                 .Visible   = .T.
697:             ENDWITH
698: 
699:             .AddObject("lbl_4c_Label2", "Label")
700:             WITH .lbl_4c_Label2
701:                 .Top       = 47
702:                 .Left      = 9
703:                 .Width     = 332
704:                 .Height    = 27
705:                 .Caption   = "Processando Dados"
706:                 .FontName  = "Tahoma"
707:                 .FontSize  = 12
708:                 .ForeColor = RGB(90, 90, 90)
709:                 .BackStyle = 0
710:                 .Visible   = .T.

*-- Linhas 756 a 764:
756: 
757:         loc_oPg.obj_4c_OptRfEstoque.Value = 1
758:         loc_oPg.txt_4c_DataSaldo.Value    = {}
759:         loc_oPg.lbl_4c_EstoqueEm.Visible  = .F.
760:         loc_oPg.txt_4c_DataSaldo.Visible   = .F.
761:         loc_oPg.txt_4c__cd_moeda.Value    = ""
762:         loc_oPg.txt_4c__ds_moeda.Value    = ""
763:         loc_oPg.txt_4c_FichaT.Value       = ""
764:         loc_oPg.txt_4c_GGrus.Value        = ""

*-- Linhas 867 a 962:
867: 
868:         IF !THIS.ValidarFormulario()
869:             RETURN
870:         ENDIF
871:         THIS.FormParaRelatorio()
872:         loc_oPg.cnt_4c_Aguarde.Visible = .T.
873:         loc_oPg.cnt_4c_Aguarde.Refresh()
874:         IF !THIS.this_oRelatorio.Visualizar()
875:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
876:         ENDIF
877:         loc_oPg.cnt_4c_Aguarde.Visible = .F.
878:     ENDPROC
879: 
880:     *--------------------------------------------------------------------------
881:     * BtnImprimirClick - Gera relatorio e envia para impressora (com dialogo)
882:     *--------------------------------------------------------------------------
883:     PROCEDURE BtnImprimirClick()
884:         LOCAL loc_oPg
885:         loc_oPg = THIS.pgf_4c_Paginas.Page1
886: 
887:         IF !THIS.ValidarFormulario()
888:             RETURN
889:         ENDIF
890:         THIS.FormParaRelatorio()
891:         loc_oPg.cnt_4c_Aguarde.Visible = .T.
892:         loc_oPg.cnt_4c_Aguarde.Refresh()
893:         IF !THIS.this_oRelatorio.Imprimir()
894:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
895:         ENDIF
896:         loc_oPg.cnt_4c_Aguarde.Visible = .F.
897:     ENDPROC
898: 
899:     *--------------------------------------------------------------------------
900:     * BtnExcelClick - Exporta dados do relatorio para arquivo XLS
901:     *--------------------------------------------------------------------------
902:     PROCEDURE BtnExcelClick()
903:         LOCAL loc_oPg, loc_cArquivo, loc_lSucesso, loc_oErro
904:         loc_oPg     = THIS.pgf_4c_Paginas.Page1
905:         loc_lSucesso = .F.
906: 
907:         IF !THIS.ValidarFormulario()
908:             RETURN
909:         ENDIF
910:         THIS.FormParaRelatorio()
911:         loc_oPg.cnt_4c_Aguarde.Visible = .T.
912:         loc_oPg.cnt_4c_Aguarde.Refresh()
913: 
914:         TRY
915:             IF THIS.this_oRelatorio.PrepararDados()
916:                 IF USED("CsRelatorio")
917:                     loc_cArquivo = gc_4c_CaminhoBase + "reports\SigReFxv_" + ;
918:                                    STRTRAN(DTOC(DATE(), 1), "-", "") + ".xls"
919:                     SELECT CsRelatorio
920:                     COPY TO (loc_cArquivo) TYPE XL5
921:                     MsgInfo("Arquivo exportado para:" + CHR(13) + loc_cArquivo, "Excel")
922:                     loc_lSucesso = .T.
923:                 ELSE
924:                     MsgAviso("Nenhum dado para exportar.", "Aviso")
925:                 ENDIF
926:             ELSE
927:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
928:             ENDIF
929:         CATCH TO loc_oErro
930:             MsgErro(loc_oErro.Message, "Erro ao exportar Excel")
931:         ENDTRY
932: 
933:         loc_oPg.cnt_4c_Aguarde.Visible = .F.
934:     ENDPROC
935: 
936:     *--------------------------------------------------------------------------
937:     * BtnEncerrarClick - Fecha o formulario
938:     *--------------------------------------------------------------------------
939:     PROCEDURE BtnEncerrarClick()
940:         THIS.Release()
941:     ENDPROC
942: 
943:     *--------------------------------------------------------------------------
944:     * OptRfEstoqueChange - Trata mudanca na opcao de periodo
945:     * Dispara em InteractiveChange do obj_4c_OptRfEstoque
946:     * Valor 1=Atual (oculta data), Valor 2=Retroativa (exibe data)
947:     *--------------------------------------------------------------------------
948:     PROCEDURE OptRfEstoqueChange()
949:         LOCAL loc_oPg
950:         loc_oPg = THIS.pgf_4c_Paginas.Page1
951: 
952:         IF loc_oPg.obj_4c_OptRfEstoque.Value = 1
953:             loc_oPg.lbl_4c_EstoqueEm.Visible = .F.
954:             loc_oPg.txt_4c_DataSaldo.Visible  = .F.
955:             loc_oPg.txt_4c_DataSaldo.Value    = {}
956:         ELSE
957:             loc_oPg.lbl_4c_EstoqueEm.Visible = .T.
958:             loc_oPg.txt_4c_DataSaldo.Visible  = .T.
959:             IF EMPTY(loc_oPg.txt_4c_DataSaldo.Value)
960:                 loc_oPg.txt_4c_DataSaldo.Value = DATE()
961:             ENDIF
962:         ENDIF


### BO (C:\4c\projeto\app\classes\SIGREFXVBO.prg):
*==============================================================================
* SIGREFXVBO.PRG
* Business Object para Relatorio de Posicao de Estoque por Grupo/Faixa de Valor
* Herda de RelatorioBase
*
* Tabela principal: SigMvEst / SigMvHst (movimentos de estoque)
* Relatorio FRX: SigReFxv.frx
*
* Filtros:
*   - Posicao: Atual (SigMvEst) ou Retroativa (SigMvHst ate data informada)
*   - Moeda: codigo + descricao (SigCdMoe)
*   - Complemento Caracteristica: codigo do titulo da ficha (SigPrCpP)
*   - Grande Grupo: codigo + descricao (SigCdGpr.Codigos/Descs)
*   - Grupo de Produto: codigo + descricao (SigCdGrp.CGrus/DGrus) - opcional
*   - Grid de Estoques: pares Empresa/Grupo alimentados pelo usuario (cursor CsEstoque)
*==============================================================================

DEFINE CLASS SIGREFXVBO AS RelatorioBase

    *-- Filtro: tipo de periodo (1=Atual / 2=Retroativa - espelha OptRfEstoque.Value)
    this_nNrPeriodo     = 1

    *-- Filtro: data da posicao retroativa (usado quando this_nNrPeriodo = 2)
    this_dDataSaldo     = {}

    *-- Filtro: moeda (CMoes / DMoes de SigCdMoe)
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *-- Filtro: complemento caracteristica (Codigos de SigPrCpP)
    this_cFichaT        = ""

    *-- Filtro: grande grupo (Codigos / Descs de SigCdGpr)
    this_cGGrus         = ""
    this_cDGRus         = ""

    *-- Filtro: grupo de produto opcional (CGrus / DGrus de SigCdGrp)
    this_cCdGrupo       = ""
    this_cDsGrupo       = ""

    *-- Nome do cursor com pares Empresa/Grupo alimentados pelo grid do form
    *   O form mantem o cursor CsEstoque; PrepararDados() le a partir dele
    this_cCursorEstoque = "CsEstoque"

    *-- Nome do cursor de saida populado por PrepararDados()
    this_cCursorDados   = "CsRelatorio"

    *-- Caminho do arquivo FRX para REPORT FORM
    this_cArquivoFRX    = ""

    *-- Titulo do relatorio
    this_cTitulo        = ""

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de posicao de estoque
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvEst"
        THIS.this_cCampoChave = ""
        THIS.this_cArquivoFRX = gc_4c_CaminhoBase + "reports\SigReFxv.frx"
        THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + ;
                                 "o de Estoque por Grupo de Produto/Faixa de Valor"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados para o relatorio
    * Replica logica do procedimento "processamento" do form legado SIGREFXV
    * Popula cursores: csCabecalho, CsRelatorio (this_cCursorDados)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nCotMoe
        LOCAL loc_cNmEmpresa, loc_cNmTitulo, loc_cNmPeriodo
        LOCAL loc_cGrupo, loc_cDsGrupo, loc_cGde, loc_cCarac
        LOCAL loc_cResp, loc_nPVen, loc_nCota, loc_cChaveBusca
        LOCAL loc_cAlias
        LOCAL pDat

        loc_lSucesso = .F.

        TRY
            *-- Validar parametros obrigatorios
            IF EMPTY(ALLTRIM(THIS.this_cCdMoeda))
                THIS.this_cMensagemErro = "Moeda " + CHR(233) + " obrigat" + CHR(243) + "ria!"
                MsgAviso(THIS.this_cMensagemErro)
            ELSE
            IF EMPTY(ALLTRIM(THIS.this_cGGrus))
                THIS.this_cMensagemErro = "Grande Grupo " + CHR(233) + " obrigat" + CHR(243) + "rio!"
                MsgAviso(THIS.this_cMensagemErro)
            ELSE
            IF !USED(THIS.this_cCursorEstoque)
                THIS.this_cMensagemErro = "Cursor de estoques n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
            IF !THIS.ValidarGridEstoque()
                *-- ValidarGridEstoque ja exibe mensagem e define this_cMensagemErro
            ELSE
                *-- Inicializar variaveis locais de filtro
                loc_cGrupo   = ALLTRIM(THIS.this_cCdGrupo)
                loc_cDsGrupo = ALLTRIM(THIS.this_cDsGrupo)
                loc_cGde     = ALLTRIM(THIS.this_cGGrus)
                loc_cCarac   = ALLTRIM(THIS.this_cFichaT)

                *-- Obter cotacao da moeda de referencia
                loc_nCotMoe = fBuscarCotacao(THIS.this_cCdMoeda, DATE())
                IF loc_nCotMoe = 0
                    loc_nCotMoe = 1
                ENDIF

                *-- Obter nome da empresa atual
                loc_cNmEmpresa = ALLTRIM(go_4c_Sistema.cEmpresa)

                *-- Montar strings de titulo e periodo
                loc_cNmTitulo  = "Estoque Por Faixa de Pre" + CHR(231) + "o " + ;
                                 IIF(!EMPTY(loc_cGrupo), ;
                                     "Grupo:" + loc_cGrupo + "-" + loc_cDsGrupo, ;
                                     "")
                loc_cNmPeriodo = "Em " + ;
                                 IIF(THIS.this_nNrPeriodo = 1, ;
                                     DTOC(DATE()), DTOC(THIS.this_dDataSaldo)) + ;
                                 "  Moeda:" + THIS.this_cCdMoeda

                *-- Criar cursor csCabecalho para o FRX
                IF USED("csCabecalho")
                    USE IN csCabecalho
                ENDIF
                CREATE CURSOR csCabecalho ;
                    (nm_empresa C(80), nm_titulo C(80), nm_periodo C(80), cb_empresa C(80))
                INSERT INTO csCabecalho (nm_empresa, nm_titulo, nm_periodo, cb_empresa) ;
                       VALUES (loc_cNmEmpresa, loc_cNmTitulo, loc_cNmPeriodo, "")

                *-- Criar cursor CsRelatorio (nome exato referenciado pelo FRX)
                IF USED("CsRelatorio")
                    USE IN CsRelatorio
                ENDIF
                CREATE CURSOR CsRelatorio ;
                    (cTits C(20), cResps C(100), Cgrus C(3), ps N(2), cUnis C(3), ;
                     Descrs C(20), FaixaIs N(12,2), FaixaFs N(12,2), Pvens N(12,2), ;
                     Qtds N(12,3), Pesos N(12,3), TotQtds N(12,2), TotPesos N(12,3), ;
                     cUnips C(3))
                INDEX ON cResps + Cgrus + ;
                         STR(FaixaIs,12,2) + STR(FaixaFs,12,2) + ;
                         STR(Ps,2) + STR(Pvens,12,2) + ;
                         cUnis + cUnips TAG Quebra

                *-- Buscar faixas de preco em SigCdPpc/SigCdPpi
                IF USED("cursor_4c_TmpProP")
                    USE IN cursor_4c_TmpProP
                ENDIF
                loc_cSQL = "SELECT a.codigos, b.descrs, b.faixafs, b.faixais " + ;
                           "FROM SigCdPpc a, SigCdPpi b " + ;
                           "WHERE a.ngrupos = 1 AND a.cidchaves = b.fkchaves"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpProP") < 1
                    THIS.this_cMensagemErro = "Falha ao buscar faixas de pre" + ;
                                             CHR(231) + CHR(227) + "o (TmpProp)"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                ELSE
                    SELECT cursor_4c_TmpProP
                    INDEX ON Codigos + STR(Faixais,12,2) + STR(FaixaFs,12,2) TAG Codigos

                    *-- Preparar datetime para posicao retroativa (?pDat em SQLEXEC)
                    pDat = fDtoSQL(THIS.this_dDataSaldo, "23:59:59")

                    *-- Loop pelos pares Empresa/Grupo do cursor CsEstoque
                    loc_lSucesso = .T.
                    loc_cAlias   = THIS.this_cCursorEstoque
                    SELECT (loc_cAlias)
                    SCAN
                        IF EMPTY(Grupos) AND EMPTY(Emps)
                            LOOP
                        ENDIF
                        SCATTER MEMVAR

                        *-- Montar SQL de movimentos (Atual ou Retroativo)
                        IF THIS.this_nNrPeriodo = 1
                            loc_cSQL = "SELECT a.Cpros, 'E' AS Opers, " + ;
                                       "SUM(a.Sqtds) AS Sqtds, SUM(a.sPesos) AS sPesos, " + ;
                                       "b.cUnis, b.pVens, b.Moevs, b.Cgrus, b.cUniPs " + ;
                                       "FROM SigMvEst a, SigCdPro b, SigCdGrp c " + ;
                                       "WHERE a.Grupos = " + EscaparSQL(m.Grupos) + ;
                                       IIF(EMPTY(m.Emps), "", ;
                                           " AND a.Emps = " + EscaparSQL(m.Emps)) + ;
                                       " AND a.Cpros = b.Cpros" + ;
                                       " AND a.Grupos = c.CGrus" + ;
                                       " AND c.Mercs = " + EscaparSQL(loc_cGde) + ;
                                       " GROUP BY a.Cpros, b.cUnis, b.pVens, " + ;
                                       "b.Moevs, b.Cgrus, b.cUniPs"
                        ELSE
                            loc_cSQL = "SELECT a.Cpros, a.Opers, " + ;
                                       "SUM(a.Qtds) AS Sqtds, SUM(a.Pesos) AS sPesos, " + ;
                                       "b.cUnis, b.pVens, b.Moevs, b.Cgrus, b.cUniPs " + ;
                                       "FROM SigMvHst a, SigCdPro b, SigCdGrp c " + ;
                                       "WHERE a.Grupos = " + EscaparSQL(m.Grupos) + ;
                                       " AND a.Datas <= ?pDat" + ;
                                       IIF(EMPTY(m.Emps), "", ;
                                           " AND a.Emps = " + EscaparSQL(m.Emps)) + ;
                                       " AND a.Cpros = b.Cpros" + ;
                                       " AND a.Grupos = c.CGrus" + ;
                                       " AND c.Mercs = " + EscaparSQL(loc_cGde) + ;
                                       " GROUP BY a.Cpros, a.Opers, b.cUnis, b.pVens, " + ;
                                       "b.Moevs, b.Cgrus, b.cUniPs"
                        ENDIF

                        IF USED("cursor_4c_TmpEst")
                            USE IN cursor_4c_TmpEst
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEst") < 1
                            THIS.this_cMensagemErro = "Falha ao buscar movimentos de estoque (TmpEst)"
                            MsgErro(THIS.this_cMensagemErro, "Erro")
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF

                        SELECT cursor_4c_TmpEst
                        SCAN
                            IF cursor_4c_TmpEst.Sqtds = 0 AND cursor_4c_TmpEst.sPesos = 0
                                LOOP
                            ENDIF
                            SCATTER MEMVAR

                            *-- Buscar caracteristica do produto em SigCdPft
                            IF USED("cursor_4c_TmpProft")
                                USE IN cursor_4c_TmpProft
                            ENDIF
                            loc_cSQL = "SELECT Resps FROM SigCdPft " + ;
                                       "WHERE cTits = " + EscaparSQL(PADR(ALLTRIM(loc_cCarac), 20)) + ;
                                       " AND Cpros = " + EscaparSQL(m.Cpros)
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpProft") < 1
                                THIS.this_cMensagemErro = "Falha ao buscar caracter" + ;
                                                         CHR(237) + "sticas (TmpProft)"
                                MsgErro(THIS.this_cMensagemErro, "Erro")
                                loc_lSucesso = .F.
                                EXIT
                            ENDIF

                            *-- Extrair resposta da caracteristica
                            SELECT cursor_4c_TmpProft
                            GO TOP
                            loc_cResp = ""
                            IF !EOF("cursor_4c_TmpProft")
                                loc_cResp = STRTRAN(cursor_4c_TmpProft.Resps, CHR(13), "")
                                loc_cResp = STRTRAN(loc_cResp, CHR(10), "")
                                loc_cResp = LEFT(loc_cResp, 100)
                            ENDIF
                            loc_cResp = PADR(IIF(EMPTY(loc_cResp), " ", loc_cResp), 100)

                            *-- Converter preco para moeda de referencia
                            loc_nPVen = m.pVens
                            IF m.Moevs <> THIS.this_cCdMoeda
                                loc_nCota = fBuscarCotacao(m.Moevs, DATE())
                                IF loc_nCota = 0
                                    loc_nCota = 1
                                ENDIF
                                loc_nPVen = ROUND(m.pVens * loc_nCota / loc_nCotMoe, 2)
                            ENDIF

                            *-- Localizar faixa de preco no TmpProP
                            SELECT cursor_4c_TmpProP
                            LOCATE FOR cursor_4c_TmpProP.Codigos = m.Cgrus AND ;
                                       BETWEEN(loc_nPVen, ;
                                               cursor_4c_TmpProP.FaixaIs, ;
                                               cursor_4c_TmpProP.FaixaFs)
                            IF !EOF("cursor_4c_TmpProP")
                                loc_cChaveBusca = loc_cResp + m.Cgrus + ;
                                                 STR(cursor_4c_TmpProP.Faixais, 12, 2) + ;
                                                 STR(cursor_4c_TmpProP.FaixaFs, 12, 2) + ;
                                                 STR(1, 2) + ;
                                                 STR(loc_nPVen, 12, 2) + ;
                                                 m.cUnis + m.cUniPs
                                SELECT CsRelatorio
                                IF !SEEK(loc_cChaveBusca)
                                    APPEND BLANK
                                    REPLACE cResps   WITH loc_cResp, ;
                                            Cgrus    WITH m.Cgrus, ;
                                            cUnis    WITH m.cUnis, ;
                                            Descrs   WITH cursor_4c_TmpProP.Descrs, ;
                                            FaixaIs  WITH cursor_4c_TmpProP.FaixaIs, ;
                                            FaixaFs  WITH cursor_4c_TmpProP.FaixaFs, ;
                                            Pvens    WITH loc_nPVen, ;
                                            cUnips   WITH m.cUniPs, ;
                                            ps       WITH 1, ;
                                            cTits    WITH loc_cCarac
                                ENDIF
                                REPLACE Qtds     WITH Qtds + ;
                                                     (m.Sqtds * IIF(m.Opers = "E", 1, -1)), ;
                                        Pesos    WITH Pesos + ;
                                                     (m.sPesos * IIF(m.Opers = "E", 1, -1)), ;
                                        TotQtds  WITH ROUND(Qtds * Pvens, 2), ;
                                        TotPesos WITH ROUND(Pesos * Pvens, 2)
                            ENDIF
                        ENDSCAN

                        IF !loc_lSucesso
                            EXIT
                        ENDIF
                    ENDSCAN

                    *-- Gerar linhas de subtotal e total geral via VFP UNION ALL local
                    IF loc_lSucesso AND RECCOUNT("CsRelatorio") > 0
                        SELECT cTits, cResps, Cgrus, 9 AS Ps, cUnis, ;
                               SPACE(20) AS Descrs, FaixaIs, FaixaFs, ;
                               0 AS Pvens, cUnips, ;
                               SUM(Qtds) AS Qtds, SUM(Pesos) AS Pesos, ;
                               SUM(TotQtds) AS TotQtds ;
                               FROM CsRelatorio ;
                               GROUP BY cTits, cResps, Cgrus, cUnis, FaixaIs, FaixaFs, cUnips ;
                        UNION ALL ;
                        SELECT cTits, REPLICATE(CHR(254), 100) AS cResps, ;
                               REPLICATE(CHR(254), 3) AS Cgrus, ;
                               9 AS Ps, cUnis, ;
                               PADR("Total Geral", 20) AS Descrs, ;
                               00000000.00 AS FaixaIs, 000000000.00 AS FaixaFs, ;
                               0 AS Pvens, cUnips, ;
                               SUM(Qtds) AS Qtds, SUM(Pesos) AS Pesos, ;
                               SUM(TotQtds) AS TotQtds ;
                               FROM CsRelatorio ;
                               GROUP BY cTits, cUnis, cUnips ;
                        INTO CURSOR cursor_4c_DbTotal

                        SELECT CsRelatorio
                        APPEND FROM DBF("cursor_4c_DbTotal")

                        IF USED("cursor_4c_DbTotal")
                            USE IN cursor_4c_DbTotal
                        ENDIF
                    ENDIF

                    IF loc_lSucesso
                        SELECT CsRelatorio
                        GO TOP
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF

                *-- Limpar cursores temporarios
                IF USED("cursor_4c_TmpProP")
                    USE IN cursor_4c_TmpProP
                ENDIF
                IF USED("cursor_4c_TmpEst")
                    USE IN cursor_4c_TmpEst
                ENDIF
                IF USED("cursor_4c_TmpProft")
                    USE IN cursor_4c_TmpProft
                ENDIF
            ENDIF
            ENDIF
            ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGridEstoque - Verifica duplicidades e inconsistencias no CsEstoque
    * Retorna .T. se valido, .F. se ha problemas
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGridEstoque()
        LOCAL loc_lValido, loc_cGrupo, loc_cEmp, loc_cAlias

        loc_lValido  = .T.
        loc_cAlias   = THIS.this_cCursorEstoque

        IF !USED(loc_cAlias)
            RETURN .T.
        ENDIF

        IF USED("cursor_4c_ChecDados")
            USE IN cursor_4c_ChecDados
        ENDIF

        SELECT * FROM (loc_cAlias) INTO CURSOR cursor_4c_ChecDados READWRITE ;
               WHERE !EMPTY(Grupos) OR !EMPTY(Emps)

        IF RECCOUNT("cursor_4c_ChecDados") = 0
            IF USED("cursor_4c_ChecDados")
                USE IN cursor_4c_ChecDados
            ENDIF
            RETURN .T.
        ENDIF

        SELECT cursor_4c_ChecDados
        INDEX ON Grupos + Emps TAG Grupos
        GO TOP

        SCAN
            loc_cGrupo = cursor_4c_ChecDados.Grupos
            loc_cEmp   = cursor_4c_ChecDados.Emps
            SKIP
            IF !EOF("cursor_4c_ChecDados")
                IF cursor_4c_ChecDados.Grupos = loc_cGrupo AND ;
                   cursor_4c_ChecDados.Emps = loc_cEmp
                    THIS.this_cMensagemErro = "Inconsist" + CHR(234) + "ncia na grade de Estoque: " + ;
                                             ALLTRIM(loc_cEmp) + "/" + ALLTRIM(loc_cGrupo) + ;
                                             " est" + CHR(225) + " duplicado"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    loc_lValido = .F.
                    EXIT
                ENDIF
                IF ALLTRIM(loc_cEmp) = "" AND ;
                   cursor_4c_ChecDados.Grupos = loc_cGrupo
                    THIS.this_cMensagemErro = "Inconsist" + CHR(234) + ;
                                             "ncia na grade de Estoque: Grupo:" + ;
                                             ALLTRIM(loc_cGrupo) + ;
                                             " com empresa em branco " + ;
                                             "n" + CHR(227) + "o pode estar relacionado " + ;
                                             "com outra empresa"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    loc_lValido = .F.
                    EXIT
                ENDIF
                SKIP -1
            ENDIF
        ENDSCAN

        IF USED("cursor_4c_ChecDados")
            USE IN cursor_4c_ChecDados
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDireto - Prepara dados e imprime sem dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDireto()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel a relatorios
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

