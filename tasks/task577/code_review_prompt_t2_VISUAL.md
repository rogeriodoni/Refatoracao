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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigMvSbn.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1679 linhas total):

*-- Linhas 18 a 38:
18: * Get_descr/Get_valo/Get_items, FigJpg, Sair, BtnOficina) sao filhos
19: * DIRETOS do form. Este form migrado segue a mesma estrutura flat
20: * (excecao documentada em CLAUDE.md para o Gate da Fase 3 quando o
21: * legado nao tem PageFrame - nao inventar Page1/Page2 que o original
22: * nao possui). O UNICO container do legado e cntSombra (faixa do
23: * cabecalho), reproduzido aqui como cnt_4c_Sombra.
24: *
25: * FASE 3/8 - ESTRUTURA BASE: esqueleto do form (propriedades visuais,
26: * Init/InicializarForm, BO e o cabecalho). CONCLUIDA.
27: *
28: * FASE 4/8 - GRADES E BOTOES: esta fase entrega (a) a grade principal
29: * (Grade/TmpSubN -> grd_4c_Subniveis) e a grade de itens (fwgrade ->
30: * grd_4c_Itens), com ColumnCount/Width/Header/InputMask identicos ao
31: * SCX legado; (b) os dois botoes do legado - Sair (cmd_4c_Sair) e
32: * BtnOficina (cmd_4c_BtnOficina) - com geometria, Picture, Caption e
33: * ToolTipText transcritos do dump; (c) o carregamento efetivo da lista
34: * (CarregarLista), que eh o trecho final do Init legado: BuscarSubniveis
35: * no BO, bind do grid e desabilitacao do form pai.
36: *
37: * Os Column*.ControlSource da grade principal so sao atribuidos DENTRO
38: * de CarregarLista, depois que o BO populou cursor_4c_Subniveis - o

*-- Linhas 294 a 302:
294:                 ENDIF
295: 
296:                 *-- Titulo: "SubNiveis - <Operacao> ( <Numero> )", igual ao legado
297:                 THIS.Caption = "SubN" + CHR(237) + "veis - " + PROPER(ALLTRIM(THIS.this_cDopes)) + ;
298:                     " ( " + ALLTRIM(STR(THIS.this_nNumes)) + " ) "
299: 
300:                 THIS.ConfigurarCabecalho()
301:                 THIS.ConfigurarShapes()
302:                 THIS.ConfigurarGradeSubniveis()

*-- Linhas 335 a 388:
335:     * Caption calculado em InicializarForm.
336:     *==========================================================================
337:     PROTECTED PROCEDURE ConfigurarCabecalho()
338:         LOCAL loc_oCnt
339: 
340:         THIS.AddObject("cnt_4c_Sombra", "Container")
341:         loc_oCnt = THIS.cnt_4c_Sombra
342:         WITH loc_oCnt
343:             .Top         = 0
344:             .Left        = 0
345:             .Width       = THIS.Width
346:             .Height      = 80
347:             .BorderWidth = 0
348:             .BackColor   = RGB(100, 100, 100)
349:             .Visible     = .T.
350:         ENDWITH
351: 
352:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
353:         WITH loc_oCnt.lbl_4c_Sombra
354:             .FontBold      = .T.
355:             .FontName      = "Tahoma"
356:             .FontSize      = 18
357:             .FontUnderline = .F.
358:             .WordWrap      = .T.
359:             .Alignment     = 0
360:             .BackStyle     = 0
361:             .AutoSize      = .F.
362:             .Caption       = THIS.Caption
363:             .Height        = 40
364:             .Left          = 10
365:             .Top           = 25
366:             .Width         = 769
367:             .ForeColor     = RGB(0, 0, 0)
368:             .Visible       = .T.
369:         ENDWITH
370: 
371:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
372:         WITH loc_oCnt.lbl_4c_Titulo
373:             .FontBold   = .T.
374:             .FontName   = "Tahoma"
375:             .FontSize   = 18
376:             .WordWrap   = .T.
377:             .Alignment  = 0
378:             .BackStyle  = 0
379:             .AutoSize   = .F.
380:             .Caption    = THIS.Caption
381:             .Height     = 46
382:             .Left       = 10
383:             .Top        = 24
384:             .Width      = 769
385:             .ForeColor  = RGB(255, 255, 255)
386:             .Visible    = .T.
387:         ENDWITH
388:     ENDPROC

*-- Linhas 408 a 441:
408:     * SCX (cntSombra -> Shape3 -> Shape2 -> ... -> Shape1 -> Sair -> Grade):
409:     * a moldura tem de ficar ATRAS da imagem, e Shape transparente criado
410:     * DEPOIS de um CommandButton pode interceptar o clique dele (Shape2
411:     * cobre 903..993 x 6..116, area do cmd_4c_Sair).
412:     *
413:     * Shape NAO tem ForeColor nem Themes (CLAUDE.md regra #33 - conferido em
414:     * automation\propriedades_baseclasses.txt): a cor mora em BorderColor /
415:     * FillColor. Nenhuma das duas eh atribuida aqui.
416:     *==========================================================================
417:     PROTECTED PROCEDURE ConfigurarShapes()
418: 
419:         *-- Shape3 do legado: invisivel (BackStyle = 0 + BorderStyle = 0)
420:         THIS.AddObject("shp_4c_Shape3", "Shape")
421:         WITH THIS.shp_4c_Shape3
422:             .Top         = 122
423:             .Left        = 903
424:             .Height      = 34
425:             .Width       = 57
426:             .BackStyle   = 0
427:             .BorderStyle = 0
428:             .BorderColor = RGB(136, 189, 188)
429:             .Visible     = .T.
430:         ENDWITH
431: 
432:         *-- Shape2 do legado: invisivel (BackStyle = 0 + BorderStyle = 0)
433:         THIS.AddObject("shp_4c_Shape2", "Shape")
434:         WITH THIS.shp_4c_Shape2
435:             .Top         = 6
436:             .Left        = 903
437:             .Height      = 110
438:             .Width       = 90
439:             .BackStyle   = 0
440:             .BorderStyle = 0
441:             .BorderColor = RGB(136, 189, 188)

