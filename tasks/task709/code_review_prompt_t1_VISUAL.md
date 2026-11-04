# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCPE.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2305 linhas total):

*-- Linhas 40 a 49:
40: * comportamento.json). Inventar Page1/Grid/5 botoes CRUD (Incluir/
41: * Visualizar/Alterar/Excluir/Buscar) violaria o PILAR 1 (UX identica ao
42: * legado). O trabalho real daquela fase foi completar ConfigurarBotoes()
43: * com os 2 botoes reais: cmd_4c_Confirmar (Ok, Left=649 absoluto /
44: * Left=0 relativo ao container) e cmd_4c_Encerrar (cancela, Left=725
45: * absoluto / Left=76 relativo).
46: *
47: * FASE 5/8: ConfigurarCamposPrincipais() - COLUNA
48: * ESQUERDA, 14 dos 31 controles de dados. O template desta fase pede
49: * "primeiros 50% dos campos da Page2 + container cnt_4c_Cabecalho"; aqui

*-- Linhas 113 a 121:
113: *     -> properties do BO. Chamado pelo BtnConfirmarClick antes de gravar.
114: *   - BtnCancelarClick() - o SIGOPCPE.cancela.Click sob o nome do objeto
115: *     legado, delegando ao BtnEncerrarClick (que eh o nome do objeto do
116: *     migrado, cmd_4c_Encerrar, e eh quem o BINDEVENT liga).
117: *
118: * O template desta fase pede tambem BtnBuscarClick, BtnSalvarClick,
119: * HabilitarCampos, LimparCampos e AjustarBotoesPorModo. Os cinco sao
120: * convencao de form CRUD (frmcadastro) e NAO SE APLICAM a esta tela, pelo
121: * que o dump mostra:

