# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 226: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 250: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlo.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1987 linhas total):

*-- Linhas 91 a 99:
91:                 loc_cCaption = "Processar Ordem de Produ" + CHR(231) + CHR(227) + "o por Tipo"
92:                 ENDIF
93:             ENDIF
94:             THIS.Caption = loc_cCaption
95: 
96:             *-- Imagem de fundo
97:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
98: 
99:             *-- Determinar visibilidade futura do Chec_pedra (criado na Fase 4)

*-- Linhas 139 a 206:
139:     PROTECTED PROCEDURE ConfigurarCabecalho()
140:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
141:         WITH THIS.cnt_4c_Cabecalho
142:             .Top        = 0
143:             .Left       = 0
144:             .Width      = THIS.Width
145:             .Height     = 80
146:             .BackStyle  = 1
147:             .BackColor  = RGB(100,100,100)
148:             .BorderWidth = 0
149:             .Visible    = .T.
150: 
151:             *-- Sombra do titulo (deslocada 1px, cor preta)
152:             .AddObject("lbl_4c_Sombra", "Label")
153:             WITH .lbl_4c_Sombra
154:                 .AutoSize    = .F.
155:                 .FontBold    = .T.
156:                 .FontName    = "Tahoma"
157:                 .FontSize    = 18
158:                 .FontUnderline = .F.
159:                 .WordWrap    = .T.
160:                 .Alignment   = 0
161:                 .BackStyle   = 0
162:                 .Height      = 40
163:                 .Left        = 10
164:                 .Top         = 18
165:                 .Width       = THIS.Width
166:                 .ForeColor   = RGB(0,0,0)
167:                 .Caption     = THIS.Caption
168:                 .Visible     = .T.
169:             ENDWITH
170: 
171:             *-- Titulo principal (branco sobre fundo escuro)
172:             .AddObject("lbl_4c_Titulo", "Label")
173:             WITH .lbl_4c_Titulo
174:                 .AutoSize    = .F.
175:                 .FontBold    = .T.
176:                 .FontName    = "Tahoma"
177:                 .FontSize    = 18
178:                 .FontUnderline = .F.
179:                 .WordWrap    = .T.
180:                 .Alignment   = 0
181:                 .BackStyle   = 0
182:                 .Height      = 46
183:                 .Left        = 10
184:                 .Top         = 17
185:                 .Width       = THIS.Width
186:                 .ForeColor   = RGB(255,255,255)
187:                 .Caption     = THIS.Caption
188:                 .Visible     = .T.
189:             ENDWITH
190:         ENDWITH
191:     ENDPROC
192: 
193:     *--------------------------------------------------------------------------
194:     * ConfigurarShape - shape decorativo por tras dos botoes (Shape3 legado)
195:     * Top=7, Left=486, Height=110, Width=173
196:     *--------------------------------------------------------------------------
197:     PROTECTED PROCEDURE ConfigurarShape()
198:         THIS.AddObject("shp_4c_Shape3", "Shape")
199:         WITH THIS.shp_4c_Shape3
200:             .Top         = 7
201:             .Left        = 486
202:             .Height      = 110
203:             .Width       = 173
204:             .BackStyle   = 0
205:             .BorderStyle = 0
206:             .BorderColor = RGB(90,90,90)

*-- Linhas 215 a 258:
215:     *--------------------------------------------------------------------------
216:     PROTECTED PROCEDURE ConfigurarBotoes()
217:         *-- Botao Processar
218:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
219:         WITH THIS.cmd_4c_Processar
220:             .Top             = 3
221:             .Left            = 528
222:             .Height          = 75
223:             .Width           = 75
224:             .FontBold        = .T.
225:             .FontItalic      = .T.
226:             .FontName        = "Comic Sans MS"
227:             .FontSize        = 8
228:             .WordWrap        = .T.
229:             .Caption         = "Processar"
230:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
231:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
232:             .ForeColor       = RGB(90,90,90)
233:             .BackColor       = RGB(255,255,255)
234:             .Themes          = .T.
235:             .PicturePosition = 13
236:             .SpecialEffect   = 0
237:             .MousePointer    = 15
238:             .Visible         = .T.
239:         ENDWITH
240: 
241:         *-- Botao Cancelar (Encerrar) - Cancel=.T. ativa ESC (form sem TitleBar)
242:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
243:         WITH THIS.cmd_4c_Cancelar
244:             .Top             = 3
245:             .Left            = 603
246:             .Height          = 75
247:             .Width           = 75
248:             .FontBold        = .T.
249:             .FontItalic      = .T.
250:             .FontName        = "Comic Sans MS"
251:             .FontSize        = 8
252:             .WordWrap        = .T.
253:             .Caption         = "Encerrar"
254:             .Cancel          = .T.
255:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
256:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
257:             .ForeColor       = RGB(90,90,90)
258:             .BackColor       = RGB(255,255,255)

*-- Linhas 287 a 372:
287:         *-- Container1 legado: Tipo de O.P. - habilitado so no modo GerPorTp
288:         THIS.AddObject("cnt_4c_TipoOp", "Container")
289:         WITH THIS.cnt_4c_TipoOp
290:             .Top         = 164
291:             .Left        = 139
292:             .Width       = 346
293:             .Height      = 25
294:             .BackStyle   = 0
295:             .BorderWidth = 0
296:             .Enabled     = THIS.this_lGerPorTp
297:             .Visible     = .T.
298:         ENDWITH
299: 
300:         *-- Opera??o legado: codigo/faixa inicial/final de OP
301:         THIS.AddObject("cnt_4c_Operacao", "Container")
302:         WITH THIS.cnt_4c_Operacao
303:             .Top         = 191
304:             .Left        = 139
305:             .Width       = 350
306:             .Height      = 25
307:             .BackStyle   = 0
308:             .BorderWidth = 0
309:             .Visible     = .T.
310:         ENDWITH
311: 
312:         *-- Conta legado: grupo/conta/descricao para filtro de movimentacao
313:         THIS.AddObject("cnt_4c_Conta", "Container")
314:         WITH THIS.cnt_4c_Conta
315:             .Top         = 218
316:             .Left        = 139
317:             .Width       = 553
318:             .Height      = 25
319:             .BackStyle   = 0
320:             .BorderWidth = 0
321:             .Visible     = .T.
322:         ENDWITH
323: 
324:         *-- Responsavel legado: grupo/conta/descricao do vendedor
325:         THIS.AddObject("cnt_4c_Responsavel", "Container")
326:         WITH THIS.cnt_4c_Responsavel
327:             .Top         = 245
328:             .Left        = 139
329:             .Width       = 553
330:             .Height      = 25
331:             .BackStyle   = 0
332:             .BorderWidth = 0
333:             .Visible     = .T.
334:         ENDWITH
335: 
336:         *-- Empresa legado: cd_empresa + ds_empresa + Chec_pedra
337:         THIS.AddObject("cnt_4c_Empresa", "Container")
338:         WITH THIS.cnt_4c_Empresa
339:             .Top         = 272
340:             .Left        = 138
341:             .Width       = 553
342:             .Height      = 25
343:             .BackStyle   = 0
344:             .BorderWidth = 0
345:             .Visible     = .T.
346:         ENDWITH
347: 
348:         *-- Cnt_Previsao legado: data previsao entrega + data geracao
349:         *-- Oculto no modo Reserva (original: ThisForm.Cnt_Previsao.Visible = .f.)
350:         THIS.AddObject("cnt_4c_Previsao", "Container")
351:         WITH THIS.cnt_4c_Previsao
352:             .Top         = 309
353:             .Left        = 7
354:             .Width       = 660
355:             .Height      = 33
356:             .BackStyle   = 0
357:             .BorderWidth = 0
358:             .Visible     = NOT THIS.this_lReserva
359:             .Visible     = .T.
360:         ENDWITH
361: 
362:         *-- Cnt_Op legado: numero da OP manual
363:         *-- Visivel apenas quando GlobAutos=2 e nao e modo Reserva
364:         THIS.AddObject("cnt_4c_Op", "Container")
365:         WITH THIS.cnt_4c_Op
366:             .Top         = 313
367:             .Left        = 478
368:             .Width       = 130
369:             .Height      = 25
370:             .BackStyle   = 0
371:             .BorderWidth = 0
372:             .Visible     = loc_lGlobAutos2