*-- Linhas 447 a 456:
447:         *-- o que faz a borda aparecer; forcar 0 aqui apagaria a moldura.
448:         THIS.AddObject("shp_4c_Shape1", "Shape")
449:         WITH THIS.shp_4c_Shape1
450:             .Top         = 104
451:             .Left        = 671
452:             .Height      = 227
453:             .Width       = 320
454:             .BackStyle   = 0
455:             .BorderWidth = 1
456:             .Visible     = .T.

*-- Linhas 473 a 482:
473:         THIS.AddObject("grd_4c_Subniveis", "Grid")
474:         loc_oGrid = THIS.grd_4c_Subniveis
475:         WITH loc_oGrid
476:             .Top          = 104
477:             .Left         = 7
478:             .Width        = 661
479:             .Height       = 227
480:             .ColumnCount  = 8
481:             .FontName     = "Tahoma"
482:             .FontSize     = 8

*-- Linhas 501 a 509:
501:             .ReadOnly      = .T.
502:             .Visible       = .T.
503:             .Header1.Alignment = 2
504:             .Header1.Caption   = "Emp"
505:         ENDWITH
506: 
507:         *-- Column2: Movimentacao (TmpSubN.Dopes)
508:         WITH loc_oGrid.Column2
509:             .FontName      = "Tahoma"

*-- Linhas 516 a 524:
516:             .ReadOnly      = .T.
517:             .Visible       = .T.
518:             .Header1.Alignment = 2
519:             .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
520:         ENDWITH
521: 
522:         *-- Column3: Codigo (TmpSubN.Numes)
523:         WITH loc_oGrid.Column3
524:             .FontName      = "Tahoma"

*-- Linhas 532 a 540:
532:             .Visible       = .T.
533:             .InputMask     = "999999"
534:             .Header1.Alignment = 2
535:             .Header1.Caption   = "C" + CHR(243) + "digo"
536:         ENDWITH
537: 
538:         *-- Column4: Data (TmpSubN.Datas)
539:         WITH loc_oGrid.Column4
540:             .FontName      = "Tahoma"

*-- Linhas 547 a 555:
547:             .ReadOnly      = .T.
548:             .Visible       = .T.
549:             .Header1.Alignment = 2
550:             .Header1.Caption   = "Data"
551:         ENDWITH
552: 
553:         *-- Column5: Documento (TmpSubN.Notas)
554:         WITH loc_oGrid.Column5
555:             .FontName      = "Tahoma"

*-- Linhas 562 a 570:
562:             .ReadOnly      = .T.
563:             .Visible       = .T.
564:             .Header1.Alignment = 2
565:             .Header1.Caption   = "Documento"
566:         ENDWITH
567: 
568:         *-- Column6: Usuario (TmpSubN.Usuars)
569:         WITH loc_oGrid.Column6
570:             .FontName      = "Tahoma"

*-- Linhas 577 a 585:
577:             .ReadOnly      = .T.
578:             .Visible       = .T.
579:             .Header1.Alignment = 2
580:             .Header1.Caption   = "Usu" + CHR(225) + "rio"
581:         ENDWITH
582: 
583:         *-- Column7: Prazo de Entrega (TmpSubN.PrazoEnts)
584:         WITH loc_oGrid.Column7
585:             .FontName      = "Tahoma"

*-- Linhas 592 a 600:
592:             .ReadOnly      = .T.
593:             .Visible       = .T.
594:             .Header1.Alignment = 2
595:             .Header1.Caption   = "Prz. Entrega"
596:         ENDWITH
597: 
598:         *-- Column8: Status (TmpSubN.Pstatus + "-" + TmpSubN.Descs)
599:         WITH loc_oGrid.Column8
600:             .FontName      = "Tahoma"