*-- Linhas 270 a 341:
270:     * Transcrito EXATO do dump (SECAO 2 - SIGOPCPE.cntSombra/lblSombra/
271:     * lblTitulo): Top=0 Left=7 Width=800 Height=80 BackColor=RGB(100,100,100).
272:     * As duas labels tem o Caption sobrescrito pelo Init legado
273:     * ("ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption") - aqui
274:     * atribuido direto, sem passar por caption placeholder do dump
275:     * ("Cadastro de Testes", resto de outro form usado como base no Form
276:     * Designer do legado).
277:     *==========================================================================
278:     PROTECTED PROCEDURE ConfigurarCabecalho()
279:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
280:         WITH THIS.cnt_4c_Cabecalho
281:             .Top         = 0
282:             .Left        = 7
283:             .Width       = THIS.Width
284:             .Height      = 80
285:             .BackStyle   = 1
286:             .BackColor   = RGB(100, 100, 100)
287:             .BorderWidth = 0
288:             .Visible     = .T.
289:         ENDWITH
290: 
291:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
292:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
293:             .Top         = 18
294:             .Left        = 10
295:             .Width       = 769
296:             .Height      = 40
297:             .FontName    = "Tahoma"
298:             .FontSize    = 18
299:             .FontBold    = .T.
300:             .FontUnderline = .F.
301:             .ForeColor   = RGB(0, 0, 0)
302:             .BackStyle   = 0
303:             .WordWrap    = .T.
304:             .AutoSize    = .F.
305:             .Alignment   = 0
306:             .Caption     = THIS.Caption
307:             .Visible     = .T.
308:         ENDWITH
309: 
310:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
311:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
312:             .Top         = 17
313:             .Left        = 10
314:             .Width       = 769
315:             .Height      = 46
316:             .FontName    = "Tahoma"
317:             .FontSize    = 18
318:             .FontBold    = .T.
319:             .ForeColor   = RGB(255, 255, 255)
320:             .BackStyle   = 0
321:             .WordWrap    = .T.
322:             .AutoSize    = .F.
323:             .Alignment   = 0
324:             .Caption     = THIS.Caption
325:             .Visible     = .T.
326:         ENDWITH
327:     ENDPROC
328: 
329:     *==========================================================================
330:     * ConfigurarBotoes - Container na posicao dos botoes Ok/cancela do
331:     * legado (Ok Left=649/Top=3, cancela Left=725/Top=3 - ambos filhos
332:     * DIRETOS do form no SCX, sem CommandGroup). Container cobre a faixa
333:     * 649..800 (Width=151) na mesma Top=0/Height=85 dos botoes framework
334:     * padrao (75x75 + margem).
335:     *
336:     * cmd_4c_Confirmar (Ok) e cmd_4c_Encerrar (cancela) - posicoes
337:     * RELATIVAS ao container, preservando o espacamento exato do legado:
338:     * cancela.Left(725) - Ok.Left(649) = 76, que eh exatamente
339:     * Width(75) + 1px de vao dentro dos 151px do container (0+75=75,
340:     * 76+75=151). Caption/Picture canonicos (regra CLAUDE.md #10):
341:     * Confirmar = cadastro_salvar_60.jpg, Encerrar = cadastro_sair_60.jpg.

*-- Linhas 347 a 370:
347:     PROTECTED PROCEDURE ConfigurarBotoes()
348:         THIS.AddObject("cnt_4c_Botoes", "Container")
349:         WITH THIS.cnt_4c_Botoes
350:             .Top         = 0
351:             .Left        = 649
352:             .Width       = 151
353:             .Height      = 85
354:             .BackStyle   = 0
355:             .BorderWidth = 0
356:             .Visible     = .T.
357:         ENDWITH
358: 
359:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_Confirmar", "CommandButton")
360:         WITH THIS.cnt_4c_Botoes.cmd_4c_Confirmar
361:             .Top            = 5
362:             .Left           = 0
363:             .Width          = 75
364:             .Height         = 75
365:             .Caption        = "Confirmar"
366:             .Picture        = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
367:             .FontName       = "Comic Sans MS"
368:             .FontSize       = 8
369:             .FontBold       = .T.
370:             .FontItalic     = .T.

*-- Linhas 379 a 393:
379:             .Visible        = .T.
380:         ENDWITH
381: 
382:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_Encerrar", "CommandButton")
383:         WITH THIS.cnt_4c_Botoes.cmd_4c_Encerrar
384:             .Top            = 5
385:             .Left           = 76
386:             .Width          = 75
387:             .Height         = 75
388:             .Caption        = "Encerrar"
389:             .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
390:             .FontName       = "Comic Sans MS"
391:             .FontSize       = 8
392:             .FontBold       = .T.
393:             .FontItalic     = .T.

*-- Linhas 415 a 429:
415:     *
416:     * Entregues AQUI (par label + controle, na ordem visual de cima para
417:     * baixo), com o nome de objeto EXATO do tasks\task709\mapeamento.json:
418:     *   Say6  / Cmb_Tipo   -> lbl_4c_Label6 / cbo_4c_Cmb_Tipo   (Top 110/106)
419:     *   Say1  / Spinner1   -> lbl_4c_Label1 / obj_4c_Spinner1   (Top 136/132)
420:     *   Say2  / Cmb_Hand   -> lbl_4c_Label2 / cbo_4c_Cmb_Hand   (Top 163/159)
421:     *   Say3  / Get_Set    -> lbl_4c_Label3 / txt_4c_Set        (Top 188/185)
422:     *   Say4  / chk_dtr    -> lbl_4c_Label4 / chk_4c_Chk_dtr    (Top 210/210)
423:     *   Say5  / chk_rts    -> lbl_4c_Label5 / chk_4c_Chk_rts    (Top 230/230)
424:     *   Say7  / Get_inbuf  -> lbl_4c_Label7 / txt_4c_Inbuf      (Top 252/249)
425:     *
426:     * Fica para a FASE 6 (coluna direita, 17 controles): Say8/Get_outbuf,
427:     * Say9/Get_inmode, Say11, Say10/Get_inlen (bloco numerico sempre
428:     * visivel) e os dois blocos CONDICIONAIS - Say12/Get_TpLeChq,
429:     * Say14/Chk_Bompara, Say15/chk_nominal, Say16/chk_cruzado (cheque) e

*-- Linhas 435 a 443:
435:     * SEM compensacao de Top: este form nao tem PageFrame nenhum (os
436:     * controles sao filhos DIRETOS do form), logo os Top do SCX sao
437:     * ABSOLUTOS e entram como estao - nao existe aqui o +29 do
438:     * pgf_4c_Paginas.Top = -29 dos forms CRUD. A faixa do cabecalho ocupa
439:     * Top 0..80 e o primeiro controle de dados esta em Top = 106, entao
440:     * nada fica soterrado e nao ha re-layout a fazer.
441:     *
442:     * ControlSource TRANSCRITO do SCX: o legado liga cada controle direto ao
443:     * cursor (ControlSource = "crSigSyCom.<coluna>") e eh esse binding que

*-- Linhas 471 a 479:
471:     *                  DisabledBackColor 192,192,192 / DisabledForeColor 0,0,0
472:     *   fwcombo     -> Height 24, Width 100, Style 2 (dropdown LIST),
473:     *                  Themes .F., DisabledForeColor 0,0,0
474:     *   fwcheckbox  -> Height 17, Width 60, Alignment 0, BackStyle 0,
475:     *                  ForeColor 90,90,90, Themes .F.
476:     * NAO sao atribuidas BackStyle em ComboBox/Spinner nem ForeColor em
477:     * Spinner-grupo: ComboBox e Spinner nao TEM BackStyle (conferido em
478:     * automation\propriedades_baseclasses.txt - CLAUDE.md regra #33).
479:     *

*-- Linhas 494 a 505:
494:         * lidos do BO (SIGOPCPEBO.ObterTipoPorIndice) para nao duplicar aqui
495:         * os literais com CHR() de Balanca (CLAUDE.md regra #4).
496:         *----------------------------------------------------------------------
497:         THIS.AddObject("lbl_4c_Label6", "Label")
498:         WITH THIS.lbl_4c_Label6
499:             .Top       = 110
500:             .Left      = 117
501:             *-- Width = 152 (Left do Cmb_Tipo) - 117: eh o vao que o legado
502:             *-- reservou para este texto. A classe say eh AutoSize = .T. /
503:             *-- Alignment = 0, mas AutoSize eh NO-OP em Label criado por
504:             *-- AddObject (fica nos 100 do default), por isso Width e Height
505:             *-- explicitos e Alignment = 0 (CLAUDE.md regra #23).

*-- Linhas 512 a 527:
512:             .FontName  = "Tahoma"
513:             .FontSize  = 8
514:             .ForeColor = RGB(90, 90, 90)
515:             .Caption   = "Tipo : "
516:             .Visible   = .T.
517:         ENDWITH
518: 
519:         THIS.AddObject("cbo_4c_Cmb_Tipo", "ComboBox")
520:         WITH THIS.cbo_4c_Cmb_Tipo
521:             .Top               = 106
522:             .Left              = 152
523:             .Width             = 168
524:             .Height            = 24
525:             .FontName          = "Tahoma"
526:             .FontSize          = 8
527:             .ForeColor         = RGB(90, 90, 90)

*-- Linhas 567 a 596:
567:         * setas (SpinnerLow/HighValue) quanto pelo teclado (KeyboardLow/
568:         * HighValue), com Value inicial 1 - transcrito do dump.
569:         *----------------------------------------------------------------------
570:         THIS.AddObject("lbl_4c_Label1", "Label")
571:         WITH THIS.lbl_4c_Label1
572:             .Top       = 136
573:             .Left      = 30
574:             .Width     = 122
575:             .Height    = 15
576:             .AutoSize  = .F.
577:             .Alignment = 0
578:             .WordWrap  = .F.
579:             .BackStyle = 0
580:             .FontName  = "Tahoma"
581:             .FontSize  = 8
582:             .ForeColor = RGB(90, 90, 90)
583:             *-- "Porta de Comunicacao : "  CHR(231)=c-cedilha CHR(227)=a-tilde
584:             .Caption   = "Porta de Comunica" + CHR(231) + CHR(227) + "o : "
585:             .Visible   = .T.
586:         ENDWITH
587: 
588:         THIS.AddObject("obj_4c_Spinner1", "Spinner")
589:         WITH THIS.obj_4c_Spinner1
590:             .Top               = 132
591:             .Left              = 152
592:             .Width             = 48
593:             .Height            = 25
594:             .FontName          = "Tahoma"
595:             .FontSize          = 8
596:             .ForeColor         = RGB(90, 90, 90)

*-- Linhas 622 a 650:
622:         * - e o item em branco existe para permitir deixar o campo sem
623:         * protocolo nenhum.
624:         *----------------------------------------------------------------------
625:         THIS.AddObject("lbl_4c_Label2", "Label")
626:         WITH THIS.lbl_4c_Label2
627:             .Top       = 163
628:             .Left      = 75
629:             .Width     = 77
630:             .Height    = 15
631:             .AutoSize  = .F.
632:             .Alignment = 0
633:             .WordWrap  = .F.
634:             .BackStyle = 0
635:             .FontName  = "Tahoma"
636:             .FontSize  = 8
637:             .ForeColor = RGB(90, 90, 90)
638:             .Caption   = "HandShaking : "
639:             .Visible   = .T.
640:         ENDWITH
641: 
642:         THIS.AddObject("cbo_4c_Cmb_Hand", "ComboBox")
643:         WITH THIS.cbo_4c_Cmb_Hand
644:             .Top               = 159
645:             .Left              = 152
646:             .Width             = 163
647:             .Height            = 24
648:             .FontName          = "Tahoma"
649:             .FontSize          = 8
650:             .ForeColor         = RGB(90, 90, 90)

*-- Linhas 683 a 711:
683:         * vazia esta em SIGOPCPEBO.this_cSettingsPadrao e eh aplicado na
684:         * carga do cursor, nao aqui.
685:         *----------------------------------------------------------------------
686:         THIS.AddObject("lbl_4c_Label3", "Label")
687:         WITH THIS.lbl_4c_Label3
688:             .Top       = 188
689:             .Left      = 98
690:             .Width     = 54
691:             .Height    = 15
692:             .AutoSize  = .F.
693:             .Alignment = 0
694:             .WordWrap  = .F.
695:             .BackStyle = 0
696:             .FontName  = "Tahoma"
697:             .FontSize  = 8
698:             .ForeColor = RGB(90, 90, 90)
699:             .Caption   = "Settings : "
700:             .Visible   = .T.
701:         ENDWITH
702: 
703:         THIS.AddObject("txt_4c_Set", "TextBox")
704:         WITH THIS.txt_4c_Set
705:             .Top               = 185
706:             .Left              = 152
707:             .Width             = 100
708:             .Height            = 23
709:             .FontName          = "Tahoma"
710:             .FontSize          = 8
711:             .ForeColor         = RGB(90, 90, 90)

*-- Linhas 730 a 825:
730:         *----------------------------------------------------------------------
731:         * Say4 "DTRenable : " + chk_dtr  /  Say5 "RTSenable : " + chk_rts
732:         *
733:         * Height 17 / Width 60 vem da classe fwcheckbox - o SCX declara
734:         * AutoSize = .T. nos dois, mas AutoSize eh NO-OP em CheckBox criado
735:         * por AddObject (fica nos 100x17 do default), entao as duas
736:         * dimensoes vao explicitas.
737:         *
738:         * .Value = 0 serve apenas de semente ANTES do binding; a partir do
739:         * .ControlSource quem define o tipo e o valor do CheckBox eh a
740:         * coluna do cursor. dtrs/rtss sao bit do SQL Server e chegam ao VFP
741:         * como LOGICO (no ramo sem conexao o CREATE CURSOR do BO tambem as
742:         * declara como L), entao o CheckBox ligado opera sobre logico -
743:         * igual ao legado, que liga chk_dtr/chk_rts direto nessas colunas.
744:         * Por isso NAO ha conversao a fazer aqui: as propriedades
745:         * this_lDtrs/this_lRtss do BO sao alimentadas pelo CarregarDoCursor,
746:         * a partir da mesma linha do cursor.
747:         *----------------------------------------------------------------------
748:         THIS.AddObject("lbl_4c_Label4", "Label")
749:         WITH THIS.lbl_4c_Label4
750:             .Top       = 210
751:             .Left      = 85
752:             .Width     = 67
753:             .Height    = 15
754:             .AutoSize  = .F.
755:             .Alignment = 0
756:             .WordWrap  = .F.
757:             .BackStyle = 0
758:             .FontName  = "Tahoma"
759:             .FontSize  = 8
760:             .ForeColor = RGB(90, 90, 90)
761:             .Caption   = "DTRenable : "
762:             .Visible   = .T.
763:         ENDWITH
764: 
765:         THIS.AddObject("chk_4c_Chk_dtr", "CheckBox")
766:         WITH THIS.chk_4c_Chk_dtr
767:             .Top       = 210
768:             .Left      = 152
769:             .Width     = 60
770:             .Height    = 17
771:             .AutoSize  = .F.
772:             .Alignment = 0
773:             .BackStyle = 0
774:             .FontName  = "Tahoma"
775:             .FontSize  = 8
776:             .ForeColor = RGB(90, 90, 90)
777:             .Themes    = .F.
778:             .Caption   = ""
779:             .TabIndex  = 5
780:             .Value     = 0
781:             .Visible   = .T.
782:             *-- ControlSource transcrito do SCX legado
783:             *-- (chk_4c_Chk_dtr.ControlSource = "crSigSyCom.dtrs"). Por ultimo no
784:             *-- bloco: o .Value acima so semeia o TIPO da coluna; a
785:             *-- partir do binding o valor vem da linha corrente do
786:             *-- cursor, que CarregarDados ja abriu e posicionou.
787:             .ControlSource = "cursor_4c_Dados.dtrs"
788:         ENDWITH
789: 
790:         THIS.AddObject("lbl_4c_Label5", "Label")
791:         WITH THIS.lbl_4c_Label5
792:             .Top       = 230
793:             .Left      = 86
794:             .Width     = 66
795:             .Height    = 15
796:             .AutoSize  = .F.
797:             .Alignment = 0
798:             .WordWrap  = .F.
799:             .BackStyle = 0
800:             .FontName  = "Tahoma"
801:             .FontSize  = 8
802:             .ForeColor = RGB(90, 90, 90)
803:             .Caption   = "RTSenable : "
804:             .Visible   = .T.
805:         ENDWITH
806: 
807:         THIS.AddObject("chk_4c_Chk_rts", "CheckBox")
808:         WITH THIS.chk_4c_Chk_rts
809:             .Top       = 230
810:             .Left      = 152
811:             .Width     = 60
812:             .Height    = 17
813:             .AutoSize  = .F.
814:             .Alignment = 0
815:             .BackStyle = 0
816:             .FontName  = "Tahoma"
817:             .FontSize  = 8
818:             .ForeColor = RGB(90, 90, 90)
819:             .Themes    = .F.
820:             .Caption   = ""
821:             .TabIndex  = 6
822:             .Value     = 0
823:             .Visible   = .T.
824:             *-- ControlSource transcrito do SCX legado
825:             *-- (chk_4c_Chk_rts.ControlSource = "crSigSyCom.rtss"). Por ultimo no

*-- Linhas 839 a 867:
839:         * comportamento da tela (CLAUDE.md regra #49) e MaxLength nunca sai
840:         * do Width em pixels (regra #19).
841:         *----------------------------------------------------------------------
842:         THIS.AddObject("lbl_4c_Label7", "Label")
843:         WITH THIS.lbl_4c_Label7
844:             .Top       = 252
845:             .Left      = 71
846:             .Width     = 81
847:             .Height    = 15
848:             .AutoSize  = .F.
849:             .Alignment = 0
850:             .WordWrap  = .F.
851:             .BackStyle = 0
852:             .FontName  = "Tahoma"
853:             .FontSize  = 8
854:             .ForeColor = RGB(90, 90, 90)
855:             .Caption   = "InBufferMode : "
856:             .Visible   = .T.
857:         ENDWITH
858: 
859:         THIS.AddObject("txt_4c_Inbuf", "TextBox")
860:         WITH THIS.txt_4c_Inbuf
861:             .Top               = 249
862:             .Left              = 152
863:             .Width             = 80
864:             .Height            = 23
865:             .FontName          = "Tahoma"
866:             .FontSize          = 8
867:             .ForeColor         = RGB(90, 90, 90)

*-- Linhas 931 a 959:
931:         * Say8 "OutBufferMode : " + Get_outbuf - tamanho do buffer de
932:         * transmissao. Value NUMERICO (outbufs numeric(8,0)).
933:         *----------------------------------------------------------------------
934:         THIS.AddObject("lbl_4c_Label8", "Label")
935:         WITH THIS.lbl_4c_Label8
936:             .Top       = 109
937:             .Left      = 361
938:             .Width     = 89
939:             .Height    = 15
940:             .AutoSize  = .F.
941:             .Alignment = 0
942:             .WordWrap  = .F.
943:             .BackStyle = 0
944:             .FontName  = "Tahoma"
945:             .FontSize  = 8
946:             .ForeColor = RGB(90, 90, 90)
947:             .Caption   = "OutBufferMode : "
948:             .Visible   = .T.
949:         ENDWITH
950: 
951:         THIS.AddObject("txt_4c_Outbuf", "TextBox")
952:         WITH THIS.txt_4c_Outbuf
953:             .Top               = 106
954:             .Left              = 450
955:             .Width             = 80
956:             .Height            = 23
957:             .FontName          = "Tahoma"
958:             .FontSize          = 8
959:             .ForeColor         = RGB(90, 90, 90)

*-- Linhas 983 a 1011:
983:         * tela pelo Say11, nao transcrito como InputMask/lista (o legado
984:         * nao declara nenhum dos dois neste campo).
985:         *----------------------------------------------------------------------
986:         THIS.AddObject("lbl_4c_Label9", "Label")
987:         WITH THIS.lbl_4c_Label9
988:             .Top       = 134
989:             .Left      = 394
990:             .Width     = 56
991:             .Height    = 15
992:             .AutoSize  = .F.
993:             .Alignment = 0
994:             .WordWrap  = .F.
995:             .BackStyle = 0
996:             .FontName  = "Tahoma"
997:             .FontSize  = 8
998:             .ForeColor = RGB(90, 90, 90)
999:             .Caption   = "InModes : "
1000:             .Visible   = .T.
1001:         ENDWITH
1002: 
1003:         THIS.AddObject("txt_4c_Inmode", "TextBox")
1004:         WITH THIS.txt_4c_Inmode
1005:             .Top               = 131
1006:             .Left              = 450
1007:             .Width             = 24
1008:             .Height            = 23
1009:             .FontName          = "Tahoma"
1010:             .FontSize          = 8
1011:             .ForeColor         = RGB(90, 90, 90)

*-- Linhas 1024 a 1073:
1024:             .ControlSource = "cursor_4c_Dados.inmodes"
1025:         ENDWITH
1026: 
1027:         THIS.AddObject("lbl_4c_Label11", "Label")
1028:         WITH THIS.lbl_4c_Label11
1029:             .Top       = 135
1030:             .Left      = 475
1031:             .Width     = 170
1032:             .Height    = 15
1033:             .AutoSize  = .F.
1034:             .Alignment = 0
1035:             .WordWrap  = .F.
1036:             .BackStyle = 0
1037:             .FontName  = "Tahoma"
1038:             .FontSize  = 8
1039:             .ForeColor = RGB(90, 90, 90)
1040:             .Caption   = "( 0 - Text , 1- Binary )"
1041:             .Visible   = .T.
1042:         ENDWITH
1043: 
1044:         *----------------------------------------------------------------------
1045:         * Say10 "InLen : " + Get_inlen - no. de caracteres lidos no buffer
1046:         * de recepcao. Value NUMERICO (inlens numeric(8,0)).
1047:         *----------------------------------------------------------------------
1048:         THIS.AddObject("lbl_4c_Label10", "Label")
1049:         WITH THIS.lbl_4c_Label10
1050:             .Top       = 159
1051:             .Left      = 408
1052:             .Width     = 42
1053:             .Height    = 15
1054:             .AutoSize  = .F.
1055:             .Alignment = 0
1056:             .WordWrap  = .F.
1057:             .BackStyle = 0
1058:             .FontName  = "Tahoma"
1059:             .FontSize  = 8
1060:             .ForeColor = RGB(90, 90, 90)
1061:             .Caption   = "InLen : "
1062:             .Visible   = .T.
1063:         ENDWITH
1064: 
1065:         THIS.AddObject("txt_4c_Inlen", "TextBox")
1066:         WITH THIS.txt_4c_Inlen
1067:             .Top               = 156
1068:             .Left              = 450
1069:             .Width             = 80
1070:             .Height            = 23
1071:             .FontName          = "Tahoma"
1072:             .FontSize          = 8
1073:             .ForeColor         = RGB(90, 90, 90)

*-- Linhas 1102 a 1130:
1102:         * (T/S/P/M/C/K/H/U), TRANSCRITO LITERAL do dump - inclusive o
1103:         * item "P" sem descricao, que o legado tambem nao descreve.
1104:         *----------------------------------------------------------------------
1105:         THIS.AddObject("lbl_4c_Label12", "Label")
1106:         WITH THIS.lbl_4c_Label12
1107:             .Top       = 185
1108:             .Left      = 345
1109:             .Width     = 105
1110:             .Height    = 15
1111:             .AutoSize  = .F.
1112:             .Alignment = 0
1113:             .WordWrap  = .F.
1114:             .BackStyle = 0
1115:             .FontName  = "Tahoma"
1116:             .FontSize  = 8
1117:             .ForeColor = RGB(90, 90, 90)
1118:             .Caption   = "Leitora de Cheques :"
1119:             .Visible   = .T.
1120:         ENDWITH
1121: 
1122:         THIS.AddObject("cbo_4c_Get_TpLeChq", "ComboBox")
1123:         WITH THIS.cbo_4c_Get_TpLeChq
1124:             .Top               = 181
1125:             .Left              = 450
1126:             .Width             = 48
1127:             .Height            = 24
1128:             .FontName          = "Tahoma"
1129:             .FontSize          = 8
1130:             .ForeColor         = RGB(90, 90, 90)

*-- Linhas 1147 a 1266:
1147:             .ControlSource = "cursor_4c_Dados.tplechqs"
1148:         ENDWITH
1149: 
1150:         THIS.AddObject("lbl_4c_Label14", "Label")
1151:         WITH THIS.lbl_4c_Label14
1152:             .Top       = 231
1153:             .Left      = 390
1154:             .Width     = 59
1155:             .Height    = 15
1156:             .AutoSize  = .F.
1157:             .Alignment = 0
1158:             .WordWrap  = .F.
1159:             .BackStyle = 0
1160:             .FontName  = "Tahoma"
1161:             .FontSize  = 8
1162:             .ForeColor = RGB(90, 90, 90)
1163:             .Caption   = "Bom Para : "
1164:             .Visible   = .T.
1165:         ENDWITH
1166: 
1167:         THIS.AddObject("chk_4c_Chk_Bompara", "CheckBox")
1168:         WITH THIS.chk_4c_Chk_Bompara
1169:             .Top       = 231
1170:             .Left      = 449
1171:             .Width     = 18
1172:             .Height    = 15
1173:             .AutoSize  = .F.
1174:             .Alignment = 0
1175:             .BackStyle = 0
1176:             .FontName  = "Tahoma"
1177:             .FontSize  = 8
1178:             .ForeColor = RGB(90, 90, 90)
1179:             .Themes    = .F.
1180:             .Caption   = ""
1181:             .TabIndex  = 13
1182:             *-- Value NUMERICO: coluna bompara numeric(1,0) - CheckBox
1183:             *-- sobre coluna numerica grava 0/1 (nao eh indice 1-based).
1184:             .Value     = 0
1185:             .Visible   = .T.
1186:             *-- ControlSource transcrito do SCX legado
1187:             *-- (chk_4c_Chk_Bompara.ControlSource = "crSigSyCom.bompara").
1188:             .ControlSource = "cursor_4c_Dados.bompara"
1189:         ENDWITH
1190: 
1191:         THIS.AddObject("lbl_4c_Label15", "Label")
1192:         WITH THIS.lbl_4c_Label15
1193:             .Top       = 248
1194:             .Left      = 398
1195:             .Width     = 51
1196:             .Height    = 15
1197:             .AutoSize  = .F.
1198:             .Alignment = 0
1199:             .WordWrap  = .F.
1200:             .BackStyle = 0
1201:             .FontName  = "Tahoma"
1202:             .FontSize  = 8
1203:             .ForeColor = RGB(90, 90, 90)
1204:             .Caption   = "Nominal : "
1205:             .Visible   = .T.
1206:         ENDWITH
1207: 
1208:         THIS.AddObject("chk_4c_Chk_nominal", "CheckBox")
1209:         WITH THIS.chk_4c_Chk_nominal
1210:             .Top       = 248
1211:             .Left      = 449
1212:             .Width     = 18
1213:             .Height    = 15
1214:             .AutoSize  = .F.
1215:             .Alignment = 0
1216:             .BackStyle = 0
1217:             .FontName  = "Tahoma"
1218:             .FontSize  = 8
1219:             .ForeColor = RGB(90, 90, 90)
1220:             .Themes    = .F.
1221:             .Caption   = ""
1222:             .TabIndex  = 14
1223:             *-- Value NUMERICO: coluna nominal numeric(1,0)
1224:             .Value     = 0
1225:             .Visible   = .T.
1226:             *-- ControlSource transcrito do SCX legado
1227:             *-- (chk_4c_Chk_nominal.ControlSource = "crSigSyCom.nominal").
1228:             .ControlSource = "cursor_4c_Dados.nominal"
1229:         ENDWITH
1230: 
1231:         THIS.AddObject("lbl_4c_Label16", "Label")
1232:         WITH THIS.lbl_4c_Label16
1233:             .Top       = 264
1234:             .Left      = 395
1235:             .Width     = 54
1236:             .Height    = 15
1237:             .AutoSize  = .F.
1238:             .Alignment = 0
1239:             .WordWrap  = .F.
1240:             .BackStyle = 0
1241:             .FontName  = "Tahoma"
1242:             .FontSize  = 8
1243:             .ForeColor = RGB(90, 90, 90)
1244:             .Caption   = "Cruzado : "
1245:             .Visible   = .T.
1246:         ENDWITH
1247: 
1248:         THIS.AddObject("chk_4c_Chk_cruzado", "CheckBox")
1249:         WITH THIS.chk_4c_Chk_cruzado
1250:             .Top       = 265
1251:             .Left      = 449
1252:             .Width     = 18
1253:             .Height    = 15
1254:             .AutoSize  = .F.
1255:             .Alignment = 0
1256:             .BackStyle = 0
1257:             .FontName  = "Tahoma"
1258:             .FontSize  = 8
1259:             .ForeColor = RGB(90, 90, 90)
1260:             .Themes    = .F.
1261:             .Caption   = ""
1262:             .TabIndex  = 15
1263:             *-- Value NUMERICO: coluna cruzado numeric(1,0)
1264:             .Value     = 0
1265:             .Visible   = .T.
1266:             *-- ControlSource transcrito do SCX legado

*-- Linhas 1279 a 1353:
1279:         * que o SCX declara). ZOrderSet = 12 do dump eh bookkeeping do
1280:         * Form Designer e NAO existe em runtime - DESCARTADO (regra #33).
1281:         *----------------------------------------------------------------------
1282:         THIS.AddObject("lbl_4c_Label13", "Label")
1283:         WITH THIS.lbl_4c_Label13
1284:             .Top       = 210
1285:             .Left      = 367
1286:             .Width     = 80
1287:             .Height    = 15
1288:             .AutoSize  = .F.
1289:             .Alignment = 0
1290:             .WordWrap  = .F.
1291:             .BackStyle = 0
1292:             .FontName  = "Tahoma"
1293:             .FontSize  = 8
1294:             .ForeColor = RGB(90, 90, 90)
1295:             .Caption   = "Tipo de Leitor  : "
1296:             .Visible   = .T.
1297:         ENDWITH
1298: 
1299:         *-- Opt_leitor: OptionGroup de 3 botoes (Serial/Teclado/Paralelo),
1300:         *-- ControlSource direto em tpbarras numeric(1,0). BorderStyle do
1301:         *-- dump eh DESCARTADO (OptionGroup nao tem essa propriedade -
1302:         *-- regra #33); so .BackStyle eh transcrito.
1303:         THIS.AddObject("obj_4c_Opt_leitor", "OptionGroup")
1304:         WITH THIS.obj_4c_Opt_leitor
1305:             .Top         = 209
1306:             .Left        = 445
1307:             .Width       = 205
1308:             .Height      = 24
1309:             .ButtonCount = 3
1310:             .AutoSize    = .F.
1311:             .BackStyle   = 0
1312:             .TabIndex    = 12
1313:             .Visible     = .T.
1314: 
1315:             WITH .Buttons(1)
1316:                 .Top       = 3
1317:                 .Left      = 5
1318:                 .Width     = 44
1319:                 .Height    = 15
1320:                 .FontName  = "Tahoma"
1321:                 .FontSize  = 8
1322:                 .BackStyle = 0
1323:                 .ForeColor = RGB(90, 90, 90)
1324:                 .Caption   = "Serial"
1325:             ENDWITH
1326: 
1327:             WITH .Buttons(2)
1328:                 .Top       = 3
1329:                 .Left      = 65
1330:                 .Width     = 55
1331:                 .Height    = 15
1332:                 .FontName  = "Tahoma"
1333:                 .FontSize  = 8
1334:                 .BackStyle = 0
1335:                 .ForeColor = RGB(90, 90, 90)
1336:                 .Caption   = "Teclado"
1337:             ENDWITH
1338: 
1339:             WITH .Buttons(3)
1340:                 .Top       = 3
1341:                 .Left      = 135
1342:                 .Width     = 56
1343:                 .Height    = 15
1344:                 .FontName  = "Tahoma"
1345:                 .FontSize  = 8
1346:                 .BackStyle = 0
1347:                 .ForeColor = RGB(90, 90, 90)
1348:                 .Caption   = "Paralelo"
1349:             ENDWITH
1350: 
1351:             *-- Value = indice 1-based do botao marcado (2 = Teclado, o
1352:             *-- default do SCX). Por ultimo no bloco, junto do
1353:             *-- ControlSource transcrito do SCX legado

*-- Linhas 1400 a 1409:
1400:         *--
1401:         *-- Os delegados de BINDEVENT sao PUBLIC (sem PROTECTED): metodo
1402:         *-- PROTECTED falha em SILENCIO no bind (CLAUDE.md regra #3).
1403:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
1404:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Encerrar,  "Click", THIS, "BtnEncerrarClick")
1405:     ENDPROC
1406: 
1407:     *==========================================================================
1408:     * ValidarTipo - Reproduz o Cmb_Tipo.InteractiveChange do legado
1409:     *

*-- Linhas 1527 a 1545:
1527:                                  "Leitora Cheques", "Impressora de Cheque")
1528: 
1529:             *-- Bloco CHEQUE - label e campo de cada linha andam juntos
1530:             THIS.lbl_4c_Label12.Visible     = loc_lCheque
1531:             THIS.cbo_4c_Get_TpLeChq.Visible = loc_lCheque
1532:             THIS.lbl_4c_Label14.Visible     = loc_lCheque
1533:             THIS.chk_4c_Chk_Bompara.Visible = loc_lCheque
1534:             THIS.lbl_4c_Label15.Visible     = loc_lCheque
1535:             THIS.chk_4c_Chk_nominal.Visible = loc_lCheque
1536:             THIS.lbl_4c_Label16.Visible     = loc_lCheque
1537:             THIS.chk_4c_Chk_cruzado.Visible = loc_lCheque
1538: 
1539:             *-- Bloco LEITOR de codigo de barra
1540:             THIS.lbl_4c_Label13.Visible     = loc_lLeitor
1541:             THIS.obj_4c_Opt_leitor.Visible  = loc_lLeitor
1542: 
1543:         CATCH TO loc_oErro
1544:             MsgErro(loc_oErro.Message + CHR(13) + ;
1545:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 1657 a 1665:
1657:     *
1658:     * Uma linha no legado e uma aqui. O objeto legado se chama [cancela] e o
1659:     * Caption dele eh "Encerrar" (SECAO 2 do dump) - o handler eh nomeado pela
1660:     * ACAO e pelo objeto do migrado (cmd_4c_Encerrar), nunca pelo nome do
1661:     * objeto legado (PILAR 3).
1662:     *
1663:     * Sair SEM gravar DESCARTA as alteracoes, exatamente como no legado, e
1664:     * isso acontece sozinho: o que o usuario digita vai para o cursor
1665:     * cursor_4c_Dados (ControlSource), e quem leva o cursor para o banco eh

*-- Linhas 2003 a 2015:
2003:     * nao aparecem aqui - quem cuida das duas eh o INSERT/UPDATE do BO, que
2004:     * precisa cobri-las porque sao NOT NULL (CLAUDE.md regra #22).
2005:     *
2006:     * TIPOS, nos dois sentidos (CheckBox ligado a coluna exige conversao
2007:     * EXPLICITA - o .Value assume o tipo do campo ligado):
2008:     *   - dtrs/rtss sao bit do SQL Server e chegam como LOGICO, logo os dois
2009:     *     CheckBox operam sobre logico -> ConverterParaLogico().
2010:     *   - bompara/nominal/cruzado sao numeric(1,0), logo esses CheckBox
2011:     *     operam sobre numerico {0,1} -> IIF(ConverterParaLogico(...), 1, 0),
2012:     *     que tolera as duas formas sem supor qual o driver entregou.
2013:     *
2014:     * SELETOR por ListIndex e nao por .Value: com Style = 2 e
2015:     * RowSourceType = 1, atribuir um .Value que nao esta na lista deixa o

*-- Linhas 2092 a 2100:
2092:                 *-- Bloco de cheque (tplechqs char(1) - a inicial da opcao)
2093:                 THIS.cbo_4c_Get_TpLeChq.Value = loc_oBO.this_cTplechqs
2094: 
2095:                 *-- numeric(1,0) -> CheckBox numerico {0,1}
2096:                 THIS.chk_4c_Chk_Bompara.Value = IIF(ConverterParaLogico(loc_oBO.this_nBompara), 1, 0)
2097:                 THIS.chk_4c_Chk_nominal.Value = IIF(ConverterParaLogico(loc_oBO.this_nNominal), 1, 0)
2098:                 THIS.chk_4c_Chk_cruzado.Value = IIF(ConverterParaLogico(loc_oBO.this_nCruzado), 1, 0)
2099: 
2100:                 *-- Bloco do leitor de codigo de barra - indice 1-based do

*-- Linhas 2140 a 2148:
2140:     *
2141:     * TIPOS no caminho de volta: ConverterParaNumero nas colunas numericas
2142:     * (devolve o proprio valor quando ja eh numerico) e ConverterParaLogico
2143:     * nas bit; os tres CheckBox sobre numeric(1,0) viram {0,1} com
2144:     * IIF(ConverterParaLogico(...), 1, 0), que aceita .Value logico ou
2145:     * numerico sem supor o que o driver entregou. tpbarras vai DIRETO, sem
2146:     * +1/-1 e sem promover 0 (regra #45).
2147:     *
2148:     * tipos NAO eh gravado por este metodo, e isso eh fidelidade: no legado o

*-- Linhas 2243 a 2251:
2243:     *   Thisform.Release
2244:     *
2245:     * O objeto legado chama-se [cancela] e o Caption dele eh "Encerrar"
2246:     * (SECAO 2 do dump); no migrado ele eh o cmd_4c_Encerrar, e o handler
2247:     * ligado por BINDEVENT eh o BtnEncerrarClick - nomeado pelo objeto do
2248:     * migrado, como manda o PILAR 3. Este metodo eh o MESMO evento sob o
2249:     * nome do objeto legado, e existe porque eh por ele que o harness de
2250:     * teste e o verificador de completude chamam a acao de cancelar.
2251:     *


### BO (C:\4c\projeto\app\classes\SIGOPCPEBO.prg):
*==============================================================================
* SIGOPCPEBO.prg - Business Object para Porta de Comunicacao (SIGOPCPE)
*
* Form OPERACIONAL de configuracao de hardware serial/paralelo.
* Tabela principal: SigSyCom (chave primaria: cidchaves char(20))
*
* Legado: SIGOPCPE.SCX - o Init() carrega TODA a tabela num cursor
* (crSigSyCom, query [Select * From SigSyCom]), indexa por Tipos
* (tag PesqTipo) e GARANTE a existencia dos 6 registros fixos de tipo de
* dispositivo, inserindo os que faltarem com Tipos + CidChaves = fUniqueIds()
* e repondo Settings = '9600,n,8,1' quando chega vazio. O usuario escolhe o
* dispositivo no Cmb_Tipo (que NAO tem ControlSource - ele apenas reposiciona
* o cursor via SEEK) e edita os campos da linha corrente; o botao Ok grava com
* poDataMgr.Update('crSigSyCom') + Commit() + fGrvSettings('CrSigSyCom').
*
* Mapeamento ControlSource legado -> propriedade (todas as 17 colunas de
* SigSyCom sao NOT NULL - ver docs/schema.sql):
*   Spinner1     -> crSigSyCom.portas    -> this_nPortas     numeric(1,0)
*   Cmb_Hand     -> crSigSyCom.hands     -> this_cHands      char(20)
*   Get_Set      -> crSigSyCom.settings  -> this_cSettings   char(20)
*   chk_dtr      -> crSigSyCom.dtrs      -> this_lDtrs       bit
*   chk_rts      -> crSigSyCom.rtss      -> this_lRtss       bit
*   Get_inbuf    -> crSigSyCom.inbufs    -> this_nInbufs     numeric(8,0)
*   Get_outbuf   -> crSigSyCom.outbufs   -> this_nOutbufs    numeric(8,0)
*   Get_inmode   -> crSigSyCom.inmodes   -> this_nInmodes    numeric(1,0)
*   Get_inlen    -> crSigSyCom.inlens    -> this_nInlens     numeric(8,0)
*   Get_TpLeChq  -> crSigSyCom.TpLeChqs  -> this_cTplechqs   char(1)
*   Opt_leitor   -> crSigSyCom.tpBarras  -> this_nTpbarras   numeric(1,0)
*   Chk_Bompara  -> crSigSyCom.bompara   -> this_nBompara    numeric(1,0)
*   chk_nominal  -> crSigSyCom.nominal   -> this_nNominal    numeric(1,0)
*   chk_cruzado  -> crSigSyCom.cruzado   -> this_nCruzado    numeric(1,0)
*   Cmb_Tipo     -> (sem ControlSource)  -> this_cTipos      char(20)
*   (sem controle na tela)               -> this_cCidchaves  char(20) - PK
*   (sem controle na tela)               -> this_cNomeimp    char(40)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SIGOPCPEBO AS BusinessBase

    *==========================================================================
    * Identificacao do registro / chave
    *==========================================================================
    *-- Tipos: char(20) - nome do dispositivo. No legado eh a chave de
    *-- pesquisa (Index On Tipos Tag PesqTipo) e o valor escolhido no
    *-- Cmb_Tipo; as comparacoes por SEEK usam PADR(...,20), porque o padding
    *-- faz parte da chave posicional do indice (CLAUDE.md regra #42).
    this_cTipos      = ""   && char(20) NOT NULL - tipo de dispositivo

    *-- CidChaves: char(20) - PRIMARY KEY (constraint sigsycom_cidchaves).
    *-- Gerada pelo fUniqueIds() do Fortyus no Insert Into do Init legado -
    *-- NUNCA vazia, senao o segundo registro colide no indice unico
    *-- (CLAUDE.md regra #22).
    this_cCidchaves  = ""   && char(20) NOT NULL - chave primaria

    *==========================================================================
    * Configuracao da porta serial (bloco esquerdo da tela, sempre visivel)
    *==========================================================================
    *-- Portas: numeric(1,0) - numero da porta de comunicacao. O Spinner1 do
    *-- legado limita 1..10 (SpinnerLowValue 1 / SpinnerHighValue 10,
    *-- KeyboardLowValue 1 / KeyboardHighValue 10) com Value inicial 1.
    this_nPortas     = 0    && numeric(1,0) NOT NULL - No. da porta COM

    *-- Hands: char(20) - HandShaking. O Cmb_Hand (RowSourceType 1) recebe no
    *-- Init legado os itens '0-None', '1-Xon Xoff', '2-RTS' e ' '; com
    *-- ControlSource char, o valor gravado eh o TEXTO do item escolhido.
    this_cHands      = ""   && char(20) NOT NULL - HandShaking

    *-- Settings: char(20) - configuracao da porta no formato
    *-- 'baud,paridade,databits,stopbits'. O Init legado repoe o default
    *-- '9600,n,8,1' em todo registro que chega vazio (this_cSettingsPadrao).
    this_cSettings   = ""   && char(20) NOT NULL - Settings da porta

    *-- Dtrs / Rtss: colunas bit do SQL Server, que chegam ao VFP como LOGICO
    *-- (.T./.F.) - por isso this_l*, e nao this_n* (bit -> LOGICAL;
    *-- numeric(1,0) -> NUMERIC). Ligadas a chk_dtr / chk_rts.
    this_lDtrs       = .F.  && bit NOT NULL - DTRenable
    this_lRtss       = .F.  && bit NOT NULL - RTSenable

    *-- Buffers e modo de leitura (Get_inbuf / Get_outbuf / Get_inmode /
    *-- Get_inlen). O dominio de InModes esta documentado na propria tela
    *-- pelo Say11: "( 0 - Text , 1- Binary )".
    this_nInbufs     = 0    && numeric(8,0) NOT NULL - InBufferMode
    this_nOutbufs    = 0    && numeric(8,0) NOT NULL - OutBufferMode
    this_nInmodes    = 0    && numeric(1,0) NOT NULL - InModes (0=Text, 1=Binary)
    this_nInlens     = 0    && numeric(8,0) NOT NULL - InLen

    *==========================================================================
    * Bloco de cheque (Say12/Say14/Say15/Say16 + controles) - o legado so
    * exibe estes controles quando Tipos = 'Leitora Cheques' OU
    * 'Impressora de Cheque' (Init e Cmb_Tipo.InteractiveChange).
    *==========================================================================
    *-- TpLeChqs: char(1) - leitora de cheques. O Get_TpLeChq eh ComboBox com
    *-- Style = 2 (dropdown list) e RowSource
    *-- "T-Teclado ,S-Serial,P,M-Manual,C-Cheque Pre,K-Pertochek,H-Check-Pronto,U-USB";
    *-- com ControlSource char, o valor gravado eh a INICIAL da opcao
    *-- escolhida (T/S/P/M/C/K/H/U).
    this_cTplechqs   = ""   && char(1) NOT NULL - tipo de leitora de cheque

    *-- BomPara / Nominal / Cruzado: numeric(1,0) ligadas a CheckBox
    *-- (Chk_Bompara / chk_nominal / chk_cruzado). CheckBox sobre coluna
    *-- numerica grava 0 ou 1 - nao eh o indice 1-based de OptionGroup/
    *-- ComboBox -, por isso propriedade NUMERICA com dominio {0,1} e
    *-- conversao explicita nos dois sentidos no Form.
    this_nBompara    = 0    && numeric(1,0) NOT NULL - imprime "Bom Para"
    this_nNominal    = 0    && numeric(1,0) NOT NULL - imprime nominal
    this_nCruzado    = 0    && numeric(1,0) NOT NULL - imprime cruzado

    *==========================================================================
    * Bloco de leitor de codigo de barra (Say13 + Opt_leitor) - o legado
    * exibe quando Tipos = 'Leitora Codigo Barra' OU 'Leitora Cheques' (Init)
    * e tambem 'Impressora de Cheque' (Cmb_Tipo.InteractiveChange).
    *==========================================================================
    *-- TpBarras: numeric(1,0) ligada ao Opt_leitor, OptionGroup de 3 botoes
    *-- (Option1 "Serial", Option2 "Teclado", Option3 "Paralelo") com
    *-- ControlSource direto: o valor gravado eh a ORDEM do botao marcado
    *-- (1=Serial, 2=Teclado, 3=Paralelo), 1-based e SEM +1/-1
    *-- (CLAUDE.md regra #45). O SCX declara Value = 2, logo o default de
    *-- tela eh "Teclado".
    this_nTpbarras   = 0    && numeric(1,0) NOT NULL - 1=Serial 2=Teclado 3=Paralelo

    *==========================================================================
    * Coluna NOT NULL sem controle na tela
    *==========================================================================
    *-- NomeImp: char(40) - nome da impressora associada ao dispositivo. Nao
    *-- tem controle no SCX e nao eh citada em metodo nenhum do legado:
    *-- existia apenas no registro em branco do cursor (AddCursor sem lista
    *-- de colunas = Select * + TableUpdate) e por isso continuava sendo
    *-- gravada em branco. Declarada aqui porque eh NOT NULL e o INSERT da
    *-- Fase 2 tem de cobri-la (CLAUDE.md regra #22).
    this_cNomeimp    = ""   && char(40) NOT NULL - nome da impressora

    *==========================================================================
    * Estado / apoio ao fluxo do form
    *==========================================================================
    *-- Alias do cursor que recebe TODA a tabela (equivalente ao crSigSyCom
    *-- do legado). O form percorre/posiciona este cursor conforme o Cmb_Tipo.
    this_cCursorDados     = "cursor_4c_Dados"

    *-- Lista dos 6 tipos de dispositivo que o Init legado GARANTE existirem
    *-- na tabela, na mesma ordem em que sao inseridos e em que o Cmb_Tipo os
    *-- apresenta (AddItem). Preenchida no Init() porque "Balanca" leva
    *-- cedilha e literal acentuado em .PRG eh proibido (CLAUDE.md regra #4).
    this_cTiposPadrao     = ""
    this_nTotalTipos      = 6

    *-- Settings default aplicado pelo Init legado a todo registro cujo
    *-- Settings chega vazio. Fica em propriedade propria, e nao na lista
    *-- acima, porque o proprio valor contem virgulas.
    this_cSettingsPadrao  = "9600,n,8,1"

    *-- Tipo selecionado no Cmb_Tipo. Guardado separado de this_cTipos para o
    *-- form saber qual linha reposicionar sem depender do estado do cursor.
    this_cTipoSelecionado = ""

    *-- Quantidade de registros carregados no cursor de dados.
    this_nQtdeRegistros   = 0

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Define a tabela principal e a chave primaria REAL de SigSyCom
    * (cidchaves - constraint sigsycom_cidchaves, ver docs/schema.sql), monta
    * a lista dos 6 tipos de dispositivo usando CHR() no lugar dos acentos e
    * zera o estado de edicao herdado de BusinessBase.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigSyCom")

            THIS.this_cTabela     = "SigSyCom"
            THIS.this_cCampoChave = "cidchaves"

            *-- Os 6 tipos fixos, na ordem dos Insert Into / AddItem do legado.
            *-- "Balanca" = "Balan" + CHR(231) + "a"  (CHR(231) = c-cedilha)
            THIS.this_cTiposPadrao = "Balan" + CHR(231) + "a" + ;
                                     ",Cupom Fiscal" + ;
                                     ",Leitora Cheques" + ;
                                     ",Leitora Codigo Barra" + ;
                                     ",Impressora de Cheque" + ;
                                     ",Gaveta Serial"
            THIS.this_nTotalTipos = 6

            *-- Estado inicial: consulta, nenhum registro posicionado.
            THIS.this_cTipoSelecionado = ""
            THIS.this_nQtdeRegistros   = 0
            THIS.this_lEmEdicao        = .F.
            THIS.this_lNovoRegistro    = .F.
            THIS.this_lDadosAlterados  = .F.
            THIS.this_cMensagemErro    = ""
            THIS.this_lErroExibido     = .F.

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar SIGOPCPEBO:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterTipoPorIndice - Devolve o nome do tipo de dispositivo na posicao
    * informada (1..this_nTotalTipos), na mesma ordem do Cmb_Tipo legado.
    * Indice fora da faixa devolve string vazia.
    *
    * Sem PROTECTED de proposito: o Form chama de fora para popular o
    * Cmb_Tipo e para resolver a linha a posicionar no cursor (CLAUDE.md
    * regra #51 - metodo que o form chama nunca pode ser PROTECTED).
    *==========================================================================
    FUNCTION ObterTipoPorIndice(par_nIndice)
        LOCAL loc_cRetorno, loc_nLinhas
        LOCAL ARRAY loc_aTipos[1]
        loc_cRetorno = ""

        IF VARTYPE(par_nIndice) = "N" AND par_nIndice >= 1
            loc_nLinhas = ALINES(loc_aTipos, THIS.this_cTiposPadrao, 1, ",")
            IF par_nIndice <= loc_nLinhas
                loc_cRetorno = ALLTRIM(loc_aTipos[par_nIndice])
            ENDIF
        ENDIF

        RETURN loc_cRetorno
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Valor da chave primaria para a auditoria
    * (BusinessBase.RegistrarAuditoria). A PK de SigSyCom eh cidchaves.
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as 17 colunas da linha corrente do
    * alias informado para as propriedades this_*. Usado tanto para a linha
    * reposicionada pelo Cmb_Tipo (equivalente ao Seek legado) quanto para o
    * proprio cursor_4c_Dados.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C"
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cTipos     = TratarNulo(tipos, "")
                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                THIS.this_nPortas    = TratarNulo(portas, 0)
                THIS.this_cHands     = TratarNulo(hands, "")
                THIS.this_cSettings  = TratarNulo(settings, "")

                *-- dtrs/rtss sao colunas bit do SQL Server - chegam ao VFP
                *-- como LOGICO (CLAUDE.md regra correlata a bit/numeric(1,0)).
                THIS.this_lDtrs      = dtrs
                THIS.this_lRtss      = rtss

                THIS.this_nInbufs    = TratarNulo(inbufs, 0)
                THIS.this_nOutbufs   = TratarNulo(outbufs, 0)
                THIS.this_nInmodes   = TratarNulo(inmodes, 0)
                THIS.this_nInlens    = TratarNulo(inlens, 0)
                THIS.this_cTplechqs  = TratarNulo(tplechqs, "")
                THIS.this_nTpbarras  = TratarNulo(tpbarras, 0)
                THIS.this_nBompara   = TratarNulo(bompara, 0)
                THIS.this_nNominal   = TratarNulo(nominal, 0)
                THIS.this_nCruzado   = TratarNulo(cruzado, 0)
                THIS.this_cNomeimp   = TratarNulo(nomeimp, "")

                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - INSERT completo em SigSyCom (as 17 colunas, todas NOT NULL).
    *
    * cidchaves eh a PK Fortyus (CLAUDE.md regra #22): gerada por
    * fUniqueIds() quando ainda esta vazia, NUNCA deixada em branco -
    * senao o proximo registro colide no indice unico sigsycom_cidchaves.
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_nResultado

        loc_lResultado  = .F.
        loc_lProsseguir = .T.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel."
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir AND EMPTY(ALLTRIM(THIS.this_cCidchaves))
            THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
        ENDIF

        IF loc_lProsseguir
            TRY
                loc_cSQL = "INSERT INTO SigSyCom " + ;
                    "(tipos, portas, dtrs, rtss, hands, settings, inbufs, outbufs, " + ;
                    "inmodes, inlens, tpbarras, cidchaves, tplechqs, bompara, cruzado, " + ;
                    "nominal, nomeimp) VALUES (" + ;
                    EscaparSQL(LEFT(THIS.this_cTipos, 20)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nPortas, 0) + ", " + ;
                    IIF(THIS.this_lDtrs, "1", "0") + ", " + ;
                    IIF(THIS.this_lRtss, "1", "0") + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cHands, 20)) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cSettings, 20)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nInbufs, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOutbufs, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nInmodes, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nInlens, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nTpbarras, 0) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cTplechqs, 1)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nBompara, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nCruzado, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNominal, 0) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cNomeimp, 40)) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao incluir Porta de Comunica" + ;
                        CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro ao Incluir")
                    loc_lResultado = .F.
                ENDIF

            CATCH TO loc_oErro
                THIS.this_cMensagemErro = "Erro ao incluir Porta de Comunica" + ;
                    CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message
                MsgErro(THIS.this_cMensagemErro, "Erro ao Incluir")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE completo em SigSyCom, filtrado pela PK cidchaves.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_nResultado

        loc_lResultado  = .F.
        loc_lProsseguir = .T.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel."
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir AND EMPTY(ALLTRIM(THIS.this_cCidchaves))
            THIS.this_cMensagemErro = "Registro sem chave prim" + CHR(225) + "ria - n" + ;
                CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel alterar."
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            TRY
                loc_cSQL = "UPDATE SigSyCom SET " + ;
                    "tipos = "    + EscaparSQL(LEFT(THIS.this_cTipos, 20)) + ", " + ;
                    "portas = "   + FormatarNumeroSQL(THIS.this_nPortas, 0) + ", " + ;
                    "dtrs = "     + IIF(THIS.this_lDtrs, "1", "0") + ", " + ;
                    "rtss = "     + IIF(THIS.this_lRtss, "1", "0") + ", " + ;
                    "hands = "    + EscaparSQL(LEFT(THIS.this_cHands, 20)) + ", " + ;
                    "settings = " + EscaparSQL(LEFT(THIS.this_cSettings, 20)) + ", " + ;
                    "inbufs = "   + FormatarNumeroSQL(THIS.this_nInbufs, 0) + ", " + ;
                    "outbufs = "  + FormatarNumeroSQL(THIS.this_nOutbufs, 0) + ", " + ;
                    "inmodes = "  + FormatarNumeroSQL(THIS.this_nInmodes, 0) + ", " + ;
                    "inlens = "   + FormatarNumeroSQL(THIS.this_nInlens, 0) + ", " + ;
                    "tpbarras = " + FormatarNumeroSQL(THIS.this_nTpbarras, 0) + ", " + ;
                    "tplechqs = " + EscaparSQL(LEFT(THIS.this_cTplechqs, 1)) + ", " + ;
                    "bompara = "  + FormatarNumeroSQL(THIS.this_nBompara, 0) + ", " + ;
                    "cruzado = "  + FormatarNumeroSQL(THIS.this_nCruzado, 0) + ", " + ;
                    "nominal = "  + FormatarNumeroSQL(THIS.this_nNominal, 0) + ", " + ;
                    "nomeimp = "  + EscaparSQL(LEFT(THIS.this_cNomeimp, 40)) + ;
                    " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao alterar Porta de Comunica" + ;
                        CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro ao Alterar")
                    loc_lResultado = .F.
                ENDIF

            CATCH TO loc_oErro
                THIS.this_cMensagemErro = "Erro ao alterar Porta de Comunica" + ;
                    CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message
                MsgErro(THIS.this_cMensagemErro, "Erro ao Alterar")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDados - Monta o cursor de trabalho da tela (equivalente EXATO ao
    * bloco de abertura do Init legado).
    *
    * O legado faz, nesta ordem:
    *   .AddCursor('SigSyCom','Tipos','crSigSyCom','','',[Select * From SigSyCom])
    *   .ReQuery('crSigSyCom')
    *   Select crSigSyCom / Index On Tipos Tag PesqTipo / Go Top
    *   para cada um dos 6 tipos: If Not Seek(Padr(<tipo>,20))
    *                                 Insert Into crSigSyCom (Tipos, CidChaves) ...
    *                             EndIf
    *                             If IsEmpty(Settings) -> Replace com '9600,n,8,1'
    *
    * Reproduzido aqui porque esse cursor NAO eh um detalhe de carga: os
    * controles da tela sao ligados a ele por ControlSource (como no legado),
    * entao ele tem de EXISTIR e estar POSICIONADO antes de
    * ConfigurarCamposPrincipais rodar - ControlSource apontando para alias
    * fechado derruba o Init inteiro com [Alias ... is not found]
    * (CLAUDE.md regra #41). Por isso o Form chama este metodo ANTES de criar
    * os campos, e por isso o ramo sem conexao tambem cria o cursor (com a
    * estrutura das 17 colunas de SigSyCom): sem alias vivo a tela nao abre
    * nem em modo de teste.
    *
    * READWRITE eh obrigatorio: os controles editam a linha corrente e o
    * bloco de semeadura faz INSERT/REPLACE no proprio cursor - cursor de
    * SQLEXEC nasce SOMENTE-LEITURA.
    *
    * Sem PROTECTED de proposito - o Form chama de fora (CLAUDE.md regra #51).
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_nResultado
        LOCAL loc_nI, loc_cTipo, loc_cAlias, loc_cAliasTmp, loc_oErro

        loc_lResultado  = .F.
        loc_lProsseguir = .T.
        loc_cAlias      = THIS.this_cCursorDados
        loc_cAliasTmp   = loc_cAlias + "_Tmp"

        TRY
            *-- Fecha o alias anterior. O TABLEREVERT so entra se houver
            *-- buffering de verdade: sem buffering ele NAO eh no-op, dispara
            *-- erro 1586 (CLAUDE.md regra #52). USE IN fecha o alias mesmo
            *-- com buffer sujo.
            IF USED(loc_cAlias)
                IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                    TABLEREVERT(.T., loc_cAlias)
                ENDIF
                USE IN (loc_cAlias)
            ENDIF
            IF USED(loc_cAliasTmp)
                USE IN (loc_cAliasTmp)
            ENDIF

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                *-- Mesma query do lcQryCFis legado: a tabela INTEIRA.
                loc_cSQL = "SELECT tipos, portas, dtrs, rtss, hands, settings, " + ;
                    "inbufs, outbufs, inmodes, inlens, tpbarras, cidchaves, " + ;
                    "tplechqs, bompara, cruzado, nominal, nomeimp FROM SigSyCom"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

                *-- SELECT bem-sucedido devolve 1 (um result set). O > 0 eh
                *-- estrito de proposito: o passo seguinte DEPENDE do cursor
                *-- temporario existir.
                IF loc_nResultado > 0
                    *-- SQLEXEC gera cursor SOMENTE-LEITURA; READWRITE eh
                    *-- obrigatorio porque os controles editam a linha e a
                    *-- semeadura faz INSERT/REPLACE no proprio cursor.
                    SELECT * FROM (loc_cAliasTmp) INTO CURSOR (loc_cAlias) READWRITE
                    IF USED(loc_cAliasTmp)
                        USE IN (loc_cAliasTmp)
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao carregar Porta de Comunica" + ;
                        CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro ao Carregar")
                    loc_lProsseguir = .F.
                ENDIF
            ELSE
                *-- Sem conexao (modo de teste / validacao de UI): cursor vazio
                *-- com a estrutura REAL de SigSyCom (docs/schema.sql). dtrs e
                *-- rtss sao Logicos porque bit do SQL Server chega ao VFP
                *-- como Logico - e sao eles que alimentam os CheckBox ligados
                *-- por ControlSource.
                CREATE CURSOR (loc_cAlias) ( ;
                    tipos     C(20), ;
                    portas    N(1, 0), ;
                    dtrs      L, ;
                    rtss      L, ;
                    hands     C(20), ;
                    settings  C(20), ;
                    inbufs    N(8, 0), ;
                    outbufs   N(8, 0), ;
                    inmodes   N(1, 0), ;
                    inlens    N(8, 0), ;
                    tpbarras  N(1, 0), ;
                    cidchaves C(20), ;
                    tplechqs  C(1), ;
                    bompara   L, ;
                    cruzado   L, ;
                    nominal   L, ;
                    nomeimp   C(40) )
            ENDIF

            IF loc_lProsseguir
                SELECT (loc_cAlias)

                *-- Index On Tipos Tag PesqTipo + Go Top do legado. A tag eh
                *-- consultada por SEEK a partir do Cmb_Tipo; chave de coluna
                *-- UNICA (char(20)), logo o SEEK usa PADR(...,20) e casa
                *-- exato mesmo com SET EXACT ON.
                INDEX ON tipos TAG PesqTipo
                GO TOP

                *-- Semeadura dos 6 tipos, igual ao legado: o que faltar eh
                *-- inserido com Tipos + CidChaves = fUniqueIds(); as demais
                *-- colunas ficam no valor em branco do cursor, exatamente
                *-- como no Insert Into de duas colunas do legado. Em seguida,
                *-- Settings vazio recebe o default '9600,n,8,1'.
                FOR loc_nI = 1 TO THIS.this_nTotalTipos
                    loc_cTipo = THIS.ObterTipoPorIndice(loc_nI)

                    IF !EMPTY(loc_cTipo)
                        IF !SEEK(PADR(loc_cTipo, 20), loc_cAlias, "PesqTipo")
                            INSERT INTO (loc_cAlias) (tipos, cidchaves) ;
                                VALUES (PADR(loc_cTipo, 20), LEFT(fUniqueIds(), 20))
                        ENDIF

                        IF EMPTY(ALLTRIM(EVALUATE(loc_cAlias + ".settings")))
                            REPLACE settings WITH THIS.this_cSettingsPadrao ;
                                IN (loc_cAlias)
                        ENDIF
                    ENDIF
                ENDFOR

                SELECT (loc_cAlias)
                GO TOP

                THIS.this_nQtdeRegistros = RECCOUNT(loc_cAlias)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar Porta de Comunica" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao Carregar")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