*-- Linhas 459 a 657:
459:     * ConfigurarCamposForm - labels e textboxes de data diretamente no form
460:     *--------------------------------------------------------------------------
461:     PROTECTED PROCEDURE ConfigurarCamposForm()
462:         THIS.AddObject("lbl_4c_PeriodoEmissao", "Label")
463:         WITH THIS.lbl_4c_PeriodoEmissao
464:             .AutoSize  = .F.
465:             .BackStyle = 0
466:             .FontName  = "Tahoma"
467:             .FontSize  = 8
468:             .ForeColor = RGB(90,90,90)
469:             .Caption   = "Per" + CHR(237) + "odo de Emiss" + CHR(227) + "o :"
470:             .Height    = 15
471:             .Left      = 32
472:             .Top       = 115
473:             .Width     = 101
474:         ENDWITH
475: 
476:         THIS.AddObject("txt_4c_Dataei", "TextBox")
477:         WITH THIS.txt_4c_Dataei
478:             .Alignment     = 3
479:             .Value         = {}
480:             .Format        = "K"
481:             .Height        = 23
482:             .Left          = 142
483:             .Top           = 111
484:             .Width         = 80
485:             .SpecialEffect = 1
486:             .FontName      = "Tahoma"
487:             .FontSize      = 8
488:         ENDWITH
489: 
490:         THIS.AddObject("lbl_4c_Ate1", "Label")
491:         WITH THIS.lbl_4c_Ate1
492:             .AutoSize  = .F.
493:             .BackStyle = 0
494:             .FontName  = "Tahoma"
495:             .FontSize  = 8
496:             .ForeColor = RGB(90,90,90)
497:             .Caption   = "at" + CHR(233)
498:             .Height    = 15
499:             .Left      = 227
500:             .Top       = 115
501:             .Width     = 18
502:         ENDWITH
503: 
504:         THIS.AddObject("txt_4c_Dataef", "TextBox")
505:         WITH THIS.txt_4c_Dataef
506:             .Alignment     = 3
507:             .Value         = {}
508:             .Format        = "K"
509:             .Height        = 23
510:             .Left          = 255
511:             .Top           = 111
512:             .Width         = 80
513:             .SpecialEffect = 1
514:             .FontName      = "Tahoma"
515:             .FontSize      = 8
516:         ENDWITH
517: 
518:         THIS.AddObject("lbl_4c_PrevEntrega", "Label")
519:         WITH THIS.lbl_4c_PrevEntrega
520:             .AutoSize  = .F.
521:             .BackStyle = 0
522:             .FontName  = "Tahoma"
523:             .FontSize  = 8
524:             .ForeColor = RGB(90,90,90)
525:             .Caption   = "Previs" + CHR(227) + "o de Entrega :"
526:             .Height    = 15
527:             .Left      = 27
528:             .Top       = 142
529:             .Width     = 106
530:         ENDWITH
531: 
532:         THIS.AddObject("txt_4c_Datapi", "TextBox")
533:         WITH THIS.txt_4c_Datapi
534:             .Alignment     = 3
535:             .Value         = {}
536:             .Format        = "K"
537:             .Height        = 23
538:             .Left          = 142
539:             .Top           = 138
540:             .Width         = 80
541:             .SpecialEffect = 1
542:             .FontName      = "Tahoma"
543:             .FontSize      = 8
544:         ENDWITH
545: 
546:         THIS.AddObject("lbl_4c_Ate2", "Label")
547:         WITH THIS.lbl_4c_Ate2
548:             .AutoSize  = .F.
549:             .BackStyle = 0
550:             .FontName  = "Tahoma"
551:             .FontSize  = 8
552:             .ForeColor = RGB(90,90,90)
553:             .Caption   = "at" + CHR(233)
554:             .Height    = 15
555:             .Left      = 227
556:             .Top       = 142
557:             .Width     = 18
558:         ENDWITH
559: 
560:         THIS.AddObject("txt_4c_Datapf", "TextBox")
561:         WITH THIS.txt_4c_Datapf
562:             .Alignment     = 3
563:             .Value         = {}
564:             .Format        = "K"
565:             .Height        = 23
566:             .Left          = 254
567:             .Top           = 138
568:             .Width         = 80
569:             .SpecialEffect = 1
570:             .FontName      = "Tahoma"
571:             .FontSize      = 8
572:         ENDWITH
573: 
574:         THIS.AddObject("lbl_4c_TipoOp", "Label")
575:         WITH THIS.lbl_4c_TipoOp
576:             .AutoSize  = .F.
577:             .BackStyle = 0
578:             .FontName  = "Tahoma"
579:             .FontSize  = 8
580:             .ForeColor = RGB(90,90,90)
581:             .Caption   = "Tipo de O.P.:"
582:             .Height    = 15
583:             .Left      = 67
584:             .Top       = 169
585:             .Width     = 66
586:         ENDWITH
587: 
588:         THIS.AddObject("lbl_4c_Movimentacao", "Label")
589:         WITH THIS.lbl_4c_Movimentacao
590:             .AutoSize  = .F.
591:             .BackStyle = 0
592:             .FontName  = "Tahoma"
593:             .FontSize  = 8
594:             .ForeColor = RGB(90,90,90)
595:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
596:             .Height    = 15
597:             .Left      = 55
598:             .Top       = 196
599:             .Width     = 78
600:         ENDWITH
601: 
602:         THIS.AddObject("lbl_4c_LblConta", "Label")
603:         WITH THIS.lbl_4c_LblConta
604:             .AutoSize  = .F.
605:             .BackStyle = 0
606:             .FontName  = "Tahoma"
607:             .FontSize  = 8
608:             .ForeColor = RGB(90,90,90)
609:             .Caption   = "Conta :"
610:             .Height    = 15
611:             .Left      = 139
612:             .Top       = 223
613:             .Width     = 38
614:         ENDWITH
615: 
616:         THIS.AddObject("lbl_4c_Vendedor", "Label")
617:         WITH THIS.lbl_4c_Vendedor
618:             .AutoSize  = .F.
619:             .BackStyle = 0
620:             .FontName  = "Tahoma"
621:             .FontSize  = 8
622:             .ForeColor = RGB(90,90,90)
623:             .Caption   = "Vendedor :"
624:             .Height    = 15
625:             .Left      = 78
626:             .Top       = 250
627:             .Width     = 55
628:         ENDWITH
629: 
630:         THIS.AddObject("lbl_4c_LblEmpresa", "Label")
631:         WITH THIS.lbl_4c_LblEmpresa
632:             .AutoSize  = .F.
633:             .BackStyle = 0
634:             .FontName  = "Tahoma"
635:             .FontSize  = 8
636:             .ForeColor = RGB(90,90,90)
637:             .Caption   = "Empresa :"
638:             .Height    = 15
639:             .Left      = 83
640:             .Top       = 277
641:             .Width     = 50
642:         ENDWITH
643:     ENDPROC
644: 
645:     *--------------------------------------------------------------------------
646:     * ConfigurarContainerTipoOp - Get_TpGOp (Container1 legado)
647:     *--------------------------------------------------------------------------
648:     PROTECTED PROCEDURE ConfigurarContainerTipoOp()
649:         THIS.cnt_4c_TipoOp.AddObject("txt_4c_TpGOp", "TextBox")
650:         WITH THIS.cnt_4c_TipoOp.txt_4c_TpGOp
651:             .Left          = 3
652:             .Top           = 1
653:             .Width         = 80
654:             .Height        = 23
655:             .MaxLength     = 10
656:             .FontName      = "Courier New"
657:             .FontSize      = 9

*-- Linhas 666 a 737:
666:     PROTECTED PROCEDURE ConfigurarContainerOperacao()
667:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacao", "TextBox")
668:         WITH THIS.cnt_4c_Operacao.txt_4c_Operacao
669:             .Left          = 3
670:             .Top           = 1
671:             .Width         = 151
672:             .Height        = 23
673:             .MaxLength     = 20
674:             .FontName      = "Courier New"
675:             .FontSize      = 9
676:             .Margin        = 2
677:             .SpecialEffect = 1
678:         ENDWITH
679: 
680:         THIS.cnt_4c_Operacao.AddObject("lbl_4c_De", "Label")
681:         WITH THIS.cnt_4c_Operacao.lbl_4c_De
682:             .AutoSize  = .F.
683:             .BackStyle = 0
684:             .FontName  = "Tahoma"
685:             .FontSize  = 8
686:             .ForeColor = RGB(90,90,90)
687:             .Caption   = "de"
688:             .Height    = 15
689:             .Left      = 180
690:             .Top       = 5
691:             .Width     = 14
692:         ENDWITH
693: 
694:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacaoi", "TextBox")
695:         WITH THIS.cnt_4c_Operacao.txt_4c_Operacaoi
696:             .Alignment     = 3
697:             .Value         = 0
698:             .Format        = "K"
699:             .Height        = 23
700:             .InputMask     = "999999"
701:             .Left          = 201
702:             .Top           = 1
703:             .Width         = 55
704:             .MaxLength     = 6
705:             .SpecialEffect = 1
706:             .FontName      = "Courier New"
707:             .FontSize      = 9
708:         ENDWITH
709: 
710:         THIS.cnt_4c_Operacao.AddObject("lbl_4c_AteOp", "Label")
711:         WITH THIS.cnt_4c_Operacao.lbl_4c_AteOp
712:             .AutoSize  = .F.
713:             .BackStyle = 0
714:             .FontName  = "Tahoma"
715:             .FontSize  = 8
716:             .ForeColor = RGB(90,90,90)
717:             .Caption   = "at" + CHR(233)
718:             .Height    = 15
719:             .Left      = 262
720:             .Top       = 4
721:             .Width     = 18
722:         ENDWITH
723: 
724:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacaof", "TextBox")
725:         WITH THIS.cnt_4c_Operacao.txt_4c_Operacaof
726:             .Alignment     = 3
727:             .Value         = 0
728:             .Format        = "K"
729:             .Height        = 23
730:             .InputMask     = "999999"
731:             .Left          = 286
732:             .Top           = 1
733:             .Width         = 55
734:             .MaxLength     = 6
735:             .SpecialEffect = 1
736:             .FontName      = "Courier New"
737:             .FontSize      = 9

*-- Linhas 744 a 775:
744:     PROTECTED PROCEDURE ConfigurarContainerConta()
745:         THIS.cnt_4c_Conta.AddObject("txt_4c_Grupo", "TextBox")
746:         WITH THIS.cnt_4c_Conta.txt_4c_Grupo
747:             .Left          = 3
748:             .Top           = 1
749:             .Width         = 80
750:             .Height        = 23
751:             .SpecialEffect = 1
752:             .FontName      = "Tahoma"
753:             .FontSize      = 8
754:         ENDWITH
755: 
756:         THIS.cnt_4c_Conta.AddObject("txt_4c_Conta", "TextBox")
757:         WITH THIS.cnt_4c_Conta.txt_4c_Conta
758:             .Left          = 86
759:             .Top           = 1
760:             .Width         = 80
761:             .Height        = 23
762:             .SpecialEffect = 1
763:             .FontName      = "Tahoma"
764:             .FontSize      = 8
765:         ENDWITH
766: 
767:         THIS.cnt_4c_Conta.AddObject("txt_4c_Dconta", "TextBox")
768:         WITH THIS.cnt_4c_Conta.txt_4c_Dconta
769:             .Left          = 170
770:             .Top           = 1
771:             .Width         = 360
772:             .Height        = 23
773:             .SpecialEffect = 1
774:             .FontName      = "Tahoma"
775:             .FontSize      = 8