*-- Linhas 607 a 615:
607:             .ReadOnly      = .T.
608:             .Visible       = .T.
609:             .Header1.Alignment = 2
610:             .Header1.Caption   = "Status"
611:         ENDWITH
612: 
613:         *-- Legado: evento nativo do Grade (AfterRowColChange) - aqui via
614:         *-- BINDEVENT porque o grid nasce por AddObject. Handler PUBLIC e
615:         *-- com o parametro do evento (CLAUDE.md #3).

*-- Linhas 630 a 639:
630:         THIS.AddObject("grd_4c_Itens", "Grid")
631:         loc_oGrid = THIS.grd_4c_Itens
632:         WITH loc_oGrid
633:             .Top               = 338
634:             .Left              = 7
635:             .Width             = 984
636:             .Height            = 323
637:             .ColumnCount       = 10
638:             .FontName          = "Tahoma"
639:             .FontSize          = 8

*-- Linhas 660 a 668:
660:             .Visible       = .T.
661:             .ForeColor     = RGB(0, 0, 0)
662:             .Header1.Alignment = 2
663:             .Header1.Caption   = "Produto"
664:             .Header1.ForeColor = RGB(90, 90, 90)
665:             .Text1.BorderStyle = 0
666:             .Text1.Format      = "K!"
667:             .Text1.InputMask   = REPLICATE("!", 14)
668:             .Text1.Margin      = 0

*-- Linhas 684 a 692:
684:             .ReadOnly      = .T.
685:             .Visible       = .T.
686:             .Header1.Alignment = 2
687:             .Header1.Caption   = "Fator"
688:             .Header1.ForeColor = RGB(90, 90, 90)
689:             .Text1.BorderStyle = 0
690:             .Text1.InputMask   = "9999.999"
691:             .Text1.Margin      = 0
692:             .Text1.ReadOnly    = .T.

*-- Linhas 706 a 714:
706:             .ReadOnly      = .T.
707:             .Visible       = .T.
708:             .Header1.Alignment = 2
709:             .Header1.Caption   = "Op"
710:             .Header1.ForeColor = RGB(90, 90, 90)
711:             .Text1.Alignment   = 2
712:             .Text1.BorderStyle = 0
713:             .Text1.Margin      = 0
714:             .Text1.MaxLength   = 1

*-- Linhas 727 a 735:
727:             .ReadOnly      = .T.
728:             .Visible       = .T.
729:             .Header1.Alignment = 2
730:             .Header1.Caption   = "Qtd."
731:             .Header1.ForeColor = RGB(90, 90, 90)
732:             .Text1.BorderStyle = 0
733:             .Text1.InputMask   = "99999.99"
734:             .Text1.Margin      = 0
735:             .Text1.ReadOnly    = .T.

*-- Linhas 747 a 755:
747:             .ReadOnly      = .T.
748:             .Visible       = .T.
749:             .Header1.Alignment = 2
750:             .Header1.Caption   = "Peso (gr)"
751:             .Header1.ForeColor = RGB(90, 90, 90)
752:             .Text1.BorderStyle = 0
753:             .Text1.InputMask   = "99999.99"
754:             .Text1.Margin      = 0
755:             .Text1.ReadOnly    = .T.

*-- Linhas 768 a 776:
768:             .Visible       = .T.
769:             .InputMask     = "99,999,999.99"
770:             .Header1.Alignment = 2
771:             .Header1.Caption   = "Valor"
772:             .Header1.ForeColor = RGB(90, 90, 90)
773:             .Text1.BorderStyle = 0
774:             .Text1.InputMask   = "99,999,999.99"
775:             .Text1.Margin      = 0
776:             .Text1.ReadOnly    = .T.

*-- Linhas 788 a 796:
788:             .ReadOnly      = .T.
789:             .Visible       = .T.
790:             .Header1.Alignment = 2
791:             .Header1.Caption   = "Moe"
792:             .Header1.ForeColor = RGB(90, 90, 90)
793:             .Text1.BorderStyle = 0
794:             .Text1.Margin      = 0
795:             .Text1.ReadOnly    = .T.
796:         ENDWITH

*-- Linhas 808 a 816:
808:             .Visible       = .T.
809:             .InputMask     = "999,999,999.99"
810:             .Header1.Alignment = 2
811:             .Header1.Caption   = "Total"
812:             .Header1.ForeColor = RGB(90, 90, 90)
813:             .Text1.Alignment   = 3
814:             .Text1.BorderStyle = 0
815:             .Text1.InputMask   = "999,999,999.99"
816:             .Text1.Margin      = 0

*-- Linhas 829 a 837:
829:             .ReadOnly      = .T.
830:             .Visible       = .T.
831:             .Header1.Alignment = 2
832:             .Header1.Caption   = "Total Peso"
833:             .Header1.ForeColor = RGB(90, 90, 90)
834:             .Text1.BorderStyle = 0
835:             .Text1.InputMask   = "999,999.99"
836:             .Text1.Margin      = 0
837:             .Text1.ReadOnly    = .T.

*-- Linhas 850 a 858:
850:             .Visible       = .T.
851:             .InputMask     = "999"
852:             .Header1.Alignment = 2
853:             .Header1.Caption   = ""
854:             .Text1.Alignment   = 3
855:             .Text1.BorderStyle = 0
856:             .Text1.InputMask   = "999"
857:             .Text1.Margin      = 0
858:             .Text1.ReadOnly    = .T.

*-- Linhas 875 a 935:
875:     * renderiza quando o botao fica desabilitado). CorretorAutomatico #99
876:     * aplicaria essa mesma troca - emitido ja correto.
877:     *
878:     * cmd_4c_BtnOficina nasce Visible = .F., igual ao legado: quem o mostra
879:     * eh AtualizarVisibilidadeOficina(), e so quando o usuario tem acesso
880:     * OPPEND e o subnivel corrente tem ordem de producao (Nops).
881:     *==========================================================================
882:     PROTECTED PROCEDURE ConfigurarBotoes()
883: 
884:         *-- Sair (legado SIGMVSBN.Sair): Cancel = .T. faz o ESC aciona-lo
885:         THIS.AddObject("cmd_4c_Sair", "CommandButton")
886:         WITH THIS.cmd_4c_Sair
887:             .Top             = 3
888:             .Left            = 923
889:             .Height          = 75
890:             .Width           = 75
891:             .FontBold        = .T.
892:             .FontItalic      = .T.
893:             .FontName        = "Comic Sans MS"
894:             .FontSize        = 8
895:             .Caption         = "Encerrar"
896:             .Cancel          = .T.
897:             .ToolTipText     = "[ESC] Sair"
898:             .ForeColor       = RGB(90, 90, 90)
899:             .BackColor       = RGB(255, 255, 255)
900:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
901:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
902:             .Themes          = .T.
903:             .Visible         = .T.
904:         ENDWITH
905: 
906:         *-- BtnOficina (legado SIGMVSBN.BtnOficina): Caption "\<Oficina"
907:         *-- no legado eh o atalho ALT+O - transcrito como esta
908:         THIS.AddObject("cmd_4c_BtnOficina", "CommandButton")
909:         WITH THIS.cmd_4c_BtnOficina
910:             .Top             = 3
911:             .Left            = 847
912:             .Height          = 75
913:             .Width           = 75
914:             .FontBold        = .T.
915:             .FontItalic      = .T.
916:             .FontName        = "Comic Sans MS"
917:             .FontSize        = 8
918:             .Caption         = "\<Oficina"
919:             .ToolTipText     = "Oficina"
920:             .ForeColor       = RGB(90, 90, 90)
921:             .BackColor       = RGB(255, 255, 255)
922:             .Picture         = gc_4c_CaminhoIcones + "geral_pn_cfg_60.jpg"
923:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pn_cfg_60.jpg"
924:             .Themes          = .T.
925:             .Visible         = .F.
926:         ENDWITH
927: 
928:         *-- Handlers PUBLIC (BINDEVENT ignora metodo PROTECTED - CLAUDE.md #3)
929:         BINDEVENT(THIS.cmd_4c_Sair,        "Click", THIS, "BtnSairClick")
930:         BINDEVENT(THIS.cmd_4c_BtnOficina,  "Click", THIS, "BtnOficinaClick")
931:     ENDPROC
932: 
933:     *==========================================================================
934:     * ConfigurarCamposPrincipais - Os tres campos de exibicao do subnivel
935:     * corrente (SIGMVSBN.Get_descr/Get_valo/Get_items do legado), filhos

*-- Linhas 955 a 964:
955:         *-- Get_descr do legado: descricao do produto do subnivel corrente
956:         THIS.AddObject("txt_4c_Descr", "TextBox")
957:         WITH THIS.txt_4c_Descr
958:             .Top               = 665
959:             .Left              = 7
960:             .Width             = 290
961:             .Height            = 23
962:             .FontName          = "Courier New"
963:             .FontSize          = 8
964:             .BorderStyle       = 1

*-- Linhas 977 a 986:
977:         *-- Get_valo do legado: TmpSubN.Valos (valor do subnivel)
978:         THIS.AddObject("txt_4c_Valo", "TextBox")
979:         WITH THIS.txt_4c_Valo
980:             .Top               = 665
981:             .Left              = 325
982:             .Width             = 126
983:             .Height            = 23
984:             .FontName          = "Courier New"
985:             .FontSize          = 8
986:             .BorderStyle       = 1

*-- Linhas 1003 a 1012:
1003:         *-- a semantica do legado)
1004:         THIS.AddObject("txt_4c_Items", "TextBox")
1005:         WITH THIS.txt_4c_Items
1006:             .Top               = 665
1007:             .Left              = 784
1008:             .Width             = 187
1009:             .Height            = 23
1010:             .FontName          = "Courier New"
1011:             .FontSize          = 8
1012:             .BorderStyle       = 1

