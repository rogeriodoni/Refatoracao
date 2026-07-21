# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 854: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 879: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGl2.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1499 linhas total):

*-- Linhas 92 a 100:
92:         loc_lSucesso = .F.
93: 
94:         TRY
95:             THIS.Caption = "Opera" + CHR(231) + CHR(245) + "es Selecionadas"
96: 
97:             *-- Criar Business Object
98:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGl2BO")
99:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
100:                 MsgErro("Falha ao criar SigPrGl2BO", "Erro SigPrGl2")

*-- Linhas 120 a 129:
120: 
121:             *-- Configurar cabecalho cinza (cntSombra do legado)
122:             THIS.ConfigurarCabecalho()
123:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
124:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
125: 
126:             *-- Configurar grade de operacoes e botoes de acao
127:             THIS.ConfigurarPaginaLista()
128:             THIS.ConfigurarBotoes()
129: 

*-- Linhas 162 a 171:
162:         *-- Top=7, Left=732, Width=60, Height=29, BackStyle=0, BorderStyle=0
163:         THIS.AddObject("shp_4c_Shape3", "Shape")
164:         WITH THIS.shp_4c_Shape3
165:             .Top         = 7
166:             .Left        = 732
167:             .Height      = 29
168:             .Width       = 60
169:             .BackStyle   = 0
170:             .BorderStyle = 0
171:             .BorderColor = RGB(136, 189, 188)

*-- Linhas 183 a 227:
183:         *-- Top=0, Left=0, Width=800, Height=80, BackColor=RGB(100,100,100)
184:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
185:         WITH THIS.cnt_4c_Cabecalho
186:             .Top         = 0
187:             .Left        = 0
188:             .Width       = loc_nW
189:             .Height      = 80
190:             .BackStyle   = 1
191:             .BackColor   = RGB(100, 100, 100)
192:             .BorderWidth = 0
193: 
194:             *-- Label sombra: ForeColor preto, efeito de profundidade
195:             *-- Top=18, Left=10, Width=769, Height=40, FontSize=18
196:             .AddObject("lbl_4c_Sombra", "Label")
197:             WITH .lbl_4c_Sombra
198:                 .AutoSize  = .F.
199:                 .Width     = loc_nW - 31
200:                 .Height    = 40
201:                 .Top       = 18
202:                 .Left      = 10
203:                 .Caption   = ""
204:                 .FontName  = "Tahoma"
205:                 .FontSize  = 18
206:                 .FontBold  = .T.
207:                 .BackStyle = 0
208:                 .ForeColor = RGB(0, 0, 0)
209:                 .WordWrap  = .T.
210:                 .Alignment = 0
211:             ENDWITH
212: 
213:             *-- Label titulo: branco sobre fundo cinza
214:             *-- Top=17, Left=10, Width=769, Height=46, FontSize=18
215:             .AddObject("lbl_4c_Titulo", "Label")
216:             WITH .lbl_4c_Titulo
217:                 .AutoSize  = .F.
218:                 .Width     = loc_nW - 31
219:                 .Height    = 46
220:                 .Top       = 17
221:                 .Left      = 10
222:                 .Caption   = ""
223:                 .FontName  = "Tahoma"
224:                 .FontSize  = 18
225:                 .FontBold  = .T.
226:                 .BackStyle = 0
227:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 286 a 301:
286:     PROTECTED PROCEDURE ConfigurarGradeOperacao
287:     *==========================================================================
288:         *-- GradeOperacao: Top=155, Left=5, Width=789, Height=156, 10 colunas
289:         *-- Column1 = CheckBox (Flag), Columns 2-10 = campos de TmpCabec
290:         LOCAL loc_oErro
291: 
292:         TRY
293:             THIS.AddObject("grd_4c_GradeOperacao", "Grid")
294:             WITH THIS.grd_4c_GradeOperacao
295:                 .Top               = 155
296:                 .Left              = 5
297:                 .Width             = 789
298:                 .Height            = 156
299:                 .ColumnCount       = 10
300:                 .FontName          = "Verdana"
301:                 .FontSize          = 8

*-- Linhas 318 a 342:
318:                     .RecordSource = "TmpCabec"
319:                 ENDIF
320: 
321:                 *-- Column1: CheckBox de selecao (Flag) - Width=17
322:                 WITH .Column1
323:                     .Width     = 17
324:                     .Movable   = .F.
325:                     .Resizable = .F.
326:                     .AddObject("Check1", "CheckBox")
327:                     WITH .Check1
328:                         .Caption   = ""
329:                         .Value     = 0
330:                         .Themes    = .F.
331:                         .BackStyle = 0
332:                     ENDWITH
333:                     .CurrentControl = "Check1"
334:                     .Sparse         = .F.
335:                     .ReadOnly       = .F.
336:                     .ControlSource  = "TmpCabec.Flag"
337:                     .Header1.Caption   = ""
338:                     .Header1.Alignment = 2
339:                     .Header1.FontName  = "Verdana"
340:                     .Header1.FontSize  = 8
341:                     .Header1.ForeColor = RGB(36, 84, 155)
342:                 ENDWITH

*-- Linhas 350 a 358:
350:                     IF USED("TmpCabec")
351:                         .ControlSource = "TmpCabec.Dopes"
352:                     ENDIF
353:                     .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
354:                     .Header1.BackColor = RGB(220, 255, 220)
355:                     .Header1.Alignment = 2
356:                     .Header1.FontName  = "Verdana"
357:                     .Header1.FontSize  = 8
358:                     .Header1.ForeColor = RGB(36, 84, 155)

*-- Linhas 367 a 375:
367:                     IF USED("TmpCabec")
368:                         .ControlSource = "TmpCabec.Numes"
369:                     ENDIF
370:                     .Header1.Caption   = "N" + CHR(250) + "mero"
371:                     .Header1.Alignment = 2
372:                     .Header1.FontName  = "Verdana"
373:                     .Header1.FontSize  = 8
374:                     .Header1.ForeColor = RGB(36, 84, 155)
375:                 ENDWITH

*-- Linhas 383 a 391:
383:                     IF USED("TmpCabec")
384:                         .ControlSource = "TmpCabec.Datas"
385:                     ENDIF
386:                     .Header1.Caption   = "Emiss" + CHR(227) + "o"
387:                     .Header1.Alignment = 2
388:                     .Header1.FontName  = "Verdana"
389:                     .Header1.FontSize  = 8
390:                     .Header1.ForeColor = RGB(36, 84, 155)
391:                 ENDWITH

*-- Linhas 399 a 407:
399:                     IF USED("TmpCabec")
400:                         .ControlSource = "IIF(ISNULL(TmpCabec.Entregas), {}, TmpCabec.Entregas)"
401:                     ENDIF
402:                     .Header1.Caption   = "Entrega"
403:                     .Header1.BackColor = RGB(192, 192, 192)
404:                     .Header1.Alignment = 2
405:                     .Header1.FontName  = "Verdana"
406:                     .Header1.FontSize  = 8
407:                     .Header1.ForeColor = RGB(36, 84, 155)

*-- Linhas 417 a 425:
417:                     IF USED("TmpCabec")
418:                         .ControlSource = "TmpCabec.Peso"
419:                     ENDIF
420:                     .Header1.Caption   = "Peso"
421:                     .Header1.Alignment = 2
422:                     .Header1.FontName  = "Verdana"
423:                     .Header1.FontSize  = 8
424:                     .Header1.ForeColor = RGB(36, 84, 155)
425:                 ENDWITH