*-- Linhas 782 a 813:
782:     PROTECTED PROCEDURE ConfigurarContainerResponsavel()
783:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_GrupoResp", "TextBox")
784:         WITH THIS.cnt_4c_Responsavel.txt_4c_GrupoResp
785:             .Left          = 3
786:             .Top           = 1
787:             .Width         = 80
788:             .Height        = 23
789:             .SpecialEffect = 1
790:             .FontName      = "Tahoma"
791:             .FontSize      = 8
792:         ENDWITH
793: 
794:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_ContaResp", "TextBox")
795:         WITH THIS.cnt_4c_Responsavel.txt_4c_ContaResp
796:             .Left          = 86
797:             .Top           = 1
798:             .Width         = 80
799:             .Height        = 23
800:             .SpecialEffect = 1
801:             .FontName      = "Tahoma"
802:             .FontSize      = 8
803:         ENDWITH
804: 
805:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_DcontaResp", "TextBox")
806:         WITH THIS.cnt_4c_Responsavel.txt_4c_DcontaResp
807:             .Left          = 170
808:             .Top           = 1
809:             .Width         = 360
810:             .Height        = 23
811:             .SpecialEffect = 1
812:             .FontName      = "Tahoma"
813:             .FontSize      = 8

*-- Linhas 820 a 829:
820:     PROTECTED PROCEDURE ConfigurarContainerEmpresa()
821:         THIS.cnt_4c_Empresa.AddObject("txt_4c_CdEmpresa", "TextBox")
822:         WITH THIS.cnt_4c_Empresa.txt_4c_CdEmpresa
823:             .Left          = 4
824:             .Top           = 1
825:             .Width         = 31
826:             .Height        = 23
827:             .InputMask     = "XXX"
828:             .MaxLength     = 3
829:             .Format        = "k"

*-- Linhas 837 a 958:
837: 
838:         THIS.cnt_4c_Empresa.AddObject("txt_4c_DsEmpresa", "TextBox")
839:         WITH THIS.cnt_4c_Empresa.txt_4c_DsEmpresa
840:             .Left          = 38
841:             .Top           = 1
842:             .Width         = 282
843:             .Height        = 23
844:             .MaxLength     = 40
845:             .Format        = "K"
846:             .FontName      = "Courier New"
847:             .FontSize      = 9
848:             .SpecialEffect = 1
849:         ENDWITH
850: 
851:         THIS.cnt_4c_Empresa.AddObject("chk_4c_NaoEmpPedra", "CheckBox")
852:         WITH THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra
853:             .Left      = 330
854:             .Top       = 5
855:             .Height    = 15
856:             .Width     = 124
857:             .FontName  = "Tahoma"
858:             .FontSize  = 8
859:             .BackStyle = 0
860:             .Caption   = "N" + CHR(227) + "o Empenhar Pedras"
861:             .Value     = 0
862:             .ForeColor = RGB(90,90,90)
863:             .Visible   = .F.
864:         ENDWITH
865:     ENDPROC
866: 
867:     *--------------------------------------------------------------------------
868:     * ConfigurarContainerPrevisao - data previsao entrega + data geracao
869:     *--------------------------------------------------------------------------
870:     PROTECTED PROCEDURE ConfigurarContainerPrevisao()
871:         THIS.cnt_4c_Previsao.AddObject("lbl_4c_LblPrevisao", "Label")
872:         WITH THIS.cnt_4c_Previsao.lbl_4c_LblPrevisao
873:             .AutoSize  = .F.
874:             .BackStyle = 0
875:             .FontName  = "Tahoma"
876:             .FontSize  = 8
877:             .ForeColor = RGB(90,90,90)
878:             .Caption   = "Previs" + CHR(227) + "o de Entrega :"
879:             .Height    = 15
880:             .Left      = 7
881:             .Top       = 9
882:             .Width     = 106
883:         ENDWITH
884: 
885:         THIS.cnt_4c_Previsao.AddObject("txt_4c_Previsao", "TextBox")
886:         WITH THIS.cnt_4c_Previsao.txt_4c_Previsao
887:             .Alignment     = 3
888:             .Value         = {}
889:             .Format        = "K"
890:             .Height        = 23
891:             .Left          = 134
892:             .Top           = 5
893:             .Width         = 80
894:             .SpecialEffect = 1
895:             .FontName      = "Tahoma"
896:             .FontSize      = 8
897:         ENDWITH
898: 
899:         THIS.cnt_4c_Previsao.AddObject("lbl_4c_LblGeracao", "Label")
900:         WITH THIS.cnt_4c_Previsao.lbl_4c_LblGeracao
901:             .AutoSize  = .F.
902:             .BackStyle = 0
903:             .FontName  = "Tahoma"
904:             .FontSize  = 8
905:             .ForeColor = RGB(90,90,90)
906:             .Caption   = "Data de Gera" + CHR(231) + CHR(227) + "o :"
907:             .Height    = 15
908:             .Left      = 244
909:             .Top       = 9
910:             .Width     = 90
911:         ENDWITH
912: 
913:         THIS.cnt_4c_Previsao.AddObject("txt_4c_Geracao", "TextBox")
914:         WITH THIS.cnt_4c_Previsao.txt_4c_Geracao
915:             .Alignment     = 3
916:             .Value         = {}
917:             .Format        = "K"
918:             .Height        = 23
919:             .Left          = 353
920:             .Top           = 5
921:             .Width         = 80
922:             .SpecialEffect = 1
923:             .FontName      = "Tahoma"
924:             .FontSize      = 8
925:         ENDWITH
926:     ENDPROC
927: 
928:     *--------------------------------------------------------------------------
929:     * ConfigurarContainerOp - numero da OP manual (Cnt_Op legado)
930:     *--------------------------------------------------------------------------
931:     PROTECTED PROCEDURE ConfigurarContainerOp()
932:         THIS.cnt_4c_Op.AddObject("lbl_4c_LblNop", "Label")
933:         WITH THIS.cnt_4c_Op.lbl_4c_LblNop
934:             .AutoSize  = .F.
935:             .BackStyle = 0
936:             .FontName  = "Tahoma"
937:             .FontSize  = 8
938:             .ForeColor = RGB(90,90,90)
939:             .Caption   = "N" + CHR(186) + " da O.P.:"
940:             .Height    = 15
941:             .Left      = 0
942:             .Top       = 5
943:             .Width     = 58
944:         ENDWITH
945: 
946:         THIS.cnt_4c_Op.AddObject("txt_4c_Nop", "TextBox")
947:         WITH THIS.cnt_4c_Op.txt_4c_Nop
948:             .Alignment     = 3
949:             .Value         = 0
950:             .Height        = 23
951:             .InputMask     = "999999"
952:             .Left          = 71
953:             .Top           = 1
954:             .Width         = 59
955:             .MaxLength     = 6
956:             .SpecialEffect = 1
957:             .FontName      = "Tahoma"
958:             .FontSize      = 8

*-- Linhas 980 a 988:
980:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.Value = DATE()
981:             ENDIF
982: 
983:             *-- Checkbox pedras: visibilidade calculada em InicializarForm
984:             THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Visible = THIS.this_lMostrarChkPedra
985: 
986:             *-- Tipo de OP: pre-selecionar se GerPorTp e apenas 1 tipo disponivel
987:             IF THIS.this_lGerPorTp AND NOT EMPTY(THIS.this_oBusinessObject.this_cTpGOp)
988:                 THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = THIS.this_oBusinessObject.this_cTpGOp

*-- Linhas 996 a 1005:
996:     * ConfigurarEventos - registra handlers via BINDEVENT (metodos PUBLIC)
997:     *--------------------------------------------------------------------------
998:     PROTECTED PROCEDURE ConfigurarEventos()
999:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
1000:         BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")
1001:         BINDEVENT(THIS.cnt_4c_TipoOp.txt_4c_TpGOp,          "KeyPress", THIS, "TxtTpGOpKeyPress")
1002:         BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacao,      "KeyPress", THIS, "TxtOperacaoKeyPress")
1003:         BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacaoi,     "KeyPress", THIS, "TxtOperacaoiKeyPress")
1004:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Grupo,            "KeyPress", THIS, "TxtGrupoContaKeyPress")
1005:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Conta,            "KeyPress", THIS, "TxtContaKeyPress")

*-- Linhas 1543 a 1551:
1543:     * Containers cobertos:
1544:     *   1. Cabecalho cinza (cnt_4c_Cabecalho)
1545:     *   2. Shape decorativo (shp_4c_Shape3)
1546:     *   3. Botoes principais (cmd_4c_Processar / cmd_4c_Cancelar)
1547:     *   4. Labels e campos de data avulsos no form
1548:     *   5. cnt_4c_TipoOp  - Tipo de O.P. (txt_4c_TpGOp)
1549:     *   6. cnt_4c_Operacao - Operacao + faixa i/f
1550:     *   7. cnt_4c_Conta    - Movimentacao: grupo/conta/dconta
1551:     *   8. cnt_4c_Responsavel - Vendedor: grupo/conta/dconta