*-- Linhas 1034 a 1043:
1034:     PROTECTED PROCEDURE ConfigurarImagemProduto()
1035:         THIS.AddObject("img_4c_FigJpg", "Image")
1036:         WITH THIS.img_4c_FigJpg
1037:             .Top     = 105
1038:             .Left    = 672
1039:             .Width   = 318
1040:             .Height  = 225
1041:             .Stretch = 1
1042:             .Visible = .F.
1043:         ENDWITH

*-- Linhas 1114 a 1129:
1114:                         .Column7.Width = 60
1115:                         .Column8.Width = 150
1116: 
1117:                         .Column1.Header1.Caption = "Emp"
1118:                         .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1119:                         .Column3.Header1.Caption = "C" + CHR(243) + "digo"
1120:                         .Column4.Header1.Caption = "Data"
1121:                         .Column5.Header1.Caption = "Documento"
1122:                         .Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
1123:                         .Column7.Header1.Caption = "Prz. Entrega"
1124:                         .Column8.Header1.Caption = "Status"
1125: 
1126:                         .Refresh()
1127:                     ENDWITH
1128: 
1129:                     *-- Legado: o proprio bind da grade dispara AfterRowColChange

*-- Linhas 1185 a 1193:
1185:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorLista
1186: 
1187:         IF USED(loc_cCursor) AND !EOF(loc_cCursor)
1188:             THIS.cmd_4c_BtnOficina.Visible = ;
1189:                 !EMPTY(TratarNulo(EVALUATE(loc_cCursor + ".Nops"), 0))
1190:         ENDIF
1191:     ENDPROC
1192: 
1193:     *==========================================================================

*-- Linhas 1309 a 1326:
1309:             .Column9.Width           = 100
1310:             .Column10.Width          = 45
1311: 
1312:             .Column1.Header1.Caption  = "Produto"
1313:             .Column2.Header1.Caption  = "Fator"
1314:             .Column3.Header1.Caption  = "Op"
1315:             .Column4.Header1.Caption  = "Qtd."
1316:             .Column5.Header1.Caption  = "Peso (gr)"
1317:             .Column6.Header1.Caption  = "Valor"
1318:             .Column7.Header1.Caption  = "Moe"
1319:             .Column8.Header1.Caption  = "Total"
1320:             .Column9.Header1.Caption  = "Total Peso"
1321:             .Column10.Header1.Caption = ""
1322: 
1323:             .Refresh()
1324:         ENDWITH
1325: 
1326:         SELECT (loc_cCursor)