*-- Linhas 433 a 441:
433:                     IF USED("TmpCabec")
434:                         .ControlSource = "TmpCabec.Contav"
435:                     ENDIF
436:                     .Header1.Caption   = "Respons" + CHR(225) + "vel"
437:                     .Header1.Alignment = 2
438:                     .Header1.FontName  = "Verdana"
439:                     .Header1.FontSize  = 8
440:                     .Header1.ForeColor = RGB(36, 84, 155)
441:                 ENDWITH

*-- Linhas 450 a 458:
450:                     IF USED("TmpCabec")
451:                         .ControlSource = "TmpCabec.Conta"
452:                     ENDIF
453:                     .Header1.Caption   = "Cliente"
454:                     .Header1.Alignment = 2
455:                     .Header1.FontName  = "Verdana"
456:                     .Header1.FontSize  = 8
457:                     .Header1.ForeColor = RGB(36, 84, 155)
458:                 ENDWITH

*-- Linhas 469 a 477:
469:                     IF USED("TmpCabec")
470:                         .ControlSource = "IIF(EMPTY(TmpCabec.Obs), ' ', '*')"
471:                     ENDIF
472:                     .Header1.Caption   = "Obs"
473:                     .Header1.Alignment = 2
474:                     .Header1.FontName  = "Verdana"
475:                     .Header1.FontSize  = 8
476:                     .Header1.ForeColor = RGB(36, 84, 155)
477:                 ENDWITH

*-- Linhas 484 a 492:
484:                     IF USED("TmpCabec")
485:                         .ControlSource = "TmpCabec.Notas"
486:                     ENDIF
487:                     .Header1.Caption   = "Doc."
488:                     .Header1.Alignment = 2
489:                 ENDWITH
490:             ENDWITH
491: 
492:         CATCH TO loc_oErro

*-- Linhas 506 a 515:
506:             *-- Top=82, Left=5, Width=602, Height=70 (entre header e GradeOperacao)
507:             THIS.AddObject("edt_4c_ObsOperacao", "EditBox")
508:             WITH THIS.edt_4c_ObsOperacao
509:                 .Top         = 82
510:                 .Left        = 5
511:                 .Width       = 602
512:                 .Height      = 70
513:                 .FontName    = "Tahoma"
514:                 .FontSize    = 8
515:                 .ForeColor   = RGB(90, 90, 90)

*-- Linhas 524 a 552:
524: 
525:             *-- Label "Cliente :" (Label6 do legado)
526:             *-- Top=317, Left=5, Width=42, Height=15, AutoSize=.T.
527:             THIS.AddObject("lbl_4c_Label6", "Label")
528:             WITH THIS.lbl_4c_Label6
529:                 .Top       = 317
530:                 .Left      = 5
531:                 .Width     = 42
532:                 .Height    = 15
533:                 .AutoSize  = .T.
534:                 .Caption   = "Cliente :"
535:                 .FontName  = "Tahoma"
536:                 .FontSize  = 8
537:                 .ForeColor = RGB(90, 90, 90)
538:                 .BackStyle = 0
539:             ENDWITH
540: 
541:             *-- getCliente: nome do cliente da operacao corrente (TmpCabec.DConta)
542:             *-- fwget no legado = display-only (When retorna .F.)
543:             *-- Top=313, Left=59, Width=345, Height=23, SpecialEffect=1
544:             THIS.AddObject("txt_4c_Cliente", "TextBox")
545:             WITH THIS.txt_4c_Cliente
546:                 .Top           = 313
547:                 .Left          = 59
548:                 .Width         = 345
549:                 .Height        = 23
550:                 .FontName      = "Tahoma"
551:                 .FontSize      = 8
552:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 563 a 591:
563: 
564:             *-- Label "Observacao do Item : " (Txt_ObsItens do legado)
565:             *-- Top=532, Left=5, Width=146, Height=15, FontBold=.T., FontName=Verdana
566:             THIS.AddObject("lbl_4c_TxtObsItens", "Label")
567:             WITH THIS.lbl_4c_TxtObsItens
568:                 .Top       = 532
569:                 .Left      = 5
570:                 .Width     = 146
571:                 .Height    = 15
572:                 .AutoSize  = .T.
573:                 .FontName  = "Verdana"
574:                 .FontSize  = 8
575:                 .FontBold  = .T.
576:                 .BackStyle = 0
577:                 .ForeColor = RGB(90, 90, 90)
578:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item : "
579:             ENDWITH
580: 
581:             *-- ObsItens: observacao do item corrente (TmpItens.Obs)
582:             *-- Top=548, Left=5, Width=737, Height=47
583:             THIS.AddObject("edt_4c_ObsItens", "EditBox")
584:             WITH THIS.edt_4c_ObsItens
585:                 .Top         = 548
586:                 .Left        = 5
587:                 .Width       = 737
588:                 .Height      = 47
589:                 .FontName    = "Tahoma"
590:                 .FontSize    = 8
591:                 .ForeColor   = RGB(90, 90, 90)

*-- Linhas 614 a 623:
614:         TRY
615:             THIS.AddObject("grd_4c_GradeItens", "Grid")
616:             WITH THIS.grd_4c_GradeItens
617:                 .Top               = 339
618:                 .Left              = 5
619:                 .Width             = 737
620:                 .Height            = 191
621:                 .ColumnCount       = 8
622:                 .FontName          = "Verdana"
623:                 .FontSize          = 8

*-- Linhas 649 a 657:
649:                     IF USED("TmpItens")
650:                         .ControlSource = "TmpItens.Cpros"
651:                     ENDIF
652:                     .Header1.Caption   = "Produto"
653:                     .Header1.Alignment = 2
654:                     .Header1.FontName  = "Verdana"
655:                     .Header1.FontSize  = 8
656:                     .Header1.ForeColor = RGB(36, 84, 155)
657:                 ENDWITH

*-- Linhas 666 a 674:
666:                     IF USED("TmpItens")
667:                         .ControlSource = "TmpItens.Qtds"
668:                     ENDIF
669:                     .Header1.Caption   = "Quantidade"
670:                     .Header1.Alignment = 2
671:                     .Header1.FontName  = "Verdana"
672:                     .Header1.FontSize  = 8
673:                     .Header1.ForeColor = RGB(36, 84, 155)
674:                 ENDWITH

*-- Linhas 683 a 691:
683:                     IF USED("TmpItens")
684:                         .ControlSource = "TmpItens.Saldo"
685:                     ENDIF
686:                     .Header1.Caption   = "Saldo"
687:                     .Header1.Alignment = 2
688:                     .Header1.FontName  = "Verdana"
689:                     .Header1.FontSize  = 8
690:                     .Header1.ForeColor = RGB(36, 84, 155)
691:                 ENDWITH

*-- Linhas 700 a 708:
700:                     IF USED("TmpItens")
701:                         .ControlSource = "TmpItens.Peso"
702:                     ENDIF
703:                     .Header1.Caption   = "Peso"
704:                     .Header1.Alignment = 2
705:                     .Header1.FontName  = "Verdana"
706:                     .Header1.FontSize  = 8
707:                     .Header1.ForeColor = RGB(36, 84, 155)
708:                 ENDWITH

*-- Linhas 720 a 728:
720:                     IF USED("TmpItens")
721:                         .ControlSource = "IIF(EMPTY(TmpItens.Obs), ' ', '*')"
722:                     ENDIF
723:                     .Header1.Caption   = "Obs"
724:                     .Header1.Alignment = 2
725:                     .Header1.FontName  = "Verdana"
726:                     .Header1.FontSize  = 8
727:                     .Header1.ForeColor = RGB(36, 84, 155)
728:                 ENDWITH