*-- Linhas 1572 a 1594:
1572:         ENDIF
1573: 
1574:         *-- 3. Botoes principais (Processar / Encerrar)
1575:         IF NOT PEMSTATUS(THIS, "cmd_4c_Processar", 5)
1576:             THIS.ConfigurarBotoes()
1577:         ENDIF
1578: 
1579:         *-- 4. Campos avulsos (labels + datas de emissao/previsao)
1580:         IF NOT PEMSTATUS(THIS, "lbl_4c_PeriodoEmissao", 5)
1581:             THIS.ConfigurarCamposForm()
1582:         ENDIF
1583: 
1584:         *-- 5. Container Tipo de O.P.
1585:         IF NOT PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
1586:             THIS.AddObject("cnt_4c_TipoOp", "Container")
1587:             WITH THIS.cnt_4c_TipoOp
1588:                 .Top         = 164
1589:                 .Left        = 139
1590:                 .Width       = 346
1591:                 .Height      = 25
1592:                 .BackStyle   = 0
1593:                 .BorderWidth = 0
1594:                 .Enabled     = THIS.this_lGerPorTp

*-- Linhas 1601 a 1610:
1601:         IF NOT PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
1602:             THIS.AddObject("cnt_4c_Operacao", "Container")
1603:             WITH THIS.cnt_4c_Operacao
1604:                 .Top         = 191
1605:                 .Left        = 139
1606:                 .Width       = 350
1607:                 .Height      = 25
1608:                 .BackStyle   = 0
1609:                 .BorderWidth = 0
1610:                 .Visible     = .T.

*-- Linhas 1616 a 1625:
1616:         IF NOT PEMSTATUS(THIS, "cnt_4c_Conta", 5)
1617:             THIS.AddObject("cnt_4c_Conta", "Container")
1618:             WITH THIS.cnt_4c_Conta
1619:                 .Top         = 218
1620:                 .Left        = 139
1621:                 .Width       = 553
1622:                 .Height      = 25
1623:                 .BackStyle   = 0
1624:                 .BorderWidth = 0
1625:                 .Visible     = .T.

*-- Linhas 1631 a 1640:
1631:         IF NOT PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
1632:             THIS.AddObject("cnt_4c_Responsavel", "Container")
1633:             WITH THIS.cnt_4c_Responsavel
1634:                 .Top         = 245
1635:                 .Left        = 139
1636:                 .Width       = 553
1637:                 .Height      = 25
1638:                 .BackStyle   = 0
1639:                 .BorderWidth = 0
1640:                 .Visible     = .T.

*-- Linhas 1646 a 1655:
1646:         IF NOT PEMSTATUS(THIS, "cnt_4c_Empresa", 5)
1647:             THIS.AddObject("cnt_4c_Empresa", "Container")
1648:             WITH THIS.cnt_4c_Empresa
1649:                 .Top         = 272
1650:                 .Left        = 138
1651:                 .Width       = 553
1652:                 .Height      = 25
1653:                 .BackStyle   = 0
1654:                 .BorderWidth = 0
1655:                 .Visible     = .T.

*-- Linhas 1661 a 1670:
1661:         IF NOT PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
1662:             THIS.AddObject("cnt_4c_Previsao", "Container")
1663:             WITH THIS.cnt_4c_Previsao
1664:                 .Top         = 309
1665:                 .Left        = 7
1666:                 .Width       = 660
1667:                 .Height      = 33
1668:                 .BackStyle   = 0
1669:                 .BorderWidth = 0
1670:                 .Visible     = NOT THIS.this_lReserva

*-- Linhas 1677 a 1686:
1677:         IF NOT PEMSTATUS(THIS, "cnt_4c_Op", 5)
1678:             THIS.AddObject("cnt_4c_Op", "Container")
1679:             WITH THIS.cnt_4c_Op
1680:                 .Top         = 313
1681:                 .Left        = 478
1682:                 .Width       = 130
1683:                 .Height      = 25
1684:                 .BackStyle   = 0
1685:                 .BorderWidth = 0
1686:                 .Visible     = loc_lGlobAutos2

*-- Linhas 1746 a 1755:
1746:         loc_lEditar = (loc_cModo = "ENTRADA")
1747: 
1748:         *-- Botao Processar segue o modo (bloqueia durante processamento)
1749:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
1750:             THIS.cmd_4c_Processar.Enabled = loc_lEditar
1751:         ENDIF
1752: 
1753:         *-- Containers de filtro alternam Enabled conforme modo
1754:         IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
1755:             THIS.cnt_4c_TipoOp.Enabled = (loc_lEditar AND THIS.this_lGerPorTp)

*-- Linhas 1823 a 1850:
1823:         LOCAL loc_oErro
1824:         TRY
1825:             WITH THIS.this_oBusinessObject
1826:                 THIS.txt_4c_Dataei.Value = .this_dDataei
1827:                 THIS.txt_4c_Dataef.Value = .this_dDataef
1828:                 THIS.txt_4c_Datapi.Value = .this_dDatapi
1829:                 THIS.txt_4c_Datapf.Value = .this_dDatapf
1830:                 THIS.cnt_4c_Operacao.txt_4c_Operacao.Value      = .this_cOperacao
1831:                 THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value     = .this_nOperacaoi
1832:                 THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value     = .this_nOperacaof
1833:                 THIS.cnt_4c_Conta.txt_4c_Grupo.Value            = .this_cGrupoConta
1834:                 THIS.cnt_4c_Conta.txt_4c_Conta.Value            = .this_cConta
1835:                 THIS.cnt_4c_Conta.txt_4c_Dconta.Value           = .this_cDconta
1836:                 THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value  = .this_cGrupoResp
1837:                 THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = .this_cContaResp
1838:                 THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = .this_cDcontaResp
1839:                 THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value      = .this_cCdEmpresa
1840:                 THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value      = .this_cDsEmpresa
1841:                 THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value    = .this_nNaoEmpPedra
1842:                 THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value           = .this_cTpGOp
1843:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.Value      = .this_dPrevisao
1844:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.Value       = .this_dGeracao
1845:                 THIS.cnt_4c_Op.txt_4c_Nop.Value                 = .this_nNop
1846:             ENDWITH
1847:         CATCH TO loc_oErro
1848:             MsgErro("Erro ao carregar campos: " + loc_oErro.Message, "Erro")
1849:         ENDTRY
1850:     ENDPROC


### BO (C:\4c\projeto\app\classes\SigPrGloBO.prg):
*==============================================================================
* SigPrGloBO.prg - Business Object para Processamento de O.P.
* Data: 2026-07-03
* Tabela: SigMvCab (principal - registros processados)
* Legado: SigPrGlo.SCX (form operacional)
*==============================================================================