### BO (C:\4c\projeto\app\classes\SigMvSbnBO.prg):
*====================================================================
* SigMvSbnBO.prg
*
* Business Object para SigMvSbn (Subniveis de Movimento)
* Form OPERACIONAL: exibe os subniveis (SigMvPec/SigOpDev + SigMvCab)
* de uma operacao/movimento especifico, e os itens (SigMvItn) do
* subnivel selecionado, alem da imagem/descricao do produto (SigCdPro).
*
* Tabelas envolvidas: SigMvPec, SigOpDev, SigMvCab, SigCdOpe, SigStats,
*                      SigMvItn, SigCdPro, SigCdGrp, SigCdEmp, SigCdPam,
*                      SigCdOpd
*====================================================================

DEFINE CLASS SigMvSbnBO AS BusinessBase

	*-- Propriedades da entidade (parametros recebidos do form pai)
	this_cEmps = ""                && Empresa (SigMvCab.Emps / lpEmps)
	this_cDopes = ""                && Codigo da operacao (SigMvCab.Dopes / lpDopes)
	this_nNumes = 0                 && Numero do movimento (SigMvCab.Numes / lpNumes)
	this_cCursorOrigem = ""         && Nome do cursor de origem recebido do form pai (lpCursor)

	*-- Propriedades derivadas/calculadas
	this_cCaption = ""              && Titulo montado: "Subniveis - <Dopes> ( <Numes> )"
	this_cDescricaoOperacao = ""    && Descricao da operacao (SigCdOpe.nDopes / crXOpe)
	this_nCodigoBusca = 0           && Codigo calculado: (Dopes numerico * 1000000) + Numes
	this_lAcOficina = .F.           && Indica se o usuario tem acesso ao botao Oficina (fChecaAcesso OPPEND)
	this_lOcultaPrs = .F.           && Indica se a grade fwGrade deve ficar oculta (fChecaAcesso OCULTAPRS)

	*-- Propriedades do subnivel selecionado na grade principal (TmpSubN)
	this_nOrdes = 0                 && Ordem do subnivel (TmpSubN.Ordes)
	this_dDatas = {}                && Data do movimento do subnivel (TmpSubN.Datas)
	this_cNotas = ""                && Numero da nota/documento (TmpSubN.Notas)
	this_cDescricaoProduto = ""     && Descricao do produto exibida (Get_descr)
	this_nValorTotal = 0            && Valor total do subnivel selecionado (Get_valo / TmpSubN.Valos)
	this_nValorInicial = 0          && Valor inicial do subnivel selecionado (Get_items / TmpSubN.ValInis)
	this_cUsuars = ""               && Usuario responsavel pelo subnivel (TmpSubN.Usuars)
	this_nNops = 0                  && Numero da ordem de producao vinculada (TmpSubN.Nops)
	this_dPrazoEnts = {}            && Prazo de entrega do subnivel (TmpSubN.PrazoEnts)
	this_cPstatus = ""              && Codigo do status do subnivel (TmpSubN.pstatus)
	this_cDescStatus = ""           && Descricao do status (TmpSubN.Descs / SigStats.descs)

	*-- Nomes dos cursores que este BO popula/consome (mantidos como
	*-- propriedade para o Form referenciar sem repetir literais)
	this_cCursorLista = "cursor_4c_Subniveis"    && Grid principal (equivalente a TmpSubN do legado)
	this_cCursorItens = "cursor_4c_Itens"        && Grid de itens do subnivel selecionado (crTpmMvItnSubn)
	this_cCursorProduto = "cursor_4c_Produto"    && Dados/imagem do produto exibido (crTmpPro / crTPro)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela = "SigMvCab"
		THIS.this_cCampoChave = "Numes"

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia TODAS as colunas do registro corrente do
	* cursor de listagem (cursor_4c_Subniveis, equivalente ao TmpSubN do
	* legado) para as propriedades this_* do subnivel selecionado.
	*   par_cAliasCursor - alias a ler; se omitido usa this_cCursorLista
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_cAlias, loc_lSucesso
		loc_lSucesso = .F.

		loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
			par_cAliasCursor, THIS.this_cCursorLista)

		IF !USED(loc_cAlias)
			THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto"
		ELSE
			SELECT (loc_cAlias)

			IF EOF() OR BOF()
				THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " registro corrente em " + loc_cAlias
			ELSE
				THIS.this_nOrdes        = TratarNulo(Ordes, 0)
				THIS.this_cEmps         = TratarNulo(Emps, "")
				THIS.this_cDopes        = TratarNulo(Dopes, "")
				THIS.this_nNumes        = TratarNulo(Numes, 0)
				THIS.this_dDatas        = TratarNulo(Datas, {})
				THIS.this_cNotas        = TratarNulo(Notas, "")
				THIS.this_nValorTotal   = TratarNulo(Valos, 0)
				THIS.this_nValorInicial = TratarNulo(ValInis, 0)
				THIS.this_cUsuars       = TratarNulo(Usuars, "")
				THIS.this_nNops         = TratarNulo(Nops, 0)
				THIS.this_dPrazoEnts    = TratarNulo(PrazoEnts, {})
				THIS.this_cPstatus      = TratarNulo(pstatus, "")
				THIS.this_cDescStatus   = TratarNulo(Descs, "")

				loc_lSucesso = .T.
			ENDIF
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Chave logica do subnivel corrente, equivalente
	* ao EmpDopNums usado no legado (Emps + Dopes + Numes com 6 digitos)
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)
	ENDPROC

	*====================================================================
	* MontarChaveEmpDopNums - Monta a chave Emps+Dopes+Str(Numes,6) usada
	* pelo legado (lcEmpDopNums) para filtrar os itens (SigMvItn) do
	* subnivel selecionado. Publico porque o Form tambem precisa montar
	* essa chave a partir da linha corrente do grid antes de chamar
	* BuscarItensSubnivel().
	*====================================================================
	FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
		*-- A chave eh POSICIONAL e tem 29 caracteres FIXOS. O legado monta
		*-- "TmpSubN.Emps + TmpSubN.Dopes + Str(TmpSubN.Numes, 6)" SEM ALLTRIM:
		*-- como Emps eh char(3) e Dopes eh char(20), a concatenacao ja sai
		*-- com o padding das colunas - 3 + 20 + 6 = 29, exatamente a largura
		*-- de SigMvItn.EmpDopNums / SigMvCab.EmpDopNums (char(29) no
		*-- docs\schema.sql).
		*--
		*-- ALLTRIM aqui QUEBRA a busca em silencio: "001" + "MALOTE" + "     3"
		*-- da 15 caracteres ("001MALOTE     3") e nunca casa com o valor
		*-- gravado, que eh "001MALOTE                   3". O SQL roda sem
		*-- erro e devolve ZERO linhas, entao a grade de itens fica sempre
		*-- vazia e a descricao/imagem do produto nunca carregam.
		*--
		*-- PADR explicito (em vez de confiar no padding do cursor) porque
		*-- ObterChavePrimaria() chama este metodo com as properties
		*-- this_cEmps/this_cDopes, que o Init do Form guarda JA com ALLTRIM.
		RETURN PADR(TratarNulo(par_cEmps, ""), 3) + ;
		       PADR(TratarNulo(par_cDopes, ""), 20) + ;
		       STR(TratarNulo(par_nNumes, 0), 6)
	ENDFUNC

	*====================================================================
	* Inserir / Atualizar - SigMvSbn eh EXCLUSIVAMENTE uma tela de
	* CONSULTA (mostra subniveis e itens de um movimento ja gravado por
	* outras telas do sistema). O codigo fonte legado inteiro
	* (SigMvSbn_form_codigo_fonte.txt) foi conferido e NAO contem nenhum
	* comando de gravacao (Insert/Update/Delete/TableUpdate/Gather) - so
	* consultas (SqlExecute) e navegacao entre grades. Nao existe chave
	* nem tabela para gravar aqui, e inventar um INSERT/UPDATE violaria o
	* PILAR 2 (nunca gravar algo que o legado nao grava). Por isso os dois
	* metodos ficam sobrescritos apenas para deixar a mensagem explicita -
	* RegistrarAuditoria() nunca eh chamado porque nenhuma gravacao ocorre.
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		THIS.this_cMensagemErro = "SigMvSbn " + CHR(233) + " uma tela de consulta - n" + ;
			CHR(227) + "o grava registros."
		RETURN .F.
	ENDPROC

	PROTECTED PROCEDURE Atualizar()
		THIS.this_cMensagemErro = "SigMvSbn " + CHR(233) + " uma tela de consulta - n" + ;
			CHR(227) + "o grava registros."
		RETURN .F.
	ENDPROC

	*====================================================================
	* BuscarSubniveis - Popula this_cCursorLista com os subniveis do
	* movimento (SigMvPec + SigOpDev, unidos por Codigos), replicando o
	* Init() do legado. Tambem resolve this_nCodigoBusca, this_lAcOficina
	* e this_lOcultaPrs (usados pelo Form para montar a tela).
	*====================================================================
	FUNCTION BuscarSubniveis(par_cEmps, par_cDopes, par_nNumes)
		LOCAL loc_cSQL, loc_nResultado, loc_nCodigo, loc_cUsuario, loc_lSucesso

		THIS.this_cMensagemErro = ""
		loc_lSucesso = .F.

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel"
			RETURN .F.
		ENDIF

		TRY
			IF USED("cursor_4c_SbnOpeTmp")
				USE IN cursor_4c_SbnOpeTmp
			ENDIF

			loc_cSQL = "SELECT nDopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SbnOpeTmp")

			IF loc_nResultado < 1
				THIS.this_cMensagemErro = "Favor reinicializar o processo. (SigCdOpe)"
			ELSE
				SELECT cursor_4c_SbnOpeTmp

				IF EOF()
					THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o " + ALLTRIM(par_cDopes) + ;
						" n" + CHR(227) + "o cadastrada em SigCdOpe."
				ELSE
					THIS.this_nCodigoBusca = (cursor_4c_SbnOpeTmp.nDopes * 1000000) + par_nNumes
					loc_nCodigo = THIS.this_nCodigoBusca

					loc_cUsuario = TratarNulo(gc_4c_UsuarioLogado, "")
					THIS.this_lAcOficina = fChecaAcesso(PADL(TRANSFORM(cursor_4c_SbnOpeTmp.nDopes), 8, "0"), "OPPEND")
					THIS.this_lOcultaPrs = (UPPER(ALLTRIM(loc_cUsuario)) <> "4CONTROL") AND ;
						fChecaAcesso(PADL(TRANSFORM(cursor_4c_SbnOpeTmp.nDopes), 8, "0"), "OCULTAPRS")

					loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, b.Datas, b.Notas, b.Valos, b.ValInis, b.Usuars, " + ;
						"b.Nops, b.Datars, c.Ordes, b.PrazoEnts, b.pstatus, ISNULL(d.descs, SPACE(20)) AS Descs " + ;
						"FROM SigMvPec a " + ;
						"JOIN SigMvCab b ON a.EmpDopnums = b.EmpDopNums " + ;
						"JOIN SigCdOpe c ON b.Dopes = c.Dopes " + ;
						"LEFT JOIN SigStats d ON b.pstatus = d.cods " + ;
						"WHERE a.Codigos = " + STR(loc_nCodigo, 10) + ;
						" AND a.EmpSubns = " + EscaparSQL(ALLTRIM(par_cEmps)) + " " + ;
						"UNION ALL " + ;
						"SELECT a.Emps, a.Dopes, a.Numes, b.Datas, b.Notas, b.Valos, b.ValInis, b.Usuars, " + ;
						"b.Nops, b.Datars, c.Ordes, b.PrazoEnts, b.pstatus, ISNULL(d.descs, SPACE(20)) AS Descs " + ;
						"FROM SigOpDev a " + ;
						"JOIN SigMvCab b ON a.EmpDopnums = b.EmpDopNums " + ;
						"JOIN SigCdOpe c ON b.Dopes = c.Dopes " + ;
						"LEFT JOIN SigStats d ON b.pstatus = d.cods " + ;
						"WHERE a.Codigos = " + STR(loc_nCodigo, 10) + " " + ;
						"ORDER BY b.Datars"

					IF USED("cursor_4c_SbnListaTmp")
						USE IN cursor_4c_SbnListaTmp
					ENDIF

					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SbnListaTmp")

					IF loc_nResultado < 1
						THIS.this_cMensagemErro = "Favor reinicializar o processo. (Subn" + CHR(237) + "veis)"
					ELSE
						IF RECCOUNT("cursor_4c_SbnListaTmp") = 0
							THIS.this_cMensagemErro = "Nenhum registro encontrado."
						ELSE
							IF USED(THIS.this_cCursorLista)
								USE IN (THIS.this_cCursorLista)
							ENDIF

							SELECT Ordes, Emps, Dopes, Numes, Datas, Notas, Valos, ValInis, Usuars, Nops, PrazoEnts, pstatus, Descs ;
								FROM cursor_4c_SbnListaTmp ;
								INTO CURSOR (THIS.this_cCursorLista) READWRITE

							SELECT (THIS.this_cCursorLista)
							REPLACE ALL PrazoEnts WITH {} FOR ISNULL(PrazoEnts)
							INDEX ON DTOS(Datas) + STR(Ordes, 4) + Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
							GO TOP

							loc_lSucesso = .T.
						ENDIF
					ENDIF
				ENDIF
			ENDIF

			IF USED("cursor_4c_SbnOpeTmp")
				USE IN cursor_4c_SbnOpeTmp
			ENDIF
			IF USED("cursor_4c_SbnListaTmp")
				USE IN cursor_4c_SbnListaTmp
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* BuscarItensSubnivel - Popula this_cCursorItens com os itens
	* (SigMvItn) do subnivel selecionado, replicando Grade.AfterRowColChange
	*   par_cEmpDopNums - chave montada por MontarChaveEmpDopNums()
	*====================================================================
	FUNCTION BuscarItensSubnivel(par_cEmpDopNums)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		THIS.this_cMensagemErro = ""
		loc_lSucesso = .F.

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel"
			RETURN .F.
		ENDIF

		TRY
			*-- SEM ALLTRIM: a chave eh posicional de 29 caracteres (ver
			*-- MontarChaveEmpDopNums). O legado tambem embute o valor cru
			*-- ("...EmpDopNums = '" + lcEmpDopNums + "'"). Trimar aqui seria
			*-- reintroduzir pela porta de tras o defeito que a chave acabou
			*-- de consertar caso o formato de Numes mude.
			loc_cSQL = "SELECT * FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

			IF USED("cursor_4c_ItnTmp")
				USE IN cursor_4c_ItnTmp
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnTmp")

			IF loc_nResultado < 1
				THIS.this_cMensagemErro = "Favor reinicializar o processo. (Itens do Subn" + CHR(237) + "vel)"
			ELSE
				IF USED(THIS.this_cCursorItens)
					USE IN (THIS.this_cCursorItens)
				ENDIF

				SELECT * FROM cursor_4c_ItnTmp INTO CURSOR (THIS.this_cCursorItens) READWRITE

				SELECT (THIS.this_cCursorItens)
				GO TOP

				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_ItnTmp")
				USE IN cursor_4c_ItnTmp
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* BuscarDadosProduto - Popula this_cCursorProduto com Cpros/FigJpgs/
	* Dpros/Cgrus/Dgrus (join SigCdPro+SigCdGrp), replicando a consulta
	* feita em Grade.AfterRowColChange apos carregar os itens do subnivel.
	* Tambem atualiza this_cDescricaoProduto (Get_descr).
	*====================================================================
	FUNCTION BuscarDadosProduto(par_cCpros)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		THIS.this_cMensagemErro = ""
		loc_lSucesso = .F.

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel"
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "SELECT a.Cpros, a.FigJpgs, a.dpros, a.Cgrus, b.Dgrus " + ;
				"FROM SigCdPro a, SigCdGrp b " + ;
				"WHERE a.Cpros = " + EscaparSQL(ALLTRIM(par_cCpros)) + " AND a.Cgrus = b.Cgrus"

			IF USED(THIS.this_cCursorProduto)
				USE IN (THIS.this_cCursorProduto)
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorProduto))

			IF loc_nResultado < 1
				THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Dados do Produto)"
			ELSE
				SELECT (THIS.this_cCursorProduto)
				GO TOP

				THIS.this_cDescricaoProduto = TratarNulo(dpros, "")

				loc_lSucesso = .T.
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* BuscarImagemProdutoPorCodigo - Versao enxuta (Cpros/FigJpgs/Dpros,
	* sem grupo), replicando fwgrade.AfterRowColChange (CursorQuery do
	* legado quando o usuario navega dentro da grade de itens).
	*====================================================================
	FUNCTION BuscarImagemProdutoPorCodigo(par_cCpros)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		THIS.this_cMensagemErro = ""
		loc_lSucesso = .F.

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel"
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "SELECT Cpros, FigJpgs, Dpros FROM SigCdPro WHERE Cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

			IF USED(THIS.this_cCursorProduto)
				USE IN (THIS.this_cCursorProduto)
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorProduto))

			IF loc_nResultado < 1
				THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crTPro)"
			ELSE
				SELECT (THIS.this_cCursorProduto)
				GO TOP

				THIS.this_cDescricaoProduto = TratarNulo(Dpros, "")

				loc_lSucesso = .T.
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ObterNumeroOS - Replica BtnOficina.Click: calcula o numero da OS
	* (lcNumps do legado) a partir de Empresa (SigCdEmp.NEmps), do
	* departamento de servicos (SigCdPam.DoppServs) e da sequencia da
	* operacao de servicos (SigCdOpd.nSeqs). Retorna 0 em caso de falha
	* (this_cMensagemErro fica preenchido); o Form so abre SigRePhi
	* quando o retorno for > 0.
	*====================================================================
	FUNCTION ObterNumeroOS(par_cEmps, par_cDopes, par_nNumes)
		LOCAL loc_cSQL, loc_nResultado, loc_nNEmps, loc_nSeqs, loc_cNEmps, loc_cSeqs, loc_cNumes, loc_nNumps, loc_lSucesso

		THIS.this_cMensagemErro = ""
		loc_lSucesso = .F.
		loc_nNumps = 0

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel"
			RETURN 0
		ENDIF

		TRY
			loc_cSQL = "SELECT NEmps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cEmps))

			IF USED("cursor_4c_SbnEmpTmp")
				USE IN cursor_4c_SbnEmpTmp
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SbnEmpTmp")

			IF loc_nResultado < 1 OR RECCOUNT("cursor_4c_SbnEmpTmp") = 0
				THIS.this_cMensagemErro = "Empresa " + ALLTRIM(par_cEmps) + " n" + CHR(227) + "o cadastrada em SigCdEmp."
			ELSE
				loc_nNEmps = cursor_4c_SbnEmpTmp.NEmps

				loc_cSQL = "SELECT DoppServs FROM SigCdPam"

				IF USED("cursor_4c_SbnPamTmp")
					USE IN cursor_4c_SbnPamTmp
				ENDIF

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SbnPamTmp")

				IF loc_nResultado < 1 OR RECCOUNT("cursor_4c_SbnPamTmp") = 0
					THIS.this_cMensagemErro = "Configura" + CHR(231) + CHR(227) + "o de Par" + CHR(226) + ;
						"metros do Sistema n" + CHR(227) + "o encontrada (SigCdPam)."
				ELSE
					loc_cSQL = "SELECT nSeqs FROM SigCdOpd WHERE Dopps = " + ;
						EscaparSQL(ALLTRIM(TratarNulo(cursor_4c_SbnPamTmp.DoppServs, "")))

					IF USED("cursor_4c_SbnOpdTmp")
						USE IN cursor_4c_SbnOpdTmp
					ENDIF

					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SbnOpdTmp")

					IF loc_nResultado < 1 OR RECCOUNT("cursor_4c_SbnOpdTmp") = 0
						THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de servi" + CHR(231) + ;
							"os n" + CHR(227) + "o cadastrada em SigCdOpd."
					ELSE
						loc_nSeqs = cursor_4c_SbnOpdTmp.nSeqs

						loc_cNEmps = ALLTRIM(STR(loc_nNEmps))
						loc_cSeqs  = ALLTRIM(STR(loc_nSeqs))
						loc_cNumes = PADL(ALLTRIM(STR(par_nNumes)), 6, "0")

						loc_nNumps = INT(VAL(loc_cNEmps + loc_cSeqs + loc_cNumes))

						loc_lSucesso = .T.
					ENDIF
				ENDIF
			ENDIF

			IF USED("cursor_4c_SbnEmpTmp")
				USE IN cursor_4c_SbnEmpTmp
			ENDIF
			IF USED("cursor_4c_SbnPamTmp")
				USE IN cursor_4c_SbnPamTmp
			ENDIF
			IF USED("cursor_4c_SbnOpdTmp")
				USE IN cursor_4c_SbnOpdTmp
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			loc_lSucesso = .F.
			loc_nNumps = 0
		ENDTRY

		RETURN loc_nNumps
	ENDFUNC

ENDDEFINE