*-- Linhas 737 a 745:
737:                     IF USED("TmpItens")
738:                         .ControlSource = "TmpItens.CodCors"
739:                     ENDIF
740:                     .Header1.Caption   = "Cor"
741:                     .Header1.Alignment = 2
742:                     .Header1.FontName  = "Verdana"
743:                     .Header1.FontSize  = 8
744:                     .Header1.ForeColor = RGB(36, 84, 155)
745:                 ENDWITH

*-- Linhas 754 a 762:
754:                     IF USED("TmpItens")
755:                         .ControlSource = "TmpItens.CodTams"
756:                     ENDIF
757:                     .Header1.Caption   = "Tam"
758:                     .Header1.Alignment = 2
759:                     .Header1.FontName  = "Verdana"
760:                     .Header1.FontSize  = 8
761:                     .Header1.ForeColor = RGB(36, 84, 155)
762:                 ENDWITH

*-- Linhas 771 a 779:
771:                     IF USED("TmpItens")
772:                         .ControlSource = "TmpItens.Reffs"
773:                     ENDIF
774:                     .Header1.Caption   = "Ref. Fornecedor"
775:                     .Header1.Alignment = 2
776:                 ENDWITH
777:             ENDWITH
778: 
779:             BINDEVENT(THIS.grd_4c_GradeItens, "AfterRowColChange", ;

*-- Linhas 788 a 897:
788:     *==========================================================================
789:     PROTECTED PROCEDURE ConfigurarBotoesSelecao
790:     *==========================================================================
791:         *-- cmd_4c_SelTudo (Top=400) e cmd_4c_Apaga (Top=358) ao lado de GradeItens
792:         LOCAL loc_oErro
793: 
794:         TRY
795:             THIS.AddObject("cmd_4c_Apaga", "CommandButton")
796:             WITH THIS.cmd_4c_Apaga
797:                 .Top             = 358
798:                 .Left            = 748
799:                 .Width           = 40
800:                 .Height          = 40
801:                 .Caption         = ""
802:                 .ToolTipText     = "Desmarcar Todos"
803:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
804:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
805:                 .Themes          = .T.
806:                 .SpecialEffect   = 0
807:                 .MousePointer    = 15
808:                 .FontName        = "Tahoma"
809:                 .FontSize        = 8
810:             ENDWITH
811:             BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
812: 
813:             THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
814:             WITH THIS.cmd_4c_SelTudo
815:                 .Top             = 400
816:                 .Left            = 748
817:                 .Width           = 40
818:                 .Height          = 40
819:                 .Caption         = ""
820:                 .ToolTipText     = "Selecionar Todos"
821:                 .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
822:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
823:                 .Themes          = .T.
824:                 .SpecialEffect   = 0
825:                 .MousePointer    = 15
826:                 .FontName        = "Tahoma"
827:                 .FontSize        = 8
828:             ENDWITH
829:             BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
830: 
831:         CATCH TO loc_oErro
832:             MsgErro("Erro em ConfigurarBotoesSelecao: " + loc_oErro.Message + ;
833:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
834:         ENDTRY
835:     ENDPROC
836: 
837:     *==========================================================================
838:     PROTECTED PROCEDURE ConfigurarBotoes
839:     *==========================================================================
840:         *-- cmd_4c_Processar (Left=648, Top=3) e cmd_4c_Cancelar (Left=723, Top=3)
841:         *-- Equivalentes aos botoes Processar/Encerrar do legado SIGPRGL2
842:         LOCAL loc_oErro
843: 
844:         TRY
845:             THIS.AddObject("cmd_4c_Processar", "CommandButton")
846:             WITH THIS.cmd_4c_Processar
847:                 .Top             = 3
848:                 .Left            = 648
849:                 .Width           = 75
850:                 .Height          = 75
851:                 .Caption         = "\<Processar"
852:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
853:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
854:                 .FontName        = "Comic Sans MS"
855:                 .FontSize        = 8
856:                 .FontBold        = .T.
857:                 .FontItalic      = .T.
858:                 .ForeColor       = RGB(90, 90, 90)
859:                 .BackColor       = RGB(255, 255, 255)
860:                 .Themes          = .T.
861:                 .PicturePosition = 13
862:                 .SpecialEffect   = 0
863:                 .MousePointer    = 15
864:                 .WordWrap        = .T.
865:                 .AutoSize        = .F.
866:             ENDWITH
867:             BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
868: 
869:             THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
870:             WITH THIS.cmd_4c_Cancelar
871:                 .Top             = 3
872:                 .Left            = 723
873:                 .Width           = 75
874:                 .Height          = 75
875:                 .Caption         = "Encerrar"
876:                 .Cancel          = .T.
877:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
878:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
879:                 .FontName        = "Comic Sans MS"
880:                 .FontSize        = 8
881:                 .FontBold        = .T.
882:                 .FontItalic      = .T.
883:                 .ForeColor       = RGB(90, 90, 90)
884:                 .BackColor       = RGB(255, 255, 255)
885:                 .Themes          = .T.
886:                 .PicturePosition = 13
887:                 .SpecialEffect   = 0
888:                 .MousePointer    = 15
889:                 .WordWrap        = .T.
890:                 .AutoSize        = .F.
891:             ENDWITH
892:             BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "CmdCancelarClick")
893: 
894:         CATCH TO loc_oErro
895:             MsgErro("Erro em ConfigurarBotoes: " + loc_oErro.Message + ;
896:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")
897:         ENDTRY

*-- Linhas 1275 a 1290:
1275:             loc_lTemRegistros = .F.
1276:         ENDIF
1277: 
1278:         IF VARTYPE(THIS.cmd_4c_Processar) = "O"
1279:             THIS.cmd_4c_Processar.Enabled = loc_lTemRegistros
1280:         ENDIF
1281:         IF VARTYPE(THIS.cmd_4c_SelTudo) = "O"
1282:             THIS.cmd_4c_SelTudo.Enabled = loc_lTemRegistros
1283:         ENDIF
1284:         IF VARTYPE(THIS.cmd_4c_Apaga) = "O"
1285:             THIS.cmd_4c_Apaga.Enabled = loc_lTemRegistros
1286:         ENDIF
1287:     ENDPROC
1288: 
1289:     *==========================================================================
1290:     PROTECTED PROCEDURE FormParaBO

*-- Linhas 1360 a 1386:
1360:     PROTECTED PROCEDURE HabilitarCampos
1361:     *==========================================================================
1362:         *-- Form OPERACIONAL: grids sao sempre ReadOnly (display-only)
1363:         *-- Apenas o CheckBox da Column1 de grd_4c_GradeOperacao aceita edicao
1364:         *-- Nao ha controles de edicao direta (campos de texto editaveis)
1365:         LPARAMETERS par_lHabilitar
1366:         LOCAL loc_lHabilitar, loc_oErro
1367: 
1368:         IF VARTYPE(par_lHabilitar) = "L"
1369:             loc_lHabilitar = par_lHabilitar
1370:         ELSE
1371:             loc_lHabilitar = .T.
1372:         ENDIF
1373: 
1374:         TRY
1375:             *-- Column1 do grid de operacoes (CheckBox Flag): editavel quando habilitado
1376:             IF VARTYPE(THIS.grd_4c_GradeOperacao) = "O"
1377:                 THIS.grd_4c_GradeOperacao.Column1.ReadOnly = !loc_lHabilitar
1378:             ENDIF
1379:             *-- Botoes de acao
1380:             IF VARTYPE(THIS.cmd_4c_Processar) = "O"
1381:                 THIS.cmd_4c_Processar.Enabled = loc_lHabilitar
1382:             ENDIF
1383: 
1384:         CATCH TO loc_oErro
1385:             MsgErro("Erro em HabilitarCampos: " + loc_oErro.Message + ;
1386:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro SigPrGl2")


### BO (C:\4c\projeto\app\classes\SigPrGl2BO.prg):
*==============================================================================
* SIGPRGL2BO.PRG
* Business Object para Operacoes Selecionadas (SIGPRGL2)
* Herda de BusinessBase
* Processa operacoes selecionadas e gera OPs
*==============================================================================

DEFINE CLASS SigPrGl2BO AS BusinessBase

    *-- Conexao e sessao
    this_oConexao    = .NULL.   && poDataMgr - conexao principal
    this_oConexao2   = .NULL.   && poDataMgr2 - conexao para update/commit
    this_oFormPai    = .NULL.   && referencia ao form pai

    *-- Parametros recebidos na abertura
    this_lReserva      = .F.    && reserva automatica
    this_nEmphPdr      = 0      && empresa padrao do gerente
    this_lAutomatico   = .F.    && processamento automatico
    this_nNumeroDaOp   = 0      && numero da OP a gerar
    this_cPorDestino   = ""     && por destino (de PorDestino do form pai)

    *-- Estado de ordenacao do grid de operacoes
    this_cOrdConta = ""         && 'EMPDOPNUM' ou 'ENTREGA'

    *-- Estado do processamento
    this_lProcessado              = .F.   && .T. apos Processar executado com sucesso
    this_nContadorSelecionadas    = 0     && qtd de operacoes com Flag=.T.

    *-- Dados do registro corrente do TmpCabec
    this_lFlag     = .F.   && checkbox de selecao
    this_cEmps     = ""    && empresa
    this_cDopes    = ""    && tipo de operacao
    this_nNumes    = 0     && numero da operacao
    this_dDatas    = {}    && data de emissao
    this_dEntregas = {}    && data de entrega
    this_nPeso     = 0     && peso total
    this_cContav   = ""    && codigo do responsavel
    this_cConta    = ""    && codigo do cliente
    this_cDConta   = ""    && descricao do cliente
    this_cObs      = ""    && observacao da operacao
    this_cNotas    = ""    && documento fiscal
    this_cJobs     = ""    && codigo do JOB
    this_cGrupoDs  = ""    && grupo de destino
    this_cContaDs  = ""    && conta de destino

    *--------------------------------------------------------------------------
    * INIT
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "EmpDopNums"

            THIS.this_lEmEdicao       = .F.
            THIS.this_lNovoRegistro   = .F.
            THIS.this_lDadosAlterados = .F.
            THIS.this_lProcessado     = .F.
            THIS.this_cMensagemErro   = ""

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContexto - recebe parametros do form pai
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarContexto(par_oFormPai, par_oConexao, par_oConexao2, ;
                                  par_lReserva, par_nEmphPdr, par_lAutomatico, ;
                                  par_nNumeroDaOp, par_cPorDestino)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_oFormPai    = par_oFormPai
            THIS.this_oConexao    = par_oConexao
            THIS.this_oConexao2   = par_oConexao2
            THIS.this_lReserva    = IIF(VARTYPE(par_lReserva)    = "L", par_lReserva,    .F.)
            THIS.this_nEmphPdr    = IIF(VARTYPE(par_nEmphPdr)    = "N", par_nEmphPdr,    0)
            THIS.this_lAutomatico = IIF(VARTYPE(par_lAutomatico) = "L", par_lAutomatico, .F.)
            THIS.this_nNumeroDaOp = IIF(VARTYPE(par_nNumeroDaOp) = "N", par_nNumeroDaOp, 0)
            THIS.this_cPorDestino = IIF(VARTYPE(par_cPorDestino) = "C", ALLTRIM(par_cPorDestino), "")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.ConfigurarContexto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * OrdenarGrade - aplica ordenacao em TmpCabec
    *--------------------------------------------------------------------------
    PROCEDURE OrdenarGrade()
        LOCAL loc_lSucesso, loc_cOrdConta

        loc_lSucesso  = .F.

        TRY
            loc_cOrdConta = UPPER(IIF(VARTYPE(THIS.this_cOrdConta) = "C", THIS.this_cOrdConta, ""))

            IF USED("TmpCabec")
                SELECT TmpCabec
                IF !EMPTY(loc_cOrdConta) AND INLIST(loc_cOrdConta, "ENTREGA", "EMPDOPNUM")
                    SET ORDER TO &loc_cOrdConta.
                ELSE
                    SET ORDER TO EmpDopNum
                    THIS.this_cOrdConta = UPPER(ORDER("TmpCabec"))
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.OrdenarGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DefinirOrdemMovimentacao - ordena TmpCabec por EmpDopNum
    *--------------------------------------------------------------------------
    PROCEDURE DefinirOrdemMovimentacao()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("TmpCabec") AND UPPER(ORDER("TmpCabec")) <> "EMPDOPNUM"
                SELECT TmpCabec
                SET ORDER TO EmpDopNum
                GO TOP
                THIS.this_cOrdConta = UPPER(ORDER("TmpCabec"))
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.DefinirOrdemMovimentacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DefinirOrdemEntrega - ordena TmpCabec por Entrega
    *--------------------------------------------------------------------------
    PROCEDURE DefinirOrdemEntrega()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("TmpCabec") AND UPPER(ORDER("TmpCabec")) <> "ENTREGA"
                SELECT TmpCabec
                SET ORDER TO Entrega
                GO TOP
                THIS.this_cOrdConta = UPPER(ORDER("TmpCabec"))
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.DefinirOrdemEntrega")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SincronizarItens - filtra TmpItens para o registro corrente de TmpCabec
    *--------------------------------------------------------------------------
    PROCEDURE SincronizarItens()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("TmpItens") AND USED("TmpCabec") AND !EOF("TmpCabec")
                SELECT TmpItens
                SET ORDER TO EmpDopNum
                SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.SincronizarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarTodos - marca Flag=.T. em todos os registros de TmpCabec
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarTodos()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("TmpCabec")
                REPLACE ALL Flag WITH .T. IN TmpCabec
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.SelecionarTodos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - marca Flag=.F. em todos os registros de TmpCabec
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("TmpCabec")
                REPLACE ALL Flag WITH .F. IN TmpCabec
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.DesmarcarTodos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSelecao - verifica operacoes selecionadas (Flag=.T.) e mesmo JOB
    * Retorna .T. se valido; .F. com mensagem em this_cMensagemErro
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSelecao()
        LOCAL loc_lSucesso, loc_nContador, loc_cJob

        loc_lSucesso = .F.
        THIS.this_cMensagemErro        = ""
        THIS.this_nContadorSelecionadas = 0

        TRY
            IF !USED("TmpCabec")
                THIS.this_cMensagemErro = "Cursor TmpCabec n" + CHR(227) + "o est" + CHR(225) + ;
                                          " dispon" + CHR(237) + "vel"
                loc_lSucesso = .F.
            ENDIF

            SELECT TmpCabec
            SET ORDER TO EmpDopNum

            loc_nContador = 0
            GO TOP
            loc_cJob = TmpCabec.Jobs

            SCAN FOR Flag
                loc_nContador = loc_nContador + 1
                IF loc_cJob <> TmpCabec.Jobs
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o " + CHR(233) + ;
                        " permitido gerar OPs de opera" + CHR(231) + CHR(245) + ;
                        "es com Jobs diferentes."
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN

            THIS.this_nContadorSelecionadas = loc_nContador

            IF loc_nContador = 0
                THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + "o Foi Selecionada!!!"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.ValidarSelecao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarOperacoes - logica principal do botao Processar
    * Calcula estoque disponivel, monta TmpFinal, abre form de continuidade
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarOperacoes()
        LOCAL loc_lSucesso, loc_cCidQuerys, loc_cQuery
        LOCAL loc_pEdI, loc_pEdF, loc_pItn
        LOCAL loc_nEstoque, loc_nProduzir, loc_nSaldo, loc_xBaixa

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lProcessado   = .F.

        TRY
            *-- 1. Validar selecao
            IF !THIS.ValidarSelecao()
                loc_lSucesso = .F.
            ENDIF

            *-- 2. IDs unicos para cursores temporarios no SQL Server
            loc_cCidQuerys = fUniqueIds()

            *-- 3. Carregar centros de estoque (SigCdCeg sem tipo 1)
            loc_cQuery = "Select * From SigCdCeg Where TpCads <> 1"
            IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpCeg") < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (TmpCeg)")
                loc_lSucesso = .F.
            ENDIF

            *-- 4. Popular CrSigTempd com dados de prioridade de estoque
            IF USED("CrSigTempd")
                USE IN CrSigTempd
            ENDIF
            SET NULL ON
            CREATE CURSOR CrSigTempd (Grupos C(10), Contas C(10), CodObs N(3,0), ;
                                      Emps C(3), CidChaves C(64), CidQuerys C(20))
            SET NULL OFF

            SELECT TmpCeg
            IF RECCOUNT() > 0
                SCAN
                    SELECT CrSigTempd
                    APPEND BLANK
                    REPLACE Grupos    WITH TmpCeg.Grupos, ;
                            Contas    WITH TmpCeg.Contas, ;
                            CodObs    WITH TmpCeg.Priors, ;
                            Emps      WITH TmpCeg.Emps, ;
                            CidChaves WITH fUniqueIds(), ;
                            CidQuerys WITH loc_cCidQuerys
                ENDSCAN
            ELSE
                SELECT CrSigTempd
                APPEND BLANK
                REPLACE Grupos    WITH crSigCdPam.GrupoEsts, ;
                        Contas    WITH crSigCdPam.ContaEsts, ;
                        CodObs    WITH 1, ;
                        Emps      WITH go_4c_Sistema.cCodEmpresa, ;
                        CidChaves WITH fUniqueIds(), ;
                        CidQuerys WITH loc_cCidQuerys
            ENDIF

            *-- 5. Persistir CrSigTempd no SQL Server
            SELECT CrSigTempd
            SCAN
                loc_cQuery = "INSERT INTO SigTempd (Grupos, Contas, CodObs, Emps, " + ;
                             "CidChaves, CidQuerys, Dpros) VALUES (" + ;
                             EscaparSQL(CrSigTempd.Grupos)    + ", " + ;
                             EscaparSQL(CrSigTempd.Contas)    + ", " + ;
                             FormatarNumeroSQL(CrSigTempd.CodObs, 0) + ", " + ;
                             EscaparSQL(CrSigTempd.Emps)      + ", " + ;
                             EscaparSQL(CrSigTempd.CidChaves) + ", " + ;
                             EscaparSQL(CrSigTempd.CidQuerys) + ", " + ;
                             "' ')"
                IF SQLEXEC(gnConnHandle, loc_cQuery) < 1
                    MsgErro("Favor reinicializar o processo.", ;
                            "Falha ao persistir SigTempd")
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN

            *-- 6. Carregar estoque disponivel (SigMvEst + SigTempd - UNION)
            loc_cQuery = "Select a.*, b.CodObs as Priors From SigMvEst a, SigTempd b " + ;
                         "Where a.Grupos = b.Grupos And a.Estos = b.Contas And " + ;
                               "a.Emps = b.Emps And a.Sqtds > 0 " + ;
                         "Union " + ;
                         "Select a.*, b.CodObs as Priors From SigMvEst a, SigTempd b " + ;
                         "Where a.Grupos = b.Grupos And b.Contas = '' And " + ;
                               "a.Emps = b.Emps And a.Sqtds > 0"

            IF USED("TmpEstoque")
                USE IN TmpEstoque
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpEstoque") < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (TmpEstoque)")
                loc_lSucesso = .F.
            ENDIF

            *-- Limpar registro temporario no SQL Server
            SQLEXEC(gnConnHandle, "DELETE FROM SigTempD WHERE CidQuerys = " + EscaparSQL(loc_cCidQuerys))

            *-- 7. Criar cursores de saldo disponivel
            SET NULL ON
            CREATE CURSOR TmpSaldo (CPros C(14), CodCors C(4), CodTams C(4), ;
                                    Saldo N(12,3), Disps N(12,3), Fabrs N(12,3), DispFs N(12,3))
            INDEX ON CPros + CodCors + CodTams TAG CPros
            SET NULL OFF

            SET NULL ON
            CREATE CURSOR TmpSaldg (Emps C(3), Grupos C(10), Estos C(10), CPros C(14), ;
                                    CodCors C(4), CodTams C(4), Saldo N(12,3), Disps N(12,3), ;
                                    Priors N(2,0), Reservs N(12,3))
            INDEX ON CPros + CodCors + CodTams + STR(Priors, 2) + Grupos + Estos + Emps TAG CPros
            INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG GruEstPro
            SET NULL OFF

            *-- 8. Consolidar estoques por produto/cor/tam em TmpSaldo e TmpSaldg
            SELECT TmpEstoque
            SCAN
                SELECT TmpSaldo
                IF !SEEK(TmpEstoque.CPros + TmpEstoque.CodCors + TmpEstoque.CodTams)
                    INSERT INTO TmpSaldo (CPros, CodCors, CodTams, Saldo, Disps) ;
                               VALUES   (TmpEstoque.CPros, TmpEstoque.CodCors, ;
                                         TmpEstoque.CodTams, 0, 0)
                ENDIF
                REPLACE Saldo WITH Saldo + TmpEstoque.Sqtds, ;
                        Disps WITH Disps + TmpEstoque.Sqtds IN TmpSaldo

                INSERT INTO TmpSaldg (Grupos, Estos, CPros, CodCors, CodTams, ;
                                      Saldo, Disps, Priors, Emps) ;
                           VALUES    (TmpEstoque.Grupos, TmpEstoque.Estos, ;
                                      TmpEstoque.CPros, TmpEstoque.CodCors, TmpEstoque.CodTams, ;
                                      TmpEstoque.Sqtds, TmpEstoque.Sqtds, ;
                                      TmpEstoque.Priors, TmpEstoque.Emps)
            ENDSCAN

            *-- 9. Carregar operacao de transferencia de reservas (SigCdOpe)
            IF USED("crSigCdOpe")
                USE IN crSigCdOpe
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT * FROM SigCdOpe WHERE Dopes = " + ;
                    EscaparSQL(crSigCdPam.TransfRes), "crSigCdOpe")

            *-- 10. Descontar estoques ja reservados em andamento
            IF !EMPTY(crSigCdPam.TransfRes) AND !EOF("crSigCdOpe") AND (crSigCdOpe.Estoqs <> 1)
                loc_pEdI = go_4c_Sistema.cCodEmpresa + crSigCdPam.TransfRes + STR(0, 6)
                loc_pEdF = go_4c_Sistema.cCodEmpresa + crSigCdPam.TransfRes + STR(999999, 6)

                loc_cQuery = "Select EmpDopNums, GrupoOs, ContaOs, Emps, Dopes, Numes " + ;
                             "From SigMvCab " + ;
                             "Where EmpDopNums Between " + EscaparSQL(loc_pEdI) + ;
                             " And " + EscaparSQL(loc_pEdF) + ;
                             " Order By EmpDopNums"

                IF USED("TempEest")
                    USE IN TempEest
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cQuery, "TempEest") < 1
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (TempEest)")
                    loc_lSucesso = .F.
                ENDIF

                SELECT TempEest
                SCAN
                    loc_cEdn = TempEest.EmpDopNums
                    IF USED("TempEestI")
                        USE IN TempEestI
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigMvItn WHERE EmpDopNums = " + ;
                            EscaparSQL(loc_cEdn), "TempEestI")

                    SELECT TempEestI
                    SCAN
                        IF (Qtds - QtBaixas > 0)
                            loc_pItn = TempEestI.CItens

                            loc_cQuery = "Select * " + ;
                                         "From SigMvIts " + ;
                                         "Where EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                                         " And CItens = " + FormatarNumeroSQL(loc_pItn, 0)

                            IF USED("TempEsti2")
                                USE IN TempEsti2
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_cQuery, "TempEsti2") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                        "Falha na Conex" + CHR(227) + "o (TempEsti2)")
                                loc_lSucesso = .F.
                            ENDIF

                            SELECT TempEsti2
                            GO TOP

                            IF EOF("TempEsti2")
                                SELECT TmpSaldo
                                IF !SEEK(TempEestI.CPros)
                                    INSERT INTO TmpSaldo (CPros) VALUES (TempEestI.CPros)
                                ENDIF
                                REPLACE Saldo WITH Saldo - (TempEestI.Qtds - TempEestI.QtBaixas), ;
                                        Disps WITH Disps - (TempEestI.Qtds - TempEestI.QtBaixas)

                                SELECT TmpSaldg
                                SET ORDER TO GruEstPro
                                IF !SEEK(TempEest.Emps + TempEest.GrupoOs + ;
                                         TempEest.ContaOs + TempEestI.CPros)
                                    INSERT INTO TmpSaldg (Emps, Grupos, Estos, CPros, Priors) ;
                                               VALUES   (TempEest.Emps, TempEest.GrupoOs, ;
                                                         TempEest.ContaOs, TempEestI.CPros, 99)
                                ENDIF
                                REPLACE Saldo WITH Saldo - (TempEestI.Qtds - TempEestI.QtBaixas), ;
                                        Disps WITH Disps - (TempEestI.Qtds - TempEestI.QtBaixas)
                            ELSE
                                SELECT TempEsti2
                                SCAN
                                    loc_nSaldo = TempEsti2.Qtds - TempEsti2.QtBaixas

                                    SELECT TmpSaldo
                                    IF !SEEK(TempEsti2.CPros + TempEsti2.CodCors + TempEsti2.CodTams)
                                        INSERT INTO TmpSaldo (CPros, CodCors, CodTams) ;
                                                   VALUES   (TempEsti2.CPros, ;
                                                             TempEsti2.CodCors, TempEsti2.CodTams)
                                    ENDIF
                                    REPLACE Saldo WITH Saldo - loc_nSaldo, ;
                                            Disps WITH Disps - loc_nSaldo

                                    SELECT TmpSaldg
                                    SET ORDER TO GruEstPro
                                    IF !SEEK(TempEest.Emps + TempEest.GrupoOs + ;
                                             TempEest.ContaOs + TempEsti2.CPros + ;
                                             TempEsti2.CodCors + TempEsti2.CodTams)
                                        INSERT INTO TmpSaldg (Emps, Grupos, Estos, ;
                                                              CPros, CodCors, CodTams, Priors) ;
                                                   VALUES   (TempEest.Emps, TempEest.GrupoOs, ;
                                                             TempEest.ContaOs, TempEsti2.CPros, ;
                                                             TempEsti2.CodCors, TempEsti2.CodTams, 99)
                                    ENDIF
                                    REPLACE Saldo WITH Saldo - loc_nSaldo, ;
                                            Disps WITH Disps - loc_nSaldo
                                ENDSCAN
                            ENDIF
                        ENDIF
                    ENDSCAN
                ENDSCAN
            ENDIF

            *-- 11. Montar TmpFinal com itens das operacoes selecionadas
            SET NULL ON
            CREATE CURSOR TmpFinal (Emps C(3), Dopes C(20), Numes N(6,0), CPros C(14), ;
                                    Qtds N(10,3), Peso N(9,3), Saldo N(10,3), ;
                                    Estoque N(10,3), Produzir N(10,3), ;
                                    Obs M NULL, Obsps M NULL, ;
                                    Datas D NULL, Entregas D NULL, ;
                                    CodCors C(4), CodTams C(4), Linhas C(10), ;
                                    Citens N(10,0), Reffs C(40), Notas C(6), ;
                                    Dpros C(40), GrupoDs C(10), ContaDs C(10), ;
                                    KeySelM L, Fabrs N(10,3), KeyPdes L, Jobs C(10))
            INDEX ON CPros + CodCors + CodTams TAG CPros
            SET NULL OFF

            SELECT TmpItens
            SET KEY TO
            SET ORDER TO CPros

            SCAN
                SELECT TmpCabec
                SEEK TmpItens.Emps + TmpItens.Dopes + STR(TmpItens.Numes, 6)
                IF !Flag
                    LOOP
                ENDIF

                SELECT TmpOper
                SEEK TmpItens.Dopes

                SELECT TmpItens
                IF (Saldo > 0)
                    loc_nEstoque  = 0
                    loc_nProduzir = 0

                    IF (TmpOper.ChkObs <> 1 AND !EMPTY(TmpItens.Obs)) OR ;
                       !SEEK(TmpItens.CPros + TmpItens.CodCors + TmpItens.CodTams, "TmpSaldo") OR ;
                       EMPTY(crSigCdPam.TransfRes) OR ;
                       (TmpOper.Reservas = 2 AND !THIS.this_lReserva) OR ;
                       TmpSaldo.Disps < 0
                        loc_nProduzir = TmpItens.Saldo
                    ELSE
                        =SEEK(TmpItens.CPros + TmpItens.CodCors + TmpItens.CodTams, "TmpSaldo")
                        loc_nEstoque = TmpSaldo.Disps
                        IF (TmpSaldo.Disps >= TmpItens.Saldo)
                            REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - TmpItens.Saldo
                        ELSE
                            loc_nProduzir = TmpItens.Saldo - TmpSaldo.Disps
                            REPLACE TmpSaldo.Disps WITH 0
                        ENDIF
                    ENDIF

                    IF USED("crSigCdPro")
                        USE IN crSigCdPro
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPro WHERE CPros = " + ;
                            EscaparSQL(TmpItens.CPros), "crSigCdPro")

                    INSERT INTO TmpFinal (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, ;
                                          Estoque, Produzir, Obsps, Obs, Datas, Entregas, ;
                                          CodCors, CodTams, Linhas, Citens, Reffs, Notas, ;
                                          Dpros, GrupoDs, ContaDs, Jobs) ;
                               VALUES   (TmpItens.Emps, TmpItens.Dopes, TmpItens.Numes, ;
                                          TmpItens.CPros, TmpItens.Qtds, TmpItens.Peso, ;
                                          TmpItens.Saldo, TmpItens.Saldo - loc_nProduzir, ;
                                          loc_nProduzir, NVL(TmpItens.Obs, ""), ;
                                          NVL(TmpCabec.Obs, ""), ;
                                          NVL(TmpCabec.Datas, CTOD("")), ;
                                          NVL(TmpCabec.Entregas, CTOD("")), ;
                                          TmpItens.CodCors, TmpItens.CodTams, ;
                                          TmpItens.Linhas, TmpItens.CItens, ;
                                          crSigCdPro.Reffs, TmpItens.Notas, ;
                                          TmpItens.Dpros, TmpCabec.GrupoDs, ;
                                          TmpCabec.ContaDs, TmpCabec.Jobs)
                ENDIF
            ENDSCAN

            *-- 12. Distribuir diferenca de saldo entre grupos (TmpSaldg)
            SELECT TmpSaldo
            SCAN
                IF Saldo # Disps
                    loc_xBaixa = Saldo - Disps
                    SELECT TmpSaldg
                    SET ORDER TO CPros
                    =SEEK(TmpSaldo.CPros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                    SCAN WHILE CPros = TmpSaldo.CPros AND CodCors = TmpSaldo.CodCors AND ;
                               CodTams = TmpSaldo.CodTams AND loc_xBaixa > 0
                        IF TmpSaldg.Disps >= loc_xBaixa
                            REPLACE TmpSaldg.Disps WITH TmpSaldg.Disps - loc_xBaixa
                            loc_xBaixa = 0
                        ELSE
                            loc_xBaixa = loc_xBaixa - TmpSaldg.Disps
                            REPLACE TmpSaldg.Disps WITH 0
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDSCAN

            *-- 13. Se DopEsts configurado: calcular estoque em fabricacao
            IF !EMPTY(crSigCdPac.DopEsts)
                THIS.ProcessarFabrico(loc_cCidQuerys)
            ENDIF

            *-- 14. Restaurar filtro de TmpItens para sincronismo com TmpCabec
            SELECT TmpItens
            SET ORDER TO EmpDopNum
            SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
            GO TOP

            THIS.this_lProcessado = .T.
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.ProcessarOperacoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarFabrico - calcula estoque em fabricacao e monta TmpFinalG
    * Chamado internamente por ProcessarOperacoes quando DopEsts nao vazio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarFabrico(par_cCidQuerys)
        LOCAL loc_lSucesso, loc_cSql, loc_llFalse, loc_llData
        LOCAL loc_nEstoque, loc_nProduzir, loc_xBaixa, loc_cEdn

        loc_lSucesso = .F.
        loc_llFalse  = .F.

        TRY
            SET NULL ON
            CREATE CURSOR TmpFabr (Priors N(2,0), Nops N(10,0), Fases C(10), ;
                                   CPros C(14), CodCors C(4), CodTams C(4), ;
                                   Qtds N(10,3), Disps N(12,3), Reservs N(12,3))
            INDEX ON CPros + CodCors + CodTams + STR(Priors, 2) + STR(Nops, 10) TAG CPros
            SET NULL OFF

            loc_cSql = "Select a.Nops, a.Cpros, a.CodCors, a.CodTams, sum(a.Qtds) as Qtds " + ;
                       "From SigOpPic a, SigCdNec b " + ;
                       "Where a.Dopes = " + EscaparSQL(crSigCdPac.DopEsts) + ;
                       " And a.EmpDopNops = b.EmpDnps And b.Chksubn = 0" + ;
                       " And a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " group by a.Nops, a.Cpros, a.CodCors, a.CodTams"

            IF USED("TmpOpi")
                USE IN TmpOpi
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSql, "TmpOpi")

            SELECT TmpOpi
            SCAN
                SELECT TmpSaldo
                IF !SEEK(TmpOpi.CPros + TmpOpi.CodCors + TmpOpi.CodTams)
                    INSERT INTO TmpSaldo (CPros, CodCors, CodTams) ;
                               VALUES   (TmpOpi.CPros, TmpOpi.CodCors, TmpOpi.CodTams)
                ENDIF
                REPLACE Fabrs  WITH Fabrs  + TmpOpi.Qtds, ;
                        DispFs WITH DispFs + TmpOpi.Qtds IN TmpSaldo

                INSERT INTO TmpFabr (Nops, CPros, CodCors, CodTams, Qtds, Priors) ;
                           VALUES   (TmpOpi.Nops, TmpOpi.CPros, TmpOpi.CodCors, ;
                                     TmpOpi.CodTams, TmpOpi.Qtds, 0)

                loc_cSql = "Select GrupoDs From SigPdMvf Where Nops = " + ;
                           TRANSFORM(TmpOpi.Nops) + " Order by CidChaves Desc"
                IF USED("TmpMfas")
                    USE IN TmpMfas
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSql, "TmpMfas")

                SELECT TmpMfas
                GO TOP
                REPLACE Fases WITH TmpMfas.GrupoDs IN TmpFabr

                loc_nEstoque  = 0
                loc_nProduzir = 0

                IF SEEK(TmpOpi.CPros + TmpOpi.CodCors + TmpOpi.CodTams, "TmpFinal", "CPros")
                    IF TmpSaldo.Fabrs >= TmpFinal.Produzir
                        loc_nEstoque  = TmpFinal.Produzir
                        loc_nProduzir = 0
                        REPLACE TmpSaldo.DispFs WITH TmpSaldo.DispFs - TmpFinal.Produzir IN TmpSaldo
                    ELSE
                        loc_nEstoque  = TmpSaldo.Fabrs
                        loc_nProduzir = TmpFinal.Produzir - TmpSaldo.Fabrs
                        REPLACE DispFs WITH 0 IN TmpSaldo
                    ENDIF
                    REPLACE Produzir WITH loc_nProduzir, ;
                            Fabrs    WITH loc_nEstoque IN TmpFinal
                ENDIF
            ENDSCAN

            *-- Distribuir fabricacao por grupo (TmpFabr)
            SELECT TmpSaldo
            SCAN
                IF Fabrs # DispFs
                    loc_xBaixa = Fabrs - DispFs
                    SELECT TmpFabr
                    SET ORDER TO CPros
                    =SEEK(TmpSaldo.CPros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                    SCAN WHILE CPros = TmpSaldo.CPros AND CodCors = TmpSaldo.CodCors AND ;
                               CodTams = TmpSaldo.CodTams AND loc_xBaixa > 0
                        IF (TmpFabr.Qtds - TmpFabr.Disps) >= loc_xBaixa
                            REPLACE TmpFabr.Disps WITH TmpFabr.Disps + loc_xBaixa IN TmpFabr
                            loc_xBaixa = 0
                        ELSE
                            loc_xBaixa = loc_xBaixa - (TmpFabr.Qtds - TmpFabr.Disps)
                            REPLACE TmpFabr.Disps WITH Qtds IN TmpFabr
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDSCAN

            *-- Montar TmpFinalG (agrupado por produto/cor/tam)
            SET NULL ON
            CREATE CURSOR TmpFinalG (Flag C(1), CPros C(14), CodCors C(4), CodTams C(4), ;
                                     Linhas C(10), Qtds N(10,3), Saldo N(10,3), ;
                                     Estoque N(10,3), Produzir N(10,3), Fabrs N(10,3), ;
                                     Produzir2 N(10,3), TotVenda N(10,3), QtdMins N(10,3), ;
                                     KeySelM L, KeySelMP L, UsuLibs C(10))
            INDEX ON CPros + CodCors + CodTams TAG CPros
            SET NULL OFF

            SELECT CPros, CodCors, CodTams, Linhas, ;
                   SUM(Qtds)     AS Qtds, ;
                   SUM(Saldo)    AS Saldo, ;
                   SUM(Estoque)  AS Estoque, ;
                   SUM(Produzir) AS Produzir, ;
                   SUM(Fabrs)    AS Fabrs ;
            FROM TmpFinal ;
            INTO CURSOR Selecao ;
            GROUP BY CPros, CodCors, CodTams, Linhas

            *-- Historico de vendas (se nMeses configurado)
            IF crSigCdPac.nMeses > 0
                loc_llData = GOMONTH(DATE(), -crSigCdPac.nMeses)

                loc_cSql = "Select a.cpros, a.qtds, b.Caixas, b.copers, b.opers, a.opers " + ;
                           "From SigMvItn a, SigCdOpe b, SigMvCab c " + ;
                           "Where a.EmpDopNums = c.EmpDopNums And a.Emps = " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa) + " And c.datas >= " + ;
                           FormatarDataSQL(loc_llData) + ;
                           " And a.dopes = b.dopes and b.tipoops in(4,5)"

                IF USED("LocalEest")
                    USE IN LocalEest
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSql, "LocalEest")

                SELECT CPros, ;
                       SUM(Qtds * IIF((Caixas = 1 AND copers = 1) OR ;
                                      (Caixas <> 1 AND Opers = 1) OR ;
                                      (Caixas <> 1 AND Opers = 3), 1, -1)) AS Qtds ;
                FROM LocalEest ;
                GROUP BY CPros ;
                INTO CURSOR Vendas READWRITE

                SELECT Vendas
                INDEX ON CPros TAG CPros
            ENDIF

            *-- Popular TmpFinalG
            SELECT TmpFinalG
            SCATTER MEMVAR BLANK

            SELECT Selecao
            SCAN
                SCATTER MEMVAR
                m.flag = "+"

                loc_cSql = "Select QtMinFabs From SigCdPro Where Cpros = " + EscaparSQL(Selecao.CPros)
                IF USED("CrSigCdPro")
                    USE IN CrSigCdPro
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSql, "CrSigCdPro")

                m.QtdMins = 0
                IF (crSigCdPac.GerPcps = 2 AND !THIS.this_lReserva) OR ;
                   (crSigCdPac.GerPcps <> 2 AND THIS.this_lReserva)
                    m.QtdMins = crSigCdPro.QtMinFabs
                ENDIF

                IF USED("Vendas") AND SEEK(m.CPros, "Vendas", "CPros")
                    m.TotVenda = Vendas.Qtds
                ELSE
                    m.TotVenda = 0
                ENDIF

                m.Produzir2 = IIF(m.QtdMins > 0 AND m.Produzir > 0 AND ;
                                  m.Produzir < m.QtdMins, ;
                                  m.QtdMins - m.Produzir, 0)

                SELECT TmpFinalG
                APPEND BLANK
                GATHER MEMVAR
            ENDSCAN

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.ProcessarFabrico")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - popula propriedades do BO com o registro corrente
    * par_cAliasCursor: alias do cursor fonte (TmpCabec)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_lFlag     = NVL(Flag,     .F.)
                THIS.this_cEmps     = ALLTRIM(NVL(Emps,     ""))
                THIS.this_cDopes    = ALLTRIM(NVL(Dopes,    ""))
                THIS.this_nNumes    = NVL(Numes,    0)
                THIS.this_dDatas    = NVL(Datas,    {})
                THIS.this_dEntregas = NVL(Entregas, {})
                THIS.this_nPeso     = NVL(Peso,     0)
                THIS.this_cContav   = ALLTRIM(NVL(Contav,   ""))
                THIS.this_cConta    = ALLTRIM(NVL(Conta,    ""))
                THIS.this_cDConta   = ALLTRIM(NVL(DConta,   ""))
                THIS.this_cObs      = NVL(Obs,      "")
                THIS.this_cNotas    = ALLTRIM(NVL(Notas,    ""))
                THIS.this_cJobs     = ALLTRIM(NVL(Jobs,     ""))
                THIS.this_cGrupoDs  = ALLTRIM(NVL(GrupoDs,  ""))
                THIS.this_cContaDs  = ALLTRIM(NVL(ContaDs,  ""))
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave no formato EmpDopNum (C(29))
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmps) + ;
               ALLTRIM(THIS.this_cDopes) + ;
               STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigMvCab com as propriedades correntes
    * Executa auditoria apos gravacao bem-sucedida
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cChave = ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cDopes) + ;
                         STR(THIS.this_nNumes, 6)

            loc_cSQL = "INSERT INTO SigMvCab (" + ;
                       "Emps, Dopes, Numes, EmpDopNums, " + ;
                       "Datas, Entregas, PbRus, " + ;
                       "Contav, IClis, NEmps, " + ;
                       "Notas, Jobs, GrupoDs, ContaDs, Obses" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       FormatarDataSQL(THIS.this_dEntregas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPeso, 3) + ", " + ;
                       EscaparSQL(THIS.this_cContav) + ", " + ;
                       EscaparSQL(THIS.this_cConta) + ", " + ;
                       EscaparSQL(THIS.this_cDConta) + ", " + ;
                       EscaparSQL(THIS.this_cNotas) + ", " + ;
                       EscaparSQL(THIS.this_cJobs) + ", " + ;
                       EscaparSQL(THIS.this_cGrupoDs) + ", " + ;
                       EscaparSQL(THIS.this_cContaDs) + ", " + ;
                       EscaparSQL(THIS.this_cObs) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir registro em SigMvCab"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em Inserir: " + loc_oErro.Message + ;
                                       " LN=" + TRANSFORM(loc_oErro.LineNo)
            MsgErro(THIS.this_cMensagemErro, "Erro SigPrGl2BO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigMvCab com as propriedades correntes
    * Executa auditoria apos gravacao bem-sucedida
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cChave = ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cDopes) + ;
                         STR(THIS.this_nNumes, 6)

            loc_cSQL = "UPDATE SigMvCab SET " + ;
                       "Datas = "    + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       "Entregas = " + FormatarDataSQL(THIS.this_dEntregas) + ", " + ;
                       "PbRus = "    + FormatarNumeroSQL(THIS.this_nPeso, 3) + ", " + ;
                       "Contav = "   + EscaparSQL(THIS.this_cContav) + ", " + ;
                       "IClis = "    + EscaparSQL(THIS.this_cConta) + ", " + ;
                       "NEmps = "    + EscaparSQL(THIS.this_cDConta) + ", " + ;
                       "Notas = "    + EscaparSQL(THIS.this_cNotas) + ", " + ;
                       "Jobs = "     + EscaparSQL(THIS.this_cJobs) + ", " + ;
                       "GrupoDs = "  + EscaparSQL(THIS.this_cGrupoDs) + ", " + ;
                       "ContaDs = "  + EscaparSQL(THIS.this_cContaDs) + ", " + ;
                       "Obses = "    + EscaparSQL(THIS.this_cObs) + ", " + ;
                       "DtAlts = GETDATE() " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(loc_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar registro em SigMvCab"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em Atualizar: " + loc_oErro.Message + ;
                                       " LN=" + TRANSFORM(loc_oErro.LineNo)
            MsgErro(THIS.this_cMensagemErro, "Erro SigPrGl2BO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigMvCab pela chave EmpDopNums
    * Executa auditoria apos exclusao bem-sucedida
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cChave = ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cDopes) + ;
                         STR(THIS.this_nNumes, 6)

            THIS.RegistrarAuditoria("DELETE")

            loc_cSQL = "DELETE FROM SigMvCab " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(loc_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao excluir registro em SigMvCab"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em ExecutarExclusao: " + loc_oErro.Message + ;
                                       " LN=" + TRANSFORM(loc_oErro.LineNo)
            MsgErro(THIS.this_cMensagemErro, "Erro SigPrGl2BO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EncerrarForm - libera referencia ao form pai e restaura Enabled
    *--------------------------------------------------------------------------
    PROCEDURE EncerrarForm()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O" AND !ISNULL(THIS.this_oFormPai)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SigPrGl2BO.EncerrarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - limpa referencias ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oConexao  = .NULL.
        THIS.this_oConexao2 = .NULL.
        THIS.this_oFormPai  = .NULL.
    ENDPROC

ENDDEFINE