DEFINE CLASS SigPrGloBO AS BusinessBase

    *--------------------------------------------------------------------------
    *-- Modo de operacao (passados via parametros na abertura do form)
    *--------------------------------------------------------------------------
    this_lReserva     = .F.    && Modo reserva automatica (_Reserva)
    this_lAutomatico  = .F.    && Modo automatico (_Autom)
    this_lPorDestino  = .F.    && Por destino (_PorDestino)
    this_lGerPorTp    = .F.    && Gerar por tipo de OP (pTipo)
    this_lAlterEmp    = .T.    && Permite alterar empresa (AlterEmp)

    *--------------------------------------------------------------------------
    *-- Filtros de periodo de emissao
    *--------------------------------------------------------------------------
    this_dDataei      = {}     && Data emissao inicial (GetDataei)
    this_dDataef      = {}     && Data emissao final (GetDataef)

    *--------------------------------------------------------------------------
    *-- Filtros de periodo de previsao de entrega
    *--------------------------------------------------------------------------
    this_dDatapi      = {}     && Data previsao entrega inicial (GetDatapi)
    this_dDatapf      = {}     && Data previsao entrega final (GetDatapf)

    *--------------------------------------------------------------------------
    *-- Filtro de operacao
    *--------------------------------------------------------------------------
    this_cOperacao    = ""     && Codigo da operacao (Get_Operacao)
    this_nOperacaoi   = 0      && Numero OP inicial - faixa (Get_Operacaoi)
    this_nOperacaof   = 0      && Numero OP final - faixa (Get_Operacaof)

    *--------------------------------------------------------------------------
    *-- Conta / Movimentacao (cliente)
    *--------------------------------------------------------------------------
    this_cGrupoConta  = ""     && Grupo da conta (Conta.Get_grupo)
    this_cConta       = ""     && Conta (Conta.Get_conta)
    this_cDconta      = ""     && Descricao da conta (Conta.Get_dconta)

    *--------------------------------------------------------------------------
    *-- Responsavel / Vendedor
    *--------------------------------------------------------------------------
    this_cGrupoResp   = ""     && Grupo do responsavel (Responsavel.Get_grupo)
    this_cContaResp   = ""     && Conta do responsavel (Responsavel.Get_conta)
    this_cDcontaResp  = ""     && Descricao do responsavel (Responsavel.Get_dconta)

    *--------------------------------------------------------------------------
    *-- Empresa
    *--------------------------------------------------------------------------
    this_cCdEmpresa   = ""     && Codigo da empresa (Empresa.get_cd_empresa)
    this_cDsEmpresa   = ""     && Razao social da empresa (Empresa.get_ds_empresa)
    this_nNaoEmpPedra = 0      && Nao empenhar pedras: 0=nao, 1=sim (Empresa.Chec_pedra)

    *--------------------------------------------------------------------------
    *-- Tipo de geracao de OP
    *--------------------------------------------------------------------------
    this_cTpGOp       = ""     && Codigo do tipo de geracao (Container1.Get_TpGOp)

    *--------------------------------------------------------------------------
    *-- Previsao de entrega e data de geracao
    *--------------------------------------------------------------------------
    this_dPrevisao    = {}     && Data de previsao de entrega (Cnt_Previsao.GetPrevisao)
    this_dGeracao     = {}     && Data de geracao (Cnt_Previsao.GetGeracao)

    *--------------------------------------------------------------------------
    *-- Numero da OP manual (GlobAutos = 2)
    *--------------------------------------------------------------------------
    this_nNop         = 0      && Numero da OP manual (Cnt_Op.GetNop)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "Numes"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - carrega propriedades a partir de cursor com registros de OP
    * Usado quando o form recarrega um contexto ja gerado a partir de SigOpPic
    * ou de cursor temporario TmpCabec/TmpItens. Popula filtros base.
    * Retorna .T. se pelo menos os campos essenciais foram carregados.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR NOT USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)
        IF EOF()
            RETURN .F.
        ENDIF

        *-- Empresa (todos os cursores relevantes tem coluna Emps)
        IF TYPE(par_cAliasCursor + ".Emps") = "C"
            THIS.this_cCdEmpresa = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Emps")), "")
            loc_lSucesso = .T.
        ENDIF

        *-- Operacao (Dopes) e movimento (Numes) - opcionais conforme cursor origem
        IF TYPE(par_cAliasCursor + ".Dopes") = "C"
            THIS.this_cOperacao  = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Dopes")), "")
            THIS.this_nOperacaoi = 0
            THIS.this_nOperacaof = 0
        ENDIF
        IF TYPE(par_cAliasCursor + ".Datas") = "D"
            THIS.this_dGeracao = NVL(EVALUATE(par_cAliasCursor + ".Datas"), DATE())
        ENDIF
        IF TYPE(par_cAliasCursor + ".Entregas") = "D"
            THIS.this_dPrevisao = NVL(EVALUATE(par_cAliasCursor + ".Entregas"), DATE())
        ENDIF
        IF TYPE(par_cAliasCursor + ".Grupo") = "C"
            THIS.this_cGrupoConta = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Grupo")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Conta") = "C"
            THIS.this_cConta = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Conta")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".DConta") = "C"
            THIS.this_cDconta = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".DConta")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Grupov") = "C"
            THIS.this_cGrupoResp = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Grupov")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Contav") = "C"
            THIS.this_cContaResp = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Contav")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Numes") = "N"
            THIS.this_nNop = NVL(EVALUATE(par_cAliasCursor + ".Numes"), 0)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarDataHoraSQL - retorna 'YYYY-MM-DD HH:MM:SS' com aspas simples
    * par_cHora: ex "23:59:59" ou "00:00:00"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarDataHoraSQL(par_dData, par_cHora)
        LOCAL loc_cBase
        IF EMPTY(par_dData) OR VARTYPE(par_dData) != "D"
            RETURN "NULL"
        ENDIF
        *-- FormatarDataSQL retorna 'YYYY-MM-DD' (12 chars, com aspas)
        *-- Remove aspas de fechamento e adiciona hora
        loc_cBase = FormatarDataSQL(par_dData)
        RETURN SUBSTR(loc_cBase, 1, LEN(loc_cBase)-1) + " " + par_cHora + "'"
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - carrega dados de configuracao para o processamento
    * Cria cursores: crSigCdPam, crSigCdPac, TmpOper, CrTmpTpGop
    * par_lGerPorTp: .T. se modo de geracao por tipo de OP
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros(par_lGerPorTp)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCampos, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Parametros de OP (SigCdPam)
            loc_cCampos = "DopEmphs, DopReqcs, DopPedcs, DopComps, TransfRes, GrPadClis, " + ;
                          "DoppPads, DopTrfCps, GrPadVens, PrevProds, GrupoEsts, ContaEsts, " + ;
                          "GruReservs, ConReservs, AgrupEmph, DoppServs, mascnums, GruEstps, " + ;
                          "ConEstps, transfencs, Ouros, GruConfs, ConConfs, GlobAutos, " + ;
                          "DopEntAus, TpOpEntAus, AutComps"
            loc_cSQL = "SELECT " + loc_cCampos + " FROM SigCdPam"
            IF USED("crSigCdPam")
                USE IN crSigCdPam
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPam") < 1
                MsgErro("Falha ao carregar par" + CHR(226) + "metros de OP (SigCdPam).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Parametros de componentes (SigCdPac)
            loc_cSQL = "SELECT * FROM SigCdPac"
            IF USED("crSigCdPac")
                USE IN crSigCdPac
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPac") < 1
                MsgErro("Falha ao carregar par" + CHR(226) + "metros de componentes (SigCdPac).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Operacoes disponiveis (SigCdOpe + SigOpCdd + SigOpCdc -> TmpOper)
            loc_cSQL = "SELECT b.OpeGops, b.CodTgOps, a.Dopes, a.NDopes, a.Globalizas, " + ;
                       "a.Reservas, a.Opers, 0 AS Acesso, b.chkObs, c.carcompos " + ;
                       "FROM SigCdOpe a " + ;
                       "LEFT JOIN SigOpCdd b ON b.dopes = a.dopes " + ;
                       "LEFT JOIN SigOpCdc c ON a.dopes = c.dopes " + ;
                       "WHERE a.Globalizas IN (1, 2)"
            IF USED("TmpOper2")
                USE IN TmpOper2
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpOper2") < 1
                MsgErro("Falha ao carregar opera" + CHR(231) + CHR(245) + "es (SigCdOpe).", "Erro")
                loc_lSucesso = .F.
            ENDIF
            *-- Normalizar NULLs nos campos opcionais
            SELECT TmpOper2
            SCAN
                REPLACE CodTgOps WITH NVL(CodTgOps, " "), ;
                        OpeGops  WITH NVL(OpeGops, " ") IN TmpOper2
            ENDSCAN
            *-- Mover para TmpOper com indice
            IF USED("TmpOper")
                USE IN TmpOper
            ENDIF
            SELECT * FROM TmpOper2 INTO CURSOR TmpOper READWRITE
            USE IN TmpOper2
            SELECT TmpOper
            INDEX ON Dopes TAG Dopes
            GO TOP
            IF EOF()
                MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Configurada Para Processar " + ;
                         "Ordem de Produ" + CHR(231) + CHR(227) + "o!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Tipos de OP com filtro de acesso (SigInTgo -> CrTmpTpGop)
            loc_cSQL = "SELECT 0 AS Acesso, * FROM SigInTgo"
            IF USED("TmpTpGop")
                USE IN TmpTpGop
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpTpGop") < 1
                MsgErro("Falha ao carregar tipos de OP (SigInTgo).", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT TmpTpGop
            SCAN
                IF fChecaAcesso("SIGPRGLOT", ALLTRIM(TmpTpGop.Codigos))
                    REPLACE Acesso WITH 1 IN TmpTpGop
                ENDIF
            ENDSCAN
            IF USED("CrTmpTpGop")
                USE IN CrTmpTpGop
            ENDIF
            SELECT * FROM TmpTpGop WHERE Acesso = 1 INTO CURSOR CrTmpTpGop READWRITE
            USE IN TmpTpGop
            SELECT CrTmpTpGop
            INDEX ON Codigos TAG Codigos
            GO TOP

            *-- Auto-selecionar tipo se GerPorTp e so ha um disponivel
            IF par_lGerPorTp AND RECCOUNT("CrTmpTpGop") = 1
                THIS.this_cTpGOp = ALLTRIM(CrTmpTpGop.Codigos)
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar par" + CHR(226) + "metros: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - carrega dados da empresa pelo codigo
    * Popula this_cCdEmpresa e this_cDsEmpresa
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresa(par_cCodEmp)
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cCodEmp))
            IF USED("TempEmp")
                USE IN TempEmp
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEmp") >= 1
                SELECT TempEmp
                IF NOT EOF()
                    THIS.this_cCdEmpresa = ALLTRIM(TempEmp.Cemps)
                    THIS.this_cDsEmpresa = ALLTRIM(TempEmp.Razas)
                    loc_lSucesso = .T.
                ENDIF
                USE IN TempEmp
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar empresa: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNumeroOP - verifica se numero de OP ja existe em SigOpPic
    * Retorna .T. se DISPONIVEL (nao existe), .F. se JA EXISTE ou erro
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNumeroOP(par_nNop)
        LOCAL loc_cSQL, loc_lDisponivel, loc_oErro
        loc_lDisponivel = .T.

        TRY
            loc_cSQL = "SELECT Numps FROM SigOpPic WHERE Numps = " + TRANSFORM(par_nNop)
            IF USED("TmpOpi")
                USE IN TmpOpi
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpOpi") >= 1
                IF RECCOUNT("TmpOpi") > 0
                    loc_lDisponivel = .F.
                ENDIF
                USE IN TmpOpi
            ELSE
                loc_lDisponivel = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar n" + CHR(250) + "mero de OP: " + loc_oErro.Message, "Erro")
            loc_lDisponivel = .F.
        ENDTRY

        RETURN loc_lDisponivel
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursoresProcessamento - cria cursores temporarios para Processar
    * TmpCabec, TmpItens, DBParam, SelPedra, Produtos
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursoresProcessamento()
        LOCAL loc_oErro
        TRY
            IF USED("DBParam")
                USE IN DBParam
            ENDIF
            IF USED("TmpCabec")
                USE IN TmpCabec
            ENDIF
            IF USED("TmpItens")
                USE IN TmpItens
            ENDIF
            IF USED("SelPedra")
                USE IN SelPedra
            ENDIF
            IF USED("Produtos")
                USE IN Produtos
            ENDIF

            SET NULL ON
            CREATE CURSOR DBParam (CodTgOps C(10) NULL, OpZers N(1,0) NULL, EntPes N(1,0) NULL)
            SET NULL OFF

            SET NULL ON
            CREATE CURSOR TmpCabec (Flag L, Emps C(3), Dopes C(20), Numes N(6,0), ;
                                     Grupo C(10), Conta C(10), Datas D NULL, ;
                                     Entregas D NULL, Grupov C(10), Contav C(10), ;
                                     Obs M NULL, Peso N(12,2), ;
                                     GrupoDs C(10), ContaDs C(10), DConta C(40), ;
                                     Notas C(6), Jobs C(10))
            SET NULL OFF
            INDEX ON DTOS(Entregas) + Emps + Dopes + STR(Numes,6) TAG Entrega
            INDEX ON Emps + Dopes + STR(Numes,6) TAG Empdopnum
            SET ORDER TO TAG Empdopnum

            SET NULL ON
            CREATE CURSOR SelPedra (Cpros C(14), Dpros C(40), Cunis C(3), ;
                                     Qtds N(12,3), Cpro2s C(14))
            SET NULL OFF

            CREATE CURSOR Produtos (Cpros C(14), Dpros C(40), cmats C(14))
            INDEX ON Cpros TAG Cpros

            SET NULL ON
            CREATE CURSOR TmpItens (Emps C(3), Dopes C(20), Numes N(6,0), ;
                                     CPros C(14), Qtds N(12,3), Saldo N(12,3), ;
                                     Peso N(9,3), Obs M NULL, Linhas C(10), ;
                                     CodCors C(4), CodTams C(4), Citens N(10,0), ;
                                     Notas C(6), dpros C(40), Reffs C(40))
            SET NULL OFF
            INDEX ON Linhas + Cpros TAG LinPro
            INDEX ON Cpros TAG Cpros
            INDEX ON Emps + Dopes + STR(Numes,6) TAG Empdopnum
            SET ORDER TO TAG Empdopnum

        CATCH TO loc_oErro
            MsgErro("Erro ao preparar cursores de processamento: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarOrdens - logica principal de processamento de OP
    * Usa this_* properties definidas pela form para os filtros.
    * Popula TmpCabec e TmpItens para uso pelo form SigPrGl2.
    * Retorna .T. se ha registros a processar, .F. caso contrario.
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarOrdens()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_Conde, loc_Condp, loc_cSQL
        LOCAL loc_cDateiSQL, loc_cDatefSQL, loc_cDatepiSQL, loc_cDatepfSQL
        LOCAL loc_Dopp, loc_lcTpGOp, loc_lcEmp
        LOCAL loc_Grupo, loc_Conta, loc_GrupoV, loc_ContaV
        LOCAL loc_GrupoG, loc_ContaG, loc_GrupoD, loc_ContaD
        LOCAL loc_Operacao, loc_Operacaoi, loc_Operacaof
        LOCAL loc_TPeso, loc_Processa, loc_Saldo, loc_Peso
        LOCAL loc_lcEdn, loc_lcCpo, loc_oProg, loc_xBaixa, loc_lnQtdTb
        LOCAL loc_pItn, loc_cDConta

        loc_lSucesso = .F.

        TRY
            THIS.PrepararCursoresProcessamento()

            *-- Coletar filtros das propriedades do BO
            SELECT crSigCdPam
            loc_Dopp       = crSigCdPam.DoppPads
            loc_lcTpGOp    = THIS.this_cTpGOp
            loc_lcEmp      = IIF(EMPTY(THIS.this_cCdEmpresa), go_4c_Sistema.cCodEmpresa, THIS.this_cCdEmpresa)
            loc_Grupo      = THIS.this_cGrupoConta
            loc_Conta      = THIS.this_cConta
            loc_GrupoV     = THIS.this_cGrupoResp
            loc_ContaV     = THIS.this_cContaResp
            loc_Operacao   = THIS.this_cOperacao
            loc_Operacaoi  = THIS.this_nOperacaoi
            loc_Operacaof  = THIS.this_nOperacaof

            *-- Carregar operacao padrao (SigCdOpd)
            loc_cSQL = "SELECT * FROM SigCdOpd WHERE Dopps = " + EscaparSQL(ALLTRIM(loc_Dopp))
            IF USED("crSigCdOpd")
                USE IN crSigCdOpd
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpd") < 1
                MsgErro("Falha ao carregar opera" + CHR(231) + CHR(227) + "o padr" + CHR(227) + "o (SigCdOpd).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Formatar datas para SQL
            loc_cDateiSQL  = IIF(EMPTY(THIS.this_dDataei), "NULL", FormatarDataSQL(THIS.this_dDataei))
            loc_cDatefSQL  = IIF(EMPTY(THIS.this_dDataef), "NULL", THIS.FormatarDataHoraSQL(THIS.this_dDataef, "23:59:59"))
            loc_cDatepiSQL = IIF(EMPTY(THIS.this_dDatapi), "NULL", FormatarDataSQL(THIS.this_dDatapi))
            loc_cDatepfSQL = IIF(EMPTY(THIS.this_dDatapf), "NULL", THIS.FormatarDataHoraSQL(THIS.this_dDatapf, "23:59:59"))

            *-- Condicao de periodo de emissao
            IF EMPTY(THIS.this_dDataef)
                loc_Conde = ""
            ELSE
                IF EMPTY(THIS.this_dDataei)
                loc_Conde = "Datas <= " + loc_cDatefSQL + " AND "
            ELSE
                loc_Conde = "Datas BETWEEN " + loc_cDateiSQL + " AND " + loc_cDatefSQL + " AND "
                ENDIF
            ENDIF

            *-- Condicao de periodo de previsao de entrega
            IF EMPTY(THIS.this_dDatapi)
                IF EMPTY(THIS.this_dDatapf)
                    loc_Condp = ""
                ELSE
                    loc_Condp = "PrazoEnts <= " + loc_cDatepfSQL + " AND "
                ENDIF
            ELSE
                IF EMPTY(THIS.this_dDatapf)
                    loc_Condp = "PrazoEnts >= " + loc_cDatepiSQL + " AND "
                ELSE
                    loc_Condp = "PrazoEnts BETWEEN " + loc_cDatepiSQL + " AND " + loc_cDatepfSQL + " AND "
                ENDIF
            ENDIF

            *-- Inserir parametros de geracao em DBParam
            IF SEEK(ALLTRIM(loc_lcTpGOp), "CrTmpTpGop", "Codigos")
                INSERT INTO DBParam (CodTgOps, OpZers, EntPes) ;
                    VALUES (loc_lcTpGOp, ;
                            IIF(THIS.this_lGerPorTp, CrTmpTpGop.OpZers, crSigCdPac.OpZers), ;
                            IIF(THIS.this_lGerPorTp, CrTmpTpGop.EntPes, 0))
            ELSE
                INSERT INTO DBParam (CodTgOps, OpZers, EntPes) ;
                    VALUES (loc_lcTpGOp, crSigCdPac.OpZers, 0)
            ENDIF

            *-- Verificar operacoes dispon?veis
            SELECT TmpOper
            GO TOP
            IF EOF()
                MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Configurada Para Processar " + ;
                         "Ordem de Produ" + CHR(231) + CHR(227) + "o!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Aplicar filtro de operacao especifica
            SET ORDER TO TAG Dopes IN TmpOper
            IF NOT EMPTY(loc_Operacao)
                SET KEY TO loc_Operacao IN TmpOper
            ENDIF

            *-- Iterar operacoes
            SELECT TmpOper
            SCAN
                IF THIS.this_lGerPorTp AND ALLTRIM(TmpOper.CodTgOps) <> ALLTRIM(loc_lcTpGOp)
                    LOOP
                ENDIF

                *-- Montar SQL para buscar movimentos desta operacao
                loc_cSQL = "SELECT Emps, Dopes, Numes, Datas, PrazoEnts, GrupoOs, " + ;
                           "ContaOs, GrupoDs, ContaDs, GrVends, Vends, Obses, rNops, Notas, Jobs " + ;
                           "FROM SigMvCab " + ;
                           "WHERE " + loc_Conde + loc_Condp + ;
                           "Emps = " + EscaparSQL(ALLTRIM(loc_lcEmp)) + " AND " + ;
                           "Dopes = " + EscaparSQL(ALLTRIM(TmpOper.Dopes)) + " AND "

                *-- Filtros de conta (cliente/destino conforme Globalizas)
                IF NOT EMPTY(loc_Grupo)
                    IF TmpOper.Globalizas = 1
                        loc_cSQL = loc_cSQL + "GrupoOs = " + EscaparSQL(ALLTRIM(loc_Grupo)) + " AND "
                    ENDIF
                    IF TmpOper.Globalizas = 2
                        loc_cSQL = loc_cSQL + "GrupoDs = " + EscaparSQL(ALLTRIM(loc_Grupo)) + " AND "
                    ENDIF
                ENDIF
                IF NOT EMPTY(loc_Conta)
                    IF TmpOper.Globalizas = 1
                        loc_cSQL = loc_cSQL + "ContaOs = " + EscaparSQL(ALLTRIM(loc_Conta)) + " AND "
                    ENDIF
                    IF TmpOper.Globalizas = 2
                        loc_cSQL = loc_cSQL + "ContaDs = " + EscaparSQL(ALLTRIM(loc_Conta)) + " AND "
                    ENDIF
                ENDIF
                *-- Filtros de vendedor (Responsavel)
                IF NOT EMPTY(loc_GrupoV)
                    loc_cSQL = loc_cSQL + "GrVends = " + EscaparSQL(ALLTRIM(loc_GrupoV)) + " AND "
                ENDIF
                IF NOT EMPTY(loc_ContaV)
                    loc_cSQL = loc_cSQL + "Vends = " + EscaparSQL(ALLTRIM(loc_ContaV)) + " AND "
                ENDIF
                *-- Apenas movimentos sem OP gerada
                loc_cSQL = loc_cSQL + "Nops = 0"

                IF USED("TempEest")
                    USE IN TempEest
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEest") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o ao buscar movimentos (TempEest).", "Erro")
                    loc_lSucesso = .F.
                ENDIF

                *-- Barra de progresso por operacao
                SELECT TempEest
                loc_oProg = CREATEOBJECT("fwprogressbar", ;
                    "Processando Opera" + CHR(231) + CHR(227) + "o " + ALLTRIM(TmpOper.Dopes) + "...", ;
                    RECCOUNT())
                loc_oProg.Show()

                SCAN
                    loc_oProg.Update(.T.)

                    *-- Filtrar por faixa de numero de OP se especificada
                    IF NOT EMPTY(loc_Operacao)
                        IF loc_Operacaoi != 0 AND loc_Operacaof != 0 AND ;
                           NOT BETWEEN(TempEest.Numes, loc_Operacaoi, loc_Operacaof)
                            LOOP
                        ENDIF
                    ENDIF

                    *-- Grupo/Conta conforme tipo de globalizacao
                    IF TmpOper.Globalizas = 1
                        loc_GrupoG = ALLTRIM(TempEest.GrupoOs)
                        loc_ContaG = ALLTRIM(TempEest.ContaOs)
                    ELSE
                        loc_GrupoG = ALLTRIM(TempEest.GrupoDs)
                        loc_ContaG = ALLTRIM(TempEest.ContaDs)
                    ENDIF

                    *-- Pular movimentos com reserva automatica ja processada
                    IF THIS.this_lReserva AND TempEest.rNops > 0
                        LOOP
                    ENDIF

                    loc_TPeso    = 0
                    loc_Processa = .F.

                    *-- Buscar itens do movimento (SigMvItn)
                    loc_lcEdn = TempEest.Emps + TempEest.Dopes + STR(TempEest.Numes, 6)
                    loc_lcCpo = "CPros, CItens, Qtds, QtBaixas, QtProds, Pesos, " + ;
                                "Emps, Dopes, Numes, Obs, Notas, Dpros, Opers, Citem2"
                    loc_cSQL = "SELECT " + loc_lcCpo + " FROM SigMvItn " + ;
                               "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn)
                    IF USED("TempEestI")
                        USE IN TempEestI
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEestI") < 1
                        MsgErro("Falha ao buscar itens do movimento (TempEestI).", "Erro")
                        loc_lSucesso = .F.
                    ENDIF

                    SELECT TempEestI
                    SCAN
                        *-- Filtrar por operacao interna se OPers = 3
                        IF TmpOper.OPers = 3 AND NOT EMPTY(TmpOper.OpeGops) AND ;
                           ALLTRIM(TempEestI.Opers) <> ALLTRIM(TmpOper.OpeGops)
                            LOOP
                        ENDIF
                        *-- Pular componentes de sub-montagem se carcompos = 5
                        IF TmpOper.carcompos = 5 AND TempEestI.Citem2 <> 0
                            LOOP
                        ENDIF

                        *-- Carregar dados do produto
                        loc_cSQL = "SELECT Pesoms, Linhas, QtdCpnts, DPros, Reffs, Cgrus " + ;
                                   "FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(TempEestI.CPros))
                        IF USED("crSigCdPro")
                            USE IN crSigCdPro
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPro") < 1
                            MsgErro("Falha ao carregar produto (SigCdPro).", "Erro")
                            loc_lSucesso = .F.
                        ENDIF

                        *-- Carregar grupo do produto
                        loc_cSQL = "SELECT GeraTubs FROM SigCdGrp " + ;
                                   "WHERE CGrus = " + EscaparSQL(ALLTRIM(crSigCdPro.CGrus))
                        IF USED("crSigCdGrp")
                            USE IN crSigCdGrp
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGrp") < 1
                            MsgErro("Falha ao carregar grupo do produto (SigCdGrp).", "Erro")
                            loc_lSucesso = .F.
                        ENDIF

                        loc_pItn   = TempEestI.CItens
                        loc_lnQtdTb = 0

                        *-- Buscar sub-itens (SigMvIts)
                        loc_cSQL = "SELECT * FROM SigMvIts " + ;
                                   "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn) + ;
                                   " AND CItens = " + FormatarNumeroSQL(loc_pItn)
                        IF USED("TempEsti2")
                            USE IN TempEsti2
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEsti2") < 1
                            MsgErro("Falha ao buscar sub-itens (TempEsti2).", "Erro")
                            loc_lSucesso = .F.
                        ENDIF

                        SELECT TempEsti2
                        GO TOP
                        IF EOF("TempEsti2")
                            *-- Sem sub-itens: processar item principal
                            SELECT TempEestI
                            loc_xBaixa = IIF(QtBaixas > 0 AND QtBaixas >= QtProds, ;
                                             QtBaixas - QtProds, 0) + QtProds
                            loc_Saldo  = TempEestI.Qtds - loc_xBaixa
                            loc_Peso   = IIF(EMPTY(TempEestI.Pesos), crSigCdPro.Pesoms, TempEestI.Pesos)
                            IF loc_Saldo <> 0
                                INSERT INTO TmpItens ;
                                    (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, ;
                                     Linhas, Citens, Notas, Dpros, Reffs) ;
                                    VALUES (TempEestI.Emps, TempEestI.Dopes, TempEestI.Numes, ;
                                            TempEestI.CPros, TempEestI.Qtds, loc_Saldo, ;
                                            TempEestI.Obs, loc_Peso, crSigCdPro.Linhas, ;
                                            TempEestI.Citens, TempEestI.Notas, TempEestI.Dpros, ;
                                            crSigCdPro.Reffs)
                                loc_TPeso    = loc_TPeso + (loc_Peso * loc_Saldo)
                                loc_Processa = .T.
                                *-- Verificar qtd de tubos por grupo
                                IF crSigCdGrp.GeraTubs <> 2
                                    loc_lnQtdTb = crSigCdPro.QtdCpnts
                                ELSE
                                    loc_cSQL = "SELECT SUM(qtds) AS total FROM SigPrMtz " + ;
                                               "WHERE Cpros = " + EscaparSQL(ALLTRIM(TempEestI.CPros))
                                    IF USED("crSigPrMtz")
                                        USE IN crSigPrMtz
                                    ENDIF
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrMtz") >= 1
                                        SELECT crSigPrMtz
                                        loc_lnQtdTb = NVL(crSigPrMtz.total, 0)
                                    ENDIF
                                ENDIF
                                IF loc_lnQtdTb = 0
                                    SELECT Produtos
                                    IF NOT SEEK(ALLTRIM(TempEestI.Cpros), "Produtos", "CPros")
                                        INSERT INTO Produtos (Cpros, DPros) ;
                                            VALUES (TempEestI.Cpros, crSigCdPro.Dpros)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ELSE
                            *-- Com sub-itens: processar cada sub-item
                            SELECT TempEsti2
                            SCAN
                                loc_xBaixa = IIF(QtBaixas > 0 AND QtBaixas >= QtProds, ;
                                                 QtBaixas - QtProds, 0) + QtProds
                                loc_Saldo  = TempEsti2.Qtds - loc_xBaixa
                                loc_Peso   = IIF(EMPTY(TempEsti2.Pesos), crSigCdPro.Pesoms, TempEsti2.Pesos)
                                IF loc_Saldo <> 0
                                    INSERT INTO TmpItens ;
                                        (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, ;
                                         Linhas, CodCors, CodTams, Citens, Notas, Dpros, Reffs) ;
                                        VALUES (TempEsti2.Emps, TempEsti2.Dopes, TempEsti2.Numes, ;
                                                TempEsti2.CPros, TempEsti2.Qtds, loc_Saldo, ;
                                                TempEestI.Obs, loc_Peso, crSigCdPro.Linhas, ;
                                                TempEsti2.CodCors, TempEsti2.CodTams, ;
                                                TempEestI.Citens, TempEestI.Notas, TempEestI.Dpros, ;
                                                crSigCdPro.Reffs)
                                    loc_TPeso    = loc_TPeso + (loc_Peso * loc_Saldo)
                                    loc_Processa = .T.
                                    *-- Verificar qtd de tubos por grupo
                                    IF crSigCdGrp.GeraTubs <> 2
                                        loc_lnQtdTb = crSigCdPro.QtdCpnts
                                    ELSE
                                        loc_cSQL = "SELECT SUM(qtds) AS total FROM SigPrMtz " + ;
                                                   "WHERE Cpros = " + EscaparSQL(ALLTRIM(TempEestI.CPros))
                                        IF USED("crSigPrMtz")
                                            USE IN crSigPrMtz
                                        ENDIF
                                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrMtz") >= 1
                                            SELECT crSigPrMtz
                                            loc_lnQtdTb = NVL(crSigPrMtz.total, 0)
                                        ENDIF
                                    ENDIF
                                    IF loc_lnQtdTb = 0
                                        SELECT Produtos
                                        IF NOT SEEK(ALLTRIM(TempEestI.Cpros), "Produtos", "CPros")
                                            INSERT INTO Produtos (Cpros, DPros) ;
                                                VALUES (TempEestI.Cpros, crSigCdPro.Dpros)
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDSCAN
                        ENDIF
                    ENDSCAN

                    *-- Inserir cabecalho se ha itens para processar neste movimento
                    IF loc_Processa
                        *-- Destino: preferencia pelo SigCdOpd, fallback para o movimento
                        loc_GrupoD = IIF(EMPTY(crSigCdOpd.GruDests), ;
                                         ALLTRIM(TempEest.GrupoDs), ALLTRIM(crSigCdOpd.GruDests))
                        loc_ContaD = IIF(EMPTY(crSigCdOpd.ConDests), ;
                                         ALLTRIM(TempEest.ContaDs), ALLTRIM(crSigCdOpd.ConDests))

                        *-- Buscar razao social do cliente
                        loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli " + ;
                                   "WHERE IClis = " + EscaparSQL(loc_ContaG)
                        IF USED("LocalCli")
                            USE IN LocalCli
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalCli") < 1
                            MsgErro("Falha ao buscar cliente (SigCdCli).", "Erro")
                            loc_lSucesso = .F.
                        ENDIF
                        SELECT LocalCli
                        loc_cDConta = IIF(EOF(), "", ALLTRIM(LocalCli.RClis))
                        USE IN LocalCli

                        INSERT INTO TmpCabec ;
                            (Flag, Emps, Dopes, Numes, Grupo, Conta, Grupov, Contav, ;
                             Datas, Entregas, Peso, Obs, GrupoDs, ContaDs, DConta, ;
                             Notas, Jobs) ;
                            VALUES (.T., TempEest.Emps, TempEest.Dopes, TempEest.Numes, ;
                                    loc_GrupoG, loc_ContaG, ;
                                    ALLTRIM(TempEest.GrVends), ALLTRIM(TempEest.Vends), ;
                                    TempEest.Datas, TempEest.PrazoEnts, ;
                                    loc_TPeso, TempEest.Obses, ;
                                    loc_GrupoD, loc_ContaD, loc_cDConta, ;
                                    ALLTRIM(TempEest.Notas), ALLTRIM(TempEest.Jobs))
                    ENDIF
                ENDSCAN

                loc_oProg.Complete()

                IF USED("TempEest")
                    USE IN TempEest
                ENDIF
            ENDSCAN

            *-- Limpar filtro de operacao
            IF NOT EMPTY(loc_Operacao)
                SET KEY TO IN TmpOper
            ENDIF

            *-- Posicionar cursores no inicio
            GO TOP IN TmpCabec
            GO TOP IN TmpItens

            *-- Verificar se ha registros para processar
            loc_lSucesso = NOT EOF("TmpItens") AND NOT EOF("TmpCabec")
            IF NOT loc_lSucesso
                MsgAviso("Nenhum Item Selecionado Para Processar!!!", "Aviso")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao processar ordens: " + loc_oErro.Message + ;
                    " Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave identificadora do contexto de processamento
    * Formato: Emp + TpGOp + Numps (evita colisao entre empresas/tipos)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cCdEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cTpGOp) + "|" + ;
                     TRANSFORM(THIS.this_nNop)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - grava uma OP gerada em SigOpPic (Ordens de Producao)
    * Chamada apos usuario confirmar selecao em SigPrGl2.
    * par_nNumps: numero da OP a gravar
    * par_cDope: operacao (Dopes) do item
    * par_cCpro: codigo do produto
    * par_nQtds: quantidade da OP
    * par_nNumes: numero do movimento origem (SigMvCab.Numes)
    * par_cCodTgOp: tipo de geracao (opcional; usa this_cTpGOp se vazio)
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Inserir(par_nNumps, par_cDope, par_cCpro, par_nQtds, par_nNumes, par_cCodTgOp)
        LOCAL loc_lSucesso, loc_cSQL, loc_cEmp, loc_cDopp
        LOCAL loc_cCodTgOp, loc_cIdChave, loc_dGeracao, loc_dPrev
        LOCAL loc_cEmpDopNums, loc_cEmpDopNops, loc_cEmpDnps
        LOCAL loc_cUsuario, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Validar parametros obrigatorios
            IF EMPTY(par_nNumps) OR par_nNumps <= 0
                MsgErro("N" + CHR(250) + "mero da OP inv" + CHR(225) + "lido para inser" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(ALLTRIM(par_cDope))
                MsgErro("Opera" + CHR(231) + CHR(227) + "o (Dopes) obrigat" + CHR(243) + "ria para inser" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Verificar duplicidade antes de inserir
            IF NOT THIS.ValidarNumeroOP(par_nNumps)
                MsgAviso("N" + CHR(250) + "mero de OP " + TRANSFORM(par_nNumps) + " j" + CHR(225) + " existe em SigOpPic.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Preparar valores
            loc_cEmp      = ALLTRIM(THIS.this_cCdEmpresa)
            IF EMPTY(loc_cEmp)
                loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF
            loc_dGeracao  = IIF(EMPTY(THIS.this_dGeracao), DATE(), THIS.this_dGeracao)
            loc_dPrev     = IIF(EMPTY(THIS.this_dPrevisao), loc_dGeracao, THIS.this_dPrevisao)
            loc_cCodTgOp  = IIF(EMPTY(ALLTRIM(par_cCodTgOp)), ALLTRIM(THIS.this_cTpGOp), ALLTRIM(par_cCodTgOp))
            loc_cUsuario  = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            *-- Recuperar Dopp da operacao padrao (usa CarregarParametros previamente)
            loc_cDopp = ""
            IF USED("crSigCdPam")
                SELECT crSigCdPam
                loc_cDopp = ALLTRIM(crSigCdPam.DoppPads)
            ENDIF

            *-- Composicao das chaves compostas (padrao do sistema)
            loc_cEmpDopNums = loc_cEmp + ALLTRIM(par_cDope) + PADL(TRANSFORM(par_nNumes), 6, "0")
            loc_cEmpDopNops = loc_cEmp + ALLTRIM(par_cDope) + PADL(TRANSFORM(par_nNumps), 10, "0")
            loc_cEmpDnps    = loc_cEmp + PADL(TRANSFORM(par_nNumps), 10, "0")
            loc_cIdChave    = loc_cEmp + PADL(TRANSFORM(par_nNumps), 10, "0")

            *-- Montar INSERT em SigOpPic (colunas NOT NULL preenchidas)
            loc_cSQL = "INSERT INTO SigOpPic " + ;
                       "(cIdChaves, Emps, Dopes, Dopps, Nops, Numes, Numps, " + ;
                       " Datas, Datap, Datages, Cpros, Empds, Locals, Ntrans, " + ;
                       " Seqdivs, CodCors, CodTams, Divs, Imprs, Usuars, Nopmaes, " + ;
                       " Pesos, CodBarras, QtdCpnts, QtdTubos, iImprs, Moedas, Units, " + ;
                       " Nfunds, Dpros, Empdnps, EmpDopNops, EmpDopNums, Notas, " + ;
                       " CodTgOps, Citens, Qtds) VALUES ("
            loc_cSQL = loc_cSQL + ;
                       EscaparSQL(loc_cIdChave) + ", " + ;
                       EscaparSQL(loc_cEmp) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cDope)) + ", " + ;
                       EscaparSQL(loc_cDopp) + ", " + ;
                       FormatarNumeroSQL(par_nNumps) + ", " + ;
                       FormatarNumeroSQL(par_nNumes) + ", " + ;
                       FormatarNumeroSQL(par_nNumps) + ", " + ;
                       FormatarDataSQL(loc_dGeracao) + ", " + ;
                       FormatarDataSQL(loc_dPrev) + ", " + ;
                       FormatarDataSQL(loc_dGeracao) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cCpro)) + ", " + ;
                       EscaparSQL(loc_cEmp) + ", " + ;
                       EscaparSQL("") + ", " + ;
                       "0, 0, "
            loc_cSQL = loc_cSQL + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL("") + ", " + ;
                       "0, 0, " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "0, 0, 0, 0, 0, 0, " + ;
                       EscaparSQL("") + ", " + ;
                       "0, 0, " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(loc_cEmpDnps) + ", " + ;
                       EscaparSQL(loc_cEmpDopNops) + ", " + ;
                       EscaparSQL(loc_cEmpDopNums) + ", " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(loc_cCodTgOp) + ", " + ;
                       "0, " + ;
                       FormatarNumeroSQL(par_nQtds) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                MsgErro("Falha ao gravar OP em SigOpPic (n" + CHR(250) + "mero " + TRANSFORM(par_nNumps) + ").", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Auditoria da insercao
            THIS.RegistrarAuditoria("INCLUIR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir OP: " + loc_oErro.Message + ;
                    " Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - vincula movimento origem (SigMvCab) ao numero da OP gerada
    * Em modo Reserva: atualiza rNops (reserva). Modo normal: atualiza Nops.
    * par_cEmp: empresa do movimento
    * par_cDope: operacao do movimento
    * par_nNumes: numero do movimento
    * par_nNumps: numero da OP gerada
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_cEmp, par_cDope, par_nNumes, par_nNumps)
        LOCAL loc_lSucesso, loc_cSQL, loc_cEmpDopNums, loc_cCampo
        LOCAL loc_dAlt, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Validar parametros
            IF EMPTY(par_nNumps) OR par_nNumps <= 0
                MsgErro("N" + CHR(250) + "mero da OP inv" + CHR(225) + "lido para atualiza" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(ALLTRIM(par_cEmp)) OR EMPTY(ALLTRIM(par_cDope)) OR par_nNumes <= 0
                MsgErro("Chave do movimento (Emp/Dope/Numes) obrigat" + CHR(243) + "ria.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Campo destino: rNops em reserva automatica, Nops caso contrario
            loc_cCampo = IIF(THIS.this_lReserva, "rNops", "Nops")

            *-- Chave composta EmpDopNums
            loc_cEmpDopNums = ALLTRIM(par_cEmp) + ALLTRIM(par_cDope) + PADL(TRANSFORM(par_nNumes), 6, "0")

            *-- Dados de auditoria embutidos no proprio UPDATE
            loc_dAlt     = DATE()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "UPDATE SigMvCab SET " + loc_cCampo + " = " + FormatarNumeroSQL(par_nNumps)
            IF NOT THIS.this_lReserva
                loc_cSQL = loc_cSQL + ", Dtalts = " + FormatarDataSQL(loc_dAlt) + ;
                           ", Usualts = " + EscaparSQL(loc_cUsuario)
            ENDIF
            loc_cSQL = loc_cSQL + " WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums)

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                MsgErro("Falha ao atualizar movimento " + loc_cEmpDopNums + " com OP " + TRANSFORM(par_nNumps) + ".", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Auditoria da atualizacao
            THIS.RegistrarAuditoria("ALTERAR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar movimento: " + loc_oErro.Message + ;
                    " Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

